unit ADODB_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'ADODB' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers, Windows,
  Variants, SysUtils, Classes, TypInfo, DB, ADODB, Windows_LMDSW,
  Variants_LMDSW, SysUtils_LMDSW, Classes_LMDSW, TypInfo_LMDSW, DB_LMDSW;


{ Type wrappers }

type
  EADOError_sw = class;
  TADOConnection_sw = class;
  TRDSConnection_sw = class;
  TParameter_sw = class;
  TParameters_sw = class;
  TADOCommand_sw = class;
  TCustomADODataSet_sw = class;
  TADODataSet_sw = class;
  TADOTable_sw = class;
  TADOQuery_sw = class;
  TADOStoredProc_sw = class;
  TADOBlobStream_sw = class;

  EADOError_sc = class of EADOError;
  EADOError_sw = class(EDatabaseError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EADOError): OleVariant;
    class function FromVar(const AValue: OleVariant): EADOError;
    class function ClassToVar(AClass: EADOError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EADOError_sc;
  end;

  TConnectMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TConnectMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TConnectMode;
  end;

  TConnectOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TConnectOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TConnectOption;
  end;

  TCursorLocation_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCursorLocation): OleVariant;
    class function FromVar(const AValue: OleVariant): TCursorLocation;
  end;

  TCursorType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCursorType): OleVariant;
    class function FromVar(const AValue: OleVariant): TCursorType;
  end;

  TEventStatus_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TEventStatus): OleVariant;
    class function FromVar(const AValue: OleVariant): TEventStatus;
  end;

  TExecuteOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TExecuteOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TExecuteOption;
  end;

  TExecuteOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TExecuteOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TExecuteOptions;
  end;

  TIsolationLevel_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TIsolationLevel): OleVariant;
    class function FromVar(const AValue: OleVariant): TIsolationLevel;
  end;

  TADOLockType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TADOLockType): OleVariant;
    class function FromVar(const AValue: OleVariant): TADOLockType;
  end;

  TObjectState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TObjectState): OleVariant;
    class function FromVar(const AValue: OleVariant): TObjectState;
  end;

  TObjectStates_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TObjectStates): OleVariant;
    class function FromVar(const AValue: OleVariant): TObjectStates;
  end;

  TSchemaInfo_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TSchemaInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TSchemaInfo;
  end;

  TXactAttribute_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TXactAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): TXactAttribute;
  end;

  TXactAttributes_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TXactAttributes): OleVariant;
    class function FromVar(const AValue: OleVariant): TXactAttributes;
  end;

  TCommandType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCommandType): OleVariant;
    class function FromVar(const AValue: OleVariant): TCommandType;
  end;

  TDisconnectEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Connection: TADOConnection;
      var EventStatus: TEventStatus);
  end;

  TDisconnectEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDisconnectEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDisconnectEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDisconnectEvent;
  end;

  TWillConnectEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Connection: TADOConnection;
      var ConnectionString: WideString; var UserID: WideString;
      var Password: WideString; var ConnectOptions: TConnectOption;
      var EventStatus: TEventStatus);
  end;

  TWillConnectEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TWillConnectEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TWillConnectEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TWillConnectEvent;
  end;

  TADOConnection_sc = class of TADOConnection;
  TADOConnection_sw = class(TCustomConnection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TADOConnection): OleVariant;
    class function FromVar(const AValue: OleVariant): TADOConnection;
    class function ClassToVar(AClass: TADOConnection_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TADOConnection_sc;
  end;

  TRDSConnection_sc = class of TRDSConnection;
  TRDSConnection_sw = class(TCustomConnection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TRDSConnection): OleVariant;
    class function FromVar(const AValue: OleVariant): TRDSConnection;
    class function ClassToVar(AClass: TRDSConnection_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TRDSConnection_sc;
  end;

  TDataType_sw = TFieldType_sw;

  TParameterAttribute_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TParameterAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): TParameterAttribute;
  end;

  TParameterAttributes_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TParameterAttributes): OleVariant;
    class function FromVar(const AValue: OleVariant): TParameterAttributes;
  end;

  TParameterDirection_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TParameterDirection): OleVariant;
    class function FromVar(const AValue: OleVariant): TParameterDirection;
  end;

  TParameter_sc = class of TParameter;
  TParameter_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TParameter): OleVariant;
    class function FromVar(const AValue: OleVariant): TParameter;
    class function ClassToVar(AClass: TParameter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TParameter_sc;
  end;

  TParameters_sc = class of TParameters;
  TParameters_sw = class(TOwnedCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TParameters): OleVariant;
    class function FromVar(const AValue: OleVariant): TParameters;
    class function ClassToVar(AClass: TParameters_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TParameters_sc;
  end;

  TADOCommand_sc = class of TADOCommand;
  TADOCommand_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TADOCommand): OleVariant;
    class function FromVar(const AValue: OleVariant): TADOCommand;
    class function ClassToVar(AClass: TADOCommand_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TADOCommand_sc;
  end;

  TCursorOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCursorOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TCursorOption;
  end;

  TCursorOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TCursorOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TCursorOptions;
  end;

  TEventReason_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TEventReason): OleVariant;
    class function FromVar(const AValue: OleVariant): TEventReason;
  end;

  TFilterGroup_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFilterGroup): OleVariant;
    class function FromVar(const AValue: OleVariant): TFilterGroup;
  end;

  TMarshalOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMarshalOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TMarshalOption;
  end;

  TRecordStatus_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TRecordStatus): OleVariant;
    class function FromVar(const AValue: OleVariant): TRecordStatus;
  end;

  TRecordStatusSet_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TRecordStatusSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TRecordStatusSet;
  end;

  TAffectRecords_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TAffectRecords): OleVariant;
    class function FromVar(const AValue: OleVariant): TAffectRecords;
  end;

  TPersistFormat_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPersistFormat): OleVariant;
    class function FromVar(const AValue: OleVariant): TPersistFormat;
  end;

  TSeekOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TSeekOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TSeekOption;
  end;

  TWillChangeFieldEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DataSet: TCustomADODataSet; const FieldCount: Integer;
      const Fields: OleVariant; var EventStatus: TEventStatus);
  end;

  TWillChangeFieldEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TWillChangeFieldEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TWillChangeFieldEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TWillChangeFieldEvent;
  end;

  TWillChangeRecordEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DataSet: TCustomADODataSet; const Reason: TEventReason;
      const RecordCount: Integer; var EventStatus: TEventStatus);
  end;

  TWillChangeRecordEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TWillChangeRecordEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TWillChangeRecordEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TWillChangeRecordEvent;
  end;

  TEndOfRecordsetEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DataSet: TCustomADODataSet; var MoreData: WordBool;
      var EventStatus: TEventStatus);
  end;

  TEndOfRecordsetEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TEndOfRecordsetEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TEndOfRecordsetEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TEndOfRecordsetEvent;
  end;

  TFetchProgressEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DataSet: TCustomADODataSet; Progress: Integer;
      MaxProgress: Integer; var EventStatus: TEventStatus);
  end;

  TFetchProgressEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFetchProgressEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFetchProgressEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFetchProgressEvent;
  end;

  TRecordsetReasonEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DataSet: TCustomADODataSet; const Reason: TEventReason;
      var EventStatus: TEventStatus);
  end;

  TRecordsetReasonEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TRecordsetReasonEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TRecordsetReasonEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TRecordsetReasonEvent;
  end;

  TCustomADODataSet_sc = class of TCustomADODataSet;
  TCustomADODataSet_sw = class(TDataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomADODataSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomADODataSet;
    class function ClassToVar(AClass: TCustomADODataSet_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomADODataSet_sc;
  end;

  TADODataSet_sc = class of TADODataSet;
  TADODataSet_sw = class(TCustomADODataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TADODataSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TADODataSet;
    class function ClassToVar(AClass: TADODataSet_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TADODataSet_sc;
  end;

  TADOTable_sc = class of TADOTable;
  TADOTable_sw = class(TCustomADODataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TADOTable): OleVariant;
    class function FromVar(const AValue: OleVariant): TADOTable;
    class function ClassToVar(AClass: TADOTable_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TADOTable_sc;
  end;

  TADOQuery_sc = class of TADOQuery;
  TADOQuery_sw = class(TCustomADODataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TADOQuery): OleVariant;
    class function FromVar(const AValue: OleVariant): TADOQuery;
    class function ClassToVar(AClass: TADOQuery_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TADOQuery_sc;
  end;

  TADOStoredProc_sc = class of TADOStoredProc;
  TADOStoredProc_sw = class(TCustomADODataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TADOStoredProc): OleVariant;
    class function FromVar(const AValue: OleVariant): TADOStoredProc;
    class function ClassToVar(AClass: TADOStoredProc_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TADOStoredProc_sc;
  end;

  TADOBlobStream_sc = class of TADOBlobStream;
  TADOBlobStream_sw = class(TMemoryStream_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TADOBlobStream): OleVariant;
    class function FromVar(const AValue: OleVariant): TADOBlobStream;
    class function ClassToVar(AClass: TADOBlobStream_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TADOBlobStream_sc;
  end;


{ Unit wrapper }

type
  ADODB_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TParameters_sacc = class(TParameters);
  TADOCommand_sacc = class(TADOCommand);
  TCustomADODataSet_sacc = class(TCustomADODataSet);

{ EADOError_sw }

class function EADOError_sw.GetTypeName: WideString;
begin
  Result := 'EADOError';
end;

class function EADOError_sw.GetWrappedClass: TClass;
begin
  Result := EADOError;
end;

class procedure EADOError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EADOError_sw.ToVar(const AValue: EADOError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EADOError_sw.FromVar(const AValue: OleVariant): EADOError;
begin
  Result := EADOError(ConvFromVar(AValue, EADOError));
end;

class function EADOError_sw.ClassToVar(AClass: EADOError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EADOError_sw.ClassFromVar(
  const AClass: OleVariant): EADOError_sc;
begin
  Result := EADOError_sc(ConvClsFromVar(AClass, EADOError));
end;

{ TConnectMode_sw }

class function TConnectMode_sw.GetTypeName: WideString;
begin
  Result := 'TConnectMode';
end;

class procedure TConnectMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..7] of TLMDEnumerator = (
    (Name: 'cmUnknown'; Value: Integer({$IFDEF LMDSCT_12}TConnectMode.{$ENDIF}cmUnknown)),
    (Name: 'cmRead'; Value: Integer({$IFDEF LMDSCT_12}TConnectMode.{$ENDIF}cmRead)),
    (Name: 'cmWrite'; Value: Integer({$IFDEF LMDSCT_12}TConnectMode.{$ENDIF}cmWrite)),
    (Name: 'cmReadWrite'; Value: Integer({$IFDEF LMDSCT_12}TConnectMode.{$ENDIF}cmReadWrite)),
    (Name: 'cmShareDenyRead'; Value: Integer({$IFDEF LMDSCT_12}TConnectMode.{$ENDIF}cmShareDenyRead)),
    (Name: 'cmShareDenyWrite'; Value: Integer({$IFDEF LMDSCT_12}TConnectMode.{$ENDIF}cmShareDenyWrite)),
    (Name: 'cmShareExclusive'; Value: Integer({$IFDEF LMDSCT_12}TConnectMode.{$ENDIF}cmShareExclusive)),
    (Name: 'cmShareDenyNone'; Value: Integer({$IFDEF LMDSCT_12}TConnectMode.{$ENDIF}cmShareDenyNone))
  );
begin
  AEnums := @ENUMS;
  ACount := 8;
end;

class function TConnectMode_sw.ToVar(const AValue: TConnectMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TConnectMode_sw.FromVar(const AValue: OleVariant): TConnectMode;
begin
  Result := TConnectMode(Integer(AValue));
end;

{ TConnectOption_sw }

class function TConnectOption_sw.GetTypeName: WideString;
begin
  Result := 'TConnectOption';
end;

class procedure TConnectOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'coConnectUnspecified'; Value: Integer({$IFDEF LMDSCT_12}TConnectOption.{$ENDIF}coConnectUnspecified)),
    (Name: 'coAsyncConnect'; Value: Integer({$IFDEF LMDSCT_12}TConnectOption.{$ENDIF}coAsyncConnect))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TConnectOption_sw.ToVar(
  const AValue: TConnectOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TConnectOption_sw.FromVar(
  const AValue: OleVariant): TConnectOption;
begin
  Result := TConnectOption(Integer(AValue));
end;

{ TCursorLocation_sw }

class function TCursorLocation_sw.GetTypeName: WideString;
begin
  Result := 'TCursorLocation';
end;

class procedure TCursorLocation_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'clUseServer'; Value: Integer({$IFDEF LMDSCT_12}TCursorLocation.{$ENDIF}clUseServer)),
    (Name: 'clUseClient'; Value: Integer({$IFDEF LMDSCT_12}TCursorLocation.{$ENDIF}clUseClient))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TCursorLocation_sw.ToVar(
  const AValue: TCursorLocation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCursorLocation_sw.FromVar(
  const AValue: OleVariant): TCursorLocation;
begin
  Result := TCursorLocation(Integer(AValue));
end;

{ TCursorType_sw }

class function TCursorType_sw.GetTypeName: WideString;
begin
  Result := 'TCursorType';
end;

class procedure TCursorType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'ctUnspecified'; Value: Integer({$IFDEF LMDSCT_12}TCursorType.{$ENDIF}ctUnspecified)),
    (Name: 'ctOpenForwardOnly'; Value: Integer({$IFDEF LMDSCT_12}TCursorType.{$ENDIF}ctOpenForwardOnly)),
    (Name: 'ctKeyset'; Value: Integer({$IFDEF LMDSCT_12}TCursorType.{$ENDIF}ctKeyset)),
    (Name: 'ctDynamic'; Value: Integer({$IFDEF LMDSCT_12}TCursorType.{$ENDIF}ctDynamic)),
    (Name: 'ctStatic'; Value: Integer({$IFDEF LMDSCT_12}TCursorType.{$ENDIF}ctStatic))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TCursorType_sw.ToVar(const AValue: TCursorType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCursorType_sw.FromVar(const AValue: OleVariant): TCursorType;
begin
  Result := TCursorType(Integer(AValue));
end;

{ TEventStatus_sw }

class function TEventStatus_sw.GetTypeName: WideString;
begin
  Result := 'TEventStatus';
end;

class procedure TEventStatus_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'esOK'; Value: Integer({$IFDEF LMDSCT_12}TEventStatus.{$ENDIF}esOK)),
    (Name: 'esErrorsOccured'; Value: Integer({$IFDEF LMDSCT_12}TEventStatus.{$ENDIF}esErrorsOccured)),
    (Name: 'esCantDeny'; Value: Integer({$IFDEF LMDSCT_12}TEventStatus.{$ENDIF}esCantDeny)),
    (Name: 'esCancel'; Value: Integer({$IFDEF LMDSCT_12}TEventStatus.{$ENDIF}esCancel)),
    (Name: 'esUnwantedEvent'; Value: Integer({$IFDEF LMDSCT_12}TEventStatus.{$ENDIF}esUnwantedEvent))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TEventStatus_sw.ToVar(const AValue: TEventStatus): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TEventStatus_sw.FromVar(const AValue: OleVariant): TEventStatus;
begin
  Result := TEventStatus(Integer(AValue));
end;

{ TExecuteOption_sw }

class function TExecuteOption_sw.GetTypeName: WideString;
begin
  Result := 'TExecuteOption';
end;

class procedure TExecuteOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'eoAsyncExecute'; Value: Integer({$IFDEF LMDSCT_12}TExecuteOption.{$ENDIF}eoAsyncExecute)),
    (Name: 'eoAsyncFetch'; Value: Integer({$IFDEF LMDSCT_12}TExecuteOption.{$ENDIF}eoAsyncFetch)),
    (Name: 'eoAsyncFetchNonBlocking'; Value: Integer({$IFDEF LMDSCT_12}TExecuteOption.{$ENDIF}eoAsyncFetchNonBlocking)),
    (Name: 'eoExecuteNoRecords'; Value: Integer({$IFDEF LMDSCT_12}TExecuteOption.{$ENDIF}eoExecuteNoRecords))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TExecuteOption_sw.ToVar(
  const AValue: TExecuteOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TExecuteOption_sw.FromVar(
  const AValue: OleVariant): TExecuteOption;
begin
  Result := TExecuteOption(Integer(AValue));
end;

{ TExecuteOptions_sw }

class function TExecuteOptions_sw.GetTypeName: WideString;
begin
  Result := 'TExecuteOptions';
end;

class function TExecuteOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TExecuteOptions);
end;

class function TExecuteOptions_sw.ToVar(
  const AValue: TExecuteOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TExecuteOptions_sw.FromVar(
  const AValue: OleVariant): TExecuteOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TIsolationLevel_sw }

class function TIsolationLevel_sw.GetTypeName: WideString;
begin
  Result := 'TIsolationLevel';
end;

class procedure TIsolationLevel_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..8] of TLMDEnumerator = (
    (Name: 'ilUnspecified'; Value: Integer({$IFDEF LMDSCT_12}TIsolationLevel.{$ENDIF}ilUnspecified)),
    (Name: 'ilChaos'; Value: Integer({$IFDEF LMDSCT_12}TIsolationLevel.{$ENDIF}ilChaos)),
    (Name: 'ilReadUncommitted'; Value: Integer({$IFDEF LMDSCT_12}TIsolationLevel.{$ENDIF}ilReadUncommitted)),
    (Name: 'ilBrowse'; Value: Integer({$IFDEF LMDSCT_12}TIsolationLevel.{$ENDIF}ilBrowse)),
    (Name: 'ilCursorStability'; Value: Integer({$IFDEF LMDSCT_12}TIsolationLevel.{$ENDIF}ilCursorStability)),
    (Name: 'ilReadCommitted'; Value: Integer({$IFDEF LMDSCT_12}TIsolationLevel.{$ENDIF}ilReadCommitted)),
    (Name: 'ilRepeatableRead'; Value: Integer({$IFDEF LMDSCT_12}TIsolationLevel.{$ENDIF}ilRepeatableRead)),
    (Name: 'ilSerializable'; Value: Integer({$IFDEF LMDSCT_12}TIsolationLevel.{$ENDIF}ilSerializable)),
    (Name: 'ilIsolated'; Value: Integer({$IFDEF LMDSCT_12}TIsolationLevel.{$ENDIF}ilIsolated))
  );
begin
  AEnums := @ENUMS;
  ACount := 9;
end;

class function TIsolationLevel_sw.ToVar(
  const AValue: TIsolationLevel): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TIsolationLevel_sw.FromVar(
  const AValue: OleVariant): TIsolationLevel;
begin
  Result := TIsolationLevel(Integer(AValue));
end;

{ TADOLockType_sw }

class function TADOLockType_sw.GetTypeName: WideString;
begin
  Result := 'TADOLockType';
end;

class procedure TADOLockType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'ltUnspecified'; Value: Integer({$IFDEF LMDSCT_12}TADOLockType.{$ENDIF}ltUnspecified)),
    (Name: 'ltReadOnly'; Value: Integer({$IFDEF LMDSCT_12}TADOLockType.{$ENDIF}ltReadOnly)),
    (Name: 'ltPessimistic'; Value: Integer({$IFDEF LMDSCT_12}TADOLockType.{$ENDIF}ltPessimistic)),
    (Name: 'ltOptimistic'; Value: Integer({$IFDEF LMDSCT_12}TADOLockType.{$ENDIF}ltOptimistic)),
    (Name: 'ltBatchOptimistic'; Value: Integer({$IFDEF LMDSCT_12}TADOLockType.{$ENDIF}ltBatchOptimistic))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TADOLockType_sw.ToVar(const AValue: TADOLockType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TADOLockType_sw.FromVar(const AValue: OleVariant): TADOLockType;
begin
  Result := TADOLockType(Integer(AValue));
end;

{ TObjectState_sw }

class function TObjectState_sw.GetTypeName: WideString;
begin
  Result := 'TObjectState';
end;

class procedure TObjectState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'stClosed'; Value: Integer({$IFDEF LMDSCT_12}TObjectState.{$ENDIF}stClosed)),
    (Name: 'stOpen'; Value: Integer({$IFDEF LMDSCT_12}TObjectState.{$ENDIF}stOpen)),
    (Name: 'stConnecting'; Value: Integer({$IFDEF LMDSCT_12}TObjectState.{$ENDIF}stConnecting)),
    (Name: 'stExecuting'; Value: Integer({$IFDEF LMDSCT_12}TObjectState.{$ENDIF}stExecuting)),
    (Name: 'stFetching'; Value: Integer({$IFDEF LMDSCT_12}TObjectState.{$ENDIF}stFetching))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TObjectState_sw.ToVar(const AValue: TObjectState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TObjectState_sw.FromVar(const AValue: OleVariant): TObjectState;
begin
  Result := TObjectState(Integer(AValue));
end;

{ TObjectStates_sw }

class function TObjectStates_sw.GetTypeName: WideString;
begin
  Result := 'TObjectStates';
end;

class function TObjectStates_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TObjectStates);
end;

class function TObjectStates_sw.ToVar(const AValue: TObjectStates): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TObjectStates_sw.FromVar(
  const AValue: OleVariant): TObjectStates;
begin
  ConvFromVar(AValue, @Result);
end;

{ TSchemaInfo_sw }

class function TSchemaInfo_sw.GetTypeName: WideString;
begin
  Result := 'TSchemaInfo';
end;

class procedure TSchemaInfo_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..39] of TLMDEnumerator = (
    (Name: 'siAsserts'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siAsserts)),
    (Name: 'siCatalogs'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siCatalogs)),
    (Name: 'siCharacterSets'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siCharacterSets)),
    (Name: 'siCollations'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siCollations)),
    (Name: 'siColumns'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siColumns)),
    (Name: 'siCheckConstraints'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siCheckConstraints)),
    (Name: 'siConstraintColumnUsage'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siConstraintColumnUsage)),
    (Name: 'siConstraintTableUsage'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siConstraintTableUsage)),
    (Name: 'siKeyColumnUsage'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siKeyColumnUsage)),
    (Name: 'siReferentialConstraints'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siReferentialConstraints)),
    (Name: 'siTableConstraints'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siTableConstraints)),
    (Name: 'siColumnsDomainUsage'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siColumnsDomainUsage)),
    (Name: 'siIndexes'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siIndexes)),
    (Name: 'siColumnPrivileges'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siColumnPrivileges)),
    (Name: 'siTablePrivileges'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siTablePrivileges)),
    (Name: 'siUsagePrivileges'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siUsagePrivileges)),
    (Name: 'siProcedures'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siProcedures)),
    (Name: 'siSchemata'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siSchemata)),
    (Name: 'siSQLLanguages'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siSQLLanguages)),
    (Name: 'siStatistics'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siStatistics)),
    (Name: 'siTables'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siTables)),
    (Name: 'siTranslations'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siTranslations)),
    (Name: 'siProviderTypes'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siProviderTypes)),
    (Name: 'siViews'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siViews)),
    (Name: 'siViewColumnUsage'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siViewColumnUsage)),
    (Name: 'siViewTableUsage'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siViewTableUsage)),
    (Name: 'siProcedureParameters'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siProcedureParameters)),
    (Name: 'siForeignKeys'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siForeignKeys)),
    (Name: 'siPrimaryKeys'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siPrimaryKeys)),
    (Name: 'siProcedureColumns'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siProcedureColumns)),
    (Name: 'siDBInfoKeywords'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siDBInfoKeywords)),
    (Name: 'siDBInfoLiterals'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siDBInfoLiterals)),
    (Name: 'siCubes'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siCubes)),
    (Name: 'siDimensions'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siDimensions)),
    (Name: 'siHierarchies'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siHierarchies)),
    (Name: 'siLevels'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siLevels)),
    (Name: 'siMeasures'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siMeasures)),
    (Name: 'siProperties'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siProperties)),
    (Name: 'siMembers'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siMembers)),
    (Name: 'siProviderSpecific'; Value: Integer({$IFDEF LMDSCT_12}TSchemaInfo.{$ENDIF}siProviderSpecific))
  );
begin
  AEnums := @ENUMS;
  ACount := 40;
end;

class function TSchemaInfo_sw.ToVar(const AValue: TSchemaInfo): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TSchemaInfo_sw.FromVar(const AValue: OleVariant): TSchemaInfo;
begin
  Result := TSchemaInfo(Integer(AValue));
end;

{ TXactAttribute_sw }

class function TXactAttribute_sw.GetTypeName: WideString;
begin
  Result := 'TXactAttribute';
end;

class procedure TXactAttribute_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'xaCommitRetaining'; Value: Integer({$IFDEF LMDSCT_12}TXactAttribute.{$ENDIF}xaCommitRetaining)),
    (Name: 'xaAbortRetaining'; Value: Integer({$IFDEF LMDSCT_12}TXactAttribute.{$ENDIF}xaAbortRetaining))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TXactAttribute_sw.ToVar(
  const AValue: TXactAttribute): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TXactAttribute_sw.FromVar(
  const AValue: OleVariant): TXactAttribute;
begin
  Result := TXactAttribute(Integer(AValue));
end;

{ TXactAttributes_sw }

class function TXactAttributes_sw.GetTypeName: WideString;
begin
  Result := 'TXactAttributes';
end;

class function TXactAttributes_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TXactAttributes);
end;

class function TXactAttributes_sw.ToVar(
  const AValue: TXactAttributes): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TXactAttributes_sw.FromVar(
  const AValue: OleVariant): TXactAttributes;
begin
  ConvFromVar(AValue, @Result);
end;

{ TCommandType_sw }

class function TCommandType_sw.GetTypeName: WideString;
begin
  Result := 'TCommandType';
end;

class procedure TCommandType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'cmdUnknown'; Value: Integer({$IFDEF LMDSCT_12}TCommandType.{$ENDIF}cmdUnknown)),
    (Name: 'cmdText'; Value: Integer({$IFDEF LMDSCT_12}TCommandType.{$ENDIF}cmdText)),
    (Name: 'cmdTable'; Value: Integer({$IFDEF LMDSCT_12}TCommandType.{$ENDIF}cmdTable)),
    (Name: 'cmdStoredProc'; Value: Integer({$IFDEF LMDSCT_12}TCommandType.{$ENDIF}cmdStoredProc)),
    (Name: 'cmdFile'; Value: Integer({$IFDEF LMDSCT_12}TCommandType.{$ENDIF}cmdFile)),
    (Name: 'cmdTableDirect'; Value: Integer({$IFDEF LMDSCT_12}TCommandType.{$ENDIF}cmdTableDirect))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TCommandType_sw.ToVar(const AValue: TCommandType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCommandType_sw.FromVar(const AValue: OleVariant): TCommandType;
begin
  Result := TCommandType(Integer(AValue));
end;

{ TDisconnectEvent_sh }

function TDisconnectEvent_sh.GetHandler: TMethod;
var
  hdr: TDisconnectEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDisconnectEvent_sh.Handler(Connection: TADOConnection;
  var EventStatus: TEventStatus);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Connection: TADOConnection; var EventStatus: T...

  v_1 := TEventStatus_sw.ToVar(EventStatus);
  args[0] := TADOConnection_sw.ToVar(Connection);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  EventStatus := TEventStatus_sw.FromVar(v_1);
end;

{ TDisconnectEvent_sw }

class function TDisconnectEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDisconnectEvent';
end;

class function TDisconnectEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDisconnectEvent_sh;
end;

class function TDisconnectEvent_sw.ToVar(
  const AValue: TDisconnectEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDisconnectEvent_sw.FromVar(
  const AValue: OleVariant): TDisconnectEvent;
begin
  Result := TDisconnectEvent(ConvFromVar(AValue));
end;

class function TDisconnectEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TDisconnectEvent;
var
  hdlr: TDisconnectEvent_sh;
begin
  hdlr   := TDisconnectEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDisconnectEvent_sw));
  Result := hdlr.Handler;
end;

{ TWillConnectEvent_sh }

function TWillConnectEvent_sh.GetHandler: TMethod;
var
  hdr: TWillConnectEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TWillConnectEvent_sh.Handler(Connection: TADOConnection;
  var ConnectionString: WideString; var UserID: WideString;
  var Password: WideString; var ConnectOptions: TConnectOption;
  var EventStatus: TEventStatus);
var
  args: array[0..5] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
  v_3: OleVariant;
  v_4: OleVariant;
  v_5: OleVariant;
begin
  // procedure (Connection: TADOConnection; var ConnectionStri...

  v_1 := ConnectionString;
  v_2 := UserID;
  v_3 := Password;
  v_4 := TConnectOption_sw.ToVar(ConnectOptions);
  v_5 := TEventStatus_sw.ToVar(EventStatus);
  args[0] := TADOConnection_sw.ToVar(Connection);
  args[1] := MakeVarRef(v_1);
  args[2] := MakeVarRef(v_2);
  args[3] := MakeVarRef(v_3);
  args[4] := MakeVarRef(v_4);
  args[5] := MakeVarRef(v_5);
  Self.Owner.RunProc(Self.ProcName, args);
  ConnectionString := WideString(v_1);
  UserID := WideString(v_2);
  Password := WideString(v_3);
  ConnectOptions := TConnectOption_sw.FromVar(v_4);
  EventStatus := TEventStatus_sw.FromVar(v_5);
end;

{ TWillConnectEvent_sw }

class function TWillConnectEvent_sw.GetTypeName: WideString;
begin
  Result := 'TWillConnectEvent';
end;

class function TWillConnectEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TWillConnectEvent_sh;
end;

class function TWillConnectEvent_sw.ToVar(
  const AValue: TWillConnectEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TWillConnectEvent_sw.FromVar(
  const AValue: OleVariant): TWillConnectEvent;
begin
  Result := TWillConnectEvent(ConvFromVar(AValue));
end;

class function TWillConnectEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TWillConnectEvent;
var
  hdlr: TWillConnectEvent_sh;
begin
  hdlr   := TWillConnectEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TWillConnectEvent_sw));
  Result := hdlr.Handler;
end;

{ TADOConnection_sw }

function TADOConnection_BeginTrans_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function BeginTrans: Integer;

  Result := TADOConnection(AObj).BeginTrans();
end;

function TADOConnection_Cancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Cancel;

  TADOConnection(AObj).Cancel();
end;

function TADOConnection_CommitTrans_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CommitTrans;

  TADOConnection(AObj).CommitTrans();
end;

function TADOConnection_Execute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // procedure/function Execute(...); overload;

  case AArgsSize of
    2:
    begin
      v_1 := Integer(AArgs[1]);
      TADOConnection(AObj).Execute(WideString(AArgs[0]), v_1);
      AssignRefParam(AArgs[1], v_1);
    end;
    3:
    begin
      v_1 := Integer(AArgs[1]);
      TADOConnection(AObj).Execute(WideString(AArgs[0]), v_1, 
        TExecuteOptions_sw.FromVar(AArgs[2]));
      AssignRefParam(AArgs[1], v_1);
    end;
  else
    WrongArgCountError('Execute');
  end;
end;

function TADOConnection_GetProcedureNames_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetProcedureNames(List: TStrings);

  TADOConnection(AObj).GetProcedureNames(TStrings_sw.FromVar(AArgs[0]));
end;

function TADOConnection_GetFieldNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetFieldNames(const TableName: string; List: TS...

  TADOConnection(AObj).GetFieldNames(string(AArgs[0]), TStrings_sw.FromVar(
    AArgs[1]));
end;

function TADOConnection_GetTableNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetTableNames(List: TStrings; SystemTables: Boo...

  case AArgsSize of
    1:
    begin
      TADOConnection(AObj).GetTableNames(TStrings_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      TADOConnection(AObj).GetTableNames(TStrings_sw.FromVar(AArgs[0]), Boolean(
        AArgs[1]));
    end;
  else
    WrongArgCountError('GetTableNames');
  end;
end;

function TADOConnection_Open_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Open(...); overload;

  TADOConnection(AObj).Open(WideString(AArgs[0]), WideString(AArgs[1]));
end;

function TADOConnection_OpenSchema_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure OpenSchema(const Schema: TSchemaInfo; const Res...

  TADOConnection(AObj).OpenSchema(TSchemaInfo_sw.FromVar(AArgs[0]), OleVariant(
    FindVarData(AArgs[1])^), OleVariant(FindVarData(AArgs[2])^), TADODataSet_sw.
    FromVar(AArgs[3]));
end;

function TADOConnection_RollbackTrans_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RollbackTrans;

  TADOConnection(AObj).RollbackTrans();
end;

function TADOConnection_CommandCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CommandCount: Integer read <getter>;

  Result := TADOConnection(AObj).CommandCount;
end;

function TADOConnection_Commands_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Commands[Index: Integer]: TADOCommand read <gett...

  Result := TADOCommand_sw.ToVar(TADOConnection(AObj).Commands[Integer(
    AArgs[0])]);
end;

function TADOConnection_DataSets_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSets[Index: Integer]: TCustomADODataSet read...

  Result := TCustomADODataSet_sw.ToVar(TADOConnection(AObj).DataSets[Integer(
    AArgs[0])]);
end;

function TADOConnection_InTransaction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property InTransaction: Boolean read <getter>;

  Result := TADOConnection(AObj).InTransaction;
end;

function TADOConnection_State_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property State: TObjectStates read <getter>;

  Result := TObjectStates_sw.ToVar(TADOConnection(AObj).State);
end;

function TADOConnection_Version_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Version: WideString read <getter>;

  Result := TADOConnection(AObj).Version;
end;

function TADOConnection_Attributes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Attributes: TXactAttributes read <getter> write ...

  if IsGet then
    Result := TXactAttributes_sw.ToVar(TADOConnection(AObj).Attributes)
  else
    TADOConnection(AObj).Attributes := TXactAttributes_sw.FromVar(AArgs[0]);
end;

function TADOConnection_CommandTimeout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CommandTimeout: Integer read <getter> write <set...

  if IsGet then
    Result := TADOConnection(AObj).CommandTimeout
  else
    TADOConnection(AObj).CommandTimeout := Integer(AArgs[0]);
end;

function TADOConnection_ConnectionString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ConnectionString: WideString read <getter> write...

  if IsGet then
    Result := TADOConnection(AObj).ConnectionString
  else
    TADOConnection(AObj).ConnectionString := WideString(AArgs[0]);
end;

function TADOConnection_ConnectionTimeout_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ConnectionTimeout: Integer read <getter> write <...

  if IsGet then
    Result := TADOConnection(AObj).ConnectionTimeout
  else
    TADOConnection(AObj).ConnectionTimeout := Integer(AArgs[0]);
end;

function TADOConnection_ConnectOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ConnectOptions: TConnectOption read <getter> wri...

  if IsGet then
    Result := TConnectOption_sw.ToVar(TADOConnection(AObj).ConnectOptions)
  else
    TADOConnection(AObj).ConnectOptions := TConnectOption_sw.FromVar(AArgs[0]);
end;

function TADOConnection_CursorLocation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CursorLocation: TCursorLocation read <getter> wr...

  if IsGet then
    Result := TCursorLocation_sw.ToVar(TADOConnection(AObj).CursorLocation)
  else
    TADOConnection(AObj).CursorLocation := TCursorLocation_sw.FromVar(AArgs[0]);
end;

function TADOConnection_DefaultDatabase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultDatabase: WideString read <getter> write ...

  if IsGet then
    Result := TADOConnection(AObj).DefaultDatabase
  else
    TADOConnection(AObj).DefaultDatabase := WideString(AArgs[0]);
end;

function TADOConnection_IsolationLevel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsolationLevel: TIsolationLevel read <getter> wr...

  if IsGet then
    Result := TIsolationLevel_sw.ToVar(TADOConnection(AObj).IsolationLevel)
  else
    TADOConnection(AObj).IsolationLevel := TIsolationLevel_sw.FromVar(AArgs[0]);
end;

function TADOConnection_KeepConnection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeepConnection: Boolean read <getter> write <set...

  if IsGet then
    Result := TADOConnection(AObj).KeepConnection
  else
    TADOConnection(AObj).KeepConnection := Boolean(AArgs[0]);
end;

function TADOConnection_Mode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Mode: TConnectMode read <getter> write <setter>;

  if IsGet then
    Result := TConnectMode_sw.ToVar(TADOConnection(AObj).Mode)
  else
    TADOConnection(AObj).Mode := TConnectMode_sw.FromVar(AArgs[0]);
end;

function TADOConnection_Provider_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Provider: WideString read <getter> write <setter>;

  if IsGet then
    Result := TADOConnection(AObj).Provider
  else
    TADOConnection(AObj).Provider := WideString(AArgs[0]);
end;

function TADOConnection_OnDisconnect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDisconnect: TDisconnectEvent read <getter> wri...

  if IsGet then
    Result := TDisconnectEvent_sw.ToVar(TADOConnection(AObj).OnDisconnect)
  else
    TADOConnection(AObj).OnDisconnect := TDisconnectEvent_sw.FromVar(AArgs[0]);
end;

function TADOConnection_OnWillConnect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnWillConnect: TWillConnectEvent read <getter> w...

  if IsGet then
    Result := TWillConnectEvent_sw.ToVar(TADOConnection(AObj).OnWillConnect)
  else
    TADOConnection(AObj).OnWillConnect := TWillConnectEvent_sw.FromVar(
      AArgs[0]);
end;

class function TADOConnection_sw.GetTypeName: WideString;
begin
  Result := 'TADOConnection';
end;

class function TADOConnection_sw.GetWrappedClass: TClass;
begin
  Result := TADOConnection;
end;

class procedure TADOConnection_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('BeginTrans', TADOConnection_BeginTrans_si, Integer_sw, 0, False);
  AData.AddProcedure('Cancel', TADOConnection_Cancel_si, 0, False);
  AData.AddProcedure('CommitTrans', TADOConnection_CommitTrans_si, 0, False);
  AData.AddProcedure('Execute', TADOConnection_Execute_si, 2, True);
  AData.AddProcedure('GetProcedureNames', TADOConnection_GetProcedureNames_si, 1, False);
  AData.AddProcedure('GetFieldNames', TADOConnection_GetFieldNames_si, 2, False);
  AData.AddProcedure('GetTableNames', TADOConnection_GetTableNames_si, 1, True);
  AData.AddProcedure('Open', TADOConnection_Open_si, 2, False);
  AData.AddProcedure('OpenSchema', TADOConnection_OpenSchema_si, 4, False);
  AData.AddProcedure('RollbackTrans', TADOConnection_RollbackTrans_si, 0, False);
  AData.AddProperty('CommandCount', TADOConnection_CommandCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Commands', TADOConnection_Commands_si, TADOCommand_sw, True, False, 1, False, False);
  AData.AddProperty('DataSets', TADOConnection_DataSets_si, TCustomADODataSet_sw, True, False, 1, False, False);
  AData.AddProperty('InTransaction', TADOConnection_InTransaction_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('State', TADOConnection_State_si, TObjectStates_sw, True, False, 0, False, False);
  AData.AddProperty('Version', TADOConnection_Version_si, WideString_sw, True, False, 0, False, False);
  AData.AddProperty('Attributes', TADOConnection_Attributes_si, TXactAttributes_sw, True, True, 0, False, False);
  AData.AddProperty('CommandTimeout', TADOConnection_CommandTimeout_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Connected', False);
  AData.AddProperty('ConnectionString', TADOConnection_ConnectionString_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('ConnectionTimeout', TADOConnection_ConnectionTimeout_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ConnectOptions', TADOConnection_ConnectOptions_si, TConnectOption_sw, True, True, 0, False, False);
  AData.AddProperty('CursorLocation', TADOConnection_CursorLocation_si, TCursorLocation_sw, True, True, 0, False, False);
  AData.AddProperty('DefaultDatabase', TADOConnection_DefaultDatabase_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('IsolationLevel', TADOConnection_IsolationLevel_si, TIsolationLevel_sw, True, True, 0, False, False);
  AData.AddProperty('KeepConnection', TADOConnection_KeepConnection_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('LoginPrompt', False);
  AData.AddProperty('Mode', TADOConnection_Mode_si, TConnectMode_sw, True, True, 0, False, False);
  AData.AddProperty('Provider', TADOConnection_Provider_si, WideString_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('AfterConnect', False);
  AData.AddPropertyRedecl('BeforeConnect', False);
  AData.AddPropertyRedecl('AfterDisconnect', False);
  AData.AddPropertyRedecl('BeforeDisconnect', False);
  AData.AddProperty('OnDisconnect', TADOConnection_OnDisconnect_si, TDisconnectEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnWillConnect', TADOConnection_OnWillConnect_si, TWillConnectEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnLogin', False);
end;

class function TADOConnection_sw.ToVar(
  const AValue: TADOConnection): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TADOConnection_sw.FromVar(
  const AValue: OleVariant): TADOConnection;
begin
  Result := TADOConnection(ConvFromVar(AValue, TADOConnection));
end;

class function TADOConnection_sw.ClassToVar(
  AClass: TADOConnection_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TADOConnection_sw.ClassFromVar(
  const AClass: OleVariant): TADOConnection_sc;
begin
  Result := TADOConnection_sc(ConvClsFromVar(AClass, TADOConnection));
end;

{ TRDSConnection_sw }

function TRDSConnection_AppServer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AppServer: OleVariant read <getter>;

  Result := TRDSConnection(AObj).AppServer;
end;

function TRDSConnection_ComputerName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ComputerName: WideString read <getter> write <se...

  if IsGet then
    Result := TRDSConnection(AObj).ComputerName
  else
    TRDSConnection(AObj).ComputerName := WideString(AArgs[0]);
end;

function TRDSConnection_InternetTimeout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property InternetTimeout: Integer read <getter> write <se...

  if IsGet then
    Result := TRDSConnection(AObj).InternetTimeout
  else
    TRDSConnection(AObj).InternetTimeout := Integer(AArgs[0]);
end;

function TRDSConnection_ServerName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ServerName: WideString read <getter> write <sett...

  if IsGet then
    Result := TRDSConnection(AObj).ServerName
  else
    TRDSConnection(AObj).ServerName := WideString(AArgs[0]);
end;

class function TRDSConnection_sw.GetTypeName: WideString;
begin
  Result := 'TRDSConnection';
end;

class function TRDSConnection_sw.GetWrappedClass: TClass;
begin
  Result := TRDSConnection;
end;

class procedure TRDSConnection_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('AppServer', TRDSConnection_AppServer_si, OleVariant_sw, True, False, 0, False, False);
  AData.AddProperty('ComputerName', TRDSConnection_ComputerName_si, WideString_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Connected', False);
  AData.AddProperty('InternetTimeout', TRDSConnection_InternetTimeout_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ServerName', TRDSConnection_ServerName_si, WideString_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('AfterConnect', False);
  AData.AddPropertyRedecl('AfterDisconnect', False);
  AData.AddPropertyRedecl('BeforeConnect', False);
  AData.AddPropertyRedecl('BeforeDisconnect', False);
end;

class function TRDSConnection_sw.ToVar(
  const AValue: TRDSConnection): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TRDSConnection_sw.FromVar(
  const AValue: OleVariant): TRDSConnection;
begin
  Result := TRDSConnection(ConvFromVar(AValue, TRDSConnection));
end;

class function TRDSConnection_sw.ClassToVar(
  AClass: TRDSConnection_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TRDSConnection_sw.ClassFromVar(
  const AClass: OleVariant): TRDSConnection_sc;
begin
  Result := TRDSConnection_sc(ConvClsFromVar(AClass, TRDSConnection));
end;

{ TParameterAttribute_sw }

class function TParameterAttribute_sw.GetTypeName: WideString;
begin
  Result := 'TParameterAttribute';
end;

class procedure TParameterAttribute_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'paSigned'; Value: Integer({$IFDEF LMDSCT_12}TParameterAttribute.{$ENDIF}paSigned)),
    (Name: 'paNullable'; Value: Integer({$IFDEF LMDSCT_12}TParameterAttribute.{$ENDIF}paNullable)),
    (Name: 'paLong'; Value: Integer({$IFDEF LMDSCT_12}TParameterAttribute.{$ENDIF}paLong))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TParameterAttribute_sw.ToVar(
  const AValue: TParameterAttribute): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TParameterAttribute_sw.FromVar(
  const AValue: OleVariant): TParameterAttribute;
begin
  Result := TParameterAttribute(Integer(AValue));
end;

{ TParameterAttributes_sw }

class function TParameterAttributes_sw.GetTypeName: WideString;
begin
  Result := 'TParameterAttributes';
end;

class function TParameterAttributes_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TParameterAttributes);
end;

class function TParameterAttributes_sw.ToVar(
  const AValue: TParameterAttributes): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TParameterAttributes_sw.FromVar(
  const AValue: OleVariant): TParameterAttributes;
begin
  ConvFromVar(AValue, @Result);
end;

{ TParameterDirection_sw }

class function TParameterDirection_sw.GetTypeName: WideString;
begin
  Result := 'TParameterDirection';
end;

class procedure TParameterDirection_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'pdUnknown'; Value: Integer({$IFDEF LMDSCT_12}TParameterDirection.{$ENDIF}pdUnknown)),
    (Name: 'pdInput'; Value: Integer({$IFDEF LMDSCT_12}TParameterDirection.{$ENDIF}pdInput)),
    (Name: 'pdOutput'; Value: Integer({$IFDEF LMDSCT_12}TParameterDirection.{$ENDIF}pdOutput)),
    (Name: 'pdInputOutput'; Value: Integer({$IFDEF LMDSCT_12}TParameterDirection.{$ENDIF}pdInputOutput)),
    (Name: 'pdReturnValue'; Value: Integer({$IFDEF LMDSCT_12}TParameterDirection.{$ENDIF}pdReturnValue))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TParameterDirection_sw.ToVar(
  const AValue: TParameterDirection): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TParameterDirection_sw.FromVar(
  const AValue: OleVariant): TParameterDirection;
begin
  Result := TParameterDirection(Integer(AValue));
end;

{ TParameter_sw }

function TParameter_AppendChunk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AppendChunk(Val: OleVariant);

  TParameter(AObj).AppendChunk(OleVariant(FindVarData(AArgs[0])^));
end;

function TParameter_LoadFromFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromFile(const FileName: string; DataType: ...

  TParameter(AObj).LoadFromFile(string(AArgs[0]), TDataType_sw.FromVar(
    AArgs[1]));
end;

function TParameter_LoadFromStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromStream(Stream: TStream; DataType: TData...

  TParameter(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]), TDataType_sw.
    FromVar(AArgs[1]));
end;

function TParameter_Parameters_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Parameters: TParameters read <getter>;

  Result := TParameters_sw.ToVar(TParameter(AObj).Parameters);
end;

function TParameter_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Name: WideString read <getter> write <setter>;

  if IsGet then
    Result := TParameter(AObj).Name
  else
    TParameter(AObj).Name := WideString(AArgs[0]);
end;

function TParameter_Attributes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Attributes: TParameterAttributes read <getter> w...

  if IsGet then
    Result := TParameterAttributes_sw.ToVar(TParameter(AObj).Attributes)
  else
    TParameter(AObj).Attributes := TParameterAttributes_sw.FromVar(AArgs[0]);
end;

function TParameter_DataType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataType: TDataType read <getter> write <setter>;

  if IsGet then
    Result := TDataType_sw.ToVar(TParameter(AObj).DataType)
  else
    TParameter(AObj).DataType := TDataType_sw.FromVar(AArgs[0]);
end;

function TParameter_Direction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Direction: TParameterDirection read <getter> wri...

  if IsGet then
    Result := TParameterDirection_sw.ToVar(TParameter(AObj).Direction)
  else
    TParameter(AObj).Direction := TParameterDirection_sw.FromVar(AArgs[0]);
end;

function TParameter_NumericScale_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NumericScale: Byte read <getter> write <setter>;

  if IsGet then
    Result := TParameter(AObj).NumericScale
  else
    TParameter(AObj).NumericScale := Byte(AArgs[0]);
end;

function TParameter_Precision_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Precision: Byte read <getter> write <setter>;

  if IsGet then
    Result := TParameter(AObj).Precision
  else
    TParameter(AObj).Precision := Byte(AArgs[0]);
end;

function TParameter_Size_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Size: Integer read <getter> write <setter>;

  if IsGet then
    Result := TParameter(AObj).Size
  else
    TParameter(AObj).Size := Integer(AArgs[0]);
end;

function TParameter_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: Variant read <getter> write <setter>;

  if IsGet then
    Result := TParameter(AObj).Value
  else
    TParameter(AObj).Value := Variant(FindVarData(AArgs[0])^);
end;

class function TParameter_sw.GetTypeName: WideString;
begin
  Result := 'TParameter';
end;

class function TParameter_sw.GetWrappedClass: TClass;
begin
  Result := TParameter;
end;

class procedure TParameter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('AppendChunk', TParameter_AppendChunk_si, 1, False);
  AData.AddProcedure('LoadFromFile', TParameter_LoadFromFile_si, 2, False);
  AData.AddProcedure('LoadFromStream', TParameter_LoadFromStream_si, 2, False);
  AData.AddProperty('Parameters', TParameter_Parameters_si, TParameters_sw, True, False, 0, False, False);
  AData.AddProperty('Name', TParameter_Name_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('Attributes', TParameter_Attributes_si, TParameterAttributes_sw, True, True, 0, False, False);
  AData.AddProperty('DataType', TParameter_DataType_si, TDataType_sw, True, True, 0, False, False);
  AData.AddProperty('Direction', TParameter_Direction_si, TParameterDirection_sw, True, True, 0, False, False);
  AData.AddProperty('NumericScale', TParameter_NumericScale_si, Byte_sw, True, True, 0, False, False);
  AData.AddProperty('Precision', TParameter_Precision_si, Byte_sw, True, True, 0, False, False);
  AData.AddProperty('Size', TParameter_Size_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Value', TParameter_Value_si, Variant_sw, True, True, 0, False, False);
end;

class function TParameter_sw.ToVar(const AValue: TParameter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TParameter_sw.FromVar(const AValue: OleVariant): TParameter;
begin
  Result := TParameter(ConvFromVar(AValue, TParameter));
end;

class function TParameter_sw.ClassToVar(AClass: TParameter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TParameter_sw.ClassFromVar(
  const AClass: OleVariant): TParameter_sc;
begin
  Result := TParameter_sc(ConvClsFromVar(AClass, TParameter));
end;

{ TParameters_sw }

function TParameters_Modified_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Modified: Boolean read <getter>;

  Result := TParameters_sacc(TParameters(AObj)).Modified;
end;

function TParameters_AddParameter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddParameter: TParameter;

  Result := TParameter_sw.ToVar(TParameters(AObj).AddParameter());
end;

function TParameters_AssignValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AssignValues(Value: TParameters);

  TParameters(AObj).AssignValues(TParameters_sw.FromVar(AArgs[0]));
end;

function TParameters_CreateParameter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CreateParameter(const Name: WideString; DataType...

  Result := TParameter_sw.ToVar(TParameters(AObj).CreateParameter(WideString(
    AArgs[0]), TDataType_sw.FromVar(AArgs[1]), TParameterDirection_sw.FromVar(
    AArgs[2]), Integer(AArgs[3]), OleVariant(FindVarData(AArgs[4])^)));
end;

function TParameters_FindParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindParam(const Value: WideString): TParameter;

  Result := TParameter_sw.ToVar(TParameters(AObj).FindParam(WideString(
    AArgs[0])));
end;

function TParameters_GetParamList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetParamList(List: TList; const ParamNames: Wid...

  TParameters(AObj).GetParamList(TList_sw.FromVar(AArgs[0]), WideString(
    AArgs[1]));
end;

function TParameters_IsEqual_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsEqual(Value: TParameters): Boolean;

  Result := TParameters(AObj).IsEqual(TParameters_sw.FromVar(AArgs[0]));
end;

function TParameters_ParamByName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ParamByName(const Value: WideString): TParameter;

  Result := TParameter_sw.ToVar(TParameters(AObj).ParamByName(WideString(
    AArgs[0])));
end;

function TParameters_ParseSQL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ParseSQL(SQL: string; DoCreate: Boolean): string;

  Result := TParameters(AObj).ParseSQL(string(AArgs[0]), Boolean(AArgs[1]));
end;

function TParameters_Refresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Refresh: Boolean;

  Result := TParameters(AObj).Refresh();
end;

function TParameters_ParamValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParamValues[const ParamName: WideString]: Varian...

  if IsGet then
    Result := TParameters(AObj).ParamValues[WideString(AArgs[0])]
  else
    TParameters(AObj).ParamValues[WideString(AArgs[0])] := Variant(FindVarData(
      AArgs[1])^);
end;

function TParameters_Command_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Command: TADOCommand read <getter>;

  Result := TADOCommand_sw.ToVar(TParameters(AObj).Command);
end;

function TParameters_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TParameter read <getter> ...

  if IsGet then
    Result := TParameter_sw.ToVar(TParameters(AObj).Items[Integer(AArgs[0])])
  else
    TParameters(AObj).Items[Integer(AArgs[0])] := TParameter_sw.FromVar(
      AArgs[1]);
end;

class function TParameters_sw.GetTypeName: WideString;
begin
  Result := 'TParameters';
end;

class function TParameters_sw.GetWrappedClass: TClass;
begin
  Result := TParameters;
end;

class procedure TParameters_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Modified', TParameters_Modified_si, Boolean_sw, True, False, 0, True, False);
  AData.AddFunction('AddParameter', TParameters_AddParameter_si, TParameter_sw, 0, False);
  AData.AddProcedure('AssignValues', TParameters_AssignValues_si, 1, False);
  AData.AddFunction('CreateParameter', TParameters_CreateParameter_si, TParameter_sw, 5, False);
  AData.AddFunction('FindParam', TParameters_FindParam_si, TParameter_sw, 1, False);
  AData.AddProcedure('GetParamList', TParameters_GetParamList_si, 2, False);
  AData.AddFunction('IsEqual', TParameters_IsEqual_si, Boolean_sw, 1, False);
  AData.AddFunction('ParamByName', TParameters_ParamByName_si, TParameter_sw, 1, False);
  AData.AddFunction('ParseSQL', TParameters_ParseSQL_si, string_sw, 2, False);
  AData.AddFunction('Refresh', TParameters_Refresh_si, Boolean_sw, 0, False);
  AData.AddProperty('ParamValues', TParameters_ParamValues_si, Variant_sw, True, True, 1, False, False);
  AData.AddProperty('Command', TParameters_Command_si, TADOCommand_sw, True, False, 0, False, False);
  AData.AddProperty('Items', TParameters_Items_si, TParameter_sw, True, True, 1, False, True);
end;

class function TParameters_sw.ToVar(const AValue: TParameters): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TParameters_sw.FromVar(const AValue: OleVariant): TParameters;
begin
  Result := TParameters(ConvFromVar(AValue, TParameters));
end;

class function TParameters_sw.ClassToVar(AClass: TParameters_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TParameters_sw.ClassFromVar(
  const AClass: OleVariant): TParameters_sc;
begin
  Result := TParameters_sc(ConvClsFromVar(AClass, TParameters));
end;

{ TADOCommand_sw }

function TADOCommand_CommandTextAlias_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CommandTextAlias: string read <getter>...

  if IsGet then
    Result := TADOCommand_sacc(TADOCommand(AObj)).CommandTextAlias
  else
    TADOCommand_sacc(TADOCommand(AObj)).CommandTextAlias := string(AArgs[0]);
end;

function TADOCommand_ComponentRef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ComponentRef: TComponent read <getter>...

  if IsGet then
    Result := TComponent_sw.ToVar(TADOCommand_sacc(TADOCommand(AObj)).
      ComponentRef)
  else
    TADOCommand_sacc(TADOCommand(AObj)).ComponentRef := TComponent_sw.FromVar(
      AArgs[0]);
end;

function TADOCommand_Cancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Cancel;

  TADOCommand(AObj).Cancel();
end;

function TADOCommand_States_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property States: TObjectStates read <getter>;

  Result := TObjectStates_sw.ToVar(TADOCommand(AObj).States);
end;

function TADOCommand_CommandText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CommandText: WideString read <getter> write <set...

  if IsGet then
    Result := TADOCommand(AObj).CommandText
  else
    TADOCommand(AObj).CommandText := WideString(AArgs[0]);
end;

function TADOCommand_CommandTimeout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CommandTimeout: Integer read <getter> write <set...

  if IsGet then
    Result := TADOCommand(AObj).CommandTimeout
  else
    TADOCommand(AObj).CommandTimeout := Integer(AArgs[0]);
end;

function TADOCommand_CommandType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CommandType: TCommandType read <getter> write <s...

  if IsGet then
    Result := TCommandType_sw.ToVar(TADOCommand(AObj).CommandType)
  else
    TADOCommand(AObj).CommandType := TCommandType_sw.FromVar(AArgs[0]);
end;

function TADOCommand_Connection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Connection: TADOConnection read <getter> write <...

  if IsGet then
    Result := TADOConnection_sw.ToVar(TADOCommand(AObj).Connection)
  else
    TADOCommand(AObj).Connection := TADOConnection_sw.FromVar(AArgs[0]);
end;

function TADOCommand_ConnectionString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ConnectionString: WideString read <getter> write...

  if IsGet then
    Result := TADOCommand(AObj).ConnectionString
  else
    TADOCommand(AObj).ConnectionString := WideString(AArgs[0]);
end;

function TADOCommand_ExecuteOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExecuteOptions: TExecuteOptions read <getter> wr...

  if IsGet then
    Result := TExecuteOptions_sw.ToVar(TADOCommand(AObj).ExecuteOptions)
  else
    TADOCommand(AObj).ExecuteOptions := TExecuteOptions_sw.FromVar(AArgs[0]);
end;

function TADOCommand_Prepared_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Prepared: WordBool read <getter> write <setter>;

  if IsGet then
    Result := TADOCommand(AObj).Prepared
  else
    TADOCommand(AObj).Prepared := WordBool(AArgs[0]);
end;

function TADOCommand_Parameters_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Parameters: TParameters read <getter> write <set...

  if IsGet then
    Result := TParameters_sw.ToVar(TADOCommand(AObj).Parameters)
  else
    TADOCommand(AObj).Parameters := TParameters_sw.FromVar(AArgs[0]);
end;

function TADOCommand_ParamCheck_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParamCheck: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TADOCommand(AObj).ParamCheck
  else
    TADOCommand(AObj).ParamCheck := Boolean(AArgs[0]);
end;

class function TADOCommand_sw.GetTypeName: WideString;
begin
  Result := 'TADOCommand';
end;

class function TADOCommand_sw.GetWrappedClass: TClass;
begin
  Result := TADOCommand;
end;

class procedure TADOCommand_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('CommandTextAlias', TADOCommand_CommandTextAlias_si, string_sw, True, True, 0, True, False);
  AData.AddProperty('ComponentRef', TADOCommand_ComponentRef_si, TComponent_sw, True, True, 0, True, False);
  AData.AddProcedure('Cancel', TADOCommand_Cancel_si, 0, False);
  AData.AddProperty('States', TADOCommand_States_si, TObjectStates_sw, True, False, 0, False, False);
  AData.AddProperty('CommandText', TADOCommand_CommandText_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('CommandTimeout', TADOCommand_CommandTimeout_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('CommandType', TADOCommand_CommandType_si, TCommandType_sw, True, True, 0, False, False);
  AData.AddProperty('Connection', TADOCommand_Connection_si, TADOConnection_sw, True, True, 0, False, False);
  AData.AddProperty('ConnectionString', TADOCommand_ConnectionString_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('ExecuteOptions', TADOCommand_ExecuteOptions_si, TExecuteOptions_sw, True, True, 0, False, False);
  AData.AddProperty('Prepared', TADOCommand_Prepared_si, WordBool_sw, True, True, 0, False, False);
  AData.AddProperty('Parameters', TADOCommand_Parameters_si, TParameters_sw, True, True, 0, False, False);
  AData.AddProperty('ParamCheck', TADOCommand_ParamCheck_si, Boolean_sw, True, True, 0, False, False);
end;

class function TADOCommand_sw.ToVar(const AValue: TADOCommand): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TADOCommand_sw.FromVar(const AValue: OleVariant): TADOCommand;
begin
  Result := TADOCommand(ConvFromVar(AValue, TADOCommand));
end;

class function TADOCommand_sw.ClassToVar(AClass: TADOCommand_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TADOCommand_sw.ClassFromVar(
  const AClass: OleVariant): TADOCommand_sc;
begin
  Result := TADOCommand_sc(ConvClsFromVar(AClass, TADOCommand));
end;

{ TCursorOption_sw }

class function TCursorOption_sw.GetTypeName: WideString;
begin
  Result := 'TCursorOption';
end;

class procedure TCursorOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..12] of TLMDEnumerator = (
    (Name: 'coHoldRecords'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coHoldRecords)),
    (Name: 'coMovePrevious'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coMovePrevious)),
    (Name: 'coAddNew'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coAddNew)),
    (Name: 'coDelete'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coDelete)),
    (Name: 'coUpdate'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coUpdate)),
    (Name: 'coBookmark'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coBookmark)),
    (Name: 'coApproxPosition'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coApproxPosition)),
    (Name: 'coUpdateBatch'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coUpdateBatch)),
    (Name: 'coResync'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coResync)),
    (Name: 'coNotify'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coNotify)),
    (Name: 'coFind'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coFind)),
    (Name: 'coSeek'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coSeek)),
    (Name: 'coIndex'; Value: Integer({$IFDEF LMDSCT_12}TCursorOption.{$ENDIF}coIndex))
  );
begin
  AEnums := @ENUMS;
  ACount := 13;
end;

class function TCursorOption_sw.ToVar(const AValue: TCursorOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCursorOption_sw.FromVar(
  const AValue: OleVariant): TCursorOption;
begin
  Result := TCursorOption(Integer(AValue));
end;

{ TCursorOptions_sw }

class function TCursorOptions_sw.GetTypeName: WideString;
begin
  Result := 'TCursorOptions';
end;

class function TCursorOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TCursorOptions);
end;

class function TCursorOptions_sw.ToVar(
  const AValue: TCursorOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TCursorOptions_sw.FromVar(
  const AValue: OleVariant): TCursorOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TEventReason_sw }

class function TEventReason_sw.GetTypeName: WideString;
begin
  Result := 'TEventReason';
end;

class procedure TEventReason_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..14] of TLMDEnumerator = (
    (Name: 'erAddNew'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erAddNew)),
    (Name: 'erDelete'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erDelete)),
    (Name: 'erUpdate'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erUpdate)),
    (Name: 'erUndoUpdate'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erUndoUpdate)),
    (Name: 'erUndoAddNew'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erUndoAddNew)),
    (Name: 'erUndoDelete'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erUndoDelete)),
    (Name: 'erRequery'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erRequery)),
    (Name: 'erResynch'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erResynch)),
    (Name: 'erClose'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erClose)),
    (Name: 'erMove'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erMove)),
    (Name: 'erFirstChange'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erFirstChange)),
    (Name: 'erMoveFirst'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erMoveFirst)),
    (Name: 'erMoveNext'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erMoveNext)),
    (Name: 'erMovePrevious'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erMovePrevious)),
    (Name: 'erMoveLast'; Value: Integer({$IFDEF LMDSCT_12}TEventReason.{$ENDIF}erMoveLast))
  );
begin
  AEnums := @ENUMS;
  ACount := 15;
end;

class function TEventReason_sw.ToVar(const AValue: TEventReason): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TEventReason_sw.FromVar(const AValue: OleVariant): TEventReason;
begin
  Result := TEventReason(Integer(AValue));
end;

{ TFilterGroup_sw }

class function TFilterGroup_sw.GetTypeName: WideString;
begin
  Result := 'TFilterGroup';
end;

class procedure TFilterGroup_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..6] of TLMDEnumerator = (
    (Name: 'fgUnassigned'; Value: Integer({$IFDEF LMDSCT_12}TFilterGroup.{$ENDIF}fgUnassigned)),
    (Name: 'fgNone'; Value: Integer({$IFDEF LMDSCT_12}TFilterGroup.{$ENDIF}fgNone)),
    (Name: 'fgPendingRecords'; Value: Integer({$IFDEF LMDSCT_12}TFilterGroup.{$ENDIF}fgPendingRecords)),
    (Name: 'fgAffectedRecords'; Value: Integer({$IFDEF LMDSCT_12}TFilterGroup.{$ENDIF}fgAffectedRecords)),
    (Name: 'fgFetchedRecords'; Value: Integer({$IFDEF LMDSCT_12}TFilterGroup.{$ENDIF}fgFetchedRecords)),
    (Name: 'fgPredicate'; Value: Integer({$IFDEF LMDSCT_12}TFilterGroup.{$ENDIF}fgPredicate)),
    (Name: 'fgConflictingRecords'; Value: Integer({$IFDEF LMDSCT_12}TFilterGroup.{$ENDIF}fgConflictingRecords))
  );
begin
  AEnums := @ENUMS;
  ACount := 7;
end;

class function TFilterGroup_sw.ToVar(const AValue: TFilterGroup): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFilterGroup_sw.FromVar(const AValue: OleVariant): TFilterGroup;
begin
  Result := TFilterGroup(Integer(AValue));
end;

{ TMarshalOption_sw }

class function TMarshalOption_sw.GetTypeName: WideString;
begin
  Result := 'TMarshalOption';
end;

class procedure TMarshalOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'moMarshalAll'; Value: Integer({$IFDEF LMDSCT_12}TMarshalOption.{$ENDIF}moMarshalAll)),
    (Name: 'moMarshalModifiedOnly'; Value: Integer({$IFDEF LMDSCT_12}TMarshalOption.{$ENDIF}moMarshalModifiedOnly))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TMarshalOption_sw.ToVar(
  const AValue: TMarshalOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMarshalOption_sw.FromVar(
  const AValue: OleVariant): TMarshalOption;
begin
  Result := TMarshalOption(Integer(AValue));
end;

{ TRecordStatus_sw }

class function TRecordStatus_sw.GetTypeName: WideString;
begin
  Result := 'TRecordStatus';
end;

class procedure TRecordStatus_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..17] of TLMDEnumerator = (
    (Name: 'rsOK'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsOK)),
    (Name: 'rsNew'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsNew)),
    (Name: 'rsModified'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsModified)),
    (Name: 'rsDeleted'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsDeleted)),
    (Name: 'rsUnmodified'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsUnmodified)),
    (Name: 'rsInvalid'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsInvalid)),
    (Name: 'rsMultipleChanges'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsMultipleChanges)),
    (Name: 'rsPendingChanges'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsPendingChanges)),
    (Name: 'rsCanceled'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsCanceled)),
    (Name: 'rsCantRelease'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsCantRelease)),
    (Name: 'rsConcurrencyViolation'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsConcurrencyViolation)),
    (Name: 'rsIntegrityViolation'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsIntegrityViolation)),
    (Name: 'rsMaxChangesExceeded'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsMaxChangesExceeded)),
    (Name: 'rsObjectOpen'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsObjectOpen)),
    (Name: 'rsOutOfMemory'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsOutOfMemory)),
    (Name: 'rsPermissionDenied'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsPermissionDenied)),
    (Name: 'rsSchemaViolation'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsSchemaViolation)),
    (Name: 'rsDBDeleted'; Value: Integer({$IFDEF LMDSCT_12}TRecordStatus.{$ENDIF}rsDBDeleted))
  );
begin
  AEnums := @ENUMS;
  ACount := 18;
end;

class function TRecordStatus_sw.ToVar(const AValue: TRecordStatus): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TRecordStatus_sw.FromVar(
  const AValue: OleVariant): TRecordStatus;
begin
  Result := TRecordStatus(Integer(AValue));
end;

{ TRecordStatusSet_sw }

class function TRecordStatusSet_sw.GetTypeName: WideString;
begin
  Result := 'TRecordStatusSet';
end;

class function TRecordStatusSet_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TRecordStatusSet);
end;

class function TRecordStatusSet_sw.ToVar(
  const AValue: TRecordStatusSet): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TRecordStatusSet_sw.FromVar(
  const AValue: OleVariant): TRecordStatusSet;
begin
  ConvFromVar(AValue, @Result);
end;

{ TAffectRecords_sw }

class function TAffectRecords_sw.GetTypeName: WideString;
begin
  Result := 'TAffectRecords';
end;

class procedure TAffectRecords_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'arCurrent'; Value: Integer({$IFDEF LMDSCT_12}TAffectRecords.{$ENDIF}arCurrent)),
    (Name: 'arFiltered'; Value: Integer({$IFDEF LMDSCT_12}TAffectRecords.{$ENDIF}arFiltered)),
    (Name: 'arAll'; Value: Integer({$IFDEF LMDSCT_12}TAffectRecords.{$ENDIF}arAll)),
    (Name: 'arAllChapters'; Value: Integer({$IFDEF LMDSCT_12}TAffectRecords.{$ENDIF}arAllChapters))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TAffectRecords_sw.ToVar(
  const AValue: TAffectRecords): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TAffectRecords_sw.FromVar(
  const AValue: OleVariant): TAffectRecords;
begin
  Result := TAffectRecords(Integer(AValue));
end;

{ TPersistFormat_sw }

class function TPersistFormat_sw.GetTypeName: WideString;
begin
  Result := 'TPersistFormat';
end;

class procedure TPersistFormat_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'pfADTG'; Value: Integer({$IFDEF LMDSCT_12}TPersistFormat.{$ENDIF}pfADTG)),
    (Name: 'pfXML'; Value: Integer({$IFDEF LMDSCT_12}TPersistFormat.{$ENDIF}pfXML))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TPersistFormat_sw.ToVar(
  const AValue: TPersistFormat): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPersistFormat_sw.FromVar(
  const AValue: OleVariant): TPersistFormat;
begin
  Result := TPersistFormat(Integer(AValue));
end;

{ TSeekOption_sw }

class function TSeekOption_sw.GetTypeName: WideString;
begin
  Result := 'TSeekOption';
end;

class procedure TSeekOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'soFirstEQ'; Value: Integer({$IFDEF LMDSCT_12}TSeekOption.{$ENDIF}soFirstEQ)),
    (Name: 'soLastEQ'; Value: Integer({$IFDEF LMDSCT_12}TSeekOption.{$ENDIF}soLastEQ)),
    (Name: 'soAfterEQ'; Value: Integer({$IFDEF LMDSCT_12}TSeekOption.{$ENDIF}soAfterEQ)),
    (Name: 'soAfter'; Value: Integer({$IFDEF LMDSCT_12}TSeekOption.{$ENDIF}soAfter)),
    (Name: 'soBeforeEQ'; Value: Integer({$IFDEF LMDSCT_12}TSeekOption.{$ENDIF}soBeforeEQ)),
    (Name: 'soBefore'; Value: Integer({$IFDEF LMDSCT_12}TSeekOption.{$ENDIF}soBefore))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TSeekOption_sw.ToVar(const AValue: TSeekOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TSeekOption_sw.FromVar(const AValue: OleVariant): TSeekOption;
begin
  Result := TSeekOption(Integer(AValue));
end;

{ TWillChangeFieldEvent_sh }

function TWillChangeFieldEvent_sh.GetHandler: TMethod;
var
  hdr: TWillChangeFieldEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TWillChangeFieldEvent_sh.Handler(DataSet: TCustomADODataSet;
  const FieldCount: Integer; const Fields: OleVariant;
  var EventStatus: TEventStatus);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (DataSet: TCustomADODataSet; const FieldCount: ...

  v_1 := TEventStatus_sw.ToVar(EventStatus);
  args[0] := TCustomADODataSet_sw.ToVar(DataSet);
  args[1] := FieldCount;
  args[2] := Fields;
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  EventStatus := TEventStatus_sw.FromVar(v_1);
end;

{ TWillChangeFieldEvent_sw }

class function TWillChangeFieldEvent_sw.GetTypeName: WideString;
begin
  Result := 'TWillChangeFieldEvent';
end;

class function TWillChangeFieldEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TWillChangeFieldEvent_sh;
end;

class function TWillChangeFieldEvent_sw.ToVar(
  const AValue: TWillChangeFieldEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TWillChangeFieldEvent_sw.FromVar(
  const AValue: OleVariant): TWillChangeFieldEvent;
begin
  Result := TWillChangeFieldEvent(ConvFromVar(AValue));
end;

class function TWillChangeFieldEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TWillChangeFieldEvent;
var
  hdlr: TWillChangeFieldEvent_sh;
begin
  hdlr   := TWillChangeFieldEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TWillChangeFieldEvent_sw));
  Result := hdlr.Handler;
end;

{ TWillChangeRecordEvent_sh }

function TWillChangeRecordEvent_sh.GetHandler: TMethod;
var
  hdr: TWillChangeRecordEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TWillChangeRecordEvent_sh.Handler(DataSet: TCustomADODataSet;
  const Reason: TEventReason; const RecordCount: Integer;
  var EventStatus: TEventStatus);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (DataSet: TCustomADODataSet; const Reason: TEve...

  v_1 := TEventStatus_sw.ToVar(EventStatus);
  args[0] := TCustomADODataSet_sw.ToVar(DataSet);
  args[1] := TEventReason_sw.ToVar(Reason);
  args[2] := RecordCount;
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  EventStatus := TEventStatus_sw.FromVar(v_1);
end;

{ TWillChangeRecordEvent_sw }

class function TWillChangeRecordEvent_sw.GetTypeName: WideString;
begin
  Result := 'TWillChangeRecordEvent';
end;

class function TWillChangeRecordEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TWillChangeRecordEvent_sh;
end;

class function TWillChangeRecordEvent_sw.ToVar(
  const AValue: TWillChangeRecordEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TWillChangeRecordEvent_sw.FromVar(
  const AValue: OleVariant): TWillChangeRecordEvent;
begin
  Result := TWillChangeRecordEvent(ConvFromVar(AValue));
end;

class function TWillChangeRecordEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TWillChangeRecordEvent;
var
  hdlr: TWillChangeRecordEvent_sh;
begin
  hdlr   := TWillChangeRecordEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TWillChangeRecordEvent_sw));
  Result := hdlr.Handler;
end;

{ TEndOfRecordsetEvent_sh }

function TEndOfRecordsetEvent_sh.GetHandler: TMethod;
var
  hdr: TEndOfRecordsetEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TEndOfRecordsetEvent_sh.Handler(DataSet: TCustomADODataSet;
  var MoreData: WordBool; var EventStatus: TEventStatus);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure (DataSet: TCustomADODataSet; var MoreData: Word...

  v_1 := MoreData;
  v_2 := TEventStatus_sw.ToVar(EventStatus);
  args[0] := TCustomADODataSet_sw.ToVar(DataSet);
  args[1] := MakeVarRef(v_1);
  args[2] := MakeVarRef(v_2);
  Self.Owner.RunProc(Self.ProcName, args);
  MoreData := WordBool(v_1);
  EventStatus := TEventStatus_sw.FromVar(v_2);
end;

{ TEndOfRecordsetEvent_sw }

class function TEndOfRecordsetEvent_sw.GetTypeName: WideString;
begin
  Result := 'TEndOfRecordsetEvent';
end;

class function TEndOfRecordsetEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TEndOfRecordsetEvent_sh;
end;

class function TEndOfRecordsetEvent_sw.ToVar(
  const AValue: TEndOfRecordsetEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TEndOfRecordsetEvent_sw.FromVar(
  const AValue: OleVariant): TEndOfRecordsetEvent;
begin
  Result := TEndOfRecordsetEvent(ConvFromVar(AValue));
end;

class function TEndOfRecordsetEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TEndOfRecordsetEvent;
var
  hdlr: TEndOfRecordsetEvent_sh;
begin
  hdlr   := TEndOfRecordsetEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TEndOfRecordsetEvent_sw));
  Result := hdlr.Handler;
end;

{ TFetchProgressEvent_sh }

function TFetchProgressEvent_sh.GetHandler: TMethod;
var
  hdr: TFetchProgressEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFetchProgressEvent_sh.Handler(DataSet: TCustomADODataSet;
  Progress: Integer; MaxProgress: Integer; var EventStatus: TEventStatus);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (DataSet: TCustomADODataSet; Progress: Integer;...

  v_1 := TEventStatus_sw.ToVar(EventStatus);
  args[0] := TCustomADODataSet_sw.ToVar(DataSet);
  args[1] := Progress;
  args[2] := MaxProgress;
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  EventStatus := TEventStatus_sw.FromVar(v_1);
end;

{ TFetchProgressEvent_sw }

class function TFetchProgressEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFetchProgressEvent';
end;

class function TFetchProgressEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFetchProgressEvent_sh;
end;

class function TFetchProgressEvent_sw.ToVar(
  const AValue: TFetchProgressEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFetchProgressEvent_sw.FromVar(
  const AValue: OleVariant): TFetchProgressEvent;
begin
  Result := TFetchProgressEvent(ConvFromVar(AValue));
end;

class function TFetchProgressEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TFetchProgressEvent;
var
  hdlr: TFetchProgressEvent_sh;
begin
  hdlr   := TFetchProgressEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TFetchProgressEvent_sw));
  Result := hdlr.Handler;
end;

{ TRecordsetReasonEvent_sh }

function TRecordsetReasonEvent_sh.GetHandler: TMethod;
var
  hdr: TRecordsetReasonEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TRecordsetReasonEvent_sh.Handler(DataSet: TCustomADODataSet;
  const Reason: TEventReason; var EventStatus: TEventStatus);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (DataSet: TCustomADODataSet; const Reason: TEve...

  v_1 := TEventStatus_sw.ToVar(EventStatus);
  args[0] := TCustomADODataSet_sw.ToVar(DataSet);
  args[1] := TEventReason_sw.ToVar(Reason);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  EventStatus := TEventStatus_sw.FromVar(v_1);
end;

{ TRecordsetReasonEvent_sw }

class function TRecordsetReasonEvent_sw.GetTypeName: WideString;
begin
  Result := 'TRecordsetReasonEvent';
end;

class function TRecordsetReasonEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TRecordsetReasonEvent_sh;
end;

class function TRecordsetReasonEvent_sw.ToVar(
  const AValue: TRecordsetReasonEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TRecordsetReasonEvent_sw.FromVar(
  const AValue: OleVariant): TRecordsetReasonEvent;
begin
  Result := TRecordsetReasonEvent(ConvFromVar(AValue));
end;

class function TRecordsetReasonEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TRecordsetReasonEvent;
var
  hdlr: TRecordsetReasonEvent_sh;
begin
  hdlr   := TRecordsetReasonEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TRecordsetReasonEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomADODataSet_sw }

function TCustomADODataSet_MasterDataLink_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MasterDataLink: TMasterDataLink read <...

  Result := TMasterDataLink_sw.ToVar(TCustomADODataSet_sacc(TCustomADODataSet(
    AObj)).MasterDataLink);
end;

function TCustomADODataSet_Command_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Command: TADOCommand read <getter>;

  Result := TADOCommand_sw.ToVar(TCustomADODataSet_sacc(TCustomADODataSet(
    AObj)).Command);
end;

function TCustomADODataSet_CommandText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CommandText: WideString read <getter> ...

  if IsGet then
    Result := TCustomADODataSet_sacc(TCustomADODataSet(AObj)).CommandText
  else
    TCustomADODataSet_sacc(TCustomADODataSet(AObj)).CommandText := WideString(
      AArgs[0]);
end;

function TCustomADODataSet_CommandTimeout_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CommandTimeout: Integer read <getter> ...

  if IsGet then
    Result := TCustomADODataSet_sacc(TCustomADODataSet(AObj)).CommandTimeout
  else
    TCustomADODataSet_sacc(TCustomADODataSet(AObj)).CommandTimeout := Integer(
      AArgs[0]);
end;

function TCustomADODataSet_CommandType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CommandType: TCommandType read <getter...

  if IsGet then
    Result := TCommandType_sw.ToVar(TCustomADODataSet_sacc(TCustomADODataSet(
      AObj)).CommandType)
  else
    TCustomADODataSet_sacc(TCustomADODataSet(AObj)).CommandType := 
      TCommandType_sw.FromVar(AArgs[0]);
end;

function TCustomADODataSet_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DataSource: TDataSource read <getter> ...

  if IsGet then
    Result := TDataSource_sw.ToVar(TCustomADODataSet_sacc(TCustomADODataSet(
      AObj)).DataSource)
  else
    TCustomADODataSet_sacc(TCustomADODataSet(AObj)).DataSource := 
      TDataSource_sw.FromVar(AArgs[0]);
end;

function TCustomADODataSet_IndexDefs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property IndexDefs: TIndexDefs read <getter> wr...

  if IsGet then
    Result := TIndexDefs_sw.ToVar(TCustomADODataSet_sacc(TCustomADODataSet(
      AObj)).IndexDefs)
  else
    TCustomADODataSet_sacc(TCustomADODataSet(AObj)).IndexDefs := TIndexDefs_sw.
      FromVar(AArgs[0]);
end;

function TCustomADODataSet_IndexFieldNames_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property IndexFieldNames: string read <getter> ...

  if IsGet then
    Result := TCustomADODataSet_sacc(TCustomADODataSet(AObj)).IndexFieldNames
  else
    TCustomADODataSet_sacc(TCustomADODataSet(AObj)).IndexFieldNames := string(
      AArgs[0]);
end;

function TCustomADODataSet_MasterFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MasterFields: string read <getter> wri...

  if IsGet then
    Result := TCustomADODataSet_sacc(TCustomADODataSet(AObj)).MasterFields
  else
    TCustomADODataSet_sacc(TCustomADODataSet(AObj)).MasterFields := string(
      AArgs[0]);
end;

function TCustomADODataSet_ParamCheck_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ParamCheck: Boolean read <getter> writ...

  if IsGet then
    Result := TCustomADODataSet_sacc(TCustomADODataSet(AObj)).ParamCheck
  else
    TCustomADODataSet_sacc(TCustomADODataSet(AObj)).ParamCheck := Boolean(
      AArgs[0]);
end;

function TCustomADODataSet_Parameters_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Parameters: TParameters read <getter> ...

  if IsGet then
    Result := TParameters_sw.ToVar(TCustomADODataSet_sacc(TCustomADODataSet(
      AObj)).Parameters)
  else
    TCustomADODataSet_sacc(TCustomADODataSet(AObj)).Parameters := 
      TParameters_sw.FromVar(AArgs[0]);
end;

function TCustomADODataSet_Prepared_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Prepared: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomADODataSet_sacc(TCustomADODataSet(AObj)).Prepared
  else
    TCustomADODataSet_sacc(TCustomADODataSet(AObj)).Prepared := Boolean(
      AArgs[0]);
end;

function TCustomADODataSet_StoreDefs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property StoreDefs: Boolean read <getter> write...

  if IsGet then
    Result := TCustomADODataSet_sacc(TCustomADODataSet(AObj)).StoreDefs
  else
    TCustomADODataSet_sacc(TCustomADODataSet(AObj)).StoreDefs := Boolean(
      AArgs[0]);
end;

function TCustomADODataSet_CancelBatch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CancelBatch(AffectRecords: TAffectRecords);

  case AArgsSize of
    0:
    begin
      TCustomADODataSet(AObj).CancelBatch();
    end;
    1:
    begin
      TCustomADODataSet(AObj).CancelBatch(TAffectRecords_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('CancelBatch');
  end;
end;

function TCustomADODataSet_CancelUpdates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CancelUpdates;

  TCustomADODataSet(AObj).CancelUpdates();
end;

function TCustomADODataSet_Clone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clone(Source: TCustomADODataSet; LockType: TADO...

  case AArgsSize of
    1:
    begin
      TCustomADODataSet(AObj).Clone(TCustomADODataSet_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      TCustomADODataSet(AObj).Clone(TCustomADODataSet_sw.FromVar(AArgs[0]), 
        TADOLockType_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('Clone');
  end;
end;

function TCustomADODataSet_DeleteRecords_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DeleteRecords(AffectRecords: TAffectRecords);

  case AArgsSize of
    0:
    begin
      TCustomADODataSet(AObj).DeleteRecords();
    end;
    1:
    begin
      TCustomADODataSet(AObj).DeleteRecords(TAffectRecords_sw.FromVar(
        AArgs[0]));
    end;
  else
    WrongArgCountError('DeleteRecords');
  end;
end;

function TCustomADODataSet_EnableBCD_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EnableBCD: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomADODataSet(AObj).EnableBCD
  else
    TCustomADODataSet(AObj).EnableBCD := Boolean(AArgs[0]);
end;

function TCustomADODataSet_LoadFromFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromFile(const FileName: WideString);

  TCustomADODataSet(AObj).LoadFromFile(WideString(AArgs[0]));
end;

function TCustomADODataSet_Requery_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Requery(Options: TExecuteOptions);

  case AArgsSize of
    0:
    begin
      TCustomADODataSet(AObj).Requery();
    end;
    1:
    begin
      TCustomADODataSet(AObj).Requery(TExecuteOptions_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Requery');
  end;
end;

function TCustomADODataSet_SaveToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToFile(const FileName: WideString; Format: ...

  case AArgsSize of
    0:
    begin
      TCustomADODataSet(AObj).SaveToFile();
    end;
    1:
    begin
      TCustomADODataSet(AObj).SaveToFile(WideString(AArgs[0]));
    end;
    2:
    begin
      TCustomADODataSet(AObj).SaveToFile(WideString(AArgs[0]), 
        TPersistFormat_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('SaveToFile');
  end;
end;

function TCustomADODataSet_Seek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Seek(const KeyValues: Variant; SeekOption: TSeek...

  case AArgsSize of
    1:
    begin
      Result := TCustomADODataSet(AObj).Seek(Variant(FindVarData(AArgs[0])^));
    end;
    2:
    begin
      Result := TCustomADODataSet(AObj).Seek(Variant(FindVarData(AArgs[0])^), 
        TSeekOption_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('Seek');
  end;
end;

function TCustomADODataSet_Supports_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Supports(CursorOptions: TCursorOptions): Boolean;

  Result := TCustomADODataSet(AObj).Supports(TCursorOptions_sw.FromVar(
    AArgs[0]));
end;

function TCustomADODataSet_UpdateBatch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UpdateBatch(AffectRecords: TAffectRecords);

  case AArgsSize of
    0:
    begin
      TCustomADODataSet(AObj).UpdateBatch();
    end;
    1:
    begin
      TCustomADODataSet(AObj).UpdateBatch(TAffectRecords_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('UpdateBatch');
  end;
end;

function TCustomADODataSet_DesignerData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DesignerData: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomADODataSet(AObj).DesignerData
  else
    TCustomADODataSet(AObj).DesignerData := string(AArgs[0]);
end;

function TCustomADODataSet_IndexName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexName: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomADODataSet(AObj).IndexName
  else
    TCustomADODataSet(AObj).IndexName := string(AArgs[0]);
end;

function TCustomADODataSet_IndexFieldCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexFieldCount: Integer read <getter>;

  Result := TCustomADODataSet(AObj).IndexFieldCount;
end;

function TCustomADODataSet_IndexFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexFields[Index: Integer]: TField read <getter...

  if IsGet then
    Result := TField_sw.ToVar(TCustomADODataSet(AObj).IndexFields[Integer(
      AArgs[0])])
  else
    TCustomADODataSet(AObj).IndexFields[Integer(AArgs[0])] := TField_sw.FromVar(
      AArgs[1]);
end;

function TCustomADODataSet_FilterGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FilterGroup: TFilterGroup read <getter> write <s...

  if IsGet then
    Result := TFilterGroup_sw.ToVar(TCustomADODataSet(AObj).FilterGroup)
  else
    TCustomADODataSet(AObj).FilterGroup := TFilterGroup_sw.FromVar(AArgs[0]);
end;

function TCustomADODataSet_RecordsetState_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RecordsetState: TObjectStates read <getter>;

  Result := TObjectStates_sw.ToVar(TCustomADODataSet(AObj).RecordsetState);
end;

function TCustomADODataSet_RecordStatus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RecordStatus: TRecordStatusSet read <getter>;

  Result := TRecordStatusSet_sw.ToVar(TCustomADODataSet(AObj).RecordStatus);
end;

function TCustomADODataSet_Sort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Sort: WideString read <getter> write <setter>;

  if IsGet then
    Result := TCustomADODataSet(AObj).Sort
  else
    TCustomADODataSet(AObj).Sort := WideString(AArgs[0]);
end;

function TCustomADODataSet_CacheSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CacheSize: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomADODataSet(AObj).CacheSize
  else
    TCustomADODataSet(AObj).CacheSize := Integer(AArgs[0]);
end;

function TCustomADODataSet_Connection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Connection: TADOConnection read <getter> write <...

  if IsGet then
    Result := TADOConnection_sw.ToVar(TCustomADODataSet(AObj).Connection)
  else
    TCustomADODataSet(AObj).Connection := TADOConnection_sw.FromVar(AArgs[0]);
end;

function TCustomADODataSet_ConnectionString_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ConnectionString: WideString read <getter> write...

  if IsGet then
    Result := TCustomADODataSet(AObj).ConnectionString
  else
    TCustomADODataSet(AObj).ConnectionString := WideString(AArgs[0]);
end;

function TCustomADODataSet_CursorLocation_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CursorLocation: TCursorLocation read <getter> wr...

  if IsGet then
    Result := TCursorLocation_sw.ToVar(TCustomADODataSet(AObj).CursorLocation)
  else
    TCustomADODataSet(AObj).CursorLocation := TCursorLocation_sw.FromVar(
      AArgs[0]);
end;

function TCustomADODataSet_CursorType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CursorType: TCursorType read <getter> write <set...

  if IsGet then
    Result := TCursorType_sw.ToVar(TCustomADODataSet(AObj).CursorType)
  else
    TCustomADODataSet(AObj).CursorType := TCursorType_sw.FromVar(AArgs[0]);
end;

function TCustomADODataSet_ExecuteOptions_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExecuteOptions: TExecuteOptions read <getter> wr...

  if IsGet then
    Result := TExecuteOptions_sw.ToVar(TCustomADODataSet(AObj).ExecuteOptions)
  else
    TCustomADODataSet(AObj).ExecuteOptions := TExecuteOptions_sw.FromVar(
      AArgs[0]);
end;

function TCustomADODataSet_LockType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LockType: TADOLockType read <getter> write <sett...

  if IsGet then
    Result := TADOLockType_sw.ToVar(TCustomADODataSet(AObj).LockType)
  else
    TCustomADODataSet(AObj).LockType := TADOLockType_sw.FromVar(AArgs[0]);
end;

function TCustomADODataSet_MarshalOptions_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MarshalOptions: TMarshalOption read <getter> wri...

  if IsGet then
    Result := TMarshalOption_sw.ToVar(TCustomADODataSet(AObj).MarshalOptions)
  else
    TCustomADODataSet(AObj).MarshalOptions := TMarshalOption_sw.FromVar(
      AArgs[0]);
end;

function TCustomADODataSet_MaxRecords_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxRecords: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomADODataSet(AObj).MaxRecords
  else
    TCustomADODataSet(AObj).MaxRecords := Integer(AArgs[0]);
end;

function TCustomADODataSet_OnWillChangeField_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnWillChangeField: TWillChangeFieldEvent read <g...

  if IsGet then
    Result := TWillChangeFieldEvent_sw.ToVar(TCustomADODataSet(AObj).
      OnWillChangeField)
  else
    TCustomADODataSet(AObj).OnWillChangeField := TWillChangeFieldEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomADODataSet_OnWillChangeRecord_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnWillChangeRecord: TWillChangeRecordEvent read ...

  if IsGet then
    Result := TWillChangeRecordEvent_sw.ToVar(TCustomADODataSet(AObj).
      OnWillChangeRecord)
  else
    TCustomADODataSet(AObj).OnWillChangeRecord := TWillChangeRecordEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomADODataSet_OnWillChangeRecordset_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnWillChangeRecordset: TRecordsetReasonEvent rea...

  if IsGet then
    Result := TRecordsetReasonEvent_sw.ToVar(TCustomADODataSet(AObj).
      OnWillChangeRecordset)
  else
    TCustomADODataSet(AObj).OnWillChangeRecordset := TRecordsetReasonEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomADODataSet_OnWillMove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnWillMove: TRecordsetReasonEvent read <getter> ...

  if IsGet then
    Result := TRecordsetReasonEvent_sw.ToVar(TCustomADODataSet(AObj).OnWillMove)
  else
    TCustomADODataSet(AObj).OnWillMove := TRecordsetReasonEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomADODataSet_OnEndOfRecordset_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnEndOfRecordset: TEndOfRecordsetEvent read <get...

  if IsGet then
    Result := TEndOfRecordsetEvent_sw.ToVar(TCustomADODataSet(AObj).
      OnEndOfRecordset)
  else
    TCustomADODataSet(AObj).OnEndOfRecordset := TEndOfRecordsetEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomADODataSet_OnFetchProgress_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFetchProgress: TFetchProgressEvent read <gette...

  if IsGet then
    Result := TFetchProgressEvent_sw.ToVar(TCustomADODataSet(AObj).
      OnFetchProgress)
  else
    TCustomADODataSet(AObj).OnFetchProgress := TFetchProgressEvent_sw.FromVar(
      AArgs[0]);
end;

class function TCustomADODataSet_sw.GetTypeName: WideString;
begin
  Result := 'TCustomADODataSet';
end;

class function TCustomADODataSet_sw.GetWrappedClass: TClass;
begin
  Result := TCustomADODataSet;
end;

class procedure TCustomADODataSet_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('MasterDataLink', TCustomADODataSet_MasterDataLink_si, TMasterDataLink_sw, True, False, 0, True, False);
  AData.AddProperty('Command', TCustomADODataSet_Command_si, TADOCommand_sw, True, False, 0, True, False);
  AData.AddProperty('CommandText', TCustomADODataSet_CommandText_si, WideString_sw, True, True, 0, True, False);
  AData.AddProperty('CommandTimeout', TCustomADODataSet_CommandTimeout_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('CommandType', TCustomADODataSet_CommandType_si, TCommandType_sw, True, True, 0, True, False);
  AData.AddProperty('DataSource', TCustomADODataSet_DataSource_si, TDataSource_sw, True, True, 0, True, False);
  AData.AddProperty('IndexDefs', TCustomADODataSet_IndexDefs_si, TIndexDefs_sw, True, True, 0, True, False);
  AData.AddProperty('IndexFieldNames', TCustomADODataSet_IndexFieldNames_si, string_sw, True, True, 0, True, False);
  AData.AddProperty('MasterFields', TCustomADODataSet_MasterFields_si, string_sw, True, True, 0, True, False);
  AData.AddProperty('ParamCheck', TCustomADODataSet_ParamCheck_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Parameters', TCustomADODataSet_Parameters_si, TParameters_sw, True, True, 0, True, False);
  AData.AddProperty('Prepared', TCustomADODataSet_Prepared_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('StoreDefs', TCustomADODataSet_StoreDefs_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProcedure('CancelBatch', TCustomADODataSet_CancelBatch_si, 0, True);
  AData.AddProcedure('CancelUpdates', TCustomADODataSet_CancelUpdates_si, 0, False);
  AData.AddProcedure('Clone', TCustomADODataSet_Clone_si, 1, True);
  AData.AddProcedure('DeleteRecords', TCustomADODataSet_DeleteRecords_si, 0, True);
  AData.AddProperty('EnableBCD', TCustomADODataSet_EnableBCD_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProcedure('LoadFromFile', TCustomADODataSet_LoadFromFile_si, 1, False);
  AData.AddProcedure('Requery', TCustomADODataSet_Requery_si, 0, True);
  AData.AddProcedure('SaveToFile', TCustomADODataSet_SaveToFile_si, 0, True);
  AData.AddFunction('Seek', TCustomADODataSet_Seek_si, Boolean_sw, 1, True);
  AData.AddFunction('Supports', TCustomADODataSet_Supports_si, Boolean_sw, 1, False);
  AData.AddProcedure('UpdateBatch', TCustomADODataSet_UpdateBatch_si, 0, True);
  AData.AddProperty('DesignerData', TCustomADODataSet_DesignerData_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('IndexName', TCustomADODataSet_IndexName_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('IndexFieldCount', TCustomADODataSet_IndexFieldCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('IndexFields', TCustomADODataSet_IndexFields_si, TField_sw, True, True, 1, False, False);
  AData.AddProperty('FilterGroup', TCustomADODataSet_FilterGroup_si, TFilterGroup_sw, True, True, 0, False, False);
  AData.AddProperty('RecordsetState', TCustomADODataSet_RecordsetState_si, TObjectStates_sw, True, False, 0, False, False);
  AData.AddProperty('RecordStatus', TCustomADODataSet_RecordStatus_si, TRecordStatusSet_sw, True, False, 0, False, False);
  AData.AddProperty('Sort', TCustomADODataSet_Sort_si, WideString_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Active', False);
  AData.AddPropertyRedecl('AutoCalcFields', False);
  AData.AddProperty('CacheSize', TCustomADODataSet_CacheSize_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Connection', TCustomADODataSet_Connection_si, TADOConnection_sw, True, True, 0, False, False);
  AData.AddProperty('ConnectionString', TCustomADODataSet_ConnectionString_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('CursorLocation', TCustomADODataSet_CursorLocation_si, TCursorLocation_sw, True, True, 0, False, False);
  AData.AddProperty('CursorType', TCustomADODataSet_CursorType_si, TCursorType_sw, True, True, 0, False, False);
  AData.AddProperty('ExecuteOptions', TCustomADODataSet_ExecuteOptions_si, TExecuteOptions_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Filter', False);
  AData.AddPropertyRedecl('Filtered', False);
  AData.AddProperty('LockType', TCustomADODataSet_LockType_si, TADOLockType_sw, True, True, 0, False, False);
  AData.AddProperty('MarshalOptions', TCustomADODataSet_MarshalOptions_si, TMarshalOption_sw, True, True, 0, False, False);
  AData.AddProperty('MaxRecords', TCustomADODataSet_MaxRecords_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('BeforeOpen', False);
  AData.AddPropertyRedecl('AfterOpen', False);
  AData.AddPropertyRedecl('BeforeClose', False);
  AData.AddPropertyRedecl('AfterClose', False);
  AData.AddPropertyRedecl('BeforeInsert', False);
  AData.AddPropertyRedecl('AfterInsert', False);
  AData.AddPropertyRedecl('BeforeEdit', False);
  AData.AddPropertyRedecl('AfterEdit', False);
  AData.AddPropertyRedecl('BeforePost', False);
  AData.AddPropertyRedecl('AfterPost', False);
  AData.AddPropertyRedecl('BeforeCancel', False);
  AData.AddPropertyRedecl('AfterCancel', False);
  AData.AddPropertyRedecl('BeforeDelete', False);
  AData.AddPropertyRedecl('AfterDelete', False);
  AData.AddPropertyRedecl('BeforeScroll', False);
  AData.AddPropertyRedecl('AfterScroll', False);
  AData.AddPropertyRedecl('BeforeRefresh', False);
  AData.AddPropertyRedecl('AfterRefresh', False);
  AData.AddPropertyRedecl('OnCalcFields', False);
  AData.AddPropertyRedecl('OnDeleteError', False);
  AData.AddPropertyRedecl('OnEditError', False);
  AData.AddPropertyRedecl('OnFilterRecord', False);
  AData.AddPropertyRedecl('OnNewRecord', False);
  AData.AddPropertyRedecl('OnPostError', False);
  AData.AddProperty('OnWillChangeField', TCustomADODataSet_OnWillChangeField_si, TWillChangeFieldEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnWillChangeRecord', TCustomADODataSet_OnWillChangeRecord_si, TWillChangeRecordEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnWillChangeRecordset', TCustomADODataSet_OnWillChangeRecordset_si, TRecordsetReasonEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnWillMove', TCustomADODataSet_OnWillMove_si, TRecordsetReasonEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnEndOfRecordset', TCustomADODataSet_OnEndOfRecordset_si, TEndOfRecordsetEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnFetchProgress', TCustomADODataSet_OnFetchProgress_si, TFetchProgressEvent_sw, True, True, 0, False, False);
end;

class function TCustomADODataSet_sw.ToVar(
  const AValue: TCustomADODataSet): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomADODataSet_sw.FromVar(
  const AValue: OleVariant): TCustomADODataSet;
begin
  Result := TCustomADODataSet(ConvFromVar(AValue, TCustomADODataSet));
end;

class function TCustomADODataSet_sw.ClassToVar(
  AClass: TCustomADODataSet_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomADODataSet_sw.ClassFromVar(
  const AClass: OleVariant): TCustomADODataSet_sc;
begin
  Result := TCustomADODataSet_sc(ConvClsFromVar(AClass, TCustomADODataSet));
end;

{ TADODataSet_sw }

function TADODataSet_CreateDataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CreateDataSet;

  TADODataSet(AObj).CreateDataSet();
end;

function TADODataSet_GetIndexNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetIndexNames(List: TStrings);

  TADODataSet(AObj).GetIndexNames(TStrings_sw.FromVar(AArgs[0]));
end;

function TADODataSet_RDSConnection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RDSConnection: TRDSConnection read <getter> writ...

  if IsGet then
    Result := TRDSConnection_sw.ToVar(TADODataSet(AObj).RDSConnection)
  else
    TADODataSet(AObj).RDSConnection := TRDSConnection_sw.FromVar(AArgs[0]);
end;

class function TADODataSet_sw.GetTypeName: WideString;
begin
  Result := 'TADODataSet';
end;

class function TADODataSet_sw.GetWrappedClass: TClass;
begin
  Result := TADODataSet;
end;

class procedure TADODataSet_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('CreateDataSet', TADODataSet_CreateDataSet_si, 0, False);
  AData.AddProcedure('GetIndexNames', TADODataSet_GetIndexNames_si, 1, False);
  AData.AddPropertyRedecl('IndexDefs', False);
  AData.AddPropertyRedecl('CommandText', False);
  AData.AddPropertyRedecl('CommandTimeout', False);
  AData.AddPropertyRedecl('CommandType', False);
  AData.AddPropertyRedecl('DataSetField', False);
  AData.AddPropertyRedecl('DataSource', False);
  AData.AddPropertyRedecl('EnableBCD', False);
  AData.AddPropertyRedecl('FieldDefs', False);
  AData.AddPropertyRedecl('IndexName', False);
  AData.AddPropertyRedecl('IndexFieldNames', False);
  AData.AddPropertyRedecl('MasterFields', False);
  AData.AddPropertyRedecl('ParamCheck', False);
  AData.AddPropertyRedecl('Parameters', False);
  AData.AddPropertyRedecl('Prepared', False);
  AData.AddProperty('RDSConnection', TADODataSet_RDSConnection_si, TRDSConnection_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('StoreDefs', False);
  AData.AddPropertyRedecl('BeforeOpen', False);
  AData.AddPropertyRedecl('AfterOpen', False);
  AData.AddPropertyRedecl('BeforeClose', False);
  AData.AddPropertyRedecl('AfterClose', False);
  AData.AddPropertyRedecl('BeforeInsert', False);
  AData.AddPropertyRedecl('AfterInsert', False);
  AData.AddPropertyRedecl('BeforeEdit', False);
  AData.AddPropertyRedecl('AfterEdit', False);
  AData.AddPropertyRedecl('BeforePost', False);
  AData.AddPropertyRedecl('AfterPost', False);
  AData.AddPropertyRedecl('BeforeCancel', False);
  AData.AddPropertyRedecl('AfterCancel', False);
  AData.AddPropertyRedecl('BeforeDelete', False);
  AData.AddPropertyRedecl('AfterDelete', False);
  AData.AddPropertyRedecl('BeforeScroll', False);
  AData.AddPropertyRedecl('AfterScroll', False);
  AData.AddPropertyRedecl('OnCalcFields', False);
  AData.AddPropertyRedecl('OnDeleteError', False);
  AData.AddPropertyRedecl('OnEditError', False);
  AData.AddPropertyRedecl('OnNewRecord', False);
  AData.AddPropertyRedecl('OnPostError', False);
end;

class function TADODataSet_sw.ToVar(const AValue: TADODataSet): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TADODataSet_sw.FromVar(const AValue: OleVariant): TADODataSet;
begin
  Result := TADODataSet(ConvFromVar(AValue, TADODataSet));
end;

class function TADODataSet_sw.ClassToVar(AClass: TADODataSet_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TADODataSet_sw.ClassFromVar(
  const AClass: OleVariant): TADODataSet_sc;
begin
  Result := TADODataSet_sc(ConvClsFromVar(AClass, TADODataSet));
end;

{ TADOTable_sw }

function TADOTable_GetIndexNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetIndexNames(List: TStrings);

  TADOTable(AObj).GetIndexNames(TStrings_sw.FromVar(AArgs[0]));
end;

function TADOTable_MasterSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MasterSource: TDataSource read <getter> write <s...

  if IsGet then
    Result := TDataSource_sw.ToVar(TADOTable(AObj).MasterSource)
  else
    TADOTable(AObj).MasterSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TADOTable_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TADOTable(AObj).ReadOnly
  else
    TADOTable(AObj).ReadOnly := Boolean(AArgs[0]);
end;

function TADOTable_TableDirect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TableDirect: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TADOTable(AObj).TableDirect
  else
    TADOTable(AObj).TableDirect := Boolean(AArgs[0]);
end;

function TADOTable_TableName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TableName: WideString read <getter> write <setter>;

  if IsGet then
    Result := TADOTable(AObj).TableName
  else
    TADOTable(AObj).TableName := WideString(AArgs[0]);
end;

class function TADOTable_sw.GetTypeName: WideString;
begin
  Result := 'TADOTable';
end;

class function TADOTable_sw.GetWrappedClass: TClass;
begin
  Result := TADOTable;
end;

class procedure TADOTable_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('GetIndexNames', TADOTable_GetIndexNames_si, 1, False);
  AData.AddPropertyRedecl('IndexDefs', False);
  AData.AddPropertyRedecl('CommandTimeout', False);
  AData.AddPropertyRedecl('EnableBCD', False);
  AData.AddPropertyRedecl('IndexFieldNames', False);
  AData.AddPropertyRedecl('IndexName', False);
  AData.AddPropertyRedecl('MasterFields', False);
  AData.AddProperty('MasterSource', TADOTable_MasterSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddProperty('ReadOnly', TADOTable_ReadOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('TableDirect', TADOTable_TableDirect_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('TableName', TADOTable_TableName_si, WideString_sw, True, True, 0, False, False);
end;

class function TADOTable_sw.ToVar(const AValue: TADOTable): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TADOTable_sw.FromVar(const AValue: OleVariant): TADOTable;
begin
  Result := TADOTable(ConvFromVar(AValue, TADOTable));
end;

class function TADOTable_sw.ClassToVar(AClass: TADOTable_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TADOTable_sw.ClassFromVar(
  const AClass: OleVariant): TADOTable_sc;
begin
  Result := TADOTable_sc(ConvClsFromVar(AClass, TADOTable));
end;

{ TADOQuery_sw }

function TADOQuery_ExecSQL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExecSQL: Integer;

  Result := TADOQuery(AObj).ExecSQL();
end;

function TADOQuery_RowsAffected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RowsAffected: Integer read <getter>;

  Result := TADOQuery(AObj).RowsAffected;
end;

function TADOQuery_SQL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SQL: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TADOQuery(AObj).SQL)
  else
    TADOQuery(AObj).SQL := TStrings_sw.FromVar(AArgs[0]);
end;

class function TADOQuery_sw.GetTypeName: WideString;
begin
  Result := 'TADOQuery';
end;

class function TADOQuery_sw.GetWrappedClass: TClass;
begin
  Result := TADOQuery;
end;

class procedure TADOQuery_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('ExecSQL', TADOQuery_ExecSQL_si, Integer_sw, 0, False);
  AData.AddProperty('RowsAffected', TADOQuery_RowsAffected_si, Integer_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('CommandTimeout', False);
  AData.AddPropertyRedecl('DataSource', False);
  AData.AddPropertyRedecl('EnableBCD', False);
  AData.AddPropertyRedecl('ParamCheck', False);
  AData.AddPropertyRedecl('Parameters', False);
  AData.AddPropertyRedecl('Prepared', False);
  AData.AddProperty('SQL', TADOQuery_SQL_si, TStrings_sw, True, True, 0, False, False);
end;

class function TADOQuery_sw.ToVar(const AValue: TADOQuery): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TADOQuery_sw.FromVar(const AValue: OleVariant): TADOQuery;
begin
  Result := TADOQuery(ConvFromVar(AValue, TADOQuery));
end;

class function TADOQuery_sw.ClassToVar(AClass: TADOQuery_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TADOQuery_sw.ClassFromVar(
  const AClass: OleVariant): TADOQuery_sc;
begin
  Result := TADOQuery_sc(ConvClsFromVar(AClass, TADOQuery));
end;

{ TADOStoredProc_sw }

function TADOStoredProc_ExecProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ExecProc;

  TADOStoredProc(AObj).ExecProc();
end;

function TADOStoredProc_ProcedureName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ProcedureName: WideString read <getter> write <s...

  if IsGet then
    Result := TADOStoredProc(AObj).ProcedureName
  else
    TADOStoredProc(AObj).ProcedureName := WideString(AArgs[0]);
end;

class function TADOStoredProc_sw.GetTypeName: WideString;
begin
  Result := 'TADOStoredProc';
end;

class function TADOStoredProc_sw.GetWrappedClass: TClass;
begin
  Result := TADOStoredProc;
end;

class procedure TADOStoredProc_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ExecProc', TADOStoredProc_ExecProc_si, 0, False);
  AData.AddPropertyRedecl('CommandTimeout', False);
  AData.AddPropertyRedecl('DataSource', False);
  AData.AddPropertyRedecl('EnableBCD', False);
  AData.AddProperty('ProcedureName', TADOStoredProc_ProcedureName_si, WideString_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Parameters', False);
  AData.AddPropertyRedecl('Prepared', False);
end;

class function TADOStoredProc_sw.ToVar(
  const AValue: TADOStoredProc): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TADOStoredProc_sw.FromVar(
  const AValue: OleVariant): TADOStoredProc;
begin
  Result := TADOStoredProc(ConvFromVar(AValue, TADOStoredProc));
end;

class function TADOStoredProc_sw.ClassToVar(
  AClass: TADOStoredProc_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TADOStoredProc_sw.ClassFromVar(
  const AClass: OleVariant): TADOStoredProc_sc;
begin
  Result := TADOStoredProc_sc(ConvClsFromVar(AClass, TADOStoredProc));
end;

{ TADOBlobStream_sw }

function TADOBlobStream_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Field: TBlobField; Mode: TBlobStreamMo...

  Result := TADOBlobStream_sw.ToVar(TADOBlobStream_sc(AObj).Create(
    TBlobField_sw.FromVar(AArgs[0]), TBlobStreamMode_sw.FromVar(AArgs[1])));
end;

function TADOBlobStream_Truncate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Truncate;

  TADOBlobStream(AObj).Truncate();
end;

class function TADOBlobStream_sw.GetTypeName: WideString;
begin
  Result := 'TADOBlobStream';
end;

class function TADOBlobStream_sw.GetWrappedClass: TClass;
begin
  Result := TADOBlobStream;
end;

class procedure TADOBlobStream_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Truncate', TADOBlobStream_Truncate_si, 0, False);

  { Class members }

  AData.AddConstructor('Create', TADOBlobStream_Create_si, 2, False);
end;

class function TADOBlobStream_sw.ToVar(
  const AValue: TADOBlobStream): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TADOBlobStream_sw.FromVar(
  const AValue: OleVariant): TADOBlobStream;
begin
  Result := TADOBlobStream(ConvFromVar(AValue, TADOBlobStream));
end;

class function TADOBlobStream_sw.ClassToVar(
  AClass: TADOBlobStream_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TADOBlobStream_sw.ClassFromVar(
  const AClass: OleVariant): TADOBlobStream_sc;
begin
  Result := TADOBlobStream_sc(ConvClsFromVar(AClass, TADOBlobStream));
end;

{ ADODB_sw }

function ADODB_EADOError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EADOError = class(EDatabaseError);

  Result := TLMDUnitWrapper.TypeToVar(EADOError_sw);
end;

function ADODB_TConnectMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConnectMode = (cmUnknown, cmRead, cmWrite, cmReadWr...

  Result := TLMDUnitWrapper.TypeToVar(TConnectMode_sw);
end;

function ADODB_TConnectOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConnectOption = (coConnectUnspecified, coAsyncConne...

  Result := TLMDUnitWrapper.TypeToVar(TConnectOption_sw);
end;

function ADODB_TCursorLocation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCursorLocation = (clUseServer, clUseClient);

  Result := TLMDUnitWrapper.TypeToVar(TCursorLocation_sw);
end;

function ADODB_TCursorType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCursorType = (ctUnspecified, ctOpenForwardOnly, ctK...

  Result := TLMDUnitWrapper.TypeToVar(TCursorType_sw);
end;

function ADODB_TEventStatus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEventStatus = (esOK, esErrorsOccured, esCantDeny, e...

  Result := TLMDUnitWrapper.TypeToVar(TEventStatus_sw);
end;

function ADODB_TExecuteOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExecuteOption = (eoAsyncExecute, eoAsyncFetch, eoAs...

  Result := TLMDUnitWrapper.TypeToVar(TExecuteOption_sw);
end;

function ADODB_TExecuteOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExecuteOptions = set of TExecuteOption;

  Result := TLMDUnitWrapper.TypeToVar(TExecuteOptions_sw);
end;

function ADODB_TIsolationLevel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIsolationLevel = (ilUnspecified, ilChaos, ilReadUnc...

  Result := TLMDUnitWrapper.TypeToVar(TIsolationLevel_sw);
end;

function ADODB_TADOLockType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TADOLockType = (ltUnspecified, ltReadOnly, ltPessimi...

  Result := TLMDUnitWrapper.TypeToVar(TADOLockType_sw);
end;

function ADODB_TObjectState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TObjectState = (stClosed, stOpen, stConnecting, stEx...

  Result := TLMDUnitWrapper.TypeToVar(TObjectState_sw);
end;

function ADODB_TObjectStates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TObjectStates = set of TObjectState;

  Result := TLMDUnitWrapper.TypeToVar(TObjectStates_sw);
end;

function ADODB_TSchemaInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSchemaInfo = (siAsserts, siCatalogs, siCharacterSet...

  Result := TLMDUnitWrapper.TypeToVar(TSchemaInfo_sw);
end;

function ADODB_TXactAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TXactAttribute = (xaCommitRetaining, xaAbortRetaining);

  Result := TLMDUnitWrapper.TypeToVar(TXactAttribute_sw);
end;

function ADODB_TXactAttributes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TXactAttributes = set of TXactAttribute;

  Result := TLMDUnitWrapper.TypeToVar(TXactAttributes_sw);
end;

function ADODB_TCommandType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCommandType = (cmdUnknown, cmdText, cmdTable, cmdSt...

  Result := TLMDUnitWrapper.TypeToVar(TCommandType_sw);
end;

function ADODB_TDisconnectEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDisconnectEvent = procedure (Connection: TADOConnec...

  Result := TLMDUnitWrapper.TypeToVar(TDisconnectEvent_sw);
end;

function ADODB_TWillConnectEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWillConnectEvent = procedure (Connection: TADOConne...

  Result := TLMDUnitWrapper.TypeToVar(TWillConnectEvent_sw);
end;

function ADODB_TADOConnection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TADOConnection = class(TCustomConnection);

  Result := TLMDUnitWrapper.TypeToVar(TADOConnection_sw);
end;

function ADODB_TRDSConnection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRDSConnection = class(TCustomConnection);

  Result := TLMDUnitWrapper.TypeToVar(TRDSConnection_sw);
end;

function ADODB_TDataType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataType = TFieldType;

  Result := TLMDUnitWrapper.TypeToVar(TDataType_sw);
end;

function ADODB_TParameterAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParameterAttribute = (paSigned, paNullable, paLong);

  Result := TLMDUnitWrapper.TypeToVar(TParameterAttribute_sw);
end;

function ADODB_TParameterAttributes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParameterAttributes = set of TParameterAttribute;

  Result := TLMDUnitWrapper.TypeToVar(TParameterAttributes_sw);
end;

function ADODB_TParameterDirection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParameterDirection = (pdUnknown, pdInput, pdOutput,...

  Result := TLMDUnitWrapper.TypeToVar(TParameterDirection_sw);
end;

function ADODB_TParameter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParameter = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TParameter_sw);
end;

function ADODB_TParameters_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParameters = class(TOwnedCollection);

  Result := TLMDUnitWrapper.TypeToVar(TParameters_sw);
end;

function ADODB_TADOCommand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TADOCommand = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TADOCommand_sw);
end;

function ADODB_TCursorOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCursorOption = (coHoldRecords, coMovePrevious, coAd...

  Result := TLMDUnitWrapper.TypeToVar(TCursorOption_sw);
end;

function ADODB_TCursorOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCursorOptions = set of TCursorOption;

  Result := TLMDUnitWrapper.TypeToVar(TCursorOptions_sw);
end;

function ADODB_TEventReason_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEventReason = (erAddNew, erDelete, erUpdate, erUndo...

  Result := TLMDUnitWrapper.TypeToVar(TEventReason_sw);
end;

function ADODB_TFilterGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFilterGroup = (fgUnassigned, fgNone, fgPendingRecor...

  Result := TLMDUnitWrapper.TypeToVar(TFilterGroup_sw);
end;

function ADODB_TMarshalOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMarshalOption = (moMarshalAll, moMarshalModifiedOnly);

  Result := TLMDUnitWrapper.TypeToVar(TMarshalOption_sw);
end;

function ADODB_TRecordStatus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRecordStatus = (rsOK, rsNew, rsModified, rsDeleted,...

  Result := TLMDUnitWrapper.TypeToVar(TRecordStatus_sw);
end;

function ADODB_TRecordStatusSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRecordStatusSet = set of TRecordStatus;

  Result := TLMDUnitWrapper.TypeToVar(TRecordStatusSet_sw);
end;

function ADODB_TAffectRecords_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAffectRecords = (arCurrent, arFiltered, arAll, arAl...

  Result := TLMDUnitWrapper.TypeToVar(TAffectRecords_sw);
end;

function ADODB_TPersistFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPersistFormat = (pfADTG, pfXML);

  Result := TLMDUnitWrapper.TypeToVar(TPersistFormat_sw);
end;

function ADODB_TSeekOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSeekOption = (soFirstEQ, soLastEQ, soAfterEQ, soAft...

  Result := TLMDUnitWrapper.TypeToVar(TSeekOption_sw);
end;

function ADODB_TWillChangeFieldEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWillChangeFieldEvent = procedure (DataSet: TCustomA...

  Result := TLMDUnitWrapper.TypeToVar(TWillChangeFieldEvent_sw);
end;

function ADODB_TWillChangeRecordEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWillChangeRecordEvent = procedure (DataSet: TCustom...

  Result := TLMDUnitWrapper.TypeToVar(TWillChangeRecordEvent_sw);
end;

function ADODB_TEndOfRecordsetEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEndOfRecordsetEvent = procedure (DataSet: TCustomAD...

  Result := TLMDUnitWrapper.TypeToVar(TEndOfRecordsetEvent_sw);
end;

function ADODB_TFetchProgressEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFetchProgressEvent = procedure (DataSet: TCustomADO...

  Result := TLMDUnitWrapper.TypeToVar(TFetchProgressEvent_sw);
end;

function ADODB_TRecordsetReasonEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRecordsetReasonEvent = procedure (DataSet: TCustomA...

  Result := TLMDUnitWrapper.TypeToVar(TRecordsetReasonEvent_sw);
end;

function ADODB_TCustomADODataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomADODataSet = class(TDataSet);

  Result := TLMDUnitWrapper.TypeToVar(TCustomADODataSet_sw);
end;

function ADODB_TADODataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TADODataSet = class(TCustomADODataSet);

  Result := TLMDUnitWrapper.TypeToVar(TADODataSet_sw);
end;

function ADODB_TADOTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TADOTable = class(TCustomADODataSet);

  Result := TLMDUnitWrapper.TypeToVar(TADOTable_sw);
end;

function ADODB_TADOQuery_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TADOQuery = class(TCustomADODataSet);

  Result := TLMDUnitWrapper.TypeToVar(TADOQuery_sw);
end;

function ADODB_TADOStoredProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TADOStoredProc = class(TCustomADODataSet);

  Result := TLMDUnitWrapper.TypeToVar(TADOStoredProc_sw);
end;

function ADODB_TADOBlobStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TADOBlobStream = class(TMemoryStream);

  Result := TLMDUnitWrapper.TypeToVar(TADOBlobStream_sw);
end;

function ADODB_CreateUDLFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CreateUDLFile(const FileName: WideString; const...

  ADODB.CreateUDLFile(WideString(AArgs[0]), WideString(AArgs[1]), WideString(
    AArgs[2]));
end;

function ADODB_DataLinkDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DataLinkDir: string;

  Result := ADODB.DataLinkDir();
end;

function ADODB_GetProviderNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetProviderNames(Names: TStrings);

  ADODB.GetProviderNames(TStrings_sw.FromVar(AArgs[0]));
end;

function ADODB_PromptDataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function PromptDataSource(ParentHandle: THandle; InitialS...

  Result := ADODB.PromptDataSource(THandle_sw.FromVar(AArgs[0]), WideString(
    AArgs[1]));
end;

function ADODB_PromptDataLinkFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function PromptDataLinkFile(ParentHandle: THandle; Initia...

  Result := ADODB.PromptDataLinkFile(THandle_sw.FromVar(AArgs[0]), WideString(
    AArgs[1]));
end;

function ADODB_GetDataLinkFiles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetDataLinkFiles(FileNames: TStrings; Directory:...

  case AArgsSize of
    1:
    begin
      Result := ADODB.GetDataLinkFiles(TStrings_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      Result := ADODB.GetDataLinkFiles(TStrings_sw.FromVar(AArgs[0]), string(
        AArgs[1]));
    end;
  else
    WrongArgCountError('GetDataLinkFiles');
  end;
end;

class function ADODB_sw.GetUnitName: WideString;
begin
  Result := 'ADODB';
end;

class procedure ADODB_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(EADOError_sw, ADODB_EADOError_si);
  AData.AddType(TConnectMode_sw, ADODB_TConnectMode_si);
  AData.AddType(TConnectOption_sw, ADODB_TConnectOption_si);
  AData.AddType(TCursorLocation_sw, ADODB_TCursorLocation_si);
  AData.AddType(TCursorType_sw, ADODB_TCursorType_si);
  AData.AddType(TEventStatus_sw, ADODB_TEventStatus_si);
  AData.AddType(TExecuteOption_sw, ADODB_TExecuteOption_si);
  AData.AddType(TExecuteOptions_sw, ADODB_TExecuteOptions_si);
  AData.AddType(TIsolationLevel_sw, ADODB_TIsolationLevel_si);
  AData.AddType(TADOLockType_sw, ADODB_TADOLockType_si);
  AData.AddType(TObjectState_sw, ADODB_TObjectState_si);
  AData.AddType(TObjectStates_sw, ADODB_TObjectStates_si);
  AData.AddType(TSchemaInfo_sw, ADODB_TSchemaInfo_si);
  AData.AddType(TXactAttribute_sw, ADODB_TXactAttribute_si);
  AData.AddType(TXactAttributes_sw, ADODB_TXactAttributes_si);
  AData.AddType(TCommandType_sw, ADODB_TCommandType_si);
  AData.AddType(TDisconnectEvent_sw, ADODB_TDisconnectEvent_si);
  AData.AddType(TWillConnectEvent_sw, ADODB_TWillConnectEvent_si);
  AData.AddType(TADOConnection_sw, ADODB_TADOConnection_si);
  AData.AddType(TRDSConnection_sw, ADODB_TRDSConnection_si);
  AData.AddType(TDataType_sw, ADODB_TDataType_si);
  AData.AddType(TParameterAttribute_sw, ADODB_TParameterAttribute_si);
  AData.AddType(TParameterAttributes_sw, ADODB_TParameterAttributes_si);
  AData.AddType(TParameterDirection_sw, ADODB_TParameterDirection_si);
  AData.AddType(TParameter_sw, ADODB_TParameter_si);
  AData.AddType(TParameters_sw, ADODB_TParameters_si);
  AData.AddType(TADOCommand_sw, ADODB_TADOCommand_si);
  AData.AddType(TCursorOption_sw, ADODB_TCursorOption_si);
  AData.AddType(TCursorOptions_sw, ADODB_TCursorOptions_si);
  AData.AddType(TEventReason_sw, ADODB_TEventReason_si);
  AData.AddType(TFilterGroup_sw, ADODB_TFilterGroup_si);
  AData.AddType(TMarshalOption_sw, ADODB_TMarshalOption_si);
  AData.AddType(TRecordStatus_sw, ADODB_TRecordStatus_si);
  AData.AddType(TRecordStatusSet_sw, ADODB_TRecordStatusSet_si);
  AData.AddType(TAffectRecords_sw, ADODB_TAffectRecords_si);
  AData.AddType(TPersistFormat_sw, ADODB_TPersistFormat_si);
  AData.AddType(TSeekOption_sw, ADODB_TSeekOption_si);
  AData.AddType(TWillChangeFieldEvent_sw, ADODB_TWillChangeFieldEvent_si);
  AData.AddType(TWillChangeRecordEvent_sw, ADODB_TWillChangeRecordEvent_si);
  AData.AddType(TEndOfRecordsetEvent_sw, ADODB_TEndOfRecordsetEvent_si);
  AData.AddType(TFetchProgressEvent_sw, ADODB_TFetchProgressEvent_si);
  AData.AddType(TRecordsetReasonEvent_sw, ADODB_TRecordsetReasonEvent_si);
  AData.AddType(TCustomADODataSet_sw, ADODB_TCustomADODataSet_si);
  AData.AddType(TADODataSet_sw, ADODB_TADODataSet_si);
  AData.AddType(TADOTable_sw, ADODB_TADOTable_si);
  AData.AddType(TADOQuery_sw, ADODB_TADOQuery_si);
  AData.AddType(TADOStoredProc_sw, ADODB_TADOStoredProc_si);
  AData.AddType(TADOBlobStream_sw, ADODB_TADOBlobStream_si);
  AData.AddProcedure('CreateUDLFile', ADODB_CreateUDLFile_si, 3, False);
  AData.AddFunction('DataLinkDir', ADODB_DataLinkDir_si, string_sw, 0, False);
  AData.AddProcedure('GetProviderNames', ADODB_GetProviderNames_si, 1, False);
  AData.AddFunction('PromptDataSource', ADODB_PromptDataSource_si, WideString_sw, 2, False);
  AData.AddFunction('PromptDataLinkFile', ADODB_PromptDataLinkFile_si, WideString_sw, 2, False);
  AData.AddFunction('GetDataLinkFiles', ADODB_GetDataLinkFiles_si, Integer_sw, 1, True);
end;

class function ADODB_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ADODB_sw);
end;

initialization
  RegisterUnitWrapper(ADODB_sw);
  RegisterClassWrapper(EADOError_sw);
  RegisterClassWrapper(TADOConnection_sw);
  RegisterClassWrapper(TRDSConnection_sw);
  RegisterClassWrapper(TParameter_sw);
  RegisterClassWrapper(TParameters_sw);
  RegisterClassWrapper(TADOCommand_sw);
  RegisterClassWrapper(TCustomADODataSet_sw);
  RegisterClassWrapper(TADODataSet_sw);
  RegisterClassWrapper(TADOTable_sw);
  RegisterClassWrapper(TADOQuery_sw);
  RegisterClassWrapper(TADOStoredProc_sw);
  RegisterClassWrapper(TADOBlobStream_sw);
  RegisterEventWrapper(TypeInfo(TDisconnectEvent), TDisconnectEvent_sw);
  RegisterEventWrapper(TypeInfo(TWillConnectEvent), TWillConnectEvent_sw);
  RegisterEventWrapper(TypeInfo(TWillChangeFieldEvent), TWillChangeFieldEvent_sw);
  RegisterEventWrapper(TypeInfo(TWillChangeRecordEvent), TWillChangeRecordEvent_sw);
  RegisterEventWrapper(TypeInfo(TEndOfRecordsetEvent), TEndOfRecordsetEvent_sw);
  RegisterEventWrapper(TypeInfo(TFetchProgressEvent), TFetchProgressEvent_sw);
  RegisterEventWrapper(TypeInfo(TRecordsetReasonEvent), TRecordsetReasonEvent_sw);

end.
