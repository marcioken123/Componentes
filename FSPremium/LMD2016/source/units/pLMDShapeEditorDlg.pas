unit pLMDShapeEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Classes, Graphics, Forms, Controls, Dialogs,
  Buttons, StdCtrls, ExtCtrls, 
  LMDClass, LMDBaseGraphicControl, LMDBaseShape, 
  LMDShapeControl, LMDCustomComponent, LMDWndProcComponent,
  LMDFormStyler, LMDBaseControl;

type
  TLMDShapeEditorDlg = class(TForm)
    Bevel1: TBevel;
    Label4: TLabel;
    pred: TComboBox;
    test: TLMDShapeControl;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure predChange(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

implementation

uses SysUtils, LMDProcs, LMDShape;

{$R *.DFM}

{********************* Class TLMDLEDEditorDlg *********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDShapeEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then
    begin
      FShow:=true;
      pred.ItemIndex:=Ord(test.Shape);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeEditorDlg.FormCreate(Sender: TObject);
{var
  i:Integer;}
begin
{  for i:=0 to Ord(High(stylenames)) do
    pred.items.add(styleNames[TLMDShapeType(i)]);}
  FShow:=False;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeEditorDlg.predChange(Sender: TObject);
begin
  if pred.ItemIndex<>-1 then
    begin
      test.Shape:=TLMDShapeType(pred.ItemIndex);
      if FShow then SetLabels;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDShapeEditorDlg.SetLabels;
begin
  pred.ItemIndex:=Ord(test.Shape);
end;

end.

 
