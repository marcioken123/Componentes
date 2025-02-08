unit pLMDShadowEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Classes, Graphics, Forms, Controls, Dialogs,
  Buttons, StdCtrls, ExtCtrls,  Tabs,
  LMDClass, LMDCustomColorComboBox, LMDBaseGraphicButton, LMDCustomSpeedButton,
  LMDBaseGraphicControl, LMDBaseShape, LMDThemes,
  LMDDockSpeedButton, LMDColorComboBox, LMDShapeControl,
  LMDCustomComponent, LMDCustomComboBox, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit,
  LMDCustomMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit, LMDControl,
  LMDThemedComboBox, LMDBaseControl;

type

  TLMDShadowEditorDlg = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    test: TLMDShapeControl;
    cmbstyle: TComboBox;
    Label1: TLabel;
    Label3: TLabel;
    cmbS: TLMDColorComboBox;
    Label4: TLabel;
    spind: TLMDSpinEdit;
    Label5: TLabel;
    dlgl: TLMDDockSpeedButton;
    ok: TButton;
    Button1: TButton;
    reset: TButton;
    procedure resetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cmbc(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure cmbSChange(Sender: TObject);
    procedure spindChange(Sender: TObject);
    procedure dlglClick(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

implementation
uses
  TypInfo, SysUtils, LMDGraph, LMDProcs, LMDShadow, pLMDCommon;

{$R *.DFM}

{********************* Class TLMDShadowEditorDlg ***************************}
{------------------------- Private---------------------------------------------}
procedure TLMDShadowEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDShadowEditorDlg.FormCreate(Sender: TObject);
begin
  LMDComLoadDelphiCustomColor(cmbS.CustomColors);
  FShow:=False;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDShadowEditorDlg.cmbChange(Sender: TObject);
begin
  with test.Shadow do
    if Sender=cmbstyle then
      Style:=TLMDShadowStyle(cmbstyle.Itemindex);

  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDShadowEditorDlg.cmbc(Sender: TObject);
begin
  with test.Shadow do
    if sender=cmbS then
      Color:=cmbS.SelectedColor;
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDShadowEditorDlg.resetClick(Sender: TObject);
var
  b:TLMDShadow;
begin
  b:=TLMDShadow.Create;
  test.Shadow.Assign(b);
  b.Free;
  SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDShadowEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LMDComSaveDelphiCustomColor(cmbS.CustomColors);
end;

{------------------------------------------------------------------------------}
Procedure TLMDShadowEditorDlg.SetLabels;
begin
  With Test.Shadow do
    begin
      {Style}
      cmbstyle.ItemIndex:=Ord(Style);
      {Color}
      cmbS.SelectedColor:=Color;
      {Depth}
      spind.Value:=Depth;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShadowEditorDlg.cmbSChange(Sender: TObject);
begin
  test.Shadow.Color:=cmbS.SelectedColor;
  If FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDShadowEditorDlg.spindChange(Sender: TObject);
begin
  test.Shadow.Depth:=TLMDShadowDepth(spind.AsInteger);
  If FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDShadowEditorDlg.dlglClick(Sender: TObject);
begin
  cmbs.Execute;
end;

end.

 
