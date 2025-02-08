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

  TMaskedText_sw = class(string_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TMaskedText): OleVariant;
    class function FromVar(const AValue: OleVariant): TMaskedText;
  end;

  TEditMask_sw = class(string_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TEditMask): OleVariant;
    class function FromVar(const AValue: OleVariant): TEditMask;
  end;


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

{ TMaskedText_sw }

class function TMaskedText_sw.GetTypeName: WideString;
begin
  Result := 'TMaskedText';
end;

class function TMaskedText_sw.ToVar(const AValue: TMaskedText): OleVariant;
begin
  Result := string_sw.ToVar(string(AValue));
end;

class function TMaskedText_sw.FromVar(const AValue: OleVariant): TMaskedText;
begin
  Result := TMaskedText(string_sw.FromVar(AValue));
end;

{ TEditMask_sw }

class function TEditMask_sw.GetTypeName: WideString;
begin
  Result := 'TEditMask';
end;

class function TEditMask_sw.ToVar(const AValue: TEditMask): OleVariant;
begin
  Result := string_sw.ToVar(string(AValue));
end;

class function TEditMask_sw.FromVar(const AValue: OleVariant): TEditMask;
begin
  Result := TEditMask(string_sw.FromVar(AValue));
end;

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
