unit inspectormulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Mask, DBCtrls, ComCtrls, DBCGrids, DBTables,
  Gauges, wwdbedit, wwcheckbox, Grids, wwDataInspector, ImgList,
  wwSpeedButton, wwDBNavigator, ExtCtrls, wwclearpanel, wwmonthcalendar,
  wwclearbuttongroup, wwradiogroup, wwriched, Wwdbigrd, Wwdbgrid, Buttons,
  wwdbdatetimepicker;

type
  TMultiInspectorForm = class(TForm)
    ImageList1: TImageList;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1PriorPage: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1NextPage: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    wwDBNavigator1Insert: TwwNavButton;
    wwDBNavigator1Delete: TwwNavButton;
    wwDBNavigator1Edit: TwwNavButton;
    wwDBNavigator1Post: TwwNavButton;
    wwDBNavigator1Cancel: TwwNavButton;
    wwDBNavigator1Refresh: TwwNavButton;
    wwDBNavigator1SaveBookmark: TwwNavButton;
    wwDBNavigator1RestoreBookmark: TwwNavButton;
    wwDataInspector3: TwwDataInspector;
    DataSource3: TDataSource;
    Table3: TTable;
    Table3LAST_NAME: TStringField;
    Table3FIRST_NAME: TStringField;
    Table3ACCT_NBR: TFloatField;
    Table3ADDRESS_1: TStringField;
    Table3CITY: TStringField;
    Table3STATE: TStringField;
    Table3ZIP: TStringField;
    Table3TELEPHONE: TStringField;
    Table3DATE_OPEN: TDateField;
    Table3SS_NUMBER: TFloatField;
    Table3PICTURE: TStringField;
    Table3BIRTH_DATE: TDateField;
    Table3RISK_LEVEL: TStringField;
    Table3OCCUPATION: TStringField;
    Table3OBJECTIVES: TStringField;
    Table3INTERESTS: TStringField;
    Table3IMAGE: TBlobField;
    Table3calcaddress: TStringField;
    Table3calcfullname: TStringField;
    Table3calccontact: TStringField;
    DBImage1: TDBImage;
    Table3RINTERESTS: TBlobField;
    Table3SEX: TStringField;
    Table3EDUCATION: TSmallintField;
    Table3CREDRATING: TStringField;
    Table3MARRIED: TBooleanField;
    wwDBRichEdit1: TwwDBRichEdit;
    wwRadioGroup1: TwwRadioGroup;
    ImageList2: TImageList;
    wwCheckBox1: TwwCheckBox;
    ImageList3: TImageList;
    ImageList4: TImageList;
    ImageList5: TImageList;
    DBRadioGroup1: TDBRadioGroup;
    wwCheckBox2: TwwCheckBox;
    SpeedButton1: TSpeedButton;
    ImageList6: TImageList;
    ImageList7: TImageList;
    Table3calcpersonal: TStringField;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    procedure Table3CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MultiInspectorForm: TMultiInspectorForm;

implementation

{$R *.DFM}

procedure TMultiInspectorForm.Table3CalcFields(DataSet: TDataSet);
var m,d,y:word;
    m2,d2,y2:word;
begin
   with Dataset do begin
     FieldByName('calcfullname').AsString := FieldByName('FIRST_NAME').AsString + ' ' + FieldByName('LAST_NAME').AsString;
     FieldByName('calcaddress').AsString := FieldByName('ADDRESS_1').AsString + #13#10+FieldByName('CITY').AsString+', '+FieldByName('STATE').AsString +' '+ FieldByName('ZIP').AsString;
     FieldByName('calccontact').AsString := 'PH:'+FieldByName('TELEPHONE').AsString;

     DecodeDate(Now,y,m,d);
     DecodeDate(FieldByName('Birth_Date').asDateTime,y2,m2,d2);
     y := y-y2;
     if FieldByName('Married').AsBoolean then
       FieldByName('calcpersonal').AsString := 'Married, '+FieldByName('Sex').AsString + ', '+IntToStr(y)+' years old'
     else
       FieldByName('calcpersonal').AsString := 'Single, '+FieldByName('Sex').AsString + ', '+IntToStr(y)+' years old';
   end;
end;

end.
