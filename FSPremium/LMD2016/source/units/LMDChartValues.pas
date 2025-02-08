unit LMDChartValues;
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
LMDChartValues unit
-----------------------------------

Changes
-------
Created (13-June-2007)

###############################################################################}

interface

uses
  SysUtils, Classes, Controls, Graphics, Types, Variants, Math,
  LMDChartValuesBase;

type
  { *********************** TLMDChartValues ********************************** }
  /// <summary>
  /// Implementation of the TLMDChartValuesBase which holds values
  /// in the in-memory array
  /// </summary>
  TLMDChartValues = class(TLMDChartValuesBase)
  private
    FValues: array of Variant;
    FValueType: TLMDChartValueType;

    procedure LoadValues(Reader: TReader);
    procedure StoreValues(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;

    function GetValueType: TLMDChartValueType; override;
    procedure SetValueType(const Value: TLMDChartValueType); override;

    function GetValues(Index: Integer): Variant; override;
    procedure SetValues(Index: Integer; Value: Variant); override;
    function GetCount : Integer; override;
    procedure SetCount(const Value: Integer); override;
  end;

implementation

{ ************************* TLMDChartValues ********************************** }
{ ------------------------- private ------------------------------------------ }
procedure TLMDChartValues.LoadValues(Reader: TReader);
var
  count: integer;
begin
  count := 0;
  Reader.ReadListBegin;
  while not Reader.EndOfList do
  begin
    Inc(count);
    SetLength(Self.FValues, count);
    case Self.FValueType of
    cvtNumber: Self.FValues[count - 1] := Reader.ReadFloat;
    cvtMoney:  Self.FValues[count - 1] := Reader.ReadCurrency;
    cvtDate:   Self.FValues[count - 1] := Reader.ReadDate;
    else
        Self.FValues[count - 1] := Reader.ReadString;
    end;
  end;
  Reader.ReadListEnd;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValues.StoreValues(Writer: TWriter);
var
  i, count: integer;
begin
  count := Length(Self.FValues);
  Writer.WriteListBegin;
  for i := 0 to count - 1 do
  begin
    case Self.FValueType of
    cvtNumber: Writer.WriteFloat(Self.FValues[i]);
    cvtMoney:  Writer.WriteCurrency(Self.FValues[i]);
    cvtDate:   Writer.WriteDate(Self.FValues[i]);
    else
        Writer.WriteString(Self.FValues[i]);
    end;
  end;
  Writer.WriteListEnd;
end;

{ ------------------------- protected --------------------------------------- }

function TLMDChartValues.GetCount: Integer;
begin
  Result := Length(Self.FValues);
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartValues.GetValues(Index: Integer): Variant;
begin
  if (Self.ValueType = cvtNumber) or (Self.ValueType = cvtMoney) then
    Result := 0
  else if (Self.ValueType = cvtLabel)then
    Result := ''
  else  
    Result := Null;
  if (Index >= 0) and (Index < Self.Count) then
    Result := Self.FValues[Index];
  if (Trim(VarToStr(Result)) = '') and ((Self.ValueType = cvtNumber) or (Self.ValueType = cvtMoney)) then
    Result := 0;  
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartValues.GetValueType: TLMDChartValueType;
begin
  Result := Self.FValueType;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValues.SetValueType(const Value: TLMDChartValueType);
begin
  FValueType := Value;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValues.SetCount(const Value: Integer);
begin
  SetLength(Self.FValues, Value);
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValues.SetValues(Index: Integer; Value: Variant);
begin
  if Index < 0 then
    Exit;
  if Index >= Self.Count then
    SetLength(Self.FValues, Index + 1);
  Self.FValues[Index] := Value;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartValues.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then { check Ancestor for an inherited value }
    begin
      if TLMDChartValues(Filer.Ancestor).FValues = nil then
        Result := Self.FValues <> nil
      else if Self.FValues = nil then
        Result := True
      else Result := False;
    end
    else { no inherited value -- check for default (nil) value }
      Result := Self.FValues <> nil;
  end;
begin
  inherited; { allow base classes to define properties }
  Filer.DefineProperty('FValues', LoadValues, StoreValues, DoWrite);
end;

end.
