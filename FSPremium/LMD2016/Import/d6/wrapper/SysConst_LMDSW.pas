unit SysConst_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'SysConst' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  SysUtils, Classes, Variants, TypInfo, LMDTypes, LMDSctClass, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, SysConst;


{ Unit wrapper }

type
  SysConst_sw = class(TLMDUnitWrapper)
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ SysConst_sw }

class function SysConst_sw.GetUnitName: WideString;
begin
  Result := 'SysConst';
end;

class function SysConst_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(SysConst_sw);
end;

initialization
  RegisterUnitWrapper(SysConst_sw);

end.
