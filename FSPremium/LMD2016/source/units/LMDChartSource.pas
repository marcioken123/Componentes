unit LMDChartSource;
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
LMDChartSource unit
-----------------------------------

Changes
-------
Created (22-June-2007)

###############################################################################}

interface

uses
  SysUtils, Classes, Controls, Graphics, Types, Variants, Math,
  LMDChartValuesBase, LMDChartSeries, LMDChartValuesCollection;

const
  CVN_XVALUES = 'X Values';
  CVN_YVALUES = 'Y Values';
  CVN_ZVALUES = 'Z Values';
  CVN_XLABELS = 'X Labels';
  CVN_YLABELS = 'Y Labels';
  CVN_ZLABELS = 'Z Labels';

type

TLMDChartSourceType = (cstXSource, cstXYSource, cstXYZSource, cstOHLCSource);

  { *********************** TLMDCustomChartSource ********************************** }
  /// <summary>
  /// The base class for all the chart sources which are helper classes which allow to configure
  /// chart series (so that they contain a set of chart values arrays appropriate for certain chart types)
  /// </summary>
  TLMDCustomChartSource = class(TComponent)
  private
    FSeries: TLMDCustomChartSeries;
    procedure SetSeries(const Value: TLMDCustomChartSeries);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
       override;
  procedure EnsureChartValuesExist(ASeries: TLMDCustomChartSeries; AName: string; AValType: TLMDChartValueType);    
  public
    function IsCompatibleWithSeries(ASeries: TLMDCustomChartSeries): boolean; virtual; abstract;
    procedure MakeSeriesCompatible(ASeries: TLMDCustomChartSeries); virtual; abstract;
  published
    property Series: TLMDCustomChartSeries read FSeries write SetSeries;
  end;

  { *********************** TLMDXChartSource *************************************** }
  /// <summary>
  /// The chart source for XValues/XLabels chart series suitable for all the currently supported chart types
  /// </summary>
  TLMDXChartSource = class (TLMDCustomChartSource)
  private
    function GetXLabels: TLMDChartValuesBase;
    function GetXValues: TLMDChartValuesBase;
  public
    function IsCompatibleWithSeries(ASeries: TLMDCustomChartSeries): boolean; override;
    procedure MakeSeriesCompatible(ASeries: TLMDCustomChartSeries); override;  
  published
    property XLabels: TLMDChartValuesBase read GetXLabels;
    property XValues: TLMDChartValuesBase read GetXValues;
  	end;

  { *********************** TLMDXChartSource *************************************** }
  /// <summary>
  /// The chart source for XValues/XLabels + YValues/YLabels chart series 
  /// </summary>
  TLMDXYChartSource = class (TLMDXChartSource)
  private
    function GetYLabels: TLMDChartValuesBase;
    function GetYValues: TLMDChartValuesBase;
  public
    function IsCompatibleWithSeries(ASeries: TLMDCustomChartSeries): boolean; override;
    procedure MakeSeriesCompatible(ASeries: TLMDCustomChartSeries); override;
  published
    property YValues: TLMDChartValuesBase read GetYValues;
    property YLabels: TLMDChartValuesBase read GetYLabels;
  end;

implementation

{ ************************* TLMDCustomChartSource ********************************** }
{ ------------------------- private ------------------------------------------------ }
procedure TLMDCustomChartSource.SetSeries(const Value: TLMDCustomChartSeries);
begin
  FSeries := Value;
end;

{ ------------------------- protected ---------------------------------------------- }
procedure TLMDCustomChartSource.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Self.FSeries) then
    Self.FSeries := nil;
end;

{ ------------------------- public ------------------------------------------------- }

procedure TLMDCustomChartSource.EnsureChartValuesExist(
  ASeries: TLMDCustomChartSeries; AName: string; AValType: TLMDChartValueType);
var
  CVItem: TLMDChartValuesCollectionItem;
begin
  CVItem := ASeries.ChartValuesCollection.ItemsByName[AName];
  if CVItem = nil then
  begin
    CVItem := ASeries.ChartValuesCollection.Add;
    CVItem.ChartValues.Name := AName;
    CVItem.ChartValues.Caption := AName;
    CVItem.ChartValues.ValueType := AValType;
  end
  else if CVItem.ChartValues.ValueType <> AValType then
  begin
    CVItem.ChartValues.ValueType := AValType;
    CVItem.ChartValues.Count := 0;
  end;
end;

{ ************************* TLMDXChartSource *************************************** }
{ ------------------------- private ------------------------------------------------ }

function TLMDXChartSource.GetXLabels: TLMDChartValuesBase;
begin
  Result := Self.FSeries.ChartValuesCollection.ItemsByName[CVN_XLABELS].ChartValues;
end;

{ ---------------------------------------------------------------------------- }

function TLMDXChartSource.GetXValues: TLMDChartValuesBase;
begin
  Result := Self.FSeries.ChartValuesCollection.ItemsByName[CVN_XVALUES].ChartValues;
end;

{ ------------------------- public ------------------------------------------------- }

function TLMDXChartSource.IsCompatibleWithSeries(
  ASeries: TLMDCustomChartSeries): boolean;
begin
  Result := false;
  if Assigned(ASeries) then
   Result := ASeries.ChartValuesCollection.Contains(CVN_XVALUES)
     and ASeries.ChartValuesCollection.Contains(CVN_XLABELS);
end;

{ ---------------------------------------------------------------------------------- }

procedure TLMDXChartSource.MakeSeriesCompatible(ASeries: TLMDCustomChartSeries);
begin
  if Assigned(ASeries) then
  begin
    Self.EnsureChartValuesExist(ASeries, CVN_XVALUES, cvtNumber);
    Self.EnsureChartValuesExist(ASeries, CVN_XLABELS, cvtLabel);
  end;
end;

{ ************************* TLMDXYChartSource ************************************** }
{ ------------------------- private ------------------------------------------------ }

function TLMDXYChartSource.GetYLabels: TLMDChartValuesBase;
begin
  Result := Self.FSeries.ChartValuesCollection.ItemsByName[CVN_YLABELS].ChartValues;
end;

{ ---------------------------------------------------------------------------------- }

function TLMDXYChartSource.GetYValues: TLMDChartValuesBase;
begin
  Result := Self.FSeries.ChartValuesCollection.ItemsByName[CVN_YVALUES].ChartValues;
end;

{ ------------------------- public ------------------------------------------------- }

function TLMDXYChartSource.IsCompatibleWithSeries(
  ASeries: TLMDCustomChartSeries): boolean;
begin
  Result := false;
  if Assigned(ASeries) then
  Result := inherited IsCompatibleWithSeries(ASeries) and
    ASeries.ChartValuesCollection.Contains(CVN_YVALUES)
    and ASeries.ChartValuesCollection.Contains(CVN_YLABELS);
end;

{ ---------------------------------------------------------------------------------- }

procedure TLMDXYChartSource.MakeSeriesCompatible(
  ASeries: TLMDCustomChartSeries);
begin
  if Assigned(ASeries) then
  begin
    inherited;
    Self.EnsureChartValuesExist(ASeries, CVN_YVALUES, cvtNumber);
    Self.EnsureChartValuesExist(ASeries, CVN_YLABELS, cvtLabel);
  end;  
end;

end.
