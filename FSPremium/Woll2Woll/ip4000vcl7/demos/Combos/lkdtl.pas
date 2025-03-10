unit Lkdtl;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, wwdblook, DB, DBTables, Wwtable, Wwdatsrc,
  ComCtrls, wwriched;

type
  TDetailComboForm = class(TForm)
    wwDataSource1: TwwDataSource;
    wwTable1: TwwTable;
    InvoiceCombo: TwwDBLookupCombo;
    CustomerCombo: TwwDBLookupCombo;
    wwTable2: TwwTable;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    wwDBRichEdit1: TwwDBRichEdit;
    procedure CustomerComboCloseUp(Sender: TObject; LookupTable: TDataSet;
      FillTable: TDataset; modified: Boolean);
    procedure CustomerComboDropDown(Sender: TObject);
  private
    BeforeDropDownValue: string;
  public
    { Public declarations }
  end;

var
  DetailComboForm: TDetailComboForm;

implementation

{$R *.DFM}

{ Clear InvoiceCombo when selecting a new Customer }
procedure TDetailComboForm.CustomerComboCloseUp(Sender: TObject;
  LookupTable: TDataSet; FillTable: TDataset; modified: Boolean);
begin
   if CustomerCombo.text<>BeforeDropDownValue then
   begin
       InvoiceCombo.LookupValue:= '';
       InvoiceCombo.text:= '';
   end
end;

{ Save value prior to being dropped down }
procedure TDetailComboForm.CustomerComboDropDown(Sender: TObject);
begin
   BeforeDropDownValue:= CustomerCombo.text;
end;

end.
