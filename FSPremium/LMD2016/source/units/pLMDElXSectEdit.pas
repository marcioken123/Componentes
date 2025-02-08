unit pLMDElXSectEdit;
{$I lmdcmps.inc}
{
  ##############################################################################
  # Author:             LMD Innovative ()
  # Created:
  # Description:
  # State:              release
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # Author:
  # Date:
  # Description:
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ElHeader, ElXHeader, StdCtrls, ExtCtrls, Menus, ElPanel,
  ElGroupBox, ElCheckItemGrp, ElBtnEdit, ElCombos, ElEdits, ElCheckCtl,
  ElXPThemedControl, ElBtnCtl, ElPopBtn, ElCGControl;

type
  TXSectEdit = class(TForm)
    Label6 : TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    GroupBox3: TGroupBox;
    Panel1: TPanel;
    Label4: TLabel;
    Bevel1: TBevel;
    ElPopupButton1: TElPopupButton;
    ElPopupButton2: TElPopupButton;
    VisCB: TElCheckBox;
    ExpandableCB: TElCheckBox;
    ExpandedCB: TElCheckBox;
    FilterCB: TElCheckBox;
    LookupCB: TElCheckBox;
    ClickCB: TElCheckBox;
    ClickSelCB: TElCheckBox;
    ResizeCB: TElCheckBox;
    PswCB: TElCheckBox;
    EditCB: TElCheckBox;
    AutosizeCB: TElCheckBox;
    ShowSortMarkCB: TElCheckBox;
    ImIndexEdit: TElEdit;
    TextEB: TElEdit;
    FieldEdit: TElEdit;
    HintEdit: TElEdit;
    WidthEB: TElEdit;
    MinWidthEB: TElEdit;
    MaxWidthEB: TElEdit;
    StyleCombo: TElComboBox;
    ColTypeCB: TElComboBox;
    PopupCombo: TElComboBox;
    ParentCombo: TElComboBox;
    ImAlignRG: TElRadioGroup;
    SortRG: TElRadioGroup;
    AlignRG: TElRadioGroup;
    LayoutRG: TElRadioGroup;
    FontBtn: TElGraphicButton;
    FontDialog1: TFontDialog;
    procedure ExpandableCBClick(Sender : TObject);
    procedure FilterCBClick(Sender : TObject);
    procedure LookupCBClick(Sender : TObject);
    procedure FontBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Item : TElXHeaderSection;
    Items : TElXHeaderSections;
    Form : TCustomForm;
    procedure SetData;
    procedure GetData;
  end;

var
  XSectEdit : TXSectEdit;

implementation

{$R *.DFM}

procedure TXSectEdit.SetData;
var
  s : shortstring;
  i : integer;
  Section1, Section : TElXHeaderSection;

begin
  TextEB.Text := Item.Text;
  str(Item.Width, s);
  WidthEB.Text := String(s);
  str(Item.MinWidth, s);
  MinWidthEB.Text := String(s);
  str(Item.MaxWidth, s);
  MaxWidthEB.Text := String(s);
  case Item.Alignment of
    hsaLeft : i := 0;
    hsaCenter : i := 1;
    hsaRight : i := 2;
  else
    i := 0;
  end; // case
  AlignRG.ItemIndex := i;

  case Item.TextLayout of
    tlTop : i := 0;
    tlCenter : i := 1;
    tlBottom : i := 2;
  else
    i := 0;
  end; // case
  LayoutRG.ItemIndex := i;

  case Item.SortMode of
    hsmNone : i := 0;
    hsmAscend : i := 1;
    hsmDescend : i := 2;
  end; // case
  SortRG.ItemIndex := i;
  StyleCombo.ItemIndex := integer(Item.Style);
  VisCB.Checked := Item.Visible;
  ClickCB.Checked := Item.AllowClick;
  EditCB.Checked := Item.Editable;
  FieldEdit.Text := Item.FieldName;
  ImIndexEdit.Text := IntToStr(Item.ImageIndex);
  case Item.PictureAlign of
    hsaLeft : i := 0;
    hsaCenter : i := 1;
    hsaRight : i := 2;
  end;
  ImAlignRG.ItemIndex := i;
  case Item.FieldType of
    sftCustom : i := 0;
    sftText : i := 1;
    sftNumber : i := 2;
    sftFloating : i := 3;
    sftDateTime : i := 4;
    sftDate : i := 5;
    sftTime : i := 6;
    sftPicture : i := 7;
    sftEnum : i := 8;
    sftBLOB : i := 9;
    sftBool: i := 10;
    sftCurrency: i := 11;
    sftMemo : i := 12;
  end;
  ColTypeCB.ItemIndex := i;
  PswCB.Checked := Item.Password;
  ResizeCB.Checked := Item.Resizable;
  ParentCombo.Items.AddObject('(no parent)', nil);
  ParentCombo.ItemIndex := 0;
  for i := 0 to Items.Count - 1 do
  begin
    Section := Items[i];
    if (Section <> Item) and (Section.Expandable) then
    begin
      Section1 := Section;
      while (Section1 <> Item) and (Section1.ParentSection <> nil) do
        Section1 := Section1.ParentSection;
      if Section1 <> Item then
      begin
        ParentCombo.Items.AddObject(Section.Text, Section);
        if Section = Item.ParentSection then ParentCombo.ItemIndex := ParentCombo.Items.Count - 1;
      end;
    end;
  end;
  PopupCombo.Items.AddObject('(no menu)', nil);
  PopupCombo.ItemIndex := 0;
  if Form <> nil then
   for i := 0 to Form.ComponentCount - 1 do
   begin
     if (Form.Components[i] is TPopupMenu) and (TPopupMenu(Form.Components[i]).Name <> '') then
     begin
       PopupCombo.Items.AddObject(TPopupMenu(Form.Components[i]).Name, Form.Components[i]);
       if Form.Components[i] = Item.PopupMenu then PopupCombo.ItemIndex := PopupCombo.Items.Count - 1;
     end;
   end;
  LookupCB.Checked := Item.LookupEnabled;
  ExpandableCB.Checked := Item.Expandable;
  ExpandedCB.Checked := Item.Expanded;
  ClickSelCB.Checked := Item.ClickSelect;
  FilterCB.Checked := Item.FilterEnabled;
  AutoSizeCB.Checked := Item.AutoSize;
  ShowSortMarkCB.Checked := Item.ShowSortMark;
  HintEdit.Text := Item.Hint;
end;

procedure TXSectEdit.GetData;
var
  i, c : integer;
  s : string;
begin
  Item.Text := TextEB.Text;
  Item.Visible := VisCB.Checked;

  // set section minimal width
  s := MinWidthEB.Text;
  val(s, i, c);
  if c = 0 then Item.MinWidth := i;

  // set section maximal width
  s := MaxWidthEB.Text;
  val(s, i, c);
  if c = 0 then Item.MaxWidth := i;

  // set section width
  s := WidthEB.Text;
  val(s, i, c);
  if c = 0 then Item.Width := i;

  // set alignment
  case AlignRG.ItemIndex of //
    0 : Item.Alignment := hsaLeft;
    1 : Item.Alignment := hsaCenter;
    2 : Item.Alignment := hsaRight;
  end; // case

  case LayoutRG.ItemIndex of
    0 : Item.TextLayout := tlTop;
    1 : Item.TextLayout := tlCenter;
    2 : Item.TextLayout := tlBottom;
  end; // case

  case SortRG.ItemIndex of //
    0 : Item.SortMode := hsmNone;
    1 : Item.SortMode := hsmAscend;
    2 : Item.SortMode := hsmDescend;
  end; // case
  Item.Style := TElSectionStyle(StyleCombo.ItemIndex);
  Item.AllowClick := ClickCB.Checked;
  Item.Editable := EditCB.Checked;
  s := ImIndexEdit.Text;
  val(s, i, c);
  if c = 0 then Item.ImageIndex := i;
  Item.FieldName := FieldEdit.Text;
  case ImAlignRG.ItemIndex of //
    0 : Item.PictureAlign := hsaLeft;
    1 : Item.PictureAlign := hsaCenter;
    2 : Item.PictureAlign := hsaRight;
  end; // case
  with Item do
    case ColTypeCB.ItemIndex of
      0 : FieldType := sftCustom;
      1 : FieldType := sftText;
      2 : FieldType := sftNumber;
      3 : FieldType := sftFloating;
      4 : FieldType := sftDateTime;
      5 : FieldType := sftDate;
      6 : FieldType := sftTime;
      7 : FieldType := sftPicture;
      8 : FieldType := sftEnum;
      9 : FieldType := sftBLOB;
      10 : FieldType := sftBool;
      11 : FieldType := sftCurrency;
      12 : Fieldtype := sftMemo;
    end;
  Item.ClickSelect := ClickSelCB.Checked;
  Item.Password := PswCB.Checked;
  Item.Resizable := ResizeCB.Checked;
  Item.LookupEnabled := LookupCB.Checked;
  Item.Expandable := ExpandableCB.Checked;
  Item.Expanded := ExpandedCB.Checked;
  Item.FilterEnabled := FilterCB.Checked;
  Item.Hint := HintEdit.Text;
  Item.AutoSize := AutoSizeCB.Checked;
  Item.ShowSortMark := ShowSortMarkCB.Checked;

  if ParentCombo.ItemIndex <> -1 then
    Item.ParentSection := TElXHeaderSection(ParentCombo.Items.Objects[ParentCombo.ItemIndex])
  else
    Item.ParentSection := nil;
  if PopupCombo.ItemIndex <> -1 then
    Item.PopupMenu := TPopupMenu(PopupCombo.Items.Objects[PopupCombo.ItemIndex])
  else
    Item.PopupMenu := nil;
end;

procedure TXSectEdit.ExpandableCBClick(Sender : TObject);
begin
  ExpandedCB.Enabled := ExpandableCB.Checked;
end;

procedure TXSectEdit.FilterCBClick(Sender : TObject);
begin
  //if FilterCB.Checked then LookupCB.Checked := false;
end;

procedure TXSectEdit.LookupCBClick(Sender : TObject);
begin
  //if LookupCB.Checked then FilterCB.Checked := false;
end;

procedure TXSectEdit.FontBtnClick(Sender: TObject);
begin
  FontDialog1.Font := TextEB.Font;
  if FontDialog1.Execute then
  begin
    HintEdit.Font.Assign(FontDialog1.Font);
    TextEB.Font.Assign(FontDialog1.Font);
  end;
end;

end.
