unit pLMDPointListEditorDlg;
{$I lmdcmps.inc}
interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  LMDPointList, LMDCustomComponent, LMDThemes, LMDClass,
  LMDCustomButton, LMDButton, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit,
  LMDCustomExtSpinEdit, LMDSpinEdit, LMDCustomScrollBox, LMDListBox, LMDControl;

type
  TfrmTLMDPointListEditor = class(TForm)
    plb: TLMDListBox;
    XVal: TLMDSpinEdit;
    YVal: TLMDSpinEdit;
    LMDButton1: TLMDButton;
    LMDButton2: TLMDButton;
    LMDButton3: TLMDButton;
    LMDButton4: TLMDButton;
    LMDButton5: TLMDButton;
    LMDButton6: TLMDButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LMDButton1Click(Sender: TObject);
    procedure LMDButton2Click(Sender: TObject);
    procedure LMDButton5Click(Sender: TObject);
    procedure LMDButton6Click(Sender: TObject);
    procedure plbClick(Sender: TObject);
    procedure XValExit(Sender: TObject);
    procedure YValExit(Sender: TObject);
  private
    FPointList : TLMDPointList;
  public
    procedure SetPointList (aValue : TLMDPointList);
    procedure GetPointList (aValue : TLMDPointList);    
  end;

implementation

uses
  Types, SysUtils;

{$R *.DFM}

procedure TfrmTLMDPointListEditor.SetPointList (aValue : TLMDPointList);
var
  i : Integer;
begin
  FPointList.Clear;
  for i := 0 to aValue.Count - 1 do
    begin
      FPointList.AddPoint (aValue.Points[i]);
      plb.Items.Add (IntToStr(aValue.Points[i].X)+';'+IntToStr(aValue.Points[i].Y)+';');
    end;
end;

procedure TfrmTLMDPointListEditor.GetPointList (aValue : TLMDPointList);
var
  i : Integer;
begin
  aValue.Clear;
  for i := 0 to FPointList.Count - 1 do
    aValue.AddPoint (FPointList.Points[i]);
end;

procedure TfrmTLMDPointListEditor.FormCreate(Sender: TObject);
begin
  FPointList := TLMDPointList.Create;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

procedure TfrmTLMDPointListEditor.FormDestroy(Sender: TObject);
begin
  FPointList.Free;
end;

procedure TfrmTLMDPointListEditor.LMDButton1Click(Sender: TObject);
begin
  FPointList.AddPoint (Point(0, 0));
  plb.Items.Add ('0;0;');
  plb.ItemIndex := plb.Items.Count - 1;
end;

procedure TfrmTLMDPointListEditor.LMDButton2Click(Sender: TObject);
begin
  if plb.ItemIndex = -1 then exit;
  FPointList.Delete (plb.ItemIndex);
  plb.Items.Delete (plb.ItemIndex);
end;

procedure TfrmTLMDPointListEditor.LMDButton5Click(Sender: TObject);
var
  p : TPoint;
begin
  if plb.ItemIndex <= 0 then exit; //0, -1
  p := FPointList.Points [plb.ItemIndex-1];
  FPointList.Points [plb.ItemIndex-1] := FPointList.Points [plb.ItemIndex];
  FPointList.Points [plb.ItemIndex] := p;
  plb.Items.Exchange (plb.ItemIndex - 1, plb.ItemIndex);
end;

procedure TfrmTLMDPointListEditor.LMDButton6Click(Sender: TObject);
var
  p : TPoint;
begin
  if plb.ItemIndex = -1 then exit;
  if plb.ItemIndex + 1 = plb.Items.Count then exit;
  p := FPointList.Points [plb.ItemIndex];
  FPointList.Points [plb.ItemIndex] := FPointList.Points [plb.ItemIndex+1];
  FPointList.Points [plb.ItemIndex+1] := p;
  plb.Items.Exchange (plb.ItemIndex + 1, plb.ItemIndex);
end;

procedure TfrmTLMDPointListEditor.plbClick(Sender: TObject);
begin
  if plb.ItemIndex = -1 then exit;
  XVal.Value := FPointList.Points[plb.ItemIndex].X;
  YVal.Value := FPointList.Points[plb.ItemIndex].Y;
end;

procedure TfrmTLMDPointListEditor.XValExit(Sender: TObject);
begin
  FPointList.PutPoint (plb.ItemIndex,Point (XVal.AsInteger, FPointList.Points[plb.ItemIndex].Y));
  plb.SetItemPart (plb.ItemIndex, 0, IntToStr (XVal.AsInteger));
end;

procedure TfrmTLMDPointListEditor.YValExit(Sender: TObject);
begin
  FPointList.PutPoint (plb.ItemIndex,Point (FPointList.Points[plb.ItemIndex].X, YVal.AsInteger));
  plb.SetItemPart (plb.ItemIndex, 1, IntToStr (YVal.AsInteger));
end;

end.
