unit LMDSedColorSchemeDialog;
{$I LMDCmps.inc}

interface
                                 
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, LMDSedView, LMDSedDocument, LMDTypes, LMDStrings, LMDSedUtils,
  LMDXml, ExtCtrls, Buttons, ComCtrls;

type
  ELMDEditBadColorSchemeXml = class(Exception);

  TLMDSedColorSchemeDlg = class(TForm)
    Panel1: TPanel;
    DocHtml: TLMDEditDocument;
    Panel2: TPanel;
    Panel3: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    dlgColor: TColorDialog;
    DocPascal: TLMDEditDocument;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    gbTokens: TGroupBox;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    btnMinus: TSpeedButton;
    btnPlus: TSpeedButton;
    lsTokens: TListBox;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    gbExample: TGroupBox;
    Panel9: TPanel;
    Panel17: TPanel;
    Panel20: TPanel;
    Panel22: TPanel;
    cbExample: TComboBox;
    ViewExample: TLMDEditView;
    PageControl1: TPageControl;
    tsMainAttrs: TTabSheet;
    gbAttributes: TGroupBox;
    cbItalic: TCheckBox;
    cbBold: TCheckBox;
    cbUnderline: TCheckBox;
    cbStrikeout: TCheckBox;
    cbFontAttrsDefined: TCheckBox;
    gbColors: TGroupBox;
    lbBgColor: TLabel;
    lbColor: TLabel;
    cbBgColor: TComboBox;
    cbColor: TComboBox;
    tsCustomAttrs: TTabSheet;
    lbCustomName: TLabel;
    btnCustomPlus: TSpeedButton;
    btnCustomMinus: TSpeedButton;
    lbCustomValue: TLabel;
    lsCustomAttrs: TListBox;
    edCustomAttrValue: TEdit;
    Button3: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    procedure lsTokensClick(Sender: TObject);
    procedure cbBgColorDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure onAttrsClick(Sender: TObject);
    procedure cbFontAttrsDefinedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbBgColorClick(Sender: TObject);
    procedure cbExampleChange(Sender: TObject);
    procedure btnMinusClick(Sender: TObject);
    procedure btnPlusClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCustomMinusClick(Sender: TObject);
    procedure btnCustomPlusClick(Sender: TObject);
    procedure lsCustomAttrsClick(Sender: TObject);
    procedure edCustomAttrValueChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure lsTokensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lsCustomAttrsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FInEvent: Boolean;
    FDocWasEmpty: Boolean;
    FDoc: TLMDEditDocument;
    FCurrentScheme: ILMDXmlDocument;
    FSchemeRoot: ILMDXmlNode;
    FExamples: array of TLMDEditDocument;
    FSchemeName: TLMDString;
    FCustomAttrs: TLMDStringHashTable;

    function  CurrentToken: TLMDString;
    procedure LoadCurrentToken;
    procedure LoadCurrentCustomAttr;
    procedure SaveCurrentToken;
    procedure RefreshExamples;

    procedure UpdateStatus;

    function  ColorToStr(AColor: TColor; var ACustom: Boolean): TLMDString;

    procedure FillColors(ACombo: TComboBox);
    procedure CheckAndSelectColor(ACombo: TComboBox; ATransparent: Boolean;
                                  AColor: TColor);
    function  FindTokenNode(const AName: TLMDString): ILMDXmlNode;
    procedure RefreshTokens;

    procedure LoadCurrentScheme(ALines: TLMDStrings);
    procedure SaveCurrentScheme;

    procedure LMDSaveTokenXMLAttrs(const ANode: ILMDXmlNode;
                                   const Attrs: TLMDEditAttributes);
    function  ShowDoc(ADoc: TLMDEditDocument; const ASchemeName: TLMDString): Boolean;
  public
    { Public declarations }
  end;

function LMDEditExecColorSchemesDialog(ADoc: TLMDEditDocument;
                                       const ASchemeName: TLMDString): Boolean;

var
  LMDSedColorSchemeDlg: TLMDSedColorSchemeDlg;

implementation

uses LMDSedParser, LMDSedConst;

const
    DefaultColorNames: array[0..15] of TLMDString =
             ('Black', 'Maroon', 'Green', 'Olive', 'Navy',
              'Purple', 'Teal', 'Gray', 'Silver', 'Red', 'Lime',
              'Yellow', 'Blue', 'Fuchsia', 'Aqua', 'White');

    DefaultColors: array[0..15] of TColor =
             (clBlack, clMaroon, clGreen, clOlive, clNavy,
              clPurple, clTeal, clGray, clSilver, clRed, clLime,
              clYellow, clBlue, clFuchsia, clAqua, clWhite);

{$R *.dfm}

function LMDEditExecColorSchemesDialog(ADoc: TLMDEditDocument;
  const ASchemeName: TLMDString): Boolean;
var
  Dlg: TLMDSedColorSchemeDlg;
begin
  Dlg := TLMDSedColorSchemeDlg.Create(nil);
  try
    Result := Dlg.ShowDoc(ADoc, ASchemeName);
  finally
    Dlg.Free;
  end;
end;

{ TLMDSedColorSchemeDlg }

procedure TLMDSedColorSchemeDlg.RefreshExamples;
var
  i: Integer;
  Item: TLMDEditParserSchemeCollectionItem;
begin
  ViewExample.BeginUpdate;

  try
    for i := 0 to Length(FExamples) - 1 do
    begin
      FExamples[i].ColorSchemes.Clear;
      Item := FExamples[i].ColorSchemes.Add;
      Item.Scheme.Text := FCurrentScheme.XML;
      Item.Name := '1';
      FExamples[i].ActiveColorScheme := '1';
    end;
  finally
    ViewExample.Document := FExamples[cbExample.ItemIndex];

    ViewExample.EndUpdate;
  end;
end;

procedure TLMDSedColorSchemeDlg.RefreshTokens;
var
  i: Integer; Nodes: ILMDXmlNodeList;
  Node: ILMDXmlNode;
  Name: TLMDString; Attrs: TLMDEditAttributes;
begin
  lsTokens.Items.BeginUpdate;
  try
    lsTokens.Clear;
    Nodes := FSchemeRoot.SelectNodes('Token');

    for i := 0 to Nodes.Count - 1 do
    begin
      Attrs.CustomAttributes := nil;
      Attrs.AttributesSet := [];

      Node := Nodes[i];
      LMDDecodeTokenXML(Node, Attrs, Name);

      if asCustomAttributes in Attrs.AttributesSet  then
        Attrs.CustomAttributes.Free;

      lsTokens.Items.Add(Name);
    end;
  finally
    lsTokens.Items.EndUpdate;
  end;

  UpdateStatus;
end;

procedure TLMDSedColorSchemeDlg.btnCustomMinusClick(Sender: TObject);
var
  OldIdx: Integer;
begin
  FInEvent := true;
  try
    OldIdx := lsCustomAttrs.ItemIndex;
    if OldIdx<>-1 then
    begin
      FCustomAttrs.Remove(lsCustomAttrs.Items[OldIdx]);
      lsCustomAttrs.Items.Delete(OldIdx);

      if lsTokens.Items.Count<=OldIdx then
        lsCustomAttrs.ItemIndex := OldIdx - 1
      else
        lsCustomAttrs.ItemIndex := OldIdx;

      LoadCurrentCustomAttr;
      SaveCurrentToken;      
    end;
  finally
    FInEvent := false;
  end;
end;

procedure TLMDSedColorSchemeDlg.btnCustomPlusClick(Sender: TObject);
var
  attrnm: string;
  i:      Integer;
begin
  attrnm := '';

  if InputQuery(SLMDSedColorSchemeAddCustomAttr, '', attrnm) then
  begin
    attrnm := LMDTrim(attrnm);

    if FCustomAttrs.HasKey(attrnm) then
      raise Exception.Create(SLMDSedColorSchemeDuplicateCustomAttr);

    FInEvent := true;
    try
      FCustomAttrs.Add(attrnm, '');
      i := lsCustomAttrs.Items.Add(attrnm);
      lsCustomAttrs.ItemIndex := i;

      LoadCurrentCustomAttr;
      SaveCurrentToken;
    finally
      FInEvent := false;
    end;
  end;
end;

procedure TLMDSedColorSchemeDlg.btnMinusClick(Sender: TObject);
var
  OldIdx: Integer;
  Node: ILMDXmlNode;
begin
  FInEvent := true;
  try
    OldIdx := lsTokens.ItemIndex;
    Node := FindTokenNode(lsTokens.Items[OldIdx]);
    FSchemeRoot.RemoveChild(Node);
    lsTokens.Items.Delete(OldIdx);
    if lsTokens.Items.Count<=OldIdx then
      lsTokens.ItemIndex := OldIdx - 1
    else
      lsTokens.ItemIndex := OldIdx;

    if lsTokens.Items.Count>0 then
      LoadCurrentToken;
    RefreshExamples;
    UpdateStatus;
  finally
    FInEvent := false;
  end;
end;

procedure TLMDSedColorSchemeDlg.btnPlusClick(Sender: TObject);
var
  Name: string;
  Node: ILMDXmlNode;
  Ok: Boolean;
begin
  Name := '';
  Ok := InputQuery(SLMDSedColorSchemeAddToken, '', Name);

  Name := LMDTrim(Name);
  if FindTokenNode(Name) <> nil then
    raise Exception.Create(SLMDSedColorSchemeDuplicateToken);

  if Ok then
  begin
    FInEvent := true;
    try
      Node := FCurrentScheme.CreateElement('Token');
      Node.SetAttr('name', Name);

      FSchemeRoot.AppendChild(Node);

      if lsTokens.Items.Count>0 then
      begin
        lsTokens.Items.Insert(lsTokens.ItemIndex, Name);
        lsTokens.Sorted := false;
        lsTokens.Sorted := true;        
        lsTokens.ItemIndex := lsTokens.Items.IndexOf(Name);
      end
      else
      begin
        lsTokens.Items.Add(Name);
        lsTokens.ItemIndex := 0;
      end;

      LoadCurrentToken;
      UpdateStatus;
    finally
      FInEvent := False;
    end;
  end;
end;

procedure TLMDSedColorSchemeDlg.Button3Click(Sender: TObject);
var
  lines: TLMDStrings;
begin
  OpenDialog1.FileName := '';

  if OpenDialog1.Execute then
  begin
    lines := TLMDMemoryStrings.Create;
    try
      lines.LoadFromFile(OpenDialog1.FileName);
      LoadCurrentScheme(lines);
    finally
      lines.Free;
    end;
  end;
end;

procedure TLMDSedColorSchemeDlg.Button4Click(Sender: TObject);
begin
  SaveDialog1.FileName := '';
  if SaveDialog1.Execute then
    FCurrentScheme.Save(SaveDialog1.FileName);
end;

procedure TLMDSedColorSchemeDlg.cbBgColorClick(Sender: TObject);
var
  Comb: TComboBox;
  i: Integer;
  Color: TLMDString;
  Clr: TColor;
  Custom: Boolean;
  S: string;
begin
  Comb := Sender as TComboBox;
  i := Comb.ItemIndex;
  if i=1 then
  begin
    StrToColorHtml(Comb.Items[i], Clr);

    dlgColor.CustomColors.Clear;
    S := IntToHex(Clr, 6);
    if S[1]='$' then
      Delete(S, 1, 1);

    dlgColor.CustomColors.Add('ColorA='+S);

    dlgColor.Color := Clr;
    if dlgColor.Execute then
    begin
      Color := ColorToStr(dlgColor.Color, Custom);
      Comb.Items[1] := Color;
      Comb.ItemIndex := 1;
    end;
  end;

  SaveCurrentToken;
  UpdateStatus;
end;

procedure TLMDSedColorSchemeDlg.cbBgColorDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  Margin = 2;
var
  Name: TLMDString;
  Color: TColor;
  Custom, Transparent: Boolean;
  Cnv: TCanvas;
begin
  Transparent := Index=0;
  Custom := Index=1;
  Name := (Control as TComboBox).Items[Index];

  Cnv := (Control as TComboBox).Canvas;

  if Custom then
  begin
    Name := SLMDSedColorSchemeCustomColor;
    StrToColorHtml((Control as TComboBox).Items[Index], Color);
  end
  else if Transparent then
    Color := Cnv.Brush.Color
  else
    StrToColorHtml(Name, Color);

  Cnv.FillRect(Rect);
  Cnv.TextOut(Rect.Left+Margin, Rect.Top, Name);

  Cnv.Brush.Color := Color;

  Rect.Top := Rect.Top+1;
  Rect.Bottom := Rect.Bottom-1;
  Rect.Left := Rect.Right - (Rect.Bottom-Rect.Top);
  Rect.Right := Rect.Right - 1;

  Cnv.Pen.Color := clBlack;
  Cnv.Rectangle(Rect);

  Inc(Rect.Left);
  Dec(Rect.Right);
  Inc(Rect.Top);
  Dec(Rect.Bottom);

  Cnv.FillRect(Rect);
end;

procedure TLMDSedColorSchemeDlg.onAttrsClick(Sender: TObject);
begin
  if FInEvent then
    Exit;

  FInEvent := true;
  try
    if not cbFontAttrsDefined.Checked then
    begin
      cbFontAttrsDefined.Checked := true;

      if Sender<>cbItalic then
        cbItalic.State := cbUnchecked;

      if Sender<>cbBold then
        cbBold.State := cbUnchecked;

      if Sender<>cbUnderline then
        cbUnderline.State := cbUnchecked;

      if Sender<>cbStrikeout then
        cbStrikeout.State := cbUnchecked;
    end;

    SaveCurrentToken;
  finally
    FInEvent := false;
  end;
  UpdateStatus;
end;

procedure TLMDSedColorSchemeDlg.cbExampleChange(Sender: TObject);
begin
  RefreshExamples;
end;

procedure TLMDSedColorSchemeDlg.cbFontAttrsDefinedClick(Sender: TObject);
begin
  if FInEvent then
    Exit;

  FInEvent := true;
  try
    if cbFontAttrsDefined.Checked then
    begin
      cbItalic.State := cbUnchecked;
      cbBold.State := cbUnchecked;
      cbUnderline.State := cbUnchecked;
      cbStrikeout.State := cbUnchecked;
    end
    else
    begin
      cbItalic.State := cbGrayed;
      cbBold.State := cbGrayed;
      cbUnderline.State := cbGrayed;
      cbStrikeout.State := cbGrayed;
    end;

    SaveCurrentToken;

  finally
    FInEvent := false;
  end;

  UpdateStatus;  
end;

procedure TLMDSedColorSchemeDlg.CheckAndSelectColor(ACombo: TComboBox;
  ATransparent: Boolean; AColor: TColor);
var
  i: Integer;
  Name: TLMDString;
  Custom: Boolean;
begin
  ACombo.Items[1] := DefaultColorNames[0];

  if ATransparent then
    ACombo.ItemIndex := 0
  else
  begin
    Name := ColorToStr(AColor, Custom);

    if not Custom then
    begin
      i := 2;
      while cbColor.Items[i]<>Name do
        Inc(i);

      ACombo.ItemIndex := i;
    end
    else
    begin
      ACombo.Items[1] := Name;
      ACombo.ItemIndex := 1;
    end;
  end;
end;

function TLMDSedColorSchemeDlg.ColorToStr(AColor: TColor;
  var ACustom: Boolean): TLMDString;
var
  i: Integer;
begin
    Result := '';

  i := Low(DefaultColors);
  while i<=High(DefaultColors) do
  begin
    if AColor=DefaultColors[i] then
      Break;

    Inc(i);
  end;

  ACustom := i>High(DefaultColors);
  if not ACustom then
    Result := DefaultColorNames[i]
  else
    Result := ColorToStrHtml(AColor);
end;

function TLMDSedColorSchemeDlg.CurrentToken: TLMDString;
begin
  Result := lsTokens.Items[lsTokens.ItemIndex];
end;

procedure TLMDSedColorSchemeDlg.edCustomAttrValueChange(Sender: TObject);
var
  i: Integer;
  Key: TLMDString;
begin
  i := lsCustomAttrs.ItemIndex;
  if i<>-1 then
  begin
    Key := lsCustomAttrs.Items[i];
    FCustomAttrs.SetOrAdd(Key, LMDTrim(edCustomAttrValue.Text));
    
    SaveCurrentToken;
  end;
end;

procedure TLMDSedColorSchemeDlg.FillColors(ACombo: TComboBox);
var
  i: Integer;
begin
  try
    ACombo.Items.BeginUpdate;

    ACombo.Items.Add('Transparent');
    ACombo.Items.Add('Black');
    for i := Low(DefaultColorNames) to High(DefaultColorNames) do
      ACombo.Items.Add(DefaultColorNames[i]);
  finally
    ACombo.Items.EndUpdate;
  end;
end;

function TLMDSedColorSchemeDlg.FindTokenNode(
  const AName: TLMDString): ILMDXmlNode;
var
  i: Integer;
  Nodes: ILMDXmlNodeList;
begin
  Result := nil;
  Nodes := FSchemeRoot.SelectNodes('Token');

  for i := 0 to Nodes.Count - 1 do
    if Nodes.Item[i].GetAttr('name')=AName then
    begin
      Result := Nodes.Item[i];
      Exit;
    end;
end;

procedure TLMDSedColorSchemeDlg.FormCreate(Sender: TObject);
begin
  LMDGetDialogFont(Font);

  Caption := SLMDSedColorSchemeCaption;
  gbTokens.Caption := SLMDSedColorSchemeTokens;
  btnPlus.Hint := SLMDSedColorSchemeTokensPlusHint;
  btnMinus.Hint := SLMDSedColorSchemeTokensMinusHint;
  gbColors.Caption := SLMDSedColorSchemeColors;
  lbColor.Caption := SLMDSedColorSchemeColor;
  lbBgColor.Caption  := SLMDSedColorSchemeBgColor;
  gbAttributes.Caption := SLMDSedColorSchemeAttributes;
  cbItalic.Caption := SLMDSedColorSchemeItalic;
  cbBold.Caption := SLMDSedColorSchemeBold;
  cbUnderline.Caption := SLMDSedColorSchemeUnderline;
  cbStrikeout.Caption := SLMDSedColorSchemeStrikeout;
  cbFontAttrsDefined.Caption := SLMDSedColorSchemeFontAttributesDefined;
  gbExample.Caption := SLMDSedColorSchemeExample;
  btnCancel.Caption := SLMDSedColorSchemeCancel;
  btnOk.Caption := SLMDSedColorSchemeOk;
  tsMainAttrs.Caption := SLMDSedColorSchemeMainAttrs;
  tsCustomAttrs.Caption := SLMDSedColorSchemeCustomAttrs;
  lbCustomName.Caption := SLMDSedColorSchemeCustomAttrName;
  btnCustomMinus.Hint := SLMDSedColorSchemeRemoveCustomAttrHint;
  btnCustomPlus.Hint := SLMDSedColorSchemeRemoveCustomAttrHint;
  lbCustomValue.Caption := SLMDSedColorSchemeCustomAttrValue;
  btnMinus.Hint := SLMDSedColorSchemeRemoveTokenHint;
  btnPlus.Hint := SLMDSedColorSchemeAddTokenHint;

  cbExample.ItemIndex := 0;

  FInEvent := false;
  SetLength(FExamples, 2);
  FExamples[0] := DocPascal;
  FExamples[1] := DocHtml;

  FCustomAttrs := TLMDStringHashTable.Create;

  UpdateStatus;
end;

procedure TLMDSedColorSchemeDlg.FormDestroy(Sender: TObject);
begin
  FCustomAttrs.Free;
end;

procedure TLMDSedColorSchemeDlg.lsCustomAttrsClick(Sender: TObject);
begin
  LoadCurrentCustomAttr;
end;

procedure TLMDSedColorSchemeDlg.lsCustomAttrsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  idx:   Integer;
  name:  string;
  newnm: string;
  val:   TLMDString;
  nd:    TLMDStringHashNode;
begin
  if Key = VK_F2 then
  begin
    idx := lsCustomAttrs.ItemIndex;

    if idx <> -1 then
    begin
      name := lsCustomAttrs.Items[idx];
      nd   := FCustomAttrs.FindNode(name);

      newnm := name;
      if InputQuery('Rename custom attribute', '', newnm) then
      begin
        newnm := LMDTrim(newnm);

        if (FCustomAttrs.FindNode(newnm) <> nil) and
           (FCustomAttrs.FindNode(newnm) <> nd) then
          raise Exception.Create(SLMDSedColorSchemeDuplicateCustomAttr);

        FInEvent := True;
        try
          val := nd.Value;
          FCustomAttrs.Remove(nd.Key);

          lsCustomAttrs.Items[idx] := newnm;
          FCustomAttrs.SetOrAdd(newnm, val);

          LoadCurrentCustomAttr;
          SaveCurrentToken;
        finally
          FInEvent := False;
        end;
      end;
    end;
  end;
end;

procedure TLMDSedColorSchemeDlg.lsTokensClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := lsTokens.ItemIndex;
  if (lsTokens.Items.Count > 0) and (idx >= 0) then
    LoadCurrentToken;
end;

procedure TLMDSedColorSchemeDlg.lsTokensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  idx:   Integer;
  nd:    ILMDXmlNode;
  newnm: string;
begin
  if Key = VK_F2 then
  begin
    idx := lsTokens.ItemIndex;

    if (lsTokens.Items.Count > 0) and (idx >= 0) then
    begin
      nd    := FindTokenNode(CurrentToken);
      newnm := CurrentToken;

      if InputQuery('Rename Token', '', newnm) then
      begin
        newnm := LMDTrim(newnm);

        if (FindTokenNode(newnm) <> nil) and
           (FindTokenNode(newnm) <> nd) then
          raise Exception.Create(SLMDSedColorSchemeDuplicateToken);

        nd.SetAttr('name', newnm);

        lsTokens.Items[idx] := nd.GetAttr('name');
        RefreshExamples;
        UpdateStatus;
      end;
    end;
  end;
end;

procedure TLMDSedColorSchemeDlg.LMDSaveTokenXMLAttrs(const ANode: ILMDXmlNode;
  const Attrs: TLMDEditAttributes);
var
  S: TLMDString; Custom: Boolean;

  Iter: TLMDStringHashIterator;
  Hash: TLMDStringHashTable;

  Node, Node2: ILMDXmlNode;
begin
  if ANode.AttrExists('backgroundColor') then
    ANode.RemoveAttr('backgroundColor');

  if asBackgroundColor in Attrs.AttributesSet then
    ANode.SetAttr('backgroundColor', ColorToStr(Attrs.BackgroundColor, Custom));

  if ANode.AttrExists('textColor') then
    ANode.RemoveAttr('textColor');

  if asTextColor in Attrs.AttributesSet then
    ANode.SetAttr('textColor', ColorToStr(Attrs.TextColor, Custom));

  if ANode.AttrExists('fontStyle') then
    ANode.RemoveAttr('fontStyle');

  if asFontStyle in Attrs.AttributesSet then
  begin
    if fsItalic in Attrs.FontStyle then
      S := 'italic ';

    if fsBold in Attrs.FontStyle then
      S := S + 'bold ';

    if fsUnderline in Attrs.FontStyle then
      S := S + 'underline ';

    if fsStrikeOut in Attrs.FontStyle then
      S := S + 'strikeOut ';

    ANode.SetAttr('fontStyle', LMDTrim(S));
  end;

  Node := ANode.SelectSingleNode('CustomAttributes');
  if Node<>nil then
    ANode.RemoveChild(Node);

  if asCustomAttributes in Attrs.AttributesSet then
  begin
    Node := ANode.EnsureChild('CustomAttributes');

    Hash := Attrs.CustomAttributes;

    if Hash.IteratorMoveFirst(Iter) then
    begin
      repeat
        Node2 := Node.EnsureChild(Iter.CurrentNode.Key);
        Node2.Text := Iter.CurrentNode.Value;
      until not Hash.IteratorMoveNext(Iter);
    end;

    Attrs.CustomAttributes.Free;
  end;
end;

procedure TLMDSedColorSchemeDlg.LoadCurrentToken;
var
  nd:    ILMDXmlNode;
  attrs: TLMDEditAttributes;
  dummy: TLMDString;
  itr:   TLMDStringHashIterator;
  hash:  TLMDStringHashTable;
begin
  FInEvent := True;
  try
    nd := FindTokenNode(CurrentToken);

    attrs.AttributesSet := [];
    attrs.CustomAttributes := nil;
    LMDDecodeTokenXML(nd, attrs, dummy);

    CheckAndSelectColor(cbColor, not (asTextColor in attrs.AttributesSet),
                        attrs.TextColor);
    CheckAndSelectColor(cbBgColor, not (asBackgroundColor in attrs.AttributesSet),
                        attrs.BackgroundColor);

    if asFontStyle in attrs.AttributesSet then
    begin
      cbItalic.Checked := fsItalic in attrs.FontStyle;
      cbBold.Checked := fsBold in attrs.FontStyle;
      cbUnderline.Checked := fsUnderline in attrs.FontStyle;
      cbStrikeout.Checked := fsStrikeOut in attrs.FontStyle;
      cbFontAttrsDefined.Checked := true;
    end
    else
    begin
      cbItalic.State := cbGrayed;
      cbBold.State := cbGrayed;
      cbUnderline.State := cbGrayed;
      cbStrikeout.State := cbGrayed;
      cbFontAttrsDefined.Checked := false;
    end;

    ///Custom attrs
    FCustomAttrs.Clear;
    lsCustomAttrs.Clear;
    edCustomAttrValue.Text := '';

    if asCustomAttributes in attrs.AttributesSet then
    begin
      hash := attrs.CustomAttributes;
      Assert(hash <> nil);

      if hash.IteratorMoveFirst(itr) then
      begin
        repeat
          lsCustomAttrs.Items.Add(itr.CurrentNode.Key);
        until not hash.IteratorMoveNext(itr);
      end;
      lsCustomAttrs.Sorted    := true;
      lsCustomAttrs.ItemIndex := -1;

      FCustomAttrs.Assign(hash);
      attrs.CustomAttributes.Free;
    end;
  finally
    FInEvent := false;
  end;
end;

procedure TLMDSedColorSchemeDlg.LoadCurrentCustomAttr;
var
  val: TLMDString;
  idx: Integer;
begin
  idx := lsCustomAttrs.ItemIndex;
  if idx = -1 then
    val := ''
  else
    val := FCustomAttrs.Find(lsCustomAttrs.Items[idx]);
  edCustomAttrValue.Text := val;
end;

procedure TLMDSedColorSchemeDlg.LoadCurrentScheme(ALines: TLMDStrings);
const
  DefaultXml = '<?xml version="1.0" encoding="UTF-8"?>'+
               '<Attributes></Attributes>';
var
  xml: TLMDString;
begin
  xml          := ALines.Text;
  FDocWasEmpty := (LMDTrim(xml) = '');

  if FDocWasEmpty then
    xml := DefaultXml;

  try
    FCurrentScheme := LMDLoadXmlDocumentFromXML(xml);
    FSchemeRoot    := FCurrentScheme.SelectSingleNode('Attributes');

    RefreshTokens;
    RefreshExamples;

    FillColors(cbColor);
    FillColors(cbBgColor);

    if lsTokens.Items.Count>0 then
    begin
      lsTokens.ItemIndex := 0;
      LoadCurrentToken;
    end
    else
      lsTokens.ItemIndex := -1;

    UpdateStatus;
  except
    on E: Exception do
      raise ELMDEditBadColorSchemeXml.CreateFmt(SLMDSedColorSchemeLoadError,
                                                [FSchemeName, E.Message]);
  end;
end;

procedure TLMDSedColorSchemeDlg.SaveCurrentScheme;
var
  item: TLMDEditParserSchemeCollectionItem;
begin
  item := FDoc.ColorSchemes.FindItem(FSchemeName);
  Assert(item<>nil);

  if (lsTokens.Items.Count>0) then
    item.Scheme.Text := FCurrentScheme.XML
  else if FDocWasEmpty then
    item.Scheme.Text := ''
  else
    item.Scheme.Text := FCurrentScheme.XML;
end;

procedure TLMDSedColorSchemeDlg.SaveCurrentToken;
var
  Node: ILMDXmlNode;
  Attrs: TLMDEditAttributes;
begin
  Node := FindTokenNode(CurrentToken);
  Attrs.AttributesSet := [];

  if cbFontAttrsDefined.Checked then
  begin
    Include(Attrs.AttributesSet, asFontStyle);

    Attrs.FontStyle := [];

    if cbItalic.Checked then
      Include(Attrs.FontStyle, fsItalic);

    if cbBold.Checked then
      Include(Attrs.FontStyle, fsBold);

    if cbUnderline.Checked then
      Include(Attrs.FontStyle, fsUnderline);

    if cbStrikeout.Checked then
      Include(Attrs.FontStyle, fsStrikeOut);
  end;

  if cbColor.ItemIndex <> 0 then
  begin
    Include(Attrs.AttributesSet, asTextColor);
    StrToColorHtml(cbColor.Items[cbColor.ItemIndex], Attrs.TextColor);
  end;

  if cbBgColor.ItemIndex <> 0 then
  begin
    Include(Attrs.AttributesSet, asBackgroundColor);
    StrToColorHtml(cbBgColor.Items[cbBgColor.ItemIndex], Attrs.BackgroundColor);
  end;

  if FCustomAttrs.Count <> 0 then
  begin
    Include(Attrs.AttributesSet, asCustomAttributes);
    Attrs.CustomAttributes := FCustomAttrs.Clone;
  end;

  LMDSaveTokenXMLAttrs(Node, Attrs);
  RefreshExamples;
end;

function TLMDSedColorSchemeDlg.ShowDoc(ADoc: TLMDEditDocument;
  const ASchemeName: TLMDString): Boolean;
var
  item: TLMDEditParserSchemeCollectionItem;
begin
  Assert((ADoc <> nil) and (ASchemeName <> ''));

  FDoc        := ADoc;
  FSchemeName := ASchemeName;
  item        := FDoc.ColorSchemes.FindItem(FSchemeName);

  if item = nil then
    raise ELMDColorSchemeLoadError.CreateFmt(SLMDSedColorSchemeNotFound,
                                             [ASchemeName]);
  if Name <> '' then
    LoadCurrentScheme(item.Scheme);
  UpdateStatus;

  ShowModal;
  Result := (ModalResult = mrOk);

  if Result then
    SaveCurrentScheme;
end;

procedure TLMDSedColorSchemeDlg.UpdateStatus;
var
  HaveTokens: Boolean;
begin
  HaveTokens := lsTokens.Items.Count>0;

  btnMinus.Enabled := HaveTokens;

  cbColor.Enabled := HaveTokens;
  cbBgColor.Enabled := HaveTokens;
  cbItalic.Enabled := HaveTokens;
  cbBold.Enabled := HaveTokens;
  cbUnderline.Enabled := HaveTokens;
  cbStrikeout.Enabled := HaveTokens;
  cbFontAttrsDefined.Enabled := HaveTokens;
  if not HaveTokens then
  begin
    cbColor.ItemIndex := -1;
    cbBgColor.ItemIndex := -1;

    cbItalic.Checked := false;
    cbBold.Checked := false;
    cbUnderline.Checked := false;
    cbStrikeout.Checked := false;
    cbFontAttrsDefined.Checked := false;
  end;
end;

end.
