unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TForm1 = class(TForm)
    QRDBText3: TQRDBText;
    QRDBText2: TQRDBText;
    Table1Salary: TFloatField;
    Table1HireDate: TDateTimeField;
    Table1PhoneExt: TStringField;
    Table1FirstName: TStringField;
    Table1LastName: TStringField;
    Table1EmpNo: TIntegerField;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRDBText1: TQRDBText;
    Table1: TTable;
    QuickRep1: TQuickRep;
    procedure HeaderAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormShow(Sender: TObject);
begin
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Table1.Active := True;
{  QuickRep1.Preview; }
end;

procedure TForm1.HeaderAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin

end;


end.
