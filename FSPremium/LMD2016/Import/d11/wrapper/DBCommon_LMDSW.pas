unit DBCommon_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'DBCommon' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  SysUtils, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Types, Windows, Variants, Classes, DB, DBCommon,
  Windows_LMDSW, Variants_LMDSW, Classes_LMDSW, DB_LMDSW;


{ Type wrappers }

type

  IDENTIFIEROption_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: IDENTIFIEROption): OleVariant;
    class function FromVar(const AValue: OleVariant): IDENTIFIEROption;
  end;


{ Unit wrapper }

type
  DBCommon_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ IDENTIFIEROption_sw }

class function IDENTIFIEROption_sw.GetTypeName: WideString;
begin
  Result := 'IDENTIFIEROption';
end;

class function IDENTIFIEROption_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(IDENTIFIEROption);
end;

class function IDENTIFIEROption_sw.ToVar(
  const AValue: IDENTIFIEROption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function IDENTIFIEROption_sw.FromVar(
  const AValue: OleVariant): IDENTIFIEROption;
begin
  Result := IDENTIFIEROption(Integer(AValue));
end;

{ DBCommon_sw }

function DBCommon_IDENTIFIEROption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type IDENTIFIEROption = (idMixCase, idMakeLowerCase, idMa...

  Result := TLMDUnitWrapper.TypeToVar(IDENTIFIEROption_sw);
end;

function DBCommon_SQLRequiresParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SQLRequiresParams(const SQL: WideString): Boolean;

  Result := DBCommon.SQLRequiresParams(WideString(AArgs[0]));
end;

function DBCommon_GetTableNameFromSQLEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetTableNameFromSQLEx(const SQL: WideString; IdO...

  Result := DBCommon.GetTableNameFromSQLEx(WideString(AArgs[0]), 
    IDENTIFIEROption_sw.FromVar(AArgs[1]));
end;

class function DBCommon_sw.GetUnitName: WideString;
begin
  Result := 'DBCommon';
end;

class procedure DBCommon_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(IDENTIFIEROption_sw, DBCommon_IDENTIFIEROption_si);
  AData.AddFunction('SQLRequiresParams', DBCommon_SQLRequiresParams_si, Boolean_sw, 1, False);
  AData.AddFunction('GetTableNameFromSQLEx', DBCommon_GetTableNameFromSQLEx_si, WideString_sw, 2, False);
end;

class function DBCommon_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(DBCommon_sw);
end;

initialization
  RegisterUnitWrapper(DBCommon_sw);

end.
