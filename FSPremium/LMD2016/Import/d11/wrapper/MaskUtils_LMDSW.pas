unit MaskUtils_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'MaskUtils' unit.
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
  LMDSctWrappers, LMDSctSysWrappers, Types, MaskUtils;


{ Type wrappers }

type

  TMaskedText_sw = string_sw;

  TEditMask_sw = string_sw;


{ Unit wrapper }

type
  MaskUtils_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ MaskUtils_sw }

function MaskUtils_TMaskedText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMaskedText = string;

  Result := TLMDUnitWrapper.TypeToVar(TMaskedText_sw);
end;

function MaskUtils_TEditMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEditMask = string;

  Result := TLMDUnitWrapper.TypeToVar(TEditMask_sw);
end;

class function MaskUtils_sw.GetUnitName: WideString;
begin
  Result := 'MaskUtils';
end;

class procedure MaskUtils_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TMaskedText_sw, MaskUtils_TMaskedText_si);
  AData.AddType(TEditMask_sw, MaskUtils_TEditMask_si);
end;

class function MaskUtils_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(MaskUtils_sw);
end;

initialization
  RegisterUnitWrapper(MaskUtils_sw);

end.
