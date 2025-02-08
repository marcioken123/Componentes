unit Classes_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Classes' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Classes, LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers, Types,
  Windows, Messages, SysUtils, Variants, TypInfo, Windows_LMDSW,
  Messages_LMDSW, SysUtils_LMDSW, Variants_LMDSW, TypInfo_LMDSW;


{ Type wrappers }

type
  EStreamError_sw = class;
  EFileStreamError_sw = class;
  EFCreateError_sw = class;
  EFOpenError_sw = class;
  EFilerError_sw = class;
  EReadError_sw = class;
  EWriteError_sw = class;
  EClassNotFound_sw = class;
  EMethodNotFound_sw = class;
  EInvalidImage_sw = class;
  EResNotFound_sw = class;
  EListError_sw = class;
  EBitsError_sw = class;
  EStringListError_sw = class;
  EComponentError_sw = class;
  EParserError_sw = class;
  EOutOfResources_sw = class;
  EInvalidOperation_sw = class;
  TListEnumerator_sw = class;
  TList_sw = class;
  TThreadList_sw = class;
  TInterfaceListEnumerator_sw = class;
  TInterfaceList_sw = class;
  TBits_sw = class;
  TPersistent_sw = class;
  TPersistentClass_sw = class;
  TInterfacedPersistent_sw = class;
  TRecall_sw = class;
  TCollectionItem_sw = class;
  TCollectionItemClass_sw = class;
  TCollectionEnumerator_sw = class;
  TCollection_sw = class;
  TOwnedCollection_sw = class;
  TStringsEnumerator_sw = class;
  TStrings_sw = class;
  TStringList_sw = class;
  TStream_sw = class;
  THandleStream_sw = class;
  TFileStream_sw = class;
  TCustomMemoryStream_sw = class;
  TMemoryStream_sw = class;
  TStringStream_sw = class;
  TResourceStream_sw = class;
  TStreamAdapter_sw = class;
  TClassFinder_sw = class;
  TFiler_sw = class;
  TComponentClass_sw = class;
  TReader_sw = class;
  TWriter_sw = class;
  TParser_sw = class;
  EThread_sw = class;
  TThread_sw = class;
  TComponentEnumerator_sw = class;
  TComponent_sw = class;
  TBasicActionLink_sw = class;
  TBasicActionLinkClass_sw = class;
  TBasicAction_sw = class;
  TBasicActionClass_sw = class;
  TDataModule_sw = class;

  TSeekOrigin_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TSeekOrigin): OleVariant;
    class function FromVar(const AValue: OleVariant): TSeekOrigin;
  end;

  TAlignment_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TAlignment): OleVariant;
    class function FromVar(const AValue: OleVariant): TAlignment;
  end;

  TLeftRight_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLeftRight): OleVariant;
    class function FromVar(const AValue: OleVariant): TLeftRight;
  end;

  TBiDiMode_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TBiDiMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TBiDiMode;
  end;

  TVerticalAlignment_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TVerticalAlignment): OleVariant;
    class function FromVar(const AValue: OleVariant): TVerticalAlignment;
  end;

  TTopBottom_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTopBottom): OleVariant;
    class function FromVar(const AValue: OleVariant): TTopBottom;
  end;

  THelpContext_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: THelpContext): OleVariant;
    class function FromVar(const AValue: OleVariant): THelpContext;
  end;

  THelpType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: THelpType): OleVariant;
    class function FromVar(const AValue: OleVariant): THelpType;
  end;

  TShortCut_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TShortCut): OleVariant;
    class function FromVar(const AValue: OleVariant): TShortCut;
  end;

  TNotifyEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject);
  end;

  TNotifyEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TNotifyEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TNotifyEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TNotifyEvent;
  end;

  TGetStrProc_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(const S: string);
  end;

  TGetStrProc_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetStrProc): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetStrProc;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetStrProc;
  end;

  EStreamError_sc = class of EStreamError;
  EStreamError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EStreamError): OleVariant;
    class function FromVar(const AValue: OleVariant): EStreamError;
    class function ClassToVar(AClass: EStreamError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EStreamError_sc;
  end;

  EFileStreamError_sc = class of EFileStreamError;
  EFileStreamError_sw = class(EStreamError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EFileStreamError): OleVariant;
    class function FromVar(const AValue: OleVariant): EFileStreamError;
    class function ClassToVar(AClass: EFileStreamError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EFileStreamError_sc;
  end;

  EFCreateError_sc = class of EFCreateError;
  EFCreateError_sw = class(EFileStreamError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EFCreateError): OleVariant;
    class function FromVar(const AValue: OleVariant): EFCreateError;
    class function ClassToVar(AClass: EFCreateError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EFCreateError_sc;
  end;

  EFOpenError_sc = class of EFOpenError;
  EFOpenError_sw = class(EFileStreamError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EFOpenError): OleVariant;
    class function FromVar(const AValue: OleVariant): EFOpenError;
    class function ClassToVar(AClass: EFOpenError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EFOpenError_sc;
  end;

  EFilerError_sc = class of EFilerError;
  EFilerError_sw = class(EStreamError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EFilerError): OleVariant;
    class function FromVar(const AValue: OleVariant): EFilerError;
    class function ClassToVar(AClass: EFilerError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EFilerError_sc;
  end;

  EReadError_sc = class of EReadError;
  EReadError_sw = class(EFilerError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EReadError): OleVariant;
    class function FromVar(const AValue: OleVariant): EReadError;
    class function ClassToVar(AClass: EReadError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EReadError_sc;
  end;

  EWriteError_sc = class of EWriteError;
  EWriteError_sw = class(EFilerError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EWriteError): OleVariant;
    class function FromVar(const AValue: OleVariant): EWriteError;
    class function ClassToVar(AClass: EWriteError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EWriteError_sc;
  end;

  EClassNotFound_sc = class of EClassNotFound;
  EClassNotFound_sw = class(EFilerError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EClassNotFound): OleVariant;
    class function FromVar(const AValue: OleVariant): EClassNotFound;
    class function ClassToVar(AClass: EClassNotFound_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EClassNotFound_sc;
  end;

  EMethodNotFound_sc = class of EMethodNotFound;
  EMethodNotFound_sw = class(EFilerError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EMethodNotFound): OleVariant;
    class function FromVar(const AValue: OleVariant): EMethodNotFound;
    class function ClassToVar(AClass: EMethodNotFound_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EMethodNotFound_sc;
  end;

  EInvalidImage_sc = class of EInvalidImage;
  EInvalidImage_sw = class(EFilerError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EInvalidImage): OleVariant;
    class function FromVar(const AValue: OleVariant): EInvalidImage;
    class function ClassToVar(AClass: EInvalidImage_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EInvalidImage_sc;
  end;

  EResNotFound_sc = class of EResNotFound;
  EResNotFound_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EResNotFound): OleVariant;
    class function FromVar(const AValue: OleVariant): EResNotFound;
    class function ClassToVar(AClass: EResNotFound_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EResNotFound_sc;
  end;

  EListError_sc = class of EListError;
  EListError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EListError): OleVariant;
    class function FromVar(const AValue: OleVariant): EListError;
    class function ClassToVar(AClass: EListError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EListError_sc;
  end;

  EBitsError_sc = class of EBitsError;
  EBitsError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EBitsError): OleVariant;
    class function FromVar(const AValue: OleVariant): EBitsError;
    class function ClassToVar(AClass: EBitsError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EBitsError_sc;
  end;

  EStringListError_sc = class of EStringListError;
  EStringListError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EStringListError): OleVariant;
    class function FromVar(const AValue: OleVariant): EStringListError;
    class function ClassToVar(AClass: EStringListError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EStringListError_sc;
  end;

  EComponentError_sc = class of EComponentError;
  EComponentError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EComponentError): OleVariant;
    class function FromVar(const AValue: OleVariant): EComponentError;
    class function ClassToVar(AClass: EComponentError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EComponentError_sc;
  end;

  EParserError_sc = class of EParserError;
  EParserError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EParserError): OleVariant;
    class function FromVar(const AValue: OleVariant): EParserError;
    class function ClassToVar(AClass: EParserError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EParserError_sc;
  end;

  EOutOfResources_sc = class of EOutOfResources;
  EOutOfResources_sw = class(EOutOfMemory_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EOutOfResources): OleVariant;
    class function FromVar(const AValue: OleVariant): EOutOfResources;
    class function ClassToVar(AClass: EOutOfResources_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EOutOfResources_sc;
  end;

  EInvalidOperation_sc = class of EInvalidOperation;
  EInvalidOperation_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EInvalidOperation): OleVariant;
    class function FromVar(const AValue: OleVariant): EInvalidOperation;
    class function ClassToVar(AClass: EInvalidOperation_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EInvalidOperation_sc;
  end;

  TDuplicates_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TDuplicates): OleVariant;
    class function FromVar(const AValue: OleVariant): TDuplicates;
  end;

  TListNotification_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TListNotification): OleVariant;
    class function FromVar(const AValue: OleVariant): TListNotification;
  end;

  TListAssignOp_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TListAssignOp): OleVariant;
    class function FromVar(const AValue: OleVariant): TListAssignOp;
  end;

  TListEnumerator_sc = class of TListEnumerator;
  TListEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TListEnumerator;
    class function ClassToVar(AClass: TListEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListEnumerator_sc;
  end;

  TList_sc = class of TList;
  TList_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TList): OleVariant;
    class function FromVar(const AValue: OleVariant): TList;
    class function ClassToVar(AClass: TList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TList_sc;
  end;

  TThreadList_sc = class of TThreadList;
  TThreadList_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TThreadList): OleVariant;
    class function FromVar(const AValue: OleVariant): TThreadList;
    class function ClassToVar(AClass: TThreadList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TThreadList_sc;
  end;

  TInterfaceListEnumerator_sc = class of TInterfaceListEnumerator;
  TInterfaceListEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TInterfaceListEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TInterfaceListEnumerator;
    class function ClassToVar(AClass: TInterfaceListEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TInterfaceListEnumerator_sc;
  end;

  TInterfaceList_sc = class of TInterfaceList;
  TInterfaceList_sw = class(TInterfacedObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TInterfaceList): OleVariant;
    class function FromVar(const AValue: OleVariant): TInterfaceList;
    class function ClassToVar(AClass: TInterfaceList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TInterfaceList_sc;
  end;

  TBits_sc = class of TBits;
  TBits_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBits): OleVariant;
    class function FromVar(const AValue: OleVariant): TBits;
    class function ClassToVar(AClass: TBits_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBits_sc;
  end;

  TPersistent_sc = class of TPersistent;
  TPersistent_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPersistent): OleVariant;
    class function FromVar(const AValue: OleVariant): TPersistent;
    class function ClassToVar(AClass: TPersistent_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPersistent_sc;
  end;

  TPersistentClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TPersistentClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TPersistentClass;
  end;

  TInterfacedPersistent_sc = class of TInterfacedPersistent;
  TInterfacedPersistent_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TInterfacedPersistent): OleVariant;
    class function FromVar(const AValue: OleVariant): TInterfacedPersistent;
    class function ClassToVar(AClass: TInterfacedPersistent_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TInterfacedPersistent_sc;
  end;

  TRecall_sc = class of TRecall;
  TRecall_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TRecall): OleVariant;
    class function FromVar(const AValue: OleVariant): TRecall;
    class function ClassToVar(AClass: TRecall_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TRecall_sc;
  end;

  TCollectionItem_sc = class of TCollectionItem;
  TCollectionItem_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCollectionItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TCollectionItem;
    class function ClassToVar(AClass: TCollectionItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCollectionItem_sc;
  end;

  TCollectionItemClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCollectionItemClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCollectionItemClass;
  end;

  TCollectionNotification_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TCollectionNotification): OleVariant;
    class function FromVar(const AValue: OleVariant): TCollectionNotification;
  end;

  TCollectionEnumerator_sc = class of TCollectionEnumerator;
  TCollectionEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCollectionEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TCollectionEnumerator;
    class function ClassToVar(AClass: TCollectionEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCollectionEnumerator_sc;
  end;

  TCollection_sc = class of TCollection;
  TCollection_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCollection): OleVariant;
    class function FromVar(const AValue: OleVariant): TCollection;
    class function ClassToVar(AClass: TCollection_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCollection_sc;
  end;

  TOwnedCollection_sc = class of TOwnedCollection;
  TOwnedCollection_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TOwnedCollection): OleVariant;
    class function FromVar(const AValue: OleVariant): TOwnedCollection;
    class function ClassToVar(AClass: TOwnedCollection_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TOwnedCollection_sc;
  end;

  TGetModuleProc_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(const FileName: string; const UnitName: string;
      const FormName: string; const DesignClass: string; CoClasses: TStrings);
  end;

  TGetModuleProc_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetModuleProc): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetModuleProc;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetModuleProc;
  end;

  TStringsEnumerator_sc = class of TStringsEnumerator;
  TStringsEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStringsEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TStringsEnumerator;
    class function ClassToVar(AClass: TStringsEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStringsEnumerator_sc;
  end;

  TStrings_sc = class of TStrings;
  TStrings_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStrings): OleVariant;
    class function FromVar(const AValue: OleVariant): TStrings;
    class function ClassToVar(AClass: TStrings_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStrings_sc;
  end;

  TStringItem_sw = class(TLMDRecordWrapper)
  private
    FValue: TStringItem;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TStringItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TStringItem;
  end;

  TStringList_sc = class of TStringList;
  TStringList_sw = class(TStrings_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStringList): OleVariant;
    class function FromVar(const AValue: OleVariant): TStringList;
    class function ClassToVar(AClass: TStringList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStringList_sc;
  end;

  TStream_sc = class of TStream;
  TStream_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStream): OleVariant;
    class function FromVar(const AValue: OleVariant): TStream;
    class function ClassToVar(AClass: TStream_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStream_sc;
  end;

  THandleStream_sc = class of THandleStream;
  THandleStream_sw = class(TStream_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THandleStream): OleVariant;
    class function FromVar(const AValue: OleVariant): THandleStream;
    class function ClassToVar(AClass: THandleStream_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THandleStream_sc;
  end;

  TFileStream_sc = class of TFileStream;
  TFileStream_sw = class(THandleStream_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFileStream): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileStream;
    class function ClassToVar(AClass: TFileStream_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFileStream_sc;
  end;

  TCustomMemoryStream_sc = class of TCustomMemoryStream;
  TCustomMemoryStream_sw = class(TStream_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomMemoryStream): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomMemoryStream;
    class function ClassToVar(AClass: TCustomMemoryStream_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomMemoryStream_sc;
  end;

  TMemoryStream_sc = class of TMemoryStream;
  TMemoryStream_sw = class(TCustomMemoryStream_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMemoryStream): OleVariant;
    class function FromVar(const AValue: OleVariant): TMemoryStream;
    class function ClassToVar(AClass: TMemoryStream_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMemoryStream_sc;
  end;

  TStringStream_sc = class of TStringStream;
  TStringStream_sw = class(TStream_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStringStream): OleVariant;
    class function FromVar(const AValue: OleVariant): TStringStream;
    class function ClassToVar(AClass: TStringStream_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStringStream_sc;
  end;

  TResourceStream_sc = class of TResourceStream;
  TResourceStream_sw = class(TCustomMemoryStream_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TResourceStream): OleVariant;
    class function FromVar(const AValue: OleVariant): TResourceStream;
    class function ClassToVar(AClass: TResourceStream_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TResourceStream_sc;
  end;

  TStreamOwnership_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TStreamOwnership): OleVariant;
    class function FromVar(const AValue: OleVariant): TStreamOwnership;
  end;

  TStreamAdapter_sc = class of TStreamAdapter;
  TStreamAdapter_sw = class(TInterfacedObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStreamAdapter): OleVariant;
    class function FromVar(const AValue: OleVariant): TStreamAdapter;
    class function ClassToVar(AClass: TStreamAdapter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStreamAdapter_sc;
  end;

  TGetClass_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(AClass: TPersistentClass);
  end;

  TGetClass_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetClass;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetClass;
  end;

  TClassFinder_sc = class of TClassFinder;
  TClassFinder_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TClassFinder): OleVariant;
    class function FromVar(const AValue: OleVariant): TClassFinder;
    class function ClassToVar(AClass: TClassFinder_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TClassFinder_sc;
  end;

  TValueType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TValueType): OleVariant;
    class function FromVar(const AValue: OleVariant): TValueType;
  end;

  TFilerFlag_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TFilerFlag): OleVariant;
    class function FromVar(const AValue: OleVariant): TFilerFlag;
  end;

  TFilerFlags_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFilerFlags): OleVariant;
    class function FromVar(const AValue: OleVariant): TFilerFlags;
  end;

  TReaderProc_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Reader: TReader);
  end;

  TReaderProc_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TReaderProc): OleVariant;
    class function FromVar(const AValue: OleVariant): TReaderProc;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TReaderProc;
  end;

  TWriterProc_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Writer: TWriter);
  end;

  TWriterProc_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TWriterProc): OleVariant;
    class function FromVar(const AValue: OleVariant): TWriterProc;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TWriterProc;
  end;

  TStreamProc_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Stream: TStream);
  end;

  TStreamProc_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TStreamProc): OleVariant;
    class function FromVar(const AValue: OleVariant): TStreamProc;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TStreamProc;
  end;

  TFiler_sc = class of TFiler;
  TFiler_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFiler): OleVariant;
    class function FromVar(const AValue: OleVariant): TFiler;
    class function ClassToVar(AClass: TFiler_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFiler_sc;
  end;

  TComponentClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TComponentClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TComponentClass;
  end;

  TSetNameEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Reader: TReader; Component: TComponent; var Name: string);
  end;

  TSetNameEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TSetNameEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TSetNameEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TSetNameEvent;
  end;

  TReferenceNameEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Reader: TReader; var Name: string);
  end;

  TReferenceNameEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TReferenceNameEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TReferenceNameEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TReferenceNameEvent;
  end;

  TAncestorNotFoundEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Reader: TReader; const ComponentName: string;
      ComponentClass: TPersistentClass; var Component: TComponent);
  end;

  TAncestorNotFoundEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TAncestorNotFoundEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TAncestorNotFoundEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TAncestorNotFoundEvent;
  end;

  TReadComponentsProc_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Component: TComponent);
  end;

  TReadComponentsProc_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TReadComponentsProc): OleVariant;
    class function FromVar(const AValue: OleVariant): TReadComponentsProc;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TReadComponentsProc;
  end;

  TReaderError_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Reader: TReader; const Message: string;
      var Handled: Boolean);
  end;

  TReaderError_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TReaderError): OleVariant;
    class function FromVar(const AValue: OleVariant): TReaderError;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TReaderError;
  end;

  TFindComponentClassEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Reader: TReader; const ClassName: string;
      var ComponentClass: TComponentClass);
  end;

  TFindComponentClassEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFindComponentClassEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFindComponentClassEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFindComponentClassEvent;
  end;

  TCreateComponentEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Reader: TReader; ComponentClass: TComponentClass;
      var Component: TComponent);
  end;

  TCreateComponentEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TCreateComponentEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TCreateComponentEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TCreateComponentEvent;
  end;

  TReader_sc = class of TReader;
  TReader_sw = class(TFiler_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TReader): OleVariant;
    class function FromVar(const AValue: OleVariant): TReader;
    class function ClassToVar(AClass: TReader_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TReader_sc;
  end;

  TFindAncestorEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Writer: TWriter; Component: TComponent;
      const Name: string; var Ancestor: TComponent;
      var RootAncestor: TComponent);
  end;

  TFindAncestorEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFindAncestorEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFindAncestorEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFindAncestorEvent;
  end;

  TGetLookupInfoEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(var Ancestor: TPersistent; var Root: TComponent;
      var LookupRoot: TComponent; var RootAncestor: TComponent);
  end;

  TGetLookupInfoEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetLookupInfoEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetLookupInfoEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetLookupInfoEvent;
  end;

  TWriter_sc = class of TWriter;
  TWriter_sw = class(TFiler_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWriter): OleVariant;
    class function FromVar(const AValue: OleVariant): TWriter;
    class function ClassToVar(AClass: TWriter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWriter_sc;
  end;

  TParserErrorEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; const Message: string;
      var Handled: Boolean);
  end;

  TParserErrorEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TParserErrorEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TParserErrorEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TParserErrorEvent;
  end;

  TParser_sc = class of TParser;
  TParser_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TParser): OleVariant;
    class function FromVar(const AValue: OleVariant): TParser;
    class function ClassToVar(AClass: TParser_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TParser_sc;
  end;

  EThread_sc = class of EThread;
  EThread_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EThread): OleVariant;
    class function FromVar(const AValue: OleVariant): EThread;
    class function ClassToVar(AClass: EThread_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EThread_sc;
  end;

  TThreadMethod_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler;
  end;

  TThreadMethod_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TThreadMethod): OleVariant;
    class function FromVar(const AValue: OleVariant): TThreadMethod;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TThreadMethod;
  end;

  TThreadPriority_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TThreadPriority): OleVariant;
    class function FromVar(const AValue: OleVariant): TThreadPriority;
  end;

  TSynchronizeRecord_sw = class(TLMDRecordWrapper)
  private
    FValue: TSynchronizeRecord;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TSynchronizeRecord): OleVariant;
    class function FromVar(const AValue: OleVariant): TSynchronizeRecord;
  end;

  TThread_sc = class of TThread;
  TThread_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TThread): OleVariant;
    class function FromVar(const AValue: OleVariant): TThread;
    class function ClassToVar(AClass: TThread_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TThread_sc;
  end;

  TComponentEnumerator_sc = class of TComponentEnumerator;
  TComponentEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TComponentEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TComponentEnumerator;
    class function ClassToVar(AClass: TComponentEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TComponentEnumerator_sc;
  end;

  TOperation_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TOperation): OleVariant;
    class function FromVar(const AValue: OleVariant): TOperation;
  end;

  TGetChildProc_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Child: TComponent);
  end;

  TGetChildProc_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetChildProc): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetChildProc;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetChildProc;
  end;

  TComponentName_sw = string_sw;

  TComponent_sc = class of TComponent;
  TComponent_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TComponent): OleVariant;
    class function FromVar(const AValue: OleVariant): TComponent;
    class function ClassToVar(AClass: TComponent_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TComponent_sc;
  end;

  TBasicActionLink_sc = class of TBasicActionLink;
  TBasicActionLink_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBasicActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TBasicActionLink;
    class function ClassToVar(AClass: TBasicActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBasicActionLink_sc;
  end;

  TBasicActionLinkClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TBasicActionLinkClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TBasicActionLinkClass;
  end;

  TBasicAction_sc = class of TBasicAction;
  TBasicAction_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBasicAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TBasicAction;
    class function ClassToVar(AClass: TBasicAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBasicAction_sc;
  end;

  TBasicActionClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TBasicActionClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TBasicActionClass;
  end;

  TDataModule_sc = class of TDataModule;
  TDataModule_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDataModule): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataModule;
    class function ClassToVar(AClass: TDataModule_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDataModule_sc;
  end;

  TActiveXRegType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TActiveXRegType): OleVariant;
    class function FromVar(const AValue: OleVariant): TActiveXRegType;
  end;

  TIdentMapEntry_sw = class(TLMDRecordWrapper)
  private
    FValue: TIdentMapEntry;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TIdentMapEntry): OleVariant;
    class function FromVar(const AValue: OleVariant): TIdentMapEntry;
  end;

  TStreamOriginalFormat_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TStreamOriginalFormat): OleVariant;
    class function FromVar(const AValue: OleVariant): TStreamOriginalFormat;
  end;


{ Unit wrapper }

type
  Classes_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCollection_sacc = class(TCollection);
  TStrings_sacc = class(TStrings);
  TMemoryStream_sacc = class(TMemoryStream);
  TReader_sacc = class(TReader);
  TThread_sacc = class(TThread);
  TBasicAction_sacc = class(TBasicAction);

{ TSeekOrigin_sw }

class function TSeekOrigin_sw.GetTypeName: WideString;
begin
  Result := 'TSeekOrigin';
end;

class function TSeekOrigin_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TSeekOrigin);
end;

class function TSeekOrigin_sw.ToVar(const AValue: TSeekOrigin): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TSeekOrigin_sw.FromVar(const AValue: OleVariant): TSeekOrigin;
begin
  Result := TSeekOrigin(Integer(AValue));
end;

{ TAlignment_sw }

class function TAlignment_sw.GetTypeName: WideString;
begin
  Result := 'TAlignment';
end;

class function TAlignment_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TAlignment);
end;

class function TAlignment_sw.ToVar(const AValue: TAlignment): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TAlignment_sw.FromVar(const AValue: OleVariant): TAlignment;
begin
  Result := TAlignment(Integer(AValue));
end;

{ TLeftRight_sw }

class function TLeftRight_sw.GetTypeName: WideString;
begin
  Result := 'TLeftRight';
end;

class function TLeftRight_sw.ToVar(const AValue: TLeftRight): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TLeftRight_sw.FromVar(const AValue: OleVariant): TLeftRight;
begin
  Result := TLeftRight(Integer(AValue));
end;

{ TBiDiMode_sw }

class function TBiDiMode_sw.GetTypeName: WideString;
begin
  Result := 'TBiDiMode';
end;

class function TBiDiMode_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TBiDiMode);
end;

class function TBiDiMode_sw.ToVar(const AValue: TBiDiMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBiDiMode_sw.FromVar(const AValue: OleVariant): TBiDiMode;
begin
  Result := TBiDiMode(Integer(AValue));
end;

{ TVerticalAlignment_sw }

class function TVerticalAlignment_sw.GetTypeName: WideString;
begin
  Result := 'TVerticalAlignment';
end;

class function TVerticalAlignment_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TVerticalAlignment);
end;

class function TVerticalAlignment_sw.ToVar(
  const AValue: TVerticalAlignment): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TVerticalAlignment_sw.FromVar(
  const AValue: OleVariant): TVerticalAlignment;
begin
  Result := TVerticalAlignment(Integer(AValue));
end;

{ TTopBottom_sw }

class function TTopBottom_sw.GetTypeName: WideString;
begin
  Result := 'TTopBottom';
end;

class function TTopBottom_sw.ToVar(const AValue: TTopBottom): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTopBottom_sw.FromVar(const AValue: OleVariant): TTopBottom;
begin
  Result := TTopBottom(Integer(AValue));
end;

{ THelpContext_sw }

class function THelpContext_sw.GetTypeName: WideString;
begin
  Result := 'THelpContext';
end;

class function THelpContext_sw.ToVar(const AValue: THelpContext): OleVariant;
begin
  Result := Integer(AValue);
end;

class function THelpContext_sw.FromVar(const AValue: OleVariant): THelpContext;
begin
  Result := THelpContext(Integer(AValue));
end;

{ THelpType_sw }

class function THelpType_sw.GetTypeName: WideString;
begin
  Result := 'THelpType';
end;

class function THelpType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(THelpType);
end;

class function THelpType_sw.ToVar(const AValue: THelpType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function THelpType_sw.FromVar(const AValue: OleVariant): THelpType;
begin
  Result := THelpType(Integer(AValue));
end;

{ TShortCut_sw }

class function TShortCut_sw.GetTypeName: WideString;
begin
  Result := 'TShortCut';
end;

class function TShortCut_sw.ToVar(const AValue: TShortCut): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TShortCut_sw.FromVar(const AValue: OleVariant): TShortCut;
begin
  Result := TShortCut(Integer(AValue));
end;

{ TNotifyEvent_sh }

function TNotifyEvent_sh.GetHandler: TMethod;
var
  hdr: TNotifyEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TNotifyEvent_sh.Handler(Sender: TObject);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (Sender: TObject) of object

  args[0] := TObject_sw.ToVar(Sender);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TNotifyEvent_sw }

class function TNotifyEvent_sw.GetTypeName: WideString;
begin
  Result := 'TNotifyEvent';
end;

class function TNotifyEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TNotifyEvent_sh;
end;

class function TNotifyEvent_sw.ToVar(const AValue: TNotifyEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TNotifyEvent_sw.FromVar(const AValue: OleVariant): TNotifyEvent;
begin
  Result := TNotifyEvent(ConvFromVar(AValue));
end;

class function TNotifyEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TNotifyEvent;
var
  hdlr: TNotifyEvent_sh;
begin
  hdlr   := TNotifyEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TNotifyEvent_sw));
  Result := hdlr.Handler;
end;

{ TGetStrProc_sh }

function TGetStrProc_sh.GetHandler: TMethod;
var
  hdr: TGetStrProc;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetStrProc_sh.Handler(const S: string);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (const S: string) of object

  args[0] := S;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TGetStrProc_sw }

class function TGetStrProc_sw.GetTypeName: WideString;
begin
  Result := 'TGetStrProc';
end;

class function TGetStrProc_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetStrProc_sh;
end;

class function TGetStrProc_sw.ToVar(const AValue: TGetStrProc): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetStrProc_sw.FromVar(const AValue: OleVariant): TGetStrProc;
begin
  Result := TGetStrProc(ConvFromVar(AValue));
end;

class function TGetStrProc_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetStrProc;
var
  hdlr: TGetStrProc_sh;
begin
  hdlr   := TGetStrProc_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetStrProc_sw));
  Result := hdlr.Handler;
end;

{ EStreamError_sw }

class function EStreamError_sw.GetTypeName: WideString;
begin
  Result := 'EStreamError';
end;

class function EStreamError_sw.GetWrappedClass: TClass;
begin
  Result := EStreamError;
end;

class procedure EStreamError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EStreamError_sw.ToVar(const AValue: EStreamError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EStreamError_sw.FromVar(const AValue: OleVariant): EStreamError;
begin
  Result := EStreamError(ConvFromVar(AValue, EStreamError));
end;

class function EStreamError_sw.ClassToVar(AClass: EStreamError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EStreamError_sw.ClassFromVar(
  const AClass: OleVariant): EStreamError_sc;
begin
  Result := EStreamError_sc(ConvClsFromVar(AClass, EStreamError));
end;

{ EFileStreamError_sw }

class function EFileStreamError_sw.GetTypeName: WideString;
begin
  Result := 'EFileStreamError';
end;

class function EFileStreamError_sw.GetWrappedClass: TClass;
begin
  Result := EFileStreamError;
end;

class procedure EFileStreamError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EFileStreamError_sw.ToVar(
  const AValue: EFileStreamError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EFileStreamError_sw.FromVar(
  const AValue: OleVariant): EFileStreamError;
begin
  Result := EFileStreamError(ConvFromVar(AValue, EFileStreamError));
end;

class function EFileStreamError_sw.ClassToVar(
  AClass: EFileStreamError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EFileStreamError_sw.ClassFromVar(
  const AClass: OleVariant): EFileStreamError_sc;
begin
  Result := EFileStreamError_sc(ConvClsFromVar(AClass, EFileStreamError));
end;

{ EFCreateError_sw }

class function EFCreateError_sw.GetTypeName: WideString;
begin
  Result := 'EFCreateError';
end;

class function EFCreateError_sw.GetWrappedClass: TClass;
begin
  Result := EFCreateError;
end;

class procedure EFCreateError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EFCreateError_sw.ToVar(const AValue: EFCreateError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EFCreateError_sw.FromVar(
  const AValue: OleVariant): EFCreateError;
begin
  Result := EFCreateError(ConvFromVar(AValue, EFCreateError));
end;

class function EFCreateError_sw.ClassToVar(
  AClass: EFCreateError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EFCreateError_sw.ClassFromVar(
  const AClass: OleVariant): EFCreateError_sc;
begin
  Result := EFCreateError_sc(ConvClsFromVar(AClass, EFCreateError));
end;

{ EFOpenError_sw }

class function EFOpenError_sw.GetTypeName: WideString;
begin
  Result := 'EFOpenError';
end;

class function EFOpenError_sw.GetWrappedClass: TClass;
begin
  Result := EFOpenError;
end;

class procedure EFOpenError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EFOpenError_sw.ToVar(const AValue: EFOpenError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EFOpenError_sw.FromVar(const AValue: OleVariant): EFOpenError;
begin
  Result := EFOpenError(ConvFromVar(AValue, EFOpenError));
end;

class function EFOpenError_sw.ClassToVar(AClass: EFOpenError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EFOpenError_sw.ClassFromVar(
  const AClass: OleVariant): EFOpenError_sc;
begin
  Result := EFOpenError_sc(ConvClsFromVar(AClass, EFOpenError));
end;

{ EFilerError_sw }

class function EFilerError_sw.GetTypeName: WideString;
begin
  Result := 'EFilerError';
end;

class function EFilerError_sw.GetWrappedClass: TClass;
begin
  Result := EFilerError;
end;

class procedure EFilerError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EFilerError_sw.ToVar(const AValue: EFilerError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EFilerError_sw.FromVar(const AValue: OleVariant): EFilerError;
begin
  Result := EFilerError(ConvFromVar(AValue, EFilerError));
end;

class function EFilerError_sw.ClassToVar(AClass: EFilerError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EFilerError_sw.ClassFromVar(
  const AClass: OleVariant): EFilerError_sc;
begin
  Result := EFilerError_sc(ConvClsFromVar(AClass, EFilerError));
end;

{ EReadError_sw }

class function EReadError_sw.GetTypeName: WideString;
begin
  Result := 'EReadError';
end;

class function EReadError_sw.GetWrappedClass: TClass;
begin
  Result := EReadError;
end;

class procedure EReadError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EReadError_sw.ToVar(const AValue: EReadError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EReadError_sw.FromVar(const AValue: OleVariant): EReadError;
begin
  Result := EReadError(ConvFromVar(AValue, EReadError));
end;

class function EReadError_sw.ClassToVar(AClass: EReadError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EReadError_sw.ClassFromVar(
  const AClass: OleVariant): EReadError_sc;
begin
  Result := EReadError_sc(ConvClsFromVar(AClass, EReadError));
end;

{ EWriteError_sw }

class function EWriteError_sw.GetTypeName: WideString;
begin
  Result := 'EWriteError';
end;

class function EWriteError_sw.GetWrappedClass: TClass;
begin
  Result := EWriteError;
end;

class procedure EWriteError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EWriteError_sw.ToVar(const AValue: EWriteError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EWriteError_sw.FromVar(const AValue: OleVariant): EWriteError;
begin
  Result := EWriteError(ConvFromVar(AValue, EWriteError));
end;

class function EWriteError_sw.ClassToVar(AClass: EWriteError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EWriteError_sw.ClassFromVar(
  const AClass: OleVariant): EWriteError_sc;
begin
  Result := EWriteError_sc(ConvClsFromVar(AClass, EWriteError));
end;

{ EClassNotFound_sw }

class function EClassNotFound_sw.GetTypeName: WideString;
begin
  Result := 'EClassNotFound';
end;

class function EClassNotFound_sw.GetWrappedClass: TClass;
begin
  Result := EClassNotFound;
end;

class procedure EClassNotFound_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EClassNotFound_sw.ToVar(
  const AValue: EClassNotFound): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EClassNotFound_sw.FromVar(
  const AValue: OleVariant): EClassNotFound;
begin
  Result := EClassNotFound(ConvFromVar(AValue, EClassNotFound));
end;

class function EClassNotFound_sw.ClassToVar(
  AClass: EClassNotFound_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EClassNotFound_sw.ClassFromVar(
  const AClass: OleVariant): EClassNotFound_sc;
begin
  Result := EClassNotFound_sc(ConvClsFromVar(AClass, EClassNotFound));
end;

{ EMethodNotFound_sw }

class function EMethodNotFound_sw.GetTypeName: WideString;
begin
  Result := 'EMethodNotFound';
end;

class function EMethodNotFound_sw.GetWrappedClass: TClass;
begin
  Result := EMethodNotFound;
end;

class procedure EMethodNotFound_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EMethodNotFound_sw.ToVar(
  const AValue: EMethodNotFound): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EMethodNotFound_sw.FromVar(
  const AValue: OleVariant): EMethodNotFound;
begin
  Result := EMethodNotFound(ConvFromVar(AValue, EMethodNotFound));
end;

class function EMethodNotFound_sw.ClassToVar(
  AClass: EMethodNotFound_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EMethodNotFound_sw.ClassFromVar(
  const AClass: OleVariant): EMethodNotFound_sc;
begin
  Result := EMethodNotFound_sc(ConvClsFromVar(AClass, EMethodNotFound));
end;

{ EInvalidImage_sw }

class function EInvalidImage_sw.GetTypeName: WideString;
begin
  Result := 'EInvalidImage';
end;

class function EInvalidImage_sw.GetWrappedClass: TClass;
begin
  Result := EInvalidImage;
end;

class procedure EInvalidImage_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EInvalidImage_sw.ToVar(const AValue: EInvalidImage): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EInvalidImage_sw.FromVar(
  const AValue: OleVariant): EInvalidImage;
begin
  Result := EInvalidImage(ConvFromVar(AValue, EInvalidImage));
end;

class function EInvalidImage_sw.ClassToVar(
  AClass: EInvalidImage_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EInvalidImage_sw.ClassFromVar(
  const AClass: OleVariant): EInvalidImage_sc;
begin
  Result := EInvalidImage_sc(ConvClsFromVar(AClass, EInvalidImage));
end;

{ EResNotFound_sw }

class function EResNotFound_sw.GetTypeName: WideString;
begin
  Result := 'EResNotFound';
end;

class function EResNotFound_sw.GetWrappedClass: TClass;
begin
  Result := EResNotFound;
end;

class procedure EResNotFound_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EResNotFound_sw.ToVar(const AValue: EResNotFound): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EResNotFound_sw.FromVar(const AValue: OleVariant): EResNotFound;
begin
  Result := EResNotFound(ConvFromVar(AValue, EResNotFound));
end;

class function EResNotFound_sw.ClassToVar(AClass: EResNotFound_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EResNotFound_sw.ClassFromVar(
  const AClass: OleVariant): EResNotFound_sc;
begin
  Result := EResNotFound_sc(ConvClsFromVar(AClass, EResNotFound));
end;

{ EListError_sw }

class function EListError_sw.GetTypeName: WideString;
begin
  Result := 'EListError';
end;

class function EListError_sw.GetWrappedClass: TClass;
begin
  Result := EListError;
end;

class procedure EListError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EListError_sw.ToVar(const AValue: EListError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EListError_sw.FromVar(const AValue: OleVariant): EListError;
begin
  Result := EListError(ConvFromVar(AValue, EListError));
end;

class function EListError_sw.ClassToVar(AClass: EListError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EListError_sw.ClassFromVar(
  const AClass: OleVariant): EListError_sc;
begin
  Result := EListError_sc(ConvClsFromVar(AClass, EListError));
end;

{ EBitsError_sw }

class function EBitsError_sw.GetTypeName: WideString;
begin
  Result := 'EBitsError';
end;

class function EBitsError_sw.GetWrappedClass: TClass;
begin
  Result := EBitsError;
end;

class procedure EBitsError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EBitsError_sw.ToVar(const AValue: EBitsError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EBitsError_sw.FromVar(const AValue: OleVariant): EBitsError;
begin
  Result := EBitsError(ConvFromVar(AValue, EBitsError));
end;

class function EBitsError_sw.ClassToVar(AClass: EBitsError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EBitsError_sw.ClassFromVar(
  const AClass: OleVariant): EBitsError_sc;
begin
  Result := EBitsError_sc(ConvClsFromVar(AClass, EBitsError));
end;

{ EStringListError_sw }

class function EStringListError_sw.GetTypeName: WideString;
begin
  Result := 'EStringListError';
end;

class function EStringListError_sw.GetWrappedClass: TClass;
begin
  Result := EStringListError;
end;

class procedure EStringListError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EStringListError_sw.ToVar(
  const AValue: EStringListError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EStringListError_sw.FromVar(
  const AValue: OleVariant): EStringListError;
begin
  Result := EStringListError(ConvFromVar(AValue, EStringListError));
end;

class function EStringListError_sw.ClassToVar(
  AClass: EStringListError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EStringListError_sw.ClassFromVar(
  const AClass: OleVariant): EStringListError_sc;
begin
  Result := EStringListError_sc(ConvClsFromVar(AClass, EStringListError));
end;

{ EComponentError_sw }

class function EComponentError_sw.GetTypeName: WideString;
begin
  Result := 'EComponentError';
end;

class function EComponentError_sw.GetWrappedClass: TClass;
begin
  Result := EComponentError;
end;

class procedure EComponentError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EComponentError_sw.ToVar(
  const AValue: EComponentError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EComponentError_sw.FromVar(
  const AValue: OleVariant): EComponentError;
begin
  Result := EComponentError(ConvFromVar(AValue, EComponentError));
end;

class function EComponentError_sw.ClassToVar(
  AClass: EComponentError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EComponentError_sw.ClassFromVar(
  const AClass: OleVariant): EComponentError_sc;
begin
  Result := EComponentError_sc(ConvClsFromVar(AClass, EComponentError));
end;

{ EParserError_sw }

class function EParserError_sw.GetTypeName: WideString;
begin
  Result := 'EParserError';
end;

class function EParserError_sw.GetWrappedClass: TClass;
begin
  Result := EParserError;
end;

class procedure EParserError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EParserError_sw.ToVar(const AValue: EParserError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EParserError_sw.FromVar(const AValue: OleVariant): EParserError;
begin
  Result := EParserError(ConvFromVar(AValue, EParserError));
end;

class function EParserError_sw.ClassToVar(AClass: EParserError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EParserError_sw.ClassFromVar(
  const AClass: OleVariant): EParserError_sc;
begin
  Result := EParserError_sc(ConvClsFromVar(AClass, EParserError));
end;

{ EOutOfResources_sw }

class function EOutOfResources_sw.GetTypeName: WideString;
begin
  Result := 'EOutOfResources';
end;

class function EOutOfResources_sw.GetWrappedClass: TClass;
begin
  Result := EOutOfResources;
end;

class procedure EOutOfResources_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EOutOfResources_sw.ToVar(
  const AValue: EOutOfResources): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EOutOfResources_sw.FromVar(
  const AValue: OleVariant): EOutOfResources;
begin
  Result := EOutOfResources(ConvFromVar(AValue, EOutOfResources));
end;

class function EOutOfResources_sw.ClassToVar(
  AClass: EOutOfResources_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EOutOfResources_sw.ClassFromVar(
  const AClass: OleVariant): EOutOfResources_sc;
begin
  Result := EOutOfResources_sc(ConvClsFromVar(AClass, EOutOfResources));
end;

{ EInvalidOperation_sw }

class function EInvalidOperation_sw.GetTypeName: WideString;
begin
  Result := 'EInvalidOperation';
end;

class function EInvalidOperation_sw.GetWrappedClass: TClass;
begin
  Result := EInvalidOperation;
end;

class procedure EInvalidOperation_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EInvalidOperation_sw.ToVar(
  const AValue: EInvalidOperation): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EInvalidOperation_sw.FromVar(
  const AValue: OleVariant): EInvalidOperation;
begin
  Result := EInvalidOperation(ConvFromVar(AValue, EInvalidOperation));
end;

class function EInvalidOperation_sw.ClassToVar(
  AClass: EInvalidOperation_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EInvalidOperation_sw.ClassFromVar(
  const AClass: OleVariant): EInvalidOperation_sc;
begin
  Result := EInvalidOperation_sc(ConvClsFromVar(AClass, EInvalidOperation));
end;

{ TDuplicates_sw }

class function TDuplicates_sw.GetTypeName: WideString;
begin
  Result := 'TDuplicates';
end;

class function TDuplicates_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TDuplicates);
end;

class function TDuplicates_sw.ToVar(const AValue: TDuplicates): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDuplicates_sw.FromVar(const AValue: OleVariant): TDuplicates;
begin
  Result := TDuplicates(Integer(AValue));
end;

{ TListNotification_sw }

class function TListNotification_sw.GetTypeName: WideString;
begin
  Result := 'TListNotification';
end;

class function TListNotification_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TListNotification);
end;

class function TListNotification_sw.ToVar(
  const AValue: TListNotification): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TListNotification_sw.FromVar(
  const AValue: OleVariant): TListNotification;
begin
  Result := TListNotification(Integer(AValue));
end;

{ TListAssignOp_sw }

class function TListAssignOp_sw.GetTypeName: WideString;
begin
  Result := 'TListAssignOp';
end;

class function TListAssignOp_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TListAssignOp);
end;

class function TListAssignOp_sw.ToVar(const AValue: TListAssignOp): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TListAssignOp_sw.FromVar(
  const AValue: OleVariant): TListAssignOp;
begin
  Result := TListAssignOp(Integer(AValue));
end;

{ TListEnumerator_sw }

function TListEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AList: TList);

  Result := TListEnumerator_sw.ToVar(TListEnumerator_sc(AObj).Create(TList_sw.
    FromVar(AArgs[0])));
end;

function TListEnumerator_MoveNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TListEnumerator(AObj).MoveNext();
end;

class function TListEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TListEnumerator';
end;

class function TListEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TListEnumerator;
end;

class procedure TListEnumerator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('MoveNext', TListEnumerator_MoveNext_si, Boolean_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TListEnumerator_Create_si, 1, False);
end;

class function TListEnumerator_sw.ToVar(
  const AValue: TListEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListEnumerator_sw.FromVar(
  const AValue: OleVariant): TListEnumerator;
begin
  Result := TListEnumerator(ConvFromVar(AValue, TListEnumerator));
end;

class function TListEnumerator_sw.ClassToVar(
  AClass: TListEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TListEnumerator_sc;
begin
  Result := TListEnumerator_sc(ConvClsFromVar(AClass, TListEnumerator));
end;

{ TList_sw }

function TList_Clear_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TList(AObj).Clear();
end;

function TList_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete(Index: Integer);

  TList(AObj).Delete(Integer(AArgs[0]));
end;

function TList_Exchange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Exchange(Index1: Integer; Index2: Integer);

  TList(AObj).Exchange(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TList_Expand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Expand: TList;

  Result := TList_sw.ToVar(TList(AObj).Expand());
end;

function TList_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TListEnumerator;

  Result := TListEnumerator_sw.ToVar(TList(AObj).GetEnumerator());
end;

function TList_Move_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure Move(CurIndex: Integer; NewIndex: Integer);

  TList(AObj).Move(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TList_Pack_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure Pack;

  TList(AObj).Pack();
end;

function TList_Assign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Assign(ListA: TList; AOperator: TListAssignOp; ...

  TList(AObj).Assign(TList_sw.FromVar(AArgs[0]), TListAssignOp_sw.FromVar(
    AArgs[1]), TList_sw.FromVar(AArgs[2]));
end;

function TList_Capacity_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Capacity: Integer read <getter> write <setter>;

  if IsGet then
    Result := TList(AObj).Capacity
  else
    TList(AObj).Capacity := Integer(AArgs[0]);
end;

function TList_Count_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter> write <setter>;

  if IsGet then
    Result := TList(AObj).Count
  else
    TList(AObj).Count := Integer(AArgs[0]);
end;

class function TList_sw.GetTypeName: WideString;
begin
  Result := 'TList';
end;

class function TList_sw.GetWrappedClass: TClass;
begin
  Result := TList;
end;

class procedure TList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Clear', TList_Clear_si, 0, False);
  AData.AddProcedure('Delete', TList_Delete_si, 1, False);
  AData.AddProcedure('Exchange', TList_Exchange_si, 2, False);
  AData.AddFunction('Expand', TList_Expand_si, TList_sw, 0, False);
  AData.AddFunction('GetEnumerator', TList_GetEnumerator_si, TListEnumerator_sw, 0, False);
  AData.AddProcedure('Move', TList_Move_si, 2, False);
  AData.AddProcedure('Pack', TList_Pack_si, 0, False);
  AData.AddProcedure('Assign', TList_Assign_si, 3, False);
  AData.AddProperty('Capacity', TList_Capacity_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('Count', TList_Count_si, Integer_sw, True, True, 0, False);
end;

class function TList_sw.ToVar(const AValue: TList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TList_sw.FromVar(const AValue: OleVariant): TList;
begin
  Result := TList(ConvFromVar(AValue, TList));
end;

class function TList_sw.ClassToVar(AClass: TList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TList_sw.ClassFromVar(const AClass: OleVariant): TList_sc;
begin
  Result := TList_sc(ConvClsFromVar(AClass, TList));
end;

{ TThreadList_sw }

function TThreadList_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TThreadList_sw.ToVar(TThreadList_sc(AObj).Create());
end;

function TThreadList_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TThreadList(AObj).Clear();
end;

function TThreadList_LockList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function LockList: TList;

  Result := TList_sw.ToVar(TThreadList(AObj).LockList());
end;

function TThreadList_UnlockList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnlockList;

  TThreadList(AObj).UnlockList();
end;

function TThreadList_Duplicates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Duplicates: TDuplicates read <getter> write <set...

  if IsGet then
    Result := TDuplicates_sw.ToVar(TThreadList(AObj).Duplicates)
  else
    TThreadList(AObj).Duplicates := TDuplicates_sw.FromVar(AArgs[0]);
end;

class function TThreadList_sw.GetTypeName: WideString;
begin
  Result := 'TThreadList';
end;

class function TThreadList_sw.GetWrappedClass: TClass;
begin
  Result := TThreadList;
end;

class procedure TThreadList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Clear', TThreadList_Clear_si, 0, False);
  AData.AddFunction('LockList', TThreadList_LockList_si, TList_sw, 0, False);
  AData.AddProcedure('UnlockList', TThreadList_UnlockList_si, 0, False);
  AData.AddProperty('Duplicates', TThreadList_Duplicates_si, TDuplicates_sw, True, True, 0, False);

  { Class members }

  AData.AddConstructor('Create', TThreadList_Create_si, 0, False);
end;

class function TThreadList_sw.ToVar(const AValue: TThreadList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TThreadList_sw.FromVar(const AValue: OleVariant): TThreadList;
begin
  Result := TThreadList(ConvFromVar(AValue, TThreadList));
end;

class function TThreadList_sw.ClassToVar(AClass: TThreadList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TThreadList_sw.ClassFromVar(
  const AClass: OleVariant): TThreadList_sc;
begin
  Result := TThreadList_sc(ConvClsFromVar(AClass, TThreadList));
end;

{ TInterfaceListEnumerator_sw }

function TInterfaceListEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AInterfaceList: TInterfaceList);

  Result := TInterfaceListEnumerator_sw.ToVar(TInterfaceListEnumerator_sc(AObj).
    Create(TInterfaceList_sw.FromVar(AArgs[0])));
end;

function TInterfaceListEnumerator_MoveNext_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TInterfaceListEnumerator(AObj).MoveNext();
end;

class function TInterfaceListEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TInterfaceListEnumerator';
end;

class function TInterfaceListEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TInterfaceListEnumerator;
end;

class procedure TInterfaceListEnumerator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('MoveNext', TInterfaceListEnumerator_MoveNext_si, Boolean_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TInterfaceListEnumerator_Create_si, 1, False);
end;

class function TInterfaceListEnumerator_sw.ToVar(
  const AValue: TInterfaceListEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TInterfaceListEnumerator_sw.FromVar(
  const AValue: OleVariant): TInterfaceListEnumerator;
begin
  Result := TInterfaceListEnumerator(ConvFromVar(AValue, 
    TInterfaceListEnumerator));
end;

class function TInterfaceListEnumerator_sw.ClassToVar(
  AClass: TInterfaceListEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TInterfaceListEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TInterfaceListEnumerator_sc;
begin
  Result := TInterfaceListEnumerator_sc(ConvClsFromVar(AClass, 
    TInterfaceListEnumerator));
end;

{ TInterfaceList_sw }

function TInterfaceList_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TInterfaceList_sw.ToVar(TInterfaceList_sc(AObj).Create());
end;

function TInterfaceList_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TInterfaceList(AObj).Clear();
end;

function TInterfaceList_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete(Index: Integer);

  TInterfaceList(AObj).Delete(Integer(AArgs[0]));
end;

function TInterfaceList_Exchange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Exchange(Index1: Integer; Index2: Integer);

  TInterfaceList(AObj).Exchange(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TInterfaceList_Expand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Expand: TInterfaceList;

  Result := TInterfaceList_sw.ToVar(TInterfaceList(AObj).Expand());
end;

function TInterfaceList_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TInterfaceListEnumerator;

  Result := TInterfaceListEnumerator_sw.ToVar(TInterfaceList(AObj).
    GetEnumerator());
end;

function TInterfaceList_Lock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Lock;

  TInterfaceList(AObj).Lock();
end;

function TInterfaceList_Unlock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Unlock;

  TInterfaceList(AObj).Unlock();
end;

function TInterfaceList_Capacity_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Capacity: Integer read <getter> write <setter>;

  if IsGet then
    Result := TInterfaceList(AObj).Capacity
  else
    TInterfaceList(AObj).Capacity := Integer(AArgs[0]);
end;

function TInterfaceList_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter> write <setter>;

  if IsGet then
    Result := TInterfaceList(AObj).Count
  else
    TInterfaceList(AObj).Count := Integer(AArgs[0]);
end;

class function TInterfaceList_sw.GetTypeName: WideString;
begin
  Result := 'TInterfaceList';
end;

class function TInterfaceList_sw.GetWrappedClass: TClass;
begin
  Result := TInterfaceList;
end;

class procedure TInterfaceList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Clear', TInterfaceList_Clear_si, 0, False);
  AData.AddProcedure('Delete', TInterfaceList_Delete_si, 1, False);
  AData.AddProcedure('Exchange', TInterfaceList_Exchange_si, 2, False);
  AData.AddFunction('Expand', TInterfaceList_Expand_si, TInterfaceList_sw, 0, False);
  AData.AddFunction('GetEnumerator', TInterfaceList_GetEnumerator_si, TInterfaceListEnumerator_sw, 0, False);
  AData.AddProcedure('Lock', TInterfaceList_Lock_si, 0, False);
  AData.AddProcedure('Unlock', TInterfaceList_Unlock_si, 0, False);
  AData.AddProperty('Capacity', TInterfaceList_Capacity_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('Count', TInterfaceList_Count_si, Integer_sw, True, True, 0, False);

  { Class members }

  AData.AddConstructor('Create', TInterfaceList_Create_si, 0, False);
end;

class function TInterfaceList_sw.ToVar(
  const AValue: TInterfaceList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TInterfaceList_sw.FromVar(
  const AValue: OleVariant): TInterfaceList;
begin
  Result := TInterfaceList(ConvFromVar(AValue, TInterfaceList));
end;

class function TInterfaceList_sw.ClassToVar(
  AClass: TInterfaceList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TInterfaceList_sw.ClassFromVar(
  const AClass: OleVariant): TInterfaceList_sc;
begin
  Result := TInterfaceList_sc(ConvClsFromVar(AClass, TInterfaceList));
end;

{ TBits_sw }

function TBits_OpenBit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function OpenBit: Integer;

  Result := TBits(AObj).OpenBit();
end;

function TBits_Bits_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Bits[Index: Integer]: Boolean read <getter> writ...

  if IsGet then
    Result := TBits(AObj).Bits[Integer(AArgs[0])]
  else
    TBits(AObj).Bits[Integer(AArgs[0])] := Boolean(AArgs[1]);
end;

function TBits_Size_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Size: Integer read <getter> write <setter>;

  if IsGet then
    Result := TBits(AObj).Size
  else
    TBits(AObj).Size := Integer(AArgs[0]);
end;

class function TBits_sw.GetTypeName: WideString;
begin
  Result := 'TBits';
end;

class function TBits_sw.GetWrappedClass: TClass;
begin
  Result := TBits;
end;

class procedure TBits_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('OpenBit', TBits_OpenBit_si, Integer_sw, 0, False);
  AData.AddProperty('Bits', TBits_Bits_si, Boolean_sw, True, True, 1, False);
  AData.AddProperty('Size', TBits_Size_si, Integer_sw, True, True, 0, False);
end;

class function TBits_sw.ToVar(const AValue: TBits): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBits_sw.FromVar(const AValue: OleVariant): TBits;
begin
  Result := TBits(ConvFromVar(AValue, TBits));
end;

class function TBits_sw.ClassToVar(AClass: TBits_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBits_sw.ClassFromVar(const AClass: OleVariant): TBits_sc;
begin
  Result := TBits_sc(ConvClsFromVar(AClass, TBits));
end;

{ TPersistent_sw }

function TPersistent_Assign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Assign(Source: TPersistent);

  TPersistent(AObj).Assign(TPersistent_sw.FromVar(AArgs[0]));
end;

function TPersistent_GetNamePath_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetNamePath: string;

  Result := TPersistent(AObj).GetNamePath();
end;

class function TPersistent_sw.GetTypeName: WideString;
begin
  Result := 'TPersistent';
end;

class function TPersistent_sw.GetWrappedClass: TClass;
begin
  Result := TPersistent;
end;

class procedure TPersistent_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Assign', TPersistent_Assign_si, 1, False);
  AData.AddFunction('GetNamePath', TPersistent_GetNamePath_si, string_sw, 0, False);
end;

class function TPersistent_sw.ToVar(const AValue: TPersistent): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPersistent_sw.FromVar(const AValue: OleVariant): TPersistent;
begin
  Result := TPersistent(ConvFromVar(AValue, TPersistent));
end;

class function TPersistent_sw.ClassToVar(AClass: TPersistent_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPersistent_sw.ClassFromVar(
  const AClass: OleVariant): TPersistent_sc;
begin
  Result := TPersistent_sc(ConvClsFromVar(AClass, TPersistent));
end;

{ TPersistentClass_sw }

class function TPersistentClass_sw.GetTypeName: WideString;
begin
  Result := 'TPersistentClass';
end;

class function TPersistentClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TPersistent;
end;

class function TPersistentClass_sw.ToVar(
  const AValue: TPersistentClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPersistentClass_sw.FromVar(
  const AValue: OleVariant): TPersistentClass;
begin
  Result := TPersistentClass(ConvFromVar(AValue, TPersistent));
end;

{ TInterfacedPersistent_sw }

class function TInterfacedPersistent_sw.GetTypeName: WideString;
begin
  Result := 'TInterfacedPersistent';
end;

class function TInterfacedPersistent_sw.GetWrappedClass: TClass;
begin
  Result := TInterfacedPersistent;
end;

class procedure TInterfacedPersistent_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TInterfacedPersistent_sw.ToVar(
  const AValue: TInterfacedPersistent): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TInterfacedPersistent_sw.FromVar(
  const AValue: OleVariant): TInterfacedPersistent;
begin
  Result := TInterfacedPersistent(ConvFromVar(AValue, TInterfacedPersistent));
end;

class function TInterfacedPersistent_sw.ClassToVar(
  AClass: TInterfacedPersistent_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TInterfacedPersistent_sw.ClassFromVar(
  const AClass: OleVariant): TInterfacedPersistent_sc;
begin
  Result := TInterfacedPersistent_sc(ConvClsFromVar(AClass, 
    TInterfacedPersistent));
end;

{ TRecall_sw }

function TRecall_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AStorage: TPersistent; AReference: TPe...

  Result := TRecall_sw.ToVar(TRecall_sc(AObj).Create(TPersistent_sw.FromVar(
    AArgs[0]), TPersistent_sw.FromVar(AArgs[1])));
end;

function TRecall_Store_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Store;

  TRecall(AObj).Store();
end;

function TRecall_Forget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Forget;

  TRecall(AObj).Forget();
end;

function TRecall_Reference_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Reference: TPersistent read <getter>;

  Result := TPersistent_sw.ToVar(TRecall(AObj).Reference);
end;

class function TRecall_sw.GetTypeName: WideString;
begin
  Result := 'TRecall';
end;

class function TRecall_sw.GetWrappedClass: TClass;
begin
  Result := TRecall;
end;

class procedure TRecall_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Store', TRecall_Store_si, 0, False);
  AData.AddProcedure('Forget', TRecall_Forget_si, 0, False);
  AData.AddProperty('Reference', TRecall_Reference_si, TPersistent_sw, True, False, 0, False);

  { Class members }

  AData.AddConstructor('Create', TRecall_Create_si, 2, False);
end;

class function TRecall_sw.ToVar(const AValue: TRecall): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TRecall_sw.FromVar(const AValue: OleVariant): TRecall;
begin
  Result := TRecall(ConvFromVar(AValue, TRecall));
end;

class function TRecall_sw.ClassToVar(AClass: TRecall_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TRecall_sw.ClassFromVar(const AClass: OleVariant): TRecall_sc;
begin
  Result := TRecall_sc(ConvClsFromVar(AClass, TRecall));
end;

{ TCollectionItem_sw }

function TCollectionItem_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Collection: TCollection);

  Result := TCollectionItem_sw.ToVar(TCollectionItem_sc(AObj).Create(
    TCollection_sw.FromVar(AArgs[0])));
end;

function TCollectionItem_Collection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Collection: TCollection read <getter> write <set...

  if IsGet then
    Result := TCollection_sw.ToVar(TCollectionItem(AObj).Collection)
  else
    TCollectionItem(AObj).Collection := TCollection_sw.FromVar(AArgs[0]);
end;

function TCollectionItem_ID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ID: Integer read <getter>;

  Result := TCollectionItem(AObj).ID;
end;

function TCollectionItem_Index_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Index: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCollectionItem(AObj).Index
  else
    TCollectionItem(AObj).Index := Integer(AArgs[0]);
end;

function TCollectionItem_DisplayName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayName: string read <getter> write <setter>;

  if IsGet then
    Result := TCollectionItem(AObj).DisplayName
  else
    TCollectionItem(AObj).DisplayName := string(AArgs[0]);
end;

class function TCollectionItem_sw.GetTypeName: WideString;
begin
  Result := 'TCollectionItem';
end;

class function TCollectionItem_sw.GetWrappedClass: TClass;
begin
  Result := TCollectionItem;
end;

class procedure TCollectionItem_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Collection', TCollectionItem_Collection_si, TCollection_sw, True, True, 0, False);
  AData.AddProperty('ID', TCollectionItem_ID_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('Index', TCollectionItem_Index_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('DisplayName', TCollectionItem_DisplayName_si, string_sw, True, True, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCollectionItem_Create_si, 1, False);
end;

class function TCollectionItem_sw.ToVar(
  const AValue: TCollectionItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCollectionItem_sw.FromVar(
  const AValue: OleVariant): TCollectionItem;
begin
  Result := TCollectionItem(ConvFromVar(AValue, TCollectionItem));
end;

class function TCollectionItem_sw.ClassToVar(
  AClass: TCollectionItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCollectionItem_sw.ClassFromVar(
  const AClass: OleVariant): TCollectionItem_sc;
begin
  Result := TCollectionItem_sc(ConvClsFromVar(AClass, TCollectionItem));
end;

{ TCollectionItemClass_sw }

class function TCollectionItemClass_sw.GetTypeName: WideString;
begin
  Result := 'TCollectionItemClass';
end;

class function TCollectionItemClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCollectionItem;
end;

class function TCollectionItemClass_sw.ToVar(
  const AValue: TCollectionItemClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCollectionItemClass_sw.FromVar(
  const AValue: OleVariant): TCollectionItemClass;
begin
  Result := TCollectionItemClass(ConvFromVar(AValue, TCollectionItem));
end;

{ TCollectionNotification_sw }

class function TCollectionNotification_sw.GetTypeName: WideString;
begin
  Result := 'TCollectionNotification';
end;

class function TCollectionNotification_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TCollectionNotification);
end;

class function TCollectionNotification_sw.ToVar(
  const AValue: TCollectionNotification): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCollectionNotification_sw.FromVar(
  const AValue: OleVariant): TCollectionNotification;
begin
  Result := TCollectionNotification(Integer(AValue));
end;

{ TCollectionEnumerator_sw }

function TCollectionEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ACollection: TCollection);

  Result := TCollectionEnumerator_sw.ToVar(TCollectionEnumerator_sc(AObj).
    Create(TCollection_sw.FromVar(AArgs[0])));
end;

function TCollectionEnumerator_GetCurrent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrent: TCollectionItem;

  Result := TCollectionItem_sw.ToVar(TCollectionEnumerator(AObj).GetCurrent());
end;

function TCollectionEnumerator_MoveNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TCollectionEnumerator(AObj).MoveNext();
end;

function TCollectionEnumerator_Current_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: TCollectionItem read <getter>;

  Result := TCollectionItem_sw.ToVar(TCollectionEnumerator(AObj).Current);
end;

class function TCollectionEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TCollectionEnumerator';
end;

class function TCollectionEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TCollectionEnumerator;
end;

class procedure TCollectionEnumerator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetCurrent', TCollectionEnumerator_GetCurrent_si, TCollectionItem_sw, 0, False);
  AData.AddFunction('MoveNext', TCollectionEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TCollectionEnumerator_Current_si, TCollectionItem_sw, True, False, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCollectionEnumerator_Create_si, 1, False);
end;

class function TCollectionEnumerator_sw.ToVar(
  const AValue: TCollectionEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCollectionEnumerator_sw.FromVar(
  const AValue: OleVariant): TCollectionEnumerator;
begin
  Result := TCollectionEnumerator(ConvFromVar(AValue, TCollectionEnumerator));
end;

class function TCollectionEnumerator_sw.ClassToVar(
  AClass: TCollectionEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCollectionEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TCollectionEnumerator_sc;
begin
  Result := TCollectionEnumerator_sc(ConvClsFromVar(AClass, 
    TCollectionEnumerator));
end;

{ TCollection_sw }

function TCollection_NextID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property NextID: Integer read <getter>;

  Result := TCollection_sacc(TCollection(AObj)).NextID;
end;

function TCollection_PropName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property PropName: string read <getter> write <...

  if IsGet then
    Result := TCollection_sacc(TCollection(AObj)).PropName
  else
    TCollection_sacc(TCollection(AObj)).PropName := string(AArgs[0]);
end;

function TCollection_UpdateCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property UpdateCount: Integer read <getter>;

  Result := TCollection_sacc(TCollection(AObj)).UpdateCount;
end;

function TCollection_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ItemClass: TCollectionItemClass);

  Result := TCollection_sw.ToVar(TCollection_sc(AObj).Create(
    TCollectionItemClass_sw.FromVar(AArgs[0])));
end;

function TCollection_Owner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Owner: TPersistent;

  Result := TPersistent_sw.ToVar(TCollection(AObj).Owner());
end;

function TCollection_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TCollectionItem;

  Result := TCollectionItem_sw.ToVar(TCollection(AObj).Add());
end;

function TCollection_BeginUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginUpdate;

  TCollection(AObj).BeginUpdate();
end;

function TCollection_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TCollection(AObj).Clear();
end;

function TCollection_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete(Index: Integer);

  TCollection(AObj).Delete(Integer(AArgs[0]));
end;

function TCollection_EndUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndUpdate;

  TCollection(AObj).EndUpdate();
end;

function TCollection_FindItemID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindItemID(ID: Integer): TCollectionItem;

  Result := TCollectionItem_sw.ToVar(TCollection(AObj).FindItemID(Integer(
    AArgs[0])));
end;

function TCollection_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TCollectionEnumerator;

  Result := TCollectionEnumerator_sw.ToVar(TCollection(AObj).GetEnumerator());
end;

function TCollection_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Insert(Index: Integer): TCollectionItem;

  Result := TCollectionItem_sw.ToVar(TCollection(AObj).Insert(Integer(
    AArgs[0])));
end;

function TCollection_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TCollection(AObj).Count;
end;

function TCollection_ItemClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ItemClass: TCollectionItemClass read <getter>;

  Result := TCollectionItemClass_sw.ToVar(TCollection(AObj).ItemClass);
end;

function TCollection_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TCollectionItem read <get...

  if IsGet then
    Result := TCollectionItem_sw.ToVar(TCollection(AObj).Items[Integer(
      AArgs[0])])
  else
    TCollection(AObj).Items[Integer(AArgs[0])] := TCollectionItem_sw.FromVar(
      AArgs[1]);
end;

class function TCollection_sw.GetTypeName: WideString;
begin
  Result := 'TCollection';
end;

class function TCollection_sw.GetWrappedClass: TClass;
begin
  Result := TCollection;
end;

class procedure TCollection_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('NextID', TCollection_NextID_si, Integer_sw, True, False, 0, True);
  AData.AddProperty('PropName', TCollection_PropName_si, string_sw, True, True, 0, True);
  AData.AddProperty('UpdateCount', TCollection_UpdateCount_si, Integer_sw, True, False, 0, True);
  AData.AddFunction('Owner', TCollection_Owner_si, TPersistent_sw, 0, False);
  AData.AddFunction('Add', TCollection_Add_si, TCollectionItem_sw, 0, False);
  AData.AddProcedure('BeginUpdate', TCollection_BeginUpdate_si, 0, False);
  AData.AddProcedure('Clear', TCollection_Clear_si, 0, False);
  AData.AddProcedure('Delete', TCollection_Delete_si, 1, False);
  AData.AddProcedure('EndUpdate', TCollection_EndUpdate_si, 0, False);
  AData.AddFunction('FindItemID', TCollection_FindItemID_si, TCollectionItem_sw, 1, False);
  AData.AddFunction('GetEnumerator', TCollection_GetEnumerator_si, TCollectionEnumerator_sw, 0, False);
  AData.AddFunction('Insert', TCollection_Insert_si, TCollectionItem_sw, 1, False);
  AData.AddProperty('Count', TCollection_Count_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('ItemClass', TCollection_ItemClass_si, TCollectionItemClass_sw, True, False, 0, False);
  AData.AddProperty('Items', TCollection_Items_si, TCollectionItem_sw, True, True, 1, False);

  { Class members }

  AData.AddConstructor('Create', TCollection_Create_si, 1, False);
end;

class function TCollection_sw.ToVar(const AValue: TCollection): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCollection_sw.FromVar(const AValue: OleVariant): TCollection;
begin
  Result := TCollection(ConvFromVar(AValue, TCollection));
end;

class function TCollection_sw.ClassToVar(AClass: TCollection_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCollection_sw.ClassFromVar(
  const AClass: OleVariant): TCollection_sc;
begin
  Result := TCollection_sc(ConvClsFromVar(AClass, TCollection));
end;

{ TOwnedCollection_sw }

function TOwnedCollection_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TPersistent; ItemClass: TColle...

  Result := TOwnedCollection_sw.ToVar(TOwnedCollection_sc(AObj).Create(
    TPersistent_sw.FromVar(AArgs[0]), TCollectionItemClass_sw.FromVar(AArgs[1])));
end;

class function TOwnedCollection_sw.GetTypeName: WideString;
begin
  Result := 'TOwnedCollection';
end;

class function TOwnedCollection_sw.GetWrappedClass: TClass;
begin
  Result := TOwnedCollection;
end;

class procedure TOwnedCollection_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TOwnedCollection_Create_si, 2, False);
end;

class function TOwnedCollection_sw.ToVar(
  const AValue: TOwnedCollection): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TOwnedCollection_sw.FromVar(
  const AValue: OleVariant): TOwnedCollection;
begin
  Result := TOwnedCollection(ConvFromVar(AValue, TOwnedCollection));
end;

class function TOwnedCollection_sw.ClassToVar(
  AClass: TOwnedCollection_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TOwnedCollection_sw.ClassFromVar(
  const AClass: OleVariant): TOwnedCollection_sc;
begin
  Result := TOwnedCollection_sc(ConvClsFromVar(AClass, TOwnedCollection));
end;

{ TGetModuleProc_sh }

function TGetModuleProc_sh.GetHandler: TMethod;
var
  hdr: TGetModuleProc;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetModuleProc_sh.Handler(const FileName: string;
  const UnitName: string; const FormName: string; const DesignClass: string;
  CoClasses: TStrings);
var
  args: array[0..4] of OleVariant;
begin
  // procedure (const FileName: string; const UnitName: string...

  args[0] := FileName;
  args[1] := UnitName;
  args[2] := FormName;
  args[3] := DesignClass;
  args[4] := TStrings_sw.ToVar(CoClasses);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TGetModuleProc_sw }

class function TGetModuleProc_sw.GetTypeName: WideString;
begin
  Result := 'TGetModuleProc';
end;

class function TGetModuleProc_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetModuleProc_sh;
end;

class function TGetModuleProc_sw.ToVar(
  const AValue: TGetModuleProc): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetModuleProc_sw.FromVar(
  const AValue: OleVariant): TGetModuleProc;
begin
  Result := TGetModuleProc(ConvFromVar(AValue));
end;

class function TGetModuleProc_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetModuleProc;
var
  hdlr: TGetModuleProc_sh;
begin
  hdlr   := TGetModuleProc_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetModuleProc_sw));
  Result := hdlr.Handler;
end;

{ TStringsEnumerator_sw }

function TStringsEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AStrings: TStrings);

  Result := TStringsEnumerator_sw.ToVar(TStringsEnumerator_sc(AObj).Create(
    TStrings_sw.FromVar(AArgs[0])));
end;

function TStringsEnumerator_GetCurrent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrent: string;

  Result := TStringsEnumerator(AObj).GetCurrent();
end;

function TStringsEnumerator_MoveNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TStringsEnumerator(AObj).MoveNext();
end;

function TStringsEnumerator_Current_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: string read <getter>;

  Result := TStringsEnumerator(AObj).Current;
end;

class function TStringsEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TStringsEnumerator';
end;

class function TStringsEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TStringsEnumerator;
end;

class procedure TStringsEnumerator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetCurrent', TStringsEnumerator_GetCurrent_si, string_sw, 0, False);
  AData.AddFunction('MoveNext', TStringsEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TStringsEnumerator_Current_si, string_sw, True, False, 0, False);

  { Class members }

  AData.AddConstructor('Create', TStringsEnumerator_Create_si, 1, False);
end;

class function TStringsEnumerator_sw.ToVar(
  const AValue: TStringsEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStringsEnumerator_sw.FromVar(
  const AValue: OleVariant): TStringsEnumerator;
begin
  Result := TStringsEnumerator(ConvFromVar(AValue, TStringsEnumerator));
end;

class function TStringsEnumerator_sw.ClassToVar(
  AClass: TStringsEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStringsEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TStringsEnumerator_sc;
begin
  Result := TStringsEnumerator_sc(ConvClsFromVar(AClass, TStringsEnumerator));
end;

{ TStrings_sw }

function TStrings_UpdateCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property UpdateCount: Integer read <getter>;

  Result := TStrings_sacc(TStrings(AObj)).UpdateCount;
end;

function TStrings_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add(const S: string): Integer;

  Result := TStrings(AObj).Add(string(AArgs[0]));
end;

function TStrings_AddObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddObject(const S: string; AObject: TObject): In...

  Result := TStrings(AObj).AddObject(string(AArgs[0]), TObject_sw.FromVar(
    AArgs[1]));
end;

function TStrings_Append_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Append(const S: string);

  TStrings(AObj).Append(string(AArgs[0]));
end;

function TStrings_AddStrings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AddStrings(Strings: TStrings);

  TStrings(AObj).AddStrings(TStrings_sw.FromVar(AArgs[0]));
end;

function TStrings_BeginUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginUpdate;

  TStrings(AObj).BeginUpdate();
end;

function TStrings_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TStrings(AObj).Clear();
end;

function TStrings_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete(Index: Integer);

  TStrings(AObj).Delete(Integer(AArgs[0]));
end;

function TStrings_EndUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndUpdate;

  TStrings(AObj).EndUpdate();
end;

function TStrings_Equals_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Equals(Strings: TStrings): Boolean;

  Result := TStrings(AObj).Equals(TStrings_sw.FromVar(AArgs[0]));
end;

function TStrings_Exchange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Exchange(Index1: Integer; Index2: Integer);

  TStrings(AObj).Exchange(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TStrings_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TStringsEnumerator;

  Result := TStringsEnumerator_sw.ToVar(TStrings(AObj).GetEnumerator());
end;

function TStrings_IndexOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOf(const S: string): Integer;

  Result := TStrings(AObj).IndexOf(string(AArgs[0]));
end;

function TStrings_IndexOfName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOfName(const Name: string): Integer;

  Result := TStrings(AObj).IndexOfName(string(AArgs[0]));
end;

function TStrings_IndexOfObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOfObject(AObject: TObject): Integer;

  Result := TStrings(AObj).IndexOfObject(TObject_sw.FromVar(AArgs[0]));
end;

function TStrings_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Insert(Index: Integer; const S: string);

  TStrings(AObj).Insert(Integer(AArgs[0]), string(AArgs[1]));
end;

function TStrings_InsertObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InsertObject(Index: Integer; const S: string; A...

  TStrings(AObj).InsertObject(Integer(AArgs[0]), string(AArgs[1]), TObject_sw.
    FromVar(AArgs[2]));
end;

function TStrings_LoadFromFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromFile(const FileName: string);

  TStrings(AObj).LoadFromFile(string(AArgs[0]));
end;

function TStrings_LoadFromStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromStream(Stream: TStream);

  TStrings(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]));
end;

function TStrings_Move_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Move(CurIndex: Integer; NewIndex: Integer);

  TStrings(AObj).Move(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TStrings_SaveToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToFile(const FileName: string);

  TStrings(AObj).SaveToFile(string(AArgs[0]));
end;

function TStrings_SaveToStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToStream(Stream: TStream);

  TStrings(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]));
end;

function TStrings_Capacity_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Capacity: Integer read <getter> write <setter>;

  if IsGet then
    Result := TStrings(AObj).Capacity
  else
    TStrings(AObj).Capacity := Integer(AArgs[0]);
end;

function TStrings_CommaText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CommaText: string read <getter> write <setter>;

  if IsGet then
    Result := TStrings(AObj).CommaText
  else
    TStrings(AObj).CommaText := string(AArgs[0]);
end;

function TStrings_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TStrings(AObj).Count;
end;

function TStrings_Delimiter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Delimiter: Char read <getter> write <setter>;

  if IsGet then
    Result := TStrings(AObj).Delimiter
  else
    TStrings(AObj).Delimiter := Char(Integer(AArgs[0]));
end;

function TStrings_DelimitedText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DelimitedText: string read <getter> write <setter>;

  if IsGet then
    Result := TStrings(AObj).DelimitedText
  else
    TStrings(AObj).DelimitedText := string(AArgs[0]);
end;

function TStrings_LineBreak_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LineBreak: string read <getter> write <setter>;

  if IsGet then
    Result := TStrings(AObj).LineBreak
  else
    TStrings(AObj).LineBreak := string(AArgs[0]);
end;

function TStrings_Names_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Names[Index: Integer]: string read <getter>;

  Result := TStrings(AObj).Names[Integer(AArgs[0])];
end;

function TStrings_Objects_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Objects[Index: Integer]: TObject read <getter> w...

  if IsGet then
    Result := TObject_sw.ToVar(TStrings(AObj).Objects[Integer(AArgs[0])])
  else
    TStrings(AObj).Objects[Integer(AArgs[0])] := TObject_sw.FromVar(AArgs[1]);
end;

function TStrings_QuoteChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property QuoteChar: Char read <getter> write <setter>;

  if IsGet then
    Result := TStrings(AObj).QuoteChar
  else
    TStrings(AObj).QuoteChar := Char(Integer(AArgs[0]));
end;

function TStrings_Values_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Values[const Name: string]: string read <getter>...

  if IsGet then
    Result := TStrings(AObj).Values[string(AArgs[0])]
  else
    TStrings(AObj).Values[string(AArgs[0])] := string(AArgs[1]);
end;

function TStrings_ValueFromIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ValueFromIndex[Index: Integer]: string read <get...

  if IsGet then
    Result := TStrings(AObj).ValueFromIndex[Integer(AArgs[0])]
  else
    TStrings(AObj).ValueFromIndex[Integer(AArgs[0])] := string(AArgs[1]);
end;

function TStrings_NameValueSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NameValueSeparator: Char read <getter> write <se...

  if IsGet then
    Result := TStrings(AObj).NameValueSeparator
  else
    TStrings(AObj).NameValueSeparator := Char(Integer(AArgs[0]));
end;

function TStrings_Strings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Strings[Index: Integer]: string read <getter> wr...

  if IsGet then
    Result := TStrings(AObj).Strings[Integer(AArgs[0])]
  else
    TStrings(AObj).Strings[Integer(AArgs[0])] := string(AArgs[1]);
end;

function TStrings_Text_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Text: string read <getter> write <setter>;

  if IsGet then
    Result := TStrings(AObj).Text
  else
    TStrings(AObj).Text := string(AArgs[0]);
end;

class function TStrings_sw.GetTypeName: WideString;
begin
  Result := 'TStrings';
end;

class function TStrings_sw.GetWrappedClass: TClass;
begin
  Result := TStrings;
end;

class procedure TStrings_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('UpdateCount', TStrings_UpdateCount_si, Integer_sw, True, False, 0, True);
  AData.AddFunction('Add', TStrings_Add_si, Integer_sw, 1, False);
  AData.AddFunction('AddObject', TStrings_AddObject_si, Integer_sw, 2, False);
  AData.AddProcedure('Append', TStrings_Append_si, 1, False);
  AData.AddProcedure('AddStrings', TStrings_AddStrings_si, 1, False);
  AData.AddProcedure('BeginUpdate', TStrings_BeginUpdate_si, 0, False);
  AData.AddProcedure('Clear', TStrings_Clear_si, 0, False);
  AData.AddProcedure('Delete', TStrings_Delete_si, 1, False);
  AData.AddProcedure('EndUpdate', TStrings_EndUpdate_si, 0, False);
  AData.AddFunction('Equals', TStrings_Equals_si, Boolean_sw, 1, False);
  AData.AddProcedure('Exchange', TStrings_Exchange_si, 2, False);
  AData.AddFunction('GetEnumerator', TStrings_GetEnumerator_si, TStringsEnumerator_sw, 0, False);
  AData.AddFunction('IndexOf', TStrings_IndexOf_si, Integer_sw, 1, False);
  AData.AddFunction('IndexOfName', TStrings_IndexOfName_si, Integer_sw, 1, False);
  AData.AddFunction('IndexOfObject', TStrings_IndexOfObject_si, Integer_sw, 1, False);
  AData.AddProcedure('Insert', TStrings_Insert_si, 2, False);
  AData.AddProcedure('InsertObject', TStrings_InsertObject_si, 3, False);
  AData.AddProcedure('LoadFromFile', TStrings_LoadFromFile_si, 1, False);
  AData.AddProcedure('LoadFromStream', TStrings_LoadFromStream_si, 1, False);
  AData.AddProcedure('Move', TStrings_Move_si, 2, False);
  AData.AddProcedure('SaveToFile', TStrings_SaveToFile_si, 1, False);
  AData.AddProcedure('SaveToStream', TStrings_SaveToStream_si, 1, False);
  AData.AddProperty('Capacity', TStrings_Capacity_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('CommaText', TStrings_CommaText_si, string_sw, True, True, 0, False);
  AData.AddProperty('Count', TStrings_Count_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('Delimiter', TStrings_Delimiter_si, Char_sw, True, True, 0, False);
  AData.AddProperty('DelimitedText', TStrings_DelimitedText_si, string_sw, True, True, 0, False);
  AData.AddProperty('LineBreak', TStrings_LineBreak_si, string_sw, True, True, 0, False);
  AData.AddProperty('Names', TStrings_Names_si, string_sw, True, False, 1, False);
  AData.AddProperty('Objects', TStrings_Objects_si, TObject_sw, True, True, 1, False);
  AData.AddProperty('QuoteChar', TStrings_QuoteChar_si, Char_sw, True, True, 0, False);
  AData.AddProperty('Values', TStrings_Values_si, string_sw, True, True, 1, False);
  AData.AddProperty('ValueFromIndex', TStrings_ValueFromIndex_si, string_sw, True, True, 1, False);
  AData.AddProperty('NameValueSeparator', TStrings_NameValueSeparator_si, Char_sw, True, True, 0, False);
  AData.AddProperty('Strings', TStrings_Strings_si, string_sw, True, True, 1, False);
  AData.AddProperty('Text', TStrings_Text_si, string_sw, True, True, 0, False);
end;

class function TStrings_sw.ToVar(const AValue: TStrings): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStrings_sw.FromVar(const AValue: OleVariant): TStrings;
begin
  Result := TStrings(ConvFromVar(AValue, TStrings));
end;

class function TStrings_sw.ClassToVar(AClass: TStrings_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStrings_sw.ClassFromVar(const AClass: OleVariant): TStrings_sc;
begin
  Result := TStrings_sc(ConvClsFromVar(AClass, TStrings));
end;

{ TStringItem_sw }

function TStringItem_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TStringItem_sw.ToVar(TStringItem(AObj));
end;

function TStringItem_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TStringItem_sw.Create as IDispatch;
end;

function TStringItem_FString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FString: string;

  if IsGet then
    Result := TStringItem_sw(AObj).FValue.FString
  else
    TStringItem_sw(AObj).FValue.FString := string(AArgs[0]);
end;

function TStringItem_FObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FObject: TObject;

  if IsGet then
    Result := TObject_sw.ToVar(TStringItem_sw(AObj).FValue.FObject)
  else
    TStringItem_sw(AObj).FValue.FObject := TObject_sw.FromVar(AArgs[0]);
end;

class function TStringItem_sw.GetTypeName: WideString;
begin
  Result := 'TStringItem';
end;

function TStringItem_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TStringItem_sw.Create;
  TStringItem_sw(Result).FValue := FValue;
end;

class procedure TStringItem_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TStringItem_Copy_si, TStringItem_sw, 0);
  AData.AddField('FString', TStringItem_FString_si, string_sw);
  AData.AddField('FObject', TStringItem_FObject_si, TObject_sw);

  { Class members }

  AData.AddConstructor('Create', TStringItem_Create_si, 0);
end;

class function TStringItem_sw.ToVar(const AValue: TStringItem): OleVariant;
var
  wrpr: TStringItem_sw;
begin
  wrpr        := TStringItem_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TStringItem_sw.FromVar(const AValue: OleVariant): TStringItem;
begin
  Result := TStringItem_sw(ConvFromVar(AValue)).FValue;
end;

{ TStringList_sw }

function TStringList_Find_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // function Find(const S: string; var Index: Integer): Boolean;

  v_1 := Integer(AArgs[1]);
  Result := TStringList(AObj).Find(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function TStringList_Sort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Sort;

  TStringList(AObj).Sort();
end;

function TStringList_Duplicates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Duplicates: TDuplicates read <getter> write <set...

  if IsGet then
    Result := TDuplicates_sw.ToVar(TStringList(AObj).Duplicates)
  else
    TStringList(AObj).Duplicates := TDuplicates_sw.FromVar(AArgs[0]);
end;

function TStringList_Sorted_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Sorted: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TStringList(AObj).Sorted
  else
    TStringList(AObj).Sorted := Boolean(AArgs[0]);
end;

function TStringList_CaseSensitive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CaseSensitive: Boolean read <getter> write <sett...

  if IsGet then
    Result := TStringList(AObj).CaseSensitive
  else
    TStringList(AObj).CaseSensitive := Boolean(AArgs[0]);
end;

function TStringList_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TStringList(AObj).OnChange)
  else
    TStringList(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TStringList_OnChanging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChanging: TNotifyEvent read <getter> write <se...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TStringList(AObj).OnChanging)
  else
    TStringList(AObj).OnChanging := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TStringList_sw.GetTypeName: WideString;
begin
  Result := 'TStringList';
end;

class function TStringList_sw.GetWrappedClass: TClass;
begin
  Result := TStringList;
end;

class procedure TStringList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Find', TStringList_Find_si, Boolean_sw, 2, False);
  AData.AddProcedure('Sort', TStringList_Sort_si, 0, False);
  AData.AddProperty('Duplicates', TStringList_Duplicates_si, TDuplicates_sw, True, True, 0, False);
  AData.AddProperty('Sorted', TStringList_Sorted_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('CaseSensitive', TStringList_CaseSensitive_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('OnChange', TStringList_OnChange_si, TNotifyEvent_sw, True, True, 0, False);
  AData.AddProperty('OnChanging', TStringList_OnChanging_si, TNotifyEvent_sw, True, True, 0, False);
end;

class function TStringList_sw.ToVar(const AValue: TStringList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStringList_sw.FromVar(const AValue: OleVariant): TStringList;
begin
  Result := TStringList(ConvFromVar(AValue, TStringList));
end;

class function TStringList_sw.ClassToVar(AClass: TStringList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStringList_sw.ClassFromVar(
  const AClass: OleVariant): TStringList_sc;
begin
  Result := TStringList_sc(ConvClsFromVar(AClass, TStringList));
end;

{ TStream_sw }

function TStream_Seek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Seek(const Offset: Int64; Origin: TSeekOrigin): ...

  Result := Int64_sw.ToVar(TStream(AObj).Seek(Int64_sw.FromVar(AArgs[0]), 
    TSeekOrigin_sw.FromVar(AArgs[1])));
end;

function TStream_CopyFrom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CopyFrom(Source: TStream; Count: Int64): Int64;

  Result := Int64_sw.ToVar(TStream(AObj).CopyFrom(TStream_sw.FromVar(AArgs[0]), 
    Int64_sw.FromVar(AArgs[1])));
end;

function TStream_ReadComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadComponent(Instance: TComponent): TComponent;

  Result := TComponent_sw.ToVar(TStream(AObj).ReadComponent(TComponent_sw.
    FromVar(AArgs[0])));
end;

function TStream_ReadComponentRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadComponentRes(Instance: TComponent): TComponent;

  Result := TComponent_sw.ToVar(TStream(AObj).ReadComponentRes(TComponent_sw.
    FromVar(AArgs[0])));
end;

function TStream_WriteComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteComponent(Instance: TComponent);

  TStream(AObj).WriteComponent(TComponent_sw.FromVar(AArgs[0]));
end;

function TStream_WriteComponentRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteComponentRes(const ResName: string; Instan...

  TStream(AObj).WriteComponentRes(string(AArgs[0]), TComponent_sw.FromVar(
    AArgs[1]));
end;

function TStream_WriteDescendent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteDescendent(Instance: TComponent; Ancestor:...

  TStream(AObj).WriteDescendent(TComponent_sw.FromVar(AArgs[0]), TComponent_sw.
    FromVar(AArgs[1]));
end;

function TStream_WriteDescendentRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteDescendentRes(const ResName: string; Insta...

  TStream(AObj).WriteDescendentRes(string(AArgs[0]), TComponent_sw.FromVar(
    AArgs[1]), TComponent_sw.FromVar(AArgs[2]));
end;

function TStream_WriteResourceHeader_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // procedure WriteResourceHeader(const ResName: string; out ...

  TStream(AObj).WriteResourceHeader(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function TStream_FixupResourceHeader_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FixupResourceHeader(FixupInfo: Integer);

  TStream(AObj).FixupResourceHeader(Integer(AArgs[0]));
end;

function TStream_ReadResHeader_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ReadResHeader;

  TStream(AObj).ReadResHeader();
end;

function TStream_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Position: Int64 read <getter> write <setter>;

  if IsGet then
    Result := Int64_sw.ToVar(TStream(AObj).Position)
  else
    TStream(AObj).Position := Int64_sw.FromVar(AArgs[0]);
end;

function TStream_Size_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Size: Int64 read <getter> write <setter>;

  if IsGet then
    Result := Int64_sw.ToVar(TStream(AObj).Size)
  else
    TStream(AObj).Size := Int64_sw.FromVar(AArgs[0]);
end;

class function TStream_sw.GetTypeName: WideString;
begin
  Result := 'TStream';
end;

class function TStream_sw.GetWrappedClass: TClass;
begin
  Result := TStream;
end;

class procedure TStream_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Seek', TStream_Seek_si, Int64_sw, 2, False);
  AData.AddFunction('CopyFrom', TStream_CopyFrom_si, Int64_sw, 2, False);
  AData.AddFunction('ReadComponent', TStream_ReadComponent_si, TComponent_sw, 1, False);
  AData.AddFunction('ReadComponentRes', TStream_ReadComponentRes_si, TComponent_sw, 1, False);
  AData.AddProcedure('WriteComponent', TStream_WriteComponent_si, 1, False);
  AData.AddProcedure('WriteComponentRes', TStream_WriteComponentRes_si, 2, False);
  AData.AddProcedure('WriteDescendent', TStream_WriteDescendent_si, 2, False);
  AData.AddProcedure('WriteDescendentRes', TStream_WriteDescendentRes_si, 3, False);
  AData.AddProcedure('WriteResourceHeader', TStream_WriteResourceHeader_si, 2, False);
  AData.AddProcedure('FixupResourceHeader', TStream_FixupResourceHeader_si, 1, False);
  AData.AddProcedure('ReadResHeader', TStream_ReadResHeader_si, 0, False);
  AData.AddProperty('Position', TStream_Position_si, Int64_sw, True, True, 0, False);
  AData.AddProperty('Size', TStream_Size_si, Int64_sw, True, True, 0, False);
end;

class function TStream_sw.ToVar(const AValue: TStream): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStream_sw.FromVar(const AValue: OleVariant): TStream;
begin
  Result := TStream(ConvFromVar(AValue, TStream));
end;

class function TStream_sw.ClassToVar(AClass: TStream_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStream_sw.ClassFromVar(const AClass: OleVariant): TStream_sc;
begin
  Result := TStream_sc(ConvClsFromVar(AClass, TStream));
end;

{ THandleStream_sw }

function THandleStream_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AHandle: Integer);

  Result := THandleStream_sw.ToVar(THandleStream_sc(AObj).Create(Integer(
    AArgs[0])));
end;

function THandleStream_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: Integer read <getter>;

  Result := THandleStream(AObj).Handle;
end;

class function THandleStream_sw.GetTypeName: WideString;
begin
  Result := 'THandleStream';
end;

class function THandleStream_sw.GetWrappedClass: TClass;
begin
  Result := THandleStream;
end;

class procedure THandleStream_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Handle', THandleStream_Handle_si, Integer_sw, True, False, 0, False);

  { Class members }

  AData.AddConstructor('Create', THandleStream_Create_si, 1, False);
end;

class function THandleStream_sw.ToVar(const AValue: THandleStream): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THandleStream_sw.FromVar(
  const AValue: OleVariant): THandleStream;
begin
  Result := THandleStream(ConvFromVar(AValue, THandleStream));
end;

class function THandleStream_sw.ClassToVar(
  AClass: THandleStream_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THandleStream_sw.ClassFromVar(
  const AClass: OleVariant): THandleStream_sc;
begin
  Result := THandleStream_sc(ConvClsFromVar(AClass, THandleStream));
end;

{ TFileStream_sw }

function TFileStream_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(const FileName: string; Mode: Word);

  Result := TFileStream_sw.ToVar(TFileStream_sc(AObj).Create(string(AArgs[0]), 
    Word(AArgs[1])));
end;

class function TFileStream_sw.GetTypeName: WideString;
begin
  Result := 'TFileStream';
end;

class function TFileStream_sw.GetWrappedClass: TClass;
begin
  Result := TFileStream;
end;

class procedure TFileStream_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TFileStream_Create_si, 2, False);
end;

class function TFileStream_sw.ToVar(const AValue: TFileStream): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFileStream_sw.FromVar(const AValue: OleVariant): TFileStream;
begin
  Result := TFileStream(ConvFromVar(AValue, TFileStream));
end;

class function TFileStream_sw.ClassToVar(AClass: TFileStream_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFileStream_sw.ClassFromVar(
  const AClass: OleVariant): TFileStream_sc;
begin
  Result := TFileStream_sc(ConvClsFromVar(AClass, TFileStream));
end;

{ TCustomMemoryStream_sw }

function TCustomMemoryStream_SaveToStream_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToStream(Stream: TStream);

  TCustomMemoryStream(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]));
end;

function TCustomMemoryStream_SaveToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToFile(const FileName: string);

  TCustomMemoryStream(AObj).SaveToFile(string(AArgs[0]));
end;

class function TCustomMemoryStream_sw.GetTypeName: WideString;
begin
  Result := 'TCustomMemoryStream';
end;

class function TCustomMemoryStream_sw.GetWrappedClass: TClass;
begin
  Result := TCustomMemoryStream;
end;

class procedure TCustomMemoryStream_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('SaveToStream', TCustomMemoryStream_SaveToStream_si, 1, False);
  AData.AddProcedure('SaveToFile', TCustomMemoryStream_SaveToFile_si, 1, False);
end;

class function TCustomMemoryStream_sw.ToVar(
  const AValue: TCustomMemoryStream): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomMemoryStream_sw.FromVar(
  const AValue: OleVariant): TCustomMemoryStream;
begin
  Result := TCustomMemoryStream(ConvFromVar(AValue, TCustomMemoryStream));
end;

class function TCustomMemoryStream_sw.ClassToVar(
  AClass: TCustomMemoryStream_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomMemoryStream_sw.ClassFromVar(
  const AClass: OleVariant): TCustomMemoryStream_sc;
begin
  Result := TCustomMemoryStream_sc(ConvClsFromVar(AClass, TCustomMemoryStream));
end;

{ TMemoryStream_sw }

function TMemoryStream_Capacity_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Capacity: Longint read <getter> write ...

  if IsGet then
    Result := TMemoryStream_sacc(TMemoryStream(AObj)).Capacity
  else
    TMemoryStream_sacc(TMemoryStream(AObj)).Capacity := Longint(AArgs[0]);
end;

function TMemoryStream_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TMemoryStream(AObj).Clear();
end;

function TMemoryStream_LoadFromStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromStream(Stream: TStream);

  TMemoryStream(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]));
end;

function TMemoryStream_LoadFromFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromFile(const FileName: string);

  TMemoryStream(AObj).LoadFromFile(string(AArgs[0]));
end;

class function TMemoryStream_sw.GetTypeName: WideString;
begin
  Result := 'TMemoryStream';
end;

class function TMemoryStream_sw.GetWrappedClass: TClass;
begin
  Result := TMemoryStream;
end;

class procedure TMemoryStream_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Capacity', TMemoryStream_Capacity_si, Longint_sw, True, True, 0, True);
  AData.AddProcedure('Clear', TMemoryStream_Clear_si, 0, False);
  AData.AddProcedure('LoadFromStream', TMemoryStream_LoadFromStream_si, 1, False);
  AData.AddProcedure('LoadFromFile', TMemoryStream_LoadFromFile_si, 1, False);
end;

class function TMemoryStream_sw.ToVar(const AValue: TMemoryStream): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMemoryStream_sw.FromVar(
  const AValue: OleVariant): TMemoryStream;
begin
  Result := TMemoryStream(ConvFromVar(AValue, TMemoryStream));
end;

class function TMemoryStream_sw.ClassToVar(
  AClass: TMemoryStream_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMemoryStream_sw.ClassFromVar(
  const AClass: OleVariant): TMemoryStream_sc;
begin
  Result := TMemoryStream_sc(ConvClsFromVar(AClass, TMemoryStream));
end;

{ TStringStream_sw }

function TStringStream_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(const AString: string);

  Result := TStringStream_sw.ToVar(TStringStream_sc(AObj).Create(string(
    AArgs[0])));
end;

function TStringStream_ReadString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadString(Count: Longint): string;

  Result := TStringStream(AObj).ReadString(Longint(AArgs[0]));
end;

function TStringStream_WriteString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteString(const AString: string);

  TStringStream(AObj).WriteString(string(AArgs[0]));
end;

function TStringStream_DataString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataString: string read <getter>;

  Result := TStringStream(AObj).DataString;
end;

class function TStringStream_sw.GetTypeName: WideString;
begin
  Result := 'TStringStream';
end;

class function TStringStream_sw.GetWrappedClass: TClass;
begin
  Result := TStringStream;
end;

class procedure TStringStream_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('ReadString', TStringStream_ReadString_si, string_sw, 1, False);
  AData.AddProcedure('WriteString', TStringStream_WriteString_si, 1, False);
  AData.AddProperty('DataString', TStringStream_DataString_si, string_sw, True, False, 0, False);

  { Class members }

  AData.AddConstructor('Create', TStringStream_Create_si, 1, False);
end;

class function TStringStream_sw.ToVar(const AValue: TStringStream): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStringStream_sw.FromVar(
  const AValue: OleVariant): TStringStream;
begin
  Result := TStringStream(ConvFromVar(AValue, TStringStream));
end;

class function TStringStream_sw.ClassToVar(
  AClass: TStringStream_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStringStream_sw.ClassFromVar(
  const AClass: OleVariant): TStringStream_sc;
begin
  Result := TStringStream_sc(ConvClsFromVar(AClass, TStringStream));
end;

{ TResourceStream_sw }

class function TResourceStream_sw.GetTypeName: WideString;
begin
  Result := 'TResourceStream';
end;

class function TResourceStream_sw.GetWrappedClass: TClass;
begin
  Result := TResourceStream;
end;

class procedure TResourceStream_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TResourceStream_sw.ToVar(
  const AValue: TResourceStream): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TResourceStream_sw.FromVar(
  const AValue: OleVariant): TResourceStream;
begin
  Result := TResourceStream(ConvFromVar(AValue, TResourceStream));
end;

class function TResourceStream_sw.ClassToVar(
  AClass: TResourceStream_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TResourceStream_sw.ClassFromVar(
  const AClass: OleVariant): TResourceStream_sc;
begin
  Result := TResourceStream_sc(ConvClsFromVar(AClass, TResourceStream));
end;

{ TStreamOwnership_sw }

class function TStreamOwnership_sw.GetTypeName: WideString;
begin
  Result := 'TStreamOwnership';
end;

class function TStreamOwnership_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TStreamOwnership);
end;

class function TStreamOwnership_sw.ToVar(
  const AValue: TStreamOwnership): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TStreamOwnership_sw.FromVar(
  const AValue: OleVariant): TStreamOwnership;
begin
  Result := TStreamOwnership(Integer(AValue));
end;

{ TStreamAdapter_sw }

function TStreamAdapter_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Stream: TStream; Ownership: TStreamOwn...

  Result := TStreamAdapter_sw.ToVar(TStreamAdapter_sc(AObj).Create(TStream_sw.
    FromVar(AArgs[0]), TStreamOwnership_sw.FromVar(AArgs[1])));
end;

function TStreamAdapter_Commit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Commit(grfCommitFlags: Longint): HResult;

  Result := HResult_sw.ToVar(TStreamAdapter(AObj).Commit(Longint(AArgs[0])));
end;

function TStreamAdapter_Revert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Revert: HResult;

  Result := HResult_sw.ToVar(TStreamAdapter(AObj).Revert());
end;

function TStreamAdapter_Stream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Stream: TStream read <getter>;

  Result := TStream_sw.ToVar(TStreamAdapter(AObj).Stream);
end;

function TStreamAdapter_StreamOwnership_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StreamOwnership: TStreamOwnership read <getter> ...

  if IsGet then
    Result := TStreamOwnership_sw.ToVar(TStreamAdapter(AObj).StreamOwnership)
  else
    TStreamAdapter(AObj).StreamOwnership := TStreamOwnership_sw.FromVar(
      AArgs[0]);
end;

class function TStreamAdapter_sw.GetTypeName: WideString;
begin
  Result := 'TStreamAdapter';
end;

class function TStreamAdapter_sw.GetWrappedClass: TClass;
begin
  Result := TStreamAdapter;
end;

class procedure TStreamAdapter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Commit', TStreamAdapter_Commit_si, HResult_sw, 1, False);
  AData.AddFunction('Revert', TStreamAdapter_Revert_si, HResult_sw, 0, False);
  AData.AddProperty('Stream', TStreamAdapter_Stream_si, TStream_sw, True, False, 0, False);
  AData.AddProperty('StreamOwnership', TStreamAdapter_StreamOwnership_si, TStreamOwnership_sw, True, True, 0, False);

  { Class members }

  AData.AddConstructor('Create', TStreamAdapter_Create_si, 2, False);
end;

class function TStreamAdapter_sw.ToVar(
  const AValue: TStreamAdapter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStreamAdapter_sw.FromVar(
  const AValue: OleVariant): TStreamAdapter;
begin
  Result := TStreamAdapter(ConvFromVar(AValue, TStreamAdapter));
end;

class function TStreamAdapter_sw.ClassToVar(
  AClass: TStreamAdapter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStreamAdapter_sw.ClassFromVar(
  const AClass: OleVariant): TStreamAdapter_sc;
begin
  Result := TStreamAdapter_sc(ConvClsFromVar(AClass, TStreamAdapter));
end;

{ TGetClass_sh }

function TGetClass_sh.GetHandler: TMethod;
var
  hdr: TGetClass;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetClass_sh.Handler(AClass: TPersistentClass);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (AClass: TPersistentClass) of object

  args[0] := TPersistentClass_sw.ToVar(AClass);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TGetClass_sw }

class function TGetClass_sw.GetTypeName: WideString;
begin
  Result := 'TGetClass';
end;

class function TGetClass_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetClass_sh;
end;

class function TGetClass_sw.ToVar(const AValue: TGetClass): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetClass_sw.FromVar(const AValue: OleVariant): TGetClass;
begin
  Result := TGetClass(ConvFromVar(AValue));
end;

class function TGetClass_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetClass;
var
  hdlr: TGetClass_sh;
begin
  hdlr   := TGetClass_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetClass_sw));
  Result := hdlr.Handler;
end;

{ TClassFinder_sw }

function TClassFinder_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AClass: TPersistentClass; AIncludeActi...

  Result := TClassFinder_sw.ToVar(TClassFinder_sc(AObj).Create(
    TPersistentClass_sw.FromVar(AArgs[0]), Boolean(AArgs[1])));
end;

function TClassFinder_GetClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetClass(const AClassName: string): TPersistentC...

  Result := TPersistentClass_sw.ToVar(TClassFinder(AObj).GetClass(string(
    AArgs[0])));
end;

function TClassFinder_GetClasses_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetClasses(Proc: TGetClass);

  TClassFinder(AObj).GetClasses(TGetClass_sw.FromVar(AArgs[0]));
end;

class function TClassFinder_sw.GetTypeName: WideString;
begin
  Result := 'TClassFinder';
end;

class function TClassFinder_sw.GetWrappedClass: TClass;
begin
  Result := TClassFinder;
end;

class procedure TClassFinder_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetClass', TClassFinder_GetClass_si, TPersistentClass_sw, 1, False);
  AData.AddProcedure('GetClasses', TClassFinder_GetClasses_si, 1, False);

  { Class members }

  AData.AddConstructor('Create', TClassFinder_Create_si, 2, False);
end;

class function TClassFinder_sw.ToVar(const AValue: TClassFinder): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TClassFinder_sw.FromVar(const AValue: OleVariant): TClassFinder;
begin
  Result := TClassFinder(ConvFromVar(AValue, TClassFinder));
end;

class function TClassFinder_sw.ClassToVar(AClass: TClassFinder_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TClassFinder_sw.ClassFromVar(
  const AClass: OleVariant): TClassFinder_sc;
begin
  Result := TClassFinder_sc(ConvClsFromVar(AClass, TClassFinder));
end;

{ TValueType_sw }

class function TValueType_sw.GetTypeName: WideString;
begin
  Result := 'TValueType';
end;

class function TValueType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TValueType);
end;

class function TValueType_sw.ToVar(const AValue: TValueType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TValueType_sw.FromVar(const AValue: OleVariant): TValueType;
begin
  Result := TValueType(Integer(AValue));
end;

{ TFilerFlag_sw }

class function TFilerFlag_sw.GetTypeName: WideString;
begin
  Result := 'TFilerFlag';
end;

class function TFilerFlag_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TFilerFlag);
end;

class function TFilerFlag_sw.ToVar(const AValue: TFilerFlag): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFilerFlag_sw.FromVar(const AValue: OleVariant): TFilerFlag;
begin
  Result := TFilerFlag(Integer(AValue));
end;

{ TFilerFlags_sw }

class function TFilerFlags_sw.GetTypeName: WideString;
begin
  Result := 'TFilerFlags';
end;

class function TFilerFlags_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFilerFlags);
end;

class function TFilerFlags_sw.ToVar(const AValue: TFilerFlags): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFilerFlags_sw.FromVar(const AValue: OleVariant): TFilerFlags;
begin
  ConvFromVar(AValue, @Result);
end;

{ TReaderProc_sh }

function TReaderProc_sh.GetHandler: TMethod;
var
  hdr: TReaderProc;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TReaderProc_sh.Handler(Reader: TReader);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (Reader: TReader) of object

  args[0] := TReader_sw.ToVar(Reader);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TReaderProc_sw }

class function TReaderProc_sw.GetTypeName: WideString;
begin
  Result := 'TReaderProc';
end;

class function TReaderProc_sw.GetScriptHandlerClass: TClass;
begin
  Result := TReaderProc_sh;
end;

class function TReaderProc_sw.ToVar(const AValue: TReaderProc): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TReaderProc_sw.FromVar(const AValue: OleVariant): TReaderProc;
begin
  Result := TReaderProc(ConvFromVar(AValue));
end;

class function TReaderProc_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TReaderProc;
var
  hdlr: TReaderProc_sh;
begin
  hdlr   := TReaderProc_sh(AScriptControl.GetEventHandler(AProcName, 
    TReaderProc_sw));
  Result := hdlr.Handler;
end;

{ TWriterProc_sh }

function TWriterProc_sh.GetHandler: TMethod;
var
  hdr: TWriterProc;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TWriterProc_sh.Handler(Writer: TWriter);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (Writer: TWriter) of object

  args[0] := TWriter_sw.ToVar(Writer);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TWriterProc_sw }

class function TWriterProc_sw.GetTypeName: WideString;
begin
  Result := 'TWriterProc';
end;

class function TWriterProc_sw.GetScriptHandlerClass: TClass;
begin
  Result := TWriterProc_sh;
end;

class function TWriterProc_sw.ToVar(const AValue: TWriterProc): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TWriterProc_sw.FromVar(const AValue: OleVariant): TWriterProc;
begin
  Result := TWriterProc(ConvFromVar(AValue));
end;

class function TWriterProc_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TWriterProc;
var
  hdlr: TWriterProc_sh;
begin
  hdlr   := TWriterProc_sh(AScriptControl.GetEventHandler(AProcName, 
    TWriterProc_sw));
  Result := hdlr.Handler;
end;

{ TStreamProc_sh }

function TStreamProc_sh.GetHandler: TMethod;
var
  hdr: TStreamProc;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TStreamProc_sh.Handler(Stream: TStream);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (Stream: TStream) of object

  args[0] := TStream_sw.ToVar(Stream);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TStreamProc_sw }

class function TStreamProc_sw.GetTypeName: WideString;
begin
  Result := 'TStreamProc';
end;

class function TStreamProc_sw.GetScriptHandlerClass: TClass;
begin
  Result := TStreamProc_sh;
end;

class function TStreamProc_sw.ToVar(const AValue: TStreamProc): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TStreamProc_sw.FromVar(const AValue: OleVariant): TStreamProc;
begin
  Result := TStreamProc(ConvFromVar(AValue));
end;

class function TStreamProc_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TStreamProc;
var
  hdlr: TStreamProc_sh;
begin
  hdlr   := TStreamProc_sh(AScriptControl.GetEventHandler(AProcName, 
    TStreamProc_sw));
  Result := hdlr.Handler;
end;

{ TFiler_sw }

function TFiler_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Stream: TStream; BufSize: Integer);

  Result := TFiler_sw.ToVar(TFiler_sc(AObj).Create(TStream_sw.FromVar(AArgs[0]),
    Integer(AArgs[1])));
end;

function TFiler_DefineProperty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DefineProperty(const Name: string; ReadData: TR...

  TFiler(AObj).DefineProperty(string(AArgs[0]), TReaderProc_sw.FromVar(
    AArgs[1]), TWriterProc_sw.FromVar(AArgs[2]), Boolean(AArgs[3]));
end;

function TFiler_DefineBinaryProperty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DefineBinaryProperty(const Name: string; ReadDa...

  TFiler(AObj).DefineBinaryProperty(string(AArgs[0]), TStreamProc_sw.FromVar(
    AArgs[1]), TStreamProc_sw.FromVar(AArgs[2]), Boolean(AArgs[3]));
end;

function TFiler_FlushBuffer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FlushBuffer;

  TFiler(AObj).FlushBuffer();
end;

function TFiler_Root_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Root: TComponent read <getter> write <setter>;

  if IsGet then
    Result := TComponent_sw.ToVar(TFiler(AObj).Root)
  else
    TFiler(AObj).Root := TComponent_sw.FromVar(AArgs[0]);
end;

function TFiler_LookupRoot_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LookupRoot: TComponent read <getter>;

  Result := TComponent_sw.ToVar(TFiler(AObj).LookupRoot);
end;

function TFiler_Ancestor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Ancestor: TPersistent read <getter> write <setter>;

  if IsGet then
    Result := TPersistent_sw.ToVar(TFiler(AObj).Ancestor)
  else
    TFiler(AObj).Ancestor := TPersistent_sw.FromVar(AArgs[0]);
end;

function TFiler_IgnoreChildren_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IgnoreChildren: Boolean read <getter> write <set...

  if IsGet then
    Result := TFiler(AObj).IgnoreChildren
  else
    TFiler(AObj).IgnoreChildren := Boolean(AArgs[0]);
end;

class function TFiler_sw.GetTypeName: WideString;
begin
  Result := 'TFiler';
end;

class function TFiler_sw.GetWrappedClass: TClass;
begin
  Result := TFiler;
end;

class procedure TFiler_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('DefineProperty', TFiler_DefineProperty_si, 4, False);
  AData.AddProcedure('DefineBinaryProperty', TFiler_DefineBinaryProperty_si, 4, False);
  AData.AddProcedure('FlushBuffer', TFiler_FlushBuffer_si, 0, False);
  AData.AddProperty('Root', TFiler_Root_si, TComponent_sw, True, True, 0, False);
  AData.AddProperty('LookupRoot', TFiler_LookupRoot_si, TComponent_sw, True, False, 0, False);
  AData.AddProperty('Ancestor', TFiler_Ancestor_si, TPersistent_sw, True, True, 0, False);
  AData.AddProperty('IgnoreChildren', TFiler_IgnoreChildren_si, Boolean_sw, True, True, 0, False);

  { Class members }

  AData.AddConstructor('Create', TFiler_Create_si, 2, False);
end;

class function TFiler_sw.ToVar(const AValue: TFiler): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFiler_sw.FromVar(const AValue: OleVariant): TFiler;
begin
  Result := TFiler(ConvFromVar(AValue, TFiler));
end;

class function TFiler_sw.ClassToVar(AClass: TFiler_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFiler_sw.ClassFromVar(const AClass: OleVariant): TFiler_sc;
begin
  Result := TFiler_sc(ConvClsFromVar(AClass, TFiler));
end;

{ TComponentClass_sw }

class function TComponentClass_sw.GetTypeName: WideString;
begin
  Result := 'TComponentClass';
end;

class function TComponentClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TComponent;
end;

class function TComponentClass_sw.ToVar(
  const AValue: TComponentClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComponentClass_sw.FromVar(
  const AValue: OleVariant): TComponentClass;
begin
  Result := TComponentClass(ConvFromVar(AValue, TComponent));
end;

{ TSetNameEvent_sh }

function TSetNameEvent_sh.GetHandler: TMethod;
var
  hdr: TSetNameEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TSetNameEvent_sh.Handler(Reader: TReader; Component: TComponent;
  var Name: string);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Reader: TReader; Component: TComponent; var Na...

  v_1 := Name;
  args[0] := TReader_sw.ToVar(Reader);
  args[1] := TComponent_sw.ToVar(Component);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Name := string(v_1);
end;

{ TSetNameEvent_sw }

class function TSetNameEvent_sw.GetTypeName: WideString;
begin
  Result := 'TSetNameEvent';
end;

class function TSetNameEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TSetNameEvent_sh;
end;

class function TSetNameEvent_sw.ToVar(const AValue: TSetNameEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TSetNameEvent_sw.FromVar(
  const AValue: OleVariant): TSetNameEvent;
begin
  Result := TSetNameEvent(ConvFromVar(AValue));
end;

class function TSetNameEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TSetNameEvent;
var
  hdlr: TSetNameEvent_sh;
begin
  hdlr   := TSetNameEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TSetNameEvent_sw));
  Result := hdlr.Handler;
end;

{ TReferenceNameEvent_sh }

function TReferenceNameEvent_sh.GetHandler: TMethod;
var
  hdr: TReferenceNameEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TReferenceNameEvent_sh.Handler(Reader: TReader; var Name: string);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Reader: TReader; var Name: string) of object

  v_1 := Name;
  args[0] := TReader_sw.ToVar(Reader);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Name := string(v_1);
end;

{ TReferenceNameEvent_sw }

class function TReferenceNameEvent_sw.GetTypeName: WideString;
begin
  Result := 'TReferenceNameEvent';
end;

class function TReferenceNameEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TReferenceNameEvent_sh;
end;

class function TReferenceNameEvent_sw.ToVar(
  const AValue: TReferenceNameEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TReferenceNameEvent_sw.FromVar(
  const AValue: OleVariant): TReferenceNameEvent;
begin
  Result := TReferenceNameEvent(ConvFromVar(AValue));
end;

class function TReferenceNameEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TReferenceNameEvent;
var
  hdlr: TReferenceNameEvent_sh;
begin
  hdlr   := TReferenceNameEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TReferenceNameEvent_sw));
  Result := hdlr.Handler;
end;

{ TAncestorNotFoundEvent_sh }

function TAncestorNotFoundEvent_sh.GetHandler: TMethod;
var
  hdr: TAncestorNotFoundEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TAncestorNotFoundEvent_sh.Handler(Reader: TReader;
  const ComponentName: string; ComponentClass: TPersistentClass;
  var Component: TComponent);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Reader: TReader; const ComponentName: string; ...

  v_1 := TComponent_sw.ToVar(Component);
  args[0] := TReader_sw.ToVar(Reader);
  args[1] := ComponentName;
  args[2] := TPersistentClass_sw.ToVar(ComponentClass);
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Component := TComponent_sw.FromVar(v_1);
end;

{ TAncestorNotFoundEvent_sw }

class function TAncestorNotFoundEvent_sw.GetTypeName: WideString;
begin
  Result := 'TAncestorNotFoundEvent';
end;

class function TAncestorNotFoundEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TAncestorNotFoundEvent_sh;
end;

class function TAncestorNotFoundEvent_sw.ToVar(
  const AValue: TAncestorNotFoundEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TAncestorNotFoundEvent_sw.FromVar(
  const AValue: OleVariant): TAncestorNotFoundEvent;
begin
  Result := TAncestorNotFoundEvent(ConvFromVar(AValue));
end;

class function TAncestorNotFoundEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TAncestorNotFoundEvent;
var
  hdlr: TAncestorNotFoundEvent_sh;
begin
  hdlr   := TAncestorNotFoundEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TAncestorNotFoundEvent_sw));
  Result := hdlr.Handler;
end;

{ TReadComponentsProc_sh }

function TReadComponentsProc_sh.GetHandler: TMethod;
var
  hdr: TReadComponentsProc;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TReadComponentsProc_sh.Handler(Component: TComponent);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (Component: TComponent) of object

  args[0] := TComponent_sw.ToVar(Component);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TReadComponentsProc_sw }

class function TReadComponentsProc_sw.GetTypeName: WideString;
begin
  Result := 'TReadComponentsProc';
end;

class function TReadComponentsProc_sw.GetScriptHandlerClass: TClass;
begin
  Result := TReadComponentsProc_sh;
end;

class function TReadComponentsProc_sw.ToVar(
  const AValue: TReadComponentsProc): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TReadComponentsProc_sw.FromVar(
  const AValue: OleVariant): TReadComponentsProc;
begin
  Result := TReadComponentsProc(ConvFromVar(AValue));
end;

class function TReadComponentsProc_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TReadComponentsProc;
var
  hdlr: TReadComponentsProc_sh;
begin
  hdlr   := TReadComponentsProc_sh(AScriptControl.GetEventHandler(AProcName, 
    TReadComponentsProc_sw));
  Result := hdlr.Handler;
end;

{ TReaderError_sh }

function TReaderError_sh.GetHandler: TMethod;
var
  hdr: TReaderError;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TReaderError_sh.Handler(Reader: TReader; const Message: string;
  var Handled: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Reader: TReader; const Message: string; var Ha...

  v_1 := Handled;
  args[0] := TReader_sw.ToVar(Reader);
  args[1] := Message;
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Handled := Boolean(v_1);
end;

{ TReaderError_sw }

class function TReaderError_sw.GetTypeName: WideString;
begin
  Result := 'TReaderError';
end;

class function TReaderError_sw.GetScriptHandlerClass: TClass;
begin
  Result := TReaderError_sh;
end;

class function TReaderError_sw.ToVar(const AValue: TReaderError): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TReaderError_sw.FromVar(const AValue: OleVariant): TReaderError;
begin
  Result := TReaderError(ConvFromVar(AValue));
end;

class function TReaderError_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TReaderError;
var
  hdlr: TReaderError_sh;
begin
  hdlr   := TReaderError_sh(AScriptControl.GetEventHandler(AProcName, 
    TReaderError_sw));
  Result := hdlr.Handler;
end;

{ TFindComponentClassEvent_sh }

function TFindComponentClassEvent_sh.GetHandler: TMethod;
var
  hdr: TFindComponentClassEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFindComponentClassEvent_sh.Handler(Reader: TReader;
  const ClassName: string; var ComponentClass: TComponentClass);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Reader: TReader; const ClassName: string; var ...

  v_1 := TComponentClass_sw.ToVar(ComponentClass);
  args[0] := TReader_sw.ToVar(Reader);
  args[1] := ClassName;
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  ComponentClass := TComponentClass_sw.FromVar(v_1);
end;

{ TFindComponentClassEvent_sw }

class function TFindComponentClassEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFindComponentClassEvent';
end;

class function TFindComponentClassEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFindComponentClassEvent_sh;
end;

class function TFindComponentClassEvent_sw.ToVar(
  const AValue: TFindComponentClassEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFindComponentClassEvent_sw.FromVar(
  const AValue: OleVariant): TFindComponentClassEvent;
begin
  Result := TFindComponentClassEvent(ConvFromVar(AValue));
end;

class function TFindComponentClassEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TFindComponentClassEvent;
var
  hdlr: TFindComponentClassEvent_sh;
begin
  hdlr   := TFindComponentClassEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TFindComponentClassEvent_sw));
  Result := hdlr.Handler;
end;

{ TCreateComponentEvent_sh }

function TCreateComponentEvent_sh.GetHandler: TMethod;
var
  hdr: TCreateComponentEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TCreateComponentEvent_sh.Handler(Reader: TReader;
  ComponentClass: TComponentClass; var Component: TComponent);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Reader: TReader; ComponentClass: TComponentCla...

  v_1 := TComponent_sw.ToVar(Component);
  args[0] := TReader_sw.ToVar(Reader);
  args[1] := TComponentClass_sw.ToVar(ComponentClass);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Component := TComponent_sw.FromVar(v_1);
end;

{ TCreateComponentEvent_sw }

class function TCreateComponentEvent_sw.GetTypeName: WideString;
begin
  Result := 'TCreateComponentEvent';
end;

class function TCreateComponentEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TCreateComponentEvent_sh;
end;

class function TCreateComponentEvent_sw.ToVar(
  const AValue: TCreateComponentEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TCreateComponentEvent_sw.FromVar(
  const AValue: OleVariant): TCreateComponentEvent;
begin
  Result := TCreateComponentEvent(ConvFromVar(AValue));
end;

class function TCreateComponentEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TCreateComponentEvent;
var
  hdlr: TCreateComponentEvent_sh;
begin
  hdlr   := TCreateComponentEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TCreateComponentEvent_sw));
  Result := hdlr.Handler;
end;

{ TReader_sw }

function TReader_PropName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property PropName: string read <getter>;

  Result := TReader_sacc(TReader(AObj)).PropName;
end;

function TReader_CanHandleExceptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CanHandleExceptions: Boolean read <get...

  Result := TReader_sacc(TReader(AObj)).CanHandleExceptions;
end;

function TReader_BeginReferences_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginReferences;

  TReader(AObj).BeginReferences();
end;

function TReader_CheckValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CheckValue(Value: TValueType);

  TReader(AObj).CheckValue(TValueType_sw.FromVar(AArgs[0]));
end;

function TReader_EndOfList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function EndOfList: Boolean;

  Result := TReader(AObj).EndOfList();
end;

function TReader_EndReferences_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndReferences;

  TReader(AObj).EndReferences();
end;

function TReader_FixupReferences_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FixupReferences;

  TReader(AObj).FixupReferences();
end;

function TReader_NextValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function NextValue: TValueType;

  Result := TValueType_sw.ToVar(TReader(AObj).NextValue());
end;

function TReader_ReadBoolean_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadBoolean: Boolean;

  Result := TReader(AObj).ReadBoolean();
end;

function TReader_ReadChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadChar: Char;

  Result := TReader(AObj).ReadChar();
end;

function TReader_ReadWideChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadWideChar: WideChar;

  Result := TReader(AObj).ReadWideChar();
end;

function TReader_ReadCollection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ReadCollection(Collection: TCollection);

  TReader(AObj).ReadCollection(TCollection_sw.FromVar(AArgs[0]));
end;

function TReader_ReadComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadComponent(Component: TComponent): TComponent;

  Result := TComponent_sw.ToVar(TReader(AObj).ReadComponent(TComponent_sw.
    FromVar(AArgs[0])));
end;

function TReader_ReadComponents_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ReadComponents(AOwner: TComponent; AParent: TCo...

  TReader(AObj).ReadComponents(TComponent_sw.FromVar(AArgs[0]), TComponent_sw.
    FromVar(AArgs[1]), TReadComponentsProc_sw.FromVar(AArgs[2]));
end;

function TReader_ReadFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadFloat: Extended;

  Result := TReader(AObj).ReadFloat();
end;

function TReader_ReadSingle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadSingle: Single;

  Result := TReader(AObj).ReadSingle();
end;

function TReader_ReadDouble_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadDouble: Double;

  Result := TReader(AObj).ReadDouble();
end;

function TReader_ReadCurrency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadCurrency: Currency;

  Result := TReader(AObj).ReadCurrency();
end;

function TReader_ReadDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadDate: TDateTime;

  Result := TDateTime_sw.ToVar(TReader(AObj).ReadDate());
end;

function TReader_ReadIdent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadIdent: string;

  Result := TReader(AObj).ReadIdent();
end;

function TReader_ReadInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadInteger: Longint;

  Result := TReader(AObj).ReadInteger();
end;

function TReader_ReadInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadInt64: Int64;

  Result := Int64_sw.ToVar(TReader(AObj).ReadInt64());
end;

function TReader_ReadListBegin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ReadListBegin;

  TReader(AObj).ReadListBegin();
end;

function TReader_ReadListEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ReadListEnd;

  TReader(AObj).ReadListEnd();
end;

function TReader_ReadPrefix_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TFilerFlags;
  v_2: Integer;
begin
  // procedure ReadPrefix(var Flags: TFilerFlags; var AChildPo...

  v_1 := TFilerFlags_sw.FromVar(AArgs[0]);
  v_2 := Integer(AArgs[1]);
  TReader(AObj).ReadPrefix(v_1, v_2);
  AssignRefParam(AArgs[0], TFilerFlags_sw.ToVar(v_1));
  AssignRefParam(AArgs[1], v_2);
end;

function TReader_ReadRootComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadRootComponent(Root: TComponent): TComponent;

  Result := TComponent_sw.ToVar(TReader(AObj).ReadRootComponent(TComponent_sw.
    FromVar(AArgs[0])));
end;

function TReader_ReadSignature_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ReadSignature;

  TReader(AObj).ReadSignature();
end;

function TReader_ReadStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadStr: string;

  Result := TReader(AObj).ReadStr();
end;

function TReader_ReadString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadString: string;

  Result := TReader(AObj).ReadString();
end;

function TReader_ReadWideString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadWideString: WideString;

  Result := TReader(AObj).ReadWideString();
end;

function TReader_ReadValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadValue: TValueType;

  Result := TValueType_sw.ToVar(TReader(AObj).ReadValue());
end;

function TReader_ReadVariant_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadVariant: Variant;

  Result := TReader(AObj).ReadVariant();
end;

function TReader_CopyValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CopyValue(Writer: TWriter);

  TReader(AObj).CopyValue(TWriter_sw.FromVar(AArgs[0]));
end;

function TReader_SkipValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SkipValue;

  TReader(AObj).SkipValue();
end;

function TReader_Owner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Owner: TComponent read <getter> write <setter>;

  if IsGet then
    Result := TComponent_sw.ToVar(TReader(AObj).Owner)
  else
    TReader(AObj).Owner := TComponent_sw.FromVar(AArgs[0]);
end;

function TReader_Parent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Parent: TComponent read <getter> write <setter>;

  if IsGet then
    Result := TComponent_sw.ToVar(TReader(AObj).Parent)
  else
    TReader(AObj).Parent := TComponent_sw.FromVar(AArgs[0]);
end;

function TReader_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Position: Longint read <getter> write <setter>;

  if IsGet then
    Result := TReader(AObj).Position
  else
    TReader(AObj).Position := Longint(AArgs[0]);
end;

function TReader_OnError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnError: TReaderError read <getter> write <setter>;

  if IsGet then
    Result := TReaderError_sw.ToVar(TReader(AObj).OnError)
  else
    TReader(AObj).OnError := TReaderError_sw.FromVar(AArgs[0]);
end;

function TReader_OnSetName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSetName: TSetNameEvent read <getter> write <se...

  if IsGet then
    Result := TSetNameEvent_sw.ToVar(TReader(AObj).OnSetName)
  else
    TReader(AObj).OnSetName := TSetNameEvent_sw.FromVar(AArgs[0]);
end;

function TReader_OnReferenceName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnReferenceName: TReferenceNameEvent read <gette...

  if IsGet then
    Result := TReferenceNameEvent_sw.ToVar(TReader(AObj).OnReferenceName)
  else
    TReader(AObj).OnReferenceName := TReferenceNameEvent_sw.FromVar(AArgs[0]);
end;

function TReader_OnAncestorNotFound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnAncestorNotFound: TAncestorNotFoundEvent read ...

  if IsGet then
    Result := TAncestorNotFoundEvent_sw.ToVar(TReader(AObj).OnAncestorNotFound)
  else
    TReader(AObj).OnAncestorNotFound := TAncestorNotFoundEvent_sw.FromVar(
      AArgs[0]);
end;

function TReader_OnCreateComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCreateComponent: TCreateComponentEvent read <g...

  if IsGet then
    Result := TCreateComponentEvent_sw.ToVar(TReader(AObj).OnCreateComponent)
  else
    TReader(AObj).OnCreateComponent := TCreateComponentEvent_sw.FromVar(
      AArgs[0]);
end;

function TReader_OnFindComponentClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFindComponentClass: TFindComponentClassEvent r...

  if IsGet then
    Result := TFindComponentClassEvent_sw.ToVar(TReader(AObj).
      OnFindComponentClass)
  else
    TReader(AObj).OnFindComponentClass := TFindComponentClassEvent_sw.FromVar(
      AArgs[0]);
end;

class function TReader_sw.GetTypeName: WideString;
begin
  Result := 'TReader';
end;

class function TReader_sw.GetWrappedClass: TClass;
begin
  Result := TReader;
end;

class procedure TReader_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('PropName', TReader_PropName_si, string_sw, True, False, 0, True);
  AData.AddProperty('CanHandleExceptions', TReader_CanHandleExceptions_si, Boolean_sw, True, False, 0, True);
  AData.AddProcedure('BeginReferences', TReader_BeginReferences_si, 0, False);
  AData.AddProcedure('CheckValue', TReader_CheckValue_si, 1, False);
  AData.AddFunction('EndOfList', TReader_EndOfList_si, Boolean_sw, 0, False);
  AData.AddProcedure('EndReferences', TReader_EndReferences_si, 0, False);
  AData.AddProcedure('FixupReferences', TReader_FixupReferences_si, 0, False);
  AData.AddFunction('NextValue', TReader_NextValue_si, TValueType_sw, 0, False);
  AData.AddFunction('ReadBoolean', TReader_ReadBoolean_si, Boolean_sw, 0, False);
  AData.AddFunction('ReadChar', TReader_ReadChar_si, Char_sw, 0, False);
  AData.AddFunction('ReadWideChar', TReader_ReadWideChar_si, WideChar_sw, 0, False);
  AData.AddProcedure('ReadCollection', TReader_ReadCollection_si, 1, False);
  AData.AddFunction('ReadComponent', TReader_ReadComponent_si, TComponent_sw, 1, False);
  AData.AddProcedure('ReadComponents', TReader_ReadComponents_si, 3, False);
  AData.AddFunction('ReadFloat', TReader_ReadFloat_si, Extended_sw, 0, False);
  AData.AddFunction('ReadSingle', TReader_ReadSingle_si, Single_sw, 0, False);
  AData.AddFunction('ReadDouble', TReader_ReadDouble_si, Double_sw, 0, False);
  AData.AddFunction('ReadCurrency', TReader_ReadCurrency_si, Currency_sw, 0, False);
  AData.AddFunction('ReadDate', TReader_ReadDate_si, TDateTime_sw, 0, False);
  AData.AddFunction('ReadIdent', TReader_ReadIdent_si, string_sw, 0, False);
  AData.AddFunction('ReadInteger', TReader_ReadInteger_si, Longint_sw, 0, False);
  AData.AddFunction('ReadInt64', TReader_ReadInt64_si, Int64_sw, 0, False);
  AData.AddProcedure('ReadListBegin', TReader_ReadListBegin_si, 0, False);
  AData.AddProcedure('ReadListEnd', TReader_ReadListEnd_si, 0, False);
  AData.AddProcedure('ReadPrefix', TReader_ReadPrefix_si, 2, False);
  AData.AddFunction('ReadRootComponent', TReader_ReadRootComponent_si, TComponent_sw, 1, False);
  AData.AddProcedure('ReadSignature', TReader_ReadSignature_si, 0, False);
  AData.AddFunction('ReadStr', TReader_ReadStr_si, string_sw, 0, False);
  AData.AddFunction('ReadString', TReader_ReadString_si, string_sw, 0, False);
  AData.AddFunction('ReadWideString', TReader_ReadWideString_si, WideString_sw, 0, False);
  AData.AddFunction('ReadValue', TReader_ReadValue_si, TValueType_sw, 0, False);
  AData.AddFunction('ReadVariant', TReader_ReadVariant_si, Variant_sw, 0, False);
  AData.AddProcedure('CopyValue', TReader_CopyValue_si, 1, False);
  AData.AddProcedure('SkipValue', TReader_SkipValue_si, 0, False);
  AData.AddProperty('Owner', TReader_Owner_si, TComponent_sw, True, True, 0, False);
  AData.AddProperty('Parent', TReader_Parent_si, TComponent_sw, True, True, 0, False);
  AData.AddProperty('Position', TReader_Position_si, Longint_sw, True, True, 0, False);
  AData.AddProperty('OnError', TReader_OnError_si, TReaderError_sw, True, True, 0, False);
  AData.AddProperty('OnSetName', TReader_OnSetName_si, TSetNameEvent_sw, True, True, 0, False);
  AData.AddProperty('OnReferenceName', TReader_OnReferenceName_si, TReferenceNameEvent_sw, True, True, 0, False);
  AData.AddProperty('OnAncestorNotFound', TReader_OnAncestorNotFound_si, TAncestorNotFoundEvent_sw, True, True, 0, False);
  AData.AddProperty('OnCreateComponent', TReader_OnCreateComponent_si, TCreateComponentEvent_sw, True, True, 0, False);
  AData.AddProperty('OnFindComponentClass', TReader_OnFindComponentClass_si, TFindComponentClassEvent_sw, True, True, 0, False);
end;

class function TReader_sw.ToVar(const AValue: TReader): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TReader_sw.FromVar(const AValue: OleVariant): TReader;
begin
  Result := TReader(ConvFromVar(AValue, TReader));
end;

class function TReader_sw.ClassToVar(AClass: TReader_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TReader_sw.ClassFromVar(const AClass: OleVariant): TReader_sc;
begin
  Result := TReader_sc(ConvClsFromVar(AClass, TReader));
end;

{ TFindAncestorEvent_sh }

function TFindAncestorEvent_sh.GetHandler: TMethod;
var
  hdr: TFindAncestorEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFindAncestorEvent_sh.Handler(Writer: TWriter; Component: TComponent;
  const Name: string; var Ancestor: TComponent; var RootAncestor: TComponent);
var
  args: array[0..4] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure (Writer: TWriter; Component: TComponent; const ...

  v_1 := TComponent_sw.ToVar(Ancestor);
  v_2 := TComponent_sw.ToVar(RootAncestor);
  args[0] := TWriter_sw.ToVar(Writer);
  args[1] := TComponent_sw.ToVar(Component);
  args[2] := Name;
  args[3] := MakeVarRef(v_1);
  args[4] := MakeVarRef(v_2);
  Self.Owner.RunProc(Self.ProcName, args);
  Ancestor := TComponent_sw.FromVar(v_1);
  RootAncestor := TComponent_sw.FromVar(v_2);
end;

{ TFindAncestorEvent_sw }

class function TFindAncestorEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFindAncestorEvent';
end;

class function TFindAncestorEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFindAncestorEvent_sh;
end;

class function TFindAncestorEvent_sw.ToVar(
  const AValue: TFindAncestorEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFindAncestorEvent_sw.FromVar(
  const AValue: OleVariant): TFindAncestorEvent;
begin
  Result := TFindAncestorEvent(ConvFromVar(AValue));
end;

class function TFindAncestorEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TFindAncestorEvent;
var
  hdlr: TFindAncestorEvent_sh;
begin
  hdlr   := TFindAncestorEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TFindAncestorEvent_sw));
  Result := hdlr.Handler;
end;

{ TGetLookupInfoEvent_sh }

function TGetLookupInfoEvent_sh.GetHandler: TMethod;
var
  hdr: TGetLookupInfoEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetLookupInfoEvent_sh.Handler(var Ancestor: TPersistent;
  var Root: TComponent; var LookupRoot: TComponent;
  var RootAncestor: TComponent);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
  v_3: OleVariant;
  v_4: OleVariant;
begin
  // procedure (var Ancestor: TPersistent; var Root: TComponen...

  v_1 := TPersistent_sw.ToVar(Ancestor);
  v_2 := TComponent_sw.ToVar(Root);
  v_3 := TComponent_sw.ToVar(LookupRoot);
  v_4 := TComponent_sw.ToVar(RootAncestor);
  args[0] := MakeVarRef(v_1);
  args[1] := MakeVarRef(v_2);
  args[2] := MakeVarRef(v_3);
  args[3] := MakeVarRef(v_4);
  Self.Owner.RunProc(Self.ProcName, args);
  Ancestor := TPersistent_sw.FromVar(v_1);
  Root := TComponent_sw.FromVar(v_2);
  LookupRoot := TComponent_sw.FromVar(v_3);
  RootAncestor := TComponent_sw.FromVar(v_4);
end;

{ TGetLookupInfoEvent_sw }

class function TGetLookupInfoEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetLookupInfoEvent';
end;

class function TGetLookupInfoEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetLookupInfoEvent_sh;
end;

class function TGetLookupInfoEvent_sw.ToVar(
  const AValue: TGetLookupInfoEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetLookupInfoEvent_sw.FromVar(
  const AValue: OleVariant): TGetLookupInfoEvent;
begin
  Result := TGetLookupInfoEvent(ConvFromVar(AValue));
end;

class function TGetLookupInfoEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetLookupInfoEvent;
var
  hdlr: TGetLookupInfoEvent_sh;
begin
  hdlr   := TGetLookupInfoEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetLookupInfoEvent_sw));
  Result := hdlr.Handler;
end;

{ TWriter_sw }

function TWriter_WriteBoolean_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteBoolean(Value: Boolean);

  TWriter(AObj).WriteBoolean(Boolean(AArgs[0]));
end;

function TWriter_WriteCollection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteCollection(Value: TCollection);

  TWriter(AObj).WriteCollection(TCollection_sw.FromVar(AArgs[0]));
end;

function TWriter_WriteComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteComponent(Component: TComponent);

  TWriter(AObj).WriteComponent(TComponent_sw.FromVar(AArgs[0]));
end;

function TWriter_WriteChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteChar(Value: Char);

  TWriter(AObj).WriteChar(Char(Integer(AArgs[0])));
end;

function TWriter_WriteWideChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteWideChar(Value: WideChar);

  TWriter(AObj).WriteWideChar(WideChar(Integer(AArgs[0])));
end;

function TWriter_WriteDescendent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteDescendent(Root: TComponent; AAncestor: TC...

  TWriter(AObj).WriteDescendent(TComponent_sw.FromVar(AArgs[0]), TComponent_sw.
    FromVar(AArgs[1]));
end;

function TWriter_WriteFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteFloat(const Value: Extended);

  TWriter(AObj).WriteFloat(Extended(AArgs[0]));
end;

function TWriter_WriteSingle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteSingle(const Value: Single);

  TWriter(AObj).WriteSingle(Single(AArgs[0]));
end;

function TWriter_WriteDouble_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteDouble(const Value: Double);

  TWriter(AObj).WriteDouble(Double(AArgs[0]));
end;

function TWriter_WriteCurrency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteCurrency(const Value: Currency);

  TWriter(AObj).WriteCurrency(Currency(AArgs[0]));
end;

function TWriter_WriteDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteDate(const Value: TDateTime);

  TWriter(AObj).WriteDate(TDateTime_sw.FromVar(AArgs[0]));
end;

function TWriter_WriteIdent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteIdent(const Ident: string);

  TWriter(AObj).WriteIdent(string(AArgs[0]));
end;

function TWriter_WriteInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteInteger(Value: Longint);

  TWriter(AObj).WriteInteger(Longint(AArgs[0]));
end;

function TWriter_WriteListBegin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteListBegin;

  TWriter(AObj).WriteListBegin();
end;

function TWriter_WriteListEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteListEnd;

  TWriter(AObj).WriteListEnd();
end;

function TWriter_WriteRootComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteRootComponent(Root: TComponent);

  TWriter(AObj).WriteRootComponent(TComponent_sw.FromVar(AArgs[0]));
end;

function TWriter_WriteSignature_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteSignature;

  TWriter(AObj).WriteSignature();
end;

function TWriter_WriteStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteStr(const Value: string);

  TWriter(AObj).WriteStr(string(AArgs[0]));
end;

function TWriter_WriteString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteString(const Value: string);

  TWriter(AObj).WriteString(string(AArgs[0]));
end;

function TWriter_WriteWideString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteWideString(const Value: WideString);

  TWriter(AObj).WriteWideString(WideString(AArgs[0]));
end;

function TWriter_WriteVariant_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteVariant(const Value: Variant);

  TWriter(AObj).WriteVariant(Variant(AArgs[0]));
end;

function TWriter_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Position: Longint read <getter> write <setter>;

  if IsGet then
    Result := TWriter(AObj).Position
  else
    TWriter(AObj).Position := Longint(AArgs[0]);
end;

function TWriter_RootAncestor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RootAncestor: TComponent read <getter> write <se...

  if IsGet then
    Result := TComponent_sw.ToVar(TWriter(AObj).RootAncestor)
  else
    TWriter(AObj).RootAncestor := TComponent_sw.FromVar(AArgs[0]);
end;

function TWriter_OnFindAncestor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFindAncestor: TFindAncestorEvent read <getter>...

  if IsGet then
    Result := TFindAncestorEvent_sw.ToVar(TWriter(AObj).OnFindAncestor)
  else
    TWriter(AObj).OnFindAncestor := TFindAncestorEvent_sw.FromVar(AArgs[0]);
end;

function TWriter_UseQualifiedNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UseQualifiedNames: Boolean read <getter> write <...

  if IsGet then
    Result := TWriter(AObj).UseQualifiedNames
  else
    TWriter(AObj).UseQualifiedNames := Boolean(AArgs[0]);
end;

class function TWriter_sw.GetTypeName: WideString;
begin
  Result := 'TWriter';
end;

class function TWriter_sw.GetWrappedClass: TClass;
begin
  Result := TWriter;
end;

class procedure TWriter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('WriteBoolean', TWriter_WriteBoolean_si, 1, False);
  AData.AddProcedure('WriteCollection', TWriter_WriteCollection_si, 1, False);
  AData.AddProcedure('WriteComponent', TWriter_WriteComponent_si, 1, False);
  AData.AddProcedure('WriteChar', TWriter_WriteChar_si, 1, False);
  AData.AddProcedure('WriteWideChar', TWriter_WriteWideChar_si, 1, False);
  AData.AddProcedure('WriteDescendent', TWriter_WriteDescendent_si, 2, False);
  AData.AddProcedure('WriteFloat', TWriter_WriteFloat_si, 1, False);
  AData.AddProcedure('WriteSingle', TWriter_WriteSingle_si, 1, False);
  AData.AddProcedure('WriteDouble', TWriter_WriteDouble_si, 1, False);
  AData.AddProcedure('WriteCurrency', TWriter_WriteCurrency_si, 1, False);
  AData.AddProcedure('WriteDate', TWriter_WriteDate_si, 1, False);
  AData.AddProcedure('WriteIdent', TWriter_WriteIdent_si, 1, False);
  AData.AddProcedure('WriteInteger', TWriter_WriteInteger_si, 1, False);
  AData.AddProcedure('WriteListBegin', TWriter_WriteListBegin_si, 0, False);
  AData.AddProcedure('WriteListEnd', TWriter_WriteListEnd_si, 0, False);
  AData.AddProcedure('WriteRootComponent', TWriter_WriteRootComponent_si, 1, False);
  AData.AddProcedure('WriteSignature', TWriter_WriteSignature_si, 0, False);
  AData.AddProcedure('WriteStr', TWriter_WriteStr_si, 1, False);
  AData.AddProcedure('WriteString', TWriter_WriteString_si, 1, False);
  AData.AddProcedure('WriteWideString', TWriter_WriteWideString_si, 1, False);
  AData.AddProcedure('WriteVariant', TWriter_WriteVariant_si, 1, False);
  AData.AddProperty('Position', TWriter_Position_si, Longint_sw, True, True, 0, False);
  AData.AddProperty('RootAncestor', TWriter_RootAncestor_si, TComponent_sw, True, True, 0, False);
  AData.AddProperty('OnFindAncestor', TWriter_OnFindAncestor_si, TFindAncestorEvent_sw, True, True, 0, False);
  AData.AddProperty('UseQualifiedNames', TWriter_UseQualifiedNames_si, Boolean_sw, True, True, 0, False);
end;

class function TWriter_sw.ToVar(const AValue: TWriter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWriter_sw.FromVar(const AValue: OleVariant): TWriter;
begin
  Result := TWriter(ConvFromVar(AValue, TWriter));
end;

class function TWriter_sw.ClassToVar(AClass: TWriter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWriter_sw.ClassFromVar(const AClass: OleVariant): TWriter_sc;
begin
  Result := TWriter_sc(ConvClsFromVar(AClass, TWriter));
end;

{ TParserErrorEvent_sh }

function TParserErrorEvent_sh.GetHandler: TMethod;
var
  hdr: TParserErrorEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TParserErrorEvent_sh.Handler(Sender: TObject; const Message: string;
  var Handled: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; const Message: string; var Ha...

  v_1 := Handled;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := Message;
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Handled := Boolean(v_1);
end;

{ TParserErrorEvent_sw }

class function TParserErrorEvent_sw.GetTypeName: WideString;
begin
  Result := 'TParserErrorEvent';
end;

class function TParserErrorEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TParserErrorEvent_sh;
end;

class function TParserErrorEvent_sw.ToVar(
  const AValue: TParserErrorEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TParserErrorEvent_sw.FromVar(
  const AValue: OleVariant): TParserErrorEvent;
begin
  Result := TParserErrorEvent(ConvFromVar(AValue));
end;

class function TParserErrorEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TParserErrorEvent;
var
  hdlr: TParserErrorEvent_sh;
begin
  hdlr   := TParserErrorEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TParserErrorEvent_sw));
  Result := hdlr.Handler;
end;

{ TParser_sw }

function TParser_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Stream: TStream; AOnError: TParserErro...

  Result := TParser_sw.ToVar(TParser_sc(AObj).Create(TStream_sw.FromVar(
    AArgs[0]), TParserErrorEvent_sw.FromVar(AArgs[1])));
end;

function TParser_CheckToken_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CheckToken(T: Char);

  TParser(AObj).CheckToken(Char(Integer(AArgs[0])));
end;

function TParser_CheckTokenSymbol_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CheckTokenSymbol(const S: string);

  TParser(AObj).CheckTokenSymbol(string(AArgs[0]));
end;

function TParser_Error_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Error(const Ident: string);

  TParser(AObj).Error(string(AArgs[0]));
end;

function TParser_ErrorStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ErrorStr(const Message: string);

  TParser(AObj).ErrorStr(string(AArgs[0]));
end;

function TParser_HexToBinary_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure HexToBinary(Stream: TStream);

  TParser(AObj).HexToBinary(TStream_sw.FromVar(AArgs[0]));
end;

function TParser_NextToken_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function NextToken: Char;

  Result := TParser(AObj).NextToken();
end;

function TParser_SourcePos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SourcePos: Longint;

  Result := TParser(AObj).SourcePos();
end;

function TParser_TokenComponentIdent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TokenComponentIdent: string;

  Result := TParser(AObj).TokenComponentIdent();
end;

function TParser_TokenFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TokenFloat: Extended;

  Result := TParser(AObj).TokenFloat();
end;

function TParser_TokenInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TokenInt: Int64;

  Result := Int64_sw.ToVar(TParser(AObj).TokenInt());
end;

function TParser_TokenString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TokenString: string;

  Result := TParser(AObj).TokenString();
end;

function TParser_TokenWideString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TokenWideString: WideString;

  Result := TParser(AObj).TokenWideString();
end;

function TParser_TokenSymbolIs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TokenSymbolIs(const S: string): Boolean;

  Result := TParser(AObj).TokenSymbolIs(string(AArgs[0]));
end;

function TParser_FloatType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FloatType: Char read <getter>;

  Result := TParser(AObj).FloatType;
end;

function TParser_SourceLine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SourceLine: Integer read <getter>;

  Result := TParser(AObj).SourceLine;
end;

function TParser_LinePos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LinePos: Integer read <getter>;

  Result := TParser(AObj).LinePos;
end;

function TParser_Token_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Token: Char read <getter>;

  Result := TParser(AObj).Token;
end;

function TParser_OnError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnError: TParserErrorEvent read <getter> write <...

  if IsGet then
    Result := TParserErrorEvent_sw.ToVar(TParser(AObj).OnError)
  else
    TParser(AObj).OnError := TParserErrorEvent_sw.FromVar(AArgs[0]);
end;

class function TParser_sw.GetTypeName: WideString;
begin
  Result := 'TParser';
end;

class function TParser_sw.GetWrappedClass: TClass;
begin
  Result := TParser;
end;

class procedure TParser_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('CheckToken', TParser_CheckToken_si, 1, False);
  AData.AddProcedure('CheckTokenSymbol', TParser_CheckTokenSymbol_si, 1, False);
  AData.AddProcedure('Error', TParser_Error_si, 1, False);
  AData.AddProcedure('ErrorStr', TParser_ErrorStr_si, 1, False);
  AData.AddProcedure('HexToBinary', TParser_HexToBinary_si, 1, False);
  AData.AddFunction('NextToken', TParser_NextToken_si, Char_sw, 0, False);
  AData.AddFunction('SourcePos', TParser_SourcePos_si, Longint_sw, 0, False);
  AData.AddFunction('TokenComponentIdent', TParser_TokenComponentIdent_si, string_sw, 0, False);
  AData.AddFunction('TokenFloat', TParser_TokenFloat_si, Extended_sw, 0, False);
  AData.AddFunction('TokenInt', TParser_TokenInt_si, Int64_sw, 0, False);
  AData.AddFunction('TokenString', TParser_TokenString_si, string_sw, 0, False);
  AData.AddFunction('TokenWideString', TParser_TokenWideString_si, WideString_sw, 0, False);
  AData.AddFunction('TokenSymbolIs', TParser_TokenSymbolIs_si, Boolean_sw, 1, False);
  AData.AddProperty('FloatType', TParser_FloatType_si, Char_sw, True, False, 0, False);
  AData.AddProperty('SourceLine', TParser_SourceLine_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('LinePos', TParser_LinePos_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('Token', TParser_Token_si, Char_sw, True, False, 0, False);
  AData.AddProperty('OnError', TParser_OnError_si, TParserErrorEvent_sw, True, True, 0, False);

  { Class members }

  AData.AddConstructor('Create', TParser_Create_si, 2, False);
end;

class function TParser_sw.ToVar(const AValue: TParser): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TParser_sw.FromVar(const AValue: OleVariant): TParser;
begin
  Result := TParser(ConvFromVar(AValue, TParser));
end;

class function TParser_sw.ClassToVar(AClass: TParser_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TParser_sw.ClassFromVar(const AClass: OleVariant): TParser_sc;
begin
  Result := TParser_sc(ConvClsFromVar(AClass, TParser));
end;

{ EThread_sw }

class function EThread_sw.GetTypeName: WideString;
begin
  Result := 'EThread';
end;

class function EThread_sw.GetWrappedClass: TClass;
begin
  Result := EThread;
end;

class procedure EThread_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EThread_sw.ToVar(const AValue: EThread): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EThread_sw.FromVar(const AValue: OleVariant): EThread;
begin
  Result := EThread(ConvFromVar(AValue, EThread));
end;

class function EThread_sw.ClassToVar(AClass: EThread_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EThread_sw.ClassFromVar(const AClass: OleVariant): EThread_sc;
begin
  Result := EThread_sc(ConvClsFromVar(AClass, EThread));
end;

{ TThreadMethod_sh }

function TThreadMethod_sh.GetHandler: TMethod;
var
  hdr: TThreadMethod;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TThreadMethod_sh.Handler;
begin
  // procedure  of object

  Self.Owner.RunProc(Self.ProcName);
end;

{ TThreadMethod_sw }

class function TThreadMethod_sw.GetTypeName: WideString;
begin
  Result := 'TThreadMethod';
end;

class function TThreadMethod_sw.GetScriptHandlerClass: TClass;
begin
  Result := TThreadMethod_sh;
end;

class function TThreadMethod_sw.ToVar(const AValue: TThreadMethod): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TThreadMethod_sw.FromVar(
  const AValue: OleVariant): TThreadMethod;
begin
  Result := TThreadMethod(ConvFromVar(AValue));
end;

class function TThreadMethod_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TThreadMethod;
var
  hdlr: TThreadMethod_sh;
begin
  hdlr   := TThreadMethod_sh(AScriptControl.GetEventHandler(AProcName, 
    TThreadMethod_sw));
  Result := hdlr.Handler;
end;

{ TThreadPriority_sw }

class function TThreadPriority_sw.GetTypeName: WideString;
begin
  Result := 'TThreadPriority';
end;

class function TThreadPriority_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TThreadPriority);
end;

class function TThreadPriority_sw.ToVar(
  const AValue: TThreadPriority): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TThreadPriority_sw.FromVar(
  const AValue: OleVariant): TThreadPriority;
begin
  Result := TThreadPriority(Integer(AValue));
end;

{ TSynchronizeRecord_sw }

function TSynchronizeRecord_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TSynchronizeRecord_sw.ToVar(TSynchronizeRecord(AObj));
end;

function TSynchronizeRecord_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TSynchronizeRecord_sw.Create as IDispatch;
end;

function TSynchronizeRecord_FThread_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FThread: TObject;

  if IsGet then
    Result := TObject_sw.ToVar(TSynchronizeRecord_sw(AObj).FValue.FThread)
  else
    TSynchronizeRecord_sw(AObj).FValue.FThread := TObject_sw.FromVar(AArgs[0]);
end;

function TSynchronizeRecord_FMethod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FMethod: TThreadMethod;

  if IsGet then
    Result := TThreadMethod_sw.ToVar(TSynchronizeRecord_sw(AObj).FValue.FMethod)
  else
    TSynchronizeRecord_sw(AObj).FValue.FMethod := TThreadMethod_sw.FromVar(
      AArgs[0]);
end;

function TSynchronizeRecord_FSynchronizeException_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FSynchronizeException: TObject;

  if IsGet then
    Result := TObject_sw.ToVar(TSynchronizeRecord_sw(AObj).FValue.
      FSynchronizeException)
  else
    TSynchronizeRecord_sw(AObj).FValue.FSynchronizeException := TObject_sw.
      FromVar(AArgs[0]);
end;

class function TSynchronizeRecord_sw.GetTypeName: WideString;
begin
  Result := 'TSynchronizeRecord';
end;

function TSynchronizeRecord_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TSynchronizeRecord_sw.Create;
  TSynchronizeRecord_sw(Result).FValue := FValue;
end;

class procedure TSynchronizeRecord_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TSynchronizeRecord_Copy_si, TSynchronizeRecord_sw, 0);
  AData.AddField('FThread', TSynchronizeRecord_FThread_si, TObject_sw);
  AData.AddField('FMethod', TSynchronizeRecord_FMethod_si, TThreadMethod_sw);
  AData.AddField('FSynchronizeException', TSynchronizeRecord_FSynchronizeException_si, TObject_sw);

  { Class members }

  AData.AddConstructor('Create', TSynchronizeRecord_Create_si, 0);
end;

class function TSynchronizeRecord_sw.ToVar(
  const AValue: TSynchronizeRecord): OleVariant;
var
  wrpr: TSynchronizeRecord_sw;
begin
  wrpr        := TSynchronizeRecord_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TSynchronizeRecord_sw.FromVar(
  const AValue: OleVariant): TSynchronizeRecord;
begin
  Result := TSynchronizeRecord_sw(ConvFromVar(AValue)).FValue;
end;

{ TThread_sw }

function TThread_ReturnValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ReturnValue: Integer read <getter> wri...

  if IsGet then
    Result := TThread_sacc(TThread(AObj)).ReturnValue
  else
    TThread_sacc(TThread(AObj)).ReturnValue := Integer(AArgs[0]);
end;

function TThread_Terminated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Terminated: Boolean read <getter>;

  Result := TThread_sacc(TThread(AObj)).Terminated;
end;

function TThread_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(CreateSuspended: Boolean);

  Result := TThread_sw.ToVar(TThread_sc(AObj).Create(Boolean(AArgs[0])));
end;

function TThread_Resume_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Resume;

  TThread(AObj).Resume();
end;

function TThread_Suspend_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Suspend;

  TThread(AObj).Suspend();
end;

function TThread_Terminate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Terminate;

  TThread(AObj).Terminate();
end;

function TThread_WaitFor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function WaitFor: LongWord;

  Result := TThread(AObj).WaitFor();
end;

function TThread_Queue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure Queue(AThread: TThread; AMethod: TThreadM...

  TThread_sc(AObj).Queue(TThread_sw.FromVar(AArgs[0]), TThreadMethod_sw.FromVar(
    AArgs[1]));
end;

function TThread_RemoveQueuedEvents_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure RemoveQueuedEvents(AThread: TThread; AMet...

  TThread_sc(AObj).RemoveQueuedEvents(TThread_sw.FromVar(AArgs[0]), 
    TThreadMethod_sw.FromVar(AArgs[1]));
end;

function TThread_StaticQueue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure StaticQueue(AThread: TThread; AMethod: TT...

  TThread_sc(AObj).StaticQueue(TThread_sw.FromVar(AArgs[0]), TThreadMethod_sw.
    FromVar(AArgs[1]));
end;

function TThread_Synchronize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure Synchronize(AThread: TThread; AMethod: TT...

  TThread_sc(AObj).Synchronize(TThread_sw.FromVar(AArgs[0]), TThreadMethod_sw.
    FromVar(AArgs[1]));
end;

function TThread_StaticSynchronize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure StaticSynchronize(AThread: TThread; AMeth...

  TThread_sc(AObj).StaticSynchronize(TThread_sw.FromVar(AArgs[0]), 
    TThreadMethod_sw.FromVar(AArgs[1]));
end;

function TThread_FatalException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FatalException: TObject read <getter>;

  Result := TObject_sw.ToVar(TThread(AObj).FatalException);
end;

function TThread_FreeOnTerminate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FreeOnTerminate: Boolean read <getter> write <se...

  if IsGet then
    Result := TThread(AObj).FreeOnTerminate
  else
    TThread(AObj).FreeOnTerminate := Boolean(AArgs[0]);
end;

function TThread_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: THandle read <getter>;

  Result := THandle_sw.ToVar(TThread(AObj).Handle);
end;

function TThread_Priority_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Priority: TThreadPriority read <getter> write <s...

  if IsGet then
    Result := TThreadPriority_sw.ToVar(TThread(AObj).Priority)
  else
    TThread(AObj).Priority := TThreadPriority_sw.FromVar(AArgs[0]);
end;

function TThread_Suspended_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Suspended: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TThread(AObj).Suspended
  else
    TThread(AObj).Suspended := Boolean(AArgs[0]);
end;

function TThread_ThreadID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ThreadID: THandle read <getter>;

  Result := THandle_sw.ToVar(TThread(AObj).ThreadID);
end;

function TThread_OnTerminate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnTerminate: TNotifyEvent read <getter> write <s...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TThread(AObj).OnTerminate)
  else
    TThread(AObj).OnTerminate := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TThread_sw.GetTypeName: WideString;
begin
  Result := 'TThread';
end;

class function TThread_sw.GetWrappedClass: TClass;
begin
  Result := TThread;
end;

class procedure TThread_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ReturnValue', TThread_ReturnValue_si, Integer_sw, True, True, 0, True);
  AData.AddProperty('Terminated', TThread_Terminated_si, Boolean_sw, True, False, 0, True);
  AData.AddProcedure('Resume', TThread_Resume_si, 0, False);
  AData.AddProcedure('Suspend', TThread_Suspend_si, 0, False);
  AData.AddProcedure('Terminate', TThread_Terminate_si, 0, False);
  AData.AddFunction('WaitFor', TThread_WaitFor_si, LongWord_sw, 0, False);
  AData.AddProperty('FatalException', TThread_FatalException_si, TObject_sw, True, False, 0, False);
  AData.AddProperty('FreeOnTerminate', TThread_FreeOnTerminate_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('Handle', TThread_Handle_si, THandle_sw, True, False, 0, False);
  AData.AddProperty('Priority', TThread_Priority_si, TThreadPriority_sw, True, True, 0, False);
  AData.AddProperty('Suspended', TThread_Suspended_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('ThreadID', TThread_ThreadID_si, THandle_sw, True, False, 0, False);
  AData.AddProperty('OnTerminate', TThread_OnTerminate_si, TNotifyEvent_sw, True, True, 0, False);

  { Class members }

  AData.AddConstructor('Create', TThread_Create_si, 1, False);
  AData.AddClassProcedure('Queue', TThread_Queue_si, 2, False);
  AData.AddClassProcedure('RemoveQueuedEvents', TThread_RemoveQueuedEvents_si, 2, False);
  AData.AddClassProcedure('StaticQueue', TThread_StaticQueue_si, 2, False);
  AData.AddClassProcedure('Synchronize', TThread_Synchronize_si, 2, False);
  AData.AddClassProcedure('StaticSynchronize', TThread_StaticSynchronize_si, 2, False);
end;

class function TThread_sw.ToVar(const AValue: TThread): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TThread_sw.FromVar(const AValue: OleVariant): TThread;
begin
  Result := TThread(ConvFromVar(AValue, TThread));
end;

class function TThread_sw.ClassToVar(AClass: TThread_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TThread_sw.ClassFromVar(const AClass: OleVariant): TThread_sc;
begin
  Result := TThread_sc(ConvClsFromVar(AClass, TThread));
end;

{ TComponentEnumerator_sw }

function TComponentEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AComponent: TComponent);

  Result := TComponentEnumerator_sw.ToVar(TComponentEnumerator_sc(AObj).Create(
    TComponent_sw.FromVar(AArgs[0])));
end;

function TComponentEnumerator_GetCurrent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrent: TComponent;

  Result := TComponent_sw.ToVar(TComponentEnumerator(AObj).GetCurrent());
end;

function TComponentEnumerator_MoveNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TComponentEnumerator(AObj).MoveNext();
end;

function TComponentEnumerator_Current_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: TComponent read <getter>;

  Result := TComponent_sw.ToVar(TComponentEnumerator(AObj).Current);
end;

class function TComponentEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TComponentEnumerator';
end;

class function TComponentEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TComponentEnumerator;
end;

class procedure TComponentEnumerator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetCurrent', TComponentEnumerator_GetCurrent_si, TComponent_sw, 0, False);
  AData.AddFunction('MoveNext', TComponentEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TComponentEnumerator_Current_si, TComponent_sw, True, False, 0, False);

  { Class members }

  AData.AddConstructor('Create', TComponentEnumerator_Create_si, 1, False);
end;

class function TComponentEnumerator_sw.ToVar(
  const AValue: TComponentEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComponentEnumerator_sw.FromVar(
  const AValue: OleVariant): TComponentEnumerator;
begin
  Result := TComponentEnumerator(ConvFromVar(AValue, TComponentEnumerator));
end;

class function TComponentEnumerator_sw.ClassToVar(
  AClass: TComponentEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TComponentEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TComponentEnumerator_sc;
begin
  Result := TComponentEnumerator_sc(ConvClsFromVar(AClass, 
    TComponentEnumerator));
end;

{ TOperation_sw }

class function TOperation_sw.GetTypeName: WideString;
begin
  Result := 'TOperation';
end;

class function TOperation_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TOperation);
end;

class function TOperation_sw.ToVar(const AValue: TOperation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TOperation_sw.FromVar(const AValue: OleVariant): TOperation;
begin
  Result := TOperation(Integer(AValue));
end;

{ TGetChildProc_sh }

function TGetChildProc_sh.GetHandler: TMethod;
var
  hdr: TGetChildProc;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetChildProc_sh.Handler(Child: TComponent);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (Child: TComponent) of object

  args[0] := TComponent_sw.ToVar(Child);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TGetChildProc_sw }

class function TGetChildProc_sw.GetTypeName: WideString;
begin
  Result := 'TGetChildProc';
end;

class function TGetChildProc_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetChildProc_sh;
end;

class function TGetChildProc_sw.ToVar(const AValue: TGetChildProc): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetChildProc_sw.FromVar(
  const AValue: OleVariant): TGetChildProc;
begin
  Result := TGetChildProc(ConvFromVar(AValue));
end;

class function TGetChildProc_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetChildProc;
var
  hdlr: TGetChildProc_sh;
begin
  hdlr   := TGetChildProc_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetChildProc_sw));
  Result := hdlr.Handler;
end;

{ TComponent_sw }

function TComponent_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TComponent);

  Result := TComponent_sw.ToVar(TComponent_sc(AObj).Create(TComponent_sw.
    FromVar(AArgs[0])));
end;

function TComponent_DestroyComponents_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DestroyComponents;

  TComponent(AObj).DestroyComponents();
end;

function TComponent_Destroying_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Destroying;

  TComponent(AObj).Destroying();
end;

function TComponent_ExecuteAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExecuteAction(Action: TBasicAction): Boolean;

  Result := TComponent(AObj).ExecuteAction(TBasicAction_sw.FromVar(AArgs[0]));
end;

function TComponent_FindComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindComponent(const AName: string): TComponent;

  Result := TComponent_sw.ToVar(TComponent(AObj).FindComponent(string(
    AArgs[0])));
end;

function TComponent_FreeNotification_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FreeNotification(AComponent: TComponent);

  TComponent(AObj).FreeNotification(TComponent_sw.FromVar(AArgs[0]));
end;

function TComponent_RemoveFreeNotification_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RemoveFreeNotification(AComponent: TComponent);

  TComponent(AObj).RemoveFreeNotification(TComponent_sw.FromVar(AArgs[0]));
end;

function TComponent_FreeOnRelease_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FreeOnRelease;

  TComponent(AObj).FreeOnRelease();
end;

function TComponent_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TComponentEnumerator;

  Result := TComponentEnumerator_sw.ToVar(TComponent(AObj).GetEnumerator());
end;

function TComponent_GetParentComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetParentComponent: TComponent;

  Result := TComponent_sw.ToVar(TComponent(AObj).GetParentComponent());
end;

function TComponent_HasParent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HasParent: Boolean;

  Result := TComponent(AObj).HasParent();
end;

function TComponent_InsertComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InsertComponent(AComponent: TComponent);

  TComponent(AObj).InsertComponent(TComponent_sw.FromVar(AArgs[0]));
end;

function TComponent_RemoveComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RemoveComponent(AComponent: TComponent);

  TComponent(AObj).RemoveComponent(TComponent_sw.FromVar(AArgs[0]));
end;

function TComponent_SetSubComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetSubComponent(IsSubComponent: Boolean);

  TComponent(AObj).SetSubComponent(Boolean(AArgs[0]));
end;

function TComponent_UpdateAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UpdateAction(Action: TBasicAction): Boolean;

  Result := TComponent(AObj).UpdateAction(TBasicAction_sw.FromVar(AArgs[0]));
end;

function TComponent_Components_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Components[Index: Integer]: TComponent read <get...

  Result := TComponent_sw.ToVar(TComponent(AObj).Components[Integer(AArgs[0])]);
end;

function TComponent_ComponentCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ComponentCount: Integer read <getter>;

  Result := TComponent(AObj).ComponentCount;
end;

function TComponent_ComponentIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ComponentIndex: Integer read <getter> write <set...

  if IsGet then
    Result := TComponent(AObj).ComponentIndex
  else
    TComponent(AObj).ComponentIndex := Integer(AArgs[0]);
end;

function TComponent_DesignInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DesignInfo: Longint read <getter> write <setter>;

  if IsGet then
    Result := TComponent(AObj).DesignInfo
  else
    TComponent(AObj).DesignInfo := Longint(AArgs[0]);
end;

function TComponent_Owner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Owner: TComponent read <getter>;

  Result := TComponent_sw.ToVar(TComponent(AObj).Owner);
end;

function TComponent_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Name: TComponentName read <getter> write <setter>;

  if IsGet then
    Result := TComponentName_sw.ToVar(TComponent(AObj).Name)
  else
    TComponent(AObj).Name := TComponentName_sw.FromVar(AArgs[0]);
end;

function TComponent_Tag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Tag: Longint read <getter> write <setter>;

  if IsGet then
    Result := TComponent(AObj).Tag
  else
    TComponent(AObj).Tag := Longint(AArgs[0]);
end;

class function TComponent_sw.GetTypeName: WideString;
begin
  Result := 'TComponent';
end;

class function TComponent_sw.GetWrappedClass: TClass;
begin
  Result := TComponent;
end;

class procedure TComponent_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('DestroyComponents', TComponent_DestroyComponents_si, 0, False);
  AData.AddProcedure('Destroying', TComponent_Destroying_si, 0, False);
  AData.AddFunction('ExecuteAction', TComponent_ExecuteAction_si, Boolean_sw, 1, False);
  AData.AddFunction('FindComponent', TComponent_FindComponent_si, TComponent_sw, 1, False);
  AData.AddProcedure('FreeNotification', TComponent_FreeNotification_si, 1, False);
  AData.AddProcedure('RemoveFreeNotification', TComponent_RemoveFreeNotification_si, 1, False);
  AData.AddProcedure('FreeOnRelease', TComponent_FreeOnRelease_si, 0, False);
  AData.AddFunction('GetEnumerator', TComponent_GetEnumerator_si, TComponentEnumerator_sw, 0, False);
  AData.AddFunction('GetParentComponent', TComponent_GetParentComponent_si, TComponent_sw, 0, False);
  AData.AddFunction('HasParent', TComponent_HasParent_si, Boolean_sw, 0, False);
  AData.AddProcedure('InsertComponent', TComponent_InsertComponent_si, 1, False);
  AData.AddProcedure('RemoveComponent', TComponent_RemoveComponent_si, 1, False);
  AData.AddProcedure('SetSubComponent', TComponent_SetSubComponent_si, 1, False);
  AData.AddFunction('UpdateAction', TComponent_UpdateAction_si, Boolean_sw, 1, False);
  AData.AddProperty('Components', TComponent_Components_si, TComponent_sw, True, False, 1, False);
  AData.AddProperty('ComponentCount', TComponent_ComponentCount_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('ComponentIndex', TComponent_ComponentIndex_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('DesignInfo', TComponent_DesignInfo_si, Longint_sw, True, True, 0, False);
  AData.AddProperty('Owner', TComponent_Owner_si, TComponent_sw, True, False, 0, False);
  AData.AddProperty('Name', TComponent_Name_si, TComponentName_sw, True, True, 0, False);
  AData.AddProperty('Tag', TComponent_Tag_si, Longint_sw, True, True, 0, False);

  { Class members }

  AData.AddConstructor('Create', TComponent_Create_si, 1, False);
end;

class function TComponent_sw.ToVar(const AValue: TComponent): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TComponent_sw.FromVar(const AValue: OleVariant): TComponent;
begin
  Result := TComponent(ConvFromVar(AValue, TComponent));
end;

class function TComponent_sw.ClassToVar(AClass: TComponent_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TComponent_sw.ClassFromVar(
  const AClass: OleVariant): TComponent_sc;
begin
  Result := TComponent_sc(ConvClsFromVar(AClass, TComponent));
end;

{ TBasicActionLink_sw }

function TBasicActionLink_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AClient: TObject);

  Result := TBasicActionLink_sw.ToVar(TBasicActionLink_sc(AObj).Create(
    TObject_sw.FromVar(AArgs[0])));
end;

function TBasicActionLink_Execute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Execute(AComponent: TComponent): Boolean;

  Result := TBasicActionLink(AObj).Execute(TComponent_sw.FromVar(AArgs[0]));
end;

function TBasicActionLink_Update_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Update: Boolean;

  Result := TBasicActionLink(AObj).Update();
end;

function TBasicActionLink_Action_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Action: TBasicAction read <getter> write <setter>;

  if IsGet then
    Result := TBasicAction_sw.ToVar(TBasicActionLink(AObj).Action)
  else
    TBasicActionLink(AObj).Action := TBasicAction_sw.FromVar(AArgs[0]);
end;

function TBasicActionLink_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TBasicActionLink(AObj).OnChange)
  else
    TBasicActionLink(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TBasicActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TBasicActionLink';
end;

class function TBasicActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TBasicActionLink;
end;

class procedure TBasicActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Execute', TBasicActionLink_Execute_si, Boolean_sw, 1, False);
  AData.AddFunction('Update', TBasicActionLink_Update_si, Boolean_sw, 0, False);
  AData.AddProperty('Action', TBasicActionLink_Action_si, TBasicAction_sw, True, True, 0, False);
  AData.AddProperty('OnChange', TBasicActionLink_OnChange_si, TNotifyEvent_sw, True, True, 0, False);

  { Class members }

  AData.AddConstructor('Create', TBasicActionLink_Create_si, 1, False);
end;

class function TBasicActionLink_sw.ToVar(
  const AValue: TBasicActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBasicActionLink_sw.FromVar(
  const AValue: OleVariant): TBasicActionLink;
begin
  Result := TBasicActionLink(ConvFromVar(AValue, TBasicActionLink));
end;

class function TBasicActionLink_sw.ClassToVar(
  AClass: TBasicActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBasicActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TBasicActionLink_sc;
begin
  Result := TBasicActionLink_sc(ConvClsFromVar(AClass, TBasicActionLink));
end;

{ TBasicActionLinkClass_sw }

class function TBasicActionLinkClass_sw.GetTypeName: WideString;
begin
  Result := 'TBasicActionLinkClass';
end;

class function TBasicActionLinkClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TBasicActionLink;
end;

class function TBasicActionLinkClass_sw.ToVar(
  const AValue: TBasicActionLinkClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBasicActionLinkClass_sw.FromVar(
  const AValue: OleVariant): TBasicActionLinkClass;
begin
  Result := TBasicActionLinkClass(ConvFromVar(AValue, TBasicActionLink));
end;

{ TBasicAction_sw }

function TBasicAction_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnChange: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TBasicAction_sacc(TBasicAction(AObj)).
      OnChange)
  else
    TBasicAction_sacc(TBasicAction(AObj)).OnChange := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TBasicAction_HandlesTarget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HandlesTarget(Target: TObject): Boolean;

  Result := TBasicAction(AObj).HandlesTarget(TObject_sw.FromVar(AArgs[0]));
end;

function TBasicAction_UpdateTarget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UpdateTarget(Target: TObject);

  TBasicAction(AObj).UpdateTarget(TObject_sw.FromVar(AArgs[0]));
end;

function TBasicAction_ExecuteTarget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ExecuteTarget(Target: TObject);

  TBasicAction(AObj).ExecuteTarget(TObject_sw.FromVar(AArgs[0]));
end;

function TBasicAction_Execute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Execute: Boolean;

  Result := TBasicAction(AObj).Execute();
end;

function TBasicAction_RegisterChanges_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RegisterChanges(Value: TBasicActionLink);

  TBasicAction(AObj).RegisterChanges(TBasicActionLink_sw.FromVar(AArgs[0]));
end;

function TBasicAction_UnRegisterChanges_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnRegisterChanges(Value: TBasicActionLink);

  TBasicAction(AObj).UnRegisterChanges(TBasicActionLink_sw.FromVar(AArgs[0]));
end;

function TBasicAction_Update_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Update: Boolean;

  Result := TBasicAction(AObj).Update();
end;

function TBasicAction_ActionComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionComponent: TComponent read <getter> write ...

  if IsGet then
    Result := TComponent_sw.ToVar(TBasicAction(AObj).ActionComponent)
  else
    TBasicAction(AObj).ActionComponent := TComponent_sw.FromVar(AArgs[0]);
end;

function TBasicAction_OnExecute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnExecute: TNotifyEvent read <getter> write <set...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TBasicAction(AObj).OnExecute)
  else
    TBasicAction(AObj).OnExecute := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TBasicAction_OnUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnUpdate: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TBasicAction(AObj).OnUpdate)
  else
    TBasicAction(AObj).OnUpdate := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TBasicAction_sw.GetTypeName: WideString;
begin
  Result := 'TBasicAction';
end;

class function TBasicAction_sw.GetWrappedClass: TClass;
begin
  Result := TBasicAction;
end;

class procedure TBasicAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('OnChange', TBasicAction_OnChange_si, TNotifyEvent_sw, True, True, 0, True);
  AData.AddFunction('HandlesTarget', TBasicAction_HandlesTarget_si, Boolean_sw, 1, False);
  AData.AddProcedure('UpdateTarget', TBasicAction_UpdateTarget_si, 1, False);
  AData.AddProcedure('ExecuteTarget', TBasicAction_ExecuteTarget_si, 1, False);
  AData.AddFunction('Execute', TBasicAction_Execute_si, Boolean_sw, 0, False);
  AData.AddProcedure('RegisterChanges', TBasicAction_RegisterChanges_si, 1, False);
  AData.AddProcedure('UnRegisterChanges', TBasicAction_UnRegisterChanges_si, 1, False);
  AData.AddFunction('Update', TBasicAction_Update_si, Boolean_sw, 0, False);
  AData.AddProperty('ActionComponent', TBasicAction_ActionComponent_si, TComponent_sw, True, True, 0, False);
  AData.AddProperty('OnExecute', TBasicAction_OnExecute_si, TNotifyEvent_sw, True, True, 0, False);
  AData.AddProperty('OnUpdate', TBasicAction_OnUpdate_si, TNotifyEvent_sw, True, True, 0, False);
end;

class function TBasicAction_sw.ToVar(const AValue: TBasicAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBasicAction_sw.FromVar(const AValue: OleVariant): TBasicAction;
begin
  Result := TBasicAction(ConvFromVar(AValue, TBasicAction));
end;

class function TBasicAction_sw.ClassToVar(AClass: TBasicAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBasicAction_sw.ClassFromVar(
  const AClass: OleVariant): TBasicAction_sc;
begin
  Result := TBasicAction_sc(ConvClsFromVar(AClass, TBasicAction));
end;

{ TBasicActionClass_sw }

class function TBasicActionClass_sw.GetTypeName: WideString;
begin
  Result := 'TBasicActionClass';
end;

class function TBasicActionClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TBasicAction;
end;

class function TBasicActionClass_sw.ToVar(
  const AValue: TBasicActionClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBasicActionClass_sw.FromVar(
  const AValue: OleVariant): TBasicActionClass;
begin
  Result := TBasicActionClass(ConvFromVar(AValue, TBasicAction));
end;

{ TDataModule_sw }

function TDataModule_CreateNew_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor CreateNew(AOwner: TComponent; Dummy: Integer);

  Result := TDataModule_sw.ToVar(TDataModule_sc(AObj).CreateNew(TComponent_sw.
    FromVar(AArgs[0]), Integer(AArgs[1])));
end;

function TDataModule_DesignOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DesignOffset: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TDataModule(AObj).DesignOffset)
  else
    TDataModule(AObj).DesignOffset := TPoint_sw.FromVar(AArgs[0]);
end;

function TDataModule_DesignSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DesignSize: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TDataModule(AObj).DesignSize)
  else
    TDataModule(AObj).DesignSize := TPoint_sw.FromVar(AArgs[0]);
end;

function TDataModule_OldCreateOrder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OldCreateOrder: Boolean read <getter> write <set...

  if IsGet then
    Result := TDataModule(AObj).OldCreateOrder
  else
    TDataModule(AObj).OldCreateOrder := Boolean(AArgs[0]);
end;

function TDataModule_OnCreate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCreate: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TDataModule(AObj).OnCreate)
  else
    TDataModule(AObj).OnCreate := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDataModule_OnDestroy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDestroy: TNotifyEvent read <getter> write <set...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TDataModule(AObj).OnDestroy)
  else
    TDataModule(AObj).OnDestroy := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TDataModule_sw.GetTypeName: WideString;
begin
  Result := 'TDataModule';
end;

class function TDataModule_sw.GetWrappedClass: TClass;
begin
  Result := TDataModule;
end;

class procedure TDataModule_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DesignOffset', TDataModule_DesignOffset_si, TPoint_sw, True, True, 0, False);
  AData.AddProperty('DesignSize', TDataModule_DesignSize_si, TPoint_sw, True, True, 0, False);
  AData.AddProperty('OldCreateOrder', TDataModule_OldCreateOrder_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('OnCreate', TDataModule_OnCreate_si, TNotifyEvent_sw, True, True, 0, False);
  AData.AddProperty('OnDestroy', TDataModule_OnDestroy_si, TNotifyEvent_sw, True, True, 0, False);

  { Class members }

  AData.AddConstructor('CreateNew', TDataModule_CreateNew_si, 2, False);
end;

class function TDataModule_sw.ToVar(const AValue: TDataModule): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDataModule_sw.FromVar(const AValue: OleVariant): TDataModule;
begin
  Result := TDataModule(ConvFromVar(AValue, TDataModule));
end;

class function TDataModule_sw.ClassToVar(AClass: TDataModule_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDataModule_sw.ClassFromVar(
  const AClass: OleVariant): TDataModule_sc;
begin
  Result := TDataModule_sc(ConvClsFromVar(AClass, TDataModule));
end;

{ TActiveXRegType_sw }

class function TActiveXRegType_sw.GetTypeName: WideString;
begin
  Result := 'TActiveXRegType';
end;

class function TActiveXRegType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TActiveXRegType);
end;

class function TActiveXRegType_sw.ToVar(
  const AValue: TActiveXRegType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TActiveXRegType_sw.FromVar(
  const AValue: OleVariant): TActiveXRegType;
begin
  Result := TActiveXRegType(Integer(AValue));
end;

{ TIdentMapEntry_sw }

function TIdentMapEntry_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TIdentMapEntry_sw.ToVar(TIdentMapEntry(AObj));
end;

function TIdentMapEntry_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TIdentMapEntry_sw.Create as IDispatch;
end;

function TIdentMapEntry_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Value: Integer;

  if IsGet then
    Result := TIdentMapEntry_sw(AObj).FValue.Value
  else
    TIdentMapEntry_sw(AObj).FValue.Value := Integer(AArgs[0]);
end;

function TIdentMapEntry_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Name: string;

  if IsGet then
    Result := TIdentMapEntry_sw(AObj).FValue.Name
  else
    TIdentMapEntry_sw(AObj).FValue.Name := string(AArgs[0]);
end;

class function TIdentMapEntry_sw.GetTypeName: WideString;
begin
  Result := 'TIdentMapEntry';
end;

function TIdentMapEntry_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TIdentMapEntry_sw.Create;
  TIdentMapEntry_sw(Result).FValue := FValue;
end;

class procedure TIdentMapEntry_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TIdentMapEntry_Copy_si, TIdentMapEntry_sw, 0);
  AData.AddField('Value', TIdentMapEntry_Value_si, Integer_sw);
  AData.AddField('Name', TIdentMapEntry_Name_si, string_sw);

  { Class members }

  AData.AddConstructor('Create', TIdentMapEntry_Create_si, 0);
end;

class function TIdentMapEntry_sw.ToVar(
  const AValue: TIdentMapEntry): OleVariant;
var
  wrpr: TIdentMapEntry_sw;
begin
  wrpr        := TIdentMapEntry_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TIdentMapEntry_sw.FromVar(
  const AValue: OleVariant): TIdentMapEntry;
begin
  Result := TIdentMapEntry_sw(ConvFromVar(AValue)).FValue;
end;

{ TStreamOriginalFormat_sw }

class function TStreamOriginalFormat_sw.GetTypeName: WideString;
begin
  Result := 'TStreamOriginalFormat';
end;

class function TStreamOriginalFormat_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TStreamOriginalFormat);
end;

class function TStreamOriginalFormat_sw.ToVar(
  const AValue: TStreamOriginalFormat): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TStreamOriginalFormat_sw.FromVar(
  const AValue: OleVariant): TStreamOriginalFormat;
begin
  Result := TStreamOriginalFormat(Integer(AValue));
end;

{ Classes_sw }

function Classes_soFromBeginning_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const soFromBeginning = <value>;

  Result := soFromBeginning;
end;

function Classes_soFromCurrent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const soFromCurrent = <value>;

  Result := soFromCurrent;
end;

function Classes_soFromEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const soFromEnd = <value>;

  Result := soFromEnd;
end;

function Classes_TSeekOrigin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSeekOrigin = (soCurrent, soEnd);

  Result := TLMDUnitWrapper.TypeToVar(TSeekOrigin_sw);
end;

function Classes_fmCreate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmCreate = <value>;

  Result := fmCreate;
end;

function Classes_scShift_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const scShift = <value>;

  Result := scShift;
end;

function Classes_scCtrl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const scCtrl = <value>;

  Result := scCtrl;
end;

function Classes_scAlt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const scAlt = <value>;

  Result := scAlt;
end;

function Classes_scNone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const scNone = <value>;

  Result := scNone;
end;

function Classes_TAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAlignment = (taRightJustify, taCenter);

  Result := TLMDUnitWrapper.TypeToVar(TAlignment_sw);
end;

function Classes_TLeftRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLeftRight = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TLeftRight_sw);
end;

function Classes_TBiDiMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBiDiMode = (bdRightToLeft, bdRightToLeftNoAlign, bd...

  Result := TLMDUnitWrapper.TypeToVar(TBiDiMode_sw);
end;

function Classes_TVerticalAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVerticalAlignment = (taAlignBottom, taVerticalCenter);

  Result := TLMDUnitWrapper.TypeToVar(TVerticalAlignment_sw);
end;

function Classes_TTopBottom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTopBottom = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TTopBottom_sw);
end;

function Classes_THelpContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THelpContext = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(THelpContext_sw);
end;

function Classes_THelpType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THelpType = (htContext);

  Result := TLMDUnitWrapper.TypeToVar(THelpType_sw);
end;

function Classes_TShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TShortCut = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TShortCut_sw);
end;

function Classes_TNotifyEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNotifyEvent = procedure (Sender: TObject) of object;

  Result := TLMDUnitWrapper.TypeToVar(TNotifyEvent_sw);
end;

function Classes_TGetStrProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetStrProc = procedure (const S: string) of object;

  Result := TLMDUnitWrapper.TypeToVar(TGetStrProc_sw);
end;

function Classes_EStreamError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EStreamError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EStreamError_sw);
end;

function Classes_EFileStreamError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EFileStreamError = class(EStreamError);

  Result := TLMDUnitWrapper.TypeToVar(EFileStreamError_sw);
end;

function Classes_EFCreateError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EFCreateError = class(EFileStreamError);

  Result := TLMDUnitWrapper.TypeToVar(EFCreateError_sw);
end;

function Classes_EFOpenError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EFOpenError = class(EFileStreamError);

  Result := TLMDUnitWrapper.TypeToVar(EFOpenError_sw);
end;

function Classes_EFilerError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EFilerError = class(EStreamError);

  Result := TLMDUnitWrapper.TypeToVar(EFilerError_sw);
end;

function Classes_EReadError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EReadError = class(EFilerError);

  Result := TLMDUnitWrapper.TypeToVar(EReadError_sw);
end;

function Classes_EWriteError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EWriteError = class(EFilerError);

  Result := TLMDUnitWrapper.TypeToVar(EWriteError_sw);
end;

function Classes_EClassNotFound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EClassNotFound = class(EFilerError);

  Result := TLMDUnitWrapper.TypeToVar(EClassNotFound_sw);
end;

function Classes_EMethodNotFound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EMethodNotFound = class(EFilerError);

  Result := TLMDUnitWrapper.TypeToVar(EMethodNotFound_sw);
end;

function Classes_EInvalidImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EInvalidImage = class(EFilerError);

  Result := TLMDUnitWrapper.TypeToVar(EInvalidImage_sw);
end;

function Classes_EResNotFound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EResNotFound = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EResNotFound_sw);
end;

function Classes_EListError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EListError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EListError_sw);
end;

function Classes_EBitsError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EBitsError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EBitsError_sw);
end;

function Classes_EStringListError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EStringListError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EStringListError_sw);
end;

function Classes_EComponentError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EComponentError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EComponentError_sw);
end;

function Classes_EParserError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EParserError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EParserError_sw);
end;

function Classes_EOutOfResources_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EOutOfResources = class(EOutOfMemory);

  Result := TLMDUnitWrapper.TypeToVar(EOutOfResources_sw);
end;

function Classes_EInvalidOperation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EInvalidOperation = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EInvalidOperation_sw);
end;

function Classes_TDuplicates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDuplicates = (dupAccept, dupError);

  Result := TLMDUnitWrapper.TypeToVar(TDuplicates_sw);
end;

function Classes_TListNotification_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListNotification = (lnExtracted, lnDeleted);

  Result := TLMDUnitWrapper.TypeToVar(TListNotification_sw);
end;

function Classes_TListAssignOp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListAssignOp = (laAnd, laOr, laXor, laSrcUnique, la...

  Result := TLMDUnitWrapper.TypeToVar(TListAssignOp_sw);
end;

function Classes_TListEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TListEnumerator_sw);
end;

function Classes_TList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TList = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TList_sw);
end;

function Classes_TThreadList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TThreadList = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TThreadList_sw);
end;

function Classes_TInterfaceListEnumerator_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInterfaceListEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TInterfaceListEnumerator_sw);
end;

function Classes_TInterfaceList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInterfaceList = class(TInterfacedObject, IInterface...

  Result := TLMDUnitWrapper.TypeToVar(TInterfaceList_sw);
end;

function Classes_TBits_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBits = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TBits_sw);
end;

function Classes_TPersistent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPersistent = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TPersistent_sw);
end;

function Classes_TPersistentClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPersistentClass = class of TPersistent;

  Result := TLMDUnitWrapper.TypeToVar(TPersistentClass_sw);
end;

function Classes_TInterfacedPersistent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInterfacedPersistent = class(TPersistent, IInterface);

  Result := TLMDUnitWrapper.TypeToVar(TInterfacedPersistent_sw);
end;

function Classes_TRecall_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRecall = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TRecall_sw);
end;

function Classes_TCollectionItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCollectionItem = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TCollectionItem_sw);
end;

function Classes_TCollectionItemClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCollectionItemClass = class of TCollectionItem;

  Result := TLMDUnitWrapper.TypeToVar(TCollectionItemClass_sw);
end;

function Classes_TCollectionNotification_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCollectionNotification = (cnExtracting, cnDeleting);

  Result := TLMDUnitWrapper.TypeToVar(TCollectionNotification_sw);
end;

function Classes_TCollectionEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCollectionEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TCollectionEnumerator_sw);
end;

function Classes_TCollection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCollection = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TCollection_sw);
end;

function Classes_TOwnedCollection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOwnedCollection = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(TOwnedCollection_sw);
end;

function Classes_TGetModuleProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetModuleProc = procedure (const FileName: string; ...

  Result := TLMDUnitWrapper.TypeToVar(TGetModuleProc_sw);
end;

function Classes_TStringsEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStringsEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TStringsEnumerator_sw);
end;

function Classes_TStrings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStrings = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TStrings_sw);
end;

function Classes_TStringItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStringItem = record;

  Result := TLMDUnitWrapper.TypeToVar(TStringItem_sw);
end;

function Classes_TStringList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStringList = class(TStrings);

  Result := TLMDUnitWrapper.TypeToVar(TStringList_sw);
end;

function Classes_TStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStream = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TStream_sw);
end;

function Classes_THandleStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THandleStream = class(TStream);

  Result := TLMDUnitWrapper.TypeToVar(THandleStream_sw);
end;

function Classes_TFileStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileStream = class(THandleStream);

  Result := TLMDUnitWrapper.TypeToVar(TFileStream_sw);
end;

function Classes_TCustomMemoryStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomMemoryStream = class(TStream);

  Result := TLMDUnitWrapper.TypeToVar(TCustomMemoryStream_sw);
end;

function Classes_TMemoryStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMemoryStream = class(TCustomMemoryStream);

  Result := TLMDUnitWrapper.TypeToVar(TMemoryStream_sw);
end;

function Classes_TStringStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStringStream = class(TStream);

  Result := TLMDUnitWrapper.TypeToVar(TStringStream_sw);
end;

function Classes_TResourceStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TResourceStream = class(TCustomMemoryStream);

  Result := TLMDUnitWrapper.TypeToVar(TResourceStream_sw);
end;

function Classes_TStreamOwnership_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStreamOwnership = (soOwned);

  Result := TLMDUnitWrapper.TypeToVar(TStreamOwnership_sw);
end;

function Classes_TStreamAdapter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStreamAdapter = class(TInterfacedObject, IStream);

  Result := TLMDUnitWrapper.TypeToVar(TStreamAdapter_sw);
end;

function Classes_TGetClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetClass = procedure (AClass: TPersistentClass) of ...

  Result := TLMDUnitWrapper.TypeToVar(TGetClass_sw);
end;

function Classes_TClassFinder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TClassFinder = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TClassFinder_sw);
end;

function Classes_TValueType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TValueType = (vaList, vaInt8, vaInt16, vaInt32, vaEx...

  Result := TLMDUnitWrapper.TypeToVar(TValueType_sw);
end;

function Classes_TFilerFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFilerFlag = (ffChildPos, ffInline);

  Result := TLMDUnitWrapper.TypeToVar(TFilerFlag_sw);
end;

function Classes_TFilerFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFilerFlags = set of TFilerFlag;

  Result := TLMDUnitWrapper.TypeToVar(TFilerFlags_sw);
end;

function Classes_TReaderProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TReaderProc = procedure (Reader: TReader) of object;

  Result := TLMDUnitWrapper.TypeToVar(TReaderProc_sw);
end;

function Classes_TWriterProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWriterProc = procedure (Writer: TWriter) of object;

  Result := TLMDUnitWrapper.TypeToVar(TWriterProc_sw);
end;

function Classes_TStreamProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStreamProc = procedure (Stream: TStream) of object;

  Result := TLMDUnitWrapper.TypeToVar(TStreamProc_sw);
end;

function Classes_TFiler_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFiler = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TFiler_sw);
end;

function Classes_TComponentClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComponentClass = class of TComponent;

  Result := TLMDUnitWrapper.TypeToVar(TComponentClass_sw);
end;

function Classes_TSetNameEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSetNameEvent = procedure (Reader: TReader; Componen...

  Result := TLMDUnitWrapper.TypeToVar(TSetNameEvent_sw);
end;

function Classes_TReferenceNameEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TReferenceNameEvent = procedure (Reader: TReader; va...

  Result := TLMDUnitWrapper.TypeToVar(TReferenceNameEvent_sw);
end;

function Classes_TAncestorNotFoundEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAncestorNotFoundEvent = procedure (Reader: TReader;...

  Result := TLMDUnitWrapper.TypeToVar(TAncestorNotFoundEvent_sw);
end;

function Classes_TReadComponentsProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TReadComponentsProc = procedure (Component: TCompone...

  Result := TLMDUnitWrapper.TypeToVar(TReadComponentsProc_sw);
end;

function Classes_TReaderError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TReaderError = procedure (Reader: TReader; const Mes...

  Result := TLMDUnitWrapper.TypeToVar(TReaderError_sw);
end;

function Classes_TFindComponentClassEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindComponentClassEvent = procedure (Reader: TReade...

  Result := TLMDUnitWrapper.TypeToVar(TFindComponentClassEvent_sw);
end;

function Classes_TCreateComponentEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCreateComponentEvent = procedure (Reader: TReader; ...

  Result := TLMDUnitWrapper.TypeToVar(TCreateComponentEvent_sw);
end;

function Classes_TReader_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TReader = class(TFiler);

  Result := TLMDUnitWrapper.TypeToVar(TReader_sw);
end;

function Classes_TFindAncestorEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindAncestorEvent = procedure (Writer: TWriter; Com...

  Result := TLMDUnitWrapper.TypeToVar(TFindAncestorEvent_sw);
end;

function Classes_TGetLookupInfoEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetLookupInfoEvent = procedure (var Ancestor: TPers...

  Result := TLMDUnitWrapper.TypeToVar(TGetLookupInfoEvent_sw);
end;

function Classes_TWriter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWriter = class(TFiler);

  Result := TLMDUnitWrapper.TypeToVar(TWriter_sw);
end;

function Classes_TParserErrorEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParserErrorEvent = procedure (Sender: TObject; cons...

  Result := TLMDUnitWrapper.TypeToVar(TParserErrorEvent_sw);
end;

function Classes_TParser_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParser = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TParser_sw);
end;

function Classes_EThread_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EThread = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EThread_sw);
end;

function Classes_TThreadMethod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TThreadMethod = procedure  of object;

  Result := TLMDUnitWrapper.TypeToVar(TThreadMethod_sw);
end;

function Classes_TThreadPriority_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TThreadPriority = (tpLowest, tpLower, tpNormal, tpHi...

  Result := TLMDUnitWrapper.TypeToVar(TThreadPriority_sw);
end;

function Classes_TSynchronizeRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSynchronizeRecord = record;

  Result := TLMDUnitWrapper.TypeToVar(TSynchronizeRecord_sw);
end;

function Classes_TThread_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TThread = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TThread_sw);
end;

function Classes_TComponentEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComponentEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TComponentEnumerator_sw);
end;

function Classes_TOperation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOperation = (opRemove);

  Result := TLMDUnitWrapper.TypeToVar(TOperation_sw);
end;

function Classes_TGetChildProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetChildProc = procedure (Child: TComponent) of obj...

  Result := TLMDUnitWrapper.TypeToVar(TGetChildProc_sw);
end;

function Classes_TComponentName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComponentName = string;

  Result := TLMDUnitWrapper.TypeToVar(TComponentName_sw);
end;

function Classes_TComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComponent = class(TPersistent, IInterface, IInterfa...

  Result := TLMDUnitWrapper.TypeToVar(TComponent_sw);
end;

function Classes_TBasicActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBasicActionLink = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TBasicActionLink_sw);
end;

function Classes_TBasicActionLinkClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBasicActionLinkClass = class of TBasicActionLink;

  Result := TLMDUnitWrapper.TypeToVar(TBasicActionLinkClass_sw);
end;

function Classes_TBasicAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBasicAction = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TBasicAction_sw);
end;

function Classes_TBasicActionClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBasicActionClass = class of TBasicAction;

  Result := TLMDUnitWrapper.TypeToVar(TBasicActionClass_sw);
end;

function Classes_TDataModule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataModule = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TDataModule_sw);
end;

function Classes_TActiveXRegType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActiveXRegType = (axrIncludeDescendants);

  Result := TLMDUnitWrapper.TypeToVar(TActiveXRegType_sw);
end;

function Classes_Point_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Point(AX: Integer; AY: Integer): TPoint;

  Result := TPoint_sw.ToVar(Classes.Point(Integer(AArgs[0]), Integer(
    AArgs[1])));
end;

function Classes_SmallPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SmallPoint(AX: SmallInt; AY: SmallInt): TSmallPo...

  Result := TSmallPoint_sw.ToVar(Classes.SmallPoint(SmallInt(AArgs[0]), 
    SmallInt(AArgs[1])));
end;

function Classes_Rect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Rect(ALeft: Integer; ATop: Integer; ARight: Inte...

  Result := TRect_sw.ToVar(Classes.Rect(Integer(AArgs[0]), Integer(AArgs[1]), 
    Integer(AArgs[2]), Integer(AArgs[3])));
end;

function Classes_Bounds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Bounds(ALeft: Integer; ATop: Integer; AWidth: In...

  Result := TRect_sw.ToVar(Classes.Bounds(Integer(AArgs[0]), Integer(AArgs[1]), 
    Integer(AArgs[2]), Integer(AArgs[3])));
end;

function Classes_ActiveClassGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ActiveClassGroup: TPersistentClass;

  Result := TPersistentClass_sw.ToVar(Classes.ActiveClassGroup());
end;

function Classes_TIdentMapEntry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIdentMapEntry = record;

  Result := TLMDUnitWrapper.TypeToVar(TIdentMapEntry_sw);
end;

function Classes_TStreamOriginalFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStreamOriginalFormat = (sofBinary, sofText);

  Result := TLMDUnitWrapper.TypeToVar(TStreamOriginalFormat_sw);
end;

class function Classes_sw.GetUnitName: WideString;
begin
  Result := 'Classes';
end;

class procedure Classes_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('soFromBeginning', Classes_soFromBeginning_si, nil, VarType(Classes.soFromBeginning));
  AData.AddConstant('soFromCurrent', Classes_soFromCurrent_si, nil, VarType(Classes.soFromCurrent));
  AData.AddConstant('soFromEnd', Classes_soFromEnd_si, nil, VarType(Classes.soFromEnd));
  AData.AddType(TSeekOrigin_sw, Classes_TSeekOrigin_si);
  AData.AddConstant('fmCreate', Classes_fmCreate_si, nil, VarType(Classes.fmCreate));
  AData.AddConstant('scShift', Classes_scShift_si, nil, VarType(Classes.scShift));
  AData.AddConstant('scCtrl', Classes_scCtrl_si, nil, VarType(Classes.scCtrl));
  AData.AddConstant('scAlt', Classes_scAlt_si, nil, VarType(Classes.scAlt));
  AData.AddConstant('scNone', Classes_scNone_si, nil, VarType(Classes.scNone));
  AData.AddType(TAlignment_sw, Classes_TAlignment_si);
  AData.AddType(TLeftRight_sw, Classes_TLeftRight_si);
  AData.AddType(TBiDiMode_sw, Classes_TBiDiMode_si);
  AData.AddType(TVerticalAlignment_sw, Classes_TVerticalAlignment_si);
  AData.AddType(TTopBottom_sw, Classes_TTopBottom_si);
  AData.AddType(THelpContext_sw, Classes_THelpContext_si);
  AData.AddType(THelpType_sw, Classes_THelpType_si);
  AData.AddType(TShortCut_sw, Classes_TShortCut_si);
  AData.AddType(TNotifyEvent_sw, Classes_TNotifyEvent_si);
  AData.AddType(TGetStrProc_sw, Classes_TGetStrProc_si);
  AData.AddType(EStreamError_sw, Classes_EStreamError_si);
  AData.AddType(EFileStreamError_sw, Classes_EFileStreamError_si);
  AData.AddType(EFCreateError_sw, Classes_EFCreateError_si);
  AData.AddType(EFOpenError_sw, Classes_EFOpenError_si);
  AData.AddType(EFilerError_sw, Classes_EFilerError_si);
  AData.AddType(EReadError_sw, Classes_EReadError_si);
  AData.AddType(EWriteError_sw, Classes_EWriteError_si);
  AData.AddType(EClassNotFound_sw, Classes_EClassNotFound_si);
  AData.AddType(EMethodNotFound_sw, Classes_EMethodNotFound_si);
  AData.AddType(EInvalidImage_sw, Classes_EInvalidImage_si);
  AData.AddType(EResNotFound_sw, Classes_EResNotFound_si);
  AData.AddType(EListError_sw, Classes_EListError_si);
  AData.AddType(EBitsError_sw, Classes_EBitsError_si);
  AData.AddType(EStringListError_sw, Classes_EStringListError_si);
  AData.AddType(EComponentError_sw, Classes_EComponentError_si);
  AData.AddType(EParserError_sw, Classes_EParserError_si);
  AData.AddType(EOutOfResources_sw, Classes_EOutOfResources_si);
  AData.AddType(EInvalidOperation_sw, Classes_EInvalidOperation_si);
  AData.AddType(TDuplicates_sw, Classes_TDuplicates_si);
  AData.AddType(TListNotification_sw, Classes_TListNotification_si);
  AData.AddType(TListAssignOp_sw, Classes_TListAssignOp_si);
  AData.AddType(TListEnumerator_sw, Classes_TListEnumerator_si);
  AData.AddType(TList_sw, Classes_TList_si);
  AData.AddType(TThreadList_sw, Classes_TThreadList_si);
  AData.AddType(TInterfaceListEnumerator_sw, Classes_TInterfaceListEnumerator_si);
  AData.AddType(TInterfaceList_sw, Classes_TInterfaceList_si);
  AData.AddType(TBits_sw, Classes_TBits_si);
  AData.AddType(TPersistent_sw, Classes_TPersistent_si);
  AData.AddType(TPersistentClass_sw, Classes_TPersistentClass_si);
  AData.AddType(TInterfacedPersistent_sw, Classes_TInterfacedPersistent_si);
  AData.AddType(TRecall_sw, Classes_TRecall_si);
  AData.AddType(TCollectionItem_sw, Classes_TCollectionItem_si);
  AData.AddType(TCollectionItemClass_sw, Classes_TCollectionItemClass_si);
  AData.AddType(TCollectionNotification_sw, Classes_TCollectionNotification_si);
  AData.AddType(TCollectionEnumerator_sw, Classes_TCollectionEnumerator_si);
  AData.AddType(TCollection_sw, Classes_TCollection_si);
  AData.AddType(TOwnedCollection_sw, Classes_TOwnedCollection_si);
  AData.AddType(TGetModuleProc_sw, Classes_TGetModuleProc_si);
  AData.AddType(TStringsEnumerator_sw, Classes_TStringsEnumerator_si);
  AData.AddType(TStrings_sw, Classes_TStrings_si);
  AData.AddType(TStringItem_sw, Classes_TStringItem_si);
  AData.AddType(TStringList_sw, Classes_TStringList_si);
  AData.AddType(TStream_sw, Classes_TStream_si);
  AData.AddType(THandleStream_sw, Classes_THandleStream_si);
  AData.AddType(TFileStream_sw, Classes_TFileStream_si);
  AData.AddType(TCustomMemoryStream_sw, Classes_TCustomMemoryStream_si);
  AData.AddType(TMemoryStream_sw, Classes_TMemoryStream_si);
  AData.AddType(TStringStream_sw, Classes_TStringStream_si);
  AData.AddType(TResourceStream_sw, Classes_TResourceStream_si);
  AData.AddType(TStreamOwnership_sw, Classes_TStreamOwnership_si);
  AData.AddType(TStreamAdapter_sw, Classes_TStreamAdapter_si);
  AData.AddType(TGetClass_sw, Classes_TGetClass_si);
  AData.AddType(TClassFinder_sw, Classes_TClassFinder_si);
  AData.AddType(TValueType_sw, Classes_TValueType_si);
  AData.AddType(TFilerFlag_sw, Classes_TFilerFlag_si);
  AData.AddType(TFilerFlags_sw, Classes_TFilerFlags_si);
  AData.AddType(TReaderProc_sw, Classes_TReaderProc_si);
  AData.AddType(TWriterProc_sw, Classes_TWriterProc_si);
  AData.AddType(TStreamProc_sw, Classes_TStreamProc_si);
  AData.AddType(TFiler_sw, Classes_TFiler_si);
  AData.AddType(TComponentClass_sw, Classes_TComponentClass_si);
  AData.AddType(TSetNameEvent_sw, Classes_TSetNameEvent_si);
  AData.AddType(TReferenceNameEvent_sw, Classes_TReferenceNameEvent_si);
  AData.AddType(TAncestorNotFoundEvent_sw, Classes_TAncestorNotFoundEvent_si);
  AData.AddType(TReadComponentsProc_sw, Classes_TReadComponentsProc_si);
  AData.AddType(TReaderError_sw, Classes_TReaderError_si);
  AData.AddType(TFindComponentClassEvent_sw, Classes_TFindComponentClassEvent_si);
  AData.AddType(TCreateComponentEvent_sw, Classes_TCreateComponentEvent_si);
  AData.AddType(TReader_sw, Classes_TReader_si);
  AData.AddType(TFindAncestorEvent_sw, Classes_TFindAncestorEvent_si);
  AData.AddType(TGetLookupInfoEvent_sw, Classes_TGetLookupInfoEvent_si);
  AData.AddType(TWriter_sw, Classes_TWriter_si);
  AData.AddType(TParserErrorEvent_sw, Classes_TParserErrorEvent_si);
  AData.AddType(TParser_sw, Classes_TParser_si);
  AData.AddType(EThread_sw, Classes_EThread_si);
  AData.AddType(TThreadMethod_sw, Classes_TThreadMethod_si);
  AData.AddType(TThreadPriority_sw, Classes_TThreadPriority_si);
  AData.AddType(TSynchronizeRecord_sw, Classes_TSynchronizeRecord_si);
  AData.AddType(TThread_sw, Classes_TThread_si);
  AData.AddType(TComponentEnumerator_sw, Classes_TComponentEnumerator_si);
  AData.AddType(TOperation_sw, Classes_TOperation_si);
  AData.AddType(TGetChildProc_sw, Classes_TGetChildProc_si);
  AData.AddType(TComponentName_sw, Classes_TComponentName_si);
  AData.AddType(TComponent_sw, Classes_TComponent_si);
  AData.AddType(TBasicActionLink_sw, Classes_TBasicActionLink_si);
  AData.AddType(TBasicActionLinkClass_sw, Classes_TBasicActionLinkClass_si);
  AData.AddType(TBasicAction_sw, Classes_TBasicAction_si);
  AData.AddType(TBasicActionClass_sw, Classes_TBasicActionClass_si);
  AData.AddType(TDataModule_sw, Classes_TDataModule_si);
  AData.AddType(TActiveXRegType_sw, Classes_TActiveXRegType_si);
  AData.AddFunction('Point', Classes_Point_si, TPoint_sw, 2, False);
  AData.AddFunction('SmallPoint', Classes_SmallPoint_si, TSmallPoint_sw, 2, False);
  AData.AddFunction('Rect', Classes_Rect_si, TRect_sw, 4, False);
  AData.AddFunction('Bounds', Classes_Bounds_si, TRect_sw, 4, False);
  AData.AddFunction('ActiveClassGroup', Classes_ActiveClassGroup_si, TPersistentClass_sw, 0, False);
  AData.AddType(TIdentMapEntry_sw, Classes_TIdentMapEntry_si);
  AData.AddType(TStreamOriginalFormat_sw, Classes_TStreamOriginalFormat_si);
end;

class function Classes_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Classes_sw);
end;

initialization
  RegisterUnitWrapper(Classes_sw);
  RegisterClassWrapper(EStreamError_sw);
  RegisterClassWrapper(EFileStreamError_sw);
  RegisterClassWrapper(EFCreateError_sw);
  RegisterClassWrapper(EFOpenError_sw);
  RegisterClassWrapper(EFilerError_sw);
  RegisterClassWrapper(EReadError_sw);
  RegisterClassWrapper(EWriteError_sw);
  RegisterClassWrapper(EClassNotFound_sw);
  RegisterClassWrapper(EMethodNotFound_sw);
  RegisterClassWrapper(EInvalidImage_sw);
  RegisterClassWrapper(EResNotFound_sw);
  RegisterClassWrapper(EListError_sw);
  RegisterClassWrapper(EBitsError_sw);
  RegisterClassWrapper(EStringListError_sw);
  RegisterClassWrapper(EComponentError_sw);
  RegisterClassWrapper(EParserError_sw);
  RegisterClassWrapper(EOutOfResources_sw);
  RegisterClassWrapper(EInvalidOperation_sw);
  RegisterClassWrapper(TListEnumerator_sw);
  RegisterClassWrapper(TList_sw);
  RegisterClassWrapper(TThreadList_sw);
  RegisterClassWrapper(TInterfaceListEnumerator_sw);
  RegisterClassWrapper(TInterfaceList_sw);
  RegisterClassWrapper(TBits_sw);
  RegisterClassWrapper(TPersistent_sw);
  RegisterClassWrapper(TInterfacedPersistent_sw);
  RegisterClassWrapper(TRecall_sw);
  RegisterClassWrapper(TCollectionItem_sw);
  RegisterClassWrapper(TCollectionEnumerator_sw);
  RegisterClassWrapper(TCollection_sw);
  RegisterClassWrapper(TOwnedCollection_sw);
  RegisterClassWrapper(TStringsEnumerator_sw);
  RegisterClassWrapper(TStrings_sw);
  RegisterClassWrapper(TStringList_sw);
  RegisterClassWrapper(TStream_sw);
  RegisterClassWrapper(THandleStream_sw);
  RegisterClassWrapper(TFileStream_sw);
  RegisterClassWrapper(TCustomMemoryStream_sw);
  RegisterClassWrapper(TMemoryStream_sw);
  RegisterClassWrapper(TStringStream_sw);
  RegisterClassWrapper(TResourceStream_sw);
  RegisterClassWrapper(TStreamAdapter_sw);
  RegisterClassWrapper(TClassFinder_sw);
  RegisterClassWrapper(TFiler_sw);
  RegisterClassWrapper(TReader_sw);
  RegisterClassWrapper(TWriter_sw);
  RegisterClassWrapper(TParser_sw);
  RegisterClassWrapper(EThread_sw);
  RegisterClassWrapper(TThread_sw);
  RegisterClassWrapper(TComponentEnumerator_sw);
  RegisterClassWrapper(TComponent_sw);
  RegisterClassWrapper(TBasicActionLink_sw);
  RegisterClassWrapper(TBasicAction_sw);
  RegisterClassWrapper(TDataModule_sw);
  RegisterEventWrapper(TypeInfo(TNotifyEvent), TNotifyEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetStrProc), TGetStrProc_sw);
  RegisterEventWrapper(TypeInfo(TGetModuleProc), TGetModuleProc_sw);
  RegisterEventWrapper(TypeInfo(TGetClass), TGetClass_sw);
  RegisterEventWrapper(TypeInfo(TReaderProc), TReaderProc_sw);
  RegisterEventWrapper(TypeInfo(TWriterProc), TWriterProc_sw);
  RegisterEventWrapper(TypeInfo(TStreamProc), TStreamProc_sw);
  RegisterEventWrapper(TypeInfo(TSetNameEvent), TSetNameEvent_sw);
  RegisterEventWrapper(TypeInfo(TReferenceNameEvent), TReferenceNameEvent_sw);
  RegisterEventWrapper(TypeInfo(TAncestorNotFoundEvent), TAncestorNotFoundEvent_sw);
  RegisterEventWrapper(TypeInfo(TReadComponentsProc), TReadComponentsProc_sw);
  RegisterEventWrapper(TypeInfo(TReaderError), TReaderError_sw);
  RegisterEventWrapper(TypeInfo(TFindComponentClassEvent), TFindComponentClassEvent_sw);
  RegisterEventWrapper(TypeInfo(TCreateComponentEvent), TCreateComponentEvent_sw);
  RegisterEventWrapper(TypeInfo(TFindAncestorEvent), TFindAncestorEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetLookupInfoEvent), TGetLookupInfoEvent_sw);
  RegisterEventWrapper(TypeInfo(TParserErrorEvent), TParserErrorEvent_sw);
  RegisterEventWrapper(TypeInfo(TThreadMethod), TThreadMethod_sw);
  RegisterEventWrapper(TypeInfo(TGetChildProc), TGetChildProc_sw);

end.
