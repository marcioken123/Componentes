unit LMDChartValuesCollection;
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
LMDChartValuesCollection
-----------------------------------

Changes
-------
Created (June-2007)

###############################################################################}

interface

uses
  SysUtils, Classes, Controls, Graphics, Math, Types, Variants,
  LMDChartValuesBase, LMDChartValues, LMDClass;

type
  TLMDChartValuesType = (cvtMemory, cvtDB, cvtXML);

  { *********************** TLMDChartValuesCollectionItem ************************** }
  /// <summary>
  /// Item of the Chart Values Collection
  /// </summary>
  TLMDChartValuesCollectionItem = class(TCollectionItem)
  protected
    FChartValues: TLMDChartValuesBase;
    procedure SetChartValues(const Value: TLMDChartValuesBase);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property ChartValues: TLMDChartValuesBase read FChartValues write SetChartValues;
  end;

  { *********************** TLMDChartValuesColl *********************************** }
  /// <summary>
  /// Collection of Chart Values array objects
  /// </summary>
  TLMDChartValuesColl = class(TOwnedCollection)
  private
    FChartValuesType: TLMDChartValuesType;
    FChartValuesClass: TLMDChartValuesClass;

    procedure SetChartValuesType(const Value: TLMDChartValuesType);
    function GetItem(Index: Integer): TLMDChartValuesCollectionItem; overload;
    procedure SetItem(Index: Integer; const Value: TLMDChartValuesCollectionItem); overload;
    function GetItemByName(Name: string): TLMDChartValuesCollectionItem; overload;
    procedure SetItemByName(Name: string; const Value: TLMDChartValuesCollectionItem); overload;

    function ItemIndexByName(Name: string): integer;
    function GetNumberOfValues: integer;
    procedure SetNumberOfValues(const Value: integer);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AComponent: TComponent; AChartValuesClass: TLMDChartValuesClass);
    function Add: TLMDChartValuesCollectionItem;
    procedure Delete(Index: Integer);

    function Contains(Name: string): boolean;

    procedure RefreshParentChart;

    property Items[Index: Integer]: TLMDChartValuesCollectionItem read GetItem write
      SetItem; default;
    property ItemsByName[Name: string]: TLMDChartValuesCollectionItem read GetItemByName write
      SetItemByName;
    property ChartValuesType: TLMDChartValuesType read FChartValuesType write SetChartValuesType;

    property NumberOfValues: integer read GetNumberOfValues write SetNumberOfValues;

    property ChartValuesClass: TLMDChartValuesClass read FChartValuesClass;
  end;

implementation

uses LMDChart, LMDChartSeries;

{ ************************* TLMDChartValuesCollectionItem ******************** }
{ -------------------------protected ----------------------------------------- }
procedure TLMDChartValuesCollectionItem.SetChartValues(
  const Value: TLMDChartValuesBase);
begin
  Self.FChartValues.Assign(Value);
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDChartValuesCollectionItem.Create(Collection: TCollection);
var
  LOwnerCollection: TLMDChartValuesColl;
begin
  inherited;
  if Assigned(Collection) and (Collection is TLMDChartValuesColl) then
  begin
    LOwnerCollection := Collection as TLMDChartValuesColl;
    FChartValues := LOwnerCollection.ChartValuesClass.Create(LOwnerCollection.Owner);
  end;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDChartValuesCollectionItem.Destroy;
begin
  FChartValues.Free;
  inherited;
end;

{ ************************* TLMDChartValuesColl ****************************** }
{ -------------------------private ------------------------------------------- }
function TLMDChartValuesColl.GetItem(
  Index: Integer): TLMDChartValuesCollectionItem;
begin
  Result := TLMDChartValuesCollectionItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
function TLMDChartValuesColl.GetItemByName(
  Name: string): TLMDChartValuesCollectionItem;
var
  ind: integer;
begin
  ind := Self.ItemIndexByName(Name);
  if ind >= 0 then
    Result := TLMDChartValuesCollectionItem(inherited GetItem(ind))
  else
    Result := nil;  
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartValuesColl.ItemIndexByName(Name: string): integer;
var
  i: integer;
  found: boolean;
begin
  i := 0;
  found := false;
  while (not found) and (i < Self.Count) do
  begin
    if Assigned(Self.Items[i].ChartValues) then
      found := Self.Items[i].ChartValues.Name = Name;
    if not found then
      Inc(i);
  end;
  if found then
    Result := i
  else
    Result := -1;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValuesColl.SetChartValuesType(
  const Value: TLMDChartValuesType);
begin
  FChartValuesType := Value;
  Self.RefreshParentChart;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValuesColl.SetItemByName(Name: string;
  const Value: TLMDChartValuesCollectionItem);
var
  ind: integer;
begin
  ind := Self.ItemIndexByName(Name);
  if ind >= 0 then
    inherited SetItem(ind, Value);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValuesColl.SetItem(Index: Integer;
  const Value: TLMDChartValuesCollectionItem);
begin
  inherited SetItem(Index, Value);
  Self.RefreshParentChart;
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartValuesColl.GetNumberOfValues: integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Self.Count - 1 do
  begin
    if Assigned(Self.Items[i].ChartValues) then
        if Self.Items[i].ChartValues.Count > Result then
          Result := Self.Items[i].ChartValues.Count;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValuesColl.SetNumberOfValues(const Value: integer);
var
  i: integer;
  LIsLoadingData: array of boolean;
begin
  if (self.Owner<>nil) and (Self.Owner is TLMDCustomChartSeries) then
  begin
    SetLength(LIsLoadingData, (Self.Owner as TLMDCustomChartSeries).ParentCharts.Count);
    for i := 0 to Length(LIsLoadingData) - 1 do
      LIsLoadingData[i] := TLMDChart((Self.Owner as TLMDCustomChartSeries).ParentCharts[i]).IsLoadingData;
  end;

  for i := 0 to Self.Count - 1 do
  begin
    if Assigned(Self.Items[i].ChartValues) then
        Self.Items[i].ChartValues.Count := Value;
  end;

  for i := 0 to Length(LIsLoadingData) - 1 do
     TLMDChart((Self.Owner as TLMDCustomChartSeries).ParentCharts[i]).IsLoadingData := LIsLoadingData[i];
end;

{ -------------------------protected ----------------------------------------- }

procedure TLMDChartValuesColl.Update(Item: TCollectionItem);
begin
  inherited;
  Self.RefreshParentChart;
end;

{ ------------------------- public ------------------------------------------- }

function TLMDChartValuesColl.Add: TLMDChartValuesCollectionItem;
begin
  Result := TLMDChartValuesCollectionItem(inherited Add);
  Self.RefreshParentChart;
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartValuesColl.Contains(Name: string): boolean;
begin
  Result := Self.ItemIndexByName(Name) >= 0;
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDChartValuesColl.Create(AComponent: TComponent; AChartValuesClass: TLMDChartValuesClass);
begin
  inherited Create(AComponent, TLMDChartValuesCollectionItem);
  Self.FChartValuesClass := AChartValuesClass;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValuesColl.RefreshParentChart;
begin
  if (Self.Owner<>nil) and (Self.Owner is TLMDCustomChartSeries) then
  begin
    (Self.Owner as TLMDCustomChartSeries).RefreshParentCharts;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValuesColl.Delete(Index: Integer);
begin
  inherited;
  Self.RefreshParentChart;
end;

end.
