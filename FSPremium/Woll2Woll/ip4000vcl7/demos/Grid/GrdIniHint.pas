unit GrdIniHint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Wwdbigrd, Wwdbgrid, Db, DBTables, Wwtable, Wwdatsrc, wwdblook,
  StdCtrls, ComCtrls, wwriched, wwdbdatetimepicker, wwDialog, Wwfltdlg,
  ExtCtrls;

type
  TGridHintIniDemo = class(TForm)
    wwDataSource1: TwwDataSource;
    wwTable1: TwwTable;
    wwDBGrid1: TwwDBGrid;
    wwDBRichEdit1: TwwDBRichEdit;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwTable2: TwwTable;
    wwTable1CustomerNo: TIntegerField;
    wwTable1Buyer: TStringField;
    wwTable1CompanyName: TStringField;
    wwTable1FirstName: TStringField;
    wwTable1LastName: TStringField;
    wwTable1Street: TStringField;
    wwTable1State: TStringField;
    wwTable1Zip: TStringField;
    wwTable1FirstContactDate: TDateField;
    wwTable1PhoneNumber: TStringField;
    wwTable1Information: TMemoField;
    wwTable1CityZip: TStringField;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure wwDBGrid1CreateHintWindow(Sender: TObject;
      HintWindow: TwwGridHintWindow; AField: TField; R: TRect;
      var WordWrap: Boolean; var MaxWidth, MaxHeight: Integer;
      var DoDefault: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GridHintIniDemo: TGridHintIniDemo;

implementation

{$R *.DFM}

procedure TGridHintIniDemo.wwDBGrid1CreateHintWindow(Sender: TObject;
  HintWindow: TwwGridHintWindow; AField: TField; R: TRect;
  var WordWrap: Boolean; var MaxWidth, MaxHeight: Integer;
  var DoDefault: Boolean);
begin
  WordWrap := True;
  if (AField is TBlobField) then
     MaxWidth := 100;
  MaxHeight := Screen.Height;
end;

procedure TGridHintIniDemo.Button1Click(Sender: TObject);
begin
  wwDBGrid1.LoadFromIniFile;
end;

procedure TGridHintIniDemo.Button2Click(Sender: TObject);
begin
  wwDBGrid1.IniAttributes.Enabled := True;
  wwDBGrid1.SaveToIniFile;
end;

end.
