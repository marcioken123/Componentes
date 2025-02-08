unit System_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

  ##############################################################################
  #
  # ERROR: This is a dummy placeholder for Delphi 'System' unit wrappers.
  #        Do not use this file. Use 'LMDSctSysWrappers' unit instead.
  ##############################################################################

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'System' unit.
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
  System;


{ Type wrappers }

type
  TClass_sw = class;
  TObject_sw = class;
  TCustomAttribute_sw = class;
  WeakAttribute_sw = class;
  UnsafeAttribute_sw = class;
  RefAttribute_sw = class;
  VolatileAttribute_sw = class;
  StoredAttribute_sw = class;
  TInterfacedObject_sw = class;
  TInterfacedClass_sw = class;
  TAggregatedObject_sw = class;
  TContainedObject_sw = class;
  TClassHelperBase_sw = class;
  TClassHelperBaseClass_sw = class;
  TMarshal_sw = class;

  CppLongInt_sw = class(LongInt_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: CppLongInt): OleVariant;
    class function FromVar(const AValue: OleVariant): CppLongInt;
  end;

  CppULongInt_sw = class(LongWord_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: CppULongInt): OleVariant;
    class function FromVar(const AValue: OleVariant): CppULongInt;
  end;

  Int8_sw = ShortInt_sw;

  Int16_sw = SmallInt_sw;

  Int32_sw = Integer_sw;

  IntPtr_sw = NativeInt_sw;

  UInt8_sw = Byte_sw;

  UInt16_sw = Word_sw;

  UInt32_sw = Cardinal_sw;

  UIntPtr_sw = NativeUInt_sw;

  _ShortStr_sw = ShortString_sw;

  _AnsiStr_sw = AnsiString_sw;

  _AnsiChr_sw = AnsiChar_sw;

  _WideStr_sw = WideString_sw;

  TClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TClass;
  end;

  HRESULT_sw = class(Longint_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HRESULT): OleVariant;
    class function FromVar(const AValue: OleVariant): HRESULT;
  end;

  TGUID_sw = class(TLMDRecordWrapper)
  private
    FValue: TGUID;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TGUID): OleVariant;
    class function FromVar(const AValue: OleVariant): TGUID;
  end;

  TInterfaceEntry_sw = class(TLMDRecordWrapper)
  private
    FValue: TInterfaceEntry;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TInterfaceEntry): OleVariant;
    class function FromVar(const AValue: OleVariant): TInterfaceEntry;
  end;

  TInterfaceTable_sw = class(TLMDRecordWrapper)
  private
    FValue: TInterfaceTable;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TInterfaceTable): OleVariant;
    class function FromVar(const AValue: OleVariant): TInterfaceTable;
  end;

  TMethod_sw = class(TLMDRecordWrapper)
  private
    FValue: TMethod;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TMethod): OleVariant;
    class function FromVar(const AValue: OleVariant): TMethod;
  end;

  TDispatchMessage_sw = class(TLMDRecordWrapper)
  private
    FValue: TDispatchMessage;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TDispatchMessage): OleVariant;
    class function FromVar(const AValue: OleVariant): TDispatchMessage;
  end;

  TObject_sc = class of TObject;
  TObject_sw = class(TLMDClassWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TObject;
    class function ClassToVar(AClass: TObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TObject_sc;
  end;

  TCustomAttribute_sc = class of TCustomAttribute;
  TCustomAttribute_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomAttribute;
    class function ClassToVar(AClass: TCustomAttribute_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomAttribute_sc;
  end;

  WeakAttribute_sc = class of WeakAttribute;
  WeakAttribute_sw = class(TCustomAttribute_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: WeakAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): WeakAttribute;
    class function ClassToVar(AClass: WeakAttribute_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): WeakAttribute_sc;
  end;

  UnsafeAttribute_sc = class of UnsafeAttribute;
  UnsafeAttribute_sw = class(TCustomAttribute_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: UnsafeAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): UnsafeAttribute;
    class function ClassToVar(AClass: UnsafeAttribute_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): UnsafeAttribute_sc;
  end;

  RefAttribute_sc = class of RefAttribute;
  RefAttribute_sw = class(TCustomAttribute_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: RefAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): RefAttribute;
    class function ClassToVar(AClass: RefAttribute_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): RefAttribute_sc;
  end;

  VolatileAttribute_sc = class of VolatileAttribute;
  VolatileAttribute_sw = class(TCustomAttribute_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: VolatileAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): VolatileAttribute;
    class function ClassToVar(AClass: VolatileAttribute_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): VolatileAttribute_sc;
  end;

  StoredAttribute_sc = class of StoredAttribute;
  StoredAttribute_sw = class(TCustomAttribute_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: StoredAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): StoredAttribute;
    class function ClassToVar(AClass: StoredAttribute_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): StoredAttribute_sc;
  end;

  TThreadID_sw = LongWord_sw;

  TMonitor_sw = class(TLMDRecordWrapper)
  private
    FValue: TMonitor;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TMonitor): OleVariant;
    class function FromVar(const AValue: OleVariant): TMonitor;
  end;

  TInterfacedObject_sc = class of TInterfacedObject;
  TInterfacedObject_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TInterfacedObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TInterfacedObject;
    class function ClassToVar(AClass: TInterfacedObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TInterfacedObject_sc;
  end;

  TInterfacedClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TInterfacedClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TInterfacedClass;
  end;

  TAggregatedObject_sc = class of TAggregatedObject;
  TAggregatedObject_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TAggregatedObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TAggregatedObject;
    class function ClassToVar(AClass: TAggregatedObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TAggregatedObject_sc;
  end;

  TContainedObject_sc = class of TContainedObject;
  TContainedObject_sw = class(TAggregatedObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TContainedObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TContainedObject;
    class function ClassToVar(AClass: TContainedObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TContainedObject_sc;
  end;

  TClassHelperBase_sc = class of TClassHelperBase;
  TClassHelperBase_sw = class(TInterfacedObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TClassHelperBase): OleVariant;
    class function FromVar(const AValue: OleVariant): TClassHelperBase;
    class function ClassToVar(AClass: TClassHelperBase_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TClassHelperBase_sc;
  end;

  TClassHelperBaseClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TClassHelperBaseClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TClassHelperBaseClass;
  end;

  UCS2Char_sw = WideChar_sw;

  UCS4Char_sw = class(LongWord_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: UCS4Char): OleVariant;
    class function FromVar(const AValue: OleVariant): UCS4Char;
  end;

  UTF8String_sw = class(AnsiString_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: UTF8String): OleVariant;
    class function FromVar(const AValue: OleVariant): UTF8String;
  end;

  RawByteString_sw = class(AnsiString_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: RawByteString): OleVariant;
    class function FromVar(const AValue: OleVariant): RawByteString;
  end;

  _UTF8Str_sw = UTF8String_sw;

  _RawByteStr_sw = RawByteString_sw;

  TDateTime_sw = class(Double_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDateTime): OleVariant;
    class function FromVar(const AValue: OleVariant): TDateTime;
  end;

  TDate_sw = class(TDateTime_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDate): OleVariant;
    class function FromVar(const AValue: OleVariant): TDate;
  end;

  TTime_sw = class(TDateTime_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTime): OleVariant;
    class function FromVar(const AValue: OleVariant): TTime;
  end;

  THandle_sw = NativeUInt_sw;

  TVarArrayBound_sw = class(TLMDRecordWrapper)
  private
    FValue: TVarArrayBound;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVarArrayBound): OleVariant;
    class function FromVar(const AValue: OleVariant): TVarArrayBound;
  end;

  TVarArray_sw = class(TLMDRecordWrapper)
  private
    FValue: TVarArray;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVarArray): OleVariant;
    class function FromVar(const AValue: OleVariant): TVarArray;
  end;

  TVarRecord_sw = class(TLMDRecordWrapper)
  private
    FValue: TVarRecord;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVarRecord): OleVariant;
    class function FromVar(const AValue: OleVariant): TVarRecord;
  end;

  TLargestVarData_sw = class(TLMDRecordWrapper)
  private
    FValue: TLargestVarData;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TLargestVarData): OleVariant;
    class function FromVar(const AValue: OleVariant): TLargestVarData;
  end;

  TVarType_sw = Word_sw;

  TVarData_sw = class(TLMDRecordWrapper)
  private
    FValue: TVarData;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVarData): OleVariant;
    class function FromVar(const AValue: OleVariant): TVarData;
  end;

  TVarOp_sw = Integer_sw;

  TCallDesc_sw = class(TLMDRecordWrapper)
  private
    FValue: TCallDesc;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCallDesc): OleVariant;
    class function FromVar(const AValue: OleVariant): TCallDesc;
  end;

  TDispDesc_sw = class(TLMDRecordWrapper)
  private
    FValue: TDispDesc;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TDispDesc): OleVariant;
    class function FromVar(const AValue: OleVariant): TDispDesc;
  end;

  TVariantManager_sw = class(TLMDRecordWrapper)
  private
    FValue: TVariantManager;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVariantManager): OleVariant;
    class function FromVar(const AValue: OleVariant): TVariantManager;
  end;

  TTypeKind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTypeKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TTypeKind;
  end;

  TDynArrayTypeInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TDynArrayTypeInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TDynArrayTypeInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TDynArrayTypeInfo;
  end;

  TVarRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TVarRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVarRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TVarRec;
  end;

  TMemoryManager_sw = class(TLMDRecordWrapper)
  private
    FValue: TMemoryManager;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TMemoryManager): OleVariant;
    class function FromVar(const AValue: OleVariant): TMemoryManager;
  end;

  TMemoryManagerEx_sw = class(TLMDRecordWrapper)
  private
    FValue: TMemoryManagerEx;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TMemoryManagerEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TMemoryManagerEx;
  end;

  THeapStatus_sw = class(TLMDRecordWrapper)
  private
    FValue: THeapStatus;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: THeapStatus): OleVariant;
    class function FromVar(const AValue: OleVariant): THeapStatus;
  end;

  TSmallBlockTypeState_sw = class(TLMDRecordWrapper)
  private
    FValue: TSmallBlockTypeState;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TSmallBlockTypeState): OleVariant;
    class function FromVar(const AValue: OleVariant): TSmallBlockTypeState;
  end;

  TMemoryManagerState_sw = class(TLMDRecordWrapper)
  private
    FValue: TMemoryManagerState;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TMemoryManagerState): OleVariant;
    class function FromVar(const AValue: OleVariant): TMemoryManagerState;
  end;

  TMonitorSupport_sw = class(TLMDRecordWrapper)
  private
    FValue: TMonitorSupport;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TMonitorSupport): OleVariant;
    class function FromVar(const AValue: OleVariant): TMonitorSupport;
  end;

  TPtrWrapper_sw = class(TLMDRecordWrapper)
  private
    FValue: TPtrWrapper;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPtrWrapper): OleVariant;
    class function FromVar(const AValue: OleVariant): TPtrWrapper;
  end;

  TMarshal_sc = class of TMarshal;
  TMarshal_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMarshal): OleVariant;
    class function FromVar(const AValue: OleVariant): TMarshal;
    class function ClassToVar(AClass: TMarshal_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMarshal_sc;
  end;

  TChunkStatus_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TChunkStatus): OleVariant;
    class function FromVar(const AValue: OleVariant): TChunkStatus;
  end;

  TMinimumBlockAlignment_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMinimumBlockAlignment): OleVariant;
    class function FromVar(const AValue: OleVariant): TMinimumBlockAlignment;
  end;

  PackageUnitEntry_sw = class(TLMDRecordWrapper)
  private
    FValue: PackageUnitEntry;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: PackageUnitEntry): OleVariant;
    class function FromVar(const AValue: OleVariant): PackageUnitEntry;
  end;

  TPackageTypeInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TPackageTypeInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPackageTypeInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TPackageTypeInfo;
  end;

  PackageInfoTable_sw = class(TLMDRecordWrapper)
  private
    FValue: PackageInfoTable;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: PackageInfoTable): OleVariant;
    class function FromVar(const AValue: OleVariant): PackageInfoTable;
  end;

  TCVModInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TCVModInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCVModInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TCVModInfo;
  end;

  TTextLineBreakStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTextLineBreakStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TTextLineBreakStyle;
  end;

  HRSRC_sw = THandle_sw;

  TResourceHandle_sw = HRSRC_sw;

  HINST_sw = THandle_sw;

  HMODULE_sw = HINST_sw;

  HGLOBAL_sw = THandle_sw;

  TFileRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TFileRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TFileRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileRec;
  end;

  TTextRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TTextRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TTextRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TTextRec;
  end;

  TLibModule_sw = class(TLMDRecordWrapper)
  private
    FValue: TLibModule;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TLibModule): OleVariant;
    class function FromVar(const AValue: OleVariant): TLibModule;
  end;

  TModuleUnloadRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TModuleUnloadRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TModuleUnloadRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TModuleUnloadRec;
  end;

  TResStringRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TResStringRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TResStringRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TResStringRec;
  end;

  TFloatSpecial_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFloatSpecial): OleVariant;
    class function FromVar(const AValue: OleVariant): TFloatSpecial;
  end;

  TSingleRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TSingleRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TSingleRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TSingleRec;
  end;

  TDoubleRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TDoubleRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TDoubleRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TDoubleRec;
  end;

  TExtended80Rec_sw = class(TLMDRecordWrapper)
  private
    FValue: TExtended80Rec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TExtended80Rec): OleVariant;
    class function FromVar(const AValue: OleVariant): TExtended80Rec;
  end;

  TExtendedRec_sw = TExtended80Rec_sw;

  TInitContext_sw = class(TLMDRecordWrapper)
  private
    FValue: TInitContext;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TInitContext): OleVariant;
    class function FromVar(const AValue: OleVariant): TInitContext;
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

  TRuntimeError_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TRuntimeError): OleVariant;
    class function FromVar(const AValue: OleVariant): TRuntimeError;
  end;


{ Unit wrapper }

type
  System_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TObject_sacc = class(TObject);

{ CppLongInt_sw }

class function CppLongInt_sw.GetTypeName: WideString;
begin
  Result := 'CppLongInt';
end;

class function CppLongInt_sw.ToVar(const AValue: CppLongInt): OleVariant;
begin
  Result := LongInt_sw.ToVar(LongInt(AValue));
end;

class function CppLongInt_sw.FromVar(const AValue: OleVariant): CppLongInt;
begin
  Result := CppLongInt(LongInt_sw.FromVar(AValue));
end;

{ CppULongInt_sw }

class function CppULongInt_sw.GetTypeName: WideString;
begin
  Result := 'CppULongInt';
end;

class function CppULongInt_sw.ToVar(const AValue: CppULongInt): OleVariant;
begin
  Result := LongWord_sw.ToVar(LongWord(AValue));
end;

class function CppULongInt_sw.FromVar(const AValue: OleVariant): CppULongInt;
begin
  Result := CppULongInt(LongWord_sw.FromVar(AValue));
end;

{ TClass_sw }

class function TClass_sw.GetTypeName: WideString;
begin
  Result := 'TClass';
end;

class function TClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TObject;
end;

class function TClass_sw.ToVar(const AValue: TClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TClass_sw.FromVar(const AValue: OleVariant): TClass;
begin
  Result := TClass(ConvFromVar(AValue, TObject));
end;

{ HRESULT_sw }

class function HRESULT_sw.GetTypeName: WideString;
begin
  Result := 'HRESULT';
end;

class function HRESULT_sw.ToVar(const AValue: HRESULT): OleVariant;
begin
  Result := Longint_sw.ToVar(Longint(AValue));
end;

class function HRESULT_sw.FromVar(const AValue: OleVariant): HRESULT;
begin
  Result := HRESULT(Longint_sw.FromVar(AValue));
end;

{ TGUID_sw }

function TGUID_D1_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var D1: LongWord;

  if IsGet then
    Result := TGUID_sw(AObj).FValue.D1
  else
    TGUID_sw(AObj).FValue.D1 := LongWord(AArgs[0]);
end;

function TGUID_D2_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var D2: Word;

  if IsGet then
    Result := TGUID_sw(AObj).FValue.D2
  else
    TGUID_sw(AObj).FValue.D2 := Word(AArgs[0]);
end;

function TGUID_D3_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var D3: Word;

  if IsGet then
    Result := TGUID_sw(AObj).FValue.D3
  else
    TGUID_sw(AObj).FValue.D3 := Word(AArgs[0]);
end;

function TGUID_Empty_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // class function Empty: TGUID;

  Result := TGUID_sw.ToVar(TGUID.Empty());
end;

function TGUID_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TGUID_sw.Create as IDispatch;
end;

function TGUID_Copy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Copy: TGUID;

  // Implicit record copy method.
  Result := TGUID_sw.ToVar(TGUID(AObj));
end;

class function TGUID_sw.GetTypeName: WideString;
begin
  Result := 'TGUID';
end;

function TGUID_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TGUID_sw.Create;
  TGUID_sw(Result).FValue := FValue;
end;

class procedure TGUID_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('D1', TGUID_D1_si, LongWord_sw);
  AData.AddField('D2', TGUID_D2_si, Word_sw);
  AData.AddField('D3', TGUID_D3_si, Word_sw);
  AData.AddFunction('Copy', TGUID_Copy_si, TGUID_sw, 0, False);

  { Class members }

  AData.AddClassFunction('Empty', TGUID_Empty_si, TGUID_sw, 0, False);
  AData.AddConstructor('Create', TGUID_Create_si, 0, False);
end;

class function TGUID_sw.ToVar(const AValue: TGUID): OleVariant;
var
  wrpr: TGUID_sw;
begin
  wrpr        := TGUID_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TGUID_sw.FromVar(const AValue: OleVariant): TGUID;
begin
  Result := TGUID_sw(ConvFromVar(AValue)).FValue;
end;

{ TInterfaceEntry_sw }

function TInterfaceEntry_IID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var IID: TGUID;

  if IsGet then
    Result := TGUID_sw.ToVar(TInterfaceEntry_sw(AObj).FValue.IID)
  else
    TInterfaceEntry_sw(AObj).FValue.IID := TGUID_sw.FromVar(AArgs[0]);
end;

function TInterfaceEntry_IOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var IOffset: Integer;

  if IsGet then
    Result := TInterfaceEntry_sw(AObj).FValue.IOffset
  else
    TInterfaceEntry_sw(AObj).FValue.IOffset := Integer(AArgs[0]);
end;

function TInterfaceEntry_ImplGetter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ImplGetter: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(TInterfaceEntry_sw(AObj).FValue.ImplGetter)
  else
    TInterfaceEntry_sw(AObj).FValue.ImplGetter := NativeUInt_sw.FromVar(
      AArgs[0]);
end;

function TInterfaceEntry_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TInterfaceEntry_sw.Create as IDispatch;
end;

function TInterfaceEntry_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TInterfaceEntry;

  // Implicit record copy method.
  Result := TInterfaceEntry_sw.ToVar(TInterfaceEntry(AObj));
end;

class function TInterfaceEntry_sw.GetTypeName: WideString;
begin
  Result := 'TInterfaceEntry';
end;

function TInterfaceEntry_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TInterfaceEntry_sw.Create;
  TInterfaceEntry_sw(Result).FValue := FValue;
end;

class procedure TInterfaceEntry_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('IID', TInterfaceEntry_IID_si, TGUID_sw);
  AData.AddField('IOffset', TInterfaceEntry_IOffset_si, Integer_sw);
  AData.AddField('ImplGetter', TInterfaceEntry_ImplGetter_si, NativeUInt_sw);
  AData.AddFunction('Copy', TInterfaceEntry_Copy_si, TInterfaceEntry_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TInterfaceEntry_Create_si, 0, False);
end;

class function TInterfaceEntry_sw.ToVar(
  const AValue: TInterfaceEntry): OleVariant;
var
  wrpr: TInterfaceEntry_sw;
begin
  wrpr        := TInterfaceEntry_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TInterfaceEntry_sw.FromVar(
  const AValue: OleVariant): TInterfaceEntry;
begin
  Result := TInterfaceEntry_sw(ConvFromVar(AValue)).FValue;
end;

{ TInterfaceTable_sw }

function TInterfaceTable_EntryCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var EntryCount: Integer;

  if IsGet then
    Result := TInterfaceTable_sw(AObj).FValue.EntryCount
  else
    TInterfaceTable_sw(AObj).FValue.EntryCount := Integer(AArgs[0]);
end;

function TInterfaceTable_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TInterfaceTable_sw.Create as IDispatch;
end;

function TInterfaceTable_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TInterfaceTable;

  // Implicit record copy method.
  Result := TInterfaceTable_sw.ToVar(TInterfaceTable(AObj));
end;

class function TInterfaceTable_sw.GetTypeName: WideString;
begin
  Result := 'TInterfaceTable';
end;

function TInterfaceTable_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TInterfaceTable_sw.Create;
  TInterfaceTable_sw(Result).FValue := FValue;
end;

class procedure TInterfaceTable_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('EntryCount', TInterfaceTable_EntryCount_si, Integer_sw);
  AData.AddFunction('Copy', TInterfaceTable_Copy_si, TInterfaceTable_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TInterfaceTable_Create_si, 0, False);
end;

class function TInterfaceTable_sw.ToVar(
  const AValue: TInterfaceTable): OleVariant;
var
  wrpr: TInterfaceTable_sw;
begin
  wrpr        := TInterfaceTable_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TInterfaceTable_sw.FromVar(
  const AValue: OleVariant): TInterfaceTable;
begin
  Result := TInterfaceTable_sw(ConvFromVar(AValue)).FValue;
end;

{ TMethod_sw }

function TMethod_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TMethod_sw.Create as IDispatch;
end;

function TMethod_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TMethod;

  // Implicit record copy method.
  Result := TMethod_sw.ToVar(TMethod(AObj));
end;

class function TMethod_sw.GetTypeName: WideString;
begin
  Result := 'TMethod';
end;

function TMethod_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TMethod_sw.Create;
  TMethod_sw(Result).FValue := FValue;
end;

class procedure TMethod_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TMethod_Copy_si, TMethod_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TMethod_Create_si, 0, False);
end;

class function TMethod_sw.ToVar(const AValue: TMethod): OleVariant;
var
  wrpr: TMethod_sw;
begin
  wrpr        := TMethod_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TMethod_sw.FromVar(const AValue: OleVariant): TMethod;
begin
  Result := TMethod_sw(ConvFromVar(AValue)).FValue;
end;

{ TDispatchMessage_sw }

function TDispatchMessage_MsgID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MsgID: Word;

  if IsGet then
    Result := TDispatchMessage_sw(AObj).FValue.MsgID
  else
    TDispatchMessage_sw(AObj).FValue.MsgID := Word(AArgs[0]);
end;

function TDispatchMessage_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TDispatchMessage_sw.Create as IDispatch;
end;

function TDispatchMessage_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TDispatchMessage;

  // Implicit record copy method.
  Result := TDispatchMessage_sw.ToVar(TDispatchMessage(AObj));
end;

class function TDispatchMessage_sw.GetTypeName: WideString;
begin
  Result := 'TDispatchMessage';
end;

function TDispatchMessage_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TDispatchMessage_sw.Create;
  TDispatchMessage_sw(Result).FValue := FValue;
end;

class procedure TDispatchMessage_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('MsgID', TDispatchMessage_MsgID_si, Word_sw);
  AData.AddFunction('Copy', TDispatchMessage_Copy_si, TDispatchMessage_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TDispatchMessage_Create_si, 0, False);
end;

class function TDispatchMessage_sw.ToVar(
  const AValue: TDispatchMessage): OleVariant;
var
  wrpr: TDispatchMessage_sw;
begin
  wrpr        := TDispatchMessage_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TDispatchMessage_sw.FromVar(
  const AValue: OleVariant): TDispatchMessage;
begin
  Result := TDispatchMessage_sw(ConvFromVar(AValue)).FValue;
end;

{ TObject_sw }

function TObject_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TObject_sw.ToVar(TObject_sc(AObj).Create());
end;

function TObject_Free_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Free;

  TObject(AObj).Free();
end;

function TObject_DisposeOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DisposeOf;

  TObject(AObj).DisposeOf();
end;

function TObject_CleanupInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CleanupInstance;

  TObject(AObj).CleanupInstance();
end;

function TObject_ClassType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ClassType: TClass;

  Result := TClass_sw.ToVar(TObject(AObj).ClassType());
end;

function TObject_ClassName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ClassName: string;

  Result := TObject_sc(AObj).ClassName();
end;

function TObject_ClassNameIs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ClassNameIs(const Name: string): Boolean;

  Result := TObject_sc(AObj).ClassNameIs(string(AArgs[0]));
end;

function TObject_ClassParent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ClassParent: TClass;

  Result := TClass_sw.ToVar(TObject_sc(AObj).ClassParent());
end;

function TObject_InstanceSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function InstanceSize: Longint;

  Result := TObject_sc(AObj).InstanceSize();
end;

function TObject_InheritsFrom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function InheritsFrom(AClass: TClass): Boolean;

  Result := TObject_sc(AObj).InheritsFrom(TClass_sw.FromVar(AArgs[0]));
end;

function TObject_QualifiedClassName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function QualifiedClassName: string;

  Result := TObject_sc(AObj).QualifiedClassName();
end;

function TObject_UnitName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function UnitName: string;

  Result := TObject_sc(AObj).UnitName();
end;

function TObject_UnitScope_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function UnitScope: string;

  Result := TObject_sc(AObj).UnitScope();
end;

function TObject_Equals_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Equals(Obj: TObject): Boolean;

  Result := TObject(AObj).Equals(TObject_sw.FromVar(AArgs[0]));
end;

function TObject_GetHashCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetHashCode: Integer;

  Result := TObject(AObj).GetHashCode();
end;

function TObject_ToString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ToString: string;

  Result := TObject(AObj).ToString();
end;

function TObject_AfterConstruction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AfterConstruction;

  TObject(AObj).AfterConstruction();
end;

function TObject_BeforeDestruction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeforeDestruction;

  TObject(AObj).BeforeDestruction();
end;

function TObject_NewInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function NewInstance: TObject;

  Result := TObject_sw.ToVar(TObject_sc(AObj).NewInstance());
end;

function TObject_FreeInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FreeInstance;

  TObject(AObj).FreeInstance();
end;

function TObject_Destroy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // destructor Destroy;

  TObject(AObj).Destroy();
end;

function TObject_Disposed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Disposed: Boolean read <getter>;

  Result := TObject_sacc(TObject(AObj)).Disposed;
end;

class function TObject_sw.GetTypeName: WideString;
begin
  Result := 'TObject';
end;

class function TObject_sw.GetWrappedClass: TClass;
begin
  Result := TObject;
end;

class procedure TObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Free', TObject_Free_si, 0, False);
  AData.AddProcedure('DisposeOf', TObject_DisposeOf_si, 0, False);
  AData.AddProcedure('CleanupInstance', TObject_CleanupInstance_si, 0, False);
  AData.AddFunction('ClassType', TObject_ClassType_si, TClass_sw, 0, False);
  AData.AddFunction('Equals', TObject_Equals_si, Boolean_sw, 1, False);
  AData.AddFunction('GetHashCode', TObject_GetHashCode_si, Integer_sw, 0, False);
  AData.AddFunction('ToString', TObject_ToString_si, string_sw, 0, False);
  AData.AddProcedure('AfterConstruction', TObject_AfterConstruction_si, 0, False);
  AData.AddProcedure('BeforeDestruction', TObject_BeforeDestruction_si, 0, False);
  AData.AddProcedure('FreeInstance', TObject_FreeInstance_si, 0, False);
  AData.AddDestructor('Destroy', TObject_Destroy_si, 0, False);
  AData.AddProperty('Disposed', TObject_Disposed_si, Boolean_sw, True, False, 0, True, False);

  { Class members }

  AData.AddConstructor('Create', TObject_Create_si, 0, False);
  AData.AddClassFunction('ClassName', TObject_ClassName_si, string_sw, 0, False);
  AData.AddClassFunction('ClassNameIs', TObject_ClassNameIs_si, Boolean_sw, 1, False);
  AData.AddClassFunction('ClassParent', TObject_ClassParent_si, TClass_sw, 0, False);
  AData.AddClassFunction('InstanceSize', TObject_InstanceSize_si, Longint_sw, 0, False);
  AData.AddClassFunction('InheritsFrom', TObject_InheritsFrom_si, Boolean_sw, 1, False);
  AData.AddClassFunction('QualifiedClassName', TObject_QualifiedClassName_si, string_sw, 0, False);
  AData.AddClassFunction('UnitName', TObject_UnitName_si, string_sw, 0, False);
  AData.AddClassFunction('UnitScope', TObject_UnitScope_si, string_sw, 0, False);
  AData.AddClassFunction('NewInstance', TObject_NewInstance_si, TObject_sw, 0, False);
end;

class function TObject_sw.ToVar(const AValue: TObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TObject_sw.FromVar(const AValue: OleVariant): TObject;
begin
  Result := TObject(ConvFromVar(AValue, TObject));
end;

class function TObject_sw.ClassToVar(AClass: TObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TObject_sw.ClassFromVar(const AClass: OleVariant): TObject_sc;
begin
  Result := TObject_sc(ConvClsFromVar(AClass, TObject));
end;

{ TCustomAttribute_sw }

class function TCustomAttribute_sw.GetTypeName: WideString;
begin
  Result := 'TCustomAttribute';
end;

class function TCustomAttribute_sw.GetWrappedClass: TClass;
begin
  Result := TCustomAttribute;
end;

class procedure TCustomAttribute_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TCustomAttribute_sw.ToVar(
  const AValue: TCustomAttribute): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomAttribute_sw.FromVar(
  const AValue: OleVariant): TCustomAttribute;
begin
  Result := TCustomAttribute(ConvFromVar(AValue, TCustomAttribute));
end;

class function TCustomAttribute_sw.ClassToVar(
  AClass: TCustomAttribute_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomAttribute_sw.ClassFromVar(
  const AClass: OleVariant): TCustomAttribute_sc;
begin
  Result := TCustomAttribute_sc(ConvClsFromVar(AClass, TCustomAttribute));
end;

{ WeakAttribute_sw }

class function WeakAttribute_sw.GetTypeName: WideString;
begin
  Result := 'WeakAttribute';
end;

class function WeakAttribute_sw.GetWrappedClass: TClass;
begin
  Result := WeakAttribute;
end;

class procedure WeakAttribute_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function WeakAttribute_sw.ToVar(const AValue: WeakAttribute): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function WeakAttribute_sw.FromVar(
  const AValue: OleVariant): WeakAttribute;
begin
  Result := WeakAttribute(ConvFromVar(AValue, WeakAttribute));
end;

class function WeakAttribute_sw.ClassToVar(
  AClass: WeakAttribute_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function WeakAttribute_sw.ClassFromVar(
  const AClass: OleVariant): WeakAttribute_sc;
begin
  Result := WeakAttribute_sc(ConvClsFromVar(AClass, WeakAttribute));
end;

{ UnsafeAttribute_sw }

class function UnsafeAttribute_sw.GetTypeName: WideString;
begin
  Result := 'UnsafeAttribute';
end;

class function UnsafeAttribute_sw.GetWrappedClass: TClass;
begin
  Result := UnsafeAttribute;
end;

class procedure UnsafeAttribute_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function UnsafeAttribute_sw.ToVar(
  const AValue: UnsafeAttribute): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function UnsafeAttribute_sw.FromVar(
  const AValue: OleVariant): UnsafeAttribute;
begin
  Result := UnsafeAttribute(ConvFromVar(AValue, UnsafeAttribute));
end;

class function UnsafeAttribute_sw.ClassToVar(
  AClass: UnsafeAttribute_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function UnsafeAttribute_sw.ClassFromVar(
  const AClass: OleVariant): UnsafeAttribute_sc;
begin
  Result := UnsafeAttribute_sc(ConvClsFromVar(AClass, UnsafeAttribute));
end;

{ RefAttribute_sw }

class function RefAttribute_sw.GetTypeName: WideString;
begin
  Result := 'RefAttribute';
end;

class function RefAttribute_sw.GetWrappedClass: TClass;
begin
  Result := RefAttribute;
end;

class procedure RefAttribute_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function RefAttribute_sw.ToVar(const AValue: RefAttribute): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function RefAttribute_sw.FromVar(const AValue: OleVariant): RefAttribute;
begin
  Result := RefAttribute(ConvFromVar(AValue, RefAttribute));
end;

class function RefAttribute_sw.ClassToVar(AClass: RefAttribute_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function RefAttribute_sw.ClassFromVar(
  const AClass: OleVariant): RefAttribute_sc;
begin
  Result := RefAttribute_sc(ConvClsFromVar(AClass, RefAttribute));
end;

{ VolatileAttribute_sw }

class function VolatileAttribute_sw.GetTypeName: WideString;
begin
  Result := 'VolatileAttribute';
end;

class function VolatileAttribute_sw.GetWrappedClass: TClass;
begin
  Result := VolatileAttribute;
end;

class procedure VolatileAttribute_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function VolatileAttribute_sw.ToVar(
  const AValue: VolatileAttribute): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function VolatileAttribute_sw.FromVar(
  const AValue: OleVariant): VolatileAttribute;
begin
  Result := VolatileAttribute(ConvFromVar(AValue, VolatileAttribute));
end;

class function VolatileAttribute_sw.ClassToVar(
  AClass: VolatileAttribute_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function VolatileAttribute_sw.ClassFromVar(
  const AClass: OleVariant): VolatileAttribute_sc;
begin
  Result := VolatileAttribute_sc(ConvClsFromVar(AClass, VolatileAttribute));
end;

{ StoredAttribute_sw }

function StoredAttribute_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    0:
    begin
      Result := StoredAttribute_sw.ToVar(StoredAttribute_sc(AObj).Create());
    end;
    1:
    begin
      Result := StoredAttribute_sw.ToVar(StoredAttribute_sc(AObj).Create(string(
        AArgs[0])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function StoredAttribute_Flag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Flag: Boolean read <getter>;

  Result := StoredAttribute(AObj).Flag;
end;

function StoredAttribute_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Name: string read <getter>;

  Result := StoredAttribute(AObj).Name;
end;

class function StoredAttribute_sw.GetTypeName: WideString;
begin
  Result := 'StoredAttribute';
end;

class function StoredAttribute_sw.GetWrappedClass: TClass;
begin
  Result := StoredAttribute;
end;

class procedure StoredAttribute_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Flag', StoredAttribute_Flag_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Name', StoredAttribute_Name_si, string_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', StoredAttribute_Create_si, 0, True);
end;

class function StoredAttribute_sw.ToVar(
  const AValue: StoredAttribute): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function StoredAttribute_sw.FromVar(
  const AValue: OleVariant): StoredAttribute;
begin
  Result := StoredAttribute(ConvFromVar(AValue, StoredAttribute));
end;

class function StoredAttribute_sw.ClassToVar(
  AClass: StoredAttribute_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function StoredAttribute_sw.ClassFromVar(
  const AClass: OleVariant): StoredAttribute_sc;
begin
  Result := StoredAttribute_sc(ConvClsFromVar(AClass, StoredAttribute));
end;

{ TMonitor_sw }

function TMonitor_SetSpinCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure SetSpinCount(const AObject: TObject; ASpi...

  TMonitor.SetSpinCount(TObject_sw.FromVar(AArgs[0]), Integer(AArgs[1]));
end;

function TMonitor_Enter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Enter(...); overload;

  TMonitor.Enter(TObject_sw.FromVar(AArgs[0]));
end;

function TMonitor_Exit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Exit(...); overload;

  TMonitor.Exit(TObject_sw.FromVar(AArgs[0]));
end;

function TMonitor_TryEnter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function TryEnter(...); overload;

  Result := TMonitor.TryEnter(TObject_sw.FromVar(AArgs[0]));
end;

function TMonitor_Wait_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Wait(...); overload;

  case AArgsSize of
    2:
    begin
      Result := TMonitor.Wait(TObject_sw.FromVar(AArgs[0]), Cardinal(AArgs[1]));
    end;
    3:
    begin
      Result := TMonitor.Wait(TObject_sw.FromVar(AArgs[0]), TObject_sw.FromVar(
        AArgs[1]), Cardinal(AArgs[2]));
    end;
  else
    WrongArgCountError('Wait');
  end;
end;

function TMonitor_Pulse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Pulse(...); overload;

  TMonitor.Pulse(TObject_sw.FromVar(AArgs[0]));
end;

function TMonitor_PulseAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function PulseAll(...); overload;

  TMonitor.PulseAll(TObject_sw.FromVar(AArgs[0]));
end;

function TMonitor_DefaultSpinCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultSpinCount: Integer read <getter> write <s...

  if IsGet then
    Result := TMonitor.DefaultSpinCount
  else
    TMonitor.DefaultSpinCount := Integer(AArgs[0]);
end;

function TMonitor_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TMonitor_sw.Create as IDispatch;
end;

function TMonitor_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TMonitor;

  // Implicit record copy method.
  Result := TMonitor_sw.ToVar(TMonitor(AObj));
end;

class function TMonitor_sw.GetTypeName: WideString;
begin
  Result := 'TMonitor';
end;

function TMonitor_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TMonitor_sw.Create;
  TMonitor_sw(Result).FValue := FValue;
end;

class procedure TMonitor_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TMonitor_Copy_si, TMonitor_sw, 0, False);

  { Class members }

  AData.AddClassProcedure('SetSpinCount', TMonitor_SetSpinCount_si, 2, False);
  AData.AddClassProcedure('Enter', TMonitor_Enter_si, 1, False);
  AData.AddClassProcedure('Exit', TMonitor_Exit_si, 1, False);
  AData.AddClassFunction('TryEnter', TMonitor_TryEnter_si, nil, 1, False);
  AData.AddClassFunction('Wait', TMonitor_Wait_si, nil, 2, True);
  AData.AddClassProcedure('Pulse', TMonitor_Pulse_si, 1, False);
  AData.AddClassProcedure('PulseAll', TMonitor_PulseAll_si, 1, False);
  AData.AddClassProperty('DefaultSpinCount', TMonitor_DefaultSpinCount_si, Integer_sw, True, True, 0, False);
  AData.AddConstructor('Create', TMonitor_Create_si, 0, False);
end;

class function TMonitor_sw.ToVar(const AValue: TMonitor): OleVariant;
var
  wrpr: TMonitor_sw;
begin
  wrpr        := TMonitor_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TMonitor_sw.FromVar(const AValue: OleVariant): TMonitor;
begin
  Result := TMonitor_sw(ConvFromVar(AValue)).FValue;
end;

{ TInterfacedObject_sw }

function TInterfacedObject_RefCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RefCount: Integer read <getter>;

  Result := TInterfacedObject(AObj).RefCount;
end;

class function TInterfacedObject_sw.GetTypeName: WideString;
begin
  Result := 'TInterfacedObject';
end;

class function TInterfacedObject_sw.GetWrappedClass: TClass;
begin
  Result := TInterfacedObject;
end;

class procedure TInterfacedObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('RefCount', TInterfacedObject_RefCount_si, Integer_sw, True, False, 0, False, False);
end;

class function TInterfacedObject_sw.ToVar(
  const AValue: TInterfacedObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TInterfacedObject_sw.FromVar(
  const AValue: OleVariant): TInterfacedObject;
begin
  Result := TInterfacedObject(ConvFromVar(AValue, TInterfacedObject));
end;

class function TInterfacedObject_sw.ClassToVar(
  AClass: TInterfacedObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TInterfacedObject_sw.ClassFromVar(
  const AClass: OleVariant): TInterfacedObject_sc;
begin
  Result := TInterfacedObject_sc(ConvClsFromVar(AClass, TInterfacedObject));
end;

{ TInterfacedClass_sw }

class function TInterfacedClass_sw.GetTypeName: WideString;
begin
  Result := 'TInterfacedClass';
end;

class function TInterfacedClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TInterfacedObject;
end;

class function TInterfacedClass_sw.ToVar(
  const AValue: TInterfacedClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TInterfacedClass_sw.FromVar(
  const AValue: OleVariant): TInterfacedClass;
begin
  Result := TInterfacedClass(ConvFromVar(AValue, TInterfacedObject));
end;

{ TAggregatedObject_sw }

class function TAggregatedObject_sw.GetTypeName: WideString;
begin
  Result := 'TAggregatedObject';
end;

class function TAggregatedObject_sw.GetWrappedClass: TClass;
begin
  Result := TAggregatedObject;
end;

class procedure TAggregatedObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TAggregatedObject_sw.ToVar(
  const AValue: TAggregatedObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TAggregatedObject_sw.FromVar(
  const AValue: OleVariant): TAggregatedObject;
begin
  Result := TAggregatedObject(ConvFromVar(AValue, TAggregatedObject));
end;

class function TAggregatedObject_sw.ClassToVar(
  AClass: TAggregatedObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TAggregatedObject_sw.ClassFromVar(
  const AClass: OleVariant): TAggregatedObject_sc;
begin
  Result := TAggregatedObject_sc(ConvClsFromVar(AClass, TAggregatedObject));
end;

{ TContainedObject_sw }

class function TContainedObject_sw.GetTypeName: WideString;
begin
  Result := 'TContainedObject';
end;

class function TContainedObject_sw.GetWrappedClass: TClass;
begin
  Result := TContainedObject;
end;

class procedure TContainedObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TContainedObject_sw.ToVar(
  const AValue: TContainedObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TContainedObject_sw.FromVar(
  const AValue: OleVariant): TContainedObject;
begin
  Result := TContainedObject(ConvFromVar(AValue, TContainedObject));
end;

class function TContainedObject_sw.ClassToVar(
  AClass: TContainedObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TContainedObject_sw.ClassFromVar(
  const AClass: OleVariant): TContainedObject_sc;
begin
  Result := TContainedObject_sc(ConvClsFromVar(AClass, TContainedObject));
end;

{ TClassHelperBase_sw }

class function TClassHelperBase_sw.GetTypeName: WideString;
begin
  Result := 'TClassHelperBase';
end;

class function TClassHelperBase_sw.GetWrappedClass: TClass;
begin
  Result := TClassHelperBase;
end;

class procedure TClassHelperBase_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TClassHelperBase_sw.ToVar(
  const AValue: TClassHelperBase): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TClassHelperBase_sw.FromVar(
  const AValue: OleVariant): TClassHelperBase;
begin
  Result := TClassHelperBase(ConvFromVar(AValue, TClassHelperBase));
end;

class function TClassHelperBase_sw.ClassToVar(
  AClass: TClassHelperBase_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TClassHelperBase_sw.ClassFromVar(
  const AClass: OleVariant): TClassHelperBase_sc;
begin
  Result := TClassHelperBase_sc(ConvClsFromVar(AClass, TClassHelperBase));
end;

{ TClassHelperBaseClass_sw }

class function TClassHelperBaseClass_sw.GetTypeName: WideString;
begin
  Result := 'TClassHelperBaseClass';
end;

class function TClassHelperBaseClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TClassHelperBase;
end;

class function TClassHelperBaseClass_sw.ToVar(
  const AValue: TClassHelperBaseClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TClassHelperBaseClass_sw.FromVar(
  const AValue: OleVariant): TClassHelperBaseClass;
begin
  Result := TClassHelperBaseClass(ConvFromVar(AValue, TClassHelperBase));
end;

{ UCS4Char_sw }

class function UCS4Char_sw.GetTypeName: WideString;
begin
  Result := 'UCS4Char';
end;

class function UCS4Char_sw.ToVar(const AValue: UCS4Char): OleVariant;
begin
  Result := LongWord_sw.ToVar(LongWord(AValue));
end;

class function UCS4Char_sw.FromVar(const AValue: OleVariant): UCS4Char;
begin
  Result := UCS4Char(LongWord_sw.FromVar(AValue));
end;

{ UTF8String_sw }

class function UTF8String_sw.GetTypeName: WideString;
begin
  Result := 'UTF8String';
end;

class function UTF8String_sw.ToVar(const AValue: UTF8String): OleVariant;
begin
  Result := AnsiString_sw.ToVar(AnsiString(AValue));
end;

class function UTF8String_sw.FromVar(const AValue: OleVariant): UTF8String;
begin
  Result := UTF8String(AnsiString_sw.FromVar(AValue));
end;

{ RawByteString_sw }

class function RawByteString_sw.GetTypeName: WideString;
begin
  Result := 'RawByteString';
end;

class function RawByteString_sw.ToVar(const AValue: RawByteString): OleVariant;
begin
  Result := AnsiString_sw.ToVar(AnsiString(AValue));
end;

class function RawByteString_sw.FromVar(
  const AValue: OleVariant): RawByteString;
begin
  Result := RawByteString(AnsiString_sw.FromVar(AValue));
end;

{ TDateTime_sw }

class function TDateTime_sw.GetTypeName: WideString;
begin
  Result := 'TDateTime';
end;

class function TDateTime_sw.ToVar(const AValue: TDateTime): OleVariant;
begin
  Result := Double_sw.ToVar(Double(AValue));
end;

class function TDateTime_sw.FromVar(const AValue: OleVariant): TDateTime;
begin
  Result := TDateTime(Double_sw.FromVar(AValue));
end;

{ TDate_sw }

class function TDate_sw.GetTypeName: WideString;
begin
  Result := 'TDate';
end;

class function TDate_sw.ToVar(const AValue: TDate): OleVariant;
begin
  Result := TDateTime_sw.ToVar(TDateTime(AValue));
end;

class function TDate_sw.FromVar(const AValue: OleVariant): TDate;
begin
  Result := TDate(TDateTime_sw.FromVar(AValue));
end;

{ TTime_sw }

class function TTime_sw.GetTypeName: WideString;
begin
  Result := 'TTime';
end;

class function TTime_sw.ToVar(const AValue: TTime): OleVariant;
begin
  Result := TDateTime_sw.ToVar(TDateTime(AValue));
end;

class function TTime_sw.FromVar(const AValue: OleVariant): TTime;
begin
  Result := TTime(TDateTime_sw.FromVar(AValue));
end;

{ TVarArrayBound_sw }

function TVarArrayBound_ElementCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ElementCount: Longint;

  if IsGet then
    Result := TVarArrayBound_sw(AObj).FValue.ElementCount
  else
    TVarArrayBound_sw(AObj).FValue.ElementCount := Longint(AArgs[0]);
end;

function TVarArrayBound_LowBound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LowBound: Longint;

  if IsGet then
    Result := TVarArrayBound_sw(AObj).FValue.LowBound
  else
    TVarArrayBound_sw(AObj).FValue.LowBound := Longint(AArgs[0]);
end;

function TVarArrayBound_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TVarArrayBound_sw.Create as IDispatch;
end;

function TVarArrayBound_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TVarArrayBound;

  // Implicit record copy method.
  Result := TVarArrayBound_sw.ToVar(TVarArrayBound(AObj));
end;

class function TVarArrayBound_sw.GetTypeName: WideString;
begin
  Result := 'TVarArrayBound';
end;

function TVarArrayBound_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVarArrayBound_sw.Create;
  TVarArrayBound_sw(Result).FValue := FValue;
end;

class procedure TVarArrayBound_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ElementCount', TVarArrayBound_ElementCount_si, Longint_sw);
  AData.AddField('LowBound', TVarArrayBound_LowBound_si, Longint_sw);
  AData.AddFunction('Copy', TVarArrayBound_Copy_si, TVarArrayBound_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TVarArrayBound_Create_si, 0, False);
end;

class function TVarArrayBound_sw.ToVar(
  const AValue: TVarArrayBound): OleVariant;
var
  wrpr: TVarArrayBound_sw;
begin
  wrpr        := TVarArrayBound_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVarArrayBound_sw.FromVar(
  const AValue: OleVariant): TVarArrayBound;
begin
  Result := TVarArrayBound_sw(ConvFromVar(AValue)).FValue;
end;

{ TVarArray_sw }

function TVarArray_DimCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DimCount: Word;

  if IsGet then
    Result := TVarArray_sw(AObj).FValue.DimCount
  else
    TVarArray_sw(AObj).FValue.DimCount := Word(AArgs[0]);
end;

function TVarArray_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: Word;

  if IsGet then
    Result := TVarArray_sw(AObj).FValue.Flags
  else
    TVarArray_sw(AObj).FValue.Flags := Word(AArgs[0]);
end;

function TVarArray_ElementSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ElementSize: Integer;

  if IsGet then
    Result := TVarArray_sw(AObj).FValue.ElementSize
  else
    TVarArray_sw(AObj).FValue.ElementSize := Integer(AArgs[0]);
end;

function TVarArray_LockCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LockCount: Integer;

  if IsGet then
    Result := TVarArray_sw(AObj).FValue.LockCount
  else
    TVarArray_sw(AObj).FValue.LockCount := Integer(AArgs[0]);
end;

function TVarArray_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TVarArray_sw.Create as IDispatch;
end;

function TVarArray_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TVarArray;

  // Implicit record copy method.
  Result := TVarArray_sw.ToVar(TVarArray(AObj));
end;

class function TVarArray_sw.GetTypeName: WideString;
begin
  Result := 'TVarArray';
end;

function TVarArray_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVarArray_sw.Create;
  TVarArray_sw(Result).FValue := FValue;
end;

class procedure TVarArray_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('DimCount', TVarArray_DimCount_si, Word_sw);
  AData.AddField('Flags', TVarArray_Flags_si, Word_sw);
  AData.AddField('ElementSize', TVarArray_ElementSize_si, Integer_sw);
  AData.AddField('LockCount', TVarArray_LockCount_si, Integer_sw);
  AData.AddFunction('Copy', TVarArray_Copy_si, TVarArray_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TVarArray_Create_si, 0, False);
end;

class function TVarArray_sw.ToVar(const AValue: TVarArray): OleVariant;
var
  wrpr: TVarArray_sw;
begin
  wrpr        := TVarArray_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVarArray_sw.FromVar(const AValue: OleVariant): TVarArray;
begin
  Result := TVarArray_sw(ConvFromVar(AValue)).FValue;
end;

{ TVarRecord_sw }

function TVarRecord_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TVarRecord_sw.Create as IDispatch;
end;

function TVarRecord_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TVarRecord;

  // Implicit record copy method.
  Result := TVarRecord_sw.ToVar(TVarRecord(AObj));
end;

class function TVarRecord_sw.GetTypeName: WideString;
begin
  Result := 'TVarRecord';
end;

function TVarRecord_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVarRecord_sw.Create;
  TVarRecord_sw(Result).FValue := FValue;
end;

class procedure TVarRecord_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TVarRecord_Copy_si, TVarRecord_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TVarRecord_Create_si, 0, False);
end;

class function TVarRecord_sw.ToVar(const AValue: TVarRecord): OleVariant;
var
  wrpr: TVarRecord_sw;
begin
  wrpr        := TVarRecord_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVarRecord_sw.FromVar(const AValue: OleVariant): TVarRecord;
begin
  Result := TVarRecord_sw(ConvFromVar(AValue)).FValue;
end;

{ TLargestVarData_sw }

function TLargestVarData_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TLargestVarData_sw.Create as IDispatch;
end;

function TLargestVarData_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TLargestVarData;

  // Implicit record copy method.
  Result := TLargestVarData_sw.ToVar(TLargestVarData(AObj));
end;

class function TLargestVarData_sw.GetTypeName: WideString;
begin
  Result := 'TLargestVarData';
end;

function TLargestVarData_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TLargestVarData_sw.Create;
  TLargestVarData_sw(Result).FValue := FValue;
end;

class procedure TLargestVarData_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TLargestVarData_Copy_si, TLargestVarData_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TLargestVarData_Create_si, 0, False);
end;

class function TLargestVarData_sw.ToVar(
  const AValue: TLargestVarData): OleVariant;
var
  wrpr: TLargestVarData_sw;
begin
  wrpr        := TLargestVarData_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TLargestVarData_sw.FromVar(
  const AValue: OleVariant): TLargestVarData;
begin
  Result := TLargestVarData_sw(ConvFromVar(AValue)).FValue;
end;

{ TVarData_sw }

function TVarData_VType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VType: TVarType;

  if IsGet then
    Result := TVarType_sw.ToVar(TVarData_sw(AObj).FValue.VType)
  else
    TVarData_sw(AObj).FValue.VType := TVarType_sw.FromVar(AArgs[0]);
end;

function TVarData_Reserved1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved1: Word;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.Reserved1
  else
    TVarData_sw(AObj).FValue.Reserved1 := Word(AArgs[0]);
end;

function TVarData_Reserved2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved2: Word;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.Reserved2
  else
    TVarData_sw(AObj).FValue.Reserved2 := Word(AArgs[0]);
end;

function TVarData_Reserved3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved3: Word;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.Reserved3
  else
    TVarData_sw(AObj).FValue.Reserved3 := Word(AArgs[0]);
end;

function TVarData_VSmallInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VSmallInt: SmallInt;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VSmallInt
  else
    TVarData_sw(AObj).FValue.VSmallInt := SmallInt(AArgs[0]);
end;

function TVarData_VInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VInteger: Integer;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VInteger
  else
    TVarData_sw(AObj).FValue.VInteger := Integer(AArgs[0]);
end;

function TVarData_VSingle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VSingle: Single;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VSingle
  else
    TVarData_sw(AObj).FValue.VSingle := Single(AArgs[0]);
end;

function TVarData_VDouble_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VDouble: Double;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VDouble
  else
    TVarData_sw(AObj).FValue.VDouble := Double(AArgs[0]);
end;

function TVarData_VCurrency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VCurrency: Currency;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VCurrency
  else
    TVarData_sw(AObj).FValue.VCurrency := Currency(AArgs[0]);
end;

function TVarData_VDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VDate: TDateTime;

  if IsGet then
    Result := TDateTime_sw.ToVar(TVarData_sw(AObj).FValue.VDate)
  else
    TVarData_sw(AObj).FValue.VDate := TDateTime_sw.FromVar(AArgs[0]);
end;

function TVarData_VError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VError: HRESULT;

  if IsGet then
    Result := HRESULT_sw.ToVar(TVarData_sw(AObj).FValue.VError)
  else
    TVarData_sw(AObj).FValue.VError := HRESULT_sw.FromVar(AArgs[0]);
end;

function TVarData_VBoolean_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VBoolean: WordBool;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VBoolean
  else
    TVarData_sw(AObj).FValue.VBoolean := WordBool(AArgs[0]);
end;

function TVarData_VShortInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VShortInt: ShortInt;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VShortInt
  else
    TVarData_sw(AObj).FValue.VShortInt := ShortInt(AArgs[0]);
end;

function TVarData_VByte_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VByte: Byte;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VByte
  else
    TVarData_sw(AObj).FValue.VByte := Byte(AArgs[0]);
end;

function TVarData_VWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VWord: Word;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VWord
  else
    TVarData_sw(AObj).FValue.VWord := Word(AArgs[0]);
end;

function TVarData_VLongWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VLongWord: LongWord;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VLongWord
  else
    TVarData_sw(AObj).FValue.VLongWord := LongWord(AArgs[0]);
end;

function TVarData_VInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VInt64: Int64;

  if IsGet then
    Result := Int64_sw.ToVar(TVarData_sw(AObj).FValue.VInt64)
  else
    TVarData_sw(AObj).FValue.VInt64 := Int64_sw.FromVar(AArgs[0]);
end;

function TVarData_VUInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VUInt64: UInt64;

  if IsGet then
    Result := UInt64_sw.ToVar(TVarData_sw(AObj).FValue.VUInt64)
  else
    TVarData_sw(AObj).FValue.VUInt64 := UInt64_sw.FromVar(AArgs[0]);
end;

function TVarData_VRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VRecord: TVarRecord;

  if IsGet then
    Result := TVarRecord_sw.ToVar(TVarData_sw(AObj).FValue.VRecord)
  else
    TVarData_sw(AObj).FValue.VRecord := TVarRecord_sw.FromVar(AArgs[0]);
end;

function TVarData_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TVarData_sw.Create as IDispatch;
end;

function TVarData_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TVarData;

  // Implicit record copy method.
  Result := TVarData_sw.ToVar(TVarData(AObj));
end;

class function TVarData_sw.GetTypeName: WideString;
begin
  Result := 'TVarData';
end;

function TVarData_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVarData_sw.Create;
  TVarData_sw(Result).FValue := FValue;
end;

class procedure TVarData_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('VType', TVarData_VType_si, TVarType_sw);
  AData.AddField('Reserved1', TVarData_Reserved1_si, Word_sw);
  AData.AddField('Reserved2', TVarData_Reserved2_si, Word_sw);
  AData.AddField('Reserved3', TVarData_Reserved3_si, Word_sw);
  AData.AddField('VSmallInt', TVarData_VSmallInt_si, SmallInt_sw);
  AData.AddField('VInteger', TVarData_VInteger_si, Integer_sw);
  AData.AddField('VSingle', TVarData_VSingle_si, Single_sw);
  AData.AddField('VDouble', TVarData_VDouble_si, Double_sw);
  AData.AddField('VCurrency', TVarData_VCurrency_si, Currency_sw);
  AData.AddField('VDate', TVarData_VDate_si, TDateTime_sw);
  AData.AddField('VError', TVarData_VError_si, HRESULT_sw);
  AData.AddField('VBoolean', TVarData_VBoolean_si, WordBool_sw);
  AData.AddField('VShortInt', TVarData_VShortInt_si, ShortInt_sw);
  AData.AddField('VByte', TVarData_VByte_si, Byte_sw);
  AData.AddField('VWord', TVarData_VWord_si, Word_sw);
  AData.AddField('VLongWord', TVarData_VLongWord_si, LongWord_sw);
  AData.AddField('VInt64', TVarData_VInt64_si, Int64_sw);
  AData.AddField('VUInt64', TVarData_VUInt64_si, UInt64_sw);
  AData.AddField('VRecord', TVarData_VRecord_si, TVarRecord_sw);
  AData.AddFunction('Copy', TVarData_Copy_si, TVarData_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TVarData_Create_si, 0, False);
end;

class function TVarData_sw.ToVar(const AValue: TVarData): OleVariant;
var
  wrpr: TVarData_sw;
begin
  wrpr        := TVarData_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVarData_sw.FromVar(const AValue: OleVariant): TVarData;
begin
  Result := TVarData_sw(ConvFromVar(AValue)).FValue;
end;

{ TCallDesc_sw }

function TCallDesc_CallType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CallType: Byte;

  if IsGet then
    Result := TCallDesc_sw(AObj).FValue.CallType
  else
    TCallDesc_sw(AObj).FValue.CallType := Byte(AArgs[0]);
end;

function TCallDesc_ArgCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ArgCount: Byte;

  if IsGet then
    Result := TCallDesc_sw(AObj).FValue.ArgCount
  else
    TCallDesc_sw(AObj).FValue.ArgCount := Byte(AArgs[0]);
end;

function TCallDesc_NamedArgCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var NamedArgCount: Byte;

  if IsGet then
    Result := TCallDesc_sw(AObj).FValue.NamedArgCount
  else
    TCallDesc_sw(AObj).FValue.NamedArgCount := Byte(AArgs[0]);
end;

function TCallDesc_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCallDesc_sw.Create as IDispatch;
end;

function TCallDesc_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCallDesc;

  // Implicit record copy method.
  Result := TCallDesc_sw.ToVar(TCallDesc(AObj));
end;

class function TCallDesc_sw.GetTypeName: WideString;
begin
  Result := 'TCallDesc';
end;

function TCallDesc_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCallDesc_sw.Create;
  TCallDesc_sw(Result).FValue := FValue;
end;

class procedure TCallDesc_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('CallType', TCallDesc_CallType_si, Byte_sw);
  AData.AddField('ArgCount', TCallDesc_ArgCount_si, Byte_sw);
  AData.AddField('NamedArgCount', TCallDesc_NamedArgCount_si, Byte_sw);
  AData.AddFunction('Copy', TCallDesc_Copy_si, TCallDesc_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCallDesc_Create_si, 0, False);
end;

class function TCallDesc_sw.ToVar(const AValue: TCallDesc): OleVariant;
var
  wrpr: TCallDesc_sw;
begin
  wrpr        := TCallDesc_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCallDesc_sw.FromVar(const AValue: OleVariant): TCallDesc;
begin
  Result := TCallDesc_sw(ConvFromVar(AValue)).FValue;
end;

{ TDispDesc_sw }

function TDispDesc_DispID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DispID: Integer;

  if IsGet then
    Result := TDispDesc_sw(AObj).FValue.DispID
  else
    TDispDesc_sw(AObj).FValue.DispID := Integer(AArgs[0]);
end;

function TDispDesc_ResType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ResType: Byte;

  if IsGet then
    Result := TDispDesc_sw(AObj).FValue.ResType
  else
    TDispDesc_sw(AObj).FValue.ResType := Byte(AArgs[0]);
end;

function TDispDesc_CallDesc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CallDesc: TCallDesc;

  if IsGet then
    Result := TCallDesc_sw.ToVar(TDispDesc_sw(AObj).FValue.CallDesc)
  else
    TDispDesc_sw(AObj).FValue.CallDesc := TCallDesc_sw.FromVar(AArgs[0]);
end;

function TDispDesc_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TDispDesc_sw.Create as IDispatch;
end;

function TDispDesc_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TDispDesc;

  // Implicit record copy method.
  Result := TDispDesc_sw.ToVar(TDispDesc(AObj));
end;

class function TDispDesc_sw.GetTypeName: WideString;
begin
  Result := 'TDispDesc';
end;

function TDispDesc_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TDispDesc_sw.Create;
  TDispDesc_sw(Result).FValue := FValue;
end;

class procedure TDispDesc_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('DispID', TDispDesc_DispID_si, Integer_sw);
  AData.AddField('ResType', TDispDesc_ResType_si, Byte_sw);
  AData.AddField('CallDesc', TDispDesc_CallDesc_si, TCallDesc_sw);
  AData.AddFunction('Copy', TDispDesc_Copy_si, TDispDesc_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TDispDesc_Create_si, 0, False);
end;

class function TDispDesc_sw.ToVar(const AValue: TDispDesc): OleVariant;
var
  wrpr: TDispDesc_sw;
begin
  wrpr        := TDispDesc_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TDispDesc_sw.FromVar(const AValue: OleVariant): TDispDesc;
begin
  Result := TDispDesc_sw(ConvFromVar(AValue)).FValue;
end;

{ TVariantManager_sw }

function TVariantManager_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TVariantManager_sw.Create as IDispatch;
end;

function TVariantManager_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TVariantManager;

  // Implicit record copy method.
  Result := TVariantManager_sw.ToVar(TVariantManager(AObj));
end;

class function TVariantManager_sw.GetTypeName: WideString;
begin
  Result := 'TVariantManager';
end;

function TVariantManager_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVariantManager_sw.Create;
  TVariantManager_sw(Result).FValue := FValue;
end;

class procedure TVariantManager_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TVariantManager_Copy_si, TVariantManager_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TVariantManager_Create_si, 0, False);
end;

class function TVariantManager_sw.ToVar(
  const AValue: TVariantManager): OleVariant;
var
  wrpr: TVariantManager_sw;
begin
  wrpr        := TVariantManager_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVariantManager_sw.FromVar(
  const AValue: OleVariant): TVariantManager;
begin
  Result := TVariantManager_sw(ConvFromVar(AValue)).FValue;
end;

{ TTypeKind_sw }

class function TTypeKind_sw.GetTypeName: WideString;
begin
  Result := 'TTypeKind';
end;

class procedure TTypeKind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..21] of TLMDEnumerator = (
    (Name: 'tkUnknown'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkUnknown)),
    (Name: 'tkInteger'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkInteger)),
    (Name: 'tkChar'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkChar)),
    (Name: 'tkEnumeration'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkEnumeration)),
    (Name: 'tkFloat'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkFloat)),
    (Name: 'tkString'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkString)),
    (Name: 'tkSet'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkSet)),
    (Name: 'tkClass'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkClass)),
    (Name: 'tkMethod'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkMethod)),
    (Name: 'tkWChar'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkWChar)),
    (Name: 'tkLString'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkLString)),
    (Name: 'tkWString'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkWString)),
    (Name: 'tkVariant'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkVariant)),
    (Name: 'tkArray'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkArray)),
    (Name: 'tkRecord'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkRecord)),
    (Name: 'tkInterface'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkInterface)),
    (Name: 'tkInt64'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkInt64)),
    (Name: 'tkDynArray'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkDynArray)),
    (Name: 'tkUString'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkUString)),
    (Name: 'tkClassRef'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkClassRef)),
    (Name: 'tkPointer'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkPointer)),
    (Name: 'tkProcedure'; Value: Integer({$IFDEF LMDSCT_12}TTypeKind.{$ENDIF}tkProcedure))
  );
begin
  AEnums := @ENUMS;
  ACount := 22;
end;

class function TTypeKind_sw.ToVar(const AValue: TTypeKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTypeKind_sw.FromVar(const AValue: OleVariant): TTypeKind;
begin
  Result := TTypeKind(Integer(AValue));
end;

{ TDynArrayTypeInfo_sw }

function TDynArrayTypeInfo_kind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var kind: TTypeKind;

  if IsGet then
    Result := TTypeKind_sw.ToVar(TDynArrayTypeInfo_sw(AObj).FValue.kind)
  else
    TDynArrayTypeInfo_sw(AObj).FValue.kind := TTypeKind_sw.FromVar(AArgs[0]);
end;

function TDynArrayTypeInfo_name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var name: Byte;

  if IsGet then
    Result := TDynArrayTypeInfo_sw(AObj).FValue.name
  else
    TDynArrayTypeInfo_sw(AObj).FValue.name := Byte(AArgs[0]);
end;

function TDynArrayTypeInfo_elSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var elSize: Longint;

  if IsGet then
    Result := TDynArrayTypeInfo_sw(AObj).FValue.elSize
  else
    TDynArrayTypeInfo_sw(AObj).FValue.elSize := Longint(AArgs[0]);
end;

function TDynArrayTypeInfo_varType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var varType: Integer;

  if IsGet then
    Result := TDynArrayTypeInfo_sw(AObj).FValue.varType
  else
    TDynArrayTypeInfo_sw(AObj).FValue.varType := Integer(AArgs[0]);
end;

function TDynArrayTypeInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TDynArrayTypeInfo_sw.Create as IDispatch;
end;

function TDynArrayTypeInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TDynArrayTypeInfo;

  // Implicit record copy method.
  Result := TDynArrayTypeInfo_sw.ToVar(TDynArrayTypeInfo(AObj));
end;

class function TDynArrayTypeInfo_sw.GetTypeName: WideString;
begin
  Result := 'TDynArrayTypeInfo';
end;

function TDynArrayTypeInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TDynArrayTypeInfo_sw.Create;
  TDynArrayTypeInfo_sw(Result).FValue := FValue;
end;

class procedure TDynArrayTypeInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('kind', TDynArrayTypeInfo_kind_si, TTypeKind_sw);
  AData.AddField('name', TDynArrayTypeInfo_name_si, Byte_sw);
  AData.AddField('elSize', TDynArrayTypeInfo_elSize_si, Longint_sw);
  AData.AddField('varType', TDynArrayTypeInfo_varType_si, Integer_sw);
  AData.AddFunction('Copy', TDynArrayTypeInfo_Copy_si, TDynArrayTypeInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TDynArrayTypeInfo_Create_si, 0, False);
end;

class function TDynArrayTypeInfo_sw.ToVar(
  const AValue: TDynArrayTypeInfo): OleVariant;
var
  wrpr: TDynArrayTypeInfo_sw;
begin
  wrpr        := TDynArrayTypeInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TDynArrayTypeInfo_sw.FromVar(
  const AValue: OleVariant): TDynArrayTypeInfo;
begin
  Result := TDynArrayTypeInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TVarRec_sw }

function TVarRec_VInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VInteger: Integer;

  if IsGet then
    Result := TVarRec_sw(AObj).FValue.VInteger
  else
    TVarRec_sw(AObj).FValue.VInteger := Integer(AArgs[0]);
end;

function TVarRec_VBoolean_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VBoolean: Boolean;

  if IsGet then
    Result := TVarRec_sw(AObj).FValue.VBoolean
  else
    TVarRec_sw(AObj).FValue.VBoolean := Boolean(AArgs[0]);
end;

function TVarRec_VChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VChar: _AnsiChr;

  if IsGet then
    Result := _AnsiChr_sw.ToVar(TVarRec_sw(AObj).FValue.VChar)
  else
    TVarRec_sw(AObj).FValue.VChar := _AnsiChr_sw.FromVar(AArgs[0]);
end;

function TVarRec_VObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VObject: TObject;

  if IsGet then
    Result := TObject_sw.ToVar(TVarRec_sw(AObj).FValue.VObject)
  else
    TVarRec_sw(AObj).FValue.VObject := TObject_sw.FromVar(AArgs[0]);
end;

function TVarRec_VClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VClass: TClass;

  if IsGet then
    Result := TClass_sw.ToVar(TVarRec_sw(AObj).FValue.VClass)
  else
    TVarRec_sw(AObj).FValue.VClass := TClass_sw.FromVar(AArgs[0]);
end;

function TVarRec_VWideChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VWideChar: WideChar;

  if IsGet then
    Result := Ord(TVarRec_sw(AObj).FValue.VWideChar)
  else
    TVarRec_sw(AObj).FValue.VWideChar := WideChar(Integer(AArgs[0]));
end;

function TVarRec__Reserved1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var _Reserved1: NativeInt;

  if IsGet then
    Result := NativeInt_sw.ToVar(TVarRec_sw(AObj).FValue._Reserved1)
  else
    TVarRec_sw(AObj).FValue._Reserved1 := NativeInt_sw.FromVar(AArgs[0]);
end;

function TVarRec_VType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VType: Byte;

  if IsGet then
    Result := TVarRec_sw(AObj).FValue.VType
  else
    TVarRec_sw(AObj).FValue.VType := Byte(AArgs[0]);
end;

function TVarRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TVarRec_sw.Create as IDispatch;
end;

function TVarRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TVarRec;

  // Implicit record copy method.
  Result := TVarRec_sw.ToVar(TVarRec(AObj));
end;

class function TVarRec_sw.GetTypeName: WideString;
begin
  Result := 'TVarRec';
end;

function TVarRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVarRec_sw.Create;
  TVarRec_sw(Result).FValue := FValue;
end;

class procedure TVarRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('VInteger', TVarRec_VInteger_si, Integer_sw);
  AData.AddField('VBoolean', TVarRec_VBoolean_si, Boolean_sw);
  AData.AddField('VChar', TVarRec_VChar_si, _AnsiChr_sw);
  AData.AddField('VObject', TVarRec_VObject_si, TObject_sw);
  AData.AddField('VClass', TVarRec_VClass_si, TClass_sw);
  AData.AddField('VWideChar', TVarRec_VWideChar_si, WideChar_sw);
  AData.AddField('_Reserved1', TVarRec__Reserved1_si, NativeInt_sw);
  AData.AddField('VType', TVarRec_VType_si, Byte_sw);
  AData.AddFunction('Copy', TVarRec_Copy_si, TVarRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TVarRec_Create_si, 0, False);
end;

class function TVarRec_sw.ToVar(const AValue: TVarRec): OleVariant;
var
  wrpr: TVarRec_sw;
begin
  wrpr        := TVarRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVarRec_sw.FromVar(const AValue: OleVariant): TVarRec;
begin
  Result := TVarRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TMemoryManager_sw }

function TMemoryManager_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TMemoryManager_sw.Create as IDispatch;
end;

function TMemoryManager_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TMemoryManager;

  // Implicit record copy method.
  Result := TMemoryManager_sw.ToVar(TMemoryManager(AObj));
end;

class function TMemoryManager_sw.GetTypeName: WideString;
begin
  Result := 'TMemoryManager';
end;

function TMemoryManager_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TMemoryManager_sw.Create;
  TMemoryManager_sw(Result).FValue := FValue;
end;

class procedure TMemoryManager_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TMemoryManager_Copy_si, TMemoryManager_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TMemoryManager_Create_si, 0, False);
end;

class function TMemoryManager_sw.ToVar(
  const AValue: TMemoryManager): OleVariant;
var
  wrpr: TMemoryManager_sw;
begin
  wrpr        := TMemoryManager_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TMemoryManager_sw.FromVar(
  const AValue: OleVariant): TMemoryManager;
begin
  Result := TMemoryManager_sw(ConvFromVar(AValue)).FValue;
end;

{ TMemoryManagerEx_sw }

function TMemoryManagerEx_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TMemoryManagerEx_sw.Create as IDispatch;
end;

function TMemoryManagerEx_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TMemoryManagerEx;

  // Implicit record copy method.
  Result := TMemoryManagerEx_sw.ToVar(TMemoryManagerEx(AObj));
end;

class function TMemoryManagerEx_sw.GetTypeName: WideString;
begin
  Result := 'TMemoryManagerEx';
end;

function TMemoryManagerEx_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TMemoryManagerEx_sw.Create;
  TMemoryManagerEx_sw(Result).FValue := FValue;
end;

class procedure TMemoryManagerEx_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TMemoryManagerEx_Copy_si, TMemoryManagerEx_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TMemoryManagerEx_Create_si, 0, False);
end;

class function TMemoryManagerEx_sw.ToVar(
  const AValue: TMemoryManagerEx): OleVariant;
var
  wrpr: TMemoryManagerEx_sw;
begin
  wrpr        := TMemoryManagerEx_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TMemoryManagerEx_sw.FromVar(
  const AValue: OleVariant): TMemoryManagerEx;
begin
  Result := TMemoryManagerEx_sw(ConvFromVar(AValue)).FValue;
end;

{ THeapStatus_sw }

function THeapStatus_TotalAddrSpace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TotalAddrSpace: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(THeapStatus_sw(AObj).FValue.TotalAddrSpace)
  else
    THeapStatus_sw(AObj).FValue.TotalAddrSpace := NativeUInt_sw.FromVar(
      AArgs[0]);
end;

function THeapStatus_TotalUncommitted_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TotalUncommitted: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(THeapStatus_sw(AObj).FValue.TotalUncommitted)
  else
    THeapStatus_sw(AObj).FValue.TotalUncommitted := NativeUInt_sw.FromVar(
      AArgs[0]);
end;

function THeapStatus_TotalCommitted_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TotalCommitted: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(THeapStatus_sw(AObj).FValue.TotalCommitted)
  else
    THeapStatus_sw(AObj).FValue.TotalCommitted := NativeUInt_sw.FromVar(
      AArgs[0]);
end;

function THeapStatus_TotalAllocated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TotalAllocated: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(THeapStatus_sw(AObj).FValue.TotalAllocated)
  else
    THeapStatus_sw(AObj).FValue.TotalAllocated := NativeUInt_sw.FromVar(
      AArgs[0]);
end;

function THeapStatus_TotalFree_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TotalFree: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(THeapStatus_sw(AObj).FValue.TotalFree)
  else
    THeapStatus_sw(AObj).FValue.TotalFree := NativeUInt_sw.FromVar(AArgs[0]);
end;

function THeapStatus_FreeSmall_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FreeSmall: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(THeapStatus_sw(AObj).FValue.FreeSmall)
  else
    THeapStatus_sw(AObj).FValue.FreeSmall := NativeUInt_sw.FromVar(AArgs[0]);
end;

function THeapStatus_FreeBig_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FreeBig: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(THeapStatus_sw(AObj).FValue.FreeBig)
  else
    THeapStatus_sw(AObj).FValue.FreeBig := NativeUInt_sw.FromVar(AArgs[0]);
end;

function THeapStatus_Unused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Unused: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(THeapStatus_sw(AObj).FValue.Unused)
  else
    THeapStatus_sw(AObj).FValue.Unused := NativeUInt_sw.FromVar(AArgs[0]);
end;

function THeapStatus_Overhead_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Overhead: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(THeapStatus_sw(AObj).FValue.Overhead)
  else
    THeapStatus_sw(AObj).FValue.Overhead := NativeUInt_sw.FromVar(AArgs[0]);
end;

function THeapStatus_HeapErrorCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HeapErrorCode: Cardinal;

  if IsGet then
    Result := THeapStatus_sw(AObj).FValue.HeapErrorCode
  else
    THeapStatus_sw(AObj).FValue.HeapErrorCode := Cardinal(AArgs[0]);
end;

function THeapStatus_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := THeapStatus_sw.Create as IDispatch;
end;

function THeapStatus_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: THeapStatus;

  // Implicit record copy method.
  Result := THeapStatus_sw.ToVar(THeapStatus(AObj));
end;

class function THeapStatus_sw.GetTypeName: WideString;
begin
  Result := 'THeapStatus';
end;

function THeapStatus_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := THeapStatus_sw.Create;
  THeapStatus_sw(Result).FValue := FValue;
end;

class procedure THeapStatus_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('TotalAddrSpace', THeapStatus_TotalAddrSpace_si, NativeUInt_sw);
  AData.AddField('TotalUncommitted', THeapStatus_TotalUncommitted_si, NativeUInt_sw);
  AData.AddField('TotalCommitted', THeapStatus_TotalCommitted_si, NativeUInt_sw);
  AData.AddField('TotalAllocated', THeapStatus_TotalAllocated_si, NativeUInt_sw);
  AData.AddField('TotalFree', THeapStatus_TotalFree_si, NativeUInt_sw);
  AData.AddField('FreeSmall', THeapStatus_FreeSmall_si, NativeUInt_sw);
  AData.AddField('FreeBig', THeapStatus_FreeBig_si, NativeUInt_sw);
  AData.AddField('Unused', THeapStatus_Unused_si, NativeUInt_sw);
  AData.AddField('Overhead', THeapStatus_Overhead_si, NativeUInt_sw);
  AData.AddField('HeapErrorCode', THeapStatus_HeapErrorCode_si, Cardinal_sw);
  AData.AddFunction('Copy', THeapStatus_Copy_si, THeapStatus_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', THeapStatus_Create_si, 0, False);
end;

class function THeapStatus_sw.ToVar(const AValue: THeapStatus): OleVariant;
var
  wrpr: THeapStatus_sw;
begin
  wrpr        := THeapStatus_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function THeapStatus_sw.FromVar(const AValue: OleVariant): THeapStatus;
begin
  Result := THeapStatus_sw(ConvFromVar(AValue)).FValue;
end;

{ TSmallBlockTypeState_sw }

function TSmallBlockTypeState_InternalBlockSize_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var InternalBlockSize: Cardinal;

  if IsGet then
    Result := TSmallBlockTypeState_sw(AObj).FValue.InternalBlockSize
  else
    TSmallBlockTypeState_sw(AObj).FValue.InternalBlockSize := Cardinal(
      AArgs[0]);
end;

function TSmallBlockTypeState_UseableBlockSize_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var UseableBlockSize: Cardinal;

  if IsGet then
    Result := TSmallBlockTypeState_sw(AObj).FValue.UseableBlockSize
  else
    TSmallBlockTypeState_sw(AObj).FValue.UseableBlockSize := Cardinal(AArgs[0]);
end;

function TSmallBlockTypeState_AllocatedBlockCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var AllocatedBlockCount: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(TSmallBlockTypeState_sw(AObj).FValue.
      AllocatedBlockCount)
  else
    TSmallBlockTypeState_sw(AObj).FValue.AllocatedBlockCount := NativeUInt_sw.
      FromVar(AArgs[0]);
end;

function TSmallBlockTypeState_ReservedAddressSpace_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ReservedAddressSpace: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(TSmallBlockTypeState_sw(AObj).FValue.
      ReservedAddressSpace)
  else
    TSmallBlockTypeState_sw(AObj).FValue.ReservedAddressSpace := NativeUInt_sw.
      FromVar(AArgs[0]);
end;

function TSmallBlockTypeState_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TSmallBlockTypeState_sw.Create as IDispatch;
end;

function TSmallBlockTypeState_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TSmallBlockTypeState;

  // Implicit record copy method.
  Result := TSmallBlockTypeState_sw.ToVar(TSmallBlockTypeState(AObj));
end;

class function TSmallBlockTypeState_sw.GetTypeName: WideString;
begin
  Result := 'TSmallBlockTypeState';
end;

function TSmallBlockTypeState_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TSmallBlockTypeState_sw.Create;
  TSmallBlockTypeState_sw(Result).FValue := FValue;
end;

class procedure TSmallBlockTypeState_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('InternalBlockSize', TSmallBlockTypeState_InternalBlockSize_si, Cardinal_sw);
  AData.AddField('UseableBlockSize', TSmallBlockTypeState_UseableBlockSize_si, Cardinal_sw);
  AData.AddField('AllocatedBlockCount', TSmallBlockTypeState_AllocatedBlockCount_si, NativeUInt_sw);
  AData.AddField('ReservedAddressSpace', TSmallBlockTypeState_ReservedAddressSpace_si, NativeUInt_sw);
  AData.AddFunction('Copy', TSmallBlockTypeState_Copy_si, TSmallBlockTypeState_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TSmallBlockTypeState_Create_si, 0, False);
end;

class function TSmallBlockTypeState_sw.ToVar(
  const AValue: TSmallBlockTypeState): OleVariant;
var
  wrpr: TSmallBlockTypeState_sw;
begin
  wrpr        := TSmallBlockTypeState_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TSmallBlockTypeState_sw.FromVar(
  const AValue: OleVariant): TSmallBlockTypeState;
begin
  Result := TSmallBlockTypeState_sw(ConvFromVar(AValue)).FValue;
end;

{ TMemoryManagerState_sw }

function TMemoryManagerState_AllocatedMediumBlockCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var AllocatedMediumBlockCount: Cardinal;

  if IsGet then
    Result := TMemoryManagerState_sw(AObj).FValue.AllocatedMediumBlockCount
  else
    TMemoryManagerState_sw(AObj).FValue.AllocatedMediumBlockCount := Cardinal(
      AArgs[0]);
end;

function TMemoryManagerState_TotalAllocatedMediumBlockSize_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TotalAllocatedMediumBlockSize: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(TMemoryManagerState_sw(AObj).FValue.
      TotalAllocatedMediumBlockSize)
  else
    TMemoryManagerState_sw(AObj).FValue.TotalAllocatedMediumBlockSize := 
      NativeUInt_sw.FromVar(AArgs[0]);
end;

function TMemoryManagerState_ReservedMediumBlockAddressSpace_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ReservedMediumBlockAddressSpace: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(TMemoryManagerState_sw(AObj).FValue.
      ReservedMediumBlockAddressSpace)
  else
    TMemoryManagerState_sw(AObj).FValue.ReservedMediumBlockAddressSpace := 
      NativeUInt_sw.FromVar(AArgs[0]);
end;

function TMemoryManagerState_AllocatedLargeBlockCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var AllocatedLargeBlockCount: Cardinal;

  if IsGet then
    Result := TMemoryManagerState_sw(AObj).FValue.AllocatedLargeBlockCount
  else
    TMemoryManagerState_sw(AObj).FValue.AllocatedLargeBlockCount := Cardinal(
      AArgs[0]);
end;

function TMemoryManagerState_TotalAllocatedLargeBlockSize_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TotalAllocatedLargeBlockSize: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(TMemoryManagerState_sw(AObj).FValue.
      TotalAllocatedLargeBlockSize)
  else
    TMemoryManagerState_sw(AObj).FValue.TotalAllocatedLargeBlockSize := 
      NativeUInt_sw.FromVar(AArgs[0]);
end;

function TMemoryManagerState_ReservedLargeBlockAddressSpace_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ReservedLargeBlockAddressSpace: NativeUInt;

  if IsGet then
    Result := NativeUInt_sw.ToVar(TMemoryManagerState_sw(AObj).FValue.
      ReservedLargeBlockAddressSpace)
  else
    TMemoryManagerState_sw(AObj).FValue.ReservedLargeBlockAddressSpace := 
      NativeUInt_sw.FromVar(AArgs[0]);
end;

function TMemoryManagerState_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TMemoryManagerState_sw.Create as IDispatch;
end;

function TMemoryManagerState_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TMemoryManagerState;

  // Implicit record copy method.
  Result := TMemoryManagerState_sw.ToVar(TMemoryManagerState(AObj));
end;

class function TMemoryManagerState_sw.GetTypeName: WideString;
begin
  Result := 'TMemoryManagerState';
end;

function TMemoryManagerState_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TMemoryManagerState_sw.Create;
  TMemoryManagerState_sw(Result).FValue := FValue;
end;

class procedure TMemoryManagerState_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('AllocatedMediumBlockCount', TMemoryManagerState_AllocatedMediumBlockCount_si, Cardinal_sw);
  AData.AddField('TotalAllocatedMediumBlockSize', TMemoryManagerState_TotalAllocatedMediumBlockSize_si, NativeUInt_sw);
  AData.AddField('ReservedMediumBlockAddressSpace', TMemoryManagerState_ReservedMediumBlockAddressSpace_si, NativeUInt_sw);
  AData.AddField('AllocatedLargeBlockCount', TMemoryManagerState_AllocatedLargeBlockCount_si, Cardinal_sw);
  AData.AddField('TotalAllocatedLargeBlockSize', TMemoryManagerState_TotalAllocatedLargeBlockSize_si, NativeUInt_sw);
  AData.AddField('ReservedLargeBlockAddressSpace', TMemoryManagerState_ReservedLargeBlockAddressSpace_si, NativeUInt_sw);
  AData.AddFunction('Copy', TMemoryManagerState_Copy_si, TMemoryManagerState_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TMemoryManagerState_Create_si, 0, False);
end;

class function TMemoryManagerState_sw.ToVar(
  const AValue: TMemoryManagerState): OleVariant;
var
  wrpr: TMemoryManagerState_sw;
begin
  wrpr        := TMemoryManagerState_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TMemoryManagerState_sw.FromVar(
  const AValue: OleVariant): TMemoryManagerState;
begin
  Result := TMemoryManagerState_sw(ConvFromVar(AValue)).FValue;
end;

{ TMonitorSupport_sw }

function TMonitorSupport_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TMonitorSupport_sw.Create as IDispatch;
end;

function TMonitorSupport_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TMonitorSupport;

  // Implicit record copy method.
  Result := TMonitorSupport_sw.ToVar(TMonitorSupport(AObj));
end;

class function TMonitorSupport_sw.GetTypeName: WideString;
begin
  Result := 'TMonitorSupport';
end;

function TMonitorSupport_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TMonitorSupport_sw.Create;
  TMonitorSupport_sw(Result).FValue := FValue;
end;

class procedure TMonitorSupport_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TMonitorSupport_Copy_si, TMonitorSupport_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TMonitorSupport_Create_si, 0, False);
end;

class function TMonitorSupport_sw.ToVar(
  const AValue: TMonitorSupport): OleVariant;
var
  wrpr: TMonitorSupport_sw;
begin
  wrpr        := TMonitorSupport_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TMonitorSupport_sw.FromVar(
  const AValue: OleVariant): TMonitorSupport;
begin
  Result := TMonitorSupport_sw(ConvFromVar(AValue)).FValue;
end;

{ TPtrWrapper_sw }

function TPtrWrapper_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TPtrWrapper_sw.ToVar(TPtrWrapper.Create(NativeInt_sw.FromVar(
        AArgs[0])));
    end;
    0:
    begin
      // Implicit parameterless constructor.
      Result := TPtrWrapper_sw.Create as IDispatch;
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TPtrWrapper_ToInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ToInteger: NativeInt;

  Result := NativeInt_sw.ToVar(TPtrWrapper_sw(AObj).FValue.ToInteger());
end;

function TPtrWrapper_NilValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NilValue: TPtrWrapper read <getter>;

  Result := TPtrWrapper_sw.ToVar(TPtrWrapper.NilValue);
end;

function TPtrWrapper_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TPtrWrapper;

  // Implicit record copy method.
  Result := TPtrWrapper_sw.ToVar(TPtrWrapper(AObj));
end;

class function TPtrWrapper_sw.GetTypeName: WideString;
begin
  Result := 'TPtrWrapper';
end;

function TPtrWrapper_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPtrWrapper_sw.Create;
  TPtrWrapper_sw(Result).FValue := FValue;
end;

class procedure TPtrWrapper_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('ToInteger', TPtrWrapper_ToInteger_si, NativeInt_sw, 0, False);
  AData.AddFunction('Copy', TPtrWrapper_Copy_si, TPtrWrapper_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TPtrWrapper_Create_si, 0, True);
  AData.AddClassProperty('NilValue', TPtrWrapper_NilValue_si, TPtrWrapper_sw, True, False, 0, False);
end;

class function TPtrWrapper_sw.ToVar(const AValue: TPtrWrapper): OleVariant;
var
  wrpr: TPtrWrapper_sw;
begin
  wrpr        := TPtrWrapper_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TPtrWrapper_sw.FromVar(const AValue: OleVariant): TPtrWrapper;
begin
  Result := TPtrWrapper_sw(ConvFromVar(AValue)).FValue;
end;

{ TMarshal_sw }

function TMarshal_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TMarshal_sw.ToVar(TMarshal_sc(AObj).Create());
end;

function TMarshal_AsAnsi_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function AsAnsi(...); overload;

  Result := _AnsiStr_sw.ToVar(TMarshal_sc(AObj).AsAnsi(string(AArgs[0])));
end;

function TMarshal_AllocMem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function AllocMem(Size: NativeInt): TPtrWrapper;

  Result := TPtrWrapper_sw.ToVar(TMarshal_sc(AObj).AllocMem(NativeInt_sw.
    FromVar(AArgs[0])));
end;

function TMarshal_ReallocMem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ReallocMem(OldPtr: TPtrWrapper; NewSize: N...

  Result := TPtrWrapper_sw.ToVar(TMarshal_sc(AObj).ReallocMem(TPtrWrapper_sw.
    FromVar(AArgs[0]), NativeInt_sw.FromVar(AArgs[1])));
end;

function TMarshal_FreeMem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure FreeMem(Ptr: TPtrWrapper);

  TMarshal_sc(AObj).FreeMem(TPtrWrapper_sw.FromVar(AArgs[0]));
end;

function TMarshal_ReadByte_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ReadByte(Ptr: TPtrWrapper; Ofs: NativeInt)...

  case AArgsSize of
    1:
    begin
      Result := TMarshal_sc(AObj).ReadByte(TPtrWrapper_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      Result := TMarshal_sc(AObj).ReadByte(TPtrWrapper_sw.FromVar(AArgs[0]), 
        NativeInt_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('ReadByte');
  end;
end;

function TMarshal_ReadInt16_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ReadInt16(Ptr: TPtrWrapper; Ofs: NativeInt...

  case AArgsSize of
    1:
    begin
      Result := TMarshal_sc(AObj).ReadInt16(TPtrWrapper_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      Result := TMarshal_sc(AObj).ReadInt16(TPtrWrapper_sw.FromVar(AArgs[0]), 
        NativeInt_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('ReadInt16');
  end;
end;

function TMarshal_ReadInt32_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ReadInt32(Ptr: TPtrWrapper; Ofs: NativeInt...

  case AArgsSize of
    1:
    begin
      Result := TMarshal_sc(AObj).ReadInt32(TPtrWrapper_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      Result := TMarshal_sc(AObj).ReadInt32(TPtrWrapper_sw.FromVar(AArgs[0]), 
        NativeInt_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('ReadInt32');
  end;
end;

function TMarshal_ReadInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ReadInt64(Ptr: TPtrWrapper; Ofs: NativeInt...

  case AArgsSize of
    1:
    begin
      Result := Int64_sw.ToVar(TMarshal_sc(AObj).ReadInt64(TPtrWrapper_sw.
        FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := Int64_sw.ToVar(TMarshal_sc(AObj).ReadInt64(TPtrWrapper_sw.
        FromVar(AArgs[0]), NativeInt_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('ReadInt64');
  end;
end;

function TMarshal_ReadPtr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ReadPtr(Ptr: TPtrWrapper; Ofs: NativeInt):...

  case AArgsSize of
    1:
    begin
      Result := TPtrWrapper_sw.ToVar(TMarshal_sc(AObj).ReadPtr(TPtrWrapper_sw.
        FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TPtrWrapper_sw.ToVar(TMarshal_sc(AObj).ReadPtr(TPtrWrapper_sw.
        FromVar(AArgs[0]), NativeInt_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('ReadPtr');
  end;
end;

function TMarshal_WriteByte_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function WriteByte(...); overload;

  case AArgsSize of
    3:
    begin
      TMarshal_sc(AObj).WriteByte(TPtrWrapper_sw.FromVar(AArgs[0]), 
        NativeInt_sw.FromVar(AArgs[1]), Byte(AArgs[2]));
    end;
    2:
    begin
      TMarshal_sc(AObj).WriteByte(TPtrWrapper_sw.FromVar(AArgs[0]), Byte(
        AArgs[1]));
    end;
  else
    WrongArgCountError('WriteByte');
  end;
end;

function TMarshal_WriteInt16_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function WriteInt16(...); overload;

  case AArgsSize of
    3:
    begin
      TMarshal_sc(AObj).WriteInt16(TPtrWrapper_sw.FromVar(AArgs[0]), 
        NativeInt_sw.FromVar(AArgs[1]), Smallint(AArgs[2]));
    end;
    2:
    begin
      TMarshal_sc(AObj).WriteInt16(TPtrWrapper_sw.FromVar(AArgs[0]), Smallint(
        AArgs[1]));
    end;
  else
    WrongArgCountError('WriteInt16');
  end;
end;

function TMarshal_WriteInt32_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function WriteInt32(...); overload;

  case AArgsSize of
    3:
    begin
      TMarshal_sc(AObj).WriteInt32(TPtrWrapper_sw.FromVar(AArgs[0]), 
        NativeInt_sw.FromVar(AArgs[1]), Integer(AArgs[2]));
    end;
    2:
    begin
      TMarshal_sc(AObj).WriteInt32(TPtrWrapper_sw.FromVar(AArgs[0]), Integer(
        AArgs[1]));
    end;
  else
    WrongArgCountError('WriteInt32');
  end;
end;

function TMarshal_WriteInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function WriteInt64(...); overload;

  case AArgsSize of
    3:
    begin
      TMarshal_sc(AObj).WriteInt64(TPtrWrapper_sw.FromVar(AArgs[0]), 
        NativeInt_sw.FromVar(AArgs[1]), Int64_sw.FromVar(AArgs[2]));
    end;
    2:
    begin
      TMarshal_sc(AObj).WriteInt64(TPtrWrapper_sw.FromVar(AArgs[0]), Int64_sw.
        FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('WriteInt64');
  end;
end;

function TMarshal_WritePtr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function WritePtr(...); overload;

  case AArgsSize of
    3:
    begin
      TMarshal_sc(AObj).WritePtr(TPtrWrapper_sw.FromVar(AArgs[0]), NativeInt_sw.
        FromVar(AArgs[1]), TPtrWrapper_sw.FromVar(AArgs[2]));
    end;
    2:
    begin
      TMarshal_sc(AObj).WritePtr(TPtrWrapper_sw.FromVar(AArgs[0]), 
        TPtrWrapper_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('WritePtr');
  end;
end;

function TMarshal_Move_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure Move(Src: TPtrWrapper; Dest: TPtrWrapper;...

  TMarshal_sc(AObj).Move(TPtrWrapper_sw.FromVar(AArgs[0]), TPtrWrapper_sw.
    FromVar(AArgs[1]), NativeInt_sw.FromVar(AArgs[2]));
end;

function TMarshal_FixString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // procedure/function FixString(...); overload;

  v_1 := string(AArgs[0]);
  Result := TPtrWrapper_sw.ToVar(TMarshal_sc(AObj).FixString(v_1));
  AssignRefParam(AArgs[0], v_1);
end;

function TMarshal_UnfixString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function UnfixString(...); overload;

  TMarshal_sc(AObj).UnfixString(TPtrWrapper_sw.FromVar(AArgs[0]));
end;

function TMarshal_UnsafeFixString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function UnsafeFixString(...); overload;

  Result := TPtrWrapper_sw.ToVar(TMarshal_sc(AObj).UnsafeFixString(string(
    AArgs[0])));
end;

function TMarshal_AllocStringAsAnsi_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function AllocStringAsAnsi(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TPtrWrapper_sw.ToVar(TMarshal_sc(AObj).AllocStringAsAnsi(string(
        AArgs[0])));
    end;
    2:
    begin
      Result := TPtrWrapper_sw.ToVar(TMarshal_sc(AObj).AllocStringAsAnsi(string(
        AArgs[0]), Word(AArgs[1])));
    end;
  else
    WrongArgCountError('AllocStringAsAnsi');
  end;
end;

function TMarshal_AllocStringAsUnicode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function AllocStringAsUnicode(const Str: string): T...

  Result := TPtrWrapper_sw.ToVar(TMarshal_sc(AObj).AllocStringAsUnicode(string(
    AArgs[0])));
end;

function TMarshal_AllocStringAsUtf8_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function AllocStringAsUtf8(...); overload;

  Result := TPtrWrapper_sw.ToVar(TMarshal_sc(AObj).AllocStringAsUtf8(string(
    AArgs[0])));
end;

function TMarshal_ReadStringAsAnsi_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function ReadStringAsAnsi(...); overload;

  case AArgsSize of
    2:
    begin
      Result := TMarshal_sc(AObj).ReadStringAsAnsi(Word(AArgs[0]), 
        TPtrWrapper_sw.FromVar(AArgs[1]));
    end;
    3:
    begin
      Result := TMarshal_sc(AObj).ReadStringAsAnsi(Word(AArgs[0]), 
        TPtrWrapper_sw.FromVar(AArgs[1]), Integer(AArgs[2]));
    end;
  else
    WrongArgCountError('ReadStringAsAnsi');
  end;
end;

function TMarshal_ReadStringAsUnicode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ReadStringAsUnicode(Ptr: TPtrWrapper; Len:...

  case AArgsSize of
    1:
    begin
      Result := TMarshal_sc(AObj).ReadStringAsUnicode(TPtrWrapper_sw.FromVar(
        AArgs[0]));
    end;
    2:
    begin
      Result := TMarshal_sc(AObj).ReadStringAsUnicode(TPtrWrapper_sw.FromVar(
        AArgs[0]), Integer(AArgs[1]));
    end;
  else
    WrongArgCountError('ReadStringAsUnicode');
  end;
end;

function TMarshal_ReadStringAsUtf8_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ReadStringAsUtf8(Ptr: TPtrWrapper; Len: In...

  case AArgsSize of
    1:
    begin
      Result := TMarshal_sc(AObj).ReadStringAsUtf8(TPtrWrapper_sw.FromVar(
        AArgs[0]));
    end;
    2:
    begin
      Result := TMarshal_sc(AObj).ReadStringAsUtf8(TPtrWrapper_sw.FromVar(
        AArgs[0]), Integer(AArgs[1]));
    end;
  else
    WrongArgCountError('ReadStringAsUtf8');
  end;
end;

function TMarshal_ReadStringAsAnsiUpTo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ReadStringAsAnsiUpTo(CodePage: Word; Ptr: ...

  Result := TMarshal_sc(AObj).ReadStringAsAnsiUpTo(Word(AArgs[0]), 
    TPtrWrapper_sw.FromVar(AArgs[1]), Integer(AArgs[2]));
end;

function TMarshal_ReadStringAsUnicodeUpTo_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ReadStringAsUnicodeUpTo(Ptr: TPtrWrapper; ...

  Result := TMarshal_sc(AObj).ReadStringAsUnicodeUpTo(TPtrWrapper_sw.FromVar(
    AArgs[0]), Integer(AArgs[1]));
end;

function TMarshal_ReadStringAsUtf8UpTo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ReadStringAsUtf8UpTo(Ptr: TPtrWrapper; Max...

  Result := TMarshal_sc(AObj).ReadStringAsUtf8UpTo(TPtrWrapper_sw.FromVar(
    AArgs[0]), Integer(AArgs[1]));
end;

function TMarshal_WriteStringAsAnsi_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function WriteStringAsAnsi(...); overload;

  case AArgsSize of
    3:
    begin
      TMarshal_sc(AObj).WriteStringAsAnsi(TPtrWrapper_sw.FromVar(AArgs[0]), 
        string(AArgs[1]), Integer(AArgs[2]));
    end;
    4:
    begin
      TMarshal_sc(AObj).WriteStringAsAnsi(TPtrWrapper_sw.FromVar(AArgs[0]), 
        string(AArgs[1]), Integer(AArgs[2]), Word(AArgs[3]));
    end;
    5:
    begin
      TMarshal_sc(AObj).WriteStringAsAnsi(TPtrWrapper_sw.FromVar(AArgs[0]), 
        NativeInt_sw.FromVar(AArgs[1]), string(AArgs[2]), Integer(AArgs[3]), Word(
        AArgs[4]));
    end;
  else
    WrongArgCountError('WriteStringAsAnsi');
  end;
end;

function TMarshal_WriteStringAsUnicode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function WriteStringAsUnicode(...); overload;

  case AArgsSize of
    3:
    begin
      TMarshal_sc(AObj).WriteStringAsUnicode(TPtrWrapper_sw.FromVar(AArgs[0]), 
        string(AArgs[1]), Integer(AArgs[2]));
    end;
    4:
    begin
      TMarshal_sc(AObj).WriteStringAsUnicode(TPtrWrapper_sw.FromVar(AArgs[0]), 
        NativeInt_sw.FromVar(AArgs[1]), string(AArgs[2]), Integer(AArgs[3]));
    end;
  else
    WrongArgCountError('WriteStringAsUnicode');
  end;
end;

function TMarshal_WriteStringAsUtf8_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function WriteStringAsUtf8(...); overload;

  case AArgsSize of
    3:
    begin
      TMarshal_sc(AObj).WriteStringAsUtf8(TPtrWrapper_sw.FromVar(AArgs[0]), 
        string(AArgs[1]), Integer(AArgs[2]));
    end;
    4:
    begin
      TMarshal_sc(AObj).WriteStringAsUtf8(TPtrWrapper_sw.FromVar(AArgs[0]), 
        NativeInt_sw.FromVar(AArgs[1]), string(AArgs[2]), Integer(AArgs[3]));
    end;
  else
    WrongArgCountError('WriteStringAsUtf8');
  end;
end;

class function TMarshal_sw.GetTypeName: WideString;
begin
  Result := 'TMarshal';
end;

class function TMarshal_sw.GetWrappedClass: TClass;
begin
  Result := TMarshal;
end;

class procedure TMarshal_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TMarshal_Create_si, 0, False);
  AData.AddClassFunction('AsAnsi', TMarshal_AsAnsi_si, nil, 1, False);
  AData.AddClassFunction('AllocMem', TMarshal_AllocMem_si, TPtrWrapper_sw, 1, False);
  AData.AddClassFunction('ReallocMem', TMarshal_ReallocMem_si, TPtrWrapper_sw, 2, False);
  AData.AddClassProcedure('FreeMem', TMarshal_FreeMem_si, 1, False);
  AData.AddClassFunction('ReadByte', TMarshal_ReadByte_si, Byte_sw, 1, True);
  AData.AddClassFunction('ReadInt16', TMarshal_ReadInt16_si, Smallint_sw, 1, True);
  AData.AddClassFunction('ReadInt32', TMarshal_ReadInt32_si, Integer_sw, 1, True);
  AData.AddClassFunction('ReadInt64', TMarshal_ReadInt64_si, Int64_sw, 1, True);
  AData.AddClassFunction('ReadPtr', TMarshal_ReadPtr_si, TPtrWrapper_sw, 1, True);
  AData.AddClassProcedure('WriteByte', TMarshal_WriteByte_si, 2, True);
  AData.AddClassProcedure('WriteInt16', TMarshal_WriteInt16_si, 2, True);
  AData.AddClassProcedure('WriteInt32', TMarshal_WriteInt32_si, 2, True);
  AData.AddClassProcedure('WriteInt64', TMarshal_WriteInt64_si, 2, True);
  AData.AddClassProcedure('WritePtr', TMarshal_WritePtr_si, 2, True);
  AData.AddClassProcedure('Move', TMarshal_Move_si, 3, False);
  AData.AddClassFunction('FixString', TMarshal_FixString_si, nil, 1, False);
  AData.AddClassProcedure('UnfixString', TMarshal_UnfixString_si, 1, False);
  AData.AddClassFunction('UnsafeFixString', TMarshal_UnsafeFixString_si, nil, 1, False);
  AData.AddClassFunction('AllocStringAsAnsi', TMarshal_AllocStringAsAnsi_si, nil, 1, True);
  AData.AddClassFunction('AllocStringAsUnicode', TMarshal_AllocStringAsUnicode_si, TPtrWrapper_sw, 1, False);
  AData.AddClassFunction('AllocStringAsUtf8', TMarshal_AllocStringAsUtf8_si, nil, 1, False);
  AData.AddClassFunction('ReadStringAsAnsi', TMarshal_ReadStringAsAnsi_si, nil, 2, True);
  AData.AddClassFunction('ReadStringAsUnicode', TMarshal_ReadStringAsUnicode_si, string_sw, 1, True);
  AData.AddClassFunction('ReadStringAsUtf8', TMarshal_ReadStringAsUtf8_si, string_sw, 1, True);
  AData.AddClassFunction('ReadStringAsAnsiUpTo', TMarshal_ReadStringAsAnsiUpTo_si, string_sw, 3, False);
  AData.AddClassFunction('ReadStringAsUnicodeUpTo', TMarshal_ReadStringAsUnicodeUpTo_si, string_sw, 2, False);
  AData.AddClassFunction('ReadStringAsUtf8UpTo', TMarshal_ReadStringAsUtf8UpTo_si, string_sw, 2, False);
  AData.AddClassProcedure('WriteStringAsAnsi', TMarshal_WriteStringAsAnsi_si, 3, True);
  AData.AddClassProcedure('WriteStringAsUnicode', TMarshal_WriteStringAsUnicode_si, 3, True);
  AData.AddClassProcedure('WriteStringAsUtf8', TMarshal_WriteStringAsUtf8_si, 3, True);
end;

class function TMarshal_sw.ToVar(const AValue: TMarshal): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMarshal_sw.FromVar(const AValue: OleVariant): TMarshal;
begin
  Result := TMarshal(ConvFromVar(AValue, TMarshal));
end;

class function TMarshal_sw.ClassToVar(AClass: TMarshal_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMarshal_sw.ClassFromVar(const AClass: OleVariant): TMarshal_sc;
begin
  Result := TMarshal_sc(ConvClsFromVar(AClass, TMarshal));
end;

{ TChunkStatus_sw }

class function TChunkStatus_sw.GetTypeName: WideString;
begin
  Result := 'TChunkStatus';
end;

class procedure TChunkStatus_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'csUnallocated'; Value: Integer({$IFDEF LMDSCT_12}TChunkStatus.{$ENDIF}csUnallocated)),
    (Name: 'csAllocated'; Value: Integer({$IFDEF LMDSCT_12}TChunkStatus.{$ENDIF}csAllocated)),
    (Name: 'csReserved'; Value: Integer({$IFDEF LMDSCT_12}TChunkStatus.{$ENDIF}csReserved)),
    (Name: 'csSysAllocated'; Value: Integer({$IFDEF LMDSCT_12}TChunkStatus.{$ENDIF}csSysAllocated)),
    (Name: 'csSysReserved'; Value: Integer({$IFDEF LMDSCT_12}TChunkStatus.{$ENDIF}csSysReserved))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TChunkStatus_sw.ToVar(const AValue: TChunkStatus): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TChunkStatus_sw.FromVar(const AValue: OleVariant): TChunkStatus;
begin
  Result := TChunkStatus(Integer(AValue));
end;

{ TMinimumBlockAlignment_sw }

class function TMinimumBlockAlignment_sw.GetTypeName: WideString;
begin
  Result := 'TMinimumBlockAlignment';
end;

class procedure TMinimumBlockAlignment_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'mba8Byte'; Value: Integer({$IFDEF LMDSCT_12}TMinimumBlockAlignment.{$ENDIF}mba8Byte)),
    (Name: 'mba16Byte'; Value: Integer({$IFDEF LMDSCT_12}TMinimumBlockAlignment.{$ENDIF}mba16Byte))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TMinimumBlockAlignment_sw.ToVar(
  const AValue: TMinimumBlockAlignment): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMinimumBlockAlignment_sw.FromVar(
  const AValue: OleVariant): TMinimumBlockAlignment;
begin
  Result := TMinimumBlockAlignment(Integer(AValue));
end;

{ PackageUnitEntry_sw }

function PackageUnitEntry_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := PackageUnitEntry_sw.Create as IDispatch;
end;

function PackageUnitEntry_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: PackageUnitEntry;

  // Implicit record copy method.
  Result := PackageUnitEntry_sw.ToVar(PackageUnitEntry(AObj));
end;

class function PackageUnitEntry_sw.GetTypeName: WideString;
begin
  Result := 'PackageUnitEntry';
end;

function PackageUnitEntry_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := PackageUnitEntry_sw.Create;
  PackageUnitEntry_sw(Result).FValue := FValue;
end;

class procedure PackageUnitEntry_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', PackageUnitEntry_Copy_si, PackageUnitEntry_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', PackageUnitEntry_Create_si, 0, False);
end;

class function PackageUnitEntry_sw.ToVar(
  const AValue: PackageUnitEntry): OleVariant;
var
  wrpr: PackageUnitEntry_sw;
begin
  wrpr        := PackageUnitEntry_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function PackageUnitEntry_sw.FromVar(
  const AValue: OleVariant): PackageUnitEntry;
begin
  Result := PackageUnitEntry_sw(ConvFromVar(AValue)).FValue;
end;

{ TPackageTypeInfo_sw }

function TPackageTypeInfo_TypeCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TypeCount: Integer;

  if IsGet then
    Result := TPackageTypeInfo_sw(AObj).FValue.TypeCount
  else
    TPackageTypeInfo_sw(AObj).FValue.TypeCount := Integer(AArgs[0]);
end;

function TPackageTypeInfo_UnitCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var UnitCount: Integer;

  if IsGet then
    Result := TPackageTypeInfo_sw(AObj).FValue.UnitCount
  else
    TPackageTypeInfo_sw(AObj).FValue.UnitCount := Integer(AArgs[0]);
end;

function TPackageTypeInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TPackageTypeInfo_sw.Create as IDispatch;
end;

function TPackageTypeInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TPackageTypeInfo;

  // Implicit record copy method.
  Result := TPackageTypeInfo_sw.ToVar(TPackageTypeInfo(AObj));
end;

class function TPackageTypeInfo_sw.GetTypeName: WideString;
begin
  Result := 'TPackageTypeInfo';
end;

function TPackageTypeInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPackageTypeInfo_sw.Create;
  TPackageTypeInfo_sw(Result).FValue := FValue;
end;

class procedure TPackageTypeInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('TypeCount', TPackageTypeInfo_TypeCount_si, Integer_sw);
  AData.AddField('UnitCount', TPackageTypeInfo_UnitCount_si, Integer_sw);
  AData.AddFunction('Copy', TPackageTypeInfo_Copy_si, TPackageTypeInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TPackageTypeInfo_Create_si, 0, False);
end;

class function TPackageTypeInfo_sw.ToVar(
  const AValue: TPackageTypeInfo): OleVariant;
var
  wrpr: TPackageTypeInfo_sw;
begin
  wrpr        := TPackageTypeInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TPackageTypeInfo_sw.FromVar(
  const AValue: OleVariant): TPackageTypeInfo;
begin
  Result := TPackageTypeInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ PackageInfoTable_sw }

function PackageInfoTable_UnitCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var UnitCount: Integer;

  if IsGet then
    Result := PackageInfoTable_sw(AObj).FValue.UnitCount
  else
    PackageInfoTable_sw(AObj).FValue.UnitCount := Integer(AArgs[0]);
end;

function PackageInfoTable_TypeInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TypeInfo: TPackageTypeInfo;

  if IsGet then
    Result := TPackageTypeInfo_sw.ToVar(PackageInfoTable_sw(AObj).FValue.
      TypeInfo)
  else
    PackageInfoTable_sw(AObj).FValue.TypeInfo := TPackageTypeInfo_sw.FromVar(
      AArgs[0]);
end;

function PackageInfoTable_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := PackageInfoTable_sw.Create as IDispatch;
end;

function PackageInfoTable_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: PackageInfoTable;

  // Implicit record copy method.
  Result := PackageInfoTable_sw.ToVar(PackageInfoTable(AObj));
end;

class function PackageInfoTable_sw.GetTypeName: WideString;
begin
  Result := 'PackageInfoTable';
end;

function PackageInfoTable_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := PackageInfoTable_sw.Create;
  PackageInfoTable_sw(Result).FValue := FValue;
end;

class procedure PackageInfoTable_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('UnitCount', PackageInfoTable_UnitCount_si, Integer_sw);
  AData.AddField('TypeInfo', PackageInfoTable_TypeInfo_si, TPackageTypeInfo_sw);
  AData.AddFunction('Copy', PackageInfoTable_Copy_si, PackageInfoTable_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', PackageInfoTable_Create_si, 0, False);
end;

class function PackageInfoTable_sw.ToVar(
  const AValue: PackageInfoTable): OleVariant;
var
  wrpr: PackageInfoTable_sw;
begin
  wrpr        := PackageInfoTable_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function PackageInfoTable_sw.FromVar(
  const AValue: OleVariant): PackageInfoTable;
begin
  Result := PackageInfoTable_sw(ConvFromVar(AValue)).FValue;
end;

{ TCVModInfo_sw }

function TCVModInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCVModInfo_sw.Create as IDispatch;
end;

function TCVModInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCVModInfo;

  // Implicit record copy method.
  Result := TCVModInfo_sw.ToVar(TCVModInfo(AObj));
end;

class function TCVModInfo_sw.GetTypeName: WideString;
begin
  Result := 'TCVModInfo';
end;

function TCVModInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCVModInfo_sw.Create;
  TCVModInfo_sw(Result).FValue := FValue;
end;

class procedure TCVModInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TCVModInfo_Copy_si, TCVModInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCVModInfo_Create_si, 0, False);
end;

class function TCVModInfo_sw.ToVar(const AValue: TCVModInfo): OleVariant;
var
  wrpr: TCVModInfo_sw;
begin
  wrpr        := TCVModInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCVModInfo_sw.FromVar(const AValue: OleVariant): TCVModInfo;
begin
  Result := TCVModInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TTextLineBreakStyle_sw }

class function TTextLineBreakStyle_sw.GetTypeName: WideString;
begin
  Result := 'TTextLineBreakStyle';
end;

class procedure TTextLineBreakStyle_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'tlbsLF'; Value: Integer({$IFDEF LMDSCT_12}TTextLineBreakStyle.{$ENDIF}tlbsLF)),
    (Name: 'tlbsCRLF'; Value: Integer({$IFDEF LMDSCT_12}TTextLineBreakStyle.{$ENDIF}tlbsCRLF))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TTextLineBreakStyle_sw.ToVar(
  const AValue: TTextLineBreakStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTextLineBreakStyle_sw.FromVar(
  const AValue: OleVariant): TTextLineBreakStyle;
begin
  Result := TTextLineBreakStyle(Integer(AValue));
end;

{ TFileRec_sw }

function TFileRec_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Handle: NativeInt;

  if IsGet then
    Result := NativeInt_sw.ToVar(TFileRec_sw(AObj).FValue.Handle)
  else
    TFileRec_sw(AObj).FValue.Handle := NativeInt_sw.FromVar(AArgs[0]);
end;

function TFileRec_Mode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Mode: Word;

  if IsGet then
    Result := TFileRec_sw(AObj).FValue.Mode
  else
    TFileRec_sw(AObj).FValue.Mode := Word(AArgs[0]);
end;

function TFileRec_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: Word;

  if IsGet then
    Result := TFileRec_sw(AObj).FValue.Flags
  else
    TFileRec_sw(AObj).FValue.Flags := Word(AArgs[0]);
end;

function TFileRec_RecSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var RecSize: Cardinal;

  if IsGet then
    Result := TFileRec_sw(AObj).FValue.RecSize
  else
    TFileRec_sw(AObj).FValue.RecSize := Cardinal(AArgs[0]);
end;

function TFileRec_BufSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BufSize: Cardinal;

  if IsGet then
    Result := TFileRec_sw(AObj).FValue.BufSize
  else
    TFileRec_sw(AObj).FValue.BufSize := Cardinal(AArgs[0]);
end;

function TFileRec_BufPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BufPos: Cardinal;

  if IsGet then
    Result := TFileRec_sw(AObj).FValue.BufPos
  else
    TFileRec_sw(AObj).FValue.BufPos := Cardinal(AArgs[0]);
end;

function TFileRec_BufEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BufEnd: Cardinal;

  if IsGet then
    Result := TFileRec_sw(AObj).FValue.BufEnd
  else
    TFileRec_sw(AObj).FValue.BufEnd := Cardinal(AArgs[0]);
end;

function TFileRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TFileRec_sw.Create as IDispatch;
end;

function TFileRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TFileRec;

  // Implicit record copy method.
  Result := TFileRec_sw.ToVar(TFileRec(AObj));
end;

class function TFileRec_sw.GetTypeName: WideString;
begin
  Result := 'TFileRec';
end;

function TFileRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TFileRec_sw.Create;
  TFileRec_sw(Result).FValue := FValue;
end;

class procedure TFileRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Handle', TFileRec_Handle_si, NativeInt_sw);
  AData.AddField('Mode', TFileRec_Mode_si, Word_sw);
  AData.AddField('Flags', TFileRec_Flags_si, Word_sw);
  AData.AddField('RecSize', TFileRec_RecSize_si, Cardinal_sw);
  AData.AddField('BufSize', TFileRec_BufSize_si, Cardinal_sw);
  AData.AddField('BufPos', TFileRec_BufPos_si, Cardinal_sw);
  AData.AddField('BufEnd', TFileRec_BufEnd_si, Cardinal_sw);
  AData.AddFunction('Copy', TFileRec_Copy_si, TFileRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TFileRec_Create_si, 0, False);
end;

class function TFileRec_sw.ToVar(const AValue: TFileRec): OleVariant;
var
  wrpr: TFileRec_sw;
begin
  wrpr        := TFileRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TFileRec_sw.FromVar(const AValue: OleVariant): TFileRec;
begin
  Result := TFileRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TTextRec_sw }

function TTextRec_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Handle: NativeInt;

  if IsGet then
    Result := NativeInt_sw.ToVar(TTextRec_sw(AObj).FValue.Handle)
  else
    TTextRec_sw(AObj).FValue.Handle := NativeInt_sw.FromVar(AArgs[0]);
end;

function TTextRec_Mode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Mode: Word;

  if IsGet then
    Result := TTextRec_sw(AObj).FValue.Mode
  else
    TTextRec_sw(AObj).FValue.Mode := Word(AArgs[0]);
end;

function TTextRec_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: Word;

  if IsGet then
    Result := TTextRec_sw(AObj).FValue.Flags
  else
    TTextRec_sw(AObj).FValue.Flags := Word(AArgs[0]);
end;

function TTextRec_BufSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BufSize: Cardinal;

  if IsGet then
    Result := TTextRec_sw(AObj).FValue.BufSize
  else
    TTextRec_sw(AObj).FValue.BufSize := Cardinal(AArgs[0]);
end;

function TTextRec_BufPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BufPos: Cardinal;

  if IsGet then
    Result := TTextRec_sw(AObj).FValue.BufPos
  else
    TTextRec_sw(AObj).FValue.BufPos := Cardinal(AArgs[0]);
end;

function TTextRec_BufEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BufEnd: Cardinal;

  if IsGet then
    Result := TTextRec_sw(AObj).FValue.BufEnd
  else
    TTextRec_sw(AObj).FValue.BufEnd := Cardinal(AArgs[0]);
end;

function TTextRec_CodePage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CodePage: Word;

  if IsGet then
    Result := TTextRec_sw(AObj).FValue.CodePage
  else
    TTextRec_sw(AObj).FValue.CodePage := Word(AArgs[0]);
end;

function TTextRec_MBCSLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MBCSLength: ShortInt;

  if IsGet then
    Result := TTextRec_sw(AObj).FValue.MBCSLength
  else
    TTextRec_sw(AObj).FValue.MBCSLength := ShortInt(AArgs[0]);
end;

function TTextRec_MBCSBufPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MBCSBufPos: Byte;

  if IsGet then
    Result := TTextRec_sw(AObj).FValue.MBCSBufPos
  else
    TTextRec_sw(AObj).FValue.MBCSBufPos := Byte(AArgs[0]);
end;

function TTextRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TTextRec_sw.Create as IDispatch;
end;

function TTextRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TTextRec;

  // Implicit record copy method.
  Result := TTextRec_sw.ToVar(TTextRec(AObj));
end;

class function TTextRec_sw.GetTypeName: WideString;
begin
  Result := 'TTextRec';
end;

function TTextRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TTextRec_sw.Create;
  TTextRec_sw(Result).FValue := FValue;
end;

class procedure TTextRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Handle', TTextRec_Handle_si, NativeInt_sw);
  AData.AddField('Mode', TTextRec_Mode_si, Word_sw);
  AData.AddField('Flags', TTextRec_Flags_si, Word_sw);
  AData.AddField('BufSize', TTextRec_BufSize_si, Cardinal_sw);
  AData.AddField('BufPos', TTextRec_BufPos_si, Cardinal_sw);
  AData.AddField('BufEnd', TTextRec_BufEnd_si, Cardinal_sw);
  AData.AddField('CodePage', TTextRec_CodePage_si, Word_sw);
  AData.AddField('MBCSLength', TTextRec_MBCSLength_si, ShortInt_sw);
  AData.AddField('MBCSBufPos', TTextRec_MBCSBufPos_si, Byte_sw);
  AData.AddFunction('Copy', TTextRec_Copy_si, TTextRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TTextRec_Create_si, 0, False);
end;

class function TTextRec_sw.ToVar(const AValue: TTextRec): OleVariant;
var
  wrpr: TTextRec_sw;
begin
  wrpr        := TTextRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TTextRec_sw.FromVar(const AValue: OleVariant): TTextRec;
begin
  Result := TTextRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TLibModule_sw }

function TLibModule_Instance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Instance: HINST;

  if IsGet then
    Result := HINST_sw.ToVar(TLibModule_sw(AObj).FValue.Instance)
  else
    TLibModule_sw(AObj).FValue.Instance := HINST_sw.FromVar(AArgs[0]);
end;

function TLibModule_CodeInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CodeInstance: HINST;

  if IsGet then
    Result := HINST_sw.ToVar(TLibModule_sw(AObj).FValue.CodeInstance)
  else
    TLibModule_sw(AObj).FValue.CodeInstance := HINST_sw.FromVar(AArgs[0]);
end;

function TLibModule_DataInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DataInstance: HINST;

  if IsGet then
    Result := HINST_sw.ToVar(TLibModule_sw(AObj).FValue.DataInstance)
  else
    TLibModule_sw(AObj).FValue.DataInstance := HINST_sw.FromVar(AArgs[0]);
end;

function TLibModule_ResInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ResInstance: HINST;

  if IsGet then
    Result := HINST_sw.ToVar(TLibModule_sw(AObj).FValue.ResInstance)
  else
    TLibModule_sw(AObj).FValue.ResInstance := HINST_sw.FromVar(AArgs[0]);
end;

function TLibModule_Reserved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved: NativeInt;

  if IsGet then
    Result := NativeInt_sw.ToVar(TLibModule_sw(AObj).FValue.Reserved)
  else
    TLibModule_sw(AObj).FValue.Reserved := NativeInt_sw.FromVar(AArgs[0]);
end;

function TLibModule_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TLibModule_sw.Create as IDispatch;
end;

function TLibModule_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TLibModule;

  // Implicit record copy method.
  Result := TLibModule_sw.ToVar(TLibModule(AObj));
end;

class function TLibModule_sw.GetTypeName: WideString;
begin
  Result := 'TLibModule';
end;

function TLibModule_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TLibModule_sw.Create;
  TLibModule_sw(Result).FValue := FValue;
end;

class procedure TLibModule_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Instance', TLibModule_Instance_si, HINST_sw);
  AData.AddField('CodeInstance', TLibModule_CodeInstance_si, HINST_sw);
  AData.AddField('DataInstance', TLibModule_DataInstance_si, HINST_sw);
  AData.AddField('ResInstance', TLibModule_ResInstance_si, HINST_sw);
  AData.AddField('Reserved', TLibModule_Reserved_si, NativeInt_sw);
  AData.AddFunction('Copy', TLibModule_Copy_si, TLibModule_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TLibModule_Create_si, 0, False);
end;

class function TLibModule_sw.ToVar(const AValue: TLibModule): OleVariant;
var
  wrpr: TLibModule_sw;
begin
  wrpr        := TLibModule_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TLibModule_sw.FromVar(const AValue: OleVariant): TLibModule;
begin
  Result := TLibModule_sw(ConvFromVar(AValue)).FValue;
end;

{ TModuleUnloadRec_sw }

function TModuleUnloadRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TModuleUnloadRec_sw.Create as IDispatch;
end;

function TModuleUnloadRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TModuleUnloadRec;

  // Implicit record copy method.
  Result := TModuleUnloadRec_sw.ToVar(TModuleUnloadRec(AObj));
end;

class function TModuleUnloadRec_sw.GetTypeName: WideString;
begin
  Result := 'TModuleUnloadRec';
end;

function TModuleUnloadRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TModuleUnloadRec_sw.Create;
  TModuleUnloadRec_sw(Result).FValue := FValue;
end;

class procedure TModuleUnloadRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TModuleUnloadRec_Copy_si, TModuleUnloadRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TModuleUnloadRec_Create_si, 0, False);
end;

class function TModuleUnloadRec_sw.ToVar(
  const AValue: TModuleUnloadRec): OleVariant;
var
  wrpr: TModuleUnloadRec_sw;
begin
  wrpr        := TModuleUnloadRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TModuleUnloadRec_sw.FromVar(
  const AValue: OleVariant): TModuleUnloadRec;
begin
  Result := TModuleUnloadRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TResStringRec_sw }

function TResStringRec_Identifier_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Identifier: NativeUint;

  if IsGet then
    Result := NativeUint_sw.ToVar(TResStringRec_sw(AObj).FValue.Identifier)
  else
    TResStringRec_sw(AObj).FValue.Identifier := NativeUint_sw.FromVar(AArgs[0]);
end;

function TResStringRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TResStringRec_sw.Create as IDispatch;
end;

function TResStringRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TResStringRec;

  // Implicit record copy method.
  Result := TResStringRec_sw.ToVar(TResStringRec(AObj));
end;

class function TResStringRec_sw.GetTypeName: WideString;
begin
  Result := 'TResStringRec';
end;

function TResStringRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TResStringRec_sw.Create;
  TResStringRec_sw(Result).FValue := FValue;
end;

class procedure TResStringRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Identifier', TResStringRec_Identifier_si, NativeUint_sw);
  AData.AddFunction('Copy', TResStringRec_Copy_si, TResStringRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TResStringRec_Create_si, 0, False);
end;

class function TResStringRec_sw.ToVar(const AValue: TResStringRec): OleVariant;
var
  wrpr: TResStringRec_sw;
begin
  wrpr        := TResStringRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TResStringRec_sw.FromVar(
  const AValue: OleVariant): TResStringRec;
begin
  Result := TResStringRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TFloatSpecial_sw }

class function TFloatSpecial_sw.GetTypeName: WideString;
begin
  Result := 'TFloatSpecial';
end;

class procedure TFloatSpecial_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..8] of TLMDEnumerator = (
    (Name: 'fsZero'; Value: Integer({$IFDEF LMDSCT_12}TFloatSpecial.{$ENDIF}fsZero)),
    (Name: 'fsNZero'; Value: Integer({$IFDEF LMDSCT_12}TFloatSpecial.{$ENDIF}fsNZero)),
    (Name: 'fsDenormal'; Value: Integer({$IFDEF LMDSCT_12}TFloatSpecial.{$ENDIF}fsDenormal)),
    (Name: 'fsNDenormal'; Value: Integer({$IFDEF LMDSCT_12}TFloatSpecial.{$ENDIF}fsNDenormal)),
    (Name: 'fsPositive'; Value: Integer({$IFDEF LMDSCT_12}TFloatSpecial.{$ENDIF}fsPositive)),
    (Name: 'fsNegative'; Value: Integer({$IFDEF LMDSCT_12}TFloatSpecial.{$ENDIF}fsNegative)),
    (Name: 'fsInf'; Value: Integer({$IFDEF LMDSCT_12}TFloatSpecial.{$ENDIF}fsInf)),
    (Name: 'fsNInf'; Value: Integer({$IFDEF LMDSCT_12}TFloatSpecial.{$ENDIF}fsNInf)),
    (Name: 'fsNaN'; Value: Integer({$IFDEF LMDSCT_12}TFloatSpecial.{$ENDIF}fsNaN))
  );
begin
  AEnums := @ENUMS;
  ACount := 9;
end;

class function TFloatSpecial_sw.ToVar(const AValue: TFloatSpecial): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFloatSpecial_sw.FromVar(
  const AValue: OleVariant): TFloatSpecial;
begin
  Result := TFloatSpecial(Integer(AValue));
end;

{ TSingleRec_sw }

function TSingleRec_Exponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Exponent: Integer;

  Result := TSingleRec_sw(AObj).FValue.Exponent();
end;

function TSingleRec_Fraction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Fraction: Extended;

  Result := TSingleRec_sw(AObj).FValue.Fraction();
end;

function TSingleRec_Mantissa_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Mantissa: UInt64;

  Result := UInt64_sw.ToVar(TSingleRec_sw(AObj).FValue.Mantissa());
end;

function TSingleRec_Sign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Sign: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TSingleRec_sw(AObj).FValue.Sign
  else
    TSingleRec_sw(AObj).FValue.Sign := Boolean(AArgs[0]);
end;

function TSingleRec_Exp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Exp: UInt64 read <getter> write <setter>;

  if IsGet then
    Result := UInt64_sw.ToVar(TSingleRec_sw(AObj).FValue.Exp)
  else
    TSingleRec_sw(AObj).FValue.Exp := UInt64_sw.FromVar(AArgs[0]);
end;

function TSingleRec_Frac_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Frac: UInt64 read <getter> write <setter>;

  if IsGet then
    Result := UInt64_sw.ToVar(TSingleRec_sw(AObj).FValue.Frac)
  else
    TSingleRec_sw(AObj).FValue.Frac := UInt64_sw.FromVar(AArgs[0]);
end;

function TSingleRec_SpecialType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SpecialType: TFloatSpecial;

  Result := TFloatSpecial_sw.ToVar(TSingleRec_sw(AObj).FValue.SpecialType());
end;

function TSingleRec_BuildUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BuildUp(const SignFlag: Boolean; const Mantissa...

  TSingleRec_sw(AObj).FValue.BuildUp(Boolean(AArgs[0]), UInt64_sw.FromVar(
    AArgs[1]), Integer(AArgs[2]));
end;

function TSingleRec_Bytes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bytes[Index: Cardinal]: UInt8 read <getter> writ...

  if IsGet then
    Result := UInt8_sw.ToVar(TSingleRec_sw(AObj).FValue.Bytes[Cardinal(
      AArgs[0])])
  else
    TSingleRec_sw(AObj).FValue.Bytes[Cardinal(AArgs[0])] := UInt8_sw.FromVar(
      AArgs[1]);
end;

function TSingleRec_Words_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Words[Index: Cardinal]: UInt16 read <getter> wri...

  if IsGet then
    Result := UInt16_sw.ToVar(TSingleRec_sw(AObj).FValue.Words[Cardinal(
      AArgs[0])])
  else
    TSingleRec_sw(AObj).FValue.Words[Cardinal(AArgs[0])] := UInt16_sw.FromVar(
      AArgs[1]);
end;

function TSingleRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TSingleRec_sw.Create as IDispatch;
end;

function TSingleRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TSingleRec;

  // Implicit record copy method.
  Result := TSingleRec_sw.ToVar(TSingleRec(AObj));
end;

class function TSingleRec_sw.GetTypeName: WideString;
begin
  Result := 'TSingleRec';
end;

function TSingleRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TSingleRec_sw.Create;
  TSingleRec_sw(Result).FValue := FValue;
end;

class procedure TSingleRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Exponent', TSingleRec_Exponent_si, Integer_sw, 0, False);
  AData.AddFunction('Fraction', TSingleRec_Fraction_si, Extended_sw, 0, False);
  AData.AddFunction('Mantissa', TSingleRec_Mantissa_si, UInt64_sw, 0, False);
  AData.AddProperty('Sign', TSingleRec_Sign_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Exp', TSingleRec_Exp_si, UInt64_sw, True, True, 0, False, False);
  AData.AddProperty('Frac', TSingleRec_Frac_si, UInt64_sw, True, True, 0, False, False);
  AData.AddFunction('SpecialType', TSingleRec_SpecialType_si, TFloatSpecial_sw, 0, False);
  AData.AddProcedure('BuildUp', TSingleRec_BuildUp_si, 3, False);
  AData.AddProperty('Bytes', TSingleRec_Bytes_si, UInt8_sw, True, True, 1, False, False);
  AData.AddProperty('Words', TSingleRec_Words_si, UInt16_sw, True, True, 1, False, False);
  AData.AddFunction('Copy', TSingleRec_Copy_si, TSingleRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TSingleRec_Create_si, 0, False);
end;

class function TSingleRec_sw.ToVar(const AValue: TSingleRec): OleVariant;
var
  wrpr: TSingleRec_sw;
begin
  wrpr        := TSingleRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TSingleRec_sw.FromVar(const AValue: OleVariant): TSingleRec;
begin
  Result := TSingleRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TDoubleRec_sw }

function TDoubleRec_Exponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Exponent: Integer;

  Result := TDoubleRec_sw(AObj).FValue.Exponent();
end;

function TDoubleRec_Fraction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Fraction: Extended;

  Result := TDoubleRec_sw(AObj).FValue.Fraction();
end;

function TDoubleRec_Mantissa_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Mantissa: UInt64;

  Result := UInt64_sw.ToVar(TDoubleRec_sw(AObj).FValue.Mantissa());
end;

function TDoubleRec_Sign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Sign: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDoubleRec_sw(AObj).FValue.Sign
  else
    TDoubleRec_sw(AObj).FValue.Sign := Boolean(AArgs[0]);
end;

function TDoubleRec_Exp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Exp: UInt64 read <getter> write <setter>;

  if IsGet then
    Result := UInt64_sw.ToVar(TDoubleRec_sw(AObj).FValue.Exp)
  else
    TDoubleRec_sw(AObj).FValue.Exp := UInt64_sw.FromVar(AArgs[0]);
end;

function TDoubleRec_Frac_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Frac: UInt64 read <getter> write <setter>;

  if IsGet then
    Result := UInt64_sw.ToVar(TDoubleRec_sw(AObj).FValue.Frac)
  else
    TDoubleRec_sw(AObj).FValue.Frac := UInt64_sw.FromVar(AArgs[0]);
end;

function TDoubleRec_SpecialType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SpecialType: TFloatSpecial;

  Result := TFloatSpecial_sw.ToVar(TDoubleRec_sw(AObj).FValue.SpecialType());
end;

function TDoubleRec_BuildUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BuildUp(const SignFlag: Boolean; const Mantissa...

  TDoubleRec_sw(AObj).FValue.BuildUp(Boolean(AArgs[0]), UInt64_sw.FromVar(
    AArgs[1]), Integer(AArgs[2]));
end;

function TDoubleRec_Bytes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bytes[Index: Cardinal]: UInt8 read <getter> writ...

  if IsGet then
    Result := UInt8_sw.ToVar(TDoubleRec_sw(AObj).FValue.Bytes[Cardinal(
      AArgs[0])])
  else
    TDoubleRec_sw(AObj).FValue.Bytes[Cardinal(AArgs[0])] := UInt8_sw.FromVar(
      AArgs[1]);
end;

function TDoubleRec_Words_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Words[Index: Cardinal]: UInt16 read <getter> wri...

  if IsGet then
    Result := UInt16_sw.ToVar(TDoubleRec_sw(AObj).FValue.Words[Cardinal(
      AArgs[0])])
  else
    TDoubleRec_sw(AObj).FValue.Words[Cardinal(AArgs[0])] := UInt16_sw.FromVar(
      AArgs[1]);
end;

function TDoubleRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TDoubleRec_sw.Create as IDispatch;
end;

function TDoubleRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TDoubleRec;

  // Implicit record copy method.
  Result := TDoubleRec_sw.ToVar(TDoubleRec(AObj));
end;

class function TDoubleRec_sw.GetTypeName: WideString;
begin
  Result := 'TDoubleRec';
end;

function TDoubleRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TDoubleRec_sw.Create;
  TDoubleRec_sw(Result).FValue := FValue;
end;

class procedure TDoubleRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Exponent', TDoubleRec_Exponent_si, Integer_sw, 0, False);
  AData.AddFunction('Fraction', TDoubleRec_Fraction_si, Extended_sw, 0, False);
  AData.AddFunction('Mantissa', TDoubleRec_Mantissa_si, UInt64_sw, 0, False);
  AData.AddProperty('Sign', TDoubleRec_Sign_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Exp', TDoubleRec_Exp_si, UInt64_sw, True, True, 0, False, False);
  AData.AddProperty('Frac', TDoubleRec_Frac_si, UInt64_sw, True, True, 0, False, False);
  AData.AddFunction('SpecialType', TDoubleRec_SpecialType_si, TFloatSpecial_sw, 0, False);
  AData.AddProcedure('BuildUp', TDoubleRec_BuildUp_si, 3, False);
  AData.AddProperty('Bytes', TDoubleRec_Bytes_si, UInt8_sw, True, True, 1, False, False);
  AData.AddProperty('Words', TDoubleRec_Words_si, UInt16_sw, True, True, 1, False, False);
  AData.AddFunction('Copy', TDoubleRec_Copy_si, TDoubleRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TDoubleRec_Create_si, 0, False);
end;

class function TDoubleRec_sw.ToVar(const AValue: TDoubleRec): OleVariant;
var
  wrpr: TDoubleRec_sw;
begin
  wrpr        := TDoubleRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TDoubleRec_sw.FromVar(const AValue: OleVariant): TDoubleRec;
begin
  Result := TDoubleRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TExtended80Rec_sw }

function TExtended80Rec_Exponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Exponent: Integer;

  Result := TExtended80Rec_sw(AObj).FValue.Exponent();
end;

function TExtended80Rec_Fraction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Fraction: Extended;

  Result := TExtended80Rec_sw(AObj).FValue.Fraction();
end;

function TExtended80Rec_Mantissa_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Mantissa: UInt64;

  Result := UInt64_sw.ToVar(TExtended80Rec_sw(AObj).FValue.Mantissa());
end;

function TExtended80Rec_Sign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Sign: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TExtended80Rec_sw(AObj).FValue.Sign
  else
    TExtended80Rec_sw(AObj).FValue.Sign := Boolean(AArgs[0]);
end;

function TExtended80Rec_Exp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Exp: UInt64 read <getter> write <setter>;

  if IsGet then
    Result := UInt64_sw.ToVar(TExtended80Rec_sw(AObj).FValue.Exp)
  else
    TExtended80Rec_sw(AObj).FValue.Exp := UInt64_sw.FromVar(AArgs[0]);
end;

function TExtended80Rec__Exp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property _Exp: UInt64 read <getter> write <setter>;

  if IsGet then
    Result := UInt64_sw.ToVar(TExtended80Rec_sw(AObj).FValue._Exp)
  else
    TExtended80Rec_sw(AObj).FValue._Exp := UInt64_sw.FromVar(AArgs[0]);
end;

function TExtended80Rec_Frac_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Frac: UInt64 read <getter> write <setter>;

  if IsGet then
    Result := UInt64_sw.ToVar(TExtended80Rec_sw(AObj).FValue.Frac)
  else
    TExtended80Rec_sw(AObj).FValue.Frac := UInt64_sw.FromVar(AArgs[0]);
end;

function TExtended80Rec_SpecialType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SpecialType: TFloatSpecial;

  Result := TFloatSpecial_sw.ToVar(TExtended80Rec_sw(AObj).FValue.SpecialType(
    ));
end;

function TExtended80Rec_BuildUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BuildUp(const SignFlag: Boolean; const Mantissa...

  TExtended80Rec_sw(AObj).FValue.BuildUp(Boolean(AArgs[0]), UInt64_sw.FromVar(
    AArgs[1]), Integer(AArgs[2]));
end;

function TExtended80Rec_Bytes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bytes[Index: Cardinal]: UInt8 read <getter> writ...

  if IsGet then
    Result := UInt8_sw.ToVar(TExtended80Rec_sw(AObj).FValue.Bytes[Cardinal(
      AArgs[0])])
  else
    TExtended80Rec_sw(AObj).FValue.Bytes[Cardinal(AArgs[0])] := UInt8_sw.
      FromVar(AArgs[1]);
end;

function TExtended80Rec_Words_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Words[Index: Cardinal]: UInt16 read <getter> wri...

  if IsGet then
    Result := UInt16_sw.ToVar(TExtended80Rec_sw(AObj).FValue.Words[Cardinal(
      AArgs[0])])
  else
    TExtended80Rec_sw(AObj).FValue.Words[Cardinal(AArgs[0])] := UInt16_sw.
      FromVar(AArgs[1]);
end;

function TExtended80Rec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TExtended80Rec_sw.Create as IDispatch;
end;

function TExtended80Rec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TExtended80Rec;

  // Implicit record copy method.
  Result := TExtended80Rec_sw.ToVar(TExtended80Rec(AObj));
end;

class function TExtended80Rec_sw.GetTypeName: WideString;
begin
  Result := 'TExtended80Rec';
end;

function TExtended80Rec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TExtended80Rec_sw.Create;
  TExtended80Rec_sw(Result).FValue := FValue;
end;

class procedure TExtended80Rec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Exponent', TExtended80Rec_Exponent_si, Integer_sw, 0, False);
  AData.AddFunction('Fraction', TExtended80Rec_Fraction_si, Extended_sw, 0, False);
  AData.AddFunction('Mantissa', TExtended80Rec_Mantissa_si, UInt64_sw, 0, False);
  AData.AddProperty('Sign', TExtended80Rec_Sign_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Exp', TExtended80Rec_Exp_si, UInt64_sw, True, True, 0, False, False);
  AData.AddProperty('_Exp', TExtended80Rec__Exp_si, UInt64_sw, True, True, 0, False, False);
  AData.AddProperty('Frac', TExtended80Rec_Frac_si, UInt64_sw, True, True, 0, False, False);
  AData.AddFunction('SpecialType', TExtended80Rec_SpecialType_si, TFloatSpecial_sw, 0, False);
  AData.AddProcedure('BuildUp', TExtended80Rec_BuildUp_si, 3, False);
  AData.AddProperty('Bytes', TExtended80Rec_Bytes_si, UInt8_sw, True, True, 1, False, False);
  AData.AddProperty('Words', TExtended80Rec_Words_si, UInt16_sw, True, True, 1, False, False);
  AData.AddFunction('Copy', TExtended80Rec_Copy_si, TExtended80Rec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TExtended80Rec_Create_si, 0, False);
end;

class function TExtended80Rec_sw.ToVar(
  const AValue: TExtended80Rec): OleVariant;
var
  wrpr: TExtended80Rec_sw;
begin
  wrpr        := TExtended80Rec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TExtended80Rec_sw.FromVar(
  const AValue: OleVariant): TExtended80Rec;
begin
  Result := TExtended80Rec_sw(ConvFromVar(AValue)).FValue;
end;

{ TInitContext_sw }

function TInitContext_InitCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var InitCount: Integer;

  if IsGet then
    Result := TInitContext_sw(AObj).FValue.InitCount
  else
    TInitContext_sw(AObj).FValue.InitCount := Integer(AArgs[0]);
end;

function TInitContext_DLLInitState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DLLInitState: Byte;

  if IsGet then
    Result := TInitContext_sw(AObj).FValue.DLLInitState
  else
    TInitContext_sw(AObj).FValue.DLLInitState := Byte(AArgs[0]);
end;

function TInitContext_ThreadID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ThreadID: TThreadID;

  if IsGet then
    Result := TThreadID_sw.ToVar(TInitContext_sw(AObj).FValue.ThreadID)
  else
    TInitContext_sw(AObj).FValue.ThreadID := TThreadID_sw.FromVar(AArgs[0]);
end;

function TInitContext_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TInitContext_sw.Create as IDispatch;
end;

function TInitContext_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TInitContext;

  // Implicit record copy method.
  Result := TInitContext_sw.ToVar(TInitContext(AObj));
end;

class function TInitContext_sw.GetTypeName: WideString;
begin
  Result := 'TInitContext';
end;

function TInitContext_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TInitContext_sw.Create;
  TInitContext_sw(Result).FValue := FValue;
end;

class procedure TInitContext_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('InitCount', TInitContext_InitCount_si, Integer_sw);
  AData.AddField('DLLInitState', TInitContext_DLLInitState_si, Byte_sw);
  AData.AddField('ThreadID', TInitContext_ThreadID_si, TThreadID_sw);
  AData.AddFunction('Copy', TInitContext_Copy_si, TInitContext_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TInitContext_Create_si, 0, False);
end;

class function TInitContext_sw.ToVar(const AValue: TInitContext): OleVariant;
var
  wrpr: TInitContext_sw;
begin
  wrpr        := TInitContext_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TInitContext_sw.FromVar(const AValue: OleVariant): TInitContext;
begin
  Result := TInitContext_sw(ConvFromVar(AValue)).FValue;
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

{ TRuntimeError_sw }

class function TRuntimeError_sw.GetTypeName: WideString;
begin
  Result := 'TRuntimeError';
end;

class procedure TRuntimeError_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..28] of TLMDEnumerator = (
    (Name: 'reNone'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reNone)),
    (Name: 'reOutOfMemory'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reOutOfMemory)),
    (Name: 'reInvalidPtr'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reInvalidPtr)),
    (Name: 'reDivByZero'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reDivByZero)),
    (Name: 'reRangeError'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reRangeError)),
    (Name: 'reIntOverflow'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reIntOverflow)),
    (Name: 'reInvalidOp'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reInvalidOp)),
    (Name: 'reZeroDivide'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reZeroDivide)),
    (Name: 'reOverflow'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reOverflow)),
    (Name: 'reUnderflow'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reUnderflow)),
    (Name: 'reInvalidCast'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reInvalidCast)),
    (Name: 'reAccessViolation'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reAccessViolation)),
    (Name: 'rePrivInstruction'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}rePrivInstruction)),
    (Name: 'reControlBreak'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reControlBreak)),
    (Name: 'reStackOverflow'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reStackOverflow)),
    (Name: 'reVarTypeCast'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reVarTypeCast)),
    (Name: 'reVarInvalidOp'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reVarInvalidOp)),
    (Name: 'reVarDispatch'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reVarDispatch)),
    (Name: 'reVarArrayCreate'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reVarArrayCreate)),
    (Name: 'reVarNotArray'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reVarNotArray)),
    (Name: 'reVarArrayBounds'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reVarArrayBounds)),
    (Name: 'reAssertionFailed'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reAssertionFailed)),
    (Name: 'reExternalException'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reExternalException)),
    (Name: 'reIntfCastError'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reIntfCastError)),
    (Name: 'reSafeCallError'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reSafeCallError)),
    (Name: 'reMonitorNotLocked'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reMonitorNotLocked)),
    (Name: 'reNoMonitorSupport'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reNoMonitorSupport)),
    (Name: 'rePlatformNotImplemented'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}rePlatformNotImplemented)),
    (Name: 'reObjectDisposed'; Value: Integer({$IFDEF LMDSCT_12}TRuntimeError.{$ENDIF}reObjectDisposed))
  );
begin
  AEnums := @ENUMS;
  ACount := 29;
end;

class function TRuntimeError_sw.ToVar(const AValue: TRuntimeError): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TRuntimeError_sw.FromVar(
  const AValue: OleVariant): TRuntimeError;
begin
  Result := TRuntimeError(Integer(AValue));
end;

{ System_sw }

function System_RTLVersion_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const RTLVersion = <value>;

  Result := RTLVersion;
end;

function System_CppLongInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type CppLongInt = LongInt;

  Result := TLMDUnitWrapper.TypeToVar(CppLongInt_sw);
end;

function System_CppULongInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type CppULongInt = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(CppULongInt_sw);
end;

function System_Int8_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type Int8 = ShortInt;

  Result := TLMDUnitWrapper.TypeToVar(Int8_sw);
end;

function System_Int16_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type Int16 = SmallInt;

  Result := TLMDUnitWrapper.TypeToVar(Int16_sw);
end;

function System_Int32_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type Int32 = Integer;

  Result := TLMDUnitWrapper.TypeToVar(Int32_sw);
end;

function System_IntPtr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type IntPtr = NativeInt;

  Result := TLMDUnitWrapper.TypeToVar(IntPtr_sw);
end;

function System_UInt8_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UInt8 = Byte;

  Result := TLMDUnitWrapper.TypeToVar(UInt8_sw);
end;

function System_UInt16_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UInt16 = Word;

  Result := TLMDUnitWrapper.TypeToVar(UInt16_sw);
end;

function System_UInt32_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UInt32 = Cardinal;

  Result := TLMDUnitWrapper.TypeToVar(UInt32_sw);
end;

function System_UIntPtr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UIntPtr = NativeUInt;

  Result := TLMDUnitWrapper.TypeToVar(UIntPtr_sw);
end;

function System__ShortStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _ShortStr = ShortString;

  Result := TLMDUnitWrapper.TypeToVar(_ShortStr_sw);
end;

function System__AnsiStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _AnsiStr = AnsiString;

  Result := TLMDUnitWrapper.TypeToVar(_AnsiStr_sw);
end;

function System__AnsiChr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _AnsiChr = AnsiChar;

  Result := TLMDUnitWrapper.TypeToVar(_AnsiChr_sw);
end;

function System__WideStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _WideStr = WideString;

  Result := TLMDUnitWrapper.TypeToVar(_WideStr_sw);
end;

function System_varEmpty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varEmpty = <value>;

  Result := varEmpty;
end;

function System_varNull_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varNull = <value>;

  Result := varNull;
end;

function System_varSmallint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varSmallint = <value>;

  Result := varSmallint;
end;

function System_varInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varInteger = <value>;

  Result := varInteger;
end;

function System_varSingle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varSingle = <value>;

  Result := varSingle;
end;

function System_varDouble_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varDouble = <value>;

  Result := varDouble;
end;

function System_varCurrency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varCurrency = <value>;

  Result := varCurrency;
end;

function System_varDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varDate = <value>;

  Result := varDate;
end;

function System_varOleStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varOleStr = <value>;

  Result := varOleStr;
end;

function System_varDispatch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varDispatch = <value>;

  Result := varDispatch;
end;

function System_varError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varError = <value>;

  Result := varError;
end;

function System_varBoolean_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varBoolean = <value>;

  Result := varBoolean;
end;

function System_varVariant_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varVariant = <value>;

  Result := varVariant;
end;

function System_varUnknown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varUnknown = <value>;

  Result := varUnknown;
end;

function System_varShortInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varShortInt = <value>;

  Result := varShortInt;
end;

function System_varByte_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varByte = <value>;

  Result := varByte;
end;

function System_varWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varWord = <value>;

  Result := varWord;
end;

function System_varLongWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varLongWord = <value>;

  Result := varLongWord;
end;

function System_varInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varInt64 = <value>;

  Result := varInt64;
end;

function System_varUInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varUInt64 = <value>;

  Result := varUInt64;
end;

function System_varRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varRecord = <value>;

  Result := varRecord;
end;

function System_varStrArg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varStrArg = <value>;

  Result := varStrArg;
end;

function System_varObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varObject = <value>;

  Result := varObject;
end;

function System_varUStrArg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varUStrArg = <value>;

  Result := varUStrArg;
end;

function System_varString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varString = <value>;

  Result := varString;
end;

function System_varAny_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varAny = <value>;

  Result := varAny;
end;

function System_varUString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varUString = <value>;

  Result := varUString;
end;

function System_varTypeMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varTypeMask = <value>;

  Result := varTypeMask;
end;

function System_varArray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varArray = <value>;

  Result := varArray;
end;

function System_varByRef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const varByRef = <value>;

  Result := varByRef;
end;

function System_vtInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtInteger = <value>;

  Result := vtInteger;
end;

function System_vtBoolean_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtBoolean = <value>;

  Result := vtBoolean;
end;

function System_vtChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtChar = <value>;

  Result := vtChar;
end;

function System_vtExtended_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtExtended = <value>;

  Result := vtExtended;
end;

function System_vtString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtString = <value>;

  Result := vtString;
end;

function System_vtPointer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtPointer = <value>;

  Result := vtPointer;
end;

function System_vtPChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtPChar = <value>;

  Result := vtPChar;
end;

function System_vtObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtObject = <value>;

  Result := vtObject;
end;

function System_vtClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtClass = <value>;

  Result := vtClass;
end;

function System_vtWideChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtWideChar = <value>;

  Result := vtWideChar;
end;

function System_vtPWideChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtPWideChar = <value>;

  Result := vtPWideChar;
end;

function System_vtAnsiString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtAnsiString = <value>;

  Result := vtAnsiString;
end;

function System_vtCurrency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtCurrency = <value>;

  Result := vtCurrency;
end;

function System_vtVariant_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtVariant = <value>;

  Result := vtVariant;
end;

function System_vtInterface_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtInterface = <value>;

  Result := vtInterface;
end;

function System_vtWideString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtWideString = <value>;

  Result := vtWideString;
end;

function System_vtInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtInt64 = <value>;

  Result := vtInt64;
end;

function System_vtUnicodeString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vtUnicodeString = <value>;

  Result := vtUnicodeString;
end;

function System_vmtArcOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtArcOffset = <value>;

  Result := vmtArcOffset;
end;

function System_CPP_ABI_ADJUST_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CPP_ABI_ADJUST = <value>;

  Result := CPP_ABI_ADJUST;
end;

function System_vmtSelfPtr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtSelfPtr = <value>;

  Result := vmtSelfPtr;
end;

function System_vmtIntfTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtIntfTable = <value>;

  Result := vmtIntfTable;
end;

function System_vmtAutoTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtAutoTable = <value>;

  Result := vmtAutoTable;
end;

function System_vmtInitTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtInitTable = <value>;

  Result := vmtInitTable;
end;

function System_vmtTypeInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtTypeInfo = <value>;

  Result := vmtTypeInfo;
end;

function System_vmtFieldTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtFieldTable = <value>;

  Result := vmtFieldTable;
end;

function System_vmtMethodTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtMethodTable = <value>;

  Result := vmtMethodTable;
end;

function System_vmtDynamicTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtDynamicTable = <value>;

  Result := vmtDynamicTable;
end;

function System_vmtClassName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtClassName = <value>;

  Result := vmtClassName;
end;

function System_vmtInstanceSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtInstanceSize = <value>;

  Result := vmtInstanceSize;
end;

function System_vmtParent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtParent = <value>;

  Result := vmtParent;
end;

function System_vmtEquals_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtEquals = <value>;

  Result := vmtEquals;
end;

function System_vmtGetHashCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtGetHashCode = <value>;

  Result := vmtGetHashCode;
end;

function System_vmtToString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtToString = <value>;

  Result := vmtToString;
end;

function System_vmtSafeCallException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtSafeCallException = <value>;

  Result := vmtSafeCallException;
end;

function System_vmtAfterConstruction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtAfterConstruction = <value>;

  Result := vmtAfterConstruction;
end;

function System_vmtBeforeDestruction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtBeforeDestruction = <value>;

  Result := vmtBeforeDestruction;
end;

function System_vmtDispatch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtDispatch = <value>;

  Result := vmtDispatch;
end;

function System_vmtDefaultHandler_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtDefaultHandler = <value>;

  Result := vmtDefaultHandler;
end;

function System_vmtNewInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtNewInstance = <value>;

  Result := vmtNewInstance;
end;

function System_vmtFreeInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtFreeInstance = <value>;

  Result := vmtFreeInstance;
end;

function System_vmtDestroy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtDestroy = <value>;

  Result := vmtDestroy;
end;

function System_vmtQueryInterface_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtQueryInterface = <value>;

  Result := vmtQueryInterface;
end;

function System_vmtAddRef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtAddRef = <value>;

  Result := vmtAddRef;
end;

function System_vmtRelease_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtRelease = <value>;

  Result := vmtRelease;
end;

function System_vmtCreateObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vmtCreateObject = <value>;

  Result := vmtCreateObject;
end;

function System_hfFieldSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const hfFieldSize = <value>;

  Result := hfFieldSize;
end;

function System_hfMonitorOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const hfMonitorOffset = <value>;

  Result := hfMonitorOffset;
end;

function System_DefaultMethodRttiVisibility_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DefaultMethodRttiVisibility = <value>;

  Result := LMDSetToVar(SizeOf(DefaultMethodRttiVisibility), 
    DefaultMethodRttiVisibility);
end;

function System_DefaultFieldRttiVisibility_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DefaultFieldRttiVisibility = <value>;

  Result := LMDSetToVar(SizeOf(DefaultFieldRttiVisibility), 
    DefaultFieldRttiVisibility);
end;

function System_DefaultPropertyRttiVisibility_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DefaultPropertyRttiVisibility = <value>;

  Result := LMDSetToVar(SizeOf(DefaultPropertyRttiVisibility), 
    DefaultPropertyRttiVisibility);
end;

function System_TClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TClass = class of TObject;

  Result := TLMDUnitWrapper.TypeToVar(TClass_sw);
end;

function System_HRESULT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HRESULT = Longint;

  Result := TLMDUnitWrapper.TypeToVar(HRESULT_sw);
end;

function System_TGUID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGUID = record;

  Result := TLMDUnitWrapper.TypeToVar(TGUID_sw);
end;

function System_TInterfaceEntry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInterfaceEntry = record;

  Result := TLMDUnitWrapper.TypeToVar(TInterfaceEntry_sw);
end;

function System_TInterfaceTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInterfaceTable = record;

  Result := TLMDUnitWrapper.TypeToVar(TInterfaceTable_sw);
end;

function System_TMethod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMethod = record;

  Result := TLMDUnitWrapper.TypeToVar(TMethod_sw);
end;

function System_TDispatchMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDispatchMessage = record;

  Result := TLMDUnitWrapper.TypeToVar(TDispatchMessage_sw);
end;

function System_TObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TObject = class;

  Result := TLMDUnitWrapper.TypeToVar(TObject_sw);
end;

function System_TCustomAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomAttribute = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TCustomAttribute_sw);
end;

function System_WeakAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type WeakAttribute = class(TCustomAttribute);

  Result := TLMDUnitWrapper.TypeToVar(WeakAttribute_sw);
end;

function System_UnsafeAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UnsafeAttribute = class(TCustomAttribute);

  Result := TLMDUnitWrapper.TypeToVar(UnsafeAttribute_sw);
end;

function System_RefAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type RefAttribute = class(TCustomAttribute);

  Result := TLMDUnitWrapper.TypeToVar(RefAttribute_sw);
end;

function System_VolatileAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type VolatileAttribute = class(TCustomAttribute);

  Result := TLMDUnitWrapper.TypeToVar(VolatileAttribute_sw);
end;

function System_StoredAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type StoredAttribute = class(TCustomAttribute);

  Result := TLMDUnitWrapper.TypeToVar(StoredAttribute_sw);
end;

function System_TThreadID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TThreadID = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(TThreadID_sw);
end;

function System_TMonitor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMonitor = record;

  Result := TLMDUnitWrapper.TypeToVar(TMonitor_sw);
end;

function System_INFINITE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const INFINITE = <value>;

  Result := INFINITE;
end;

function System_MonitorEnter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MonitorEnter(const AObject: TObject; Timeout: Ca...

  case AArgsSize of
    1:
    begin
      Result := System.MonitorEnter(TObject_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      Result := System.MonitorEnter(TObject_sw.FromVar(AArgs[0]), Cardinal(
        AArgs[1]));
    end;
  else
    WrongArgCountError('MonitorEnter');
  end;
end;

function System_MonitorTryEnter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MonitorTryEnter(const AObject: TObject): Boolean;

  Result := System.MonitorTryEnter(TObject_sw.FromVar(AArgs[0]));
end;

function System_MonitorExit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MonitorExit(const AObject: TObject);

  System.MonitorExit(TObject_sw.FromVar(AArgs[0]));
end;

function System_MonitorWait_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function MonitorWait(...); overload;

  case AArgsSize of
    2:
    begin
      Result := System.MonitorWait(TObject_sw.FromVar(AArgs[0]), Cardinal(
        AArgs[1]));
    end;
    3:
    begin
      Result := System.MonitorWait(TObject_sw.FromVar(AArgs[0]), TObject_sw.
        FromVar(AArgs[1]), Cardinal(AArgs[2]));
    end;
  else
    WrongArgCountError('MonitorWait');
  end;
end;

function System_MonitorPulse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MonitorPulse(const AObject: TObject);

  System.MonitorPulse(TObject_sw.FromVar(AArgs[0]));
end;

function System_MonitorPulseAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MonitorPulseAll(const AObject: TObject);

  System.MonitorPulseAll(TObject_sw.FromVar(AArgs[0]));
end;

function System_YieldProcessor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure YieldProcessor;

  System.YieldProcessor();
end;

function System_S_OK_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const S_OK = <value>;

  Result := S_OK;
end;

function System_S_FALSE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const S_FALSE = <value>;

  Result := S_FALSE;
end;

function System_E_NOINTERFACE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const E_NOINTERFACE = <value>;

  Result := HRESULT_sw.ToVar(E_NOINTERFACE);
end;

function System_E_UNEXPECTED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const E_UNEXPECTED = <value>;

  Result := HRESULT_sw.ToVar(E_UNEXPECTED);
end;

function System_E_NOTIMPL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const E_NOTIMPL = <value>;

  Result := HRESULT_sw.ToVar(E_NOTIMPL);
end;

function System_TInterfacedObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInterfacedObject = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TInterfacedObject_sw);
end;

function System_TInterfacedClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInterfacedClass = class of TInterfacedObject;

  Result := TLMDUnitWrapper.TypeToVar(TInterfacedClass_sw);
end;

function System_TAggregatedObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAggregatedObject = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TAggregatedObject_sw);
end;

function System_TContainedObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TContainedObject = class(TAggregatedObject);

  Result := TLMDUnitWrapper.TypeToVar(TContainedObject_sw);
end;

function System_TClassHelperBase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TClassHelperBase = class(TInterfacedObject);

  Result := TLMDUnitWrapper.TypeToVar(TClassHelperBase_sw);
end;

function System_TClassHelperBaseClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TClassHelperBaseClass = class of TClassHelperBase;

  Result := TLMDUnitWrapper.TypeToVar(TClassHelperBaseClass_sw);
end;

function System_UCS2Char_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UCS2Char = WideChar;

  Result := TLMDUnitWrapper.TypeToVar(UCS2Char_sw);
end;

function System_UCS4Char_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UCS4Char = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(UCS4Char_sw);
end;

function System_UTF8String_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UTF8String = AnsiString;

  Result := TLMDUnitWrapper.TypeToVar(UTF8String_sw);
end;

function System_RawByteString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type RawByteString = AnsiString;

  Result := TLMDUnitWrapper.TypeToVar(RawByteString_sw);
end;

function System__UTF8Str_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _UTF8Str = UTF8String;

  Result := TLMDUnitWrapper.TypeToVar(_UTF8Str_sw);
end;

function System__RawByteStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _RawByteStr = RawByteString;

  Result := TLMDUnitWrapper.TypeToVar(_RawByteStr_sw);
end;

function System_TDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDateTime = Double;

  Result := TLMDUnitWrapper.TypeToVar(TDateTime_sw);
end;

function System_TDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDate = TDateTime;

  Result := TLMDUnitWrapper.TypeToVar(TDate_sw);
end;

function System_TTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTime = TDateTime;

  Result := TLMDUnitWrapper.TypeToVar(TTime_sw);
end;

function System_THandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THandle = NativeUInt;

  Result := TLMDUnitWrapper.TypeToVar(THandle_sw);
end;

function System_TVarArrayBound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVarArrayBound = record;

  Result := TLMDUnitWrapper.TypeToVar(TVarArrayBound_sw);
end;

function System_TVarArray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVarArray = record;

  Result := TLMDUnitWrapper.TypeToVar(TVarArray_sw);
end;

function System_TVarRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVarRecord = record;

  Result := TLMDUnitWrapper.TypeToVar(TVarRecord_sw);
end;

function System_TLargestVarData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLargestVarData = record;

  Result := TLMDUnitWrapper.TypeToVar(TLargestVarData_sw);
end;

function System_TVarType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVarType = Word;

  Result := TLMDUnitWrapper.TypeToVar(TVarType_sw);
end;

function System_TVarData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVarData = record;

  Result := TLMDUnitWrapper.TypeToVar(TVarData_sw);
end;

function System_TVarOp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVarOp = Integer;

  Result := TLMDUnitWrapper.TypeToVar(TVarOp_sw);
end;

function System_opAdd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opAdd = <value>;

  Result := opAdd;
end;

function System_opSubtract_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opSubtract = <value>;

  Result := opSubtract;
end;

function System_opMultiply_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opMultiply = <value>;

  Result := opMultiply;
end;

function System_opDivide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opDivide = <value>;

  Result := opDivide;
end;

function System_opIntDivide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opIntDivide = <value>;

  Result := opIntDivide;
end;

function System_opModulus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opModulus = <value>;

  Result := opModulus;
end;

function System_opShiftLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opShiftLeft = <value>;

  Result := opShiftLeft;
end;

function System_opShiftRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opShiftRight = <value>;

  Result := opShiftRight;
end;

function System_opAnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opAnd = <value>;

  Result := opAnd;
end;

function System_opOr_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const opOr = <value>;

  Result := opOr;
end;

function System_opXor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opXor = <value>;

  Result := opXor;
end;

function System_opCompare_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opCompare = <value>;

  Result := opCompare;
end;

function System_opNegate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opNegate = <value>;

  Result := opNegate;
end;

function System_opNot_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opNot = <value>;

  Result := opNot;
end;

function System_opCmpEQ_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opCmpEQ = <value>;

  Result := opCmpEQ;
end;

function System_opCmpNE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opCmpNE = <value>;

  Result := opCmpNE;
end;

function System_opCmpLT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opCmpLT = <value>;

  Result := opCmpLT;
end;

function System_opCmpLE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opCmpLE = <value>;

  Result := opCmpLE;
end;

function System_opCmpGT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opCmpGT = <value>;

  Result := opCmpGT;
end;

function System_opCmpGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const opCmpGE = <value>;

  Result := opCmpGE;
end;

function System_NumSmallBlockTypes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const NumSmallBlockTypes = <value>;

  Result := NumSmallBlockTypes;
end;

function System_TCallDesc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCallDesc = record;

  Result := TLMDUnitWrapper.TypeToVar(TCallDesc_sw);
end;

function System_TDispDesc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDispDesc = record;

  Result := TLMDUnitWrapper.TypeToVar(TDispDesc_sw);
end;

function System_TVariantManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVariantManager = record;

  Result := TLMDUnitWrapper.TypeToVar(TVariantManager_sw);
end;

function System_TTypeKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTypeKind = (tkUnknown, tkInteger, tkChar, tkEnumera...

  Result := TLMDUnitWrapper.TypeToVar(TTypeKind_sw);
end;

function System_TDynArrayTypeInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDynArrayTypeInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TDynArrayTypeInfo_sw);
end;

function System_TVarRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVarRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TVarRec_sw);
end;

function System_TMemoryManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMemoryManager = record;

  Result := TLMDUnitWrapper.TypeToVar(TMemoryManager_sw);
end;

function System_TMemoryManagerEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMemoryManagerEx = record;

  Result := TLMDUnitWrapper.TypeToVar(TMemoryManagerEx_sw);
end;

function System_THeapStatus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THeapStatus = record;

  Result := TLMDUnitWrapper.TypeToVar(THeapStatus_sw);
end;

function System_TSmallBlockTypeState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSmallBlockTypeState = record;

  Result := TLMDUnitWrapper.TypeToVar(TSmallBlockTypeState_sw);
end;

function System_TMemoryManagerState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMemoryManagerState = record;

  Result := TLMDUnitWrapper.TypeToVar(TMemoryManagerState_sw);
end;

function System_TMonitorSupport_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMonitorSupport = record;

  Result := TLMDUnitWrapper.TypeToVar(TMonitorSupport_sw);
end;

function System_TPtrWrapper_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPtrWrapper = record;

  Result := TLMDUnitWrapper.TypeToVar(TPtrWrapper_sw);
end;

function System_TMarshal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMarshal = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TMarshal_sw);
end;

function System_TChunkStatus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TChunkStatus = (csUnallocated, csAllocated, csReserv...

  Result := TLMDUnitWrapper.TypeToVar(TChunkStatus_sw);
end;

function System_TMinimumBlockAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMinimumBlockAlignment = (mba8Byte, mba16Byte);

  Result := TLMDUnitWrapper.TypeToVar(TMinimumBlockAlignment_sw);
end;

function System_PackageUnitEntry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type PackageUnitEntry = record;

  Result := TLMDUnitWrapper.TypeToVar(PackageUnitEntry_sw);
end;

function System_TPackageTypeInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPackageTypeInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TPackageTypeInfo_sw);
end;

function System_PackageInfoTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type PackageInfoTable = record;

  Result := TLMDUnitWrapper.TypeToVar(PackageInfoTable_sw);
end;

function System_ReleaseExceptionObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ReleaseExceptionObject;

  System.ReleaseExceptionObject();
end;

function System_ExceptObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExceptObject: TObject;

  Result := TObject_sw.ToVar(System.ExceptObject());
end;

function System_TCVModInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCVModInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TCVModInfo_sw);
end;

function System_ExceptionClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ExceptionClass: TClass;

  if IsGet then
    Result := TClass_sw.ToVar(System.ExceptionClass)
  else
    System.ExceptionClass := TClass_sw.FromVar(AArgs[0]);
end;

function System_HPrevInst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HPrevInst: LongWord;

  if IsGet then
    Result := System.HPrevInst
  else
    System.HPrevInst := LongWord(AArgs[0]);
end;

function System_MainInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MainInstance: THandle;

  if IsGet then
    Result := THandle_sw.ToVar(System.MainInstance)
  else
    System.MainInstance := THandle_sw.FromVar(AArgs[0]);
end;

function System_MainThreadID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MainThreadID: TThreadID;

  if IsGet then
    Result := TThreadID_sw.ToVar(System.MainThreadID)
  else
    System.MainThreadID := TThreadID_sw.FromVar(AArgs[0]);
end;

function System_IsLibrary_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var IsLibrary: Boolean;

  if IsGet then
    Result := System.IsLibrary
  else
    System.IsLibrary := Boolean(AArgs[0]);
end;

function System_CmdShow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CmdShow: Integer;

  if IsGet then
    Result := System.CmdShow
  else
    System.CmdShow := Integer(AArgs[0]);
end;

function System_ExitCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ExitCode: Integer;

  if IsGet then
    Result := System.ExitCode
  else
    System.ExitCode := Integer(AArgs[0]);
end;

function System_RandSeed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var RandSeed: Longint;

  if IsGet then
    Result := System.RandSeed
  else
    System.RandSeed := Longint(AArgs[0]);
end;

function System_IsConsole_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var IsConsole: Boolean;

  if IsGet then
    Result := System.IsConsole
  else
    System.IsConsole := Boolean(AArgs[0]);
end;

function System_IsMultiThread_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var IsMultiThread: Boolean;

  if IsGet then
    Result := System.IsMultiThread
  else
    System.IsMultiThread := Boolean(AArgs[0]);
end;

function System_FileMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FileMode: Byte;

  if IsGet then
    Result := System.FileMode
  else
    System.FileMode := Byte(AArgs[0]);
end;

function System_Test8086_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Test8086: Byte;

  if IsGet then
    Result := System.Test8086
  else
    System.Test8086 := Byte(AArgs[0]);
end;

function System_Test8087_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Test8087: Byte;

  if IsGet then
    Result := System.Test8087
  else
    System.Test8087 := Byte(AArgs[0]);
end;

function System_TestFDIV_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TestFDIV: Shortint;

  if IsGet then
    Result := System.TestFDIV
  else
    System.TestFDIV := Shortint(AArgs[0]);
end;

function System_TestSSE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TestSSE: Cardinal;

  if IsGet then
    Result := System.TestSSE
  else
    System.TestSSE := Cardinal(AArgs[0]);
end;

function System_CPUCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CPUCount: Integer;

  if IsGet then
    Result := System.CPUCount
  else
    System.CPUCount := Integer(AArgs[0]);
end;

function System_CPUi386_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CPUi386 = <value>;

  Result := CPUi386;
end;

function System_CPUi486_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CPUi486 = <value>;

  Result := CPUi486;
end;

function System_CPUPentium_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CPUPentium = <value>;

  Result := CPUPentium;
end;

function System_Default8087CW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Default8087CW: Word;

  if IsGet then
    Result := System.Default8087CW
  else
    System.Default8087CW := Word(AArgs[0]);
end;

function System_DefaultMXCSR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultMXCSR: UInt32;

  if IsGet then
    Result := UInt32_sw.ToVar(System.DefaultMXCSR)
  else
    System.DefaultMXCSR := UInt32_sw.FromVar(AArgs[0]);
end;

function System_HeapAllocFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HeapAllocFlags: Word;

  if IsGet then
    Result := System.HeapAllocFlags
  else
    System.HeapAllocFlags := Word(AArgs[0]);
end;

function System_DebugHook_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DebugHook: Byte;

  if IsGet then
    Result := System.DebugHook
  else
    System.DebugHook := Byte(AArgs[0]);
end;

function System_JITEnable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var JITEnable: Byte;

  if IsGet then
    Result := System.JITEnable
  else
    System.JITEnable := Byte(AArgs[0]);
end;

function System_NoErrMsg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var NoErrMsg: Boolean;

  if IsGet then
    Result := System.NoErrMsg
  else
    System.NoErrMsg := Boolean(AArgs[0]);
end;

function System_DefaultSystemCodePage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultSystemCodePage: Integer;

  if IsGet then
    Result := System.DefaultSystemCodePage
  else
    System.DefaultSystemCodePage := Integer(AArgs[0]);
end;

function System_DefaultUnicodeCodePage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultUnicodeCodePage: Integer;

  if IsGet then
    Result := System.DefaultUnicodeCodePage
  else
    System.DefaultUnicodeCodePage := Integer(AArgs[0]);
end;

function System_UTF8CompareLocale_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var UTF8CompareLocale: Cardinal;

  if IsGet then
    Result := System.UTF8CompareLocale
  else
    System.UTF8CompareLocale := Cardinal(AArgs[0]);
end;

function System_SetUTF8CompareLocale_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetUTF8CompareLocale;

  System.SetUTF8CompareLocale();
end;

function System_TTextLineBreakStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTextLineBreakStyle = (tlbsLF, tlbsCRLF);

  Result := TLMDUnitWrapper.TypeToVar(TTextLineBreakStyle_sw);
end;

function System_DefaultTextLineBreakStyle_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultTextLineBreakStyle: TTextLineBreakStyle;

  if IsGet then
    Result := TTextLineBreakStyle_sw.ToVar(System.DefaultTextLineBreakStyle)
  else
    System.DefaultTextLineBreakStyle := TTextLineBreakStyle_sw.FromVar(
      AArgs[0]);
end;

function System_sLineBreak_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sLineBreak = <value>;

  Result := sLineBreak;
end;

function System_HRSRC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HRSRC = THandle;

  Result := TLMDUnitWrapper.TypeToVar(HRSRC_sw);
end;

function System_TResourceHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TResourceHandle = HRSRC;

  Result := TLMDUnitWrapper.TypeToVar(TResourceHandle_sw);
end;

function System_HINST_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HINST = THandle;

  Result := TLMDUnitWrapper.TypeToVar(HINST_sw);
end;

function System_HMODULE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HMODULE = HINST;

  Result := TLMDUnitWrapper.TypeToVar(HMODULE_sw);
end;

function System_HGLOBAL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HGLOBAL = THandle;

  Result := TLMDUnitWrapper.TypeToVar(HGLOBAL_sw);
end;

function System_LoadResource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function LoadResource(ModuleHandle: HMODULE; ResHandle: T...

  Result := HGLOBAL_sw.ToVar(System.LoadResource(HMODULE_sw.FromVar(AArgs[0]), 
    TResourceHandle_sw.FromVar(AArgs[1])));
end;

function System_SizeofResource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SizeofResource(ModuleHandle: HMODULE; ResHandle:...

  Result := System.SizeofResource(HMODULE_sw.FromVar(AArgs[0]), 
    TResourceHandle_sw.FromVar(AArgs[1]));
end;

function System_UnlockResource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UnlockResource(ResData: HGLOBAL): LongBool;

  Result := System.UnlockResource(HGLOBAL_sw.FromVar(AArgs[0]));
end;

function System_FreeResource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FreeResource(ResData: HGLOBAL): LongBool;

  Result := System.FreeResource(HGLOBAL_sw.FromVar(AArgs[0]));
end;

function System_IsMemoryManagerSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsMemoryManagerSet: Boolean;

  Result := System.IsMemoryManagerSet();
end;

function System_AllocMemCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var AllocMemCount: Integer;

  if IsGet then
    Result := System.AllocMemCount
  else
    System.AllocMemCount := Integer(AArgs[0]);
end;

function System_AllocMemSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var AllocMemSize: Integer;

  if IsGet then
    Result := System.AllocMemSize
  else
    System.AllocMemSize := Integer(AArgs[0]);
end;

function System_ReportMemoryLeaksOnShutdown_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ReportMemoryLeaksOnShutdown: Boolean;

  if IsGet then
    Result := System.ReportMemoryLeaksOnShutdown
  else
    System.ReportMemoryLeaksOnShutdown := Boolean(AArgs[0]);
end;

function System_NeverSleepOnMMThreadContention_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var NeverSleepOnMMThreadContention: Boolean;

  if IsGet then
    Result := System.NeverSleepOnMMThreadContention
  else
    System.NeverSleepOnMMThreadContention := Boolean(AArgs[0]);
end;

function System_GetHeapStatus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetHeapStatus: THeapStatus;

  Result := THeapStatus_sw.ToVar(System.GetHeapStatus());
end;

function System_GetMemoryManagerState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TMemoryManagerState;
begin
  // procedure GetMemoryManagerState(var AMemoryManagerState: ...

  v_1 := TMemoryManagerState_sw.FromVar(AArgs[0]);
  System.GetMemoryManagerState(v_1);
  AssignRefParam(AArgs[0], TMemoryManagerState_sw.ToVar(v_1));
end;

function System_GetMinimumBlockAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetMinimumBlockAlignment: TMinimumBlockAlignment;

  Result := TMinimumBlockAlignment_sw.ToVar(System.GetMinimumBlockAlignment());
end;

function System_SetMinimumBlockAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetMinimumBlockAlignment(AMinimumBlockAlignment...

  System.SetMinimumBlockAlignment(TMinimumBlockAlignment_sw.FromVar(AArgs[0]));
end;

function System_AttemptToUseSharedMemoryManager_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AttemptToUseSharedMemoryManager: Boolean;

  Result := System.AttemptToUseSharedMemoryManager();
end;

function System_ShareMemoryManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ShareMemoryManager: Boolean;

  Result := System.ShareMemoryManager();
end;

function System_EndThread_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndThread(ExitCode: Integer);

  System.EndThread(Integer(AArgs[0]));
end;

function System_fmClosed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmClosed = <value>;

  Result := fmClosed;
end;

function System_fmInput_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmInput = <value>;

  Result := fmInput;
end;

function System_fmOutput_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmOutput = <value>;

  Result := fmOutput;
end;

function System_fmInOut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmInOut = <value>;

  Result := fmInOut;
end;

function System_tfCRLF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const tfCRLF = <value>;

  Result := tfCRLF;
end;

function System_TFileRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TFileRec_sw);
end;

function System_TTextRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTextRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TTextRec_sw);
end;

function System___IOTest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure __IOTest;

  System.__IOTest();
end;

function System_SetInOutRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetInOutRes(NewValue: Integer);

  System.SetInOutRes(Integer(AArgs[0]));
end;

function System_ChDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function ChDir(...); overload;

  System.ChDir(string(AArgs[0]));
end;

function System__UGetDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UGetDir(D: Byte; var S: UnicodeString);

  v_1 := UnicodeString(AArgs[1]);
  System._UGetDir(Byte(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function System__LGetDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LGetDir(D: Byte; var S: _AnsiStr);

  v_1 := _AnsiStr_sw.FromVar(AArgs[1]);
  System._LGetDir(Byte(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], _AnsiStr_sw.ToVar(v_1));
end;

function System__WGetDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WGetDir(D: Byte; var S: _WideStr);

  v_1 := _WideStr_sw.FromVar(AArgs[1]);
  System._WGetDir(Byte(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], _WideStr_sw.ToVar(v_1));
end;

function System__SGetDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _ShortStr;
begin
  // procedure _SGetDir(D: Byte; var S: _ShortStr);

  v_1 := _ShortStr_sw.FromVar(AArgs[1]);
  System._SGetDir(Byte(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], _ShortStr_sw.ToVar(v_1));
end;

function System_IOResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IOResult: Integer;

  Result := System.IOResult();
end;

function System_MkDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function MkDir(...); overload;

  System.MkDir(string(AArgs[0]));
end;

function System_ParamCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ParamCount: Integer;

  Result := System.ParamCount();
end;

function System_ParamStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ParamStr(Index: Integer): string;

  Result := System.ParamStr(Integer(AArgs[0]));
end;

function System_RmDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function RmDir(...); overload;

  System.RmDir(string(AArgs[0]));
end;

function System_UpCase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function UpCase(...); overload;

  Result := Ord(System.UpCase(WideChar(Integer(AArgs[0]))));
end;

function System_Randomize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Randomize;

  System.Randomize();
end;

function System_Random_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Random(...); overload;

  case AArgsSize of
    1:
    begin
      Result := System.Random(Integer(AArgs[0]));
    end;
    0:
    begin
      Result := System.Random();
    end;
  else
    WrongArgCountError('Random');
  end;
end;

function System_feeINEXACT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const feeINEXACT = <value>;

  Result := feeINEXACT;
end;

function System_feeUNDERFLOW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const feeUNDERFLOW = <value>;

  Result := feeUNDERFLOW;
end;

function System_feeOVERFLOW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const feeOVERFLOW = <value>;

  Result := feeOVERFLOW;
end;

function System_feeDIVBYZERO_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const feeDIVBYZERO = <value>;

  Result := feeDIVBYZERO;
end;

function System_feeINVALID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const feeINVALID = <value>;

  Result := feeINVALID;
end;

function System_feeALLEXCEPT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const feeALLEXCEPT = <value>;

  Result := feeALLEXCEPT;
end;

function System_feeDENORMALOPERAND_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const feeDENORMALOPERAND = <value>;

  Result := feeDENORMALOPERAND;
end;

function System_femINEXACT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const femINEXACT = <value>;

  Result := femINEXACT;
end;

function System_femUNDERFLOW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const femUNDERFLOW = <value>;

  Result := femUNDERFLOW;
end;

function System_femOVERFLOW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const femOVERFLOW = <value>;

  Result := femOVERFLOW;
end;

function System_femDIVBYZERO_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const femDIVBYZERO = <value>;

  Result := femDIVBYZERO;
end;

function System_femINVALID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const femINVALID = <value>;

  Result := femINVALID;
end;

function System_femALLEXCEPT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const femALLEXCEPT = <value>;

  Result := femALLEXCEPT;
end;

function System_femDENORMALOPERAND_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const femDENORMALOPERAND = <value>;

  Result := femDENORMALOPERAND;
end;

function System_ferTONEAREST_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ferTONEAREST = <value>;

  Result := ferTONEAREST;
end;

function System_ferUPWARD_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ferUPWARD = <value>;

  Result := ferUPWARD;
end;

function System_ferDOWNWARD_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ferDOWNWARD = <value>;

  Result := ferDOWNWARD;
end;

function System_ferTOWARDZERO_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ferTOWARDZERO = <value>;

  Result := ferTOWARDZERO;
end;

function System_ferALLROUND_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ferALLROUND = <value>;

  Result := ferALLROUND;
end;

function System_FClearExcept_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FClearExcept;

  System.FClearExcept();
end;

function System_FCheckExcept_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FCheckExcept;

  System.FCheckExcept();
end;

function System_FRaiseExcept_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FRaiseExcept(excepts: UInt32; CheckExceptionMas...

  case AArgsSize of
    1:
    begin
      System.FRaiseExcept(UInt32_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      System.FRaiseExcept(UInt32_sw.FromVar(AArgs[0]), Boolean(AArgs[1]));
    end;
  else
    WrongArgCountError('FRaiseExcept');
  end;
end;

function System_FGetRound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FGetRound: UInt32;

  Result := UInt32_sw.ToVar(System.FGetRound());
end;

function System_FSetRound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FSetRound(NewRound: UInt32): UInt32;

  Result := UInt32_sw.ToVar(System.FSetRound(UInt32_sw.FromVar(AArgs[0])));
end;

function System_FSetExceptFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FSetExceptFlag(NewFlags: UInt32; Excepts: UInt32...

  case AArgsSize of
    1:
    begin
      Result := UInt32_sw.ToVar(System.FSetExceptFlag(UInt32_sw.FromVar(
        AArgs[0])));
    end;
    2:
    begin
      Result := UInt32_sw.ToVar(System.FSetExceptFlag(UInt32_sw.FromVar(
        AArgs[0]), UInt32_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('FSetExceptFlag');
  end;
end;

function System_FGetExceptFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FGetExceptFlag(Excepts: UInt32): UInt32;

  case AArgsSize of
    0:
    begin
      Result := UInt32_sw.ToVar(System.FGetExceptFlag());
    end;
    1:
    begin
      Result := UInt32_sw.ToVar(System.FGetExceptFlag(UInt32_sw.FromVar(
        AArgs[0])));
    end;
  else
    WrongArgCountError('FGetExceptFlag');
  end;
end;

function System_FSetExceptMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FSetExceptMask(NewMasks: UInt32; ExceptMasks: UI...

  case AArgsSize of
    1:
    begin
      Result := UInt32_sw.ToVar(System.FSetExceptMask(UInt32_sw.FromVar(
        AArgs[0])));
    end;
    2:
    begin
      Result := UInt32_sw.ToVar(System.FSetExceptMask(UInt32_sw.FromVar(
        AArgs[0]), UInt32_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('FSetExceptMask');
  end;
end;

function System_FGetExceptMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FGetExceptMask(ExceptMasks: UInt32): UInt32;

  case AArgsSize of
    0:
    begin
      Result := UInt32_sw.ToVar(System.FGetExceptMask());
    end;
    1:
    begin
      Result := UInt32_sw.ToVar(System.FGetExceptMask(UInt32_sw.FromVar(
        AArgs[0])));
    end;
  else
    WrongArgCountError('FGetExceptMask');
  end;
end;

function System_Reset8087CW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Reset8087CW;

  System.Reset8087CW();
end;

function System_Set8087CW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Set8087CW(NewCW: Word);

  System.Set8087CW(Word(AArgs[0]));
end;

function System_Get8087CW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Get8087CW: Word;

  Result := System.Get8087CW();
end;

function System_ResetMXCSR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ResetMXCSR;

  System.ResetMXCSR();
end;

function System_SetMXCSR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetMXCSR(NewMXCSR: UInt32);

  System.SetMXCSR(UInt32_sw.FromVar(AArgs[0]));
end;

function System_SetMXCSRExceptionFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetMXCSRExceptionFlag(NewExceptionFlag: UInt32);

  System.SetMXCSRExceptionFlag(UInt32_sw.FromVar(AArgs[0]));
end;

function System_GetMXCSR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetMXCSR: UInt32;

  Result := UInt32_sw.ToVar(System.GetMXCSR());
end;

function System_UTF8Encode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function UTF8Encode(...); overload;

  Result := _RawByteStr_sw.ToVar(System.UTF8Encode(_WideStr_sw.FromVar(
    AArgs[0])));
end;

function System_UTF8EncodeToShortString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function UTF8EncodeToShortString(...); overload;

  Result := _ShortStr_sw.ToVar(System.UTF8EncodeToShortString(_WideStr_sw.
    FromVar(AArgs[0])));
end;

function System_UTF8Decode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UTF8Decode(const S: _RawByteStr): _WideStr;

  Result := _WideStr_sw.ToVar(System.UTF8Decode(_RawByteStr_sw.FromVar(
    AArgs[0])));
end;

function System_UTF8ToWideString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UTF8ToWideString(const S: _RawByteStr): _WideStr;

  Result := _WideStr_sw.ToVar(System.UTF8ToWideString(_RawByteStr_sw.FromVar(
    AArgs[0])));
end;

function System_UTF8ToUnicodeString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function UTF8ToUnicodeString(...); overload;

  Result := System.UTF8ToUnicodeString(_RawByteStr_sw.FromVar(AArgs[0]));
end;

function System_UTF8ToString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function UTF8ToString(...); overload;

  Result := System.UTF8ToString(_RawByteStr_sw.FromVar(AArgs[0]));
end;

function System_AnsiToUtf8_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AnsiToUtf8(const S: string): _RawByteStr;

  Result := _RawByteStr_sw.ToVar(System.AnsiToUtf8(string(AArgs[0])));
end;

function System_Utf8ToAnsi_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Utf8ToAnsi(const S: _RawByteStr): string;

  Result := System.Utf8ToAnsi(_RawByteStr_sw.FromVar(AArgs[0]));
end;

function System_GetVariantManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TVariantManager;
begin
  // procedure GetVariantManager(var VarMgr: TVariantManager);

  v_1 := TVariantManager_sw.FromVar(AArgs[0]);
  System.GetVariantManager(v_1);
  AssignRefParam(AArgs[0], TVariantManager_sw.ToVar(v_1));
end;

function System_SetVariantManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetVariantManager(const VarMgr: TVariantManager);

  System.SetVariantManager(TVariantManager_sw.FromVar(AArgs[0]));
end;

function System_IsVariantManagerSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsVariantManagerSet: Boolean;

  Result := System.IsVariantManagerSet();
end;

function System__IntfDispCall_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _IntfDispCall;

  System._IntfDispCall();
end;

function System__IntfVarCall_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _IntfVarCall;

  System._IntfVarCall();
end;

function System_TLibModule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLibModule = record;

  Result := TLMDUnitWrapper.TypeToVar(TLibModule_sw);
end;

function System_TModuleUnloadRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TModuleUnloadRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TModuleUnloadRec_sw);
end;

function System_FindClassHInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindClassHInstance(ClassType: TClass): HINST;

  Result := HINST_sw.ToVar(System.FindClassHInstance(TClass_sw.FromVar(
    AArgs[0])));
end;

function System_FindResourceHInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindResourceHInstance(Instance: HINST): HINST;

  Result := HINST_sw.ToVar(System.FindResourceHInstance(HINST_sw.FromVar(
    AArgs[0])));
end;

function System_GetResourceModuleName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetResourceModuleName(HostAppName: string; Modul...

  Result := System.GetResourceModuleName(string(AArgs[0]), string(AArgs[1]));
end;

function System_TResStringRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TResStringRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TResStringRec_sw);
end;

function System_TFloatSpecial_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFloatSpecial = (fsZero, fsNZero, fsDenormal, fsNDen...

  Result := TLMDUnitWrapper.TypeToVar(TFloatSpecial_sw);
end;

function System_TSingleRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSingleRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TSingleRec_sw);
end;

function System_TDoubleRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDoubleRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TDoubleRec_sw);
end;

function System_TExtended80Rec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExtended80Rec = record;

  Result := TLMDUnitWrapper.TypeToVar(TExtended80Rec_sw);
end;

function System_TExtendedRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExtendedRec = TExtended80Rec;

  Result := TLMDUnitWrapper.TypeToVar(TExtendedRec_sw);
end;

function System_Int_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Int(const X: Extended): Extended;

  Result := System.Int(Extended(AArgs[0]));
end;

function System_Frac_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Frac(const X: Extended): Extended;

  Result := System.Frac(Extended(AArgs[0]));
end;

function System_Exp_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Exp(const X: Extended): Extended;

  Result := System.Exp(Extended(AArgs[0]));
end;

function System_Cos_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Cos(const X: Extended): Extended;

  Result := System.Cos(Extended(AArgs[0]));
end;

function System_Sin_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Sin(const X: Extended): Extended;

  Result := System.Sin(Extended(AArgs[0]));
end;

function System_Ln_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Ln(const X: Extended): Extended;

  Result := System.Ln(Extended(AArgs[0]));
end;

function System_ArcTan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ArcTan(const X: Extended): Extended;

  Result := System.ArcTan(Extended(AArgs[0]));
end;

function System_Sqrt_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Sqrt(const X: Extended): Extended;

  Result := System.Sqrt(Extended(AArgs[0]));
end;

function System_Tangent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Tangent(const X: Extended): Extended;

  Result := System.Tangent(Extended(AArgs[0]));
end;

function System_SineCosine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Extended;
  v_2: Extended;
begin
  // procedure SineCosine(const X: Extended; var Sin: Extended...

  v_1 := Extended(AArgs[1]);
  v_2 := Extended(AArgs[2]);
  System.SineCosine(Extended(AArgs[0]), v_1, v_2);
  AssignRefParam(AArgs[1], v_1);
  AssignRefParam(AArgs[2], v_2);
end;

function System_ExpMinus1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExpMinus1(const X: Extended): Extended;

  Result := System.ExpMinus1(Extended(AArgs[0]));
end;

function System_LnXPlus1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function LnXPlus1(const X: Extended): Extended;

  Result := System.LnXPlus1(Extended(AArgs[0]));
end;

function System__ROUND_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _ROUND;

  System._ROUND();
end;

function System__TRUNC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _TRUNC;

  System._TRUNC();
end;

function System__MulDivInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _MulDivInt64(AValue: Int64; AMul: Int64; ADiv: I...

  Result := Int64_sw.ToVar(System._MulDivInt64(Int64_sw.FromVar(AArgs[0]), 
    Int64_sw.FromVar(AArgs[1]), Int64_sw.FromVar(AArgs[2])));
end;

function System__AbstractError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _AbstractError;

  System._AbstractError();
end;

function System__Assert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _Assert(const Message: string; const Filename: ...

  System._Assert(string(AArgs[0]), string(AArgs[1]), Integer(AArgs[2]));
end;

function System__Append_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _Append(var t: TTextRec): Integer;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := System._Append(v_1);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__Close_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _Close(var t: TTextRec): Integer;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := System._Close(v_1);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__EofFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TFileRec;
begin
  // function _EofFile(var f: TFileRec): Boolean;

  v_1 := TFileRec_sw.FromVar(AArgs[0]);
  Result := System._EofFile(v_1);
  AssignRefParam(AArgs[0], TFileRec_sw.ToVar(v_1));
end;

function System__EofText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _EofText(var t: TTextRec): Boolean;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := System._EofText(v_1);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__Eoln_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _Eoln(var t: TTextRec): Boolean;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := System._Eoln(v_1);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__Erase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TFileRec;
begin
  // procedure _Erase(var f: TFileRec);

  v_1 := TFileRec_sw.FromVar(AArgs[0]);
  System._Erase(v_1);
  AssignRefParam(AArgs[0], TFileRec_sw.ToVar(v_1));
end;

function System__FilePos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TFileRec;
begin
  // function _FilePos(var f: TFileRec): Longint;

  v_1 := TFileRec_sw.FromVar(AArgs[0]);
  Result := System._FilePos(v_1);
  AssignRefParam(AArgs[0], TFileRec_sw.ToVar(v_1));
end;

function System__FileSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TFileRec;
begin
  // function _FileSize(var f: TFileRec): Longint;

  v_1 := TFileRec_sw.FromVar(AArgs[0]);
  Result := System._FileSize(v_1);
  AssignRefParam(AArgs[0], TFileRec_sw.ToVar(v_1));
end;

function System__Flush_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _Flush(var t: TTextRec): Integer;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := System._Flush(v_1);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__Halt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _Halt(Code: Integer);

  System._Halt(Integer(AArgs[0]));
end;

function System__Halt0_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _Halt0;

  System._Halt0();
end;

function System_Mark_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure Mark;

  System.Mark();
end;

function System__ReadChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _ReadChar(var t: TTextRec): _AnsiChr;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := _AnsiChr_sw.ToVar(System._ReadChar(v_1));
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__ReadLong_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _ReadLong(var t: TTextRec): Longint;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := System._ReadLong(v_1);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__ReadLString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
  v_2: _AnsiStr;
begin
  // procedure _ReadLString(var t: TTextRec; var s: _AnsiStr; ...

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  v_2 := _AnsiStr_sw.FromVar(AArgs[1]);
  System._ReadLString(v_1, v_2, Word(AArgs[2]));
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
  AssignRefParam(AArgs[1], _AnsiStr_sw.ToVar(v_2));
end;

function System__ReadUString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
  v_2: UnicodeString;
begin
  // procedure _ReadUString(var t: TTextRec; var s: UnicodeStr...

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  v_2 := UnicodeString(AArgs[1]);
  System._ReadUString(v_1, v_2);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
  AssignRefParam(AArgs[1], v_2);
end;

function System__ReadWString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
  v_2: _WideStr;
begin
  // procedure _ReadWString(var t: TTextRec; var s: _WideStr);

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  v_2 := _WideStr_sw.FromVar(AArgs[1]);
  System._ReadWString(v_1, v_2);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
  AssignRefParam(AArgs[1], _WideStr_sw.ToVar(v_2));
end;

function System__ReadWChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _ReadWChar(var t: TTextRec): WideChar;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := Ord(System._ReadWChar(v_1));
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__ReadExt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _ReadExt(var t: TTextRec): Extended;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := System._ReadExt(v_1);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__ReadLn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // procedure _ReadLn(var t: TTextRec);

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  System._ReadLn(v_1);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System_Release_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Release;

  System.Release();
end;

function System__ResetText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _ResetText(var t: TTextRec): Integer;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := System._ResetText(v_1);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__ResetFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TFileRec;
begin
  // function _ResetFile(var f: TFileRec; recSize: Longint): I...

  v_1 := TFileRec_sw.FromVar(AArgs[0]);
  Result := System._ResetFile(v_1, Longint(AArgs[1]));
  AssignRefParam(AArgs[0], TFileRec_sw.ToVar(v_1));
end;

function System__RewritText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _RewritText(var t: TTextRec): Integer;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := System._RewritText(v_1);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__RewritFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TFileRec;
begin
  // function _RewritFile(var f: TFileRec; recSize: Longint): ...

  v_1 := TFileRec_sw.FromVar(AArgs[0]);
  Result := System._RewritFile(v_1, Longint(AArgs[1]));
  AssignRefParam(AArgs[0], TFileRec_sw.ToVar(v_1));
end;

function System__RunError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _RunError(errorCode: Byte);

  System._RunError(Byte(AArgs[0]));
end;

function System__Run0Error_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _Run0Error;

  System._Run0Error();
end;

function System__Seek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TFileRec;
begin
  // procedure _Seek(var f: TFileRec; recNum: Cardinal);

  v_1 := TFileRec_sw.FromVar(AArgs[0]);
  System._Seek(v_1, Cardinal(AArgs[1]));
  AssignRefParam(AArgs[0], TFileRec_sw.ToVar(v_1));
end;

function System__SeekEof_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _SeekEof(var t: TTextRec): Boolean;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := System._SeekEof(v_1);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__SeekEoln_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _SeekEoln(var t: TTextRec): Boolean;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := System._SeekEoln(v_1);
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__StrLong_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _StrLong(val: Longint; width: Longint): _ShortStr;

  Result := _ShortStr_sw.ToVar(System._StrLong(Longint(AArgs[0]), Longint(
    AArgs[1])));
end;

function System__Str0Long_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _Str0Long(val: Longint): _ShortStr;

  Result := _ShortStr_sw.ToVar(System._Str0Long(Longint(AArgs[0])));
end;

function System__Truncate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TFileRec;
begin
  // procedure _Truncate(var f: TFileRec);

  v_1 := TFileRec_sw.FromVar(AArgs[0]);
  System._Truncate(v_1);
  AssignRefParam(AArgs[0], TFileRec_sw.ToVar(v_1));
end;

function System__ValLong_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // function _ValLong(const S: string; var Code: Integer): Lo...

  v_1 := Integer(AArgs[1]);
  Result := System._ValLong(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function System__Write2Ext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _Write2Ext;

  System._Write2Ext();
end;

function System__Write1Ext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _Write1Ext;

  System._Write1Ext();
end;

function System__Write0Ext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _Write0Ext;

  System._Write0Ext();
end;

function System__SetElem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _SetElem;

  System._SetElem();
end;

function System__SetRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _SetRange;

  System._SetRange();
end;

function System__SetEq_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _SetEq;

  System._SetEq();
end;

function System__SetLe_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _SetLe;

  System._SetLe();
end;

function System__SetIntersect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _SetIntersect;

  System._SetIntersect();
end;

function System__SetIntersect3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _SetIntersect3;

  System._SetIntersect3();
end;

function System__SetUnion_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _SetUnion;

  System._SetUnion();
end;

function System__SetUnion3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _SetUnion3;

  System._SetUnion3();
end;

function System__SetSub_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _SetSub;

  System._SetSub();
end;

function System__SetSub3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _SetSub3;

  System._SetSub3();
end;

function System__SetExpand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _SetExpand;

  System._SetExpand();
end;

function System__Str2Ext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _Str2Ext(val: Extended; width: LongInt; precisio...

  Result := _ShortStr_sw.ToVar(System._Str2Ext(Extended(AArgs[0]), LongInt(
    AArgs[1]), LongInt(AArgs[2])));
end;

function System__Str1Ext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _Str1Ext(val: Extended; width: LongInt): _ShortStr;

  Result := _ShortStr_sw.ToVar(System._Str1Ext(Extended(AArgs[0]), LongInt(
    AArgs[1])));
end;

function System__Str0Ext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _Str0Ext(val: Extended): _ShortStr;

  Result := _ShortStr_sw.ToVar(System._Str0Ext(Extended(AArgs[0])));
end;

function System__ValExt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _ValExt;

  System._ValExt();
end;

function System__Pow10_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _Pow10;

  System._Pow10();
end;

function System__Real2Ext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _Real2Ext;

  System._Real2Ext();
end;

function System__Ext2Real_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _Ext2Real;

  System._Ext2Real();
end;

function System__ObjSetup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _ObjSetup;

  System._ObjSetup();
end;

function System__ObjCopy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _ObjCopy;

  System._ObjCopy();
end;

function System__BoundErr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _BoundErr;

  System._BoundErr();
end;

function System__IntOver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _IntOver;

  System._IntOver();
end;

function System__IntDivByZero_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _IntDivByZero;

  System._IntDivByZero();
end;

function System__AtomicIncInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Int64;
begin
  // function _AtomicIncInt64(var Target: Int64; Increment: In...

  v_1 := Int64_sw.FromVar(AArgs[0]);
  Result := Int64_sw.ToVar(System._AtomicIncInt64(v_1, Int64_sw.FromVar(
    AArgs[1])));
  AssignRefParam(AArgs[0], Int64_sw.ToVar(v_1));
end;

function System__AtomicXchgInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Int64;
begin
  // function _AtomicXchgInt64(var Target: Int64; Exchange: In...

  v_1 := Int64_sw.FromVar(AArgs[0]);
  Result := Int64_sw.ToVar(System._AtomicXchgInt64(v_1, Int64_sw.FromVar(
    AArgs[1])));
  AssignRefParam(AArgs[0], Int64_sw.ToVar(v_1));
end;

function System_TInitContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInitContext = record;

  Result := TLMDUnitWrapper.TypeToVar(TInitContext_sw);
end;

function System__StartLib_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _StartLib;

  System._StartLib();
end;

function System_TExceptionRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExceptionRecord = record;

  Result := TLMDUnitWrapper.TypeToVar(TExceptionRecord_sw);
end;

function System__BeforeDestruction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _BeforeDestruction(const Instance: TObject; Oute...

  Result := TObject_sw.ToVar(System._BeforeDestruction(TObject_sw.FromVar(
    AArgs[0]), ShortInt(AArgs[1])));
end;

function System__ClassDestroy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _ClassDestroy(const Instance: TObject);

  System._ClassDestroy(TObject_sw.FromVar(AArgs[0]));
end;

function System__AfterConstruction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _AfterConstruction(const Instance: TObject): TOb...

  Result := TObject_sw.ToVar(System._AfterConstruction(TObject_sw.FromVar(
    AArgs[0])));
end;

function System__IsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _IsClass(const Child: TObject; Parent: TClass): ...

  Result := System._IsClass(TObject_sw.FromVar(AArgs[0]), TClass_sw.FromVar(
    AArgs[1]));
end;

function System__AsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _AsClass(const Child: TObject; Parent: TClass): ...

  Result := TObject_sw.ToVar(System._AsClass(TObject_sw.FromVar(AArgs[0]), 
    TClass_sw.FromVar(AArgs[1])));
end;

function System__RaiseExcept_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _RaiseExcept;

  System._RaiseExcept();
end;

function System__RaiseAgain_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _RaiseAgain;

  System._RaiseAgain();
end;

function System__DoneExcept_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _DoneExcept;

  System._DoneExcept();
end;

function System__TryFinallyExit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _TryFinallyExit;

  System._TryFinallyExit();
end;

function System__HandleAnyException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _HandleAnyException;

  System._HandleAnyException();
end;

function System__HandleAutoException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _HandleAutoException;

  System._HandleAutoException();
end;

function System__HandleOnException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _HandleOnException;

  System._HandleOnException();
end;

function System__HandleFinally_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _HandleFinally;

  System._HandleFinally();
end;

function System__UnhandledException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _UnhandledException;

  System._UnhandledException();
end;

function System__CallDynaInst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _CallDynaInst;

  System._CallDynaInst();
end;

function System__CallDynaClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _CallDynaClass;

  System._CallDynaClass();
end;

function System__UStrAsg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UStrAsg(var Dest: UnicodeString; const Source:...

  v_1 := UnicodeString(AArgs[0]);
  System._UStrAsg(v_1, UnicodeString(AArgs[1]));
  AssignRefParam(AArgs[0], v_1);
end;

function System__UStrLAsg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UStrLAsg(var Dest: UnicodeString; const Source...

  v_1 := UnicodeString(AArgs[0]);
  System._UStrLAsg(v_1, UnicodeString(AArgs[1]));
  AssignRefParam(AArgs[0], v_1);
end;

function System__WStrAsg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WStrAsg(var Dest: _WideStr; const Source: _Wid...

  v_1 := _WideStr_sw.FromVar(AArgs[0]);
  System._WStrAsg(v_1, _WideStr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], _WideStr_sw.ToVar(v_1));
end;

function System__WStrLAsg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WStrLAsg(var Dest: _WideStr; const Source: _Wi...

  v_1 := _WideStr_sw.FromVar(AArgs[0]);
  System._WStrLAsg(v_1, _WideStr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], _WideStr_sw.ToVar(v_1));
end;

function System__LStrAsg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LStrAsg(var Dest: _AnsiStr; const Source: _Ans...

  v_1 := _AnsiStr_sw.FromVar(AArgs[0]);
  System._LStrAsg(v_1, _AnsiStr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], _AnsiStr_sw.ToVar(v_1));
end;

function System__LStrLAsg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LStrLAsg(var Dest: _AnsiStr; const Source: _An...

  v_1 := _AnsiStr_sw.FromVar(AArgs[0]);
  System._LStrLAsg(v_1, _AnsiStr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], _AnsiStr_sw.ToVar(v_1));
end;

function System_StringElementSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StringElementSize(...); overload;

  Result := System.StringElementSize(UnicodeString(AArgs[0]));
end;

function System_StringCodePage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StringCodePage(...); overload;

  Result := System.StringCodePage(UnicodeString(AArgs[0]));
end;

function System_StringRefCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StringRefCount(...); overload;

  Result := System.StringRefCount(UnicodeString(AArgs[0]));
end;

function System__UStrLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _UStrLen(const S: UnicodeString): Integer;

  Result := System._UStrLen(UnicodeString(AArgs[0]));
end;

function System__WStrLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _WStrLen(const S: _WideStr): Longint;

  Result := System._WStrLen(_WideStr_sw.FromVar(AArgs[0]));
end;

function System__LStrLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _LStrLen(const S: _AnsiStr): Longint;

  Result := System._LStrLen(_AnsiStr_sw.FromVar(AArgs[0]));
end;

function System_UniqueString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure/function UniqueString(...); overload;

  v_1 := _WideStr_sw.FromVar(AArgs[0]);
  System.UniqueString(v_1);
  AssignRefParam(AArgs[0], _WideStr_sw.ToVar(v_1));
end;

function System__PStrCmp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _PStrCmp;

  System._PStrCmp();
end;

function System__AStrCmp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _AStrCmp;

  System._AStrCmp();
end;

function System__WStrLCmp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _WStrLCmp;

  System._WStrLCmp();
end;

function System__Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _Copy(const S: _ShortStr; Index: Integer; Count:...

  Result := _ShortStr_sw.ToVar(System._Copy(_ShortStr_sw.FromVar(AArgs[0]), 
    Integer(AArgs[1]), Integer(AArgs[2])));
end;

function System__LStrFromChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LStrFromChar(var Dest: _AnsiStr; Source: _Ansi...

  v_1 := _AnsiStr_sw.FromVar(AArgs[0]);
  System._LStrFromChar(v_1, _AnsiChr_sw.FromVar(AArgs[1]), Word(AArgs[2]));
  AssignRefParam(AArgs[0], _AnsiStr_sw.ToVar(v_1));
end;

function System__LStrFromWChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LStrFromWChar(var Dest: _AnsiStr; Source: Wide...

  v_1 := _AnsiStr_sw.FromVar(AArgs[0]);
  System._LStrFromWChar(v_1, WideChar(Integer(AArgs[1])), Word(AArgs[2]));
  AssignRefParam(AArgs[0], _AnsiStr_sw.ToVar(v_1));
end;

function System__LStrFromUStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LStrFromUStr(var Dest: _AnsiStr; const Source:...

  v_1 := _AnsiStr_sw.FromVar(AArgs[0]);
  System._LStrFromUStr(v_1, UnicodeString(AArgs[1]), Word(AArgs[2]));
  AssignRefParam(AArgs[0], _AnsiStr_sw.ToVar(v_1));
end;

function System__LStrFromWStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LStrFromWStr(var Dest: _AnsiStr; const Source:...

  v_1 := _AnsiStr_sw.FromVar(AArgs[0]);
  System._LStrFromWStr(v_1, _WideStr_sw.FromVar(AArgs[1]), Word(AArgs[2]));
  AssignRefParam(AArgs[0], _AnsiStr_sw.ToVar(v_1));
end;

function System__LStrFromString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LStrFromString(var Dest: _AnsiStr; const Sourc...

  v_1 := _AnsiStr_sw.FromVar(AArgs[0]);
  System._LStrFromString(v_1, _ShortStr_sw.FromVar(AArgs[1]), Word(AArgs[2]));
  AssignRefParam(AArgs[0], _AnsiStr_sw.ToVar(v_1));
end;

function System__LStrCat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LStrCat(var Dest: _AnsiStr; const Source: _Ans...

  v_1 := _AnsiStr_sw.FromVar(AArgs[0]);
  System._LStrCat(v_1, _AnsiStr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], _AnsiStr_sw.ToVar(v_1));
end;

function System__LStrCat3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LStrCat3(var Dest: _AnsiStr; const Source1: _A...

  v_1 := _AnsiStr_sw.FromVar(AArgs[0]);
  System._LStrCat3(v_1, _AnsiStr_sw.FromVar(AArgs[1]), _AnsiStr_sw.FromVar(
    AArgs[2]));
  AssignRefParam(AArgs[0], _AnsiStr_sw.ToVar(v_1));
end;

function System__LStrCatN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _LStrCatN;

  System._LStrCatN();
end;

function System__LStrCmp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _LStrCmp;

  System._LStrCmp();
end;

function System__LStrEqual_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _LStrEqual;

  System._LStrEqual();
end;

function System__LStrCopy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _LStrCopy(const S: _AnsiStr; Index: Integer; Cou...

  Result := _AnsiStr_sw.ToVar(System._LStrCopy(_AnsiStr_sw.FromVar(AArgs[0]), 
    Integer(AArgs[1]), Integer(AArgs[2])));
end;

function System__LStrDelete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LStrDelete(var S: _AnsiStr; Index: Integer; Co...

  v_1 := _AnsiStr_sw.FromVar(AArgs[0]);
  System._LStrDelete(v_1, Integer(AArgs[1]), Integer(AArgs[2]));
  AssignRefParam(AArgs[0], _AnsiStr_sw.ToVar(v_1));
end;

function System__LStrInsert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LStrInsert(const Source: _AnsiStr; var S: _Ans...

  v_1 := _AnsiStr_sw.FromVar(AArgs[1]);
  System._LStrInsert(_AnsiStr_sw.FromVar(AArgs[0]), v_1, Integer(AArgs[2]));
  AssignRefParam(AArgs[1], _AnsiStr_sw.ToVar(v_1));
end;

function System__LStrSetLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _AnsiStr;
begin
  // procedure _LStrSetLength(var Str: _AnsiStr; NewLength: In...

  v_1 := _AnsiStr_sw.FromVar(AArgs[0]);
  System._LStrSetLength(v_1, Integer(AArgs[1]), Word(AArgs[2]));
  AssignRefParam(AArgs[0], _AnsiStr_sw.ToVar(v_1));
end;

function System__WStrFromChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WStrFromChar(var Dest: _WideStr; Source: _Ansi...

  v_1 := _WideStr_sw.FromVar(AArgs[0]);
  System._WStrFromChar(v_1, _AnsiChr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], _WideStr_sw.ToVar(v_1));
end;

function System__WStrFromWChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WStrFromWChar(var Dest: _WideStr; Source: Wide...

  v_1 := _WideStr_sw.FromVar(AArgs[0]);
  System._WStrFromWChar(v_1, WideChar(Integer(AArgs[1])));
  AssignRefParam(AArgs[0], _WideStr_sw.ToVar(v_1));
end;

function System__WStrFromLStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WStrFromLStr(var Dest: _WideStr; const Source:...

  v_1 := _WideStr_sw.FromVar(AArgs[0]);
  System._WStrFromLStr(v_1, _AnsiStr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], _WideStr_sw.ToVar(v_1));
end;

function System__WStrFromUStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WStrFromUStr(var Dest: _WideStr; const Source:...

  v_1 := _WideStr_sw.FromVar(AArgs[0]);
  System._WStrFromUStr(v_1, UnicodeString(AArgs[1]));
  AssignRefParam(AArgs[0], _WideStr_sw.ToVar(v_1));
end;

function System__WStrFromString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WStrFromString(var Dest: _WideStr; const Sourc...

  v_1 := _WideStr_sw.FromVar(AArgs[0]);
  System._WStrFromString(v_1, _ShortStr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], _WideStr_sw.ToVar(v_1));
end;

function System__WStrCat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WStrCat(var Dest: _WideStr; const Source: _Wid...

  v_1 := _WideStr_sw.FromVar(AArgs[0]);
  System._WStrCat(v_1, _WideStr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], _WideStr_sw.ToVar(v_1));
end;

function System__WStrCat3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WStrCat3(var Dest: _WideStr; const Source1: _W...

  v_1 := _WideStr_sw.FromVar(AArgs[0]);
  System._WStrCat3(v_1, _WideStr_sw.FromVar(AArgs[1]), _WideStr_sw.FromVar(
    AArgs[2]));
  AssignRefParam(AArgs[0], _WideStr_sw.ToVar(v_1));
end;

function System__WStrCatN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _WStrCatN;

  System._WStrCatN();
end;

function System__WStrCmp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _WStrCmp;

  System._WStrCmp();
end;

function System__WStrEqual_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _WStrEqual;

  System._WStrEqual();
end;

function System__WStrCopy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _WStrCopy(const S: _WideStr; Index: Integer; Cou...

  Result := _WideStr_sw.ToVar(System._WStrCopy(_WideStr_sw.FromVar(AArgs[0]), 
    Integer(AArgs[1]), Integer(AArgs[2])));
end;

function System__WStrDelete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WStrDelete(var S: _WideStr; Index: Integer; Co...

  v_1 := _WideStr_sw.FromVar(AArgs[0]);
  System._WStrDelete(v_1, Integer(AArgs[1]), Integer(AArgs[2]));
  AssignRefParam(AArgs[0], _WideStr_sw.ToVar(v_1));
end;

function System__WStrInsert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WStrInsert(const Source: _WideStr; var Dest: _...

  v_1 := _WideStr_sw.FromVar(AArgs[1]);
  System._WStrInsert(_WideStr_sw.FromVar(AArgs[0]), v_1, Integer(AArgs[2]));
  AssignRefParam(AArgs[1], _WideStr_sw.ToVar(v_1));
end;

function System__WStrSetLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _WideStr;
begin
  // procedure _WStrSetLength(var S: _WideStr; NewLength: Inte...

  v_1 := _WideStr_sw.FromVar(AArgs[0]);
  System._WStrSetLength(v_1, Integer(AArgs[1]));
  AssignRefParam(AArgs[0], _WideStr_sw.ToVar(v_1));
end;

function System__UStrFromChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UStrFromChar(var Dest: UnicodeString; Source: ...

  v_1 := UnicodeString(AArgs[0]);
  System._UStrFromChar(v_1, _AnsiChr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], v_1);
end;

function System__UStrFromWChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UStrFromWChar(var Dest: UnicodeString; Source:...

  v_1 := UnicodeString(AArgs[0]);
  System._UStrFromWChar(v_1, WideChar(Integer(AArgs[1])));
  AssignRefParam(AArgs[0], v_1);
end;

function System__UStrFromLStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UStrFromLStr(var Dest: UnicodeString; const So...

  v_1 := UnicodeString(AArgs[0]);
  System._UStrFromLStr(v_1, _AnsiStr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], v_1);
end;

function System__UStrFromWStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UStrFromWStr(var Dest: UnicodeString; const So...

  v_1 := UnicodeString(AArgs[0]);
  System._UStrFromWStr(v_1, _WideStr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], v_1);
end;

function System__UStrFromString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UStrFromString(var Dest: UnicodeString; const ...

  v_1 := UnicodeString(AArgs[0]);
  System._UStrFromString(v_1, _ShortStr_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], v_1);
end;

function System__UStrCat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UStrCat(var Dest: UnicodeString; const Source:...

  v_1 := UnicodeString(AArgs[0]);
  System._UStrCat(v_1, UnicodeString(AArgs[1]));
  AssignRefParam(AArgs[0], v_1);
end;

function System__UStrCat3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UStrCat3(var Dest: UnicodeString; const Source...

  v_1 := UnicodeString(AArgs[0]);
  System._UStrCat3(v_1, UnicodeString(AArgs[1]), UnicodeString(AArgs[2]));
  AssignRefParam(AArgs[0], v_1);
end;

function System__UStrCatN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _UStrCatN;

  System._UStrCatN();
end;

function System__UStrCmp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _UStrCmp;

  System._UStrCmp();
end;

function System__UStrEqual_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _UStrEqual;

  System._UStrEqual();
end;

function System__UStrCopy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _UStrCopy(const S: UnicodeString; Index: Integer...

  Result := System._UStrCopy(UnicodeString(AArgs[0]), Integer(AArgs[1]), 
    Integer(AArgs[2]));
end;

function System__UStrDelete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UStrDelete(var S: UnicodeString; Index: Intege...

  v_1 := UnicodeString(AArgs[0]);
  System._UStrDelete(v_1, Integer(AArgs[1]), Integer(AArgs[2]));
  AssignRefParam(AArgs[0], v_1);
end;

function System__UStrInsert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UStrInsert(const Source: UnicodeString; var De...

  v_1 := UnicodeString(AArgs[1]);
  System._UStrInsert(UnicodeString(AArgs[0]), v_1, Integer(AArgs[2]));
  AssignRefParam(AArgs[1], v_1);
end;

function System__UStrSetLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: UnicodeString;
begin
  // procedure _UStrSetLength(var Str: UnicodeString; NewLengt...

  v_1 := UnicodeString(AArgs[0]);
  System._UStrSetLength(v_1, Integer(AArgs[1]));
  AssignRefParam(AArgs[0], v_1);
end;

function System_Pos_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure/function Pos(...); overload;

  case AArgsSize of
    2:
    begin
      Result := System.Pos(_WideStr_sw.FromVar(AArgs[0]), _WideStr_sw.FromVar(
        AArgs[1]));
    end;
    3:
    begin
      Result := System.Pos(_WideStr_sw.FromVar(AArgs[0]), _WideStr_sw.FromVar(
        AArgs[1]), Integer(AArgs[2]));
    end;
  else
    WrongArgCountError('Pos');
  end;
end;

function System_StringOfChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function StringOfChar(...); overload;

  Result := System.StringOfChar(WideChar(Integer(AArgs[0])), Integer(AArgs[1]));
end;

function System_SetCodePage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: _RawByteStr;
begin
  // procedure SetCodePage(var S: _RawByteStr; CodePage: Word;...

  case AArgsSize of
    2:
    begin
      v_1 := _RawByteStr_sw.FromVar(AArgs[0]);
      System.SetCodePage(v_1, Word(AArgs[1]));
      AssignRefParam(AArgs[0], _RawByteStr_sw.ToVar(v_1));
    end;
    3:
    begin
      v_1 := _RawByteStr_sw.FromVar(AArgs[0]);
      System.SetCodePage(v_1, Word(AArgs[1]), Boolean(AArgs[2]));
      AssignRefParam(AArgs[0], _RawByteStr_sw.ToVar(v_1));
    end;
  else
    WrongArgCountError('SetCodePage');
  end;
end;

function System__CopyRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _CopyRecord;

  System._CopyRecord();
end;

function System__CopyObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _CopyObject;

  System._CopyObject();
end;

function System__CopyArray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _CopyArray;

  System._CopyArray();
end;

function System___llmul_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure __llmul;

  System.__llmul();
end;

function System___lldiv_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure __lldiv;

  System.__lldiv();
end;

function System___lludiv_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure __lludiv;

  System.__lludiv();
end;

function System___llmod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure __llmod;

  System.__llmod();
end;

function System___llmulo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure __llmulo;

  System.__llmulo();
end;

function System___lldivo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure __lldivo;

  System.__lldivo();
end;

function System___llmodo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure __llmodo;

  System.__llmodo();
end;

function System___llumod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure __llumod;

  System.__llumod();
end;

function System___llshl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure __llshl;

  System.__llshl();
end;

function System___llushr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure __llushr;

  System.__llushr();
end;

function System__ReadInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _ReadInt64(var t: TTextRec): Int64;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := Int64_sw.ToVar(System._ReadInt64(v_1));
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__ReadUInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TTextRec;
begin
  // function _ReadUInt64(var t: TTextRec): UInt64;

  v_1 := TTextRec_sw.FromVar(AArgs[0]);
  Result := UInt64_sw.ToVar(System._ReadUInt64(v_1));
  AssignRefParam(AArgs[0], TTextRec_sw.ToVar(v_1));
end;

function System__StrInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _StrInt64(val: Int64; width: Integer): _ShortStr;

  Result := _ShortStr_sw.ToVar(System._StrInt64(Int64_sw.FromVar(AArgs[0]), 
    Integer(AArgs[1])));
end;

function System__Str0Int64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _Str0Int64(val: Int64): _ShortStr;

  Result := _ShortStr_sw.ToVar(System._Str0Int64(Int64_sw.FromVar(AArgs[0])));
end;

function System__ValInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // function _ValInt64(const S: string; var Code: Integer): I...

  v_1 := Integer(AArgs[1]);
  Result := Int64_sw.ToVar(System._ValInt64(string(AArgs[0]), v_1));
  AssignRefParam(AArgs[1], v_1);
end;

function System__ValUInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // function _ValUInt64(const s: string; var code: Integer): ...

  v_1 := Integer(AArgs[1]);
  Result := UInt64_sw.ToVar(System._ValUInt64(string(AArgs[0]), v_1));
  AssignRefParam(AArgs[1], v_1);
end;

function System__StrUInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _StrUInt64(val: UInt64; width: Integer): _ShortStr;

  Result := _ShortStr_sw.ToVar(System._StrUInt64(UInt64_sw.FromVar(AArgs[0]), 
    Integer(AArgs[1])));
end;

function System__Str0UInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _Str0UInt64(val: Int64): _ShortStr;

  Result := _ShortStr_sw.ToVar(System._Str0UInt64(Int64_sw.FromVar(AArgs[0])));
end;

function System__DynArraySetLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _DynArraySetLength;

  System._DynArraySetLength();
end;

function System__FSafeDivide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _FSafeDivide;

  System._FSafeDivide();
end;

function System__FSafeDivideR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure _FSafeDivideR;

  System._FSafeDivideR();
end;

function System__CheckAutoResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function _CheckAutoResult(ResultCode: HResult): HResult;

  Result := HResult_sw.ToVar(System._CheckAutoResult(HResult_sw.FromVar(
    AArgs[0])));
end;

function System_FPower10_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FPower10;

  System.FPower10();
end;

function System_Power10_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Power10(val: Extended; power: Integer): Extended;

  Result := System.Power10(Extended(AArgs[0]), Integer(AArgs[1]));
end;

function System_TextStart_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure TextStart;

  System.TextStart();
end;

function System_CompToDouble_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CompToDouble(Value: Comp): Double;

  Result := System.CompToDouble(Comp(AArgs[0]));
end;

function System_DoubleToComp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Comp;
begin
  // procedure DoubleToComp(Value: Double; var Result: Comp);

  v_1 := Comp(AArgs[1]);
  System.DoubleToComp(Double(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function System_CompToCurrency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CompToCurrency(Value: Comp): Currency;

  Result := System.CompToCurrency(Comp(AArgs[0]));
end;

function System_CurrencyToComp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Comp;
begin
  // procedure CurrencyToComp(Value: Currency; var Result: Comp);

  v_1 := Comp(AArgs[1]);
  System.CurrencyToComp(Currency(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function System_TRuntimeError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRuntimeError = (reNone, reOutOfMemory, reInvalidPtr...

  Result := TLMDUnitWrapper.TypeToVar(TRuntimeError_sw);
end;

function System_Error_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Error(errorCode: TRuntimeError);

  System.Error(TRuntimeError_sw.FromVar(AArgs[0]));
end;

function System_GetLastError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetLastError: Integer;

  Result := System.GetLastError();
end;

function System_SetLastError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetLastError(ErrorCode: Integer);

  System.SetLastError(Integer(AArgs[0]));
end;

function System_SetMultiByteConversionCodePage_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetMultiByteConversionCodePage(CodePage: Integer);

  System.SetMultiByteConversionCodePage(Integer(AArgs[0]));
end;

function System_GetUILanguages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetUILanguages(const LANGID: WORD): string;

  Result := System.GetUILanguages(WORD(AArgs[0]));
end;

function System_GetLocaleOverride_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetLocaleOverride(const AppName: string): string;

  Result := System.GetLocaleOverride(string(AArgs[0]));
end;

function System_SetLocaleOverride_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetLocaleOverride(const NewPreferredLanguages: ...

  System.SetLocaleOverride(string(AArgs[0]));
end;

class function System_sw.GetUnitName: WideString;
begin
  Result := 'System';
end;

class procedure System_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('RTLVersion', System_RTLVersion_si, nil, VarType(System.RTLVersion));
  AData.AddType(CppLongInt_sw, System_CppLongInt_si);
  AData.AddType(CppULongInt_sw, System_CppULongInt_si);
  AData.AddType(Int8_sw, System_Int8_si);
  AData.AddType(Int16_sw, System_Int16_si);
  AData.AddType(Int32_sw, System_Int32_si);
  AData.AddType(IntPtr_sw, System_IntPtr_si);
  AData.AddType(UInt8_sw, System_UInt8_si);
  AData.AddType(UInt16_sw, System_UInt16_si);
  AData.AddType(UInt32_sw, System_UInt32_si);
  AData.AddType(UIntPtr_sw, System_UIntPtr_si);
  AData.AddType(_ShortStr_sw, System__ShortStr_si);
  AData.AddType(_AnsiStr_sw, System__AnsiStr_si);
  AData.AddType(_AnsiChr_sw, System__AnsiChr_si);
  AData.AddType(_WideStr_sw, System__WideStr_si);
  AData.AddConstant('varEmpty', System_varEmpty_si, nil, VarType(System.varEmpty));
  AData.AddConstant('varNull', System_varNull_si, nil, VarType(System.varNull));
  AData.AddConstant('varSmallint', System_varSmallint_si, nil, VarType(System.varSmallint));
  AData.AddConstant('varInteger', System_varInteger_si, nil, VarType(System.varInteger));
  AData.AddConstant('varSingle', System_varSingle_si, nil, VarType(System.varSingle));
  AData.AddConstant('varDouble', System_varDouble_si, nil, VarType(System.varDouble));
  AData.AddConstant('varCurrency', System_varCurrency_si, nil, VarType(System.varCurrency));
  AData.AddConstant('varDate', System_varDate_si, nil, VarType(System.varDate));
  AData.AddConstant('varOleStr', System_varOleStr_si, nil, VarType(System.varOleStr));
  AData.AddConstant('varDispatch', System_varDispatch_si, nil, VarType(System.varDispatch));
  AData.AddConstant('varError', System_varError_si, nil, VarType(System.varError));
  AData.AddConstant('varBoolean', System_varBoolean_si, nil, VarType(System.varBoolean));
  AData.AddConstant('varVariant', System_varVariant_si, nil, VarType(System.varVariant));
  AData.AddConstant('varUnknown', System_varUnknown_si, nil, VarType(System.varUnknown));
  AData.AddConstant('varShortInt', System_varShortInt_si, nil, VarType(System.varShortInt));
  AData.AddConstant('varByte', System_varByte_si, nil, VarType(System.varByte));
  AData.AddConstant('varWord', System_varWord_si, nil, VarType(System.varWord));
  AData.AddConstant('varLongWord', System_varLongWord_si, nil, VarType(System.varLongWord));
  AData.AddConstant('varInt64', System_varInt64_si, nil, VarType(System.varInt64));
  AData.AddConstant('varUInt64', System_varUInt64_si, nil, VarType(System.varUInt64));
  AData.AddConstant('varRecord', System_varRecord_si, nil, VarType(System.varRecord));
  AData.AddConstant('varStrArg', System_varStrArg_si, nil, VarType(System.varStrArg));
  AData.AddConstant('varObject', System_varObject_si, nil, VarType(System.varObject));
  AData.AddConstant('varUStrArg', System_varUStrArg_si, nil, VarType(System.varUStrArg));
  AData.AddConstant('varString', System_varString_si, nil, VarType(System.varString));
  AData.AddConstant('varAny', System_varAny_si, nil, VarType(System.varAny));
  AData.AddConstant('varUString', System_varUString_si, nil, VarType(System.varUString));
  AData.AddConstant('varTypeMask', System_varTypeMask_si, nil, VarType(System.varTypeMask));
  AData.AddConstant('varArray', System_varArray_si, nil, VarType(System.varArray));
  AData.AddConstant('varByRef', System_varByRef_si, nil, VarType(System.varByRef));
  AData.AddConstant('vtInteger', System_vtInteger_si, nil, VarType(System.vtInteger));
  AData.AddConstant('vtBoolean', System_vtBoolean_si, nil, VarType(System.vtBoolean));
  AData.AddConstant('vtChar', System_vtChar_si, nil, VarType(System.vtChar));
  AData.AddConstant('vtExtended', System_vtExtended_si, nil, VarType(System.vtExtended));
  AData.AddConstant('vtString', System_vtString_si, nil, VarType(System.vtString));
  AData.AddConstant('vtPointer', System_vtPointer_si, nil, VarType(System.vtPointer));
  AData.AddConstant('vtPChar', System_vtPChar_si, nil, VarType(System.vtPChar));
  AData.AddConstant('vtObject', System_vtObject_si, nil, VarType(System.vtObject));
  AData.AddConstant('vtClass', System_vtClass_si, nil, VarType(System.vtClass));
  AData.AddConstant('vtWideChar', System_vtWideChar_si, nil, VarType(System.vtWideChar));
  AData.AddConstant('vtPWideChar', System_vtPWideChar_si, nil, VarType(System.vtPWideChar));
  AData.AddConstant('vtAnsiString', System_vtAnsiString_si, nil, VarType(System.vtAnsiString));
  AData.AddConstant('vtCurrency', System_vtCurrency_si, nil, VarType(System.vtCurrency));
  AData.AddConstant('vtVariant', System_vtVariant_si, nil, VarType(System.vtVariant));
  AData.AddConstant('vtInterface', System_vtInterface_si, nil, VarType(System.vtInterface));
  AData.AddConstant('vtWideString', System_vtWideString_si, nil, VarType(System.vtWideString));
  AData.AddConstant('vtInt64', System_vtInt64_si, nil, VarType(System.vtInt64));
  AData.AddConstant('vtUnicodeString', System_vtUnicodeString_si, nil, VarType(System.vtUnicodeString));
  AData.AddConstant('vmtArcOffset', System_vmtArcOffset_si, nil, VarType(System.vmtArcOffset));
  AData.AddConstant('CPP_ABI_ADJUST', System_CPP_ABI_ADJUST_si, nil, VarType(System.CPP_ABI_ADJUST));
  AData.AddConstant('vmtSelfPtr', System_vmtSelfPtr_si, nil, VarType(System.vmtSelfPtr));
  AData.AddConstant('vmtIntfTable', System_vmtIntfTable_si, nil, VarType(System.vmtIntfTable));
  AData.AddConstant('vmtAutoTable', System_vmtAutoTable_si, nil, VarType(System.vmtAutoTable));
  AData.AddConstant('vmtInitTable', System_vmtInitTable_si, nil, VarType(System.vmtInitTable));
  AData.AddConstant('vmtTypeInfo', System_vmtTypeInfo_si, nil, VarType(System.vmtTypeInfo));
  AData.AddConstant('vmtFieldTable', System_vmtFieldTable_si, nil, VarType(System.vmtFieldTable));
  AData.AddConstant('vmtMethodTable', System_vmtMethodTable_si, nil, VarType(System.vmtMethodTable));
  AData.AddConstant('vmtDynamicTable', System_vmtDynamicTable_si, nil, VarType(System.vmtDynamicTable));
  AData.AddConstant('vmtClassName', System_vmtClassName_si, nil, VarType(System.vmtClassName));
  AData.AddConstant('vmtInstanceSize', System_vmtInstanceSize_si, nil, VarType(System.vmtInstanceSize));
  AData.AddConstant('vmtParent', System_vmtParent_si, nil, VarType(System.vmtParent));
  AData.AddConstant('vmtEquals', System_vmtEquals_si, nil, VarType(System.vmtEquals));
  AData.AddConstant('vmtGetHashCode', System_vmtGetHashCode_si, nil, VarType(System.vmtGetHashCode));
  AData.AddConstant('vmtToString', System_vmtToString_si, nil, VarType(System.vmtToString));
  AData.AddConstant('vmtSafeCallException', System_vmtSafeCallException_si, nil, VarType(System.vmtSafeCallException));
  AData.AddConstant('vmtAfterConstruction', System_vmtAfterConstruction_si, nil, VarType(System.vmtAfterConstruction));
  AData.AddConstant('vmtBeforeDestruction', System_vmtBeforeDestruction_si, nil, VarType(System.vmtBeforeDestruction));
  AData.AddConstant('vmtDispatch', System_vmtDispatch_si, nil, VarType(System.vmtDispatch));
  AData.AddConstant('vmtDefaultHandler', System_vmtDefaultHandler_si, nil, VarType(System.vmtDefaultHandler));
  AData.AddConstant('vmtNewInstance', System_vmtNewInstance_si, nil, VarType(System.vmtNewInstance));
  AData.AddConstant('vmtFreeInstance', System_vmtFreeInstance_si, nil, VarType(System.vmtFreeInstance));
  AData.AddConstant('vmtDestroy', System_vmtDestroy_si, nil, VarType(System.vmtDestroy));
  AData.AddConstant('vmtQueryInterface', System_vmtQueryInterface_si, nil, VarType(System.vmtQueryInterface));
  AData.AddConstant('vmtAddRef', System_vmtAddRef_si, nil, VarType(System.vmtAddRef));
  AData.AddConstant('vmtRelease', System_vmtRelease_si, nil, VarType(System.vmtRelease));
  AData.AddConstant('vmtCreateObject', System_vmtCreateObject_si, nil, VarType(System.vmtCreateObject));
  AData.AddConstant('hfFieldSize', System_hfFieldSize_si, Cardinal_sw);
  AData.AddConstant('hfMonitorOffset', System_hfMonitorOffset_si, nil, VarType(System.hfMonitorOffset));
  AData.AddConstant('DefaultMethodRttiVisibility', System_DefaultMethodRttiVisibility_si, nil, varInteger);
  AData.AddConstant('DefaultFieldRttiVisibility', System_DefaultFieldRttiVisibility_si, nil, varInteger);
  AData.AddConstant('DefaultPropertyRttiVisibility', System_DefaultPropertyRttiVisibility_si, nil, varInteger);
  AData.AddType(TClass_sw, System_TClass_si);
  AData.AddType(HRESULT_sw, System_HRESULT_si);
  AData.AddType(TGUID_sw, System_TGUID_si);
  AData.AddType(TInterfaceEntry_sw, System_TInterfaceEntry_si);
  AData.AddType(TInterfaceTable_sw, System_TInterfaceTable_si);
  AData.AddType(TMethod_sw, System_TMethod_si);
  AData.AddType(TDispatchMessage_sw, System_TDispatchMessage_si);
  AData.AddType(TObject_sw, System_TObject_si);
  AData.AddType(TCustomAttribute_sw, System_TCustomAttribute_si);
  AData.AddType(WeakAttribute_sw, System_WeakAttribute_si);
  AData.AddType(UnsafeAttribute_sw, System_UnsafeAttribute_si);
  AData.AddType(RefAttribute_sw, System_RefAttribute_si);
  AData.AddType(VolatileAttribute_sw, System_VolatileAttribute_si);
  AData.AddType(StoredAttribute_sw, System_StoredAttribute_si);
  AData.AddType(TThreadID_sw, System_TThreadID_si);
  AData.AddType(TMonitor_sw, System_TMonitor_si);
  AData.AddConstant('INFINITE', System_INFINITE_si, Cardinal_sw);
  AData.AddFunction('MonitorEnter', System_MonitorEnter_si, Boolean_sw, 1, True);
  AData.AddFunction('MonitorTryEnter', System_MonitorTryEnter_si, Boolean_sw, 1, False);
  AData.AddProcedure('MonitorExit', System_MonitorExit_si, 1, False);
  AData.AddFunction('MonitorWait', System_MonitorWait_si, nil, 2, True);
  AData.AddProcedure('MonitorPulse', System_MonitorPulse_si, 1, False);
  AData.AddProcedure('MonitorPulseAll', System_MonitorPulseAll_si, 1, False);
  AData.AddProcedure('YieldProcessor', System_YieldProcessor_si, 0, False);
  AData.AddConstant('S_OK', System_S_OK_si, nil, VarType(System.S_OK));
  AData.AddConstant('S_FALSE', System_S_FALSE_si, nil, VarType(System.S_FALSE));
  AData.AddConstant('E_NOINTERFACE', System_E_NOINTERFACE_si, HRESULT_sw);
  AData.AddConstant('E_UNEXPECTED', System_E_UNEXPECTED_si, HRESULT_sw);
  AData.AddConstant('E_NOTIMPL', System_E_NOTIMPL_si, HRESULT_sw);
  AData.AddType(TInterfacedObject_sw, System_TInterfacedObject_si);
  AData.AddType(TInterfacedClass_sw, System_TInterfacedClass_si);
  AData.AddType(TAggregatedObject_sw, System_TAggregatedObject_si);
  AData.AddType(TContainedObject_sw, System_TContainedObject_si);
  AData.AddType(TClassHelperBase_sw, System_TClassHelperBase_si);
  AData.AddType(TClassHelperBaseClass_sw, System_TClassHelperBaseClass_si);
  AData.AddType(UCS2Char_sw, System_UCS2Char_si);
  AData.AddType(UCS4Char_sw, System_UCS4Char_si);
  AData.AddType(UTF8String_sw, System_UTF8String_si);
  AData.AddType(RawByteString_sw, System_RawByteString_si);
  AData.AddType(_UTF8Str_sw, System__UTF8Str_si);
  AData.AddType(_RawByteStr_sw, System__RawByteStr_si);
  AData.AddType(TDateTime_sw, System_TDateTime_si);
  AData.AddType(TDate_sw, System_TDate_si);
  AData.AddType(TTime_sw, System_TTime_si);
  AData.AddType(THandle_sw, System_THandle_si);
  AData.AddType(TVarArrayBound_sw, System_TVarArrayBound_si);
  AData.AddType(TVarArray_sw, System_TVarArray_si);
  AData.AddType(TVarRecord_sw, System_TVarRecord_si);
  AData.AddType(TLargestVarData_sw, System_TLargestVarData_si);
  AData.AddType(TVarType_sw, System_TVarType_si);
  AData.AddType(TVarData_sw, System_TVarData_si);
  AData.AddType(TVarOp_sw, System_TVarOp_si);
  AData.AddConstant('opAdd', System_opAdd_si, nil, VarType(System.opAdd));
  AData.AddConstant('opSubtract', System_opSubtract_si, nil, VarType(System.opSubtract));
  AData.AddConstant('opMultiply', System_opMultiply_si, nil, VarType(System.opMultiply));
  AData.AddConstant('opDivide', System_opDivide_si, nil, VarType(System.opDivide));
  AData.AddConstant('opIntDivide', System_opIntDivide_si, nil, VarType(System.opIntDivide));
  AData.AddConstant('opModulus', System_opModulus_si, nil, VarType(System.opModulus));
  AData.AddConstant('opShiftLeft', System_opShiftLeft_si, nil, VarType(System.opShiftLeft));
  AData.AddConstant('opShiftRight', System_opShiftRight_si, nil, VarType(System.opShiftRight));
  AData.AddConstant('opAnd', System_opAnd_si, nil, VarType(System.opAnd));
  AData.AddConstant('opOr', System_opOr_si, nil, VarType(System.opOr));
  AData.AddConstant('opXor', System_opXor_si, nil, VarType(System.opXor));
  AData.AddConstant('opCompare', System_opCompare_si, nil, VarType(System.opCompare));
  AData.AddConstant('opNegate', System_opNegate_si, nil, VarType(System.opNegate));
  AData.AddConstant('opNot', System_opNot_si, nil, VarType(System.opNot));
  AData.AddConstant('opCmpEQ', System_opCmpEQ_si, nil, VarType(System.opCmpEQ));
  AData.AddConstant('opCmpNE', System_opCmpNE_si, nil, VarType(System.opCmpNE));
  AData.AddConstant('opCmpLT', System_opCmpLT_si, nil, VarType(System.opCmpLT));
  AData.AddConstant('opCmpLE', System_opCmpLE_si, nil, VarType(System.opCmpLE));
  AData.AddConstant('opCmpGT', System_opCmpGT_si, nil, VarType(System.opCmpGT));
  AData.AddConstant('opCmpGE', System_opCmpGE_si, nil, VarType(System.opCmpGE));
  AData.AddConstant('NumSmallBlockTypes', System_NumSmallBlockTypes_si, nil, VarType(System.NumSmallBlockTypes));
  AData.AddType(TCallDesc_sw, System_TCallDesc_si);
  AData.AddType(TDispDesc_sw, System_TDispDesc_si);
  AData.AddType(TVariantManager_sw, System_TVariantManager_si);
  AData.AddType(TTypeKind_sw, System_TTypeKind_si);
  AData.AddType(TDynArrayTypeInfo_sw, System_TDynArrayTypeInfo_si);
  AData.AddType(TVarRec_sw, System_TVarRec_si);
  AData.AddType(TMemoryManager_sw, System_TMemoryManager_si);
  AData.AddType(TMemoryManagerEx_sw, System_TMemoryManagerEx_si);
  AData.AddType(THeapStatus_sw, System_THeapStatus_si);
  AData.AddType(TSmallBlockTypeState_sw, System_TSmallBlockTypeState_si);
  AData.AddType(TMemoryManagerState_sw, System_TMemoryManagerState_si);
  AData.AddType(TMonitorSupport_sw, System_TMonitorSupport_si);
  AData.AddType(TPtrWrapper_sw, System_TPtrWrapper_si);
  AData.AddType(TMarshal_sw, System_TMarshal_si);
  AData.AddType(TChunkStatus_sw, System_TChunkStatus_si);
  AData.AddType(TMinimumBlockAlignment_sw, System_TMinimumBlockAlignment_si);
  AData.AddType(PackageUnitEntry_sw, System_PackageUnitEntry_si);
  AData.AddType(TPackageTypeInfo_sw, System_TPackageTypeInfo_si);
  AData.AddType(PackageInfoTable_sw, System_PackageInfoTable_si);
  AData.AddProcedure('ReleaseExceptionObject', System_ReleaseExceptionObject_si, 0, False);
  AData.AddFunction('ExceptObject', System_ExceptObject_si, TObject_sw, 0, False);
  AData.AddType(TCVModInfo_sw, System_TCVModInfo_si);
  AData.AddVariable('ExceptionClass', System_ExceptionClass_si, TClass_sw);
  AData.AddVariable('HPrevInst', System_HPrevInst_si, LongWord_sw);
  AData.AddVariable('MainInstance', System_MainInstance_si, THandle_sw);
  AData.AddVariable('MainThreadID', System_MainThreadID_si, TThreadID_sw);
  AData.AddVariable('IsLibrary', System_IsLibrary_si, Boolean_sw);
  AData.AddVariable('CmdShow', System_CmdShow_si, Integer_sw);
  AData.AddVariable('ExitCode', System_ExitCode_si, Integer_sw);
  AData.AddVariable('RandSeed', System_RandSeed_si, Longint_sw);
  AData.AddVariable('IsConsole', System_IsConsole_si, Boolean_sw);
  AData.AddVariable('IsMultiThread', System_IsMultiThread_si, Boolean_sw);
  AData.AddVariable('FileMode', System_FileMode_si, Byte_sw);
  AData.AddVariable('Test8086', System_Test8086_si, Byte_sw);
  AData.AddVariable('Test8087', System_Test8087_si, Byte_sw);
  AData.AddVariable('TestFDIV', System_TestFDIV_si, Shortint_sw);
  AData.AddVariable('TestSSE', System_TestSSE_si, Cardinal_sw);
  AData.AddVariable('CPUCount', System_CPUCount_si, Integer_sw);
  AData.AddConstant('CPUi386', System_CPUi386_si, nil, VarType(System.CPUi386));
  AData.AddConstant('CPUi486', System_CPUi486_si, nil, VarType(System.CPUi486));
  AData.AddConstant('CPUPentium', System_CPUPentium_si, nil, VarType(System.CPUPentium));
  AData.AddVariable('Default8087CW', System_Default8087CW_si, Word_sw);
  AData.AddVariable('DefaultMXCSR', System_DefaultMXCSR_si, UInt32_sw);
  AData.AddVariable('HeapAllocFlags', System_HeapAllocFlags_si, Word_sw);
  AData.AddVariable('DebugHook', System_DebugHook_si, Byte_sw);
  AData.AddVariable('JITEnable', System_JITEnable_si, Byte_sw);
  AData.AddVariable('NoErrMsg', System_NoErrMsg_si, Boolean_sw);
  AData.AddVariable('DefaultSystemCodePage', System_DefaultSystemCodePage_si, Integer_sw);
  AData.AddVariable('DefaultUnicodeCodePage', System_DefaultUnicodeCodePage_si, Integer_sw);
  AData.AddVariable('UTF8CompareLocale', System_UTF8CompareLocale_si, Cardinal_sw);
  AData.AddProcedure('SetUTF8CompareLocale', System_SetUTF8CompareLocale_si, 0, False);
  AData.AddType(TTextLineBreakStyle_sw, System_TTextLineBreakStyle_si);
  AData.AddVariable('DefaultTextLineBreakStyle', System_DefaultTextLineBreakStyle_si, TTextLineBreakStyle_sw);
  AData.AddConstant('sLineBreak', System_sLineBreak_si, AnsiString_sw);
  AData.AddType(HRSRC_sw, System_HRSRC_si);
  AData.AddType(TResourceHandle_sw, System_TResourceHandle_si);
  AData.AddType(HINST_sw, System_HINST_si);
  AData.AddType(HMODULE_sw, System_HMODULE_si);
  AData.AddType(HGLOBAL_sw, System_HGLOBAL_si);
  AData.AddFunction('LoadResource', System_LoadResource_si, HGLOBAL_sw, 2, False);
  AData.AddFunction('SizeofResource', System_SizeofResource_si, Integer_sw, 2, False);
  AData.AddFunction('UnlockResource', System_UnlockResource_si, LongBool_sw, 1, False);
  AData.AddFunction('FreeResource', System_FreeResource_si, LongBool_sw, 1, False);
  AData.AddFunction('IsMemoryManagerSet', System_IsMemoryManagerSet_si, Boolean_sw, 0, False);
  AData.AddVariable('AllocMemCount', System_AllocMemCount_si, Integer_sw);
  AData.AddVariable('AllocMemSize', System_AllocMemSize_si, Integer_sw);
  AData.AddVariable('ReportMemoryLeaksOnShutdown', System_ReportMemoryLeaksOnShutdown_si, Boolean_sw);
  AData.AddVariable('NeverSleepOnMMThreadContention', System_NeverSleepOnMMThreadContention_si, Boolean_sw);
  AData.AddFunction('GetHeapStatus', System_GetHeapStatus_si, THeapStatus_sw, 0, False);
  AData.AddProcedure('GetMemoryManagerState', System_GetMemoryManagerState_si, 1, False);
  AData.AddFunction('GetMinimumBlockAlignment', System_GetMinimumBlockAlignment_si, TMinimumBlockAlignment_sw, 0, False);
  AData.AddProcedure('SetMinimumBlockAlignment', System_SetMinimumBlockAlignment_si, 1, False);
  AData.AddFunction('AttemptToUseSharedMemoryManager', System_AttemptToUseSharedMemoryManager_si, Boolean_sw, 0, False);
  AData.AddFunction('ShareMemoryManager', System_ShareMemoryManager_si, Boolean_sw, 0, False);
  AData.AddProcedure('EndThread', System_EndThread_si, 1, False);
  AData.AddConstant('fmClosed', System_fmClosed_si, nil, VarType(System.fmClosed));
  AData.AddConstant('fmInput', System_fmInput_si, nil, VarType(System.fmInput));
  AData.AddConstant('fmOutput', System_fmOutput_si, nil, VarType(System.fmOutput));
  AData.AddConstant('fmInOut', System_fmInOut_si, nil, VarType(System.fmInOut));
  AData.AddConstant('tfCRLF', System_tfCRLF_si, nil, VarType(System.tfCRLF));
  AData.AddType(TFileRec_sw, System_TFileRec_si);
  AData.AddType(TTextRec_sw, System_TTextRec_si);
  AData.AddProcedure('__IOTest', System___IOTest_si, 0, False);
  AData.AddProcedure('SetInOutRes', System_SetInOutRes_si, 1, False);
  AData.AddProcedure('ChDir', System_ChDir_si, 1, False);
  AData.AddProcedure('_UGetDir', System__UGetDir_si, 2, False);
  AData.AddProcedure('_LGetDir', System__LGetDir_si, 2, False);
  AData.AddProcedure('_WGetDir', System__WGetDir_si, 2, False);
  AData.AddProcedure('_SGetDir', System__SGetDir_si, 2, False);
  AData.AddFunction('IOResult', System_IOResult_si, Integer_sw, 0, False);
  AData.AddProcedure('MkDir', System_MkDir_si, 1, False);
  AData.AddFunction('ParamCount', System_ParamCount_si, Integer_sw, 0, False);
  AData.AddFunction('ParamStr', System_ParamStr_si, string_sw, 1, False);
  AData.AddProcedure('RmDir', System_RmDir_si, 1, False);
  AData.AddFunction('UpCase', System_UpCase_si, nil, 1, False);
  AData.AddProcedure('Randomize', System_Randomize_si, 0, False);
  AData.AddFunction('Random', System_Random_si, nil, 0, True);
  AData.AddConstant('feeINEXACT', System_feeINEXACT_si, nil, VarType(System.feeINEXACT));
  AData.AddConstant('feeUNDERFLOW', System_feeUNDERFLOW_si, nil, VarType(System.feeUNDERFLOW));
  AData.AddConstant('feeOVERFLOW', System_feeOVERFLOW_si, nil, VarType(System.feeOVERFLOW));
  AData.AddConstant('feeDIVBYZERO', System_feeDIVBYZERO_si, nil, VarType(System.feeDIVBYZERO));
  AData.AddConstant('feeINVALID', System_feeINVALID_si, nil, VarType(System.feeINVALID));
  AData.AddConstant('feeALLEXCEPT', System_feeALLEXCEPT_si, nil, VarType(System.feeALLEXCEPT));
  AData.AddConstant('feeDENORMALOPERAND', System_feeDENORMALOPERAND_si, nil, VarType(System.feeDENORMALOPERAND));
  AData.AddConstant('femINEXACT', System_femINEXACT_si, nil, VarType(System.femINEXACT));
  AData.AddConstant('femUNDERFLOW', System_femUNDERFLOW_si, nil, VarType(System.femUNDERFLOW));
  AData.AddConstant('femOVERFLOW', System_femOVERFLOW_si, nil, VarType(System.femOVERFLOW));
  AData.AddConstant('femDIVBYZERO', System_femDIVBYZERO_si, nil, VarType(System.femDIVBYZERO));
  AData.AddConstant('femINVALID', System_femINVALID_si, nil, VarType(System.femINVALID));
  AData.AddConstant('femALLEXCEPT', System_femALLEXCEPT_si, nil, VarType(System.femALLEXCEPT));
  AData.AddConstant('femDENORMALOPERAND', System_femDENORMALOPERAND_si, nil, VarType(System.femDENORMALOPERAND));
  AData.AddConstant('ferTONEAREST', System_ferTONEAREST_si, nil, VarType(System.ferTONEAREST));
  AData.AddConstant('ferUPWARD', System_ferUPWARD_si, nil, VarType(System.ferUPWARD));
  AData.AddConstant('ferDOWNWARD', System_ferDOWNWARD_si, nil, VarType(System.ferDOWNWARD));
  AData.AddConstant('ferTOWARDZERO', System_ferTOWARDZERO_si, nil, VarType(System.ferTOWARDZERO));
  AData.AddConstant('ferALLROUND', System_ferALLROUND_si, nil, VarType(System.ferALLROUND));
  AData.AddProcedure('FClearExcept', System_FClearExcept_si, 0, False);
  AData.AddProcedure('FCheckExcept', System_FCheckExcept_si, 0, False);
  AData.AddProcedure('FRaiseExcept', System_FRaiseExcept_si, 1, True);
  AData.AddFunction('FGetRound', System_FGetRound_si, UInt32_sw, 0, False);
  AData.AddFunction('FSetRound', System_FSetRound_si, UInt32_sw, 1, False);
  AData.AddFunction('FSetExceptFlag', System_FSetExceptFlag_si, UInt32_sw, 1, True);
  AData.AddFunction('FGetExceptFlag', System_FGetExceptFlag_si, UInt32_sw, 0, True);
  AData.AddFunction('FSetExceptMask', System_FSetExceptMask_si, UInt32_sw, 1, True);
  AData.AddFunction('FGetExceptMask', System_FGetExceptMask_si, UInt32_sw, 0, True);
  AData.AddProcedure('Reset8087CW', System_Reset8087CW_si, 0, False);
  AData.AddProcedure('Set8087CW', System_Set8087CW_si, 1, False);
  AData.AddFunction('Get8087CW', System_Get8087CW_si, Word_sw, 0, False);
  AData.AddProcedure('ResetMXCSR', System_ResetMXCSR_si, 0, False);
  AData.AddProcedure('SetMXCSR', System_SetMXCSR_si, 1, False);
  AData.AddProcedure('SetMXCSRExceptionFlag', System_SetMXCSRExceptionFlag_si, 1, False);
  AData.AddFunction('GetMXCSR', System_GetMXCSR_si, UInt32_sw, 0, False);
  AData.AddFunction('UTF8Encode', System_UTF8Encode_si, nil, 1, False);
  AData.AddFunction('UTF8EncodeToShortString', System_UTF8EncodeToShortString_si, nil, 1, False);
  AData.AddFunction('UTF8Decode', System_UTF8Decode_si, _WideStr_sw, 1, False);
  AData.AddFunction('UTF8ToWideString', System_UTF8ToWideString_si, _WideStr_sw, 1, False);
  AData.AddFunction('UTF8ToUnicodeString', System_UTF8ToUnicodeString_si, nil, 1, False);
  AData.AddFunction('UTF8ToString', System_UTF8ToString_si, nil, 1, False);
  AData.AddFunction('AnsiToUtf8', System_AnsiToUtf8_si, _RawByteStr_sw, 1, False);
  AData.AddFunction('Utf8ToAnsi', System_Utf8ToAnsi_si, string_sw, 1, False);
  AData.AddProcedure('GetVariantManager', System_GetVariantManager_si, 1, False);
  AData.AddProcedure('SetVariantManager', System_SetVariantManager_si, 1, False);
  AData.AddFunction('IsVariantManagerSet', System_IsVariantManagerSet_si, Boolean_sw, 0, False);
  AData.AddProcedure('_IntfDispCall', System__IntfDispCall_si, 0, False);
  AData.AddProcedure('_IntfVarCall', System__IntfVarCall_si, 0, False);
  AData.AddType(TLibModule_sw, System_TLibModule_si);
  AData.AddType(TModuleUnloadRec_sw, System_TModuleUnloadRec_si);
  AData.AddFunction('FindClassHInstance', System_FindClassHInstance_si, HINST_sw, 1, False);
  AData.AddFunction('FindResourceHInstance', System_FindResourceHInstance_si, HINST_sw, 1, False);
  AData.AddFunction('GetResourceModuleName', System_GetResourceModuleName_si, string_sw, 2, False);
  AData.AddType(TResStringRec_sw, System_TResStringRec_si);
  AData.AddType(TFloatSpecial_sw, System_TFloatSpecial_si);
  AData.AddType(TSingleRec_sw, System_TSingleRec_si);
  AData.AddType(TDoubleRec_sw, System_TDoubleRec_si);
  AData.AddType(TExtended80Rec_sw, System_TExtended80Rec_si);
  AData.AddType(TExtendedRec_sw, System_TExtendedRec_si);
  AData.AddFunction('Int', System_Int_si, Extended_sw, 1, False);
  AData.AddFunction('Frac', System_Frac_si, Extended_sw, 1, False);
  AData.AddFunction('Exp', System_Exp_si, Extended_sw, 1, False);
  AData.AddFunction('Cos', System_Cos_si, Extended_sw, 1, False);
  AData.AddFunction('Sin', System_Sin_si, Extended_sw, 1, False);
  AData.AddFunction('Ln', System_Ln_si, Extended_sw, 1, False);
  AData.AddFunction('ArcTan', System_ArcTan_si, Extended_sw, 1, False);
  AData.AddFunction('Sqrt', System_Sqrt_si, Extended_sw, 1, False);
  AData.AddFunction('Tangent', System_Tangent_si, Extended_sw, 1, False);
  AData.AddProcedure('SineCosine', System_SineCosine_si, 3, False);
  AData.AddFunction('ExpMinus1', System_ExpMinus1_si, Extended_sw, 1, False);
  AData.AddFunction('LnXPlus1', System_LnXPlus1_si, Extended_sw, 1, False);
  AData.AddProcedure('_ROUND', System__ROUND_si, 0, False);
  AData.AddProcedure('_TRUNC', System__TRUNC_si, 0, False);
  AData.AddFunction('_MulDivInt64', System__MulDivInt64_si, Int64_sw, 3, False);
  AData.AddProcedure('_AbstractError', System__AbstractError_si, 0, False);
  AData.AddProcedure('_Assert', System__Assert_si, 3, False);
  AData.AddFunction('_Append', System__Append_si, Integer_sw, 1, False);
  AData.AddFunction('_Close', System__Close_si, Integer_sw, 1, False);
  AData.AddFunction('_EofFile', System__EofFile_si, Boolean_sw, 1, False);
  AData.AddFunction('_EofText', System__EofText_si, Boolean_sw, 1, False);
  AData.AddFunction('_Eoln', System__Eoln_si, Boolean_sw, 1, False);
  AData.AddProcedure('_Erase', System__Erase_si, 1, False);
  AData.AddFunction('_FilePos', System__FilePos_si, Longint_sw, 1, False);
  AData.AddFunction('_FileSize', System__FileSize_si, Longint_sw, 1, False);
  AData.AddFunction('_Flush', System__Flush_si, Integer_sw, 1, False);
  AData.AddProcedure('_Halt', System__Halt_si, 1, False);
  AData.AddProcedure('_Halt0', System__Halt0_si, 0, False);
  AData.AddProcedure('Mark', System_Mark_si, 0, False);
  AData.AddFunction('_ReadChar', System__ReadChar_si, _AnsiChr_sw, 1, False);
  AData.AddFunction('_ReadLong', System__ReadLong_si, Longint_sw, 1, False);
  AData.AddProcedure('_ReadLString', System__ReadLString_si, 3, False);
  AData.AddProcedure('_ReadUString', System__ReadUString_si, 2, False);
  AData.AddProcedure('_ReadWString', System__ReadWString_si, 2, False);
  AData.AddFunction('_ReadWChar', System__ReadWChar_si, WideChar_sw, 1, False);
  AData.AddFunction('_ReadExt', System__ReadExt_si, Extended_sw, 1, False);
  AData.AddProcedure('_ReadLn', System__ReadLn_si, 1, False);
  AData.AddProcedure('Release', System_Release_si, 0, False);
  AData.AddFunction('_ResetText', System__ResetText_si, Integer_sw, 1, False);
  AData.AddFunction('_ResetFile', System__ResetFile_si, Integer_sw, 2, False);
  AData.AddFunction('_RewritText', System__RewritText_si, Integer_sw, 1, False);
  AData.AddFunction('_RewritFile', System__RewritFile_si, Integer_sw, 2, False);
  AData.AddProcedure('_RunError', System__RunError_si, 1, False);
  AData.AddProcedure('_Run0Error', System__Run0Error_si, 0, False);
  AData.AddProcedure('_Seek', System__Seek_si, 2, False);
  AData.AddFunction('_SeekEof', System__SeekEof_si, Boolean_sw, 1, False);
  AData.AddFunction('_SeekEoln', System__SeekEoln_si, Boolean_sw, 1, False);
  AData.AddFunction('_StrLong', System__StrLong_si, _ShortStr_sw, 2, False);
  AData.AddFunction('_Str0Long', System__Str0Long_si, _ShortStr_sw, 1, False);
  AData.AddProcedure('_Truncate', System__Truncate_si, 1, False);
  AData.AddFunction('_ValLong', System__ValLong_si, Longint_sw, 2, False);
  AData.AddProcedure('_Write2Ext', System__Write2Ext_si, 0, False);
  AData.AddProcedure('_Write1Ext', System__Write1Ext_si, 0, False);
  AData.AddProcedure('_Write0Ext', System__Write0Ext_si, 0, False);
  AData.AddProcedure('_SetElem', System__SetElem_si, 0, False);
  AData.AddProcedure('_SetRange', System__SetRange_si, 0, False);
  AData.AddProcedure('_SetEq', System__SetEq_si, 0, False);
  AData.AddProcedure('_SetLe', System__SetLe_si, 0, False);
  AData.AddProcedure('_SetIntersect', System__SetIntersect_si, 0, False);
  AData.AddProcedure('_SetIntersect3', System__SetIntersect3_si, 0, False);
  AData.AddProcedure('_SetUnion', System__SetUnion_si, 0, False);
  AData.AddProcedure('_SetUnion3', System__SetUnion3_si, 0, False);
  AData.AddProcedure('_SetSub', System__SetSub_si, 0, False);
  AData.AddProcedure('_SetSub3', System__SetSub3_si, 0, False);
  AData.AddProcedure('_SetExpand', System__SetExpand_si, 0, False);
  AData.AddFunction('_Str2Ext', System__Str2Ext_si, _ShortStr_sw, 3, False);
  AData.AddFunction('_Str1Ext', System__Str1Ext_si, _ShortStr_sw, 2, False);
  AData.AddFunction('_Str0Ext', System__Str0Ext_si, _ShortStr_sw, 1, False);
  AData.AddProcedure('_ValExt', System__ValExt_si, 0, False);
  AData.AddProcedure('_Pow10', System__Pow10_si, 0, False);
  AData.AddProcedure('_Real2Ext', System__Real2Ext_si, 0, False);
  AData.AddProcedure('_Ext2Real', System__Ext2Real_si, 0, False);
  AData.AddProcedure('_ObjSetup', System__ObjSetup_si, 0, False);
  AData.AddProcedure('_ObjCopy', System__ObjCopy_si, 0, False);
  AData.AddProcedure('_BoundErr', System__BoundErr_si, 0, False);
  AData.AddProcedure('_IntOver', System__IntOver_si, 0, False);
  AData.AddProcedure('_IntDivByZero', System__IntDivByZero_si, 0, False);
  AData.AddFunction('_AtomicIncInt64', System__AtomicIncInt64_si, Int64_sw, 2, False);
  AData.AddFunction('_AtomicXchgInt64', System__AtomicXchgInt64_si, Int64_sw, 2, False);
  AData.AddType(TInitContext_sw, System_TInitContext_si);
  AData.AddProcedure('_StartLib', System__StartLib_si, 0, False);
  AData.AddType(TExceptionRecord_sw, System_TExceptionRecord_si);
  AData.AddFunction('_BeforeDestruction', System__BeforeDestruction_si, TObject_sw, 2, False);
  AData.AddProcedure('_ClassDestroy', System__ClassDestroy_si, 1, False);
  AData.AddFunction('_AfterConstruction', System__AfterConstruction_si, TObject_sw, 1, False);
  AData.AddFunction('_IsClass', System__IsClass_si, Boolean_sw, 2, False);
  AData.AddFunction('_AsClass', System__AsClass_si, TObject_sw, 2, False);
  AData.AddProcedure('_RaiseExcept', System__RaiseExcept_si, 0, False);
  AData.AddProcedure('_RaiseAgain', System__RaiseAgain_si, 0, False);
  AData.AddProcedure('_DoneExcept', System__DoneExcept_si, 0, False);
  AData.AddProcedure('_TryFinallyExit', System__TryFinallyExit_si, 0, False);
  AData.AddProcedure('_HandleAnyException', System__HandleAnyException_si, 0, False);
  AData.AddProcedure('_HandleAutoException', System__HandleAutoException_si, 0, False);
  AData.AddProcedure('_HandleOnException', System__HandleOnException_si, 0, False);
  AData.AddProcedure('_HandleFinally', System__HandleFinally_si, 0, False);
  AData.AddProcedure('_UnhandledException', System__UnhandledException_si, 0, False);
  AData.AddProcedure('_CallDynaInst', System__CallDynaInst_si, 0, False);
  AData.AddProcedure('_CallDynaClass', System__CallDynaClass_si, 0, False);
  AData.AddProcedure('_UStrAsg', System__UStrAsg_si, 2, False);
  AData.AddProcedure('_UStrLAsg', System__UStrLAsg_si, 2, False);
  AData.AddProcedure('_WStrAsg', System__WStrAsg_si, 2, False);
  AData.AddProcedure('_WStrLAsg', System__WStrLAsg_si, 2, False);
  AData.AddProcedure('_LStrAsg', System__LStrAsg_si, 2, False);
  AData.AddProcedure('_LStrLAsg', System__LStrLAsg_si, 2, False);
  AData.AddFunction('StringElementSize', System_StringElementSize_si, nil, 1, False);
  AData.AddFunction('StringCodePage', System_StringCodePage_si, nil, 1, False);
  AData.AddFunction('StringRefCount', System_StringRefCount_si, nil, 1, False);
  AData.AddFunction('_UStrLen', System__UStrLen_si, Integer_sw, 1, False);
  AData.AddFunction('_WStrLen', System__WStrLen_si, Longint_sw, 1, False);
  AData.AddFunction('_LStrLen', System__LStrLen_si, Longint_sw, 1, False);
  AData.AddProcedure('UniqueString', System_UniqueString_si, 1, False);
  AData.AddProcedure('_PStrCmp', System__PStrCmp_si, 0, False);
  AData.AddProcedure('_AStrCmp', System__AStrCmp_si, 0, False);
  AData.AddProcedure('_WStrLCmp', System__WStrLCmp_si, 0, False);
  AData.AddFunction('_Copy', System__Copy_si, _ShortStr_sw, 3, False);
  AData.AddProcedure('_LStrFromChar', System__LStrFromChar_si, 3, False);
  AData.AddProcedure('_LStrFromWChar', System__LStrFromWChar_si, 3, False);
  AData.AddProcedure('_LStrFromUStr', System__LStrFromUStr_si, 3, False);
  AData.AddProcedure('_LStrFromWStr', System__LStrFromWStr_si, 3, False);
  AData.AddProcedure('_LStrFromString', System__LStrFromString_si, 3, False);
  AData.AddProcedure('_LStrCat', System__LStrCat_si, 2, False);
  AData.AddProcedure('_LStrCat3', System__LStrCat3_si, 3, False);
  AData.AddProcedure('_LStrCatN', System__LStrCatN_si, 0, False);
  AData.AddProcedure('_LStrCmp', System__LStrCmp_si, 0, False);
  AData.AddProcedure('_LStrEqual', System__LStrEqual_si, 0, False);
  AData.AddFunction('_LStrCopy', System__LStrCopy_si, _AnsiStr_sw, 3, False);
  AData.AddProcedure('_LStrDelete', System__LStrDelete_si, 3, False);
  AData.AddProcedure('_LStrInsert', System__LStrInsert_si, 3, False);
  AData.AddProcedure('_LStrSetLength', System__LStrSetLength_si, 3, False);
  AData.AddProcedure('_WStrFromChar', System__WStrFromChar_si, 2, False);
  AData.AddProcedure('_WStrFromWChar', System__WStrFromWChar_si, 2, False);
  AData.AddProcedure('_WStrFromLStr', System__WStrFromLStr_si, 2, False);
  AData.AddProcedure('_WStrFromUStr', System__WStrFromUStr_si, 2, False);
  AData.AddProcedure('_WStrFromString', System__WStrFromString_si, 2, False);
  AData.AddProcedure('_WStrCat', System__WStrCat_si, 2, False);
  AData.AddProcedure('_WStrCat3', System__WStrCat3_si, 3, False);
  AData.AddProcedure('_WStrCatN', System__WStrCatN_si, 0, False);
  AData.AddProcedure('_WStrCmp', System__WStrCmp_si, 0, False);
  AData.AddProcedure('_WStrEqual', System__WStrEqual_si, 0, False);
  AData.AddFunction('_WStrCopy', System__WStrCopy_si, _WideStr_sw, 3, False);
  AData.AddProcedure('_WStrDelete', System__WStrDelete_si, 3, False);
  AData.AddProcedure('_WStrInsert', System__WStrInsert_si, 3, False);
  AData.AddProcedure('_WStrSetLength', System__WStrSetLength_si, 2, False);
  AData.AddProcedure('_UStrFromChar', System__UStrFromChar_si, 2, False);
  AData.AddProcedure('_UStrFromWChar', System__UStrFromWChar_si, 2, False);
  AData.AddProcedure('_UStrFromLStr', System__UStrFromLStr_si, 2, False);
  AData.AddProcedure('_UStrFromWStr', System__UStrFromWStr_si, 2, False);
  AData.AddProcedure('_UStrFromString', System__UStrFromString_si, 2, False);
  AData.AddProcedure('_UStrCat', System__UStrCat_si, 2, False);
  AData.AddProcedure('_UStrCat3', System__UStrCat3_si, 3, False);
  AData.AddProcedure('_UStrCatN', System__UStrCatN_si, 0, False);
  AData.AddProcedure('_UStrCmp', System__UStrCmp_si, 0, False);
  AData.AddProcedure('_UStrEqual', System__UStrEqual_si, 0, False);
  AData.AddFunction('_UStrCopy', System__UStrCopy_si, UnicodeString_sw, 3, False);
  AData.AddProcedure('_UStrDelete', System__UStrDelete_si, 3, False);
  AData.AddProcedure('_UStrInsert', System__UStrInsert_si, 3, False);
  AData.AddProcedure('_UStrSetLength', System__UStrSetLength_si, 2, False);
  AData.AddFunction('Pos', System_Pos_si, nil, 2, True);
  AData.AddFunction('StringOfChar', System_StringOfChar_si, nil, 2, False);
  AData.AddProcedure('SetCodePage', System_SetCodePage_si, 2, True);
  AData.AddProcedure('_CopyRecord', System__CopyRecord_si, 0, False);
  AData.AddProcedure('_CopyObject', System__CopyObject_si, 0, False);
  AData.AddProcedure('_CopyArray', System__CopyArray_si, 0, False);
  AData.AddProcedure('__llmul', System___llmul_si, 0, False);
  AData.AddProcedure('__lldiv', System___lldiv_si, 0, False);
  AData.AddProcedure('__lludiv', System___lludiv_si, 0, False);
  AData.AddProcedure('__llmod', System___llmod_si, 0, False);
  AData.AddProcedure('__llmulo', System___llmulo_si, 0, False);
  AData.AddProcedure('__lldivo', System___lldivo_si, 0, False);
  AData.AddProcedure('__llmodo', System___llmodo_si, 0, False);
  AData.AddProcedure('__llumod', System___llumod_si, 0, False);
  AData.AddProcedure('__llshl', System___llshl_si, 0, False);
  AData.AddProcedure('__llushr', System___llushr_si, 0, False);
  AData.AddFunction('_ReadInt64', System__ReadInt64_si, Int64_sw, 1, False);
  AData.AddFunction('_ReadUInt64', System__ReadUInt64_si, UInt64_sw, 1, False);
  AData.AddFunction('_StrInt64', System__StrInt64_si, _ShortStr_sw, 2, False);
  AData.AddFunction('_Str0Int64', System__Str0Int64_si, _ShortStr_sw, 1, False);
  AData.AddFunction('_ValInt64', System__ValInt64_si, Int64_sw, 2, False);
  AData.AddFunction('_ValUInt64', System__ValUInt64_si, UInt64_sw, 2, False);
  AData.AddFunction('_StrUInt64', System__StrUInt64_si, _ShortStr_sw, 2, False);
  AData.AddFunction('_Str0UInt64', System__Str0UInt64_si, _ShortStr_sw, 1, False);
  AData.AddProcedure('_DynArraySetLength', System__DynArraySetLength_si, 0, False);
  AData.AddProcedure('_FSafeDivide', System__FSafeDivide_si, 0, False);
  AData.AddProcedure('_FSafeDivideR', System__FSafeDivideR_si, 0, False);
  AData.AddFunction('_CheckAutoResult', System__CheckAutoResult_si, HResult_sw, 1, False);
  AData.AddProcedure('FPower10', System_FPower10_si, 0, False);
  AData.AddFunction('Power10', System_Power10_si, Extended_sw, 2, False);
  AData.AddProcedure('TextStart', System_TextStart_si, 0, False);
  AData.AddFunction('CompToDouble', System_CompToDouble_si, Double_sw, 1, False);
  AData.AddProcedure('DoubleToComp', System_DoubleToComp_si, 2, False);
  AData.AddFunction('CompToCurrency', System_CompToCurrency_si, Currency_sw, 1, False);
  AData.AddProcedure('CurrencyToComp', System_CurrencyToComp_si, 2, False);
  AData.AddType(TRuntimeError_sw, System_TRuntimeError_si);
  AData.AddProcedure('Error', System_Error_si, 1, False);
  AData.AddFunction('GetLastError', System_GetLastError_si, Integer_sw, 0, False);
  AData.AddProcedure('SetLastError', System_SetLastError_si, 1, False);
  AData.AddProcedure('SetMultiByteConversionCodePage', System_SetMultiByteConversionCodePage_si, 1, False);
  AData.AddFunction('GetUILanguages', System_GetUILanguages_si, string_sw, 1, False);
  AData.AddFunction('GetLocaleOverride', System_GetLocaleOverride_si, string_sw, 1, False);
  AData.AddProcedure('SetLocaleOverride', System_SetLocaleOverride_si, 1, False);
end;

class function System_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(System_sw);
end;

initialization
  RegisterUnitWrapper(System_sw);
  RegisterClassWrapper(TObject_sw);
  RegisterClassWrapper(TCustomAttribute_sw);
  RegisterClassWrapper(WeakAttribute_sw);
  RegisterClassWrapper(UnsafeAttribute_sw);
  RegisterClassWrapper(RefAttribute_sw);
  RegisterClassWrapper(VolatileAttribute_sw);
  RegisterClassWrapper(StoredAttribute_sw);
  RegisterClassWrapper(TInterfacedObject_sw);
  RegisterClassWrapper(TAggregatedObject_sw);
  RegisterClassWrapper(TContainedObject_sw);
  RegisterClassWrapper(TClassHelperBase_sw);
  RegisterClassWrapper(TMarshal_sw);

end.
