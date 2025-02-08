unit System.Classes_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'System.Classes' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Classes, System.Variants, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Winapi.Windows, Winapi.Messages, System.Types,
  System.TypInfo, System.SysUtils, Winapi.Windows_LMDSW, Winapi.Messages_LMDSW,
  System.Types_LMDSW, System.TypInfo_LMDSW, System.SysUtils_LMDSW;


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
  TBytesStream_sw = class;
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
  EThreadExternalException_sw = class;
  TThread_sw = class;
  TComponentEnumerator_sw = class;
  ComponentPlatformsAttribute_sw = class;
  TObservers_sw = class;
  TLinkObservers_sw = class;
  TObserverMapping_sw = class;
  EObserverException_sw = class;
  TDefaultAttributeBase_sw = class;
  DefaultAttribute_sw = class;
  NoDefaultAttribute_sw = class;
  ObservableMemberAttribute_sw = class;
  TBaseAsyncResult_sw = class;
  TComponent_sw = class;
  TBasicActionLink_sw = class;
  TBasicActionLinkClass_sw = class;
  TBasicAction_sw = class;
  TBasicActionClass_sw = class;
  TDataModule_sw = class;
  TTextReader_sw = class;
  TTextWriter_sw = class;
  TBinaryReader_sw = class;
  TBinaryWriter_sw = class;
  TStringReader_sw = class;
  TStringWriter_sw = class;
  TStreamWriter_sw = class;
  TStreamReader_sw = class;
  ELoginCredentialError_sw = class;
  TLoginCredentialService_sw = class;

  TSeekOrigin_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TSeekOrigin): OleVariant;
    class function FromVar(const AValue: OleVariant): TSeekOrigin;
  end;

  TPlatformIds_sw = UInt32_sw;

  TAlignment_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
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
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBiDiMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TBiDiMode;
  end;

  TVerticalAlignment_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
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
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
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

  EListError_sw = System.SysUtils_LMDSW.EListError_sw;

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

  TDuplicates_sw = System.Types_LMDSW.TDuplicates_sw;

  TListNotification_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TListNotification): OleVariant;
    class function FromVar(const AValue: OleVariant): TListNotification;
  end;

  TListAssignOp_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
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
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
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

  TBytesStream_sc = class of TBytesStream;
  TBytesStream_sw = class(TMemoryStream_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBytesStream): OleVariant;
    class function FromVar(const AValue: OleVariant): TBytesStream;
    class function ClassToVar(AClass: TBytesStream_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBytesStream_sc;
  end;

  TStringStream_sc = class of TStringStream;
  TStringStream_sw = class(TBytesStream_sw)
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
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
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
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TValueType): OleVariant;
    class function FromVar(const AValue: OleVariant): TValueType;
  end;

  TFilerFlag_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
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

  TFindMethodInstanceEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Reader: TReader; const MethodName: string;
      var AMethod: TMethod; var Error: Boolean);
  end;

  TFindMethodInstanceEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFindMethodInstanceEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFindMethodInstanceEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFindMethodInstanceEvent;
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

  TFindMethodNameEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Writer: TWriter; AMethod: TMethod;
      var MethodName: string);
  end;

  TFindMethodNameEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFindMethodNameEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFindMethodNameEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFindMethodNameEvent;
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

  EThreadExternalException_sc = class of EThreadExternalException;
  EThreadExternalException_sw = class(EThread_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EThreadExternalException): OleVariant;
    class function FromVar(const AValue: OleVariant): EThreadExternalException;
    class function ClassToVar(AClass: EThreadExternalException_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EThreadExternalException_sc;
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
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TThreadPriority): OleVariant;
    class function FromVar(const AValue: OleVariant): TThreadPriority;
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
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
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

  TGetStreamProc_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(const S: TStream);
  end;

  TGetStreamProc_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetStreamProc): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetStreamProc;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetStreamProc;
  end;

  TGetDeltaStreamsEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Proc: TGetStreamProc;
      var Handled: Boolean);
  end;

  TGetDeltaStreamsEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetDeltaStreamsEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetDeltaStreamsEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetDeltaStreamsEvent;
  end;

  TComponentName_sw = class(string_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TComponentName): OleVariant;
    class function FromVar(const AValue: OleVariant): TComponentName;
  end;

  ComponentPlatformsAttribute_sc = class of ComponentPlatformsAttribute;
  ComponentPlatformsAttribute_sw = class(TCustomAttribute_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: ComponentPlatformsAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): ComponentPlatformsAttribute;
    class function ClassToVar(AClass: ComponentPlatformsAttribute_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): ComponentPlatformsAttribute_sc;
  end;

  TObservers_sc = class of TObservers;
  TObservers_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TObservers): OleVariant;
    class function FromVar(const AValue: OleVariant): TObservers;
    class function ClassToVar(AClass: TObservers_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TObservers_sc;
  end;

  TLinkObservers_sc = class of TLinkObservers;
  TLinkObservers_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TLinkObservers): OleVariant;
    class function FromVar(const AValue: OleVariant): TLinkObservers;
    class function ClassToVar(AClass: TLinkObservers_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TLinkObservers_sc;
  end;

  TObserverMapping_sc = class of TObserverMapping;
  TObserverMapping_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TObserverMapping): OleVariant;
    class function FromVar(const AValue: OleVariant): TObserverMapping;
    class function ClassToVar(AClass: TObserverMapping_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TObserverMapping_sc;
  end;

  EObserverException_sc = class of EObserverException;
  EObserverException_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EObserverException): OleVariant;
    class function FromVar(const AValue: OleVariant): EObserverException;
    class function ClassToVar(AClass: EObserverException_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EObserverException_sc;
  end;

  TDefaultAttributeBase_sc = class of TDefaultAttributeBase;
  TDefaultAttributeBase_sw = class(TCustomAttribute_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDefaultAttributeBase): OleVariant;
    class function FromVar(const AValue: OleVariant): TDefaultAttributeBase;
    class function ClassToVar(AClass: TDefaultAttributeBase_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDefaultAttributeBase_sc;
  end;

  DefaultAttribute_sc = class of DefaultAttribute;
  DefaultAttribute_sw = class(TDefaultAttributeBase_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: DefaultAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): DefaultAttribute;
    class function ClassToVar(AClass: DefaultAttribute_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): DefaultAttribute_sc;
  end;

  NoDefaultAttribute_sc = class of NoDefaultAttribute;
  NoDefaultAttribute_sw = class(TDefaultAttributeBase_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: NoDefaultAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): NoDefaultAttribute;
    class function ClassToVar(AClass: NoDefaultAttribute_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): NoDefaultAttribute_sc;
  end;

  ObservableMemberAttribute_sc = class of ObservableMemberAttribute;
  ObservableMemberAttribute_sw = class(TCustomAttribute_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: ObservableMemberAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): ObservableMemberAttribute;
    class function ClassToVar(AClass: ObservableMemberAttribute_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): ObservableMemberAttribute_sc;
  end;

  TDesignInfo_sw = Int32_sw;

  TBaseAsyncResult_sc = class of TBaseAsyncResult;
  TBaseAsyncResult_sw = class(TInterfacedObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBaseAsyncResult): OleVariant;
    class function FromVar(const AValue: OleVariant): TBaseAsyncResult;
    class function ClassToVar(AClass: TBaseAsyncResult_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBaseAsyncResult_sc;
  end;

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

  TActionEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Action: TBasicAction; var Handled: Boolean);
  end;

  TActionEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TActionEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TActionEvent;
  end;

  THintEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(var HintStr: string; var CanShow: Boolean);
  end;

  THintEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: THintEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): THintEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): THintEvent;
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
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
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
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TStreamOriginalFormat): OleVariant;
    class function FromVar(const AValue: OleVariant): TStreamOriginalFormat;
  end;

  TWndMethod_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(var Message: TMessage);
  end;

  TWndMethod_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TWndMethod): OleVariant;
    class function FromVar(const AValue: OleVariant): TWndMethod;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TWndMethod;
  end;

  TTextReader_sc = class of TTextReader;
  TTextReader_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTextReader): OleVariant;
    class function FromVar(const AValue: OleVariant): TTextReader;
    class function ClassToVar(AClass: TTextReader_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTextReader_sc;
  end;

  TTextWriter_sc = class of TTextWriter;
  TTextWriter_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTextWriter): OleVariant;
    class function FromVar(const AValue: OleVariant): TTextWriter;
    class function ClassToVar(AClass: TTextWriter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTextWriter_sc;
  end;

  TBinaryReader_sc = class of TBinaryReader;
  TBinaryReader_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBinaryReader): OleVariant;
    class function FromVar(const AValue: OleVariant): TBinaryReader;
    class function ClassToVar(AClass: TBinaryReader_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBinaryReader_sc;
  end;

  TBinaryWriter_sc = class of TBinaryWriter;
  TBinaryWriter_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBinaryWriter): OleVariant;
    class function FromVar(const AValue: OleVariant): TBinaryWriter;
    class function ClassToVar(AClass: TBinaryWriter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBinaryWriter_sc;
  end;

  TStringReader_sc = class of TStringReader;
  TStringReader_sw = class(TTextReader_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStringReader): OleVariant;
    class function FromVar(const AValue: OleVariant): TStringReader;
    class function ClassToVar(AClass: TStringReader_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStringReader_sc;
  end;

  TStringWriter_sc = class of TStringWriter;
  TStringWriter_sw = class(TTextWriter_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStringWriter): OleVariant;
    class function FromVar(const AValue: OleVariant): TStringWriter;
    class function ClassToVar(AClass: TStringWriter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStringWriter_sc;
  end;

  TStreamWriter_sc = class of TStreamWriter;
  TStreamWriter_sw = class(TTextWriter_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStreamWriter): OleVariant;
    class function FromVar(const AValue: OleVariant): TStreamWriter;
    class function ClassToVar(AClass: TStreamWriter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStreamWriter_sc;
  end;

  TStreamReader_sc = class of TStreamReader;
  TStreamReader_sw = class(TTextReader_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStreamReader): OleVariant;
    class function FromVar(const AValue: OleVariant): TStreamReader;
    class function ClassToVar(AClass: TStreamReader_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStreamReader_sc;
  end;

  ELoginCredentialError_sc = class of ELoginCredentialError;
  ELoginCredentialError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: ELoginCredentialError): OleVariant;
    class function FromVar(const AValue: OleVariant): ELoginCredentialError;
    class function ClassToVar(AClass: ELoginCredentialError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): ELoginCredentialError_sc;
  end;

  TLoginCredentialService_sc = class of TLoginCredentialService;
  TLoginCredentialService_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TLoginCredentialService): OleVariant;
    class function FromVar(const AValue: OleVariant): TLoginCredentialService;
    class function ClassToVar(AClass: TLoginCredentialService_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TLoginCredentialService_sc;
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
  TBaseAsyncResult_sacc = class(TBaseAsyncResult);
  TComponent_sacc = class(TComponent);
  TBasicAction_sacc = class(TBasicAction);

{ TSeekOrigin_sw }

class function TSeekOrigin_sw.GetTypeName: WideString;
begin
  Result := 'TSeekOrigin';
end;

class procedure TSeekOrigin_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'soBeginning'; Value: Integer({$IFDEF LMDSCT_12}TSeekOrigin.{$ENDIF}soBeginning)),
    (Name: 'soCurrent'; Value: Integer({$IFDEF LMDSCT_12}TSeekOrigin.{$ENDIF}soCurrent)),
    (Name: 'soEnd'; Value: Integer({$IFDEF LMDSCT_12}TSeekOrigin.{$ENDIF}soEnd))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
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

class procedure TAlignment_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'taLeftJustify'; Value: Integer({$IFDEF LMDSCT_12}TAlignment.{$ENDIF}taLeftJustify)),
    (Name: 'taRightJustify'; Value: Integer({$IFDEF LMDSCT_12}TAlignment.{$ENDIF}taRightJustify)),
    (Name: 'taCenter'; Value: Integer({$IFDEF LMDSCT_12}TAlignment.{$ENDIF}taCenter))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
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

class procedure TBiDiMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'bdLeftToRight'; Value: Integer({$IFDEF LMDSCT_12}TBiDiMode.{$ENDIF}bdLeftToRight)),
    (Name: 'bdRightToLeft'; Value: Integer({$IFDEF LMDSCT_12}TBiDiMode.{$ENDIF}bdRightToLeft)),
    (Name: 'bdRightToLeftNoAlign'; Value: Integer({$IFDEF LMDSCT_12}TBiDiMode.{$ENDIF}bdRightToLeftNoAlign)),
    (Name: 'bdRightToLeftReadingOnly'; Value: Integer({$IFDEF LMDSCT_12}TBiDiMode.{$ENDIF}bdRightToLeftReadingOnly))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
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

class procedure TVerticalAlignment_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'taAlignTop'; Value: Integer({$IFDEF LMDSCT_12}TVerticalAlignment.{$ENDIF}taAlignTop)),
    (Name: 'taAlignBottom'; Value: Integer({$IFDEF LMDSCT_12}TVerticalAlignment.{$ENDIF}taAlignBottom)),
    (Name: 'taVerticalCenter'; Value: Integer({$IFDEF LMDSCT_12}TVerticalAlignment.{$ENDIF}taVerticalCenter))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
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

class procedure THelpType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'htKeyword'; Value: Integer({$IFDEF LMDSCT_12}THelpType.{$ENDIF}htKeyword)),
    (Name: 'htContext'; Value: Integer({$IFDEF LMDSCT_12}THelpType.{$ENDIF}htContext))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
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

{ TListNotification_sw }

class function TListNotification_sw.GetTypeName: WideString;
begin
  Result := 'TListNotification';
end;

class procedure TListNotification_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'lnAdded'; Value: Integer({$IFDEF LMDSCT_12}TListNotification.{$ENDIF}lnAdded)),
    (Name: 'lnExtracted'; Value: Integer({$IFDEF LMDSCT_12}TListNotification.{$ENDIF}lnExtracted)),
    (Name: 'lnDeleted'; Value: Integer({$IFDEF LMDSCT_12}TListNotification.{$ENDIF}lnDeleted))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
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

class procedure TListAssignOp_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'laCopy'; Value: Integer({$IFDEF LMDSCT_12}TListAssignOp.{$ENDIF}laCopy)),
    (Name: 'laAnd'; Value: Integer({$IFDEF LMDSCT_12}TListAssignOp.{$ENDIF}laAnd)),
    (Name: 'laOr'; Value: Integer({$IFDEF LMDSCT_12}TListAssignOp.{$ENDIF}laOr)),
    (Name: 'laXor'; Value: Integer({$IFDEF LMDSCT_12}TListAssignOp.{$ENDIF}laXor)),
    (Name: 'laSrcUnique'; Value: Integer({$IFDEF LMDSCT_12}TListAssignOp.{$ENDIF}laSrcUnique)),
    (Name: 'laDestUnique'; Value: Integer({$IFDEF LMDSCT_12}TListAssignOp.{$ENDIF}laDestUnique))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
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

function TList_Error_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure/function Error(...); overload;

  TList_sc(AObj).Error(string(AArgs[0]), NativeInt_sw.FromVar(AArgs[1]));
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

  case AArgsSize of
    1:
    begin
      TList(AObj).Assign(TList_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      TList(AObj).Assign(TList_sw.FromVar(AArgs[0]), TListAssignOp_sw.FromVar(
        AArgs[1]));
    end;
    3:
    begin
      TList(AObj).Assign(TList_sw.FromVar(AArgs[0]), TListAssignOp_sw.FromVar(
        AArgs[1]), TList_sw.FromVar(AArgs[2]));
    end;
  else
    WrongArgCountError('Assign');
  end;
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
  AData.AddProcedure('Assign', TList_Assign_si, 1, True);
  AData.AddProperty('Capacity', TList_Capacity_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Count', TList_Count_si, Integer_sw, True, True, 0, False, False);

  { Class members }

  AData.AddClassProcedure('Error', TList_Error_si, 2, False);
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
  AData.AddProperty('Duplicates', TThreadList_Duplicates_si, TDuplicates_sw, True, True, 0, False, False);

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

function TInterfaceList_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TInterfaceListEnumerator;

  Result := TInterfaceListEnumerator_sw.ToVar(TInterfaceList(AObj).
    GetEnumerator());
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
  AData.AddProcedure('Lock', TInterfaceList_Lock_si, 0, False);
  AData.AddProcedure('Unlock', TInterfaceList_Unlock_si, 0, False);
  AData.AddFunction('GetEnumerator', TInterfaceList_GetEnumerator_si, TInterfaceListEnumerator_sw, 0, False);
  AData.AddProperty('Capacity', TInterfaceList_Capacity_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Count', TInterfaceList_Count_si, Integer_sw, True, True, 0, False, False);

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
  AData.AddProperty('Bits', TBits_Bits_si, Boolean_sw, True, True, 1, False, True);
  AData.AddProperty('Size', TBits_Size_si, Integer_sw, True, True, 0, False, False);
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
  AData.AddProperty('Reference', TRecall_Reference_si, TPersistent_sw, True, False, 0, False, False);

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

function TCollectionItem_Release_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Release;

  TCollectionItem(AObj).Release();
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

  AData.AddProcedure('Release', TCollectionItem_Release_si, 0, False);
  AData.AddProperty('Collection', TCollectionItem_Collection_si, TCollection_sw, True, True, 0, False, False);
  AData.AddProperty('ID', TCollectionItem_ID_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Index', TCollectionItem_Index_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('DisplayName', TCollectionItem_DisplayName_si, string_sw, True, True, 0, False, False);

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

class procedure TCollectionNotification_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'cnAdded'; Value: Integer({$IFDEF LMDSCT_12}TCollectionNotification.{$ENDIF}cnAdded)),
    (Name: 'cnExtracting'; Value: Integer({$IFDEF LMDSCT_12}TCollectionNotification.{$ENDIF}cnExtracting)),
    (Name: 'cnDeleting'; Value: Integer({$IFDEF LMDSCT_12}TCollectionNotification.{$ENDIF}cnDeleting))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
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
  AData.AddProperty('Current', TCollectionEnumerator_Current_si, TCollectionItem_sw, True, False, 0, False, False);

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

function TCollection_Capacity_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Capacity: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCollection(AObj).Capacity
  else
    TCollection(AObj).Capacity := Integer(AArgs[0]);
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

  AData.AddProperty('NextID', TCollection_NextID_si, Integer_sw, True, False, 0, True, False);
  AData.AddProperty('PropName', TCollection_PropName_si, string_sw, True, True, 0, True, False);
  AData.AddProperty('UpdateCount', TCollection_UpdateCount_si, Integer_sw, True, False, 0, True, False);
  AData.AddFunction('Owner', TCollection_Owner_si, TPersistent_sw, 0, False);
  AData.AddFunction('Add', TCollection_Add_si, TCollectionItem_sw, 0, False);
  AData.AddProcedure('BeginUpdate', TCollection_BeginUpdate_si, 0, False);
  AData.AddProcedure('Clear', TCollection_Clear_si, 0, False);
  AData.AddProcedure('Delete', TCollection_Delete_si, 1, False);
  AData.AddProcedure('EndUpdate', TCollection_EndUpdate_si, 0, False);
  AData.AddFunction('FindItemID', TCollection_FindItemID_si, TCollectionItem_sw, 1, False);
  AData.AddFunction('GetEnumerator', TCollection_GetEnumerator_si, TCollectionEnumerator_sw, 0, False);
  AData.AddFunction('Insert', TCollection_Insert_si, TCollectionItem_sw, 1, False);
  AData.AddProperty('Capacity', TCollection_Capacity_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Count', TCollection_Count_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ItemClass', TCollection_ItemClass_si, TCollectionItemClass_sw, True, False, 0, False, False);
  AData.AddProperty('Items', TCollection_Items_si, TCollectionItem_sw, True, True, 1, False, False);

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
  AData.AddProperty('Current', TStringsEnumerator_Current_si, string_sw, True, False, 0, False, False);

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

function TStrings_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TStrings_sw.ToVar(TStrings_sc(AObj).Create());
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
  // procedure/function AddStrings(...); overload;

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
  // procedure/function LoadFromFile(...); overload;

  case AArgsSize of
    1:
    begin
      TStrings(AObj).LoadFromFile(string(AArgs[0]));
    end;
    2:
    begin
      TStrings(AObj).LoadFromFile(string(AArgs[0]), TEncoding_sw.FromVar(
        AArgs[1]));
    end;
  else
    WrongArgCountError('LoadFromFile');
  end;
end;

function TStrings_LoadFromStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function LoadFromStream(...); overload;

  case AArgsSize of
    1:
    begin
      TStrings(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      TStrings(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]), TEncoding_sw.
        FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('LoadFromStream');
  end;
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
  // procedure/function SaveToFile(...); overload;

  case AArgsSize of
    1:
    begin
      TStrings(AObj).SaveToFile(string(AArgs[0]));
    end;
    2:
    begin
      TStrings(AObj).SaveToFile(string(AArgs[0]), TEncoding_sw.FromVar(
        AArgs[1]));
    end;
  else
    WrongArgCountError('SaveToFile');
  end;
end;

function TStrings_SaveToStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SaveToStream(...); overload;

  case AArgsSize of
    1:
    begin
      TStrings(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      TStrings(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]), TEncoding_sw.
        FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('SaveToStream');
  end;
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

function TStrings_DefaultEncoding_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultEncoding: TEncoding read <getter> write <...

  if IsGet then
    Result := TEncoding_sw.ToVar(TStrings(AObj).DefaultEncoding)
  else
    TStrings(AObj).DefaultEncoding := TEncoding_sw.FromVar(AArgs[0]);
end;

function TStrings_Delimiter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Delimiter: Char read <getter> write <setter>;

  if IsGet then
    Result := Ord(TStrings(AObj).Delimiter)
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

function TStrings_Encoding_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Encoding: TEncoding read <getter>;

  Result := TEncoding_sw.ToVar(TStrings(AObj).Encoding);
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
    Result := Ord(TStrings(AObj).QuoteChar)
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
    Result := Ord(TStrings(AObj).NameValueSeparator)
  else
    TStrings(AObj).NameValueSeparator := Char(Integer(AArgs[0]));
end;

function TStrings_StrictDelimiter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StrictDelimiter: Boolean read <getter> write <se...

  if IsGet then
    Result := TStrings(AObj).StrictDelimiter
  else
    TStrings(AObj).StrictDelimiter := Boolean(AArgs[0]);
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

function TStrings_WriteBOM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WriteBOM: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TStrings(AObj).WriteBOM
  else
    TStrings(AObj).WriteBOM := Boolean(AArgs[0]);
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

  AData.AddProperty('UpdateCount', TStrings_UpdateCount_si, Integer_sw, True, False, 0, True, False);
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
  AData.AddProcedure('LoadFromFile', TStrings_LoadFromFile_si, 1, True);
  AData.AddProcedure('LoadFromStream', TStrings_LoadFromStream_si, 1, True);
  AData.AddProcedure('Move', TStrings_Move_si, 2, False);
  AData.AddProcedure('SaveToFile', TStrings_SaveToFile_si, 1, True);
  AData.AddProcedure('SaveToStream', TStrings_SaveToStream_si, 1, True);
  AData.AddProperty('Capacity', TStrings_Capacity_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('CommaText', TStrings_CommaText_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Count', TStrings_Count_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('DefaultEncoding', TStrings_DefaultEncoding_si, TEncoding_sw, True, True, 0, False, False);
  AData.AddProperty('Delimiter', TStrings_Delimiter_si, Char_sw, True, True, 0, False, False);
  AData.AddProperty('DelimitedText', TStrings_DelimitedText_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Encoding', TStrings_Encoding_si, TEncoding_sw, True, False, 0, False, False);
  AData.AddProperty('LineBreak', TStrings_LineBreak_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Names', TStrings_Names_si, string_sw, True, False, 1, False, False);
  AData.AddProperty('Objects', TStrings_Objects_si, TObject_sw, True, True, 1, False, False);
  AData.AddProperty('QuoteChar', TStrings_QuoteChar_si, Char_sw, True, True, 0, False, False);
  AData.AddProperty('Values', TStrings_Values_si, string_sw, True, True, 1, False, False);
  AData.AddProperty('ValueFromIndex', TStrings_ValueFromIndex_si, string_sw, True, True, 1, False, False);
  AData.AddProperty('NameValueSeparator', TStrings_NameValueSeparator_si, Char_sw, True, True, 0, False, False);
  AData.AddProperty('StrictDelimiter', TStrings_StrictDelimiter_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Strings', TStrings_Strings_si, string_sw, True, True, 1, False, True);
  AData.AddProperty('Text', TStrings_Text_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('WriteBOM', TStrings_WriteBOM_si, Boolean_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TStrings_Create_si, 0, False);
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

function TStringItem_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TStringItem_sw.Create as IDispatch;
end;

function TStringItem_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TStringItem;

  // Implicit record copy method.
  Result := TStringItem_sw.ToVar(TStringItem(AObj));
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

  AData.AddField('FString', TStringItem_FString_si, string_sw);
  AData.AddField('FObject', TStringItem_FObject_si, TObject_sw);
  AData.AddFunction('Copy', TStringItem_Copy_si, TStringItem_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TStringItem_Create_si, 0, False);
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

function TStringList_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    0:
    begin
      Result := TStringList_sw.ToVar(TStringList_sc(AObj).Create());
    end;
    1:
    begin
      Result := TStringList_sw.ToVar(TStringList_sc(AObj).Create(Boolean(
        AArgs[0])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

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

function TStringList_OwnsObjects_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OwnsObjects: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TStringList(AObj).OwnsObjects
  else
    TStringList(AObj).OwnsObjects := Boolean(AArgs[0]);
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
  AData.AddProperty('Duplicates', TStringList_Duplicates_si, TDuplicates_sw, True, True, 0, False, False);
  AData.AddProperty('Sorted', TStringList_Sorted_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('CaseSensitive', TStringList_CaseSensitive_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnChange', TStringList_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnChanging', TStringList_OnChanging_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OwnsObjects', TStringList_OwnsObjects_si, Boolean_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TStringList_Create_si, 0, True);
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

function TStream_ReadData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: AnsiChar;
  v_2: AnsiChar;
begin
  // procedure/function ReadData(...); overload;

  case AArgsSize of
    1:
    begin
      v_1 := AnsiChar(Integer(AArgs[0]));
      Result := TStream(AObj).ReadData(v_1);
      AssignRefParam(AArgs[0], Ord(v_1));
    end;
    2:
    begin
      v_2 := AnsiChar(Integer(AArgs[0]));
      Result := TStream(AObj).ReadData(v_2, Longint(AArgs[1]));
      AssignRefParam(AArgs[0], Ord(v_2));
    end;
  else
    WrongArgCountError('ReadData');
  end;
end;

function TStream_WriteData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function WriteData(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TStream(AObj).WriteData(AnsiChar(Integer(AArgs[0])));
    end;
    2:
    begin
      Result := TStream(AObj).WriteData(AnsiChar(Integer(AArgs[0])), Longint(
        AArgs[1]));
    end;
  else
    WrongArgCountError('WriteData');
  end;
end;

function TStream_Seek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Seek(...); overload;

  Result := Int64_sw.ToVar(TStream(AObj).Seek(Int64_sw.FromVar(AArgs[0]), 
    TSeekOrigin_sw.FromVar(AArgs[1])));
end;

function TStream_ReadBufferData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: AnsiChar;
  v_2: AnsiChar;
begin
  // procedure/function ReadBufferData(...); overload;

  case AArgsSize of
    1:
    begin
      v_1 := AnsiChar(Integer(AArgs[0]));
      TStream(AObj).ReadBufferData(v_1);
      AssignRefParam(AArgs[0], Ord(v_1));
    end;
    2:
    begin
      v_2 := AnsiChar(Integer(AArgs[0]));
      TStream(AObj).ReadBufferData(v_2, Longint(AArgs[1]));
      AssignRefParam(AArgs[0], Ord(v_2));
    end;
  else
    WrongArgCountError('ReadBufferData');
  end;
end;

function TStream_WriteBufferData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // procedure/function WriteBufferData(...); overload;

  v_1 := Integer(AArgs[0]);
  TStream(AObj).WriteBufferData(v_1, Longint(AArgs[1]));
  AssignRefParam(AArgs[0], v_1);
end;

function TStream_CopyFrom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CopyFrom(const Source: TStream; Count: Int64): I...

  Result := Int64_sw.ToVar(TStream(AObj).CopyFrom(TStream_sw.FromVar(AArgs[0]), 
    Int64_sw.FromVar(AArgs[1])));
end;

function TStream_ReadComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadComponent(const Instance: TComponent): TComp...

  Result := TComponent_sw.ToVar(TStream(AObj).ReadComponent(TComponent_sw.
    FromVar(AArgs[0])));
end;

function TStream_ReadComponentRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadComponentRes(const Instance: TComponent): TC...

  Result := TComponent_sw.ToVar(TStream(AObj).ReadComponentRes(TComponent_sw.
    FromVar(AArgs[0])));
end;

function TStream_WriteComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteComponent(const Instance: TComponent);

  TStream(AObj).WriteComponent(TComponent_sw.FromVar(AArgs[0]));
end;

function TStream_WriteComponentRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteComponentRes(const ResName: string; const ...

  TStream(AObj).WriteComponentRes(string(AArgs[0]), TComponent_sw.FromVar(
    AArgs[1]));
end;

function TStream_WriteDescendent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteDescendent(const Instance: TComponent; con...

  TStream(AObj).WriteDescendent(TComponent_sw.FromVar(AArgs[0]), TComponent_sw.
    FromVar(AArgs[1]));
end;

function TStream_WriteDescendentRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteDescendentRes(const ResName: string; const...

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

  AData.AddFunction('ReadData', TStream_ReadData_si, nil, 1, True);
  AData.AddFunction('WriteData', TStream_WriteData_si, nil, 1, True);
  AData.AddFunction('Seek', TStream_Seek_si, nil, 2, False);
  AData.AddProcedure('ReadBufferData', TStream_ReadBufferData_si, 1, True);
  AData.AddProcedure('WriteBufferData', TStream_WriteBufferData_si, 2, False);
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
  AData.AddProperty('Position', TStream_Position_si, Int64_sw, True, True, 0, False, False);
  AData.AddProperty('Size', TStream_Size_si, Int64_sw, True, True, 0, False, False);
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
  // constructor Create(AHandle: THandle);

  Result := THandleStream_sw.ToVar(THandleStream_sc(AObj).Create(THandle_sw.
    FromVar(AArgs[0])));
end;

function THandleStream_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: THandle read <getter>;

  Result := THandle_sw.ToVar(THandleStream(AObj).Handle);
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

  AData.AddProperty('Handle', THandleStream_Handle_si, THandle_sw, True, False, 0, False, False);

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
  // procedure/function Create(...); overload;

  case AArgsSize of
    2:
    begin
      Result := TFileStream_sw.ToVar(TFileStream_sc(AObj).Create(string(
        AArgs[0]), Word(AArgs[1])));
    end;
    3:
    begin
      Result := TFileStream_sw.ToVar(TFileStream_sc(AObj).Create(string(
        AArgs[0]), Word(AArgs[1]), Cardinal(AArgs[2])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TFileStream_FileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileName: string read <getter>;

  Result := TFileStream(AObj).FileName;
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
  { Instance members }

  AData.AddProperty('FileName', TFileStream_FileName_si, string_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TFileStream_Create_si, 2, True);
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

  AData.AddProperty('Capacity', TMemoryStream_Capacity_si, Longint_sw, True, True, 0, True, False);
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

{ TBytesStream_sw }

class function TBytesStream_sw.GetTypeName: WideString;
begin
  Result := 'TBytesStream';
end;

class function TBytesStream_sw.GetWrappedClass: TClass;
begin
  Result := TBytesStream;
end;

class procedure TBytesStream_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TBytesStream_sw.ToVar(const AValue: TBytesStream): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBytesStream_sw.FromVar(const AValue: OleVariant): TBytesStream;
begin
  Result := TBytesStream(ConvFromVar(AValue, TBytesStream));
end;

class function TBytesStream_sw.ClassToVar(AClass: TBytesStream_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBytesStream_sw.ClassFromVar(
  const AClass: OleVariant): TBytesStream_sc;
begin
  Result := TBytesStream_sc(ConvClsFromVar(AClass, TBytesStream));
end;

{ TStringStream_sw }

function TStringStream_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    0:
    begin
      Result := TStringStream_sw.ToVar(TStringStream_sc(AObj).Create());
    end;
    1:
    begin
      Result := TStringStream_sw.ToVar(TStringStream_sc(AObj).Create(string(
        AArgs[0])));
    end;
    2:
    begin
      Result := TStringStream_sw.ToVar(TStringStream_sc(AObj).Create(string(
        AArgs[0]), TEncoding_sw.FromVar(AArgs[1])));
    end;
    3:
    begin
      Result := TStringStream_sw.ToVar(TStringStream_sc(AObj).Create(string(
        AArgs[0]), TEncoding_sw.FromVar(AArgs[1]), Boolean(AArgs[2])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TStringStream_ReadString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadString(Count: Integer): string;

  Result := TStringStream(AObj).ReadString(Integer(AArgs[0]));
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

function TStringStream_Encoding_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Encoding: TEncoding read <getter>;

  Result := TEncoding_sw.ToVar(TStringStream(AObj).Encoding);
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
  AData.AddProperty('DataString', TStringStream_DataString_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('Encoding', TStringStream_Encoding_si, TEncoding_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TStringStream_Create_si, 0, True);
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

class procedure TStreamOwnership_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'soReference'; Value: Integer({$IFDEF LMDSCT_12}TStreamOwnership.{$ENDIF}soReference)),
    (Name: 'soOwned'; Value: Integer({$IFDEF LMDSCT_12}TStreamOwnership.{$ENDIF}soOwned))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
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

  case AArgsSize of
    1:
    begin
      Result := TStreamAdapter_sw.ToVar(TStreamAdapter_sc(AObj).Create(
        TStream_sw.FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TStreamAdapter_sw.ToVar(TStreamAdapter_sc(AObj).Create(
        TStream_sw.FromVar(AArgs[0]), TStreamOwnership_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TStreamAdapter_Commit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Commit(grfCommitFlags: DWORD): HResult;

  Result := HResult_sw.ToVar(TStreamAdapter(AObj).Commit(DWORD_sw.FromVar(
    AArgs[0])));
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
  AData.AddProperty('Stream', TStreamAdapter_Stream_si, TStream_sw, True, False, 0, False, False);
  AData.AddProperty('StreamOwnership', TStreamAdapter_StreamOwnership_si, TStreamOwnership_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TStreamAdapter_Create_si, 1, True);
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

  case AArgsSize of
    0:
    begin
      Result := TClassFinder_sw.ToVar(TClassFinder_sc(AObj).Create());
    end;
    1:
    begin
      Result := TClassFinder_sw.ToVar(TClassFinder_sc(AObj).Create(
        TPersistentClass_sw.FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TClassFinder_sw.ToVar(TClassFinder_sc(AObj).Create(
        TPersistentClass_sw.FromVar(AArgs[0]), Boolean(AArgs[1])));
    end;
  else
    WrongArgCountError('Create');
  end;
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

function TClassFinder_FinderClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FinderClass: TPersistentClass read <getter>;

  Result := TPersistentClass_sw.ToVar(TClassFinder(AObj).FinderClass);
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
  AData.AddProperty('FinderClass', TClassFinder_FinderClass_si, TPersistentClass_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TClassFinder_Create_si, 0, True);
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

class procedure TValueType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..21] of TLMDEnumerator = (
    (Name: 'vaNull'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaNull)),
    (Name: 'vaList'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaList)),
    (Name: 'vaInt8'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaInt8)),
    (Name: 'vaInt16'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaInt16)),
    (Name: 'vaInt32'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaInt32)),
    (Name: 'vaExtended'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaExtended)),
    (Name: 'vaString'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaString)),
    (Name: 'vaIdent'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaIdent)),
    (Name: 'vaFalse'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaFalse)),
    (Name: 'vaTrue'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaTrue)),
    (Name: 'vaBinary'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaBinary)),
    (Name: 'vaSet'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaSet)),
    (Name: 'vaLString'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaLString)),
    (Name: 'vaNil'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaNil)),
    (Name: 'vaCollection'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaCollection)),
    (Name: 'vaSingle'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaSingle)),
    (Name: 'vaCurrency'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaCurrency)),
    (Name: 'vaDate'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaDate)),
    (Name: 'vaWString'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaWString)),
    (Name: 'vaInt64'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaInt64)),
    (Name: 'vaUTF8String'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaUTF8String)),
    (Name: 'vaDouble'; Value: Integer({$IFDEF LMDSCT_12}TValueType.{$ENDIF}vaDouble))
  );
begin
  AEnums := @ENUMS;
  ACount := 22;
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

class procedure TFilerFlag_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'ffInherited'; Value: Integer({$IFDEF LMDSCT_12}TFilerFlag.{$ENDIF}ffInherited)),
    (Name: 'ffChildPos'; Value: Integer({$IFDEF LMDSCT_12}TFilerFlag.{$ENDIF}ffChildPos)),
    (Name: 'ffInline'; Value: Integer({$IFDEF LMDSCT_12}TFilerFlag.{$ENDIF}ffInline))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
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
  AData.AddProperty('Root', TFiler_Root_si, TComponent_sw, True, True, 0, False, False);
  AData.AddProperty('LookupRoot', TFiler_LookupRoot_si, TComponent_sw, True, False, 0, False, False);
  AData.AddProperty('Ancestor', TFiler_Ancestor_si, TPersistent_sw, True, True, 0, False, False);
  AData.AddProperty('IgnoreChildren', TFiler_IgnoreChildren_si, Boolean_sw, True, True, 0, False, False);

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

{ TFindMethodInstanceEvent_sh }

function TFindMethodInstanceEvent_sh.GetHandler: TMethod;
var
  hdr: TFindMethodInstanceEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFindMethodInstanceEvent_sh.Handler(Reader: TReader;
  const MethodName: string; var AMethod: TMethod; var Error: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure (Reader: TReader; const MethodName: string; var...

  v_1 := TMethod_sw.ToVar(AMethod);
  v_2 := Error;
  args[0] := TReader_sw.ToVar(Reader);
  args[1] := MethodName;
  args[2] := MakeVarRef(v_1);
  args[3] := MakeVarRef(v_2);
  Self.Owner.RunProc(Self.ProcName, args);
  AMethod := TMethod_sw.FromVar(v_1);
  Error := Boolean(v_2);
end;

{ TFindMethodInstanceEvent_sw }

class function TFindMethodInstanceEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFindMethodInstanceEvent';
end;

class function TFindMethodInstanceEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFindMethodInstanceEvent_sh;
end;

class function TFindMethodInstanceEvent_sw.ToVar(
  const AValue: TFindMethodInstanceEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFindMethodInstanceEvent_sw.FromVar(
  const AValue: OleVariant): TFindMethodInstanceEvent;
begin
  Result := TFindMethodInstanceEvent(ConvFromVar(AValue));
end;

class function TFindMethodInstanceEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TFindMethodInstanceEvent;
var
  hdlr: TFindMethodInstanceEvent_sh;
begin
  hdlr   := TFindMethodInstanceEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TFindMethodInstanceEvent_sw));
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

function TReader_ReadVar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: AnsiChar;
begin
  // procedure/function ReadVar(...); overload;

  v_1 := AnsiChar(Integer(AArgs[0]));
  TReader(AObj).ReadVar(v_1, LongInt(AArgs[1]));
  AssignRefParam(AArgs[0], Ord(v_1));
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

  Result := Ord(TReader(AObj).ReadChar());
end;

function TReader_ReadWideChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadWideChar: WideChar;

  Result := Ord(TReader(AObj).ReadWideChar());
end;

function TReader_ReadCollection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ReadCollection(const Collection: TCollection);

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
  // procedure ReadComponents(const AOwner: TComponent; const ...

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
  // function ReadInteger: Integer;

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
  // function ReadRootComponent(const Root: TComponent): TComp...

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
  // function ReadWideString: string;

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
  // procedure CopyValue(const Writer: TWriter);

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

function TReader_OnFindMethodInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFindMethodInstance: TFindMethodInstanceEvent r...

  if IsGet then
    Result := TFindMethodInstanceEvent_sw.ToVar(TReader(AObj).
      OnFindMethodInstance)
  else
    TReader(AObj).OnFindMethodInstance := TFindMethodInstanceEvent_sw.FromVar(
      AArgs[0]);
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

  AData.AddProperty('PropName', TReader_PropName_si, string_sw, True, False, 0, True, False);
  AData.AddProperty('CanHandleExceptions', TReader_CanHandleExceptions_si, Boolean_sw, True, False, 0, True, False);
  AData.AddProcedure('BeginReferences', TReader_BeginReferences_si, 0, False);
  AData.AddProcedure('CheckValue', TReader_CheckValue_si, 1, False);
  AData.AddFunction('EndOfList', TReader_EndOfList_si, Boolean_sw, 0, False);
  AData.AddProcedure('EndReferences', TReader_EndReferences_si, 0, False);
  AData.AddProcedure('FixupReferences', TReader_FixupReferences_si, 0, False);
  AData.AddFunction('NextValue', TReader_NextValue_si, TValueType_sw, 0, False);
  AData.AddProcedure('ReadVar', TReader_ReadVar_si, 2, False);
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
  AData.AddFunction('ReadInteger', TReader_ReadInteger_si, Integer_sw, 0, False);
  AData.AddFunction('ReadInt64', TReader_ReadInt64_si, Int64_sw, 0, False);
  AData.AddProcedure('ReadListBegin', TReader_ReadListBegin_si, 0, False);
  AData.AddProcedure('ReadListEnd', TReader_ReadListEnd_si, 0, False);
  AData.AddProcedure('ReadPrefix', TReader_ReadPrefix_si, 2, False);
  AData.AddFunction('ReadRootComponent', TReader_ReadRootComponent_si, TComponent_sw, 1, False);
  AData.AddProcedure('ReadSignature', TReader_ReadSignature_si, 0, False);
  AData.AddFunction('ReadStr', TReader_ReadStr_si, string_sw, 0, False);
  AData.AddFunction('ReadString', TReader_ReadString_si, string_sw, 0, False);
  AData.AddFunction('ReadWideString', TReader_ReadWideString_si, string_sw, 0, False);
  AData.AddFunction('ReadValue', TReader_ReadValue_si, TValueType_sw, 0, False);
  AData.AddFunction('ReadVariant', TReader_ReadVariant_si, Variant_sw, 0, False);
  AData.AddProcedure('CopyValue', TReader_CopyValue_si, 1, False);
  AData.AddProcedure('SkipValue', TReader_SkipValue_si, 0, False);
  AData.AddProperty('Owner', TReader_Owner_si, TComponent_sw, True, True, 0, False, False);
  AData.AddProperty('Parent', TReader_Parent_si, TComponent_sw, True, True, 0, False, False);
  AData.AddProperty('Position', TReader_Position_si, Longint_sw, True, True, 0, False, False);
  AData.AddProperty('OnError', TReader_OnError_si, TReaderError_sw, True, True, 0, False, False);
  AData.AddProperty('OnFindMethodInstance', TReader_OnFindMethodInstance_si, TFindMethodInstanceEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSetName', TReader_OnSetName_si, TSetNameEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnReferenceName', TReader_OnReferenceName_si, TReferenceNameEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnAncestorNotFound', TReader_OnAncestorNotFound_si, TAncestorNotFoundEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnCreateComponent', TReader_OnCreateComponent_si, TCreateComponentEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnFindComponentClass', TReader_OnFindComponentClass_si, TFindComponentClassEvent_sw, True, True, 0, False, False);
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

{ TFindMethodNameEvent_sh }

function TFindMethodNameEvent_sh.GetHandler: TMethod;
var
  hdr: TFindMethodNameEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFindMethodNameEvent_sh.Handler(Writer: TWriter; AMethod: TMethod;
  var MethodName: string);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Writer: TWriter; AMethod: TMethod; var MethodN...

  v_1 := MethodName;
  args[0] := TWriter_sw.ToVar(Writer);
  args[1] := TMethod_sw.ToVar(AMethod);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  MethodName := string(v_1);
end;

{ TFindMethodNameEvent_sw }

class function TFindMethodNameEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFindMethodNameEvent';
end;

class function TFindMethodNameEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFindMethodNameEvent_sh;
end;

class function TFindMethodNameEvent_sw.ToVar(
  const AValue: TFindMethodNameEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFindMethodNameEvent_sw.FromVar(
  const AValue: OleVariant): TFindMethodNameEvent;
begin
  Result := TFindMethodNameEvent(ConvFromVar(AValue));
end;

class function TFindMethodNameEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TFindMethodNameEvent;
var
  hdlr: TFindMethodNameEvent_sh;
begin
  hdlr   := TFindMethodNameEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TFindMethodNameEvent_sw));
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

function TWriter_WriteVar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function WriteVar(...); overload;

  TWriter(AObj).WriteVar(AnsiChar(Integer(AArgs[0])), LongInt(AArgs[1]));
end;

function TWriter_WriteBoolean_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteBoolean(Value: Boolean);

  TWriter(AObj).WriteBoolean(Boolean(AArgs[0]));
end;

function TWriter_WriteCollection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteCollection(const Value: TCollection);

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
  // procedure WriteDescendent(const Root: TComponent; const A...

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
  // procedure/function WriteInteger(...); overload;

  TWriter(AObj).WriteInteger(Int64_sw.FromVar(AArgs[0]));
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

function TWriter_WriteProperties_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteProperties(const Instance: TPersistent);

  TWriter(AObj).WriteProperties(TPersistent_sw.FromVar(AArgs[0]));
end;

function TWriter_WriteRootComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteRootComponent(const Root: TComponent);

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
  // procedure WriteStr(const Value: AnsiString);

  TWriter(AObj).WriteStr(AnsiString(AArgs[0]));
end;

function TWriter_WriteUTF8Str_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteUTF8Str(const Value: string);

  TWriter(AObj).WriteUTF8Str(string(AArgs[0]));
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
  // procedure WriteWideString(const Value: string);

  TWriter(AObj).WriteWideString(string(AArgs[0]));
end;

function TWriter_WriteVariant_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteVariant(const Value: Variant);

  TWriter(AObj).WriteVariant(Variant(FindVarData(AArgs[0])^));
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

function TWriter_OnFindMethodName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFindMethodName: TFindMethodNameEvent read <get...

  if IsGet then
    Result := TFindMethodNameEvent_sw.ToVar(TWriter(AObj).OnFindMethodName)
  else
    TWriter(AObj).OnFindMethodName := TFindMethodNameEvent_sw.FromVar(AArgs[0]);
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

  AData.AddProcedure('WriteVar', TWriter_WriteVar_si, 2, False);
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
  AData.AddProcedure('WriteProperties', TWriter_WriteProperties_si, 1, False);
  AData.AddProcedure('WriteRootComponent', TWriter_WriteRootComponent_si, 1, False);
  AData.AddProcedure('WriteSignature', TWriter_WriteSignature_si, 0, False);
  AData.AddProcedure('WriteStr', TWriter_WriteStr_si, 1, False);
  AData.AddProcedure('WriteUTF8Str', TWriter_WriteUTF8Str_si, 1, False);
  AData.AddProcedure('WriteString', TWriter_WriteString_si, 1, False);
  AData.AddProcedure('WriteWideString', TWriter_WriteWideString_si, 1, False);
  AData.AddProcedure('WriteVariant', TWriter_WriteVariant_si, 1, False);
  AData.AddProperty('Position', TWriter_Position_si, Longint_sw, True, True, 0, False, False);
  AData.AddProperty('RootAncestor', TWriter_RootAncestor_si, TComponent_sw, True, True, 0, False, False);
  AData.AddProperty('OnFindAncestor', TWriter_OnFindAncestor_si, TFindAncestorEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnFindMethodName', TWriter_OnFindMethodName_si, TFindMethodNameEvent_sw, True, True, 0, False, False);
  AData.AddProperty('UseQualifiedNames', TWriter_UseQualifiedNames_si, Boolean_sw, True, True, 0, False, False);
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
  // procedure/function Create(...); overload;

  case AArgsSize of
    2:
    begin
      Result := TParser_sw.ToVar(TParser_sc(AObj).Create(TStream_sw.FromVar(
        AArgs[0]), TFormatSettings_sw.FromVar(AArgs[1])));
    end;
    3:
    begin
      Result := TParser_sw.ToVar(TParser_sc(AObj).Create(TStream_sw.FromVar(
        AArgs[0]), TFormatSettings_sw.FromVar(AArgs[1]), TParserErrorEvent_sw.
        FromVar(AArgs[2])));
    end;
  else
    WrongArgCountError('Create');
  end;
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

  Result := Ord(TParser(AObj).NextToken());
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
  // function TokenWideString: UnicodeString;

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

  Result := Ord(TParser(AObj).FloatType);
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

  Result := Ord(TParser(AObj).Token);
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
  AData.AddFunction('TokenWideString', TParser_TokenWideString_si, UnicodeString_sw, 0, False);
  AData.AddFunction('TokenSymbolIs', TParser_TokenSymbolIs_si, Boolean_sw, 1, False);
  AData.AddProperty('FloatType', TParser_FloatType_si, Char_sw, True, False, 0, False, False);
  AData.AddProperty('SourceLine', TParser_SourceLine_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('LinePos', TParser_LinePos_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Token', TParser_Token_si, Char_sw, True, False, 0, False, False);
  AData.AddProperty('OnError', TParser_OnError_si, TParserErrorEvent_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TParser_Create_si, 2, True);
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

{ EThreadExternalException_sw }

class function EThreadExternalException_sw.GetTypeName: WideString;
begin
  Result := 'EThreadExternalException';
end;

class function EThreadExternalException_sw.GetWrappedClass: TClass;
begin
  Result := EThreadExternalException;
end;

class procedure EThreadExternalException_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EThreadExternalException_sw.ToVar(
  const AValue: EThreadExternalException): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EThreadExternalException_sw.FromVar(
  const AValue: OleVariant): EThreadExternalException;
begin
  Result := EThreadExternalException(ConvFromVar(AValue, 
    EThreadExternalException));
end;

class function EThreadExternalException_sw.ClassToVar(
  AClass: EThreadExternalException_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EThreadExternalException_sw.ClassFromVar(
  const AClass: OleVariant): EThreadExternalException_sc;
begin
  Result := EThreadExternalException_sc(ConvClsFromVar(AClass, 
    EThreadExternalException));
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

class procedure TThreadPriority_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..6] of TLMDEnumerator = (
    (Name: 'tpIdle'; Value: Integer({$IFDEF LMDSCT_12}TThreadPriority.{$ENDIF}tpIdle)),
    (Name: 'tpLowest'; Value: Integer({$IFDEF LMDSCT_12}TThreadPriority.{$ENDIF}tpLowest)),
    (Name: 'tpLower'; Value: Integer({$IFDEF LMDSCT_12}TThreadPriority.{$ENDIF}tpLower)),
    (Name: 'tpNormal'; Value: Integer({$IFDEF LMDSCT_12}TThreadPriority.{$ENDIF}tpNormal)),
    (Name: 'tpHigher'; Value: Integer({$IFDEF LMDSCT_12}TThreadPriority.{$ENDIF}tpHigher)),
    (Name: 'tpHighest'; Value: Integer({$IFDEF LMDSCT_12}TThreadPriority.{$ENDIF}tpHighest)),
    (Name: 'tpTimeCritical'; Value: Integer({$IFDEF LMDSCT_12}TThreadPriority.{$ENDIF}tpTimeCritical))
  );
begin
  AEnums := @ENUMS;
  ACount := 7;
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
  // procedure/function Create(...); overload;

  case AArgsSize of
    0:
    begin
      Result := TThread_sw.ToVar(TThread_sc(AObj).Create());
    end;
    1:
    begin
      Result := TThread_sw.ToVar(TThread_sc(AObj).Create(Boolean(AArgs[0])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TThread_Resume_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Resume;

  TThread(AObj).Resume();
end;

function TThread_Start_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Start;

  TThread(AObj).Start();
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

function TThread_CheckTerminated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function CheckTerminated: Boolean;

  Result := TThread_sc(AObj).CheckTerminated();
end;

function TThread_SetReturnValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure SetReturnValue(Value: Integer);

  TThread_sc(AObj).SetReturnValue(Integer(AArgs[0]));
end;

function TThread_Queue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Queue(...); overload;

  TThread_sc(AObj).Queue(TThread_sw.FromVar(AArgs[0]), TThreadMethod_sw.FromVar(
    AArgs[1]));
end;

function TThread_RemoveQueuedEvents_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function RemoveQueuedEvents(...); overload;

  case AArgsSize of
    2:
    begin
      TThread_sc(AObj).RemoveQueuedEvents(TThread_sw.FromVar(AArgs[0]), 
        TThreadMethod_sw.FromVar(AArgs[1]));
    end;
    1:
    begin
      TThread_sc(AObj).RemoveQueuedEvents(TThread_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('RemoveQueuedEvents');
  end;
end;

function TThread_StaticQueue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure StaticQueue(const AThread: TThread; AMeth...

  TThread_sc(AObj).StaticQueue(TThread_sw.FromVar(AArgs[0]), TThreadMethod_sw.
    FromVar(AArgs[1]));
end;

function TThread_Synchronize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Synchronize(...); overload;

  TThread_sc(AObj).Synchronize(TThread_sw.FromVar(AArgs[0]), TThreadMethod_sw.
    FromVar(AArgs[1]));
end;

function TThread_StaticSynchronize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure StaticSynchronize(const AThread: TThread;...

  TThread_sc(AObj).StaticSynchronize(TThread_sw.FromVar(AArgs[0]), 
    TThreadMethod_sw.FromVar(AArgs[1]));
end;

function TThread_NameThreadForDebugging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function NameThreadForDebugging(...); overload;

  case AArgsSize of
    1:
    begin
      TThread_sc(AObj).NameThreadForDebugging(string(AArgs[0]));
    end;
    2:
    begin
      TThread_sc(AObj).NameThreadForDebugging(string(AArgs[0]), TThreadID_sw.
        FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('NameThreadForDebugging');
  end;
end;

function TThread_SpinWait_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure SpinWait(Iterations: Integer);

  TThread_sc(AObj).SpinWait(Integer(AArgs[0]));
end;

function TThread_Sleep_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure Sleep(Timeout: Integer);

  TThread_sc(AObj).Sleep(Integer(AArgs[0]));
end;

function TThread_Yield_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure Yield;

  TThread_sc(AObj).Yield();
end;

function TThread_GetTickCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function GetTickCount: Cardinal;

  Result := TThread_sc(AObj).GetTickCount();
end;

function TThread_ExternalThread_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExternalThread: Boolean read <getter>;

  Result := TThread(AObj).ExternalThread;
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

function TThread_Finished_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Finished: Boolean read <getter>;

  Result := TThread(AObj).Finished;
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

function TThread_Started_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Started: Boolean read <getter>;

  Result := TThread(AObj).Started;
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
  // property ThreadID: TThreadID read <getter>;

  Result := TThreadID_sw.ToVar(TThread(AObj).ThreadID);
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

function TThread_Current_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: TThread read <getter>;

  Result := TThread_sw.ToVar(TThread_sc(AObj).Current);
end;

function TThread_CurrentThread_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CurrentThread: TThread read <getter>;

  Result := TThread_sw.ToVar(TThread_sc(AObj).CurrentThread);
end;

function TThread_ProcessorCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ProcessorCount: Integer read <getter>;

  Result := TThread_sc(AObj).ProcessorCount;
end;

function TThread_IsSingleProcessor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsSingleProcessor: Boolean read <getter>;

  Result := TThread_sc(AObj).IsSingleProcessor;
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

  AData.AddProperty('ReturnValue', TThread_ReturnValue_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('Terminated', TThread_Terminated_si, Boolean_sw, True, False, 0, True, False);
  AData.AddProcedure('Resume', TThread_Resume_si, 0, False);
  AData.AddProcedure('Start', TThread_Start_si, 0, False);
  AData.AddProcedure('Suspend', TThread_Suspend_si, 0, False);
  AData.AddProcedure('Terminate', TThread_Terminate_si, 0, False);
  AData.AddFunction('WaitFor', TThread_WaitFor_si, LongWord_sw, 0, False);
  AData.AddProperty('ExternalThread', TThread_ExternalThread_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('FatalException', TThread_FatalException_si, TObject_sw, True, False, 0, False, False);
  AData.AddProperty('FreeOnTerminate', TThread_FreeOnTerminate_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Finished', TThread_Finished_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Handle', TThread_Handle_si, THandle_sw, True, False, 0, False, False);
  AData.AddProperty('Priority', TThread_Priority_si, TThreadPriority_sw, True, True, 0, False, False);
  AData.AddProperty('Started', TThread_Started_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Suspended', TThread_Suspended_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ThreadID', TThread_ThreadID_si, TThreadID_sw, True, False, 0, False, False);
  AData.AddProperty('OnTerminate', TThread_OnTerminate_si, TNotifyEvent_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TThread_Create_si, 0, True);
  AData.AddClassFunction('CheckTerminated', TThread_CheckTerminated_si, Boolean_sw, 0, False);
  AData.AddClassProcedure('SetReturnValue', TThread_SetReturnValue_si, 1, False);
  AData.AddClassProcedure('Queue', TThread_Queue_si, 2, False);
  AData.AddClassProcedure('RemoveQueuedEvents', TThread_RemoveQueuedEvents_si, 1, True);
  AData.AddClassProcedure('StaticQueue', TThread_StaticQueue_si, 2, False);
  AData.AddClassProcedure('Synchronize', TThread_Synchronize_si, 2, False);
  AData.AddClassProcedure('StaticSynchronize', TThread_StaticSynchronize_si, 2, False);
  AData.AddClassProcedure('NameThreadForDebugging', TThread_NameThreadForDebugging_si, 1, True);
  AData.AddClassProcedure('SpinWait', TThread_SpinWait_si, 1, False);
  AData.AddClassProcedure('Sleep', TThread_Sleep_si, 1, False);
  AData.AddClassProcedure('Yield', TThread_Yield_si, 0, False);
  AData.AddClassFunction('GetTickCount', TThread_GetTickCount_si, Cardinal_sw, 0, False);
  AData.AddClassProperty('Current', TThread_Current_si, TThread_sw, True, False, 0, False);
  AData.AddClassProperty('CurrentThread', TThread_CurrentThread_si, TThread_sw, True, False, 0, False);
  AData.AddClassProperty('ProcessorCount', TThread_ProcessorCount_si, Integer_sw, True, False, 0, False);
  AData.AddClassProperty('IsSingleProcessor', TThread_IsSingleProcessor_si, Boolean_sw, True, False, 0, False);
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
  AData.AddProperty('Current', TComponentEnumerator_Current_si, TComponent_sw, True, False, 0, False, False);

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

class procedure TOperation_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'opInsert'; Value: Integer({$IFDEF LMDSCT_12}TOperation.{$ENDIF}opInsert)),
    (Name: 'opRemove'; Value: Integer({$IFDEF LMDSCT_12}TOperation.{$ENDIF}opRemove))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
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

{ TGetStreamProc_sh }

function TGetStreamProc_sh.GetHandler: TMethod;
var
  hdr: TGetStreamProc;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetStreamProc_sh.Handler(const S: TStream);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (const S: TStream) of object

  args[0] := TStream_sw.ToVar(S);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TGetStreamProc_sw }

class function TGetStreamProc_sw.GetTypeName: WideString;
begin
  Result := 'TGetStreamProc';
end;

class function TGetStreamProc_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetStreamProc_sh;
end;

class function TGetStreamProc_sw.ToVar(
  const AValue: TGetStreamProc): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetStreamProc_sw.FromVar(
  const AValue: OleVariant): TGetStreamProc;
begin
  Result := TGetStreamProc(ConvFromVar(AValue));
end;

class function TGetStreamProc_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetStreamProc;
var
  hdlr: TGetStreamProc_sh;
begin
  hdlr   := TGetStreamProc_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetStreamProc_sw));
  Result := hdlr.Handler;
end;

{ TGetDeltaStreamsEvent_sh }

function TGetDeltaStreamsEvent_sh.GetHandler: TMethod;
var
  hdr: TGetDeltaStreamsEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetDeltaStreamsEvent_sh.Handler(Sender: TObject;
  Proc: TGetStreamProc; var Handled: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Proc: TGetStreamProc; var Han...

  v_1 := Handled;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TGetStreamProc_sw.ToVar(Proc);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Handled := Boolean(v_1);
end;

{ TGetDeltaStreamsEvent_sw }

class function TGetDeltaStreamsEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetDeltaStreamsEvent';
end;

class function TGetDeltaStreamsEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetDeltaStreamsEvent_sh;
end;

class function TGetDeltaStreamsEvent_sw.ToVar(
  const AValue: TGetDeltaStreamsEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetDeltaStreamsEvent_sw.FromVar(
  const AValue: OleVariant): TGetDeltaStreamsEvent;
begin
  Result := TGetDeltaStreamsEvent(ConvFromVar(AValue));
end;

class function TGetDeltaStreamsEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetDeltaStreamsEvent;
var
  hdlr: TGetDeltaStreamsEvent_sh;
begin
  hdlr   := TGetDeltaStreamsEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetDeltaStreamsEvent_sw));
  Result := hdlr.Handler;
end;

{ TComponentName_sw }

class function TComponentName_sw.GetTypeName: WideString;
begin
  Result := 'TComponentName';
end;

class function TComponentName_sw.ToVar(
  const AValue: TComponentName): OleVariant;
begin
  Result := string_sw.ToVar(string(AValue));
end;

class function TComponentName_sw.FromVar(
  const AValue: OleVariant): TComponentName;
begin
  Result := TComponentName(string_sw.FromVar(AValue));
end;

{ ComponentPlatformsAttribute_sw }

function ComponentPlatformsAttribute_Create_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(const Platforms: TPlatformIds);

  Result := ComponentPlatformsAttribute_sw.ToVar(ComponentPlatformsAttribute_sc(
    AObj).Create(TPlatformIds_sw.FromVar(AArgs[0])));
end;

function ComponentPlatformsAttribute_Platforms_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Platforms: TPlatformIds read <getter> write <set...

  if IsGet then
    Result := TPlatformIds_sw.ToVar(ComponentPlatformsAttribute(AObj).Platforms)
  else
    ComponentPlatformsAttribute(AObj).Platforms := TPlatformIds_sw.FromVar(
      AArgs[0]);
end;

class function ComponentPlatformsAttribute_sw.GetTypeName: WideString;
begin
  Result := 'ComponentPlatformsAttribute';
end;

class function ComponentPlatformsAttribute_sw.GetWrappedClass: TClass;
begin
  Result := ComponentPlatformsAttribute;
end;

class procedure ComponentPlatformsAttribute_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Platforms', ComponentPlatformsAttribute_Platforms_si, TPlatformIds_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', ComponentPlatformsAttribute_Create_si, 1, False);
end;

class function ComponentPlatformsAttribute_sw.ToVar(
  const AValue: ComponentPlatformsAttribute): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function ComponentPlatformsAttribute_sw.FromVar(
  const AValue: OleVariant): ComponentPlatformsAttribute;
begin
  Result := ComponentPlatformsAttribute(ConvFromVar(AValue, 
    ComponentPlatformsAttribute));
end;

class function ComponentPlatformsAttribute_sw.ClassToVar(
  AClass: ComponentPlatformsAttribute_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function ComponentPlatformsAttribute_sw.ClassFromVar(
  const AClass: OleVariant): ComponentPlatformsAttribute_sc;
begin
  Result := ComponentPlatformsAttribute_sc(ConvClsFromVar(AClass, 
    ComponentPlatformsAttribute));
end;

{ TObservers_sw }

function TObservers_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TObservers_sw.ToVar(TObservers_sc(AObj).Create());
end;

function TObservers_CanObserve_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function CanObserve(...); overload;

  Result := TObservers(AObj).CanObserve(Integer(AArgs[0]));
end;

function TObservers_IsObserving_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function IsObserving(...); overload;

  Result := TObservers(AObj).IsObserving(Integer(AArgs[0]));
end;

class function TObservers_sw.GetTypeName: WideString;
begin
  Result := 'TObservers';
end;

class function TObservers_sw.GetWrappedClass: TClass;
begin
  Result := TObservers;
end;

class procedure TObservers_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('CanObserve', TObservers_CanObserve_si, nil, 1, False);
  AData.AddFunction('IsObserving', TObservers_IsObserving_si, nil, 1, False);

  { Class members }

  AData.AddConstructor('Create', TObservers_Create_si, 0, False);
end;

class function TObservers_sw.ToVar(const AValue: TObservers): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TObservers_sw.FromVar(const AValue: OleVariant): TObservers;
begin
  Result := TObservers(ConvFromVar(AValue, TObservers));
end;

class function TObservers_sw.ClassToVar(AClass: TObservers_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TObservers_sw.ClassFromVar(
  const AClass: OleVariant): TObservers_sc;
begin
  Result := TObservers_sc(ConvClsFromVar(AClass, TObservers));
end;

{ TLinkObservers_sw }

function TLinkObservers_EditLinkUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure EditLinkUpdate(const AObservers: TObserve...

  TLinkObservers_sc(AObj).EditLinkUpdate(TObservers_sw.FromVar(AArgs[0]));
end;

function TLinkObservers_EditLinkTrackUpdate_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function EditLinkTrackUpdate(const AObservers: TObs...

  Result := TLinkObservers_sc(AObj).EditLinkTrackUpdate(TObservers_sw.FromVar(
    AArgs[0]));
end;

function TLinkObservers_EditLinkReset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure EditLinkReset(const AObservers: TObservers);

  TLinkObservers_sc(AObj).EditLinkReset(TObservers_sw.FromVar(AArgs[0]));
end;

function TLinkObservers_EditLinkModified_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure EditLinkModified(AObservers: TObservers);

  TLinkObservers_sc(AObj).EditLinkModified(TObservers_sw.FromVar(AArgs[0]));
end;

function TLinkObservers_EditLinkIsModified_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function EditLinkIsModified(const AObservers: TObse...

  Result := TLinkObservers_sc(AObj).EditLinkIsModified(TObservers_sw.FromVar(
    AArgs[0]));
end;

function TLinkObservers_EditLinkIsValidChar_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function EditLinkIsValidChar(const AObservers: TObs...

  Result := TLinkObservers_sc(AObj).EditLinkIsValidChar(TObservers_sw.FromVar(
    AArgs[0]), Char(Integer(AArgs[1])));
end;

function TLinkObservers_EditLinkIsEditing_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function EditLinkIsEditing(const AObservers: TObser...

  Result := TLinkObservers_sc(AObj).EditLinkIsEditing(TObservers_sw.FromVar(
    AArgs[0]));
end;

function TLinkObservers_EditLinkEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function EditLinkEdit(const AObservers: TObservers)...

  Result := TLinkObservers_sc(AObj).EditLinkEdit(TObservers_sw.FromVar(
    AArgs[0]));
end;

function TLinkObservers_EditLinkSetIsReadOnly_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure EditLinkSetIsReadOnly(const AObservers: T...

  TLinkObservers_sc(AObj).EditLinkSetIsReadOnly(TObservers_sw.FromVar(AArgs[0]),
    Boolean(AArgs[1]));
end;

function TLinkObservers_EditLinkIsReadOnly_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function EditLinkIsReadOnly(const AObservers: TObse...

  Result := TLinkObservers_sc(AObj).EditLinkIsReadOnly(TObservers_sw.FromVar(
    AArgs[0]));
end;

function TLinkObservers_EditGridLinkUpdate_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure EditGridLinkUpdate(const AObservers: TObs...

  TLinkObservers_sc(AObj).EditGridLinkUpdate(TObservers_sw.FromVar(AArgs[0]));
end;

function TLinkObservers_EditGridLinkReset_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure EditGridLinkReset(const AObservers: TObse...

  TLinkObservers_sc(AObj).EditGridLinkReset(TObservers_sw.FromVar(AArgs[0]));
end;

function TLinkObservers_EditGridLinkModified_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure EditGridLinkModified(const AObservers: TO...

  TLinkObservers_sc(AObj).EditGridLinkModified(TObservers_sw.FromVar(AArgs[0]));
end;

function TLinkObservers_EditGridLinkIsModified_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function EditGridLinkIsModified(const AObservers: T...

  Result := TLinkObservers_sc(AObj).EditGridLinkIsModified(TObservers_sw.
    FromVar(AArgs[0]));
end;

function TLinkObservers_EditGridLinkIsValidChar_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function EditGridLinkIsValidChar(const AObservers: ...

  Result := TLinkObservers_sc(AObj).EditGridLinkIsValidChar(TObservers_sw.
    FromVar(AArgs[0]), Char(Integer(AArgs[1])));
end;

function TLinkObservers_EditGridLinkIsEditing_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function EditGridLinkIsEditing(const AObservers: TO...

  Result := TLinkObservers_sc(AObj).EditGridLinkIsEditing(TObservers_sw.FromVar(
    AArgs[0]));
end;

function TLinkObservers_EditGridLinkEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function EditGridLinkEdit(const AObservers: TObserv...

  Result := TLinkObservers_sc(AObj).EditGridLinkEdit(TObservers_sw.FromVar(
    AArgs[0]));
end;

function TLinkObservers_EditGridLinkIsReadOnly_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function EditGridLinkIsReadOnly(const AObservers: T...

  Result := TLinkObservers_sc(AObj).EditGridLinkIsReadOnly(TObservers_sw.
    FromVar(AArgs[0]));
end;

function TLinkObservers_EditGridLinkSetIsReadOnly_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure EditGridLinkSetIsReadOnly(const AObserver...

  TLinkObservers_sc(AObj).EditGridLinkSetIsReadOnly(TObservers_sw.FromVar(
    AArgs[0]), Boolean(AArgs[1]));
end;

function TLinkObservers_PositionLinkPosChanged_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure PositionLinkPosChanged(const AObservers: ...

  TLinkObservers_sc(AObj).PositionLinkPosChanged(TObservers_sw.FromVar(
    AArgs[0]));
end;

function TLinkObservers_PositionLinkPosChanging_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure PositionLinkPosChanging(const AObservers:...

  TLinkObservers_sc(AObj).PositionLinkPosChanging(TObservers_sw.FromVar(
    AArgs[0]));
end;

function TLinkObservers_ListSelectionChanged_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure ListSelectionChanged(const AObservers: TO...

  TLinkObservers_sc(AObj).ListSelectionChanged(TObservers_sw.FromVar(AArgs[0]));
end;

function TLinkObservers_ControlValueUpdate_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure ControlValueUpdate(AObservers: TObservers);

  TLinkObservers_sc(AObj).ControlValueUpdate(TObservers_sw.FromVar(AArgs[0]));
end;

function TLinkObservers_ControlValueModified_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure ControlValueModified(AObservers: TObserve...

  TLinkObservers_sc(AObj).ControlValueModified(TObservers_sw.FromVar(AArgs[0]));
end;

function TLinkObservers_ControlValueTrackUpdate_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function ControlValueTrackUpdate(const AObservers: ...

  Result := TLinkObservers_sc(AObj).ControlValueTrackUpdate(TObservers_sw.
    FromVar(AArgs[0]));
end;

function TLinkObservers_AllowControlChange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function AllowControlChange(const AControl: TCompon...

  Result := TLinkObservers_sc(AObj).AllowControlChange(TComponent_sw.FromVar(
    AArgs[0]));
end;

function TLinkObservers_ControlChanged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure ControlChanged(const AControl: TComponent);

  TLinkObservers_sc(AObj).ControlChanged(TComponent_sw.FromVar(AArgs[0]));
end;

class function TLinkObservers_sw.GetTypeName: WideString;
begin
  Result := 'TLinkObservers';
end;

class function TLinkObservers_sw.GetWrappedClass: TClass;
begin
  Result := TLinkObservers;
end;

class procedure TLinkObservers_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddClassProcedure('EditLinkUpdate', TLinkObservers_EditLinkUpdate_si, 1, False);
  AData.AddClassFunction('EditLinkTrackUpdate', TLinkObservers_EditLinkTrackUpdate_si, Boolean_sw, 1, False);
  AData.AddClassProcedure('EditLinkReset', TLinkObservers_EditLinkReset_si, 1, False);
  AData.AddClassProcedure('EditLinkModified', TLinkObservers_EditLinkModified_si, 1, False);
  AData.AddClassFunction('EditLinkIsModified', TLinkObservers_EditLinkIsModified_si, Boolean_sw, 1, False);
  AData.AddClassFunction('EditLinkIsValidChar', TLinkObservers_EditLinkIsValidChar_si, Boolean_sw, 2, False);
  AData.AddClassFunction('EditLinkIsEditing', TLinkObservers_EditLinkIsEditing_si, Boolean_sw, 1, False);
  AData.AddClassFunction('EditLinkEdit', TLinkObservers_EditLinkEdit_si, Boolean_sw, 1, False);
  AData.AddClassProcedure('EditLinkSetIsReadOnly', TLinkObservers_EditLinkSetIsReadOnly_si, 2, False);
  AData.AddClassFunction('EditLinkIsReadOnly', TLinkObservers_EditLinkIsReadOnly_si, Boolean_sw, 1, False);
  AData.AddClassProcedure('EditGridLinkUpdate', TLinkObservers_EditGridLinkUpdate_si, 1, False);
  AData.AddClassProcedure('EditGridLinkReset', TLinkObservers_EditGridLinkReset_si, 1, False);
  AData.AddClassProcedure('EditGridLinkModified', TLinkObservers_EditGridLinkModified_si, 1, False);
  AData.AddClassFunction('EditGridLinkIsModified', TLinkObservers_EditGridLinkIsModified_si, Boolean_sw, 1, False);
  AData.AddClassFunction('EditGridLinkIsValidChar', TLinkObservers_EditGridLinkIsValidChar_si, Boolean_sw, 2, False);
  AData.AddClassFunction('EditGridLinkIsEditing', TLinkObservers_EditGridLinkIsEditing_si, Boolean_sw, 1, False);
  AData.AddClassFunction('EditGridLinkEdit', TLinkObservers_EditGridLinkEdit_si, Boolean_sw, 1, False);
  AData.AddClassFunction('EditGridLinkIsReadOnly', TLinkObservers_EditGridLinkIsReadOnly_si, Boolean_sw, 1, False);
  AData.AddClassProcedure('EditGridLinkSetIsReadOnly', TLinkObservers_EditGridLinkSetIsReadOnly_si, 2, False);
  AData.AddClassProcedure('PositionLinkPosChanged', TLinkObservers_PositionLinkPosChanged_si, 1, False);
  AData.AddClassProcedure('PositionLinkPosChanging', TLinkObservers_PositionLinkPosChanging_si, 1, False);
  AData.AddClassProcedure('ListSelectionChanged', TLinkObservers_ListSelectionChanged_si, 1, False);
  AData.AddClassProcedure('ControlValueUpdate', TLinkObservers_ControlValueUpdate_si, 1, False);
  AData.AddClassProcedure('ControlValueModified', TLinkObservers_ControlValueModified_si, 1, False);
  AData.AddClassFunction('ControlValueTrackUpdate', TLinkObservers_ControlValueTrackUpdate_si, Boolean_sw, 1, False);
  AData.AddClassFunction('AllowControlChange', TLinkObservers_AllowControlChange_si, Boolean_sw, 1, False);
  AData.AddClassProcedure('ControlChanged', TLinkObservers_ControlChanged_si, 1, False);
end;

class function TLinkObservers_sw.ToVar(
  const AValue: TLinkObservers): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TLinkObservers_sw.FromVar(
  const AValue: OleVariant): TLinkObservers;
begin
  Result := TLinkObservers(ConvFromVar(AValue, TLinkObservers));
end;

class function TLinkObservers_sw.ClassToVar(
  AClass: TLinkObservers_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TLinkObservers_sw.ClassFromVar(
  const AClass: OleVariant): TLinkObservers_sc;
begin
  Result := TLinkObservers_sc(ConvClsFromVar(AClass, TLinkObservers));
end;

{ TObserverMapping_sw }

function TObserverMapping_EditLinkID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EditLinkID = <value>;

  Result := TObserverMapping_sc(AObj).EditLinkID;
end;

function TObserverMapping_EditGridLinkID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EditGridLinkID = <value>;

  Result := TObserverMapping_sc(AObj).EditGridLinkID;
end;

function TObserverMapping_PositionLinkID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const PositionLinkID = <value>;

  Result := TObserverMapping_sc(AObj).PositionLinkID;
end;

function TObserverMapping_ControlValueID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ControlValueID = <value>;

  Result := TObserverMapping_sc(AObj).ControlValueID;
end;

function TObserverMapping_MappedID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MappedID = <value>;

  Result := TObserverMapping_sc(AObj).MappedID;
end;

function TObserverMapping_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TObserverMapping_sw.ToVar(TObserverMapping_sc(AObj).Create());
end;

function TObserverMapping_GetObserverID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function GetObserverID(const Key: string): Integer;

  Result := TObserverMapping_sc(AObj).GetObserverID(string(AArgs[0]));
end;

class function TObserverMapping_sw.GetTypeName: WideString;
begin
  Result := 'TObserverMapping';
end;

class function TObserverMapping_sw.GetWrappedClass: TClass;
begin
  Result := TObserverMapping;
end;

class procedure TObserverMapping_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstant('EditLinkID', TObserverMapping_EditLinkID_si, nil, VarType(TObserverMapping.EditLinkID));
  AData.AddConstant('EditGridLinkID', TObserverMapping_EditGridLinkID_si, nil, VarType(TObserverMapping.EditGridLinkID));
  AData.AddConstant('PositionLinkID', TObserverMapping_PositionLinkID_si, nil, VarType(TObserverMapping.PositionLinkID));
  AData.AddConstant('ControlValueID', TObserverMapping_ControlValueID_si, nil, VarType(TObserverMapping.ControlValueID));
  AData.AddConstant('MappedID', TObserverMapping_MappedID_si, nil, VarType(TObserverMapping.MappedID));
  AData.AddConstructor('Create', TObserverMapping_Create_si, 0, False);
  AData.AddClassFunction('GetObserverID', TObserverMapping_GetObserverID_si, Integer_sw, 1, False);
end;

class function TObserverMapping_sw.ToVar(
  const AValue: TObserverMapping): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TObserverMapping_sw.FromVar(
  const AValue: OleVariant): TObserverMapping;
begin
  Result := TObserverMapping(ConvFromVar(AValue, TObserverMapping));
end;

class function TObserverMapping_sw.ClassToVar(
  AClass: TObserverMapping_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TObserverMapping_sw.ClassFromVar(
  const AClass: OleVariant): TObserverMapping_sc;
begin
  Result := TObserverMapping_sc(ConvClsFromVar(AClass, TObserverMapping));
end;

{ EObserverException_sw }

class function EObserverException_sw.GetTypeName: WideString;
begin
  Result := 'EObserverException';
end;

class function EObserverException_sw.GetWrappedClass: TClass;
begin
  Result := EObserverException;
end;

class procedure EObserverException_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EObserverException_sw.ToVar(
  const AValue: EObserverException): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EObserverException_sw.FromVar(
  const AValue: OleVariant): EObserverException;
begin
  Result := EObserverException(ConvFromVar(AValue, EObserverException));
end;

class function EObserverException_sw.ClassToVar(
  AClass: EObserverException_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EObserverException_sw.ClassFromVar(
  const AClass: OleVariant): EObserverException_sc;
begin
  Result := EObserverException_sc(ConvClsFromVar(AClass, EObserverException));
end;

{ TDefaultAttributeBase_sw }

function TDefaultAttributeBase_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: Variant read <getter>;

  Result := TDefaultAttributeBase(AObj).Value;
end;

class function TDefaultAttributeBase_sw.GetTypeName: WideString;
begin
  Result := 'TDefaultAttributeBase';
end;

class function TDefaultAttributeBase_sw.GetWrappedClass: TClass;
begin
  Result := TDefaultAttributeBase;
end;

class procedure TDefaultAttributeBase_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Value', TDefaultAttributeBase_Value_si, Variant_sw, True, False, 0, False, False);
end;

class function TDefaultAttributeBase_sw.ToVar(
  const AValue: TDefaultAttributeBase): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDefaultAttributeBase_sw.FromVar(
  const AValue: OleVariant): TDefaultAttributeBase;
begin
  Result := TDefaultAttributeBase(ConvFromVar(AValue, TDefaultAttributeBase));
end;

class function TDefaultAttributeBase_sw.ClassToVar(
  AClass: TDefaultAttributeBase_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDefaultAttributeBase_sw.ClassFromVar(
  const AClass: OleVariant): TDefaultAttributeBase_sc;
begin
  Result := TDefaultAttributeBase_sc(ConvClsFromVar(AClass, 
    TDefaultAttributeBase));
end;

{ DefaultAttribute_sw }

function DefaultAttribute_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  Result := DefaultAttribute_sw.ToVar(DefaultAttribute_sc(AObj).Create(string(
    AArgs[0])));
end;

class function DefaultAttribute_sw.GetTypeName: WideString;
begin
  Result := 'DefaultAttribute';
end;

class function DefaultAttribute_sw.GetWrappedClass: TClass;
begin
  Result := DefaultAttribute;
end;

class procedure DefaultAttribute_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', DefaultAttribute_Create_si, 1, False);
end;

class function DefaultAttribute_sw.ToVar(
  const AValue: DefaultAttribute): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function DefaultAttribute_sw.FromVar(
  const AValue: OleVariant): DefaultAttribute;
begin
  Result := DefaultAttribute(ConvFromVar(AValue, DefaultAttribute));
end;

class function DefaultAttribute_sw.ClassToVar(
  AClass: DefaultAttribute_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function DefaultAttribute_sw.ClassFromVar(
  const AClass: OleVariant): DefaultAttribute_sc;
begin
  Result := DefaultAttribute_sc(ConvClsFromVar(AClass, DefaultAttribute));
end;

{ NoDefaultAttribute_sw }

function NoDefaultAttribute_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := NoDefaultAttribute_sw.ToVar(NoDefaultAttribute_sc(AObj).Create());
end;

class function NoDefaultAttribute_sw.GetTypeName: WideString;
begin
  Result := 'NoDefaultAttribute';
end;

class function NoDefaultAttribute_sw.GetWrappedClass: TClass;
begin
  Result := NoDefaultAttribute;
end;

class procedure NoDefaultAttribute_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', NoDefaultAttribute_Create_si, 0, False);
end;

class function NoDefaultAttribute_sw.ToVar(
  const AValue: NoDefaultAttribute): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function NoDefaultAttribute_sw.FromVar(
  const AValue: OleVariant): NoDefaultAttribute;
begin
  Result := NoDefaultAttribute(ConvFromVar(AValue, NoDefaultAttribute));
end;

class function NoDefaultAttribute_sw.ClassToVar(
  AClass: NoDefaultAttribute_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function NoDefaultAttribute_sw.ClassFromVar(
  const AClass: OleVariant): NoDefaultAttribute_sc;
begin
  Result := NoDefaultAttribute_sc(ConvClsFromVar(AClass, NoDefaultAttribute));
end;

{ ObservableMemberAttribute_sw }

function ObservableMemberAttribute_Create_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  Result := ObservableMemberAttribute_sw.ToVar(ObservableMemberAttribute_sc(
    AObj).Create(string(AArgs[0])));
end;

function ObservableMemberAttribute_MemberName_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MemberName: string read <getter>;

  Result := ObservableMemberAttribute(AObj).MemberName;
end;

class function ObservableMemberAttribute_sw.GetTypeName: WideString;
begin
  Result := 'ObservableMemberAttribute';
end;

class function ObservableMemberAttribute_sw.GetWrappedClass: TClass;
begin
  Result := ObservableMemberAttribute;
end;

class procedure ObservableMemberAttribute_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('MemberName', ObservableMemberAttribute_MemberName_si, string_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', ObservableMemberAttribute_Create_si, 1, False);
end;

class function ObservableMemberAttribute_sw.ToVar(
  const AValue: ObservableMemberAttribute): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function ObservableMemberAttribute_sw.FromVar(
  const AValue: OleVariant): ObservableMemberAttribute;
begin
  Result := ObservableMemberAttribute(ConvFromVar(AValue, 
    ObservableMemberAttribute));
end;

class function ObservableMemberAttribute_sw.ClassToVar(
  AClass: ObservableMemberAttribute_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function ObservableMemberAttribute_sw.ClassFromVar(
  const AClass: OleVariant): ObservableMemberAttribute_sc;
begin
  Result := ObservableMemberAttribute_sc(ConvClsFromVar(AClass, 
    ObservableMemberAttribute));
end;

{ TBaseAsyncResult_sw }

function TBaseAsyncResult_Context_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Context: TObject read <getter>;

  Result := TObject_sw.ToVar(TBaseAsyncResult_sacc(TBaseAsyncResult(AObj)).
    Context);
end;

function TBaseAsyncResult_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  Result := TBaseAsyncResult_sw.ToVar(TBaseAsyncResult_sc(AObj).Create());
end;

function TBaseAsyncResult_WaitForCompletion_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WaitForCompletion;

  TBaseAsyncResult(AObj).WaitForCompletion();
end;

function TBaseAsyncResult_Dispatch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class procedure Dispatch(const AsyncResult: TBaseAsyncRes...

  TBaseAsyncResult_sc(AObj).Dispatch(TBaseAsyncResult_sw.FromVar(AArgs[0]));
end;

class function TBaseAsyncResult_sw.GetTypeName: WideString;
begin
  Result := 'TBaseAsyncResult';
end;

class function TBaseAsyncResult_sw.GetWrappedClass: TClass;
begin
  Result := TBaseAsyncResult;
end;

class procedure TBaseAsyncResult_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Context', TBaseAsyncResult_Context_si, TObject_sw, True, False, 0, True, False);
  AData.AddProcedure('WaitForCompletion', TBaseAsyncResult_WaitForCompletion_si, 0, False);

  { Class members }

  AData.AddConstructor('Create', TBaseAsyncResult_Create_si, 0, False);
  AData.AddClassProcedure('Dispatch', TBaseAsyncResult_Dispatch_si, 1, False);
end;

class function TBaseAsyncResult_sw.ToVar(
  const AValue: TBaseAsyncResult): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBaseAsyncResult_sw.FromVar(
  const AValue: OleVariant): TBaseAsyncResult;
begin
  Result := TBaseAsyncResult(ConvFromVar(AValue, TBaseAsyncResult));
end;

class function TBaseAsyncResult_sw.ClassToVar(
  AClass: TBaseAsyncResult_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBaseAsyncResult_sw.ClassFromVar(
  const AClass: OleVariant): TBaseAsyncResult_sc;
begin
  Result := TBaseAsyncResult_sc(ConvClsFromVar(AClass, TBaseAsyncResult));
end;

{ TComponent_sw }

function TComponent_OnGetDeltaStreams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetDeltaStreams: TGetDeltaStreamsEve...

  if IsGet then
    Result := TGetDeltaStreamsEvent_sw.ToVar(TComponent_sacc(TComponent(AObj)).
      OnGetDeltaStreams)
  else
    TComponent_sacc(TComponent(AObj)).OnGetDeltaStreams := 
      TGetDeltaStreamsEvent_sw.FromVar(AArgs[0]);
end;

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
  // procedure InsertComponent(const AComponent: TComponent);

  TComponent(AObj).InsertComponent(TComponent_sw.FromVar(AArgs[0]));
end;

function TComponent_RemoveComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RemoveComponent(const AComponent: TComponent);

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
  // property DesignInfo: TDesignInfo read <getter> write <set...

  if IsGet then
    Result := TDesignInfo_sw.ToVar(TComponent(AObj).DesignInfo)
  else
    TComponent(AObj).DesignInfo := TDesignInfo_sw.FromVar(AArgs[0]);
end;

function TComponent_Owner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Owner: TComponent read <getter>;

  Result := TComponent_sw.ToVar(TComponent(AObj).Owner);
end;

function TComponent_Observers_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Observers: TObservers read <getter>;

  Result := TObservers_sw.ToVar(TComponent(AObj).Observers);
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
  // property Tag: NativeInt read <getter> write <setter>;

  if IsGet then
    Result := NativeInt_sw.ToVar(TComponent(AObj).Tag)
  else
    TComponent(AObj).Tag := NativeInt_sw.FromVar(AArgs[0]);
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

  AData.AddProperty('OnGetDeltaStreams', TComponent_OnGetDeltaStreams_si, TGetDeltaStreamsEvent_sw, True, True, 0, True, False);
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
  AData.AddProperty('Components', TComponent_Components_si, TComponent_sw, True, False, 1, False, False);
  AData.AddProperty('ComponentCount', TComponent_ComponentCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ComponentIndex', TComponent_ComponentIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('DesignInfo', TComponent_DesignInfo_si, TDesignInfo_sw, True, True, 0, False, False);
  AData.AddProperty('Owner', TComponent_Owner_si, TComponent_sw, True, False, 0, False, False);
  AData.AddProperty('Observers', TComponent_Observers_si, TObservers_sw, True, False, 0, False, False);
  AData.AddProperty('Name', TComponent_Name_si, TComponentName_sw, True, True, 0, False, False);
  AData.AddProperty('Tag', TComponent_Tag_si, NativeInt_sw, True, True, 0, False, False);

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

  case AArgsSize of
    0:
    begin
      Result := TBasicActionLink(AObj).Execute();
    end;
    1:
    begin
      Result := TBasicActionLink(AObj).Execute(TComponent_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Execute');
  end;
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

  AData.AddFunction('Execute', TBasicActionLink_Execute_si, Boolean_sw, 0, True);
  AData.AddFunction('Update', TBasicActionLink_Update_si, Boolean_sw, 0, False);
  AData.AddProperty('Action', TBasicActionLink_Action_si, TBasicAction_sw, True, True, 0, False, False);
  AData.AddProperty('OnChange', TBasicActionLink_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);

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

{ TActionEvent_sh }

function TActionEvent_sh.GetHandler: TMethod;
var
  hdr: TActionEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TActionEvent_sh.Handler(Action: TBasicAction; var Handled: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Action: TBasicAction; var Handled: Boolean) of...

  v_1 := Handled;
  args[0] := TBasicAction_sw.ToVar(Action);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Handled := Boolean(v_1);
end;

{ TActionEvent_sw }

class function TActionEvent_sw.GetTypeName: WideString;
begin
  Result := 'TActionEvent';
end;

class function TActionEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TActionEvent_sh;
end;

class function TActionEvent_sw.ToVar(const AValue: TActionEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TActionEvent_sw.FromVar(const AValue: OleVariant): TActionEvent;
begin
  Result := TActionEvent(ConvFromVar(AValue));
end;

class function TActionEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TActionEvent;
var
  hdlr: TActionEvent_sh;
begin
  hdlr   := TActionEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TActionEvent_sw));
  Result := hdlr.Handler;
end;

{ THintEvent_sh }

function THintEvent_sh.GetHandler: TMethod;
var
  hdr: THintEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure THintEvent_sh.Handler(var HintStr: string; var CanShow: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure (var HintStr: string; var CanShow: Boolean) of ...

  v_1 := HintStr;
  v_2 := CanShow;
  args[0] := MakeVarRef(v_1);
  args[1] := MakeVarRef(v_2);
  Self.Owner.RunProc(Self.ProcName, args);
  HintStr := string(v_1);
  CanShow := Boolean(v_2);
end;

{ THintEvent_sw }

class function THintEvent_sw.GetTypeName: WideString;
begin
  Result := 'THintEvent';
end;

class function THintEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := THintEvent_sh;
end;

class function THintEvent_sw.ToVar(const AValue: THintEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function THintEvent_sw.FromVar(const AValue: OleVariant): THintEvent;
begin
  Result := THintEvent(ConvFromVar(AValue));
end;

class function THintEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): THintEvent;
var
  hdlr: THintEvent_sh;
begin
  hdlr   := THintEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    THintEvent_sw));
  Result := hdlr.Handler;
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

function TBasicAction_ClientCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ClientCount: Integer read <getter>;

  Result := TBasicAction_sacc(TBasicAction(AObj)).ClientCount;
end;

function TBasicAction_Clients_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Clients[Index: Integer]: TBasicActionL...

  Result := TBasicActionLink_sw.ToVar(TBasicAction_sacc(TBasicAction(AObj)).
    Clients[Integer(AArgs[0])]);
end;

function TBasicAction_Suspended_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Suspended: Boolean;

  Result := TBasicAction(AObj).Suspended();
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
  // procedure RegisterChanges(const Value: TBasicActionLink);

  TBasicAction(AObj).RegisterChanges(TBasicActionLink_sw.FromVar(AArgs[0]));
end;

function TBasicAction_UnRegisterChanges_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnRegisterChanges(const Value: TBasicActionLink);

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

  AData.AddProperty('OnChange', TBasicAction_OnChange_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('ClientCount', TBasicAction_ClientCount_si, Integer_sw, True, False, 0, True, False);
  AData.AddProperty('Clients', TBasicAction_Clients_si, TBasicActionLink_sw, True, False, 1, True, False);
  AData.AddFunction('Suspended', TBasicAction_Suspended_si, Boolean_sw, 0, False);
  AData.AddFunction('HandlesTarget', TBasicAction_HandlesTarget_si, Boolean_sw, 1, False);
  AData.AddProcedure('UpdateTarget', TBasicAction_UpdateTarget_si, 1, False);
  AData.AddProcedure('ExecuteTarget', TBasicAction_ExecuteTarget_si, 1, False);
  AData.AddFunction('Execute', TBasicAction_Execute_si, Boolean_sw, 0, False);
  AData.AddProcedure('RegisterChanges', TBasicAction_RegisterChanges_si, 1, False);
  AData.AddProcedure('UnRegisterChanges', TBasicAction_UnRegisterChanges_si, 1, False);
  AData.AddFunction('Update', TBasicAction_Update_si, Boolean_sw, 0, False);
  AData.AddProperty('ActionComponent', TBasicAction_ActionComponent_si, TComponent_sw, True, True, 0, False, False);
  AData.AddProperty('OnExecute', TBasicAction_OnExecute_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnUpdate', TBasicAction_OnUpdate_si, TNotifyEvent_sw, True, True, 0, False, False);
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

  case AArgsSize of
    1:
    begin
      Result := TDataModule_sw.ToVar(TDataModule_sc(AObj).CreateNew(
        TComponent_sw.FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TDataModule_sw.ToVar(TDataModule_sc(AObj).CreateNew(
        TComponent_sw.FromVar(AArgs[0]), Integer(AArgs[1])));
    end;
  else
    WrongArgCountError('CreateNew');
  end;
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

  AData.AddProperty('DesignOffset', TDataModule_DesignOffset_si, TPoint_sw, True, True, 0, False, False);
  AData.AddProperty('DesignSize', TDataModule_DesignSize_si, TPoint_sw, True, True, 0, False, False);
  AData.AddProperty('OldCreateOrder', TDataModule_OldCreateOrder_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnCreate', TDataModule_OnCreate_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDestroy', TDataModule_OnDestroy_si, TNotifyEvent_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('CreateNew', TDataModule_CreateNew_si, 1, True);
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

class procedure TActiveXRegType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'axrComponentOnly'; Value: Integer({$IFDEF LMDSCT_12}TActiveXRegType.{$ENDIF}axrComponentOnly)),
    (Name: 'axrIncludeDescendants'; Value: Integer({$IFDEF LMDSCT_12}TActiveXRegType.{$ENDIF}axrIncludeDescendants))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
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

function TIdentMapEntry_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TIdentMapEntry_sw.Create as IDispatch;
end;

function TIdentMapEntry_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TIdentMapEntry;

  // Implicit record copy method.
  Result := TIdentMapEntry_sw.ToVar(TIdentMapEntry(AObj));
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

  AData.AddField('Value', TIdentMapEntry_Value_si, Integer_sw);
  AData.AddField('Name', TIdentMapEntry_Name_si, string_sw);
  AData.AddFunction('Copy', TIdentMapEntry_Copy_si, TIdentMapEntry_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TIdentMapEntry_Create_si, 0, False);
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

class procedure TStreamOriginalFormat_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'sofUnknown'; Value: Integer({$IFDEF LMDSCT_12}TStreamOriginalFormat.{$ENDIF}sofUnknown)),
    (Name: 'sofBinary'; Value: Integer({$IFDEF LMDSCT_12}TStreamOriginalFormat.{$ENDIF}sofBinary)),
    (Name: 'sofText'; Value: Integer({$IFDEF LMDSCT_12}TStreamOriginalFormat.{$ENDIF}sofText)),
    (Name: 'sofUTF8Text'; Value: Integer({$IFDEF LMDSCT_12}TStreamOriginalFormat.{$ENDIF}sofUTF8Text))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
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

{ TWndMethod_sh }

function TWndMethod_sh.GetHandler: TMethod;
var
  hdr: TWndMethod;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TWndMethod_sh.Handler(var Message: TMessage);
var
  args: array[0..0] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (var Message: TMessage) of object

  v_1 := TMessage_sw.ToVar(Message);
  args[0] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Message := TMessage_sw.FromVar(v_1);
end;

{ TWndMethod_sw }

class function TWndMethod_sw.GetTypeName: WideString;
begin
  Result := 'TWndMethod';
end;

class function TWndMethod_sw.GetScriptHandlerClass: TClass;
begin
  Result := TWndMethod_sh;
end;

class function TWndMethod_sw.ToVar(const AValue: TWndMethod): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TWndMethod_sw.FromVar(const AValue: OleVariant): TWndMethod;
begin
  Result := TWndMethod(ConvFromVar(AValue));
end;

class function TWndMethod_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TWndMethod;
var
  hdlr: TWndMethod_sh;
begin
  hdlr   := TWndMethod_sh(AScriptControl.GetEventHandler(AProcName, 
    TWndMethod_sw));
  Result := hdlr.Handler;
end;

{ TTextReader_sw }

function TTextReader_Close_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Close;

  TTextReader(AObj).Close();
end;

function TTextReader_Peek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Peek: Integer;

  Result := TTextReader(AObj).Peek();
end;

function TTextReader_Read_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Read(...); overload;

  Result := TTextReader(AObj).Read();
end;

function TTextReader_ReadLine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadLine: string;

  Result := TTextReader(AObj).ReadLine();
end;

function TTextReader_ReadToEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadToEnd: string;

  Result := TTextReader(AObj).ReadToEnd();
end;

class function TTextReader_sw.GetTypeName: WideString;
begin
  Result := 'TTextReader';
end;

class function TTextReader_sw.GetWrappedClass: TClass;
begin
  Result := TTextReader;
end;

class procedure TTextReader_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Close', TTextReader_Close_si, 0, False);
  AData.AddFunction('Peek', TTextReader_Peek_si, Integer_sw, 0, False);
  AData.AddFunction('Read', TTextReader_Read_si, nil, 0, False);
  AData.AddFunction('ReadLine', TTextReader_ReadLine_si, string_sw, 0, False);
  AData.AddFunction('ReadToEnd', TTextReader_ReadToEnd_si, string_sw, 0, False);
end;

class function TTextReader_sw.ToVar(const AValue: TTextReader): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTextReader_sw.FromVar(const AValue: OleVariant): TTextReader;
begin
  Result := TTextReader(ConvFromVar(AValue, TTextReader));
end;

class function TTextReader_sw.ClassToVar(AClass: TTextReader_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTextReader_sw.ClassFromVar(
  const AClass: OleVariant): TTextReader_sc;
begin
  Result := TTextReader_sc(ConvClsFromVar(AClass, TTextReader));
end;

{ TTextWriter_sw }

function TTextWriter_Close_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Close;

  TTextWriter(AObj).Close();
end;

function TTextWriter_Flush_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Flush;

  TTextWriter(AObj).Flush();
end;

function TTextWriter_Write_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Write(...); overload;

  TTextWriter(AObj).Write(string(AArgs[0]));
end;

function TTextWriter_WriteLine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function WriteLine(...); overload;

  case AArgsSize of
    0:
    begin
      TTextWriter(AObj).WriteLine();
    end;
    1:
    begin
      TTextWriter(AObj).WriteLine(string(AArgs[0]));
    end;
  else
    WrongArgCountError('WriteLine');
  end;
end;

class function TTextWriter_sw.GetTypeName: WideString;
begin
  Result := 'TTextWriter';
end;

class function TTextWriter_sw.GetWrappedClass: TClass;
begin
  Result := TTextWriter;
end;

class procedure TTextWriter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Close', TTextWriter_Close_si, 0, False);
  AData.AddProcedure('Flush', TTextWriter_Flush_si, 0, False);
  AData.AddProcedure('Write', TTextWriter_Write_si, 1, False);
  AData.AddProcedure('WriteLine', TTextWriter_WriteLine_si, 0, True);
end;

class function TTextWriter_sw.ToVar(const AValue: TTextWriter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTextWriter_sw.FromVar(const AValue: OleVariant): TTextWriter;
begin
  Result := TTextWriter(ConvFromVar(AValue, TTextWriter));
end;

class function TTextWriter_sw.ClassToVar(AClass: TTextWriter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTextWriter_sw.ClassFromVar(
  const AClass: OleVariant): TTextWriter_sc;
begin
  Result := TTextWriter_sc(ConvClsFromVar(AClass, TTextWriter));
end;

{ TBinaryReader_sw }

function TBinaryReader_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TBinaryReader_sw.ToVar(TBinaryReader_sc(AObj).Create(string(
        AArgs[0])));
    end;
    2:
    begin
      Result := TBinaryReader_sw.ToVar(TBinaryReader_sc(AObj).Create(string(
        AArgs[0]), TEncoding_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TBinaryReader_Close_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Close;

  TBinaryReader(AObj).Close();
end;

function TBinaryReader_PeekChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function PeekChar: Integer;

  Result := TBinaryReader(AObj).PeekChar();
end;

function TBinaryReader_Read_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Read(...); overload;

  Result := TBinaryReader(AObj).Read();
end;

function TBinaryReader_ReadBoolean_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadBoolean: Boolean;

  Result := TBinaryReader(AObj).ReadBoolean();
end;

function TBinaryReader_ReadByte_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadByte: Byte;

  Result := TBinaryReader(AObj).ReadByte();
end;

function TBinaryReader_ReadChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadChar: Char;

  Result := Ord(TBinaryReader(AObj).ReadChar());
end;

function TBinaryReader_ReadDouble_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadDouble: Double;

  Result := TBinaryReader(AObj).ReadDouble();
end;

function TBinaryReader_ReadSByte_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadSByte: ShortInt;

  Result := TBinaryReader(AObj).ReadSByte();
end;

function TBinaryReader_ReadShortInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadShortInt: ShortInt;

  Result := TBinaryReader(AObj).ReadShortInt();
end;

function TBinaryReader_ReadSmallInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadSmallInt: SmallInt;

  Result := TBinaryReader(AObj).ReadSmallInt();
end;

function TBinaryReader_ReadInt16_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadInt16: SmallInt;

  Result := TBinaryReader(AObj).ReadInt16();
end;

function TBinaryReader_ReadInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadInteger: Integer;

  Result := TBinaryReader(AObj).ReadInteger();
end;

function TBinaryReader_ReadInt32_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadInt32: Integer;

  Result := TBinaryReader(AObj).ReadInt32();
end;

function TBinaryReader_ReadInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadInt64: Int64;

  Result := Int64_sw.ToVar(TBinaryReader(AObj).ReadInt64());
end;

function TBinaryReader_ReadSingle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadSingle: Single;

  Result := TBinaryReader(AObj).ReadSingle();
end;

function TBinaryReader_ReadString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadString: string;

  Result := TBinaryReader(AObj).ReadString();
end;

function TBinaryReader_ReadWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadWord: Word;

  Result := TBinaryReader(AObj).ReadWord();
end;

function TBinaryReader_ReadUInt16_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadUInt16: Word;

  Result := TBinaryReader(AObj).ReadUInt16();
end;

function TBinaryReader_ReadCardinal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadCardinal: Cardinal;

  Result := TBinaryReader(AObj).ReadCardinal();
end;

function TBinaryReader_ReadUInt32_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadUInt32: Cardinal;

  Result := TBinaryReader(AObj).ReadUInt32();
end;

function TBinaryReader_ReadUInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadUInt64: UInt64;

  Result := UInt64_sw.ToVar(TBinaryReader(AObj).ReadUInt64());
end;

function TBinaryReader_BaseStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BaseStream: TStream read <getter>;

  Result := TStream_sw.ToVar(TBinaryReader(AObj).BaseStream);
end;

class function TBinaryReader_sw.GetTypeName: WideString;
begin
  Result := 'TBinaryReader';
end;

class function TBinaryReader_sw.GetWrappedClass: TClass;
begin
  Result := TBinaryReader;
end;

class procedure TBinaryReader_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Close', TBinaryReader_Close_si, 0, False);
  AData.AddFunction('PeekChar', TBinaryReader_PeekChar_si, Integer_sw, 0, False);
  AData.AddFunction('Read', TBinaryReader_Read_si, nil, 0, False);
  AData.AddFunction('ReadBoolean', TBinaryReader_ReadBoolean_si, Boolean_sw, 0, False);
  AData.AddFunction('ReadByte', TBinaryReader_ReadByte_si, Byte_sw, 0, False);
  AData.AddFunction('ReadChar', TBinaryReader_ReadChar_si, Char_sw, 0, False);
  AData.AddFunction('ReadDouble', TBinaryReader_ReadDouble_si, Double_sw, 0, False);
  AData.AddFunction('ReadSByte', TBinaryReader_ReadSByte_si, ShortInt_sw, 0, False);
  AData.AddFunction('ReadShortInt', TBinaryReader_ReadShortInt_si, ShortInt_sw, 0, False);
  AData.AddFunction('ReadSmallInt', TBinaryReader_ReadSmallInt_si, SmallInt_sw, 0, False);
  AData.AddFunction('ReadInt16', TBinaryReader_ReadInt16_si, SmallInt_sw, 0, False);
  AData.AddFunction('ReadInteger', TBinaryReader_ReadInteger_si, Integer_sw, 0, False);
  AData.AddFunction('ReadInt32', TBinaryReader_ReadInt32_si, Integer_sw, 0, False);
  AData.AddFunction('ReadInt64', TBinaryReader_ReadInt64_si, Int64_sw, 0, False);
  AData.AddFunction('ReadSingle', TBinaryReader_ReadSingle_si, Single_sw, 0, False);
  AData.AddFunction('ReadString', TBinaryReader_ReadString_si, string_sw, 0, False);
  AData.AddFunction('ReadWord', TBinaryReader_ReadWord_si, Word_sw, 0, False);
  AData.AddFunction('ReadUInt16', TBinaryReader_ReadUInt16_si, Word_sw, 0, False);
  AData.AddFunction('ReadCardinal', TBinaryReader_ReadCardinal_si, Cardinal_sw, 0, False);
  AData.AddFunction('ReadUInt32', TBinaryReader_ReadUInt32_si, Cardinal_sw, 0, False);
  AData.AddFunction('ReadUInt64', TBinaryReader_ReadUInt64_si, UInt64_sw, 0, False);
  AData.AddProperty('BaseStream', TBinaryReader_BaseStream_si, TStream_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TBinaryReader_Create_si, 1, True);
end;

class function TBinaryReader_sw.ToVar(const AValue: TBinaryReader): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBinaryReader_sw.FromVar(
  const AValue: OleVariant): TBinaryReader;
begin
  Result := TBinaryReader(ConvFromVar(AValue, TBinaryReader));
end;

class function TBinaryReader_sw.ClassToVar(
  AClass: TBinaryReader_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBinaryReader_sw.ClassFromVar(
  const AClass: OleVariant): TBinaryReader_sc;
begin
  Result := TBinaryReader_sc(ConvClsFromVar(AClass, TBinaryReader));
end;

{ TBinaryWriter_sw }

function TBinaryWriter_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TBinaryWriter_sw.ToVar(TBinaryWriter_sc(AObj).Create(TStream_sw.
        FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TBinaryWriter_sw.ToVar(TBinaryWriter_sc(AObj).Create(TStream_sw.
        FromVar(AArgs[0]), TEncoding_sw.FromVar(AArgs[1])));
    end;
    3:
    begin
      Result := TBinaryWriter_sw.ToVar(TBinaryWriter_sc(AObj).Create(TStream_sw.
        FromVar(AArgs[0]), TEncoding_sw.FromVar(AArgs[1]), Boolean(AArgs[2])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TBinaryWriter_Close_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Close;

  TBinaryWriter(AObj).Close();
end;

function TBinaryWriter_Seek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Seek(const Offset: Int64; Origin: TSeekOrigin): ...

  Result := Int64_sw.ToVar(TBinaryWriter(AObj).Seek(Int64_sw.FromVar(AArgs[0]), 
    TSeekOrigin_sw.FromVar(AArgs[1])));
end;

function TBinaryWriter_Write_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Write(...); overload;

  TBinaryWriter(AObj).Write(string(AArgs[0]));
end;

function TBinaryWriter_BaseStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BaseStream: TStream read <getter>;

  Result := TStream_sw.ToVar(TBinaryWriter(AObj).BaseStream);
end;

function TBinaryWriter_Null_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Null: TBinaryWriter read <getter>;

  Result := TBinaryWriter_sw.ToVar(TBinaryWriter_sc(AObj).Null);
end;

class function TBinaryWriter_sw.GetTypeName: WideString;
begin
  Result := 'TBinaryWriter';
end;

class function TBinaryWriter_sw.GetWrappedClass: TClass;
begin
  Result := TBinaryWriter;
end;

class procedure TBinaryWriter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Close', TBinaryWriter_Close_si, 0, False);
  AData.AddFunction('Seek', TBinaryWriter_Seek_si, Int64_sw, 2, False);
  AData.AddProcedure('Write', TBinaryWriter_Write_si, 1, False);
  AData.AddProperty('BaseStream', TBinaryWriter_BaseStream_si, TStream_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TBinaryWriter_Create_si, 1, True);
  AData.AddClassProperty('Null', TBinaryWriter_Null_si, TBinaryWriter_sw, True, False, 0, False);
end;

class function TBinaryWriter_sw.ToVar(const AValue: TBinaryWriter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBinaryWriter_sw.FromVar(
  const AValue: OleVariant): TBinaryWriter;
begin
  Result := TBinaryWriter(ConvFromVar(AValue, TBinaryWriter));
end;

class function TBinaryWriter_sw.ClassToVar(
  AClass: TBinaryWriter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBinaryWriter_sw.ClassFromVar(
  const AClass: OleVariant): TBinaryWriter_sc;
begin
  Result := TBinaryWriter_sc(ConvClsFromVar(AClass, TBinaryWriter));
end;

{ TStringReader_sw }

function TStringReader_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(S: string);

  Result := TStringReader_sw.ToVar(TStringReader_sc(AObj).Create(string(
    AArgs[0])));
end;

class function TStringReader_sw.GetTypeName: WideString;
begin
  Result := 'TStringReader';
end;

class function TStringReader_sw.GetWrappedClass: TClass;
begin
  Result := TStringReader;
end;

class procedure TStringReader_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TStringReader_Create_si, 1, False);
end;

class function TStringReader_sw.ToVar(const AValue: TStringReader): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStringReader_sw.FromVar(
  const AValue: OleVariant): TStringReader;
begin
  Result := TStringReader(ConvFromVar(AValue, TStringReader));
end;

class function TStringReader_sw.ClassToVar(
  AClass: TStringReader_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStringReader_sw.ClassFromVar(
  const AClass: OleVariant): TStringReader_sc;
begin
  Result := TStringReader_sc(ConvClsFromVar(AClass, TStringReader));
end;

{ TStringWriter_sw }

function TStringWriter_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    0:
    begin
      Result := TStringWriter_sw.ToVar(TStringWriter_sc(AObj).Create());
    end;
    1:
    begin
      Result := TStringWriter_sw.ToVar(TStringWriter_sc(AObj).Create(
        TStringBuilder_sw.FromVar(AArgs[0])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

class function TStringWriter_sw.GetTypeName: WideString;
begin
  Result := 'TStringWriter';
end;

class function TStringWriter_sw.GetWrappedClass: TClass;
begin
  Result := TStringWriter;
end;

class procedure TStringWriter_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TStringWriter_Create_si, 0, True);
end;

class function TStringWriter_sw.ToVar(const AValue: TStringWriter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStringWriter_sw.FromVar(
  const AValue: OleVariant): TStringWriter;
begin
  Result := TStringWriter(ConvFromVar(AValue, TStringWriter));
end;

class function TStringWriter_sw.ClassToVar(
  AClass: TStringWriter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStringWriter_sw.ClassFromVar(
  const AClass: OleVariant): TStringWriter_sc;
begin
  Result := TStringWriter_sc(ConvClsFromVar(AClass, TStringWriter));
end;

{ TStreamWriter_sw }

function TStreamWriter_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TStreamWriter_sw.ToVar(TStreamWriter_sc(AObj).Create(TStream_sw.
        FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TStreamWriter_sw.ToVar(TStreamWriter_sc(AObj).Create(TStream_sw.
        FromVar(AArgs[0]), TEncoding_sw.FromVar(AArgs[1])));
    end;
    3:
    begin
      Result := TStreamWriter_sw.ToVar(TStreamWriter_sc(AObj).Create(TStream_sw.
        FromVar(AArgs[0]), TEncoding_sw.FromVar(AArgs[1]), Integer(AArgs[2])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TStreamWriter_OwnStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure OwnStream;

  TStreamWriter(AObj).OwnStream();
end;

function TStreamWriter_AutoFlush_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoFlush: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TStreamWriter(AObj).AutoFlush
  else
    TStreamWriter(AObj).AutoFlush := Boolean(AArgs[0]);
end;

function TStreamWriter_NewLine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NewLine: string read <getter> write <setter>;

  if IsGet then
    Result := TStreamWriter(AObj).NewLine
  else
    TStreamWriter(AObj).NewLine := string(AArgs[0]);
end;

function TStreamWriter_Encoding_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Encoding: TEncoding read <getter>;

  Result := TEncoding_sw.ToVar(TStreamWriter(AObj).Encoding);
end;

function TStreamWriter_BaseStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BaseStream: TStream read <getter>;

  Result := TStream_sw.ToVar(TStreamWriter(AObj).BaseStream);
end;

class function TStreamWriter_sw.GetTypeName: WideString;
begin
  Result := 'TStreamWriter';
end;

class function TStreamWriter_sw.GetWrappedClass: TClass;
begin
  Result := TStreamWriter;
end;

class procedure TStreamWriter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('OwnStream', TStreamWriter_OwnStream_si, 0, False);
  AData.AddProperty('AutoFlush', TStreamWriter_AutoFlush_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('NewLine', TStreamWriter_NewLine_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Encoding', TStreamWriter_Encoding_si, TEncoding_sw, True, False, 0, False, False);
  AData.AddProperty('BaseStream', TStreamWriter_BaseStream_si, TStream_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TStreamWriter_Create_si, 1, True);
end;

class function TStreamWriter_sw.ToVar(const AValue: TStreamWriter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStreamWriter_sw.FromVar(
  const AValue: OleVariant): TStreamWriter;
begin
  Result := TStreamWriter(ConvFromVar(AValue, TStreamWriter));
end;

class function TStreamWriter_sw.ClassToVar(
  AClass: TStreamWriter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStreamWriter_sw.ClassFromVar(
  const AClass: OleVariant): TStreamWriter_sc;
begin
  Result := TStreamWriter_sc(ConvClsFromVar(AClass, TStreamWriter));
end;

{ TStreamReader_sw }

function TStreamReader_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TStreamReader_sw.ToVar(TStreamReader_sc(AObj).Create(TStream_sw.
        FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TStreamReader_sw.ToVar(TStreamReader_sc(AObj).Create(TStream_sw.
        FromVar(AArgs[0]), TEncoding_sw.FromVar(AArgs[1])));
    end;
    3:
    begin
      Result := TStreamReader_sw.ToVar(TStreamReader_sc(AObj).Create(TStream_sw.
        FromVar(AArgs[0]), TEncoding_sw.FromVar(AArgs[1]), Boolean(AArgs[2])));
    end;
    4:
    begin
      Result := TStreamReader_sw.ToVar(TStreamReader_sc(AObj).Create(TStream_sw.
        FromVar(AArgs[0]), TEncoding_sw.FromVar(AArgs[1]), Boolean(AArgs[2]),
        Integer(AArgs[3])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TStreamReader_DiscardBufferedData_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DiscardBufferedData;

  TStreamReader(AObj).DiscardBufferedData();
end;

function TStreamReader_OwnStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure OwnStream;

  TStreamReader(AObj).OwnStream();
end;

function TStreamReader_BaseStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BaseStream: TStream read <getter>;

  Result := TStream_sw.ToVar(TStreamReader(AObj).BaseStream);
end;

function TStreamReader_CurrentEncoding_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CurrentEncoding: TEncoding read <getter>;

  Result := TEncoding_sw.ToVar(TStreamReader(AObj).CurrentEncoding);
end;

function TStreamReader_EndOfStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EndOfStream: Boolean read <getter>;

  Result := TStreamReader(AObj).EndOfStream;
end;

class function TStreamReader_sw.GetTypeName: WideString;
begin
  Result := 'TStreamReader';
end;

class function TStreamReader_sw.GetWrappedClass: TClass;
begin
  Result := TStreamReader;
end;

class procedure TStreamReader_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('DiscardBufferedData', TStreamReader_DiscardBufferedData_si, 0, False);
  AData.AddProcedure('OwnStream', TStreamReader_OwnStream_si, 0, False);
  AData.AddProperty('BaseStream', TStreamReader_BaseStream_si, TStream_sw, True, False, 0, False, False);
  AData.AddProperty('CurrentEncoding', TStreamReader_CurrentEncoding_si, TEncoding_sw, True, False, 0, False, False);
  AData.AddProperty('EndOfStream', TStreamReader_EndOfStream_si, Boolean_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TStreamReader_Create_si, 1, True);
end;

class function TStreamReader_sw.ToVar(const AValue: TStreamReader): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStreamReader_sw.FromVar(
  const AValue: OleVariant): TStreamReader;
begin
  Result := TStreamReader(ConvFromVar(AValue, TStreamReader));
end;

class function TStreamReader_sw.ClassToVar(
  AClass: TStreamReader_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStreamReader_sw.ClassFromVar(
  const AClass: OleVariant): TStreamReader_sc;
begin
  Result := TStreamReader_sc(ConvClsFromVar(AClass, TStreamReader));
end;

{ ELoginCredentialError_sw }

class function ELoginCredentialError_sw.GetTypeName: WideString;
begin
  Result := 'ELoginCredentialError';
end;

class function ELoginCredentialError_sw.GetWrappedClass: TClass;
begin
  Result := ELoginCredentialError;
end;

class procedure ELoginCredentialError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function ELoginCredentialError_sw.ToVar(
  const AValue: ELoginCredentialError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function ELoginCredentialError_sw.FromVar(
  const AValue: OleVariant): ELoginCredentialError;
begin
  Result := ELoginCredentialError(ConvFromVar(AValue, ELoginCredentialError));
end;

class function ELoginCredentialError_sw.ClassToVar(
  AClass: ELoginCredentialError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function ELoginCredentialError_sw.ClassFromVar(
  const AClass: OleVariant): ELoginCredentialError_sc;
begin
  Result := ELoginCredentialError_sc(ConvClsFromVar(AClass, 
    ELoginCredentialError));
end;

{ TLoginCredentialService_sw }

function TLoginCredentialService_Default_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Default = <value>;

  Result := TLoginCredentialService_sc(AObj).Default;
end;

function TLoginCredentialService_DefaultUsrPw_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DefaultUsrPw = <value>;

  Result := TLoginCredentialService_sc(AObj).DefaultUsrPw;
end;

function TLoginCredentialService_DefaultUsrPwDm_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DefaultUsrPwDm = <value>;

  Result := TLoginCredentialService_sc(AObj).DefaultUsrPwDm;
end;

function TLoginCredentialService_GetLoginCredentials_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
  v_2: string;
  v_3: string;
  v_4: string;
  v_5: string;
begin
  // procedure/function GetLoginCredentials(...); overload;

  case AArgsSize of
    3:
    begin
      v_1 := string(AArgs[1]);
      v_2 := string(AArgs[2]);
      Result := TLoginCredentialService_sc(AObj).GetLoginCredentials(string(
        AArgs[0]), v_1, v_2);
      AssignRefParam(AArgs[1], v_1);
      AssignRefParam(AArgs[2], v_2);
    end;
    4:
    begin
      v_3 := string(AArgs[1]);
      v_4 := string(AArgs[2]);
      v_5 := string(AArgs[3]);
      Result := TLoginCredentialService_sc(AObj).GetLoginCredentials(string(
        AArgs[0]), v_3, v_4, v_5);
      AssignRefParam(AArgs[1], v_3);
      AssignRefParam(AArgs[2], v_4);
      AssignRefParam(AArgs[3], v_5);
    end;
  else
    WrongArgCountError('GetLoginCredentials');
  end;
end;

class function TLoginCredentialService_sw.GetTypeName: WideString;
begin
  Result := 'TLoginCredentialService';
end;

class function TLoginCredentialService_sw.GetWrappedClass: TClass;
begin
  Result := TLoginCredentialService;
end;

class procedure TLoginCredentialService_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstant('Default', TLoginCredentialService_Default_si, nil, VarType(TLoginCredentialService.Default));
  AData.AddConstant('DefaultUsrPw', TLoginCredentialService_DefaultUsrPw_si, nil, VarType(TLoginCredentialService.DefaultUsrPw));
  AData.AddConstant('DefaultUsrPwDm', TLoginCredentialService_DefaultUsrPwDm_si, nil, VarType(TLoginCredentialService.DefaultUsrPwDm));
  AData.AddClassFunction('GetLoginCredentials', TLoginCredentialService_GetLoginCredentials_si, nil, 3, True);
end;

class function TLoginCredentialService_sw.ToVar(
  const AValue: TLoginCredentialService): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TLoginCredentialService_sw.FromVar(
  const AValue: OleVariant): TLoginCredentialService;
begin
  Result := TLoginCredentialService(ConvFromVar(AValue, 
    TLoginCredentialService));
end;

class function TLoginCredentialService_sw.ClassToVar(
  AClass: TLoginCredentialService_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TLoginCredentialService_sw.ClassFromVar(
  const AClass: OleVariant): TLoginCredentialService_sc;
begin
  Result := TLoginCredentialService_sc(ConvClsFromVar(AClass, 
    TLoginCredentialService));
end;

{ Classes_sw }

function Classes_MaxListSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MaxListSize = <value>;

  Result := MaxListSize;
end;

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
  // type TSeekOrigin = (soBeginning, soCurrent, soEnd);

  Result := TLMDUnitWrapper.TypeToVar(TSeekOrigin_sw);
end;

function Classes_TPlatformIds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPlatformIds = UInt32;

  Result := TLMDUnitWrapper.TypeToVar(TPlatformIds_sw);
end;

function Classes_fmCreate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const fmCreate = <value>;

  Result := fmCreate;
end;

function Classes_toEOF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const toEOF = <value>;

  Result := Ord(toEOF);
end;

function Classes_toSymbol_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const toSymbol = <value>;

  Result := Ord(toSymbol);
end;

function Classes_toString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const toString = <value>;

  Result := Ord(toString);
end;

function Classes_toInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const toInteger = <value>;

  Result := Ord(toInteger);
end;

function Classes_toFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const toFloat = <value>;

  Result := Ord(toFloat);
end;

function Classes_toWString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const toWString = <value>;

  Result := Ord(toWString);
end;

function Classes_scCommand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const scCommand = <value>;

  Result := scCommand;
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

function Classes_pidWin32_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidWin32 = <value>;

  Result := pidWin32;
end;

function Classes_pidWin64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidWin64 = <value>;

  Result := pidWin64;
end;

function Classes_pidOSX32_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidOSX32 = <value>;

  Result := pidOSX32;
end;

function Classes_pidiOSSimulator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidiOSSimulator = <value>;

  Result := pidiOSSimulator;
end;

function Classes_pidAndroid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidAndroid = <value>;

  Result := pidAndroid;
end;

function Classes_pidLinux32_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidLinux32 = <value>;

  Result := pidLinux32;
end;

function Classes_pidiOSDevice_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidiOSDevice = <value>;

  Result := pidiOSDevice;
end;

function Classes_pidiOSDevice32_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidiOSDevice32 = <value>;

  Result := pidiOSDevice32;
end;

function Classes_pidLinux64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidLinux64 = <value>;

  Result := pidLinux64;
end;

function Classes_pidWinNX32_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidWinNX32 = <value>;

  Result := pidWinNX32;
end;

function Classes_pidWinIoT32_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidWinIoT32 = <value>;

  Result := pidWinIoT32;
end;

function Classes_pidiOSDevice64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidiOSDevice64 = <value>;

  Result := pidiOSDevice64;
end;

function Classes_pidWinARM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pidWinARM = <value>;

  Result := pidWinARM;
end;

function Classes_dupIgnore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dupIgnore = <value>;

  Result := TDuplicates_sw.ToVar(dupIgnore);
end;

function Classes_dupAccept_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dupAccept = <value>;

  Result := TDuplicates_sw.ToVar(dupAccept);
end;

function Classes_dupError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const dupError = <value>;

  Result := TDuplicates_sw.ToVar(dupError);
end;

function Classes_TAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAlignment = (taLeftJustify, taRightJustify, taCenter);

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
  // type TBiDiMode = (bdLeftToRight, bdRightToLeft, bdRightTo...

  Result := TLMDUnitWrapper.TypeToVar(TBiDiMode_sw);
end;

function Classes_TVerticalAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVerticalAlignment = (taAlignTop, taAlignBottom, taV...

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
  // type THelpType = (htKeyword, htContext);

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
  // type EListError = System.SysUtils.EListError;

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
  // type TDuplicates = System.Types.TDuplicates;

  Result := TLMDUnitWrapper.TypeToVar(TDuplicates_sw);
end;

function Classes_TListNotification_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListNotification = (lnAdded, lnExtracted, lnDeleted);

  Result := TLMDUnitWrapper.TypeToVar(TListNotification_sw);
end;

function Classes_TListAssignOp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListAssignOp = (laCopy, laAnd, laOr, laXor, laSrcUn...

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
  // type TInterfaceList = class(TInterfacedObject);

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
  // type TInterfacedPersistent = class(TPersistent);

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
  // type TCollectionNotification = (cnAdded, cnExtracting, cn...

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

function Classes_TBytesStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBytesStream = class(TMemoryStream);

  Result := TLMDUnitWrapper.TypeToVar(TBytesStream_sw);
end;

function Classes_TStringStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStringStream = class(TBytesStream);

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
  // type TStreamOwnership = (soReference, soOwned);

  Result := TLMDUnitWrapper.TypeToVar(TStreamOwnership_sw);
end;

function Classes_TStreamAdapter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStreamAdapter = class(TInterfacedObject);

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
  // type TValueType = (vaNull, vaList, vaInt8, vaInt16, vaInt...

  Result := TLMDUnitWrapper.TypeToVar(TValueType_sw);
end;

function Classes_TFilerFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFilerFlag = (ffInherited, ffChildPos, ffInline);

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

function Classes_TFindMethodInstanceEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindMethodInstanceEvent = procedure (Reader: TReade...

  Result := TLMDUnitWrapper.TypeToVar(TFindMethodInstanceEvent_sw);
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

function Classes_TFindMethodNameEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindMethodNameEvent = procedure (Writer: TWriter; A...

  Result := TLMDUnitWrapper.TypeToVar(TFindMethodNameEvent_sw);
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

function Classes_EThreadExternalException_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EThreadExternalException = class(EThread);

  Result := TLMDUnitWrapper.TypeToVar(EThreadExternalException_sw);
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
  // type TThreadPriority = (tpIdle, tpLowest, tpLower, tpNorm...

  Result := TLMDUnitWrapper.TypeToVar(TThreadPriority_sw);
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
  // type TOperation = (opInsert, opRemove);

  Result := TLMDUnitWrapper.TypeToVar(TOperation_sw);
end;

function Classes_TGetChildProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetChildProc = procedure (Child: TComponent) of obj...

  Result := TLMDUnitWrapper.TypeToVar(TGetChildProc_sw);
end;

function Classes_TGetStreamProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetStreamProc = procedure (const S: TStream) of obj...

  Result := TLMDUnitWrapper.TypeToVar(TGetStreamProc_sw);
end;

function Classes_TGetDeltaStreamsEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetDeltaStreamsEvent = procedure (Sender: TObject; ...

  Result := TLMDUnitWrapper.TypeToVar(TGetDeltaStreamsEvent_sw);
end;

function Classes_TComponentName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComponentName = string;

  Result := TLMDUnitWrapper.TypeToVar(TComponentName_sw);
end;

function Classes_ComponentPlatformsAttribute_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ComponentPlatformsAttribute = class(TCustomAttribute);

  Result := TLMDUnitWrapper.TypeToVar(ComponentPlatformsAttribute_sw);
end;

function Classes_TObservers_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TObservers = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TObservers_sw);
end;

function Classes_TLinkObservers_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLinkObservers = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TLinkObservers_sw);
end;

function Classes_TObserverMapping_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TObserverMapping = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TObserverMapping_sw);
end;

function Classes_EObserverException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EObserverException = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EObserverException_sw);
end;

function Classes_TDefaultAttributeBase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDefaultAttributeBase = class(TCustomAttribute);

  Result := TLMDUnitWrapper.TypeToVar(TDefaultAttributeBase_sw);
end;

function Classes_DefaultAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type DefaultAttribute = class(TDefaultAttributeBase);

  Result := TLMDUnitWrapper.TypeToVar(DefaultAttribute_sw);
end;

function Classes_NoDefaultAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type NoDefaultAttribute = class(TDefaultAttributeBase);

  Result := TLMDUnitWrapper.TypeToVar(NoDefaultAttribute_sw);
end;

function Classes_ObservableMemberAttribute_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ObservableMemberAttribute = class(TCustomAttribute);

  Result := TLMDUnitWrapper.TypeToVar(ObservableMemberAttribute_sw);
end;

function Classes_TDesignInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDesignInfo = Int32;

  Result := TLMDUnitWrapper.TypeToVar(TDesignInfo_sw);
end;

function Classes_TBaseAsyncResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBaseAsyncResult = class(TInterfacedObject);

  Result := TLMDUnitWrapper.TypeToVar(TBaseAsyncResult_sw);
end;

function Classes_TComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TComponent = class(TPersistent);

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

function Classes_TActionEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionEvent = procedure (Action: TBasicAction; var ...

  Result := TLMDUnitWrapper.TypeToVar(TActionEvent_sw);
end;

function Classes_THintEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THintEvent = procedure (var HintStr: string; var Can...

  Result := TLMDUnitWrapper.TypeToVar(THintEvent_sw);
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

function Classes_CurrentGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CurrentGroup: Integer;

  if IsGet then
    Result := System.Classes.CurrentGroup
  else
    System.Classes.CurrentGroup := Integer(AArgs[0]);
end;

function Classes_TActiveXRegType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActiveXRegType = (axrComponentOnly, axrIncludeDesce...

  Result := TLMDUnitWrapper.TypeToVar(TActiveXRegType_sw);
end;

function Classes_Point_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Point(AX: Integer; AY: Integer): TPoint;

  Result := TPoint_sw.ToVar(System.Classes.Point(Integer(AArgs[0]), Integer(
    AArgs[1])));
end;

function Classes_SmallPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SmallPoint(AX: SmallInt; AY: SmallInt): TSmallPo...

  Result := TSmallPoint_sw.ToVar(System.Classes.SmallPoint(SmallInt(AArgs[0]), 
    SmallInt(AArgs[1])));
end;

function Classes_PointsEqual_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function PointsEqual(...); overload;

  Result := System.Classes.PointsEqual(TPoint_sw.FromVar(AArgs[0]), TPoint_sw.
    FromVar(AArgs[1]));
end;

function Classes_InvalidPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function InvalidPoint(...); overload;

  case AArgsSize of
    2:
    begin
      Result := System.Classes.InvalidPoint(Integer(AArgs[0]), Integer(
        AArgs[1]));
    end;
    1:
    begin
      Result := System.Classes.InvalidPoint(TPoint_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('InvalidPoint');
  end;
end;

function Classes_Rect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Rect(...); overload;

  case AArgsSize of
    4:
    begin
      Result := TRect_sw.ToVar(System.Classes.Rect(Integer(AArgs[0]), Integer(
        AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3])));
    end;
    2:
    begin
      Result := TRect_sw.ToVar(System.Classes.Rect(TPoint_sw.FromVar(AArgs[0]), 
        TPoint_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('Rect');
  end;
end;

function Classes_Bounds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Bounds(ALeft: Integer; ATop: Integer; AWidth: In...

  Result := TRect_sw.ToVar(System.Classes.Bounds(Integer(AArgs[0]), Integer(
    AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3])));
end;

function Classes_RegisterClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RegisterClass(AClass: TPersistentClass);

  System.Classes.RegisterClass(TPersistentClass_sw.FromVar(AArgs[0]));
end;

function Classes_RegisterClassAlias_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RegisterClassAlias(AClass: TPersistentClass; co...

  System.Classes.RegisterClassAlias(TPersistentClass_sw.FromVar(AArgs[0]), 
    string(AArgs[1]));
end;

function Classes_UnRegisterClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnRegisterClass(AClass: TPersistentClass);

  System.Classes.UnRegisterClass(TPersistentClass_sw.FromVar(AArgs[0]));
end;

function Classes_UnRegisterModuleClasses_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnRegisterModuleClasses(Module: HMODULE);

  System.Classes.UnRegisterModuleClasses(HMODULE_sw.FromVar(AArgs[0]));
end;

function Classes_FindClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindClass(const ClassName: string): TPersistentC...

  Result := TPersistentClass_sw.ToVar(System.Classes.FindClass(string(
    AArgs[0])));
end;

function Classes_GetClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetClass(const AClassName: string): TPersistentC...

  Result := TPersistentClass_sw.ToVar(System.Classes.GetClass(string(
    AArgs[0])));
end;

function Classes_StartClassGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure StartClassGroup(AClass: TPersistentClass);

  System.Classes.StartClassGroup(TPersistentClass_sw.FromVar(AArgs[0]));
end;

function Classes_GroupDescendentsWith_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GroupDescendentsWith(AClass: TPersistentClass; ...

  System.Classes.GroupDescendentsWith(TPersistentClass_sw.FromVar(AArgs[0]), 
    TPersistentClass_sw.FromVar(AArgs[1]));
end;

function Classes_ActivateClassGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ActivateClassGroup(AClass: TPersistentClass): TP...

  Result := TPersistentClass_sw.ToVar(System.Classes.ActivateClassGroup(
    TPersistentClass_sw.FromVar(AArgs[0])));
end;

function Classes_ActiveClassGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ActiveClassGroup: TPersistentClass;

  Result := TPersistentClass_sw.ToVar(System.Classes.ActiveClassGroup());
end;

function Classes_ClassGroupOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function ClassGroupOf(...); overload;

  Result := TPersistentClass_sw.ToVar(System.Classes.ClassGroupOf(
    TPersistentClass_sw.FromVar(AArgs[0])));
end;

function Classes_ReportClassGroups_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ReportClassGroups(Report: TStrings);

  System.Classes.ReportClassGroups(TStrings_sw.FromVar(AArgs[0]));
end;

function Classes_TIdentMapEntry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIdentMapEntry = record;

  Result := TLMDUnitWrapper.TypeToVar(TIdentMapEntry_sw);
end;

function Classes_FindGlobalComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindGlobalComponent(const Name: string): TCompon...

  Result := TComponent_sw.ToVar(System.Classes.FindGlobalComponent(string(
    AArgs[0])));
end;

function Classes_IsUniqueGlobalComponentName_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsUniqueGlobalComponentName(const Name: string):...

  Result := System.Classes.IsUniqueGlobalComponentName(string(AArgs[0]));
end;

function Classes_InitInheritedComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function InitInheritedComponent(Instance: TComponent; Roo...

  Result := System.Classes.InitInheritedComponent(TComponent_sw.FromVar(
    AArgs[0]), TClass_sw.FromVar(AArgs[1]));
end;

function Classes_InitComponentRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function InitComponentRes(const ResName: string; Instance...

  Result := System.Classes.InitComponentRes(string(AArgs[0]), TComponent_sw.
    FromVar(AArgs[1]));
end;

function Classes_ReadComponentRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadComponentRes(const ResName: string; Instance...

  Result := TComponent_sw.ToVar(System.Classes.ReadComponentRes(string(
    AArgs[0]), TComponent_sw.FromVar(AArgs[1])));
end;

function Classes_ReadComponentResEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadComponentResEx(HInstance: THandle; const Res...

  Result := TComponent_sw.ToVar(System.Classes.ReadComponentResEx(THandle_sw.
    FromVar(AArgs[0]), string(AArgs[1])));
end;

function Classes_ReadComponentResFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReadComponentResFile(const FileName: string; con...

  Result := TComponent_sw.ToVar(System.Classes.ReadComponentResFile(string(
    AArgs[0]), TComponent_sw.FromVar(AArgs[1])));
end;

function Classes_WriteComponentResFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteComponentResFile(const FileName: string; c...

  System.Classes.WriteComponentResFile(string(AArgs[0]), TComponent_sw.FromVar(
    AArgs[1]));
end;

function Classes_GlobalFixupReferences_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GlobalFixupReferences;

  System.Classes.GlobalFixupReferences();
end;

function Classes_GetFixupReferenceNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetFixupReferenceNames(const Root: TComponent; ...

  System.Classes.GetFixupReferenceNames(TComponent_sw.FromVar(AArgs[0]), 
    TStrings_sw.FromVar(AArgs[1]));
end;

function Classes_GetFixupInstanceNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetFixupInstanceNames(const Root: TComponent; c...

  System.Classes.GetFixupInstanceNames(TComponent_sw.FromVar(AArgs[0]), string(
    AArgs[1]), TStrings_sw.FromVar(AArgs[2]));
end;

function Classes_RedirectFixupReferences_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RedirectFixupReferences(const Root: TComponent;...

  System.Classes.RedirectFixupReferences(TComponent_sw.FromVar(AArgs[0]), 
    string(AArgs[1]), string(AArgs[2]));
end;

function Classes_RemoveFixupReferences_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RemoveFixupReferences(const Root: TComponent; c...

  System.Classes.RemoveFixupReferences(TComponent_sw.FromVar(AArgs[0]), string(
    AArgs[1]));
end;

function Classes_RemoveFixups_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RemoveFixups(const Instance: TPersistent);

  System.Classes.RemoveFixups(TPersistent_sw.FromVar(AArgs[0]));
end;

function Classes_FindNestedComponent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindNestedComponent(const Root: TComponent; cons...

  Result := TComponent_sw.ToVar(System.Classes.FindNestedComponent(
    TComponent_sw.FromVar(AArgs[0]), string(AArgs[1])));
end;

function Classes_BeginGlobalLoading_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginGlobalLoading;

  System.Classes.BeginGlobalLoading();
end;

function Classes_NotifyGlobalLoading_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure NotifyGlobalLoading;

  System.Classes.NotifyGlobalLoading();
end;

function Classes_EndGlobalLoading_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndGlobalLoading;

  System.Classes.EndGlobalLoading();
end;

function Classes_CollectionsEqual_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CollectionsEqual(const C1: TCollection; const C2...

  Result := System.Classes.CollectionsEqual(TCollection_sw.FromVar(AArgs[0]), 
    TCollection_sw.FromVar(AArgs[1]), TComponent_sw.FromVar(AArgs[2]),
    TComponent_sw.FromVar(AArgs[3]));
end;

function Classes_GetUltimateOwner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function GetUltimateOwner(...); overload;

  Result := TPersistent_sw.ToVar(System.Classes.GetUltimateOwner(TPersistent_sw.
    FromVar(AArgs[0])));
end;

function Classes_TStreamOriginalFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStreamOriginalFormat = (sofUnknown, sofBinary, sofT...

  Result := TLMDUnitWrapper.TypeToVar(TStreamOriginalFormat_sw);
end;

function Classes_ObjectBinaryToText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TStreamOriginalFormat;
begin
  // procedure/function ObjectBinaryToText(...); overload;

  case AArgsSize of
    2:
    begin
      System.Classes.ObjectBinaryToText(TStream_sw.FromVar(AArgs[0]), 
        TStream_sw.FromVar(AArgs[1]));
    end;
    3:
    begin
      v_1 := TStreamOriginalFormat_sw.FromVar(AArgs[2]);
      System.Classes.ObjectBinaryToText(TStream_sw.FromVar(AArgs[0]), 
        TStream_sw.FromVar(AArgs[1]), v_1);
      AssignRefParam(AArgs[2], TStreamOriginalFormat_sw.ToVar(v_1));
    end;
  else
    WrongArgCountError('ObjectBinaryToText');
  end;
end;

function Classes_ObjectTextToBinary_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TStreamOriginalFormat;
begin
  // procedure/function ObjectTextToBinary(...); overload;

  case AArgsSize of
    2:
    begin
      System.Classes.ObjectTextToBinary(TStream_sw.FromVar(AArgs[0]), 
        TStream_sw.FromVar(AArgs[1]));
    end;
    3:
    begin
      v_1 := TStreamOriginalFormat_sw.FromVar(AArgs[2]);
      System.Classes.ObjectTextToBinary(TStream_sw.FromVar(AArgs[0]), 
        TStream_sw.FromVar(AArgs[1]), v_1);
      AssignRefParam(AArgs[2], TStreamOriginalFormat_sw.ToVar(v_1));
    end;
  else
    WrongArgCountError('ObjectTextToBinary');
  end;
end;

function Classes_ObjectResourceToText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TStreamOriginalFormat;
begin
  // procedure/function ObjectResourceToText(...); overload;

  case AArgsSize of
    2:
    begin
      System.Classes.ObjectResourceToText(TStream_sw.FromVar(AArgs[0]), 
        TStream_sw.FromVar(AArgs[1]));
    end;
    3:
    begin
      v_1 := TStreamOriginalFormat_sw.FromVar(AArgs[2]);
      System.Classes.ObjectResourceToText(TStream_sw.FromVar(AArgs[0]), 
        TStream_sw.FromVar(AArgs[1]), v_1);
      AssignRefParam(AArgs[2], TStreamOriginalFormat_sw.ToVar(v_1));
    end;
  else
    WrongArgCountError('ObjectResourceToText');
  end;
end;

function Classes_ObjectTextToResource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TStreamOriginalFormat;
begin
  // procedure/function ObjectTextToResource(...); overload;

  case AArgsSize of
    3:
    begin
      v_1 := TStreamOriginalFormat_sw.FromVar(AArgs[2]);
      System.Classes.ObjectTextToResource(TStream_sw.FromVar(AArgs[0]), 
        TStream_sw.FromVar(AArgs[1]), v_1);
      AssignRefParam(AArgs[2], TStreamOriginalFormat_sw.ToVar(v_1));
    end;
    4:
    begin
      v_1 := TStreamOriginalFormat_sw.FromVar(AArgs[2]);
      System.Classes.ObjectTextToResource(TStream_sw.FromVar(AArgs[0]), 
        TStream_sw.FromVar(AArgs[1]), v_1, string(AArgs[3]));
      AssignRefParam(AArgs[2], TStreamOriginalFormat_sw.ToVar(v_1));
    end;
  else
    WrongArgCountError('ObjectTextToResource');
  end;
end;

function Classes_TestStreamFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function TestStreamFormat(const Stream: TStream): TStream...

  Result := TStreamOriginalFormat_sw.ToVar(System.Classes.TestStreamFormat(
    TStream_sw.FromVar(AArgs[0])));
end;

function Classes_GetResourceName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // function GetResourceName(const ObjStream: TStream; var AN...

  v_1 := string(AArgs[1]);
  Result := System.Classes.GetResourceName(TStream_sw.FromVar(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function Classes_WriteObjectResourceHeader_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure WriteObjectResourceHeader(const ObjStream: TStr...

  case AArgsSize of
    2:
    begin
      System.Classes.WriteObjectResourceHeader(TStream_sw.FromVar(AArgs[0]), 
        TStream_sw.FromVar(AArgs[1]));
    end;
    3:
    begin
      System.Classes.WriteObjectResourceHeader(TStream_sw.FromVar(AArgs[0]), 
        TStream_sw.FromVar(AArgs[1]), string(AArgs[2]));
    end;
  else
    WrongArgCountError('WriteObjectResourceHeader');
  end;
end;

function Classes_CountGenerations_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CountGenerations(Ancestor: TClass; Descendent: T...

  Result := System.Classes.CountGenerations(TClass_sw.FromVar(AArgs[0]), 
    TClass_sw.FromVar(AArgs[1]));
end;

function Classes_CheckSynchronize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CheckSynchronize(Timeout: Integer): Boolean;

  case AArgsSize of
    0:
    begin
      Result := System.Classes.CheckSynchronize();
    end;
    1:
    begin
      Result := System.Classes.CheckSynchronize(Integer(AArgs[0]));
    end;
  else
    WrongArgCountError('CheckSynchronize');
  end;
end;

function Classes_WakeMainThread_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var WakeMainThread: TNotifyEvent;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(System.Classes.WakeMainThread)
  else
    System.Classes.WakeMainThread := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function Classes_SyncEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SyncEvent: THandle;

  if IsGet then
    Result := THandle_sw.ToVar(System.Classes.SyncEvent)
  else
    System.Classes.SyncEvent := THandle_sw.FromVar(AArgs[0]);
end;

function Classes_TWndMethod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWndMethod = procedure (var Message: TMessage) of ob...

  Result := TLMDUnitWrapper.TypeToVar(TWndMethod_sw);
end;

function Classes_TTextReader_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTextReader = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TTextReader_sw);
end;

function Classes_TTextWriter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTextWriter = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TTextWriter_sw);
end;

function Classes_TBinaryReader_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBinaryReader = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TBinaryReader_sw);
end;

function Classes_TBinaryWriter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBinaryWriter = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TBinaryWriter_sw);
end;

function Classes_TStringReader_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStringReader = class(TTextReader);

  Result := TLMDUnitWrapper.TypeToVar(TStringReader_sw);
end;

function Classes_TStringWriter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStringWriter = class(TTextWriter);

  Result := TLMDUnitWrapper.TypeToVar(TStringWriter_sw);
end;

function Classes_TStreamWriter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStreamWriter = class(TTextWriter);

  Result := TLMDUnitWrapper.TypeToVar(TStreamWriter_sw);
end;

function Classes_TStreamReader_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStreamReader = class(TTextReader);

  Result := TLMDUnitWrapper.TypeToVar(TStreamReader_sw);
end;

function Classes_ELoginCredentialError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ELoginCredentialError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(ELoginCredentialError_sw);
end;

function Classes_TLoginCredentialService_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLoginCredentialService = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TLoginCredentialService_sw);
end;

function Classes_AllocateHWnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AllocateHWnd(const AMethod: TWndMethod): HWND;

  Result := HWND_sw.ToVar(System.Classes.AllocateHWnd(TWndMethod_sw.FromVar(
    AArgs[0])));
end;

function Classes_DeallocateHWnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DeallocateHWnd(Wnd: HWND);

  System.Classes.DeallocateHWnd(HWND_sw.FromVar(AArgs[0]));
end;

function Classes_AncestorIsValid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AncestorIsValid(const Ancestor: TPersistent; con...

  Result := System.Classes.AncestorIsValid(TPersistent_sw.FromVar(AArgs[0]), 
    TComponent_sw.FromVar(AArgs[1]), TComponent_sw.FromVar(AArgs[2]));
end;

class function Classes_sw.GetUnitName: WideString;
begin
  Result := 'Classes';
end;

class procedure Classes_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('MaxListSize', Classes_MaxListSize_si, nil, VarType(System.Classes.MaxListSize));
  AData.AddConstant('soFromBeginning', Classes_soFromBeginning_si, nil, VarType(System.Classes.soFromBeginning));
  AData.AddConstant('soFromCurrent', Classes_soFromCurrent_si, nil, VarType(System.Classes.soFromCurrent));
  AData.AddConstant('soFromEnd', Classes_soFromEnd_si, nil, VarType(System.Classes.soFromEnd));
  AData.AddType(TSeekOrigin_sw, Classes_TSeekOrigin_si);
  AData.AddType(TPlatformIds_sw, Classes_TPlatformIds_si);
  AData.AddConstant('fmCreate', Classes_fmCreate_si, nil, VarType(System.Classes.fmCreate));
  AData.AddConstant('toEOF', Classes_toEOF_si, Char_sw);
  AData.AddConstant('toSymbol', Classes_toSymbol_si, Char_sw);
  AData.AddConstant('toString', Classes_toString_si, Char_sw);
  AData.AddConstant('toInteger', Classes_toInteger_si, Char_sw);
  AData.AddConstant('toFloat', Classes_toFloat_si, Char_sw);
  AData.AddConstant('toWString', Classes_toWString_si, Char_sw);
  AData.AddConstant('scCommand', Classes_scCommand_si, nil, VarType(System.Classes.scCommand));
  AData.AddConstant('scShift', Classes_scShift_si, nil, VarType(System.Classes.scShift));
  AData.AddConstant('scCtrl', Classes_scCtrl_si, nil, VarType(System.Classes.scCtrl));
  AData.AddConstant('scAlt', Classes_scAlt_si, nil, VarType(System.Classes.scAlt));
  AData.AddConstant('scNone', Classes_scNone_si, nil, VarType(System.Classes.scNone));
  AData.AddConstant('pidWin32', Classes_pidWin32_si, nil, VarType(System.Classes.pidWin32));
  AData.AddConstant('pidWin64', Classes_pidWin64_si, nil, VarType(System.Classes.pidWin64));
  AData.AddConstant('pidOSX32', Classes_pidOSX32_si, nil, VarType(System.Classes.pidOSX32));
  AData.AddConstant('pidiOSSimulator', Classes_pidiOSSimulator_si, nil, VarType(System.Classes.pidiOSSimulator));
  AData.AddConstant('pidAndroid', Classes_pidAndroid_si, nil, VarType(System.Classes.pidAndroid));
  AData.AddConstant('pidLinux32', Classes_pidLinux32_si, nil, VarType(System.Classes.pidLinux32));
  AData.AddConstant('pidiOSDevice', Classes_pidiOSDevice_si, nil, VarType(System.Classes.pidiOSDevice));
  AData.AddConstant('pidiOSDevice32', Classes_pidiOSDevice32_si, Integer_sw);
  AData.AddConstant('pidLinux64', Classes_pidLinux64_si, nil, VarType(System.Classes.pidLinux64));
  AData.AddConstant('pidWinNX32', Classes_pidWinNX32_si, nil, VarType(System.Classes.pidWinNX32));
  AData.AddConstant('pidWinIoT32', Classes_pidWinIoT32_si, nil, VarType(System.Classes.pidWinIoT32));
  AData.AddConstant('pidiOSDevice64', Classes_pidiOSDevice64_si, nil, VarType(System.Classes.pidiOSDevice64));
  AData.AddConstant('pidWinARM', Classes_pidWinARM_si, nil, VarType(System.Classes.pidWinARM));
  AData.AddConstant('dupIgnore', Classes_dupIgnore_si, TDuplicates_sw);
  AData.AddConstant('dupAccept', Classes_dupAccept_si, TDuplicates_sw);
  AData.AddConstant('dupError', Classes_dupError_si, TDuplicates_sw);
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
  AData.AddType(TBytesStream_sw, Classes_TBytesStream_si);
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
  AData.AddType(TFindMethodInstanceEvent_sw, Classes_TFindMethodInstanceEvent_si);
  AData.AddType(TReader_sw, Classes_TReader_si);
  AData.AddType(TFindAncestorEvent_sw, Classes_TFindAncestorEvent_si);
  AData.AddType(TFindMethodNameEvent_sw, Classes_TFindMethodNameEvent_si);
  AData.AddType(TGetLookupInfoEvent_sw, Classes_TGetLookupInfoEvent_si);
  AData.AddType(TWriter_sw, Classes_TWriter_si);
  AData.AddType(TParserErrorEvent_sw, Classes_TParserErrorEvent_si);
  AData.AddType(TParser_sw, Classes_TParser_si);
  AData.AddType(EThread_sw, Classes_EThread_si);
  AData.AddType(EThreadExternalException_sw, Classes_EThreadExternalException_si);
  AData.AddType(TThreadMethod_sw, Classes_TThreadMethod_si);
  AData.AddType(TThreadPriority_sw, Classes_TThreadPriority_si);
  AData.AddType(TThread_sw, Classes_TThread_si);
  AData.AddType(TComponentEnumerator_sw, Classes_TComponentEnumerator_si);
  AData.AddType(TOperation_sw, Classes_TOperation_si);
  AData.AddType(TGetChildProc_sw, Classes_TGetChildProc_si);
  AData.AddType(TGetStreamProc_sw, Classes_TGetStreamProc_si);
  AData.AddType(TGetDeltaStreamsEvent_sw, Classes_TGetDeltaStreamsEvent_si);
  AData.AddType(TComponentName_sw, Classes_TComponentName_si);
  AData.AddType(ComponentPlatformsAttribute_sw, Classes_ComponentPlatformsAttribute_si);
  AData.AddType(TObservers_sw, Classes_TObservers_si);
  AData.AddType(TLinkObservers_sw, Classes_TLinkObservers_si);
  AData.AddType(TObserverMapping_sw, Classes_TObserverMapping_si);
  AData.AddType(EObserverException_sw, Classes_EObserverException_si);
  AData.AddType(TDefaultAttributeBase_sw, Classes_TDefaultAttributeBase_si);
  AData.AddType(DefaultAttribute_sw, Classes_DefaultAttribute_si);
  AData.AddType(NoDefaultAttribute_sw, Classes_NoDefaultAttribute_si);
  AData.AddType(ObservableMemberAttribute_sw, Classes_ObservableMemberAttribute_si);
  AData.AddType(TDesignInfo_sw, Classes_TDesignInfo_si);
  AData.AddType(TBaseAsyncResult_sw, Classes_TBaseAsyncResult_si);
  AData.AddType(TComponent_sw, Classes_TComponent_si);
  AData.AddType(TBasicActionLink_sw, Classes_TBasicActionLink_si);
  AData.AddType(TBasicActionLinkClass_sw, Classes_TBasicActionLinkClass_si);
  AData.AddType(TActionEvent_sw, Classes_TActionEvent_si);
  AData.AddType(THintEvent_sw, Classes_THintEvent_si);
  AData.AddType(TBasicAction_sw, Classes_TBasicAction_si);
  AData.AddType(TBasicActionClass_sw, Classes_TBasicActionClass_si);
  AData.AddType(TDataModule_sw, Classes_TDataModule_si);
  AData.AddVariable('CurrentGroup', Classes_CurrentGroup_si, Integer_sw);
  AData.AddType(TActiveXRegType_sw, Classes_TActiveXRegType_si);
  AData.AddFunction('Point', Classes_Point_si, TPoint_sw, 2, False);
  AData.AddFunction('SmallPoint', Classes_SmallPoint_si, TSmallPoint_sw, 2, False);
  AData.AddFunction('PointsEqual', Classes_PointsEqual_si, nil, 2, False);
  AData.AddFunction('InvalidPoint', Classes_InvalidPoint_si, nil, 1, True);
  AData.AddFunction('Rect', Classes_Rect_si, nil, 2, True);
  AData.AddFunction('Bounds', Classes_Bounds_si, TRect_sw, 4, False);
  AData.AddProcedure('RegisterClass', Classes_RegisterClass_si, 1, False);
  AData.AddProcedure('RegisterClassAlias', Classes_RegisterClassAlias_si, 2, False);
  AData.AddProcedure('UnRegisterClass', Classes_UnRegisterClass_si, 1, False);
  AData.AddProcedure('UnRegisterModuleClasses', Classes_UnRegisterModuleClasses_si, 1, False);
  AData.AddFunction('FindClass', Classes_FindClass_si, TPersistentClass_sw, 1, False);
  AData.AddFunction('GetClass', Classes_GetClass_si, TPersistentClass_sw, 1, False);
  AData.AddProcedure('StartClassGroup', Classes_StartClassGroup_si, 1, False);
  AData.AddProcedure('GroupDescendentsWith', Classes_GroupDescendentsWith_si, 2, False);
  AData.AddFunction('ActivateClassGroup', Classes_ActivateClassGroup_si, TPersistentClass_sw, 1, False);
  AData.AddFunction('ActiveClassGroup', Classes_ActiveClassGroup_si, TPersistentClass_sw, 0, False);
  AData.AddFunction('ClassGroupOf', Classes_ClassGroupOf_si, nil, 1, False);
  AData.AddProcedure('ReportClassGroups', Classes_ReportClassGroups_si, 1, False);
  AData.AddType(TIdentMapEntry_sw, Classes_TIdentMapEntry_si);
  AData.AddFunction('FindGlobalComponent', Classes_FindGlobalComponent_si, TComponent_sw, 1, False);
  AData.AddFunction('IsUniqueGlobalComponentName', Classes_IsUniqueGlobalComponentName_si, Boolean_sw, 1, False);
  AData.AddFunction('InitInheritedComponent', Classes_InitInheritedComponent_si, Boolean_sw, 2, False);
  AData.AddFunction('InitComponentRes', Classes_InitComponentRes_si, Boolean_sw, 2, False);
  AData.AddFunction('ReadComponentRes', Classes_ReadComponentRes_si, TComponent_sw, 2, False);
  AData.AddFunction('ReadComponentResEx', Classes_ReadComponentResEx_si, TComponent_sw, 2, False);
  AData.AddFunction('ReadComponentResFile', Classes_ReadComponentResFile_si, TComponent_sw, 2, False);
  AData.AddProcedure('WriteComponentResFile', Classes_WriteComponentResFile_si, 2, False);
  AData.AddProcedure('GlobalFixupReferences', Classes_GlobalFixupReferences_si, 0, False);
  AData.AddProcedure('GetFixupReferenceNames', Classes_GetFixupReferenceNames_si, 2, False);
  AData.AddProcedure('GetFixupInstanceNames', Classes_GetFixupInstanceNames_si, 3, False);
  AData.AddProcedure('RedirectFixupReferences', Classes_RedirectFixupReferences_si, 3, False);
  AData.AddProcedure('RemoveFixupReferences', Classes_RemoveFixupReferences_si, 2, False);
  AData.AddProcedure('RemoveFixups', Classes_RemoveFixups_si, 1, False);
  AData.AddFunction('FindNestedComponent', Classes_FindNestedComponent_si, TComponent_sw, 2, False);
  AData.AddProcedure('BeginGlobalLoading', Classes_BeginGlobalLoading_si, 0, False);
  AData.AddProcedure('NotifyGlobalLoading', Classes_NotifyGlobalLoading_si, 0, False);
  AData.AddProcedure('EndGlobalLoading', Classes_EndGlobalLoading_si, 0, False);
  AData.AddFunction('CollectionsEqual', Classes_CollectionsEqual_si, Boolean_sw, 4, False);
  AData.AddFunction('GetUltimateOwner', Classes_GetUltimateOwner_si, nil, 1, False);
  AData.AddType(TStreamOriginalFormat_sw, Classes_TStreamOriginalFormat_si);
  AData.AddProcedure('ObjectBinaryToText', Classes_ObjectBinaryToText_si, 2, True);
  AData.AddProcedure('ObjectTextToBinary', Classes_ObjectTextToBinary_si, 2, True);
  AData.AddProcedure('ObjectResourceToText', Classes_ObjectResourceToText_si, 2, True);
  AData.AddProcedure('ObjectTextToResource', Classes_ObjectTextToResource_si, 3, True);
  AData.AddFunction('TestStreamFormat', Classes_TestStreamFormat_si, TStreamOriginalFormat_sw, 1, False);
  AData.AddFunction('GetResourceName', Classes_GetResourceName_si, Boolean_sw, 2, False);
  AData.AddProcedure('WriteObjectResourceHeader', Classes_WriteObjectResourceHeader_si, 2, True);
  AData.AddFunction('CountGenerations', Classes_CountGenerations_si, Integer_sw, 2, False);
  AData.AddFunction('CheckSynchronize', Classes_CheckSynchronize_si, Boolean_sw, 0, True);
  AData.AddVariable('WakeMainThread', Classes_WakeMainThread_si, TNotifyEvent_sw);
  AData.AddVariable('SyncEvent', Classes_SyncEvent_si, THandle_sw);
  AData.AddType(TWndMethod_sw, Classes_TWndMethod_si);
  AData.AddType(TTextReader_sw, Classes_TTextReader_si);
  AData.AddType(TTextWriter_sw, Classes_TTextWriter_si);
  AData.AddType(TBinaryReader_sw, Classes_TBinaryReader_si);
  AData.AddType(TBinaryWriter_sw, Classes_TBinaryWriter_si);
  AData.AddType(TStringReader_sw, Classes_TStringReader_si);
  AData.AddType(TStringWriter_sw, Classes_TStringWriter_si);
  AData.AddType(TStreamWriter_sw, Classes_TStreamWriter_si);
  AData.AddType(TStreamReader_sw, Classes_TStreamReader_si);
  AData.AddType(ELoginCredentialError_sw, Classes_ELoginCredentialError_si);
  AData.AddType(TLoginCredentialService_sw, Classes_TLoginCredentialService_si);
  AData.AddFunction('AllocateHWnd', Classes_AllocateHWnd_si, HWND_sw, 1, False);
  AData.AddProcedure('DeallocateHWnd', Classes_DeallocateHWnd_si, 1, False);
  AData.AddFunction('AncestorIsValid', Classes_AncestorIsValid_si, Boolean_sw, 3, False);
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
  RegisterClassWrapper(TBytesStream_sw);
  RegisterClassWrapper(TStringStream_sw);
  RegisterClassWrapper(TResourceStream_sw);
  RegisterClassWrapper(TStreamAdapter_sw);
  RegisterClassWrapper(TClassFinder_sw);
  RegisterClassWrapper(TFiler_sw);
  RegisterClassWrapper(TReader_sw);
  RegisterClassWrapper(TWriter_sw);
  RegisterClassWrapper(TParser_sw);
  RegisterClassWrapper(EThread_sw);
  RegisterClassWrapper(EThreadExternalException_sw);
  RegisterClassWrapper(TThread_sw);
  RegisterClassWrapper(TComponentEnumerator_sw);
  RegisterClassWrapper(ComponentPlatformsAttribute_sw);
  RegisterClassWrapper(TObservers_sw);
  RegisterClassWrapper(TLinkObservers_sw);
  RegisterClassWrapper(TObserverMapping_sw);
  RegisterClassWrapper(EObserverException_sw);
  RegisterClassWrapper(TDefaultAttributeBase_sw);
  RegisterClassWrapper(DefaultAttribute_sw);
  RegisterClassWrapper(NoDefaultAttribute_sw);
  RegisterClassWrapper(ObservableMemberAttribute_sw);
  RegisterClassWrapper(TBaseAsyncResult_sw);
  RegisterClassWrapper(TComponent_sw);
  RegisterClassWrapper(TBasicActionLink_sw);
  RegisterClassWrapper(TBasicAction_sw);
  RegisterClassWrapper(TDataModule_sw);
  RegisterClassWrapper(TTextReader_sw);
  RegisterClassWrapper(TTextWriter_sw);
  RegisterClassWrapper(TBinaryReader_sw);
  RegisterClassWrapper(TBinaryWriter_sw);
  RegisterClassWrapper(TStringReader_sw);
  RegisterClassWrapper(TStringWriter_sw);
  RegisterClassWrapper(TStreamWriter_sw);
  RegisterClassWrapper(TStreamReader_sw);
  RegisterClassWrapper(ELoginCredentialError_sw);
  RegisterClassWrapper(TLoginCredentialService_sw);
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
  RegisterEventWrapper(TypeInfo(TFindMethodInstanceEvent), TFindMethodInstanceEvent_sw);
  RegisterEventWrapper(TypeInfo(TFindAncestorEvent), TFindAncestorEvent_sw);
  RegisterEventWrapper(TypeInfo(TFindMethodNameEvent), TFindMethodNameEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetLookupInfoEvent), TGetLookupInfoEvent_sw);
  RegisterEventWrapper(TypeInfo(TParserErrorEvent), TParserErrorEvent_sw);
  RegisterEventWrapper(TypeInfo(TThreadMethod), TThreadMethod_sw);
  RegisterEventWrapper(TypeInfo(TGetChildProc), TGetChildProc_sw);
  RegisterEventWrapper(TypeInfo(TGetStreamProc), TGetStreamProc_sw);
  RegisterEventWrapper(TypeInfo(TGetDeltaStreamsEvent), TGetDeltaStreamsEvent_sw);
  RegisterEventWrapper(TypeInfo(TActionEvent), TActionEvent_sw);
  RegisterEventWrapper(TypeInfo(THintEvent), THintEvent_sw);
  RegisterEventWrapper(TypeInfo(TWndMethod), TWndMethod_sw);

end.
