unit radiou;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, StdCtrls, wwclearbuttongroup, wwradiogroup, wwcheckbox,
  Db, DBTables, Grids, Wwdbigrd, Wwdbgrid, wwradiobutton, ExtCtrls, DBCtrls,
  wwSpeedButton, wwDBNavigator, wwclearpanel;

type
  TRadioDemoForm = class(TForm)
    radiomacballimagelist: TImageList;
    creditcardglyphlist: TImageList;
    wwRadioGroup1: TwwRadioGroup;
    wwRadioGroup3: TwwRadioGroup;
    DataSource1: TDataSource;
    Table1: TTable;
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
    macgreenImageList: TImageList;
    wwRadioGroup4: TwwRadioGroup;
    sexImageList: TImageList;
    maritalImageList: TImageList;
    wwRadioGroup5: TwwRadioGroup;
    priorityImageList1: TImageList;
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
    ImageList2: TImageList;
    ImageList1: TImageList;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RadioDemoForm: TRadioDemoForm;

implementation

{$R *.DFM}

end.
