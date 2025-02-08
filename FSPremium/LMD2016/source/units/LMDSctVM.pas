unit LMDSctVM;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDSctPasRuntime unit (YB)
--------------------------
LMD ScriptPack run-time VM for native PasScript and native VbScript.

Changes
-------
Release 4.0 (March 2009)
 - Initial Release

###############################################################################}

interface

uses
  // We try to NOT use Variants unit here. VM overrides many variant handling
  // routines, so to be sure that proper routines are used do not include
  // Variants unit in uses.

  Windows, SysUtils, Classes, ActiveX, SyncObjs, Types, LMDTypes, LMDSctCst,
  LMDSctClass, LMDSctVMByteCode, LMDSctVMCompBase;

type
  TLMDCodeObject     = class;
  TLMDVirtMachine    = class;
  TLMDVMDebugger     = class;
  ELMDVirtMachine    = class(Exception);

  {****************************** ELMDVMRuntime *******************************}

  TLMDRuntimeErrorType = (retUndeclaredId, retOutsideOfLoop, retEBCFromFinally,
                          retCannotAssign, retInvalidParamCount, retTypeMismatch,
                          retObjectRequired, retLoopVar, retCannotRaiseNil,
                          retCannotRaiseLocked, retLowOnlyArray, retHighOnlyArray,
                          retViolatesBounds, retInvalidDispId, retProcRequired,
                          retValObjRequired, retAborted, retIEInvalidObjKind,
                          retIEInvalidBracketType, retIEInvalidInstr,
                          retIENoBreakpointInfo);

  ELMDVMRuntime = class(Exception)
  private
    class function FormatMsg(AErrorType: TLMDRuntimeErrorType;
                             const AArgs: array of const): WideString;
  public
    class procedure RaiseError(AErrorType: TLMDRuntimeErrorType); overload;
    class procedure RaiseError(AErrorType: TLMDRuntimeErrorType;
                               const AStrName: WideString); overload;
    class procedure RaiseError(AInvokeRes: HResult; var EInfo: TExcepInfo;
                               AFinalizeEInfo: Boolean); overload;
  end;

  {****************************** TLMDThreadData ******************************}

  TLMDStackItem = class
  private
    FData:         packed array of OleVariant; // Should be packaed. See
                                               // TExcVarData comments.
    FSize:         Integer;
    FPrev:         TLMDStackItem;
    FUsedItemSize: Integer;
  public
    constructor Create(ASize: Integer; APrev: TLMDStackItem);
  end;

  TLMDStackPool = class
  private
    FLast: TLMDStackItem;
  public
    constructor Create;
    destructor Destroy; override;

    function  AsquireStack(ASize: Integer): PLMDVarArray;
    procedure ReleaseStack(ASize: Integer);
  end;

  PLMDCallStackFrame = ^TLMDCallStackFrame;
  TLMDCallStackFrame = record
    Next:     PLMDCallStackFrame;
    VM:       TLMDVirtMachine;
    Ctx:      Pointer;       // Pointer to corresponding PLMDVMInterpretContext.
    CurNS:    TLMDAbstractNamespace;
    IP:       PLMDInstr;     // Pointer to current instruction.
    Stack:    PLMDVarArray;  // Pointer to data stack, e.g. local variables.
    ExcSt:    Pointer;       // PExcVarData.
  end;

  TLMDThreadVM = class;
  TLMDVMLock   = class
  private
    FVM:                TLMDVirtMachine;
    FVMDataList:        TList;
    FInactiveOrClosing: Boolean;
    FDebuggerId:        Integer;
  public
    constructor Create(VM: TLMDVirtMachine);
    destructor Destroy; override;

    property VM: TLMDVirtMachine read FVM;
  end;

  TLMDThreadGlobals = class
  private
    FThreadVM:       TLMDThreadVM;
    FVMLock:         TLMDVMLock;
    FItems:          TLMDNameHashTable;        // TThreadExternsItem items.
    FProcsCache:     TLMDIdentifierHashTable;  // Proc by string name cache.
                                               // Stores exact names as keys,
                                               // without upper-casing them.
    FValObjCache:    TLMDIdentifierHashTable;  // ValObj by string name cache.
                                               // Stores exact names as keys,
                                               // without upper-casing them.
    FPubMrsExterns:  TList;
    FChangeNumber:   Integer;

    procedure UpdateContent(AScriptGlobals, AExterns, APubMrsExterns,
                            AIntrinsics: TList; AChangeNumber: Integer);
    function  SearchInPubMembers(AName: Integer; const AStrName: WideString;
                                 out ASearchRes: TLMDNameSearchRes): Boolean;
    function  AddMemberToItems(AObject: TLMDExternObject; AMemberName,
                               ADispId: Integer): TLMDNameSearchRes;
    function  AddProcToCache(const AStrName: WideString): TLMDProcObject;
    function  AddValObjToCache(const AStrName: WideString): TLMDGlobalValuedObject;
  public
    constructor Create(AThreadVM: TLMDThreadVM);
    destructor Destroy; override;

    procedure Clear;
    function  Search(AName: Integer; const AStrName: WideString): TLMDNameSearchRes;
    function  FindProcByStrName(const AStrName: WideString): TLMDProcObject;
    function  FindValObjByStrName(const AStrName: WideString): TLMDGlobalValuedObject;
  end;

  TLMDThread   = class;
  PLMDFrame = ^TLMDFrame;
  TLMDFrame = type TLMDPtrUInt;

  TLMDThreadVM = class
  private
    FVMLock:       TLMDVMLock;
    FThread:       TLMDThread;
    FGlobals:      TLMDThreadGlobals;
    FLockCount:    Integer;
    FFlag:         Integer;
    FSteppingBase: PLMDFrame;
    FInBreak:      Boolean;
  public
    constructor Create(AVMLock: TLMDVMLock; AThread: TLMDThread;
                       AInactiveOrClosing: Boolean; ASteppingBase: PLMDFrame);
    destructor Destroy; override;

    function  Lock: Boolean;
    procedure Unlock;
    property  VMLock: TLMDVMLock read FVMLock;
    property  Thread: TLMDThread read FThread;
    property  Globals: TLMDThreadGlobals read FGlobals;
    property  SteppingBase: PLMDFrame read FSteppingBase;
    property  InBreak: Boolean read FInBreak write FInBreak;
  end;

  TLMDThreadVMs = array of TLMDThreadVM;
  TLMDThread    = class
  private
    FThread:       THandle;
    FStackPool:    TLMDStackPool;
    FCallStack:    PLMDCallStackFrame;
    FVMData:       TLMDThreadVMs;
  public
    constructor Create;
    destructor Destroy; override;

    function IsThreadClosed: Boolean;
    property StackPool: TLMDStackPool read FStackPool;
    property CallStack: PLMDCallStackFrame read FCallStack write FCallStack;
    property VMData: TLMDThreadVMs read FVMData;
  public
    PV: POleVariant; // Temporary registers used in Interpret.
    V:  OleVariant;  //
  end;

  TLMDThreadData = record
    Thread:       TLMDThread;
    VMDataLength: Integer;
  end;

  TLMDVMId = record
    Id:    Integer;    // Unique auto-increment id.
    Index: Integer;    // Unique reusable index among all *existing* VMs.
    Lock:  TLMDVMLock;
  end;

  {****************************** TLMDCodeObject ******************************}

  TLMDCodeObject = class(TInterfacedObject, IInterface, IDispatch)
  private
    FId:           TLMDVMId;
    FIdsByStrName: TLMDIdentifierHashTable;
    FIdsByName:    TLMDNameHashTable;      // Items - TCodeObjectItem.
    FMaxDispId:    Integer;

    procedure Init(AVM: TLMDVirtMachine);
    function  EncodeInvokeError(E: Exception; AEInfo: PExcepInfo): HRESULT;
    procedure RaiseVMHasBeenClosed;
  protected
    { IUnknown overrides }

    function  QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;

    { IDispatch }

    function  GetTypeInfo(Index: Integer; LocaleID: Integer; out TypeInfo):
                          HResult; stdcall;
    function  GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function  GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount: Integer;
                            LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function  Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
                     Flags: Word; var Params; VarResult: Pointer;
                     ExcepInfo: Pointer; ArgErr: Pointer): HResult; stdcall;
  public
    constructor Create(AVM: TLMDVirtMachine);
    destructor Destroy; override;

    function  GetIdOfName(ANameIndex: Integer; out ADispId: Integer): Boolean;
    procedure InvokeMember(AThread: TLMDThread; DispID: Integer;
                           ABracketType: TLMDBracketType; AResMask: DWORD;
                           AArgCount: Integer; AArgs: PLMDVarArray;
                           var AResult: OleVariant);
    procedure InvokePropPut(AThread: TLMDThread; DispID: Integer;
                            ABracketType: TLMDBracketType; AArgCount: Integer;
                            AArgs: PLMDVarArray; AValue: POleVariant);
  end;

  {***************************** TLMDVirtMachine ******************************}

  TLMDVMState = (msUninitialized, msInitialized, msActive);

  TLMDExternObjects = class
  private
    FVM:           TLMDVirtMachine;
    FSection:      TCriticalSection;
    FObjects:      TLMDNameHashTable;
    FPubMrsObjs:   TList;
    FChangeNumber: Integer;
  public
    constructor Create(AVM: TLMDVirtMachine);
    destructor Destroy; override;

    procedure Close;
    function  Add(const AObj: IDispatch; const AName: WideString;
                  APublishMembers: Boolean): Boolean;
    procedure UpdateContentOf(AGlobals: TLMDThreadGlobals);
    property  ChangeNumber: Integer read FChangeNumber;
  end;

  TLMDVMSourceItem = record
    Line: Integer;
    Pos:  Integer;
    Cur:  PWideChar;
  end;
  TLMDVMSourceItems = array of TLMDVMSourceItem;

  TLMDVMSource = class
  private
    FText:        WideString;
    FIndex:       TLMDVMSourceItems;
    FIndexLength: Integer;

    procedure SetText(const Value: WideString);
    procedure UpdateIndex;
    procedure AddItem(ALine, APos: Integer; ACur: PWideChar);
  public
    constructor Create; overload;
    constructor Create(const AText: WideString); overload;

    procedure Clear;
    procedure PosToLine(ASrcPos: Integer; out ALine, ALinePos: Integer); overload;
    function  PosToLine(ASrcPos: Integer): Integer; overload;
    procedure LineToPos(ALine: Integer; out ASrcPos, ALength: Integer);
    property  Text: WideString read FText write SetText;
  end;

  TLMDVMBreakpoint = class
  public
    IsUser:  Boolean;
    Threads: array of TLMDThread;
    Instr:   PLMDInstr;
    Origin:  TLMDInstrCode;
  end;

  TLMDVMGetBPInfoResult = (bpirOk, bpirCausedBreak, bpirGoThrough,
                           bpirBPRemoved, bpirNoBPInfo);
  TLMDVMBreakKind       = (bkBreakpoint, bkStep, bkCausedBreak);

  TLMDVMBreakpoints = class
  private
    FVM:      TLMDVirtMachine;
    FSection: TCriticalSection;
    FItems:   TList;
  protected
    function  FindItem(AInstr: PLMDInstr): TLMDVMBreakpoint;
    function  AddItem(AInstr: PLMDInstr): TLMDVMBreakpoint;
    procedure TryRemoveItem(AItem: TLMDVMBreakpoint);

    function  IndexOfThread(AItem: TLMDVMBreakpoint;
                            AThread: TLMDThread): Integer;
    procedure AddThread(AItem: TLMDVMBreakpoint; AThread: TLMDThread);
    procedure DeleteThread(AItem: TLMDVMBreakpoint; AIndex: Integer);

    procedure AddStepBP(AInstr: PLMDInstr; AThread: TLMDThread);
    procedure AddStepBPs(AThread: TLMDThread; AStartFrom: PLMDInstr;
                         ASkipStartLine: Boolean);
    procedure AddExcStepBPs(AThread: TLMDThread; AHandler: TLMDTry);
  public
    constructor Create(AVM: TLMDVirtMachine);
    destructor Destroy; override;

    procedure Clear;
    procedure SetUserBP(AInstr: PLMDInstr);
    procedure RemoveUserBP(AInstr: PLMDInstr);
    function  GetInfo(AThread: TLMDThread; ADebugger: TLMDVMDebugger;
                      AStepBase: PLMDFrame; ACurFrame: TLMDFrame;
                      AInstr: PLMDInstr; out ABreakKind: TLMDVMBreakKind;
                      out AOrigin: TLMDInstr): TLMDVMGetBPInfoResult;
    procedure SetStepBPs(AThread: TLMDThread; AStepBase: PLMDFrame;
                         ACurFrame: TLMDFrame; AStartFrom: PLMDInstr;
                         ASkipStartLine: Boolean);
    procedure SetExcStepBPs(AThread: TLMDThread; AStepBase: PLMDFrame;
                            ACurFrame: TLMDFrame; AHandler: TLMDTry);
    procedure RemoveStepBps(AThread: TLMDThread; AStepBase: PLMDFrame);
  end;

  PLMDVMInterpretContext = ^TLMDVMInterpretContext;
  TLMDVMInterpretContext = record
    Code:      TLMDByteCode;
    Args:      PLMDVarArray;
    Result:    POleVariant;
    Source:    TLMDVMSource;    // TLMDVMSource. Nil - means VM source.
  end;

  TLMVMDResumeKind = (rkStepOver, rkStepInto, rkContinue, rkIgnore,
                      rkAbort);

  TLMDOnIsTest          = procedure(Sender: TObject; const AObj,
                                    AType: OleVariant; var AResult: Boolean)
                                    of object;
  TLMDOnExceptionIsTest = procedure(Sender: TObject; E: Exception;
                                    AType: OleVariant; var AResult: Boolean)
                                    of object;
  TLMDOnVarToException  = procedure(Sender: TObject; const V: OleVariant;
                                    var AResult: Exception) of object;
  TLMDOnExceptionToVar  = procedure(Sender: TObject; const E: Exception;
                                    var AResult: OleVariant) of object;
  TLMDOnFormatException = procedure(Sender: TObject; ALine, ALinePos: Integer;
                                    const E: Exception) of object;
  TLMDOnEventMake       = procedure(Sender: TObject; const AProcName: WideString;
                                    var AResult: OleVariant) of object;
  TLMDOnNew             = procedure(Sender: TObject; const AType: OleVariant;
                                    AArgs: PLMDVarArray; AArgCount: Integer;
                                    var AResult: OleVariant) of object;

  TLMDVirtMachine = class(TLMDVMBase)
  private
    FState:                  TLMDVMState;
    FLanguage:               ILMDLanguage;
    FSection:                TCriticalSection;
    FId:                     TLMDVMId;
    FCodeObject:             IDispatch;
    FBreakpoints:            TLMDVMBreakpoints;
    FSource:                 TLMDVMSource;
    FScriptGlobals:          TLMDNameHashTable;
    FScriptGlobalsByDispId:  array of TLMDDispIdObject;
    FDispIdsCount:           Integer;                    // Count of items in
                                                         // FScriptGlobalsByDispId.
    FExternObjects:          TLMDExternObjects;
    FIntrinsicObjects:       TLMDNameHashTable;
    FProcedures:             TList;
    FGlobalVars:             TList;
    FGlobalConsts:           TList;
    FGlobalNamespace:        TLMDAbstractNamespace;
    FGlobalStmts:            TList;
    FGlobalByteCode:         TLMDByteCode;
    FDebugger:               TLMDVMDebugger;
    FTerminateFlag:          Integer;
    FOnIsTest:               TLMDOnIsTest;
    FOnExceptionIsTest:      TLMDOnExceptionIsTest;
    FOnVarToException:       TLMDOnVarToException;
    FOnExceptionToVar:       TLMDOnExceptionToVar;
    FOnFormatException:      TLMDOnFormatException;
    FOnEventMake:            TLMDOnEventMake;
    FOnNew:                  TLMDOnNew;

    function  GetCodeObject: IDispatch;
    procedure RaiseVMNotActive;
    procedure RaiseProcNotFound(const AStrName: WideString);
    procedure RaiseValObjNotFound(const AStrName: WideString);
    procedure AddIntrinsicProc(AObject: TLMDGlobalObject);
    function  EmitGlobalCode: TLMDByteCode;
    procedure DoClear;

    class function  GetArray(const AArray: OleVariant;
                             out AElemType: TVarType): PSafeArray;
    class procedure CreateArray(AArray: TLMDArray; AArgs: PLMDVarArray;
                                var AResult: OleVariant);
    class procedure RedimArray(ARedim: TLMDArrayRedim; var AValue: OleVariant;
                               AArgs: PLMDVarArray);
    class procedure GetArrayElem(AArray: PSafeArray; AElemType: TVarType;
                                 AIndices: PInteger; var AResult: OleVariant);
    class procedure SetArrayElem(AArray: PSafeArray; AElemType: TVarType;
                                 AIndices: PInteger; const AValue: OleVariant);

    class procedure AddValToSet(var ASet: OleVariant; AElem: Integer);
    class procedure AddRangeToSet(var ASet: OleVariant; AMinElem, AMaxElem: Integer);

    class procedure GetIndexed(AArgCount: Integer; const AIndexed: OleVariant;
                               AArgs: PLMDVarArray; var AResult: OleVariant);
    class procedure SetIndexed(var AIndexed: OleVariant; AValue: POleVariant;
                               AArgs: PLMDVarArray; AArgCount: Integer);

    class procedure InvokeDispatchPropPut(ACall: TLMDCall; const AObj: IDispatch;
                                          ADispId: Integer; AArgs: PLMDVarArray;
                                          AValue: POleVariant);
    class procedure InvokeDispatchMember(ACall: TLMDCall; const AObj: IDispatch;
                                         ADispId: Integer; AArgs: PLMDVarArray;
                                         var OleResult: OleVariant);

    class procedure InvokeMemberCall(AThread: TLMDThread; ACall: TLMDCall;
                                     ATop: POleVariant);
    class procedure InvokeAssignMemberCall(AThread: TLMDThread; ACall: TLMDCall;
                                           ATop: POleVariant);

    procedure InvokeProc(AThread: TLMDThread; ACall: TLMDCall;
                         AProc: TLMDProcObject; ATop: POleVariant);
    procedure InvokeProcNoChecks(AThread: TLMDThread; AProc: TLMDProcObject;
                                 AArgs: PLMDVarArray; var OleResult: OleVariant);

    procedure FormatException(AThread: TLMDThread; ASource: TLMDVMSource;
                              E: Exception; APos: Integer);

    function  FindBreakpointCode(ALine: Integer; out AByteCode: TLMDByteCode;
                                 out AInstr: PLMDInstr): Boolean;
    procedure HandleBreakpoint(AThread: TLMDThread; AFrame: PLMDCallStackFrame;
                               ASteppingBase: PLMDFrame;
                               ABreakKind: TLMDVMBreakKind);
    function  EvalDebug(const AExpr: WideString;
                        AFrame: PLMDCallStackFrame): OleVariant;

    procedure Interpret(AThread: TLMDThread; const ACtx: TLMDVMInterpretContext);
  public
    constructor Create(const ALanguage: ILMDLanguage);
    destructor Destroy; override;

    procedure MakeEventHandler(const AProcName: WideString;
                               var AResult: OleVariant); override;

    procedure Initialize(const ASource: WideString);
    procedure Open(ADebugger: TLMDVMDebugger = nil);
    procedure Close;
    function  AddExternObject(AObj: IDispatch; const AName: WideString;
                              APublishMembers: Boolean): Boolean;
    procedure Lock;
    procedure Unlock;
    function  RunProc(const AName: WideString): OleVariant; overload;
    function  RunProc(const AName: WideString;
                      const AArgs: array of OleVariant): OleVariant; overload;
    function  ReadVar(const AName: WideString): OleVariant;
    procedure WriteVar(const AName: WideString; const AValue: OleVariant);

    function  PrepareExpr(const AExpr: WideString): TObject;
    function  PrepareStmt(const AStmt: WideString): TObject;
    function  Eval(APreparedExpr: TObject): OleVariant; overload;
    function  Eval(const AExpr: WideString): OleVariant; overload;
    procedure ExecStmt(APreparedStmt: TObject); overload;
    procedure ExecStmt(const AStmt: WideString); overload;

    function  SetBreakpoint(ALine: Integer): Boolean;
    procedure RemoveBreakpoint(ALine: Integer);

    property State: TLMDVMState read FState;
    property CodeObject: IDispatch read GetCodeObject;
    property OnIsTest: TLMDOnIsTest read FOnIsTest write FOnIsTest;
    property OnExceptionIsTest: TLMDOnExceptionIsTest read FOnExceptionIsTest write FOnExceptionIsTest;
    property OnVarToException: TLMDOnVarToException read FOnVarToException write FOnVarToException;
    property OnExceptionToVar: TLMDOnExceptionToVar read FOnExceptionToVar write FOnExceptionToVar;
    property OnFormatException: TLMDOnFormatException read FOnFormatException write FOnFormatException;
    property OnEventMake: TLMDOnEventMake read FOnEventMake write FOnEventMake;
    property OnNew: TLMDOnNew read FOnNew write FOnNew;
  end;

  {****************************** TLMDPasDebugger *****************************}

  ILMDPasDebugVarChildren  = interface;
  TLMDPasDebugVar          = record
    Name:     WideString;
    Type_:    WideString;
    Value:    WideString;
    Children: ILMDPasDebugVarChildren; // nil, if no children.
  end;

  TLMDPasDebugVarChildProc = procedure(const AVariable: TLMDPasDebugVar;
                                       ACookie: Pointer;
                                       var AStop: Boolean) of object;

  ILMDPasDebugVarChildren = interface
    procedure Enum(AProc: TLMDPasDebugVarChildProc; ACookie: Pointer);
  end;

  TLMDPasStackFrames = class;
  TLMDPasStackFrame  = class
  private
    FOwner:       TLMDPasStackFrames;
    FFrame:       PLMDCallStackFrame;
    FCtx:         PLMDVMInterpretContext;
    FVM:          TLMDVirtMachine;
    FLine:        Integer;
    FDescription: WideString;

    procedure FillParams;
  public
    constructor Create(AOwner: TLMDPasStackFrames; AFrame: PLMDCallStackFrame);

    procedure Eval(const AExpr: WideString; out AVars: TLMDPasDebugVar); overload;
    function  Eval(const AExpr: WideString; out AValue: OleVariant): Boolean; overload;
    procedure GetVariables(out AVars: TLMDPasDebugVar);
    property  VM: TLMDVirtMachine read FVM;
    property  Description: WideString read FDescription;
    property  Line: Integer read FLine;
  end;

  TLMDPasStackFrames = class
  private
    FItems:           TList;
    FBreakedThreadId: Cardinal;

    function  GetCount: Integer;
    function  GetItems(AIndex: Integer): TLMDPasStackFrame;
    procedure Add(AFrame: PLMDCallStackFrame);
    procedure SetInBreakFlags(AThread: TLMDThread; AInBreak: Boolean);
  public
    constructor Create(ABreakedThreadId: Cardinal);
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TLMDPasStackFrame read GetItems; default;
  end;

  TLMDOnBreak = procedure(Sender: TObject; ABreakKind: TLMDVMBreakKind;
                          AVM: TLMDVirtMachine; ALine: Integer;
                          ACallStack: TLMDPasStackFrames;
                          var AResumeKind: TLMVMDResumeKind) of object;

  TLMDVMDebugger = class
  private
    FId:           Integer;
    FSection:      TCriticalSection;
    FVMs:          TList;
    FCausingBreak: Boolean;
    FOnBreak:      TLMDOnBreak;

    procedure InsertVM(AVM: TLMDVirtMachine);
    procedure RemoveVM(AVM: TLMDVirtMachine);
  protected
    function DoOnBreak(ABreakKind: TLMDVMBreakKind; AVM: TLMDVirtMachine;
                       ALine: Integer; AStack: TLMDPasStackFrames): TLMVMDResumeKind; virtual;
    function HandleBreak(AThread: TLMDThread; ABreakKind: TLMDVMBreakKind;
                         AVM: TLMDVirtMachine; ALine: Integer): TLMVMDResumeKind;
    function ResetCausingBreak: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure CauseBreak;
    property  OnBreak: TLMDOnBreak read FOnBreak write FOnBreak;
  end;

const
  opStrConcat = 20;
  opPower     = 21;
  opEqv       = 22;
  opImp       = 23;
  opCmpREQ    = 24;
  opCmpRNE    = 25;

procedure VarUnaryOp(const AArg: OleVariant; var ARes: OleVariant;
                     AOper: TVarOp);
procedure VarBinaryOp(const ALeft, ARight: OleVariant; var ARes: OleVariant;
                      AOper: TVarOp);
function  VarCompareOp(const ALeft, ARight: OleVariant; AOper: TVarOp): Boolean;
procedure VarMoveData(var ADest, ASource: OleVariant);
procedure VarAssignByRef(var ADest: OleVariant; const AValue: OleVariant);
function  VarResolveRef(const V: OleVariant): POleVariant; {$IFDEF LMDCOMP14}inline;{$ENDIF}
function  VarResolveRefNoCheck(const V: OleVariant): POleVariant;

implementation

uses
  Math, TypInfo;

type
  TBinaryOpEntry = (
    beUnknown,
    beInt_SmiSmi,
    beInt_SmiI32,
    beFlt_SmiSgl,
    beFlt_SmiDbl,
    beInt_SmiBln,
    beInt_SmiShi,
    beInt_SmiByt,
    beI64_SmiWrd,
    beI64_SmiLWd,
    beI64_SmiI64,
    beInt_I32Smi,
    beInt_I32I32,
    beFlt_I32Sgl,
    beFlt_I32Dbl,
    beInt_I32Bln,
    beInt_I32Shi,
    beInt_I32Byt,
    beI64_I32Wrd,
    beI64_I32LWd,
    beI64_I32I64,
    beFlt_SglSmi,
    beFlt_SglI32,
    beFlt_SglSgl,
    beFlt_SglDbl,
    beFlt_SglBln,
    beFlt_SglShi,
    beFlt_SglByt,
    beFlt_SglWrd,
    beFlt_SglLWd,
    beFlt_SglI64,
    beFlt_DblSmi,
    beFlt_DblI32,
    beFlt_DblSgl,
    beFlt_DblDbl,
    beFlt_DblBln,
    beFlt_DblShi,
    beFlt_DblByt,
    beFlt_DblWrd,
    beFlt_DblLWd,
    beFlt_DblI64,
    beInt_BlnSmi,
    beInt_BlnI32,
    beFlt_BlnSgl,
    beFlt_BlnDbl,
    beBln_BlnBln,
    beInt_BlnShi,
    beInt_BlnByt,
    beI64_BlnWrd,
    beI64_BlnLWd,
    beI64_BlnI64,
    beInt_ShiSmi,
    beInt_ShiI32,
    beFlt_ShiSgl,
    beFlt_ShiDbl,
    beInt_ShiBln,
    beInt_ShiShi,
    beInt_ShiByt,
    beI64_ShiWrd,
    beI64_ShiLWd,
    beI64_ShiI64,
    beInt_BytSmi,
    beInt_BytI32,
    beFlt_BytSgl,
    beFlt_BytDbl,
    beInt_BytBln,
    beInt_BytShi,
    beInt_BytByt,
    beI64_BytWrd,
    beI64_BytLWd,
    beI64_BytI64,
    beI64_WrdSmi,
    beI64_WrdI32,
    beFlt_WrdSgl,
    beFlt_WrdDbl,
    beI64_WrdBln,
    beI64_WrdShi,
    beI64_WrdByt,
    beI64_WrdWrd,
    beI64_WrdLWd,
    beI64_WrdI64,
    beI64_LWdSmi,
    beI64_LWdI32,
    beFlt_LWdSgl,
    beFlt_LWdDbl,
    beI64_LWdBln,
    beI64_LWdShi,
    beI64_LWdByt,
    beI64_LWdWrd,
    beI64_LWdLWd,
    beI64_LWdI64,
    beI64_I64Smi,
    beI64_I64I32,
    beFlt_I64Sgl,
    beFlt_I64Dbl,
    beI64_I64Bln,
    beI64_I64Shi,
    beI64_I64Byt,
    beI64_I64Wrd,
    beI64_I64LWd,
    beI64_I64I64,
    beObj_ObjObj
  );

  TSetBit = record
    Low:  DWord;
    High: DWord;
  end;

  PExcVarData = ^TExcVarData;
  TExcVarData = packed record // The size of this struct sould be  equal to
                              // two OleVariant sizes for both: x86 and x64
                              // platforms.
    VType1:     TVarType;
    Reserved1:  array[0..{$IFDEF LMDX64}6{$ELSE}4{$ENDIF}] of Word;
    Try_:       TLMDTry;

    VType2:     TVarType;
    Reserved2:  array[0..2] of Word;
    ExceptObj:  Exception;
    Next:       PExcVarData;
  end;

  PNamesArray         = ^TNamesArray;
  TNamesArray         = array [0..0] of PWideChar;
  PDispIdsArray       = ^TDispIdsArray;
  TDispIdsArray       = array [0..0] of Integer;

  TThreadGlobalsItem = class(TLMDNamedItem)
  public
    TrySearchInPubs: Boolean;
    SearchRes:       TLMDNameSearchRes;
  end;

  TCodeObjectItem = class(TLMDNamedItem)
  public
    DispId: Integer;
  end;

  {******************************** TVMIndexes ********************************}

  TVMSteppingItem = class
  public
    Thread:     TLMDThread;
    DebuggerId: Integer;
    Base:       TLMDFrame;
  end;

  TVMIndexes = class
  private
    FThreadDatas:    TList;
    FLocks:          TList;
    FSteppingItems:  TList;
    FSection:        TCriticalSection;
    FNextVMId:       Integer;
    FNextDebuggerId: Integer;

    function  GetVMNextId: Integer;
    function  GetSteppingBase(AThread: TLMDThread;
                              ALock: TLMDVMLock): PLMDFrame;
    procedure SteppingBaseGC;
    procedure ThreadDataGC;
  public
    constructor Create;
    destructor Destroy; override;

    function  AsquireId(VM: TLMDVirtMachine): TLMDVMId;
    procedure ReleaseId(const AId: TLMDVMId);
    function  InitThread(const AId: TLMDVMId): TLMDThread;

    procedure MarkOpened(const AId: TLMDVMId; ADebugger: TLMDVMDebugger);
    procedure MarkClosingAndWait(const AId: TLMDVMId);
    function  IsInactiveOrClosing(const AId: TLMDVMId): Boolean;

    function  GetNextDebuggerId: Integer;
  end;

  {************************* TGlobalObjectsNamespace **************************}

  TGlobalObjectsNamespace = class(TLMDAbstractNamespace)
  private
    FVM:        TLMDVirtMachine;
    FVMIdIndex: Integer;
  public
    constructor Create(AVM: TLMDVirtMachine);
    function    Find(AThread: Pointer; ANameIndex: Integer;
                     AStrName: PWideString): TLMDNameSearchRes; override;
    procedure   EnumDebugVars(ALocalsOnly: Boolean;
                              AProc: TLMDNamespaceEnumVarsProc); override;
  end;

  {*************************** TVMParserCallbacks **************************** }

  TVMParserCallbacks = class(ILMDParserCallbacks)
  private
    FVM: TLMDVirtMachine;

    procedure AddObjDispIdIndex(AObj: TLMDDispIdObject);
  public
    constructor Create(AVM: TLMDVirtMachine);

    function  GetNameId(const AName: WideString): Integer; override;
    procedure GlobalStmtParsed(AStmt: ILMDEmitable); override;
    procedure GlobalObjParsed(AObj: TLMDGlobalObject;
                              var ADuplicateName: Boolean); override;
    procedure UsedUnitParsed(const AName: WideString;
                             var ADuplicateName: Boolean); override;
  end;

  {************************* TVMEvalParserCallbacks ************************** }

  TVMEvalParserCallbacks = class(ILMDParserCallbacks)
  public
    function  GetNameId(const AName: WideString): Integer; override;
    procedure GlobalStmtParsed(AStmt: ILMDEmitable); override;
    procedure GlobalObjParsed(AObj: TLMDGlobalObject;
                              var ADuplicateName: Boolean); override;
    procedure UsedUnitParsed(const AName: WideString;
                             var ADuplicateName: Boolean); override;
  end;

  TPreparedDynCode = class
  private
    FVM:       TLMDVirtMachine;
    FSource:   TLMDVMSource;
    FByteCode: TLMDByteCode;
    FParsed:   ILMDEmitable;
  public
    constructor Create(AVM: TLMDVirtMachine);
    destructor Destroy; override;

    procedure PrepareExpr(const AExpr: WideString;
                          ADebugNS: TLMDAbstractNamespace = nil);
    procedure PrepareStmt(const AStmt: WideString);
  end;
    
  {**************** ILMDPasDebugVarChildren implementations *******************}

  TDebugVarUtils = class
  private
    class function GetType(const AValue: OleVariant): WideString; overload;
    class function GetType(AType: PTypeDesc): WideString; overload;
    class function GetType(AType: TVarType): WideString; overload;
    class function GetValue(const AValue: OleVariant;
                            const ALang: ILMDLanguage): WideString;
    class function GetChildren(const ALang: ILMDLanguage;
                               const AValue: OleVariant): ILMDPasDebugVarChildren;
  public
    class procedure FillVar(const AName, AType: WideString;
                            const ALang: ILMDLanguage;
                            const AValue: OleVariant;
                            out AVar: TLMDPasDebugVar);
  end;

  TStoredVarChildItems = array of TLMDPasDebugVar;
  TStoredVarChildren   = class(TInterfacedObject, ILMDPasDebugVarChildren)
  private
    FFrame: PLMDCallStackFrame;
    FItems: TStoredVarChildItems;

    procedure AddVarProc(const ADisplayName: WideString;
                         const ASRes: TLMDNameSearchRes);
  public
    class function Init(AFrame: PLMDCallStackFrame;
                        ALocalsOnly: Boolean): ILMDPasDebugVarChildren;
    procedure      Enum(AProc: TLMDPasDebugVarChildProc; ACookie: Pointer);
  end;

  TDispatchVarChildren = class(TInterfacedObject, ILMDPasDebugVarChildren)
  private
    FLang:   ILMDLanguage;
    FObject: IDispatch;

    function GetPropValue(ADispId: Integer; out AValue: OleVariant): Boolean;
  public
    constructor    Create(const ALang: ILMDLanguage; const AObject: IDispatch);
    class function HasChildProps(const AObject: IDispatch): Boolean;
    procedure      Enum(AProc: TLMDPasDebugVarChildProc; ACookie: Pointer);
  end;

  TArrayVarIndices  = array of Integer;
  TArrayVarChildren = class(TInterfacedObject, ILMDPasDebugVarChildren)
  private
    FLang:     ILMDLanguage;
    FArray:    OleVariant;
    FDim:      Integer;
    FIndices:  TArrayVarIndices;
    FElemType: WideString;

    function InitIndices(ADimCount: Integer): TArrayVarIndices;
    function InitElemType(const AArray: OleVariant): WideString;
  public
    constructor    Create(const ALang: ILMDLanguage;
                          const AArray: OleVariant); overload;
    constructor    Create(const ALang: ILMDLanguage;
                          const AArray: OleVariant; ADim: Integer;
                          AIndices: TArrayVarIndices); overload;
    class function HasChildProps(const AArray: OleVariant): Boolean;
    procedure      Enum(AProc: TLMDPasDebugVarChildProc; ACookie: Pointer);
  end;

  {*************************** TDebugVarsNamespace ****************************}

  TDebugVarsNSItem = record
    Name: Integer;
    Var_: POleVariant;
  end;

  TDebugVarsNamespace = class(TLMDAbstractNamespace)
  private
    FFrame:  PLMDCallStackFrame;
  public
    constructor Create(AFrame: PLMDCallStackFrame);
    function    Find(AThread: Pointer; AName: Integer;
                     AStrName: PWideString): TLMDNameSearchRes; override;
    procedure   EnumDebugVars(ALocalsOnly: Boolean;
                              AProc: TLMDNamespaceEnumVarsProc); override;
  end;

{------------------------------------------------------------------------------}
const
  GUID_NULL: TGUID        = '{00000000-0000-0000-0000-000000000000}';
  VM_GUID:   TGUID        = '{E298CC73-406C-418B-A455-E8AFC284156C}';
  MAX_ARG_COUNT           = 64;
  MAX_ARRAY_BOUNDS        = 60; // As in MS VbScript.
  SRC_CHARSPRESITEM_SHIFT = 5;
  SRC_CHARSPRESITEM       = 1 shl SRC_CHARSPRESITEM_SHIFT;
  STEP_STOPATANY          = 0;
  STEP_NOSTOP             = {$IFDEF LMDX64}$FFFFFFFFFFFFFFFF{$ELSE}$FFFFFFFF{$ENDIF};
  VSIZE                   = SizeOf(OleVariant);
  VARTYPE_MAX             = varInt64;
  VARDEEPDATA             = $BFE8;

  BINARY_ENTRIES: array[0..VARTYPE_MAX, 0..VARTYPE_MAX] of TBinaryOpEntry =
  (
    { varEmpty }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beUnknown,          // varSmallint
      beUnknown,          // varInteger
      beUnknown,          // varSingle
      beUnknown,          // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beUnknown,          // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beUnknown,          // varShortInt
      beUnknown,          // varByte
      beUnknown,          // varWord
      beUnknown,          // varLongWord
      beUnknown           // varInt64
    ),
    { varNull }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beUnknown,          // varSmallint
      beUnknown,          // varInteger
      beUnknown,          // varSingle
      beUnknown,          // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beUnknown,          // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beUnknown,          // varShortInt
      beUnknown,          // varByte
      beUnknown,          // varWord
      beUnknown,          // varLongWord
      beUnknown           // varInt64
    ),
    { varSmallint }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beInt_SmiSmi,       // varSmallint
      beInt_SmiI32,       // varInteger
      beFlt_SmiSgl,       // varSingle
      beFlt_SmiDbl,       // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beInt_SmiBln,       // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beInt_SmiShi,       // varShortInt
      beInt_SmiByt,       // varByte
      beI64_SmiWrd,       // varWord
      beI64_SmiLWd,       // varLongWord
      beI64_SmiI64        // varInt64
    ),
    { varInteger }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beInt_I32Smi,       // varSmallint
      beInt_I32I32,       // varInteger
      beFlt_I32Sgl,       // varSingle
      beFlt_I32Dbl,       // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beInt_I32Bln,       // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beInt_I32Shi,       // varShortInt
      beInt_I32Byt,       // varByte
      beI64_I32Wrd,       // varWord
      beI64_I32LWd,       // varLongWord
      beI64_I32I64        // varInt64
    ),
    { varSingle }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beFlt_SglSmi,       // varSmallint
      beFlt_SglI32,       // varInteger
      beFlt_SglSgl,       // varSingle
      beFlt_SglDbl,       // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beFlt_SglBln,       // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beFlt_SglShi,       // varShortInt
      beFlt_SglByt,       // varByte
      beFlt_SglWrd,       // varWord
      beFlt_SglLWd,       // varLongWord
      beFlt_SglI64        // varInt64
    ),
    { varDouble }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beFlt_DblSmi,       // varSmallint
      beFlt_DblI32,       // varInteger
      beFlt_DblSgl,       // varSingle
      beFlt_DblDbl,       // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beFlt_DblBln,       // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beFlt_DblShi,       // varShortInt
      beFlt_DblByt,       // varByte
      beFlt_DblWrd,       // varWord
      beFlt_DblLWd,       // varLongWord
      beFlt_DblI64        // varInt64
    ),
    { varCurrency }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beUnknown,          // varSmallint
      beUnknown,          // varInteger
      beUnknown,          // varSingle
      beUnknown,          // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beUnknown,          // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beUnknown,          // varShortInt
      beUnknown,          // varByte
      beUnknown,          // varWord
      beUnknown,          // varLongWord
      beUnknown           // varInt64
    ),
    { varDate }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beUnknown,          // varSmallint
      beUnknown,          // varInteger
      beUnknown,          // varSingle
      beUnknown,          // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beUnknown,          // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beUnknown,          // varShortInt
      beUnknown,          // varByte
      beUnknown,          // varWord
      beUnknown,          // varLongWord
      beUnknown           // varInt64
    ),
    { varOleStr }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beUnknown,          // varSmallint
      beUnknown,          // varInteger
      beUnknown,          // varSingle
      beUnknown,          // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beUnknown,          // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beUnknown,          // varShortInt
      beUnknown,          // varByte
      beUnknown,          // varWord
      beUnknown,          // varLongWord
      beUnknown           // varInt64
    ),
    { varDispatch }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beUnknown,          // varSmallint
      beUnknown,          // varInteger
      beUnknown,          // varSingle
      beUnknown,          // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beObj_ObjObj,       // varDispatch
      beUnknown,          // varError
      beUnknown,          // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beUnknown,          // varShortInt
      beUnknown,          // varByte
      beUnknown,          // varWord
      beUnknown,          // varLongWord
      beUnknown           // varInt64
    ),
    { varError }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beUnknown,          // varSmallint
      beUnknown,          // varInteger
      beUnknown,          // varSingle
      beUnknown,          // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beUnknown,          // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beUnknown,          // varShortInt
      beUnknown,          // varByte
      beUnknown,          // varWord
      beUnknown,          // varLongWord
      beUnknown           // varInt64
    ),
    { varBoolean }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beInt_BlnSmi,       // varSmallint
      beInt_BlnI32,       // varInteger
      beFlt_BlnSgl,       // varSingle
      beFlt_BlnDbl,       // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beBln_BlnBln,       // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beInt_BlnShi,       // varShortInt
      beInt_BlnByt,       // varByte
      beI64_BlnWrd,       // varWord
      beI64_BlnLWd,       // varLongWord
      beI64_BlnI64        // varInt64
    ),
    { varVariant }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beUnknown,          // varSmallint
      beUnknown,          // varInteger
      beUnknown,          // varSingle
      beUnknown,          // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beUnknown,          // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beUnknown,          // varShortInt
      beUnknown,          // varByte
      beUnknown,          // varWord
      beUnknown,          // varLongWord
      beUnknown           // varInt64
    ),
    { varUnknown }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beUnknown,          // varSmallint
      beUnknown,          // varInteger
      beUnknown,          // varSingle
      beUnknown,          // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beUnknown,          // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beUnknown,          // varShortInt
      beUnknown,          // varByte
      beUnknown,          // varWord
      beUnknown,          // varLongWord
      beUnknown           // varInt64
    ),
    { varDecimal }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beUnknown,          // varSmallint
      beUnknown,          // varInteger
      beUnknown,          // varSingle
      beUnknown,          // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beUnknown,          // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beUnknown,          // varShortInt
      beUnknown,          // varByte
      beUnknown,          // varWord
      beUnknown,          // varLongWord
      beUnknown           // varInt64
    ),
    { varUndef0F }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beUnknown,          // varSmallint
      beUnknown,          // varInteger
      beUnknown,          // varSingle
      beUnknown,          // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beUnknown,          // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beUnknown,          // varShortInt
      beUnknown,          // varByte
      beUnknown,          // varWord
      beUnknown,          // varLongWord
      beUnknown           // varInt64
    ),
    { varShortInt }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beInt_ShiSmi,       // varSmallint
      beInt_ShiI32,       // varInteger
      beFlt_ShiSgl,       // varSingle
      beFlt_ShiDbl,       // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beInt_ShiBln,       // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beInt_ShiShi,       // varShortInt
      beInt_ShiByt,       // varByte
      beI64_ShiWrd,       // varWord
      beI64_ShiLWd,       // varLongWord
      beI64_ShiI64        // varInt64
    ),
    { varByte }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beInt_BytSmi,       // varSmallint
      beInt_BytI32,       // varInteger
      beFlt_BytSgl,       // varSingle
      beFlt_BytDbl,       // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beInt_BytBln,       // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beInt_BytShi,       // varShortInt
      beInt_BytByt,       // varByte
      beI64_BytWrd,       // varWord
      beI64_BytLWd,       // varLongWord
      beI64_BytI64        // varInt64
    ),
    { varWord }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beI64_WrdSmi,       // varSmallint
      beI64_WrdI32,       // varInteger
      beFlt_WrdSgl,       // varSingle
      beFlt_WrdDbl,       // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beI64_WrdBln,       // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beI64_WrdShi,       // varShortInt
      beI64_WrdByt,       // varByte
      beI64_WrdWrd,       // varWord
      beI64_WrdLWd,       // varLongWord
      beI64_WrdI64        // varInt64
    ),
    { varLongWord }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beI64_LWdSmi,       // varSmallint
      beI64_LWdI32,       // varInteger
      beFlt_LWdSgl,       // varSingle
      beFlt_LWdDbl,       // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beI64_LWdBln,       // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beI64_LWdShi,       // varShortInt
      beI64_LWdByt,       // varByte
      beI64_LWdWrd,       // varWord
      beI64_LWdLWd,       // varLongWord
      beI64_LWdI64        // varInt64
    ),
    { varInt64 }
    (
      beUnknown,          // varEmpty
      beUnknown,          // varNull
      beI64_I64Smi,       // varSmallint
      beI64_I64I32,       // varInteger
      beFlt_I64Sgl,       // varSingle
      beFlt_I64Dbl,       // varDouble
      beUnknown,          // varCurrency
      beUnknown,          // varDate
      beUnknown,          // varOleStr
      beUnknown,          // varDispatch
      beUnknown,          // varError
      beI64_I64Bln,       // varBoolean
      beUnknown,          // varVariant
      beUnknown,          // varUnknown
      beUnknown,          // varDecimal
      beUnknown,          // varUndef0F
      beI64_I64Shi,       // varShortInt
      beI64_I64Byt,       // varByte
      beI64_I64Wrd,       // varWord
      beI64_I64LWd,       // varLongWord
      beI64_I64I64        // varInt64
    )
  );

{------------------------------------------------------------------------------}
var
  SET_BITS:    array[0..31] of TSetBit;
  VMIndexes:   TVMIndexes;
  EvalCbs:     TVMEvalParserCallbacks;
  NoStopSteps: TLMDFrame;

threadvar
  ThreadData: TLMDThreadData;

{------------------------------------------------------------------------------}

{$IFDEF LMDX64}
function InterlockedCompareExchange(var Target: Integer;
  Exchange: Integer; Comparand: Integer): Integer;
asm
      .NOFRAME
      MOV     EAX,R8d
 LOCK CMPXCHG [RCX].Integer,EDX
end;
{$ELSE}
function InterlockedCompareExchange(var Target: Integer;
  Exchange: Integer; Comparand: Integer): Integer;
asm
      XCHG    EAX,ECX
 LOCK CMPXCHG [ECX],EDX
end;
{$ENDIF}

{------------------------------------------------------------------------------}
procedure InitSetBits;
var
  i, j:      Integer;
  Low, High: DWord;
begin
  for i := 0 to 31 do
  begin
    Low  := 0;
    High := 0;
    for j := 0 to i do
      High := High or (1 shl j);
    for j := 0 to i - 1 do
      Low := Low or (1 shl j);

    SET_BITS[i].Low  := Low;
    SET_BITS[i].High := High;
  end;
end;
       
{------------------------------------------------------------------------------}
procedure UnwindTo(var AExcList: PExcVarData;
  ACurExc: Exception; AToId: Integer);
var
  cur: PExcVarData;
begin
  cur := AExcList;

  while (cur <> nil) and ((cur.Try_.HdrHierLow > AToId) or
                          (cur.Try_.HdrHierHigh < AToId)) do
  begin
    if cur.ExceptObj <> ACurExc then
      cur.ExceptObj.Free;
    cur := cur.Next;
  end;

  AExcList := cur;  
end;

{------------------------------------------------------------------------------}
procedure Unwind(var AExcList: PExcVarData;
  ACurExc: Exception); 
var
  cur: PExcVarData;
begin
  cur      := AExcList;
  AExcList := nil;
  
  while cur <> nil do
  begin
    if cur.ExceptObj <> ACurExc then
      cur.ExceptObj.Free;
    cur := cur.Next;
  end;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarAdd(const ALeft, ARight: OleVariant; var ARes: OleVariant);
begin
  ARes := ALeft + ARight;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarSubtract(const ALeft, ARight: OleVariant; var ARes: OleVariant);
begin
  ARes := ALeft - ARight;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarMultiply(const ALeft, ARight: OleVariant; var ARes: OleVariant);
begin
  ARes := ALeft * ARight;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarDivide(const ALeft, ARight: OleVariant; var ARes: OleVariant);
begin
  ARes := ALeft / ARight;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarIntDivide(const ALeft, ARight: OleVariant; var ARes: OleVariant);
begin
  ARes := ALeft div ARight;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarModulus(const ALeft, ARight: OleVariant; var ARes: OleVariant);
begin
  ARes := ALeft mod ARight;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarShiftLeft(const ALeft, ARight: OleVariant; var ARes: OleVariant);
begin
  ARes := ALeft shl ARight;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarShiftRight(const ALeft, ARight: OleVariant; var ARes: OleVariant);
begin
  ARes := ALeft shr ARight;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarAnd(const ALeft, ARight: OleVariant; var ARes: OleVariant);
begin
  ARes := ALeft and ARight;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarOr(const ALeft, ARight: OleVariant; var ARes: OleVariant);
begin
  ARes := ALeft or ARight;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarXor(const ALeft, ARight: OleVariant; var ARes: OleVariant);
begin
  ARes := ALeft xor ARight;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarStrConcat(const ALeft, ARight: OleVariant;
  var ARes: OleVariant);
var
  s1, s2: WideString;
begin
  // Null and Empty cannot be varByRef, otherwise implicit
  // conversion to string will process varByRefs.

  case TVarData(ALeft).VType of
    varNull,
    varEmpty: s1 := '';
  else
    s1 := ALeft;
  end;

  case TVarData(ARight).VType of
    varNull,
    varEmpty: s2 := '';
  else
    s2 := ARight;
  end;

  ARes := s1 + s2;
end;

{-----------------------------------------------------------------------------}

procedure _StdVarPower(const ALeft, ARight: OleVariant;
  var ARes: OleVariant);
begin
  ARes := Power(Double(ALeft), Double(ARight));
end;

{-----------------------------------------------------------------------------}

procedure _StdVarEqv(const ALeft, ARight: OleVariant; var ARes: OleVariant);
type
  TExprType = (etNull, etBool, etNumeric);
  TResType  = (rtNull, rtNum, rtBool);
const
  EXPR_TYPES: array[0..VARTYPE_MAX] of TExprType = (
    etNumeric, // varEmpty
    etNull,    // varNull
    etNumeric, // varSmallint
    etNumeric, // varInteger
    etNumeric, // varSingle
    etNumeric, // varDouble
    etNumeric, // varCurrency
    etNumeric, // varDate
    etNumeric, // varOleStr
    etNumeric, // varDispatch
    etNumeric, // varError
    etBool,    // varBoolean
    etNumeric, // varVariant
    etNumeric, // varUnknown
    etNumeric, // varDecimal
    etNumeric, // varUndef0F
    etNumeric, // varShortInt
    etNumeric, // varByte
    etNumeric, // varWord
    etNumeric, // varLongWord
    etNumeric  // varInt64
  );
  IMP_TYPES: array[TExprType, TExprType] of TResType = (
    { etNull }
    (
      rtNull,      // etNull
      rtNull,      // etBool
      rtNull       // etNumeric
    ),
    { etBool }
    (
      rtNull,      // etNull
      rtBool,      // etBool
      rtNum        // etNumeric
    ),
    { etNumeric }
    (
      rtNull,      // etNull
      rtNum,       // etBool
      rtNum        // etNumeric
    )
  );
label
  LError;
var
  ldt, rdt: PVarData;
begin
  ldt := @TVarData(ALeft);
  rdt := @TVarData(ARight);

  if ldt.VType > VARTYPE_MAX then
  begin
    ldt := PVarData(VarResolveRef(OleVariant(ldt^)));
    if ldt.VType > VARTYPE_MAX then
      goto LError;
  end;

  if rdt.VType > VARTYPE_MAX then
  begin
    rdt := PVarData(VarResolveRef(OleVariant(rdt^)));
    if rdt.VType > VARTYPE_MAX then
      goto LError;
  end;

  case IMP_TYPES[EXPR_TYPES[ldt.VType], EXPR_TYPES[rdt.VType]] of
    rtNull:   ARes := OleNull;
    rtNum:    ARes := not (Integer(ALeft) xor Integer(ARight));
    rtBool:   ARes := (ldt.VBoolean = rdt.VBoolean);
  else
LError:
    VarCastError;
  end;
end;

{-----------------------------------------------------------------------------}

procedure _StdVarImp(const ALeft, ARight: OleVariant; var ARes: OleVariant);
type
  TExprType = (etNull, etBool, etNumeric);
  TResType  = (rtNum, rtBool, rtNullNum, rtNullBool);
const
  EXPR_TYPES: array[0..VARTYPE_MAX] of TExprType = (
    etNumeric, // varEmpty
    etNull,    // varNull
    etNumeric, // varSmallint
    etNumeric, // varInteger
    etNumeric, // varSingle
    etNumeric, // varDouble
    etNumeric, // varCurrency
    etNumeric, // varDate
    etNumeric, // varOleStr
    etNumeric, // varDispatch
    etNumeric, // varError
    etBool,    // varBoolean
    etNumeric, // varVariant
    etNumeric, // varUnknown
    etNumeric, // varDecimal
    etNumeric, // varUndef0F
    etNumeric, // varShortInt
    etNumeric, // varByte
    etNumeric, // varWord
    etNumeric, // varLongWord
    etNumeric  // varInt64
  );
  IMP_TYPES: array[TExprType, TExprType] of TResType = (
    { etNull }
    (
      rtNullNum,    // etNull
      rtNullBool,   // etBool
      rtNullNum     // etNumeric
    ),
    { etBool }
    (
      rtNullBool,   // etNull
      rtBool,       // etBool
      rtNum         // etNumeric
    ),
    { etNumeric }
    (
      rtNullNum,    // etNull
      rtNum,        // etBool
      rtNum         // etNumeric
    )
  );
  BOOLS: array[Boolean] of Integer = (0, Integer($FFFFFFFF));
label
  LError;
var
  ldt, rdt:    PVarData;
  lv, rv, res: Integer;
begin
  ldt := @TVarData(ALeft);
  rdt := @TVarData(ARight);

  if ldt.VType > VARTYPE_MAX then
  begin
    ldt := PVarData(VarResolveRef(OleVariant(ldt^)));
    if ldt.VType > VARTYPE_MAX then
      goto LError;
  end;

  if rdt.VType > VARTYPE_MAX then
  begin
    rdt := PVarData(VarResolveRef(OleVariant(rdt^)));
    if rdt.VType > VARTYPE_MAX then
      goto LError;
  end;

  case ldt.VType of
    varNull:    lv := BOOLS[True];
    varBoolean: lv := BOOLS[ldt.VBoolean];
  else
    lv := Integer(ALeft);
  end;

  case rdt.VType of
    varNull:    rv := 0;
    varBoolean: rv := BOOLS[rdt.VBoolean];
  else
    rv := Integer(ARight);
  end;

  res := not (lv xor rv) or rv;

  case IMP_TYPES[EXPR_TYPES[ldt.VType], EXPR_TYPES[rdt.VType]] of
    rtNum:        ARes := res;
    rtBool:       ARes := (res <> 0);
    rtNullNum:    if res = 0 then
                    ARes := OleNull
                  else
                    ARes := res;
    rtNullBool:   if res = 0 then
                    ARes := OleNull
                  else
                    ARes := (res <> 0);
  else
LError:
    VarCastError;
  end;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarUnaryNegate(const AArg: OleVariant; var ARes: OleVariant);
begin
  ARes := -AArg;
end;

{-----------------------------------------------------------------------------}
procedure _StdVarUnaryNot(const AArg: OleVariant; var ARes: OleVariant);
begin
  ARes := not AArg;
end;

{-----------------------------------------------------------------------------}
{$WARNINGS OFF}
procedure VarBinaryOp(const ALeft, ARight: OleVariant; var ARes: OleVariant;
  AOper: TVarOp);
type
  TValue = record
    case Integer of
      0: (Bln: Boolean);
      1: (Int: Integer);
      2: (Flt: Double);
      3: (I64: Int64);
      4: (Obj: Pointer);
  end;
label
  LUnknown, L_Int, L_Bln, L_Flt, L_I64, L_Obj;
var
  L, R:         TValue;
  ldata, rdata: PVarData;
  overflow:     Boolean;
begin
  ldata := @TVarData(ALeft);
  rdata := @TVarData(ARight);

  if ldata.VType > VARTYPE_MAX then
  begin
    ldata := PVarData(VarResolveRef(OleVariant(ldata^)));
    if ldata.VType > VARTYPE_MAX then
      goto LUnknown;
  end;

  if rdata.VType > VARTYPE_MAX then
  begin
    rdata := PVarData(VarResolveRef(OleVariant(rdata^)));
    if rdata.VType > VARTYPE_MAX then
      goto LUnknown;
  end;

  case BINARY_ENTRIES[ldata.VType, rdata.VType] of
    beInt_SmiSmi:     begin
                        L.Int := ldata.VSmallint;
                        R.Int := rdata.VSmallint;
                        goto L_Int;
                      end;
    beInt_SmiI32:     begin
                        L.Int := ldata.VSmallint;
                        R.Int := rdata.VInteger;
                        goto L_Int;
                      end;
    beFlt_SmiSgl:     begin
                        L.Flt := ldata.VSmallint;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_SmiDbl:     begin
                        L.Flt := ldata.VSmallint;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beInt_SmiBln:     begin
                        L.Int := ldata.VSmallint;
                        R.Int := Integer(rdata.VBoolean);
                        goto L_Int;
                      end;
    beInt_SmiShi:     begin
                        L.Int := ldata.VSmallint;
                        R.Int := rdata.VShortInt;
                        goto L_Int;
                      end;
    beInt_SmiByt:     begin
                        L.Int := ldata.VSmallint;
                        R.Int := rdata.VByte;
                        goto L_Int;
                      end;
    beI64_SmiWrd:     begin
                        L.I64 := ldata.VSmallint;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_SmiLWd:     begin
                        L.I64 := ldata.VSmallint;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_SmiI64:     begin
                        L.I64 := ldata.VSmallint;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beInt_I32Smi:     begin
                        L.Int := ldata.VInteger;
                        R.Int := rdata.VSmallint;
                        goto L_Int;
                      end;
    beInt_I32I32:     begin
                        L.Int := ldata.VInteger;
                        R.Int := rdata.VInteger;
                        goto L_Int;
                      end;
    beFlt_I32Sgl:     begin
                        L.Flt := ldata.VInteger;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_I32Dbl:     begin
                        L.Flt := ldata.VInteger;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beInt_I32Bln:     begin
                        L.Int := ldata.VInteger;
                        R.Int := Integer(rdata.VBoolean);
                        goto L_Int;
                      end;
    beInt_I32Shi:     begin
                        L.Int := ldata.VInteger;
                        R.Int := rdata.VShortInt;
                        goto L_Int;
                      end;
    beInt_I32Byt:     begin
                        L.Int := ldata.VInteger;
                        R.Int := rdata.VByte;
                        goto L_Int;
                      end;
    beI64_I32Wrd:     begin
                        L.I64 := ldata.VInteger;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_I32LWd:     begin
                        L.I64 := ldata.VInteger;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_I32I64:     begin
                        L.I64 := ldata.VInteger;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beFlt_SglSmi:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VSmallint;
                        goto L_Flt;
                      end;
    beFlt_SglI32:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VInteger;
                        goto L_Flt;
                      end;
    beFlt_SglSgl:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_SglDbl:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beFlt_SglBln:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := Integer(rdata.VBoolean);
                        goto L_Flt;
                      end;
    beFlt_SglShi:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VShortInt;
                        goto L_Flt;
                      end;
    beFlt_SglByt:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VByte;
                        goto L_Flt;
                      end;
    beFlt_SglWrd:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VWord;
                        goto L_Flt;
                      end;
    beFlt_SglLWd:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VLongWord;
                        goto L_Flt;
                      end;
    beFlt_SglI64:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VInt64;
                        goto L_Flt;
                      end;
    beFlt_DblSmi:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VSmallint;
                        goto L_Flt;
                      end;
    beFlt_DblI32:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VInteger;
                        goto L_Flt;
                      end;
    beFlt_DblSgl:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_DblDbl:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beFlt_DblBln:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := Integer(rdata.VBoolean);
                        goto L_Flt;
                      end;
    beFlt_DblShi:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VShortInt;
                        goto L_Flt;
                      end;
    beFlt_DblByt:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VByte;
                        goto L_Flt;
                      end;
    beFlt_DblWrd:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VWord;
                        goto L_Flt;
                      end;
    beFlt_DblLWd:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VLongWord;
                        goto L_Flt;
                      end;
    beFlt_DblI64:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VInt64;
                        goto L_Flt;
                      end;
    beInt_BlnSmi:     begin
                        L.Int := Integer(ldata.VBoolean);
                        R.Int := rdata.VSmallint;
                        goto L_Int;
                      end;
    beInt_BlnI32:     begin
                        L.Int := Integer(ldata.VBoolean);
                        R.Int := rdata.VInteger;
                        goto L_Int;
                      end;
    beFlt_BlnSgl:     begin
                        L.Flt := Integer(ldata.VBoolean);
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_BlnDbl:     begin
                        L.Flt := Integer(ldata.VBoolean);
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beBln_BlnBln:     begin
                        L.Bln := ldata.VBoolean;
                        R.Bln := rdata.VBoolean;
                        goto L_Bln;
                      end;
    beInt_BlnShi:     begin
                        L.Int := Integer(ldata.VBoolean);
                        R.Int := rdata.VShortInt;
                        goto L_Int;
                      end;
    beInt_BlnByt:     begin
                        L.Int := Integer(ldata.VBoolean);
                        R.Int := rdata.VByte;
                        goto L_Int;
                      end;
    beI64_BlnWrd:     begin
                        L.I64 := Integer(ldata.VBoolean);
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_BlnLWd:     begin
                        L.I64 := Integer(ldata.VBoolean);
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_BlnI64:     begin
                        L.I64 := Integer(ldata.VBoolean);
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beInt_ShiSmi:     begin
                        L.Int := ldata.VShortInt;
                        R.Int := rdata.VSmallint;
                        goto L_Int;
                      end;
    beInt_ShiI32:     begin
                        L.Int := ldata.VShortInt;
                        R.Int := rdata.VInteger;
                        goto L_Int;
                      end;
    beFlt_ShiSgl:     begin
                        L.Flt := ldata.VShortInt;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_ShiDbl:     begin
                        L.Flt := ldata.VShortInt;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beInt_ShiBln:     begin
                        L.Int := ldata.VShortInt;
                        R.Int := Integer(rdata.VBoolean);
                        goto L_Int;
                      end;
    beInt_ShiShi:     begin
                        L.Int := ldata.VShortInt;
                        R.Int := rdata.VShortInt;
                        goto L_Int;
                      end;
    beInt_ShiByt:     begin
                        L.Int := ldata.VShortInt;
                        R.Int := rdata.VByte;
                        goto L_Int;
                      end;
    beI64_ShiWrd:     begin
                        L.I64 := ldata.VShortInt;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_ShiLWd:     begin
                        L.I64 := ldata.VShortInt;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_ShiI64:     begin
                        L.I64 := ldata.VShortInt;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beInt_BytSmi:     begin
                        L.Int := ldata.VByte;
                        R.Int := rdata.VSmallint;
                        goto L_Int;
                      end;
    beInt_BytI32:     begin
                        L.Int := ldata.VByte;
                        R.Int := rdata.VInteger;
                        goto L_Int;
                      end;
    beFlt_BytSgl:     begin
                        L.Flt := ldata.VByte;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_BytDbl:     begin
                        L.Flt := ldata.VByte;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beInt_BytBln:     begin
                        L.Int := ldata.VByte;
                        R.Int := Integer(rdata.VBoolean);
                        goto L_Int;
                      end;
    beInt_BytShi:     begin
                        L.Int := ldata.VByte;
                        R.Int := rdata.VShortInt;
                        goto L_Int;
                      end;
    beInt_BytByt:     begin
                        L.Int := ldata.VByte;
                        R.Int := rdata.VByte;
                        goto L_Int;
                      end;
    beI64_BytWrd:     begin
                        L.I64 := ldata.VByte;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_BytLWd:     begin
                        L.I64 := ldata.VByte;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_BytI64:     begin
                        L.I64 := ldata.VByte;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beI64_WrdSmi:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VSmallint;
                        goto L_I64;
                      end;
    beI64_WrdI32:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VInteger;
                        goto L_I64;
                      end;
    beFlt_WrdSgl:     begin
                        L.Flt := ldata.VWord;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_WrdDbl:     begin
                        L.Flt := ldata.VWord;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beI64_WrdBln:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := Integer(rdata.VBoolean);
                        goto L_I64;
                      end;
    beI64_WrdShi:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VShortInt;
                        goto L_I64;
                      end;
    beI64_WrdByt:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VByte;
                        goto L_I64;
                      end;
    beI64_WrdWrd:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_WrdLWd:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_WrdI64:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beI64_LWdSmi:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VSmallint;
                        goto L_I64;
                      end;
    beI64_LWdI32:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VInteger;
                        goto L_I64;
                      end;
    beFlt_LWdSgl:     begin
                        L.Flt := ldata.VLongWord;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_LWdDbl:     begin
                        L.Flt := ldata.VLongWord;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beI64_LWdBln:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := Integer(rdata.VBoolean);
                        goto L_I64;
                      end;
    beI64_LWdShi:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VShortInt;
                        goto L_I64;
                      end;
    beI64_LWdByt:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VByte;
                        goto L_I64;
                      end;
    beI64_LWdWrd:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_LWdLWd:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_LWdI64:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beI64_I64Smi:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VSmallint;
                        goto L_I64;
                      end;
    beI64_I64I32:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VInteger;
                        goto L_I64;
                      end;
    beFlt_I64Sgl:     begin
                        L.Flt := ldata.VInt64;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_I64Dbl:     begin
                        L.Flt := ldata.VInt64;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beI64_I64Bln:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := Integer(rdata.VBoolean);
                        goto L_I64;
                      end;
    beI64_I64Shi:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VShortInt;
                        goto L_I64;
                      end;
    beI64_I64Byt:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VByte;
                        goto L_I64;
                      end;
    beI64_I64Wrd:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_I64LWd:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_I64I64:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
  else
    goto LUnknown;
  end;

L_Flt:

  case AOper of
    opAdd        :  L.Flt := L.Flt + R.Flt;
    opSubtract   :  L.Flt := L.Flt - R.Flt;
    opMultiply   :  L.Flt := L.Flt * R.Flt;
    opDivide     :  L.Flt := L.Flt / R.Flt;
  else
    goto LUnknown;
  end;

  if (TVarData(ARes).VType and VARDEEPDATA) <> 0 then
    VarClear(ARes);
  TVarData(ARes).VType    := varDouble;
  TVarData(ARes).VDouble  := L.Flt;
  Exit;

L_I64:

  case AOper of
    opAdd, opSubtract, opMultiply:
    begin
      overflow := False;
      {$RANGECHECKS ON}
      try
        case AOper of
          opAdd      : L.I64 := L.I64 + R.I64;
          opSubtract : L.I64 := L.I64 - R.I64;
          opMultiply : L.I64 := L.I64 * R.I64;
        end;
      except
        on SysUtils.EOverflow do
          overflow := True;
        else
          raise;
      end;
      {$RANGECHECKS OFF}

      if overflow then
        goto LUnknown;
    end;

    opDivide     : goto LUnknown;
    opIntDivide  : L.I64 := L.I64 div R.I64;
    opModulus    : L.I64 := L.I64 mod R.I64;
    opShiftLeft  : L.I64 := L.I64 shl R.I64;
    opShiftRight : L.I64 := L.I64 shr R.I64;
    opAnd        : L.I64 := L.I64 and R.I64;
    opOr         : L.I64 := L.I64 or  R.I64;
    opXor        : L.I64 := L.I64 xor R.I64;
    opEqv        : L.I64 := not (L.I64 xor R.I64);
    opImp        : L.I64 := not (L.I64 xor R.I64) or R.I64;
  else
    goto LUnknown;
  end;

  if (TVarData(ARes).VType and VARDEEPDATA) <> 0 then
    VarClear(ARes);
  TVarData(ARes).VType    := varInt64;
  TVarData(ARes).VInt64   := L.I64;
  Exit;

L_Bln:

  case AOper of
    opAnd  : L.Bln := L.Bln and R.Bln;
    opOr   : L.Bln := L.Bln or  R.Bln;
    opXor  : L.Bln := L.Bln xor R.Bln;
    opEqv  : L.Bln := L.Bln = R.Bln;
    opImp  : L.Bln := (L.Bln = R.Bln) or R.Bln;
  else
    L.Int  := Integer(L.Bln);
    R.Int := Integer(R.Bln);
    goto L_Int;
  end;

  if (TVarData(ARes).VType and VARDEEPDATA) <> 0 then
    VarClear(ARes);
  TVarData(ARes).VType    := varBoolean;
  TVarData(ARes).VBoolean := L.Bln;
  Exit;

L_Int:

  case AOper of
    opAdd        : {$IFDEF LMDX64}
                   begin
                     L.I64 := Int64(L.Int) + Int64(R.Int);
                     if L.I64 <> Integer(L.I64) then
                       goto LUnknown; // Overflow
                     L.Int := Integer(L.I64);
                   end;
                   {$ELSE}
                   asm
                     MOV  EAX, L.Int
                     MOV  EDX, R.Int
                     ADD  EAX, EDX
                     JO   LUnknown // SETO Overflow
                     MOV  L.Int, EAX
                   end;
                   {$ENDIF}
    opSubtract   : {$IFDEF LMDX64}
                   begin
                     L.I64 := Int64(L.Int) - Int64(R.Int);
                     if L.I64 <> Integer(L.I64) then
                       goto LUnknown; // Overflow
                     L.Int := Integer(L.I64);
                   end;
                   {$ELSE}
                   asm
                     MOV  EAX, L.Int
                     MOV  EDX, R.Int
                     SUB  EAX, EDX
                     JO   LUnknown // SETO Overflow
                     MOV  L.Int, EAX
                   end;
                   {$ENDIF}
    opMultiply   : {$IFDEF LMDX64}
                   begin
                     L.I64 := Int64(L.Int) * Int64(R.Int);
                     if L.I64 <> Integer(L.I64) then
                       goto LUnknown; // Overflow
                     L.Int := Integer(L.I64);
                   end;
                   {$ELSE}
                   asm
                     MOV  EAX, L.Int
                     MOV  EDX, R.Int
                     IMUL EDX
                     JO   LUnknown // SETO Overflow
                     MOV  L.Int, EAX
                   end;
                   {$ENDIF}
    opDivide     : goto LUnknown;
    opIntDivide  : L.Int := L.Int div R.Int;
    opModulus    : L.Int := L.Int mod R.Int;
    opShiftLeft  : L.Int := L.Int shl R.Int;
    opShiftRight : L.Int := L.Int shr R.Int;
    opAnd        : L.Int := L.Int and R.Int;
    opOr         : L.Int := L.Int or  R.Int;
    opXor        : L.Int := L.Int xor R.Int;
    opEqv        : L.Int := not (L.Int xor R.Int);
    opImp        : L.Int := not (L.Int xor R.Int) or R.Int;
  else
    goto LUnknown;
  end;

  if (TVarData(ARes).VType and VARDEEPDATA) <> 0 then
    VarClear(ARes);
  TVarData(ARes).VType    := varInteger;
  TVarData(ARes).VInteger := L.Int;
  Exit;

LUnknown:

  case AOper of
    opAdd:        _StdVarAdd(ALeft, ARight, ARes);
    opSubtract:   _StdVarSubtract(ALeft, ARight, ARes);
    opMultiply:   _StdVarMultiply(ALeft, ARight, ARes);
    opDivide:     _StdVarDivide(ALeft, ARight, ARes);
    opIntDivide:  _StdVarIntDivide(ALeft, ARight, ARes);
    opModulus:    _StdVarModulus(ALeft, ARight, ARes);
    opShiftLeft:  _StdVarShiftLeft(ALeft, ARight, ARes);
    opShiftRight: _StdVarShiftRight(ALeft, ARight, ARes);
    opAnd:        _StdVarAnd(ALeft, ARight, ARes);
    opOr:         _StdVarOr(ALeft, ARight, ARes);
    opXor:        _StdVarXor(ALeft, ARight, ARes);
    opStrConcat:  _StdVarStrConcat(ALeft, ARight, ARes);
    opPower:      _StdVarPower(ALeft, ARight, ARes);
    opEqv:        _StdVarEqv(ALeft, ARight, ARes);
    opImp:        _StdVarImp(ALeft, ARight, ARes);
  else
    {$IFDEF LMDCOMP7}
    VarInvalidOp;
    {$ELSE}
    Assert(False);
    {$ENDIF}
  end;
end;
{$WARNINGS ON}

{-----------------------------------------------------------------------------}

function _VarCmpREQ(const ALeft, ARight: OleVariant): Boolean;
label
  LFalse;
var
  ldt, rdt: PVarData;
begin
  ldt := @TVarData(ALeft);
  rdt := @TVarData(ARight);

  if ldt.VType <> varDispatch then
  begin
    ldt := PVarData(VarResolveRef(OleVariant(ldt^)));
    if ldt.VType <> varDispatch then
      goto LFalse;
  end;

  if rdt.VType <> varDispatch then
  begin
    rdt := PVarData(VarResolveRef(OleVariant(rdt^)));
    if rdt.VType <> varDispatch then
      goto LFalse;
  end;

  Result := (ldt.VDispatch = rdt.VDispatch);
  Exit;

LFalse:
  Result := False;
end;

{-----------------------------------------------------------------------------}

function _VarCmpRNE(const ALeft, ARight: OleVariant): Boolean;
label
  LFalse;
var
  ldt, rdt: PVarData;
begin
  ldt := @TVarData(ALeft);
  rdt := @TVarData(ARight);

  if ldt.VType <> varDispatch then
  begin
    ldt := PVarData(VarResolveRef(OleVariant(ldt^)));
    if ldt.VType <> varDispatch then
      goto LFalse;
  end;

  if rdt.VType <> varDispatch then
  begin
    rdt := PVarData(VarResolveRef(OleVariant(rdt^)));
    if rdt.VType <> varDispatch then
      goto LFalse;
  end;

  Result := (ldt.VDispatch <> rdt.VDispatch);
  Exit;

LFalse:
  Result := False;
end;

{-----------------------------------------------------------------------------}

{$WARNINGS OFF}
function VarCompareOp(const ALeft, ARight: OleVariant; AOper: TVarOp): Boolean;
type
  TValue = record
    case Integer of
      0: (Bln: Boolean);
      1: (Int: Integer);
      2: (Flt: Double);
      3: (I64: Int64);
      4: (Obj: Pointer);
  end;
label
  LUnknown, L_Int, L_Bln, L_Flt, L_I64, L_Cmp, L_Obj;
var
  L, R:         TValue;
  ldata, rdata: PVarData;
begin
  ldata := @TVarData(ALeft);
  rdata := @TVarData(ARight);

  if ldata.VType > VARTYPE_MAX then
  begin
    ldata := PVarData(VarResolveRef(OleVariant(ldata^)));
    if ldata.VType > VARTYPE_MAX then
      goto LUnknown;
  end;

  if rdata.VType > VARTYPE_MAX then
  begin
    rdata := PVarData(VarResolveRef(OleVariant(rdata^)));
    if rdata.VType > VARTYPE_MAX then
      goto LUnknown;
  end;

  case BINARY_ENTRIES[ldata.VType, rdata.VType] of
    beInt_SmiSmi:     begin
                        L.Int := ldata.VSmallint;
                        R.Int := rdata.VSmallint;
                        goto L_Int;
                      end;
    beInt_SmiI32:     begin
                        L.Int := ldata.VSmallint;
                        R.Int := rdata.VInteger;
                        goto L_Int;
                      end;
    beFlt_SmiSgl:     begin
                        L.Flt := ldata.VSmallint;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_SmiDbl:     begin
                        L.Flt := ldata.VSmallint;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beInt_SmiBln:     begin
                        L.Int := ldata.VSmallint;
                        R.Int := Integer(rdata.VBoolean);
                        goto L_Int;
                      end;
    beInt_SmiShi:     begin
                        L.Int := ldata.VSmallint;
                        R.Int := rdata.VShortInt;
                        goto L_Int;
                      end;
    beInt_SmiByt:     begin
                        L.Int := ldata.VSmallint;
                        R.Int := rdata.VByte;
                        goto L_Int;
                      end;
    beI64_SmiWrd:     begin
                        L.I64 := ldata.VSmallint;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_SmiLWd:     begin
                        L.I64 := ldata.VSmallint;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_SmiI64:     begin
                        L.I64 := ldata.VSmallint;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beInt_I32Smi:     begin
                        L.Int := ldata.VInteger;
                        R.Int := rdata.VSmallint;
                        goto L_Int;
                      end;
    beInt_I32I32:     begin
                        L.Int := ldata.VInteger;
                        R.Int := rdata.VInteger;
                        goto L_Int;
                      end;
    beFlt_I32Sgl:     begin
                        L.Flt := ldata.VInteger;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_I32Dbl:     begin
                        L.Flt := ldata.VInteger;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beInt_I32Bln:     begin
                        L.Int := ldata.VInteger;
                        R.Int := Integer(rdata.VBoolean);
                        goto L_Int;
                      end;
    beInt_I32Shi:     begin
                        L.Int := ldata.VInteger;
                        R.Int := rdata.VShortInt;
                        goto L_Int;
                      end;
    beInt_I32Byt:     begin
                        L.Int := ldata.VInteger;
                        R.Int := rdata.VByte;
                        goto L_Int;
                      end;
    beI64_I32Wrd:     begin
                        L.I64 := ldata.VInteger;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_I32LWd:     begin
                        L.I64 := ldata.VInteger;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_I32I64:     begin
                        L.I64 := ldata.VInteger;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beFlt_SglSmi:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VSmallint;
                        goto L_Flt;
                      end;
    beFlt_SglI32:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VInteger;
                        goto L_Flt;
                      end;
    beFlt_SglSgl:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_SglDbl:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beFlt_SglBln:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := Integer(rdata.VBoolean);
                        goto L_Flt;
                      end;
    beFlt_SglShi:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VShortInt;
                        goto L_Flt;
                      end;
    beFlt_SglByt:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VByte;
                        goto L_Flt;
                      end;
    beFlt_SglWrd:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VWord;
                        goto L_Flt;
                      end;
    beFlt_SglLWd:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VLongWord;
                        goto L_Flt;
                      end;
    beFlt_SglI64:     begin
                        L.Flt := ldata.VSingle;
                        R.Flt := rdata.VInt64;
                        goto L_Flt;
                      end;
    beFlt_DblSmi:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VSmallint;
                        goto L_Flt;
                      end;
    beFlt_DblI32:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VInteger;
                        goto L_Flt;
                      end;
    beFlt_DblSgl:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_DblDbl:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beFlt_DblBln:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := Integer(rdata.VBoolean);
                        goto L_Flt;
                      end;
    beFlt_DblShi:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VShortInt;
                        goto L_Flt;
                      end;
    beFlt_DblByt:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VByte;
                        goto L_Flt;
                      end;
    beFlt_DblWrd:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VWord;
                        goto L_Flt;
                      end;
    beFlt_DblLWd:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VLongWord;
                        goto L_Flt;
                      end;
    beFlt_DblI64:     begin
                        L.Flt := ldata.VDouble;
                        R.Flt := rdata.VInt64;
                        goto L_Flt;
                      end;
    beInt_BlnSmi:     begin
                        L.Int := Integer(ldata.VBoolean);
                        R.Int := rdata.VSmallint;
                        goto L_Int;
                      end;
    beInt_BlnI32:     begin
                        L.Int := Integer(ldata.VBoolean);
                        R.Int := rdata.VInteger;
                        goto L_Int;
                      end;
    beFlt_BlnSgl:     begin
                        L.Flt := Integer(ldata.VBoolean);
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_BlnDbl:     begin
                        L.Flt := Integer(ldata.VBoolean);
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beBln_BlnBln:     begin
                        L.Bln := ldata.VBoolean;
                        R.Bln := rdata.VBoolean;
                        goto L_Bln;
                      end;
    beInt_BlnShi:     begin
                        L.Int := Integer(ldata.VBoolean);
                        R.Int := rdata.VShortInt;
                        goto L_Int;
                      end;
    beInt_BlnByt:     begin
                        L.Int := Integer(ldata.VBoolean);
                        R.Int := rdata.VByte;
                        goto L_Int;
                      end;
    beI64_BlnWrd:     begin
                        L.I64 := Integer(ldata.VBoolean);
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_BlnLWd:     begin
                        L.I64 := Integer(ldata.VBoolean);
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_BlnI64:     begin
                        L.I64 := Integer(ldata.VBoolean);
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beInt_ShiSmi:     begin
                        L.Int := ldata.VShortInt;
                        R.Int := rdata.VSmallint;
                        goto L_Int;
                      end;
    beInt_ShiI32:     begin
                        L.Int := ldata.VShortInt;
                        R.Int := rdata.VInteger;
                        goto L_Int;
                      end;
    beFlt_ShiSgl:     begin
                        L.Flt := ldata.VShortInt;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_ShiDbl:     begin
                        L.Flt := ldata.VShortInt;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beInt_ShiBln:     begin
                        L.Int := ldata.VShortInt;
                        R.Int := Integer(rdata.VBoolean);
                        goto L_Int;
                      end;
    beInt_ShiShi:     begin
                        L.Int := ldata.VShortInt;
                        R.Int := rdata.VShortInt;
                        goto L_Int;
                      end;
    beInt_ShiByt:     begin
                        L.Int := ldata.VShortInt;
                        R.Int := rdata.VByte;
                        goto L_Int;
                      end;
    beI64_ShiWrd:     begin
                        L.I64 := ldata.VShortInt;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_ShiLWd:     begin
                        L.I64 := ldata.VShortInt;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_ShiI64:     begin
                        L.I64 := ldata.VShortInt;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beInt_BytSmi:     begin
                        L.Int := ldata.VByte;
                        R.Int := rdata.VSmallint;
                        goto L_Int;
                      end;
    beInt_BytI32:     begin
                        L.Int := ldata.VByte;
                        R.Int := rdata.VInteger;
                        goto L_Int;
                      end;
    beFlt_BytSgl:     begin
                        L.Flt := ldata.VByte;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_BytDbl:     begin
                        L.Flt := ldata.VByte;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beInt_BytBln:     begin
                        L.Int := ldata.VByte;
                        R.Int := Integer(rdata.VBoolean);
                        goto L_Int;
                      end;
    beInt_BytShi:     begin
                        L.Int := ldata.VByte;
                        R.Int := rdata.VShortInt;
                        goto L_Int;
                      end;
    beInt_BytByt:     begin
                        L.Int := ldata.VByte;
                        R.Int := rdata.VByte;
                        goto L_Int;
                      end;
    beI64_BytWrd:     begin
                        L.I64 := ldata.VByte;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_BytLWd:     begin
                        L.I64 := ldata.VByte;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_BytI64:     begin
                        L.I64 := ldata.VByte;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beI64_WrdSmi:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VSmallint;
                        goto L_I64;
                      end;
    beI64_WrdI32:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VInteger;
                        goto L_I64;
                      end;
    beFlt_WrdSgl:     begin
                        L.Flt := ldata.VWord;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_WrdDbl:     begin
                        L.Flt := ldata.VWord;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beI64_WrdBln:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := Integer(rdata.VBoolean);
                        goto L_I64;
                      end;
    beI64_WrdShi:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VShortInt;
                        goto L_I64;
                      end;
    beI64_WrdByt:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VByte;
                        goto L_I64;
                      end;
    beI64_WrdWrd:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_WrdLWd:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_WrdI64:     begin
                        L.I64 := ldata.VWord;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beI64_LWdSmi:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VSmallint;
                        goto L_I64;
                      end;
    beI64_LWdI32:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VInteger;
                        goto L_I64;
                      end;
    beFlt_LWdSgl:     begin
                        L.Flt := ldata.VLongWord;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_LWdDbl:     begin
                        L.Flt := ldata.VLongWord;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beI64_LWdBln:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := Integer(rdata.VBoolean);
                        goto L_I64;
                      end;
    beI64_LWdShi:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VShortInt;
                        goto L_I64;
                      end;
    beI64_LWdByt:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VByte;
                        goto L_I64;
                      end;
    beI64_LWdWrd:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_LWdLWd:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_LWdI64:     begin
                        L.I64 := ldata.VLongWord;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beI64_I64Smi:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VSmallint;
                        goto L_I64;
                      end;
    beI64_I64I32:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VInteger;
                        goto L_I64;
                      end;
    beFlt_I64Sgl:     begin
                        L.Flt := ldata.VInt64;
                        R.Flt := rdata.VSingle;
                        goto L_Flt;
                      end;
    beFlt_I64Dbl:     begin
                        L.Flt := ldata.VInt64;
                        R.Flt := rdata.VDouble;
                        goto L_Flt;
                      end;
    beI64_I64Bln:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := Integer(rdata.VBoolean);
                        goto L_I64;
                      end;
    beI64_I64Shi:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VShortInt;
                        goto L_I64;
                      end;
    beI64_I64Byt:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VByte;
                        goto L_I64;
                      end;
    beI64_I64Wrd:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VWord;
                        goto L_I64;
                      end;
    beI64_I64LWd:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VLongWord;
                        goto L_I64;
                      end;
    beI64_I64I64:     begin
                        L.I64 := ldata.VInt64;
                        R.I64 := rdata.VInt64;
                        goto L_I64;
                      end;
    beObj_ObjObj:     begin
                        L.Obj := ldata.VDispatch;
                        R.Obj := rdata.VDispatch;
                        goto L_Obj;
                      end;
  else
    goto LUnknown;
  end;

L_Obj:

  case AOper of
    opCmpEQ      : Result := L.Obj = R.Obj;
    opCmpNE      : Result := L.Obj <> R.Obj;
    opCmpREQ     : Result := L.Obj = R.Obj;
    opCmpRNE     : Result := L.Obj <> R.Obj;
  else
    goto LUnknown;
  end;

  Exit;

L_Flt:

  case AOper of
    opCmpEQ      : Result := L.Flt = R.Flt;
    opCmpNE      : Result := L.Flt <> R.Flt;
    opCmpLT      : Result := L.Flt < R.Flt;
    opCmpLE      : Result := L.Flt <= R.Flt;
    opCmpGT      : Result := L.Flt > R.Flt;
    opCmpGE      : Result := L.Flt >= R.Flt;
  else
    goto LUnknown;
  end;

  Exit;

L_I64:

  case AOper of
    opCmpEQ      : Result := L.I64 = R.I64;
    opCmpNE      : Result := L.I64 <> R.I64;
    opCmpLT      : Result := L.I64 < R.I64;
    opCmpLE      : Result := L.I64 <= R.I64;
    opCmpGT      : Result := L.I64 > R.I64;
    opCmpGE      : Result := L.I64 >= R.I64;
  else
    goto LUnknown;
  end;

  Exit;

L_Bln:

  case AOper of
    opCmpEQ      : Result := L.Bln = R.Bln;
    opCmpNE      : Result := L.Bln <> R.Bln;
    opCmpLT      : Result := L.Bln < R.Bln;
    opCmpLE      : Result := L.Bln <= R.Bln;
    opCmpGT      : Result := L.Bln > R.Bln;
    opCmpGE      : Result := L.Bln >= R.Bln;
  else
    L.Int  := Integer(L.Bln);
    R.Int := Integer(R.Bln);
    goto L_Int;
  end;

  Exit;

L_Int:

  case AOper of
    opCmpEQ      : Result := L.Int = R.Int;
    opCmpNE      : Result := L.Int <> R.Int;
    opCmpLT      : Result := L.Int < R.Int;
    opCmpLE      : Result := L.Int <= R.Int;
    opCmpGT      : Result := L.Int > R.Int;
    opCmpGE      : Result := L.Int >= R.Int;
  else
    goto LUnknown;
  end;

  Exit;

LUnknown:

  case AOper of
    opCmpEQ:  Result := ALeft = ARight;
    opCmpNE:  Result := ALeft <> ARight;
    opCmpLT:  Result := ALeft < ARight;
    opCmpLE:  Result := ALeft <= ARight;
    opCmpGT:  Result := ALeft > ARight;
    opCmpGE:  Result := ALeft >= ARight;
    opCmpREQ: Result := _VarCmpREQ(ALeft, ARight);
    opCmpRNE: Result := _VarCmpRNE(ALeft, ARight);
  else
    {$IFDEF LMDCOMP7}
    VarInvalidOp;
    {$ELSE}
    Assert(False);
    {$ENDIF}
  end;
end;
{$WARNINGS ON}

{-----------------------------------------------------------------------------}
procedure VarUnaryNegate(const AArg: OleVariant; var ARes: OleVariant);
const
  CTruth: array [False..True] of Byte = (0, 1);
label
  LBegin, LDone, LUnknown;
var
  data:  PVarData;
  rdata: TVarData;
begin
  data := @TVarData(AArg);

LBegin:

  case data.VType of
    varSmallint:  begin
                    rdata.VType     := varSmallint;
                    rdata.VSmallInt := -data.VSmallInt;
                    goto LDone;
                  end;
    varInteger:   begin
                    rdata.VType     := varInteger;
                    rdata.VInteger := -data.VInteger;
                    goto LDone;
                  end;
    varSingle:    begin
                    rdata.VType     := varSingle;
                    rdata.VSingle   := -data.VSingle;
                    goto LDone;
                  end;
    varDouble:    begin
                    rdata.VType     := varDouble;
                    rdata.VDouble   := -data.VDouble;
                    goto LDone;
                  end;
    varCurrency:  begin
                    rdata.VType     := varCurrency;
                    rdata.VCurrency := -data.VCurrency;
                    goto LDone;
                  end;
    varDate:      begin
                    rdata.VType     := varDate;
                    rdata.VDate     := -data.VDate;
                    goto LDone;
                  end;
    varBoolean:   begin
                    rdata.VType     := varSmallInt;
                    rdata.VSmallInt := -CTruth[data.VBoolean = True];
                    goto LDone;
                  end;
    varShortInt:  begin
                    rdata.VType     := varShortInt;
                    rdata.VShortInt := -data.VShortInt;
                    goto LDone;
                  end;
    varByte:      begin
                    rdata.VType     := varSmallInt;
                    rdata.VSmallInt := -data.VByte;
                    goto LDone;
                  end;
    varWord:      begin
                    rdata.VType     := varInteger;
                    rdata.VInteger  := -data.VWord;
                    goto LDone;
                  end;
    varLongWord:  begin
                    if (data.VLongWord and $80000000) <> 0 then
                    begin
                      rdata.VType   := varInt64;
                      rdata.VInt64  := -data.VLongWord;
                    end
                    else
                    begin
                      rdata.VType    := varInteger;
                      rdata.VInteger := -Integer(data.VLongWord);
                    end;
                  end;
    varInt64:     begin
                    rdata.VType     := varInt64;
                    rdata.VInt64    := -data.VInt64;
                    goto LDone;
                  end;
  else
    goto LUnknown;
  end;

LDone:

  if (TVarData(ARes).VType and VARDEEPDATA) <> 0 then
    VarClear(ARes);
  TVarData(ARes) := rdata;
  Exit;

LUnknown:

  if data.VType = (varByRef or varVariant) then
  begin
    data := PVarData(VarResolveRefNoCheck(OleVariant(data^)));
    goto LBegin;
  end;

  _StdVarUnaryNegate(AArg, ARes);
end;

{-----------------------------------------------------------------------------}
procedure VarUnaryNot(const AArg: OleVariant; var ARes: OleVariant);
label
  LBegin, LI64, LDone, LUnknown;
var
  i64:   Int64;
  data:  PVarData;
  rdata: TVarData;
begin
  data := @TVarData(AArg);

LBegin:

  case data.VType of
    varSmallint:  begin
                    rdata.VType     := varSmallint;
                    rdata.VSmallInt :=  not data.VSmallInt;
                    goto LDone;
                  end;
    varInteger:   begin
                    rdata.VType     := varInteger;
                    rdata.VInteger :=  not data.VInteger;
                    goto LDone;
                  end;
    varSingle:    begin
                    i64 := Round(data.VSingle);
                    goto LI64;
                  end;
    varDouble:    begin
                    i64 := Round(data.VDouble);
                    goto LI64;
                  end;
    varCurrency:  begin
                    i64 := Round(data.VCurrency);
                    goto LI64;
                  end;
    varDate:      begin
                    i64 := Round(data.VDate);
                    goto LI64;
                  end;
    varBoolean:   begin
                    rdata.VType     := varBoolean;
                    rdata.VBoolean  := not data.VBoolean;
                    goto LDone;
                  end;
    varShortInt:  begin
                    rdata.VType     := varShortInt;
                    rdata.VShortInt := not data.VShortInt;
                    goto LDone;
                  end;
    varByte:      begin
                    rdata.VType     := varByte;
                    rdata.VByte     := not data.VByte;
                    goto LDone;
                  end;
    varWord:      begin
                    rdata.VType     := varWord;
                    rdata.VWord     := not data.VWord;
                    goto LDone;
                  end;
    varLongWord:  begin
                    rdata.VType     := varLongWord;
                    rdata.VLongWord := not data.VLongWord;
                    goto LDone;
                  end;
    varInt64:     begin
                    rdata.VType     := varInt64;
                    rdata.VInt64    := not data.VInt64;
                    goto LDone;
                  end;
  else
    goto LUnknown;
  end;

LI64:

  if (i64 >= Low(Integer)) and (i64 <= High(Integer)) then
  begin
    rdata.VType     := varInteger;
    rdata.VInteger  := not Integer(i64);
  end
  else
  begin
    rdata.VType     := varInt64;
    rdata.VInt64    := not i64;
  end;
  goto LDone;

LDone:

  if (TVarData(ARes).VType and VARDEEPDATA) <> 0 then
    VarClear(ARes);
  TVarData(ARes) := rdata;
  Exit;

LUnknown:

  if data.VType = (varByRef or varVariant) then
  begin
    data := PVarData(VarResolveRefNoCheck(OleVariant(data^)));
    goto LBegin;
  end;

  _StdVarUnaryNot(AArg, ARes);
end;

{-----------------------------------------------------------------------------}
procedure VarUnaryOp(const AArg: OleVariant; var ARes: OleVariant;
  AOper: TVarOp);
begin
  case AOper of
    opNegate: VarUnaryNegate(AArg, ARes);
    opNot:    VarUnaryNot(AArg, ARes);
  else
    {$IFDEF LMDCOMP7}
    VarInvalidOp;
    {$ELSE}
    Assert(False);
    {$ENDIF}
  end;
end;

{-----------------------------------------------------------------------------}
procedure VarMoveData(var ADest, ASource: OleVariant);
begin
  if (TVarData(ADest).VType and VARDEEPDATA) <> 0 then
    VarClear(ADest);

  TVarData(ADest)         := TVarData(ASource);
  TVarData(ASource).VType := 0;
end;

{-----------------------------------------------------------------------------}
procedure VarMakeRef(var ADest, ASource: OleVariant);
begin
  if (TVarData(ADest).VType and VARDEEPDATA) <> 0 then
    VarClear(ADest);

  TVarData(ADest).VType    := (varByRef or varVariant);
  TVarData(ADest).VPointer := @ASource;
end;

{-----------------------------------------------------------------------------}
procedure VarAssignByRef(var ADest: OleVariant; const AValue: OleVariant);
var
  p: POleVariant;
begin
  p := @ADest;

  if PVarData(p).VType = (varByRef or varVariant) then // Is var by ref.
  begin
    p  := VarResolveRefNoCheck(p^);
    p^ := AValue;
  end;
end;

{-----------------------------------------------------------------------------}
function VarResolveRef(const V: OleVariant): POleVariant;
begin
  Result := @V;
  while PVarData(Result).VType = (varByRef or varVariant) do
    Result := PVarData(Result).VPointer;
end;

{-----------------------------------------------------------------------------}
function VarResolveRefNoCheck(const V: OleVariant): POleVariant;
begin
  Result := PVarData(@V).VPointer;
  while PVarData(Result).VType = (varByRef or varVariant) do
    Result := PVarData(Result).VPointer;
end;

{******************************** ELMDVMRuntime *******************************}
{------------------------------------------------------------------------------}
class function ELMDVMRuntime.FormatMsg(AErrorType: TLMDRuntimeErrorType;
  const AArgs: array of const): WideString;
begin
  case AErrorType of
    retUndeclaredId:
      Result := Format(SLMDRuntimeUndeclaredId, AArgs);
    retOutsideOfLoop:
      Result := SLMDRuntimeOutsideOfLoop;
    retEBCFromFinally:
      Result := SLMDRuntimeEBCFromFinally;
    retCannotAssign:
      Result := SLMDRuntimeCannotAssign;
    retInvalidParamCount:
      Result := SLMDRuntimeInvalidParamCount;
    retTypeMismatch:
      Result := SLMDRuntimeTypeMismatch;
    retObjectRequired:
      Result := SLMDRuntimeObjectRequired;
    retLoopVar:
      Result := SLMDRuntimeLoopVar;
    retCannotRaiseNil:
      Result := SLMDRuntimeCannotRaiseNil;
    retCannotRaiseLocked:
      Result := SLMDRuntimeCannotRaiseLocked;
    retLowOnlyArray:
      Result := SLMDRuntimeLowOnlyArray;
    retHighOnlyArray:
      Result := SLMDRuntimeHighOnlyArray;
    retViolatesBounds:
      Result := SLMDRuntimeViolatesBounds;
    retInvalidDispId:
      Result := SLMDRuntimeInvalidDispId;
    retProcRequired:
      Result := SLMDVMProcRequired;
    retValObjRequired:
      Result := SLMDVMValObjRequired;
    retAborted:
      Result := SLMDVMAborted;
    retIEInvalidInstr:
      Result := SLMDRuntimeIEInvalidInstr;
    retIEInvalidObjKind:
      Result := SLMDRuntimeIEInvalidObjKind;
    retIEInvalidBracketType:
      Result := SLMDRuntimeIEInvalidBracket;
    retIENoBreakpointInfo:
      Result := SLMDRuntimeIENoBreakpointInfo;
  else
    Result := SLMDRuntimeInvalidException;
  end;
end;

{------------------------------------------------------------------------------}
class procedure ELMDVMRuntime.RaiseError(AErrorType: TLMDRuntimeErrorType);
begin
  raise ELMDVMRuntime.Create(FormatMsg(AErrorType, []));
end;

{------------------------------------------------------------------------------}
class procedure ELMDVMRuntime.RaiseError(AErrorType: TLMDRuntimeErrorType;
  const AStrName: WideString);
begin
  raise ELMDVMRuntime.Create(FormatMsg(AErrorType, [AStrName]));
end;

{***************************** TLMDPasVirtualMachine *************************}
{-----------------------------------------------------------------------------}
constructor TLMDVirtMachine.Create(const ALanguage: ILMDLanguage);
begin
  inherited Create;

  FLanguage         := ALanguage;
  FSection          := TCriticalSection.Create;
  FId               := VMIndexes.AsquireId(Self);
  FScriptGlobals    := TLMDNameHashTable.Create(True);
  FIntrinsicObjects := TLMDNameHashTable.Create(True);
  FProcedures       := TList.Create;
  FGlobalVars	      := TList.Create;
  FGlobalConsts     := TList.Create;
  FGlobalNamespace  := TGlobalObjectsNamespace.Create(Self);
  FExternObjects    := TLMDExternObjects.Create(Self);
  FGlobalStmts      := TList.Create;
  FSource           := TLMDVMSource.Create;
  FBreakpoints      := TLMDVMBreakpoints.Create(Self);
end;

{-----------------------------------------------------------------------------}
destructor TLMDVirtMachine.Destroy;
begin
  Close;

  FScriptGlobals.Free;
  FProcedures.Free;
  FGlobalVars.Free;
  FGlobalConsts.Free;
  FGlobalNamespace.Free;
  FIntrinsicObjects.Free;
  FExternObjects.Free;
  FSection.Free;
  FSource.Free;
  FBreakpoints.Free;
  FGlobalStmts.Free;

  VMIndexes.ReleaseId(FId);
  inherited;
end;

{-----------------------------------------------------------------------------}
procedure TLMDVirtMachine.Initialize(const ASource: WideString);
var
  cbs:       TVMParserCallbacks;
  line, pos: Integer;
  parser:    ILMDParserBase;
begin
  FSection.Acquire;
  try
    if FState <> msUninitialized then
      raise ELMDVirtMachine.Create(SLMDVMNonInitialize);

    FSource.Text := ASource;
    cbs          := TVMParserCallbacks.Create(Self);
    parser       := FLanguage.CreateParser(cbs);
    try
      try
        parser.Parse(FSource.Text);
        FLanguage.AddIntrinsics(AddIntrinsicProc);
        FGlobalByteCode := EmitGlobalCode;
        FCodeObject     := TLMDCodeObject.Create(Self);
      except
        on e: Exception do
        begin
          if e is ELMDCompileBase then
          begin
            FSource.PosToLine(ELMDCompileBase(e).SourcePos,
                              line, pos);
            if Assigned(FOnFormatException) then
              FOnFormatException(Self, line, pos, e);
          end;

          DoClear;
          raise;
        end;
      end;
    finally
      parser.Free;
      cbs.Free;
    end;

    FState := msInitialized;
  finally
    FSection.Release;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDVirtMachine.Open(ADebugger: TLMDVMDebugger);
var
  ctx:    TLMDVMInterpretContext;
  thread: TLMDThread;
begin
  FSection.Acquire;
  try
    if FState <> msInitialized then
      raise ELMDVirtMachine.Create(SLMDVMInitialize);

    FState         := msActive;
    FTerminateFlag := Integer(ic_MASK);

    if ADebugger <> nil then
      ADebugger.InsertVM(Self);
    VMIndexes.MarkOpened(FId, FDebugger);

    thread := VMIndexes.InitThread(FId);

    ctx.Code   := FGlobalByteCode;
    ctx.Args   := nil;
    ctx.Result := nil;
    ctx.Source := nil;
    Interpret(thread, ctx);
  finally
    FSection.Release;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDVirtMachine.Close;
begin
  FSection.Acquire;
  try
    if FState = msUninitialized then
      Exit;

    VMIndexes.MarkClosingAndWait(FId); // Will reset FTerminateFlag to 0.
    if FDebugger <> nil then
      FDebugger.RemoveVM(Self);

    FState := msUninitialized;
    DoClear;
  finally
    FSection.Release;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDVirtMachine.RunProc(const AName: WideString): OleVariant;
var
  proc:     TLMDProcObject;
  trddt:    TLMDThreadData;
  threadVM: TLMDThreadVM;
begin
  trddt := ThreadData;
  if FId.Index >= trddt.VMDataLength then
    trddt.Thread := VMIndexes.InitThread(FId);

  threadVM := trddt.Thread.VMData[FId.Index];

  if not threadVM.Lock then
    RaiseVMNotActive;
  try
    proc := threadVM.Globals.FindProcByStrName(AName); // No UpperCase needed.

    if proc = nil then
      RaiseProcNotFound(AName);

    if proc.ParamCount <> 0 then
      ELMDVMRuntime.RaiseError(retInvalidParamCount);

    InvokeProcNoChecks(trddt.Thread, proc, nil, Result);
  finally
    threadVM.Unlock;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDVirtMachine.RunProc(const AName: WideString;
  const AArgs: array of OleVariant): OleVariant;
var
  proc:     TLMDProcObject;
  trddt:    TLMDThreadData;
  threadVM: TLMDThreadVM;
begin
  trddt := ThreadData;
  if FId.Index >= trddt.VMDataLength then
    trddt.Thread := VMIndexes.InitThread(FId);

  threadVM := trddt.Thread.VMData[FId.Index];

  if not threadVM.Lock then
    RaiseVMNotActive;
  try
    proc := threadVM.Globals.FindProcByStrName(AName); // No UpperCase needed.

    if proc = nil then
      RaiseProcNotFound(AName);

    if proc.ParamCount <> Length(AArgs) then
      ELMDVMRuntime.RaiseError(retInvalidParamCount);

    InvokeProcNoChecks(trddt.Thread, proc, @AArgs[0], Result);
  finally
    threadVM.Unlock;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDVirtMachine.Interpret(AThread: TLMDThread;
  const ACtx: TLMDVMInterpretContext);
label
  LInstrLoop, LRet, L_GlobCall0, L_GlobCallRef0, L_Blk0, L_Blk1;
var
  top:      POleVariant;
  sres:     TLMDNameSearchRes;
  isres:    Boolean;
  e:        Exception;
  call:     TLMDCall;
  tryhdr:   TLMDTry;
  frm:      TLMDCallStackFrame;
  cure:     PExcVarData;
  bknd:     TLMDVMBreakKind;
  brkcmds:  array [0..1] of TLMDInstr;
  stepbase: PLMDFrame;
  nsi:      TLMDAbstractNamespace;
begin
  frm.CurNS         := ACtx.Code.InitialNamespace;
  frm.Stack         := AThread.StackPool.AsquireStack(ACtx.Code.StackSize);
  top               := POleVariant(TLMDPtrInt(frm.Stack) + ACtx.Code.StackLocalsOffset);
  frm.ExcSt         := nil;
  frm.IP            := @ACtx.Code.Code[0];

  frm.Next          := AThread.CallStack;
  frm.VM            := Self;
  frm.Ctx           := @ACtx;
  AThread.CallStack := @frm;

  stepbase := AThread.VMData[FId.Index].SteppingBase;
  if TLMDPtrUInt(@frm) >= stepbase^ then
    FBreakpoints.SetStepBPs(AThread, stepbase, TLMDFrame(@frm),
                            frm.IP, False);

LInstrLoop:
  try
    while True do
    begin
      case TLMDInstrCode(TLMDPtrInt(frm.IP.Code) and FTerminateFlag) of
        icJump:
        begin
          frm.IP := TLMDLabel(frm.IP.Data).Target;
        end;
        icPop:
        begin
          Dec(top);
          Inc(frm.IP);
        end;
        icGreater:
        begin
          POleVariant(TLMDPtrInt(top) - VSIZE)^ :=
            VarCompareOp(POleVariant(TLMDPtrInt(top) - VSIZE)^, top^, opCmpGT);
          Dec(top);
          Inc(frm.IP);
        end;
        icGreaterEqual:
        begin
          POleVariant(TLMDPtrInt(top) - VSIZE)^ :=
            VarCompareOp(POleVariant(TLMDPtrInt(top) - VSIZE)^, top^, opCmpGE);
          Dec(top);
          Inc(frm.IP);
        end;
        icLess:
        begin
          POleVariant(TLMDPtrInt(top) - VSIZE)^ :=
            VarCompareOp(POleVariant(TLMDPtrInt(top) - VSIZE)^, top^, opCmpLT);
          Dec(top);
          Inc(frm.IP);
        end;
        icLessEqual:
        begin
          POleVariant(TLMDPtrInt(top) - VSIZE)^ :=
            VarCompareOp(POleVariant(TLMDPtrInt(top) - VSIZE)^, top^, opCmpLE);
          Dec(top);
          Inc(frm.IP);
        end;
        icEqual:
        begin
          POleVariant(TLMDPtrInt(top) - VSIZE)^ :=
            VarCompareOp(POleVariant(TLMDPtrInt(top) - VSIZE)^, top^, opCmpEQ);
          Dec(top);
          Inc(frm.IP);
        end;
        icRefEqual:
        begin
          POleVariant(TLMDPtrInt(top) - VSIZE)^ :=
            VarCompareOp(POleVariant(TLMDPtrInt(top) - VSIZE)^, top^, opCmpREQ);
          Dec(top);
          Inc(frm.IP);
        end;
        icNotEqual:
        begin
          POleVariant(TLMDPtrInt(top) - VSIZE)^ :=
            VarCompareOp(POleVariant(TLMDPtrInt(top) - VSIZE)^, top^, opCmpNE);
          Dec(top);
          Inc(frm.IP);
        end;
        icRefNotEqual:
        begin
          POleVariant(TLMDPtrInt(top) - VSIZE)^ :=
            VarCompareOp(POleVariant(TLMDPtrInt(top) - VSIZE)^, top^, opCmpRNE);
          Dec(top);
          Inc(frm.IP);
        end;
        icPlus:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opAdd);
          Dec(top);
          Inc(frm.IP);
        end;
        icStrConcat:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opStrConcat);
          Dec(top);
          Inc(frm.IP);
        end;
        icMinus:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opSubtract);
          Dec(top);
          Inc(frm.IP);
        end;
        icJmpIfTrue:
        begin
          if top^ then
            frm.IP := TLMDLabel(frm.IP.Data).Target
          else
            Inc(frm.IP);
        end;
        icPopJmpIfTrue:
        begin
          if top^ then
            frm.IP := TLMDLabel(frm.IP.Data).Target
          else
            Inc(frm.IP);
          Dec(top);
        end;
        icPopJmpIfEqual:
        begin
          if VarCompareOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                          top^, opCmpEQ) then
            frm.IP := TLMDLabel(frm.IP.Data).Target
          else
            Inc(frm.IP);
          Dec(top, 2);
        end;
        icPopJmpIfNotEqual:
        begin
          if VarCompareOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                          top^, opCmpNE) then
            frm.IP := TLMDLabel(frm.IP.Data).Target
          else
            Inc(frm.IP);
          Dec(top, 2);
        end;
        icEqv:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opEqv);
          Dec(top);
          Inc(frm.IP);
        end;
        icImp:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opImp);
          Dec(top);
          Inc(frm.IP);
        end;
        icOr:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opOr);
          Dec(top);
          Inc(frm.IP);
        end;
        icXor:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opXor);
          Dec(top);
          Inc(frm.IP);
        end;
        icMultiply:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opMultiply);
          Dec(top);
          Inc(frm.IP);
        end;
        icDivide:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opDivide);
          Dec(top);
          Inc(frm.IP);
        end;
        icIntDiv:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opIntDivide);
          Dec(top);
          Inc(frm.IP);
        end;
        icMod:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opModulus);
          Dec(top);
          Inc(frm.IP);
        end;
        icPower:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opPower);
          Dec(top);
          Inc(frm.IP);
        end;
        icJmpIfFalse:
        begin
          if top^ then
            Inc(frm.IP)
          else
            frm.IP := TLMDLabel(frm.IP.Data).Target;
        end;
        icPopJmpIfFalse:
        begin
          if top^ then
            Inc(frm.IP)
          else
            frm.IP := TLMDLabel(frm.IP.Data).Target;
          Dec(top);
        end;
        icAnd:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opAnd);
          Dec(top);
          Inc(frm.IP);
        end;
        icShl:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opShiftLeft);
          Dec(top);
          Inc(frm.IP);
        end;
        icShr:
        begin
          VarBinaryOp(POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      top^,
                      POleVariant(TLMDPtrInt(top) - VSIZE)^,
                      opShiftRight);
          Dec(top);
          Inc(frm.IP);
        end;
        icUnaryPlus:
        begin
          Inc(frm.IP);
        end;
        icUnaryMinus:
        begin
          VarUnaryNegate(top^, top^);
          Inc(frm.IP);
        end;
        icUnaryNot:
        begin
          VarUnaryNot(top^, top^);
          Inc(frm.IP);
        end;
        icPush:
        begin
          Inc(top, Integer(frm.IP.Data));
          Inc(frm.IP);
        end;
        icPush0:
        begin
          Inc(top);
          top^ := 0;
          Inc(frm.IP);
        end;
        icPushUnassigned:
        begin
          Inc(top);
          top^ := OleUnassigned;
          Inc(frm.IP);
        end;
        icPushLiteral:
        begin
          Inc(top);
          top^ := POleVariant(frm.IP.Data)^;
          Inc(frm.IP);
        end;
        icAddValToSet:
        begin
          AddValToSet(POleVariant(TLMDPtrInt(top) - VSIZE)^, Integer(top^));
          Dec(top);
          Inc(frm.IP);
        end;
        icAddRangeToSet:
        begin
          AddRangeToSet(POleVariant(TLMDPtrInt(top) - 2 * VSIZE)^,
                        Integer(POleVariant(TLMDPtrInt(top) - VSIZE)^),
                        Integer(top^));
          Dec(top, 2);
          Inc(frm.IP);
        end;
        icIn:
        begin
          POleVariant(TLMDPtrInt(top) - VSIZE)^ :=
            ((1 shl Integer(POleVariant(TLMDPtrInt(top) - VSIZE)^))
             and Integer(top^)) <> 0;
          Dec(top);
          Inc(frm.IP);
        end;
        icGlobCall:
        begin
          call := TLMDCall(frm.IP.Data);
          sres := frm.CurNS.Find(AThread, call.Name, @call.StrName);

        L_GlobCall0:
          case sres.ObjKind of
            srNotFound:
            begin
              ELMDVMRuntime.RaiseError(retUndeclaredId, call.StrName);
            end;
            srExternal:
            begin
              with TVarData(AThread.V) do
              begin
                if (VType and VARDEEPDATA) <> 0 then
                  VarClear(AThread.V);
                VType     := varDispatch;
                VDispatch := Pointer(TLMDExternObject(sres.NamedObject).Obj);
                if VDispatch <> nil then
                  IDispatch(VDispatch)._AddRef;
              end;
            end;
            srExternalMember:
            begin
              if TLMDExternObject(sres.NamedObject).CodeObject <> nil then
              begin
                TLMDCodeObject(TLMDExternObject(sres.NamedObject).CodeObject).
                                                                  InvokeMember(
                  AThread,
                  sres.DispId,
                  call.BracketType,
                  call.ResMask,
                  call.ArgCount,
                  PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                  POleVariant(TLMDPtrInt(top) - call.ResOffset)^);
              end
              else
              begin
                InvokeDispatchMember(
                  call,
                  TLMDExternObject(sres.NamedObject).Obj,
                  sres.DispId,
                  PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                  POleVariant(TLMDPtrInt(top) - call.ResOffset)^);
              end;

              Dec(TLMDPtrInt(top), call.ResOffset);

              if TLMDFrame(@frm) >= stepbase^ then
                FBreakpoints.SetStepBPs(AThread, stepbase, TLMDFrame(@frm),
                                        frm.IP, True);
              Inc(frm.IP);
              Continue; // Main while
            end;
            srGlobalVar:
              AThread.V := TLMDVarObject(sres.NamedObject).Value;
            srGlobalConst:
              AThread.V := TLMDConstObject(sres.NamedObject).Value;
            srProcedure:
            begin
              InvokeProc(AThread, call, TLMDProcObject(sres.NamedObject),
                         top);
              Dec(TLMDPtrInt(top), call.ResOffset);

              if TLMDFrame(@frm) >= stepbase^ then
                FBreakpoints.SetStepBPs(AThread, stepbase, TLMDFrame(@frm),
                                        frm.IP, True);
              Inc(frm.IP);
              Continue; // Main while
            end;
            srLocalVar:
              AThread.V := frm.Stack[sres.LocalVarIndex];
            srLocalConst:
              AThread.V := sres.LocalConst^;
            srParam:
              AThread.V := VarResolveRef(ACtx.Args[sres.ParamInfo.Index])^;
            srResult:
              AThread.V := ACtx.Result^;
            srExit:
            begin
              if (DWORD(call.BracketType) or call.ResMask) <> 0 then
                ELMDVMRuntime.RaiseError(retTypeMismatch);

              if call.ExitLabel <> nil then
              begin
                frm.IP := call.ExitLabel.Target;
                top    := POleVariant(TLMDPtrInt(frm.Stack) + ACtx.Code.StackLocalsOffset);
                Continue; // Main while
              end;

              goto LRet;
            end;
            srBreak:
            begin
              if (DWORD(call.BracketType) or call.ResMask) <> 0 then
                ELMDVMRuntime.RaiseError(retTypeMismatch);

              if call.BreakLabel = nil then
                ELMDVMRuntime.RaiseError(retOutsideOfLoop);

              frm.IP := call.BreakLabel.Target;
              top    := POleVariant(TLMDPtrInt(frm.Stack) + ACtx.Code.StackLocalsOffset);
              Continue; // Main while
            end;
            srContinue:
            begin
              if (DWORD(call.BracketType) or call.ResMask) <> 0 then
                ELMDVMRuntime.RaiseError(retTypeMismatch);

              if call.ContinueLabel = nil then
                ELMDVMRuntime.RaiseError(retOutsideOfLoop);

              frm.IP := call.ContinueLabel.Target;
              top    := POleVariant(TLMDPtrInt(frm.Stack) + ACtx.Code.StackLocalsOffset);
              Continue; // Main while
            end;
            srIntrinsic:
            begin
              TIntrinsic(sres.NamedObject).Execute(
                Self, call,
                PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                POleVariant(TLMDPtrInt(top) - call.ResOffset)^);

              Dec(TLMDPtrInt(top), call.ResOffset);
              Inc(frm.IP);
              Continue; // Main while
            end;
            srDebugVar:
            begin
              AThread.V := VarResolveRef(sres.DebugVar^)^;
            end;
            else
              ELMDVMRuntime.RaiseError(retIEInvalidObjKind);
          end;

          case call.BracketType of
            bkNon:
            begin
              Dec(TLMDPtrInt(top), call.ResOffset);
              VarMoveData(top^, AThread.V);
            end;
            bkVbRound:
            begin
              if sres.ObjKind = srResult then
              begin
                nsi := frm.CurNS.Parent;
                while nsi <> nil do
                begin
                  sres := nsi.Find(AThread, call.Name, @call.StrName);
                  if sres.ObjKind <> srResult then
                    goto L_GlobCall0;
                  nsi := nsi.Parent;
                end;
              end;

              goto L_Blk0;
            end;
            bkRound:
              ELMDVMRuntime.RaiseError(retTypeMismatch);
            bkBlock:
            begin
              L_Blk0:
              GetIndexed(call.ArgCount, AThread.V,
                         PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                         POleVariant(TLMDPtrInt(top) - call.ResOffset)^);
              Dec(TLMDPtrInt(top), call.ResOffset);
            end;
          end;
          
          Inc(frm.IP);
        end;
        icGlobCallRef:
        begin
          call := TLMDCall(frm.IP.Data);
          sres := frm.CurNS.Find(AThread, call.Name, @call.StrName);

        L_GlobCallRef0:
          case sres.ObjKind of
            srNotFound:
              ELMDVMRuntime.RaiseError(retUndeclaredId, call.StrName);
            srExternal:
            begin
              with TVarData(AThread.V) do
              begin
                if (VType and VARDEEPDATA) <> 0 then
                  VarClear(AThread.V);
                VType     := varDispatch;
                VDispatch := Pointer(TLMDExternObject(sres.NamedObject).Obj);
                if VDispatch <> nil then
                  IDispatch(VDispatch)._AddRef;
              end;
            end;
            srExternalMember:
            begin
              if TLMDExternObject(sres.NamedObject).CodeObject <> nil then
              begin
                TLMDCodeObject(TLMDExternObject(sres.NamedObject).
                                                      CodeObject).InvokeMember(
                  AThread,
                  sres.DispId,
                  call.BracketType,
                  call.ResMask,
                  call.ArgCount,
                  PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                  POleVariant(TLMDPtrInt(top) - call.ResOffset)^);
              end
              else
              begin
                InvokeDispatchMember(
                  call,
                  TLMDExternObject(sres.NamedObject).Obj,
                  sres.DispId,
                  PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                  POleVariant(TLMDPtrInt(top) - call.ResOffset)^);
              end;

              Dec(TLMDPtrInt(top), call.ResOffset);

              if TLMDFrame(@frm) >= stepbase^ then
                FBreakpoints.SetStepBPs(AThread, stepbase, TLMDFrame(@frm),
                                        frm.IP, True);
              Inc(frm.IP);
              Continue; // Main while
            end;
            srGlobalVar:
              VarMakeRef(AThread.V, TLMDVarObject(sres.NamedObject).Value);
            srGlobalConst:
              AThread.V := TLMDConstObject(sres.NamedObject).Value;
            srProcedure:
            begin
              InvokeProc(AThread, call, TLMDProcObject(sres.NamedObject),
                         top);
              Dec(TLMDPtrInt(top), call.ResOffset);

              if TLMDFrame(@frm) >= stepbase^ then
                FBreakpoints.SetStepBPs(AThread, stepbase, TLMDFrame(@frm),
                                        frm.IP, True);
              Inc(frm.IP);
              Continue; // Main while
            end;
            srLocalVar:
              VarMakeRef(AThread.V, frm.Stack[sres.LocalVarIndex]);
            srLocalConst:
              AThread.V := sres.LocalConst^;
            srParam:
            begin
              AThread.PV := @ACtx.Args[sres.ParamInfo.Index];

              case TLMDParamKind(sres.ParamInfo.Kind) of
                pkSimple: // If the arg value is ref-to-var, we SHOULD
                          // replace the ref-to-var with explicit value.
                begin
                  if PVarData(AThread.PV).VType = (varByRef or varVariant) then
                    AThread.PV^ := VarResolveRefNoCheck(AThread.PV^)^;
                  VarMakeRef(AThread.V, AThread.PV^);
                end;
                pkConst:
                  AThread.V := VarResolveRef(AThread.PV^)^;
                pkByRef:
                  VarMakeRef(AThread.V, VarResolveRef(AThread.PV^)^);
              end;
            end;
            srResult:
              VarMakeRef(AThread.V, ACtx.Result^);
            srExit, srBreak, srContinue:
            begin
              ELMDVMRuntime.RaiseError(retTypeMismatch);
            end;
            srIntrinsic:
            begin
              TIntrinsic(sres.NamedObject).Execute(
                Self, call,
                PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                POleVariant(TLMDPtrInt(top) - call.ResOffset)^);

              Dec(TLMDPtrInt(top), call.ResOffset);
              Inc(frm.IP);
              Continue;
            end;
            srDebugVar:
            begin
              AThread.V := VarResolveRef(sres.DebugVar^)^; // No by-ref???
            end;
            else
              ELMDVMRuntime.RaiseError(retIEInvalidObjKind);
          end;

          case call.BracketType of
            bkNon:
            begin
              Dec(TLMDPtrInt(top), call.ResOffset);
              VarMoveData(top^, AThread.V);
            end;
            bkVbRound:
            begin
              if sres.ObjKind = srResult then
              begin
                nsi := frm.CurNS.Parent;
                while nsi <> nil do
                begin
                  sres := nsi.Find(AThread, call.Name, @call.StrName);
                  if sres.ObjKind <> srResult then
                    goto L_GlobCallRef0;
                  nsi := nsi.Parent;
                end;
              end;

              if TVarData(AThread.V).VType = (varByRef or varVariant) then
                AThread.PV := VarResolveRefNoCheck(AThread.V)
              else
                AThread.PV := @AThread.V;

              goto L_Blk1;
            end;
            bkRound:
              ELMDVMRuntime.RaiseError(retTypeMismatch);
            bkBlock:
            begin
              L_Blk1:
              GetIndexed(call.ArgCount, AThread.V,
                         PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                         POleVariant(TLMDPtrInt(top) - call.ResOffset)^);
              Dec(TLMDPtrInt(top), call.ResOffset);
            end;
          end;

          Inc(frm.IP);
        end;
        icMemberCall,
        icMemberCallRef:
        begin
          call := TLMDCall(frm.IP.Data);
          InvokeMemberCall(AThread, call, top);
          Dec(TLMDPtrInt(top), call.ResOffset);

          if TLMDFrame(@frm) >= stepbase^ then
            FBreakpoints.SetStepBPs(AThread, stepbase, TLMDFrame(@frm),
                                    frm.IP, True);
          Inc(frm.IP);
        end;
        icUnnamedCall,
        icUnnamedCallRef:
        begin
          call := TLMDCall(frm.IP.Data);

          case call.BracketType of
            bkRound:
              ELMDVMRuntime.RaiseError(retTypeMismatch);
            bkVbRound,
            bkBlock:
            begin
              GetIndexed(call.ArgCount,
                         POleVariant(TLMDPtrInt(top) - call.ObjectOffset)^,
                         PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                         POleVariant(TLMDPtrInt(top) - call.ResOffset)^);
              Dec(TLMDPtrInt(top), call.ResOffset);
            end;
            else
              ELMDVMRuntime.RaiseError(retIEInvalidBracketType);
          end;

          Inc(frm.IP);
        end;
        icNewUnnamedCall:
        begin
          call       := TLMDCall(frm.IP.Data);
          AThread.PV := POleVariant(TLMDPtrInt(top) - call.ResOffset);

          AThread.PV^ := OleUnassigned;
          if Assigned(FOnNew) then
            FOnNew(Self, POleVariant(TLMDPtrInt(top) - call.ObjectOffset)^,
                   PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                   call.ArgCount, AThread.PV^);
          Dec(TLMDPtrInt(top), call.ResOffset);

          if TLMDFrame(@frm) >= stepbase^ then
            FBreakpoints.SetStepBPs(AThread, stepbase, TLMDFrame(@frm),
                                    frm.IP, True);
          Inc(frm.IP);
        end;
        icAssignGlobCall:
        begin
          call := TLMDCall(frm.IP.Data);
          sres := frm.CurNS.Find(AThread, call.Name, @call.StrName);

          case sres.ObjKind of
            srNotFound:
              ELMDVMRuntime.RaiseError(retUndeclaredId, call.StrName);
            srExternalMember:
            begin
              if TLMDExternObject(sres.NamedObject).CodeObject <> nil then
              begin
                TLMDCodeObject(TLMDExternObject(sres.NamedObject).
                                                    CodeObject).InvokePropPut(
                  AThread,
                  sres.DispId,
                  call.BracketType,
                  call.ArgCount,
                  PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                  top);
              end
              else
              begin
                InvokeDispatchPropPut(
                  call,
                  TLMDExternObject(sres.NamedObject).Obj,
                  sres.DispId,
                  PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                  top);
              end;

              Dec(TLMDPtrInt(top), call.ArgsOffset + VSIZE);

              if TLMDFrame(@frm) >= stepbase^ then
                FBreakpoints.SetStepBPs(AThread, stepbase, TLMDFrame(@frm),
                                        frm.IP, True);
              Inc(frm.IP);
              Continue; // Main while
            end;
            srGlobalVar:
              AThread.PV := @TLMDVarObject(sres.NamedObject).Value;
            srLocalVar:
              AThread.PV := @frm.Stack[sres.LocalVarIndex];
            srParam:
            begin
              AThread.PV := @ACtx.Args[sres.ParamInfo.Index];

              case TLMDParamKind(sres.ParamInfo.Kind) of
                pkSimple:
                  ; // Do nothing.
                pkConst:
                  ELMDVMRuntime.RaiseError(retCannotAssign);
                pkByRef:
                  AThread.PV := VarResolveRef(AThread.PV^);
              end;
            end;
            srResult:
              AThread.PV := ACtx.Result;
            else
              ELMDVMRuntime.RaiseError(retCannotAssign);
          end;

          case call.BracketType of
            bkNon:
            begin
              VarMoveData(AThread.PV^, top^);
              Dec(top);
            end;
            bkRound:
              ELMDVMRuntime.RaiseError(retCannotAssign);
            bkVbRound,
            bkBlock:
            begin
              SetIndexed(AThread.PV^, top,
                         PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                         call.ArgCount);
              Dec(TLMDPtrInt(top), call.ArgsOffset + VSIZE);
            end;
          end;

          Inc(frm.IP);
        end;
        icAssignMemberCall:
        begin
          call := TLMDCall(frm.IP.Data);
          InvokeAssignMemberCall(AThread, call, top);
          Dec(TLMDPtrInt(top), call.ObjectOffset + VSIZE);

          if TLMDFrame(@frm) >= stepbase^ then
            FBreakpoints.SetStepBPs(AThread, stepbase, TLMDFrame(@frm),
                                    frm.IP, True);
          Inc(frm.IP);
        end;
        icAssignUnnamedCall:
        begin
          call       := TLMDCall(frm.IP.Data);
          AThread.PV := POleVariant(TLMDPtrInt(top) - call.ObjectOffset);

          case call.BracketType of
            bkVbRound,
            bkBlock:
            begin
              SetIndexed(POleVariant(TLMDPtrInt(top) - call.ObjectOffset)^, top,
                         PLMDVarArray(TLMDPtrInt(top) - call.ArgsOffset),
                         call.ArgCount);
              Dec(TLMDPtrInt(top), call.ObjectOffset + VSIZE);
            end;
          else
            ELMDVMRuntime.RaiseError(retCannotAssign);
          end;

          Inc(frm.IP);
        end;
        icAssignLValue:
        begin
          if PVarData(TLMDPtrInt(top) - VSIZE).VType <> (varByRef or
                                                      varVariant) then
            ELMDVMRuntime.RaiseError(retCannotAssign);

          VarResolveRefNoCheck(POleVariant(TLMDPtrInt(top) - VSIZE)^)^ := top^;
          Dec(top, 2);
          Inc(frm.IP);
        end;
        icAssignLocalVar:    // Like in icAssignGlobCall.
        begin
          VarMoveData(frm.Stack[Integer(frm.IP.Data)], top^);
          Dec(top);
          Inc(frm.IP);
        end;
        icAssignArg:         // Like in icAssignGlobCall.
        begin
          AThread.PV := @ACtx.Args[TLMDParamInfo(frm.IP.Data).Index];

          case TLMDParamKind(TLMDParamInfo(frm.IP.Data).Kind) of
            pkSimple:
              ; // Do nothing.
            pkConst:
              ELMDVMRuntime.RaiseError(retCannotAssign);
            pkByRef:
              AThread.PV := VarResolveRef(AThread.PV^);
          end;

          VarMoveData(AThread.PV^, top^);
          Dec(top);
          Inc(frm.IP);
        end;
        icAssignResult:      // Like in icAssignGlobCall.
        begin
          VarMoveData(ACtx.Result^, top^);
          Dec(top);
          Inc(frm.IP);
        end;
        icAssignGlobalVar:   // Like in icAssignGlobCall.
        begin
          VarMoveData(TLMDVarObject(frm.IP.Data).Value, top^);
          Dec(top);
          Inc(frm.IP);
        end;
        icAssignGlobalConst: // Special cmd, for constant initializers.
        begin
          VarMoveData(TLMDConstObject(frm.IP.Data).Value, top^);
          Dec(top);
          Inc(frm.IP);
        end;
        icCaseJmpIfEqual:
        begin
          if VarCompareOp(top^, POleVariant(TLMDPtrInt(top) - VSIZE)^, opCmpEQ) then
          begin
            frm.IP := TLMDLabel(frm.IP.Data).Target;
            Dec(top, 2);
          end
          else
          begin
            Inc(frm.IP);
            Dec(top);
          end;
        end;
        icCaseJmpIfInRange:
        begin
          if VarCompareOp(POleVariant(TLMDPtrInt(top) - 2 * VSIZE)^,
                          POleVariant(TLMDPtrInt(top) - VSIZE)^, opCmpGE) and
             VarCompareOp(POleVariant(TLMDPtrInt(top) - 2 * VSIZE)^,
                          top^, opCmpLE) then
          begin
            frm.IP := TLMDLabel(frm.IP.Data).Target;
            Dec(top, 3);
          end
          else
          begin
            Inc(frm.IP);
            Dec(top, 2);
          end;
        end;
        icForInitLValue:
        begin
          if PVarData(TLMDPtrInt(top) - VSIZE).VType <> (varByRef or
                                                         varVariant) then
            ELMDVMRuntime.RaiseError(retLoopVar);

          AThread.PV := VarResolveRefNoCheck(POleVariant(TLMDPtrInt(top) - VSIZE)^);

          frm.Stack[TLMDFor(frm.IP.Data).LoopVarRef] := TLMDPtrInt(AThread.PV);
          VarMoveData(AThread.PV^, top^);
          Dec(top, 2);
          Inc(frm.IP);
        end;
        icForInitLocal:
        begin
          AThread.PV := @frm.Stack[TLMDFor(frm.IP.Data).LoopLocalVar];

          frm.Stack[TLMDFor(frm.IP.Data).LoopVarRef] := TLMDPtrInt(AThread.PV);
          VarMoveData(AThread.PV^, top^);
          Dec(top);
          Inc(frm.IP);
        end;
        icForInc:
        begin
          AThread.PV := TVarData(frm.Stack[TLMDFor(frm.IP.Data).
                                           LoopVarRef]).VPointer;
          VarBinaryOp(AThread.PV^, OleOne, AThread.PV^, opAdd);
          Inc(frm.IP);
        end;
        icForIncStep:
        begin
          AThread.PV := TVarData(frm.Stack[TLMDFor(frm.IP.Data).
                                           LoopVarRef]).VPointer;
          VarBinaryOp(AThread.PV^, frm.Stack[TLMDFor(frm.IP.Data).StepVar],
                      AThread.PV^, opAdd);
          Inc(frm.IP);
        end;
        icForDec:
        begin
          AThread.PV := TVarData(frm.Stack[TLMDFor(frm.IP.Data).
                                           LoopVarRef]).VPointer;
          VarBinaryOp(AThread.PV^, OleOne, AThread.PV^, opSubtract);
          Inc(frm.IP);
        end;
        icForJmpIfLE:
        begin
          AThread.PV := TVarData(frm.Stack[TLMDFor(frm.IP.Data).
                                           LoopVarRef]).VPointer;
          if VarCompareOp(AThread.PV^, frm.Stack[TLMDFor(frm.IP.Data).ToVar],
                          opCmpLE) then
            frm.IP := TLMDFor(frm.IP.Data).JmpLabel.Target
          else
            Inc(frm.IP);
        end;
        icForJmpIfGE:
        begin
          AThread.PV := TVarData(frm.Stack[TLMDFor(frm.IP.Data).
                                           LoopVarRef]).VPointer;
          if VarCompareOp(AThread.PV^, frm.Stack[TLMDFor(frm.IP.Data).ToVar],
                          opCmpGE) then
            frm.IP := TLMDFor(frm.IP.Data).JmpLabel.Target
          else
            Inc(frm.IP);
        end;
        icForJmpStep:
        begin
          AThread.PV := TVarData(frm.Stack[TLMDFor(frm.IP.Data).
                                           LoopVarRef]).VPointer;

          if VarCompareOp(frm.Stack[TLMDFor(frm.IP.Data).StepVar],
                          OleZero, opcmpGE) then
          begin
            if VarCompareOp(AThread.PV^, frm.Stack[TLMDFor(frm.IP.Data).ToVar],
                            opCmpLE) then
            begin
              frm.IP := TLMDFor(frm.IP.Data).JmpLabel.Target;
              Continue; // Main while
            end;
          end
          else
          begin
            if VarCompareOp(AThread.PV^, frm.Stack[TLMDFor(frm.IP.Data).ToVar],
                            opCmpGE) then
            begin
              frm.IP := TLMDFor(frm.IP.Data).JmpLabel.Target;
              Continue; // Main while
            end;
          end;

          Inc(frm.IP);
        end;
        icIs:
        begin
          if Assigned(FOnIsTest) then
            FOnIsTest(Self, POleVariant(TLMDPtrInt(top) - VSIZE)^, top^, isres)
          else
            isres := False;

          Dec(top);
          top^ := isres;
          Inc(frm.IP);
        end;
        icRaise:
        begin
          if Assigned(FOnVarToException) then
            FOnVarToException(Self, top^, e);
          if e = nil then
            ELMDVMRuntime.RaiseError(retCannotRaiseNil);

          cure := frm.ExcSt;
          while cure <> nil do // Do not allow to raise owned by the list
                               // exception. This can lead to repeated
                               // destruction of the same exception object.
          begin
            if e = cure.ExceptObj then
              ELMDVMRuntime.RaiseError(retCannotRaiseLocked);
            cure := cure.Next;
          end;

          raise e;
        end;
        isReraise:
        begin
          e := PExcVarData(@frm.Stack[Integer(frm.IP.Data)]).ExceptObj;
          raise e;
        end;
        icRaiseEBCFromFinally:
        begin
          ELMDVMRuntime.RaiseError(retEBCFromFinally);
        end;
        icFinallyRet:
        begin
          frm.IP := TVarData(frm.Stack[TLMDTry(frm.IP.Data).
                                       FinallyRetVar]).VPointer;
        end;
        icCallFinally:
        begin
          frm.Stack[TLMDTry(frm.IP.Data).FinallyRetVar] := TLMDPtrInt(frm.IP) +
                                                           SizeOf(TLMDInstr);
          frm.IP := TLMDTry(frm.IP.Data).FinallyLabel.Target;
        end;
        icExceptJmpIfIs:
        begin
          isres := False;
          e     := Exception(TVarData(frm.Stack[TLMDExcJump(frm.IP.Data).
                                                 Try_.ExceptionVar]).vInteger);
          if Assigned(FOnExceptionIsTest) then
            FOnExceptionIsTest(Self, e, top^, isres);

          if isres then
          begin
            Dec(top);
            frm.IP := TLMDExcJump(frm.IP.Data).Label_.Target;
            Continue; // Main while
          end;

          Dec(top);
          Inc(frm.IP);
        end;
        icExceptDone:
        begin
          PExcVarData(frm.ExcSt).ExceptObj.Free;
          frm.ExcSt := PExcVarData(frm.ExcSt).Next;
          Inc(frm.IP);
        end;
        icExceptToVar:
        begin
          AThread.V := OleUnassigned;
          e         := PExcVarData(@frm.Stack[Integer(frm.IP.Data)]).ExceptObj;

          if Assigned(FOnExceptionToVar) then
            FOnExceptionToVar(Self, e, AThread.V);

          Inc(top);
          VarMoveData(top^, AThread.V);
          Inc(frm.IP);
        end;
        icSetNamespace:
        begin
          frm.CurNS := TLMDAbstractNamespace(frm.IP.Data);
          Inc(frm.IP);
        end;
        icArrayCreate:
        begin
          CreateArray(TLMDArray(frm.IP.Data),
            PLMDVarArray(TLMDPtrInt(top) - TLMDArray(frm.IP.Data).ArgsOffset),
            AThread.V);

          Dec(TLMDPtrInt(top), TLMDArray(frm.IP.Data).ArgsOffset);
          VarMoveData(top^, AThread.V);
          Inc(frm.IP);
        end;
        icArrayRedimLValue:
        begin
          AThread.PV := POleVariant(TLMDPtrInt(top) - TLMDArrayRedim(frm.IP.Data)
                                    .ArrayOffset);
          if PVarData(AThread.PV).VType <> (varByRef or varVariant) then
            ELMDVMRuntime.RaiseError(retCannotAssign);

          RedimArray(TLMDArrayRedim(frm.IP.Data),
                     VarResolveRefNoCheck(AThread.PV^)^,
                     PLMDVarArray(TLMDPtrInt(top) - TLMDArrayRedim(frm.IP.Data)
                     .ArgsOffset));

          Dec(TLMDPtrInt(top), TLMDArrayRedim(frm.IP.Data).ArrayOffset);
          Inc(frm.IP);
        end;
        icArrayRedimLocal:
        begin
          RedimArray(TLMDArrayRedim(frm.IP.Data),
                     frm.Stack[TLMDArrayRedim(frm.IP.Data).ArrayLocalVar],
                     PLMDVarArray(TLMDPtrInt(top) - TLMDArrayRedim(frm.IP.Data)
                     .ArgsOffset));

          Dec(TLMDPtrInt(top), TLMDArrayRedim(frm.IP.Data).ArgsOffset);
          Inc(frm.IP);
        end;
        icEventHandlerMake:
        begin
          Inc(top);
          MakeEventHandler(PWideString(frm.IP.Data)^, top^);
          Inc(frm.IP);
        end;
        icPushLocalVar:    // Like in icGlobCall.
        begin
          Inc(top);
          top^ := frm.Stack[Integer(frm.IP.Data)];
          Inc(frm.IP);
        end;
        icPushLocalConst:  // Like in icGlobCall.
        begin
          Inc(top);
          top^ := POleVariant(frm.IP.Data)^;
          Inc(frm.IP);
        end;
        icPushArg:         // Like in icGlobCall.
        begin
          Inc(top);
          top^ := VarResolveRef(ACtx.Args[TLMDParamInfo(frm.IP.Data).Index])^;
          Inc(frm.IP);
        end;
        icPushResult:      // Like in icGlobCall.
        begin
          Inc(top);
          top^ := ACtx.Result^;
          Inc(frm.IP);
        end;
        icPushLocalVarRef: // Like in icGlobCallRef.
        begin
          Inc(top);
          VarMakeRef(top^, frm.Stack[Integer(frm.IP.Data)]);
          Inc(frm.IP);
        end;
        icPushArgRef:      // Like in icGlobCallRef.
        begin
          Inc(top);
          AThread.PV := @ACtx.Args[TLMDParamInfo(frm.IP.Data).Index];

          case TLMDParamKind(TLMDParamInfo(frm.IP.Data).Kind) of
            pkSimple: // If the arg value is ref-to-var, we SHOULD
                      // replace the ref-to-var with explicit value.
            begin
              if PVarData(AThread.PV).VType = (varByRef or varVariant) then
                AThread.PV^ := VarResolveRefNoCheck(AThread.PV^)^;
              VarMakeRef(top^, AThread.PV^);
            end;
            pkConst:
              top^ := VarResolveRef(AThread.PV^)^;
            pkByRef:
              VarMakeRef(top^, VarResolveRef(AThread.PV^)^);
          end;

          Inc(frm.IP);
        end;
        icPushResultRef:   // Like in icGlobCallRef.
        begin
          Inc(top);
          VarMakeRef(top^, ACtx.Result^);
          Inc(frm.IP);
        end;
        icRet:
        begin
          goto LRet;
        end;
        icBreakpointJmp:
        begin
          frm.IP := PLMDInstr(frm.IP.Data);
        end;
        icBreak:
        begin
          FTerminateFlag := Integer(ic_Mask); // Before closing check.

          if VMIndexes.IsInactiveOrClosing(FId) then
          begin
            FTerminateFlag := 0; // Restore zero, if closing.
            ELMDVMRuntime.RaiseError(retAborted);
          end;

          case FBreakpoints.GetInfo(AThread, FDebugger, stepbase,
                                    TLMDFrame(@frm.Stack), frm.IP,
                                    bknd, brkcmds[0]) of
            bpirOk:
            begin
              brkcmds[1]      := frm.IP^; // Copy other fields as is.
              brkcmds[1].Code := icBreakpointJmp;
              brkcmds[1].Data := TObject(TLMDPtrInt(frm.IP) + SizeOf(TLMDInstr));

              HandleBreakpoint(AThread, @frm, stepbase, bknd);
              frm.IP := @brkcmds[0];
            end;
            bpirCausedBreak:
            begin
              // Note: Caused break can occures INSIDE breakpoint chunk
              // (e.g. brkcmds), so, since only one chunk is available to
              // Interpret, we should avoid re-initializing the chunk
              // recursively.
              // This why bpirCausedBreak is different from the bpirOk.

              HandleBreakpoint(AThread, @frm, stepbase, bknd);
              Continue; // Main while.
            end;
            bpirGoThrough: // No stopping on this breakpoint. Continue
                           // silently.
            begin
              brkcmds[1]      := frm.IP^; // Copy other fields as is.
              brkcmds[1].Code := icBreakpointJmp;
              brkcmds[1].Data := TObject(TLMDPtrInt(frm.IP) + SizeOf(TLMDInstr));

              frm.IP := @brkcmds[0];
            end;
            bpirBPRemoved:    // This can happen due to threading issues. In
                              // this case we should re-execute original command.
              Continue; // Main while.
            bpirNoBPInfo:
            begin
              FBreakpoints.RemoveStepBps(AThread, stepbase);
              ELMDVMRuntime.RaiseError(retIENoBreakpointInfo);
            end;
          end;
        end;
      else
        ELMDVMRuntime.RaiseError(retIEInvalidInstr);
      end;
    end; // Main while

LRet:
    // Note: This code should be duplicated in exception hanlder below.
    // 
    // We should set stepbase to STEP_STOPATANY. First, this is valid, because
    // we already leaving current procedure, so, no child invokations will be
    // possible. Second, since we use phisical process stack addresses as
    // SingleStepBase values, we SHOULD reset the value to preserve stepping
    // mode even when the last (most parent) script invokation is finished.
    // This is because next time the script code can be invoked from another
    // (longer) phisical process stack.

    if stepbase^ = TLMDFrame(@frm) then
      stepbase^ := STEP_STOPATANY;
    AThread.CallStack := AThread.CallStack.Next;
    AThread.StackPool.ReleaseStack(ACtx.Code.StackSize);
    Exit;
    
  except
    e := Exception(AcquireExceptionObject);
    FormatException(AThread, ACtx.Source, e, frm.IP.SourceInfo and LMD_SPOSMASK);

    if (frm.IP.TryIndex <> -1) and (FTerminateFlag <> 0) then
    begin
      tryhdr     := ACtx.Code.Trys[frm.IP.TryIndex];
      AThread.PV := @frm.Stack[tryhdr.ExceptionVar];

      UnwindTo(PExcVarData(frm.ExcSt), e, tryhdr.HdrHierLow);
      with PExcVarData(AThread.PV)^ do
      begin
        if (VType1 and VARDEEPDATA) <> 0 then
          VarClear(POleVariant(@VType1)^);
        if (VType2 and VARDEEPDATA) <> 0 then
          VarClear(POleVariant(@VType2)^);

        VType1    := varInteger;
        VType2    := varInteger;
        Try_      := tryhdr;
        ExceptObj := e;
        Next      := PExcVarData(frm.ExcSt);
        frm.ExcSt := PExcVarData(AThread.PV);
      end;

      if TLMDFrame(@frm) >= stepbase^ then
        FBreakpoints.SetExcStepBPs(AThread, stepbase, TLMDFrame(@frm),
                                   tryhdr);

      top    := POleVariant(TLMDPtrInt(frm.Stack) + ACtx.Code.StackLocalsOffset);
      frm.IP := tryhdr.HandlerLabel.Target;
    end
    else
    begin
      Unwind(PExcVarData(frm.ExcSt), e);

      // Note: This code should be same as at the LRet
      //       label above.

      if stepbase^ = TLMDFrame(@frm) then
        stepbase^ := STEP_STOPATANY;
      AThread.CallStack := AThread.CallStack.Next;
      AThread.StackPool.ReleaseStack(ACtx.Code.StackSize);
      raise e;
    end;
  end;

  goto LInstrLoop;
end;

{------------------------------------------------------------------------------}
procedure TLMDVirtMachine.RaiseValObjNotFound(const AStrName: WideString);
var
  name: Integer;
begin
  name := GlobNameTable.GetNameIndex(AStrName, False);
  if FScriptGlobals.Find(name) <> nil then
    ELMDVMRuntime.RaiseError(retValObjRequired);

  ELMDVMRuntime.RaiseError(retUndeclaredId, AStrName);
end;

procedure TLMDVirtMachine.RaiseVMNotActive;
begin
  // This function hides resourcestring conversion from
  // the caller, so optimizing the caller performance.

  raise ELMDVirtMachine.Create(SLMDVMActive);
end;

{------------------------------------------------------------------------------}
class procedure TLMDVirtMachine.InvokeDispatchMember(ACall: TLMDCall;
  const AObj: IDispatch; ADispId: Integer; AArgs: PLMDVarArray;
  var OleResult: OleVariant);
const
  DISP_FLAGS: array[TLMDBracketType] of DWord = (
      DISPATCH_METHOD or DISPATCH_PROPERTYGET, // bkNon
      DISPATCH_METHOD or DISPATCH_PROPERTYGET, // bkVbRound
      DISPATCH_METHOD,                         // bkRound
      DISPATCH_PROPERTYGET                     // bkBlock
  );
var
  hr        : HRESULT;
  dispprms  : TDispParams;
  enfo      : packed array[0..SizeOf(TExcepInfo) - 1] of Byte;
  i         : Integer;
  args      : array[0..MAX_ARG_COUNT - 1] of TVariantArg;
  pres      : POleVariant;
begin
  with dispprms do
  begin
    cArgs := ACall.ArgCount;
    if cArgs > MAX_ARG_COUNT - 1 then
      ELMDVMRuntime.RaiseError(retInvalidParamCount);

    // Arguments should be treated by IDispatch as readonly,
    // so we just copy memory, without add-refs/releases.

    for i := 0 to cArgs - 1 do
      args[i] := TVariantArg(AArgs[cArgs - 1 - i]);

    rgvarg            := @args[0];
    rgdispidNamedArgs := nil;
    cNamedArgs        := 0;
  end;

  FillChar(enfo, SizeOf(TExcepInfo), 0);
  pres := POleVariant(DWORD(@OleResult) and ACall.ResMask);
  hr   := AObj.Invoke(ADispId, GUID_NULL, 0, DISP_FLAGS[ACall.BracketType],
                      dispprms, pres, @enfo, nil);

  if hr <> S_OK then
    ELMDVMRuntime.RaiseError(hr, TExcepInfo(enfo), True);
end;

{------------------------------------------------------------------------------}
class procedure TLMDVirtMachine.InvokeMemberCall(AThread: TLMDThread;
  ACall: TLMDCall; ATop: POleVariant);
var
  dispId: Integer;
  obj:    Pointer;
  cdo:    TLMDCodeObject;
begin
  obj := POleVariant(TLMDPtrInt(ATop) - ACall.ObjectOffset);

  case PVarData(obj).VType of // Like in _VarToDisp in Variants.pas Vcl unit.
    varDispatch:             obj := PVarData(obj).VDispatch;
    varDispatch or varByRef: obj := Pointer(PVarData(obj).VPointer^);
    varNull,
    varEmpty:                obj := nil;
  else
    VarCastError;
  end;

  if obj = nil then
    ELMDVMRuntime.RaiseError(retObjectRequired);

  if IDispatch(obj).QueryInterface(VM_GUID, cdo) = S_OK then
  begin
    if not cdo.GetIdOfName(ACall.Name, dispId) then
      ELMDVMRuntime.RaiseError(retUndeclaredId, ACall.StrName);

    cdo.InvokeMember(AThread, dispId, ACall.BracketType,
                     ACall.ResMask, ACall.ArgCount,
                     PLMDVarArray(TLMDPtrInt(ATop) - ACall.ArgsOffset),
                     POleVariant(TLMDPtrInt(ATop) - ACall.ResOffset)^);
  end
  else
  begin
    if IDispatch(obj).GetIDsOfNames(GUID_NULL, @ACall.StrName, 1, 0,
                                    @dispId) <> S_OK then
      ELMDVMRuntime.RaiseError(retUndeclaredId, ACall.StrName);

    InvokeDispatchMember(ACall, IDispatch(obj), dispId,
                         PLMDVarArray(TLMDPtrInt(ATop) - ACall.ArgsOffset),
                         POleVariant(TLMDPtrInt(ATop) - ACall.ResOffset)^);
  end;
end;

{------------------------------------------------------------------------------}
class procedure TLMDVirtMachine.InvokeDispatchPropPut(ACall: TLMDCall;
  const AObj: IDispatch; ADispId: Integer; AArgs: PLMDVarArray;
  AValue: POleVariant);
const
  NamedArgs: Longint = DISPID_PROPERTYPUT;
var
  hr        : HRESULT;
  enfo      : packed array[0..SizeOf(TExcepInfo) - 1] of Byte;
  dispprms  : TDispParams;
  args      : array[0..MAX_ARG_COUNT] of TVariantArg;
  i         : Integer;
begin
  if ACall.BracketType = bkRound then
    ELMDVMRuntime.RaiseError(retCannotAssign);

  with dispprms do
  begin
    cArgs := ACall.ArgCount + 1;
    if cArgs > MAX_ARG_COUNT - 1 then
      ELMDVMRuntime.RaiseError(retInvalidParamCount);

    // Arguments should be treated by IDispatch as readonly,
    // so we just copy memory, without add-refs/releases.

    args[0] := PVariantArg(AValue)^;
    for i := 1 to cArgs - 1 do
      args[i] := TVariantArg(AArgs[cArgs - 1 - i]);

    rgvarg            := @args[0];
    rgdispidNamedArgs := @NamedArgs;
    cNamedArgs        := 1;
  end;

  FillChar(enfo, SizeOf(TExcepInfo), 0);
  hr := AObj.Invoke(ADispId, GUID_NULL, 0, DISPATCH_PROPERTYPUT or
                    DISPATCH_PROPERTYPUTREF, dispprms, nil, @enfo, nil);

  if hr <> S_OK then
    ELMDVMRuntime.RaiseError(hr, TExcepInfo(enfo), True);
end;

{------------------------------------------------------------------------------}
class procedure TLMDVirtMachine.InvokeAssignMemberCall(AThread: TLMDThread;
  ACall: TLMDCall; ATop: POleVariant);
var
  dispId: Integer;
  obj:    Pointer;
  cdo:    TLMDCodeObject;
begin
  obj := POleVariant(TLMDPtrInt(ATop) - ACall.ObjectOffset);

  case PVarData(obj).VType of // Like in _VarToDisp in Variants.pas Vcl unit.
    varDispatch:             obj := PVarData(obj).VDispatch;
    varDispatch or varByRef: obj := Pointer(PVarData(obj).VPointer^);
    varNull,
    varEmpty:                obj := nil;
  else
    VarCastError;
  end;

  if obj = nil then
    ELMDVMRuntime.RaiseError(retObjectRequired);

  if IDispatch(obj).QueryInterface(VM_GUID, cdo) = S_OK then
  begin
    if not cdo.GetIdOfName(ACall.Name, dispId) then
      ELMDVMRuntime.RaiseError(retUndeclaredId, ACall.StrName);

    cdo.InvokePropPut(AThread, dispId, ACall.BracketType, ACall.ArgCount,
                      PLMDVarArray(TLMDPtrInt(ATop) - ACall.ArgsOffset),
                      ATop);
  end
  else
  begin
    if IDispatch(obj).GetIDsOfNames(GUID_NULL, @ACall.StrName, 1, 0,
                                    @dispId) <> S_OK then
      ELMDVMRuntime.RaiseError(retUndeclaredId, ACall.StrName);

    InvokeDispatchPropPut(ACall, IDispatch(obj), dispId,
                          PLMDVarArray(TLMDPtrInt(ATop) - ACall.ArgsOffset),
                          ATop);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDVirtMachine.InvokeProcNoChecks(AThread: TLMDThread;
  AProc: TLMDProcObject; AArgs: PLMDVarArray; var OleResult: OleVariant);
var
  ctx: TLMDVMInterpretContext;
begin
  ctx.Code   := AProc.ByteCode;
  ctx.Args   := PLMDVarArray(AArgs);
  ctx.Result := @OleResult;
  ctx.Source := nil;
  
  Interpret(AThread, ctx);
end;

{------------------------------------------------------------------------------}
class procedure TLMDVirtMachine.CreateArray(AArray: TLMDArray;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  i:      Integer;
  bnds:   array[0..MAX_ARRAY_BOUNDS] of TVarArrayBound;
  argcnt: Integer;
  arr:    PSafeArray;
begin
  argcnt := AArray.DimCount * 2;
  if argcnt > MAX_ARRAY_BOUNDS - 1 then
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  for i := 0 to AArray.DimCount - 1 do
    with bnds[i] do
    begin
      LowBound     := AArgs[i * 2];
      ElementCount := AArgs[i * 2 + 1] - LowBound + 1;
    end;

  arr := SafeArrayCreate(AArray.ElemVarType, AArray.DimCount,
                         {$IFDEF LMDCOMP16}@bnds{$ELSE}PVarArrayBoundArray(@bnds)^
                         {$ENDIF});
  if arr = nil then
    VarArrayCreateError;

  if (TVarData(AResult).VType and VARDEEPDATA) <> 0 then
    VarClear(AResult);
  TVarData(AResult).VType   := AArray.ElemVarType or varArray;
  TVarData(AResult).VArray  := PVarArray(arr);
end;

{------------------------------------------------------------------------------}
class function TLMDVirtMachine.GetArray(const AArray: OleVariant;
  out AElemType: TVarType): PSafeArray;
label
  L;
var
  v: PVarData;
begin
  v := @AArray;
L:
  if (v.VType and varArray) <> 0 then
  begin
    if (v.VType and varByRef) <> 0 then
      Result := PSafeArray(v.VPointer^)
    else
      Result := PSafeArray(v.VArray);
  end
  else if v.VType = (varByRef or varVariant) then
  begin
    v := PVarData(VarResolveRefNoCheck(OleVariant(v^)));
    goto L;
  end
  else
  begin
    Result := nil; // Initialize.
    VarCastError;
  end;

  AElemType := v.VType and varTypeMask;
end;

class procedure TLMDVirtMachine.GetArrayElem(AArray: PSafeArray;
  AElemType: TVarType; AIndices: PInteger; var AResult: OleVariant);
var
  elemp:   Pointer;
  elemdt:  TVarData;
begin
  if AElemType = varVariant then
  begin
    VarResultCheck(SafeArrayPtrOfIndex(AArray, AIndices^, elemp));
    AResult := OleVariant(elemp^);
  end
  else
  begin
    elemdt.VType := AElemType;
    VarResultCheck(SafeArrayGetElement(AArray, AIndices^,
                                       elemdt.VPointer));
    VarMoveData(AResult, OleVariant(elemdt));
  end;
end;

{------------------------------------------------------------------------------}
function TLMDVirtMachine.GetCodeObject: IDispatch;
begin
  FSection.Acquire;
  try
    if not (FState in [msInitialized, msActive]) then
      raise ELMDVirtMachine.Create(SLMDVMInitialize);
    Result := FCodeObject;
  finally
    FSection.Release;
  end;
end;

{------------------------------------------------------------------------------}
class procedure TLMDVirtMachine.GetIndexed(AArgCount: Integer;
  const AIndexed: OleVariant; AArgs: PLMDVarArray; var AResult: OleVariant);
label
  L, L_ARRAY, L_DISPATCH;
var
  v:        PVarData;
  p:        Pointer;
  i:        Integer;
  indices:  array[0..MAX_ARRAY_BOUNDS] of Integer;
  dispprms: TDispParams;
  enfo:     packed array[0..SizeOf(TExcepInfo) - 1] of Byte;
  hr:       HResult;
  args:     array[0..MAX_ARG_COUNT - 1] of TVariantArg;
begin
  v := @AIndexed;
L:
  case v.VType of
    varDispatch:              begin
                                p := v.VDispatch;
                                goto L_DISPATCH;
                              end;
    varByRef or varDispatch:  begin
                                p := Pointer(v.VPointer^);
                                goto L_DISPATCH;
                              end;
    varByRef or varVariant:   begin
                                v := PVarData(VarResolveRefNoCheck(OleVariant(v^)));
                                goto L;
                              end;
  else
    if (v.VType and varArray) <> 0 then
    begin
      if (v.VType and varByRef) <> 0 then
        p := PSafeArray(v.VPointer^)
      else
        p := PSafeArray(v.VArray);
      goto L_ARRAY;
    end
    else
      ELMDVMRuntime.RaiseError(retTypeMismatch);
  end;

L_ARRAY:

  if AArgCount > MAX_ARRAY_BOUNDS - 1 then
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  { Init indices }

  if PSafeArray(p).cDims <> AArgCount then
    ELMDVMRuntime.RaiseError(retInvalidParamCount);
  for i := 0 to AArgCount - 1 do
    indices[i] := AArgs[i];

  { Get elem }

  GetArrayElem(PSafeArray(p), v.VType and varTypeMask,
               @indices[0], AResult);
  Exit; // Done.

L_DISPATCH:

  with dispprms do
  begin
    cArgs := AArgCount;
    if cArgs > MAX_ARG_COUNT - 1 then
      ELMDVMRuntime.RaiseError(retInvalidParamCount);

    // Arguments should be treated by IDispatch as readonly,
    // so we just copy memory, without add-refs/releases.

    for i := 0 to cArgs - 1 do
      args[i] := TVariantArg(AArgs[cArgs - 1 - i]);

    rgvarg            := @args[0];
    rgdispidNamedArgs := nil;
    cNamedArgs        := 0;
  end;

  FillChar(enfo, SizeOf(TExcepInfo), 0);
  hr := IDispatch(p).Invoke(DISPID_VALUE, GUID_NULL, 0, DISPATCH_PROPERTYGET,
                            dispprms, @AResult, @enfo, nil);
  if hr <> S_OK then
    ELMDVMRuntime.RaiseError(hr, TExcepInfo(enfo), True);
end;

{------------------------------------------------------------------------------}
procedure TLMDVirtMachine.AddIntrinsicProc(AObject: TLMDGlobalObject);
begin
  FIntrinsicObjects.Add(AObject);
end;

class procedure TLMDVirtMachine.AddRangeToSet(var ASet: OleVariant; AMinElem,
  AMaxElem: Integer);
begin
  if (AMinElem < 0) or (AMinElem > 31) then
    ELMDVMRuntime.RaiseError(retViolatesBounds);
  if (AMaxElem < 0) or (AMaxElem > 31) then
    ELMDVMRuntime.RaiseError(retViolatesBounds);

  ASet := SET_BITS[AMinElem].Low xor SET_BITS[AMaxElem].High;
end;

{------------------------------------------------------------------------------}
class procedure TLMDVirtMachine.AddValToSet(var ASet: OleVariant;
  AElem: Integer);
begin
  if (AElem < 0) or (AElem > 31) then
    ELMDVMRuntime.RaiseError(retViolatesBounds);
  ASet := Integer(ASet) or (1 shl AElem);
end;

{------------------------------------------------------------------------------}
function TLMDVirtMachine.AddExternObject(AObj: IDispatch;
  const AName: WideString; APublishMembers: Boolean): Boolean;
begin
  Result := False; // Initialize.
  FSection.Acquire;
  try
    if not (FState in [msInitialized, msActive]) then
      raise ELMDVirtMachine.Create(SLMDVMInitialize);
      
    Result := FExternObjects.Add(AObj, AName, APublishMembers);
  finally
    FSection.Release;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDVirtMachine.EmitGlobalCode: TLMDByteCode;
var
  i: Integer;
begin
  { Emit procedures }

  for i := 0 to FProcedures.Count - 1 do
    TLMDProcObject(FProcedures[i]).EmitByteCode(FGlobalNamespace);

  { Emit global code }

  Result := TLMDByteCode.Create;
  try
    Result.BeginEmit('Global code', FGlobalNamespace, 0);

    for i := 0 to FGlobalStmts.Count - 1 do
      ILMDEmitable(FGlobalStmts[i]).Emit(FGlobalNamespace, Result);

    Result.Emit(icRet, nil);
    Result.EndEmit;
  except
    Result.Free;
    raise;
  end;
end;

function TLMDVirtMachine.Eval(APreparedExpr: TObject): OleVariant;
var
  pcd:       TPreparedDynCode;
  ctx:       TLMDVMInterpretContext;
  trddt:     TLMDThreadData;
  threadVM:  TLMDThreadVM;
begin
  pcd    := TPreparedDynCode(APreparedExpr);
  trddt  := ThreadData;

  if FId.Index >= trddt.VMDataLength then
    trddt.Thread := VMIndexes.InitThread(FId);

  threadVM := trddt.Thread.VMData[FId.Index];

  if not threadVM.Lock then
    RaiseVMNotActive;
  try
    ctx.Code   := pcd.FByteCode;
    ctx.Args   := nil;
    ctx.Result := @Result;
    ctx.Source := pcd.FSource;
    Interpret(trddt.Thread, ctx);
  finally
    threadVM.Unlock;
  end;
end;

procedure TLMDVirtMachine.ExecStmt(APreparedStmt: TObject);
var
  pcd:       TPreparedDynCode;
  ctx:       TLMDVMInterpretContext;
  trddt:     TLMDThreadData;
  threadVM:  TLMDThreadVM;
begin
  pcd    := TPreparedDynCode(APreparedStmt);
  trddt  := ThreadData;
  
  if FId.Index >= trddt.VMDataLength then
    trddt.Thread := VMIndexes.InitThread(FId);

  threadVM := trddt.Thread.VMData[FId.Index];

  if not threadVM.Lock then
    RaiseVMNotActive;
  try
    ctx.Code   := pcd.FByteCode;
    ctx.Args   := nil;
    ctx.Result := nil;
    ctx.Source := pcd.FSource;
    Interpret(trddt.Thread, ctx);
  finally
    threadVM.Unlock;
  end;
end;

procedure TLMDVirtMachine.FormatException(AThread: TLMDThread;
  ASource: TLMDVMSource; E: Exception; APos: Integer);
var
  line, lnpos: Integer;
begin
  if not AThread.VMData[FId.Index].InBreak then
  begin
    if ASource = nil then
      ASource := FSource;
    ASource.PosToLine(APos, line, lnpos);

    if Assigned(FOnFormatException) then
      FOnFormatException(Self, line, lnpos, E);
  end;
end;

{****************************** TLMDExternObjects *****************************}
{------------------------------------------------------------------------------}
procedure TLMDExternObjects.Close;
begin
  FSection.Acquire;
  try
    FObjects.Clear;
    FPubMrsObjs.Clear;
    FChangeNumber := 0;
  finally
    FSection.Release;
  end;
end;

{------------------------------------------------------------------------------}
constructor TLMDExternObjects.Create(AVM: TLMDVirtMachine);
begin
  inherited Create;

  FVM         := AVM;
  FSection    := TCriticalSection.Create;
  FPubMrsObjs := TList.Create;
  FObjects    := TLMDNameHashTable.Create(True);
end;

{------------------------------------------------------------------------------}
destructor TLMDExternObjects.Destroy;
begin
  FSection.Free;
  FObjects.Free;
  FPubMrsObjs.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDExternObjects.Add(const AObj: IDispatch;
  const AName: WideString; APublishMembers: Boolean): Boolean;
var
  idx:    Integer;
  extern: TLMDExternObject;
  cdo:    TLMDCodeObject;
begin
  idx := GlobNameTable.GetNameIndex(AName);
  cdo := nil;
  AObj.QueryInterface(VM_GUID, cdo);

  FSection.Acquire;
  try
    extern := TLMDExternObject.Create(idx, AName, AObj, cdo,
                                      APublishMembers);
    Result := FObjects.Add(extern);

    if Result then
    begin
      if APublishMembers then
        FPubMrsObjs.Add(extern);
      Inc(FChangeNumber);
    end
    else
      extern.Free;
  finally
    FSection.Release;
  end;
end;

{************************** TGlobalObjectsNamespace ***************************}
{------------------------------------------------------------------------------}
constructor TGlobalObjectsNamespace.Create(
  AVM: TLMDVirtMachine);
begin
  inherited Create(nil);
  FVM        := AVM;
  FVMIdIndex := AVM.FId.Index
end;

{------------------------------------------------------------------------------}
procedure TGlobalObjectsNamespace.EnumDebugVars(
  ALocalsOnly: Boolean; AProc: TLMDNamespaceEnumVarsProc);
var
  i:    Integer;
  sres: TLMDNameSearchRes;
begin
  if not ALocalsOnly then
  begin
    for i := 0 to FVM.FGlobalConsts.Count - 1 do
    begin
      sres.ObjKind     := srGlobalConst;
      sres.NamedObject := FVM.FGlobalConsts[i];
      AProc(TLMDConstObject(FVM.FGlobalConsts[i]).StrName, sres);
    end;

    for i := 0 to FVM.FGlobalVars.Count - 1 do
    begin
      sres.ObjKind     := srGlobalConst;
      sres.NamedObject := FVM.FGlobalVars[i];
      AProc(TLMDVarObject(FVM.FGlobalVars[i]).StrName, sres);
    end;
  end;
end;

function TGlobalObjectsNamespace.Find(AThread: Pointer; ANameIndex: Integer;
  AStrName: PWideString): TLMDNameSearchRes;
var
  threadVM: TLMDThreadVM;
begin
  // Since a search is performed only inside working VM, the VM is already
  // locked, so the threadVM item is guaranteed to exist here.

  threadVM := TLMDThread(AThread).VMData[FVMIdIndex];
  Result   := threadVM.Globals.Search(ANameIndex, AStrName^);
end;

{******************************** TLMDStackItem *******************************}
{------------------------------------------------------------------------------}
constructor TLMDStackItem.Create(ASize: Integer; APrev: TLMDStackItem);
begin
  inherited Create;

  FSize         := ASize;
  FPrev         := APrev;
  FUsedItemSize := 0;
  SetLength(FData, FSize);
end;

{******************************* TLMDStackPool ********************************}
{------------------------------------------------------------------------------}
function TLMDStackPool.AsquireStack(ASize: Integer): PLMDVarArray;
label
  L;
var
  itemsz: Integer;
  cur:    PLMDVarArray;
begin
  if (FLast = nil) or (FLast.FSize - FLast.FUsedItemSize < ASize) then
  begin
    itemsz := 256;
    if ASize > itemsz then
      itemsz := ASize;
    FLast := TLMDStackItem.Create(itemsz, FLast);
  end;

  Result := @FLast.FData[FLast.FUsedItemSize];
  Inc(FLast.FUsedItemSize, ASize);

  { Clear stack content }

  cur := Result;

L:
  case ASize of
    0:  Exit;
    1:  begin
          if (TVarData(cur[0]).VType and VARDEEPDATA) <> 0 then
            VarClear(cur[0]);
          TVarData(cur[0]).VType := varEmpty;
        end;
    2:  begin
          if (TVarData(cur[0]).VType and VARDEEPDATA) <> 0 then
            VarClear(cur[0]);
          if (TVarData(cur[1]).VType and VARDEEPDATA) <> 0 then
            VarClear(cur[1]);
          TVarData(cur[0]).VType := varEmpty;
          TVarData(cur[1]).VType := varEmpty;
        end;
    3:  begin
          if (TVarData(cur[0]).VType and VARDEEPDATA) <> 0 then
            VarClear(cur[0]);
          if (TVarData(cur[1]).VType and VARDEEPDATA) <> 0 then
            VarClear(cur[1]);
          if (TVarData(cur[2]).VType and VARDEEPDATA) <> 0 then
            VarClear(cur[2]);
          TVarData(cur[0]).VType := varEmpty;
          TVarData(cur[1]).VType := varEmpty;
          TVarData(cur[2]).VType := varEmpty;
        end;
  else
    if (TVarData(cur[0]).VType and VARDEEPDATA) <> 0 then
      VarClear(cur[0]);
    if (TVarData(cur[1]).VType and VARDEEPDATA) <> 0 then
      VarClear(cur[1]);
    if (TVarData(cur[2]).VType and VARDEEPDATA) <> 0 then
      VarClear(cur[2]);
    if (TVarData(cur[3]).VType and VARDEEPDATA) <> 0 then
      VarClear(cur[3]);
    TVarData(cur[0]).VType := varEmpty;
    TVarData(cur[1]).VType := varEmpty;
    TVarData(cur[2]).VType := varEmpty;
    TVarData(cur[3]).VType := varEmpty;

    Dec(ASize, 4);
    Inc(TLMDPtrInt(cur), 4 * VSIZE);

    goto L;
  end;
end;

{------------------------------------------------------------------------------}
constructor TLMDStackPool.Create;
begin
  inherited Create;
  FLast := nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDStackPool.Destroy;
var
  cur: TLMDStackItem;
begin
  while FLast <> nil do
  begin
    cur   := FLast;
    FLast := FLast.FPrev;

    cur.Free;
  end;

  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDStackPool.ReleaseStack(ASize: Integer);
var
  cur: TLMDStackItem;
begin
  Dec(FLast.FUsedItemSize, ASize);

  if (FLast.FUsedItemSize = 0) and (FLast.FPrev <> nil) then
  begin
    cur   := FLast;
    FLast := FLast.FPrev;

    cur.Free;
  end;
end;

{******************************* TLMDCodeObject *******************************}
{------------------------------------------------------------------------------}
constructor TLMDCodeObject.Create(AVM: TLMDVirtMachine);
begin
  inherited Create;

  FId           := AVM.FId;
  FIdsByStrName := TLMDIdentifierHashTable.Create(True);
  FIdsByName    := TLMDNameHashTable.Create(True);

  Init(AVM);
end;

{------------------------------------------------------------------------------}
destructor TLMDCodeObject.Destroy;
begin
  FIdsByStrName.Free;
  FIdsByName.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDCodeObject.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
var
  i:    Integer;
  item: TLMDIdentifierItem;
begin
  item := FIdsByStrName.Find(WideUpperCase(PNamesArray(Names)[0]));
  
  if item <> nil then
  begin
    PDispIdsArray(DispIds)[0] := Integer(item.Data);
    Result                    := S_OK;
    Exit;
  end;

  for i := 0 to NameCount - 1 do
    PDispIdsArray(DispIds)[i] := DISPID_UNKNOWN;
  Result := DISP_E_UNKNOWNNAME;
end;

{------------------------------------------------------------------------------}
function TLMDCodeObject.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result            := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDCodeObject.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count  := 0;
  Result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDCodeObject.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
label
  L_END;
type
  TState = (sMeth, sPGet, sPPut, sTpMis, sNoMr, sNotUsed);
const
  STATES: array[0..15, Boolean] of TState =
  (
    (sNoMr, sNoMr),   // 0  - No valid flag
    (sMeth, sTpMis),  // 1  - DISPATCH_METHOD
    (sPGet, sTpMis),  // 2  - DISPATCH_PROPERTYGET
    (sNoMr, sNoMr),   // 3  - No valid flag
    (sPPut, sTpMis),  // 4  - DISPATCH_PROPERTYPUT
    (sNoMr, sNoMr),   // 5  - No valid flag
    (sNoMr, sNoMr),   // 6  - No valid flag
    (sNoMr, sNoMr),   // 7  - No valid flag
    (sPPut, sTpMis),  // 8  - DISPATCH_PROPERTYPUTREF
    (sNoMr, sNoMr),   // 9  - No valid flag
    (sNoMr, sNoMr),   // 10 - No valid flag
    (sNoMr, sNoMr),   // 11 - No valid flag
    (sPPut, sTpMis),  // 12 - DISPATCH_PROPERTYPUT or DISPATCH_PROPERTYPUTREF
    (sNoMr, sNoMr),   // 13 - No valid flag
    (sNoMr, sNoMr),   // 14 - No valid flag
    (sNoMr, sNoMr)    // 15 - No valid flag
  );
var
  obj:      TLMDDispIdObject;
  argsz:    Integer;
  dargs:    TDispParams absolute Params;
  vargs:    PLMDVarArray;
  i:        Integer;
  trddt:    TLMDThreadData;
  threadVM: TLMDThreadVM;
  vm:       TLMDVirtMachine;
begin
  Result   := S_OK;
  trddt    := ThreadData;
  argsz    := dargs.cArgs;
  vargs    := nil;
  threadVM := nil;
  try
    if FId.Index >= trddt.VMDataLength then
      trddt.Thread := VMIndexes.InitThread(FId);
      
    threadVM := trddt.Thread.VMData[FId.Index];
    if not threadVM.Lock then
    begin
      threadVM := nil; // Not-locked mark.
      RaiseVMHasBeenClosed;
    end;

    vm := threadVM.VMLock.VM;
    if vm.FId.Id <> FId.Id then
      RaiseVMHasBeenClosed;

    // Unsigned comparison will automatically process
    // the (DispId <= 0) case.

    if Cardinal(DispId - 1) >= Cardinal(FMaxDispId) then
    begin
      Result := DISP_E_MEMBERNOTFOUND;
      goto L_END;
    end;

    obj := vm.FScriptGlobalsByDispId[DispId];

    { Invoke }

    case STATES[obj.InvokeFlags and DWORD(Flags) and DWORD($0F), // $0F - is 4-bits mask.
                (DWORD(VarResult) and not obj.ResMask) <> 0] of
      sMeth:
      begin
        if argsz <> TLMDProcObject(obj).ParamCount then
        begin
          Result := DISP_E_BADPARAMCOUNT;
          goto L_END;
        end;

        // IDispatch should treat the arguments as readonly, however
        // the Interpret can freely change argument values treating
        // them as locals. So we make here a real copy of argument
        // array with all proper add-refs/releases.

        vargs := trddt.Thread.StackPool.AsquireStack(argsz + 1);
        for i := 0 to argsz - 1 do
          vargs[i] := OleVariant(dargs.rgvarg[argsz - 1 - i]); // Reverse args.

        vm.InvokeProcNoChecks(trddt.Thread, TLMDProcObject(obj),
                              vargs, vargs[argsz]);

        if VarResult <> nil then
          POleVariant(VarResult)^ := vargs[argsz];
      end;
      sPGet:
      begin
        if argsz > 0 then
        begin
          Result := DISP_E_BADPARAMCOUNT;
          goto L_END;
        end;

        if VarResult <> nil then
          POleVariant(VarResult)^ := TLMDGlobalValuedObject(obj).Value;
      end;
      sPPut:
      begin
        if argsz <> 1 then
        begin
          Result := DISP_E_BADPARAMCOUNT;
          goto L_END;
        end;

        TLMDGlobalValuedObject(obj).Value := OleVariant(dargs.rgvarg[0]);
      end;
      sTpMis:
      begin
        Result := DISP_E_TYPEMISMATCH; // Cannot convert viod to any possible
                                       // Variant.
        goto L_END;
      end;
      sNoMr:
      begin
        // We are here when invoke flags does not compatible with invoked
        // item kind (attempt to assign to a method, or a property read
        // without result). It probably more descriptive to raise TYPEMISMATCH
        // error, instead of MEMBERNOTFOUND.

        Result := DISP_E_TYPEMISMATCH; // DISP_E_MEMBERNOTFOUND;
        goto L_END;
      end;
      sNotUsed: Exit; // Prevents Delphi compiler from
                      // transforming case to ifs.
    end;

L_END:
  except
    on e: Exception do
      Result := EncodeInvokeError(e, ExcepInfo);
  end;

  if threadVM <> nil then
    threadVM.Unlock;
  if vargs <> nil then
    trddt.Thread.StackPool.ReleaseStack(argsz + 1);
end;

{------------------------------------------------------------------------------}
function TLMDCodeObject.GetIdOfName(ANameIndex: Integer;
  out ADispId: Integer): Boolean;
var
  item: TCodeObjectItem;
begin
  item := TCodeObjectItem(FIdsByName.Find(ANameIndex));

  if item <> nil then
  begin
    ADispId := item.DispId;
    Result  := True;
    Exit;
  end;

  Result := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDCodeObject.InvokeMember(AThread: TLMDThread; DispID: Integer;
  ABracketType: TLMDBracketType; AResMask: DWORD;  AArgCount: Integer;
  AArgs: PLMDVarArray; var AResult: OleVariant);
type
  TState = (sProc, sVar, sVarBlk, sConst, sConstBlk, sTpMiss);
const
  STATES: array[TLMDGlobalObjType, TLMDBracketType, Boolean] of TState =
  (
    { bkNone }               { bkVbRound }           { bkRound }             { bkBlock }

    ((sVar,      sVar),      (sVarBlk,   sVarBlk),    (sTpMiss,   sTpMiss),   (sVarBlk,   sVarBlk)),   // gtVar
    ((sConst,    sConst),    (sConstBlk, sConstBlk),  (sTpMiss,   sTpMiss),   (sConstBlk, sConstBlk)), // gtConst
    ((sProc,     sTpMiss),   (sProc,     sTpMiss),    (sProc,     sTpMiss),   (sTpMiss,   sTpMiss)),   // gtProcedure
    ((sTpMiss,   sTpMiss),   (sTpMiss,   sTpMiss),    (sTpMiss,   sTpMiss),   (sTpMiss,   sTpMiss)),   // gtExit
    ((sTpMiss,   sTpMiss),   (sTpMiss,   sTpMiss),    (sTpMiss,   sTpMiss),   (sTpMiss,   sTpMiss)),   // gtBreak
    ((sTpMiss,   sTpMiss),   (sTpMiss,   sTpMiss),    (sTpMiss,   sTpMiss),   (sTpMiss,   sTpMiss)),   // gtContinue
    ((sTpMiss,   sTpMiss),   (sTpMiss,   sTpMiss),    (sTpMiss,   sTpMiss),   (sTpMiss,   sTpMiss)),   // gtIntrinsic
    ((sTpMiss,   sTpMiss),   (sTpMiss,   sTpMiss),    (sTpMiss,   sTpMiss),   (sTpMiss,   sTpMiss))    // gtExtern
  );
var
  obj:      TLMDDispIdObject;
  threadVM: TLMDThreadVM;
  vm:       TLMDVirtMachine;
begin
  if FId.Index >= Length(AThread.VMData) then
    AThread := VMIndexes.InitThread(FId);

  threadVM := AThread.VMData[FId.Index];
  if not threadVM.Lock then
    RaiseVMHasBeenClosed;
  try
    vm := threadVM.VMLock.VM;
    if vm.FId.Id <> FId.Id then
      RaiseVMHasBeenClosed;

    // Unsigned comparison will automatically process
    // the (DispId <= 0) case.

    if Cardinal(DispId - 1) >= Cardinal(FMaxDispId) then
      ELMDVMRuntime.RaiseError(retInvalidDispId);
    obj := vm.FScriptGlobalsByDispId[DispID];

    case STATES[obj.GlobalObjType, ABracketType,
                (AResMask and not obj.ResMask) <> 0] of
      sProc:
      begin
        if TLMDProcObject(obj).ParamCount <> AArgCount then
          ELMDVMRuntime.RaiseError(retInvalidParamCount);

        vm.InvokeProcNoChecks(AThread, TLMDProcObject(obj), AArgs, AResult);
        Exit;
      end;
      sVar:
        AResult := TLMDGlobalValuedObject(obj).Value;
      sVarBlk:
        vm.GetIndexed(AArgCount, TLMDGlobalValuedObject(obj).Value,
                      AArgs, AResult);
      sConst:
        AResult := TLMDGlobalValuedObject(obj).Value;
      sConstBlk:
        vm.GetIndexed(AArgCount, TLMDGlobalValuedObject(obj).Value,
                      AArgs, AResult);
      sTpMiss:
        ELMDVMRuntime.RaiseError(retTypeMismatch);
    end;
  finally
    threadVM.Unlock;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCodeObject.InvokePropPut(AThread: TLMDThread;
  DispID: Integer; ABracketType: TLMDBracketType; AArgCount: Integer;
  AArgs: PLMDVarArray; AValue: POleVariant);
type
  TState = (sVar, sVarBlk, sCntAsgn, sNotUsed1, sNotUsed2);
const
  STATES: array[TLMDGlobalObjType, TLMDBracketType] of TState =
  (
    { bkNon }       { bkVbRound}    { bkRound }     { bkBlock }

    (sVar,          sVarBlk,        sCntAsgn,       sVarBlk),   // gtVar
    (sCntAsgn,      sCntAsgn,       sCntAsgn,       sCntAsgn),  // gtConst
    (sCntAsgn,      sCntAsgn,       sCntAsgn,       sCntAsgn),  // gtProcedure
    (sCntAsgn,      sCntAsgn,       sCntAsgn,       sCntAsgn),  // gtExit
    (sCntAsgn,      sCntAsgn,       sCntAsgn,       sCntAsgn),  // gtBreak
    (sCntAsgn,      sCntAsgn,       sCntAsgn,       sCntAsgn),  // gtContinue
    (sCntAsgn,      sCntAsgn,       sCntAsgn,       sCntAsgn),  // gtIntrinsic
    (sCntAsgn,      sCntAsgn,       sCntAsgn,       sCntAsgn)   // gtExtern
  );
var
  obj:      TLMDDispIdObject;
  threadVM: TLMDThreadVM;
  vm:       TLMDVirtMachine;
begin
  if FId.Index >= Length(AThread.VMData) then
    AThread := VMIndexes.InitThread(FId);

  threadVM := AThread.VMData[FId.Index];
  if not threadVM.Lock then
    RaiseVMHasBeenClosed;
  try
    vm := threadVM.VMLock.VM;
    if vm.FId.Id <> FId.Id then
      RaiseVMHasBeenClosed;

    // Unsigned comparison will automatically process
    // the (DispId <= 0) case.

    if Cardinal(DispId - 1) >= Cardinal(FMaxDispId) then
      ELMDVMRuntime.RaiseError(retInvalidDispId);
    obj := vm.FScriptGlobalsByDispId[DispID];

    case STATES[TLMDGlobalObject(obj).GlobalObjType, ABracketType] of
      sVar:
      begin
        TLMDGlobalValuedObject(obj).Value := AValue^;
      end;
      sVarBlk:
      begin
        vm.SetIndexed(TLMDGlobalValuedObject(obj).Value, AValue, AArgs,
                      AArgCount);
      end;
      sCntAsgn:
      begin
        ELMDVMRuntime.RaiseError(retCannotAssign);
      end;
      sNotUsed1: Exit; // Prevents Delphi compiler from
      sNotUsed2: Exit; // transforming case to ifs.
    end;
  finally
    threadVM.Unlock;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCodeObject.QueryInterface(const IID: TGUID; out Obj): HResult;
type
  PInt64Array = ^TInt64Array;
  TInt64Array = array[0..1] of Int64;
begin
  if @IID = @VM_GUID then // Compare by addresses for security
                          // and performance.
  begin
    Pointer(Obj) := Self;
    Result       := S_OK;
  end
  else
  begin
    if GetInterface(IID, Obj) then
      Result := S_OK
    else
      Result := E_NOINTERFACE;
  end;
end;

{******************************** TLMDVMIndex *********************************}
{------------------------------------------------------------------------------}
constructor TVMIndexes.Create;
begin
  inherited Create;

  FSection        := TCriticalSection.Create;
  FThreadDatas    := TList.Create;
  FLocks          := TList.Create;
  FSteppingItems  := TList.Create;
  FNextVMId       := 1;
  FNextDebuggerId := 1;
end;

{------------------------------------------------------------------------------}
procedure TVMIndexes.ReleaseId(const AId: TLMDVMId);
begin
  FSection.Acquire;
  try
    AId.Lock.FVM := nil;
  finally
    FSection.Release;
  end;
end;

{------------------------------------------------------------------------------}
procedure TVMIndexes.MarkOpened(const AId: TLMDVMId;
  ADebugger: TLMDVMDebugger);
var
  i:     Integer;
  lock:  TLMDVMLock;
  tvm:   TLMDThreadVM;
  dbgid: Integer;
begin
  FSection.Acquire;
  try
    dbgid := -1;
    if ADebugger <> nil then
      dbgid := ADebugger.FId;

    lock                    := AId.Lock;
    lock.FInactiveOrClosing := False;
    lock.FDebuggerId        := dbgid;

    for i := 0 to lock.FVMDataList.Count - 1 do
    begin
      tvm               := TLMDThreadVM(lock.FVMDataList[i]);
      tvm.FFlag         := 0;
      tvm.FSteppingBase := GetSteppingBase(tvm.Thread, lock);
    end;
  finally
    FSection.Release;
  end;
end;

{------------------------------------------------------------------------------}
procedure TVMIndexes.MarkClosingAndWait(const AId: TLMDVMId);
var
  I:       Integer;
  lock:    TLMDVMLock;
  vmdtlst: TList;
begin
  lock    := AId.Lock;
  vmdtlst := TList.Create;
  try
    FSection.Acquire;
    try
      if not lock.FInactiveOrClosing then // Required to prevent dead-loop while
                                          // resetting VM-data flags.
      begin
        lock.FInactiveOrClosing := True;
        lock.FDebuggerId        := -1;
        lock.VM.FTerminateFlag  := 0;     // Inside FSection.
        
        vmdtlst.Assign(lock.FVMDataList);
      end;
    finally
      FSection.Release;
    end;

    while True do
    begin
      for i := vmdtlst.Count - 1 downto 0 do
      begin
        if InterlockedCompareExchange(TLMDThreadVM(vmdtlst[i]).FFlag,
                                      -1, 0) = 0 then
          vmdtlst.Delete(i);
      end;

      if vmdtlst.Count = 0 then
        Break; // while
      Sleep(0);
    end;

    for i := 0 to lock.FVMDataList.Count - 1 do
      with TLMDThreadVM(lock.FVMDataList[i]) do
      begin
        FGlobals.Clear;
        FSteppingBase := nil;
      end;
  finally
    vmdtlst.Free;
  end;
end;

{------------------------------------------------------------------------------}
destructor TVMIndexes.Destroy;
var
  i: Integer;
begin
  for i := 0 to FThreadDatas.Count - 1 do
    TObject(FThreadDatas[i]).Free;
  for i := 0 to FLocks.Count - 1 do
    TObject(FLocks[i]).Free;
  for i := 0 to FSteppingItems.Count - 1 do
    TObject(FSteppingItems[i]).Free;

  FSection.Free;
  FThreadDatas.Free;
  FLocks.Free;
  FSteppingItems.Free;
  
  inherited;
end;

{------------------------------------------------------------------------------}
function TVMIndexes.AsquireId(VM: TLMDVirtMachine): TLMDVMId;
var
  I:    Integer;
  Lock: TLMDVMLock;
begin
  FSection.Acquire;
  try
    for I := 0 to FLocks.Count - 1 do
    begin
      Lock := TLMDVMLock(FLocks[I]);

      if Lock.FVM = nil then
      begin
        Lock.FVM     := VM;
        Result.Id    := GetVMNextId;
        Result.Index := I;
        Result.Lock  := Lock;
        Exit;
      end;
    end;

    Lock         := TLMDVMLock.Create(VM);
    Result.Id    := GetVMNextId;
    Result.Index := FLocks.Add(Lock);
    Result.Lock  := Lock;
  finally
    FSection.Release;
  end;
end;

{********************************* TLMDThreadVM *******************************}
{------------------------------------------------------------------------------}
constructor TLMDThreadVM.Create(AVMLock: TLMDVMLock;
  AThread: TLMDThread; AInactiveOrClosing: Boolean;
  ASteppingBase: PLMDFrame);
begin
  inherited Create;

  FVMLock := AVMLock;
  FThread := AThread;
  if AInactiveOrClosing then
    FFlag := -1;
  FGlobals      := TLMDThreadGlobals.Create(Self);
  FSteppingBase := ASteppingBase;

  AVMLock.FVMDataList.Add(Self);
end;

destructor TLMDThreadVM.Destroy;
begin
  FVMLock.FVMDataList.Remove(Self);
  FGlobals.Free;
  inherited;
end;

function TLMDThreadVM.Lock: Boolean;
begin
  if FLockCount > 0 then
  begin
    Inc(FLockCount);
    Result := True;
    Exit;
  end;

  Result := (InterlockedCompareExchange(FFlag, 1, 0) = 0);
  if Result then
    Inc(FLockCount);
end;

{------------------------------------------------------------------------------}
procedure TLMDThreadVM.Unlock;
begin
  Dec(FLockCount);
  if FLockCount = 0 then
    FFlag := 0;
end;

{******************************** TLMDVMLock **********************************}
{------------------------------------------------------------------------------}
constructor TLMDVMLock.Create(VM: TLMDVirtMachine);
begin
  inherited Create;

  FVM                := VM;
  FVMDataList        := TList.Create;
  FInactiveOrClosing := True;
  FDebuggerId        := -1;
end;

{------------------------------------------------------------------------------}
destructor TLMDVMLock.Destroy;
begin
  while FVMDataList.Count > 0 do
    TLMDThreadVM(FVMDataList[0]).Free;
  FVMDataList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TVMIndexes.InitThread(const AId: TLMDVMId): TLMDThread;
var
  i, oldlnt, newlnt: Integer;
  lock:              TLMDVMLock;
begin
  FSection.Acquire;
  try
    if ThreadData.Thread = nil then
    begin
      ThreadDataGC;

      ThreadData.Thread := TLMDThread.Create;
      FThreadDatas.Add(ThreadData.Thread);
    end;
    Result := ThreadData.Thread;

    if ThreadData.VMDataLength <= AId.Index then
    begin
      oldlnt := ThreadData.VMDataLength;
      newlnt := 4;
      if ThreadData.VMDataLength > 0 then
        newlnt := ThreadData.VMDataLength * 2;
      if newlnt <= AId.Index then
        newlnt := AId.Index + 1;

      ThreadData.VMDataLength := newlnt;
      SetLength(Result.FVMData, newlnt);

      { Ensure locks are created }

      while FLocks.Count < newlnt do
        FLocks.Add(TLMDVMLock.Create(nil));

      { Ensure thread VM-datas are created }

      for i := oldlnt to newlnt - 1 do
      begin
        lock             := TLMDVMLock(FLocks[i]);
        Result.VMData[i] := TLMDThreadVM.Create(lock, Result,
                                                lock.FInactiveOrClosing,
                                                GetSteppingBase(Result, lock));
      end;
    end;
  finally
    FSection.Release;
  end;
end;

{------------------------------------------------------------------------------}
procedure TVMParserCallbacks.AddObjDispIdIndex(AObj: TLMDDispIdObject);
var
  oldlen: Integer;
begin
  if FVM.FDispIdsCount = 0 then
  begin
    SetLength(FVM.FScriptGlobalsByDispId, 4);

    FVM.FScriptGlobalsByDispId[0] := nil; // Do not use DispId = 0.
    FVM.FDispIdsCount             := 1;
  end;

  oldlen := Length(FVM.FScriptGlobalsByDispId);
  if FVM.FDispIdsCount = oldlen then
    SetLength(FVM.FScriptGlobalsByDispId, oldlen * 2);

  AObj.DispId := FVM.FDispIdsCount;
  FVM.FScriptGlobalsByDispId[AObj.DispId] := AObj;

  Inc(FVM.FDispIdsCount);
end;

constructor TVMParserCallbacks.Create(AVM: TLMDVirtMachine);
begin
  inherited Create;
  FVM := AVM;
end;

function TVMParserCallbacks.GetNameId(const AName: WideString): Integer;
begin
  Result := GlobNameTable.GetNameIndex(AName);
end;

procedure TVMParserCallbacks.GlobalObjParsed(AObj: TLMDGlobalObject;
  var ADuplicateName: Boolean);
begin
  ADuplicateName := not FVM.FScriptGlobals.Add(AObj);

  if not ADuplicateName then
  begin
    AddObjDispIdIndex(TLMDDispIdObject(AObj));

    case AObj.GlobalObjType of
      gtVar:        FVM.FGlobalVars.Add(AObj);
      gtConst:      FVM.FGlobalConsts.Add(AObj);
      gtProcedure:  FVM.FProcedures.Add(AObj);
    end;
  end;
end;

procedure TVMParserCallbacks.GlobalStmtParsed(AStmt: ILMDEmitable);
begin
  FVM.FGlobalStmts.Add(AStmt);
end;

procedure TVMParserCallbacks.UsedUnitParsed(const AName: WideString;
  var ADuplicateName: Boolean);
begin
  // Do nothing.
end;

function TVMIndexes.GetVMNextId: Integer;
begin
  Result := FNextVMId;
  Inc(FNextVMId);
end;

class procedure ELMDVMRuntime.RaiseError(AInvokeRes: HResult;
  var EInfo: TExcepInfo; AFinalizeEInfo: Boolean);
var
  LInfo: TExcepInfo;
  msg:   string;
  code:  Integer;
begin
  // Message detection algorithm is analogous to algorithm
  // used by DispCallError VCL function from ComObj.pas unit.

  msg  := '';
  code := AInvokeRes;

  case AInvokeRes of
    DISP_E_EXCEPTION:
    begin
      LInfo := EInfo;
      if AFinalizeEInfo then
        Finalize(EInfo); // Do not use EInfo bellow.

      msg  := LInfo.bstrDescription;
      code := LInfo.scode;
    end;
    DISP_E_BADPARAMCOUNT:
      msg := FormatMsg(retInvalidParamCount, []);
    DISP_E_TYPEMISMATCH:
      msg := FormatMsg(retTypeMismatch, []);
  end;

  if msg = '' then
    msg := SysErrorMessage(code);
  if msg = '' then
    FmtStr(msg, SLMDRuntimeOleError, [code]);

  raise ELMDVMRuntime.Create(msg);
end;

{------------------------------------------------------------------------------}

function TLMDThreadGlobals.AddMemberToItems(AObject: TLMDExternObject;
  AMemberName, ADispId: Integer): TLMDNameSearchRes;
var
  item: TThreadGlobalsItem;
begin
  item := TThreadGlobalsItem(FItems.Find(AMemberName));
  if item = nil then
  begin
    item := TThreadGlobalsItem.Create(AMemberName);
    FItems.Add(item);
  end;

  item.TrySearchInPubs       := False;
  item.SearchRes.ObjKind     := srExternalMember;
  item.SearchRes.NamedObject := AObject;
  item.SearchRes.DispId      := ADispId;

  Result := item.SearchRes;
end;

function TLMDThreadGlobals.AddProcToCache(
  const AStrName: WideString): TLMDProcObject;
var
  name: Integer;
  eitm: TThreadGlobalsItem;
  item: TLMDIdentifierItem;
begin
  Result := nil;
  name   := GlobNameTable.GetNameIndex(WideUpperCase(AStrName), False);
  eitm   := TThreadGlobalsItem(FItems.Find(name));

  if (eitm <> nil) and (eitm.SearchRes.NamedObject is TLMDProcObject) then
  begin
    item      := TLMDIdentifierItem.Create;
    item.Name := AStrName;
    item.Data := eitm.SearchRes.NamedObject;
    FProcsCache.Add(item);

    Result := TLMDProcObject(item.Data);
  end;
end;

function TLMDThreadGlobals.AddValObjToCache(
  const AStrName: WideString): TLMDGlobalValuedObject;
var
  name: Integer;
  eitm: TThreadGlobalsItem;
  item: TLMDIdentifierItem;
begin
  Result := nil;
  name   := GlobNameTable.GetNameIndex(WideUpperCase(AStrName), False);
  eitm   := TThreadGlobalsItem(FItems.Find(name));

  if (eitm <> nil) and (eitm.SearchRes.NamedObject is TLMDGlobalValuedObject) then
  begin
    item      := TLMDIdentifierItem.Create;
    item.Name := AStrName;
    item.Data := eitm.SearchRes.NamedObject;
    FValObjCache.Add(item);

    Result := TLMDGlobalValuedObject(item.Data);
  end;
end;

procedure TLMDThreadGlobals.Clear;
begin
  FItems.Clear;
  FProcsCache.Clear;
  FValObjCache.Clear;
  FPubMrsExterns.Clear;
  FChangeNumber := -1;
end;

constructor TLMDThreadGlobals.Create(AThreadVM: TLMDThreadVM);
begin
  inherited Create;

  FThreadVM      := AThreadVM;
  FVMLock        := AThreadVM.FVMLock;
  FItems         := TLMDNameHashTable.Create(True);
  FProcsCache    := TLMDIdentifierHashTable.Create(True);
  FValObjCache   := TLMDIdentifierHashTable.Create(True);
  FPubMrsExterns := TList.Create;
  FChangeNumber  := -1;
end;

destructor TLMDThreadGlobals.Destroy;
begin
  FItems.Free;
  FProcsCache.Free;
  FValObjCache.Free;
  FPubMrsExterns.Free;
  inherited;
end;

function TLMDThreadGlobals.FindProcByStrName(
  const AStrName: WideString): TLMDProcObject;
var
  item: TLMDIdentifierItem;
begin
  if FChangeNumber <> FVMLock.FVM.FExternObjects.ChangeNumber then
    FVMLock.FVM.FExternObjects.UpdateContentOf(Self);

  item := FProcsCache.Find(AStrName);
  if item <> nil then
  begin
    Result := TLMDProcObject(item.Data);
    Exit;
  end;

  Result := AddProcToCache(AStrName);
end;

function TLMDThreadGlobals.FindValObjByStrName(
  const AStrName: WideString): TLMDGlobalValuedObject;
var
  item: TLMDIdentifierItem;
begin
  if FChangeNumber <> FVMLock.FVM.FExternObjects.ChangeNumber then
    FVMLock.FVM.FExternObjects.UpdateContentOf(Self);

  item := FProcsCache.Find(AStrName);
  if item <> nil then
  begin
    Result := TLMDGlobalValuedObject(item.Data);
    Exit;
  end;

  Result := AddValObjToCache(AStrName);
end;

function TLMDThreadGlobals.Search(AName: Integer;
  const AStrName: WideString): TLMDNameSearchRes;
var
  item: TThreadGlobalsItem;
begin
  if FChangeNumber <> FVMLock.FVM.FExternObjects.ChangeNumber then
    FVMLock.FVM.FExternObjects.UpdateContentOf(Self);

  item := TThreadGlobalsItem(FItems.Find(AName));

  if item <> nil then
  begin
    if item.TrySearchInPubs then
    begin
      SearchInPubMembers(AName, AStrName, Result);
      item.TrySearchInPubs := False;
    end;

    Result := item.SearchRes;
    Exit;
  end;

  Result.ObjKind := srNotFound;
  SearchInPubMembers(AName, AStrName, Result);
end;

procedure TLMDExternObjects.UpdateContentOf(AGlobals: TLMDThreadGlobals);
var
  externs: TList;
  scptgls: TList;
  bldins:  TList;
begin
  FSection.Acquire;
  externs := TList.Create;
  scptgls := TList.Create;
  bldins  := TList.Create;
  try
    FObjects.GetAll(externs);
    FVM.FScriptGlobals.GetAll(scptgls);
    FVM.FIntrinsicObjects.GetAll(bldins);

    AGlobals.UpdateContent(scptgls, externs, FPubMrsObjs, bldins,
                           FChangeNumber);
  finally
    FSection.Release;
    externs.Free;
    scptgls.Free;
    bldins.Free;
  end;
end;

function TLMDThreadGlobals.SearchInPubMembers(AName: Integer;
  const AStrName: WideString; out ASearchRes: TLMDNameSearchRes): Boolean;
var
  i:      Integer;
  eobj:   TLMDExternObject;
  found:  Boolean;
  dispId: Integer;
begin
  for i := 0 to FPubMrsExterns.Count - 1 do
  begin
    eobj := TLMDExternObject(FPubMrsExterns[I]);

    if eobj.CodeObject <> nil then
      found := TLMDCodeObject(eobj.CodeObject).GetIdOfName(AName, dispId)
    else
      found := (eobj.Obj.GetIDsOfNames(GUID_NULL, @AStrName, 1, 0,
                                       @dispId) = S_OK);

    if found then
    begin
      ASearchRes := AddMemberToItems(eobj, AName, dispId);
      Result     := True;
      Exit;
    end;
  end;

  Result := False;
end;

procedure TLMDThreadGlobals.UpdateContent(AScriptGlobals, AExterns,
  APubMrsExterns, AIntrinsics: TList; AChangeNumber: Integer);
const
  SEARCHRES_BY_OBJKND: array[TLMDGlobalObjType] of TLMDNameSearchResKind = (
    srGlobalVar,     // gtVar
    srGlobalConst,   // gtConst
    srProcedure,     // gtProcedure
    srExit,          // gtExit
    srBreak,         // gtBreak
    srContinue,      // gtContinue
    srIntrinsic,     // gtIntrinsic
    srExternal       // gtExtern
  );
var
  i:    Integer;
  item: TThreadGlobalsItem;
  gobj: TLMDGlobalObject;
  eobj: TLMDExternObject;
begin
  FItems.Clear;
  FProcsCache.Clear;
  FValObjCache.Clear;

  for i := 0 to AScriptGlobals.Count - 1 do
  begin
    gobj := TLMDExternObject(AScriptGlobals[i]);
    item := TThreadGlobalsItem.Create(gobj.Name);
    try
      item.TrySearchInPubs       := False;
      item.SearchRes.ObjKind     := SEARCHRES_BY_OBJKND[gobj.GlobalObjType];
      item.SearchRes.NamedObject := gobj;
      item.SearchRes.DispId      := 0;

      if not FItems.Add(item) then
        item.Free;
    except
      item.Free;
      raise;
    end;
  end;

  for i := 0 to AExterns.Count - 1 do
  begin
    eobj := TLMDExternObject(AExterns[i]);
    item := TThreadGlobalsItem.Create(eobj.Name);
    try
      item.TrySearchInPubs       := False;
      item.SearchRes.ObjKind     := srExternal;
      item.SearchRes.NamedObject := eobj;
      item.SearchRes.DispId      := 0;

      if not FItems.Add(item) then
        item.Free;
    except
      item.Free;
      raise;
    end;
  end;

  for i := 0 to AIntrinsics.Count - 1 do
  begin
    gobj := TIntrinsic(AIntrinsics[i]);
    item := TThreadGlobalsItem.Create(gobj.Name);
    try
      item.TrySearchInPubs       := True; // Externs pub-members have higher
                                          // priority then builtin objects.
      item.SearchRes.ObjKind     := SEARCHRES_BY_OBJKND[gobj.GlobalObjType];
      item.SearchRes.NamedObject := gobj;
      item.SearchRes.DispId      := 0;

      if not FItems.Add(item) then
        item.Free;
    except
      item.Free;
      raise;
    end;
  end;

  FPubMrsExterns.Assign(APubMrsExterns);
  FChangeNumber := AChangeNumber;
end;

procedure TLMDVirtMachine.RaiseProcNotFound(
  const AStrName: WideString);
var
  name: Integer;
begin
  name := GlobNameTable.GetNameIndex(AStrName, False);
  if FScriptGlobals.Find(name) <> nil then
    ELMDVMRuntime.RaiseError(retProcRequired);

  ELMDVMRuntime.RaiseError(retUndeclaredId, AStrName);
end;

procedure TLMDVirtMachine.DoClear;
var
  i: Integer;
begin
  FCodeObject := nil;
  FSource.Clear;

  for i := 0 to FGlobalStmts.Count - 1 do
    TObject(FGlobalStmts[i]).Free;
  FGlobalStmts.Clear;
  FreeAndNil(FGlobalByteCode);

  FDispIdsCount := 0;
  FScriptGlobals.Clear;
  FIntrinsicObjects.Clear;
  SetLength(FScriptGlobalsByDispId, 0);
  FProcedures.Clear;
  FGlobalVars.Clear;
  FGlobalConsts.Clear;
  FExternObjects.Close;
  FBreakpoints.Clear;
end;

procedure TLMDCodeObject.Init(AVM: TLMDVirtMachine);
var
  i:    Integer;
  obj:  TLMDDispIdObject;
  iitm: TLMDIdentifierItem;
  citm: TCodeObjectItem;
begin
  FMaxDispId := AVM.FDispIdsCount - 1;

  for i := 1 to FMaxDispId do
  begin
    obj := AVM.FScriptGlobalsByDispId[i];

    iitm      := TLMDIdentifierItem.Create;
    iitm.Name := WideUpperCase(GlobNameTable.GetName(obj.Name));
    iitm.Data := TObject(obj.DispId);
    FIdsByStrName.Add(iitm);

    citm        := TCodeObjectItem.Create(obj.Name);
    citm.DispId := obj.DispId;
    FIdsByName.Add(citm);
  end;
end;

procedure TLMDCodeObject.RaiseVMHasBeenClosed;
begin
  // This function hides resourcestring conversion from
  // the caller, so optimizing the caller performance.

  raise ELMDVirtMachine.Create(SLMDVMActive);
end;

procedure TLMDVirtMachine.Lock;
var
  trddt:    TLMDThreadData;
  threadVM: TLMDThreadVM;
begin
  trddt := ThreadData;
  if FId.Index >= trddt.VMDataLength then
    trddt.Thread := VMIndexes.InitThread(FId);

  threadVM := trddt.Thread.VMData[FId.Index];
  if not threadVM.Lock then
    RaiseVMNotActive;
end;

procedure TLMDVirtMachine.MakeEventHandler(const AProcName: WideString;
  var AResult: OleVariant);
begin
  AResult := OleUnassigned;
  if Assigned(FOnEventMake) then
    FOnEventMake(Self, AProcName, AResult);
end;

procedure TLMDVirtMachine.Unlock;
var
  trddt:    TLMDThreadData;
  threadVM: TLMDThreadVM;
begin
  trddt := ThreadData;
  if FId.Index >= trddt.VMDataLength then
    trddt.Thread := VMIndexes.InitThread(FId);

  threadVM := trddt.Thread.VMData[FId.Index];
  threadVM.Unlock;
end;

procedure TLMDVirtMachine.WriteVar(const AName: WideString;
  const AValue: OleVariant);
var
  vobj:     TLMDGlobalValuedObject;
  trddt:    TLMDThreadData;
  threadVM: TLMDThreadVM;
begin
  trddt := ThreadData;
  if FId.Index >= trddt.VMDataLength then
    trddt.Thread := VMIndexes.InitThread(FId);

  threadVM := trddt.Thread.VMData[FId.Index];

  if not threadVM.Lock then
    RaiseVMNotActive;
  try
    vobj := threadVM.Globals.FindValObjByStrName(AName); // No UpperCase needed.

    if vobj = nil then
      RaiseValObjNotFound(AName);
    if vobj.GlobalObjType = gtConst then
      ELMDVMRuntime.RaiseError(retCannotAssign);

    vobj.Value := AValue;
  finally
    threadVM.Unlock;
  end;
end;

function TLMDCodeObject.EncodeInvokeError(E: Exception;
  AEInfo: PExcepInfo): HRESULT;
begin
  if E is EVariantTypeCastError then
  begin
    Result := DISP_E_TYPEMISMATCH;
    Exit;
  end;

  if AEInfo <> nil then
  begin
    FillChar(AEInfo^, SizeOf(TExcepInfo), 0);

    with AEInfo^ do
    begin
      bstrSource      := 'LMD-ScriptPack Pascal script VM.';
      bstrDescription := e.Message;
      scode           := E_FAIL;
    end;
  end;
  
  Result := DISP_E_EXCEPTION;
end;

procedure TLMDVirtMachine.InvokeProc(AThread: TLMDThread;
  ACall: TLMDCall; AProc: TLMDProcObject; ATop: POleVariant);
const
  BRCKT_MASK: array[TLMDBracketType] of DWORD = (
    0, // bkNon
    0, // bkVbRound
    0, // bkRound
    1  // bkBlock
  );
var
  ctx: TLMDVMInterpretContext;
begin
  if (BRCKT_MASK[ACall.BracketType] or (ACall.ResMask and not AProc.ResMask) or
      DWORD(ACall.ArgCount - AProc.ParamCount)) <> 0 then // Fast part, only
                                                          // single Jmp.
  begin
    if ACall.BracketType = bkBlock then
      ELMDVMRuntime.RaiseError(retTypeMismatch)
    else if ACall.ArgCount <> AProc.ParamCount then // Slow part in error case.
      ELMDVMRuntime.RaiseError(retInvalidParamCount)
    else
      ELMDVMRuntime.RaiseError(retTypeMismatch);
  end;

  ctx.Code   := AProc.ByteCode;
  ctx.Args   := PLMDVarArray(TLMDPtrInt(ATop) - ACall.ArgsOffset);
  ctx.Result := POleVariant(TLMDPtrInt(ATop) - ACall.ResOffset);
  ctx.Source := nil;
  
  Interpret(AThread, ctx);
end;

{ TLMDVMSource }

procedure TLMDVMSource.Clear;
begin
  FText        := '';
  FIndexLength := 0;
end;

constructor TLMDVMSource.Create;
begin
  inherited Create;
end;

constructor TLMDVMSource.Create(const AText: WideString);
begin
  inherited Create;
  SetText(AText);
end;

procedure TLMDVMSource.AddItem(ALine, APos: Integer;
  ACur: PWideChar);
var
  capsty: Integer;
begin
  { Grow }

  capsty := Length(FIndex);

  if FIndexLength = capsty then
  begin
    if capsty = 0 then
      SetLength(FIndex, 4)
    else
      SetLength(FIndex, capsty * 2);
  end;

  { Add }

  with FIndex[FIndexLength] do
  begin
    Line := ALine;
    Pos  := APos;
    Cur  := ACur;
  end;
  Inc(FIndexLength);
end;

procedure TLMDVMSource.SetText(const Value: WideString);
begin
  FText := Value;
  UpdateIndex;
end;

procedure TLMDVMSource.UpdateIndex;
var
  last, lnstart, cur, eoff: PWideChar;
  line: Integer;

  procedure _SkipChar;
  begin
    if (cur - last) = SRC_CHARSPRESITEM then
    begin
      AddItem(line, (cur - lnstart) + 1, cur); // Pos in line is in Delphi format,
                                               // e.g. starts from 1, not zero.
      last := cur;
    end;

    Inc(cur);
  end;

begin
  FIndexLength := 0;
  if FText = '' then
    Exit;

  cur     := PWideChar(FText);
  eoff    := cur + Length(FText);
  last    := cur - SRC_CHARSPRESITEM;
  lnstart := cur;
  line    := 0;

  while cur <> eoff do
  begin
    if Ord(cur^) in [13, 10] then
    begin
      _SkipChar;
      if (cur <> eoff) and (Ord(cur^) = 10) then
        _SkipChar;
        
      Inc(line);
      lnstart := cur;
      Continue; // while
    end;

    _SkipChar;
  end;
end;

procedure TLMDVMSource.PosToLine(ASrcPos: Integer; out ALine,
  ALinePos: Integer);
var
  item:           TLMDVMSourceItem;
  reqch, lnstart: PWideChar;
begin
  Dec(ASrcPos); // To zero based format.

  if (ASrcPos < 0) or (ASrcPos >= Length(FText)) then
  begin
    ALine    := -1;
    ALinePos := -1;
    Exit;
  end;

  item    := FIndex[ASrcPos shr SRC_CHARSPRESITEM_SHIFT];
  reqch   := PWideChar(FText) + ASrcPos;
  lnstart := item.Cur - (item.Pos - 1);

  while item.Cur <> reqch do
  begin
    if Ord(item.Cur^) in [13, 10] then
    begin
      Inc(item.Cur);
      if item.Cur = reqch then
        Break; // while

      if Ord(item.Cur^) = 10 then
        Inc(item.Cur);

      Inc(item.Line);
      lnstart := item.Cur;
      Continue; // while
    end;

    Inc(item.Cur);
  end;

  ALine    := item.Line;
  ALinePos := (item.Cur - lnstart) + 1; // Pos in line is in Delphi format,
                                        // e.g. starts from 1, not zero.
end;

procedure TLMDVMSource.LineToPos(ALine: Integer; out ASrcPos,
  ALength: Integer);
var
  i:                    Integer;
  item:                 TLMDVMSourceItem;
  lnstrt, lneoff, eoff: PWideChar;
begin
  ASrcPos := -1;
  ALength := 0;

  if Length(FIndex) = 0 then
    Exit;

  { Find closest item }

  item := FIndex[0];
  for i := 1 to FIndexLength - 1 do
  begin
    if FIndex[i].Line >= ALine then
      Break; // for
    item := FIndex[i];
  end;

  { Scan chars }

  eoff   := PWideChar(FText) + Length(FText);
  lnstrt := nil;
  lneoff := nil;

  while item.Cur <> eoff do
  begin
    if (item.Line = ALine) and (item.Pos = 1) then
      lnstrt := item.Cur;

    if Ord(item.Cur^) in [13, 10] then
    begin
      if item.Line = ALine then
      begin
        lneoff := item.Cur;
        Break; // while
      end;

      Inc(item.Cur);
      if (item.Cur <> eoff) and (Ord(item.Cur^) = 10) then
        Inc(item.Cur);

      Inc(item.Line);
      item.Pos := 1;  // Pos in line is in Delphi format,
                      // e.g. starts from 1, not zero.

      Continue; // while
    end;

    Inc(item.Pos);
    Inc(item.Cur);
  end;

  if lnstrt <> nil then
  begin
    if lneoff = nil then
      lneoff := eoff;

    ASrcPos := (lnstrt - PWideChar(FText)) + 1; // Pos in line is in Delphi format,
                                                // e.g. starts from 1, not zero.
    ALength := (lneoff - lnstrt);
  end;
end;

function TLMDVMSource.PosToLine(ASrcPos: Integer): Integer;
var
  pos: Integer;
begin
  PosToLine(ASrcPos, Result, pos);  
end;

{ TVMEvalParserCallbacks }

function TVMEvalParserCallbacks.GetNameId(const AName: WideString): Integer;
begin
  Result := GlobNameTable.GetNameIndex(AName);
end;

procedure TVMEvalParserCallbacks.GlobalObjParsed(AObj: TLMDGlobalObject;
  var ADuplicateName: Boolean);
begin
  ADuplicateName := True; // Do nothing.
end;

procedure TVMEvalParserCallbacks.GlobalStmtParsed(AStmt: ILMDEmitable);
begin
  // Do nothing.
end;

procedure TVMEvalParserCallbacks.UsedUnitParsed(const AName: WideString;
  var ADuplicateName: Boolean);
begin
  ADuplicateName := True; // Do nothing.
end;

constructor TPreparedDynCode.Create(AVM: TLMDVirtMachine);
begin
  inherited Create;
  FVM       := AVM;
  FSource   := TLMDVMSource.Create;
  FByteCode := TLMDByteCode.Create;
end;

destructor TPreparedDynCode.Destroy;
begin
  FSource.Free;
  FByteCode.Free;
  FParsed.Free;
  inherited;
end;

procedure TPreparedDynCode.PrepareExpr(const AExpr: WideString;
  ADebugNS: TLMDAbstractNamespace);
var
  parser:    ILMDParserBase;
  line, pos: Integer;
  ns:        TLMDAbstractNamespace;
begin
  FSource.Text := AExpr;
  parser       := FVM.FLanguage.CreateParser(EvalCbs);
  try
    try
      FParsed := parser.ParseExpr(FSource.Text);

      ns := ADebugNS;
      if ns = nil then
        ns := FVM.FGlobalNamespace;

      FByteCode.BeginEmit(AExpr, ns, 0);
      FParsed.Emit(ns, FByteCode);
      FByteCode.Emit(icAssignResult);
      FByteCode.Emit(icRet);
      FByteCode.EndEmit;
    except
      on e: ELMDCompileBase do
      begin
        FSource.PosToLine(ELMDCompileBase(e).SourcePos,
                          line, pos);
        if Assigned(FVM.FOnFormatException) then
          FVM.FOnFormatException(Self, line, pos, e);
        raise;
      end
      else
        raise;
    end;
  finally
    parser.Free;
  end;
end;

procedure TPreparedDynCode.PrepareStmt(const AStmt: WideString);
var
  parser:    ILMDParserBase;
  line, pos: Integer;
begin
  FSource.Text := AStmt;
  parser       := FVM.FLanguage.CreateParser(EvalCbs);
  try
    try
      FParsed := parser.ParseStmt(FSource.Text);

      FByteCode.BeginEmit(AStmt, FVM.FGlobalNamespace, 0);
      FParsed.Emit(FVM.FGlobalNamespace, FByteCode);
      FByteCode.Emit(icRet);
      FByteCode.EndEmit;
    except
      on e: ELMDCompileBase do
      begin
        FSource.PosToLine(ELMDCompileBase(e).SourcePos,
                          line, pos);
        if Assigned(FVM.FOnFormatException) then
          FVM.FOnFormatException(Self, line, pos, e);
        raise;
      end
      else
        raise;
    end;
  finally
    parser.Free;
  end;
end;

function TLMDVirtMachine.PrepareExpr(const AExpr: WideString): TObject;
var
  pcd: TPreparedDynCode;
begin
  Result := nil; // Initialize.
  FSection.Acquire;
  try
    if not (FState in [msInitialized, msActive]) then
      raise ELMDVirtMachine.Create(SLMDVMInitialize);

    pcd := TPreparedDynCode.Create(Self);
    try
      pcd.PrepareExpr(AExpr);
    except
      pcd.Free;
      raise;
    end;

    Result := pcd;
  finally
    FSection.Release;
  end;
end;

function TLMDVirtMachine.PrepareStmt(const AStmt: WideString): TObject;
var
  pcd: TPreparedDynCode;
begin
  Result := nil; // Initialize.
  FSection.Acquire;
  try
    if not (FState in [msInitialized, msActive]) then
      raise ELMDVirtMachine.Create(SLMDVMInitialize);

    pcd := TPreparedDynCode.Create(Self);
    try
      pcd.PrepareStmt(AStmt);
    except
      pcd.Free;
      raise;
    end;

    Result := pcd;
  finally
    FSection.Release;
  end;
end;

function TLMDVirtMachine.Eval(const AExpr: WideString): OleVariant;
var
  obj: TObject;
begin
  obj := PrepareExpr(AExpr);
  try
    Result := Eval(obj);
  finally
    obj.Free;
  end;
end;

procedure TLMDVirtMachine.ExecStmt(const AStmt: WideString);
var
  obj: TObject;
begin
  obj := PrepareStmt(AStmt);
  try
    ExecStmt(obj);
  finally
    obj.Free;
  end;
end;

function TLMDVirtMachine.ReadVar(const AName: WideString): OleVariant;
var
  vobj:     TLMDGlobalValuedObject;
  trddt:    TLMDThreadData;
  threadVM: TLMDThreadVM;
begin
  trddt := ThreadData;
  if FId.Index >= trddt.VMDataLength then
    trddt.Thread := VMIndexes.InitThread(FId);

  threadVM := trddt.Thread.VMData[FId.Index];

  if not threadVM.Lock then
    RaiseVMNotActive;
  try
    vobj := threadVM.Globals.FindValObjByStrName(AName); // No UpperCase needed.

    if vobj = nil then
      RaiseValObjNotFound(AName);

    Result := vobj.Value;
  finally
    threadVM.Unlock;
  end;
end;

class procedure TLMDVirtMachine.RedimArray(ARedim: TLMDArrayRedim;
  var AValue: OleVariant; AArgs: PLMDVarArray);

  procedure _CopyMultyDim(ASrc: PSafeArray; ASElemType: TVarType;
                          ADest: PSafeArray; ADElemType: TVarType);
  label
    L, L2;
  var
    i:       Integer;
    starts,
    eofs,
    indices: array[0..MAX_ARRAY_BOUNDS] of Integer;
    dim,
    lstdm:   Integer;
    v:       OleVariant;
  begin
    lstdm := ASrc.cDims - 1;

    for i := 0 to lstdm do
    begin
      dim       := lstdm - i;
      starts[i] := Max(ASrc.rgsabound[dim].lLbound,
                       ADest.rgsabound[dim].lLbound);
      eofs[i]   := Min(ASrc.rgsabound[dim].lLbound +
                       Integer(ASrc.rgsabound[dim].cElements),
                       ADest.rgsabound[dim].lLbound +
                       Integer(ADest.rgsabound[dim].cElements));

      if starts[i] >= eofs[i] then
        Exit; // No intersection.
    end;

    indices := starts;
    dim     := lstdm;
  L:
    GetArrayElem(ASrc, ASElemType, @indices[0], v);
    SetArrayElem(ADest, ADElemType, @indices[0], v);

    Inc(indices[dim]);
    if indices[dim] <> eofs[dim] then
      goto L
    else
    begin
  L2:
      Dec(dim);
      if dim < 0 then
        Exit;

      Inc(indices[dim]);
      if indices[dim] = eofs[dim] then
        goto L2;

      repeat
        Inc(dim);
        indices[dim] := starts[dim];
      until (dim = lstdm);

      goto L;
    end;
  end;

  procedure _CopySingleDim(ASrc: PSafeArray; ASElemType: TVarType;
                           ADest: PSafeArray; ADElemType: TVarType);
  var
    low, eof: Integer;
    i:        Integer;
    v:        OleVariant;
  begin
    low := Max(ASrc.rgsabound[0].lLbound,
               ADest.rgsabound[0].lLbound);
    eof := Min(ASrc.rgsabound[0].lLbound +
               Integer(ASrc.rgsabound[0].cElements),
               ADest.rgsabound[0].lLbound +
               Integer(ADest.rgsabound[0].cElements));

    for i := low to eof - 1 do
    begin
      GetArrayElem(ASrc, ASElemType, @i, v);
      SetArrayElem(ADest, ADElemType, @i, v);
    end;
  end;

var
  src:  PSafeArray;
  dst:  OleVariant;
  eltp: TVarType;
begin
  if ARedim.Preserve and (TVarData(AValue).VType <> varEmpty) then
  begin
    src := GetArray(AValue, eltp);
    if src.cDims <> ARedim.DimCount then
      ELMDVMRuntime.RaiseError(retInvalidParamCount);

    CreateArray(ARedim, AArgs, dst);

    if ARedim.DimCount = 1 then
      _CopySingleDim(src, eltp, PSafeArray(TVarData(dst).VArray),
                     TVarData(dst).VType and varTypeMask)
    else
      _CopyMultyDim(src, eltp, PSafeArray(TVarData(dst).VArray),
                    TVarData(dst).VType and varTypeMask);

    VarMoveData(AValue, dst);
  end
  else
    CreateArray(ARedim, AArgs, AValue);
end;

procedure TLMDVirtMachine.RemoveBreakpoint(ALine: Integer);
var
  bcd:   TLMDByteCode;
  instr: PLMDInstr;
begin
  FSection.Acquire;
  try
    if FState = msUninitialized then
      raise ELMDVirtMachine.Create(SLMDVMInitialize);

    if FindBreakpointCode(ALine, bcd, instr) then
      FBreakpoints.RemoveUserBP(instr);
  finally
    FSection.Release;
  end;
end;

class procedure TLMDVirtMachine.SetArrayElem(AArray: PSafeArray;
  AElemType: TVarType; AIndices: PInteger; const AValue: OleVariant);

  procedure _PutOleStr(A: PSafeArray; const AIndices;
                       const AValue: OleVariant);
  var
    s: WideString;
  begin
    s := AValue;
    VarResultCheck(SafeArrayPutElement(A, AIndices, Pointer(s)^));
  end;

  procedure _PutUnknown(A: PSafeArray; const AIndices;
                        const AValue: OleVariant);
  var
    obj: IUnknown;
  begin
    obj := AValue;
    VarResultCheck(SafeArrayPutElement(A, AIndices, Pointer(obj)^));
  end;

  procedure _PutDispatch(A: PSafeArray; const AIndices;
                        const AValue: OleVariant);
  var
    obj: IDispatch;
  begin
    obj := AValue;
    VarResultCheck(SafeArrayPutElement(A, AIndices, Pointer(obj)^));
  end;

var
  elemp:   Pointer;
  elemdt:  TVarData;
begin
  case AElemType of
    varSmallint:    elemdt.VSmallInt  := AValue;
    varInteger:     elemdt.VInteger   := AValue;
    varSingle:      elemdt.VSingle    := AValue;
    varDouble:      elemdt.VDouble    := AValue;
    varCurrency:    elemdt.VCurrency  := AValue;
    varDate:        elemdt.VDate      := AValue;
    varOleStr:      begin
                      _PutOleStr(AArray, AIndices^, AValue);
                      Exit;
                    end;
    varDispatch:    begin
                      _PutDispatch(AArray, AIndices^, AValue);
                      Exit;
                    end;
    varError:       elemdt.VError     := AValue;
    varBoolean:     elemdt.VBoolean   := AValue;
    varVariant:     begin
                      VarResultCheck(SafeArrayPtrOfIndex(AArray, AIndices^,
                                                         elemp));
                      OleVariant(elemp^) := AValue;
                      Exit;
                    end;
    varUnknown:     begin
                      _PutUnknown(AArray, AIndices^, AValue);
                      Exit;
                    end;
    varShortInt:    elemdt.VShortInt  := AValue;
    varByte:        elemdt.VByte      := AValue;
    varWord:        elemdt.VWord      := AValue;
    varLongWord:    elemdt.VLongWord  := AValue;
    varInt64:       elemdt.VInt64     := AValue;
    {$IFDEF LMDCOMP12}
    varUInt64:      elemdt.VUInt64    := AValue;
    {$ENDIF}
  else
    VarCastError;
  end;

  elemdt.VType := AElemType;
  VarResultCheck(SafeArrayPutElement(AArray, AIndices^,  // Only simple types
                                     elemdt.VPointer));  // here. So, data need
                                                         // not be finalized.
end;

function TLMDVirtMachine.SetBreakpoint(ALine: Integer): Boolean;
var
  bcd:   TLMDByteCode;
  instr: PLMDInstr;
begin
  Result := False; // Initialize.
  FSection.Acquire;
  try
    if FState = msUninitialized then
      raise ELMDVirtMachine.Create(SLMDVMInitialize);

    Result := FindBreakpointCode(ALine, bcd, instr);
    if Result then
      FBreakpoints.SetUserBP(instr);
  finally
    FSection.Release;
  end;
end;

class procedure TLMDVirtMachine.SetIndexed(var AIndexed: OleVariant;
  AValue: POleVariant; AArgs: PLMDVarArray; AArgCount: Integer);
const
  NamedArgs: Longint = DISPID_PROPERTYPUT;
label
  L, L_ARRAY, L_DISPATCH;
var
  v:        PVarData;
  p:        Pointer;
  i:        Integer;
  indices:  array[0..MAX_ARRAY_BOUNDS] of Integer;
  dispprms: TDispParams;
  enfo:     packed array[0..SizeOf(TExcepInfo) - 1] of Byte;
  hr:       HResult;
  args:     array[0..MAX_ARG_COUNT - 1] of TVariantArg;
begin
  v := @AIndexed;
L:
  case v.VType of
    varDispatch:              begin
                                p := v.VDispatch;
                                goto L_DISPATCH;
                              end;
    varByRef or varDispatch:  begin
                                p := Pointer(v.VPointer^);
                                goto L_DISPATCH;
                              end;
    varByRef or varVariant:   begin
                                v := PVarData(VarResolveRefNoCheck(OleVariant(v^)));
                                goto L;
                              end;
  else
    if (v.VType and varArray) <> 0 then
    begin
      if (v.VType and varByRef) <> 0 then
        p := PSafeArray(v.VPointer^)
      else
        p := PSafeArray(v.VArray);
      goto L_ARRAY;
    end
    else
      ELMDVMRuntime.RaiseError(retTypeMismatch);
  end;

L_ARRAY:

  if AArgCount > MAX_ARRAY_BOUNDS - 1 then
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  if PSafeArray(p).cDims <> AArgCount then
    ELMDVMRuntime.RaiseError(retInvalidParamCount);
  for i := 0 to AArgCount - 1 do
    indices[i] := AArgs[i];

  SetArrayElem(PSafeArray(p), v.VType and varTypeMask,
               @indices[0], AValue^);
  Exit; // Done.

L_DISPATCH:

  with dispprms do
  begin
    cArgs := AArgCount + 1;
    if cArgs > MAX_ARG_COUNT - 1 then
      ELMDVMRuntime.RaiseError(retInvalidParamCount);

    // Arguments should be treated by IDispatch as readonly,
    // so we just copy memory, without add-refs/releases.

    args[0] := PVariantArg(AValue)^;
    for i := 1 to cArgs - 1 do
      args[i] := TVariantArg(AArgs[cArgs - 1 - i]);

    rgvarg            := @args[0];
    rgdispidNamedArgs := @NamedArgs;
    cNamedArgs        := 1;
  end;

  FillChar(enfo, SizeOf(TExcepInfo), 0);
  hr := IDispatch(p).Invoke(DISPID_VALUE, GUID_NULL, 0, DISPATCH_PROPERTYPUT or
                            DISPATCH_PROPERTYPUTREF, dispprms, nil, @enfo, nil);
  if hr <> S_OK then
    ELMDVMRuntime.RaiseError(hr, TExcepInfo(enfo), True);
end;

function TLMDVirtMachine.FindBreakpointCode(ALine: Integer;
  out AByteCode: TLMDByteCode; out AInstr: PLMDInstr): Boolean;
var
  i:         Integer;
  spos, lnt: Integer;
begin
  FSource.LineToPos(ALine, spos, lnt);

  AByteCode := FGlobalByteCode;
  AInstr    := AByteCode.GetFirstBreakInstr(spos, lnt);
  if AInstr <> nil then
  begin
    Result := True;
    Exit;
  end;

  for i := 0 to FProcedures.Count - 1 do
  begin
    AByteCode := TLMDProcObject(FProcedures[i]).ByteCode;
    AInstr    := AByteCode.GetFirstBreakInstr(spos, lnt);
    if AInstr <> nil then
    begin
      Result := True;
      Exit;
    end;
  end;

  AByteCode := nil;
  AInstr    := nil;
  Result    := False;
end;

{ TLMDVMBreakpoints }

procedure TLMDVMBreakpoints.Clear;
var
  i: Integer;
begin
  FSection.Acquire;
  try
    for i := 0 to FItems.Count - 1 do
      TObject(FItems[i]).Free;
    FItems.Clear;
  finally
    FSection.Release;
  end;
end;

constructor TLMDVMBreakpoints.Create(AVM: TLMDVirtMachine);
begin
  inherited Create;

  FVM      := AVM;
  FItems   := TList.Create;
  FSection := TCriticalSection.Create;
end;

destructor TLMDVMBreakpoints.Destroy;
begin
  Clear;
  FSection.Free;
  FItems.Free;
  inherited;
end;

function TLMDVMBreakpoints.FindItem(AInstr: PLMDInstr): TLMDVMBreakpoint;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    if TLMDVMBreakpoint(FItems[i]).Instr = AInstr then
    begin
      Result := TLMDVMBreakpoint(FItems[i]);
      Exit;
    end;
    
  Result := nil;
end;

function TLMDVMBreakpoints.GetInfo(AThread: TLMDThread;
  ADebugger: TLMDVMDebugger; AStepBase: PLMDFrame; ACurFrame: TLMDFrame;
  AInstr: PLMDInstr; out ABreakKind: TLMDVMBreakKind;
  out AOrigin: TLMDInstr): TLMDVMGetBPInfoResult;
var
  item:   TLMDVMBreakpoint;
  isstep: Boolean;
begin
  Result     := bpirNoBPInfo;
  ABreakKind := bkBreakpoint;
  
  FSection.Acquire;
  try
    item := FindItem(AInstr);

    if item <> nil then
    begin
      isstep := (IndexOfThread(item, AThread) <> -1);

      AOrigin      := AInstr^; // Copy other fields as is.
      AOrigin.Code := item.Origin;
      Result       := bpirOk;

      if isstep then
        ABreakKind := bkStep;

      if not item.IsUser and (not isstep or (ACurFrame < AStepBase^)) then
        Result := bpirGoThrough;
    end
    else if AInstr.Code <> icBreak then // Check inside lock.
    begin
      if (ADebugger <> nil) and ADebugger.ResetCausingBreak then
      begin
        Result     := bpirCausedBreak;
        ABreakKind := bkCausedBreak;
      end
      else
        Result := bpirBPRemoved;
    end;
  finally
    FSection.Release;
  end;
end;

procedure TLMDVMBreakpoints.RemoveUserBP(AInstr: PLMDInstr);
var
  item: TLMDVMBreakpoint;
begin
  FSection.Acquire;
  try
    item := FindItem(AInstr);

    if item <> nil then
    begin
      item.IsUser := False;
      TryRemoveItem(item);
    end;
  finally
    FSection.Release;
  end;
end;

procedure TLMDVMBreakpoints.SetUserBP(AInstr: PLMDInstr);
var
  item: TLMDVMBreakpoint;
begin
  FSection.Acquire;
  try
    item := FindItem(AInstr);
    if item = nil then
      item := AddItem(AInstr);

    item.IsUser := True;
  finally
    FSection.Release;
  end;
end;

procedure TLMDVMBreakpoints.TryRemoveItem(AItem: TLMDVMBreakpoint);
begin
  if not AItem.IsUser and (Length(AItem.Threads) = 0) then
  begin
    AItem.Instr.Code := AItem.Origin; // Restore code.

    FItems.Remove(AItem);
    AItem.Free;
  end;
end;

function TLMDVMBreakpoints.AddItem(AInstr: PLMDInstr): TLMDVMBreakpoint;
begin
  Result        := TLMDVMBreakpoint.Create;
  Result.Instr  := AInstr;
  Result.Origin := AInstr.Code;
  AInstr.Code   := icBreak; // Replace code.

  FItems.Add(Result);
end;

procedure TLMDVMBreakpoints.RemoveStepBps(AThread: TLMDThread;
  AStepBase: PLMDFrame);
var
  i, idx: Integer;
  item:   TLMDVMBreakpoint;
begin
  FSection.Acquire;
  try
    for i := FItems.Count - 1 downto 0 do
    begin
      item := TLMDVMBreakpoint(FItems[i]);
      idx  := IndexOfThread(item, AThread);

      if idx <> -1 then
      begin
        DeleteThread(item, idx);
        TryRemoveItem(item);
      end;
    end;

    AStepBase^ := STEP_NOSTOP;
  finally
    FSection.Release;
  end;
end;

procedure TLMDVMBreakpoints.SetStepBPs(AThread: TLMDThread;
  AStepBase: PLMDFrame; ACurFrame: TLMDFrame; AStartFrom: PLMDInstr;
  ASkipStartLine: Boolean);
begin
  FSection.Acquire;
  try
    AddStepBPs(AThread, AStartFrom, ASkipStartLine);
    AStepBase^ := ACurFrame;
  finally
    FSection.Release;
  end;
end;

function TLMDVMBreakpoints.IndexOfThread(AItem: TLMDVMBreakpoint;
  AThread: TLMDThread): Integer;
var
  i: Integer;
begin
  for i := 0 to High(AItem.Threads) do
    if AItem.Threads[i] = AThread then
    begin
      Result := i;
      Exit;
    end;

  Result := -1;
end;

procedure TLMDVMBreakpoints.DeleteThread(AItem: TLMDVMBreakpoint;
  AIndex: Integer);
var
  i: Integer;
begin
  if (AIndex >= 0) and (AIndex <= High(AItem.Threads)) then
  begin
    for i := AIndex + 1 to High(AItem.Threads) do
      AItem.Threads[i - 1] := AItem.Threads[i];

    SetLength(AItem.Threads, Length(AItem.Threads) - 1);
  end;
end;

procedure TLMDVMBreakpoints.AddThread(AItem: TLMDVMBreakpoint;
  AThread: TLMDThread);
var
  oldln: Integer;
begin
  if IndexOfThread(AItem, AThread) = -1 then
  begin
    oldln := Length(AItem.Threads);

    SetLength(AItem.Threads, oldln + 1);
    AItem.Threads[oldln] := AThread;
  end;
end;

procedure TLMDVMBreakpoints.AddStepBPs(AThread: TLMDThread;
  AStartFrom: PLMDInstr; ASkipStartLine: Boolean);
var
  chidx:        Integer;
  chunks:       TList;
  cur:          PLMDInstr;
  isleaf, nobp: Boolean;
  line:         Integer;

  function _GetInstrCode(AInstr: PLMDInstr): TLMDInstrCode;
  begin
    Result := AInstr.Code;
    if Result = icBreak then
      Result := FindItem(AInstr).Origin;
  end;

  procedure _AddChunk(AStart: PLMDInstr);
  begin
    if chunks.IndexOf(AStart) = -1 then
      chunks.Add(AStart);
  end;

  procedure _AddChunks(AInstr: PLMDInstr; out AIsLeaf, ANoBP: Boolean);
  var
    i: Integer;
  begin
    AIsLeaf := False;
    ANoBP   := False;

    case _GetInstrCode(AInstr) of
      icRet:
        AIsLeaf := True;
      icJump:
      begin
        AIsLeaf := True;
        _AddChunk(TLMDLabel(AInstr.Data).Target);
      end;
      icPop,
      icPush,
      icPush0,
      icPushUnassigned,
      icPushLiteral,
      icPushLocalVar,
      icPushLocalConst,
      icPushArg,
      icPushResult,
      icPushLocalVarRef,
      icPushArgRef,
      icPushResultRef,
      icGreater,
      icGreaterEqual,
      icLess,
      icLessEqual,
      icIn,
      icIs,
      icEqual,
      icRefEqual,
      icNotEqual,
      icRefNotEqual,
      icPlus,
      icMinus,
      icOr,
      icXor,
      icMultiply,
      icDivide,
      icIntDiv,
      icMod,
      icAnd,
      icShl,
      icShr,
      icUnaryPlus,
      icUnaryMinus,
      icUnaryNot:
        ; // Do nothing
      icJmpIfTrue,
      icJmpIfFalse,
      icPopJmpIfTrue,
      icPopJmpIfFalse,
      icPopJmpIfEqual,
      icPopJmpIfNotEqual:
        _AddChunk(TLMDLabel(AInstr.Data).Target);
      icAddValToSet,
      icAddRangeToSet:
        ; // Do nothing
      icGlobCall:
      begin
        if TLMDCall(AInstr.Data).ExitLabel <> nil then
          _AddChunk(TLMDCall(AInstr.Data).ExitLabel.Target);
        if TLMDCall(AInstr.Data).BreakLabel <> nil then
          _AddChunk(TLMDCall(AInstr.Data).BreakLabel.Target);
        if TLMDCall(AInstr.Data).ContinueLabel <> nil then
          _AddChunk(TLMDCall(AInstr.Data).ContinueLabel.Target);
      end;
      icMemberCall,
      icUnnamedCall,
      icNewUnnamedCall,
      icAssignGlobCall,
      icAssignMemberCall,
      icAssignUnnamedCall,
      icAssignLValue,
      icAssignLocalVar,
      icAssignArg,
      icAssignResult,
      icAssignGlobalVar,
      icAssignGlobalConst,
      icForInitLValue,
      icForInitLocal,
      icForInc,
      icForIncStep,
      icForDec:
        ; // Do nothing
      icForJmpIfLE,
      icForJmpIfGE,
      icForJmpStep:
        _AddChunk(TLMDFor(AInstr.Data).JmpLabel.Target);
      icCaseJmpIfEqual,
      icCaseJmpIfInRange:
        _AddChunk(TLMDLabel(AInstr.Data).Target);
      icRaise,
      isReraise,
      icRaiseEBCFromFinally:
        AIsLeaf := True;
      icCallFinally:
      begin
        AIsLeaf := True;
        ANoBP   := True;
        _AddChunk(TLMDTry(AInstr.Data).FinallyLabel.Target);
      end;
      icFinallyRet:
      begin
        AIsLeaf := True;
        ANoBP   := True;

        for i := 0 to TLMDTry(AInstr.Data).KnownFinallyRetCount - 1 do
          _AddChunk(TLMDTry(AInstr.Data).KnownFinallyRets[i].Target);
      end;
      icExceptJmpIfIs:
        _AddChunk(TLMDExcJump(AInstr.Data).Label_.Target);
      icExceptDone,
      icExceptToVar,
      icSetNamespace,
      icGlobCallRef,
      icMemberCallRef,
      icUnnamedCallRef,
      icArrayCreate,
      icArrayRedimLValue,
      icArrayRedimLocal,
      icEventHandlerMake:
        ; // Do nothing
      icBreakpointJmp:
      begin
        AIsLeaf := True;
        _AddChunk(PLMDInstr(AInstr.Data));
      end;
    else
      ELMDVMRuntime.RaiseError(retIEInvalidInstr);
    end; // case
  end;

begin
  chunks := TList.Create;
  try
    _AddChunk(AStartFrom);
    chidx := 0;
    line  := FVM.FSource.PosToLine(AStartFrom.SourceInfo and LMD_SPOSMASK);

    repeat
      cur := chunks[chidx];

      while True do
      begin
        _AddChunks(cur, isleaf, nobp);

        if ((line <> FVM.FSource.PosToLine(cur.SourceInfo and LMD_SPOSMASK)) or
            not ASkipStartLine) and
           ((cur.SourceInfo and LMD_BREAKABLE) <> 0) then
        begin
          isleaf := True;
          if not nobp then
            AddStepBP(cur, AThread);
        end;

        if isleaf then // Chunk processed.
          Break; // while

        cur := PLMDInstr(TLMDPtrInt(cur) + SizeOf(TLMDInstr));
      end;
      
      Inc(chidx);
    until chidx >= chunks.Count;
  finally
    chunks.Free;
  end;
end;

procedure TLMDVMBreakpoints.AddStepBP(AInstr: PLMDInstr;
  AThread: TLMDThread);
var
  item: TLMDVMBreakpoint;
begin
  item := FindItem(AInstr);
  if item = nil then
    item := AddItem(AInstr);

  AddThread(item, AThread);
end;

procedure TLMDVMBreakpoints.SetExcStepBPs(AThread: TLMDThread;
  AStepBase: PLMDFrame; ACurFrame: TLMDFrame; AHandler: TLMDTry);
begin
  FSection.Acquire;
  try
    AddExcStepBPs(AThread, AHandler);
    AStepBase^ := ACurFrame;
  finally
    FSection.Release;
  end;
end;

procedure TLMDVMBreakpoints.AddExcStepBPs(AThread: TLMDThread;
  AHandler: TLMDTry);
begin
  while AHandler <> nil do
  begin
    AddStepBPs(AThread, AHandler.HandlerLabel.Target, False);
    AHandler := AHandler.Parent;
  end;
end;

function TVMIndexes.GetSteppingBase(AThread: TLMDThread;
  ALock: TLMDVMLock): PLMDFrame;
var
  i:    Integer;
  item: TVMSteppingItem;
begin
  if ALock.FDebuggerId = -1 then
  begin
    Result := @NoStopSteps;
    Exit;
  end;

  for i := 0 to FSteppingItems.Count - 1 do
  begin
    item := TVMSteppingItem(FSteppingItems[i]);
    
    if (item.Thread = AThread) and
       (item.DebuggerId = ALock.FDebuggerId) then
    begin
      Result := @item.Base;
      Exit;
    end;
  end;

  item            := TVMSteppingItem.Create;
  item.Thread     := AThread;
  item.DebuggerId := ALock.FDebuggerId;
  item.Base       := STEP_NOSTOP;

  FSteppingItems.Add(item);
  if FSteppingItems.Count > (FLocks.Count * 10) then
    SteppingBaseGC;

  Result := @item.Base;
end;

{ TLMDPasDebugger }

procedure TLMDVMDebugger.CauseBreak;
var
  i: Integer;
begin
  FSection.Acquire;
  try
    FCausingBreak := True;
    for i := 0 to FVMs.Count - 1 do
      TLMDVirtMachine(FVMs[i]).FTerminateFlag := 0; // Inside FSection.
  finally
    FSection.Release;
  end;
end;

constructor TLMDVMDebugger.Create;
begin
  inherited Create;

  FId      := VMIndexes.GetNextDebuggerId;
  FSection := TCriticalSection.Create;
  FVMs     := TList.Create;
end;

destructor TLMDVMDebugger.Destroy;
begin
  FSection.Free;
  FVMs.Free;
  inherited;
end;

function TLMDVMDebugger.DoOnBreak(ABreakKind: TLMDVMBreakKind;
  AVM: TLMDVirtMachine; ALine: Integer;
  AStack: TLMDPasStackFrames): TLMVMDResumeKind;
begin
  Result := rkContinue;
  if Assigned(FOnBreak) then
    FOnBreak(Self, ABreakKind, AVM, ALine, AStack, Result);
end;

function TVMIndexes.GetNextDebuggerId: Integer;
begin
  FSection.Acquire;
  try
    Result := FNextDebuggerId;
    Inc(FNextDebuggerId);
  finally
    FSection.Release;
  end;
end;

procedure TVMIndexes.SteppingBaseGC;

  function _IsLockExist(ADebuggerId: Integer): Boolean;
  var
    i: Integer;
  begin
    for i := 0 to FLocks.Count - 1 do
      if TLMDVMLock(FLocks[i]).FDebuggerId = ADebuggerId then
      begin
        Result := True;
        Exit;
      end;
    Result := False;
  end;

var
  i:    Integer;
  item: TVMSteppingItem;
begin
  for i := FSteppingItems.Count - 1 downto 0 do
  begin
    item := TVMSteppingItem(FSteppingItems[i]);

    if not _IsLockExist(item.DebuggerId) then
    begin
      item.Free;
      FSteppingItems.Delete(i);
    end;
  end;
end;

procedure TVMIndexes.ThreadDataGC;
var
  i:   Integer;
  tdt: TLMDThread;
begin
  for i := FThreadDatas.Count - 1 downto 0 do
  begin
    tdt := TLMDThread(FThreadDatas[i]);

    if tdt.IsThreadClosed then
    begin
      FThreadDatas.Delete(i);
      tdt.Free;
    end;
  end;
end;

function TLMDVMDebugger.HandleBreak(AThread: TLMDThread;
  ABreakKind: TLMDVMBreakKind; AVM: TLMDVirtMachine;
  ALine: Integer): TLMVMDResumeKind;
var
  cstack: TLMDPasStackFrames;
  cur:    PLMDCallStackFrame;
begin
  cstack := TLMDPasStackFrames.Create(GetCurrentThreadId);
  try
    cur := AThread.CallStack;
    while cur <> nil do
    begin
      if cur.VM.FDebugger = Self then
        cstack.Add(cur);
      cur := cur.Next;
    end;

    cstack.SetInBreakFlags(AThread, True);
    Result := DoOnBreak(ABreakKind, AVM, ALine, cstack);
  finally
    cstack.SetInBreakFlags(AThread, False);
    cstack.Free;
  end;
end;

procedure TLMDVMDebugger.InsertVM(AVM: TLMDVirtMachine);
begin
  FSection.Acquire;
  try
    if FVMs.IndexOf(AVM) = -1 then
    begin
      FVMs.Add(AVM);
      AVM.FDebugger := Self;
    end;
  finally
    FSection.Release;
  end;
end;

function TLMDVMDebugger.ResetCausingBreak: Boolean;
begin
  FSection.Acquire;
  try
    Result        := FCausingBreak;
    FCausingBreak := False;
  finally
    FSection.Release;
  end;
end;

procedure TLMDVMDebugger.RemoveVM(AVM: TLMDVirtMachine);
begin
  FSection.Acquire;
  try
    if AVM.FDebugger = Self then
    begin
      FVMs.Remove(AVM);
      AVM.FDebugger := nil;
    end;
  finally
    FSection.Release;
  end;
end;

{ TLMDPasStackFrames }

procedure TLMDPasStackFrames.Add(AFrame: PLMDCallStackFrame);
begin
  FItems.Add(TLMDPasStackFrame.Create(Self, AFrame));
end;

constructor TLMDPasStackFrames.Create(ABreakedThreadId: Cardinal);
begin
  inherited Create;
  
  FItems           := TList.Create;
  FBreakedThreadId := ABreakedThreadId;
end;

destructor TLMDPasStackFrames.Destroy;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TObject(FItems[i]).Free;
  FItems.Free;
  inherited;
end;

function TLMDPasStackFrames.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TLMDPasStackFrames.GetItems(AIndex: Integer): TLMDPasStackFrame;
begin
  Result := TLMDPasStackFrame(FItems[AIndex]);
end;

procedure TLMDPasStackFrames.SetInBreakFlags(AThread: TLMDThread;
  AInBreak: Boolean);
var
  i:    Integer;
  item: TLMDPasStackFrame;
begin
  for i := 0 to FItems.Count - 1 do
  begin
    item := TLMDPasStackFrame(FItems[i]);
    AThread.VMData[item.FVM.FId.Index].InBreak := AInBreak;
  end;
end;

{ TLMDPasStackFrame }

constructor TLMDPasStackFrame.Create(AOwner: TLMDPasStackFrames;
  AFrame: PLMDCallStackFrame);
begin
  inherited Create;
  FOwner := AOwner;
  FFrame := AFrame;
  FillParams;
end;

procedure TLMDPasStackFrame.Eval(const AExpr: WideString;
  out AVars: TLMDPasDebugVar);
var
  res: OleVariant;
begin
  if GetCurrentThreadId <> FOwner.FBreakedThreadId then
    raise ELMDVirtMachine.Create(SLMDInvalidDebugThread);

  try
    res := FVM.EvalDebug(AExpr, FFrame);
    TDebugVarUtils.FillVar(AExpr, TDebugVarUtils.GetType(res),
                           FVM.FLanguage, res, AVars);
  except
    on E: Exception do
    begin
      AVars.Name     := AExpr;
      AVars.Type_    := 'Error';
      AVars.Value    := E.Message;
      AVars.Children := nil;
    end;
  end;
end;

function TLMDPasStackFrame.Eval(const AExpr: WideString;
  out AValue: OleVariant): Boolean;
begin
  if GetCurrentThreadId <> FOwner.FBreakedThreadId then
    raise ELMDVirtMachine.Create(SLMDInvalidDebugThread);

  Result := True;
  try
    AValue := FVM.EvalDebug(AExpr, FFrame);
  except
    Result := False;
  end;
end;

procedure TLMDPasStackFrame.FillParams;
begin
  FCtx         := PLMDVMInterpretContext(FFrame.Ctx);
  FVM          := FFrame.VM;
  FDescription := FCtx.Code.Description;
  FLine        := FFrame.VM.FSource.PosToLine(FFrame.IP.SourceInfo and
                                              LMD_SPOSMASK);
end;

procedure TLMDPasStackFrame.GetVariables(out AVars: TLMDPasDebugVar);
begin
  if GetCurrentThreadId <> FOwner.FBreakedThreadId then
    raise ELMDVirtMachine.Create(SLMDInvalidDebugThread);

  if FCtx.Code = FVM.FGlobalByteCode then
  begin
    AVars.Name     := 'Globals';
    AVars.Type_    := 'object';
    AVars.Value    := '{...}';
    AVars.Children := TStoredVarChildren.Init(FFrame, False);
  end
  else
  begin
    AVars.Name     := 'Locals';
    AVars.Type_    := 'object';
    AVars.Value    := '{...}';
    AVars.Children := TStoredVarChildren.Init(FFrame, True);
  end;
end;

{ TStoredVarChildren }

procedure TStoredVarChildren.AddVarProc(const ADisplayName: WideString;
  const ASRes: TLMDNameSearchRes);
var
  dv:   TLMDPasDebugVar;
  ctx:  PLMDVMInterpretContext;
  vobj: TLMDGlobalValuedObject;
  v:    OleVariant;
begin
  ctx := PLMDVMInterpretContext(FFrame.Ctx);

  case ASRes.ObjKind of
    srGlobalVar,
    srGlobalConst:
    begin
      vobj := TLMDGlobalValuedObject(ASRes.NamedObject);
      v    := vobj.Value;

      TDebugVarUtils.FillVar(ADisplayName, TDebugVarUtils.GetType(v),
                             FFrame.VM.FLanguage, v, dv);
    end;
    srLocalVar:
    begin
      v := FFrame.Stack[ASRes.LocalVarIndex];
      TDebugVarUtils.FillVar(ADisplayName, TDebugVarUtils.GetType(v),
                             FFrame.VM.FLanguage, v, dv);
    end;
    srLocalConst:
    begin
      v := ASRes.LocalConst^;
      TDebugVarUtils.FillVar(ADisplayName, TDebugVarUtils.GetType(v),
                             FFrame.VM.FLanguage, v, dv);
    end;
    srParam:
    begin
      v := ctx.Args[ASRes.ParamInfo.Index];
      TDebugVarUtils.FillVar(ADisplayName, TDebugVarUtils.GetType(v),
                             FFrame.VM.FLanguage, v, dv);
    end;
    srResult:
    begin
      if ctx.Result <> nil then
      begin
        v := ctx.Result^;
        TDebugVarUtils.FillVar(ADisplayName, TDebugVarUtils.GetType(v),
                               FFrame.VM.FLanguage, v, dv);
      end;
    end;
  else
    Exit;
  end;

  SetLength(FItems, Length(FItems) + 1);
  FItems[High(FItems)] := dv;
end;

procedure TStoredVarChildren.Enum(AProc: TLMDPasDebugVarChildProc;
  ACookie: Pointer);
var
  i:    Integer;
  stop: Boolean;
begin
  stop := False;

  for i := 0 to High(FItems) do
  begin
    AProc(FItems[i], ACookie, stop);
    if stop then
      Break; // for
  end;
end;

class function TStoredVarChildren.Init(AFrame: PLMDCallStackFrame;
  ALocalsOnly: Boolean): ILMDPasDebugVarChildren;
var
  obj: TStoredVarChildren;
begin
  obj := TStoredVarChildren.Create;
  try
    obj.FFrame := AFrame;
    AFrame.CurNS.EnumDebugVars(ALocalsOnly, obj.AddVarProc);
  except
    obj.Free;
    raise;
  end;

  Result := obj;
end;

{ TDebugVarUtils }

class procedure TDebugVarUtils.FillVar(const AName, AType: WideString;
  const ALang: ILMDLanguage; const AValue: OleVariant;
  out AVar: TLMDPasDebugVar);
begin
  AVar.Name     := AName;
  AVar.Type_    := AType;
  AVar.Value    := GetValue(AValue, ALang);
  AVar.Children := GetChildren(ALang, AValue);
end;

class function TDebugVarUtils.GetChildren(const ALang: ILMDLanguage;
  const AValue: OleVariant): ILMDPasDebugVarChildren;
var
  dt: PVarData;
begin
  dt     := PVarData(VarResolveRef(AValue));
  Result := nil;

  if (dt.VType = varDispatch) and (dt.VDispatch <> nil) and
     TDispatchVarChildren.HasChildProps(IDispatch(dt.VDispatch)) then
  begin
    Result := TDispatchVarChildren.Create(ALang, IDispatch(dt.VDispatch));
  end
  else if ((dt.VType and varArray) <> 0) and
          TArrayVarChildren.HasChildProps(OleVariant(dt^)) then
    Result := TArrayVarChildren.Create(ALang, OleVariant(dt^));
end;

class function TDebugVarUtils.GetType(
  const AValue: OleVariant): WideString;
begin
  Result := GetType(PVarData(VarResolveRef(AValue)).VType);
end;

class function TDebugVarUtils.GetType(AType: TVarType): WideString;
const
  TYPES: array [varEmpty..varInt64] of string = (
    'Unassigned', 'Null', 'Smallint', 'Integer', 'Single', 'Double',
    'Currency', 'Date', 'String', 'Object', 'Error', 'Boolean', 'Variant',
    'Unknown', 'Decimal', '$0F', 'ShortInt', 'Byte', 'Word', 'LongWord',
    'Int64');
begin
  if (AType and varTypeMask) <= varInt64 then
    Result := TYPES[AType and varTypeMask]
  else if AType = varString then
    Result := 'String'
  else if AType = varAny then
    Result := 'Any'
  else if not TryGetCustomVarTypeName(AType, Result) then
    Result := Format('Unknown type $%x', [AType and varTypeMask]);

  if (AType and varArray) <> 0 then
    Result := 'array of ' + Result;
end;

class function TDebugVarUtils.GetType(AType: PTypeDesc): WideString;
var
  vtype: TVarType;
begin
  while AType.vt = VT_PTR do
    AType := AType.ptdesc;

  vtype := AType.vt;
  if vtype = VT_USERDEFINED then
    vtype := varDispatch;

  Result := GetType(vtype);
end;

class function TDebugVarUtils.GetValue(const AValue: OleVariant;
  const ALang: ILMDLanguage): WideString;
var
  dt: PVarData;
begin
  dt     := PVarData(VarResolveRef(AValue));
  Result := '';

  try
    if (dt.VType and varArray) <> 0 then
      Result := '{...}'
    else case dt.VType and varTypeMask of
      varEmpty:       Result := ALang.DebugEmpty;
      varNull:        Result := ALang.DebugNull;
      varSmallint,
      varInteger,
      varSingle,
      varDouble,
      varCurrency,
      varDate:        Result := AValue;
      varOleStr:      Result := QuotedStr(AValue);
      varDispatch:    begin
                        Result := '{...}';
                        if dt.VDispatch = nil then
                          Result := ALang.DebugNothing;
                      end;
      varBoolean:     begin
                        if AValue then
                          Result := 'True'
                        else
                          Result := 'False';
                      end;
      varUnknown:     begin
                        Result := '{...}';
                        if dt.VUnknown = nil then
                          Result := ALang.DebugNothing;
                      end;
      varShortInt,
      varByte,
      varWord,
      varLongWord,
      varInt64:       Result := AValue;
      varString:      Result := ALang.DebugStrLiteral(AValue);
      varAny:         Result := AValue;
    end;
  except
    on E: Exception do
      Result := E.Message;
  end;
end;

{ TDispatchVarChildren }

constructor TDispatchVarChildren.Create(const ALang: ILMDLanguage;
  const AObject: IDispatch);
begin
  inherited Create;
  FLang   := ALang;
  FObject := AObject;
end;

procedure TDispatchVarChildren.Enum(AProc: TLMDPasDebugVarChildProc;
  ACookie: Pointer);
var
  i:      Integer;
  ti:     ITypeInfo;
  tattrs: PTypeAttr;
  fdescr: PFuncDesc;
  name:   WideString;
  cnames: Integer;
  dispid: Integer;
  v:      OleVariant;
  tp:     string;
  item:   TLMDPasDebugVar;
  stop:   Boolean;
begin
  if not Succeeded(FObject.GetTypeInfo(0, 0, ti)) then
    Exit;
  if not Succeeded(ti.GetTypeAttr(tattrs)) then
    Exit;
  try
    stop := False;

    for i := 0 to tattrs.cFuncs - 1 do
    begin
      if not Succeeded(ti.GetFuncDesc(i, fdescr)) then
        Continue; // for
      try
        if not Succeeded(ti.GetNames(fdescr.memid, @name, 1, cnames)) or
           (cnames <> 1) then
          Continue; // for

        if not Succeeded(ti.GetIDsOfNames(@name, 1, @dispid)) then
          Continue; // for

        if fdescr.invkind = INVOKE_PROPERTYGET then
        begin
          if fdescr.cParams > 0 then
          begin
            item.Name     := name + '[]';
            item.Type_    := 'Collection';
            item.Value    := '{...}';
            item.Children := nil;
          end
          else if GetPropValue(dispid, v) then
          begin
            tp := TDebugVarUtils.GetType(@fdescr.elemdescFunc);
            TDebugVarUtils.FillVar(name, tp, FLang, v, item);
          end
          else
          begin
            item.Name     := name;
            item.Type_    := 'Error';
            item.Value    := 'Inaccessible value';
            item.Children := nil;
          end;

          AProc(item, ACookie, stop);
        end;
      finally
        ti.ReleaseFuncDesc(fdescr);
      end;

      if stop then
        Break; // for
    end;
  finally
    ti.ReleaseTypeAttr(tattrs);
  end;
end;

function TDispatchVarChildren.GetPropValue(ADispId: Integer;
  out AValue: OleVariant): Boolean;
var
  dprms: TDispParams;
  enfo:  TExcepInfo;
begin
  FillChar(enfo, SizeOf(TExcepInfo), 0);
  FillChar(dprms, SizeOf(TDispParams), 0);

  Result := Succeeded(FObject.Invoke(ADispId, GUID_NULL, 0,
                                     DISPATCH_PROPERTYGET, dprms,
                                     @AValue, @enfo, nil));
end;

class function TDispatchVarChildren.HasChildProps(
  const AObject: IDispatch): Boolean;
var
  i:      Integer;
  ti:     ITypeInfo;
  tattrs: PTypeAttr;
  fdescr: PFuncDesc;
begin
  Result := False;

  if not Succeeded(AObject.GetTypeInfo(0, 0, ti)) then
    Exit;
  if not Succeeded(ti.GetTypeAttr(tattrs)) then
    Exit;
    
  try
    for i := 0 to tattrs.cFuncs - 1 do
    begin
      if not Succeeded(ti.GetFuncDesc(i, fdescr)) then
        Continue; // for
      try
        if fdescr.invkind = INVOKE_PROPERTYGET then
        begin
          Result := True;
          Exit;
        end;
      finally
        ti.ReleaseFuncDesc(fdescr);
      end;
    end;
  finally
    ti.ReleaseTypeAttr(tattrs);
  end;
end;

{ TArrayVarChildren }

constructor TArrayVarChildren.Create(const ALang: ILMDLanguage;
  const AArray: OleVariant);
var
  eltp: TVarType;
begin
  inherited Create;

  FLang     := ALang;
  FArray    := AArray;
  FIndices  := InitIndices(TLMDVirtMachine.GetArray(AArray, eltp).cDims);
  FDim      := High(FIndices);
  FElemType := InitElemType(AArray);
end;

constructor TArrayVarChildren.Create(const ALang: ILMDLanguage;
  const AArray: OleVariant; ADim: Integer; AIndices: TArrayVarIndices);
begin
  inherited Create;

  FLang     := ALang;
  FArray    := AArray;
  FDim      := ADim;
  FIndices  := Copy(AIndices, 0, Length(AIndices)); // Make unique copy.
  FElemType := InitElemType(AArray);
end;

procedure TArrayVarChildren.Enum(AProc: TLMDPasDebugVarChildProc;
  ACookie: Pointer);
var
  idxs:  TArrayVarIndices;
  revsd: TArrayVarIndices;
  i, j:  Integer;
  item:  TLMDPasDebugVar;
  stop:  Boolean;
  name:  WideString;
  elem:  OleVariant;
  a:     PSafeArray;
  eltp:  TVarType;
  lbnd:  Integer;
  ubnd:  Integer;
begin
  idxs  := Copy(FIndices, 0, Length(FIndices)); // Make unique copy.
  stop  := False;
  a     := TLMDVirtMachine.GetArray(FArray, eltp);
  lbnd  := a.rgsabound[FDim].lLbound;
  ubnd :=  lbnd + Integer(a.rgsabound[FDim].cElements) - 1;

  for i := lbnd to ubnd do
  begin
    idxs[FDim] := i;
    name       := Format('[%d]', [i]);

    if FDim > 0 then
    begin
      item.Name     := name;
      item.Type_    := 'array';
      item.Value    := '{...}';
      item.Children := TArrayVarChildren.Create(FLang, FArray, FDim - 1, idxs);
    end
    else
    begin
      SetLength(revsd, Length(idxs));
      for j := 0 to High(idxs) do
        revsd[j] := idxs[High(idxs) - j];

      TLMDVirtMachine.GetArrayElem(a, eltp, @revsd[0], elem);
      TDebugVarUtils.FillVar(name, FElemType, FLang, elem, item);
    end;

    AProc(item, ACookie, stop);
    if stop then
      Break; // for
  end;
end;

class function TArrayVarChildren.HasChildProps(
  const AArray: OleVariant): Boolean;
var
  i:    Integer;
  a:    PSafeArray;
  eltp: TVarType;
begin
  a := TLMDVirtMachine.GetArray(AArray, eltp);

  for i := 0 to a.cDims - 1 do
    if a.rgsabound[i].cElements = 0 then
    begin
      Result := False;
      Exit;
    end;

  Result := True;
end;

function TArrayVarChildren.InitElemType(
  const AArray: OleVariant): WideString;
begin
  Result := TDebugVarUtils.GetType(PVarData(VarResolveRef(AArray)).VType and
                                   varTypeMask);
end;

function TArrayVarChildren.InitIndices(
  ADimCount: Integer): TArrayVarIndices;
var
  i: Integer;
begin
  SetLength(Result, ADimCount);
  for i := 0 to High(Result) do
    Result[i] := 0;    
end;

function TLMDVirtMachine.EvalDebug(const AExpr: WideString;
  AFrame: PLMDCallStackFrame): OleVariant;
var
  pcd:    TPreparedDynCode;
  ns:     TLMDAbstractNamespace;
  trddt:  TLMDThreadData;
  ctx:    TLMDVMInterpretContext;
begin
  Result := OleUnassigned;
  trddt  := ThreadData;

  pcd := TPreparedDynCode.Create(Self);
  ns  := nil;
  try
    FSection.Acquire;
    try
      if (PLMDVMInterpretContext(AFrame.Ctx).Code <>
          FGlobalByteCode) then
        ns := TDebugVarsNamespace.Create(AFrame);

      pcd.PrepareExpr(AExpr, ns);
    finally
      FSection.Release;
    end;

    ctx.Code   := pcd.FByteCode;
    ctx.Args   := nil;
    ctx.Result := @Result;
    ctx.Source := pcd.FSource;
    Interpret(trddt.Thread, ctx);
  finally
    pcd.Free;
    ns.Free;
  end;
end;

{ TDebugVarsNamespace }

constructor TDebugVarsNamespace.Create(AFrame: PLMDCallStackFrame);
begin
  inherited Create(nil);
  FFrame  := AFrame;
end;

procedure TDebugVarsNamespace.EnumDebugVars(
  ALocalsOnly: Boolean; AProc: TLMDNamespaceEnumVarsProc);
begin
  FFrame.CurNS.EnumDebugVars(ALocalsOnly, AProc);
end;

function TDebugVarsNamespace.Find(AThread: Pointer; AName: Integer;
  AStrName: PWideString): TLMDNameSearchRes;
var
  ctx: PLMDVMInterpretContext;
begin
  Result := FFrame.CurNS.Find(AThread, AName, AStrName);
  ctx    := PLMDVMInterpretContext(FFrame.Ctx);

  case Result.ObjKind of
    srLocalVar:
    begin
      Result.ObjKind     := srDebugVar;
      Result.DebugVar    := @FFrame.Stack[Result.LocalVarIndex];
    end;
    srLocalConst:
    begin
      Result.ObjKind     := srDebugVar;
      Result.DebugVar    := Result.LocalConst;
    end;
    srParam:
    begin
      Result.ObjKind     := srDebugVar;
      Result.DebugVar    := @ctx.Args[Result.ParamInfo.Index];
    end;
    srResult:
    begin
      Result.ObjKind     := srDebugVar;
      Result.DebugVar    := ctx.Result;
    end;
  end;
end;

{------------------------------------------------------------------------------}
{ TLMDThread }

constructor TLMDThread.Create;
begin
  inherited Create;
  FStackPool := TLMDStackPool.Create;
  FThread    := 0;

  if not DuplicateHandle(GetCurrentProcess, GetCurrentThread,
                         GetCurrentProcess, @FThread, 0, True,
                         DUPLICATE_SAME_ACCESS) then
    RaiseLastOSError;
end;

destructor TLMDThread.Destroy;
begin
  FStackPool.Free;
  CloseHandle(FThread);
  inherited;
end;

function TLMDThread.IsThreadClosed: Boolean;
var
  cd: Cardinal;
begin
  if not GetExitCodeThread(FThread, cd) then
    RaiseLastOSError;
  Result := (cd <> STILL_ACTIVE);
end;

function TVMIndexes.IsInactiveOrClosing(const AId: TLMDVMId): Boolean;
var
  lock: TLMDVMLock;
begin
  FSection.Acquire;
  try
    lock   := AId.Lock;
    Result := lock.FInactiveOrClosing;
  finally
    FSection.Release;
  end;
end;

procedure TLMDVirtMachine.HandleBreakpoint(AThread: TLMDThread;
  AFrame: PLMDCallStackFrame; ASteppingBase: PLMDFrame;
  ABreakKind: TLMDVMBreakKind);
var
  line: Integer;
  rknd: TLMVMDResumeKind;
begin
  if not AThread.VMData[FId.Index].InBreak then
  begin
    rknd := rkContinue;
    line := FSource.PosToLine(AFrame.IP.SourceInfo and LMD_SPOSMASK);
    if FDebugger <> nil then
      rknd := FDebugger.HandleBreak(AThread, ABreakKind, Self, line);

    case rknd of
      rkStepOver:
      begin
        FBreakpoints.RemoveStepBps(AThread, ASteppingBase);
        FBreakpoints.SetStepBPs(AThread, ASteppingBase, TLMDFrame(@AFrame),
                                AFrame.IP, True);
      end;
      rkStepInto:
      begin
        FBreakpoints.RemoveStepBps(AThread, ASteppingBase);
        FBreakpoints.SetStepBPs(AThread, ASteppingBase,
                                STEP_STOPATANY,
                                AFrame.IP, True);
      end;
      rkContinue:
        FBreakpoints.RemoveStepBps(AThread, ASteppingBase);
      rkIgnore:
        ; // Do nothing
      rkAbort:
        ELMDVMRuntime.RaiseError(retAborted);
    end;
  end;
end;

{------------------------------------------------------------------------------}
initialization
  InitSetBits;
  VMIndexes   := TVMIndexes.Create;
  EvalCbs     := TVMEvalParserCallbacks.Create;
  NoStopSteps := STEP_NOSTOP;

{------------------------------------------------------------------------------}
finalization
  VMIndexes.Free;
  EvalCbs.Free;

end.

