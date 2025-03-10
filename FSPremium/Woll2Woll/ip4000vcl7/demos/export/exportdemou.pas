unit exportdemou;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Db, DBTables, StdCtrls, DBGrids, Wwdbigrd, Wwdbgrid,
  ExtCtrls,shellapi, Buttons, ComCtrls, ToolWin, Mask, wwdbedit,
  clipbrd,wwExport, ImgList, wwclearbuttongroup, wwradiogroup, wwcheckbox,
  Wwdotdot, Wwdbcomb, Wwdatsrc, Wwquery;

type
  TExportForm = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    wwDBGrid1: TwwDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    Panel3: TPanel;
    BitBtn4: TBitBtn;
    GroupBox1: TGroupBox;
    BestColumnFitCB: TwwCheckBox;
    ShowCheckboxCB: TwwCheckBox;
    ShowURLCB: TwwCheckBox;
    ShowColorsCB: TwwCheckBox;
    AlternatingCB: TwwCheckBox;
    GroupBox2: TGroupBox;
    ExportSelectedCB: TwwCheckBox;
    MultiselectCB: TwwCheckBox;
    ShowRecCB: TwwCheckBox;
    ShowHeaderCB: TwwCheckBox;
    ShowTitleCB: TwwCheckBox;
    Label1: TLabel;
    wwDBEdit1: TwwDBEdit;
    BitBtn5: TBitBtn;
    Table1CustomerNo: TIntegerField;
    Table1Buyer: TStringField;
    Table1CompanyName: TStringField;
    Table1FirstName: TStringField;
    Table1LastName: TStringField;
    Table1Street: TStringField;
    Table1City: TStringField;
    Table1State: TStringField;
    Table1Zip: TStringField;
    Table1FirstContactDate: TDateField;
    Table1PhoneNumber: TStringField;
    Table1Information: TMemoField;
    Table1RichEdit: TBlobField;
    Table1RequestedDemo: TStringField;
    Table1Logical: TBooleanField;
    wwRadioGroup1: TwwRadioGroup;
    ImageList1: TImageList;
    macgreenImageList: TImageList;
    Table2: TTable;
    Table2CustomerNo: TIntegerField;
    Table2InvoiceNo: TFloatField;
    Table2PaymentMethod: TFloatField;
    Table2TotalInvoice: TCurrencyField;
    Table2PurchaseDate: TDateField;
    Table2BalanceDue: TCurrencyField;
    Table2First: TStringField;
    Table2Last: TStringField;
    wwDBComboBox1: TwwDBComboBox;
    SumQuery: TwwQuery;
    SumQuerySUMOFbalancedue: TCurrencyField;
    SumQuerySUMOFTotalInvoice: TCurrencyField;
    wwDataSource1: TwwDataSource;
    DataSource2: TDataSource;
    wwRadioGroup2: TwwRadioGroup;
    procedure wwDBGrid1CalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure MultiselectCBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure wwDBGrid1UpdateFooter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure SetExportOptions(AOptions:TwwExportOptions);
  end;

var
  ExportForm: TExportForm;

implementation

{$R *.DFM}

procedure TExportForm.SetExportOptions(AOptions:TwwExportOptions);
begin
  AOptions.Options := [esoDblQuoteFields,esoShowFooter];
  if ShowTitleCB.Checked then
    AOptions.Options := AOptions.Options + [esoShowTitle];
  if ShowHeaderCB.Checked then
    AOptions.Options := AOptions.Options + [esoShowHeader];
  if ShowRecCB.Checked then
    AOptions.Options := AOptions.Options + [esoShowRecordNo];
  if ExportSelectedCB.Checked then
    AOptions.Options := AOptions.Options + [esoSaveSelectedOnly];
  if BestColumnFitCB.Checked then
    AOptions.Options := AOptions.Options + [esoBestColFit];
  if ShowCheckBoxCB.Checked then
    AOptions.Options := AOptions.Options + [esoAddControls];
  if ShowURLCB.Checked then
    AOptions.Options := AOptions.Options + [esoEmbedURL];
  if ShowColorsCB.Checked then
    AOptions.Options := AOptions.Options + [esoDynamicColors];
  if AlternatingCB.Checked then
    AOptions.Options := AOptions.Options + [esoShowAlternating];
  AOptions.OutputWidthinTwips := StrToInt(wwDBEdit1.Text)*1440;
  if wwRadioGroup1.ItemIndex = 0 then
     AOptions.Options := AOptions.Options + [esoClipboard]
  else  AOptions.Options := AOptions.Options - [esoClipboard];
end;

procedure TExportForm.wwDBGrid1CalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if aFieldName='StartDate' then begin
    ABrush.Color := clRed;
    AFont.Style := [fsBold,fsUnderline];
    AFont.Name := 'Arial';
    AFont.Size := 8;
    AFont.COlor := clYellow;
    ATitleAlignment:=taRightJustify;
  end;
end;

procedure TExportForm.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if Field.FieldName = 'Balance Due' then
     if Field.asFloat > 0.0 then begin
       ABrush.Color := clRed;
       AFont.Style := [fsBold];
     end;
end;

procedure TExportForm.BitBtn1Click(Sender: TObject);
begin
   with wwDBGrid1,wwDBGrid1.ExportOptions do begin
      ExportType := wwgetHTML;
      FileName := 'wwexporttest.html';
      SetExportOptions(wwDBGrid1.ExportOptions);
      Save;
      if not(esoClipboard in Options) then
         ShellExecute(Handle, 'OPEN', PChar(wwdbgrid1.exportoptions.Filename), nil, nil, sw_shownormal);
   end;
end;

procedure TExportForm.BitBtn3Click(Sender: TObject);
begin
   with wwDBGrid1,wwDBGrid1.ExportOptions do begin
      ExportType := wwgetTxt;
      FileName := 'wwexporttest.txt';
      Delimiter := ',';
      SetExportOptions(wwDBGrid1.ExportOptions);
      Save;
      if not(esoClipboard in Options) then
         ShellExecute(Handle, 'OPEN', PChar(wwdbgrid1.exportoptions.Filename), nil, nil, sw_shownormal);
   end;
end;

procedure TExportForm.MultiselectCBClick(Sender: TObject);
begin
  if (Sender as TwwCheckBox).Checked then
     wwdbgrid1.options := wwdbgrid1.options + [dgMultiSelect]
  else wwdbgrid1.options := wwdbgrid1.options - [dgMultiSelect];
end;

procedure TExportForm.FormShow(Sender: TObject);
begin
  wwDBEdit1.Text := '8';
  wwRadioGroup1.itemindex := 1;
end;

procedure TExportForm.BitBtn2Click(Sender: TObject);
begin
   with wwDBGrid1,wwDBGrid1.ExportOptions do begin
      ExportType := wwgetTxt;
      FileName := 'wwexporttest.txt';
      Delimiter := '';
      SetExportOptions(wwDBGrid1.ExportOptions);
      Save;
      if not(esoClipboard in Options) then
         ShellExecute(Handle, 'OPEN', PChar(wwdbgrid1.exportoptions.Filename), nil, nil, sw_shownormal);
   end;
end;

procedure TExportForm.BitBtn4Click(Sender: TObject);
begin
   with wwDBGrid1,wwDBGrid1.ExportOptions do begin
      ExportType := wwgetTxt;
      FileName := 'wwexporttest.txt';
      Delimiter := #9;
      SetExportOptions(ExportOptions);
      Save;
      if not(esoClipboard in Options) then
         ShellExecute(Handle, 'OPEN', PChar(wwdbgrid1.exportoptions.Filename), nil, nil, sw_shownormal);
   end;
end;

procedure TExportForm.BitBtn5Click(Sender: TObject);
begin
   with wwDBGrid1,wwDBGrid1.ExportOptions do begin
      ExportType := wwgetSYLK;
      FileName := 'wwexporttest.slk';
      SetExportOptions(ExportOptions);
      Save;
      if not(esoClipboard in Options) then
      ShellExecute(Handle, 'Open', PChar(wwdbgrid1.exportoptions.Filename), nil, nil, sw_shownormal);
   end;
end;

procedure TExportForm.wwDBGrid1UpdateFooter(Sender: TObject);
begin
   SumQuery.active:= False;
   SumQuery.active:= True;
   wwDBGrid1.ColumnByName('Balance Due').FooterValue:=
      FloatToStrF(SumQuerySumOfBalanceDue.asFloat, ffCurrency, 10, 2);
   wwDBGrid1.ColumnByName('Total Invoice').FooterValue:=
      FloatToStrF(SumQuerySumOfTotalInvoice.asFloat, ffCurrency, 10, 2);
end;

end.
