unit LMDSctScripter;
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

LMDSctScripter unit (YB)
------------------------
LMD Script Pack main control unit.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Controls, TypInfo, ActiveX, Variants, ComObj,
  Types, RTLConsts, intfLMDBase, LMDTypes, LMDStrings, LMDUnicode, LMDHashTable,
  LMDSvcPvdr, LMDSctClass, LMDSctWrappers;

type
  ELMDScriptControl      = class(Exception);
  TLMDScriptControl      = class;
  TLMDDebugModule        = class;
  TLMDScriptDebugger     = class;
  TLMDComExceptionIgnore = class(EOleSysError); // Ignore this exception
                                                // in Delph debugger.

  {*********************** class TLMDScriptEventHandler ***********************}

  TLMDScriptEventHandler      = class;
  TLMDScriptEventHandlerClass = class of TLMDScriptEventHandler;

  TLMDScriptEventHandler = class
  private
    FOwner:    TLMDScriptControl;
    FProcName: TLMDString;
  public
    constructor Create(AOwner: TLMDScriptControl;
                       const AProcName: TLMDString); virtual;

    function GetHandler: TMethod; virtual; abstract;
    property Owner: TLMDScriptControl read FOwner;
    property ProcName: TLMDString read FProcName;
  end;

  {************************* class TLMDScriptControl **************************}

  ILMDNamedValuesHolder = interface
    ['{DB3038C2-6AF2-4688-8AD5-716B4337ED7C}']
    procedure AddOrSet(const AName: WideString; AValue: POleVariant);
  end;

  TLMDScriptControlState  = (ssInactive, ssPrepared, ssActive);
  TLMDScriptControlStates = set of TLMDScriptControlState;
  TLMDScriptLanguage      = (slVBScript, slJScript, slPerl, slRexx, slTCL,
                             slPython, slLua, slPascal, slNativeVb);
  TLMDScriptLangKind      = (slkActiveX, slkNative);

  TLMDScriptControl = class(TComponent, ILMDComponent)
  private
    FAbout:               TLMDAboutVar;
    FState:               TLMDScriptControlState;
    FRunner:              TObject;
    FCodeObject:          IDispatch;
    FNamedValuesHolder:   ILMDNamedValuesHolder;
    FNamedItems:          TLMDHashTable;
    FEventHandlers:       TList;
    FSource:              TLMDStrings;
    FDebugger:            TLMDScriptDebugger;
    FLanguage:            TLMDScriptLanguage;
    FExceptionSourceInfo: Boolean;
    FAfterClose:          TNotifyEvent;
    FBeforePrepare:       TNotifyEvent;
    FBeforeOpen:          TNotifyEvent;
    FDebugModule:         TLMDDebugModule;
    FLoadingDebugName:    TLMDString;

    procedure CheckState(AValidStates: TLMDScriptControlStates);
    procedure ValidateDebugger(ALanguage: TLMDScriptLanguage;
                               ADebugger: TLMDScriptDebugger);
    procedure SourceChanging;
    procedure DoAddNamedObject(const Name: TLMDString;
                               const AObj: IDispatch;
                               APublishMembers: Boolean);
    procedure DoAddOrSetNamedValue(const Name: TLMDString;
                                   const Value: OleVariant);
    function  InitNamedValuesHolder: ILMDNamedValuesHolder;
    function  GetCodeObject: IDispatch;
    function  GetScript: OleVariant;
    procedure SetLanguage(const Value: TLMDScriptLanguage);
    procedure SetSource(const Value: TLMDStrings);
    procedure SetDebugger(const Value: TLMDScriptDebugger);
    function  GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetExceptionSourceInfo(const Value: Boolean);
    function  GetDebugName: TLMDString;
    procedure SetDebugModule(const Value: TLMDDebugModule);
    procedure SetDebugName(const Value: TLMDString);
  protected
    { ILMDComponent }

    function  getLMDPackage: TLMDPackageID;
  protected
    procedure Loaded; override;
    procedure DoBeforePrepare; virtual;
    procedure DoBeforeOpen; virtual;
    procedure DoAfterClose; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Prepare;
    procedure Open(ACloseOnRuntimeError: Boolean = True);
    procedure Close(AClearObjects: Boolean = False;
                    AClearEventHandler: Boolean = True);

    procedure AddOrSetValue(const Name: TLMDString; const Value: OleVariant);
    function  TryReadValue(const Name: TLMDString;
                           out AResult: OleVariant): Boolean;
    procedure AddObject(const Name: TLMDString; const Obj: OleVariant;
                        APublishMembers: Boolean = False);
    procedure AddChildren(const AOwner: TComponent;
                          APublishMembers: Boolean = False);
    procedure AddUnit(AWrapperClass: TLMDUnitWrapperClass;
                      APublishMembers: Boolean = True);
    procedure AddUnits(AWrapperClasses: array of TLMDUnitWrapperClass;
                       APublishMembers: Boolean = True);
    procedure AddAllUnits(APublishMembers: Boolean = True);
    procedure RemoveObject(const AName: TLMDString);
    procedure ClearObjects;

    procedure ClearEventHandlers;
    function  GetEventHandler(const AProcName: TLMDString;
                              AEventType: TLMDEventWrapperClass): TLMDScriptEventHandler;
    procedure HookEvent(AInstance: TPersistent; APropInfo: TLMDPropInfo;
                        const AProcName: TLMDString); overload;
    procedure HookEvent(AInstance: TPersistent; const APropName,
                        AProcName: TLMDString); overload;

    function  GetUnitInstance(AWrapperClass: TLMDUnitWrapperClass): IDispatch;

    function  PrepareExpr(const AExpression: TLMDString): TObject;
    function  PrepareStmt(const AStatement: TLMDString): TObject;
    function  Eval(const AExpression: TLMDString): OleVariant; overload;
    function  Eval(APreparedExpr: TObject): OleVariant; overload;
    procedure ExecuteStatement(const AStatement: TLMDString); overload;
    procedure ExecuteStatement(APreparedStmt: TObject); overload;

    function  RunProc(const Name: TLMDString): OleVariant; overload;
    function  RunProc(const Name: TLMDString;
                      const Args: array of OleVariant): OleVariant; overload;
    function  ReadVar(const Name: TLMDString): OleVariant;
    procedure WriteVar(const Name: TLMDString; const Value: OleVariant);

    property State: TLMDScriptControlState read FState;
    property CodeObject: IDispatch read GetCodeObject;
    property Script: OleVariant read GetScript;
    property DebugModule: TLMDDebugModule read FDebugModule write SetDebugModule;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Active: Boolean read GetActive write SetActive default False;
    property Source: TLMDStrings read FSource write SetSource;
    property Debugger: TLMDScriptDebugger read FDebugger write SetDebugger;
    property DebugName: TLMDString read GetDebugName write SetDebugName;
    property Language: TLMDScriptLanguage read FLanguage write SetLanguage default slVBScript;
    property ExceptionSourceInfo: Boolean read FExceptionSourceInfo write SetExceptionSourceInfo default True;
    property BeforePrepare: TNotifyEvent read FBeforePrepare write FBeforePrepare;
    property BeforeOpen: TNotifyEvent read FBeforeOpen write FBeforeOpen;
    property AfterClose: TNotifyEvent read FAfterClose write FAfterClose;
  end;

  {************************* class TLMDDebugModule ****************************}

  TLMDDebugModule = class(TCollectionItem)
  private
    FName: TLMDString;

    procedure SetName(const Value: TLMDString);
    function  GetDebugger: TLMDScriptDebugger;
  public
    destructor Destroy; override;
    procedure  Assign(Source: TPersistent); override;
    procedure  Delete;
    property   Debugger: TLMDScriptDebugger read GetDebugger;
  published
    property Name: TLMDString read FName write SetName;
  end;

  TLMDDebugModules = class(TOwnedCollection)
  private
    function  GetItem(Index: Integer): TLMDDebugModule;
    procedure SetItem(Index: Integer; const Value: TLMDDebugModule);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    function Add: TLMDDebugModule;
    function FindItemID(ID: Integer): TLMDDebugModule;
    function FindByName(const AName: TLMDString): TLMDDebugModule;
    function FindOrAdd(const AName: TLMDString): TLMDDebugModule;
    function Insert(Index: Integer): TLMDDebugModule;
    property Items[Index: Integer]: TLMDDebugModule read GetItem write SetItem; default;
  end;

  {************************** class TLMDBreakpoint ****************************}

  TLMDBreakpoint      = class;
  TLMDBreakpointState = (bsNonactive, bsValid, bsInvalid);

  TLMDBreakpointAction = class
  private
    FBP:             TLMDBreakpoint;
    FBreak:          Boolean;
    FLogMessage:     TLMDString;
    FEvalExpression: TLMDString;
    FDisableGroup:   TLMDString;
    FEnableGroup:    TLMDString;
    FLogStackFrames: Integer;

    procedure SetBreak(const Value: Boolean);
    procedure SetLogMessage(const Value: TLMDString);
    procedure SetLogStackFrames(const Value: Integer);
    procedure SetEvalExpression(const Value: TLMDString);
    procedure SetEnableGroup(const Value: TLMDString);
    procedure SetDisableGroup(const Value: TLMDString);
  public
    constructor Create(ABP: TLMDBreakpoint);

    property Break: Boolean read FBreak write SetBreak;
    property LogMessage: TLMDString read FLogMessage write SetLogMessage;
    property LogStackFrames: Integer read FLogStackFrames write SetLogStackFrames;
    property EvalExpression: TLMDString read FEvalExpression write SetEvalExpression;
    property EnableGroup: TLMDString read FEnableGroup write SetEnableGroup;
    property DisableGroup: TLMDString read FDisableGroup write SetDisableGroup;
  end;

  TLMDBreakpoint = class
  private
    FDebugger:         TLMDScriptDebugger;
    FModule:           TLMDDebugModule;
    FLine:             Integer;
    FEnabled:          Boolean;
    FCondition:        TLMDString;
    FPassCount:        Integer;
    FCurrentPassCount: Integer;
    FGroup:            TLMDString;
    FAction:           TLMDBreakpointAction;
    FValid:            Boolean;
    FData:             TLMDDataTag;

    procedure InternalSetCrPassCount(AValue: Integer);
    function  GetState: TLMDBreakpointState;
    procedure SetEnabled(const Value: Boolean);
    procedure SetCondition(const Value: TLMDString);
    procedure SetPassCount(const Value: Integer);
    procedure SetGroup(const Value: TLMDString);
    function  GetIndex: Integer;
  public
    constructor Create(ADebugger: TLMDScriptDebugger;
                       AModule: TLMDDebugModule;
                       ALine: Integer); overload;
    destructor Destroy; override;

    procedure Delete;
    property  Debugger: TLMDScriptDebugger read FDebugger;
    property  Index: Integer read GetIndex;
    property  Module: TLMDDebugModule read FModule;
    property  Line: Integer read FLine;
    property  Enabled: Boolean read FEnabled write SetEnabled;
    property  Condition: TLMDString read FCondition write SetCondition;
    property  PassCount: Integer read FPassCount write SetPassCount;
    property  Group: TLMDString read FGroup write SetGroup;
    property  CurrentPassCount: Integer read FCurrentPassCount;
    property  Action: TLMDBreakpointAction read FAction;
    property  State: TLMDBreakpointState read GetState;
    property  Data: TLMDDataTag read FData write FData;
  end;

  {*************************** class TLMDVariables ****************************}

  TLMDVariableFlag  = (vfReadonly, vfPublic, vfPrivate, vfProtected, vfFinal,
                       vfGlobal, vfStatic, vfField, vfVirtual, vfConstant,
                       vfSynchronized, vfVolatile);
  TLMDVariableFlags = set of TLMDVariableFlag;

  TLMDVariable  = class;
  TLMDVariables = class
  private
    FChanged:     Boolean;
    FUpdateCount: Integer;
    FRoot:        TLMDVariable;
    FDebugger:    TLMDScriptDebugger;
    FOnChange:    TNotifyEvent;

    procedure InitProc(const ARunnerVar: IUnknown; const AName: TLMDString;
                       const AType: TLMDString; const AValue: TLMDString;
                       AFlags: TLMDVariableFlags; AExpandable: Boolean);
  protected
    procedure DoChange; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Changed; // Used by external UI controls to be
                       // consistent with BeginUpdate/EndUpdate.
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Clear;
    property  Root: TLMDVariable read FRoot;
    property  OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  {*************************** class TLMDVariable *****************************}

  TLMDVariable = class
  private
    FId:          Integer;
    FOwner:       TLMDVariables;
    FParent:      TLMDVariable;
    FItemsFilled: Boolean;
    FItems:       TList;
    FRunnerVar:   IUnknown;
    FValue:       TLMDString;
    FType_:       TLMDString;
    FName:        TLMDString;
    FFlags:       TLMDVariableFlags;
    FExpandable:  Boolean;

    function  GetCount: Integer;
    function  GetItems(AIndex: Integer): TLMDVariable;
    procedure AddItemProc(const ARunnerVar: IUnknown; const AName: TLMDString;
                          const AType: TLMDString; const AValue: TLMDString;
                          AFlags: TLMDVariableFlags; AExpandable: Boolean);
    procedure FillItems;
    procedure ClearItems;
    function  GetNextId: Integer;
  public
    constructor Create(AOwner: TLMDVariables; AParent: TLMDVariable;
                       const ARunnerVar: IUnknown; const AName: TLMDString;
                       const AType: TLMDString; const AValue: TLMDString;
                       AFlags: TLMDVariableFlags; AExpandable: Boolean);
    destructor Destroy; override;

    function IndexOfId(AId: Integer): Integer;

    property Id: Integer read FId; // Abstract autoincrement id for
                                   // some UI controls.
    property Name: TLMDString read FName;
    property Type_: TLMDString read FType_;
    property Value: TLMDString read FValue;
    property Flags: TLMDVariableFlags read FFlags;
    property Expandable: Boolean read FExpandable;
    property Parent: TLMDVariable read FParent;
    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TLMDVariable read GetItems; default;
  end;

  {************************** class TLMDStackFrame ****************************}

  TLMDStackFrame = class
  private
    FDebugger:       TLMDScriptDebugger;
    FRunnerFrame:    TObject;
    FOwnRunnerFrame: Boolean;
    FScriptControl:  TLMDScriptControl;
    FLine:           Integer;

    function GetIndex: Integer;
    function GetLongDescription: TLMDString;
    function GetShortDescription: TLMDString;
    function GetModule: TLMDDebugModule;
  public
    constructor Create(ADebugger: TLMDScriptDebugger; ARunnerFrame: TObject;
                       AOwnRunnerFrame: Boolean; AScriptControl: TLMDScriptControl;
                       ALine: Integer);
    destructor Destroy; override;

    procedure Eval(const AExpression: TLMDString; AResult: TLMDVariables); overload;
    function  Eval(const AExpression: TLMDString): TLMDString; overload;
    procedure GetVariables(AResult: TLMDVariables);

    property Index: Integer read GetIndex;
    property ScriptControl: TLMDScriptControl read FScriptControl;
    property Module: TLMDDebugModule read GetModule;
    property Line: Integer read FLine;
    property LongDescription: TLMDString read GetLongDescription;
    property ShortDescription: TLMDString read GetShortDescription;
  end;

  {************************ class TLMDScriptDebugger **************************}

  TLMDBreakKind       = (bkNone, bkBreakpoint, bkStep, bkCausedBreak);
  TLMDBreakResumeKind = (rkStepOver, rkStepInto, rkContinue, rkAbort);
  TLMDDebugMsgKind    = (dmDebuggerOutput, dmBreakpointReached, dmLogMessage,
                         dmEvalExpr, dmLogStackHeader, dmLogStackFrame);
  TLMDDebugMsgKinds   = set of TLMDDebugMsgKind;
  TLMDAdjustBPKind    = (abkSet, abkRemove, abkCorrectLine);

  ILMDScriptDebuggerNotifier = class // Can be used in services.
  public
    procedure Breaked(ADebugger: TLMDScriptDebugger); virtual; abstract;
    procedure Resumed(ADebugger: TLMDScriptDebugger); virtual; abstract;
    procedure DebugNameChanged(ADebugger: TLMDScriptDebugger;
                               AScript: TLMDScriptControl); virtual; abstract;
    procedure LogMessage(ADebugger: TLMDScriptDebugger; const AMsg: TLMDString;
                         AKind: TLMDDebugMsgKind); virtual; abstract;
    procedure BreakpointsChanged(ADebugger: TLMDScriptDebugger); virtual; abstract;
  end;

  TLMDBreakEvent = procedure(Sender: TObject; AScriptControl: TLMDScriptControl;
                             ALine: Integer) of object;
  TLMDInvalidBreakpointEvent = procedure(Sender: TObject;
                                         ABreakpoint: TLMDBreakpoint) of object;
  TLMDFormatDebugMsgEvent = procedure(Sender: TObject; AMsgKind: TLMDDebugMsgKind;
                                      BP: TLMDBreakpoint; const S: TLMDString;
                                      AFRame: TLMDStackFrame;
                                      var AMsg: TLMDString) of object;
  TLMDLogMessageEvent = procedure(Sender: TObject; AKind: TLMDDebugMsgKind;
                                  const AMsg: TLMDString) of object;

  TLMDScriptDebugger = class(TComponent, ILMDComponent)
  private
    FAbout:                TLMDAboutVar;
    FModules:              TLMDDebugModules;
    FServiceProvider:      TLMDServiceProvider;
    FScripts:              TList;
    FBreakpoints:          TList;
    FRunnerDebug:          TObject;
    FBreakKind:            TLMDBreakKind;
    FLoggingStack:         Boolean;
    FStackFrames:          TList; // Lazy inited to prevent exceptions
                                  // in OnHandleBreakpoint COM event.
    FIsSynchBreaks:        Boolean;
    FNotifiers:            TList;
    FOnBreak:              TLMDBreakEvent;
    FOnResume:             TNotifyEvent;
    FOnInvalidBreakpoint:  TLMDInvalidBreakpointEvent;
    FOnFormatDebugMsg:     TLMDFormatDebugMsgEvent;
    FOnLogMessage:         TLMDLogMessageEvent;
    FOnBreakpointsChanged: TNotifyEvent;

    procedure InsertScriptItem(AItem: TLMDScriptControl);
    procedure RemoveScriptItem(AItem: TLMDScriptControl);
    procedure ScriptItemLangChanged(AItem: TLMDScriptControl);
    procedure DisconnectScripts;
    procedure AdjustRunnerDebug;
    procedure ModuleDeleting(AModule: TLMDDebugModule);
    procedure ScriptDebugModuleChanged(AItem: TLMDScriptControl);
    procedure LogDebugMsg(AKind: TLMDDebugMsgKind; BP: TLMDBreakpoint;
                          const S: TLMDString = ''; AFrame: TLMDStackFrame = nil);
    procedure InsertBreakpointItem(AItem: TLMDBreakpoint);
    procedure RemoveBreakpointItem(AItem: TLMDBreakpoint);
    function  GetBreakpointCount: Integer;
    function  GetBreakpoints(AIndex: Integer): TLMDBreakpoint;
    procedure SetBreakpointGroupEnabled(const AGroup: TLMDString;
                                        AValue: Boolean);
    procedure AdjustBreakpoint(BP: TLMDBreakpoint; AAdjustKind: TLMDAdjustBPKind;
                               AOldLine: Integer = -1);
    procedure AddStackFrameProc(ARunnerFrame: TObject; AOwnRunnerFrame: Boolean;
                                AScriptControl: TLMDScriptControl; ALine: Integer);
    procedure UpdateStackFrames;
    procedure ClearStackFrames;
    procedure HandleBreak(ABreakKind: TLMDBreakKind; AScript: TLMDScriptControl;
                          ALine: Integer);
    procedure CheckInBerak;
    function  GetStackFrameCount: Integer;
    function  GetStackFrames(AIndex: Integer): TLMDStackFrame;
    procedure SetIsSynchBreaks(const Value: Boolean);
    procedure SetServiceProvider(const Value: TLMDServiceProvider);
    procedure SetModules(const Value: TLMDDebugModules);
  protected
    { ILMDComponent }

    function  getLMDPackage: TLMDPackageID;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure DoBreakpoint(AScriptControl: TLMDScriptControl;
                           ALine: Integer); virtual;
    procedure DoResume; virtual;
    procedure DoInvalidBreakpoint(ABreakpoint: TLMDBreakpoint); virtual;
    procedure DoFormatDebugMsg(AMsgKind: TLMDDebugMsgKind;
                               BP: TLMDBreakpoint; const S: TLMDString;
                               AFrame: TLMDStackFrame;
                               var AMsg: TLMDString); virtual;
    procedure DoLogMessage(AKind: TLMDDebugMsgKind;
                           const AMsg: TLMDString); virtual;
    procedure DoBreakpointsChanged; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ResetBreakpointsState;
    function  FindBreakpoint(AModule: TLMDDebugModule;
                             ALine: Integer): TLMDBreakpoint; overload;
    function  SetBreakpoint(AModule: TLMDDebugModule;
                            ALine: Integer): TLMDBreakpoint; overload;
    procedure MoveBreakpoints(const ABreakpoints: array of TLMDBreakpoint;
                              const ANewLines: array of Integer);
    procedure EnableGroup(const AGroup: TLMDString);
    procedure DisableGroup(const AGroup: TLMDString);
    procedure ClearBreakpoints; overload;
    procedure ClearBreakpoints(AModule: TLMDDebugModule); overload;
    procedure CauseBreak;

    procedure ResumeFromBreak(AKind: TLMDBreakResumeKind);

    procedure AddNotifier(ANotifier: ILMDScriptDebuggerNotifier);
    procedure RemoveNotifier(ANotifier: ILMDScriptDebuggerNotifier);

    property BreakpointCount: Integer read GetBreakpointCount;
    property Breakpoints[AIndex: Integer]: TLMDBreakpoint read GetBreakpoints;

    property BreakKind: TLMDBreakKind read FBreakKind;
    property StackFrameCount: Integer read GetStackFrameCount;
    property StackFrames[AIndex: Integer]: TLMDStackFrame read GetStackFrames;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Modules: TLMDDebugModules read FModules write SetModules;
    property IsSynchBreaks: Boolean read FIsSynchBreaks write SetIsSynchBreaks default False;
    property ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
    property OnBreak: TLMDBreakEvent read FOnBreak write FOnBreak;
    property OnResume: TNotifyEvent read FOnResume write FOnResume;
    property OnInvalidBreakpoint: TLMDInvalidBreakpointEvent read FOnInvalidBreakpoint write FOnInvalidBreakpoint;
    property OnFormatDebugMsg: TLMDFormatDebugMsgEvent read FOnFormatDebugMsg write FOnFormatDebugMsg;
    property OnLogMessage: TLMDLogMessageEvent read FOnLogMessage write FOnLogMessage;
    property OnBreakpointsChanged: TNotifyEvent read FOnBreakpointsChanged write FOnBreakpointsChanged;
  end;

const
  LMDScriptLangKinds: array[TLMDScriptLanguage] of TLMDScriptLangKind =
  (
    slkActiveX, slkActiveX, slkActiveX, slkActiveX,
    slkActiveX, slkActiveX, slkActiveX, slkNative, slkNative
  );
  LMDAllStackFrames = MaxInt;
  LMDAllMsgKinds    = [Low(TLMDDebugMsgKind)..High(TLMDDebugMsgKind)];

function  LMDScriptLangToStr(ALanguage: TLMDScriptLanguage): TLMDString;
function  LMDStrToScriptLang(const S: TLMDString): TLMDScriptLanguage;
function  LMDHasErrorMessageInfo(const AMsg: WideString): Boolean;
procedure LMDEncodeErrorMessageInfo(ASource: TObject; ALine, APos: Integer;
                                    var AMsg: WideString);
function  LMDDecodeErrorMessageInfo(const AMsg: WideString;
                                    out AOriginalMsg: WideString;
                                    out ASource: TLMDScriptControl;
                                    out ALine, APos: Integer): Boolean;

implementation

uses
  Forms, SyncObjs, Dialogs, LMDSctMSScriptTLB, LMDSctCst, LMDSctSysWrappers,
  LMDSctVMCompBase, LMDSctPasCompiler, LMDSctVbCompiler, LMDSctVM;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

type
  {*********************************** Common *********************************}

  TNamedItemKind = (nikObject, nikValue);

  TNamedItem = class
  public
    Kind:        TNamedItemKind;
    UppName:     WideString;
    Name:        WideString;
    Value:       OleVariant;
    PubMembers:  Boolean;
  end;

  TNamedItemsTraits = class(TLMDHashTableTraits)
  public
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

  { -------------------------------------------------------------------------- }

  TNamedValuesHolderItem = class
  public
    UppName: WideString;
    DispId:  Integer;
    Value:   POleVariant;
  end;

  TNamedValuesHolderMapTraits = class(TLMDHashTableTraits)
  public
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

  TNamedValuesHolder = class(TInterfacedObject, IDispatch,
                             ILMDNamedValuesHolder)
  private
    FNameMap:     TLMDHashTable;
    FDispIdIndex: TList;
  protected
    { IDispatch }

    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer;
                         out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
                           LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
                    Flags: Word; var Params; VarResult, ExcepInfo,
                    ArgErr: Pointer): HResult; stdcall;

    { ILMDNamedValuesHolder }

    procedure AddOrSet(const AName: WideString; AValue: POleVariant);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  { -------------------------------------------------------------------------- }

  TScriptSourceStrings = class(TLMDMemoryStrings)
  private
    FScript: TLMDScriptControl;
  protected
    procedure Changing; override;
  public
    constructor Create(AScript: TLMDScriptControl);
  end;

  { -------------------------------------------------------------------------- }

  TRunnerDebugBase = class;
  TRunnerBase      = class
  public
    function  GetLangKind: TLMDScriptLangKind; virtual; abstract;
    procedure Prepare(ADebugger: TRunnerDebugBase); virtual; abstract;
    procedure Open; virtual; abstract;
    procedure Close; virtual; abstract;
    procedure AddNamedObjectsToEngine(ACtrl: TLMDScriptControl);
    procedure AddNamedObjectToEngine(AItem: TNamedItem); virtual; abstract;
    function  RunProc(const Name: TLMDString): OleVariant; overload; virtual; abstract;
    function  RunProc(const Name: TLMDString;
                      const Args: array of OleVariant): OleVariant; overload; virtual; abstract;
    function  ReadVar(const Name: TLMDString): OleVariant; virtual; abstract;
    procedure WriteVar(const Name: TLMDString; const Value: OleVariant); virtual; abstract;
    function  PrepareExpr(const AExpr: WideString): TObject; virtual; abstract;
    function  PrepareStmt(const AStmt: WideString): TObject; virtual; abstract;
    function  Eval(APreparedExpr: TObject): OleVariant; overload; virtual; abstract;
    function  Eval(const AExpr: WideString): OleVariant; overload; virtual; abstract;
    procedure ExecStmt(APreparedStmt: TObject); overload; virtual; abstract;
    procedure ExecStmt(const AStmt: WideString); overload; virtual; abstract;
    function  GetCodeObject: IDispatch; virtual; abstract;
    procedure SetBreakpoints(ACtrl: TLMDScriptControl;
                             ADebugger: TLMDScriptDebugger);
    procedure AdjustBreakpoint(ALine: Integer; AEnabled, ADelete: Boolean;
                               out AIsValid: Boolean); virtual; abstract;
  end;
             
  { -------------------------------------------------------------------------- }

  TVarProc      = procedure(const ARunnerVar: IUnknown; const AName: TLMDString;
                            const AType: TLMDString; const AValue: TLMDString;
                            AFlags: TLMDVariableFlags; AExpandable: Boolean) of object;
  TGetFrameProc = procedure(ARunnerFrame: TObject; AOwnRunnerFrame: Boolean;
                            AScriptControl: TLMDScriptControl;
                            ALine: Integer) of object;

  TRunnerDebugBase = class
  public
    function  GetLangKind: TLMDScriptLangKind; virtual; abstract;
    procedure CauseBreak; virtual; abstract;
    procedure GetStackFrames(AProc: TGetFrameProc); virtual; abstract;
    procedure Eval(ARunnerFrame: TObject; const AExpr: TLMDString;
                   AProc: TVarProc); overload; virtual; abstract;
    function  Eval(ARunnerFrame: TObject;
                   const AExpr: TLMDString): TLMDString; overload; virtual; abstract;
    procedure GetVars(ARunnerFrame: TObject; AProc: TVarProc); virtual; abstract;
    procedure GetVarChildren(const ARunnerVar: IUnknown; AProc: TVarProc); virtual; abstract;
    function  GetLongDescription(ARunnerFrame: TObject): TLMDString; virtual; abstract;
    function  GetShortDescription(ARunnerFrame: TObject): TLMDString; virtual; abstract;
    procedure ResumeFromBreak(AKind: TLMDBreakResumeKind); virtual; abstract;
  end;

  {****************************** TActiveXRunner ******************************}

  TActiveXRunner      = class;
  TActiveXRunnerDebug = class;
  TAXAppDebugger      = class;

  TAXConditionConverter = class(TInterfacedObject, IDispatch)
  protected
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer;
                         out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
                           NameCount, LocaleID: Integer;
                           DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
                    Flags: Word; var Params; VarResult, ExcepInfo,
                    ArgErr: Pointer): HResult; stdcall;
  end;

  TAXSite = class(TInterfacedObject, IActiveScriptSite,
                  IActiveScriptSiteWindow, IActiveScriptSiteDebug)
  private
    FRunner:   TActiveXRunner;
    FCondCvtr: TAXConditionConverter;
  protected
    { IActiveScriptSite }

    procedure GetLCID(out plcid: LongWord); safecall;
    procedure GetItemInfo(pstrName: PWideChar;
                          dwReturnMask: LongWord;
                          out ppiunkItem: IUnknown;
                          out ppti: IUnknown); safecall;
    procedure GetDocVersionString(out pbstrVersion: WideString); safecall;
    procedure OnScriptTerminate(var pVarResult: OleVariant; var pexcepinfo: tagEXCEPINFO); safecall;
    procedure OnStateChange(ssScriptState: tagSCRIPTSTATE); safecall;
    procedure OnScriptError(const pscripterror: IActiveScriptError); safecall;
    procedure OnEnterScript; safecall;
    procedure OnLeaveScript; safecall;

    { IActiveScriptSiteWindow }

    procedure GetWindow(out phwnd: wireHWND); safecall;
    procedure EnableModeless(fEnable: Integer); safecall;

    { IActiveScriptSiteDebug }

    procedure GetDocumentContextFromPosition(dwSourceContext: LongWord;
                                             uCharacterOffset: LongWord;
                                             uNumChars: LongWord;
                                             out ppsc: IDebugDocumentContext); safecall;
    procedure GetApplication(out ppda: IDebugApplication); safecall;
    procedure GetRootApplicationNode(out ppdanRoot: IDebugApplicationNode); safecall;
    procedure OnScriptErrorDebug(const pErrorDebug: IActiveScriptErrorDebug;
                                 out pfEnterDebugger: Integer;
                                 out pfCallOnScriptErrorWhenContinuing: Integer); safecall;
  public
    constructor Create(ARunner: TActiveXRunner);
    destructor Destroy; override;
  end;

  { -------------------------------------------------------------------------- }

  TAXRunnerFrame = class
  public
    Data: tagDebugStackFrameDescriptor;
  end;
             
  { -------------------------------------------------------------------------- }

  TAXExprCallBack = class(TObject, IDebugExpressionCallBack)
  private
    FEvent: TEvent;
  protected
    { IUnknown }

    function QueryInterface(const IID: TGUID; out Obj): HRESULT; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    { IDebugExpressionCallBack }

    procedure OnComplete; safecall;
  public
    constructor Create;
    destructor  Destroy; override;
    procedure   WaitFor;
  end;

  { -------------------------------------------------------------------------- }

  TAXBreakThread = class(TThread)
  private
    FOwner:       TAXAppDebugger;
    FThread:      IRemoteDebugApplicationThread;
    FBreakKind:   TLMDBreakKind;
    FScript:      TLMDScriptControl;
    FLine:        Integer;
    FBreakpoint:  TLMDBreakpoint;
  protected
    procedure Execute; override;
  public
    constructor Create(AOwner: TAXAppDebugger;
                       const AThread: IRemoteDebugApplicationThread;
                       ABreakKind: TLMDBreakKind; AScript: TLMDScriptControl;
                       ALine: Integer; ABreakpoint: TLMDBreakpoint);
  end;

  { -------------------------------------------------------------------------- }

  TAXAppDebugger = class(TInterfacedObject, IApplicationDebugger,
                         IDebugSessionProvider)
  private
    FRunnerDebug: TActiveXRunnerDebug;

    procedure DoHandleBreak(const AThread: IRemoteDebugApplicationThread;
                            ABreakKind: TLMDBreakKind; AScript: TLMDScriptControl;
                            ALine: Integer; BP: TLMDBreakpoint);
  protected
    { IApplicationDebugger }

    procedure QueryAlive; safecall;
    procedure CreateInstanceAtDebugger(var rclsid: TGUID; const pUnkOuter: IUnknown;
                                       dwClsContext: LongWord; var riid: TGUID;
                                       out ppvObject: IUnknown); safecall;
    procedure onDebugOutput(pstr: PWideChar); safecall;
    procedure onHandleBreakPoint(const prpt: IRemoteDebugApplicationThread;
                                 br: tagBREAKREASON;
                                 const pError: IActiveScriptErrorDebug); safecall;
    procedure onClose; safecall;
    procedure onDebuggerEvent(var riid: TGUID; const punk: IUnknown); safecall;

    { IDebugSessionProvider }

    procedure StartDebugSession(const pda: IRemoteDebugApplication); safecall;
  public
    constructor Create(ARunnerDebug: TActiveXRunnerDebug);
  end;
    
  { -------------------------------------------------------------------------- }

  TAXScriptErrorHolder = class // Ref-counted class.
  private
    FRefCount:   Integer;
    FLastError:  IActiveScriptError;
    FAddSrcInfo: Boolean;
    FSource:     TObject;
  public
    constructor Create(AAddSrcInfo: Boolean; ASource: TObject);

    function  AddRef: TAXScriptErrorHolder;
    procedure Release;
    procedure SetError(AError: IActiveScriptError);
    procedure ClearScriptError;
    procedure FormatScriptError(var AMsg: WideString);
    procedure CheckScriptError;
  end;

  { -------------------------------------------------------------------------- }

  TAXCodeObject = class(TInterfacedObject, IDispatch)
  private
    FErrorHolder: TAXScriptErrorHolder;
    FOrigin:      IDispatch;
  protected
    { IDispatch }

    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
                           NameCount, LocaleID: Integer;
                           DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
                    Flags: Word; var Params; VarResult, ExcepInfo,
                    ArgErr: Pointer): HResult; stdcall;
  public
    constructor Create(AErrorHolder: TAXScriptErrorHolder; AOrigin: IDispatch);
    destructor Destroy; override;
  end;

  { -------------------------------------------------------------------------- }

  TAXDynCode = class
  private
    FText: WideString;
  public
    constructor Create(AText: WideString);
  end;

  { -------------------------------------------------------------------------- }

  TActiveXRunner = class(TRunnerBase)
  private
    FSControl:       TLMDScriptControl;
    FAddSrcInfo:     Boolean;
    FSite:           TAXSite;
    FRunnerDebug:    TActiveXRunnerDebug;
    FAppDebugger:    TAXAppDebugger;
    FHelper:         CDebugDocumentHelper;
    FScript:         IActiveScript;
    FScriptParse:    IActiveScriptParse;
    FSourceContext:  DWORD;
    FErrorHolder:    TAXScriptErrorHolder;
    FCodeObject:     TAXCodeObject;

    procedure DefineDebugDocBlock(const ASource: WideString;
                                  out ASourceContext: DWORD);
    function  GetDebugDocBlock: IDebugApplicationNode;
    procedure GetSourceLineMetrix(ALine: Integer; out APos, ALength: Integer);
  public
    constructor Create(ASControl: TLMDScriptControl; AAddSrcInfo: Boolean);
    destructor Destroy; override;

    function  GetLangKind: TLMDScriptLangKind; override;
    procedure Prepare(ARunnerDebug: TRunnerDebugBase); override;
    procedure Open; override;
    procedure Close; override;
    procedure AddNamedObjectToEngine(AItem: TNamedItem); override;
    function  RunProc(const Name: TLMDString): OleVariant; overload; override;
    function  RunProc(const Name: TLMDString;
                      const Args: array of OleVariant): OleVariant; overload; override;
    function  ReadVar(const Name: TLMDString): OleVariant; override;
    procedure WriteVar(const Name: TLMDString; const Value: OleVariant); override;
    function  PrepareExpr(const AExpr: WideString): TObject; override;
    function  PrepareStmt(const AStmt: WideString): TObject; override;
    function  Eval(APreparedExpr: TObject): OleVariant; overload; override;
    function  Eval(const AExpr: WideString): OleVariant; overload; override;
    procedure ExecStmt(APreparedStmt: TObject); overload; override;
    procedure ExecStmt(const AStmt: WideString); overload; override;
    function  GetCodeObject: IDispatch; override;
    procedure AdjustBreakpoint(ALine: Integer; AEnabled, ADelete: Boolean;
                               out AIsValid: Boolean); override;
  end;
                   
  { -------------------------------------------------------------------------- }

  TActiveXRunnerDebug = class(TRunnerDebugBase)
  private
    FDebugger:    TLMDScriptDebugger;
    FAppDebugger: TAXAppDebugger;
    FApplication: IDebugApplication;
    FBreakThread: IRemoteDebugApplicationThread;

    procedure Init;
    procedure Fin;
    function  FindScriptControl(const ADocument: IDebugDocument): TLMDScriptControl;

    procedure FillVar(const AProp: IDebugProperty; AProc: TVarProc);
    function  DoEval(AFrame: IDebugStackFrame;
                     const AExpression: WideString): IDebugExpression;
  public
    constructor Create(ADebugger: TLMDScriptDebugger);
    destructor Destroy; override;

    function  GetLangKind: TLMDScriptLangKind; override;
    procedure CauseBreak; override;
    procedure GetStackFrames(AProc: TGetFrameProc); override;
    procedure Eval(ARunnerFrame: TObject; const AExpr: TLMDString;
                   AProc: TVarProc); override;
    function  Eval(ARunnerFrame: TObject;
                   const AExpr: TLMDString): TLMDString; override;
    procedure GetVars(ARunnerFrame: TObject; AProc: TVarProc); override;
    procedure GetVarChildren(const ARunnerVar: IUnknown; AProc: TVarProc); override;
    function  GetLongDescription(ARunnerFrame: TObject): TLMDString; override;
    function  GetShortDescription(ARunnerFrame: TObject): TLMDString; override;
    procedure ResumeFromBreak(AKind: TLMDBreakResumeKind); override;
  end;

  {******************************* TNativeRunner ******************************}

  TNativeRunnerDebug      = class;
  TNativeBreakpointThread = class(TThread)
  private
    FRunnerDebug:   TNativeRunnerDebug;
    FCallStack:     TLMDPasStackFrames;
    FBreakKind:     TLMDBreakKind;
    FScriptControl: TLMDScriptControl;
    FLine:          Integer;
    FBP:            TLMDBreakpoint;
  protected
    procedure Execute; override;
  public
    constructor Create(ARunnerDebug: TNativeRunnerDebug;
                       ACallStack: TLMDPasStackFrames; ABreakKind: TLMDBreakKind;
                       AScriptControl: TLMDScriptControl; ALine: Integer;
                       BP: TLMDBreakpoint);
  end;

  { -------------------------------------------------------------------------- }

  TNativeBreakTask = (btResume, btGetVars, btEval);

  PNativeBreakData = ^TNativeBreakData;
  TNativeBreakData = record
    CallStack:   TLMDPasStackFrames;
    TaskEvent:   TEvent;
    Task:        TNativeBreakTask;
    Complition:  TEvent;
    ResumeKind:  TLMVMDResumeKind;
    EvalFrame:   TLMDPasStackFrame;
    EvalExpr:    TLMDString;
    EvalRes:     TLMDPasDebugVar;
  end;
        
  { -------------------------------------------------------------------------- }

  TNativeRunner = class(TRunnerBase)
  private
    FSControl:    TLMDScriptControl;
    FAddSrcInfo:  Boolean;
    FVM:          TLMDVirtMachine;
    FRunnerDebug: TNativeRunnerDebug;
    FPasDebugger: TLMDVMDebugger;

    procedure IsTestProc(Sender: TObject; const AObj, AType: OleVariant;
                         var AResult: Boolean);
    procedure ExcIsTestProc(Sender: TObject; E: Exception;
                            AType: OleVariant; var AResult: Boolean);
    procedure VarToExcProc(Sender: TObject; const V: OleVariant;
                           var E: Exception);
    procedure ExcToVarProc(Sender: TObject; const E: Exception;
                           var V: OleVariant);
    procedure FormatExcProc(Sender: TObject; ALine, ALinePos: Integer;
                            const E: Exception);
    procedure EventMakeProc(Sender: TObject; const AProcName: WideString;
                            var V: OleVariant);
    procedure New(Sender: TObject; const AType: OleVariant;
                  AArgs: PLMDVarArray; AArgCount: Integer;
                  var AResult: OleVariant);
  public
    constructor Create(ASControl: TLMDScriptControl; AAddSrcInfo: Boolean);
    destructor Destroy; override;

    function  GetLangKind: TLMDScriptLangKind; override;
    procedure Prepare(ARunnerDebug: TRunnerDebugBase); override;
    procedure Open; override;
    procedure Close; override;
    procedure AddNamedObjectToEngine(AItem: TNamedItem); override;
    function  RunProc(const Name: TLMDString): OleVariant; overload; override;
    function  RunProc(const Name: TLMDString;
                      const Args: array of OleVariant): OleVariant; overload; override;
    function  ReadVar(const Name: TLMDString): OleVariant; override;
    procedure WriteVar(const Name: TLMDString; const Value: OleVariant); override;
    function  PrepareExpr(const AExpr: WideString): TObject; override;
    function  PrepareStmt(const AStmt: WideString): TObject; override;
    function  Eval(APreparedExpr: TObject): OleVariant; overload; override;
    function  Eval(const AExpr: WideString): OleVariant; overload; override;
    procedure ExecStmt(APreparedStmt: TObject); overload; override;
    procedure ExecStmt(const AStmt: WideString); overload; override;
    function  GetCodeObject: IDispatch; override;
    procedure AdjustBreakpoint(ALine: Integer; AEnabled, ADelete: Boolean;
                               out AIsValid: Boolean); override;
  end;

  TNativeRunnerTaskRes = (trOk, trResume);

  TNativeRunnerDebug = class(TRunnerDebugBase)
  private
    FDebugger:    TLMDScriptDebugger;
    FPasDebugger: TLMDVMDebugger;
    FBreakData:   PNativeBreakData;

    function  IsSynchBreaks: Boolean;
    function  FindScriptControl(AVM: TLMDVirtMachine): TLMDScriptControl;
    function  ExecBreakTask: TNativeRunnerTaskRes;
    procedure DoHandleBreak(ACallStack: TLMDPasStackFrames;
                            ABreakKind: TLMDBreakKind;
                            AScript: TLMDScriptControl;
                            ALine: Integer; BP: TLMDBreakpoint);
    procedure DebuggerBreak(Sender: TObject; ABreakKind: TLMDVMBreakKind;
                            AVM: TLMDVirtMachine; ALine: Integer;
                            ACallStack: TLMDPasStackFrames;
                            var AResumeKind: TLMVMDResumeKind);
    procedure FillVar(const AVar: TLMDPasDebugVar; AProc: TVarProc);
    procedure VarChildProc(const AVariable: TLMDPasDebugVar;
                           ACookie: Pointer; var AStop: Boolean);
  public
    constructor Create(ADebugger: TLMDScriptDebugger);
    destructor Destroy; override;

    function  GetLangKind: TLMDScriptLangKind; override;
    procedure CauseBreak; override;
    procedure GetStackFrames(AProc: TGetFrameProc); override;
    procedure Eval(ARunnerFrame: TObject; const AExpr: TLMDString;
                   AProc: TVarProc); override;
    function  Eval(ARunnerFrame: TObject;
                   const AExpr: TLMDString): TLMDString; override;
    procedure GetVars(ARunnerFrame: TObject; AProc: TVarProc); override;
    procedure GetVarChildren(const ARunnerVar: IUnknown; AProc: TVarProc); override;
    function  GetLongDescription(ARunnerFrame: TObject): TLMDString; override;
    function  GetShortDescription(ARunnerFrame: TObject): TLMDString; override;
    procedure ResumeFromBreak(AKind: TLMDBreakResumeKind); override;
  end;

{ ---------------------------------------------------------------------------- }

const
  ConditionCvtrName: WideString = 'LMDCONDCVTR_946F_D2188D24F6F9';
  ConditionCvtrRes:  WideString = 'LMDCONDCVTR_TRUE';
  ValuesHolderName:  WideString = 'LMDVALHLDR_AC3E_247A909A71EC';

  SExcFmt = '%s'#13#10'Source: $%x [line: %d, pos: %d]'; // Do not change. Msg
                                                         // parsing functions should
                                                         // be changed accordingly.

  EngineProdIDs: array [TLMDScriptLanguage] of WideString = (
    'VBScript',           // slVBScript
    'JScript',            // slJScript
    'PerlScript',         // slPerl
    'ObjectREXXScript',   // slRexx
    'TclScript',          // slTCL
    'Python',             // slPython
    'LuaScript',          // slLua
    'Pascal',             // slPascal
    'NativeVb'            // slNativeVb
  );

var
  NextVarId:        Integer = 1;
  PDMVar:           IProcessDebugManager; // Lazy inited, use GetPDM function.
  PDMLock:          TCriticalSection;     //
  SourceList:       TList;                // List of script controls.

{ ---------------------------------------------------------------------------- }

procedure LMDOleCheck(Code: HRESULT; AIDEIgnore: Boolean = False;
  AMsg: TLMDString = '');
begin
  if Code < 0 then
  begin
    if AIDEIgnore then
      raise TLMDCOMExceptionIgnore.Create(AMsg, Code, -1)
    else
      raise EOleSysError.Create(AMsg, Code, -1);
  end;
end;
                             
{ ---------------------------------------------------------------------------- }

function LMDScriptLangToStr(ALanguage: TLMDScriptLanguage): TLMDString;
begin
  Result := EngineProdIDs[ALanguage];
end;

{ ---------------------------------------------------------------------------- }

function LMDStrToScriptLang(const S: TLMDString): TLMDScriptLanguage;
var
  i: TLMDScriptLanguage;
begin
  for i := Low(TLMDScriptLanguage) to High(TLMDScriptLanguage) do
    if LMDSameText(S, EngineProdIDs[i]) then
    begin
      Result := i;
      Exit;
    end;

  raise ELMDScriptControl.Create('Invalid script language name.');
end;

{ ---------------------------------------------------------------------------- }

function LMDHasErrorMessageInfo(const AMsg: WideString): Boolean;
var
  len:     Integer;
  c, boff: PWideChar;
begin
  // Should be as fast as possible.

  Result := False;
  len    := Length(AMsg);
  if len = 0 then
    Exit;

  c    := @AMsg[len];
  boff := c - len;

  while (c <> boff) and (c^ <> '[') do
    Dec(c);

  // Here we does not check for the eoff, because the string
  // always ended with #0 and this will not be equal to any
  // specified char.

  Result := (c <> boff) and (c[1] = 'l') and
            (c[2] = 'i') and (c[3] = 'n') and
            (c[4] = 'e') and (c[5] = ':');
end;

{ ---------------------------------------------------------------------------- }

procedure LMDEncodeErrorMessageInfo(ASource: TObject; ALine, APos: Integer;
  var AMsg: WideString);
begin
  if not LMDHasErrorMessageInfo(AMsg) then
    AMsg := Format(SExcFmt, [AMsg, TLMDPtrInt(ASource), ALine, APos]);
end;

{ ---------------------------------------------------------------------------- }

function LMDDecodeErrorMessageInfo(const AMsg: WideString;
  out AOriginalMsg: WideString; out ASource: TLMDScriptControl;
  out ALine, APos: Integer): Boolean;
label
  LError;
var
  len, ln, ps:   Integer;
  src:           TObject;
  valcd:         Integer;
  c, tend, boff: PWideChar;
  s:             WideString;

  procedure _SkipBlanks;
  begin
    while (c <> boff) and (Ord(c^) <= 255) and
          (AnsiChar(c^) in [' ', #13, #10]) do
      Dec(c);
  end;
begin
  if not LMDHasErrorMessageInfo(AMsg) then
    goto LError;

  len  := Length(AMsg);
  c    := @AMsg[len];
  boff := c - len;

  { Skip ']' }

  while (c <> boff) and (c^ <> ']') do
    Dec(c);
  if c = boff then
    goto LError;
  Dec(c);

  { Parse pos number }

  _SkipBlanks;
  tend := c;
  while (c <> boff) and (Ord(c^) <= 255) and
        (AnsiChar(c^) in ['0'..'9', '-']) do
    Dec(c);

  SetString(s, c + 1, tend - c);
  Val(s, ps, valcd);
  if valcd <> 0 then
    goto LError;

  { Skip 'pos:' }

  _SkipBlanks;
  if not ((c - 3 > boff) and (c^ = ':') and ((c - 1)^ = 's') and
          ((c - 2)^ = 'o') and ((c - 3)^ = 'p')) then
    goto LError;
  Dec(c, 4);

  { Skip ',' }

  _SkipBlanks;
  if not ((c <> boff) and (c^ = ',')) then
    goto LError;
  Dec(c);

  { Parse line number }

  _SkipBlanks;
  tend := c;
  while (c <> boff) and (Ord(c^) <= 255) and
        (AnsiChar(c^) in ['0'..'9', '-']) do
    Dec(c);

  SetString(s, c + 1, tend - c);
  Val(s, ln, valcd);
  if valcd <> 0 then
    goto LError;

  { Skip 'line:' }

  _SkipBlanks;
  if not ((c - 4 > boff) and (c^ = ':') and ((c - 1)^ = 'e') and
          ((c - 2)^ = 'n') and ((c - 3)^ = 'i') and ((c - 4)^ = 'l')) then
    goto LError;
  Dec(c, 5);

  { Skip '[' }

  _SkipBlanks;
  if not ((c <> boff) and (c^ = '[')) then
    goto LError;
  Dec(c);

  { Parse source }

  _SkipBlanks;
  tend := c;
  while (c <> boff) and (Ord(c^) <= 255) and
        (AnsiChar(c^) in ['0'..'9', 'a'..'f', 'A'..'F', '$']) do
    Dec(c);

  SetString(s, c + 1, tend - c);
  Val(s, TLMDPtrInt(src), valcd);
  if valcd <> 0 then
    goto LError;

  { Skip 'Source:' }

  _SkipBlanks;
  if not ((c - 6 > boff) and (c^ = ':') and ((c - 1)^ = 'e') and
          ((c - 2)^ = 'c') and ((c - 3)^ = 'r') and ((c - 4)^ = 'u') and
          ((c - 5)^ = 'o') and ((c - 6)^ = 'S')) then
    goto LError;
  Dec(c, 7);

  if (SourceList = nil) or (SourceList.IndexOf(src) = -1) then
    goto LError;

  { Parse original message }

  _SkipBlanks;
  if c = boff then
    AOriginalMsg := ''
  else
    SetString(AOriginalMsg, boff + 1, c - boff);

  ASource := TLMDScriptControl(src);
  ALine   := ln;
  APos    := ps;
  Result  := True;
  Exit;

LError:
  AOriginalMsg := '';
  ASource      := nil;
  ALine        := -1;
  APos         := -1;
  Result       := False;
end;

{ ---------------------------------------------------------------------------- }

procedure DispCallCheck(AStatus: Integer; var AExcepInfo: EXCEPINFO);
begin
  if AStatus < 0 then
  begin
    if AStatus = DISP_E_EXCEPTION then
      LMDOleCheck(AExcepInfo.scode, False, AExcepInfo.bstrDescription)
    else
      LMDOleCheck(AStatus, False);
  end;
end;

{ ---------------------------------------------------------------------------- }

function GetPDM: IProcessDebugManager;
begin
  PDMLock.Acquire;
  try
    if PDMVar = nil then
    begin
      OleCheck(CoCreateInstance(CLASS_ProcessDebugManager, nil,
                                CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER or
                                CLSCTX_INPROC_HANDLER,
                                IProcessDebugManager, PDMVar));
    end;

    Result := PDMVar;
  finally
    PDMLock.Release;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure GetBreakParams(const ACodeContext: IDebugCodeContext;
  out ADocument: IDebugDocument; out ALine: Integer); overload;
var
  docctx:        IDebugDocumentContext;
  text:          IDebugDocumentText;
  pos, numchars: DWORD;
  line, col:     DWORD;
begin
  ACodeContext.GetDocumentContext(docctx);
  docctx.GetDocument(ADocument);

  LMDOleCheck(ADocument.QueryInterface(IDebugDocumentText, text));

  text.GetPositionOfContext(docctx, pos, numchars);
  text.GetLineOfPosition(pos, line, col);

  ALine := line;
end;

{ ---------------------------------------------------------------------------- }

procedure GetBreakParams(const AFrame: tagDebugStackFrameDescriptor;
  out ADocument: IDebugDocument; out ALine: Integer); overload;
var
  cdctx: IDebugCodeContext;
begin
  AFrame.pdsf.GetCodeContext(cdctx);
  GetBreakParams(cdctx, ADocument, ALine);
end;

{ ---------------------------------------------------------------------------- }

procedure GetBreakParams(const AThread: IRemoteDebugApplicationThread;
                         out ADocument: IDebugDocument;
                         out ALine: Integer); overload;
var
  frames:  IEnumDebugStackFrames;
  frame:   tagDebugStackFrameDescriptor;
  fetched: DWORD;
begin
  AThread.EnumStackFrames(frames);
  frames.RemoteNext(1, frame, fetched);

  GetBreakParams(frame, ADocument, ALine);
end;

{************************** class TNamedItemsTraits ***************************}
{ --------------------------------- public ----------------------------------- }

class function TNamedItemsTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := MakeHashK(TNamedItem(AItem).UppName);
end;
    
{ ---------------------------------------------------------------------------- }

class function TNamedItemsTraits.MakeHashK(const AKey): Integer;
begin
  Result := TLMDHashTable.StrHash(WideString(AKey));
end;

{ ---------------------------------------------------------------------------- }

class function TNamedItemsTraits.Compare(const AKey;
  AItem: TObject): Boolean;
begin
  Result := (WideString(AKey) = TNamedItem(AItem).UppName);
end;

{******************************* TAXCodeObject ********************************}
{ ---------------------------------------------------------------------------- }

function TAXCodeObject.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := FOrigin.GetTypeInfoCount(Count);
end;

{ ---------------------------------------------------------------------------- }

function TAXCodeObject.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Result := FOrigin.GetTypeInfo(Index, LocaleID, TypeInfo);
end;

{ ---------------------------------------------------------------------------- }

function TAXCodeObject.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := FOrigin.GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs);
end;

{ ---------------------------------------------------------------------------- }

function TAXCodeObject.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  FErrorHolder.ClearScriptError;
  Result := FOrigin.Invoke(DispID, IID, LocaleID, Flags, Params,
                           VarResult, ExcepInfo, ArgErr);

  if FErrorHolder.FLastError <> nil then
  begin
    FErrorHolder.FormatScriptError(PEXCEPINFO(ExcepInfo)^.bstrDescription);
    Result := DISP_E_EXCEPTION;
  end;
end;

{ ---------------------------------------------------------------------------- }

constructor TAXCodeObject.Create(AErrorHolder: TAXScriptErrorHolder;
  AOrigin: IDispatch);
begin
  inherited Create;
  FErrorHolder := AErrorHolder.AddRef;
  FOrigin      := AOrigin;
end;
    
{******************************* class TAXSite ********************************}
{ -------------------------------- protected --------------------------------- }

procedure TAXSite.GetLCID(out plcid: LongWord);
begin
  plcid := GetThreadLocale;
end;

procedure TAXSite.GetRootApplicationNode(out ppdanRoot: IDebugApplicationNode);
var
  Result: HRESULT;
begin
  Result := S_OK;

  if FRunner.FHelper <> nil then
    FRunner.FHelper.GetDebugApplicationNode(ppdanRoot)
  else
    Result := E_NOTIMPL;

  LMDOleCheck(Result);
end;

{ ---------------------------------------------------------------------------- }

procedure TAXSite.GetItemInfo(pstrName: PWideChar;
  dwReturnMask: LongWord; out ppiunkItem: IUnknown;
  out ppti: IUnknown);
var
  uppnm:  WideString;
  item:   TNamedItem;
  Result: HRESULT;
begin
  if (dwReturnMask and SCRIPTINFO_IUNKNOWN) <> 0 then
  begin
    uppnm := LMDWideUpperCase(pstrName);
    item  := TNamedItem(FRunner.FSControl.FNamedItems.Find(uppnm));

    if (item <> nil) and (item.Kind = nikObject) and
       (TVarData(item.Value).VType = varDispatch) and
       (TVarData(item.Value).VDispatch <> nil) then
    begin
      ppiunkItem := IDispatch(item.Value);
      Result     := S_OK;
    end
    else if uppnm = ValuesHolderName then
    begin
      ppiunkItem := FRunner.FSControl.FNamedValuesHolder;
      Result     := S_OK;
    end
    else if uppnm = ConditionCvtrName then
    begin
      ppiunkItem := FCondCvtr;
      Result     := S_OK;
    end
    else
      Result := TYPE_E_ELEMENTNOTFOUND;
  end
  else
    Result := E_NOTIMPL;

  LMDOleCheck(Result, true);
end;

{ ---------------------------------------------------------------------------- }

procedure TAXSite.GetDocVersionString(out pbstrVersion: WideString);
begin
  LMDOleCheck(E_NOTIMPL, true);
end;

{ ---------------------------------------------------------------------------- }

procedure TAXSite.OnScriptTerminate(var pVarResult: OleVariant;
  var pexcepinfo: tagEXCEPINFO);
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }

procedure TAXSite.OnStateChange(ssScriptState: tagSCRIPTSTATE);
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TAXSite.OnScriptError(const pscripterror: IActiveScriptError);
begin
  FRunner.FErrorHolder.SetError(pscripterror);
end;

{ ---------------------------------------------------------------------------- }

procedure TAXSite.OnEnterScript;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TAXSite.OnLeaveScript;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TAXSite.GetWindow(out phwnd: wireHWND);
begin
  phwnd := wireHWND(Application.Handle);
end;

{ ---------------------------------------------------------------------------- }

destructor TAXSite.Destroy;
begin
  FCondCvtr._Release;
  inherited;
end;

procedure TAXSite.EnableModeless(fEnable: Integer);
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TAXSite.GetDocumentContextFromPosition(dwSourceContext: LongWord;
  uCharacterOffset: LongWord; uNumChars: LongWord;
  out ppsc: IDebugDocumentContext);
var
  sc:             IActiveScript;
  charpos, chars: DWORD;

  Result: HRESULT;
begin
  Result := S_OK;

  if FRunner.FHelper <> nil then
  begin
    FRunner.FHelper.GetScriptBlockInfo(dwSourceContext, sc, charpos, chars);
    FRunner.FHelper.CreateDebugDocumentContext(charpos + uCharacterOffset,
                                               uNumChars, ppsc);
  end
  else
    Result := E_NOTIMPL;

  LMDOleCheck(Result);
end;
                     
{ ---------------------------------------------------------------------------- }

procedure TAXSite.GetApplication(out ppda: IDebugApplication);
var
    Result: HRESULT;
begin
  if FRunner.FAppDebugger <> nil then
  begin
    ppda   := FRunner.FRunnerDebug.FApplication;
    Result := S_OK;
  end
  else
    Result := E_NOTIMPL;

  LMDOleCheck(Result, true);
end;

{ ---------------------------------------------------------------------------- }

procedure TAXSite.OnScriptErrorDebug(
  const pErrorDebug: IActiveScriptErrorDebug; out pfEnterDebugger: Integer;
  out pfCallOnScriptErrorWhenContinuing: Integer);
begin
  pfEnterDebugger                   := Integer(False);
  pfCallOnScriptErrorWhenContinuing := Integer(True);
end;

{ --------------------------------- public ----------------------------------- }

constructor TAXSite.Create(ARunner: TActiveXRunner);
begin
  inherited Create;
  FRunner   := ARunner;
  FCondCvtr := TAXConditionConverter.Create;
  FCondCvtr._AddRef;
end;
        
{ ---------------------------------------------------------------------------- }

{******************************* TAXExprCallBack ******************************}
{ ---------------------------------------------------------------------------- }

function TAXExprCallBack.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

{ ---------------------------------------------------------------------------- }

function TAXExprCallBack._AddRef: Integer;
begin
  Result := -1;
end;

{ ---------------------------------------------------------------------------- }

function TAXExprCallBack._Release: Integer;
begin
  Result := -1;
end;

{ ---------------------------------------------------------------------------- }

procedure TAXExprCallBack.onComplete;
begin
  FEvent.SetEvent;
end;

{ ---------------------------------------------------------------------------- }

constructor TAXExprCallBack.Create;
begin
  inherited;
  FEvent := TEvent.Create(nil, False, False, '');
end;
            
{ ---------------------------------------------------------------------------- }

destructor TAXExprCallBack.Destroy;
begin
  FEvent.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TAXExprCallBack.WaitFor;
begin
  FEvent.WaitFor(INFINITE);
end;

{****************************** TAXAppDebugger ********************************}
{ ---------------------------------------------------------------------------- }

procedure TAXAppDebugger.QueryAlive;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TAXAppDebugger.CreateInstanceAtDebugger(var rclsid: TGUID;
  const pUnkOuter: IUnknown; dwClsContext: LongWord; var riid: TGUID;
  out ppvObject: IUnknown);
var
  Result: HRESULT;
begin
  Result := CoCreateInstance(rclsid, pUnkOuter, dwClsContext,
                             riid, ppvObject);
  LMDOleCheck(Result);
end;

{ ---------------------------------------------------------------------------- }

procedure TAXAppDebugger.DoHandleBreak(
  const AThread: IRemoteDebugApplicationThread; ABreakKind: TLMDBreakKind;
  AScript: TLMDScriptControl; ALine: Integer; BP: TLMDBreakpoint);
var
  frms:     IEnumDebugStackFrames;
  frm:      tagDebugStackFrameDescriptor;
  fetched:  Cardinal;
  eres:     HRESULT;
  estr:     WideString;
  app:      IRemoteDebugApplication;
  s:        WideString;
  i, cnt:   Integer;
  dbgr:     TLMDScriptDebugger;
  clearsck: Boolean;
  curpcnt:  Integer;
begin
  dbgr     := FRunnerDebug.FDebugger;
  clearsck := True;

  try
    if (ABreakKind = bkBreakpoint) and (BP <> nil) then
    begin
      AThread.EnumStackFrames(frms);
      frms.RemoteNext(1, frm, fetched);

      { Evaluate condition }

      if BP.Condition <> '' then
      begin
        s := ConditionCvtrName + '(' + BP.Condition + ')';
        FRunnerDebug.DoEval(frm.pdsf, s).GetResultAsString(eres, estr);

        if not Succeeded(eres) or (Pos(WideString(ConditionCvtrRes),
                                       estr) = 0) then
        begin
          AThread.GetApplication(app);
          app.ResumeFromBreakPoint(AThread, BREAKRESUMEACTION_IGNORE,
                                   ERRORRESUMEACTION_SkipErrorStatement);
          Exit;
        end;
      end;

      { Handle PassCount }

      if BP.FPassCount > 0 then
      begin
        curpcnt := BP.CurrentPassCount;
        if curpcnt >= BP.FPassCount then
          curpcnt := 0;
        Inc(curpcnt);

        BP.InternalSetCrPassCount(curpcnt);
      end;

      dbgr.LogDebugMsg(dmBreakpointReached, BP);

      if BP.CurrentPassCount < BP.FPassCount then
      begin
        AThread.GetApplication(app);
        app.ResumeFromBreakPoint(AThread, BREAKRESUMEACTION_IGNORE,
                                 ERRORRESUMEACTION_SkipErrorStatement);
        Exit;
      end;

      { Log message }

      if BP.Action.LogMessage <> '' then
        dbgr.LogDebugMsg(dmLogMessage, BP);

      { Eval expression }

      if BP.Action.EvalExpression <> '' then
      begin
        s := BP.Action.EvalExpression;
        FRunnerDebug.DoEval(frm.pdsf, s).GetResultAsString(eres, estr);

        dbgr.LogDebugMsg(dmEvalExpr, BP, estr);
      end;

      { Log stack frames }

      if BP.Action.LogStackFrames > 0 then
      begin
        dbgr.FLoggingStack := True;
        try
          dbgr.LogDebugMsg(dmLogStackHeader, BP);

          cnt := dbgr.StackFrameCount;
          if cnt > BP.Action.LogStackFrames then
            cnt := BP.Action.LogStackFrames;

          for i := 0 to cnt - 1 do
          begin
            dbgr.LogDebugMsg(dmLogStackFrame, BP, '',
                             dbgr.StackFrames[i]);
          end;
        finally
          dbgr.FLoggingStack := False;
        end;
      end;

      { Enable/disable group }

      s := BP.Action.EnableGroup;
      if s <> '' then
        dbgr.SetBreakpointGroupEnabled(s, True);

      s := BP.Action.DisableGroup;
      if s <> '' then
        dbgr.SetBreakpointGroupEnabled(s, False);

      { Is break required }

      if not BP.Action.Break then
      begin
        AThread.GetApplication(app);
        app.ResumeFromBreakPoint(AThread, BREAKRESUMEACTION_IGNORE,
                                 ERRORRESUMEACTION_SkipErrorStatement);
        Exit;
      end;
    end;

    clearsck := False;
    dbgr.HandleBreak(ABreakKind, AScript, ALine);
  finally
    if clearsck then
      dbgr.ClearStackFrames;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TAXAppDebugger.onDebugOutput(pstr: PWideChar);
begin
  FRunnerDebug.FDebugger.LogDebugMsg(dmDebuggerOutput, nil, pstr);
end;

{ ---------------------------------------------------------------------------- }

procedure TAXAppDebugger.onHandleBreakPoint(
 const prpt: IRemoteDebugApplicationThread; br: tagBREAKREASON;
 const pError: IActiveScriptErrorDebug);
var
  app:     IRemoteDebugApplication;
  doc:     IDebugDocument;
  line:    Integer;
  script:  TLMDScriptControl;
  bkknd:   TLMDBreakKind;
  bp:      TLMDBreakpoint;
begin
  if (br <> BREAKREASON_BREAKPOINT) and (br <> BREAKREASON_STEP) and
     (br <> BREAKREASON_DEBUGGER_HALT) then
  begin
    prpt.GetApplication(app);
    app.ResumeFromBreakPoint(prpt, BREAKRESUMEACTION_IGNORE,
                             ERRORRESUMEACTION_SkipErrorStatement);
    Exit;
  end;

  case br of
    BREAKREASON_BREAKPOINT: bkknd := bkBreakpoint;
    BREAKREASON_STEP:       bkknd := bkStep;
    else                    bkknd := bkCausedBreak;
  end;

  GetBreakParams(prpt, doc, line);

  script                    := FRunnerDebug.FindScriptControl(doc);
  bp                        := FRunnerDebug.FDebugger.FindBreakpoint(script.DebugModule,
                                                                     line);
  FRunnerDebug.FBreakThread := prpt;
  Assert(script <> nil);

  // Expression evaluation is not possible inside the
  // onHandleBreakPoint, so, if required, new thread is
  // started.

  if (bkknd = bkBreakpoint) and (bp <> nil) and
     ((bp.Condition <> '') or (bp.Action.EvalExpression <> '')) then
    TAXBreakThread.Create(Self, prpt, bkknd, script, line, bp)
  else
  begin
    try
      DoHandleBreak(prpt, bkknd, script, line, bp);
    except
      LMDOleCheck(E_FAIL, True);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TAXAppDebugger.onClose;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TAXAppDebugger.onDebuggerEvent(var riid: TGUID;
  const punk: IUnknown);
begin
  LMDOleCheck(E_NOTIMPL, true);
end;

{ ---------------------------------------------------------------------------- }

procedure TAXAppDebugger.StartDebugSession(
  const pda: IRemoteDebugApplication);
begin
  pda.ConnectDebugger(Self);
end;

{ ---------------------------------------------------------------------------- }

constructor TAXAppDebugger.Create(ARunnerDebug: TActiveXRunnerDebug);
begin
  inherited Create;
  FRunnerDebug := ARunnerDebug;
end;
          
{************************ class TLMDScriptEventHandler ************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDScriptEventHandler.Create(AOwner: TLMDScriptControl;
  const AProcName: TLMDString);
begin
  inherited Create;

  FOwner     := AOwner;
  FProcName  := AProcName;
end;

{************************** class TLMDScriptControl ***************************}
{ --------------------------------- private ---------------------------------- }

procedure TLMDScriptControl.SourceChanging;
begin
  CheckState([ssInactive]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.DoAddNamedObject(const Name: TLMDString;
  const AObj: IDispatch; APublishMembers: Boolean);
var
  uppnm: WideString;
  item:  TNamedItem;
begin
  uppnm := LMDWideUpperCase(Name);
  if FNamedItems.Find(uppnm) <> nil then
    raise EOleSysError.Create(Format(SLMDDuplicateNamedItem, [Name]),
                              E_FAIL, -1);

  item             := TNamedItem.Create;
  item.Kind        := nikObject;
  item.UppName     := uppnm;
  item.Name        := Name;
  item.Value       := AObj;
  item.PubMembers  := APublishMembers;
  FNamedItems.Add(item);

  if FState <> ssInactive then
    TRunnerBase(FRunner).AddNamedObjectToEngine(item);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.DoAddOrSetNamedValue(const Name: TLMDString;
  const Value: OleVariant);
var
  uppnm: WideString;
  item:  TNamedItem;
begin
  uppnm := LMDWideUpperCase(Name);
  item  := TNamedItem(FNamedItems.Find(uppnm));

  if (item <> nil) and (item.Kind <> nikValue) then
    raise EOleSysError.Create(Format(SLMDValNamedItemRequired, [Name]),
                              E_FAIL, -1);

  if item = nil then
  begin
    item             := TNamedItem.Create;
    item.Kind        := nikValue;
    item.UppName     := uppnm;
    item.Name        := Name;
    FNamedItems.Add(item);
  end;

  item.Value := Value;

  if FState <> ssInactive then
    FNamedValuesHolder.AddOrSet(item.Name, @item.Value);
end;

{ ---------------------------------------------------------------------------- }

function TLMDScriptControl.GetCodeObject: IDispatch;
begin
  CheckState([ssPrepared, ssActive]);
  Result := FCodeObject;
end;

function TLMDScriptControl.GetDebugName: TLMDString;
begin
  Result := '';
  if FDebugModule <> nil then
    Result := FDebugModule.Name;
end;

{ ---------------------------------------------------------------------------- }
function TLMDScriptControl.GetScript: OleVariant;
begin
  CheckState([ssPrepared, ssActive]);
  Result := FCodeObject;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.SetLanguage(const Value: TLMDScriptLanguage);
begin
  CheckState([ssInactive]);

  {$IFDEF LMDX64}
  if LMDScriptLangKinds[Value] = slkActiveX then
    raise ELMDScriptControl.Create('ActiveX languages are not supported ' +
                                   'on X64 platform');
  {$ENDIF}

  if FDebugger <> nil then
    ValidateDebugger(Value, FDebugger);
  FLanguage := Value;
  if FDebugger <> nil then
    FDebugger.ScriptItemLangChanged(Self);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.SetSource(const Value: TLMDStrings);
begin
  CheckState([ssInactive]);
  FSource.Assign(Value);
end;
                         
{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.SetDebugger(const Value: TLMDScriptDebugger);
begin
  CheckState([ssInactive]);
  if Value <> nil then
    ValidateDebugger(FLanguage, Value);

  if FDebugger <> Value then
  begin
    if FDebugger <> nil then
      FDebugger.RemoveScriptItem(Self);
    if Value <> nil then
      Value.InsertScriptItem(Self);
  end;
end;

procedure TLMDScriptControl.SetDebugModule(const Value: TLMDDebugModule);
begin
  if Value <> FDebugModule then
  begin
    if (Value = nil) or (Value.Debugger = FDebugger) then
      FDebugModule := Value;
    if FDebugger <> nil then
      FDebugger.ScriptDebugModuleChanged(Self);
  end;
end;

procedure TLMDScriptControl.SetDebugName(const Value: TLMDString);
begin
  if csLoading in ComponentState then
    FLoadingDebugName := Value
  else if GetDebugName <> Value then
  begin
    if Value = '' then
      DebugModule := nil
    else if FDebugger <> nil then
      DebugModule := FDebugger.Modules.FindOrAdd(Value);
  end;
end;

procedure TLMDScriptControl.SetExceptionSourceInfo(const Value: Boolean);
begin
  CheckState([ssInactive]);
  FExceptionSourceInfo := Value;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.SetActive(const Value: Boolean);
begin
  if GetActive <> Value then
  begin
    if Value then
      Open(True)
    else
      Close;
  end;
end;

{ ------------------------------ protected ----------------------------------- }

function TLMDScriptControl.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_SCRIPT;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDScriptControl.Create(AOwner: TComponent);
begin
  inherited;
  FSource              := TScriptSourceStrings.Create(Self);
  FNamedItems          := TLMDHashTable.Create(TNamedItemsTraits, True);
  FEventHandlers       := TList.Create;
  FLanguage            := slVBScript;
  FExceptionSourceInfo := True;

  SourceList.Add(Self);
end;

function TLMDScriptControl.InitNamedValuesHolder: ILMDNamedValuesHolder;
var
  items: TList;
  i:     Integer;
begin
  Result := TNamedValuesHolder.Create;
  items  := TList.Create;
  try
    FNamedItems.GetAll(items);

    for i := 0 to items.Count - 1 do
    begin
      if TNamedItem(items[i]).Kind = nikValue then
        Result.AddOrSet(TNamedItem(items[i]).Name,
                        @TNamedItem(items[i]).Value);
    end;
  finally
    items.Free;
  end;
end;

procedure TLMDScriptControl.Loaded;
begin
  inherited;
  DebugName := FLoadingDebugName;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDScriptControl.Destroy;
begin
  if SourceList <> nil then
    SourceList.Remove(Self);

  Active   := False;
  Debugger := nil;
  ClearEventHandlers;

  FSource.Free;
  FEventHandlers.Free;
  FNamedItems.Free;
  inherited;
end;

procedure TLMDScriptControl.DoAfterClose;
begin
  if Assigned(FAfterClose) then
    FAfterClose(Self);
end;

procedure TLMDScriptControl.DoBeforeOpen;
begin
  if Assigned(FBeforeOpen) then
    FBeforeOpen(Self);
end;

procedure TLMDScriptControl.DoBeforePrepare;
begin
  if Assigned(FBeforePrepare) then
    FBeforePrepare(Self);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.AddOrSetValue(const Name: TLMDString;
  const Value: OleVariant);
begin
  DoAddOrSetNamedValue(Name, Value);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.AddObject(const Name: TLMDString;
                                      const Obj: OleVariant;
                                      APublishMembers: Boolean);
begin
  DoAddNamedObject(Name, Obj, APublishMembers);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.AddChildren(const AOwner: TComponent;
  APublishMembers: Boolean);
var
  i:    Integer;
  disp: IDispatch;
begin
  for i := 0 to AOwner.ComponentCount - 1 do
    if AOwner.Components[i].Name <> '' then
    begin
      disp := TObject_sw.ToVar(AOwner.Components[i]);
      DoAddNamedObject(AOwner.Components[i].Name,
                   disp,
                   APublishMembers);
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.AddUnit(AWrapperClass: TLMDUnitWrapperClass;
  APublishMembers: Boolean);
begin
  DoAddNamedObject(AWrapperClass.GetUnitName, GetUnitInstance(AWrapperClass),
               APublishMembers);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.AddUnits(
  AWrapperClasses: array of TLMDUnitWrapperClass;
  APublishMembers: Boolean);
var
  i: Integer;
begin
  for i := Low(AWrapperClasses) to High(AWrapperClasses) do
    AddUnit(AWrapperClasses[i], APublishMembers);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.AddAllUnits(APublishMembers: Boolean);
var
  i:    Integer;
  wrps: TList;
begin
  wrps := GetUnitWrapperClassList;
  for i := 0 to wrps.Count - 1 do
    AddUnit(TLMDUnitWrapperClass(wrps[i]), APublishMembers);
end;

{ ---------------------------------------------------------------------------- }

function TLMDScriptControl.TryReadValue(const Name: TLMDString;
  out AResult: OleVariant): Boolean;
var
  uppnm: WideString;
  item:  TNamedItem;
begin
  uppnm := LMDWideUpperCase(Name);
  item  := TNamedItem(FNamedItems.Find(uppnm));

  Result := (item <> nil) and (item.Kind = nikValue);
  if Result then
    AResult := item.Value;
end;

{ ---------------------------------------------------------------------------- }

function TLMDScriptControl.ReadVar(const Name: TLMDString): OleVariant;
begin
  CheckState([ssActive]);
  Result := TRunnerBase(FRunner).ReadVar(Name);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.RemoveObject(const AName: TLMDString);
var
  uppnm: WideString;
begin
  CheckState([ssInactive]);

  uppnm := LMDWideUpperCase(Name);
  FNamedItems.Remove(uppnm);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.ClearObjects;
begin
  CheckState([ssInactive]);
  FNamedItems.Clear;
end;
    
{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.ClearEventHandlers;
var
  i: Integer;
begin
  for i := 0 to FEventHandlers.Count - 1 do
    TLMDScriptEventHandler(FEventHandlers[i]).Free;
  FEventHandlers.Count := 0;
end;
    
{ ---------------------------------------------------------------------------- }

function TLMDScriptControl.GetEventHandler(const AProcName: TLMDString;
  AEventType: TLMDEventWrapperClass): TLMDScriptEventHandler;
var
  i:    Integer;
  hcls: TLMDScriptEventHandlerClass;
  item: TLMDScriptEventHandler;
begin
  hcls := TLMDScriptEventHandlerClass(AEventType.GetScriptHandlerClass);

  for i := 0 to FEventHandlers.Count - 1 do
  begin
    item := TLMDScriptEventHandler(FEventHandlers[i]);

    if (item.ClassType = hcls) and
       WideSameText(item.ProcName, AProcName) then
    begin
      Result := item;
      Exit;
    end;
  end;

  Result := hcls.Create(Self, AProcName);
  FEventHandlers.Add(Result);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.HookEvent(AInstance: TPersistent;
  APropInfo: TLMDPropInfo; const AProcName: TLMDString);
var
  evttp: TLMDEventWrapperClass;
  md:    TMethod;
begin
  evttp := GetEventWrapperClass(APropInfo.PropType^);
  md    := GetEventHandler(AProcName, evttp).GetHandler;
  SetMethodProp(AInstance, APropInfo, md);
end;

{ ---------------------------------------------------------------------------- }

function TLMDScriptControl.GetUnitInstance(
  AWrapperClass: TLMDUnitWrapperClass): IDispatch;
begin
  Result := AWrapperClass.Create(Self);
end;

procedure TLMDScriptControl.HookEvent(AInstance: TPersistent; const APropName,
  AProcName: TLMDString);
var
  pnfo: TLMDPropInfo;
begin
  pnfo := GetPropInfo(AInstance.ClassInfo, APropName);
  if pnfo = nil then
    raise ELMDScriptControl.CreateFmt('Property not found: %s', [APropName]);
  HookEvent(AInstance, pnfo, AProcName);
end;

{ ---------------------------------------------------------------------------- }

function TLMDScriptControl.Eval(const AExpression: TLMDString): OleVariant;
begin
  CheckState([ssActive]);
  Result := TRunnerBase(FRunner).Eval(AExpression);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptControl.ExecuteStatement(const AStatement: TLMDString);
begin
  CheckState([ssActive]);
  TRunnerBase(FRunner).ExecStmt(AStatement);
end;
                              
{ ---------------------------------------------------------------------------- }

function TLMDScriptControl.RunProc(const Name: TLMDString): OleVariant;
begin
  CheckState([ssActive]);
  Result := TRunnerBase(FRunner).RunProc(Name);
end;

{ ---------------------------------------------------------------------------- }
function TLMDScriptControl.RunProc(const Name: TLMDString;
  const Args: array of OleVariant): OleVariant;
begin
  CheckState([ssActive]);
  Result := TRunnerBase(FRunner).RunProc(Name, Args);
end;

{*************************** class TLMDBreakpoint *****************************}
{ ---------------------------------------------------------------------------- }

function TLMDBreakpoint.GetState: TLMDBreakpointState;
var
  i:  Integer;
  sc: TLMDScriptControl;
begin
  Result := bsNonactive;

  for i := 0  to FDebugger.FScripts.Count - 1 do
  begin
    sc := TLMDScriptControl(FDebugger.FScripts[i]);
    if sc.FState <> ssInactive then
    begin
      Result := bsValid;
      Break; // for
    end;
  end;

  if (Result <> bsNonactive) and not FValid then
    Result := bsInvalid;
end;
            
procedure TLMDBreakpoint.InternalSetCrPassCount(AValue: Integer);
begin
  if FCurrentPassCount <> AValue then
  begin
    FCurrentPassCount := AValue;
    FDebugger.DoBreakpointsChanged;
  end;
end;

procedure TLMDBreakpoint.SetCondition(const Value: TLMDString);
begin
  if FCondition <> Value then
  begin
    FCondition := Value;
    FDebugger.DoBreakpointsChanged;
  end;
end;

procedure TLMDBreakpoint.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    FDebugger.AdjustBreakpoint(Self, abkSet);
    FDebugger.DoBreakpointsChanged;
  end;
end;

procedure TLMDBreakpoint.SetGroup(const Value: TLMDString);
begin
  if FGroup <> Value then
  begin
    FGroup := Value;
    FDebugger.DoBreakpointsChanged;
  end;
end;

procedure TLMDBreakpoint.SetPassCount(const Value: Integer);
begin
  if FPassCount <> Value then
  begin
    FPassCount := Value;
    FDebugger.DoBreakpointsChanged;
  end;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDBreakpoint.Destroy;
begin
  FDebugger.RemoveBreakpointItem(Self);
  FAction.Free;
  inherited;
end;
     
{ ---------------------------------------------------------------------------- }

procedure TLMDBreakpoint.Delete;
begin
  Free;
end;

{**************************** class TLMDVariables *****************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVariables.Create;
begin
  inherited Create;
  FRoot := nil;
end;
         
{ ---------------------------------------------------------------------------- }

destructor TLMDVariables.Destroy;
begin
  Clear;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVariables.Clear;
begin
  if FRoot <> nil then
  begin
    FRoot.Free;
    FRoot     := nil;
    FDebugger := nil;

    Changed;
  end;
end;
             
{ ---------------------------------------------------------------------------- }

procedure TLMDVariables.InitProc(const ARunnerVar: IUnknown;
  const AName: TLMDString; const AType: TLMDString;
  const AValue: TLMDString; AFlags: TLMDVariableFlags;
  AExpandable: Boolean);
begin
  if FRoot <> nil then
    raise ELMDScriptControl.Create('Variables already has root.');

  FRoot := TLMDVariable.Create(Self, nil, ARunnerVar, AName,
                               AType, AValue, AFlags, AExpandable);
  Changed;
end;

{**************************** class TLMDVariable ******************************}
{ ---------------------------------------------------------------------------- }

function TLMDVariable.GetCount: Integer;
begin
  if not FItemsFilled then
    FillItems;
  Result := FItems.Count;
end;
             
{ ---------------------------------------------------------------------------- }

function TLMDVariable.GetItems(AIndex: Integer): TLMDVariable;
begin
  if not FItemsFilled then
    FillItems;
  Result := TLMDVariable(FItems[AIndex]);
end;
            
function TLMDVariable.GetNextId: Integer;
begin
  Result := NextVarId;
  Inc(NextVarId);
end;

function TLMDVariable.IndexOfId(AId: Integer): Integer;
var
  i: Integer;
begin
  if not FItemsFilled then
    FillItems;

  for i := 0 to FItems.Count - 1 do
    if TLMDVariable(FItems[i]).FId = AId then
    begin
      Result := i;
      Exit;
    end;

  Result := -1;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVariable.ClearItems;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TLMDVariable(FItems[i]).Free;
  FItems.Clear;
  FItemsFilled := False;
end;
          
{ ---------------------------------------------------------------------------- }

constructor TLMDVariable.Create(AOwner: TLMDVariables;
  AParent: TLMDVariable; const ARunnerVar: IUnknown; const AName: TLMDString;
  const AType: TLMDString; const AValue: TLMDString; AFlags: TLMDVariableFlags;
  AExpandable: Boolean);
begin
  inherited Create;

  FId         := GetNextId;
  FOwner      := AOwner;
  FParent     := AParent;
  FRunnerVar  := ARunnerVar;
  FItems      := TList.Create;
  FName       := AName;
  FType_      := AType;
  FValue      := AValue;
  FFlags      := AFlags;
  FExpandable := AExpandable;
end;
               
{ ---------------------------------------------------------------------------- }

destructor TLMDVariable.Destroy;
begin
  ClearItems;
  FItems.Free;
  inherited;
end;

{*************************** class TLMDStackFrame *****************************}
{ ---------------------------------------------------------------------------- }

function TLMDStackFrame.GetIndex: Integer;
begin
  Result := FDebugger.FStackFrames.IndexOf(Self);
end;

function TLMDStackFrame.GetLongDescription: TLMDString;
begin
  FDebugger.CheckInBerak;
  Result := TRunnerDebugBase(FDebugger.FRunnerDebug).
    GetLongDescription(FRunnerFrame);
end;

{ ---------------------------------------------------------------------------- }

function TLMDStackFrame.GetShortDescription: TLMDString;
begin
  FDebugger.CheckInBerak;
  Result := TRunnerDebugBase(FDebugger.FRunnerDebug).
    GetShortDescription(FRunnerFrame);
end;
            
{ ---------------------------------------------------------------------------- }

constructor TLMDStackFrame.Create(ADebugger: TLMDScriptDebugger;
  ARunnerFrame: TObject; AOwnRunnerFrame: Boolean;
  AScriptControl: TLMDScriptControl; ALine: Integer);
begin
  inherited Create;

  FDebugger         := ADebugger;
  FRunnerFrame      := ARunnerFrame; // Owned by self.
  FOwnRunnerFrame   := AOwnRunnerFrame;
  FScriptControl    := AScriptControl;
  FLine             := ALine;
end;
            
{ ---------------------------------------------------------------------------- }

destructor TLMDStackFrame.Destroy;
begin
  if FOwnRunnerFrame then
    FRunnerFrame.Free;
  inherited;
end;
          
{ ---------------------------------------------------------------------------- }

procedure TLMDStackFrame.Eval(const AExpression: TLMDString;
  AResult: TLMDVariables);
begin
  FDebugger.CheckInBerak;

  AResult.BeginUpdate;
  try
    AResult.Clear;
    AResult.FDebugger := FDebugger;

    TRunnerDebugBase(FDebugger.FRunnerDebug).Eval(FRunnerFrame,
                                                  AExpression,
                                                  AResult.InitProc);
  finally
    AResult.EndUpdate;
  end;
end;
                 
{ ---------------------------------------------------------------------------- }

function TLMDStackFrame.Eval(const AExpression: TLMDString): TLMDString;
begin
  FDebugger.CheckInBerak;
  Result := TRunnerDebugBase(FDebugger.FRunnerDebug).Eval(FRunnerFrame,
                                                          AExpression);
end;
          
{ ---------------------------------------------------------------------------- }

procedure TLMDStackFrame.GetVariables(AResult: TLMDVariables);
begin
  FDebugger.CheckInBerak;

  AResult.BeginUpdate;
  try
    AResult.Clear;
    AResult.FDebugger := FDebugger;

    TRunnerDebugBase(FDebugger.FRunnerDebug).GetVars(FRunnerFrame,
                                                     AResult.InitProc);
  finally
    AResult.EndUpdate;
  end;
end;

{************************* class TLMDScriptDebugger ***************************}
{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.InsertScriptItem(AItem: TLMDScriptControl);
begin
  FScripts.Add(AItem);
  AItem.FDebugger := Self;
  AdjustRunnerDebug;
end;

procedure TLMDScriptDebugger.LogDebugMsg(AKind: TLMDDebugMsgKind;
  BP: TLMDBreakpoint; const S: TLMDString; AFrame: TLMDStackFrame);
var
  msg: TLMDString;
begin
  msg := '';

  case AKind of
    dmDebuggerOutput:
      msg := S;
    dmBreakpointReached:
    begin
      if BP.FPassCount = 0 then
        msg := Format(SLMDBreakpointReached, [BP.Module.Name,
                                              BP.Line])
      else
        msg := Format(SLMDBreakpointReachedPass, [BP.Module.Name,
                                                  BP.Line, BP.CurrentPassCount,
                                                  BP.PassCount]);
    end;
    dmLogMessage:
      msg := Format(SLMDBreakpointMessage, [BP.Action.LogMessage]);
    dmEvalExpr:
      msg := Format(SLMDBreakpointEvalExpr, [BP.Action.EvalExpression, S]);
    dmLogStackHeader:
    begin
      if BP.Action.LogStackFrames = LMDAllStackFrames then
        msg := TLMDBreakpointWholeStackHdr
      else
        msg := Format(TLMDBreakpointNStackHdr, [BP.Action.LogStackFrames]);
    end;
    dmLogStackFrame:
    begin
      msg := '    ' + AFrame.ScriptControl.DebugName;
      if msg <> '' then
        msg := msg + ': ';
      msg := msg + AFrame.LongDescription;
    end;
  end;

  DoFormatDebugMsg(AKind, BP, S, AFrame, msg);
  DoLogMessage(AKind, msg);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.ModuleDeleting(AModule: TLMDDebugModule);
var
  i:   Integer;
  sct: TLMDScriptControl;
  bp: TLMDBreakpoint;
begin
  for i := 0 to FScripts.Count - 1 do
  begin
    sct := TLMDScriptControl(FScripts[i]);
    if sct.FDebugModule = AModule then
      sct.DebugModule := nil;
  end;

  for i := FBreakpoints.Count - 1 downto 0 do
  begin
    bp := TLMDBreakpoint(FBreakpoints[i]);
    if bp.FModule = AModule then
      bp.Delete;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FServiceProvider) then
    ServiceProvider := nil;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.RemoveScriptItem(AItem: TLMDScriptControl);
begin
  FScripts.Remove(AItem);
  AItem.FDebugger    := nil;
  AItem.FDebugModule := nil;
  AdjustRunnerDebug;
end;
               
{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.DisableGroup(const AGroup: TLMDString);
begin
  SetBreakpointGroupEnabled(AGroup, False);
end;

procedure TLMDScriptDebugger.DisconnectScripts;
var
  script: TLMDScriptControl;
begin
  while FScripts.Count > 0 do
  begin
    script          := TLMDScriptControl(FScripts[0]);
    script.Active   := False;
    script.Debugger := nil; // Will remove script control from the list.
  end;
end;
            
{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.InsertBreakpointItem(AItem: TLMDBreakpoint);
begin
  FBreakpoints.Add(AItem);
  AItem.FDebugger := Self;

  AdjustBreakpoint(AItem, abkSet);
  DoBreakpointsChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.RemoveBreakpointItem(AItem: TLMDBreakpoint);
begin
  AdjustBreakpoint(AItem, abkRemove);
  FBreakpoints.Remove(AItem);
  AItem.FDebugger := nil;

  DoBreakpointsChanged;
end;
                  
{ ---------------------------------------------------------------------------- }

function TLMDScriptDebugger.GetBreakpointCount: Integer;
begin
  Result := FBreakpoints.Count;
end;
               
{ ---------------------------------------------------------------------------- }

function TLMDScriptDebugger.GetBreakpoints(
  AIndex: Integer): TLMDBreakpoint;
begin
  Result := TLMDBreakpoint(FBreakpoints[AIndex]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.AddStackFrameProc(ARunnerFrame: TObject;
  AOwnRunnerFrame: Boolean; AScriptControl: TLMDScriptControl; ALine: Integer);
var
  frame: TLMDStackFrame;
begin
  frame := TLMDStackFrame.Create(Self, ARunnerFrame, AOwnRunnerFrame,
                                 AScriptControl, ALine);
  FStackFrames.Add(frame);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.ClearBreakpoints(AModule: TLMDDebugModule);
var
  i:  Integer;
  bp: TLMDBreakpoint;
begin
  for i := FBreakpoints.Count - 1 downto 0 do
  begin
    bp := TLMDBreakpoint(FBreakpoints[i]);
    if bp.FModule = AModule then
      bp.Free;
  end;
end;

procedure TLMDScriptDebugger.ClearStackFrames;
var
  i: Integer;
begin
  for i := 0 to FStackFrames.Count - 1 do
    TLMDStackFrame(FStackFrames[i]).Free;
  FStackFrames.Clear;
end;
              
{ ---------------------------------------------------------------------------- }

function TLMDScriptDebugger.GetStackFrameCount: Integer;
begin
  Result := 0;

  if (FBreakKind <> bkNone) or FLoggingStack then
  begin
    if FStackFrames.Count = 0 then
      UpdateStackFrames;
    Result := FStackFrames.Count;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDScriptDebugger.GetStackFrames(
  AIndex: Integer): TLMDStackFrame;
begin
  CheckInBerak;

  if FStackFrames.Count = 0 then
    UpdateStackFrames;
  Result := TLMDStackFrame(FStackFrames[AIndex]);
end;
              
{ ---------------------------------------------------------------------------- }

function TLMDScriptDebugger.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_SCRIPT;
end;
           
{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.DoBreakpoint(AScriptControl: TLMDScriptControl;
  ALine: Integer);
var
  i: Integer;
  lst: TList;
begin
  if not (csDestroying in ComponentState) then
  begin
    { Internal notifiers }

    for i := 0 to FNotifiers.Count - 1 do
      ILMDScriptDebuggerNotifier(FNotifiers[i]).Breaked(Self);

    { Services notifiers }

    if FServiceProvider <> nil then
    begin
      lst := FServiceProvider.Notifiers.GetList(ILMDScriptDebuggerNotifier);
      try
        for i := 0 to lst.Count - 1 do
          ILMDScriptDebuggerNotifier(lst[i]).Breaked(Self);
      finally
        lst.Free;
      end;
    end;

    if Assigned(FOnBreak) then
      FOnBreak(Self, AScriptControl, ALine);
  end;
end;
           
procedure TLMDScriptDebugger.DoBreakpointsChanged;
var
  i:   Integer;
  lst: TList;
begin
  if not (csDestroying in ComponentState) then
  begin
    { Internal notifiers }

    for i := 0 to FNotifiers.Count - 1 do
      ILMDScriptDebuggerNotifier(FNotifiers[i]).BreakpointsChanged(Self);

    { Services notifiers }

    if FServiceProvider <> nil then
    begin
      lst := FServiceProvider.Notifiers.GetList(ILMDScriptDebuggerNotifier);
      try
        for i := 0 to lst.Count - 1 do
          ILMDScriptDebuggerNotifier(lst[i]).BreakpointsChanged(Self);
      finally
        lst.Free;
      end;
    end;

    if Assigned(FOnBreakpointsChanged) then
      FOnBreakpointsChanged(Self);
  end;
end;

procedure TLMDScriptDebugger.DoLogMessage(AKind: TLMDDebugMsgKind;
  const AMsg: TLMDString);
var
  i:   Integer;
  lst: TList;
begin
  if not (csDestroying in ComponentState) then
  begin
    { Internal notifiers }

    for i := 0 to FNotifiers.Count - 1 do
      ILMDScriptDebuggerNotifier(FNotifiers[i]).LogMessage(Self, AMsg, AKind);

    { Services notifiers }

    if FServiceProvider <> nil then
    begin
      lst := FServiceProvider.Notifiers.GetList(ILMDScriptDebuggerNotifier);
      try
        for i := 0 to lst.Count - 1 do
          ILMDScriptDebuggerNotifier(lst[i]).LogMessage(Self, AMsg, AKind);
      finally
        lst.Free;
      end;
    end;

    if Assigned(FOnLogMessage) then
      FOnLogMessage(Self, AKind, AMsg);
  end;
end;

procedure TLMDScriptDebugger.DoFormatDebugMsg(AMsgKind: TLMDDebugMsgKind;
  BP: TLMDBreakpoint; const S: TLMDString; AFrame: TLMDStackFrame;
  var AMsg: TLMDString);
begin
  if Assigned(FOnFormatDebugMsg) then
    FOnFormatDebugMsg(Self, AMsgKind, BP, S, AFrame, AMsg);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.DoInvalidBreakpoint(
  ABreakpoint: TLMDBreakpoint);
begin
  if Assigned(FOnInvalidBreakpoint) then
    FOnInvalidBreakpoint(Self, ABreakpoint);
end;
              
procedure TLMDScriptDebugger.DoResume;
var
  i:   Integer;
  lst: TList;
begin
  if not (csDestroying in ComponentState) then
  begin
    { Internal notifiers }

    for i := 0 to FNotifiers.Count - 1 do
      ILMDScriptDebuggerNotifier(FNotifiers[i]).Resumed(Self);

    { Services notifiers }

    if FServiceProvider <> nil then
    begin
      lst := FServiceProvider.Notifiers.GetList(ILMDScriptDebuggerNotifier);
      try
        for i := 0 to lst.Count - 1 do
          ILMDScriptDebuggerNotifier(lst[i]).Resumed(Self);
      finally
        lst.Free;
      end;
    end;
  end;
end;

procedure TLMDScriptDebugger.EnableGroup(const AGroup: TLMDString);
begin
  SetBreakpointGroupEnabled(AGroup, True);
end;

function TLMDScriptDebugger.FindBreakpoint(AModule: TLMDDebugModule;
  ALine: Integer): TLMDBreakpoint;
var
  i:  Integer;
  bp: TLMDBreakpoint;
begin
  for i := 0 to FBreakpoints.Count - 1 do
  begin
    bp := TLMDBreakpoint(FBreakpoints[i]);

    if (bp.FModule = AModule) and (bp.Line = ALine) then
    begin
      Result := bp;
      Exit;
    end;
  end;

  Result := nil;
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDScriptDebugger.Create(AOwner: TComponent);
begin
  inherited;
  FModules     := TLMDDebugModules.Create(Self, TLMDDebugModule);
  FScripts     := TList.Create;
  FBreakpoints := TList.Create;
  FStackFrames := TList.Create;
  FNotifiers   := TList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDScriptDebugger.Destroy;
begin
  Destroying;
  ServiceProvider := nil;
  ClearBreakpoints;
  ClearStackFrames;
  DisconnectScripts;
  FScripts.Free;
  FBreakpoints.Free;
  FStackFrames.Free;
  FModules.Free;
  FRunnerDebug.Free;
  FNotifiers.Free;
  FNotifiers := nil;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

function TLMDScriptDebugger.SetBreakpoint(AModule: TLMDDebugModule;
  ALine: Integer): TLMDBreakpoint;
begin
  Result := FindBreakpoint(AModule, ALine);
  Assert(AModule <> nil);

  if Result = nil then
    Result := TLMDBreakpoint.Create(Self, AModule, ALine);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.SetBreakpointGroupEnabled(
  const AGroup: TLMDString; AValue: Boolean);
var
  i: Integer;
begin
  if AGroup = '' then
    Exit;

  for i := 0 to FBreakpoints.Count - 1 do
  begin
    if LMDSameText(TLMDBreakpoint(FBreakpoints[i]).Group, AGroup) then
      TLMDBreakpoint(FBreakpoints[i]).Enabled := AValue;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.ClearBreakpoints;
begin
  while FBreakpoints.Count > 0 do
    TLMDBreakpoint(FBreakpoints[0]).Free;
end;
             
{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.CauseBreak;
begin
  TRunnerDebugBase(FRunnerDebug).CauseBreak;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugger.ResetBreakpointsState;
var
  i: Integer;
begin
  for i := 0 to FBreakpoints.Count - 1 do
    TLMDBreakpoint(FBreakpoints[i]).InternalSetCrPassCount(0);
end;

procedure TLMDScriptDebugger.ResumeFromBreak(AKind: TLMDBreakResumeKind);
begin
  CheckInBerak;

  FBreakKind := bkNone;
  ClearStackFrames;
  TRunnerDebugBase(FRunnerDebug).ResumeFromBreak(AKind);

  DoResume;
end;

procedure TLMDScriptDebugger.AddNotifier(
  ANotifier: ILMDScriptDebuggerNotifier);
begin
  if FNotifiers.IndexOf(ANotifier) = -1 then
    FNotifiers.Add(ANotifier);
end;

procedure TLMDScriptDebugger.RemoveNotifier(
  ANotifier: ILMDScriptDebuggerNotifier);
begin
  if FNotifiers <> nil then
    FNotifiers.Remove(ANotifier);
end;

procedure TLMDScriptControl.Close(AClearObjects: Boolean;
  AClearEventHandler: Boolean);
begin
  if FState in [ssPrepared, ssActive] then
  begin
    TRunnerBase(FRunner).Close;
    FCodeObject := nil;
    FNamedValuesHolder := nil;

    FRunner.Free;
    FRunner := nil;

    FState := ssInactive;
  end;

  if AClearObjects then
    ClearObjects;
  if AClearEventHandler then
    ClearEventHandlers;

  DoAfterClose;
end;

procedure TLMDScriptControl.Open(ACloseOnRuntimeError: Boolean);
begin
  CheckState([ssInactive, ssPrepared]);

  if FState = ssInactive then
    Prepare;
  DoBeforeOpen;

  try
    FState := ssActive;
    TRunnerBase(FRunner).Open;
  except
    if ACloseOnRuntimeError then
      Close;
    raise;  
  end;
end;

procedure TLMDScriptControl.Prepare;
var
  rdbg: TRunnerDebugBase;
begin
  CheckState([ssInactive]);
  DoBeforePrepare;

  case LMDScriptLangKinds[FLanguage] of
    slkActiveX: FRunner := TActiveXRunner.Create(Self, FExceptionSourceInfo);
    slkNative:  FRunner := TNativeRunner.Create(Self, FExceptionSourceInfo);
  end;
  try
    rdbg := nil;
    if FDebugger <> nil then
      rdbg := TRunnerDebugBase(FDebugger.FRunnerDebug);

    FNamedValuesHolder := InitNamedValuesHolder;
    TRunnerBase(FRunner).Prepare(rdbg); // Can raise exception. Syntax error,
                                        // for example, while parsing script.

    FCodeObject := TRunnerBase(FRunner).GetCodeObject;
    FState      := ssPrepared;
  except
    FRunner.Free;
    FCodeObject := nil;
    raise;
  end;
end;

procedure TLMDScriptControl.CheckState(
  AValidStates: TLMDScriptControlStates);
begin
  if not (FState in AValidStates) then
    raise ELMDScriptControl.Create('Invalid script control state');
end;

function TLMDScriptControl.GetActive: Boolean;
begin
  Result := (FState = ssActive);
end;

{ TActiveXRunner }

procedure TActiveXRunner.AddNamedObjectToEngine(AItem: TNamedItem);
var
  flags: LongWord;
begin
  flags := SCRIPTITEM_ISVISIBLE;
  if AItem.PubMembers then
    flags := flags or SCRIPTITEM_GLOBALMEMBERS;

  FScript.AddNamedItem(PWideChar(AItem.Name), flags);
end;

procedure TActiveXRunner.AdjustBreakpoint(ALine: Integer;
  AEnabled, ADelete: Boolean; out AIsValid: Boolean);
const
  BpStates: array[Boolean] of tagBREAKPOINT_STATE = (
    BREAKPOINT_ENABLED, BREAKPOINT_DELETED);
var
  asd:       IActiveScriptDebug;
  cdctxs:    IEnumDebugCodeContexts;
  cdctx:     IDebugCodeContext;
  fetched:   DWORD;
  pos, lnt:  Integer;
  ctxdoc:    IDebugDocument;
  ctxline:   Integer;
begin
  Assert(FHelper <> nil);
  AIsValid := False;

  asd := nil;
  FScript.QueryInterface(IActiveScriptDebug, asd);

  if asd <> nil then
  begin
    GetSourceLineMetrix(ALine, pos, lnt);
    asd.EnumCodeContextsOfPosition(FSourceContext, pos, lnt, cdctxs);

    cdctxs.RemoteNext(1, cdctx, fetched);

    if fetched = 1 then // Use first virtual op-code instruction.
    begin
      GetBreakParams(cdctx, ctxdoc, ctxline);

      if ctxline = ALine then
      begin
        cdctx.SetBreakPoint(BpStates[ADelete or not AEnabled]);
        if not ADelete then
          AIsValid := True;
      end;
    end;
  end;
end;

procedure TAXScriptErrorHolder.CheckScriptError;
var
  err:  EXCEPINFO;
  sctx: LongWord;
  line: LongWord;
  pos:  Integer;
  msg:  WideString;
begin
  if FLastError <> nil then
  begin
    FLastError.RemoteGetExceptionInfo(err);
    FLastError.GetSourcePosition(sctx, line, pos);
    FormatScriptError(msg);

    FLastError := nil;
    raise EOleSysError.Create(msg, err.scode, -1);
  end;
end;

procedure TAXScriptErrorHolder.ClearScriptError;
begin
  FLastError := nil;
end;

procedure TActiveXRunner.Close;
begin
  if FScript <> nil then
    FScript.Close;
  if FHelper <> nil then
    FHelper.Detach;
  if FCodeObject <> nil then
    FCodeObject._Release;

  FCodeObject  := nil;
  FScriptParse := nil;
  FScript      := nil;
  FAppDebugger := nil;
  FRunnerDebug := nil;
  FHelper      := nil;
end;

constructor TActiveXRunner.Create(ASControl: TLMDScriptControl;
  AAddSrcInfo: Boolean);
begin
  inherited Create;

  FSControl    := ASControl;
  FAddSrcInfo  := AAddSrcInfo;
  FErrorHolder := TAXScriptErrorHolder.Create(FAddSrcInfo, ASControl).AddRef;
  FSite        := TAXSite.Create(Self);
  FSite._AddRef;
end;

procedure TActiveXRunner.DefineDebugDocBlock(const ASource: WideString;
  out ASourceContext: DWORD);
begin
  FHelper.AddUnicodeText(PWideChar(ASource));
  FHelper.DefineScriptBlock(0, Length(ASource), FScript,
                            Integer(False), ASourceContext);
end;

destructor TActiveXRunner.Destroy;
begin
  FSite._Release;
  FSite := nil;
  FErrorHolder.Release;

  inherited;
end;

function TActiveXRunner.Eval(const AExpr: WideString): OleVariant;
var
  enfo: EXCEPINFO;
begin
  Result := Null;
  try
    FErrorHolder.ClearScriptError;
    FScriptParse.ParseScriptText(PWideChar(AExpr),
                                 nil, nil, nil, 0, 0,
                                 SCRIPTTEXT_ISEXPRESSION,
                                 Result, enfo);
  except
    on E: EOleSysError do
    begin
      FErrorHolder.CheckScriptError;
      DispCallCheck(E.ErrorCode, enfo); // For sure.
    end;
  end;
end;

function TActiveXRunner.Eval(APreparedExpr: TObject): OleVariant;
begin
  Result := Eval(TAXDynCode(APreparedExpr).FText);
end;

procedure TActiveXRunner.ExecStmt(const AStmt: WideString);
var
  enfo:  EXCEPINFO;
  Dummy: OleVariant;
begin
  try
    FErrorHolder.ClearScriptError;
    FScriptParse.ParseScriptText(PWideChar(AStmt),
                                 nil, nil, nil, 0, 0, 0,
                                 Dummy, enfo);
  except
    on E: EOleSysError do
    begin
      FErrorHolder.CheckScriptError;
      DispCallCheck(E.ErrorCode, enfo); // For sure.
    end;
  end;
end;

procedure TAXScriptErrorHolder.FormatScriptError(var AMsg: WideString);
var
  err:  EXCEPINFO;
  sctx: LongWord;
  line: LongWord;
  pos:  Integer;
begin
  if FLastError <> nil then
  begin
    FLastError.RemoteGetExceptionInfo(err);
    FLastError.GetSourcePosition(sctx, line, pos);

    AMsg := err.bstrDescription;
    if FAddSrcInfo then
      LMDEncodeErrorMessageInfo(FSource, line, pos, AMsg);
  end;
end;

procedure TActiveXRunner.ExecStmt(APreparedStmt: TObject);
begin
  ExecStmt(TAXDynCode(APreparedStmt).FText);
end;

function TActiveXRunner.GetCodeObject: IDispatch;
begin
  Result := FCodeObject;
end;

function TActiveXRunner.GetDebugDocBlock: IDebugApplicationNode;
var
  appnd:   IDebugApplicationNode;
  nodes:   IEnumDebugApplicationNodes;
  fetched: DWORD;
begin
  FHelper.GetDebugApplicationNode(appnd);

  appnd.EnumChildren(nodes);

  nodes.RemoteNext(1, Result, fetched);
end;

function TActiveXRunner.GetLangKind: TLMDScriptLangKind;
begin
  Result := slkActiveX;
end;

procedure TActiveXRunner.GetSourceLineMetrix(ALine: Integer; out APos,
  ALength: Integer);
var
  appnd:            IDebugApplicationNode;
  doc:              IDebugDocument;
  text:             IDebugDocumentText;
  szlines, szchars: DWORD;
  pos, nextpos:     DWORD;
begin
  Assert(FAppDebugger <> nil);

  FHelper.GetDebugApplicationNode(appnd);

  appnd.GetDocument(doc);

  OleCheck(doc.QueryInterface(IDebugDocumentText, text));

  text.GetPositionOfLine(ALine, pos);
  text.GetSize(szlines, szchars);

  if ALine < Integer(szlines - 1) then
    text.GetPositionOfLine(ALine + 1, nextpos)
  else
    nextpos := szchars + 1;

  APos    := pos;
  ALength := nextpos - pos;
end;

procedure TActiveXRunner.Open;
begin
  FErrorHolder.ClearScriptError;
  try
    FScript.SetScriptState(SCRIPTSTATE_STARTED); // May not thew exception in
                                                 // case global code produces
                                                 // run-time error.
  finally
    FErrorHolder.CheckScriptError;
  end;
end;

procedure TActiveXRunner.Prepare(ARunnerDebug: TRunnerDebugBase);
var
  enfo:    EXCEPINFO;
  source,
  err:     WideString;
  asd:     IActiveScriptDebug;
  name:    WideString;
  hr:      HRESULT;
  clsid:   TGuid;
  obj:     IUnknown;
  origin:  IDispatch;
begin
  try
    source       := FSControl.FSource.Text;
    FAppDebugger := nil;
    FHelper      := nil;

    if ARunnerDebug <> nil then
    begin
      FRunnerDebug := TActiveXRunnerDebug(ARunnerDebug);
      FAppDebugger := FRunnerDebug.FAppDebugger;
    end;

    { Create and init script VM }

    name := EngineProdIDs[FSControl.FLanguage];
    err  := Format(SLMDScriptCantCreateEngine, [name]);

    LMDOleCheck(CLSIDFromProgID(PWideChar(name), clsid), False, err);
    obj := CreateComObject(clsid);

    LMDOleCheck(obj.QueryInterface(IID_IActiveScript, FScript), false, err);
    LMDOleCheck(FScript.QueryInterface(IID_IActiveScriptParse, FScriptParse),
                false, err);

    FScriptParse.InitNew;
    FScript.SetScriptSite(FSite);

    { Check debugging support }

    if FAppDebugger <> nil then
    begin
      hr := FScript.QueryInterface(IActiveScriptDebug, asd);
      LMDOleCheck(hr, False, SLMDDebuggingNotSupported);
    end;

    { Parse script source text }

    if FAppDebugger <> nil then
    begin
      GetPDM.CreateDebugDocumentHelper(nil, FHelper);

      FHelper.Init(FRunnerDebug.FApplication,
                   StringToOleStr('LMD Script Doc'),
                   StringToOleStr('LMD Script Doc'),
                   TEXT_DOC_ATTR_READONLY);
      FHelper.Attach(nil);

      DefineDebugDocBlock(source, FSourceContext);
    end
    else
      FSourceContext := 0;

    try
      FErrorHolder.ClearScriptError;
      FScriptParse.ParseScriptText(PWideChar(source),
                                   nil, nil, nil,
                                   FSourceContext,
                                   0, 0, POleVariant(nil)^,
                                   enfo);
    except
      on E: EOleSysError do
      begin
        FErrorHolder.CheckScriptError;
        DispCallCheck(E.ErrorCode, enfo); // For sure.
      end;
    end;

    { Define named-items and breakpoints }

    AddNamedObjectsToEngine(FSControl);
    FScript.AddNamedItem(PWideChar(ValuesHolderName), SCRIPTITEM_ISVISIBLE or
                                                      SCRIPTITEM_GLOBALMEMBERS);

    if FAppDebugger <> nil then
    begin
      FScript.AddNamedItem(PWideChar(ConditionCvtrName), 
                           SCRIPTITEM_ISVISIBLE);
      SetBreakpoints(FSControl, FRunnerDebug.FDebugger);
    end;

    { Create code object }

    FScript.GetScriptDispatch(nil, origin);

    FCodeObject := TAXCodeObject.Create(FErrorHolder, origin);
    FCodeObject._AddRef;
  except
    Close;
    raise;
  end;
end;

function TActiveXRunner.PrepareExpr(const AExpr: WideString): TObject;
begin
  Result := TAXDynCode.Create(AExpr);
end;

function TActiveXRunner.PrepareStmt(const AStmt: WideString): TObject;
begin
  Result := TAXDynCode.Create(AStmt);
end;

function TActiveXRunner.ReadVar(const Name: TLMDString): OleVariant;
var
  cobj:   IDispatch;
  wname:  WideString;
  id:     Integer;
  params: TDispParams;
  enfo:   tagExcepInfo;
  hr:     HRESULT;
begin
  cobj  := GetCodeObject;
  wname := Name;

  OleCheck(cobj.GetIDsOfNames(GUID_NULL, @wname, 1, 0, @id));

  with params do
  begin
    rgvarg            := nil;
    rgdispidNamedArgs := nil;
    cArgs             := 0;
    cNamedArgs        := 0;
  end;

  FErrorHolder.ClearScriptError;
  hr := cobj.Invoke(id, GUID_NULL, 0, DISPATCH_PROPERTYGET,
                    params, @Result, @enfo, nil);
  if hr <> S_OK then
  begin
    FErrorHolder.CheckScriptError;
    DispCallCheck(hr, enfo); // For sure.
  end;
end;

function TActiveXRunner.RunProc(const Name: TLMDString;
  const Args: array of OleVariant): OleVariant;
const
  MAX_ARG_COUNT = 64;
var
  cobj:   IDispatch;
  wname:  WideString;
  i:      Integer;
  id:     Integer;
  parghi: Integer;
  pargs:  array[0..MAX_ARG_COUNT - 1] of TVariantArg;
  params: TDispParams;
  enfo:   tagExcepInfo;
  hr:     HRESULT;
begin
  cobj  := GetCodeObject;
  wname := Name;

  OleCheck(cobj.GetIDsOfNames(GUID_NULL, @wname, 1, 0, @id));

  parghi := High(Args);
  if parghi > MAX_ARG_COUNT - 1 then
    raise EOleSysError.Create(SLMDTooManyParams, E_INVALIDARG, -1);

  for i := 0 to parghi do
    pargs[parghi - i] := PVariantArg(@Args[i])^; // Arguments should be treated
                                                 // by IDispatch as readonly,
                                                 // so we just copy memory,
                                                 // without add-refs/releases.
  with params do
  begin
    rgvarg            := @pargs[0];
    rgdispidNamedArgs := nil;
    cArgs             := parghi + 1;
    cNamedArgs        := 0;
  end;

  FErrorHolder.ClearScriptError;
  hr := cobj.Invoke(id, GUID_NULL, 0, DISPATCH_METHOD,
                    params, @Result, @enfo, nil);
  if hr <> S_OK then
  begin
    FErrorHolder.CheckScriptError;
    DispCallCheck(hr, enfo); // For sure.
  end;
end;

procedure TActiveXRunner.WriteVar(const Name: TLMDString;
  const Value: OleVariant);
const
  NamedArgs: Longint = DISPID_PROPERTYPUT;
var
  wname:      WideString;
  cobj:       IDispatch;
  id:         Integer;
  enfo:       tagExcepInfo;
  params:     TDispParams;
  hr:         HRESULT;
begin
  cobj  := GetCodeObject;
  wname := Name;

  OleCheck(cobj.GetIDsOfNames(GUID_NULL, @wname, 1, 0, @id));

  with params do
  begin
    rgvarg            := @Value;
    rgdispidNamedArgs := @NamedArgs;
    cNamedArgs        := 1;
    cArgs             := 1;
  end;

  FErrorHolder.ClearScriptError;
  hr := cobj.Invoke(id, GUID_NULL, 0, DISPATCH_PROPERTYPUT,
                    params, nil, @enfo, nil);
  if hr <> S_OK then
  begin
    FErrorHolder.CheckScriptError;
    DispCallCheck(hr, enfo); // For sure.
  end;
end;

function TActiveXRunner.RunProc(const Name: TLMDString): OleVariant;
var
  cobj:   IDispatch;
  wname:  WideString;
  id:     Integer;
  params: TDispParams;
  enfo:   tagExcepInfo;
  hr:     HRESULT;
begin
  cobj  := GetCodeObject;
  wname := Name;

  OleCheck(cobj.GetIDsOfNames(GUID_NULL, @wname, 1, 0, @id));

  with params do
  begin
    rgvarg            := nil;
    rgdispidNamedArgs := nil;
    cArgs             := 0;
    cNamedArgs        := 0;
  end;

  FErrorHolder.ClearScriptError;
  hr := cobj.Invoke(id, GUID_NULL, 0, DISPATCH_METHOD,
                    params, @Result, @enfo, nil);
  if hr <> S_OK then
  begin
    FErrorHolder.CheckScriptError;
    DispCallCheck(hr, enfo); // For sure.
  end;
end;

{ TNativeRunner }

procedure TNativeRunner.AddNamedObjectToEngine(AItem: TNamedItem);
begin
  FVM.AddExternObject(AItem.Value, AItem.Name, AItem.PubMembers);
end;

procedure TNativeRunner.AdjustBreakpoint(ALine: Integer;
  AEnabled, ADelete: Boolean; out AIsValid: Boolean);
begin
  if not ADelete then
  begin
    AIsValid := True;
    if AEnabled then
      AIsValid := FVM.SetBreakpoint(ALine)
    else
      FVM.RemoveBreakpoint(ALine);
  end
  else
  begin
    AIsValid := False;
    FVM.RemoveBreakpoint(ALine);
  end;
end;

procedure TNativeRunner.Close;
begin
  if FVM <> nil then
  begin
    FVM.Close;
    FVM.Free;
    FVM          := nil;
    FRunnerDebug := nil;
    FPasDebugger := nil;
  end;
end;

constructor TNativeRunner.Create(ASControl: TLMDScriptControl;
  AAddSrcInfo: Boolean);
begin
  inherited Create;
  FSControl   := ASControl;
  FAddSrcInfo := AAddSrcInfo;
end;

destructor TNativeRunner.Destroy;
begin
  Close;
  inherited;
end;

function TNativeRunner.Eval(const AExpr: WideString): OleVariant;
begin
  Result := FVM.Eval(AExpr);
end;

function TNativeRunner.Eval(APreparedExpr: TObject): OleVariant;
begin
  Result := FVM.Eval(APreparedExpr);
end;

procedure TNativeRunner.EventMakeProc(Sender: TObject;
  const AProcName: WideString; var V: OleVariant);
begin
  V := TLMDEventWrapper.ToVar(FSControl, AProcName);
end;

procedure TNativeRunner.ExcIsTestProc(Sender: TObject; E: Exception;
  AType: OleVariant; var AResult: Boolean);
begin
  AResult := VarObjectIs(E, AType);
end;

procedure TNativeRunner.ExcToVarProc(Sender: TObject; const E: Exception;
  var V: OleVariant);
begin
  V := TObject_sw.ToVar(E);
end;

procedure TNativeRunner.ExecStmt(const AStmt: WideString);
begin
  FVM.ExecStmt(AStmt);
end;

procedure TNativeRunner.ExecStmt(APreparedStmt: TObject);
begin
  FVM.ExecStmt(APreparedStmt);
end;

procedure TNativeRunner.FormatExcProc(Sender: TObject; ALine,
  ALinePos: Integer; const E: Exception);
var
  s: WideString;
begin
  s := E.Message;
  LMDEncodeErrorMessageInfo(FSControl, ALine, ALinePos, s);
  E.Message := s;
end;

function TNativeRunner.GetCodeObject: IDispatch;
begin
  Result := FVM.CodeObject;
end;

function TNativeRunner.GetLangKind: TLMDScriptLangKind;
begin
  Result := slkNative;
end;

procedure TNativeRunner.IsTestProc(Sender: TObject; const AObj,
  AType: OleVariant; var AResult: Boolean);
begin
  AResult := VarObjOrRecIs(AObj, AType);
end;

procedure TNativeRunner.New(Sender: TObject; const AType: OleVariant;
  AArgs: PLMDVarArray; AArgCount: Integer; var AResult: OleVariant);
begin
  AResult := VarObjOrRecNew(AType, AArgs, AArgCount);
end;

procedure TNativeRunner.Open;
begin
  FVM.Open(FPasDebugger);
end;

procedure TNativeRunner.Prepare(ARunnerDebug: TRunnerDebugBase);
var
  source: WideString;
  lang:   ILMDLanguage;
begin
  case FSControl.FLanguage of
    slPascal:   lang := TLMDPasLanguage.Create;
    slNativeVb: lang := TLMDVbLanguage.Create;
  else
    lang := nil; // Initialize.
    Assert(False);
  end;


  FVM := TLMDVirtMachine.Create(lang);
  try
    source       := FSControl.FSource.Text;
    FPasDebugger := nil;

    if ARunnerDebug <> nil then
    begin
      FRunnerDebug := TNativeRunnerDebug(ARunnerDebug);
      FPasDebugger := FRunnerDebug.FPasDebugger;
    end;

    FVM.OnIsTest            := IsTestProc;
    FVM.OnExceptionIsTest   := ExcIsTestProc;
    FVM.OnVarToException    := VarToExcProc;
    FVM.OnExceptionToVar    := ExcToVarProc;
    FVM.OnEventMake         := EventMakeProc;
    FVM.OnNew               := New;
    if FAddSrcInfo then
      FVM.OnFormatException := FormatExcProc;

    FVM.Initialize(source);

    AddNamedObjectsToEngine(FSControl);
    FVM.AddExternObject(FSControl.FNamedValuesHolder as IDispatch,
                        ValuesHolderName, True);

    if FRunnerDebug <> nil then
      SetBreakpoints(FSControl, FRunnerDebug.FDebugger);
  except
    Close;
    raise; 
  end;
end;

function TNativeRunner.PrepareExpr(const AExpr: WideString): TObject;
begin
  Result := FVM.PrepareExpr(AExpr);
end;

function TNativeRunner.PrepareStmt(const AStmt: WideString): TObject;
begin
  Result := FVM.PrepareStmt(AStmt);
end;

function TNativeRunner.ReadVar(const Name: TLMDString): OleVariant;
begin
  Result := FVM.ReadVar(Name);
end;

function TNativeRunner.RunProc(const Name: TLMDString;
  const Args: array of OleVariant): OleVariant;
begin
  Result := FVM.RunProc(Name, Args);
end;

function TNativeRunner.RunProc(const Name: TLMDString): OleVariant;
begin
  Result := FVM.RunProc(Name);
end;

procedure TNativeRunner.VarToExcProc(Sender: TObject; const V: OleVariant;
  var E: Exception);
var
  obj: TObject;
begin
  obj := TObject_sw.FromVar(V);
  if obj is Exception then
    E := Exception(obj);
end;

procedure TNativeRunner.WriteVar(const Name: TLMDString;
  const Value: OleVariant);
begin
  FVM.WriteVar(Name, Value);
end;

{ TRunnerBase }

procedure TRunnerBase.AddNamedObjectsToEngine(ACtrl: TLMDScriptControl);
var
  i:     Integer;
  items: TList;
begin
  items := TList.Create;
  try
    ACtrl.FNamedItems.GetAll(items);

    for i := 0 to items.Count - 1 do
    begin
      if TNamedItem(items[i]).Kind = nikObject then
        AddNamedObjectToEngine(TNamedItem(items[i]));
    end;
  finally
    items.Free;
  end;
end;

procedure TRunnerBase.SetBreakpoints(ACtrl: TLMDScriptControl;
  ADebugger: TLMDScriptDebugger);
var
  i: Integer;
begin
  for i := 0 to ADebugger.BreakpointCount - 1 do
  begin
    if ADebugger.Breakpoints[i].FModule = ACtrl.FDebugModule then
      ADebugger.AdjustBreakpoint(ADebugger.Breakpoints[i], abkSet);
    ADebugger.DoBreakpointsChanged;
  end;
end;

{ TAXScriptErrorHolder }

function TAXScriptErrorHolder.AddRef: TAXScriptErrorHolder;
begin
  Inc(FRefCount);
  Result := Self;
end;

procedure TAXScriptErrorHolder.Release;
begin
  Dec(FRefCount);
  if FRefCount <= 0 then
    Free;
end;

procedure TAXScriptErrorHolder.SetError(AError: IActiveScriptError);
begin
  FLastError := AError;
end;

constructor TAXScriptErrorHolder.Create(AAddSrcInfo: Boolean;
  ASource: TObject);
begin
  inherited Create;
  FAddSrcInfo := AAddSrcInfo;
  FSource     := ASource;
end;

destructor TAXCodeObject.Destroy;
begin
  FErrorHolder.Release;
  inherited;
end;

procedure TLMDScriptControl.ValidateDebugger(
  ALanguage: TLMDScriptLanguage; ADebugger: TLMDScriptDebugger);
var
  i:    Integer;
  scpt: TLMDScriptControl;
begin
  for i := 0 to ADebugger.FScripts.Count - 1 do
  begin
    scpt := TLMDScriptControl(ADebugger.FScripts[i]);
    if (scpt <> Self) and (LMDScriptLangKinds[scpt.FLanguage] <>
                           LMDScriptLangKinds[ALanguage]) then
      raise ELMDScriptControl.Create(SLMDCannotMixDebuggers);
  end;
end;

procedure TLMDScriptControl.WriteVar(const Name: TLMDString;
  const Value: OleVariant);
begin
  CheckState([ssActive]);
  TRunnerBase(FRunner).WriteVar(Name, Value);
end;

function TLMDScriptControl.PrepareExpr(
  const AExpression: TLMDString): TObject;
begin
  CheckState([ssPrepared, ssActive]);
  Result := TRunnerBase(FRunner).PrepareExpr(AExpression);
end;

function TLMDScriptControl.PrepareStmt(
  const AStatement: TLMDString): TObject;
begin
  CheckState([ssPrepared, ssActive]);
  Result := TRunnerBase(FRunner).PrepareStmt(AStatement);
end;

function TLMDScriptControl.Eval(APreparedExpr: TObject): OleVariant;
begin
  CheckState([ssActive]);
  Result := TRunnerBase(FRunner).Eval(APreparedExpr);
end;

procedure TLMDScriptControl.ExecuteStatement(APreparedStmt: TObject);
begin
  CheckState([ssActive]);
  TRunnerBase(FRunner).ExecStmt(APreparedStmt);
end;

{ TAXDynCode }

constructor TAXDynCode.Create(AText: WideString);
begin
  inherited Create;
  FText := AText;
end;

{ TActiveXRunnerDebug }

procedure TActiveXRunnerDebug.CauseBreak;
begin
  FApplication.CauseBreak;
end;

constructor TActiveXRunnerDebug.Create(ADebugger: TLMDScriptDebugger);
begin
  inherited Create;

  FDebugger    := ADebugger;
  FAppDebugger := TAXAppDebugger.Create(Self);
  FAppDebugger._AddRef;
  Init;
end;

destructor TActiveXRunnerDebug.Destroy;
begin
  Fin;
  FAppDebugger._Release;
  
  inherited;
end;

procedure TLMDScriptDebugger.AdjustRunnerDebug;
begin
  if (FRunnerDebug <> nil) and ((FScripts.Count = 0) or
                                (LMDScriptLangKinds[TLMDScriptControl(
                                                    FScripts[0]).FLanguage] <>
                                 TRunnerDebugBase(FRunnerDebug).GetLangKind)) then
  begin
    FRunnerDebug.Free;
    FRunnerDebug := nil;
  end;

  if (FRunnerDebug = nil) and (FScripts.Count > 0) then
  begin
    case LMDScriptLangKinds[TLMDScriptControl(FScripts[0]).FLanguage] of
      slkActiveX: FRunnerDebug := TActiveXRunnerDebug.Create(Self);
      slkNative:  FRunnerDebug := TNativeRunnerDebug.Create(Self);
    end;
  end;
end;

procedure TLMDScriptDebugger.ScriptDebugModuleChanged(AItem: TLMDScriptControl);
var
  i:   Integer;
  lst: TList;
begin
  if not (csDestroying in ComponentState) then
  begin
    { Internal notifiers }

    for i := 0 to FNotifiers.Count - 1 do
      ILMDScriptDebuggerNotifier(FNotifiers[i]).DebugNameChanged(Self, AItem);

    { Services notifiers }

    if FServiceProvider <> nil then
    begin
      lst := FServiceProvider.Notifiers.GetList(ILMDScriptDebuggerNotifier);
      try
        for i := 0 to lst.Count - 1 do
          ILMDScriptDebuggerNotifier(lst[i]).DebugNameChanged(Self, AItem);
      finally
        lst.Free;
      end;
    end;
  end;
end;

procedure TLMDScriptDebugger.ScriptItemLangChanged(
  AItem: TLMDScriptControl);
begin
  AdjustRunnerDebug;
end;

procedure TActiveXRunnerDebug.Eval(ARunnerFrame: TObject;
  const AExpr: TLMDString; AProc: TVarProc);
var
  frame:   IDebugStackFrame;
  exp:     IDebugExpression;
  prop:    IDebugProperty;
  exphres: HResult;
begin
  frame  := TAXRunnerFrame(ARunnerFrame).Data.pdsf;
  exp    := DoEval(frame, AExpr);

  exp.GetResultAsDebugProperty(exphres, prop);
  LMDOleCheck(exphres);

  FillVar(prop, AProc);
end;

function TActiveXRunnerDebug.DoEval(AFrame: IDebugStackFrame;
  const AExpression: WideString): IDebugExpression;
var
  expctx:  IDebugExpressionContext;
  expcbs:  TAXExprCallBack;
begin
  Result := nil;

  OleCheck(AFrame.QueryInterface(IDebugExpressionContext, expctx));
  expctx.ParseLanguageText(PWideChar(AExpression), 10, nil,
                           DEBUG_TEXT_RETURNVALUE or DEBUG_TEXT_ISEXPRESSION,
                           Result);

  expcbs := TAXExprCallBack.Create;
  try
    Result.Start(expcbs);
    expcbs.WaitFor;
  finally
    expcbs.Free;
  end;
end;

function TActiveXRunnerDebug.Eval(ARunnerFrame: TObject;
  const AExpr: TLMDString): TLMDString;
var
  frame:   IDebugStackFrame;
  exp:     IDebugExpression;
  exphres: HResult;
  wres:    WideString;
begin
  Result := '';
  frame  := TAXRunnerFrame(ARunnerFrame).Data.pdsf;
  exp    := DoEval(frame, AExpr);

  exp.GetResultAsString(exphres, wres);
  LMDOleCheck(exphres);

  Result := wres;
end;

procedure TActiveXRunnerDebug.Fin;
begin
  if FApplication <> nil then
  begin
    FApplication.DisconnectDebugger;
    FApplication := nil;
  end;
end;

function TActiveXRunnerDebug.FindScriptControl(
  const ADocument: IDebugDocument): TLMDScriptControl;
var
  i:      Integer;
  script: TLMDScriptControl;
  block:  IDebugApplicationNode;
  doc:    IDebugDocument;
begin
  for i := 0 to FDebugger.FScripts.Count - 1 do
  begin
    script := TLMDScriptControl(FDebugger.FScripts[i]);

    block := nil;
    if script.FRunner <> nil then
      block := TActiveXRunner(script.FRunner).GetDebugDocBlock;

    doc := nil;
    if block <> nil then
      block.GetDocument(doc);

    if doc = ADocument then
    begin
      Result := script;
      Exit;
    end;
  end;

  Result := nil;
end;

function TActiveXRunnerDebug.GetLangKind: TLMDScriptLangKind;
begin
  Result := slkActiveX;
end;

function TActiveXRunnerDebug.GetLongDescription(
  ARunnerFrame: TObject): TLMDString;
var
  frame: IDebugStackFrame;
  wres:  WideString;
begin
  Result := '';
  frame  := TAXRunnerFrame(ARunnerFrame).Data.pdsf;

  frame.GetDescriptionString(Integer(True), wres);
  Result := wres;
end;

function TActiveXRunnerDebug.GetShortDescription(
  ARunnerFrame: TObject): TLMDString;
var
  frame: IDebugStackFrame;
  wres:  WideString;
begin
  Result := '';
  frame  := TAXRunnerFrame(ARunnerFrame).Data.pdsf;

  frame.GetDescriptionString(Integer(False), wres);
  wres := Result;
end;

procedure TActiveXRunnerDebug.GetVars(ARunnerFrame: TObject;
  AProc: TVarProc);
var
  frame: IDebugStackFrame;
  prop:  IDebugProperty;
begin
  frame := TAXRunnerFrame(ARunnerFrame).Data.pdsf;
  frame.GetDebugProperty(prop);

  FillVar(prop, AProc);
end;

procedure TActiveXRunnerDebug.Init;
//var
//  appcce: DWORD;
begin
  GetPDM.CreateApplication(FApplication);
  FApplication.SetName(StringToOleStr('LMD Debug Application'));
 // GetPDM.AddApplication(FApplication, appcce); // Windows7 reports "Access
                                                 // denied here. But, likely
                                                 // all things works even without
                                                 // AddApplication call. May be
                                                 // this way is even better.
  FApplication.ConnectDebugger(FAppDebugger);
end;

procedure TActiveXRunnerDebug.ResumeFromBreak(AKind: TLMDBreakResumeKind);
const
  BREAK_ACTIONS: array[TLMDBreakResumeKind] of tagBREAKRESUMEACTION = (
    BREAKRESUMEACTION_STEP_OVER, // rkStepOver
    BREAKRESUMEACTION_STEP_INTO, // rkStepInto
    BREAKRESUMEACTION_CONTINUE,  // rkContinue
    BREAKRESUMEACTION_ABORT      // rkAbort
  );
var
  app: IRemoteDebugApplication;
  trd: IRemoteDebugApplicationThread;
begin
  Assert(FBreakThread <> nil);

  trd          := FBreakThread;
  FBreakThread := nil;

  trd.GetApplication(app);
  app.ResumeFromBreakPoint(trd, BREAK_ACTIONS[AKind],
                           ERRORRESUMEACTION_SkipErrorStatement);
end;

procedure TLMDScriptDebugger.AdjustBreakpoint(BP: TLMDBreakpoint;
  AAdjustKind: TLMDAdjustBPKind; AOldLine: Integer);
var
  sctlst:  TList;
  i:       Integer;
  sct:     TLMDScriptControl;
  isvalid: Boolean;
begin
  sctlst := TList.Create;
  try
    for i := 0 to FScripts.Count - 1 do
    begin
      sct := TLMDScriptControl(FScripts[i]);
      if sct.FDebugModule = BP.FModule then
        sctlst.Add(sct);
    end;

    BP.FValid := True;

    for i := 0 to sctlst.Count - 1 do
    begin
      sct := TLMDScriptControl(sctlst[i]);

      if sct.FRunner <> nil then
      begin
        if AAdjustKind = abkCorrectLine then
          TRunnerBase(sct.FRunner).AdjustBreakpoint(AOldLine, True,
                                                    True, isvalid);
        TRunnerBase(sct.FRunner).AdjustBreakpoint(BP.FLine, BP.FEnabled,
                                                  (AAdjustKind = abkRemove),
                                                  isvalid);
        if not isvalid then
          BP.FValid := False;
          
        if (AAdjustKind <> abkRemove) and not isvalid then
          DoInvalidBreakpoint(BP);
      end;
    end;
  finally
    sctlst.Free;
  end;
end;

procedure TActiveXRunnerDebug.FillVar(const AProp: IDebugProperty;
  AProc: TVarProc);
const
  AXFLAGS: array[TLMDVariableFlag] of DWORD = (
    DBGPROP_ATTRIB_VALUE_READONLY,       // vfReadonly
    DBGPROP_ATTRIB_ACCESS_PUBLIC,        // vfPublic
    DBGPROP_ATTRIB_ACCESS_PRIVATE,       // vfPrivate
    DBGPROP_ATTRIB_ACCESS_PROTECTED,     // vfProtected
    DBGPROP_ATTRIB_ACCESS_FINAL,         // vfFinal
    DBGPROP_ATTRIB_STORAGE_GLOBAL,       // vfGlobal
    DBGPROP_ATTRIB_STORAGE_STATIC,       // vfStatic
    DBGPROP_ATTRIB_STORAGE_FIELD,        // vfField
    DBGPROP_ATTRIB_STORAGE_VIRTUAL,      // vfVirtual
    DBGPROP_ATTRIB_TYPE_IS_CONSTANT,     // vfConstant
    DBGPROP_ATTRIB_TYPE_IS_SYNCHRONIZED, // vfSynchronized
    DBGPROP_ATTRIB_TYPE_IS_VOLATILE      // vfVolatile
  );
var
  pnfo:    tagDebugPropertyInfo;
  i:       TLMDVariableFlag;
  flags:   TLMDVariableFlags;
  expnd:   Boolean;
  rvar:    IUnknown;
begin
  AProp.GetPropertyInfo(DBGPROP_INFO_STANDARD, 10, pnfo);

  flags := [];
  for i := Low(TLMDVariableFlag) to High(TLMDVariableFlag) do
    if (pnfo.m_dwAttrib and AXFLAGS[i]) <> 0 then
      Include(flags, i);

  rvar  := nil;
  expnd := ((pnfo.m_dwAttrib and DBGPROP_ATTRIB_VALUE_IS_EXPANDABLE) <> 0);
  if expnd then
    rvar := AProp;

  AProc(rvar, pnfo.m_bstrName, pnfo.m_bstrType,
        pnfo.m_bstrValue, flags, expnd);
end;

procedure TActiveXRunnerDebug.GetVarChildren(const ARunnerVar: IInterface;
  AProc: TVarProc);
var
  prop:    IDebugProperty;
  i:       Integer;
  cnt:     Cardinal;
  pnfo:    tagDebugPropertyInfo;
  members: IEnumDebugPropertyInfo;
  fetched: DWORD;
begin
  if ARunnerVar <> nil then
  begin
    prop := ARunnerVar as IDebugProperty;

    prop.EnumMembers(DBGPROP_INFO_DEBUGPROP,
                     10, IID_IEnumDebugPropertyInfo,
                     members);

    members.GetCount(cnt);
    for i := 0 to cnt - 1 do
    begin
      members.RemoteNext(1, pnfo, fetched);
      if fetched = 1 then // For sure.
        FillVar(pnfo.m_pDebugProp, AProc);
    end;
  end;
end;

procedure TLMDVariable.FillItems;
var
  rdebug: TRunnerDebugBase;
begin
  try
    rdebug := TRunnerDebugBase(FOwner.FDebugger.FRunnerDebug);
    rdebug.GetVarChildren(FRunnerVar, AddItemProc);

    FItemsFilled := True;
  except
    ClearItems;
    raise;
  end;
end;

procedure TLMDVariable.AddItemProc(const ARunnerVar: IInterface;
  const AName, AType, AValue: TLMDString; AFlags: TLMDVariableFlags;
  AExpandable: Boolean);
var
  var_: TLMDVariable;
begin
  var_ := TLMDVariable.Create(FOwner, Self, ARunnerVar, Aname,
                              AType, AValue, AFlags, AExpandable);
  FItems.Add(var_);
end;

procedure TLMDScriptDebugger.HandleBreak(ABreakKind: TLMDBreakKind;
  AScript: TLMDScriptControl; ALine: Integer);
begin
  FBreakKind := ABreakKind;
  DoBreakpoint(AScript, ALine);
end;

procedure TActiveXRunnerDebug.GetStackFrames(AProc: TGetFrameProc);
var
  frames:  IEnumDebugStackFrames;
  frame:   tagDebugStackFrameDescriptor;
  fetched: DWORD;
  doc:     IDebugDocument;
  line:    Integer;
  script:  TLMDScriptControl;
  fdobj:   TAXRunnerFrame;
begin
  Assert(FBreakThread <> nil);
  FBreakThread.EnumStackFrames(frames);

  fetched := 1;
  while fetched > 0 do
  begin
    frames.RemoteNext(1, frame, fetched);

    if fetched = 1 then
    begin
      GetBreakParams(frame, doc, line);

      script := FindScriptControl(doc);
      Assert(script <> nil);

      fdobj      := TAXRunnerFrame.Create;
      fdobj.Data := frame;

      AProc(fdobj, True, script, line);
    end;
  end;
end;

{ TNativeRunnerDebug }

procedure TNativeRunnerDebug.CauseBreak;
begin
  FPasDebugger.CauseBreak;
end;

constructor TNativeRunnerDebug.Create(ADebugger: TLMDScriptDebugger);
begin
  inherited Create;
  FDebugger            := ADebugger;
  FPasDebugger         := TLMDVMDebugger.Create;
  FPasDebugger.OnBreak := DebuggerBreak;
end;

procedure TNativeRunnerDebug.DebuggerBreak(Sender: TObject;
  ABreakKind: TLMDVMBreakKind; AVM: TLMDVirtMachine; ALine: Integer;
  ACallStack: TLMDPasStackFrames; var AResumeKind: TLMVMDResumeKind);
const
  BREAKKINDS: array[TLMDVMBreakKind] of TLMDBreakKind = (
    bkBreakpoint,     // LMDSctPasRuntime.bkBreakpoint
    bkStep,           // LMDSctPasRuntime.bkStep
    bkCausedBreak     // LMDSctPasRuntime.bkCausedBreak
  );
var
  script: TLMDScriptControl;
  brdt:   TNativeBreakData;
  bp:     TLMDBreakpoint;
begin
  script := FindScriptControl(AVM);
  bp     := FDebugger.FindBreakpoint(script.DebugModule, ALine);
  Assert(script <> nil);

  if IsSynchBreaks then
  begin
    brdt.TaskEvent  := nil;
    brdt.CallStack  := ACallStack;
    brdt.ResumeKind := LMDSctVM.rkContinue; // Default resume kind.
    FBreakData      := @brdt;
    try
      DoHandleBreak(ACallStack, BREAKKINDS[ABreakKind], script, ALine, bp);
      AResumeKind := brdt.ResumeKind;
    finally
      FBreakData := nil;
    end;
  end
  else
  begin
    brdt.TaskEvent := TEvent.Create(nil, False, False, '');
    try
      brdt.CallStack  := ACallStack;
      FBreakData      := @brdt;

      TNativeBreakpointThread.Create(Self, ACallStack, BREAKKINDS[ABreakKind],
                                  script, ALine, bp);
      while True do
      begin
        brdt.TaskEvent.WaitFor(INFINITE);

        if ExecBreakTask = trResume then
        begin
          AResumeKind := brdt.ResumeKind;
          Break; // while
        end;
      end;
    finally
      FBreakData := nil;
      brdt.TaskEvent.Free;
    end;
  end;
end;

destructor TNativeRunnerDebug.Destroy;
begin
  FPasDebugger.Free;
  inherited;
end;

procedure TNativeRunnerDebug.DoHandleBreak(ACallStack: TLMDPasStackFrames;
  ABreakKind: TLMDBreakKind; AScript: TLMDScriptControl; ALine: Integer;
  BP: TLMDBreakpoint);
var
  dbgr:     TLMDScriptDebugger;
  clearsck: Boolean;
  v:        OleVariant;
  vdt:      PVarData;
  s:        TLMDString;
  dv:       TLMDPasDebugVar;
  cnt:      Integer;
  i:        Integer;
  curpcnt:  Integer;
begin
  dbgr     := FDebugger;
  clearsck := True;

  try
    if (ABreakKind = bkBreakpoint) and (BP <> nil) then
    begin
      { Evaluate condition }

      if (BP.Condition <> '') and ACallStack[0].Eval(BP.Condition, v) then
      begin
        vdt := PVarData(VarResolveRef(v));
        if (vdt.VType <> varBoolean) or not vdt.VBoolean then
        begin
          FBreakData.ResumeKind := LMDSctVM.rkIgnore;
          Exit;
        end;
      end;

      { Handle PassCount }

      if BP.FPassCount > 0 then
      begin
        curpcnt := BP.CurrentPassCount;
        if curpcnt >= BP.FPassCount then
          curpcnt := 0;
        Inc(curpcnt);

        BP.InternalSetCrPassCount(curpcnt);
      end;

      dbgr.LogDebugMsg(dmBreakpointReached, BP);

      if BP.CurrentPassCount < BP.FPassCount then
      begin
        FBreakData.ResumeKind := LMDSctVM.rkIgnore;
        Exit;
      end;

      { Log message }

      if BP.Action.LogMessage <> '' then
        dbgr.LogDebugMsg(dmLogMessage, BP);

      { Eval expression }

      if BP.Action.EvalExpression <> '' then
      begin
        s := BP.Action.EvalExpression;
        ACallStack[0].Eval(s, dv);

        dbgr.LogDebugMsg(dmEvalExpr, BP, dv.Value);
      end;

      { Log stack frames }

      if BP.Action.LogStackFrames > 0 then
      begin
        dbgr.FLoggingStack := True;
        try
          dbgr.LogDebugMsg(dmLogStackHeader, BP);

          cnt := dbgr.StackFrameCount;
          if cnt > BP.Action.LogStackFrames then
            cnt := BP.Action.LogStackFrames;

          for i := 0 to cnt - 1 do
          begin
            dbgr.LogDebugMsg(dmLogStackFrame, BP, '',
                             dbgr.StackFrames[i]);
          end;
        finally
          dbgr.FLoggingStack := False;
        end;
      end;

      { Enable/disable group }

      s := BP.Action.EnableGroup;
      if s <> '' then
        dbgr.SetBreakpointGroupEnabled(s, True);

      s := BP.Action.DisableGroup;
      if s <> '' then
        dbgr.SetBreakpointGroupEnabled(s, False);

      { Is break required }

      if not BP.Action.Break then
      begin
        FBreakData.ResumeKind := LMDSctVM.rkIgnore;
        Exit;
      end;
    end;

    clearsck := False;
    dbgr.HandleBreak(ABreakKind, AScript, ALine);
  finally
    if clearsck then
      dbgr.ClearStackFrames;
  end;
end;

procedure TNativeRunnerDebug.Eval(ARunnerFrame: TObject;
  const AExpr: TLMDString; AProc: TVarProc);
var
  compl: TEvent;
begin
  Assert(FBreakData <> nil);
  compl := nil;

  if not IsSynchBreaks then
    compl := TEvent.Create(nil, False, False, '');
  try
    FBreakData.EvalFrame  := TLMDPasStackFrame(ARunnerFrame);
    FBreakData.EvalExpr   := AExpr;
    FBreakData.Complition := compl;
    FBreakData.Task       := btEval;

    if IsSynchBreaks then
      ExecBreakTask
    else
    begin
      FBreakData.TaskEvent.SetEvent;
      compl.WaitFor(INFINITE);
    end;
      
    FillVar(FBreakData.EvalRes, AProc);
  finally
    compl.Free;
  end;
end;

function TNativeRunnerDebug.Eval(ARunnerFrame: TObject;
  const AExpr: TLMDString): TLMDString;
var
  compl: TEvent;
begin
  Assert(FBreakData <> nil);
  compl := nil;

  if not IsSynchBreaks then
    compl := TEvent.Create(nil, False, False, '');
  try
    FBreakData.EvalFrame  := TLMDPasStackFrame(ARunnerFrame);
    FBreakData.EvalExpr   := AExpr;
    FBreakData.Complition := compl;
    FBreakData.Task       := btEval;

    if IsSynchBreaks then
      ExecBreakTask
    else
    begin
      FBreakData.TaskEvent.SetEvent;
      compl.WaitFor(INFINITE);
    end;

    Result := FBreakData.EvalRes.Value;
  finally
    compl.Free;
  end;
end;

function TNativeRunnerDebug.ExecBreakTask: TNativeRunnerTaskRes;
var
  compl: TEvent;
begin
  Result := trOk;
  
  case FBreakData.Task of
    btResume:     begin
                    Result := trResume;
                    Exit;
                  end;
    btGetVars:    FBreakData.EvalFrame.GetVariables(FBreakData.EvalRes);
    btEval:       FBreakData.EvalFrame.Eval(FBreakData.EvalExpr,
                                            FBreakData.EvalRes);
  end;

  if FBreakData.Complition <> nil then
  begin
    compl                 := FBreakData.Complition;
    FBreakData.Complition := nil;

    compl.SetEvent;
  end;
end;

procedure TNativeRunnerDebug.FillVar(const AVar: TLMDPasDebugVar;
  AProc: TVarProc);
begin
  // We always report [vfPublic] flags, like VBcript/JScript
  // for simplicity.

  AProc(AVar.Children, AVar.Name, AVar.Type_, AVar.Value, [vfPublic],
        (AVar.Children <> nil));
end;

function TNativeRunnerDebug.FindScriptControl(
  AVM: TLMDVirtMachine): TLMDScriptControl;
var
  i: Integer;
begin
  for i := 0 to FDebugger.FScripts.Count - 1 do
  begin
    Result := TLMDScriptControl(FDebugger.FScripts[i]);
    
    if (Result.FRunner <> nil) and
       (TNativeRunner(Result.FRunner).FVM = AVM) then
      Exit;
  end;

  Result := nil;
end;

function TNativeRunnerDebug.GetLangKind: TLMDScriptLangKind;
begin
  Result := slkNative;
end;

function TNativeRunnerDebug.GetLongDescription(
  ARunnerFrame: TObject): TLMDString;
begin
  Result := TLMDPasStackFrame(ARunnerFrame).Description;
end;

function TNativeRunnerDebug.GetShortDescription(
  ARunnerFrame: TObject): TLMDString;
begin
  Result := TLMDPasStackFrame(ARunnerFrame).Description;
end;

procedure TNativeRunnerDebug.GetStackFrames(AProc: TGetFrameProc);
var
  i:      Integer;
  script: TLMDScriptControl;
begin
  Assert(FBreakData <> nil);

  for i := 0 to FBreakData.CallStack.Count - 1 do
  begin
    script := FindScriptControl(FBreakData.CallStack[i].VM);
    Assert(script <> nil);

    AProc(FBreakData.CallStack[i], False, script,
          FBreakData.CallStack[i].Line);
  end;
end;

procedure TNativeRunnerDebug.GetVarChildren(const ARunnerVar: IInterface;
  AProc: TVarProc);
var
  children: ILMDPasDebugVarChildren;
begin
  if ARunnerVar <> nil then
  begin
    children := ILMDPasDebugVarChildren(ARunnerVar);
    children.Enum(VarChildProc, @TMethod(AProc));
  end;
end;

procedure TNativeRunnerDebug.GetVars(ARunnerFrame: TObject;
  AProc: TVarProc);
var
  compl: TEvent;
begin
  Assert(FBreakData <> nil);
  compl := nil;

  if not IsSynchBreaks then
    compl := TEvent.Create(nil, False, False, '');
  try
    FBreakData.EvalFrame  := TLMDPasStackFrame(ARunnerFrame);
    FBreakData.Complition := compl;
    FBreakData.Task       := btGetVars;

    if IsSynchBreaks then
      ExecBreakTask
    else
    begin
      FBreakData.TaskEvent.SetEvent;
      compl.WaitFor(INFINITE);
    end;

    FillVar(FBreakData.EvalRes, AProc);
  finally
    compl.Free;
  end;
end;

function TNativeRunnerDebug.IsSynchBreaks: Boolean;
begin
  Result := FDebugger.IsSynchBreaks;
end;

procedure TNativeRunnerDebug.ResumeFromBreak(AKind: TLMDBreakResumeKind);
const
  VMREUMEKINDS: array[TLMDBreakResumeKind] of TLMVMDResumeKind = (
    LMDSctVM.rkStepOver,   // rkStepOver
    LMDSctVM.rkStepInto,   // rkStepInto
    LMDSctVM.rkContinue,   // rkContinue
    LMDSctVM.rkAbort       // rkAbort
  );
begin
  Assert(FBreakData <> nil);

  FBreakData.ResumeKind := VMREUMEKINDS[AKind];
  FBreakData.Task       := btResume; 

  if IsSynchBreaks then
    ExecBreakTask // For sure.
  else
    FBreakData.TaskEvent.SetEvent;
end;

procedure TLMDScriptDebugger.UpdateStackFrames;
begin
  ClearStackFrames;
  TRunnerDebugBase(FRunnerDebug).GetStackFrames(AddStackFrameProc);
end;

procedure TNativeRunnerDebug.VarChildProc(const AVariable: TLMDPasDebugVar;
  ACookie: Pointer; var AStop: Boolean);
begin
  FillVar(AVariable, TVarProc(ACookie^));
end;

{ TNativeBreakpointThread }

constructor TNativeBreakpointThread.Create(ARunnerDebug: TNativeRunnerDebug;
  ACallStack: TLMDPasStackFrames; ABreakKind: TLMDBreakKind;
  AScriptControl: TLMDScriptControl; ALine: Integer; BP: TLMDBreakpoint);
begin
  inherited Create(True);
  
  FRunnerDebug   := ARunnerDebug;
  FCallStack     := ACallStack;
  FBreakKind     := ABreakKind;
  FScriptControl := AScriptControl;
  FLine          := ALine;
  FBP            := BP;

  FreeOnTerminate := True;
  Resume;
end;

procedure TNativeBreakpointThread.Execute;
begin
  FRunnerDebug.DoHandleBreak(FCallStack, FBreakKind, FScriptControl,
                             FLine, FBP);
end;

procedure TLMDScriptDebugger.CheckInBerak;
begin
  if (FBreakKind = bkNone) and not FLoggingStack then
    raise ELMDScriptControl.Create('Script debugger is not in break.');
end;

procedure TLMDScriptDebugger.SetIsSynchBreaks(const Value: Boolean);
begin
  Assert(FBreakKind = bkNone);
  FIsSynchBreaks := Value;
end;

procedure TLMDScriptDebugger.SetModules(const Value: TLMDDebugModules);
begin
  FModules.Assign(Value);
end;

procedure TLMDScriptDebugger.SetServiceProvider(
  const Value: TLMDServiceProvider);
begin
  if FServiceProvider <> Value then
  begin
    if FServiceProvider <> nil then
    begin
      FServiceProvider.RemoveFreeNotification(Self);
      FServiceProvider.Members.UnregisterMember(Self);
    end;

    FServiceProvider := Value;

    if FServiceProvider <> nil then
    begin
      FServiceProvider.FreeNotification(Self);
      FServiceProvider.Members.RegisterMember(Self);
    end;
  end;
end;

procedure TLMDVariables.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TLMDVariables.EndUpdate;
begin
  Dec(FUpdateCount);
  if (FUpdateCount <= 0) and (FChanged) then
    Changed;
end;

procedure TLMDVariables.Changed;
begin
  if FUpdateCount > 0 then
    FChanged := True
  else
  begin
    FChanged := False;
    DoChange;
  end;
end;

procedure TLMDVariables.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{ TAXBreakThread }

constructor TAXBreakThread.Create(AOwner: TAXAppDebugger;
  const AThread: IRemoteDebugApplicationThread; ABreakKind: TLMDBreakKind;
  AScript: TLMDScriptControl; ALine: Integer; ABreakpoint: TLMDBreakpoint);
begin
  inherited Create(True);

  FOwner      := AOwner;
  FThread     := AThread;
  FBreakKind  := ABreakKind;
  FScript     := AScript;
  FLine       := ALine;
  FBreakpoint := ABreakpoint;

  FreeOnTerminate := True;
  Resume;
end;

procedure TAXBreakThread.Execute;
begin
  FOwner.DoHandleBreak(FThread, FBreakKind, FScript, FLine, FBreakpoint);
end;

{ TAXConditionConverter }

function TAXConditionConverter.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := DISP_E_UNKNOWNNAME;
end;

function TAXConditionConverter.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TAXConditionConverter.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count  := 0;
  Result := S_OK;
end;

function TAXConditionConverter.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
var
  prms: PDispParams;
  v:    OleVariant;
  vdt:  PVarData;
begin
  prms := @Params;
  Assert((DispID = DISPID_VALUE) and (prms.cArgs = 1) and
         (prms.cNamedArgs = 0));

  v   := OleVariant(prms.rgvarg[0]);
  vdt := PVarData(VarResolveRef(v));

  if VarResult <> nil then
  begin
    if (vdt.VType = varBoolean) and vdt.VBoolean then
      OleVariant(VarResult^) := ConditionCvtrRes
    else
      OleVariant(VarResult^) := '';
  end;

  Result := S_OK;
end;

{ TLMDBreakpointAction }

constructor TLMDBreakpointAction.Create(ABP: TLMDBreakpoint);
begin
  inherited Create;
  FBP    := ABP;
  FBreak := True;
end;

procedure TLMDBreakpointAction.SetBreak(const Value: Boolean);
begin
  if FBreak <> Value then
  begin
    FBreak := Value;
    FBP.FDebugger.DoBreakpointsChanged;
  end;
end;

procedure TLMDBreakpointAction.SetDisableGroup(const Value: TLMDString);
begin
  if FDisableGroup <> Value then
  begin
    FDisableGroup := Value;
    FBP.FDebugger.DoBreakpointsChanged;
  end;
end;

procedure TLMDBreakpointAction.SetEnableGroup(const Value: TLMDString);
begin
  if FEnableGroup <> Value then
  begin
    FEnableGroup := Value;
    FBP.FDebugger.DoBreakpointsChanged;
  end;
end;

procedure TLMDBreakpointAction.SetEvalExpression(const Value: TLMDString);
begin
  if FEvalExpression <> Value then
  begin
    FEvalExpression := Value;
    FBP.FDebugger.DoBreakpointsChanged;
  end;
end;

procedure TLMDBreakpointAction.SetLogMessage(const Value: TLMDString);
begin
  if FLogMessage <> Value then
  begin
    FLogMessage := Value;
    FBP.FDebugger.DoBreakpointsChanged;
  end;
end;

procedure TLMDBreakpointAction.SetLogStackFrames(const Value: Integer);
begin
  if FLogStackFrames <> Value then
  begin
    FLogStackFrames := Value;
    FBP.FDebugger.DoBreakpointsChanged;
  end;
end;

{ TScriptSourceStrings }

procedure TScriptSourceStrings.Changing;
begin
  inherited;
  if FScript <> nil then
    FScript.SourceChanging;
end;

constructor TScriptSourceStrings.Create(AScript: TLMDScriptControl);
begin
  inherited Create;
  FScript := AScript;
end;

{ TNamedValuesHolder }

procedure TNamedValuesHolder.AddOrSet(const AName: WideString;
  AValue: POleVariant);
var
  item:  TNamedValuesHolderItem;
  uppnm: WideString;
begin
  uppnm := LMDWideUpperCase(AName);
  item  := TNamedValuesHolderItem(FNameMap.Find(uppnm));

  if item = nil then
  begin
    item         := TNamedValuesHolderItem.Create;
    item.UppName := uppnm;
    item.DispId  := FDispIdIndex.Count;

    FNameMap.Add(item);
    FDispIdIndex.Add(item);
  end;

  item.Value := AValue;
end;

constructor TNamedValuesHolder.Create;
begin
  inherited Create;
  FNameMap      := TLMDHashTable.Create(TNamedValuesHolderMapTraits, True);
  FDispIdIndex  := TList.Create;
  FDispIdIndex.Add(nil); // Skip zero DispId.
end;

destructor TNamedValuesHolder.Destroy;
begin
  FDispIdIndex.Free;
  FNameMap.Free;
  inherited;
end;

function TNamedValuesHolder.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
type
  PNamesArray   = ^TNamesArray;
  TNamesArray   = array [0..0] of PWideChar;
  PDispIdsArray = ^TDispIdsArray;
  TDispIdsArray = array [0..0] of Integer;
var
  i:     Integer;
  item:  TNamedValuesHolderItem;
  uppnm: WideString;
begin
  uppnm := LMDWideUpperCase(PNamesArray(Names)[0]);
  item  := TNamedValuesHolderItem(FNameMap.Find(uppnm));

  if item <> nil then
  begin
    PDispIdsArray(DispIds)[0] := item.DispId;
    Result                    := S_OK;
    Exit;
  end;

  for i := 0 to NameCount - 1 do
    PDispIdsArray(DispIds)[i] := DISPID_UNKNOWN;
  Result := DISP_E_UNKNOWNNAME;
end;

function TNamedValuesHolder.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TNamedValuesHolder.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count  := 0;
  Result := S_OK;
end;

function TNamedValuesHolder.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
var
  dargs: TDispParams absolute Params;
  item:  TNamedValuesHolderItem;
begin
  Result := S_OK;

  if (DispID <= 0) or (DispId >= FDispIdIndex.Count) then
  begin
    Result := DISP_E_MEMBERNOTFOUND;
    Exit;
  end;
  item := TNamedValuesHolderItem(FDispIdIndex[DispID]);

  if (Flags and DISPATCH_PROPERTYGET) <> 0 then
  begin
    if dargs.cArgs > 0 then
    begin
      Result := DISP_E_BADPARAMCOUNT;
      Exit;
    end;

    if VarResult <> nil then
      POleVariant(VarResult)^ := item.Value^;
  end
  else if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
  begin
    if dargs.cArgs <> 1 then
    begin
      Result := DISP_E_BADPARAMCOUNT;
      Exit;
    end;

    item.Value^ := OleVariant(dargs.rgvarg[0]);
  end
  else
    Result := DISP_E_TYPEMISMATCH;
end;

{ TNamedValuesHolderMapTraits }

class function TNamedValuesHolderMapTraits.Compare(const AKey;
  AItem: TObject): Boolean;
begin
  Result := (WideString(AKey) = TNamedValuesHolderItem(AItem).UppName);
end;

class function TNamedValuesHolderMapTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := MakeHashK(TNamedValuesHolderItem(AItem).UppName);
end;

class function TNamedValuesHolderMapTraits.MakeHashK(const AKey): Integer;
begin
  Result := TLMDHashTable.StrHash(WideString(AKey));
end;

constructor TLMDBreakpoint.Create(ADebugger: TLMDScriptDebugger;
  AModule: TLMDDebugModule; ALine: Integer);
begin
  inherited Create;

  FModule  := AModule;
  FLine    := ALine;
  FEnabled := True;
  FAction  := TLMDBreakpointAction.Create(Self);

  ADebugger.InsertBreakpointItem(Self);
end;

{ TLMDDebugModules }

function TLMDDebugModules.Add: TLMDDebugModule;
begin
  Result := TLMDDebugModule(inherited Add);
end;

function TLMDDebugModules.FindByName(const AName: TLMDString): TLMDDebugModule;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Items[i].Name = AName then
    begin
      Result := Items[i];
      Exit;
    end;

  Result := nil;
end;

function TLMDDebugModules.FindItemID(ID: Integer): TLMDDebugModule;
begin
  Result := TLMDDebugModule(inherited FindItemID(ID));
end;

function TLMDDebugModules.FindOrAdd(const AName: TLMDString): TLMDDebugModule;
begin
  Result := FindByName(AName);
  if Result = nil then
  begin
    Result      := Add;
    Result.Name := AName;
  end;
end;

function TLMDDebugModules.GetItem(Index: Integer): TLMDDebugModule;
begin
  Result := TLMDDebugModule(inherited Items[Index]);
end;

function TLMDDebugModules.Insert(Index: Integer): TLMDDebugModule;
begin
  Result := TLMDDebugModule(inherited Insert(Index));
end;

procedure TLMDDebugModules.SetItem(Index: Integer;
  const Value: TLMDDebugModule);
begin
  inherited Items[Index] := Value;
end;

procedure TLMDDebugModules.Update(Item: TCollectionItem);
begin
  inherited;
  TLMDScriptDebugger(Owner).DoBreakpointsChanged;
end;

{ TLMDDebugModule }

procedure TLMDDebugModule.Assign(Source: TPersistent);
begin
  if Source is TLMDDebugModule then
    Name := TLMDDebugModule(Source).Name
  else
    inherited;
end;

procedure TLMDDebugModule.Delete;
begin
  Free;
end;

destructor TLMDDebugModule.Destroy;
begin
  if Debugger <> nil then
    Debugger.ModuleDeleting(Self);
  inherited;
end;

function TLMDDebugModule.GetDebugger: TLMDScriptDebugger;
begin
  Result := nil;
  if Collection <> nil then
    Result := TLMDScriptDebugger(Collection.Owner);
end;

procedure TLMDDebugModule.SetName(const Value: TLMDString);
begin
  FName := Value;
  Changed(False);
end;

procedure TLMDScriptDebugger.MoveBreakpoints(
  const ABreakpoints: array of TLMDBreakpoint;
  const ANewLines: array of Integer);

  function _HasDuplicate(BP: TLMDBreakpoint): Boolean;
  var
    i: Integer;
  begin
    for i := 0 to FBreakpoints.Count - 1 do
      if (BP <> FBreakpoints[i]) and
         (BP.Module = TLMDBreakpoint(FBreakpoints[i]).Module) and
         (BP.Line = TLMDBreakpoint(FBreakpoints[i]).Line) then
      begin
        Result := True;
        Exit;
      end;

    Result := False;
  end;

var
  i:       Integer;
  oldlns:  array of Integer;
  hasdups: Boolean;
begin
  if Length(ABreakpoints) = 0 then
    Exit;
  SetLength(oldlns, Length(ABreakpoints));

  { Assign new lines }

  for i := 0 to High(ABreakpoints) do
  begin
    Assert(ABreakpoints[i].FDebugger = Self);

    oldlns[i]             := ABreakpoints[i].FLine;
    ABreakpoints[i].FLine := ANewLines[i];
  end;

  { Check for duplicates }

  hasdups := False;
  for i := 0 to High(ABreakpoints) do
  begin
    if _HasDuplicate(ABreakpoints[i]) then
    begin
      hasdups := True;
      Break; // for
    end;
  end;

  if hasdups then
  begin
    for i := 0 to High(ABreakpoints) do
      ABreakpoints[i].FLine := oldlns[i];
    raise ELMDScriptControl.Create('Duplicate breakpoint lines found.');
  end;

  { Adjust in runner }

  for i := 0 to High(ABreakpoints) do
    if ABreakpoints[i].Line <> oldlns[i] then
      AdjustBreakpoint(ABreakpoints[i], abkCorrectLine, oldlns[i]);

  DoBreakpointsChanged;
end;

function TLMDBreakpoint.GetIndex: Integer;
begin
  Result := -1;
  if FDebugger <> nil then
    Result := FDebugger.FBreakpoints.IndexOf(Self);
end;

function TLMDStackFrame.GetModule: TLMDDebugModule;
begin
  Result := nil;
  if FScriptControl <> nil then
    Result := FScriptControl.DebugModule;
end;

initialization
  {$IFDEF LMD_DEBUGTRACE}
    {$I C1.INC}
  {$ENDIF}

  {$IFNDEF LMDDISABLE_OLEINIT}
  OleInitialize(nil);
  {$ENDIF}
  PDMLock    := TCriticalSection.Create;
  SourceList := TList.Create;

{ ---------------------------------------------------------------------------- }

finalization
  FreeAndNil(SourceList);
  PDMLock.Free;
  PDMVar := nil;
  {$IFNDEF LMDDISABLE_OLEINIT}
  OleUninitialize;
  {$ENDIF}

{ ---------------------------------------------------------------------------- }

end.
