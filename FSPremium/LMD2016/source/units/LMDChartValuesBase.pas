unit LMDChartValuesBase;
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
LMDChartValuesBase unit
-----------------------------------

Changes
-------
Created (12-June-2007)

###############################################################################}

interface

uses
  SysUtils, Classes, Controls, Graphics, Types, Variants, Math,
  LMDChartPersistent;

type
  TLMDChartValueType = (cvtNumber, cvtMoney, cvtDate, cvtLabel, cvtUnknown);
  { ************************ TLMDChartValues ********************************** }
  /// <summary>
  /// The base class for representation of one set of values for a chart series
  // (e.g. often - one and single _value_ for simple one-values series like
  // bar or column series, or X labels, or Y labels); this set of values should
  // not be confused with coordinate axis - there can be 2 axises and 3
  //(like for bubble series) or 4 (like for 'open-high-low-close' financial series)
  // sets of values
  /// </summary>
  TLMDChartValuesBase = class(TLMDChartPersistent)
  private
    FName: string;
    FLowestValue: Variant;
    FHighestValue: Variant;
    FCaption: string;
    FParentCharts: TList;

    procedure SetName(val : string);
    function GetName : string;

  protected
    function GetValues(Index: Integer): Variant; virtual;
    procedure SetValues(Index: Integer; Value: Variant); virtual;
    function GetCount : Integer; virtual; abstract;
    procedure SetCount(const Value: Integer); virtual;

    function GetValueType: TLMDChartValueType; virtual;abstract;
    procedure SetValueType(const Value: TLMDChartValueType); virtual;

    property LowestValue: Variant read FLowestValue;
    property HighestValue: Variant read FHighestValue;

    procedure RefreshParentCharts;
  public
    constructor Create(Owner: TPersistent=nil); override;
    destructor Destroy; override;

    property Values[Index: Integer]: Variant read GetValues write SetValues;

    procedure AddParentChart(AChart: TControl);
    procedure RemoveParentChart(AChart: TControl);
  published
    property Name : string read GetName write SetName;
    property Caption : string read FCaption write FCaption;
    property Count : Integer read GetCount write SetCount;
    property ValueType: TLMDChartValueType read GetValueType write SetValueType;
  end;

  TLMDChartValuesClass = class of TLMDChartValuesBase;

  function CompareTypedChartValues(val1, val2: Variant; valType: TLMDChartValueType): integer;

  function ChartValueTypeToStr(AValType: TLMDChartValueType): string;
  function StrToChartValueType(AValType: string): TLMDChartValueType;

implementation

uses LMDChart;

{ ---------------------------------------------------------------------------- }

function ChartValueTypeToStr(AValType: TLMDChartValueType): string;
begin
  case AValType of
    cvtNumber: Result := 'Number';
    cvtMoney:  Result := 'Money';
    cvtDate:   Result := 'Date(time)';
    cvtLabel:  Result := 'Label';
  else
    Result := 'Custom';
  end;
end;

{ ---------------------------------------------------------------------------- }

function StrToChartValueType(AValType: string): TLMDChartValueType;
begin
  if AValType = 'Number' then
    Result := cvtNumber
  else if AValType = 'Money' then
    Result := cvtMoney
  else if AValType = 'Date(time)' then
    Result := cvtDate
  else if AValType = 'Label' then
    Result := cvtLabel
  else
    Result := cvtLabel;  
end;

{ ---------------------------------------------------------------------------- }

function CompareTypedChartValues(val1, val2: Variant; valType: TLMDChartValueType): integer;
begin
  Result := 0;
  if VarIsEmpty(val1) or VarIsEmpty(val2)
        or (Trim(VarToStr(val1)) = '') or (Trim(VarToStr(val2)) = '') then
    Exit;
  case valType of
    cvtNumber, cvtMoney: if val1 > val2 then Result := 1
                else if val1 < val2 then Result := -1;
    cvtDate:   if StrToDateTime(VarToStr(val1)) > StrToDateTime(VarToStr(val2)) then Result := 1
                else if StrToDateTime(VarToStr(val1)) < StrToDateTime(VarToStr(val2)) then Result := -1;
    cvtLabel:  if VarToStr(val1) > VarToStr(val2) then Result := 1
                else if VarToStr(val1) < VarToStr(val2) then Result := -1;
  end;
end;

{ ************************* TLMDChartValuesBase ****************************** }
{ ------------------------- private ------------------------------------------ }
function TLMDChartValuesBase.GetName: string;
begin
  Result := FName;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValuesBase.SetName(val : string);
begin
  FName := val;
end;

{ ------------------------- protected ---------------------------------------- }

procedure TLMDChartValuesBase.SetValues(Index: Integer; Value: Variant);
begin
  if(CompareTypedChartValues(Value, Self.FLowestValue, Self.ValueType) < 0) then
    Self.FLowestValue := Value;
  if(CompareTypedChartValues(Value, Self.FHighestValue, Self.ValueType) > 0) then
    Self.FHighestValue := Value;
  Self.RefreshParentCharts;  
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValuesBase.SetCount(const Value: Integer);
var
  i: integer;
begin
  begin
    i := Self.Count - 1;
    while (i >= 0) and (VarIsEmpty(Self.Values[i])) do
    begin
      if (Self.ValueType = cvtNumber) or (Self.ValueType = cvtMoney) then
        Self.Values[i] := 0
      else if Self.ValueType = cvtLabel then
        Self.Values[i] := ' '
      else
        Self.Values[i] := Null;
      Dec(i);
    end;
  end;
  //Self.RefreshParentCharts;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValuesBase.SetValueType(
  const Value: TLMDChartValueType);
begin
  Self.RefreshParentCharts;
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartValuesBase.GetValues(Index: Integer): Variant;
begin
  Result := Unassigned;
  if (Trim(VarToStr(Result)) = '') and ((Self.ValueType = cvtNumber) or (Self.ValueType = cvtMoney)) then
    Result := 0;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValuesBase.RefreshParentCharts;
var
  i: integer;
begin
  for i := 0 to Self.FParentCharts.Count - 1 do
  begin
    TLMDChart(Self.FParentCharts.Items[i]).SetDataChanged;
    TLMDChart(Self.FParentCharts.Items[i]).Refresh;
  end;
end;

{ ------------------------- public ------------------------------------------- }

procedure TLMDChartValuesBase.AddParentChart(AChart: TControl);
begin
  if (AChart is TLMDChart) and (Self.FParentCharts.IndexOf(AChart) < 0) then
    Self.FParentCharts.Add(AChart);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValuesBase.RemoveParentChart(AChart: TControl);
begin
  Self.FParentCharts.Remove(AChart);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDChartValuesBase.Create(Owner: TPersistent);
begin
  inherited;
  Self.FParentCharts := TList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartValuesBase.Destroy;
begin
  inherited;
  Self.FParentCharts.Free;
end;

end.
