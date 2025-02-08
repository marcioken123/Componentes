unit pLMDBevelEditorDlg;
{$I lmdcmps.Inc}

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

pLMDBevelEditorDlg unit ()
--------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  Windows, Forms, LMDCustomComponent, LMDWndProcComponent, Classes, ExtCtrls,
  StdCtrls, ComCtrls, Controls, 
  LMDCustomButton, LMDButton, LMDCustomCheckBox, LMDCheckBox,
  LMDCustomGroupBox, LMDGroupBox, LMDButtonControl, LMDRadioButton,
  LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDCustomExtSpinEdit,
  LMDSpinEdit, LMDCustomComboBox, LMDCustomColorComboBox, LMDColorComboBox,
  LMDBaseGraphicButton, LMDCustomSpeedButton, LMDDockSpeedButton, LMDCustomControl, 
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDCustomPanelFill,
  LMDPanelFill,  LMDSimplePanel, LMDBaseGraphicControl,
  LMDControl, LMDBaseControl, LMDThemedComboBox, LMDThemes;
  type
  TLMDBevelEditorDlg = class(TForm)
    Bevel1: TBevel;
    nb: TPageControl;
    Label10: TLabel;
    cmbStandard: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    bt3: TLMDDockSpeedButton;
    bt2: TLMDDockSpeedButton;
    bt1: TLMDDockSpeedButton;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    cmb: TComboBox;
    cmb1: TComboBox;
    cmbs: TLMDColorComboBox;
    cmbb: TLMDColorComboBox;
    cmbL: TLMDColorComboBox;
    edbiw: TLMDSpinEdit;
    edbw: TLMDSpinEdit;
    edwi: TLMDSpinEdit;
    edwo: TLMDSpinEdit;
    LMDGroupBox1: TGroupBox;
    Label11: TLabel;
    cmbb2: TLMDColorComboBox;
    Label12: TLabel;
    edbiw2: TLMDSpinEdit;
    Label13: TLabel;
    cmbb3: TLMDColorComboBox;
    Label14: TLabel;
    edbiw3: TLMDSpinEdit;
    bt1_2: TLMDDockSpeedButton;
    bt1_3: TLMDDockSpeedButton;
    cmbEdge: TComboBox;
    Label15: TLabel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    tb4: TTabSheet;
    rbStandard: TRadioButton;
    rbCustom: TRadioButton;
    rbEdge: TRadioButton;
    rbWindow: TRadioButton;
    ok: TButton;
    Button1: TButton;
    reset: TButton;
    cbLeft: TCheckBox;
    cbTop: TCheckBox;
    cbRight: TCheckBox;
    cbBottom: TCheckBox;
    st: TStaticText;
    test: TLMDSimplePanel;
    procedure rbclick(Sender: TObject);
    procedure cbLeftClick(Sender: TObject);
    procedure cbTopClick(Sender: TObject);
    procedure cbRightClick(Sender: TObject);
    procedure cbBottomClick(Sender: TObject);
    procedure cmbbChange(Sender: TObject);
    procedure edbiwChange(Sender: TObject);
    procedure cmbStandardChange(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure cmb1Change(Sender: TObject);
    procedure bt1Click(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure cmbEdgeChange(Sender: TObject);
    procedure tb4Enter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    Procedure SetLabels;
  end;

implementation

uses
  LMDClass, LMDGraph, LMDUtils, LMDBevel;

{$R *.DFM}

procedure TLMDBevelEditorDlg.rbclick(Sender: TObject);
begin
  if Sender=rbStandard then
    test.Bevel.Mode := bmStandard;
  if Sender=rbCustom then
     test.Bevel.Mode := bmCustom;
  if Sender=rbWindow then
     test.Bevel.Mode := bmWindows;
  if Sender=rbEdge then
     test.Bevel.Mode := bmEdge;
  SetLabels;
end;

procedure TLMDBevelEditorDlg.cbLeftClick(Sender: TObject);
begin
  if cbLeft.checked then
    test.bevel.BorderSides := test.bevel.BorderSides + [fsLeft]
  else
    test.bevel.BorderSides := test.bevel.BorderSides - [fsLeft]
end;

procedure TLMDBevelEditorDlg.cbTopClick(Sender: TObject);
begin
  if cbTop.checked then
    test.bevel.BorderSides := test.bevel.BorderSides + [fsTop]
  else
    test.bevel.BorderSides := test.bevel.BorderSides - [fsTop]
end;

procedure TLMDBevelEditorDlg.cbRightClick(Sender: TObject);
begin
  if cbRight.checked then
    test.bevel.BorderSides := test.bevel.BorderSides + [fsRight]
  else
    test.bevel.BorderSides := test.bevel.BorderSides - [fsRight]
end;

procedure TLMDBevelEditorDlg.cbBottomClick(Sender: TObject);
begin
  if cbBottom.checked then
    test.bevel.BorderSides := test.bevel.BorderSides + [fsBottom]
  else
    test.bevel.BorderSides := test.bevel.BorderSides - [fsBottom]
end;

procedure TLMDBevelEditorDlg.cmbbChange(Sender: TObject);
begin
  with Test.Bevel do
    if sender=cmbb then BorderColor:=cmbb.SelectedColor
    else if sender=cmbb2 then BorderColor:=cmbb2.SelectedColor
    else if sender=cmbb3 then BorderColor:=cmbb3.SelectedColor
    else if sender=cmbl then LightColor:=cmbl.SelectedColor
    else if sender=cmbs then ShadowColor:=cmbs.SelectedColor;
  if Self.Visible then
    SetLabels;
end;

procedure TLMDBevelEditorDlg.edbiwChange(Sender: TObject);
begin
  with test.bevel do
    begin
      if sender=edbiw then Borderinnerwidth:=Trunc(edbiw.value)
      else if sender=edbiw2 then Borderinnerwidth:=Trunc(edbiw2.value)
      else if sender=edbiw3 then Borderinnerwidth:=Trunc(edbiw3.value)
      else if sender=edbw then BorderWidth:=Trunc(edbw.value)
      else if sender=edwi then widthInner:=Trunc(edwi.value)
      else if sender=edwo then widthOuter:=Trunc(edwo.value)
    end;
  if Self.Visible then
    SetLabels;
end;

procedure TLMDBevelEditorDlg.FormCreate(Sender: TObject);
begin
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);test.ThemeMode := ttmNone;{$ENDIF}
end;

procedure TLMDBevelEditorDlg.cmbStandardChange(Sender: TObject);
begin
  Test.Bevel.StandardStyle := TLMDBorderStyle(cmbStandard.Itemindex);
end;

procedure TLMDBevelEditorDlg.cmbChange(Sender: TObject);
begin
  Test.Bevel.StyleInner:=TLMDBevelStyle(cmb.Itemindex)
end;

procedure TLMDBevelEditorDlg.cmb1Change(Sender: TObject);
begin
  Test.Bevel.StyleOuter:=TLMDBevelStyle(cmb1.Itemindex)
end;

Procedure TLMDBevelEditorDlg.SetLabels;
begin
  With Test.Bevel do
    begin
      {Withs}
      edwo.value:=WidthOuter;
      edwi.value:=WidthInner;
      edbiw.value:=BorderInnerWidth;
      edbiw2.value:=BorderInnerWidth;
      edbiw3.value:=BorderInnerWidth;
      edbw.value:=BorderWidth;
      {Colors}
      cmbB.SelectedColor:=BorderColor;
      cmbb2.SelectedColor:=BorderColor;
      cmbb3.SelectedColor:=BorderColor;
      cmbl.SelectedColor:=LightColor;
      cmbs.SelectedColor:=ShadowColor;
      {Styles}
      cmb.ItemIndex:=Ord(StyleInner);
      cmb1.ItemIndex:=Ord(StyleOuter);
      cmbEdge.ItemIndex:=Ord(EdgeStyle);

      {Mode}
      rbStandard.Checked:=Mode=bmStandard;
      rbCustom.Checked:=Mode=bmCustom;
      rbEdge.Checked:=Mode=bmEdge;
      rbWindow.Checked:=Mode=bmWindows;

      {Sides}
      cbLeft.checked := fsLeft In BorderSides;
      cbRight.checked := fsRight In BorderSides;
      cbTop.checked := fsTop In BorderSides;
      cbBottom.checked := fsBottom In BorderSides;
      {StandardStyle}
      cmbStandard.ItemIndex:=Ord(StandardStyle);
    end;

end;

procedure TLMDBevelEditorDlg.bt1Click(Sender: TObject);
begin
  if sender=bt1 then cmbb.Execute
  else if sender=bt1_2 then cmbL.ExecuteEnh(cmbb.CustomColors)
  else if sender=bt1_3 then cmbL.ExecuteEnh(cmbb.CustomColors)
  else if sender=bt2 then cmbL.ExecuteEnh(cmbb.CustomColors)
  else if sender=bt3 then cmbs.ExecuteEnh(cmbb.CustomColors)
end;

procedure TLMDBevelEditorDlg.resetClick(Sender: TObject);
var
  b : TLMDBevel;
begin
  b:=TLMDBevel.Create;
  test.bevel.assign(b);
  b.free;
  SetLabels;
end;

procedure TLMDBevelEditorDlg.cmbEdgeChange(Sender: TObject);
begin
  Test.Bevel.EdgeStyle:=TLMDEdgeStyle(cmbEdge.Itemindex)
end;

procedure TLMDBevelEditorDlg.tb4Enter(Sender: TObject);
begin
  st.setfocus;
end;

end.
