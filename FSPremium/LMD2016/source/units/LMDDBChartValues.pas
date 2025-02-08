unit LMDDBChartValues;
{$I lmdcmps.inc}

interface

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
LMDDBChartValues unit
-----------------------------------

Changes
-------
Created (22-June-2007)

###############################################################################}

uses
  SysUtils, Classes, Controls, Graphics, Db, Types, Variants, Math,
  LMDChartValuesBase;

type

  { *********************** TLMDDBChartValues ******************************** }
  /// <summary>
  /// Chart Values implementation which operates on the data in DB
  /// </summary>
  TLMDDBChartValues = class(TLMDChartValuesBase)
  private
    FDataSet: TDataSet;
    FFieldName: string;
    FIndicativeValueType: TLMDChartValueType;
    procedure SetDataSet(const Value: TDataSet);
  protected
    function GetValues(Index: Integer): Variant; override;
    procedure SetValues(Index: Integer; Value: Variant); override;
    function GetCount : Integer; override;
    procedure SetCount(const Value: Integer); override;
    function GetValueType: TLMDChartValueType; override;
    procedure SetValueType(const Value: TLMDChartValueType); override;
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property FieldName: string read FFieldName write FFieldName;  
  end;

implementation

uses LMDChartSeries;

{ ************************* TLMDDBChartValues ******************************** }
{ ------------------------- private ------------------------------------------ }
procedure TLMDDBChartValues.SetDataSet(const Value: TDataSet);
begin
  if Assigned(Self.FDataSet) and (Self.FMainOwner is TComponent) then
    Self.FDataSet.RemoveFreeNotification(Self.FMainOwner as TComponent);
  FDataSet := Value;
  if Assigned(Self.FDataSet) and (Self.FMainOwner is TComponent) then
    Self.FDataSet.FreeNotification(Self.FMainOwner as TComponent);
end;

{ ------------------------- protected ---------------------------------------- }

function TLMDDBChartValues.GetCount: Integer;
begin
  Result := 0;
  if (not Assigned(Self.DataSet)) then
    Exit; 
  if Self.DataSet.State = dsInactive then
    Self.DataSet.Open;
  if (Self.DataSet.State = dsInactive) then
    Exit;
  Result := Self.DataSet.RecordCount;  
end;

{ ---------------------------------------------------------------------------- }

function TLMDDBChartValues.GetValues(Index: Integer): Variant;
begin
  if (Self.ValueType = cvtNumber) or (Self.ValueType = cvtMoney) then
    Result := 0
  else if (Self.ValueType = cvtLabel)then
    Result := ''
  else  
    Result := Null;
  if (not Assigned(Self.DataSet)) then
    Exit;
  if Self.DataSet.State = dsInactive then
    Self.DataSet.Open;
  if (Self.DataSet.State = dsInactive)
    or (Index < 0) or (Index >= Self.Count) or (Trim(Self.FieldName) = '') then
    Exit;
  Self.DataSet.RecNo := Index + 1;
  Result := Self.DataSet.FieldValues[Self.FFieldName];
  if (Trim(VarToStr(Result)) = '') and ((Self.ValueType = cvtNumber) or (Self.ValueType = cvtMoney)) then
    Result := 0;
end;

{ ---------------------------------------------------------------------------- }

function TLMDDBChartValues.GetValueType: TLMDChartValueType;
var
  LField: TField;
begin
  Result :=  FIndicativeValueType;
  if (not Assigned(Self.DataSet)) then
    Exit;
  if Self.DataSet.State = dsInactive then
    Self.DataSet.Open;
  if (Self.DataSet.State = dsInactive) or (Trim(Self.FieldName) = '') then
    Exit;
  LField := Self.DataSet.Fields.FieldByName(Self.FieldName);
  if not Assigned(LField) then
    Exit;
  case LField.DataType of
  ftInteger, ftSmallint, ftWord, ftFloat, ftLargeInt: Result := cvtNumber;
  ftCurrency: Result := cvtMoney;
  ftDate, ftTime, ftDateTime: Result := cvtDate; 
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBChartValues.SetCount(const Value: Integer);
var
  oldC, i: integer;
  LNewVal: Variant;
begin
  if (not Assigned(Self.DataSet)) or (Trim(Self.FieldName) = '') then
    Exit;
  if Self.DataSet.State = dsInactive then
    Self.DataSet.Open;

  oldC := Self.Count;
  if oldC < Value then
    for i := oldC to Value - 1 do
    begin
      Self.DataSet.Insert;
      case Self.ValueType of
        cvtMoney, cvtNumber: LNewVal := 0;
        cvtLabel: LNewVal := ' ';
        cvtDate: LNewVal := Now;
      else
        LNewVal := Unassigned;
      end;
      Self.DataSet.FieldValues[Self.FieldName] := LNewVal;
      Self.DataSet.Post;
    end
  else if (oldC > Value) and (oldC > 0) then
  begin
    Self.DataSet.RecNo := oldC;
    while (Self.DataSet.RecordCount > Value) and (Self.DataSet.RecordCount > 0) do
      Self.DataSet.Delete;
  end;

  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBChartValues.SetValues(Index: Integer; Value: Variant);
begin
  if (not Assigned(Self.DataSet)) then
    Exit; 
  if Self.DataSet.State = dsInactive then
    Self.DataSet.Open;
  if (Self.DataSet.State = dsInactive)
    or (Index < 0) or (Index >= Self.Count) or (Trim(Self.FieldName) = '') then
    Exit;
  Self.DataSet.RecNo := Index + 1;
  Self.DataSet.Edit;
  Self.DataSet.FieldValues[Self.FFieldName] := Value;
  Self.DataSet.Post;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBChartValues.SetValueType(const Value: TLMDChartValueType);
begin
  Self.FIndicativeValueType := Value;
  inherited;
end;

{ ------------------------- public ------------------------------------------- }

constructor TLMDDBChartValues.Create(AOwner: TPersistent);
begin
  inherited;
  if Assigned(AOwner) and (AOwner is TLMDChartSeries) then
    (AOwner as TLMDChartSeries).RefreshChartValuesSettings(Self);
end;

end.
