unit rcdpnldemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, wwrcdpnl, Db, DBTables, Wwtable, Wwdatsrc, ExtCtrls, ComCtrls,
  wwriched, Mask, wwdbedit, Wwdotdot, Wwdbcomb, wwdblook, Wwdbdlg, Grids,
  Wwdbigrd, Wwdbgrid, wwSpeedButton, wwDBNavigator, wwDialog, Wwfltdlg,
  Wwkeycb, wwcommon, wwclearpanel;

type
  TRecordPanelDemo = class(TForm)
    wwDataSource1: TwwDataSource;
    wwtable1: TwwTable;
    wwRecordViewPanel1: TwwRecordViewPanel;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Label2: TLabel;
    TableComboBox: TwwDBComboBox;
    Label1: TLabel;
    RulerBevel: TBevel;
    Panel2: TPanel;
    ConsistentEditWidthCheckbox: TCheckBox;
    Layout: TRadioGroup;
    Bevel1: TBevel;
    AliasCombobox: TwwDBComboBox;
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
    wwDBNavigator1FilterDialog: TwwNavButton;
    Bevel2: TBevel;
    procedure LayoutClick(Sender: TObject);
    procedure TableComboBoxChange(Sender: TObject);
    procedure wwRecordViewPanel1AfterCreateControl(Sender: TObject;
      curField: TField; Control: TControl);
    procedure ConsistentEditWidthCheckboxClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AliasComboboxChange(Sender: TObject);
  private
    OrigApplicationHint: TNotifyEvent;
    procedure FormChangeHint(Sender: TObject);
  end;

var
  RecordPanelDemo: TRecordPanelDemo;

implementation

{$R *.DFM}

procedure TRecordPanelDemo.LayoutClick(Sender: TObject);
begin
  with (Sender as TRadioGroup) do
  begin
     if ItemIndex = 0 then wwRecordViewPanel1.Style:= rvpsVertical
     else wwRecordViewPanel1.Style:= rvpsHorizontal;
  end;

  ConsistentEditWidthCheckbox.enabled:=  wwRecordViewPanel1.Style = rvpsVertical;
end;

procedure TRecordPanelDemo.TableComboBoxChange(Sender: TObject);
begin
  if TableCombobox.droppeddown then exit;

  If TableComboBox.text='' then exit;
  If AliasComboBox.text='' then exit;

  wwRecordViewPanel1.Selected.clear;
  wwtable1.active:= false;
  wwtable1.indexName:= '';
  wwtable1.tableName:= TableCombobox.text;
  wwtable1.databaseName:= AliasComboBox.text;
  wwtable1.active:= true;
end;

procedure TRecordPanelDemo.wwRecordViewPanel1AfterCreateControl(
  Sender: TObject; curField: TField; Control: TControl);
begin
   if Control is TwwDBRichEdit then Control.Height:= 75;
end;

procedure TRecordPanelDemo.ConsistentEditWidthCheckboxClick(
  Sender: TObject);
begin
   if (sender as TCheckBox).checked then
   begin
      Layout.ItemIndex:= 0;
      wwRecordViewPanel1.Options:= wwRecordViewPanel1.Options + [rvopConsistentEditWidth];
   end
   else
      wwRecordViewPanel1.Options:= wwRecordViewPanel1.Options - [rvopConsistentEditWidth];
end;

procedure TRecordPanelDemo.FormShow(Sender: TObject);
begin
   OrigApplicationHint:= Application.OnHint;
   Application.OnHint:= FormChangeHint;
   Session.GetDatabaseNames(AliasComboBox.Items);
   AliasComboBox.itemIndex:= AliasComboBox.Items.IndexOf('InfoDemo5');
   Session.GetTableNames(AliasComboBox.Text, '', True, False, TableComboBox.items);
   TableComboBox.itemIndex:= TableComboBox.Items.IndexOf('IP4CUST.DB');
end;

procedure TRecordPanelDemo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Application.OnHint:= OrigApplicationHint;
end;

procedure TRecordPanelDemo.FormChangeHint(Sender: TObject);
begin
   StatusBar1.Panels[0].text:=Application.Hint;
end;

procedure TRecordPanelDemo.AliasComboboxChange(Sender: TObject);
begin
   Session.GetTableNames(AliasComboBox.Text, '', True, False, TableComboBox.items);
   TableComboBox.text:= '';
   wwtable1.active:= false;
end;

end.
