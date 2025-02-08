unit pLMDLightEditorDlg;
{$I lmdcmps.inc}
interface

uses
  Classes, Graphics, Forms, Controls, Dialogs, Buttons, StdCtrls, ExtCtrls,
  LMDCustomComponent, LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel,
  LMDBaseGraphicControl, LMDCustomLight, LMDLight, LMDGraph, LMDBaseControl;

const
  LMDLightColorStr:array[TLMDLightColor] of string = ('lcNone', 'lcBlue', 'lcRed',
                                     'lcGreen', 'lcYellow', 'lcMarine', 'lcPurple');
type
  TLMDLightEditorDlg = class(TForm)
    Bevel1: TBevel;
    test: TLMDLight;
    Label4: TLabel;
    pred: TComboBox;
    LMDSimpleLabel1: TLMDSimpleLabel;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure predChange(Sender: TObject);
    procedure testClick(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

implementation

uses SysUtils, LMDProcs;

{$R *.DFM}

{********************* Class TLMDLEDEditorDlg *********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDLightEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then
    begin
      FShow:=true;
      pred.ItemIndex:=Ord(test.LightColor);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDLightEditorDlg.FormCreate(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to Ord(High(LMDLightColorStr)) do
    pred.items.add(LMDLightColorStr[TLMDLightColor(i)]);
  FShow:=False;
end;

{------------------------------------------------------------------------------}
procedure TLMDLightEditorDlg.predChange(Sender: TObject);
begin
  if pred.ItemIndex<>-1 then
    begin
      test.LightColor:=TLMDLightColor(pred.ItemIndex);
      if FShow then SetLabels;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDLightEditorDlg.SetLabels;
begin
  pred.ItemIndex:=Ord(test.LightColor);
end;

procedure TLMDLightEditorDlg.testClick(Sender: TObject);
begin
  test.Active:= not test.Active;
end;

end.

