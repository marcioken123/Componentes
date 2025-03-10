unit gridexpandpanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, wwcheckbox, wwDataInspector, ComCtrls,
  wwriched, Grids, Wwdbigrd, Wwdbgrid, wwSpeedButton, wwDBNavigator,
  wwclearpanel, ExtCtrls, wwrcdpnl;

type
  TFormExpandPanel = class(TForm)
    wwDBGrid1: TwwDBGrid;
    wwDBRichEdit2: TwwDBRichEdit;
    wwDataInspector1: TwwDataInspector;
    wwExpandButton1: TwwExpandButton;
    wwExpandButton2: TwwExpandButton;
    wwDBRichEdit1: TwwDBRichEdit;
    DataSource1: TDataSource;
    Table1: TTable;
    Table1ACCT_NBR: TFloatField;
    Table1FIRST_NAME: TStringField;
    Table1LAST_NAME: TStringField;
    Table1RINTERESTS: TBlobField;
    Table1IMAGE: TBlobField;
    Table1PAYMETHOD: TSmallintField;
    Table1BALANCEDUE: TFloatField;
    Table1SEX: TStringField;
    Table1MARRIED: TBooleanField;
    Table1CITY: TStringField;
    Table1EDUCATION: TSmallintField;
    Table1ADDRESS_1: TStringField;
    Table1STATE: TStringField;
    Table1ZIP: TStringField;
    Table1TELEPHONE: TStringField;
    Table1DATE_OPEN: TDateField;
    Table1INTERESTS: TStringField;
    Table1SS_NUMBER: TFloatField;
    Table1PICTURE: TStringField;
    Table1BIRTH_DATE: TDateField;
    Table1RISK_LEVEL: TStringField;
    Table1OCCUPATION: TStringField;
    Table1OBJECTIVES: TStringField;
    Table1CREDRATING: TStringField;
    Table1Name: TStringField;
    Table1ShippingAddress: TStringField;
    Panel1: TPanel;
    wwRecordViewPanel1: TwwRecordViewPanel;
    procedure Table1CalcFields(DataSet: TDataSet);
    procedure wwDataInspector2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wwExpandButton2BeforeExpand(Sender: TObject);
    procedure wwExpandButton2AfterExpand(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormExpandPanel: TFormExpandPanel;

implementation

{$R *.dfm}

procedure TFormExpandPanel.Table1CalcFields(DataSet: TDataSet);
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

procedure TFormExpandPanel.wwDataInspector2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
{  if (key=vk_tab) THEN
  begin
     if (wwdatainspector2.row=wwdatainspector2.rowcount-1) then
     begin
        if not (ssShift in Shift) then
           key:=0;
     end
     else if wwdatainspector2.row=0 then
     begin
        if (ssShift in Shift) then
          key:=0;
     end
  end}
end;

procedure TFormExpandPanel.wwExpandButton2BeforeExpand(Sender: TObject);
begin
  wwrecordviewpanel1.width:= wwExpandButton2.width;
end;

procedure TFormExpandPanel.wwExpandButton2AfterExpand(Sender: TObject);
begin
  wwrecordviewpanel1.datasource.dataset.FieldByName('ACCT_NBR').FocusControl;
end;

end.
