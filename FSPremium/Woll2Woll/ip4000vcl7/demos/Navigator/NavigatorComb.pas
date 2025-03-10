unit NavigatorComb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, wwrcdpnl, StdCtrls, Db, DBTables, Wwtable, Wwdatsrc, ComCtrls,
  wwriched, wwSpeedButton, wwDBNavigator, ImgList, wwclearpanel;

type
  TCombinedForm = class(TForm)
    Splitter1: TSplitter;
    wwRecordViewPanel1: TwwRecordViewPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    wwRecordViewPanel2: TwwRecordViewPanel;
    Panel3: TPanel;
    Splitter2: TSplitter;
    wwDBRichEdit1: TwwDBRichEdit;
    Navigator: TwwDBNavigator;
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
    NavigatorButton: TwwNavButton;
    NavigatorButton1: TwwNavButton;
    NavigatorButton2: TwwNavButton;
    StatusBar1: TStatusBar;
    wwDataSource1: TwwDataSource;
    wwTable1: TwwTable;
    wwDataSource2: TwwDataSource;
    wwTable2: TwwTable;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure NavigatorButton2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
     procedure ActiveControlChange(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CombinedForm: TCombinedForm;

implementation

{$R *.DFM}

procedure TCombinedForm.FormCreate(Sender: TObject);
begin
  Screen.OnActiveControlChange := ActiveControlChange;
end;

// When using the OnActiveControlChange Event, make sure
// that you set the ActiveControl property for your forms
// to some sort of default value.  In this demo, that
// property is set to the corresponding TwwRecordViewPanel or
// TwwDBGrid components.
procedure TCombinedForm.ActiveControlChange(Sender: TObject);
var i: integer;
begin
  Navigator.SetDataSourceFromComponent(Screen.ActiveControl, False);
  { Clear dialogs associcated with nav buttons so that a change in datasource, also
    changes the built-in dialogs }
  for i:= 0 to Navigator.Buttons.Count-1 do
  begin
     if Navigator.Buttons[i].Style in
        [nbsFilterDialog, nbsRecordViewDialog, nbsLocateDialog, nbsSearchDialog] then
        Navigator.Buttons[i].Dialog:= nil;
  end;

  if Navigator.DataSource <> nil then StatusBar1.SimpleText :=
    'Browsing table: "' + (Navigator.DataSource.DataSet as TwwTable).TableName + '"'
  else StatusBar1.SimpleText := 'Click on the Show menu to open a form';
end;


procedure TCombinedForm.NavigatorButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TCombinedForm.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveControlChange := nil;
end;


end.
