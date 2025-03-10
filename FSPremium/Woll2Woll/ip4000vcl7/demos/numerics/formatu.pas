unit formatu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, wwcheckbox, ExtCtrls, DBCtrls, Grids, DBGrids, Db,
  DBTables, ImgList, wwclearbuttongroup, wwradiogroup, wwSpeedButton,
  wwDBNavigator, wwclearpanel, Mask, wwdbedit, Wwdbspin, ComCtrls, wwriched;

type
  TFormatForm = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1PriorPage: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1NextPage: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    Label1: TLabel;
    Label2: TLabel;
    wwDBEdit2: TwwDBEdit;
    Table1CustomerNo: TIntegerField;
    Table1InvoiceNo: TFloatField;
    Table1PaymentMethod: TFloatField;
    Table1TotalInvoice: TCurrencyField;
    Table1PurchaseDate: TDateField;
    Table1BalanceDue: TCurrencyField;
    wwDBEdit3: TwwDBEdit;
    wwDBSpinEdit1: TwwDBSpinEdit;
    Label3: TLabel;
    Image1: TImage;
    wwDBRichEdit1: TwwDBRichEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormatForm: TFormatForm;

implementation

{$R *.DFM}

end.
