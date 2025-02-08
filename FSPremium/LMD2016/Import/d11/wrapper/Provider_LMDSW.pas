unit Provider_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Provider' unit.
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
  Windows, SysUtils, Variants, Classes, DBClient, DB, WideStrings, Provider,
  Windows_LMDSW, SysUtils_LMDSW, Variants_LMDSW, Classes_LMDSW, DBClient_LMDSW,
  DB_LMDSW, WideStrings_LMDSW;


{ Type wrappers }

type
  EDSWriter_sw = class;
  TCustomPacketWriter_sw = class;
  TDataPacketWriter_sw = class;
  TPacketDataSet_sw = class;
  TCustomProvider_sw = class;
  TBaseProvider_sw = class;
  TDataSetProvider_sw = class;
  TProvider_sw = class;
  TUpdateTree_sw = class;
  TCustomResolver_sw = class;
  TDataSetResolver_sw = class;
  TSQLResolver_sw = class;
  TLocalAppServer_sw = class;

  EDSWriter_sc = class of EDSWriter;
  EDSWriter_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EDSWriter): OleVariant;
    class function FromVar(const AValue: OleVariant): EDSWriter;
    class function ClassToVar(AClass: EDSWriter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EDSWriter_sc;
  end;

  TCustomPacketWriter_sc = class of TCustomPacketWriter;
  TCustomPacketWriter_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomPacketWriter): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomPacketWriter;
    class function ClassToVar(AClass: TCustomPacketWriter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomPacketWriter_sc;
  end;

  TGetRecordOption_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TGetRecordOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetRecordOption;
  end;

  TGetRecordOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TGetRecordOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetRecordOptions;
  end;

  TDataRequestEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    function Handler(Sender: TObject; Input: OleVariant): OleVariant;
  end;

  TDataRequestEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDataRequestEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataRequestEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDataRequestEvent;
  end;

  TProviderOption_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TProviderOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TProviderOption;
  end;

  TProviderOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TProviderOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TProviderOptions;
  end;

  TPutFieldInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TPutFieldInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPutFieldInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TPutFieldInfo;
  end;

  TGetParamsEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DataSet: TDataSet; Params: TList);
  end;

  TGetParamsEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetParamsEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetParamsEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetParamsEvent;
  end;

  TOnValidate_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(const Delta: OleVariant);
  end;

  TOnValidate_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TOnValidate): OleVariant;
    class function FromVar(const AValue: OleVariant): TOnValidate;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TOnValidate;
  end;

  TDataPacketWriter_sc = class of TDataPacketWriter;
  TDataPacketWriter_sw = class(TCustomPacketWriter_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDataPacketWriter): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataPacketWriter;
    class function ClassToVar(AClass: TDataPacketWriter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDataPacketWriter_sc;
  end;

  TPacketDataSet_sc = class of TPacketDataSet;
  TPacketDataSet_sw = class(TCustomClientDataSet_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPacketDataSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TPacketDataSet;
    class function ClassToVar(AClass: TPacketDataSet_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPacketDataSet_sc;
  end;

  TCustomProvider_sc = class of TCustomProvider;
  TCustomProvider_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomProvider): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomProvider;
    class function ClassToVar(AClass: TCustomProvider_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomProvider_sc;
  end;

  TResolverResponse_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TResolverResponse): OleVariant;
    class function FromVar(const AValue: OleVariant): TResolverResponse;
  end;

  TProviderDataEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; DataSet: TCustomClientDataSet);
  end;

  TProviderDataEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TProviderDataEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TProviderDataEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TProviderDataEvent;
  end;

  TBeforeUpdateRecordEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
  end;

  TBeforeUpdateRecordEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TBeforeUpdateRecordEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TBeforeUpdateRecordEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TBeforeUpdateRecordEvent;
  end;

  TAfterUpdateRecordEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind);
  end;

  TAfterUpdateRecordEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TAfterUpdateRecordEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TAfterUpdateRecordEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TAfterUpdateRecordEvent;
  end;

  TResolverErrorEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; DataSet: TCustomClientDataSet;
      E: EUpdateError; UpdateKind: TUpdateKind; var Response: TResolverResponse);
  end;

  TResolverErrorEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TResolverErrorEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TResolverErrorEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TResolverErrorEvent;
  end;

  TBeforeCommitEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; DeltaDS: TCustomClientDataSet;
      ErrorCount: integer; MaxErrors: integer; const ResultVar: OleVariant);
  end;

  TBeforeCommitEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TBeforeCommitEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TBeforeCommitEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TBeforeCommitEvent;
  end;

  TBaseProvider_sc = class of TBaseProvider;
  TBaseProvider_sw = class(TCustomProvider_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBaseProvider): OleVariant;
    class function FromVar(const AValue: OleVariant): TBaseProvider;
    class function ClassToVar(AClass: TBaseProvider_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBaseProvider_sc;
  end;

  TGetTableNameEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
  end;

  TGetTableNameEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetTableNameEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetTableNameEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetTableNameEvent;
  end;

  TGetDSProps_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
  end;

  TGetDSProps_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetDSProps): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetDSProps;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetDSProps;
  end;

  TDataSetProvider_sc = class of TDataSetProvider;
  TDataSetProvider_sw = class(TBaseProvider_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDataSetProvider): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSetProvider;
    class function ClassToVar(AClass: TDataSetProvider_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDataSetProvider_sc;
  end;

  TProvider_sc = class of TProvider;
  TProvider_sw = class(TDataSetProvider_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TProvider): OleVariant;
    class function FromVar(const AValue: OleVariant): TProvider;
    class function ClassToVar(AClass: TProvider_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TProvider_sc;
  end;

  TUpdateTree_sc = class of TUpdateTree;
  TUpdateTree_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TUpdateTree): OleVariant;
    class function FromVar(const AValue: OleVariant): TUpdateTree;
    class function ClassToVar(AClass: TUpdateTree_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TUpdateTree_sc;
  end;

  TCustomResolver_sc = class of TCustomResolver;
  TCustomResolver_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomResolver): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomResolver;
    class function ClassToVar(AClass: TCustomResolver_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomResolver_sc;
  end;

  TDataSetResolver_sc = class of TDataSetResolver;
  TDataSetResolver_sw = class(TCustomResolver_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDataSetResolver): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSetResolver;
    class function ClassToVar(AClass: TDataSetResolver_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDataSetResolver_sc;
  end;

  TSQLResolver_sc = class of TSQLResolver;
  TSQLResolver_sw = class(TCustomResolver_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSQLResolver): OleVariant;
    class function FromVar(const AValue: OleVariant): TSQLResolver;
    class function ClassToVar(AClass: TSQLResolver_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSQLResolver_sc;
  end;

  TLocalAppServer_sc = class of TLocalAppServer;
  TLocalAppServer_sw = class(TInterfacedObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TLocalAppServer): OleVariant;
    class function FromVar(const AValue: OleVariant): TLocalAppServer;
    class function ClassToVar(AClass: TLocalAppServer_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TLocalAppServer_sc;
  end;


{ Unit wrapper }

type
  Provider_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TPacketDataSet_sacc = class(TPacketDataSet);
  TCustomProvider_sacc = class(TCustomProvider);
  TBaseProvider_sacc = class(TBaseProvider);
  TDataSetProvider_sacc = class(TDataSetProvider);
  TUpdateTree_sacc = class(TUpdateTree);
  TDataSetResolver_sacc = class(TDataSetResolver);
  TSQLResolver_sacc = class(TSQLResolver);

{ EDSWriter_sw }

function EDSWriter_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ErrMsg: string; Status: Integer);

  Result := EDSWriter_sw.ToVar(EDSWriter_sc(AObj).Create(string(AArgs[0]), 
    Integer(AArgs[1])));
end;

function EDSWriter_ErrorCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ErrorCode: Integer read <getter>;

  Result := EDSWriter(AObj).ErrorCode;
end;

class function EDSWriter_sw.GetTypeName: WideString;
begin
  Result := 'EDSWriter';
end;

class function EDSWriter_sw.GetWrappedClass: TClass;
begin
  Result := EDSWriter;
end;

class procedure EDSWriter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ErrorCode', EDSWriter_ErrorCode_si, Integer_sw, True, False, 0, False);

  { Class members }

  AData.AddConstructor('Create', EDSWriter_Create_si, 2, False);
end;

class function EDSWriter_sw.ToVar(const AValue: EDSWriter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EDSWriter_sw.FromVar(const AValue: OleVariant): EDSWriter;
begin
  Result := EDSWriter(ConvFromVar(AValue, EDSWriter));
end;

class function EDSWriter_sw.ClassToVar(AClass: EDSWriter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EDSWriter_sw.ClassFromVar(
  const AClass: OleVariant): EDSWriter_sc;
begin
  Result := EDSWriter_sc(ConvClsFromVar(AClass, EDSWriter));
end;

{ TCustomPacketWriter_sw }

function TCustomPacketWriter_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TCustomPacketWriter_sw.ToVar(TCustomPacketWriter_sc(AObj).Create());
end;

class function TCustomPacketWriter_sw.GetTypeName: WideString;
begin
  Result := 'TCustomPacketWriter';
end;

class function TCustomPacketWriter_sw.GetWrappedClass: TClass;
begin
  Result := TCustomPacketWriter;
end;

class procedure TCustomPacketWriter_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TCustomPacketWriter_Create_si, 0, False);
end;

class function TCustomPacketWriter_sw.ToVar(
  const AValue: TCustomPacketWriter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomPacketWriter_sw.FromVar(
  const AValue: OleVariant): TCustomPacketWriter;
begin
  Result := TCustomPacketWriter(ConvFromVar(AValue, TCustomPacketWriter));
end;

class function TCustomPacketWriter_sw.ClassToVar(
  AClass: TCustomPacketWriter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomPacketWriter_sw.ClassFromVar(
  const AClass: OleVariant): TCustomPacketWriter_sc;
begin
  Result := TCustomPacketWriter_sc(ConvClsFromVar(AClass, TCustomPacketWriter));
end;

{ TGetRecordOption_sw }

class function TGetRecordOption_sw.GetTypeName: WideString;
begin
  Result := 'TGetRecordOption';
end;

class function TGetRecordOption_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TGetRecordOption);
end;

class function TGetRecordOption_sw.ToVar(
  const AValue: TGetRecordOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TGetRecordOption_sw.FromVar(
  const AValue: OleVariant): TGetRecordOption;
begin
  Result := TGetRecordOption(Integer(AValue));
end;

{ TGetRecordOptions_sw }

class function TGetRecordOptions_sw.GetTypeName: WideString;
begin
  Result := 'TGetRecordOptions';
end;

class function TGetRecordOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TGetRecordOptions);
end;

class function TGetRecordOptions_sw.ToVar(
  const AValue: TGetRecordOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TGetRecordOptions_sw.FromVar(
  const AValue: OleVariant): TGetRecordOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TDataRequestEvent_sh }

function TDataRequestEvent_sh.GetHandler: TMethod;
var
  hdr: TDataRequestEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

function TDataRequestEvent_sh.Handler(Sender: TObject;
  Input: OleVariant): OleVariant;
var
  args: array[0..1] of OleVariant;
begin
  // function (Sender: TObject; Input: OleVariant): OleVariant...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := Input;
  Result := OleVariant(Self.Owner.RunProc(Self.ProcName, args));
end;

{ TDataRequestEvent_sw }

class function TDataRequestEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDataRequestEvent';
end;

class function TDataRequestEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDataRequestEvent_sh;
end;

class function TDataRequestEvent_sw.ToVar(
  const AValue: TDataRequestEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDataRequestEvent_sw.FromVar(
  const AValue: OleVariant): TDataRequestEvent;
begin
  Result := TDataRequestEvent(ConvFromVar(AValue));
end;

class function TDataRequestEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TDataRequestEvent;
var
  hdlr: TDataRequestEvent_sh;
begin
  hdlr   := TDataRequestEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDataRequestEvent_sw));
  Result := hdlr.Handler;
end;

{ TProviderOption_sw }

class function TProviderOption_sw.GetTypeName: WideString;
begin
  Result := 'TProviderOption';
end;

class function TProviderOption_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TProviderOption);
end;

class function TProviderOption_sw.ToVar(
  const AValue: TProviderOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TProviderOption_sw.FromVar(
  const AValue: OleVariant): TProviderOption;
begin
  Result := TProviderOption(Integer(AValue));
end;

{ TProviderOptions_sw }

class function TProviderOptions_sw.GetTypeName: WideString;
begin
  Result := 'TProviderOptions';
end;

class function TProviderOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TProviderOptions);
end;

class function TProviderOptions_sw.ToVar(
  const AValue: TProviderOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TProviderOptions_sw.FromVar(
  const AValue: OleVariant): TProviderOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TPutFieldInfo_sw }

function TPutFieldInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TPutFieldInfo_sw.ToVar(TPutFieldInfo(AObj));
end;

function TPutFieldInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TPutFieldInfo_sw.Create as IDispatch;
end;

function TPutFieldInfo_FieldNo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FieldNo: Integer;

  if IsGet then
    Result := TPutFieldInfo_sw(AObj).FValue.FieldNo
  else
    TPutFieldInfo_sw(AObj).FValue.FieldNo := Integer(AArgs[0]);
end;

function TPutFieldInfo_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Field: TField;

  if IsGet then
    Result := TField_sw.ToVar(TPutFieldInfo_sw(AObj).FValue.Field)
  else
    TPutFieldInfo_sw(AObj).FValue.Field := TField_sw.FromVar(AArgs[0]);
end;

function TPutFieldInfo_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DataSet: TDataSet;

  if IsGet then
    Result := TDataSet_sw.ToVar(TPutFieldInfo_sw(AObj).FValue.DataSet)
  else
    TPutFieldInfo_sw(AObj).FValue.DataSet := TDataSet_sw.FromVar(AArgs[0]);
end;

function TPutFieldInfo_Size_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Size: Integer;

  if IsGet then
    Result := TPutFieldInfo_sw(AObj).FValue.Size
  else
    TPutFieldInfo_sw(AObj).FValue.Size := Integer(AArgs[0]);
end;

function TPutFieldInfo_IsDetail_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var IsDetail: Boolean;

  if IsGet then
    Result := TPutFieldInfo_sw(AObj).FValue.IsDetail
  else
    TPutFieldInfo_sw(AObj).FValue.IsDetail := Boolean(AArgs[0]);
end;

function TPutFieldInfo_Opened_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Opened: Boolean;

  if IsGet then
    Result := TPutFieldInfo_sw(AObj).FValue.Opened
  else
    TPutFieldInfo_sw(AObj).FValue.Opened := Boolean(AArgs[0]);
end;

function TPutFieldInfo_LocalFieldIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LocalFieldIndex: Integer;

  if IsGet then
    Result := TPutFieldInfo_sw(AObj).FValue.LocalFieldIndex
  else
    TPutFieldInfo_sw(AObj).FValue.LocalFieldIndex := Integer(AArgs[0]);
end;

class function TPutFieldInfo_sw.GetTypeName: WideString;
begin
  Result := 'TPutFieldInfo';
end;

function TPutFieldInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPutFieldInfo_sw.Create;
  TPutFieldInfo_sw(Result).FValue := FValue;
end;

class procedure TPutFieldInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TPutFieldInfo_Copy_si, TPutFieldInfo_sw, 0);
  AData.AddField('FieldNo', TPutFieldInfo_FieldNo_si, Integer_sw);
  AData.AddField('Field', TPutFieldInfo_Field_si, TField_sw);
  AData.AddField('DataSet', TPutFieldInfo_DataSet_si, TDataSet_sw);
  AData.AddField('Size', TPutFieldInfo_Size_si, Integer_sw);
  AData.AddField('IsDetail', TPutFieldInfo_IsDetail_si, Boolean_sw);
  AData.AddField('Opened', TPutFieldInfo_Opened_si, Boolean_sw);
  AData.AddField('LocalFieldIndex', TPutFieldInfo_LocalFieldIndex_si, Integer_sw);

  { Class members }

  AData.AddConstructor('Create', TPutFieldInfo_Create_si, 0);
end;

class function TPutFieldInfo_sw.ToVar(const AValue: TPutFieldInfo): OleVariant;
var
  wrpr: TPutFieldInfo_sw;
begin
  wrpr        := TPutFieldInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TPutFieldInfo_sw.FromVar(
  const AValue: OleVariant): TPutFieldInfo;
begin
  Result := TPutFieldInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TGetParamsEvent_sh }

function TGetParamsEvent_sh.GetHandler: TMethod;
var
  hdr: TGetParamsEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetParamsEvent_sh.Handler(DataSet: TDataSet; Params: TList);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (DataSet: TDataSet; Params: TList) of object

  args[0] := TDataSet_sw.ToVar(DataSet);
  args[1] := TList_sw.ToVar(Params);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TGetParamsEvent_sw }

class function TGetParamsEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetParamsEvent';
end;

class function TGetParamsEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetParamsEvent_sh;
end;

class function TGetParamsEvent_sw.ToVar(
  const AValue: TGetParamsEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetParamsEvent_sw.FromVar(
  const AValue: OleVariant): TGetParamsEvent;
begin
  Result := TGetParamsEvent(ConvFromVar(AValue));
end;

class function TGetParamsEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetParamsEvent;
var
  hdlr: TGetParamsEvent_sh;
begin
  hdlr   := TGetParamsEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetParamsEvent_sw));
  Result := hdlr.Handler;
end;

{ TOnValidate_sh }

function TOnValidate_sh.GetHandler: TMethod;
var
  hdr: TOnValidate;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TOnValidate_sh.Handler(const Delta: OleVariant);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (const Delta: OleVariant) of object

  args[0] := Delta;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TOnValidate_sw }

class function TOnValidate_sw.GetTypeName: WideString;
begin
  Result := 'TOnValidate';
end;

class function TOnValidate_sw.GetScriptHandlerClass: TClass;
begin
  Result := TOnValidate_sh;
end;

class function TOnValidate_sw.ToVar(const AValue: TOnValidate): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TOnValidate_sw.FromVar(const AValue: OleVariant): TOnValidate;
begin
  Result := TOnValidate(ConvFromVar(AValue));
end;

class function TOnValidate_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TOnValidate;
var
  hdlr: TOnValidate_sh;
begin
  hdlr   := TOnValidate_sh(AScriptControl.GetEventHandler(AProcName, 
    TOnValidate_sw));
  Result := hdlr.Handler;
end;

{ TDataPacketWriter_sw }

function TDataPacketWriter_GetDataPacket_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
  v_2: OleVariant;
begin
  // procedure GetDataPacket(DataSet: TDataSet; var RecsOut: I...

  v_1 := Integer(AArgs[1]);
  TDataPacketWriter(AObj).GetDataPacket(TDataSet_sw.FromVar(AArgs[0]), v_1, 
    v_2);
  AssignRefParam(AArgs[1], v_1);
  AssignRefParam(AArgs[2], v_2);
end;

function TDataPacketWriter_Reset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Reset;

  TDataPacketWriter(AObj).Reset();
end;

function TDataPacketWriter_Constraints_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Constraints: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDataPacketWriter(AObj).Constraints
  else
    TDataPacketWriter(AObj).Constraints := Boolean(AArgs[0]);
end;

function TDataPacketWriter_PacketOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PacketOptions: TGetRecordOptions read <getter> w...

  if IsGet then
    Result := TGetRecordOptions_sw.ToVar(TDataPacketWriter(AObj).PacketOptions)
  else
    TDataPacketWriter(AObj).PacketOptions := TGetRecordOptions_sw.FromVar(
      AArgs[0]);
end;

function TDataPacketWriter_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TProviderOptions read <getter> write <s...

  if IsGet then
    Result := TProviderOptions_sw.ToVar(TDataPacketWriter(AObj).Options)
  else
    TDataPacketWriter(AObj).Options := TProviderOptions_sw.FromVar(AArgs[0]);
end;

function TDataPacketWriter_OnGetParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetParams: TGetParamsEvent read <getter> write...

  if IsGet then
    Result := TGetParamsEvent_sw.ToVar(TDataPacketWriter(AObj).OnGetParams)
  else
    TDataPacketWriter(AObj).OnGetParams := TGetParamsEvent_sw.FromVar(AArgs[0]);
end;

class function TDataPacketWriter_sw.GetTypeName: WideString;
begin
  Result := 'TDataPacketWriter';
end;

class function TDataPacketWriter_sw.GetWrappedClass: TClass;
begin
  Result := TDataPacketWriter;
end;

class procedure TDataPacketWriter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('GetDataPacket', TDataPacketWriter_GetDataPacket_si, 3, False);
  AData.AddProcedure('Reset', TDataPacketWriter_Reset_si, 0, False);
  AData.AddProperty('Constraints', TDataPacketWriter_Constraints_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('PacketOptions', TDataPacketWriter_PacketOptions_si, TGetRecordOptions_sw, True, True, 0, False);
  AData.AddProperty('Options', TDataPacketWriter_Options_si, TProviderOptions_sw, True, True, 0, False);
  AData.AddProperty('OnGetParams', TDataPacketWriter_OnGetParams_si, TGetParamsEvent_sw, True, True, 0, False);
end;

class function TDataPacketWriter_sw.ToVar(
  const AValue: TDataPacketWriter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDataPacketWriter_sw.FromVar(
  const AValue: OleVariant): TDataPacketWriter;
begin
  Result := TDataPacketWriter(ConvFromVar(AValue, TDataPacketWriter));
end;

class function TDataPacketWriter_sw.ClassToVar(
  AClass: TDataPacketWriter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDataPacketWriter_sw.ClassFromVar(
  const AClass: OleVariant): TDataPacketWriter_sc;
begin
  Result := TDataPacketWriter_sc(ConvClsFromVar(AClass, TDataPacketWriter));
end;

{ TPacketDataSet_sw }

function TPacketDataSet_WritingCurValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property WritingCurValues: Boolean read <getter...

  if IsGet then
    Result := TPacketDataSet_sacc(TPacketDataSet(AObj)).WritingCurValues
  else
    TPacketDataSet_sacc(TPacketDataSet(AObj)).WritingCurValues := Boolean(
      AArgs[0]);
end;

function TPacketDataSet_AssignCurValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AssignCurValues(Source: TDataSet);

  TPacketDataSet(AObj).AssignCurValues(TDataSet_sw.FromVar(AArgs[0]));
end;

function TPacketDataSet_CreateFromDelta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CreateFromDelta(Source: TPacketDataSet);

  TPacketDataSet(AObj).CreateFromDelta(TPacketDataSet_sw.FromVar(AArgs[0]));
end;

function TPacketDataSet_HasCurValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HasCurValues: Boolean;

  Result := TPacketDataSet(AObj).HasCurValues();
end;

function TPacketDataSet_HasMergeConflicts_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HasMergeConflicts: Boolean;

  Result := TPacketDataSet(AObj).HasMergeConflicts();
end;

function TPacketDataSet_InitAltRecBuffers_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InitAltRecBuffers(CheckModified: Boolean);

  TPacketDataSet(AObj).InitAltRecBuffers(Boolean(AArgs[0]));
end;

function TPacketDataSet_UpdateKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UpdateKind: TUpdateKind;

  Result := TUpdateKind_sw.ToVar(TPacketDataSet(AObj).UpdateKind());
end;

function TPacketDataSet_NewValuesModified_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NewValuesModified: Boolean read <getter>;

  Result := TPacketDataSet(AObj).NewValuesModified;
end;

function TPacketDataSet_StreamMetaData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StreamMetaData: Boolean read <getter> write <set...

  if IsGet then
    Result := TPacketDataSet(AObj).StreamMetaData
  else
    TPacketDataSet(AObj).StreamMetaData := Boolean(AArgs[0]);
end;

function TPacketDataSet_UseCurValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UseCurValues: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TPacketDataSet(AObj).UseCurValues
  else
    TPacketDataSet(AObj).UseCurValues := Boolean(AArgs[0]);
end;

class function TPacketDataSet_sw.GetTypeName: WideString;
begin
  Result := 'TPacketDataSet';
end;

class function TPacketDataSet_sw.GetWrappedClass: TClass;
begin
  Result := TPacketDataSet;
end;

class procedure TPacketDataSet_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('WritingCurValues', TPacketDataSet_WritingCurValues_si, Boolean_sw, True, True, 0, True);
  AData.AddProcedure('AssignCurValues', TPacketDataSet_AssignCurValues_si, 1, False);
  AData.AddProcedure('CreateFromDelta', TPacketDataSet_CreateFromDelta_si, 1, False);
  AData.AddFunction('HasCurValues', TPacketDataSet_HasCurValues_si, Boolean_sw, 0, False);
  AData.AddFunction('HasMergeConflicts', TPacketDataSet_HasMergeConflicts_si, Boolean_sw, 0, False);
  AData.AddProcedure('InitAltRecBuffers', TPacketDataSet_InitAltRecBuffers_si, 1, False);
  AData.AddFunction('UpdateKind', TPacketDataSet_UpdateKind_si, TUpdateKind_sw, 0, False);
  AData.AddProperty('NewValuesModified', TPacketDataSet_NewValuesModified_si, Boolean_sw, True, False, 0, False);
  AData.AddProperty('StreamMetaData', TPacketDataSet_StreamMetaData_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('UseCurValues', TPacketDataSet_UseCurValues_si, Boolean_sw, True, True, 0, False);
end;

class function TPacketDataSet_sw.ToVar(
  const AValue: TPacketDataSet): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPacketDataSet_sw.FromVar(
  const AValue: OleVariant): TPacketDataSet;
begin
  Result := TPacketDataSet(ConvFromVar(AValue, TPacketDataSet));
end;

class function TPacketDataSet_sw.ClassToVar(
  AClass: TPacketDataSet_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPacketDataSet_sw.ClassFromVar(
  const AClass: OleVariant): TPacketDataSet_sc;
begin
  Result := TPacketDataSet_sc(ConvClsFromVar(AClass, TPacketDataSet));
end;

{ TCustomProvider_sw }

function TCustomProvider_OnDataRequest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDataRequest: TDataRequestEvent read ...

  if IsGet then
    Result := TDataRequestEvent_sw.ToVar(TCustomProvider_sacc(TCustomProvider(
      AObj)).OnDataRequest)
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).OnDataRequest := 
      TDataRequestEvent_sw.FromVar(AArgs[0]);
end;

function TCustomProvider_OnValidate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnValidate: TOnValidate read <getter> ...

  if IsGet then
    Result := TOnValidate_sw.ToVar(TCustomProvider_sacc(TCustomProvider(AObj)).
      OnValidate)
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).OnValidate := TOnValidate_sw.
      FromVar(AArgs[0]);
end;

function TCustomProvider_BeforeApplyUpdates_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BeforeApplyUpdates: TRemoteEvent read ...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomProvider_sacc(TCustomProvider(AObj)).
      BeforeApplyUpdates)
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).BeforeApplyUpdates := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomProvider_AfterApplyUpdates_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AfterApplyUpdates: TRemoteEvent read <...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomProvider_sacc(TCustomProvider(AObj)).
      AfterApplyUpdates)
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).AfterApplyUpdates := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomProvider_BeforeGetRecords_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BeforeGetRecords: TRemoteEvent read <g...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomProvider_sacc(TCustomProvider(AObj)).
      BeforeGetRecords)
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).BeforeGetRecords := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomProvider_AfterGetRecords_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AfterGetRecords: TRemoteEvent read <ge...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomProvider_sacc(TCustomProvider(AObj)).
      AfterGetRecords)
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).AfterGetRecords := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomProvider_BeforeRowRequest_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BeforeRowRequest: TRemoteEvent read <g...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomProvider_sacc(TCustomProvider(AObj)).
      BeforeRowRequest)
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).BeforeRowRequest := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomProvider_AfterRowRequest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AfterRowRequest: TRemoteEvent read <ge...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomProvider_sacc(TCustomProvider(AObj)).
      AfterRowRequest)
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).AfterRowRequest := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomProvider_BeforeExecute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BeforeExecute: TRemoteEvent read <gett...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomProvider_sacc(TCustomProvider(AObj)).
      BeforeExecute)
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).BeforeExecute := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomProvider_AfterExecute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AfterExecute: TRemoteEvent read <gette...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomProvider_sacc(TCustomProvider(AObj)).
      AfterExecute)
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).AfterExecute := TRemoteEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomProvider_BeforeGetParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BeforeGetParams: TRemoteEvent read <ge...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomProvider_sacc(TCustomProvider(AObj)).
      BeforeGetParams)
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).BeforeGetParams := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomProvider_AfterGetParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AfterGetParams: TRemoteEvent read <get...

  if IsGet then
    Result := TRemoteEvent_sw.ToVar(TCustomProvider_sacc(TCustomProvider(AObj)).
      AfterGetParams)
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).AfterGetParams := 
      TRemoteEvent_sw.FromVar(AArgs[0]);
end;

function TCustomProvider_ActiveUpdateException_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ActiveUpdateException: Exception read ...

  Result := Exception_sw.ToVar(TCustomProvider_sacc(TCustomProvider(AObj)).
    ActiveUpdateException);
end;

function TCustomProvider_OwnerData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OwnerData: OleVariant read <getter> wr...

  if IsGet then
    Result := TCustomProvider_sacc(TCustomProvider(AObj)).OwnerData
  else
    TCustomProvider_sacc(TCustomProvider(AObj)).OwnerData := OleVariant(
      AArgs[0]);
end;

function TCustomProvider_ApplyUpdates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // function ApplyUpdates(const Delta: OleVariant; MaxErrors:...

  Result := TCustomProvider(AObj).ApplyUpdates(OleVariant(AArgs[0]), Integer(
    AArgs[1]), v_1);
  AssignRefParam(AArgs[2], v_1);
end;

function TCustomProvider_GetRecords_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // function GetRecords(Count: Integer; out RecsOut: Integer;...

  Result := TCustomProvider(AObj).GetRecords(Integer(AArgs[0]), v_1, Integer(
    AArgs[2]));
  AssignRefParam(AArgs[1], v_1);
end;

function TCustomProvider_RowRequest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: OleVariant;
begin
  // function RowRequest(const Row: OleVariant; RequestType: I...

  v_1 := OleVariant(AArgs[2]);
  Result := TCustomProvider(AObj).RowRequest(OleVariant(AArgs[0]), Integer(
    AArgs[1]), v_1);
  AssignRefParam(AArgs[2], v_1);
end;

function TCustomProvider_Execute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure Execute(const CommandText: WideString; var Para...

  v_1 := OleVariant(AArgs[1]);
  v_2 := OleVariant(AArgs[2]);
  TCustomProvider(AObj).Execute(WideString(AArgs[0]), v_1, v_2);
  AssignRefParam(AArgs[1], v_1);
  AssignRefParam(AArgs[2], v_2);
end;

function TCustomProvider_GetParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: OleVariant;
begin
  // function GetParams(var OwnerData: OleVariant): OleVariant;

  v_1 := OleVariant(AArgs[0]);
  Result := TCustomProvider(AObj).GetParams(v_1);
  AssignRefParam(AArgs[0], v_1);
end;

function TCustomProvider_DataRequest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DataRequest(Input: OleVariant): OleVariant;

  Result := TCustomProvider(AObj).DataRequest(OleVariant(AArgs[0]));
end;

function TCustomProvider_Data_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Data: OleVariant read <getter>;

  Result := TCustomProvider(AObj).Data;
end;

function TCustomProvider_Exported_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Exported: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomProvider(AObj).Exported
  else
    TCustomProvider(AObj).Exported := Boolean(AArgs[0]);
end;

class function TCustomProvider_sw.GetTypeName: WideString;
begin
  Result := 'TCustomProvider';
end;

class function TCustomProvider_sw.GetWrappedClass: TClass;
begin
  Result := TCustomProvider;
end;

class procedure TCustomProvider_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('OnDataRequest', TCustomProvider_OnDataRequest_si, TDataRequestEvent_sw, True, True, 0, True);
  AData.AddProperty('OnValidate', TCustomProvider_OnValidate_si, TOnValidate_sw, True, True, 0, True);
  AData.AddProperty('BeforeApplyUpdates', TCustomProvider_BeforeApplyUpdates_si, TRemoteEvent_sw, True, True, 0, True);
  AData.AddProperty('AfterApplyUpdates', TCustomProvider_AfterApplyUpdates_si, TRemoteEvent_sw, True, True, 0, True);
  AData.AddProperty('BeforeGetRecords', TCustomProvider_BeforeGetRecords_si, TRemoteEvent_sw, True, True, 0, True);
  AData.AddProperty('AfterGetRecords', TCustomProvider_AfterGetRecords_si, TRemoteEvent_sw, True, True, 0, True);
  AData.AddProperty('BeforeRowRequest', TCustomProvider_BeforeRowRequest_si, TRemoteEvent_sw, True, True, 0, True);
  AData.AddProperty('AfterRowRequest', TCustomProvider_AfterRowRequest_si, TRemoteEvent_sw, True, True, 0, True);
  AData.AddProperty('BeforeExecute', TCustomProvider_BeforeExecute_si, TRemoteEvent_sw, True, True, 0, True);
  AData.AddProperty('AfterExecute', TCustomProvider_AfterExecute_si, TRemoteEvent_sw, True, True, 0, True);
  AData.AddProperty('BeforeGetParams', TCustomProvider_BeforeGetParams_si, TRemoteEvent_sw, True, True, 0, True);
  AData.AddProperty('AfterGetParams', TCustomProvider_AfterGetParams_si, TRemoteEvent_sw, True, True, 0, True);
  AData.AddProperty('ActiveUpdateException', TCustomProvider_ActiveUpdateException_si, Exception_sw, True, False, 0, True);
  AData.AddProperty('OwnerData', TCustomProvider_OwnerData_si, OleVariant_sw, True, True, 0, True);
  AData.AddFunction('ApplyUpdates', TCustomProvider_ApplyUpdates_si, OleVariant_sw, 3, False);
  AData.AddFunction('GetRecords', TCustomProvider_GetRecords_si, OleVariant_sw, 3, False);
  AData.AddFunction('RowRequest', TCustomProvider_RowRequest_si, OleVariant_sw, 3, False);
  AData.AddProcedure('Execute', TCustomProvider_Execute_si, 3, False);
  AData.AddFunction('GetParams', TCustomProvider_GetParams_si, OleVariant_sw, 1, False);
  AData.AddFunction('DataRequest', TCustomProvider_DataRequest_si, OleVariant_sw, 1, False);
  AData.AddProperty('Data', TCustomProvider_Data_si, OleVariant_sw, True, False, 0, False);
  AData.AddProperty('Exported', TCustomProvider_Exported_si, Boolean_sw, True, True, 0, False);
end;

class function TCustomProvider_sw.ToVar(
  const AValue: TCustomProvider): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomProvider_sw.FromVar(
  const AValue: OleVariant): TCustomProvider;
begin
  Result := TCustomProvider(ConvFromVar(AValue, TCustomProvider));
end;

class function TCustomProvider_sw.ClassToVar(
  AClass: TCustomProvider_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomProvider_sw.ClassFromVar(
  const AClass: OleVariant): TCustomProvider_sc;
begin
  Result := TCustomProvider_sc(ConvClsFromVar(AClass, TCustomProvider));
end;

{ TResolverResponse_sw }

class function TResolverResponse_sw.GetTypeName: WideString;
begin
  Result := 'TResolverResponse';
end;

class function TResolverResponse_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TResolverResponse);
end;

class function TResolverResponse_sw.ToVar(
  const AValue: TResolverResponse): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TResolverResponse_sw.FromVar(
  const AValue: OleVariant): TResolverResponse;
begin
  Result := TResolverResponse(Integer(AValue));
end;

{ TProviderDataEvent_sh }

function TProviderDataEvent_sh.GetHandler: TMethod;
var
  hdr: TProviderDataEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TProviderDataEvent_sh.Handler(Sender: TObject;
  DataSet: TCustomClientDataSet);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; DataSet: TCustomClientDataSet...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TCustomClientDataSet_sw.ToVar(DataSet);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TProviderDataEvent_sw }

class function TProviderDataEvent_sw.GetTypeName: WideString;
begin
  Result := 'TProviderDataEvent';
end;

class function TProviderDataEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TProviderDataEvent_sh;
end;

class function TProviderDataEvent_sw.ToVar(
  const AValue: TProviderDataEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TProviderDataEvent_sw.FromVar(
  const AValue: OleVariant): TProviderDataEvent;
begin
  Result := TProviderDataEvent(ConvFromVar(AValue));
end;

class function TProviderDataEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TProviderDataEvent;
var
  hdlr: TProviderDataEvent_sh;
begin
  hdlr   := TProviderDataEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TProviderDataEvent_sw));
  Result := hdlr.Handler;
end;

{ TBeforeUpdateRecordEvent_sh }

function TBeforeUpdateRecordEvent_sh.GetHandler: TMethod;
var
  hdr: TBeforeUpdateRecordEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TBeforeUpdateRecordEvent_sh.Handler(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);
var
  args: array[0..4] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; SourceDS: TDataSet; DeltaDS: ...

  v_1 := Applied;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TDataSet_sw.ToVar(SourceDS);
  args[2] := TCustomClientDataSet_sw.ToVar(DeltaDS);
  args[3] := TUpdateKind_sw.ToVar(UpdateKind);
  args[4] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Applied := Boolean(v_1);
end;

{ TBeforeUpdateRecordEvent_sw }

class function TBeforeUpdateRecordEvent_sw.GetTypeName: WideString;
begin
  Result := 'TBeforeUpdateRecordEvent';
end;

class function TBeforeUpdateRecordEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TBeforeUpdateRecordEvent_sh;
end;

class function TBeforeUpdateRecordEvent_sw.ToVar(
  const AValue: TBeforeUpdateRecordEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TBeforeUpdateRecordEvent_sw.FromVar(
  const AValue: OleVariant): TBeforeUpdateRecordEvent;
begin
  Result := TBeforeUpdateRecordEvent(ConvFromVar(AValue));
end;

class function TBeforeUpdateRecordEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TBeforeUpdateRecordEvent;
var
  hdlr: TBeforeUpdateRecordEvent_sh;
begin
  hdlr   := TBeforeUpdateRecordEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TBeforeUpdateRecordEvent_sw));
  Result := hdlr.Handler;
end;

{ TAfterUpdateRecordEvent_sh }

function TAfterUpdateRecordEvent_sh.GetHandler: TMethod;
var
  hdr: TAfterUpdateRecordEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TAfterUpdateRecordEvent_sh.Handler(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind);
var
  args: array[0..3] of OleVariant;
begin
  // procedure (Sender: TObject; SourceDS: TDataSet; DeltaDS: ...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TDataSet_sw.ToVar(SourceDS);
  args[2] := TCustomClientDataSet_sw.ToVar(DeltaDS);
  args[3] := TUpdateKind_sw.ToVar(UpdateKind);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TAfterUpdateRecordEvent_sw }

class function TAfterUpdateRecordEvent_sw.GetTypeName: WideString;
begin
  Result := 'TAfterUpdateRecordEvent';
end;

class function TAfterUpdateRecordEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TAfterUpdateRecordEvent_sh;
end;

class function TAfterUpdateRecordEvent_sw.ToVar(
  const AValue: TAfterUpdateRecordEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TAfterUpdateRecordEvent_sw.FromVar(
  const AValue: OleVariant): TAfterUpdateRecordEvent;
begin
  Result := TAfterUpdateRecordEvent(ConvFromVar(AValue));
end;

class function TAfterUpdateRecordEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TAfterUpdateRecordEvent;
var
  hdlr: TAfterUpdateRecordEvent_sh;
begin
  hdlr   := TAfterUpdateRecordEvent_sh(AScriptControl.GetEventHandler(AProcName,
    TAfterUpdateRecordEvent_sw));
  Result := hdlr.Handler;
end;

{ TResolverErrorEvent_sh }

function TResolverErrorEvent_sh.GetHandler: TMethod;
var
  hdr: TResolverErrorEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TResolverErrorEvent_sh.Handler(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
var
  args: array[0..4] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; DataSet: TCustomClientDataSet...

  v_1 := TResolverResponse_sw.ToVar(Response);
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TCustomClientDataSet_sw.ToVar(DataSet);
  args[2] := EUpdateError_sw.ToVar(E);
  args[3] := TUpdateKind_sw.ToVar(UpdateKind);
  args[4] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Response := TResolverResponse_sw.FromVar(v_1);
end;

{ TResolverErrorEvent_sw }

class function TResolverErrorEvent_sw.GetTypeName: WideString;
begin
  Result := 'TResolverErrorEvent';
end;

class function TResolverErrorEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TResolverErrorEvent_sh;
end;

class function TResolverErrorEvent_sw.ToVar(
  const AValue: TResolverErrorEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TResolverErrorEvent_sw.FromVar(
  const AValue: OleVariant): TResolverErrorEvent;
begin
  Result := TResolverErrorEvent(ConvFromVar(AValue));
end;

class function TResolverErrorEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TResolverErrorEvent;
var
  hdlr: TResolverErrorEvent_sh;
begin
  hdlr   := TResolverErrorEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TResolverErrorEvent_sw));
  Result := hdlr.Handler;
end;

{ TBeforeCommitEvent_sh }

function TBeforeCommitEvent_sh.GetHandler: TMethod;
var
  hdr: TBeforeCommitEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TBeforeCommitEvent_sh.Handler(Sender: TObject;
  DeltaDS: TCustomClientDataSet; ErrorCount: integer; MaxErrors: integer;
  const ResultVar: OleVariant);
var
  args: array[0..4] of OleVariant;
begin
  // procedure (Sender: TObject; DeltaDS: TCustomClientDataSet...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TCustomClientDataSet_sw.ToVar(DeltaDS);
  args[2] := ErrorCount;
  args[3] := MaxErrors;
  args[4] := ResultVar;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TBeforeCommitEvent_sw }

class function TBeforeCommitEvent_sw.GetTypeName: WideString;
begin
  Result := 'TBeforeCommitEvent';
end;

class function TBeforeCommitEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TBeforeCommitEvent_sh;
end;

class function TBeforeCommitEvent_sw.ToVar(
  const AValue: TBeforeCommitEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TBeforeCommitEvent_sw.FromVar(
  const AValue: OleVariant): TBeforeCommitEvent;
begin
  Result := TBeforeCommitEvent(ConvFromVar(AValue));
end;

class function TBeforeCommitEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TBeforeCommitEvent;
var
  hdlr: TBeforeCommitEvent_sh;
begin
  hdlr   := TBeforeCommitEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TBeforeCommitEvent_sw));
  Result := hdlr.Handler;
end;

{ TBaseProvider_sw }

function TBaseProvider_PacketDataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property PacketDataSet: TPacketDataSet read <ge...

  if IsGet then
    Result := TPacketDataSet_sw.ToVar(TBaseProvider_sacc(TBaseProvider(AObj)).
      PacketDataSet)
  else
    TBaseProvider_sacc(TBaseProvider(AObj)).PacketDataSet := TPacketDataSet_sw.
      FromVar(AArgs[0]);
end;

function TBaseProvider_Resolver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Resolver: TCustomResolver read <getter>;

  Result := TCustomResolver_sw.ToVar(TBaseProvider(AObj).Resolver);
end;

function TBaseProvider_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TProviderOptions read <getter> write <s...

  if IsGet then
    Result := TProviderOptions_sw.ToVar(TBaseProvider(AObj).Options)
  else
    TBaseProvider(AObj).Options := TProviderOptions_sw.FromVar(AArgs[0]);
end;

function TBaseProvider_UpdateMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UpdateMode: TUpdateMode read <getter> write <set...

  if IsGet then
    Result := TUpdateMode_sw.ToVar(TBaseProvider(AObj).UpdateMode)
  else
    TBaseProvider(AObj).UpdateMode := TUpdateMode_sw.FromVar(AArgs[0]);
end;

function TBaseProvider_OnGetData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetData: TProviderDataEvent read <getter> writ...

  if IsGet then
    Result := TProviderDataEvent_sw.ToVar(TBaseProvider(AObj).OnGetData)
  else
    TBaseProvider(AObj).OnGetData := TProviderDataEvent_sw.FromVar(AArgs[0]);
end;

function TBaseProvider_OnUpdateData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnUpdateData: TProviderDataEvent read <getter> w...

  if IsGet then
    Result := TProviderDataEvent_sw.ToVar(TBaseProvider(AObj).OnUpdateData)
  else
    TBaseProvider(AObj).OnUpdateData := TProviderDataEvent_sw.FromVar(AArgs[0]);
end;

function TBaseProvider_OnUpdateError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnUpdateError: TResolverErrorEvent read <getter>...

  if IsGet then
    Result := TResolverErrorEvent_sw.ToVar(TBaseProvider(AObj).OnUpdateError)
  else
    TBaseProvider(AObj).OnUpdateError := TResolverErrorEvent_sw.FromVar(
      AArgs[0]);
end;

function TBaseProvider_BeforeUpdateRecord_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeUpdateRecord: TBeforeUpdateRecordEvent rea...

  if IsGet then
    Result := TBeforeUpdateRecordEvent_sw.ToVar(TBaseProvider(AObj).
      BeforeUpdateRecord)
  else
    TBaseProvider(AObj).BeforeUpdateRecord := TBeforeUpdateRecordEvent_sw.
      FromVar(AArgs[0]);
end;

function TBaseProvider_AfterUpdateRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterUpdateRecord: TAfterUpdateRecordEvent read ...

  if IsGet then
    Result := TAfterUpdateRecordEvent_sw.ToVar(TBaseProvider(AObj).
      AfterUpdateRecord)
  else
    TBaseProvider(AObj).AfterUpdateRecord := TAfterUpdateRecordEvent_sw.FromVar(
      AArgs[0]);
end;

class function TBaseProvider_sw.GetTypeName: WideString;
begin
  Result := 'TBaseProvider';
end;

class function TBaseProvider_sw.GetWrappedClass: TClass;
begin
  Result := TBaseProvider;
end;

class procedure TBaseProvider_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('PacketDataSet', TBaseProvider_PacketDataSet_si, TPacketDataSet_sw, True, True, 0, True);
  AData.AddProperty('Resolver', TBaseProvider_Resolver_si, TCustomResolver_sw, True, False, 0, False);
  AData.AddProperty('Options', TBaseProvider_Options_si, TProviderOptions_sw, True, True, 0, False);
  AData.AddProperty('UpdateMode', TBaseProvider_UpdateMode_si, TUpdateMode_sw, True, True, 0, False);
  AData.AddPropertyRedecl('OnDataRequest');
  AData.AddProperty('OnGetData', TBaseProvider_OnGetData_si, TProviderDataEvent_sw, True, True, 0, False);
  AData.AddProperty('OnUpdateData', TBaseProvider_OnUpdateData_si, TProviderDataEvent_sw, True, True, 0, False);
  AData.AddProperty('OnUpdateError', TBaseProvider_OnUpdateError_si, TResolverErrorEvent_sw, True, True, 0, False);
  AData.AddProperty('BeforeUpdateRecord', TBaseProvider_BeforeUpdateRecord_si, TBeforeUpdateRecordEvent_sw, True, True, 0, False);
  AData.AddProperty('AfterUpdateRecord', TBaseProvider_AfterUpdateRecord_si, TAfterUpdateRecordEvent_sw, True, True, 0, False);
end;

class function TBaseProvider_sw.ToVar(const AValue: TBaseProvider): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBaseProvider_sw.FromVar(
  const AValue: OleVariant): TBaseProvider;
begin
  Result := TBaseProvider(ConvFromVar(AValue, TBaseProvider));
end;

class function TBaseProvider_sw.ClassToVar(
  AClass: TBaseProvider_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBaseProvider_sw.ClassFromVar(
  const AClass: OleVariant): TBaseProvider_sc;
begin
  Result := TBaseProvider_sc(ConvClsFromVar(AClass, TBaseProvider));
end;

{ TGetTableNameEvent_sh }

function TGetTableNameEvent_sh.GetHandler: TMethod;
var
  hdr: TGetTableNameEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetTableNameEvent_sh.Handler(Sender: TObject; DataSet: TDataSet;
  var TableName: WideString);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; DataSet: TDataSet; var TableN...

  v_1 := TableName;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TDataSet_sw.ToVar(DataSet);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  TableName := WideString(v_1);
end;

{ TGetTableNameEvent_sw }

class function TGetTableNameEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetTableNameEvent';
end;

class function TGetTableNameEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetTableNameEvent_sh;
end;

class function TGetTableNameEvent_sw.ToVar(
  const AValue: TGetTableNameEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetTableNameEvent_sw.FromVar(
  const AValue: OleVariant): TGetTableNameEvent;
begin
  Result := TGetTableNameEvent(ConvFromVar(AValue));
end;

class function TGetTableNameEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TGetTableNameEvent;
var
  hdlr: TGetTableNameEvent_sh;
begin
  hdlr   := TGetTableNameEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetTableNameEvent_sw));
  Result := hdlr.Handler;
end;

{ TGetDSProps_sh }

function TGetDSProps_sh.GetHandler: TMethod;
var
  hdr: TGetDSProps;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetDSProps_sh.Handler(Sender: TObject; DataSet: TDataSet;
  out Properties: OleVariant);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; DataSet: TDataSet; out Proper...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TDataSet_sw.ToVar(DataSet);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Properties := OleVariant(v_1);
end;

{ TGetDSProps_sw }

class function TGetDSProps_sw.GetTypeName: WideString;
begin
  Result := 'TGetDSProps';
end;

class function TGetDSProps_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetDSProps_sh;
end;

class function TGetDSProps_sw.ToVar(const AValue: TGetDSProps): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetDSProps_sw.FromVar(const AValue: OleVariant): TGetDSProps;
begin
  Result := TGetDSProps(ConvFromVar(AValue));
end;

class function TGetDSProps_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetDSProps;
var
  hdlr: TGetDSProps_sh;
begin
  hdlr   := TGetDSProps_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetDSProps_sw));
  Result := hdlr.Handler;
end;

{ TDataSetProvider_sw }

function TDataSetProvider_TransactionStarted_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TransactionStarted: Boolean read <gett...

  if IsGet then
    Result := TDataSetProvider_sacc(TDataSetProvider(AObj)).TransactionStarted
  else
    TDataSetProvider_sacc(TDataSetProvider(AObj)).TransactionStarted := Boolean(
      AArgs[0]);
end;

function TDataSetProvider_Params_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Params: TParams read <getter>;

  Result := TParams_sw.ToVar(TDataSetProvider(AObj).Params);
end;

function TDataSetProvider_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSet: TDataSet read <getter> write <setter>;

  if IsGet then
    Result := TDataSet_sw.ToVar(TDataSetProvider(AObj).DataSet)
  else
    TDataSetProvider(AObj).DataSet := TDataSet_sw.FromVar(AArgs[0]);
end;

function TDataSetProvider_Constraints_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Constraints: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDataSetProvider(AObj).Constraints
  else
    TDataSetProvider(AObj).Constraints := Boolean(AArgs[0]);
end;

function TDataSetProvider_ResolveToDataSet_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ResolveToDataSet: Boolean read <getter> write <s...

  if IsGet then
    Result := TDataSetProvider(AObj).ResolveToDataSet
  else
    TDataSetProvider(AObj).ResolveToDataSet := Boolean(AArgs[0]);
end;

function TDataSetProvider_OnGetTableName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetTableName: TGetTableNameEvent read <getter>...

  if IsGet then
    Result := TGetTableNameEvent_sw.ToVar(TDataSetProvider(AObj).OnGetTableName)
  else
    TDataSetProvider(AObj).OnGetTableName := TGetTableNameEvent_sw.FromVar(
      AArgs[0]);
end;

function TDataSetProvider_OnGetDataSetProperties_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetDataSetProperties: TGetDSProps read <getter...

  if IsGet then
    Result := TGetDSProps_sw.ToVar(TDataSetProvider(AObj).
      OnGetDataSetProperties)
  else
    TDataSetProvider(AObj).OnGetDataSetProperties := TGetDSProps_sw.FromVar(
      AArgs[0]);
end;

class function TDataSetProvider_sw.GetTypeName: WideString;
begin
  Result := 'TDataSetProvider';
end;

class function TDataSetProvider_sw.GetWrappedClass: TClass;
begin
  Result := TDataSetProvider;
end;

class procedure TDataSetProvider_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('TransactionStarted', TDataSetProvider_TransactionStarted_si, Boolean_sw, True, True, 0, True);
  AData.AddPropertyRedecl('ActiveUpdateException');
  AData.AddPropertyRedecl('OwnerData');
  AData.AddProperty('Params', TDataSetProvider_Params_si, TParams_sw, True, False, 0, False);
  AData.AddProperty('DataSet', TDataSetProvider_DataSet_si, TDataSet_sw, True, True, 0, False);
  AData.AddProperty('Constraints', TDataSetProvider_Constraints_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('ResolveToDataSet', TDataSetProvider_ResolveToDataSet_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Exported');
  AData.AddPropertyRedecl('Options');
  AData.AddPropertyRedecl('UpdateMode');
  AData.AddPropertyRedecl('OnDataRequest');
  AData.AddPropertyRedecl('OnGetData');
  AData.AddPropertyRedecl('OnUpdateData');
  AData.AddPropertyRedecl('OnUpdateError');
  AData.AddPropertyRedecl('AfterUpdateRecord');
  AData.AddPropertyRedecl('BeforeUpdateRecord');
  AData.AddPropertyRedecl('OnValidate');
  AData.AddPropertyRedecl('BeforeApplyUpdates');
  AData.AddPropertyRedecl('AfterApplyUpdates');
  AData.AddPropertyRedecl('BeforeGetRecords');
  AData.AddPropertyRedecl('AfterGetRecords');
  AData.AddPropertyRedecl('BeforeRowRequest');
  AData.AddPropertyRedecl('AfterRowRequest');
  AData.AddPropertyRedecl('BeforeExecute');
  AData.AddPropertyRedecl('AfterExecute');
  AData.AddPropertyRedecl('BeforeGetParams');
  AData.AddPropertyRedecl('AfterGetParams');
  AData.AddProperty('OnGetTableName', TDataSetProvider_OnGetTableName_si, TGetTableNameEvent_sw, True, True, 0, False);
  AData.AddProperty('OnGetDataSetProperties', TDataSetProvider_OnGetDataSetProperties_si, TGetDSProps_sw, True, True, 0, False);
end;

class function TDataSetProvider_sw.ToVar(
  const AValue: TDataSetProvider): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDataSetProvider_sw.FromVar(
  const AValue: OleVariant): TDataSetProvider;
begin
  Result := TDataSetProvider(ConvFromVar(AValue, TDataSetProvider));
end;

class function TDataSetProvider_sw.ClassToVar(
  AClass: TDataSetProvider_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDataSetProvider_sw.ClassFromVar(
  const AClass: OleVariant): TDataSetProvider_sc;
begin
  Result := TDataSetProvider_sc(ConvClsFromVar(AClass, TDataSetProvider));
end;

{ TProvider_sw }

class function TProvider_sw.GetTypeName: WideString;
begin
  Result := 'TProvider';
end;

class function TProvider_sw.GetWrappedClass: TClass;
begin
  Result := TProvider;
end;

class procedure TProvider_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TProvider_sw.ToVar(const AValue: TProvider): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TProvider_sw.FromVar(const AValue: OleVariant): TProvider;
begin
  Result := TProvider(ConvFromVar(AValue, TProvider));
end;

class function TProvider_sw.ClassToVar(AClass: TProvider_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TProvider_sw.ClassFromVar(
  const AClass: OleVariant): TProvider_sc;
begin
  Result := TProvider_sc(ConvClsFromVar(AClass, TProvider));
end;

{ TUpdateTree_sw }

function TUpdateTree_Opened_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Opened: Boolean read <getter> write <s...

  if IsGet then
    Result := TUpdateTree_sacc(TUpdateTree(AObj)).Opened
  else
    TUpdateTree_sacc(TUpdateTree(AObj)).Opened := Boolean(AArgs[0]);
end;

function TUpdateTree_DetailList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DetailList: TList read <getter>;

  Result := TList_sw.ToVar(TUpdateTree_sacc(TUpdateTree(AObj)).DetailList);
end;

function TUpdateTree_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AParent: TUpdateTree; AResolver: TCust...

  Result := TUpdateTree_sw.ToVar(TUpdateTree_sc(AObj).Create(TUpdateTree_sw.
    FromVar(AArgs[0]), TCustomResolver_sw.FromVar(AArgs[1])));
end;

function TUpdateTree_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TUpdateTree(AObj).Clear();
end;

function TUpdateTree_DoUpdates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DoUpdates: Boolean;

  Result := TUpdateTree(AObj).DoUpdates();
end;

function TUpdateTree_InitData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InitData(ASource: TDataSet);

  TUpdateTree(AObj).InitData(TDataSet_sw.FromVar(AArgs[0]));
end;

function TUpdateTree_InitDelta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InitDelta(ADelta: TPacketDataSet);

  TUpdateTree(AObj).InitDelta(TPacketDataSet_sw.FromVar(AArgs[0]));
end;

function TUpdateTree_InitErrorPacket_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InitErrorPacket(E: EUpdateError; Response: TRes...

  TUpdateTree(AObj).InitErrorPacket(EUpdateError_sw.FromVar(AArgs[0]), 
    TResolverResponse_sw.FromVar(AArgs[1]));
end;

function TUpdateTree_RefreshData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RefreshData(Options: TFetchOptions);

  TUpdateTree(AObj).RefreshData(TFetchOptions_sw.FromVar(AArgs[0]));
end;

function TUpdateTree_Delta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Delta: TPacketDataSet read <getter> write <setter>;

  if IsGet then
    Result := TPacketDataSet_sw.ToVar(TUpdateTree(AObj).Delta)
  else
    TUpdateTree(AObj).Delta := TPacketDataSet_sw.FromVar(AArgs[0]);
end;

function TUpdateTree_DetailCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DetailCount: Integer read <getter>;

  Result := TUpdateTree(AObj).DetailCount;
end;

function TUpdateTree_Details_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Details[Index: Integer]: TUpdateTree read <getter>;

  Result := TUpdateTree_sw.ToVar(TUpdateTree(AObj).Details[Integer(AArgs[0])]);
end;

function TUpdateTree_ErrorDS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ErrorDS: TPacketDataSet read <getter> write <set...

  if IsGet then
    Result := TPacketDataSet_sw.ToVar(TUpdateTree(AObj).ErrorDS)
  else
    TUpdateTree(AObj).ErrorDS := TPacketDataSet_sw.FromVar(AArgs[0]);
end;

function TUpdateTree_HasErrors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HasErrors: Boolean read <getter>;

  Result := TUpdateTree(AObj).HasErrors;
end;

function TUpdateTree_IsNested_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsNested: Boolean read <getter>;

  Result := TUpdateTree(AObj).IsNested;
end;

function TUpdateTree_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Name: WideString read <getter> write <setter>;

  if IsGet then
    Result := TUpdateTree(AObj).Name
  else
    TUpdateTree(AObj).Name := WideString(AArgs[0]);
end;

function TUpdateTree_Parent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Parent: TUpdateTree read <getter>;

  Result := TUpdateTree_sw.ToVar(TUpdateTree(AObj).Parent);
end;

function TUpdateTree_Resolver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Resolver: TCustomResolver read <getter>;

  Result := TCustomResolver_sw.ToVar(TUpdateTree(AObj).Resolver);
end;

function TUpdateTree_Source_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Source: TDataSet read <getter> write <setter>;

  if IsGet then
    Result := TDataSet_sw.ToVar(TUpdateTree(AObj).Source)
  else
    TUpdateTree(AObj).Source := TDataSet_sw.FromVar(AArgs[0]);
end;

class function TUpdateTree_sw.GetTypeName: WideString;
begin
  Result := 'TUpdateTree';
end;

class function TUpdateTree_sw.GetWrappedClass: TClass;
begin
  Result := TUpdateTree;
end;

class procedure TUpdateTree_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Opened', TUpdateTree_Opened_si, Boolean_sw, True, True, 0, True);
  AData.AddProperty('DetailList', TUpdateTree_DetailList_si, TList_sw, True, False, 0, True);
  AData.AddProcedure('Clear', TUpdateTree_Clear_si, 0, False);
  AData.AddFunction('DoUpdates', TUpdateTree_DoUpdates_si, Boolean_sw, 0, False);
  AData.AddProcedure('InitData', TUpdateTree_InitData_si, 1, False);
  AData.AddProcedure('InitDelta', TUpdateTree_InitDelta_si, 1, False);
  AData.AddProcedure('InitErrorPacket', TUpdateTree_InitErrorPacket_si, 2, False);
  AData.AddProcedure('RefreshData', TUpdateTree_RefreshData_si, 1, False);
  AData.AddProperty('Delta', TUpdateTree_Delta_si, TPacketDataSet_sw, True, True, 0, False);
  AData.AddProperty('DetailCount', TUpdateTree_DetailCount_si, Integer_sw, True, False, 0, False);
  AData.AddProperty('Details', TUpdateTree_Details_si, TUpdateTree_sw, True, False, 1, False);
  AData.AddProperty('ErrorDS', TUpdateTree_ErrorDS_si, TPacketDataSet_sw, True, True, 0, False);
  AData.AddProperty('HasErrors', TUpdateTree_HasErrors_si, Boolean_sw, True, False, 0, False);
  AData.AddProperty('IsNested', TUpdateTree_IsNested_si, Boolean_sw, True, False, 0, False);
  AData.AddProperty('Name', TUpdateTree_Name_si, WideString_sw, True, True, 0, False);
  AData.AddProperty('Parent', TUpdateTree_Parent_si, TUpdateTree_sw, True, False, 0, False);
  AData.AddProperty('Resolver', TUpdateTree_Resolver_si, TCustomResolver_sw, True, False, 0, False);
  AData.AddProperty('Source', TUpdateTree_Source_si, TDataSet_sw, True, True, 0, False);

  { Class members }

  AData.AddConstructor('Create', TUpdateTree_Create_si, 2, False);
end;

class function TUpdateTree_sw.ToVar(const AValue: TUpdateTree): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TUpdateTree_sw.FromVar(const AValue: OleVariant): TUpdateTree;
begin
  Result := TUpdateTree(ConvFromVar(AValue, TUpdateTree));
end;

class function TUpdateTree_sw.ClassToVar(AClass: TUpdateTree_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TUpdateTree_sw.ClassFromVar(
  const AClass: OleVariant): TUpdateTree_sc;
begin
  Result := TUpdateTree_sc(ConvClsFromVar(AClass, TUpdateTree));
end;

{ TCustomResolver_sw }

function TCustomResolver_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AProvider: TBaseProvider);

  Result := TCustomResolver_sw.ToVar(TCustomResolver_sc(AObj).Create(
    TBaseProvider_sw.FromVar(AArgs[0])));
end;

function TCustomResolver_ApplyUpdates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // function ApplyUpdates(const Delta: OleVariant; MaxErrors:...

  Result := TCustomResolver(AObj).ApplyUpdates(OleVariant(AArgs[0]), Integer(
    AArgs[1]), v_1);
  AssignRefParam(AArgs[2], v_1);
end;

function TCustomResolver_FreeTreeData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FreeTreeData(Tree: TUpdateTree);

  TCustomResolver(AObj).FreeTreeData(TUpdateTree_sw.FromVar(AArgs[0]));
end;

function TCustomResolver_InitKeyFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InitKeyFields(Tree: TUpdateTree; ADelta: TPacke...

  TCustomResolver(AObj).InitKeyFields(TUpdateTree_sw.FromVar(AArgs[0]), 
    TPacketDataSet_sw.FromVar(AArgs[1]));
end;

function TCustomResolver_InitTreeData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InitTreeData(Tree: TUpdateTree);

  TCustomResolver(AObj).InitTreeData(TUpdateTree_sw.FromVar(AArgs[0]));
end;

function TCustomResolver_InternalBeforeResolve_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InternalBeforeResolve(Tree: TUpdateTree);

  TCustomResolver(AObj).InternalBeforeResolve(TUpdateTree_sw.FromVar(AArgs[0]));
end;

function TCustomResolver_InternalUpdateRecord_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function InternalUpdateRecord(Tree: TUpdateTree): Boolean;

  Result := TCustomResolver(AObj).InternalUpdateRecord(TUpdateTree_sw.FromVar(
    AArgs[0]));
end;

function TCustomResolver_RowRequest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RowRequest(Row: OleVariant; Options: TFetchOptio...

  Result := TCustomResolver(AObj).RowRequest(OleVariant(AArgs[0]), 
    TFetchOptions_sw.FromVar(AArgs[1]));
end;

function TCustomResolver_Provider_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Provider: TBaseProvider read <getter>;

  Result := TBaseProvider_sw.ToVar(TCustomResolver(AObj).Provider);
end;

function TCustomResolver_UpdateTree_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UpdateTree: TUpdateTree read <getter>;

  Result := TUpdateTree_sw.ToVar(TCustomResolver(AObj).UpdateTree);
end;

class function TCustomResolver_sw.GetTypeName: WideString;
begin
  Result := 'TCustomResolver';
end;

class function TCustomResolver_sw.GetWrappedClass: TClass;
begin
  Result := TCustomResolver;
end;

class procedure TCustomResolver_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('ApplyUpdates', TCustomResolver_ApplyUpdates_si, OleVariant_sw, 3, False);
  AData.AddProcedure('FreeTreeData', TCustomResolver_FreeTreeData_si, 1, False);
  AData.AddProcedure('InitKeyFields', TCustomResolver_InitKeyFields_si, 2, False);
  AData.AddProcedure('InitTreeData', TCustomResolver_InitTreeData_si, 1, False);
  AData.AddProcedure('InternalBeforeResolve', TCustomResolver_InternalBeforeResolve_si, 1, False);
  AData.AddFunction('InternalUpdateRecord', TCustomResolver_InternalUpdateRecord_si, Boolean_sw, 1, False);
  AData.AddFunction('RowRequest', TCustomResolver_RowRequest_si, OleVariant_sw, 2, False);
  AData.AddProperty('Provider', TCustomResolver_Provider_si, TBaseProvider_sw, True, False, 0, False);
  AData.AddProperty('UpdateTree', TCustomResolver_UpdateTree_si, TUpdateTree_sw, True, False, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCustomResolver_Create_si, 1, False);
end;

class function TCustomResolver_sw.ToVar(
  const AValue: TCustomResolver): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomResolver_sw.FromVar(
  const AValue: OleVariant): TCustomResolver;
begin
  Result := TCustomResolver(ConvFromVar(AValue, TCustomResolver));
end;

class function TCustomResolver_sw.ClassToVar(
  AClass: TCustomResolver_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomResolver_sw.ClassFromVar(
  const AClass: OleVariant): TCustomResolver_sc;
begin
  Result := TCustomResolver_sc(ConvClsFromVar(AClass, TCustomResolver));
end;

{ TDataSetResolver_sw }

function TDataSetResolver_Provider_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Provider: TDataSetProvider read <getter>;

  Result := TDataSetProvider_sw.ToVar(TDataSetResolver_sacc(TDataSetResolver(
    AObj)).Provider);
end;

function TDataSetResolver_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AProvider: TDataSetProvider);

  Result := TDataSetResolver_sw.ToVar(TDataSetResolver_sc(AObj).Create(
    TDataSetProvider_sw.FromVar(AArgs[0])));
end;

class function TDataSetResolver_sw.GetTypeName: WideString;
begin
  Result := 'TDataSetResolver';
end;

class function TDataSetResolver_sw.GetWrappedClass: TClass;
begin
  Result := TDataSetResolver;
end;

class procedure TDataSetResolver_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Provider', TDataSetResolver_Provider_si, TDataSetProvider_sw, True, False, 0, True);

  { Class members }

  AData.AddConstructor('Create', TDataSetResolver_Create_si, 1, False);
end;

class function TDataSetResolver_sw.ToVar(
  const AValue: TDataSetResolver): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDataSetResolver_sw.FromVar(
  const AValue: OleVariant): TDataSetResolver;
begin
  Result := TDataSetResolver(ConvFromVar(AValue, TDataSetResolver));
end;

class function TDataSetResolver_sw.ClassToVar(
  AClass: TDataSetResolver_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDataSetResolver_sw.ClassFromVar(
  const AClass: OleVariant): TDataSetResolver_sc;
begin
  Result := TDataSetResolver_sc(ConvClsFromVar(AClass, TDataSetResolver));
end;

{ TSQLResolver_sw }

function TSQLResolver_Provider_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Provider: TDataSetProvider read <getter>;

  Result := TDataSetProvider_sw.ToVar(TSQLResolver_sacc(TSQLResolver(AObj)).
    Provider);
end;

function TSQLResolver_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AProvider: TDataSetProvider);

  Result := TSQLResolver_sw.ToVar(TSQLResolver_sc(AObj).Create(
    TDataSetProvider_sw.FromVar(AArgs[0])));
end;

class function TSQLResolver_sw.GetTypeName: WideString;
begin
  Result := 'TSQLResolver';
end;

class function TSQLResolver_sw.GetWrappedClass: TClass;
begin
  Result := TSQLResolver;
end;

class procedure TSQLResolver_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Provider', TSQLResolver_Provider_si, TDataSetProvider_sw, True, False, 0, True);

  { Class members }

  AData.AddConstructor('Create', TSQLResolver_Create_si, 1, False);
end;

class function TSQLResolver_sw.ToVar(const AValue: TSQLResolver): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSQLResolver_sw.FromVar(const AValue: OleVariant): TSQLResolver;
begin
  Result := TSQLResolver(ConvFromVar(AValue, TSQLResolver));
end;

class function TSQLResolver_sw.ClassToVar(AClass: TSQLResolver_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSQLResolver_sw.ClassFromVar(
  const AClass: OleVariant): TSQLResolver_sc;
begin
  Result := TSQLResolver_sc(ConvClsFromVar(AClass, TSQLResolver));
end;

{ TLocalAppServer_sw }

function TLocalAppServer_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AProvider: TCustomProvider);

  Result := TLocalAppServer_sw.ToVar(TLocalAppServer_sc(AObj).Create(
    TCustomProvider_sw.FromVar(AArgs[0])));
end;

class function TLocalAppServer_sw.GetTypeName: WideString;
begin
  Result := 'TLocalAppServer';
end;

class function TLocalAppServer_sw.GetWrappedClass: TClass;
begin
  Result := TLocalAppServer;
end;

class procedure TLocalAppServer_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TLocalAppServer_Create_si, 1, False);
end;

class function TLocalAppServer_sw.ToVar(
  const AValue: TLocalAppServer): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TLocalAppServer_sw.FromVar(
  const AValue: OleVariant): TLocalAppServer;
begin
  Result := TLocalAppServer(ConvFromVar(AValue, TLocalAppServer));
end;

class function TLocalAppServer_sw.ClassToVar(
  AClass: TLocalAppServer_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TLocalAppServer_sw.ClassFromVar(
  const AClass: OleVariant): TLocalAppServer_sc;
begin
  Result := TLocalAppServer_sc(ConvClsFromVar(AClass, TLocalAppServer));
end;

{ Provider_sw }

function Provider_InformixLob_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var InformixLob: Boolean;

  if IsGet then
    Result := Provider.InformixLob
  else
    Provider.InformixLob := Boolean(AArgs[0]);
end;

function Provider_EDSWriter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EDSWriter = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EDSWriter_sw);
end;

function Provider_TCustomPacketWriter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomPacketWriter = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TCustomPacketWriter_sw);
end;

function Provider_TGetRecordOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetRecordOption = (grReset, grXML, grXMLUTF8);

  Result := TLMDUnitWrapper.TypeToVar(TGetRecordOption_sw);
end;

function Provider_TGetRecordOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetRecordOptions = set of TGetRecordOption;

  Result := TLMDUnitWrapper.TypeToVar(TGetRecordOptions_sw);
end;

function Provider_TDataRequestEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataRequestEvent = function (Sender: TObject; Input...

  Result := TLMDUnitWrapper.TypeToVar(TDataRequestEvent_sw);
end;

function Provider_TProviderOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProviderOption = (poFetchDetailsOnDemand, poIncFiel...

  Result := TLMDUnitWrapper.TypeToVar(TProviderOption_sw);
end;

function Provider_TProviderOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProviderOptions = set of TProviderOption;

  Result := TLMDUnitWrapper.TypeToVar(TProviderOptions_sw);
end;

function Provider_TPutFieldInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPutFieldInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TPutFieldInfo_sw);
end;

function Provider_TGetParamsEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetParamsEvent = procedure (DataSet: TDataSet; Para...

  Result := TLMDUnitWrapper.TypeToVar(TGetParamsEvent_sw);
end;

function Provider_TOnValidate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOnValidate = procedure (const Delta: OleVariant) of...

  Result := TLMDUnitWrapper.TypeToVar(TOnValidate_sw);
end;

function Provider_TDataPacketWriter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataPacketWriter = class(TCustomPacketWriter);

  Result := TLMDUnitWrapper.TypeToVar(TDataPacketWriter_sw);
end;

function Provider_TPacketDataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPacketDataSet = class(TCustomClientDataSet);

  Result := TLMDUnitWrapper.TypeToVar(TPacketDataSet_sw);
end;

function Provider_TCustomProvider_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomProvider = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomProvider_sw);
end;

function Provider_ResetOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ResetOption: Integer = <value>;

  Result := ResetOption;
end;

function Provider_MetaDataOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MetaDataOption: Integer = <value>;

  Result := MetaDataOption;
end;

function Provider_XMLOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const XMLOption: Integer = <value>;

  Result := XMLOption;
end;

function Provider_XMLUTF8Option_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const XMLUTF8Option: Integer = <value>;

  Result := XMLUTF8Option;
end;

function Provider_TResolverResponse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TResolverResponse = (rrAbort, rrMerge, rrApply, rrIg...

  Result := TLMDUnitWrapper.TypeToVar(TResolverResponse_sw);
end;

function Provider_TProviderDataEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProviderDataEvent = procedure (Sender: TObject; Dat...

  Result := TLMDUnitWrapper.TypeToVar(TProviderDataEvent_sw);
end;

function Provider_TBeforeUpdateRecordEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBeforeUpdateRecordEvent = procedure (Sender: TObjec...

  Result := TLMDUnitWrapper.TypeToVar(TBeforeUpdateRecordEvent_sw);
end;

function Provider_TAfterUpdateRecordEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAfterUpdateRecordEvent = procedure (Sender: TObject...

  Result := TLMDUnitWrapper.TypeToVar(TAfterUpdateRecordEvent_sw);
end;

function Provider_TResolverErrorEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TResolverErrorEvent = procedure (Sender: TObject; Da...

  Result := TLMDUnitWrapper.TypeToVar(TResolverErrorEvent_sw);
end;

function Provider_TBeforeCommitEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBeforeCommitEvent = procedure (Sender: TObject; Del...

  Result := TLMDUnitWrapper.TypeToVar(TBeforeCommitEvent_sw);
end;

function Provider_TBaseProvider_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBaseProvider = class(TCustomProvider);

  Result := TLMDUnitWrapper.TypeToVar(TBaseProvider_sw);
end;

function Provider_TGetTableNameEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetTableNameEvent = procedure (Sender: TObject; Dat...

  Result := TLMDUnitWrapper.TypeToVar(TGetTableNameEvent_sw);
end;

function Provider_TGetDSProps_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetDSProps = procedure (Sender: TObject; DataSet: T...

  Result := TLMDUnitWrapper.TypeToVar(TGetDSProps_sw);
end;

function Provider_TDataSetProvider_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSetProvider = class(TBaseProvider);

  Result := TLMDUnitWrapper.TypeToVar(TDataSetProvider_sw);
end;

function Provider_TProvider_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProvider = class(TDataSetProvider);

  Result := TLMDUnitWrapper.TypeToVar(TProvider_sw);
end;

function Provider_TUpdateTree_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUpdateTree = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TUpdateTree_sw);
end;

function Provider_TCustomResolver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomResolver = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomResolver_sw);
end;

function Provider_TDataSetResolver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSetResolver = class(TCustomResolver);

  Result := TLMDUnitWrapper.TypeToVar(TDataSetResolver_sw);
end;

function Provider_TSQLResolver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSQLResolver = class(TCustomResolver);

  Result := TLMDUnitWrapper.TypeToVar(TSQLResolver_sw);
end;

function Provider_TLocalAppServer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLocalAppServer = class(TInterfacedObject, IAppServe...

  Result := TLMDUnitWrapper.TypeToVar(TLocalAppServer_sw);
end;

function Provider_GetObjectProperty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetObjectProperty(Instance: TPersistent; const P...

  Result := TObject_sw.ToVar(Provider.GetObjectProperty(TPersistent_sw.FromVar(
    AArgs[0]), string(AArgs[1])));
end;

function Provider_GetStringProperty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetStringProperty(Instance: TPersistent; const P...

  Result := Provider.GetStringProperty(TPersistent_sw.FromVar(AArgs[0]), string(
    AArgs[1]));
end;

function Provider_VarArrayFromStrings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarArrayFromStrings(Strings: TStrings): Variant;

  Result := Provider.VarArrayFromStrings(TStrings_sw.FromVar(AArgs[0]));
end;

function Provider_VarArrayFromWideStrings_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarArrayFromWideStrings(Strings: TWideStrings): ...

  Result := Provider.VarArrayFromWideStrings(TWideStrings_sw.FromVar(AArgs[0]));
end;

class function Provider_sw.GetUnitName: WideString;
begin
  Result := 'Provider';
end;

class procedure Provider_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddVariable('InformixLob', Provider_InformixLob_si, Boolean_sw);
  AData.AddType(EDSWriter_sw, Provider_EDSWriter_si);
  AData.AddType(TCustomPacketWriter_sw, Provider_TCustomPacketWriter_si);
  AData.AddType(TGetRecordOption_sw, Provider_TGetRecordOption_si);
  AData.AddType(TGetRecordOptions_sw, Provider_TGetRecordOptions_si);
  AData.AddType(TDataRequestEvent_sw, Provider_TDataRequestEvent_si);
  AData.AddType(TProviderOption_sw, Provider_TProviderOption_si);
  AData.AddType(TProviderOptions_sw, Provider_TProviderOptions_si);
  AData.AddType(TPutFieldInfo_sw, Provider_TPutFieldInfo_si);
  AData.AddType(TGetParamsEvent_sw, Provider_TGetParamsEvent_si);
  AData.AddType(TOnValidate_sw, Provider_TOnValidate_si);
  AData.AddType(TDataPacketWriter_sw, Provider_TDataPacketWriter_si);
  AData.AddType(TPacketDataSet_sw, Provider_TPacketDataSet_si);
  AData.AddType(TCustomProvider_sw, Provider_TCustomProvider_si);
  AData.AddConstant('ResetOption', Provider_ResetOption_si, Integer_sw);
  AData.AddConstant('MetaDataOption', Provider_MetaDataOption_si, Integer_sw);
  AData.AddConstant('XMLOption', Provider_XMLOption_si, Integer_sw);
  AData.AddConstant('XMLUTF8Option', Provider_XMLUTF8Option_si, Integer_sw);
  AData.AddType(TResolverResponse_sw, Provider_TResolverResponse_si);
  AData.AddType(TProviderDataEvent_sw, Provider_TProviderDataEvent_si);
  AData.AddType(TBeforeUpdateRecordEvent_sw, Provider_TBeforeUpdateRecordEvent_si);
  AData.AddType(TAfterUpdateRecordEvent_sw, Provider_TAfterUpdateRecordEvent_si);
  AData.AddType(TResolverErrorEvent_sw, Provider_TResolverErrorEvent_si);
  AData.AddType(TBeforeCommitEvent_sw, Provider_TBeforeCommitEvent_si);
  AData.AddType(TBaseProvider_sw, Provider_TBaseProvider_si);
  AData.AddType(TGetTableNameEvent_sw, Provider_TGetTableNameEvent_si);
  AData.AddType(TGetDSProps_sw, Provider_TGetDSProps_si);
  AData.AddType(TDataSetProvider_sw, Provider_TDataSetProvider_si);
  AData.AddType(TProvider_sw, Provider_TProvider_si);
  AData.AddType(TUpdateTree_sw, Provider_TUpdateTree_si);
  AData.AddType(TCustomResolver_sw, Provider_TCustomResolver_si);
  AData.AddType(TDataSetResolver_sw, Provider_TDataSetResolver_si);
  AData.AddType(TSQLResolver_sw, Provider_TSQLResolver_si);
  AData.AddType(TLocalAppServer_sw, Provider_TLocalAppServer_si);
  AData.AddFunction('GetObjectProperty', Provider_GetObjectProperty_si, TObject_sw, 2, False);
  AData.AddFunction('GetStringProperty', Provider_GetStringProperty_si, WideString_sw, 2, False);
  AData.AddFunction('VarArrayFromStrings', Provider_VarArrayFromStrings_si, Variant_sw, 1, False);
  AData.AddFunction('VarArrayFromWideStrings', Provider_VarArrayFromWideStrings_si, Variant_sw, 1, False);
end;

class function Provider_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Provider_sw);
end;

initialization
  RegisterUnitWrapper(Provider_sw);
  RegisterClassWrapper(EDSWriter_sw);
  RegisterClassWrapper(TCustomPacketWriter_sw);
  RegisterClassWrapper(TDataPacketWriter_sw);
  RegisterClassWrapper(TPacketDataSet_sw);
  RegisterClassWrapper(TCustomProvider_sw);
  RegisterClassWrapper(TBaseProvider_sw);
  RegisterClassWrapper(TDataSetProvider_sw);
  RegisterClassWrapper(TProvider_sw);
  RegisterClassWrapper(TUpdateTree_sw);
  RegisterClassWrapper(TCustomResolver_sw);
  RegisterClassWrapper(TDataSetResolver_sw);
  RegisterClassWrapper(TSQLResolver_sw);
  RegisterClassWrapper(TLocalAppServer_sw);
  RegisterEventWrapper(TypeInfo(TDataRequestEvent), TDataRequestEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetParamsEvent), TGetParamsEvent_sw);
  RegisterEventWrapper(TypeInfo(TOnValidate), TOnValidate_sw);
  RegisterEventWrapper(TypeInfo(TProviderDataEvent), TProviderDataEvent_sw);
  RegisterEventWrapper(TypeInfo(TBeforeUpdateRecordEvent), TBeforeUpdateRecordEvent_sw);
  RegisterEventWrapper(TypeInfo(TAfterUpdateRecordEvent), TAfterUpdateRecordEvent_sw);
  RegisterEventWrapper(TypeInfo(TResolverErrorEvent), TResolverErrorEvent_sw);
  RegisterEventWrapper(TypeInfo(TBeforeCommitEvent), TBeforeCommitEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetTableNameEvent), TGetTableNameEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetDSProps), TGetDSProps_sw);

end.
