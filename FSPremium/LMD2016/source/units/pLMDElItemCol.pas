unit pLMDElItemCol;
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

pLMDElItemCol unit
------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Math, Buttons, ExtCtrls, ElTree, TypInfo,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  ComCtrls, ElTreeInplaceEditors, ElXPThemedControl, ElEdits, ElBtnCtl,
  ElCheckCtl, ElBtnEdit, ElCombos, ElPopBtn, ElClrCmb, ElCLabel, ElLabel,
  ElPgCtl, ElPanel, ElGroupBox, ElCGControl, Dialogs;

type
  TItemColDlg = class(TForm)
    OKBtn: TElPopupButton;
    CancelBtn: TElPopupButton;
    ElPageControl1: TElPageControl;
    ElTabSheet1: TElTabSheet;
    ElTabSheet2: TElTabSheet;
    ElTabSheet3: TElTabSheet;
    ColTextMemo: TElMemo;
    HintEdit: TElMemo;
    TextEdit: TElMemo;
    OvIndex2Edit: TElEdit;
    OvIndexEdit: TElEdit;
    StIndex2Edit: TElEdit;
    Index2Edit: TElEdit;
    IndexEdit: TElEdit;
    StIndexEdit: TElEdit;
    ShowChecksCB: TElCheckBox;
    ColorsCB: TElCheckBox;
    StylesCB: TElCheckBox;
    StrikeLineColorCB: TElColorCombo;
    BorderStyleCombo: TElComboBox;
    IndentEdit: TElEdit;
    HeightEdit: TElEdit;
    TagEdit: TElEdit;
    WholeLineCB: TElCheckBox;
    WordWrapCB: TElCheckBox;
    CheckBox1: TElCheckBox;
    SuppressLinesCB: TElCheckBox;
    IndentAdjustCB: TElCheckBox;
    OwnHeightCB: TElCheckBox;
    MultilineCB: TElCheckBox;
    SuppressButtonsCB: TElCheckBox;
    AllowEditCB: TElCheckBox;
    HorZlineCB: TElCheckBox;
    StrikeOutCB: TElCheckBox;
    HtmlCB: TElCheckBox;
    HiddenCB: TElCheckBox;
    EnabledCB: TElCheckBox;
    ForcedBtnsCB: TElCheckBox;
    Label2: TElLabel;
    Label1: TElLabel;
    Label13: TElLabel;
    Label16: TElLabel;
    Label11: TElLabel;
    Label10: TElLabel;
    Label7: TElLabel;
    Label6: TElLabel;
    Label3: TElLabel;
    Label15: TElLabel;
    Label14: TElLabel;
    ColorsGB: TElGroupBox;
    Label4: TElLabel;
    Label5: TElLabel;
    Label12: TElLabel;
    UseBkColorCB: TElCheckBox;
    ColorCombo: TElColorCombo;
    BkColorCombo: TElColorCombo;
    RowBkColorCombo: TElColorCombo;
    CBGroup: TElGroupBox;
    Label8: TElLabel;
    Label9: TElLabel;
    CBEnabledCB: TElCheckBox;
    CBTypeCombo: TElComboBox;
    CBStateCombo: TElComboBox;
    StylesGB: TElGroupBox;
    BoldCB: TElCheckBox;
    ItCB: TElCheckBox;
    ULCB: TElCheckBox;
    StrikeCB: TElCheckBox;
    FontDialog1: TFontDialog;
    FontBtn: TElGraphicButton;
    procedure ColorsCBClick(Sender : TObject);
    procedure StylesCBClick(Sender : TObject);
    procedure FormCloseQuery(Sender : TObject; var CanClose : Boolean);
    procedure OKBtnClick(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure CancelBtnClick(Sender : TObject);
    procedure ShowChecksCBClick(Sender : TObject);
    procedure CBTypeComboChange(Sender : TObject);
    procedure StrikeOutCBClick(Sender: TObject);
    procedure OwnHeightCBClick(Sender: TObject);
    procedure IndentAdjustCBClick(Sender: TObject);
    procedure FontBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Item : TElTreeItem;
    ByCancel : boolean;
    procedure SetData;
    procedure GetData;
  end;

var
  ItemColDlg : TItemColDlg;

implementation

{$R *.DFM}

procedure TItemColDlg.SetData;
{$ifdef LMD_UNICODE}
var i : integer;
{$endif}
begin
  TextEdit.Font.Assign(TElTree(Item.Owner).Font);
  HintEdit.Font.Assign(TextEdit.Font);
  ColTextMemo.Font.Assign(TextEdit.Font);

  ColorCombo.Text := ColorToString(Item.Color);
  BkColorCombo.Text := ColorToString(Item.BkColor);
  RowBkColorCombo.Text := ColorToString(Item.RowBkColor);

  ColorsCB.Checked := Item.ParentColors;
  ColorsGB.Enabled := not ColorsCB.Checked;
  UseBkColorCB.Checked := Item.UseBkColor;
  StylesCB.Checked := Item.ParentFontStyle;
  StylesGB.Enabled := not StylesCB.Checked;
  TextEdit.Text := Item.Text;
  HintEdit.Text := Item.Hint;
  {$ifdef LMD_UNICODE}
  ColTextMemo.Lines.Clear;
  for i := 0 to Item.ColumnText.Count -1 do
  begin
    ColTextMemo.Lines.Add(Item.ColumnText[i]);
  end;
  {$else}
  ColTextMemo.Lines.Assign(Item.ColumnText);
  {$endif}
  ItCB.Checked := Item.Italic;
  ULCB.Checked := Item.Underlined;
  BoldCB.Checked := Item.Bold;
  StrikeCB.Checked := Item.Strikeout;
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
  ShowChecksCB.Checked := Item.ShowCheckBox;
  HiddenCB.Checked := Item.Hidden;

  EnabledCB.Checked := Item.Enabled;
  HTMLCB.Checked := Item.IsHTML;
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
  StrikeOutCB.Checked := Item.StrikedOutLine;
  StrikeLineColorCB.Enabled := StrikeOutCB.Checked;
  StrikeLineColorCB.Text := ColorToString(Item.StrikedLineColor);

  IndentAdjustCB.Checked := Item.IndentAdjust <> 0;
  IndentEdit.Enabled := IndentAdjustCB.Checked;
  IndentEdit.Text := IntToStr(Item.IndentAdjust);

  BorderStyleCombo.ItemIndex := Ord(Item.BorderStyle);

  TagEdit.Text := IntToStr(Item.Tag);
end;

procedure TItemColDlg.GetData;
var
  I, J : integer;
  S : string;
begin
  Item.ParentColors := ColorsCB.Checked;
  if not ColorsCB.Checked then
  begin
    IdentToColor(ColorCombo.Text, i);
    Item.Color := TColor(i);
    IdentToColor(BkColorCombo.Text, i);
    Item.BkColor := TColor(i);
    IdentToColor(RowBkColorCombo.Text, i);
    Item.RowBkColor := TColor(i);
    Item.UseBkColor := UseBkColorCB.Checked;
  end;

  Item.ParentFontStyle := StylesCB.Checked;
  Item.Text := TextEdit.Text;
  Item.Hint := HintEdit.Text;
  Item.ColumnText.Assign(ColTextMemo.Lines);
  Item.Italic := ItCB.Checked;
  Item.Underlined := ULCB.Checked;
  Item.Bold := BoldCB.Checked;
  Item.Strikeout := StrikeCB.Checked;
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
  Item.ShowCheckBox := ShowChecksCB.Checked;
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

  Item.StrikedOutLine := StrikeOutCB.Checked;
  IdentToColor(StrikeLineColorCB.Text, i);
  if Item.StrikedOutLine then
    Item.StrikedLineColor := i;

  if IndentAdjustCB.Checked then
    Item.IndentAdjust := StrToIntDef(IndentEdit.Text, Item.IndentAdjust)
  else
    Item.IndentAdjust := 0;

  Item.BorderStyle := TElItemBorderStyle(Max(BorderStyleCombo.ItemIndex, 0));

  Item.Tag := StrtoIntDef(TagEdit.Text, Item.Tag);
end;

procedure TItemColDlg.ColorsCBClick(Sender : TObject);
begin
  ColorsGB.Enabled := not ColorsCB.Checked;
  ColorCombo.Enabled := ColorsGB.Enabled;
  BkColorCombo.Enabled := ColorsGB.Enabled;
  RowBkColorCombo.Enabled := ColorsGB.Enabled;
end;

procedure TItemColDlg.StylesCBClick(Sender : TObject);
begin
  StylesGB.Enabled := not StylesCB.Checked;
  ItCB.enabled := StylesGB.Enabled;
  BoldCB.enabled := StylesGB.Enabled;
  StrikeCB.enabled := StylesGB.Enabled;
  ULCB.enabled := StylesGB.Enabled;
end;

{$HINTS off}

procedure TItemColDlg.FormCloseQuery(Sender : TObject; var CanClose : Boolean);
var
  C : integer;
  s : string;
  i, j : integer;
begin
  if (ByCancel) or (ColorsCB.Checked) then
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

procedure TItemColDlg.OKBtnClick(Sender : TObject);
begin
  ByCancel := false;
end;

procedure TItemColDlg.FormCreate(Sender : TObject);
begin
  ByCancel := true;
end;

procedure TItemColDlg.CancelBtnClick(Sender : TObject);
begin
  ByCancel := true;
end;

procedure TItemColDlg.ShowChecksCBClick(Sender : TObject);
var
  i : integer;
  b : boolean;
begin
  CBGroup.Enabled := ShowChecksCB.Checked;
  b := ShowChecksCB.Checked;
  for i := 0 to CBGroup.ControlCount - 1 do
  begin
    CBGroup.Controls[i].Enabled := b;
  end;
end;

procedure TItemColDlg.CBTypeComboChange(Sender : TObject);
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

procedure TItemColDlg.StrikeOutCBClick(Sender: TObject);
begin
  StrikeLineColorCB.Enabled := StrikeOutCB.Checked;
end;

procedure TItemColDlg.OwnHeightCBClick(Sender: TObject);
begin
  HeightEdit.Enabled := OwnHeightCB.Checked;
end;

procedure TItemColDlg.IndentAdjustCBClick(Sender: TObject);
begin
  IndentEdit.Enabled := IndentAdjustCB.Checked;
end;

procedure TItemColDlg.FontBtnClick(Sender: TObject);
begin
  FontDialog1.Font := TextEdit.Font;
  if FontDialog1.Execute then
  begin
    ColTextMemo.Font.Assign(FontDialog1.Font);
    HintEdit.Font.Assign(FontDialog1.Font);
    TextEdit.Font.Assign(FontDialog1.Font);
  end;
end;

end.
