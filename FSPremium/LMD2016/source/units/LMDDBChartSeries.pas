unit LMDDBChartSeries;
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
  SysUtils, Classes, Controls, Graphics, Db, Math, Types, Variants, 
  LMDChartSeries, LMDDBChartValues, LMDChartPersistent, LMDChartValuesBase,
  LMDChartValuesCollection;

type

  { *********************** TLMDDBChartSeries ******************************** }
  /// <summary>
  /// Chart Series implementation which operates on the data in DB
  /// </summary>
  TLMDDBChartSeries = class (TLMDCustomChartSeries)
  private
    FDataSet: TDataSet;
    procedure SetDataSet(const Value: TDataSet);
  protected
    function GetChartValuesType: TLMDChartValuesType; override;
    function GetChartValuesClass: TLMDChartValuesClass; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AMainOwner: TComponent); override;

    procedure RefreshChartValuesSettings(AValues: TLMDChartValuesBase); override;
    procedure RefreshAllChartValuesSettings;
  published
    property DataSet: TDataSet read FDataSet write SetDataSet;  
  end;

implementation

{ ************************* TLMDDBChartSeries ******************************** }
{ ------------------------- private ------------------------------------------ }
procedure TLMDDBChartSeries.SetDataSet(const Value: TDataSet);
begin
  if Assigned(Self.FDataSet) then
    Self.FDataSet.RemoveFreeNotification(Self);
  FDataSet := Value;
  if Assigned(Self.FDataSet) then
    Self.FDataSet.FreeNotification(Self);
  Self.RefreshAllChartValuesSettings;  
end;

{ ------------------------- protected ---------------------------------------- }

procedure TLMDDBChartSeries.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: integer;  
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if (AComponent = Self.FDataSet) then
    begin
      Self.FDataSet := nil;
      Self.RefreshAllChartValuesSettings;
    end
    else if Assigned(Self.ChartValuesCollection) then 
    begin
      for i := 0 to Self.ChartValuesCollection.Count - 1 do
        if Assigned(Self.ChartValuesCollection.Items[i].ChartValues)
          and (Self.ChartValuesCollection.Items[i].ChartValues is TLMDDBChartValues) then
            (Self.ChartValuesCollection.Items[i].ChartValues as TLMDDBChartValues).DataSet := nil;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDDBChartSeries.GetChartValuesClass: TLMDChartValuesClass;
begin
  Result := TLMDDBChartValues;
end;

{ ---------------------------------------------------------------------------- }

function TLMDDBChartSeries.GetChartValuesType: TLMDChartValuesType;
begin
  Result := cvtDB;
end;

{ ------------------------- public ------------------------------------------- }

constructor TLMDDBChartSeries.Create(AMainOwner: TComponent);
begin
  inherited;

end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBChartSeries.RefreshChartValuesSettings(
  AValues: TLMDChartValuesBase);
begin
  inherited;
  if Assigned(AValues) and (AValues is TLMDDBChartValues) then
    (AValues as TLMDDBChartValues).DataSet := Self.DataSet;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBChartSeries.RefreshAllChartValuesSettings;
var
  i: integer;
begin
  if Assigned(Self.ChartValuesCollection) then
    for i := 0 to Self.ChartValuesCollection.Count - 1 do
      if Assigned(Self.ChartValuesCollection.Items[i].ChartValues) and
        (Self.ChartValuesCollection.Items[i].ChartValues is TLMDDBChartValues) then
          (Self.ChartValuesCollection.Items[i].ChartValues as TLMDDBChartValues).DataSet := Self.DataSet;  

end;

end.
