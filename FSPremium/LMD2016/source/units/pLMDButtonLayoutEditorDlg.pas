unit pLMDButtonLayoutEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Windows, Forms, StdCtrls, Classes, ExtCtrls, ComCtrls, Controls, 
  LMDCustomComponent, LMDWndProcComponent, LMDCustomButton, LMDButton, 
  LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, LMDCustomComboBox, 
  LMDButtonBase, LMDCustomColorComboBox, LMDColorComboBox, LMDClass,
  LMDDockSpeedButton, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, 
  LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDCustomExtSpinEdit, 
  LMDSpinEdit, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel,
  LMDSimpleLabel, LMDBaseGraphicButton, LMDCustomSpeedButton, LMDSpeedButton, 
  LMDControl, LMDBaseControl, LMDThemedComboBox, LMDThemes;

type
  TLMDButtonLayoutEditorDlg = class(TForm)
    Bevel1: TBevel;
    test: TLMDSpeedButton;
    nb: TPageControl;
    Label7: TLabel;
    Label8: TLabel;
    Label3: TLabel;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    spc: TLMDSpinEdit;
    cmb2: TComboBox;
    cmb: TComboBox;
    LMDDockSpeedButton1: TLMDDockSpeedButton;
    Label4: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    LMDDockSpeedButton2: TLMDDockSpeedButton;
    acmb: TLMDColorComboBox;
    ari: TLMDSpinEdit;
    ars: TLMDSpinEdit;
    LMDSimpleLabel4: TLMDSimpleLabel;
    Label2: TLabel;
    ap: TComboBox;
    capX: TLMDSpinEdit;
    Label5: TLabel;
    capY: TLMDSpinEdit;
    Label6: TLabel;
    LMDSimpleLabel5: TLMDSimpleLabel;
    LMDSimpleLabel6: TLMDSimpleLabel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    ok: TLMDButton;
    cancel: TLMDButton;
    reset: TLMDButton;
    chk: TLMDCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure edchange(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chkClick(Sender: TObject);
    procedure btn(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acmbChange(Sender: TObject);
    procedure cmbChange(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

implementation

uses 
  SysUtils, 
  LMDUtils, LMDGraph, LMDButtonLayout, pLMDCommon, pLMDCPGetCore;

{$R *.DFM}

{********************* Class TLMDButtonLayoutEditorDlg ************************}
{------------------------- Private---------------------------------------------}
procedure TLMDButtonLayoutEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonLayoutEditorDlg.FormCreate(Sender: TObject);
begin
  LMDComLoadDelphiCustomColor(acmb.CustomColors);
  FShow:=False;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);test.CtlXP:=false;{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonLayoutEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LMDComSaveDelphiCustomColor(acmb.CustomColors);
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonLayoutEditorDlg.btn(Sender: TObject);
begin
  acmb.Execute;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonLayoutEditorDlg.chkClick(Sender: TObject);
begin
  test.ButtonLayout.Arrow:=chk.Checked;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonLayoutEditorDlg.edchange(Sender: TObject);
begin
  with test.ButtonLayout do
    if sender=spc then Spacing:=Trunc(spc.value)
    else if sender=ari then ArrowIndent:=Trunc(ari.value)
    else if sender=ars then ArrowSize:=Trunc(ars.value)
    else if sender=capX then OffsetX:=Trunc(capX.value)
    else if sender=capY then OffsetY:=Trunc(capY.value);
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonLayoutEditorDlg.resetClick(Sender: TObject);
var
  b:TLMDButtonLayout;
begin
  b:=TLMDButtonLayout.Create;
  try
    test.ButtonLayout.Assign(b);
    SetLabels;
  finally
    b.Free;
  end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDButtonLayoutEditorDlg.SetLabels;
begin
  With Test.ButtonLayout do
    begin
      {Sizes}
      ari.Value:=ArrowIndent;
      ars.Value:=ArrowSize;
      spc.Value:=Spacing;
      capX.Value:=OffsetX;
      capY.Value:=OffsetY;
      {Colors}
      acmb.SelectedColor:=ArrowColor;
      {show Arrow?}
      chk.checked:=Arrow;

      {Alignment}
      cmb.ItemIndex:=Ord(Alignment);
      cmb2.ItemIndex:=Ord(AlignText2Glyph);
      ap.ItemIndex:=Ord(ArrowPosition);
    end;

end;

procedure TLMDButtonLayoutEditorDlg.acmbChange(Sender: TObject);
begin
  test.ButtonLayout.ArrowColor:=acmb.SelectedColor;
  if not FShow then SetLabels;
end;

procedure TLMDButtonLayoutEditorDlg.cmbChange(Sender: TObject);
begin
  with test.ButtonLayout do
    if sender=cmb then Alignment:=TLMDAlignment(Ord(cmb.ItemIndex))
    else if sender=cmb2 then AlignText2Glyph:=TLMDTextArrange(ord(cmb2.ItemIndex))
    else if sender=ap then ArrowPosition:=TLMDArrowPosition(Ord(ap.ItemIndex));

end;

end.

