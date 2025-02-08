unit LMDSctVMByteCode;
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

LMDSctVMByteCode unit (YB)
--------------------------
LMD ScriptPack byte-code for native VM.

Changes
-------
Release 4.0 (March 2009)
 - Initial Release

###############################################################################}


interface

uses
  Windows, Classes, SysUtils, ActiveX, LMDTypes, LMDSctCst;

const
  LMD_SPOSMASK  = $7FFFFFFF; // 0111111...
  LMD_BREAKABLE = $80000000; // 1000000...
  ic_MASK       = $FF;       // Removed from TLMDInstrCode due to compilers
                             // internal error.   

type
  TLMDByteCode = class;
  TLMDTry      = class;

  {************************** TLMDAbstractNamespace ***************************}

  TLMDNameSearchResKind = (srNotFound, srExternal, srExternalMember, srUnit,
                           srGlobalVar, srGlobalConst, srProcedure, srLocalVar,
                           srLocalConst, srParam, srResult, srExit, srBreak,
                           srContinue, srIntrinsic, srDebugVar);

  TLMDParamKind = (pkSimple, pkConst, pkByRef);
  TLMDParamInfo = packed record // Used as Data in byte-code instruction,
                                // so, should be equal in size to Pointer
                                // size for both: x86 and x64 platforms.
    Index:  Word;
    Kind:   Word; // TLMDParamKind.
    {$IFDEF LMDX64}
    Unused: Integer;
    {$ENDIF}
  end;

  TLMDNameSearchRes = record
    ObjKind: TLMDNameSearchResKind;
    case TLMDNameSearchResKind of
      srExternal,
      srExternalMember,
      srGlobalVar,
      srGlobalConst,
      srProcedure,
      srExit,
      srBreak,
      srContinue,
      srIntrinsic:     (NamedObject: TObject;
                        case TLMDNameSearchResKind of
                          srExternalMember: (DispId: Integer);
                       );
      srLocalVar:      (LocalVarIndex: Integer);
      srLocalConst:    (LocalConst: POleVariant);
      srParam:         (ParamInfo: TLMDParamInfo);
      srResult:        (); // Nothing.
      srDebugVar:      (DebugVar: POleVariant);
  end;

  TLMDNamespaceEnumVarsProc = procedure(const ADisplayName: WideString;
                                        const ASRes: TLMDNameSearchRes) of object;

  TLMDAbstractNamespace = class
  private
    FParent: TLMDAbstractNamespace;
  public
    constructor Create(AParent: TLMDAbstractNamespace);

    function  Find(AThread: Pointer; AName: Integer;
                   AStrName: PWideString): TLMDNameSearchRes; virtual; abstract;
    procedure EnumDebugVars(ALocalsOnly: Boolean;
                            AProc: TLMDNamespaceEnumVarsProc); virtual; abstract;
    function  CompileTimeFind(AName: Integer): TLMDNameSearchRes; virtual;
    property  Parent: TLMDAbstractNamespace read FParent;
  end;

  {********************************* TLMDInstr ********************************}

  TLMDInstrCode =
  (
    icBreak = 0, // Used also as aborting cmd on VM closing.
                 // Used in bitmasks - sould be zero.
    icBreakpointJmp,
    icRet,
    icJump,
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
    icRefEqual,    // Vb "Is"
    icNotEqual,
    icRefNotEqual, // Vb "Is Not"
    icPlus,
    icStrConcat,
    icMinus,
    icImp,
    icEqv,
    icOr,
    icXor,
    icMultiply,
    icDivide,
    icIntDiv,
    icMod,
    icAnd,
    icShl,
    icShr,
    icPower,
    icUnaryPlus,
    icUnaryMinus,
    icUnaryNot,
    icJmpIfTrue,
    icJmpIfFalse,
    icPopJmpIfTrue,
    icPopJmpIfFalse,
    icPopJmpIfEqual,
    icPopJmpIfNotEqual,
    icAddValToSet,
    icAddRangeToSet,
    icGlobCall,
    icMemberCall,
    icUnnamedCall,
    icGlobCallRef,
    icMemberCallRef,
    icUnnamedCallRef,
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
    icForDec,
    icForJmpIfLE,
    icForJmpIfGE,
    icForJmpStep,
    icCaseJmpIfEqual,
    icCaseJmpIfInRange,
    icRaise,
    isReraise,
    icRaiseEBCFromFinally,
    icCallFinally,
    icFinallyRet,
    icExceptJmpIfIs,
    icExceptDone,
    icExceptToVar,
    icSetNamespace,
    icArrayCreate,
    icArrayRedimLValue,
    icArrayRedimLocal,
    icEventHandlerMake
  );

  PLMDInstr = ^TLMDInstr;
  TLMDInstr = record
    Code:       TLMDInstrCode;
    Data:       TObject;
    TryIndex:   ShortInt;
    SourceInfo: Cardinal; // Use LMD_SPOSMASK and LMD_BREAKABLE to decode.
  end;

  PLMDInstrs = ^TLMDInstrs;
  TLMDInstrs = packed array[0..1024] of TLMDInstr;

  {******************************* TLMDByteCode *******************************}

  TLMDLabel = class
  private
    FTarget: PLMDInstr; // Until postprocess stores
                        // Integer instruction index.
  public
    property Target: PLMDInstr read FTarget;
  end;

  TLMDBracketType = (bkNon, bkVbRound, bkRound, bkBlock);

  TLMDCall = class
  private
    FName:          Integer;
    FStrName:       WideString;
    FBracketType:   TLMDBracketType;
    FArgCount:      Integer;
    FArgsOffset:    Integer;
    FResOffset:     Integer;
    FObjectOffset:  Integer;
    FResMask:       DWORD;
    FBreakLabel:    TLMDLabel;
    FContinueLabel: TLMDLabel;
    FExitLabel:     TLMDLabel;

    procedure CalcOffsets(AHasObject, AHasValue: Boolean);
  public
    property Name: Integer read FName;
    property StrName: WideString read FStrName;
    property ArgCount: Integer read FArgCount;
    property BracketType: TLMDBracketType read FBracketType;
    property ObjectOffset: Integer read FObjectOffset;   // In bytes.
    property ArgsOffset: Integer read FArgsOffset;       //
    property ResOffset: Integer read FResOffset;         //
    property ResMask: DWORD read FResMask;   // Zero if call result is
                                             // not used (semantically),
                                             // otherwise = $FFFFFFFF.
    property BreakLabel: TLMDLabel read FBreakLabel write FBreakLabel;
    property ContinueLabel: TLMDLabel read FContinueLabel write FContinueLabel;
    property ExitLabel: TLMDLabel read FExitLabel write FExitLabel;
  end;

  TLMDTry = class
  private
    FIndex:         Integer;
    FParent:        TLMDTry;
    FFinallyRetVar: Integer;
    FExceptionVar:  Integer;
    FFinallyLabel:  TLMDLabel;
    FHandlerLabel:  TLMDLabel;
    FHdrHierHigh:   Integer;
    FHdrHierLow:    Integer;
    FKnownFRets:    TList; // Lazy inited.

    function GetKnownFinallyRetCount: Integer;
    function GetKnownFinallyRets(AIndex: Integer): TLMDLabel;
  public
    destructor Destroy; override;
    procedure  AddKnownFinallyRet(L: TLMDLabel);

    // ExceptionVar - Unnamed array of two local vars that, which are used
    //                by VM to place run-time info about thrown exception.
    //                This info contains a pointer to real Delphi exception
    //                instance as well as some internal VM's run-time info.
    //                Note: two consequtive local vars are required, because
    //                the size of data is greater than SizeOf(Variant) in x64
    //                platform. See also: TExcVarData type.
    // HdrHierLow,
    // HdrHierHigh  - Abstract low and high indexes. The way for very
    //                fast check of whether the one exception handler,
    //                e.g. except or finally code is resided inside
    //                another exception handler:
    //                  (child.HdrHierLow > pnt.HdrHierLow) and
    //                  (child.HdrHierLow < pnt.HdrHierHigh);
    //                Note, this is NOT one *try* inside another *try*, this is
    //                one *handler* inside another *handler*, for example:
    //                  try
    //                  except    // 1
    //                    try
    //                    finally // 2. This handler is inside handler 1.
    //                    end;
    //                  end;
    // Parent -       Denotes parent try, e.g. one try is reside inside another
    //                try, for example:
    //                  try
    //                    try
    //                    finally
    //                    end;
    //                  except
    //                  end;

    property Index: Integer read FIndex;
    property Parent: TLMDTry read FParent;
    property FinallyLabel: TLMDLabel read FFinallyLabel write FFinallyLabel;
    property FinallyRetVar: Integer read FFinallyRetVar write FFinallyRetVar;
    property KnownFinallyRets[AIndex: Integer]: TLMDLabel read GetKnownFinallyRets;
    property KnownFinallyRetCount: Integer read GetKnownFinallyRetCount;
    property ExceptionVar: Integer read FExceptionVar write FExceptionVar;
    property HandlerLabel: TLMDLabel read FHandlerLabel write FHandlerLabel;
    property HdrHierLow: Integer read FHdrHierLow;
    property HdrHierHigh: Integer read FHdrHierHigh;
  end;

  TLMDExcJump = class
  private
    FTry:   TLMDTry;
    FLabel: TLMDLabel;
  public
    constructor Create(ATry: TLMDTry; ALabel: TLMDLabel);

    property Try_: TLMDTry read FTry;
    property Label_: TLMDLabel read FLabel;
  end;

  TLMDFor = class
  private
    FJmpLabel:     TLMDLabel;
    FToVar:        Integer;
    FStepVar:      Integer;
    FLoopVarRef:   Integer;
    FLoopLocalVar: Integer;
  public
    constructor Create(AJmpLabel: TLMDLabel; AToVar, AStepVar: Integer;
                       ALoopVarRef: Integer); overload;
    constructor Create(AJmpLabel: TLMDLabel; AToVar, AStepVar: Integer;
                       ALoopVarRef: Integer; ALoopLocalVar: Integer); overload;

    // LoopVarRef - is unnamed local var that stores the pointer to
    //              real loop-var in Integer form. This prevents name
    //              search on each iteration.
    // LoopLocalVar - is optimization for local vars. Should be used
    //                with special byte-code instruction.

    property JmpLabel: TLMDLabel read FJmpLabel;
    property ToVar: Integer read FToVar;
    property StepVar: Integer read FStepVar;
    property LoopVarRef: Integer read FLoopVarRef;
    property LoopLocalVar: Integer read FLoopLocalVar;
  end;

  TLMDArray = class
  private
    FArgsOffset:  Integer;
    FElemVarType: TVarType;
    FDimCount:    Integer;
  public
    property DimCount: Integer read FDimCount;
    property ElemVarType: TVarType read FElemVarType;
    property ArgsOffset: Integer read FArgsOffset; // In bytes.
  end;

  TLMDArrayRedim = class(TLMDArray)
  private
    FPreserve:      Boolean;
    FArrayOffset:   Integer;
    FArrayLocalVar: Integer;
  public
    // ArrayLocalVar - is optimization for local vars. Should be used instead
    //                 of ArrayOffset by special byte-code instruction.

    property Preserve: Boolean read FPreserve;
    property ArrayOffset: Integer read FArrayOffset; // In bytes.
    property ArrayLocalVar: Integer read FArrayLocalVar;
  end;

  PLMDTrys = ^TLMDTrys;
  TLMDTrys = array[0..1024] of TLMDTry; // Range not used.

  TLMDByteCode = class
  private
    FCode:               PLMDInstrs;
    FCodeLength:         Integer;
    FCount:              Integer;
    FItems:              TList; // Of different classes.
    FTryCount:           Integer;
    FTryArray:           PLMDTrys;
    FCurrentProtBlock:   TLMDTry;
    FStackSize:          Integer;
    FStackLocalsOffset:  Integer;
    FInitialNamespace:   TLMDAbstractNamespace;
    FNextExcHdrRangeId:  Integer;
    FCurSourcePos:       Integer;
    FMaxSourcePos:       Integer;
    FMinSourcePos:       Integer;
    FNextInstrBreakable: Boolean;
    FDescription:        WideString;
    FLocalVarCount:      Integer;

    procedure CalcStackSize;
    procedure ProcessLabels;
    procedure CreateTryArray;
    procedure Grow(AOldLen: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    { Emitting }

    procedure BeginEmit(const ADescription: WideString;
                        AInitialNamespace: TLMDAbstractNamespace;
                        ASourcePos: Integer);

    procedure BeginSourcePos(ASourcePos: Integer; out AOldSourcePos: Integer);
    procedure EndSourcePos(AOldSourcePos: Integer);
    property  CurSourcePos: Integer read FCurSourcePos;

    function  CreateLabel: TLMDLabel;
    procedure BindLabel(ALabel: TLMDLabel);

    procedure SetNextInstrBreakable;
    procedure ManualResetNextInstrBreakable;
    procedure Emit(ACode: TLMDInstrCode; AData: TObject); overload;
    procedure Emit(ACode: TLMDInstrCode); overload;

    function  AddCall(AName: Integer; const AStrName: WideString;
                      ABracketType: TLMDBracketType; AArgCount: Integer;
                      AHasObject, AHasValue, AIsResUsed: Boolean): TLMDCall;

    function  AddLocalVar: Integer;
    function  AddLocalVarArray(ALength: Integer): Integer;

    function  AddFor(AJmpLabel: TLMDLabel; AIsStepUsed: Boolean): TLMDFor; overload;
    function  AddFor(AJmpLabel: TLMDLabel; ALoopLocalVar: Integer;
                     AIsStepUsed: Boolean): TLMDFor; overload;

    function  AddArray(ADimCount: Integer; AElemVarType: TVarType): TLMDArray;
    function  AddArrayRedim(ADimCount: Integer; AElemVarType: TVarType;
                            APreserve: Boolean): TLMDArrayRedim; overload;
    function  AddArrayRedim(ADimCount: Integer; AElemVarType: TVarType;
                            APreserve: Boolean;
                            AArrayLocalVar: Integer): TLMDArrayRedim; overload;

    function  BeginProtectedBlock: TLMDTry;
    procedure EndProtectedBlock;
    procedure BeginExcHdrCode(ATry: TLMDTry);
    procedure EndExcHdrCode(ATry: TLMDTry);
    function  AddExcJmp(ATry: TLMDTry; ALabel: TLMDLabel): TLMDExcJump;

    procedure EndEmit;

    { Runtime }

    function GetFirstBreakInstr(AStartPos, ALength: Integer): PLMDInstr;
    property Code: PLMDInstrs read FCode;
    property StackSize: Integer read FStackSize;
    property StackLocalsOffset: Integer read FStackLocalsOffset; // In bytes.
    property Trys: PLMDTrys read FTryArray;
    property InitialNamespace: TLMDAbstractNamespace read FInitialNamespace;

    { Debugger related }

    property Description: WideString read FDescription;
  end;

implementation

type
  TJump = class
  private
    FInstr:       PLMDInstr;
    FStackLength: Integer;
    FIsProcessed: Boolean;
  public
    constructor Create(AInstr: PLMDInstr; AStackLength: Integer);

    property Instr: PLMDInstr read FInstr;
    property StackLength: Integer read FStackLength;
    property IsProcessed: Boolean read FIsProcessed;
  end;

const
  VSIZE = SizeOf(OleVariant);

{***************************** TLMDForJump ************************************}
{------------------------------------------------------------------------------}
constructor TLMDFor.Create(AJmpLabel: TLMDLabel; AToVar, AStepVar: Integer;
  ALoopVarRef: Integer);
begin
  inherited Create;
  FJmpLabel       := AJmpLabel;
  FToVar          := AToVar;
  FStepVar        := AStepVar;
  FLoopVarRef     := ALoopVarRef;
end;

{************************** TLMDAbstractNamespace *****************************}
{ ---------------------------------------------------------------------------- }
function TLMDAbstractNamespace.CompileTimeFind(
  AName: Integer): TLMDNameSearchRes;
begin
  Result.ObjKind     := srNotFound;
  Result.NamedObject := nil;
end;

{********************************** TLMDTry ***********************************}
{------------------------------------------------------------------------------}
procedure TLMDTry.AddKnownFinallyRet(L: TLMDLabel);
begin
  if FKnownFRets = nil then
    FKnownFRets := TList.Create;
  FKnownFRets.Add(L);
end;

destructor TLMDTry.Destroy;
begin
  FKnownFRets.Free;
  inherited;
end;

function TLMDTry.GetKnownFinallyRetCount: Integer;
begin
  if FKnownFRets = nil then
    Result := 0
  else
    Result := FKnownFRets.Count;
end;

function TLMDTry.GetKnownFinallyRets(AIndex: Integer): TLMDLabel;
begin
  Result := TLMDLabel(FKnownFRets[AIndex]);
end;

{******************************* TLMDExcJump **********************************}
{------------------------------------------------------------------------------}
constructor TLMDExcJump.Create(ATry: TLMDTry; ALabel: TLMDLabel);
begin
  inherited Create;
  FTry   := ATry;
  FLabel := ALabel;
end;

{********************************* TLMDByteCode *******************************}
{------------------------------ public ----------------------------------------}
procedure TLMDByteCode.Emit(ACode: TLMDInstrCode);
begin
  Emit(ACode, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDByteCode.EndEmit;
begin
  ProcessLabels;
  CalcStackSize;
  CreateTryArray;
end;

{------------------------------------------------------------------------------}
constructor TLMDByteCode.Create;
begin
  inherited Create;
  FItems        := TList.Create;
  FCurSourcePos := -1;
end;

{------------------------------------------------------------------------------}
destructor TLMDByteCode.Destroy;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TObject(FItems[i]).Free;
  FItems.Free;

  if FTryArray <> nil then
    FreeMem(FTryArray);
  FreeMem(FCode);

  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDByteCode.BindLabel(ALabel: TLMDLabel);
begin
  ALabel.FTarget := PLMDInstr(FCount);
end;

{------------------------------------------------------------------------------}
function TLMDByteCode.BeginProtectedBlock: TLMDTry;
begin
  Result := TLMDTry.Create;
  try
    Result.FIndex     := FTryCount;
    Result.FParent    := FCurrentProtBlock;
    FCurrentProtBlock := Result;

    FItems.Add(Result);
    Inc(FTryCount);
  except
    Result.Free;
    raise;
  end;
end;

procedure TLMDByteCode.BeginSourcePos(ASourcePos: Integer;
  out AOldSourcePos: Integer);
begin
  AOldSourcePos := FCurSourcePos;
  FCurSourcePos := ASourcePos;
end;

{------------------------------------------------------------------------------}
procedure TLMDByteCode.EndProtectedBlock;
begin
  FCurrentProtBlock := FCurrentProtBlock.FParent;
end;

procedure TLMDByteCode.EndSourcePos(AOldSourcePos: Integer);
begin
  FCurSourcePos := AOldSourcePos;
end;

{------------------------------------------------------------------------------}
procedure TLMDByteCode.Emit(ACode: TLMDInstrCode; AData: TObject);
var
  OldLen:   Integer;
  TryIndex: Integer;
begin
  OldLen := FCodeLength;
  if OldLen = FCount then
    Grow(OldLen);

  TryIndex := -1;
  if FCurrentProtBlock <> nil then
    TryIndex := FCurrentProtBlock.Index;

  Assert(FCurSourcePos <> -1);
  if FMinSourcePos > FCurSourcePos then
    FMinSourcePos := FCurSourcePos;
  if FMaxSourcePos < FCurSourcePos then
    FMaxSourcePos := FCurSourcePos;

  FCode[FCount].Code       := ACode;
  FCode[FCount].TryIndex   := TryIndex;
  FCode[FCount].Data       := AData;
  FCode[FCount].SourceInfo := FCurSourcePos;

  if FNextInstrBreakable then
  begin
    FCode[FCount].SourceInfo := FCode[FCount].SourceInfo or LMD_BREAKABLE;
    FNextInstrBreakable      := False;
  end;

  Inc(FCount);
end;

{------------------------------------------------------------------------------}
function TLMDByteCode.AddArray(ADimCount: Integer;
  AElemVarType: TVarType): TLMDArray;
begin
  Result := TLMDArray.Create;
  try
    Result.FDimCount    := ADimCount;
    Result.FElemVarType := AElemVarType;
    Result.FArgsOffset  := ((ADimCount * 2) - 1) * VSIZE;

    FItems.Add(Result);
  except
    Result.Free;
    raise;
  end;
end;

function TLMDByteCode.AddArrayRedim(ADimCount: Integer; AElemVarType: TVarType;
  APreserve: Boolean): TLMDArrayRedim;
begin
  Result := TLMDArrayRedim.Create;
  try
    Result.FDimCount    := ADimCount;
    Result.FElemVarType := AElemVarType;
    Result.FArgsOffset  := ((ADimCount * 2) - 1) * VSIZE;
    Result.FArrayOffset := Result.FArgsOffset + VSIZE;
    Result.FPreserve    := APreserve;

    FItems.Add(Result);
  except
    Result.Free;
    raise;
  end;
end;

function TLMDByteCode.AddArrayRedim(ADimCount: Integer; AElemVarType: TVarType;
  APreserve: Boolean; AArrayLocalVar: Integer): TLMDArrayRedim;
begin
  Result := TLMDArrayRedim.Create;
  try
    Result.FDimCount      := ADimCount;
    Result.FElemVarType   := AElemVarType;
    Result.FArgsOffset    := ((ADimCount * 2) - 1) * VSIZE;
    Result.FArrayOffset   := Result.FArgsOffset + VSIZE; // For sure.
    Result.FPreserve      := APreserve;
    Result.FArrayLocalVar := AArrayLocalVar;

    FItems.Add(Result);
  except
    Result.Free;
    raise;
  end;
end;

function TLMDByteCode.AddCall(AName: Integer; const AStrName: WideString;
  ABracketType: TLMDBracketType; AArgCount: Integer; AHasObject, AHasValue,
  AIsResUsed: Boolean): TLMDCall;
const
  RES_MASKS: array[Boolean] of DWORD = (0, $FFFFFFFF);
begin
  Result := TLMDCall.Create;
  try
    Result.FName        := AName;
    Result.FStrName     := AStrName;
    Result.FBracketType := ABracketType;
    Result.FArgCount    := AArgCount;
    Result.FResMask     := RES_MASKS[AIsResUsed];
    Result.CalcOffsets(AHasObject, AHasValue);

    FItems.Add(Result);
  except
    Result.Free;
    raise;
  end;
end;

function TLMDByteCode.AddExcJmp(ATry: TLMDTry;
  ALabel: TLMDLabel): TLMDExcJump;
begin
  Result := TLMDExcJump.Create(ATry, ALabel);
  try
    FItems.Add(Result)
  except
    Result.Free;
  end;
end;

function TLMDByteCode.AddFor(AJmpLabel: TLMDLabel;
  ALoopLocalVar: Integer; AIsStepUsed: Boolean): TLMDFor;
var
  stepv: Integer;
begin
  stepv := -1;
  if AIsStepUsed then
    stepv := AddLocalVar;

  Result := TLMDFor.Create(AJmpLabel, AddLocalVar, stepv, AddLocalVar,
                           ALoopLocalVar);
  try
    FItems.Add(Result);
  except
    Result.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDByteCode.CreateLabel: TLMDLabel;
begin
  Result := TLMDLabel.Create;
  try
    Result.FTarget := PLMDInstr(-1);
    FItems.Add(Result);
  except
    Result.Free;
    raise;
  end;
end;

{---------------------------------- private -----------------------------------}
procedure TLMDByteCode.ProcessLabels;
var
  i:       Integer;
  jmps:    TList;
  lbl:     TLMDLabel;
  newtrgt: PLMDInstr;
begin
  { Replace instruction indexes to direct pointers }

  for i := 0 to FItems.Count - 1 do
    if TObject(FItems[i]) is TLMDLabel then
    begin
      lbl         := TLMDLabel(FItems[i]);
      lbl.FTarget := @FCode[Integer(lbl.FTarget)];
    end;

  { Remove sequential unconditional jumps }

  jmps := TList.Create;
  try
    for i := 0 to FItems.Count - 1 do
      if TObject(FItems[i]) is TLMDLabel then
      begin
        lbl := TLMDLabel(FItems[i]);
        jmps.Clear;

        while lbl.FTarget.Code = icJump do
        begin
          newtrgt := TLMDLabel(lbl.FTarget.Data).FTarget;

          if jmps.IndexOf(newtrgt) = -1 then
          begin
            lbl.FTarget := newtrgt;
            jmps.Add(newtrgt);
          end
          else
            Break; // while
        end;
      end;
  finally
    jmps.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDByteCode.CalcStackSize;
var
  i:         Integer;
  chunks:    TList;
  cur:       PLMDInstr;
  curLength: Integer;
  processed: Boolean;

  procedure _AddChunk(AInstr: PLMDInstr; AStackLength: Integer); overload;
  var
    i:   Integer;
    cur: TJump;
  begin
    for i := 0 to chunks.Count - 1 do
    begin
      cur := TJump(chunks[i]);

      if cur.Instr = AInstr then
      begin
        if cur.StackLength < AStackLength then
        begin
          cur.FStackLength := AStackLength;
          cur.FIsProcessed := False;
        end;

        Exit;
      end;
    end;

    chunks.Add(TJump.Create(AInstr, AStackLength));
  end;

  procedure _AddChunk(ALabel: TLMDLabel; AStackLength: Integer); overload;
  begin
    _AddChunk(ALabel.Target, AStackLength);
  end;

begin
  if FCodeLength = 0 then
  begin
    FStackSize         := 0;
    FStackLocalsOffset := 0;
    Exit;
  end;

  processed := False;
  chunks    := TList.Create;
  try
    _AddChunk(@FCode[0], 0);
    for i := 0 to FItems.Count - 1 do
    begin
      if TObject(FItems[i]) is TLMDTry then
        _AddChunk(TLMDTry(FItems[i]).HandlerLabel, 0);
    end;

    while not processed do
    begin
      processed := True;

      for i := 0 to chunks.Count - 1 do
        if not TJump(chunks[i]).IsProcessed then
        begin
          processed := False;
          cur       := TJump(chunks[i]).Instr;
          curLength := TJump(chunks[i]).StackLength;

          while True do
          begin
            case cur^.Code of
              icRet:
                Break;
              icPop:
                Dec(curLength);
              icPush:
                Inc(curLength, Integer(cur^.Data));
              icPush0,
              icPushUnassigned,
              icPushLiteral,
              icPushLocalVar,
              icPushLocalConst,
              icPushArg,
              icPushResult,
              icPushLocalVarRef,
              icPushArgRef,
              icPushResultRef:
                Inc(curLength);
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
              icStrConcat,
              icMinus,
              icImp,
              icEqv,
              icOr,
              icXor,
              icMultiply,
              icDivide,
              icIntDiv,
              icMod,
              icAnd,
              icShl,
              icShr,
              icPower:
                Dec(curLength);
              icUnaryPlus,
              icUnaryMinus,
              icUnaryNot:
                ; // Do nothing.
              icAddValToSet:
                Dec(curLength);
              icAddRangeToSet:
                Dec(curLength, 2);
              icGlobCall,
              icGlobCallRef,
              icMemberCall,
              icMemberCallRef,
              icUnnamedCall,
              icUnnamedCallRef,
              icNewUnnamedCall:
                Dec(curLength, TLMDCall(cur^.Data).ResOffset div VSIZE);
              icAssignGlobCall:
                Dec(curLength, (TLMDCall(cur^.Data).ArgsOffset div VSIZE) +
                                1);
              icAssignMemberCall:
                Dec(curLength, (TLMDCall(cur^.Data).ObjectOffset div VSIZE) +
                                1);
              icAssignUnnamedCall:
                Dec(curLength, (TLMDCall(cur^.Data).ObjectOffset div VSIZE) +
                                1);
              icAssignLValue:
                Dec(curLength, 2);
              icAssignLocalVar,
              icAssignArg,
              icAssignResult,
              icAssignGlobalVar,
              icAssignGlobalConst:
                Dec(curLength);
              icForInitLValue:
                Dec(curLength, 2);
              icForInitLocal:
                Dec(curLength);
              icForInc,
              icForIncStep,
              icForDec:
                ; // Do nothing.
              icRaise,
              isReraise:
                Break;
              icSetNamespace:
                ; // Do nothing.
              icCallFinally,
              icRaiseEBCFromFinally,
              icFinallyRet:
                Break;
              icExceptJmpIfIs:
              begin
                _AddChunk(TLMDExcJump(cur^.Data).Label_, curLength - 1);
                Dec(curLength);
              end;
              icExceptDone:
                ; // Do nothing.
              icExceptToVar:
                Inc(curLength);
              icJump:
              begin
                _AddChunk(TLMDLabel(cur^.Data), curLength);
                Break;
              end;
              icJmpIfTrue,
              icJmpIfFalse:
                _AddChunk(TLMDLabel(cur^.Data), curLength);
              icPopJmpIfTrue,
              icPopJmpIfFalse:
              begin
                _AddChunk(TLMDLabel(cur^.Data), curLength - 1);
                Dec(curLength);
              end;
              icPopJmpIfEqual,
              icPopJmpIfNotEqual:
              begin
                _AddChunk(TLMDLabel(cur^.Data), curLength - 2);
                Dec(curLength);
              end;
              icForJmpIfLE,
              icForJmpIfGE,
              icForJmpStep:
                _AddChunk(TLMDFor(cur^.Data).JmpLabel, curLength);
              icCaseJmpIfEqual:
              begin
                _AddChunk(TLMDLabel(cur^.Data), curLength - 2);
                Dec(curLength);
              end;
              icCaseJmpIfInRange:
              begin
                _AddChunk(TLMDLabel(cur^.Data), curLength - 3);
                Dec(curLength, 2);
              end;
              icArrayCreate:
                Dec(curLength, TLMDArray(cur^.Data).DimCount - 1);
              icArrayRedimLValue:
                Dec(curLength, TLMDArray(cur^.Data).DimCount + 1);
              icArrayRedimLocal:
                Dec(curLength, TLMDArray(cur^.Data).DimCount);
              icEventHandlerMake:
                Inc(curLength);
            else
              Assert(False);
            end;
            Inc(cur);

            if FStackSize < curLength then
              FStackSize := curLength;
          end;

          TJump(chunks[i]).FIsProcessed := True;
        end; // for
    end; // main while

    Inc(FStackSize, FLocalVarCount);
    FStackLocalsOffset := (FLocalVarCount - 1) * VSIZE;
  finally
    for i := 0 to chunks.Count - 1 do
      TJump(chunks[i]).Free;
    chunks.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDByteCode.Grow(AOldLen: Integer);
begin
  FCodeLength := AOldLen * 2;
  if FCodeLength < 4 then
    FCodeLength := 4;

  ReallocMem(FCode, FCodeLength * SizeOf(TLMDInstr));
end;

{------------------------------------------------------------------------------}
procedure TLMDByteCode.CreateTryArray;
var
  i, idx: Integer;
begin
  if FTryCount > 0 then
  begin
    idx := 0;
    GetMem(FTryArray, FTryCount * SizeOf(Pointer));

    for i := 0 to FItems.Count - 1 do
      if TObject(FItems[i]) is TLMDTry then
      begin
        FTryArray[idx] := TLMDTry(FItems[i]);
        Inc(idx);
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDByteCode.BeginEmit(const ADescription: WideString;
  AInitialNamespace: TLMDAbstractNamespace; ASourcePos: Integer);
begin
  FDescription      := ADescription;
  FInitialNamespace := AInitialNamespace;
  FCurSourcePos     := ASourcePos;
end;

{------------------------------------------------------------------------------}
procedure TLMDByteCode.BeginExcHdrCode(ATry: TLMDTry);
begin
  ATry.FHdrHierLow := FNextExcHdrRangeId;
  Inc(FNextExcHdrRangeId);
end;

{------------------------------------------------------------------------------}
procedure TLMDByteCode.EndExcHdrCode(ATry: TLMDTry);
begin
  ATry.FHdrHierHigh := FNextExcHdrRangeId;
  Inc(FNextExcHdrRangeId);
end;

{------------------------------------------------------------------------------}
procedure TLMDByteCode.SetNextInstrBreakable;
begin
  FNextInstrBreakable := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDByteCode.ManualResetNextInstrBreakable;
begin
  FNextInstrBreakable := False;
end;

{------------------------------------------------------------------------------}
function TLMDByteCode.GetFirstBreakInstr(AStartPos,
  ALength: Integer): PLMDInstr;
var
  i:    Integer;
  snfo: Cardinal;
begin
  if (AStartPos > FMaxSourcePos) or
     (AStartPos + ALength - 1 < FMinSourcePos) then
  begin
    Result := nil;
    Exit;
  end;

  for i := 0 to FCodeLength - 1 do
  begin
    snfo := FCode[i].SourceInfo;

    if ((snfo and LMD_BREAKABLE) <> 0) and
       (Integer(snfo and LMD_SPOSMASK) >= AStartPos) and
       (Integer(snfo and LMD_SPOSMASK) <= AStartPos + ALength - 1) then
    begin
      Result := @FCode[i];
      Exit;
    end;
  end;

  Result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDByteCode.AddLocalVar: Integer;
begin
  Result := FLocalVarCount;
  Inc(FLocalVarCount);
end;

function TLMDByteCode.AddLocalVarArray(ALength: Integer): Integer;
begin
  Result := FLocalVarCount;
  Inc(FLocalVarCount, ALength);
end;

{------------------------------------------------------------------------------}
function TLMDByteCode.AddFor(AJmpLabel: TLMDLabel;
  AIsStepUsed: Boolean): TLMDFor;
var
  stepv: Integer;
begin
  stepv := -1;
  if AIsStepUsed then
    stepv := AddLocalVar;

  Result := TLMDFor.Create(AJmpLabel, AddLocalVar, stepv, AddLocalVar);
  try
    FItems.Add(Result);
  except
    Result.Free;
  end;
end;

{ TLMDCall }

procedure TLMDCall.CalcOffsets(AHasObject, AHasValue: Boolean);
begin
  FArgsOffset := (FArgCount - 1) * VSIZE;
  if AHasValue then
    FArgsOffset := FArgsOffset + VSIZE;

  FObjectOffset := FArgsOffset + VSIZE;
  FResOffset    := FArgsOffset + VSIZE;

  if AHasObject then
    FResOffset := FResOffset + VSIZE;
end;

{------------------------------------------------------------------------------}
constructor TJump.Create(AInstr: PLMDInstr; AStackLength: Integer);
begin
  inherited Create;
  FInstr       := AInstr;
  FStackLength := AStackLength;
end;

constructor TLMDFor.Create(AJmpLabel: TLMDLabel; AToVar, AStepVar,
  ALoopVarRef, ALoopLocalVar: Integer);
begin
  inherited Create;
  FJmpLabel       := AJmpLabel;
  FToVar          := AToVar;
  FStepVar        := AStepVar;
  FLoopVarRef     := ALoopVarRef;
  FLoopLocalVar   := ALoopLocalVar;
end;

constructor TLMDAbstractNamespace.Create(AParent: TLMDAbstractNamespace);
begin
  inherited Create;
  FParent := AParent;
end;

end.
