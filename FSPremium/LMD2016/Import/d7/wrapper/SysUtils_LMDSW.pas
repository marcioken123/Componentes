unit SysUtils_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'SysUtils' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  SysUtils, Classes, Variants, TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Windows, SysConst, Windows_LMDSW,
  SysConst_LMDSW;


{ Type wrappers }

type
  TLanguages_sw = class;
  Exception_sw = class;
  ExceptClass_sw = class;
  EAbort_sw = class;
  EHeapException_sw = class;
  EOutOfMemory_sw = class;
  EInOutError_sw = class;
  EExternal_sw = class;
  EExternalException_sw = class;
  EIntError_sw = class;
  EDivByZero_sw = class;
  ERangeError_sw = class;
  EIntOverflow_sw = class;
  EMathError_sw = class;
  EInvalidOp_sw = class;
  EZeroDivide_sw = class;
  EOverflow_sw = class;
  EUnderflow_sw = class;
  EInvalidPointer_sw = class;
  EInvalidCast_sw = class;
  EConvertError_sw = class;
  EAccessViolation_sw = class;
  EPrivilege_sw = class;
  EStackOverflow_sw = class;
  EControlC_sw = class;
  EVariantError_sw = class;
  EPropReadOnly_sw = class;
  EPropWriteOnly_sw = class;
  EAssertionFailed_sw = class;
  EAbstractError_sw = class;
  EIntfCastError_sw = class;
  EInvalidContainer_sw = class;
  EInvalidInsert_sw = class;
  EPackageError_sw = class;
  EOSError_sw = class;
  EWin32Error_sw = class;
  ESafecallException_sw = class;
  TSimpleRWSync_sw = class;
  TThreadLocalCounter_sw = class;
  TMultiReadExclusiveWriteSynchronizer_sw = class;

  TSysCharSet_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TSysCharSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TSysCharSet;
  end;

  WordRec_sw = class(TLMDRecordWrapper)
  private
    FValue: WordRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: WordRec): OleVariant;
    class function FromVar(const AValue: OleVariant): WordRec;
  end;

  LongRec_sw = class(TLMDRecordWrapper)
  private
    FValue: LongRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: LongRec): OleVariant;
    class function FromVar(const AValue: OleVariant): LongRec;
  end;

  Int64Rec_sw = class(TLMDRecordWrapper)
  private
    FValue: Int64Rec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: Int64Rec): OleVariant;
    class function FromVar(const AValue: OleVariant): Int64Rec;
  end;

  TFileName_sw = class(string_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFileName): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileName;
  end;

  TSearchRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TSearchRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TSearchRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TSearchRec;
  end;

  TFloatValue_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFloatValue): OleVariant;
    class function FromVar(const AValue: OleVariant): TFloatValue;
  end;

  TFloatFormat_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFloatFormat): OleVariant;
    class function FromVar(const AValue: OleVariant): TFloatFormat;
  end;

  TFloatRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TFloatRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TFloatRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TFloatRec;
  end;

  TTimeStamp_sw = class(TLMDRecordWrapper)
  private
    FValue: TTimeStamp;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TTimeStamp): OleVariant;
    class function FromVar(const AValue: OleVariant): TTimeStamp;
  end;

  TMbcsByteType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMbcsByteType): OleVariant;
    class function FromVar(const AValue: OleVariant): TMbcsByteType;
  end;

  TSysLocale_sw = class(TLMDRecordWrapper)
  private
    FValue: TSysLocale;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TSysLocale): OleVariant;
    class function FromVar(const AValue: OleVariant): TSysLocale;
  end;

  TLangRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TLangRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TLangRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TLangRec;
  end;

  TLanguages_sc = class of TLanguages;
  TLanguages_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TLanguages): OleVariant;
    class function FromVar(const AValue: OleVariant): TLanguages;
    class function ClassToVar(AClass: TLanguages_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TLanguages_sc;
  end;

  Exception_sc = class of Exception;
  Exception_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: Exception): OleVariant;
    class function FromVar(const AValue: OleVariant): Exception;
    class function ClassToVar(AClass: Exception_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): Exception_sc;
  end;

  ExceptClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: ExceptClass): OleVariant;
    class function FromVar(const AValue: OleVariant): ExceptClass;
  end;

  EAbort_sc = class of EAbort;
  EAbort_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EAbort): OleVariant;
    class function FromVar(const AValue: OleVariant): EAbort;
    class function ClassToVar(AClass: EAbort_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EAbort_sc;
  end;

  EHeapException_sc = class of EHeapException;
  EHeapException_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EHeapException): OleVariant;
    class function FromVar(const AValue: OleVariant): EHeapException;
    class function ClassToVar(AClass: EHeapException_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EHeapException_sc;
  end;

  EOutOfMemory_sc = class of EOutOfMemory;
  EOutOfMemory_sw = class(EHeapException_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EOutOfMemory): OleVariant;
    class function FromVar(const AValue: OleVariant): EOutOfMemory;
    class function ClassToVar(AClass: EOutOfMemory_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EOutOfMemory_sc;
  end;

  EInOutError_sc = class of EInOutError;
  EInOutError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EInOutError): OleVariant;
    class function FromVar(const AValue: OleVariant): EInOutError;
    class function ClassToVar(AClass: EInOutError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EInOutError_sc;
  end;

  TExceptionRecord_sw = class(TLMDRecordWrapper)
  private
    FValue: TExceptionRecord;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TExceptionRecord): OleVariant;
    class function FromVar(const AValue: OleVariant): TExceptionRecord;
  end;

  EExternal_sc = class of EExternal;
  EExternal_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EExternal): OleVariant;
    class function FromVar(const AValue: OleVariant): EExternal;
    class function ClassToVar(AClass: EExternal_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EExternal_sc;
  end;

  EExternalException_sc = class of EExternalException;
  EExternalException_sw = class(EExternal_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EExternalException): OleVariant;
    class function FromVar(const AValue: OleVariant): EExternalException;
    class function ClassToVar(AClass: EExternalException_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EExternalException_sc;
  end;

  EIntError_sc = class of EIntError;
  EIntError_sw = class(EExternal_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EIntError): OleVariant;
    class function FromVar(const AValue: OleVariant): EIntError;
    class function ClassToVar(AClass: EIntError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EIntError_sc;
  end;

  EDivByZero_sc = class of EDivByZero;
  EDivByZero_sw = class(EIntError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EDivByZero): OleVariant;
    class function FromVar(const AValue: OleVariant): EDivByZero;
    class function ClassToVar(AClass: EDivByZero_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EDivByZero_sc;
  end;

  ERangeError_sc = class of ERangeError;
  ERangeError_sw = class(EIntError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: ERangeError): OleVariant;
    class function FromVar(const AValue: OleVariant): ERangeError;
    class function ClassToVar(AClass: ERangeError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): ERangeError_sc;
  end;

  EIntOverflow_sc = class of EIntOverflow;
  EIntOverflow_sw = class(EIntError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EIntOverflow): OleVariant;
    class function FromVar(const AValue: OleVariant): EIntOverflow;
    class function ClassToVar(AClass: EIntOverflow_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EIntOverflow_sc;
  end;

  EMathError_sc = class of EMathError;
  EMathError_sw = class(EExternal_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EMathError): OleVariant;
    class function FromVar(const AValue: OleVariant): EMathError;
    class function ClassToVar(AClass: EMathError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EMathError_sc;
  end;

  EInvalidOp_sc = class of EInvalidOp;
  EInvalidOp_sw = class(EMathError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EInvalidOp): OleVariant;
    class function FromVar(const AValue: OleVariant): EInvalidOp;
    class function ClassToVar(AClass: EInvalidOp_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EInvalidOp_sc;
  end;

  EZeroDivide_sc = class of EZeroDivide;
  EZeroDivide_sw = class(EMathError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EZeroDivide): OleVariant;
    class function FromVar(const AValue: OleVariant): EZeroDivide;
    class function ClassToVar(AClass: EZeroDivide_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EZeroDivide_sc;
  end;

  EOverflow_sc = class of EOverflow;
  EOverflow_sw = class(EMathError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EOverflow): OleVariant;
    class function FromVar(const AValue: OleVariant): EOverflow;
    class function ClassToVar(AClass: EOverflow_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EOverflow_sc;
  end;

  EUnderflow_sc = class of EUnderflow;
  EUnderflow_sw = class(EMathError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EUnderflow): OleVariant;
    class function FromVar(const AValue: OleVariant): EUnderflow;
    class function ClassToVar(AClass: EUnderflow_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EUnderflow_sc;
  end;

  EInvalidPointer_sc = class of EInvalidPointer;
  EInvalidPointer_sw = class(EHeapException_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EInvalidPointer): OleVariant;
    class function FromVar(const AValue: OleVariant): EInvalidPointer;
    class function ClassToVar(AClass: EInvalidPointer_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EInvalidPointer_sc;
  end;

  EInvalidCast_sc = class of EInvalidCast;
  EInvalidCast_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EInvalidCast): OleVariant;
    class function FromVar(const AValue: OleVariant): EInvalidCast;
    class function ClassToVar(AClass: EInvalidCast_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EInvalidCast_sc;
  end;

  EConvertError_sc = class of EConvertError;
  EConvertError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EConvertError): OleVariant;
    class function FromVar(const AValue: OleVariant): EConvertError;
    class function ClassToVar(AClass: EConvertError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EConvertError_sc;
  end;

  EAccessViolation_sc = class of EAccessViolation;
  EAccessViolation_sw = class(EExternal_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EAccessViolation): OleVariant;
    class function FromVar(const AValue: OleVariant): EAccessViolation;
    class function ClassToVar(AClass: EAccessViolation_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EAccessViolation_sc;
  end;

  EPrivilege_sc = class of EPrivilege;
  EPrivilege_sw = class(EExternal_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EPrivilege): OleVariant;
    class function FromVar(const AValue: OleVariant): EPrivilege;
    class function ClassToVar(AClass: EPrivilege_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EPrivilege_sc;
  end;

  EStackOverflow_sc = class of EStackOverflow;
  EStackOverflow_sw = class(EExternal_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EStackOverflow): OleVariant;
    class function FromVar(const AValue: OleVariant): EStackOverflow;
    class function ClassToVar(AClass: EStackOverflow_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EStackOverflow_sc;
  end;

  EControlC_sc = class of EControlC;
  EControlC_sw = class(EExternal_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EControlC): OleVariant;
    class function FromVar(const AValue: OleVariant): EControlC;
    class function ClassToVar(AClass: EControlC_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EControlC_sc;
  end;

  EVariantError_sc = class of EVariantError;
  EVariantError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantError;
    class function ClassToVar(AClass: EVariantError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantError_sc;
  end;

  EPropReadOnly_sc = class of EPropReadOnly;
  EPropReadOnly_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EPropReadOnly): OleVariant;
    class function FromVar(const AValue: OleVariant): EPropReadOnly;
    class function ClassToVar(AClass: EPropReadOnly_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EPropReadOnly_sc;
  end;

  EPropWriteOnly_sc = class of EPropWriteOnly;
  EPropWriteOnly_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EPropWriteOnly): OleVariant;
    class function FromVar(const AValue: OleVariant): EPropWriteOnly;
    class function ClassToVar(AClass: EPropWriteOnly_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EPropWriteOnly_sc;
  end;

  EAssertionFailed_sc = class of EAssertionFailed;
  EAssertionFailed_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EAssertionFailed): OleVariant;
    class function FromVar(const AValue: OleVariant): EAssertionFailed;
    class function ClassToVar(AClass: EAssertionFailed_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EAssertionFailed_sc;
  end;

  EAbstractError_sc = class of EAbstractError;
  EAbstractError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EAbstractError): OleVariant;
    class function FromVar(const AValue: OleVariant): EAbstractError;
    class function ClassToVar(AClass: EAbstractError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EAbstractError_sc;
  end;

  EIntfCastError_sc = class of EIntfCastError;
  EIntfCastError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EIntfCastError): OleVariant;
    class function FromVar(const AValue: OleVariant): EIntfCastError;
    class function ClassToVar(AClass: EIntfCastError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EIntfCastError_sc;
  end;

  EInvalidContainer_sc = class of EInvalidContainer;
  EInvalidContainer_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EInvalidContainer): OleVariant;
    class function FromVar(const AValue: OleVariant): EInvalidContainer;
    class function ClassToVar(AClass: EInvalidContainer_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EInvalidContainer_sc;
  end;

  EInvalidInsert_sc = class of EInvalidInsert;
  EInvalidInsert_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EInvalidInsert): OleVariant;
    class function FromVar(const AValue: OleVariant): EInvalidInsert;
    class function ClassToVar(AClass: EInvalidInsert_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EInvalidInsert_sc;
  end;

  EPackageError_sc = class of EPackageError;
  EPackageError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EPackageError): OleVariant;
    class function FromVar(const AValue: OleVariant): EPackageError;
    class function ClassToVar(AClass: EPackageError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EPackageError_sc;
  end;

  EOSError_sc = class of EOSError;
  EOSError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EOSError): OleVariant;
    class function FromVar(const AValue: OleVariant): EOSError;
    class function ClassToVar(AClass: EOSError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EOSError_sc;
  end;

  EWin32Error_sc = class of EWin32Error;
  EWin32Error_sw = class(EOSError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EWin32Error): OleVariant;
    class function FromVar(const AValue: OleVariant): EWin32Error;
    class function ClassToVar(AClass: EWin32Error_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EWin32Error_sc;
  end;

  ESafecallException_sc = class of ESafecallException;
  ESafecallException_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: ESafecallException): OleVariant;
    class function FromVar(const AValue: OleVariant): ESafecallException;
    class function ClassToVar(AClass: ESafecallException_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): ESafecallException_sc;
  end;

  TFormatSettings_sw = class(TLMDRecordWrapper)
  private
    FValue: TFormatSettings;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TFormatSettings): OleVariant;
    class function FromVar(const AValue: OleVariant): TFormatSettings;
  end;

  TFilenameCaseMatch_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFilenameCaseMatch): OleVariant;
    class function FromVar(const AValue: OleVariant): TFilenameCaseMatch;
  end;

  TNameType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TNameType): OleVariant;
    class function FromVar(const AValue: OleVariant): TNameType;
  end;

  TSimpleRWSync_sc = class of TSimpleRWSync;
  TSimpleRWSync_sw = class(TInterfacedObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSimpleRWSync): OleVariant;
    class function FromVar(const AValue: OleVariant): TSimpleRWSync;
    class function ClassToVar(AClass: TSimpleRWSync_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSimpleRWSync_sc;
  end;

  TThreadInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TThreadInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TThreadInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TThreadInfo;
  end;

  TThreadLocalCounter_sc = class of TThreadLocalCounter;
  TThreadLocalCounter_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TThreadLocalCounter): OleVariant;
    class function FromVar(const AValue: OleVariant): TThreadLocalCounter;
    class function ClassToVar(AClass: TThreadLocalCounter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TThreadLocalCounter_sc;
  end;

  TMultiReadExclusiveWriteSynchronizer_sc = class of TMultiReadExclusiveWriteSynchronizer;
  TMultiReadExclusiveWriteSynchronizer_sw = class(TInterfacedObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMultiReadExclusiveWriteSynchronizer): OleVariant;
    class function FromVar(const AValue: OleVariant): TMultiReadExclusiveWriteSynchronizer;
    class function ClassToVar(AClass: TMultiReadExclusiveWriteSynchronizer_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMultiReadExclusiveWriteSynchronizer_sc;
  end;

  TMREWSync_sw = TMultiReadExclusiveWriteSynchronizer_sw;


{ Unit wrapper }

type
  SysUtils_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TSysCharSet_sw }

class function TSysCharSet_sw.GetTypeName: WideString;
begin
  Result := 'TSysCharSet';
end;

class function TSysCharSet_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TSysCharSet);
end;

class function TSysCharSet_sw.ToVar(const AValue: TSysCharSet): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TSysCharSet_sw.FromVar(const AValue: OleVariant): TSysCharSet;
begin
  ConvFromVar(AValue, @Result);
end;

{ WordRec_sw }

function WordRec_Lo_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Lo: Byte;

  if IsGet then
    Result := WordRec_sw(AObj).FValue.Lo
  else
    WordRec_sw(AObj).FValue.Lo := Byte(AArgs[0]);
end;

function WordRec_Hi_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Hi: Byte;

  if IsGet then
    Result := WordRec_sw(AObj).FValue.Hi
  else
    WordRec_sw(AObj).FValue.Hi := Byte(AArgs[0]);
end;

function WordRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := WordRec_sw.Create as IDispatch;
end;

function WordRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: WordRec;

  // Implicit record copy method.
  Result := WordRec_sw.ToVar(WordRec(AObj));
end;

class function WordRec_sw.GetTypeName: WideString;
begin
  Result := 'WordRec';
end;

function WordRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := WordRec_sw.Create;
  WordRec_sw(Result).FValue := FValue;
end;

class procedure WordRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Lo', WordRec_Lo_si, Byte_sw);
  AData.AddField('Hi', WordRec_Hi_si, Byte_sw);
  AData.AddFunction('Copy', WordRec_Copy_si, WordRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', WordRec_Create_si, 0, False);
end;

class function WordRec_sw.ToVar(const AValue: WordRec): OleVariant;
var
  wrpr: WordRec_sw;
begin
  wrpr        := WordRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function WordRec_sw.FromVar(const AValue: OleVariant): WordRec;
begin
  Result := WordRec_sw(ConvFromVar(AValue)).FValue;
end;

{ LongRec_sw }

function LongRec_Lo_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Lo: Word;

  if IsGet then
    Result := LongRec_sw(AObj).FValue.Lo
  else
    LongRec_sw(AObj).FValue.Lo := Word(AArgs[0]);
end;

function LongRec_Hi_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Hi: Word;

  if IsGet then
    Result := LongRec_sw(AObj).FValue.Hi
  else
    LongRec_sw(AObj).FValue.Hi := Word(AArgs[0]);
end;

function LongRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := LongRec_sw.Create as IDispatch;
end;

function LongRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: LongRec;

  // Implicit record copy method.
  Result := LongRec_sw.ToVar(LongRec(AObj));
end;

class function LongRec_sw.GetTypeName: WideString;
begin
  Result := 'LongRec';
end;

function LongRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := LongRec_sw.Create;
  LongRec_sw(Result).FValue := FValue;
end;

class procedure LongRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Lo', LongRec_Lo_si, Word_sw);
  AData.AddField('Hi', LongRec_Hi_si, Word_sw);
  AData.AddFunction('Copy', LongRec_Copy_si, LongRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', LongRec_Create_si, 0, False);
end;

class function LongRec_sw.ToVar(const AValue: LongRec): OleVariant;
var
  wrpr: LongRec_sw;
begin
  wrpr        := LongRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function LongRec_sw.FromVar(const AValue: OleVariant): LongRec;
begin
  Result := LongRec_sw(ConvFromVar(AValue)).FValue;
end;

{ Int64Rec_sw }

function Int64Rec_Lo_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Lo: Cardinal;

  if IsGet then
    Result := Int64Rec_sw(AObj).FValue.Lo
  else
    Int64Rec_sw(AObj).FValue.Lo := Cardinal(AArgs[0]);
end;

function Int64Rec_Hi_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Hi: Cardinal;

  if IsGet then
    Result := Int64Rec_sw(AObj).FValue.Hi
  else
    Int64Rec_sw(AObj).FValue.Hi := Cardinal(AArgs[0]);
end;

function Int64Rec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := Int64Rec_sw.Create as IDispatch;
end;

function Int64Rec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: Int64Rec;

  // Implicit record copy method.
  Result := Int64Rec_sw.ToVar(Int64Rec(AObj));
end;

class function Int64Rec_sw.GetTypeName: WideString;
begin
  Result := 'Int64Rec';
end;

function Int64Rec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := Int64Rec_sw.Create;
  Int64Rec_sw(Result).FValue := FValue;
end;

class procedure Int64Rec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Lo', Int64Rec_Lo_si, Cardinal_sw);
  AData.AddField('Hi', Int64Rec_Hi_si, Cardinal_sw);
  AData.AddFunction('Copy', Int64Rec_Copy_si, Int64Rec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', Int64Rec_Create_si, 0, False);
end;

class function Int64Rec_sw.ToVar(const AValue: Int64Rec): OleVariant;
var
  wrpr: Int64Rec_sw;
begin
  wrpr        := Int64Rec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function Int64Rec_sw.FromVar(const AValue: OleVariant): Int64Rec;
begin
  Result := Int64Rec_sw(ConvFromVar(AValue)).FValue;
end;

{ TFileName_sw }

class function TFileName_sw.GetTypeName: WideString;
begin
  Result := 'TFileName';
end;

class function TFileName_sw.ToVar(const AValue: TFileName): OleVariant;
begin
  Result := string_sw.ToVar(string(AValue));
end;

class function TFileName_sw.FromVar(const AValue: OleVariant): TFileName;
begin
  Result := TFileName(string_sw.FromVar(AValue));
end;

{ TSearchRec_sw }

function TSearchRec_Time_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Time: Integer;

  if IsGet then
    Result := TSearchRec_sw(AObj).FValue.Time
  else
    TSearchRec_sw(AObj).FValue.Time := Integer(AArgs[0]);
end;

function TSearchRec_Size_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Size: Integer;

  if IsGet then
    Result := TSearchRec_sw(AObj).FValue.Size
  else
    TSearchRec_sw(AObj).FValue.Size := Integer(AArgs[0]);
end;

function TSearchRec_Attr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Attr: Integer;

  if IsGet then
    Result := TSearchRec_sw(AObj).FValue.Attr
  else
    TSearchRec_sw(AObj).FValue.Attr := Integer(AArgs[0]);
end;

function TSearchRec_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Name: TFileName;

  if IsGet then
    Result := TFileName_sw.ToVar(TSearchRec_sw(AObj).FValue.Name)
  else
    TSearchRec_sw(AObj).FValue.Name := TFileName_sw.FromVar(AArgs[0]);
end;

function TSearchRec_ExcludeAttr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ExcludeAttr: Integer;

  if IsGet then
    Result := TSearchRec_sw(AObj).FValue.ExcludeAttr
  else
    TSearchRec_sw(AObj).FValue.ExcludeAttr := Integer(AArgs[0]);
end;

function TSearchRec_FindHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FindHandle: THandle;

  if IsGet then
    Result := THandle_sw.ToVar(TSearchRec_sw(AObj).FValue.FindHandle)
  else
    TSearchRec_sw(AObj).FValue.FindHandle := THandle_sw.FromVar(AArgs[0]);
end;

function TSearchRec_FindData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FindData: TWin32FindData;

  if IsGet then
    Result := TWin32FindData_sw.ToVar(TSearchRec_sw(AObj).FValue.FindData)
  else
    TSearchRec_sw(AObj).FValue.FindData := TWin32FindData_sw.FromVar(AArgs[0]);
end;

function TSearchRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TSearchRec_sw.Create as IDispatch;
end;

function TSearchRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TSearchRec;

  // Implicit record copy method.
  Result := TSearchRec_sw.ToVar(TSearchRec(AObj));
end;

class function TSearchRec_sw.GetTypeName: WideString;
begin
  Result := 'TSearchRec';
end;

function TSearchRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TSearchRec_sw.Create;
  TSearchRec_sw(Result).FValue := FValue;
end;

class procedure TSearchRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Time', TSearchRec_Time_si, Integer_sw);
  AData.AddField('Size', TSearchRec_Size_si, Integer_sw);
  AData.AddField('Attr', TSearchRec_Attr_si, Integer_sw);
  AData.AddField('Name', TSearchRec_Name_si, TFileName_sw);
  AData.AddField('ExcludeAttr', TSearchRec_ExcludeAttr_si, Integer_sw);
  AData.AddField('FindHandle', TSearchRec_FindHandle_si, THandle_sw);
  AData.AddField('FindData', TSearchRec_FindData_si, TWin32FindData_sw);
  AData.AddFunction('Copy', TSearchRec_Copy_si, TSearchRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TSearchRec_Create_si, 0, False);
end;

class function TSearchRec_sw.ToVar(const AValue: TSearchRec): OleVariant;
var
  wrpr: TSearchRec_sw;
begin
  wrpr        := TSearchRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TSearchRec_sw.FromVar(const AValue: OleVariant): TSearchRec;
begin
  Result := TSearchRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TFloatValue_sw }

class function TFloatValue_sw.GetTypeName: WideString;
begin
  Result := 'TFloatValue';
end;

class procedure TFloatValue_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'fvExtended'; Value: Integer({$IFDEF LMDSCT_12}TFloatValue.{$ENDIF}fvExtended)),
    (Name: 'fvCurrency'; Value: Integer({$IFDEF LMDSCT_12}TFloatValue.{$ENDIF}fvCurrency))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TFloatValue_sw.ToVar(const AValue: TFloatValue): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFloatValue_sw.FromVar(const AValue: OleVariant): TFloatValue;
begin
  Result := TFloatValue(Integer(AValue));
end;

{ TFloatFormat_sw }

class function TFloatFormat_sw.GetTypeName: WideString;
begin
  Result := 'TFloatFormat';
end;

class procedure TFloatFormat_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'ffGeneral'; Value: Integer({$IFDEF LMDSCT_12}TFloatFormat.{$ENDIF}ffGeneral)),
    (Name: 'ffExponent'; Value: Integer({$IFDEF LMDSCT_12}TFloatFormat.{$ENDIF}ffExponent)),
    (Name: 'ffFixed'; Value: Integer({$IFDEF LMDSCT_12}TFloatFormat.{$ENDIF}ffFixed)),
    (Name: 'ffNumber'; Value: Integer({$IFDEF LMDSCT_12}TFloatFormat.{$ENDIF}ffNumber)),
    (Name: 'ffCurrency'; Value: Integer({$IFDEF LMDSCT_12}TFloatFormat.{$ENDIF}ffCurrency))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TFloatFormat_sw.ToVar(const AValue: TFloatFormat): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFloatFormat_sw.FromVar(const AValue: OleVariant): TFloatFormat;
begin
  Result := TFloatFormat(Integer(AValue));
end;

{ TFloatRec_sw }

function TFloatRec_Exponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Exponent: Smallint;

  if IsGet then
    Result := TFloatRec_sw(AObj).FValue.Exponent
  else
    TFloatRec_sw(AObj).FValue.Exponent := Smallint(AArgs[0]);
end;

function TFloatRec_Negative_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Negative: Boolean;

  if IsGet then
    Result := TFloatRec_sw(AObj).FValue.Negative
  else
    TFloatRec_sw(AObj).FValue.Negative := Boolean(AArgs[0]);
end;

function TFloatRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TFloatRec_sw.Create as IDispatch;
end;

function TFloatRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TFloatRec;

  // Implicit record copy method.
  Result := TFloatRec_sw.ToVar(TFloatRec(AObj));
end;

class function TFloatRec_sw.GetTypeName: WideString;
begin
  Result := 'TFloatRec';
end;

function TFloatRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TFloatRec_sw.Create;
  TFloatRec_sw(Result).FValue := FValue;
end;

class procedure TFloatRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Exponent', TFloatRec_Exponent_si, Smallint_sw);
  AData.AddField('Negative', TFloatRec_Negative_si, Boolean_sw);
  AData.AddFunction('Copy', TFloatRec_Copy_si, TFloatRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TFloatRec_Create_si, 0, False);
end;

class function TFloatRec_sw.ToVar(const AValue: TFloatRec): OleVariant;
var
  wrpr: TFloatRec_sw;
begin
  wrpr        := TFloatRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TFloatRec_sw.FromVar(const AValue: OleVariant): TFloatRec;
begin
  Result := TFloatRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TTimeStamp_sw }

function TTimeStamp_Time_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Time: Integer;

  if IsGet then
    Result := TTimeStamp_sw(AObj).FValue.Time
  else
    TTimeStamp_sw(AObj).FValue.Time := Integer(AArgs[0]);
end;

function TTimeStamp_Date_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Date: Integer;

  if IsGet then
    Result := TTimeStamp_sw(AObj).FValue.Date
  else
    TTimeStamp_sw(AObj).FValue.Date := Integer(AArgs[0]);
end;

function TTimeStamp_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TTimeStamp_sw.Create as IDispatch;
end;

function TTimeStamp_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TTimeStamp;

  // Implicit record copy method.
  Result := TTimeStamp_sw.ToVar(TTimeStamp(AObj));
end;

class function TTimeStamp_sw.GetTypeName: WideString;
begin
  Result := 'TTimeStamp';
end;

function TTimeStamp_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TTimeStamp_sw.Create;
  TTimeStamp_sw(Result).FValue := FValue;
end;

class procedure TTimeStamp_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Time', TTimeStamp_Time_si, Integer_sw);
  AData.AddField('Date', TTimeStamp_Date_si, Integer_sw);
  AData.AddFunction('Copy', TTimeStamp_Copy_si, TTimeStamp_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TTimeStamp_Create_si, 0, False);
end;

class function TTimeStamp_sw.ToVar(const AValue: TTimeStamp): OleVariant;
var
  wrpr: TTimeStamp_sw;
begin
  wrpr        := TTimeStamp_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TTimeStamp_sw.FromVar(const AValue: OleVariant): TTimeStamp;
begin
  Result := TTimeStamp_sw(ConvFromVar(AValue)).FValue;
end;

{ TMbcsByteType_sw }

class function TMbcsByteType_sw.GetTypeName: WideString;
begin
  Result := 'TMbcsByteType';
end;

class procedure TMbcsByteType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'mbSingleByte'; Value: Integer({$IFDEF LMDSCT_12}TMbcsByteType.{$ENDIF}mbSingleByte)),
    (Name: 'mbLeadByte'; Value: Integer({$IFDEF LMDSCT_12}TMbcsByteType.{$ENDIF}mbLeadByte)),
    (Name: 'mbTrailByte'; Value: Integer({$IFDEF LMDSCT_12}TMbcsByteType.{$ENDIF}mbTrailByte))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TMbcsByteType_sw.ToVar(const AValue: TMbcsByteType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMbcsByteType_sw.FromVar(
  const AValue: OleVariant): TMbcsByteType;
begin
  Result := TMbcsByteType(Integer(AValue));
end;

{ TSysLocale_sw }

function TSysLocale_DefaultLCID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultLCID: Integer;

  if IsGet then
    Result := TSysLocale_sw(AObj).FValue.DefaultLCID
  else
    TSysLocale_sw(AObj).FValue.DefaultLCID := Integer(AArgs[0]);
end;

function TSysLocale_PriLangID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var PriLangID: Integer;

  if IsGet then
    Result := TSysLocale_sw(AObj).FValue.PriLangID
  else
    TSysLocale_sw(AObj).FValue.PriLangID := Integer(AArgs[0]);
end;

function TSysLocale_SubLangID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SubLangID: Integer;

  if IsGet then
    Result := TSysLocale_sw(AObj).FValue.SubLangID
  else
    TSysLocale_sw(AObj).FValue.SubLangID := Integer(AArgs[0]);
end;

function TSysLocale_FarEast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FarEast: Boolean;

  if IsGet then
    Result := TSysLocale_sw(AObj).FValue.FarEast
  else
    TSysLocale_sw(AObj).FValue.FarEast := Boolean(AArgs[0]);
end;

function TSysLocale_MiddleEast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MiddleEast: Boolean;

  if IsGet then
    Result := TSysLocale_sw(AObj).FValue.MiddleEast
  else
    TSysLocale_sw(AObj).FValue.MiddleEast := Boolean(AArgs[0]);
end;

function TSysLocale_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TSysLocale_sw.Create as IDispatch;
end;

function TSysLocale_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TSysLocale;

  // Implicit record copy method.
  Result := TSysLocale_sw.ToVar(TSysLocale(AObj));
end;

class function TSysLocale_sw.GetTypeName: WideString;
begin
  Result := 'TSysLocale';
end;

function TSysLocale_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TSysLocale_sw.Create;
  TSysLocale_sw(Result).FValue := FValue;
end;

class procedure TSysLocale_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('DefaultLCID', TSysLocale_DefaultLCID_si, Integer_sw);
  AData.AddField('PriLangID', TSysLocale_PriLangID_si, Integer_sw);
  AData.AddField('SubLangID', TSysLocale_SubLangID_si, Integer_sw);
  AData.AddField('FarEast', TSysLocale_FarEast_si, Boolean_sw);
  AData.AddField('MiddleEast', TSysLocale_MiddleEast_si, Boolean_sw);
  AData.AddFunction('Copy', TSysLocale_Copy_si, TSysLocale_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TSysLocale_Create_si, 0, False);
end;

class function TSysLocale_sw.ToVar(const AValue: TSysLocale): OleVariant;
var
  wrpr: TSysLocale_sw;
begin
  wrpr        := TSysLocale_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TSysLocale_sw.FromVar(const AValue: OleVariant): TSysLocale;
begin
  Result := TSysLocale_sw(ConvFromVar(AValue)).FValue;
end;

{ TLangRec_sw }

function TLangRec_FName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FName: string;

  if IsGet then
    Result := TLangRec_sw(AObj).FValue.FName
  else
    TLangRec_sw(AObj).FValue.FName := string(AArgs[0]);
end;

function TLangRec_FLCID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FLCID: LCID;

  if IsGet then
    Result := LCID_sw.ToVar(TLangRec_sw(AObj).FValue.FLCID)
  else
    TLangRec_sw(AObj).FValue.FLCID := LCID_sw.FromVar(AArgs[0]);
end;

function TLangRec_FExt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FExt: string;

  if IsGet then
    Result := TLangRec_sw(AObj).FValue.FExt
  else
    TLangRec_sw(AObj).FValue.FExt := string(AArgs[0]);
end;

function TLangRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TLangRec_sw.Create as IDispatch;
end;

function TLangRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TLangRec;

  // Implicit record copy method.
  Result := TLangRec_sw.ToVar(TLangRec(AObj));
end;

class function TLangRec_sw.GetTypeName: WideString;
begin
  Result := 'TLangRec';
end;

function TLangRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TLangRec_sw.Create;
  TLangRec_sw(Result).FValue := FValue;
end;

class procedure TLangRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('FName', TLangRec_FName_si, string_sw);
  AData.AddField('FLCID', TLangRec_FLCID_si, LCID_sw);
  AData.AddField('FExt', TLangRec_FExt_si, string_sw);
  AData.AddFunction('Copy', TLangRec_Copy_si, TLangRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TLangRec_Create_si, 0, False);
end;

class function TLangRec_sw.ToVar(const AValue: TLangRec): OleVariant;
var
  wrpr: TLangRec_sw;
begin
  wrpr        := TLangRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TLangRec_sw.FromVar(const AValue: OleVariant): TLangRec;
begin
  Result := TLangRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TLanguages_sw }

function TLanguages_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TLanguages_sw.ToVar(TLanguages_sc(AObj).Create());
end;

function TLanguages_IndexOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOf(ID: LCID): Integer;

  Result := TLanguages(AObj).IndexOf(LCID_sw.FromVar(AArgs[0]));
end;

function TLanguages_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TLanguages(AObj).Count;
end;

function TLanguages_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Name[Index: Integer]: string read <getter>;

  Result := TLanguages(AObj).Name[Integer(AArgs[0])];
end;

function TLanguages_NameFromLocaleID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NameFromLocaleID[ID: LCID]: string read <getter>;

  Result := TLanguages(AObj).NameFromLocaleID[LCID_sw.FromVar(AArgs[0])];
end;

function TLanguages_NameFromLCID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NameFromLCID[const ID: string]: string read <get...

  Result := TLanguages(AObj).NameFromLCID[string(AArgs[0])];
end;

function TLanguages_ID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ID[Index: Integer]: string read <getter>;

  Result := TLanguages(AObj).ID[Integer(AArgs[0])];
end;

function TLanguages_LocaleID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LocaleID[Index: Integer]: LCID read <getter>;

  Result := LCID_sw.ToVar(TLanguages(AObj).LocaleID[Integer(AArgs[0])]);
end;

function TLanguages_Ext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Ext[Index: Integer]: string read <getter>;

  Result := TLanguages(AObj).Ext[Integer(AArgs[0])];
end;

class function TLanguages_sw.GetTypeName: WideString;
begin
  Result := 'TLanguages';
end;

class function TLanguages_sw.GetWrappedClass: TClass;
begin
  Result := TLanguages;
end;

class procedure TLanguages_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('IndexOf', TLanguages_IndexOf_si, Integer_sw, 1, False);
  AData.AddProperty('Count', TLanguages_Count_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Name', TLanguages_Name_si, string_sw, True, False, 1, False, False);
  AData.AddProperty('NameFromLocaleID', TLanguages_NameFromLocaleID_si, string_sw, True, False, 1, False, False);
  AData.AddProperty('NameFromLCID', TLanguages_NameFromLCID_si, string_sw, True, False, 1, False, False);
  AData.AddProperty('ID', TLanguages_ID_si, string_sw, True, False, 1, False, False);
  AData.AddProperty('LocaleID', TLanguages_LocaleID_si, LCID_sw, True, False, 1, False, False);
  AData.AddProperty('Ext', TLanguages_Ext_si, string_sw, True, False, 1, False, False);

  { Class members }

  AData.AddConstructor('Create', TLanguages_Create_si, 0, False);
end;

class function TLanguages_sw.ToVar(const AValue: TLanguages): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TLanguages_sw.FromVar(const AValue: OleVariant): TLanguages;
begin
  Result := TLanguages(ConvFromVar(AValue, TLanguages));
end;

class function TLanguages_sw.ClassToVar(AClass: TLanguages_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TLanguages_sw.ClassFromVar(
  const AClass: OleVariant): TLanguages_sc;
begin
  Result := TLanguages_sc(ConvClsFromVar(AClass, TLanguages));
end;

{ Exception_sw }

function Exception_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(const Msg: string);

  Result := Exception_sw.ToVar(Exception_sc(AObj).Create(string(AArgs[0])));
end;

function Exception_CreateRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function CreateRes(...); overload;

  Result := Exception_sw.ToVar(Exception_sc(AObj).CreateRes(Integer(AArgs[0])));
end;

function Exception_CreateHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor CreateHelp(const Msg: string; AHelpContext: I...

  Result := Exception_sw.ToVar(Exception_sc(AObj).CreateHelp(string(AArgs[0]), 
    Integer(AArgs[1])));
end;

function Exception_CreateResHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function CreateResHelp(...); overload;

  Result := Exception_sw.ToVar(Exception_sc(AObj).CreateResHelp(Integer(
    AArgs[0]), Integer(AArgs[1])));
end;

function Exception_HelpContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpContext: Integer read <getter> write <setter>;

  if IsGet then
    Result := Exception(AObj).HelpContext
  else
    Exception(AObj).HelpContext := Integer(AArgs[0]);
end;

function Exception_Message_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Message: string read <getter> write <setter>;

  if IsGet then
    Result := Exception(AObj).Message
  else
    Exception(AObj).Message := string(AArgs[0]);
end;

class function Exception_sw.GetTypeName: WideString;
begin
  Result := 'Exception';
end;

class function Exception_sw.GetWrappedClass: TClass;
begin
  Result := Exception;
end;

class procedure Exception_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('HelpContext', Exception_HelpContext_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Message', Exception_Message_si, string_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', Exception_Create_si, 1, False);
  AData.AddConstructor('CreateRes', Exception_CreateRes_si, 1, False);
  AData.AddConstructor('CreateHelp', Exception_CreateHelp_si, 2, False);
  AData.AddConstructor('CreateResHelp', Exception_CreateResHelp_si, 2, False);
end;

class function Exception_sw.ToVar(const AValue: Exception): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function Exception_sw.FromVar(const AValue: OleVariant): Exception;
begin
  Result := Exception(ConvFromVar(AValue, Exception));
end;

class function Exception_sw.ClassToVar(AClass: Exception_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function Exception_sw.ClassFromVar(
  const AClass: OleVariant): Exception_sc;
begin
  Result := Exception_sc(ConvClsFromVar(AClass, Exception));
end;

{ ExceptClass_sw }

class function ExceptClass_sw.GetTypeName: WideString;
begin
  Result := 'ExceptClass';
end;

class function ExceptClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := Exception;
end;

class function ExceptClass_sw.ToVar(const AValue: ExceptClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function ExceptClass_sw.FromVar(const AValue: OleVariant): ExceptClass;
begin
  Result := ExceptClass(ConvFromVar(AValue, Exception));
end;

{ EAbort_sw }

class function EAbort_sw.GetTypeName: WideString;
begin
  Result := 'EAbort';
end;

class function EAbort_sw.GetWrappedClass: TClass;
begin
  Result := EAbort;
end;

class procedure EAbort_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EAbort_sw.ToVar(const AValue: EAbort): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EAbort_sw.FromVar(const AValue: OleVariant): EAbort;
begin
  Result := EAbort(ConvFromVar(AValue, EAbort));
end;

class function EAbort_sw.ClassToVar(AClass: EAbort_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EAbort_sw.ClassFromVar(const AClass: OleVariant): EAbort_sc;
begin
  Result := EAbort_sc(ConvClsFromVar(AClass, EAbort));
end;

{ EHeapException_sw }

class function EHeapException_sw.GetTypeName: WideString;
begin
  Result := 'EHeapException';
end;

class function EHeapException_sw.GetWrappedClass: TClass;
begin
  Result := EHeapException;
end;

class procedure EHeapException_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EHeapException_sw.ToVar(
  const AValue: EHeapException): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EHeapException_sw.FromVar(
  const AValue: OleVariant): EHeapException;
begin
  Result := EHeapException(ConvFromVar(AValue, EHeapException));
end;

class function EHeapException_sw.ClassToVar(
  AClass: EHeapException_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EHeapException_sw.ClassFromVar(
  const AClass: OleVariant): EHeapException_sc;
begin
  Result := EHeapException_sc(ConvClsFromVar(AClass, EHeapException));
end;

{ EOutOfMemory_sw }

class function EOutOfMemory_sw.GetTypeName: WideString;
begin
  Result := 'EOutOfMemory';
end;

class function EOutOfMemory_sw.GetWrappedClass: TClass;
begin
  Result := EOutOfMemory;
end;

class procedure EOutOfMemory_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EOutOfMemory_sw.ToVar(const AValue: EOutOfMemory): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EOutOfMemory_sw.FromVar(const AValue: OleVariant): EOutOfMemory;
begin
  Result := EOutOfMemory(ConvFromVar(AValue, EOutOfMemory));
end;

class function EOutOfMemory_sw.ClassToVar(AClass: EOutOfMemory_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EOutOfMemory_sw.ClassFromVar(
  const AClass: OleVariant): EOutOfMemory_sc;
begin
  Result := EOutOfMemory_sc(ConvClsFromVar(AClass, EOutOfMemory));
end;

{ EInOutError_sw }

function EInOutError_ErrorCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ErrorCode: Integer;

  if IsGet then
    Result := EInOutError(AObj).ErrorCode
  else
    EInOutError(AObj).ErrorCode := Integer(AArgs[0]);
end;

class function EInOutError_sw.GetTypeName: WideString;
begin
  Result := 'EInOutError';
end;

class function EInOutError_sw.GetWrappedClass: TClass;
begin
  Result := EInOutError;
end;

class procedure EInOutError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddField('ErrorCode', EInOutError_ErrorCode_si, Integer_sw);
end;

class function EInOutError_sw.ToVar(const AValue: EInOutError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EInOutError_sw.FromVar(const AValue: OleVariant): EInOutError;
begin
  Result := EInOutError(ConvFromVar(AValue, EInOutError));
end;

class function EInOutError_sw.ClassToVar(AClass: EInOutError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EInOutError_sw.ClassFromVar(
  const AClass: OleVariant): EInOutError_sc;
begin
  Result := EInOutError_sc(ConvClsFromVar(AClass, EInOutError));
end;

{ TExceptionRecord_sw }

function TExceptionRecord_ExceptionCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ExceptionCode: Cardinal;

  if IsGet then
    Result := TExceptionRecord_sw(AObj).FValue.ExceptionCode
  else
    TExceptionRecord_sw(AObj).FValue.ExceptionCode := Cardinal(AArgs[0]);
end;

function TExceptionRecord_ExceptionFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ExceptionFlags: Cardinal;

  if IsGet then
    Result := TExceptionRecord_sw(AObj).FValue.ExceptionFlags
  else
    TExceptionRecord_sw(AObj).FValue.ExceptionFlags := Cardinal(AArgs[0]);
end;

function TExceptionRecord_NumberParameters_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var NumberParameters: Cardinal;

  if IsGet then
    Result := TExceptionRecord_sw(AObj).FValue.NumberParameters
  else
    TExceptionRecord_sw(AObj).FValue.NumberParameters := Cardinal(AArgs[0]);
end;

function TExceptionRecord_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TExceptionRecord_sw.Create as IDispatch;
end;

function TExceptionRecord_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TExceptionRecord;

  // Implicit record copy method.
  Result := TExceptionRecord_sw.ToVar(TExceptionRecord(AObj));
end;

class function TExceptionRecord_sw.GetTypeName: WideString;
begin
  Result := 'TExceptionRecord';
end;

function TExceptionRecord_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TExceptionRecord_sw.Create;
  TExceptionRecord_sw(Result).FValue := FValue;
end;

class procedure TExceptionRecord_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ExceptionCode', TExceptionRecord_ExceptionCode_si, Cardinal_sw);
  AData.AddField('ExceptionFlags', TExceptionRecord_ExceptionFlags_si, Cardinal_sw);
  AData.AddField('NumberParameters', TExceptionRecord_NumberParameters_si, Cardinal_sw);
  AData.AddFunction('Copy', TExceptionRecord_Copy_si, TExceptionRecord_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TExceptionRecord_Create_si, 0, False);
end;

class function TExceptionRecord_sw.ToVar(
  const AValue: TExceptionRecord): OleVariant;
var
  wrpr: TExceptionRecord_sw;
begin
  wrpr        := TExceptionRecord_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TExceptionRecord_sw.FromVar(
  const AValue: OleVariant): TExceptionRecord;
begin
  Result := TExceptionRecord_sw(ConvFromVar(AValue)).FValue;
end;

{ EExternal_sw }

class function EExternal_sw.GetTypeName: WideString;
begin
  Result := 'EExternal';
end;

class function EExternal_sw.GetWrappedClass: TClass;
begin
  Result := EExternal;
end;

class procedure EExternal_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EExternal_sw.ToVar(const AValue: EExternal): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EExternal_sw.FromVar(const AValue: OleVariant): EExternal;
begin
  Result := EExternal(ConvFromVar(AValue, EExternal));
end;

class function EExternal_sw.ClassToVar(AClass: EExternal_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EExternal_sw.ClassFromVar(
  const AClass: OleVariant): EExternal_sc;
begin
  Result := EExternal_sc(ConvClsFromVar(AClass, EExternal));
end;

{ EExternalException_sw }

class function EExternalException_sw.GetTypeName: WideString;
begin
  Result := 'EExternalException';
end;

class function EExternalException_sw.GetWrappedClass: TClass;
begin
  Result := EExternalException;
end;

class procedure EExternalException_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EExternalException_sw.ToVar(
  const AValue: EExternalException): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EExternalException_sw.FromVar(
  const AValue: OleVariant): EExternalException;
begin
  Result := EExternalException(ConvFromVar(AValue, EExternalException));
end;

class function EExternalException_sw.ClassToVar(
  AClass: EExternalException_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EExternalException_sw.ClassFromVar(
  const AClass: OleVariant): EExternalException_sc;
begin
  Result := EExternalException_sc(ConvClsFromVar(AClass, EExternalException));
end;

{ EIntError_sw }

class function EIntError_sw.GetTypeName: WideString;
begin
  Result := 'EIntError';
end;

class function EIntError_sw.GetWrappedClass: TClass;
begin
  Result := EIntError;
end;

class procedure EIntError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EIntError_sw.ToVar(const AValue: EIntError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EIntError_sw.FromVar(const AValue: OleVariant): EIntError;
begin
  Result := EIntError(ConvFromVar(AValue, EIntError));
end;

class function EIntError_sw.ClassToVar(AClass: EIntError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EIntError_sw.ClassFromVar(
  const AClass: OleVariant): EIntError_sc;
begin
  Result := EIntError_sc(ConvClsFromVar(AClass, EIntError));
end;

{ EDivByZero_sw }

class function EDivByZero_sw.GetTypeName: WideString;
begin
  Result := 'EDivByZero';
end;

class function EDivByZero_sw.GetWrappedClass: TClass;
begin
  Result := EDivByZero;
end;

class procedure EDivByZero_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EDivByZero_sw.ToVar(const AValue: EDivByZero): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EDivByZero_sw.FromVar(const AValue: OleVariant): EDivByZero;
begin
  Result := EDivByZero(ConvFromVar(AValue, EDivByZero));
end;

class function EDivByZero_sw.ClassToVar(AClass: EDivByZero_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EDivByZero_sw.ClassFromVar(
  const AClass: OleVariant): EDivByZero_sc;
begin
  Result := EDivByZero_sc(ConvClsFromVar(AClass, EDivByZero));
end;

{ ERangeError_sw }

class function ERangeError_sw.GetTypeName: WideString;
begin
  Result := 'ERangeError';
end;

class function ERangeError_sw.GetWrappedClass: TClass;
begin
  Result := ERangeError;
end;

class procedure ERangeError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function ERangeError_sw.ToVar(const AValue: ERangeError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function ERangeError_sw.FromVar(const AValue: OleVariant): ERangeError;
begin
  Result := ERangeError(ConvFromVar(AValue, ERangeError));
end;

class function ERangeError_sw.ClassToVar(AClass: ERangeError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function ERangeError_sw.ClassFromVar(
  const AClass: OleVariant): ERangeError_sc;
begin
  Result := ERangeError_sc(ConvClsFromVar(AClass, ERangeError));
end;

{ EIntOverflow_sw }

class function EIntOverflow_sw.GetTypeName: WideString;
begin
  Result := 'EIntOverflow';
end;

class function EIntOverflow_sw.GetWrappedClass: TClass;
begin
  Result := EIntOverflow;
end;

class procedure EIntOverflow_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EIntOverflow_sw.ToVar(const AValue: EIntOverflow): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EIntOverflow_sw.FromVar(const AValue: OleVariant): EIntOverflow;
begin
  Result := EIntOverflow(ConvFromVar(AValue, EIntOverflow));
end;

class function EIntOverflow_sw.ClassToVar(AClass: EIntOverflow_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EIntOverflow_sw.ClassFromVar(
  const AClass: OleVariant): EIntOverflow_sc;
begin
  Result := EIntOverflow_sc(ConvClsFromVar(AClass, EIntOverflow));
end;

{ EMathError_sw }

class function EMathError_sw.GetTypeName: WideString;
begin
  Result := 'EMathError';
end;

class function EMathError_sw.GetWrappedClass: TClass;
begin
  Result := EMathError;
end;

class procedure EMathError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EMathError_sw.ToVar(const AValue: EMathError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EMathError_sw.FromVar(const AValue: OleVariant): EMathError;
begin
  Result := EMathError(ConvFromVar(AValue, EMathError));
end;

class function EMathError_sw.ClassToVar(AClass: EMathError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EMathError_sw.ClassFromVar(
  const AClass: OleVariant): EMathError_sc;
begin
  Result := EMathError_sc(ConvClsFromVar(AClass, EMathError));
end;

{ EInvalidOp_sw }

class function EInvalidOp_sw.GetTypeName: WideString;
begin
  Result := 'EInvalidOp';
end;

class function EInvalidOp_sw.GetWrappedClass: TClass;
begin
  Result := EInvalidOp;
end;

class procedure EInvalidOp_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EInvalidOp_sw.ToVar(const AValue: EInvalidOp): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EInvalidOp_sw.FromVar(const AValue: OleVariant): EInvalidOp;
begin
  Result := EInvalidOp(ConvFromVar(AValue, EInvalidOp));
end;

class function EInvalidOp_sw.ClassToVar(AClass: EInvalidOp_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EInvalidOp_sw.ClassFromVar(
  const AClass: OleVariant): EInvalidOp_sc;
begin
  Result := EInvalidOp_sc(ConvClsFromVar(AClass, EInvalidOp));
end;

{ EZeroDivide_sw }

class function EZeroDivide_sw.GetTypeName: WideString;
begin
  Result := 'EZeroDivide';
end;

class function EZeroDivide_sw.GetWrappedClass: TClass;
begin
  Result := EZeroDivide;
end;

class procedure EZeroDivide_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EZeroDivide_sw.ToVar(const AValue: EZeroDivide): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EZeroDivide_sw.FromVar(const AValue: OleVariant): EZeroDivide;
begin
  Result := EZeroDivide(ConvFromVar(AValue, EZeroDivide));
end;

class function EZeroDivide_sw.ClassToVar(AClass: EZeroDivide_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EZeroDivide_sw.ClassFromVar(
  const AClass: OleVariant): EZeroDivide_sc;
begin
  Result := EZeroDivide_sc(ConvClsFromVar(AClass, EZeroDivide));
end;

{ EOverflow_sw }

class function EOverflow_sw.GetTypeName: WideString;
begin
  Result := 'EOverflow';
end;

class function EOverflow_sw.GetWrappedClass: TClass;
begin
  Result := EOverflow;
end;

class procedure EOverflow_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EOverflow_sw.ToVar(const AValue: EOverflow): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EOverflow_sw.FromVar(const AValue: OleVariant): EOverflow;
begin
  Result := EOverflow(ConvFromVar(AValue, EOverflow));
end;

class function EOverflow_sw.ClassToVar(AClass: EOverflow_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EOverflow_sw.ClassFromVar(
  const AClass: OleVariant): EOverflow_sc;
begin
  Result := EOverflow_sc(ConvClsFromVar(AClass, EOverflow));
end;

{ EUnderflow_sw }

class function EUnderflow_sw.GetTypeName: WideString;
begin
  Result := 'EUnderflow';
end;

class function EUnderflow_sw.GetWrappedClass: TClass;
begin
  Result := EUnderflow;
end;

class procedure EUnderflow_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EUnderflow_sw.ToVar(const AValue: EUnderflow): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EUnderflow_sw.FromVar(const AValue: OleVariant): EUnderflow;
begin
  Result := EUnderflow(ConvFromVar(AValue, EUnderflow));
end;

class function EUnderflow_sw.ClassToVar(AClass: EUnderflow_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EUnderflow_sw.ClassFromVar(
  const AClass: OleVariant): EUnderflow_sc;
begin
  Result := EUnderflow_sc(ConvClsFromVar(AClass, EUnderflow));
end;

{ EInvalidPointer_sw }

class function EInvalidPointer_sw.GetTypeName: WideString;
begin
  Result := 'EInvalidPointer';
end;

class function EInvalidPointer_sw.GetWrappedClass: TClass;
begin
  Result := EInvalidPointer;
end;

class procedure EInvalidPointer_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EInvalidPointer_sw.ToVar(
  const AValue: EInvalidPointer): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EInvalidPointer_sw.FromVar(
  const AValue: OleVariant): EInvalidPointer;
begin
  Result := EInvalidPointer(ConvFromVar(AValue, EInvalidPointer));
end;

class function EInvalidPointer_sw.ClassToVar(
  AClass: EInvalidPointer_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EInvalidPointer_sw.ClassFromVar(
  const AClass: OleVariant): EInvalidPointer_sc;
begin
  Result := EInvalidPointer_sc(ConvClsFromVar(AClass, EInvalidPointer));
end;

{ EInvalidCast_sw }

class function EInvalidCast_sw.GetTypeName: WideString;
begin
  Result := 'EInvalidCast';
end;

class function EInvalidCast_sw.GetWrappedClass: TClass;
begin
  Result := EInvalidCast;
end;

class procedure EInvalidCast_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EInvalidCast_sw.ToVar(const AValue: EInvalidCast): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EInvalidCast_sw.FromVar(const AValue: OleVariant): EInvalidCast;
begin
  Result := EInvalidCast(ConvFromVar(AValue, EInvalidCast));
end;

class function EInvalidCast_sw.ClassToVar(AClass: EInvalidCast_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EInvalidCast_sw.ClassFromVar(
  const AClass: OleVariant): EInvalidCast_sc;
begin
  Result := EInvalidCast_sc(ConvClsFromVar(AClass, EInvalidCast));
end;

{ EConvertError_sw }

class function EConvertError_sw.GetTypeName: WideString;
begin
  Result := 'EConvertError';
end;

class function EConvertError_sw.GetWrappedClass: TClass;
begin
  Result := EConvertError;
end;

class procedure EConvertError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EConvertError_sw.ToVar(const AValue: EConvertError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EConvertError_sw.FromVar(
  const AValue: OleVariant): EConvertError;
begin
  Result := EConvertError(ConvFromVar(AValue, EConvertError));
end;

class function EConvertError_sw.ClassToVar(
  AClass: EConvertError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EConvertError_sw.ClassFromVar(
  const AClass: OleVariant): EConvertError_sc;
begin
  Result := EConvertError_sc(ConvClsFromVar(AClass, EConvertError));
end;

{ EAccessViolation_sw }

class function EAccessViolation_sw.GetTypeName: WideString;
begin
  Result := 'EAccessViolation';
end;

class function EAccessViolation_sw.GetWrappedClass: TClass;
begin
  Result := EAccessViolation;
end;

class procedure EAccessViolation_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EAccessViolation_sw.ToVar(
  const AValue: EAccessViolation): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EAccessViolation_sw.FromVar(
  const AValue: OleVariant): EAccessViolation;
begin
  Result := EAccessViolation(ConvFromVar(AValue, EAccessViolation));
end;

class function EAccessViolation_sw.ClassToVar(
  AClass: EAccessViolation_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EAccessViolation_sw.ClassFromVar(
  const AClass: OleVariant): EAccessViolation_sc;
begin
  Result := EAccessViolation_sc(ConvClsFromVar(AClass, EAccessViolation));
end;

{ EPrivilege_sw }

class function EPrivilege_sw.GetTypeName: WideString;
begin
  Result := 'EPrivilege';
end;

class function EPrivilege_sw.GetWrappedClass: TClass;
begin
  Result := EPrivilege;
end;

class procedure EPrivilege_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EPrivilege_sw.ToVar(const AValue: EPrivilege): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EPrivilege_sw.FromVar(const AValue: OleVariant): EPrivilege;
begin
  Result := EPrivilege(ConvFromVar(AValue, EPrivilege));
end;

class function EPrivilege_sw.ClassToVar(AClass: EPrivilege_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EPrivilege_sw.ClassFromVar(
  const AClass: OleVariant): EPrivilege_sc;
begin
  Result := EPrivilege_sc(ConvClsFromVar(AClass, EPrivilege));
end;

{ EStackOverflow_sw }

class function EStackOverflow_sw.GetTypeName: WideString;
begin
  Result := 'EStackOverflow';
end;

class function EStackOverflow_sw.GetWrappedClass: TClass;
begin
  Result := EStackOverflow;
end;

class procedure EStackOverflow_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EStackOverflow_sw.ToVar(
  const AValue: EStackOverflow): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EStackOverflow_sw.FromVar(
  const AValue: OleVariant): EStackOverflow;
begin
  Result := EStackOverflow(ConvFromVar(AValue, EStackOverflow));
end;

class function EStackOverflow_sw.ClassToVar(
  AClass: EStackOverflow_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EStackOverflow_sw.ClassFromVar(
  const AClass: OleVariant): EStackOverflow_sc;
begin
  Result := EStackOverflow_sc(ConvClsFromVar(AClass, EStackOverflow));
end;

{ EControlC_sw }

class function EControlC_sw.GetTypeName: WideString;
begin
  Result := 'EControlC';
end;

class function EControlC_sw.GetWrappedClass: TClass;
begin
  Result := EControlC;
end;

class procedure EControlC_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EControlC_sw.ToVar(const AValue: EControlC): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EControlC_sw.FromVar(const AValue: OleVariant): EControlC;
begin
  Result := EControlC(ConvFromVar(AValue, EControlC));
end;

class function EControlC_sw.ClassToVar(AClass: EControlC_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EControlC_sw.ClassFromVar(
  const AClass: OleVariant): EControlC_sc;
begin
  Result := EControlC_sc(ConvClsFromVar(AClass, EControlC));
end;

{ EVariantError_sw }

class function EVariantError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantError';
end;

class function EVariantError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantError;
end;

class procedure EVariantError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantError_sw.ToVar(const AValue: EVariantError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantError_sw.FromVar(
  const AValue: OleVariant): EVariantError;
begin
  Result := EVariantError(ConvFromVar(AValue, EVariantError));
end;

class function EVariantError_sw.ClassToVar(
  AClass: EVariantError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantError_sc;
begin
  Result := EVariantError_sc(ConvClsFromVar(AClass, EVariantError));
end;

{ EPropReadOnly_sw }

class function EPropReadOnly_sw.GetTypeName: WideString;
begin
  Result := 'EPropReadOnly';
end;

class function EPropReadOnly_sw.GetWrappedClass: TClass;
begin
  Result := EPropReadOnly;
end;

class procedure EPropReadOnly_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EPropReadOnly_sw.ToVar(const AValue: EPropReadOnly): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EPropReadOnly_sw.FromVar(
  const AValue: OleVariant): EPropReadOnly;
begin
  Result := EPropReadOnly(ConvFromVar(AValue, EPropReadOnly));
end;

class function EPropReadOnly_sw.ClassToVar(
  AClass: EPropReadOnly_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EPropReadOnly_sw.ClassFromVar(
  const AClass: OleVariant): EPropReadOnly_sc;
begin
  Result := EPropReadOnly_sc(ConvClsFromVar(AClass, EPropReadOnly));
end;

{ EPropWriteOnly_sw }

class function EPropWriteOnly_sw.GetTypeName: WideString;
begin
  Result := 'EPropWriteOnly';
end;

class function EPropWriteOnly_sw.GetWrappedClass: TClass;
begin
  Result := EPropWriteOnly;
end;

class procedure EPropWriteOnly_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EPropWriteOnly_sw.ToVar(
  const AValue: EPropWriteOnly): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EPropWriteOnly_sw.FromVar(
  const AValue: OleVariant): EPropWriteOnly;
begin
  Result := EPropWriteOnly(ConvFromVar(AValue, EPropWriteOnly));
end;

class function EPropWriteOnly_sw.ClassToVar(
  AClass: EPropWriteOnly_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EPropWriteOnly_sw.ClassFromVar(
  const AClass: OleVariant): EPropWriteOnly_sc;
begin
  Result := EPropWriteOnly_sc(ConvClsFromVar(AClass, EPropWriteOnly));
end;

{ EAssertionFailed_sw }

class function EAssertionFailed_sw.GetTypeName: WideString;
begin
  Result := 'EAssertionFailed';
end;

class function EAssertionFailed_sw.GetWrappedClass: TClass;
begin
  Result := EAssertionFailed;
end;

class procedure EAssertionFailed_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EAssertionFailed_sw.ToVar(
  const AValue: EAssertionFailed): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EAssertionFailed_sw.FromVar(
  const AValue: OleVariant): EAssertionFailed;
begin
  Result := EAssertionFailed(ConvFromVar(AValue, EAssertionFailed));
end;

class function EAssertionFailed_sw.ClassToVar(
  AClass: EAssertionFailed_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EAssertionFailed_sw.ClassFromVar(
  const AClass: OleVariant): EAssertionFailed_sc;
begin
  Result := EAssertionFailed_sc(ConvClsFromVar(AClass, EAssertionFailed));
end;

{ EAbstractError_sw }

class function EAbstractError_sw.GetTypeName: WideString;
begin
  Result := 'EAbstractError';
end;

class function EAbstractError_sw.GetWrappedClass: TClass;
begin
  Result := EAbstractError;
end;

class procedure EAbstractError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EAbstractError_sw.ToVar(
  const AValue: EAbstractError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EAbstractError_sw.FromVar(
  const AValue: OleVariant): EAbstractError;
begin
  Result := EAbstractError(ConvFromVar(AValue, EAbstractError));
end;

class function EAbstractError_sw.ClassToVar(
  AClass: EAbstractError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EAbstractError_sw.ClassFromVar(
  const AClass: OleVariant): EAbstractError_sc;
begin
  Result := EAbstractError_sc(ConvClsFromVar(AClass, EAbstractError));
end;

{ EIntfCastError_sw }

class function EIntfCastError_sw.GetTypeName: WideString;
begin
  Result := 'EIntfCastError';
end;

class function EIntfCastError_sw.GetWrappedClass: TClass;
begin
  Result := EIntfCastError;
end;

class procedure EIntfCastError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EIntfCastError_sw.ToVar(
  const AValue: EIntfCastError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EIntfCastError_sw.FromVar(
  const AValue: OleVariant): EIntfCastError;
begin
  Result := EIntfCastError(ConvFromVar(AValue, EIntfCastError));
end;

class function EIntfCastError_sw.ClassToVar(
  AClass: EIntfCastError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EIntfCastError_sw.ClassFromVar(
  const AClass: OleVariant): EIntfCastError_sc;
begin
  Result := EIntfCastError_sc(ConvClsFromVar(AClass, EIntfCastError));
end;

{ EInvalidContainer_sw }

class function EInvalidContainer_sw.GetTypeName: WideString;
begin
  Result := 'EInvalidContainer';
end;

class function EInvalidContainer_sw.GetWrappedClass: TClass;
begin
  Result := EInvalidContainer;
end;

class procedure EInvalidContainer_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EInvalidContainer_sw.ToVar(
  const AValue: EInvalidContainer): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EInvalidContainer_sw.FromVar(
  const AValue: OleVariant): EInvalidContainer;
begin
  Result := EInvalidContainer(ConvFromVar(AValue, EInvalidContainer));
end;

class function EInvalidContainer_sw.ClassToVar(
  AClass: EInvalidContainer_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EInvalidContainer_sw.ClassFromVar(
  const AClass: OleVariant): EInvalidContainer_sc;
begin
  Result := EInvalidContainer_sc(ConvClsFromVar(AClass, EInvalidContainer));
end;

{ EInvalidInsert_sw }

class function EInvalidInsert_sw.GetTypeName: WideString;
begin
  Result := 'EInvalidInsert';
end;

class function EInvalidInsert_sw.GetWrappedClass: TClass;
begin
  Result := EInvalidInsert;
end;

class procedure EInvalidInsert_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EInvalidInsert_sw.ToVar(
  const AValue: EInvalidInsert): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EInvalidInsert_sw.FromVar(
  const AValue: OleVariant): EInvalidInsert;
begin
  Result := EInvalidInsert(ConvFromVar(AValue, EInvalidInsert));
end;

class function EInvalidInsert_sw.ClassToVar(
  AClass: EInvalidInsert_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EInvalidInsert_sw.ClassFromVar(
  const AClass: OleVariant): EInvalidInsert_sc;
begin
  Result := EInvalidInsert_sc(ConvClsFromVar(AClass, EInvalidInsert));
end;

{ EPackageError_sw }

class function EPackageError_sw.GetTypeName: WideString;
begin
  Result := 'EPackageError';
end;

class function EPackageError_sw.GetWrappedClass: TClass;
begin
  Result := EPackageError;
end;

class procedure EPackageError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EPackageError_sw.ToVar(const AValue: EPackageError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EPackageError_sw.FromVar(
  const AValue: OleVariant): EPackageError;
begin
  Result := EPackageError(ConvFromVar(AValue, EPackageError));
end;

class function EPackageError_sw.ClassToVar(
  AClass: EPackageError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EPackageError_sw.ClassFromVar(
  const AClass: OleVariant): EPackageError_sc;
begin
  Result := EPackageError_sc(ConvClsFromVar(AClass, EPackageError));
end;

{ EOSError_sw }

function EOSError_ErrorCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ErrorCode: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(EOSError(AObj).ErrorCode)
  else
    EOSError(AObj).ErrorCode := DWORD_sw.FromVar(AArgs[0]);
end;

class function EOSError_sw.GetTypeName: WideString;
begin
  Result := 'EOSError';
end;

class function EOSError_sw.GetWrappedClass: TClass;
begin
  Result := EOSError;
end;

class procedure EOSError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddField('ErrorCode', EOSError_ErrorCode_si, DWORD_sw);
end;

class function EOSError_sw.ToVar(const AValue: EOSError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EOSError_sw.FromVar(const AValue: OleVariant): EOSError;
begin
  Result := EOSError(ConvFromVar(AValue, EOSError));
end;

class function EOSError_sw.ClassToVar(AClass: EOSError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EOSError_sw.ClassFromVar(const AClass: OleVariant): EOSError_sc;
begin
  Result := EOSError_sc(ConvClsFromVar(AClass, EOSError));
end;

{ EWin32Error_sw }

class function EWin32Error_sw.GetTypeName: WideString;
begin
  Result := 'EWin32Error';
end;

class function EWin32Error_sw.GetWrappedClass: TClass;
begin
  Result := EWin32Error;
end;

class procedure EWin32Error_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EWin32Error_sw.ToVar(const AValue: EWin32Error): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EWin32Error_sw.FromVar(const AValue: OleVariant): EWin32Error;
begin
  Result := EWin32Error(ConvFromVar(AValue, EWin32Error));
end;

class function EWin32Error_sw.ClassToVar(AClass: EWin32Error_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EWin32Error_sw.ClassFromVar(
  const AClass: OleVariant): EWin32Error_sc;
begin
  Result := EWin32Error_sc(ConvClsFromVar(AClass, EWin32Error));
end;

{ ESafecallException_sw }

class function ESafecallException_sw.GetTypeName: WideString;
begin
  Result := 'ESafecallException';
end;

class function ESafecallException_sw.GetWrappedClass: TClass;
begin
  Result := ESafecallException;
end;

class procedure ESafecallException_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function ESafecallException_sw.ToVar(
  const AValue: ESafecallException): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function ESafecallException_sw.FromVar(
  const AValue: OleVariant): ESafecallException;
begin
  Result := ESafecallException(ConvFromVar(AValue, ESafecallException));
end;

class function ESafecallException_sw.ClassToVar(
  AClass: ESafecallException_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function ESafecallException_sw.ClassFromVar(
  const AClass: OleVariant): ESafecallException_sc;
begin
  Result := ESafecallException_sc(ConvClsFromVar(AClass, ESafecallException));
end;

{ TFormatSettings_sw }

function TFormatSettings_CurrencyFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CurrencyFormat: Byte;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.CurrencyFormat
  else
    TFormatSettings_sw(AObj).FValue.CurrencyFormat := Byte(AArgs[0]);
end;

function TFormatSettings_NegCurrFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var NegCurrFormat: Byte;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.NegCurrFormat
  else
    TFormatSettings_sw(AObj).FValue.NegCurrFormat := Byte(AArgs[0]);
end;

function TFormatSettings_ThousandSeparator_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ThousandSeparator: Char;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.ThousandSeparator
  else
    TFormatSettings_sw(AObj).FValue.ThousandSeparator := Char(Integer(
      AArgs[0]));
end;

function TFormatSettings_DecimalSeparator_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DecimalSeparator: Char;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.DecimalSeparator
  else
    TFormatSettings_sw(AObj).FValue.DecimalSeparator := Char(Integer(AArgs[0]));
end;

function TFormatSettings_CurrencyDecimals_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CurrencyDecimals: Byte;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.CurrencyDecimals
  else
    TFormatSettings_sw(AObj).FValue.CurrencyDecimals := Byte(AArgs[0]);
end;

function TFormatSettings_DateSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DateSeparator: Char;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.DateSeparator
  else
    TFormatSettings_sw(AObj).FValue.DateSeparator := Char(Integer(AArgs[0]));
end;

function TFormatSettings_TimeSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TimeSeparator: Char;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.TimeSeparator
  else
    TFormatSettings_sw(AObj).FValue.TimeSeparator := Char(Integer(AArgs[0]));
end;

function TFormatSettings_ListSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ListSeparator: Char;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.ListSeparator
  else
    TFormatSettings_sw(AObj).FValue.ListSeparator := Char(Integer(AArgs[0]));
end;

function TFormatSettings_CurrencyString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CurrencyString: string;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.CurrencyString
  else
    TFormatSettings_sw(AObj).FValue.CurrencyString := string(AArgs[0]);
end;

function TFormatSettings_ShortDateFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ShortDateFormat: string;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.ShortDateFormat
  else
    TFormatSettings_sw(AObj).FValue.ShortDateFormat := string(AArgs[0]);
end;

function TFormatSettings_LongDateFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LongDateFormat: string;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.LongDateFormat
  else
    TFormatSettings_sw(AObj).FValue.LongDateFormat := string(AArgs[0]);
end;

function TFormatSettings_TimeAMString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TimeAMString: string;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.TimeAMString
  else
    TFormatSettings_sw(AObj).FValue.TimeAMString := string(AArgs[0]);
end;

function TFormatSettings_TimePMString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TimePMString: string;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.TimePMString
  else
    TFormatSettings_sw(AObj).FValue.TimePMString := string(AArgs[0]);
end;

function TFormatSettings_ShortTimeFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ShortTimeFormat: string;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.ShortTimeFormat
  else
    TFormatSettings_sw(AObj).FValue.ShortTimeFormat := string(AArgs[0]);
end;

function TFormatSettings_LongTimeFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LongTimeFormat: string;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.LongTimeFormat
  else
    TFormatSettings_sw(AObj).FValue.LongTimeFormat := string(AArgs[0]);
end;

function TFormatSettings_TwoDigitYearCenturyWindow_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TwoDigitYearCenturyWindow: Word;

  if IsGet then
    Result := TFormatSettings_sw(AObj).FValue.TwoDigitYearCenturyWindow
  else
    TFormatSettings_sw(AObj).FValue.TwoDigitYearCenturyWindow := Word(AArgs[0]);
end;

function TFormatSettings_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TFormatSettings_sw.Create as IDispatch;
end;

function TFormatSettings_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TFormatSettings;

  // Implicit record copy method.
  Result := TFormatSettings_sw.ToVar(TFormatSettings(AObj));
end;

class function TFormatSettings_sw.GetTypeName: WideString;
begin
  Result := 'TFormatSettings';
end;

function TFormatSettings_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TFormatSettings_sw.Create;
  TFormatSettings_sw(Result).FValue := FValue;
end;

class procedure TFormatSettings_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('CurrencyFormat', TFormatSettings_CurrencyFormat_si, Byte_sw);
  AData.AddField('NegCurrFormat', TFormatSettings_NegCurrFormat_si, Byte_sw);
  AData.AddField('ThousandSeparator', TFormatSettings_ThousandSeparator_si, Char_sw);
  AData.AddField('DecimalSeparator', TFormatSettings_DecimalSeparator_si, Char_sw);
  AData.AddField('CurrencyDecimals', TFormatSettings_CurrencyDecimals_si, Byte_sw);
  AData.AddField('DateSeparator', TFormatSettings_DateSeparator_si, Char_sw);
  AData.AddField('TimeSeparator', TFormatSettings_TimeSeparator_si, Char_sw);
  AData.AddField('ListSeparator', TFormatSettings_ListSeparator_si, Char_sw);
  AData.AddField('CurrencyString', TFormatSettings_CurrencyString_si, string_sw);
  AData.AddField('ShortDateFormat', TFormatSettings_ShortDateFormat_si, string_sw);
  AData.AddField('LongDateFormat', TFormatSettings_LongDateFormat_si, string_sw);
  AData.AddField('TimeAMString', TFormatSettings_TimeAMString_si, string_sw);
  AData.AddField('TimePMString', TFormatSettings_TimePMString_si, string_sw);
  AData.AddField('ShortTimeFormat', TFormatSettings_ShortTimeFormat_si, string_sw);
  AData.AddField('LongTimeFormat', TFormatSettings_LongTimeFormat_si, string_sw);
  AData.AddField('TwoDigitYearCenturyWindow', TFormatSettings_TwoDigitYearCenturyWindow_si, Word_sw);
  AData.AddFunction('Copy', TFormatSettings_Copy_si, TFormatSettings_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TFormatSettings_Create_si, 0, False);
end;

class function TFormatSettings_sw.ToVar(
  const AValue: TFormatSettings): OleVariant;
var
  wrpr: TFormatSettings_sw;
begin
  wrpr        := TFormatSettings_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TFormatSettings_sw.FromVar(
  const AValue: OleVariant): TFormatSettings;
begin
  Result := TFormatSettings_sw(ConvFromVar(AValue)).FValue;
end;

{ TFilenameCaseMatch_sw }

class function TFilenameCaseMatch_sw.GetTypeName: WideString;
begin
  Result := 'TFilenameCaseMatch';
end;

class procedure TFilenameCaseMatch_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'mkNone'; Value: Integer({$IFDEF LMDSCT_12}TFilenameCaseMatch.{$ENDIF}mkNone)),
    (Name: 'mkExactMatch'; Value: Integer({$IFDEF LMDSCT_12}TFilenameCaseMatch.{$ENDIF}mkExactMatch)),
    (Name: 'mkSingleMatch'; Value: Integer({$IFDEF LMDSCT_12}TFilenameCaseMatch.{$ENDIF}mkSingleMatch)),
    (Name: 'mkAmbiguous'; Value: Integer({$IFDEF LMDSCT_12}TFilenameCaseMatch.{$ENDIF}mkAmbiguous))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TFilenameCaseMatch_sw.ToVar(
  const AValue: TFilenameCaseMatch): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFilenameCaseMatch_sw.FromVar(
  const AValue: OleVariant): TFilenameCaseMatch;
begin
  Result := TFilenameCaseMatch(Integer(AValue));
end;

{ TNameType_sw }

class function TNameType_sw.GetTypeName: WideString;
begin
  Result := 'TNameType';
end;

class procedure TNameType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'ntContainsUnit'; Value: Integer({$IFDEF LMDSCT_12}TNameType.{$ENDIF}ntContainsUnit)),
    (Name: 'ntRequiresPackage'; Value: Integer({$IFDEF LMDSCT_12}TNameType.{$ENDIF}ntRequiresPackage)),
    (Name: 'ntDcpBpiName'; Value: Integer({$IFDEF LMDSCT_12}TNameType.{$ENDIF}ntDcpBpiName))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TNameType_sw.ToVar(const AValue: TNameType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TNameType_sw.FromVar(const AValue: OleVariant): TNameType;
begin
  Result := TNameType(Integer(AValue));
end;

{ TSimpleRWSync_sw }

function TSimpleRWSync_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TSimpleRWSync_sw.ToVar(TSimpleRWSync_sc(AObj).Create());
end;

function TSimpleRWSync_BeginRead_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginRead;

  TSimpleRWSync(AObj).BeginRead();
end;

function TSimpleRWSync_EndRead_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndRead;

  TSimpleRWSync(AObj).EndRead();
end;

function TSimpleRWSync_BeginWrite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function BeginWrite: Boolean;

  Result := TSimpleRWSync(AObj).BeginWrite();
end;

function TSimpleRWSync_EndWrite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndWrite;

  TSimpleRWSync(AObj).EndWrite();
end;

class function TSimpleRWSync_sw.GetTypeName: WideString;
begin
  Result := 'TSimpleRWSync';
end;

class function TSimpleRWSync_sw.GetWrappedClass: TClass;
begin
  Result := TSimpleRWSync;
end;

class procedure TSimpleRWSync_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('BeginRead', TSimpleRWSync_BeginRead_si, 0, False);
  AData.AddProcedure('EndRead', TSimpleRWSync_EndRead_si, 0, False);
  AData.AddFunction('BeginWrite', TSimpleRWSync_BeginWrite_si, Boolean_sw, 0, False);
  AData.AddProcedure('EndWrite', TSimpleRWSync_EndWrite_si, 0, False);

  { Class members }

  AData.AddConstructor('Create', TSimpleRWSync_Create_si, 0, False);
end;

class function TSimpleRWSync_sw.ToVar(const AValue: TSimpleRWSync): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSimpleRWSync_sw.FromVar(
  const AValue: OleVariant): TSimpleRWSync;
begin
  Result := TSimpleRWSync(ConvFromVar(AValue, TSimpleRWSync));
end;

class function TSimpleRWSync_sw.ClassToVar(
  AClass: TSimpleRWSync_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSimpleRWSync_sw.ClassFromVar(
  const AClass: OleVariant): TSimpleRWSync_sc;
begin
  Result := TSimpleRWSync_sc(ConvClsFromVar(AClass, TSimpleRWSync));
end;

{ TThreadInfo_sw }

function TThreadInfo_ThreadID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ThreadID: Cardinal;

  if IsGet then
    Result := TThreadInfo_sw(AObj).FValue.ThreadID
  else
    TThreadInfo_sw(AObj).FValue.ThreadID := Cardinal(AArgs[0]);
end;

function TThreadInfo_Active_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Active: Integer;

  if IsGet then
    Result := TThreadInfo_sw(AObj).FValue.Active
  else
    TThreadInfo_sw(AObj).FValue.Active := Integer(AArgs[0]);
end;

function TThreadInfo_RecursionCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var RecursionCount: Cardinal;

  if IsGet then
    Result := TThreadInfo_sw(AObj).FValue.RecursionCount
  else
    TThreadInfo_sw(AObj).FValue.RecursionCount := Cardinal(AArgs[0]);
end;

function TThreadInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TThreadInfo_sw.Create as IDispatch;
end;

function TThreadInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TThreadInfo;

  // Implicit record copy method.
  Result := TThreadInfo_sw.ToVar(TThreadInfo(AObj));
end;

class function TThreadInfo_sw.GetTypeName: WideString;
begin
  Result := 'TThreadInfo';
end;

function TThreadInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TThreadInfo_sw.Create;
  TThreadInfo_sw(Result).FValue := FValue;
end;

class procedure TThreadInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ThreadID', TThreadInfo_ThreadID_si, Cardinal_sw);
  AData.AddField('Active', TThreadInfo_Active_si, Integer_sw);
  AData.AddField('RecursionCount', TThreadInfo_RecursionCount_si, Cardinal_sw);
  AData.AddFunction('Copy', TThreadInfo_Copy_si, TThreadInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TThreadInfo_Create_si, 0, False);
end;

class function TThreadInfo_sw.ToVar(const AValue: TThreadInfo): OleVariant;
var
  wrpr: TThreadInfo_sw;
begin
  wrpr        := TThreadInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TThreadInfo_sw.FromVar(const AValue: OleVariant): TThreadInfo;
begin
  Result := TThreadInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TThreadLocalCounter_sw }

class function TThreadLocalCounter_sw.GetTypeName: WideString;
begin
  Result := 'TThreadLocalCounter';
end;

class function TThreadLocalCounter_sw.GetWrappedClass: TClass;
begin
  Result := TThreadLocalCounter;
end;

class procedure TThreadLocalCounter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TThreadLocalCounter_sw.ToVar(
  const AValue: TThreadLocalCounter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TThreadLocalCounter_sw.FromVar(
  const AValue: OleVariant): TThreadLocalCounter;
begin
  Result := TThreadLocalCounter(ConvFromVar(AValue, TThreadLocalCounter));
end;

class function TThreadLocalCounter_sw.ClassToVar(
  AClass: TThreadLocalCounter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TThreadLocalCounter_sw.ClassFromVar(
  const AClass: OleVariant): TThreadLocalCounter_sc;
begin
  Result := TThreadLocalCounter_sc(ConvClsFromVar(AClass, TThreadLocalCounter));
end;

{ TMultiReadExclusiveWriteSynchronizer_sw }

function TMultiReadExclusiveWriteSynchronizer_Create_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TMultiReadExclusiveWriteSynchronizer_sw.ToVar(
    TMultiReadExclusiveWriteSynchronizer_sc(AObj).Create());
end;

function TMultiReadExclusiveWriteSynchronizer_BeginRead_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginRead;

  TMultiReadExclusiveWriteSynchronizer(AObj).BeginRead();
end;

function TMultiReadExclusiveWriteSynchronizer_EndRead_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndRead;

  TMultiReadExclusiveWriteSynchronizer(AObj).EndRead();
end;

function TMultiReadExclusiveWriteSynchronizer_BeginWrite_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function BeginWrite: Boolean;

  Result := TMultiReadExclusiveWriteSynchronizer(AObj).BeginWrite();
end;

function TMultiReadExclusiveWriteSynchronizer_EndWrite_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndWrite;

  TMultiReadExclusiveWriteSynchronizer(AObj).EndWrite();
end;

function TMultiReadExclusiveWriteSynchronizer_RevisionLevel_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RevisionLevel: Cardinal read <getter>;

  Result := TMultiReadExclusiveWriteSynchronizer(AObj).RevisionLevel;
end;

class function TMultiReadExclusiveWriteSynchronizer_sw.GetTypeName: WideString;
begin
  Result := 'TMultiReadExclusiveWriteSynchronizer';
end;

class function TMultiReadExclusiveWriteSynchronizer_sw.GetWrappedClass: TClass;
begin
  Result := TMultiReadExclusiveWriteSynchronizer;
end;

class procedure TMultiReadExclusiveWriteSynchronizer_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('BeginRead', TMultiReadExclusiveWriteSynchronizer_BeginRead_si, 0, False);
  AData.AddProcedure('EndRead', TMultiReadExclusiveWriteSynchronizer_EndRead_si, 0, False);
  AData.AddFunction('BeginWrite', TMultiReadExclusiveWriteSynchronizer_BeginWrite_si, Boolean_sw, 0, False);
  AData.AddProcedure('EndWrite', TMultiReadExclusiveWriteSynchronizer_EndWrite_si, 0, False);
  AData.AddProperty('RevisionLevel', TMultiReadExclusiveWriteSynchronizer_RevisionLevel_si, Cardinal_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TMultiReadExclusiveWriteSynchronizer_Create_si, 0, False);
end;

class function TMultiReadExclusiveWriteSynchronizer_sw.ToVar(
  const AValue: TMultiReadExclusiveWriteSynchronizer): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMultiReadExclusiveWriteSynchronizer_sw.FromVar(
  const AValue: OleVariant): TMultiReadExclusiveWriteSynchronizer;
begin
  Result := TMultiReadExclusiveWriteSynchronizer(ConvFromVar(AValue, 
    TMultiReadExclusiveWriteSynchronizer));
end;

class function TMultiReadExclusiveWriteSynchronizer_sw.ClassToVar(
  AClass: TMultiReadExclusiveWriteSynchronizer_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMultiReadExclusiveWriteSynchronizer_sw.ClassFromVar(
  const AClass: OleVariant): TMultiReadExclusiveWriteSynchronizer_sc;
begin
  Result := TMultiReadExclusiveWriteSynchronizer_sc(ConvClsFromVar(AClass, 
    TMultiReadExclusiveWriteSynchronizer));
end;

{ SysUtils_sw }

function SysUtils_fmOpenRead_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmOpenRead = <value>;

  Result := fmOpenRead;
end;

function SysUtils_fmOpenWrite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmOpenWrite = <value>;

  Result := fmOpenWrite;
end;

function SysUtils_fmOpenReadWrite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmOpenReadWrite = <value>;

  Result := fmOpenReadWrite;
end;

function SysUtils_fmShareCompat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmShareCompat = <value>;

  Result := fmShareCompat;
end;

function SysUtils_fmShareExclusive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmShareExclusive = <value>;

  Result := fmShareExclusive;
end;

function SysUtils_fmShareDenyWrite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmShareDenyWrite = <value>;

  Result := fmShareDenyWrite;
end;

function SysUtils_fmShareDenyRead_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmShareDenyRead = <value>;

  Result := fmShareDenyRead;
end;

function SysUtils_fmShareDenyNone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmShareDenyNone = <value>;

  Result := fmShareDenyNone;
end;

function SysUtils_faReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const faReadOnly = <value>;

  Result := faReadOnly;
end;

function SysUtils_faHidden_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const faHidden = <value>;

  Result := faHidden;
end;

function SysUtils_faSysFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const faSysFile = <value>;

  Result := faSysFile;
end;

function SysUtils_faVolumeID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const faVolumeID = <value>;

  Result := faVolumeID;
end;

function SysUtils_faDirectory_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const faDirectory = <value>;

  Result := faDirectory;
end;

function SysUtils_faArchive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const faArchive = <value>;

  Result := faArchive;
end;

function SysUtils_faSymLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const faSymLink = <value>;

  Result := faSymLink;
end;

function SysUtils_faAnyFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const faAnyFile = <value>;

  Result := faAnyFile;
end;

function SysUtils_HoursPerDay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const HoursPerDay = <value>;

  Result := HoursPerDay;
end;

function SysUtils_MinsPerHour_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MinsPerHour = <value>;

  Result := MinsPerHour;
end;

function SysUtils_SecsPerMin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SecsPerMin = <value>;

  Result := SecsPerMin;
end;

function SysUtils_MSecsPerSec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MSecsPerSec = <value>;

  Result := MSecsPerSec;
end;

function SysUtils_MinsPerDay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MinsPerDay = <value>;

  Result := MinsPerDay;
end;

function SysUtils_SecsPerDay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SecsPerDay = <value>;

  Result := SecsPerDay;
end;

function SysUtils_MSecsPerDay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MSecsPerDay = <value>;

  Result := MSecsPerDay;
end;

function SysUtils_DateDelta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DateDelta = <value>;

  Result := DateDelta;
end;

function SysUtils_UnixDateDelta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const UnixDateDelta = <value>;

  Result := UnixDateDelta;
end;

function SysUtils_TSysCharSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSysCharSet = set of Char;

  Result := TLMDUnitWrapper.TypeToVar(TSysCharSet_sw);
end;

function SysUtils_WordRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type WordRec = record;

  Result := TLMDUnitWrapper.TypeToVar(WordRec_sw);
end;

function SysUtils_LongRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LongRec = record;

  Result := TLMDUnitWrapper.TypeToVar(LongRec_sw);
end;

function SysUtils_Int64Rec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type Int64Rec = record;

  Result := TLMDUnitWrapper.TypeToVar(Int64Rec_sw);
end;

function SysUtils_TFileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileName = string;

  Result := TLMDUnitWrapper.TypeToVar(TFileName_sw);
end;

function SysUtils_TSearchRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSearchRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TSearchRec_sw);
end;

function SysUtils_TFloatValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFloatValue = (fvExtended, fvCurrency);

  Result := TLMDUnitWrapper.TypeToVar(TFloatValue_sw);
end;

function SysUtils_TFloatFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFloatFormat = (ffGeneral, ffExponent, ffFixed, ffNu...

  Result := TLMDUnitWrapper.TypeToVar(TFloatFormat_sw);
end;

function SysUtils_TFloatRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFloatRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TFloatRec_sw);
end;

function SysUtils_TTimeStamp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTimeStamp = record;

  Result := TLMDUnitWrapper.TypeToVar(TTimeStamp_sw);
end;

function SysUtils_TMbcsByteType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMbcsByteType = (mbSingleByte, mbLeadByte, mbTrailBy...

  Result := TLMDUnitWrapper.TypeToVar(TMbcsByteType_sw);
end;

function SysUtils_TSysLocale_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSysLocale = record;

  Result := TLMDUnitWrapper.TypeToVar(TSysLocale_sw);
end;

function SysUtils_TLangRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLangRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TLangRec_sw);
end;

function SysUtils_TLanguages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLanguages = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TLanguages_sw);
end;

function SysUtils_Exception_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type Exception = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(Exception_sw);
end;

function SysUtils_ExceptClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ExceptClass = class of Exception;

  Result := TLMDUnitWrapper.TypeToVar(ExceptClass_sw);
end;

function SysUtils_EAbort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EAbort = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EAbort_sw);
end;

function SysUtils_EHeapException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EHeapException = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EHeapException_sw);
end;

function SysUtils_EOutOfMemory_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EOutOfMemory = class(EHeapException);

  Result := TLMDUnitWrapper.TypeToVar(EOutOfMemory_sw);
end;

function SysUtils_EInOutError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EInOutError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EInOutError_sw);
end;

function SysUtils_TExceptionRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExceptionRecord = record;

  Result := TLMDUnitWrapper.TypeToVar(TExceptionRecord_sw);
end;

function SysUtils_EExternal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EExternal = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EExternal_sw);
end;

function SysUtils_EExternalException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EExternalException = class(EExternal);

  Result := TLMDUnitWrapper.TypeToVar(EExternalException_sw);
end;

function SysUtils_EIntError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EIntError = class(EExternal);

  Result := TLMDUnitWrapper.TypeToVar(EIntError_sw);
end;

function SysUtils_EDivByZero_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EDivByZero = class(EIntError);

  Result := TLMDUnitWrapper.TypeToVar(EDivByZero_sw);
end;

function SysUtils_ERangeError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ERangeError = class(EIntError);

  Result := TLMDUnitWrapper.TypeToVar(ERangeError_sw);
end;

function SysUtils_EIntOverflow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EIntOverflow = class(EIntError);

  Result := TLMDUnitWrapper.TypeToVar(EIntOverflow_sw);
end;

function SysUtils_EMathError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EMathError = class(EExternal);

  Result := TLMDUnitWrapper.TypeToVar(EMathError_sw);
end;

function SysUtils_EInvalidOp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EInvalidOp = class(EMathError);

  Result := TLMDUnitWrapper.TypeToVar(EInvalidOp_sw);
end;

function SysUtils_EZeroDivide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EZeroDivide = class(EMathError);

  Result := TLMDUnitWrapper.TypeToVar(EZeroDivide_sw);
end;

function SysUtils_EOverflow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EOverflow = class(EMathError);

  Result := TLMDUnitWrapper.TypeToVar(EOverflow_sw);
end;

function SysUtils_EUnderflow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EUnderflow = class(EMathError);

  Result := TLMDUnitWrapper.TypeToVar(EUnderflow_sw);
end;

function SysUtils_EInvalidPointer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EInvalidPointer = class(EHeapException);

  Result := TLMDUnitWrapper.TypeToVar(EInvalidPointer_sw);
end;

function SysUtils_EInvalidCast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EInvalidCast = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EInvalidCast_sw);
end;

function SysUtils_EConvertError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EConvertError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EConvertError_sw);
end;

function SysUtils_EAccessViolation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EAccessViolation = class(EExternal);

  Result := TLMDUnitWrapper.TypeToVar(EAccessViolation_sw);
end;

function SysUtils_EPrivilege_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EPrivilege = class(EExternal);

  Result := TLMDUnitWrapper.TypeToVar(EPrivilege_sw);
end;

function SysUtils_EStackOverflow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EStackOverflow = class(EExternal);

  Result := TLMDUnitWrapper.TypeToVar(EStackOverflow_sw);
end;

function SysUtils_EControlC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EControlC = class(EExternal);

  Result := TLMDUnitWrapper.TypeToVar(EControlC_sw);
end;

function SysUtils_EVariantError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EVariantError_sw);
end;

function SysUtils_EPropReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EPropReadOnly = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EPropReadOnly_sw);
end;

function SysUtils_EPropWriteOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EPropWriteOnly = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EPropWriteOnly_sw);
end;

function SysUtils_EAssertionFailed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EAssertionFailed = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EAssertionFailed_sw);
end;

function SysUtils_EAbstractError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EAbstractError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EAbstractError_sw);
end;

function SysUtils_EIntfCastError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EIntfCastError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EIntfCastError_sw);
end;

function SysUtils_EInvalidContainer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EInvalidContainer = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EInvalidContainer_sw);
end;

function SysUtils_EInvalidInsert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EInvalidInsert = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EInvalidInsert_sw);
end;

function SysUtils_EPackageError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EPackageError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EPackageError_sw);
end;

function SysUtils_EOSError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EOSError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EOSError_sw);
end;

function SysUtils_EWin32Error_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EWin32Error = class(EOSError);

  Result := TLMDUnitWrapper.TypeToVar(EWin32Error_sw);
end;

function SysUtils_ESafecallException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ESafecallException = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(ESafecallException_sw);
end;

function SysUtils_EmptyStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var EmptyStr: string;

  if IsGet then
    Result := SysUtils.EmptyStr
  else
    SysUtils.EmptyStr := string(AArgs[0]);
end;

function SysUtils_EmptyWideStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var EmptyWideStr: WideString;

  if IsGet then
    Result := SysUtils.EmptyWideStr
  else
    SysUtils.EmptyWideStr := WideString(AArgs[0]);
end;

function SysUtils_Win32Platform_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Win32Platform: Integer;

  if IsGet then
    Result := SysUtils.Win32Platform
  else
    SysUtils.Win32Platform := Integer(AArgs[0]);
end;

function SysUtils_Win32MajorVersion_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Win32MajorVersion: Integer;

  if IsGet then
    Result := SysUtils.Win32MajorVersion
  else
    SysUtils.Win32MajorVersion := Integer(AArgs[0]);
end;

function SysUtils_Win32MinorVersion_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Win32MinorVersion: Integer;

  if IsGet then
    Result := SysUtils.Win32MinorVersion
  else
    SysUtils.Win32MinorVersion := Integer(AArgs[0]);
end;

function SysUtils_Win32BuildNumber_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Win32BuildNumber: Integer;

  if IsGet then
    Result := SysUtils.Win32BuildNumber
  else
    SysUtils.Win32BuildNumber := Integer(AArgs[0]);
end;

function SysUtils_Win32CSDVersion_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Win32CSDVersion: string;

  if IsGet then
    Result := SysUtils.Win32CSDVersion
  else
    SysUtils.Win32CSDVersion := string(AArgs[0]);
end;

function SysUtils_CheckWin32Version_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CheckWin32Version(AMajor: Integer; AMinor: Integ...

  case AArgsSize of
    1:
    begin
      Result := SysUtils.CheckWin32Version(Integer(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.CheckWin32Version(Integer(AArgs[0]), Integer(
        AArgs[1]));
    end;
  else
    WrongArgCountError('CheckWin32Version');
  end;
end;

function SysUtils_GetFileVersion_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetFileVersion(const AFileName: string): Cardinal;

  Result := SysUtils.GetFileVersion(string(AArgs[0]));
end;

function SysUtils_CurrencyString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CurrencyString: string;

  if IsGet then
    Result := SysUtils.CurrencyString
  else
    SysUtils.CurrencyString := string(AArgs[0]);
end;

function SysUtils_CurrencyFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CurrencyFormat: Byte;

  if IsGet then
    Result := SysUtils.CurrencyFormat
  else
    SysUtils.CurrencyFormat := Byte(AArgs[0]);
end;

function SysUtils_NegCurrFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var NegCurrFormat: Byte;

  if IsGet then
    Result := SysUtils.NegCurrFormat
  else
    SysUtils.NegCurrFormat := Byte(AArgs[0]);
end;

function SysUtils_ThousandSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ThousandSeparator: Char;

  if IsGet then
    Result := SysUtils.ThousandSeparator
  else
    SysUtils.ThousandSeparator := Char(Integer(AArgs[0]));
end;

function SysUtils_DecimalSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DecimalSeparator: Char;

  if IsGet then
    Result := SysUtils.DecimalSeparator
  else
    SysUtils.DecimalSeparator := Char(Integer(AArgs[0]));
end;

function SysUtils_CurrencyDecimals_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CurrencyDecimals: Byte;

  if IsGet then
    Result := SysUtils.CurrencyDecimals
  else
    SysUtils.CurrencyDecimals := Byte(AArgs[0]);
end;

function SysUtils_DateSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DateSeparator: Char;

  if IsGet then
    Result := SysUtils.DateSeparator
  else
    SysUtils.DateSeparator := Char(Integer(AArgs[0]));
end;

function SysUtils_ShortDateFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ShortDateFormat: string;

  if IsGet then
    Result := SysUtils.ShortDateFormat
  else
    SysUtils.ShortDateFormat := string(AArgs[0]);
end;

function SysUtils_LongDateFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LongDateFormat: string;

  if IsGet then
    Result := SysUtils.LongDateFormat
  else
    SysUtils.LongDateFormat := string(AArgs[0]);
end;

function SysUtils_TimeSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TimeSeparator: Char;

  if IsGet then
    Result := SysUtils.TimeSeparator
  else
    SysUtils.TimeSeparator := Char(Integer(AArgs[0]));
end;

function SysUtils_TimeAMString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TimeAMString: string;

  if IsGet then
    Result := SysUtils.TimeAMString
  else
    SysUtils.TimeAMString := string(AArgs[0]);
end;

function SysUtils_TimePMString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TimePMString: string;

  if IsGet then
    Result := SysUtils.TimePMString
  else
    SysUtils.TimePMString := string(AArgs[0]);
end;

function SysUtils_ShortTimeFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ShortTimeFormat: string;

  if IsGet then
    Result := SysUtils.ShortTimeFormat
  else
    SysUtils.ShortTimeFormat := string(AArgs[0]);
end;

function SysUtils_LongTimeFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LongTimeFormat: string;

  if IsGet then
    Result := SysUtils.LongTimeFormat
  else
    SysUtils.LongTimeFormat := string(AArgs[0]);
end;

function SysUtils_SysLocale_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SysLocale: TSysLocale;

  if IsGet then
    Result := TSysLocale_sw.ToVar(SysUtils.SysLocale)
  else
    SysUtils.SysLocale := TSysLocale_sw.FromVar(AArgs[0]);
end;

function SysUtils_TwoDigitYearCenturyWindow_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TwoDigitYearCenturyWindow: Word;

  if IsGet then
    Result := SysUtils.TwoDigitYearCenturyWindow
  else
    SysUtils.TwoDigitYearCenturyWindow := Word(AArgs[0]);
end;

function SysUtils_ListSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ListSeparator: Char;

  if IsGet then
    Result := SysUtils.ListSeparator
  else
    SysUtils.ListSeparator := Char(Integer(AArgs[0]));
end;

function SysUtils_TFormatSettings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFormatSettings = record;

  Result := TLMDUnitWrapper.TypeToVar(TFormatSettings_sw);
end;

function SysUtils_MaxEraCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MaxEraCount = <value>;

  Result := MaxEraCount;
end;

function SysUtils_PathDelim_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const PathDelim = <value>;

  Result := PathDelim;
end;

function SysUtils_DriveDelim_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DriveDelim = <value>;

  Result := DriveDelim;
end;

function SysUtils_PathSep_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const PathSep = <value>;

  Result := PathSep;
end;

function SysUtils_Languages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Languages: TLanguages;

  Result := TLanguages_sw.ToVar(SysUtils.Languages());
end;

function SysUtils_AppendStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // procedure AppendStr(var Dest: string; const S: string);

  v_1 := string(AArgs[0]);
  SysUtils.AppendStr(v_1, string(AArgs[1]));
  AssignRefParam(AArgs[0], v_1);
end;

function SysUtils_UpperCase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UpperCase(const S: string): string;

  Result := SysUtils.UpperCase(string(AArgs[0]));
end;

function SysUtils_LowerCase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function LowerCase(const S: string): string;

  Result := SysUtils.LowerCase(string(AArgs[0]));
end;

function SysUtils_CompareStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CompareStr(const S1: string; const S2: string): ...

  Result := SysUtils.CompareStr(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_CompareText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CompareText(const S1: string; const S2: string):...

  Result := SysUtils.CompareText(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_SameText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SameText(const S1: string; const S2: string): Bo...

  Result := SysUtils.SameText(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_AnsiUpperCase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiUpperCase(const S: string): string;

  Result := SysUtils.AnsiUpperCase(string(AArgs[0]));
end;

function SysUtils_AnsiLowerCase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiLowerCase(const S: string): string;

  Result := SysUtils.AnsiLowerCase(string(AArgs[0]));
end;

function SysUtils_AnsiCompareStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiCompareStr(const S1: string; const S2: strin...

  Result := SysUtils.AnsiCompareStr(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_AnsiSameStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiSameStr(const S1: string; const S2: string):...

  Result := SysUtils.AnsiSameStr(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_AnsiCompareText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiCompareText(const S1: string; const S2: stri...

  Result := SysUtils.AnsiCompareText(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_AnsiSameText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiSameText(const S1: string; const S2: string)...

  Result := SysUtils.AnsiSameText(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_WideUpperCase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function WideUpperCase(const S: WideString): WideString;

  Result := SysUtils.WideUpperCase(WideString(AArgs[0]));
end;

function SysUtils_WideLowerCase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function WideLowerCase(const S: WideString): WideString;

  Result := SysUtils.WideLowerCase(WideString(AArgs[0]));
end;

function SysUtils_WideCompareStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function WideCompareStr(const S1: WideString; const S2: W...

  Result := SysUtils.WideCompareStr(WideString(AArgs[0]), WideString(AArgs[1]));
end;

function SysUtils_WideSameStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function WideSameStr(const S1: WideString; const S2: Wide...

  Result := SysUtils.WideSameStr(WideString(AArgs[0]), WideString(AArgs[1]));
end;

function SysUtils_WideCompareText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function WideCompareText(const S1: WideString; const S2: ...

  Result := SysUtils.WideCompareText(WideString(AArgs[0]), WideString(
    AArgs[1]));
end;

function SysUtils_WideSameText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function WideSameText(const S1: WideString; const S2: Wid...

  Result := SysUtils.WideSameText(WideString(AArgs[0]), WideString(AArgs[1]));
end;

function SysUtils_Trim_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Trim(...); overload;

  Result := SysUtils.Trim(string(AArgs[0]));
end;

function SysUtils_TrimLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function TrimLeft(...); overload;

  Result := SysUtils.TrimLeft(string(AArgs[0]));
end;

function SysUtils_TrimRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function TrimRight(...); overload;

  Result := SysUtils.TrimRight(string(AArgs[0]));
end;

function SysUtils_QuotedStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function QuotedStr(const S: string): string;

  Result := SysUtils.QuotedStr(string(AArgs[0]));
end;

function SysUtils_AnsiQuotedStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiQuotedStr(const S: string; Quote: Char): str...

  Result := SysUtils.AnsiQuotedStr(string(AArgs[0]), Char(Integer(AArgs[1])));
end;

function SysUtils_AnsiDequotedStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiDequotedStr(const S: string; AQuote: Char): ...

  Result := SysUtils.AnsiDequotedStr(string(AArgs[0]), Char(Integer(AArgs[1])));
end;

function SysUtils_AdjustLineBreaks_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AdjustLineBreaks(const S: string; Style: TTextLi...

  case AArgsSize of
    1:
    begin
      Result := SysUtils.AdjustLineBreaks(string(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.AdjustLineBreaks(string(AArgs[0]), 
        TTextLineBreakStyle_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('AdjustLineBreaks');
  end;
end;

function SysUtils_IsValidIdent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsValidIdent(const Ident: string): Boolean;

  Result := SysUtils.IsValidIdent(string(AArgs[0]));
end;

function SysUtils_IntToStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function IntToStr(...); overload;

  Result := SysUtils.IntToStr(Int64_sw.FromVar(AArgs[0]));
end;

function SysUtils_IntToHex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function IntToHex(...); overload;

  Result := SysUtils.IntToHex(Int64_sw.FromVar(AArgs[0]), Integer(AArgs[1]));
end;

function SysUtils_StrToInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StrToInt(const S: string): Integer;

  Result := SysUtils.StrToInt(string(AArgs[0]));
end;

function SysUtils_StrToIntDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StrToIntDef(const S: string; Default: Integer): ...

  Result := SysUtils.StrToIntDef(string(AArgs[0]), Integer(AArgs[1]));
end;

function SysUtils_TryStrToInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // function TryStrToInt(const S: string; out Value: Integer)...

  Result := SysUtils.TryStrToInt(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function SysUtils_StrToInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StrToInt64(const S: string): Int64;

  Result := Int64_sw.ToVar(SysUtils.StrToInt64(string(AArgs[0])));
end;

function SysUtils_StrToInt64Def_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StrToInt64Def(const S: string; const Default: In...

  Result := Int64_sw.ToVar(SysUtils.StrToInt64Def(string(AArgs[0]), Int64_sw.
    FromVar(AArgs[1])));
end;

function SysUtils_TryStrToInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Int64;
begin
  // function TryStrToInt64(const S: string; out Value: Int64)...

  Result := SysUtils.TryStrToInt64(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], Int64_sw.ToVar(v_1));
end;

function SysUtils_DefaultTrueBoolStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DefaultTrueBoolStr = <value>;

  Result := DefaultTrueBoolStr;
end;

function SysUtils_DefaultFalseBoolStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DefaultFalseBoolStr = <value>;

  Result := DefaultFalseBoolStr;
end;

function SysUtils_StrToBool_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StrToBool(const S: string): Boolean;

  Result := SysUtils.StrToBool(string(AArgs[0]));
end;

function SysUtils_StrToBoolDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StrToBoolDef(const S: string; const Default: Boo...

  Result := SysUtils.StrToBoolDef(string(AArgs[0]), Boolean(AArgs[1]));
end;

function SysUtils_TryStrToBool_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Boolean;
begin
  // function TryStrToBool(const S: string; out Value: Boolean...

  Result := SysUtils.TryStrToBool(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function SysUtils_BoolToStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function BoolToStr(B: Boolean; UseBoolStrs: Boolean): str...

  case AArgsSize of
    1:
    begin
      Result := SysUtils.BoolToStr(Boolean(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.BoolToStr(Boolean(AArgs[0]), Boolean(AArgs[1]));
    end;
  else
    WrongArgCountError('BoolToStr');
  end;
end;

function SysUtils_LoadStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function LoadStr(Ident: Integer): string;

  Result := SysUtils.LoadStr(Integer(AArgs[0]));
end;

function SysUtils_FileOpen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FileOpen(const FileName: string; Mode: LongWord)...

  Result := SysUtils.FileOpen(string(AArgs[0]), LongWord(AArgs[1]));
end;

function SysUtils_FileCreate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FileCreate(...); overload;

  case AArgsSize of
    1:
    begin
      Result := SysUtils.FileCreate(string(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.FileCreate(string(AArgs[0]), Integer(AArgs[1]));
    end;
  else
    WrongArgCountError('FileCreate');
  end;
end;

function SysUtils_FileSeek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FileSeek(...); overload;

  Result := Int64_sw.ToVar(SysUtils.FileSeek(Integer(AArgs[0]), Int64_sw.
    FromVar(AArgs[1]), Integer(AArgs[2])));
end;

function SysUtils_FileClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FileClose(Handle: Integer);

  SysUtils.FileClose(Integer(AArgs[0]));
end;

function SysUtils_FileAge_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FileAge(const FileName: string): Integer;

  Result := SysUtils.FileAge(string(AArgs[0]));
end;

function SysUtils_FileExists_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FileExists(const FileName: string): Boolean;

  Result := SysUtils.FileExists(string(AArgs[0]));
end;

function SysUtils_DirectoryExists_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DirectoryExists(const Directory: string): Boolean;

  Result := SysUtils.DirectoryExists(string(AArgs[0]));
end;

function SysUtils_ForceDirectories_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ForceDirectories(Dir: string): Boolean;

  Result := SysUtils.ForceDirectories(string(AArgs[0]));
end;

function SysUtils_FindFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TSearchRec;
begin
  // function FindFirst(const Path: string; Attr: Integer; var...

  v_1 := TSearchRec_sw.FromVar(AArgs[2]);
  Result := SysUtils.FindFirst(string(AArgs[0]), Integer(AArgs[1]), v_1);
  AssignRefParam(AArgs[2], TSearchRec_sw.ToVar(v_1));
end;

function SysUtils_FindNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TSearchRec;
begin
  // function FindNext(var F: TSearchRec): Integer;

  v_1 := TSearchRec_sw.FromVar(AArgs[0]);
  Result := SysUtils.FindNext(v_1);
  AssignRefParam(AArgs[0], TSearchRec_sw.ToVar(v_1));
end;

function SysUtils_FindClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TSearchRec;
begin
  // procedure FindClose(var F: TSearchRec);

  v_1 := TSearchRec_sw.FromVar(AArgs[0]);
  SysUtils.FindClose(v_1);
  AssignRefParam(AArgs[0], TSearchRec_sw.ToVar(v_1));
end;

function SysUtils_FileGetDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FileGetDate(Handle: Integer): Integer;

  Result := SysUtils.FileGetDate(Integer(AArgs[0]));
end;

function SysUtils_FileSetDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FileSetDate(...); overload;

  Result := SysUtils.FileSetDate(string(AArgs[0]), Integer(AArgs[1]));
end;

function SysUtils_FileGetAttr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FileGetAttr(const FileName: string): Integer;

  Result := SysUtils.FileGetAttr(string(AArgs[0]));
end;

function SysUtils_FileSetAttr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FileSetAttr(const FileName: string; Attr: Intege...

  Result := SysUtils.FileSetAttr(string(AArgs[0]), Integer(AArgs[1]));
end;

function SysUtils_FileIsReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FileIsReadOnly(const FileName: string): Boolean;

  Result := SysUtils.FileIsReadOnly(string(AArgs[0]));
end;

function SysUtils_FileSetReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FileSetReadOnly(const FileName: string; ReadOnly...

  Result := SysUtils.FileSetReadOnly(string(AArgs[0]), Boolean(AArgs[1]));
end;

function SysUtils_DeleteFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DeleteFile(const FileName: string): Boolean;

  Result := SysUtils.DeleteFile(string(AArgs[0]));
end;

function SysUtils_RenameFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RenameFile(const OldName: string; const NewName:...

  Result := SysUtils.RenameFile(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_ChangeFileExt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ChangeFileExt(const FileName: string; const Exte...

  Result := SysUtils.ChangeFileExt(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_ExtractFilePath_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExtractFilePath(const FileName: string): string;

  Result := SysUtils.ExtractFilePath(string(AArgs[0]));
end;

function SysUtils_ExtractFileDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExtractFileDir(const FileName: string): string;

  Result := SysUtils.ExtractFileDir(string(AArgs[0]));
end;

function SysUtils_ExtractFileDrive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExtractFileDrive(const FileName: string): string;

  Result := SysUtils.ExtractFileDrive(string(AArgs[0]));
end;

function SysUtils_ExtractFileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExtractFileName(const FileName: string): string;

  Result := SysUtils.ExtractFileName(string(AArgs[0]));
end;

function SysUtils_ExtractFileExt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExtractFileExt(const FileName: string): string;

  Result := SysUtils.ExtractFileExt(string(AArgs[0]));
end;

function SysUtils_ExpandFileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExpandFileName(const FileName: string): string;

  Result := SysUtils.ExpandFileName(string(AArgs[0]));
end;

function SysUtils_TFilenameCaseMatch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFilenameCaseMatch = (mkNone, mkExactMatch, mkSingle...

  Result := TLMDUnitWrapper.TypeToVar(TFilenameCaseMatch_sw);
end;

function SysUtils_ExpandFileNameCase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TFilenameCaseMatch;
begin
  // function ExpandFileNameCase(const FileName: string; out M...

  Result := SysUtils.ExpandFileNameCase(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TFilenameCaseMatch_sw.ToVar(v_1));
end;

function SysUtils_ExpandUNCFileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExpandUNCFileName(const FileName: string): string;

  Result := SysUtils.ExpandUNCFileName(string(AArgs[0]));
end;

function SysUtils_ExtractRelativePath_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExtractRelativePath(const BaseName: string; cons...

  Result := SysUtils.ExtractRelativePath(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_ExtractShortPathName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExtractShortPathName(const FileName: string): st...

  Result := SysUtils.ExtractShortPathName(string(AArgs[0]));
end;

function SysUtils_FileSearch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FileSearch(const Name: string; const DirList: st...

  Result := SysUtils.FileSearch(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_DiskFree_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DiskFree(Drive: Byte): Int64;

  Result := Int64_sw.ToVar(SysUtils.DiskFree(Byte(AArgs[0])));
end;

function SysUtils_DiskSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DiskSize(Drive: Byte): Int64;

  Result := Int64_sw.ToVar(SysUtils.DiskSize(Byte(AArgs[0])));
end;

function SysUtils_FileDateToDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FileDateToDateTime(FileDate: Integer): TDateTime;

  Result := TDateTime_sw.ToVar(SysUtils.FileDateToDateTime(Integer(AArgs[0])));
end;

function SysUtils_DateTimeToFileDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DateTimeToFileDate(DateTime: TDateTime): Integer;

  Result := SysUtils.DateTimeToFileDate(TDateTime_sw.FromVar(AArgs[0]));
end;

function SysUtils_GetCurrentDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrentDir: string;

  Result := SysUtils.GetCurrentDir();
end;

function SysUtils_SetCurrentDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SetCurrentDir(const Dir: string): Boolean;

  Result := SysUtils.SetCurrentDir(string(AArgs[0]));
end;

function SysUtils_CreateDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CreateDir(const Dir: string): Boolean;

  Result := SysUtils.CreateDir(string(AArgs[0]));
end;

function SysUtils_RemoveDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RemoveDir(const Dir: string): Boolean;

  Result := SysUtils.RemoveDir(string(AArgs[0]));
end;

function SysUtils_FloatToStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FloatToStr(...); overload;

  case AArgsSize of
    1:
    begin
      Result := SysUtils.FloatToStr(Extended(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.FloatToStr(Extended(AArgs[0]), TFormatSettings_sw.
        FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('FloatToStr');
  end;
end;

function SysUtils_CurrToStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function CurrToStr(...); overload;

  case AArgsSize of
    1:
    begin
      Result := SysUtils.CurrToStr(Currency(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.CurrToStr(Currency(AArgs[0]), TFormatSettings_sw.
        FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('CurrToStr');
  end;
end;

function SysUtils_MinCurrency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MinCurrency: Currency = <value>;

  Result := MinCurrency;
end;

function SysUtils_MaxCurrency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MaxCurrency: Currency = <value>;

  Result := MaxCurrency;
end;

function SysUtils_FloatToCurr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FloatToCurr(const Value: Extended): Currency;

  Result := SysUtils.FloatToCurr(Extended(AArgs[0]));
end;

function SysUtils_TryFloatToCurr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Currency;
begin
  // function TryFloatToCurr(const Value: Extended; out AResul...

  Result := SysUtils.TryFloatToCurr(Extended(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function SysUtils_FloatToStrF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FloatToStrF(...); overload;

  case AArgsSize of
    4:
    begin
      Result := SysUtils.FloatToStrF(Extended(AArgs[0]), TFloatFormat_sw.
        FromVar(AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3]));
    end;
    5:
    begin
      Result := SysUtils.FloatToStrF(Extended(AArgs[0]), TFloatFormat_sw.
        FromVar(AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3]),
        TFormatSettings_sw.FromVar(AArgs[4]));
    end;
  else
    WrongArgCountError('FloatToStrF');
  end;
end;

function SysUtils_CurrToStrF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function CurrToStrF(...); overload;

  case AArgsSize of
    3:
    begin
      Result := SysUtils.CurrToStrF(Currency(AArgs[0]), TFloatFormat_sw.FromVar(
        AArgs[1]), Integer(AArgs[2]));
    end;
    4:
    begin
      Result := SysUtils.CurrToStrF(Currency(AArgs[0]), TFloatFormat_sw.FromVar(
        AArgs[1]), Integer(AArgs[2]), TFormatSettings_sw.FromVar(AArgs[3]));
    end;
  else
    WrongArgCountError('CurrToStrF');
  end;
end;

function SysUtils_FormatFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FormatFloat(...); overload;

  case AArgsSize of
    2:
    begin
      Result := SysUtils.FormatFloat(string(AArgs[0]), Extended(AArgs[1]));
    end;
    3:
    begin
      Result := SysUtils.FormatFloat(string(AArgs[0]), Extended(AArgs[1]), 
        TFormatSettings_sw.FromVar(AArgs[2]));
    end;
  else
    WrongArgCountError('FormatFloat');
  end;
end;

function SysUtils_FormatCurr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FormatCurr(...); overload;

  case AArgsSize of
    2:
    begin
      Result := SysUtils.FormatCurr(string(AArgs[0]), Currency(AArgs[1]));
    end;
    3:
    begin
      Result := SysUtils.FormatCurr(string(AArgs[0]), Currency(AArgs[1]), 
        TFormatSettings_sw.FromVar(AArgs[2]));
    end;
  else
    WrongArgCountError('FormatCurr');
  end;
end;

function SysUtils_StrToFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StrToFloat(...); overload;

  case AArgsSize of
    1:
    begin
      Result := SysUtils.StrToFloat(string(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.StrToFloat(string(AArgs[0]), TFormatSettings_sw.
        FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('StrToFloat');
  end;
end;

function SysUtils_StrToFloatDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StrToFloatDef(...); overload;

  case AArgsSize of
    2:
    begin
      Result := SysUtils.StrToFloatDef(string(AArgs[0]), Extended(AArgs[1]));
    end;
    3:
    begin
      Result := SysUtils.StrToFloatDef(string(AArgs[0]), Extended(AArgs[1]), 
        TFormatSettings_sw.FromVar(AArgs[2]));
    end;
  else
    WrongArgCountError('StrToFloatDef');
  end;
end;

function SysUtils_TryStrToFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Extended;
  v_2: Extended;
begin
  // procedure/function TryStrToFloat(...); overload;

  case AArgsSize of
    2:
    begin
      Result := SysUtils.TryStrToFloat(string(AArgs[0]), v_1);
      AssignRefParam(AArgs[1], v_1);
    end;
    3:
    begin
      Result := SysUtils.TryStrToFloat(string(AArgs[0]), v_2, 
        TFormatSettings_sw.FromVar(AArgs[2]));
      AssignRefParam(AArgs[1], v_2);
    end;
  else
    WrongArgCountError('TryStrToFloat');
  end;
end;

function SysUtils_StrToCurr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StrToCurr(...); overload;

  case AArgsSize of
    1:
    begin
      Result := SysUtils.StrToCurr(string(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.StrToCurr(string(AArgs[0]), TFormatSettings_sw.FromVar(
        AArgs[1]));
    end;
  else
    WrongArgCountError('StrToCurr');
  end;
end;

function SysUtils_StrToCurrDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StrToCurrDef(...); overload;

  case AArgsSize of
    2:
    begin
      Result := SysUtils.StrToCurrDef(string(AArgs[0]), Currency(AArgs[1]));
    end;
    3:
    begin
      Result := SysUtils.StrToCurrDef(string(AArgs[0]), Currency(AArgs[1]), 
        TFormatSettings_sw.FromVar(AArgs[2]));
    end;
  else
    WrongArgCountError('StrToCurrDef');
  end;
end;

function SysUtils_TryStrToCurr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Currency;
  v_2: Currency;
begin
  // procedure/function TryStrToCurr(...); overload;

  case AArgsSize of
    2:
    begin
      Result := SysUtils.TryStrToCurr(string(AArgs[0]), v_1);
      AssignRefParam(AArgs[1], v_1);
    end;
    3:
    begin
      Result := SysUtils.TryStrToCurr(string(AArgs[0]), v_2, TFormatSettings_sw.
        FromVar(AArgs[2]));
      AssignRefParam(AArgs[1], v_2);
    end;
  else
    WrongArgCountError('TryStrToCurr');
  end;
end;

function SysUtils_DateTimeToTimeStamp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DateTimeToTimeStamp(DateTime: TDateTime): TTimeS...

  Result := TTimeStamp_sw.ToVar(SysUtils.DateTimeToTimeStamp(TDateTime_sw.
    FromVar(AArgs[0])));
end;

function SysUtils_TimeStampToDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TimeStampToDateTime(const TimeStamp: TTimeStamp)...

  Result := TDateTime_sw.ToVar(SysUtils.TimeStampToDateTime(TTimeStamp_sw.
    FromVar(AArgs[0])));
end;

function SysUtils_MSecsToTimeStamp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MSecsToTimeStamp(MSecs: Comp): TTimeStamp;

  Result := TTimeStamp_sw.ToVar(SysUtils.MSecsToTimeStamp(Comp(AArgs[0])));
end;

function SysUtils_TimeStampToMSecs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TimeStampToMSecs(const TimeStamp: TTimeStamp): C...

  Result := SysUtils.TimeStampToMSecs(TTimeStamp_sw.FromVar(AArgs[0]));
end;

function SysUtils_EncodeDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function EncodeDate(Year: Word; Month: Word; Day: Word): ...

  Result := TDateTime_sw.ToVar(SysUtils.EncodeDate(Word(AArgs[0]), Word(
    AArgs[1]), Word(AArgs[2])));
end;

function SysUtils_EncodeTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function EncodeTime(Hour: Word; Min: Word; Sec: Word; MSe...

  Result := TDateTime_sw.ToVar(SysUtils.EncodeTime(Word(AArgs[0]), Word(
    AArgs[1]), Word(AArgs[2]), Word(AArgs[3])));
end;

function SysUtils_TryEncodeDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TDateTime;
begin
  // function TryEncodeDate(Year: Word; Month: Word; Day: Word...

  Result := SysUtils.TryEncodeDate(Word(AArgs[0]), Word(AArgs[1]), Word(
    AArgs[2]), v_1);
  AssignRefParam(AArgs[3], TDateTime_sw.ToVar(v_1));
end;

function SysUtils_TryEncodeTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TDateTime;
begin
  // function TryEncodeTime(Hour: Word; Min: Word; Sec: Word; ...

  Result := SysUtils.TryEncodeTime(Word(AArgs[0]), Word(AArgs[1]), Word(
    AArgs[2]), Word(AArgs[3]), v_1);
  AssignRefParam(AArgs[4], TDateTime_sw.ToVar(v_1));
end;

function SysUtils_DecodeDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Word;
  v_2: Word;
  v_3: Word;
begin
  // procedure DecodeDate(const DateTime: TDateTime; var Year:...

  v_1 := Word(AArgs[1]);
  v_2 := Word(AArgs[2]);
  v_3 := Word(AArgs[3]);
  SysUtils.DecodeDate(TDateTime_sw.FromVar(AArgs[0]), v_1, v_2, v_3);
  AssignRefParam(AArgs[1], v_1);
  AssignRefParam(AArgs[2], v_2);
  AssignRefParam(AArgs[3], v_3);
end;

function SysUtils_DecodeDateFully_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Word;
  v_2: Word;
  v_3: Word;
  v_4: Word;
begin
  // function DecodeDateFully(const DateTime: TDateTime; var Y...

  v_1 := Word(AArgs[1]);
  v_2 := Word(AArgs[2]);
  v_3 := Word(AArgs[3]);
  v_4 := Word(AArgs[4]);
  Result := SysUtils.DecodeDateFully(TDateTime_sw.FromVar(AArgs[0]), v_1, v_2, 
    v_3, v_4);
  AssignRefParam(AArgs[1], v_1);
  AssignRefParam(AArgs[2], v_2);
  AssignRefParam(AArgs[3], v_3);
  AssignRefParam(AArgs[4], v_4);
end;

function SysUtils_DecodeTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Word;
  v_2: Word;
  v_3: Word;
  v_4: Word;
begin
  // procedure DecodeTime(const DateTime: TDateTime; var Hour:...

  v_1 := Word(AArgs[1]);
  v_2 := Word(AArgs[2]);
  v_3 := Word(AArgs[3]);
  v_4 := Word(AArgs[4]);
  SysUtils.DecodeTime(TDateTime_sw.FromVar(AArgs[0]), v_1, v_2, v_3, v_4);
  AssignRefParam(AArgs[1], v_1);
  AssignRefParam(AArgs[2], v_2);
  AssignRefParam(AArgs[3], v_3);
  AssignRefParam(AArgs[4], v_4);
end;

function SysUtils_DateTimeToSystemTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TSystemTime;
begin
  // procedure DateTimeToSystemTime(const DateTime: TDateTime;...

  v_1 := TSystemTime_sw.FromVar(AArgs[1]);
  SysUtils.DateTimeToSystemTime(TDateTime_sw.FromVar(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TSystemTime_sw.ToVar(v_1));
end;

function SysUtils_SystemTimeToDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SystemTimeToDateTime(const SystemTime: TSystemTi...

  Result := TDateTime_sw.ToVar(SysUtils.SystemTimeToDateTime(TSystemTime_sw.
    FromVar(AArgs[0])));
end;

function SysUtils_DayOfWeek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DayOfWeek(const DateTime: TDateTime): Word;

  Result := SysUtils.DayOfWeek(TDateTime_sw.FromVar(AArgs[0]));
end;

function SysUtils_Date_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Date: TDateTime;

  Result := TDateTime_sw.ToVar(SysUtils.Date());
end;

function SysUtils_Time_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Time: TDateTime;

  Result := TDateTime_sw.ToVar(SysUtils.Time());
end;

function SysUtils_GetTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetTime: TDateTime;

  Result := TDateTime_sw.ToVar(SysUtils.GetTime());
end;

function SysUtils_Now_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Now: TDateTime;

  Result := TDateTime_sw.ToVar(SysUtils.Now());
end;

function SysUtils_CurrentYear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CurrentYear: Word;

  Result := SysUtils.CurrentYear();
end;

function SysUtils_IncMonth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IncMonth(const DateTime: TDateTime; NumberOfMont...

  case AArgsSize of
    1:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.IncMonth(TDateTime_sw.FromVar(
        AArgs[0])));
    end;
    2:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.IncMonth(TDateTime_sw.FromVar(
        AArgs[0]), Integer(AArgs[1])));
    end;
  else
    WrongArgCountError('IncMonth');
  end;
end;

function SysUtils_IncAMonth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Word;
  v_2: Word;
  v_3: Word;
begin
  // procedure IncAMonth(var Year: Word; var Month: Word; var ...

  case AArgsSize of
    3:
    begin
      v_1 := Word(AArgs[0]);
      v_2 := Word(AArgs[1]);
      v_3 := Word(AArgs[2]);
      SysUtils.IncAMonth(v_1, v_2, v_3);
      AssignRefParam(AArgs[0], v_1);
      AssignRefParam(AArgs[1], v_2);
      AssignRefParam(AArgs[2], v_3);
    end;
    4:
    begin
      v_1 := Word(AArgs[0]);
      v_2 := Word(AArgs[1]);
      v_3 := Word(AArgs[2]);
      SysUtils.IncAMonth(v_1, v_2, v_3, Integer(AArgs[3]));
      AssignRefParam(AArgs[0], v_1);
      AssignRefParam(AArgs[1], v_2);
      AssignRefParam(AArgs[2], v_3);
    end;
  else
    WrongArgCountError('IncAMonth');
  end;
end;

function SysUtils_ReplaceTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TDateTime;
begin
  // procedure ReplaceTime(var DateTime: TDateTime; const NewT...

  v_1 := TDateTime_sw.FromVar(AArgs[0]);
  SysUtils.ReplaceTime(v_1, TDateTime_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], TDateTime_sw.ToVar(v_1));
end;

function SysUtils_ReplaceDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TDateTime;
begin
  // procedure ReplaceDate(var DateTime: TDateTime; const NewD...

  v_1 := TDateTime_sw.FromVar(AArgs[0]);
  SysUtils.ReplaceDate(v_1, TDateTime_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], TDateTime_sw.ToVar(v_1));
end;

function SysUtils_IsLeapYear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsLeapYear(Year: Word): Boolean;

  Result := SysUtils.IsLeapYear(Word(AArgs[0]));
end;

function SysUtils_DateToStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function DateToStr(...); overload;

  case AArgsSize of
    1:
    begin
      Result := SysUtils.DateToStr(TDateTime_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.DateToStr(TDateTime_sw.FromVar(AArgs[0]), 
        TFormatSettings_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('DateToStr');
  end;
end;

function SysUtils_TimeToStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function TimeToStr(...); overload;

  case AArgsSize of
    1:
    begin
      Result := SysUtils.TimeToStr(TDateTime_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.TimeToStr(TDateTime_sw.FromVar(AArgs[0]), 
        TFormatSettings_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('TimeToStr');
  end;
end;

function SysUtils_DateTimeToStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function DateTimeToStr(...); overload;

  case AArgsSize of
    1:
    begin
      Result := SysUtils.DateTimeToStr(TDateTime_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.DateTimeToStr(TDateTime_sw.FromVar(AArgs[0]), 
        TFormatSettings_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('DateTimeToStr');
  end;
end;

function SysUtils_StrToDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StrToDate(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.StrToDate(string(AArgs[0])));
    end;
    2:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.StrToDate(string(AArgs[0]), 
        TFormatSettings_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('StrToDate');
  end;
end;

function SysUtils_StrToDateDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StrToDateDef(...); overload;

  case AArgsSize of
    2:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.StrToDateDef(string(AArgs[0]), 
        TDateTime_sw.FromVar(AArgs[1])));
    end;
    3:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.StrToDateDef(string(AArgs[0]), 
        TDateTime_sw.FromVar(AArgs[1]), TFormatSettings_sw.FromVar(AArgs[2])));
    end;
  else
    WrongArgCountError('StrToDateDef');
  end;
end;

function SysUtils_TryStrToDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TDateTime;
  v_2: TDateTime;
begin
  // procedure/function TryStrToDate(...); overload;

  case AArgsSize of
    2:
    begin
      Result := SysUtils.TryStrToDate(string(AArgs[0]), v_1);
      AssignRefParam(AArgs[1], TDateTime_sw.ToVar(v_1));
    end;
    3:
    begin
      Result := SysUtils.TryStrToDate(string(AArgs[0]), v_2, TFormatSettings_sw.
        FromVar(AArgs[2]));
      AssignRefParam(AArgs[1], TDateTime_sw.ToVar(v_2));
    end;
  else
    WrongArgCountError('TryStrToDate');
  end;
end;

function SysUtils_StrToTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StrToTime(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.StrToTime(string(AArgs[0])));
    end;
    2:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.StrToTime(string(AArgs[0]), 
        TFormatSettings_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('StrToTime');
  end;
end;

function SysUtils_StrToTimeDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StrToTimeDef(...); overload;

  case AArgsSize of
    2:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.StrToTimeDef(string(AArgs[0]), 
        TDateTime_sw.FromVar(AArgs[1])));
    end;
    3:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.StrToTimeDef(string(AArgs[0]), 
        TDateTime_sw.FromVar(AArgs[1]), TFormatSettings_sw.FromVar(AArgs[2])));
    end;
  else
    WrongArgCountError('StrToTimeDef');
  end;
end;

function SysUtils_TryStrToTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TDateTime;
  v_2: TDateTime;
begin
  // procedure/function TryStrToTime(...); overload;

  case AArgsSize of
    2:
    begin
      Result := SysUtils.TryStrToTime(string(AArgs[0]), v_1);
      AssignRefParam(AArgs[1], TDateTime_sw.ToVar(v_1));
    end;
    3:
    begin
      Result := SysUtils.TryStrToTime(string(AArgs[0]), v_2, TFormatSettings_sw.
        FromVar(AArgs[2]));
      AssignRefParam(AArgs[1], TDateTime_sw.ToVar(v_2));
    end;
  else
    WrongArgCountError('TryStrToTime');
  end;
end;

function SysUtils_StrToDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StrToDateTime(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.StrToDateTime(string(AArgs[0])));
    end;
    2:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.StrToDateTime(string(AArgs[0]), 
        TFormatSettings_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('StrToDateTime');
  end;
end;

function SysUtils_StrToDateTimeDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StrToDateTimeDef(...); overload;

  case AArgsSize of
    2:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.StrToDateTimeDef(string(AArgs[0]), 
        TDateTime_sw.FromVar(AArgs[1])));
    end;
    3:
    begin
      Result := TDateTime_sw.ToVar(SysUtils.StrToDateTimeDef(string(AArgs[0]), 
        TDateTime_sw.FromVar(AArgs[1]), TFormatSettings_sw.FromVar(AArgs[2])));
    end;
  else
    WrongArgCountError('StrToDateTimeDef');
  end;
end;

function SysUtils_TryStrToDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TDateTime;
  v_2: TDateTime;
begin
  // procedure/function TryStrToDateTime(...); overload;

  case AArgsSize of
    2:
    begin
      Result := SysUtils.TryStrToDateTime(string(AArgs[0]), v_1);
      AssignRefParam(AArgs[1], TDateTime_sw.ToVar(v_1));
    end;
    3:
    begin
      Result := SysUtils.TryStrToDateTime(string(AArgs[0]), v_2, 
        TFormatSettings_sw.FromVar(AArgs[2]));
      AssignRefParam(AArgs[1], TDateTime_sw.ToVar(v_2));
    end;
  else
    WrongArgCountError('TryStrToDateTime');
  end;
end;

function SysUtils_FormatDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FormatDateTime(...); overload;

  case AArgsSize of
    2:
    begin
      Result := SysUtils.FormatDateTime(string(AArgs[0]), TDateTime_sw.FromVar(
        AArgs[1]));
    end;
    3:
    begin
      Result := SysUtils.FormatDateTime(string(AArgs[0]), TDateTime_sw.FromVar(
        AArgs[1]), TFormatSettings_sw.FromVar(AArgs[2]));
    end;
  else
    WrongArgCountError('FormatDateTime');
  end;
end;

function SysUtils_DateTimeToString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
  v_2: string;
begin
  // procedure/function DateTimeToString(...); overload;

  case AArgsSize of
    3:
    begin
      v_1 := string(AArgs[0]);
      SysUtils.DateTimeToString(v_1, string(AArgs[1]), TDateTime_sw.FromVar(
        AArgs[2]));
      AssignRefParam(AArgs[0], v_1);
    end;
    4:
    begin
      v_2 := string(AArgs[0]);
      SysUtils.DateTimeToString(v_2, string(AArgs[1]), TDateTime_sw.FromVar(
        AArgs[2]), TFormatSettings_sw.FromVar(AArgs[3]));
      AssignRefParam(AArgs[0], v_2);
    end;
  else
    WrongArgCountError('DateTimeToString');
  end;
end;

function SysUtils_MinDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MinDateTime: TDateTime = <value>;

  Result := TDateTime_sw.ToVar(MinDateTime);
end;

function SysUtils_MaxDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MaxDateTime: TDateTime = <value>;

  Result := TDateTime_sw.ToVar(MaxDateTime);
end;

function SysUtils_FloatToDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FloatToDateTime(const Value: Extended): TDateTime;

  Result := TDateTime_sw.ToVar(SysUtils.FloatToDateTime(Extended(AArgs[0])));
end;

function SysUtils_TryFloatToDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TDateTime;
begin
  // function TryFloatToDateTime(const Value: Extended; out AR...

  Result := SysUtils.TryFloatToDateTime(Extended(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TDateTime_sw.ToVar(v_1));
end;

function SysUtils_SysErrorMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SysErrorMessage(ErrorCode: Integer): string;

  Result := SysUtils.SysErrorMessage(Integer(AArgs[0]));
end;

function SysUtils_GetLocaleStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetLocaleStr(Locale: Integer; LocaleType: Intege...

  Result := SysUtils.GetLocaleStr(Integer(AArgs[0]), Integer(AArgs[1]), string(
    AArgs[2]));
end;

function SysUtils_GetLocaleChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetLocaleChar(Locale: Integer; LocaleType: Integ...

  Result := SysUtils.GetLocaleChar(Integer(AArgs[0]), Integer(AArgs[1]), Char(
    Integer(AArgs[2])));
end;

function SysUtils_GetFormatSettings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetFormatSettings;

  SysUtils.GetFormatSettings();
end;

function SysUtils_GetLocaleFormatSettings_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TFormatSettings;
begin
  // procedure GetLocaleFormatSettings(LCID: Integer; var Form...

  v_1 := TFormatSettings_sw.FromVar(AArgs[1]);
  SysUtils.GetLocaleFormatSettings(Integer(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TFormatSettings_sw.ToVar(v_1));
end;

function SysUtils_Sleep_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Sleep(milliseconds: Cardinal);

  SysUtils.Sleep(Cardinal(AArgs[0]));
end;

function SysUtils_GetModuleName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetModuleName(Module: HMODULE): string;

  Result := SysUtils.GetModuleName(HMODULE_sw.FromVar(AArgs[0]));
end;

function SysUtils_Abort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Abort;

  SysUtils.Abort();
end;

function SysUtils_OutOfMemoryError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure OutOfMemoryError;

  SysUtils.OutOfMemoryError();
end;

function SysUtils_Beep_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Beep;

  SysUtils.Beep();
end;

function SysUtils_ByteType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ByteType(const S: string; Index: Integer): TMbcs...

  Result := TMbcsByteType_sw.ToVar(SysUtils.ByteType(string(AArgs[0]), Integer(
    AArgs[1])));
end;

function SysUtils_ByteToCharLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ByteToCharLen(const S: string; MaxLen: Integer):...

  Result := SysUtils.ByteToCharLen(string(AArgs[0]), Integer(AArgs[1]));
end;

function SysUtils_CharToByteLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CharToByteLen(const S: string; MaxLen: Integer):...

  Result := SysUtils.CharToByteLen(string(AArgs[0]), Integer(AArgs[1]));
end;

function SysUtils_ByteToCharIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ByteToCharIndex(const S: string; Index: Integer)...

  Result := SysUtils.ByteToCharIndex(string(AArgs[0]), Integer(AArgs[1]));
end;

function SysUtils_CharToByteIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CharToByteIndex(const S: string; Index: Integer)...

  Result := SysUtils.CharToByteIndex(string(AArgs[0]), Integer(AArgs[1]));
end;

function SysUtils_CharLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CharLength(const S: string; Index: Integer): Int...

  Result := SysUtils.CharLength(string(AArgs[0]), Integer(AArgs[1]));
end;

function SysUtils_NextCharIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function NextCharIndex(const S: string; Index: Integer): ...

  Result := SysUtils.NextCharIndex(string(AArgs[0]), Integer(AArgs[1]));
end;

function SysUtils_IsPathDelimiter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsPathDelimiter(const S: string; Index: Integer)...

  Result := SysUtils.IsPathDelimiter(string(AArgs[0]), Integer(AArgs[1]));
end;

function SysUtils_IsDelimiter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsDelimiter(const Delimiters: string; const S: s...

  Result := SysUtils.IsDelimiter(string(AArgs[0]), string(AArgs[1]), Integer(
    AArgs[2]));
end;

function SysUtils_IncludeTrailingPathDelimiter_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IncludeTrailingPathDelimiter(const S: string): s...

  Result := SysUtils.IncludeTrailingPathDelimiter(string(AArgs[0]));
end;

function SysUtils_IncludeTrailingBackslash_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IncludeTrailingBackslash(const S: string): string;

  Result := SysUtils.IncludeTrailingBackslash(string(AArgs[0]));
end;

function SysUtils_ExcludeTrailingPathDelimiter_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExcludeTrailingPathDelimiter(const S: string): s...

  Result := SysUtils.ExcludeTrailingPathDelimiter(string(AArgs[0]));
end;

function SysUtils_ExcludeTrailingBackslash_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExcludeTrailingBackslash(const S: string): string;

  Result := SysUtils.ExcludeTrailingBackslash(string(AArgs[0]));
end;

function SysUtils_LastDelimiter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function LastDelimiter(const Delimiters: string; const S:...

  Result := SysUtils.LastDelimiter(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_AnsiCompareFileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiCompareFileName(const S1: string; const S2: ...

  Result := SysUtils.AnsiCompareFileName(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_SameFileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SameFileName(const S1: string; const S2: string)...

  Result := SysUtils.SameFileName(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_AnsiLowerCaseFileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiLowerCaseFileName(const S: string): string;

  Result := SysUtils.AnsiLowerCaseFileName(string(AArgs[0]));
end;

function SysUtils_AnsiUpperCaseFileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiUpperCaseFileName(const S: string): string;

  Result := SysUtils.AnsiUpperCaseFileName(string(AArgs[0]));
end;

function SysUtils_AnsiPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiPos(const Substr: string; const S: string): ...

  Result := SysUtils.AnsiPos(string(AArgs[0]), string(AArgs[1]));
end;

function SysUtils_WrapText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function WrapText(...); overload;

  case AArgsSize of
    4:
    begin
      Result := SysUtils.WrapText(string(AArgs[0]), string(AArgs[1]), 
        TSysCharSet_sw.FromVar(AArgs[2]), Integer(AArgs[3]));
    end;
    1:
    begin
      Result := SysUtils.WrapText(string(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.WrapText(string(AArgs[0]), Integer(AArgs[1]));
    end;
  else
    WrongArgCountError('WrapText');
  end;
end;

function SysUtils_SwitchChars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SwitchChars = <value>;

  Result := LMDSetToVar(SizeOf(SwitchChars), SwitchChars);
end;

function SysUtils_FindCmdLineSwitch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FindCmdLineSwitch(...); overload;

  case AArgsSize of
    3:
    begin
      Result := SysUtils.FindCmdLineSwitch(string(AArgs[0]), TSysCharSet_sw.
        FromVar(AArgs[1]), Boolean(AArgs[2]));
    end;
    1:
    begin
      Result := SysUtils.FindCmdLineSwitch(string(AArgs[0]));
    end;
    2:
    begin
      Result := SysUtils.FindCmdLineSwitch(string(AArgs[0]), Boolean(AArgs[1]));
    end;
  else
    WrongArgCountError('FindCmdLineSwitch');
  end;
end;

function SysUtils_Supports_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Supports(...); overload;

  Result := SysUtils.Supports(TClass_sw.FromVar(AArgs[0]), TGUID_sw.FromVar(
    AArgs[1]));
end;

function SysUtils_CreateGUID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TGUID;
begin
  // function CreateGUID(out Guid: TGUID): HResult;

  Result := HResult_sw.ToVar(SysUtils.CreateGUID(v_1));
  AssignRefParam(AArgs[0], TGUID_sw.ToVar(v_1));
end;

function SysUtils_StringToGUID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StringToGUID(const S: string): TGUID;

  Result := TGUID_sw.ToVar(SysUtils.StringToGUID(string(AArgs[0])));
end;

function SysUtils_GUIDToString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GUIDToString(const GUID: TGUID): string;

  Result := SysUtils.GUIDToString(TGUID_sw.FromVar(AArgs[0]));
end;

function SysUtils_IsEqualGUID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsEqualGUID(const guid1: TGUID; const guid2: TGU...

  Result := SysUtils.IsEqualGUID(TGUID_sw.FromVar(AArgs[0]), TGUID_sw.FromVar(
    AArgs[1]));
end;

function SysUtils_pfNeverBuild_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfNeverBuild = <value>;

  Result := pfNeverBuild;
end;

function SysUtils_pfDesignOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfDesignOnly = <value>;

  Result := pfDesignOnly;
end;

function SysUtils_pfRunOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfRunOnly = <value>;

  Result := pfRunOnly;
end;

function SysUtils_pfIgnoreDupUnits_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfIgnoreDupUnits = <value>;

  Result := pfIgnoreDupUnits;
end;

function SysUtils_pfModuleTypeMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfModuleTypeMask = <value>;

  Result := pfModuleTypeMask;
end;

function SysUtils_pfExeModule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfExeModule = <value>;

  Result := pfExeModule;
end;

function SysUtils_pfPackageModule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfPackageModule = <value>;

  Result := pfPackageModule;
end;

function SysUtils_pfProducerMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfProducerMask = <value>;

  Result := pfProducerMask;
end;

function SysUtils_pfV3Produced_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfV3Produced = <value>;

  Result := pfV3Produced;
end;

function SysUtils_pfProducerUndefined_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfProducerUndefined = <value>;

  Result := pfProducerUndefined;
end;

function SysUtils_pfBCB4Produced_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfBCB4Produced = <value>;

  Result := pfBCB4Produced;
end;

function SysUtils_pfDelphi4Produced_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfDelphi4Produced = <value>;

  Result := pfDelphi4Produced;
end;

function SysUtils_pfLibraryModule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pfLibraryModule = <value>;

  Result := pfLibraryModule;
end;

function SysUtils_ufMainUnit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ufMainUnit = <value>;

  Result := ufMainUnit;
end;

function SysUtils_ufPackageUnit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ufPackageUnit = <value>;

  Result := ufPackageUnit;
end;

function SysUtils_ufWeakUnit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ufWeakUnit = <value>;

  Result := ufWeakUnit;
end;

function SysUtils_ufOrgWeakUnit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ufOrgWeakUnit = <value>;

  Result := ufOrgWeakUnit;
end;

function SysUtils_ufImplicitUnit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ufImplicitUnit = <value>;

  Result := ufImplicitUnit;
end;

function SysUtils_ufWeakPackageUnit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ufWeakPackageUnit = <value>;

  Result := ufWeakPackageUnit;
end;

function SysUtils_TNameType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNameType = (ntContainsUnit, ntRequiresPackage, ntDc...

  Result := TLMDUnitWrapper.TypeToVar(TNameType_sw);
end;

function SysUtils_LoadPackage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function LoadPackage(const Name: string): HMODULE;

  Result := HMODULE_sw.ToVar(SysUtils.LoadPackage(string(AArgs[0])));
end;

function SysUtils_UnloadPackage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnloadPackage(Module: HMODULE);

  SysUtils.UnloadPackage(HMODULE_sw.FromVar(AArgs[0]));
end;

function SysUtils_InitializePackage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InitializePackage(Module: HMODULE);

  SysUtils.InitializePackage(HMODULE_sw.FromVar(AArgs[0]));
end;

function SysUtils_FinalizePackage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FinalizePackage(Module: HMODULE);

  SysUtils.FinalizePackage(HMODULE_sw.FromVar(AArgs[0]));
end;

function SysUtils_RaiseLastOSError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RaiseLastOSError;

  SysUtils.RaiseLastOSError();
end;

function SysUtils_RaiseLastWin32Error_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RaiseLastWin32Error;

  SysUtils.RaiseLastWin32Error();
end;

function SysUtils_Win32Check_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Win32Check(RetVal: BOOL): BOOL;

  Result := BOOL_sw.ToVar(SysUtils.Win32Check(BOOL_sw.FromVar(AArgs[0])));
end;

function SysUtils_CallTerminateProcs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CallTerminateProcs: Boolean;

  Result := SysUtils.CallTerminateProcs();
end;

function SysUtils_GDAL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GDAL: LongWord;

  Result := SysUtils.GDAL();
end;

function SysUtils_RCS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RCS;

  SysUtils.RCS();
end;

function SysUtils_RPR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RPR;

  SysUtils.RPR();
end;

function SysUtils_HexDisplayPrefix_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HexDisplayPrefix: string;

  if IsGet then
    Result := SysUtils.HexDisplayPrefix
  else
    SysUtils.HexDisplayPrefix := string(AArgs[0]);
end;

function SysUtils_SafeLoadLibrary_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SafeLoadLibrary(const FileName: string; ErrorMod...

  case AArgsSize of
    1:
    begin
      Result := HMODULE_sw.ToVar(SysUtils.SafeLoadLibrary(string(AArgs[0])));
    end;
    2:
    begin
      Result := HMODULE_sw.ToVar(SysUtils.SafeLoadLibrary(string(AArgs[0]), 
        UINT_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('SafeLoadLibrary');
  end;
end;

function SysUtils_TSimpleRWSync_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSimpleRWSync = class(TInterfacedObject);

  Result := TLMDUnitWrapper.TypeToVar(TSimpleRWSync_sw);
end;

function SysUtils_TThreadInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TThreadInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TThreadInfo_sw);
end;

function SysUtils_TThreadLocalCounter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TThreadLocalCounter = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TThreadLocalCounter_sw);
end;

function SysUtils_TMultiReadExclusiveWriteSynchronizer_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMultiReadExclusiveWriteSynchronizer = class(TInterf...

  Result := TLMDUnitWrapper.TypeToVar(TMultiReadExclusiveWriteSynchronizer_sw);
end;

function SysUtils_TMREWSync_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMREWSync = TMultiReadExclusiveWriteSynchronizer;

  Result := TLMDUnitWrapper.TypeToVar(TMREWSync_sw);
end;

function SysUtils_GetEnvironmentVariable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function GetEnvironmentVariable(...); overload;

  Result := SysUtils.GetEnvironmentVariable(string(AArgs[0]));
end;

class function SysUtils_sw.GetUnitName: WideString;
begin
  Result := 'SysUtils';
end;

class procedure SysUtils_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('fmOpenRead', SysUtils_fmOpenRead_si, nil, VarType(SysUtils.fmOpenRead));
  AData.AddConstant('fmOpenWrite', SysUtils_fmOpenWrite_si, nil, VarType(SysUtils.fmOpenWrite));
  AData.AddConstant('fmOpenReadWrite', SysUtils_fmOpenReadWrite_si, nil, VarType(SysUtils.fmOpenReadWrite));
  AData.AddConstant('fmShareCompat', SysUtils_fmShareCompat_si, nil, VarType(SysUtils.fmShareCompat));
  AData.AddConstant('fmShareExclusive', SysUtils_fmShareExclusive_si, nil, VarType(SysUtils.fmShareExclusive));
  AData.AddConstant('fmShareDenyWrite', SysUtils_fmShareDenyWrite_si, nil, VarType(SysUtils.fmShareDenyWrite));
  AData.AddConstant('fmShareDenyRead', SysUtils_fmShareDenyRead_si, nil, VarType(SysUtils.fmShareDenyRead));
  AData.AddConstant('fmShareDenyNone', SysUtils_fmShareDenyNone_si, nil, VarType(SysUtils.fmShareDenyNone));
  AData.AddConstant('faReadOnly', SysUtils_faReadOnly_si, nil, VarType(SysUtils.faReadOnly));
  AData.AddConstant('faHidden', SysUtils_faHidden_si, nil, VarType(SysUtils.faHidden));
  AData.AddConstant('faSysFile', SysUtils_faSysFile_si, nil, VarType(SysUtils.faSysFile));
  AData.AddConstant('faVolumeID', SysUtils_faVolumeID_si, nil, VarType(SysUtils.faVolumeID));
  AData.AddConstant('faDirectory', SysUtils_faDirectory_si, nil, VarType(SysUtils.faDirectory));
  AData.AddConstant('faArchive', SysUtils_faArchive_si, nil, VarType(SysUtils.faArchive));
  AData.AddConstant('faSymLink', SysUtils_faSymLink_si, nil, VarType(SysUtils.faSymLink));
  AData.AddConstant('faAnyFile', SysUtils_faAnyFile_si, nil, VarType(SysUtils.faAnyFile));
  AData.AddConstant('HoursPerDay', SysUtils_HoursPerDay_si, nil, VarType(SysUtils.HoursPerDay));
  AData.AddConstant('MinsPerHour', SysUtils_MinsPerHour_si, nil, VarType(SysUtils.MinsPerHour));
  AData.AddConstant('SecsPerMin', SysUtils_SecsPerMin_si, nil, VarType(SysUtils.SecsPerMin));
  AData.AddConstant('MSecsPerSec', SysUtils_MSecsPerSec_si, nil, VarType(SysUtils.MSecsPerSec));
  AData.AddConstant('MinsPerDay', SysUtils_MinsPerDay_si, nil, VarType(SysUtils.MinsPerDay));
  AData.AddConstant('SecsPerDay', SysUtils_SecsPerDay_si, nil, VarType(SysUtils.SecsPerDay));
  AData.AddConstant('MSecsPerDay', SysUtils_MSecsPerDay_si, nil, VarType(SysUtils.MSecsPerDay));
  AData.AddConstant('DateDelta', SysUtils_DateDelta_si, nil, VarType(SysUtils.DateDelta));
  AData.AddConstant('UnixDateDelta', SysUtils_UnixDateDelta_si, nil, VarType(SysUtils.UnixDateDelta));
  AData.AddType(TSysCharSet_sw, SysUtils_TSysCharSet_si);
  AData.AddType(WordRec_sw, SysUtils_WordRec_si);
  AData.AddType(LongRec_sw, SysUtils_LongRec_si);
  AData.AddType(Int64Rec_sw, SysUtils_Int64Rec_si);
  AData.AddType(TFileName_sw, SysUtils_TFileName_si);
  AData.AddType(TSearchRec_sw, SysUtils_TSearchRec_si);
  AData.AddType(TFloatValue_sw, SysUtils_TFloatValue_si);
  AData.AddType(TFloatFormat_sw, SysUtils_TFloatFormat_si);
  AData.AddType(TFloatRec_sw, SysUtils_TFloatRec_si);
  AData.AddType(TTimeStamp_sw, SysUtils_TTimeStamp_si);
  AData.AddType(TMbcsByteType_sw, SysUtils_TMbcsByteType_si);
  AData.AddType(TSysLocale_sw, SysUtils_TSysLocale_si);
  AData.AddType(TLangRec_sw, SysUtils_TLangRec_si);
  AData.AddType(TLanguages_sw, SysUtils_TLanguages_si);
  AData.AddType(Exception_sw, SysUtils_Exception_si);
  AData.AddType(ExceptClass_sw, SysUtils_ExceptClass_si);
  AData.AddType(EAbort_sw, SysUtils_EAbort_si);
  AData.AddType(EHeapException_sw, SysUtils_EHeapException_si);
  AData.AddType(EOutOfMemory_sw, SysUtils_EOutOfMemory_si);
  AData.AddType(EInOutError_sw, SysUtils_EInOutError_si);
  AData.AddType(TExceptionRecord_sw, SysUtils_TExceptionRecord_si);
  AData.AddType(EExternal_sw, SysUtils_EExternal_si);
  AData.AddType(EExternalException_sw, SysUtils_EExternalException_si);
  AData.AddType(EIntError_sw, SysUtils_EIntError_si);
  AData.AddType(EDivByZero_sw, SysUtils_EDivByZero_si);
  AData.AddType(ERangeError_sw, SysUtils_ERangeError_si);
  AData.AddType(EIntOverflow_sw, SysUtils_EIntOverflow_si);
  AData.AddType(EMathError_sw, SysUtils_EMathError_si);
  AData.AddType(EInvalidOp_sw, SysUtils_EInvalidOp_si);
  AData.AddType(EZeroDivide_sw, SysUtils_EZeroDivide_si);
  AData.AddType(EOverflow_sw, SysUtils_EOverflow_si);
  AData.AddType(EUnderflow_sw, SysUtils_EUnderflow_si);
  AData.AddType(EInvalidPointer_sw, SysUtils_EInvalidPointer_si);
  AData.AddType(EInvalidCast_sw, SysUtils_EInvalidCast_si);
  AData.AddType(EConvertError_sw, SysUtils_EConvertError_si);
  AData.AddType(EAccessViolation_sw, SysUtils_EAccessViolation_si);
  AData.AddType(EPrivilege_sw, SysUtils_EPrivilege_si);
  AData.AddType(EStackOverflow_sw, SysUtils_EStackOverflow_si);
  AData.AddType(EControlC_sw, SysUtils_EControlC_si);
  AData.AddType(EVariantError_sw, SysUtils_EVariantError_si);
  AData.AddType(EPropReadOnly_sw, SysUtils_EPropReadOnly_si);
  AData.AddType(EPropWriteOnly_sw, SysUtils_EPropWriteOnly_si);
  AData.AddType(EAssertionFailed_sw, SysUtils_EAssertionFailed_si);
  AData.AddType(EAbstractError_sw, SysUtils_EAbstractError_si);
  AData.AddType(EIntfCastError_sw, SysUtils_EIntfCastError_si);
  AData.AddType(EInvalidContainer_sw, SysUtils_EInvalidContainer_si);
  AData.AddType(EInvalidInsert_sw, SysUtils_EInvalidInsert_si);
  AData.AddType(EPackageError_sw, SysUtils_EPackageError_si);
  AData.AddType(EOSError_sw, SysUtils_EOSError_si);
  AData.AddType(EWin32Error_sw, SysUtils_EWin32Error_si);
  AData.AddType(ESafecallException_sw, SysUtils_ESafecallException_si);
  AData.AddVariable('EmptyStr', SysUtils_EmptyStr_si, string_sw);
  AData.AddVariable('EmptyWideStr', SysUtils_EmptyWideStr_si, WideString_sw);
  AData.AddVariable('Win32Platform', SysUtils_Win32Platform_si, Integer_sw);
  AData.AddVariable('Win32MajorVersion', SysUtils_Win32MajorVersion_si, Integer_sw);
  AData.AddVariable('Win32MinorVersion', SysUtils_Win32MinorVersion_si, Integer_sw);
  AData.AddVariable('Win32BuildNumber', SysUtils_Win32BuildNumber_si, Integer_sw);
  AData.AddVariable('Win32CSDVersion', SysUtils_Win32CSDVersion_si, string_sw);
  AData.AddFunction('CheckWin32Version', SysUtils_CheckWin32Version_si, Boolean_sw, 1, True);
  AData.AddFunction('GetFileVersion', SysUtils_GetFileVersion_si, Cardinal_sw, 1, False);
  AData.AddVariable('CurrencyString', SysUtils_CurrencyString_si, string_sw);
  AData.AddVariable('CurrencyFormat', SysUtils_CurrencyFormat_si, Byte_sw);
  AData.AddVariable('NegCurrFormat', SysUtils_NegCurrFormat_si, Byte_sw);
  AData.AddVariable('ThousandSeparator', SysUtils_ThousandSeparator_si, Char_sw);
  AData.AddVariable('DecimalSeparator', SysUtils_DecimalSeparator_si, Char_sw);
  AData.AddVariable('CurrencyDecimals', SysUtils_CurrencyDecimals_si, Byte_sw);
  AData.AddVariable('DateSeparator', SysUtils_DateSeparator_si, Char_sw);
  AData.AddVariable('ShortDateFormat', SysUtils_ShortDateFormat_si, string_sw);
  AData.AddVariable('LongDateFormat', SysUtils_LongDateFormat_si, string_sw);
  AData.AddVariable('TimeSeparator', SysUtils_TimeSeparator_si, Char_sw);
  AData.AddVariable('TimeAMString', SysUtils_TimeAMString_si, string_sw);
  AData.AddVariable('TimePMString', SysUtils_TimePMString_si, string_sw);
  AData.AddVariable('ShortTimeFormat', SysUtils_ShortTimeFormat_si, string_sw);
  AData.AddVariable('LongTimeFormat', SysUtils_LongTimeFormat_si, string_sw);
  AData.AddVariable('SysLocale', SysUtils_SysLocale_si, TSysLocale_sw);
  AData.AddVariable('TwoDigitYearCenturyWindow', SysUtils_TwoDigitYearCenturyWindow_si, Word_sw);
  AData.AddVariable('ListSeparator', SysUtils_ListSeparator_si, Char_sw);
  AData.AddType(TFormatSettings_sw, SysUtils_TFormatSettings_si);
  AData.AddConstant('MaxEraCount', SysUtils_MaxEraCount_si, nil, VarType(SysUtils.MaxEraCount));
  AData.AddConstant('PathDelim', SysUtils_PathDelim_si, nil, VarType(SysUtils.PathDelim));
  AData.AddConstant('DriveDelim', SysUtils_DriveDelim_si, nil, VarType(SysUtils.DriveDelim));
  AData.AddConstant('PathSep', SysUtils_PathSep_si, nil, VarType(SysUtils.PathSep));
  AData.AddFunction('Languages', SysUtils_Languages_si, TLanguages_sw, 0, False);
  AData.AddProcedure('AppendStr', SysUtils_AppendStr_si, 2, False);
  AData.AddFunction('UpperCase', SysUtils_UpperCase_si, string_sw, 1, False);
  AData.AddFunction('LowerCase', SysUtils_LowerCase_si, string_sw, 1, False);
  AData.AddFunction('CompareStr', SysUtils_CompareStr_si, Integer_sw, 2, False);
  AData.AddFunction('CompareText', SysUtils_CompareText_si, Integer_sw, 2, False);
  AData.AddFunction('SameText', SysUtils_SameText_si, Boolean_sw, 2, False);
  AData.AddFunction('AnsiUpperCase', SysUtils_AnsiUpperCase_si, string_sw, 1, False);
  AData.AddFunction('AnsiLowerCase', SysUtils_AnsiLowerCase_si, string_sw, 1, False);
  AData.AddFunction('AnsiCompareStr', SysUtils_AnsiCompareStr_si, Integer_sw, 2, False);
  AData.AddFunction('AnsiSameStr', SysUtils_AnsiSameStr_si, Boolean_sw, 2, False);
  AData.AddFunction('AnsiCompareText', SysUtils_AnsiCompareText_si, Integer_sw, 2, False);
  AData.AddFunction('AnsiSameText', SysUtils_AnsiSameText_si, Boolean_sw, 2, False);
  AData.AddFunction('WideUpperCase', SysUtils_WideUpperCase_si, WideString_sw, 1, False);
  AData.AddFunction('WideLowerCase', SysUtils_WideLowerCase_si, WideString_sw, 1, False);
  AData.AddFunction('WideCompareStr', SysUtils_WideCompareStr_si, Integer_sw, 2, False);
  AData.AddFunction('WideSameStr', SysUtils_WideSameStr_si, Boolean_sw, 2, False);
  AData.AddFunction('WideCompareText', SysUtils_WideCompareText_si, Integer_sw, 2, False);
  AData.AddFunction('WideSameText', SysUtils_WideSameText_si, Boolean_sw, 2, False);
  AData.AddFunction('Trim', SysUtils_Trim_si, nil, 1, False);
  AData.AddFunction('TrimLeft', SysUtils_TrimLeft_si, nil, 1, False);
  AData.AddFunction('TrimRight', SysUtils_TrimRight_si, nil, 1, False);
  AData.AddFunction('QuotedStr', SysUtils_QuotedStr_si, string_sw, 1, False);
  AData.AddFunction('AnsiQuotedStr', SysUtils_AnsiQuotedStr_si, string_sw, 2, False);
  AData.AddFunction('AnsiDequotedStr', SysUtils_AnsiDequotedStr_si, string_sw, 2, False);
  AData.AddFunction('AdjustLineBreaks', SysUtils_AdjustLineBreaks_si, string_sw, 1, True);
  AData.AddFunction('IsValidIdent', SysUtils_IsValidIdent_si, Boolean_sw, 1, False);
  AData.AddFunction('IntToStr', SysUtils_IntToStr_si, nil, 1, False);
  AData.AddFunction('IntToHex', SysUtils_IntToHex_si, nil, 2, False);
  AData.AddFunction('StrToInt', SysUtils_StrToInt_si, Integer_sw, 1, False);
  AData.AddFunction('StrToIntDef', SysUtils_StrToIntDef_si, Integer_sw, 2, False);
  AData.AddFunction('TryStrToInt', SysUtils_TryStrToInt_si, Boolean_sw, 2, False);
  AData.AddFunction('StrToInt64', SysUtils_StrToInt64_si, Int64_sw, 1, False);
  AData.AddFunction('StrToInt64Def', SysUtils_StrToInt64Def_si, Int64_sw, 2, False);
  AData.AddFunction('TryStrToInt64', SysUtils_TryStrToInt64_si, Boolean_sw, 2, False);
  AData.AddConstant('DefaultTrueBoolStr', SysUtils_DefaultTrueBoolStr_si, nil, VarType(SysUtils.DefaultTrueBoolStr));
  AData.AddConstant('DefaultFalseBoolStr', SysUtils_DefaultFalseBoolStr_si, nil, VarType(SysUtils.DefaultFalseBoolStr));
  AData.AddFunction('StrToBool', SysUtils_StrToBool_si, Boolean_sw, 1, False);
  AData.AddFunction('StrToBoolDef', SysUtils_StrToBoolDef_si, Boolean_sw, 2, False);
  AData.AddFunction('TryStrToBool', SysUtils_TryStrToBool_si, Boolean_sw, 2, False);
  AData.AddFunction('BoolToStr', SysUtils_BoolToStr_si, string_sw, 1, True);
  AData.AddFunction('LoadStr', SysUtils_LoadStr_si, string_sw, 1, False);
  AData.AddFunction('FileOpen', SysUtils_FileOpen_si, Integer_sw, 2, False);
  AData.AddFunction('FileCreate', SysUtils_FileCreate_si, nil, 1, True);
  AData.AddFunction('FileSeek', SysUtils_FileSeek_si, nil, 3, False);
  AData.AddProcedure('FileClose', SysUtils_FileClose_si, 1, False);
  AData.AddFunction('FileAge', SysUtils_FileAge_si, Integer_sw, 1, False);
  AData.AddFunction('FileExists', SysUtils_FileExists_si, Boolean_sw, 1, False);
  AData.AddFunction('DirectoryExists', SysUtils_DirectoryExists_si, Boolean_sw, 1, False);
  AData.AddFunction('ForceDirectories', SysUtils_ForceDirectories_si, Boolean_sw, 1, False);
  AData.AddFunction('FindFirst', SysUtils_FindFirst_si, Integer_sw, 3, False);
  AData.AddFunction('FindNext', SysUtils_FindNext_si, Integer_sw, 1, False);
  AData.AddProcedure('FindClose', SysUtils_FindClose_si, 1, False);
  AData.AddFunction('FileGetDate', SysUtils_FileGetDate_si, Integer_sw, 1, False);
  AData.AddFunction('FileSetDate', SysUtils_FileSetDate_si, nil, 2, False);
  AData.AddFunction('FileGetAttr', SysUtils_FileGetAttr_si, Integer_sw, 1, False);
  AData.AddFunction('FileSetAttr', SysUtils_FileSetAttr_si, Integer_sw, 2, False);
  AData.AddFunction('FileIsReadOnly', SysUtils_FileIsReadOnly_si, Boolean_sw, 1, False);
  AData.AddFunction('FileSetReadOnly', SysUtils_FileSetReadOnly_si, Boolean_sw, 2, False);
  AData.AddFunction('DeleteFile', SysUtils_DeleteFile_si, Boolean_sw, 1, False);
  AData.AddFunction('RenameFile', SysUtils_RenameFile_si, Boolean_sw, 2, False);
  AData.AddFunction('ChangeFileExt', SysUtils_ChangeFileExt_si, string_sw, 2, False);
  AData.AddFunction('ExtractFilePath', SysUtils_ExtractFilePath_si, string_sw, 1, False);
  AData.AddFunction('ExtractFileDir', SysUtils_ExtractFileDir_si, string_sw, 1, False);
  AData.AddFunction('ExtractFileDrive', SysUtils_ExtractFileDrive_si, string_sw, 1, False);
  AData.AddFunction('ExtractFileName', SysUtils_ExtractFileName_si, string_sw, 1, False);
  AData.AddFunction('ExtractFileExt', SysUtils_ExtractFileExt_si, string_sw, 1, False);
  AData.AddFunction('ExpandFileName', SysUtils_ExpandFileName_si, string_sw, 1, False);
  AData.AddType(TFilenameCaseMatch_sw, SysUtils_TFilenameCaseMatch_si);
  AData.AddFunction('ExpandFileNameCase', SysUtils_ExpandFileNameCase_si, string_sw, 2, False);
  AData.AddFunction('ExpandUNCFileName', SysUtils_ExpandUNCFileName_si, string_sw, 1, False);
  AData.AddFunction('ExtractRelativePath', SysUtils_ExtractRelativePath_si, string_sw, 2, False);
  AData.AddFunction('ExtractShortPathName', SysUtils_ExtractShortPathName_si, string_sw, 1, False);
  AData.AddFunction('FileSearch', SysUtils_FileSearch_si, string_sw, 2, False);
  AData.AddFunction('DiskFree', SysUtils_DiskFree_si, Int64_sw, 1, False);
  AData.AddFunction('DiskSize', SysUtils_DiskSize_si, Int64_sw, 1, False);
  AData.AddFunction('FileDateToDateTime', SysUtils_FileDateToDateTime_si, TDateTime_sw, 1, False);
  AData.AddFunction('DateTimeToFileDate', SysUtils_DateTimeToFileDate_si, Integer_sw, 1, False);
  AData.AddFunction('GetCurrentDir', SysUtils_GetCurrentDir_si, string_sw, 0, False);
  AData.AddFunction('SetCurrentDir', SysUtils_SetCurrentDir_si, Boolean_sw, 1, False);
  AData.AddFunction('CreateDir', SysUtils_CreateDir_si, Boolean_sw, 1, False);
  AData.AddFunction('RemoveDir', SysUtils_RemoveDir_si, Boolean_sw, 1, False);
  AData.AddFunction('FloatToStr', SysUtils_FloatToStr_si, nil, 1, True);
  AData.AddFunction('CurrToStr', SysUtils_CurrToStr_si, nil, 1, True);
  AData.AddConstant('MinCurrency', SysUtils_MinCurrency_si, Currency_sw);
  AData.AddConstant('MaxCurrency', SysUtils_MaxCurrency_si, Currency_sw);
  AData.AddFunction('FloatToCurr', SysUtils_FloatToCurr_si, Currency_sw, 1, False);
  AData.AddFunction('TryFloatToCurr', SysUtils_TryFloatToCurr_si, Boolean_sw, 2, False);
  AData.AddFunction('FloatToStrF', SysUtils_FloatToStrF_si, nil, 4, True);
  AData.AddFunction('CurrToStrF', SysUtils_CurrToStrF_si, nil, 3, True);
  AData.AddFunction('FormatFloat', SysUtils_FormatFloat_si, nil, 2, True);
  AData.AddFunction('FormatCurr', SysUtils_FormatCurr_si, nil, 2, True);
  AData.AddFunction('StrToFloat', SysUtils_StrToFloat_si, nil, 1, True);
  AData.AddFunction('StrToFloatDef', SysUtils_StrToFloatDef_si, nil, 2, True);
  AData.AddFunction('TryStrToFloat', SysUtils_TryStrToFloat_si, nil, 2, True);
  AData.AddFunction('StrToCurr', SysUtils_StrToCurr_si, nil, 1, True);
  AData.AddFunction('StrToCurrDef', SysUtils_StrToCurrDef_si, nil, 2, True);
  AData.AddFunction('TryStrToCurr', SysUtils_TryStrToCurr_si, nil, 2, True);
  AData.AddFunction('DateTimeToTimeStamp', SysUtils_DateTimeToTimeStamp_si, TTimeStamp_sw, 1, False);
  AData.AddFunction('TimeStampToDateTime', SysUtils_TimeStampToDateTime_si, TDateTime_sw, 1, False);
  AData.AddFunction('MSecsToTimeStamp', SysUtils_MSecsToTimeStamp_si, TTimeStamp_sw, 1, False);
  AData.AddFunction('TimeStampToMSecs', SysUtils_TimeStampToMSecs_si, Comp_sw, 1, False);
  AData.AddFunction('EncodeDate', SysUtils_EncodeDate_si, TDateTime_sw, 3, False);
  AData.AddFunction('EncodeTime', SysUtils_EncodeTime_si, TDateTime_sw, 4, False);
  AData.AddFunction('TryEncodeDate', SysUtils_TryEncodeDate_si, Boolean_sw, 4, False);
  AData.AddFunction('TryEncodeTime', SysUtils_TryEncodeTime_si, Boolean_sw, 5, False);
  AData.AddProcedure('DecodeDate', SysUtils_DecodeDate_si, 4, False);
  AData.AddFunction('DecodeDateFully', SysUtils_DecodeDateFully_si, Boolean_sw, 5, False);
  AData.AddProcedure('DecodeTime', SysUtils_DecodeTime_si, 5, False);
  AData.AddProcedure('DateTimeToSystemTime', SysUtils_DateTimeToSystemTime_si, 2, False);
  AData.AddFunction('SystemTimeToDateTime', SysUtils_SystemTimeToDateTime_si, TDateTime_sw, 1, False);
  AData.AddFunction('DayOfWeek', SysUtils_DayOfWeek_si, Word_sw, 1, False);
  AData.AddFunction('Date', SysUtils_Date_si, TDateTime_sw, 0, False);
  AData.AddFunction('Time', SysUtils_Time_si, TDateTime_sw, 0, False);
  AData.AddFunction('GetTime', SysUtils_GetTime_si, TDateTime_sw, 0, False);
  AData.AddFunction('Now', SysUtils_Now_si, TDateTime_sw, 0, False);
  AData.AddFunction('CurrentYear', SysUtils_CurrentYear_si, Word_sw, 0, False);
  AData.AddFunction('IncMonth', SysUtils_IncMonth_si, TDateTime_sw, 1, True);
  AData.AddProcedure('IncAMonth', SysUtils_IncAMonth_si, 3, True);
  AData.AddProcedure('ReplaceTime', SysUtils_ReplaceTime_si, 2, False);
  AData.AddProcedure('ReplaceDate', SysUtils_ReplaceDate_si, 2, False);
  AData.AddFunction('IsLeapYear', SysUtils_IsLeapYear_si, Boolean_sw, 1, False);
  AData.AddFunction('DateToStr', SysUtils_DateToStr_si, nil, 1, True);
  AData.AddFunction('TimeToStr', SysUtils_TimeToStr_si, nil, 1, True);
  AData.AddFunction('DateTimeToStr', SysUtils_DateTimeToStr_si, nil, 1, True);
  AData.AddFunction('StrToDate', SysUtils_StrToDate_si, nil, 1, True);
  AData.AddFunction('StrToDateDef', SysUtils_StrToDateDef_si, nil, 2, True);
  AData.AddFunction('TryStrToDate', SysUtils_TryStrToDate_si, nil, 2, True);
  AData.AddFunction('StrToTime', SysUtils_StrToTime_si, nil, 1, True);
  AData.AddFunction('StrToTimeDef', SysUtils_StrToTimeDef_si, nil, 2, True);
  AData.AddFunction('TryStrToTime', SysUtils_TryStrToTime_si, nil, 2, True);
  AData.AddFunction('StrToDateTime', SysUtils_StrToDateTime_si, nil, 1, True);
  AData.AddFunction('StrToDateTimeDef', SysUtils_StrToDateTimeDef_si, nil, 2, True);
  AData.AddFunction('TryStrToDateTime', SysUtils_TryStrToDateTime_si, nil, 2, True);
  AData.AddFunction('FormatDateTime', SysUtils_FormatDateTime_si, nil, 2, True);
  AData.AddProcedure('DateTimeToString', SysUtils_DateTimeToString_si, 3, True);
  AData.AddConstant('MinDateTime', SysUtils_MinDateTime_si, TDateTime_sw);
  AData.AddConstant('MaxDateTime', SysUtils_MaxDateTime_si, TDateTime_sw);
  AData.AddFunction('FloatToDateTime', SysUtils_FloatToDateTime_si, TDateTime_sw, 1, False);
  AData.AddFunction('TryFloatToDateTime', SysUtils_TryFloatToDateTime_si, Boolean_sw, 2, False);
  AData.AddFunction('SysErrorMessage', SysUtils_SysErrorMessage_si, string_sw, 1, False);
  AData.AddFunction('GetLocaleStr', SysUtils_GetLocaleStr_si, string_sw, 3, False);
  AData.AddFunction('GetLocaleChar', SysUtils_GetLocaleChar_si, Char_sw, 3, False);
  AData.AddProcedure('GetFormatSettings', SysUtils_GetFormatSettings_si, 0, False);
  AData.AddProcedure('GetLocaleFormatSettings', SysUtils_GetLocaleFormatSettings_si, 2, False);
  AData.AddProcedure('Sleep', SysUtils_Sleep_si, 1, False);
  AData.AddFunction('GetModuleName', SysUtils_GetModuleName_si, string_sw, 1, False);
  AData.AddProcedure('Abort', SysUtils_Abort_si, 0, False);
  AData.AddProcedure('OutOfMemoryError', SysUtils_OutOfMemoryError_si, 0, False);
  AData.AddProcedure('Beep', SysUtils_Beep_si, 0, False);
  AData.AddFunction('ByteType', SysUtils_ByteType_si, TMbcsByteType_sw, 2, False);
  AData.AddFunction('ByteToCharLen', SysUtils_ByteToCharLen_si, Integer_sw, 2, False);
  AData.AddFunction('CharToByteLen', SysUtils_CharToByteLen_si, Integer_sw, 2, False);
  AData.AddFunction('ByteToCharIndex', SysUtils_ByteToCharIndex_si, Integer_sw, 2, False);
  AData.AddFunction('CharToByteIndex', SysUtils_CharToByteIndex_si, Integer_sw, 2, False);
  AData.AddFunction('CharLength', SysUtils_CharLength_si, Integer_sw, 2, False);
  AData.AddFunction('NextCharIndex', SysUtils_NextCharIndex_si, Integer_sw, 2, False);
  AData.AddFunction('IsPathDelimiter', SysUtils_IsPathDelimiter_si, Boolean_sw, 2, False);
  AData.AddFunction('IsDelimiter', SysUtils_IsDelimiter_si, Boolean_sw, 3, False);
  AData.AddFunction('IncludeTrailingPathDelimiter', SysUtils_IncludeTrailingPathDelimiter_si, string_sw, 1, False);
  AData.AddFunction('IncludeTrailingBackslash', SysUtils_IncludeTrailingBackslash_si, string_sw, 1, False);
  AData.AddFunction('ExcludeTrailingPathDelimiter', SysUtils_ExcludeTrailingPathDelimiter_si, string_sw, 1, False);
  AData.AddFunction('ExcludeTrailingBackslash', SysUtils_ExcludeTrailingBackslash_si, string_sw, 1, False);
  AData.AddFunction('LastDelimiter', SysUtils_LastDelimiter_si, Integer_sw, 2, False);
  AData.AddFunction('AnsiCompareFileName', SysUtils_AnsiCompareFileName_si, Integer_sw, 2, False);
  AData.AddFunction('SameFileName', SysUtils_SameFileName_si, Boolean_sw, 2, False);
  AData.AddFunction('AnsiLowerCaseFileName', SysUtils_AnsiLowerCaseFileName_si, string_sw, 1, False);
  AData.AddFunction('AnsiUpperCaseFileName', SysUtils_AnsiUpperCaseFileName_si, string_sw, 1, False);
  AData.AddFunction('AnsiPos', SysUtils_AnsiPos_si, Integer_sw, 2, False);
  AData.AddFunction('WrapText', SysUtils_WrapText_si, nil, 1, True);
  AData.AddConstant('SwitchChars', SysUtils_SwitchChars_si, nil, varInteger);
  AData.AddFunction('FindCmdLineSwitch', SysUtils_FindCmdLineSwitch_si, nil, 1, True);
  AData.AddFunction('Supports', SysUtils_Supports_si, nil, 2, False);
  AData.AddFunction('CreateGUID', SysUtils_CreateGUID_si, HResult_sw, 1, False);
  AData.AddFunction('StringToGUID', SysUtils_StringToGUID_si, TGUID_sw, 1, False);
  AData.AddFunction('GUIDToString', SysUtils_GUIDToString_si, string_sw, 1, False);
  AData.AddFunction('IsEqualGUID', SysUtils_IsEqualGUID_si, Boolean_sw, 2, False);
  AData.AddConstant('pfNeverBuild', SysUtils_pfNeverBuild_si, nil, VarType(SysUtils.pfNeverBuild));
  AData.AddConstant('pfDesignOnly', SysUtils_pfDesignOnly_si, nil, VarType(SysUtils.pfDesignOnly));
  AData.AddConstant('pfRunOnly', SysUtils_pfRunOnly_si, nil, VarType(SysUtils.pfRunOnly));
  AData.AddConstant('pfIgnoreDupUnits', SysUtils_pfIgnoreDupUnits_si, nil, VarType(SysUtils.pfIgnoreDupUnits));
  AData.AddConstant('pfModuleTypeMask', SysUtils_pfModuleTypeMask_si, nil, VarType(SysUtils.pfModuleTypeMask));
  AData.AddConstant('pfExeModule', SysUtils_pfExeModule_si, nil, VarType(SysUtils.pfExeModule));
  AData.AddConstant('pfPackageModule', SysUtils_pfPackageModule_si, nil, VarType(SysUtils.pfPackageModule));
  AData.AddConstant('pfProducerMask', SysUtils_pfProducerMask_si, nil, VarType(SysUtils.pfProducerMask));
  AData.AddConstant('pfV3Produced', SysUtils_pfV3Produced_si, nil, VarType(SysUtils.pfV3Produced));
  AData.AddConstant('pfProducerUndefined', SysUtils_pfProducerUndefined_si, nil, VarType(SysUtils.pfProducerUndefined));
  AData.AddConstant('pfBCB4Produced', SysUtils_pfBCB4Produced_si, nil, VarType(SysUtils.pfBCB4Produced));
  AData.AddConstant('pfDelphi4Produced', SysUtils_pfDelphi4Produced_si, nil, VarType(SysUtils.pfDelphi4Produced));
  AData.AddConstant('pfLibraryModule', SysUtils_pfLibraryModule_si, nil, VarType(SysUtils.pfLibraryModule));
  AData.AddConstant('ufMainUnit', SysUtils_ufMainUnit_si, nil, VarType(SysUtils.ufMainUnit));
  AData.AddConstant('ufPackageUnit', SysUtils_ufPackageUnit_si, nil, VarType(SysUtils.ufPackageUnit));
  AData.AddConstant('ufWeakUnit', SysUtils_ufWeakUnit_si, nil, VarType(SysUtils.ufWeakUnit));
  AData.AddConstant('ufOrgWeakUnit', SysUtils_ufOrgWeakUnit_si, nil, VarType(SysUtils.ufOrgWeakUnit));
  AData.AddConstant('ufImplicitUnit', SysUtils_ufImplicitUnit_si, nil, VarType(SysUtils.ufImplicitUnit));
  AData.AddConstant('ufWeakPackageUnit', SysUtils_ufWeakPackageUnit_si, nil, VarType(SysUtils.ufWeakPackageUnit));
  AData.AddType(TNameType_sw, SysUtils_TNameType_si);
  AData.AddFunction('LoadPackage', SysUtils_LoadPackage_si, HMODULE_sw, 1, False);
  AData.AddProcedure('UnloadPackage', SysUtils_UnloadPackage_si, 1, False);
  AData.AddProcedure('InitializePackage', SysUtils_InitializePackage_si, 1, False);
  AData.AddProcedure('FinalizePackage', SysUtils_FinalizePackage_si, 1, False);
  AData.AddProcedure('RaiseLastOSError', SysUtils_RaiseLastOSError_si, 0, False);
  AData.AddProcedure('RaiseLastWin32Error', SysUtils_RaiseLastWin32Error_si, 0, False);
  AData.AddFunction('Win32Check', SysUtils_Win32Check_si, BOOL_sw, 1, False);
  AData.AddFunction('CallTerminateProcs', SysUtils_CallTerminateProcs_si, Boolean_sw, 0, False);
  AData.AddFunction('GDAL', SysUtils_GDAL_si, LongWord_sw, 0, False);
  AData.AddProcedure('RCS', SysUtils_RCS_si, 0, False);
  AData.AddProcedure('RPR', SysUtils_RPR_si, 0, False);
  AData.AddVariable('HexDisplayPrefix', SysUtils_HexDisplayPrefix_si, string_sw);
  AData.AddFunction('SafeLoadLibrary', SysUtils_SafeLoadLibrary_si, HMODULE_sw, 1, True);
  AData.AddType(TSimpleRWSync_sw, SysUtils_TSimpleRWSync_si);
  AData.AddType(TThreadInfo_sw, SysUtils_TThreadInfo_si);
  AData.AddType(TThreadLocalCounter_sw, SysUtils_TThreadLocalCounter_si);
  AData.AddType(TMultiReadExclusiveWriteSynchronizer_sw, SysUtils_TMultiReadExclusiveWriteSynchronizer_si);
  AData.AddType(TMREWSync_sw, SysUtils_TMREWSync_si);
  AData.AddFunction('GetEnvironmentVariable', SysUtils_GetEnvironmentVariable_si, nil, 1, False);
end;

class function SysUtils_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(SysUtils_sw);
end;

initialization
  RegisterUnitWrapper(SysUtils_sw);
  RegisterClassWrapper(TLanguages_sw);
  RegisterClassWrapper(Exception_sw);
  RegisterClassWrapper(EAbort_sw);
  RegisterClassWrapper(EHeapException_sw);
  RegisterClassWrapper(EOutOfMemory_sw);
  RegisterClassWrapper(EInOutError_sw);
  RegisterClassWrapper(EExternal_sw);
  RegisterClassWrapper(EExternalException_sw);
  RegisterClassWrapper(EIntError_sw);
  RegisterClassWrapper(EDivByZero_sw);
  RegisterClassWrapper(ERangeError_sw);
  RegisterClassWrapper(EIntOverflow_sw);
  RegisterClassWrapper(EMathError_sw);
  RegisterClassWrapper(EInvalidOp_sw);
  RegisterClassWrapper(EZeroDivide_sw);
  RegisterClassWrapper(EOverflow_sw);
  RegisterClassWrapper(EUnderflow_sw);
  RegisterClassWrapper(EInvalidPointer_sw);
  RegisterClassWrapper(EInvalidCast_sw);
  RegisterClassWrapper(EConvertError_sw);
  RegisterClassWrapper(EAccessViolation_sw);
  RegisterClassWrapper(EPrivilege_sw);
  RegisterClassWrapper(EStackOverflow_sw);
  RegisterClassWrapper(EControlC_sw);
  RegisterClassWrapper(EVariantError_sw);
  RegisterClassWrapper(EPropReadOnly_sw);
  RegisterClassWrapper(EPropWriteOnly_sw);
  RegisterClassWrapper(EAssertionFailed_sw);
  RegisterClassWrapper(EAbstractError_sw);
  RegisterClassWrapper(EIntfCastError_sw);
  RegisterClassWrapper(EInvalidContainer_sw);
  RegisterClassWrapper(EInvalidInsert_sw);
  RegisterClassWrapper(EPackageError_sw);
  RegisterClassWrapper(EOSError_sw);
  RegisterClassWrapper(EWin32Error_sw);
  RegisterClassWrapper(ESafecallException_sw);
  RegisterClassWrapper(TSimpleRWSync_sw);
  RegisterClassWrapper(TThreadLocalCounter_sw);
  RegisterClassWrapper(TMultiReadExclusiveWriteSynchronizer_sw);

end.
