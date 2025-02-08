unit pLMDGradientEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Classes, Forms, Dialogs, LMDCustomComponent, LMDWndProcComponent,
  LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, StdCtrls,
  LMDCustomButton, LMDButton, LMDCustomListBox, LMDCustomImageListBox,
  LMDCustomComboBox, LMDColorListBox, LMDClass,
  LMDCustomColorComboBox, LMDColorComboBox, Controls, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit,
  LMDCustomMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit, LMDDrawEdge,
  LMDSpeedButton, LMDBaseGraphicButton, LMDCustomSpeedButton,
  LMDDockSpeedButton, LMDBaseGraphicControl,
  LMDGraphicControl, LMDFill, ExtCtrls, LMDCustomColorListBox, LMDControl,
  LMDBaseControl, LMDThemes, LMDThemedComboBox;

type
  TLMDGradientEditorDlg = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label3: TLabel;
    edbiw: TLMDSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    direct: TComboBox;
    cmbb: TLMDColorComboBox;
    cmbL: TLMDColorComboBox;
    test: TLMDFill;
    bt1: TLMDDockSpeedButton;
    bt2: TLMDDockSpeedButton;
    ext_std: TLMDSpeedButton;
    LMDDrawEdge1: TLMDDrawEdge;
    clb: TLMDColorListBox;
    addBtn: TLMDSpeedButton;
    delBtn: TLMDSpeedButton;
    cd: TColorDialog;
    ok: TButton;
    cancel: TButton;
    reset: TButton;
    chk: TCheckBox;
    sepBtn: TLMDSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure edchange(Sender: TObject);
    procedure cmbc(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chkClick(Sender: TObject);
    procedure directChange(Sender: TObject);
    procedure btn(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ext_stdClick(Sender: TObject);
    procedure clbClick(Sender: TObject);
    procedure delBtnClick(Sender: TObject);
    procedure addBtnClick(Sender: TObject);
    procedure sepBtnClick(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
    procedure ActivateExt;
    procedure ActivateStd;
  end;

implementation

uses TypInfo, SysUtils, LMDUtils, LMDGradient, LMDGraph, Graphics, pLMDCommon;
{$R *.DFM}

{********************* Class TGradientEditorDlg *******************************}
{------------------------- Private---------------------------------------------}
procedure TLMDGradientEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradientEditorDlg.FormCreate(Sender: TObject);
begin
  LMDComLoadDelphiCustomColor(cmbb.CustomColors);
  FShow:=False;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}  
end;

{------------------------------------------------------------------------------}
procedure TLMDGradientEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LMDComSaveDelphiCustomColor(cmbb.CustomColors);
end;

{------------------------------------------------------------------------------}
procedure TLMDGradientEditorDlg.btn(Sender: TObject);
begin
  if sender=bt1 then cmbb.Execute
  else if sender=bt2 then cmbL.ExecuteEnh(cmbb.CustomColors)
end;

{------------------------------------------------------------------------------}
procedure TLMDGradientEditorDlg.chkClick(Sender: TObject);
begin
  Test.FillObject.Gradient.PaletteRealize:=chk.Checked;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradientEditorDlg.cmbc(Sender: TObject);
begin
  with test.FillObject.Gradient do
    if sender=cmbb then Color:=cmbb.SelectedColor
    else if sender=cmbl then EndColor:=cmbl.SelectedColor;
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradientEditorDlg.directChange(Sender: TObject);
begin
  Test.FillObject.Gradient.Style:=TLMDGradientStyle(direct.Itemindex);
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradientEditorDlg.edchange(Sender: TObject);
begin
  Test.FillObject.Gradient.Colorcount:=Trunc(edbiw.value);
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradientEditorDlg.resetClick(Sender: TObject);
var
  b:TLMDGradient;

begin
  b:=TLMDGradient.Create;
  test.FillObject.Gradient:=b;
  b.free;
  test.Bevel.Styleouter:=bvLowered;
  SetLabels;
end;

procedure TLMDGradientEditorDlg.sepBtnClick(Sender: TObject);
begin
  clb.Items.Add('-');
  clbClick(nil);
end;

{------------------------------------------------------------------------------}
Procedure TLMDGradientEditorDlg.SetLabels;
var
  i : Integer;
begin
  With Test.FillObject.Gradient do
    begin
      {Withs}
      edbiw.value:=ColorCount;
      {Colors}
      cmbb.SelectedColor:=Color;
      cmbL.SelectedColor:=EndColor;
      {PaletteRealize}
      chk.checked:=PaletteRealize;
      {Direction}
      direct.Itemindex:=Ord(Style);

      if TwoColors then
        ActivateStd
      else
        ActivateExt;

      clb.Clear;
      for i := 0 to Test.FillObject.Gradient.Colors.Count - 1 do
        clb.Items.Add(ColorToString(Longint(Test.FillObject.Gradient.Colors[i])));
    end;
end;

procedure TLMDGradientEditorDlg.ext_stdClick(Sender: TObject);
begin
  if ext_std.Caption = 'Ext >>' then
    ActivateExt
  else
    ActivateStd;
  Test.FillObject.Gradient.TwoColors := (ext_std.Caption = 'Ext >>');
end;

procedure TLMDGradientEditorDlg.clbClick(Sender: TObject);
var
  i : Integer;
begin
  Test.FillObject.Gradient.Colors.Clear;
  for i := 0 to clb.Items.Count - 1 do
    Test.FillObject.Gradient.Colors.Add(TObject(clb.Colors[i]));
  Test.FillObject.Gradient.InitPalette;
end;

procedure TLMDGradientEditorDlg.delBtnClick(Sender: TObject);
begin
  clb.Items.Delete (clb.ItemIndex);
  clbClick (nil);
end;

procedure TLMDGradientEditorDlg.addBtnClick(Sender: TObject);
begin
  if cd.Execute then
  begin
    clb.Items.Add (ColorToString (cd.Color));
    clbClick (nil);
  end;
end;

procedure TLMDGradientEditorDlg.ActivateStd;
begin
  ext_std.Caption := 'Ext >>';
  cmbb.Visible := true;
  cmbl.Visible := true;
  bt1.Visible := true;
  bt2.Visible := true;

  clb.Visible := false;
  delBtn.Visible := false;
  addBtn.Visible := false;
  sepBtn.Visible := false;
end;

procedure TLMDGradientEditorDlg.ActivateExt;
begin
  ext_std.Caption := 'Std >>';
  cmbb.Visible := false;
  cmbl.Visible := false;
  bt1.Visible := false;
  bt2.Visible := false;

  clb.Visible := true;
  delBtn.Visible := true;
  addBtn.Visible := true;
  sepBtn.Visible := true;
end;

end.

