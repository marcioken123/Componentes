unit TypInfo_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'TypInfo' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Classes, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers,
  Types, Variants, SysUtils, Variants_LMDSW, SysUtils_LMDSW;


{ Unit wrapper }

type
  TypInfo_sw = class(TLMDUnitWrapper)
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TypInfo_sw }

class function TypInfo_sw.GetUnitName: WideString;
begin
  Result := 'TypInfo';
end;

class function TypInfo_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(TypInfo_sw);
end;

initialization
  RegisterUnitWrapper(TypInfo_sw);

end.
