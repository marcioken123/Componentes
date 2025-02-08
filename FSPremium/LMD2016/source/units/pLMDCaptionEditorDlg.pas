unit pLMDCaptionEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Classes, Graphics, Forms, Controls, Dialogs, Buttons, StdCtrls, ExtCtrls, Tabs,
  LMDClass, LMDBaseGraphicControl, LMDBaseShape, LMDShapeControl,
  LMDCustomComponent, LMDCustomControl, LMDCustomPanel, LMDButtonControl,
  LMDCustomCheckBox, LMDCheckBox, LMDCustomButton, LMDButton, LMDControl,
  LMDBaseControl, LMDThemes;

type

  TLMDCaptionEditorDlg = class(TForm)
    Bevel2: TBevel;
    Label1: TLabel;
    cmb: TComboBox;
    test: TLMDShapeControl;
    Label2: TLabel;
    cap: TEdit;
    ok: TLMDButton;
    Button1: TLMDButton;
    reset: TLMDButton;
    chk: TLMDCheckBox;
    btnf: TLMDButton;
    btnffx: TLMDButton;
    procedure FormCreate(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btncClick(Sender: TObject);
    procedure chkClick(Sender: TObject);
    procedure capChange(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

 implementation
uses
  TypInfo, SysUtils, LMDGraph, LMDProcs, pLMDCPGetMain, pLMDCPGetCore, LMDCaption;

{$R *.DFM}
{********************* Class TFxEditorDlg *************************************}
{------------------------- Private---------------------------------------------}
procedure TLMDCaptionEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionEditorDlg.FormCreate(Sender: TObject);
begin
  chk.Checked:=test.Caption.MultiLine;
  FShow:=False;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionEditorDlg.cmbChange(Sender: TObject);
begin
  test.Caption.Alignment:=TLMDAlignment(cmb.Itemindex);
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionEditorDlg.resetClick(Sender: TObject);
var
  b:TLMDCaption;
begin
  b:=TLMDCaption.Create;
  {save Positions}
  test.Caption.Assign(b);
  b.free;
  SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionEditorDlg.SetLabels;
begin
  With Test.Caption do
    begin
      cap.Text:=Caption;
      {Bool}
      chk.Checked:=MultiLine;
      {Alignment}
      cmb.ItemIndex:=Ord(Alignment);
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionEditorDlg.btncClick(Sender: TObject);
begin
  if sender=btnf then
    LMDCPGetFont(test.caption.Font)
  else if sender=btnffx then
    LMDCPGetFontFX(test.caption.FontFX);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionEditorDlg.chkClick(Sender: TObject);
begin
  test.caption.multiline:=chk.Checked;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionEditorDlg.capChange(Sender: TObject);
begin
  test.Caption.Caption:=cap.Text;
end;

end.

 
