unit System.SysConst_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'System.SysConst' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Types, System.Classes, System.SysUtils, System.Variants,
  System.TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers,
  System.SysConst;


{ Unit wrapper }

type
  SysConst_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ SysConst_sw }

function SysConst_SNoMappingForUnicodeCharacter_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SNoMappingForUnicodeCharacter = <value>;

  Result := SNoMappingForUnicodeCharacter;
end;

class function SysConst_sw.GetUnitName: WideString;
begin
  Result := 'SysConst';
end;

class procedure SysConst_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('SNoMappingForUnicodeCharacter', SysConst_SNoMappingForUnicodeCharacter_si, nil, VarType(System.SysConst.SNoMappingForUnicodeCharacter));
end;

class function SysConst_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(SysConst_sw);
end;

initialization
  RegisterUnitWrapper(SysConst_sw);

end.
