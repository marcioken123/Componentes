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
  LMDSctSysWrappers, Windows, Variants, Classes, DB, DBCommon, Windows_LMDSW,
  Variants_LMDSW, Classes_LMDSW, DB_LMDSW;


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

{ DBCommon_sw }

function DBCommon_SQLRequiresParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SQLRequiresParams(const SQL: WideString): Boolean;

  Result := DBCommon.SQLRequiresParams(WideString(AArgs[0]));
end;

class function DBCommon_sw.GetUnitName: WideString;
begin
  Result := 'DBCommon';
end;

class procedure DBCommon_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddFunction('SQLRequiresParams', DBCommon_SQLRequiresParams_si, Boolean_sw, 1, False);
end;

class function DBCommon_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(DBCommon_sw);
end;

initialization
  RegisterUnitWrapper(DBCommon_sw);

end.
