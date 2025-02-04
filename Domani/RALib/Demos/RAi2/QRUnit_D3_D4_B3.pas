unit QRUnit_D3_D4_B3;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TForm1 = class(TForm)
    QuickRep1 : TQuickRep;
    TitleBand1 : TQRBand;
    QRLabel1 : TQRLabel;
    PageFooterBand1 : TQRBand;
    QRSysData1 : TQRSysData;
    ColumnHeaderBand1 : TQRBand;
    DetailBand1 : TQRBand;
    QRLabel2 : TQRLabel;
    QRLabel3 : TQRLabel;
    QRLabel4 : TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRep1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
  public
    L, M: Integer;
    DataSet: TDataSet;
  end;

var
  Form1: TForm1;

implementation

//uses fRAI2Test;

{$R *.DFM}

function MessageBox(hWnd: integer; lpText, lpCaption: PChar; uType: integer): Integer;
  external 'user32.dll' name 'MessageBoxA';

procedure TForm1.FormCreate(Sender: TObject);
begin
//  QuickRep1.DataSet.Active := True;
//  QRLabel1.Enabled := False;
  DataSet := Application.FindComponent('Test').FindComponent('Table1');
//  MessageBox(0, DataSet.Name, 'Information', 0);
  QRLabel1.Caption := 'Привет';
  L := Field2.Left;
  M := 0;
  QRExpr1.Left := 100;
end;

procedure TForm1.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin                 
  Field1.Caption := DataSet.FieldValues['EmpNo'];
  Field2.Caption := DataSet.FieldValues['LastName'];
  Field3.Caption := DataSet.FieldValues['FirstName'];
  Field2.Left := L;
  L := L + 1;
end;

procedure TForm1.QuickRep1NeedData(Sender: TObject; var MoreData: Boolean);
begin
  M := M + 1;
  MoreData := M < 10;
//  MoreData := True;
  DataSet.Next;
end;

procedure TForm1.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  DataSet.Open;
  DataSet.First;
end;

end.
