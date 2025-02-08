unit LMDSctPasCompiler;
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

LMDSctPasCompiler unit (YB)
---------------------------
LMD ScriptPack compiler for Pascal Script.

Changes
-------
Release 4.0 (March 2009)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Variants, SysUtils, ActiveX, ComObj, Dialogs, LMDSctCst,
  LMDSctClass, LMDSctVMCompBase, LMDSctVMByteCode;

type
  TLMDDesignatorExpr  = class;
  TLMDProcedureDecl   = class;
  TLMDLocalVarDecl    = class;
  ELMDPasCompiler     = class(ELMDCompileBase);

  TLMDEBC = record
    ExitL:     TLMDLabel;
    BreakL:    TLMDLabel;
    ContinueL: TLMDLabel;
  end;

  TLMDContext = record
    Code:         TLMDByteCode;
    CurReraise:   TLMDTry;
    CurNamespace: TLMDAbstractNamespace;
    CurEBC:       TLMDEBC;
  end;

  {************************* class TLMDPasExpression **************************}

  TLMDExprEmitRes = (erNoRes, erStack, erPopJmpIfTrue, erPopJmpIfFalse);

  TLMDExpression = class(ILMDEmitable)
  private
    FSourcePos: Integer;
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel;
                             var AResInStack: Boolean); virtual; abstract;
    procedure DoEmitRefByteCode(var C: TLMDContext); virtual;
  public
    procedure Emit(ANamespace: TLMDAbstractNamespace;
                   AByteCode: TLMDByteCode); override;
    procedure EmitByteCode(var C: TLMDContext); overload;
    procedure EmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                           AJmpLabel: TLMDLabel = nil); overload;
    procedure EmitRefByteCode(var C: TLMDContext);
    property  SourcePos: Integer read FSourcePos;
  end;

  {************************* class TLMDPasStatement ***************************}

  TLMDStatement = class(ILMDEmitable)
  private
    FSourcePos: Integer;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); virtual; abstract;
  public
    procedure Emit(ANamespace: TLMDAbstractNamespace;
                   AByteCode: TLMDByteCode); override;
    procedure EmitByteCode(var C: TLMDContext);
    property  SourcePos: Integer read FSourcePos;
  end;

  {************************** class TLMDPasStmtList ***************************}

  TLMDStmtList = class
  private
    FItems:    TList;
    FOwnItems: Boolean;

    function GetItems(AIndex: Integer): TLMDStatement;
    function GetCount: Integer;
  public
    constructor Create; overload;
    constructor Create(AOwnItems: Boolean); overload;
    destructor Destroy; override;

    procedure Add(AItem: TLMDStatement);
    procedure EmitByteCode(var C: TLMDContext);
    property  Items[AIndex: Integer]: TLMDStatement read GetItems; default;
    property  Count: Integer read GetCount;
  end;

  {************************* class TLMDPasUsedUnit ****************************}

  TLMDUsedUnit = class(TLMDNamedItem)
  public
    constructor Create(AName: Integer);
  end;

  {********************** class TLMDPasGlobalVarDecl **************************}

  TLMDGlobalVarIniter = class(ILMDEmitable) // Pseudo stmt.
  private
    FVar:    TLMDVarObject;
    FIniter: TLMDExpression;
  public
    constructor Create(AVar: TLMDVarObject; AIniter: TLMDExpression);
    destructor Destroy; override;

    procedure Emit(ANamespace: TLMDAbstractNamespace;
                   AByteCode: TLMDByteCode); override;
  end;

  {************************ class TLMDPasGLobalConstDecl **********************}

  TLMDGlobalConstIniter = class(ILMDEmitable) // Pseudo stmt.
  private
    FConst:  TLMDConstObject;
    FIniter: TLMDExpression;
  public
    constructor Create(AConst: TLMDConstObject; AIniter: TLMDExpression);
    procedure   Emit(ANamespace: TLMDAbstractNamespace;
                     AByteCode: TLMDByteCode); override;
  end;

  {************************ class TLMDPasProcedureDecl ************************}

  TLMDProcLocalNamespace = class(TLMDAbstractNamespace)
  private
    FProcedure: TLMDProcedureDecl;
  public
    constructor Create(AProcedure: TLMDProcedureDecl;
                       AParent: TLMDAbstractNamespace);

    function  Find(AThread: Pointer; AName: Integer;
                   AStrName: PWideString): TLMDNameSearchRes; override;
    procedure EnumDebugVars(ALocalsOnly: Boolean;
                            AProc: TLMDNamespaceEnumVarsProc); override;
    function  CompileTimeFind(AName: Integer): TLMDNameSearchRes; override;
  end;

  TLMDProcLocalType = (ltVar, ltConst, ltResult, ltParam);

  TLMDProcLocal = class(TLMDNamedItem)
  private
    FStrName:   WideString;
    FLocalType: TLMDProcLocalType;
  public
    constructor Create(ALocalType: TLMDProcLocalType; AName: Integer;
                       const AStrName: WideString);

    property LocalType: TLMDProcLocalType read FLocalType;
    property StrName: WideString read FStrName;
  end;

  TLMDLocalVarDecl = class(TLMDProcLocal)
  private
    FExpr:  TLMDExpression;
    FIndex: Integer;
  public
    constructor Create(AName: Integer; const AStrName: WideString); overload;
    destructor Destroy; override;

    property Expr: TLMDExpression read FExpr;
    property Index: Integer read FIndex;
  end;

  TLMDLocalConstDecl = class(TLMDProcLocal)
  private
    FExpr:  TLMDExpression;
    FValue: OleVariant;
  public
    constructor Create(AName: Integer; const AStrName: WideString);
    destructor Destroy; override;

    property Expr: TLMDExpression read FExpr  write FExpr;
    property Value: OleVariant read FValue write FValue;
  end;

  TLMDLocalResultDecl = class(TLMDProcLocal)
  public
    constructor Create(AName: Integer; const AStrName: WideString);
  end;

  TLMDParamDecl = class(TLMDProcLocal)
  private
    FParamInfo: TLMDParamInfo;
  public
    constructor Create(AName: Integer; const AStrName: WideString;
                       AParamKind: TLMDParamKind); overload;
    property ParamInfo: TLMDParamInfo read FParamInfo;
  end;

  TLMDProcKind = (pkFunction, pkProcedure);

  TLMDProcedureDecl = class(TLMDProcObject)
  private
    FProcKind:       TLMDProcKind;
    FLocalNamespace: TLMDProcLocalNamespace;
    FLocalMap:       TLMDNameHashTable;
    FParams:         TList;
    FLocalVars:      TList;
    FLocalConsts:    TList;
    FLocalResult:    TLMDLocalResultDecl;
    FStmtList:       TLMDStmtList;
    FSourcePos:      Integer;
    FEndSourcePos:   Integer;

    function GetParams(AIndex: Integer): TLMDParamDecl;
    function GetLocalConstCount: Integer;
    function GetLocalConsts(AIndex: Integer): TLMDLocalConstDecl;
    function GetLocalVars(AIndex: Integer): TLMDLocalVarDecl;
    function GetLocalVarCount: Integer;
    function AddLocalItem(AItem: TLMDProcLocal): Boolean;
    function CreateLocalNS(AParent: TLMDAbstractNamespace): TLMDProcLocalNamespace;
  public
    constructor Create(AName: Integer; const AStrName: WideString;
                       AProcKind: TLMDProcKind);
    destructor Destroy; override;

    function  GetGlobalObjType: TLMDGlobalObjType; override;
    procedure EmitByteCode(AGlobalNamespace: TLMDAbstractNamespace); override;

    property SourcePos: Integer read FSourcePos;
    property EndSourcePos: Integer read FEndSourcePos;
    property ProcKind: TLMDProcKind read FProcKind;
    property StmtList: TLMDStmtList read FStmtList;
    property Params[AIndex: Integer]: TLMDParamDecl read GetParams;
    property ParamCount;
    property LocalVars[AIndex: Integer]: TLMDLocalVarDecl read GetLocalVars;
    property LocalVarCount: Integer read GetLocalVarCount;
    property LocalConsts[AIndex: Integer]: TLMDLocalConstDecl read GetLocalConsts;
    property LocalConstCount: Integer read GetLocalConstCount;
    property LocalResult: TLMDLocalResultDecl read FLocalResult;
    property LocalNamespace: TLMDProcLocalNamespace read FLocalNamespace;
  end;

  {***************************** TLMDPasCompound ******************************}

  TLMDCompound = class(TLMDStatement)
  private
    FStmtList: TLMDStmtList;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property StmtList: TLMDStmtList read FStmtList;
  end;

  {***************************** class TLMDPasIf ******************************}

  TLMDIfStmt = class(TLMDStatement)
  private
    FIfExpr:   TLMDExpression;
    FThenStmt: TLMDStatement;
    FElseStmt: TLMDStatement;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property IfExpr: TLMDExpression read FIfExpr;
    property ThenStmt: TLMDStatement read FThenStmt;
    property ElseStmt: TLMDStatement read FElseStmt;
  end;

  {************************** class TLMDPasCaseStmt ***************************}

  TLMDCaseSelector = class;
  TLMDCaseLabel    = class
  private
    FFirstExpr:  TLMDExpression;
    FSecondExpr: TLMDExpression;
    FSourcePos:  Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure EmitExpressions(var C: TLMDContext;
                              out ATestInstr: TLMDInstrCode);
    property  FirstExpr: TLMDExpression read FFirstExpr;
    property  SecondExpr: TLMDExpression read FSecondExpr;
    property  SourcePos: Integer read FSourcePos;
  end;

  TLMDCaseSelector = class
  private
    FLabels: TList;
    FStmt:   TLMDStatement;

    function  GetLabelCount: Integer;
    function  GetLabels(AIndex: Integer): TLMDCaseLabel;
    procedure AddLabel(ALabel: TLMDCaseLabel);
  public
    constructor Create;
    destructor Destroy; override;

    property Labels[AIndex: Integer]: TLMDCaseLabel read GetLabels;
    property LabelCount: Integer read GetLabelCount;
    property Stmt: TLMDStatement read FStmt;
  end;

  TLMDCaseStmt = class(TLMDStatement)
  private
    FCaseExpr:   TLMDExpression;
    FSelectors:  TList;
    FElseStmts:  TLMDStmtList;

    function  GetSelectorCount: Integer;
    function  GetSelectors(AIndex: Integer): TLMDCaseSelector;
    procedure AddSelector(ASelector: TLMDCaseSelector);
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property CaseExpr: TLMDExpression read FCaseExpr;
    property ElseStmtList: TLMDStmtList read FElseStmts;
    property CaseSelectorCount: Integer read GetSelectorCount;
    property CaseSelectors[AIndex: Integer]: TLMDCaseSelector read GetSelectors;
  end;

  {*************************** class TLMDPasRepeat ****************************}

  TLMDRepeatStmt = class(TLMDStatement)
  private
    FStmtList:   TLMDStmtList;
    FRepeatExpr: TLMDExpression;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property StmtList: TLMDStmtList read FStmtList;
    property RepeatExpr: TLMDExpression read FRepeatExpr;
  end;

  {************************* class TLMDPasWhileStmt ***************************}

  TLMDWhileStmt = class(TLMDStatement)
  private
    FStmt:      TLMDStatement;
    FWhileExpr: TLMDExpression;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property Stmt: TLMDStatement read FStmt;
    property WhileExpr: TLMDExpression read FWhileExpr;
  end;

  {************************** class TLMDPasForStmt ****************************}

  TLMDForCounterKind = (ckTo, ckDownto);

  TLMDForStmt = class(TLMDStatement)
  private
    FVarExpr:     TLMDDesignatorExpr;
    FCounterKind: TLMDForCounterKind;
    FFromExpr:    TLMDExpression;
    FToExpr:      TLMDExpression;
    FStmt:        TLMDStatement;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    destructor Destroy; override;

    property VarExpr: TLMDDesignatorExpr read FVarExpr;
    property CounterKind: TLMDForCounterKind read FCounterKind;
    property FromExpr: TLMDExpression read FFromExpr;
    property ToExpr: TLMDExpression read FToExpr;
    property Stmt: TLMDStatement read FStmt;
  end;

  {************************* class TLMDPasRaiseStmt ***************************}
  
  TLMDRaiseStmt = class(TLMDStatement)
  private
    FExpr: TLMDExpression;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property Expr: TLMDExpression read FExpr;
  end;

  {************************** class TLMDPasTryStmt ****************************}

  TLMDExceptionSubBlock = class;

  TLMDExcSubBlockNamespace = class(TLMDAbstractNamespace)
  private
    FVarName:  Integer;
    FVarSName: WideString;
    FVarIndex: Integer;
  public
    constructor Create(AParent: TLMDAbstractNamespace; AVarName: Integer;
                       const AVarSName: WideString; AVarIndex: Integer);

    function  Find(AThread: Pointer; AName: Integer;
                   AStrName: PWideString): TLMDNameSearchRes; override;
    procedure EnumDebugVars(ALocalsOnly: Boolean;
                            AProc: TLMDNamespaceEnumVarsProc); override;
    function  CompileTimeFind(AName: Integer): TLMDNameSearchRes; override;
  end;

  TLMDExceptionSubBlock = class(TLMDNamedItem)
  private
    FExpr:      TLMDExpression;
    FStmt:      TLMDStatement;
    FSourcePos: Integer;
    FStrName:   WideString;
    FNamespace: TLMDExcSubBlockNamespace;

    function CreateNS(AParent: TLMDAbstractNamespace;
                      AVarIndex: Integer): TLMDAbstractNamespace;
  public
    constructor Create(AName: Integer; const AStrName: WideString);
    destructor Destroy; override;

    property  Namespace: TLMDExcSubBlockNamespace read FNamespace;
    property  StrName: WideString read FStrName;
    property  Expr: TLMDExpression read FExpr;
    property  Stmt: TLMDStatement read FStmt;
    property  SourcePos: Integer read FSourcePos;
  end;

  TLMDExceptionBlock = class
  private
    FElseStmtList:  TLMDStmtList;
    FBlocks:        TList;
    FHasElse:       Boolean;
    FElseSourcePos: Integer;

    function  GetBlockCount: Integer;
    function  GetBlocks(AIndex: Integer): TLMDExceptionSubBlock;
    procedure AddBlock(ABlock: TLMDExceptionSubBlock);
  public
    constructor Create;
    destructor Destroy; override;

    property ElseStmtList : TLMDStmtList read FElseStmtList;
    property Blocks[AIndex: Integer]: TLMDExceptionSubBlock read GetBlocks;
    property BlockCount: Integer read GetBlockCount;
    property HasElse: Boolean read FHasElse;
    property ElseSourcePos: Integer read FElseSourcePos;
  end;

  TLMDTryStmtType = (ttFinally, ttExcept);

  TLMDTryStmt = class(TLMDStatement)
  private
    FTryStmtList:     TLMDStmtList;
    FExceptStmtList:  TLMDStmtList;
    FExceptionBlock:  TLMDExceptionBlock;
    FFinallyStmtList: TLMDStmtList;
    FTryStmtType:     TLMDTryStmtType;

    procedure EmitTryFinally(var C: TLMDContext);
    procedure EmitTryExcept(var C: TLMDContext);
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property TryStmtType: TLMDTryStmtType read FTryStmtType;
    property TryStmtList: TLMDStmtList read FTryStmtList;
    property ExceptStmtList: TLMDStmtList read FExceptStmtList;
    property ExceptionBlock: TLMDExceptionBlock read FExceptionBlock;
    property FinallyStmtList: TLMDStmtList read FFinallyStmtList;
  end;

  {*********************** class TLMDPasBinaryOperator ************************}

  TLMDBinaryOp = (bopGreater, bopGreaterEqual, bopEqual, bopLess,
                  bopLessEqual, bopNotEqual, bopIn, bopIs, bopPlus,
                  bopMinus, bopOr, bopXor, bopMultiply, bopDivide,
                  bopDiv, bopMod, bopAnd, bopShl, bopShr);

  TLMDBinaryExpr = class(TLMDExpression)
  private
    FLeftExpr:  TLMDExpression;
    FRightExpr: TLMDExpression;
    FOperator:  TLMDBinaryOp;
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel; var AResInStack: Boolean); override;
  public
    constructor Create(AOperator: TLMDBinaryOp);
    destructor Destroy; override;

    property Oper: TLMDBinaryOp read FOperator;
    property LeftExpr: TLMDExpression read FLeftExpr;
    property RightExpr: TLMDExpression read FRightExpr;
  end;

  {********************** class TLMDPasDesignatorExpr *************************}

  TLMDDesignatorItem = class
  private
    FName:         Integer;
    FStrName:      WideString;
    FArgs:         TList;
    FBracketType:  TLMDBracketType;
    FSourcePos:    Integer;
    FIsResultUsed: Boolean;

    function  GetArgs(AIndex: Integer): TLMDExpression;
    function  GetArgCount: Integer;
    procedure AddArg(AArgs: TLMDExpression);
    procedure EmitArgs(var C: TLMDContext);
    function  GetIsNamed: Boolean;
  public
    constructor Create; overload;
    constructor Create(AName: Integer; const AStrName: WideString); overload;
    destructor Destroy; override;

    property Name: Integer read FName;
    property StrName: WideString read FStrName;
    property IsNamed: Boolean read GetIsNamed;
    property SourcePos: Integer read FSourcePos;
    property Args[AIndex: Integer]: TLMDExpression read GetArgs;
    property ArgCount: Integer read GetArgCount;
    property BracketType: TLMDBracketType read FBracketType;
    property IsResultUsed: Boolean read FIsResultUsed; // Whether the call result
                                                       // is semantically used.
  end;

  TLMDPasGetCallInstr = function(var C: TLMDContext;
                                 AItem: TLMDDesignatorItem;
                                 out AInstr: TLMDInstr;
                                 out ANeedSlot: Boolean): Boolean of object;
  TLMDPasEmitValue    = procedure(var C: TLMDContext;
                                  AItem: TLMDDesignatorItem) of object;

  TLMDDesignatorExpr = class(TLMDExpression)
  private
    FItems: TList;

    function  GetItemCount: Integer;
    function  GetItems(AIndex: Integer): TLMDDesignatorItem;
    function  GetLastItem: TLMDDesignatorItem;
    procedure AddItem(AItem: TLMDDesignatorItem);
    function  OptimizeCallInstr(var C: TLMDContext; AItem: TLMDDesignatorItem;
                                ACallInstr: TLMDInstrCode; AHasObject,
                                AHasValue: Boolean; out ANeedSlot: Boolean): TLMDInstr;
    procedure InternalEmit(var C: TLMDContext; ANeedRef: Boolean;
                           AGetInstrProc: TLMDPasGetCallInstr = nil;
                           AEmitValueProc: TLMDPasEmitValue = nil);
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel; var AResInStack: Boolean); override;
    procedure DoEmitRefByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    constructor CreateSimple(AName: Integer; const AStrName: WideString;
                             ASourcePos: Integer);
    destructor Destroy; override;

    property Items[AIndex: Integer]: TLMDDesignatorItem read GetItems; default;
    property ItemCount: Integer read GetItemCount;
    property LastItem: TLMDDesignatorItem read GetLastItem;
  end;

  {********************** class TLMDPasExpressionStmt *************************}

  TLMDExpressionStmt = class(TLMDStatement)
  private
    FExpr: TLMDExpression;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property Expr: TLMDExpression read FExpr;
  end;

  {************************* class TLMDAssignmentStmt *************************}

  TLMDAssignmentStmt = class(TLMDStatement)
  private
    FLeftExpr:  TLMDDesignatorExpr;
    FRightExpr: TLMDExpression;

    function  AsgnCallInstrProc(var C: TLMDContext; AItem: TLMDDesignatorItem;
                                out AInstr: TLMDInstr; out ANeedSlot: Boolean): Boolean;
    procedure EmitValueProc(var C: TLMDContext; AItem: TLMDDesignatorItem);
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property LeftExpr: TLMDDesignatorExpr read FLeftExpr;
    property RightExpr: TLMDExpression read FRightExpr;
  end;

  {************************** class TLMDPasEmptyStmt **************************}

  TLMDPasEmptyStmt = class(TLMDStatement)
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  end;

  {************************** class TLMDPasLiteral ****************************}

  TLMDLiteral = class(TLMDExpression)
  private
    FValue: OleVariant;
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel; var AResInStack: Boolean); override;
  public
    constructor Create(AValue: OleVariant); overload;
    property    Value: OleVariant read FValue;
  end;

  {************************** class TLMDPasUnaryOp ****************************}

  TLMDUnaryOp = (uopPlus, uopMinus, uopNot);

  TLMDUnaryExpr = class(TLMDExpression)
  private
    FOperator: TLMDUnaryOp;
    FExpr:     TLMDExpression;
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel; var AResInStack: Boolean); override;
  public
    constructor Create(AOperator: TLMDUnaryOp);
    destructor Destroy; override;

    property Oper: TLMDUnaryOp read FOperator;
    property Expr: TLMDExpression read FExpr;
  end;

  {************************* class TLMDPasSetElement **************************}

  TLMDSetElement = class
  private
    FLeftExpr:  TLMDExpression;
    FRightExpr: TLMDExpression;
    FSourcePos: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure EmitByteCode(var C: TLMDContext);

    property LeftExpr: TLMDExpression read FLeftExpr;
    property RightExpr: TLMDExpression read FRightExpr;
    property SourcePos: Integer read FSourcePos;
  end;

  {*************************** class TLMDPasSetExpr ***************************}

  TLMDPasSetExpr = class(TLMDExpression)
  private
    FSetElements: TList;

    function  GetSetElementCount: Integer;
    function  GetSetElements(AIndex: Integer): TLMDSetElement;
    procedure AddSetElement(AElem: TLMDSetElement);
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel; var AResInStack: Boolean); override;
  public
    constructor Create;
    destructor Destroy; override;

    property  SetElements[AIndex: Integer]: TLMDSetElement read GetSetElements;
    property  SetElementCount: Integer read GetSetElementCount;
  end;

  {****************************** TLMDArrayExpr *******************************}

  TLMDArrayDim = class
  private
    FLeftExpr:  TLMDExpression;
    FRightExpr: TLMDExpression;
    FSourcePos: Integer;
  public
    destructor Destroy; override;
    procedure  EmitByteCode(var C: TLMDContext);

    property LeftExpr: TLMDExpression read FLeftExpr;
    property RightExpr: TLMDExpression read FRightExpr;
    property SourcePos: Integer read FSourcePos;
  end;

  TLMDArrayExpr = class(TLMDExpression)
  private
    FArrayDims:   TList;
    FElemVarType: TVarType;

    function  GetArrayDimCount: Integer;
    function  GetArrayDims(AIndex: Integer): TLMDArrayDim;
    procedure AddArrayDim(AElem: TLMDArrayDim);
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel; var AResInStack: Boolean); override;
  public
    constructor Create;
    destructor Destroy; override;

    property ArrayDims[AIndex: Integer]: TLMDArrayDim read GetArrayDims;
    property ArrayDimCount: Integer read GetArrayDimCount;
    property ElemVarType: TVarType read FElemVarType;
  end;

  {**************************** TLMDEventMakeExpr *****************************}

  TLMDEventMakeExpr = class(TLMDExpression)
  private
    FProcName:    Integer;
    FStrProcName: WideString;
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel; var AResInStack: Boolean); override;
  public
    constructor Create(AProcName: Integer);

    property ProcName: Integer read FProcName;
    property StrProcName: WideString read FStrProcName;
  end;

  {***************************** enum TLMDPasToken ****************************}

  TLMDPasToken =
  (
    { Identifier }

    ptIdentifier,

    { Constants }

    ptCString,
    ptCInteger,
    ptCFloat,

    { Reserved words }

    ptArray,
    ptBegin,
    ptCase,
    ptConst,
    ptDo,
    ptDownto,
    ptElse,
    ptEnd,
    ptExcept,
    ptFinally,
    ptFor,
    ptFunction,
    ptIf,
    ptNil,
    ptOf,
    ptOn,
    ptOut,
    ptProcedure,
    ptRaise,
    ptRepeat,
    ptThen,
    ptTo,
    ptTry,
    ptUntil,
    ptUses,
    ptVar,
    ptWhile,

    { Operators }

    ptAnd,
    ptDiv,
    ptDivide,
    ptEqual,
    ptGreater,
    ptGreaterEqual,
    ptIn,
    ptIs,
    ptLess,
    ptLessEqual,
    ptMinus,
    ptMod,
    ptMultiply,
    ptNot,
    ptNotEqual,
    ptOr,
    ptPlus,
    ptShl,
    ptShr,
    ptXor,

    { Other }

    ptAssignment,
    ptCloseBlock,
    ptCloseRound,
    ptColon,
    ptComma,
    ptOpenBlock,
    ptOpenRound,
    ptPeriod,
    ptDoublePeriod,
    ptSemiColon,
    ptReference,

    { Comment }

    ptComment,

    { EOf }

    ptEOf
  );

  TLMDPasTokens = set of TLMDPasToken;

  {*************************** class TLMDPasScanner ***************************}

  TLMDPasScannerSavepoint = PWideChar;
  TLMDPasTokenDescription = record
    S:         WideString;
    IsKeyword: Boolean;
  end;

  TLMDPasScanner = class
  private
    FStrSource:     WideString;
    FSource:        PWideChar;
    FCurChar:       PWideChar;
    FSkipComments:  Boolean;
    FToken:         TLMDPasToken;
    FTokenStartPos: Integer;
    FSData:         WideString;
    FIData:         Integer;
    FFData:         Extended;
    FTokenEndPos:   Integer;

    procedure NextChar;
    function  GetCurCharPos: Integer;
    procedure SkipBlanks;
    procedure ScanToken;
    function  ScanNumber(ALLowFloat: Boolean; out IntVal: Integer;
                         out FloatVal: Extended): TLMDPasToken;
    function  ScanIdentifier: WideString;
    function  ScanString: WideString;
    function  DetectReservedWord(const Token: WideString): TLMDPasToken;
    procedure NextToken;
  public
    constructor Create(SkipComments: Boolean = True);
    destructor Destroy; override;

    function  TokenToStr(Token: TLMDPasToken): WideString;
    function  GetSavepoint: TLMDPasScannerSavepoint;
    procedure Rollback(const S: TLMDPasScannerSavepoint);
    procedure Start(const Source: WideString);
    procedure SkipToken;
    
    property Token: TLMDPasToken read FToken;
    property TokenStartPos: Integer read FTokenStartPos;  // In Delphi format,
    property TokenEndPos: Integer read FTokenEndPos;      // starting from 1.
    property SData: WideString read FSData;
    property IData: Integer read FIData;
    property FData: Extended read FFData;
  end;

  {**************************** class TLMDPasParser ***************************}

  TLMDPasParserTryState = (ptsNowhere, ptsInTry, ptsInExcept, ptsInFinally);

  TLMDPasParserSavepoint = record
    ScannerSP:      TLMDPasScannerSavepoint;
    TryState:       TLMDPasParserTryState;
    LastSkippedPos: Integer;
  end;

  TLMDPasParser = class(ILMDParserBase)
  private
    FCbs:            ILMDParserCallbacks;
    FScanner:        TLMDPasScanner;
    FTryState:       TLMDPasParserTryState;
    FLastSkippedPos: Integer;

    function  GetCurToken: TLMDPasToken;
    procedure DoAddGlobalObject(AObj: TLMDGlobalObject);
    procedure DoAddUsedUnit(const AUnitName: WideString);
    procedure DoAddProcLocal(AItem: TLMDProcLocal;
                             AProc: TLMDProcedureDecl);
    function  PasNil: OleVariant;
    procedure InvalidTokenError(AToken: TLMDPasToken);
    procedure CheckTokens(ATokens: TLMDPasTokens);
    procedure CheckAndSkipTokens(ATokens: TLMDPasTokens);
    procedure SkipToken;
    function  GetSavepoint: TLMDPasParserSavepoint;
    procedure Rollback(const ASavepoint: TLMDPasParserSavepoint);
    property  CurToken: TLMDPasToken read GetCurToken;

    procedure ParseUnit;
    procedure ParseUsesClause;
    procedure ParseGlobalVarSection;
    procedure ParseGlobalVarDecl;
    procedure ParseLocalVarSection(AProc: TLMDProcedureDecl);
    procedure ParseLocalVarDecl(AProc: TLMDProcedureDecl);
    procedure ParseGlobalConstSection;
    procedure ParseGlobalConstDecl;
    procedure ParseLocalConstSection(AProc: TLMDProcedureDecl);
    function  ParseLocalConstDecl: TLMDLocalConstDecl;
    procedure ParseProcedureDecl;
    procedure ParseParamsDecl(AProc: TLMDProcedureDecl);
    function  ParseParamDecl: TLMDParamDecl;
    procedure ParseStmtList(AStmtList: TLMDStmtList);
    function  ParseStatement: TLMDStatement;
    function  ParseEmptyStmt: TLMDPasEmptyStmt;
    function  ParseCompoundStmt: TLMDCompound;
    function  ParseIfStmt: TLMDIfStmt;
    function  ParseCaseStmt: TLMDCaseStmt;
    function  ParseCaseSelector: TLMDCaseSelector;
    function  ParseCaseLabel: TLMDCaseLabel;
    function  ParseRepeatStmt: TLMDRepeatStmt;
    function  ParseWhileStmt: TLMDWhileStmt;
    function  ParseForStmt: TLMDForStmt;
    function  ParseTryStmt: TLMDTryStmt;
    function  ParseExceptionBlock: TLMDExceptionBlock;
    function  ParseRaiseStmt: TLMDRaiseStmt;
    function  ParseExpression: TLMDExpression;
    function  ParseSimpleExpression: TLMDExpression;
    function  ParseTerm: TLMDExpression;
    function  ParseFactor: TLMDExpression;
    procedure ParseArrayDim(AArrExpr: TLMDArrayExpr);
    function  ParseRelOp: TLMDBinaryOp;
    function  ParseAddOp: TLMDBinaryOp;
    function  ParseMulOp: TLMDBinaryOp;
    function  ParseDesignator: TLMDDesignatorExpr;
    function  ParseNamedCall: TLMDDesignatorItem;
    procedure ParseSetElements(ASetExpr: TLMDPasSetExpr);
    function  ParseSetElement: TLMDSetElement;
    function  CreateBinaryExpr(AOper: TLMDBinaryOp;
                               ALeft: TLMDExpression): TLMDBinaryExpr;
    function  CreateUnaryExpr(AOper: TLMDUnaryOp): TLMDUnaryExpr;
    function  ParseIdentifier: Integer; overload;
    function  ParseIdentifier(out AStrName: WideString): Integer; overload;
    function  ParseArrayType: TVarType;
  public
    constructor Create(ACbs: ILMDParserCallbacks);
    destructor Destroy; override;

    procedure Parse(const ASource: WideString); override;
    function  ParseStmt(const ASource: WideString): ILMDEmitable; override;
    function  ParseExpr(const ASource: WideString): ILMDEmitable; override;
    property  Scanner: TLMDPasScanner read FScanner;
  end;

  TLMDPasLanguage = class(TInterfacedObject, ILMDLanguage)
  protected
    { ILMDLanguage }

    function  CreateParser(ACbs: ILMDParserCallbacks): ILMDParserBase;
    procedure AddIntrinsics(AProc: TLMDAddIntrinsicProc);
    function  DebugEmpty: WideString;
    function  DebugNothing: WideString;
    function  DebugNull: WideString;
    function  DebugStrLiteral(const S: WideString): WideString;
  end;

implementation

uses
  LMDSctVM;

type
  {*************************** Intrinsic Objects ******************************}

  TPasIntrinsicKind  = (bokProcedure, bokFunction, bokConstant);
  TPasIntrinsicClass = class of TPasIntrinsic;

  TPasIntrinsic = class(TIntrinsic)
  private
    FKind:      TPasIntrinsicKind;
    FArgsCount: Integer;
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); virtual; abstract;
  public
    constructor Create(const AName: Integer; const AStrName: WideString;
                       AKind: TPasIntrinsicKind; AArgsCount: Integer);
    procedure   Execute(AVM: TLMDVMBase; ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TNullObject = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TUnassignedObject = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TInclude = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TExclude = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TBeep = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TArcTan = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCos = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDec = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TInc = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TSin = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TLowerCase = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  THigh = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TLow = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TLn = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TAnsiCompareStr = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TAnsiCompareText = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TAnsiLowerCase = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TAnsiUpperCase = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TAbs = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCompareStr = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCompareText = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDate = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDateTimeToStr = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDateToStr = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDayOfWeek = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDecodeDate = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TExp = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TFloatToStr = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TFrac = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TInt = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TIntToHex = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TIntToStr = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TIsLeapYear = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TIsValidIdent = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTrue = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TFalse = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TLength = class(TPasIntrinsic)
  protected
    function  FastLength(S: PWideChar): Integer;
    function  SlowLength(const S: OleVariant): Integer;
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TNow = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TOdd = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TPos = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TRandom = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TRound = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TSqr = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TSqrt = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TStrToDate = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TStrToDateTime = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TStrToFloat = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TStrToInt = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TStrToIntDef = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTime = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTimeToStr = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TStrToTime = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTrim = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTrimLeft = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTrimRight = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTrunc = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TUpperCase = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TVarIsNull = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TVarToStr = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TAssigned = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TShowMessage = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TInsert = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCreateOleObject = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TGetActiveOleObject = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TInputQuery = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDecodeTime = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TEncodeDate = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TEncodeTime = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TFormat = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TFormatFloat = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TFormatDateTime = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TOrd = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TIncMonth = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TChr = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCopy = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDelete = class(TPasIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

const
  VSIZE       = SizeOf(OleVariant);
  VARDEEPDATA = $BFE8;

  {************************** constant LMDPasTokens ***************************}

  LMDPasTokens: array[TLMDPasToken] of TLMDPasTokenDescription = (
    (S: 'identifier';         IsKeyword: False;    ), { ptIdentifier }
    (S: 'string constant';    IsKeyword: False;    ), { ptCString }
    (S: 'number';             IsKeyword: False;    ), { ptCInteger }
    (S: 'real constant';      IsKeyword: False;    ), { ptCFloat }
    (S: 'array';              IsKeyword: True;     ), { ptArray }
    (S: 'begin';              IsKeyword: True;     ), { ptBegin }
    (S: 'case';               IsKeyword: True;     ), { ptCase }
    (S: 'const';              IsKeyword: True;     ), { ptConst }
    (S: 'do';                 IsKeyword: True;     ), { ptDo }
    (S: 'downto';             IsKeyword: True;     ), { ptDownto }
    (S: 'else';               IsKeyword: True;     ), { ptElse }
    (S: 'end';                IsKeyword: True;     ), { ptEnd }
    (S: 'except';             IsKeyword: True;     ), { ptExcept }
    (S: 'finally';            IsKeyword: True;     ), { ptFinally }
    (S: 'for';                IsKeyword: True;     ), { ptFor }
    (S: 'function';           IsKeyword: True;     ), { ptFunction }
    (S: 'if';                 IsKeyword: True;     ), { ptIf }
    (S: 'nil';                IsKeyword: True;     ), { ptNil }
    (S: 'of';                 IsKeyword: True;     ), { ptOf }
    (S: 'on';                 IsKeyword: True;     ), { ptOn }
    (S: 'out';                IsKeyword: True;     ), { ptOut }
    (S: 'procedure';          IsKeyword: True;     ), { ptProcedure }
    (S: 'raise';              IsKeyword: True;     ), { ptRaise }
    (S: 'repeat';             IsKeyword: True;     ), { ptRepeat }
    (S: 'then';               IsKeyword: True;     ), { ptThen }
    (S: 'to';                 IsKeyword: True;     ), { ptTo }
    (S: 'try';                IsKeyword: True;     ), { ptTry }
    (S: 'until';              IsKeyword: True;     ), { ptUntil }
    (S: 'uses';               IsKeyword: True;     ), { ptUses }
    (S: 'var';                IsKeyword: True;     ), { ptVar }
    (S: 'while';              IsKeyword: True;     ), { ptWhile }
    (S: 'and';                IsKeyword: True;     ), { ptAnd }
    (S: 'div';                IsKeyword: True;     ), { ptDiv }
    (S: '/';                  IsKeyword: False;    ), { ptDivide }
    (S: '=';                  IsKeyword: False;    ), { ptEqual }
    (S: '>';                  IsKeyword: False;    ), { ptGreater }
    (S: '>=';                 IsKeyword: False;    ), { ptGreaterEqual }
    (S: 'in';                 IsKeyword: True;     ), { ptIn }
    (S: 'is';                 IsKeyword: True;     ), { ptIs }
    (S: '<';                  IsKeyword: False;    ), { ptLess }
    (S: '<=';                 IsKeyword: False;    ), { ptLessEqual }
    (S: '-';                  IsKeyword: False;    ), { ptMinus }
    (S: 'mod';                IsKeyword: True;     ), { ptMod }
    (S: '*';                  IsKeyword: False;    ), { ptMultiply }
    (S: 'not';                IsKeyword: True;     ), { ptNot }
    (S: '<>';                 IsKeyword: False;    ), { ptNotEqual }
    (S: 'or';                 IsKeyword: True;     ), { ptOr }
    (S: '+';                  IsKeyword: False;    ), { ptPlus }
    (S: 'shl';                IsKeyword: True;     ), { ptShl }
    (S: 'shr';                IsKeyword: True;     ), { ptShr }
    (S: 'xor';                IsKeyword: True;     ), { ptXor }
    (S: ':=';                 IsKeyword: False;    ), { ptAssignment }
    (S: ']';                  IsKeyword: False;    ), { ptCloseBlock }
    (S: ')';                  IsKeyword: False;    ), { ptCloseRound }
    (S: ':';                  IsKeyword: False;    ), { ptColon }
    (S: ',';                  IsKeyword: False;    ), { ptComma }
    (S: '[';                  IsKeyword: False;    ), { ptOpenBlock }
    (S: '(';                  IsKeyword: False;    ), { ptOpenRound }
    (S: '.';                  IsKeyword: False;    ), { ptPeriod }
    (S: '..';                 IsKeyword: False;    ), { ptDoublePeriod }
    (S: ';';                  IsKeyword: False;    ), { ptSemiColon }
    (S: '@';                  IsKeyword: False;    ), { ptReference }
    (S: 'comment';            IsKeyword: False;    ), { ptComment }
    (S: 'end of file';        IsKeyword: False;    )  { ptEOf }
  );

  {**************************** Parser token sets *****************************}

  IdentifierTokens        = [ptIdentifier];
  RelOpTokens             = [ptGreater] + [ptLess] + [ptLessEqual] +
                            [ptGreaterEqual] + [ptNotEqual] + [ptEqual] +
                            [ptIn] + [ptIs];
  AddOpTokens             = [ptPlus] + [ptMinus] + [ptOr] + [ptXor];
  MulOpTokens             = [ptMultiply] + [ptDivide] + [ptDiv] + [ptMod] +
                            [ptAnd] + [ptShl] + [ptShr];
  DesignatorTokens        = IdentifierTokens;
  SetConstructorTokens    = [ptOpenBlock];
  FactorTokens            = DesignatorTokens + [ptCInteger] + [ptCFloat] +
                            [ptCString] + [ptNil] + [ptOpenRound] + [ptNot] +
                            [ptMinus] + [ptPlus] + SetConstructorTokens +
                            [ptArray] + [ptReference];
  TermTokens              = FactorTokens;
  SimpleExpressionTokens  = TermTokens;
  ExpressionTokens        = SimpleExpressionTokens;
  SetElementTokens        = ExpressionTokens;
  EmptyStmtTokens         = [ptSemiColon, ptElse, ptUntil, ptEnd];
  CompoundStmtTokens      = [ptBegin];
  IfStmtTokens            = [ptIf];
  CaseStmtTokens          = [ptCase];
  CaseLabelTokens         = ExpressionTokens;
  CaseSelectorTokens      = CaseLabelTokens;
  RepeatStmtTokens        = [ptRepeat];
  WhileStmtTokens         = [ptWhile];
  ForStmtTokens           = [ptFor];
  TryStmtTokens           = [ptTry];
  ExceptionBlockTokens    = [ptOn] + [ptElse];
  RaiseStmtTokens         = [ptRaise];
  StatementTokens         = DesignatorTokens + CompoundStmtTokens + IfStmtTokens +
                            CaseStmtTokens + RepeatStmtTokens + WhileStmtTokens +
                            ForStmtTokens + TryStmtTokens + RaiseStmtTokens +
                            EmptyStmtTokens;
  StmtListTokens          = StatementTokens;
  ProcedureDeclTokens     = [ptProcedure] + [ptFunction];
  UsesClauseTokens        = [ptUses];
  VarSectionTokens        = [ptVar];
  VarDeclTokens           = IdentifierTokens;
  ConstSectionTokens      = [ptConst];
  ConstDeclTokens         = IdentifierTokens;

var
  IntegerNameIndex:  Integer;
  StringNameIndex:   Integer;
  DoubleNameIndex:   Integer;
  SingleNameIndex:   Integer;
  BooleanNameIndex:  Integer;
  VariantNameIndex:  Integer;
  ByteNameIndex:     Integer;
  WordNameIndex:     Integer;
  LongWordNameIndex: Integer;
  SmallintNameIndex: Integer;
  CurrencyNameIndex: Integer;
  ShortIntNameIndex: Integer;
  Int64NameIndex:    Integer;
  UInt64NameIndex:   Integer;
  ErrorNameIndex:    Integer;
  ObjectNameIndex:   Integer;

{**************************** class TLMDPasScanner ****************************}
{ --------------------------------- private ---------------------------------- }

procedure TLMDPasScanner.NextChar;
begin
  if FCurChar <> nil then
    Inc(FCurChar);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.GetCurCharPos: Integer;
begin
  if FCurChar = nil then
    Result := 0
  else
    Result := (FCurChar - FSource) + 1; // Return in Delphi format,
                                        // starting from 1. 
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.SkipBlanks;
begin
  while (FCurChar <> nil) and (FCurChar^ <> #0) do
  begin
    if (Ord(FCurChar^) <= 255) and (AnsiChar(FCurChar^) in [#33..#255]) then
      Break;
    Inc(FCurChar);
  end;
end;
                                                         
{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.ScanToken;
var
  tknpos:      Integer;
  tkn:         TLMDPasToken;
  sdt:         WideString;
  illegalChar: WideChar;
  idt:         Integer;
  fdt:         Extended;
begin
  tknpos := GetCurCharPos;

  case FCurChar^ of
    'A'..'Z', 'a'..'z', '_':
    begin
      sdt := ScanIdentifier;
      tkn := DetectReservedWord(sdt);
    end;
    '0'..'9', '$':
      tkn := ScanNumber(True, idt, fdt);
    '''', '#':
    begin
      sdt := ScanString;
      tkn := ptCString;
    end;
    '=':
    begin
      tkn := ptEqual;
      NextChar;
    end;
    '>':
    begin
      NextChar;
      if FCurChar^ = '=' then
      begin
        tkn := ptGreaterEqual;
        NextChar;
      end
      else tkn := ptGreater;
    end;
    '<':
    begin
      NextChar;
      if FCurChar^ = '=' then
      begin
        tkn := ptLessEqual;
        NextChar;
      end
      else if FCurChar^ = '>' then
      begin
        tkn := ptNotEqual;
        NextChar;
      end
      else tkn := ptLess;
    end;
    ':':
    begin
      NextChar;
      if FCurChar^ = '=' then
      begin
        tkn := ptAssignment;
        NextChar;
      end
      else tkn := ptColon;
    end;
    '/':
    begin
      NextChar;
      if FCurChar^ = '/' then
      begin
        { Comment }

        sdt := '//';
        NextChar;
        while not ((Ord(FCurChar^) <= 255) and
                   (AnsiChar(FCurChar^) in [#0, #13, #10])) do
        begin
          sdt := sdt + FCurChar^;
          NextChar;
        end;
        tkn := ptComment;
      end
      else
        tkn := ptDivide;
    end;
    '{':
    begin
      { Comment }

      sdt := '{';
      NextChar;
      while not ((Ord(FCurChar^) <= 255) and
                 (AnsiChar(FCurChar^) in [#0, '}'])) do
      begin
        sdt := sdt + FCurChar^;
        NextChar;
      end;
      if FCurChar^ = '}' then
      begin
        sdt := sdt + '}';
        NextChar;
      end;
      tkn := ptComment;
    end;
    '(':
    begin
      NextChar;
      if FCurChar^ = '*' then
      begin
        { Comment }

        sdt := '(*';
        NextChar;
        while FCurChar^ <> #0 do
        begin
          sdt := sdt + FCurChar^;
          if FCurChar^ = '*' then
          begin
            NextChar;
            if FCurChar^ = ')' then
            begin
              sdt := sdt + ')';
              NextChar;
              Break;
            end;
          end
          else
            NextChar;
        end;
        tkn := ptComment;
      end
      else
        tkn := ptOpenRound;
    end;
    '.':
    begin
      NextChar;
      if FCurChar^ = '.' then
      begin
        tkn := ptDoublePeriod;
        NextChar;
      end
      else tkn := ptPeriod;
    end;
    ')': begin tkn := ptCloseRound; NextChar; end;
    '[': begin tkn := ptOpenBlock; NextChar; end;
    ']': begin tkn := ptCloseBlock; NextChar; end;
    ',': begin tkn := ptComma; NextChar; end;
    ';': begin tkn := ptSemiColon; NextChar; end;
    '@': begin tkn := ptReference; NextChar; end;
    '+': begin tkn := ptPlus; NextChar; end;
    '-': begin tkn := ptMinus; NextChar; end;
    '*': begin tkn := ptMultiply; NextChar; end;
  else
    illegalChar := FCurChar^;
    raise ELMDPasCompiler.CreateFmt(SLMDIllegalChar, [WideString(illegalChar),
                                                      Ord(illegalChar)],
                                    GetCurCharPos);
  end;

  FTokenStartPos := tknpos;
  FTokenEndPos   := GetCurCharPos - 1;
  FToken         := tkn;

  case tkn of
    ptIdentifier,
    ptComment,
    ptCString:      FSData := sdt;
    ptCInteger:     FIData := idt;
    ptCFloat:       FFData := fdt;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.ScanNumber(ALLowFloat: Boolean; out IntVal: Integer;
  out FloatVal: Extended): TLMDPasToken;
var
  cbegin:       PWideChar;
  isFloat:      Boolean;
  oldCurChar:   PWideChar;
  s:            WideString;
  valCode:      Integer;
begin
  cbegin  := FCurChar;
  isFloat := False;
  case FCurChar^ of
    '0'..'9':
      begin
        while (Ord(FCurChar^) <= 255) and (AnsiChar(FCurChar^) in ['0'..'9']) do
        begin
          NextChar;
          if (FCurChar^ = '.') and AllowFloat then
          begin
            oldCurChar := FCurChar;
            NextChar;
            if FCurChar^ = '.' then // Handle ptDoublePeriod
              FCurChar := oldCurChar
            else
              isFloat := True;
          end;
        end;
        if (Ord(FCurChar^) <= 255) and (AnsiChar(FCurChar^) in ['E', 'e']) and
           AllowFloat then
        begin
          isFloat := True;
          NextChar;
          if (Ord(FCurChar^) <= 255) and (AnsiChar(FCurChar^) in ['+', '-']) then
            NextChar;
          while (Ord(FCurChar^) <= 255) and (AnsiChar(FCurChar^) in ['0'..'9']) do
            NextChar;
        end;
        SetString(s, cbegin, FCurChar - cbegin);
        if isFloat then
        begin
          Val(s, FloatVal, valCode);
          if valCode <> 0 then
            raise ELMDPasCompiler.Create(SLMDWrongFloat, GetCurCharPos - 1);
          Result := ptCFloat;
        end
        else
        begin
          Val(s, IntVal, valCode);
          if valCode <> 0 then
            raise ELMDPasCompiler.Create(SLMDWrongInteger, GetCurCharPos - 1);
          Result := ptCInteger;
        end;
      end;
    '$':
      begin
        NextChar;
        while (Ord(FCurChar^) <= 255) and
              (AnsiChar(FCurChar^) in ['0'..'9', 'A'..'F', 'a'..'f']) do
          NextChar;
        SetString(s, cbegin, FCurChar - cbegin);
        Val(s, IntVal, valCode);
        if valCode <> 0 then
          raise ELMDPasCompiler.Create(SLMDWrongInteger, GetCurCharPos - 1);
        Result := ptCInteger;
      end;
  else
    raise ELMDPasCompiler.Create(SLMDWrongInteger, GetCurCharPos - 1);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.ScanIdentifier: WideString;
var
  cbegin: PWideChar;
begin
  cbegin := FCurChar;
  while (Ord(FCurChar^) <= 255) and
        (AnsiChar(FCurChar^) in ['A'..'Z', 'a'..'z', '_', '0'..'9']) do
    NextChar;
  SetString(Result, cbegin, FCurChar - cbegin);
end;
                                                              
{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.ScanString: WideString;
var
  idx, cap: Integer;
  ival:     Integer;
  fval:     Extended;
begin
  idx := 1;
  cap := 16;
  SetLength(Result, cap);

  while True do
    case FCurChar^ of
      '''':
      begin
        { Read quoted string }

        NextChar; // Skip quote.

        while True do
        begin
          if (Ord(FCurChar^) <= 255) and (AnsiChar(FCurChar^) in [#0, #13, #10]) then
            raise ELMDPasCompiler.Create(SLMDUnterminatedStr, GetCurCharPos - 1);

          if FCurChar^ = '''' then // In case of double quote, leave the
                                   // position at the second quote char.
          begin
            NextChar;
            if FCurChar^ <> '''' then
              Break; // while
          end;

          if idx > cap then // Grow.
          begin
            cap := cap * 2;
            SetLength(Result, cap);
          end;
          Result[idx] := FCurChar^;
          Inc(idx);

          NextChar;
        end;
      end;
      '#':
      begin
        { Read char code }

        NextChar;
        ScanNumber(False, ival, fval);

        if idx > cap then // Grow.
        begin
          cap := cap * 2;
          SetLength(Result, cap);
        end;
        Result[idx] := WideChar(Word(ival));
        Inc(idx);
      end;
    else
      Break;
    end;

  SetLength(Result, idx - 1);
end;
                                                              
{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.DetectReservedWord(const Token: WideString): TLMDPasToken;
var
  i: TLMDPasToken;
begin
  for i := Low(LMDPasTokens) to High(LMDPasTokens) do
    with LMDPasTokens[i] do
      if IsKeyword and SameText(S, Token) then
      begin
        Result := i;
        Exit;
      end;
  Result := ptIdentifier;
end;
                                                              
{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.NextToken;
begin
  while True do
  begin
    SkipBlanks;
    if (FCurChar <> nil) and (FCurChar^ <> #0) then
      ScanToken
    else
    begin
      FToken         := ptEOf;
      FTokenStartPos := GetCurCharPos;
      FTokenEndPos   := GetCurCharPos;
    end;

    if not FSkipComments or (FToken <> ptComment) then
      Break;
  end;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDPasScanner.Create(SkipComments: Boolean);
begin
  inherited Create;
  FSkipComments := SkipComments;
end;
                                                     
{ ---------------------------------------------------------------------------- }

destructor TLMDPasScanner.Destroy;
begin
  inherited;
end;
                                                     
{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.TokenToStr(Token: TLMDPasToken): WideString;
begin
  Result := '''' + LMDPasTokens[Token].S + '''';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.GetSavepoint: TLMDPasScannerSavepoint;
begin
  Result := @FSource[TokenStartPos - 1];
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.Rollback(const S: TLMDPasScannerSavepoint);
begin
  FCurChar := S;
  NextToken;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.Start(const Source: WideString);
begin
  FStrSource := Source;
  FSource    := PWideChar(FStrSource);
  FCurChar   := FSource;
  NextToken;
end;
                                                  
{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.SkipToken;
begin
  NextToken;
end;
                                          
{ *************************** TLMDPasParser ********************************* }
{-----------------------------------------------------------------------------}

procedure TLMDPasParser.CheckAndSkipTokens(
  ATokens: TLMDPasTokens);
begin
  CheckTokens(ATokens);
  SkipToken;
end;

{-----------------------------------------------------------------------------}

procedure TLMDPasParser.CheckTokens(ATokens: TLMDPasTokens);
begin
  if not (FScanner.Token in ATokens) then
    InvalidTokenError(FScanner.Token);
end;

{-----------------------------------------------------------------------------}

constructor TLMDPasParser.Create(ACbs: ILMDParserCallbacks);
begin
  inherited Create;

  FScanner := TLMDPasScanner.Create;
  FCbs     := ACbs;
end;

{-----------------------------------------------------------------------------}

destructor TLMDPasParser.Destroy;
begin
  FScanner.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.GetCurToken: TLMDPasToken;
begin
  Result := FScanner.Token;
end;

{-----------------------------------------------------------------------------}

procedure TLMDPasParser.InvalidTokenError(AToken: TLMDPasToken);
begin
  raise ELMDPasCompiler.CreateFmt(SLMDInvalidTokenShort,
                                  [FScanner.TokenToStr(AToken)],
                                  FScanner.TokenEndPos);
end;

{-----------------------------------------------------------------------------}

procedure TLMDPasParser.SkipToken;
begin
  FLastSkippedPos := FScanner.TokenEndPos;
  FScanner.SkipToken;
end;

{-----------------------------------------------------------------------------}

procedure TLMDPasParser.Parse(const ASource: WideString);
begin
  FScanner.Start(ASource);
  ParseUnit;
  CheckAndSkipTokens([ptEOf]);
end;

{-----------------------------------------------------------------------------}

procedure TLMDPasParser.ParseUnit;
var
  i:     Integer;
  stmts: TLMDStmtList;
begin
  CheckTokens(UsesClauseTokens + VarSectionTokens +
              ConstSectionTokens + ProcedureDeclTokens +
              [ptBegin] + [ptEOf]);

  if CurToken in UsesClauseTokens then
    ParseUsesClause;

  while CurToken in (VarSectionTokens + ConstSectionTokens +
                     ProcedureDeclTokens) do
  begin
    if CurToken in (VarSectionTokens) then
      ParseGlobalVarSection
    else if CurToken in (ConstSectionTokens) then
      ParseGlobalConstSection
    else
      ParseProcedureDecl;
  end;

  if CurToken = ptBegin then
  begin
    SkipToken;

    stmts := TLMDStmtList.Create(False); // Not own items.
    try
      ParseStmtList(stmts);
      for i := 0 to stmts.Count - 1 do
        FCbs.GlobalStmtParsed(stmts[i]);
    finally
      stmts.Free;
    end;

    CheckAndSkipTokens([ptEnd]);
    CheckAndSkipTokens([ptSemiColon]);
  end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDPasParser.ParseUsesClause;
label
  L;
var
  unit_:  TLMDUsedUnit;
  unitnm: Integer;
  s:      WideString;
begin
  CheckAndSkipTokens([ptUses]);

L:
  unitnm := ParseIdentifier(s);
  unit_  := TLMDUsedUnit.Create(unitnm);
  try
    DoAddUsedUnit(s);
  except
    unit_.Free;
    raise;
  end;
  CheckTokens([ptComma] + [ptSemiColon]);

  if CurToken in ([ptComma]) then
  begin
    CheckAndSkipTokens([ptComma]);
    goto L;
  end;

  CheckAndSkipTokens([ptSemiColon]);
end;

{-----------------------------------------------------------------------------}
procedure TLMDPasParser.ParseLocalVarDecl(AProc: TLMDProcedureDecl);
label
  L;
var
  vardcl: TLMDLocalVarDecl;
  name:   Integer;
  strnm:  WideString;
begin
L:
  name   := ParseIdentifier(strnm);
  vardcl := TLMDLocalVarDecl.Create(name, strnm);
  try
    DoAddProcLocal(vardcl, AProc);
  except
    vardcl.Free;
    raise;
  end;

  if CurToken = ptEqual then
  begin
    SkipToken;
    vardcl.FExpr := ParseExpression;
  end;

  if CurToken = ptComma then
  begin
    SkipToken;
    goto L;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPasParser.ParseLocalVarSection(AProc: TLMDProcedureDecl);
begin
  CheckAndSkipTokens([ptVar]);

  ParseLocalVarDecl(AProc);
  CheckAndSkipTokens([ptSemiColon]);

  while CurToken in VarDeclTokens do
  begin
    ParseLocalVarDecl(AProc);
    CheckAndSkipTokens([ptSemiColon]);
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDPasParser.ParseGlobalVarDecl;
label
  L;
var
  vardcl:  TLMDVarObject;
  vname:   Integer;
  strnm:   WideString;
  exprs:   TLMDExpression;
begin
L:
  vname  := ParseIdentifier(strnm);
  vardcl := TLMDVarObject.Create(vname, strnm);
  try
    if CurToken = ptEqual then
    begin
      SkipToken;
      exprs := ParseExpression;
      FCbs.GlobalStmtParsed(TLMDGlobalVarIniter.Create(vardcl, exprs));
    end;

    DoAddGlobalObject(vardcl);
  except
    vardcl.Free;
    raise;
  end;

  if CurToken = ptComma then
  begin
    SkipToken;
    goto L;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDPasParser.ParseGlobalVarSection;
begin
  CheckAndSkipTokens([ptVar]);

  ParseGlobalVarDecl;
  CheckAndSkipTokens([ptSemiColon]);

  while CurToken in VarDeclTokens do
  begin
    ParseGlobalVarDecl;
    CheckAndSkipTokens([ptSemiColon]);
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDPasParser.ParseGlobalConstSection;
label
  L;
begin
  CheckAndSkipTokens([ptConst]);
L:
  ParseGlobalConstDecl;
  CheckAndSkipTokens([ptSemiColon]);
  if CurToken in ConstDeclTokens then
    goto L;
end;

{------------------------------------------------------------------------------}
procedure TLMDPasParser.ParseLocalConstSection(AProc: TLMDProcedureDecl);
label
  L;
var
  lcst: TLMDLocalConstDecl;
begin
  CheckAndSkipTokens([ptConst]);
L:
  lcst := ParseLocalConstDecl;
  try
    DoAddProcLocal(lcst, AProc);
  except
    lcst.Free;
    raise;
  end;

  CheckAndSkipTokens([ptSemiColon]);

  if CurToken in ConstDeclTokens then
    goto L;
end;

{-----------------------------------------------------------------------------}
procedure TLMDPasParser.ParseGlobalConstDecl;
var
  cstnm: Integer;
  strnm: WideString;
  gcst:  TLMDConstObject;
  expr:  TLMDExpression;
begin
  cstnm := ParseIdentifier(strnm);
  gcst  := TLMDConstObject.Create(cstnm, strnm);
  try
    CheckAndSkipTokens([ptEqual]);

    expr := ParseExpression;
    FCbs.GlobalStmtParsed(TLMDGlobalConstIniter.Create(gcst, expr));

    DoAddGlobalObject(gcst);
  except
    gcst.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseLocalConstDecl: TLMDLocalConstDecl;
var
  cstnm: Integer;
  strnm: WideString;
begin
  cstnm := ParseIdentifier(strnm);
  CheckAndSkipTokens([ptEqual]);

  Result := TLMDLocalConstDecl.Create(cstnm, strnm);
  try
    Result.Expr := ParseExpression;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDPasParser.ParseProcedureDecl;
const
  PROC_KINDS: array[Boolean] of TLMDProcKind = (pkFunction, pkProcedure);
var
  pname:  Integer;
  pdecl:  TLMDProcedureDecl;
  pknd:   TLMDProcKind;
  strnm:  WideString;
  resitm: TLMDLocalResultDecl;
begin
  CheckTokens([ptProcedure] + [ptFunction]);
  pknd := PROC_KINDS[CurToken = ptProcedure];
  SkipToken;

  pname := ParseIdentifier(strnm);
  pdecl := TLMDProcedureDecl.Create(pname, strnm, pknd);
  try
    pdecl.FSourcePos := FLastSkippedPos;

    if pknd = pkFunction then
    begin
      // Add Result variable first to prohibit
      // locals with the same name.

      resitm := TLMDLocalResultDecl.Create(FCbs.GetNameId('Result'), 'Result');
      pdecl.AddLocalItem(resitm);
    end;

    CheckTokens([ptOpenRound] + [ptSemiColon]);

    if CurToken in [ptOpenRound] then
    begin
      SkipToken;
      if CurToken <> ptCloseRound then
        ParseParamsDecl(pdecl);
      CheckAndSkipTokens([ptCloseRound]);
    end;

    CheckAndSkipTokens([ptSemiColon]);
    CheckTokens(VarSectionTokens + ConstSectionTokens + [ptBegin]);

    while CurToken in (VarSectionTokens + ConstSectionTokens) do
    begin
      if CurToken in (VarSectionTokens) then
        ParseLocalVarSection(pdecl)
      else
        ParseLocalConstSection(pdecl);
    end;

    CheckAndSkipTokens([ptBegin]);
    CheckTokens(StmtListTokens + [ptEnd]);

    ParseStmtList(pdecl.StmtList);

    CheckAndSkipTokens([ptEnd]);
    pdecl.FEndSourcePos := FLastSkippedPos;
    CheckAndSkipTokens([ptSemiColon]);

    DoAddGlobalObject(pdecl);
  except 
    pdecl.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDPasParser.ParseParamsDecl(AProc: TLMDProcedureDecl);
label
  L;
var
  prm: TLMDParamDecl;
begin
L:
  prm := ParseParamDecl;
  try
    DoAddProcLocal(prm, AProc);
  except
    prm.Free;
    raise;
  end;

  if CurToken in ([ptSemiColon]) then
  begin
    SkipToken;
    goto L;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseParamDecl: TLMDParamDecl;
var
  pknd:  TLMDParamKind;
  pname: Integer;
  strnm: WideString;
begin
  pknd := pkSimple;

  if CurToken in ([ptVar] + [ptOut] + [ptConst]) then
  begin
    if CurToken in ([ptVar]) then
    begin
      SkipToken;
      pknd := pkByRef;
    end
    else if CurToken in ([ptOut]) then
    begin
      SkipToken;
      pknd := pkByRef;
    end
    else if CurToken in ([ptConst]) then
    begin
      SkipToken;
      pknd := pkConst;
    end;
  end;

  pname  := ParseIdentifier(strnm);
  Result := TLMDParamDecl.Create(pname, strnm, pknd);
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseStatement: TLMDStatement;
var
  dsgnr: TLMDDesignatorExpr;
  right: TLMDExpression;
  spos:  Integer;
begin
  CheckTokens(DesignatorTokens + CompoundStmtTokens + IfStmtTokens +
              CaseStmtTokens + RepeatStmtTokens + WhileStmtTokens +
              ForStmtTokens + TryStmtTokens + RaiseStmtTokens +
              EmptyStmtTokens);

  if CurToken in (DesignatorTokens) then
  begin
    dsgnr := ParseDesignator;
    try
      if CurToken = ptAssignment then
      begin
        SkipToken;
        spos  := FLastSkippedPos;
        right := ParseExpression;

        Result                                := TLMDAssignmentStmt.Create;
        TLMDAssignmentStmt(Result).FLeftExpr  := dsgnr;
        TLMDAssignmentStmt(Result).FRightExpr := right;
        Result.FSourcePos                     := spos;
      end
      else
      begin
        Result                           := TLMDExpressionStmt.Create;
        TLMDExpressionStmt(Result).FExpr := dsgnr;
        Result.FSourcePos                := FLastSkippedPos;
      end;
    except
      dsgnr.Free;
      raise;
    end;
  end
  else if CurToken in (CompoundStmtTokens) then
  begin
    Result := ParseCompoundStmt;
  end
  else if CurToken in (IfStmtTokens) then
  begin
    Result := ParseIfStmt;
  end
  else if CurToken in (CaseStmtTokens) then
  begin
    Result := ParseCaseStmt;
  end
  else if CurToken in (RepeatStmtTokens) then
  begin
    Result := ParseRepeatStmt;
  end
  else if CurToken in (WhileStmtTokens) then
  begin
    Result := ParseWhileStmt;
  end
  else if CurToken in (ForStmtTokens) then
  begin
    Result := ParseForStmt;
  end
  else if CurToken in (TryStmtTokens) then
  begin
    Result := ParseTryStmt;
  end
  else if CurToken in (RaiseStmtTokens) then
  begin
    Result := ParseRaiseStmt;
  end
  else
  begin
    Result := ParseEmptyStmt;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseStmt(const ASource: WideString): ILMDEmitable;
begin
  FScanner.Start(ASource);
  Result := ParseStatement;
  try
    CheckAndSkipTokens([ptEOf]);
  except
    Result.Free;
    raise;
  end;
end;

procedure TLMDPasParser.ParseStmtList(AStmtList: TLMDStmtList);
label
  L;
var
  stmt: TLMDStatement;
begin
L:
  stmt := ParseStatement;
  if stmt is TLMDPasEmptyStmt then
    stmt.Free
  else
    AStmtList.Add(stmt);

  if (CurToken in EmptyStmtTokens) and
     (CurToken <> ptSemiColon) then
    Exit;

  CheckAndSkipTokens([ptSemiColon]);

  if CurToken in StatementTokens then
    goto L;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseCompoundStmt: TLMDCompound;
begin
  CheckAndSkipTokens([ptBegin]);
  CheckTokens(StmtListTokens + [ptEnd]);

  Result := TLMDCompound.Create;
  try
    ParseStmtList(Result.StmtList);
    CheckAndSkipTokens([ptEnd]);
    Result.FSourcePos := FLastSkippedPos;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseIfStmt: TLMDIfStmt;
begin
  Result := TLMDIfStmt.Create;
  try
    CheckAndSkipTokens([ptIf]);
    Result.FSourcePos := FLastSkippedPos;
    Result.FIfExpr    := ParseExpression;

    CheckAndSkipTokens([ptThen]);
    Result.FThenStmt := ParseStatement;

    if CurToken in [ptElse] then
    begin
      SkipToken;
      Result.FElseStmt := ParseStatement;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseCaseStmt: TLMDCaseStmt;
begin
  Result :=  TLMDCaseStmt.Create;
  try
    CheckAndSkipTokens([ptCase]);
    Result.FSourcePos := FLastSkippedPos;
    Result.FCaseExpr  := ParseExpression;

    CheckAndSkipTokens([ptOf]);
    Result.AddSelector(ParseCaseSelector);

    CheckAndSkipTokens([ptSemiColon]);
    CheckTokens(CaseSelectorTokens + [ptEnd, ptElse]);

    while CurToken in CaseSelectorTokens do
    begin
      Result.AddSelector(ParseCaseSelector);
      CheckAndSkipTokens([ptSemiColon]);
    end;

    if CurToken = ptElse then
    begin
      SkipToken;
      CheckTokens(StmtListTokens + [ptEnd]);
      ParseStmtList(Result.ElseStmtList);
    end;

    CheckAndSkipTokens([ptEnd]);
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseCaseSelector: TLMDCaseSelector;
begin
  Result := TLMDCaseSelector.Create;
  try
    Result.AddLabel(ParseCaseLabel);
    CheckTokens([ptComma] + [ptColon]);

    while CurToken in [ptComma] do
    begin
      SkipToken;
      Result.AddLabel(ParseCaseLabel);
    end;

    CheckAndSkipTokens([ptColon]);
    Result.FStmt := ParseStatement;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseCaseLabel: TLMDCaseLabel;
begin
  Result := TLMDCaseLabel.Create;
  try
    Result.FFirstExpr := ParseExpression;

    if CurToken in [ptDoublePeriod] then
    begin
      SkipToken;
      Result.FSecondExpr := ParseExpression;
    end;

    Result.FSourcePos := FLastSkippedPos;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseRepeatStmt: TLMDRepeatStmt;
begin
  Result := TLMDRepeatStmt.Create;
  try
    CheckAndSkipTokens([ptRepeat]);
    Result.FSourcePos := FLastSkippedPos;

    ParseStmtList(Result.StmtList);
    CheckAndSkipTokens([ptUntil]);

    Result.FRepeatExpr := ParseExpression();
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.ParseWhileStmt: TLMDWhileStmt;
begin
  Result := TLMDWhileStmt.Create;
  try
    CheckAndSkipTokens([ptWhile]);
    Result.FSourcePos := FLastSkippedPos;

    Result.FWhileExpr := ParseExpression;
    CheckAndSkipTokens([ptDo]);
    Result.FStmt      := ParseStatement;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseForStmt: TLMDForStmt;
var
  varnm: Integer;
  s:     WideString;
  spos:  Integer;
begin
  CheckAndSkipTokens([ptFor]);
  spos  := FLastSkippedPos;
  varnm := ParseIdentifier(s);

  Result := TLMDForStmt.Create;
  try
    Result.FSourcePos  := spos;
    Result.FVarExpr := TLMDDesignatorExpr.CreateSimple(varnm, s, spos);

    CheckAndSkipTokens([ptAssignment]);
    Result.FFromExpr := ParseExpression;

    CheckTokens([ptTo] + [ptDownto]);
    if CurToken in ([ptTo]) then
      Result.FCounterKind := ckTo
    else
      Result.FCounterKind := ckDownto;
    SkipToken;

    Result.FToExpr := ParseExpression;
    CheckAndSkipTokens([ptDo]);

    Result.FStmt := ParseStatement;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseTryStmt: TLMDTryStmt;
var
  olsts: TLMDPasParserTryState;
begin
  olsts  := FTryState;
  Result := TLMDTryStmt.Create;
  try
    CheckAndSkipTokens([ptTry]);
    Result.FSourcePos := FLastSkippedPos;

    CheckTokens(StmtListTokens + [ptExcept] + [ptFinally]);

    if CurToken in (StmtListTokens) then
    begin
      FTryState := ptsInTry;
      ParseStmtList(Result.TryStmtList);
    end;

    CheckTokens([ptExcept] + [ptFinally]);

    if CurToken in ([ptExcept]) then
    begin
      SkipToken;

      FTryState           := ptsInExcept;
      Result.FTryStmtType := ttExcept;

      if CurToken in (ExceptionBlockTokens) then
        Result.FExceptionBlock := ParseExceptionBlock
      else
        ParseStmtList(Result.ExceptStmtList);
    end
    else
    begin
      CheckAndSkipTokens([ptFinally]);

      FTryState           := ptsInFinally;
      Result.FTryStmtType := ttFinally;

      ParseStmtList(Result.FinallyStmtList);
    end;

    CheckAndSkipTokens([ptEnd]);
  except
    Result.Free;
    FTryState := olsts;
    raise;
  end;

  FTryState := olsts;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseEmptyStmt: TLMDPasEmptyStmt;
begin
  // Special processing: Do not skip token here. This will
  // emulate Delphi behavior.

  CheckTokens(EmptyStmtTokens);
  Result := TLMDPasEmptyStmt.Create;
end;

function TLMDPasParser.ParseExceptionBlock: TLMDExceptionBlock;
var
  evarnm:   Integer;
  evarsnm:  WideString;
  subblock: TLMDExceptionSubBlock;
  sp:       TLMDPasParserSavepoint;
  colon:    Boolean;
  spos:     Integer;
begin
  Result := TLMDExceptionBlock.Create;
  try
    while CurToken in ([ptOn]) do
    begin
      CheckAndSkipTokens([ptOn]);
      spos := FLastSkippedPos;

      CheckTokens(IdentifierTokens + ExpressionTokens);

      evarnm  := -1;
      evarsnm := '';
      if CurToken in (IdentifierTokens) then
      begin
        sp := GetSavepoint;
        SkipToken;
        colon := (CurToken = ptColon);
        Rollback(sp);

        if colon then
        begin
          evarnm := ParseIdentifier(evarsnm);
          CheckAndSkipTokens([ptColon]);
        end;
      end;

      subblock := TLMDExceptionSubBlock.Create(evarnm, evarsnm);
      try
        subblock.FSourcePos := spos;
        subblock.FExpr      := ParseExpression;

        CheckAndSkipTokens([ptDo]);
        subblock.FStmt := ParseStatement;
        CheckAndSkipTokens([ptSemiColon]);

        Result.AddBlock(subblock);
      except
        subblock.Free;
        raise;
      end;
    end;

    if CurToken in ([ptElse]) then
    begin
      SkipToken;
      Result.FHasElse       := True;
      Result.FElseSourcePos := FLastSkippedPos;

      ParseStmtList(Result.ElseStmtList);
    end;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.ParseRaiseStmt: TLMDRaiseStmt;
begin
  Result := TLMDRaiseStmt.Create;
  try
    CheckAndSkipTokens([ptRaise]);
    Result.FSourcePos := FLastSkippedPos;

    if CurToken in ExpressionTokens then
      Result.FExpr := ParseExpression
    else if FTryState <> ptsInExcept then
      raise ELMDPasCompiler.Create(SLMDParserReRaise, FLastSkippedPos);
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.ParseExpr(const ASource: WideString): ILMDEmitable;
begin
  FScanner.Start(ASource);
  Result := ParseExpression;
  try
    CheckAndSkipTokens([ptEOf]);
  except
    Result.Free;
    raise;
  end;
end;

function TLMDPasParser.ParseExpression: TLMDExpression;
var
  bop: TLMDBinaryOp;
begin
  Result := ParseSimpleExpression;
  try
    while CurToken in (RelOpTokens) do
    begin
      bop    := ParseRelOp;
      Result := CreateBinaryExpr(bop, Result);

      with TLMDBinaryExpr(Result) do
      begin
        FRightExpr := ParseSimpleExpression;
        FSourcePos := FLastSkippedPos;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.ParseSimpleExpression: TLMDExpression;
var
  bop: TLMDBinaryOp;
begin
  Result := ParseTerm;
  try
    while CurToken in (AddOpTokens) do
    begin
      bop    := ParseAddOp;
      Result := CreateBinaryExpr(bop, Result);

      with TLMDBinaryExpr(Result) do
      begin
        FRightExpr := ParseTerm;
        FSourcePos := FLastSkippedPos;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.ParseTerm: TLMDExpression;
var
  bop: TLMDBinaryOp;
begin
  Result := ParseFactor;
  try
    while CurToken in (MulOpTokens) do
    begin
      bop    := ParseMulOp;
      Result := CreateBinaryExpr(bop, Result);

      with TLMDBinaryExpr(Result) do
      begin
        FRightExpr := ParseFactor;
        FSourcePos := FLastSkippedPos;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.ParseFactor: TLMDExpression;
var
  strnm: WideString;
begin
  CheckTokens(DesignatorTokens + [ptCInteger] + [ptCFloat] + [ptCString] +
              [ptNil] + [ptOpenRound] + [ptNot] + [ptMinus] +
              [ptPlus] + SetConstructorTokens + [ptArray] + [ptReference]);

  if CurToken in (DesignatorTokens) then
  begin
    Result := ParseDesignator;
  end
  else if CurToken in ([ptCInteger]) then
  begin
    SkipToken;
    Result := TLMDLiteral.Create(FScanner.IData);
  end
  else if CurToken in ([ptCFloat]) then
  begin
    SkipToken;
    Result := TLMDLiteral.Create(FScanner.FData);
  end
  else if CurToken in ([ptCString]) then
  begin
    SkipToken;
    Result := TLMDLiteral.Create(FScanner.SData);
  end
  else if CurToken in ([ptNil]) then
  begin
    SkipToken;
    Result := TLMDLiteral.Create(PasNil);
  end
  else if CurToken in ([ptOpenRound]) then
  begin
    SkipToken;
    Result := ParseExpression;
    try
      CheckAndSkipTokens([ptCloseRound]);
    except
      Result.Free;
      raise;
    end;
  end
  else if CurToken in ([ptNot]) then
  begin
    SkipToken;
    Result := CreateUnaryExpr(uopNot);
    try
      with TLMDUnaryExpr(Result) do
        FExpr := ParseFactor;
    except
      Result.Free;
      raise;
    end;
  end
  else if CurToken in ([ptMinus]) then
  begin
    SkipToken;
    Result := CreateUnaryExpr(uopMinus);
    try
      with TLMDUnaryExpr(Result) do
        FExpr := ParseFactor;
    except
      Result.Free;
      raise;
    end;
  end
  else if CurToken in ([ptPlus]) then
  begin
    SkipToken;
    Result := CreateUnaryExpr(uopPlus);
    try
      with TLMDUnaryExpr(Result) do
        FExpr := ParseFactor;
    except
      Result.Free;
      raise;
    end;
  end
  else if CurToken in (SetConstructorTokens) then
  begin
    Result := TLMDPasSetExpr.Create;
    try
      CheckAndSkipTokens([ptOpenBlock]);
      ParseSetElements(TLMDPasSetExpr(Result));
      Result.FSourcePos := FScanner.TokenEndPos;
      CheckAndSkipTokens([ptCloseBlock]);
    except
      Result.Free;
      raise;
    end;
  end
  else if CurToken in [ptArray] then
  begin
    CheckAndSkipTokens([ptArray]);
    CheckAndSkipTokens([ptOpenBlock]);

    Result := TLMDArrayExpr.Create;
    try
      ParseArrayDim(TLMDArrayExpr(Result));

      CheckTokens([ptComma] + [ptCloseBlock]);
      while CurToken in ([ptComma]) do
      begin
        SkipToken;
        ParseArrayDim(TLMDArrayExpr(Result));
      end;

      Result.FSourcePos := FScanner.TokenEndPos;
      CheckAndSkipTokens([ptCloseBlock]);

      if CurToken in ([ptOf]) then
      begin
        SkipToken;
        Result.FSourcePos                  := FScanner.TokenEndPos;
        TLMDArrayExpr(Result).FElemVarType := ParseArrayType;
      end;
    except
      Result.Free;
      raise;
    end;
  end
  else
  begin
    CheckAndSkipTokens([ptreference]);

    Result            := TLMDEventMakeExpr.Create(ParseIdentifier(strnm));
    Result.FSourcePos := FScanner.TokenEndPos;
    TLMDEventMakeExpr(Result).FStrProcName := strnm;
  end;

  Result.FSourcePos := FLastSkippedPos;
end;

{------------------------------------------------------------------------------}
procedure TLMDPasParser.ParseArrayDim(AArrExpr: TLMDArrayExpr);
var
  arrdim: TLMDArrayDim;
begin
  arrdim := TLMDArrayDim.Create;
  try
    arrdim.FLeftExpr := ParseExpression;

    if CurToken in ([ptDoublePeriod]) then
    begin
      SkipToken;
      arrdim.FRightExpr := ParseExpression;
    end
    else
    begin
      arrdim.FRightExpr := arrdim.LeftExpr;
      arrdim.FLeftExpr  := TLMDLiteral.Create(0);
    end;

    arrdim.FSourcePos := FLastSkippedPos;
    AArrExpr.AddArrayDim(arrdim);
  except
    arrdim.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.ParseRelOp: TLMDBinaryOp;
begin
  CheckTokens([ptGreater] + [ptLess] + [ptLessEqual] + [ptGreaterEqual] +
              [ptNotEqual] + [ptEqual] + [ptIn] + [ptIs]);

  case CurToken of
    ptGreater     : Result := bopGreater;
    ptLess        : Result := bopLess;
    ptLessEqual   : Result := bopLessEqual;
    ptGreaterEqual: Result := bopGreaterEqual;
    ptNotEqual    : Result := bopNotEqual;
    ptEqual       : Result := bopEqual;
    ptIn          : Result := bopIn;
    ptIs          : Result := bopIs;
  else
    Result := TLMDBinaryOp(-1);
  end;

  SkipToken;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.ParseAddOp: TLMDBinaryOp;
begin
  CheckTokens([ptPlus] + [ptMinus] + [ptOr] + [ptXor]);

  case CurToken of
    ptPlus        : Result := bopPlus;
    ptMinus       : Result := bopMinus;
    ptOr          : Result := bopOr;
    ptXor         : Result := bopXor;
  else
    Result := TLMDBinaryOp(-1);
  end;

  SkipToken;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.ParseMulOp: TLMDBinaryOp;
begin
  CheckTokens([ptMultiply] + [ptDivide] + [ptDiv] + [ptMod] + [ptAnd] +
              [ptShl] + [ptShr]);

  case CurToken of
    ptMultiply    : Result := bopMultiply;
    ptDivide      : Result := bopDivide;
    ptDiv         : Result := bopDiv;
    ptMod         : Result := bopMod;
    ptAnd         : Result := bopAnd;
    ptShl         : Result := bopShl;
    ptShr         : Result := bopShr;
  else
    Result := TLMDBinaryOp(-1);
  end;

  SkipToken;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.ParseDesignator: TLMDDesignatorExpr;
var
  item: TLMDDesignatorItem;
begin
  Result := TLMDDesignatorExpr.Create;
  try
    item := ParseNamedCall;
    Result.AddItem(item);

    while True do
    begin
      case CurToken of
        ptPeriod:
        begin
          SkipToken;
          item := ParseNamedCall;
          Result.AddItem(item);
        end;
        ptOpenBlock:
        begin
          SkipToken;
          if item = nil then
          begin
            item := TLMDDesignatorItem.Create;
            Result.AddItem(item);
          end;

          item.FBracketType := bkBlock;

          item.AddArg(ParseExpression);
          CheckTokens([ptComma] + [ptCloseBlock]);
          while CurToken in ([ptComma]) do
          begin
            SkipToken;
            item.AddArg(ParseExpression);
          end;

          CheckAndSkipTokens([ptCloseBlock]);
          item.FSourcePos := FLastSkippedPos;
          item            := nil;
        end;
        ptOpenRound:
        begin
          SkipToken;
          if item = nil then
          begin
            item := TLMDDesignatorItem.Create;
            Result.AddItem(item);
          end;

          item.FBracketType := bkRound;

          if CurToken <> ptCloseRound then
          begin
            item.AddArg(ParseExpression);
            CheckTokens([ptComma] + [ptCloseRound]);
            while CurToken in ([ptComma]) do
            begin
              SkipToken;
              item.AddArg(ParseExpression);
            end;
          end;

          CheckAndSkipTokens([ptCloseRound]);
          item.FSourcePos := FLastSkippedPos;
          item            := nil;
        end;
      else
        Break; // while
      end;
    end;

    Result.FSourcePos := FLastSkippedPos;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.GetSavepoint: TLMDPasParserSavepoint;
begin
  Result.ScannerSP      := FScanner.GetSavepoint;
  Result.TryState       := FTryState;
  Result.LastSkippedPos := FLastSkippedPos;
end;

{-----------------------------------------------------------------------------}

procedure TLMDPasParser.ParseSetElements(ASetExpr: TLMDPasSetExpr);
begin
  CheckTokens(SetElementTokens + [ptCloseBlock]);

  if CurToken in (SetElementTokens) then
  begin
    ASetExpr.AddSetElement(ParseSetElement);

    while CurToken in ([ptComma]) do
    begin
      SkipToken;
      ASetExpr.AddSetElement(ParseSetElement);
    end;
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.ParseSetElement: TLMDSetElement;
begin
  Result := TLMDSetElement.Create;
  try
    Result.FLeftExpr := ParseExpression;
    if CurToken in ([ptDoublePeriod]) then
    begin
      SkipToken;
      Result.FRightExpr := ParseExpression;
    end;

    Result.FSourcePos := FLastSkippedPos;
  except
    Result.Free;
    raise;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseIdentifier: Integer;
var
  s: WideString;
begin
  CheckTokens([ptIdentifier]);

  s      := FScanner.SData;
  Result := FCbs.GetNameId(s);

  SkipToken;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseIdentifier(out AStrName: WideString): Integer;
begin
  CheckTokens([ptIdentifier]);

  AStrName := FScanner.SData;
  Result   := FCbs.GetNameId(AStrName);

  SkipToken;
end;

{------------------------------------------------------------------------------}
function TLMDPasParser.ParseArrayType: TVarType;
var
  name: Integer;
begin
  name := ParseIdentifier;

  if name = SmallintNameIndex then
    Result := varSmallint
  else if name = IntegerNameIndex then
    Result := varInteger
  else if name = SingleNameIndex then
    Result := varSingle
  else if name = DoubleNameIndex then
    Result := varDouble
  else if name = CurrencyNameIndex then
    Result := varCurrency
  else if name = StringNameIndex then
    Result := varOleStr
  else if name = ObjectNameIndex then
    Result := varDispatch
  else if name = ErrorNameIndex then
    Result := varError
  else if name = BooleanNameIndex then
    Result := varBoolean
  else if name = VariantNameIndex then
    Result := varVariant
  else if name = ShortIntNameIndex then
    Result := varShortInt
  else if name = ByteNameIndex then
    Result := varByte
  else if name = WordNameIndex then
    Result := varWord
  else if name = LongWordNameIndex then
    Result := varLongWord
  else if name = Int64NameIndex then
    Result := varInt64
  else if name = UInt64NameIndex then
    {$IFDEF LMDCOMP12}
    Result := varUInt64
    {$ELSE}
    Result := varInt64
    {$ENDIF}
  else
    raise ELMDPasCompiler.Create(SLMDParserTypeExpected, FLastSkippedPos);
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.ParseNamedCall: TLMDDesignatorItem;
var
  strnm: WideString;
  name:  Integer;
begin
  name              := ParseIdentifier(strnm);
  Result            := TLMDDesignatorItem.Create(name, strnm);
  Result.FSourcePos := FLastSkippedPos;
end;

{-----------------------------------------------------------------------------}

function TLMDPasParser.CreateBinaryExpr(AOper: TLMDBinaryOp;
  ALeft: TLMDExpression): TLMDBinaryExpr;
begin
  Result           := TLMDBinaryExpr.Create(AOper);
  Result.FLeftExpr := ALeft;
end;

{-----------------------------------------------------------------------------}
function TLMDPasParser.CreateUnaryExpr(
  AOper: TLMDUnaryOp): TLMDUnaryExpr;
begin
  Result := TLMDUnaryExpr.Create(AOper);
end;

{----------------------------- private ----------------------------------------}
procedure TLMDPasParser.DoAddGlobalObject(AObj: TLMDGlobalObject);
var
  dupnm: Boolean;
begin
  FCbs.GlobalObjParsed(AObj, dupnm);
  if dupnm then
    raise ELMDPasCompiler.CreateFmt(SLMDDuplicateNamedItem, [AObj.StrName],
                                    FLastSkippedPos);
end;

{------------------------------------------------------------------------------}
procedure TLMDPasParser.DoAddProcLocal(AItem: TLMDProcLocal;
  AProc: TLMDProcedureDecl);
var
  added: Boolean;
begin
  added := AProc.AddLocalItem(AItem);
  if not added then
    raise ELMDPasCompiler.CreateFmt(SLMDDuplicateNamedItem, [AItem.StrName],
                                    FLastSkippedPos);
end;

{------------------------------------------------------------------------------}
procedure TLMDPasParser.DoAddUsedUnit(const AUnitName: WideString);
var
  dupnm: Boolean;
begin
  FCbs.UsedUnitParsed(AUnitName, dupnm);
  if dupnm then
    raise ELMDPasCompiler.CreateFmt(SLMDDuplicateNamedItem, [AUnitName],
                                    FLastSkippedPos);
end;

{------------------------------------------------------------------------------}
function TLMDPasParser.PasNil: OleVariant;
var
  d: IDispatch;
begin
  d      := nil;
  Result := d;
end;

procedure TLMDPasParser.Rollback(const ASavepoint: TLMDPasParserSavepoint);
begin
  FScanner.Rollback(ASavepoint.ScannerSP);
  FTryState       := ASavepoint.TryState;
  FLastSkippedPos := ASavepoint.LastSkippedPos;
end;

{************************* class TLMDPasProcedureDecl *************************}
{ --------------------------------- public ----------------------------------- }
destructor TLMDProcedureDecl.Destroy;
begin
  FLocalNamespace.Free;
  FLocalMap.Free; // Clears all children.
  FParams.Free;
  FLocalVars.Free;
  FLocalConsts.Free;
  FStmtList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDProcedureDecl.EmitByteCode(
  AGlobalNamespace: TLMDAbstractNamespace);
var
  i:     Integer;
  ctx:   TLMDContext;
  oldsp: Integer;
  locns: TLMDAbstractNamespace;
begin
  { Prepare }

  locns := CreateLocalNS(AGlobalNamespace);

  FillChar(ctx, SizeOf(ctx), 0);
  ctx.Code         := ByteCode;
  ctx.CurNamespace := locns;

  { Emit }

  ctx.Code.BeginEmit(StrName, locns, FSourcePos);

  for i := 0 to FLocalVars.Count - 1 do
    TLMDLocalVarDecl(FLocalVars[i]).FIndex := ctx.Code.AddLocalVar;

  for i := 0 to FLocalVars.Count - 1 do
    if TLMDLocalVarDecl(FLocalVars[i]).Expr <> nil then
    begin
      TLMDLocalVarDecl(FLocalVars[i]).Expr.EmitByteCode(ctx);
      ctx.Code.Emit(icAssignLocalVar,
                    TObject(TLMDLocalVarDecl(FLocalVars[i]).FIndex));
    end;

  for i := 0 to FStmtList.Count - 1 do
    FStmtList[i].EmitByteCode(ctx);

  ctx.Code.BeginSourcePos(EndSourcePos, oldsp);
  ctx.Code.SetNextInstrBreakable;
  ctx.Code.Emit(icRet);
  ctx.Code.EndSourcePos(oldsp);
  ctx.Code.EndEmit;
end;

{------------------------------------------------------------------------------}
function TLMDProcedureDecl.GetGlobalObjType: TLMDGlobalObjType;
begin
  Result := gtProcedure;
end;

{------------------------------------------------------------------------------}
function TLMDProcedureDecl.AddLocalItem(AItem: TLMDProcLocal): Boolean;
var
  prm: TLMDParamDecl;
begin
  if not FLocalMap.Add(AItem) then
  begin
    Result := False;
    Exit;
  end;

  case AItem.LocalType of
    ltVar:    begin
                FLocalVars.Add(AItem);
              end;
    ltConst:  FLocalConsts.Add(AItem);
    ltParam:  begin
                prm                  := TLMDParamDecl(AItem);
                prm.FParamInfo.Index := FParams.Add(prm);
                ParamAdded; // Adjust inherited ParamCount.
              end;
    ltResult: FLocalResult := TLMDLocalResultDecl(AItem);
  end;

  Result := True;
end;

{------------------------------------------------------------------------------}
constructor TLMDProcedureDecl.Create(AName: Integer;
  const AStrName: WideString; AProcKind: TLMDProcKind);
begin
  inherited Create(AName, AStrName);

  FProcKind       := AProcKind;
  FLocalMap       := TLMDNameHashTable.Create(True);
  FStmtList       := TLMDStmtList.Create;
  FParams         := TList.Create;
  FLocalVars      := TList.Create;
  FLocalConsts    := TList.Create;
  FLocalNamespace := nil;
  ResMask         := $FFFFFFFF * DWORD(Ord(AProcKind = pkFunction));
end;

function TLMDProcedureDecl.CreateLocalNS(
  AParent: TLMDAbstractNamespace): TLMDProcLocalNamespace;
begin
  Assert(FLocalNamespace = nil); // Need list of namespaces to
                                 // properly free them.
  FLocalNamespace := TLMDProcLocalNamespace.Create(Self, AParent);
  Result          := FLocalNamespace;
end;

{ --------------------------------- private ----------------------------------- }
function TLMDProcedureDecl.GetParams(AIndex: Integer): TLMDParamDecl;
begin
  Result := FParams[AIndex];
end;

{------------------------------------------------------------------------------}
function TLMDProcedureDecl.GetLocalConstCount: Integer;
begin
  Result := FLocalConsts.Count;
end;

{------------------------------------------------------------------------------}
function TLMDProcedureDecl.GetLocalConsts(AIndex: Integer): TLMDLocalConstDecl;
begin
  Result := FLocalConsts[AIndex];
end;

{------------------------------------------------------------------------------}
function TLMDProcedureDecl.GetLocalVars(AIndex: Integer): TLMDLocalVarDecl;
begin
  Result := FLocalVars[AIndex];
end;

{************************** class TLMDPasParamDecl ****************************}
{ --------------------------------- public ----------------------------------- }
constructor TLMDParamDecl.Create(AName: Integer; const AStrName: WideString;
  AParamKind: TLMDParamKind);
begin
  inherited Create(ltParam, AName, AStrName);
  FParamInfo.Kind := Word(AParamKind);
end;

{******************************* class TLMDPasIf ******************************}
{ --------------------------------- public ----------------------------------- }
constructor TLMDIfStmt.Create;
begin
  inherited Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDIfStmt.Destroy;
begin
  FIfExpr.Free;
  FThenStmt.Free;
  FElseStmt.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDIfStmt.DoEmitByteCode(var C: TLMDContext);
var
  elseL: TLMDLabel;
  endL:  TLMDLabel;
begin
  elseL := C.Code.CreateLabel;
  FIfExpr.EmitByteCode(C, erPopJmpIfFalse, elseL);
  FThenStmt.EmitByteCode(C);

  if FElseStmt <> nil then
  begin
    endL := C.Code.CreateLabel;
    C.Code.Emit(icJump, endL); // Skip else code.
    C.Code.BindLabel(elseL);
    FElseStmt.EmitByteCode(C);
    C.Code.BindLabel(endL);
  end
  else
    C.Code.BindLabel(elseL);
end;

{*************************** class TLMDPasCaseStmt ****************************}
{ --------------------------------- public ----------------------------------- }
procedure TLMDCaseStmt.AddSelector(ASelector: TLMDCaseSelector);
begin
  FSelectors.Add(ASelector);
end;

{------------------------------------------------------------------------------}
constructor TLMDCaseStmt.Create;
begin
  inherited Create;
  FSelectors := TList.Create;
  FElseStmts  := TLMDStmtList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDCaseStmt.Destroy;
var
  i: Integer;
begin
  for i := 0 to FSelectors.Count - 1 do
    TObject(FSelectors[i]).Free;
  FSelectors.Free;
  FElseStmts.Free;
  FCaseExpr.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaseStmt.DoEmitByteCode(var C: TLMDContext);
var
  i, j:     Integer;
  endL:     TLMDLabel;
  elseL:    TLMDLabel;
  stmtL:    array of TLMDLabel;
  tstinstr: TLMDInstrCode;
  slcr:     TLMDCaseSelector;
begin
  endL  := C.Code.CreateLabel;
  elseL := C.Code.CreateLabel;
  SetLength(stmtL, FSelectors.Count);
  for i := 0 to High(stmtL) do
    stmtL[i] := C.Code.CreateLabel;

  FCaseExpr.EmitByteCode(C);

  for i := 0 to FSelectors.Count - 1 do
  begin
    slcr := TLMDCaseSelector(FSelectors[i]);

    for j := 0 to slcr.LabelCount - 1 do
    begin
      slcr.Labels[j].EmitExpressions(C, tstinstr);
      C.Code.Emit(tstinstr, stmtL[i]);
    end;
  end;

  C.Code.Emit(icPop);
  C.Code.Emit(icJump, elseL);

  for i := 0 to FSelectors.Count - 1 do
  begin
    slcr := TLMDCaseSelector(FSelectors[i]);

    C.Code.BindLabel(stmtL[i]);
    slcr.FStmt.EmitByteCode(C);
    C.Code.Emit(icJump, endL);
  end;

  C.Code.BindLabel(elseL);
  FElseStmts.EmitByteCode(C);
  C.Code.BindLabel(endL);
end;

{-------------------------------- private -------------------------------------}
function TLMDCaseStmt.GetSelectorCount: Integer;
begin
  Result := FSelectors.Count;
end;

{------------------------------------------------------------------------------}
function TLMDCaseStmt.GetSelectors(AIndex: Integer): TLMDCaseSelector;
begin
  Result := FSelectors[AIndex];
end;

{***************************** TLMDPasCaseSelector ****************************}
{ --------------------------------- public ----------------------------------- }
procedure TLMDCaseSelector.AddLabel(ALabel: TLMDCaseLabel);
begin
  FLabels.Add(ALabel);
end;

{------------------------------------------------------------------------------}
constructor TLMDCaseSelector.Create;
begin
  inherited Create;
  FLabels := TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDCaseSelector.Destroy;
var
  i: Integer;
begin
  for i := 0 to FLabels.Count - 1 do
    TObject(FLabels[i]).Free;
  FLabels.Free;
  FStmt.Free;
  inherited;
end;

{---------------------------------- private -----------------------------------}
function TLMDCaseSelector.GetLabelCount: Integer;
begin
  Result := FLabels.Count;
end;

{------------------------------------------------------------------------------}
function TLMDCaseSelector.GetLabels(AIndex: Integer): TLMDCaseLabel;
begin
  Result := FLabels[AIndex];
end;

{*************************** class TLMDPasCaseLabel ***************************}
{ --------------------------------- public ----------------------------------- }
constructor TLMDCaseLabel.Create;
begin
  inherited Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDCaseLabel.Destroy;
begin
  FFirstExpr.Free;
  FSecondExpr.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaseLabel.EmitExpressions(var C: TLMDContext;
  out ATestInstr: TLMDInstrCode);
var
  oldsp: Integer;
begin
  C.Code.BeginSourcePos(FSourcePos, oldsp);

  FFirstExpr.EmitByteCode(C);
  ATestInstr := icCaseJmpIfEqual;

  if FSecondExpr <> nil then
  begin
    FSecondExpr.EmitByteCode(C);
    ATestInstr := icCaseJmpIfInRange;
  end;

  C.Code.EndSourcePos(oldsp);
end;

{***************************** class TLMDPasRepeat ****************************}
{ --------------------------------- public ----------------------------------- }
constructor TLMDRepeatStmt.Create;
begin
  inherited Create;
  FStmtList := TLMDStmtList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDRepeatStmt.Destroy;
begin
  FStmtList.Free;
  FRepeatExpr.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRepeatStmt.DoEmitByteCode(var C: TLMDContext);
var
  L:      TLMDLabel;
  oldebc: TLMDEBC;
begin
  L := C.Code.CreateLabel;
  C.Code.BindLabel(L);

  oldebc := C.CurEBC;
  C.CurEBC.BreakL    := C.Code.CreateLabel;
  C.CurEBC.ContinueL := C.Code.CreateLabel;

  FStmtList.EmitByteCode(C);

  C.Code.BindLabel(C.CurEBC.ContinueL);
  C.Code.SetNextInstrBreakable;
  FRepeatExpr.EmitByteCode(C, erPopJmpIfFalse, L);
  C.Code.BindLabel(C.CurEBC.BreakL);

  C.CurEBC := oldebc;
end;

{*************************** class TLMDPasWhileStmt ***************************}
{ --------------------------------- public ----------------------------------- }
constructor TLMDWhileStmt.Create;
begin
  inherited Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDWhileStmt.Destroy;
begin
  FStmt.Free;
  FWhileExpr.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDWhileStmt.DoEmitByteCode(var C: TLMDContext);
var
  L, exprL: TLMDLabel;
  oldebc:   TLMDEBC;
begin
  exprL := C.Code.CreateLabel;
  L     := C.Code.CreateLabel;

  oldebc             := C.CurEBC;
  C.CurEBC.BreakL    := C.Code.CreateLabel;
  C.CurEBC.ContinueL := L;

  C.Code.Emit(icJump, L);
  C.Code.BindLabel(exprL);

  FStmt.EmitByteCode(C);

  C.Code.BindLabel(L);
  C.Code.SetNextInstrBreakable;
  FWhileExpr.EmitByteCode(C, erPopJmpIfTrue, exprL);
  C.Code.BindLabel(C.CurEBC.BreakL);

  C.CurEBC := oldebc;
end;

{**************************** class TLMDPasForStmt ****************************}
{ --------------------------------- public ----------------------------------- }
destructor TLMDForStmt.Destroy;
begin
  FFromExpr.Free;
  FToExpr.Free;
  FStmt.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDForStmt.DoEmitByteCode(var C: TLMDContext);
const
  INCCMDS: array[TLMDForCounterKind] of TLMDInstrCode = (icForInc,
                                                         icForDec);
  JMPCMDS: array[TLMDForCounterKind] of TLMDInstrCode = (icForJmpIfLE,
                                                         icForJmpIfGE);
var
  L1, L2:    TLMDLabel;
  for_:      TLMDFor;
  oldebc:    TLMDEBC;
  sres:      TLMDNameSearchRes;
  varnm:     Integer;
  varsnm:    WideString;
begin
  L1 := C.Code.CreateLabel;
  L2 := C.Code.CreateLabel;

  oldebc             := C.CurEBC;
  C.CurEBC.BreakL    := C.Code.CreateLabel;
  C.CurEBC.ContinueL := C.Code.CreateLabel;

  varnm        := FVarExpr.Items[0].Name;
  varsnm       := FVarExpr.Items[0].StrName;
  sres.ObjKind := srNotFound;
  if C.CurNamespace <> nil then
    sres := C.CurNamespace.CompileTimeFind(varnm);

  if sres.ObjKind = srLocalVar then
  begin
    for_ := C.Code.AddFor(L1, sres.LocalVarIndex, False);

    FFromExpr.EmitByteCode(C);
    C.Code.Emit(icForInitLocal, for_); // Counter var.
  end
  else
  begin
    for_ := C.Code.AddFor(L1, False);

    FVarExpr.EmitRefByteCode(C);
    FFromExpr.EmitByteCode(C);
    C.Code.Emit(icForInitLValue, for_); // Counter var.
  end;

  FToExpr.EmitByteCode(C);
  C.Code.Emit(icAssignLocalVar, TObject(for_.ToVar));

  C.Code.Emit(icJump, L2);

  C.Code.BindLabel(L1);
  FStmt.EmitByteCode(C);

  C.Code.BindLabel(C.CurEBC.ContinueL);
  C.Code.Emit(INCCMDS[CounterKind], for_);

  C.Code.BindLabel(L2);
  C.Code.SetNextInstrBreakable;
  C.Code.Emit(JMPCMDS[CounterKind], for_);
  C.Code.BindLabel(C.CurEBC.BreakL);

  C.CurEBC := oldebc;
end;

{************************** class TLMDAssignmentStmt **************************}
{ --------------------------------- public ----------------------------------- }
function TLMDAssignmentStmt.AsgnCallInstrProc(var C: TLMDContext;
  AItem: TLMDDesignatorItem; out AInstr: TLMDInstr;
  out ANeedSlot: Boolean): Boolean;
const
  MBR_ASGNCALLS: array[Boolean] of TLMDInstrCode = (icAssignUnnamedCall,
                                                    icAssignMemberCall);
var
  icode: TLMDInstrCode;
  first: Boolean;
begin
  if AItem = FLeftExpr.LastItem then
  begin
    first := (AItem = FLeftExpr.Items[0]);

    if first then
      icode := icAssignGlobCall
    else
      icode := MBR_ASGNCALLS[AItem.IsNamed];

    AInstr := FLeftExpr.OptimizeCallInstr(C, AItem, icode, first, True,
                                          ANeedSlot);
    ANeedSlot := False; // Assignment never require a slot.
    Result    := True;
  end
  else
    Result := False;
end;

constructor TLMDAssignmentStmt.Create;
begin
  inherited Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDAssignmentStmt.Destroy;
begin
  FLeftExpr.Free;
  FRightExpr.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDAssignmentStmt.DoEmitByteCode(var C: TLMDContext);
begin
  FLeftExpr.InternalEmit(C, False, AsgnCallInstrProc,
                         EmitValueProc);
end;

procedure TLMDAssignmentStmt.EmitValueProc(var C: TLMDContext;
  AItem: TLMDDesignatorItem);
begin
  if AItem = FLeftExpr.LastItem then
    FRightExpr.EmitByteCode(C);
end;

{*************************** class TLMDPasRaiseStmt ***************************}
{ --------------------------------- public ----------------------------------- }
constructor TLMDRaiseStmt.Create;
begin
  inherited Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDRaiseStmt.Destroy;
begin
  FExpr.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRaiseStmt.DoEmitByteCode(var C: TLMDContext);
begin
  if FExpr = nil then
    C.Code.Emit(isReraise, TObject(C.CurReraise.ExceptionVar))
  else
  begin
    FExpr.EmitByteCode(C);
    C.Code.Emit(icRaise);
  end;
end;

{**************************** class TLMDPasTryStmt ****************************}
{ --------------------------------- public ----------------------------------- }
constructor TLMDTryStmt.Create;
begin
  inherited Create;
  FTryStmtList     := TLMDStmtList.Create;
  FExceptStmtList  := TLMDStmtList.Create;
  FFinallyStmtList := TLMDStmtList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDTryStmt.Destroy;
begin
  FTryStmtList.Free;
  FExceptStmtList.Free;
  FFinallyStmtList.Free;
  FExceptionBlock.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDTryStmt.DoEmitByteCode(var C: TLMDContext);
begin
  C.Code.ManualResetNextInstrBreakable;
  if FTryStmtType = ttFinally then
    EmitTryFinally(C)
  else
    EmitTryExcept(C);
end;

procedure TLMDTryStmt.EmitTryExcept(var C: TLMDContext);
var
  i:            Integer;
  endL:         TLMDLabel;
  elseL:        TLMDLabel;
  tryitm:       TLMDTry;
  stmtLs:       array of TLMDLabel;
  oldreraise:   TLMDTry;
  excns:        TLMDAbstractNamespace;
  onvar:        Integer;
  oldns:        TLMDAbstractNamespace;
  haspntloop:   Boolean;
  ebc, oldebc:  TLMDEBC;
begin
  haspntloop := (C.CurEBC.BreakL <> nil);
  oldebc     := C.CurEBC;

  tryitm               := C.Code.BeginProtectedBlock;
  tryitm.HandlerLabel  := C.Code.CreateLabel;
  tryitm.ExceptionVar  := C.Code.AddLocalVarArray(2);
  endL                 := C.Code.CreateLabel;

  { Try }

  FTryStmtList.EmitByteCode(C);
  C.Code.EndProtectedBlock;
  C.Code.Emit(icJump, endL);

  { Exception system handler }

  C.Code.BeginExcHdrCode(tryitm);
  C.Code.BindLabel(tryitm.HandlerLabel);
  C.Code.Emit(icSetNamespace, C.CurNamespace);

  oldreraise   := C.CurReraise;
  C.CurReraise := tryitm;

  ebc.ExitL     := C.Code.CreateLabel;
  ebc.BreakL    := nil;
  ebc.ContinueL := nil;
  if haspntloop then
  begin
    ebc.BreakL    := C.Code.CreateLabel;
    ebc.ContinueL := C.Code.CreateLabel;
  end;
  C.CurEBC := ebc;

  if FExceptionBlock = nil then
  begin
    { Simple except }

    FExceptStmtList.EmitByteCode(C);
    C.Code.Emit(icExceptDone);
    C.Code.Emit(icJump, endL);
  end
  else
  begin
    { Complex except with 'on' clauses }

    SetLength(stmtLs, FExceptionBlock.BlockCount);
    for i := 0 to High(stmtLs) do
      stmtLs[i] := C.Code.CreateLabel;

    { Dispatching code }

    for i := 0 to FExceptionBlock.BlockCount - 1 do
    begin
      FExceptionBlock.Blocks[i].Expr.EmitByteCode(C);
      C.Code.Emit(icExceptJmpIfIs, C.Code.AddExcJmp(tryitm, stmtLs[i]));
    end;

    elseL := C.Code.CreateLabel;
    C.Code.Emit(icJump, elseL);

    { Exception bloks stmts }

    for i := 0 to FExceptionBlock.BlockCount - 1 do
    begin
      if FExceptionBlock.Blocks[i].Name = -1 then
      begin
        // on TMyException do

        C.Code.BindLabel(stmtLs[i]);
        FExceptionBlock.Blocks[i].Stmt.EmitByteCode(C);
      end
      else
      begin
        // on E: TMyException do

        onvar          := C.Code.AddLocalVar;
        excns          := FExceptionBlock.Blocks[i].CreateNS(C.CurNamespace,
                                                             onvar);
        oldns          := C.CurNamespace;
        C.CurNamespace := excns;

        C.Code.BindLabel(stmtLs[i]);
        C.Code.Emit(icSetNamespace, excns);
        C.Code.Emit(icExceptToVar, TObject(tryitm.ExceptionVar));
        C.Code.Emit(icAssignLocalVar, TObject(onvar));

        FExceptionBlock.Blocks[i].Stmt.EmitByteCode(C);
        C.Code.Emit(icSetNamespace, oldns);

        C.CurNamespace := oldns;
      end;

      C.Code.Emit(icExceptDone);
      C.Code.Emit(icJump, endL);
    end;

    // 'else' except block

    C.Code.BindLabel(elseL);

    if FExceptionBlock.HasElse then
    begin
      FExceptionBlock.ElseStmtList.EmitByteCode(C);
      C.Code.Emit(icExceptDone);
      C.Code.Emit(icJump, endL);
    end
    else
      C.Code.Emit(isReraise, TObject(tryitm.ExceptionVar)); // Reraise on
                                                            // implicit else.
  end;

  C.CurEBC     := oldebc;
  C.CurReraise := oldreraise;

  C.Code.EndExcHdrCode(tryitm);

  { Exit, Break and Continue proxy handlers }

  if haspntloop then
  begin
    C.Code.BindLabel(ebc.BreakL);
    C.Code.Emit(icExceptDone);
    C.Code.Emit(icJump, oldebc.BreakL);

    C.Code.BindLabel(ebc.ContinueL);
    C.Code.Emit(icExceptDone);
    C.Code.Emit(icJump, oldebc.ContinueL);
  end;

  C.Code.BindLabel(ebc.ExitL);
  C.Code.Emit(icExceptDone);
  if oldebc.ExitL <> nil then
    C.Code.Emit(icJump, oldebc.ExitL)
  else
    C.Code.Emit(icRet);

  C.Code.BindLabel(endL);
end;

procedure TLMDTryStmt.EmitTryFinally(var C: TLMDContext);
type
  TFinallyReturn = (frNormal, frExit, frBreak, frContinue);
var
  endL:         TLMDLabel;
  tryitm:       TLMDTry;
  invalidEBCL:  TLMDLabel;
  haspntloop:   Boolean;
  ebc, oldebc:  TLMDEBC;
  i:            TFinallyReturn;
  frets:        array[TFinallyReturn] of TLMDLabel;
begin
  FillChar(frets, Sizeof(frets), 0);
  haspntloop := (C.CurEBC.BreakL <> nil);
  oldebc     := C.CurEBC;

  if (FFinallyStmtList.Count = 0) then    // Nothing in finally, so
    FTryStmtList.EmitByteCode(C)          // just emit try shild stmts.
  else
  begin
    tryitm                := C.Code.BeginProtectedBlock;
    tryitm.FinallyLabel   := C.Code.CreateLabel;
    tryitm.HandlerLabel   := C.Code.CreateLabel;
    tryitm.FinallyRetVar  := C.Code.AddLocalVar;
    frets[frNormal]       := C.Code.CreateLabel;
    frets[frExit]         := C.Code.CreateLabel;
    if haspntloop then
    begin
      frets[frBreak]      := C.Code.CreateLabel;
      frets[frContinue]   := C.Code.CreateLabel;
    end;
    tryitm.ExceptionVar   := C.Code.AddLocalVarArray(2);
    endL                  := C.Code.CreateLabel;

    { Try }

    ebc.ExitL     := C.Code.CreateLabel;
    ebc.BreakL    := nil;
    ebc.ContinueL := nil;
    if haspntloop then
    begin
      ebc.BreakL    := C.Code.CreateLabel;
      ebc.ContinueL := C.Code.CreateLabel;
    end;
    C.CurEBC := ebc;

    FTryStmtList.EmitByteCode(C);
    C.Code.EndProtectedBlock;
    C.Code.Emit(icCallFinally, tryitm);
    C.Code.BindLabel(frets[frNormal]);
    C.Code.Emit(icJump, endL);

    C.CurEBC := oldebc;

    { Finally code }

    // Note: This code acts as a lightweight sub-routine and it is
    //       called in following situations:
    // - Immediatelly after try child stmts.
    // - When Exit, Break or Continue leaves execution away from the try
    //   region.
    // - From exception handler (in case of exception in try child stmts).

    C.Code.BeginExcHdrCode(tryitm);

    invalidEBCL        := C.Code.CreateLabel;
    C.CurEBC.ExitL     := invalidEBCL;  // Executing Exit, Break or
    C.CurEBC.BreakL    := invalidEBCL;  // Continue from finally
    C.CurEBC.ContinueL := invalidEBCL;  // section in invalid.

    C.Code.BindLabel(tryitm.FinallyLabel);
    FFinallyStmtList.EmitByteCode(C);
    C.Code.Emit(icFinallyRet, tryitm);

    C.CurEBC := oldebc;

    C.Code.EndExcHdrCode(tryitm);

    { Exit, Break and Continue proxy handlers }

    if haspntloop then
    begin
      C.Code.BindLabel(ebc.BreakL);
      C.Code.Emit(icCallFinally, tryitm);
      C.Code.BindLabel(frets[frBreak]);
      C.Code.Emit(icJump, oldebc.BreakL);

      C.Code.BindLabel(ebc.ContinueL);
      C.Code.Emit(icCallFinally, tryitm);
      C.Code.BindLabel(frets[frContinue]);
      C.Code.Emit(icJump, oldebc.ContinueL);
    end;

    C.Code.BindLabel(ebc.ExitL);
    C.Code.Emit(icCallFinally, tryitm);
    C.Code.BindLabel(frets[frExit]);
    if oldebc.ExitL <> nil then
      C.Code.Emit(icJump, oldebc.ExitL)
    else
      C.Code.Emit(icRet);

    { Invalid Exit, Break and Continue from finally handler }

    C.Code.BindLabel(invalidEBCL);
    C.Code.Emit(icRaiseEBCFromFinally);

    { Exception system handler }

    // Note: This handler called only by exception subsystem in case of
    //       exceptions in try child stmts. This code is NOT called in case
    //       when finally stmts are executed by other reasons.

    C.Code.BindLabel(tryitm.HandlerLabel);
    C.Code.Emit(icSetNamespace, C.CurNamespace);
    C.Code.Emit(icCallFinally, tryitm);
    C.Code.Emit(isReraise, TObject(tryitm.ExceptionVar));

    C.Code.BindLabel(endL);

    for i := Low(TFinallyReturn) to High(TFinallyReturn) do
    begin
      if frets[i] <> nil then
        tryitm.AddKnownFinallyRet(frets[i]);
    end;
  end;
end;

{************************ class TLMDPasExceptionBlock *************************}
{ --------------------------------- public ----------------------------------- }
procedure TLMDExceptionBlock.AddBlock(ABlock: TLMDExceptionSubBlock);
begin
  FBlocks.Add(ABlock);
end;

{------------------------------------------------------------------------------}
constructor TLMDExceptionBlock.Create;
begin
  inherited Create;
  FBlocks := TList.Create;
  FElseStmtList := TLMDStmtList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDExceptionBlock.Destroy;
var
  i: Integer;
begin
  for i := 0 to FBlocks.Count - 1 do
    TObject(FBlocks[i]).Free;
  FBlocks.Free;
  FElseStmtList.Free;
  inherited;
end;

{----------------------------- private ----------------------------------------}
function TLMDExceptionBlock.GetBlockCount: Integer;
begin
  Result := FBlocks.Count;
end;

{------------------------------------------------------------------------------}
function TLMDExceptionBlock.GetBlocks(AIndex: Integer): TLMDExceptionSubBlock;
begin
  Result := FBlocks[AIndex];
end;

{*************************** class TLMDPasExpression **************************}
{ --------------------------------- public ----------------------------------- }
procedure TLMDExpression.DoEmitRefByteCode(var C: TLMDContext);
begin
  EmitByteCode(C);
end;

{------------------------------------------------------------------------------}
procedure TLMDExpression.Emit(ANamespace: TLMDAbstractNamespace;
  AByteCode: TLMDByteCode);
var
  oldsp:   Integer;
  rsinsck: Boolean;
  ctx:     TLMDContext;
begin
  FillChar(ctx, SizeOf(ctx), 0);
  ctx.Code         := AByteCode;
  ctx.CurNamespace := ANamespace;

  ctx.Code.BeginSourcePos(FSourcePos, oldsp);

  rsinsck := True;
  DoEmitByteCode(ctx, erStack, nil, rsinsck);
  Assert(rsinsck);

  ctx.Code.EndSourcePos(oldsp);
end;

procedure TLMDExpression.EmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel);
var
  oldsp:   Integer;
  rsinsck: Boolean;
begin
  C.Code.BeginSourcePos(FSourcePos, oldsp);

  rsinsck := True;
  DoEmitByteCode(C, AEmitRes, AJmpLabel, rsinsck);

  if rsinsck then
  begin
    case AEmitRes of
      erNoRes:          C.Code.Emit(icPop);
      erStack:          ; // Do nothing.
      erPopJmpIfTrue:   C.Code.Emit(icPopJmpIfTrue, AJmpLabel);
      erPopJmpIfFalse:  C.Code.Emit(icPopJmpIfFalse, AJmpLabel);
    else
      Assert(False);
    end;
  end;

  C.Code.EndSourcePos(oldsp);
end;

procedure TLMDExpression.EmitByteCode(var C: TLMDContext);
begin
  EmitByteCode(C, erStack);
end;

procedure TLMDExpression.EmitRefByteCode(var C: TLMDContext);
var
  oldsp: Integer;
begin
  C.Code.BeginSourcePos(FSourcePos, oldsp);
  DoEmitRefByteCode(C);
  C.Code.EndSourcePos(oldsp);
end;

{**************************** class TLMDPasLiteral ****************************}
{ --------------------------------- public ----------------------------------- }
constructor TLMDLiteral.Create(AValue: OleVariant);
begin
  inherited Create;
  FValue := AValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDLiteral.DoEmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel;
  var AResInStack: Boolean);
var
  defemit: Boolean;
  dt:      PVarData;
begin
  // Here, some optimizations is provided for common cases like:
  //   - if true then
  //   - while true do
  //   - ect.
  // Note that we can't just convert variant FValue to Boolean because
  // of potential conversion exceptions.

  defemit := False;
  dt      := PVarData(@FValue);

  case AEmitRes of
    erNoRes:          ; // No code needed.
    erStack:          defemit := True;
    erPopJmpIfTrue:   begin
                        if (dt.VType = varBoolean) and dt.VBoolean then
                        begin
                          C.Code.Emit(icJump, AJmpLabel);
                          AResInStack := False; // Result already in
                                                // correct place.
                        end
                        else
                          defemit := True;
                      end;
    erPopJmpIfFalse:  begin
                        if (dt.VType = varBoolean) and not dt.VBoolean then
                        begin
                          C.Code.Emit(icJump, AJmpLabel);
                          AResInStack := False; // Result already in
                                                // correct place.
                        end
                        else
                          defemit := True;
                      end;
  else
    Assert(False);
  end;

  if defemit then
  begin
    if (dt.VType = varInteger) and (dt.VInteger = 0) then
      C.Code.Emit(icPush0)
    else if dt.VType = varEmpty then
      C.Code.Emit(icPushUnassigned)
    else
      C.Code.Emit(icPushLiteral, TObject(@FValue));
  end;
end;

{****************************** class TLMDPasNot ******************************}
{ --------------------------------- public ----------------------------------- }
constructor TLMDUnaryExpr.Create(AOperator: TLMDUnaryOp);
begin
  inherited Create;
  FOperator := AOperator;
end;

{------------------------------------------------------------------------------}
destructor TLMDUnaryExpr.Destroy;
begin
  FExpr.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDUnaryExpr.DoEmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel;
  var AResInStack: Boolean);
begin
  case FOperator of
    uopPlus:
    begin
      FExpr.EmitByteCode(C);
      C.Code.Emit(icUnaryPlus);
    end;
    uopMinus:
    begin
      FExpr.EmitByteCode(C);
      C.Code.Emit(icUnaryMinus);
    end;
    uopNot:
    begin
      case AEmitRes of
        erPopJmpIfTrue:   begin
                            FExpr.EmitByteCode(C, erPopJmpIfFalse,
                                               AJmpLabel);
                            AResInStack := False; // Result already in
                                                  // correct place.
                          end;
        erPopJmpIfFalse:  begin
                            FExpr.EmitByteCode(C, erPopJmpIfTrue,
                                               AJmpLabel);
                            AResInStack := False; // Result already in
                                                  // correct place.
                          end;
      else
        FExpr.EmitByteCode(C);
        C.Code.Emit(icUnaryNot);
      end;
    end;
  else
    Assert(False);
  end;
end;

{*************************** class TLMDPassetElement **************************}
{ --------------------------------- public ----------------------------------- }
constructor TLMDSetElement.Create;
begin
  inherited Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDSetElement.Destroy;
begin
  FLeftExpr.Free;
  FRightExpr.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSetElement.EmitByteCode(var C: TLMDContext);
var
  oldsp: Integer;
begin
  C.Code.BeginSourcePos(FSourcePos, oldsp);

  FLeftExpr.EmitByteCode(C);
  if FRightExpr <> nil then
  begin
    FRightExpr.EmitByteCode(C);
    C.Code.Emit(icAddRangeToSet);
  end
  else
    C.Code.Emit(icAddValToSet);

  C.Code.EndSourcePos(oldsp);
end;

{*************************** class TLMDPasStatement ***************************}
{ --------------------------------- public ----------------------------------- }
procedure TLMDStatement.EmitByteCode(var C: TLMDContext);
var
  oldsp: Integer;
begin
  C.Code.BeginSourcePos(FSourcePos, oldsp);
  C.Code.SetNextInstrBreakable;
  DoEmitByteCode(C);
  C.Code.EndSourcePos(oldsp);
end;

procedure TLMDStatement.Emit(ANamespace: TLMDAbstractNamespace;
  AByteCode: TLMDByteCode);
var
  oldsp: Integer;
  ctx:   TLMDContext;
begin
  FillChar(ctx, SizeOf(ctx), 0);
  ctx.Code         := AByteCode;
  ctx.CurNamespace := ANamespace;

  ctx.Code.BeginSourcePos(FSourcePos, oldsp);
  ctx.Code.SetNextInstrBreakable;
  DoEmitByteCode(ctx);
  ctx.Code.EndSourcePos(oldsp);
end;

{*************************** class TLMDPasStmtList ****************************}
{ --------------------------------- public ----------------------------------- }
procedure TLMDStmtList.Add(AItem: TLMDStatement);
begin
  FItems.Add(AItem);
end;

{--------------------------------- private ------------------------------------}
constructor TLMDStmtList.Create;
begin
  Create(True);
end;

{------------------------------------------------------------------------------}
constructor TLMDStmtList.Create(AOwnItems: Boolean);
begin
  inherited Create;

  FItems    := TList.Create;
  FOwnItems := AOwnItems;
end;

destructor TLMDStmtList.Destroy;
var
  i: Integer;
begin
  if FOwnItems then
  begin
    for i := 0 to FItems.Count - 1 do
      TObject(FItems[i]).Free;
  end;
  FItems.Free;

  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDStmtList.EmitByteCode(var C: TLMDContext);
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TLMDStatement(FItems[i]).EmitByteCode(C);
end;

{------------------------------------------------------------------------------}
function TLMDStmtList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{------------------------------------------------------------------------------}
function TLMDStmtList.GetItems(AIndex: Integer): TLMDStatement;
begin
  Result := FItems[AIndex];
end;

{***************************** TLMDPasOperator ********************************}

constructor TLMDBinaryExpr.Create(AOperator: TLMDBinaryOp);
begin
  inherited Create;
  FOperator := AOperator;
end;

{------------------------------------------------------------------------------}
destructor TLMDBinaryExpr.Destroy;
begin
  FLeftExpr.Free;
  FRightExpr.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDBinaryExpr.DoEmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel;
  var AResInStack: Boolean);
const
  OR_LEFTEXP_RES: array[TLMDExprEmitRes] of TLMDExprEmitRes = (
    erPopJmpIfTrue,   // erNoRes
    erStack,          // erStack (never used)
    erPopJmpIfTrue,   // erPopJmpIfTrue
    erPopJmpIfTrue    // erPopJmpIfFalse
  );
  AND_LEFTEXP_RES: array[TLMDExprEmitRes] of TLMDExprEmitRes = (
    erPopJmpIfFalse,  // erNoRes
    erStack,          // erStack (never used)
    erPopJmpIfFalse,  // erPopJmpIfTrue
    erPopJmpIfFalse   // erPopJmpIfFalse
  );
var
  L: TLMDLabel;
begin
  if not (FOperator in [bopOr, bopAnd]) then
  begin
    FLeftExpr.EmitByteCode(C);
    FRightExpr.EmitByteCode(C);
  end;

  case FOperator of
    bopGreater     : C.Code.Emit(icGreater);
    bopGreaterEqual: C.Code.Emit(icGreaterEqual);
    bopEqual       : begin
                       if AEmitRes = erPopJmpIfTrue then
                       begin
                         C.Code.Emit(icPopJmpIfEqual, AJmpLabel);
                         AResInStack := False; // Result already in
                                               // correct place.
                       end
                       else
                         C.Code.Emit(icEqual);
                     end;
    bopLess        : C.Code.Emit(icLess);
    bopLessEqual   : C.Code.Emit(icLessEqual);
    bopNotEqual    : begin
                       if AEmitRes = erPopJmpIfTrue then
                       begin
                         C.Code.Emit(icPopJmpIfNotEqual, AJmpLabel);
                         AResInStack := False; // Result already in
                                               // correct place.
                       end
                       else
                         C.Code.Emit(icNotEqual);
                     end;
    bopIn          : C.Code.Emit(icIn);
    bopIs          : C.Code.Emit(icIs);
    bopPlus        : C.Code.Emit(icPlus);
    bopMinus       : C.Code.Emit(icMinus);
    bopOr          : begin
                       if AEmitRes = erStack then
                       begin
                         L := C.Code.CreateLabel;
                         FLeftExpr.EmitByteCode(C);
                         C.Code.Emit(icJmpIfTrue, L); // No pop.
                         C.Code.Emit(icPop);
                       end
                       else
                       begin
                         L := AJmpLabel;
                         if AEmitRes <> erPopJmpIfTrue then
                           L := C.Code.CreateLabel;
                         FLeftExpr.EmitByteCode(C, OR_LEFTEXP_RES[
                                                AEmitRes], L);
                       end;

                       FRightExpr.EmitByteCode(C, AEmitRes, AJmpLabel);
                       if L <> AJmpLabel then
                         C.Code.BindLabel(L);

                       AResInStack := False; // Result already in
                                             // correct place.
                     end;
    bopXor         : C.Code.Emit(icXor);
    bopMultiply    : C.Code.Emit(icMultiply);
    bopDivide      : C.Code.Emit(icDivide);
    bopDiv         : C.Code.Emit(icIntDiv);
    bopMod         : C.Code.Emit(icMod);
    bopAnd         : begin
                       if AEmitRes = erStack then
                       begin
                         L := C.Code.CreateLabel;
                         FLeftExpr.EmitByteCode(C);
                         C.Code.Emit(icJmpIfFalse, L); // No pop.
                         C.Code.Emit(icPop);
                       end
                       else
                       begin
                         L := AJmpLabel;
                         if AEmitRes <> erPopJmpIfFalse then
                           L := C.Code.CreateLabel;
                         FLeftExpr.EmitByteCode(C, AND_LEFTEXP_RES[
                                                AEmitRes], L);
                       end;

                       FRightExpr.EmitByteCode(C, AEmitRes, AJmpLabel);
                       if L <> AJmpLabel then
                         C.Code.BindLabel(L);

                       AResInStack := False; // Result already in
                                             // correct place.
                     end;
    bopShl         : C.Code.Emit(icShl);
    bopShr         : C.Code.Emit(icShr);
  else
    Assert(False);
  end;
end;

{*************************** TLMDPasExpressionStmt ****************************}
{------------------------------------------------------------------------------}
constructor TLMDExpressionStmt.Create;
begin
  inherited Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDExpressionStmt.Destroy;
begin
  FExpr.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDExpressionStmt.DoEmitByteCode(var C: TLMDContext);
begin
  FExpr.EmitByteCode(C, erNoRes);
end;

{****************************** TLMDPasCompound *******************************}
{------------------------------------------------------------------------------}
constructor TLMDCompound.Create;
begin
  inherited Create;
  FStmtList := TLMDStmtList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDCompound.Destroy;
begin
  FStmtList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCompound.DoEmitByteCode(var C: TLMDContext);
begin
  FStmtList.EmitByteCode(C);
end;

{************************ TLMDPasDesignatorExpr *******************************}
{------------------------------------------------------------------------------}
procedure TLMDDesignatorExpr.AddItem(AItem: TLMDDesignatorItem);
begin
  FItems.Add(AItem);
end;

{------------------------------------------------------------------------------}
constructor TLMDDesignatorExpr.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

constructor TLMDDesignatorExpr.CreateSimple(AName: Integer;
  const AStrName: WideString; ASourcePos: Integer);
begin
  Create;

  FSourcePos := ASourcePos;
  AddItem(TLMDDesignatorItem.Create);

  Items[0].FName      := AName;
  Items[0].FStrName   := AStrName;
  Items[0].FSourcePos := ASourcePos;
end;

{------------------------------------------------------------------------------}
destructor TLMDDesignatorExpr.Destroy;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TObject(FItems[i]).Free;
  FItems.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDDesignatorExpr.DoEmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel; var AResInStack: Boolean);
begin
  if AEmitRes = erNoRes then
    Items[ItemCount - 1].FIsResultUsed := False;
  InternalEmit(C, False);
end;

{------------------------------------------------------------------------------}
procedure TLMDDesignatorExpr.DoEmitRefByteCode(var C: TLMDContext);
begin
  InternalEmit(C, True);
end;

{----------------------------- private ----------------------------------------}
function TLMDDesignatorExpr.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

{------------------------------------------------------------------------------}
function TLMDDesignatorExpr.GetItems(AIndex: Integer): TLMDDesignatorItem;
begin
  Result := TLMDDesignatorItem(FItems[AIndex]);
end;

function TLMDDesignatorExpr.GetLastItem: TLMDDesignatorItem;
begin
  Result := TLMDDesignatorItem(FItems[FItems.Count - 1]);
end;

procedure TLMDDesignatorExpr.InternalEmit(var C: TLMDContext; ANeedRef: Boolean;
  AGetInstrProc: TLMDPasGetCallInstr; AEmitValueProc: TLMDPasEmitValue);
const
  MBR_CALLS:    array[Boolean] of TLMDInstrCode = (icUnnamedCall, icMemberCall);
  MBR_REFCALLS: array[Boolean] of TLMDInstrCode = (icUnnamedCallRef, icMemberCallRef);
var
  i:          Integer;
  needSlot:   Boolean;
  slots:      Integer;
  icode:      TLMDInstrCode;
  callInstrs: array of TLMDInstr;
begin
  slots := FItems.Count;
  SetLength(callInstrs, FItems.Count);

  for i := 0 to FItems.Count - 1 do
  begin
    needSlot := True;

    if not Assigned(AGetInstrProc) or
       not AGetInstrProc(C, Items[i], callInstrs[i], needSlot) then
    begin
      if ANeedRef and (i = FItems.Count - 1) then // Ref needed.
      begin
        if i = 0 then
          icode := icGlobCallRef
        else
          icode := MBR_REFCALLS[Items[i].IsNamed];
      end
      else
      begin
        if i = 0 then
          icode := icGlobCall
        else
          icode := MBR_CALLS[Items[i].IsNamed];
      end;

      callInstrs[i] := OptimizeCallInstr(C, Items[i], icode, (i > 0), False,
                                         needSlot);
    end;

    if not needSlot then
      Dec(slots);
  end;

  if slots > 0 then
    C.Code.Emit(icPush, TObject(slots)); // Slots for results.

  for i := 0 to FItems.Count - 1 do
  begin
    Items[i].EmitArgs(C);
    if Assigned(AEmitValueProc) then
      AEmitValueProc(C, Items[i]);
    C.Code.Emit(callInstrs[i].Code, callInstrs[i].Data);
  end;
end;

{******************************* TLMDPasSetExpr *******************************}
{------------------------------------------------------------------------------}
procedure TLMDPasSetExpr.AddSetElement(AElem: TLMDSetElement);
begin
  FSetElements.Add(AElem);
end;

{------------------------------------------------------------------------------}
constructor TLMDPasSetExpr.Create;
begin
  inherited Create;
  FSetElements := TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDPasSetExpr.Destroy;
var
  i: Integer;
begin
  for i := 0 to FSetElements.Count - 1 do
    TObject(FSetElements[i]).Free;
  FSetElements.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDPasSetExpr.DoEmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel;
  var AResInStack: Boolean);
var
  i:Integer;
begin
  C.Code.Emit(icPush0);
  for i := 0 to FSetElements.Count - 1 do
    TLMDSetElement(FSetElements[i]).EmitByteCode(C);
end;

{----------------------------- private ----------------------------------------}
function TLMDPasSetExpr.GetSetElementCount: Integer;
begin
  Result := FSetElements.Count;
end;

{------------------------------------------------------------------------------}
function TLMDPasSetExpr.GetSetElements(
  AIndex: Integer): TLMDSetElement;
begin
  Result := FSetElements[AIndex];
end;

{************************ TLMDPasExceptionSubBlock ****************************}
{------------------------------------------------------------------------------}
constructor TLMDExceptionSubBlock.Create(AName: Integer;
  const AStrName: WideString);
begin
  inherited Create(AName);

  FStrName   := AStrName;
  FNamespace := nil;
end;

function TLMDExceptionSubBlock.CreateNS(AParent: TLMDAbstractNamespace;
  AVarIndex: Integer): TLMDAbstractNamespace;
begin
  Assert(FNamespace = nil); // Need a list of namespaces to
                            // properly free them.
  FNamespace := TLMDExcSubBlockNamespace.Create(AParent, Name, StrName,
                                                AVarIndex);
  Result     := FNamespace;
end;

destructor TLMDExceptionSubBlock.Destroy;
begin
  FExpr.Free;
  FStmt.Free;
  FNamespace.Free;
  inherited;
end;

{************************** TLMDPasLocalVarDecl *******************************}
{------------------------------------------------------------------------------}
constructor TLMDLocalVarDecl.Create(AName: Integer;
  const AStrName: WideString);
begin
  inherited Create(ltVar, AName, AStrName);
end;

{------------------------------------------------------------------------------}
destructor TLMDLocalVarDecl.Destroy;
begin
  FExpr.Free;
  inherited;
end;

{************************** TLMDPasLocalConstDecl *****************************}
{------------------------------------------------------------------------------}
constructor TLMDLocalConstDecl.Create(AName: Integer;
  const AStrName: WideString);
begin
  inherited Create(ltConst, AName, AStrName);
end;

{------------------------------------------------------------------------------}
destructor TLMDLocalConstDecl.Destroy;
begin
  FExpr.Free;
  inherited;
end;

{************************** TLMDPasUsedUnit ***********************************}
{------------------------------------------------------------------------------}
constructor TLMDUsedUnit.Create(AName: Integer);
begin
  inherited Create(AName);
end;

{************************** TLMDPasLocalResultDecl ****************************}
{------------------------------------------------------------------------------}
constructor TLMDLocalResultDecl.Create(AName: Integer;
  const AStrName: WideString);
begin
  inherited Create(ltResult, AName, AStrName);
end;

{*************************** TLMDProcLocalNamespace ***************************}
{------------------------------------------------------------------------------}
function TLMDProcLocalNamespace.CompileTimeFind(
  AName: Integer): TLMDNameSearchRes;
var
  itm: TLMDProcLocal;
begin
  itm := TLMDProcLocal(FProcedure.FLocalMap.Find(AName));

  if itm <> nil then
  begin
    case itm.LocalType of
      ltVar:    begin
                  Result.ObjKind       := srLocalVar;
                  Result.LocalVarIndex := TLMDLocalVarDecl(itm).Index;
                end;
      ltConst:  begin
                  Result.ObjKind    := srLocalConst;
                  Result.LocalConst := @TLMDLocalConstDecl(itm).Value;
                end;
      ltResult: Result.ObjKind := srResult;
      ltParam:  begin
                  Result.ObjKind   := srParam;
                  Result.ParamInfo := TLMDParamDecl(itm).ParamInfo;
                end;
    end;

    Exit;
  end;

  if Parent <> nil then
  begin
    Result := Parent.CompileTimeFind(AName);
    Exit;
  end;

  Result := inherited CompileTimeFind(AName);
end;

constructor TLMDProcLocalNamespace.Create(AProcedure: TLMDProcedureDecl;
  AParent: TLMDAbstractNamespace);
begin
  inherited Create(AParent);
  FProcedure := AProcedure;
end;

{------------------------------------------------------------------------------}
procedure TLMDProcLocalNamespace.EnumDebugVars(
  ALocalsOnly: Boolean; AProc: TLMDNamespaceEnumVarsProc);
var
  i:    Integer;
  sres: TLMDNameSearchRes;
begin
  for i := 0 to FProcedure.ParamCount - 1 do
  begin
    sres.ObjKind   := srParam;
    sres.ParamInfo := FProcedure.Params[i].ParamInfo;
    AProc(FProcedure.Params[i].StrName, sres);
  end;

  for i := 0 to FProcedure.LocalConstCount - 1 do
  begin
    sres.ObjKind     := srLocalConst;
    sres.NamedObject := FProcedure.LocalConsts[i];
    AProc(FProcedure.LocalConsts[i].StrName, sres);
  end;

  for i := 0 to FProcedure.LocalVarCount - 1 do
  begin
    sres.ObjKind       := srLocalVar;
    sres.LocalVarIndex := FProcedure.LocalVars[i].Index;
    AProc(FProcedure.LocalVars[i].StrName, sres);
  end;

  if FProcedure.ProcKind = pkFunction then
  begin
    sres.ObjKind     := srResult;
    sres.NamedObject := FProcedure.LocalResult;
    AProc(FProcedure.LocalResult.StrName, sres);
  end;

  if Parent <> nil then
    Parent.EnumDebugVars(ALocalsOnly, AProc);
end;

function TLMDProcLocalNamespace.Find(AThread: Pointer; AName: Integer;
  AStrName: PWideString): TLMDNameSearchRes;
var
  itm: TLMDProcLocal;
begin
  itm := TLMDProcLocal(FProcedure.FLocalMap.Find(AName));

  if itm <> nil then
  begin
    case itm.LocalType of
      ltVar:    begin
                  Result.ObjKind       := srLocalVar;
                  Result.LocalVarIndex := TLMDLocalVarDecl(itm).Index;
                end;
      ltConst:  begin
                  Result.ObjKind    := srLocalConst;
                  Result.LocalConst := @TLMDLocalConstDecl(itm).Value;
                end;
      ltResult: Result.ObjKind := srResult;
      ltParam:  begin
                  Result.ObjKind   := srParam;
                  Result.ParamInfo := TLMDParamDecl(itm).ParamInfo;
                end;
    end;

    Exit;
  end;

  Result := Parent.Find(AThread, AName, AStrName);
end;

{************************** TLMDExcSubBlockNamespace **************************}
{------------------------------------------------------------------------------}
function TLMDExcSubBlockNamespace.CompileTimeFind(
  AName: Integer): TLMDNameSearchRes;
begin
  if AName = FVarName then
  begin
    Result.ObjKind       := srLocalVar;
    Result.LocalVarIndex := FVarIndex;
    Exit;
  end;

  if Parent <> nil then
  begin
    Result := Parent.CompileTimeFind(AName);
    Exit;
  end;

  Result := inherited CompileTimeFind(AName);
end;

{------------------------------------------------------------------------------}
constructor TLMDExcSubBlockNamespace.Create(AParent: TLMDAbstractNamespace;
  AVarName: Integer; const AVarSName: WideString; AVarIndex: Integer);
begin
  inherited Create(AParent);
  FVarName  := AVarName;
  FVarSName := AVarSName;
  FVarIndex := AVarIndex;
end;

procedure TLMDExcSubBlockNamespace.EnumDebugVars(
  ALocalsOnly: Boolean; AProc: TLMDNamespaceEnumVarsProc);
var
  sres: TLMDNameSearchRes;
begin
  if Parent <> nil then
    Parent.EnumDebugVars(ALocalsOnly, AProc);

  sres.ObjKind       := srLocalVar;
  sres.LocalVarIndex := FVarIndex;
  AProc(FVarSName, sres);
end;

{------------------------------------------------------------------------------}
function TLMDExcSubBlockNamespace.Find(AThread: Pointer; AName: Integer;
  AStrName: PWideString): TLMDNameSearchRes;
begin
  if AName = FVarName then
  begin
    Result.ObjKind       := srLocalVar;
    Result.LocalVarIndex := FVarIndex;
    Exit;
  end;

  Result := Parent.Find(AThread, AName, AStrName);
end;

{******************************** TLMDArrayExpr *******************************}
{------------------------------------------------------------------------------}
procedure TLMDArrayExpr.AddArrayDim(AElem: TLMDArrayDim);
begin
  FArrayDims.Add(AElem)
end;

{------------------------------------------------------------------------------}
constructor TLMDArrayExpr.Create;
begin
  inherited Create;
  FArrayDims   := TList.Create;
  FElemVarType := varVariant;
end;

{------------------------------------------------------------------------------}
destructor TLMDArrayExpr.Destroy;
var
  i: Integer;
begin
  for i := 0 to FArrayDims.Count - 1 do
    TLMDArrayDim(FArrayDims[i]).Free;
  FArrayDims.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDArrayExpr.DoEmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel;
  var AResInStack: Boolean);
var
  i: Integer;
begin
  for i := 0 to FArrayDims.Count - 1 do
    TLMDArrayDim(FArrayDims[i]).EmitByteCode(C);

  C.Code.Emit(icArrayCreate, C.Code.AddArray(FArrayDims.Count,
                                             FElemVarType));
end;

{---------------------------------- private -----------------------------------}
function TLMDArrayExpr.GetArrayDimCount: Integer;
begin
  Result := FArrayDims.Count;
end;

{------------------------------------------------------------------------------}
function TLMDArrayExpr.GetArrayDims(AIndex: Integer): TLMDArrayDim;
begin
  Result := FArrayDims[AIndex];
end;

{******************************** TLMDArrayDim ********************************}
{------------------------------------------------------------------------------}
destructor TLMDArrayDim.Destroy;
begin
  FLeftExpr.Free;
  FRightExpr.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDArrayDim.EmitByteCode(var C: TLMDContext);
begin
  FLeftExpr.EmitByteCode(C);
  FRightExpr.EmitByteCode(C);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDProcLocal.Create(ALocalType: TLMDProcLocalType;
  AName: Integer; const AStrName: WideString);
begin
  inherited Create(AName);
  FStrName   := AStrName;
  FLocalType := ALocalType;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDesignatorExpr.OptimizeCallInstr(var C: TLMDContext;
  AItem: TLMDDesignatorItem; ACallInstr: TLMDInstrCode; AHasObject,
  AHasValue: Boolean; out ANeedSlot: Boolean): TLMDInstr;
const
  GlobCallOptmz: array[TLMDProcLocalType] of TLMDInstrCode = (
    icPushLocalVar, icPushLocalConst, icPushResult, icPushArg
  );
  GlobCallRefOptmz: array[TLMDProcLocalType] of TLMDInstrCode = (
    icPushLocalVarRef, icPushLocalConst, icPushResultRef, icPushArgRef
  );
  AsgnGlobCallOptmz: array[TLMDProcLocalType] of TLMDInstrCode = (
    icAssignLocalVar, TLMDInstrCode(-1), icAssignResult, icAssignArg
  );

  function _MakeData(SRes: TLMDNameSearchRes): TObject;
  begin
    Result := nil;

    case SRes.ObjKind of
      srLocalVar:     Result := TObject(SRes.LocalVarIndex);
      srLocalConst:   Result := TObject(SRes.LocalConst);
      srParam:        Result := TObject(SRes.ParamInfo);
      srResult:       ; // Do nothing.
    else
      Assert(False);
    end;
  end;

var
  sres: TLMDNameSearchRes;
  ltp:  TLMDProcLocalType;
  call: TLMDCall;
begin
  if (AItem.BracketType = bkNon) and (C.CurNamespace <> nil) then
  begin
    sres := C.CurNamespace.CompileTimeFind(AItem.Name);

    case sres.ObjKind of
      srLocalVar: ltp := ltVar;
      srResult:   ltp := ltResult;
      srParam:    ltp := ltParam;
    else
      ltp := TLMDProcLocalType(-1);
    end;

    if ltp <> TLMDProcLocalType(-1) then
    begin
      case ACallInstr of
        icGlobCall:
        begin
          ANeedSlot   := False;
          Result.Code := GlobCallOptmz[ltp];
          Result.Data := _MakeData(sres);
          Exit;
        end;
        icGlobCallRef:
        begin
          ANeedSlot   := False;
          Result.Code := GlobCallRefOptmz[ltp];
          Result.Data := _MakeData(sres);
          Exit;
        end;
        icAssignGlobCall:
        begin
          if sres.ObjKind in [srLocalVar, srResult, srParam] then
          begin
            ANeedSlot   := False;
            Result.Code := AsgnGlobCallOptmz[ltp];
            Result.Data := _MakeData(sres);
            Exit;
          end;
        end;
      end;
    end;
  end;

  call               := C.Code.AddCall(AItem.Name, AItem.StrName,
                                       AItem.BracketType, AItem.ArgCount,
                                       AHasObject, AHasValue,
                                       AItem.IsResultUsed);
  call.ExitLabel     := C.CurEBC.ExitL;
  call.BreakLabel    := C.CurEBC.BreakL;
  call.ContinueLabel := C.CurEBC.ContinueL;

  ANeedSlot   := True;
  Result.Code := ACallInstr;
  Result.Data := call;
end;

{ TLMDPasEmptyStmt }

procedure TLMDPasEmptyStmt.DoEmitByteCode(var C: TLMDContext);
begin
  C.Code.ManualResetNextInstrBreakable;
end;

{ TLMDEventMakeExpr }

constructor TLMDEventMakeExpr.Create(AProcName: Integer);
begin
  inherited Create;
  FProcName := AProcName;
end;

procedure TLMDEventMakeExpr.DoEmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel;
  var AResInStack: Boolean);
begin
  C.Code.Emit(icEventHandlerMake, TObject(@FStrProcName));
end;

{------------------------------------------------------------------------------}
function TLMDProcedureDecl.GetLocalVarCount: Integer;
begin
  Result := FLocalVars.Count;
end;

{ TLMDDesignatorItem }

procedure TLMDDesignatorItem.AddArg(AArgs: TLMDExpression);
begin
  FArgs.Add(AArgs);
end;

constructor TLMDDesignatorItem.Create(AName: Integer;
  const AStrName: WideString);
begin
  inherited Create;

  FName         := AName;
  FStrName      := AStrName;
  FArgs         := TList.Create;
  FIsResultUsed := True;
end;

constructor TLMDDesignatorItem.Create;
begin
  inherited Create;

  FArgs         := TList.Create;
  FIsResultUsed := True;
end;

destructor TLMDDesignatorItem.Destroy;
var
  i: Integer;
begin
  for i := 0 to FArgs.Count - 1 do
    TObject(FArgs[i]).Free;
  FArgs.Free;

  inherited;
end;

procedure TLMDDesignatorItem.EmitArgs(var C: TLMDContext);
var
  i: Integer;
begin
  for i := 0 to FArgs.Count - 1 do
    TLMDExpression(FArgs[i]).EmitRefByteCode(C);
end;

function TLMDDesignatorItem.GetArgCount: Integer;
begin
  Result := FArgs.Count;
end;

function TLMDDesignatorItem.GetArgs(AIndex: Integer): TLMDExpression;
begin
  Result := FArgs[AIndex];
end;

function TLMDDesignatorItem.GetIsNamed: Boolean;
begin
  Result := (FStrName <> '');
end;

{ TLMDGlobalVarIniter }

constructor TLMDGlobalVarIniter.Create(AVar: TLMDVarObject;
  AIniter: TLMDExpression);
begin
  inherited Create;
  FVar    := AVar;
  FIniter := AIniter;
end;

destructor TLMDGlobalVarIniter.Destroy;
begin
  FIniter.Free;
  inherited;
end;

procedure TLMDGlobalVarIniter.Emit(ANamespace: TLMDAbstractNamespace;
  AByteCode: TLMDByteCode);
var
  oldsp: Integer;
  ctx:   TLMDContext;
begin
  FillChar(ctx, SizeOf(ctx), 0);
  ctx.Code         := AByteCode;
  ctx.CurNamespace := ANamespace;

  ctx.Code.BeginSourcePos(FIniter.SourcePos, oldsp);

  ctx.Code.SetNextInstrBreakable;
  FIniter.EmitByteCode(ctx);
  ctx.Code.Emit(icAssignGlobalVar, FVar);

  ctx.Code.EndSourcePos(oldsp);
end;

{ TLMDGlobalConstIniter }

constructor TLMDGlobalConstIniter.Create(AConst: TLMDConstObject;
  AIniter: TLMDExpression);
begin
  inherited Create;
  FConst  := AConst;
  FIniter := AIniter;
end;

procedure TLMDGlobalConstIniter.Emit(ANamespace: TLMDAbstractNamespace;
  AByteCode: TLMDByteCode);
var
  oldsp: Integer;
  ctx:   TLMDContext;
begin
  FillChar(ctx, SizeOf(ctx), 0);
  ctx.Code         := AByteCode;
  ctx.CurNamespace := ANamespace;

  ctx.Code.BeginSourcePos(FIniter.SourcePos, oldsp);

  ctx.Code.SetNextInstrBreakable;
  FIniter.EmitByteCode(ctx);
  ctx.Code.Emit(icAssignGlobalConst, FConst);

  ctx.Code.EndSourcePos(oldsp);
end;

{ TLMDPasLanguage }

procedure TLMDPasLanguage.AddIntrinsics(AProc: TLMDAddIntrinsicProc);

  procedure _Add(const AName: WideString; AClass: TPasIntrinsicClass;
                 AKind: TPasIntrinsicKind; AParamCount: Integer = 0);
  var
    idx: Integer;
  begin
    idx := GlobNameTable.GetNameIndex(AName);
    AProc(AClass.Create(idx, AName, AKind, AParamCount));
  end;

begin
  AProc(TLMDExitObject.Create(
    GlobNameTable.GetNameIndex('Exit'), 'Exit'));
  AProc(TLMDBreakObject.Create(
    GlobNameTable.GetNameIndex('Break'), 'Break'));
  AProc(TLMDContinueObject.Create(
    GlobNameTable.GetNameIndex('Continue'), 'Continue'));

  _Add('Null', TNullObject, bokConstant);
  _Add('Unassigned', TUnassignedObject, bokConstant);

  _Add('Include', TInclude, bokProcedure, 2);
  _Add('Exclude', TExclude, bokProcedure, 2);
  _Add('Beep', TBeep, bokProcedure, 0);
  _Add('ArcTan', TArcTan, bokFunction, 1);
  _Add('Cos', TCos, bokFunction, 1);
  _Add('Dec', TDec, bokFunction, -1);
  _Add('Sin', TSin, bokFunction, 1);
  _Add('LowerCase', TLowerCase, bokFunction, 1);
  _Add('High', THigh, bokFunction, -1);
  _Add('Low', TLow, bokFunction, -1);
  _Add('Ln', TLn, bokFunction, 1);
  _Add('AnsiCompareStr', TAnsiCompareStr, bokFunction, 2);
  _Add('AnsiCompareText', TAnsiCompareText, bokFunction, 2);
  _Add('AnsiLowerCase', TAnsiLowerCase, bokFunction, 1);
  _Add('AnsiUpperCase', TAnsiUpperCase, bokFunction, 1);
  _Add('Abs', TAbs, bokFunction, 1);
  _Add('CompareStr', TCompareStr, bokFunction, 2);
  _Add('CompareText', TCompareText, bokFunction, 2);
  _Add('Date', TDate, bokConstant);
  _Add('DateTimeToStr', TDateTimeToStr, bokFunction, 1);
  _Add('DateToStr', TDateToStr, bokFunction, 1);
  _Add('DayOfWeek', TDayOfWeek, bokFunction, 1);
  _Add('DecodeDate', TDecodeDate, bokProcedure, 4);
  _Add('Exp', TExp, bokFunction, 1);
  _Add('FloatToStr', TFloatToStr, bokFunction, 1);
  _Add('Frac', TFrac, bokFunction, 1);
  _Add('Int', TInt, bokFunction, 1);
  _Add('IntToHex', TIntToHex, bokFunction, 2);
  _Add('IntToStr', TIntToStr, bokFunction, 1);
  _Add('IsLeapYear', TIsLeapYear, bokFunction, 1);
  _Add('IsValidIdent', TIsValidIdent, bokFunction, 1);
  _Add('True', TTrue, bokConstant);
  _Add('False', TFalse, bokConstant);
  _Add('Length', TLength, bokFunction, -1);
  _Add('Now', TNow, bokFunction, 0);
  _Add('Odd', TOdd, bokFunction, 1);
  _Add('Pos', TPos, bokFunction, 2);
  _Add('Random', TRandom, bokFunction, -1);
  _Add('Round', TRound, bokFunction, 1);
  _Add('Sqr', TSqr, bokFunction, 1);
  _Add('Sqrt', TSqrt, bokFunction, 1);
  _Add('StrToDate', TStrToDate, bokFunction, 1);
  _Add('StrToDateTime', TStrToDateTime, bokFunction, 1);
  _Add('StrToFloat', TStrToFloat, bokFunction, 1);
  _Add('StrToInt', TStrToInt, bokFunction, 1);
  _Add('StrToIntDef', TStrToIntDef, bokFunction, 2);
  _Add('Time', TTime, bokFunction, 0);
  _Add('TimeToStr', TTimeToStr, bokFunction, 1);
  _Add('StrToTime', TStrToTime, bokFunction, 1);
  _Add('Trim', TTrim, bokFunction, 1);
  _Add('TrimLeft', TTrimLeft, bokFunction, 1);
  _Add('TrimRight', TTrimRight, bokFunction, 1);
  _Add('Trunc', TTrunc, bokFunction, 1);
  _Add('UpperCase', TUpperCase, bokFunction, 1);
  _Add('VarIsNull', TVarIsNull, bokFunction, 1);
  _Add('VarToStr', TVarToStr, bokFunction, 1);
  _Add('Assigned', TAssigned, bokFunction, 1);
  _Add('ShowMessage', TShowMessage, bokProcedure, 1);
  _Add('Insert', TInsert, bokProcedure, 3);
  _Add('IncMonth', TIncMonth, bokFunction, -1);
  _Add('Inc', TInc, bokProcedure, -1);
  _Add('Chr', TChr, bokFunction, 1);
  _Add('Copy', TCopy, bokFunction, 3);
  _Add('Delete', TDelete, bokProcedure, 3);
  _Add('CreateOleObject', TCreateOleObject, bokFunction, 1);
  _Add('GetActiveOleObject', TGetActiveOleObject, bokFunction, 1);
  _Add('InputQuery', TInputQuery, bokFunction, 3);
  _Add('DecodeTime', TDecodeTime, bokProcedure, 5);
  _Add('EncodeDate', TEncodeDate, bokFunction, 3);
  _Add('EncodeTime', TEncodeTime, bokFunction, 4);
  _Add('Format', TFormat, bokFunction, -1);
  _Add('FormatFloat', TFormatFloat, bokFunction, 2);
  _Add('FormatDateTime', TFormatDateTime, bokFunction, 2);
  _Add('Ord', TOrd, bokFunction, 1);
end;

function TLMDPasLanguage.CreateParser(
  ACbs: ILMDParserCallbacks): ILMDParserBase;
begin
  Result := TLMDPasParser.Create(ACbs);
end;

function TLMDPasLanguage.DebugStrLiteral(const S: WideString): WideString;
var
  i: Integer;
begin
  Result := S;
  for i := Length(Result) downto 1 do
    if Result[i] = '''' then Insert('''', Result, i);
  Result := '''' + Result + '''';
end;

function TLMDPasLanguage.DebugEmpty: WideString;
begin
  Result := 'Unassigned';
end;

function TLMDPasLanguage.DebugNothing: WideString;
begin
  Result := 'nil';
end;

function TLMDPasLanguage.DebugNull: WideString;
begin
  Result := 'Null';
end;

{******************************* TPasIntrinsic ********************************}
{------------------------------------------------------------------------------}
constructor TPasIntrinsic.Create(const AName: Integer;
  const AStrName: WideString; AKind: TPasIntrinsicKind;
  AArgsCount: Integer);
begin
  inherited Create(AName, AStrName);

  FKind      := AKind;
  FArgsCount := AArgsCount;
end;

{------------------------------------------------------------------------------}
procedure TPasIntrinsic.Execute(AVM: TLMDVMBase; ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
type
  TState = (sOk, sPrmChck, sTpMis, sNotUsed1, sNotUsed2);
const
  STATES: array[TPasIntrinsicKind, TLMDBracketType,
                Boolean, Boolean] of TState =
  (
    { bokProcedure }
    (
      ((sPrmChck,   sOk),       (sTpMis,    sTpMis)),       // bkNon
      ((sTpMis,     sTpMis),    (sTpMis,    sTpMis)),       // bkVbRound
      ((sPrmChck,   sOk),       (sTpMis,    sTpMis)),       // bkRound
      ((sTpMis,     sTpMis),    (sTpMis,    sTpMis))        // bkBlock
    ),
    { bokFunction }
    (
      ((sPrmChck,   sOk),       (sPrmChck,  sOk)),          // bkNon
      ((sTpMis,     sTpMis),    (sTpMis,    sTpMis)),       // bkVbRound
      ((sPrmChck,   sOk),       (sPrmChck,  sOk)),          // bkRound
      ((sTpMis,     sTpMis),    (sTpMis,    sTpMis))        // bkBlock
    ),
    { bokConstant }
    (
      ((sOk,        sOk),       (sOk,       sOk)),          // bkNon
      ((sTpMis,     sTpMis),    (sTpMis,    sTpMis)),       // bkVbRound
      ((sTpMis,     sTpMis),    (sTpMis,    sTpMis)),       // bkRound
      ((sTpMis,     sTpMis),    (sTpMis,    sTpMis))        // bkBlock
    )
  );
begin
  case STATES[FKind, ACall.BracketType, Boolean(ACall.ResMask and 1),
              (FArgsCount = -1)] of
    sOk:
      ; // Do nothing.
    sPrmChck:
    begin
      if FArgsCount <> ACall.ArgCount then
        ELMDVMRuntime.RaiseError(retInvalidParamCount);
    end;
    sTpMis:
      ELMDVMRuntime.RaiseError(retTypeMismatch);
    sNotUsed1: Exit; // Prevent Delphi compiler from
    sNotUsed2: Exit; // transforming case to ifs.
  end;

  DoExecute(ACall, AArgs, AResult);
end;

{******************************** TNullObject *********************************}
{------------------------------------------------------------------------------}
procedure TNullObject.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType := varNull;
  end;
end;

{***************************** TUnassignedObject ******************************}
{------------------------------------------------------------------------------}
procedure TUnassignedObject.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType := varEmpty;
  end;
end;

{********************************** TBeep *************************************}
{------------------------------------------------------------------------------}
procedure TBeep.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  Beep;
end;

{********************************* TArcTan ************************************}
{------------------------------------------------------------------------------}
procedure TArcTan.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := ArcTan(AArgs[0]);
end;

{********************************** TCos **************************************}
{------------------------------------------------------------------------------}
procedure TCos.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Cos(AArgs[0]);
end;

{*********************************** TDec *************************************}
{------------------------------------------------------------------------------}
procedure TDec.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  res:   TVarData;
  v, by: POleVariant;
begin
  if ACall.ArgCount = 1 then
    by := @OleOne
  else if ACall.ArgCount = 2 then
    by := @AArgs[1]
  else
  begin
    by := nil; // Initialize.
    ELMDVMRuntime.RaiseError(retInvalidParamCount);
  end;

  v := @AArgs[0];
  if PVarData(v).VType = (varByRef or varVariant) then
  begin
    v         := VarResolveRefNoCheck(v^);
    res.VType := 0;

    VarBinaryOp(v^, by^, OleVariant(res), opSubtract);
    VarMoveData(v^, OleVariant(res));
  end;
end;

{*********************************** TInc *************************************}
{------------------------------------------------------------------------------}
procedure TInc.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  res:   TVarData;
  v, by: POleVariant;
begin
  if ACall.ArgCount = 1 then
    by := @OleOne
  else if ACall.ArgCount = 2 then
    by := @AArgs[1]
  else
  begin
    by := nil; // Initialize.
    ELMDVMRuntime.RaiseError(retInvalidParamCount);
  end;

  v := @AArgs[0];
  if PVarData(v).VType = (varByRef or varVariant) then
  begin
    v         := VarResolveRefNoCheck(v^);
    res.VType := 0;

    VarBinaryOp(v^, by^, OleVariant(res), opAdd);
    VarMoveData(v^, OleVariant(res));
  end;
end;

{******************************** TSin *************************************}
{------------------------------------------------------------------------------}
procedure TSin.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Sin(AArgs[0]);
end;

{****************************** TLowerCase *********************************}
{------------------------------------------------------------------------------}
procedure TLowerCase.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := LowerCase(AArgs[0]);
end;

{********************************* TLn *************************************}
{------------------------------------------------------------------------------}
procedure TLn.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Ln(AArgs[0]);
end;

{**************************** TAnsiCompareStr ******************************}
{------------------------------------------------------------------------------}
procedure TAnsiCompareStr.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := AnsiCompareStr(AArgs[0], AArgs[1]);
end;

{*************************** TAnsiCompareText ******************************}
{------------------------------------------------------------------------------}
procedure TAnsiCompareText.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := AnsiCompareText(AArgs[0], AArgs[1]);
end;

{***************************** TAnsiLowerCase ******************************}
{------------------------------------------------------------------------------}
procedure TAnsiLowerCase.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := AnsiLowerCase(AArgs[0]);
end;
{------------------------------------------------------------------------------}
{***************************** TAnsiUpperCase ******************************}

procedure TAnsiUpperCase.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := AnsiUpperCase(AArgs[0]);
end;

{********************************* TAbs ************************************}
{------------------------------------------------------------------------------}
procedure TAbs.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Abs(AArgs[0]);
end;

{******************************* TCompareStr *******************************}
{------------------------------------------------------------------------------}
procedure TCompareStr.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := CompareStr(AArgs[0], AArgs[1])
end;

{****************************** TCompareText *******************************}
{------------------------------------------------------------------------------}
procedure TCompareText.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := CompareText(AArgs[0], AArgs[1]);
end;

{********************************* TDate ***********************************}
{------------------------------------------------------------------------------}
procedure TDate.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Date;
end;

{**************************** TDateTimeToStr *******************************}
{------------------------------------------------------------------------------}
procedure TDateTimeToStr.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := DateTimeToStr(AArgs[0]);
end;

{*********************************** TDateToStr ****************************}
{------------------------------------------------------------------------------}
procedure TDateToStr.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := DateToStr(AArgs[0]);
end;

{******************************* TDayOfWeek ********************************}
{------------------------------------------------------------------------------}
procedure TDayOfWeek.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := DayOfWeek(AArgs[0]);
end;

{*********************************** TExp **********************************}
{------------------------------------------------------------------------------}
procedure TExp.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Exp(AArgs[0]);
end;

{******************************** TFloatToStr ******************************}
{------------------------------------------------------------------------------}
procedure TFloatToStr.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := FloatToStr(AArgs[0]);
end;

{*********************************** TFrac *********************************}
{------------------------------------------------------------------------------}
procedure TFrac.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Frac(AArgs[0]);
end;

{*********************************** TInt **********************************}
{------------------------------------------------------------------------------}
procedure TInt.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Int(AArgs[0]);
end;

{********************************* TIntToHex *******************************}
{------------------------------------------------------------------------------}
procedure TIntToHex.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := IntToHex(AArgs[0], AArgs[1]);
end;

{****************************** TIntToStr **********************************}
{------------------------------------------------------------------------------}
procedure TIntToStr.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := IntToStr(AArgs[0]);
end;

{***************************** TIsLeapYear *********************************}
{------------------------------------------------------------------------------}
procedure TIsLeapYear.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := IsLeapYear(AArgs[0]);
end;

{**************************** TIsValidIdent ********************************}
{------------------------------------------------------------------------------}
procedure TIsValidIdent.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := IsValidIdent(AArgs[0])
end;

{********************************** TTrue **********************************}
{------------------------------------------------------------------------------}
procedure TTrue.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := True;
end;

{********************************* TFalse **********************************}
{------------------------------------------------------------------------------}
procedure TFalse.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := False;
end;

{********************************** TNow ***********************************}
{------------------------------------------------------------------------------}
procedure TNow.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Now;
end;

{********************************* TPos ************************************}
{------------------------------------------------------------------------------}
procedure TPos.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Pos(AArgs[0], AArgs[1]);
end;

{****************************** TRandom ************************************}
{------------------------------------------------------------------------------}
procedure TRandom.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  if ACall.ArgCount = 0 then
    AResult := Random
  else if ACall.ArgCount = 1 then
    AResult := Random(Integer(AArgs[0]))
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);
end;

{******************************* TRound ************************************}
{------------------------------------------------------------------------------}
procedure TRound.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Round(AArgs[0]);
end;

{******************************** TSqr *************************************}
{------------------------------------------------------------------------------}
procedure TSqr.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Sqr(AArgs[0]);
end;

{******************************** TSqrt ************************************}
{------------------------------------------------------------------------------}
procedure TSqrt.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Sqrt(AArgs[0])
end;

{****************************** TStrToDate *********************************}
{------------------------------------------------------------------------------}
procedure TStrToDate.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := StrToDate(AArgs[0]);
end;

{**************************** TStrToDateTime *******************************}
{------------------------------------------------------------------------------}
procedure TStrToDateTime.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := StrToDateTime(AArgs[0]);
end;

{**************************** TStrToFloat **********************************}
{------------------------------------------------------------------------------}
procedure TStrToFloat.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := StrToFloat(AArgs[0]);
end;

{***************************** TStrToInt ***********************************}
{------------------------------------------------------------------------------}
procedure TStrToInt.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := StrToInt(AArgs[0]);
end;

{**************************** TStrToIntDef *********************************}
{------------------------------------------------------------------------------}
procedure TStrToIntDef.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := StrToIntDef(AArgs[0], AArgs[1]);
end;

{****************************** TTime **************************************}
{------------------------------------------------------------------------------}
procedure TTime.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Time;
end;

{**************************** TTimeToStr ***********************************}
{------------------------------------------------------------------------------}
procedure TTimeToStr.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := TimeToStr(AArgs[0]);
end;

{**************************** TStrToTime ***********************************}
{------------------------------------------------------------------------------}
procedure TStrToTime.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := StrToTime(AArgs[0]);
end;

{******************************* TTrim *************************************}
{------------------------------------------------------------------------------}
procedure TTrim.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Trim(AArgs[0]);
end;

{****************************** TTrimLeft **********************************}
{------------------------------------------------------------------------------}
procedure TTrimLeft.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := TrimLeft(AArgs[0]);
end;

{***************************** TTrimRight **********************************}
{------------------------------------------------------------------------------}
procedure TTrimRight.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := TrimRight(AArgs[0]);
end;

{******************************* TTrunc ************************************}
{------------------------------------------------------------------------------}
procedure TTrunc.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Trunc(AArgs[0]);
end;

{******************************* TUpperCase ********************************}
{------------------------------------------------------------------------------}
procedure TUpperCase.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := UpperCase(AArgs[0]);
end;

{****************************** TVarIsNull *********************************}
{------------------------------------------------------------------------------}
procedure TVarIsNull.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := VarIsNull(AArgs[0]);
end;

{******************************** TVarToStr ********************************}
{------------------------------------------------------------------------------}
procedure TVarToStr.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := VarToStr(AArgs[0]);
end;

{********************************* TShowMessage ****************************}
{------------------------------------------------------------------------------}
procedure TShowMessage.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  ShowMessage(AArgs[0]);
end;

{******************************* TIncMonth *********************************}
{------------------------------------------------------------------------------}
procedure TIncMonth.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  if ACall.ArgCount = 1 then
    AResult := IncMonth(AArgs[0])
  else if ACall.ArgCount = 2 then
    AResult := IncMonth(AArgs[0], AArgs[1])
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);
end;

{******************************** TDecodeDate *********************************}
{------------------------------------------------------------------------------}
procedure TDecodeDate.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  v1, v2, v3: Word;
begin
  v1 := AArgs[1];
  v2 := AArgs[2];
  v3 := AArgs[3];

  DecodeDate(AArgs[0], v1, v2, v3);

  VarAssignByRef(AArgs[1], v1);
  VarAssignByRef(AArgs[2], v2);
  VarAssignByRef(AArgs[3], v3);
end;

{*********************************** TChr **********************************}
{------------------------------------------------------------------------------}
procedure TChr.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Chr(Integer(AArgs[0]));
end;

{********************************** TOdd ***********************************}
{------------------------------------------------------------------------------}
procedure TOdd.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := Odd(Integer(AArgs[0]));
end;

{********************************* TInsert *********************************}
{------------------------------------------------------------------------------}
procedure TInsert.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  v1: WideString;
begin
  v1 := AArgs[1];
  Insert(AArgs[0], v1, Integer(AArgs[2]));
  VarAssignByRef(AArgs[1], v1);
end;

{***************************** TCreateOleObject ****************************}
{------------------------------------------------------------------------------}
procedure TCreateOleObject.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := CreateOleObject(AArgs[0]);
end;

{*************************** TGetActiveOleObject ***************************}
{------------------------------------------------------------------------------}
procedure TGetActiveOleObject.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := GetActiveOleObject(AArgs[0]);
end;

{******************************* TInputQuery *******************************}
{------------------------------------------------------------------------------}
procedure TInputQuery.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  v: String;
begin
  v := AArgs[2];
  AResult := InputQuery(AArgs[0], AArgs[1], v);
  VarAssignByRef(AArgs[2], v);
end;

{******************************* TDecodeTime *******************************}
{------------------------------------------------------------------------------}
procedure TDecodeTime.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  v1, v2, v3, v4: Word;
begin
  v1 := AArgs[1];
  v2 := AArgs[2];
  v3 := AArgs[3];
  v4 := AArgs[4];

  DecodeTime(AArgs[0], v1, v2, v3, v4);

  VarAssignByRef(AArgs[1], v1);
  VarAssignByRef(AArgs[2], v2);
  VarAssignByRef(AArgs[3], v3);
  VarAssignByRef(AArgs[4], v4);
end;

{****************************** TEncodeDate ********************************}
{------------------------------------------------------------------------------}
procedure TEncodeDate.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := EncodeDate(AArgs[0], AArgs[1], AArgs[2])
end;

{**************************** TEncodeTime **********************************}
{------------------------------------------------------------------------------}
procedure TEncodeTime.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := EncodeTime(AArgs[0], AArgs[1], AArgs[2], AArgs[3])
end;

{****************************** TFormatFloat *******************************}
{------------------------------------------------------------------------------}
procedure TFormatFloat.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := FormatFloat(AArgs[0], AArgs[1]);
end;

{*************************** TFormatDateTime *******************************}
{------------------------------------------------------------------------------}
procedure TFormatDateTime.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  AResult := FormatDateTime(AArgs[0], AArgs[1])
end;

{********************************** TDelete ********************************}
{------------------------------------------------------------------------------}
procedure TDelete.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  v0: WideString;
begin
  v0 := AArgs[0];

  Delete(v0, Integer(AArgs[1]), Integer(AArgs[2]));
  VarAssignByRef(AArgs[0], v0);
end;

{******************************* TAssigned *********************************}
{------------------------------------------------------------------------------}
procedure TAssigned.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  P: PVarData;
begin
  AResult := True;
  P       := PVarData(VarResolveRef(AArgs[0]));

  if p.VType in [varEmpty, varNull] then
    AResult := False
  else if (p.VType = varDispatch) and (p.VDispatch = nil) then
    AResult := False;
end;

{********************************** TOrd **************************************}
{------------------------------------------------------------------------------}
procedure TOrd.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  if VarIsStr(AArgs[0]) then
    if Length(WideString(AArgs[0])) = 0 then
      AResult := 0
    else
      AResult := Ord(WideString(AArgs[0])[1])
  else
    AResult := Ord(Integer(AArgs[0]));
end;

{*********************************** TCopy ************************************}
{------------------------------------------------------------------------------}
procedure TCopy.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  str     : WideString;
  arr     : OleVariant;
  High, Low, i, j: Integer;
  Bounds  : array[0..1] of Integer;
begin
  if VarIsArray(AArgs[0]) then
  begin
    arr := AArgs[0];
    Low  := VarArrayLowBound(arr, 1);
    High := VarArrayHighBound(arr, 1);

    if Low < Integer(AArgs[1]) then
      Low := Integer(AArgs[1]);

    if High > (Low + Integer(AArgs[2]) - 1) then
      High := Low + Integer(AArgs[2]) - 1;

    if (High - Low) < 0 then
      AResult := OleUnassigned
    else
    begin
      Bounds[0] := 0;
      Bounds[1] := High - Low;
      AResult   := VarArrayCreate(Bounds, FindVarData(AArgs[0]).VType and
                                  varTypeMask);

      j := 0;
      for I := Low to High do
      begin
        VarArrayPut(Variant(AResult), VarArrayGet(arr, [I]), [J]);
        Inc(j);
      end;
    end;
  end
  else
  begin
    str     := AArgs[0];
    AResult := Copy(str, Integer(AArgs[1]), Integer(AArgs[2]))
  end;
end;

{*********************************** TLow *************************************}
{------------------------------------------------------------------------------}
procedure TLow.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  if not VarIsArray(AArgs[0]) then
    ELMDVMRuntime.RaiseError(retLowOnlyArray);

  if ACall.ArgCount = 1 then
    AResult := VarArrayLowBound(Variant(AArgs[0]), 1)
  else if ACall.ArgCount = 2 then
    AResult := VarArrayLowBound(Variant(AArgs[0]), AArgs[1])
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);
end;

{********************************** TFormat ***********************************}
{------------------------------------------------------------------------------}
procedure TFormat.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
   arr   : array of TVarRec;
   H, Low, I, J: Integer;
   VarArr: array of OleVariant;
begin
  if ACall.ArgCount = 1 then
    AResult := AArgs[0]
  else if (ACall.ArgCount = 2) and (VarIsArray(AArgs[1])) then
  begin
    H   := VarArrayHighBound(AArgs[1], 1);
    Low := VarArrayLowBound(AArgs[1], 1);
    SetLength(arr, H - Low + 1);
    SetLength(VarArr, Length(arr));

    J := 0;
    for I := Low to H do
    begin
      VarArr[J] := VarArrayGet(AArgs[1], [I]);
      Inc(J);
    end;

    for I := 0 to High(VarArr) do
    begin
      arr[I].VType    := vtVariant;
      arr[I].VVariant := @VarArr[I];
    end;
    AResult := Format(AArgs[0], arr);
  end
  else
  begin
    SetLength(arr, ACall.ArgCount - 1);
    for I := 0 to High(arr) do
    begin
      arr[I].VType    := vtVariant;
      arr[I].VVariant := @AArgs[I + 1];
    end;
    AResult := Format(AArgs[0], arr);
  end;
end;

{********************************** TLength ***********************************}
{------------------------------------------------------------------------------}
procedure TLength.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  p: PVarData;
begin
  if VarIsArray(AArgs[0]) then
  begin
    if ACall.ArgCount = 1 then
      AResult := VarArrayHighBound(AArgs[0], 1) + 1 -
                 VarArrayLowBound(AArgs[0], 1)
    else if ACall.ArgCount = 2 then
      AResult := VarArrayHighBound(AArgs[0], AArgs[1]) + 1 -
                 VarArrayLowBound(AArgs[0], AArgs[1])
    else
      ELMDVMRuntime.RaiseError(retInvalidParamCount);
  end
  else
  begin
    if ACall.ArgCount = 1 then
    begin
      p := @AArgs[0];
      while p.VType = (varByRef or varVariant) do
        p := PVarData(p.VPointer);

      if p.VType = varOleStr then
        AResult := FastLength(p.VOleStr)
      else
        AResult := SlowLength(OleVariant(p^));
    end
    else
      ELMDVMRuntime.RaiseError(retInvalidParamCount);
  end;
end;

{********************************** THigh *************************************}
{------------------------------------------------------------------------------}
procedure THigh.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  if not VarIsArray(AArgs[0]) then
    ELMDVMRuntime.RaiseError(retHighOnlyArray);

  if ACall.ArgCount = 1 then
    AResult := VarArrayHighBound(Variant(AArgs[0]), 1)
  else if ACall.ArgCount = 2 then
    AResult := VarArrayHighBound(Variant(AArgs[0]), AArgs[1])
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);
end;

{ TInclude }

procedure TInclude.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  v0: TVarData;
begin
  v0.VType    := varInteger;
  v0.VInteger := AArgs[0];
  v0.VInteger := v0.VInteger or (1 shl Integer(AArgs[1]));

  VarAssignByRef(AArgs[0], OleVariant(v0));
end;

{ TExclude }

procedure TExclude.DoExecute(ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
var
  v0: TVarData;
begin
  v0.VType    := varInteger;
  v0.VInteger := AArgs[0];
  v0.VInteger := v0.VInteger and not (1 shl Integer(AArgs[1]));

  VarAssignByRef(AArgs[0], OleVariant(v0));
end;

function TLength.FastLength(S: PWideChar): Integer;
var
  cur: PWideChar;
begin
  Result := 0;
  if S = nil then
    Exit;

  cur := S;
  while cur^ <> #0 do
    Inc(cur);

  Result := (cur - S);
end;

function TLength.SlowLength(const S: OleVariant): Integer;
begin
  Result := Length(WideString(S));
end;

initialization
  IntegerNameIndex  := GlobNameTable.GetNameIndex('Integer');
  StringNameIndex   := GlobNameTable.GetNameIndex('String');
  DoubleNameIndex   := GlobNameTable.GetNameIndex('Double');
  SingleNameIndex   := GlobNameTable.GetNameIndex('Single');
  BooleanNameIndex  := GlobNameTable.GetNameIndex('Boolean');
  VariantNameIndex  := GlobNameTable.GetNameIndex('Variant');
  ByteNameIndex     := GlobNameTable.GetNameIndex('Byte');
  WordNameIndex     := GlobNameTable.GetNameIndex('Word');
  LongWordNameIndex := GlobNameTable.GetNameIndex('LongWord');
  SmallintNameIndex := GlobNameTable.GetNameIndex('SmallInt');
  CurrencyNameIndex := GlobNameTable.GetNameIndex('Currency');
  ShortIntNameIndex := GlobNameTable.GetNameIndex('ShortInt');
  Int64NameIndex    := GlobNameTable.GetNameIndex('Int64');
  UInt64NameIndex   := GlobNameTable.GetNameIndex('UInt64');
  ErrorNameIndex    := GlobNameTable.GetNameIndex('Error');
  ObjectNameIndex   := GlobNameTable.GetNameIndex('Object');

{ ---------------------------------------------------------------------------- }
end.

