unit Variants_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Variants' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Classes, Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Types, SysUtils, SysUtils_LMDSW;


{ Type wrappers }

type
  TCustomVariantType_sw = class;
  TCustomVariantTypeClass_sw = class;
  TInvokeableVariantType_sw = class;
  EVariantInvalidOpError_sw = class;
  EVariantTypeCastError_sw = class;
  EVariantOverflowError_sw = class;
  EVariantInvalidArgError_sw = class;
  EVariantBadVarTypeError_sw = class;
  EVariantBadIndexError_sw = class;
  EVariantArrayLockedError_sw = class;
  EVariantNotAnArrayError_sw = class;
  EVariantArrayCreateError_sw = class;
  EVariantNotImplError_sw = class;
  EVariantOutOfMemoryError_sw = class;
  EVariantUnexpectedError_sw = class;
  EVariantDispatchError_sw = class;
  EVariantRangeCheckError_sw = class;
  EVariantInvalidNullOpError_sw = class;

  TCustomVariantType_sc = class of TCustomVariantType;
  TCustomVariantType_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomVariantType): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomVariantType;
    class function ClassToVar(AClass: TCustomVariantType_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomVariantType_sc;
  end;

  TCustomVariantTypeClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCustomVariantTypeClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomVariantTypeClass;
  end;

  TInvokeableVariantType_sc = class of TInvokeableVariantType;
  TInvokeableVariantType_sw = class(TCustomVariantType_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TInvokeableVariantType): OleVariant;
    class function FromVar(const AValue: OleVariant): TInvokeableVariantType;
    class function ClassToVar(AClass: TInvokeableVariantType_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TInvokeableVariantType_sc;
  end;

  EVariantInvalidOpError_sc = class of EVariantInvalidOpError;
  EVariantInvalidOpError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantInvalidOpError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantInvalidOpError;
    class function ClassToVar(AClass: EVariantInvalidOpError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantInvalidOpError_sc;
  end;

  EVariantTypeCastError_sc = class of EVariantTypeCastError;
  EVariantTypeCastError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantTypeCastError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantTypeCastError;
    class function ClassToVar(AClass: EVariantTypeCastError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantTypeCastError_sc;
  end;

  EVariantOverflowError_sc = class of EVariantOverflowError;
  EVariantOverflowError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantOverflowError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantOverflowError;
    class function ClassToVar(AClass: EVariantOverflowError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantOverflowError_sc;
  end;

  EVariantInvalidArgError_sc = class of EVariantInvalidArgError;
  EVariantInvalidArgError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantInvalidArgError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantInvalidArgError;
    class function ClassToVar(AClass: EVariantInvalidArgError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantInvalidArgError_sc;
  end;

  EVariantBadVarTypeError_sc = class of EVariantBadVarTypeError;
  EVariantBadVarTypeError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantBadVarTypeError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantBadVarTypeError;
    class function ClassToVar(AClass: EVariantBadVarTypeError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantBadVarTypeError_sc;
  end;

  EVariantBadIndexError_sc = class of EVariantBadIndexError;
  EVariantBadIndexError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantBadIndexError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantBadIndexError;
    class function ClassToVar(AClass: EVariantBadIndexError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantBadIndexError_sc;
  end;

  EVariantArrayLockedError_sc = class of EVariantArrayLockedError;
  EVariantArrayLockedError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantArrayLockedError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantArrayLockedError;
    class function ClassToVar(AClass: EVariantArrayLockedError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantArrayLockedError_sc;
  end;

  EVariantNotAnArrayError_sc = class of EVariantNotAnArrayError;
  EVariantNotAnArrayError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantNotAnArrayError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantNotAnArrayError;
    class function ClassToVar(AClass: EVariantNotAnArrayError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantNotAnArrayError_sc;
  end;

  EVariantArrayCreateError_sc = class of EVariantArrayCreateError;
  EVariantArrayCreateError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantArrayCreateError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantArrayCreateError;
    class function ClassToVar(AClass: EVariantArrayCreateError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantArrayCreateError_sc;
  end;

  EVariantNotImplError_sc = class of EVariantNotImplError;
  EVariantNotImplError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantNotImplError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantNotImplError;
    class function ClassToVar(AClass: EVariantNotImplError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantNotImplError_sc;
  end;

  EVariantOutOfMemoryError_sc = class of EVariantOutOfMemoryError;
  EVariantOutOfMemoryError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantOutOfMemoryError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantOutOfMemoryError;
    class function ClassToVar(AClass: EVariantOutOfMemoryError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantOutOfMemoryError_sc;
  end;

  EVariantUnexpectedError_sc = class of EVariantUnexpectedError;
  EVariantUnexpectedError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantUnexpectedError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantUnexpectedError;
    class function ClassToVar(AClass: EVariantUnexpectedError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantUnexpectedError_sc;
  end;

  EVariantDispatchError_sc = class of EVariantDispatchError;
  EVariantDispatchError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantDispatchError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantDispatchError;
    class function ClassToVar(AClass: EVariantDispatchError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantDispatchError_sc;
  end;

  EVariantRangeCheckError_sc = class of EVariantRangeCheckError;
  EVariantRangeCheckError_sw = class(EVariantOverflowError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantRangeCheckError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantRangeCheckError;
    class function ClassToVar(AClass: EVariantRangeCheckError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantRangeCheckError_sc;
  end;

  EVariantInvalidNullOpError_sc = class of EVariantInvalidNullOpError;
  EVariantInvalidNullOpError_sw = class(EVariantInvalidOpError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantInvalidNullOpError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantInvalidNullOpError;
    class function ClassToVar(AClass: EVariantInvalidNullOpError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantInvalidNullOpError_sc;
  end;


{ Unit wrapper }

type
  Variants_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TCustomVariantType_sw }

class function TCustomVariantType_sw.GetTypeName: WideString;
begin
  Result := 'TCustomVariantType';
end;

class function TCustomVariantType_sw.GetWrappedClass: TClass;
begin
  Result := TCustomVariantType;
end;

class procedure TCustomVariantType_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TCustomVariantType_sw.ToVar(
  const AValue: TCustomVariantType): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomVariantType_sw.FromVar(
  const AValue: OleVariant): TCustomVariantType;
begin
  Result := TCustomVariantType(ConvFromVar(AValue, TCustomVariantType));
end;

class function TCustomVariantType_sw.ClassToVar(
  AClass: TCustomVariantType_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomVariantType_sw.ClassFromVar(
  const AClass: OleVariant): TCustomVariantType_sc;
begin
  Result := TCustomVariantType_sc(ConvClsFromVar(AClass, TCustomVariantType));
end;

{ TCustomVariantTypeClass_sw }

class function TCustomVariantTypeClass_sw.GetTypeName: WideString;
begin
  Result := 'TCustomVariantTypeClass';
end;

class function TCustomVariantTypeClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomVariantType;
end;

class function TCustomVariantTypeClass_sw.ToVar(
  const AValue: TCustomVariantTypeClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomVariantTypeClass_sw.FromVar(
  const AValue: OleVariant): TCustomVariantTypeClass;
begin
  Result := TCustomVariantTypeClass(ConvFromVar(AValue, TCustomVariantType));
end;

{ TInvokeableVariantType_sw }

class function TInvokeableVariantType_sw.GetTypeName: WideString;
begin
  Result := 'TInvokeableVariantType';
end;

class function TInvokeableVariantType_sw.GetWrappedClass: TClass;
begin
  Result := TInvokeableVariantType;
end;

class procedure TInvokeableVariantType_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TInvokeableVariantType_sw.ToVar(
  const AValue: TInvokeableVariantType): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TInvokeableVariantType_sw.FromVar(
  const AValue: OleVariant): TInvokeableVariantType;
begin
  Result := TInvokeableVariantType(ConvFromVar(AValue, TInvokeableVariantType));
end;

class function TInvokeableVariantType_sw.ClassToVar(
  AClass: TInvokeableVariantType_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TInvokeableVariantType_sw.ClassFromVar(
  const AClass: OleVariant): TInvokeableVariantType_sc;
begin
  Result := TInvokeableVariantType_sc(ConvClsFromVar(AClass, 
    TInvokeableVariantType));
end;

{ EVariantInvalidOpError_sw }

class function EVariantInvalidOpError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantInvalidOpError';
end;

class function EVariantInvalidOpError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantInvalidOpError;
end;

class procedure EVariantInvalidOpError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantInvalidOpError_sw.ToVar(
  const AValue: EVariantInvalidOpError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantInvalidOpError_sw.FromVar(
  const AValue: OleVariant): EVariantInvalidOpError;
begin
  Result := EVariantInvalidOpError(ConvFromVar(AValue, EVariantInvalidOpError));
end;

class function EVariantInvalidOpError_sw.ClassToVar(
  AClass: EVariantInvalidOpError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantInvalidOpError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantInvalidOpError_sc;
begin
  Result := EVariantInvalidOpError_sc(ConvClsFromVar(AClass, 
    EVariantInvalidOpError));
end;

{ EVariantTypeCastError_sw }

class function EVariantTypeCastError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantTypeCastError';
end;

class function EVariantTypeCastError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantTypeCastError;
end;

class procedure EVariantTypeCastError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantTypeCastError_sw.ToVar(
  const AValue: EVariantTypeCastError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantTypeCastError_sw.FromVar(
  const AValue: OleVariant): EVariantTypeCastError;
begin
  Result := EVariantTypeCastError(ConvFromVar(AValue, EVariantTypeCastError));
end;

class function EVariantTypeCastError_sw.ClassToVar(
  AClass: EVariantTypeCastError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantTypeCastError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantTypeCastError_sc;
begin
  Result := EVariantTypeCastError_sc(ConvClsFromVar(AClass, 
    EVariantTypeCastError));
end;

{ EVariantOverflowError_sw }

class function EVariantOverflowError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantOverflowError';
end;

class function EVariantOverflowError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantOverflowError;
end;

class procedure EVariantOverflowError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantOverflowError_sw.ToVar(
  const AValue: EVariantOverflowError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantOverflowError_sw.FromVar(
  const AValue: OleVariant): EVariantOverflowError;
begin
  Result := EVariantOverflowError(ConvFromVar(AValue, EVariantOverflowError));
end;

class function EVariantOverflowError_sw.ClassToVar(
  AClass: EVariantOverflowError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantOverflowError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantOverflowError_sc;
begin
  Result := EVariantOverflowError_sc(ConvClsFromVar(AClass, 
    EVariantOverflowError));
end;

{ EVariantInvalidArgError_sw }

class function EVariantInvalidArgError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantInvalidArgError';
end;

class function EVariantInvalidArgError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantInvalidArgError;
end;

class procedure EVariantInvalidArgError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantInvalidArgError_sw.ToVar(
  const AValue: EVariantInvalidArgError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantInvalidArgError_sw.FromVar(
  const AValue: OleVariant): EVariantInvalidArgError;
begin
  Result := EVariantInvalidArgError(ConvFromVar(AValue, 
    EVariantInvalidArgError));
end;

class function EVariantInvalidArgError_sw.ClassToVar(
  AClass: EVariantInvalidArgError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantInvalidArgError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantInvalidArgError_sc;
begin
  Result := EVariantInvalidArgError_sc(ConvClsFromVar(AClass, 
    EVariantInvalidArgError));
end;

{ EVariantBadVarTypeError_sw }

class function EVariantBadVarTypeError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantBadVarTypeError';
end;

class function EVariantBadVarTypeError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantBadVarTypeError;
end;

class procedure EVariantBadVarTypeError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantBadVarTypeError_sw.ToVar(
  const AValue: EVariantBadVarTypeError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantBadVarTypeError_sw.FromVar(
  const AValue: OleVariant): EVariantBadVarTypeError;
begin
  Result := EVariantBadVarTypeError(ConvFromVar(AValue, 
    EVariantBadVarTypeError));
end;

class function EVariantBadVarTypeError_sw.ClassToVar(
  AClass: EVariantBadVarTypeError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantBadVarTypeError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantBadVarTypeError_sc;
begin
  Result := EVariantBadVarTypeError_sc(ConvClsFromVar(AClass, 
    EVariantBadVarTypeError));
end;

{ EVariantBadIndexError_sw }

class function EVariantBadIndexError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantBadIndexError';
end;

class function EVariantBadIndexError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantBadIndexError;
end;

class procedure EVariantBadIndexError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantBadIndexError_sw.ToVar(
  const AValue: EVariantBadIndexError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantBadIndexError_sw.FromVar(
  const AValue: OleVariant): EVariantBadIndexError;
begin
  Result := EVariantBadIndexError(ConvFromVar(AValue, EVariantBadIndexError));
end;

class function EVariantBadIndexError_sw.ClassToVar(
  AClass: EVariantBadIndexError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantBadIndexError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantBadIndexError_sc;
begin
  Result := EVariantBadIndexError_sc(ConvClsFromVar(AClass, 
    EVariantBadIndexError));
end;

{ EVariantArrayLockedError_sw }

class function EVariantArrayLockedError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantArrayLockedError';
end;

class function EVariantArrayLockedError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantArrayLockedError;
end;

class procedure EVariantArrayLockedError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantArrayLockedError_sw.ToVar(
  const AValue: EVariantArrayLockedError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantArrayLockedError_sw.FromVar(
  const AValue: OleVariant): EVariantArrayLockedError;
begin
  Result := EVariantArrayLockedError(ConvFromVar(AValue, 
    EVariantArrayLockedError));
end;

class function EVariantArrayLockedError_sw.ClassToVar(
  AClass: EVariantArrayLockedError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantArrayLockedError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantArrayLockedError_sc;
begin
  Result := EVariantArrayLockedError_sc(ConvClsFromVar(AClass, 
    EVariantArrayLockedError));
end;

{ EVariantNotAnArrayError_sw }

class function EVariantNotAnArrayError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantNotAnArrayError';
end;

class function EVariantNotAnArrayError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantNotAnArrayError;
end;

class procedure EVariantNotAnArrayError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantNotAnArrayError_sw.ToVar(
  const AValue: EVariantNotAnArrayError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantNotAnArrayError_sw.FromVar(
  const AValue: OleVariant): EVariantNotAnArrayError;
begin
  Result := EVariantNotAnArrayError(ConvFromVar(AValue, 
    EVariantNotAnArrayError));
end;

class function EVariantNotAnArrayError_sw.ClassToVar(
  AClass: EVariantNotAnArrayError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantNotAnArrayError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantNotAnArrayError_sc;
begin
  Result := EVariantNotAnArrayError_sc(ConvClsFromVar(AClass, 
    EVariantNotAnArrayError));
end;

{ EVariantArrayCreateError_sw }

class function EVariantArrayCreateError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantArrayCreateError';
end;

class function EVariantArrayCreateError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantArrayCreateError;
end;

class procedure EVariantArrayCreateError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantArrayCreateError_sw.ToVar(
  const AValue: EVariantArrayCreateError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantArrayCreateError_sw.FromVar(
  const AValue: OleVariant): EVariantArrayCreateError;
begin
  Result := EVariantArrayCreateError(ConvFromVar(AValue, 
    EVariantArrayCreateError));
end;

class function EVariantArrayCreateError_sw.ClassToVar(
  AClass: EVariantArrayCreateError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantArrayCreateError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantArrayCreateError_sc;
begin
  Result := EVariantArrayCreateError_sc(ConvClsFromVar(AClass, 
    EVariantArrayCreateError));
end;

{ EVariantNotImplError_sw }

class function EVariantNotImplError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantNotImplError';
end;

class function EVariantNotImplError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantNotImplError;
end;

class procedure EVariantNotImplError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantNotImplError_sw.ToVar(
  const AValue: EVariantNotImplError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantNotImplError_sw.FromVar(
  const AValue: OleVariant): EVariantNotImplError;
begin
  Result := EVariantNotImplError(ConvFromVar(AValue, EVariantNotImplError));
end;

class function EVariantNotImplError_sw.ClassToVar(
  AClass: EVariantNotImplError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantNotImplError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantNotImplError_sc;
begin
  Result := EVariantNotImplError_sc(ConvClsFromVar(AClass, 
    EVariantNotImplError));
end;

{ EVariantOutOfMemoryError_sw }

class function EVariantOutOfMemoryError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantOutOfMemoryError';
end;

class function EVariantOutOfMemoryError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantOutOfMemoryError;
end;

class procedure EVariantOutOfMemoryError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantOutOfMemoryError_sw.ToVar(
  const AValue: EVariantOutOfMemoryError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantOutOfMemoryError_sw.FromVar(
  const AValue: OleVariant): EVariantOutOfMemoryError;
begin
  Result := EVariantOutOfMemoryError(ConvFromVar(AValue, 
    EVariantOutOfMemoryError));
end;

class function EVariantOutOfMemoryError_sw.ClassToVar(
  AClass: EVariantOutOfMemoryError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantOutOfMemoryError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantOutOfMemoryError_sc;
begin
  Result := EVariantOutOfMemoryError_sc(ConvClsFromVar(AClass, 
    EVariantOutOfMemoryError));
end;

{ EVariantUnexpectedError_sw }

class function EVariantUnexpectedError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantUnexpectedError';
end;

class function EVariantUnexpectedError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantUnexpectedError;
end;

class procedure EVariantUnexpectedError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantUnexpectedError_sw.ToVar(
  const AValue: EVariantUnexpectedError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantUnexpectedError_sw.FromVar(
  const AValue: OleVariant): EVariantUnexpectedError;
begin
  Result := EVariantUnexpectedError(ConvFromVar(AValue, 
    EVariantUnexpectedError));
end;

class function EVariantUnexpectedError_sw.ClassToVar(
  AClass: EVariantUnexpectedError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantUnexpectedError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantUnexpectedError_sc;
begin
  Result := EVariantUnexpectedError_sc(ConvClsFromVar(AClass, 
    EVariantUnexpectedError));
end;

{ EVariantDispatchError_sw }

class function EVariantDispatchError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantDispatchError';
end;

class function EVariantDispatchError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantDispatchError;
end;

class procedure EVariantDispatchError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantDispatchError_sw.ToVar(
  const AValue: EVariantDispatchError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantDispatchError_sw.FromVar(
  const AValue: OleVariant): EVariantDispatchError;
begin
  Result := EVariantDispatchError(ConvFromVar(AValue, EVariantDispatchError));
end;

class function EVariantDispatchError_sw.ClassToVar(
  AClass: EVariantDispatchError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantDispatchError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantDispatchError_sc;
begin
  Result := EVariantDispatchError_sc(ConvClsFromVar(AClass, 
    EVariantDispatchError));
end;

{ EVariantRangeCheckError_sw }

class function EVariantRangeCheckError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantRangeCheckError';
end;

class function EVariantRangeCheckError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantRangeCheckError;
end;

class procedure EVariantRangeCheckError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantRangeCheckError_sw.ToVar(
  const AValue: EVariantRangeCheckError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantRangeCheckError_sw.FromVar(
  const AValue: OleVariant): EVariantRangeCheckError;
begin
  Result := EVariantRangeCheckError(ConvFromVar(AValue, 
    EVariantRangeCheckError));
end;

class function EVariantRangeCheckError_sw.ClassToVar(
  AClass: EVariantRangeCheckError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantRangeCheckError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantRangeCheckError_sc;
begin
  Result := EVariantRangeCheckError_sc(ConvClsFromVar(AClass, 
    EVariantRangeCheckError));
end;

{ EVariantInvalidNullOpError_sw }

class function EVariantInvalidNullOpError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantInvalidNullOpError';
end;

class function EVariantInvalidNullOpError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantInvalidNullOpError;
end;

class procedure EVariantInvalidNullOpError_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantInvalidNullOpError_sw.ToVar(
  const AValue: EVariantInvalidNullOpError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantInvalidNullOpError_sw.FromVar(
  const AValue: OleVariant): EVariantInvalidNullOpError;
begin
  Result := EVariantInvalidNullOpError(ConvFromVar(AValue, 
    EVariantInvalidNullOpError));
end;

class function EVariantInvalidNullOpError_sw.ClassToVar(
  AClass: EVariantInvalidNullOpError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantInvalidNullOpError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantInvalidNullOpError_sc;
begin
  Result := EVariantInvalidNullOpError_sc(ConvClsFromVar(AClass, 
    EVariantInvalidNullOpError));
end;

{ Variants_sw }

function Variants_TCustomVariantType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomVariantType = class(TObject, IInterface);

  Result := TLMDUnitWrapper.TypeToVar(TCustomVariantType_sw);
end;

function Variants_TCustomVariantTypeClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomVariantTypeClass = class of TCustomVariantType;

  Result := TLMDUnitWrapper.TypeToVar(TCustomVariantTypeClass_sw);
end;

function Variants_TInvokeableVariantType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInvokeableVariantType = class(TCustomVariantType, I...

  Result := TLMDUnitWrapper.TypeToVar(TInvokeableVariantType_sw);
end;

function Variants_EVariantInvalidOpError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantInvalidOpError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantInvalidOpError_sw);
end;

function Variants_EVariantTypeCastError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantTypeCastError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantTypeCastError_sw);
end;

function Variants_EVariantOverflowError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantOverflowError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantOverflowError_sw);
end;

function Variants_EVariantInvalidArgError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantInvalidArgError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantInvalidArgError_sw);
end;

function Variants_EVariantBadVarTypeError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantBadVarTypeError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantBadVarTypeError_sw);
end;

function Variants_EVariantBadIndexError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantBadIndexError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantBadIndexError_sw);
end;

function Variants_EVariantArrayLockedError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantArrayLockedError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantArrayLockedError_sw);
end;

function Variants_EVariantNotAnArrayError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantNotAnArrayError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantNotAnArrayError_sw);
end;

function Variants_EVariantArrayCreateError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantArrayCreateError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantArrayCreateError_sw);
end;

function Variants_EVariantNotImplError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantNotImplError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantNotImplError_sw);
end;

function Variants_EVariantOutOfMemoryError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantOutOfMemoryError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantOutOfMemoryError_sw);
end;

function Variants_EVariantUnexpectedError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantUnexpectedError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantUnexpectedError_sw);
end;

function Variants_EVariantDispatchError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantDispatchError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantDispatchError_sw);
end;

function Variants_EVariantRangeCheckError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantRangeCheckError = class(EVariantOverflowError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantRangeCheckError_sw);
end;

function Variants_EVariantInvalidNullOpError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantInvalidNullOpError = class(EVariantInvalidOp...

  Result := TLMDUnitWrapper.TypeToVar(EVariantInvalidNullOpError_sw);
end;

class function Variants_sw.GetUnitName: WideString;
begin
  Result := 'Variants';
end;

class procedure Variants_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TCustomVariantType_sw, Variants_TCustomVariantType_si);
  AData.AddType(TCustomVariantTypeClass_sw, Variants_TCustomVariantTypeClass_si);
  AData.AddType(TInvokeableVariantType_sw, Variants_TInvokeableVariantType_si);
  AData.AddType(EVariantInvalidOpError_sw, Variants_EVariantInvalidOpError_si);
  AData.AddType(EVariantTypeCastError_sw, Variants_EVariantTypeCastError_si);
  AData.AddType(EVariantOverflowError_sw, Variants_EVariantOverflowError_si);
  AData.AddType(EVariantInvalidArgError_sw, Variants_EVariantInvalidArgError_si);
  AData.AddType(EVariantBadVarTypeError_sw, Variants_EVariantBadVarTypeError_si);
  AData.AddType(EVariantBadIndexError_sw, Variants_EVariantBadIndexError_si);
  AData.AddType(EVariantArrayLockedError_sw, Variants_EVariantArrayLockedError_si);
  AData.AddType(EVariantNotAnArrayError_sw, Variants_EVariantNotAnArrayError_si);
  AData.AddType(EVariantArrayCreateError_sw, Variants_EVariantArrayCreateError_si);
  AData.AddType(EVariantNotImplError_sw, Variants_EVariantNotImplError_si);
  AData.AddType(EVariantOutOfMemoryError_sw, Variants_EVariantOutOfMemoryError_si);
  AData.AddType(EVariantUnexpectedError_sw, Variants_EVariantUnexpectedError_si);
  AData.AddType(EVariantDispatchError_sw, Variants_EVariantDispatchError_si);
  AData.AddType(EVariantRangeCheckError_sw, Variants_EVariantRangeCheckError_si);
  AData.AddType(EVariantInvalidNullOpError_sw, Variants_EVariantInvalidNullOpError_si);
end;

class function Variants_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Variants_sw);
end;

initialization
  RegisterUnitWrapper(Variants_sw);
  RegisterClassWrapper(TCustomVariantType_sw);
  RegisterClassWrapper(TInvokeableVariantType_sw);
  RegisterClassWrapper(EVariantInvalidOpError_sw);
  RegisterClassWrapper(EVariantTypeCastError_sw);
  RegisterClassWrapper(EVariantOverflowError_sw);
  RegisterClassWrapper(EVariantInvalidArgError_sw);
  RegisterClassWrapper(EVariantBadVarTypeError_sw);
  RegisterClassWrapper(EVariantBadIndexError_sw);
  RegisterClassWrapper(EVariantArrayLockedError_sw);
  RegisterClassWrapper(EVariantNotAnArrayError_sw);
  RegisterClassWrapper(EVariantArrayCreateError_sw);
  RegisterClassWrapper(EVariantNotImplError_sw);
  RegisterClassWrapper(EVariantOutOfMemoryError_sw);
  RegisterClassWrapper(EVariantUnexpectedError_sw);
  RegisterClassWrapper(EVariantDispatchError_sw);
  RegisterClassWrapper(EVariantRangeCheckError_sw);
  RegisterClassWrapper(EVariantInvalidNullOpError_sw);

end.
