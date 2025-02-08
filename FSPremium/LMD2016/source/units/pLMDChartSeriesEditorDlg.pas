unit pLMDChartSeriesEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Grids, Variants,
  LMDChartSeries, LMDChartValuesCollection, LMDChartSource, LMDChartValuesBase,
  LMDShSpinEdit, LMDUtils,
  pLMDChartValuesOptionsSelDlg;

type
  TLMDChartSeriesEditorDlg = class(TForm)
    btOK: TButton;
    btCancel: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lvSeriesType: TListView;
    sgData: TStringGrid;
    seRowCount: TLMDShSpinEdit;
    Label3: TLabel;
    btColOptions: TButton;
    Label4: TLabel;
    edSeriesName: TEdit;
    procedure seRowCountChange(Sender: TObject);
    procedure lvSeriesTypeClick(Sender: TObject);
    procedure btColOptionsClick(Sender: TObject);
  private
    { Private declarations }
    FChartSeries: TLMDCustomChartSeries;
    FForm: TForm;

    procedure ChartValuesToForm;
    procedure FormToChartValues;

    procedure SeriesToForm;
    procedure FormToSeries;
  public
    { Public declarations }

    procedure Edit(ASeries: TLMDCustomChartSeries);
  end;

implementation

{$R *.DFM}

{ TLMDChartSeriesEditor }

procedure TLMDChartSeriesEditorDlg.ChartValuesToForm;
var
  i, j: integer;
begin
  if not Assigned(Self.FChartSeries) then
        Exit;

  Self.seRowCount.Value := Self.FChartSeries.ChartValuesCollection.NumberOfValues;
  Self.sgData.RowCount := Self.seRowCount.Value + 3;
  Self.sgData.ColCount := Self.FChartSeries.ChartValuesCollection.Count;
  Self.edSeriesName.Text := Self.FChartSeries.Name;

  for i := 0 to Self.FChartSeries.ChartValuesCollection.Count - 1 do
  begin
    if Assigned(Self.FChartSeries.ChartValuesCollection.Items[i].ChartValues) then
    begin
      Self.sgData.Cells[i, 0] := Self.FChartSeries.ChartValuesCollection.Items[i].ChartValues.Name;
      Self.sgData.Cells[i, 1] := Self.FChartSeries.ChartValuesCollection.Items[i].ChartValues.Caption;
      Self.sgData.Cells[i, 2] := ChartValueTypeToStr(Self.FChartSeries.ChartValuesCollection.Items[i].ChartValues.ValueType);
      for j := 0 to Self.FChartSeries.ChartValuesCollection.Items[i].ChartValues.Count - 1 do
        Self.sgData.Cells[i, j + 3] := VarToStr(Self.FChartSeries.ChartValuesCollection.Items[i].ChartValues.Values[j]);
    end;
  end;
end;

procedure TLMDChartSeriesEditorDlg.Edit(ASeries: TLMDCustomChartSeries);
begin
  if not Assigned(ASeries) then
        Exit;
  FForm := LMDGetOwnerForm(ASeries);      
  Self.FChartSeries := ASeries;
  Self.SeriesToForm;
  if Self.ShowModal = mrOK then
  begin
    Self.FormToSeries;
    ASeries.RefreshParentCharts;
    if Assigned(FForm) then
        FForm.Designer.Modified;
  end;
end;

procedure TLMDChartSeriesEditorDlg.FormToChartValues;
var
  i, j: integer;
  CVItem: TLMDChartValuesCollectionItem;
begin
  if not Assigned(Self.FChartSeries) then
        Exit;

  Self.FChartSeries.Name := Self.edSeriesName.Text;
  Self.FChartSeries.ChartValuesCollection.Clear;

  for i := 0 to Self.sgData.ColCount - 1 do
  begin
    CVItem := Self.FChartSeries.ChartValuesCollection.Add;
    CVItem.ChartValues.Name := Self.sgData.Cells[i, 0];
    CVItem.ChartValues.Caption := Self.sgData.Cells[i, 1];
    CVItem.ChartValues.ValueType := StrToChartValueType(Self.sgData.Cells[i, 2]);
    CVItem.ChartValues.Count := Self.sgData.RowCount - 3;
    for j := 0 to Self.FChartSeries.ChartValuesCollection.Items[i].ChartValues.Count - 1 do
        Self.FChartSeries.ChartValuesCollection.Items[i].ChartValues.Values[j] := Self.sgData.Cells[i, j + 3];
  end;

end;

procedure TLMDChartSeriesEditorDlg.FormToSeries;
begin
  if not Assigned(Self.FChartSeries) then
        Exit;
  Self.FChartSeries.SeriesName := Self.edSeriesName.Text;
  Self.FormToChartValues;      
end;

procedure TLMDChartSeriesEditorDlg.SeriesToForm;
begin
  if not Assigned(Self.FChartSeries) then
        Exit;
  Self.edSeriesName.Text := Self.FChartSeries.SeriesName;
  Self.ChartValuesToForm;
end;

procedure TLMDChartSeriesEditorDlg.seRowCountChange(Sender: TObject);
var
  oldCount, i, j: integer;
begin
  Self.FChartSeries.ChartValuesCollection.NumberOfValues := Self.seRowCount.Value;
  oldCount := sgData.RowCount;
  Self.sgData.RowCount := Self.seRowCount.Value + 3;
  for j := oldCount to sgData.RowCount - 1 do
    for i := 0 to sgData.ColCount - 1 do
      sgData.Cells[i, j] := '';
end;

procedure TLMDChartSeriesEditorDlg.lvSeriesTypeClick(Sender: TObject);
var
  si: integer;
  LChartSource: TLMDCustomChartSource;
begin
  if MessageDlg('Changing the type of the series may lead to the loss of existing chart data. Continue?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    si := Self.lvSeriesType.Items.IndexOf(Self.lvSeriesType.Selected);
    LChartSource := nil;
    case si of
    0: LChartSource := TLMDXChartSource.Create(nil);
    1: LChartSource := TLMDXYChartSource.Create(nil);
    4: LChartSource := nil;
    else
        ShowMessage('The series type is not yet supported'); 
    end;
    if Assigned(LChartSource) then
    begin
        LChartSource.MakeSeriesCompatible(Self.FChartSeries);
        Self.ChartValuesToForm;
        LChartSource.Free;
    end;
    if Assigned(FForm) then
        FForm.Designer.Modified;
  end;
end;

procedure TLMDChartSeriesEditorDlg.btColOptionsClick(Sender: TObject);
var
  LChartValues: TLMDChartValuesBase;
  LColOptionsDlg: TLMDChartValuesOptionsSelector;
  ACol: integer;
begin
    ACol := sgData.Col;
    if Assigned(Self.FChartSeries) and Assigned(Self.FChartSeries.ChartValuesCollection)
     and (ACol < Self.FChartSeries.ChartValuesCollection.Count) then
    begin
      LChartValues := Self.FChartSeries.ChartValuesCollection[ACol].ChartValues;
      if Assigned(LChartValues) then
      begin
        LColOptionsDlg := TLMDChartValuesOptionsSelector.Create(nil);
        if LColOptionsDlg.Edit(LChartValues) then
        begin
          sgData.Cells[ACol, 0] := LChartValues.Name;
          sgData.Cells[ACol, 1] := LChartValues.Caption;
          sgData.Cells[ACol, 2] := ChartValueTypeToStr(LChartValues.ValueType);
        end;
        LColOptionsDlg.Free;
      end;
    end;
end;

end.
