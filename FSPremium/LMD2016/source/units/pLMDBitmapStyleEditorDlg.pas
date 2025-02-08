unit pLMDBitmapStyleEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Classes, Graphics, Forms, Controls, Dialogs, Buttons, StdCtrls, ExtCtrls,
  LMDClass, LMDGraph, LMDBaseGraphicControl, LMDGraphicControl, LMDBaseImage,
  LMDWndProcComponent, LMDNImage, LMDCustomNImage, LMDCustomComponent,
  LMDBaseControl, LMDComboBox, LMDThemedComboBox, LMDCustomComboBox;

type
  TLMDBitmapStyleEditorDlg = class(TForm)
    Bevel1: TBevel;
    Label4: TLabel;
    pred: TLMDComboBox;
    test: TLMDNImage;
    ok: TButton;
    cancel: TButton;
    procedure predChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    Procedure SetLabels;
  end;

implementation

uses 
  SysUtils, 
  LMDThemes, LMDUtils;

{$R *.DFM}
{********************* Class TLMDBitmapStyleEditorDlg *************************}
{------------------------- Private---------------------------------------------}
procedure TLMDBitmapStyleEditorDlg.FormCreate(Sender: TObject);
begin
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDBitmapStyleEditorDlg.predChange(Sender: TObject);
begin
  if pred.ItemIndex<>-1 then
    with Test do
      begin
        Style:=TLMDBitmapStyle(pred.ItemIndex);
        if Style<>sbAutoSize then
          begin Width:=250; Height:=180 end;
      end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDBitmapStyleEditorDlg.SetLabels;
begin
   pred.ItemIndex:=Ord(test.Style);
end;

end.

 
