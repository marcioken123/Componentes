unit pLMDElXStylesProp;
{$I lmdcmps.inc}
{$J+}

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

pLMDElXStylesProp unit
----------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  buttons,
  Forms,
  Dialogs,
  ComCtrls,
  StdCtrls,
  ExtCtrls,
  Math,
  DB,
  ElDBXTree,
  LMDElDBConst,
  ElXTree,
  ElTreeInplaceEditors,
//  ElXTreeCell,
  ElEdits,
  ElPgCtl,
  ElGroupBox,
  ElCheckCtl,
  ElACtrls,
  ElPanel,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  ElXPThemedControl, ElPopBtn, ElCheckItemGrp, ElBtnCtl, ElCLabel, ElLabel,
  ElCGControl
  ;

type

  TElXStylesDefsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
  end;

  TNewStylesPropDlg = class(TForm)
    PageControl1: TElPageControl;
    TabSheet1: TElTabSheet;
    TabSheet2: TElTabSheet;
    Panel1: TElPanel;
    OKBtn: TElPopupButton;
    ListStyle: TTabControl;
    Button1: TElPopupButton;
    Styles: TElGroupBox;
    StylesCB: TElCheckBox;
    ColorsCB: TElCheckBox;
    StylesGB: TElGroupBox;
    BoldCB: TElCheckBox;
    ItCB: TElCheckBox;
    ULCB: TElCheckBox;
    StrikeCB: TElCheckBox;
    ColorsGB: TElGroupBox;
    UseBkColorCB: TElCheckBox;
    ColorCombo: TElAdvancedComboBox;
    RowBkColorCombo: TElAdvancedComboBox;
    ShowChecksCB: TElCheckBox;
    CBGroup: TElGroupBox;
    CBEnabledCB: TElCheckBox;
    CheckBoxCB: TElAdvancedComboBox;
    Image1GB: TElGroupBox;
    ImageCB: TElAdvancedComboBox;
    StImageCB: TElAdvancedComboBox;
    Image2CB: TElAdvancedComboBox;
    StImage2CB: TElAdvancedComboBox;
    Image0GB: TElGroupBox;
    IndexEdit: TElEdit;
    Index2Edit: TElEdit;
    StIndexEdit: TElEdit;
    StIndex2Edit: TElEdit;
    ImagesGB: TElRadioGroup;
    PatternGB: TElGroupBox;
    SpeedButton1: TElGraphicButton;
    PatternE: TElEdit;
    PatternCB: TElAdvancedComboBox;
    UsePatternCB: TElCheckBox;
    Misc: TElGroupBox;
    EnabledCB: TElCheckBox;
    HiddenCB: TElCheckBox;
    HtmlCB: TElCheckBox;
    MultilineCB: TElCheckBox;
    HorZlineCB: TElCheckBox;
    AllowEditCB: TElCheckBox;
    ForcedBtnsCB: TElCheckBox;
    SuppressButtonsCB: TElCheckBox;
    SuppressLinesCB: TElCheckBox;
    IndentAdjustCB: TElCheckBox;
    OwnHeightCB: TElCheckBox;
    StrikeOutCB: TElCheckBox;
    Hints: TElGroupBox;
    HintRG: TElRadioGroup;
    HintED: TElEdit;
    HTMLCBL: TElCheckBox;
    HintCB: TElAdvancedComboBox;
    BorderStyleCombo: TElAdvancedComboBox;
    StrikeLineColorCB: TElAdvancedComboBox;
    Styles1: TElGroupBox;
    StylesCB1: TElCheckBox;
    ColorsCB1: TElCheckBox;
    StylesGB1: TElGroupBox;
    BoldCB1: TElCheckBox;
    ItCB1: TElCheckBox;
    ULCB1: TElCheckBox;
    StrikeCB1: TElCheckBox;
    ColorsGB1: TElGroupBox;
    UseBkColorCB1: TElCheckBox;
    ColorCombo1: TElAdvancedComboBox;
    RowBkColorCombo1: TElAdvancedComboBox;
    ShowChecksCB1: TElCheckBox;
    CBGroup1: TElGroupBox;
    CBEnabledCB1: TElCheckBox;
    CheckBoxCB1: TElAdvancedComboBox;
    ImagesGB1: TElRadioGroup;
    Image0GB1: TElGroupBox;
    IndexEdit1: TElEdit;
    Index2Edit1: TElEdit;
    StIndexEdit1: TElEdit;
    StIndex2Edit1: TElEdit;
    Image1GB1: TElGroupBox;
    ImageCB1: TElAdvancedComboBox;
    StImageCB1: TElAdvancedComboBox;
    Image2CB1: TElAdvancedComboBox;
    StImage2CB1: TElAdvancedComboBox;
    UsePatternCB1: TElCheckBox;
    PatternGB1: TElGroupBox;
    SpeedButton2: TElGraphicButton;
    PatternE1: TElEdit;
    PatternCB1: TElAdvancedComboBox;
    Misc1: TElGroupBox;
    EnabledCB1: TElCheckBox;
    HiddenCB1: TElCheckBox;
    HtmlCB1: TElCheckBox;
    MultilineCB1: TElCheckBox;
    HorZlineCB1: TElCheckBox;
    AllowEditCB1: TElCheckBox;
    ForcedBtnsCB1: TElCheckBox;
    SuppressButtonsCB1: TElCheckBox;
    SuppressLinesCB1: TElCheckBox;
    IndentAdjustCB1: TElCheckBox;
    OwnHeightCB1: TElCheckBox;
    StrikeOutCB1: TElCheckBox;
    GroupBox1: TElGroupBox;
    HintRG1: TElRadioGroup;
    HintED1: TElEdit;
    HTMLCBL1: TElCheckBox;
    HintCB1: TElAdvancedComboBox;
    BorderStyleCombo1: TElAdvancedComboBox;
    StrikeLineColorCB1: TElAdvancedComboBox;
    HeightEdit: TElEdit;
    IndentEdit: TElEdit;
    IndentEdit1: TElEdit;
    HeightEdit1: TElEdit;
    BkColorCombo: TElAdvancedComboBox;
    BkColorCombo1: TElAdvancedComboBox;
    Label4: TElLabel;
    Label12: TElLabel;
    Label5: TElLabel;
    Label7: TElLabel;
    Label10: TElLabel;
    Label11: TElLabel;
    Label24: TElLabel;
    Label25: TElLabel;
    Label8: TElLabel;
    Label9: TElLabel;
    Label14: TElLabel;
    Label16: TElLabel;
    Label30: TElLabel;
    Label15: TElLabel;
    Label26: TElLabel;
    Label27: TElLabel;
    Label20: TElLabel;
    Label22: TElLabel;
    Label21: TElLabel;
    Label1: TElLabel;
    Label2: TElLabel;
    Label3: TElLabel;
    Label6: TElLabel;
    Label13: TElLabel;
    Label17: TElLabel;
    Label18: TElLabel;
    Label19: TElLabel;
    Label23: TElLabel;
    Label31: TElLabel;
    Label34: TElLabel;
    Label28: TElLabel;
    Label29: TElLabel;
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure StylesCB1Click(Sender: TObject);
    procedure StylesCBClick(Sender: TObject);
    procedure ColorsCBClick(Sender: TObject);
    procedure ColorsCB1Click(Sender: TObject);
    procedure ShowChecksCBClick(Sender: TObject);
    procedure ShowChecksCB1Click(Sender: TObject);
    procedure StrikeOutCBClick(Sender: TObject);
    procedure StrikeOutCB1Click(Sender: TObject);
    procedure OwnHeightCBClick(Sender: TObject);
    procedure OwnHeightCB1Click(Sender: TObject);
    procedure IndentAdjustCB1Click(Sender: TObject);
    procedure IndentAdjustCBClick(Sender: TObject);
    procedure ListStyleChange(Sender: TObject);
    procedure ListStyleChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ImagesGBClick(Sender: TObject);
    procedure ImagesGB1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure HintRGClick(Sender: TObject);
    procedure HintRG1Click(Sender: TObject);
    procedure UsePatternCBClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure UsePatternCB1Click(Sender: TObject);
    procedure PageControl1ClosePageQuery(Sender: TObject;
      Page: TElTabSheet; var CanClose: Boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; NewPage: TElTabSheet;
      var AllowChange: Boolean);
  private
    { Private declarations }
  public
    AComp : TComponent;
    DStylesDefs : TElXStylesDefs;
    DStylesDefsItem : TElXStylesDefsItem;
    procedure SetData(param : integer);
    procedure GetData(param : integer);
  end;

var

  StylesPropDlg: TNewStylesPropDlg = nil;

implementation

{$R *.DFM}
procedure TElXStylesDefsProperty.Edit;
var
  Form : TCustomForm;
begin
  if StylesPropDlg = nil then
    StylesPropDlg := TNewStylesPropDlg.Create(Application);
  with StylesPropDlg do
  begin
    AComp := TComponent(GetComponent(0));
    DStylesDefs := TCustomElDBXTree(GetComponent(0)).StylesDefs;
    if DStylesDefs.Count > 0 then
      begin
        ShowModal;
        Form := GetParentForm(AComp as TControl);
        if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
      end
    else
      ShowMessage (SNoSetInstall);
  end;
end;

function TElXStylesDefsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TNewStylesPropDlg.FormShow(Sender: TObject);
var i : integer;
begin
  if DStylesDefs.Count > 1 then
    begin
      for i:=1 to DStylesDefs.Count-1 do
        if not DStylesDefs[i].InDesign then ListStyle.Tabs.Add(DStylesDefs[i].StyleCaption);
      ListStyle.TabIndex := 0;
    end
  else
    if Assigned(TabSheet2) then
      FreeAndNil(TabSheet2);
  PageControl1.ActivePageIndex := 0;
  DStylesDefsItem := DStylesDefs.Items[0];
  CheckBoxCB.Items.Clear;
  HintCB.Items.Clear;
  ImageCB.Items.Clear;
  Image2CB.Items.Clear;
  StImageCB.Items.Clear;
  StImage2CB.Items.Clear;
  if (DStylesDefsItem <> nil) and (DStylesDefsItem.DataLink.DataSet <> nil) then
  begin
    for i := 0 to DStylesDefsItem.DataLink.DataSet.FieldCount-1 do
    begin
      PatternCB.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
      if (DStylesDefsItem.DataLink.DataSet.Fields[i].DataType in [ftSmallint, ftInteger,ftWord, ftFloat]) then
      begin
        ImageCB.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
        Image2CB.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
        StImageCB.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
        StImage2CB.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
      end
      else
        if (DStylesDefsItem.DataLink.DataSet.Fields[i].DataType in [ftBoolean]) then
          CheckBoxCB.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName)
        else
          HintCB.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
    end;
  end;
  GetData(0);
end;

procedure TNewStylesPropDlg.OKBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TNewStylesPropDlg.StylesCB1Click(Sender: TObject);
begin
  StylesGB1.Enabled := not StylesCB1.Checked;
  ItCB1.enabled := StylesGB1.Enabled;
  BoldCB1.enabled := StylesGB1.Enabled;
  StrikeCB1.enabled := StylesGB1.Enabled;
  ULCB1.enabled := StylesGB1.Enabled;
  if StylesCB1.Checked then
  begin
    ItCB1.Checked := false;
    BoldCB1.Checked := false;
    StrikeCB1.Checked := false;
    ULCB1.Checked := false;
  end;
end;

procedure TNewStylesPropDlg.StylesCBClick(Sender: TObject);
begin
  StylesGB.Enabled := not StylesCB.Checked;
  ItCB.enabled := StylesGB.Enabled;
  BoldCB.enabled := StylesGB.Enabled;
  StrikeCB.enabled := StylesGB.Enabled;
  ULCB.enabled := StylesGB.Enabled;
  if StylesCB.Checked then
  begin
    ItCB.Checked := false;
    BoldCB.Checked := false;
    StrikeCB.Checked := false;
    ULCB.Checked := false;
  end;
end;

procedure TNewStylesPropDlg.ColorsCBClick(Sender: TObject);
begin
  ColorsGB.Enabled := not ColorsCB.Checked;
  ColorCombo.Enabled := ColorsGB.Enabled;
  RowBkColorCombo.Enabled := ColorsGB.Enabled;
  BkColorCombo.Enabled := ColorsGB.Enabled;
end;

procedure TNewStylesPropDlg.ColorsCB1Click(Sender: TObject);
begin
  ColorsGB1.Enabled := not ColorsCB1.Checked;
  ColorCombo1.Enabled := ColorsGB1.Enabled;
  RowBkColorCombo1.Enabled := ColorsGB1.Enabled;
  BkColorCombo1.Enabled := ColorsGB.Enabled;
end;

procedure TNewStylesPropDlg.ShowChecksCBClick(Sender: TObject);
var i : integer;
  b : boolean;
begin
  CBGroup.Enabled := ShowChecksCB.Checked;
  b := ShowChecksCB.Checked;
  for i := 0 to CBGroup.ControlCount - 1 do
  begin
    CBGroup.Controls[i].Enabled := b;
  end;
end;

procedure TNewStylesPropDlg.ShowChecksCB1Click(Sender: TObject);
var i : integer;
  b : boolean;
begin
  CBGroup1.Enabled := ShowChecksCB1.Checked;
  b := ShowChecksCB1.Checked;
  for i := 0 to CBGroup1.ControlCount - 1 do
  begin
    CBGroup1.Controls[i].Enabled := b;
  end;
end;

procedure TNewStylesPropDlg.StrikeOutCBClick(Sender: TObject);
begin
  StrikeLineColorCB.Enabled := StrikeOutCB.Checked;
end;

procedure TNewStylesPropDlg.StrikeOutCB1Click(Sender: TObject);
begin
  StrikeLineColorCB1.Enabled := StrikeOutCB1.Checked;
end;

procedure TNewStylesPropDlg.OwnHeightCBClick(Sender: TObject);
begin
  HeightEdit.Enabled := OwnHeightCB.Checked;
end;

procedure TNewStylesPropDlg.OwnHeightCB1Click(Sender: TObject);
begin
  HeightEdit1.Enabled := OwnHeightCB1.Checked;
end;

procedure TNewStylesPropDlg.IndentAdjustCB1Click(Sender: TObject);
begin
  IndentEdit1.Enabled := IndentAdjustCB1.Checked;
end;

procedure TNewStylesPropDlg.IndentAdjustCBClick(Sender: TObject);
begin
  IndentEdit.Enabled := IndentAdjustCB.Checked;
end;

procedure TNewStylesPropDlg.SetData(param : integer);
var
  I, J : integer;
  S : string;
begin
  if param = 0 then
    begin
      DStylesDefsItem.ParentColors := ColorsCB.Checked;
      if not ColorsCB.Checked then
      begin
        IdentToColor(ColorCombo.Text, i);
        DStylesDefsItem.Color := TColor(i);
        IdentToColor(BkColorCombo.Text, i);
        DStylesDefsItem.BkColor := TColor(i);
        IdentToColor(RowBkColorCombo.Text, i);
        DStylesDefsItem.RowBkColor := TColor(i);
        DStylesDefsItem.UseBkColor := UseBkColorCB.Checked;
      end;
      DStylesDefsItem.ParentFontStyle := StylesCB.Checked;
      DStylesDefsItem.Italic := ItCB.Checked;
      DStylesDefsItem.Underlined := ULCB.Checked;
      DStylesDefsItem.Bold := BoldCB.Checked;
      DStylesDefsItem.Strikeout := StrikeCB.Checked;
      DStylesDefsItem.ForceButtons := ForcedBtnsCB.Checked;
      DStylesDefsItem.ShowCheckBox := ShowChecksCB.Checked;
      DStylesDefsItem.CheckBox := CheckBoxCB.Text;

      DStylesDefsItem.HintField := HintCB.Text;
      DStylesDefsItem.Hint := HintED.Text;
      DStylesDefsItem.HintIsHTML := HTMLCBL.Checked;

      DStylesDefsItem.Image := ImageCB.Text;
      DStylesDefsItem.Image2 := Image2CB.Text;
      DStylesDefsItem.CheckBoxEnabled := CBEnabledCB.Checked;
      DStylesDefsItem.Hidden := HiddenCB.Checked;

      DStylesDefsItem.Enabled := EnabledCB.Checked;
      DStylesDefsItem.IsHTML := HTMLCB.Checked;
      DStylesDefsItem.Multiline := MultilineCB.Checked;
      DStylesDefsItem.DrawHLine := HorzLineCB.Checked;
      DStylesDefsItem.AllowEdit := AllowEditCB.Checked;
      DStylesDefsItem.SuppressButtons := SuppressButtonsCB.Checked;
      DStylesDefsItem.SuppressLines := SuppressLinesCB.Checked;

      DStylesDefsItem.StrikedOutLine := StrikeOutCB.Checked;
      IdentToColor(StrikeLineColorCB.Text, i);
      if StrikeOutCB.Checked then
        DStylesDefsItem.StrikedLineColor := i;

      DStylesDefsItem.OwnerHeight := not OwnHeightCB.Checked;
      if not DStylesDefsItem.OwnerHeight then
        DStylesDefsItem.Height := StrToIntDef(HeightEdit.Text, DStylesDefsItem.Height);

      DStylesDefsItem.UsePattern := UsePatternCB.Checked;
      DStylesDefsItem.Pattern := PatternE.Text;

      if IndentAdjustCB.Checked then
        DStylesDefsItem.IndentAdjust := StrToIntDef(IndentEdit.Text, DStylesDefsItem.IndentAdjust)
      else
        DStylesDefsItem.IndentAdjust := 0;

      if BorderStyleCombo.ItemIndex > 0 then
        DStylesDefsItem.BorderStyle := TElItemBorderStyle(BorderStyleCombo.ItemIndex)
      else
        DStylesDefsItem.BorderStyle := TElItemBorderStyle(0);

      case ImagesGB.ItemIndex of
        0 : begin
              DStylesDefsItem.ImagesFromBase := False;
              S := IndexEdit.Text;
              val(S, I, J);
              if J = 0 then DStylesDefsItem.ImageIndex := I;
              S := StIndexEdit.Text;
              val(S, I, J);
              if J = 0 then DStylesDefsItem.StateImageIndex := I;

              S := Index2Edit.Text;
              val(S, I, J);
              if J = 0 then DStylesDefsItem.ImageIndex2 := I;
              S := StIndex2Edit.Text;
              val(S, I, J);
              if J = 0 then DStylesDefsItem.StateImageIndex2 := I;
            end;
        1 : begin
              DStylesDefsItem.ImagesFromBase := True;
              DStylesDefsItem.Image := ImageCB.Text;
              DStylesDefsItem.Image2 := Image2CB.Text;
              DStylesDefsItem.StImage := StImageCB.Text;
              DStylesDefsItem.StImage2 := StImage2CB.Text;
            end;
      end;
    end
  else
    begin
      DStylesDefsItem.ParentColors := ColorsCB1.Checked;
      if not ColorsCB1.Checked then
      begin
        IdentToColor(ColorCombo1.Text, i);
        DStylesDefsItem.Color := TColor(i);
        IdentToColor(BkColorCombo1.Text, i);
        DStylesDefsItem.BkColor := TColor(i);
        IdentToColor(RowBkColorCombo1.Text, i);
        DStylesDefsItem.RowBkColor := TColor(i);
        DStylesDefsItem.UseBkColor := UseBkColorCB1.Checked;
      end;
      DStylesDefsItem.ParentFontStyle := StylesCB1.Checked;
      DStylesDefsItem.Italic := ItCB1.Checked;
      DStylesDefsItem.Underlined := ULCB1.Checked;
      DStylesDefsItem.Bold := BoldCB1.Checked;
      DStylesDefsItem.Strikeout := StrikeCB1.Checked;
      DStylesDefsItem.ForceButtons := ForcedBtnsCB1.Checked;
      DStylesDefsItem.ShowCheckBox := ShowChecksCB1.Checked;
      DStylesDefsItem.CheckBoxEnabled := CBEnabledCB1.Checked;
      if ShowChecksCB1.Checked then
        DStylesDefsItem.CheckBox := CheckBoxCB1.Text;

      DStylesDefsItem.HintField := HintCB1.Text;
      DStylesDefsItem.Hint := HintED1.Text;
      DStylesDefsItem.HintIsHTML := HTMLCBL1.Checked;

      DStylesDefsItem.Image := ImageCB1.Text;
      DStylesDefsItem.Image2 := Image2CB1.Text;
      DStylesDefsItem.Hidden := HiddenCB1.Checked;

      DStylesDefsItem.Enabled := EnabledCB1.Checked;
      DStylesDefsItem.IsHTML := HTMLCB1.Checked;
      DStylesDefsItem.Multiline := MultilineCB1.Checked;
      DStylesDefsItem.DrawHLine := HorzLineCB1.Checked;
      DStylesDefsItem.AllowEdit := AllowEditCB1.Checked;
      DStylesDefsItem.SuppressButtons := SuppressButtonsCB1.Checked;
      DStylesDefsItem.SuppressLines := SuppressLinesCB1.Checked;

      DStylesDefsItem.StrikedOutLine := StrikeOutCB1.Checked;
      IdentToColor(StrikeLineColorCB1.Text, i);
      if StrikeOutCB1.Checked then
        DStylesDefsItem.StrikedLineColor := i;

      DStylesDefsItem.UsePattern := UsePatternCB1.Checked;
      DStylesDefsItem.Pattern := PatternE1.Text;

      DStylesDefsItem.OwnerHeight := not OwnHeightCB1.Checked;
      if not DStylesDefsItem.OwnerHeight then
        DStylesDefsItem.Height := StrToIntDef(HeightEdit1.Text, DStylesDefsItem.Height);

      if IndentAdjustCB1.Checked then
        DStylesDefsItem.IndentAdjust := StrToIntDef(IndentEdit1.Text, DStylesDefsItem.IndentAdjust)
      else
        DStylesDefsItem.IndentAdjust := 0;

      if BorderStyleCombo1.ItemIndex > 0 then
        DStylesDefsItem.BorderStyle := TElItemBorderStyle(BorderStyleCombo1.ItemIndex)
      else
        DStylesDefsItem.BorderStyle := TElItemBorderStyle(0);

      case ImagesGB1.ItemIndex of
        0 : begin
              DStylesDefsItem.ImagesFromBase := False;
              DStylesDefsItem.ImageIndex := StrToInt(IndexEdit1.Text);
              DStylesDefsItem.StateImageIndex := StrToInt(StIndexEdit1.Text);

              DStylesDefsItem.ImageIndex2 := StrToInt(Index2Edit1.Text);
              DStylesDefsItem.StateImageIndex2 := StrToInt(StIndex2Edit1.Text);
            end;
        1 : begin
              DStylesDefsItem.ImagesFromBase := True;
              DStylesDefsItem.Image := ImageCB1.Text;
              DStylesDefsItem.Image2 := Image2CB1.Text;
              DStylesDefsItem.StImage := StImageCB1.Text;
              DStylesDefsItem.StImage2 := StImage2CB1.Text;
            end;
      end;
    end;
end;

procedure TNewStylesPropDlg.GetData(param : integer);
var i : integer;
    b : boolean;
begin
  if DStylesDefsItem = nil then exit;
  if param = 0 then
    begin
      ColorCombo.Text := ColorToString(DStylesDefsItem.Color);
      BkColorCombo.Text := ColorToString(DStylesDefsItem.BkColor);
      RowBkColorCombo.Text := ColorToString(DStylesDefsItem.RowBkColor);

      ColorsCB.Checked := DStylesDefsItem.ParentColors;
      ColorsGB.Enabled := not ColorsCB.Checked;
      ColorCombo.Enabled := ColorsGB.Enabled;
      BkColorCombo.Enabled := ColorsGB.Enabled;
      RowBkColorCombo.Enabled := ColorsGB.Enabled;
      UseBkColorCB.Checked := DStylesDefsItem.UseBkColor;
      StylesCB.Checked := DStylesDefsItem.ParentFontStyle;
      StylesGB.Enabled := not StylesCB.Checked;
      ItCB.enabled := StylesGB.Enabled;
      BoldCB.enabled := StylesGB.Enabled;
      StrikeCB.enabled := StylesGB.Enabled;
      ULCB.enabled := StylesGB.Enabled;
      ItCB.Checked := DStylesDefsItem.Italic;
      ULCB.Checked := DStylesDefsItem.Underlined;
      BoldCB.Checked := DStylesDefsItem.Bold;
      StrikeCB.Checked := DStylesDefsItem.Strikeout;

      ForcedBtnsCB.Checked := DStylesDefsItem.ForceButtons;
      CBEnabledCB.Checked := DStylesDefsItem.CheckBoxEnabled;
      ShowChecksCB.Checked := DStylesDefsItem.ShowCheckBox;
      HiddenCB.Checked := DStylesDefsItem.Hidden;
      CheckBoxCB.Text := DStylesDefsItem.CheckBox;

      HintRG.ItemIndex := 0;
      if DStylesDefsItem.HintField = '' then
      begin
        HintED.Text := DStylesDefsItem.Hint;
        Label26.Enabled := false;
        HintCB.Enabled := false;
        HintCB.Text := '';
        Label27.Enabled := true;
        HintED.Enabled := true;
      end
      else
      begin
        Label26.Enabled := true;
        HintCB.Enabled := true;
        Label27.Enabled := false;
        HintED.Enabled := false;
        HintCB.Text := DStylesDefsItem.HintField;
        HintRG.ItemIndex := 1;
      end;
      HTMLCBL.Checked := DStylesDefsItem.HintIsHTML;

      ImageCB.Text := DStylesDefsItem.Image;
      Image2CB.Text := DStylesDefsItem.Image2;

      EnabledCB.Checked := DStylesDefsItem.Enabled;
      HTMLCB.Checked := DStylesDefsItem.IsHTML;
      MultilineCB.Checked := DStylesDefsItem.Multiline;
      HorzLineCB.Checked := DStylesDefsItem.DrawHLine;
      AllowEditCB.Checked := DStylesDefsItem.AllowEdit;
      SuppressButtonsCB.Checked :=DStylesDefsItem.SuppressButtons;
      SuppressLinesCB.Checked :=DStylesDefsItem.SuppressLines;
      StrikeOutCB.Checked := DStylesDefsItem.StrikedOutLine;
      StrikeLineColorCB.Enabled := DStylesDefsItem.StrikedOutLine;
      StrikeLineColorCB.Text := ColorToString(DStylesDefsItem.StrikedLineColor);
//      ShowMessage('striked color = ' + ColorToString(DStylesDefsItem.StrikedLineColor));
      OwnHeightCB.Checked := not DStylesDefsItem.OwnerHeight;
      HeightEdit.Enabled := OwnHeightCB.Checked;
      HeightEdit.Text := IntToStr(DStylesDefsItem.Height);

      IndentAdjustCB.Checked := DStylesDefsItem.IndentAdjust <> 0;
      IndentEdit.Enabled := IndentAdjustCB.Checked;
      IndentEdit.Text := IntToStr(DStylesDefsItem.IndentAdjust);

      BorderStyleCombo.ItemIndex := Ord(DStylesDefsItem.BorderStyle);

      IndexEdit.Text := IntToStr(DStylesDefsItem.ImageIndex);
      StIndexEdit.Text := IntToStr(DStylesDefsItem.StateImageIndex);
      Index2Edit.Text := IntToStr(DStylesDefsItem.ImageIndex2);
      StIndex2Edit.Text := IntToStr(DStylesDefsItem.StateImageIndex2);
      ImageCB.Text := DStylesDefsItem.Image;
      Image2CB.Text := DStylesDefsItem.Image2;
      StImageCB.Text := DStylesDefsItem.StImage;
      StImage2CB.Text := DStylesDefsItem.StImage2;
      PatternE.Text := DStylesDefsItem.Pattern;
      UsePatternCB.Checked := DStylesDefsItem.UsePattern;

       if not DStylesDefsItem.ImagesFromBase then
         ImagesGB.ItemIndex := 0
       else
         ImagesGB.ItemIndex := 1;
       b := (ImagesGB.ItemIndex=0);
       for i := 0 to Image0GB.ControlCount - 1 do
         begin
           Image0GB.Controls[i].Enabled := b;
         end;
       for i := 0 to Image1GB.ControlCount - 1 do
         begin
           Image1GB.Controls[i].Enabled := not b;
         end;
       for i := 0 to PatternGB.ControlCount - 1 do
         begin
           PatternGB.Controls[i].Enabled := DStylesDefsItem.UsePattern;
       end;
     PatternGB.Enabled := DStylesDefsItem.UsePattern;
     PatternCB.Text := DStylesDefsItem.DataField;
    end
  else
    begin
      ColorCombo1.Text := ColorToString(DStylesDefsItem.Color);
      BkColorCombo1.Text := ColorToString(DStylesDefsItem.BkColor);
      RowBkColorCombo1.Text := ColorToString(DStylesDefsItem.RowBkColor);

      ColorsCB1.Checked := DStylesDefsItem.ParentColors;
      ColorsGB1.Enabled := not ColorsCB1.Checked;
      ColorCombo1.Enabled := ColorsGB1.Enabled;
      BkColorCombo1.Enabled := ColorsGB1.Enabled;
      RowBkColorCombo1.Enabled := ColorsGB1.Enabled;
      UseBkColorCB1.Checked := DStylesDefsItem.UseBkColor;
      StylesCB1.Checked := DStylesDefsItem.ParentFontStyle;
      StylesGB1.Enabled := not StylesCB1.Checked;
      ItCB1.enabled := StylesGB1.Enabled;
      BoldCB1.enabled := StylesGB1.Enabled;
      StrikeCB1.enabled := StylesGB1.Enabled;
      ULCB1.enabled := StylesGB1.Enabled;
      ItCB1.Checked := DStylesDefsItem.Italic;
      ULCB1.Checked := DStylesDefsItem.Underlined;
      BoldCB1.Checked := DStylesDefsItem.Bold;
      StrikeCB1.Checked := DStylesDefsItem.Strikeout;
      ForcedBtnsCB1.Checked := DStylesDefsItem.ForceButtons;
      CBEnabledCB1.Checked := DStylesDefsItem.CheckBoxEnabled;
      ShowChecksCB1.Checked := DStylesDefsItem.ShowCheckBox;
      HiddenCB1.Checked := DStylesDefsItem.Hidden;
      CheckBoxCB1.Text := DStylesDefsItem.CheckBox;

      HintRG1.ItemIndex := 0;
      if DStylesDefsItem.HintField = '' then
      begin
        HintED1.Text := DStylesDefsItem.Hint;
        Label28.Enabled := false;
        HintCB1.Enabled := false;
        HintCB1.Text := '';
        Label29.Enabled := true;
        HintED1.Enabled := true;
      end
      else
      begin
        HintCB1.Text := DStylesDefsItem.HintField;
        HintRG1.ItemIndex := 1;
        Label28.Enabled := true;
        HintCB1.Enabled := true;
        Label29.Enabled := false;
        HintED1.Enabled := false;
      end;
      HTMLCBL1.Checked := DStylesDefsItem.HintIsHTML;

      ImageCB1.Text := DStylesDefsItem.Image;
      Image2CB1.Text := DStylesDefsItem.Image2;
      EnabledCB1.Checked := DStylesDefsItem.Enabled;
      HTMLCB1.Checked := DStylesDefsItem.IsHTML;
      MultilineCB1.Checked := DStylesDefsItem.Multiline;
      HorzLineCB1.Checked := DStylesDefsItem.DrawHLine;
      AllowEditCB1.Checked := DStylesDefsItem.AllowEdit;
      SuppressButtonsCB1.Checked :=DStylesDefsItem.SuppressButtons;
      SuppressLinesCB1.Checked :=DStylesDefsItem.SuppressLines;
      StrikeOutCB1.Checked := DStylesDefsItem.StrikedOutLine;
      StrikeLineColorCB1.Enabled := StrikeOutCB.Checked;
      StrikeLineColorCB1.Text := ColorToString(DStylesDefsItem.StrikedLineColor);

      OwnHeightCB1.Checked := not DStylesDefsItem.OwnerHeight;
      HeightEdit1.Enabled := OwnHeightCB1.Checked;
      HeightEdit1.Text := IntToStr(DStylesDefsItem.Height);

      IndentAdjustCB1.Checked := DStylesDefsItem.IndentAdjust <> 0;
      IndentEdit1.Enabled := IndentAdjustCB1.Checked;
      IndentEdit1.Text := IntToStr(DStylesDefsItem.IndentAdjust);

      BorderStyleCombo1.ItemIndex := Ord(DStylesDefsItem.BorderStyle);

      IndexEdit1.Text := IntToStr(DStylesDefsItem.ImageIndex);
      StIndexEdit1.Text := IntToStr(DStylesDefsItem.StateImageIndex);
      Index2Edit1.Text := IntToStr(DStylesDefsItem.ImageIndex2);
      StIndex2Edit1.Text := IntToStr(DStylesDefsItem.StateImageIndex2);
      ImageCB1.Text := DStylesDefsItem.Image;
      Image2CB1.Text := DStylesDefsItem.Image2;
      StImageCB1.Text := DStylesDefsItem.StImage;
      StImage2CB1.Text := DStylesDefsItem.StImage2;
      PatternE1.Text := DStylesDefsItem.Pattern;
      UsePatternCB1.Checked := DStylesDefsItem.UsePattern;
       if not DStylesDefsItem.ImagesFromBase then
         ImagesGB1.ItemIndex := 0
       else
         ImagesGB1.ItemIndex := 1;
       b := (ImagesGB1.ItemIndex=0);
       for i := 0 to Image0GB1.ControlCount - 1 do
         begin
           Image0GB1.Controls[i].Enabled := b;
         end;
       for i := 0 to Image1GB1.ControlCount - 1 do
         begin
           Image1GB1.Controls[i].Enabled := not b;
         end;
       for i := 0 to PatternGB1.ControlCount - 1 do
         begin
           PatternGB1.Controls[i].Enabled := DStylesDefsItem.UsePattern;
       end;
       PatternGB1.Enabled := DStylesDefsItem.UsePattern;
       PatternCB1.Text := DStylesDefsItem.DataField;
    end;
end;

procedure TNewStylesPropDlg.ListStyleChange(Sender: TObject);
var i, t : integer;
begin
  t := ListStyle.TabIndex+1;
  if DStylesDefs.Count>1 then DStylesDefsItem := DStylesDefs.Items[t]
    else DStylesDefsItem := nil;
  CheckBoxCB1.Items.Clear;
  ImageCB1.Items.Clear;
  Image2CB1.Items.Clear;
  StImageCB1.Items.Clear;
  StImage2CB1.Items.Clear;
  PatternCB1.Items.Clear;
  if (DStylesDefsItem <> nil) and (DStylesDefsItem.DataLink.DataSet <> nil) then
    begin
      for i := 0 to DStylesDefsItem.DataLink.DataSet.FieldCount-1 do
        begin
          PatternCB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
          if (DStylesDefsItem.DataLink.DataSet.Fields[i].DataType in [ftSmallint, ftInteger,ftWord, ftFloat]) then
            begin
              ImageCB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
              Image2CB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
              StImageCB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
              StImage2CB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
            end;
          if (DStylesDefsItem.DataLink.DataSet.Fields[i].DataType in [ftBoolean]) then
              CheckBoxCB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
        end;
    end;
  GetData(t);
end;

procedure TNewStylesPropDlg.ListStyleChanging(Sender: TObject;
  var AllowChange: Boolean);
var t : integer;
    C : integer;
begin
  AllowChange := True;
  if IdentToColor(ColorCombo1.Text, C) and IdentToColor(BkColorCombo1.Text, C) then
    AllowChange := true
  else
    begin
      MessageBox(Handle, 'Invalid color property', 'Error', mb_IconError or mb_Ok);
      AllowChange := false;
      exit;
    end;
  t := ListStyle.TabIndex+1;
  if AllowChange then SetData(t);
end;

procedure TNewStylesPropDlg.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  t : integer;
begin
  if DStylesDefs.Count > 1 then
    begin
      for t:=1 to DStylesDefs.Count-1 do
        if not DStylesDefs[t].InDesign then ListStyle.Tabs.Delete(ListStyle.Tabs.Count-1);
    end ;
  t := PageControl1.ActivePageIndex;
  CanClose := True;
  if CanClose then
    begin
      SetData(t);
      DStylesDefs.Tree.RebuildTree(false);
    end;
end;

procedure TNewStylesPropDlg.ImagesGBClick(Sender: TObject);
var i : integer;
    b : boolean;
begin
  b := (ImagesGB.ItemIndex=0);
  for i := 0 to Image0GB.ControlCount - 1 do
    begin
      Image0GB.Controls[i].Enabled := b;
    end;
  for i := 0 to Image1GB.ControlCount - 1 do
    begin
      Image1GB.Controls[i].Enabled := not b;
    end;
end;

procedure TNewStylesPropDlg.ImagesGB1Click(Sender: TObject);
var i : integer;
    b : boolean;
begin
  b := (ImagesGB1.ItemIndex=0);
  for i := 0 to Image0GB1.ControlCount - 1 do
    begin
      Image0GB1.Controls[i].Enabled := b;
    end;
  for i := 0 to Image1GB1.ControlCount - 1 do
    begin
      Image1GB1.Controls[i].Enabled := not b;
    end;
end;

procedure TNewStylesPropDlg.Button1Click(Sender: TObject);
var canclose : boolean;
    t : integer;
    C : integer;
begin
  t := PageControl1.ActivePageIndex;
  if t = 0 then
    begin
      if IdentToColor(ColorCombo.Text, C) and IdentToColor(BkColorCombo.Text, C) then
        CanClose := true
      else
        begin
          MessageBox(Handle, 'Invalid color property', 'Error', mb_IconError or mb_Ok);
          exit;
        end;
    end
  else
    begin
      if IdentToColor(ColorCombo1.Text, C) and IdentToColor(BkColorCombo1.Text, C) then
        CanClose := true
      else
      begin
        MessageBox(Handle, 'Invalid color property', 'Error', mb_IconError or mb_Ok);
        exit;
      end;
      t := ListStyle.TabIndex+1;
    end;
  if CanClose then
    begin
      SetData(t);
      DStylesDefs.Tree.RebuildTree(false);
    end;
end;

procedure TNewStylesPropDlg.HintRGClick(Sender: TObject);
begin
  if HintRG.ItemIndex = 0 then
  begin
    Label26.Enabled := false;
    HintCB.Enabled := false;
    HintCB.Text := '';
    Label27.Enabled := true;
    HintED.Enabled := true;
  end
  else
  begin
    Label26.Enabled := true;
    HintCB.Enabled := true;
    Label27.Enabled := false;
    HintED.Enabled := false;
  end;
end;

procedure TNewStylesPropDlg.HintRG1Click(Sender: TObject);
begin
  if HintRG1.ItemIndex = 0 then
  begin
    Label28.Enabled := false;
    HintCB1.Enabled := false;
    HintCB1.Text := '';
    Label29.Enabled := true;
    HintED1.Enabled := true;
  end
  else
  begin
    Label28.Enabled := true;
    HintCB1.Enabled := true;
    Label29.Enabled := false;
    HintED1.Enabled := false;
  end;
end;

procedure TNewStylesPropDlg.UsePatternCBClick(Sender: TObject);
var i : integer;
  b : boolean;
begin
  PatternGB.Enabled := UsePatternCB.Checked;
  b := UsePatternCB.Checked;
  PatternGB.Enabled := b;
  if b then   HTMLCB.Checked := true;
  for i := 0 to PatternGB.ControlCount - 1 do
  begin
    PatternGB.Controls[i].Enabled := b;
  end;
end;

procedure TNewStylesPropDlg.SpeedButton1Click(Sender: TObject);
begin
  if PatternCB.Text <> '' then
    begin
      if PatternE.Text = '' then PatternE.Text := '<html>' ;
      PatternE.Text := PatternE.Text + '<a href="'+PatternCB.Text+'"></a> ';
    end;
end;

procedure TNewStylesPropDlg.SpeedButton2Click(Sender: TObject);
begin
  if PatternCB1.Text <> '' then
    begin
      if PatternE1.Text = '' then PatternE1.Text := '<html>';
      PatternE1.Text := PatternE1.Text + '<a href="'+PatternCB1.Text+'"></a> ';
    end;
end;

procedure TNewStylesPropDlg.UsePatternCB1Click(Sender: TObject);
var i : integer;
  b : boolean;
begin
  PatternGB1.Enabled := UsePatternCB1.Checked;
  b := UsePatternCB1.Checked;
  PatternGB1.Enabled := b;
  if b then HTMLCB1.Checked := true;
  for i := 0 to PatternGB1.ControlCount - 1 do
  begin
    PatternGB1.Controls[i].Enabled := b;
  end;
end;

procedure TNewStylesPropDlg.PageControl1ClosePageQuery(Sender: TObject;
  Page: TElTabSheet; var CanClose: Boolean);
var t : integer;
begin
  t := PageControl1.ActivePageIndex;
  CanClose := True;
  if t = 0 then
    begin
//      if IdentToColor(ColorCombo.Text, C) and IdentToColor(BkColorCombo.Text, C) then
//        CanClose := true
//      else
//        begin
//          MessageBox(Handle, 'Invalid color property', 'Error', mb_IconError or mb_Ok);
//          CanClose := false;
//          exit;
//        end;
      if ImagesGB.ItemIndex = 0 then
        begin
          try
            CanClose := true;
            StrToInt(IndexEdit.Text);
            StrToInt(StIndexEdit.Text);
          except
            MessageBox(Handle, 'Invalid image index property', 'Error', mb_IconError or mb_Ok);
            CanClose := false;
            exit;
          end;
        end;
    end
  else
    begin
//      if IdentToColor(ColorCombo1.Text, C) and IdentToColor(BkColorCombo1.Text, C) then
//        CanClose := true
//      else
//      begin
//        MessageBox(Handle, 'Invalid color property', 'Error', mb_IconError or mb_Ok);
//        CanClose := false;
//        exit;
//      end;
      if ImagesGB1.ItemIndex = 0 then
        begin
          try
            CanClose := true;
            StrToInt(IndexEdit1.Text);
            StrToInt(StIndexEdit1.Text);
          except
            MessageBox(Handle, 'Invalid image index property', 'Error', mb_IconError or mb_Ok);
            CanClose := false;
            exit;
          end;
        end;
      t := ListStyle.TabIndex + 1;
    end;
  if CanClose then SetData(t);
end;

procedure TNewStylesPropDlg.PageControl1Change(Sender: TObject);
var i, t : integer;
begin
  t := PageControl1.ActivePageIndex;
  if t = 0 then DStylesDefsItem := DStylesDefs.Items[t]
    else
      if DStylesDefs.Count>1 then
        begin
          DStylesDefsItem := DStylesDefs.Items[1];
          ListStyle.TabIndex := 0;
        end
      else DStylesDefsItem := nil;
  if t<>0 then
    begin
      CheckBoxCB1.Items.Clear;
      HintCB1.Items.Clear;
      ImageCB1.Items.Clear;
      Image2CB1.Items.Clear;
      StImageCB1.Items.Clear;
      StImage2CB1.Items.Clear;
      PatternCB1.Items.Clear;
      if (DStylesDefsItem <> nil) and (DStylesDefsItem.DataLink.DataSet <> nil) then
        begin
          for i := 0 to DStylesDefsItem.DataLink.DataSet.FieldCount-1 do
            begin
              PatternCB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
              if (DStylesDefsItem.DataLink.DataSet.Fields[i].DataType in [ftSmallint, ftInteger,ftWord, ftFloat]) then
              begin
                ImageCB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
                Image2CB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
                StImageCB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
                StImage2CB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
              end
              else
                if (DStylesDefsItem.DataLink.DataSet.Fields[i].DataType in [ftBoolean]) then
                  CheckBoxCB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName)
                else
                  HintCB1.Items.Add(DStylesDefsItem.DataLink.DataSet.Fields[i].FieldName);
            end;
        end;
    end;
  GetData(t);
end;

procedure TNewStylesPropDlg.PageControl1Changing(Sender: TObject;
  NewPage: TElTabSheet; var AllowChange: Boolean);
begin
  if (PageControl1.ActivePageIndex > -1) then
    SetData(PageControl1.ActivePageIndex);
end;

end.
