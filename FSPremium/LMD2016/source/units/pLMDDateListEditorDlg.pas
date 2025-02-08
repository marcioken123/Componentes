unit pLMDDateListEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, 
  LMDClass, LMDDateL, LMDEdit, LMDButton, LMDListBox, LMDThemes,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomButton, LMDCustomScrollBox,
  LMDCustomComponent, LMDCustomControl, LMDBaseEdit, LMDCustomEdit, LMDControl;

type
  TLMDDateListEditorDlg = class(TForm)
    DList: TLMDListBox;
    OkBtn: TButton;
    CancelBtn: TButton;
    AddBtn: TButton;
    DelBtn: TButton;
    UpBtn: TButton;
    DnButn: TButton;
    DateEdit: TDateTimePicker;
    TimeEdit: TDateTimePicker;
    Des: TLMDEdit;
    procedure AddBtnClick(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure DnButnClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DListClick(Sender: TObject);
    procedure DesTextChangedAt(sender: TObject; At: Integer);
    procedure DateEditChange(Sender: TObject);
    procedure TimeEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

implementation

{$R *.DFM}

procedure TLMDDateListEditorDlg.AddBtnClick(Sender: TObject);
begin
  DList.Items.Add (DateToStr (Date)+';'+TimetoStr(Time)+';'+'-');
end;

procedure TLMDDateListEditorDlg.OkBtnClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TLMDDateListEditorDlg.CancelBtnClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TLMDDateListEditorDlg.DelBtnClick(Sender: TObject);
begin
  DList.Items.Delete (DList.ItemIndex);
end;

procedure TLMDDateListEditorDlg.DnButnClick(Sender: TObject);
begin
  if DList.ItemIndex < DList.Items.Count-1 then
  DList.ItemIndex := DList.ItemIndex + 1;
end;

procedure TLMDDateListEditorDlg.FormCreate(Sender: TObject);
begin
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

procedure TLMDDateListEditorDlg.UpBtnClick(Sender: TObject);
begin
  if DList.ItemIndex > 0 then
    DList.ItemIndex := DList.ItemIndex - 1;
end;

procedure TLMDDateListEditorDlg.DListClick(Sender: TObject);
var
  s: String;
begin
  s := DList.Items[DList.ItemIndex];
  DateEdit.Date := TDate(StrToDate (Copy (s, 1, Pos(';',s)-1)));
  Delete (s, 1, Pos(';',s));
  TimeEdit.Time := TTime(StrToTime (Copy (s, 1, Pos(';',s)-1)));
  Delete (s, 1, Pos(';',s));
  Des.Text := s;
end;

procedure TLMDDateListEditorDlg.DesTextChangedAt(sender: TObject; At: Integer);
var
  s,s2: String;
begin
  if DList.ItemIndex = -1 then exit;
  s := DList.Items[DList.ItemIndex];
  s2 := Copy (s, 1, Pos(';',s)-1);
  Delete (s, 1, Pos(';',s));
  s2 := s2+';'+Copy (s, 1, Pos(';',s)-1);
  Delete (s, 1, Pos(';',s));
  s2 := s2+';'+Des.Text;
  DList.Items[DList.ItemIndex] := s2;
end;

procedure TLMDDateListEditorDlg.DateEditChange(Sender: TObject);
var
  s: String;
begin
  if DList.ItemIndex = -1 then exit;
  s := DList.Items[DList.ItemIndex];
  Delete (s, 1, Pos(';',s)-1);
  s := DateToStr (TDateTime(DateEdit.Date)) + s;
  DList.Items[DList.ItemIndex] := s;
end;

procedure TLMDDateListEditorDlg.TimeEditChange(Sender: TObject);
var
  s,s2: String;
begin
  if DList.ItemIndex = -1 then exit;
  s := DList.Items[DList.ItemIndex];
  s2 := Copy (s, 1, Pos(';',s)-1);
  Delete (s, 1, Pos(';',s));
  Delete (s, 1, Pos(';',s)-1);
  s := s2+';'+TimeToStr(TDateTime(TimeEdit.Time))+s;
  DList.Items[DList.ItemIndex] := s;
end;

end.
 
