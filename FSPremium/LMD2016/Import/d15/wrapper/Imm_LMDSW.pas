unit Imm_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Imm' unit.
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
  LMDSctWrappers, LMDSctSysWrappers, Types, Windows, Imm, Windows_LMDSW;


{ Unit wrapper }

type
  Imm_sw = class(TLMDUnitWrapper)
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Imm_sw }

class function Imm_sw.GetUnitName: WideString;
begin
  Result := 'Imm';
end;

class function Imm_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Imm_sw);
end;

initialization
  RegisterUnitWrapper(Imm_sw);

end.
