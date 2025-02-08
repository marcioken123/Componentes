unit pLMDDateTimeFormatEditorDlg;
{$I lmdcmps.inc}
interface

uses
  Windows, ComCtrls, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  LMDListBox, LMDClass, LMDCustomScrollBox, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomSimpleLabel, LMDInformationLabel,
  LMDWndProcComponent, LMDSimpleLabel, LMDCustomComponent, LMDBaseControl;

type
  TLMDFrmDateTimePropertyEditor = class(TForm)
    LMDListBox1: TLMDListBox;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    LMDSimpleLabel1: TLMDSimpleLabel;
    ComboBox1: TComboBox;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDInformationLabel1: TLMDInformationLabel;
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
  public
    procedure SetFormat(aValue: String);
  end;

implementation

{$R *.DFM}

procedure TLMDFrmDateTimePropertyEditor.Edit1Change(Sender: TObject);
begin
  LMDInformationLabel1.DateTimeFormat := Edit1.Text;
end;

procedure TLMDFrmDateTimePropertyEditor.ComboBox1Change(Sender: TObject);
begin
  If ComboBox1.Text = 'Custom' then
    exit;
  If ComboBox1.Text = '21.11.98' then
    Edit1.Text := 'dd.mm.yy';
  If ComboBox1.Text = '11/21/98' then
    Edit1.Text := 'mm/dd/yy';
  If ComboBox1.Text = '23:20' then
    Edit1.Text := 'hh:mm';
  If ComboBox1.Text = '23:20:12' then
    Edit1.Text := 'hh:mm:ss';
  If ComboBox1.Text = '31.10.1998' then
    Edit1.Text := 'dd.mm.yyyy';
  If ComboBox1.Text = 'Thursday, 14.05.1998' then
    Edit1.Text := 'dddd, dd.mm.yyyy';
  If ComboBox1.Text = 'Thursday, 14.05.1998 15:01' then
    Edit1.Text := 'dddd, dd.mm.yyyy hh:mm';
end;

procedure TLMDFrmDateTimePropertyEditor.SetFormat(aValue : String);
begin
  Edit1.Text := aValue;
end;

end.
 
