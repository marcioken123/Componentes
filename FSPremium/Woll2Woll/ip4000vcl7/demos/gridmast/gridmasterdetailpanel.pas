unit gridmasterdetailpanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, wwcheckbox, DBTables, Grids, Wwdbigrd, Wwdbgrid, ComCtrls,
  wwriched, Mask, wwdbedit, wwdbdatetimepicker, Buttons, wwdblook,
  wwDialog, wwrcdvw, wwclearbuttongroup, wwradiogroup, wwradiobutton,
  wwrcdpnl, wwmonthcalendar, ImgList, wwDataInspector, wwSpeedButton,
  wwDBNavigator, wwclearpanel, ExtCtrls;

type
  TMasterDetailPanelForm = class(TForm)
    CustomerGrid: TwwDBGrid;
    DataSource1: TDataSource;
    CustomerTable: TTable;
    DataSource2: TDataSource;
    OrdersTable: TTable;
    wwExpandButton1: TwwExpandButton;
    CustomerTableCustNo: TFloatField;
    CustomerTableCompany: TStringField;
    CustomerTableAddr1: TStringField;
    CustomerTableAddr2: TStringField;
    CustomerTableCity: TStringField;
    CustomerTableState: TStringField;
    CustomerTableZip: TStringField;
    CustomerTableCountry: TStringField;
    CustomerTablePhone: TStringField;
    CustomerTableFAX: TStringField;
    CustomerTableTaxRate: TFloatField;
    CustomerTableContact: TStringField;
    CustomerTableLastInvoiceDate: TDateTimeField;
    CustomerTableOrders: TIntegerField;
    DataSource3: TDataSource;
    Table3: TTable;
    ItemsGrid: TwwDBGrid;
    wwExpandButton2: TwwExpandButton;
    OrdersTableOrderNo: TFloatField;
    OrdersTableCustNo: TFloatField;
    OrdersTableSaleDate: TDateTimeField;
    OrdersTableShipDate: TDateTimeField;
    OrdersTableEmpNo: TIntegerField;
    OrdersTableShipToContact: TStringField;
    OrdersTableShipToAddr1: TStringField;
    OrdersTableShipToAddr2: TStringField;
    OrdersTableShipToCity: TStringField;
    OrdersTableShipToState: TStringField;
    OrdersTableShipToZip: TStringField;
    OrdersTableShipToCountry: TStringField;
    OrdersTableShipToPhone: TStringField;
    OrdersTableShipVIA: TStringField;
    OrdersTablePO: TStringField;
    OrdersTableTerms: TStringField;
    OrdersTablePaymentMethod: TStringField;
    OrdersTableItemsTotal: TCurrencyField;
    OrdersTableTaxRate: TFloatField;
    OrdersTableFreight: TCurrencyField;
    OrdersTableAmountPaid: TCurrencyField;
    OrdersTableItems: TIntegerField;
    Table5: TTable;
    CustomerTableHaveOrders: TIntegerField;
    CalcTotalItems: TQuery;
    SumQuery: TQuery;
    SpeedButton1: TSpeedButton;
    ImageList1: TImageList;
    Query1: TQuery;
    SumQuerySUMOFItemsTotal: TCurrencyField;
    InvoicePanel: TPanel;
    InvoiceGrid: TwwDBGrid;
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
    procedure CustomerGridCalcTitleImage(Sender: TObject; Field: TField;
      var TitleImageAttributes: TwwTitleImageAttributes);
    procedure InvoiceGridUpdateFooter(Sender: TObject);
    procedure wwExpandButton1AfterExpand(Sender: TObject);
    procedure InvoiceGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MasterDetailPanelForm: TMasterDetailPanelForm;

implementation

{$R *.DFM}

procedure TMasterDetailPanelForm.CustomerGridCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
   if (Field.FieldName='Orders') then
   begin
      TitleImageAttributes.ImageIndex:=2;
   end;
end;

procedure TMasterDetailPanelForm.InvoiceGridUpdateFooter(Sender: TObject);
begin
   SumQuery.active:= False;
   SumQuery.ParamByName('CustNo').asInteger:= CustomerTable.FieldByName('CustNo').asInteger;
   SumQuery.active:= True;
   InvoiceGrid.ColumnByName('ItemsTotal').FooterValue:=
      FloatToStrF(SumQuerySUMOFItemsTotal.asFloat, ffCurrency, 10, 2);
end;

procedure TMasterDetailPanelForm.wwExpandButton1AfterExpand(
  Sender: TObject);
begin
   InvoiceGrid.setfocus;
end;

procedure TMasterDetailPanelForm.InvoiceGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ssctrl in shift then
    if key=vk_left then
       if (Sender as TwwDBGrid).selectedindex = 0 then
          wwExpandButton1.Expanded:=false;
end;

end.
