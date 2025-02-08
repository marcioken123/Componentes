unit pLMDTransparentEditorDlg;
{$I lmdcmps.inc}
interface

uses
  consts, Classes, Graphics, Forms, Controls, Dialogs,
  Buttons, StdCtrls, ExtCtrls,
  LMDClass, LMDGraph, LMDCont, LMDCustomColorComboBox, LMDBaseGraphicButton,
  LMDCustomSpeedButton, LMDBaseImage, LMDBaseLabel, LMDCustomSimpleLabel,
  LMDBaseGraphicControl, LMDGraphicControl, LMDDrawEdge, LMDFill,
  LMDSimpleLabel, LMDCustomNImage, LMDDockSpeedButton, LMDNImage,
  LMDColorComboBox, LMDCustomComponent, LMDCustomComboBox, LMDStringList,
  LMDBaseController, LMDCustomContainer, LMDThemedComboBox, LMDBaseControl,
  LMDThemes;

type
  TLMDTransparentEditorDlg = class(TForm)
    Bevel1: TBevel;
    Label5: TLabel;
    cmbc: TLMDColorComboBox;
    Label1: TLabel;
    cmb: TComboBox;
    LMDDrawEdge1: TLMDDrawEdge;
    lbl: TLMDSimpleLabel;
    LMDFill1: TLMDFill;
    test: TLMDNImage;
    dlgl: TLMDDockSpeedButton;
    strl: TLMDStringList;
    ok: TButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure cmbcChange(Sender: TObject);
    procedure dlglClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure cmbChange(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

implementation

uses TypInfo, SysUtils, lmdutils, pLMDCommon;

{$R *.DFM}

{********************* Class LMDBrushEditorDlg ********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDTransparentEditorDlg.FormCreate(Sender: TObject);
begin
  LMDComLoadDelphiCustomColor(cmbc.CustomColors);
  FShow:=False;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDTransparentEditorDlg.cmbcChange(Sender: TObject);
begin
  test.TransparentStyle.Color:=cmbc.SelectedColor;
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDTransparentEditorDlg.dlglClick(Sender: TObject);
begin
  cmbc.Execute;
end;

{------------------------------------------------------------------------------}
procedure TLMDTransparentEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LMDComSaveDelphiCustomColor(cmbc.CustomColors);
end;

{------------------------------------------------------------------------------}
procedure TLMDTransparentEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDTransparentEditorDlg.cmbChange(Sender: TObject);
begin
  test.TransparentStyle.Mode:=TLMDTransparentMode(cmb.Itemindex);
  if FShow then SetLabels;
 end;

{------------------------------------------------------------------------------}
Procedure TLMDTransparentEditorDlg.SetLabels;
begin
  With test.TransparentStyle do
    begin
      cmbc.SelectedColor:=Color;
      cmb.ItemIndex:=Ord(Mode);
      lbl.Caption:=strl[0].Items[Ord(Mode)];
    end;
end;

end.
 
