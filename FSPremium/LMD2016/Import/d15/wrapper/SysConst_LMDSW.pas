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
  Types, Classes, SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, SysConst;


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

function SysConst_SMonitorLockException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SMonitorLockException = <value>;

  Result := SMonitorLockException;
end;

function SysConst_SNoMonitorSupportException_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SNoMonitorSupportException = <value>;

  Result := SNoMonitorSupportException;
end;

function SysConst_SInvalidSourceArray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SInvalidSourceArray = <value>;

  Result := SInvalidSourceArray;
end;

function SysConst_SInvalidDestinationArray_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SInvalidDestinationArray = <value>;

  Result := SInvalidDestinationArray;
end;

function SysConst_SCharIndexOutOfBounds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SCharIndexOutOfBounds = <value>;

  Result := SCharIndexOutOfBounds;
end;

function SysConst_SByteIndexOutOfBounds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SByteIndexOutOfBounds = <value>;

  Result := SByteIndexOutOfBounds;
end;

function SysConst_SInvalidCharCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SInvalidCharCount = <value>;

  Result := SInvalidCharCount;
end;

function SysConst_SInvalidDestinationIndex_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SInvalidDestinationIndex = <value>;

  Result := SInvalidDestinationIndex;
end;

function SysConst_SInvalidCodePage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SInvalidCodePage = <value>;

  Result := SInvalidCodePage;
end;

class function SysConst_sw.GetUnitName: WideString;
begin
  Result := 'SysConst';
end;

class procedure SysConst_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('SMonitorLockException', SysConst_SMonitorLockException_si, nil, VarType(SysConst.SMonitorLockException));
  AData.AddConstant('SNoMonitorSupportException', SysConst_SNoMonitorSupportException_si, nil, VarType(SysConst.SNoMonitorSupportException));
  AData.AddConstant('SInvalidSourceArray', SysConst_SInvalidSourceArray_si, nil, VarType(SysConst.SInvalidSourceArray));
  AData.AddConstant('SInvalidDestinationArray', SysConst_SInvalidDestinationArray_si, nil, VarType(SysConst.SInvalidDestinationArray));
  AData.AddConstant('SCharIndexOutOfBounds', SysConst_SCharIndexOutOfBounds_si, nil, VarType(SysConst.SCharIndexOutOfBounds));
  AData.AddConstant('SByteIndexOutOfBounds', SysConst_SByteIndexOutOfBounds_si, nil, VarType(SysConst.SByteIndexOutOfBounds));
  AData.AddConstant('SInvalidCharCount', SysConst_SInvalidCharCount_si, nil, VarType(SysConst.SInvalidCharCount));
  AData.AddConstant('SInvalidDestinationIndex', SysConst_SInvalidDestinationIndex_si, nil, VarType(SysConst.SInvalidDestinationIndex));
  AData.AddConstant('SInvalidCodePage', SysConst_SInvalidCodePage_si, nil, VarType(SysConst.SInvalidCodePage));
end;

class function SysConst_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(SysConst_sw);
end;

initialization
  RegisterUnitWrapper(SysConst_sw);

end.
