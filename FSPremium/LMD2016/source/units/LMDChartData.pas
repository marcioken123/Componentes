unit LMDChartData;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################
LMDChartData unit
-----------------

Changes
-------

Created (06-June-2006)

--------
Since 18-June-2007 is a wrapper (adapter) for TLMDChartSeriesCollection
(the new data model for the chart); series objects of the TLMDChartSeriesCollection
correspond to columns, chartValues of series - to rows; row names are 'XLabels'
chart values of series, column names are series names of series; table values
are 'XValues' chart values of series.

-------
Since 17-November-2007 ChartData is transponed (rows are now columns, columns are now rows):
series objects of the TLMDChartSeriesCollection correspond to rows,
chartValues of series - to columns; column names are 'XLabels' chart values of series,
row names are series names of series;
The reason for this change is that in the current implementation of Chart Types
it gives much more natural results
###############################################################################}

interface

uses
  SysUtils, Classes, Controls, Graphics, Dialogs, Types, Variants, ExtCtrls, Math,
  LMDXML, LMDXMLNodeNames, LMDChartPersistent, LMDChartUtils, LMDChartLine,
  LMDChartBackground, LMDChartMarker, LMDChartSeries, LMDChartSeriesCollection,
  LMDChartSource, LMDChartValuesBase;

type
  TDataType = (dtMoney, dtNumber);
  TLMDSeriesOrientType = (sotRow, sotCol);
  TDynamicArray = array of array of variant;
  /// <summary>
  /// Represents chart data.
  /// </summary>
  { ************************** TLMDChartData ********************************* }
  TLMDChartData = class(TLMDChartPersistent)
  private
    function GetColCount: integer;
    function GetRowCount: integer;

    procedure ResizeInternalArrays;
  protected
    FChanged: boolean;
    AOwnerMy: TObject;
    FColumnsNames: array of string;
    FRowsWidth: array of integer; //custom width of bar (used when FRowAutoSize not set)
    FRowsLines: array of TLMDChartLine;
    FRowsNames: array of string;
    FRowsFill: array of TLMDChartBackground;
    FRowsMarkers: array of TLMDChartMarker;
    FColorScheme: array of TColor;
    FHighestValue: variant;
    FLowestValue: variant;
    FValuesType: TDataType;
    FValTypeIndicator: string;
    //FValues: array of array of variant;
    FHighestForStacked: boolean;

    FChartSeriesColl: TLMDChartSeriesColl;

    procedure SetValuesType(NewType: TDataType);
    procedure SetHighestForStacked(NewType: boolean);
    function GetHighestValue: variant;
    function GetLowestValue: variant;
  public
    procedure Assign(ASource: TPersistent); override;
    constructor Create(AOwner: TPersistent; ASeriesColl: TLMDChartSeriesColl);reintroduce;  
    destructor Destroy; override;

    procedure SetSeriesColl(ASeriesColl: TLMDChartSeriesColl);

    function IsChanged: boolean; override;
    procedure NoChanged; override;
    procedure SetChanged;
    /// <summary>
    /// Gets columns names
    /// </summary>
    function GetColumnsNames(AColumn: integer): string;
    /// <summary>
    /// Gets row fill
    /// </summary>
    function GetRowFill(ARow: integer): TLMDChartBackground;
    /// <summary>
    /// Gets row marker
    /// </summary>
    function GetRowMarker(ARow: integer): TLMDChartMarker;
    /// <summary>
    /// Gets rows lines
    /// </summary>
    function GetRowsLines(APosition: integer): TLMDChartLine;
    /// <summary>
    /// Gets rows names
    /// </summary>
    function GetRowsNames(ARow: integer): string;
    /// <summary>
    /// Gets table value
    /// </summary>
    function GetTableValue(AColumn, ARow: integer): real;
    /// <summary>
    /// Sets columns names
    /// </summary>
    procedure SetColumnsNames(AColumn: integer; AValue: string); overload;
    procedure SetColumnsNames(AColumn: integer; AValue: TDateTime; FSet: TFormatSettings); overload;
    procedure SetColumnsNames(AColumn: integer; AValue: TDateTime); overload;
    procedure SetColumnsNames(AColumn: integer; AValue: Currency; FSet: TFormatSettings); overload;
    procedure SetColumnsNames(AColumn: integer; AValue: Currency); overload;
    procedure SetColumnsNames(AColumn: integer; AValue: double); overload;
    /// <summary>
    /// Sets rows lines
    /// </summary>
    procedure SetRowsLines(APosition: integer; Value: TLMDChartLine);
    /// <summary>
    /// Sets rows name
    /// </summary>
    procedure SetRowsNames(ARow: integer; AValue: string); overload;
    procedure SetRowsNames(ARow: integer; AValue: TDateTime; FSet: TFormatSettings); overload;
    procedure SetRowsNames(ARow: integer; AValue: TDateTime); overload;
    procedure SetRowsNames(ARow: integer; AValue: Currency; FSet: TFormatSettings); overload;
    procedure SetRowsNames(ARow: integer; AValue: Currency); overload;
    procedure SetRowsNames(ARow: integer; AValue: double); overload;
    /// <summary>
    /// Sets row width
    /// </summary>
    procedure SetRowWidth(ARow, ASize: integer);
    /// <summary>
    /// Sets table size
    /// </summary>
    procedure SetTableSize(AColumn, ARow: integer);
    /// <summary>
    /// Sets table size
    /// </summary>
    procedure SetTableValue(AValue: real; AColumn, ARow: integer);
    /// <summary>
    /// Sets color scheme
    /// </summary>
    procedure SetColorScheme(const AColors: array of TColor);
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
    /// <summary>
    /// Loads inner object state to xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
    procedure InvertedRecalculate();
    procedure Get3ParametersPointArr(AOrient: TLMDSeriesOrientType; var Arr: TDynamicArray);
    procedure SetEmptyValue(ACol, ARow: integer);

    procedure Refresh;
  published
    property HighestValue: variant read GetHighestValue;
    property LowestValue: variant read GetLowestValue;
    property ValuesType: TDataType read FValuesType write SetValuesType;
    property RowCount: integer read GetRowCount default 3;
    property ColCount: integer read GetColCount default 3;
    property ValIndicator: string read FValTypeIndicator;
    property HighestForStacked: boolean read FHighestForStacked write SetHighestForStacked default false;
  end;

const
  EmptyID: integer = MaxInt;
  LMDDefaultColorTemplate: array[0..17] of TColor =
  (
    $00FF9933,
    clLime,
    clTeal,
    clMaroon,
    clSilver,
    clGreen,
    clOlive,
    clNavy,
    clPurple,
    clGray,
    clAqua,
    clRed,
    clBlue,
    clFuchsia,
    clYellow,
    clLtGray,
    clDkGray,
    clWhite
    );

implementation

{ *************************** TLMDChartData ********************************** }
{ --------------------------- private -----------------------------------------}

procedure TLMDChartData.SetHighestForStacked(NewType: boolean);
begin
  if FHighestForStacked <> NewType then
  begin
    FHighestForStacked := NewType;
    HighestOwnerRepaint;
    FChanged := true;
  end;
end;

{ --------------------------- private -----------------------------------------}

procedure TLMDChartData.SetValuesType(NewType: TDataType);
begin
  FValuesType := NewType;
  if FValuesType = dtNumber then
    FValTypeIndicator := '';
  if FValuesType = dtMoney then
    FValTypeIndicator := ' ' + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}CurrencyString;
  FChanged := true;
end;

{ --------------------------- private -----------------------------------------}

function TLMDChartData.GetHighestValue: variant;
var
  arr: array of double;
  max, tmp: double;
  i, j: integer;
begin
  if FHighestForStacked then
  begin
    SetLength(arr, RowCount);
    for i := 0 to RowCount - 1 do
    begin
      max := MinDouble;
      for j := 0 to ColCount - 1 do
      begin
        tmp := GetTableValue(j, i);
        if tmp = EmptyID then
          tmp := 0;
        if tmp > max then
          max := tmp;
      end;
      arr[i] := max;
    end;
    max := 0;
    for i := 0 to RowCount - 1 do
      max := max + arr[i];
    GetHighestValue := max;
  end
  else
    GetHighestValue := FHighestValue;
end;

{ --------------------------- private -----------------------------------------}

function TLMDChartData.GetLowestValue: variant;
begin
  GetLowestValue := FLowestValue;
end;

{ --------------------------- public ------------------------------------------}

procedure TLMDChartData.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
{var
  WorkNode, IterNode, ArrayNode: ILMDXmlNode;
  i, j: integer;}
begin
  {
  WorkNode := BaseNode.NeedChild(NNChartData + Comment);
  //----------
  IterNode := WorkNode.NeedChild('ColumnsNames');
  SetLength(FColumnsNames, IterNode.ChildNodes.Count);
  for i := 0 to IterNode.ChildNodes.Count - 1 do
  begin
    ArrayNode := IterNode.NeedChild('i' + inttostr(i));
    FColumnsNames[i] := ArrayNode.GetVarAttr('value', 0);
  end;
  //----------
  IterNode := WorkNode.NeedChild('RowsWidth');
  SetLength(FRowsWidth, IterNode.ChildNodes.Count);
  for i := 0 to IterNode.ChildNodes.Count - 1 do
  begin
    ArrayNode := IterNode.NeedChild('i' + inttostr(i));
    FRowsWidth[i] := ArrayNode.GetVarAttr('value', 0);
  end;
  //----------
  IterNode := WorkNode.NeedChild('RowsFill');
  SetLength(FRowsFill, IterNode.ChildNodes.Count);
  for i := 0 to IterNode.ChildNodes.Count - 1 do
  begin
    ArrayNode := IterNode.NeedChild('i' + inttostr(i));
    FRowsFill[i] := TLMDChartBackground.Create(AOwnerMy);
    FRowsFill[i].LoadStateFromXML(ArrayNode, inttostr(i));
  end;
  //----------
  IterNode := WorkNode.NeedChild('RowsLines');
  SetLength(FRowsLines, IterNode.ChildNodes.Count);
  for i := 0 to IterNode.ChildNodes.Count - 1 do
  begin
    ArrayNode := IterNode.NeedChild('i' + inttostr(i));
    FRowsLines[i] := TLMDChartLine.create(AOwnerMy);
    FRowsLines[i].LoadStateFromXML(ArrayNode, inttostr(i));
  end;
  //----------
  IterNode := WorkNode.NeedChild('RowsNames');
  SetLength(FRowsNames, IterNode.ChildNodes.Count);
  for i := 0 to IterNode.ChildNodes.Count - 1 do
  begin
    ArrayNode := IterNode.NeedChild('i' + inttostr(i));
    FRowsNames[i] := ArrayNode.GetVarAttr('value', 0);
  end;
  //----------
  IterNode := WorkNode.NeedChild('RowsMarkers');
  SetLength(FRowsMarkers, IterNode.ChildNodes.Count);
  for i := 0 to IterNode.ChildNodes.Count - 1 do
  begin
    ArrayNode := IterNode.NeedChild('i' + inttostr(i));
    FRowsMarkers[i] := TLMDChartMarker.create(AOwnerMy);
    FRowsMarkers[i].LoadStateFromXML(ArrayNode, inttostr(i));
  end;
  //----------
  IterNode := WorkNode.NeedChild('ColorScheme');
  SetLength(FColorScheme, IterNode.ChildNodes.Count);
  for i := 0 to IterNode.ChildNodes.Count - 1 do
  begin
    ArrayNode := IterNode.NeedChild('i' + inttostr(i));
    FColorScheme[i] := TColor(ArrayNode.GetVarAttr('value', 0));
  end;
  //----------
  IterNode := WorkNode.NeedChild('HighestValue');
  FHighestValue := IterNode.GetVarAttr('value', 0);
  //----------
  IterNode := WorkNode.NeedChild('LowestValue');
  FLowestValue := IterNode.GetVarAttr('value', 0);
  //----------
  IterNode := WorkNode.NeedChild('RowCount');
  //RowCount := IterNode.GetVarAttr('value', 0);
  //----------
  IterNode := WorkNode.NeedChild('ColCount');
  //ColCount := IterNode.GetVarAttr('value', 0);
  //----------
  IterNode := WorkNode.NeedChild('ValuesType');
  ValuesType := TDataType(IterNode.GetVarAttr('value', 0));
  //----------
  IterNode := WorkNode.NeedChild('Values');
  SetLength(FValues, IterNode.ChildNodes.Count);
  for i := 0 to ColCount - 1 do
  begin
    SetLength(FValues[i], IterNode.ChildNodes.Count);
    for j := 0 to RowCount - 1 do
    begin
      ArrayNode := IterNode.NeedChild('i' + inttostr(i) + 'i' + inttostr(j));
      FValues[i, j] := ArrayNode.GetFloatAttr('value', 0);
    end;
  end;
  FChanged := true;
  }
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
{var
  WorkNode, IterNode, ArrayNode: ILMDXmlNode;
  i, j: integer; }
begin
  {
  WorkNode := BaseNode.EnsureChild(NNChartData + Comment);
  //----------
  IterNode := WorkNode.EnsureChild('ColumnsNames');
  for i := 0 to length(FColumnsNames) - 1 do
  begin
    ArrayNode := IterNode.AppendElement('i' + inttostr(i));
    ArrayNode.SetVarAttr('value', FColumnsNames[i]);
  end;
  //----------
  IterNode := WorkNode.EnsureChild('RowsWidth');
  for i := 0 to length(FRowsWidth) - 1 do
  begin
    ArrayNode := IterNode.AppendElement('i' + inttostr(i));
    ArrayNode.SetVarAttr('value', FRowsWidth[i]);
  end;
  //----------
  IterNode := WorkNode.EnsureChild('RowsLines');
  for i := 0 to length(FRowsLines) - 1 do
  begin
    ArrayNode := IterNode.AppendElement('i' + inttostr(i));
    FRowsLines[i].SaveStateToXML(ArrayNode, inttostr(i));
  end;
  //----------
  IterNode := WorkNode.EnsureChild('RowsNames');
  for i := 0 to length(FRowsNames) - 1 do
  begin
    ArrayNode := IterNode.AppendElement('i' + inttostr(i));
    ArrayNode.SetVarAttr('value', FRowsNames[i]);
  end;
  //----------
  IterNode := WorkNode.EnsureChild('RowsFill');
  for i := 0 to length(FRowsFill) - 1 do
  begin
    ArrayNode := IterNode.AppendElement('i' + inttostr(i));
    FRowsFill[i].SaveStateToXML(ArrayNode, inttostr(i));
  end;
  //----------
  IterNode := WorkNode.EnsureChild('RowsMarkers');
  for i := 0 to length(FRowsMarkers) - 1 do
  begin
    ArrayNode := IterNode.AppendElement('i' + inttostr(i));
    FRowsMarkers[i].SaveStateToXML(ArrayNode, inttostr(i));
  end;
  //----------
  IterNode := WorkNode.EnsureChild('ColorScheme');
  for i := 0 to length(FColorScheme) - 1 do
  begin
    ArrayNode := IterNode.AppendElement('i' + inttostr(i));
    ArrayNode.SetVarAttr('value', FColorScheme[i]);
  end;
  //----------
  IterNode := WorkNode.AppendElement('HighestValue');
  IterNode.SetVarAttr('value', FHighestValue);
  //----------
  IterNode := WorkNode.AppendElement('LowestValue');
  IterNode.SetVarAttr('value', FLowestValue);
  //----------
  IterNode := WorkNode.AppendElement('RowCount');
  IterNode.SetVarAttr('value', RowCount);
  //----------
  IterNode := WorkNode.AppendElement('ColCount');
  IterNode.SetVarAttr('value', ColCount);
  //----------
  IterNode := WorkNode.AppendElement('ValuesType');
  IterNode.SetVarAttr('value', Variant(valuesType));
  //----------
  IterNode := WorkNode.AppendElement('Values');
  for i := 0 to length(FValues) - 1 do
    for j := 0 to length(FValues[i]) - 1 do
    begin
      ArrayNode := IterNode.AppendElement('i' + inttostr(i) + 'i' + inttostr(j));
      ArrayNode.SetFloatAttr('value', FValues[i, j]);
    end;
  }  
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartData.IsChanged: boolean;
begin
  IsChanged := FChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartData.NoChanged;
begin
  FChanged := false;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartData.InvertedRecalculate();
var
  i, j: integer;
  tmpr: real;
  tmps: string;
begin
  for i := 0 to RowCount - 1 do
    for j := 0 to (ColCount div 2) - 1 do
    begin
      tmpr := GetTableValue(j, i);
      SetTableValue(GetTableValue(ColCount - 1 - j, i), j, i);
      SetTableValue(tmpr, ColCount - 1 - j, i);
    end;
  for j := 0 to (ColCount div 2) - 1 do
  begin
    tmps := GetColumnsNames(j);
    SetColumnsNames(j, GetColumnsNames(ColCount - 1 - j));
    SetColumnsNames(ColCount - 1 - j, tmps);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartData.Assign(ASource: TPersistent);
var
  i: integer;
begin
  if ASource is TLMDChartData then
  begin
    try
      self.SetTableSize(ColCount, RowCount);
      for i := 0 to ColCount - 1 do
      begin
        FColumnsNames[i] := TLMDChartData(ASource).FColumnsNames[i];
      end;
      for i := 0 to RowCount - 1 do
      begin
        FRowsNames[i] := TLMDChartData(ASource).FRowsNames[i];
        FRowsMarkers[i].Assign(TLMDChartData(ASource).FRowsMarkers[i]);
        FRowsLines[i].Assign(TLMDChartData(ASource).FRowsLines[i]);
        FRowsFill[i].Assign(TLMDChartData(ASource).FRowsFill[i]);
      end;
      FRowsWidth := copy(TLMDChartData(ASource).FRowsWidth);
      FColorScheme := copy(TLMDChartData(ASource).FColorScheme);
      FHighestValue := TLMDChartData(ASource).FHighestValue;
      FLowestValue := TLMDChartData(ASource).FLowestValue;
      FValuesType := TLMDChartData(ASource).FValuesType;
      //FValues := Copy(TLMDChartData(ASource).FValues);
      FValTypeIndicator := TLMDChartData(ASource).FValTypeIndicator;
      AOwnerMy := TLMDChartData(ASource).AOwnerMy;

      Self.FChartSeriesColl := TLMDChartData(ASource).FChartSeriesColl;
    finally
    end;
  end;
  inherited Assign(ASource);
end;

{ -----------------------------------------------------------------------------}

constructor TLMDChartData.Create(AOwner: TPersistent; ASeriesColl: TLMDChartSeriesColl);
begin
  inherited Create(AOwner);
  AOwnerMy := AOwner;
  Self.SetSeriesColl(ASeriesColl);

  SetLength(FColorScheme, 0);
  SetColorScheme(LMDDefaultColorTemplate);
  SetLength(FRowsFill, 0);
  SetLength(FRowsMarkers, 0);
  SetLength(FRowsLines, 0);
  FHighestValue := 0;
  FLowestValue := 0;
  FHighestForStacked := false;
  ValuesType := dtNumber;
  //SetLength(FValues, ColCount, RowCount);
  SetLength(FRowsWidth, 0);
  SetLength(FRowsNames, 0);
  SetLength(FColumnsNames, 0);
  FValTypeIndicator := '';
end;

{ -----------------------------------------------------------------------------}

destructor TLMDChartData.Destroy;
var
  i: integer;
begin
  //FValues := nil;
  FRowsWidth := nil;
  for i := 0 to Length(FRowsLines) - 1 do
    FRowsLines[i].Free;
  for i := 0 to Length(FRowsFill) - 1 do
    FRowsFill[i].Free;
  for i := 0 to Length(FRowsMarkers) - 1 do
    FRowsMarkers[i].Free;
  inherited Destroy;
end;

function TLMDChartData.GetColCount: integer;
begin
  Result := 0;
  if Assigned(Self.FChartSeriesColl) then
    Result := Self.FChartSeriesColl.MaxNumberOfValues;
end;

function TLMDChartData.GetColumnsNames(AColumn: integer): string;
var
  chartSource: TLMDXChartSource;
begin
  result := ' ';
  chartSource := TLMDXChartSource.Create(nil);
  if chartSource.IsCompatibleWithSeries(Self.FChartSeriesColl.Items[0].Series)
    then
    begin
      chartSource.Series := Self.FChartSeriesColl.Items[0].Series;
      if (AColumn >= 0) and (AColumn < ColCount) then
        result := chartSource.XLabels.Values[AColumn];
    end;
  chartSource.Free;
end;

{ -----------------------------------------------------------------------------}

function TLMDChartData.GetRowCount: integer;
begin
  if Assigned(Self.FChartSeriesColl) then
    Result := Self.FChartSeriesColl.Count
  else
    Result := 0;
end;

function TLMDChartData.GetRowFill(ARow: integer): TLMDChartBackground;
begin
  Result := nil;
  if (ARow < 0) or (ARow >= Self.FChartSeriesColl.Count) then
    Exit;
  Result := Self.FChartSeriesColl[ARow].Fill;
  {
  Self.ResizeInternalArrays;
  if ARow < 0 then
  begin
    FRowsFill[0].Style := cbsSolid;
    result := FRowsFill[0];
  end
  else
    if ARow >= RowCount then
    begin
      FRowsFill[RowCount - 1].Style := cbsSolid;
      result := FRowsFill[RowCount - 1];
    end
    else
    begin
      FRowsFill[ARow].Style := cbsSolid;
      result := FRowsFill[ARow];
    end;
  }  
end;

{ -----------------------------------------------------------------------------}

function TLMDChartData.GetRowMarker(ARow: integer): TLMDChartMarker;
begin
  {
  Self.ResizeInternalArrays;
  if ARow < 0 then
    result := FRowsMarkers[0]
  else
    if ARow >= RowCount then
      result := FRowsMarkers[RowCount - 1]
    else
      result := FRowsMarkers[ARow];
   }
  Result := nil;
  if (ARow < 0) or (ARow >= Self.FChartSeriesColl.Count) then
    Exit;
  Result := Self.FChartSeriesColl[ARow].Marker;    
end;

{ -----------------------------------------------------------------------------}

function TLMDChartData.GetRowsLines(APosition: integer): TLMDChartLine;
begin
  Result := nil;
  if (APosition < 0) or (APosition >= Self.FChartSeriesColl.Count) then
    Exit;
  Result := Self.FChartSeriesColl[APosition].Line;
  {
  Self.ResizeInternalArrays;
  if APosition < 0 then
    result := FRowsLines[0]
  else
    if APosition >= RowCount then
      result := FRowsLines[RowCount - 1]
    else
      result := FRowsLines[APosition];
   }
end;

{ -----------------------------------------------------------------------------}

function TLMDChartData.GetRowsNames(ARow: integer): string;
begin
  result := '';
  if (ARow < 0) or (ARow >= RowCount) then
    exit;
  if Assigned(Self.FChartSeriesColl.Items[ARow].Series) then
    result := Self.FChartSeriesColl.Items[ARow].Series.SeriesName;
end;

{ -----------------------------------------------------------------------------}

function TLMDChartData.GetTableValue(AColumn, ARow: integer): real;
var
  chartSource: TLMDXChartSource;
begin
  result := 0;
  chartSource := TLMDXChartSource.Create(nil);
   if chartSource.IsCompatibleWithSeries(Self.FChartSeriesColl.Items[ARow].Series)
    then
    begin
      if (ARow >= 0) and (ARow < RowCount) and (AColumn >= 0) and (AColumn < ColCount) then
      begin
        chartSource.Series := Self.FChartSeriesColl.Items[ARow].Series;
        result := chartSource.XValues.Values[AColumn];
      end;
    end;
  chartSource.Free;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetColumnsNames(AColumn: integer; AValue: string);
var
  chartSource: TLMDXChartSource;
begin
 if (AColumn < 0) or (AColumn >= ColCount) then
    exit;
  chartSource := TLMDXChartSource.Create(nil);
  if not (Assigned(Self.FChartSeriesColl) and (Self.FChartSeriesColl.Count > 0)
    and Assigned(Self.FChartSeriesColl.Items[0].Series)) then
    Exit;
  if chartSource.IsCompatibleWithSeries(Self.FChartSeriesColl.Items[0].Series)
    then
    begin
      chartSource.Series := Self.FChartSeriesColl.Items[0].Series;
    if Assigned(chartSource.Series) and (AColumn >= 0) and (AColumn < ColCount) then
        chartSource.XLabels.Values[AColumn] := AValue;
    end;
  chartSource.Free;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetColumnsNames(AColumn: integer; AValue: double);
begin
  Self.SetColumnsNames(AColumn, floattostr(AValue));
end;

{ -----------------------------------------------------------------------------}

//procedure TLMDChartData.SetColumnsNames(AColumn: integer; AValue: Currency; FSet: TFormatSettings);
//begin
//  Self.SetColumnsNames(AColumn, CurrToStr(AValue, FSet));
//end;

procedure TLMDChartData.SetColumnsNames(AColumn: integer; AValue: Currency; FSet: TFormatSettings);
begin
{$IFNDEF LMDCOMP7}
  CurrencyFormat := FSet.CurrencyFormat;
  NegCurrFormat := FSet.NegCurrFormat;
  ThousandSeparator := FSet.ThousandSeparator;
  DecimalSeparator := FSet.DecimalSeparator;
  CurrencyDecimals := FSet.CurrencyDecimals;
  DateSeparator := FSet.DateSeparator;
  TimeSeparator := FSet.TimeSeparator;
  ListSeparator := FSet.ListSeparator;
  CurrencyString := FSet.CurrencyString;
  ShortDateFormat := FSet.ShortDateFormat;
  LongDateFormat := FSet.LongDateFormat;
  TimeAMString := FSet.TimeAMString;
  TimePMString := FSet.TimePMString;
  ShortTimeFormat := FSet.ShortTimeFormat;
  LongTimeFormat := FSet.LongTimeFormat;
  Self.SetColumnsNames(AColumn, CurrToStr(AValue));
{$ENDIF}
{$IFDEF LMDCOMP7}
  Self.SetColumnsNames(AColumn, CurrToStr(AValue, FSet));
{$ENDIF}
end;


{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetColumnsNames(AColumn: integer; AValue: Currency);
begin
  Self.SetColumnsNames(AColumn, CurrToStr(AValue));
end;

{ -----------------------------------------------------------------------------}

//procedure TLMDChartData.SetColumnsNames(AColumn: integer; AValue: TDateTime; FSet: TFormatSettings);
//begin
//  Self.SetColumnsNames(AColumn, DateTimeToStr(AValue, FSet));
//end;

procedure TLMDChartData.SetColumnsNames(AColumn: integer; AValue: TDateTime; FSet: TFormatSettings);
begin
{$IFNDEF LMDCOMP7}
  CurrencyFormat := FSet.CurrencyFormat;
  NegCurrFormat := FSet.NegCurrFormat;
  ThousandSeparator := FSet.ThousandSeparator;
  DecimalSeparator := FSet.DecimalSeparator;
  CurrencyDecimals := FSet.CurrencyDecimals;
  DateSeparator := FSet.DateSeparator;
  TimeSeparator := FSet.TimeSeparator;
  ListSeparator := FSet.ListSeparator;
  CurrencyString := FSet.CurrencyString;
  ShortDateFormat := FSet.ShortDateFormat;
  LongDateFormat := FSet.LongDateFormat;
  TimeAMString := FSet.TimeAMString;
  TimePMString := FSet.TimePMString;
  ShortTimeFormat := FSet.ShortTimeFormat;
  LongTimeFormat := FSet.LongTimeFormat;
  Self.SetColumnsNames(AColumn, DateTimeToStr(AValue));
{$ENDIF}
{$IFDEF LMDCOMP7}
  Self.SetColumnsNames(AColumn, DateTimeToStr(AValue, FSet));
{$ENDIF}
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetColumnsNames(AColumn: integer; AValue: TDateTime);
begin
  Self.SetColumnsNames(AColumn, DateTimeToStr(AValue));
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetRowsLines(APosition: integer; Value: TLMDChartLine);
begin
  if (APosition < 0) or (APosition >= Self.FChartSeriesColl.Count) then
    Exit;
  Self.FChartSeriesColl[APosition].Line := Value;
  {
  Self.ResizeInternalArrays;
  if (APosition < 0) or (APosition >= RowCount) then
    exit;
  FRowsLines[APosition].Assign(Value);
  }
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetRowsNames(ARow: integer; AValue: string);
begin
  if (ARow < 0) or (ARow >= RowCount) then
    exit;
  Self.FChartSeriesColl.Items[ARow].Series.SeriesName := AValue;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetRowsNames(ARow: integer; AValue: double);
begin
  Self.SetRowsNames(ARow, floattostr(AValue));
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetRowsNames(ARow: integer; AValue: Currency; FSet: TFormatSettings);
begin
  Self.SetRowsNames(ARow, CurrToStr(AValue  {$IFDEF LMDCOMP7}, FSet{$ENDIF}));
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetRowsNames(ARow: integer; AValue: Currency);
begin
  Self.SetRowsNames(ARow, CurrToStr(AValue));
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetRowsNames(ARow: integer; AValue: TDateTime; FSet: TFormatSettings);
begin
  Self.SetRowsNames(ARow, DateTimeToStr(AValue {$IFDEF LMDCOMP7}, FSet{$ENDIF}));
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetRowsNames(ARow: integer; AValue: TDateTime);
begin
  Self.SetRowsNames(ARow, DateTimeToStr(AValue));
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetRowWidth(ARow, ASize: integer);
begin
  Self.ResizeInternalArrays;
  if (ARow < 0) or (ARow >= RowCount) then
    exit;
  FRowsWidth[ARow] := 10;
  HighestOwnerRepaint;
end;

procedure TLMDChartData.SetSeriesColl(ASeriesColl: TLMDChartSeriesColl);
begin
  Self.FChartSeriesColl := ASeriesColl;
  Self.ResizeInternalArrays;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetTableSize(AColumn, ARow: integer);
var
  i, oldX: integer;
  LSeries: TLMDChartSeries;
  LOwner: TComponent;
  LChartSource: TLMDXChartSource;
  LSeriesItem: TLMDChartSeriesCollectionItem;
begin
  //since rows are now a collection explicitly formed by the user
  //who creates series objects and links them to the chart,
  //here we should only set the number of columns(chart values) for all the existing series,
  //and ARow parameter is to be ignored and the number of series remains the same

  //however for some backward compatibility (e.g. adding sample data in Chart constructor)
  //we still support 'automatic' creation
  //of missing series (if new RowCount is greater than current) and assume they're 'standard' XAxis in-memory series

  oldX := RowCount;

  if Assigned(Self.AOwnerMy) and (Self.AOwnerMy is TComponent) then
    LOwner := Self.AOwnerMy as TComponent
  else
    LOwner := nil;
  LChartSource := TLMDXChartSource.Create(nil);  

  for i := oldX to ARow - 1 do
  begin
    LSeries := TLMDChartSeries.Create(LOwner);
    LChartSource.MakeSeriesCompatible(LSeries);
    LSeriesItem := TLMDChartSeriesCollectionItem.Create(Self.FChartSeriesColl);
    LSeriesItem.Series := LSeries;
  end;

  //setting number of values in all the series to AColumn number
  for i := 0 to Self.FChartSeriesColl.Count - 1 do
      Self.FChartSeriesColl.Items[i].Series.Count := AColumn;

  Self.ResizeInternalArrays;
  HighestOwnerRepaint;

  LChartSource.Free;
end;

procedure TLMDChartData.ResizeInternalArrays;
var
  i, oldY: integer;
begin
  if not Assigned(Self.FChartSeriesColl) then
    Exit;

  //resize FRowWidth
  oldY := Length(FRowsWidth);
  SetLength(FRowsWidth, RowCount);
  //fill new elements with default width of bar
  for i := oldY to RowCount - 1 do
    FRowsWidth[i] := 10;

  //resize the bars lines array
  oldY := Length(FRowsLines);
  //ShowMessage(IntToStr(oldY) + ', ' + IntToStr(RowCount));  
  if oldY < RowCount then
  begin
    SetLength(FRowsLines, RowCount);
    for i := oldY to RowCount - 1 do
      FRowsLines[i] := TLMDChartLine.Create(FMainOwner);
  end
  else
    if oldY > RowCount then
    begin
      for i := RowCount downto oldY - 1 do
        FRowsLines[i].Free;
      SetLength(FRowsLines, RowCount);
    end;

  //resize the bars fill array
  oldY := Length(FRowsFill);
  if oldY < RowCount then
  begin
    SetLength(FRowsFill, RowCount);
    for i := oldY to RowCount - 1 do
    begin
      FRowsFill[i] := TLMDChartBackground.Create(FMainOwner);
      if length(FColorScheme) > 0 then
        FRowsFill[i].SolidColor := FColorScheme[(i mod length(FColorScheme))];
    end;
  end
  else
    if oldY > RowCount then
    begin
      for i := RowCount downto oldY - 1 do
        FRowsFill[i].Free;
      SetLength(FRowsFill, RowCount);
    end;

  //resize the bars markers array
  oldY := Length(FRowsMarkers);
  if oldY < RowCount then
  begin
    SetLength(FRowsMarkers, RowCount);
    for i := oldY to RowCount - 1 do
    begin
      FRowsMarkers[i] := TLMDChartMarker.Create(FMainOwner);
      //if i <= 20 then FRowsMarkers[i].Color := LMDDefaultColorTemplate[i];
    end;
  end
  else
    if oldY > RowCount then
    begin
      for i := RowCount downto oldY - 1 do
        FRowsMarkers[i].Free;
      SetLength(FRowsMarkers, RowCount);
    end;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetTableValue(AValue: real; AColumn, ARow: integer);
var
  chartSource: TLMDXChartSource;
begin
  chartSource := TLMDXChartSource.Create(nil);
  if AValue = EmptyID then
    AValue := 0;
  if AValue > FHighestValue then
    FHighestValue := AValue;
  if AValue < FLowestValue then
    FLowestValue := AValue;
  if (ARow > 0) and (ARow < RowCount) and (AColumn > 0) and (AColumn < ColCount) then
    begin
      if chartSource.IsCompatibleWithSeries(Self.FChartSeriesColl.Items[ARow].Series)
      then
      begin
        chartSource.Series := Self.FChartSeriesColl.Items[ARow].Series;
        chartSource.XValues.Values[AColumn] := AValue;
      end;
    end;
  chartSource.Free;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.SetColorScheme(const AColors: array of TColor);
var
  i: integer;
begin
  Self.ResizeInternalArrays;
  if length(AColors) < 0 then
    exit;

  Setlength(FColorScheme, Length(AColors));

  for i := 0 to Length(AColors) - 1 do
    FColorScheme[i] := AColors[i];

  for i := 0 to length(FRowsFill) - 1 do
    FRowsFill[i].SolidColor := FColorScheme[i mod length(FColorScheme)];
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartData.Get3ParametersPointArr(AOrient: TLMDSeriesOrientType;
  var Arr: TDynamicArray);
var
  workn, i, j, k: integer;
begin
  if AOrient = sotRow then
    workn := RowCount
  else
    workn := ColCount;
  case workn of

    0, 1:
      begin
        Arr := nil; // can't give 3 parameters
      end;

    2:
      begin // give with 1 index of column
        // for series in columns
        if AOrient = sotCol then
        begin
          SetLength(Arr, RowCount);
          for i := 0 to RowCount - 1 do
            SetLength(Arr[i], 3);
          for i := 0 to RowCount - 1 do
            for j := 0 to 2 do
              if j = 0 then
                Arr[i, j] := i
              else
                Arr[i, j] := GetTableValue(j - 1, i);
        end
          // for series in rows
        else
        begin
          SetLength(Arr, ColCount);
          for i := 0 to ColCount - 1 do
            SetLength(Arr[i], 3);
          for i := 0 to ColCount - 1 do
            for j := 0 to 2 do
              if j = 0 then
                Arr[i, j] := i
              else
                Arr[i, j] := GetTableValue(i, j - 1);
        end;
      end;

    3:
      begin // give all 3 parameters
        // for series in columns
        if AOrient = sotCol then
        begin
          SetLength(Arr, RowCount);
          for i := 0 to RowCount - 1 do
            SetLength(Arr[i], 3);
          for i := 0 to RowCount - 1 do
            for j := 0 to 2 do
              Arr[i, j] := GetTableValue(j, i);
        end
          // for series in rows
        else
        begin
          SetLength(Arr, ColCount);
          for i := 0 to ColCount - 1 do
            SetLength(Arr[i], 3);
          for i := 0 to ColCount - 1 do
            for j := 0 to 2 do
              Arr[i, j] := GetTableValue(i, j);
        end;
      end;

  else
    case (workn mod 3) of

      0:
        begin // give all 3 parameters for all points
          // for series in columns
          if AOrient = sotCol then
          begin
            SetLength(Arr, RowCount * (workn div 3));
            for i := 0 to Length(Arr) - 1 do
              SetLength(Arr[i], 3);
            for k := 0 to (workn div 3 - 1) do
              for i := 0 to RowCount - 1 do
                for j := 0 to 2 do
                  Arr[i + RowCount * k, j] := GetTableValue(j + 3 * k, i);
          end
            // for series in rows
          else
          begin
            SetLength(Arr, ColCount * (workn div 3));
            for i := 0 to Length(Arr) - 1 do
              SetLength(Arr[i], 3);
            for k := 0 to (workn div 3 - 1) do
              for i := 0 to ColCount - 1 do
                for j := 0 to 2 do
                  Arr[i + ColCount * k, j] := GetTableValue(i, j + 3 * k);
          end;
        end;

    else
      case (workn mod 2) of

        0:
          begin // give with 1 index of column for all points
            // for series in columns
            if AOrient = sotCol then
            begin
              SetLength(Arr, RowCount * (workn div 2));
              for i := 0 to Length(Arr) - 1 do
                SetLength(Arr[i], 3);
              for k := 0 to (workn div 2 - 1) do
                for i := 0 to RowCount - 1 do
                  for j := 0 to 2 do
                    if j = 0 then
                      Arr[i + k * RowCount, j] := i + k * RowCount
                    else
                      Arr[i + k * RowCount, j] := GetTableValue(j + 2 * k - 1, i);
            end
              // for series in rows
            else
            begin
              SetLength(Arr, ColCount * (workn div 2));
              for i := 0 to Length(Arr) - 1 do
                SetLength(Arr[i], 3);
              for k := 0 to (workn div 2 - 1) do
                for i := 0 to ColCount - 1 do
                  for j := 0 to 2 do
                    if j = 0 then
                      Arr[i + k * ColCount, j] := i + k * ColCount
                    else
                      Arr[i + k * ColCount, j] := GetTableValue(i, j + 2 * k - 1);
            end;
          end;

        1:
          begin // give with first parameter as X value for all points
            // for series in columns
            if AOrient = sotCol then
            begin
              SetLength(Arr, RowCount * (workn div 2));
              for i := 0 to Length(Arr) - 1 do
                SetLength(Arr[i], 3);
              for k := 0 to (workn div 2 - 1) do
                for i := 0 to RowCount - 1 do
                  for j := 0 to 2 do
                    if j = 0 then
                      Arr[i + RowCount * k, j] := GetTableValue(0, i)
                    else
                      Arr[i + RowCount * k, j] := GetTableValue(j + 2 * k, i);
            end
              // for series in rows
            else
            begin
              SetLength(Arr, ColCount * (workn div 2));
              for i := 0 to Length(Arr) - 1 do
                SetLength(Arr[i], 3);
              for k := 0 to (workn div 2 - 1) do
                for i := 0 to ColCount - 1 do
                  for j := 0 to 2 do
                    if j = 0 then
                      Arr[i + ColCount * k, j] := GetTableValue(i, 0)
                    else
                      Arr[i + ColCount * k, j] := GetTableValue(i, j + 2 * k);
            end;
          end;
      end; // case (workn mod 2) of
    end; //case (workn mod 3) of

  end; // case workn of
end;

procedure TLMDChartData.SetEmptyValue(ACol, ARow: integer);
begin
  self.SetTableValue(EmptyID, ACol, ARow);
end;

procedure TLMDChartData.Refresh;
var
  i, j, k: integer;
  val: variant;
  Lcvt: TLMDChartValueType;
begin
  Self.ResizeInternalArrays;
  Self.FHighestValue := 0;
  Self.FLowestValue := 0;

  if not Assigned(Self.FChartSeriesColl) then
        Exit;

  for i := 0 to Self.FChartSeriesColl.Count - 1 do
  begin
    if Assigned(Self.FChartSeriesColl.Items[i].Series) then
        for j := 0 to Self.FChartSeriesColl.Items[i].Series.ChartValuesCollection.Count - 1 do
        begin
          if Assigned(Self.FChartSeriesColl.Items[i].Series.ChartValuesCollection.Items[j].ChartValues) then
          begin
            Lcvt := Self.FChartSeriesColl.Items[i].Series.ChartValuesCollection.Items[j].ChartValues.ValueType;
            if (Lcvt = cvtNumber) or (Lcvt = cvtMoney) then
                  for k := 0 to Self.FChartSeriesColl.Items[i].Series.ChartValuesCollection.Items[j].ChartValues.Count - 1 do
                  begin
                        val := Self.FChartSeriesColl.Items[i].Series.ChartValuesCollection.Items[j].ChartValues.Values[k];
                        if CompareTypedChartValues(val, Self.FHighestValue, Lcvt) > 0 then
                                Self.FHighestValue := val;
                        if CompareTypedChartValues(val, Self.FLowestValue, Lcvt) < 0 then
                                Self.FLowestValue := val;
                  end;
          end;        
        end;
  end;
end;

procedure TLMDChartData.SetChanged;
begin
  Self.FChanged := true;
end;

end.
