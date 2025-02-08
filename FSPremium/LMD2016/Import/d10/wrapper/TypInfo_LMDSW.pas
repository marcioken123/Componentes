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
  Variants, SysUtils, Variants_LMDSW, SysUtils_LMDSW;


{ Type wrappers }

type
  TPublishableVariantType_sw = class;
  EPropertyError_sw = class;
  EPropertyConvertError_sw = class;

  TTypeKind_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TTypeKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TTypeKind;
  end;

  TPublishableVariantType_sc = class of TPublishableVariantType;
  TPublishableVariantType_sw = class(TInvokeableVariantType_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPublishableVariantType): OleVariant;
    class function FromVar(const AValue: OleVariant): TPublishableVariantType;
    class function ClassToVar(AClass: TPublishableVariantType_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPublishableVariantType_sc;
  end;

  TTypeKinds_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TTypeKinds): OleVariant;
    class function FromVar(const AValue: OleVariant): TTypeKinds;
  end;

  TOrdType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TOrdType): OleVariant;
    class function FromVar(const AValue: OleVariant): TOrdType;
  end;

  TFloatType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TFloatType): OleVariant;
    class function FromVar(const AValue: OleVariant): TFloatType;
  end;

  TMethodKind_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TMethodKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TMethodKind;
  end;

  EPropertyError_sc = class of EPropertyError;
  EPropertyError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EPropertyError): OleVariant;
    class function FromVar(const AValue: OleVariant): EPropertyError;
    class function ClassToVar(AClass: EPropertyError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EPropertyError_sc;
  end;

  EPropertyConvertError_sc = class of EPropertyConvertError;
  EPropertyConvertError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EPropertyConvertError): OleVariant;
    class function FromVar(const AValue: OleVariant): EPropertyConvertError;
    class function ClassToVar(AClass: EPropertyConvertError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EPropertyConvertError_sc;
  end;


{ Unit wrapper }

type
  TypInfo_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TTypeKind_sw }

class function TTypeKind_sw.GetTypeName: WideString;
begin
  Result := 'TTypeKind';
end;

class function TTypeKind_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TTypeKind);
end;

class function TTypeKind_sw.ToVar(const AValue: TTypeKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTypeKind_sw.FromVar(const AValue: OleVariant): TTypeKind;
begin
  Result := TTypeKind(Integer(AValue));
end;

{ TPublishableVariantType_sw }

class function TPublishableVariantType_sw.GetTypeName: WideString;
begin
  Result := 'TPublishableVariantType';
end;

class function TPublishableVariantType_sw.GetWrappedClass: TClass;
begin
  Result := TPublishableVariantType;
end;

class procedure TPublishableVariantType_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TPublishableVariantType_sw.ToVar(
  const AValue: TPublishableVariantType): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPublishableVariantType_sw.FromVar(
  const AValue: OleVariant): TPublishableVariantType;
begin
  Result := TPublishableVariantType(ConvFromVar(AValue, 
    TPublishableVariantType));
end;

class function TPublishableVariantType_sw.ClassToVar(
  AClass: TPublishableVariantType_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPublishableVariantType_sw.ClassFromVar(
  const AClass: OleVariant): TPublishableVariantType_sc;
begin
  Result := TPublishableVariantType_sc(ConvClsFromVar(AClass, 
    TPublishableVariantType));
end;

{ TTypeKinds_sw }

class function TTypeKinds_sw.GetTypeName: WideString;
begin
  Result := 'TTypeKinds';
end;

class function TTypeKinds_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TTypeKinds);
end;

class function TTypeKinds_sw.ToVar(const AValue: TTypeKinds): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TTypeKinds_sw.FromVar(const AValue: OleVariant): TTypeKinds;
begin
  ConvFromVar(AValue, @Result);
end;

{ TOrdType_sw }

class function TOrdType_sw.GetTypeName: WideString;
begin
  Result := 'TOrdType';
end;

class function TOrdType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TOrdType);
end;

class function TOrdType_sw.ToVar(const AValue: TOrdType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TOrdType_sw.FromVar(const AValue: OleVariant): TOrdType;
begin
  Result := TOrdType(Integer(AValue));
end;

{ TFloatType_sw }

class function TFloatType_sw.GetTypeName: WideString;
begin
  Result := 'TFloatType';
end;

class function TFloatType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TFloatType);
end;

class function TFloatType_sw.ToVar(const AValue: TFloatType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFloatType_sw.FromVar(const AValue: OleVariant): TFloatType;
begin
  Result := TFloatType(Integer(AValue));
end;

{ TMethodKind_sw }

class function TMethodKind_sw.GetTypeName: WideString;
begin
  Result := 'TMethodKind';
end;

class function TMethodKind_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TMethodKind);
end;

class function TMethodKind_sw.ToVar(const AValue: TMethodKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMethodKind_sw.FromVar(const AValue: OleVariant): TMethodKind;
begin
  Result := TMethodKind(Integer(AValue));
end;

{ EPropertyError_sw }

class function EPropertyError_sw.GetTypeName: WideString;
begin
  Result := 'EPropertyError';
end;

class function EPropertyError_sw.GetWrappedClass: TClass;
begin
  Result := EPropertyError;
end;

class procedure EPropertyError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EPropertyError_sw.ToVar(
  const AValue: EPropertyError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EPropertyError_sw.FromVar(
  const AValue: OleVariant): EPropertyError;
begin
  Result := EPropertyError(ConvFromVar(AValue, EPropertyError));
end;

class function EPropertyError_sw.ClassToVar(
  AClass: EPropertyError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EPropertyError_sw.ClassFromVar(
  const AClass: OleVariant): EPropertyError_sc;
begin
  Result := EPropertyError_sc(ConvClsFromVar(AClass, EPropertyError));
end;

{ EPropertyConvertError_sw }

class function EPropertyConvertError_sw.GetTypeName: WideString;
begin
  Result := 'EPropertyConvertError';
end;

class function EPropertyConvertError_sw.GetWrappedClass: TClass;
begin
  Result := EPropertyConvertError;
end;

class procedure EPropertyConvertError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EPropertyConvertError_sw.ToVar(
  const AValue: EPropertyConvertError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EPropertyConvertError_sw.FromVar(
  const AValue: OleVariant): EPropertyConvertError;
begin
  Result := EPropertyConvertError(ConvFromVar(AValue, EPropertyConvertError));
end;

class function EPropertyConvertError_sw.ClassToVar(
  AClass: EPropertyConvertError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EPropertyConvertError_sw.ClassFromVar(
  const AClass: OleVariant): EPropertyConvertError_sc;
begin
  Result := EPropertyConvertError_sc(ConvClsFromVar(AClass, 
    EPropertyConvertError));
end;

{ TypInfo_sw }

function TypInfo_TTypeKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTypeKind = (tkInteger, tkChar, tkEnumeration, tkFlo...

  Result := TLMDUnitWrapper.TypeToVar(TTypeKind_sw);
end;

function TypInfo_TPublishableVariantType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPublishableVariantType = class(TInvokeableVariantTy...

  Result := TLMDUnitWrapper.TypeToVar(TPublishableVariantType_sw);
end;

function TypInfo_TTypeKinds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTypeKinds = set of TTypeKind;

  Result := TLMDUnitWrapper.TypeToVar(TTypeKinds_sw);
end;

function TypInfo_TOrdType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOrdType = (otUByte, otSWord, otUWord, otSLong, otUL...

  Result := TLMDUnitWrapper.TypeToVar(TOrdType_sw);
end;

function TypInfo_TFloatType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFloatType = (ftDouble, ftExtended, ftComp, ftCurr);

  Result := TLMDUnitWrapper.TypeToVar(TFloatType_sw);
end;

function TypInfo_TMethodKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMethodKind = (mkFunction, mkConstructor, mkDestruct...

  Result := TLMDUnitWrapper.TypeToVar(TMethodKind_sw);
end;

function TypInfo_EPropertyError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EPropertyError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EPropertyError_sw);
end;

function TypInfo_EPropertyConvertError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EPropertyConvertError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EPropertyConvertError_sw);
end;

class function TypInfo_sw.GetUnitName: WideString;
begin
  Result := 'TypInfo';
end;

class procedure TypInfo_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TTypeKind_sw, TypInfo_TTypeKind_si);
  AData.AddType(TPublishableVariantType_sw, TypInfo_TPublishableVariantType_si);
  AData.AddType(TTypeKinds_sw, TypInfo_TTypeKinds_si);
  AData.AddType(TOrdType_sw, TypInfo_TOrdType_si);
  AData.AddType(TFloatType_sw, TypInfo_TFloatType_si);
  AData.AddType(TMethodKind_sw, TypInfo_TMethodKind_si);
  AData.AddType(EPropertyError_sw, TypInfo_EPropertyError_si);
  AData.AddType(EPropertyConvertError_sw, TypInfo_EPropertyConvertError_si);
end;

class function TypInfo_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(TypInfo_sw);
end;

initialization
  RegisterUnitWrapper(TypInfo_sw);
  RegisterClassWrapper(TPublishableVariantType_sw);
  RegisterClassWrapper(EPropertyError_sw);
  RegisterClassWrapper(EPropertyConvertError_sw);

end.
