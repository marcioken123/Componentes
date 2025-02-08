unit Data.DB_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Data.DB' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Types, System.TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, System.SysUtils, System.Classes, System.Variants,
  System.MaskUtils, Data.DBCommonTypes, Data.DB, System.SysUtils_LMDSW,
  System.Classes_LMDSW, System.Variants_LMDSW, System.MaskUtils_LMDSW,
  Data.DBCommonTypes_LMDSW;


{ Type wrappers }

type
  EDatabaseError_sw = class;
  EUpdateError_sw = class;
  TCustomConnection_sw = class;
  TNamedItem_sw = class;
  TDefCollection_sw = class;
  TFieldClass_sw = class;
  TFieldDefsClass_sw = class;
  TFieldDef_sw = class;
  TFieldDefClass_sw = class;
  TFieldDefs_sw = class;
  TIndexDef_sw = class;
  TIndexDefClass_sw = class;
  TIndexDefs_sw = class;
  TIndexDefsClass_sw = class;
  TFlatList_sw = class;
  TFieldDefList_sw = class;
  TFieldDefListClass_sw = class;
  TFieldList_sw = class;
  TFieldListClass_sw = class;
  TFieldsEnumerator_sw = class;
  TFields_sw = class;
  TFieldsClass_sw = class;
  TLookupList_sw = class;
  TLookupListClass_sw = class;
  TDefaultLookupList_sw = class;
  TField_sw = class;
  TStringField_sw = class;
  TWideStringField_sw = class;
  TNumericField_sw = class;
  TIntegerField_sw = class;
  TLongWordField_sw = class;
  TSmallintField_sw = class;
  TShortintField_sw = class;
  TByteField_sw = class;
  TLargeintField_sw = class;
  TWordField_sw = class;
  TAutoIncField_sw = class;
  TUnsignedAutoIncField_sw = class;
  TFloatField_sw = class;
  TSingleField_sw = class;
  TCurrencyField_sw = class;
  TExtendedField_sw = class;
  TBooleanField_sw = class;
  TDateTimeField_sw = class;
  TSQLTimeStampField_sw = class;
  TSQLTimeStampOffsetField_sw = class;
  TDateField_sw = class;
  TTimeField_sw = class;
  TBinaryField_sw = class;
  TBytesField_sw = class;
  TVarBytesField_sw = class;
  TBCDField_sw = class;
  TFMTBCDField_sw = class;
  TBlobField_sw = class;
  TMemoField_sw = class;
  TWideMemoField_sw = class;
  TGraphicField_sw = class;
  TObjectField_sw = class;
  TADTField_sw = class;
  TArrayField_sw = class;
  TDataSetField_sw = class;
  TReferenceField_sw = class;
  TVariantField_sw = class;
  TInterfaceField_sw = class;
  TIDispatchField_sw = class;
  TGuidField_sw = class;
  TAggregateField_sw = class;
  TDataLink_sw = class;
  TDetailDataLink_sw = class;
  TMasterDataLink_sw = class;
  TDataSource_sw = class;
  TDataSetDesigner_sw = class;
  TCheckConstraint_sw = class;
  TCheckConstraintClass_sw = class;
  TCheckConstraints_sw = class;
  TCheckConstraintsClass_sw = class;
  TBitConverter_sw = class;
  TParamObjectClass_sw = class;
  TParam_sw = class;
  TParamClass_sw = class;
  TParams_sw = class;
  TParamsClass_sw = class;
  TParamObject_sw = class;
  TParamStreamObject_sw = class;
  TDataSetClass_sw = class;
  TDataSet_sw = class;

  EDatabaseError_sc = class of EDatabaseError;
  EDatabaseError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EDatabaseError): OleVariant;
    class function FromVar(const AValue: OleVariant): EDatabaseError;
    class function ClassToVar(AClass: EDatabaseError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EDatabaseError_sc;
  end;

  EUpdateError_sc = class of EUpdateError;
  EUpdateError_sw = class(EDatabaseError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EUpdateError): OleVariant;
    class function FromVar(const AValue: OleVariant): EUpdateError;
    class function ClassToVar(AClass: EUpdateError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EUpdateError_sc;
  end;

  TFieldType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFieldType): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldType;
  end;

  TDataSetState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDataSetState): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSetState;
  end;

  TDataEvent_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDataEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataEvent;
  end;

  TUpdateStatus_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TUpdateStatus): OleVariant;
    class function FromVar(const AValue: OleVariant): TUpdateStatus;
  end;

  TUpdateStatusSet_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TUpdateStatusSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TUpdateStatusSet;
  end;

  TUpdateAction_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TUpdateAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TUpdateAction;
  end;

  TUpdateMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TUpdateMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TUpdateMode;
  end;

  TUpdateKind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TUpdateKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TUpdateKind;
  end;

  TUpdateErrorEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DataSet: TDataSet; E: EDatabaseError;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
  end;

  TUpdateErrorEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TUpdateErrorEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TUpdateErrorEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TUpdateErrorEvent;
  end;

  TUpdateRecordEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DataSet: TDataSet; UpdateKind: TUpdateKind;
      var UpdateAction: TUpdateAction);
  end;

  TUpdateRecordEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TUpdateRecordEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TUpdateRecordEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TUpdateRecordEvent;
  end;

  TConnectChangeEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Connecting: Boolean);
  end;

  TConnectChangeEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TConnectChangeEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TConnectChangeEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TConnectChangeEvent;
  end;

  TCustomConnection_sc = class of TCustomConnection;
  TCustomConnection_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomConnection): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomConnection;
    class function ClassToVar(AClass: TCustomConnection_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomConnection_sc;
  end;

  TNamedItem_sc = class of TNamedItem;
  TNamedItem_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TNamedItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TNamedItem;
    class function ClassToVar(AClass: TNamedItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TNamedItem_sc;
  end;

  TDefUpdateMethod_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler;
  end;

  TDefUpdateMethod_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDefUpdateMethod): OleVariant;
    class function FromVar(const AValue: OleVariant): TDefUpdateMethod;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDefUpdateMethod;
  end;

  TDefCollection_sc = class of TDefCollection;
  TDefCollection_sw = class(TOwnedCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDefCollection): OleVariant;
    class function FromVar(const AValue: OleVariant): TDefCollection;
    class function ClassToVar(AClass: TDefCollection_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDefCollection_sc;
  end;

  TFieldClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TFieldClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldClass;
  end;

  TFieldAttribute_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFieldAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldAttribute;
  end;

  TFieldAttributes_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFieldAttributes): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldAttributes;
  end;

  TFieldDefsClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TFieldDefsClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldDefsClass;
  end;

  TFieldDef_sc = class of TFieldDef;
  TFieldDef_sw = class(TNamedItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFieldDef): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldDef;
    class function ClassToVar(AClass: TFieldDef_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFieldDef_sc;
  end;

  TFieldDefClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TFieldDefClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldDefClass;
  end;

  TFieldDefs_sc = class of TFieldDefs;
  TFieldDefs_sw = class(TDefCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFieldDefs): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldDefs;
    class function ClassToVar(AClass: TFieldDefs_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFieldDefs_sc;
  end;

  TIndexOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TIndexOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TIndexOption;
  end;

  TIndexOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TIndexOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TIndexOptions;
  end;

  TIndexDef_sc = class of TIndexDef;
  TIndexDef_sw = class(TNamedItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TIndexDef): OleVariant;
    class function FromVar(const AValue: OleVariant): TIndexDef;
    class function ClassToVar(AClass: TIndexDef_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TIndexDef_sc;
  end;

  TIndexDefClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TIndexDefClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TIndexDefClass;
  end;

  TIndexDefs_sc = class of TIndexDefs;
  TIndexDefs_sw = class(TDefCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TIndexDefs): OleVariant;
    class function FromVar(const AValue: OleVariant): TIndexDefs;
    class function ClassToVar(AClass: TIndexDefs_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TIndexDefs_sc;
  end;

  TIndexDefsClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TIndexDefsClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TIndexDefsClass;
  end;

  TFlatList_sc = class of TFlatList;
  TFlatList_sw = class(TStringList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFlatList): OleVariant;
    class function FromVar(const AValue: OleVariant): TFlatList;
    class function ClassToVar(AClass: TFlatList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFlatList_sc;
  end;

  TFieldDefList_sc = class of TFieldDefList;
  TFieldDefList_sw = class(TFlatList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFieldDefList): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldDefList;
    class function ClassToVar(AClass: TFieldDefList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFieldDefList_sc;
  end;

  TFieldDefListClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TFieldDefListClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldDefListClass;
  end;

  TFieldList_sc = class of TFieldList;
  TFieldList_sw = class(TFlatList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFieldList): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldList;
    class function ClassToVar(AClass: TFieldList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFieldList_sc;
  end;

  TFieldListClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TFieldListClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldListClass;
  end;

  TFieldsEnumerator_sc = class of TFieldsEnumerator;
  TFieldsEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFieldsEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldsEnumerator;
    class function ClassToVar(AClass: TFieldsEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFieldsEnumerator_sc;
  end;

  TFieldKind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFieldKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldKind;
  end;

  TFieldKinds_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFieldKinds): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldKinds;
  end;

  TFields_sc = class of TFields;
  TFields_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFields): OleVariant;
    class function FromVar(const AValue: OleVariant): TFields;
    class function ClassToVar(AClass: TFields_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFields_sc;
  end;

  TFieldsClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TFieldsClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldsClass;
  end;

  TProviderFlag_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TProviderFlag): OleVariant;
    class function FromVar(const AValue: OleVariant): TProviderFlag;
  end;

  TProviderFlags_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TProviderFlags): OleVariant;
    class function FromVar(const AValue: OleVariant): TProviderFlags;
  end;

  TFieldNotifyEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TField);
  end;

  TFieldNotifyEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFieldNotifyEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldNotifyEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFieldNotifyEvent;
  end;

  TFieldGetTextEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TField; var Text: string; DisplayText: Boolean);
  end;

  TFieldGetTextEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFieldGetTextEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldGetTextEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFieldGetTextEvent;
  end;

  TFieldSetTextEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TField; const Text: string);
  end;

  TFieldSetTextEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFieldSetTextEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldSetTextEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFieldSetTextEvent;
  end;

  TFieldChars_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFieldChars): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldChars;
  end;

  TAutoRefreshFlag_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TAutoRefreshFlag): OleVariant;
    class function FromVar(const AValue: OleVariant): TAutoRefreshFlag;
  end;

  TLookupList_sc = class of TLookupList;
  TLookupList_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TLookupList): OleVariant;
    class function FromVar(const AValue: OleVariant): TLookupList;
    class function ClassToVar(AClass: TLookupList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TLookupList_sc;
  end;

  TLookupListClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TLookupListClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TLookupListClass;
  end;

  TLookupListEntry_sw = class(TLMDRecordWrapper)
  private
    FValue: TLookupListEntry;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TLookupListEntry): OleVariant;
    class function FromVar(const AValue: OleVariant): TLookupListEntry;
  end;

  TDefaultLookupList_sc = class of TDefaultLookupList;
  TDefaultLookupList_sw = class(TLookupList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDefaultLookupList): OleVariant;
    class function FromVar(const AValue: OleVariant): TDefaultLookupList;
    class function ClassToVar(AClass: TDefaultLookupList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDefaultLookupList_sc;
  end;

  Largeint_sw = Int64_sw;

  TField_sc = class of TField;
  TField_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TField): OleVariant;
    class function FromVar(const AValue: OleVariant): TField;
    class function ClassToVar(AClass: TField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TField_sc;
  end;

  TStringField_sc = class of TStringField;
  TStringField_sw = class(TField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStringField): OleVariant;
    class function FromVar(const AValue: OleVariant): TStringField;
    class function ClassToVar(AClass: TStringField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStringField_sc;
  end;

  TWideStringField_sc = class of TWideStringField;
  TWideStringField_sw = class(TStringField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWideStringField): OleVariant;
    class function FromVar(const AValue: OleVariant): TWideStringField;
    class function ClassToVar(AClass: TWideStringField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWideStringField_sc;
  end;

  TNumericField_sc = class of TNumericField;
  TNumericField_sw = class(TField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TNumericField): OleVariant;
    class function FromVar(const AValue: OleVariant): TNumericField;
    class function ClassToVar(AClass: TNumericField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TNumericField_sc;
  end;

  TIntegerField_sc = class of TIntegerField;
  TIntegerField_sw = class(TNumericField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TIntegerField): OleVariant;
    class function FromVar(const AValue: OleVariant): TIntegerField;
    class function ClassToVar(AClass: TIntegerField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TIntegerField_sc;
  end;

  TLongWordField_sc = class of TLongWordField;
  TLongWordField_sw = class(TNumericField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TLongWordField): OleVariant;
    class function FromVar(const AValue: OleVariant): TLongWordField;
    class function ClassToVar(AClass: TLongWordField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TLongWordField_sc;
  end;

  TSmallintField_sc = class of TSmallintField;
  TSmallintField_sw = class(TIntegerField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSmallintField): OleVariant;
    class function FromVar(const AValue: OleVariant): TSmallintField;
    class function ClassToVar(AClass: TSmallintField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSmallintField_sc;
  end;

  TShortintField_sc = class of TShortintField;
  TShortintField_sw = class(TIntegerField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TShortintField): OleVariant;
    class function FromVar(const AValue: OleVariant): TShortintField;
    class function ClassToVar(AClass: TShortintField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TShortintField_sc;
  end;

  TByteField_sc = class of TByteField;
  TByteField_sw = class(TIntegerField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TByteField): OleVariant;
    class function FromVar(const AValue: OleVariant): TByteField;
    class function ClassToVar(AClass: TByteField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TByteField_sc;
  end;

  TLargeintField_sc = class of TLargeintField;
  TLargeintField_sw = class(TNumericField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TLargeintField): OleVariant;
    class function FromVar(const AValue: OleVariant): TLargeintField;
    class function ClassToVar(AClass: TLargeintField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TLargeintField_sc;
  end;

  TWordField_sc = class of TWordField;
  TWordField_sw = class(TIntegerField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWordField): OleVariant;
    class function FromVar(const AValue: OleVariant): TWordField;
    class function ClassToVar(AClass: TWordField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWordField_sc;
  end;

  TAutoIncField_sc = class of TAutoIncField;
  TAutoIncField_sw = class(TIntegerField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TAutoIncField): OleVariant;
    class function FromVar(const AValue: OleVariant): TAutoIncField;
    class function ClassToVar(AClass: TAutoIncField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TAutoIncField_sc;
  end;

  TUnsignedAutoIncField_sc = class of TUnsignedAutoIncField;
  TUnsignedAutoIncField_sw = class(TLongWordField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TUnsignedAutoIncField): OleVariant;
    class function FromVar(const AValue: OleVariant): TUnsignedAutoIncField;
    class function ClassToVar(AClass: TUnsignedAutoIncField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TUnsignedAutoIncField_sc;
  end;

  TFloatField_sc = class of TFloatField;
  TFloatField_sw = class(TNumericField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFloatField): OleVariant;
    class function FromVar(const AValue: OleVariant): TFloatField;
    class function ClassToVar(AClass: TFloatField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFloatField_sc;
  end;

  TSingleField_sc = class of TSingleField;
  TSingleField_sw = class(TNumericField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSingleField): OleVariant;
    class function FromVar(const AValue: OleVariant): TSingleField;
    class function ClassToVar(AClass: TSingleField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSingleField_sc;
  end;

  TCurrencyField_sc = class of TCurrencyField;
  TCurrencyField_sw = class(TFloatField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCurrencyField): OleVariant;
    class function FromVar(const AValue: OleVariant): TCurrencyField;
    class function ClassToVar(AClass: TCurrencyField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCurrencyField_sc;
  end;

  TExtendedField_sc = class of TExtendedField;
  TExtendedField_sw = class(TNumericField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TExtendedField): OleVariant;
    class function FromVar(const AValue: OleVariant): TExtendedField;
    class function ClassToVar(AClass: TExtendedField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TExtendedField_sc;
  end;

  TBooleanField_sc = class of TBooleanField;
  TBooleanField_sw = class(TField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBooleanField): OleVariant;
    class function FromVar(const AValue: OleVariant): TBooleanField;
    class function ClassToVar(AClass: TBooleanField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBooleanField_sc;
  end;

  TDateTimeField_sc = class of TDateTimeField;
  TDateTimeField_sw = class(TField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDateTimeField): OleVariant;
    class function FromVar(const AValue: OleVariant): TDateTimeField;
    class function ClassToVar(AClass: TDateTimeField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDateTimeField_sc;
  end;

  TSQLTimeStampField_sc = class of TSQLTimeStampField;
  TSQLTimeStampField_sw = class(TField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSQLTimeStampField): OleVariant;
    class function FromVar(const AValue: OleVariant): TSQLTimeStampField;
    class function ClassToVar(AClass: TSQLTimeStampField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSQLTimeStampField_sc;
  end;

  TSQLTimeStampOffsetField_sc = class of TSQLTimeStampOffsetField;
  TSQLTimeStampOffsetField_sw = class(TSQLTimeStampField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSQLTimeStampOffsetField): OleVariant;
    class function FromVar(const AValue: OleVariant): TSQLTimeStampOffsetField;
    class function ClassToVar(AClass: TSQLTimeStampOffsetField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSQLTimeStampOffsetField_sc;
  end;

  TDateField_sc = class of TDateField;
  TDateField_sw = class(TDateTimeField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDateField): OleVariant;
    class function FromVar(const AValue: OleVariant): TDateField;
    class function ClassToVar(AClass: TDateField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDateField_sc;
  end;

  TTimeField_sc = class of TTimeField;
  TTimeField_sw = class(TDateTimeField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTimeField): OleVariant;
    class function FromVar(const AValue: OleVariant): TTimeField;
    class function ClassToVar(AClass: TTimeField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTimeField_sc;
  end;

  TBinaryField_sc = class of TBinaryField;
  TBinaryField_sw = class(TField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBinaryField): OleVariant;
    class function FromVar(const AValue: OleVariant): TBinaryField;
    class function ClassToVar(AClass: TBinaryField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBinaryField_sc;
  end;

  TBytesField_sc = class of TBytesField;
  TBytesField_sw = class(TBinaryField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBytesField): OleVariant;
    class function FromVar(const AValue: OleVariant): TBytesField;
    class function ClassToVar(AClass: TBytesField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBytesField_sc;
  end;

  TVarBytesField_sc = class of TVarBytesField;
  TVarBytesField_sw = class(TBytesField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TVarBytesField): OleVariant;
    class function FromVar(const AValue: OleVariant): TVarBytesField;
    class function ClassToVar(AClass: TVarBytesField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TVarBytesField_sc;
  end;

  TBCDField_sc = class of TBCDField;
  TBCDField_sw = class(TNumericField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBCDField): OleVariant;
    class function FromVar(const AValue: OleVariant): TBCDField;
    class function ClassToVar(AClass: TBCDField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBCDField_sc;
  end;

  TFMTBCDField_sc = class of TFMTBCDField;
  TFMTBCDField_sw = class(TNumericField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFMTBCDField): OleVariant;
    class function FromVar(const AValue: OleVariant): TFMTBCDField;
    class function ClassToVar(AClass: TFMTBCDField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFMTBCDField_sc;
  end;

  TBlobType_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TBlobType): OleVariant;
    class function FromVar(const AValue: OleVariant): TBlobType;
  end;

  TBlobField_sc = class of TBlobField;
  TBlobField_sw = class(TField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBlobField): OleVariant;
    class function FromVar(const AValue: OleVariant): TBlobField;
    class function ClassToVar(AClass: TBlobField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBlobField_sc;
  end;

  TMemoField_sc = class of TMemoField;
  TMemoField_sw = class(TBlobField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMemoField): OleVariant;
    class function FromVar(const AValue: OleVariant): TMemoField;
    class function ClassToVar(AClass: TMemoField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMemoField_sc;
  end;

  TWideMemoField_sc = class of TWideMemoField;
  TWideMemoField_sw = class(TBlobField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWideMemoField): OleVariant;
    class function FromVar(const AValue: OleVariant): TWideMemoField;
    class function ClassToVar(AClass: TWideMemoField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWideMemoField_sc;
  end;

  TGraphicField_sc = class of TGraphicField;
  TGraphicField_sw = class(TBlobField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TGraphicField): OleVariant;
    class function FromVar(const AValue: OleVariant): TGraphicField;
    class function ClassToVar(AClass: TGraphicField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TGraphicField_sc;
  end;

  TObjectField_sc = class of TObjectField;
  TObjectField_sw = class(TField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TObjectField): OleVariant;
    class function FromVar(const AValue: OleVariant): TObjectField;
    class function ClassToVar(AClass: TObjectField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TObjectField_sc;
  end;

  TADTField_sc = class of TADTField;
  TADTField_sw = class(TObjectField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TADTField): OleVariant;
    class function FromVar(const AValue: OleVariant): TADTField;
    class function ClassToVar(AClass: TADTField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TADTField_sc;
  end;

  TArrayField_sc = class of TArrayField;
  TArrayField_sw = class(TObjectField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TArrayField): OleVariant;
    class function FromVar(const AValue: OleVariant): TArrayField;
    class function ClassToVar(AClass: TArrayField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TArrayField_sc;
  end;

  TDataSetField_sc = class of TDataSetField;
  TDataSetField_sw = class(TObjectField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDataSetField): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSetField;
    class function ClassToVar(AClass: TDataSetField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDataSetField_sc;
  end;

  TReferenceField_sc = class of TReferenceField;
  TReferenceField_sw = class(TDataSetField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TReferenceField): OleVariant;
    class function FromVar(const AValue: OleVariant): TReferenceField;
    class function ClassToVar(AClass: TReferenceField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TReferenceField_sc;
  end;

  TVariantField_sc = class of TVariantField;
  TVariantField_sw = class(TField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TVariantField): OleVariant;
    class function FromVar(const AValue: OleVariant): TVariantField;
    class function ClassToVar(AClass: TVariantField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TVariantField_sc;
  end;

  TInterfaceField_sc = class of TInterfaceField;
  TInterfaceField_sw = class(TField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TInterfaceField): OleVariant;
    class function FromVar(const AValue: OleVariant): TInterfaceField;
    class function ClassToVar(AClass: TInterfaceField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TInterfaceField_sc;
  end;

  TIDispatchField_sc = class of TIDispatchField;
  TIDispatchField_sw = class(TInterfaceField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TIDispatchField): OleVariant;
    class function FromVar(const AValue: OleVariant): TIDispatchField;
    class function ClassToVar(AClass: TIDispatchField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TIDispatchField_sc;
  end;

  TGuidField_sc = class of TGuidField;
  TGuidField_sw = class(TStringField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TGuidField): OleVariant;
    class function FromVar(const AValue: OleVariant): TGuidField;
    class function ClassToVar(AClass: TGuidField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TGuidField_sc;
  end;

  TAggHandle_sw = TObject_sw;

  TAggregateField_sc = class of TAggregateField;
  TAggregateField_sw = class(TField_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TAggregateField): OleVariant;
    class function FromVar(const AValue: OleVariant): TAggregateField;
    class function ClassToVar(AClass: TAggregateField_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TAggregateField_sc;
  end;

  TDataLink_sc = class of TDataLink;
  TDataLink_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDataLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataLink;
    class function ClassToVar(AClass: TDataLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDataLink_sc;
  end;

  TDetailDataLink_sc = class of TDetailDataLink;
  TDetailDataLink_sw = class(TDataLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDetailDataLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TDetailDataLink;
    class function ClassToVar(AClass: TDetailDataLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDetailDataLink_sc;
  end;

  TMasterDataLink_sc = class of TMasterDataLink;
  TMasterDataLink_sw = class(TDetailDataLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMasterDataLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TMasterDataLink;
    class function ClassToVar(AClass: TMasterDataLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMasterDataLink_sc;
  end;

  TDataChangeEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Field: TField);
  end;

  TDataChangeEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDataChangeEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataChangeEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDataChangeEvent;
  end;

  TDataSource_sc = class of TDataSource;
  TDataSource_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDataSource): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSource;
    class function ClassToVar(AClass: TDataSource_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDataSource_sc;
  end;

  TDataSetDesigner_sc = class of TDataSetDesigner;
  TDataSetDesigner_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDataSetDesigner): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSetDesigner;
    class function ClassToVar(AClass: TDataSetDesigner_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDataSetDesigner_sc;
  end;

  TCheckConstraint_sc = class of TCheckConstraint;
  TCheckConstraint_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCheckConstraint): OleVariant;
    class function FromVar(const AValue: OleVariant): TCheckConstraint;
    class function ClassToVar(AClass: TCheckConstraint_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCheckConstraint_sc;
  end;

  TCheckConstraintClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCheckConstraintClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCheckConstraintClass;
  end;

  TCheckConstraints_sc = class of TCheckConstraints;
  TCheckConstraints_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCheckConstraints): OleVariant;
    class function FromVar(const AValue: OleVariant): TCheckConstraints;
    class function ClassToVar(AClass: TCheckConstraints_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCheckConstraints_sc;
  end;

  TCheckConstraintsClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCheckConstraintsClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCheckConstraintsClass;
  end;

  TBitConverter_sc = class of TBitConverter;
  TBitConverter_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBitConverter): OleVariant;
    class function FromVar(const AValue: OleVariant): TBitConverter;
    class function ClassToVar(AClass: TBitConverter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBitConverter_sc;
  end;

  TParamType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TParamType): OleVariant;
    class function FromVar(const AValue: OleVariant): TParamType;
  end;

  TParamTypes_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TParamTypes): OleVariant;
    class function FromVar(const AValue: OleVariant): TParamTypes;
  end;

  TParamObjectClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TParamObjectClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TParamObjectClass;
  end;

  TParam_sc = class of TParam;
  TParam_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TParam): OleVariant;
    class function FromVar(const AValue: OleVariant): TParam;
    class function ClassToVar(AClass: TParam_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TParam_sc;
  end;

  TParamClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TParamClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TParamClass;
  end;

  TParams_sc = class of TParams;
  TParams_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TParams): OleVariant;
    class function FromVar(const AValue: OleVariant): TParams;
    class function ClassToVar(AClass: TParams_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TParams_sc;
  end;

  TParamsClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TParamsClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TParamsClass;
  end;

  TParamObject_sc = class of TParamObject;
  TParamObject_sw = class(TInterfacedObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TParamObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TParamObject;
    class function ClassToVar(AClass: TParamObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TParamObject_sc;
  end;

  TParamStreamObject_sc = class of TParamStreamObject;
  TParamStreamObject_sw = class(TParamObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TParamStreamObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TParamStreamObject;
    class function ClassToVar(AClass: TParamStreamObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TParamStreamObject_sc;
  end;

  TPSCommandType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPSCommandType): OleVariant;
    class function FromVar(const AValue: OleVariant): TPSCommandType;
  end;

  TSQLCommandType_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TSQLCommandType): OleVariant;
    class function FromVar(const AValue: OleVariant): TSQLCommandType;
  end;

  TPacketAttribute_sw = class(TLMDRecordWrapper)
  private
    FValue: TPacketAttribute;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPacketAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): TPacketAttribute;
  end;

  TPacketAttributeList_sw = TList_sw;

  TBookmarkStr_sw = AnsiString_sw;

  TBookmarkFlag_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBookmarkFlag): OleVariant;
    class function FromVar(const AValue: OleVariant): TBookmarkFlag;
  end;

  TRecBuf_sw = NativeInt_sw;

  TGetMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TGetMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetMode;
  end;

  TGetResult_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TGetResult): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetResult;
  end;

  TDataAction_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDataAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataAction;
  end;

  TBlobStreamMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBlobStreamMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TBlobStreamMode;
  end;

  TLocateOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TLocateOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TLocateOption;
  end;

  TLocateOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TLocateOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TLocateOptions;
  end;

  TDataOperation_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler;
  end;

  TDataOperation_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDataOperation): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataOperation;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDataOperation;
  end;

  TDataSetNotifyEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DataSet: TDataSet);
  end;

  TDataSetNotifyEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDataSetNotifyEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSetNotifyEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDataSetNotifyEvent;
  end;

  TDataSetErrorEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
  end;

  TDataSetErrorEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDataSetErrorEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSetErrorEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDataSetErrorEvent;
  end;

  TFilterOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFilterOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TFilterOption;
  end;

  TFilterOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFilterOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TFilterOptions;
  end;

  TFilterRecordEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DataSet: TDataSet; var Accept: Boolean);
  end;

  TFilterRecordEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFilterRecordEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFilterRecordEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFilterRecordEvent;
  end;

  TGroupPosInd_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TGroupPosInd): OleVariant;
    class function FromVar(const AValue: OleVariant): TGroupPosInd;
  end;

  TGroupPosInds_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TGroupPosInds): OleVariant;
    class function FromVar(const AValue: OleVariant): TGroupPosInds;
  end;

  TDataSetClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TDataSetClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSetClass;
  end;

  TDataSet_sc = class of TDataSet;
  TDataSet_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDataSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSet;
    class function ClassToVar(AClass: TDataSet_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDataSet_sc;
  end;

  TDateTimeAlias_sw = class(TDateTime_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDateTimeAlias): OleVariant;
    class function FromVar(const AValue: OleVariant): TDateTimeAlias;
  end;

  TDateTimeRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TDateTimeRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TDateTimeRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TDateTimeRec;
  end;

  TDBScreenCursor_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDBScreenCursor): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBScreenCursor;
  end;


{ Unit wrapper }

type
  DB_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCustomConnection_sacc = class(TCustomConnection);
  TDefCollection_sacc = class(TDefCollection);
  TFlatList_sacc = class(TFlatList);
  TFields_sacc = class(TFields);
  TDataLink_sacc = class(TDataLink);
  TParam_sacc = class(TParam);
  TDataSet_sacc = class(TDataSet);

{ EDatabaseError_sw }

class function EDatabaseError_sw.GetTypeName: WideString;
begin
  Result := 'EDatabaseError';
end;

class function EDatabaseError_sw.GetWrappedClass: TClass;
begin
  Result := EDatabaseError;
end;

class procedure EDatabaseError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EDatabaseError_sw.ToVar(
  const AValue: EDatabaseError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EDatabaseError_sw.FromVar(
  const AValue: OleVariant): EDatabaseError;
begin
  Result := EDatabaseError(ConvFromVar(AValue, EDatabaseError));
end;

class function EDatabaseError_sw.ClassToVar(
  AClass: EDatabaseError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EDatabaseError_sw.ClassFromVar(
  const AClass: OleVariant): EDatabaseError_sc;
begin
  Result := EDatabaseError_sc(ConvClsFromVar(AClass, EDatabaseError));
end;

{ EUpdateError_sw }

function EUpdateError_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(NativeError: string; Context: string; ...

  Result := EUpdateError_sw.ToVar(EUpdateError_sc(AObj).Create(string(AArgs[0]),
    string(AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3]), Exception_sw.FromVar(
    AArgs[4])));
end;

function EUpdateError_Context_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Context: string read <getter>;

  Result := EUpdateError(AObj).Context;
end;

function EUpdateError_ErrorCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ErrorCode: Integer read <getter>;

  Result := EUpdateError(AObj).ErrorCode;
end;

function EUpdateError_PreviousError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PreviousError: Integer read <getter>;

  Result := EUpdateError(AObj).PreviousError;
end;

function EUpdateError_OriginalException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OriginalException: Exception read <getter>;

  Result := Exception_sw.ToVar(EUpdateError(AObj).OriginalException);
end;

class function EUpdateError_sw.GetTypeName: WideString;
begin
  Result := 'EUpdateError';
end;

class function EUpdateError_sw.GetWrappedClass: TClass;
begin
  Result := EUpdateError;
end;

class procedure EUpdateError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Context', EUpdateError_Context_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('ErrorCode', EUpdateError_ErrorCode_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('PreviousError', EUpdateError_PreviousError_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('OriginalException', EUpdateError_OriginalException_si, Exception_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', EUpdateError_Create_si, 5, False);
end;

class function EUpdateError_sw.ToVar(const AValue: EUpdateError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EUpdateError_sw.FromVar(const AValue: OleVariant): EUpdateError;
begin
  Result := EUpdateError(ConvFromVar(AValue, EUpdateError));
end;

class function EUpdateError_sw.ClassToVar(AClass: EUpdateError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EUpdateError_sw.ClassFromVar(
  const AClass: OleVariant): EUpdateError_sc;
begin
  Result := EUpdateError_sc(ConvClsFromVar(AClass, EUpdateError));
end;

{ TFieldType_sw }

class function TFieldType_sw.GetTypeName: WideString;
begin
  Result := 'TFieldType';
end;

class procedure TFieldType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..51] of TLMDEnumerator = (
    (Name: 'ftUnknown'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftUnknown)),
    (Name: 'ftString'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftString)),
    (Name: 'ftSmallint'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftSmallint)),
    (Name: 'ftInteger'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftInteger)),
    (Name: 'ftWord'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftWord)),
    (Name: 'ftBoolean'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftBoolean)),
    (Name: 'ftFloat'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftFloat)),
    (Name: 'ftCurrency'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftCurrency)),
    (Name: 'ftBCD'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftBCD)),
    (Name: 'ftDate'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftDate)),
    (Name: 'ftTime'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftTime)),
    (Name: 'ftDateTime'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftDateTime)),
    (Name: 'ftBytes'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftBytes)),
    (Name: 'ftVarBytes'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftVarBytes)),
    (Name: 'ftAutoInc'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftAutoInc)),
    (Name: 'ftBlob'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftBlob)),
    (Name: 'ftMemo'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftMemo)),
    (Name: 'ftGraphic'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftGraphic)),
    (Name: 'ftFmtMemo'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftFmtMemo)),
    (Name: 'ftParadoxOle'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftParadoxOle)),
    (Name: 'ftDBaseOle'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftDBaseOle)),
    (Name: 'ftTypedBinary'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftTypedBinary)),
    (Name: 'ftCursor'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftCursor)),
    (Name: 'ftFixedChar'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftFixedChar)),
    (Name: 'ftWideString'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftWideString)),
    (Name: 'ftLargeint'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftLargeint)),
    (Name: 'ftADT'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftADT)),
    (Name: 'ftArray'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftArray)),
    (Name: 'ftReference'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftReference)),
    (Name: 'ftDataSet'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftDataSet)),
    (Name: 'ftOraBlob'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftOraBlob)),
    (Name: 'ftOraClob'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftOraClob)),
    (Name: 'ftVariant'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftVariant)),
    (Name: 'ftInterface'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftInterface)),
    (Name: 'ftIDispatch'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftIDispatch)),
    (Name: 'ftGuid'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftGuid)),
    (Name: 'ftTimeStamp'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftTimeStamp)),
    (Name: 'ftFMTBcd'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftFMTBcd)),
    (Name: 'ftFixedWideChar'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftFixedWideChar)),
    (Name: 'ftWideMemo'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftWideMemo)),
    (Name: 'ftOraTimeStamp'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftOraTimeStamp)),
    (Name: 'ftOraInterval'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftOraInterval)),
    (Name: 'ftLongWord'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftLongWord)),
    (Name: 'ftShortint'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftShortint)),
    (Name: 'ftByte'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftByte)),
    (Name: 'ftExtended'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftExtended)),
    (Name: 'ftConnection'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftConnection)),
    (Name: 'ftParams'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftParams)),
    (Name: 'ftStream'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftStream)),
    (Name: 'ftTimeStampOffset'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftTimeStampOffset)),
    (Name: 'ftObject'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftObject)),
    (Name: 'ftSingle'; Value: Integer({$IFDEF LMDSCT_12}TFieldType.{$ENDIF}ftSingle))
  );
begin
  AEnums := @ENUMS;
  ACount := 52;
end;

class function TFieldType_sw.ToVar(const AValue: TFieldType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFieldType_sw.FromVar(const AValue: OleVariant): TFieldType;
begin
  Result := TFieldType(Integer(AValue));
end;

{ TDataSetState_sw }

class function TDataSetState_sw.GetTypeName: WideString;
begin
  Result := 'TDataSetState';
end;

class procedure TDataSetState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..12] of TLMDEnumerator = (
    (Name: 'dsInactive'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsInactive)),
    (Name: 'dsBrowse'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsBrowse)),
    (Name: 'dsEdit'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsEdit)),
    (Name: 'dsInsert'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsInsert)),
    (Name: 'dsSetKey'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsSetKey)),
    (Name: 'dsCalcFields'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsCalcFields)),
    (Name: 'dsFilter'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsFilter)),
    (Name: 'dsNewValue'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsNewValue)),
    (Name: 'dsOldValue'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsOldValue)),
    (Name: 'dsCurValue'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsCurValue)),
    (Name: 'dsBlockRead'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsBlockRead)),
    (Name: 'dsInternalCalc'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsInternalCalc)),
    (Name: 'dsOpening'; Value: Integer({$IFDEF LMDSCT_12}TDataSetState.{$ENDIF}dsOpening))
  );
begin
  AEnums := @ENUMS;
  ACount := 13;
end;

class function TDataSetState_sw.ToVar(const AValue: TDataSetState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDataSetState_sw.FromVar(
  const AValue: OleVariant): TDataSetState;
begin
  Result := TDataSetState(Integer(AValue));
end;

{ TDataEvent_sw }

class function TDataEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDataEvent';
end;

class procedure TDataEvent_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..14] of TLMDEnumerator = (
    (Name: 'deFieldChange'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deFieldChange)),
    (Name: 'deRecordChange'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deRecordChange)),
    (Name: 'deDataSetChange'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deDataSetChange)),
    (Name: 'deDataSetScroll'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deDataSetScroll)),
    (Name: 'deLayoutChange'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deLayoutChange)),
    (Name: 'deUpdateRecord'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deUpdateRecord)),
    (Name: 'deUpdateState'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deUpdateState)),
    (Name: 'deCheckBrowseMode'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deCheckBrowseMode)),
    (Name: 'dePropertyChange'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}dePropertyChange)),
    (Name: 'deFieldListChange'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deFieldListChange)),
    (Name: 'deFocusControl'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deFocusControl)),
    (Name: 'deParentScroll'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deParentScroll)),
    (Name: 'deConnectChange'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deConnectChange)),
    (Name: 'deReconcileError'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deReconcileError)),
    (Name: 'deDisabledStateChange'; Value: Integer({$IFDEF LMDSCT_12}TDataEvent.{$ENDIF}deDisabledStateChange))
  );
begin
  AEnums := @ENUMS;
  ACount := 15;
end;

class function TDataEvent_sw.ToVar(const AValue: TDataEvent): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDataEvent_sw.FromVar(const AValue: OleVariant): TDataEvent;
begin
  Result := TDataEvent(Integer(AValue));
end;

{ TUpdateStatus_sw }

class function TUpdateStatus_sw.GetTypeName: WideString;
begin
  Result := 'TUpdateStatus';
end;

class procedure TUpdateStatus_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'usUnmodified'; Value: Integer({$IFDEF LMDSCT_12}TUpdateStatus.{$ENDIF}usUnmodified)),
    (Name: 'usModified'; Value: Integer({$IFDEF LMDSCT_12}TUpdateStatus.{$ENDIF}usModified)),
    (Name: 'usInserted'; Value: Integer({$IFDEF LMDSCT_12}TUpdateStatus.{$ENDIF}usInserted)),
    (Name: 'usDeleted'; Value: Integer({$IFDEF LMDSCT_12}TUpdateStatus.{$ENDIF}usDeleted))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TUpdateStatus_sw.ToVar(const AValue: TUpdateStatus): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TUpdateStatus_sw.FromVar(
  const AValue: OleVariant): TUpdateStatus;
begin
  Result := TUpdateStatus(Integer(AValue));
end;

{ TUpdateStatusSet_sw }

class function TUpdateStatusSet_sw.GetTypeName: WideString;
begin
  Result := 'TUpdateStatusSet';
end;

class function TUpdateStatusSet_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TUpdateStatusSet);
end;

class function TUpdateStatusSet_sw.ToVar(
  const AValue: TUpdateStatusSet): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TUpdateStatusSet_sw.FromVar(
  const AValue: OleVariant): TUpdateStatusSet;
begin
  ConvFromVar(AValue, @Result);
end;

{ TUpdateAction_sw }

class function TUpdateAction_sw.GetTypeName: WideString;
begin
  Result := 'TUpdateAction';
end;

class procedure TUpdateAction_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'uaFail'; Value: Integer({$IFDEF LMDSCT_12}TUpdateAction.{$ENDIF}uaFail)),
    (Name: 'uaAbort'; Value: Integer({$IFDEF LMDSCT_12}TUpdateAction.{$ENDIF}uaAbort)),
    (Name: 'uaSkip'; Value: Integer({$IFDEF LMDSCT_12}TUpdateAction.{$ENDIF}uaSkip)),
    (Name: 'uaRetry'; Value: Integer({$IFDEF LMDSCT_12}TUpdateAction.{$ENDIF}uaRetry)),
    (Name: 'uaApplied'; Value: Integer({$IFDEF LMDSCT_12}TUpdateAction.{$ENDIF}uaApplied))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TUpdateAction_sw.ToVar(const AValue: TUpdateAction): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TUpdateAction_sw.FromVar(
  const AValue: OleVariant): TUpdateAction;
begin
  Result := TUpdateAction(Integer(AValue));
end;

{ TUpdateMode_sw }

class function TUpdateMode_sw.GetTypeName: WideString;
begin
  Result := 'TUpdateMode';
end;

class procedure TUpdateMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'upWhereAll'; Value: Integer({$IFDEF LMDSCT_12}TUpdateMode.{$ENDIF}upWhereAll)),
    (Name: 'upWhereChanged'; Value: Integer({$IFDEF LMDSCT_12}TUpdateMode.{$ENDIF}upWhereChanged)),
    (Name: 'upWhereKeyOnly'; Value: Integer({$IFDEF LMDSCT_12}TUpdateMode.{$ENDIF}upWhereKeyOnly))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TUpdateMode_sw.ToVar(const AValue: TUpdateMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TUpdateMode_sw.FromVar(const AValue: OleVariant): TUpdateMode;
begin
  Result := TUpdateMode(Integer(AValue));
end;

{ TUpdateKind_sw }

class function TUpdateKind_sw.GetTypeName: WideString;
begin
  Result := 'TUpdateKind';
end;

class procedure TUpdateKind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'ukModify'; Value: Integer({$IFDEF LMDSCT_12}TUpdateKind.{$ENDIF}ukModify)),
    (Name: 'ukInsert'; Value: Integer({$IFDEF LMDSCT_12}TUpdateKind.{$ENDIF}ukInsert)),
    (Name: 'ukDelete'; Value: Integer({$IFDEF LMDSCT_12}TUpdateKind.{$ENDIF}ukDelete))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TUpdateKind_sw.ToVar(const AValue: TUpdateKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TUpdateKind_sw.FromVar(const AValue: OleVariant): TUpdateKind;
begin
  Result := TUpdateKind(Integer(AValue));
end;

{ TUpdateErrorEvent_sh }

function TUpdateErrorEvent_sh.GetHandler: TMethod;
var
  hdr: TUpdateErrorEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TUpdateErrorEvent_sh.Handler(DataSet: TDataSet; E: EDatabaseError;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (DataSet: TDataSet; E: EDatabaseError; UpdateKi...

  v_1 := TUpdateAction_sw.ToVar(UpdateAction);
  args[0] := TDataSet_sw.ToVar(DataSet);
  args[1] := EDatabaseError_sw.ToVar(E);
  args[2] := TUpdateKind_sw.ToVar(UpdateKind);
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  UpdateAction := TUpdateAction_sw.FromVar(v_1);
end;

{ TUpdateErrorEvent_sw }

class function TUpdateErrorEvent_sw.GetTypeName: WideString;
begin
  Result := 'TUpdateErrorEvent';
end;

class function TUpdateErrorEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TUpdateErrorEvent_sh;
end;

class function TUpdateErrorEvent_sw.ToVar(
  const AValue: TUpdateErrorEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TUpdateErrorEvent_sw.FromVar(
  const AValue: OleVariant): TUpdateErrorEvent;
begin
  Result := TUpdateErrorEvent(ConvFromVar(AValue));
end;

class function TUpdateErrorEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TUpdateErrorEvent;
var
  hdlr: TUpdateErrorEvent_sh;
begin
  hdlr   := TUpdateErrorEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TUpdateErrorEvent_sw));
  Result := hdlr.Handler;
end;

{ TUpdateRecordEvent_sh }

function TUpdateRecordEvent_sh.GetHandler: TMethod;
var
  hdr: TUpdateRecordEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TUpdateRecordEvent_sh.Handler(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (DataSet: TDataSet; UpdateKind: TUpdateKind; va...

  v_1 := TUpdateAction_sw.ToVar(UpdateAction);
  args[0] := TDataSet_sw.ToVar(DataSet);
  args[1] := TUpdateKind_sw.ToVar(UpdateKind);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  UpdateAction := TUpdateAction_sw.FromVar(v_1);
end;

{ TUpdateRecordEvent_sw }

class function TUpdateRecordEvent_sw.GetTypeName: WideString;
begin
  Result := 'TUpdateRecordEvent';
end;

class function TUpdateRecordEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TUpdateRecordEvent_sh;
end;

class function TUpdateRecordEvent_sw.ToVar(
  const AValue: TUpdateRecordEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TUpdateRecordEvent_sw.FromVar(
  const AValue: OleVariant): TUpdateRecordEvent;
begin
  Result := TUpdateRecordEvent(ConvFromVar(AValue));
end;

class function TUpdateRecordEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TUpdateRecordEvent;
var
  hdlr: TUpdateRecordEvent_sh;
begin
  hdlr   := TUpdateRecordEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TUpdateRecordEvent_sw));
  Result := hdlr.Handler;
end;

{ TConnectChangeEvent_sh }

function TConnectChangeEvent_sh.GetHandler: TMethod;
var
  hdr: TConnectChangeEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TConnectChangeEvent_sh.Handler(Sender: TObject; Connecting: Boolean);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Connecting: Boolean) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := Connecting;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TConnectChangeEvent_sw }

class function TConnectChangeEvent_sw.GetTypeName: WideString;
begin
  Result := 'TConnectChangeEvent';
end;

class function TConnectChangeEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TConnectChangeEvent_sh;
end;

class function TConnectChangeEvent_sw.ToVar(
  const AValue: TConnectChangeEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TConnectChangeEvent_sw.FromVar(
  const AValue: OleVariant): TConnectChangeEvent;
begin
  Result := TConnectChangeEvent(ConvFromVar(AValue));
end;

class function TConnectChangeEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TConnectChangeEvent;
var
  hdlr: TConnectChangeEvent_sh;
begin
  hdlr   := TConnectChangeEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TConnectChangeEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomConnection_sw }

function TCustomConnection_StreamedConnected_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property StreamedConnected: Boolean read <gette...

  if IsGet then
    Result := TCustomConnection_sacc(TCustomConnection(AObj)).StreamedConnected
  else
    TCustomConnection_sacc(TCustomConnection(AObj)).StreamedConnected := 
      Boolean(AArgs[0]);
end;

function TCustomConnection_Open_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Open(...); overload;

  TCustomConnection(AObj).Open();
end;

function TCustomConnection_Close_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Close;

  TCustomConnection(AObj).Close();
end;

function TCustomConnection_Connected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Connected: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomConnection(AObj).Connected
  else
    TCustomConnection(AObj).Connected := Boolean(AArgs[0]);
end;

function TCustomConnection_DataSets_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSets[Index: Integer]: TDataSet read <getter>;

  Result := TDataSet_sw.ToVar(TCustomConnection(AObj).DataSets[Integer(
    AArgs[0])]);
end;

function TCustomConnection_DataSetCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSetCount: Integer read <getter>;

  Result := TCustomConnection(AObj).DataSetCount;
end;

function TCustomConnection_LoginPrompt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LoginPrompt: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomConnection(AObj).LoginPrompt
  else
    TCustomConnection(AObj).LoginPrompt := Boolean(AArgs[0]);
end;

function TCustomConnection_AfterConnect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterConnect: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomConnection(AObj).AfterConnect)
  else
    TCustomConnection(AObj).AfterConnect := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomConnection_BeforeConnect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeConnect: TNotifyEvent read <getter> write ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomConnection(AObj).BeforeConnect)
  else
    TCustomConnection(AObj).BeforeConnect := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomConnection_AfterDisconnect_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterDisconnect: TNotifyEvent read <getter> writ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomConnection(AObj).AfterDisconnect)
  else
    TCustomConnection(AObj).AfterDisconnect := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomConnection_BeforeDisconnect_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeDisconnect: TNotifyEvent read <getter> wri...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomConnection(AObj).BeforeDisconnect)
  else
    TCustomConnection(AObj).BeforeDisconnect := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomConnection_OnLogin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnLogin: TLoginEvent read <getter> write <setter>;

  if IsGet then
    Result := TLoginEvent_sw.ToVar(TCustomConnection(AObj).OnLogin)
  else
    TCustomConnection(AObj).OnLogin := TLoginEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomConnection_sw.GetTypeName: WideString;
begin
  Result := 'TCustomConnection';
end;

class function TCustomConnection_sw.GetWrappedClass: TClass;
begin
  Result := TCustomConnection;
end;

class procedure TCustomConnection_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('StreamedConnected', TCustomConnection_StreamedConnected_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProcedure('Open', TCustomConnection_Open_si, 0, False);
  AData.AddProcedure('Close', TCustomConnection_Close_si, 0, False);
  AData.AddProperty('Connected', TCustomConnection_Connected_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('DataSets', TCustomConnection_DataSets_si, TDataSet_sw, True, False, 1, False, False);
  AData.AddProperty('DataSetCount', TCustomConnection_DataSetCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('LoginPrompt', TCustomConnection_LoginPrompt_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AfterConnect', TCustomConnection_AfterConnect_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('BeforeConnect', TCustomConnection_BeforeConnect_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('AfterDisconnect', TCustomConnection_AfterDisconnect_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('BeforeDisconnect', TCustomConnection_BeforeDisconnect_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnLogin', TCustomConnection_OnLogin_si, TLoginEvent_sw, True, True, 0, False, False);
end;

class function TCustomConnection_sw.ToVar(
  const AValue: TCustomConnection): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomConnection_sw.FromVar(
  const AValue: OleVariant): TCustomConnection;
begin
  Result := TCustomConnection(ConvFromVar(AValue, TCustomConnection));
end;

class function TCustomConnection_sw.ClassToVar(
  AClass: TCustomConnection_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomConnection_sw.ClassFromVar(
  const AClass: OleVariant): TCustomConnection_sc;
begin
  Result := TCustomConnection_sc(ConvClsFromVar(AClass, TCustomConnection));
end;

{ TNamedItem_sw }

function TNamedItem_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Name: string read <getter> write <setter>;

  if IsGet then
    Result := TNamedItem(AObj).Name
  else
    TNamedItem(AObj).Name := string(AArgs[0]);
end;

class function TNamedItem_sw.GetTypeName: WideString;
begin
  Result := 'TNamedItem';
end;

class function TNamedItem_sw.GetWrappedClass: TClass;
begin
  Result := TNamedItem;
end;

class procedure TNamedItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Name', TNamedItem_Name_si, string_sw, True, True, 0, False, False);
end;

class function TNamedItem_sw.ToVar(const AValue: TNamedItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TNamedItem_sw.FromVar(const AValue: OleVariant): TNamedItem;
begin
  Result := TNamedItem(ConvFromVar(AValue, TNamedItem));
end;

class function TNamedItem_sw.ClassToVar(AClass: TNamedItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TNamedItem_sw.ClassFromVar(
  const AClass: OleVariant): TNamedItem_sc;
begin
  Result := TNamedItem_sc(ConvClsFromVar(AClass, TNamedItem));
end;

{ TDefUpdateMethod_sh }

function TDefUpdateMethod_sh.GetHandler: TMethod;
var
  hdr: TDefUpdateMethod;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDefUpdateMethod_sh.Handler;
begin
  // procedure  of object

  Self.Owner.RunProc(Self.ProcName);
end;

{ TDefUpdateMethod_sw }

class function TDefUpdateMethod_sw.GetTypeName: WideString;
begin
  Result := 'TDefUpdateMethod';
end;

class function TDefUpdateMethod_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDefUpdateMethod_sh;
end;

class function TDefUpdateMethod_sw.ToVar(
  const AValue: TDefUpdateMethod): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDefUpdateMethod_sw.FromVar(
  const AValue: OleVariant): TDefUpdateMethod;
begin
  Result := TDefUpdateMethod(ConvFromVar(AValue));
end;

class function TDefUpdateMethod_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TDefUpdateMethod;
var
  hdlr: TDefUpdateMethod_sh;
begin
  hdlr   := TDefUpdateMethod_sh(AScriptControl.GetEventHandler(AProcName, 
    TDefUpdateMethod_sw));
  Result := hdlr.Handler;
end;

{ TDefCollection_sw }

function TDefCollection_OnUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnUpdate: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TDefCollection_sacc(TDefCollection(AObj)).
      OnUpdate)
  else
    TDefCollection_sacc(TDefCollection(AObj)).OnUpdate := TNotifyEvent_sw.
      FromVar(AArgs[0]);
end;

function TDefCollection_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ADataSet: TDataSet; AOwner: TPersisten...

  Result := TDefCollection_sw.ToVar(TDefCollection_sc(AObj).Create(TDataSet_sw.
    FromVar(AArgs[0]), TPersistent_sw.FromVar(AArgs[1]), TCollectionItemClass_sw.
    FromVar(AArgs[2])));
end;

function TDefCollection_Find_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Find(const AName: string): TNamedItem;

  Result := TNamedItem_sw.ToVar(TDefCollection(AObj).Find(string(AArgs[0])));
end;

function TDefCollection_GetItemNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetItemNames(List: TStrings);

  TDefCollection(AObj).GetItemNames(TStrings_sw.FromVar(AArgs[0]));
end;

function TDefCollection_IndexOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOf(const AName: string): Integer;

  Result := TDefCollection(AObj).IndexOf(string(AArgs[0]));
end;

function TDefCollection_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSet: TDataSet read <getter>;

  Result := TDataSet_sw.ToVar(TDefCollection(AObj).DataSet);
end;

function TDefCollection_Updated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Updated: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDefCollection(AObj).Updated
  else
    TDefCollection(AObj).Updated := Boolean(AArgs[0]);
end;

class function TDefCollection_sw.GetTypeName: WideString;
begin
  Result := 'TDefCollection';
end;

class function TDefCollection_sw.GetWrappedClass: TClass;
begin
  Result := TDefCollection;
end;

class procedure TDefCollection_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('OnUpdate', TDefCollection_OnUpdate_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddFunction('Find', TDefCollection_Find_si, TNamedItem_sw, 1, False);
  AData.AddProcedure('GetItemNames', TDefCollection_GetItemNames_si, 1, False);
  AData.AddFunction('IndexOf', TDefCollection_IndexOf_si, Integer_sw, 1, False);
  AData.AddProperty('DataSet', TDefCollection_DataSet_si, TDataSet_sw, True, False, 0, False, False);
  AData.AddProperty('Updated', TDefCollection_Updated_si, Boolean_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TDefCollection_Create_si, 3, False);
end;

class function TDefCollection_sw.ToVar(
  const AValue: TDefCollection): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDefCollection_sw.FromVar(
  const AValue: OleVariant): TDefCollection;
begin
  Result := TDefCollection(ConvFromVar(AValue, TDefCollection));
end;

class function TDefCollection_sw.ClassToVar(
  AClass: TDefCollection_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDefCollection_sw.ClassFromVar(
  const AClass: OleVariant): TDefCollection_sc;
begin
  Result := TDefCollection_sc(ConvClsFromVar(AClass, TDefCollection));
end;

{ TFieldClass_sw }

class function TFieldClass_sw.GetTypeName: WideString;
begin
  Result := 'TFieldClass';
end;

class function TFieldClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TField;
end;

class function TFieldClass_sw.ToVar(const AValue: TFieldClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFieldClass_sw.FromVar(const AValue: OleVariant): TFieldClass;
begin
  Result := TFieldClass(ConvFromVar(AValue, TField));
end;

{ TFieldAttribute_sw }

class function TFieldAttribute_sw.GetTypeName: WideString;
begin
  Result := 'TFieldAttribute';
end;

class procedure TFieldAttribute_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'faHiddenCol'; Value: Integer({$IFDEF LMDSCT_12}TFieldAttribute.{$ENDIF}faHiddenCol)),
    (Name: 'faReadonly'; Value: Integer({$IFDEF LMDSCT_12}TFieldAttribute.{$ENDIF}faReadonly)),
    (Name: 'faRequired'; Value: Integer({$IFDEF LMDSCT_12}TFieldAttribute.{$ENDIF}faRequired)),
    (Name: 'faLink'; Value: Integer({$IFDEF LMDSCT_12}TFieldAttribute.{$ENDIF}faLink)),
    (Name: 'faUnNamed'; Value: Integer({$IFDEF LMDSCT_12}TFieldAttribute.{$ENDIF}faUnNamed)),
    (Name: 'faFixed'; Value: Integer({$IFDEF LMDSCT_12}TFieldAttribute.{$ENDIF}faFixed))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TFieldAttribute_sw.ToVar(
  const AValue: TFieldAttribute): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFieldAttribute_sw.FromVar(
  const AValue: OleVariant): TFieldAttribute;
begin
  Result := TFieldAttribute(Integer(AValue));
end;

{ TFieldAttributes_sw }

class function TFieldAttributes_sw.GetTypeName: WideString;
begin
  Result := 'TFieldAttributes';
end;

class function TFieldAttributes_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFieldAttributes);
end;

class function TFieldAttributes_sw.ToVar(
  const AValue: TFieldAttributes): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFieldAttributes_sw.FromVar(
  const AValue: OleVariant): TFieldAttributes;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFieldDefsClass_sw }

class function TFieldDefsClass_sw.GetTypeName: WideString;
begin
  Result := 'TFieldDefsClass';
end;

class function TFieldDefsClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TFieldDefs;
end;

class function TFieldDefsClass_sw.ToVar(
  const AValue: TFieldDefsClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFieldDefsClass_sw.FromVar(
  const AValue: OleVariant): TFieldDefsClass;
begin
  Result := TFieldDefsClass(ConvFromVar(AValue, TFieldDefs));
end;

{ TFieldDef_sw }

function TFieldDef_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  Result := TFieldDef_sw.ToVar(TFieldDef_sc(AObj).Create(TFieldDefs_sw.FromVar(
    AArgs[0]), string(AArgs[1]), TFieldType_sw.FromVar(AArgs[2]), Integer(
    AArgs[3]), Boolean(AArgs[4]), Integer(AArgs[5])));
end;

function TFieldDef_AddChild_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddChild: TFieldDef;

  Result := TFieldDef_sw.ToVar(TFieldDef(AObj).AddChild());
end;

function TFieldDef_CreateField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CreateField(Owner: TComponent; ParentField: TObj...

  case AArgsSize of
    1:
    begin
      Result := TField_sw.ToVar(TFieldDef(AObj).CreateField(TComponent_sw.
        FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TField_sw.ToVar(TFieldDef(AObj).CreateField(TComponent_sw.
        FromVar(AArgs[0]), TObjectField_sw.FromVar(AArgs[1])));
    end;
    3:
    begin
      Result := TField_sw.ToVar(TFieldDef(AObj).CreateField(TComponent_sw.
        FromVar(AArgs[0]), TObjectField_sw.FromVar(AArgs[1]), string(AArgs[2])));
    end;
    4:
    begin
      Result := TField_sw.ToVar(TFieldDef(AObj).CreateField(TComponent_sw.
        FromVar(AArgs[0]), TObjectField_sw.FromVar(AArgs[1]), string(AArgs[2]),
        Boolean(AArgs[3])));
    end;
  else
    WrongArgCountError('CreateField');
  end;
end;

function TFieldDef_HasChildDefs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HasChildDefs: Boolean;

  Result := TFieldDef(AObj).HasChildDefs();
end;

function TFieldDef_FieldClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldClass: TFieldClass read <getter>;

  Result := TFieldClass_sw.ToVar(TFieldDef(AObj).FieldClass);
end;

function TFieldDef_FieldNo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldNo: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFieldDef(AObj).FieldNo
  else
    TFieldDef(AObj).FieldNo := Integer(AArgs[0]);
end;

function TFieldDef_InternalCalcField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property InternalCalcField: Boolean read <getter> write <...

  if IsGet then
    Result := TFieldDef(AObj).InternalCalcField
  else
    TFieldDef(AObj).InternalCalcField := Boolean(AArgs[0]);
end;

function TFieldDef_ParentDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentDef: TFieldDef read <getter>;

  Result := TFieldDef_sw.ToVar(TFieldDef(AObj).ParentDef);
end;

function TFieldDef_Required_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Required: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TFieldDef(AObj).Required
  else
    TFieldDef(AObj).Required := Boolean(AArgs[0]);
end;

function TFieldDef_Attributes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Attributes: TFieldAttributes read <getter> write...

  if IsGet then
    Result := TFieldAttributes_sw.ToVar(TFieldDef(AObj).Attributes)
  else
    TFieldDef(AObj).Attributes := TFieldAttributes_sw.FromVar(AArgs[0]);
end;

function TFieldDef_ChildDefs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ChildDefs: TFieldDefs read <getter> write <setter>;

  if IsGet then
    Result := TFieldDefs_sw.ToVar(TFieldDef(AObj).ChildDefs)
  else
    TFieldDef(AObj).ChildDefs := TFieldDefs_sw.FromVar(AArgs[0]);
end;

function TFieldDef_DataType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataType: TFieldType read <getter> write <setter>;

  if IsGet then
    Result := TFieldType_sw.ToVar(TFieldDef(AObj).DataType)
  else
    TFieldDef(AObj).DataType := TFieldType_sw.FromVar(AArgs[0]);
end;

function TFieldDef_Precision_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Precision: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFieldDef(AObj).Precision
  else
    TFieldDef(AObj).Precision := Integer(AArgs[0]);
end;

function TFieldDef_Size_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Size: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFieldDef(AObj).Size
  else
    TFieldDef(AObj).Size := Integer(AArgs[0]);
end;

class function TFieldDef_sw.GetTypeName: WideString;
begin
  Result := 'TFieldDef';
end;

class function TFieldDef_sw.GetWrappedClass: TClass;
begin
  Result := TFieldDef;
end;

class procedure TFieldDef_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('AddChild', TFieldDef_AddChild_si, TFieldDef_sw, 0, False);
  AData.AddFunction('CreateField', TFieldDef_CreateField_si, TField_sw, 1, True);
  AData.AddFunction('HasChildDefs', TFieldDef_HasChildDefs_si, Boolean_sw, 0, False);
  AData.AddProperty('FieldClass', TFieldDef_FieldClass_si, TFieldClass_sw, True, False, 0, False, False);
  AData.AddProperty('FieldNo', TFieldDef_FieldNo_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('InternalCalcField', TFieldDef_InternalCalcField_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ParentDef', TFieldDef_ParentDef_si, TFieldDef_sw, True, False, 0, False, False);
  AData.AddProperty('Required', TFieldDef_Required_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Attributes', TFieldDef_Attributes_si, TFieldAttributes_sw, True, True, 0, False, False);
  AData.AddProperty('ChildDefs', TFieldDef_ChildDefs_si, TFieldDefs_sw, True, True, 0, False, False);
  AData.AddProperty('DataType', TFieldDef_DataType_si, TFieldType_sw, True, True, 0, False, False);
  AData.AddProperty('Precision', TFieldDef_Precision_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Size', TFieldDef_Size_si, Integer_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TFieldDef_Create_si, 6, False);
end;

class function TFieldDef_sw.ToVar(const AValue: TFieldDef): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFieldDef_sw.FromVar(const AValue: OleVariant): TFieldDef;
begin
  Result := TFieldDef(ConvFromVar(AValue, TFieldDef));
end;

class function TFieldDef_sw.ClassToVar(AClass: TFieldDef_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFieldDef_sw.ClassFromVar(
  const AClass: OleVariant): TFieldDef_sc;
begin
  Result := TFieldDef_sc(ConvClsFromVar(AClass, TFieldDef));
end;

{ TFieldDefClass_sw }

class function TFieldDefClass_sw.GetTypeName: WideString;
begin
  Result := 'TFieldDefClass';
end;

class function TFieldDefClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TFieldDef;
end;

class function TFieldDefClass_sw.ToVar(
  const AValue: TFieldDefClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFieldDefClass_sw.FromVar(
  const AValue: OleVariant): TFieldDefClass;
begin
  Result := TFieldDefClass(ConvFromVar(AValue, TFieldDef));
end;

{ TFieldDefs_sw }

function TFieldDefs_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TPersistent);

  Result := TFieldDefs_sw.ToVar(TFieldDefs_sc(AObj).Create(TPersistent_sw.
    FromVar(AArgs[0])));
end;

function TFieldDefs_AddFieldDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddFieldDef: TFieldDef;

  Result := TFieldDef_sw.ToVar(TFieldDefs(AObj).AddFieldDef());
end;

function TFieldDefs_Find_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Find(const Name: string): TFieldDef;

  Result := TFieldDef_sw.ToVar(TFieldDefs(AObj).Find(string(AArgs[0])));
end;

function TFieldDefs_Update_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Update;

  TFieldDefs(AObj).Update();
end;

function TFieldDefs_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Add(const Name: string; DataType: TFieldType; S...

  case AArgsSize of
    2:
    begin
      TFieldDefs(AObj).Add(string(AArgs[0]), TFieldType_sw.FromVar(AArgs[1]));
    end;
    3:
    begin
      TFieldDefs(AObj).Add(string(AArgs[0]), TFieldType_sw.FromVar(AArgs[1]), 
        Integer(AArgs[2]));
    end;
    4:
    begin
      TFieldDefs(AObj).Add(string(AArgs[0]), TFieldType_sw.FromVar(AArgs[1]), 
        Integer(AArgs[2]), Boolean(AArgs[3]));
    end;
  else
    WrongArgCountError('Add');
  end;
end;

function TFieldDefs_HiddenFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HiddenFields: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TFieldDefs(AObj).HiddenFields
  else
    TFieldDefs(AObj).HiddenFields := Boolean(AArgs[0]);
end;

function TFieldDefs_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TFieldDef read <getter> w...

  if IsGet then
    Result := TFieldDef_sw.ToVar(TFieldDefs(AObj).Items[Integer(AArgs[0])])
  else
    TFieldDefs(AObj).Items[Integer(AArgs[0])] := TFieldDef_sw.FromVar(AArgs[1]);
end;

function TFieldDefs_ParentDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentDef: TFieldDef read <getter>;

  Result := TFieldDef_sw.ToVar(TFieldDefs(AObj).ParentDef);
end;

class function TFieldDefs_sw.GetTypeName: WideString;
begin
  Result := 'TFieldDefs';
end;

class function TFieldDefs_sw.GetWrappedClass: TClass;
begin
  Result := TFieldDefs;
end;

class procedure TFieldDefs_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('AddFieldDef', TFieldDefs_AddFieldDef_si, TFieldDef_sw, 0, False);
  AData.AddFunction('Find', TFieldDefs_Find_si, TFieldDef_sw, 1, False);
  AData.AddProcedure('Update', TFieldDefs_Update_si, 0, False);
  AData.AddProcedure('Add', TFieldDefs_Add_si, 2, True);
  AData.AddProperty('HiddenFields', TFieldDefs_HiddenFields_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Items', TFieldDefs_Items_si, TFieldDef_sw, True, True, 1, False, True);
  AData.AddProperty('ParentDef', TFieldDefs_ParentDef_si, TFieldDef_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TFieldDefs_Create_si, 1, False);
end;

class function TFieldDefs_sw.ToVar(const AValue: TFieldDefs): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFieldDefs_sw.FromVar(const AValue: OleVariant): TFieldDefs;
begin
  Result := TFieldDefs(ConvFromVar(AValue, TFieldDefs));
end;

class function TFieldDefs_sw.ClassToVar(AClass: TFieldDefs_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFieldDefs_sw.ClassFromVar(
  const AClass: OleVariant): TFieldDefs_sc;
begin
  Result := TFieldDefs_sc(ConvClsFromVar(AClass, TFieldDefs));
end;

{ TIndexOption_sw }

class function TIndexOption_sw.GetTypeName: WideString;
begin
  Result := 'TIndexOption';
end;

class procedure TIndexOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'ixPrimary'; Value: Integer({$IFDEF LMDSCT_12}TIndexOption.{$ENDIF}ixPrimary)),
    (Name: 'ixUnique'; Value: Integer({$IFDEF LMDSCT_12}TIndexOption.{$ENDIF}ixUnique)),
    (Name: 'ixDescending'; Value: Integer({$IFDEF LMDSCT_12}TIndexOption.{$ENDIF}ixDescending)),
    (Name: 'ixCaseInsensitive'; Value: Integer({$IFDEF LMDSCT_12}TIndexOption.{$ENDIF}ixCaseInsensitive)),
    (Name: 'ixExpression'; Value: Integer({$IFDEF LMDSCT_12}TIndexOption.{$ENDIF}ixExpression)),
    (Name: 'ixNonMaintained'; Value: Integer({$IFDEF LMDSCT_12}TIndexOption.{$ENDIF}ixNonMaintained))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TIndexOption_sw.ToVar(const AValue: TIndexOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TIndexOption_sw.FromVar(const AValue: OleVariant): TIndexOption;
begin
  Result := TIndexOption(Integer(AValue));
end;

{ TIndexOptions_sw }

class function TIndexOptions_sw.GetTypeName: WideString;
begin
  Result := 'TIndexOptions';
end;

class function TIndexOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TIndexOptions);
end;

class function TIndexOptions_sw.ToVar(const AValue: TIndexOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TIndexOptions_sw.FromVar(
  const AValue: OleVariant): TIndexOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TIndexDef_sw }

function TIndexDef_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  Result := TIndexDef_sw.ToVar(TIndexDef_sc(AObj).Create(TIndexDefs_sw.FromVar(
    AArgs[0]), string(AArgs[1]), string(AArgs[2]), TIndexOptions_sw.FromVar(
    AArgs[3])));
end;

function TIndexDef_FieldExpression_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldExpression: string read <getter>;

  Result := TIndexDef(AObj).FieldExpression;
end;

function TIndexDef_CaseInsFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CaseInsFields: string read <getter> write <setter>;

  if IsGet then
    Result := TIndexDef(AObj).CaseInsFields
  else
    TIndexDef(AObj).CaseInsFields := string(AArgs[0]);
end;

function TIndexDef_DescFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DescFields: string read <getter> write <setter>;

  if IsGet then
    Result := TIndexDef(AObj).DescFields
  else
    TIndexDef(AObj).DescFields := string(AArgs[0]);
end;

function TIndexDef_Expression_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Expression: string read <getter> write <setter>;

  if IsGet then
    Result := TIndexDef(AObj).Expression
  else
    TIndexDef(AObj).Expression := string(AArgs[0]);
end;

function TIndexDef_Fields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Fields: string read <getter> write <setter>;

  if IsGet then
    Result := TIndexDef(AObj).Fields
  else
    TIndexDef(AObj).Fields := string(AArgs[0]);
end;

function TIndexDef_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TIndexOptions read <getter> write <sett...

  if IsGet then
    Result := TIndexOptions_sw.ToVar(TIndexDef(AObj).Options)
  else
    TIndexDef(AObj).Options := TIndexOptions_sw.FromVar(AArgs[0]);
end;

function TIndexDef_Source_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Source: string read <getter> write <setter>;

  if IsGet then
    Result := TIndexDef(AObj).Source
  else
    TIndexDef(AObj).Source := string(AArgs[0]);
end;

function TIndexDef_GroupingLevel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GroupingLevel: Integer read <getter> write <sett...

  if IsGet then
    Result := TIndexDef(AObj).GroupingLevel
  else
    TIndexDef(AObj).GroupingLevel := Integer(AArgs[0]);
end;

class function TIndexDef_sw.GetTypeName: WideString;
begin
  Result := 'TIndexDef';
end;

class function TIndexDef_sw.GetWrappedClass: TClass;
begin
  Result := TIndexDef;
end;

class procedure TIndexDef_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('FieldExpression', TIndexDef_FieldExpression_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('CaseInsFields', TIndexDef_CaseInsFields_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('DescFields', TIndexDef_DescFields_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Expression', TIndexDef_Expression_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Fields', TIndexDef_Fields_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TIndexDef_Options_si, TIndexOptions_sw, True, True, 0, False, False);
  AData.AddProperty('Source', TIndexDef_Source_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('GroupingLevel', TIndexDef_GroupingLevel_si, Integer_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TIndexDef_Create_si, 4, False);
end;

class function TIndexDef_sw.ToVar(const AValue: TIndexDef): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TIndexDef_sw.FromVar(const AValue: OleVariant): TIndexDef;
begin
  Result := TIndexDef(ConvFromVar(AValue, TIndexDef));
end;

class function TIndexDef_sw.ClassToVar(AClass: TIndexDef_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TIndexDef_sw.ClassFromVar(
  const AClass: OleVariant): TIndexDef_sc;
begin
  Result := TIndexDef_sc(ConvClsFromVar(AClass, TIndexDef));
end;

{ TIndexDefClass_sw }

class function TIndexDefClass_sw.GetTypeName: WideString;
begin
  Result := 'TIndexDefClass';
end;

class function TIndexDefClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TIndexDef;
end;

class function TIndexDefClass_sw.ToVar(
  const AValue: TIndexDefClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TIndexDefClass_sw.FromVar(
  const AValue: OleVariant): TIndexDefClass;
begin
  Result := TIndexDefClass(ConvFromVar(AValue, TIndexDef));
end;

{ TIndexDefs_sw }

function TIndexDefs_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ADataSet: TDataSet);

  Result := TIndexDefs_sw.ToVar(TIndexDefs_sc(AObj).Create(TDataSet_sw.FromVar(
    AArgs[0])));
end;

function TIndexDefs_AddIndexDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddIndexDef: TIndexDef;

  Result := TIndexDef_sw.ToVar(TIndexDefs(AObj).AddIndexDef());
end;

function TIndexDefs_Find_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Find(const Name: string): TIndexDef;

  Result := TIndexDef_sw.ToVar(TIndexDefs(AObj).Find(string(AArgs[0])));
end;

function TIndexDefs_Update_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Update;

  TIndexDefs(AObj).Update();
end;

function TIndexDefs_FindIndexForFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindIndexForFields(const Fields: string): TIndex...

  Result := TIndexDef_sw.ToVar(TIndexDefs(AObj).FindIndexForFields(string(
    AArgs[0])));
end;

function TIndexDefs_GetIndexForFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetIndexForFields(const Fields: string; CaseInse...

  Result := TIndexDef_sw.ToVar(TIndexDefs(AObj).GetIndexForFields(string(
    AArgs[0]), Boolean(AArgs[1])));
end;

function TIndexDefs_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Add(const Name: string; const Fields: string; O...

  TIndexDefs(AObj).Add(string(AArgs[0]), string(AArgs[1]), TIndexOptions_sw.
    FromVar(AArgs[2]));
end;

function TIndexDefs_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TIndexDef read <getter> w...

  if IsGet then
    Result := TIndexDef_sw.ToVar(TIndexDefs(AObj).Items[Integer(AArgs[0])])
  else
    TIndexDefs(AObj).Items[Integer(AArgs[0])] := TIndexDef_sw.FromVar(AArgs[1]);
end;

class function TIndexDefs_sw.GetTypeName: WideString;
begin
  Result := 'TIndexDefs';
end;

class function TIndexDefs_sw.GetWrappedClass: TClass;
begin
  Result := TIndexDefs;
end;

class procedure TIndexDefs_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('AddIndexDef', TIndexDefs_AddIndexDef_si, TIndexDef_sw, 0, False);
  AData.AddFunction('Find', TIndexDefs_Find_si, TIndexDef_sw, 1, False);
  AData.AddProcedure('Update', TIndexDefs_Update_si, 0, False);
  AData.AddFunction('FindIndexForFields', TIndexDefs_FindIndexForFields_si, TIndexDef_sw, 1, False);
  AData.AddFunction('GetIndexForFields', TIndexDefs_GetIndexForFields_si, TIndexDef_sw, 2, False);
  AData.AddProcedure('Add', TIndexDefs_Add_si, 3, False);
  AData.AddProperty('Items', TIndexDefs_Items_si, TIndexDef_sw, True, True, 1, False, True);

  { Class members }

  AData.AddConstructor('Create', TIndexDefs_Create_si, 1, False);
end;

class function TIndexDefs_sw.ToVar(const AValue: TIndexDefs): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TIndexDefs_sw.FromVar(const AValue: OleVariant): TIndexDefs;
begin
  Result := TIndexDefs(ConvFromVar(AValue, TIndexDefs));
end;

class function TIndexDefs_sw.ClassToVar(AClass: TIndexDefs_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TIndexDefs_sw.ClassFromVar(
  const AClass: OleVariant): TIndexDefs_sc;
begin
  Result := TIndexDefs_sc(ConvClsFromVar(AClass, TIndexDefs));
end;

{ TIndexDefsClass_sw }

class function TIndexDefsClass_sw.GetTypeName: WideString;
begin
  Result := 'TIndexDefsClass';
end;

class function TIndexDefsClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TIndexDefs;
end;

class function TIndexDefsClass_sw.ToVar(
  const AValue: TIndexDefsClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TIndexDefsClass_sw.FromVar(
  const AValue: OleVariant): TIndexDefsClass;
begin
  Result := TIndexDefsClass(ConvFromVar(AValue, TIndexDefs));
end;

{ TFlatList_sw }

function TFlatList_Updated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Updated: Boolean read <getter> write <...

  if IsGet then
    Result := TFlatList_sacc(TFlatList(AObj)).Updated
  else
    TFlatList_sacc(TFlatList(AObj)).Updated := Boolean(AArgs[0]);
end;

function TFlatList_Locked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Locked: Boolean read <getter> write <s...

  if IsGet then
    Result := TFlatList_sacc(TFlatList(AObj)).Locked
  else
    TFlatList_sacc(TFlatList(AObj)).Locked := Boolean(AArgs[0]);
end;

function TFlatList_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ADataSet: TDataSet);

  Result := TFlatList_sw.ToVar(TFlatList_sc(AObj).Create(TDataSet_sw.FromVar(
    AArgs[0])));
end;

function TFlatList_Update_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Update;

  TFlatList(AObj).Update();
end;

function TFlatList_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSet: TDataSet read <getter>;

  Result := TDataSet_sw.ToVar(TFlatList(AObj).DataSet);
end;

class function TFlatList_sw.GetTypeName: WideString;
begin
  Result := 'TFlatList';
end;

class function TFlatList_sw.GetWrappedClass: TClass;
begin
  Result := TFlatList;
end;

class procedure TFlatList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Updated', TFlatList_Updated_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Locked', TFlatList_Locked_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProcedure('Update', TFlatList_Update_si, 0, False);
  AData.AddProperty('DataSet', TFlatList_DataSet_si, TDataSet_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TFlatList_Create_si, 1, False);
end;

class function TFlatList_sw.ToVar(const AValue: TFlatList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFlatList_sw.FromVar(const AValue: OleVariant): TFlatList;
begin
  Result := TFlatList(ConvFromVar(AValue, TFlatList));
end;

class function TFlatList_sw.ClassToVar(AClass: TFlatList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFlatList_sw.ClassFromVar(
  const AClass: OleVariant): TFlatList_sc;
begin
  Result := TFlatList_sc(ConvClsFromVar(AClass, TFlatList));
end;

{ TFieldDefList_sw }

function TFieldDefList_FieldByName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FieldByName(const Name: string): TFieldDef;

  Result := TFieldDef_sw.ToVar(TFieldDefList(AObj).FieldByName(string(
    AArgs[0])));
end;

function TFieldDefList_Find_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Find(const Name: string): TFieldDef;

  Result := TFieldDef_sw.ToVar(TFieldDefList(AObj).Find(string(AArgs[0])));
end;

function TFieldDefList_FieldDefs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldDefs[Index: Integer]: TFieldDef read <gette...

  Result := TFieldDef_sw.ToVar(TFieldDefList(AObj).FieldDefs[Integer(
    AArgs[0])]);
end;

class function TFieldDefList_sw.GetTypeName: WideString;
begin
  Result := 'TFieldDefList';
end;

class function TFieldDefList_sw.GetWrappedClass: TClass;
begin
  Result := TFieldDefList;
end;

class procedure TFieldDefList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('FieldByName', TFieldDefList_FieldByName_si, TFieldDef_sw, 1, False);
  AData.AddFunction('Find', TFieldDefList_Find_si, TFieldDef_sw, 1, False);
  AData.AddProperty('FieldDefs', TFieldDefList_FieldDefs_si, TFieldDef_sw, True, False, 1, False, True);
end;

class function TFieldDefList_sw.ToVar(const AValue: TFieldDefList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFieldDefList_sw.FromVar(
  const AValue: OleVariant): TFieldDefList;
begin
  Result := TFieldDefList(ConvFromVar(AValue, TFieldDefList));
end;

class function TFieldDefList_sw.ClassToVar(
  AClass: TFieldDefList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFieldDefList_sw.ClassFromVar(
  const AClass: OleVariant): TFieldDefList_sc;
begin
  Result := TFieldDefList_sc(ConvClsFromVar(AClass, TFieldDefList));
end;

{ TFieldDefListClass_sw }

class function TFieldDefListClass_sw.GetTypeName: WideString;
begin
  Result := 'TFieldDefListClass';
end;

class function TFieldDefListClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TFieldDefList;
end;

class function TFieldDefListClass_sw.ToVar(
  const AValue: TFieldDefListClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFieldDefListClass_sw.FromVar(
  const AValue: OleVariant): TFieldDefListClass;
begin
  Result := TFieldDefListClass(ConvFromVar(AValue, TFieldDefList));
end;

{ TFieldList_sw }

function TFieldList_FieldByName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FieldByName(const Name: string): TField;

  Result := TField_sw.ToVar(TFieldList(AObj).FieldByName(string(AArgs[0])));
end;

function TFieldList_Find_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Find(const Name: string): TField;

  Result := TField_sw.ToVar(TFieldList(AObj).Find(string(AArgs[0])));
end;

function TFieldList_Fields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Fields[Index: Integer]: TField read <getter>; de...

  Result := TField_sw.ToVar(TFieldList(AObj).Fields[Integer(AArgs[0])]);
end;

class function TFieldList_sw.GetTypeName: WideString;
begin
  Result := 'TFieldList';
end;

class function TFieldList_sw.GetWrappedClass: TClass;
begin
  Result := TFieldList;
end;

class procedure TFieldList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('FieldByName', TFieldList_FieldByName_si, TField_sw, 1, False);
  AData.AddFunction('Find', TFieldList_Find_si, TField_sw, 1, False);
  AData.AddProperty('Fields', TFieldList_Fields_si, TField_sw, True, False, 1, False, True);
end;

class function TFieldList_sw.ToVar(const AValue: TFieldList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFieldList_sw.FromVar(const AValue: OleVariant): TFieldList;
begin
  Result := TFieldList(ConvFromVar(AValue, TFieldList));
end;

class function TFieldList_sw.ClassToVar(AClass: TFieldList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFieldList_sw.ClassFromVar(
  const AClass: OleVariant): TFieldList_sc;
begin
  Result := TFieldList_sc(ConvClsFromVar(AClass, TFieldList));
end;

{ TFieldListClass_sw }

class function TFieldListClass_sw.GetTypeName: WideString;
begin
  Result := 'TFieldListClass';
end;

class function TFieldListClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TFieldList;
end;

class function TFieldListClass_sw.ToVar(
  const AValue: TFieldListClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFieldListClass_sw.FromVar(
  const AValue: OleVariant): TFieldListClass;
begin
  Result := TFieldListClass(ConvFromVar(AValue, TFieldList));
end;

{ TFieldsEnumerator_sw }

function TFieldsEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AFields: TFields);

  Result := TFieldsEnumerator_sw.ToVar(TFieldsEnumerator_sc(AObj).Create(
    TFields_sw.FromVar(AArgs[0])));
end;

function TFieldsEnumerator_GetCurrent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrent: TField;

  Result := TField_sw.ToVar(TFieldsEnumerator(AObj).GetCurrent());
end;

function TFieldsEnumerator_MoveNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TFieldsEnumerator(AObj).MoveNext();
end;

function TFieldsEnumerator_Current_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: TField read <getter>;

  Result := TField_sw.ToVar(TFieldsEnumerator(AObj).Current);
end;

class function TFieldsEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TFieldsEnumerator';
end;

class function TFieldsEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TFieldsEnumerator;
end;

class procedure TFieldsEnumerator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetCurrent', TFieldsEnumerator_GetCurrent_si, TField_sw, 0, False);
  AData.AddFunction('MoveNext', TFieldsEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TFieldsEnumerator_Current_si, TField_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TFieldsEnumerator_Create_si, 1, False);
end;

class function TFieldsEnumerator_sw.ToVar(
  const AValue: TFieldsEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFieldsEnumerator_sw.FromVar(
  const AValue: OleVariant): TFieldsEnumerator;
begin
  Result := TFieldsEnumerator(ConvFromVar(AValue, TFieldsEnumerator));
end;

class function TFieldsEnumerator_sw.ClassToVar(
  AClass: TFieldsEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFieldsEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TFieldsEnumerator_sc;
begin
  Result := TFieldsEnumerator_sc(ConvClsFromVar(AClass, TFieldsEnumerator));
end;

{ TFieldKind_sw }

class function TFieldKind_sw.GetTypeName: WideString;
begin
  Result := 'TFieldKind';
end;

class procedure TFieldKind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'fkData'; Value: Integer({$IFDEF LMDSCT_12}TFieldKind.{$ENDIF}fkData)),
    (Name: 'fkCalculated'; Value: Integer({$IFDEF LMDSCT_12}TFieldKind.{$ENDIF}fkCalculated)),
    (Name: 'fkLookup'; Value: Integer({$IFDEF LMDSCT_12}TFieldKind.{$ENDIF}fkLookup)),
    (Name: 'fkInternalCalc'; Value: Integer({$IFDEF LMDSCT_12}TFieldKind.{$ENDIF}fkInternalCalc)),
    (Name: 'fkAggregate'; Value: Integer({$IFDEF LMDSCT_12}TFieldKind.{$ENDIF}fkAggregate))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TFieldKind_sw.ToVar(const AValue: TFieldKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFieldKind_sw.FromVar(const AValue: OleVariant): TFieldKind;
begin
  Result := TFieldKind(Integer(AValue));
end;

{ TFieldKinds_sw }

class function TFieldKinds_sw.GetTypeName: WideString;
begin
  Result := 'TFieldKinds';
end;

class function TFieldKinds_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFieldKinds);
end;

class function TFieldKinds_sw.ToVar(const AValue: TFieldKinds): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFieldKinds_sw.FromVar(const AValue: OleVariant): TFieldKinds;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFields_sw }

function TFields_SparseFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property SparseFields: Integer read <getter> wr...

  if IsGet then
    Result := TFields_sacc(TFields(AObj)).SparseFields
  else
    TFields_sacc(TFields(AObj)).SparseFields := Integer(AArgs[0]);
end;

function TFields_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChange: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TFields_sacc(TFields(AObj)).OnChange)
  else
    TFields_sacc(TFields(AObj)).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TFields_ValidFieldKinds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ValidFieldKinds: TFieldKinds read <get...

  if IsGet then
    Result := TFieldKinds_sw.ToVar(TFields_sacc(TFields(AObj)).ValidFieldKinds)
  else
    TFields_sacc(TFields(AObj)).ValidFieldKinds := TFieldKinds_sw.FromVar(
      AArgs[0]);
end;

function TFields_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ADataSet: TDataSet);

  Result := TFields_sw.ToVar(TFields_sc(AObj).Create(TDataSet_sw.FromVar(
    AArgs[0])));
end;

function TFields_Add_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure Add(Field: TField);

  TFields(AObj).Add(TField_sw.FromVar(AArgs[0]));
end;

function TFields_CheckFieldName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CheckFieldName(const FieldName: string);

  TFields(AObj).CheckFieldName(string(AArgs[0]));
end;

function TFields_CheckFieldNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CheckFieldNames(const FieldNames: string);

  TFields(AObj).CheckFieldNames(string(AArgs[0]));
end;

function TFields_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TFields(AObj).Clear();
end;

function TFields_FindField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindField(const FieldName: string): TField;

  Result := TField_sw.ToVar(TFields(AObj).FindField(string(AArgs[0])));
end;

function TFields_FieldByName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FieldByName(const FieldName: string): TField;

  Result := TField_sw.ToVar(TFields(AObj).FieldByName(string(AArgs[0])));
end;

function TFields_FieldByNumber_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FieldByNumber(FieldNo: Integer): TField;

  Result := TField_sw.ToVar(TFields(AObj).FieldByNumber(Integer(AArgs[0])));
end;

function TFields_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TFieldsEnumerator;

  Result := TFieldsEnumerator_sw.ToVar(TFields(AObj).GetEnumerator());
end;

function TFields_GetFieldNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetFieldNames(List: TStrings);

  TFields(AObj).GetFieldNames(TStrings_sw.FromVar(AArgs[0]));
end;

function TFields_IndexOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOf(Field: TField): Integer;

  Result := TFields(AObj).IndexOf(TField_sw.FromVar(AArgs[0]));
end;

function TFields_Remove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Remove(Field: TField);

  TFields(AObj).Remove(TField_sw.FromVar(AArgs[0]));
end;

function TFields_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TFields(AObj).Count;
end;

function TFields_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSet: TDataSet read <getter>;

  Result := TDataSet_sw.ToVar(TFields(AObj).DataSet);
end;

function TFields_Fields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Fields[Index: Integer]: TField read <getter> wri...

  if IsGet then
    Result := TField_sw.ToVar(TFields(AObj).Fields[Integer(AArgs[0])])
  else
    TFields(AObj).Fields[Integer(AArgs[0])] := TField_sw.FromVar(AArgs[1]);
end;

class function TFields_sw.GetTypeName: WideString;
begin
  Result := 'TFields';
end;

class function TFields_sw.GetWrappedClass: TClass;
begin
  Result := TFields;
end;

class procedure TFields_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('SparseFields', TFields_SparseFields_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('OnChange', TFields_OnChange_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('ValidFieldKinds', TFields_ValidFieldKinds_si, TFieldKinds_sw, True, True, 0, True, False);
  AData.AddProcedure('Add', TFields_Add_si, 1, False);
  AData.AddProcedure('CheckFieldName', TFields_CheckFieldName_si, 1, False);
  AData.AddProcedure('CheckFieldNames', TFields_CheckFieldNames_si, 1, False);
  AData.AddProcedure('Clear', TFields_Clear_si, 0, False);
  AData.AddFunction('FindField', TFields_FindField_si, TField_sw, 1, False);
  AData.AddFunction('FieldByName', TFields_FieldByName_si, TField_sw, 1, False);
  AData.AddFunction('FieldByNumber', TFields_FieldByNumber_si, TField_sw, 1, False);
  AData.AddFunction('GetEnumerator', TFields_GetEnumerator_si, TFieldsEnumerator_sw, 0, False);
  AData.AddProcedure('GetFieldNames', TFields_GetFieldNames_si, 1, False);
  AData.AddFunction('IndexOf', TFields_IndexOf_si, Integer_sw, 1, False);
  AData.AddProcedure('Remove', TFields_Remove_si, 1, False);
  AData.AddProperty('Count', TFields_Count_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('DataSet', TFields_DataSet_si, TDataSet_sw, True, False, 0, False, False);
  AData.AddProperty('Fields', TFields_Fields_si, TField_sw, True, True, 1, False, True);

  { Class members }

  AData.AddConstructor('Create', TFields_Create_si, 1, False);
end;

class function TFields_sw.ToVar(const AValue: TFields): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFields_sw.FromVar(const AValue: OleVariant): TFields;
begin
  Result := TFields(ConvFromVar(AValue, TFields));
end;

class function TFields_sw.ClassToVar(AClass: TFields_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFields_sw.ClassFromVar(const AClass: OleVariant): TFields_sc;
begin
  Result := TFields_sc(ConvClsFromVar(AClass, TFields));
end;

{ TFieldsClass_sw }

class function TFieldsClass_sw.GetTypeName: WideString;
begin
  Result := 'TFieldsClass';
end;

class function TFieldsClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TFields;
end;

class function TFieldsClass_sw.ToVar(const AValue: TFieldsClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFieldsClass_sw.FromVar(const AValue: OleVariant): TFieldsClass;
begin
  Result := TFieldsClass(ConvFromVar(AValue, TFields));
end;

{ TProviderFlag_sw }

class function TProviderFlag_sw.GetTypeName: WideString;
begin
  Result := 'TProviderFlag';
end;

class procedure TProviderFlag_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'pfInUpdate'; Value: Integer({$IFDEF LMDSCT_12}TProviderFlag.{$ENDIF}pfInUpdate)),
    (Name: 'pfInWhere'; Value: Integer({$IFDEF LMDSCT_12}TProviderFlag.{$ENDIF}pfInWhere)),
    (Name: 'pfInKey'; Value: Integer({$IFDEF LMDSCT_12}TProviderFlag.{$ENDIF}pfInKey)),
    (Name: 'pfHidden'; Value: Integer({$IFDEF LMDSCT_12}TProviderFlag.{$ENDIF}pfHidden))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TProviderFlag_sw.ToVar(const AValue: TProviderFlag): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TProviderFlag_sw.FromVar(
  const AValue: OleVariant): TProviderFlag;
begin
  Result := TProviderFlag(Integer(AValue));
end;

{ TProviderFlags_sw }

class function TProviderFlags_sw.GetTypeName: WideString;
begin
  Result := 'TProviderFlags';
end;

class function TProviderFlags_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TProviderFlags);
end;

class function TProviderFlags_sw.ToVar(
  const AValue: TProviderFlags): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TProviderFlags_sw.FromVar(
  const AValue: OleVariant): TProviderFlags;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFieldNotifyEvent_sh }

function TFieldNotifyEvent_sh.GetHandler: TMethod;
var
  hdr: TFieldNotifyEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFieldNotifyEvent_sh.Handler(Sender: TField);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (Sender: TField) of object

  args[0] := TField_sw.ToVar(Sender);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TFieldNotifyEvent_sw }

class function TFieldNotifyEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFieldNotifyEvent';
end;

class function TFieldNotifyEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFieldNotifyEvent_sh;
end;

class function TFieldNotifyEvent_sw.ToVar(
  const AValue: TFieldNotifyEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFieldNotifyEvent_sw.FromVar(
  const AValue: OleVariant): TFieldNotifyEvent;
begin
  Result := TFieldNotifyEvent(ConvFromVar(AValue));
end;

class function TFieldNotifyEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TFieldNotifyEvent;
var
  hdlr: TFieldNotifyEvent_sh;
begin
  hdlr   := TFieldNotifyEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TFieldNotifyEvent_sw));
  Result := hdlr.Handler;
end;

{ TFieldGetTextEvent_sh }

function TFieldGetTextEvent_sh.GetHandler: TMethod;
var
  hdr: TFieldGetTextEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFieldGetTextEvent_sh.Handler(Sender: TField; var Text: string;
  DisplayText: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TField; var Text: string; DisplayText:...

  v_1 := Text;
  args[0] := TField_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  args[2] := DisplayText;
  Self.Owner.RunProc(Self.ProcName, args);
  Text := string(v_1);
end;

{ TFieldGetTextEvent_sw }

class function TFieldGetTextEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFieldGetTextEvent';
end;

class function TFieldGetTextEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFieldGetTextEvent_sh;
end;

class function TFieldGetTextEvent_sw.ToVar(
  const AValue: TFieldGetTextEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFieldGetTextEvent_sw.FromVar(
  const AValue: OleVariant): TFieldGetTextEvent;
begin
  Result := TFieldGetTextEvent(ConvFromVar(AValue));
end;

class function TFieldGetTextEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TFieldGetTextEvent;
var
  hdlr: TFieldGetTextEvent_sh;
begin
  hdlr   := TFieldGetTextEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TFieldGetTextEvent_sw));
  Result := hdlr.Handler;
end;

{ TFieldSetTextEvent_sh }

function TFieldSetTextEvent_sh.GetHandler: TMethod;
var
  hdr: TFieldSetTextEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFieldSetTextEvent_sh.Handler(Sender: TField; const Text: string);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TField; const Text: string) of object

  args[0] := TField_sw.ToVar(Sender);
  args[1] := Text;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TFieldSetTextEvent_sw }

class function TFieldSetTextEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFieldSetTextEvent';
end;

class function TFieldSetTextEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFieldSetTextEvent_sh;
end;

class function TFieldSetTextEvent_sw.ToVar(
  const AValue: TFieldSetTextEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFieldSetTextEvent_sw.FromVar(
  const AValue: OleVariant): TFieldSetTextEvent;
begin
  Result := TFieldSetTextEvent(ConvFromVar(AValue));
end;

class function TFieldSetTextEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TFieldSetTextEvent;
var
  hdlr: TFieldSetTextEvent_sh;
begin
  hdlr   := TFieldSetTextEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TFieldSetTextEvent_sw));
  Result := hdlr.Handler;
end;

{ TFieldChars_sw }

class function TFieldChars_sw.GetTypeName: WideString;
begin
  Result := 'TFieldChars';
end;

class function TFieldChars_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFieldChars);
end;

class function TFieldChars_sw.ToVar(const AValue: TFieldChars): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFieldChars_sw.FromVar(const AValue: OleVariant): TFieldChars;
begin
  ConvFromVar(AValue, @Result);
end;

{ TAutoRefreshFlag_sw }

class function TAutoRefreshFlag_sw.GetTypeName: WideString;
begin
  Result := 'TAutoRefreshFlag';
end;

class procedure TAutoRefreshFlag_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'arNone'; Value: Integer({$IFDEF LMDSCT_12}TAutoRefreshFlag.{$ENDIF}arNone)),
    (Name: 'arAutoInc'; Value: Integer({$IFDEF LMDSCT_12}TAutoRefreshFlag.{$ENDIF}arAutoInc)),
    (Name: 'arDefault'; Value: Integer({$IFDEF LMDSCT_12}TAutoRefreshFlag.{$ENDIF}arDefault))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TAutoRefreshFlag_sw.ToVar(
  const AValue: TAutoRefreshFlag): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TAutoRefreshFlag_sw.FromVar(
  const AValue: OleVariant): TAutoRefreshFlag;
begin
  Result := TAutoRefreshFlag(Integer(AValue));
end;

{ TLookupList_sw }

function TLookupList_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TLookupList_sw.ToVar(TLookupList_sc(AObj).Create());
end;

function TLookupList_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Add(const AKey: Variant; const AValue: Variant);

  TLookupList(AObj).Add(Variant(FindVarData(AArgs[0])^), Variant(FindVarData(
    AArgs[1])^));
end;

function TLookupList_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TLookupList(AObj).Clear();
end;

function TLookupList_ValueOfKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ValueOfKey(const AKey: Variant): Variant;

  Result := TLookupList(AObj).ValueOfKey(Variant(FindVarData(AArgs[0])^));
end;

class function TLookupList_sw.GetTypeName: WideString;
begin
  Result := 'TLookupList';
end;

class function TLookupList_sw.GetWrappedClass: TClass;
begin
  Result := TLookupList;
end;

class procedure TLookupList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Add', TLookupList_Add_si, 2, False);
  AData.AddProcedure('Clear', TLookupList_Clear_si, 0, False);
  AData.AddFunction('ValueOfKey', TLookupList_ValueOfKey_si, Variant_sw, 1, False);

  { Class members }

  AData.AddConstructor('Create', TLookupList_Create_si, 0, False);
end;

class function TLookupList_sw.ToVar(const AValue: TLookupList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TLookupList_sw.FromVar(const AValue: OleVariant): TLookupList;
begin
  Result := TLookupList(ConvFromVar(AValue, TLookupList));
end;

class function TLookupList_sw.ClassToVar(AClass: TLookupList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TLookupList_sw.ClassFromVar(
  const AClass: OleVariant): TLookupList_sc;
begin
  Result := TLookupList_sc(ConvClsFromVar(AClass, TLookupList));
end;

{ TLookupListClass_sw }

class function TLookupListClass_sw.GetTypeName: WideString;
begin
  Result := 'TLookupListClass';
end;

class function TLookupListClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TLookupList;
end;

class function TLookupListClass_sw.ToVar(
  const AValue: TLookupListClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TLookupListClass_sw.FromVar(
  const AValue: OleVariant): TLookupListClass;
begin
  Result := TLookupListClass(ConvFromVar(AValue, TLookupList));
end;

{ TLookupListEntry_sw }

function TLookupListEntry_Key_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Key: Variant;

  if IsGet then
    Result := TLookupListEntry_sw(AObj).FValue.Key
  else
    TLookupListEntry_sw(AObj).FValue.Key := Variant(FindVarData(AArgs[0])^);
end;

function TLookupListEntry_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Value: Variant;

  if IsGet then
    Result := TLookupListEntry_sw(AObj).FValue.Value
  else
    TLookupListEntry_sw(AObj).FValue.Value := Variant(FindVarData(AArgs[0])^);
end;

function TLookupListEntry_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TLookupListEntry_sw.Create as IDispatch;
end;

function TLookupListEntry_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TLookupListEntry;

  // Implicit record copy method.
  Result := TLookupListEntry_sw.ToVar(TLookupListEntry(AObj));
end;

class function TLookupListEntry_sw.GetTypeName: WideString;
begin
  Result := 'TLookupListEntry';
end;

function TLookupListEntry_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TLookupListEntry_sw.Create;
  TLookupListEntry_sw(Result).FValue := FValue;
end;

class procedure TLookupListEntry_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Key', TLookupListEntry_Key_si, Variant_sw);
  AData.AddField('Value', TLookupListEntry_Value_si, Variant_sw);
  AData.AddFunction('Copy', TLookupListEntry_Copy_si, TLookupListEntry_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TLookupListEntry_Create_si, 0, False);
end;

class function TLookupListEntry_sw.ToVar(
  const AValue: TLookupListEntry): OleVariant;
var
  wrpr: TLookupListEntry_sw;
begin
  wrpr        := TLookupListEntry_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TLookupListEntry_sw.FromVar(
  const AValue: OleVariant): TLookupListEntry;
begin
  Result := TLookupListEntry_sw(ConvFromVar(AValue)).FValue;
end;

{ TDefaultLookupList_sw }

class function TDefaultLookupList_sw.GetTypeName: WideString;
begin
  Result := 'TDefaultLookupList';
end;

class function TDefaultLookupList_sw.GetWrappedClass: TClass;
begin
  Result := TDefaultLookupList;
end;

class procedure TDefaultLookupList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TDefaultLookupList_sw.ToVar(
  const AValue: TDefaultLookupList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDefaultLookupList_sw.FromVar(
  const AValue: OleVariant): TDefaultLookupList;
begin
  Result := TDefaultLookupList(ConvFromVar(AValue, TDefaultLookupList));
end;

class function TDefaultLookupList_sw.ClassToVar(
  AClass: TDefaultLookupList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDefaultLookupList_sw.ClassFromVar(
  const AClass: OleVariant): TDefaultLookupList_sc;
begin
  Result := TDefaultLookupList_sc(ConvClsFromVar(AClass, TDefaultLookupList));
end;

{ TField_sw }

function TField_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TField(AObj).Clear();
end;

function TField_FocusControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FocusControl;

  TField(AObj).FocusControl();
end;

function TField_IsBlob_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function IsBlob: Boolean;

  Result := TField_sc(AObj).IsBlob();
end;

function TField_IsValidChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsValidChar(InputChar: Char): Boolean;

  Result := TField(AObj).IsValidChar(Char(Integer(AArgs[0])));
end;

function TField_RefreshLookupList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RefreshLookupList;

  TField(AObj).RefreshLookupList();
end;

function TField_SetFieldType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetFieldType(Value: TFieldType);

  TField(AObj).SetFieldType(TFieldType_sw.FromVar(AArgs[0]));
end;

function TField_AsBoolean_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsBoolean: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).AsBoolean
  else
    TField(AObj).AsBoolean := Boolean(AArgs[0]);
end;

function TField_AsCurrency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsCurrency: Currency read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).AsCurrency
  else
    TField(AObj).AsCurrency := Currency(AArgs[0]);
end;

function TField_AsDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsDateTime: TDateTime read <getter> write <setter>;

  if IsGet then
    Result := TDateTime_sw.ToVar(TField(AObj).AsDateTime)
  else
    TField(AObj).AsDateTime := TDateTime_sw.FromVar(AArgs[0]);
end;

function TField_AsSingle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsSingle: Single read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).AsSingle
  else
    TField(AObj).AsSingle := Single(AArgs[0]);
end;

function TField_AsFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsFloat: Double read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).AsFloat
  else
    TField(AObj).AsFloat := Double(AArgs[0]);
end;

function TField_AsExtended_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsExtended: Extended read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).AsExtended
  else
    TField(AObj).AsExtended := Extended(AArgs[0]);
end;

function TField_AsInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsInteger: Longint read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).AsInteger
  else
    TField(AObj).AsInteger := Longint(AArgs[0]);
end;

function TField_AsLargeInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsLargeInt: Largeint read <getter> write <setter>;

  if IsGet then
    Result := Largeint_sw.ToVar(TField(AObj).AsLargeInt)
  else
    TField(AObj).AsLargeInt := Largeint_sw.FromVar(AArgs[0]);
end;

function TField_AsLongWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsLongWord: LongWord read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).AsLongWord
  else
    TField(AObj).AsLongWord := LongWord(AArgs[0]);
end;

function TField_AsString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsString: string read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).AsString
  else
    TField(AObj).AsString := string(AArgs[0]);
end;

function TField_AsWideString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsWideString: string read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).AsWideString
  else
    TField(AObj).AsWideString := string(AArgs[0]);
end;

function TField_AsAnsiString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsAnsiString: AnsiString read <getter> write <se...

  if IsGet then
    Result := TField(AObj).AsAnsiString
  else
    TField(AObj).AsAnsiString := AnsiString(AArgs[0]);
end;

function TField_AsVariant_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsVariant: Variant read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).AsVariant
  else
    TField(AObj).AsVariant := Variant(FindVarData(AArgs[0])^);
end;

function TField_AttributeSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AttributeSet: string read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).AttributeSet
  else
    TField(AObj).AttributeSet := string(AArgs[0]);
end;

function TField_Calculated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Calculated: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).Calculated
  else
    TField(AObj).Calculated := Boolean(AArgs[0]);
end;

function TField_CanModify_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CanModify: Boolean read <getter>;

  Result := TField(AObj).CanModify;
end;

function TField_CurValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CurValue: Variant read <getter>;

  Result := TField(AObj).CurValue;
end;

function TField_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSet: TDataSet read <getter> write <setter>;

  if IsGet then
    Result := TDataSet_sw.ToVar(TField(AObj).DataSet)
  else
    TField(AObj).DataSet := TDataSet_sw.FromVar(AArgs[0]);
end;

function TField_DataSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSize: Integer read <getter>;

  Result := TField(AObj).DataSize;
end;

function TField_DataType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataType: TFieldType read <getter>;

  Result := TFieldType_sw.ToVar(TField(AObj).DataType);
end;

function TField_DisplayName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayName: string read <getter>;

  Result := TField(AObj).DisplayName;
end;

function TField_DisplayText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayText: string read <getter>;

  Result := TField(AObj).DisplayText;
end;

function TField_EditMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EditMask: TEditMask read <getter> write <setter>;

  if IsGet then
    Result := TEditMask_sw.ToVar(TField(AObj).EditMask)
  else
    TField(AObj).EditMask := TEditMask_sw.FromVar(AArgs[0]);
end;

function TField_EditMaskPtr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EditMaskPtr: TEditMask read <getter>;

  Result := TEditMask_sw.ToVar(TField(AObj).EditMaskPtr);
end;

function TField_FieldNo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldNo: Integer read <getter>;

  Result := TField(AObj).FieldNo;
end;

function TField_FullName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FullName: string read <getter>;

  Result := TField(AObj).FullName;
end;

function TField_IsIndexField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsIndexField: Boolean read <getter>;

  Result := TField(AObj).IsIndexField;
end;

function TField_IsNull_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsNull: Boolean read <getter>;

  Result := TField(AObj).IsNull;
end;

function TField_Lookup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Lookup: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).Lookup
  else
    TField(AObj).Lookup := Boolean(AArgs[0]);
end;

function TField_LookupList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LookupList: TLookupList read <getter>;

  Result := TLookupList_sw.ToVar(TField(AObj).LookupList);
end;

function TField_NewValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NewValue: Variant read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).NewValue
  else
    TField(AObj).NewValue := Variant(FindVarData(AArgs[0])^);
end;

function TField_Offset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Offset: Integer read <getter>;

  Result := TField(AObj).Offset;
end;

function TField_OldValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OldValue: Variant read <getter>;

  Result := TField(AObj).OldValue;
end;

function TField_ParentField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentField: TObjectField read <getter> write <s...

  if IsGet then
    Result := TObjectField_sw.ToVar(TField(AObj).ParentField)
  else
    TField(AObj).ParentField := TObjectField_sw.FromVar(AArgs[0]);
end;

function TField_Size_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Size: Integer read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).Size
  else
    TField(AObj).Size := Integer(AArgs[0]);
end;

function TField_Text_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Text: string read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).Text
  else
    TField(AObj).Text := string(AArgs[0]);
end;

function TField_ValidChars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ValidChars: TFieldChars read <getter> write <set...

  if IsGet then
    Result := TFieldChars_sw.ToVar(TField(AObj).ValidChars)
  else
    TField(AObj).ValidChars := TFieldChars_sw.FromVar(AArgs[0]);
end;

function TField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: Variant read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).Value
  else
    TField(AObj).Value := Variant(FindVarData(AArgs[0])^);
end;

function TField_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Alignment: TAlignment read <getter> write <setter>;

  if IsGet then
    Result := TAlignment_sw.ToVar(TField(AObj).Alignment)
  else
    TField(AObj).Alignment := TAlignment_sw.FromVar(AArgs[0]);
end;

function TField_AutoGenerateValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoGenerateValue: TAutoRefreshFlag read <getter...

  if IsGet then
    Result := TAutoRefreshFlag_sw.ToVar(TField(AObj).AutoGenerateValue)
  else
    TField(AObj).AutoGenerateValue := TAutoRefreshFlag_sw.FromVar(AArgs[0]);
end;

function TField_CustomConstraint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CustomConstraint: string read <getter> write <se...

  if IsGet then
    Result := TField(AObj).CustomConstraint
  else
    TField(AObj).CustomConstraint := string(AArgs[0]);
end;

function TField_ConstraintErrorMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ConstraintErrorMessage: string read <getter> wri...

  if IsGet then
    Result := TField(AObj).ConstraintErrorMessage
  else
    TField(AObj).ConstraintErrorMessage := string(AArgs[0]);
end;

function TField_DefaultExpression_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultExpression: string read <getter> write <s...

  if IsGet then
    Result := TField(AObj).DefaultExpression
  else
    TField(AObj).DefaultExpression := string(AArgs[0]);
end;

function TField_DisplayLabel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayLabel: string read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).DisplayLabel
  else
    TField(AObj).DisplayLabel := string(AArgs[0]);
end;

function TField_DisplayWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).DisplayWidth
  else
    TField(AObj).DisplayWidth := Integer(AArgs[0]);
end;

function TField_FieldKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldKind: TFieldKind read <getter> write <setter>;

  if IsGet then
    Result := TFieldKind_sw.ToVar(TField(AObj).FieldKind)
  else
    TField(AObj).FieldKind := TFieldKind_sw.FromVar(AArgs[0]);
end;

function TField_FieldName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldName: string read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).FieldName
  else
    TField(AObj).FieldName := string(AArgs[0]);
end;

function TField_HasConstraints_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HasConstraints: Boolean read <getter>;

  Result := TField(AObj).HasConstraints;
end;

function TField_Index_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Index: Integer read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).Index
  else
    TField(AObj).Index := Integer(AArgs[0]);
end;

function TField_ImportedConstraint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImportedConstraint: string read <getter> write <...

  if IsGet then
    Result := TField(AObj).ImportedConstraint
  else
    TField(AObj).ImportedConstraint := string(AArgs[0]);
end;

function TField_LookupDataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LookupDataSet: TDataSet read <getter> write <set...

  if IsGet then
    Result := TDataSet_sw.ToVar(TField(AObj).LookupDataSet)
  else
    TField(AObj).LookupDataSet := TDataSet_sw.FromVar(AArgs[0]);
end;

function TField_LookupKeyFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LookupKeyFields: string read <getter> write <set...

  if IsGet then
    Result := TField(AObj).LookupKeyFields
  else
    TField(AObj).LookupKeyFields := string(AArgs[0]);
end;

function TField_LookupResultField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LookupResultField: string read <getter> write <s...

  if IsGet then
    Result := TField(AObj).LookupResultField
  else
    TField(AObj).LookupResultField := string(AArgs[0]);
end;

function TField_KeyFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeyFields: string read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).KeyFields
  else
    TField(AObj).KeyFields := string(AArgs[0]);
end;

function TField_LookupCache_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LookupCache: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).LookupCache
  else
    TField(AObj).LookupCache := Boolean(AArgs[0]);
end;

function TField_Origin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Origin: string read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).Origin
  else
    TField(AObj).Origin := string(AArgs[0]);
end;

function TField_ProviderFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ProviderFlags: TProviderFlags read <getter> writ...

  if IsGet then
    Result := TProviderFlags_sw.ToVar(TField(AObj).ProviderFlags)
  else
    TField(AObj).ProviderFlags := TProviderFlags_sw.FromVar(AArgs[0]);
end;

function TField_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).ReadOnly
  else
    TField(AObj).ReadOnly := Boolean(AArgs[0]);
end;

function TField_Required_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Required: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).Required
  else
    TField(AObj).Required := Boolean(AArgs[0]);
end;

function TField_Visible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Visible: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TField(AObj).Visible
  else
    TField(AObj).Visible := Boolean(AArgs[0]);
end;

function TField_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TFieldNotifyEvent read <getter> write ...

  if IsGet then
    Result := TFieldNotifyEvent_sw.ToVar(TField(AObj).OnChange)
  else
    TField(AObj).OnChange := TFieldNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TField_OnGetText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetText: TFieldGetTextEvent read <getter> writ...

  if IsGet then
    Result := TFieldGetTextEvent_sw.ToVar(TField(AObj).OnGetText)
  else
    TField(AObj).OnGetText := TFieldGetTextEvent_sw.FromVar(AArgs[0]);
end;

function TField_OnSetText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSetText: TFieldSetTextEvent read <getter> writ...

  if IsGet then
    Result := TFieldSetTextEvent_sw.ToVar(TField(AObj).OnSetText)
  else
    TField(AObj).OnSetText := TFieldSetTextEvent_sw.FromVar(AArgs[0]);
end;

function TField_OnValidate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnValidate: TFieldNotifyEvent read <getter> writ...

  if IsGet then
    Result := TFieldNotifyEvent_sw.ToVar(TField(AObj).OnValidate)
  else
    TField(AObj).OnValidate := TFieldNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TField_sw.GetTypeName: WideString;
begin
  Result := 'TField';
end;

class function TField_sw.GetWrappedClass: TClass;
begin
  Result := TField;
end;

class procedure TField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Clear', TField_Clear_si, 0, False);
  AData.AddProcedure('FocusControl', TField_FocusControl_si, 0, False);
  AData.AddFunction('IsValidChar', TField_IsValidChar_si, Boolean_sw, 1, False);
  AData.AddProcedure('RefreshLookupList', TField_RefreshLookupList_si, 0, False);
  AData.AddProcedure('SetFieldType', TField_SetFieldType_si, 1, False);
  AData.AddProperty('AsBoolean', TField_AsBoolean_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AsCurrency', TField_AsCurrency_si, Currency_sw, True, True, 0, False, False);
  AData.AddProperty('AsDateTime', TField_AsDateTime_si, TDateTime_sw, True, True, 0, False, False);
  AData.AddProperty('AsSingle', TField_AsSingle_si, Single_sw, True, True, 0, False, False);
  AData.AddProperty('AsFloat', TField_AsFloat_si, Double_sw, True, True, 0, False, False);
  AData.AddProperty('AsExtended', TField_AsExtended_si, Extended_sw, True, True, 0, False, False);
  AData.AddProperty('AsInteger', TField_AsInteger_si, Longint_sw, True, True, 0, False, False);
  AData.AddProperty('AsLargeInt', TField_AsLargeInt_si, Largeint_sw, True, True, 0, False, False);
  AData.AddProperty('AsLongWord', TField_AsLongWord_si, LongWord_sw, True, True, 0, False, False);
  AData.AddProperty('AsString', TField_AsString_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('AsWideString', TField_AsWideString_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('AsAnsiString', TField_AsAnsiString_si, AnsiString_sw, True, True, 0, False, False);
  AData.AddProperty('AsVariant', TField_AsVariant_si, Variant_sw, True, True, 0, False, False);
  AData.AddProperty('AttributeSet', TField_AttributeSet_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Calculated', TField_Calculated_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('CanModify', TField_CanModify_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('CurValue', TField_CurValue_si, Variant_sw, True, False, 0, False, False);
  AData.AddProperty('DataSet', TField_DataSet_si, TDataSet_sw, True, True, 0, False, False);
  AData.AddProperty('DataSize', TField_DataSize_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('DataType', TField_DataType_si, TFieldType_sw, True, False, 0, False, False);
  AData.AddProperty('DisplayName', TField_DisplayName_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('DisplayText', TField_DisplayText_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('EditMask', TField_EditMask_si, TEditMask_sw, True, True, 0, False, False);
  AData.AddProperty('EditMaskPtr', TField_EditMaskPtr_si, TEditMask_sw, True, False, 0, False, False);
  AData.AddProperty('FieldNo', TField_FieldNo_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('FullName', TField_FullName_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('IsIndexField', TField_IsIndexField_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('IsNull', TField_IsNull_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Lookup', TField_Lookup_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('LookupList', TField_LookupList_si, TLookupList_sw, True, False, 0, False, False);
  AData.AddProperty('NewValue', TField_NewValue_si, Variant_sw, True, True, 0, False, False);
  AData.AddProperty('Offset', TField_Offset_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('OldValue', TField_OldValue_si, Variant_sw, True, False, 0, False, False);
  AData.AddProperty('ParentField', TField_ParentField_si, TObjectField_sw, True, True, 0, False, False);
  AData.AddProperty('Size', TField_Size_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Text', TField_Text_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ValidChars', TField_ValidChars_si, TFieldChars_sw, True, True, 0, False, False);
  AData.AddProperty('Value', TField_Value_si, Variant_sw, True, True, 0, False, False);
  AData.AddProperty('Alignment', TField_Alignment_si, TAlignment_sw, True, True, 0, False, False);
  AData.AddProperty('AutoGenerateValue', TField_AutoGenerateValue_si, TAutoRefreshFlag_sw, True, True, 0, False, False);
  AData.AddProperty('CustomConstraint', TField_CustomConstraint_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ConstraintErrorMessage', TField_ConstraintErrorMessage_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('DefaultExpression', TField_DefaultExpression_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('DisplayLabel', TField_DisplayLabel_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('DisplayWidth', TField_DisplayWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('FieldKind', TField_FieldKind_si, TFieldKind_sw, True, True, 0, False, False);
  AData.AddProperty('FieldName', TField_FieldName_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('HasConstraints', TField_HasConstraints_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Index', TField_Index_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ImportedConstraint', TField_ImportedConstraint_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('LookupDataSet', TField_LookupDataSet_si, TDataSet_sw, True, True, 0, False, False);
  AData.AddProperty('LookupKeyFields', TField_LookupKeyFields_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('LookupResultField', TField_LookupResultField_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('KeyFields', TField_KeyFields_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('LookupCache', TField_LookupCache_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Origin', TField_Origin_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ProviderFlags', TField_ProviderFlags_si, TProviderFlags_sw, True, True, 0, False, False);
  AData.AddProperty('ReadOnly', TField_ReadOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Required', TField_Required_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Visible', TField_Visible_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnChange', TField_OnChange_si, TFieldNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnGetText', TField_OnGetText_si, TFieldGetTextEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSetText', TField_OnSetText_si, TFieldSetTextEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnValidate', TField_OnValidate_si, TFieldNotifyEvent_sw, True, True, 0, False, False);

  { Class members }

  AData.AddClassFunction('IsBlob', TField_IsBlob_si, Boolean_sw, 0, False);
end;

class function TField_sw.ToVar(const AValue: TField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TField_sw.FromVar(const AValue: OleVariant): TField;
begin
  Result := TField(ConvFromVar(AValue, TField));
end;

class function TField_sw.ClassToVar(AClass: TField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TField_sw.ClassFromVar(const AClass: OleVariant): TField_sc;
begin
  Result := TField_sc(ConvClsFromVar(AClass, TField));
end;

{ TStringField_sw }

function TStringField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: AnsiString read <getter> write <setter>;

  if IsGet then
    Result := TStringField(AObj).Value
  else
    TStringField(AObj).Value := AnsiString(AArgs[0]);
end;

function TStringField_FixedChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FixedChar: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TStringField(AObj).FixedChar
  else
    TStringField(AObj).FixedChar := Boolean(AArgs[0]);
end;

function TStringField_Transliterate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Transliterate: Boolean read <getter> write <sett...

  if IsGet then
    Result := TStringField(AObj).Transliterate
  else
    TStringField(AObj).Transliterate := Boolean(AArgs[0]);
end;

class function TStringField_sw.GetTypeName: WideString;
begin
  Result := 'TStringField';
end;

class function TStringField_sw.GetWrappedClass: TClass;
begin
  Result := TStringField;
end;

class procedure TStringField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TStringField_Value_si, AnsiString_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('EditMask', False);
  AData.AddProperty('FixedChar', TStringField_FixedChar_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Size', False);
  AData.AddProperty('Transliterate', TStringField_Transliterate_si, Boolean_sw, True, True, 0, False, False);
end;

class function TStringField_sw.ToVar(const AValue: TStringField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStringField_sw.FromVar(const AValue: OleVariant): TStringField;
begin
  Result := TStringField(ConvFromVar(AValue, TStringField));
end;

class function TStringField_sw.ClassToVar(AClass: TStringField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStringField_sw.ClassFromVar(
  const AClass: OleVariant): TStringField_sc;
begin
  Result := TStringField_sc(ConvClsFromVar(AClass, TStringField));
end;

{ TWideStringField_sw }

function TWideStringField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: string read <getter> write <setter>;

  if IsGet then
    Result := TWideStringField(AObj).Value
  else
    TWideStringField(AObj).Value := string(AArgs[0]);
end;

class function TWideStringField_sw.GetTypeName: WideString;
begin
  Result := 'TWideStringField';
end;

class function TWideStringField_sw.GetWrappedClass: TClass;
begin
  Result := TWideStringField;
end;

class procedure TWideStringField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TWideStringField_Value_si, string_sw, True, True, 0, False, False);
end;

class function TWideStringField_sw.ToVar(
  const AValue: TWideStringField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWideStringField_sw.FromVar(
  const AValue: OleVariant): TWideStringField;
begin
  Result := TWideStringField(ConvFromVar(AValue, TWideStringField));
end;

class function TWideStringField_sw.ClassToVar(
  AClass: TWideStringField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWideStringField_sw.ClassFromVar(
  const AClass: OleVariant): TWideStringField_sc;
begin
  Result := TWideStringField_sc(ConvClsFromVar(AClass, TWideStringField));
end;

{ TNumericField_sw }

function TNumericField_DisplayFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayFormat: string read <getter> write <setter>;

  if IsGet then
    Result := TNumericField(AObj).DisplayFormat
  else
    TNumericField(AObj).DisplayFormat := string(AArgs[0]);
end;

function TNumericField_EditFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EditFormat: string read <getter> write <setter>;

  if IsGet then
    Result := TNumericField(AObj).EditFormat
  else
    TNumericField(AObj).EditFormat := string(AArgs[0]);
end;

class function TNumericField_sw.GetTypeName: WideString;
begin
  Result := 'TNumericField';
end;

class function TNumericField_sw.GetWrappedClass: TClass;
begin
  Result := TNumericField;
end;

class procedure TNumericField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Alignment', False);
  AData.AddProperty('DisplayFormat', TNumericField_DisplayFormat_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('EditFormat', TNumericField_EditFormat_si, string_sw, True, True, 0, False, False);
end;

class function TNumericField_sw.ToVar(const AValue: TNumericField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TNumericField_sw.FromVar(
  const AValue: OleVariant): TNumericField;
begin
  Result := TNumericField(ConvFromVar(AValue, TNumericField));
end;

class function TNumericField_sw.ClassToVar(
  AClass: TNumericField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TNumericField_sw.ClassFromVar(
  const AClass: OleVariant): TNumericField_sc;
begin
  Result := TNumericField_sc(ConvClsFromVar(AClass, TNumericField));
end;

{ TIntegerField_sw }

function TIntegerField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: Longint read <getter> write <setter>;

  if IsGet then
    Result := TIntegerField(AObj).Value
  else
    TIntegerField(AObj).Value := Longint(AArgs[0]);
end;

function TIntegerField_MaxValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxValue: Longint read <getter> write <setter>;

  if IsGet then
    Result := TIntegerField(AObj).MaxValue
  else
    TIntegerField(AObj).MaxValue := Longint(AArgs[0]);
end;

function TIntegerField_MinValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinValue: Longint read <getter> write <setter>;

  if IsGet then
    Result := TIntegerField(AObj).MinValue
  else
    TIntegerField(AObj).MinValue := Longint(AArgs[0]);
end;

class function TIntegerField_sw.GetTypeName: WideString;
begin
  Result := 'TIntegerField';
end;

class function TIntegerField_sw.GetWrappedClass: TClass;
begin
  Result := TIntegerField;
end;

class procedure TIntegerField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TIntegerField_Value_si, Longint_sw, True, True, 0, False, False);
  AData.AddProperty('MaxValue', TIntegerField_MaxValue_si, Longint_sw, True, True, 0, False, False);
  AData.AddProperty('MinValue', TIntegerField_MinValue_si, Longint_sw, True, True, 0, False, False);
end;

class function TIntegerField_sw.ToVar(const AValue: TIntegerField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TIntegerField_sw.FromVar(
  const AValue: OleVariant): TIntegerField;
begin
  Result := TIntegerField(ConvFromVar(AValue, TIntegerField));
end;

class function TIntegerField_sw.ClassToVar(
  AClass: TIntegerField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TIntegerField_sw.ClassFromVar(
  const AClass: OleVariant): TIntegerField_sc;
begin
  Result := TIntegerField_sc(ConvClsFromVar(AClass, TIntegerField));
end;

{ TLongWordField_sw }

function TLongWordField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: LongWord read <getter> write <setter>;

  if IsGet then
    Result := TLongWordField(AObj).Value
  else
    TLongWordField(AObj).Value := LongWord(AArgs[0]);
end;

function TLongWordField_MaxValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxValue: LongWord read <getter> write <setter>;

  if IsGet then
    Result := TLongWordField(AObj).MaxValue
  else
    TLongWordField(AObj).MaxValue := LongWord(AArgs[0]);
end;

function TLongWordField_MinValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinValue: LongWord read <getter> write <setter>;

  if IsGet then
    Result := TLongWordField(AObj).MinValue
  else
    TLongWordField(AObj).MinValue := LongWord(AArgs[0]);
end;

class function TLongWordField_sw.GetTypeName: WideString;
begin
  Result := 'TLongWordField';
end;

class function TLongWordField_sw.GetWrappedClass: TClass;
begin
  Result := TLongWordField;
end;

class procedure TLongWordField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TLongWordField_Value_si, LongWord_sw, True, True, 0, False, False);
  AData.AddProperty('MaxValue', TLongWordField_MaxValue_si, LongWord_sw, True, True, 0, False, False);
  AData.AddProperty('MinValue', TLongWordField_MinValue_si, LongWord_sw, True, True, 0, False, False);
end;

class function TLongWordField_sw.ToVar(
  const AValue: TLongWordField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TLongWordField_sw.FromVar(
  const AValue: OleVariant): TLongWordField;
begin
  Result := TLongWordField(ConvFromVar(AValue, TLongWordField));
end;

class function TLongWordField_sw.ClassToVar(
  AClass: TLongWordField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TLongWordField_sw.ClassFromVar(
  const AClass: OleVariant): TLongWordField_sc;
begin
  Result := TLongWordField_sc(ConvClsFromVar(AClass, TLongWordField));
end;

{ TSmallintField_sw }

class function TSmallintField_sw.GetTypeName: WideString;
begin
  Result := 'TSmallintField';
end;

class function TSmallintField_sw.GetWrappedClass: TClass;
begin
  Result := TSmallintField;
end;

class procedure TSmallintField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TSmallintField_sw.ToVar(
  const AValue: TSmallintField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSmallintField_sw.FromVar(
  const AValue: OleVariant): TSmallintField;
begin
  Result := TSmallintField(ConvFromVar(AValue, TSmallintField));
end;

class function TSmallintField_sw.ClassToVar(
  AClass: TSmallintField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSmallintField_sw.ClassFromVar(
  const AClass: OleVariant): TSmallintField_sc;
begin
  Result := TSmallintField_sc(ConvClsFromVar(AClass, TSmallintField));
end;

{ TShortintField_sw }

class function TShortintField_sw.GetTypeName: WideString;
begin
  Result := 'TShortintField';
end;

class function TShortintField_sw.GetWrappedClass: TClass;
begin
  Result := TShortintField;
end;

class procedure TShortintField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TShortintField_sw.ToVar(
  const AValue: TShortintField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TShortintField_sw.FromVar(
  const AValue: OleVariant): TShortintField;
begin
  Result := TShortintField(ConvFromVar(AValue, TShortintField));
end;

class function TShortintField_sw.ClassToVar(
  AClass: TShortintField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TShortintField_sw.ClassFromVar(
  const AClass: OleVariant): TShortintField_sc;
begin
  Result := TShortintField_sc(ConvClsFromVar(AClass, TShortintField));
end;

{ TByteField_sw }

class function TByteField_sw.GetTypeName: WideString;
begin
  Result := 'TByteField';
end;

class function TByteField_sw.GetWrappedClass: TClass;
begin
  Result := TByteField;
end;

class procedure TByteField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TByteField_sw.ToVar(const AValue: TByteField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TByteField_sw.FromVar(const AValue: OleVariant): TByteField;
begin
  Result := TByteField(ConvFromVar(AValue, TByteField));
end;

class function TByteField_sw.ClassToVar(AClass: TByteField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TByteField_sw.ClassFromVar(
  const AClass: OleVariant): TByteField_sc;
begin
  Result := TByteField_sc(ConvClsFromVar(AClass, TByteField));
end;

{ TLargeintField_sw }

function TLargeintField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: Largeint read <getter> write <setter>;

  if IsGet then
    Result := Largeint_sw.ToVar(TLargeintField(AObj).Value)
  else
    TLargeintField(AObj).Value := Largeint_sw.FromVar(AArgs[0]);
end;

function TLargeintField_MaxValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxValue: Largeint read <getter> write <setter>;

  if IsGet then
    Result := Largeint_sw.ToVar(TLargeintField(AObj).MaxValue)
  else
    TLargeintField(AObj).MaxValue := Largeint_sw.FromVar(AArgs[0]);
end;

function TLargeintField_MinValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinValue: Largeint read <getter> write <setter>;

  if IsGet then
    Result := Largeint_sw.ToVar(TLargeintField(AObj).MinValue)
  else
    TLargeintField(AObj).MinValue := Largeint_sw.FromVar(AArgs[0]);
end;

class function TLargeintField_sw.GetTypeName: WideString;
begin
  Result := 'TLargeintField';
end;

class function TLargeintField_sw.GetWrappedClass: TClass;
begin
  Result := TLargeintField;
end;

class procedure TLargeintField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TLargeintField_Value_si, Largeint_sw, True, True, 0, False, False);
  AData.AddProperty('MaxValue', TLargeintField_MaxValue_si, Largeint_sw, True, True, 0, False, False);
  AData.AddProperty('MinValue', TLargeintField_MinValue_si, Largeint_sw, True, True, 0, False, False);
end;

class function TLargeintField_sw.ToVar(
  const AValue: TLargeintField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TLargeintField_sw.FromVar(
  const AValue: OleVariant): TLargeintField;
begin
  Result := TLargeintField(ConvFromVar(AValue, TLargeintField));
end;

class function TLargeintField_sw.ClassToVar(
  AClass: TLargeintField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TLargeintField_sw.ClassFromVar(
  const AClass: OleVariant): TLargeintField_sc;
begin
  Result := TLargeintField_sc(ConvClsFromVar(AClass, TLargeintField));
end;

{ TWordField_sw }

class function TWordField_sw.GetTypeName: WideString;
begin
  Result := 'TWordField';
end;

class function TWordField_sw.GetWrappedClass: TClass;
begin
  Result := TWordField;
end;

class procedure TWordField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TWordField_sw.ToVar(const AValue: TWordField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWordField_sw.FromVar(const AValue: OleVariant): TWordField;
begin
  Result := TWordField(ConvFromVar(AValue, TWordField));
end;

class function TWordField_sw.ClassToVar(AClass: TWordField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWordField_sw.ClassFromVar(
  const AClass: OleVariant): TWordField_sc;
begin
  Result := TWordField_sc(ConvClsFromVar(AClass, TWordField));
end;

{ TAutoIncField_sw }

class function TAutoIncField_sw.GetTypeName: WideString;
begin
  Result := 'TAutoIncField';
end;

class function TAutoIncField_sw.GetWrappedClass: TClass;
begin
  Result := TAutoIncField;
end;

class procedure TAutoIncField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TAutoIncField_sw.ToVar(const AValue: TAutoIncField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TAutoIncField_sw.FromVar(
  const AValue: OleVariant): TAutoIncField;
begin
  Result := TAutoIncField(ConvFromVar(AValue, TAutoIncField));
end;

class function TAutoIncField_sw.ClassToVar(
  AClass: TAutoIncField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TAutoIncField_sw.ClassFromVar(
  const AClass: OleVariant): TAutoIncField_sc;
begin
  Result := TAutoIncField_sc(ConvClsFromVar(AClass, TAutoIncField));
end;

{ TUnsignedAutoIncField_sw }

class function TUnsignedAutoIncField_sw.GetTypeName: WideString;
begin
  Result := 'TUnsignedAutoIncField';
end;

class function TUnsignedAutoIncField_sw.GetWrappedClass: TClass;
begin
  Result := TUnsignedAutoIncField;
end;

class procedure TUnsignedAutoIncField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TUnsignedAutoIncField_sw.ToVar(
  const AValue: TUnsignedAutoIncField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TUnsignedAutoIncField_sw.FromVar(
  const AValue: OleVariant): TUnsignedAutoIncField;
begin
  Result := TUnsignedAutoIncField(ConvFromVar(AValue, TUnsignedAutoIncField));
end;

class function TUnsignedAutoIncField_sw.ClassToVar(
  AClass: TUnsignedAutoIncField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TUnsignedAutoIncField_sw.ClassFromVar(
  const AClass: OleVariant): TUnsignedAutoIncField_sc;
begin
  Result := TUnsignedAutoIncField_sc(ConvClsFromVar(AClass, 
    TUnsignedAutoIncField));
end;

{ TFloatField_sw }

function TFloatField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: Double read <getter> write <setter>;

  if IsGet then
    Result := TFloatField(AObj).Value
  else
    TFloatField(AObj).Value := Double(AArgs[0]);
end;

function TFloatField_currency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property currency: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TFloatField(AObj).currency
  else
    TFloatField(AObj).currency := Boolean(AArgs[0]);
end;

function TFloatField_MaxValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxValue: Double read <getter> write <setter>;

  if IsGet then
    Result := TFloatField(AObj).MaxValue
  else
    TFloatField(AObj).MaxValue := Double(AArgs[0]);
end;

function TFloatField_MinValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinValue: Double read <getter> write <setter>;

  if IsGet then
    Result := TFloatField(AObj).MinValue
  else
    TFloatField(AObj).MinValue := Double(AArgs[0]);
end;

function TFloatField_Precision_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Precision: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFloatField(AObj).Precision
  else
    TFloatField(AObj).Precision := Integer(AArgs[0]);
end;

class function TFloatField_sw.GetTypeName: WideString;
begin
  Result := 'TFloatField';
end;

class function TFloatField_sw.GetWrappedClass: TClass;
begin
  Result := TFloatField;
end;

class procedure TFloatField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TFloatField_Value_si, Double_sw, True, True, 0, False, False);
  AData.AddProperty('currency', TFloatField_currency_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('MaxValue', TFloatField_MaxValue_si, Double_sw, True, True, 0, False, False);
  AData.AddProperty('MinValue', TFloatField_MinValue_si, Double_sw, True, True, 0, False, False);
  AData.AddProperty('Precision', TFloatField_Precision_si, Integer_sw, True, True, 0, False, False);
end;

class function TFloatField_sw.ToVar(const AValue: TFloatField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFloatField_sw.FromVar(const AValue: OleVariant): TFloatField;
begin
  Result := TFloatField(ConvFromVar(AValue, TFloatField));
end;

class function TFloatField_sw.ClassToVar(AClass: TFloatField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFloatField_sw.ClassFromVar(
  const AClass: OleVariant): TFloatField_sc;
begin
  Result := TFloatField_sc(ConvClsFromVar(AClass, TFloatField));
end;

{ TSingleField_sw }

function TSingleField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: Single read <getter> write <setter>;

  if IsGet then
    Result := TSingleField(AObj).Value
  else
    TSingleField(AObj).Value := Single(AArgs[0]);
end;

function TSingleField_currency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property currency: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TSingleField(AObj).currency
  else
    TSingleField(AObj).currency := Boolean(AArgs[0]);
end;

function TSingleField_MaxValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxValue: Single read <getter> write <setter>;

  if IsGet then
    Result := TSingleField(AObj).MaxValue
  else
    TSingleField(AObj).MaxValue := Single(AArgs[0]);
end;

function TSingleField_MinValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinValue: Single read <getter> write <setter>;

  if IsGet then
    Result := TSingleField(AObj).MinValue
  else
    TSingleField(AObj).MinValue := Single(AArgs[0]);
end;

function TSingleField_Precision_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Precision: Integer read <getter> write <setter>;

  if IsGet then
    Result := TSingleField(AObj).Precision
  else
    TSingleField(AObj).Precision := Integer(AArgs[0]);
end;

class function TSingleField_sw.GetTypeName: WideString;
begin
  Result := 'TSingleField';
end;

class function TSingleField_sw.GetWrappedClass: TClass;
begin
  Result := TSingleField;
end;

class procedure TSingleField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TSingleField_Value_si, Single_sw, True, True, 0, False, False);
  AData.AddProperty('currency', TSingleField_currency_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('MaxValue', TSingleField_MaxValue_si, Single_sw, True, True, 0, False, False);
  AData.AddProperty('MinValue', TSingleField_MinValue_si, Single_sw, True, True, 0, False, False);
  AData.AddProperty('Precision', TSingleField_Precision_si, Integer_sw, True, True, 0, False, False);
end;

class function TSingleField_sw.ToVar(const AValue: TSingleField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSingleField_sw.FromVar(const AValue: OleVariant): TSingleField;
begin
  Result := TSingleField(ConvFromVar(AValue, TSingleField));
end;

class function TSingleField_sw.ClassToVar(AClass: TSingleField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSingleField_sw.ClassFromVar(
  const AClass: OleVariant): TSingleField_sc;
begin
  Result := TSingleField_sc(ConvClsFromVar(AClass, TSingleField));
end;

{ TCurrencyField_sw }

class function TCurrencyField_sw.GetTypeName: WideString;
begin
  Result := 'TCurrencyField';
end;

class function TCurrencyField_sw.GetWrappedClass: TClass;
begin
  Result := TCurrencyField;
end;

class procedure TCurrencyField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('currency', False);
end;

class function TCurrencyField_sw.ToVar(
  const AValue: TCurrencyField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCurrencyField_sw.FromVar(
  const AValue: OleVariant): TCurrencyField;
begin
  Result := TCurrencyField(ConvFromVar(AValue, TCurrencyField));
end;

class function TCurrencyField_sw.ClassToVar(
  AClass: TCurrencyField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCurrencyField_sw.ClassFromVar(
  const AClass: OleVariant): TCurrencyField_sc;
begin
  Result := TCurrencyField_sc(ConvClsFromVar(AClass, TCurrencyField));
end;

{ TExtendedField_sw }

function TExtendedField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: Extended read <getter> write <setter>;

  if IsGet then
    Result := TExtendedField(AObj).Value
  else
    TExtendedField(AObj).Value := Extended(AArgs[0]);
end;

function TExtendedField_currency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property currency: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TExtendedField(AObj).currency
  else
    TExtendedField(AObj).currency := Boolean(AArgs[0]);
end;

function TExtendedField_MaxValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxValue: Extended read <getter> write <setter>;

  if IsGet then
    Result := TExtendedField(AObj).MaxValue
  else
    TExtendedField(AObj).MaxValue := Extended(AArgs[0]);
end;

function TExtendedField_MinValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinValue: Extended read <getter> write <setter>;

  if IsGet then
    Result := TExtendedField(AObj).MinValue
  else
    TExtendedField(AObj).MinValue := Extended(AArgs[0]);
end;

function TExtendedField_Precision_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Precision: Integer read <getter> write <setter>;

  if IsGet then
    Result := TExtendedField(AObj).Precision
  else
    TExtendedField(AObj).Precision := Integer(AArgs[0]);
end;

class function TExtendedField_sw.GetTypeName: WideString;
begin
  Result := 'TExtendedField';
end;

class function TExtendedField_sw.GetWrappedClass: TClass;
begin
  Result := TExtendedField;
end;

class procedure TExtendedField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TExtendedField_Value_si, Extended_sw, True, True, 0, False, False);
  AData.AddProperty('currency', TExtendedField_currency_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('MaxValue', TExtendedField_MaxValue_si, Extended_sw, True, True, 0, False, False);
  AData.AddProperty('MinValue', TExtendedField_MinValue_si, Extended_sw, True, True, 0, False, False);
  AData.AddProperty('Precision', TExtendedField_Precision_si, Integer_sw, True, True, 0, False, False);
end;

class function TExtendedField_sw.ToVar(
  const AValue: TExtendedField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TExtendedField_sw.FromVar(
  const AValue: OleVariant): TExtendedField;
begin
  Result := TExtendedField(ConvFromVar(AValue, TExtendedField));
end;

class function TExtendedField_sw.ClassToVar(
  AClass: TExtendedField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TExtendedField_sw.ClassFromVar(
  const AClass: OleVariant): TExtendedField_sc;
begin
  Result := TExtendedField_sc(ConvClsFromVar(AClass, TExtendedField));
end;

{ TBooleanField_sw }

function TBooleanField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TBooleanField(AObj).Value
  else
    TBooleanField(AObj).Value := Boolean(AArgs[0]);
end;

function TBooleanField_DisplayValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayValues: string read <getter> write <setter>;

  if IsGet then
    Result := TBooleanField(AObj).DisplayValues
  else
    TBooleanField(AObj).DisplayValues := string(AArgs[0]);
end;

class function TBooleanField_sw.GetTypeName: WideString;
begin
  Result := 'TBooleanField';
end;

class function TBooleanField_sw.GetWrappedClass: TClass;
begin
  Result := TBooleanField;
end;

class procedure TBooleanField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TBooleanField_Value_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('DisplayValues', TBooleanField_DisplayValues_si, string_sw, True, True, 0, False, False);
end;

class function TBooleanField_sw.ToVar(const AValue: TBooleanField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBooleanField_sw.FromVar(
  const AValue: OleVariant): TBooleanField;
begin
  Result := TBooleanField(ConvFromVar(AValue, TBooleanField));
end;

class function TBooleanField_sw.ClassToVar(
  AClass: TBooleanField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBooleanField_sw.ClassFromVar(
  const AClass: OleVariant): TBooleanField_sc;
begin
  Result := TBooleanField_sc(ConvClsFromVar(AClass, TBooleanField));
end;

{ TDateTimeField_sw }

function TDateTimeField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: TDateTime read <getter> write <setter>;

  if IsGet then
    Result := TDateTime_sw.ToVar(TDateTimeField(AObj).Value)
  else
    TDateTimeField(AObj).Value := TDateTime_sw.FromVar(AArgs[0]);
end;

function TDateTimeField_DisplayFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayFormat: string read <getter> write <setter>;

  if IsGet then
    Result := TDateTimeField(AObj).DisplayFormat
  else
    TDateTimeField(AObj).DisplayFormat := string(AArgs[0]);
end;

class function TDateTimeField_sw.GetTypeName: WideString;
begin
  Result := 'TDateTimeField';
end;

class function TDateTimeField_sw.GetWrappedClass: TClass;
begin
  Result := TDateTimeField;
end;

class procedure TDateTimeField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TDateTimeField_Value_si, TDateTime_sw, True, True, 0, False, False);
  AData.AddProperty('DisplayFormat', TDateTimeField_DisplayFormat_si, string_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('EditMask', False);
end;

class function TDateTimeField_sw.ToVar(
  const AValue: TDateTimeField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDateTimeField_sw.FromVar(
  const AValue: OleVariant): TDateTimeField;
begin
  Result := TDateTimeField(ConvFromVar(AValue, TDateTimeField));
end;

class function TDateTimeField_sw.ClassToVar(
  AClass: TDateTimeField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDateTimeField_sw.ClassFromVar(
  const AClass: OleVariant): TDateTimeField_sc;
begin
  Result := TDateTimeField_sc(ConvClsFromVar(AClass, TDateTimeField));
end;

{ TSQLTimeStampField_sw }

function TSQLTimeStampField_DisplayFormat_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayFormat: string read <getter> write <setter>;

  if IsGet then
    Result := TSQLTimeStampField(AObj).DisplayFormat
  else
    TSQLTimeStampField(AObj).DisplayFormat := string(AArgs[0]);
end;

class function TSQLTimeStampField_sw.GetTypeName: WideString;
begin
  Result := 'TSQLTimeStampField';
end;

class function TSQLTimeStampField_sw.GetWrappedClass: TClass;
begin
  Result := TSQLTimeStampField;
end;

class procedure TSQLTimeStampField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DisplayFormat', TSQLTimeStampField_DisplayFormat_si, string_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('EditMask', False);
end;

class function TSQLTimeStampField_sw.ToVar(
  const AValue: TSQLTimeStampField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSQLTimeStampField_sw.FromVar(
  const AValue: OleVariant): TSQLTimeStampField;
begin
  Result := TSQLTimeStampField(ConvFromVar(AValue, TSQLTimeStampField));
end;

class function TSQLTimeStampField_sw.ClassToVar(
  AClass: TSQLTimeStampField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSQLTimeStampField_sw.ClassFromVar(
  const AClass: OleVariant): TSQLTimeStampField_sc;
begin
  Result := TSQLTimeStampField_sc(ConvClsFromVar(AClass, TSQLTimeStampField));
end;

{ TSQLTimeStampOffsetField_sw }

class function TSQLTimeStampOffsetField_sw.GetTypeName: WideString;
begin
  Result := 'TSQLTimeStampOffsetField';
end;

class function TSQLTimeStampOffsetField_sw.GetWrappedClass: TClass;
begin
  Result := TSQLTimeStampOffsetField;
end;

class procedure TSQLTimeStampOffsetField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TSQLTimeStampOffsetField_sw.ToVar(
  const AValue: TSQLTimeStampOffsetField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSQLTimeStampOffsetField_sw.FromVar(
  const AValue: OleVariant): TSQLTimeStampOffsetField;
begin
  Result := TSQLTimeStampOffsetField(ConvFromVar(AValue, 
    TSQLTimeStampOffsetField));
end;

class function TSQLTimeStampOffsetField_sw.ClassToVar(
  AClass: TSQLTimeStampOffsetField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSQLTimeStampOffsetField_sw.ClassFromVar(
  const AClass: OleVariant): TSQLTimeStampOffsetField_sc;
begin
  Result := TSQLTimeStampOffsetField_sc(ConvClsFromVar(AClass, 
    TSQLTimeStampOffsetField));
end;

{ TDateField_sw }

class function TDateField_sw.GetTypeName: WideString;
begin
  Result := 'TDateField';
end;

class function TDateField_sw.GetWrappedClass: TClass;
begin
  Result := TDateField;
end;

class procedure TDateField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TDateField_sw.ToVar(const AValue: TDateField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDateField_sw.FromVar(const AValue: OleVariant): TDateField;
begin
  Result := TDateField(ConvFromVar(AValue, TDateField));
end;

class function TDateField_sw.ClassToVar(AClass: TDateField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDateField_sw.ClassFromVar(
  const AClass: OleVariant): TDateField_sc;
begin
  Result := TDateField_sc(ConvClsFromVar(AClass, TDateField));
end;

{ TTimeField_sw }

class function TTimeField_sw.GetTypeName: WideString;
begin
  Result := 'TTimeField';
end;

class function TTimeField_sw.GetWrappedClass: TClass;
begin
  Result := TTimeField;
end;

class procedure TTimeField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TTimeField_sw.ToVar(const AValue: TTimeField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTimeField_sw.FromVar(const AValue: OleVariant): TTimeField;
begin
  Result := TTimeField(ConvFromVar(AValue, TTimeField));
end;

class function TTimeField_sw.ClassToVar(AClass: TTimeField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTimeField_sw.ClassFromVar(
  const AClass: OleVariant): TTimeField_sc;
begin
  Result := TTimeField_sc(ConvClsFromVar(AClass, TTimeField));
end;

{ TBinaryField_sw }

class function TBinaryField_sw.GetTypeName: WideString;
begin
  Result := 'TBinaryField';
end;

class function TBinaryField_sw.GetWrappedClass: TClass;
begin
  Result := TBinaryField;
end;

class procedure TBinaryField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Size', False);
end;

class function TBinaryField_sw.ToVar(const AValue: TBinaryField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBinaryField_sw.FromVar(const AValue: OleVariant): TBinaryField;
begin
  Result := TBinaryField(ConvFromVar(AValue, TBinaryField));
end;

class function TBinaryField_sw.ClassToVar(AClass: TBinaryField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBinaryField_sw.ClassFromVar(
  const AClass: OleVariant): TBinaryField_sc;
begin
  Result := TBinaryField_sc(ConvClsFromVar(AClass, TBinaryField));
end;

{ TBytesField_sw }

class function TBytesField_sw.GetTypeName: WideString;
begin
  Result := 'TBytesField';
end;

class function TBytesField_sw.GetWrappedClass: TClass;
begin
  Result := TBytesField;
end;

class procedure TBytesField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TBytesField_sw.ToVar(const AValue: TBytesField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBytesField_sw.FromVar(const AValue: OleVariant): TBytesField;
begin
  Result := TBytesField(ConvFromVar(AValue, TBytesField));
end;

class function TBytesField_sw.ClassToVar(AClass: TBytesField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBytesField_sw.ClassFromVar(
  const AClass: OleVariant): TBytesField_sc;
begin
  Result := TBytesField_sc(ConvClsFromVar(AClass, TBytesField));
end;

{ TVarBytesField_sw }

class function TVarBytesField_sw.GetTypeName: WideString;
begin
  Result := 'TVarBytesField';
end;

class function TVarBytesField_sw.GetWrappedClass: TClass;
begin
  Result := TVarBytesField;
end;

class procedure TVarBytesField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TVarBytesField_sw.ToVar(
  const AValue: TVarBytesField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TVarBytesField_sw.FromVar(
  const AValue: OleVariant): TVarBytesField;
begin
  Result := TVarBytesField(ConvFromVar(AValue, TVarBytesField));
end;

class function TVarBytesField_sw.ClassToVar(
  AClass: TVarBytesField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TVarBytesField_sw.ClassFromVar(
  const AClass: OleVariant): TVarBytesField_sc;
begin
  Result := TVarBytesField_sc(ConvClsFromVar(AClass, TVarBytesField));
end;

{ TBCDField_sw }

function TBCDField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: Currency read <getter> write <setter>;

  if IsGet then
    Result := TBCDField(AObj).Value
  else
    TBCDField(AObj).Value := Currency(AArgs[0]);
end;

function TBCDField_currency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property currency: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TBCDField(AObj).currency
  else
    TBCDField(AObj).currency := Boolean(AArgs[0]);
end;

function TBCDField_MaxValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxValue: Currency read <getter> write <setter>;

  if IsGet then
    Result := TBCDField(AObj).MaxValue
  else
    TBCDField(AObj).MaxValue := Currency(AArgs[0]);
end;

function TBCDField_MinValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinValue: Currency read <getter> write <setter>;

  if IsGet then
    Result := TBCDField(AObj).MinValue
  else
    TBCDField(AObj).MinValue := Currency(AArgs[0]);
end;

function TBCDField_Precision_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Precision: Integer read <getter> write <setter>;

  if IsGet then
    Result := TBCDField(AObj).Precision
  else
    TBCDField(AObj).Precision := Integer(AArgs[0]);
end;

class function TBCDField_sw.GetTypeName: WideString;
begin
  Result := 'TBCDField';
end;

class function TBCDField_sw.GetWrappedClass: TClass;
begin
  Result := TBCDField;
end;

class procedure TBCDField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TBCDField_Value_si, Currency_sw, True, True, 0, False, False);
  AData.AddProperty('currency', TBCDField_currency_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('MaxValue', TBCDField_MaxValue_si, Currency_sw, True, True, 0, False, False);
  AData.AddProperty('MinValue', TBCDField_MinValue_si, Currency_sw, True, True, 0, False, False);
  AData.AddProperty('Precision', TBCDField_Precision_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Size', False);
end;

class function TBCDField_sw.ToVar(const AValue: TBCDField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBCDField_sw.FromVar(const AValue: OleVariant): TBCDField;
begin
  Result := TBCDField(ConvFromVar(AValue, TBCDField));
end;

class function TBCDField_sw.ClassToVar(AClass: TBCDField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBCDField_sw.ClassFromVar(
  const AClass: OleVariant): TBCDField_sc;
begin
  Result := TBCDField_sc(ConvClsFromVar(AClass, TBCDField));
end;

{ TFMTBCDField_sw }

function TFMTBCDField_currency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property currency: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TFMTBCDField(AObj).currency
  else
    TFMTBCDField(AObj).currency := Boolean(AArgs[0]);
end;

function TFMTBCDField_MaxValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxValue: string read <getter> write <setter>;

  if IsGet then
    Result := TFMTBCDField(AObj).MaxValue
  else
    TFMTBCDField(AObj).MaxValue := string(AArgs[0]);
end;

function TFMTBCDField_MinValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinValue: string read <getter> write <setter>;

  if IsGet then
    Result := TFMTBCDField(AObj).MinValue
  else
    TFMTBCDField(AObj).MinValue := string(AArgs[0]);
end;

function TFMTBCDField_Precision_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Precision: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFMTBCDField(AObj).Precision
  else
    TFMTBCDField(AObj).Precision := Integer(AArgs[0]);
end;

class function TFMTBCDField_sw.GetTypeName: WideString;
begin
  Result := 'TFMTBCDField';
end;

class function TFMTBCDField_sw.GetWrappedClass: TClass;
begin
  Result := TFMTBCDField;
end;

class procedure TFMTBCDField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('currency', TFMTBCDField_currency_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('MaxValue', TFMTBCDField_MaxValue_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('MinValue', TFMTBCDField_MinValue_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Precision', TFMTBCDField_Precision_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Size', False);
end;

class function TFMTBCDField_sw.ToVar(const AValue: TFMTBCDField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFMTBCDField_sw.FromVar(const AValue: OleVariant): TFMTBCDField;
begin
  Result := TFMTBCDField(ConvFromVar(AValue, TFMTBCDField));
end;

class function TFMTBCDField_sw.ClassToVar(AClass: TFMTBCDField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFMTBCDField_sw.ClassFromVar(
  const AClass: OleVariant): TFMTBCDField_sc;
begin
  Result := TFMTBCDField_sc(ConvClsFromVar(AClass, TFMTBCDField));
end;

{ TBlobType_sw }

class function TBlobType_sw.GetTypeName: WideString;
begin
  Result := 'TBlobType';
end;

class function TBlobType_sw.ToVar(const AValue: TBlobType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBlobType_sw.FromVar(const AValue: OleVariant): TBlobType;
begin
  Result := TBlobType(Integer(AValue));
end;

{ TBlobField_sw }

function TBlobField_LoadFromFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromFile(const FileName: string);

  TBlobField(AObj).LoadFromFile(string(AArgs[0]));
end;

function TBlobField_LoadFromStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromStream(Stream: TStream);

  TBlobField(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]));
end;

function TBlobField_SaveToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToFile(const FileName: string);

  TBlobField(AObj).SaveToFile(string(AArgs[0]));
end;

function TBlobField_SaveToStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToStream(Stream: TStream);

  TBlobField(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]));
end;

function TBlobField_BlobSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BlobSize: Integer read <getter>;

  Result := TBlobField(AObj).BlobSize;
end;

function TBlobField_Modified_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Modified: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TBlobField(AObj).Modified
  else
    TBlobField(AObj).Modified := Boolean(AArgs[0]);
end;

function TBlobField_Transliterate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Transliterate: Boolean read <getter> write <sett...

  if IsGet then
    Result := TBlobField(AObj).Transliterate
  else
    TBlobField(AObj).Transliterate := Boolean(AArgs[0]);
end;

function TBlobField_BlobType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BlobType: TBlobType read <getter> write <setter>;

  if IsGet then
    Result := TBlobType_sw.ToVar(TBlobField(AObj).BlobType)
  else
    TBlobField(AObj).BlobType := TBlobType_sw.FromVar(AArgs[0]);
end;

function TBlobField_GraphicHeader_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GraphicHeader: Boolean read <getter> write <sett...

  if IsGet then
    Result := TBlobField(AObj).GraphicHeader
  else
    TBlobField(AObj).GraphicHeader := Boolean(AArgs[0]);
end;

class function TBlobField_sw.GetTypeName: WideString;
begin
  Result := 'TBlobField';
end;

class function TBlobField_sw.GetWrappedClass: TClass;
begin
  Result := TBlobField;
end;

class procedure TBlobField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('LoadFromFile', TBlobField_LoadFromFile_si, 1, False);
  AData.AddProcedure('LoadFromStream', TBlobField_LoadFromStream_si, 1, False);
  AData.AddProcedure('SaveToFile', TBlobField_SaveToFile_si, 1, False);
  AData.AddProcedure('SaveToStream', TBlobField_SaveToStream_si, 1, False);
  AData.AddProperty('BlobSize', TBlobField_BlobSize_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Modified', TBlobField_Modified_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Transliterate', TBlobField_Transliterate_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('BlobType', TBlobField_BlobType_si, TBlobType_sw, True, True, 0, False, False);
  AData.AddProperty('GraphicHeader', TBlobField_GraphicHeader_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Size', False);
end;

class function TBlobField_sw.ToVar(const AValue: TBlobField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBlobField_sw.FromVar(const AValue: OleVariant): TBlobField;
begin
  Result := TBlobField(ConvFromVar(AValue, TBlobField));
end;

class function TBlobField_sw.ClassToVar(AClass: TBlobField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBlobField_sw.ClassFromVar(
  const AClass: OleVariant): TBlobField_sc;
begin
  Result := TBlobField_sc(ConvClsFromVar(AClass, TBlobField));
end;

{ TMemoField_sw }

function TMemoField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: AnsiString read <getter> write <setter>;

  if IsGet then
    Result := TMemoField(AObj).Value
  else
    TMemoField(AObj).Value := AnsiString(AArgs[0]);
end;

class function TMemoField_sw.GetTypeName: WideString;
begin
  Result := 'TMemoField';
end;

class function TMemoField_sw.GetWrappedClass: TClass;
begin
  Result := TMemoField;
end;

class procedure TMemoField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TMemoField_Value_si, AnsiString_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Transliterate', False);
end;

class function TMemoField_sw.ToVar(const AValue: TMemoField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMemoField_sw.FromVar(const AValue: OleVariant): TMemoField;
begin
  Result := TMemoField(ConvFromVar(AValue, TMemoField));
end;

class function TMemoField_sw.ClassToVar(AClass: TMemoField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMemoField_sw.ClassFromVar(
  const AClass: OleVariant): TMemoField_sc;
begin
  Result := TMemoField_sc(ConvClsFromVar(AClass, TMemoField));
end;

{ TWideMemoField_sw }

function TWideMemoField_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: string read <getter> write <setter>;

  if IsGet then
    Result := TWideMemoField(AObj).Value
  else
    TWideMemoField(AObj).Value := string(AArgs[0]);
end;

class function TWideMemoField_sw.GetTypeName: WideString;
begin
  Result := 'TWideMemoField';
end;

class function TWideMemoField_sw.GetWrappedClass: TClass;
begin
  Result := TWideMemoField;
end;

class procedure TWideMemoField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TWideMemoField_Value_si, string_sw, True, True, 0, False, False);
end;

class function TWideMemoField_sw.ToVar(
  const AValue: TWideMemoField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWideMemoField_sw.FromVar(
  const AValue: OleVariant): TWideMemoField;
begin
  Result := TWideMemoField(ConvFromVar(AValue, TWideMemoField));
end;

class function TWideMemoField_sw.ClassToVar(
  AClass: TWideMemoField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWideMemoField_sw.ClassFromVar(
  const AClass: OleVariant): TWideMemoField_sc;
begin
  Result := TWideMemoField_sc(ConvClsFromVar(AClass, TWideMemoField));
end;

{ TGraphicField_sw }

class function TGraphicField_sw.GetTypeName: WideString;
begin
  Result := 'TGraphicField';
end;

class function TGraphicField_sw.GetWrappedClass: TClass;
begin
  Result := TGraphicField;
end;

class procedure TGraphicField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TGraphicField_sw.ToVar(const AValue: TGraphicField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TGraphicField_sw.FromVar(
  const AValue: OleVariant): TGraphicField;
begin
  Result := TGraphicField(ConvFromVar(AValue, TGraphicField));
end;

class function TGraphicField_sw.ClassToVar(
  AClass: TGraphicField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TGraphicField_sw.ClassFromVar(
  const AClass: OleVariant): TGraphicField_sc;
begin
  Result := TGraphicField_sc(ConvClsFromVar(AClass, TGraphicField));
end;

{ TObjectField_sw }

function TObjectField_FieldCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldCount: Integer read <getter>;

  Result := TObjectField(AObj).FieldCount;
end;

function TObjectField_Fields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Fields: TFields read <getter>;

  Result := TFields_sw.ToVar(TObjectField(AObj).Fields);
end;

function TObjectField_FieldValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldValues[Index: Integer]: Variant read <gette...

  if IsGet then
    Result := TObjectField(AObj).FieldValues[Integer(AArgs[0])]
  else
    TObjectField(AObj).FieldValues[Integer(AArgs[0])] := Variant(FindVarData(
      AArgs[1])^);
end;

function TObjectField_UnNamed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UnNamed: Boolean read <getter>;

  Result := TObjectField(AObj).UnNamed;
end;

function TObjectField_ObjectType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ObjectType: string read <getter> write <setter>;

  if IsGet then
    Result := TObjectField(AObj).ObjectType
  else
    TObjectField(AObj).ObjectType := string(AArgs[0]);
end;

class function TObjectField_sw.GetTypeName: WideString;
begin
  Result := 'TObjectField';
end;

class function TObjectField_sw.GetWrappedClass: TClass;
begin
  Result := TObjectField;
end;

class procedure TObjectField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('FieldCount', TObjectField_FieldCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Fields', TObjectField_Fields_si, TFields_sw, True, False, 0, False, False);
  AData.AddProperty('FieldValues', TObjectField_FieldValues_si, Variant_sw, True, True, 1, False, True);
  AData.AddProperty('UnNamed', TObjectField_UnNamed_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('ObjectType', TObjectField_ObjectType_si, string_sw, True, True, 0, False, False);
end;

class function TObjectField_sw.ToVar(const AValue: TObjectField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TObjectField_sw.FromVar(const AValue: OleVariant): TObjectField;
begin
  Result := TObjectField(ConvFromVar(AValue, TObjectField));
end;

class function TObjectField_sw.ClassToVar(AClass: TObjectField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TObjectField_sw.ClassFromVar(
  const AClass: OleVariant): TObjectField_sc;
begin
  Result := TObjectField_sc(ConvClsFromVar(AClass, TObjectField));
end;

{ TADTField_sw }

class function TADTField_sw.GetTypeName: WideString;
begin
  Result := 'TADTField';
end;

class function TADTField_sw.GetWrappedClass: TClass;
begin
  Result := TADTField;
end;

class procedure TADTField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TADTField_sw.ToVar(const AValue: TADTField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TADTField_sw.FromVar(const AValue: OleVariant): TADTField;
begin
  Result := TADTField(ConvFromVar(AValue, TADTField));
end;

class function TADTField_sw.ClassToVar(AClass: TADTField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TADTField_sw.ClassFromVar(
  const AClass: OleVariant): TADTField_sc;
begin
  Result := TADTField_sc(ConvClsFromVar(AClass, TADTField));
end;

{ TArrayField_sw }

class function TArrayField_sw.GetTypeName: WideString;
begin
  Result := 'TArrayField';
end;

class function TArrayField_sw.GetWrappedClass: TClass;
begin
  Result := TArrayField;
end;

class procedure TArrayField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Size', False);
end;

class function TArrayField_sw.ToVar(const AValue: TArrayField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TArrayField_sw.FromVar(const AValue: OleVariant): TArrayField;
begin
  Result := TArrayField(ConvFromVar(AValue, TArrayField));
end;

class function TArrayField_sw.ClassToVar(AClass: TArrayField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TArrayField_sw.ClassFromVar(
  const AClass: OleVariant): TArrayField_sc;
begin
  Result := TArrayField_sc(ConvClsFromVar(AClass, TArrayField));
end;

{ TDataSetField_sw }

function TDataSetField_NestedDataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NestedDataSet: TDataSet read <getter>;

  Result := TDataSet_sw.ToVar(TDataSetField(AObj).NestedDataSet);
end;

function TDataSetField_IncludeObjectField_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IncludeObjectField: Boolean read <getter> write ...

  if IsGet then
    Result := TDataSetField(AObj).IncludeObjectField
  else
    TDataSetField(AObj).IncludeObjectField := Boolean(AArgs[0]);
end;

class function TDataSetField_sw.GetTypeName: WideString;
begin
  Result := 'TDataSetField';
end;

class function TDataSetField_sw.GetWrappedClass: TClass;
begin
  Result := TDataSetField;
end;

class procedure TDataSetField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('NestedDataSet', TDataSetField_NestedDataSet_si, TDataSet_sw, True, False, 0, False, False);
  AData.AddProperty('IncludeObjectField', TDataSetField_IncludeObjectField_si, Boolean_sw, True, True, 0, False, False);
end;

class function TDataSetField_sw.ToVar(const AValue: TDataSetField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDataSetField_sw.FromVar(
  const AValue: OleVariant): TDataSetField;
begin
  Result := TDataSetField(ConvFromVar(AValue, TDataSetField));
end;

class function TDataSetField_sw.ClassToVar(
  AClass: TDataSetField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDataSetField_sw.ClassFromVar(
  const AClass: OleVariant): TDataSetField_sc;
begin
  Result := TDataSetField_sc(ConvClsFromVar(AClass, TDataSetField));
end;

{ TReferenceField_sw }

function TReferenceField_ReferenceTableName_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReferenceTableName: string read <getter> write <...

  if IsGet then
    Result := TReferenceField(AObj).ReferenceTableName
  else
    TReferenceField(AObj).ReferenceTableName := string(AArgs[0]);
end;

class function TReferenceField_sw.GetTypeName: WideString;
begin
  Result := 'TReferenceField';
end;

class function TReferenceField_sw.GetWrappedClass: TClass;
begin
  Result := TReferenceField;
end;

class procedure TReferenceField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ReferenceTableName', TReferenceField_ReferenceTableName_si, string_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Size', False);
end;

class function TReferenceField_sw.ToVar(
  const AValue: TReferenceField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TReferenceField_sw.FromVar(
  const AValue: OleVariant): TReferenceField;
begin
  Result := TReferenceField(ConvFromVar(AValue, TReferenceField));
end;

class function TReferenceField_sw.ClassToVar(
  AClass: TReferenceField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TReferenceField_sw.ClassFromVar(
  const AClass: OleVariant): TReferenceField_sc;
begin
  Result := TReferenceField_sc(ConvClsFromVar(AClass, TReferenceField));
end;

{ TVariantField_sw }

class function TVariantField_sw.GetTypeName: WideString;
begin
  Result := 'TVariantField';
end;

class function TVariantField_sw.GetWrappedClass: TClass;
begin
  Result := TVariantField;
end;

class procedure TVariantField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TVariantField_sw.ToVar(const AValue: TVariantField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TVariantField_sw.FromVar(
  const AValue: OleVariant): TVariantField;
begin
  Result := TVariantField(ConvFromVar(AValue, TVariantField));
end;

class function TVariantField_sw.ClassToVar(
  AClass: TVariantField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TVariantField_sw.ClassFromVar(
  const AClass: OleVariant): TVariantField_sc;
begin
  Result := TVariantField_sc(ConvClsFromVar(AClass, TVariantField));
end;

{ TInterfaceField_sw }

class function TInterfaceField_sw.GetTypeName: WideString;
begin
  Result := 'TInterfaceField';
end;

class function TInterfaceField_sw.GetWrappedClass: TClass;
begin
  Result := TInterfaceField;
end;

class procedure TInterfaceField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TInterfaceField_sw.ToVar(
  const AValue: TInterfaceField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TInterfaceField_sw.FromVar(
  const AValue: OleVariant): TInterfaceField;
begin
  Result := TInterfaceField(ConvFromVar(AValue, TInterfaceField));
end;

class function TInterfaceField_sw.ClassToVar(
  AClass: TInterfaceField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TInterfaceField_sw.ClassFromVar(
  const AClass: OleVariant): TInterfaceField_sc;
begin
  Result := TInterfaceField_sc(ConvClsFromVar(AClass, TInterfaceField));
end;

{ TIDispatchField_sw }

class function TIDispatchField_sw.GetTypeName: WideString;
begin
  Result := 'TIDispatchField';
end;

class function TIDispatchField_sw.GetWrappedClass: TClass;
begin
  Result := TIDispatchField;
end;

class procedure TIDispatchField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TIDispatchField_sw.ToVar(
  const AValue: TIDispatchField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TIDispatchField_sw.FromVar(
  const AValue: OleVariant): TIDispatchField;
begin
  Result := TIDispatchField(ConvFromVar(AValue, TIDispatchField));
end;

class function TIDispatchField_sw.ClassToVar(
  AClass: TIDispatchField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TIDispatchField_sw.ClassFromVar(
  const AClass: OleVariant): TIDispatchField_sc;
begin
  Result := TIDispatchField_sc(ConvClsFromVar(AClass, TIDispatchField));
end;

{ TGuidField_sw }

function TGuidField_AsGuid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsGuid: TGUID read <getter> write <setter>;

  if IsGet then
    Result := TGUID_sw.ToVar(TGuidField(AObj).AsGuid)
  else
    TGuidField(AObj).AsGuid := TGUID_sw.FromVar(AArgs[0]);
end;

class function TGuidField_sw.GetTypeName: WideString;
begin
  Result := 'TGuidField';
end;

class function TGuidField_sw.GetWrappedClass: TClass;
begin
  Result := TGuidField;
end;

class procedure TGuidField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('AsGuid', TGuidField_AsGuid_si, TGUID_sw, True, True, 0, False, False);
end;

class function TGuidField_sw.ToVar(const AValue: TGuidField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TGuidField_sw.FromVar(const AValue: OleVariant): TGuidField;
begin
  Result := TGuidField(ConvFromVar(AValue, TGuidField));
end;

class function TGuidField_sw.ClassToVar(AClass: TGuidField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TGuidField_sw.ClassFromVar(
  const AClass: OleVariant): TGuidField_sc;
begin
  Result := TGuidField_sc(ConvClsFromVar(AClass, TGuidField));
end;

{ TAggregateField_sw }

function TAggregateField_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: TAggHandle read <getter> write <setter>;

  if IsGet then
    Result := TAggHandle_sw.ToVar(TAggregateField(AObj).Handle)
  else
    TAggregateField(AObj).Handle := TAggHandle_sw.FromVar(AArgs[0]);
end;

function TAggregateField_ResultType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ResultType: TFieldType read <getter> write <sett...

  if IsGet then
    Result := TFieldType_sw.ToVar(TAggregateField(AObj).ResultType)
  else
    TAggregateField(AObj).ResultType := TFieldType_sw.FromVar(AArgs[0]);
end;

function TAggregateField_Active_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Active: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TAggregateField(AObj).Active
  else
    TAggregateField(AObj).Active := Boolean(AArgs[0]);
end;

function TAggregateField_currency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property currency: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TAggregateField(AObj).currency
  else
    TAggregateField(AObj).currency := Boolean(AArgs[0]);
end;

function TAggregateField_DisplayName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayName: string read <getter> write <setter>;

  if IsGet then
    Result := TAggregateField(AObj).DisplayName
  else
    TAggregateField(AObj).DisplayName := string(AArgs[0]);
end;

function TAggregateField_DisplayFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayFormat: string read <getter> write <setter>;

  if IsGet then
    Result := TAggregateField(AObj).DisplayFormat
  else
    TAggregateField(AObj).DisplayFormat := string(AArgs[0]);
end;

function TAggregateField_Expression_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Expression: string read <getter> write <setter>;

  if IsGet then
    Result := TAggregateField(AObj).Expression
  else
    TAggregateField(AObj).Expression := string(AArgs[0]);
end;

function TAggregateField_GroupingLevel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GroupingLevel: Integer read <getter> write <sett...

  if IsGet then
    Result := TAggregateField(AObj).GroupingLevel
  else
    TAggregateField(AObj).GroupingLevel := Integer(AArgs[0]);
end;

function TAggregateField_IndexName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexName: string read <getter> write <setter>;

  if IsGet then
    Result := TAggregateField(AObj).IndexName
  else
    TAggregateField(AObj).IndexName := string(AArgs[0]);
end;

function TAggregateField_Precision_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Precision: Integer read <getter> write <setter>;

  if IsGet then
    Result := TAggregateField(AObj).Precision
  else
    TAggregateField(AObj).Precision := Integer(AArgs[0]);
end;

class function TAggregateField_sw.GetTypeName: WideString;
begin
  Result := 'TAggregateField';
end;

class function TAggregateField_sw.GetWrappedClass: TClass;
begin
  Result := TAggregateField;
end;

class procedure TAggregateField_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Handle', TAggregateField_Handle_si, TAggHandle_sw, True, True, 0, False, False);
  AData.AddProperty('ResultType', TAggregateField_ResultType_si, TFieldType_sw, True, True, 0, False, False);
  AData.AddProperty('Active', TAggregateField_Active_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('currency', TAggregateField_currency_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('DisplayName', TAggregateField_DisplayName_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('DisplayFormat', TAggregateField_DisplayFormat_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Expression', TAggregateField_Expression_si, string_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('FieldKind', False);
  AData.AddProperty('GroupingLevel', TAggregateField_GroupingLevel_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('IndexName', TAggregateField_IndexName_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Precision', TAggregateField_Precision_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Visible', False);
end;

class function TAggregateField_sw.ToVar(
  const AValue: TAggregateField): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TAggregateField_sw.FromVar(
  const AValue: OleVariant): TAggregateField;
begin
  Result := TAggregateField(ConvFromVar(AValue, TAggregateField));
end;

class function TAggregateField_sw.ClassToVar(
  AClass: TAggregateField_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TAggregateField_sw.ClassFromVar(
  const AClass: OleVariant): TAggregateField_sc;
begin
  Result := TAggregateField_sc(ConvClsFromVar(AClass, TAggregateField));
end;

{ TDataLink_sw }

function TDataLink_VisualControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property VisualControl: Boolean read <getter> w...

  if IsGet then
    Result := TDataLink_sacc(TDataLink(AObj)).VisualControl
  else
    TDataLink_sacc(TDataLink(AObj)).VisualControl := Boolean(AArgs[0]);
end;

function TDataLink_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TDataLink_sw.ToVar(TDataLink_sc(AObj).Create());
end;

function TDataLink_Edit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Edit: Boolean;

  Result := TDataLink(AObj).Edit();
end;

function TDataLink_ExecuteAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExecuteAction(Action: TBasicAction): Boolean;

  Result := TDataLink(AObj).ExecuteAction(TBasicAction_sw.FromVar(AArgs[0]));
end;

function TDataLink_UpdateAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UpdateAction(Action: TBasicAction): Boolean;

  Result := TDataLink(AObj).UpdateAction(TBasicAction_sw.FromVar(AArgs[0]));
end;

function TDataLink_UpdateRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UpdateRecord;

  TDataLink(AObj).UpdateRecord();
end;

function TDataLink_Active_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Active: Boolean read <getter>;

  Result := TDataLink(AObj).Active;
end;

function TDataLink_ActiveRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActiveRecord: Integer read <getter> write <setter>;

  if IsGet then
    Result := TDataLink(AObj).ActiveRecord
  else
    TDataLink(AObj).ActiveRecord := Integer(AArgs[0]);
end;

function TDataLink_BOF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BOF: Boolean read <getter>;

  Result := TDataLink(AObj).BOF;
end;

function TDataLink_BufferCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BufferCount: Integer read <getter> write <setter>;

  if IsGet then
    Result := TDataLink(AObj).BufferCount
  else
    TDataLink(AObj).BufferCount := Integer(AArgs[0]);
end;

function TDataLink_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSet: TDataSet read <getter>;

  Result := TDataSet_sw.ToVar(TDataLink(AObj).DataSet);
end;

function TDataLink_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDataLink(AObj).DataSource)
  else
    TDataLink(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TDataLink_DataSourceFixed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSourceFixed: Boolean read <getter> write <se...

  if IsGet then
    Result := TDataLink(AObj).DataSourceFixed
  else
    TDataLink(AObj).DataSourceFixed := Boolean(AArgs[0]);
end;

function TDataLink_Editing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Editing: Boolean read <getter>;

  Result := TDataLink(AObj).Editing;
end;

function TDataLink_Eof_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Eof: Boolean read <getter>;

  Result := TDataLink(AObj).Eof;
end;

function TDataLink_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDataLink(AObj).ReadOnly
  else
    TDataLink(AObj).ReadOnly := Boolean(AArgs[0]);
end;

function TDataLink_RecordCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RecordCount: Integer read <getter>;

  Result := TDataLink(AObj).RecordCount;
end;

class function TDataLink_sw.GetTypeName: WideString;
begin
  Result := 'TDataLink';
end;

class function TDataLink_sw.GetWrappedClass: TClass;
begin
  Result := TDataLink;
end;

class procedure TDataLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('VisualControl', TDataLink_VisualControl_si, Boolean_sw, True, True, 0, True, False);
  AData.AddFunction('Edit', TDataLink_Edit_si, Boolean_sw, 0, False);
  AData.AddFunction('ExecuteAction', TDataLink_ExecuteAction_si, Boolean_sw, 1, False);
  AData.AddFunction('UpdateAction', TDataLink_UpdateAction_si, Boolean_sw, 1, False);
  AData.AddProcedure('UpdateRecord', TDataLink_UpdateRecord_si, 0, False);
  AData.AddProperty('Active', TDataLink_Active_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('ActiveRecord', TDataLink_ActiveRecord_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('BOF', TDataLink_BOF_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('BufferCount', TDataLink_BufferCount_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('DataSet', TDataLink_DataSet_si, TDataSet_sw, True, False, 0, False, False);
  AData.AddProperty('DataSource', TDataLink_DataSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddProperty('DataSourceFixed', TDataLink_DataSourceFixed_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Editing', TDataLink_Editing_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Eof', TDataLink_Eof_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('ReadOnly', TDataLink_ReadOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('RecordCount', TDataLink_RecordCount_si, Integer_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TDataLink_Create_si, 0, False);
end;

class function TDataLink_sw.ToVar(const AValue: TDataLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDataLink_sw.FromVar(const AValue: OleVariant): TDataLink;
begin
  Result := TDataLink(ConvFromVar(AValue, TDataLink));
end;

class function TDataLink_sw.ClassToVar(AClass: TDataLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDataLink_sw.ClassFromVar(
  const AClass: OleVariant): TDataLink_sc;
begin
  Result := TDataLink_sc(ConvClsFromVar(AClass, TDataLink));
end;

{ TDetailDataLink_sw }

function TDetailDataLink_DetailDataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DetailDataSet: TDataSet read <getter>;

  Result := TDataSet_sw.ToVar(TDetailDataLink(AObj).DetailDataSet);
end;

class function TDetailDataLink_sw.GetTypeName: WideString;
begin
  Result := 'TDetailDataLink';
end;

class function TDetailDataLink_sw.GetWrappedClass: TClass;
begin
  Result := TDetailDataLink;
end;

class procedure TDetailDataLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DetailDataSet', TDetailDataLink_DetailDataSet_si, TDataSet_sw, True, False, 0, False, False);
end;

class function TDetailDataLink_sw.ToVar(
  const AValue: TDetailDataLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDetailDataLink_sw.FromVar(
  const AValue: OleVariant): TDetailDataLink;
begin
  Result := TDetailDataLink(ConvFromVar(AValue, TDetailDataLink));
end;

class function TDetailDataLink_sw.ClassToVar(
  AClass: TDetailDataLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDetailDataLink_sw.ClassFromVar(
  const AClass: OleVariant): TDetailDataLink_sc;
begin
  Result := TDetailDataLink_sc(ConvClsFromVar(AClass, TDetailDataLink));
end;

{ TMasterDataLink_sw }

function TMasterDataLink_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(DataSet: TDataSet);

  Result := TMasterDataLink_sw.ToVar(TMasterDataLink_sc(AObj).Create(
    TDataSet_sw.FromVar(AArgs[0])));
end;

function TMasterDataLink_FieldNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldNames: string read <getter> write <setter>;

  if IsGet then
    Result := TMasterDataLink(AObj).FieldNames
  else
    TMasterDataLink(AObj).FieldNames := string(AArgs[0]);
end;

function TMasterDataLink_OnMasterChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnMasterChange: TNotifyEvent read <getter> write...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TMasterDataLink(AObj).OnMasterChange)
  else
    TMasterDataLink(AObj).OnMasterChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TMasterDataLink_OnMasterDisable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnMasterDisable: TNotifyEvent read <getter> writ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TMasterDataLink(AObj).OnMasterDisable)
  else
    TMasterDataLink(AObj).OnMasterDisable := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TMasterDataLink_sw.GetTypeName: WideString;
begin
  Result := 'TMasterDataLink';
end;

class function TMasterDataLink_sw.GetWrappedClass: TClass;
begin
  Result := TMasterDataLink;
end;

class procedure TMasterDataLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('FieldNames', TMasterDataLink_FieldNames_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('OnMasterChange', TMasterDataLink_OnMasterChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnMasterDisable', TMasterDataLink_OnMasterDisable_si, TNotifyEvent_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TMasterDataLink_Create_si, 1, False);
end;

class function TMasterDataLink_sw.ToVar(
  const AValue: TMasterDataLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMasterDataLink_sw.FromVar(
  const AValue: OleVariant): TMasterDataLink;
begin
  Result := TMasterDataLink(ConvFromVar(AValue, TMasterDataLink));
end;

class function TMasterDataLink_sw.ClassToVar(
  AClass: TMasterDataLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMasterDataLink_sw.ClassFromVar(
  const AClass: OleVariant): TMasterDataLink_sc;
begin
  Result := TMasterDataLink_sc(ConvClsFromVar(AClass, TMasterDataLink));
end;

{ TDataChangeEvent_sh }

function TDataChangeEvent_sh.GetHandler: TMethod;
var
  hdr: TDataChangeEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDataChangeEvent_sh.Handler(Sender: TObject; Field: TField);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Field: TField) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TField_sw.ToVar(Field);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TDataChangeEvent_sw }

class function TDataChangeEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDataChangeEvent';
end;

class function TDataChangeEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDataChangeEvent_sh;
end;

class function TDataChangeEvent_sw.ToVar(
  const AValue: TDataChangeEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDataChangeEvent_sw.FromVar(
  const AValue: OleVariant): TDataChangeEvent;
begin
  Result := TDataChangeEvent(ConvFromVar(AValue));
end;

class function TDataChangeEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TDataChangeEvent;
var
  hdlr: TDataChangeEvent_sh;
begin
  hdlr   := TDataChangeEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDataChangeEvent_sw));
  Result := hdlr.Handler;
end;

{ TDataSource_sw }

function TDataSource_Edit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Edit;

  TDataSource(AObj).Edit();
end;

function TDataSource_IsLinkedTo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsLinkedTo(DataSet: TDataSet): Boolean;

  Result := TDataSource(AObj).IsLinkedTo(TDataSet_sw.FromVar(AArgs[0]));
end;

function TDataSource_State_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property State: TDataSetState read <getter>;

  Result := TDataSetState_sw.ToVar(TDataSource(AObj).State);
end;

function TDataSource_AutoEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoEdit: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDataSource(AObj).AutoEdit
  else
    TDataSource(AObj).AutoEdit := Boolean(AArgs[0]);
end;

function TDataSource_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSet: TDataSet read <getter> write <setter>;

  if IsGet then
    Result := TDataSet_sw.ToVar(TDataSource(AObj).DataSet)
  else
    TDataSource(AObj).DataSet := TDataSet_sw.FromVar(AArgs[0]);
end;

function TDataSource_Enabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Enabled: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDataSource(AObj).Enabled
  else
    TDataSource(AObj).Enabled := Boolean(AArgs[0]);
end;

function TDataSource_OnStateChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnStateChange: TNotifyEvent read <getter> write ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TDataSource(AObj).OnStateChange)
  else
    TDataSource(AObj).OnStateChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSource_OnDataChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDataChange: TDataChangeEvent read <getter> wri...

  if IsGet then
    Result := TDataChangeEvent_sw.ToVar(TDataSource(AObj).OnDataChange)
  else
    TDataSource(AObj).OnDataChange := TDataChangeEvent_sw.FromVar(AArgs[0]);
end;

function TDataSource_OnUpdateData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnUpdateData: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TDataSource(AObj).OnUpdateData)
  else
    TDataSource(AObj).OnUpdateData := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TDataSource_sw.GetTypeName: WideString;
begin
  Result := 'TDataSource';
end;

class function TDataSource_sw.GetWrappedClass: TClass;
begin
  Result := TDataSource;
end;

class procedure TDataSource_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Edit', TDataSource_Edit_si, 0, False);
  AData.AddFunction('IsLinkedTo', TDataSource_IsLinkedTo_si, Boolean_sw, 1, False);
  AData.AddProperty('State', TDataSource_State_si, TDataSetState_sw, True, False, 0, False, False);
  AData.AddProperty('AutoEdit', TDataSource_AutoEdit_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('DataSet', TDataSource_DataSet_si, TDataSet_sw, True, True, 0, False, False);
  AData.AddProperty('Enabled', TDataSource_Enabled_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnStateChange', TDataSource_OnStateChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDataChange', TDataSource_OnDataChange_si, TDataChangeEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnUpdateData', TDataSource_OnUpdateData_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TDataSource_sw.ToVar(const AValue: TDataSource): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDataSource_sw.FromVar(const AValue: OleVariant): TDataSource;
begin
  Result := TDataSource(ConvFromVar(AValue, TDataSource));
end;

class function TDataSource_sw.ClassToVar(AClass: TDataSource_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDataSource_sw.ClassFromVar(
  const AClass: OleVariant): TDataSource_sc;
begin
  Result := TDataSource_sc(ConvClsFromVar(AClass, TDataSource));
end;

{ TDataSetDesigner_sw }

function TDataSetDesigner_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(DataSet: TDataSet);

  Result := TDataSetDesigner_sw.ToVar(TDataSetDesigner_sc(AObj).Create(
    TDataSet_sw.FromVar(AArgs[0])));
end;

function TDataSetDesigner_BeginDesign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginDesign;

  TDataSetDesigner(AObj).BeginDesign();
end;

function TDataSetDesigner_DataEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DataEvent(Event: TDataEvent; Info: NativeInt);

  TDataSetDesigner(AObj).DataEvent(TDataEvent_sw.FromVar(AArgs[0]), 
    NativeInt_sw.FromVar(AArgs[1]));
end;

function TDataSetDesigner_EndDesign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndDesign;

  TDataSetDesigner(AObj).EndDesign();
end;

function TDataSetDesigner_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSet: TDataSet read <getter>;

  Result := TDataSet_sw.ToVar(TDataSetDesigner(AObj).DataSet);
end;

class function TDataSetDesigner_sw.GetTypeName: WideString;
begin
  Result := 'TDataSetDesigner';
end;

class function TDataSetDesigner_sw.GetWrappedClass: TClass;
begin
  Result := TDataSetDesigner;
end;

class procedure TDataSetDesigner_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('BeginDesign', TDataSetDesigner_BeginDesign_si, 0, False);
  AData.AddProcedure('DataEvent', TDataSetDesigner_DataEvent_si, 2, False);
  AData.AddProcedure('EndDesign', TDataSetDesigner_EndDesign_si, 0, False);
  AData.AddProperty('DataSet', TDataSetDesigner_DataSet_si, TDataSet_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TDataSetDesigner_Create_si, 1, False);
end;

class function TDataSetDesigner_sw.ToVar(
  const AValue: TDataSetDesigner): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDataSetDesigner_sw.FromVar(
  const AValue: OleVariant): TDataSetDesigner;
begin
  Result := TDataSetDesigner(ConvFromVar(AValue, TDataSetDesigner));
end;

class function TDataSetDesigner_sw.ClassToVar(
  AClass: TDataSetDesigner_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDataSetDesigner_sw.ClassFromVar(
  const AClass: OleVariant): TDataSetDesigner_sc;
begin
  Result := TDataSetDesigner_sc(ConvClsFromVar(AClass, TDataSetDesigner));
end;

{ TCheckConstraint_sw }

function TCheckConstraint_CustomConstraint_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CustomConstraint: string read <getter> write <se...

  if IsGet then
    Result := TCheckConstraint(AObj).CustomConstraint
  else
    TCheckConstraint(AObj).CustomConstraint := string(AArgs[0]);
end;

function TCheckConstraint_ErrorMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ErrorMessage: string read <getter> write <setter>;

  if IsGet then
    Result := TCheckConstraint(AObj).ErrorMessage
  else
    TCheckConstraint(AObj).ErrorMessage := string(AArgs[0]);
end;

function TCheckConstraint_FromDictionary_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FromDictionary: Boolean read <getter> write <set...

  if IsGet then
    Result := TCheckConstraint(AObj).FromDictionary
  else
    TCheckConstraint(AObj).FromDictionary := Boolean(AArgs[0]);
end;

function TCheckConstraint_ImportedConstraint_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImportedConstraint: string read <getter> write <...

  if IsGet then
    Result := TCheckConstraint(AObj).ImportedConstraint
  else
    TCheckConstraint(AObj).ImportedConstraint := string(AArgs[0]);
end;

class function TCheckConstraint_sw.GetTypeName: WideString;
begin
  Result := 'TCheckConstraint';
end;

class function TCheckConstraint_sw.GetWrappedClass: TClass;
begin
  Result := TCheckConstraint;
end;

class procedure TCheckConstraint_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('CustomConstraint', TCheckConstraint_CustomConstraint_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ErrorMessage', TCheckConstraint_ErrorMessage_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('FromDictionary', TCheckConstraint_FromDictionary_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ImportedConstraint', TCheckConstraint_ImportedConstraint_si, string_sw, True, True, 0, False, False);
end;

class function TCheckConstraint_sw.ToVar(
  const AValue: TCheckConstraint): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCheckConstraint_sw.FromVar(
  const AValue: OleVariant): TCheckConstraint;
begin
  Result := TCheckConstraint(ConvFromVar(AValue, TCheckConstraint));
end;

class function TCheckConstraint_sw.ClassToVar(
  AClass: TCheckConstraint_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCheckConstraint_sw.ClassFromVar(
  const AClass: OleVariant): TCheckConstraint_sc;
begin
  Result := TCheckConstraint_sc(ConvClsFromVar(AClass, TCheckConstraint));
end;

{ TCheckConstraintClass_sw }

class function TCheckConstraintClass_sw.GetTypeName: WideString;
begin
  Result := 'TCheckConstraintClass';
end;

class function TCheckConstraintClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCheckConstraint;
end;

class function TCheckConstraintClass_sw.ToVar(
  const AValue: TCheckConstraintClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCheckConstraintClass_sw.FromVar(
  const AValue: OleVariant): TCheckConstraintClass;
begin
  Result := TCheckConstraintClass(ConvFromVar(AValue, TCheckConstraint));
end;

{ TCheckConstraints_sw }

function TCheckConstraints_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Owner: TPersistent);

  Result := TCheckConstraints_sw.ToVar(TCheckConstraints_sc(AObj).Create(
    TPersistent_sw.FromVar(AArgs[0])));
end;

function TCheckConstraints_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TCheckConstraint;

  Result := TCheckConstraint_sw.ToVar(TCheckConstraints(AObj).Add());
end;

function TCheckConstraints_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TCheckConstraint read <ge...

  if IsGet then
    Result := TCheckConstraint_sw.ToVar(TCheckConstraints(AObj).Items[Integer(
      AArgs[0])])
  else
    TCheckConstraints(AObj).Items[Integer(AArgs[0])] := TCheckConstraint_sw.
      FromVar(AArgs[1]);
end;

class function TCheckConstraints_sw.GetTypeName: WideString;
begin
  Result := 'TCheckConstraints';
end;

class function TCheckConstraints_sw.GetWrappedClass: TClass;
begin
  Result := TCheckConstraints;
end;

class procedure TCheckConstraints_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TCheckConstraints_Add_si, TCheckConstraint_sw, 0, False);
  AData.AddProperty('Items', TCheckConstraints_Items_si, TCheckConstraint_sw, True, True, 1, False, True);

  { Class members }

  AData.AddConstructor('Create', TCheckConstraints_Create_si, 1, False);
end;

class function TCheckConstraints_sw.ToVar(
  const AValue: TCheckConstraints): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCheckConstraints_sw.FromVar(
  const AValue: OleVariant): TCheckConstraints;
begin
  Result := TCheckConstraints(ConvFromVar(AValue, TCheckConstraints));
end;

class function TCheckConstraints_sw.ClassToVar(
  AClass: TCheckConstraints_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCheckConstraints_sw.ClassFromVar(
  const AClass: OleVariant): TCheckConstraints_sc;
begin
  Result := TCheckConstraints_sc(ConvClsFromVar(AClass, TCheckConstraints));
end;

{ TCheckConstraintsClass_sw }

class function TCheckConstraintsClass_sw.GetTypeName: WideString;
begin
  Result := 'TCheckConstraintsClass';
end;

class function TCheckConstraintsClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCheckConstraints;
end;

class function TCheckConstraintsClass_sw.ToVar(
  const AValue: TCheckConstraintsClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCheckConstraintsClass_sw.FromVar(
  const AValue: OleVariant): TCheckConstraintsClass;
begin
  Result := TCheckConstraintsClass(ConvFromVar(AValue, TCheckConstraints));
end;

{ TBitConverter_sw }

class function TBitConverter_sw.GetTypeName: WideString;
begin
  Result := 'TBitConverter';
end;

class function TBitConverter_sw.GetWrappedClass: TClass;
begin
  Result := TBitConverter;
end;

class procedure TBitConverter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TBitConverter_sw.ToVar(const AValue: TBitConverter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBitConverter_sw.FromVar(
  const AValue: OleVariant): TBitConverter;
begin
  Result := TBitConverter(ConvFromVar(AValue, TBitConverter));
end;

class function TBitConverter_sw.ClassToVar(
  AClass: TBitConverter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBitConverter_sw.ClassFromVar(
  const AClass: OleVariant): TBitConverter_sc;
begin
  Result := TBitConverter_sc(ConvClsFromVar(AClass, TBitConverter));
end;

{ TParamType_sw }

class function TParamType_sw.GetTypeName: WideString;
begin
  Result := 'TParamType';
end;

class procedure TParamType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'ptUnknown'; Value: Integer({$IFDEF LMDSCT_12}TParamType.{$ENDIF}ptUnknown)),
    (Name: 'ptInput'; Value: Integer({$IFDEF LMDSCT_12}TParamType.{$ENDIF}ptInput)),
    (Name: 'ptOutput'; Value: Integer({$IFDEF LMDSCT_12}TParamType.{$ENDIF}ptOutput)),
    (Name: 'ptInputOutput'; Value: Integer({$IFDEF LMDSCT_12}TParamType.{$ENDIF}ptInputOutput)),
    (Name: 'ptResult'; Value: Integer({$IFDEF LMDSCT_12}TParamType.{$ENDIF}ptResult))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TParamType_sw.ToVar(const AValue: TParamType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TParamType_sw.FromVar(const AValue: OleVariant): TParamType;
begin
  Result := TParamType(Integer(AValue));
end;

{ TParamTypes_sw }

class function TParamTypes_sw.GetTypeName: WideString;
begin
  Result := 'TParamTypes';
end;

class function TParamTypes_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TParamTypes);
end;

class function TParamTypes_sw.ToVar(const AValue: TParamTypes): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TParamTypes_sw.FromVar(const AValue: OleVariant): TParamTypes;
begin
  ConvFromVar(AValue, @Result);
end;

{ TParamObjectClass_sw }

class function TParamObjectClass_sw.GetTypeName: WideString;
begin
  Result := 'TParamObjectClass';
end;

class function TParamObjectClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TParamObject;
end;

class function TParamObjectClass_sw.ToVar(
  const AValue: TParamObjectClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TParamObjectClass_sw.FromVar(
  const AValue: OleVariant): TParamObjectClass;
begin
  Result := TParamObjectClass(ConvFromVar(AValue, TParamObject));
end;

{ TParam_sw }

function TParam_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DataSet: TDataSet read <getter>;

  Result := TDataSet_sw.ToVar(TParam_sacc(TParam(AObj)).DataSet);
end;

function TParam_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  Result := TParam_sw.ToVar(TParam_sc(AObj).Create(TParams_sw.FromVar(AArgs[0]),
    TParamType_sw.FromVar(AArgs[1])));
end;

function TParam_AssignField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AssignField(Field: TField);

  TParam(AObj).AssignField(TField_sw.FromVar(AArgs[0]));
end;

function TParam_AssignFieldValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AssignFieldValue(Field: TField; const Value: Va...

  TParam(AObj).AssignFieldValue(TField_sw.FromVar(AArgs[0]), Variant(
    FindVarData(AArgs[1])^));
end;

function TParam_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TParam(AObj).Clear();
end;

function TParam_GetDataSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetDataSize: Integer;

  Result := TParam(AObj).GetDataSize();
end;

function TParam_LoadFromFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromFile(const FileName: string; BlobType: ...

  TParam(AObj).LoadFromFile(string(AArgs[0]), TBlobType_sw.FromVar(AArgs[1]));
end;

function TParam_LoadFromStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromStream(Stream: TStream; BlobType: TBlob...

  TParam(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]), TBlobType_sw.
    FromVar(AArgs[1]));
end;

function TParam_SetDataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetDataSet(Dataset: TDataSet; AInstanceOwner: B...

  TParam(AObj).SetDataSet(TDataSet_sw.FromVar(AArgs[0]), Boolean(AArgs[1]));
end;

function TParam_SetParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetParams(Params: TParams; AInstanceOwner: Bool...

  TParam(AObj).SetParams(TParams_sw.FromVar(AArgs[0]), Boolean(AArgs[1]));
end;

function TParam_SetStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetStream(Stream: TStream; AInstanceOwner: Bool...

  case AArgsSize of
    2:
    begin
      TParam(AObj).SetStream(TStream_sw.FromVar(AArgs[0]), Boolean(AArgs[1]));
    end;
    3:
    begin
      TParam(AObj).SetStream(TStream_sw.FromVar(AArgs[0]), Boolean(AArgs[1]), 
        Integer(AArgs[2]));
    end;
  else
    WrongArgCountError('SetStream');
  end;
end;

function TParam_AsBCD_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsBCD: Currency read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsBCD
  else
    TParam(AObj).AsBCD := Currency(AArgs[0]);
end;

function TParam_AsBoolean_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsBoolean: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsBoolean
  else
    TParam(AObj).AsBoolean := Boolean(AArgs[0]);
end;

function TParam_AsCurrency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsCurrency: Currency read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsCurrency
  else
    TParam(AObj).AsCurrency := Currency(AArgs[0]);
end;

function TParam_AsDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsDate: TDateTime read <getter> write <setter>;

  if IsGet then
    Result := TDateTime_sw.ToVar(TParam(AObj).AsDate)
  else
    TParam(AObj).AsDate := TDateTime_sw.FromVar(AArgs[0]);
end;

function TParam_AsDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsDateTime: TDateTime read <getter> write <setter>;

  if IsGet then
    Result := TDateTime_sw.ToVar(TParam(AObj).AsDateTime)
  else
    TParam(AObj).AsDateTime := TDateTime_sw.FromVar(AArgs[0]);
end;

function TParam_AsSingle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsSingle: Single read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsSingle
  else
    TParam(AObj).AsSingle := Single(AArgs[0]);
end;

function TParam_AsFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsFloat: Double read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsFloat
  else
    TParam(AObj).AsFloat := Double(AArgs[0]);
end;

function TParam_AsInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsInteger: LongInt read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsInteger
  else
    TParam(AObj).AsInteger := LongInt(AArgs[0]);
end;

function TParam_AsSmallInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsSmallInt: LongInt read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsSmallInt
  else
    TParam(AObj).AsSmallInt := LongInt(AArgs[0]);
end;

function TParam_AsShortInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsShortInt: LongInt read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsShortInt
  else
    TParam(AObj).AsShortInt := LongInt(AArgs[0]);
end;

function TParam_AsByte_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsByte: LongInt read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsByte
  else
    TParam(AObj).AsByte := LongInt(AArgs[0]);
end;

function TParam_AsLongWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsLongWord: LongWord read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsLongWord
  else
    TParam(AObj).AsLongWord := LongWord(AArgs[0]);
end;

function TParam_AsLargeInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsLargeInt: LargeInt read <getter> write <setter>;

  if IsGet then
    Result := LargeInt_sw.ToVar(TParam(AObj).AsLargeInt)
  else
    TParam(AObj).AsLargeInt := LargeInt_sw.FromVar(AArgs[0]);
end;

function TParam_AsMemo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsMemo: string read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsMemo
  else
    TParam(AObj).AsMemo := string(AArgs[0]);
end;

function TParam_AsString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsString: string read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsString
  else
    TParam(AObj).AsString := string(AArgs[0]);
end;

function TParam_AsWideString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsWideString: string read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsWideString
  else
    TParam(AObj).AsWideString := string(AArgs[0]);
end;

function TParam_AsAnsiString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsAnsiString: AnsiString read <getter> write <se...

  if IsGet then
    Result := TParam(AObj).AsAnsiString
  else
    TParam(AObj).AsAnsiString := AnsiString(AArgs[0]);
end;

function TParam_AsTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsTime: TDateTime read <getter> write <setter>;

  if IsGet then
    Result := TDateTime_sw.ToVar(TParam(AObj).AsTime)
  else
    TParam(AObj).AsTime := TDateTime_sw.FromVar(AArgs[0]);
end;

function TParam_AsWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsWord: LongInt read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).AsWord
  else
    TParam(AObj).AsWord := LongInt(AArgs[0]);
end;

function TParam_AsDataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsDataSet: TDataSet read <getter> write <setter>;

  if IsGet then
    Result := TDataSet_sw.ToVar(TParam(AObj).AsDataSet)
  else
    TParam(AObj).AsDataSet := TDataSet_sw.FromVar(AArgs[0]);
end;

function TParam_AsObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsObject: TObject read <getter> write <setter>;

  if IsGet then
    Result := TObject_sw.ToVar(TParam(AObj).AsObject)
  else
    TParam(AObj).AsObject := TObject_sw.FromVar(AArgs[0]);
end;

function TParam_AsParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsParams: TParams read <getter> write <setter>;

  if IsGet then
    Result := TParams_sw.ToVar(TParam(AObj).AsParams)
  else
    TParam(AObj).AsParams := TParams_sw.FromVar(AArgs[0]);
end;

function TParam_AsStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AsStream: TStream read <getter> write <setter>;

  if IsGet then
    Result := TStream_sw.ToVar(TParam(AObj).AsStream)
  else
    TParam(AObj).AsStream := TStream_sw.FromVar(AArgs[0]);
end;

function TParam_Bound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bound: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).Bound
  else
    TParam(AObj).Bound := Boolean(AArgs[0]);
end;

function TParam_IsNull_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsNull: Boolean read <getter>;

  Result := TParam(AObj).IsNull;
end;

function TParam_NativeStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NativeStr: string read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).NativeStr
  else
    TParam(AObj).NativeStr := string(AArgs[0]);
end;

function TParam_Text_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Text: string read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).Text
  else
    TParam(AObj).Text := string(AArgs[0]);
end;

function TParam_DataType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataType: TFieldType read <getter> write <setter>;

  if IsGet then
    Result := TFieldType_sw.ToVar(TParam(AObj).DataType)
  else
    TParam(AObj).DataType := TFieldType_sw.FromVar(AArgs[0]);
end;

function TParam_Precision_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Precision: Integer read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).Precision
  else
    TParam(AObj).Precision := Integer(AArgs[0]);
end;

function TParam_NumericScale_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NumericScale: Integer read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).NumericScale
  else
    TParam(AObj).NumericScale := Integer(AArgs[0]);
end;

function TParam_Name_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Name: string read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).Name
  else
    TParam(AObj).Name := string(AArgs[0]);
end;

function TParam_ParamType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParamType: TParamType read <getter> write <setter>;

  if IsGet then
    Result := TParamType_sw.ToVar(TParam(AObj).ParamType)
  else
    TParam(AObj).ParamType := TParamType_sw.FromVar(AArgs[0]);
end;

function TParam_Size_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Size: Integer read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).Size
  else
    TParam(AObj).Size := Integer(AArgs[0]);
end;

function TParam_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: Variant read <getter> write <setter>;

  if IsGet then
    Result := TParam(AObj).Value
  else
    TParam(AObj).Value := Variant(FindVarData(AArgs[0])^);
end;

class function TParam_sw.GetTypeName: WideString;
begin
  Result := 'TParam';
end;

class function TParam_sw.GetWrappedClass: TClass;
begin
  Result := TParam;
end;

class procedure TParam_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DataSet', TParam_DataSet_si, TDataSet_sw, True, False, 0, True, False);
  AData.AddProcedure('AssignField', TParam_AssignField_si, 1, False);
  AData.AddProcedure('AssignFieldValue', TParam_AssignFieldValue_si, 2, False);
  AData.AddProcedure('Clear', TParam_Clear_si, 0, False);
  AData.AddFunction('GetDataSize', TParam_GetDataSize_si, Integer_sw, 0, False);
  AData.AddProcedure('LoadFromFile', TParam_LoadFromFile_si, 2, False);
  AData.AddProcedure('LoadFromStream', TParam_LoadFromStream_si, 2, False);
  AData.AddProcedure('SetDataSet', TParam_SetDataSet_si, 2, False);
  AData.AddProcedure('SetParams', TParam_SetParams_si, 2, False);
  AData.AddProcedure('SetStream', TParam_SetStream_si, 2, True);
  AData.AddProperty('AsBCD', TParam_AsBCD_si, Currency_sw, True, True, 0, False, False);
  AData.AddProperty('AsBoolean', TParam_AsBoolean_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AsCurrency', TParam_AsCurrency_si, Currency_sw, True, True, 0, False, False);
  AData.AddProperty('AsDate', TParam_AsDate_si, TDateTime_sw, True, True, 0, False, False);
  AData.AddProperty('AsDateTime', TParam_AsDateTime_si, TDateTime_sw, True, True, 0, False, False);
  AData.AddProperty('AsSingle', TParam_AsSingle_si, Single_sw, True, True, 0, False, False);
  AData.AddProperty('AsFloat', TParam_AsFloat_si, Double_sw, True, True, 0, False, False);
  AData.AddProperty('AsInteger', TParam_AsInteger_si, LongInt_sw, True, True, 0, False, False);
  AData.AddProperty('AsSmallInt', TParam_AsSmallInt_si, LongInt_sw, True, True, 0, False, False);
  AData.AddProperty('AsShortInt', TParam_AsShortInt_si, LongInt_sw, True, True, 0, False, False);
  AData.AddProperty('AsByte', TParam_AsByte_si, LongInt_sw, True, True, 0, False, False);
  AData.AddProperty('AsLongWord', TParam_AsLongWord_si, LongWord_sw, True, True, 0, False, False);
  AData.AddProperty('AsLargeInt', TParam_AsLargeInt_si, LargeInt_sw, True, True, 0, False, False);
  AData.AddProperty('AsMemo', TParam_AsMemo_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('AsString', TParam_AsString_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('AsWideString', TParam_AsWideString_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('AsAnsiString', TParam_AsAnsiString_si, AnsiString_sw, True, True, 0, False, False);
  AData.AddProperty('AsTime', TParam_AsTime_si, TDateTime_sw, True, True, 0, False, False);
  AData.AddProperty('AsWord', TParam_AsWord_si, LongInt_sw, True, True, 0, False, False);
  AData.AddProperty('AsDataSet', TParam_AsDataSet_si, TDataSet_sw, True, True, 0, False, False);
  AData.AddProperty('AsObject', TParam_AsObject_si, TObject_sw, True, True, 0, False, False);
  AData.AddProperty('AsParams', TParam_AsParams_si, TParams_sw, True, True, 0, False, False);
  AData.AddProperty('AsStream', TParam_AsStream_si, TStream_sw, True, True, 0, False, False);
  AData.AddProperty('Bound', TParam_Bound_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('IsNull', TParam_IsNull_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('NativeStr', TParam_NativeStr_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Text', TParam_Text_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('DataType', TParam_DataType_si, TFieldType_sw, True, True, 0, False, False);
  AData.AddProperty('Precision', TParam_Precision_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('NumericScale', TParam_NumericScale_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Name', TParam_Name_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ParamType', TParam_ParamType_si, TParamType_sw, True, True, 0, False, False);
  AData.AddProperty('Size', TParam_Size_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Value', TParam_Value_si, Variant_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TParam_Create_si, 2, False);
end;

class function TParam_sw.ToVar(const AValue: TParam): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TParam_sw.FromVar(const AValue: OleVariant): TParam;
begin
  Result := TParam(ConvFromVar(AValue, TParam));
end;

class function TParam_sw.ClassToVar(AClass: TParam_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TParam_sw.ClassFromVar(const AClass: OleVariant): TParam_sc;
begin
  Result := TParam_sc(ConvClsFromVar(AClass, TParam));
end;

{ TParamClass_sw }

class function TParamClass_sw.GetTypeName: WideString;
begin
  Result := 'TParamClass';
end;

class function TParamClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TParam;
end;

class function TParamClass_sw.ToVar(const AValue: TParamClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TParamClass_sw.FromVar(const AValue: OleVariant): TParamClass;
begin
  Result := TParamClass(ConvFromVar(AValue, TParam));
end;

{ TParams_sw }

function TParams_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TParams_sw.ToVar(TParams_sc(AObj).Create(TPersistent_sw.FromVar(
        AArgs[0])));
    end;
    0:
    begin
      Result := TParams_sw.ToVar(TParams_sc(AObj).Create());
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TParams_AddParameter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddParameter: TParam;

  Result := TParam_sw.ToVar(TParams(AObj).AddParameter());
end;

function TParams_AssignValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AssignValues(Value: TParams);

  TParams(AObj).AssignValues(TParams_sw.FromVar(AArgs[0]));
end;

function TParams_AddParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AddParam(Value: TParam);

  TParams(AObj).AddParam(TParam_sw.FromVar(AArgs[0]));
end;

function TParams_RemoveParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RemoveParam(Value: TParam);

  TParams(AObj).RemoveParam(TParam_sw.FromVar(AArgs[0]));
end;

function TParams_CreateParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CreateParam(FldType: TFieldType; const ParamName...

  Result := TParam_sw.ToVar(TParams(AObj).CreateParam(TFieldType_sw.FromVar(
    AArgs[0]), string(AArgs[1]), TParamType_sw.FromVar(AArgs[2])));
end;

function TParams_GetParamList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function GetParamList(...); overload;

  TParams(AObj).GetParamList(TList_sw.FromVar(AArgs[0]), string(AArgs[1]));
end;

function TParams_IsEqual_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsEqual(Value: TParams): Boolean;

  Result := TParams(AObj).IsEqual(TParams_sw.FromVar(AArgs[0]));
end;

function TParams_ParseSQL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ParseSQL(const SQL: string; DoCreate: Boolean): ...

  Result := TParams(AObj).ParseSQL(string(AArgs[0]), Boolean(AArgs[1]));
end;

function TParams_ParamByName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ParamByName(const Value: string): TParam;

  Result := TParam_sw.ToVar(TParams(AObj).ParamByName(string(AArgs[0])));
end;

function TParams_FindParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindParam(const Value: string): TParam;

  Result := TParam_sw.ToVar(TParams(AObj).FindParam(string(AArgs[0])));
end;

function TParams_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TParam read <getter> writ...

  if IsGet then
    Result := TParam_sw.ToVar(TParams(AObj).Items[Integer(AArgs[0])])
  else
    TParams(AObj).Items[Integer(AArgs[0])] := TParam_sw.FromVar(AArgs[1]);
end;

function TParams_ParamValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParamValues[const ParamName: string]: Variant re...

  if IsGet then
    Result := TParams(AObj).ParamValues[string(AArgs[0])]
  else
    TParams(AObj).ParamValues[string(AArgs[0])] := Variant(FindVarData(
      AArgs[1])^);
end;

class function TParams_sw.GetTypeName: WideString;
begin
  Result := 'TParams';
end;

class function TParams_sw.GetWrappedClass: TClass;
begin
  Result := TParams;
end;

class procedure TParams_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('AddParameter', TParams_AddParameter_si, TParam_sw, 0, False);
  AData.AddProcedure('AssignValues', TParams_AssignValues_si, 1, False);
  AData.AddProcedure('AddParam', TParams_AddParam_si, 1, False);
  AData.AddProcedure('RemoveParam', TParams_RemoveParam_si, 1, False);
  AData.AddFunction('CreateParam', TParams_CreateParam_si, TParam_sw, 3, False);
  AData.AddProcedure('GetParamList', TParams_GetParamList_si, 2, False);
  AData.AddFunction('IsEqual', TParams_IsEqual_si, Boolean_sw, 1, False);
  AData.AddFunction('ParseSQL', TParams_ParseSQL_si, string_sw, 2, False);
  AData.AddFunction('ParamByName', TParams_ParamByName_si, TParam_sw, 1, False);
  AData.AddFunction('FindParam', TParams_FindParam_si, TParam_sw, 1, False);
  AData.AddProperty('Items', TParams_Items_si, TParam_sw, True, True, 1, False, True);
  AData.AddProperty('ParamValues', TParams_ParamValues_si, Variant_sw, True, True, 1, False, False);

  { Class members }

  AData.AddConstructor('Create', TParams_Create_si, 0, True);
end;

class function TParams_sw.ToVar(const AValue: TParams): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TParams_sw.FromVar(const AValue: OleVariant): TParams;
begin
  Result := TParams(ConvFromVar(AValue, TParams));
end;

class function TParams_sw.ClassToVar(AClass: TParams_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TParams_sw.ClassFromVar(const AClass: OleVariant): TParams_sc;
begin
  Result := TParams_sc(ConvClsFromVar(AClass, TParams));
end;

{ TParamsClass_sw }

class function TParamsClass_sw.GetTypeName: WideString;
begin
  Result := 'TParamsClass';
end;

class function TParamsClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TParams;
end;

class function TParamsClass_sw.ToVar(const AValue: TParamsClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TParamsClass_sw.FromVar(const AValue: OleVariant): TParamsClass;
begin
  Result := TParamsClass(ConvFromVar(AValue, TParams));
end;

{ TParamObject_sw }

function TParamObject_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AObject: TObject; ADataType: TFieldTyp...

  Result := TParamObject_sw.ToVar(TParamObject_sc(AObj).Create(TObject_sw.
    FromVar(AArgs[0]), TFieldType_sw.FromVar(AArgs[1]), Boolean(AArgs[2])));
end;

class function TParamObject_sw.GetTypeName: WideString;
begin
  Result := 'TParamObject';
end;

class function TParamObject_sw.GetWrappedClass: TClass;
begin
  Result := TParamObject;
end;

class procedure TParamObject_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TParamObject_Create_si, 3, False);
end;

class function TParamObject_sw.ToVar(const AValue: TParamObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TParamObject_sw.FromVar(const AValue: OleVariant): TParamObject;
begin
  Result := TParamObject(ConvFromVar(AValue, TParamObject));
end;

class function TParamObject_sw.ClassToVar(AClass: TParamObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TParamObject_sw.ClassFromVar(
  const AClass: OleVariant): TParamObject_sc;
begin
  Result := TParamObject_sc(ConvClsFromVar(AClass, TParamObject));
end;

{ TParamStreamObject_sw }

class function TParamStreamObject_sw.GetTypeName: WideString;
begin
  Result := 'TParamStreamObject';
end;

class function TParamStreamObject_sw.GetWrappedClass: TClass;
begin
  Result := TParamStreamObject;
end;

class procedure TParamStreamObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TParamStreamObject_sw.ToVar(
  const AValue: TParamStreamObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TParamStreamObject_sw.FromVar(
  const AValue: OleVariant): TParamStreamObject;
begin
  Result := TParamStreamObject(ConvFromVar(AValue, TParamStreamObject));
end;

class function TParamStreamObject_sw.ClassToVar(
  AClass: TParamStreamObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TParamStreamObject_sw.ClassFromVar(
  const AClass: OleVariant): TParamStreamObject_sc;
begin
  Result := TParamStreamObject_sc(ConvClsFromVar(AClass, TParamStreamObject));
end;

{ TPSCommandType_sw }

class function TPSCommandType_sw.GetTypeName: WideString;
begin
  Result := 'TPSCommandType';
end;

class procedure TPSCommandType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..9] of TLMDEnumerator = (
    (Name: 'ctUnknown'; Value: Integer({$IFDEF LMDSCT_12}TPSCommandType.{$ENDIF}ctUnknown)),
    (Name: 'ctQuery'; Value: Integer({$IFDEF LMDSCT_12}TPSCommandType.{$ENDIF}ctQuery)),
    (Name: 'ctTable'; Value: Integer({$IFDEF LMDSCT_12}TPSCommandType.{$ENDIF}ctTable)),
    (Name: 'ctStoredProc'; Value: Integer({$IFDEF LMDSCT_12}TPSCommandType.{$ENDIF}ctStoredProc)),
    (Name: 'ctServerMethod'; Value: Integer({$IFDEF LMDSCT_12}TPSCommandType.{$ENDIF}ctServerMethod)),
    (Name: 'ctSelect'; Value: Integer({$IFDEF LMDSCT_12}TPSCommandType.{$ENDIF}ctSelect)),
    (Name: 'ctInsert'; Value: Integer({$IFDEF LMDSCT_12}TPSCommandType.{$ENDIF}ctInsert)),
    (Name: 'ctUpdate'; Value: Integer({$IFDEF LMDSCT_12}TPSCommandType.{$ENDIF}ctUpdate)),
    (Name: 'ctDelete'; Value: Integer({$IFDEF LMDSCT_12}TPSCommandType.{$ENDIF}ctDelete)),
    (Name: 'ctDDL'; Value: Integer({$IFDEF LMDSCT_12}TPSCommandType.{$ENDIF}ctDDL))
  );
begin
  AEnums := @ENUMS;
  ACount := 10;
end;

class function TPSCommandType_sw.ToVar(
  const AValue: TPSCommandType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPSCommandType_sw.FromVar(
  const AValue: OleVariant): TPSCommandType;
begin
  Result := TPSCommandType(Integer(AValue));
end;

{ TSQLCommandType_sw }

class function TSQLCommandType_sw.GetTypeName: WideString;
begin
  Result := 'TSQLCommandType';
end;

class function TSQLCommandType_sw.ToVar(
  const AValue: TSQLCommandType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TSQLCommandType_sw.FromVar(
  const AValue: OleVariant): TSQLCommandType;
begin
  Result := TSQLCommandType(Integer(AValue));
end;

{ TPacketAttribute_sw }

function TPacketAttribute_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Name: string;

  if IsGet then
    Result := TPacketAttribute_sw(AObj).FValue.Name
  else
    TPacketAttribute_sw(AObj).FValue.Name := string(AArgs[0]);
end;

function TPacketAttribute_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Value: OleVariant;

  if IsGet then
    Result := TPacketAttribute_sw(AObj).FValue.Value
  else
    TPacketAttribute_sw(AObj).FValue.Value := OleVariant(FindVarData(
      AArgs[0])^);
end;

function TPacketAttribute_IncludeInDelta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var IncludeInDelta: Boolean;

  if IsGet then
    Result := TPacketAttribute_sw(AObj).FValue.IncludeInDelta
  else
    TPacketAttribute_sw(AObj).FValue.IncludeInDelta := Boolean(AArgs[0]);
end;

function TPacketAttribute_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TPacketAttribute_sw.Create as IDispatch;
end;

function TPacketAttribute_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TPacketAttribute;

  // Implicit record copy method.
  Result := TPacketAttribute_sw.ToVar(TPacketAttribute(AObj));
end;

class function TPacketAttribute_sw.GetTypeName: WideString;
begin
  Result := 'TPacketAttribute';
end;

function TPacketAttribute_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPacketAttribute_sw.Create;
  TPacketAttribute_sw(Result).FValue := FValue;
end;

class procedure TPacketAttribute_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Name', TPacketAttribute_Name_si, string_sw);
  AData.AddField('Value', TPacketAttribute_Value_si, OleVariant_sw);
  AData.AddField('IncludeInDelta', TPacketAttribute_IncludeInDelta_si, Boolean_sw);
  AData.AddFunction('Copy', TPacketAttribute_Copy_si, TPacketAttribute_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TPacketAttribute_Create_si, 0, False);
end;

class function TPacketAttribute_sw.ToVar(
  const AValue: TPacketAttribute): OleVariant;
var
  wrpr: TPacketAttribute_sw;
begin
  wrpr        := TPacketAttribute_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TPacketAttribute_sw.FromVar(
  const AValue: OleVariant): TPacketAttribute;
begin
  Result := TPacketAttribute_sw(ConvFromVar(AValue)).FValue;
end;

{ TBookmarkFlag_sw }

class function TBookmarkFlag_sw.GetTypeName: WideString;
begin
  Result := 'TBookmarkFlag';
end;

class procedure TBookmarkFlag_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'bfCurrent'; Value: Integer({$IFDEF LMDSCT_12}TBookmarkFlag.{$ENDIF}bfCurrent)),
    (Name: 'bfBOF'; Value: Integer({$IFDEF LMDSCT_12}TBookmarkFlag.{$ENDIF}bfBOF)),
    (Name: 'bfEOF'; Value: Integer({$IFDEF LMDSCT_12}TBookmarkFlag.{$ENDIF}bfEOF)),
    (Name: 'bfInserted'; Value: Integer({$IFDEF LMDSCT_12}TBookmarkFlag.{$ENDIF}bfInserted))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TBookmarkFlag_sw.ToVar(const AValue: TBookmarkFlag): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBookmarkFlag_sw.FromVar(
  const AValue: OleVariant): TBookmarkFlag;
begin
  Result := TBookmarkFlag(Integer(AValue));
end;

{ TGetMode_sw }

class function TGetMode_sw.GetTypeName: WideString;
begin
  Result := 'TGetMode';
end;

class procedure TGetMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'gmCurrent'; Value: Integer({$IFDEF LMDSCT_12}TGetMode.{$ENDIF}gmCurrent)),
    (Name: 'gmNext'; Value: Integer({$IFDEF LMDSCT_12}TGetMode.{$ENDIF}gmNext)),
    (Name: 'gmPrior'; Value: Integer({$IFDEF LMDSCT_12}TGetMode.{$ENDIF}gmPrior))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TGetMode_sw.ToVar(const AValue: TGetMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TGetMode_sw.FromVar(const AValue: OleVariant): TGetMode;
begin
  Result := TGetMode(Integer(AValue));
end;

{ TGetResult_sw }

class function TGetResult_sw.GetTypeName: WideString;
begin
  Result := 'TGetResult';
end;

class procedure TGetResult_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'grOK'; Value: Integer({$IFDEF LMDSCT_12}TGetResult.{$ENDIF}grOK)),
    (Name: 'grBOF'; Value: Integer({$IFDEF LMDSCT_12}TGetResult.{$ENDIF}grBOF)),
    (Name: 'grEOF'; Value: Integer({$IFDEF LMDSCT_12}TGetResult.{$ENDIF}grEOF)),
    (Name: 'grError'; Value: Integer({$IFDEF LMDSCT_12}TGetResult.{$ENDIF}grError))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TGetResult_sw.ToVar(const AValue: TGetResult): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TGetResult_sw.FromVar(const AValue: OleVariant): TGetResult;
begin
  Result := TGetResult(Integer(AValue));
end;

{ TDataAction_sw }

class function TDataAction_sw.GetTypeName: WideString;
begin
  Result := 'TDataAction';
end;

class procedure TDataAction_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'daFail'; Value: Integer({$IFDEF LMDSCT_12}TDataAction.{$ENDIF}daFail)),
    (Name: 'daAbort'; Value: Integer({$IFDEF LMDSCT_12}TDataAction.{$ENDIF}daAbort)),
    (Name: 'daRetry'; Value: Integer({$IFDEF LMDSCT_12}TDataAction.{$ENDIF}daRetry))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TDataAction_sw.ToVar(const AValue: TDataAction): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDataAction_sw.FromVar(const AValue: OleVariant): TDataAction;
begin
  Result := TDataAction(Integer(AValue));
end;

{ TBlobStreamMode_sw }

class function TBlobStreamMode_sw.GetTypeName: WideString;
begin
  Result := 'TBlobStreamMode';
end;

class procedure TBlobStreamMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'bmRead'; Value: Integer({$IFDEF LMDSCT_12}TBlobStreamMode.{$ENDIF}bmRead)),
    (Name: 'bmWrite'; Value: Integer({$IFDEF LMDSCT_12}TBlobStreamMode.{$ENDIF}bmWrite)),
    (Name: 'bmReadWrite'; Value: Integer({$IFDEF LMDSCT_12}TBlobStreamMode.{$ENDIF}bmReadWrite))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TBlobStreamMode_sw.ToVar(
  const AValue: TBlobStreamMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBlobStreamMode_sw.FromVar(
  const AValue: OleVariant): TBlobStreamMode;
begin
  Result := TBlobStreamMode(Integer(AValue));
end;

{ TLocateOption_sw }

class function TLocateOption_sw.GetTypeName: WideString;
begin
  Result := 'TLocateOption';
end;

class procedure TLocateOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'loCaseInsensitive'; Value: Integer({$IFDEF LMDSCT_12}TLocateOption.{$ENDIF}loCaseInsensitive)),
    (Name: 'loPartialKey'; Value: Integer({$IFDEF LMDSCT_12}TLocateOption.{$ENDIF}loPartialKey))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TLocateOption_sw.ToVar(const AValue: TLocateOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TLocateOption_sw.FromVar(
  const AValue: OleVariant): TLocateOption;
begin
  Result := TLocateOption(Integer(AValue));
end;

{ TLocateOptions_sw }

class function TLocateOptions_sw.GetTypeName: WideString;
begin
  Result := 'TLocateOptions';
end;

class function TLocateOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TLocateOptions);
end;

class function TLocateOptions_sw.ToVar(
  const AValue: TLocateOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TLocateOptions_sw.FromVar(
  const AValue: OleVariant): TLocateOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TDataOperation_sh }

function TDataOperation_sh.GetHandler: TMethod;
var
  hdr: TDataOperation;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDataOperation_sh.Handler;
begin
  // procedure  of object

  Self.Owner.RunProc(Self.ProcName);
end;

{ TDataOperation_sw }

class function TDataOperation_sw.GetTypeName: WideString;
begin
  Result := 'TDataOperation';
end;

class function TDataOperation_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDataOperation_sh;
end;

class function TDataOperation_sw.ToVar(
  const AValue: TDataOperation): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDataOperation_sw.FromVar(
  const AValue: OleVariant): TDataOperation;
begin
  Result := TDataOperation(ConvFromVar(AValue));
end;

class function TDataOperation_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TDataOperation;
var
  hdlr: TDataOperation_sh;
begin
  hdlr   := TDataOperation_sh(AScriptControl.GetEventHandler(AProcName, 
    TDataOperation_sw));
  Result := hdlr.Handler;
end;

{ TDataSetNotifyEvent_sh }

function TDataSetNotifyEvent_sh.GetHandler: TMethod;
var
  hdr: TDataSetNotifyEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDataSetNotifyEvent_sh.Handler(DataSet: TDataSet);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (DataSet: TDataSet) of object

  args[0] := TDataSet_sw.ToVar(DataSet);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TDataSetNotifyEvent_sw }

class function TDataSetNotifyEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDataSetNotifyEvent';
end;

class function TDataSetNotifyEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDataSetNotifyEvent_sh;
end;

class function TDataSetNotifyEvent_sw.ToVar(
  const AValue: TDataSetNotifyEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDataSetNotifyEvent_sw.FromVar(
  const AValue: OleVariant): TDataSetNotifyEvent;
begin
  Result := TDataSetNotifyEvent(ConvFromVar(AValue));
end;

class function TDataSetNotifyEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TDataSetNotifyEvent;
var
  hdlr: TDataSetNotifyEvent_sh;
begin
  hdlr   := TDataSetNotifyEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDataSetNotifyEvent_sw));
  Result := hdlr.Handler;
end;

{ TDataSetErrorEvent_sh }

function TDataSetErrorEvent_sh.GetHandler: TMethod;
var
  hdr: TDataSetErrorEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDataSetErrorEvent_sh.Handler(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (DataSet: TDataSet; E: EDatabaseError; var Acti...

  v_1 := TDataAction_sw.ToVar(Action);
  args[0] := TDataSet_sw.ToVar(DataSet);
  args[1] := EDatabaseError_sw.ToVar(E);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Action := TDataAction_sw.FromVar(v_1);
end;

{ TDataSetErrorEvent_sw }

class function TDataSetErrorEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDataSetErrorEvent';
end;

class function TDataSetErrorEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDataSetErrorEvent_sh;
end;

class function TDataSetErrorEvent_sw.ToVar(
  const AValue: TDataSetErrorEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDataSetErrorEvent_sw.FromVar(
  const AValue: OleVariant): TDataSetErrorEvent;
begin
  Result := TDataSetErrorEvent(ConvFromVar(AValue));
end;

class function TDataSetErrorEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TDataSetErrorEvent;
var
  hdlr: TDataSetErrorEvent_sh;
begin
  hdlr   := TDataSetErrorEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDataSetErrorEvent_sw));
  Result := hdlr.Handler;
end;

{ TFilterOption_sw }

class function TFilterOption_sw.GetTypeName: WideString;
begin
  Result := 'TFilterOption';
end;

class procedure TFilterOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'foCaseInsensitive'; Value: Integer({$IFDEF LMDSCT_12}TFilterOption.{$ENDIF}foCaseInsensitive)),
    (Name: 'foNoPartialCompare'; Value: Integer({$IFDEF LMDSCT_12}TFilterOption.{$ENDIF}foNoPartialCompare))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TFilterOption_sw.ToVar(const AValue: TFilterOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFilterOption_sw.FromVar(
  const AValue: OleVariant): TFilterOption;
begin
  Result := TFilterOption(Integer(AValue));
end;

{ TFilterOptions_sw }

class function TFilterOptions_sw.GetTypeName: WideString;
begin
  Result := 'TFilterOptions';
end;

class function TFilterOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFilterOptions);
end;

class function TFilterOptions_sw.ToVar(
  const AValue: TFilterOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFilterOptions_sw.FromVar(
  const AValue: OleVariant): TFilterOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFilterRecordEvent_sh }

function TFilterRecordEvent_sh.GetHandler: TMethod;
var
  hdr: TFilterRecordEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFilterRecordEvent_sh.Handler(DataSet: TDataSet; var Accept: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (DataSet: TDataSet; var Accept: Boolean) of object

  v_1 := Accept;
  args[0] := TDataSet_sw.ToVar(DataSet);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Accept := Boolean(v_1);
end;

{ TFilterRecordEvent_sw }

class function TFilterRecordEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFilterRecordEvent';
end;

class function TFilterRecordEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFilterRecordEvent_sh;
end;

class function TFilterRecordEvent_sw.ToVar(
  const AValue: TFilterRecordEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFilterRecordEvent_sw.FromVar(
  const AValue: OleVariant): TFilterRecordEvent;
begin
  Result := TFilterRecordEvent(ConvFromVar(AValue));
end;

class function TFilterRecordEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TFilterRecordEvent;
var
  hdlr: TFilterRecordEvent_sh;
begin
  hdlr   := TFilterRecordEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TFilterRecordEvent_sw));
  Result := hdlr.Handler;
end;

{ TGroupPosInd_sw }

class function TGroupPosInd_sw.GetTypeName: WideString;
begin
  Result := 'TGroupPosInd';
end;

class procedure TGroupPosInd_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'gbFirst'; Value: Integer({$IFDEF LMDSCT_12}TGroupPosInd.{$ENDIF}gbFirst)),
    (Name: 'gbMiddle'; Value: Integer({$IFDEF LMDSCT_12}TGroupPosInd.{$ENDIF}gbMiddle)),
    (Name: 'gbLast'; Value: Integer({$IFDEF LMDSCT_12}TGroupPosInd.{$ENDIF}gbLast))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TGroupPosInd_sw.ToVar(const AValue: TGroupPosInd): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TGroupPosInd_sw.FromVar(const AValue: OleVariant): TGroupPosInd;
begin
  Result := TGroupPosInd(Integer(AValue));
end;

{ TGroupPosInds_sw }

class function TGroupPosInds_sw.GetTypeName: WideString;
begin
  Result := 'TGroupPosInds';
end;

class function TGroupPosInds_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TGroupPosInds);
end;

class function TGroupPosInds_sw.ToVar(const AValue: TGroupPosInds): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TGroupPosInds_sw.FromVar(
  const AValue: OleVariant): TGroupPosInds;
begin
  ConvFromVar(AValue, @Result);
end;

{ TDataSetClass_sw }

class function TDataSetClass_sw.GetTypeName: WideString;
begin
  Result := 'TDataSetClass';
end;

class function TDataSetClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TDataSet;
end;

class function TDataSetClass_sw.ToVar(const AValue: TDataSetClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDataSetClass_sw.FromVar(
  const AValue: OleVariant): TDataSetClass;
begin
  Result := TDataSetClass(ConvFromVar(AValue, TDataSet));
end;

{ TDataSet_sw }

function TDataSet_ActiveRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ActiveRecord: Integer read <getter>;

  Result := TDataSet_sacc(TDataSet(AObj)).ActiveRecord;
end;

function TDataSet_CurrentRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CurrentRecord: Integer read <getter>;

  Result := TDataSet_sacc(TDataSet(AObj)).CurrentRecord;
end;

function TDataSet_BlobFieldCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BlobFieldCount: Integer read <getter>;

  Result := TDataSet_sacc(TDataSet(AObj)).BlobFieldCount;
end;

function TDataSet_BookmarkSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BookmarkSize: Integer read <getter> wr...

  if IsGet then
    Result := TDataSet_sacc(TDataSet(AObj)).BookmarkSize
  else
    TDataSet_sacc(TDataSet(AObj)).BookmarkSize := Integer(AArgs[0]);
end;

function TDataSet_Buffers_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Buffers[Index: Integer]: TRecBuf read ...

  Result := TRecBuf_sw.ToVar(TDataSet_sacc(TDataSet(AObj)).Buffers[Integer(
    AArgs[0])]);
end;

function TDataSet_BufferCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BufferCount: Integer read <getter>;

  Result := TDataSet_sacc(TDataSet(AObj)).BufferCount;
end;

function TDataSet_CalcBuffer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CalcBuffer: NativeInt read <getter>;

  Result := NativeInt_sw.ToVar(TDataSet_sacc(TDataSet(AObj)).CalcBuffer);
end;

function TDataSet_CalcFieldsSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CalcFieldsSize: Integer read <getter>;

  Result := TDataSet_sacc(TDataSet(AObj)).CalcFieldsSize;
end;

function TDataSet_Constraints_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Constraints: TCheckConstraints read <g...

  if IsGet then
    Result := TCheckConstraints_sw.ToVar(TDataSet_sacc(TDataSet(AObj)).
      Constraints)
  else
    TDataSet_sacc(TDataSet(AObj)).Constraints := TCheckConstraints_sw.FromVar(
      AArgs[0]);
end;

function TDataSet_FieldNoOfs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property FieldNoOfs: Integer read <getter> writ...

  if IsGet then
    Result := TDataSet_sacc(TDataSet(AObj)).FieldNoOfs
  else
    TDataSet_sacc(TDataSet(AObj)).FieldNoOfs := Integer(AArgs[0]);
end;

function TDataSet_InternalCalcFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property InternalCalcFields: Boolean read <gett...

  Result := TDataSet_sacc(TDataSet(AObj)).InternalCalcFields;
end;

function TDataSet_NestedDataSetClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property NestedDataSetClass: TDataSetClass read...

  if IsGet then
    Result := TDataSetClass_sw.ToVar(TDataSet_sacc(TDataSet(AObj)).
      NestedDataSetClass)
  else
    TDataSet_sacc(TDataSet(AObj)).NestedDataSetClass := TDataSetClass_sw.
      FromVar(AArgs[0]);
end;

function TDataSet_ActiveBuffer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ActiveBuffer: TRecBuf;

  Result := TRecBuf_sw.ToVar(TDataSet(AObj).ActiveBuffer());
end;

function TDataSet_Append_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Append;

  TDataSet(AObj).Append();
end;

function TDataSet_Cancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Cancel;

  TDataSet(AObj).Cancel();
end;

function TDataSet_CheckBrowseMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CheckBrowseMode;

  TDataSet(AObj).CheckBrowseMode();
end;

function TDataSet_ClearFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ClearFields;

  TDataSet(AObj).ClearFields();
end;

function TDataSet_Close_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Close;

  TDataSet(AObj).Close();
end;

function TDataSet_ControlsDisabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ControlsDisabled: Boolean;

  Result := TDataSet(AObj).ControlsDisabled();
end;

function TDataSet_CreateBlobStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CreateBlobStream(Field: TField; Mode: TBlobStrea...

  Result := TStream_sw.ToVar(TDataSet(AObj).CreateBlobStream(TField_sw.FromVar(
    AArgs[0]), TBlobStreamMode_sw.FromVar(AArgs[1])));
end;

function TDataSet_CursorPosChanged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CursorPosChanged;

  TDataSet(AObj).CursorPosChanged();
end;

function TDataSet_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete;

  TDataSet(AObj).Delete();
end;

function TDataSet_DisableControls_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DisableControls;

  TDataSet(AObj).DisableControls();
end;

function TDataSet_Edit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Edit;

  TDataSet(AObj).Edit();
end;

function TDataSet_EnableControls_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EnableControls;

  TDataSet(AObj).EnableControls();
end;

function TDataSet_FieldByName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FieldByName(const FieldName: string): TField;

  Result := TField_sw.ToVar(TDataSet(AObj).FieldByName(string(AArgs[0])));
end;

function TDataSet_FindField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindField(const FieldName: string): TField;

  Result := TField_sw.ToVar(TDataSet(AObj).FindField(string(AArgs[0])));
end;

function TDataSet_FindFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindFirst: Boolean;

  Result := TDataSet(AObj).FindFirst();
end;

function TDataSet_FindLast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindLast: Boolean;

  Result := TDataSet(AObj).FindLast();
end;

function TDataSet_FindNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindNext: Boolean;

  Result := TDataSet(AObj).FindNext();
end;

function TDataSet_FindPrior_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindPrior: Boolean;

  Result := TDataSet(AObj).FindPrior();
end;

function TDataSet_First_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure First;

  TDataSet(AObj).First();
end;

function TDataSet_GetCurrentRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function GetCurrentRecord(...); overload;

  Result := TDataSet(AObj).GetCurrentRecord(TRecBuf_sw.FromVar(AArgs[0]));
end;

function TDataSet_GetDetailDataSets_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function GetDetailDataSets(...); overload;

  TDataSet(AObj).GetDetailDataSets(TList_sw.FromVar(AArgs[0]));
end;

function TDataSet_GetDetailLinkFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function GetDetailLinkFields(...); overload;

  TDataSet(AObj).GetDetailLinkFields(TList_sw.FromVar(AArgs[0]), TList_sw.
    FromVar(AArgs[1]));
end;

function TDataSet_GetFieldList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function GetFieldList(...); overload;

  TDataSet(AObj).GetFieldList(TList_sw.FromVar(AArgs[0]), string(AArgs[1]));
end;

function TDataSet_GetFieldNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetFieldNames(List: TStrings);

  TDataSet(AObj).GetFieldNames(TStrings_sw.FromVar(AArgs[0]));
end;

function TDataSet_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Insert;

  TDataSet(AObj).Insert();
end;

function TDataSet_IsEmpty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsEmpty: Boolean;

  Result := TDataSet(AObj).IsEmpty();
end;

function TDataSet_IsLinkedTo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsLinkedTo(DataSource: TDataSource): Boolean;

  Result := TDataSet(AObj).IsLinkedTo(TDataSource_sw.FromVar(AArgs[0]));
end;

function TDataSet_IsSequenced_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsSequenced: Boolean;

  Result := TDataSet(AObj).IsSequenced();
end;

function TDataSet_Last_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Last;

  TDataSet(AObj).Last();
end;

function TDataSet_Locate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Locate(const KeyFields: string; const KeyValues:...

  Result := TDataSet(AObj).Locate(string(AArgs[0]), Variant(FindVarData(
    AArgs[1])^), TLocateOptions_sw.FromVar(AArgs[2]));
end;

function TDataSet_Lookup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Lookup(const KeyFields: string; const KeyValues:...

  Result := TDataSet(AObj).Lookup(string(AArgs[0]), Variant(FindVarData(
    AArgs[1])^), string(AArgs[2]));
end;

function TDataSet_MoveBy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveBy(Distance: Integer): Integer;

  Result := TDataSet(AObj).MoveBy(Integer(AArgs[0]));
end;

function TDataSet_Next_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Next;

  TDataSet(AObj).Next();
end;

function TDataSet_Open_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Open;

  TDataSet(AObj).Open();
end;

function TDataSet_Post_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Post;

  TDataSet(AObj).Post();
end;

function TDataSet_Prior_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Prior;

  TDataSet(AObj).Prior();
end;

function TDataSet_Refresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Refresh;

  TDataSet(AObj).Refresh();
end;

function TDataSet_CopyFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CopyFields(Source: TDataSet): Integer;

  Result := TDataSet(AObj).CopyFields(TDataSet_sw.FromVar(AArgs[0]));
end;

function TDataSet_UpdateCursorPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UpdateCursorPos;

  TDataSet(AObj).UpdateCursorPos();
end;

function TDataSet_UpdateRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UpdateRecord;

  TDataSet(AObj).UpdateRecord();
end;

function TDataSet_UpdateStatus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UpdateStatus: TUpdateStatus;

  Result := TUpdateStatus_sw.ToVar(TDataSet(AObj).UpdateStatus());
end;

function TDataSet_AggFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AggFields: TFields read <getter>;

  Result := TFields_sw.ToVar(TDataSet(AObj).AggFields);
end;

function TDataSet_Bof_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bof: Boolean read <getter>;

  Result := TDataSet(AObj).Bof;
end;

function TDataSet_CanModify_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CanModify: Boolean read <getter>;

  Result := TDataSet(AObj).CanModify;
end;

function TDataSet_DataSetField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSetField: TDataSetField read <getter> write ...

  if IsGet then
    Result := TDataSetField_sw.ToVar(TDataSet(AObj).DataSetField)
  else
    TDataSet(AObj).DataSetField := TDataSetField_sw.FromVar(AArgs[0]);
end;

function TDataSet_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter>;

  Result := TDataSource_sw.ToVar(TDataSet(AObj).DataSource);
end;

function TDataSet_DefaultFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultFields: Boolean read <getter>;

  Result := TDataSet(AObj).DefaultFields;
end;

function TDataSet_Designer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Designer: TDataSetDesigner read <getter>;

  Result := TDataSetDesigner_sw.ToVar(TDataSet(AObj).Designer);
end;

function TDataSet_Eof_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Eof: Boolean read <getter>;

  Result := TDataSet(AObj).Eof;
end;

function TDataSet_BlockReadSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BlockReadSize: Integer read <getter> write <sett...

  if IsGet then
    Result := TDataSet(AObj).BlockReadSize
  else
    TDataSet(AObj).BlockReadSize := Integer(AArgs[0]);
end;

function TDataSet_FieldCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldCount: Integer read <getter>;

  Result := TDataSet(AObj).FieldCount;
end;

function TDataSet_FieldDefs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldDefs: TFieldDefs read <getter> write <setter>;

  if IsGet then
    Result := TFieldDefs_sw.ToVar(TDataSet(AObj).FieldDefs)
  else
    TDataSet(AObj).FieldDefs := TFieldDefs_sw.FromVar(AArgs[0]);
end;

function TDataSet_FieldDefList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldDefList: TFieldDefList read <getter>;

  Result := TFieldDefList_sw.ToVar(TDataSet(AObj).FieldDefList);
end;

function TDataSet_Fields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Fields: TFields read <getter>;

  Result := TFields_sw.ToVar(TDataSet(AObj).Fields);
end;

function TDataSet_FieldList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldList: TFieldList read <getter>;

  Result := TFieldList_sw.ToVar(TDataSet(AObj).FieldList);
end;

function TDataSet_FieldValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldValues[const FieldName: string]: Variant re...

  if IsGet then
    Result := TDataSet(AObj).FieldValues[string(AArgs[0])]
  else
    TDataSet(AObj).FieldValues[string(AArgs[0])] := Variant(FindVarData(
      AArgs[1])^);
end;

function TDataSet_Found_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Found: Boolean read <getter>;

  Result := TDataSet(AObj).Found;
end;

function TDataSet_IsUniDirectional_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsUniDirectional: Boolean read <getter>;

  Result := TDataSet(AObj).IsUniDirectional;
end;

function TDataSet_Modified_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Modified: Boolean read <getter>;

  Result := TDataSet(AObj).Modified;
end;

function TDataSet_ObjectView_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ObjectView: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDataSet(AObj).ObjectView
  else
    TDataSet(AObj).ObjectView := Boolean(AArgs[0]);
end;

function TDataSet_RecordCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RecordCount: Integer read <getter>;

  Result := TDataSet(AObj).RecordCount;
end;

function TDataSet_RecNo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RecNo: Integer read <getter> write <setter>;

  if IsGet then
    Result := TDataSet(AObj).RecNo
  else
    TDataSet(AObj).RecNo := Integer(AArgs[0]);
end;

function TDataSet_RecordSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RecordSize: Word read <getter>;

  Result := TDataSet(AObj).RecordSize;
end;

function TDataSet_SparseArrays_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SparseArrays: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDataSet(AObj).SparseArrays
  else
    TDataSet(AObj).SparseArrays := Boolean(AArgs[0]);
end;

function TDataSet_State_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property State: TDataSetState read <getter>;

  Result := TDataSetState_sw.ToVar(TDataSet(AObj).State);
end;

function TDataSet_Filter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Filter: string read <getter> write <setter>;

  if IsGet then
    Result := TDataSet(AObj).Filter
  else
    TDataSet(AObj).Filter := string(AArgs[0]);
end;

function TDataSet_Filtered_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Filtered: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDataSet(AObj).Filtered
  else
    TDataSet(AObj).Filtered := Boolean(AArgs[0]);
end;

function TDataSet_FilterOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FilterOptions: TFilterOptions read <getter> writ...

  if IsGet then
    Result := TFilterOptions_sw.ToVar(TDataSet(AObj).FilterOptions)
  else
    TDataSet(AObj).FilterOptions := TFilterOptions_sw.FromVar(AArgs[0]);
end;

function TDataSet_Active_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Active: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDataSet(AObj).Active
  else
    TDataSet(AObj).Active := Boolean(AArgs[0]);
end;

function TDataSet_AutoCalcFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoCalcFields: Boolean read <getter> write <set...

  if IsGet then
    Result := TDataSet(AObj).AutoCalcFields
  else
    TDataSet(AObj).AutoCalcFields := Boolean(AArgs[0]);
end;

function TDataSet_BeforeOpen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeOpen: TDataSetNotifyEvent read <getter> wr...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).BeforeOpen)
  else
    TDataSet(AObj).BeforeOpen := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_AfterOpen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterOpen: TDataSetNotifyEvent read <getter> wri...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).AfterOpen)
  else
    TDataSet(AObj).AfterOpen := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_BeforeClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeClose: TDataSetNotifyEvent read <getter> w...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).BeforeClose)
  else
    TDataSet(AObj).BeforeClose := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_AfterClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterClose: TDataSetNotifyEvent read <getter> wr...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).AfterClose)
  else
    TDataSet(AObj).AfterClose := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_BeforeInsert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeInsert: TDataSetNotifyEvent read <getter> ...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).BeforeInsert)
  else
    TDataSet(AObj).BeforeInsert := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_AfterInsert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterInsert: TDataSetNotifyEvent read <getter> w...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).AfterInsert)
  else
    TDataSet(AObj).AfterInsert := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_BeforeEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeEdit: TDataSetNotifyEvent read <getter> wr...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).BeforeEdit)
  else
    TDataSet(AObj).BeforeEdit := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_AfterEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterEdit: TDataSetNotifyEvent read <getter> wri...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).AfterEdit)
  else
    TDataSet(AObj).AfterEdit := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_BeforePost_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforePost: TDataSetNotifyEvent read <getter> wr...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).BeforePost)
  else
    TDataSet(AObj).BeforePost := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_AfterPost_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterPost: TDataSetNotifyEvent read <getter> wri...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).AfterPost)
  else
    TDataSet(AObj).AfterPost := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_BeforeCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeCancel: TDataSetNotifyEvent read <getter> ...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).BeforeCancel)
  else
    TDataSet(AObj).BeforeCancel := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_AfterCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterCancel: TDataSetNotifyEvent read <getter> w...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).AfterCancel)
  else
    TDataSet(AObj).AfterCancel := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_BeforeDelete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeDelete: TDataSetNotifyEvent read <getter> ...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).BeforeDelete)
  else
    TDataSet(AObj).BeforeDelete := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_AfterDelete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterDelete: TDataSetNotifyEvent read <getter> w...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).AfterDelete)
  else
    TDataSet(AObj).AfterDelete := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_BeforeScroll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeScroll: TDataSetNotifyEvent read <getter> ...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).BeforeScroll)
  else
    TDataSet(AObj).BeforeScroll := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_AfterScroll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterScroll: TDataSetNotifyEvent read <getter> w...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).AfterScroll)
  else
    TDataSet(AObj).AfterScroll := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_BeforeRefresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeRefresh: TDataSetNotifyEvent read <getter>...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).BeforeRefresh)
  else
    TDataSet(AObj).BeforeRefresh := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_AfterRefresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterRefresh: TDataSetNotifyEvent read <getter> ...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).AfterRefresh)
  else
    TDataSet(AObj).AfterRefresh := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_OnCalcFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCalcFields: TDataSetNotifyEvent read <getter> ...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).OnCalcFields)
  else
    TDataSet(AObj).OnCalcFields := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_OnDeleteError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDeleteError: TDataSetErrorEvent read <getter> ...

  if IsGet then
    Result := TDataSetErrorEvent_sw.ToVar(TDataSet(AObj).OnDeleteError)
  else
    TDataSet(AObj).OnDeleteError := TDataSetErrorEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_OnEditError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnEditError: TDataSetErrorEvent read <getter> wr...

  if IsGet then
    Result := TDataSetErrorEvent_sw.ToVar(TDataSet(AObj).OnEditError)
  else
    TDataSet(AObj).OnEditError := TDataSetErrorEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_OnFilterRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFilterRecord: TFilterRecordEvent read <getter>...

  if IsGet then
    Result := TFilterRecordEvent_sw.ToVar(TDataSet(AObj).OnFilterRecord)
  else
    TDataSet(AObj).OnFilterRecord := TFilterRecordEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_OnNewRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnNewRecord: TDataSetNotifyEvent read <getter> w...

  if IsGet then
    Result := TDataSetNotifyEvent_sw.ToVar(TDataSet(AObj).OnNewRecord)
  else
    TDataSet(AObj).OnNewRecord := TDataSetNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataSet_OnPostError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnPostError: TDataSetErrorEvent read <getter> wr...

  if IsGet then
    Result := TDataSetErrorEvent_sw.ToVar(TDataSet(AObj).OnPostError)
  else
    TDataSet(AObj).OnPostError := TDataSetErrorEvent_sw.FromVar(AArgs[0]);
end;

class function TDataSet_sw.GetTypeName: WideString;
begin
  Result := 'TDataSet';
end;

class function TDataSet_sw.GetWrappedClass: TClass;
begin
  Result := TDataSet;
end;

class procedure TDataSet_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ActiveRecord', TDataSet_ActiveRecord_si, Integer_sw, True, False, 0, True, False);
  AData.AddProperty('CurrentRecord', TDataSet_CurrentRecord_si, Integer_sw, True, False, 0, True, False);
  AData.AddProperty('BlobFieldCount', TDataSet_BlobFieldCount_si, Integer_sw, True, False, 0, True, False);
  AData.AddProperty('BookmarkSize', TDataSet_BookmarkSize_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('Buffers', TDataSet_Buffers_si, TRecBuf_sw, True, False, 1, True, False);
  AData.AddProperty('BufferCount', TDataSet_BufferCount_si, Integer_sw, True, False, 0, True, False);
  AData.AddProperty('CalcBuffer', TDataSet_CalcBuffer_si, NativeInt_sw, True, False, 0, True, False);
  AData.AddProperty('CalcFieldsSize', TDataSet_CalcFieldsSize_si, Integer_sw, True, False, 0, True, False);
  AData.AddProperty('Constraints', TDataSet_Constraints_si, TCheckConstraints_sw, True, True, 0, True, False);
  AData.AddProperty('FieldNoOfs', TDataSet_FieldNoOfs_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('InternalCalcFields', TDataSet_InternalCalcFields_si, Boolean_sw, True, False, 0, True, False);
  AData.AddProperty('NestedDataSetClass', TDataSet_NestedDataSetClass_si, TDataSetClass_sw, True, True, 0, True, False);
  AData.AddFunction('ActiveBuffer', TDataSet_ActiveBuffer_si, TRecBuf_sw, 0, False);
  AData.AddProcedure('Append', TDataSet_Append_si, 0, False);
  AData.AddProcedure('Cancel', TDataSet_Cancel_si, 0, False);
  AData.AddProcedure('CheckBrowseMode', TDataSet_CheckBrowseMode_si, 0, False);
  AData.AddProcedure('ClearFields', TDataSet_ClearFields_si, 0, False);
  AData.AddProcedure('Close', TDataSet_Close_si, 0, False);
  AData.AddFunction('ControlsDisabled', TDataSet_ControlsDisabled_si, Boolean_sw, 0, False);
  AData.AddFunction('CreateBlobStream', TDataSet_CreateBlobStream_si, TStream_sw, 2, False);
  AData.AddProcedure('CursorPosChanged', TDataSet_CursorPosChanged_si, 0, False);
  AData.AddProcedure('Delete', TDataSet_Delete_si, 0, False);
  AData.AddProcedure('DisableControls', TDataSet_DisableControls_si, 0, False);
  AData.AddProcedure('Edit', TDataSet_Edit_si, 0, False);
  AData.AddProcedure('EnableControls', TDataSet_EnableControls_si, 0, False);
  AData.AddFunction('FieldByName', TDataSet_FieldByName_si, TField_sw, 1, False);
  AData.AddFunction('FindField', TDataSet_FindField_si, TField_sw, 1, False);
  AData.AddFunction('FindFirst', TDataSet_FindFirst_si, Boolean_sw, 0, False);
  AData.AddFunction('FindLast', TDataSet_FindLast_si, Boolean_sw, 0, False);
  AData.AddFunction('FindNext', TDataSet_FindNext_si, Boolean_sw, 0, False);
  AData.AddFunction('FindPrior', TDataSet_FindPrior_si, Boolean_sw, 0, False);
  AData.AddProcedure('First', TDataSet_First_si, 0, False);
  AData.AddFunction('GetCurrentRecord', TDataSet_GetCurrentRecord_si, nil, 1, False);
  AData.AddProcedure('GetDetailDataSets', TDataSet_GetDetailDataSets_si, 1, False);
  AData.AddProcedure('GetDetailLinkFields', TDataSet_GetDetailLinkFields_si, 2, False);
  AData.AddProcedure('GetFieldList', TDataSet_GetFieldList_si, 2, False);
  AData.AddProcedure('GetFieldNames', TDataSet_GetFieldNames_si, 1, False);
  AData.AddProcedure('Insert', TDataSet_Insert_si, 0, False);
  AData.AddFunction('IsEmpty', TDataSet_IsEmpty_si, Boolean_sw, 0, False);
  AData.AddFunction('IsLinkedTo', TDataSet_IsLinkedTo_si, Boolean_sw, 1, False);
  AData.AddFunction('IsSequenced', TDataSet_IsSequenced_si, Boolean_sw, 0, False);
  AData.AddProcedure('Last', TDataSet_Last_si, 0, False);
  AData.AddFunction('Locate', TDataSet_Locate_si, Boolean_sw, 3, False);
  AData.AddFunction('Lookup', TDataSet_Lookup_si, Variant_sw, 3, False);
  AData.AddFunction('MoveBy', TDataSet_MoveBy_si, Integer_sw, 1, False);
  AData.AddProcedure('Next', TDataSet_Next_si, 0, False);
  AData.AddProcedure('Open', TDataSet_Open_si, 0, False);
  AData.AddProcedure('Post', TDataSet_Post_si, 0, False);
  AData.AddProcedure('Prior', TDataSet_Prior_si, 0, False);
  AData.AddProcedure('Refresh', TDataSet_Refresh_si, 0, False);
  AData.AddFunction('CopyFields', TDataSet_CopyFields_si, Integer_sw, 1, False);
  AData.AddProcedure('UpdateCursorPos', TDataSet_UpdateCursorPos_si, 0, False);
  AData.AddProcedure('UpdateRecord', TDataSet_UpdateRecord_si, 0, False);
  AData.AddFunction('UpdateStatus', TDataSet_UpdateStatus_si, TUpdateStatus_sw, 0, False);
  AData.AddProperty('AggFields', TDataSet_AggFields_si, TFields_sw, True, False, 0, False, False);
  AData.AddProperty('Bof', TDataSet_Bof_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('CanModify', TDataSet_CanModify_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('DataSetField', TDataSet_DataSetField_si, TDataSetField_sw, True, True, 0, False, False);
  AData.AddProperty('DataSource', TDataSet_DataSource_si, TDataSource_sw, True, False, 0, False, False);
  AData.AddProperty('DefaultFields', TDataSet_DefaultFields_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Designer', TDataSet_Designer_si, TDataSetDesigner_sw, True, False, 0, False, False);
  AData.AddProperty('Eof', TDataSet_Eof_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('BlockReadSize', TDataSet_BlockReadSize_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('FieldCount', TDataSet_FieldCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('FieldDefs', TDataSet_FieldDefs_si, TFieldDefs_sw, True, True, 0, False, False);
  AData.AddProperty('FieldDefList', TDataSet_FieldDefList_si, TFieldDefList_sw, True, False, 0, False, False);
  AData.AddProperty('Fields', TDataSet_Fields_si, TFields_sw, True, False, 0, False, False);
  AData.AddProperty('FieldList', TDataSet_FieldList_si, TFieldList_sw, True, False, 0, False, False);
  AData.AddProperty('FieldValues', TDataSet_FieldValues_si, Variant_sw, True, True, 1, False, True);
  AData.AddProperty('Found', TDataSet_Found_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('IsUniDirectional', TDataSet_IsUniDirectional_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Modified', TDataSet_Modified_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('ObjectView', TDataSet_ObjectView_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('RecordCount', TDataSet_RecordCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('RecNo', TDataSet_RecNo_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('RecordSize', TDataSet_RecordSize_si, Word_sw, True, False, 0, False, False);
  AData.AddProperty('SparseArrays', TDataSet_SparseArrays_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('State', TDataSet_State_si, TDataSetState_sw, True, False, 0, False, False);
  AData.AddProperty('Filter', TDataSet_Filter_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Filtered', TDataSet_Filtered_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('FilterOptions', TDataSet_FilterOptions_si, TFilterOptions_sw, True, True, 0, False, False);
  AData.AddProperty('Active', TDataSet_Active_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AutoCalcFields', TDataSet_AutoCalcFields_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('BeforeOpen', TDataSet_BeforeOpen_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('AfterOpen', TDataSet_AfterOpen_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('BeforeClose', TDataSet_BeforeClose_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('AfterClose', TDataSet_AfterClose_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('BeforeInsert', TDataSet_BeforeInsert_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('AfterInsert', TDataSet_AfterInsert_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('BeforeEdit', TDataSet_BeforeEdit_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('AfterEdit', TDataSet_AfterEdit_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('BeforePost', TDataSet_BeforePost_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('AfterPost', TDataSet_AfterPost_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('BeforeCancel', TDataSet_BeforeCancel_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('AfterCancel', TDataSet_AfterCancel_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('BeforeDelete', TDataSet_BeforeDelete_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('AfterDelete', TDataSet_AfterDelete_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('BeforeScroll', TDataSet_BeforeScroll_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('AfterScroll', TDataSet_AfterScroll_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('BeforeRefresh', TDataSet_BeforeRefresh_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('AfterRefresh', TDataSet_AfterRefresh_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnCalcFields', TDataSet_OnCalcFields_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDeleteError', TDataSet_OnDeleteError_si, TDataSetErrorEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnEditError', TDataSet_OnEditError_si, TDataSetErrorEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnFilterRecord', TDataSet_OnFilterRecord_si, TFilterRecordEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnNewRecord', TDataSet_OnNewRecord_si, TDataSetNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnPostError', TDataSet_OnPostError_si, TDataSetErrorEvent_sw, True, True, 0, False, False);
end;

class function TDataSet_sw.ToVar(const AValue: TDataSet): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDataSet_sw.FromVar(const AValue: OleVariant): TDataSet;
begin
  Result := TDataSet(ConvFromVar(AValue, TDataSet));
end;

class function TDataSet_sw.ClassToVar(AClass: TDataSet_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDataSet_sw.ClassFromVar(const AClass: OleVariant): TDataSet_sc;
begin
  Result := TDataSet_sc(ConvClsFromVar(AClass, TDataSet));
end;

{ TDateTimeAlias_sw }

class function TDateTimeAlias_sw.GetTypeName: WideString;
begin
  Result := 'TDateTimeAlias';
end;

class function TDateTimeAlias_sw.ToVar(
  const AValue: TDateTimeAlias): OleVariant;
begin
  Result := TDateTime_sw.ToVar(TDateTime(AValue));
end;

class function TDateTimeAlias_sw.FromVar(
  const AValue: OleVariant): TDateTimeAlias;
begin
  Result := TDateTimeAlias(TDateTime_sw.FromVar(AValue));
end;

{ TDateTimeRec_sw }

function TDateTimeRec_Date_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Date: Longint;

  if IsGet then
    Result := TDateTimeRec_sw(AObj).FValue.Date
  else
    TDateTimeRec_sw(AObj).FValue.Date := Longint(AArgs[0]);
end;

function TDateTimeRec_Time_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Time: Longint;

  if IsGet then
    Result := TDateTimeRec_sw(AObj).FValue.Time
  else
    TDateTimeRec_sw(AObj).FValue.Time := Longint(AArgs[0]);
end;

function TDateTimeRec_DateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DateTime: TDateTimeAlias;

  if IsGet then
    Result := TDateTimeAlias_sw.ToVar(TDateTimeRec_sw(AObj).FValue.DateTime)
  else
    TDateTimeRec_sw(AObj).FValue.DateTime := TDateTimeAlias_sw.FromVar(
      AArgs[0]);
end;

function TDateTimeRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TDateTimeRec_sw.Create as IDispatch;
end;

function TDateTimeRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TDateTimeRec;

  // Implicit record copy method.
  Result := TDateTimeRec_sw.ToVar(TDateTimeRec(AObj));
end;

class function TDateTimeRec_sw.GetTypeName: WideString;
begin
  Result := 'TDateTimeRec';
end;

function TDateTimeRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TDateTimeRec_sw.Create;
  TDateTimeRec_sw(Result).FValue := FValue;
end;

class procedure TDateTimeRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Date', TDateTimeRec_Date_si, Longint_sw);
  AData.AddField('Time', TDateTimeRec_Time_si, Longint_sw);
  AData.AddField('DateTime', TDateTimeRec_DateTime_si, TDateTimeAlias_sw);
  AData.AddFunction('Copy', TDateTimeRec_Copy_si, TDateTimeRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TDateTimeRec_Create_si, 0, False);
end;

class function TDateTimeRec_sw.ToVar(const AValue: TDateTimeRec): OleVariant;
var
  wrpr: TDateTimeRec_sw;
begin
  wrpr        := TDateTimeRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TDateTimeRec_sw.FromVar(const AValue: OleVariant): TDateTimeRec;
begin
  Result := TDateTimeRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TDBScreenCursor_sw }

class function TDBScreenCursor_sw.GetTypeName: WideString;
begin
  Result := 'TDBScreenCursor';
end;

class procedure TDBScreenCursor_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'dcrDefault'; Value: Integer({$IFDEF LMDSCT_12}TDBScreenCursor.{$ENDIF}dcrDefault)),
    (Name: 'dcrHourGlass'; Value: Integer({$IFDEF LMDSCT_12}TDBScreenCursor.{$ENDIF}dcrHourGlass)),
    (Name: 'dcrSQLWait'; Value: Integer({$IFDEF LMDSCT_12}TDBScreenCursor.{$ENDIF}dcrSQLWait)),
    (Name: 'dcrOther'; Value: Integer({$IFDEF LMDSCT_12}TDBScreenCursor.{$ENDIF}dcrOther))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TDBScreenCursor_sw.ToVar(
  const AValue: TDBScreenCursor): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDBScreenCursor_sw.FromVar(
  const AValue: OleVariant): TDBScreenCursor;
begin
  Result := TDBScreenCursor(Integer(AValue));
end;

{ DB_sw }

function DB_EDatabaseError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EDatabaseError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EDatabaseError_sw);
end;

function DB_EUpdateError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EUpdateError = class(EDatabaseError);

  Result := TLMDUnitWrapper.TypeToVar(EUpdateError_sw);
end;

function DB_TFieldType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldType = (ftUnknown, ftString, ftSmallint, ftInt...

  Result := TLMDUnitWrapper.TypeToVar(TFieldType_sw);
end;

function DB_TDataSetState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSetState = (dsInactive, dsBrowse, dsEdit, dsIns...

  Result := TLMDUnitWrapper.TypeToVar(TDataSetState_sw);
end;

function DB_TDataEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataEvent = (deFieldChange, deRecordChange, deDataS...

  Result := TLMDUnitWrapper.TypeToVar(TDataEvent_sw);
end;

function DB_TUpdateStatus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUpdateStatus = (usUnmodified, usModified, usInserte...

  Result := TLMDUnitWrapper.TypeToVar(TUpdateStatus_sw);
end;

function DB_TUpdateStatusSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUpdateStatusSet = set of TUpdateStatus;

  Result := TLMDUnitWrapper.TypeToVar(TUpdateStatusSet_sw);
end;

function DB_TUpdateAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUpdateAction = (uaFail, uaAbort, uaSkip, uaRetry, u...

  Result := TLMDUnitWrapper.TypeToVar(TUpdateAction_sw);
end;

function DB_TUpdateMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUpdateMode = (upWhereAll, upWhereChanged, upWhereKe...

  Result := TLMDUnitWrapper.TypeToVar(TUpdateMode_sw);
end;

function DB_TUpdateKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUpdateKind = (ukModify, ukInsert, ukDelete);

  Result := TLMDUnitWrapper.TypeToVar(TUpdateKind_sw);
end;

function DB_TUpdateErrorEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUpdateErrorEvent = procedure (DataSet: TDataSet; E:...

  Result := TLMDUnitWrapper.TypeToVar(TUpdateErrorEvent_sw);
end;

function DB_TUpdateRecordEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUpdateRecordEvent = procedure (DataSet: TDataSet; U...

  Result := TLMDUnitWrapper.TypeToVar(TUpdateRecordEvent_sw);
end;

function DB_TConnectChangeEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConnectChangeEvent = procedure (Sender: TObject; Co...

  Result := TLMDUnitWrapper.TypeToVar(TConnectChangeEvent_sw);
end;

function DB_TCustomConnection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomConnection = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomConnection_sw);
end;

function DB_TNamedItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNamedItem = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TNamedItem_sw);
end;

function DB_TDefUpdateMethod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDefUpdateMethod = procedure  of object;

  Result := TLMDUnitWrapper.TypeToVar(TDefUpdateMethod_sw);
end;

function DB_TDefCollection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDefCollection = class(TOwnedCollection);

  Result := TLMDUnitWrapper.TypeToVar(TDefCollection_sw);
end;

function DB_TFieldClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldClass = class of TField;

  Result := TLMDUnitWrapper.TypeToVar(TFieldClass_sw);
end;

function DB_TFieldAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldAttribute = (faHiddenCol, faReadonly, faRequir...

  Result := TLMDUnitWrapper.TypeToVar(TFieldAttribute_sw);
end;

function DB_TFieldAttributes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldAttributes = set of TFieldAttribute;

  Result := TLMDUnitWrapper.TypeToVar(TFieldAttributes_sw);
end;

function DB_TFieldDefsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldDefsClass = class of TFieldDefs;

  Result := TLMDUnitWrapper.TypeToVar(TFieldDefsClass_sw);
end;

function DB_TFieldDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldDef = class(TNamedItem);

  Result := TLMDUnitWrapper.TypeToVar(TFieldDef_sw);
end;

function DB_TFieldDefClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldDefClass = class of TFieldDef;

  Result := TLMDUnitWrapper.TypeToVar(TFieldDefClass_sw);
end;

function DB_TFieldDefs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldDefs = class(TDefCollection);

  Result := TLMDUnitWrapper.TypeToVar(TFieldDefs_sw);
end;

function DB_TIndexOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIndexOption = (ixPrimary, ixUnique, ixDescending, i...

  Result := TLMDUnitWrapper.TypeToVar(TIndexOption_sw);
end;

function DB_TIndexOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIndexOptions = set of TIndexOption;

  Result := TLMDUnitWrapper.TypeToVar(TIndexOptions_sw);
end;

function DB_TIndexDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIndexDef = class(TNamedItem);

  Result := TLMDUnitWrapper.TypeToVar(TIndexDef_sw);
end;

function DB_TIndexDefClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIndexDefClass = class of TIndexDef;

  Result := TLMDUnitWrapper.TypeToVar(TIndexDefClass_sw);
end;

function DB_TIndexDefs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIndexDefs = class(TDefCollection);

  Result := TLMDUnitWrapper.TypeToVar(TIndexDefs_sw);
end;

function DB_TIndexDefsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIndexDefsClass = class of TIndexDefs;

  Result := TLMDUnitWrapper.TypeToVar(TIndexDefsClass_sw);
end;

function DB_TFlatList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFlatList = class(TStringList);

  Result := TLMDUnitWrapper.TypeToVar(TFlatList_sw);
end;

function DB_TFieldDefList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldDefList = class(TFlatList);

  Result := TLMDUnitWrapper.TypeToVar(TFieldDefList_sw);
end;

function DB_TFieldDefListClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldDefListClass = class of TFieldDefList;

  Result := TLMDUnitWrapper.TypeToVar(TFieldDefListClass_sw);
end;

function DB_TFieldList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldList = class(TFlatList);

  Result := TLMDUnitWrapper.TypeToVar(TFieldList_sw);
end;

function DB_TFieldListClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldListClass = class of TFieldList;

  Result := TLMDUnitWrapper.TypeToVar(TFieldListClass_sw);
end;

function DB_TFieldsEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldsEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TFieldsEnumerator_sw);
end;

function DB_TFieldKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldKind = (fkData, fkCalculated, fkLookup, fkInte...

  Result := TLMDUnitWrapper.TypeToVar(TFieldKind_sw);
end;

function DB_TFieldKinds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldKinds = set of TFieldKind;

  Result := TLMDUnitWrapper.TypeToVar(TFieldKinds_sw);
end;

function DB_TFields_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TFields = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TFields_sw);
end;

function DB_TFieldsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldsClass = class of TFields;

  Result := TLMDUnitWrapper.TypeToVar(TFieldsClass_sw);
end;

function DB_TProviderFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProviderFlag = (pfInUpdate, pfInWhere, pfInKey, pfH...

  Result := TLMDUnitWrapper.TypeToVar(TProviderFlag_sw);
end;

function DB_TProviderFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProviderFlags = set of TProviderFlag;

  Result := TLMDUnitWrapper.TypeToVar(TProviderFlags_sw);
end;

function DB_TFieldNotifyEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldNotifyEvent = procedure (Sender: TField) of ob...

  Result := TLMDUnitWrapper.TypeToVar(TFieldNotifyEvent_sw);
end;

function DB_TFieldGetTextEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldGetTextEvent = procedure (Sender: TField; var ...

  Result := TLMDUnitWrapper.TypeToVar(TFieldGetTextEvent_sw);
end;

function DB_TFieldSetTextEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldSetTextEvent = procedure (Sender: TField; cons...

  Result := TLMDUnitWrapper.TypeToVar(TFieldSetTextEvent_sw);
end;

function DB_TFieldChars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldChars = set of AnsiChar;

  Result := TLMDUnitWrapper.TypeToVar(TFieldChars_sw);
end;

function DB_TAutoRefreshFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAutoRefreshFlag = (arNone, arAutoInc, arDefault);

  Result := TLMDUnitWrapper.TypeToVar(TAutoRefreshFlag_sw);
end;

function DB_TLookupList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLookupList = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TLookupList_sw);
end;

function DB_TLookupListClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLookupListClass = class of TLookupList;

  Result := TLMDUnitWrapper.TypeToVar(TLookupListClass_sw);
end;

function DB_TLookupListEntry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLookupListEntry = record;

  Result := TLMDUnitWrapper.TypeToVar(TLookupListEntry_sw);
end;

function DB_TDefaultLookupList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDefaultLookupList = class(TLookupList);

  Result := TLMDUnitWrapper.TypeToVar(TDefaultLookupList_sw);
end;

function DB_Largeint_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type Largeint = Int64;

  Result := TLMDUnitWrapper.TypeToVar(Largeint_sw);
end;

function DB_TField_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TField = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TField_sw);
end;

function DB_TStringField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStringField = class(TField);

  Result := TLMDUnitWrapper.TypeToVar(TStringField_sw);
end;

function DB_TWideStringField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWideStringField = class(TStringField);

  Result := TLMDUnitWrapper.TypeToVar(TWideStringField_sw);
end;

function DB_TNumericField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNumericField = class(TField);

  Result := TLMDUnitWrapper.TypeToVar(TNumericField_sw);
end;

function DB_TIntegerField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIntegerField = class(TNumericField);

  Result := TLMDUnitWrapper.TypeToVar(TIntegerField_sw);
end;

function DB_TLongWordField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLongWordField = class(TNumericField);

  Result := TLMDUnitWrapper.TypeToVar(TLongWordField_sw);
end;

function DB_TSmallintField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSmallintField = class(TIntegerField);

  Result := TLMDUnitWrapper.TypeToVar(TSmallintField_sw);
end;

function DB_TShortintField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TShortintField = class(TIntegerField);

  Result := TLMDUnitWrapper.TypeToVar(TShortintField_sw);
end;

function DB_TByteField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TByteField = class(TIntegerField);

  Result := TLMDUnitWrapper.TypeToVar(TByteField_sw);
end;

function DB_TLargeintField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLargeintField = class(TNumericField);

  Result := TLMDUnitWrapper.TypeToVar(TLargeintField_sw);
end;

function DB_TWordField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWordField = class(TIntegerField);

  Result := TLMDUnitWrapper.TypeToVar(TWordField_sw);
end;

function DB_TAutoIncField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAutoIncField = class(TIntegerField);

  Result := TLMDUnitWrapper.TypeToVar(TAutoIncField_sw);
end;

function DB_TUnsignedAutoIncField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUnsignedAutoIncField = class(TLongWordField);

  Result := TLMDUnitWrapper.TypeToVar(TUnsignedAutoIncField_sw);
end;

function DB_TFloatField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFloatField = class(TNumericField);

  Result := TLMDUnitWrapper.TypeToVar(TFloatField_sw);
end;

function DB_TSingleField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSingleField = class(TNumericField);

  Result := TLMDUnitWrapper.TypeToVar(TSingleField_sw);
end;

function DB_TCurrencyField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCurrencyField = class(TFloatField);

  Result := TLMDUnitWrapper.TypeToVar(TCurrencyField_sw);
end;

function DB_TExtendedField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExtendedField = class(TNumericField);

  Result := TLMDUnitWrapper.TypeToVar(TExtendedField_sw);
end;

function DB_TBooleanField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBooleanField = class(TField);

  Result := TLMDUnitWrapper.TypeToVar(TBooleanField_sw);
end;

function DB_TDateTimeField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDateTimeField = class(TField);

  Result := TLMDUnitWrapper.TypeToVar(TDateTimeField_sw);
end;

function DB_TSQLTimeStampField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSQLTimeStampField = class(TField);

  Result := TLMDUnitWrapper.TypeToVar(TSQLTimeStampField_sw);
end;

function DB_TSQLTimeStampOffsetField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSQLTimeStampOffsetField = class(TSQLTimeStampField);

  Result := TLMDUnitWrapper.TypeToVar(TSQLTimeStampOffsetField_sw);
end;

function DB_TDateField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDateField = class(TDateTimeField);

  Result := TLMDUnitWrapper.TypeToVar(TDateField_sw);
end;

function DB_TTimeField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTimeField = class(TDateTimeField);

  Result := TLMDUnitWrapper.TypeToVar(TTimeField_sw);
end;

function DB_TBinaryField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBinaryField = class(TField);

  Result := TLMDUnitWrapper.TypeToVar(TBinaryField_sw);
end;

function DB_TBytesField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBytesField = class(TBinaryField);

  Result := TLMDUnitWrapper.TypeToVar(TBytesField_sw);
end;

function DB_TVarBytesField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVarBytesField = class(TBytesField);

  Result := TLMDUnitWrapper.TypeToVar(TVarBytesField_sw);
end;

function DB_TBCDField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBCDField = class(TNumericField);

  Result := TLMDUnitWrapper.TypeToVar(TBCDField_sw);
end;

function DB_TFMTBCDField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFMTBCDField = class(TNumericField);

  Result := TLMDUnitWrapper.TypeToVar(TFMTBCDField_sw);
end;

function DB_TBlobType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBlobType = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TBlobType_sw);
end;

function DB_TBlobField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBlobField = class(TField);

  Result := TLMDUnitWrapper.TypeToVar(TBlobField_sw);
end;

function DB_TMemoField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMemoField = class(TBlobField);

  Result := TLMDUnitWrapper.TypeToVar(TMemoField_sw);
end;

function DB_TWideMemoField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWideMemoField = class(TBlobField);

  Result := TLMDUnitWrapper.TypeToVar(TWideMemoField_sw);
end;

function DB_TGraphicField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGraphicField = class(TBlobField);

  Result := TLMDUnitWrapper.TypeToVar(TGraphicField_sw);
end;

function DB_TObjectField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TObjectField = class(TField);

  Result := TLMDUnitWrapper.TypeToVar(TObjectField_sw);
end;

function DB_TADTField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TADTField = class(TObjectField);

  Result := TLMDUnitWrapper.TypeToVar(TADTField_sw);
end;

function DB_TArrayField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TArrayField = class(TObjectField);

  Result := TLMDUnitWrapper.TypeToVar(TArrayField_sw);
end;

function DB_TDataSetField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSetField = class(TObjectField);

  Result := TLMDUnitWrapper.TypeToVar(TDataSetField_sw);
end;

function DB_TReferenceField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TReferenceField = class(TDataSetField);

  Result := TLMDUnitWrapper.TypeToVar(TReferenceField_sw);
end;

function DB_TVariantField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVariantField = class(TField);

  Result := TLMDUnitWrapper.TypeToVar(TVariantField_sw);
end;

function DB_TInterfaceField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInterfaceField = class(TField);

  Result := TLMDUnitWrapper.TypeToVar(TInterfaceField_sw);
end;

function DB_TIDispatchField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIDispatchField = class(TInterfaceField);

  Result := TLMDUnitWrapper.TypeToVar(TIDispatchField_sw);
end;

function DB_TGuidField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGuidField = class(TStringField);

  Result := TLMDUnitWrapper.TypeToVar(TGuidField_sw);
end;

function DB_TAggHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAggHandle = TObject;

  Result := TLMDUnitWrapper.TypeToVar(TAggHandle_sw);
end;

function DB_TAggregateField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAggregateField = class(TField);

  Result := TLMDUnitWrapper.TypeToVar(TAggregateField_sw);
end;

function DB_TDataLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataLink = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TDataLink_sw);
end;

function DB_TDetailDataLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDetailDataLink = class(TDataLink);

  Result := TLMDUnitWrapper.TypeToVar(TDetailDataLink_sw);
end;

function DB_TMasterDataLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMasterDataLink = class(TDetailDataLink);

  Result := TLMDUnitWrapper.TypeToVar(TMasterDataLink_sw);
end;

function DB_TDataChangeEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataChangeEvent = procedure (Sender: TObject; Field...

  Result := TLMDUnitWrapper.TypeToVar(TDataChangeEvent_sw);
end;

function DB_TDataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSource = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TDataSource_sw);
end;

function DB_TDataSetDesigner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSetDesigner = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TDataSetDesigner_sw);
end;

function DB_TCheckConstraint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCheckConstraint = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TCheckConstraint_sw);
end;

function DB_TCheckConstraintClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCheckConstraintClass = class of TCheckConstraint;

  Result := TLMDUnitWrapper.TypeToVar(TCheckConstraintClass_sw);
end;

function DB_TCheckConstraints_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCheckConstraints = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(TCheckConstraints_sw);
end;

function DB_TCheckConstraintsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCheckConstraintsClass = class of TCheckConstraints;

  Result := TLMDUnitWrapper.TypeToVar(TCheckConstraintsClass_sw);
end;

function DB_TBitConverter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBitConverter = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TBitConverter_sw);
end;

function DB_TParamType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParamType = (ptUnknown, ptInput, ptOutput, ptInputO...

  Result := TLMDUnitWrapper.TypeToVar(TParamType_sw);
end;

function DB_TParamTypes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParamTypes = set of TParamType;

  Result := TLMDUnitWrapper.TypeToVar(TParamTypes_sw);
end;

function DB_TParamObjectClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParamObjectClass = class of TParamObject;

  Result := TLMDUnitWrapper.TypeToVar(TParamObjectClass_sw);
end;

function DB_TParam_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TParam = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TParam_sw);
end;

function DB_TParamClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParamClass = class of TParam;

  Result := TLMDUnitWrapper.TypeToVar(TParamClass_sw);
end;

function DB_TParams_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TParams = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(TParams_sw);
end;

function DB_TParamsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParamsClass = class of TParams;

  Result := TLMDUnitWrapper.TypeToVar(TParamsClass_sw);
end;

function DB_TParamObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParamObject = class(TInterfacedObject);

  Result := TLMDUnitWrapper.TypeToVar(TParamObject_sw);
end;

function DB_TParamStreamObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParamStreamObject = class(TParamObject);

  Result := TLMDUnitWrapper.TypeToVar(TParamStreamObject_sw);
end;

function DB_TPSCommandType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPSCommandType = (ctUnknown, ctQuery, ctTable, ctSto...

  Result := TLMDUnitWrapper.TypeToVar(TPSCommandType_sw);
end;

function DB_TSQLCommandType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSQLCommandType = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TSQLCommandType_sw);
end;

function DB_TPacketAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPacketAttribute = record;

  Result := TLMDUnitWrapper.TypeToVar(TPacketAttribute_sw);
end;

function DB_TPacketAttributeList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPacketAttributeList = TList;

  Result := TLMDUnitWrapper.TypeToVar(TPacketAttributeList_sw);
end;

function DB_TBookmarkStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBookmarkStr = AnsiString;

  Result := TLMDUnitWrapper.TypeToVar(TBookmarkStr_sw);
end;

function DB_TBookmarkFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBookmarkFlag = (bfCurrent, bfBOF, bfEOF, bfInserted);

  Result := TLMDUnitWrapper.TypeToVar(TBookmarkFlag_sw);
end;

function DB_TRecBuf_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TRecBuf = NativeInt;

  Result := TLMDUnitWrapper.TypeToVar(TRecBuf_sw);
end;

function DB_TGetMode_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TGetMode = (gmCurrent, gmNext, gmPrior);

  Result := TLMDUnitWrapper.TypeToVar(TGetMode_sw);
end;

function DB_TGetResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetResult = (grOK, grBOF, grEOF, grError);

  Result := TLMDUnitWrapper.TypeToVar(TGetResult_sw);
end;

function DB_TDataAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataAction = (daFail, daAbort, daRetry);

  Result := TLMDUnitWrapper.TypeToVar(TDataAction_sw);
end;

function DB_TBlobStreamMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBlobStreamMode = (bmRead, bmWrite, bmReadWrite);

  Result := TLMDUnitWrapper.TypeToVar(TBlobStreamMode_sw);
end;

function DB_TLocateOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLocateOption = (loCaseInsensitive, loPartialKey);

  Result := TLMDUnitWrapper.TypeToVar(TLocateOption_sw);
end;

function DB_TLocateOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLocateOptions = set of TLocateOption;

  Result := TLMDUnitWrapper.TypeToVar(TLocateOptions_sw);
end;

function DB_TDataOperation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataOperation = procedure  of object;

  Result := TLMDUnitWrapper.TypeToVar(TDataOperation_sw);
end;

function DB_TDataSetNotifyEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSetNotifyEvent = procedure (DataSet: TDataSet) ...

  Result := TLMDUnitWrapper.TypeToVar(TDataSetNotifyEvent_sw);
end;

function DB_TDataSetErrorEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSetErrorEvent = procedure (DataSet: TDataSet; E...

  Result := TLMDUnitWrapper.TypeToVar(TDataSetErrorEvent_sw);
end;

function DB_TFilterOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFilterOption = (foCaseInsensitive, foNoPartialCompa...

  Result := TLMDUnitWrapper.TypeToVar(TFilterOption_sw);
end;

function DB_TFilterOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFilterOptions = set of TFilterOption;

  Result := TLMDUnitWrapper.TypeToVar(TFilterOptions_sw);
end;

function DB_TFilterRecordEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFilterRecordEvent = procedure (DataSet: TDataSet; v...

  Result := TLMDUnitWrapper.TypeToVar(TFilterRecordEvent_sw);
end;

function DB_TGroupPosInd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGroupPosInd = (gbFirst, gbMiddle, gbLast);

  Result := TLMDUnitWrapper.TypeToVar(TGroupPosInd_sw);
end;

function DB_TGroupPosInds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGroupPosInds = set of TGroupPosInd;

  Result := TLMDUnitWrapper.TypeToVar(TGroupPosInds_sw);
end;

function DB_TDataSetClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSetClass = class of TDataSet;

  Result := TLMDUnitWrapper.TypeToVar(TDataSetClass_sw);
end;

function DB_TDataSet_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TDataSet = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TDataSet_sw);
end;

function DB_TDateTimeAlias_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDateTimeAlias = TDateTime;

  Result := TLMDUnitWrapper.TypeToVar(TDateTimeAlias_sw);
end;

function DB_TDateTimeRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDateTimeRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TDateTimeRec_sw);
end;

function DB_ftNonTextTypes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ftNonTextTypes = <value>;

  Result := LMDSetToVar(SizeOf(ftNonTextTypes), ftNonTextTypes);
end;

function DB_ftFixedSizeTypes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ftFixedSizeTypes = <value>;

  Result := LMDSetToVar(SizeOf(ftFixedSizeTypes), ftFixedSizeTypes);
end;

function DB_dsEditModes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dsEditModes = <value>;

  Result := LMDSetToVar(SizeOf(dsEditModes), dsEditModes);
end;

function DB_dsWriteModes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dsWriteModes = <value>;

  Result := LMDSetToVar(SizeOf(dsWriteModes), dsWriteModes);
end;

function DB_sApplyUpdatesDataSetCommand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sApplyUpdatesDataSetCommand = <value>;

  Result := sApplyUpdatesDataSetCommand;
end;

function DB_sCancelUpdatesDataSetCommand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sCancelUpdatesDataSetCommand = <value>;

  Result := sCancelUpdatesDataSetCommand;
end;

function DB_ObjectFieldTypes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ObjectFieldTypes = <value>;

  Result := LMDSetToVar(SizeOf(ObjectFieldTypes), ObjectFieldTypes);
end;

function DB_dsMaxStringSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dsMaxStringSize = <value>;

  Result := dsMaxStringSize;
end;

function DB_TDBScreenCursor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBScreenCursor = (dcrDefault, dcrHourGlass, dcrSQLW...

  Result := TLMDUnitWrapper.TypeToVar(TDBScreenCursor_sw);
end;

function DB_ExtractFieldName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // procedure/function ExtractFieldName(...); overload;

  v_1 := Integer(AArgs[1]);
  Result := Data.DB.ExtractFieldName(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function DB_DatabaseError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DatabaseError(const Message: string; Component:...

  case AArgsSize of
    1:
    begin
      Data.DB.DatabaseError(string(AArgs[0]));
    end;
    2:
    begin
      Data.DB.DatabaseError(string(AArgs[0]), TComponent_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('DatabaseError');
  end;
end;

function DB_GetFieldProperty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetFieldProperty(DataSet: TDataSet; Control: TCo...

  Result := TField_sw.ToVar(Data.DB.GetFieldProperty(TDataSet_sw.FromVar(
    AArgs[0]), TComponent_sw.FromVar(AArgs[1]), string(AArgs[2])));
end;

function DB_VarTypeToDataType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarTypeToDataType(VarType: Integer): TFieldType;

  Result := TFieldType_sw.ToVar(Data.DB.VarTypeToDataType(Integer(AArgs[0])));
end;

function DB_DefaultFieldDefsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultFieldDefsClass: TFieldDefsClass;

  if IsGet then
    Result := TFieldDefsClass_sw.ToVar(Data.DB.DefaultFieldDefsClass)
  else
    Data.DB.DefaultFieldDefsClass := TFieldDefsClass_sw.FromVar(AArgs[0]);
end;

function DB_DefaultFieldDefClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultFieldDefClass: TFieldDefClass;

  if IsGet then
    Result := TFieldDefClass_sw.ToVar(Data.DB.DefaultFieldDefClass)
  else
    Data.DB.DefaultFieldDefClass := TFieldDefClass_sw.FromVar(AArgs[0]);
end;

function DB_DefaultLookupListClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultLookupListClass: TLookupListClass;

  if IsGet then
    Result := TLookupListClass_sw.ToVar(Data.DB.DefaultLookupListClass)
  else
    Data.DB.DefaultLookupListClass := TLookupListClass_sw.FromVar(AArgs[0]);
end;

function DB_DefaultIndexDefClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultIndexDefClass: TIndexDefClass;

  if IsGet then
    Result := TIndexDefClass_sw.ToVar(Data.DB.DefaultIndexDefClass)
  else
    Data.DB.DefaultIndexDefClass := TIndexDefClass_sw.FromVar(AArgs[0]);
end;

function DB_DefaultCheckConstraintClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultCheckConstraintClass: TCheckConstraintClass;

  if IsGet then
    Result := TCheckConstraintClass_sw.ToVar(Data.DB.
      DefaultCheckConstraintClass)
  else
    Data.DB.DefaultCheckConstraintClass := TCheckConstraintClass_sw.FromVar(
      AArgs[0]);
end;

function DB_DefaultParamClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultParamClass: TParamClass;

  if IsGet then
    Result := TParamClass_sw.ToVar(Data.DB.DefaultParamClass)
  else
    Data.DB.DefaultParamClass := TParamClass_sw.FromVar(AArgs[0]);
end;

function DB_DefaultParamsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultParamsClass: TParamsClass;

  if IsGet then
    Result := TParamsClass_sw.ToVar(Data.DB.DefaultParamsClass)
  else
    Data.DB.DefaultParamsClass := TParamsClass_sw.FromVar(AArgs[0]);
end;

function DB_DefaultFieldsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultFieldsClass: TFieldsClass;

  if IsGet then
    Result := TFieldsClass_sw.ToVar(Data.DB.DefaultFieldsClass)
  else
    Data.DB.DefaultFieldsClass := TFieldsClass_sw.FromVar(AArgs[0]);
end;

function DB_DefaultFieldListClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultFieldListClass: TFieldListClass;

  if IsGet then
    Result := TFieldListClass_sw.ToVar(Data.DB.DefaultFieldListClass)
  else
    Data.DB.DefaultFieldListClass := TFieldListClass_sw.FromVar(AArgs[0]);
end;

function DB_DefaultIndexDefsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultIndexDefsClass: TIndexDefsClass;

  if IsGet then
    Result := TIndexDefsClass_sw.ToVar(Data.DB.DefaultIndexDefsClass)
  else
    Data.DB.DefaultIndexDefsClass := TIndexDefsClass_sw.FromVar(AArgs[0]);
end;

function DB_DefaultFieldDefListClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultFieldDefListClass: TFieldDefListClass;

  if IsGet then
    Result := TFieldDefListClass_sw.ToVar(Data.DB.DefaultFieldDefListClass)
  else
    Data.DB.DefaultFieldDefListClass := TFieldDefListClass_sw.FromVar(AArgs[0]);
end;

function DB_DefaultCheckConstraintsClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultCheckConstraintsClass: TCheckConstraintsClass;

  if IsGet then
    Result := TCheckConstraintsClass_sw.ToVar(Data.DB.
      DefaultCheckConstraintsClass)
  else
    Data.DB.DefaultCheckConstraintsClass := TCheckConstraintsClass_sw.FromVar(
      AArgs[0]);
end;

class function DB_sw.GetUnitName: WideString;
begin
  Result := 'DB';
end;

class procedure DB_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(EDatabaseError_sw, DB_EDatabaseError_si);
  AData.AddType(EUpdateError_sw, DB_EUpdateError_si);
  AData.AddType(TFieldType_sw, DB_TFieldType_si);
  AData.AddType(TDataSetState_sw, DB_TDataSetState_si);
  AData.AddType(TDataEvent_sw, DB_TDataEvent_si);
  AData.AddType(TUpdateStatus_sw, DB_TUpdateStatus_si);
  AData.AddType(TUpdateStatusSet_sw, DB_TUpdateStatusSet_si);
  AData.AddType(TUpdateAction_sw, DB_TUpdateAction_si);
  AData.AddType(TUpdateMode_sw, DB_TUpdateMode_si);
  AData.AddType(TUpdateKind_sw, DB_TUpdateKind_si);
  AData.AddType(TUpdateErrorEvent_sw, DB_TUpdateErrorEvent_si);
  AData.AddType(TUpdateRecordEvent_sw, DB_TUpdateRecordEvent_si);
  AData.AddType(TConnectChangeEvent_sw, DB_TConnectChangeEvent_si);
  AData.AddType(TCustomConnection_sw, DB_TCustomConnection_si);
  AData.AddType(TNamedItem_sw, DB_TNamedItem_si);
  AData.AddType(TDefUpdateMethod_sw, DB_TDefUpdateMethod_si);
  AData.AddType(TDefCollection_sw, DB_TDefCollection_si);
  AData.AddType(TFieldClass_sw, DB_TFieldClass_si);
  AData.AddType(TFieldAttribute_sw, DB_TFieldAttribute_si);
  AData.AddType(TFieldAttributes_sw, DB_TFieldAttributes_si);
  AData.AddType(TFieldDefsClass_sw, DB_TFieldDefsClass_si);
  AData.AddType(TFieldDef_sw, DB_TFieldDef_si);
  AData.AddType(TFieldDefClass_sw, DB_TFieldDefClass_si);
  AData.AddType(TFieldDefs_sw, DB_TFieldDefs_si);
  AData.AddType(TIndexOption_sw, DB_TIndexOption_si);
  AData.AddType(TIndexOptions_sw, DB_TIndexOptions_si);
  AData.AddType(TIndexDef_sw, DB_TIndexDef_si);
  AData.AddType(TIndexDefClass_sw, DB_TIndexDefClass_si);
  AData.AddType(TIndexDefs_sw, DB_TIndexDefs_si);
  AData.AddType(TIndexDefsClass_sw, DB_TIndexDefsClass_si);
  AData.AddType(TFlatList_sw, DB_TFlatList_si);
  AData.AddType(TFieldDefList_sw, DB_TFieldDefList_si);
  AData.AddType(TFieldDefListClass_sw, DB_TFieldDefListClass_si);
  AData.AddType(TFieldList_sw, DB_TFieldList_si);
  AData.AddType(TFieldListClass_sw, DB_TFieldListClass_si);
  AData.AddType(TFieldsEnumerator_sw, DB_TFieldsEnumerator_si);
  AData.AddType(TFieldKind_sw, DB_TFieldKind_si);
  AData.AddType(TFieldKinds_sw, DB_TFieldKinds_si);
  AData.AddType(TFields_sw, DB_TFields_si);
  AData.AddType(TFieldsClass_sw, DB_TFieldsClass_si);
  AData.AddType(TProviderFlag_sw, DB_TProviderFlag_si);
  AData.AddType(TProviderFlags_sw, DB_TProviderFlags_si);
  AData.AddType(TFieldNotifyEvent_sw, DB_TFieldNotifyEvent_si);
  AData.AddType(TFieldGetTextEvent_sw, DB_TFieldGetTextEvent_si);
  AData.AddType(TFieldSetTextEvent_sw, DB_TFieldSetTextEvent_si);
  AData.AddType(TFieldChars_sw, DB_TFieldChars_si);
  AData.AddType(TAutoRefreshFlag_sw, DB_TAutoRefreshFlag_si);
  AData.AddType(TLookupList_sw, DB_TLookupList_si);
  AData.AddType(TLookupListClass_sw, DB_TLookupListClass_si);
  AData.AddType(TLookupListEntry_sw, DB_TLookupListEntry_si);
  AData.AddType(TDefaultLookupList_sw, DB_TDefaultLookupList_si);
  AData.AddType(Largeint_sw, DB_Largeint_si);
  AData.AddType(TField_sw, DB_TField_si);
  AData.AddType(TStringField_sw, DB_TStringField_si);
  AData.AddType(TWideStringField_sw, DB_TWideStringField_si);
  AData.AddType(TNumericField_sw, DB_TNumericField_si);
  AData.AddType(TIntegerField_sw, DB_TIntegerField_si);
  AData.AddType(TLongWordField_sw, DB_TLongWordField_si);
  AData.AddType(TSmallintField_sw, DB_TSmallintField_si);
  AData.AddType(TShortintField_sw, DB_TShortintField_si);
  AData.AddType(TByteField_sw, DB_TByteField_si);
  AData.AddType(TLargeintField_sw, DB_TLargeintField_si);
  AData.AddType(TWordField_sw, DB_TWordField_si);
  AData.AddType(TAutoIncField_sw, DB_TAutoIncField_si);
  AData.AddType(TUnsignedAutoIncField_sw, DB_TUnsignedAutoIncField_si);
  AData.AddType(TFloatField_sw, DB_TFloatField_si);
  AData.AddType(TSingleField_sw, DB_TSingleField_si);
  AData.AddType(TCurrencyField_sw, DB_TCurrencyField_si);
  AData.AddType(TExtendedField_sw, DB_TExtendedField_si);
  AData.AddType(TBooleanField_sw, DB_TBooleanField_si);
  AData.AddType(TDateTimeField_sw, DB_TDateTimeField_si);
  AData.AddType(TSQLTimeStampField_sw, DB_TSQLTimeStampField_si);
  AData.AddType(TSQLTimeStampOffsetField_sw, DB_TSQLTimeStampOffsetField_si);
  AData.AddType(TDateField_sw, DB_TDateField_si);
  AData.AddType(TTimeField_sw, DB_TTimeField_si);
  AData.AddType(TBinaryField_sw, DB_TBinaryField_si);
  AData.AddType(TBytesField_sw, DB_TBytesField_si);
  AData.AddType(TVarBytesField_sw, DB_TVarBytesField_si);
  AData.AddType(TBCDField_sw, DB_TBCDField_si);
  AData.AddType(TFMTBCDField_sw, DB_TFMTBCDField_si);
  AData.AddType(TBlobType_sw, DB_TBlobType_si);
  AData.AddType(TBlobField_sw, DB_TBlobField_si);
  AData.AddType(TMemoField_sw, DB_TMemoField_si);
  AData.AddType(TWideMemoField_sw, DB_TWideMemoField_si);
  AData.AddType(TGraphicField_sw, DB_TGraphicField_si);
  AData.AddType(TObjectField_sw, DB_TObjectField_si);
  AData.AddType(TADTField_sw, DB_TADTField_si);
  AData.AddType(TArrayField_sw, DB_TArrayField_si);
  AData.AddType(TDataSetField_sw, DB_TDataSetField_si);
  AData.AddType(TReferenceField_sw, DB_TReferenceField_si);
  AData.AddType(TVariantField_sw, DB_TVariantField_si);
  AData.AddType(TInterfaceField_sw, DB_TInterfaceField_si);
  AData.AddType(TIDispatchField_sw, DB_TIDispatchField_si);
  AData.AddType(TGuidField_sw, DB_TGuidField_si);
  AData.AddType(TAggHandle_sw, DB_TAggHandle_si);
  AData.AddType(TAggregateField_sw, DB_TAggregateField_si);
  AData.AddType(TDataLink_sw, DB_TDataLink_si);
  AData.AddType(TDetailDataLink_sw, DB_TDetailDataLink_si);
  AData.AddType(TMasterDataLink_sw, DB_TMasterDataLink_si);
  AData.AddType(TDataChangeEvent_sw, DB_TDataChangeEvent_si);
  AData.AddType(TDataSource_sw, DB_TDataSource_si);
  AData.AddType(TDataSetDesigner_sw, DB_TDataSetDesigner_si);
  AData.AddType(TCheckConstraint_sw, DB_TCheckConstraint_si);
  AData.AddType(TCheckConstraintClass_sw, DB_TCheckConstraintClass_si);
  AData.AddType(TCheckConstraints_sw, DB_TCheckConstraints_si);
  AData.AddType(TCheckConstraintsClass_sw, DB_TCheckConstraintsClass_si);
  AData.AddType(TBitConverter_sw, DB_TBitConverter_si);
  AData.AddType(TParamType_sw, DB_TParamType_si);
  AData.AddType(TParamTypes_sw, DB_TParamTypes_si);
  AData.AddType(TParamObjectClass_sw, DB_TParamObjectClass_si);
  AData.AddType(TParam_sw, DB_TParam_si);
  AData.AddType(TParamClass_sw, DB_TParamClass_si);
  AData.AddType(TParams_sw, DB_TParams_si);
  AData.AddType(TParamsClass_sw, DB_TParamsClass_si);
  AData.AddType(TParamObject_sw, DB_TParamObject_si);
  AData.AddType(TParamStreamObject_sw, DB_TParamStreamObject_si);
  AData.AddType(TPSCommandType_sw, DB_TPSCommandType_si);
  AData.AddType(TSQLCommandType_sw, DB_TSQLCommandType_si);
  AData.AddType(TPacketAttribute_sw, DB_TPacketAttribute_si);
  AData.AddType(TPacketAttributeList_sw, DB_TPacketAttributeList_si);
  AData.AddType(TBookmarkStr_sw, DB_TBookmarkStr_si);
  AData.AddType(TBookmarkFlag_sw, DB_TBookmarkFlag_si);
  AData.AddType(TRecBuf_sw, DB_TRecBuf_si);
  AData.AddType(TGetMode_sw, DB_TGetMode_si);
  AData.AddType(TGetResult_sw, DB_TGetResult_si);
  AData.AddType(TDataAction_sw, DB_TDataAction_si);
  AData.AddType(TBlobStreamMode_sw, DB_TBlobStreamMode_si);
  AData.AddType(TLocateOption_sw, DB_TLocateOption_si);
  AData.AddType(TLocateOptions_sw, DB_TLocateOptions_si);
  AData.AddType(TDataOperation_sw, DB_TDataOperation_si);
  AData.AddType(TDataSetNotifyEvent_sw, DB_TDataSetNotifyEvent_si);
  AData.AddType(TDataSetErrorEvent_sw, DB_TDataSetErrorEvent_si);
  AData.AddType(TFilterOption_sw, DB_TFilterOption_si);
  AData.AddType(TFilterOptions_sw, DB_TFilterOptions_si);
  AData.AddType(TFilterRecordEvent_sw, DB_TFilterRecordEvent_si);
  AData.AddType(TGroupPosInd_sw, DB_TGroupPosInd_si);
  AData.AddType(TGroupPosInds_sw, DB_TGroupPosInds_si);
  AData.AddType(TDataSetClass_sw, DB_TDataSetClass_si);
  AData.AddType(TDataSet_sw, DB_TDataSet_si);
  AData.AddType(TDateTimeAlias_sw, DB_TDateTimeAlias_si);
  AData.AddType(TDateTimeRec_sw, DB_TDateTimeRec_si);
  AData.AddConstant('ftNonTextTypes', DB_ftNonTextTypes_si, nil, varInteger);
  AData.AddConstant('ftFixedSizeTypes', DB_ftFixedSizeTypes_si, nil, varInteger);
  AData.AddConstant('dsEditModes', DB_dsEditModes_si, nil, varInteger);
  AData.AddConstant('dsWriteModes', DB_dsWriteModes_si, nil, varInteger);
  AData.AddConstant('sApplyUpdatesDataSetCommand', DB_sApplyUpdatesDataSetCommand_si, nil, VarType(Data.DB.sApplyUpdatesDataSetCommand));
  AData.AddConstant('sCancelUpdatesDataSetCommand', DB_sCancelUpdatesDataSetCommand_si, nil, VarType(Data.DB.sCancelUpdatesDataSetCommand));
  AData.AddConstant('ObjectFieldTypes', DB_ObjectFieldTypes_si, nil, varInteger);
  AData.AddConstant('dsMaxStringSize', DB_dsMaxStringSize_si, nil, VarType(Data.DB.dsMaxStringSize));
  AData.AddType(TDBScreenCursor_sw, DB_TDBScreenCursor_si);
  AData.AddFunction('ExtractFieldName', DB_ExtractFieldName_si, nil, 2, False);
  AData.AddProcedure('DatabaseError', DB_DatabaseError_si, 1, True);
  AData.AddFunction('GetFieldProperty', DB_GetFieldProperty_si, TField_sw, 3, False);
  AData.AddFunction('VarTypeToDataType', DB_VarTypeToDataType_si, TFieldType_sw, 1, False);
  AData.AddVariable('DefaultFieldDefsClass', DB_DefaultFieldDefsClass_si, TFieldDefsClass_sw);
  AData.AddVariable('DefaultFieldDefClass', DB_DefaultFieldDefClass_si, TFieldDefClass_sw);
  AData.AddVariable('DefaultLookupListClass', DB_DefaultLookupListClass_si, TLookupListClass_sw);
  AData.AddVariable('DefaultIndexDefClass', DB_DefaultIndexDefClass_si, TIndexDefClass_sw);
  AData.AddVariable('DefaultCheckConstraintClass', DB_DefaultCheckConstraintClass_si, TCheckConstraintClass_sw);
  AData.AddVariable('DefaultParamClass', DB_DefaultParamClass_si, TParamClass_sw);
  AData.AddVariable('DefaultParamsClass', DB_DefaultParamsClass_si, TParamsClass_sw);
  AData.AddVariable('DefaultFieldsClass', DB_DefaultFieldsClass_si, TFieldsClass_sw);
  AData.AddVariable('DefaultFieldListClass', DB_DefaultFieldListClass_si, TFieldListClass_sw);
  AData.AddVariable('DefaultIndexDefsClass', DB_DefaultIndexDefsClass_si, TIndexDefsClass_sw);
  AData.AddVariable('DefaultFieldDefListClass', DB_DefaultFieldDefListClass_si, TFieldDefListClass_sw);
  AData.AddVariable('DefaultCheckConstraintsClass', DB_DefaultCheckConstraintsClass_si, TCheckConstraintsClass_sw);
end;

class function DB_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(DB_sw);
end;

initialization
  RegisterUnitWrapper(DB_sw);
  RegisterClassWrapper(EDatabaseError_sw);
  RegisterClassWrapper(EUpdateError_sw);
  RegisterClassWrapper(TCustomConnection_sw);
  RegisterClassWrapper(TNamedItem_sw);
  RegisterClassWrapper(TDefCollection_sw);
  RegisterClassWrapper(TFieldDef_sw);
  RegisterClassWrapper(TFieldDefs_sw);
  RegisterClassWrapper(TIndexDef_sw);
  RegisterClassWrapper(TIndexDefs_sw);
  RegisterClassWrapper(TFlatList_sw);
  RegisterClassWrapper(TFieldDefList_sw);
  RegisterClassWrapper(TFieldList_sw);
  RegisterClassWrapper(TFieldsEnumerator_sw);
  RegisterClassWrapper(TFields_sw);
  RegisterClassWrapper(TLookupList_sw);
  RegisterClassWrapper(TDefaultLookupList_sw);
  RegisterClassWrapper(TField_sw);
  RegisterClassWrapper(TStringField_sw);
  RegisterClassWrapper(TWideStringField_sw);
  RegisterClassWrapper(TNumericField_sw);
  RegisterClassWrapper(TIntegerField_sw);
  RegisterClassWrapper(TLongWordField_sw);
  RegisterClassWrapper(TSmallintField_sw);
  RegisterClassWrapper(TShortintField_sw);
  RegisterClassWrapper(TByteField_sw);
  RegisterClassWrapper(TLargeintField_sw);
  RegisterClassWrapper(TWordField_sw);
  RegisterClassWrapper(TAutoIncField_sw);
  RegisterClassWrapper(TUnsignedAutoIncField_sw);
  RegisterClassWrapper(TFloatField_sw);
  RegisterClassWrapper(TSingleField_sw);
  RegisterClassWrapper(TCurrencyField_sw);
  RegisterClassWrapper(TExtendedField_sw);
  RegisterClassWrapper(TBooleanField_sw);
  RegisterClassWrapper(TDateTimeField_sw);
  RegisterClassWrapper(TSQLTimeStampField_sw);
  RegisterClassWrapper(TSQLTimeStampOffsetField_sw);
  RegisterClassWrapper(TDateField_sw);
  RegisterClassWrapper(TTimeField_sw);
  RegisterClassWrapper(TBinaryField_sw);
  RegisterClassWrapper(TBytesField_sw);
  RegisterClassWrapper(TVarBytesField_sw);
  RegisterClassWrapper(TBCDField_sw);
  RegisterClassWrapper(TFMTBCDField_sw);
  RegisterClassWrapper(TBlobField_sw);
  RegisterClassWrapper(TMemoField_sw);
  RegisterClassWrapper(TWideMemoField_sw);
  RegisterClassWrapper(TGraphicField_sw);
  RegisterClassWrapper(TObjectField_sw);
  RegisterClassWrapper(TADTField_sw);
  RegisterClassWrapper(TArrayField_sw);
  RegisterClassWrapper(TDataSetField_sw);
  RegisterClassWrapper(TReferenceField_sw);
  RegisterClassWrapper(TVariantField_sw);
  RegisterClassWrapper(TInterfaceField_sw);
  RegisterClassWrapper(TIDispatchField_sw);
  RegisterClassWrapper(TGuidField_sw);
  RegisterClassWrapper(TAggregateField_sw);
  RegisterClassWrapper(TDataLink_sw);
  RegisterClassWrapper(TDetailDataLink_sw);
  RegisterClassWrapper(TMasterDataLink_sw);
  RegisterClassWrapper(TDataSource_sw);
  RegisterClassWrapper(TDataSetDesigner_sw);
  RegisterClassWrapper(TCheckConstraint_sw);
  RegisterClassWrapper(TCheckConstraints_sw);
  RegisterClassWrapper(TBitConverter_sw);
  RegisterClassWrapper(TParam_sw);
  RegisterClassWrapper(TParams_sw);
  RegisterClassWrapper(TParamObject_sw);
  RegisterClassWrapper(TParamStreamObject_sw);
  RegisterClassWrapper(TDataSet_sw);
  RegisterEventWrapper(TypeInfo(TUpdateErrorEvent), TUpdateErrorEvent_sw);
  RegisterEventWrapper(TypeInfo(TUpdateRecordEvent), TUpdateRecordEvent_sw);
  RegisterEventWrapper(TypeInfo(TConnectChangeEvent), TConnectChangeEvent_sw);
  RegisterEventWrapper(TypeInfo(TDefUpdateMethod), TDefUpdateMethod_sw);
  RegisterEventWrapper(TypeInfo(TFieldNotifyEvent), TFieldNotifyEvent_sw);
  RegisterEventWrapper(TypeInfo(TFieldGetTextEvent), TFieldGetTextEvent_sw);
  RegisterEventWrapper(TypeInfo(TFieldSetTextEvent), TFieldSetTextEvent_sw);
  RegisterEventWrapper(TypeInfo(TDataChangeEvent), TDataChangeEvent_sw);
  RegisterEventWrapper(TypeInfo(TDataOperation), TDataOperation_sw);
  RegisterEventWrapper(TypeInfo(TDataSetNotifyEvent), TDataSetNotifyEvent_sw);
  RegisterEventWrapper(TypeInfo(TDataSetErrorEvent), TDataSetErrorEvent_sw);
  RegisterEventWrapper(TypeInfo(TFilterRecordEvent), TFilterRecordEvent_sw);

end.
