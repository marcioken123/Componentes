unit pLMDFontFXEditorDlg;
{$I lmdcmps.inc}

interface

uses
  classes, Graphics, Forms, Controls, Dialogs,
  Buttons, StdCtrls, ExtCtrls, Tabs, ComCtrls,
  LMDClass, LMDButton, LMDCustomButton, LMDDockButton, LMDCustomComboBox,
  LMDCustomColorComboBox, LMDColorComboBox, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit,
  LMDCustomMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit, 
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomLabel, LMDLabel,
  LMDControl, LMDBaseControl, LMDThemes, LMDThemedComboBox;

type
  TLMDFxEditorDlg = class(TForm)
    nb: TPageControl;
    Label1: TLabel;
    cmb: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    test: TLMDLabel;
    Label3: TLabel;
    lidepth: TLMDSpinEdit;
    rt: TLabel;
    anglev: TLMDSpinEdit;
    Label2: TLabel;
    cmbL: TLMDColorComboBox;
    cmbs: TLMDColorComboBox;
    Label4: TLabel;
    shDepth: TLMDSpinEdit;
    trac: TLMDSpinEdit;
    Label7: TLabel;
    dlgl: TLMDDockButton;
    dlgs: TLMDDockButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ok: TButton;
    Button1: TButton;
    reset: TButton;
    procedure FormCreate(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure edchange(Sender: TObject);
    procedure cmbc(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dlgsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

 implementation
uses
  TypInfo, SysUtils, lmdgraph, lmdutils, LMDFXCaption, pLMDCommon;

{$R *.DFM}
{********************* Class TFxEditorDlg *************************************}
{------------------------- Private---------------------------------------------}
procedure TLMDFxEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDFxEditorDlg.FormCreate(Sender: TObject);
begin
  LMDComLoadDelphiCustomColor(cmbL.CustomColors);
  FShow:=False;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDFxEditorDlg.cmbChange(Sender: TObject);
begin
  test.fontfx.Style:=TLMDThreeDStyle(cmb.Itemindex);
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDFxEditorDlg.cmbc(Sender: TObject);
begin
  with test.fontfx do
    if sender=cmbl then
      LightColor:=cmbl.SelectedColor
    else if sender=cmbs then
      ShadowColor:=cmbs.SelectedColor;
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDFxEditorDlg.dlgsclick(Sender: TObject);
begin
  if sender=dlgl then
    cmbl.Execute
  else
    cmbs.ExecuteEnh(cmbl.CustomColors);
end;

{------------------------------------------------------------------------------}
procedure TLMDFxEditorDlg.edchange(Sender: TObject);
begin
  with test.fontfx do
    begin
      if sender=anglev then
        begin
          if anglev.value=360 then anglev.value:=0;
          Angle:=Trunc(anglev.value);
        end
      else
        if sender=lidepth then
          LightDepth:=Trunc(lidepth.value)
        else
          if sender=shDepth then
            ShadowDepth:=Trunc(shdepth.value)
          else
            if sender=trac then
              Tracing:=Trunc(trac.value);
    end;
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDFxEditorDlg.resetClick(Sender: TObject);
var
  b:TLMDFxCaption;
begin
  b:=TLMDFxCaption.Create;
  {save Positions}
  test.FontFx:=b;
  b.free;
  SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDFxEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LMDComSaveDelphiCustomColor(cmbL.CustomColors);
end;

{------------------------------------------------------------------------------}
Procedure TLMDFxEditorDlg.SetLabels;
begin
  With Test.FontFx do
    begin
      {Tracing}
      trac.value:=Tracing;
      {Widths}
      if anglev.Visible then anglev.Value:=angle;
      liDepth.value:=LightDepth;
      shDepth.value:=ShadowDepth;
      {Colors}
      cmbl.SelectedColor:=LightColor;
      cmbs.SelectedColor:=ShadowColor;
      {Styles}
      cmb.ItemIndex:=Ord(Style);
    end;

end;

end.

 
