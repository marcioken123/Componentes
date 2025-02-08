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
  SysUtils, Classes, Variants, TypInfo, LMDTypes, LMDSctClass, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Windows, Imm, Windows_LMDSW;


{ Type wrappers }

type

  HIMC_sw = Integer_sw;


{ Unit wrapper }

type
  Imm_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Imm_sw }

function Imm_HIMC_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type HIMC = Integer;

  Result := TLMDUnitWrapper.TypeToVar(HIMC_sw);
end;

class function Imm_sw.GetUnitName: WideString;
begin
  Result := 'Imm';
end;

class procedure Imm_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(HIMC_sw, Imm_HIMC_si);
end;

class function Imm_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Imm_sw);
end;

initialization
  RegisterUnitWrapper(Imm_sw);

end.
