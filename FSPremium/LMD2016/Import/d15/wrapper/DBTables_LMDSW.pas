unit DBTables_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'DBTables' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers, Types,
  Variants, Windows, SysUtils, Classes, DB, DBCommon, DBCommonTypes, DBTables,
  Variants_LMDSW, Windows_LMDSW, SysUtils_LMDSW, Classes_LMDSW, DB_LMDSW,
  DBCommon_LMDSW, DBCommonTypes_LMDSW;


{ Type wrappers }

type
  EDBEngineError_sw = class;
  ENoResultSet_sw = class;
  TDBError_sw = class;
  TBDECallback_sw = class;
  TSessionList_sw = class;
  TSession_sw = class;
  TParamList_sw = class;
  TDatabase_sw = class;
  TDataSetUpdateObject_sw = class;
  TSQLUpdateObject_sw = class;
  TBDEDataSet_sw = class;
  TNestedTable_sw = class;
  TDBDataSet_sw = class;
  TIndexFiles_sw = class;
  TTable_sw = class;
  TBatchMove_sw = class;
  TStoredProc_sw = class;
  TQuery_sw = class;
  TUpdateSQL_sw = class;
  TBlobStream_sw = class;

  EDBEngineError_sc = class of EDBEngineError;
  EDBEngineError_sw = class(EDatabaseError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EDBEngineError): OleVariant;
    class function FromVar(const AValue: OleVariant): EDBEngineError;
    class function ClassToVar(AClass: EDBEngineError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EDBEngineError_sc;
  end;

  ENoResultSet_sc = class of ENoResultSet;
  ENoResultSet_sw = class(EDatabaseError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: ENoResultSet): OleVariant;
    class function FromVar(const AValue: OleVariant): ENoResultSet;
    class function ClassToVar(AClass: ENoResultSet_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): ENoResultSet_sc;
  end;

  TDBError_sc = class of TDBError;
  TDBError_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBError): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBError;
    class function ClassToVar(AClass: TDBError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBError_sc;
  end;

  TBDECallback_sc = class of TBDECallback;
  TBDECallback_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBDECallback): OleVariant;
    class function FromVar(const AValue: OleVariant): TBDECallback;
    class function ClassToVar(AClass: TBDECallback_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBDECallback_sc;
  end;

  TSessionList_sc = class of TSessionList;
  TSessionList_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSessionList): OleVariant;
    class function FromVar(const AValue: OleVariant): TSessionList;
    class function ClassToVar(AClass: TSessionList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSessionList_sc;
  end;

  TConfigModes_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TConfigModes): OleVariant;
    class function FromVar(const AValue: OleVariant): TConfigModes;
  end;

  TConfigMode_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TConfigMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TConfigMode;
  end;

  TPasswordEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var Continue: Boolean);
  end;

  TPasswordEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TPasswordEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TPasswordEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TPasswordEvent;
  end;

  TDatabaseEvent_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TDatabaseEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDatabaseEvent;
  end;

  TTraceFlag_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TTraceFlag): OleVariant;
    class function FromVar(const AValue: OleVariant): TTraceFlag;
  end;

  TTraceFlags_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TTraceFlags): OleVariant;
    class function FromVar(const AValue: OleVariant): TTraceFlags;
  end;

  TSession_sc = class of TSession;
  TSession_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSession): OleVariant;
    class function FromVar(const AValue: OleVariant): TSession;
    class function ClassToVar(AClass: TSession_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSession_sc;
  end;

  TParamList_sc = class of TParamList;
  TParamList_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TParamList): OleVariant;
    class function FromVar(const AValue: OleVariant): TParamList;
    class function ClassToVar(AClass: TParamList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TParamList_sc;
  end;

  TTransIsolation_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TTransIsolation): OleVariant;
    class function FromVar(const AValue: OleVariant): TTransIsolation;
  end;

  TDatabaseLoginEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Database: TDatabase; LoginParams: TStrings);
  end;

  TDatabaseLoginEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDatabaseLoginEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDatabaseLoginEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDatabaseLoginEvent;
  end;

  TDatabase_sc = class of TDatabase;
  TDatabase_sw = class(TCustomConnection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDatabase): OleVariant;
    class function FromVar(const AValue: OleVariant): TDatabase;
    class function ClassToVar(AClass: TDatabase_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDatabase_sc;
  end;

  TRecNoStatus_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TRecNoStatus): OleVariant;
    class function FromVar(const AValue: OleVariant): TRecNoStatus;
  end;

  TDataSetUpdateObject_sc = class of TDataSetUpdateObject;
  TDataSetUpdateObject_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDataSetUpdateObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSetUpdateObject;
    class function ClassToVar(AClass: TDataSetUpdateObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDataSetUpdateObject_sc;
  end;

  TSQLUpdateObject_sc = class of TSQLUpdateObject;
  TSQLUpdateObject_sw = class(TDataSetUpdateObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSQLUpdateObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TSQLUpdateObject;
    class function ClassToVar(AClass: TSQLUpdateObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSQLUpdateObject_sc;
  end;

  TBDEKeyBuffer_sw = class(TLMDRecordWrapper)
  private
    FValue: TBDEKeyBuffer;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TBDEKeyBuffer): OleVariant;
    class function FromVar(const AValue: OleVariant): TBDEKeyBuffer;
  end;

  TBDERecInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TBDERecInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TBDERecInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TBDERecInfo;
  end;

  TBDEDataSet_sc = class of TBDEDataSet;
  TBDEDataSet_sw = class(TDataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBDEDataSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TBDEDataSet;
    class function ClassToVar(AClass: TBDEDataSet_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBDEDataSet_sc;
  end;

  TNestedTable_sc = class of TNestedTable;
  TNestedTable_sw = class(TBDEDataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TNestedTable): OleVariant;
    class function FromVar(const AValue: OleVariant): TNestedTable;
    class function ClassToVar(AClass: TNestedTable_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TNestedTable_sc;
  end;

  TDBDataSet_sc = class of TDBDataSet;
  TDBDataSet_sw = class(TBDEDataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBDataSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBDataSet;
    class function ClassToVar(AClass: TDBDataSet_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBDataSet_sc;
  end;

  TBatchMode_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TBatchMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TBatchMode;
  end;

  TTableType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TTableType): OleVariant;
    class function FromVar(const AValue: OleVariant): TTableType;
  end;

  TLockType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TLockType): OleVariant;
    class function FromVar(const AValue: OleVariant): TLockType;
  end;

  TIndexName_sw = string_sw;

  TIndexFiles_sc = class of TIndexFiles;
  TIndexFiles_sw = class(TStringList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TIndexFiles): OleVariant;
    class function FromVar(const AValue: OleVariant): TIndexFiles;
    class function ClassToVar(AClass: TIndexFiles_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TIndexFiles_sc;
  end;

  TTable_sc = class of TTable;
  TTable_sw = class(TDBDataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTable): OleVariant;
    class function FromVar(const AValue: OleVariant): TTable;
    class function ClassToVar(AClass: TTable_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTable_sc;
  end;

  TBatchMove_sc = class of TBatchMove;
  TBatchMove_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBatchMove): OleVariant;
    class function FromVar(const AValue: OleVariant): TBatchMove;
    class function ClassToVar(AClass: TBatchMove_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBatchMove_sc;
  end;

  TParamBindMode_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TParamBindMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TParamBindMode;
  end;

  TServerDesc_sw = class(TLMDRecordWrapper)
  private
    FValue: TServerDesc;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TServerDesc): OleVariant;
    class function FromVar(const AValue: OleVariant): TServerDesc;
  end;

  TStoredProc_sc = class of TStoredProc;
  TStoredProc_sw = class(TDBDataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStoredProc): OleVariant;
    class function FromVar(const AValue: OleVariant): TStoredProc;
    class function ClassToVar(AClass: TStoredProc_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStoredProc_sc;
  end;

  TQuery_sc = class of TQuery;
  TQuery_sw = class(TDBDataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TQuery): OleVariant;
    class function FromVar(const AValue: OleVariant): TQuery;
    class function ClassToVar(AClass: TQuery_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TQuery_sc;
  end;

  TUpdateSQL_sc = class of TUpdateSQL;
  TUpdateSQL_sw = class(TSQLUpdateObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TUpdateSQL): OleVariant;
    class function FromVar(const AValue: OleVariant): TUpdateSQL;
    class function ClassToVar(AClass: TUpdateSQL_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TUpdateSQL_sc;
  end;

  TBlobStream_sc = class of TBlobStream;
  TBlobStream_sw = class(TStream_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBlobStream): OleVariant;
    class function FromVar(const AValue: OleVariant): TBlobStream;
    class function ClassToVar(AClass: TBlobStream_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBlobStream_sc;
  end;


{ Unit wrapper }

type
  DBTables_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TSession_sacc = class(TSession);
  TDataSetUpdateObject_sacc = class(TDataSetUpdateObject);
  TDBDataSet_sacc = class(TDBDataSet);
  TTable_sacc = class(TTable);
  TQuery_sacc = class(TQuery);

{ EDBEngineError_sw }

function EDBEngineError_ErrorCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ErrorCount: Integer read <getter>;

  Result := EDBEngineError(AObj).ErrorCount;
end;

function EDBEngineError_Errors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Errors[Index: Integer]: TDBError read <getter>;

  Result := TDBError_sw.ToVar(EDBEngineError(AObj).Errors[Integer(AArgs[0])]);
end;

class function EDBEngineError_sw.GetTypeName: WideString;
begin
  Result := 'EDBEngineError';
end;

class function EDBEngineError_sw.GetWrappedClass: TClass;
begin
  Result := EDBEngineError;
end;

class procedure EDBEngineError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ErrorCount', EDBEngineError_ErrorCount_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('Errors', EDBEngineError_Errors_si, TDBError_sw, True, False, 1, False);
end;

class function EDBEngineError_sw.ToVar(
  const AValue: EDBEngineError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EDBEngineError_sw.FromVar(
  const AValue: OleVariant): EDBEngineError;
begin
  Result := EDBEngineError(ConvFromVar(AValue, EDBEngineError));
end;

class function EDBEngineError_sw.ClassToVar(
  AClass: EDBEngineError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EDBEngineError_sw.ClassFromVar(
  const AClass: OleVariant): EDBEngineError_sc;
begin
  Result := EDBEngineError_sc(ConvClsFromVar(AClass, EDBEngineError));
end;

{ ENoResultSet_sw }

class function ENoResultSet_sw.GetTypeName: WideString;
begin
  Result := 'ENoResultSet';
end;

class function ENoResultSet_sw.GetWrappedClass: TClass;
begin
  Result := ENoResultSet;
end;

class procedure ENoResultSet_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function ENoResultSet_sw.ToVar(const AValue: ENoResultSet): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function ENoResultSet_sw.FromVar(const AValue: OleVariant): ENoResultSet;
begin
  Result := ENoResultSet(ConvFromVar(AValue, ENoResultSet));
end;

class function ENoResultSet_sw.ClassToVar(AClass: ENoResultSet_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function ENoResultSet_sw.ClassFromVar(
  const AClass: OleVariant): ENoResultSet_sc;
begin
  Result := ENoResultSet_sc(ConvClsFromVar(AClass, ENoResultSet));
end;

{ TDBError_sw }

function TDBError_Category_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Category: Byte read <getter>;

  Result := TDBError(AObj).Category;
end;

function TDBError_SubCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SubCode: Byte read <getter>;

  Result := TDBError(AObj).SubCode;
end;

function TDBError_Message_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Message: string read <getter>;

  Result := TDBError(AObj).Message;
end;

function TDBError_NativeError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NativeError: Longint read <getter>;

  Result := TDBError(AObj).NativeError;
end;

class function TDBError_sw.GetTypeName: WideString;
begin
  Result := 'TDBError';
end;

class function TDBError_sw.GetWrappedClass: TClass;
begin
  Result := TDBError;
end;

class procedure TDBError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Category', TDBError_Category_si, Byte_sw, True, False, 0, False);
  AData.AddProperty('SubCode', TDBError_SubCode_si, Byte_sw, True, False, 0, False);
  AData.AddProperty('Message', TDBError_Message_si, string_sw, True, False, 0, False);
  AData.AddProperty('NativeError', TDBError_NativeError_si, Longint_sw, True, False, 0, False);
end;

class function TDBError_sw.ToVar(const AValue: TDBError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBError_sw.FromVar(const AValue: OleVariant): TDBError;
begin
  Result := TDBError(ConvFromVar(AValue, TDBError));
end;

class function TDBError_sw.ClassToVar(AClass: TDBError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBError_sw.ClassFromVar(const AClass: OleVariant): TDBError_sc;
begin
  Result := TDBError_sc(ConvClsFromVar(AClass, TDBError));
end;

{ TBDECallback_sw }

class function TBDECallback_sw.GetTypeName: WideString;
begin
  Result := 'TBDECallback';
end;

class function TBDECallback_sw.GetWrappedClass: TClass;
begin
  Result := TBDECallback;
end;

class procedure TBDECallback_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TBDECallback_sw.ToVar(const AValue: TBDECallback): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBDECallback_sw.FromVar(const AValue: OleVariant): TBDECallback;
begin
  Result := TBDECallback(ConvFromVar(AValue, TBDECallback));
end;

class function TBDECallback_sw.ClassToVar(AClass: TBDECallback_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBDECallback_sw.ClassFromVar(
  const AClass: OleVariant): TBDECallback_sc;
begin
  Result := TBDECallback_sc(ConvClsFromVar(AClass, TBDECallback));
end;

{ TSessionList_sw }

function TSessionList_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TSessionList_sw.ToVar(TSessionList_sc(AObj).Create());
end;

function TSessionList_CurrentSession_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CurrentSession: TSession read <getter> write <se...

  if IsGet then
    Result := TSession_sw.ToVar(TSessionList(AObj).CurrentSession)
  else
    TSessionList(AObj).CurrentSession := TSession_sw.FromVar(AArgs[0]);
end;

function TSessionList_FindSession_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindSession(const SessionName: string): TSession;

  Result := TSession_sw.ToVar(TSessionList(AObj).FindSession(string(AArgs[0])));
end;

function TSessionList_GetSessionNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetSessionNames(List: TStrings);

  TSessionList(AObj).GetSessionNames(TStrings_sw.FromVar(AArgs[0]));
end;

function TSessionList_OpenSession_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function OpenSession(const SessionName: string): TSession;

  Result := TSession_sw.ToVar(TSessionList(AObj).OpenSession(string(AArgs[0])));
end;

function TSessionList_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TSessionList(AObj).Count;
end;

function TSessionList_Sessions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Sessions[Index: Integer]: TSession read <getter>...

  Result := TSession_sw.ToVar(TSessionList(AObj).Sessions[Integer(AArgs[0])]);
end;

function TSessionList_List_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property List[const SessionName: string]: TSession read <...

  Result := TSession_sw.ToVar(TSessionList(AObj).List[string(AArgs[0])]);
end;

class function TSessionList_sw.GetTypeName: WideString;
begin
  Result := 'TSessionList';
end;

class function TSessionList_sw.GetWrappedClass: TClass;
begin
  Result := TSessionList;
end;

class procedure TSessionList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('CurrentSession', TSessionList_CurrentSession_si, TSession_sw, True, True, 0, False);
  AData.AddFunction('FindSession', TSessionList_FindSession_si, TSession_sw, 1, False);
  AData.AddProcedure('GetSessionNames', TSessionList_GetSessionNames_si, 1, False);
  AData.AddFunction('OpenSession', TSessionList_OpenSession_si, TSession_sw, 1, False);
  AData.AddProperty('Count', TSessionList_Count_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('Sessions', TSessionList_Sessions_si, TSession_sw, True, False, 1, False);
  AData.AddProperty('List', TSessionList_List_si, TSession_sw, True, False, 1, False);

  { Class members }

  AData.AddConstructor('Create', TSessionList_Create_si, 0, False);
end;

class function TSessionList_sw.ToVar(const AValue: TSessionList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSessionList_sw.FromVar(const AValue: OleVariant): TSessionList;
begin
  Result := TSessionList(ConvFromVar(AValue, TSessionList));
end;

class function TSessionList_sw.ClassToVar(AClass: TSessionList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSessionList_sw.ClassFromVar(
  const AClass: OleVariant): TSessionList_sc;
begin
  Result := TSessionList_sc(ConvClsFromVar(AClass, TSessionList));
end;

{ TConfigModes_sw }

class function TConfigModes_sw.GetTypeName: WideString;
begin
  Result := 'TConfigModes';
end;

class function TConfigModes_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TConfigModes);
end;

class function TConfigModes_sw.ToVar(const AValue: TConfigModes): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TConfigModes_sw.FromVar(const AValue: OleVariant): TConfigModes;
begin
  Result := TConfigModes(Integer(AValue));
end;

{ TConfigMode_sw }

class function TConfigMode_sw.GetTypeName: WideString;
begin
  Result := 'TConfigMode';
end;

class function TConfigMode_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TConfigMode);
end;

class function TConfigMode_sw.ToVar(const AValue: TConfigMode): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TConfigMode_sw.FromVar(const AValue: OleVariant): TConfigMode;
begin
  ConvFromVar(AValue, @Result);
end;

{ TPasswordEvent_sh }

function TPasswordEvent_sh.GetHandler: TMethod;
var
  hdr: TPasswordEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TPasswordEvent_sh.Handler(Sender: TObject; var Continue: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var Continue: Boolean) of object

  v_1 := Continue;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Continue := Boolean(v_1);
end;

{ TPasswordEvent_sw }

class function TPasswordEvent_sw.GetTypeName: WideString;
begin
  Result := 'TPasswordEvent';
end;

class function TPasswordEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TPasswordEvent_sh;
end;

class function TPasswordEvent_sw.ToVar(
  const AValue: TPasswordEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TPasswordEvent_sw.FromVar(
  const AValue: OleVariant): TPasswordEvent;
begin
  Result := TPasswordEvent(ConvFromVar(AValue));
end;

class function TPasswordEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TPasswordEvent;
var
  hdlr: TPasswordEvent_sh;
begin
  hdlr   := TPasswordEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TPasswordEvent_sw));
  Result := hdlr.Handler;
end;

{ TDatabaseEvent_sw }

class function TDatabaseEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDatabaseEvent';
end;

class function TDatabaseEvent_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TDatabaseEvent);
end;

class function TDatabaseEvent_sw.ToVar(
  const AValue: TDatabaseEvent): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDatabaseEvent_sw.FromVar(
  const AValue: OleVariant): TDatabaseEvent;
begin
  Result := TDatabaseEvent(Integer(AValue));
end;

{ TTraceFlag_sw }

class function TTraceFlag_sw.GetTypeName: WideString;
begin
  Result := 'TTraceFlag';
end;

class function TTraceFlag_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TTraceFlag);
end;

class function TTraceFlag_sw.ToVar(const AValue: TTraceFlag): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTraceFlag_sw.FromVar(const AValue: OleVariant): TTraceFlag;
begin
  Result := TTraceFlag(Integer(AValue));
end;

{ TTraceFlags_sw }

class function TTraceFlags_sw.GetTypeName: WideString;
begin
  Result := 'TTraceFlags';
end;

class function TTraceFlags_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TTraceFlags);
end;

class function TTraceFlags_sw.ToVar(const AValue: TTraceFlags): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TTraceFlags_sw.FromVar(const AValue: OleVariant): TTraceFlags;
begin
  ConvFromVar(AValue, @Result);
end;

{ TSession_sw }

function TSession_BDEOwnsLoginCbDb_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BDEOwnsLoginCbDb: Boolean read <getter...

  if IsGet then
    Result := TSession_sacc(TSession(AObj)).BDEOwnsLoginCbDb
  else
    TSession_sacc(TSession(AObj)).BDEOwnsLoginCbDb := Boolean(AArgs[0]);
end;

function TSession_AddAlias_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AddAlias(const Name: string; const Driver: stri...

  TSession(AObj).AddAlias(string(AArgs[0]), string(AArgs[1]), TStrings_sw.
    FromVar(AArgs[2]));
end;

function TSession_AddDriver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AddDriver(const Name: string; List: TStrings);

  TSession(AObj).AddDriver(string(AArgs[0]), TStrings_sw.FromVar(AArgs[1]));
end;

function TSession_AddStandardAlias_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AddStandardAlias(const Name: string; const Path...

  TSession(AObj).AddStandardAlias(string(AArgs[0]), string(AArgs[1]), string(
    AArgs[2]));
end;

function TSession_ConfigMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ConfigMode: TConfigMode read <getter> write <set...

  if IsGet then
    Result := TConfigMode_sw.ToVar(TSession(AObj).ConfigMode)
  else
    TSession(AObj).ConfigMode := TConfigMode_sw.FromVar(AArgs[0]);
end;

function TSession_AddPassword_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AddPassword(const Password: string);

  TSession(AObj).AddPassword(string(AArgs[0]));
end;

function TSession_Close_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Close;

  TSession(AObj).Close();
end;

function TSession_CloseDatabase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CloseDatabase(Database: TDatabase);

  TSession(AObj).CloseDatabase(TDatabase_sw.FromVar(AArgs[0]));
end;

function TSession_DeleteAlias_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DeleteAlias(const Name: string);

  TSession(AObj).DeleteAlias(string(AArgs[0]));
end;

function TSession_DeleteDriver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DeleteDriver(const Name: string);

  TSession(AObj).DeleteDriver(string(AArgs[0]));
end;

function TSession_DropConnections_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DropConnections;

  TSession(AObj).DropConnections();
end;

function TSession_FindDatabase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindDatabase(const DatabaseName: string): TDatab...

  Result := TDatabase_sw.ToVar(TSession(AObj).FindDatabase(string(AArgs[0])));
end;

function TSession_GetAliasNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetAliasNames(List: TStrings);

  TSession(AObj).GetAliasNames(TStrings_sw.FromVar(AArgs[0]));
end;

function TSession_GetAliasParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetAliasParams(const AliasName: string; List: T...

  TSession(AObj).GetAliasParams(string(AArgs[0]), TStrings_sw.FromVar(
    AArgs[1]));
end;

function TSession_GetAliasDriverName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetAliasDriverName(const AliasName: string): str...

  Result := TSession(AObj).GetAliasDriverName(string(AArgs[0]));
end;

function TSession_GetConfigParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetConfigParams(const Path: string; const Secti...

  TSession(AObj).GetConfigParams(string(AArgs[0]), string(AArgs[1]), 
    TStrings_sw.FromVar(AArgs[2]));
end;

function TSession_GetDatabaseNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetDatabaseNames(List: TStrings);

  TSession(AObj).GetDatabaseNames(TStrings_sw.FromVar(AArgs[0]));
end;

function TSession_GetDriverNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetDriverNames(List: TStrings);

  TSession(AObj).GetDriverNames(TStrings_sw.FromVar(AArgs[0]));
end;

function TSession_GetDriverParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetDriverParams(const DriverName: string; List:...

  TSession(AObj).GetDriverParams(string(AArgs[0]), TStrings_sw.FromVar(
    AArgs[1]));
end;

function TSession_GetFieldNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetFieldNames(const DatabaseName: string; const...

  TSession(AObj).GetFieldNames(string(AArgs[0]), string(AArgs[1]), TStrings_sw.
    FromVar(AArgs[2]));
end;

function TSession_GetPassword_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetPassword: Boolean;

  Result := TSession(AObj).GetPassword();
end;

function TSession_GetTableNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetTableNames(const DatabaseName: string; const...

  TSession(AObj).GetTableNames(string(AArgs[0]), string(AArgs[1]), Boolean(
    AArgs[2]), Boolean(AArgs[3]), TStrings_sw.FromVar(AArgs[4]));
end;

function TSession_GetStoredProcNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetStoredProcNames(const DatabaseName: string; ...

  TSession(AObj).GetStoredProcNames(string(AArgs[0]), TStrings_sw.FromVar(
    AArgs[1]));
end;

function TSession_IsAlias_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsAlias(const Name: string): Boolean;

  Result := TSession(AObj).IsAlias(string(AArgs[0]));
end;

function TSession_ModifyAlias_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ModifyAlias(Name: string; List: TStrings);

  TSession(AObj).ModifyAlias(string(AArgs[0]), TStrings_sw.FromVar(AArgs[1]));
end;

function TSession_ModifyDriver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ModifyDriver(Name: string; List: TStrings);

  TSession(AObj).ModifyDriver(string(AArgs[0]), TStrings_sw.FromVar(AArgs[1]));
end;

function TSession_Open_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Open;

  TSession(AObj).Open();
end;

function TSession_OpenDatabase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function OpenDatabase(const DatabaseName: string): TDatab...

  Result := TDatabase_sw.ToVar(TSession(AObj).OpenDatabase(string(AArgs[0])));
end;

function TSession_RemoveAllPasswords_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RemoveAllPasswords;

  TSession(AObj).RemoveAllPasswords();
end;

function TSession_RemovePassword_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RemovePassword(const Password: string);

  TSession(AObj).RemovePassword(string(AArgs[0]));
end;

function TSession_SaveConfigFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveConfigFile;

  TSession(AObj).SaveConfigFile();
end;

function TSession_DatabaseCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DatabaseCount: Integer read <getter>;

  Result := TSession(AObj).DatabaseCount;
end;

function TSession_Databases_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Databases[Index: Integer]: TDatabase read <getter>;

  Result := TDatabase_sw.ToVar(TSession(AObj).Databases[Integer(AArgs[0])]);
end;

function TSession_TraceFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TraceFlags: TTraceFlags read <getter> write <set...

  if IsGet then
    Result := TTraceFlags_sw.ToVar(TSession(AObj).TraceFlags)
  else
    TSession(AObj).TraceFlags := TTraceFlags_sw.FromVar(AArgs[0]);
end;

function TSession_Active_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Active: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TSession(AObj).Active
  else
    TSession(AObj).Active := Boolean(AArgs[0]);
end;

function TSession_AutoSessionName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoSessionName: Boolean read <getter> write <se...

  if IsGet then
    Result := TSession(AObj).AutoSessionName
  else
    TSession(AObj).AutoSessionName := Boolean(AArgs[0]);
end;

function TSession_KeepConnections_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeepConnections: Boolean read <getter> write <se...

  if IsGet then
    Result := TSession(AObj).KeepConnections
  else
    TSession(AObj).KeepConnections := Boolean(AArgs[0]);
end;

function TSession_NetFileDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NetFileDir: string read <getter> write <setter>;

  if IsGet then
    Result := TSession(AObj).NetFileDir
  else
    TSession(AObj).NetFileDir := string(AArgs[0]);
end;

function TSession_PrivateDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PrivateDir: string read <getter> write <setter>;

  if IsGet then
    Result := TSession(AObj).PrivateDir
  else
    TSession(AObj).PrivateDir := string(AArgs[0]);
end;

function TSession_SessionName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SessionName: string read <getter> write <setter>;

  if IsGet then
    Result := TSession(AObj).SessionName
  else
    TSession(AObj).SessionName := string(AArgs[0]);
end;

function TSession_SQLHourGlass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SQLHourGlass: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TSession(AObj).SQLHourGlass
  else
    TSession(AObj).SQLHourGlass := Boolean(AArgs[0]);
end;

function TSession_OnPassword_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnPassword: TPasswordEvent read <getter> write <...

  if IsGet then
    Result := TPasswordEvent_sw.ToVar(TSession(AObj).OnPassword)
  else
    TSession(AObj).OnPassword := TPasswordEvent_sw.FromVar(AArgs[0]);
end;

function TSession_OnStartup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnStartup: TNotifyEvent read <getter> write <set...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TSession(AObj).OnStartup)
  else
    TSession(AObj).OnStartup := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TSession_sw.GetTypeName: WideString;
begin
  Result := 'TSession';
end;

class function TSession_sw.GetWrappedClass: TClass;
begin
  Result := TSession;
end;

class procedure TSession_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('BDEOwnsLoginCbDb', TSession_BDEOwnsLoginCbDb_si, Boolean_sw, True, True, 0, True);
  AData.AddProcedure('AddAlias', TSession_AddAlias_si, 3, False);
  AData.AddProcedure('AddDriver', TSession_AddDriver_si, 2, False);
  AData.AddProcedure('AddStandardAlias', TSession_AddStandardAlias_si, 3, False);
  AData.AddProperty('ConfigMode', TSession_ConfigMode_si, TConfigMode_sw, True, True, 0, False);
  AData.AddProcedure('AddPassword', TSession_AddPassword_si, 1, False);
  AData.AddProcedure('Close', TSession_Close_si, 0, False);
  AData.AddProcedure('CloseDatabase', TSession_CloseDatabase_si, 1, False);
  AData.AddProcedure('DeleteAlias', TSession_DeleteAlias_si, 1, False);
  AData.AddProcedure('DeleteDriver', TSession_DeleteDriver_si, 1, False);
  AData.AddProcedure('DropConnections', TSession_DropConnections_si, 0, False);
  AData.AddFunction('FindDatabase', TSession_FindDatabase_si, TDatabase_sw, 1, False);
  AData.AddProcedure('GetAliasNames', TSession_GetAliasNames_si, 1, False);
  AData.AddProcedure('GetAliasParams', TSession_GetAliasParams_si, 2, False);
  AData.AddFunction('GetAliasDriverName', TSession_GetAliasDriverName_si, string_sw, 1, False);
  AData.AddProcedure('GetConfigParams', TSession_GetConfigParams_si, 3, False);
  AData.AddProcedure('GetDatabaseNames', TSession_GetDatabaseNames_si, 1, False);
  AData.AddProcedure('GetDriverNames', TSession_GetDriverNames_si, 1, False);
  AData.AddProcedure('GetDriverParams', TSession_GetDriverParams_si, 2, False);
  AData.AddProcedure('GetFieldNames', TSession_GetFieldNames_si, 3, False);
  AData.AddFunction('GetPassword', TSession_GetPassword_si, Boolean_sw, 0, False);
  AData.AddProcedure('GetTableNames', TSession_GetTableNames_si, 5, False);
  AData.AddProcedure('GetStoredProcNames', TSession_GetStoredProcNames_si, 2, False);
  AData.AddFunction('IsAlias', TSession_IsAlias_si, Boolean_sw, 1, False);
  AData.AddProcedure('ModifyAlias', TSession_ModifyAlias_si, 2, False);
  AData.AddProcedure('ModifyDriver', TSession_ModifyDriver_si, 2, False);
  AData.AddProcedure('Open', TSession_Open_si, 0, False);
  AData.AddFunction('OpenDatabase', TSession_OpenDatabase_si, TDatabase_sw, 1, False);
  AData.AddProcedure('RemoveAllPasswords', TSession_RemoveAllPasswords_si, 0, False);
  AData.AddProcedure('RemovePassword', TSession_RemovePassword_si, 1, False);
  AData.AddProcedure('SaveConfigFile', TSession_SaveConfigFile_si, 0, False);
  AData.AddProperty('DatabaseCount', TSession_DatabaseCount_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('Databases', TSession_Databases_si, TDatabase_sw, True, False, 1, False);
  AData.AddProperty('TraceFlags', TSession_TraceFlags_si, TTraceFlags_sw, True, True, 0, False);
  AData.AddProperty('Active', TSession_Active_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('AutoSessionName', TSession_AutoSessionName_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('KeepConnections', TSession_KeepConnections_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('NetFileDir', TSession_NetFileDir_si, string_sw, True, True, 0, False);
  AData.AddProperty('PrivateDir', TSession_PrivateDir_si, string_sw, True, True, 0, False);
  AData.AddProperty('SessionName', TSession_SessionName_si, string_sw, True, True, 0, False);
  AData.AddProperty('SQLHourGlass', TSession_SQLHourGlass_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('OnPassword', TSession_OnPassword_si, TPasswordEvent_sw, True, True, 0, False);
  AData.AddProperty('OnStartup', TSession_OnStartup_si, TNotifyEvent_sw, True, True, 0, False);
end;

class function TSession_sw.ToVar(const AValue: TSession): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSession_sw.FromVar(const AValue: OleVariant): TSession;
begin
  Result := TSession(ConvFromVar(AValue, TSession));
end;

class function TSession_sw.ClassToVar(AClass: TSession_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSession_sw.ClassFromVar(const AClass: OleVariant): TSession_sc;
begin
  Result := TSession_sc(ConvClsFromVar(AClass, TSession));
end;

{ TParamList_sw }

function TParamList_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Params: TStrings);

  Result := TParamList_sw.ToVar(TParamList_sc(AObj).Create(TStrings_sw.FromVar(
    AArgs[0])));
end;

function TParamList_FieldCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldCount: Integer read <getter>;

  Result := TParamList(AObj).FieldCount;
end;

class function TParamList_sw.GetTypeName: WideString;
begin
  Result := 'TParamList';
end;

class function TParamList_sw.GetWrappedClass: TClass;
begin
  Result := TParamList;
end;

class procedure TParamList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('FieldCount', TParamList_FieldCount_si, Integer_sw, True, False, 0, False);

  { Class members }

  AData.AddConstructor('Create', TParamList_Create_si, 1, False);
end;

class function TParamList_sw.ToVar(const AValue: TParamList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TParamList_sw.FromVar(const AValue: OleVariant): TParamList;
begin
  Result := TParamList(ConvFromVar(AValue, TParamList));
end;

class function TParamList_sw.ClassToVar(AClass: TParamList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TParamList_sw.ClassFromVar(
  const AClass: OleVariant): TParamList_sc;
begin
  Result := TParamList_sc(ConvClsFromVar(AClass, TParamList));
end;

{ TTransIsolation_sw }

class function TTransIsolation_sw.GetTypeName: WideString;
begin
  Result := 'TTransIsolation';
end;

class function TTransIsolation_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TTransIsolation);
end;

class function TTransIsolation_sw.ToVar(
  const AValue: TTransIsolation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTransIsolation_sw.FromVar(
  const AValue: OleVariant): TTransIsolation;
begin
  Result := TTransIsolation(Integer(AValue));
end;

{ TDatabaseLoginEvent_sh }

function TDatabaseLoginEvent_sh.GetHandler: TMethod;
var
  hdr: TDatabaseLoginEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDatabaseLoginEvent_sh.Handler(Database: TDatabase;
  LoginParams: TStrings);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Database: TDatabase; LoginParams: TStrings) of...

  args[0] := TDatabase_sw.ToVar(Database);
  args[1] := TStrings_sw.ToVar(LoginParams);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TDatabaseLoginEvent_sw }

class function TDatabaseLoginEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDatabaseLoginEvent';
end;

class function TDatabaseLoginEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDatabaseLoginEvent_sh;
end;

class function TDatabaseLoginEvent_sw.ToVar(
  const AValue: TDatabaseLoginEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDatabaseLoginEvent_sw.FromVar(
  const AValue: OleVariant): TDatabaseLoginEvent;
begin
  Result := TDatabaseLoginEvent(ConvFromVar(AValue));
end;

class function TDatabaseLoginEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TDatabaseLoginEvent;
var
  hdlr: TDatabaseLoginEvent_sh;
begin
  hdlr   := TDatabaseLoginEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDatabaseLoginEvent_sw));
  Result := hdlr.Handler;
end;

{ TDatabase_sw }

function TDatabase_CloseDataSets_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CloseDataSets;

  TDatabase(AObj).CloseDataSets();
end;

function TDatabase_Commit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Commit;

  TDatabase(AObj).Commit();
end;

function TDatabase_FlushSchemaCache_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FlushSchemaCache(const TableName: string);

  TDatabase(AObj).FlushSchemaCache(string(AArgs[0]));
end;

function TDatabase_GetFieldNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetFieldNames(const TableName: string; List: TS...

  TDatabase(AObj).GetFieldNames(string(AArgs[0]), TStrings_sw.FromVar(
    AArgs[1]));
end;

function TDatabase_GetTableNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetTableNames(List: TStrings; SystemTables: Boo...

  TDatabase(AObj).GetTableNames(TStrings_sw.FromVar(AArgs[0]), Boolean(
    AArgs[1]));
end;

function TDatabase_Rollback_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Rollback;

  TDatabase(AObj).Rollback();
end;

function TDatabase_StartTransaction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure StartTransaction;

  TDatabase(AObj).StartTransaction();
end;

function TDatabase_ValidateName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ValidateName(const Name: string);

  TDatabase(AObj).ValidateName(string(AArgs[0]));
end;

function TDatabase_DataSets_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSets[Index: Integer]: TDBDataSet read <getter>;

  Result := TDBDataSet_sw.ToVar(TDatabase(AObj).DataSets[Integer(AArgs[0])]);
end;

function TDatabase_Directory_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Directory: string read <getter> write <setter>;

  if IsGet then
    Result := TDatabase(AObj).Directory
  else
    TDatabase(AObj).Directory := string(AArgs[0]);
end;

function TDatabase_IsSQLBased_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsSQLBased: Boolean read <getter>;

  Result := TDatabase(AObj).IsSQLBased;
end;

function TDatabase_InTransaction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property InTransaction: Boolean read <getter>;

  Result := TDatabase(AObj).InTransaction;
end;

function TDatabase_Session_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Session: TSession read <getter>;

  Result := TSession_sw.ToVar(TDatabase(AObj).Session);
end;

function TDatabase_Temporary_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Temporary: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDatabase(AObj).Temporary
  else
    TDatabase(AObj).Temporary := Boolean(AArgs[0]);
end;

function TDatabase_SessionAlias_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SessionAlias: Boolean read <getter>;

  Result := TDatabase(AObj).SessionAlias;
end;

function TDatabase_TraceFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TraceFlags: TTraceFlags read <getter> write <set...

  if IsGet then
    Result := TTraceFlags_sw.ToVar(TDatabase(AObj).TraceFlags)
  else
    TDatabase(AObj).TraceFlags := TTraceFlags_sw.FromVar(AArgs[0]);
end;

function TDatabase_AliasName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AliasName: string read <getter> write <setter>;

  if IsGet then
    Result := TDatabase(AObj).AliasName
  else
    TDatabase(AObj).AliasName := string(AArgs[0]);
end;

function TDatabase_DatabaseName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DatabaseName: string read <getter> write <setter>;

  if IsGet then
    Result := TDatabase(AObj).DatabaseName
  else
    TDatabase(AObj).DatabaseName := string(AArgs[0]);
end;

function TDatabase_DriverName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DriverName: string read <getter> write <setter>;

  if IsGet then
    Result := TDatabase(AObj).DriverName
  else
    TDatabase(AObj).DriverName := string(AArgs[0]);
end;

function TDatabase_Exclusive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Exclusive: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDatabase(AObj).Exclusive
  else
    TDatabase(AObj).Exclusive := Boolean(AArgs[0]);
end;

function TDatabase_HandleShared_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HandleShared: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDatabase(AObj).HandleShared
  else
    TDatabase(AObj).HandleShared := Boolean(AArgs[0]);
end;

function TDatabase_KeepConnection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeepConnection: Boolean read <getter> write <set...

  if IsGet then
    Result := TDatabase(AObj).KeepConnection
  else
    TDatabase(AObj).KeepConnection := Boolean(AArgs[0]);
end;

function TDatabase_Params_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Params: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TDatabase(AObj).Params)
  else
    TDatabase(AObj).Params := TStrings_sw.FromVar(AArgs[0]);
end;

function TDatabase_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDatabase(AObj).ReadOnly
  else
    TDatabase(AObj).ReadOnly := Boolean(AArgs[0]);
end;

function TDatabase_SessionName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SessionName: string read <getter> write <setter>;

  if IsGet then
    Result := TDatabase(AObj).SessionName
  else
    TDatabase(AObj).SessionName := string(AArgs[0]);
end;

function TDatabase_TransIsolation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TransIsolation: TTransIsolation read <getter> wr...

  if IsGet then
    Result := TTransIsolation_sw.ToVar(TDatabase(AObj).TransIsolation)
  else
    TDatabase(AObj).TransIsolation := TTransIsolation_sw.FromVar(AArgs[0]);
end;

function TDatabase_OnLogin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnLogin: TDatabaseLoginEvent read <getter> write...

  if IsGet then
    Result := TDatabaseLoginEvent_sw.ToVar(TDatabase(AObj).OnLogin)
  else
    TDatabase(AObj).OnLogin := TDatabaseLoginEvent_sw.FromVar(AArgs[0]);
end;

class function TDatabase_sw.GetTypeName: WideString;
begin
  Result := 'TDatabase';
end;

class function TDatabase_sw.GetWrappedClass: TClass;
begin
  Result := TDatabase;
end;

class procedure TDatabase_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('CloseDataSets', TDatabase_CloseDataSets_si, 0, False);
  AData.AddProcedure('Commit', TDatabase_Commit_si, 0, False);
  AData.AddProcedure('FlushSchemaCache', TDatabase_FlushSchemaCache_si, 1, False);
  AData.AddProcedure('GetFieldNames', TDatabase_GetFieldNames_si, 2, False);
  AData.AddProcedure('GetTableNames', TDatabase_GetTableNames_si, 2, False);
  AData.AddProcedure('Rollback', TDatabase_Rollback_si, 0, False);
  AData.AddProcedure('StartTransaction', TDatabase_StartTransaction_si, 0, False);
  AData.AddProcedure('ValidateName', TDatabase_ValidateName_si, 1, False);
  AData.AddProperty('DataSets', TDatabase_DataSets_si, TDBDataSet_sw, True, False, 1, False);
  AData.AddProperty('Directory', TDatabase_Directory_si, string_sw, True, True, 0, False);
  AData.AddProperty('IsSQLBased', TDatabase_IsSQLBased_si, Boolean_sw, True, False, 0, False);
  AData.AddProperty('InTransaction', TDatabase_InTransaction_si, Boolean_sw, True, False, 0, False);
  AData.AddProperty('Session', TDatabase_Session_si, TSession_sw, True, False, 0, False);
  AData.AddProperty('Temporary', TDatabase_Temporary_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('SessionAlias', TDatabase_SessionAlias_si, Boolean_sw, True, False, 0, False);
  AData.AddProperty('TraceFlags', TDatabase_TraceFlags_si, TTraceFlags_sw, True, True, 0, False);
  AData.AddProperty('AliasName', TDatabase_AliasName_si, string_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Connected');
  AData.AddProperty('DatabaseName', TDatabase_DatabaseName_si, string_sw, True, True, 0, False);
  AData.AddProperty('DriverName', TDatabase_DriverName_si, string_sw, True, True, 0, False);
  AData.AddProperty('Exclusive', TDatabase_Exclusive_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('HandleShared', TDatabase_HandleShared_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('KeepConnection', TDatabase_KeepConnection_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('LoginPrompt');
  AData.AddProperty('Params', TDatabase_Params_si, TStrings_sw, True, True, 0, False);
  AData.AddProperty('ReadOnly', TDatabase_ReadOnly_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('SessionName', TDatabase_SessionName_si, string_sw, True, True, 0, False);
  AData.AddProperty('TransIsolation', TDatabase_TransIsolation_si, TTransIsolation_sw, True, True, 0, False);
  AData.AddPropertyRedecl('AfterConnect');
  AData.AddPropertyRedecl('AfterDisconnect');
  AData.AddPropertyRedecl('BeforeConnect');
  AData.AddPropertyRedecl('BeforeDisconnect');
  AData.AddProperty('OnLogin', TDatabase_OnLogin_si, TDatabaseLoginEvent_sw, True, True, 0, False);
end;

class function TDatabase_sw.ToVar(const AValue: TDatabase): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDatabase_sw.FromVar(const AValue: OleVariant): TDatabase;
begin
  Result := TDatabase(ConvFromVar(AValue, TDatabase));
end;

class function TDatabase_sw.ClassToVar(AClass: TDatabase_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDatabase_sw.ClassFromVar(
  const AClass: OleVariant): TDatabase_sc;
begin
  Result := TDatabase_sc(ConvClsFromVar(AClass, TDatabase));
end;

{ TRecNoStatus_sw }

class function TRecNoStatus_sw.GetTypeName: WideString;
begin
  Result := 'TRecNoStatus';
end;

class function TRecNoStatus_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TRecNoStatus);
end;

class function TRecNoStatus_sw.ToVar(const AValue: TRecNoStatus): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TRecNoStatus_sw.FromVar(const AValue: OleVariant): TRecNoStatus;
begin
  Result := TRecNoStatus(Integer(AValue));
end;

{ TDataSetUpdateObject_sw }

function TDataSetUpdateObject_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DataSet: TDataSet read <getter> write ...

  if IsGet then
    Result := TDataSet_sw.ToVar(TDataSetUpdateObject_sacc(TDataSetUpdateObject(
      AObj)).DataSet)
  else
    TDataSetUpdateObject_sacc(TDataSetUpdateObject(AObj)).DataSet := 
      TDataSet_sw.FromVar(AArgs[0]);
end;

function TDataSetUpdateObject_Apply_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Apply(UpdateKind: TUpdateKind);

  TDataSetUpdateObject(AObj).Apply(TUpdateKind_sw.FromVar(AArgs[0]));
end;

class function TDataSetUpdateObject_sw.GetTypeName: WideString;
begin
  Result := 'TDataSetUpdateObject';
end;

class function TDataSetUpdateObject_sw.GetWrappedClass: TClass;
begin
  Result := TDataSetUpdateObject;
end;

class procedure TDataSetUpdateObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DataSet', TDataSetUpdateObject_DataSet_si, TDataSet_sw, True, True, 0, True);
  AData.AddProcedure('Apply', TDataSetUpdateObject_Apply_si, 1, False);
end;

class function TDataSetUpdateObject_sw.ToVar(
  const AValue: TDataSetUpdateObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDataSetUpdateObject_sw.FromVar(
  const AValue: OleVariant): TDataSetUpdateObject;
begin
  Result := TDataSetUpdateObject(ConvFromVar(AValue, TDataSetUpdateObject));
end;

class function TDataSetUpdateObject_sw.ClassToVar(
  AClass: TDataSetUpdateObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDataSetUpdateObject_sw.ClassFromVar(
  const AClass: OleVariant): TDataSetUpdateObject_sc;
begin
  Result := TDataSetUpdateObject_sc(ConvClsFromVar(AClass, 
    TDataSetUpdateObject));
end;

{ TSQLUpdateObject_sw }

class function TSQLUpdateObject_sw.GetTypeName: WideString;
begin
  Result := 'TSQLUpdateObject';
end;

class function TSQLUpdateObject_sw.GetWrappedClass: TClass;
begin
  Result := TSQLUpdateObject;
end;

class procedure TSQLUpdateObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TSQLUpdateObject_sw.ToVar(
  const AValue: TSQLUpdateObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSQLUpdateObject_sw.FromVar(
  const AValue: OleVariant): TSQLUpdateObject;
begin
  Result := TSQLUpdateObject(ConvFromVar(AValue, TSQLUpdateObject));
end;

class function TSQLUpdateObject_sw.ClassToVar(
  AClass: TSQLUpdateObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSQLUpdateObject_sw.ClassFromVar(
  const AClass: OleVariant): TSQLUpdateObject_sc;
begin
  Result := TSQLUpdateObject_sc(ConvClsFromVar(AClass, TSQLUpdateObject));
end;

{ TBDEKeyBuffer_sw }

function TBDEKeyBuffer_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TBDEKeyBuffer_sw.ToVar(TBDEKeyBuffer(AObj));
end;

function TBDEKeyBuffer_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TBDEKeyBuffer_sw.Create as IDispatch;
end;

function TBDEKeyBuffer_Modified_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Modified: Boolean;

  if IsGet then
    Result := TBDEKeyBuffer_sw(AObj).FValue.Modified
  else
    TBDEKeyBuffer_sw(AObj).FValue.Modified := Boolean(AArgs[0]);
end;

function TBDEKeyBuffer_Exclusive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Exclusive: Boolean;

  if IsGet then
    Result := TBDEKeyBuffer_sw(AObj).FValue.Exclusive
  else
    TBDEKeyBuffer_sw(AObj).FValue.Exclusive := Boolean(AArgs[0]);
end;

function TBDEKeyBuffer_FieldCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FieldCount: Integer;

  if IsGet then
    Result := TBDEKeyBuffer_sw(AObj).FValue.FieldCount
  else
    TBDEKeyBuffer_sw(AObj).FValue.FieldCount := Integer(AArgs[0]);
end;

class function TBDEKeyBuffer_sw.GetTypeName: WideString;
begin
  Result := 'TBDEKeyBuffer';
end;

function TBDEKeyBuffer_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TBDEKeyBuffer_sw.Create;
  TBDEKeyBuffer_sw(Result).FValue := FValue;
end;

class procedure TBDEKeyBuffer_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TBDEKeyBuffer_Copy_si, TBDEKeyBuffer_sw, 0);
  AData.AddField('Modified', TBDEKeyBuffer_Modified_si, Boolean_sw);
  AData.AddField('Exclusive', TBDEKeyBuffer_Exclusive_si, Boolean_sw);
  AData.AddField('FieldCount', TBDEKeyBuffer_FieldCount_si, Integer_sw);

  { Class members }

  AData.AddConstructor('Create', TBDEKeyBuffer_Create_si, 0);
end;

class function TBDEKeyBuffer_sw.ToVar(const AValue: TBDEKeyBuffer): OleVariant;
var
  wrpr: TBDEKeyBuffer_sw;
begin
  wrpr        := TBDEKeyBuffer_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TBDEKeyBuffer_sw.FromVar(
  const AValue: OleVariant): TBDEKeyBuffer;
begin
  Result := TBDEKeyBuffer_sw(ConvFromVar(AValue)).FValue;
end;

{ TBDERecInfo_sw }

function TBDERecInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TBDERecInfo_sw.ToVar(TBDERecInfo(AObj));
end;

function TBDERecInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TBDERecInfo_sw.Create as IDispatch;
end;

function TBDERecInfo_RecordNumber_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var RecordNumber: Longint;

  if IsGet then
    Result := TBDERecInfo_sw(AObj).FValue.RecordNumber
  else
    TBDERecInfo_sw(AObj).FValue.RecordNumber := Longint(AArgs[0]);
end;

function TBDERecInfo_UpdateStatus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var UpdateStatus: TUpdateStatus;

  if IsGet then
    Result := TUpdateStatus_sw.ToVar(TBDERecInfo_sw(AObj).FValue.UpdateStatus)
  else
    TBDERecInfo_sw(AObj).FValue.UpdateStatus := TUpdateStatus_sw.FromVar(
      AArgs[0]);
end;

function TBDERecInfo_BookmarkFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BookmarkFlag: TBookmarkFlag;

  if IsGet then
    Result := TBookmarkFlag_sw.ToVar(TBDERecInfo_sw(AObj).FValue.BookmarkFlag)
  else
    TBDERecInfo_sw(AObj).FValue.BookmarkFlag := TBookmarkFlag_sw.FromVar(
      AArgs[0]);
end;

class function TBDERecInfo_sw.GetTypeName: WideString;
begin
  Result := 'TBDERecInfo';
end;

function TBDERecInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TBDERecInfo_sw.Create;
  TBDERecInfo_sw(Result).FValue := FValue;
end;

class procedure TBDERecInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TBDERecInfo_Copy_si, TBDERecInfo_sw, 0);
  AData.AddField('RecordNumber', TBDERecInfo_RecordNumber_si, Longint_sw);
  AData.AddField('UpdateStatus', TBDERecInfo_UpdateStatus_si, TUpdateStatus_sw);
  AData.AddField('BookmarkFlag', TBDERecInfo_BookmarkFlag_si, TBookmarkFlag_sw);

  { Class members }

  AData.AddConstructor('Create', TBDERecInfo_Create_si, 0);
end;

class function TBDERecInfo_sw.ToVar(const AValue: TBDERecInfo): OleVariant;
var
  wrpr: TBDERecInfo_sw;
begin
  wrpr        := TBDERecInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TBDERecInfo_sw.FromVar(const AValue: OleVariant): TBDERecInfo;
begin
  Result := TBDERecInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TBDEDataSet_sw }

function TBDEDataSet_ApplyUpdates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ApplyUpdates;

  TBDEDataSet(AObj).ApplyUpdates();
end;

function TBDEDataSet_CancelUpdates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CancelUpdates;

  TBDEDataSet(AObj).CancelUpdates();
end;

function TBDEDataSet_CacheBlobs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CacheBlobs: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TBDEDataSet(AObj).CacheBlobs
  else
    TBDEDataSet(AObj).CacheBlobs := Boolean(AArgs[0]);
end;

function TBDEDataSet_CommitUpdates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CommitUpdates;

  TBDEDataSet(AObj).CommitUpdates();
end;

function TBDEDataSet_ConstraintsDisabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ConstraintsDisabled: Boolean;

  Result := TBDEDataSet(AObj).ConstraintsDisabled();
end;

function TBDEDataSet_DisableConstraints_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DisableConstraints;

  TBDEDataSet(AObj).DisableConstraints();
end;

function TBDEDataSet_EnableConstraints_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EnableConstraints;

  TBDEDataSet(AObj).EnableConstraints();
end;

function TBDEDataSet_FetchAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FetchAll;

  TBDEDataSet(AObj).FetchAll();
end;

function TBDEDataSet_FlushBuffers_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FlushBuffers;

  TBDEDataSet(AObj).FlushBuffers();
end;

function TBDEDataSet_GetIndexInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetIndexInfo;

  TBDEDataSet(AObj).GetIndexInfo();
end;

function TBDEDataSet_RevertRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RevertRecord;

  TBDEDataSet(AObj).RevertRecord();
end;

function TBDEDataSet_ExpIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExpIndex: Boolean read <getter>;

  Result := TBDEDataSet(AObj).ExpIndex;
end;

function TBDEDataSet_KeySize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeySize: Word read <getter>;

  Result := TBDEDataSet(AObj).KeySize;
end;

function TBDEDataSet_UpdateObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UpdateObject: TDataSetUpdateObject read <getter>...

  if IsGet then
    Result := TDataSetUpdateObject_sw.ToVar(TBDEDataSet(AObj).UpdateObject)
  else
    TBDEDataSet(AObj).UpdateObject := TDataSetUpdateObject_sw.FromVar(AArgs[0]);
end;

function TBDEDataSet_UpdatesPending_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UpdatesPending: Boolean read <getter>;

  Result := TBDEDataSet(AObj).UpdatesPending;
end;

function TBDEDataSet_CachedUpdates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CachedUpdates: Boolean read <getter> write <sett...

  if IsGet then
    Result := TBDEDataSet(AObj).CachedUpdates
  else
    TBDEDataSet(AObj).CachedUpdates := Boolean(AArgs[0]);
end;

function TBDEDataSet_OnUpdateError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnUpdateError: TUpdateErrorEvent read <getter> w...

  if IsGet then
    Result := TUpdateErrorEvent_sw.ToVar(TBDEDataSet(AObj).OnUpdateError)
  else
    TBDEDataSet(AObj).OnUpdateError := TUpdateErrorEvent_sw.FromVar(AArgs[0]);
end;

function TBDEDataSet_OnUpdateRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnUpdateRecord: TUpdateRecordEvent read <getter>...

  if IsGet then
    Result := TUpdateRecordEvent_sw.ToVar(TBDEDataSet(AObj).OnUpdateRecord)
  else
    TBDEDataSet(AObj).OnUpdateRecord := TUpdateRecordEvent_sw.FromVar(AArgs[0]);
end;

class function TBDEDataSet_sw.GetTypeName: WideString;
begin
  Result := 'TBDEDataSet';
end;

class function TBDEDataSet_sw.GetWrappedClass: TClass;
begin
  Result := TBDEDataSet;
end;

class procedure TBDEDataSet_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ApplyUpdates', TBDEDataSet_ApplyUpdates_si, 0, False);
  AData.AddProcedure('CancelUpdates', TBDEDataSet_CancelUpdates_si, 0, False);
  AData.AddProperty('CacheBlobs', TBDEDataSet_CacheBlobs_si, Boolean_sw, True, True, 0, False);
  AData.AddProcedure('CommitUpdates', TBDEDataSet_CommitUpdates_si, 0, False);
  AData.AddFunction('ConstraintsDisabled', TBDEDataSet_ConstraintsDisabled_si, Boolean_sw, 0, False);
  AData.AddProcedure('DisableConstraints', TBDEDataSet_DisableConstraints_si, 0, False);
  AData.AddProcedure('EnableConstraints', TBDEDataSet_EnableConstraints_si, 0, False);
  AData.AddProcedure('FetchAll', TBDEDataSet_FetchAll_si, 0, False);
  AData.AddProcedure('FlushBuffers', TBDEDataSet_FlushBuffers_si, 0, False);
  AData.AddProcedure('GetIndexInfo', TBDEDataSet_GetIndexInfo_si, 0, False);
  AData.AddProcedure('RevertRecord', TBDEDataSet_RevertRecord_si, 0, False);
  AData.AddProperty('ExpIndex', TBDEDataSet_ExpIndex_si, Boolean_sw, True, False, 0, False);
  AData.AddProperty('KeySize', TBDEDataSet_KeySize_si, Word_sw, True, False, 0, False);
  AData.AddProperty('UpdateObject', TBDEDataSet_UpdateObject_si, TDataSetUpdateObject_sw, True, True, 0, False);
  AData.AddProperty('UpdatesPending', TBDEDataSet_UpdatesPending_si, Boolean_sw, True, False, 0, False);
  AData.AddPropertyRedecl('Active');
  AData.AddPropertyRedecl('AutoCalcFields');
  AData.AddProperty('CachedUpdates', TBDEDataSet_CachedUpdates_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('ObjectView');
  AData.AddPropertyRedecl('BeforeOpen');
  AData.AddPropertyRedecl('AfterOpen');
  AData.AddPropertyRedecl('BeforeClose');
  AData.AddPropertyRedecl('AfterClose');
  AData.AddPropertyRedecl('BeforeInsert');
  AData.AddPropertyRedecl('AfterInsert');
  AData.AddPropertyRedecl('BeforeEdit');
  AData.AddPropertyRedecl('AfterEdit');
  AData.AddPropertyRedecl('BeforePost');
  AData.AddPropertyRedecl('AfterPost');
  AData.AddPropertyRedecl('BeforeCancel');
  AData.AddPropertyRedecl('AfterCancel');
  AData.AddPropertyRedecl('BeforeDelete');
  AData.AddPropertyRedecl('AfterDelete');
  AData.AddPropertyRedecl('BeforeScroll');
  AData.AddPropertyRedecl('AfterScroll');
  AData.AddPropertyRedecl('BeforeRefresh');
  AData.AddPropertyRedecl('AfterRefresh');
  AData.AddPropertyRedecl('OnCalcFields');
  AData.AddPropertyRedecl('OnDeleteError');
  AData.AddPropertyRedecl('OnEditError');
  AData.AddPropertyRedecl('OnNewRecord');
  AData.AddPropertyRedecl('OnPostError');
  AData.AddProperty('OnUpdateError', TBDEDataSet_OnUpdateError_si, TUpdateErrorEvent_sw, True, True, 0, False);
  AData.AddProperty('OnUpdateRecord', TBDEDataSet_OnUpdateRecord_si, TUpdateRecordEvent_sw, True, True, 0, False);
end;

class function TBDEDataSet_sw.ToVar(const AValue: TBDEDataSet): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBDEDataSet_sw.FromVar(const AValue: OleVariant): TBDEDataSet;
begin
  Result := TBDEDataSet(ConvFromVar(AValue, TBDEDataSet));
end;

class function TBDEDataSet_sw.ClassToVar(AClass: TBDEDataSet_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBDEDataSet_sw.ClassFromVar(
  const AClass: OleVariant): TBDEDataSet_sc;
begin
  Result := TBDEDataSet_sc(ConvClsFromVar(AClass, TBDEDataSet));
end;

{ TNestedTable_sw }

class function TNestedTable_sw.GetTypeName: WideString;
begin
  Result := 'TNestedTable';
end;

class function TNestedTable_sw.GetWrappedClass: TClass;
begin
  Result := TNestedTable;
end;

class procedure TNestedTable_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('DataSetField');
  AData.AddPropertyRedecl('ObjectView');
end;

class function TNestedTable_sw.ToVar(const AValue: TNestedTable): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TNestedTable_sw.FromVar(const AValue: OleVariant): TNestedTable;
begin
  Result := TNestedTable(ConvFromVar(AValue, TNestedTable));
end;

class function TNestedTable_sw.ClassToVar(AClass: TNestedTable_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TNestedTable_sw.ClassFromVar(
  const AClass: OleVariant): TNestedTable_sc;
begin
  Result := TNestedTable_sc(ConvClsFromVar(AClass, TNestedTable));
end;

{ TDBDataSet_sw }

function TDBDataSet_UpdateMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property UpdateMode: TUpdateMode read <getter> ...

  if IsGet then
    Result := TUpdateMode_sw.ToVar(TDBDataSet_sacc(TDBDataSet(AObj)).UpdateMode)
  else
    TDBDataSet_sacc(TDBDataSet(AObj)).UpdateMode := TUpdateMode_sw.FromVar(
      AArgs[0]);
end;

function TDBDataSet_CloseDatabase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CloseDatabase(Database: TDatabase);

  TDBDataSet(AObj).CloseDatabase(TDatabase_sw.FromVar(AArgs[0]));
end;

function TDBDataSet_OpenDatabase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function OpenDatabase: TDatabase;

  Result := TDatabase_sw.ToVar(TDBDataSet(AObj).OpenDatabase());
end;

function TDBDataSet_Database_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Database: TDatabase read <getter>;

  Result := TDatabase_sw.ToVar(TDBDataSet(AObj).Database);
end;

function TDBDataSet_DBSession_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DBSession: TSession read <getter>;

  Result := TSession_sw.ToVar(TDBDataSet(AObj).DBSession);
end;

function TDBDataSet_AutoRefresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoRefresh: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBDataSet(AObj).AutoRefresh
  else
    TDBDataSet(AObj).AutoRefresh := Boolean(AArgs[0]);
end;

function TDBDataSet_DatabaseName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DatabaseName: string read <getter> write <setter>;

  if IsGet then
    Result := TDBDataSet(AObj).DatabaseName
  else
    TDBDataSet(AObj).DatabaseName := string(AArgs[0]);
end;

function TDBDataSet_SessionName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SessionName: string read <getter> write <setter>;

  if IsGet then
    Result := TDBDataSet(AObj).SessionName
  else
    TDBDataSet(AObj).SessionName := string(AArgs[0]);
end;

class function TDBDataSet_sw.GetTypeName: WideString;
begin
  Result := 'TDBDataSet';
end;

class function TDBDataSet_sw.GetWrappedClass: TClass;
begin
  Result := TDBDataSet;
end;

class procedure TDBDataSet_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('UpdateMode', TDBDataSet_UpdateMode_si, TUpdateMode_sw, True, True, 0, True);
  AData.AddProcedure('CloseDatabase', TDBDataSet_CloseDatabase_si, 1, False);
  AData.AddFunction('OpenDatabase', TDBDataSet_OpenDatabase_si, TDatabase_sw, 0, False);
  AData.AddProperty('Database', TDBDataSet_Database_si, TDatabase_sw, True, False, 0, False);
  AData.AddProperty('DBSession', TDBDataSet_DBSession_si, TSession_sw, True, False, 0, False);
  AData.AddProperty('AutoRefresh', TDBDataSet_AutoRefresh_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('DatabaseName', TDBDataSet_DatabaseName_si, string_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Filter');
  AData.AddPropertyRedecl('Filtered');
  AData.AddPropertyRedecl('FilterOptions');
  AData.AddProperty('SessionName', TDBDataSet_SessionName_si, string_sw, True, True, 0, False);
  AData.AddPropertyRedecl('OnFilterRecord');
end;

class function TDBDataSet_sw.ToVar(const AValue: TDBDataSet): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBDataSet_sw.FromVar(const AValue: OleVariant): TDBDataSet;
begin
  Result := TDBDataSet(ConvFromVar(AValue, TDBDataSet));
end;

class function TDBDataSet_sw.ClassToVar(AClass: TDBDataSet_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBDataSet_sw.ClassFromVar(
  const AClass: OleVariant): TDBDataSet_sc;
begin
  Result := TDBDataSet_sc(ConvClsFromVar(AClass, TDBDataSet));
end;

{ TBatchMode_sw }

class function TBatchMode_sw.GetTypeName: WideString;
begin
  Result := 'TBatchMode';
end;

class function TBatchMode_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TBatchMode);
end;

class function TBatchMode_sw.ToVar(const AValue: TBatchMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBatchMode_sw.FromVar(const AValue: OleVariant): TBatchMode;
begin
  Result := TBatchMode(Integer(AValue));
end;

{ TTableType_sw }

class function TTableType_sw.GetTypeName: WideString;
begin
  Result := 'TTableType';
end;

class function TTableType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TTableType);
end;

class function TTableType_sw.ToVar(const AValue: TTableType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTableType_sw.FromVar(const AValue: OleVariant): TTableType;
begin
  Result := TTableType(Integer(AValue));
end;

{ TLockType_sw }

class function TLockType_sw.GetTypeName: WideString;
begin
  Result := 'TLockType';
end;

class function TLockType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TLockType);
end;

class function TLockType_sw.ToVar(const AValue: TLockType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TLockType_sw.FromVar(const AValue: OleVariant): TLockType;
begin
  Result := TLockType(Integer(AValue));
end;

{ TIndexFiles_sw }

function TIndexFiles_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TTable);

  Result := TIndexFiles_sw.ToVar(TIndexFiles_sc(AObj).Create(TTable_sw.FromVar(
    AArgs[0])));
end;

class function TIndexFiles_sw.GetTypeName: WideString;
begin
  Result := 'TIndexFiles';
end;

class function TIndexFiles_sw.GetWrappedClass: TClass;
begin
  Result := TIndexFiles;
end;

class procedure TIndexFiles_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TIndexFiles_Create_si, 1, False);
end;

class function TIndexFiles_sw.ToVar(const AValue: TIndexFiles): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TIndexFiles_sw.FromVar(const AValue: OleVariant): TIndexFiles;
begin
  Result := TIndexFiles(ConvFromVar(AValue, TIndexFiles));
end;

class function TIndexFiles_sw.ClassToVar(AClass: TIndexFiles_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TIndexFiles_sw.ClassFromVar(
  const AClass: OleVariant): TIndexFiles_sc;
begin
  Result := TIndexFiles_sc(ConvClsFromVar(AClass, TIndexFiles));
end;

{ TTable_sw }

function TTable_MasterLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MasterLink: TMasterDataLink read <gett...

  Result := TMasterDataLink_sw.ToVar(TTable_sacc(TTable(AObj)).MasterLink);
end;

function TTable_BatchMove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function BatchMove(ASource: TBDEDataSet; AMode: TBatchMod...

  Result := TTable(AObj).BatchMove(TBDEDataSet_sw.FromVar(AArgs[0]), 
    TBatchMode_sw.FromVar(AArgs[1]));
end;

function TTable_AddIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AddIndex(const Name: string; const Fields: stri...

  TTable(AObj).AddIndex(string(AArgs[0]), string(AArgs[1]), TIndexOptions_sw.
    FromVar(AArgs[2]), string(AArgs[3]));
end;

function TTable_ApplyRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ApplyRange;

  TTable(AObj).ApplyRange();
end;

function TTable_CancelRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CancelRange;

  TTable(AObj).CancelRange();
end;

function TTable_CloseIndexFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CloseIndexFile(const IndexFileName: string);

  TTable(AObj).CloseIndexFile(string(AArgs[0]));
end;

function TTable_CreateTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CreateTable;

  TTable(AObj).CreateTable();
end;

function TTable_DeleteIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DeleteIndex(const Name: string);

  TTable(AObj).DeleteIndex(string(AArgs[0]));
end;

function TTable_DeleteTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DeleteTable;

  TTable(AObj).DeleteTable();
end;

function TTable_EditKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EditKey;

  TTable(AObj).EditKey();
end;

function TTable_EditRangeEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EditRangeEnd;

  TTable(AObj).EditRangeEnd();
end;

function TTable_EditRangeStart_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EditRangeStart;

  TTable(AObj).EditRangeStart();
end;

function TTable_EmptyTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EmptyTable;

  TTable(AObj).EmptyTable();
end;

function TTable_GetIndexNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetIndexNames(List: TStrings);

  TTable(AObj).GetIndexNames(TStrings_sw.FromVar(AArgs[0]));
end;

function TTable_GotoCurrent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GotoCurrent(Table: TTable);

  TTable(AObj).GotoCurrent(TTable_sw.FromVar(AArgs[0]));
end;

function TTable_GotoKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GotoKey: Boolean;

  Result := TTable(AObj).GotoKey();
end;

function TTable_GotoNearest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GotoNearest;

  TTable(AObj).GotoNearest();
end;

function TTable_LockTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LockTable(LockType: TLockType);

  TTable(AObj).LockTable(TLockType_sw.FromVar(AArgs[0]));
end;

function TTable_OpenIndexFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure OpenIndexFile(const IndexName: string);

  TTable(AObj).OpenIndexFile(string(AArgs[0]));
end;

function TTable_RenameTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RenameTable(const NewTableName: string);

  TTable(AObj).RenameTable(string(AArgs[0]));
end;

function TTable_SetKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetKey;

  TTable(AObj).SetKey();
end;

function TTable_SetRangeEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetRangeEnd;

  TTable(AObj).SetRangeEnd();
end;

function TTable_SetRangeStart_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetRangeStart;

  TTable(AObj).SetRangeStart();
end;

function TTable_UnlockTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnlockTable(LockType: TLockType);

  TTable(AObj).UnlockTable(TLockType_sw.FromVar(AArgs[0]));
end;

function TTable_Exists_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Exists: Boolean read <getter>;

  Result := TTable(AObj).Exists;
end;

function TTable_IndexFieldCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexFieldCount: Integer read <getter>;

  Result := TTable(AObj).IndexFieldCount;
end;

function TTable_IndexFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexFields[Index: Integer]: TField read <getter...

  if IsGet then
    Result := TField_sw.ToVar(TTable(AObj).IndexFields[Integer(AArgs[0])])
  else
    TTable(AObj).IndexFields[Integer(AArgs[0])] := TField_sw.FromVar(AArgs[1]);
end;

function TTable_KeyExclusive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeyExclusive: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTable(AObj).KeyExclusive
  else
    TTable(AObj).KeyExclusive := Boolean(AArgs[0]);
end;

function TTable_KeyFieldCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeyFieldCount: Integer read <getter> write <sett...

  if IsGet then
    Result := TTable(AObj).KeyFieldCount
  else
    TTable(AObj).KeyFieldCount := Integer(AArgs[0]);
end;

function TTable_TableLevel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TableLevel: Integer read <getter> write <setter>;

  if IsGet then
    Result := TTable(AObj).TableLevel
  else
    TTable(AObj).TableLevel := Integer(AArgs[0]);
end;

function TTable_DefaultIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultIndex: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTable(AObj).DefaultIndex
  else
    TTable(AObj).DefaultIndex := Boolean(AArgs[0]);
end;

function TTable_Exclusive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Exclusive: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTable(AObj).Exclusive
  else
    TTable(AObj).Exclusive := Boolean(AArgs[0]);
end;

function TTable_IndexDefs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexDefs: TIndexDefs read <getter> write <setter>;

  if IsGet then
    Result := TIndexDefs_sw.ToVar(TTable(AObj).IndexDefs)
  else
    TTable(AObj).IndexDefs := TIndexDefs_sw.FromVar(AArgs[0]);
end;

function TTable_IndexFieldNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexFieldNames: string read <getter> write <set...

  if IsGet then
    Result := TTable(AObj).IndexFieldNames
  else
    TTable(AObj).IndexFieldNames := string(AArgs[0]);
end;

function TTable_IndexFiles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexFiles: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TTable(AObj).IndexFiles)
  else
    TTable(AObj).IndexFiles := TStrings_sw.FromVar(AArgs[0]);
end;

function TTable_IndexName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexName: string read <getter> write <setter>;

  if IsGet then
    Result := TTable(AObj).IndexName
  else
    TTable(AObj).IndexName := string(AArgs[0]);
end;

function TTable_MasterFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MasterFields: string read <getter> write <setter>;

  if IsGet then
    Result := TTable(AObj).MasterFields
  else
    TTable(AObj).MasterFields := string(AArgs[0]);
end;

function TTable_MasterSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MasterSource: TDataSource read <getter> write <s...

  if IsGet then
    Result := TDataSource_sw.ToVar(TTable(AObj).MasterSource)
  else
    TTable(AObj).MasterSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TTable_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTable(AObj).ReadOnly
  else
    TTable(AObj).ReadOnly := Boolean(AArgs[0]);
end;

function TTable_StoreDefs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StoreDefs: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TTable(AObj).StoreDefs
  else
    TTable(AObj).StoreDefs := Boolean(AArgs[0]);
end;

function TTable_TableName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TableName: TFileName read <getter> write <setter>;

  if IsGet then
    Result := TFileName_sw.ToVar(TTable(AObj).TableName)
  else
    TTable(AObj).TableName := TFileName_sw.FromVar(AArgs[0]);
end;

function TTable_TableType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TableType: TTableType read <getter> write <setter>;

  if IsGet then
    Result := TTableType_sw.ToVar(TTable(AObj).TableType)
  else
    TTable(AObj).TableType := TTableType_sw.FromVar(AArgs[0]);
end;

function TTable_Ranged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Ranged: Boolean read <getter>;

  Result := TTable(AObj).Ranged;
end;

class function TTable_sw.GetTypeName: WideString;
begin
  Result := 'TTable';
end;

class function TTable_sw.GetWrappedClass: TClass;
begin
  Result := TTable;
end;

class procedure TTable_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('MasterLink', TTable_MasterLink_si, TMasterDataLink_sw, True, False, 0, True);
  AData.AddFunction('BatchMove', TTable_BatchMove_si, Longint_sw, 2, False);
  AData.AddProcedure('AddIndex', TTable_AddIndex_si, 4, False);
  AData.AddProcedure('ApplyRange', TTable_ApplyRange_si, 0, False);
  AData.AddProcedure('CancelRange', TTable_CancelRange_si, 0, False);
  AData.AddProcedure('CloseIndexFile', TTable_CloseIndexFile_si, 1, False);
  AData.AddProcedure('CreateTable', TTable_CreateTable_si, 0, False);
  AData.AddProcedure('DeleteIndex', TTable_DeleteIndex_si, 1, False);
  AData.AddProcedure('DeleteTable', TTable_DeleteTable_si, 0, False);
  AData.AddProcedure('EditKey', TTable_EditKey_si, 0, False);
  AData.AddProcedure('EditRangeEnd', TTable_EditRangeEnd_si, 0, False);
  AData.AddProcedure('EditRangeStart', TTable_EditRangeStart_si, 0, False);
  AData.AddProcedure('EmptyTable', TTable_EmptyTable_si, 0, False);
  AData.AddProcedure('GetIndexNames', TTable_GetIndexNames_si, 1, False);
  AData.AddProcedure('GotoCurrent', TTable_GotoCurrent_si, 1, False);
  AData.AddFunction('GotoKey', TTable_GotoKey_si, Boolean_sw, 0, False);
  AData.AddProcedure('GotoNearest', TTable_GotoNearest_si, 0, False);
  AData.AddProcedure('LockTable', TTable_LockTable_si, 1, False);
  AData.AddProcedure('OpenIndexFile', TTable_OpenIndexFile_si, 1, False);
  AData.AddProcedure('RenameTable', TTable_RenameTable_si, 1, False);
  AData.AddProcedure('SetKey', TTable_SetKey_si, 0, False);
  AData.AddProcedure('SetRangeEnd', TTable_SetRangeEnd_si, 0, False);
  AData.AddProcedure('SetRangeStart', TTable_SetRangeStart_si, 0, False);
  AData.AddProcedure('UnlockTable', TTable_UnlockTable_si, 1, False);
  AData.AddProperty('Exists', TTable_Exists_si, Boolean_sw, True, False, 0, False);
  AData.AddProperty('IndexFieldCount', TTable_IndexFieldCount_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('IndexFields', TTable_IndexFields_si, TField_sw, True, True, 1, False);
  AData.AddProperty('KeyExclusive', TTable_KeyExclusive_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('KeyFieldCount', TTable_KeyFieldCount_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('TableLevel', TTable_TableLevel_si, Integer_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Constraints');
  AData.AddProperty('DefaultIndex', TTable_DefaultIndex_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('Exclusive', TTable_Exclusive_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('FieldDefs');
  AData.AddProperty('IndexDefs', TTable_IndexDefs_si, TIndexDefs_sw, True, True, 0, False);
  AData.AddProperty('IndexFieldNames', TTable_IndexFieldNames_si, string_sw, True, True, 0, False);
  AData.AddProperty('IndexFiles', TTable_IndexFiles_si, TStrings_sw, True, True, 0, False);
  AData.AddProperty('IndexName', TTable_IndexName_si, string_sw, True, True, 0, False);
  AData.AddProperty('MasterFields', TTable_MasterFields_si, string_sw, True, True, 0, False);
  AData.AddProperty('MasterSource', TTable_MasterSource_si, TDataSource_sw, True, True, 0, False);
  AData.AddProperty('ReadOnly', TTable_ReadOnly_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('StoreDefs', TTable_StoreDefs_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('TableName', TTable_TableName_si, TFileName_sw, True, True, 0, False);
  AData.AddProperty('TableType', TTable_TableType_si, TTableType_sw, True, True, 0, False);
  AData.AddPropertyRedecl('UpdateMode');
  AData.AddPropertyRedecl('UpdateObject');
  AData.AddProperty('Ranged', TTable_Ranged_si, Boolean_sw, True, False, 0, False);
end;

class function TTable_sw.ToVar(const AValue: TTable): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTable_sw.FromVar(const AValue: OleVariant): TTable;
begin
  Result := TTable(ConvFromVar(AValue, TTable));
end;

class function TTable_sw.ClassToVar(AClass: TTable_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTable_sw.ClassFromVar(const AClass: OleVariant): TTable_sc;
begin
  Result := TTable_sc(ConvClsFromVar(AClass, TTable));
end;

{ TBatchMove_sw }

function TBatchMove_Execute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Execute;

  TBatchMove(AObj).Execute();
end;

function TBatchMove_ChangedCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ChangedCount: Longint read <getter>;

  Result := TBatchMove(AObj).ChangedCount;
end;

function TBatchMove_KeyViolCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeyViolCount: Longint read <getter>;

  Result := TBatchMove(AObj).KeyViolCount;
end;

function TBatchMove_MovedCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MovedCount: Longint read <getter>;

  Result := TBatchMove(AObj).MovedCount;
end;

function TBatchMove_ProblemCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ProblemCount: Longint read <getter>;

  Result := TBatchMove(AObj).ProblemCount;
end;

function TBatchMove_AbortOnKeyViol_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AbortOnKeyViol: Boolean read <getter> write <set...

  if IsGet then
    Result := TBatchMove(AObj).AbortOnKeyViol
  else
    TBatchMove(AObj).AbortOnKeyViol := Boolean(AArgs[0]);
end;

function TBatchMove_AbortOnProblem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AbortOnProblem: Boolean read <getter> write <set...

  if IsGet then
    Result := TBatchMove(AObj).AbortOnProblem
  else
    TBatchMove(AObj).AbortOnProblem := Boolean(AArgs[0]);
end;

function TBatchMove_CommitCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CommitCount: Integer read <getter> write <setter>;

  if IsGet then
    Result := TBatchMove(AObj).CommitCount
  else
    TBatchMove(AObj).CommitCount := Integer(AArgs[0]);
end;

function TBatchMove_ChangedTableName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ChangedTableName: TFileName read <getter> write ...

  if IsGet then
    Result := TFileName_sw.ToVar(TBatchMove(AObj).ChangedTableName)
  else
    TBatchMove(AObj).ChangedTableName := TFileName_sw.FromVar(AArgs[0]);
end;

function TBatchMove_Destination_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Destination: TTable read <getter> write <setter>;

  if IsGet then
    Result := TTable_sw.ToVar(TBatchMove(AObj).Destination)
  else
    TBatchMove(AObj).Destination := TTable_sw.FromVar(AArgs[0]);
end;

function TBatchMove_KeyViolTableName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeyViolTableName: TFileName read <getter> write ...

  if IsGet then
    Result := TFileName_sw.ToVar(TBatchMove(AObj).KeyViolTableName)
  else
    TBatchMove(AObj).KeyViolTableName := TFileName_sw.FromVar(AArgs[0]);
end;

function TBatchMove_Mappings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Mappings: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TBatchMove(AObj).Mappings)
  else
    TBatchMove(AObj).Mappings := TStrings_sw.FromVar(AArgs[0]);
end;

function TBatchMove_Mode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Mode: TBatchMode read <getter> write <setter>;

  if IsGet then
    Result := TBatchMode_sw.ToVar(TBatchMove(AObj).Mode)
  else
    TBatchMove(AObj).Mode := TBatchMode_sw.FromVar(AArgs[0]);
end;

function TBatchMove_ProblemTableName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ProblemTableName: TFileName read <getter> write ...

  if IsGet then
    Result := TFileName_sw.ToVar(TBatchMove(AObj).ProblemTableName)
  else
    TBatchMove(AObj).ProblemTableName := TFileName_sw.FromVar(AArgs[0]);
end;

function TBatchMove_RecordCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RecordCount: Longint read <getter> write <setter>;

  if IsGet then
    Result := TBatchMove(AObj).RecordCount
  else
    TBatchMove(AObj).RecordCount := Longint(AArgs[0]);
end;

function TBatchMove_Source_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Source: TBDEDataSet read <getter> write <setter>;

  if IsGet then
    Result := TBDEDataSet_sw.ToVar(TBatchMove(AObj).Source)
  else
    TBatchMove(AObj).Source := TBDEDataSet_sw.FromVar(AArgs[0]);
end;

function TBatchMove_Transliterate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Transliterate: Boolean read <getter> write <sett...

  if IsGet then
    Result := TBatchMove(AObj).Transliterate
  else
    TBatchMove(AObj).Transliterate := Boolean(AArgs[0]);
end;

class function TBatchMove_sw.GetTypeName: WideString;
begin
  Result := 'TBatchMove';
end;

class function TBatchMove_sw.GetWrappedClass: TClass;
begin
  Result := TBatchMove;
end;

class procedure TBatchMove_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Execute', TBatchMove_Execute_si, 0, False);
  AData.AddProperty('ChangedCount', TBatchMove_ChangedCount_si, Longint_sw, True, False, 0, False);
  AData.AddProperty('KeyViolCount', TBatchMove_KeyViolCount_si, Longint_sw, True, False, 0, False);
  AData.AddProperty('MovedCount', TBatchMove_MovedCount_si, Longint_sw, True, False, 0, False);
  AData.AddProperty('ProblemCount', TBatchMove_ProblemCount_si, Longint_sw, True, False, 0, False);
  AData.AddProperty('AbortOnKeyViol', TBatchMove_AbortOnKeyViol_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('AbortOnProblem', TBatchMove_AbortOnProblem_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('CommitCount', TBatchMove_CommitCount_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('ChangedTableName', TBatchMove_ChangedTableName_si, TFileName_sw, True, True, 0, False);
  AData.AddProperty('Destination', TBatchMove_Destination_si, TTable_sw, True, True, 0, False);
  AData.AddProperty('KeyViolTableName', TBatchMove_KeyViolTableName_si, TFileName_sw, True, True, 0, False);
  AData.AddProperty('Mappings', TBatchMove_Mappings_si, TStrings_sw, True, True, 0, False);
  AData.AddProperty('Mode', TBatchMove_Mode_si, TBatchMode_sw, True, True, 0, False);
  AData.AddProperty('ProblemTableName', TBatchMove_ProblemTableName_si, TFileName_sw, True, True, 0, False);
  AData.AddProperty('RecordCount', TBatchMove_RecordCount_si, Longint_sw, True, True, 0, False);
  AData.AddProperty('Source', TBatchMove_Source_si, TBDEDataSet_sw, True, True, 0, False);
  AData.AddProperty('Transliterate', TBatchMove_Transliterate_si, Boolean_sw, True, True, 0, False);
end;

class function TBatchMove_sw.ToVar(const AValue: TBatchMove): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBatchMove_sw.FromVar(const AValue: OleVariant): TBatchMove;
begin
  Result := TBatchMove(ConvFromVar(AValue, TBatchMove));
end;

class function TBatchMove_sw.ClassToVar(AClass: TBatchMove_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBatchMove_sw.ClassFromVar(
  const AClass: OleVariant): TBatchMove_sc;
begin
  Result := TBatchMove_sc(ConvClsFromVar(AClass, TBatchMove));
end;

{ TParamBindMode_sw }

class function TParamBindMode_sw.GetTypeName: WideString;
begin
  Result := 'TParamBindMode';
end;

class function TParamBindMode_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TParamBindMode);
end;

class function TParamBindMode_sw.ToVar(
  const AValue: TParamBindMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TParamBindMode_sw.FromVar(
  const AValue: OleVariant): TParamBindMode;
begin
  Result := TParamBindMode(Integer(AValue));
end;

{ TServerDesc_sw }

function TServerDesc_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TServerDesc_sw.ToVar(TServerDesc(AObj));
end;

function TServerDesc_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TServerDesc_sw.Create as IDispatch;
end;

function TServerDesc_ParamName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ParamName: string;

  if IsGet then
    Result := TServerDesc_sw(AObj).FValue.ParamName
  else
    TServerDesc_sw(AObj).FValue.ParamName := string(AArgs[0]);
end;

function TServerDesc_BindType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BindType: TFieldType;

  if IsGet then
    Result := TFieldType_sw.ToVar(TServerDesc_sw(AObj).FValue.BindType)
  else
    TServerDesc_sw(AObj).FValue.BindType := TFieldType_sw.FromVar(AArgs[0]);
end;

class function TServerDesc_sw.GetTypeName: WideString;
begin
  Result := 'TServerDesc';
end;

function TServerDesc_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TServerDesc_sw.Create;
  TServerDesc_sw(Result).FValue := FValue;
end;

class procedure TServerDesc_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TServerDesc_Copy_si, TServerDesc_sw, 0);
  AData.AddField('ParamName', TServerDesc_ParamName_si, string_sw);
  AData.AddField('BindType', TServerDesc_BindType_si, TFieldType_sw);

  { Class members }

  AData.AddConstructor('Create', TServerDesc_Create_si, 0);
end;

class function TServerDesc_sw.ToVar(const AValue: TServerDesc): OleVariant;
var
  wrpr: TServerDesc_sw;
begin
  wrpr        := TServerDesc_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TServerDesc_sw.FromVar(const AValue: OleVariant): TServerDesc;
begin
  Result := TServerDesc_sw(ConvFromVar(AValue)).FValue;
end;

{ TStoredProc_sw }

function TStoredProc_CopyParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CopyParams(Value: TParams);

  TStoredProc(AObj).CopyParams(TParams_sw.FromVar(AArgs[0]));
end;

function TStoredProc_DescriptionsAvailable_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DescriptionsAvailable: Boolean;

  Result := TStoredProc(AObj).DescriptionsAvailable();
end;

function TStoredProc_ExecProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ExecProc;

  TStoredProc(AObj).ExecProc();
end;

function TStoredProc_ParamByName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ParamByName(const Value: string): TParam;

  Result := TParam_sw.ToVar(TStoredProc(AObj).ParamByName(string(AArgs[0])));
end;

function TStoredProc_Prepare_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Prepare;

  TStoredProc(AObj).Prepare();
end;

function TStoredProc_GetResults_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetResults;

  TStoredProc(AObj).GetResults();
end;

function TStoredProc_UnPrepare_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnPrepare;

  TStoredProc(AObj).UnPrepare();
end;

function TStoredProc_ParamCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParamCount: Word read <getter>;

  Result := TStoredProc(AObj).ParamCount;
end;

function TStoredProc_Prepared_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Prepared: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TStoredProc(AObj).Prepared
  else
    TStoredProc(AObj).Prepared := Boolean(AArgs[0]);
end;

function TStoredProc_StoredProcName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StoredProcName: string read <getter> write <sett...

  if IsGet then
    Result := TStoredProc(AObj).StoredProcName
  else
    TStoredProc(AObj).StoredProcName := string(AArgs[0]);
end;

function TStoredProc_Overload_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Overload: Word read <getter> write <setter>;

  if IsGet then
    Result := TStoredProc(AObj).Overload
  else
    TStoredProc(AObj).Overload := Word(AArgs[0]);
end;

function TStoredProc_Params_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Params: TParams read <getter> write <setter>;

  if IsGet then
    Result := TParams_sw.ToVar(TStoredProc(AObj).Params)
  else
    TStoredProc(AObj).Params := TParams_sw.FromVar(AArgs[0]);
end;

function TStoredProc_ParamBindMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParamBindMode: TParamBindMode read <getter> writ...

  if IsGet then
    Result := TParamBindMode_sw.ToVar(TStoredProc(AObj).ParamBindMode)
  else
    TStoredProc(AObj).ParamBindMode := TParamBindMode_sw.FromVar(AArgs[0]);
end;

class function TStoredProc_sw.GetTypeName: WideString;
begin
  Result := 'TStoredProc';
end;

class function TStoredProc_sw.GetWrappedClass: TClass;
begin
  Result := TStoredProc;
end;

class procedure TStoredProc_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('CopyParams', TStoredProc_CopyParams_si, 1, False);
  AData.AddFunction('DescriptionsAvailable', TStoredProc_DescriptionsAvailable_si, Boolean_sw, 0, False);
  AData.AddProcedure('ExecProc', TStoredProc_ExecProc_si, 0, False);
  AData.AddFunction('ParamByName', TStoredProc_ParamByName_si, TParam_sw, 1, False);
  AData.AddProcedure('Prepare', TStoredProc_Prepare_si, 0, False);
  AData.AddProcedure('GetResults', TStoredProc_GetResults_si, 0, False);
  AData.AddProcedure('UnPrepare', TStoredProc_UnPrepare_si, 0, False);
  AData.AddProperty('ParamCount', TStoredProc_ParamCount_si, Word_sw, True, False, 0, False);
  AData.AddPropertyRedecl('StmtHandle');
  AData.AddProperty('Prepared', TStoredProc_Prepared_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('StoredProcName', TStoredProc_StoredProcName_si, string_sw, True, True, 0, False);
  AData.AddProperty('Overload', TStoredProc_Overload_si, Word_sw, True, True, 0, False);
  AData.AddProperty('Params', TStoredProc_Params_si, TParams_sw, True, True, 0, False);
  AData.AddProperty('ParamBindMode', TStoredProc_ParamBindMode_si, TParamBindMode_sw, True, True, 0, False);
  AData.AddPropertyRedecl('UpdateObject');
end;

class function TStoredProc_sw.ToVar(const AValue: TStoredProc): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStoredProc_sw.FromVar(const AValue: OleVariant): TStoredProc;
begin
  Result := TStoredProc(ConvFromVar(AValue, TStoredProc));
end;

class function TStoredProc_sw.ClassToVar(AClass: TStoredProc_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStoredProc_sw.ClassFromVar(
  const AClass: OleVariant): TStoredProc_sc;
begin
  Result := TStoredProc_sc(ConvClsFromVar(AClass, TStoredProc));
end;

{ TQuery_sw }

function TQuery_DataLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DataLink: TDataLink read <getter>;

  Result := TDataLink_sw.ToVar(TQuery_sacc(TQuery(AObj)).DataLink);
end;

function TQuery_ExecSQL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ExecSQL;

  TQuery(AObj).ExecSQL();
end;

function TQuery_ParamByName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ParamByName(const Value: string): TParam;

  Result := TParam_sw.ToVar(TQuery(AObj).ParamByName(string(AArgs[0])));
end;

function TQuery_Prepare_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Prepare;

  TQuery(AObj).Prepare();
end;

function TQuery_UnPrepare_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnPrepare;

  TQuery(AObj).UnPrepare();
end;

function TQuery_Prepared_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Prepared: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TQuery(AObj).Prepared
  else
    TQuery(AObj).Prepared := Boolean(AArgs[0]);
end;

function TQuery_ParamCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParamCount: Word read <getter>;

  Result := TQuery(AObj).ParamCount;
end;

function TQuery_Local_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Local: Boolean read <getter>;

  Result := TQuery(AObj).Local;
end;

function TQuery_Text_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Text: string read <getter>;

  Result := TQuery(AObj).Text;
end;

function TQuery_RowsAffected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RowsAffected: Integer read <getter>;

  Result := TQuery(AObj).RowsAffected;
end;

function TQuery_Constrained_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Constrained: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TQuery(AObj).Constrained
  else
    TQuery(AObj).Constrained := Boolean(AArgs[0]);
end;

function TQuery_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TQuery(AObj).DataSource)
  else
    TQuery(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TQuery_ParamCheck_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParamCheck: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TQuery(AObj).ParamCheck
  else
    TQuery(AObj).ParamCheck := Boolean(AArgs[0]);
end;

function TQuery_RequestLive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RequestLive: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TQuery(AObj).RequestLive
  else
    TQuery(AObj).RequestLive := Boolean(AArgs[0]);
end;

function TQuery_SQL_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property SQL: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TQuery(AObj).SQL)
  else
    TQuery(AObj).SQL := TStrings_sw.FromVar(AArgs[0]);
end;

function TQuery_Params_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Params: TParams read <getter> write <setter>;

  if IsGet then
    Result := TParams_sw.ToVar(TQuery(AObj).Params)
  else
    TQuery(AObj).Params := TParams_sw.FromVar(AArgs[0]);
end;

function TQuery_UniDirectional_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UniDirectional: Boolean read <getter> write <set...

  if IsGet then
    Result := TQuery(AObj).UniDirectional
  else
    TQuery(AObj).UniDirectional := Boolean(AArgs[0]);
end;

class function TQuery_sw.GetTypeName: WideString;
begin
  Result := 'TQuery';
end;

class function TQuery_sw.GetWrappedClass: TClass;
begin
  Result := TQuery;
end;

class procedure TQuery_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DataLink', TQuery_DataLink_si, TDataLink_sw, True, False, 0, True);
  AData.AddProcedure('ExecSQL', TQuery_ExecSQL_si, 0, False);
  AData.AddFunction('ParamByName', TQuery_ParamByName_si, TParam_sw, 1, False);
  AData.AddProcedure('Prepare', TQuery_Prepare_si, 0, False);
  AData.AddProcedure('UnPrepare', TQuery_UnPrepare_si, 0, False);
  AData.AddProperty('Prepared', TQuery_Prepared_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('ParamCount', TQuery_ParamCount_si, Word_sw, True, False, 0, False);
  AData.AddProperty('Local', TQuery_Local_si, Boolean_sw, True, False, 0, False);
  AData.AddPropertyRedecl('StmtHandle');
  AData.AddProperty('Text', TQuery_Text_si, string_sw, True, False, 0, False);
  AData.AddProperty('RowsAffected', TQuery_RowsAffected_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('Constrained', TQuery_Constrained_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Constraints');
  AData.AddProperty('DataSource', TQuery_DataSource_si, TDataSource_sw, True, True, 0, False);
  AData.AddProperty('ParamCheck', TQuery_ParamCheck_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('RequestLive', TQuery_RequestLive_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('SQL', TQuery_SQL_si, TStrings_sw, True, True, 0, False);
  AData.AddProperty('Params', TQuery_Params_si, TParams_sw, True, True, 0, False);
  AData.AddProperty('UniDirectional', TQuery_UniDirectional_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('UpdateMode');
  AData.AddPropertyRedecl('UpdateObject');
end;

class function TQuery_sw.ToVar(const AValue: TQuery): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TQuery_sw.FromVar(const AValue: OleVariant): TQuery;
begin
  Result := TQuery(ConvFromVar(AValue, TQuery));
end;

class function TQuery_sw.ClassToVar(AClass: TQuery_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TQuery_sw.ClassFromVar(const AClass: OleVariant): TQuery_sc;
begin
  Result := TQuery_sc(ConvClsFromVar(AClass, TQuery));
end;

{ TUpdateSQL_sw }

function TUpdateSQL_ExecSQL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ExecSQL(UpdateKind: TUpdateKind);

  TUpdateSQL(AObj).ExecSQL(TUpdateKind_sw.FromVar(AArgs[0]));
end;

function TUpdateSQL_DatabaseName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DatabaseName: string read <getter> write <setter>;

  if IsGet then
    Result := TUpdateSQL(AObj).DatabaseName
  else
    TUpdateSQL(AObj).DatabaseName := string(AArgs[0]);
end;

function TUpdateSQL_Query_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Query[UpdateKind: TUpdateKind]: TQuery read <get...

  Result := TQuery_sw.ToVar(TUpdateSQL(AObj).Query[TUpdateKind_sw.FromVar(
    AArgs[0])]);
end;

function TUpdateSQL_SQL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SQL[UpdateKind: TUpdateKind]: TStrings read <get...

  if IsGet then
    Result := TStrings_sw.ToVar(TUpdateSQL(AObj).SQL[TUpdateKind_sw.FromVar(
      AArgs[0])])
  else
    TUpdateSQL(AObj).SQL[TUpdateKind_sw.FromVar(AArgs[0])] := TStrings_sw.
      FromVar(AArgs[1]);
end;

function TUpdateSQL_SessionName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SessionName: string read <getter> write <setter>;

  if IsGet then
    Result := TUpdateSQL(AObj).SessionName
  else
    TUpdateSQL(AObj).SessionName := string(AArgs[0]);
end;

function TUpdateSQL_ModifySQL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ModifySQL: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TUpdateSQL(AObj).ModifySQL)
  else
    TUpdateSQL(AObj).ModifySQL := TStrings_sw.FromVar(AArgs[0]);
end;

function TUpdateSQL_InsertSQL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property InsertSQL: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TUpdateSQL(AObj).InsertSQL)
  else
    TUpdateSQL(AObj).InsertSQL := TStrings_sw.FromVar(AArgs[0]);
end;

function TUpdateSQL_DeleteSQL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DeleteSQL: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TUpdateSQL(AObj).DeleteSQL)
  else
    TUpdateSQL(AObj).DeleteSQL := TStrings_sw.FromVar(AArgs[0]);
end;

class function TUpdateSQL_sw.GetTypeName: WideString;
begin
  Result := 'TUpdateSQL';
end;

class function TUpdateSQL_sw.GetWrappedClass: TClass;
begin
  Result := TUpdateSQL;
end;

class procedure TUpdateSQL_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ExecSQL', TUpdateSQL_ExecSQL_si, 1, False);
  AData.AddProperty('DatabaseName', TUpdateSQL_DatabaseName_si, string_sw, True, True, 0, False);
  AData.AddPropertyRedecl('DataSet');
  AData.AddProperty('Query', TUpdateSQL_Query_si, TQuery_sw, True, False, 1, False);
  AData.AddProperty('SQL', TUpdateSQL_SQL_si, TStrings_sw, True, True, 1, False);
  AData.AddProperty('SessionName', TUpdateSQL_SessionName_si, string_sw, True, True, 0, False);
  AData.AddProperty('ModifySQL', TUpdateSQL_ModifySQL_si, TStrings_sw, True, True, 0, False);
  AData.AddProperty('InsertSQL', TUpdateSQL_InsertSQL_si, TStrings_sw, True, True, 0, False);
  AData.AddProperty('DeleteSQL', TUpdateSQL_DeleteSQL_si, TStrings_sw, True, True, 0, False);
end;

class function TUpdateSQL_sw.ToVar(const AValue: TUpdateSQL): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TUpdateSQL_sw.FromVar(const AValue: OleVariant): TUpdateSQL;
begin
  Result := TUpdateSQL(ConvFromVar(AValue, TUpdateSQL));
end;

class function TUpdateSQL_sw.ClassToVar(AClass: TUpdateSQL_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TUpdateSQL_sw.ClassFromVar(
  const AClass: OleVariant): TUpdateSQL_sc;
begin
  Result := TUpdateSQL_sc(ConvClsFromVar(AClass, TUpdateSQL));
end;

{ TBlobStream_sw }

function TBlobStream_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Field: TBlobField; Mode: TBlobStreamMo...

  Result := TBlobStream_sw.ToVar(TBlobStream_sc(AObj).Create(TBlobField_sw.
    FromVar(AArgs[0]), TBlobStreamMode_sw.FromVar(AArgs[1])));
end;

function TBlobStream_Truncate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Truncate;

  TBlobStream(AObj).Truncate();
end;

class function TBlobStream_sw.GetTypeName: WideString;
begin
  Result := 'TBlobStream';
end;

class function TBlobStream_sw.GetWrappedClass: TClass;
begin
  Result := TBlobStream;
end;

class procedure TBlobStream_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Truncate', TBlobStream_Truncate_si, 0, False);

  { Class members }

  AData.AddConstructor('Create', TBlobStream_Create_si, 2, False);
end;

class function TBlobStream_sw.ToVar(const AValue: TBlobStream): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBlobStream_sw.FromVar(const AValue: OleVariant): TBlobStream;
begin
  Result := TBlobStream(ConvFromVar(AValue, TBlobStream));
end;

class function TBlobStream_sw.ClassToVar(AClass: TBlobStream_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBlobStream_sw.ClassFromVar(
  const AClass: OleVariant): TBlobStream_sc;
begin
  Result := TBlobStream_sc(ConvClsFromVar(AClass, TBlobStream));
end;

{ DBTables_sw }

function DBTables_EDBEngineError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EDBEngineError = class(EDatabaseError);

  Result := TLMDUnitWrapper.TypeToVar(EDBEngineError_sw);
end;

function DBTables_ENoResultSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ENoResultSet = class(EDatabaseError);

  Result := TLMDUnitWrapper.TypeToVar(ENoResultSet_sw);
end;

function DBTables_TDBError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBError = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TDBError_sw);
end;

function DBTables_TBDECallback_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBDECallback = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TBDECallback_sw);
end;

function DBTables_TSessionList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSessionList = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TSessionList_sw);
end;

function DBTables_TConfigModes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConfigModes = (cfmPersistent, cfmSession);

  Result := TLMDUnitWrapper.TypeToVar(TConfigModes_sw);
end;

function DBTables_TConfigMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConfigMode = set of TConfigModes;

  Result := TLMDUnitWrapper.TypeToVar(TConfigMode_sw);
end;

function DBTables_TPasswordEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPasswordEvent = procedure (Sender: TObject; var Con...

  Result := TLMDUnitWrapper.TypeToVar(TPasswordEvent_sw);
end;

function DBTables_TDatabaseEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDatabaseEvent = (dbClose, dbAdd, dbRemove, dbAddAli...

  Result := TLMDUnitWrapper.TypeToVar(TDatabaseEvent_sw);
end;

function DBTables_TTraceFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTraceFlag = (tfQExecute, tfError, tfStmt, tfConnect...

  Result := TLMDUnitWrapper.TypeToVar(TTraceFlag_sw);
end;

function DBTables_TTraceFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTraceFlags = set of TTraceFlag;

  Result := TLMDUnitWrapper.TypeToVar(TTraceFlags_sw);
end;

function DBTables_TSession_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSession = class(TComponent, IDBSession);

  Result := TLMDUnitWrapper.TypeToVar(TSession_sw);
end;

function DBTables_TParamList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParamList = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TParamList_sw);
end;

function DBTables_TTransIsolation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTransIsolation = (tiReadCommitted, tiRepeatableRead);

  Result := TLMDUnitWrapper.TypeToVar(TTransIsolation_sw);
end;

function DBTables_TDatabaseLoginEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDatabaseLoginEvent = procedure (Database: TDatabase...

  Result := TLMDUnitWrapper.TypeToVar(TDatabaseLoginEvent_sw);
end;

function DBTables_TDatabase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDatabase = class(TCustomConnection);

  Result := TLMDUnitWrapper.TypeToVar(TDatabase_sw);
end;

function DBTables_TRecNoStatus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRecNoStatus = (rnParadox, rnNotSupported);

  Result := TLMDUnitWrapper.TypeToVar(TRecNoStatus_sw);
end;

function DBTables_TDataSetUpdateObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSetUpdateObject = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TDataSetUpdateObject_sw);
end;

function DBTables_TSQLUpdateObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSQLUpdateObject = class(TDataSetUpdateObject);

  Result := TLMDUnitWrapper.TypeToVar(TSQLUpdateObject_sw);
end;

function DBTables_TBDEKeyBuffer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBDEKeyBuffer = record;

  Result := TLMDUnitWrapper.TypeToVar(TBDEKeyBuffer_sw);
end;

function DBTables_TBDERecInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBDERecInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TBDERecInfo_sw);
end;

function DBTables_TBDEDataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBDEDataSet = class(TDataSet);

  Result := TLMDUnitWrapper.TypeToVar(TBDEDataSet_sw);
end;

function DBTables_TNestedTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNestedTable = class(TBDEDataSet);

  Result := TLMDUnitWrapper.TypeToVar(TNestedTable_sw);
end;

function DBTables_TDBDataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBDataSet = class(TBDEDataSet);

  Result := TLMDUnitWrapper.TypeToVar(TDBDataSet_sw);
end;

function DBTables_TBatchMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBatchMode = (batUpdate, batAppendUpdate, batDelete,...

  Result := TLMDUnitWrapper.TypeToVar(TBatchMode_sw);
end;

function DBTables_TTableType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTableType = (ttParadox, ttDBase, ttFoxPro, ttASCII);

  Result := TLMDUnitWrapper.TypeToVar(TTableType_sw);
end;

function DBTables_TLockType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLockType = (ltWriteLock);

  Result := TLMDUnitWrapper.TypeToVar(TLockType_sw);
end;

function DBTables_TIndexName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIndexName = string;

  Result := TLMDUnitWrapper.TypeToVar(TIndexName_sw);
end;

function DBTables_TIndexFiles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIndexFiles = class(TStringList);

  Result := TLMDUnitWrapper.TypeToVar(TIndexFiles_sw);
end;

function DBTables_TTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTable = class(TDBDataSet);

  Result := TLMDUnitWrapper.TypeToVar(TTable_sw);
end;

function DBTables_TBatchMove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBatchMove = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TBatchMove_sw);
end;

function DBTables_TParamBindMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParamBindMode = (pbByNumber);

  Result := TLMDUnitWrapper.TypeToVar(TParamBindMode_sw);
end;

function DBTables_TServerDesc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TServerDesc = record;

  Result := TLMDUnitWrapper.TypeToVar(TServerDesc_sw);
end;

function DBTables_TStoredProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStoredProc = class(TDBDataSet);

  Result := TLMDUnitWrapper.TypeToVar(TStoredProc_sw);
end;

function DBTables_TQuery_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TQuery = class(TDBDataSet);

  Result := TLMDUnitWrapper.TypeToVar(TQuery_sw);
end;

function DBTables_TUpdateSQL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUpdateSQL = class(TSQLUpdateObject);

  Result := TLMDUnitWrapper.TypeToVar(TUpdateSQL_sw);
end;

function DBTables_TBlobStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBlobStream = class(TStream);

  Result := TLMDUnitWrapper.TypeToVar(TBlobStream_sw);
end;

function DBTables_Session_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Session: TSession;

  if IsGet then
    Result := TSession_sw.ToVar(DBTables.Session)
  else
    DBTables.Session := TSession_sw.FromVar(AArgs[0]);
end;

function DBTables_Sessions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Sessions: TSessionList;

  if IsGet then
    Result := TSessionList_sw.ToVar(DBTables.Sessions)
  else
    DBTables.Sessions := TSessionList_sw.FromVar(AArgs[0]);
end;

class function DBTables_sw.GetUnitName: WideString;
begin
  Result := 'DBTables';
end;

class procedure DBTables_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(EDBEngineError_sw, DBTables_EDBEngineError_si);
  AData.AddType(ENoResultSet_sw, DBTables_ENoResultSet_si);
  AData.AddType(TDBError_sw, DBTables_TDBError_si);
  AData.AddType(TBDECallback_sw, DBTables_TBDECallback_si);
  AData.AddType(TSessionList_sw, DBTables_TSessionList_si);
  AData.AddType(TConfigModes_sw, DBTables_TConfigModes_si);
  AData.AddType(TConfigMode_sw, DBTables_TConfigMode_si);
  AData.AddType(TPasswordEvent_sw, DBTables_TPasswordEvent_si);
  AData.AddType(TDatabaseEvent_sw, DBTables_TDatabaseEvent_si);
  AData.AddType(TTraceFlag_sw, DBTables_TTraceFlag_si);
  AData.AddType(TTraceFlags_sw, DBTables_TTraceFlags_si);
  AData.AddType(TSession_sw, DBTables_TSession_si);
  AData.AddType(TParamList_sw, DBTables_TParamList_si);
  AData.AddType(TTransIsolation_sw, DBTables_TTransIsolation_si);
  AData.AddType(TDatabaseLoginEvent_sw, DBTables_TDatabaseLoginEvent_si);
  AData.AddType(TDatabase_sw, DBTables_TDatabase_si);
  AData.AddType(TRecNoStatus_sw, DBTables_TRecNoStatus_si);
  AData.AddType(TDataSetUpdateObject_sw, DBTables_TDataSetUpdateObject_si);
  AData.AddType(TSQLUpdateObject_sw, DBTables_TSQLUpdateObject_si);
  AData.AddType(TBDEKeyBuffer_sw, DBTables_TBDEKeyBuffer_si);
  AData.AddType(TBDERecInfo_sw, DBTables_TBDERecInfo_si);
  AData.AddType(TBDEDataSet_sw, DBTables_TBDEDataSet_si);
  AData.AddType(TNestedTable_sw, DBTables_TNestedTable_si);
  AData.AddType(TDBDataSet_sw, DBTables_TDBDataSet_si);
  AData.AddType(TBatchMode_sw, DBTables_TBatchMode_si);
  AData.AddType(TTableType_sw, DBTables_TTableType_si);
  AData.AddType(TLockType_sw, DBTables_TLockType_si);
  AData.AddType(TIndexName_sw, DBTables_TIndexName_si);
  AData.AddType(TIndexFiles_sw, DBTables_TIndexFiles_si);
  AData.AddType(TTable_sw, DBTables_TTable_si);
  AData.AddType(TBatchMove_sw, DBTables_TBatchMove_si);
  AData.AddType(TParamBindMode_sw, DBTables_TParamBindMode_si);
  AData.AddType(TServerDesc_sw, DBTables_TServerDesc_si);
  AData.AddType(TStoredProc_sw, DBTables_TStoredProc_si);
  AData.AddType(TQuery_sw, DBTables_TQuery_si);
  AData.AddType(TUpdateSQL_sw, DBTables_TUpdateSQL_si);
  AData.AddType(TBlobStream_sw, DBTables_TBlobStream_si);
  AData.AddVariable('Session', DBTables_Session_si, TSession_sw);
  AData.AddVariable('Sessions', DBTables_Sessions_si, TSessionList_sw);
end;

class function DBTables_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(DBTables_sw);
end;

initialization
  RegisterUnitWrapper(DBTables_sw);
  RegisterClassWrapper(EDBEngineError_sw);
  RegisterClassWrapper(ENoResultSet_sw);
  RegisterClassWrapper(TDBError_sw);
  RegisterClassWrapper(TBDECallback_sw);
  RegisterClassWrapper(TSessionList_sw);
  RegisterClassWrapper(TSession_sw);
  RegisterClassWrapper(TParamList_sw);
  RegisterClassWrapper(TDatabase_sw);
  RegisterClassWrapper(TDataSetUpdateObject_sw);
  RegisterClassWrapper(TSQLUpdateObject_sw);
  RegisterClassWrapper(TBDEDataSet_sw);
  RegisterClassWrapper(TNestedTable_sw);
  RegisterClassWrapper(TDBDataSet_sw);
  RegisterClassWrapper(TIndexFiles_sw);
  RegisterClassWrapper(TTable_sw);
  RegisterClassWrapper(TBatchMove_sw);
  RegisterClassWrapper(TStoredProc_sw);
  RegisterClassWrapper(TQuery_sw);
  RegisterClassWrapper(TUpdateSQL_sw);
  RegisterClassWrapper(TBlobStream_sw);
  RegisterEventWrapper(TypeInfo(TPasswordEvent), TPasswordEvent_sw);
  RegisterEventWrapper(TypeInfo(TDatabaseLoginEvent), TDatabaseLoginEvent_sw);

end.
