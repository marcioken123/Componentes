{***********************************************************
                R&A Library
                   RAI2
       Copyright (C) 1998-2000 R&A

       component   : RAI2Program and more..
       description : R&A Interpreter version 2

       programer   : black(nbs)
       e-mail      : black@infa.ru
                     blacknbs@chat.ru
       www         : http://www.infa.ru/black/ralib.htm
                     http://www.chat.ru/~blacknbs/ralib.htm


   additional programming:
   -------------------------
     Array support:
       programmer  : olej
       e-mail      : olej@atlas.cz (private)
                     olej@asset.sk
                     http://go.to/aolej
************************************************************}
{$INCLUDE RA.INC}

{  TO DO:
  - set constants: [Enum1..Enum9];
  - more testing for nested if-statements;
  - 'in' operator for sets;
  - 'as', 'is' operators;
}

{ history (R&A Library versions):
  1.10:
   - first release;
  1.12:
   - method HandleException removed as bugged;
   - method UpdateExceptionPos now fill error message
     with error Unit name and Line pos;
   - fixed bug in TRAI2Unit.Assignment method;
   - new public property BaseErrLine used in UpdateExceptionPos;
  1.17.7:
   - local "const" statement for functions;
   - global variables and constants - scope on all units - not normal !;
   - OnGetValue and OnSetValue now called before call to Adapter;
   - fixed bug with "Break" statement inside "for" loop;
  1.17.10:
   - fixed(?) bug with "begin/end" statement in "else" part of "if" statement;
   - fixed few bugs in ole automation support;
  1.21.2 (RALib 1.21 Update 2):
   - fixed bug with multiple external functions defintions
     (greetings to Peter Fischer-Haaser)
   - fixed AV-bug in TRAI2Function.InFunction1 if errors in source occured
     (greetings to Andre N Belokon)
  1.21.4 (RALib 1.21 Update 4):
   - fixed bugs in "if" and "while" with "begin" statements;
   - "div" and "mod" now working;
  1.21.6 (RALib 1.21 Update 6):
   - fixed bug with incorrect error line and unit name if erorr
     occured in used unit
     (greetings to Dmitry Mokrushin)
   - add parameters check (not fully functional - only count checked)
     in source fucntion calls;
  1.31.2 (RALib 1.31 Update 2):
   - fixed bug: sometimes compare-operators ('=', '>', ...)
     in expressions do not working.
  1.31.4 (RALib 1.31 Update 4):
   - fixed bug: plus and minus operators after symbol ']' not working.
  1.31.5 (RALib 1.31 Update 5):
   - function Statement1 is changed; this remove many bugs and add new ones.
   - fixed many bug in exception handling statements and in nested
     "begin/end" statements;
   - fixed error with source function with TObject (and descendants)
     returning values;
  1.41.1:
   - another fix for bug with incorrect error line and unit name
     if erorr occurred in used unit;
   - fixed bug with "break" statement;
   - "exit" statement;
   - "repeat" loop;
  1.50:
   - behavior of "UseGlobalAdapter" property was changed; in previous versions
     each TRAI2Expression component creates its own copy of GlobalAdapter and
     then manage it own copy, but now TRAI2Expression manages two adapters:
     own and global, so GlobalRAI2Adapter now is used by all TRAI2Expressions;
     performance of "Compile" function increased (there is no necessity
     more to Assign adapters) (20 msec on my machine with rai2_all unit)
     and memory requirement decreased;
   - sorting in TRAI2Adapter dramatically increase its performance speed;
   - fixed bug in "except/on" statement;
  1.51:
   - arrays as local and global variables. supports simple types (integer,
     double, string, tdatetime, object).
     Added by Andrej Olejnik (olej@asset.sk);
   - type conversion with integer, string, TObject,... keywords;  


{$DEFINE RAI2_DEBUG}
{$DEFINE RAI2_OLEAUTO}

unit RAI2;

interface

uses Windows, SysUtils, Classes, RAI2Parser;

const

 { max arguments to functions - small values increase performance }
  MaxArgs = 32;

 { max fields allowed in records }
  MaxRecFields = 32;

type

 { argument definition }
  TValueArray = array[0..MaxArgs] of Variant;
  TTypeArray = array[0..MaxArgs] of Word;
  TNameArray = array[0..MaxArgs] of string;
  PValueArray = ^TValueArray;
  PTypeArray = ^TTypeArray;
  PNameArray = ^TNameArray;

  TArgs = class;

  TRAI2GetValue = procedure(Sender: TObject; Identifer: string; var Value: Variant;
    Args: TArgs; var Done: Boolean) of object;
  TRAI2SetValue = procedure(Sender: TObject; Identifer: string;
    const Value: Variant; Args: TArgs; var Done: Boolean) of object;
  TRAI2GetUnitSource = procedure(UnitName: string; var Source: string;
    var Done: Boolean) of object;

  TRAI2AdapterGetValue = procedure(var Value: Variant; Args: TArgs);
  TRAI2AdapterSetValue = procedure(const Value: Variant; Args: TArgs);
  TRAI2AdapterNewRecord = procedure(var Value: Pointer);
  TRAI2AdapterDisposeRecord = procedure(const Value: Pointer);
  TRAI2AdapterCopyRecord = procedure(var Dest: Pointer; const Source: Pointer);

  TOpenArray = array[0..MaxArgs] of TVarRec;

  TArgs = class
  private
    VarNames: TNameArray;
    HasVars: Boolean;
  public
    Identifer: string;
    Count: Integer;
    Types: TTypeArray;
    Values: TValueArray;
    Names: TNameArray;
    HasResult: Boolean; { = False, if result not needed - used by calls
                          to ole automation servers }
    Assignment: Boolean; { internal }
    Obj: TObject;
    ObjTyp: Word; { varObject, varClass, varUnknown }
    destructor Destroy; override;
    procedure Clear;
    procedure OpenArray(const Index: Integer);
    procedure Delete(const Index: Integer);
  private
   { open array parameter support }
    { allocates memory only if necessary }
    OAV: ^TValueArray; { open array values }
  public
   { open array parameter support }
    OA: ^TOpenArray; { open array }
    OAS: Integer; { open array size }
  end;

 { function description }
  TFunDesc = record
    UnitName: string;
    Identifer: string;
    ClassIdentifer: string;
    ParamCount: - 1..MaxArgs;
    ParamTypes: TTypeArray;
    ParamNames: TNameArray;
    ResTyp: Word;
    PosBeg: integer; { position in source }
    PosEnd: integer;
  end;
  PFunDesc = ^TFunDesc;

  TSimpleEvent = procedure of object;
  TRAI2Expression = class;

  TRAI2Event = class(TObject)
  private
    Owner: TRAI2Expression;
    FunName: string;
    FArgs: TArgs;
    constructor Create(AOwner: TRAI2Expression; AFunName: string); virtual;
    function GetArgs: TArgs;
  protected
    function CallFunction(Args: TArgs; Params: array of Variant): Variant;
    property Args: TArgs read GetArgs;
  public
    destructor Destroy; override;
  end;

  TRAI2EventClass = class of TRAI2Event;

 { variable holder }
  TRAI2Var = class
  public
    Identifer: string;
    Typ: string;
    VTyp: Word;
    Value: Variant;
  end;

 { variables list }
  TRAI2VarList = class(TList)
  public
    destructor Destroy; override;
    procedure AddVar(const Identifer, Typ: string; VTyp: Word;
      const Value: Variant);
    function FindVar(const Identifer: string): TRAI2Var;
    procedure DeleteVar(const Identifer: string);
    function GetValue(Identifer: string; var Value: Variant; Args: TArgs)
      : Boolean;
    function SetValue(Identifer: string; const Value: Variant; Args: TArgs)
      : Boolean;
  end;
 { notes about TRAI2VarList implementation:
   - list must allows to contain more than one Var with same names;
   - FindVar must return last added Var with given name;
   - DeleteVar must delete last added Var with given name; }

  TRAI2IdentiferList = class(TList)
  private
    FDuplicates: TDuplicates;
  public
    function Find(const S: string; var Index: Integer): Boolean;
    procedure Sort;
    property Duplicates: TDuplicates read FDuplicates write FDuplicates;
  end;

  TRAI2RecFieldDef = record
    Identifer: string;
    Offset: Integer;
    Typ: Word;
  end;

  TCallConvention = set of (ccFastCall, ccStdCall, ccCDecl, ccDynamic,
    ccVirtual, ccClass);

 { TRAI2Adapter - route RAI2 calls to Delphi functions }
  { very simple implementation - NEED! to optimize }
  TRAI2Adapter = class
  private
    FOwner: TRAI2Expression;
    FSrcUnitList: TRAI2IdentiferList;
    FExtUnitList: TRAI2IdentiferList;
    FGetList: TRAI2IdentiferList;
    FSetList: TRAI2IdentiferList;
    FDGetList: TRAI2IdentiferList; { direct get list }
    FClassList: TRAI2IdentiferList;
    FConstList: TRAI2IdentiferList;
    FFunList: TRAI2IdentiferList;
    FRecList: TRAI2IdentiferList;
    FRecGetList: TRAI2IdentiferList;
    FRecSetList: TRAI2IdentiferList;
    FOnGetList: TRAI2IdentiferList;
    FOnSetList: TRAI2IdentiferList;
    FSrcFunList: TRAI2IdentiferList;
    FExtFunList: TRAI2IdentiferList;
    FEventHandlerList: TRAI2IdentiferList;
    FEventList: TRAI2IdentiferList;
    FParams: TTypeArray;
    CurUnit: TObject; {TRAI2UnitSource}
    FSorted: Boolean;
    procedure CheckArgs(var Args: TArgs; ParamCount: Integer;
      var ParamTypes: TTypeArray);
    function GetRec(RecordType: string): TObject;
{$IFDEF RAI2_OLEAUTO}
    function DispatchCall(Identifer: string; var Value: Variant;
      Args: TArgs; Get: Boolean): Boolean; stdcall;
{$ENDIF RAI2_OLEAUTO}
    function GetValueRTTI(Identifer: string; var Value: Variant;
      Args: TArgs): Boolean;
    function SetValueRTTI(Identifer: string; const Value: Variant;
      Args: TArgs): Boolean;
  protected
    function GetValue(Identifer: string; var Value: Variant; Args: TArgs)
      : Boolean; virtual;
    function SetValue(Identifer: string; const Value: Variant; Args: TArgs)
      : Boolean; virtual;
    function SetUnknown(var Value: Variant): Boolean; virtual;
    function NewRecord(RecordType: string; var Value: Variant)
      : Boolean; virtual;
    function FindFunDesc(const Identifer: string): PFunDesc; virtual;
    procedure UnitChanged(NewUnitName: string; var Source: string); virtual;
    function UnitExists(const Identifer: string): Boolean; virtual;
    function IsEvent(Obj: TObject; const Identifer: string): Boolean; virtual;
    function NewEvent(const FunName, EventType: string; AOwner: TRAI2Expression)
      : TSimpleEvent; virtual;
    procedure ClearSource; dynamic;
    procedure ClearNonSource; dynamic;
    procedure Sort; dynamic;
  public
    constructor Create(AOwner: TRAI2Expression);
    destructor Destroy; override;
    procedure Clear; dynamic;
    procedure Assign(Source: TRAI2Adapter); dynamic;
    procedure AddSrcUnit(Identifer: string; Source: string; UsesList: string);
      dynamic;
    procedure AddExtUnit(Identifer: string); dynamic;
    procedure AddClass(UnitName: string; ClassType: TClass; Identifer: string);
      dynamic;
    procedure AddGet(ClassType: TClass; Identifer: string;
      GetFunc: TRAI2AdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word); dynamic;
    procedure AddSet(ClassType: TClass; Identifer: string;
      SetFunc: TRAI2AdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word); dynamic;
    procedure AddFun(UnitName: string; Identifer: string;
      GetFunc: TRAI2AdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word); dynamic;
   { function AddDGet under construction - don't use them ! }
    procedure AddDGet(ClassType: TClass; Identifer: string;
      GetFunc: Pointer; ParamCount: Integer; ParamTypes: array of Word;
      ResTyp: Word; CallConvention: TCallConvention); dynamic;
    procedure AddRec(UnitName: string; Identifer: string; RecordSize: Integer;
      Fields: array of TRAI2RecFieldDef; CreateFunc: TRAI2AdapterNewRecord;
      DestroyFunc: TRAI2AdapterDisposeRecord; CopyFunc: TRAI2AdapterCopyRecord);
      dynamic;
    procedure AddRecGet(UnitName: string; RecordType: string; Identifer: string;
      GetFunc: TRAI2AdapterGetValue; ParamCount: Integer;
      ParamTypes: array of Word); dynamic;
    procedure AddRecSet(UnitName: string; RecordType: string; Identifer: string;
      SetFunc: TRAI2AdapterSetValue; ParamCount: Integer;
      ParamTypes: array of Word); dynamic;
    procedure AddConst(UnitName: string; Identifer: string; Value: Variant);
      dynamic;
    procedure AddExtFun(UnitName: string; Identifer: string; DllInstance: HINST;
      DllName: string; FunName: string; FunIndex: integer; ParamCount: Integer;
      ParamTypes: array of Word; ResTyp: Word); dynamic;
    procedure AddSrcFun(UnitName: string; Identifer: string;
      PosBeg, PosEnd: integer; ParamCount: Integer; ParamTypes: array of Word;
      ParamNames: array of string; ResTyp: Word); dynamic;
    procedure AddHandler(UnitName: string; Identifer: string;
      EventClass: TRAI2EventClass; Code: Pointer); dynamic;
    procedure AddEvent(UnitName: string; ClassType: TClass;
      Identifer: string); dynamic;
    procedure AddOnGet(Method: TRAI2GetValue); dynamic;
    procedure AddOnSet(Method: TRAI2SetValue); dynamic;
  end;

 { Expression evaluator }
  TRAI2Expression = class(TComponent)
  private
    Parser: TRAI2Parser;
    FVResult: Variant;
    ExpStack: array[0..99] of Variant;
    ExpStackPtr: - 1..99;
    Token1: Variant;
    FBacked: Boolean;
    TTyp1: TTokenTyp;
    TokenStr1: string;
    PrevTTyp: TTokenTyp;
    FArgs: TArgs; { data }
    Args: TArgs; { pointer to current }
    FPStream: TStream; { parsed source }
    FParsed: Boolean;
    FAdapter: TRAI2Adapter;
    FGlobalAdapter: Boolean;
    FCompiled: Boolean;
    FBaseErrLine: Integer;
    FOnGetValue: TRAI2GetValue;
    FOnSetValue: TRAI2SetValue;
    function GetSource: string;
    procedure SetSource(Value: string);
    procedure SetCurPos(Value: Integer);
    function GetCurPos: Integer;
    function GetTokenStr: string;
    procedure InternalGetValue(Obj: Pointer; ObjTyp: Word; var Result: Variant);
    function CallFunction(const FunName: string; Args: TArgs;
      Params: array of Variant): Variant; dynamic; abstract;
  protected
    function UpdateExceptionPos(E: Exception; const UnitName: string): Exception;
    procedure Init; dynamic;
    procedure ErrorExpected(Exp: string);
    procedure ErrorNotImplemented(Message: string);
    function PosBeg: Integer;
    function PosEnd: Integer;
    procedure Back;
    procedure SafeBack; {? please don't use ?}
    function CreateAdapter: TRAI2Adapter; dynamic;

    procedure ParseToken;
    procedure ReadToken;
    procedure WriteToken;
    procedure Parse;

    function Expression1: Variant;
    function Expression2(const ExpType: Word): Variant;
    function SetExpression1: Variant;

    procedure NextToken;
    function GetValue(Identifer: string; var Value: Variant;
      var Args: TArgs): Boolean; virtual;
    function SetValue(Identifer: string; const Value: Variant;
      var Args: TArgs): Boolean; virtual;
    procedure SourceChanged; dynamic;
    procedure SetAdapter(Adapter: TRAI2Adapter);
    property Token: Variant read Token1;
    property TTyp: TTokenTyp read TTyp1;
    property TokenStr: string read GetTokenStr;
    property CurPos: Integer read GetCurPos write SetCurPos;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Run; dynamic;
    property Source: string read GetSource write SetSource;
    property VResult: Variant read FVResult;
    property OnGetValue: TRAI2GetValue read FOnGetValue write FOnGetValue;
    property OnSetValue: TRAI2SetValue read FOnSetValue write FOnSetValue;
    property RAI2Adapter: TRAI2Adapter read FAdapter;
    property GlobalAdapter: Boolean read FGlobalAdapter write FGlobalAdapter default True;
    property BaseErrLine: Integer read FBaseErrLine write FBaseErrLine;
  end;

  TParserState = record
    CurPos: Integer;
    Token: Variant;
    TTyp: TTokenTyp;
    PrevTTyp: TTokenTyp;
    Backed: Boolean;
  end;

 { Function executor }
  TRAI2Function = class(TRAI2Expression)
  private
    FBreak, FContinue, FExit: Boolean;
    FunStack: TList;
    FunContext: Pointer; { PFunContext }
    SS: TStrings;
    StateStack: array[0..99] of TParserState;
    StateStackPtr: - 1..99;
  protected
    procedure Init; override;
    procedure PushState;
    procedure PopState;
    procedure DecState;

    procedure InFunction1(Fun: PFunDesc);
    procedure DoOnStatement; virtual;
    procedure Statement1;
    procedure SkipStatement1;
    procedure SkipToEnd1;
    procedure SkipToUntil1;
    procedure SkipIdentifer1;
    procedure FindToken1(TTyp1: TTokenTyp);
    procedure Var1(VarList: TRAI2VarList);
    procedure Const1(ConstList: TRAI2VarList);
    procedure Identifer1;
    procedure Begin1;
    procedure If1;
    procedure While1;
    procedure Repeat1;
    procedure For1;
    procedure Try1;
    procedure Raise1;

    procedure Assignment(const Identifer: string); virtual;
    function GetValue(Identifer: string; var Value: Variant;
      var Args: TArgs): Boolean; override;
    function SetValue(Identifer: string; const Value: Variant;
      var Args: TArgs): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

 { Unit executor }
  TRAI2Unit = class(TRAI2Function)
  private
    FCurUnitName: string;
    FClearUnits: boolean;
    FEventHandlerList: TList;
    FGlobalVars: TRAI2VarList;
    FOnGetUnitSource: TRAI2GetUnitSource;
  protected
    procedure Init; override;
    procedure ReadFunHeader(var FunDesc: TFunDesc);
    procedure Uses1(var UsesList: string);
    procedure ReadUnit(const UnitName: string);
    procedure Function1;
    procedure Unit1;
    function GetValue(Identifer: string; var Value: Variant;
      var Args: TArgs): Boolean; override;
    function SetValue(Identifer: string; const Value: Variant;
      var Args: TArgs): Boolean; override;
    procedure Assignment(const Identifer: string); override;
    function GetUnitSource(UnitName: string; var Source: string): boolean;
      dynamic;
    procedure ExecFunction(Fun: PFunDesc);
    procedure SourceChanged; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure DeclareExternalFunction(const Declaration: string);
    procedure Compile;
    function CallFunction(const FunName: string; Args: TArgs;
      Params: array of Variant): Variant; override;
    function NewEvent(const FunName, EventType: string)
      : TSimpleEvent;
    function FunctionExist(const FunName: string): boolean;
    property OnGetUnitSource: TRAI2GetUnitSource read FOnGetUnitSource
      write FOnGetUnitSource;
    property CurUnitName: string read FCurUnitName write FCurUnitName;
  end;

 { main RAI2 component }
  TRAI2Program = class(TRAI2Unit)
  private
    FPas: TStrings;
    FOnStatement: TNotifyEvent;
    procedure SetPas(Value: TStrings);
  protected
    procedure DoOnStatement; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Pas: TStrings read FPas write SetPas;
    property GlobalAdapter;
    property OnGetValue;
    property OnSetValue;
    property OnGetUnitSource;
    property OnStatement: TNotifyEvent read FOnStatement write FOnStatement;
  end;

  ERAI2Error = class(Exception)
  private
    ExceptionPos: Boolean;
  public
    ErrCode: integer;
    ErrPos: integer;
    ErrName: string;
    ErrName2: string;
    ErrUnitName: string;
    ErrLine: Integer;
    Message1: string;
    constructor Create(const AErrCode: integer; const AErrPos: integer;
      const AErrName, AErrName2: string);
  end;

 {Error raising routines}
procedure RAI2Error(const AErrCode: integer; const AErrPos: integer);
procedure RAI2ErrorN(const AErrCode: integer; const AErrPos: integer;
  const AErrName: string);
procedure RAI2ErrorN2(const AErrCode: integer; const AErrPos: integer;
  const AErrName1, AErrName2: string);
function LoadStr2(const ResID: Integer): string;

const
 { additional variant types - TVarData.VType }
  varObject = $0010;
  varClass = $0011;
  varPointer = $0012;
  varSet = $0013;
  //varArray = $0014;


 { V2O - converts variant to object }
function V2O(const V: Variant): TObject;

 { O2V - converts object to variant }
function O2V(O: TObject): Variant;

 { V2C - converts variant to class }
function V2C(const V: Variant): TClass;

 { O2V - converts class to variant }
function C2V(C: TClass): Variant;

 { V2P - converts variant to pointer }
function V2P(const V: Variant): Pointer;

 { P2V - converts pointer to variant }
function P2V(P: Pointer): Variant;

 { R2V - create record holder and put it into variant }
function R2V(ARecordType: string; ARec: Pointer): Variant;

 { V2R - returns pointer to record from variant, containing record holder }
function V2R(const V: Variant): Pointer;

 { P2R - returns pointer to record from record holder, typically Args.Obj }
function P2R(const P: Pointer): Pointer;

 { S2V - converts integer to set and put it into variant }
function S2V(const I: Integer): Variant;

 { V2S - give a set from variant and converts it to integer }
function V2S(V: Variant): Integer;

procedure V2OA(V: Variant; var OA: TOpenArray; var OAValues: TValueArray;
  var Size: Integer);

 { RFD - RecordFieldDefinition - return record needed for TRAI2Adapter.AddRec
   Fields parameter }
function RFD(Identifer: string; Offset: Integer; Typ: Word)
  : TRAI2RecFieldDef;

 { raise error ieNotImplemented }
procedure NotImplemented(Message: string);

 { clear list of TObject }
procedure ClearList(List: TList);


var
  GlobalRAI2Adapter: TRAI2Adapter = nil;

const

  prArgsNoCheck = -1;
  noInstance = HINST(0);
  RFDNull: TRAI2RecFieldDef = (Identifer: ''; Offset: 0; Typ: 0);

  ResBase = $5000;

 {RAI2 error codes}

  ieOk = 0; { Okay - no errors }
  ieUnknown = 1;
  ieInternal = 2;
  ieUserBreak = 3; { internal }
  ieRaise = 4; { internal }
  ieErrorPos = 5;

  { register-time errors }
  ieRegisterBase = 30;
  ieRecordNotDefined = ieRegisterBase + 1;

  { run-time errors }
  ieRuntimeBase = 50;
  ieStackOverFlow = ieRuntimeBase + 2;
  ieTypeMistmatch = ieRuntimeBase + 3;
  ieIntegerOverflow = ieRuntimeBase + 4;
  ieMainUndefined = ieRuntimeBase + 5;
  ieUnitNotFound = ieRuntimeBase + 6;
  ieEventNotRegistered = ieRuntimeBase + 7;

  { syntax errors (now run-timed) }
  ieSyntaxBase = 100;
  ieBadRemark = ieSyntaxBase + 1; { Bad remark - detected by parser }
  ieIdentiferExpected = ieSyntaxBase + 2;
  ieExpected = ieSyntaxBase + 3;
  ieUnknownIdentifer = ieSyntaxBase + 4;
  ieBooleanRequired = ieSyntaxBase + 5;
  ieClassRequired = ieSyntaxBase + 6;
  ieNotAllowedBeforeElse = ieSyntaxBase + 7;
  ieIntegerRequired = ieSyntaxBase + 8;
  ieROCRequired = ieSyntaxBase + 9;
  ieMissingOperator = ieSyntaxBase + 10;
  ieIdentiferRedeclared = ieSyntaxBase + 11;

 { array indexes }
  ieArrayBase = 170;
  ieArrayIndexOutOfBounds = ieArrayBase + 1;
  ieArrayTooManyParams = ieArrayBase + 2;
  ieArrayNotEnoughParams = ieArrayBase + 3;
  ieArrayBadDimension= ieArrayBase + 4;
  ieArrayBadRange = ieArrayBase + 5;

 { function call errors (now run-timed) }
  ieFunctionBase = 180;
  ieTooManyParams = ieFunctionBase + 1;
  ieNotEnoughParams = ieFunctionBase + 2;
  ieIncompatibleTypes = ieFunctionBase + 3;
  ieDllErrorLoadLibrary = ieFunctionBase + 4;
  ieDllInvalidArgument = ieFunctionBase + 5;
  ieDllInvalidResult = ieFunctionBase + 6;
  ieDllFunctionNotFound = ieFunctionBase + 7;
  ieDirectInvalidArgument = ieFunctionBase + 8;
  ieDirectInvalidResult = ieFunctionBase + 9;
  ieDirectInvalidConvention = ieFunctionBase + 10;


{$IFDEF RAI2_OLEAUTO}
  ieOleAuto = ieFunctionBase + 21;
{$ENDIF}

  ieUserBase = $300;

  irExpression = ResBase + 301;
  irIdentifer = ResBase + 302;
  irDeclaration = ResBase + 303;
  irEndOfFile = ResBase + 304;


implementation

uses RAStream, iMTracer, TypInfo
{$IFNDEF RA_D3H}
  , Ole2 { IUnknown in Delphi 2 }
{$ENDIF}
{$IFDEF RAI2_OLEAUTO}
  , OleConst
{$IFDEF RA_D3H}
  , ActiveX, ComObj
{$ELSE}
  , OleAuto
{$ENDIF RA_D3H}
{$ENDIF RAI2_OLEAUTO}
  , RAUtils;


{$R rai2.res} { error messages }


{ internal structures }
type

 { Adapter classes - translates data from RAI2 calls to Delphi functions }

  TRAI2Identifer = class
    UnitName: string;
    Identifer: string;
  end;

  TRAI2UnitSource = class(TRAI2Identifer)
    Source: string;
    UsesList: TNameArray;
  end;

  TRAI2Method = class(TRAI2Identifer)
  private
    ClassType: TClass;
    ParamCount: - 1..MaxArgs;
    ParamTypes: TTypeArray; { varInteger, varString, .. }
    Func: Pointer; { TRAI2AdapterGetValue or TRAI2AdapterSetValue }
  end;

  TRAI2DMethod = class(TRAI2Method)
  private
    ResTyp: Word;
    CallConvention: TCallConvention;
  end;

  TRAI2Class = class(TRAI2Identifer)
  private
    ClassType: TClass;
  end;

  TRAI2Const = class(TRAI2Identifer)
  private
    Value: Variant;
  end;

  TRAI2RecFields = array[0..MaxRecFields] of TRAI2RecFieldDef;

  TRAI2Record = class(TRAI2Identifer)
  private
    RecordSize: Integer; { sizeof(Rec^) }
    FieldCount: Integer;
    Fields: TRAI2RecFields;
    CreateFunc: TRAI2AdapterNewRecord;
    DestroyFunc: TRAI2AdapterDisposeRecord;
    CopyFunc: TRAI2AdapterCopyRecord;
  end;

  TRAI2RecMethod = class(TRAI2Identifer)
  private
    RAI2Record: TRAI2Record;
    ParamCount: - 1..MaxArgs;
    ParamTypes: TTypeArray; { varInteger, varString and so one .. }
    Func: Pointer; { TRAI2AdapterGetValue or TRAI2AdapterSetValue }
  end;


 { ************* record support - very hack and not interesting ************}
const
  IID_IRAI2Rec: TGUID = (
    D1: $775006A0; D2: $A8A1; D3: $11D2; D4: ($B3, $83, $44, $45, $53, $54, $00, $00));
type
  TRAI2RecHolder = class;
{$IFDEF RA_D3H}
  IRAI2Rec = interface
    ['{775006A0-A8A1-11D2-B383-444553540000}']
    function GetRAI2Record: TRAI2Record;
    function GetSelf: TRAI2RecHolder;
    property RAI2Record: TRAI2Record read GetRAI2Record;
  end;
{$ELSE}
  IRAI2Rec = class(IUnknown)
    function GetRAI2Record: TRAI2Record; virtual; abstract;
    function GetSelf: TRAI2RecHolder; virtual; abstract;
    property RAI2Record: TRAI2Record read GetRAI2Record;
  end;
{$ENDIF}

  TRAI2RecHolder = class({$IFDEF RA_D3H}TObject, IUnknown, {$ENDIF}IRAI2Rec)
  private
{$IFDEF RA_D3H}
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Longint; stdcall;
    function _Release: Longint; stdcall;
    function GetRAI2Record: TRAI2Record;
    function GetSelf: TRAI2RecHolder;
{$ELSE}
    function QueryInterface(const IID: TGUID; var Obj): HResult; override;
    function AddRef: Longint; override;
    function Release: Longint; override;
    function GetRAI2Record: TRAI2Record; override;
    function GetSelf: TRAI2RecHolder; override;
{$ENDIF}
  private
    FRefCount: Integer;
  private
    RecordType: string;
    RAI2Record: TRAI2Record;
    Rec: Pointer; { data }
  public
    constructor Create(ARecordType: string; ARec: Pointer);
    destructor Destroy; override;
  end;
 { ############# record support ############}

  PMethod = ^TMethod;

 { interpreter function }
  TRAI2SrcFun = class(TRAI2Identifer)
  private
    FunDesc: TFunDesc;
  end;

 { external function }
  TRAI2ExtFun = class(TRAI2SrcFun)
  private
    DllInstance: HINST;
    DllName: string;
    FunName: string;
     {or}
    FunIndex: integer;
    function CallDll(Args: TArgs): Variant;
  end;

 { function context - stack }
  PFunContext = ^TFunContext;
  TFunContext = record
    PrevFunContext: PFunContext;
    LocalVars: TRAI2VarList;
    Fun: TRAI2SrcFun;
  end;

  TRAI2EventDesc = class(TRAI2Identifer)
    EventClass: TRAI2EventClass;
    Code: Pointer;
  end;


{$IFDEF RA_D2}
 { TStringStream - reduced implementation from Delphi 3 classes.pas }
  TStringStream = class(TStream)
  private
    FDataString: string;
    FPosition: Integer;
  protected
    procedure SetSize(NewSize: Longint);
  public
    constructor Create(const AString: string);
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
  end;
{$ENDIF RA_D2}


{$IFDEF RAI2_DEBUG}
var
  ObjCount: Integer = 0;
{$ENDIF}


function LoadStr2(const ResID: Integer): string;
begin
  SetLength(Result, 1024);
  SetLength(Result, LoadString(hInstance, ResID, PChar(Result), Length(Result)));
end;

procedure RAI2Error(const AErrCode: integer; const AErrPos: integer);
begin
  raise ERAI2Error.Create(AErrCode, AErrPos, '', '');
end; { RAI2Error }

procedure RAI2ErrorN(const AErrCode: integer; const AErrPos: integer;
  const AErrName: string);
begin
  raise ERAI2Error.Create(AErrCode, AErrPos, AErrName, '');
end; { RAI2ErrorN }

procedure RAI2ErrorN2(const AErrCode: integer; const AErrPos: integer;
  const AErrName1, AErrName2: string);
begin
  raise ERAI2Error.Create(AErrCode, AErrPos, AErrName1, AErrName2);
end; { RAI2ErrorN2 }

constructor ERAI2Error.Create(const AErrCode: integer;
  const AErrPos: integer; const AErrName, AErrName2: string);
begin
  inherited Create('');
  ErrCode := AErrCode;
  ErrPos := AErrPos;
  ErrName := AErrName;
  ErrName2 := AErrName2;
  // S := LoadStr(ErrCode + ResBase);
  { function LoadStr don't work sometimes :-( }
  Message := Format(LoadStr2(ErrCode + ResBase), [ErrName, ErrName2]);
  Message1 := Message;
end; { Create }


function V2O(const V: Variant): TObject;
begin
  Result := TVarData(V).vPointer;
end;

function O2V(O: TObject): Variant;
begin
  TVarData(Result).VType := varObject;
  TVarData(Result).vPointer := O;
end;

function V2C(const V: Variant): TClass;
begin
  Result := TVarData(V).vPointer;
end;

function C2V(C: TClass): Variant;
begin
  TVarData(Result).VType := varClass;
  TVarData(Result).vPointer := C;
end;

function V2P(const V: Variant): Pointer;
begin
  Result := TVarData(V).vPointer;
end;

function P2V(P: Pointer): Variant;
begin
  TVarData(Result).VType := varPointer;
  TVarData(Result).vPointer := P;
end;

function R2V(ARecordType: string; ARec: Pointer): Variant;
begin
{$IFDEF RA_D3H}
  Result := IUnknown(TRAI2RecHolder.Create(ARecordType, ARec));
  IUnknown(Result)._Release;
{$ELSE}
  TVarData(Result).VPointer := Pointer(IUnknown(TRAI2RecHolder.Create(ARecordType, ARec)));
  TVarData(Result).VType := varUnknown;
{$ENDIF}
end;

function V2R(const V: Variant): Pointer;
var
  Unk: IUnknown;
begin
  if (TVarData(V).VType <> varUnknown) or
{$IFDEF RA_D3H}
  (IUnknown(V).QueryInterface(IID_IRAI2Rec, Unk)
{$ELSE}
  (IUnknown(TVarData(V).VUnknown).QueryInterface(IID_IRAI2Rec, Unk)
{$ENDIF}
    <> NOERROR) then
    RAI2Error(ieROCRequired, -1);
  Result := IRAI2Rec(Unk).GetSelf.Rec;
{$IFNDEF RA_D3H}
  IUnknown(Unk).Release;
{$ENDIF}
end;

function P2R(const P: Pointer): Pointer;
var
  Unk: IUnknown;
begin
  if IUnknown(P).QueryInterface(IID_IRAI2Rec, Unk) <> NOERROR then
    RAI2Error(ieROCRequired, -1);
  Result := IRAI2Rec(Unk).GetSelf.Rec;
{$IFNDEF RA_D3H}
  Unk.Release;
{$ENDIF}
end;

function S2V(const I: Integer): Variant;
begin
  Result := I;
  TVarData(Result).VType := varSet;
end;

function V2S(V: Variant): Integer;
begin
  if (TVarData(V).VType and varArray) = 0 then
    Result := TVarData(V).VInteger
  else
  begin
   { rai2 think about all function parameters, started
     with '[' symbol that they are open arrays;
     but it may be set constant, so we must convert it now }
    //..
    RAI2Error(ieTypeMistmatch, -1);
    Result := 0; { satisfy compiler }
  end;
end;

procedure V2OA(V: Variant; var OA: TOpenArray; var OAValues: TValueArray;
  var Size: Integer);
var
  i: integer;
begin
  if (TVarData(V).VType and varArray) = 0 then
    RAI2Error(ieTypeMistmatch, -1);
  Size := VarArrayHighBound(V, 1);
  for i := 0 to Size - 1 do { Iterate }
  begin
    case TVarData(V[i]).VType of { }
      varInteger, varSmallInt:
        begin
          OA[i].vInteger := V[i];
          OA[i].VType := vtInteger;
        end;
      varString, varOleStr:
        begin
         // OA[i].vPChar := PChar(string(V[i]));
         // OA[i].VType := vtPChar;
          OAValues[i] := V[i];
          OA[i].vVariant := @OAValues[i];
          OA[i].VType := vtVariant;
        end;
      varBoolean:
        begin
          OA[i].vBoolean := V[i];
          OA[i].VType := vtBoolean;
        end;
      varDouble, varCurrency:
        begin
          OA[i].vExtended := TVarData(V[i]).vPointer;
          OA[i].VType := vtExtended;
        end;
    else
      begin
        OAValues[i] := V[i];
        OA[i].vVariant := @OAValues[i];
        OA[i].VType := vtVariant;
      end;
    end; { case }
  end;
end;

function RFD(Identifer: string; Offset: Integer; Typ: Word)
  : TRAI2RecFieldDef;
begin
  Result.Identifer := Identifer;
  Result.Offset := Offset;
  Result.Typ := Typ;
end;

procedure NotImplemented(Message: string);
begin
  RAI2ErrorN(ieInternal, -1,
    Message + ' not implemented');
end; { ErrorNotImplemented }

function TypeName2VarTyp(TypeName: string): Word;
begin
  if Cmp(TypeName, 'integer') or Cmp(TypeName, 'longint') then
    Result := varInteger
  else if Cmp(TypeName, 'word') or Cmp(TypeName, 'smallint') then
    Result := varSmallInt
  else if Cmp(TypeName, 'byte') then
    Result := varByte
  else if Cmp(TypeName, 'wordbool') or Cmp(TypeName, 'boolean') then
    Result := varBoolean
  else if Cmp(TypeName, 'string') or Cmp(TypeName, 'PChar') or
    Cmp(TypeName, 'ANSIString') or Cmp(TypeName, 'ShortString') then
    Result := varString
  else if Cmp(TypeName, 'double') then
    Result := varDouble
  else if Cmp(TypeName, 'tdatetime') then
    Result := varDate
  else if Cmp(TypeName, 'tobject') then
    Result := varObject
  else
    Result := varEmpty;
end; { TypeName2VarTyp }

procedure ClearList(List: TList);
var
  i: Integer;
begin
  for i := 0 to List.Count - 1 do { Iterate }
    TObject(List[i]).Free;
  List.Clear;
end; { ClearList }

procedure ClearMethodList(List: TList);
var
  i: Integer;
begin
  for i := 0 to List.Count - 1 do { Iterate }
    Dispose(PMethod(List[i]));
  List.Clear;
end; { ClearMethodList }

{$IFNDEF RA_D3H}

function AnsiStrIComp(S1, S2: PChar): Integer;
begin
  Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, S1, -1,
    S2, -1) - 2;
end;
{$ENDIF}

{$IFNDEF RA_D3H}

constructor TStringStream.Create(const AString: string);
begin
  inherited Create;
  FDataString := AString;
end;

function TStringStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := Length(FDataString) - FPosition;
  if Result > Count then Result := Count;
  Move(PChar(@FDataString[FPosition + 1])^, Buffer, Result);
  Inc(FPosition, Result);
end;

function TStringStream.Write(const Buffer; Count: Longint): Longint;
begin
  Result := Count;
  SetLength(FDataString, (FPosition + Result));
  Move(Buffer, PChar(@FDataString[FPosition + 1])^, Result);
  Inc(FPosition, Result);
end;

function TStringStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  case Origin of
    soFromBeginning: FPosition := Offset;
    soFromCurrent: FPosition := FPosition + Offset;
    soFromEnd: FPosition := Length(FDataString) - Offset;
  end;
  Result := FPosition;
end;

procedure TStringStream.SetSize(NewSize: Longint);
begin
  SetLength(FDataString, NewSize);
  if FPosition > NewSize then FPosition := NewSize;
end;
{$ENDIF}


{$IFDEF RAI2_OLEAUTO}
{************* Some code from Delphi's OleAuto unit **************}
const
{$IFDEF RA_D3H}
{ Maximum number of dispatch arguments }

  MaxDispArgs = 64;
{$ENDIF RA_D3H}

{ Special variant type codes }

  varStrArg = $0048;

{ Parameter type masks }

  atVarMask = $3F;
  atTypeMask = $7F;
  atByRef = $80;

{ Call GetIDsOfNames method on the given IDispatch interface }

procedure GetIDsOfNames(Dispatch: IDispatch; Names: PChar;
  NameCount: Integer; DispIDs: PDispIDList);
var
  I, N: Integer;
  Ch: WideChar;
  P: PWideChar;
  NameRefs: array[0..MaxDispArgs - 1] of PWideChar;
  WideNames: array[0..1023] of WideChar;
  R: Integer;
begin
  I := 0;
  N := 0;
  repeat
    P := @WideNames[I];
    if N = 0 then NameRefs[0] := P else NameRefs[NameCount - N] := P;
    repeat
      Ch := WideChar(Names[I]);
      WideNames[I] := Ch;
      Inc(I);
    until Char(Ch) = #0;
    Inc(N);
  until N = NameCount;
{  if Dispatch.GetIDsOfNames(GUID_NULL, @NameRefs, NameCount,
    LOCALE_SYSTEM_DEFAULT, DispIDs) <> 0 then }
  R := Dispatch.GetIDsOfNames(GUID_NULL, @NameRefs, NameCount,
    LOCALE_SYSTEM_DEFAULT, DispIDs);
  if R <> 0 then
{$IFDEF RA_D3H}
    raise EOleError.CreateFmt(SNoMethod, [Names]);
{$ELSE}
    raise EOleError.CreateResFmt(SNoMethod, [Names]);
{$ENDIF RA_D3H}
end;

{ Central call dispatcher }

procedure VarDispInvoke(Result: PVariant; const Dispatch: Pointer;
  Names: PChar; CallDesc: PCallDesc; ParamTypes: Pointer); cdecl;
var
  DispIDs: array[0..MaxDispArgs - 1] of Integer;
begin
  GetIDsOfNames(IDispatch(Dispatch), Names, CallDesc^.NamedArgCount + 1, @DispIDs);
  if Result <> nil then VarClear(Result^);
{$IFDEF RA_D3H}
  DispatchInvoke(IDispatch(Dispatch), CallDesc, @DispIDs, @ParamTypes, Result);
{$ELSE}
  DispInvoke(Dispatch, CallDesc, @DispIDs, @ParamTypes, Result);
{$ENDIF RA_D3H}
end;
{################## from OleAuto unit ##################}
{$ENDIF RAI2_OLEAUTO}

type
  TFunc = procedure; far;
  TiFunc = function: integer; far;
  TfFunc = function: boolean; far;
  TwFunc = function: word; far;

function CallDllIns(Ins: HINST; FuncName: string; Args: TArgs;
  ParamDesc: TTypeArray; ResTyp: Word): Variant;
var
{  Func: procedure; far;
  iFunc: function: integer; far;
  fFunc: function: boolean; far;
  wFunc: function: word; far; }
  Func : TFunc ;
  iFunc: TiFunc;
  fFunc: TfFunc;
  wFunc: TwFunc;
  i: integer;
  Aint: integer;
 // Abyte : byte;
  Aword : word;
  Apointer: pointer;
  iRes: integer;
begin
  Result := Null;
  Func := GetProcAddress(Ins, PChar(FuncName));
  iFunc := @Func; fFunc := @Func; wFunc := @Func;
  if @Func <> nil then
  begin
    for i := Args.Count - 1 downto 0 do { 'stdcall' call conversion }
    begin
      case ParamDesc[i] of
        varInteger,{ ttByte,} varBoolean:
          begin Aint := Args.Values[i]; asm push Aint end; end;
        varSmallInt:
          begin Aword := Word(Args.Values[i]); asm push Aword end; end;
        varString:
          begin Apointer := PChar(string(Args.Values[i])); asm push Apointer end; end;
        else
          RAI2ErrorN(ieDllInvalidArgument, -1, FuncName);
      end;
    end;
    iRes := 0; { satisfy compiler }
    case ResTyp of
      varSmallInt:
        iRes := wFunc;
      varInteger:
        iRes := iFunc;
      varBoolean:
        iRes := integer(fFunc);
      varEmpty:
        Func;
      else
        RAI2ErrorN(ieDllInvalidResult, -1, FuncName);
    end;
    Result := iRes;
  end
  else
    RAI2Error(ieDllFunctionNotFound, -1);
end;

function CallDll(DllName, FuncName: string; Args: TArgs;
  ParamDesc: TTypeArray; ResTyp: Word): Variant;
var
  Ins: HINST;
begin
  Result := false;
  Ins := LoadLibrary(PChar(DllName));
  if Ins = 0 then
    RAI2ErrorN(ieDllErrorLoadLibrary, -1, DllName);
  try
    Result := CallDllIns(Ins, FuncName, Args, ParamDesc, ResTyp);
  finally { wrap up }
    FreeLibrary(Ins);
  end; { try/finally }
end;

procedure ConvertParamTypes(InParams: array of Word; var OutParams: TTypeArray);
var
  i: Integer;
begin
  for i := Low(InParams) to High(InParams) do { Iterate }
    OutParams[i] := InParams[i];
end; { ConvertParamTypes }

procedure ConvertParamNames(InParams: array of string;
  var OutParams: TNameArray);
var
  i: Integer;
begin
  for i := Low(InParams) to High(InParams) do { Iterate }
    OutParams[i] := InParams[i];
end; { ConvertParamTypes }

{ ************************* Array support ************************* }

const
  {Max avalaible dimension for arrays}
  RAI2_MAX_ARRAY_DIMENSION = 10;

type

  TRAI2ArrayValues = array[0..RAI2_MAX_ARRAY_DIMENSION - 1] of Integer;

  PRAI2ArrayRec = ^TRAI2ArrayRec;
  TRAI2ArrayRec = packed record
    Dimension: Integer; {number of dimensions}
    BeginPos: TRAI2ArrayValues; {starting range for all dimensions}
    EndPos: TRAI2ArrayValues; {ending range for all dimensions}
    ItemType: Integer; {array type}
    ElementSize: Integer; {size of element in bytes}
    Size: Integer; {number of elements in array}
    Memory: Pointer; {pointer to memory representation of array}
  end;
  
function GetArraySize(Dimension: Integer; BeginPos,
  EndPos: TRAI2ArrayValues): Integer;
var
  A: Integer;
begin
  Result := 1;
  for A := 0 to Dimension - 1 do
  begin
    Result := Result * ((EndPos[A] - BeginPos[A]) + 1);
  end;
end;

{Calculate starting position of element in memory}

function GetArrayOffset(Dimension: Integer; BeginPos, EndPos: TRAI2ArrayValues;
  Element: TRAI2ArrayValues): Integer;
var
  A: Integer;
  LastDim: Integer;
begin
  Result := 0;
  LastDim := 1;
  for A := 0 to Dimension - 1 do
  begin
    if (Element[A] < BeginPos[A]) or (Element[A] > EndPos[A]) then
      RAI2Error(ieArrayIndexOutOfBounds, -1);
    Result := Result + (LastDim * (Element[A] - BeginPos[A]));
    LastDim := LastDim * (EndPos[A] - BeginPos[A] + 1);
  end;
end;

{Allocate memory for new array}

function RAI2ArrayInit(const Dimension: Integer; const BeginPos,
  EndPos: TRAI2ArrayValues; const ItemType: Integer): PRAI2ArrayRec;
var
  PP: PRAI2ArrayRec;
  SS: TStringList;
  AA: Integer;
  ArraySize: Integer;
begin
  if (Dimension < 1) or (Dimension > MaxArgs) then
    RAI2Error(ieArrayBadDimension, -1);
  for AA := 0 to Dimension - 1 do
  begin
    if not (BeginPos[AA] <= EndPos[AA]) then
      RAI2Error(ieArrayBadRange, -1);
  end;

  New(PP);
  PP^.BeginPos := BeginPos;
  PP^.EndPos := EndPos;
  PP^.ItemType := ItemType;
  ArraySize := GetArraySize(Dimension, BeginPos, EndPos);
  PP^.Size := ArraySize;
  PP^.Dimension := Dimension;
  case ItemType of
    varInteger, varObject:
      begin
        PP^.ElementSize := SizeOf(Integer);
      end;
    varDouble:
      begin
        PP^.ElementSize := SizeOf(Double);
      end;
    varByte:
      begin
        PP^.ElementSize := SizeOf(Byte);
      end;
    varSmallInt:
      begin
        PP^.ElementSize := SizeOf(varSmallInt);
      end;
    varDate:
      begin
        PP^.ElementSize := SizeOf(Double);
      end;
    varString:
      begin
        PP^.ElementSize := 0;
        SS := TStringList.Create;
        for AA := 1 to ArraySize do
          SS.Add('');
        PP^.Memory := SS;
      end;
  end;
  if ItemType <> varString then
  begin
    GetMem(PP^.Memory, ArraySize * PP^.ElementSize);
    ZeroMemory(PP^.Memory, ArraySize * PP^.ElementSize);
  end;
  Result := PP;
end;

{Free memory for array}

procedure RAI2ArrayFree(RAI2ArrayRec: PRAI2ArrayRec);
begin
  if not Assigned(RAI2ArrayRec) then Exit;
  if (RAI2ArrayRec^.ItemType <> varString) then
  begin
    FreeMem(RAI2ArrayRec^.Memory, (RAI2ArrayRec^.Size) *
      RAI2ArrayRec^.ElementSize);
    Dispose(RAI2ArrayRec);
  end
  else
  begin
    TStringList(RAI2ArrayRec^.Memory).Clear;
    TStringList(RAI2ArrayRec^.Memory).Free;
    Dispose(RAI2ArrayRec);
  end;
end;

{Set element for array}

procedure RAI2ArraySetElement(Element: TRAI2ArrayValues; Value: Variant;
  RAI2ArrayRec: PRAI2ArrayRec);
var
  Offset: Integer;
begin
  if RAI2ArrayRec^.Dimension > 1 then
    Offset := GetArrayOffset(RAI2ArrayRec^.Dimension, RAI2ArrayRec^.BeginPos,
      RAI2ArrayRec^.EndPos, Element)
  else
    Offset := Element[0] - RAI2ArrayRec^.BeginPos[0];
  case RAI2ArrayRec^.ItemType of
    varInteger:
      PInteger(Pointer(Integer(RAI2ArrayRec^.Memory) +
        (Offset * RAI2ArrayRec^.ElementSize)))^ := Value;
    varDouble:
      PDouble(Pointer(Integer(RAI2ArrayRec^.Memory) +
        (Offset * RAI2ArrayRec^.ElementSize)))^ := Value;
    varByte:
      PByte(Pointer(Integer(RAI2ArrayRec^.Memory) +
        (Offset * RAI2ArrayRec^.ElementSize)))^ := Value;
    varSmallInt:
      PSmallInt(Pointer(Integer(RAI2ArrayRec^.Memory) +
        (Offset * RAI2ArrayRec^.ElementSize)))^ := Value;
    varDate:
      PDouble(Pointer(Integer(RAI2ArrayRec^.Memory) +
        (Offset * RAI2ArrayRec^.ElementSize)))^ := Value;
    varString:
      begin
        Value := VarAsType(Value, varString);
        TStringList(RAI2ArrayRec^.Memory).Strings[Offset] := Value;
      end;
    varObject:
      PInteger(Pointer(Integer(RAI2ArrayRec^.Memory) +
        (Offset * RAI2ArrayRec^.ElementSize)))^ := TVarData(Value).VInteger;
  end;
end;

{Get element for array}

function RAI2ArrayGetElement(Element: TRAI2ArrayValues; RAI2ArrayRec:
  PRAI2ArrayRec): Variant;
var
  Offset: Integer;
begin
  if RAI2ArrayRec^.Dimension > 1 then
    Offset := GetArrayOffset(RAI2ArrayRec^.Dimension, RAI2ArrayRec^.BeginPos,
      RAI2ArrayRec^.EndPos, Element)
  else
    Offset := Element[0] - RAI2ArrayRec^.BeginPos[0];
  case RAI2ArrayRec^.ItemType of
    varInteger:
      Result := Integer(Pointer(Integer(RAI2ArrayRec^.Memory) + ((Offset) *
        RAI2ArrayRec^.ElementSize))^);
    varDouble:
      Result := Double(Pointer(Integer(RAI2ArrayRec^.Memory) + ((Offset) *
        RAI2ArrayRec^.ElementSize))^);
    varByte:
      Result := Byte(Pointer(Integer(RAI2ArrayRec^.Memory) + ((Offset) *
        RAI2ArrayRec^.ElementSize))^);
    varSmallInt:
      Result := SmallInt(Pointer(Integer(RAI2ArrayRec^.Memory) + ((Offset) *
        RAI2ArrayRec^.ElementSize))^);
    varDate:
      Result := TDateTime(Pointer(Integer(RAI2ArrayRec^.Memory) + ((Offset) *
        RAI2ArrayRec^.ElementSize))^);
    varString:
      Result := TStringList(RAI2ArrayRec^.Memory).Strings[Offset];
    varObject:
      begin
        Result := Integer(Pointer(Integer(RAI2ArrayRec^.Memory) + ((Offset) *
          RAI2ArrayRec^.ElementSize))^);
        TVarData(Result).VType := varObject;
      end;
  end;
end;

{ ########################## Array support ########################## }


{ ************************** TRAI2VarList ************************** }

destructor TRAI2VarList.Destroy;
{-----olej------}
var
  i, II: Integer;
  VarRec: TRAI2Var;
{-----olej------}
begin
{-----olej------}
  for i := 0 to Count - 1 do { Iterate }
  begin
    VarRec := TRAI2Var(Items[i]);
    if VarRec.VTyp = varArray then
    begin
      II := VarRec.Value;
      RAI2ArrayFree(PRAI2ArrayRec(II));
    end;
  end;
{-----olej------}
  ClearList(Self);
  inherited Destroy;
end;

procedure TRAI2VarList.AddVar(const Identifer, Typ: string; VTyp: Word;
  const Value: Variant);
var
  VarRec: TRAI2Var;
begin
  VarRec := TRAI2Var.Create;
  VarRec.Identifer := Identifer;
  VarRec.Value := Value;
  VarRec.Typ := Typ;
  VarRec.VTyp := VTyp;
  Insert(0, VarRec);
end;

function TRAI2VarList.FindVar(const Identifer: string): TRAI2Var;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do { Iterate }
  begin
    Result := TRAI2Var(Items[i]);
    if Cmp(Result.Identifer, Identifer) then
      Exit;
  end;
  Result := nil;
end;

procedure TRAI2VarList.DeleteVar(const Identifer: string);
var
  i: Integer;
  VarRec: TRAI2Var;
  {-----olej----}
  II: Integer;
  {-----olej----}
begin
  for i := 0 to Count - 1 do { Iterate }
  begin
    VarRec := TRAI2Var(Items[i]);
    if Cmp(VarRec.Identifer, Identifer) then
    begin
      {-----olej----}
      if VarRec.VTyp = varArray then
      begin
        II := VarRec.Value;
        RAI2ArrayFree(PRAI2ArrayRec(II));
      end;
      {-----olej----}
      VarRec.Free;
      Delete(i);
      Exit;
    end;
  end;
end; { DeleteVar }

function TRAI2VarList.GetValue(Identifer: string; var Value: Variant;
  Args: TArgs): Boolean;
var
  V: TRAI2Var;
  II2: Integer;
  VV: TRAI2ArrayValues;
  PP: PRAI2ArrayRec;
  Bound: Integer;
begin
  V := FindVar(Identifer);
  Result := (V <> nil) and (Args.Obj = nil);
  if Result then
  begin
    if Args.Count <> 0 then
    begin
      if V.VTyp <> varArray then
        RAI2Error(ieROCRequired, -1);
      {Get array value}
      PP := PRAI2ArrayRec(Integer(V.Value));
      if Args.Count > PP.Dimension then
        RAI2Error(ieArrayTooManyParams, -1)
      else if Args.Count < PP.Dimension then
        RAI2Error(ieArrayNotEnoughParams, -1);
      for II2 := 0 to Args.Count - 1 do
      begin
        Bound := Args.Values[II2];
        if Bound < PP.BeginPos[II2] then
          RAI2Error(ieArrayIndexOutOfBounds, -1)
        else if Bound > PP.EndPos[II2] then
          RAI2Error(ieArrayIndexOutOfBounds, -1);
        VV[II2] := Args.Values[II2];
      end;
      Value := RAI2ArrayGetElement(VV, PP);
      Result := True;
    end
    else
    begin
      Result := True;
      Value := V.Value;
    end;
  end
end; { GetValue }

function TRAI2VarList.SetValue(Identifer: string; const Value: Variant;
  Args: TArgs): Boolean;
var
  V: TRAI2Var;
  II2: Integer;
  VV: TRAI2ArrayValues;
  PP: PRAI2ArrayRec;
  Bound: Integer;
begin
  V := FindVar(Identifer);
  Result := (V <> nil) and (Args.Obj = nil);
  if Result then
  begin
    if Args.Count <> 0 then
    begin
      if V.VTyp <> varArray then
        RAI2Error(ieROCRequired, -1);

      PP := PRAI2ArrayRec(Integer(V.Value));
      if Args.Count > PP.Dimension then
        RAI2Error(ieArrayTooManyParams, -1)
      else if Args.Count < PP.Dimension then
        RAI2Error(ieArrayNotEnoughParams, -1);
      for II2 := 0 to Args.Count - 1 do
      begin
        Bound := Args.Values[II2];
        if Bound < PP.BeginPos[II2] then
          RAI2Error(ieArrayIndexOutOfBounds, -1)
        else if Bound > PP.EndPos[II2] then
          RAI2Error(ieArrayIndexOutOfBounds, -1);
        VV[II2] := Args.Values[II2];
      end;
      RAI2ArraySetElement(VV, Value, PP);
      Result := True;
    end
    else
    begin
      Result := True;
      V.Value := Value;
    end;
  end
end; { SetValue }

{ ************************** TAdapter ************************** }

constructor TRAI2RecHolder.Create(ARecordType: string; ARec: Pointer);
begin
  RecordType := ARecordType;
  Rec := ARec;
  FRefCount := 1;
{$IFDEF RAI2_DEBUG}
  inc(ObjCount);
{$ENDIF}
end; { Create }

destructor TRAI2RecHolder.Destroy;
begin
  if Assigned(RAI2Record) then
  begin
    if Assigned(RAI2Record.DestroyFunc) then
      RAI2Record.DestroyFunc(Rec)
    else
      FreeMem(Rec, RAI2Record.RecordSize);
  end
  else
    RAI2Error(ieInternal, -1);
  inherited Destroy;
end;

function TRAI2RecHolder.GetRAI2Record: TRAI2Record;
begin
  Result := RAI2Record;
end;

function TRAI2RecHolder.GetSelf: TRAI2RecHolder;
begin
  Result := Self;
end;

{$IFDEF RA_D3H}

function TRAI2RecHolder.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;
{$ELSE}

function TRAI2RecHolder.QueryInterface(const IID: TGUID; var Obj): HResult;
begin
  if IsEqualIID(iid, IID_IUnknown) or IsEqualIID(iid, IID_IRAI2Rec) then
  begin
    Pointer(obj) := Self;
    AddRef;
    Result := S_OK;
  end else
  begin
    Pointer(obj) := nil;
    Result := E_NOINTERFACE;
  end;
end;
{$ENDIF}

{$IFDEF RA_D3H}

function TRAI2RecHolder._AddRef: Longint;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;
{$ELSE}

function TRAI2RecHolder.AddRef: Longint;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;
{$ENDIF}

{$IFDEF RA_D3H}

function TRAI2RecHolder._Release: Longint;
begin
  Dec(FRefCount);
  Result := FRefCount;
  if Result = 0 then
  begin
    Destroy;
{$IFDEF RAI2_DEBUG}
    dec(ObjCount);
{$ENDIF}
  end;
end;
{$ELSE}

function TRAI2RecHolder.Release: Longint;
begin
  Dec(FRefCount);
  Result := FRefCount;
  if Result = 0 then
  begin
    Destroy;
{$IFDEF RAI2_DEBUG}
    dec(ObjCount);
{$ENDIF}
  end;
end;
{$ENDIF}

function TRAI2ExtFun.CallDll(Args: TArgs): Variant;
begin
  if DllInstance > 0 then
    Result := RAI2.CallDllIns(DllInstance, FunName, Args, FunDesc.ParamTypes,
      FunDesc.ResTyp)
  else
    Result := RAI2.CallDll(DllName, FunName, Args, FunDesc.ParamTypes,
      FunDesc.ResTyp)
end;


{************************ TRAI2Event ************************}

constructor TRAI2Event.Create(AOwner: TRAI2Expression; AFunName: string);
begin
  Owner := AOwner;
  FunName := AFunName;
end;

destructor TRAI2Event.Destroy;
begin
  FArgs.Free;
  inherited Destroy;
end; { Destroy }

function TRAI2Event.GetArgs: TArgs;
begin
  if FArgs = nil then
    FArgs := TArgs.Create;
  Result := FArgs;
end;

function TRAI2Event.CallFunction(Args: TArgs; Params: array of Variant)
  : Variant;
var
  i: Integer;
begin
  if Args = nil then
    Args := Self.Args;
  Args.Clear;
  for i := Low(Params) to High(Params) do { Iterate }
  begin
    Args.Values[Args.Count] := Params[i];
    inc(Args.Count);
  end; { for }
  Result := Owner.CallFunction(FunName, Args, Null);
end;
{######################## TRAI2Event ########################}

{ TIdentiferList }

function TRAI2IdentiferList.Find(const S: string; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := AnsiStrIComp(PChar(TRAI2Identifer(List[I]).Identifer), PChar(S));
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then L := I;
      end;
    end;
  end;
  Index := L;
end;

procedure TRAI2IdentiferList.Sort;

  function SortIdentifer(Item1, Item2: Pointer): Integer;
  begin
    { function AnsiStrIComp about 30% faster when AnsiCompareText }
    { Result := AnsiCompareText(TRAI2Identifer(Item1).Identifer,
       TRAI2Identifer(Item2).Identifer); }
    Result := AnsiStrIComp(PChar(TRAI2Identifer(Item1).Identifer),
      PChar(TRAI2Identifer(Item2).Identifer));
  end;

begin
  inherited Sort(@SortIdentifer);
end;

{************************ TRAI2Adapter ************************}

constructor TRAI2Adapter.Create(AOwner: TRAI2Expression);
begin
  FOwner := AOwner;
  FSrcUnitList := TRAI2IdentiferList.Create;
  FExtUnitList := TRAI2IdentiferList.Create;
  FGetList := TRAI2IdentiferList.Create;
  FGetList.Duplicates := dupAccept;
  FSetList := TRAI2IdentiferList.Create;
  FDGetList := TRAI2IdentiferList.Create;
  FClassList := TRAI2IdentiferList.Create;
  FConstList := TRAI2IdentiferList.Create;
  FFunList := TRAI2IdentiferList.Create;
  FRecList := TRAI2IdentiferList.Create;
  FRecGetList := TRAI2IdentiferList.Create;
  FRecSetList := TRAI2IdentiferList.Create;
  FOnGetList := TRAI2IdentiferList.Create;
  FOnSetList := TRAI2IdentiferList.Create;
  FExtFunList := TRAI2IdentiferList.Create;
  FSrcFunList := TRAI2IdentiferList.Create;
  FEventHandlerList := TRAI2IdentiferList.Create;
  FEventList := TRAI2IdentiferList.Create;
end;

destructor TRAI2Adapter.Destroy;
begin
  Clear;
  FSrcUnitList.Free;
  FExtUnitList.Free;
  FGetList.Free;
  FSetList.Free;
  FDGetList.Free;
  FClassList.Free;
  FConstList.Free;
  FFunList.Free;
  FRecList.Free;
  FRecGetList.Free;
  FRecSetList.Free;
  FOnGetList.Free;
  FOnSetList.Free;
  FExtFunList.Free;
  FSrcFunList.Free;
  FEventHandlerList.Free;
  FEventList.Free;
  inherited Destroy;
end;

{ clear source }

procedure TRAI2Adapter.ClearSource;
begin
  ClearList(FSrcUnitList);
  ClearList(FSrcFunList);
end;

{ clear all except source }

procedure TRAI2Adapter.ClearNonSource;
begin
  ClearList(FExtUnitList);
  ClearList(FGetList);
  ClearList(FSetList);
  ClearList(FDGetList);
  ClearList(FClassList);
  ClearList(FConstList);
  ClearList(FFunList);
  ClearList(FRecList);
  ClearList(FRecGetList);
  ClearList(FRecSetList);
  ClearList(FExtFunList);
  ClearList(FEventHandlerList);
  ClearList(FEventList);
  ClearMethodList(FOnGetList);
  ClearMethodList(FOnSetList);
end;

{ clear all }

procedure TRAI2Adapter.Clear;
begin
  ClearSource;
  ClearNonSource;
end;

procedure TRAI2Adapter.Assign(Source: TRAI2Adapter);
var
  i: Integer;
begin
  if Source = Self then Exit;

  for i := 0 to Source.FGetList.Count - 1 do { Iterate }
    with TRAI2Method(Source.FGetList[i]) do
      AddGet(ClassType, Identifer, Func, ParamCount, ParamTypes);
  for i := 0 to Source.FSetList.Count - 1 do { Iterate }
    with TRAI2Method(Source.FSetList[i]) do
      AddSet(ClassType, Identifer, Func, ParamCount, ParamTypes);
  for i := 0 to Source.FDGetList.Count - 1 do { Iterate }
    with TRAI2DMethod(Source.FDGetList[i]) do
      AddDGet(ClassType, Identifer, Func, ParamCount, ParamTypes, ResTyp,
        CallConvention);
  for i := 0 to Source.FFunList.Count - 1 do { Iterate }
    with TRAI2Method(Source.FFunList[i]) do
      AddFun(UnitName, Identifer, Func, ParamCount, ParamTypes);
  for i := 0 to Source.FExtUnitList.Count - 1 do { Iterate }
    with TRAI2Identifer(Source.FExtUnitList[i]) do
      AddExtUnit(Identifer);
  for i := 0 to Source.FClassList.Count - 1 do { Iterate }
    with TRAI2Class(Source.FClassList[i]) do
      AddClass(UnitName, ClassType, Identifer);
  for i := 0 to Source.FConstList.Count - 1 do { Iterate }
    with TRAI2Const(Source.FConstList[i]) do
      AddConst(UnitName, Identifer, Value);
  for i := 0 to Source.FRecList.Count - 1 do { Iterate }
    with TRAI2Record(Source.FRecList[i]) do
      AddRec(UnitName, Identifer, RecordSize, Fields, CreateFunc,
        DestroyFunc, CopyFunc);
  for i := 0 to Source.FRecGetList.Count - 1 do { Iterate }
    with TRAI2RecMethod(Source.FRecGetList[i]) do
      AddRecGet(UnitName, RAI2Record.Identifer, Identifer, Func, ParamCount,
        ParamTypes);
  for i := 0 to Source.FRecSetList.Count - 1 do { Iterate }
    with TRAI2RecMethod(Source.FRecSetList[i]) do
      AddRecSet(UnitName, RAI2Record.Identifer, Identifer, Func, ParamCount,
        ParamTypes);
  for i := 0 to Source.FExtFunList.Count - 1 do { Iterate }
    with TRAI2ExtFun(Source.FExtFunList[i]) do
      AddExtFun(UnitName, Identifer, DllInstance, DllName, FunName, FunIndex,
        FunDesc.ParamCount, FunDesc.ParamTypes, FunDesc.ResTyp);
  for i := 0 to Source.FEventHandlerList.Count - 1 do { Iterate }
    with TRAI2EventDesc(Source.FEventHandlerList[i]) do
      AddHandler(UnitName, Identifer, EventClass, Code);
  for i := 0 to Source.FEventList.Count - 1 do { Iterate }
    with TRAI2Class(Source.FEventList[i]) do
      AddEvent(UnitName, ClassType, Identifer);
  for i := 0 to Source.FOnGetList.Count - 1 do { Iterate }
    AddOnGet(TRAI2GetValue(PMethod(Source.FOnGetList[i])^));
  for i := 0 to Source.FOnSetList.Count - 1 do { Iterate }
    AddOnSet(TRAI2SetValue(PMethod(Source.FOnSetList[i])^));
end;

procedure TRAI2Adapter.AddGet(ClassType: TClass; Identifer: string;
  GetFunc: TRAI2AdapterGetValue; ParamCount: Integer; ParamTypes: array of Word);
var
  RAI2Method: TRAI2Method;
begin
  if ClassType <> nil then
  begin
    RAI2Method := TRAI2Method.Create;
    RAI2Method.ClassType := ClassType;
    RAI2Method.Identifer := Identifer;
    RAI2Method.Func := @GetFunc;
    RAI2Method.ParamCount := ParamCount;
    ConvertParamTypes(ParamTypes, RAI2Method.ParamTypes);
    FGetList.Add(RAI2Method);
  end
  else
    AddFun('', Identifer, GetFunc, ParamCount, ParamTypes);
end;

procedure TRAI2Adapter.AddDGet(ClassType: TClass; Identifer: string;
  GetFunc: Pointer; ParamCount: Integer; ParamTypes: array of Word;
  ResTyp: Word; CallConvention: TCallConvention);
var
  RAI2Method: TRAI2DMethod;
begin
  RAI2Method := TRAI2DMethod.Create;
  RAI2Method.ClassType := ClassType;
  RAI2Method.Identifer := Identifer;
  RAI2Method.Func := GetFunc;
  RAI2Method.ParamCount := ParamCount;
  ConvertParamTypes(ParamTypes, RAI2Method.ParamTypes);
  RAI2Method.ResTyp := ResTyp;
  RAI2Method.CallConvention := CallConvention;
  FDGetList.Add(RAI2Method);
end;

procedure TRAI2Adapter.AddSet(ClassType: TClass; Identifer: string;
  SetFunc: TRAI2AdapterSetValue; ParamCount: Integer; ParamTypes: array of Word);
var
  RAI2Method: TRAI2Method;
begin
  RAI2Method := TRAI2Method.Create;
  RAI2Method.ClassType := ClassType;
  RAI2Method.Identifer := Identifer;
  RAI2Method.Func := @SetFunc;
  RAI2Method.ParamCount := ParamCount;
  ConvertParamTypes(ParamTypes, RAI2Method.ParamTypes);
  FSetList.Add(RAI2Method);
end;

procedure TRAI2Adapter.AddFun(UnitName: string; Identifer: string;
  GetFunc: TRAI2AdapterGetValue; ParamCount: Integer; ParamTypes: array of Word);
var
  RAI2Method: TRAI2Method;
begin
  RAI2Method := TRAI2Method.Create;
  RAI2Method.Identifer := Identifer;
  RAI2Method.Func := @GetFunc;
  RAI2Method.ParamCount := ParamCount;
  ConvertParamTypes(ParamTypes, RAI2Method.ParamTypes);
  FFunList.Add(RAI2Method);
end;

procedure TRAI2Adapter.AddSrcUnit(Identifer: string; Source: string;
  UsesList: string);
var
  RAI2Unit: TRAI2UnitSource;
  S: string;
  i: Integer;
begin
  RAI2Unit := TRAI2UnitSource.Create;
  RAI2Unit.Identifer := Identifer;
  RAI2Unit.Source := Source;
  i := 0;
  S := Trim(SubStr(UsesList, i, ','));
  while S <> '' do
  begin
    RAI2Unit.UsesList[i] := S;
    inc(i);
    S := Trim(SubStr(UsesList, i, ','));
  end; { while }
  FSrcUnitList.Add(RAI2Unit);
end;

procedure TRAI2Adapter.AddExtUnit(Identifer: string);
var
  RAI2Unit: TRAI2Identifer;
begin
  RAI2Unit := TRAI2Identifer.Create;
  RAI2Unit.Identifer := Identifer;
  FExtUnitList.Add(RAI2Unit);
end;

procedure TRAI2Adapter.AddClass(UnitName: string; ClassType: TClass;
  Identifer: string);
var
  RAI2Class: TRAI2Class;
begin
  RAI2Class := TRAI2Class.Create;
  RAI2Class.ClassType := ClassType;
  RAI2Class.Identifer := Identifer;
  FClassList.Add(RAI2Class);
end;

procedure TRAI2Adapter.AddConst(UnitName: string; Identifer: string;
  Value: Variant);
var
  RAI2Const: TRAI2Const;
begin
  RAI2Const := TRAI2Const.Create;
  RAI2Const.Identifer := Identifer;
  RAI2Const.Value := Value;
  FConstList.Add(RAI2Const);
end;

procedure TRAI2Adapter.AddRec(UnitName: string; Identifer: string;
  RecordSize: Integer; Fields: array of TRAI2RecFieldDef;
  CreateFunc: TRAI2AdapterNewRecord; DestroyFunc: TRAI2AdapterDisposeRecord;
  CopyFunc: TRAI2AdapterCopyRecord);
var
  RAI2Record: TRAI2Record;
  i: Integer;
begin
  RAI2Record := TRAI2Record.Create;
  RAI2Record.Identifer := Identifer;
  RAI2Record.RecordSize := RecordSize;
  RAI2Record.CreateFunc := CreateFunc;
  RAI2Record.DestroyFunc := DestroyFunc;
  RAI2Record.CopyFunc := CopyFunc;
  for i := Low(Fields) to High(Fields) do { Iterate }
    RAI2Record.Fields[i] := Fields[i];
  RAI2Record.FieldCount := High(Fields) - Low(Fields) + 1;
  FRecList.Add(RAI2Record);
end;

procedure TRAI2Adapter.AddRecGet(UnitName: string; RecordType: string;
  Identifer: string; GetFunc: TRAI2AdapterGetValue;
  ParamCount: Integer; ParamTypes: array of Word);
var
  RecMethod: TRAI2RecMethod;
begin
  RecMethod := TRAI2RecMethod.Create;
  RecMethod.RAI2Record := GetRec(RecordType) as TRAI2Record;
  RecMethod.Identifer := Identifer;
  RecMethod.Func := @GetFunc;
  RecMethod.ParamCount := ParamCount;
  ConvertParamTypes(ParamTypes, RecMethod.ParamTypes);
  FRecGetList.Add(RecMethod);
end;

procedure TRAI2Adapter.AddRecSet(UnitName: string; RecordType: string;
  Identifer: string; SetFunc: TRAI2AdapterSetValue;
  ParamCount: Integer; ParamTypes: array of Word);
var
  RecMethod: TRAI2RecMethod;
begin
  RecMethod := TRAI2RecMethod.Create;
  RecMethod.RAI2Record := GetRec(RecordType) as TRAI2Record;
  RecMethod.Identifer := Identifer;
  RecMethod.Func := @SetFunc;
  RecMethod.ParamCount := ParamCount;
  ConvertParamTypes(ParamTypes, RecMethod.ParamTypes);
  FRecSetList.Add(RecMethod);
end;

procedure TRAI2Adapter.AddExtFun(UnitName: string; Identifer: string;
  DllInstance: HINST; DllName: string; FunName: string; FunIndex: integer;
  ParamCount: Integer; ParamTypes: array of Word; ResTyp: Word);
var
  RAI2ExtFun: TRAI2ExtFun;
begin
  RAI2ExtFun := TRAI2ExtFun.Create;
  RAI2ExtFun.FunDesc.UnitName := UnitName;
  RAI2ExtFun.Identifer := Identifer;
  RAI2ExtFun.DllInstance := DllInstance;
  RAI2ExtFun.DllName := DllName;
  RAI2ExtFun.FunName := FunName;
  RAI2ExtFun.FunIndex := FunIndex;
  RAI2ExtFun.FunDesc.ParamCount := ParamCount;
  RAI2ExtFun.FunDesc.ResTyp := ResTyp;
  ConvertParamTypes(ParamTypes, RAI2ExtFun.FunDesc.ParamTypes);
  FExtFunList.Add(RAI2ExtFun);
end;

procedure TRAI2Adapter.AddSrcFun(UnitName: string; Identifer: string;
  PosBeg, PosEnd: integer; ParamCount: Integer; ParamTypes: array of Word;
  ParamNames: array of string; ResTyp: Word);
var
  RAI2SrcFun: TRAI2SrcFun;
begin
  RAI2SrcFun := TRAI2SrcFun.Create;
  RAI2SrcFun.FunDesc.UnitName := UnitName;
  RAI2SrcFun.FunDesc.Identifer := Identifer;
  RAI2SrcFun.FunDesc.PosBeg := PosBeg;
  RAI2SrcFun.FunDesc.PosEnd := PosEnd;
  RAI2SrcFun.FunDesc.ParamCount := ParamCount;
  RAI2SrcFun.Identifer := Identifer;
  ConvertParamTypes(ParamTypes, RAI2SrcFun.FunDesc.ParamTypes);
  ConvertParamNames(ParamNames, RAI2SrcFun.FunDesc.ParamNames);
  RAI2SrcFun.FunDesc.ResTyp := ResTyp;
  FSrcFunList.Add(RAI2SrcFun);
end;

procedure TRAI2Adapter.AddHandler(UnitName: string; Identifer: string;
  EventClass: TRAI2EventClass; Code: Pointer);
var
  RAI2EventDesc: TRAI2EventDesc;
begin
  RAI2EventDesc := TRAI2EventDesc.Create;
  RAI2EventDesc.UnitName := UnitName;
  RAI2EventDesc.Identifer := Identifer;
  RAI2EventDesc.EventClass := EventClass;
  RAI2EventDesc.Code := Code;
  FEventHandlerList.Add(RAI2EventDesc);
end;

procedure TRAI2Adapter.AddEvent(UnitName: string; ClassType: TClass;
  Identifer: string);
var
  RAI2Event: TRAI2Class;
begin
  RAI2Event := TRAI2Class.Create;
  RAI2Event.UnitName := UnitName;
  RAI2Event.Identifer := Identifer;
  RAI2Event.ClassType := ClassType;
  FEventList.Add(RAI2Event);
end;

procedure TRAI2Adapter.AddOnGet(Method: TRAI2GetValue);
var
  PM: PMethod;
begin
  New(PM);
  PM^ := TMethod(Method);
  FOnGetList.Add(PM);
end;

procedure TRAI2Adapter.AddOnSet(Method: TRAI2SetValue);
var
  PM: PMethod;
begin
  New(PM);
  PM^ := TMethod(Method);
  FOnSetList.Add(PM);
end;

function TRAI2Adapter.GetRec(RecordType: string): TObject;
var
  i: Integer;
begin
  for i := 0 to FRecList.Count - 1 do { Iterate }
  begin
    Result := FRecList[i];
    if Cmp(TRAI2Record(Result).Identifer, RecordType) then
      Exit;
  end; { for }
  //RAI2ErrorN(ieRecordNotDefined, -1, RecordType);
  Result := nil;
end; { GetRec }

procedure TRAI2Adapter.CheckArgs(var Args: TArgs; ParamCount: Integer;
  var ParamTypes: TTypeArray);
var
  i: Integer;
begin
  if ParamCount = prArgsNoCheck then Exit;
  if Args.Count > ParamCount then
    RAI2Error(ieTooManyParams, -1);
  if Args.Count < ParamCount then
    RAI2Error(ieNotEnoughParams, -1);

  Args.HasVars := False;
  Args.Types := ParamTypes;
  for i := 0 to Args.Count - 1 do { Iterate }
    if (Args.VarNames[i] <> '') and
      ((ParamTypes[i] and varByRef) <> 0) then
    begin
      Args.HasVars := True;
      Break;
    end;
end; { CheckArgs }

function TRAI2Adapter.FindFunDesc(const Identifer: string): PFunDesc;
var
  i: Integer;
begin
  for i := FSrcFunList.Count - 1 downto 0 do { Iterate }
  begin
    Result := @TRAI2SrcFun(FSrcFunList.Items[i]).FunDesc;
    if Cmp(Result.Identifer, Identifer) then
      Exit;
  end; { for }
  Result := nil;
end;

function TRAI2Adapter.GetValue(Identifer: string; var Value: Variant;
  Args: TArgs): Boolean;
var
  Unk: IUnknown;

  function GetMethod: boolean;
  var
    i: Integer;
    RAI2Method: TRAI2Method;
  begin
    Result := GetValueRTTI(Identifer, Value, Args);
    if Result then Exit;
    if FGetList.Find(Identifer, i) then
      for i := i to FGetList.Count - 1 do { Iterate }
      begin
        RAI2Method := TRAI2Method(FGetList[i]);
        if Assigned(RAI2Method.Func) and
          (((Args.ObjTyp = varObject) and
          (Args.Obj is RAI2Method.ClassType)) or
          ((Args.ObjTyp = varClass) and
          (TClass(Args.Obj) = RAI2Method.ClassType))) {?!} then
        begin
          Args.Identifer := Identifer;
          CheckArgs(Args, RAI2Method.ParamCount, RAI2Method.ParamTypes);
          TRAI2AdapterGetValue(RAI2Method.Func)(Value, Args);
          Result := True;
          Exit;
        end;
        if not Cmp(RAI2Method.Identifer, Identifer) then Break;
      end;
    if Cmp(Identifer, 'Free') then
    begin
      Result := True;
      Args.Obj.Free;
      Args.Obj := nil;
      Value := Null;
      Exit;
    end;
  end; {  }

  { function DGetMethod under construction }
  function DGetMethod: boolean;
  var
    RAI2Method: TRAI2DMethod;
    i, j: Integer;
    Aint: integer;
    Aword : word;
    iRes: integer;
    Func: Pointer;
    REAX, REDX, RECX: Integer;
  begin
    Result := False;
    iRes := 0; { satisfy compiler }
    for i := 0 to FDGetList.Count - 1 do    { Iterate }
    begin
      RAI2Method := TRAI2DMethod(FDGetList[i]);
      Func := RAI2Method.Func;
      if Assigned(RAI2Method.Func) and
         (((Args.ObjTyp = varObject) and
          (Args.Obj is RAI2Method.ClassType)) { or
          ((Args.ObjTyp = varClass) and
          (TClass(Args.Obj) = RAI2Method.ClassType))})  and
         Cmp(RAI2Method.Identifer, Identifer) then
      begin
        Args.Identifer := Identifer;
        CheckArgs(Args, RAI2Method.ParamCount, RAI2Method.ParamTypes);
        if ccFastCall in RAI2Method.CallConvention then
        begin
         { !!! Delphi fast-call !!! }
  
         { push parameters to stack }
          for j := 2 to RAI2Method.ParamCount - 1 do
            case RAI2Method.ParamTypes[j] of
              varInteger, varObject, varPointer, varBoolean{?}:
                begin Aint := Args.Values[j]; asm push Aint end; end;
              varSmallInt:
                begin Aword := Word(Args.Values[j]); asm push Aword end; end;
              else
                RAI2ErrorN(ieDirectInvalidArgument, -1, Identifer);
            end;
          REAX := Integer(Args.Obj);
          if RAI2Method.ParamCount > 0 then
            case RAI2Method.ParamTypes[0] of
              varInteger, varObject, varPointer, varBoolean, varSmallInt,
              varString:
                REDX := TVarData(Args.Values[0]).vInteger;
              else
                RAI2ErrorN(ieDirectInvalidArgument, -1, Identifer);
            end;
          if RAI2Method.ParamCount > 1 then
            case RAI2Method.ParamTypes[1] of
              varInteger, varObject, varPointer, varBoolean, varSmallInt,
              varString:
                RECX := TVarData(Args.Values[1]).vInteger
              else
                RAI2ErrorN(ieDirectInvalidArgument, -1, Identifer);
            end;
          case RAI2Method.ResTyp of
            varSmallInt, varInteger, varBoolean, varEmpty, varObject,
            varPointer:
              asm
                mov      EAX, REAX
                mov      EDX, REDX
                mov      ECX, RECX
                call     Func
                mov      iRes, EAX
              end;
            else
              RAI2ErrorN(ieDirectInvalidResult, -1, Identifer);
          end;
         { clear result }
          case RAI2Method.ResTyp of
            varInteger, varObject:
              Value := iRes;
            varSmallInt:
              Value := iRes and $0000FFFF;
            varBoolean:
              begin
                Value := iRes and $000000FF;
                TVarData(Value).VType := varBoolean;
              end;
            varEmpty:
              Value := Null;
          end;
        end
        else
          RAI2ErrorN(ieDirectInvalidConvention, -1, Identifer);
        Result := True;
        Exit;
      end;
    end;
  end;    {  }

  function GetRecord: Boolean;
  var
    i: Integer;
    UnkRAI2Record: TRAI2Record;
    Rec: PChar;
    RAI2RecMethod: TRAI2RecMethod;
  begin
    Result := False;
    UnkRAI2Record := IRAI2Rec(Unk).RAI2Record;
{$IFNDEF RA_D3H}
    Unk.Release;
{$ENDIF}
    for i := 0 to UnkRAI2Record.FieldCount - 1 do { Iterate }
      if Cmp(UnkRAI2Record.Fields[i].Identifer, Identifer) then
      begin
        Rec := P2R(Args.Obj);
        with UnkRAI2Record.Fields[i] do
          case Typ of { }
            varInteger:
              Value := PInteger(Rec + Offset)^;
            varSmallInt:
              Value := SmallInt(PWord(Rec + Offset)^);
            varBoolean:
              Value := PBool(Rec + Offset)^;
            varString:
              Value := PString(Rec + Offset)^;
          end; { case }
        Result := True;
        Exit;
      end; { for }
    for i := 0 to FRecGetList.Count - 1 do { Iterate }
    begin
      RAI2RecMethod := TRAI2RecMethod(FRecGetList[i]);
      if (RAI2RecMethod.RAI2Record = UnkRAI2Record) and
        Cmp(RAI2RecMethod.Identifer, Identifer) then
      begin
        Args.Identifer := Identifer;
        CheckArgs(Args, RAI2RecMethod.ParamCount, RAI2RecMethod.ParamTypes);
        TRAI2AdapterGetValue(RAI2RecMethod.Func)(Value, Args);
        Result := True;
        Exit;
      end;
    end
  end;

  function GetConst: boolean;
  var
    i: Integer;
  begin
    if Cmp(Identifer, 'nil') then
    begin
      Value := P2V(nil);
      Result := True;
      Exit;
    end;
    if Cmp(Identifer, 'Null') then
    begin
      Value := Null;
      Result := True;
      Exit;
    end;
    Result := FConstList.Find(Identifer, i);
    if Result then
      Value := TRAI2Const(FConstList[i]).Value;
  end; {  }

  function GetClass: boolean;
  var
    i: Integer;
  begin
    Result := FClassList.Find(Identifer, i);
    if Result then
    begin
      if Args.Count = 0 then
        Value := C2V(TRAI2Class(FClassList[i]).ClassType)
      else
        if Args.Count = 1 then
       { typecasting }
        begin
          Value := Args.Values[0];
          if TVarData(Value).VType <> varClass then
            TVarData(Value).VType := varObject;
        end
        else
          RAI2Error(ieTooManyParams, -1);
    end;
  end; {  }

  function GetFun: boolean;
  var
    i: Integer;
    RAI2Method: TRAI2Method;
  begin
    Result := FFunList.Find(Identifer, i);
    if Result then
    begin
      RAI2Method := TRAI2Method(FFunList[i]);
      if Cmp(RAI2Method.Identifer, Identifer) then
      begin
        Args.Identifer := Identifer;
        CheckArgs(Args, RAI2Method.ParamCount, RAI2Method.ParamTypes);
        TRAI2AdapterGetValue(RAI2Method.Func)(Value, Args);
      end;
    end;
  end; {  }

  function GetExtFun: boolean;
  var
    i: Integer;
    RAI2ExtFun: TRAI2ExtFun;
  begin
    Result := False;
    for i := 0 to FExtFunList.Count - 1 do { Iterate }
    begin
      RAI2ExtFun := TRAI2ExtFun(FExtFunList[i]);
      if Cmp(RAI2ExtFun.Identifer, Identifer) then
      begin
        Args.Identifer := Identifer;
        CheckArgs(Args, RAI2ExtFun.FunDesc.ParamCount,
          RAI2ExtFun.FunDesc.ParamTypes);
        Value := RAI2ExtFun.CallDll(Args);
        Result := True;
        Exit;
      end;
    end;
  end; {  }

{$IFDEF RAI2_OLEAUTO}
  function GetOleAutoFun: boolean;
  begin
    Result := False;
    if Cmp(Identifer, 'CreateOleObject') or
      Cmp(Identifer, 'GetActiveOleObject') or
      Cmp(Identifer, 'GetOleObject') then
    begin
      FParams[0] := varString;
      CheckArgs(Args, 1, FParams);
      if Cmp(Identifer, 'CreateOleObject') then
        Value := CreateOleObject(Args.Values[0])
      else if Cmp(Identifer, 'CreateOleObject') then
        Value := GetActiveOleObject(Args.Values[0])
      else { GetOleObject }
      begin
        try
          Value := GetActiveOleObject(Args.Values[0])
        except
          on E: EOleError do
            Value := CreateOleObject(Args.Values[0])
        end;
      end;
      Result := True;
      Exit;
    end;
  end; {  }
{$ENDIF RAI2_OLEAUTO}

  function TypeCast: Boolean;
  var
    VT: Word;
  begin
    VT := TypeName2VarTyp(Identifer);
    Result := VT <> varEmpty;
    if Result then
    begin
      Value := Args.Values[0];
      TVarData(Value).VType := VT;
    end;
  end;

var
  i: Integer;
begin
  Result := True;
  if not FSorted then Sort;
  if Args.Obj <> nil then
  begin
   { methods }
    if Args.ObjTyp in [varObject, varClass] then
      if GetMethod or DGetMethod then Exit else
    else
      if (Args.ObjTyp = varUnknown) and
        (IUnknown(Pointer(Args.Obj)).QueryInterface(IID_IRAI2Rec, Unk)
        = NOERROR) then
     { records }
        if GetRecord then Exit else
      else
        if Args.ObjTyp = varDispatch then
     { Ole automation call }
        begin
{$IFDEF RAI2_OLEAUTO}
          Result := DispatchCall(Identifer, Value, Args, True);
          if Result then Exit;
{$ELSE}
          NotImplemented('Ole automation call');
{$ENDIF RAI2_OLEAUTO}
        end;
  end
  else {if Args.Obj = nil then }
  begin
   { classes }
    if GetClass then Exit;
   { constants }
    if GetConst then Exit;
   { classless functions and procedures }
    if GetFun then Exit;
   { external functions }
    if GetExtFun then Exit;
{$IFDEF RAI2_OLEAUTO}
    if GetOleAutoFun then Exit;
{$ENDIF RAI2_OLEAUTO}
    if TypeCast then Exit;
  end;

  for i := 0 to FOnGetList.Count - 1 do { Iterate }
  begin
    TRAI2GetValue(FOnGetList[i]^)(Self, Identifer, Value, Args, Result);
    if Result then Exit;
  end;
  Result := False;
end;

function TRAI2Adapter.SetValue(Identifer: string; const Value: Variant;
  Args: TArgs): Boolean;
var
  Unk: IUnknown;

  function SetMethod: boolean;
  var
    i: Integer;
    RAI2Method: TRAI2Method;
  begin
    Result := SetValueRTTI(Identifer, Value, Args);
    if Result then Exit;
    for i := 0 to FSetList.Count - 1 do { Iterate }
    begin
      RAI2Method := TRAI2Method(FSetList[i]);
      if Assigned(RAI2Method.Func) and
        (Args.Obj is RAI2Method.ClassType) and
        Cmp(RAI2Method.Identifer, Identifer) then
      begin
        Args.Identifer := Identifer;
        CheckArgs(Args, RAI2Method.ParamCount, RAI2Method.ParamTypes);
        TRAI2AdapterSetValue(RAI2Method.Func)(Value, Args);
        Result := True;
        Exit;
      end;
    end;
  end; {  }

  function SetRecord: boolean;
  var
    i: Integer;
    UnkRAI2Record: TRAI2Record;
    RAI2RecMethod: TRAI2RecMethod;
    Rec: PChar;
  begin
    Result := False;
    UnkRAI2Record := IRAI2Rec(Unk).RAI2Record;
{$IFNDEF RA_D3H}
    Unk.Release;
{$ENDIF}
    for i := 0 to UnkRAI2Record.FieldCount - 1 do { Iterate }
      if Cmp(UnkRAI2Record.Fields[i].Identifer, Identifer) then
      begin
        Rec := P2R(Args.Obj);
        with UnkRAI2Record.Fields[i] do
          case Typ of { }
            varInteger:
              PInteger(Rec + Offset)^ := Value;
            varSmallInt:
              PWord(Rec + Offset)^ := Word(Value);
            varBoolean:
              PBool(Rec + Offset)^ := Value;
          end; { case }
        Result := True;
        Exit;
      end; { for }
    for i := 0 to FRecSetList.Count - 1 do { Iterate }
    begin
      RAI2RecMethod := TRAI2RecMethod(FRecSetList[i]);
      if (RAI2RecMethod.RAI2Record = UnkRAI2Record) and
        Cmp(RAI2RecMethod.Identifer, Identifer) then
      begin
        Args.Identifer := Identifer;
        CheckArgs(Args, RAI2RecMethod.ParamCount, RAI2RecMethod.ParamTypes);
        TRAI2AdapterSetValue(RAI2RecMethod.Func)(Value, Args);
        Result := True;
        Exit;
      end;
    end
  end; {  }

var
  i: Integer;
  V: Variant;
begin
  Result := True;
  if Args.Obj <> nil then
  begin
   { methods }
    if Args.ObjTyp in [varObject, varClass] then
      if SetMethod then Exit else
    else
      if (Args.ObjTyp = varUnknown) and
        (IUnknown(Pointer(Args.Obj)).QueryInterface(IID_IRAI2Rec, Unk)
        = NOERROR) then
     { RAI2Record }
        if SetRecord then Exit else
      else
        if Args.ObjTyp = varDispatch then
     { Ole automation call }
        begin
{$IFDEF RAI2_OLEAUTO}
          V := Value;
          Result := DispatchCall(Identifer, V, Args, False);
          if Result then Exit;
{$ELSE}
          NotImplemented('Ole automation call');
{$ENDIF RAI2_OLEAUTO}
        end;
  end;

  for i := 0 to FOnSetList.Count - 1 do { Iterate }
  begin
    TRAI2SetValue(FOnSetList[i]^)(Self, Identifer, Value, Args, Result);
    if Result then Exit;
  end;
  Result := False;
end;

function TRAI2Adapter.SetUnknown(var Value: Variant): Boolean;
var
  Unk: IUnknown;
  RecHolder: TRAI2RecHolder;
begin
  if IUnknown(TVarData(Value).VUnknown).QueryInterface(IID_IRAI2Rec, Unk)
    = NOERROR then
  begin
   { IRAI2Rec }
   { reset RAI2Record  }
    RecHolder := IRAI2Rec(Unk).GetSelf;
{$IFNDEF RA_D3H}
    Unk.Release;
{$ENDIF RA_D3H}
    RecHolder.RAI2Record := TRAI2Record(GetRec(RecHolder.RecordType));
    Result := Assigned(RecHolder.RAI2Record);
  end
  else
    Result := False;
end;

function TRAI2Adapter.NewRecord(RecordType: string;
  var Value: Variant): Boolean;
var
  i, j: Integer;
  RAI2Record: TRAI2Record;
  Rec: PChar;
begin
  for i := 0 to FRecList.Count - 1 do { Iterate }
  begin
    RAI2Record := TRAI2Record(FRecList[i]);
    if Cmp(RAI2Record.Identifer, RecordType) then
    begin
      if Assigned(RAI2Record.CreateFunc) then
        RAI2Record.CreateFunc(Pointer(Rec))
      else
      begin
        GetMem(Rec, RAI2Record.RecordSize);
        for j := 0 to RAI2Record.FieldCount - 1 do { Iterate }
          if RAI2Record.Fields[j].Typ = varString then
            PString(PString(Rec + RAI2Record.Fields[j].Offset)^) := NewStr('');
      end;
      Value := R2V(RecordType, Rec);
      Result := SetUnknown(Value);
      Exit;
    end;
  end; { for }
  Result := False;
end;

{$IFDEF RAI2_OLEAUTO}

function TRAI2Adapter.DispatchCall(Identifer: string; var Value: Variant;
  Args: TArgs; Get: Boolean): Boolean; stdcall;
var
  CallDesc: TCallDesc;
  ParamTypes: array[0..MaxDispArgs * 4 - 1] of byte;
  ParamsPtr: Pointer absolute ParamTypes;
  Ptr: Integer;

  procedure AddParam(Param: Variant);

    procedure AddParam1(Typ: byte; ParamSize: Integer; var Param);
    begin
      CallDesc.ArgTypes[Ptr] := Typ;
      Move(Param, ParamTypes[Ptr], ParamSize);
      inc(Ptr, ParamSize);
    end;

  var
    Int: Integer;
    Wrd: WordBool;
    Poin: Pointer;
  begin
    case TVarData(Param).VType of
      varInteger:
        begin
          Int := Param;
          AddParam1(varInteger, sizeof(Int), Int);
        end;
      varString:
        begin
          Poin := V2P(Param);
          AddParam1(varStrArg, sizeof(Poin), Poin);
        end;
      varBoolean:
        begin
          Wrd := WordBool(Param);
          AddParam1(varBoolean, sizeof(Wrd), Wrd);
        end;
    end;
  end; { AddParam1 }

var
  PVRes: PVariant;
  Names: string;
  i: Integer;
begin
  Result := True;
 {Âûחûגאול לועמה קונוח Ole Automation}
  with CallDesc do
  begin
    if Get then
      CallType := DISPATCH_METHOD or DISPATCH_PROPERTYGET
    else
      CallType := DISPATCH_PROPERTYPUT;
    ArgCount := Args.Count;
    NamedArgCount := 0; { named args not supported by RAI2 }
  end;
  Names := Identifer + #00;
  Ptr := 0;
  if not Get then
  begin
    AddParam(Value);
    inc(CallDesc.ArgCount);
  end;
  for i := 0 to Args.Count - 1 do
    AddParam(Args.Values[i]);
  Value := Null;
 { When calling procedures(without result) PVRes must be nil }
  if Args.HasResult and Get then
    PVRes := @Value
  else
    PVRes := nil;
  try
   { call }
    VarDispInvoke(PVRes, Args.Obj, PChar(Names), @CallDesc, ParamsPtr);
  except
    on E: EOleError do
      RAI2ErrorN2(ieOleAuto, -1, Identifer, E.Message);
  end;
  if Get and (TVarData(Value).VType = varOleStr) then
    Value := VarAsType(Value, varString);
end;
{$ENDIF RAI2_OLEAUTO}

function TRAI2Adapter.GetValueRTTI(Identifer: string; var Value: Variant;
  Args: TArgs): Boolean;
var
  TypeInf: PTypeInfo;
  PropInf: PPropInfo;
  PropTyp: TypInfo.TTypeKind;
begin
  Result := False;
  if (Args.ObjTyp <> varObject) or (Args.Obj = nil) then Exit;
  TypeInf := Args.Obj.ClassInfo;
  if TypeInf = nil then Exit;
  PropInf := GetPropInfo(TypeInf, Identifer);
  if PropInf = nil then Exit;
  PropTyp := PropInf.PropType^.Kind;
  case PropTyp of
    tkInteger, tkEnumeration:
      Value := GetOrdProp(Args.Obj, PropInf);
    tkChar, tkWChar:
      Value := Char(GetOrdProp(Args.Obj, PropInf));
    tkFloat:
      Value := GetFloatProp(Args.Obj, PropInf);
    tkString, tkLString{$IFDEF RA_D3H}, tkWString{$ENDIF RA_D3H}:
      Value := GetStrProp(Args.Obj, PropInf);
    tkClass:
      Value := O2V(TObject(GetOrdProp(Args.Obj, PropInf)));
    tkSet:
      Value := S2V(GetOrdProp(Args.Obj, PropInf));
  else
    Exit;
  end;
  if PropInf^.PropType^.Name = 'Boolean' then
    TVarData(Value).VType := varBoolean;
  Result := True;
end;

function TRAI2Adapter.SetValueRTTI(Identifer: string; const Value: Variant;
  Args: TArgs): Boolean;
var
  TypeInf: PTypeInfo;
  PropInf: PPropInfo;
  PropTyp: TypInfo.TTypeKind;
  Obj: TObject;
begin
  Result := False;
  if (Args.ObjTyp <> varObject) or (Args.Obj = nil) then Exit;
  Obj := Args.Obj;
  TypeInf := Obj.ClassInfo;
  if TypeInf = nil then Exit;
  PropInf := GetPropInfo(TypeInf, Identifer);
  if PropInf = nil then Exit;
  PropTyp := PropInf.PropType^.Kind;
  case PropTyp of
    tkInteger, tkEnumeration:
      SetOrdProp(Args.Obj, PropInf, Var2Type(Value, varInteger));
    tkChar, tkWChar:
      SetOrdProp(Args.Obj, PropInf, integer(string(Value)[1]));
    tkFloat:
      SetFloatProp(Args.Obj, PropInf, Value);
    tkString, tkLString{$IFDEF RA_D3H}, tkWString{$ENDIF RA_D3H}:
      SetStrProp(Args.Obj, PropInf, VarToStr(Value));
    tkClass:
      SetOrdProp(Args.Obj, PropInf, integer(V2O(Value)));
    tkSet:
      SetOrdProp(Args.Obj, PropInf, V2S(Value));
  else
    Exit;
  end;
  Result := True;
end;

procedure TRAI2Adapter.UnitChanged(NewUnitName: string; var Source: string);
var
  i: Integer;
begin
  for i := 0 to FSrcUnitList.Count - 1 do { Iterate }
  begin
    CurUnit := TRAI2UnitSource(FSrcUnitList.Items[i]);
    if Cmp(TRAI2UnitSource(CurUnit).Identifer, NewUnitName) then
    begin
      Source := TRAI2UnitSource(CurUnit).Source;
      Exit;
    end;
  end; { for }
  CurUnit := nil;
  Source := '';
end;

function TRAI2Adapter.UnitExists(const Identifer: string): Boolean;
var
  RAI2Identifer: TRAI2Identifer;
  i: Integer;
begin
  Result := True;
  for i := 0 to FSrcUnitList.Count - 1 do { Iterate }
  begin
    RAI2Identifer := TRAI2Identifer(FSrcUnitList.Items[i]);
    if Cmp(RAI2Identifer.Identifer, Identifer) then
      Exit;
  end; { for }
  for i := 0 to FExtUnitList.Count - 1 do { Iterate }
  begin
    RAI2Identifer := TRAI2Identifer(FExtUnitList.Items[i]);
    if Cmp(RAI2Identifer.Identifer, Identifer) then
      Exit;
  end; { for }
  Result := False;
end;

function TRAI2Adapter.NewEvent(const FunName, EventType: string;
  AOwner: TRAI2Expression): TSimpleEvent;
var
  Event: TRAI2Event;
  i: Integer;
  RAI2EventDesc: TRAI2EventDesc;
begin
  for i := 0 to FEventHandlerList.Count - 1 do { Iterate }
  begin
    RAI2EventDesc := TRAI2EventDesc(FEventHandlerList.Items[i]);
    if Cmp(RAI2EventDesc.Identifer, EventType) then
    begin
      Event := RAI2EventDesc.EventClass.Create(AOwner, FunName);
      TMethod(Result).Code := RAI2EventDesc.Code;
      TMethod(Result).Data := Event;
      Exit;
    end;
  end; { for }
  Result := nil; { satisfy compiler }
end; { NewEvent }

function TRAI2Adapter.IsEvent(Obj: TObject; const Identifer: string)
  : Boolean;
var
  RAI2Class: TRAI2Class;
  i: Integer;
begin
  for i := 0 to FEventList.Count - 1 do { Iterate }
  begin
    RAI2Class := TRAI2Class(FEventList[i]);
    if (Obj is RAI2Class.ClassType) and
      Cmp(RAI2Class.Identifer, Identifer) then
    begin
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

procedure TRAI2Adapter.Sort;
begin
  FConstList.Sort;
  FClassList.Sort;
  FFunList.Sort;
  FGetList.Sort;
  FSorted := True;
end;


{ ************************* TArgs ************************* }

procedure TArgs.Clear;
begin
  Count := 0;
  Obj := nil;
  ObjTyp := 0;
  HasVars := False;
end;

destructor TArgs.Destroy;
begin
  if OA <> nil then Dispose(OA);
  if OAV <> nil then Dispose(OAV);
  inherited Destroy;
end; { Destroy }

procedure TArgs.OpenArray(const index: Integer);
begin
  if OA = nil then New(OA);
  if OAV = nil then New(OAV);
  V2OA(Values[index], OA^, OAV^, OAS);
end;

procedure TArgs.Delete(const Index: Integer);
var
  i: Integer;
begin
  for i := Index to Count - 2 do
  begin
    Types[i] := Types[i + 1];
    Values[i] := Values[i + 1];
    Names[i] := Names[i + 1];
  end;
  dec(Count);
end;

{ ************************* TRAI2Expression ************************* }

constructor TRAI2Expression.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parser := TRAI2Parser.Create;
  FPStream := TStringStream.Create('');
  FArgs := TArgs.Create;
  FAdapter := CreateAdapter;
  FGlobalAdapter := True;
end; { Create }

destructor TRAI2Expression.Destroy;
begin
  FVResult := Null;
  FAdapter.Free;
  FArgs.Free;
  FPStream.Free;
  Parser.Free;
  inherited Destroy;
end; { Destroy }

function TRAI2Expression.UpdateExceptionPos(E: Exception; const UnitName: string): Exception;
begin
  if (E is ERAI2Error) and not (E as ERAI2Error).ExceptionPos then
    with E as ERAI2Error do
    begin
      if ErrPos = -1 then
        ErrPos := CurPos;
      if ErrUnitName = '' then
        ErrUnitName := UnitName;
      if ErrUnitName <> '' then
      begin
        ErrLine := GetLineByPos(Parser.Source, ErrPos) + BaseErrLine + 1
           { first line has number 1 };
        Message := Format(LoadStr2(ieErrorPos + ResBase),
          [ErrUnitName, ErrLine, Message1]);
        ExceptionPos := True;
      end;
    end;
  Result := E;
end; { UpdateExceptionPos }

procedure TRAI2Expression.Init;
begin
  FVResult := Null;
  ExpStackPtr := -1;
 // Parse;
  Parser.Init;
  FBacked := False;
  Args := FArgs;
  FAdapter.ClearNonSource;
end; { Init }

function TRAI2Expression.GetSource: string;
begin
  Result := Parser.Source;
end; { GetSource }

procedure TRAI2Expression.SetSource(Value: string);
begin
  Parser.Source := Value;
  SourceChanged;
end; { SetSource }

procedure TRAI2Expression.SourceChanged;
begin
end; { SourceChanged }

procedure TRAI2Expression.SetAdapter(Adapter: TRAI2Adapter);
begin
  FAdapter := Adapter;
end; { SetAdapter }

procedure TRAI2Expression.SetCurPos(Value: Integer);
begin
  if FParsed then
    FPStream.Position := Value
  else
    Parser.Pos := Value;
  FBacked := False;
end; { SetCurPos }

function TRAI2Expression.GetCurPos: Integer;
begin
  if FParsed then
    Result := FPStream.Position
  else
    Result := Parser.Pos;
end; { GetCurPos }

procedure TRAI2Expression.ErrorExpected(Exp: string);
begin
  if TokenStr <> '' then
    RAI2ErrorN2(ieExpected, PosBeg, Exp, '''' + TokenStr + '''')
  else
    RAI2ErrorN2(ieExpected, PosBeg, Exp, LoadStr(irEndOfFile));
end; { ErrorExpected }

procedure TRAI2Expression.ErrorNotImplemented(Message: string);
begin
  RAI2ErrorN(ieInternal, PosBeg, Message + ' not implemented');
end; { ErrorNotImplemented }

function TRAI2Expression.PosBeg: Integer;
begin
  Result := CurPos - Length(TokenStr);
end; { PosBeg }

function TRAI2Expression.PosEnd: Integer;
begin
  Result := CurPos;
end; { PosEnd }

function TRAI2Expression.GetTokenStr: string;
begin
  if FParsed and (TTyp <> ttUnknown) then
    Result := TypToken(TTyp)
  else
    Result := TokenStr1;
end; { GetTokenStr }

procedure TRAI2Expression.Parse;
begin
{$IFNDEF RA_D2}
  FPStream.Size := 0;
{$ELSE}
  (FPStream as TStringStream).SetSize(0);
{$ENDIF}
  FPStream.Position := 0;
  Parser.Init;
  repeat
    ParseToken;
    WriteToken;
  until TTyp1 = ttEmpty;
  FParsed := True;
  FPStream.Position := 0;
end; { Parse }

procedure TRAI2Expression.WriteToken;
begin
  WordSaveToStream(FPStream, Word(TTyp1));
  case TTyp1 of
    ttInteger:
      IntSaveToStream(FPStream, Token1);
    ttString:
      StringSaveToStream(FPStream, Token1);
    ttTrue, ttFalse:
      BoolSaveToStream(FPStream, Token1);
    ttDouble:
      ExtendedSaveToStream(FPStream, Token1);
    ttIdentifer:
      StringSaveToStream(FPStream, Token1);
    ttUnknown:
      StringSaveToStream(FPStream, TokenStr1);
  end;
end; { WriteToken }

procedure TRAI2Expression.ReadToken;
begin
  TTyp1 := SmallInt(WordLoadFromStream(FPStream));
  case TTyp1 of
    ttInteger:
      Token1 := IntLoadFromStream(FPStream);
    ttString:
      Token1 := StringLoadFromStream(FPStream);
    ttTrue, ttFalse:
      Token1 := BoolLoadFromStream(FPStream);
    ttDouble:
      Token1 := ExtendedLoadFromStream(FPStream);
    ttIdentifer:
      Token1 := StringLoadFromStream(FPStream);
    ttUnknown:
      TokenStr1 := StringLoadFromStream(FPStream);
  end;
end; { ReadParsed }

procedure TRAI2Expression.NextToken;
begin
  if FBacked then
    FBacked := False
  else
  begin
    PrevTTyp := TTyp1;
    if FParsed then
      ReadToken
    else
      ParseToken;
  end;
end; { NextToken }

procedure TRAI2Expression.ParseToken;
var
  OldDecimalSeparator: char;
  Dob: Extended;
  Int: Integer;
  Stub: Integer;
begin
  TokenStr1 := Parser.Token;
  TTyp1 := TokenTyp(TokenStr1);
  case TTyp of { }
    ttInteger:
      begin
        Val(TokenStr1, Int, Stub);
        Token1 := Int;
      end;
    ttDouble:
      begin
        OldDecimalSeparator := DecimalSeparator;
        DecimalSeparator := '.';
        if not TextToFloat(PChar(TokenStr1), Dob, fvExtended) then
        begin
          DecimalSeparator := OldDecimalSeparator;
          RAI2Error(ieInternal, -1);
        end
        else
          DecimalSeparator := OldDecimalSeparator;
        Token1 := Dob;
      end;
    ttString:
      Token1 := Copy(TokenStr, 2, Length(TokenStr1) - 2);
    ttFalse:
      Token1 := False;
    ttTrue:
      Token1 := True;
    ttIdentifer:
      Token1 := TokenStr1;
    {-----olej-----}
    ttArray:
      Token1 := TokenStr1;
    {-----olej-----}
  end; { case }
end; { ParseToken }

procedure TRAI2Expression.Back;
begin
//  RAI2Error(ieInternal, -2);
  if FBacked then
    RAI2Error(ieInternal, -1);
  FBacked := True;
end; { Back }

procedure TRAI2Expression.SafeBack;
begin
  if not FBacked then
    Back;
end; { SafeBack }

function TRAI2Expression.CreateAdapter: TRAI2Adapter;
begin
  Result := TRAI2Adapter.Create(Self);
end; { CreateAdapter }

function TRAI2Expression.Expression1: Variant;

  procedure PushExp(var Value: Variant);
  begin
    inc(ExpStackPtr);
    if ExpStackPtr > High(ExpStack) then
      RAI2Error(ieInternal, -1);
    ExpStack[ExpStackPtr] := Value;
  end; { PushExp }

  function PopExp: Variant;
  begin
    if ExpStackPtr = -1 then
      RAI2Error(ieInternal, -1);
    Result := ExpStack[ExpStackPtr];
    dec(ExpStackPtr);
  end; { PopExp }

  { function Expression called recursively very often, so placing it
    as local function (not class method) improve performance }
  function Expression(const OpTyp: TTokenTyp): Variant;
  var
    Tmp: Variant;
  begin
    Result := Unassigned;
    if OpTyp <> ttUnknown then
      NextToken;
    while True do
    begin
      case TTyp of { }
        ttInteger, ttDouble, ttString, ttFalse, ttTrue, ttIdentifer:
          begin
            Result := Token;
            if TTyp = ttIdentifer then
            begin
              Args.Clear;
              InternalGetValue(nil, 0, Result);
            end;
            NextToken;
            if TTyp in [ttInteger, ttDouble, ttString,
              ttFalse, ttTrue, ttIdentifer] then
              RAI2Error(ieMissingOperator, PosEnd {!!});
            if Prior(TTyp) < Prior(OpTyp) then
              Exit;
          end;
        ttMul:
          if priorMul > Prior(OpTyp) then
            Result := PopExp * Expression(TTyp)
          else Exit;
        ttPlus:
         { proceed differently depending on a types }
          if not (PrevTTyp in [ttInteger, ttDouble, ttString, ttFalse, ttTrue,
            ttIdentifer, ttRB, ttRS]) then
           { unar plus }
            Result := Expression(ttNot {highest priority})
          else
            if priorPlus > Prior(OpTyp) then
            begin
              Tmp := PopExp;
              if TVarData(Tmp).VType = varSet then
              begin
                Result := TVarData(Tmp).VInteger or
                  TVarData(Expression(TTyp)).VInteger;
                TVarData(Result).VType := varSet;
              end else
                Result := Tmp + Expression(TTyp)
            end else Exit;
        ttMinus:
         { proceed differently depending on a types }
          if not (PrevTTyp in [ttInteger, ttDouble, ttString, ttFalse, ttTrue,
            ttIdentifer, ttRB, ttRS]) then
           { unar minus }
            Result := -Expression(ttNot {highest priority})
          else
            if priorMinus > Prior(OpTyp) then
            begin
              Tmp := PopExp;
              if TVarData(Tmp).VType = varSet then
              begin
                Result := TVarData(Tmp).VInteger and not
                  TVarData(Expression(TTyp)).VInteger;
                TVarData(Result).VType := varSet;
              end else
                Result := Tmp - Expression(TTyp)
            end else Exit;
        ttDiv:
          if priorDiv > Prior(OpTyp) then
            Result := PopExp / Expression(TTyp)
          else Exit;
        ttIntDiv:
          if priorIntDiv > Prior(OpTyp) then
            Result := PopExp div Expression(TTyp)
          else Exit;
        ttMod:
          if priorMod > Prior(OpTyp) then
            Result := PopExp mod Expression(TTyp)
          else Exit;
        ttOr:
          if priorOr > Prior(OpTyp) then
            Result := PopExp or Expression(TTyp)
          else Exit;
        ttAnd:
          if priorAnd > Prior(OpTyp) then
            Result := PopExp and Expression(TTyp)
          else Exit;
        ttNot:
         { 'Not' has highest priority, so we have not need to check this }
         // if priorNot > Prior(OpTyp) then
          Result := not Expression(TTyp);
         //  else Exit;
        ttEqu:
         { proceed differently depending on a types }
          if priorEqu > Prior(OpTyp) then
          begin
            Tmp := PopExp;
            if TVarData(Tmp).VType in [varObject, varClass, varSet, varPointer] then
              Result := TVarData(Tmp).VInteger =
                TVarData(Expression(TTyp)).VInteger
            else
              Result := Tmp = Expression(TTyp)
          end else Exit;
        ttNotEqu:
         { proceed differently depending on a types }
          if priorNotEqu > Prior(OpTyp) then
          begin
            Tmp := PopExp;
            if TVarData(Tmp).VType in [varObject, varClass, varSet, varPointer] then
              Result := TVarData(Tmp).VInteger <>
                TVarData(Expression(TTyp)).VInteger
            else
              Result := Tmp <> Expression(TTyp)
          end else Exit;
        ttGreater:
          if priorGreater > Prior(OpTyp) then
            Result := PopExp > Expression(TTyp)
          else Exit;
        ttLess:
          if priorLess > Prior(OpTyp) then
            Result := PopExp < Expression(TTyp)
          else Exit;
        ttEquLess:
          if priorEquLess > Prior(OpTyp) then
            Result := PopExp <= Expression(TTyp)
          else Exit;
        ttEquGreater:
          if priorEquGreater > Prior(OpTyp) then
            Result := PopExp >= Expression(TTyp)
          else Exit;
        ttLB:
          begin
            Result := Expression(TTyp);
            if TTyp1 <> ttRB then
              ErrorExpected(''')''');
            NextToken;
          end;
        ttRB:
          if TVarData(Result).VType = varEmpty then
            ErrorExpected(LoadStr(irExpression))
          else Exit;
        ttLS:
          begin
            NextToken;
            Result := SetExpression1;
            if TTyp1 <> ttRS then
              ErrorExpected(''']''');
            NextToken;
          end;
        ttRS:
          if TVarData(Result).VType = varEmpty then
            ErrorExpected(LoadStr(irExpression))
          else Exit;
      else
        if TVarData(Result).VType = varEmpty then
          ErrorExpected(LoadStr(irExpression))
        else Exit;
      end; { case }
      PushExp(Result);
    end;
  end; { Expression }
var
  OldExpStackPtr: Integer;
begin
  Result := Null;
  try
    OldExpStackPtr := ExpStackPtr;
    try
      Expression(ttUnknown);
      Result := PopExp;
    finally
      ExpStackPtr := OldExpStackPtr;
    end;
  except
    on E: EVariantError do
      RAI2Error(ieTypeMistmatch, CurPos);
  end; { try/except }
end; { Expression1 }

function TRAI2Expression.Expression2(const ExpType: Word): Variant;
var
  ErrPos: Integer;
begin
  ErrPos := PosBeg;
  Result := Expression1;
  if TVarData(Result).VType <> ExpType then
    case ExpType of { }
      varInteger:
        RAI2Error(ieIntegerRequired, ErrPos);
      varBoolean:
        RAI2Error(ieBooleanRequired, ErrPos);
    else
      RAI2Error(ieUnknown, ErrPos);
    end; { case }
end; { Expression2 }

{ calulate sets expressions, such as: [fsBold, fsItalic] }

function TRAI2Expression.SetExpression1: Variant;
var
  V1: Variant;
begin
  Result := 0;
  while True do
  begin
    case TTyp of { }
      ttIdentifer, ttInteger:
        begin
          if TTyp = ttInteger then
            Result := Result or Integer(Token)
          else
          begin
            Args.Clear;
            InternalGetValue(nil, 0, V1);
            if VarType(V1) <> varInteger then
              RAI2Error(ieIntegerRequired, PosBeg);
            Result := Result or 1 shl Integer(V1);
          end;
          NextToken; { skip ',' }
          if TTyp = ttCol then
            NextToken
          else if TTyp = ttRS then
            Break
          else
            ErrorExpected(''']''');
        end;
      ttRS:
        Break;
    else
      Break;
    end;
  end;
  TVarData(Result).VType := varSet;
end; { SetExpression1 }

procedure TRAI2Expression.InternalGetValue(Obj: Pointer; ObjTyp: Word;
  var Result: Variant);

  procedure ReadArgs;
  var
    LocalArgs: TArgs;

    function ReadOpenArray: Variant;
    var
      Values: TValueArray;
      i: Integer;
    begin
     { open array or set constant }
      NextToken;
      Values[0] := Expression1;
      i := 1;
      while TTyp = ttCol do
      begin
        NextToken;
        Args.Clear;
        Values[i] := Expression1;
        inc(i);
      end; { while }
      if TTyp <> ttRS then
        ErrorExpected(''']''');
      Result := VarArrayCreate([0, i], varVariant);
      for i := 0 to i - 1 do { Iterate }
        Result[i] := Values[i];
      NextToken;
    end;

  var
    i: Integer;
    SK: TTokenTyp;
  begin
    LocalArgs := Args;
    Args := TArgs.Create;
    try
      i := 0;
      if TTyp = ttLB then
        SK := ttRB
      else { if TTyp = ttLS then }
        SK := ttRS;

      NextToken;
      if TTyp = ttIdentifer then
        LocalArgs.VarNames[i] := Token else
        LocalArgs.VarNames[i] := '';

      Args.Clear;
      if TTyp = ttLS then
        LocalArgs.Values[i] := ReadOpenArray else
        LocalArgs.Values[i] := Expression1;

      while TTyp = ttCol do
      begin
        inc(i);
        NextToken;
        if TTyp = ttIdentifer then
          LocalArgs.VarNames[i] := Token else
          LocalArgs.VarNames[i] := '';
        Args.Clear;
        if TTyp = ttLS then
          LocalArgs.Values[i] := ReadOpenArray else
          LocalArgs.Values[i] := Expression1;
      end; { while }
      if TTyp <> SK then
        if SK = ttRB then
          ErrorExpected(''')''') else ErrorExpected(''']''');
      NextToken;
      LocalArgs.Count := i + 1;
    finally { wrap up }
      Args.Free;
      Args := LocalArgs;
    end; { try/finally }
  end; { ReadArgs }

  procedure UpdateVarParams;
  var
    i, C: Integer;
  begin
    if not Args.HasVars then Exit;
    C := Args.Count;
    Args.Obj := nil;
    Args.ObjTyp := 0;
    Args.Count := 0;
    for i := 0 to C - 1 do { Iterate }
      if (Args.VarNames[i] <> '') and ((Args.Types[i] and varByRef) <> 0) then
      {  if not } SetValue(Args.VarNames[i], Args.Values[i], Args) {then
          RAI2ErrorN(ieUnknownIdentifer, PosBeg, Args.VarNames[i])};
    Args.HasVars := False;
  end; { SetVarParams }

var
  Identifer: string;
  V: Variant;
begin
  Identifer := Token;
  NextToken;
  if TTyp in [ttLB, ttLS] then
    ReadArgs
  else
    Args.Count := 0;
  Args.Obj := Obj;
  Args.ObjTyp := ObjTyp;
  if TTyp = ttColon then
  begin
    Back;
    Token1 := Identifer; {!!!!!!!!!!!!!!}
    { Args.Obj, Args.ObjTyp, Args.Count needed in caller }
    Exit;
  end;

  { need result if object field or method or assignment }
  Args.HasResult := (TTyp = ttPoint) or Args.Assignment;

  if GetValue(Identifer, Result, Args) then
  begin
    if TVarData(Result).VType = varUnknown then
      if not (FAdapter.SetUnknown(Result) or
        GlobalRAI2Adapter.SetUnknown(Result)) then
        RAI2ErrorN(ieRecordNotDefined, -1, 'Unknown RecordType');
   { Args.HasVars may be changed in previous call to GetValue }
    if Args.HasVars then
      UpdateVarParams
  end
  else
    RAI2ErrorN(ieUnknownIdentifer, PosBeg {?}, Identifer);

  Args.Obj := nil;
  Args.ObjTyp := 0;
  Args.Count := 0;
 { Args.Obj, Args.ObjTyp, Args.Count NOT needed in caller }

  if TTyp = ttPoint then { object field or method }
  begin
    NextToken;
    if TTyp <> ttIdentifer then
      ErrorExpected(LoadStr(irIdentifer));
    if not (TVarData(Result).VType in
      [varObject, varClass, varUnknown, varDispatch]) then
      RAI2Error(ieROCRequired, PosBeg);

    V := Null;
    InternalGetValue(TVarData(Result).vPointer, TVarData(Result).VType, V);
    Result := V;

    NextToken;
  end;
  Back;
end; { InternalGetValue }

procedure TRAI2Expression.Run;
begin
  Init;
  NextToken;
  FVResult := Expression1;
end; { Run }

function TRAI2Expression.GetValue(Identifer: string; var Value: Variant;
  var Args: TArgs): Boolean;
begin
  try
    Result := FAdapter.GetValue(Identifer, Value, Args);
    if not Result and FGlobalAdapter and
      Assigned(GlobalRAI2Adapter) and (FAdapter <> GlobalRAI2Adapter) then
      Result := GlobalRAI2Adapter.GetValue(Identifer, Value, Args);
  except
    on E: Exception do
    begin
      UpdateExceptionPos(E, '');
      raise;
    end;
  end;
  if not Result and Assigned(FOnGetValue) then
    FOnGetValue(Self, Identifer, Value, Args, Result);
end; { GetValue }

function TRAI2Expression.SetValue(Identifer: string; const Value: Variant;
  var Args: TArgs): Boolean;
begin
  try
    Result := FAdapter.SetValue(Identifer, Value, Args);
    if not Result and FGlobalAdapter and
      Assigned(GlobalRAI2Adapter) and (FAdapter <> GlobalRAI2Adapter) then
      Result := GlobalRAI2Adapter.SetValue(Identifer, Value, Args);
  except
    on E: ERAI2Error do
    begin
      E.ErrPos := PosBeg;
      raise;
    end;
  end;
  if not Result and Assigned(FOnSetValue) then
    FOnSetValue(Self, Identifer, Value, Args, Result);
end; { SetValue }


{ ************************ TRAI2Function ************************ }

constructor TRAI2Function.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FunStack := TList.Create;
  SS := TStringList.Create;
end; { Create }

destructor TRAI2Function.Destroy;
begin
  SS.Free;
  FunStack.Free;
  inherited Destroy;
end; { Destroy }

procedure TRAI2Function.Init;
begin
  inherited Init;
  FBreak := False;
  FContinue := False;
  FunStack.Clear;
  StateStackPtr := -1;
end; { Init }

procedure TRAI2Function.PushState;
begin
  inc(StateStackPtr);
  if StateStackPtr > High(StateStack) then
    RAI2Error(ieInternal, -1);
  StateStack[StateStackPtr].Token := Token1;
  StateStack[StateStackPtr].TTyp := TTyp1;
  StateStack[StateStackPtr].PrevTTyp := PrevTTyp;
  StateStack[StateStackPtr].Backed := FBacked;
  StateStack[StateStackPtr].CurPos := CurPos;
end; { PushState }

procedure TRAI2Function.PopState;
begin
  if StateStackPtr = -1 then
    RAI2Error(ieInternal, -1);
  CurPos := StateStack[StateStackPtr].CurPos;
  Token1 := StateStack[StateStackPtr].Token;
  TTyp1 := StateStack[StateStackPtr].TTyp;
  PrevTTyp := StateStack[StateStackPtr].PrevTTyp;
  FBacked := StateStack[StateStackPtr].Backed;
  dec(StateStackPtr);
end; { PopState }

procedure TRAI2Function.DecState;
begin
  dec(StateStackPtr);
end; { DecState }

procedure TRAI2Function.InFunction1(Fun: PFunDesc);
var
  FunArgs: TArgs;
  VarNames: PNameArray;

  procedure EnterFunction;
  var
    FC: PFunContext;
    i: Integer;
  begin
    New(PFunContext(FC));
    FillChar(FC^, sizeof(FC^), 0); 
    New(VarNames);
    PFunContext(FC).PrevFunContext := FunContext;
    FunContext := FC;
    PFunContext(FunContext).LocalVars := TRAI2VarList.Create;
    FunStack.Add(FunContext);
    FVResult := Null;
    if Fun <> nil then
    begin
      Args.HasVars := False;
      Args.Types := Fun.ParamTypes;
      for i := 0 to Args.Count - 1 do { Iterate }
      begin
        PFunContext(FunContext).LocalVars.AddVar(Fun.ParamNames[i], '',
          Fun.ParamTypes[i], Args.Values[i]);
        VarNames^ := Fun.ParamNames;
        Args.HasVars := Args.HasVars or ((Fun.ParamTypes[i] and varByRef) <> 0);
      end;
      if Fun.ResTyp > 0 then
        PFunContext(FunContext).LocalVars.AddVar('Result', '',
          Fun.ResTyp, Var2Type(Null, Fun.ResTyp));
    end
    else
      PFunContext(FunContext).LocalVars.AddVar('Result', '', varVariant, Null);
    FunArgs := Args;
    Args := TArgs.Create;
  end; { EnterFunction }

  procedure LeaveFunction(Ok: boolean);

    procedure UpdateVarParams;
    var
      i, C: Integer;
    begin
      if not Args.HasVars then Exit;
      C := Args.Count;
      Args.Obj := nil;
      Args.ObjTyp := 0;
      Args.Count := 0;
      for i := 0 to C - 1 do { Iterate }
        if (VarNames[i] <> '') and
          ((Args.Types[i] and varByRef) <> 0) then
          GetValue(VarNames[i], Args.Values[i], Args);
    end; { SetVarParams }

  var
    FC: PFunContext;
    C: Integer;
  begin
    Args.Free;
    Args := FunArgs;
    if Ok then
    begin
      C := Args.Count;
      UpdateVarParams;
      Args.Count := 0;
      if (Fun = nil) or (Fun.ResTyp > 0) then
        PFunContext(FunContext).LocalVars.GetValue('Result', FVResult, Args);
      Args.Count := C;
    end;
    FC := PFunContext(FunContext).PrevFunContext;
    PFunContext(FunContext).LocalVars.Free;
    Dispose(PFunContext(FunContext));
    Dispose(VarNames);
    FunStack.Delete(FunStack.Count - 1);
    FunContext := FC;
  end; { LeaveFunction }

begin
 { allocate stack }
  EnterFunction;
  try
    FExit := False;
    while True do
    begin
      case TTyp of { }
        ttBegin:
          begin
            Begin1;
            if (TTyp <> ttSemicolon) and not FExit then
              ErrorExpected(''';''');
            Break;
          end;
        ttVar:
          Var1(PFunContext(FunContext).LocalVars);
        ttConst:
          Const1(PFunContext(FunContext).LocalVars);
      else
        ErrorExpected('''' + kwBEGIN + '''');
      end; { case }
      NextToken;
    end; { while }
    LeaveFunction(True);
    FExit := False;
  except
    on E: Exception do
    begin
      if (E is ERAI2Error) and (Fun <> nil) and
        ((E as ERAI2Error).ErrUnitName = '') then
        UpdateExceptionPos(E, Fun.UnitName);
      LeaveFunction(False);
      FExit := False;
      raise;
    end;
  end; { try/finally }
end; { InFunction1 }

function TRAI2Function.GetValue(Identifer: string; var Value: Variant;
  var Args: TArgs): Boolean;
begin
  Result := False;
 { check in local variables }
  try
    if FunContext <> nil then
      Result := PFunContext(FunContext).LocalVars.GetValue(Identifer, Value, Args);
  except
    on E: Exception do
    begin
      if Assigned(PFunContext(FunContext).Fun) then
        UpdateExceptionPos(E, PFunContext(FunContext).Fun.UnitName)
      else
        UpdateExceptionPos(E, '');
      raise;
    end;
  end;
  if not Result then
    Result := inherited GetValue(Identifer, Value, Args);
end; { GetValue }

function TRAI2Function.SetValue(Identifer: string; const Value: Variant;
  var Args: TArgs): Boolean;
begin
  Result := False;
 { check in local variables }
  try
    if FunContext <> nil then
      Result := PFunContext(FunContext).LocalVars.SetValue(Identifer, Value, Args);
  except
    on E: Exception do
    begin
      if Assigned(PFunContext(FunContext).Fun) then
        UpdateExceptionPos(E, PFunContext(FunContext).Fun.UnitName)
      else
        UpdateExceptionPos(E, '');
      raise;
    end;
  end;
  if not Result then
    Result := inherited SetValue(Identifer, Value, Args);
end; { SetValue }

procedure TRAI2Function.DoOnStatement;
begin
end;

{ exit: current position set to next token }

procedure TRAI2Function.Statement1;
begin
  DoOnStatement;
  case TTyp of { }
    ttIdentifer:
     { assignment or function call }
      begin
        Identifer1;
        if not (TTyp in [ttSemicolon, ttEnd, ttElse, ttUntil, ttFinally, ttExcept]) then
          ErrorExpected(''';''');
       // Back;
      end;
    ttSemicolon:
      ; // Back;
    ttEnd:
      ; // Back;
    ttBegin:
      Begin1;
    ttIf:
      If1;
    ttElse:
      Exit;
    ttWhile:
      While1;
    ttRepeat:
      Repeat1;
    ttFor:
      For1;
    ttBreak:
      FBreak := True;
    ttContinue:
      FContinue := True;
    ttTry:
      Try1;
    ttRaise:
      Raise1;
    ttExit:
      FExit := True;
  else
    ErrorExpected(''';''');
  end; { case }
end; { Statement1 }

{ exit: current position set to next token }
{ very simple version, many syntax errors are not found out }

procedure TRAI2Function.SkipStatement1;
begin
  case TTyp of { }
    ttEmpty:
      ErrorExpected('''' + kwEND + '''');
    ttIdentifer:
      SkipIdentifer1;
    ttSemicolon:
      NextToken;
    ttEnd:
      NextToken;
    ttIf:
      begin
        FindToken1(ttThen);
        NextToken;
        SkipStatement1;
        if TTyp = ttElse then
        begin
          NextToken;
          SkipStatement1;
        end;
        Exit;
      end;
    ttElse:
      Exit;
    ttWhile, ttFor:
      begin
        FindToken1(ttDo);
        NextToken;
        SkipStatement1;
        Exit;
      end;
    ttRepeat:
      begin
        SkipToUntil1;
        SkipIdentifer1;
        Exit;
      end;
    ttBreak, ttContinue:
      NextToken;
    ttBegin:
      begin
        SkipToEnd1;
        Exit;
      end;
    ttTry:
      begin
        SkipToEnd1;
        Exit;
      end;
    ttFunction, ttProcedure:
      ErrorExpected('''' + kwEND + '''');
    ttRaise:
      begin
        NextToken;
        SkipIdentifer1;
      end;
    ttExit:
      NextToken;
  end; { case }
end; { SkipStatement1 }

{ out: current position set to token after end }

procedure TRAI2Function.SkipToEnd1;
begin
  while True do
  begin
    NextToken;
    if TTyp = ttEnd then
    begin
      NextToken;
      Break;
    end
    else if TTyp in [ttBegin, ttTry] then
      SkipToEnd1
    else if TTyp = ttEmpty then
      ErrorExpected('''' + kwEND + '''')
    else
      SkipStatement1;
    if TTyp = ttEnd then
    begin
      NextToken;
      Break;
    end;
  end;
end; { SkipToEnd }

{ out: current position set to token after end }

procedure TRAI2Function.SkipToUntil1;
begin
  while True do
  begin
    NextToken;
    if TTyp = ttUntil then
    begin
      NextToken;
      Break;
    end
    else if TTyp = ttEmpty then
      ErrorExpected('''' + kwUNTIL + '''')
    else
      SkipStatement1;
    if TTyp = ttUntil then
    begin
      NextToken;
      Break;
    end;
  end;
end; { SkipToEnd }

{exit: current position set to next token after assignment or function call }

procedure TRAI2Function.SkipIdentifer1;
begin
  while True do
    case TTyp of { }
      ttEmpty:
        ErrorExpected('''' + kwEND + '''');
      ttIdentifer..ttBoolean, ttLB..ttColon, ttLS, ttRS, ttNot..ttEquLess,
        ttTrue, ttFalse:
        NextToken;
      ttSemicolon, ttEnd, ttElse, ttUntil, ttFinally, ttExcept, ttDo:
        Break;
    else
      ErrorExpected(LoadStr(irExpression))
    end; { case }
end; { SkipIdentifer1 }

procedure TRAI2Function.FindToken1(TTyp1: TTokenTyp);
begin
  while not (TTyp in [TTyp1, ttEmpty]) do
    NextToken;
  if TTyp = ttEmpty then
    ErrorExpected('''' + kwEND + '''');
end; { FindToken }

procedure TRAI2Function.Assignment(const Identifer: string);
var
  MyArgs: TArgs;
begin
 { push args }
  MyArgs := Args;
  Args := TArgs.Create;
  try
    Args.Assignment := True;
    FVResult := Expression1;
  finally { wrap up }
   { pop args }
    Args.Free;
    Args := MyArgs;
  end; { try/finally }
  if not SetValue(Identifer, FVResult, Args) then
    RAI2ErrorN(ieUnknownIdentifer, PosBeg, Identifer);
end; { Assignment }

procedure TRAI2Function.Identifer1;
var
  Identifer: string;

  procedure Assig;
  begin
    NextToken;
    if TTyp <> ttEqu then
      ErrorExpected('''=''');
    NextToken;
    Assignment(Identifer);
  end; { Assig }

begin
  Identifer := Token;
  Args.Clear;
  NextToken;
  if TTyp = ttColon then { assignment }
    Assig
  else { function call }
  begin
    Back;
    Args.Assignment := False;
    InternalGetValue(nil, 0, FVResult);
    Identifer := Token; { Back! }
    NextToken;
    if TTyp = ttColon then { assignment }
    begin
      Assig;
    end;
  end;
end; { Identifer1 }

{exit: current position set to next token after "end"}

procedure TRAI2Function.Begin1;
begin
  NextToken;
  while True do
  begin
    case TTyp of { }
      ttEnd:
        begin
          NextToken;
          Exit;
        end;
      ttElse, ttDo:
        ErrorExpected('statement');
      ttSemicolon:
        begin
          DoOnStatement;
          NextToken;
        end;
      ttIdentifer, ttBegin, ttIf, ttWhile, ttFor, ttRepeat,
        ttBreak, ttContinue, ttTry, ttRaise, ttExit:
        Statement1;
    else
      ErrorExpected('''' + kwEND + '''');
    end; { case }
    if FBreak or FContinue or FExit then
      Exit;
  end;
end; { Begin1 }

{exit: current position set to next token after if block }

procedure TRAI2Function.If1;
var
  Condition: Variant;
begin
  NextToken;
  Condition := Expression2(varBoolean);
  if TTyp <> ttThen then
    ErrorExpected('''' + kwTHEN + '''');
  NextToken;
  if TVarData(Condition).VBoolean then
  begin
    Statement1;
   // NextToken; {!!!????}
    if TTyp = ttElse then
    begin
      NextToken;
      SkipStatement1;
     // Back; {!!!????}
    end;
  end
  else
  begin
    SkipStatement1;
    if TTyp = ttElse then
    begin
      NextToken;
      Statement1;
    end
   { else
    if TTyp = ttSemicolon then
    begin
      NextToken;
      if TTyp = ttElse then
        RAI2Error(ieNotAllowedBeforeElse, PosBeg)
    end; }
  end;
end; { If1 }

{exit: current position set to next token after loop }

procedure TRAI2Function.While1;
var
  WhileCurPos: Integer;
  WhilePos: Integer;
  Condition: Variant;
begin
  PushState;
  try
    WhilePos := PosEnd;
    WhileCurPos := CurPos;
    while True do
    begin
      NextToken;
      Condition := Expression1;
      if TVarData(Condition).VType <> varBoolean then
        RAI2Error(ieBooleanRequired, WhilePos);
      if TTyp <> ttDo then
        ErrorExpected('''' + kwDO + '''');
      NextToken;
      if TVarData(Condition).VBoolean then
      begin
        FContinue := False;
        FBreak := False;
        Statement1;
        if FBreak or FExit then
          Break;
      end
      else
        Break;
      CurPos := WhileCurPos;
    end; { while }
  finally
    PopState;
  end;
  SkipStatement1;
  FContinue := False;
  FBreak := False;
end; { While1 }

{exit: current position set to next token after loop }

procedure TRAI2Function.Repeat1;
var
  RepeatCurPos: Integer;
  Condition: Variant;
begin
  RepeatCurPos := CurPos;
  while True do
  begin
    NextToken;
    case TTyp of
      ttElse, ttDo:
        ErrorExpected('statement');
      ttSemicolon:
        DoOnStatement;
      ttIdentifer, ttBegin, ttIf, ttWhile, ttFor, ttRepeat,
        ttBreak, ttContinue, ttTry, ttRaise, ttExit:
        begin
          FContinue := False;
          FBreak := False;
          Statement1;
          if FBreak or FExit then
            Break;
        end;
      ttUntil:
        begin
          NextToken;
          Condition := Expression1;
          if TVarData(Condition).VType <> varBoolean then
            RAI2Error(ieBooleanRequired, CurPos);
          if TVarData(Condition).VBoolean then
            Break
          else
            CurPos := RepeatCurPos;
        end;
    else
      ErrorExpected('''' + kwUNTIL + '''');
    end;
  end; { while }
  if FBreak or FExit then
  begin
    SkipToUntil1;
    SkipIdentifer1;
  end;
  FContinue := False;
  FBreak := False;
end; { Repeat1 }

{exit: current position set to next token after loop }

procedure TRAI2Function.For1;
var
  i: Integer;
  DoCurPos: Integer;
  iBeg, iEnd: Integer;
  LoopVariable: string;
begin
  NextToken;
  if TTyp <> ttIdentifer then
    ErrorExpected(LoadStr(irIdentifer));
 // CheckLocalIdentifer;
  LoopVariable := Token;
  NextToken;
  if TTyp <> ttColon then
    ErrorExpected(''':''');
  NextToken;
  if TTyp <> ttEqu then
    ErrorExpected('''=''');
  NextToken;
  iBeg := Expression2(varInteger);
  if TTyp <> ttTo then
    ErrorExpected('''' + kwTO + '''');
  NextToken;
  iEnd := Expression2(varInteger);
  if TTyp <> ttDo then
    ErrorExpected('''' + kwDO + '''');
  DoCurPos := CurPos;
  NextToken;
  for i := iBeg to iEnd do { Iterate }
  begin
    Args.Clear;
    if not SetValue(LoopVariable, i, Args) then
      RAI2ErrorN(ieUnknownIdentifer, PosBeg, LoopVariable);
    FContinue := False;
    FBreak := False;
    Statement1;
    if FBreak or FExit then
    begin
      CurPos := DoCurPos;
      NextToken;
      Break;
    end;
    CurPos := DoCurPos;
    NextToken;
  end; { for }
  SkipStatement1;
  FContinue := False;
  FBreak := False;
end; { For1 }

procedure TRAI2Function.Var1(VarList: TRAI2VarList);
var
  i: Integer;
  Value: Variant;
  TypName: string;
  Typ: Word;
  {----olej----}
  {Temporary for array type}
  ArrayBegin, ArrayEnd: TRAI2ArrayValues;
  ArrayType: Integer;
  PP: PRAI2ArrayRec;
  Dimension: Integer;
  Minus: Boolean;
  {----olej----}
begin
  repeat
    Typ := varEmpty;
    ArrayType := varEmpty;
    Dimension := 0;
    SS.Clear;
    repeat
      NextToken;
      if TTyp <> ttIdentifer then
        ErrorExpected(LoadStr(irIdentifer));
      SS.Add(Token);
      NextToken;
    until TTyp <> ttCol;
    if TTyp <> ttColon then
      ErrorExpected(''':''');
    NextToken;
    TypName := Token;
    if TTyp = ttIdentifer then
      Typ := TypeName2VarTyp(TypName)
    else if TTyp = ttArray then
      Typ := varArray
    else
      ErrorExpected(LoadStr(irIdentifer));

    {***** olej *****}
    {Get Array variables params}
    {This is code is not very clear}
    if Typ = varArray then
    begin
      NextToken;
      if TTyp <> ttLs then
        ErrorExpected('''[''');
      {Parse Array Range}
      Dimension := 0;
      repeat
        NextToken;
        Minus := False;
        if (Trim(TokenStr1) = '-') then
        begin
          Minus := True;
          NextToken;
        end;
        if Pos('..', TokenStr1) < 1 then
          ErrorExpected('''..''');
        try
          ArrayBegin[Dimension] :=
            StrToInt(Copy(TokenStr1, 1, Pos('..', TokenStr1) - 1));
          ArrayEnd[Dimension] :=
            StrToInt(Copy(TokenStr1, Pos('..', TokenStr1) + 2, Length(TokenStr1)));
          if Minus then ArrayBegin[Dimension] := ArrayBegin[Dimension] * (-1);
        except
          ErrorExpected('''Integer Value''');
        end;
        if (Dimension < 0) or (Dimension > MaxArgs) then
          RAI2Error(ieArrayBadDimension, CurPos);
        if not (ArrayBegin[Dimension] <= ArrayEnd[Dimension]) then
          RAI2Error(ieArrayBadRange, CurPos);
      {End Array Range}
        NextToken;
        Inc(Dimension);
      until TTyp <> ttCol; { , }

      if TTyp <> ttRs then
        ErrorExpected(''']''');
      NextToken;
      if TTyp <> ttOf then
        ErrorExpected('''' + kwOF + '''');
      NextToken;
      ArrayType := TypeName2VarTyp(Token);
      if ArrayType = varEmpty then
        ErrorNotImplemented(Token + ' array type');
    end;
    {end: var A:array[1..200] of integer, parsing}
    {##### olej #####}
    for i := 0 to SS.Count - 1 do { Iterate }
    begin
      if VarList.FindVar(SS[i]) <> nil then
        RAI2ErrorN(ieIdentiferRedeclared, PosBeg, SS[i]);
      Value := Null;
      TVarData(Value).VType := varEmpty;
     { may be record }
      if not FAdapter.NewRecord(TypName, Value) then
        GlobalRAI2Adapter.NewRecord(TypName, Value);
      {***** olej *****}
      {Create array with arrayType}
      if Typ = varArray then
      begin
        PP := RAI2ArrayInit(Dimension, ArrayBegin, ArrayEnd, ArrayType);
        VarList.AddVar(SS[i], TypName, varArray, Integer(PP));
      end
      else
      begin
        if (TVarData(Value).VType = varEmpty) and (Typ <> 0) then
          Value := Var2Type(Value, Typ);
        VarList.AddVar(SS[i], TypName, varEmpty, Value);
      end;
     {end - array is allocated}
     {##### olej #####}
    end;
    SS.Clear;
    NextToken;
    if TTyp <> ttSemicolon then
      ErrorExpected(''';''');
    NextToken;
    Back;
  until TTyp <> ttIdentifer;
end; { Var1 }

procedure TRAI2Function.Const1(ConstList: TRAI2VarList);
var
  Nam: string;
  Value: Variant;
begin
  repeat
    NextToken;
    if TTyp <> ttIdentifer then
      ErrorExpected(LoadStr(irIdentifer));
    Nam := Token;
    NextToken;
    if TTyp <> ttEqu then
      ErrorExpected('=');
    if ConstList.FindVar(Nam) <> nil then
      RAI2ErrorN(ieIdentiferRedeclared, PosBeg, Nam);
    NextToken;
    Value := Expression1;

    ConstList.AddVar(Nam, '', varEmpty, Value);
    if TTyp <> ttSemicolon then
      ErrorExpected(''';''');
    NextToken;
    Back;
  until TTyp <> ttIdentifer;
end; { Const1 }

procedure TRAI2Function.Try1;

  procedure FindFinallyExcept;
  begin
    while True do
    begin
      case TTyp of { }
        ttEmpty:
          ErrorExpected('''' + kwEND + '''');
        ttSemicolon: ;
        ttFinally, ttExcept:
          Exit;
      else
        SkipStatement1;
      end;
      NextToken;
    end;
  end; { FindFinallyExcept }

  procedure Except1(E: Exception);
  var
    ExceptionClassName, ExceptionVarName: string;
    ExceptionClass: TClass;
    V: Variant;

    function On1: boolean;
    begin
      NextToken;
      if TTyp <> ttIdentifer then
        ErrorExpected(LoadStr(irIdentifer));
      ExceptionClassName := Token;
      NextToken;
      if TTyp = ttColon then
      begin
        NextToken;
        if TTyp <> ttIdentifer then
          ErrorExpected(LoadStr(irIdentifer));
        ExceptionVarName := ExceptionClassName;
        ExceptionClassName := Token;
        NextToken;
      end;
      Args.Clear;
      if not GetValue(ExceptionClassName, V, Args) then
        RAI2ErrorN(ieUnknownIdentifer, PosBeg {?}, ExceptionClassName);
      if VarType(V) <> varClass then
        RAI2Error(ieClassRequired, PosBeg {?});
      ExceptionClass := TClass(V2O(V));
      if TTyp <> ttDo then
        ErrorExpected('''' + kwDO + '''');
      Result := E is ExceptionClass;
      if Result then
       { do this 'on' section }
      begin
        NextToken;
        PFunContext(FunContext).LocalVars.AddVar(ExceptionVarName,
          ExceptionClassName, varObject, O2V(E));
        try
          Statement1;
        finally { wrap up }
          PFunContext(FunContext).LocalVars.DeleteVar(ExceptionVarName);
        end; { try/finally }
        SkipToEnd1;
      end
      else
      begin
        NextToken;
        SkipStatement1;
       { if TTyp = ttSemicolon then
          NextToken; }
      end;
    end; { On1 }

  begin
    NextToken;
    if TTyp = ttOn then
    begin
      if On1 then Exit;
      while True do
      begin
        NextToken;
        case TTyp of { }
          ttEmpty:
            ErrorExpected('''' + kwEND + '''');
          ttOn:
            if On1 then Exit;
          ttEnd:
            raise E;
          ttElse:
            begin
              NextToken;
              Statement1;
              NextToken;
              if TTyp = ttSemicolon then
                NextToken;
              if TTyp <> ttEnd then
                ErrorExpected('''' + kwEND + '''');
              Exit;
            end;
        else
          ErrorExpected('''' + kwEND + '''');
        end; { case }
      end; { while }
    end
    else
    begin
      Back;
      Begin1;
    end;
  end; { Except1 }

  procedure DoFinallyExcept(E: Exception);
  begin
    case TTyp of { }
      ttFinally:
       { do statements up to 'end' }
        begin
          Begin1;
          if E <> nil then
            raise E;
        end;
      ttExcept:
        begin
          if E = nil then
           { skip except section }
            SkipToEnd1
          else
           { except section }
          begin
            try
              Except1(E);
            except
              on E1: ERAI2Error do
                if E1.ErrCode = ieRaise then
                  raise E
                else raise;
            end;
          end;
        end;
    end;
  end; { DoFinallyExcept }

begin
  while True do
  begin
    NextToken;
    case TTyp of { }
      ttFinally:
        begin
          DoFinallyExcept(nil);
          Exit;
        end;
      ttExcept:
        begin
          DoFinallyExcept(nil);
          Exit;
        end;
      ttSemicolon:
        DoOnStatement;
      ttIdentifer, ttBegin, ttIf, ttWhile, ttFor, ttRepeat,
        ttBreak, ttContinue, ttTry, ttRaise, ttExit:
        begin
          try
            Statement1;
            if FBreak or FContinue or FExit then
            begin
              FindFinallyExcept;
              DoFinallyExcept(nil);
              Exit;
            end;
          except
            on E: Exception do
            begin
              ChangeTopException(nil);
              FindFinallyExcept;
              DoFinallyExcept(E);
              Exit;
            end;
          end; { try/finally }
        end;
    else
      ErrorExpected('''' + kwFINALLY + '''');
    end; { case }
  end;
end; { Try1 }

procedure TRAI2Function.Raise1;
var
  V: Variant;
begin
  NextToken;
  case TTyp of
    ttEmpty, ttSemicolon, ttEnd, ttBegin, ttElse, ttFinally, ttExcept:
     { re-raising exception }
      raise ERAI2Error.Create(ieRaise, PosBeg, '', '');
    ttIdentifer:
      begin
        InternalGetValue(nil, 0, V);
        if VarType(V) <> varObject then
          RAI2Error(ieClassRequired, PosBeg {?});
        raise V2O(V);
      end;
  else
    RAI2Error(ieClassRequired, PosBeg {?});
  end;
end; { Raise1 }

procedure TRAI2Function.Run;
begin
  Init;
  NextToken;
  InFunction1(nil);
end; { Run }


{************************ TRAI2Unit **************************}

constructor TRAI2Unit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FClearUnits := True;
  FEventHandlerList := TList.Create;
  FGlobalVars := TRAI2VarList.Create;
end; { Create }

destructor TRAI2Unit.Destroy;
begin
  ClearList(FEventHandlerList);
  FEventHandlerList.Free;
  FGlobalVars.Free;
  inherited Destroy;
end; { Destroy }

procedure TRAI2Unit.Init;
begin
  inherited Init;
  if FClearUnits then
  begin
    FAdapter.ClearSource;
    FGlobalVars.Clear;
    ClearList(FEventHandlerList);
  end;
end; { Init }

procedure TRAI2Unit.ReadFunHeader(var FunDesc: TFunDesc);
var
  TypName: string;

  procedure ReadParams;
  var
    VarParam: boolean;
    ParamType: string;
    iBeg: integer;
  begin
    while True do
    begin
      VarParam := False;
      NextToken;
      FunDesc.ParamNames[FunDesc.ParamCount] := Token;
      if TTyp = ttRB then
        Break;
      if TTyp = ttVar then
      begin
        VarParam := True;
        NextToken;
      end;
    {  if TTyp = ttConst then
        NextToken; }
      iBeg := FunDesc.ParamCount;
      while True do
      begin
        case TTyp of
          ttIdentifer:
            FunDesc.ParamNames[FunDesc.ParamCount] := Token;
          ttSemicolon: Break;
          ttRB: Exit;
          ttColon:
            begin
              NextToken;
              if TTyp <> ttIdentifer then
                ErrorExpected(LoadStr(irIdentifer));
              ParamType := Token;
              while True do
              begin
                if TTyp = ttRB then
                  Back;
                if TTyp in [ttRB, ttSemicolon] then
                  Break;
                NextToken;
              end; { while }
              inc(FunDesc.ParamCount);
              while iBeg < FunDesc.ParamCount do
              begin
                FunDesc.ParamTypes[iBeg] := TypeName2VarTyp(ParamType);
                if VarParam then
                  FunDesc.ParamTypes[iBeg] := FunDesc.ParamTypes[iBeg] or
                    varByRef;
                inc(iBeg);
              end;
              Break;
            end;
          ttCol:
            inc(FunDesc.ParamCount);
        end;
        NextToken;
      end; { while }
    end; { while }
  end;

var
  Fun: boolean;
begin
  Fun := TTyp = ttFunction;
  NextToken;
  if TTyp <> ttIdentifer then
    ErrorExpected(LoadStr(irIdentifer));
  FunDesc.Identifer := Token;
  NextToken;
  if TTyp = ttPoint then
  begin
    FunDesc.ClassIdentifer := FunDesc.Identifer;
    NextToken;
    if TTyp <> ttIdentifer then
      ErrorExpected(LoadStr(irIdentifer));
    FunDesc.Identifer := Token;
    NextToken;
  end;
  FunDesc.ResTyp := varEmpty;
  FunDesc.ParamCount := 0;
  if TTyp = ttLB then
  begin
   //  NextToken;
    ReadParams;
    NextToken;
  end;
  if Fun then
    if (TTyp = ttColon) then
    begin
      NextToken;
      if TTyp <> ttIdentifer then
        ErrorExpected(LoadStr(irIdentifer));
      TypName := Token;
      FunDesc.ResTyp := TypeName2VarTyp(TypName);
      if FunDesc.ResTyp = 0 then
        FunDesc.ResTyp := varVariant;
      NextToken;
    end
    else
      ErrorExpected(''':''');
  if TTyp <> ttSemicolon then
    ErrorExpected(''';''');
end; { ReadFunHeader }

procedure TRAI2Unit.Function1;
var
  FunDesc: TFunDesc;
  FunName: string;
  FunIndex: integer;
  DllName: string;
begin
  ReadFunHeader(FunDesc);
  FunDesc.PosBeg := CurPos;
  NextToken;
  if TTyp = ttExternal then
  begin
    NextToken;
    if TTyp = ttString then
      DllName := Token
    else
      ErrorExpected('''string constant'''); {DEBUG!!!}
    NextToken;
    if TTyp <> ttIdentifer then
      ErrorExpected('''name'' or ''index''');
    FunIndex := -1;
    FunName := '';
    if Cmp(Token, 'name') then
    begin
      NextToken;
      if TTyp = ttString then
        FunName := Token
      else
        ErrorExpected('''string constant'''); {DEBUG!!!}
    end
    else
      if Cmp(Token, 'index') then
      begin
        NextToken;
        if TTyp = ttInteger then
          FunIndex := Token
        else
          ErrorExpected('''integer constant'''); {DEBUG!!!}
      end
      else
        ErrorExpected('''name'' or ''index''');
    with FunDesc do
      FAdapter.AddExtFun(FCurUnitName {??!!}, Identifer, noInstance, DllName, FunName,
        FunIndex, ParamCount, ParamTypes, ResTyp);
    NextToken;
  end
  else
  begin
    FindToken1(ttBegin);
    SkipToEnd1;
    with FunDesc do
      FAdapter.AddSrcFun(FCurUnitName {??!!}, Identifer, PosBeg, CurPos, ParamCount,
        ParamTypes, ParamNames, ResTyp);
  end;
end; { Function1 }

procedure TRAI2Unit.ReadUnit(const UnitName: string);
var
  OldUnitName: string;
  OldSource: string;
  S: string;
begin
  if FAdapter.UnitExists(UnitName) then Exit;
  OldUnitName := FCurUnitName;
  OldSource := Source;
  PushState;
  try try
      if not GetUnitSource(UnitName, S) then
        RAI2ErrorN(ieUnitNotFound, PosBeg, UnitName);
      FCurUnitName := UnitName;
      Source := S;
      NextToken;
      if TTyp <> ttUnit then
        ErrorExpected('''' + kwUNIT + '''');
      Unit1;
    except
      on E: ERAI2Error do
      begin
        UpdateExceptionPos(E, FCurUnitName);
        raise;
      end;
    end
  finally { wrap up }
    FCurUnitName := OldUnitName;
    Source := OldSource;
    PopState;
  end; { try/finally }
end; { ReadUnit }

procedure TRAI2Unit.Uses1(var UsesList: string);
begin
  NextToken;
  if TTyp <> ttIdentifer then
    ErrorExpected(LoadStr(irIdentifer));
  UsesList := Token;
  ReadUnit(Token);
  while True do
  begin
    NextToken;
    if TTyp = ttSemicolon then
      Exit;
    if TTyp <> ttCol then
      ErrorExpected(''',''');
    NextToken;
    if TTyp <> ttIdentifer then
      ErrorExpected(LoadStr(irIdentifer));
    UsesList := UsesList + ',';
    ReadUnit(Token);
  end; { while }
end; { Uses1 }

procedure TRAI2Unit.Unit1;
var
  UsesList: string;
begin
  NextToken;
  if TTyp <> ttIdentifer then
    ErrorExpected(LoadStr(irIdentifer));
  FCurUnitName := Token;
  NextToken;
  if TTyp <> ttSemicolon then
    ErrorExpected(''';''');
  UsesList := '';
  NextToken;
  while True do
  begin
    case TTyp of { }
      ttEmpty:
        ErrorExpected('''' + kwEND + '''');
      ttFunction, ttProcedure:
        begin
          Function1;
          if TTyp <> ttSemicolon then
            ErrorExpected(''';''');
        end;
      ttEnd:
        Break;
      ttUses:
        Uses1(UsesList);
      ttVar:
        Var1(FGlobalVars);
      ttConst:
        Const1(FGlobalVars);
    else
      ErrorExpected(LoadStr(irDeclaration));
    end; { case }
    NextToken;
  end; { while }
  if TTyp <> ttEnd then
    ErrorExpected('''' + kwEND + '''');
  NextToken;
  if TTyp <> ttPoint then
    ErrorExpected('''.''');
  FAdapter.AddSrcUnit(FCurUnitName, Source, UsesList);
end; { Unit1 }

procedure TRAI2Unit.Run;
var
  FunDesc: PFunDesc;
begin
  Init;
  NextToken;
  case TTyp of { }
    ttVar, ttBegin:
      InFunction1(nil);
    ttFunction, ttProcedure:
      Function1;
    ttUnit:
      begin
        try
          Unit1;
        except
          on E: ERAI2Error do
          begin
            UpdateExceptionPos(E, FCurUnitName);
            raise;
          end;
        end;
       { execute main function }
        FunDesc := FAdapter.FindFunDesc('main');
        if FunDesc = nil then
          RAI2Error(ieMainUndefined, -1);
        CurPos := FunDesc.PosBeg;
        NextToken;
        InFunction1(FunDesc);
      end;
  else
    FVResult := Expression1;
  end; { case }
  FCompiled := True;
end; { Run }

procedure TRAI2Unit.Compile;
begin
  Init;
  try
    NextToken;
    if TTyp <> ttUnit then
      ErrorExpected('''' + kwUNIT + '''');
    Unit1;
  except
    on E: ERAI2Error do
    begin
      UpdateExceptionPos(E, FCurUnitName);
      raise;
    end;
  end;
  FCompiled := True;
end; { Compile }

procedure TRAI2Unit.SourceChanged;
begin
  inherited SourceChanged;
//  FCompiled := False;
  { I forget why I add this line, but with it multi-units not working;
    I comment it and wait for problems ;-( }
end; { SourceChanged }

function TRAI2Unit.GetValue(Identifer: string; var Value: Variant;
  var Args: TArgs): Boolean;
var
  FunDesc: PFunDesc;
  OldArgs: TArgs;
begin
  Result := inherited GetValue(Identifer, Value, Args);
  if Result then Exit;
  FunDesc := FAdapter.FindFunDesc(Identifer);
  Result := FunDesc <> nil;
  if Result then
  begin
    FAdapter.CheckArgs(Args, FunDesc.ParamCount, FunDesc.ParamTypes); {not tested !}
    OldArgs := Self.Args;
    try
      Self.Args := Args;
      ExecFunction(FunDesc);
    finally
      Self.Args := OldArgs;
    end;
    Value := FVResult;
  end
  else
    Result := FGlobalVars.GetValue(Identifer, Value, Args);
end; { GetValue }

function TRAI2Unit.SetValue(Identifer: string; const Value: Variant;
  var Args: TArgs): Boolean;
begin
 { check in global variables }
  Result := inherited SetValue(Identifer, Value, Args);
  if not Result then
    Result := FGlobalVars.SetValue(Identifer, Value, Args);
end; { SetValue }

procedure TRAI2Unit.Assignment(const Identifer: string);
var
  MyArgs: TArgs;
  FunDesc: PFunDesc;
  PropInf: PPropInfo;
  FunName: string;
  PopSt: Boolean;
begin
  { may be event assignment }
  if (Args.Obj <> nil) and (Args.ObjTyp = varObject) then
  begin
    FunDesc := FAdapter.FindFunDesc(Token);
    if FunDesc <> nil then
    begin
      PushState;
      PopSt := True;
      try
        NextToken;
        if not (TTyp in [ttFirstExpression..ttLastExpression] - [ttSemicolon]) then
        begin
          FunName := Token;
          PropInf := GetPropInfo(Args.Obj.ClassInfo, Identifer);
          if PropInf.PropType^.Kind = tkMethod then
          begin
           { method assignment }
            SetMethodProp(Args.Obj, PropInf,
              TMethod(NewEvent(FunName, PropInf^.PropType^.Name)));
            PopSt := False;
            Exit;
          end
          else
            if FAdapter.IsEvent(Args.Obj, Identifer) then
            begin
              if not SetValue(Identifer, FunName, Args) then
                RAI2ErrorN(ieUnknownIdentifer, PosBeg, Identifer);
              PopSt := False;
              Exit;
            end;
        end;
      finally
        if PopSt then
          PopState else
          DecState;
      end;
    end;
  end;
 { normal(not method) assignment }
 { push args }
  MyArgs := Args;
  Args := TArgs.Create;
  try
    Args.Assignment := True;
    FVResult := Expression1;
  finally { wrap up }
   { pop args }
    Args.Free;
    Args := MyArgs;
  end; { try/finally }
  if not SetValue(Identifer, FVResult, Args) then
    RAI2ErrorN(ieUnknownIdentifer, PosBeg, Identifer);
end; { Assignment }

function TRAI2Unit.GetUnitSource(UnitName: string; var Source: string): boolean;
begin
  Result := False;
  if Assigned(FOnGetUnitSource) then
    FOnGetUnitSource(UnitName, Source, Result);
end; { GetUnitSource }

procedure TRAI2Unit.DeclareExternalFunction(const Declaration: string);
var
  OldSource: string;
  OldPos: integer;
begin
  Source := Declaration;
  OldSource := Source;
  OldPos := Parser.Pos;
  try
    NextToken;
    if not (TTyp in [ttFunction, ttProcedure]) then
      ErrorExpected('''' + kwFUNCTION + ''' or ''' + kwPROCEDURE + '''');
    Function1;
  finally { wrap up }
    Source := OldSource;
    Parser.Pos := OldPos;
  end; { try/finally }
end; { DeclareExternalFunction }

procedure TRAI2Unit.ExecFunction(Fun: PFunDesc);
var
  OldUnitName: string;
  S: string;
begin
  PushState;
  OldUnitName := FCurUnitName;
  try
    if not Cmp(FCurUnitName, Fun.UnitName) then
    begin
      FCurUnitName := Fun.UnitName;
      FAdapter.UnitChanged(FCurUnitName, S);
      Source := S;
    end;
    CurPos := Fun.PosBeg;
    NextToken;
    try
      InFunction1(Fun);
    except
      on E: ERAI2Error do
      begin
        UpdateExceptionPos(E, FCurUnitName);
        raise;
      end;
    end;
  finally { wrap up }
    if not Cmp(FCurUnitName, OldUnitName) then
    begin
      FCurUnitName := OldUnitName;
      FAdapter.UnitChanged(FCurUnitName, S);
      Source := S;
    end;
    PopState;
  end; { try/finally }
end; { ExecFunction }

function TRAI2Unit.CallFunction(const FunName: string; Args: TArgs;
  Params: array of Variant): Variant;
var
  FunDesc: PFunDesc;
  i: Integer;
  OldArgs: TArgs;
begin
  if not FCompiled then Compile;
  FunDesc := FAdapter.FindFunDesc(FunName);
  if FunDesc <> nil then
  begin
    OldArgs := Self.Args;
    if Args = nil then
    begin
      Self.Args.Clear;
      for i := Low(Params) to High(Params) do { Iterate }
      begin
        Self.Args.Values[Self.Args.Count] := Params[i];
        inc(Self.Args.Count);
      end; { for }
    end
    else
      Self.Args := Args;
    try
     { simple init }
      FBreak := False;
      FContinue := False;

      ExecFunction(FunDesc);

      Result := FVResult;
    finally
      Self.Args := OldArgs;
    end;
  end
  else
    RAI2ErrorN(ieUnknownIdentifer, -1, FunName);
end; { CallFunction }

function TRAI2Unit.NewEvent(const FunName, EventType: string): TSimpleEvent;
begin
  Result := FAdapter.NewEvent(FunName, EventType, Self);
  if not Assigned(Result) then
    Result := GlobalRAI2Adapter.NewEvent(FunName, EventType, Self);
  if not Assigned(Result) then
    RAI2ErrorN(ieEventNotRegistered, -1, EventType);
end; { NewEvent }

function TRAI2Unit.FunctionExist(const FunName: string): boolean;
begin
  Result := FAdapter.FindFunDesc(FunName) <> nil;
end;

{######################## TRAI2Unit ##########################}


{*********************** TRAI2Program ***********************}

type
  TRAI2ProgramStrings = class(TStringList)
  private
    FRAI2Program: TRAI2Program;
  protected
    procedure Changed; override;
  end;

procedure TRAI2ProgramStrings.Changed;
begin
  FRAI2Program.Source := Text;
end;

constructor TRAI2Program.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPas := TRAI2ProgramStrings.Create;
  (FPas as TRAI2ProgramStrings).FRAI2Program := Self;
end; { Create }

destructor TRAI2Program.Destroy;
begin
  FPas.Free;
  inherited Destroy;
end; { Destroy }

procedure TRAI2Program.SetPas(Value: TStrings);
begin
  FPas.Assign(Value);
end;

procedure TRAI2Program.DoOnStatement;
begin
  if Assigned(FOnStatement) then
    FOnStatement(Self);
end;


{$IFDEF RAI2_OLEAUTO}
var
  OleInitialized: Boolean;
{$ENDIF RAI2_OLEAUTO}
initialization
  GlobalRAI2Adapter := TRAI2Adapter.Create(nil);
{$IFDEF RAI2_OLEAUTO}
  OleInitialized := OleInitialize(nil) = S_OK;
{$ENDIF RAI2_OLEAUTO}
finalization
{$IFDEF RAI2_OLEAUTO}
  if OleInitialized then OleUnInitialize;
{$ENDIF RAI2_OLEAUTO}
{$IFDEF RAI2_DEBUG}
  if ObjCount <> 0 then
    Windows.MessageBox(0, PChar('Memory leak in RAI2.pas'#13 +
      'ObjCount = ' + IntToStr(ObjCount)),
      'RAI2 Internal Error', MB_ICONERROR);
{$ENDIF}
  GlobalRAI2Adapter.Free;
end.

