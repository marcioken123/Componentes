unit lkcustom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, wwdblook, Grids, Wwdbigrd, Wwdbgrid,
  wwSpeedButton, wwDBNavigator, ExtCtrls, wwclearpanel, ComCtrls, wwriched;

type
  TCustomComboForm = class(TForm)
    DataSource1: TDataSource;
    Query1: TQuery;
    DataSource2: TDataSource;
    Table1: TTable;
    wwDBRichEdit1: TwwDBRichEdit;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    wwDBNavigator1Insert: TwwNavButton;
    wwDBNavigator1Delete: TwwNavButton;
    wwDBNavigator1Edit: TwwNavButton;
    wwDBNavigator1Post: TwwNavButton;
    wwDBNavigator1Cancel: TwwNavButton;
    wwDBLookupCombo2: TwwDBLookupCombo;
    Query2: TQuery;
    DataSource3: TDataSource;
    wwDBLookupCombo1: TwwDBLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    Query1ZIP: TStringField;
    Query1CITY: TStringField;
    Query1STATE: TStringField;
    Query2ZIP: TStringField;
    Query2CITY: TStringField;
    Query2STATE: TStringField;
    procedure wwDBLookupCombo2PerformCustomSearch(Sender: TObject;
      LookupTable: TDataSet; SearchField, SearchValue: String;
      PerformLookup: Boolean; var Found: Boolean);
    procedure wwDBLookupCombo1PerformCustomSearch(Sender: TObject;
      LookupTable: TDataSet; SearchField, SearchValue: String;
      PerformLookup: Boolean; var Found: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CustomComboForm: TCustomComboForm;

implementation

{$R *.DFM}

procedure TCustomComboForm.wwDBLookupCombo2PerformCustomSearch(Sender: TObject;
  LookupTable: TDataSet; SearchField, SearchValue: String;
  PerformLookup: Boolean; var Found: Boolean);
const dbl = '"';
var q: TQuery;
begin
   q:= TQuery(LookupTable);
   q.active:= false;
   SearchValue:= AnsiUppercase(SearchValue);
   if PerformLookup then
   begin
     q.sql.clear;
     q.sql.add('Select * from ip4zip');
     q.sql.add('where zip=' + Dbl + SearchValue + Dbl);
   end
   else begin
     q.sql.clear;
     q.sql.add('Select * from ip4zip');
     q.sql.add('where upper(ip4zip."city") like ' + Dbl + SearchValue + '%' + Dbl);
//     q.ParamByName('City').asString:= SearchValue + '%';
   end;
   q.active:= true;
   found:= not q.eof;
end;

procedure TCustomComboForm.wwDBLookupCombo1PerformCustomSearch(Sender: TObject;
  LookupTable: TDataSet; SearchField, SearchValue: String;
  PerformLookup: Boolean; var Found: Boolean);
const dbl = '"';
var q: TQuery;
begin
   q:= TQuery(LookupTable);
   q.active:= false;
   SearchValue:= AnsiUppercase(SearchValue);
   if PerformLookup then
   begin
     q.sql.clear;
     q.sql.add('Select * from ip4zip');
     q.sql.add('where ip4zip."zip" = ' + Dbl + SearchValue + Dbl);
   end
   else begin
     q.sql.clear;
     q.sql.add('Select * from ip4zip');
     q.sql.add('where ip4zip."zip" like ' + Dbl + SearchValue + '%' + Dbl);
   end;
   q.active:= true;
   found:= not q.eof;
end;

end.
