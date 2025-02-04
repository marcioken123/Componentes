unit fTable;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids;

type
  TForm1 = class(TForm)
    tEmployeeFirstName: TStringField;
    tEmployeeLastName: TStringField;
    DataSource1: TDataSource;
    dgEmployee: TDBGrid;
    tEmployee: TTable;
    Table1: TTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

end.
