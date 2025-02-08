unit pLMDDateTimeEditorDlg;
{$I lmdcmps.Inc}
interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  LMDShSpinEdit;

type
  TLMDFrmDateTimeEditor = class(TForm)
    LMDButton1: TButton;
    LMDGroupBox1: TGroupBox;
    LMDSimpleLabel1: TLabel;
    LMDSimpleLabel2: TLabel;
    LMDSimpleLabel3: TLabel;
    DayEdit: TLMDShSpinEdit;
    MonthEdit: TLMDShSpinEdit;
    YearEdit: TLMDShSpinEdit;
    LMDGroupBox2: TGroupBox;
    LMDSimpleLabel4: TLabel;
    LMDSimpleLabel5: TLabel;
    LMDSimpleLabel6: TLabel;
    HourEdit: TLMDShSpinEdit;
    MinuteEdit: TLMDShSpinEdit;
    SecondEdit: TLMDShSpinEdit;
    LMDButton2: TButton;
    Button1: TButton;
    Button2: TButton;
    procedure LMDButton1Click(Sender: TObject);
    procedure LMDButton2Click(Sender: TObject);
    procedure LMDAssist1CancelClick(Sender: TObject);
    procedure LMDAssist1Completed(Sender: TObject; var Cancel: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.DFM}

procedure TLMDFrmDateTimeEditor.LMDButton1Click(Sender: TObject);
var
  y, m, d : word;
begin
  DecodeDate (date, y, m, d);
  YearEdit.Value := y;
  MonthEdit.Value := m;
  DayEdit.Value := d;
end;

procedure TLMDFrmDateTimeEditor.LMDButton2Click(Sender: TObject);
var
  h, m, s, hs : Word;
begin
  DecodeTime (time, h, m, s, hs);
  HourEdit.Value := h;
  MinuteEdit.Value := m;
  SecondEdit.Value := s;
end;

procedure TLMDFrmDateTimeEditor.LMDAssist1CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
{  Close;}
end;

procedure TLMDFrmDateTimeEditor.LMDAssist1Completed(Sender: TObject;
  var Cancel: Boolean);
begin
  Cancel := false;
  ModalResult := mrOk;
{  Close;}
end;

end.
 
