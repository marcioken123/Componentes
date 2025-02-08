unit MultiMon_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'MultiMon' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Classes, SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Windows, MultiMon, Windows_LMDSW;


{ Unit wrapper }

type
  MultiMon_sw = class(TLMDUnitWrapper)
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ MultiMon_sw }

class function MultiMon_sw.GetUnitName: WideString;
begin
  Result := 'MultiMon';
end;

class function MultiMon_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(MultiMon_sw);
end;

initialization
  RegisterUnitWrapper(MultiMon_sw);

end.
