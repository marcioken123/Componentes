unit LMDChartSeries;
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
LMDChartSeries unit
-----------------------------------

Changes
-------
Created (15-June-2007)

###############################################################################}

interface

uses
  SysUtils, Classes, Controls, Graphics, Types, Variants, Math, Windows,
  LMDCustomComponent, LMDTypes, LMDChartPersistent, LMDChartValuesBase, LMDChartValues,
  LMDChartValuesCollection;

type
  { *********************** TLMDCustomChartSeries ********************************** }
  /// <summary>
  /// The base class for all the chart series implementations (in-memory series, DB series etc),
  //  which defines the basic series functionality and interface (maintaiting sets of chart values etc.)
  /// </summary>
  TLMDCustomChartSeries = class(TLMDCustomComponent)
  private
    FChartValuesColl: TLMDChartValuesColl;
    FSeriesName: string;
    FParentCharts: TList;
    function GetCount: integer;
    procedure SetCount(const Value: integer);
    procedure SetChartValues(const Value: TLMDChartValuesColl);
  protected
    function GetChartValuesType: TLMDChartValuesType; virtual; abstract;
    function GetChartValuesClass: TLMDChartValuesClass; virtual; abstract;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AMainOwner: TComponent); override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;override;
    procedure Assign(Source: TPersistent); override;
    procedure RefreshChartValuesSettings(AValues: TLMDChartValuesBase); virtual;
    procedure AddParentChart(AChart: TControl);
    procedure RemoveParentChart(AChart: TControl);
    procedure RefreshParentCharts;
    property ParentCharts: TList read FParentCharts;
  published
    property About;
    property ChartValuesCollection: TLMDChartValuesColl read FChartValuesColl write SetChartValues;
    property SeriesName: string read FSeriesName write FSeriesName;
    //allows to set count for all the chartValues arrays (labels, values etc.) at once,
    //or get the maximal count of values (actually should be the same in all the chartValues arrays)
    property Count: integer read GetCount write SetCount;
  end;

  { *********************** TLMDChartSeries ********************************** }
  /// <summary>
  /// Chart series implementation which holds its data in memory
  /// </summary>
  TLMDChartSeries = class (TLMDCustomChartSeries)
  protected
    function GetChartValuesType: TLMDChartValuesType; override;
    function GetChartValuesClass: TLMDChartValuesClass; override;
  public
    constructor Create(AMainOwner: TComponent); override;
  end;

implementation
uses
  LMDChart, LMDChartSource{$IFDEF LMD_DEBUGTRACE}, Dialogs; {$I C2.INC}{$ELSE};{$ENDIF}

{ ************************** TLMDCustomChartSeries *************************** }
{ -------------------------- private ----------------------------------------- }

procedure TLMDCustomChartSeries.SetChartValues(
  const Value: TLMDChartValuesColl);
begin
  FChartValuesColl.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDCustomChartSeries.SetCount(const Value: integer);
var
  i: integer;
begin
  for i := 0 to Self.FChartValuesColl.Count - 1 do
    begin
      Self.FChartValuesColl.Items[i].ChartValues.Count := Value;
    end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDCustomChartSeries.GetCount: integer;
var
  i: integer;
begin
  Result := 0;
  if Assigned(Self) {!!!} and Assigned(Self.FChartValuesColl) and (Self.FChartValuesColl.Count > 0) then
  begin
    Result := Self.FChartValuesColl.Items[0].ChartValues.Count;
    for i := 1 to Self.FChartValuesColl.Count - 1 do
    begin
      if Self.FChartValuesColl.Items[i].ChartValues.Count > Result then
        Result := Self.FChartValuesColl.Items[i].ChartValues.Count;
    end;
  end;
end;

{ -------------------------- protected --------------------------------------- }
function TLMDCustomChartSeries.getLMDPackage: TLMDPackageID;
begin
  result := pi_LMD_Chart;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomChartSeries.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent is TLMDChart) then
    Self.RemoveParentChart(AComponent as TLMDChart);
end;

{ -------------------------- public ------------------------------------------ }

procedure TLMDCustomChartSeries.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TLMDCustomChartSeries then
  Self.FChartValuesColl.Assign((Source as TLMDCustomChartSeries).FChartValuesColl);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDCustomChartSeries.Create(AMainOwner: TComponent);
var
  LSource: TLMDXChartSource;
begin
  inherited;
  Self.FParentCharts := TList.Create;
  Self.FChartValuesColl := TLMDChartValuesColl.Create(Self, Self.GetChartValuesClass);
  LSource := TLMDXChartSource.Create(nil);
  LSource.MakeSeriesCompatible(Self);
  LSource.Free;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDCustomChartSeries.Destroy;
begin
  Self.FChartValuesColl.Free;
  if Assigned(Self.FParentCharts) then
    Self.FParentCharts.Free; 
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDCustomChartSeries.RefreshChartValuesSettings(
  AValues: TLMDChartValuesBase);
begin

end;

{ ---------------------------------------------------------------------------- }

procedure TLMDCustomChartSeries.RefreshParentCharts;
var
  i: integer;
begin
  for i := 0 to Self.FParentCharts.Count - 1 do
  begin
    TLMDChart(Self.FParentCharts.Items[i]).SetDataChanged;
    TLMDChart(Self.FParentCharts.Items[i]).Refresh;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDCustomChartSeries.AddParentChart(AChart: TControl);
var
  i: integer;
begin
  if Assigned(AChart) and (Self.FParentCharts.IndexOf(AChart) < 0) then
  begin
    Self.FParentCharts.Add(AChart);
    AChart.FreeNotification(Self);
    Self.FreeNotification(AChart);
    for i := 0 to Self.ChartValuesCollection.Count - 1 do
      if Assigned(Self.ChartValuesCollection.Items[i].ChartValues) then
        Self.ChartValuesCollection.Items[i].ChartValues.AddParentChart(AChart);
  end;
end;

{ ************************** TLMDChartSeries ********************************* }
{ -------------------------- protected --------------------------------------- }

function TLMDChartSeries.GetChartValuesClass: TLMDChartValuesClass;
begin
  Result := TLMDChartValues;
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartSeries.GetChartValuesType: TLMDChartValuesType;
begin
  Result := cvtMemory;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDCustomChartSeries.RemoveParentChart(AChart: TControl);
var
  i: integer;
begin
  if Assigned(AChart) and (Self.FParentCharts.IndexOf(AChart) >= 0) then
  begin
    AChart.RemoveFreeNotification(Self);
    Self.RemoveFreeNotification(AChart);
    Self.FParentCharts.Remove(AChart);
    for i := 0 to Self.ChartValuesCollection.Count - 1 do
      if Assigned(Self.ChartValuesCollection.Items[i].ChartValues) then
        Self.ChartValuesCollection.Items[i].ChartValues.RemoveParentChart(AChart);
  end;
end;

{ -------------------------- public ------------------------------------------ }
constructor TLMDChartSeries.Create(AMainOwner: TComponent);
begin
  inherited;
end;

initialization
{$IFDEF LMD_DEBUGTRACE}
  {$I C1.INC}
{$ENDIF}
end.
