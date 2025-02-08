unit pLMDElXItemCol;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

pLMDElXItemCol unit
-------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Math, Buttons, ExtCtrls, ElXTree, TypInfo,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  ComCtrls, ElTreeInplaceEditors, ElPanel, ElGroupBox,
  ElXPThemedControl, ElBtnCtl, ElCheckCtl, ElComponent, ElTreeAdvEdit,
  ElEdits, ElBtnEdit, ElCombos, ElClrCmb, ElHeader, ElCheckItemGrp, LMDGraph,
  ElCLabel, ElLabel, ElPopBtn, ElPgCtl, ElCGControl, Dialogs,
  ElTreeStdEditors;

type
  TXItemColDlg = class(TForm)
    ElTreeInplaceAdvancedEdit1: TElTreeInplaceAdvancedEdit;
    OKBtn: TElPopupButton;
    CancelBtn: TElPopupButton;
    ElPageControl1: TElPageControl;
    ElTabSheet1: TElTabSheet;
    ElTabSheet2: TElTabSheet;
    ElTabSheet3: TElTabSheet;
    ElTabSheet4: TElTabSheet;
    HintEdit: TElMemo;
    TextEdit: TElMemo;
    CheckBoxGB: TElGroupBox;
    CBEnabledCB: TElCheckBox;
    CBTypeCombo: TElComboBox;
    CBStateCombo: TElComboBox;
    OwnStyleGB: TElGroupBox;
    ColorsGB: TElGroupBox;
    ColorCombo: TElColorCombo;
    BkColorCombo: TElColorCombo;
    RowBkColorCombo: TElColorCombo;
    StylesGB: TElGroupBox;
    ItCB: TElCheckBox;
    ULCB: TElCheckBox;
    BoldCB: TElCheckBox;
    StrikeCB: TElCheckBox;
    StrikeLineColorCB: TElColorCombo;
    ElGroupBox2: TElGroupBox;
    BorderStyleCombo: TElComboBox;
    BorderSpaceColorCB: TElColorCombo;
    BorderSidesCG: TElCheckGroup;
    StrikeOutCB: TElCheckBox;
    UseBkColorsCB: TElCheckBox;
    CellStyleGB: TElGroupBox;
    ElGroupBox5: TElGroupBox;
    CellItCB: TElCheckBox;
    CellULCB: TElCheckBox;
    CellBoldCB: TElCheckBox;
    CellStrikeCB: TElCheckBox;
    CellColorsGB: TElGroupBox;
    CellColorCombo: TElColorCombo;
    CellBkColorCombo: TElColorCombo;
    CellRowBkColorCombo: TElColorCombo;
    CellStrikeLineColorCB: TElColorCombo;
    ElGroupBox3: TElGroupBox;
    CellBorderStyleCombo: TElComboBox;
    CellBorderSpaceColorCB: TElColorCombo;
    CellBorderSidesCG: TElCheckGroup;
    CellUseBkColorsCB: TElCheckBox;
    CellStrikeOutCB: TElCheckBox;
    CellTree: TElXTree;
    IndentEdit: TElEdit;
    HeightEdit: TElEdit;
    TagEdit: TElEdit;
    OwnHeightCB: TElCheckBox;
    IndentAdjustCB: TElCheckBox;
    WholeLineCB: TElCheckBox;
    SuppressLinesCB: TElCheckBox;
    SuppressButtonsCB: TElCheckBox;
    ForcedBtnsCB: TElCheckBox;
    AllowEditCB: TElCheckBox;
    HorZlineCB: TElCheckBox;
    WordWrapCB: TElCheckBox;
    MultilineCB: TElCheckBox;
    HintHTMLCB: TElCheckBox;
    HtmlCB: TElCheckBox;
    HiddenCB: TElCheckBox;
    EnabledCB: TElCheckBox;
    ElGroupBox1: TElGroupBox;
    Label6: TElLabel;
    Label7: TElLabel;
    Label16: TElLabel;
    IndexEdit: TElEdit;
    StIndexEdit: TElEdit;
    OvIndexEdit: TElEdit;
    Index2Edit: TElEdit;
    StIndex2Edit: TElEdit;
    OvIndex2Edit: TElEdit;
    Label14: TElLabel;
    Label13: TElLabel;
    Label2: TElLabel;
    Label8: TElLabel;
    Label9: TElLabel;
    Label4: TElLabel;
    Label5: TElLabel;
    Label12: TElLabel;
    Label15: TElLabel;
    Label19: TElLabel;
    Label1: TElLabel;
    Label17: TElLabel;
    Label18: TElLabel;
    Label3: TElLabel;
    Label20: TElLabel;
    Label10: TElLabel;
    Label11: TElLabel;
    FontBtn: TElGraphicButton;
    FontDialog1: TFontDialog;
    procedure FormCloseQuery(Sender : TObject; var CanClose : Boolean);
    procedure OKBtnClick(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure CancelBtnClick(Sender : TObject);
    procedure CBTypeComboChange(Sender : TObject);
    procedure StrikeOutCBClick(Sender: TObject);
    procedure OwnHeightCBClick(Sender: TObject);
    procedure IndentAdjustCBClick(Sender: TObject);
    procedure ColorsGBClick(Sender: TObject);
    procedure OwnStyleGBClick(Sender: TObject);
    procedure CheckBoxGBClick(Sender: TObject);
    procedure CellColorsGBClick(Sender: TObject);
    procedure CellTreeItemSelectedChange(Sender: TObject;
      Item: TElXTreeItem);
    procedure ElTreeInplaceAdvancedEdit1BeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure TextEditChange(Sender: TObject);
    procedure CellStrikeOutCBClick(Sender: TObject);
    procedure CellTreeInplaceEditorNeeded(Sender: TObject;
      Item: TElXTreeItem; SectionIndex: Integer;
      SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor);
    procedure FontBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Item : TElXTreeItem;
    ByCancel : boolean;
    MainTreeColumn: Integer;
    procedure SetData;
    procedure GetData;
    procedure SetCellStyleData(AIndex: integer);
    procedure GetCellStyleData(AIndex: integer);
    procedure CellStyleClick(Sender: TObject);
  end;

var
  XItemColDlg : TXItemColDlg;

implementation

uses ElXTreeCell;

{$R *.DFM}

procedure TXItemColDlg.SetData;
var
  i : integer;
begin
  TextEdit.Font.Assign(TElXTree(Item.Owner).Font);
  HintEdit.Font.Assign(TextEdit.Font);

  OwnStyleGB.CheckBoxChecked := Item.UseOwnStyle;
  if Item.UseOwnStyle then
  begin
    colorCombo.SelectedColor := Item.Style.TextColor;
    BkColorCombo.SelectedColor := Item.Style.TextBackGroundColor;
    RowBkColorCombo.SelectedColor := Item.Style.CellBackGroundColor;

    ColorsGB.CheckBoxChecked := Item.Style.ParentColors;
//    ColorsGBClick(self);
    UseBkColorsCB.Checked := Item.Style.UseBackGroundColor;
    ItCB.Checked := Item.Style.Italic;
    ULCB.Checked := Item.Style.Underlined;
    BoldCB.Checked := Item.Style.Bold;
    StrikeCB.Checked := Item.Style.Strikeout;

    StrikeOutCB.Checked := Item.Style.StrikedOutLine;
    StrikeLineColorCB.Enabled := StrikeOutCB.Checked;
    StrikeLineColorCB.SelectedColor := Item.Style.StrikedLineColor;
    BorderStyleCombo.ItemIndex := Ord(Item.Style.BorderStyle);
    BorderSpaceColorCB.SelectedColor := Item.Style.BorderSpaceColor;
    if (ebsLeft in Item.Style.BorderSides) then
      BorderSidesCG.Checked[0] := True;
    if (ebsRight in Item.Style.BorderSides) then
      BorderSidesCG.Checked[1] := True;
    if (ebsTop in Item.Style.BorderSides) then
      BorderSidesCG.Checked[2] := True;
    if (ebsBottom in Item.Style.BorderSides) then
      BorderSidesCG.Checked[3] := True;
  end;
  OwnStyleGBClick(Self);
  TextEdit.Text := Item.Text;
  HintEdit.Text := Item.Hint;

  CellTree.Items.Clear;
  for i := 0 to Item.Cells.Count -1 do
  begin
    if Item.Cells[i].Text = '' then
      CellTree.Items.Add(nil,'Untitled')
    else
      CellTree.Items.Add(nil,Item.Cells[i].Text);
    CellTree.Items[i].UseOwnStyle := True;
    CellTree.Items[i].Style.CellBackGroundColor := clBtnFace;

    CellTree.Items[i].Cells[1].UseOwnStyle := True;
    CellTree.Items[i].Cells[1].Style.Control := TElXCellCheckBox.Create;
    TElXCellCheckBox(CellTree.Items[i].Cells[1].Style.Control).Alignment := taCenter;
    TElXCellCheckBox(CellTree.Items[i].Cells[1].Style.Control).Checked := Item.Cells[i].UserText;
    CellTree.Items[i].Cells[2].UseOwnStyle := True;
    CellTree.Items[i].Cells[2].Style.Control := TElXCellCheckBox.Create;
    TElXCellCheckBox(CellTree.Items[i].Cells[2].Style.Control).Alignment := taCenter;
    CellTree.Items[i].Cells[2].Style.Control.OnClick := CellStyleClick;
    TElXCellCheckBox(CellTree.Items[i].Cells[2].Style.Control).Checked := Item.Cells[i].UseOwnStyle;
    if i = MainTreeColumn then
      CellTree.Items[i].Style.TextColor := clBtnShadow;
  end;

  ForcedBtnsCB.Checked := Item.ForceButtons;
  IndexEdit.Text := IntToStr(Item.ImageIndex);
  StIndexEdit.Text := IntToStr(Item.StateImageIndex);
  Index2Edit.Text := IntToStr(Item.ImageIndex2);
  StIndex2Edit.Text := IntToStr(Item.StateImageIndex2);
  OvIndexEdit.Text := IntToStr(Item.OverlayIndex);
  OvIndex2Edit.Text := IntToStr(Item.OverlayIndex2);
  CBStateCombo.ItemIndex := Integer(Item.CheckBoxState);
  CBTypeCombo.ItemIndex := Integer(Item.CheckBoxType);
  CBEnabledCB.Checked := Item.CheckBoxEnabled;
  CheckBoxGB.CheckBoxChecked := Item.ShowCheckBox;
  CheckBoxGBClick(Self);
  HiddenCB.Checked := Item.Hidden;

  EnabledCB.Checked := Item.Enabled;
  HTMLCB.Checked := Item.IsHTML;
  HintHTMLCB.Checked := Item.HintIsHTML;
  MultilineCB.Checked := Item.Multiline;
  WordWrapCB.Checked := Item.WordWrap;
  OwnHeightCB.Checked := not Item.OwnerHeight;
  HeightEdit.Enabled := OwnHeightCB.Checked;
  HeightEdit.Text := IntToStr(Item.Height);

  WholeLineCB.Checked := Item.WholeLine;
  HorzLineCB.Checked := Item.DrawHLine;
  AllowEditCB.Checked := Item.AllowEdit;
  SuppressButtonsCB.Checked :=Item.SuppressButtons;
  SuppressLinesCB.Checked :=Item.SuppressLines;

  IndentAdjustCB.Checked := Item.IndentAdjust <> 0;
  IndentEdit.Enabled := IndentAdjustCB.Checked;
  IndentEdit.Text := IntToStr(Item.IndentAdjust);

  TagEdit.Text := IntToStr(Item.Tag);
end;

procedure TXItemColDlg.GetData;
var
  I, J : integer;
  S : string;
  ABorderSides: TLMDBorderSides;
begin
  Item.UseOwnStyle := OwnStyleGB.CheckBoxChecked;
  if Item.UseOwnStyle then
  begin
    Item.Style.ParentColors := ColorsGB.CheckBoxChecked;
    if not ColorsGB.CheckBoxChecked then
    begin
      IdentToColor(ColorCombo.Text, i);
      Item.Style.TextColor := TColor(i);
      IdentToColor(BkColorCombo.Text, i);
      Item.Style.TextBackGroundColor := TColor(i);
      IdentToColor(RowBkColorCombo.Text, i);
      Item.Style.CellBackGroundColor := TColor(i);
      Item.Style.UseBackGroundColor := UseBkColorsCB.Checked;
    end;
    Item.Style.Italic := ItCB.Checked;
    Item.Style.Underlined := ULCB.Checked;
    Item.Style.Bold := BoldCB.Checked;
    Item.Style.Strikeout := StrikeCB.Checked;

    Item.Style.StrikedOutLine := StrikeOutCB.Checked;
    IdentToColor(StrikeLineColorCB.Text, i);
    if Item.Style.StrikedOutLine then
      Item.Style.StrikedLineColor := TColor(i);
    Item.Style.BorderStyle := TElItemBorderStyle(Max(BorderStyleCombo.ItemIndex, 0));
    Item.Style.BorderSpaceColor := BorderSpaceColorCB.SelectedColor;

    ABorderSides := [];
    if BorderSidesCG.Checked[0] then
      Include(ABorderSides, ebsLeft);
    if BorderSidesCG.Checked[1] then
      Include(ABorderSides, ebsRight);
    if BorderSidesCG.Checked[2] then
      Include(ABorderSides, ebsTop);
    if BorderSidesCG.Checked[3] then
      Include(ABorderSides, ebsBottom);
    Item.Style.BorderSides := ABorderSides;  
  end;
  Item.Text := TextEdit.Text;
  Item.Hint := HintEdit.Text;

  j := Item.Cells.Count - CellTree.Items.Count - 1;
  for i := 0 to  j do
  begin
    Item.Cells.Delete(Item.Cells.Count - 1);
  end;

  for i := 0 to CellTree.Items.Count -1 do
  begin
    if Item.Cells.Count <= i then
      Item.Cells.Add;
    if CellTree.Items[i].Cells[0].Text = 'Untitled' then
      Item.Cells[i].Text := ''
    else
      Item.Cells[i].Text := CellTree.Items[i].Cells[0].Text;
  end;

  Item.ForceButtons := ForcedBtnsCB.Checked;
  S := IndexEdit.Text;
  val(S, I, J);
  if J = 0 then Item.ImageIndex := I;
  S := StIndexEdit.Text;
  val(S, I, J);
  if J = 0 then Item.StateImageIndex := I;
  S := OvIndexEdit.Text;
  val(S, I, J);
  if J = 0 then Item.OverlayIndex := I;

  S := Index2Edit.Text;
  val(S, I, J);
  if J = 0 then Item.ImageIndex2 := I;
  S := StIndex2Edit.Text;
  val(S, I, J);
  if J = 0 then Item.StateImageIndex2 := I;
  S := OvIndex2Edit.Text;
  val(S, I, J);
  if J = 0 then Item.OverlayIndex2 := I;

  Item.CheckBoxState := TCheckBoxState(CBStateCombo.ItemIndex);
  Item.CheckBoxType := TElCheckBoxType(CBTypeCombo.ItemIndex);
  Item.ShowCheckBox := CheckBoxGB.CheckBoxChecked;
  Item.CheckBoxEnabled := CBEnabledCB.Checked;
  Item.Hidden := HiddenCB.Checked;
  Item.Enabled := EnabledCB.Checked;
  Item.IsHTML := HTMLCB.Checked;

  Item.Multiline := MultilineCB.Checked;
  Item.WordWrap := WordWrapCB.Checked;
  Item.OwnerHeight := not OwnHeightCB.Checked;
  if not Item.OwnerHeight then
    Item.Height := StrToIntDef(HeightEdit.Text, Item.Height);

  Item.WholeLine := WholeLineCB.Checked;
  Item.DrawHLine := HorzLineCB.Checked;
  Item.AllowEdit := AllowEditCB.Checked;
  Item.SuppressButtons := SuppressButtonsCB.Checked;
  Item.SuppressLines := SuppressLinesCB.Checked;
  Item.HintIsHTML := HintHTMLCB.Checked;

  if IndentAdjustCB.Checked then
    Item.IndentAdjust := StrToIntDef(IndentEdit.Text, Item.IndentAdjust)
  else
    Item.IndentAdjust := 0;
  Item.Tag := StrtoIntDef(TagEdit.Text, Item.Tag);
end;

{$HINTS off}

procedure TXItemColDlg.FormCloseQuery(Sender : TObject; var CanClose : Boolean);
var
  C : integer;
  s : string;
  i, j : integer;
begin
  if Assigned(CellTree.Selected) then
    GetCellStyleData(CellTree.Selected.Index);
  if (ByCancel) or (ColorsGB.CheckBoxChecked) then
  begin
    CanClose := true;
    exit;
  end;
  CanClose := false;
  if IdentToColor(ColorCombo.Text, C) and IdentToColor(BkColorCombo.Text, C) then
    CanClose := true
  else
  begin
    MessageBox(Handle, 'Invalid color property', 'Error', mb_IconError or mb_Ok);
    ByCancel := true;
    exit;
  end;
  S := IndexEdit.Text;
  val(S, I, J);
  if J > 0 then CanClose := false;
  S := StIndexEdit.Text;
  val(S, I, J);
  if J > 0 then CanClose := false;
  if not CanClose then
  begin
    MessageBox(Handle, 'Invalid image index property', 'Error', mb_IconError or mb_Ok);
    ByCancel := true;
  end;
end;
{$HINTS on}

procedure TXItemColDlg.OKBtnClick(Sender : TObject);
begin
  ByCancel := false;
end;

procedure TXItemColDlg.FormCreate(Sender : TObject);
begin
  ByCancel := true;
end;

procedure TXItemColDlg.CancelBtnClick(Sender : TObject);
begin
  ByCancel := true;
end;

procedure TXItemColDlg.CBTypeComboChange(Sender : TObject);
begin
  if (CBTypeCombo.ItemIndex <> 1) then
  begin
    if CBStateCombo.Items.Count = 3 then CBStateCombo.Items.Delete(2);
  end
  else
  begin
    if CBStateCombo.Items.Count = 2 then CBStateCombo.items.Add('Grayed');
  end;
end;

procedure TXItemColDlg.StrikeOutCBClick(Sender: TObject);
begin
  StrikeLineColorCB.Enabled := StrikeOutCB.Checked;
end;

procedure TXItemColDlg.OwnHeightCBClick(Sender: TObject);
begin
  HeightEdit.Enabled := OwnHeightCB.Checked;
end;

procedure TXItemColDlg.IndentAdjustCBClick(Sender: TObject);
begin
  IndentEdit.Enabled := IndentAdjustCB.Checked;
end;

procedure TXItemColDlg.ColorsGBClick(Sender: TObject);
begin
  ColorCombo.Enabled := not ColorsGB.CheckBoxChecked;
  BkColorCombo.Enabled := not ColorsGB.CheckBoxChecked;
  RowBkColorCombo.Enabled := not ColorsGB.CheckBoxChecked;
//  UseBkColorsCB.Enabled := not ColorsGB.CheckBoxChecked;
  Label5.Enabled := not ColorsGB.CheckBoxChecked;
  Label12.Enabled := not ColorsGB.CheckBoxChecked;
  Label4.Enabled := not ColorsGB.CheckBoxChecked;
end;

procedure TXItemColDlg.OwnStyleGBClick(Sender: TObject);
begin
  StylesGB.Enabled := OwnStyleGB.CheckBoxChecked;
  ColorsGB.Enabled := OwnStyleGB.CheckBoxChecked;
  ColorsGBClick(self);
  StrikeOutCB.Enabled := OwnStyleGB.CheckBoxChecked;
  StrikeLineColorCB.Enabled := OwnStyleGB.CheckBoxChecked;
  BorderStyleCombo.Enabled := OwnStyleGB.CheckBoxChecked;
  BorderSidesCG.Enabled :=  OwnStyleGB.CheckBoxChecked;
  Label15.Enabled := OwnStyleGB.CheckBoxChecked;
  UseBkColorsCB.Enabled := OwnStyleGB.CheckBoxChecked;
end;

procedure TXItemColDlg.CheckBoxGBClick(Sender: TObject);
var
  i : integer;
  b : boolean;
begin
  b := CheckBoxGB.CheckBoxChecked;
  for i := 0 to CheckBoxGB.ControlCount - 1 do
  begin
    CheckBoxGB.Controls[i].Enabled := b;
  end;
end;

procedure TXItemColDlg.CellStyleClick(Sender: TObject);
begin
  CellStyleGB.Enabled := TElXCellCheckBox(Sender).Checked;
  Item.Cells[CellTree.Selected.Index].UseOwnStyle := TElXCellCheckBox(Sender).Checked;
  if CellStyleGB.Enabled then
  begin
    CellColorsGB.CheckBoxChecked := Item.Cells[CellTree.Selected.Index].Style.ParentColors;
    CellColorsGBClick(self);
  end;
end;

procedure TXItemColDlg.GetCellStyleData(AIndex: integer);
var
  ABorderSides: TLMDBorderSides;
begin
  Item.Cells[AIndex].UseOwnStyle := TElXCellCheckBox(CellTree.Items[AIndex].Cells[2].Style.Control).Checked;
  if TElXCellCheckBox(CellTree.Items[AIndex].Cells[2].Style.Control).Checked then
  begin
    Item.Cells[aIndex].Style.ParentColors := CellColorsGB.CheckBoxChecked;
    if not CellColorsGB.CheckBoxChecked then
    begin
      Item.Cells[aIndex].Style.TextColor := CellColorCombo.SelectedColor;
      Item.Cells[aIndex].Style.TextBackGroundColor := CellBkColorCombo.SelectedColor;
      Item.Cells[aIndex].Style.CellBackGroundColor := CellRowBkColorCombo.SelectedColor;
      Item.Cells[aIndex].Style.UseBackGroundColor := CellUseBkColorsCB.Checked;
    end;
    Item.Cells[aIndex].Style.Italic := CellItCB.Checked;
    Item.Cells[aIndex].Style.Underlined := CellULCB.Checked;
    Item.Cells[aIndex].Style.Bold := CellBoldCB.Checked;
    Item.Cells[aIndex].Style.Strikeout := CellStrikeCB.Checked;

    Item.Cells[aIndex].Style.StrikedOutLine := CellStrikeOutCB.Checked;
    if Item.Cells[aIndex].Style.StrikedOutLine then
      Item.Cells[aIndex].Style.StrikedLineColor := CellStrikeLineColorCB.SelectedColor;
    Item.Cells[aIndex].Style.BorderStyle := TElItemBorderStyle(Max(CellBorderStyleCombo.ItemIndex, 0));
    Item.Cells[aIndex].Style.BorderSpaceColor := CellBorderSpaceColorCB.SelectedColor;
    Item.Cells[aIndex].Style.BorderSides := [];
    ABorderSides := [];
    if CellBorderSidesCG.Checked[0] then
      Include(ABorderSides, ebsLeft);
    if CellBorderSidesCG.Checked[1] then
      Include(ABorderSides, ebsRight);
    if CellBorderSidesCG.Checked[2] then
      Include(ABorderSides, ebsTop);
    if CellBorderSidesCG.Checked[3] then
      Include(ABorderSides, ebsBottom);
    Item.Cells[aIndex].Style.BorderSides := ABorderSides;
  end;
end;

procedure TXItemColDlg.SetCellStyleData(AIndex: integer);
var
  AStyle: TElXCellStyleRead;
begin
  AStyle := Item.Cells[aIndex].CurrentStyle;
  CellStyleGB.Enabled := Item.Cells[aIndex].UseOwnStyle;
  with AStyle do
  begin
    CellColorCombo.SelectedColor := AStyle.TextColor;
    CellBkColorCombo.SelectedColor := AStyle.TextBackGroundColor;
    CellRowBkColorCombo.SelectedColor := AStyle.CellBackGroundColor;

    CellColorsGB.CheckBoxChecked := AStyle.ParentColors;
    CellColorsGBClick(self);
    CellUseBkColorsCB.Checked := AStyle.UseBackGroundColor;
    CellItCB.Checked := AStyle.Italic;
    CellULCB.Checked := AStyle.Underlined;
    CellBoldCB.Checked := AStyle.Bold;
    CellStrikeCB.Checked := AStyle.Strikeout;

    CellStrikeOutCB.Checked := AStyle.StrikedOutLine;
    CellStrikeLineColorCB.Enabled := CellStrikeOutCB.Checked;
    CellStrikeLineColorCB.SelectedColor := AStyle.StrikedLineColor;
    CellBorderStyleCombo.ItemIndex := Ord(AStyle.BorderStyle);
    CellBorderSpaceColorCB.SelectedColor := AStyle.BorderSpaceColor;
    if (ebsLeft in AStyle.BorderSides) then
      CellBorderSidesCG.Checked[0] := True;
    if (ebsRight in AStyle.BorderSides) then
      CellBorderSidesCG.Checked[1] := True;
    if (ebsTop in AStyle.BorderSides) then
      CellBorderSidesCG.Checked[2] := True;
    if (ebsBottom in AStyle.BorderSides) then
      CellBorderSidesCG.Checked[3] := True;
  end;
end;

procedure TXItemColDlg.CellColorsGBClick(Sender: TObject);
begin
  if CellStyleGB.Enabled then
  begin
    CellColorCombo.Enabled := not CellColorsGB.CheckBoxChecked;
    CellBkColorCombo.Enabled := not CellColorsGB.CheckBoxChecked;
    CellRowBkColorCombo.Enabled := not CellColorsGB.CheckBoxChecked;
//    CellUseBkColorsCB.Enabled := not CellColorsGB.CheckBoxChecked;
    Label1.Enabled := not CellColorsGB.CheckBoxChecked;
    Label17.Enabled := not CellColorsGB.CheckBoxChecked;
    Label18.Enabled := not CellColorsGB.CheckBoxChecked;
  end;
end;

procedure TXItemColDlg.CellTreeItemSelectedChange(Sender: TObject;
  Item: TElXTreeItem);
begin
  if Item.Selected then
    SetCellStyleData(Item.Index)
  else
    GetCellStyleData(Item.Index);
end;

procedure TXItemColDlg.ElTreeInplaceAdvancedEdit1BeforeOperation(
  Sender: TObject; var DefaultConversion: Boolean);
begin
  ElTreeInplaceAdvancedEdit1.Editor.Color := CellTree.BackGroundColor;
  ElTreeInplaceAdvancedEdit1.Editor.Font.Assign(TextEdit.Font);
end;

procedure TXItemColDlg.TextEditChange(Sender: TObject);
begin
  if (CellTree.Items.Count > MainTreeColumn) and (CellTree.Items[MainTreeColumn].Text <> TextEdit.Text) then
    CellTree.Items[MainTreeColumn].Text := TextEdit.Text;
end;

procedure TXItemColDlg.CellStrikeOutCBClick(Sender: TObject);
begin
  CellStrikeLineColorCB.Enabled := CellStrikeOutCB.Checked;
end;

procedure TXItemColDlg.CellTreeInplaceEditorNeeded(Sender: TObject;
  Item: TElXTreeItem; SectionIndex: Integer;
  SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor);
begin
  if TElXCellCheckBox(Item.Cells[1].Style.Control).Checked then
    Editor := nil;
  if Item.Index = MainTreeColumn then
    Editor := nil;
end;

procedure TXItemColDlg.FontBtnClick(Sender: TObject);
begin
  FontDialog1.Font := TextEdit.Font;
  if FontDialog1.Execute then
  begin
    HintEdit.Font.Assign(FontDialog1.Font);
    TextEdit.Font.Assign(FontDialog1.Font);
    ElTreeInplaceAdvancedEdit1.Editor.Font.Assign(FontDialog1.Font);
  end;
end;

end.
