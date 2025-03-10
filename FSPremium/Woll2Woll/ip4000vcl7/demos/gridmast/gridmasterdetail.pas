unit gridmasterdetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, wwcheckbox, DBTables, Grids, Wwdbigrd, Wwdbgrid, ComCtrls,
  wwriched, Mask, wwdbedit, wwdbdatetimepicker, Buttons, wwdblook,
  wwDialog, wwrcdvw, wwclearbuttongroup, wwradiogroup, wwradiobutton,
  wwrcdpnl, wwmonthcalendar, ImgList, wwDataInspector;

type
  TMasterDetailGridForm = class(TForm)
    CustomerGrid: TwwDBGrid;
    InvoiceGrid: TwwDBGrid;
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
    procedure wwExpandButton1AfterExpand(Sender: TObject);
    procedure CustomerTableCalcFields(DataSet: TDataSet);
    procedure wwExpandButton1BeforeCollapse(Sender: TObject);
    procedure OrdersTableCalcFields(DataSet: TDataSet);
    procedure wwExpandButton2BeforeCollapse(Sender: TObject);
    procedure InvoiceGridBeforePaint(Sender: TObject);
    procedure CustomerGridCalcTitleImage(Sender: TObject; Field: TField;
      var TitleImageAttributes: TwwTitleImageAttributes);
    procedure InvoiceGridUpdateFooter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MasterDetailGridForm: TMasterDetailGridForm;

implementation

{$R *.DFM}

procedure TMasterDetailGridForm.wwExpandButton1AfterExpand(Sender: TObject);
begin
{   if wwdbgrid1.IsActiveRowAlternatingColor then
      (Sender as TwwExpandButton).Grid.color:= wwdbgrid1.paintoptions.alternatingRowColor
   else
      (Sender as TwwExpandButton).Grid.color:= wwdbgrid1.color;}
end;

procedure TMasterDetailGridForm.CustomerTableCalcFields(DataSet: TDataSet);
begin
{  CalcTotalOrders.active:=false;
  CalcTotalOrders.parambyName('CustNo').asfloat:=dataset.fieldbyname('CustNo').asfloat;
  CalcTotalOrders.active:=true;
  dataset.fieldbyname('Orders').asstring:= CalcTotalOrders.fields[0].AsString;
}
end;

procedure TMasterDetailGridForm.wwExpandButton1BeforeCollapse(Sender: TObject);
begin
//   wwExpandButton1.refreshCalcField;
end;

procedure TMasterDetailGridForm.OrdersTableCalcFields(DataSet: TDataSet);
begin
{  CalcTotalItems.active:=false;
  CalcTotalItems.parambyName('OrderNo').asfloat:=dataset.fieldbyname('OrderNo').asfloat;
  CalcTotalItems.active:=true;
  dataset.fieldbyname('Items').asstring:= CalcTotalItems.fields[0].AsString;
}
end;

procedure TMasterDetailGridForm.wwExpandButton2BeforeCollapse(Sender: TObject);
begin
//   wwExpandButton2.refreshCalcField;
end;

procedure TMasterDetailGridForm.InvoiceGridBeforePaint(Sender: TObject);
begin
  // Paint to my grid the
   if CustomerGrid.IsActiveRowAlternatingColor then
   begin
      with TwwDBGrid(Sender) do
        Canvas.CopyRect(ClientRect,
           CustomerGrid.PaintOptions.AlternatingColorBitmap.Canvas, ClientRect);
   end
   else
      with TwwDBGrid(Sender) do
        Canvas.CopyRect(ClientRect,
           CustomerGrid.PaintOptions.OrigBitmap.Canvas, ClientRect);
end;

procedure TMasterDetailGridForm.CustomerGridCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
   if (Field.FieldName='Orders') then
   begin
      TitleImageAttributes.ImageIndex:=2;
   end;
end;

procedure TMasterDetailGridForm.InvoiceGridUpdateFooter(Sender: TObject);
begin
   SumQuery.active:= False;
   SumQuery.ParamByName('CustNo').asInteger:= CustomerTable.FieldByName('CustNo').asInteger;
   SumQuery.active:= True;
   InvoiceGrid.ColumnByName('ItemsTotal').FooterValue:=
      FloatToStrF(SumQuerySUMOFItemsTotal.asFloat, ffCurrency, 10, 2);
end;

end.
