unit DBClient_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'DBClient' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Types, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers,
  Windows, SysUtils, Variants, Classes, DB, DBCommon, DBCommonTypes, DBClient,
  Windows_LMDSW, SysUtils_LMDSW, Variants_LMDSW, Classes_LMDSW, DB_LMDSW,
  DBCommon_LMDSW, DBCommonTypes_LMDSW;


{ Type wrappers }

type
  EDBClient_sw = class;
  EReconcileError_sw = class;
  TCustomRemoteServer_sw = class;
  TConnectionBroker_sw = class;
  TAggregate_sw = class;
  TAggregates_sw = class;
  TCustomClientDataSet_sw = class;
  TClientDataSet_sw = class;
  TClientBlobStream_sw = class;

  EDBClient_sc = class of EDBClient;
  EDBClient_sw = class(EDatabaseError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EDBClient): OleVariant;
    class function FromVar(const AValue: OleVariant): EDBClient;
    class function ClassToVar(AClass: EDBClient_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EDBClient_sc;
  end;

  EReconcileError_sc = class of EReconcileError;
  EReconcileError_sw = class(EDBClient_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EReconcileError): OleVariant;
    class function FromVar(const AValue: OleVariant): EReconcileError;
    class function ClassToVar(AClass: EReconcileError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EReconcileError_sc;
  end;

  TGetUsernameEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var Username: string);
  end;

  TGetUsernameEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetUsernameEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetUsernameEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetUsernameEvent;
  end;

  TCustomRemoteServer_sc = class of TCustomRemoteServer;
  TCustomRemoteServer_sw = class(TCustomConnection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomRemoteServer): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomRemoteServer;
    class function ClassToVar(AClass: TCustomRemoteServer_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomRemoteServer_sc;
  end;

  TConnectionBroker_sc = class of TConnectionBroker;
  TConnectionBroker_sw = class(TCustomRemoteServer_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TConnectionBroker): OleVariant;
    class function FromVar(const AValue: OleVariant): TConnectionBroker;
    class function ClassToVar(AClass: TConnectionBroker_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TConnectionBroker_sc;
  end;

  TAggUpdateEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Agg: TAggregate);
  end;

  TAggUpdateEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TAggUpdateEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TAggUpdateEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TAggUpdateEvent;
  end;

  TAggregate_sc = class of TAggregate;
  TAggregate_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TAggregate): OleVariant;
    class function FromVar(const AValue: OleVariant): TAggregate;
    class function ClassToVar(AClass: TAggregate_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TAggregate_sc;
  end;

  TAggregates_sc = class of TAggregates;
  TAggregates_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TAggregates): OleVariant;
    class function FromVar(const AValue: OleVariant): TAggregates;
    class function ClassToVar(AClass: TAggregates_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TAggregates_sc;
  end;

  TRecInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TRecInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TRecInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TRecInfo;
  end;

  TCDSRecInfo_sw = TRecInfo_sw;

  TKeyBuffer_sw = class(TLMDRecordWrapper)
  private
    FValue: TKeyBuffer;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TKeyBuffer): OleVariant;
    class function FromVar(const AValue: OleVariant): TKeyBuffer;
  end;

  TCDSKeyBuffer_sw = TKeyBuffer_sw;

  TDataPacketFormat_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDataPacketFormat): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataPacketFormat;
  end;

  TReconcileAction_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TReconcileAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TReconcileAction;
  end;

  TReconcileErrorEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DataSet: TCustomClientDataSet; E: EReconcileError;
      UpdateKind: TUpdateKind; var Action: TReconcileAction);
  end;

  TReconcileErrorEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TReconcileErrorEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TReconcileErrorEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TReconcileErrorEvent;
  end;

  TRemoteEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var OwnerData: OleVariant);
  end;

  TRemoteEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TRemoteEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TRemoteEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TRemoteEvent;
  end;

  TReconcileInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TReconcileInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TReconcileInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TReconcileInfo;
  end;

  TDataSetOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDataSetOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSetOption;
  end;

  TDataSetOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TDataSetOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSetOptions;
  end;

  TFetchOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFetchOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TFetchOption;
  end;

  TFetchOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFetchOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TFetchOptions;
  end;

  TCustomClientDataSet_sc = class of TCustomClientDataSet;
  TCustomClientDataSet_sw = class(TDataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomClientDataSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomClientDataSet;
    class function ClassToVar(AClass: TCustomClientDataSet_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomClientDataSet_sc;
  end;

  TClientDataSet_sc = class of TClientDataSet;
  TClientDataSet_sw = class(TCustomClientDataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TClientDataSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TClientDataSet;
    class function ClassToVar(AClass: TClientDataSet_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TClientDataSet_sc;
  end;

  TClientBlobStream_sc = class of TClientBlobStream;
  TClientBlobStream_sw = class(TMemoryStream_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TClientBlobStream): OleVariant;
    class function FromVar(const AValue: OleVariant): TClientBlobStream;
    class function ClassToVar(AClass: TClientBlobStream_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TClientBlobStream_sc;
  end;


{ Unit wrapper }

type
  DBClient_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCustomRemoteServer_sacc = class(TCustomRemoteServer);
  TAggregate_sacc = class(TAggregate);
  TCustomClientDataSet_sacc = class(TCustomClientDataSet);

{ EDBClient_sw }

class function EDBClient_sw.GetTypeName: WideString;
begin
  Result := 'EDBClient';
end;

class function EDBClient_sw.GetWrappedClass: TClass;
begin
  Result := EDBClient;
end;

class procedure EDBClient_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EDBClient_sw.ToVar(const AValue: EDBClient): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EDBClient_sw.FromVar(const AValue: OleVariant): EDBClient;
begin
  Result := EDBClient(ConvFromVar(AValue, EDBClient));
end;

class function EDBClient_sw.ClassToVar(AClass: EDBClient_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EDBClient_sw.ClassFromVar(
  const AClass: OleVariant): EDBClient_sc;
begin
  Result := EDBClient_sc(ConvClsFromVar(AClass, EDBClient));
end;

{ EReconcileError_sw }

function EReconcileError_Context_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Context: string read <getter>;

  Result := EReconcileError(AObj).Context;
end;

class function EReconcileError_sw.GetTypeName: WideString;
begin
  Result := 'EReconcileError';
end;

class function EReconcileError_sw.GetWrappedClass: TClass;
begin
  Result := EReconcileError;
end;

class procedure EReconcileError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Context', EReconcileError_Context_si, string_sw, True, False, 0, False, False);
end;

class function EReconcileError_sw.ToVar(
  const AValue: EReconcileError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EReconcileError_sw.FromVar(
  const AValue: OleVariant): EReconcileError;
begin
  Result := EReconcileError(ConvFromVar(AValue, EReconcileError));
end;

class function EReconcileError_sw.ClassToVar(
  AClass: EReconcileError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EReconcileError_sw.ClassFromVar(
  const AClass: OleVariant): EReconcileError_sc;
begin
  Result := EReconcileError_sc(ConvClsFromVar(AClass, EReconcileError));
end;

{ TGetUsernameEvent_sh }

function TGetUsernameEvent_sh.GetHandler: TMethod;
var
  hdr: TGetUsernameEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetUsernameEvent_sh.Handler(Sender: TObject; var Username: string);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var Username: string) of object

  v_1 := Username;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Username := string(v_1);
end;

{ TGetUsernameEvent_sw }

class function TGetUsernameEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetUsernameEvent';
end;

class function TGetUsernameEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetUsernameEvent_sh;
end;

class function TGetUsernameEvent_sw.ToVar(
  const AValue: TGetUsernameEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetUsernameEvent_sw.FromVar(
  const AValue: OleVariant): TGetUsernameEvent;
begin
  Result := TGetUsernameEvent(ConvFromVar(AValue));
end;

class function TGetUsernameEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TGetUsernameEvent;
var
  hdlr: TGetUsernameEvent_sh;
begin
  hdlr   := TGetUsernameEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetUsernameEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomRemoteServer_sw }

function TCustomRemoteServer_OnGetUsername_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetUsername: TGetUsernameEvent read ...

  if IsGet then
    Result := TGetUsernameEvent_sw.ToVar(TCustomRemoteServer_sacc(
      TCustomRemoteServer(AObj)).OnGetUsername)
  else
    TCustomRemoteServer_sacc(TCustomRemoteServer(AObj)).OnGetUsername := 
      TGetUsernameEvent_sw.FromVar(AArgs[0]);
end;

function TCustomRemoteServer_GetServerList_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetServerList: OleVariant;

  Result := TCustomRemoteServer(AObj).GetServerList();
end;

function TCustomRemoteServer_GetProviderNames_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetProviderNames(Proc: TGetStrProc);

  TCustomRemoteServer(AObj).GetProviderNames(TGetStrProc_sw.FromVar(AArgs[0]));
end;

function TCustomRemoteServer_AppServer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AppServer: Variant read <getter>;

  Result := TCustomRemoteServer(AObj).AppServer;
end;

class function TCustomRemoteServer_sw.GetTypeName: WideString;
begin
  Result := 'TCustomRemoteServer';
end;

class function TCustomRemoteServer_sw.GetWrappedClass: TClass;
begin
  Result := TCustomRemoteServer;
end;

class procedure TCustomRemoteServer_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('OnGetUsername', TCustomRemoteServer_OnGetUsername_si, TGetUsernameEvent_sw, True, True, 0, True, False);
  AData.AddFunction('GetServerList', TCustomRemoteServer_GetServerList_si, OleVariant_sw, 0, False);
  AData.AddProcedure('GetProviderNames', TCustomRemoteServer_GetProviderNames_si, 1, False);
  AData.AddProperty('AppServer', TCustomRemoteServer_AppServer_si, Variant_sw, True, False, 0, False, False);
end;

class function TCustomRemoteServer_sw.ToVar(
  const AValue: TCustomRemoteServer): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomRemoteServer_sw.FromVar(
  const AValue: OleVariant): TCustomRemoteServer;
begin
  Result := TCustomRemoteServer(ConvFromVar(AValue, TCustomRemoteServer));
end;

class function TCustomRemoteServer_sw.ClassToVar(
  AClass: TCustomRemoteServer_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomRemoteServer_sw.ClassFromVar(
  const AClass: OleVariant): TCustomRemoteServer_sc;
begin
  Result := TCustomRemoteServer_sc(ConvClsFromVar(AClass, TCustomRemoteServer));
end;

{ TConnectionBroker_sw }

function TConnectionBroker_Connection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Connection: TCustomRemoteServer read <getter> wr...

  if IsGet then
    Result := TCustomRemoteServer_sw.ToVar(TConnectionBroker(AObj).Connection)
  else
    TConnectionBroker(AObj).Connection := TCustomRemoteServer_sw.FromVar(
      AArgs[0]);
end;

class function TConnectionBroker_sw.GetTypeName: WideString;
begin
  Result := 'TConnectionBroker';
end;

class function TConnectionBroker_sw.GetWrappedClass: TClass;
begin
  Result := TConnectionBroker;
end;

class procedure TConnectionBroker_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Connected', False);
  AData.AddProperty('Connection', TConnectionBroker_Connection_si, TCustomRemoteServer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('LoginPrompt', False);
  AData.AddPropertyRedecl('AfterConnect', False);
  AData.AddPropertyRedecl('AfterDisconnect', False);
  AData.AddPropertyRedecl('BeforeConnect', False);
  AData.AddPropertyRedecl('BeforeDisconnect', False);
  AData.AddPropertyRedecl('OnGetUsername', False);
  AData.AddPropertyRedecl('OnLogin', False);
end;

class function TConnectionBroker_sw.ToVar(
  const AValue: TConnectionBroker): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TConnectionBroker_sw.FromVar(
  const AValue: OleVariant): TConnectionBroker;
begin
  Result := TConnectionBroker(ConvFromVar(AValue, TConnectionBroker));
end;

class function TConnectionBroker_sw.ClassToVar(
  AClass: TConnectionBroker_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TConnectionBroker_sw.ClassFromVar(
  const AClass: OleVariant): TConnectionBroker_sc;
begin
  Result := TConnectionBroker_sc(ConvClsFromVar(AClass, TConnectionBroker));
end;

{ TAggUpdateEvent_sh }

function TAggUpdateEvent_sh.GetHandler: TMethod;
var
  hdr: TAggUpdateEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TAggUpdateEvent_sh.Handler(Agg: TAggregate);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (Agg: TAggregate) of object

  args[0] := TAggregate_sw.ToVar(Agg);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TAggUpdateEvent_sw }

class function TAggUpdateEvent_sw.GetTypeName: WideString;
begin
  Result := 'TAggUpdateEvent';
end;

class function TAggUpdateEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TAggUpdateEvent_sh;
end;

class function TAggUpdateEvent_sw.ToVar(
  const AValue: TAggUpdateEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TAggUpdateEvent_sw.FromVar(
  const AValue: OleVariant): TAggUpdateEvent;
begin
  Result := TAggUpdateEvent(ConvFromVar(AValue));
end;

class function TAggUpdateEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TAggUpdateEvent;
var
  hdlr: TAggUpdateEvent_sh;
begin
  hdlr   := TAggUpdateEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TAggUpdateEvent_sw));
  Result := hdlr.Handler;
end;

{ TAggregate_sw }

function TAggregate_DependentFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DependentFields: TBits read <getter>;

  Result := TBits_sw.ToVar(TAggregate_sacc(TAggregate(AObj)).DependentFields);
end;

function TAggregate_RecBufOfs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property RecBufOfs: Integer read <getter> write...

  if IsGet then
    Result := TAggregate_sacc(TAggregate(AObj)).RecBufOfs
  else
    TAggregate_sacc(TAggregate(AObj)).RecBufOfs := Integer(AArgs[0]);
end;

function TAggregate_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  Result := TAggregate_sw.ToVar(TAggregate_sc(AObj).Create(TAggregates_sw.
    FromVar(AArgs[0]), TCustomClientDataSet_sw.FromVar(AArgs[1])));
end;

function TAggregate_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Value: Variant;

  Result := TAggregate(AObj).Value();
end;

function TAggregate_InUse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property InUse: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TAggregate(AObj).InUse
  else
    TAggregate(AObj).InUse := Boolean(AArgs[0]);
end;

function TAggregate_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSet: TCustomClientDataSet read <getter>;

  Result := TCustomClientDataSet_sw.ToVar(TAggregate(AObj).DataSet);
end;

function TAggregate_DataSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSize: Integer read <getter>;

  Result := TAggregate(AObj).DataSize;
end;

function TAggregate_DataType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataType: TFieldType read <getter>;

  Result := TFieldType_sw.ToVar(TAggregate(AObj).DataType);
end;

function TAggregate_Active_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Active: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TAggregate(AObj).Active
  else
    TAggregate(AObj).Active := Boolean(AArgs[0]);
end;

function TAggregate_AggregateName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AggregateName: string read <getter> write <setter>;

  if IsGet then
    Result := TAggregate(AObj).AggregateName
  else
    TAggregate(AObj).AggregateName := string(AArgs[0]);
end;

function TAggregate_Expression_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Expression: string read <getter> write <setter>;

  if IsGet then
    Result := TAggregate(AObj).Expression
  else
    TAggregate(AObj).Expression := string(AArgs[0]);
end;

function TAggregate_GroupingLevel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GroupingLevel: Integer read <getter> write <sett...

  if IsGet then
    Result := TAggregate(AObj).GroupingLevel
  else
    TAggregate(AObj).GroupingLevel := Integer(AArgs[0]);
end;

function TAggregate_IndexName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexName: string read <getter> write <setter>;

  if IsGet then
    Result := TAggregate(AObj).IndexName
  else
    TAggregate(AObj).IndexName := string(AArgs[0]);
end;

function TAggregate_Visible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Visible: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TAggregate(AObj).Visible
  else
    TAggregate(AObj).Visible := Boolean(AArgs[0]);
end;

function TAggregate_OnUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnUpdate: TAggUpdateEvent read <getter> write <s...

  if IsGet then
    Result := TAggUpdateEvent_sw.ToVar(TAggregate(AObj).OnUpdate)
  else
    TAggregate(AObj).OnUpdate := TAggUpdateEvent_sw.FromVar(AArgs[0]);
end;

class function TAggregate_sw.GetTypeName: WideString;
begin
  Result := 'TAggregate';
end;

class function TAggregate_sw.GetWrappedClass: TClass;
begin
  Result := TAggregate;
end;

class procedure TAggregate_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DependentFields', TAggregate_DependentFields_si, TBits_sw, True, False, 0, True, False);
  AData.AddProperty('RecBufOfs', TAggregate_RecBufOfs_si, Integer_sw, True, True, 0, True, False);
  AData.AddFunction('Value', TAggregate_Value_si, Variant_sw, 0, False);
  AData.AddProperty('InUse', TAggregate_InUse_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('DataSet', TAggregate_DataSet_si, TCustomClientDataSet_sw, True, False, 0, False, False);
  AData.AddProperty('DataSize', TAggregate_DataSize_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('DataType', TAggregate_DataType_si, TFieldType_sw, True, False, 0, False, False);
  AData.AddProperty('Active', TAggregate_Active_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AggregateName', TAggregate_AggregateName_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Expression', TAggregate_Expression_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('GroupingLevel', TAggregate_GroupingLevel_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('IndexName', TAggregate_IndexName_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Visible', TAggregate_Visible_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnUpdate', TAggregate_OnUpdate_si, TAggUpdateEvent_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TAggregate_Create_si, 2, False);
end;

class function TAggregate_sw.ToVar(const AValue: TAggregate): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TAggregate_sw.FromVar(const AValue: OleVariant): TAggregate;
begin
  Result := TAggregate(ConvFromVar(AValue, TAggregate));
end;

class function TAggregate_sw.ClassToVar(AClass: TAggregate_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TAggregate_sw.ClassFromVar(
  const AClass: OleVariant): TAggregate_sc;
begin
  Result := TAggregate_sc(ConvClsFromVar(AClass, TAggregate));
end;

{ TAggregates_sw }

function TAggregates_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Owner: TPersistent);

  Result := TAggregates_sw.ToVar(TAggregates_sc(AObj).Create(TPersistent_sw.
    FromVar(AArgs[0])));
end;

function TAggregates_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TAggregate;

  Result := TAggregate_sw.ToVar(TAggregates(AObj).Add());
end;

function TAggregates_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TAggregates(AObj).Clear();
end;

function TAggregates_Find_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Find(const DisplayName: string): TAggregate;

  Result := TAggregate_sw.ToVar(TAggregates(AObj).Find(string(AArgs[0])));
end;

function TAggregates_IndexOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOf(const DisplayName: string): Integer;

  Result := TAggregates(AObj).IndexOf(string(AArgs[0]));
end;

function TAggregates_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TAggregate read <getter> ...

  if IsGet then
    Result := TAggregate_sw.ToVar(TAggregates(AObj).Items[Integer(AArgs[0])])
  else
    TAggregates(AObj).Items[Integer(AArgs[0])] := TAggregate_sw.FromVar(
      AArgs[1]);
end;

class function TAggregates_sw.GetTypeName: WideString;
begin
  Result := 'TAggregates';
end;

class function TAggregates_sw.GetWrappedClass: TClass;
begin
  Result := TAggregates;
end;

class procedure TAggregates_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TAggregates_Add_si, TAggregate_sw, 0, False);
  AData.AddProcedure('Clear', TAggregates_Clear_si, 0, False);
  AData.AddFunction('Find', TAggregates_Find_si, TAggregate_sw, 1, False);
  AData.AddFunction('IndexOf', TAggregates_IndexOf_si, Integer_sw, 1, False);
  AData.AddProperty('Items', TAggregates_Items_si, TAggregate_sw, True, True, 1, False, True);

  { Class members }

  AData.AddConstructor('Create', TAggregates_Create_si, 1, False);
end;

class function TAggregates_sw.ToVar(const AValue: TAggregates): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TAggregates_sw.FromVar(const AValue: OleVariant): TAggregates;
begin
  Result := TAggregates(ConvFromVar(AValue, TAggregates));
end;

class function TAggregates_sw.ClassToVar(AClass: TAggregates_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TAggregates_sw.ClassFromVar(
  const AClass: OleVariant): TAggregates_sc;
begin
  Result := TAggregates_sc(ConvClsFromVar(AClass, TAggregates));
end;

{ TRecInfo_sw }

function TRecInfo_RecordNumber_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var RecordNumber: Longint;

  if IsGet then
    Result := TRecInfo_sw(AObj).FValue.RecordNumber
  else
    TRecInfo_sw(AObj).FValue.RecordNumber := Longint(AArgs[0]);
end;

function TRecInfo_BookmarkFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BookmarkFlag: TBookmarkFlag;

  if IsGet then
    Result := TBookmarkFlag_sw.ToVar(TRecInfo_sw(AObj).FValue.BookmarkFlag)
  else
    TRecInfo_sw(AObj).FValue.BookmarkFlag := TBookmarkFlag_sw.FromVar(AArgs[0]);
end;

function TRecInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TRecInfo_sw.Create as IDispatch;
end;

function TRecInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TRecInfo;

  // Implicit record copy method.
  Result := TRecInfo_sw.ToVar(TRecInfo(AObj));
end;

class function TRecInfo_sw.GetTypeName: WideString;
begin
  Result := 'TRecInfo';
end;

function TRecInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TRecInfo_sw.Create;
  TRecInfo_sw(Result).FValue := FValue;
end;

class procedure TRecInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('RecordNumber', TRecInfo_RecordNumber_si, Longint_sw);
  AData.AddField('BookmarkFlag', TRecInfo_BookmarkFlag_si, TBookmarkFlag_sw);
  AData.AddFunction('Copy', TRecInfo_Copy_si, TRecInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TRecInfo_Create_si, 0, False);
end;

class function TRecInfo_sw.ToVar(const AValue: TRecInfo): OleVariant;
var
  wrpr: TRecInfo_sw;
begin
  wrpr        := TRecInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TRecInfo_sw.FromVar(const AValue: OleVariant): TRecInfo;
begin
  Result := TRecInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TKeyBuffer_sw }

function TKeyBuffer_Modified_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Modified: Boolean;

  if IsGet then
    Result := TKeyBuffer_sw(AObj).FValue.Modified
  else
    TKeyBuffer_sw(AObj).FValue.Modified := Boolean(AArgs[0]);
end;

function TKeyBuffer_Exclusive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Exclusive: Boolean;

  if IsGet then
    Result := TKeyBuffer_sw(AObj).FValue.Exclusive
  else
    TKeyBuffer_sw(AObj).FValue.Exclusive := Boolean(AArgs[0]);
end;

function TKeyBuffer_FieldCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FieldCount: Integer;

  if IsGet then
    Result := TKeyBuffer_sw(AObj).FValue.FieldCount
  else
    TKeyBuffer_sw(AObj).FValue.FieldCount := Integer(AArgs[0]);
end;

function TKeyBuffer_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TKeyBuffer_sw.Create as IDispatch;
end;

function TKeyBuffer_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TKeyBuffer;

  // Implicit record copy method.
  Result := TKeyBuffer_sw.ToVar(TKeyBuffer(AObj));
end;

class function TKeyBuffer_sw.GetTypeName: WideString;
begin
  Result := 'TKeyBuffer';
end;

function TKeyBuffer_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TKeyBuffer_sw.Create;
  TKeyBuffer_sw(Result).FValue := FValue;
end;

class procedure TKeyBuffer_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Modified', TKeyBuffer_Modified_si, Boolean_sw);
  AData.AddField('Exclusive', TKeyBuffer_Exclusive_si, Boolean_sw);
  AData.AddField('FieldCount', TKeyBuffer_FieldCount_si, Integer_sw);
  AData.AddFunction('Copy', TKeyBuffer_Copy_si, TKeyBuffer_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TKeyBuffer_Create_si, 0, False);
end;

class function TKeyBuffer_sw.ToVar(const AValue: TKeyBuffer): OleVariant;
var
  wrpr: TKeyBuffer_sw;
begin
  wrpr        := TKeyBuffer_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TKeyBuffer_sw.FromVar(const AValue: OleVariant): TKeyBuffer;
begin
  Result := TKeyBuffer_sw(ConvFromVar(AValue)).FValue;
end;

{ TDataPacketFormat_sw }

class function TDataPacketFormat_sw.GetTypeName: WideString;
begin
  Result := 'TDataPacketFormat';
end;

class procedure TDataPacketFormat_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'dfBinary'; Value: Integer({$IFDEF LMDSCT_12}TDataPacketFormat.{$ENDIF}dfBinary)),
    (Name: 'dfXML'; Value: Integer({$IFDEF LMDSCT_12}TDataPacketFormat.{$ENDIF}dfXML)),
    (Name: 'dfXMLUTF8'; Value: Integer({$IFDEF LMDSCT_12}TDataPacketFormat.{$ENDIF}dfXMLUTF8))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TDataPacketFormat_sw.ToVar(
  const AValue: TDataPacketFormat): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDataPacketFormat_sw.FromVar(
  const AValue: OleVariant): TDataPacketFormat;
begin
  Result := TDataPacketFormat(Integer(AValue));
end;

{ TReconcileAction_sw }

class function TReconcileAction_sw.GetTypeName: WideString;
begin
  Result := 'TReconcileAction';
end;

class procedure TReconcileAction_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'raSkip'; Value: Integer({$IFDEF LMDSCT_12}TReconcileAction.{$ENDIF}raSkip)),
    (Name: 'raAbort'; Value: Integer({$IFDEF LMDSCT_12}TReconcileAction.{$ENDIF}raAbort)),
    (Name: 'raMerge'; Value: Integer({$IFDEF LMDSCT_12}TReconcileAction.{$ENDIF}raMerge)),
    (Name: 'raCorrect'; Value: Integer({$IFDEF LMDSCT_12}TReconcileAction.{$ENDIF}raCorrect)),
    (Name: 'raCancel'; Value: Integer({$IFDEF LMDSCT_12}TReconcileAction.{$ENDIF}raCancel)),
    (Name: 'raRefresh'; Value: Integer({$IFDEF LMDSCT_12}TReconcileAction.{$ENDIF}raRefresh))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TReconcileAction_sw.ToVar(
  const AValue: TReconcileAction): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TReconcileAction_sw.FromVar(
  const AValue: OleVariant): TReconcileAction;
begin
  Result := TReconcileAction(Integer(AValue));
end;

{ TReconcileErrorEvent_sh }

function TReconcileErrorEvent_sh.GetHandler: TMethod;
var
  hdr: TReconcileErrorEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TReconcileErrorEvent_sh.Handler(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (DataSet: TCustomClientDataSet; E: EReconcileEr...

  v_1 := TReconcileAction_sw.ToVar(Action);
  args[0] := TCustomClientDataSet_sw.ToVar(DataSet);
  args[1] := EReconcileError_sw.ToVar(E);
  args[2] := TUpdateKind_sw.ToVar(UpdateKind);
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Action := TReconcileAction_sw.FromVar(v_1);
end;

{ TReconcileErrorEvent_sw }

class function TReconcileErrorEvent_sw.GetTypeName: WideString;
begin
  Result := 'TReconcileErrorEvent';
end;

class function TReconcileErrorEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TReconcileErrorEvent_sh;
end;

class function TReconcileErrorEvent_sw.ToVar(
  const AValue: TReconcileErrorEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TReconcileErrorEvent_sw.FromVar(
  const AValue: OleVariant): TReconcileErrorEvent;
begin
  Result := TReconcileErrorEvent(ConvFromVar(AValue));
end;

class function TReconcileErrorEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TReconcileErrorEvent;
var
  hdlr: TReconcileErrorEvent_sh;
begin
  hdlr   := TReconcileErrorEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TReconcileErrorEvent_sw));
  Result := hdlr.Handler;
end;

{ TRemoteEvent_sh }

function TRemoteEvent_sh.GetHandler: TMethod;
var
  hdr: TRemoteEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TRemoteEvent_sh.Handler(Sender: TObject; var OwnerData: OleVariant);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var OwnerData: OleVariant) of...

  v_1 := OwnerData;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  OwnerData := OleVariant(FindVarData(v_1)^);
end;

{ TRemoteEvent_sw }

class function TRemoteEvent_sw.GetTypeName: WideString;
begin
  Result := 'TRemoteEvent';
end;

class function TRemoteEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TRemoteEvent_sh;
end;

class function TRemoteEvent_sw.ToVar(const AValue: TRemoteEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TRemoteEvent_sw.FromVar(const AValue: OleVariant): TRemoteEvent;
begin
  Result := TRemoteEvent(ConvFromVar(AValue));
end;

class function TRemoteEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TRemoteEvent;
var
  hdlr: TRemoteEvent_sh;
begin
  hdlr   := TRemoteEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TRemoteEvent_sw));
  Result := hdlr.Handler;
end;

{ TReconcileInfo_sw }

function TReconcileInfo_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DataSet: TDataSet;

  if IsGet then
    Result := TDataSet_sw.ToVar(TReconcileInfo_sw(AObj).FValue.DataSet)
  else
    TReconcileInfo_sw(AObj).FValue.DataSet := TDataSet_sw.FromVar(AArgs[0]);
end;

function TReconcileInfo_UpdateKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var UpdateKind: TUpdateKind;

  if IsGet then
    Result := TUpdateKind_sw.ToVar(TReconcileInfo_sw(AObj).FValue.UpdateKind)
  else
    TReconcileInfo_sw(AObj).FValue.UpdateKind := TUpdateKind_sw.FromVar(
      AArgs[0]);
end;

function TReconcileInfo_ReconcileError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ReconcileError: EReconcileError;

  if IsGet then
    Result := EReconcileError_sw.ToVar(TReconcileInfo_sw(AObj).FValue.
      ReconcileError)
  else
    TReconcileInfo_sw(AObj).FValue.ReconcileError := EReconcileError_sw.FromVar(
      AArgs[0]);
end;

function TReconcileInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TReconcileInfo_sw.Create as IDispatch;
end;

function TReconcileInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TReconcileInfo;

  // Implicit record copy method.
  Result := TReconcileInfo_sw.ToVar(TReconcileInfo(AObj));
end;

class function TReconcileInfo_sw.GetTypeName: WideString;
begin
  Result := 'TReconcileInfo';
end;

function TReconcileInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TReconcileInfo_sw.Create;
  TReconcileInfo_sw(Result).FValue := FValue;
end;

class procedure TReconcileInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('DataSet', TReconcileInfo_DataSet_si, TDataSet_sw);
  AData.AddField('UpdateKind', TReconcileInfo_UpdateKind_si, TUpdateKind_sw);
  AData.AddField('ReconcileError', TReconcileInfo_ReconcileError_si, EReconcileError_sw);
  AData.AddFunction('Copy', TReconcileInfo_Copy_si, TReconcileInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TReconcileInfo_Create_si, 0, False);
end;

class function TReconcileInfo_sw.ToVar(
  const AValue: TReconcileInfo): OleVariant;
var
  wrpr: TReconcileInfo_sw;
begin
  wrpr        := TReconcileInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TReconcileInfo_sw.FromVar(
  const AValue: OleVariant): TReconcileInfo;
begin
  Result := TReconcileInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TDataSetOption_sw }

class function TDataSetOption_sw.GetTypeName: WideString;
begin
  Result := 'TDataSetOption';
end;

class procedure TDataSetOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'doDisableInserts'; Value: Integer({$IFDEF LMDSCT_12}TDataSetOption.{$ENDIF}doDisableInserts)),
    (Name: 'doDisableDeletes'; Value: Integer({$IFDEF LMDSCT_12}TDataSetOption.{$ENDIF}doDisableDeletes)),
    (Name: 'doDisableEdits'; Value: Integer({$IFDEF LMDSCT_12}TDataSetOption.{$ENDIF}doDisableEdits)),
    (Name: 'doNoResetCall'; Value: Integer({$IFDEF LMDSCT_12}TDataSetOption.{$ENDIF}doNoResetCall))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TDataSetOption_sw.ToVar(
  const AValue: TDataSetOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDataSetOption_sw.FromVar(
  const AValue: OleVariant): TDataSetOption;
begin
  Result := TDataSetOption(Integer(AValue));
end;

{ TDataSetOptions_sw }

class function TDataSetOptions_sw.GetTypeName: WideString;
begin
  Result := 'TDataSetOptions';
end;

class function TDataSetOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TDataSetOptions);
end;

class function TDataSetOptions_sw.ToVar(
  const AValue: TDataSetOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TDataSetOptions_sw.FromVar(
  const AValue: OleVariant): TDataSetOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFetchOption_sw }

class function TFetchOption_sw.GetTypeName: WideString;
begin
  Result := 'TFetchOption';
end;

class procedure TFetchOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'foRecord'; Value: Integer({$IFDEF LMDSCT_12}TFetchOption.{$ENDIF}foRecord)),
    (Name: 'foBlobs'; Value: Integer({$IFDEF LMDSCT_12}TFetchOption.{$ENDIF}foBlobs)),
    (Name: 'foDetails'; Value: Integer({$IFDEF LMDSCT_12}TFetchOption.{$ENDIF}foDetails))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TFetchOption_sw.ToVar(const AValue: TFetchOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFetchOption_sw.FromVar(const AValue: OleVariant): TFetchOption;
begin
  Result := TFetchOption(Integer(AValue));
end;

{ TFetchOptions_sw }

class function TFetchOptions_sw.GetTypeName: WideString;
begin
  Result := 'TFetchOptions';
end;

class function TFetchOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFetchOptions);
end;

class function TFetchOptions_sw.ToVar(const AValue: TFetchOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFetchOptions_sw.FromVar(
  const AValue: OleVariant): TFetchOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TCustomClientDataSet_sw }

function TCustomClientDataSet_Aggregates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Aggregates: TAggregates read <getter> ...

  if IsGet then
    Result := TAggregates_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).Aggregates)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).Aggregates := 
      TAggregates_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_AggregatesActive_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AggregatesActive: Boolean read <getter...

  if IsGet then
    Result := TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).
      AggregatesActive
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).AggregatesActive := 
      Boolean(AArgs[0]);
end;

function TCustomClientDataSet_CommandText_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property CommandText: WideString read <getter> ...

  if IsGet then
    Result := TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).CommandText
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).CommandText := 
      WideString(AArgs[0]);
end;

function TCustomClientDataSet_DisableStringTrim_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DisableStringTrim: Boolean read <gette...

  if IsGet then
    Result := TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).
      DisableStringTrim
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).DisableStringTrim := 
      Boolean(AArgs[0]);
end;

function TCustomClientDataSet_IndexDefs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property IndexDefs: TIndexDefs read <getter> wr...

  if IsGet then
    Result := TIndexDefs_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).IndexDefs)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).IndexDefs := 
      TIndexDefs_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_IndexName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property IndexName: Widestring read <getter> wr...

  if IsGet then
    Result := TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).IndexName
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).IndexName := 
      Widestring(AArgs[0]);
end;

function TCustomClientDataSet_IsClone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property IsClone: Boolean read <getter>;

  Result := TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).IsClone;
end;

function TCustomClientDataSet_FetchOnDemand_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property FetchOnDemand: Boolean read <getter> w...

  if IsGet then
    Result := TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).
      FetchOnDemand
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).FetchOnDemand := 
      Boolean(AArgs[0]);
end;

function TCustomClientDataSet_MasterSource_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MasterSource: TDataSource read <getter...

  if IsGet then
    Result := TDataSource_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).MasterSource)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).MasterSource := 
      TDataSource_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_Params_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Params: TParams read <getter> write <s...

  if IsGet then
    Result := TParams_sw.ToVar(TCustomClientDataSet_sacc(TCustomClientDataSet(
      AObj)).Params)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).Params := TParams_sw.
      FromVar(AArgs[0]);
end;

function TCustomClientDataSet_ProviderEOF_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ProviderEOF: Boolean read <getter> wri...

  if IsGet then
    Result := TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).ProviderEOF
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).ProviderEOF := 
      Boolean(AArgs[0]);
end;

function TCustomClientDataSet_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ReadOnly: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).ReadOnly
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).ReadOnly := Boolean(
      AArgs[0]);
end;

function TCustomClientDataSet_StoreDefs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property StoreDefs: Boolean read <getter> write...

  if IsGet then
    Result := TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).StoreDefs
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).StoreDefs := Boolean(
      AArgs[0]);
end;

function TCustomClientDataSet_OnReconcileError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnReconcileError: TReconcileErrorEvent...

  if IsGet then
    Result := TReconcileErrorEvent_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).OnReconcileError)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).OnReconcileError := 
      TReconcileErrorEvent_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_BeforeApplyUpdates_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BeforeApplyUpdates: TRemoteEvent read ...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).BeforeApplyUpdates)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).BeforeApplyUpdates := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_AfterApplyUpdates_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AfterApplyUpdates: TRemoteEvent read <...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).AfterApplyUpdates)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).AfterApplyUpdates := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_BeforeGetRecords_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BeforeGetRecords: TRemoteEvent read <g...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).BeforeGetRecords)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).BeforeGetRecords := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_AfterGetRecords_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AfterGetRecords: TRemoteEvent read <ge...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).AfterGetRecords)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).AfterGetRecords := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_BeforeRowRequest_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BeforeRowRequest: TRemoteEvent read <g...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).BeforeRowRequest)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).BeforeRowRequest := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_AfterRowRequest_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AfterRowRequest: TRemoteEvent read <ge...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).AfterRowRequest)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).AfterRowRequest := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_BeforeExecute_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BeforeExecute: TRemoteEvent read <gett...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).BeforeExecute)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).BeforeExecute := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_AfterExecute_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AfterExecute: TRemoteEvent read <gette...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).AfterExecute)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).AfterExecute := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_BeforeGetParams_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BeforeGetParams: TRemoteEvent read <ge...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).BeforeGetParams)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).BeforeGetParams := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_AfterGetParams_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AfterGetParams: TRemoteEvent read <get...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomClientDataSet_sacc(
      TCustomClientDataSet(AObj)).AfterGetParams)
  else
    TCustomClientDataSet_sacc(TCustomClientDataSet(AObj)).AfterGetParams := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomClientDataSet_ProviderName_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ProviderName: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomClientDataSet(AObj).ProviderName
  else
    TCustomClientDataSet(AObj).ProviderName := string(AArgs[0]);
end;

function TCustomClientDataSet_FileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileName: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomClientDataSet(AObj).FileName
  else
    TCustomClientDataSet(AObj).FileName := string(AArgs[0]);
end;

function TCustomClientDataSet_ConnectionBroker_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ConnectionBroker: TConnectionBroker read <getter...

  if IsGet then
    Result := TConnectionBroker_sw.ToVar(TCustomClientDataSet(AObj).
      ConnectionBroker)
  else
    TCustomClientDataSet(AObj).ConnectionBroker := TConnectionBroker_sw.FromVar(
      AArgs[0]);
end;

function TCustomClientDataSet_IndexFieldNames_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexFieldNames: Widestring read <getter> write ...

  if IsGet then
    Result := TCustomClientDataSet(AObj).IndexFieldNames
  else
    TCustomClientDataSet(AObj).IndexFieldNames := Widestring(AArgs[0]);
end;

function TCustomClientDataSet_MasterFields_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MasterFields: Widestring read <getter> write <se...

  if IsGet then
    Result := TCustomClientDataSet(AObj).MasterFields
  else
    TCustomClientDataSet(AObj).MasterFields := Widestring(AArgs[0]);
end;

function TCustomClientDataSet_PacketRecords_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PacketRecords: Integer read <getter> write <sett...

  if IsGet then
    Result := TCustomClientDataSet(AObj).PacketRecords
  else
    TCustomClientDataSet(AObj).PacketRecords := Integer(AArgs[0]);
end;

function TCustomClientDataSet_RemoteServer_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RemoteServer: TCustomRemoteServer read <getter> ...

  if IsGet then
    Result := TCustomRemoteServer_sw.ToVar(TCustomClientDataSet(AObj).
      RemoteServer)
  else
    TCustomClientDataSet(AObj).RemoteServer := TCustomRemoteServer_sw.FromVar(
      AArgs[0]);
end;

function TCustomClientDataSet_AddIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AddIndex(const Name: string; const Fields: stri...

  case AArgsSize of
    3:
    begin
      TCustomClientDataSet(AObj).AddIndex(string(AArgs[0]), string(AArgs[1]), 
        TIndexOptions_sw.FromVar(AArgs[2]));
    end;
    4:
    begin
      TCustomClientDataSet(AObj).AddIndex(string(AArgs[0]), string(AArgs[1]), 
        TIndexOptions_sw.FromVar(AArgs[2]), string(AArgs[3]));
    end;
    5:
    begin
      TCustomClientDataSet(AObj).AddIndex(string(AArgs[0]), string(AArgs[1]), 
        TIndexOptions_sw.FromVar(AArgs[2]), string(AArgs[3]), string(AArgs[4]));
    end;
    6:
    begin
      TCustomClientDataSet(AObj).AddIndex(string(AArgs[0]), string(AArgs[1]), 
        TIndexOptions_sw.FromVar(AArgs[2]), string(AArgs[3]), string(AArgs[4]),
        Integer(AArgs[5]));
    end;
  else
    WrongArgCountError('AddIndex');
  end;
end;

function TCustomClientDataSet_AppendData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AppendData(const Data: OleVariant; HitEOF: Bool...

  TCustomClientDataSet(AObj).AppendData(OleVariant(FindVarData(AArgs[0])^), 
    Boolean(AArgs[1]));
end;

function TCustomClientDataSet_ApplyRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ApplyRange;

  TCustomClientDataSet(AObj).ApplyRange();
end;

function TCustomClientDataSet_ApplyUpdates_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ApplyUpdates(MaxErrors: Integer): Integer;

  Result := TCustomClientDataSet(AObj).ApplyUpdates(Integer(AArgs[0]));
end;

function TCustomClientDataSet_CancelRange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CancelRange;

  TCustomClientDataSet(AObj).CancelRange();
end;

function TCustomClientDataSet_CancelUpdates_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CancelUpdates;

  TCustomClientDataSet(AObj).CancelUpdates();
end;

function TCustomClientDataSet_CreateDataSet_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CreateDataSet;

  TCustomClientDataSet(AObj).CreateDataSet();
end;

function TCustomClientDataSet_CloneCursor_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CloneCursor(Source: TCustomClientDataSet; Reset...

  case AArgsSize of
    2:
    begin
      TCustomClientDataSet(AObj).CloneCursor(TCustomClientDataSet_sw.FromVar(
        AArgs[0]), Boolean(AArgs[1]));
    end;
    3:
    begin
      TCustomClientDataSet(AObj).CloneCursor(TCustomClientDataSet_sw.FromVar(
        AArgs[0]), Boolean(AArgs[1]), Boolean(AArgs[2]));
    end;
  else
    WrongArgCountError('CloneCursor');
  end;
end;

function TCustomClientDataSet_ConstraintsDisabled_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ConstraintsDisabled: Boolean;

  Result := TCustomClientDataSet(AObj).ConstraintsDisabled();
end;

function TCustomClientDataSet_DataRequest_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DataRequest(Data: OleVariant): OleVariant;

  Result := TCustomClientDataSet(AObj).DataRequest(OleVariant(FindVarData(
    AArgs[0])^));
end;

function TCustomClientDataSet_DeleteIndex_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DeleteIndex(const Name: string);

  TCustomClientDataSet(AObj).DeleteIndex(string(AArgs[0]));
end;

function TCustomClientDataSet_DisableConstraints_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DisableConstraints;

  TCustomClientDataSet(AObj).DisableConstraints();
end;

function TCustomClientDataSet_EnableConstraints_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EnableConstraints;

  TCustomClientDataSet(AObj).EnableConstraints();
end;

function TCustomClientDataSet_EditKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EditKey;

  TCustomClientDataSet(AObj).EditKey();
end;

function TCustomClientDataSet_EditRangeEnd_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EditRangeEnd;

  TCustomClientDataSet(AObj).EditRangeEnd();
end;

function TCustomClientDataSet_EditRangeStart_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EditRangeStart;

  TCustomClientDataSet(AObj).EditRangeStart();
end;

function TCustomClientDataSet_EmptyDataSet_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EmptyDataSet;

  TCustomClientDataSet(AObj).EmptyDataSet();
end;

function TCustomClientDataSet_Execute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Execute;

  TCustomClientDataSet(AObj).Execute();
end;

function TCustomClientDataSet_FetchBlobs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FetchBlobs;

  TCustomClientDataSet(AObj).FetchBlobs();
end;

function TCustomClientDataSet_FetchDetails_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FetchDetails;

  TCustomClientDataSet(AObj).FetchDetails();
end;

function TCustomClientDataSet_RefreshRecord_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RefreshRecord;

  TCustomClientDataSet(AObj).RefreshRecord();
end;

function TCustomClientDataSet_FetchParams_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FetchParams;

  TCustomClientDataSet(AObj).FetchParams();
end;

function TCustomClientDataSet_GetGroupState_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetGroupState(Level: Integer): TGroupPosInds;

  Result := TGroupPosInds_sw.ToVar(TCustomClientDataSet(AObj).GetGroupState(
    Integer(AArgs[0])));
end;

function TCustomClientDataSet_GetIndexInfo_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetIndexInfo(IndexName: string);

  TCustomClientDataSet(AObj).GetIndexInfo(string(AArgs[0]));
end;

function TCustomClientDataSet_GetIndexNames_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetIndexNames(List: TStrings);

  TCustomClientDataSet(AObj).GetIndexNames(TStrings_sw.FromVar(AArgs[0]));
end;

function TCustomClientDataSet_GetNextPacket_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetNextPacket: Integer;

  Result := TCustomClientDataSet(AObj).GetNextPacket();
end;

function TCustomClientDataSet_GetOptionalParam_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetOptionalParam(const ParamName: string): OleVa...

  Result := TCustomClientDataSet(AObj).GetOptionalParam(string(AArgs[0]));
end;

function TCustomClientDataSet_GotoCurrent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GotoCurrent(DataSet: TCustomClientDataSet);

  TCustomClientDataSet(AObj).GotoCurrent(TCustomClientDataSet_sw.FromVar(
    AArgs[0]));
end;

function TCustomClientDataSet_GotoKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GotoKey: Boolean;

  Result := TCustomClientDataSet(AObj).GotoKey();
end;

function TCustomClientDataSet_GotoNearest_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GotoNearest;

  TCustomClientDataSet(AObj).GotoNearest();
end;

function TCustomClientDataSet_HasAppServer_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HasAppServer: Boolean read <getter>;

  Result := TCustomClientDataSet(AObj).HasAppServer;
end;

function TCustomClientDataSet_LoadFromFile_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromFile(const FileName: string);

  case AArgsSize of
    0:
    begin
      TCustomClientDataSet(AObj).LoadFromFile();
    end;
    1:
    begin
      TCustomClientDataSet(AObj).LoadFromFile(string(AArgs[0]));
    end;
  else
    WrongArgCountError('LoadFromFile');
  end;
end;

function TCustomClientDataSet_LoadFromStream_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromStream(Stream: TStream);

  TCustomClientDataSet(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]));
end;

function TCustomClientDataSet_MergeChangeLog_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MergeChangeLog;

  TCustomClientDataSet(AObj).MergeChangeLog();
end;

function TCustomClientDataSet_Reconcile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Reconcile(const Results: OleVariant): Boolean;

  Result := TCustomClientDataSet(AObj).Reconcile(OleVariant(FindVarData(
    AArgs[0])^));
end;

function TCustomClientDataSet_RevertRecord_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RevertRecord;

  TCustomClientDataSet(AObj).RevertRecord();
end;

function TCustomClientDataSet_SaveToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToFile(const FileName: string; Format: TDat...

  case AArgsSize of
    0:
    begin
      TCustomClientDataSet(AObj).SaveToFile();
    end;
    1:
    begin
      TCustomClientDataSet(AObj).SaveToFile(string(AArgs[0]));
    end;
    2:
    begin
      TCustomClientDataSet(AObj).SaveToFile(string(AArgs[0]), 
        TDataPacketFormat_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('SaveToFile');
  end;
end;

function TCustomClientDataSet_SaveToStream_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToStream(Stream: TStream; Format: TDataPack...

  case AArgsSize of
    1:
    begin
      TCustomClientDataSet(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      TCustomClientDataSet(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]), 
        TDataPacketFormat_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('SaveToStream');
  end;
end;

function TCustomClientDataSet_SetKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetKey;

  TCustomClientDataSet(AObj).SetKey();
end;

function TCustomClientDataSet_SetOptionalParam_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetOptionalParam(const ParamName: string; const...

  case AArgsSize of
    2:
    begin
      TCustomClientDataSet(AObj).SetOptionalParam(string(AArgs[0]), OleVariant(
        FindVarData(AArgs[1])^));
    end;
    3:
    begin
      TCustomClientDataSet(AObj).SetOptionalParam(string(AArgs[0]), OleVariant(
        FindVarData(AArgs[1])^), Boolean(AArgs[2]));
    end;
  else
    WrongArgCountError('SetOptionalParam');
  end;
end;

function TCustomClientDataSet_SetProvider_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetProvider(Provider: TComponent);

  TCustomClientDataSet(AObj).SetProvider(TComponent_sw.FromVar(AArgs[0]));
end;

function TCustomClientDataSet_SetRangeEnd_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetRangeEnd;

  TCustomClientDataSet(AObj).SetRangeEnd();
end;

function TCustomClientDataSet_SetRangeStart_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetRangeStart;

  TCustomClientDataSet(AObj).SetRangeStart();
end;

function TCustomClientDataSet_UndoLastChange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UndoLastChange(FollowChange: Boolean): Boolean;

  Result := TCustomClientDataSet(AObj).UndoLastChange(Boolean(AArgs[0]));
end;

function TCustomClientDataSet_ActiveAggs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActiveAggs[Index: Integer]: TList read <getter>;

  Result := TList_sw.ToVar(TCustomClientDataSet(AObj).ActiveAggs[Integer(
    AArgs[0])]);
end;

function TCustomClientDataSet_ChangeCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ChangeCount: Integer read <getter>;

  Result := TCustomClientDataSet(AObj).ChangeCount;
end;

function TCustomClientDataSet_CloneSource_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CloneSource: TCustomClientDataSet read <getter>;

  Result := TCustomClientDataSet_sw.ToVar(TCustomClientDataSet(AObj).
    CloneSource);
end;

function TCustomClientDataSet_Data_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Data: OleVariant read <getter> write <setter>;

  if IsGet then
    Result := TCustomClientDataSet(AObj).Data
  else
    TCustomClientDataSet(AObj).Data := OleVariant(FindVarData(AArgs[0])^);
end;

function TCustomClientDataSet_XMLData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property XMLData: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomClientDataSet(AObj).XMLData
  else
    TCustomClientDataSet(AObj).XMLData := string(AArgs[0]);
end;

function TCustomClientDataSet_DataSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSize: Integer read <getter>;

  Result := TCustomClientDataSet(AObj).DataSize;
end;

function TCustomClientDataSet_Delta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Delta: OleVariant read <getter>;

  Result := TCustomClientDataSet(AObj).Delta;
end;

function TCustomClientDataSet_GroupingLevel_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GroupingLevel: Integer read <getter>;

  Result := TCustomClientDataSet(AObj).GroupingLevel;
end;

function TCustomClientDataSet_IndexFieldCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexFieldCount: Integer read <getter>;

  Result := TCustomClientDataSet(AObj).IndexFieldCount;
end;

function TCustomClientDataSet_IndexFields_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IndexFields[Index: Integer]: TField read <getter...

  if IsGet then
    Result := TField_sw.ToVar(TCustomClientDataSet(AObj).IndexFields[Integer(
      AArgs[0])])
  else
    TCustomClientDataSet(AObj).IndexFields[Integer(AArgs[0])] := TField_sw.
      FromVar(AArgs[1]);
end;

function TCustomClientDataSet_KeyExclusive_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeyExclusive: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomClientDataSet(AObj).KeyExclusive
  else
    TCustomClientDataSet(AObj).KeyExclusive := Boolean(AArgs[0]);
end;

function TCustomClientDataSet_KeyFieldCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeyFieldCount: Integer read <getter> write <sett...

  if IsGet then
    Result := TCustomClientDataSet(AObj).KeyFieldCount
  else
    TCustomClientDataSet(AObj).KeyFieldCount := Integer(AArgs[0]);
end;

function TCustomClientDataSet_KeySize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeySize: Word read <getter>;

  Result := TCustomClientDataSet(AObj).KeySize;
end;

function TCustomClientDataSet_LogChanges_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LogChanges: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomClientDataSet(AObj).LogChanges
  else
    TCustomClientDataSet(AObj).LogChanges := Boolean(AArgs[0]);
end;

function TCustomClientDataSet_SavePoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SavePoint: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomClientDataSet(AObj).SavePoint
  else
    TCustomClientDataSet(AObj).SavePoint := Integer(AArgs[0]);
end;

function TCustomClientDataSet_StatusFilter_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StatusFilter: TUpdateStatusSet read <getter> wri...

  if IsGet then
    Result := TUpdateStatusSet_sw.ToVar(TCustomClientDataSet(AObj).StatusFilter)
  else
    TCustomClientDataSet(AObj).StatusFilter := TUpdateStatusSet_sw.FromVar(
      AArgs[0]);
end;

function TCustomClientDataSet_Ranged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Ranged: Boolean read <getter>;

  Result := TCustomClientDataSet(AObj).Ranged;
end;

class function TCustomClientDataSet_sw.GetTypeName: WideString;
begin
  Result := 'TCustomClientDataSet';
end;

class function TCustomClientDataSet_sw.GetWrappedClass: TClass;
begin
  Result := TCustomClientDataSet;
end;

class procedure TCustomClientDataSet_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Aggregates', TCustomClientDataSet_Aggregates_si, TAggregates_sw, True, True, 0, True, False);
  AData.AddProperty('AggregatesActive', TCustomClientDataSet_AggregatesActive_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('CommandText', TCustomClientDataSet_CommandText_si, WideString_sw, True, True, 0, True, False);
  AData.AddProperty('DisableStringTrim', TCustomClientDataSet_DisableStringTrim_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('IndexDefs', TCustomClientDataSet_IndexDefs_si, TIndexDefs_sw, True, True, 0, True, False);
  AData.AddProperty('IndexName', TCustomClientDataSet_IndexName_si, Widestring_sw, True, True, 0, True, False);
  AData.AddProperty('IsClone', TCustomClientDataSet_IsClone_si, Boolean_sw, True, False, 0, True, False);
  AData.AddProperty('FetchOnDemand', TCustomClientDataSet_FetchOnDemand_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('MasterSource', TCustomClientDataSet_MasterSource_si, TDataSource_sw, True, True, 0, True, False);
  AData.AddProperty('Params', TCustomClientDataSet_Params_si, TParams_sw, True, True, 0, True, False);
  AData.AddProperty('ProviderEOF', TCustomClientDataSet_ProviderEOF_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ReadOnly', TCustomClientDataSet_ReadOnly_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('StoreDefs', TCustomClientDataSet_StoreDefs_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('OnReconcileError', TCustomClientDataSet_OnReconcileError_si, TReconcileErrorEvent_sw, True, True, 0, True, False);
  AData.AddProperty('BeforeApplyUpdates', TCustomClientDataSet_BeforeApplyUpdates_si, TRemoteEvent_sw, True, True, 0, True, False);
  AData.AddProperty('AfterApplyUpdates', TCustomClientDataSet_AfterApplyUpdates_si, TRemoteEvent_sw, True, True, 0, True, False);
  AData.AddProperty('BeforeGetRecords', TCustomClientDataSet_BeforeGetRecords_si, TRemoteEvent_sw, True, True, 0, True, False);
  AData.AddProperty('AfterGetRecords', TCustomClientDataSet_AfterGetRecords_si, TRemoteEvent_sw, True, True, 0, True, False);
  AData.AddProperty('BeforeRowRequest', TCustomClientDataSet_BeforeRowRequest_si, TRemoteEvent_sw, True, True, 0, True, False);
  AData.AddProperty('AfterRowRequest', TCustomClientDataSet_AfterRowRequest_si, TRemoteEvent_sw, True, True, 0, True, False);
  AData.AddProperty('BeforeExecute', TCustomClientDataSet_BeforeExecute_si, TRemoteEvent_sw, True, True, 0, True, False);
  AData.AddProperty('AfterExecute', TCustomClientDataSet_AfterExecute_si, TRemoteEvent_sw, True, True, 0, True, False);
  AData.AddProperty('BeforeGetParams', TCustomClientDataSet_BeforeGetParams_si, TRemoteEvent_sw, True, True, 0, True, False);
  AData.AddProperty('AfterGetParams', TCustomClientDataSet_AfterGetParams_si, TRemoteEvent_sw, True, True, 0, True, False);
  AData.AddPropertyRedecl('Active', False);
  AData.AddPropertyRedecl('DataSetField', False);
  AData.AddProperty('ProviderName', TCustomClientDataSet_ProviderName_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('FileName', TCustomClientDataSet_FileName_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ConnectionBroker', TCustomClientDataSet_ConnectionBroker_si, TConnectionBroker_sw, True, True, 0, False, False);
  AData.AddProperty('IndexFieldNames', TCustomClientDataSet_IndexFieldNames_si, Widestring_sw, True, True, 0, False, False);
  AData.AddProperty('MasterFields', TCustomClientDataSet_MasterFields_si, Widestring_sw, True, True, 0, False, False);
  AData.AddProperty('PacketRecords', TCustomClientDataSet_PacketRecords_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('RemoteServer', TCustomClientDataSet_RemoteServer_si, TCustomRemoteServer_sw, True, True, 0, False, False);
  AData.AddProcedure('AddIndex', TCustomClientDataSet_AddIndex_si, 3, True);
  AData.AddProcedure('AppendData', TCustomClientDataSet_AppendData_si, 2, False);
  AData.AddProcedure('ApplyRange', TCustomClientDataSet_ApplyRange_si, 0, False);
  AData.AddFunction('ApplyUpdates', TCustomClientDataSet_ApplyUpdates_si, Integer_sw, 1, False);
  AData.AddProcedure('CancelRange', TCustomClientDataSet_CancelRange_si, 0, False);
  AData.AddProcedure('CancelUpdates', TCustomClientDataSet_CancelUpdates_si, 0, False);
  AData.AddProcedure('CreateDataSet', TCustomClientDataSet_CreateDataSet_si, 0, False);
  AData.AddProcedure('CloneCursor', TCustomClientDataSet_CloneCursor_si, 2, True);
  AData.AddFunction('ConstraintsDisabled', TCustomClientDataSet_ConstraintsDisabled_si, Boolean_sw, 0, False);
  AData.AddFunction('DataRequest', TCustomClientDataSet_DataRequest_si, OleVariant_sw, 1, False);
  AData.AddProcedure('DeleteIndex', TCustomClientDataSet_DeleteIndex_si, 1, False);
  AData.AddProcedure('DisableConstraints', TCustomClientDataSet_DisableConstraints_si, 0, False);
  AData.AddProcedure('EnableConstraints', TCustomClientDataSet_EnableConstraints_si, 0, False);
  AData.AddProcedure('EditKey', TCustomClientDataSet_EditKey_si, 0, False);
  AData.AddProcedure('EditRangeEnd', TCustomClientDataSet_EditRangeEnd_si, 0, False);
  AData.AddProcedure('EditRangeStart', TCustomClientDataSet_EditRangeStart_si, 0, False);
  AData.AddProcedure('EmptyDataSet', TCustomClientDataSet_EmptyDataSet_si, 0, False);
  AData.AddProcedure('Execute', TCustomClientDataSet_Execute_si, 0, False);
  AData.AddProcedure('FetchBlobs', TCustomClientDataSet_FetchBlobs_si, 0, False);
  AData.AddProcedure('FetchDetails', TCustomClientDataSet_FetchDetails_si, 0, False);
  AData.AddProcedure('RefreshRecord', TCustomClientDataSet_RefreshRecord_si, 0, False);
  AData.AddProcedure('FetchParams', TCustomClientDataSet_FetchParams_si, 0, False);
  AData.AddFunction('GetGroupState', TCustomClientDataSet_GetGroupState_si, TGroupPosInds_sw, 1, False);
  AData.AddProcedure('GetIndexInfo', TCustomClientDataSet_GetIndexInfo_si, 1, False);
  AData.AddProcedure('GetIndexNames', TCustomClientDataSet_GetIndexNames_si, 1, False);
  AData.AddFunction('GetNextPacket', TCustomClientDataSet_GetNextPacket_si, Integer_sw, 0, False);
  AData.AddFunction('GetOptionalParam', TCustomClientDataSet_GetOptionalParam_si, OleVariant_sw, 1, False);
  AData.AddProcedure('GotoCurrent', TCustomClientDataSet_GotoCurrent_si, 1, False);
  AData.AddFunction('GotoKey', TCustomClientDataSet_GotoKey_si, Boolean_sw, 0, False);
  AData.AddProcedure('GotoNearest', TCustomClientDataSet_GotoNearest_si, 0, False);
  AData.AddProperty('HasAppServer', TCustomClientDataSet_HasAppServer_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProcedure('LoadFromFile', TCustomClientDataSet_LoadFromFile_si, 0, True);
  AData.AddProcedure('LoadFromStream', TCustomClientDataSet_LoadFromStream_si, 1, False);
  AData.AddProcedure('MergeChangeLog', TCustomClientDataSet_MergeChangeLog_si, 0, False);
  AData.AddFunction('Reconcile', TCustomClientDataSet_Reconcile_si, Boolean_sw, 1, False);
  AData.AddProcedure('RevertRecord', TCustomClientDataSet_RevertRecord_si, 0, False);
  AData.AddProcedure('SaveToFile', TCustomClientDataSet_SaveToFile_si, 0, True);
  AData.AddProcedure('SaveToStream', TCustomClientDataSet_SaveToStream_si, 1, True);
  AData.AddProcedure('SetKey', TCustomClientDataSet_SetKey_si, 0, False);
  AData.AddProcedure('SetOptionalParam', TCustomClientDataSet_SetOptionalParam_si, 2, True);
  AData.AddProcedure('SetProvider', TCustomClientDataSet_SetProvider_si, 1, False);
  AData.AddProcedure('SetRangeEnd', TCustomClientDataSet_SetRangeEnd_si, 0, False);
  AData.AddProcedure('SetRangeStart', TCustomClientDataSet_SetRangeStart_si, 0, False);
  AData.AddFunction('UndoLastChange', TCustomClientDataSet_UndoLastChange_si, Boolean_sw, 1, False);
  AData.AddProperty('ActiveAggs', TCustomClientDataSet_ActiveAggs_si, TList_sw, True, False, 1, False, False);
  AData.AddProperty('ChangeCount', TCustomClientDataSet_ChangeCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('CloneSource', TCustomClientDataSet_CloneSource_si, TCustomClientDataSet_sw, True, False, 0, False, False);
  AData.AddProperty('Data', TCustomClientDataSet_Data_si, OleVariant_sw, True, True, 0, False, False);
  AData.AddProperty('XMLData', TCustomClientDataSet_XMLData_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('DataSize', TCustomClientDataSet_DataSize_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Delta', TCustomClientDataSet_Delta_si, OleVariant_sw, True, False, 0, False, False);
  AData.AddProperty('GroupingLevel', TCustomClientDataSet_GroupingLevel_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('IndexFieldCount', TCustomClientDataSet_IndexFieldCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('IndexFields', TCustomClientDataSet_IndexFields_si, TField_sw, True, True, 1, False, False);
  AData.AddProperty('KeyExclusive', TCustomClientDataSet_KeyExclusive_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('KeyFieldCount', TCustomClientDataSet_KeyFieldCount_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('KeySize', TCustomClientDataSet_KeySize_si, Word_sw, True, False, 0, False, False);
  AData.AddProperty('LogChanges', TCustomClientDataSet_LogChanges_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('SavePoint', TCustomClientDataSet_SavePoint_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('StatusFilter', TCustomClientDataSet_StatusFilter_si, TUpdateStatusSet_sw, True, True, 0, False, False);
  AData.AddProperty('Ranged', TCustomClientDataSet_Ranged_si, Boolean_sw, True, False, 0, False, False);
end;

class function TCustomClientDataSet_sw.ToVar(
  const AValue: TCustomClientDataSet): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomClientDataSet_sw.FromVar(
  const AValue: OleVariant): TCustomClientDataSet;
begin
  Result := TCustomClientDataSet(ConvFromVar(AValue, TCustomClientDataSet));
end;

class function TCustomClientDataSet_sw.ClassToVar(
  AClass: TCustomClientDataSet_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomClientDataSet_sw.ClassFromVar(
  const AClass: OleVariant): TCustomClientDataSet_sc;
begin
  Result := TCustomClientDataSet_sc(ConvClsFromVar(AClass, 
    TCustomClientDataSet));
end;

{ TClientDataSet_sw }

class function TClientDataSet_sw.GetTypeName: WideString;
begin
  Result := 'TClientDataSet';
end;

class function TClientDataSet_sw.GetWrappedClass: TClass;
begin
  Result := TClientDataSet;
end;

class procedure TClientDataSet_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Active', False);
  AData.AddPropertyRedecl('Aggregates', False);
  AData.AddPropertyRedecl('AggregatesActive', False);
  AData.AddPropertyRedecl('AutoCalcFields', False);
  AData.AddPropertyRedecl('CommandText', False);
  AData.AddPropertyRedecl('ConnectionBroker', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DataSetField', False);
  AData.AddPropertyRedecl('DisableStringTrim', False);
  AData.AddPropertyRedecl('FileName', False);
  AData.AddPropertyRedecl('Filter', False);
  AData.AddPropertyRedecl('Filtered', False);
  AData.AddPropertyRedecl('FilterOptions', False);
  AData.AddPropertyRedecl('FieldDefs', False);
  AData.AddPropertyRedecl('IndexDefs', False);
  AData.AddPropertyRedecl('IndexFieldNames', False);
  AData.AddPropertyRedecl('IndexName', False);
  AData.AddPropertyRedecl('FetchOnDemand', False);
  AData.AddPropertyRedecl('MasterFields', False);
  AData.AddPropertyRedecl('MasterSource', False);
  AData.AddPropertyRedecl('ObjectView', False);
  AData.AddPropertyRedecl('PacketRecords', False);
  AData.AddPropertyRedecl('Params', False);
  AData.AddPropertyRedecl('ProviderName', False);
  AData.AddPropertyRedecl('ReadOnly', False);
  AData.AddPropertyRedecl('RemoteServer', False);
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
  AData.AddPropertyRedecl('BeforeRefresh', False);
  AData.AddPropertyRedecl('AfterRefresh', False);
  AData.AddPropertyRedecl('OnCalcFields', False);
  AData.AddPropertyRedecl('OnDeleteError', False);
  AData.AddPropertyRedecl('OnEditError', False);
  AData.AddPropertyRedecl('OnFilterRecord', False);
  AData.AddPropertyRedecl('OnNewRecord', False);
  AData.AddPropertyRedecl('OnPostError', False);
  AData.AddPropertyRedecl('OnReconcileError', False);
  AData.AddPropertyRedecl('BeforeApplyUpdates', False);
  AData.AddPropertyRedecl('AfterApplyUpdates', False);
  AData.AddPropertyRedecl('BeforeGetRecords', False);
  AData.AddPropertyRedecl('AfterGetRecords', False);
  AData.AddPropertyRedecl('BeforeRowRequest', False);
  AData.AddPropertyRedecl('AfterRowRequest', False);
  AData.AddPropertyRedecl('BeforeExecute', False);
  AData.AddPropertyRedecl('AfterExecute', False);
  AData.AddPropertyRedecl('BeforeGetParams', False);
  AData.AddPropertyRedecl('AfterGetParams', False);
end;

class function TClientDataSet_sw.ToVar(
  const AValue: TClientDataSet): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TClientDataSet_sw.FromVar(
  const AValue: OleVariant): TClientDataSet;
begin
  Result := TClientDataSet(ConvFromVar(AValue, TClientDataSet));
end;

class function TClientDataSet_sw.ClassToVar(
  AClass: TClientDataSet_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TClientDataSet_sw.ClassFromVar(
  const AClass: OleVariant): TClientDataSet_sc;
begin
  Result := TClientDataSet_sc(ConvClsFromVar(AClass, TClientDataSet));
end;

{ TClientBlobStream_sw }

function TClientBlobStream_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Field: TBlobField; Mode: TBlobStreamMo...

  Result := TClientBlobStream_sw.ToVar(TClientBlobStream_sc(AObj).Create(
    TBlobField_sw.FromVar(AArgs[0]), TBlobStreamMode_sw.FromVar(AArgs[1])));
end;

function TClientBlobStream_Truncate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Truncate;

  TClientBlobStream(AObj).Truncate();
end;

class function TClientBlobStream_sw.GetTypeName: WideString;
begin
  Result := 'TClientBlobStream';
end;

class function TClientBlobStream_sw.GetWrappedClass: TClass;
begin
  Result := TClientBlobStream;
end;

class procedure TClientBlobStream_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Truncate', TClientBlobStream_Truncate_si, 0, False);

  { Class members }

  AData.AddConstructor('Create', TClientBlobStream_Create_si, 2, False);
end;

class function TClientBlobStream_sw.ToVar(
  const AValue: TClientBlobStream): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TClientBlobStream_sw.FromVar(
  const AValue: OleVariant): TClientBlobStream;
begin
  Result := TClientBlobStream(ConvFromVar(AValue, TClientBlobStream));
end;

class function TClientBlobStream_sw.ClassToVar(
  AClass: TClientBlobStream_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TClientBlobStream_sw.ClassFromVar(
  const AClass: OleVariant): TClientBlobStream_sc;
begin
  Result := TClientBlobStream_sc(ConvClsFromVar(AClass, TClientBlobStream));
end;

{ DBClient_sw }

function DBClient_EDBClient_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EDBClient = class(EDatabaseError);

  Result := TLMDUnitWrapper.TypeToVar(EDBClient_sw);
end;

function DBClient_EReconcileError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EReconcileError = class(EDBClient);

  Result := TLMDUnitWrapper.TypeToVar(EReconcileError_sw);
end;

function DBClient_TGetUsernameEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetUsernameEvent = procedure (Sender: TObject; var ...

  Result := TLMDUnitWrapper.TypeToVar(TGetUsernameEvent_sw);
end;

function DBClient_TCustomRemoteServer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomRemoteServer = class(TCustomConnection);

  Result := TLMDUnitWrapper.TypeToVar(TCustomRemoteServer_sw);
end;

function DBClient_TConnectionBroker_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConnectionBroker = class(TCustomRemoteServer);

  Result := TLMDUnitWrapper.TypeToVar(TConnectionBroker_sw);
end;

function DBClient_TAggUpdateEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAggUpdateEvent = procedure (Agg: TAggregate) of obj...

  Result := TLMDUnitWrapper.TypeToVar(TAggUpdateEvent_sw);
end;

function DBClient_TAggregate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAggregate = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TAggregate_sw);
end;

function DBClient_TAggregates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAggregates = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(TAggregates_sw);
end;

function DBClient_TRecInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRecInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TRecInfo_sw);
end;

function DBClient_TCDSRecInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCDSRecInfo = TRecInfo;

  Result := TLMDUnitWrapper.TypeToVar(TCDSRecInfo_sw);
end;

function DBClient_TKeyBuffer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TKeyBuffer = record;

  Result := TLMDUnitWrapper.TypeToVar(TKeyBuffer_sw);
end;

function DBClient_TCDSKeyBuffer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCDSKeyBuffer = TKeyBuffer;

  Result := TLMDUnitWrapper.TypeToVar(TCDSKeyBuffer_sw);
end;

function DBClient_TDataPacketFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataPacketFormat = (dfBinary, dfXML, dfXMLUTF8);

  Result := TLMDUnitWrapper.TypeToVar(TDataPacketFormat_sw);
end;

function DBClient_TReconcileAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TReconcileAction = (raSkip, raAbort, raMerge, raCorr...

  Result := TLMDUnitWrapper.TypeToVar(TReconcileAction_sw);
end;

function DBClient_TReconcileErrorEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TReconcileErrorEvent = procedure (DataSet: TCustomCl...

  Result := TLMDUnitWrapper.TypeToVar(TReconcileErrorEvent_sw);
end;

function DBClient_TRemoteEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRemoteEvent = procedure (Sender: TObject; var Owner...

  Result := TLMDUnitWrapper.TypeToVar(TRemoteEvent_sw);
end;

function DBClient_TReconcileInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TReconcileInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TReconcileInfo_sw);
end;

function DBClient_TDataSetOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSetOption = (doDisableInserts, doDisableDeletes...

  Result := TLMDUnitWrapper.TypeToVar(TDataSetOption_sw);
end;

function DBClient_TDataSetOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSetOptions = set of TDataSetOption;

  Result := TLMDUnitWrapper.TypeToVar(TDataSetOptions_sw);
end;

function DBClient_TFetchOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFetchOption = (foRecord, foBlobs, foDetails);

  Result := TLMDUnitWrapper.TypeToVar(TFetchOption_sw);
end;

function DBClient_TFetchOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFetchOptions = set of TFetchOption;

  Result := TLMDUnitWrapper.TypeToVar(TFetchOptions_sw);
end;

function DBClient_TCustomClientDataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomClientDataSet = class(TDataSet);

  Result := TLMDUnitWrapper.TypeToVar(TCustomClientDataSet_sw);
end;

function DBClient_TClientDataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TClientDataSet = class(TCustomClientDataSet);

  Result := TLMDUnitWrapper.TypeToVar(TClientDataSet_sw);
end;

function DBClient_TClientBlobStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TClientBlobStream = class(TMemoryStream);

  Result := TLMDUnitWrapper.TypeToVar(TClientBlobStream_sw);
end;

function DBClient_AllParamTypes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const AllParamTypes = <value>;

  Result := LMDSetToVar(SizeOf(AllParamTypes), AllParamTypes);
end;

function DBClient_PackageParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function PackageParams(Params: TParams; Types: TParamType...

  case AArgsSize of
    1:
    begin
      Result := DBClient.PackageParams(TParams_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      Result := DBClient.PackageParams(TParams_sw.FromVar(AArgs[0]), 
        TParamTypes_sw.FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('PackageParams');
  end;
end;

function DBClient_UnpackParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnpackParams(const Source: OleVariant; Dest: TP...

  DBClient.UnpackParams(OleVariant(FindVarData(AArgs[0])^), TParams_sw.FromVar(
    AArgs[1]));
end;

function DBClient_AllRecords_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const AllRecords = <value>;

  Result := AllRecords;
end;

class function DBClient_sw.GetUnitName: WideString;
begin
  Result := 'DBClient';
end;

class procedure DBClient_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(EDBClient_sw, DBClient_EDBClient_si);
  AData.AddType(EReconcileError_sw, DBClient_EReconcileError_si);
  AData.AddType(TGetUsernameEvent_sw, DBClient_TGetUsernameEvent_si);
  AData.AddType(TCustomRemoteServer_sw, DBClient_TCustomRemoteServer_si);
  AData.AddType(TConnectionBroker_sw, DBClient_TConnectionBroker_si);
  AData.AddType(TAggUpdateEvent_sw, DBClient_TAggUpdateEvent_si);
  AData.AddType(TAggregate_sw, DBClient_TAggregate_si);
  AData.AddType(TAggregates_sw, DBClient_TAggregates_si);
  AData.AddType(TRecInfo_sw, DBClient_TRecInfo_si);
  AData.AddType(TCDSRecInfo_sw, DBClient_TCDSRecInfo_si);
  AData.AddType(TKeyBuffer_sw, DBClient_TKeyBuffer_si);
  AData.AddType(TCDSKeyBuffer_sw, DBClient_TCDSKeyBuffer_si);
  AData.AddType(TDataPacketFormat_sw, DBClient_TDataPacketFormat_si);
  AData.AddType(TReconcileAction_sw, DBClient_TReconcileAction_si);
  AData.AddType(TReconcileErrorEvent_sw, DBClient_TReconcileErrorEvent_si);
  AData.AddType(TRemoteEvent_sw, DBClient_TRemoteEvent_si);
  AData.AddType(TReconcileInfo_sw, DBClient_TReconcileInfo_si);
  AData.AddType(TDataSetOption_sw, DBClient_TDataSetOption_si);
  AData.AddType(TDataSetOptions_sw, DBClient_TDataSetOptions_si);
  AData.AddType(TFetchOption_sw, DBClient_TFetchOption_si);
  AData.AddType(TFetchOptions_sw, DBClient_TFetchOptions_si);
  AData.AddType(TCustomClientDataSet_sw, DBClient_TCustomClientDataSet_si);
  AData.AddType(TClientDataSet_sw, DBClient_TClientDataSet_si);
  AData.AddType(TClientBlobStream_sw, DBClient_TClientBlobStream_si);
  AData.AddConstant('AllParamTypes', DBClient_AllParamTypes_si, nil, varInteger);
  AData.AddFunction('PackageParams', DBClient_PackageParams_si, OleVariant_sw, 1, True);
  AData.AddProcedure('UnpackParams', DBClient_UnpackParams_si, 2, False);
  AData.AddConstant('AllRecords', DBClient_AllRecords_si, nil, VarType(DBClient.AllRecords));
end;

class function DBClient_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(DBClient_sw);
end;

initialization
  RegisterUnitWrapper(DBClient_sw);
  RegisterClassWrapper(EDBClient_sw);
  RegisterClassWrapper(EReconcileError_sw);
  RegisterClassWrapper(TCustomRemoteServer_sw);
  RegisterClassWrapper(TConnectionBroker_sw);
  RegisterClassWrapper(TAggregate_sw);
  RegisterClassWrapper(TAggregates_sw);
  RegisterClassWrapper(TCustomClientDataSet_sw);
  RegisterClassWrapper(TClientDataSet_sw);
  RegisterClassWrapper(TClientBlobStream_sw);
  RegisterEventWrapper(TypeInfo(TGetUsernameEvent), TGetUsernameEvent_sw);
  RegisterEventWrapper(TypeInfo(TAggUpdateEvent), TAggUpdateEvent_sw);
  RegisterEventWrapper(TypeInfo(TReconcileErrorEvent), TReconcileErrorEvent_sw);
  RegisterEventWrapper(TypeInfo(TRemoteEvent), TRemoteEvent_sw);

end.
