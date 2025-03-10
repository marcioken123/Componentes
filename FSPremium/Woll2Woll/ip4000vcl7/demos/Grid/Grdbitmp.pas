unit Grdbitmp;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, DBTables, DB, Grids, Wwdbigrd, Wwdbgrid, Wwtable,
  Wwdatsrc, StdCtrls, DBCtrls, wwdblook, Wwdbdlg, Mask, Wwdbedit, Wwdotdot,
  Wwdbcomb, Wwdbspin, ExtCtrls, Wwquery, ComCtrls, wwriched, wwSpeedButton,
  wwDBNavigator, ImgList, wwclearpanel;

type
  TBitmapForm = class(TForm)
    CustomerDS: TwwDataSource;
    CustomerTable: TwwTable;
    InvoiceDS: TwwDataSource;
    InvoiceTable: TwwTable;
    InvoiceGrid: TwwDBGrid;
    DBText1: TDBText;
    CustomerTableFullName: TStringField;
    DBText2: TDBText;
    CustomerTableCustomerNo: TIntegerField;
    CustomerTableBuyer: TStringField;
    CustomerTableCompanyName: TStringField;
    CustomerTableFirstName: TStringField;
    CustomerTableLastName: TStringField;
    CustomerTableStreet: TStringField;
    CustomerTableCity: TStringField;
    CustomerTableState: TStringField;
    CustomerTableZip: TStringField;
    CustomerTableFirstContactDate: TDateField;
    CustomerTablePhoneNumber: TStringField;
    CustomerTableInformation: TMemoField;
    CustomerTableRequestedDemo: TStringField;
    CustomerTableLogical: TBooleanField;
    CustomerTableFullAddress: TStringField;
    DBText3: TDBText;
    PayMethCombo: TwwDBCombobox;
    ImageList1: TImageList;
    SumQuery: TwwQuery;
    SumQuerySUMOFbalancedue: TCurrencyField;
    SumQuerySUMOFTotalInvoice: TCurrencyField;
    wwDataSource1: TwwDataSource;
    wwDBRichEdit1: TwwDBRichEdit;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1PriorPage: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1NextPage: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    wwDBNavigator1SaveBookmark: TwwNavButton;
    wwDBNavigator1RestoreBookmark: TwwNavButton;
    InvoiceTableCustomerNo: TIntegerField;
    InvoiceTableInvoiceNo: TFloatField;
    InvoiceTablePaymentMethod: TFloatField;
    InvoiceTableTotalInvoice: TCurrencyField;
    InvoiceTablePurchaseDate: TDateField;
    InvoiceTableBalanceDue: TCurrencyField;
    InvoiceTablePayImageIndex: TIntegerField;
    procedure CustomerTableCalcFields(DataSet: TDataset);
    procedure InvoiceGridCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure InvoiceGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure InvoiceGridCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure InvoiceGridDblClick(Sender: TObject);
    procedure PayMethComboCloseUp(Sender: TwwDBCombobox; select: Boolean);
    procedure InvoiceTableCalcFields(DataSet: TDataSet);
    procedure InvoiceGridUpdateFooter(Sender: TObject);
  private
    procedure ToggleBitmaps;
  public
  end;

var
  BitmapForm: TBitmapForm;

implementation

{$R *.DFM}

{Calculate the FullName and FullAddress fields.}
procedure TBitmapForm.CustomerTableCalcFields(DataSet: TDataset);
begin
  CustomerTableFullName.AsString := CustomerTable.FieldByName('First Name').AsString + ' ' +
    CustomerTable.FieldByName('Last Name').AsString;
  CustomerTableFullAddress.AsString :=
    CustomerTable.FieldByName('City').AsString + ', ' +
    CustomerTable.FieldByName('State').AsString + '  ' +
    CustomerTable.FieldByName('Zip').AsString;
end;

{If the customer owes money then paint the record red.  It checks the value of the
 'Balance Due' field and if it is greater than zero then it will change the attributes
 for every column except the one that has focus. }
procedure TBitmapForm.InvoiceGridCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if not highlight and (InvoiceTable.FieldByName('Balance Due').AsInteger > 0) then
  begin
    ABrush.Color := clRed;  {Change the background color to red}
    AFont.Color := clWhite; {Change the pen color to white}
  end;
end;

{Allows the user to cycle through the available bitmaps in the grid.
 The three choices are (Visa), (American Express), and
 (MasterCard).  The if statements check which Card the record
 contains and changes it to another card.}
procedure TBitmapForm.ToggleBitmaps;
var payMethod: string;
begin
   InvoiceTable.Edit;
   PayMethod:= InvoiceTablePaymentMethod.asString;
   if (length(PayMethod)=0) or (PayMethod='-1') then payMethod:= ' ';

   case PayMethod[1] of
      '0': PayMethod:='-1';
      '1': PayMethod:='0';
      '2': PayMethod:='1';
      ' ': PayMethod:='2';
   end;
   InvoiceTablePaymentMethod.asString := PayMethod;
end;

procedure TBitmapForm.InvoiceGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if InvoiceGrid.GetActiveField.FieldName = 'PayImageIndex' then
    if (KEY=VK_SPACE) then
       ToggleBitmaps;
end;

{ Set Specific title attributes for the Invoice Grid }
procedure TBitmapForm.InvoiceGridCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if (AFieldName = 'Total Invoice') or (AFieldName = 'Balance Due') then
  begin
    ATitleAlignment := taRightJustify;
  end;
end;

{ Cycle through credit card bitmaps when dbl-clicked }
procedure TBitmapForm.InvoiceGridDblClick(Sender: TObject);
begin
  if InvoiceGrid.GetActiveField.FieldName = 'PayBitmap' then ToggleBitmaps;
end;

procedure TBitmapForm.PayMethComboCloseUp(Sender: TwwDBCombobox;
  select: Boolean);
begin
  if select then Sender.UpdateRecord;
end;

procedure TBitmapForm.InvoiceTableCalcFields(DataSet: TDataSet);
begin
  dataset.FieldByName('PayImageIndex').asInteger:=
     dataset.FieldByName('Payment Method').asInteger;
end;

procedure TBitmapForm.InvoiceGridUpdateFooter(Sender: TObject);
begin
   SumQuery.active:= False;
   SumQuery.ParamByName('CustNo').asInteger:= CustomerTable.FieldByName('Customer No').asInteger;
   SumQuery.active:= True;
   InvoiceGrid.ColumnByName('Balance Due').FooterValue:=
      FloatToStrF(SumQuerySumOfBalanceDue.asFloat, ffCurrency, 10, 2);
   InvoiceGrid.ColumnByName('Total Invoice').FooterValue:=
      FloatToStrF(SumQuerySumOfTotalInvoice.asFloat, ffCurrency, 10, 2);

end;

end.
