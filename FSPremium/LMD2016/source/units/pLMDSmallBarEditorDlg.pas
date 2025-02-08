unit pLMDSmallBarEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Classes, Graphics, Forms, Controls, Dialogs, Buttons, StdCtrls, ExtCtrls, Tabs,
  LMDBaseGraphicControl, LMDGraphicControl, LMDProgress, LMDCustomColorComboBox,
  LMDBaseGraphicButton, LMDCustomSpeedButton, LMDBaseMeter, LMDCustomProgress,
  LMDClass, LMDWndProcComponent, LMDDockSpeedButton, LMDColorComboBox,
  LMDCustomComponent, LMDCustomComboBox, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit,
  LMDCustomExtSpinEdit, LMDSpinEdit, LMDControl, LMDThemedComboBox, LMDBaseControl,
  LMDThemes;

type

  TLMDSmallBarEditorDlg = class(TForm)
    Bevel1: TBevel;
    cmbb: TLMDColorComboBox;
    Label1: TLabel;
    spinc: TLMDSpinEdit;
    spinh: TLMDSpinEdit;
    spinv: TLMDSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    chk: TCheckBox;
    test: TLMDProgress;
    ok: TButton;
    Button1: TButton;
    reset: TButton;
    dlgb: TLMDDockSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dlgbClick(Sender: TObject);
    procedure chkClick(Sender: TObject);
    procedure spincChange(Sender: TObject);
    procedure cmbbChange(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

 implementation
uses
  TypInfo, SysUtils, lmdgraph, lmdutils, LMDSmallBar, pLMDCommon;

{$R *.DFM}

{********************* Class TFxEditorDlg *************************************}
{------------------------- Private---------------------------------------------}
procedure TLMDSmallBarEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDSmallBarEditorDlg.FormCreate(Sender: TObject);
begin
  LMDComLoadDelphiCustomColor(cmbb.CustomColors);
  FShow:=False;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
  test.CtlXP:=false;
end;

{------------------------------------------------------------------------------}
procedure TLMDSmallBarEditorDlg.resetClick(Sender: TObject);
var
  b:TLMDSmallBar;
begin
  b:=TLMDSmallBar.Create;
  try
    test.SmallBar:=b;
  finally
    b.free;
  end;
  SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDSmallBarEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LMDComSaveDelphiCustomColor(cmbb.CustomColors);
end;

{------------------------------------------------------------------------------}
Procedure TLMDSmallBarEditorDlg.SetLabels;
begin
  With Test.SmallBar do
    begin
      {Colors}
      cmbb.SelectedColor:=BarColor;
      {Integers}
      spinc.value:=BarCount;
      spinh.value:=HSpace;
      spinv.value:=VSpace;
      {Booleans}
      chk.checked:=Autosize;
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDSmallBarEditorDlg.dlgbClick(Sender: TObject);
begin
  cmbb.Execute;
end;

{------------------------------------------------------------------------------}
procedure TLMDSmallBarEditorDlg.chkClick(Sender: TObject);
begin
  test.SmallBar.Autosize:=chk.checked;
end;

{------------------------------------------------------------------------------}
procedure TLMDSmallBarEditorDlg.spincChange(Sender: TObject);
begin
  with test.Smallbar do
    if sender=spinc then
      test.smallbar.barcount:=spinc.AsInteger
    else if sender=spinh then
      test.smallbar.hspace:=spinh.AsInteger
    else if sender=spinv then
      test.smallbar.vspace:=spinv.AsInteger;
end;

{------------------------------------------------------------------------------}
procedure TLMDSmallBarEditorDlg.cmbbChange(Sender: TObject);
begin
  test.smallbar.barcolor:=cmbb.selectedcolor;
end;

end.

 
