unit LMDChartSeriesCollection;
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
LMDChartSeriesCollection
-----------------------------------

Changes
-------
Created (June-2007) (RS)

-------

18-November-2007 - ChartSeries collection item is now used to store not only the reference to a ChartSeries,
but also visual settings like chart marker, chart line and fill (background) assigned to the series;
before when these settings were kept in LMDChartData, they were not persisted.

###############################################################################}

interface

uses
  SysUtils, Classes, Controls, Graphics, Types, Variants, Math,
  LMDChartValuesBase, LMDChartSeries, LMDChartLine, LMDChartMarker, LMDChartBackground;

type
  { *********************** TLMDChartSeriesCollectionItem ****************************** }
  /// <summary>
  /// Collection item class for the Chart Series collection
  /// </summary>  
  TLMDChartSeriesCollectionItem = class(TCollectionItem)
  private
    FFill: TLMDChartBackground;
    FLine: TLMDChartLine;
    FMarker: TLMDChartMarker;
    procedure SetFill(const Value: TLMDChartBackground);
    procedure SetLine(const Value: TLMDChartLine);
    procedure SetMarker(const Value: TLMDChartMarker);
  protected
    FSeries: TLMDCustomChartSeries;
    procedure SetSeries(const Value: TLMDCustomChartSeries);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure RefreshParentChart;    
  published
    property Series: TLMDCustomChartSeries read FSeries write
      SetSeries;
    property Marker: TLMDChartMarker read FMarker write SetMarker;
    property Line: TLMDChartLine read FLine write SetLine;
    property Fill: TLMDChartBackground read FFill write SetFill;
  end;

  { *********************** TLMDChartSeriesColl **************************************** }
  /// <summary>
  /// Chart Series collection class
  /// </summary>  
  TLMDChartSeriesColl = class(TCollection)
  private
    function GetItem(Index: Integer): TLMDChartSeriesCollectionItem;
    procedure SetItem(Index: Integer; const Value: TLMDChartSeriesCollectionItem);
    function GetMaxNumberOfValues: integer;

    procedure RefreshParentChart;
  protected
    FOwner: TComponent;
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;

  public
    constructor Create(AComponent: TComponent);
    function Add: TLMDChartSeriesCollectionItem;
    procedure Delete(Index: Integer);
    property Items[Index: Integer]: TLMDChartSeriesCollectionItem read GetItem write
      SetItem; default;
    property MaxNumberOfValues: integer read GetMaxNumberOfValues;  
  end;

implementation

{ TLMDChartSeriesCollectionItem }

uses LMDChart;

{ ********************* TLMDChartSeriesCollectionItem ************************ }
{ ------------------------- protected ---------------------------------------- }
procedure TLMDChartSeriesCollectionItem.SetSeries(
  const Value: TLMDCustomChartSeries);
begin
  if Self.FSeries = Value then
    Exit;
    if Assigned(Self.FSeries) then
  begin
    Self.FSeries.RemoveParentChart(TLMDChartSeriesColl(Self.Collection).FOwner as TControl);
    //TLMDChartSeriesColl(Self.Collection).FOwner.RemoveFreeNotification(Self.FSeries);
  end;

  Self.FSeries := Value;

  if Assigned(Self.FSeries) then
  begin
    Self.FSeries.AddParentChart(TLMDChartSeriesColl(Self.Collection).FOwner as TControl);
    //TLMDChartSeriesColl(Self.Collection).FOwner.FreeNotification(Self.FSeries);
  end;

  Self.RefreshParentChart;
end;

{ ------------------------- public ------------------------------------------- }

constructor TLMDChartSeriesCollectionItem.Create(Collection: TCollection);
begin
  inherited;
  Self.Series := nil;
  Self.FMarker := TLMDChartMarker.Create(Self);
  Self.FLine := TLMDChartLine.Create(Self);
  Self.FFill := TLMDChartBackground.Create(Self);
end;

{ ********************* TLMDChartSeriesColl ********************************** }
{ ------------------------- private ------------------------------------------ }
function TLMDChartSeriesColl.GetItem(
  Index: Integer): TLMDChartSeriesCollectionItem;
begin
  Result := TLMDChartSeriesCollectionItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartSeriesColl.GetMaxNumberOfValues: integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Self.Count - 1 do
  begin
    if Assigned(Self.Items[i].Series) and Assigned(Self.Items[i].Series.ChartValuesCollection) then
      if Self.Items[i].Series.ChartValuesCollection.NumberOfValues > Result then
        Result := Self.Items[i].Series.ChartValuesCollection.NumberOfValues;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartSeriesColl.RefreshParentChart;
begin
 if Assigned(Self.FOwner) and (Self.FOwner is TLMDChart) and (not (Self.FOwner as TLMDChart).IsLoadingData) then
 begin
    (Self.FOwner as TLMDChart).SetDataChanged;
    (Self.FOwner as TLMDChart).Refresh;
 end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartSeriesColl.SetItem(Index: Integer;
  const Value: TLMDChartSeriesCollectionItem);
begin
  inherited SetItem(Index, Value);
  Self.RefreshParentChart;
end;

{ ------------------------- protected ---------------------------------------- }
function TLMDChartSeriesColl.GetOwner: TPersistent;
begin
  Result := Self.FOwner;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartSeriesColl.Update(Item: TCollectionItem);
begin
  inherited;
  if (Item is TLMDChartSeriesCollectionItem) then
  begin
    if (Item as TLMDChartSeriesCollectionItem).Series <> nil then
      Self.RefreshParentChart;
  end;
end;

{ ------------------------- public ------------------------------------------- }

function TLMDChartSeriesColl.Add: TLMDChartSeriesCollectionItem;
begin
  Result := TLMDChartSeriesCollectionItem(inherited Add);
  Self.RefreshParentChart;
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDChartSeriesColl.Create(AComponent: TComponent);
begin
  inherited Create(TLMDChartSeriesCollectionItem);
  Self.FOwner := AComponent;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartSeriesColl.Delete(Index: Integer);
begin
  inherited;
  Self.RefreshParentChart;
end;

procedure TLMDChartSeriesCollectionItem.SetFill(
  const Value: TLMDChartBackground);
begin
  FFill.Assign(Value);
  Self.RefreshParentChart
end;

procedure TLMDChartSeriesCollectionItem.SetLine(
  const Value: TLMDChartLine);
begin
  FLine.Assign(Value);
  Self.RefreshParentChart
end;

procedure TLMDChartSeriesCollectionItem.SetMarker(
  const Value: TLMDChartMarker);
begin
  FMarker.Assign(Value);
  Self.RefreshParentChart
end;

destructor TLMDChartSeriesCollectionItem.Destroy;
begin
  Self.FMarker.Free;
  Self.FLine.Free;
  Self.FFill.Free;
  inherited;
end;

procedure TLMDChartSeriesCollectionItem.RefreshParentChart;
begin
  if Assigned(Self.Collection) and (Self.Collection is TLMDChartSeriesColl) then
    (Self.Collection as TLMDChartSeriesColl).RefreshParentChart;
end;

end.
