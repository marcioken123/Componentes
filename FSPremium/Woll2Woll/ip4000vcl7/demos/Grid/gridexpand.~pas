unit gridexpand;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Wwdbigrd, Wwdbgrid, Db, DBTables, StdCtrls, ComCtrls, wwriched,
  DBCtrls, wwdblook, wwclearbuttongroup, wwradiogroup, wwcheckbox, ImgList,
  Mask, wwDataInspector, Buttons, DBCGrids, Wwtable, wwpaintoptions,
  wwdbedit, wwDialog, wwidlg, wwrcdvw, wwdbdatetimepicker, ExtCtrls,
  Wwdotdot, Wwdbcomb;

type
  TGridExpandForm = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    wwDBGrid1: TwwDBGrid;
    Table1LAST_NAME: TStringField;
    Table1FIRST_NAME: TStringField;
    Table1ACCT_NBR: TFloatField;
    Table1ADDRESS_1: TStringField;
    Table1CITY: TStringField;
    Table1STATE: TStringField;
    Table1ZIP: TStringField;
    Table1TELEPHONE: TStringField;
    Table1DATE_OPEN: TDateField;
    Table1SS_NUMBER: TFloatField;
    Table1PICTURE: TStringField;
    Table1BIRTH_DATE: TDateField;
    Table1RISK_LEVEL: TStringField;
    Table1OCCUPATION: TStringField;
    Table1OBJECTIVES: TStringField;
    Table1INTERESTS: TStringField;
    Table1IMAGE: TBlobField;
    Table1RINTERESTS: TBlobField;
    Table1SEX: TStringField;
    Table1EDUCATION: TSmallintField;
    Table1CREDRATING: TStringField;
    Table1MARRIED: TBooleanField;
    Table1PAYMETHOD: TSmallintField;
    Table1BALANCEDUE: TFloatField;
    wwDBRichEdit2: TwwDBRichEdit;
    wwDataInspector1: TwwDataInspector;
    wwExpandButton1: TwwExpandButton;
    Table1Name: TStringField;
    Table1ShippingAddress: TStringField;
    wwDataInspector2: TwwDataInspector;
    wwExpandButton2: TwwExpandButton;
    wwDBRichEdit1: TwwDBRichEdit;
    procedure Table1CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GridExpandForm: TGridExpandForm;

implementation

{$R *.DFM}

procedure TGridExpandForm.Table1CalcFields(DataSet: TDataSet);
begin
  with dataset do
     fieldbyname('Name').asstring:=
     fieldbyname('First_Name').asstring + ' ' +
     fieldbyname('Last_Name').asstring;
  with dataset do
     fieldbyname('ShippingAddress').asstring:=
     fieldbyname('Address_1').asstring + ', ' +
     fieldbyname('City').asstring + ', ' +
     fieldbyname('State').asstring + ' ' +
     fieldbyname('Zip').asstring;
end;

end.
