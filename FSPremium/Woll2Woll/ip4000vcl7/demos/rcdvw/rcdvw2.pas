unit rcdvw2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Wwdbigrd, Wwdbgrid, Db, DBTables, StdCtrls, ComCtrls, wwriched,
  DBCtrls, wwdblook, wwclearbuttongroup, wwradiogroup, wwcheckbox, ImgList,
  Mask, wwDataInspector, Buttons, DBCGrids, Wwtable, wwpaintoptions,
  wwdbedit, wwDialog, wwidlg, wwrcdvw, ExtCtrls, wwrcdpnl,
  Wwdbspin, Wwdotdot, Wwdbcomb;

type
  TRecordViewCustomForm = class(TForm)
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
    Table1selected: TBooleanField;
    Table1details: TIntegerField;
    SpeedButton2: TSpeedButton;
    Table1PAYMETHOD: TSmallintField;
    Table1BALANCEDUE: TFloatField;
    ImageList6: TImageList;
    wwRecordViewDialog1: TwwRecordViewDialog;
    wwCheckBox1: TwwCheckBox;
    wwRadioGroup4: TwwRadioGroup;
    wwRadioGroup1: TwwRadioGroup;
    wwDBRichEdit1: TwwDBRichEdit;
    procedure SpeedButton2Click(Sender: TObject);
    procedure wwRecordViewDialog1AfterCreateControl(
      Form: TwwRecordViewForm; curField: TField; Control: TControl);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RecordViewCustomForm: TRecordViewCustomForm;

implementation

{$R *.DFM}

procedure TRecordViewCustomForm.SpeedButton2Click(Sender: TObject);
begin
   wwrecordviewdialog1.execute;
end;

procedure TRecordViewCustomForm.wwRecordViewDialog1AfterCreateControl(
  Form: TwwRecordViewForm; curField: TField; Control: TControl);
begin
   if Control is TLabel then
   begin
     (Control as TLabel).Transparent := true;
   end;
end;

end.
