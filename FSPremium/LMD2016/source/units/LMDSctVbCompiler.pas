unit LMDSctVbCompiler;
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

LMDSctVBCompiler unit (YB)
---------------------------
LMD ScriptPack compiler for native VBScript.

Changes
-------

###############################################################################}

interface

uses
  Windows, Classes, SysUtils, Variants, StrUtils, Dialogs, Controls
  {$IFDEF LMDCOMP17}, UITypes{$ENDIF}, LMDSctCst, LMDSctClass, LMDSctVMCompBase,
  LMDSctVMByteCode;

resourcestring
  SStrExpected          = '%s expected.';
  SInvalidToken         = 'Invalid token: %s.';
  SLMDWrongDate         = 'Syntax error in date constant';
  SLMDUnterminatedIdent = 'Unterminated identifier';
  SLMDEmptyIdent        = 'Identifiers with empty name not supported';
  SLMDInvalidExit       = 'Invalid "exit" instruction';

type
  TLMDVbProcDecl       = class;
  TLMDVbDesignatorExpr = class;
  TLMDVbParser         = class;
  ELMDVbCompiler       = class(ELMDCompileBase);

  TLMDExitLabels = record
    ProcL: TLMDLabel; // In case of nil, icRet should be used.
    ForL:  TLMDLabel;
    DoL:   TLMDLabel;
  end;

  TLMDContext = record
    Code:         TLMDByteCode;
    CurNamespace: TLMDAbstractNamespace;
    CurExits:     TLMDExitLabels;
    CurReraise:   TLMDTry;
  end;

  {***************************** TLMDVbExpression *****************************}

  TLMDExprEmitRes = (erNoRes, erStack, erPopJmpIfTrue, erPopJmpIfFalse);

  TLMDVbExpression = class(ILMDEmitable)
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

  {**************************** TLMDVbUnaryOpExpr *****************************}

  TLMDVbUnaryOp = (uoPlus, uoMinus, uoNot);

  TLMDVbUnaryOpExpr = class(TLMDVbExpression)
  private
    FOpType:  TLMDVbUnaryOp;
    FOperand: TLMDVbExpression;
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel; var AResInStack: Boolean); override;
  public
    constructor Create(OpType: TLMDVbUnaryOp; Operand: TLMDVbExpression);
    destructor  Destroy; override;

    property OpType: TLMDVbUnaryOp read FOpType;
    property Operand: TLMDVbExpression read Foperand;
  end;

  {**************************** TLMDVbBinaryOpExpr ****************************}

  TLMDVbBinaryOp = (boPlus, boMinus, boMult, boDivide, boIntDivide, boImp,
                    boEqv, boXor, boOr, boAnd, boGreater, boGreaterEqual,
                    boLess, boLessEqual, boEqual, boNotEqual, boStrConcat,
                    boMod, boExp, boIs, boIsNot, boTypeOfIs);

  TLMDVbBinaryOpExpr = class(TLMDVbExpression)
  private
    FLeftExpr:  TLMDVbExpression;
    FRightExpr: TLMDVbExpression;
    FOpType:    TLMDVbBinaryOp;
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel; var AResInStack: Boolean); override;
  public
    constructor Create(ALeftExpr: TLMDVbExpression; ARightExpr: TLMDVbExpression;
                       OpType: TLMDVbBinaryOp);
    destructor Destroy; override;

    property LeftExpr: TLMDVbExpression read FLeftExpr;
    property RightExpr: TLMDVbExpression read FRightExpr;
    property OpType: TLMDVbBinaryOp read FOpType;
  end;

  {*************************** TLMDVbDesignatorExpr ***************************}

  TLMDVbDesignatorItem = class
  private
    FName:         Integer;
    FStrName:      WideString;
    FBracketType:  TLMDBracketType;
    FArgs:         TList;
    FSourcePos:    Integer;
    FIsResultUsed: Boolean;

    function  GetArg(AIndex: Integer): TLMDVbExpression;
    function  GetArgsCount: Integer;
    function  GetIsNamed: Boolean;
    procedure SetName(AName: Integer; const AStrName: WideString);
    procedure AddArgument(AExpression: TLMDVbExpression);
    procedure ClearArgs;
    procedure EmitArgs(var C: TLMDContext);
  public
    constructor Create;
    destructor Destroy; override;

    property Name: Integer read FName;
    property StrName: WideString read FStrName;
    property SourcePos: Integer read FSourcePos;
    property BracketType: TLMDBracketType read FBracketType;
    property Args[AIndex: Integer]:  TLMDVbExpression read GetArg;
    property ArgCount: Integer read GetArgsCount;
    property IsNamed: Boolean read GetIsNamed;
    property IsResultUsed: Boolean read FIsResultUsed; // Whether the call result
                                                       // is semantically used.
  end;

  TLMDVbGetCallInstr = function(var C: TLMDContext;
                                AItem: TLMDVbDesignatorItem;
                                out AInstr: TLMDInstr;
                                out ANeedSlot: Boolean): Boolean of object;
  TLMDVbEmitValue    = procedure(var C: TLMDContext;
                                 AItem: TLMDVbDesignatorItem) of object;

  TLMDVbDesignatorExpr = class(TLMDVbExpression)
  private
    FItems: TList;

    function  GetItems(AIndex: Integer): TLMDVbDesignatorItem;
    function  GeItemCount: Integer;
    function  GetLastItem: TLMDVbDesignatorItem;
    procedure AddItem;
    procedure ClearItems;
    function  OptimizeCallInstr(var C: TLMDContext;
                                AItem: TLMDVbDesignatorItem;
                                ACallInstr: TLMDInstrCode;
                                AHasObject, AHasValue: Boolean;
                                out ANeedSlot: Boolean): TLMDInstr;
    procedure InternalEmit(var C: TLMDContext; ANeedRef: Boolean;
                           AGetInstrProc: TLMDVbGetCallInstr = nil;
                           AEmitValueProc: TLMDVbEmitValue = nil);
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel; var AResInStack: Boolean); override;
    procedure DoEmitRefByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    constructor CreateSimple(AName: Integer; const AStrName: WideString;
                             ASourcePos: Integer);
    destructor Destroy; override;

    property  Items[AInteger: Integer]: TLMDVbDesignatorItem  read GetItems; default;
    property  ItemCount: Integer read GeItemCount;
    property  LastItem: TLMDVbDesignatorItem read GetLastItem;
  end;

  {******************************* TLMDVbNewExpr ******************************}

  TLMDVbNewExpr = class(TLMDVbDesignatorExpr)
  private
    FNewCallItem: TLMDVbDesignatorItem; // Don't own this item.

    function NewCallInstrProc(var C: TLMDContext; AItem: TLMDVbDesignatorItem;
                              out AInstr: TLMDInstr; out ANeedSlot: Boolean): Boolean;
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel; var AResInStack: Boolean); override;
    procedure DoEmitRefByteCode(var C: TLMDContext); override;
  public
    property NewCallItem: TLMDVbDesignatorItem read FNewCallItem;
  end;

  {**************************** TLMDVbLiteralExpr *****************************}

  TLMDVbLiteralExpr = class(TLMDVbExpression)
  private
    FValue: OleVariant;
  protected
    procedure DoEmitByteCode(var C: TLMDContext; AEmitRes: TLMDExprEmitRes;
                             AJmpLabel: TLMDLabel; var AResInStack: Boolean); override;
  public
    constructor Create(Value: OleVariant);
    property    Value: OleVariant read FValue;
  end;

  {***************************** TLMDVbStatement ******************************}

  TLMDVbStatement = class(ILMDEmitable)
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

  {****************************** TLMDVbStmtList ******************************}

  TLMDVbStmtList = class
  private
    FOwnItems: Boolean;
    FItems:    TList;

    function GetItems(AIndex: Integer): TLMDVbStatement;
    function GetCount: Integer;
  public
    constructor Create; overload;
    constructor Create(AOwnItems: Boolean); overload;
    destructor Destroy; override;

    procedure EmitByteCode(var C: TLMDContext);
    procedure Add(Statement: TLMDVbStatement);
    property  Items[AIndex: Integer]: TLMDVbStatement read GetItems; default;
    property  Count: Integer read GetCount;
  end;

  {***************************** TLMDVbReturnStmt *****************************}

  TLMDVbReturnStmt = class(TLMDVbStatement)
  private
    FExpr: TLMDVbExpression;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    destructor Destroy; override;
    property   Expr: TLMDVbExpression read FExpr;
  end;

  {****************************** TLMDVbTryStmt *******************************}

  TLMDVbCatch = class;

  TLMDVbCatchNamespace = class(TLMDAbstractNamespace)
  private
    FCatch:    TLMDVbCatch;
    FVarIndex: Integer;
  public
    constructor Create(AParent: TLMDAbstractNamespace; ACatch: TLMDVbCatch;
                       AVarIndex: Integer);

    function  Find(AThread: Pointer; AName: Integer;
                   AStrName: PWideString): TLMDNameSearchRes; override;
    procedure EnumDebugVars(ALocalsOnly: Boolean;
                            AProc: TLMDNamespaceEnumVarsProc); override;
    function  CompileTimeFind(AName: Integer): TLMDNameSearchRes; override;
  end;

  TLMDVbCatch = class
  private
    FName:      Integer;
    FStrName:   WideString;
    FExpr:      TLMDVbExpression;
    FStmts:     TLMDVbStmtlist;
    FNamespace: TLMDVbCatchNamespace;

    function GetHasAs: Boolean;
    function CreateNS(AParent: TLMDAbstractNamespace;
                      AVarIndex: Integer): TLMDAbstractNamespace;
  public
    constructor Create(AName: Integer; const AStrName: WideString); overload;
    constructor Create; overload;
    destructor Destroy; override;

    property Name: Integer read FName;
    property HasAs: Boolean read GetHasAs;
    property StrName: WideString read FStrName;
    property Expr: TLMDVbExpression read FExpr;
    property Stmts: TLMDVbStmtlist read FStmts;
    property Namespace: TLMDVbCatchNamespace read FNamespace;
  end;

  TLMDVbTryStmt = class(TLMDVbStatement)
  private
    FTryStmts:     TLMDVbStmtList;
    FCatches:      TList;
    FFinallyStmts: TLMDVbStmtList;

    function  GetCatchCount: Integer;
    function  GetCatches(AIndex: Integer): TLMDVbCatch;
    procedure AddCatch(ACatch: TLMDVbCatch);
    procedure EmitTryFinally(var C: TLMDContext);
    procedure EmitTryCatch(var C: TLMDContext);
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property TryStmts: TLMDVbStmtList read FTryStmts;
    property CatchCount: Integer read GetCatchCount;
    property Catches[AIndex: Integer]: TLMDVbCatch read GetCatches;
    property FinallyStmts: TLMDVbStmtList read FFinallyStmts;
  end;

  TLMDVbThrowStmt = class(TLMDVbStatement)
  private
    FExpr: TLMDVbExpression;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    destructor Destroy; override;
    property   Expr: TLMDVbExpression read FExpr;
  end;

  {*************************** TLMDVbExpressionStmt ***************************}

  TLMDVbExpressionStmt = class(TLMDVbStatement)
  private
    FExpr: TLMDVbExpression;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create(AExpr: TLMDVbExpression);
    destructor  Destroy; override;

    property Expr: TLMDVbExpression read FExpr;
  end;

  {***************************** TLMDVbSelectStmt *****************************}

  TLMDVbCaseSelector = class
  private
    FLabels:    TList;
    FStmts:     TLMDVbStmtList;
    FSourcePos: Integer;

    function  GetLabels(AIndex: Integer): TLMDVbExpression;
    function  GetLabelCount: Integer;
    procedure AddLabel(AExpr: TLMDVbExpression);
  public
    constructor Create;
    destructor Destroy; override;

    property SourcePos: Integer read FSourcePos;
    property Labels[AIndex: Integer]: TLMDVbExpression read GetLabels;
    property LabelCount: Integer read GetLabelCount;
    property StmtList: TLMDVbStmtList read FStmts;
  end;

  TLMDVbSelectStmt = class(TLMDVbStatement)
  private
    FExpr:      TLMDVbExpression;
    FSelectors: TList;
    FElseStmts: TLMDVbStmtList;

    function  GetSelectors(AIndex: Integer): TLMDVbCaseSelector;
    function  GetSelectorCount: Integer;
    procedure AddSelector(ASelector: TLMDVbCaseSelector);
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property Expr: TLMDVbExpression read FExpr;
    property Selectors[AIndex: Integer]: TLMDVbCaseSelector read GetSelectors;
    property SelectorCount: Integer read GetSelectorCount;
    property ElseStmts: TLMDVbStmtList read FElseStmts;
  end;

  {****************************** TLMDVbCallStmt ******************************}

  TLMDVbCallStmt = class(TLMDVbStatement)
  private
    FDesignator: TLMDVbDesignatorExpr;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create(Designator: TLMDVbDesignatorExpr);
    destructor Destroy; override;

    property Designator: TLMDVbDesignatorExpr read FDesignator;
  end;

  {****************************** TLMDVbExitStmt ******************************}

  TLMDVbExitType = (etFor, etDo, etFunction, etSub);

  TLMDVbExitStmt = class(TLMDVbStatement)
  private
    FExitType: TLMDVbExitType;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create(ExitType: TLMDVbExitType);
    property    ExitType: TLMDVbExitType read FExitType;
  end;

  {****************************** TLMDVbDimStmt *******************************}

  TLMDVbDimVarDecl = class
  private
    FIdentifier: Integer;
    FIsArray:    Boolean;
    FArrayDims:  TList;
    FSourcePos:  Integer;
    FVar:        TObject;
    FElemType:   TVarType;
    FIniter:     TLMDVbExpression;

    function  GetArrayDims(AIndex: Integer): TLMDVbExpression;
    function  GetArrayDimCount: Integer;
    procedure AddArrayDim(AExpr: TLMDVbExpression);
    procedure EmitArrayDims(var C: TLMDContext);
  public
    constructor Create(AIdentifier: Integer);
    destructor Destroy; override;

    property  SourcePos: Integer read FSourcePos;
    property  Identifier: Integer read FIdentifier;
    property  IsArray: Boolean read FIsArray; // Can be True with zero dims.
    property  ElemType: TVarType read FElemType;
    property  ArrayDims[AIndex: Integer]: TLMDVbExpression read GetArrayDims;
    property  ArrayDimCount: Integer read GetArrayDimCount;
    property  Initer: TLMDVbExpression read FIniter;
    property  Var_: TObject read FVar; // TLMDVbLocalVarDecl or TLMDVarObject
                                       // (global var).
  end;

  TLMDVbDimStmt = class(TLMDVbStatement)
  private
    FVarDecls: TList;

    function  GetVarDecls(AIndex: Integer): TLMDVbDimVarDecl;
    function  GetVarDeclCount: Integer;
    procedure AddVarDecl(AVarDecl: TLMDVbDimVarDecl);
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property VarDecls[AIndex: Integer]: TLMDVbDimVarDecl read GetVarDecls;
    property VarDeclCount: Integer read GetVarDeclCount;
  end;

  {****************************** TLMDVbRedimStmt *****************************}

  TLMDVbRedimVarDecl = class
  private
    FVarExpr:    TLMDVbDesignatorExpr;
    FArrayDims:  TList;
    FSourcePos:  Integer;
    FElemType:   TVarType;

    function  GetArrayDims(AIndex: Integer): TLMDVbExpression;
    function  GetArrayDimCount: Integer;
    procedure AddArrayDim(AExpr: TLMDVbExpression);
    procedure EmitArrayDims(var C: TLMDContext);
  public
    constructor Create;
    destructor Destroy; override;

    property  SourcePos: Integer read FSourcePos;
    property  VarExpr: TLMDVbDesignatorExpr read FVarExpr;
    property  ElemType: TVarType read FElemType;
    property  ArrayDims[AIndex: Integer]: TLMDVbExpression read GetArrayDims;
    property  ArrayDimCount: Integer read GetArrayDimCount;
  end;

  TLMDVbRedimStmt = class(TLMDVbStatement)
  private
    FPreserve: Boolean;
    FVarDecls: TList;

    function  GetVarDecls(AIndex: Integer): TLMDVbRedimVarDecl;
    function  GetVarDeclCount: Integer;
    procedure AddVarDecl(AVarDecl: TLMDVbRedimVarDecl);
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create(APreserve: Boolean);
    destructor Destroy; override;

    property Preserve: Boolean read FPreserve;
    property VarDecls[AIndex: Integer]: TLMDVbRedimVarDecl read GetVarDecls;
    property VarDeclCount: Integer read GetVarDeclCount;
  end;

  {**************************** TLMDVbEraseStmt *******************************}

  TLMDVbEraseStmt = class(TLMDVbStatement)
  private
    FExpr: TLMDVbDesignatorExpr;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    destructor Destroy; override;
    property   Expr: TLMDVbDesignatorExpr read FExpr;
  end;

  {*************************** TLMDVbAssignmentStmt ***************************}

  TLMDVbAssignmentStmt = class(TLMDVbStatement)
  private
    FLeftExpr:  TLMDVbDesignatorExpr;
    FRightExpr: TLMDVbExpression;

    function  AsgnCallInstrProc(var C: TLMDContext; AItem: TLMDVbDesignatorItem;
                                out AInstr: TLMDInstr; out ANeedSlot: Boolean): Boolean;
    procedure EmitValueProc(var C: TLMDContext; AItem: TLMDVbDesignatorItem);
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    destructor Destroy; override;
    property   LeftExpr: TLMDVbDesignatorExpr read FLeftExpr;
    property   RightExpr: TLMDVbExpression read FRightExpr;
  end;

  {****************************** TLMDVbIfBlock *******************************}

  TLMDVbIfBlock = class
  private
    FCondition: TLMDVbExpression;
    FStmtList:  TLMDVbStmtList;
    FSourcePos: Integer;
  public
    constructor Create(Condition: TLMDVbExpression);
    destructor Destroy; override;

    property SourcePos: Integer read FSourcePos;
    property Condition: TLMDVbExpression read FCondition;
    property StmtList: TLMDVbStmtList read FStmtList;
  end;

  {****************************** TLMDVbIfStmt ********************************}

  TLMDVbIfStmt = class(TLMDVbStatement)
  private
    FBlocks:       TList;
    FElseStmtList: TLMDVbStmtList;

    function  GetIfBlock(AIndex: Integer): TLMDVbIfBlock;
    function  GetIfBlocksCount: INteger;
    function  GetLastBlock: TLMDVbIfBlock;
    procedure AddBlock(Condition: TLMDVbExpression);
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property Blocks[AIndex: Integer]: TLMDVbIfBlock read GetIfBlock;
    property LastBlock: TLMDVbIfBlock read GetLastBlock;
    property BlocksCount: INteger read GetIfBlocksCount;
    property ElseStmtList: TLMDVbStmtList read FElseStmtList;
  end;

  {****************************** TLMDVbForStmt *******************************}

  TLMDVbForStmt = class(TLMDVbStatement)
  private
    FVarExpr:    TLMDVbDesignatorExpr;
    FFromExpr:   TLMDVbExpression;
    FToExpr:     TLMDVbExpression;
    FStepExpr:   TLMDVbExpression;
    FStmts:      TLMDVbStmtList;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property VarExpr: TLMDVbDesignatorExpr read FVarExpr;
    property FromExpr: TLMDVbExpression read FFromExpr;
    property ToExpr: TLMDVbExpression read FToExpr;
    property StepExpr: TLMDVbExpression read FStepExpr;
    property Stmts: TLMDVbStmtList read FStmts;
  end;

  {**************************** TLMDVbDoLoopStmt ******************************}

  TLMDVbLoopType       = (ltWhile, ltUntil);
  TLMDVbConditionCheck = (ccNoCondition, ccBeforeStmts, ccAfterStmts);

  TLMDVbDoLoopStmt = class(TLMDVbStatement)
  private
    FLoopType:  TLMDVbLoopType;
    FCondCheck: TLMDVbConditionCheck;
    FExpr:      TLMDVbExpression;
    FStmts:     TLMDVbStmtList;
  protected
    procedure DoEmitByteCode(var C: TLMDContext); override;
  public
    constructor Create;
    destructor Destroy; override;

    property  LoopType: TLMDVbLoopType read FLoopType;
    property  CondCheck: TLMDVbConditionCheck read FCondCheck;
    property  Expr: TLMDVbExpression read FExpr;
    property  Stmts: TLMDVbStmtList read FStmts;
  end;

  {****************************** TLMDVbProcDecl ******************************}

  TLMDVbProcLocalNamespace = class(TLMDAbstractNamespace)
  private
    FProc:   TLMDVbProcDecl;
  public
    constructor Create(AParent: TLMDAbstractNamespace; AProc: TLMDVbProcDecl);

    function  Find(AThread: Pointer; AName: Integer;
                   AStrName: PWideString): TLMDNameSearchRes; override;
    procedure EnumDebugVars(ALocalsOnly: Boolean;
                            AProc: TLMDNamespaceEnumVarsProc); override;
    function  CompileTimeFind(AName: Integer): TLMDNameSearchRes; override;
  end;

  TLMDVbProcLocalType = (ltVar, ltResult, ltParam);

  TLMDVbProcLocal = class(TLMDNamedItem)
  private
    FStrName:   WideString;
    FLocalType: TLMDVbProcLocalType;
  public
    constructor Create(ALocalType: TLMDVbProcLocalType; AName: Integer;
                       const AStrName: WideString);

    property LocalType: TLMDVbProcLocalType read FLocalType;
    property StrName: WideString read FStrName;
  end;

  TLMDVbLocalVarDecl = class(TLMDVbProcLocal)
  private
    FIndex: Integer;
  public
    constructor Create(AName: Integer; const AStrName: WideString); overload;
    property    Index: Integer read FIndex;
  end;

  TLMDVbLocalResultDecl = class(TLMDVbProcLocal)
  public
    constructor Create(AName: Integer; const AStrName: WideString);
  end;

  TLMDVbParamDecl = class(TLMDVbProcLocal)
  private
    FParamInfo: TLMDParamInfo;
  public
    constructor Create(AName: Integer; const AStrName: WideString;
                       AParamKind: TLMDParamKind); overload;
    property    ParamInfo: TLMDParamInfo read FParamInfo;
  end;

  TLMDVbProcKind = (pkFunction, pkSub);

  TLMDVbProcDecl = class(TLMDProcObject)
  private
    FProcKind:       TLMDVbProcKind;
    FLocalNamespace: TLMDVbProcLocalNamespace;
    FLocalMap:       TLMDNameHashTable;
    FParams:         TList;
    FLocalVars:      TList;
    FLocalResult:    TLMDVbLocalResultDecl;
    FStmtList:       TLMDVbStmtList;
    FSourcePos:      Integer;
    FEndSourcePos:   Integer;

    function  GetLocalVarCount: Integer;
    function  GetLocalVars(AIndex: Integer): TLMDVbLocalVarDecl;
    function  GetParams(AIndex: Integer): TLMDVbParamDecl;
    function  AddLocalItem(AItem: TLMDVbProcLocal): Boolean;
    function  CreateNS(AParent: TLMDAbstractNamespace): TLMDAbstractNamespace;
  public
    constructor Create(AName: Integer; const AStrName: WideString;
                       AProcKind: TLMDVbProcKind);
    destructor Destroy; override;

    procedure EmitByteCode(AGlobalNamespace: TLMDAbstractNamespace); override;
    property  SourcePos: Integer read FSourcePos;
    property  EndSourcePos: Integer read FEndSourcePos;
    property  ProcKind: TLMDVbProcKind read FProcKind;
    property  Params[AIndex: Integer]: TLMDVbParamDecl read GetParams;
    property  ParamCount;
    property  LocalVars[AIndex: Integer]: TLMDVbLocalVarDecl read GetLocalVars;
    property  LocalVarCount: Integer read GetLocalVarCount;
    property  LocalResult: TLMDVbLocalResultDecl read FLocalResult;
    property  LocalNamespace: TLMDVbProcLocalNamespace read FLocalNamespace;
    property  StmtList: TLMDVbStmtList read FStmtList;
  end;

  {******************************** TLMDVbToken *******************************}

  TLMDVbToken = (
    ptIdentifier,
    ptCString,
    ptCInteger,
    ptCFloat,
    ptCDate,
    ptImp,
    ptEqv,
    ptXor,
    ptOr,
    ptAnd,
    ptNot,
    ptTypeOf,
    ptIs,
    ptGreater,
    ptGreaterEqual,
    ptLess,
    ptLessEqual,
    ptEqual,
    ptAssignment,
    ptNotEqual,
    ptStrConcat,
    ptPlus,
    ptMinus,
    ptMultiply,
    ptDivide,
    ptIntDivide,
    ptMod,
    ptExp,
    ptOpenRound,
    ptCloseRound,
    ptComma,
    ptColon,
    ptDot,
    ptTrue,
    ptFalse,
    ptNothing,
    ptEmpty,
    ptNull,
    ptDim,
    ptSet,
    ptRedim,
    ptPreserve,
    ptFor,
    ptTo,
    ptStep,
    ptNext,
    ptIf,
    ptThen,
    ptElse,
    ptElseIf,
    ptEnd,
    ptDo,
    ptLoop,
    ptWhile,
    ptUntil,
    ptFunction,
    ptSub,
    ptByRef,
    ptByVal,
    ptErase,
    ptCall,
    prSelect,
    ptCase,
    ptExit,
    ptTry,
    ptCatch,
    ptAs,
    ptFinally,
    ptThrow,
    ptReturn,
    ptNew,
    ptComment,
    ptHiddenEOl,
    ptEOl,
    ptEOf
  );

  TLMDVbTokens = set of TLMDVbToken;

  {*************************** class TLMDVbScanner ****************************}

  TLMDVbScannerSavepoint = PWideChar;
  TLMDVbTokenDescription = record
    S:         WideString;
    IsKeyword: Boolean;
  end;

  TVBScanner = class
  private
    FStrSource:      WideString;
    FSource:         PWideChar;
    FCurChar:        PWideChar;
    FSkipComments:   Boolean;
    FToken:          TLMDVbToken;
    FTokenStartPos:  Integer;
    FSData:          WideString;
    FIData:          Integer;
    FFData:          Extended;
    FDData:          TDateTime;
    FTokenEndPos:    Integer;
    FLastEOlSkipped: Boolean;

    procedure NextChar;
    function  GetCurCharPos: Integer;
    procedure SkipBlanks;
    procedure ScanToken;
    function  ScanNumber(ALLowFloat: Boolean; out IntVal: Integer;
                         out FloatVal: Extended): TLMDVbToken;
    function  ScanHexNumber(ALLowFloat: Boolean; out IntVal: Integer;
                            out FloatVal: Extended): TLMDVbToken;
    function  ScanIdentifier: WideString;
    function  ScanBracketIdentifier: WideString;
    function  ScanString: WideString;
    procedure ScanHiddenEOl;
    function  ScanDate(var ADate: TDateTime): TLMDVbToken;
    function  DetectReservedWord(const Token: WideString): TLMDVbToken;
    procedure NextToken;
  public
    constructor Create(SkipComments: Boolean = True);
    destructor Destroy; override;

    function  TokenToStr(Token: TLMDVbToken): WideString;
    function  GetSavepoint: TLMDVbScannerSavepoint;
    procedure Rollback(const S: TLMDVbScannerSavepoint);
    procedure Start(const Source: WideString);
    procedure SkipToken;
    property  Token: TLMDVbToken read FToken;
    property  TokenStartPos: Integer read FTokenStartPos;  // In Delphi format,
    property  TokenEndPos: Integer read FTokenEndPos;      // starting from 1.
    property  SData: WideString read FSData;
    property  IData: Integer read FIData;
    property  FData: Extended read FFData;
    property  DData: TDateTime read FDData;
  end;

  {******************************* TLMDVbParser *******************************}

  TLMDVbParserTryState   = (ptsNowhere, ptsInTry, ptsInCatch, ptsInFinally);
  TLMDVbParserExitCounts = array[TLMDVbExitType] of Integer;

  TLMDVbParserSavepoint = record
    ScannerSP:        TLMDVbScannerSavepoint;
    LastSkippedPos:   Integer;
    CurrentProc:      TLMDVbProcDecl;
    ExitPntCounts:    TLMDVbParserExitCounts;
    OnlyColonBRCount: Integer;
    TryState:         TLMDVbParserTryState;
  end;

  TLMDVbParser = class(ILMDParserBase)
  private
    FCbs:              ILMDParserCallbacks;
    FScanner:          TVBScanner;
    FLastSkippedPos:   Integer;
    FCurrentProc:      TLMDVbProcDecl; // For adding local variables
                                       // by Dim stmt and for Return
                                       // stmt.
    FExitPntCounts:    TLMDVbParserExitCounts;
    FOnlyColonBRCount: Integer;
    FTryState:         TLMDVbParserTryState;

    function  GetCurToken: TLMDVbToken;
    function  GetSavepoint: TLMDVbParserSavepoint;
    procedure Rollback(const ASavepoint: TLMDVbParserSavepoint);
    procedure DoAddGlobalObject(AObj: TLMDGlobalObject);
    procedure DoAddProcLocal(AItem: TLMDVbProcLocal;
                             AProc: TLMDVbProcDecl);
    function  DoAddDimVar(AName: Integer; const AStrName: WideString): TObject;
    function  VbNothing: OleVariant;
  protected
    procedure InvalidTokenError(AToken: TLMDVbToken);
    procedure StrExpectedError(const AStr: string);
    procedure StrError(const AStr: string);
    procedure CheckTokens(ATokens: TLMDVbTokens);
    procedure CheckAndSkipTokens(ATokens: TLMDVbTokens);
    procedure SkipToken;
    property  CurToken: TLMDVbToken read GetCurToken;
    procedure ParseUnit;
    procedure ParseDecl;
    procedure ParseStmtList(StmtList: TLMDVbStmtList);
    function  ParseStatement: TLMDVbStatement;
    procedure ParseProcDecl;
    procedure ParseParamList(AProcDecl: TLMDVbProcDecl);
    function  ParseParamModifier: TLMDParamKind;
    function  ParseTryStmt: TLMDVbTryStmt;
    function  ParseThrowStmt: TLMDVbThrowStmt;
    function  ParseReturnStmt: TLMDVbReturnStmt;
    function  ParseDoLoopStmt: TLMDVbDoLoopStmt;
    procedure ParseWUExpr(ADoLoopStmt: TLMDVbDoLoopStmt);
    function  ParseIfStmt: TLMDVbIfStmt;
    function  ParseForStmt: TLMDVbForStmt;
    function  ParseExitStmt: TLMDVbExitStmt;
    function  ParseSelectStmt: TLMDVbSelectStmt;
    function  ParseCallStmt: TLMDVbCallStmt;
    function  ParseEraseStmt: TLMDVbEraseStmt;
    function  ParseSetStmt: TLMDVbAssignmentStmt;
    function  ParseDimStmt: TLMDVbDimStmt;
    function  ParseDimVarDecl: TLMDVbDimVarDecl;
    function  ParseRedimStmt: TLMDVbRedimStmt;
    function  ParseRedimVarDecl: TLMDVbRedimVarDecl;
    procedure ParseArrayDim(ArrayDecl: TLMDVbDimVarDecl);
    function  ParseExprStmt: TLMDVbStatement;
    function  ParseExpression: TLMDVbExpression;
    function  ParseEqvExpr: TLMDVbExpression;
    function  ParseXorExpr: TLMDVbExpression;
    function  ParseOrExpr: TLMDVbExpression;
    function  ParseAndExpr: TLMDVbExpression;
    function  ParseCompareExpr: TLMDVbExpression;
    function  ParseCompareOp: TLMDVbBinaryOp;
    function  ParseTypeOfExpr: TLMDVbExpression;
    function  ParseConcatExpr: TLMDVbExpression;
    function  ParseAddExpr: TLMDVbExpression;
    function  ParseAddOp: TLMDVbBinaryOp;
    function  ParseModExpr: TLMDVbExpression;
    function  ParseMultIntExpr: TLMDVbExpression;
    function  ParseMultExpr: TLMDVbExpression;
    function  ParseMultOp: TLMDVbBinaryOp;
    function  ParseExpExpr: TLMDVbExpression;
    function  ParseValueExpr: TLMDVbExpression;
    function  ParseNewExpr: TLMDVbNewExpr;
    function  ParseDesignator: TLMDVbDesignatorExpr; overload;
    function  ParseDesignator(out ArgCount: Integer;
                              out HasRound: Boolean): TLMDVbDesignatorExpr; overload;
    procedure ParseDesignatorTail(AExpr: TLMDVbDesignatorExpr;
                                  out ArgCount: Integer; out HasRound: Boolean);
    procedure ParseArguments(AItem: TLMDVbDesignatorItem; out ArgCount: Integer);
    function  IsBR: Boolean;
    procedure ParseBR;
    function  ParseIdentifier: Integer; overload;
    function  ParseIdentifier(out AStrName: WideString): Integer; overload;
    function  ParseArrayType: TVarType;
  public
    constructor Create(ACbs: ILMDParserCallbacks);
    destructor Destroy; override;

    procedure Parse(const ASource: WideString); override;
    function  ParseStmt(const ASource: WideString): ILMDEmitable; override;
    function  ParseExpr(const ASource: WideString): ILMDEmitable; override;
    property  Scanner: TVBScanner read FScanner;
  end;

  TLMDVbLanguage = class(TInterfacedObject, ILMDLanguage)
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
  Math, ComObj, LMDSctVM;

type
  {*************************** Intrinsic Objects ******************************}

  TVbIntrinsicKind  = (bokProcedure, bokFunction, bokConstant);
  TVbIntrinsicClass = class of TVbIntrinsic;

  TVbIntrinsic = class(TIntrinsic)
  private
    FKind:      TVbIntrinsicKind;
    FArgsCount: Integer;
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); virtual; abstract;
    class function VarToDate(const V: OleVariant): TDateTime; // For some date
                                                              // related intrinsics.
  public
    constructor Create(const AName: Integer; const AStrName: WideString;
                       AKind: TVbIntrinsicKind; AArgsCount: Integer);
    procedure   Execute(AVM: TLMDVMBase; ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbEmpty = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbNull = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbSmallInt = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbLongWord = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbShortInt = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbInt64 = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  {$IFDEF LMDCOMP12}
  TvbUInt64 = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;
  {$ENDIF}

  TvbInteger = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbSingle = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbDouble = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbCurrency = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbDate = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbString = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbObject = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbError = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbBoolean = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbVariant = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbDataObject = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbByte = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbArray = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbUseSystemDayOfWeek = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbSunday = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbMonday = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbTuesday = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbWednesday = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbThursday = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbFriday = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbSaturday = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbBinaryCompare = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbTextCompare = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbOKOnly = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbOKCancel = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbAbortRetryIgnore = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbYesNoCancel = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbYesNo = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbRetryCancel = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbCritical = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbQuestion = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbExclamation = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbInformation = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbOK = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbCancel = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbAbort = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbRetry = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbIgnore = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbYes = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TvbNo = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TAbs = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TAtn = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCos = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TSin = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTan = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TSqr = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TExp = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TLog = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCBool = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCByte = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCCur = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCDate = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCDbl = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCInt = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCLng = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCSng = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCStr = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TChr = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TInt = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TFix = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TRound = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TSgn = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TOct = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  THex = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TVarType_ = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTypeName = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TIsArray = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TIsDate = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TIsEmpty = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TIsNull = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TIsNumeric = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TIsObject = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TArray = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TLBound = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TUBound = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TNow = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDate = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTime = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TYear = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TMonth = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDay = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  THour = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TMinute = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TSecond = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TWeekday = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TWeekdayName = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TMonthName = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDateSerial = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTimeSerial = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDateValue = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTimeValue = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TDateAdd = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTimer = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TRGB = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TJoin = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TFilter = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TRnd = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TRandomize = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TCreateObject = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TGetObject = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TAsc = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TUCase = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TLCase = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TLen = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TLTrim = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TRTrim = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TTrim = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TSpace = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TString = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TStrReverse = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TStrComp = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TLeft = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TMid = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TRight = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TSplit = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TReplace = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TInStr = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TInStrRev = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TInputBox = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TMsgBox = class(TVbIntrinsic)
  protected
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  end;

  TGetRef = class(TVbIntrinsic)
  protected
    FVM: TLMDVMBase;
    procedure DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
                        var AResult: OleVariant); override;
  public
    procedure Execute(AVM: TLMDVMBase; ACall: TLMDCall; AArgs: PLMDVarArray;
                      var AResult: OleVariant); override;
  end;

const
  VARDEEPDATA = $BFE8;

  {************************** constant LMDVbTokens ****************************}

  LMDVbTokens: array[TLMDVbToken] of TLMDVbTokenDescription = (
    (S: 'identifier';         IsKeyword: False;    ), { ptIdentifier }
    (S: 'string constant';    IsKeyword: False;    ), { ptCString }
    (S: 'number';             IsKeyword: False;    ), { ptCInteger }
    (S: 'real constant';      IsKeyword: False;    ), { ptCFloat }
    (S: 'date constant';      IsKeyword: False;    ), { ptCDate }
    (S: 'Imp';                IsKeyword: True;     ), { ptImp }
    (S: 'Eqv';                IsKeyword: True;     ), { ptEqv }
    (S: 'Xor';                IsKeyword: True;     ), { ptXor }
    (S: 'Or';                 IsKeyword: True;     ), { ptOr }
    (S: 'And';                IsKeyword: True;     ), { ptAnd }
    (S: 'Not';                IsKeyword: True;     ), { ptNot }
    (S: 'TypeOf';             IsKeyword: True;     ), { ptTypeOf }
    (S: 'Is';                 IsKeyword: True;     ), { ptIs }
    (S: '>';                  IsKeyword: False;    ), { ptGreater }
    (S: '>=';                 IsKeyword: False;    ), { ptGreaterEqual }
    (S: '<';                  IsKeyword: False;    ), { ptLess }
    (S: '<=';                 IsKeyword: False;    ), { ptLessEqual }
    (S: '=';                  IsKeyword: False;    ), { ptEqual }
    (S: '=';                  IsKeyword: False;    ), { ptAssignment }
    (S: '<>';                 IsKeyword: False;    ), { ptNotEqual }
    (S: '&';                  IsKeyword: False;    ), { ptStrConcat }
    (S: '+';                  IsKeyword: False;    ), { ptPlus }
    (S: '-';                  IsKeyword: False;    ), { ptMinus }
    (S: '*';                  IsKeyword: False;    ), { ptMultiply }
    (S: '/';                  IsKeyword: False;    ), { ptDivide }
    (S: '\';                  IsKeyword: False;    ), { ptIntDivide }
    (S: 'Mod';                IsKeyword: True;     ), { ptMod }
    (S: '^';                  IsKeyword: False;    ), { ptExp }
    (S: '(';                  IsKeyword: False;    ), { ptOpenRound }
    (S: ')';                  IsKeyword: False;    ), { ptCloseRound }
    (S: ',';                  IsKeyword: False;    ), { ptComma }
    (S: ':';                  IsKeyword: False;    ), { ptColon }
    (S: '.';                  IsKeyword: False;    ), { ptDot }
    (S: 'True';               IsKeyword: True;     ), { ptTrue }
    (S: 'False';              IsKeyword: True;     ), { ptFalse }
    (S: 'Nothing';            IsKeyword: True;     ), { ptNothing }
    (S: 'Empty';              IsKeyword: True;     ), { ptEmpty }
    (S: 'Null';               IsKeyword: True;     ), { ptNull }
    (S: 'Dim';                IsKeyword: True;     ), { ptDim }
    (S: 'Set';                IsKeyword: True;     ), { ptSet }
    (S: 'Redim';              IsKeyword: True;     ), { ptRedim }
    (S: 'Preserve';           IsKeyword: True;     ), { ptPreserve }
    (S: 'For';                IsKeyword: True;     ), { ptFor }
    (S: 'To';                 IsKeyword: True;     ), { ptTo }
    (S: 'Step';               IsKeyword: True;     ), { ptStep }
    (S: 'Next';               IsKeyword: True;     ), { ptNext }
    (S: 'If';                 IsKeyword: True;     ), { ptIf }
    (S: 'Then';               IsKeyword: True;     ), { ptThen }
    (S: 'Else';               IsKeyword: True;     ), { ptElse }
    (S: 'ElseIf';             IsKeyword: True;     ), { ptElseIf }
    (S: 'End';                IsKeyword: True;     ), { ptEnd }
    (S: 'Do';                 IsKeyword: True;     ), { ptDo }
    (S: 'Loop';               IsKeyword: True;     ), { ptLoop }
    (S: 'While';              IsKeyword: True;     ), { ptWhile }
    (S: 'Until';              IsKeyword: True;     ), { ptUntil }
    (S: 'Function';           IsKeyword: True;     ), { ptFunction }
    (S: 'Sub';                IsKeyword: True;     ), { ptSub }
    (S: 'ByRef';              IsKeyword: True;     ), { ptByRef }
    (S: 'ByVal';              IsKeyword: True;     ), { ptByVal }
    (S: 'Erase';              IsKeyword: True;     ), { ptErase }
    (S: 'Call';               IsKeyword: True;     ), { ptCall }
    (S: 'Select';             IsKeyword: True;     ), { ptSelect }
    (S: 'Case';               IsKeyword: True;     ), { ptCase }
    (S: 'Exit';               IsKeyword: True;     ), { ptExit }
    (S: 'Try';                IsKeyword: True;     ), { ptTry }
    (S: 'Catch';              IsKeyword: True;     ), { ptCatch }
    (S: 'As';                 IsKeyword: True;     ), { ptAs }
    (S: 'Finally';            IsKeyword: True;     ), { ptFinally }
    (S: 'Throw';              IsKeyword: True;     ), { ptThrow }
    (S: 'Return';             IsKeyword: True;     ), { ptReturn }
    (S: 'New';                IsKeyword: True;     ), { ptNew }
    (S: 'comment';            IsKeyword: False;    ), { ptComment }
    (S: 'hidden end of line'; IsKeyword: False;    ), { ptHiddenEOl }
    (S: 'end of line';        IsKeyword: False;    ), { ptEOl }
    (S: 'end of file';        IsKeyword: False;    )  { ptEOf }
  );

  IdentifierTokens      = [ptIdentifier];
  DesignatorTokens      = IdentifierTokens;
  NewExprTokens         = [ptNew];
  ValueExprTokens       = DesignatorTokens + NewExprTokens + [ptTrue, ptFalse,
                          ptCInteger, ptCFloat, ptCString, ptCDate, ptNothing,
                          ptNull, ptEmpty, ptPlus, ptMinus, ptNot, ptOpenRound];
  ExpExprTokens         = ValueExprTokens;
  MultExprTokens        = ExpExprTokens;
  MultOpTokens          = [ptMultiply, ptDivide];
  MultIntExprTokens     = MultExprTokens;
  ModExprTokens         = MultIntExprTokens;
  AddExprTokens         = ModExprTokens;
  AddOpTokens           = [ptPlus, ptMinus];
  ConcatExprTokens      = AddExprTokens;
  TypeOfExprTokens      = ConcatExprTokens + [ptTypeOf];
  CompareExprTokens     = TypeOfExprTokens;
  CompareOpTokens       = [ptIs, ptGreaterEqual, ptLessEqual, ptGreater,
                           ptLess, ptNotEqual, ptEqual];
  AndExprTokens         = CompareExprTokens;
  OrExprTokens          = AndExprTokens;
  XorExprTokens         = OrExprTokens;
  EqvExprTokens         = XorExprTokens;
  ExprTokens            = EqvExprTokens;
  DoLoopStmtTokens      = [ptDo];
  WUExprTokens          = [ptWhile, ptUntil];
  IfStmtTokens          = [ptIf];
  ForStmtTokens         = [ptFor];
  ExitStmtTokens        = [ptExit];
  SelectStmtTokens      = [prSelect];
  CallStmtTokens        = [ptCall];
  EraseStmtTokens       = [ptErase];
  SetStmtTokens         = [ptSet];
  DimStmtTokens         = [ptDim];
  RedimStmtTokens       = [ptRedim];
  ArrayDeclTokens       = IdentifierTokens;
  ArrayDimTokens        = ExprTokens;
  ExprStmtTokens        = DesignatorTokens;
  TryStmtTokens         = [ptTry];
  ThrowStmtTokens       = [ptThrow];
  ReturnStmtTokens      = [ptReturn];
  StatementTokens       = ExprStmtTokens + SetStmtTokens + EraseStmtTokens +
                          CallStmtTokens + ExitStmtTokens + DimStmtTokens +
                          RedimStmtTokens + ForStmtTokens + IfStmtTokens +
                          DoLoopStmtTokens + SelectStmtTokens + TryStmtTokens +
                          ThrowStmtTokens + ReturnStmtTokens;
  StmtListLineTokens    = StatementTokens;
  StmtListTokens        = StmtListLineTokens;
  ParamModifierTokens   = [ptByRef, ptByVal];
  ParamListTokens       = ParamModifierTokens + ExprTokens;
  FuncDeclTokens        = [ptFunction];
  SubDeclTokens         = [ptSub];
  DeclTokens            = StmtListTokens + FuncDeclTokens + SubDeclTokens;
  UnitTokens            = DeclTokens;

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

{**************************** class TLMDVbScanner *****************************}
{ --------------------------------- private ---------------------------------- }

procedure TVBScanner.NextChar;
begin
  if FCurChar <> nil then
    Inc(FCurChar);
end;

{ ---------------------------------------------------------------------------- }

function TVBScanner.GetCurCharPos: Integer;
begin
  if FCurChar = nil then
    Result := 0
  else
    Result := (FCurChar - FSource) + 1; // Return in Delphi format,
                                        // starting from 1.
end;

{ ---------------------------------------------------------------------------- }

procedure TVBScanner.SkipBlanks;
begin
  while (FCurChar <> nil) and (FCurChar^ <> #0) do
  begin
    if  (Ord(FCurChar^) = 13) or
        (Ord(FCurChar^) = 10) or
        ((Ord(FCurChar^) <= 255) and
       (AnsiChar(FCurChar^) in [#33..#255])) then
      Break;
    Inc(FCurChar);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TVBScanner.ScanToken;
var
  tknpos:      Integer;
  tkn:         TLMDVbToken;
  sdt:         WideString;
  illegalChar: WideChar;
  idt:         Integer;
  fdt:         Extended;
  ddt:         TDateTime;
begin
  tknpos := GetCurCharPos;

  case FCurChar^ of
    #13:
    begin
      tkn := ptEOL;
      NextChar;
      if FCurChar^ = #10 then NextChar;
    end;
    '_':
    begin
      ScanHiddenEOl;
      tkn := ptHiddenEOl;
    end;
    'A'..'Z', 'a'..'z':
    begin
      sdt := ScanIdentifier;
      tkn := DetectReservedWord(sdt);
    end;
    '[':
    begin
      sdt := ScanBracketIdentifier;
      tkn := ptIdentifier;
    end;
    '&':
    begin
      NextChar;
      if AnsiChar(FCurChar^) in ['0'..'9' , 'A'..'F' , 'a'..'f'] then
        tkn := ScanHexNumber(True, idt, fdt)
      else
        tkn := ptStrConcat;
    end;
    '0'..'9':
      tkn := ScanNumber(True, idt, fdt);
    '"':
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
      tkn := ptColon;
      NextChar;
    end;
    '''':
    begin
      NextChar;
      while not ((Ord(FCurChar^) <= 255) and
                 (AnsiChar(FCurChar^) in [#0, #13, #10])) do
      begin
          sdt := sdt + FCurChar^;
          NextChar;
      end;
      tkn := ptComment;
    end;
    '#':
    begin
      NextChar;
      tkn := ScanDate(ddt);
    end;
    '^': begin tkn := ptExp; NextChar; end;
    '(': begin tkn := ptOpenRound; NextChar; end;
    ')': begin tkn := ptCloseRound; NextChar; end;
    ',': begin tkn := ptComma; NextChar; end;
    '+': begin tkn := ptPlus; NextChar; end;
    '-': begin tkn := ptMinus; NextChar; end;
    '*': begin tkn := ptMultiply; NextChar; end;
    '/': begin tkn := ptDivide; NextChar; end;
    '\': begin tkn := ptIntDivide; NextChar; end;
    '.': begin tkn := ptDot; NextChar; end;
  else
    illegalChar := FCurChar^;
    raise ELMDVbCompiler.CreateFmt(SLMDIllegalChar, [WideString(illegalChar),
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
    ptCDate:        FDData := ddt;
  end;
end;
                                                                      
{ ---------------------------------------------------------------------------- }

function TVBScanner.ScanNumber(ALLowFloat: Boolean; out IntVal: Integer;
  out FloatVal: Extended): TLMDVbToken;
var
  cbegin:  PWideChar;
  isFloat: Boolean;
  s:       WideString;
  valCode: Integer;
begin
  cbegin  := FCurChar;
  isFloat := False;

  while (Ord(FCurChar^) <= 255) and (AnsiChar(FCurChar^) in ['0'..'9']) do
  begin
    NextChar;
    if (FCurChar^ = '.') and AllowFloat then
    begin
      NextChar;
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
    Result := ptCFloat;
    Val(s, FloatVal, valCode);
    if valCode <> 0 then
      raise ELMDVbCompiler.Create(SLMDWrongFloat, GetCurCharPos - 1);
  end
  else
  begin
    Result := ptCInteger;
    Val(s, IntVal, valCode);
    if valCode <> 0 then
      raise ELMDVbCompiler.Create(SLMDWrongInteger, GetCurCharPos - 1);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TVBScanner.ScanHexNumber(ALLowFloat: Boolean; out IntVal: Integer;
  out FloatVal: Extended): TLMDVbToken;
var
  cbegin:  PWideChar;
  s:       WideString;
  valCode: Integer;
begin
  cbegin := FCurChar;

  while (Ord(FCurChar^) <= 255) and
         (AnsiChar(FCurChar^) in ['0'..'9', 'A'..'F', 'a'..'f']) do
    NextChar;

  SetString(s, cbegin, FCurChar - cbegin);
  Val('$' + s, IntVal, valCode);
  if valCode <> 0 then
    raise ELMDVbCompiler.Create(SLMDWrongInteger, GetCurCharPos - 1);
  Result := ptCInteger;
end;

procedure TVBScanner.ScanHiddenEOl;
var
  illegalChar: WideChar;
begin
  NextChar;
  SkipBlanks;

  case FCurChar^ of
    #13, #10:  begin
                 NextChar;
                 if FCurChar^ = #10 then NextChar;
               end;
    #0:        ; // Do nothing.
  else
    illegalChar := FCurChar^;
    raise ELMDVbCompiler.CreateFmt(SLMDIllegalChar, [WideString(illegalChar),
                                                     Ord(illegalChar)],
                                   GetCurCharPos);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TVBScanner.ScanBracketIdentifier: WideString;
var
  cbegin: PWideChar;
begin
  NextChar;
  cbegin := FCurChar;

  while not ((Ord(FCurChar^) <= 255) and
             (AnsiChar(FCurChar^) in [#13, #10, #0, ']'])) do
    NextChar;
  if FCurChar^ <> ']' then
    raise ELMDVbCompiler.Create(SLMDUnterminatedIdent, GetCurCharPos - 1);
  if FCurChar = cbegin then
    raise ELMDVbCompiler.Create(SLMDEmptyIdent, GetCurCharPos - 1);


  SetString(Result, cbegin, FCurChar - cbegin);
  NextChar;
end;

function TVBScanner.ScanDate(var ADate: TDateTime): TLMDVbToken;
type
  PDateToken = ^TDateToken;
  TDateToken = (dtNum, dtDateDelim, dtTimeDelim, dtAM, dtPM, dtEnd,
                dtInvalid);
var
  b:      PWideChar;
  sn:     WideString;
  tkns:   array[0..12] of TDateToken;
  nums:   array[0..12] of Integer;
  tcnt:   Integer;
  i:      Integer;
  n:      Integer;
  dt, tm: array[0..2] of Integer;
  val:    TDateTime;

  procedure _Error;
  begin
    raise ELMDVbCompiler.Create(SLMDWrongDate, GetCurCharPos - 1);
  end;

  function _ParseNum: Integer;
  begin
    if tkns[i] <> dtNum then
      _Error;
    Result := nums[i];
    Inc(i);
  end;

  procedure _ParseDateTail(N: Integer);
  begin
    dt[0] := N;

    if tkns[i] = dtDateDelim then
      Inc(i);
    dt[1] := _ParseNum;
    if (tkns[i] = dtDateDelim) or ((tkns[i] = dtNum) and
                                   (tkns[i + 1] <> dtTimeDelim)) then
    begin
      if tkns[i] = dtDateDelim then
        Inc(i);
      dt[2] := _ParseNum;
    end
    else
    begin
      dt[2] := dt[1];
      dt[1] := dt[0];
      dt[0] := CurrentYear;
    end;
  end;

  procedure _ParseTimeTail(N: Integer);
  begin
    tm[0] := N;

    if tkns[i] <> dtTimeDelim then
      _Error;
    Inc(i);
    tm[1] := _ParseNum;
    if tkns[i] = dtTimeDelim then
    begin
      Inc(i);
      tm[2] := _ParseNum;
    end;
    if tkns[i] in [dtAM, dtPM] then
    begin
      if (tkns[i] = dtPM) and (tm[0] < 12) then
        Inc(tm[0], 12);
      Inc(i);
    end;
  end;

begin
  // <Date>     ::= "#" <Num> (<DateTail> [<Num> <TimeTail>] |
  //                           <TimeTail> [<Num> <DateTail>]) "#"
  // <DateTail> ::= [<DateDelim>] <Num> [[<DateDelim>] <Num>]
  // <TimeTail> ::= <TimeDelim> <Num> [<TimeDelim> <Num>] [<AM> | <PM>]

  { Tokenize }

  tcnt := 0;
  while tcnt < High(tkns) do
  begin
    SkipBlanks;

    case FCurChar^ of
      '0'..'9':       begin
                        b := FCurChar;
                        while (Ord(FCurChar^) <= 255) and
                              (AnsiChar(FCurChar^) in ['0'..'9']) do
                          NextChar;
                        SetString(sn, b, FCurChar - b);
                        if not TryStrToInt(sn, nums[tcnt]) then
                          _Error;
                        tkns[tcnt] := dtNum;
                        Inc(tcnt);
                      end;
      '/', '-', ',':  begin
                        tkns[tcnt] := dtDateDelim;
                        Inc(tcnt);
                        NextChar;
                      end;
      ':', '.':       begin
                        tkns[tcnt] := dtTimeDelim;
                        Inc(tcnt);
                        NextChar;
                      end;
      'a', 'A':       begin
                        NextChar;
                        if (FCurChar^ <> 'm') and (FCurChar^ <> 'M') then
                          _Error;
                        tkns[tcnt] := dtAM;
                        Inc(tcnt);
                        NextChar;
                      end;
      'p', 'P':       begin
                        NextChar;
                        if (FCurChar^ <> 'm') and (FCurChar^ <> 'M') then
                          _Error;
                        tkns[tcnt] := dtPM;
                        Inc(tcnt);
                        NextChar;
                      end;
      '#':            begin
                        tkns[tcnt] := dtEnd;
                        Inc(tcnt);
                        NextChar;
                        Break; // while
                      end;
    else
      _Error;
    end;
  end;

  tkns[tcnt] := dtInvalid;
  i          := 0;

  { Parse }

  FillChar(dt, SizeOf(dt), 0);
  FillChar(tm, SizeOf(tm), 0);

  n := _ParseNum;
  if tkns[i] = dtTimeDelim then
  begin
    _ParseTimeTail(n);
    if tkns[i] = dtNum then
    begin
      n := _ParseNum;
      _ParseDateTail(n);
    end;
  end
  else
  begin
    _ParseDateTail(n);
    if tkns[i] = dtNum then
    begin
      n := _ParseNum;
      _ParseTimeTail(n);
    end;
  end;
  if tkns[i] <> dtEnd then
    _Error;

  // Despite MS VBScript has VERY complex rules to determine the order
  // of Year, Month and Day parts, we ommit it for now and supports only
  // yyyy-mm-dd ISO order.

  if dt[0] <= 29 then
    dt[0] := dt[0] + 2000
  else if dt[0] <= 99 then
    dt[0] := dt[0] + 1900;

  if not TryEncodeDate(dt[0], dt[1], dt[2], val) then
    _Error;
  ADate := val;
  if not TryEncodeTime(tm[0], tm[1], tm[2], 0, val) then
    _Error;
  ADate := ADate + val;

  Result := ptCDate;
end;

{ ---------------------------------------------------------------------------- }

function TVBScanner.ScanIdentifier: WideString;
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

function TVBScanner.ScanString: WideString;
var
  idx, cap: Integer;
begin
  idx := 1;
  cap := 16;
  SetLength(Result, cap);

  NextChar; // Skip quote.

  while True do
  begin
    if (Ord(FCurChar^) <= 255) and (AnsiChar(FCurChar^) in [#0, #13, #10]) then
      raise ELMDVbCompiler.Create(SLMDUnterminatedStr, GetCurCharPos - 1);

    if FCurChar^ = '"' then // In case of double quote, leave the
                            // position at the second quote char.
    begin
      NextChar;
      if FCurChar^ <> '"' then
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

  SetLength(Result, idx - 1);
end;

{ ---------------------------------------------------------------------------- }

function TVBScanner.DetectReservedWord(const Token: WideString): TLMDVbToken;
var
  i: TLMDVbToken;
begin
  for i := Low(LMDVbTokens) to High(LMDVbTokens) do
    with LMDVbTokens[i] do
      if IsKeyword and SameText(S, Token) then
      begin
        Result := i;
        Exit;
      end;
  Result := ptIdentifier;
end;

{ ---------------------------------------------------------------------------- }

procedure TVBScanner.NextToken;
begin
  while True do
  begin
    SkipBlanks;
    if (FCurChar <> nil) and (FCurChar^ <> #0) then
      ScanToken
    else
    begin
      if not FLastEOlSkipped then
      begin
        FToken          := ptEOl;
        FLastEOlSkipped := True;
      end
      else
        FToken := ptEOf;

      FTokenStartPos := GetCurCharPos;
      FTokenEndPos   := GetCurCharPos;
    end;

    if (not FSkipComments or (FToken <> ptComment)) and
       (FToken <> ptHiddenEOl) then
      Break;
  end;
end;

{ --------------------------------- public ----------------------------------- }

constructor TVBScanner.Create(SkipComments: Boolean);
begin
  inherited Create;
  FSkipComments := SkipComments;
end;

{ ---------------------------------------------------------------------------- }

destructor TVBScanner.Destroy;
begin
  inherited;
end;
                                                     
{ ---------------------------------------------------------------------------- }

function TVBScanner.TokenToStr(Token: TLMDVbToken): WideString;
begin
  Result := '''' + LMDVbTokens[Token].S + '''';
end;
                                                      
{ ---------------------------------------------------------------------------- }

function TVBScanner.GetSavepoint: TLMDVbScannerSavepoint;
begin
  Result := @FSource[TokenStartPos - 1];
end;
                                                        
{ ---------------------------------------------------------------------------- }

procedure TVBScanner.Rollback(const S: TLMDVbScannerSavepoint);
begin
  FCurChar := S;
  NextToken;
end;

{ ---------------------------------------------------------------------------- }

procedure TVBScanner.Start(const Source: WideString);
begin
  FStrSource      := Source;
  FSource         := PWideChar(FStrSource);
  FCurChar        := FSource;
  FLastEOlSkipped := False;
  NextToken;
end;
                                                  
{ ---------------------------------------------------------------------------- }

procedure TVBScanner.SkipToken;
begin
  NextToken;
end;

{*************************** TLMDVbExpressionStmt *****************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVbExpressionStmt.Create(AExpr: TLMDVbExpression);
begin
  inherited Create;
  FExpr:= AExpr;
end;

destructor TLMDVbExpressionStmt.Destroy;
begin
  FExpr.Free;
  inherited;
end;

procedure TLMDVbExpressionStmt.DoEmitByteCode(var C: TLMDContext);
begin
  FExpr.EmitByteCode(C, erNoRes);
end;

{******************************* TLMDVbCall ***********************************}
{ ---------------------------------------------------------------------------- }
procedure TLMDVbDesignatorItem.ClearArgs;
var
  i:Integer;
begin
  for i := 0 to FArgs.Count - 1 do
    TLMDVbExpression(FArgs[i]).Free;
end;

constructor TLMDVbDesignatorItem.Create;
begin
  inherited;
  FArgs         := TList.Create;
  FName         := -1;
  FIsResultUsed := True;
end;

destructor TLMDVbDesignatorItem.Destroy;
begin
  ClearArgs;
  FArgs.Free;
  inherited;
end;

procedure TLMDVbDesignatorItem.EmitArgs(var C: TLMDContext);
var
  i: Integer;
begin
  for i := 0 to FArgs.Count - 1 do
    TLMDVbExpression(FArgs[i]).EmitRefByteCode(C);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbDesignatorItem.SetName(AName: Integer;
  const AStrName: WideString);
begin
  FName    := AName;
  FStrName := AStrName;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbDesignatorItem.AddArgument(AExpression: TLMDVbExpression);
begin
  FArgs.Add(AExpression);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbDesignatorItem.GetArg(AIndex: Integer): TLMDVbExpression;
begin
  Result := FArgs[AIndex];
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbDesignatorItem.GetArgsCount: Integer;
begin
  Result := FArgs.Count;
end;

function TLMDVbDesignatorItem.GetIsNamed: Boolean;
begin
  Result := (FStrName <> '');
end;

{**************************** TLMDVbDesignatorExpr ****************************}
{ ---------------------------------------------------------------------------- }

procedure TLMDVbDesignatorExpr.ClearItems;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TObject(FItems[i]).Free;
end;

constructor TLMDVbDesignatorExpr.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

constructor TLMDVbDesignatorExpr.CreateSimple(AName: Integer;
  const AStrName: WideString; ASourcePos: Integer);
begin
  Create;

  FSourcePos := ASourcePos;
  AddItem;

  LastItem.FName      := AName;
  LastItem.FStrName   := AStrName;
  LastItem.FSourcePos := ASourcePos;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbDesignatorExpr.Destroy;
begin
 ClearItems;
 FItems.Free;
 inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbDesignatorExpr.DoEmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel; var AResInStack: Boolean);
begin
  if AEmitRes = erNoRes then
    Items[ItemCount - 1].FIsResultUsed := False;
  InternalEmit(C, False);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbDesignatorExpr.DoEmitRefByteCode(var C: TLMDContext);
begin
  InternalEmit(C, True);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbDesignatorExpr.AddItem;
begin
  FItems.Add(TLMDVbDesignatorItem.Create);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbDesignatorExpr.GetLastItem: TLMDVbDesignatorItem;
begin
  Result := Items[GeItemCount-1];
end;

procedure TLMDVbDesignatorExpr.InternalEmit(var C: TLMDContext;
  ANeedRef: Boolean; AGetInstrProc: TLMDVbGetCallInstr;
  AEmitValueProc: TLMDVbEmitValue);
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

function TLMDVbDesignatorExpr.OptimizeCallInstr(var C: TLMDContext;
  AItem: TLMDVbDesignatorItem; ACallInstr: TLMDInstrCode; AHasObject,
  AHasValue: Boolean; out ANeedSlot: Boolean): TLMDInstr;
const
  GlobCallOptmz: array[TLMDVbProcLocalType] of TLMDInstrCode = (
    icPushLocalVar, icPushResult, icPushArg
  );
  GlobCallRefOptmz: array[TLMDVbProcLocalType] of TLMDInstrCode = (
    icPushLocalVarRef, icPushResultRef, icPushArgRef
  );
  AsgnGlobCallOptmz: array[TLMDVbProcLocalType] of TLMDInstrCode = (
    icAssignLocalVar, icAssignResult, icAssignArg
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
  ltp:  TLMDVbProcLocalType;
begin
  if (AItem.BracketType = bkNon) and (C.CurNamespace <> nil) then
  begin
    sres := C.CurNamespace.CompileTimeFind(AItem.Name);

    case sres.ObjKind of
      srLocalVar:   ltp := ltVar;
      srResult:     ltp := ltResult;
      srParam:      ltp := ltParam;
    else
      ltp := TLMDVbProcLocalType(-1);
    end;

    if ltp <> TLMDVbProcLocalType(-1) then
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
      else
        // Do nothing. Member/unnamed
        // calls can't be optimized.
      end;
    end;
  end;

  ANeedSlot   := True;
  Result.Code := ACallInstr;
  Result.Data := C.Code.AddCall(AItem.Name, AItem.StrName, AItem.BracketType,
                                AItem.ArgCount, AHasObject, AHasValue,
                                AItem.IsResultUsed);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbDesignatorExpr.GetItems(AIndex: Integer): TLMDVbDesignatorItem;
begin
  Result := FItems[AIndex];
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbDesignatorExpr.GeItemCount: Integer;
begin
  Result := FItems.Count;
end;

{***************************** TLMDVbUnaryOpExpr ******************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVbUnaryOpExpr.Create(OpType: TLMDVbUnaryOp;
  Operand: TLMDVbExpression);
begin
  inherited Create;
  FOpType  := OpType;
  FOperand := Operand;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbUnaryOpExpr.Destroy;
begin
  FOperand.Free;
  inherited;
end;

procedure TLMDVbUnaryOpExpr.DoEmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel; var AResInStack: Boolean);
begin
  case FOpType of
    uoPlus:
    begin
      FOperand.EmitByteCode(C);
      C.Code.Emit(icUnaryPlus);
    end;
    uoMinus:
    begin
      FOperand.EmitByteCode(C);
      C.Code.Emit(icUnaryMinus);
    end;
    uoNot:
    begin
      case AEmitRes of
        erPopJmpIfTrue:   begin
                            FOperand.EmitByteCode(C, erPopJmpIfFalse,
                                                  AJmpLabel);
                            AResInStack := False; // Result already in
                                                  // correct place.
                          end;
        erPopJmpIfFalse:  begin
                            FOperand.EmitByteCode(C, erPopJmpIfTrue,
                                                  AJmpLabel);
                            AResInStack := False; // Result already in
                                                  // correct place.
                          end;
      else
        FOperand.EmitByteCode(C);
        C.Code.Emit(icUnaryNot);
      end;
    end;
  else
    Assert(False);
  end;
end;

{***************************** TLMDVbBinaryOpExpr *****************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVbBinaryOpExpr.Create(ALeftExpr: TLMDVbExpression;
  ARightExpr: TLMDVbExpression; OpType: TLMDVbBinaryOp);
begin
  inherited Create;
  FLeftExpr  := ALeftExpr;
  FRightExpr := ARightExpr;
  FOpType    := OpType;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDVbBinaryOpExpr.Destroy;
begin
  FLeftExpr.Free;
  FRightExpr.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDVbBinaryOpExpr.DoEmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel; var AResInStack: Boolean);
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
  if not (FOpType in [boOr, boAnd]) then
  begin
    FLeftExpr.EmitByteCode(C);
    FRightExpr.EmitByteCode(C);
  end;

  case FOpType of
    boPlus:           C.Code.Emit(icPlus);
    boMinus:          C.Code.Emit(icMinus);
    boMult:           C.Code.Emit(icMultiply);
    boDivide:         C.Code.Emit(icDivide);
    boIntDivide:      C.Code.Emit(icIntDiv);
    boImp:            C.Code.Emit(icImp);
    boEqv:            C.Code.Emit(icEqv);
    boXor:            C.Code.Emit(icXor);
    boOr:             begin
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
    boAnd:            begin
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
    boGreater:        C.Code.Emit(icGreater);
    boGreaterEqual:   C.Code.Emit(icGreaterEqual);
    boLess:           C.Code.Emit(icLess);
    boLessEqual:      C.Code.Emit(icLessEqual);
    boEqual:          begin
                        if AEmitRes = erPopJmpIfTrue then
                        begin
                          C.Code.Emit(icPopJmpIfEqual, AJmpLabel);
                          AResInStack := False; // Result already in
                                                // correct place.
                        end
                        else
                          C.Code.Emit(icEqual);
                      end;
    boNotEqual:       begin
                        if AEmitRes = erPopJmpIfTrue then
                        begin
                          C.Code.Emit(icPopJmpIfNotEqual, AJmpLabel);
                          AResInStack := False; // Result already in
                                                // correct place.
                        end
                        else
                          C.Code.Emit(icNotEqual);
                      end;
    boStrConcat:      C.Code.Emit(icStrConcat);
    boMod:            C.Code.Emit(icMod);
    boExp:            C.Code.Emit(icPower);
    boIs:             C.Code.Emit(icRefEqual);
    boIsNot:          C.Code.Emit(icRefNotEqual);
    boTypeOfIs:       C.Code.Emit(icIs);
  else
    Assert(False);
  end;
end;

{************************* TLMDVbLiteralExpr **********************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVbLiteralExpr.Create(Value: OleVariant);
begin
  inherited Create;
  FValue:= Value;
end;

{**************************** TLMDVbCaseBlock *********************************}
{ ---------------------------------------------------------------------------- }

procedure TLMDVbCaseSelector.AddLabel(AExpr: TLMDVbExpression);
begin
  FLabels.Add(AExpr);
end;

constructor TLMDVbCaseSelector.Create;
begin
  inherited Create;

  FLabels := TList.Create;
  FStmts  := TLMDVbStmtList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbCaseSelector.Destroy;
var
  i: Integer;
begin
  for i := 0 to FLabels.Count - 1 do
    TObject(FLabels[i]).Free;
  FLabels.Free;
  FStmts.Free;
  inherited;
end;

function TLMDVbCaseSelector.GetLabelCount: Integer;
begin
  Result := FLabels.Count;
end;

function TLMDVbCaseSelector.GetLabels(AIndex: Integer): TLMDVbExpression;
begin
  Result := TLMDVbExpression(FLabels[AIndex]);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDVbSelectStmt.Create;
begin
  inherited Create;

  FExpr      := nil;
  FSelectors := TList.Create;
  FElseStmts := TLMDVbStmtList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbSelectStmt.Destroy;
var
  i: Integer;
begin
  for i := 0 to FSelectors.Count - 1 do
    TObject(FSelectors.Items[i]).Free;
  FSelectors.Free;
  FElseStmts.Free;
  FExpr.Free;
  inherited;
end;

procedure TLMDVbSelectStmt.DoEmitByteCode(var C: TLMDContext);
var
  i, j:  Integer;
  endL:  TLMDLabel;
  elseL: TLMDLabel;
  stmtL: array of TLMDLabel;
  slcr:  TLMDVbCaseSelector;
begin
  endL  := C.Code.CreateLabel;
  elseL := C.Code.CreateLabel;
  SetLength(stmtL, FSelectors.Count);
  for i := 0 to High(stmtL) do
    stmtL[i] := C.Code.CreateLabel;

  FExpr.EmitByteCode(C);

  for i := 0 to FSelectors.Count - 1 do
  begin
    slcr := TLMDVbCaseSelector(FSelectors[i]);

    for j := 0 to slcr.LabelCount - 1 do
    begin
      slcr.Labels[j].EmitByteCode(C);
      C.Code.Emit(icCaseJmpIfEqual, stmtL[i]);
    end;
  end;

  C.Code.Emit(icPop);
  C.Code.Emit(icJump, elseL);

  for i := 0 to FSelectors.Count - 1 do
  begin
    slcr := TLMDVbCaseSelector(FSelectors[i]);

    C.Code.BindLabel(stmtL[i]);
    slcr.FStmts.EmitByteCode(C);
    C.Code.Emit(icJump, endL);
  end;

  C.Code.BindLabel(elseL);
  FElseStmts.EmitByteCode(C);
  C.Code.BindLabel(endL);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbSelectStmt.GetSelectors(AIndex: Integer): TLMDVbCaseSelector;
begin
  Result := TLMDVbCaseSelector(FSelectors.Items[AIndex]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbSelectStmt.GetSelectorCount: Integer;
begin
  Result := FSelectors.Count;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbSelectStmt.AddSelector(ASelector: TLMDVbCaseSelector);
begin
  FSelectors.Add(ASelector);
end;

{**************************** TLMDVbDimVarDecl ********************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVbDimVarDecl.Create(AIdentifier: Integer);
begin
  inherited Create;

  FIdentifier := AIdentifier;
  FArrayDims  := TList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbDimVarDecl.Destroy;
var
  i: Integer;
begin
  for i :=0 to ArrayDimCount - 1 do
    TObject(FArrayDims[i]).Free;
  FArrayDims.Free;
  FIniter.Free;
  inherited;
end;

procedure TLMDVbDimVarDecl.EmitArrayDims(var C: TLMDContext);
var
  i: Integer;
begin
  for i := 0 to ArrayDimCount - 1 do
  begin
    C.Code.Emit(icPush0);         // Low bound, always zero in Vb.
    ArrayDims[i].EmitByteCode(C); // High bound.
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbDimVarDecl.AddArrayDim(AExpr: TLMDVbExpression);
begin
  FArrayDims.Add(AExpr);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbDimVarDecl.GetArrayDims(AIndex: Integer): TLMDVbExpression;
begin
  Result := TLMDVbExpression(FArrayDims[AIndex]);
end;

function TLMDVbDimVarDecl.GetArrayDimCount: Integer;
begin
  Result := FArrayDims.Count;
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDVbDimStmt.Create;
begin
  inherited Create;
  FVarDecls := TList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbDimStmt.Destroy;
var
  i: Integer;
begin
  for i := 0 to FVarDecls.Count - 1 do
    TObject(FVarDecls[i]).Free;
  FVarDecls.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbDimStmt.AddVarDecl(AVarDecl: TLMDVbDimVarDecl);
begin
  FVarDecls.Add(AVarDecl);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbDimStmt.GetVarDecls(AIndex: Integer): TLMDVbDimVarDecl;
begin
  Result := TLMDVbDimVarDecl(FVarDecls[AIndex]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbDimStmt.GetVarDeclCount: Integer;
begin
  Result := FVarDecls.Count;
end;

{******************************* TLMDVbCallStmt *******************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVbCallStmt.Create(Designator: TLMDVbDesignatorExpr);
begin
  inherited Create;
  FDesignator := Designator;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbCallStmt.Destroy;
begin
  FDesignator.Free;
  inherited;
end;

procedure TLMDVbCallStmt.DoEmitByteCode(var C: TLMDContext);
begin
  if FDesignator.LastItem.FBracketType = bkNon then
    FDesignator.LastItem.FBracketType := bkVbRound;
  FDesignator.EmitByteCode(C, erNoRes);
end;

{******************************* TLMDVbExitStmt *******************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVbExitStmt.Create(ExitType: TLMDVbExitType);
begin
  inherited Create;
  FExitType := ExitType;
end;

{****************************** TLMDVbRedimStmt *******************************}
{ ---------------------------------------------------------------------------- }

procedure TLMDVbRedimStmt.AddVarDecl(AVarDecl: TLMDVbRedimVarDecl);
begin
  FVarDecls.Add(AVarDecl);
end;

constructor TLMDVbRedimStmt.Create(APreserve: Boolean);
begin
  inherited Create;
  FPreserve := APreserve;
  FVarDecls := TList.Create;
end;

{*************************** TLMDVbAssignmentStmt *****************************}
{ ---------------------------------------------------------------------------- }

function TLMDVbAssignmentStmt.AsgnCallInstrProc(var C: TLMDContext;
  AItem: TLMDVbDesignatorItem; out AInstr: TLMDInstr;
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

destructor TLMDVbAssignmentStmt.Destroy;
begin
  FLeftExpr.Free;
  FRightExpr.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDVbAssignmentStmt.DoEmitByteCode(var C: TLMDContext);
begin
  FLeftExpr.InternalEmit(C, False, AsgnCallInstrProc,
                         EmitValueProc);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDVbAssignmentStmt.EmitValueProc(var C: TLMDContext;
  AItem: TLMDVbDesignatorItem);
begin
  if AItem = FLeftExpr.LastItem then
    FRightExpr.EmitByteCode(C);
end;

{******************************* TLMDVbIfBlock ********************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVbIfBlock.Create(Condition: TLMDVbExpression);
begin
  inherited Create;
  FCondition := Condition;
  FStmtList  := TLMDVbStmtList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbIfBlock.Destroy;
begin
  FCondition.Free;
  FStmtList.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDVbIfStmt.Create;
begin
  inherited Create;

  FBlocks       := TList.Create;
  FElseStmtList := TLMDVbStmtList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbIfStmt.Destroy;
var
  i: Integer;
begin
  for i := 0 to FBlocks.Count - 1 do
    TObject(FBlocks.Items[i]).Free;
  FBlocks.Free;
  FElseStmtList.Free;
  inherited;
end;

procedure TLMDVbIfStmt.DoEmitByteCode(var C: TLMDContext);
var
  skipL:   TLMDLabel;
  endL:    TLMDLabel;
  i:       Integer;
  block:   TLMDVbIfBlock;
  haselse: Boolean;
begin
  skipL   := nil;
  endL    := nil;
  haselse := (FElseStmtList.Count > 0);

  for i := 0 to FBlocks.Count - 1 do
  begin
    if skipL <> nil then
      C.Code.BindLabel(skipL);

    block := TLMDVbIfBlock(FBlocks[i]);
    skipL := C.Code.CreateLabel;

    C.Code.SetNextInstrBreakable;
    block.FCondition.EmitByteCode(C, erPopJmpIfFalse, skipL);
    block.FStmtList.EmitByteCode(C);

    if (i <> FBlocks.Count - 1) or haselse then
    begin
      if endL = nil then
        endL := C.Code.CreateLabel;
      C.Code.Emit(icJump, endL);
    end;
  end;

  if skipL <> nil then
    C.Code.BindLabel(skipL);
  if haselse then
    FElseStmtList.EmitByteCode(C);
  if endL <> nil then
    C.Code.BindLabel(endL);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbIfStmt.AddBlock(Condition: TLMDVbExpression);
begin
  FBlocks.Add(TLMDVbIfBlock.Create(Condition));
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbIfStmt.GetLastBlock: TLMDVbIfBlock;
begin
  Result := Blocks[BlocksCount - 1];
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbIfStmt.GetIfBlock(AIndex: Integer): TLMDVbIfBlock;
begin
  Result := TLMDVbIfBlock(FBlocks[AIndex]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbIfStmt.GetIfBlocksCount: INteger;
begin
  Result := FBlocks.Count;
end;

{******************************** TLMDVbForStmt *******************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVbForStmt.Create;
begin
  inherited Create;
  FStmts := TLMDVbStmtList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbForStmt.Destroy;
begin
  FVarExpr.Free;
  FFromExpr.Free;
  FToExpr.Free;
  FStepExpr.Free;
  FStmts.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbForStmt.DoEmitByteCode(var C: TLMDContext);
const
  INCCMDS: array[Boolean] of TLMDInstrCode = (icForInc, icForIncStep);
  JMPCMDS: array[Boolean] of TLMDInstrCode = (icForJmpIfLE, icForJmpStep);
var
  L1, L2:    TLMDLabel;
  for_:      TLMDFor;
  oldext:    TLMDExitLabels;
  sres:      TLMDNameSearchRes;
  hasstep:   Boolean;
  varnm:     Integer;
  varsnm:     WideString;
begin
  hasstep := (FStepExpr <> nil);
  L1      := C.Code.CreateLabel;
  L2      := C.Code.CreateLabel;

  oldext          := C.CurExits;
  C.CurExits.ForL := C.Code.CreateLabel;

  varnm        := FVarExpr.Items[0].Name;
  varsnm       := FVarExpr.Items[0].StrName;
  sres.ObjKind := srNotFound;
  if C.CurNamespace <> nil then
    sres := C.CurNamespace.CompileTimeFind(varnm);

  if sres.ObjKind = srLocalVar then
  begin
    for_ := C.Code.AddFor(L1, sres.LocalVarIndex, hasstep);

    FFromExpr.EmitByteCode(C);
    C.Code.Emit(icForInitLocal, for_); // Counter var.
  end
  else
  begin
    for_ := C.Code.AddFor(L1, hasstep);

    FVarExpr.EmitRefByteCode(C);
    FFromExpr.EmitByteCode(C);
    C.Code.Emit(icForInitLValue, for_); // Counter var.
  end;

  FToExpr.EmitByteCode(C);
  C.Code.Emit(icAssignLocalVar, TObject(for_.ToVar));

  if FStepExpr <> nil then
  begin
    FStepExpr.EmitByteCode(C);
    C.Code.Emit(icAssignLocalVar, TObject(for_.StepVar));
  end;

  C.Code.Emit(icJump, L2);

  C.Code.BindLabel(L1);
  FStmts.EmitByteCode(C);

  C.Code.Emit(INCCMDS[hasstep], for_);

  C.Code.BindLabel(L2);
  C.Code.SetNextInstrBreakable;
  C.Code.Emit(JMPCMDS[hasstep], for_);
  C.Code.BindLabel(C.CurExits.ForL);

  C.CurExits := oldext;
end;

{******************************* TLMDVbDoLoopStmt *****************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVbDoLoopStmt.Create;
begin
  inherited Create;

  FCondCheck := ccNoCondition;
  FExpr      := nil;
  FStmts     := TLMDVbStmtList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbDoLoopStmt.Destroy;
begin
  FExpr.Free;
  FStmts.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbDoLoopStmt.DoEmitByteCode(var C: TLMDContext);
const
  EXPR_RESS: array[TLMDVbLoopType] of TLMDExprEmitRes = (
    erPopJmpIfTrue, // ltWhile
    erPopJmpIfFalse // ltUntil
  );
var
  exprL, stmtsL: TLMDLabel;
  oldext: TLMDExitLabels;
begin
  exprL  := C.Code.CreateLabel;
  stmtsL := C.Code.CreateLabel;

  oldext         := C.CurExits;
  C.CurExits.DoL := C.Code.CreateLabel;

  if FCondCheck = ccBeforeStmts then
    C.Code.Emit(icJump, exprL);

  C.Code.BindLabel(stmtsL);
  FStmts.EmitByteCode(C);
  C.Code.BindLabel(exprL);

  if FCondCheck = ccNoCondition then
    C.Code.Emit(icJump, stmtsL)
  else
  begin
    C.Code.SetNextInstrBreakable;
    FExpr.EmitByteCode(C, EXPR_RESS[FLoopType], stmtsL);
  end;

  C.Code.BindLabel(C.CurExits.DoL);
  C.CurExits := oldext;
end;

{******************************* TLMDVbStmtList *******************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVbStmtList.Create;
begin
  Create(True);
end;

{ ---------------------------------------------------------------------------- }

destructor  TLMDVbStmtList.Destroy;
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

{ ---------------------------------------------------------------------------- }

procedure TLMDVbStmtList.EmitByteCode(var C: TLMDContext);
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TLMDVbStatement(FItems[i]).EmitByteCode(C);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbStmtList.GetItems(AIndex: Integer): TLMDVbStatement;
begin
  Result := TLMDVbStatement(FItems[AIndex]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbStmtList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbStmtList.Add(Statement: TLMDVbStatement);
begin
  FItems.Add(Statement);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDVbStmtList.Create(AOwnItems: Boolean);
begin
  inherited Create;
  FOwnItems := AOwnItems;
  FItems    := TList.Create;
end;

{**************************** TLMDVbProcDecl **********************************}
{ ---------------------------------------------------------------------------- }

constructor TLMDVbProcDecl.Create(AName: Integer; const AStrName: WideString;
  AProcKind: TLMDVbProcKind);
begin
  inherited Create(AName, AStrName);

  FProcKind       := AProcKind;
  FLocalMap       := TLMDNameHashTable.Create(True);
  FParams         := TList.Create;
  FLocalVars      := TList.Create;
  FLocalNamespace := nil;
  FStmtList       := TLMDVbStmtList.Create;
  ResMask         := $FFFFFFFF * DWORD(Ord(AProcKind = pkFunction));
end;

function TLMDVbProcDecl.CreateNS(
  AParent: TLMDAbstractNamespace): TLMDAbstractNamespace;
begin
  Assert(FLocalNamespace = nil); // Need a list of namespaces to
                                 // properly free them.
  FLocalNamespace := TLMDVbProcLocalNamespace.Create(AParent, Self);
  Result          := FLocalNamespace;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbProcDecl.Destroy;
begin
  FLocalNamespace.Free;
  FLocalMap.Free; // Clears all children.
  FParams.Free;
  FLocalVars.Free;
  FStmtList.Free;

  inherited;
end;

procedure TLMDVbProcDecl.EmitByteCode(AGlobalNamespace: TLMDAbstractNamespace);
var
  i:     Integer;
  oldsp: Integer;
  ctx:   TLMDContext;
  locns: TLMDAbstractNamespace;
begin
  { Prepare }

  locns := CreateNS(AGlobalNamespace);
  FillChar(ctx, SizeOf(ctx), 0);
  ctx.Code         := ByteCode;
  ctx.CurNamespace := locns;

  { Emit }

  ByteCode.BeginEmit(StrName, locns, FSourcePos);

  for i := 0 to FLocalVars.Count - 1 do
    TLMDVbLocalVarDecl(FLocalVars[i]).FIndex := ByteCode.AddLocalVar;

  for i := 0 to FStmtList.Count - 1 do
    FStmtList[i].EmitByteCode(ctx);

  ByteCode.BeginSourcePos(EndSourcePos, oldsp);
  ByteCode.SetNextInstrBreakable;
  ByteCode.Emit(icRet);
  ByteCode.EndSourcePos(oldsp);
  ByteCode.EndEmit;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbProcDecl.AddLocalItem(AItem: TLMDVbProcLocal): Boolean;
var
  prm: TLMDVbParamDecl;
begin
  if ((AItem.LocalType = ltParam) and (AItem.Name = Name)) or
     not FLocalMap.Add(AItem) then
  begin
    Result := False;
    Exit;
  end;

  case AItem.LocalType of
    ltVar:    begin
                FLocalVars.Add(AItem);
              end;
    ltParam:  begin
                prm                  := TLMDVbParamDecl(AItem);
                prm.FParamInfo.Index := FParams.Add(prm);
                ParamAdded; // Adjust inherited ParamCount.
              end;
    ltResult: FLocalResult := TLMDVbLocalResultDecl(AItem);
  end;

  Result := True;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbProcDecl.GetLocalVarCount: Integer;
begin
  Result := FLocalVars.Count;
end;

function TLMDVbProcDecl.GetLocalVars(AIndex: Integer): TLMDVbLocalVarDecl;
begin
  Result := TLMDVbLocalVarDecl(FLocalVars[AIndex]);
end;

function TLMDVbProcDecl.GetParams(AIndex: Integer): TLMDVbParamDecl;
begin
  Result := TLMDVbParamDecl(FParams[AIndex]);
end;

{****************************** TLMDVbParser **********************************}
{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.CheckAndSkipTokens(
  ATokens: TLMDVbTokens);
begin
  CheckTokens(ATokens);
  SkipToken;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.CheckTokens(ATokens: TLMDVbTokens);
begin
  if not (FScanner.Token in ATokens) then
    InvalidTokenError(FScanner.Token);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDVbParser.Create(ACbs: ILMDParserCallbacks);
begin
  inherited Create;
  FCbs     := ACbs;
  FScanner := TVBScanner.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbParser.Destroy;
begin
  FScanner.Free;
  inherited;
end;

function TLMDVbParser.DoAddDimVar(AName: Integer;
  const AStrName: WideString): TObject;
var
  lvar: TLMDVbLocalVarDecl;
  gvar: TLMDVarObject;
begin
  if FCurrentProc <> nil then
  begin
    lvar := TLMDVbLocalVarDecl.Create(AName, AStrName);
    try
      DoAddProcLocal(lvar, FCurrentProc);
      Result := lvar;
    except
      lvar.Free;
      raise;
    end;
  end
  else
  begin
    gvar := TLMDVarObject.Create(AName, AStrName);
    try
      DoAddGlobalObject(gvar);
      Result := gvar;
    except
      gvar.Free;
      raise;
    end;
  end;
end;

procedure TLMDVbParser.DoAddGlobalObject(AObj: TLMDGlobalObject);
var
  dupnm: Boolean;
begin
  FCbs.GlobalObjParsed(AObj, dupnm);
  if dupnm then
    raise ELMDVbCompiler.CreateFmt(SLMDDuplicateNamedItem, [AObj.StrName],
                                   FLastSkippedPos);
end;

procedure TLMDVbParser.DoAddProcLocal(AItem: TLMDVbProcLocal;
  AProc: TLMDVbProcDecl);
var
  added: Boolean;
begin
  added := AProc.AddLocalItem(AItem);
  if not added then
    raise ELMDVbCompiler.CreateFmt(SLMDDuplicateNamedItem, [AItem.StrName],
                                   FLastSkippedPos);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.GetCurToken: TLMDVbToken;
begin
  Result := FScanner.Token;
end;

function TLMDVbParser.GetSavepoint: TLMDVbParserSavepoint;
begin
  Result.ScannerSP        := FScanner.GetSavepoint;
  Result.LastSkippedPos   := FLastSkippedPos;
  Result.CurrentProc      := FCurrentProc;
  Result.ExitPntCounts    := FExitPntCounts;
  Result.OnlyColonBRCount := FOnlyColonBRCount;
  Result.TryState         := FTryState;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.InvalidTokenError(AToken: TLMDVbToken);
begin
  raise ELMDVbCompiler.CreateFmt(SInvalidToken,
                                 [FScanner.TokenToStr(AToken)],
                                 FScanner.TokenEndPos);
end;

function TLMDVbParser.IsBR: Boolean;
begin
  Result := ((FOnlyColonBRCount = 0) and (CurToken = ptEOl)) or
            (CurToken = ptColon);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.StrExpectedError(const AStr: string);
begin
  raise ELMDVbCompiler.CreateFmt(SStrExpected, [AStr],
                                 FScanner.TokenEndPos);
end;

function TLMDVbParser.VbNothing: OleVariant;
var
  d: IDispatch;
begin
  d      := nil;
  Result := d;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.SkipToken;
begin
  FLastSkippedPos := FScanner.TokenEndPos;
  FScanner.SkipToken;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.Parse(const ASource: WideString);
begin
  FScanner.Start(ASource);
  ParseUnit;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.ParseUnit;
begin
  if IsBR then
    ParseBR;
  while CurToken in DeclTokens do
    ParseDecl;
  CheckAndSkipTokens([ptEOf]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.ParseDecl;
var
  stmts: TLMDVbStmtList;
  i:     Integer;
begin
  while CurToken in (StmtListTokens + FuncDeclTokens + SubDeclTokens) do
  begin
    if CurToken in StmtListTokens then
    begin
      stmts := TLMDVbStmtList.Create(False);
      try
        ParseStmtList(stmts);
        for i := 0 to stmts.Count - 1 do
          FCbs.GlobalStmtParsed(stmts[i]);
      finally
        stmts.Free;
      end;
    end
    else if CurToken in (SubDeclTokens + FuncDeclTokens) then
      ParseProcDecl;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseStatement: TLMDVbStatement;
begin
  CheckTokens(StatementTokens);

  if CurToken in ExprStmtTokens then
    Result := ParseExprStmt
  else if CurToken in SetStmtTokens then
    Result := ParseSetStmt
  else if CurToken in EraseStmtTokens then
    Result := ParseEraseStmt
  else if CurToken in CallStmtTokens then
    Result := ParseCallStmt
  else if CurToken in ExitStmtTokens then
    Result := ParseExitStmt
  else if CurToken in DimStmtTokens then
    Result := ParseDimStmt
  else if CurToken in RedimStmtTokens then
    Result := ParseRedimStmt
  else if CurToken in ForStmtTokens then
    Result := ParseForStmt
  else if CurToken in IfStmtTokens then
    Result := ParseIfStmt
  else if CurToken in DoLoopStmtTokens then
    Result := ParseDoLoopStmt
  else if CurToken in SelectStmtTokens then
    Result := ParseSelectStmt
  else if CurToken in ThrowStmtTokens then
    Result := ParseThrowStmt
  else if CurToken in ReturnStmtTokens then
    Result := ParseReturnStmt
  else
    Result := ParseTryStmt;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseStmt(const ASource: WideString): ILMDEmitable;
begin
  FScanner.Start(ASource);
  Result := ParseStatement;
  try
    CheckAndSkipTokens([ptEOl]);
    CheckAndSkipTokens([ptEOf]);
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.ParseStmtList(StmtList: TLMDVbStmtList);
begin
  while CurToken in StatementTokens do
  begin
    StmtList.Add(ParseStatement);
    if (FOnlyColonBRCount <> 0) and (CurToken = ptEOl) then
      Break; // Do not skip EOl.
    ParseBR;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseThrowStmt: TLMDVbThrowStmt;
begin
  Result := TLMDVbThrowStmt.Create;
  try
    CheckAndSkipTokens([ptThrow]);
    Result.FSourcePos := FLastSkippedPos;

    if CurToken in ExprTokens then
      Result.FExpr := ParseExpression
    else if FTryState <> ptsInCatch then
      raise ELMDVbCompiler.Create(SLMDParserReRaise, FLastSkippedPos);
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseTryStmt: TLMDVbTryStmt;

  function _TestCatchAs: Boolean;
  var
    sp: TLMDVbParserSavepoint;
  begin
    Result := False;

    if CurToken in IdentifierTokens then
    begin
      sp := GetSavepoint;
      ParseIdentifier;
      Result := (CurToken = ptAs);
      Rollback(sp);
    end;
  end;

var
  haselse: Boolean;
  vnm:     Integer;
  s:       WideString;
  ctch:    TLMDVbCatch;
  olsts:   TLMDVbParserTryState;
begin
  olsts  := FTryState;
  Result := TLMDVbTryStmt.Create;
  try
    Result.FSourcePos := FScanner.TokenStartPos;
    CheckAndSkipTokens([ptTry]);
    ParseBR;

    FTryState := ptsInTry;
    ParseStmtList(Result.FTryStmts);

    haselse := False;
    while (CurToken = ptCatch) and not haselse do
    begin
      SkipToken;
      ctch := nil;
      try
        if _TestCatchAs then
        begin
          vnm  := ParseIdentifier(s);
          ctch := TLMDVbCatch.Create(vnm, s);

          CheckAndSkipTokens([ptAs]);
          ctch.FExpr := ParseExpression;
        end
        else
        begin
          haselse := True;
          ctch    := TLMDVbCatch.Create;
        end;

        ParseBR;
        FTryState := ptsInCatch;
        ParseStmtList(ctch.FStmts);

        Result.AddCatch(ctch);
      except
        ctch.Free;
        raise;
      end;
    end;

    if (Result.CatchCount = 0) or (CurToken = ptFinally) then
    begin
      CheckAndSkipTokens([ptFinally]);
      ParseBR;

      FTryState := ptsInFinally;
      ParseStmtList(Result.FFinallyStmts);
    end;

    CheckAndSkipTokens([ptEnd]);
    CheckAndSkipTokens([ptTry]);
  except
    Result.Free;
    FTryState := olsts;
    raise;
  end;
  FTryState := olsts;
end;

function TLMDVbParser.ParseTypeOfExpr: TLMDVbExpression;
var
  left, right: TLMDVbExpression;
begin
  if CurToken = ptTypeOf then
  begin
    SkipToken;
    left  := nil;
    right := nil;
    try
      left  := ParseTypeOfExpr;
      CheckAndSkipTokens([ptIs]);
      right := ParseConcatExpr;
    except
      left.Free;
      right.Free;
      raise;
    end;

    Result := TLMDVbBinaryOpExpr.Create(left, right, boTypeOfIs);
  end
  else
    Result := ParseConcatExpr;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.ParseProcDecl;
const
  PROC_KINDS: array[Boolean] of TLMDVbProcKind = (pkFunction, pkSub);
  EXIT_PNT:   array[TLMDVbProcKind] of TLMDVbExitType = (etFunction, etSub);
var
  name:   Integer;
  strnm:  WideString;
  pdecl:  TLMDVbProcDecl;
  pknd:   TLMDVbProcKind;
  spos:   Integer;
  resitm: TLMDVbLocalResultDecl;
begin
  CheckTokens(SubDeclTokens + FuncDeclTokens);
  pknd := PROC_KINDS[CurToken = ptSub];
  SkipToken;

  spos  := FScanner.TokenStartPos;
  name  := ParseIdentifier(strnm);
  pdecl := TLMDVbProcDecl.Create(name, strnm, pknd);
  pdecl.FSourcePos := spos;
  try
    if pknd = pkFunction then
    begin
      // Add Result variable first to prohibit
      // locals with the same name.

      resitm := TLMDVbLocalResultDecl.Create(pdecl.Name, pdecl.StrName);
      pdecl.AddLocalItem(resitm);
    end;

    if CurToken in [ptOpenRound] then
    begin
      SkipToken;
      CheckTokens(ParamListTokens + [ptCloseRound]);
      ParseParamList(pdecl);
      CheckAndSkipTokens([ptCloseRound]);
    end;
    ParseBR;

    FCurrentProc := pdecl;
    Inc(FExitPntCounts[EXIT_PNT[pknd]]);
    try
      CheckTokens(StmtListTokens + [ptEnd]);
      ParseStmtList(pdecl.StmtList);
    finally
      Dec(FExitPntCounts[EXIT_PNT[pknd]]);
      FCurrentProc := nil;
    end;

    CheckAndSkipTokens([ptEnd]);
    case pknd of
      pkFunction: CheckAndSkipTokens([ptFunction]);
      pkSub:      CheckAndSkipTokens([ptSub]);
    end;
    pdecl.FEndSourcePos := FLastSkippedPos;

    ParseBR;
    DoAddGlobalObject(pdecl);
  except
    pdecl.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.ParseParamList(AProcDecl: TLMDVbProcDecl);
var
  prmknd: TLMDParamKind;
  prm:    TLMDVbParamDecl;
  prmnm:  Integer;
  s:      WideString;
begin
  if CurToken in ParamListTokens then
  begin
    prmknd := ParseParamModifier;
    prmnm  := ParseIdentifier(s);
    prm    := TLMDVbParamDecl.Create(prmnm, s, prmknd);
    try
      DoAddProcLocal(prm, AProcDecl);
    except
      prm.Free;
      raise;
    end;

    while CurToken in [ptComma] do
    begin
      SkipToken;
      CheckTokens(ParamListTokens);
      prmknd := ParseParamModifier;
      prmnm  := ParseIdentifier(s);
      prm    := TLMDVbParamDecl.Create(prmnm, s, prmknd);
      try
        DoAddProcLocal(prm, AProcDecl);
      except
        prm.Free;
        raise;
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseParamModifier: TLMDParamKind;
begin
  if CurToken in ParamModifierTokens then
  begin
    if CurToken in [ptByRef] then
    begin
      SkipToken;
      Result := pkByRef;
    end
    else
    begin
      CheckAndSkipTokens([ptByVal]);
      Result := pkSimple;
    end;
  end
  else
    Result := pkByRef;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseDoLoopStmt: TLMDVbDoLoopStmt;
begin
  Result := TLMDVbDoLoopStmt.Create;
  try
    Result.FSourcePos := FScanner.TokenStartPos;
    CheckAndSkipTokens([ptDo]);

    if CurToken in WUExprTokens then
    begin
      Result.FCondCheck := ccBeforeStmts;
      ParseWUExpr(Result);

      if IsBR then
        ParseBR;
      Inc(FExitPntCounts[etDo]);
      try
        CheckTokens(StmtListTokens + [ptLoop]);
        ParseStmtList(Result.Stmts);
      finally
        Dec(FExitPntCounts[etDo]);
      end;

      CheckAndSkipTokens([ptLoop]);
    end
    else
    begin
      ParseBR;
      Inc(FExitPntCounts[etDo]);
      try
        CheckTokens(StmtListTokens + [ptLoop]);
        ParseStmtList(Result.Stmts);
      finally
        Dec(FExitPntCounts[etDo]);
      end;

      CheckAndSkipTokens([ptLoop]);

      if CurToken in WUExprTokens then
      begin
        Result.FCondCheck := ccAfterStmts;
        ParseWUExpr(Result);
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.ParseWUExpr(ADoLoopStmt: TLMDVbDoLoopStmt);
begin
  CheckTokens(WUExprTokens);

  if CurToken in [ptWhile] then
  begin
    SkipToken;
    ADoLoopStmt.FLoopType := ltWhile;
  end
  else
  begin
    CheckAndSkipTokens([ptUntil]);
    ADoLoopStmt.FLoopType := ltUntil;
  end;

  ADoLoopStmt.FExpr := ParseExpression;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseIdentifier(out AStrName: WideString): Integer;
begin
  CheckTokens([ptIdentifier]);

  AStrName := FScanner.SData;
  Result   := FCbs.GetNameId(AStrName);

  SkipToken;
end;

function TLMDVbParser.ParseIfStmt: TLMDVbIfStmt;
begin
  Result            := TLMDVbIfStmt.Create;
  Result.FSourcePos := FScanner.TokenStartPos;
  try
    CheckAndSkipTokens([ptIf]);
    Result.AddBlock(ParseExpression);
    Result.LastBlock.FSourcePos := Result.SourcePos;

    CheckAndSkipTokens([ptThen]);

    if CurToken in StatementTokens then
    begin
      Inc(FOnlyColonBRCount);
      try
        ParseStmtList(Result.LastBlock.StmtList);
        if CurToken in [ptElse] then
        begin
          SkipToken;
          ParseStmtList(Result.ElseStmtList);
        end;
      finally
        Dec(FOnlyColonBRCount);
      end;
    end
    else
    begin
      ParseBR;
      CheckTokens(StmtListTokens + [ptElseIf, ptElse, ptEnd]);
      ParseStmtList(Result.LastBlock.StmtList);

      while CurToken in [ptElseIf] do
      begin
        Result.FSourcePos := FScanner.TokenStartPos;
        CheckAndSkipTokens([ptElseIf]);
        Result.AddBlock(ParseExpression);
        Result.LastBlock.FSourcePos := Result.SourcePos;
        CheckAndSkipTokens([ptThen]);
        ParseBR;
        ParseStmtList(Result.LastBlock.StmtList);
      end;
      if CurToken in [ptElse] then
      begin
        SkipToken;
        ParseBR;
        ParseStmtList(Result.ElseStmtList);
      end;

      CheckAndSkipTokens([ptEnd]);
      CheckAndSkipTokens([ptIf]);
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseForStmt: TLMDVbForStmt;
var
  varnm: Integer;
  s:     WideString;
  spos:  Integer;
begin
  spos := FScanner.TokenStartPos;
  CheckAndSkipTokens([ptFor]);

  Result := TLMDVbForStmt.Create;
  try
    Result.FSourcePos := spos;
    varnm             := ParseIdentifier(s);
    Result.FVarExpr   := TLMDVbDesignatorExpr.CreateSimple(varnm, s, spos);

    CheckAndSkipTokens([ptEqual]);
    Result.FFromExpr := ParseExpression;
    CheckAndSkipTokens([ptTo]);
    Result.FToExpr := ParseExpression;

    if CurToken in [ptStep] then
    begin
      SkipToken;
      Result.FStepExpr := ParseExpression;
    end;

    ParseBR;
    Inc(FExitPntCounts[etFor]);
    try
      CheckTokens(StmtListTokens + [ptNext]);
      ParseStmtList(Result.Stmts);
    finally
      Dec(FExitPntCounts[etFor]);
    end;
    CheckAndSkipTokens([ptNext]);
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseExitStmt: TLMDVbExitStmt;
var
  exttp: TLMDVbExitType;
  spos:  Integer;
begin
  spos := FScanner.TokenStartPos;
  CheckAndSkipTokens([ptExit]);
  CheckTokens([ptFor, ptDo, ptFunction, ptSub]);

  case CurToken of
    ptFor:      exttp := etFor;
    ptDo:       exttp := etDo;
    ptFunction: exttp := etFunction;
  else
    exttp := etSub;
  end;
  if FExitPntCounts[exttp] = 0 then
    StrError(SLMDInvalidExit);
  SkipToken;

  Result            := TLMDVbExitStmt.Create(exttp);
  Result.FSourcePos := spos;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseSelectStmt: TLMDVbSelectStmt;
var
  haselse: Boolean;
  slcr:    TLMDVbCaseSelector;
begin
  Result            := TLMDVbSelectStmt.Create;
  Result.FSourcePos := FScanner.TokenStartPos;

  try
    haselse := False;
    CheckAndSkipTokens([prSelect]);
    CheckAndSkipTokens([ptCase]);
    Result.FExpr := ParseExpression;
    ParseBR;

    CheckTokens([ptCase] + [ptEnd]);

    while (CurToken = ptCase) and not haselse do
    begin
      Result.FSourcePos := FScanner.TokenStartPos;
      SkipToken;

      CheckTokens(ExprTokens + [ptElse]);

      if CurToken in ExprTokens then
      begin
        slcr := TLMDVbCaseSelector.Create;
        try
          slcr.FSourcePos := Result.SourcePos;

          slcr.AddLabel(ParseExpression);
          while CurToken = ptComma do
          begin
            SkipToken;
            slcr.AddLabel(ParseExpression);
          end;

          if IsBR then
            ParseBR;
          ParseStmtList(slcr.StmtList);
        except
          slcr.Free;
          raise;
        end;
        Result.AddSelector(slcr);
      end
      else
      begin
        CheckAndSkipTokens([ptElse]);
        if IsBR then
          ParseBR;
        ParseStmtList(Result.ElseStmts);

        haselse := True;
      end;
    end;

    CheckAndSkipTokens([ptEnd]);
    CheckAndSkipTokens([prSelect]);
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseCallStmt: TLMDVbCallStmt;
var
  spos: Integer;
begin
  spos := FScanner.TokenStartPos;
  CheckAndSkipTokens([ptCall]);

  Result            := TLMDVbCallStmt.Create(ParseDesignator);
  Result.FSourcePos := spos;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseEraseStmt: TLMDVbEraseStmt;
var
  spos: Integer;
begin
  spos := FScanner.TokenStartPos;
  CheckAndSkipTokens([ptErase]);

  Result := TLMDVbEraseStmt.Create;
  try
    Result.FSourcePos := spos;
    Result.FExpr      := ParseDesignator;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseSetStmt: TLMDVbAssignmentStmt;
begin
  CheckAndSkipTokens([ptSet]);
  Result := TLMDVbAssignmentStmt.Create;
  try
    Result.FLeftExpr  := ParseDesignator;
    Result.FSourcePos := FScanner.TokenStartPos;

    CheckAndSkipTokens([ptEqual]);
    Result.FRightExpr := ParseExpression;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseDimStmt: TLMDVbDimStmt;
begin
  Result            := TLMDVbDimStmt.Create;
  Result.FSourcePos := FScanner.TokenStartPos;
  try
    CheckAndSkipTokens([ptDim]);
    Result.AddVarDecl(ParseDimVarDecl);

    while CurToken in [ptComma] do
    begin
      SkipToken;
      Result.AddVarDecl(ParseDimVarDecl);
    end;
  except
    Result.Free;
    raise;
  end;
end;

function TLMDVbParser.ParseRedimVarDecl: TLMDVbRedimVarDecl;
var
  spos:  Integer;
  varnm: Integer;
  s:     WideString;
begin
  spos              := FScanner.TokenStartPos;
  varnm             := ParseIdentifier(s);
  Result            := TLMDVbRedimVarDecl.Create;
  Result.FSourcePos := spos;
  try
    Result.FVarExpr  := TLMDVbDesignatorExpr.CreateSimple(varnm, s, spos);
    Result.FElemType := varVariant;
    CheckAndSkipTokens([ptOpenRound]);

    Result.AddArrayDim(ParseExpression);
    while CurToken in [ptComma] do
    begin
      SkipToken;
      Result.AddArrayDim(ParseExpression);
    end;

    CheckAndSkipTokens([ptCloseRound]);

    if CurToken = ptAs then
    begin
      SkipToken;
      Result.FElemType := ParseArrayType;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseRedimStmt: TLMDVbRedimStmt;
var
  presrv: Boolean;
  spos:   Integer;
begin
  spos := FScanner.TokenStartPos;
  CheckAndSkipTokens([ptRedim]);
  CheckTokens([ptPreserve] + ArrayDeclTokens);

  if CurToken in [ptPreserve] then
  begin
    presrv := True;
    CheckAndSkipTokens([ptPreserve]);
  end
  else
    presrv := False;

  Result            := TLMDVbRedimStmt.Create(presrv);
  Result.FSourcePos := spos;
  try
    Result.AddVarDecl(ParseRedimVarDecl);
    while CurToken in [ptComma] do
    begin
      SkipToken;
      Result.AddVarDecl(ParseRedimVarDecl);
    end;
  except
    Result.Free;
    raise;
  end;
end;

function TLMDVbParser.ParseReturnStmt: TLMDVbReturnStmt;
begin
  CheckAndSkipTokens([ptReturn]);
  Result := TLMDVbReturnStmt.Create;
  try
    if (FCurrentProc <> nil) and
       (FCurrentProc.ProcKind = pkFunction) then
      Result.FExpr := ParseExpression;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseDimVarDecl: TLMDVbDimVarDecl;
var
  spos:  Integer;
  varnm: Integer;
  s:     WideString;
begin
  spos              := FScanner.TokenStartPos;
  varnm             := ParseIdentifier(s);
  Result            := TLMDVbDimVarDecl.Create(varnm);
  Result.FSourcePos := spos;
  try
    Result.FVar      := DoAddDimVar(varnm, s);
    Result.FElemType := varVariant;

    if CurToken = ptOpenRound then
    begin
      CheckAndSkipTokens([ptOpenRound]);
      Result.FIsArray := True;

      if CurToken <> ptCloseRound then
      begin
        Result.AddArrayDim(ParseExpression);
        while CurToken in [ptComma] do
        begin
          SkipToken;
          Result.AddArrayDim(ParseExpression);
        end;
      end;

      CheckAndSkipTokens([ptCloseRound]);

      if CurToken = ptAs then
      begin
        SkipToken;
        Result.FElemType := ParseArrayType;
      end;
    end
    else if CurToken = ptEqual then
    begin
      SkipToken;
      Result.FIniter := ParseExpression;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.ParseArguments(AItem: TLMDVbDesignatorItem;
  out ArgCount: Integer);
begin
  ArgCount := 0;
  CheckAndSkipTokens([ptOpenRound]);

  if CurToken <> ptCloseRound then
  begin
    AItem.AddArgument(ParseExpression);
    Inc(ArgCount);

    while CurToken in [ptComma] do
    begin
      CheckAndSkipTokens([ptComma]);
      AItem.AddArgument(ParseExpression);
      Inc(ArgCount);
    end;
  end;

  CheckAndSkipTokens([ptCloseRound]);
end;

procedure TLMDVbParser.ParseArrayDim(ArrayDecl: TLMDVbDimVarDecl);
begin
  ArrayDecl.AddArrayDim(ParseExpression);
  while CurToken in [ptComma] do
  begin
    SkipToken;
    ArrayDecl.AddArrayDim(ParseExpression);
  end;
end;

function TLMDVbParser.ParseArrayType: TVarType;
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
    raise ELMDVbCompiler.Create(SLMDParserTypeExpected, FLastSkippedPos);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseExprStmt: TLMDVbStatement;
var
  argcnt: Integer;
  hasrnd: Boolean;
  dgntr:  TLMDVbDesignatorExpr;
  spos:   Integer;
begin
  spos   := FScanner.TokenStartPos;
  Result := nil;
  dgntr  := ParseDesignator(argcnt, hasrnd);
  try
    if CurToken in [ptEqual] then
    begin
      spos := FScanner.TokenStartPos;
      CheckAndSkipTokens([ptEqual]);

      Result                                  := TLMDVbAssignmentStmt.Create;
      TLMDVbAssignmentStmt(Result).FLeftExpr  := dgntr;
      TLMDVbAssignmentStmt(Result).FRightExpr := ParseExpression;
      Result.FSourcePos                       := spos;
    end
    else if (CurToken in [ptComma] + ExprTokens) and
            ((argcnt = 1) or not hasrnd) then
    begin
      if not hasrnd then
        dgntr.LastItem.AddArgument(ParseExpression);

      while CurToken in [ptComma] do
      begin
        SkipToken;
        dgntr.LastItem.AddArgument(ParseExpression);
      end;

      Result            := TLMDVbExpressionStmt.Create(dgntr);
      Result.FSourcePos := spos;
    end
    else if argcnt > 1 then
      StrError('Invalid use of parentheses in procedure call.')
    else
    begin
      Result            := TLMDVbExpressionStmt.Create(dgntr);
      Result.FSourcePos := spos;
    end;
  except
    dgntr.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseExpr(const ASource: WideString): ILMDEmitable;
begin
  FScanner.Start(ASource);
  Result := ParseExpression;
  try
    CheckAndSkipTokens([ptEOl]);
    CheckAndSkipTokens([ptEOf]);
  except
    Result.Free;
    raise;
  end;
end;

function TLMDVbParser.ParseExpression: TLMDVbExpression;
var
  child: TLMDVbExpression;
  spos:  Integer;
begin
  Result := ParseEqvExpr;
  try
    while CurToken in [ptImp] do
    begin
      spos := FScanner.TokenStartPos;
      CheckAndSkipTokens([ptImp]);

      child := ParseEqvExpr;
      try
        Result            := TLMDVbBinaryOpExpr.Create(Result, child, boImp);
        Result.FSourcePos := spos;
      except
        child.Free;
        raise;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseEqvExpr: TLMDVbExpression;
var
  child: TLMDVbExpression;
  spos:  Integer;
begin
  Result := ParseXorExpr;
  try
    while CurToken in [ptEqv] do
    begin
      spos := FScanner.TokenStartPos;
      CheckAndSkipTokens([ptEqv]);

      child := ParseXorExpr;
      try
        Result            := TLMDVbBinaryOpExpr.Create(Result, child, boEqv);
        Result.FSourcePos := spos;
      except
        child.Free;
        raise;
      end;
    end
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseXorExpr: TLMDVbExpression;
var
  child: TLMDVbExpression;
  spos:  Integer;
begin
  Result := ParseOrExpr;
  try
    while CurToken = ptXor do
    begin
      spos := FScanner.TokenStartPos;
      CheckAndSkipTokens([ptXor]);

      child := ParseOrExpr;
      try
        Result            := TLMDVbBinaryOpExpr.Create(Result, child, boXor);
        Result.FSourcePos := spos;
      except
        child.Free;
        raise;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TLMDVbParser.Rollback(const ASavepoint: TLMDVbParserSavepoint);
begin
  FScanner.Rollback(ASavepoint.ScannerSP);
  FLastSkippedPos   := ASavepoint.LastSkippedPos;
  FCurrentProc      := ASavepoint.CurrentProc;
  FExitPntCounts    := ASavepoint.ExitPntCounts;
  FOnlyColonBRCount := ASavepoint.OnlyColonBRCount;
  FTryState         := ASavepoint.TryState;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseOrExpr: TLMDVbExpression;
var
  chils: TLMDVbExpression;
  spos:  Integer;
begin
  Result := ParseAndExpr;
  try
    while CurToken in [ptOr] do
    begin
      spos := FScanner.TokenStartPos;
      CheckAndSkipTokens([ptOr]);

      chils := ParseAndExpr;
      try
        Result            := TLMDVbBinaryOpExpr.Create(Result, chils, boOr);
        Result.FSourcePos := spos;
      except
        chils.Free;
        raise;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseAndExpr: TLMDVbExpression;
var
  child: TLMDVbExpression;
  spos:  Integer;
begin
  Result := ParseCompareExpr;
  try
    while CurToken in [ptAnd] do
    begin
      spos := FScanner.TokenStartPos;
      CheckAndSkipTokens([ptAnd]);

      child := ParseCompareExpr;
      try
        Result            := TLMDVbBinaryOpExpr.Create(Result, child, boAnd);
        Result.FSourcePos := spos;
      except
        child.Free;
        raise;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbExitStmt.DoEmitByteCode(var C: TLMDContext);
begin
  case FExitType of
    etFor:        begin
                    Assert(C.CurExits.ForL <> nil);
                    C.Code.Emit(icJump, C.CurExits.ForL);
                  end;
    etDo:         begin
                    Assert(C.CurExits.DoL <> nil);
                    C.Code.Emit(icJump, C.CurExits.DoL);
                  end;
    etFunction,
    etSub:        if C.CurExits.ProcL <> nil then
                    C.Code.Emit(icJump, C.CurExits.ProcL)
                  else
                    C.Code.Emit(icRet);
  else
    Assert(False);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbDimStmt.DoEmitByteCode(var C: TLMDContext);
var
  i:        Integer;
  vd:       TLMDVbDimVarDecl;
  lvar:     TLMDVbLocalVarDecl;
  needasgn: Boolean;
begin
  for i := 0 to VarDeclCount - 1 do
  begin
    vd       := VarDecls[i];
    needasgn := False;

    if vd.IsArray then
    begin
      if vd.ArrayDimCount > 0 then
      begin
        vd.EmitArrayDims(C);
        C.Code.Emit(icArrayCreate, C.Code.AddArray(vd.ArrayDimCount,
                    vd.FElemType));
      end
      else
      begin
        // MS VbScript produce the following value in this case:
        //  val.VType  := (varArray or varVariant);
        //  val.VArray := nil;
        // But, Delphi's Variant handling routines do not support this
        // value. VarClear will raise access violation in this case.

        C.Code.Emit(icPushUnassigned);
      end;

      needasgn := True;
    end
    else if vd.Initer <> nil then
    begin
      vd.Initer.EmitByteCode(C);
      needasgn := True;
    end;

    if needasgn then
    begin
      if vd.Var_ is TLMDVbLocalVarDecl then
      begin
        lvar := TLMDVbLocalVarDecl(vd.Var_);
        C.Code.Emit(icAssignLocalVar, TObject(lvar.FIndex));
      end
      else if vd.Var_ is TLMDVarObject then
        C.Code.Emit(icAssignGlobalVar, vd.Var_)
      else
        Assert(False); // Since Dim declare variables, it should
                       // assign created arrays exactly in these
                       // varibles, without name search.
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDVbRedimStmt.Destroy;
var
  i: Integer;
begin
  for i := 0 to FVarDecls.Count - 1 do
    TObject(FVarDecls[i]).Free;
  FVarDecls.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbRedimStmt.DoEmitByteCode(var C: TLMDContext);
var
  i:      Integer;
  vd:     TLMDVbRedimVarDecl;
  varnm:  Integer;
  varsnm: WideString;
  sres:   TLMDNameSearchRes;
  redim:  TLMDArrayRedim;
begin
  for i := 0 to VarDeclCount - 1 do
  begin
    vd      := VarDecls[i];
    varnm   := vd.VarExpr.Items[0].Name;
    varsnm  := vd.VarExpr.Items[0].StrName;

    sres.ObjKind := srNotFound;
    if C.CurNamespace <> nil then
      sres := C.CurNamespace.CompileTimeFind(varnm);

    if sres.ObjKind = srLocalVar then
    begin
      redim := C.Code.AddArrayRedim(vd.ArrayDimCount, vd.FElemType, FPreserve,
                                    sres.LocalVarIndex);
      vd.EmitArrayDims(C);
      C.Code.Emit(icArrayRedimLocal, redim);
    end
    else
    begin
      redim := C.Code.AddArrayRedim(vd.ArrayDimCount, vd.FElemType, FPreserve);

      vd.FVarExpr.EmitRefByteCode(C);
      vd.EmitArrayDims(C);
      C.Code.Emit(icArrayRedimLValue, redim);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbRedimStmt.GetVarDeclCount: Integer;
begin
  Result := FVarDecls.Count;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbRedimStmt.GetVarDecls(AIndex: Integer): TLMDVbRedimVarDecl;
begin
  Result := TLMDVbRedimVarDecl(FVarDecls[AIndex]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseCompareExpr: TLMDVbExpression;
var
  child: TLMDVbExpression;
  op:    TLMDVbBinaryOp;
  spos:  Integer;
begin
  Result := ParseTypeOfExpr;
  try
    while CurToken in CompareOpTokens do
    begin
      spos  := FScanner.TokenStartPos;
      op    := ParseCompareOp;
      child := ParseTypeOfExpr;
      try
        Result            := TLMDVbBinaryOpExpr.Create(Result, child, op);
        Result.FSourcePos := spos;
      except
        child.Free;
        raise;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TLMDVbLiteralExpr.DoEmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel; var AResInStack: Boolean);
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

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseCompareOp: TLMDVbBinaryOp;
begin
  CheckTokens(CompareOpTokens);

  case CurToken of
    ptIs:           Result := boIs;
    ptGreaterEqual: Result := boGreaterEqual;
    ptLessEqual:    Result := boLessEqual;
    ptGreater:      Result := boGreater;
    ptLess:         Result := boLess;
    ptNotEqual:     Result := boNotEqual;
  else
    Result := boEqual;
  end;
  SkipToken;

  if (Result = boIs) and (CurToken = ptNot) then
  begin
    SkipToken;
    Result := boIsNot;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseConcatExpr: TLMDVbExpression;
var
  child: TLMDVbExpression;
  spos:  Integer;
begin
  Result := ParseAddExpr;
  try
    while CurToken in [ptStrConcat] do
    begin
      spos := FScanner.TokenStartPos;
      CheckAndSkipTokens([ptStrConcat]);

      child := ParseAddExpr;
      try
        Result            := TLMDVbBinaryOpExpr.Create(Result, child,
                                                       boStrConcat);
        Result.FSourcePos := spos;
      except
        child.Free;
        raise;
      end;
    end
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseAddExpr: TLMDVbExpression;
var
  child: TLMDVbExpression;
  op:    TLMDVbBinaryOp;
  spos:  Integer;
begin
  Result := ParseModExpr;
  try
    while CurToken in AddOpTokens do
    begin
      spos  := FScanner.TokenStartPos;
      op    := ParseAddOp;
      child := ParseModExpr;
      try
        Result            := TLMDVbBinaryOpExpr.Create(Result, child, op);
        Result.FSourcePos := spos;
      except
        child.Free;
        raise;
      end;
    end
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseAddOp: TLMDVbBinaryOp;
begin
  case CurToken of
    ptPlus:  Result := boPlus;
    ptMinus: Result := boMinus;
  else
    CheckTokens(AddOpTokens);
    Result := TLMDVbBinaryOp(-1);
  end;
  SkipToken;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseModExpr: TLMDVbExpression;
var
  child: TLMDVbExpression;
  spos:  Integer;
begin
  Result := ParseMultIntExpr;
  try
    while CurToken in [ptMod] do
    begin
      spos := FScanner.TokenStartPos;
      CheckAndSkipTokens([ptMod]);

      child := ParseMultIntExpr;
      try
        Result            := TLMDVbBinaryOpExpr.Create(Result, child, boMod);
        Result.FSourcePos := spos;
      except
        child.Free;
        raise;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseMultIntExpr: TLMDVbExpression;
var
  child: TLMDVbExpression;
  spos:  Integer;
begin
  Result := ParseMultExpr;
  try
    while CurToken in [ptIntDivide] do
    begin
      spos := FScanner.TokenStartPos;
      CheckAndSkipTokens([ptIntDivide]);

      child := ParseMultExpr;
      try
        Result            := TLMDVbBinaryOpExpr.Create(Result, child,
                                                       boIntDivide);
        Result.FSourcePos := spos;
      except
        child.Free;
        raise;
      end;
    end
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseMultExpr: TLMDVbExpression;
var
  child: TLMDVbExpression;
  op:    TLMDVbBinaryOp;
  spos:  Integer;
begin
  Result := ParseExpExpr;
  try
    while CurToken in MultOpTokens do
    begin
      spos  := FScanner.TokenStartPos;
      op    := ParseMultOp;
      child := ParseExpExpr;
      try
        Result            := TLMDVbBinaryOpExpr.Create(Result, child, op);
        Result.FSourcePos := spos;
      except
        child.Free;
        raise;
      end;
    end
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseMultOp: TLMDVbBinaryOp;
begin
  case CurToken of
    ptMultiply: Result := boMult;
    ptDivide:   Result := boDivide;
  else
    CheckTokens(MultOpTokens);
    Result := TLMDVbBinaryOp(-1);
  end;
  SkipToken;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseNewExpr: TLMDVbNewExpr;
var
  nm:     Integer;
  s:      WideString;
  acnt:   Integer;
  hasrnd: Boolean;
begin
  CheckAndSkipTokens([ptNew]);

  Result            := TLMDVbNewExpr.Create;
  Result.FSourcePos := FScanner.TokenStartPos;
  try
    nm := ParseIdentifier(s);
    Result.AddItem;
    Result.LastItem.FSourcePos := FLastSkippedPos;
    Result.LastItem.SetName(nm, s);

    while CurToken = ptDot do
    begin
      SkipToken;
      nm := ParseIdentifier(s);
      Result.AddItem;
      Result.LastItem.FSourcePos := FLastSkippedPos;
      Result.LastItem.SetName(nm, s);
    end;

    Result.AddItem;                          // Add unnamed 'new' call.
    Result.FNewCallItem := Result.LastItem;  //

    Result.LastItem.FSourcePos   := FScanner.TokenStartPos;
    Result.LastItem.FBracketType := bkVbRound; // Even if no args. Unnamed calls
                                               // always have brackets.
    if CurToken = ptOpenRound then
      ParseArguments(Result.LastItem, acnt);

    ParseDesignatorTail(Result, acnt, hasrnd);
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseExpExpr: TLMDVbExpression;
var
  child: TLMDVbExpression;
  spos:  Integer;
begin
  Result := ParseValueExpr;
  try
    while CurToken in [ptExp] do
    begin
      spos := FScanner.TokenStartPos;
      CheckAndSkipTokens([ptExp]);

      child := ParseValueExpr;
      try
        Result            := TLMDVbBinaryOpExpr.Create(Result, child, boExp);
        Result.FSourcePos := spos;
      except
        child.Free;
        raise;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseValueExpr: TLMDVbExpression;
var
  spos: Integer;
begin
  CheckTokens(ValueExprTokens);

  if CurToken in DesignatorTokens then
    Result := ParseDesignator
  else if CurToken in NewExprTokens then
    Result := ParseNewExpr
  else case CurToken of
    ptTrue:
    begin
      Result            := TLMDVbLiteralExpr.Create(True);
      Result.FSourcePos := FScanner.TokenStartPos;
      SkipToken;
    end;
    ptFalse:
    begin
      Result            := TLMDVbLiteralExpr.Create(False);
      Result.FSourcePos := FScanner.TokenStartPos;
      SkipToken;
    end;
    ptCInteger:
    begin
      Result            := TLMDVbLiteralExpr.Create(FScanner.IData);
      Result.FSourcePos := FScanner.TokenStartPos;
      SkipToken;
    end;
    ptCFloat:
    begin
      Result            := TLMDVbLiteralExpr.Create(FScanner.FData);
      Result.FSourcePos := FScanner.TokenStartPos;
      SkipToken;
    end;
    ptCString:
    begin
      Result            := TLMDVbLiteralExpr.Create(FScanner.SData);
      Result.FSourcePos := FScanner.TokenStartPos;
      SkipToken;
    end;
    ptCDate:
    begin
      Result            := TLMDVbLiteralExpr.Create(FScanner.DData);
      Result.FSourcePos := FScanner.TokenStartPos;
      SkipToken;
    end;
    ptNothing:
    begin
      Result            := TLMDVbLiteralExpr.Create(VbNothing);
      Result.FSourcePos := FScanner.TokenStartPos;
      SkipToken;
    end;
    ptNull:
    begin
      Result            := TLMDVbLiteralExpr.Create(Null);
      Result.FSourcePos := FScanner.TokenStartPos;
      SkipToken;
    end;
    ptEmpty:
    begin
      Result            := TLMDVbLiteralExpr.Create(Unassigned);
      Result.FSourcePos := FScanner.TokenStartPos;
      SkipToken;
    end;
    ptPlus:
    begin
      spos := FScanner.TokenStartPos;
      SkipToken;

      Result            := TLMDVbUnaryOpExpr.Create(uoPlus, ParseValueExpr);
      Result.FSourcePos := spos;
    end;
    ptMinus:
    begin
      spos := FScanner.TokenStartPos;
      SkipToken;

      Result            := TLMDVbUnaryOpExpr.Create(uoMinus, ParseValueExpr);
      Result.FSourcePos := spos;
    end;
    ptNot:
    begin
      spos := FScanner.TokenStartPos;
      SkipToken;

      Result            := TLMDVbUnaryOpExpr.Create(uoNot, ParseValueExpr);
      Result.FSourcePos := spos;
    end;
  else
    CheckAndSkipTokens([ptOpenRound]);
    Result := ParseExpression;
    try
      CheckAndSkipTokens([ptCloseRound]);
    except
      Result.Free;
      raise;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseDesignator(out ArgCount: Integer;
  out HasRound: Boolean): TLMDVbDesignatorExpr;
var
  nm: Integer;
  s:  WideString;
begin
  Result            := TLMDVbDesignatorExpr.Create;
  Result.FSourcePos := FScanner.TokenStartPos;
  try
    nm := ParseIdentifier(s);
    Result.AddItem;
    Result.LastItem.FSourcePos := FLastSkippedPos;
    Result.LastItem.SetName(nm, s);

    ParseDesignatorTail(Result, ArgCount, HasRound);
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.ParseDesignatorTail(AExpr: TLMDVbDesignatorExpr;
  out ArgCount: Integer; out HasRound: Boolean);
var
  nm: Integer;
  s:  WideString;
begin
  ArgCount := 0;
  HasRound := False;

  while CurToken in [ptDot, ptOpenRound] do
  begin
    ArgCount := 0;
    CheckTokens([ptDot, ptOpenRound]);

    if CurToken in [ptDot] then
    begin
      HasRound := False;
      CheckAndSkipTokens([ptDot]);

      nm := ParseIdentifier(s);
      AExpr.AddItem;
      AExpr.LastItem.FSourcePos := FLastSkippedPos;
      AExpr.LastItem.SetName(nm, s);
    end
    else
    begin
      HasRound := True;

      if AExpr.LastItem.FBracketType <> bkNon then
      begin
        AExpr.AddItem; // Add unnamed call.
        AExpr.LastItem.FSourcePos := FScanner.TokenStartPos;
      end;
      AExpr.LastItem.FBracketType := bkVbRound;
      ParseArguments(AExpr.LastItem, ArgCount);
    end;
  end;
end;

function TLMDVbParser.ParseDesignator: TLMDVbDesignatorExpr;
var
  argcnt: Integer;
  hasrnd: Boolean;
begin
  Result := ParseDesignator(argcnt, hasrnd);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.ParseBR;
const
  BR_TOKENS: array[Boolean] of TLMDVbTokens = ([ptEOl, ptColon],
                                               [ptColon]);
begin
  CheckAndSkipTokens(BR_TOKENS[FOnlyColonBRCount <> 0]);
  while CurToken in BR_TOKENS[FOnlyColonBRCount <> 0] do
    SkipToken;
end;

{ ---------------------------------------------------------------------------- }

function TLMDVbParser.ParseIdentifier: Integer;
var
  s: WideString;
begin
  CheckTokens([ptIdentifier]);

  s      := FScanner.SData;
  Result := FCbs.GetNameId(s);

  SkipToken;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDVbParser.StrError(const AStr: string);
begin
  raise ELMDVbCompiler.Create(AStr, FScanner.TokenEndPos);
end;

{ TLMDVbLanguage }

procedure TLMDVbLanguage.AddIntrinsics(AProc: TLMDAddIntrinsicProc);

  procedure _Add(const AName: WideString; AClass: TVbIntrinsicClass;
                 AKind: TVbIntrinsicKind; AParamCount: Integer = 0);
  var
    idx: Integer;
  begin
    idx := GlobNameTable.GetNameIndex(AName);
    AProc(AClass.Create(idx, AName, AKind, AParamCount));
  end;

begin
  _Add('vbEmpty', TvbEmpty, bokConstant);
  _Add('vbNull', TvbNull, bokConstant);
  _Add('vbSmallInt', TvbSmallInt, bokConstant);
  _Add('LongWord', TvbLongWord, bokConstant);
  _Add('ShortInt', TvbShortInt, bokConstant);
  _Add('Int64', TvbInt64, bokConstant);
  {$IFDEF LMDCOMP12}
  _Add('UInt64', TvbUInt64, bokConstant);
  {$ENDIF}
  _Add('vbInteger', TvbInteger, bokConstant);
  _Add('vbSingle', TvbSingle, bokConstant);
  _Add('vbDouble', TvbDouble, bokConstant);
  _Add('vbCurrency', TvbCurrency, bokConstant);
  _Add('vbDate', TvbDate, bokConstant);
  _Add('vbString', TvbString, bokConstant);
  _Add('vbObject', TvbObject, bokConstant);
  _Add('vbError', TvbError, bokConstant);
  _Add('vbBoolean', TvbBoolean, bokConstant);
  _Add('vbVariant', TvbVariant, bokConstant);
  _Add('vbDataObject', TvbDataObject, bokConstant);
  _Add('vbByte', TvbByte, bokConstant);
  _Add('vbArray', TvbArray, bokConstant);
  _Add('vbUseSystemDayOfWeek', TvbUseSystemDayOfWeek, bokConstant);
  _Add('vbSunday', TvbSunday, bokConstant);
  _Add('vbMonday', TvbMonday, bokConstant);
  _Add('vbTuesday', TvbTuesday, bokConstant);
  _Add('vbWednesday', TvbWednesday, bokConstant);
  _Add('vbThursday', TvbThursday, bokConstant);
  _Add('vbFriday', TvbFriday, bokConstant);
  _Add('vbSaturday', TvbSaturday, bokConstant);
  _Add('vbBinaryCompare', TvbBinaryCompare, bokConstant);
  _Add('vbTextCompare', TvbTextCompare, bokConstant);
  _Add('vbOKOnly', TvbOKOnly, bokConstant);
  _Add('vbOKCancel', TvbOKCancel, bokConstant);
  _Add('vbAbortRetryIgnore', TvbAbortRetryIgnore, bokConstant);
  _Add('vbYesNoCancel', TvbYesNoCancel, bokConstant);
  _Add('vbYesNo', TvbYesNo, bokConstant);
  _Add('vbRetryCancel', TvbRetryCancel, bokConstant);
  _Add('vbCritical', TvbCritical, bokConstant);
  _Add('vbQuestion', TvbQuestion, bokConstant);
  _Add('vbExclamation', TvbExclamation, bokConstant);
  _Add('vbInformation', TvbInformation, bokConstant);
  _Add('vbOK', TvbOK, bokConstant);
  _Add('vbCancel', TvbCancel, bokConstant);
  _Add('vbAbort', TvbAbort, bokConstant);
  _Add('vbRetry', TvbRetry, bokConstant);
  _Add('vbIgnore', TvbIgnore, bokConstant);
  _Add('vbYes', TvbYes, bokConstant);
  _Add('vbNo', TvbNo, bokConstant);

  _Add('Abs', TAbs, bokFunction, 1);
  _Add('Atn', TAtn, bokFunction, 1);
  _Add('Cos', TCos, bokFunction, 1);
  _Add('Sin', TSin, bokFunction, 1);
  _Add('Tan', TTan, bokFunction, 1);
  _Add('Sqr', TTan, bokFunction, 1);
  _Add('Exp', TExp, bokFunction, 1);
  _Add('CBool', TCBool, bokFunction, 1);
  _Add('CByte', TCByte, bokFunction, 1);
  _Add('CCur', TCCur, bokFunction, 1);
  _Add('CDate', TCDate, bokFunction, 1);
  _Add('CDbl', TCDbl, bokFunction, 1);
  _Add('CInt', TCInt, bokFunction, 1);
  _Add('CLng', TCLng, bokFunction, 1);
  _Add('CSng', TCSng, bokFunction, 1);
  _Add('CStr', TCStr, bokFunction, 1);
  _Add('Chr', TChr, bokFunction, 1);
  _Add('Int', TInt, bokFunction, 1);
  _Add('Fix', TFix, bokFunction, 1);
  _Add('Log', TLog, bokFunction, 1);
  _Add('Round', TRound, bokFunction, -1);
  _Add('Sgn', TSgn, bokFunction, 1);
  _Add('Oct', TOct, bokFunction, 1);
  _Add('Hex', THex, bokFunction, 1);
  _Add('VarType', TVarType_, bokFunction, 1);
  _Add('TypeName', TTypeName, bokFunction, 1);
  _Add('IsArray', TIsArray, bokFunction, 1);
  _Add('IsDate', TIsDate, bokFunction, 1);
  _Add('IsEmpty', TIsEmpty, bokFunction, 1);
  _Add('IsNull', TIsNull, bokFunction, 1);
  _Add('IsNumeric', TIsNumeric, bokFunction, 1);
  _Add('IsObject', TIsObject, bokFunction, 1);
  _Add('Array', TArray, bokFunction, -1);
  _Add('LBound', TLBound, bokFunction, -1);
  _Add('UBound', TUBound, bokFunction, -1);
  _Add('Now', TNow, bokFunction, 0);
  _Add('Date', TDate, bokFunction, 0);
  _Add('Time', TTime, bokFunction, 0);
  _Add('Year', TYear, bokFunction, 1);
  _Add('Month', TMonth, bokFunction, 1);
  _Add('Day', TDay, bokFunction, 1);
  _Add('Hour', THour, bokFunction, 1);
  _Add('Minute', TMinute, bokFunction, 1);
  _Add('Second', TSecond, bokFunction, 1);
  _Add('Weekday', TWeekday, bokFunction, -1);
  _Add('WeekdayName', TWeekdayName, bokFunction, -1);
  _Add('MonthName', TMonthName, bokFunction, -1);
  _Add('DateSerial', TDateSerial, bokFunction, 3);
  _Add('TimeSerial', TTimeSerial, bokFunction, 3);
  _Add('DateValue', TDateValue, bokFunction, 1);
  _Add('TimeValue', TTimeValue, bokFunction, 1);
  _Add('DateAdd', TDateAdd, bokFunction, 3);
  _Add('Timer', TTimer, bokFunction, 0);
  _Add('RGB', TRGB, bokFunction, 3);
  _Add('Join', TJoin, bokFunction, -1);
  _Add('Filter', TFilter, bokFunction, -1);
  _Add('Rnd', TRnd, bokFunction, 0);
  _Add('Randomize', TRandomize, bokProcedure, 0);
  _Add('CreateObject', TCreateObject, bokFunction, 1);
  _Add('GetObject', TGetObject, bokFunction, 1);
  _Add('Asc', TAsc, bokFunction, 1);
  _Add('UCase', TUCase, bokFunction, 1);
  _Add('LCase', TLCase, bokFunction, 1);
  _Add('Len', TLen, bokFunction, 1);
  _Add('LTrim', TLTrim, bokFunction, 1);
  _Add('RTrim', TRTrim, bokFunction, 1);
  _Add('Trim', TTrim, bokFunction, 1);
  _Add('Space', TSpace, bokFunction, 1);
  _Add('String', TString, bokFunction, 2);
  _Add('StrReverse', TStrReverse, bokFunction, 1);
  _Add('StrComp', TStrComp, bokFunction, -1);
  _Add('Left', TLeft, bokFunction, 2);
  _Add('Mid', TMid, bokFunction, -1);
  _Add('Right', TRight, bokFunction, 2);
  _Add('Split', TSplit, bokFunction, -1);
  _Add('Replace', TReplace, bokFunction, -1);
  _Add('InStr', TInStr, bokFunction, -1);
  _Add('InStrRev', TInStrRev, bokFunction, -1);
  _Add('InputBox', TInputBox, bokFunction, -1);
  _Add('MsgBox', TMsgBox, bokFunction, -1);
  _Add('GetRef', TGetRef, bokFunction, 1);
end;

function TLMDVbLanguage.CreateParser(
  ACbs: ILMDParserCallbacks): ILMDParserBase;
begin
  Result := TLMDVbParser.Create(ACbs);
end;

function TLMDVbLanguage.DebugStrLiteral(const S: WideString): WideString;
var
  i: Integer;
begin
  Result := S;
  for i := Length(Result) downto 1 do
    if Result[i] = '"' then Insert('"', Result, i);
  Result := '"' + Result + '"';
end;

function TLMDVbLanguage.DebugEmpty: WideString;
begin
  Result := 'Empty';
end;

function TLMDVbLanguage.DebugNothing: WideString;
begin
  Result := 'Nothing';
end;

function TLMDVbLanguage.DebugNull: WideString;
begin
  Result := 'Null';
end;

{ TLMDVbExpression }

procedure TLMDVbExpression.DoEmitRefByteCode(var C: TLMDContext);
begin
  EmitByteCode(C);
end;

procedure TLMDVbExpression.Emit(ANamespace: TLMDAbstractNamespace;
  AByteCode: TLMDByteCode);
var
  oldsp:   Integer;
  rsinsck: Boolean;
  ctx:     TLMDContext;
begin
  FillChar(ctx, SizeOf(ctx), 0);
  ctx.Code         := AByteCode;
  ctx.CurNamespace := ANamespace;

  AByteCode.BeginSourcePos(FSourcePos, oldsp);
  rsinsck := True;
  DoEmitByteCode(ctx, erStack, nil, rsinsck);
  Assert(rsinsck);
  AByteCode.EndSourcePos(oldsp);
end;

procedure TLMDVbExpression.EmitByteCode(var C: TLMDContext);
begin
  EmitByteCode(C, erStack);
end;

procedure TLMDVbExpression.EmitByteCode(var C: TLMDContext;
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

procedure TLMDVbExpression.EmitRefByteCode(var C: TLMDContext);
var
  oldsp: Integer;
begin
  C.Code.BeginSourcePos(FSourcePos, oldsp);
  DoEmitRefByteCode(C);
  C.Code.EndSourcePos(oldsp);
end;

{ TLMDVbStatement }

procedure TLMDVbStatement.Emit(ANamespace: TLMDAbstractNamespace;
  AByteCode: TLMDByteCode);
var
  oldsp: Integer;
  ctx:   TLMDContext;
begin
  FillChar(ctx, SizeOf(ctx), 0);
  ctx.Code         := AByteCode;
  ctx.CurNamespace := ANamespace;

  AByteCode.BeginSourcePos(FSourcePos, oldsp);
  AByteCode.SetNextInstrBreakable;
  DoEmitByteCode(ctx);
  AByteCode.EndSourcePos(oldsp);
end;

procedure TLMDVbStatement.EmitByteCode(var C: TLMDContext);
var
  oldsp: Integer;
begin
  C.Code.BeginSourcePos(FSourcePos, oldsp);
  C.Code.SetNextInstrBreakable;
  DoEmitByteCode(C);
  C.Code.EndSourcePos(oldsp);
end;

{ TLMDVbProcLocalNamespace }

function TLMDVbProcLocalNamespace.CompileTimeFind(
  AName: Integer): TLMDNameSearchRes;
var
  itm: TLMDVbProcLocal;
begin
  itm := TLMDVbProcLocal(FProc.FLocalMap.Find(AName));

  if itm <> nil then
  begin
    case itm.LocalType of
      ltVar:    begin
                  Result.ObjKind       := srLocalVar;
                  Result.LocalVarIndex := TLMDVbLocalVarDecl(itm).Index;
                end;
      ltResult: Result.ObjKind := srResult;
      ltParam:  begin
                  Result.ObjKind   := srParam;
                  Result.ParamInfo := TLMDVbParamDecl(itm).ParamInfo;
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

constructor TLMDVbProcLocalNamespace.Create(AParent: TLMDAbstractNamespace;
  AProc: TLMDVbProcDecl);
begin
  inherited Create(AParent);
  FProc := AProc;
end;

procedure TLMDVbProcLocalNamespace.EnumDebugVars(ALocalsOnly: Boolean;
  AProc: TLMDNamespaceEnumVarsProc);
var
  i:    Integer;
  sres: TLMDNameSearchRes;
begin
  for i := 0 to FProc.ParamCount - 1 do
  begin
    sres.ObjKind   := srParam;
    sres.ParamInfo := FProc.Params[i].ParamInfo;
    AProc(FProc.Params[i].StrName, sres);
  end;

  for i := 0 to FProc.LocalVarCount - 1 do
  begin
    sres.ObjKind       := srLocalVar;
    sres.LocalVarIndex := FProc.LocalVars[i].Index;
    AProc(FProc.LocalVars[i].StrName, sres);
  end;

  if FProc.ProcKind = pkFunction then
  begin
    sres.ObjKind     := srResult;
    sres.NamedObject := FProc.LocalResult;
    AProc(FProc.LocalResult.StrName, sres);
  end;

  if Parent <> nil then
    Parent.EnumDebugVars(ALocalsOnly, AProc);
end;

function TLMDVbProcLocalNamespace.Find(AThread: Pointer; AName: Integer;
  AStrName: PWideString): TLMDNameSearchRes;
var
  itm: TLMDVbProcLocal;
begin
  itm := TLMDVbProcLocal(FProc.FLocalMap.Find(AName));

  if itm <> nil then
  begin
    case itm.LocalType of
      ltVar:    begin
                  Result.ObjKind       := srLocalVar;
                  Result.LocalVarIndex := TLMDVbLocalVarDecl(itm).Index;
                end;
      ltResult: Result.ObjKind := srResult;
      ltParam:  begin
                  Result.ObjKind   := srParam;
                  Result.ParamInfo := TLMDVbParamDecl(itm).ParamInfo;
                end;
    end;

    Exit;
  end;

  Result := Parent.Find(AThread, AName, AStrName);
end;

{ TLMDVbProcLocal }

constructor TLMDVbProcLocal.Create(ALocalType: TLMDVbProcLocalType;
  AName: Integer; const AStrName: WideString);
begin
  inherited Create(AName);
  FStrName   := AStrName;
  FLocalType := ALocalType;
end;

{ TLMDVbLocalVarDecl }

constructor TLMDVbLocalVarDecl.Create(AName: Integer;
  const AStrName: WideString);
begin
  inherited Create(ltVar, AName, AStrName);
end;

{ TLMDVbLocalResultDecl }

constructor TLMDVbLocalResultDecl.Create(AName: Integer;
  const AStrName: WideString);
begin
  inherited Create(ltResult, AName, AStrName);
end;

constructor TLMDVbParamDecl.Create(AName: Integer; const AStrName: WideString;
  AParamKind: TLMDParamKind);
begin
  inherited Create(ltParam, AName, AStrName);
  FParamInfo.Kind := Word(AParamKind);
end;

{ TLMDVbTryStmt }

procedure TLMDVbTryStmt.AddCatch(ACatch: TLMDVbCatch);
begin
  FCatches.Add(ACatch);
end;

constructor TLMDVbTryStmt.Create;
begin
  inherited Create;
  FTryStmts     := TLMDVbStmtList.Create;
  FCatches      := TList.Create;
  FFinallyStmts := TLMDVbStmtList.Create;
end;

destructor TLMDVbTryStmt.Destroy;
var
  i: Integer;
begin
  for i := 0 to FCatches.Count - 1 do
    TObject(FCatches[i]).Free;

  FTryStmts.Free;
  FCatches.Free;
  FFinallyStmts.Free;
  inherited;
end;

procedure TLMDVbTryStmt.DoEmitByteCode(var C: TLMDContext);
begin
  C.Code.ManualResetNextInstrBreakable;
  EmitTryFinally(C);
end;

procedure TLMDVbTryStmt.EmitTryCatch(var C: TLMDContext);
var
  i:              Integer;
  endL:           TLMDLabel;
  elseL:          TLMDLabel;
  tryitm:         TLMDTry;
  stmtLs:         array of TLMDLabel;
  oldreraise:     TLMDTry;
  excns:          TLMDAbstractNamespace;
  onvar:          Integer;
  oldns:          TLMDAbstractNamespace;
  haspntdoloop:   Boolean;
  haspntforloop:  Boolean;
  ext, oldext:    TLMDExitLabels;
  condcnt:        Integer;
  elsectch:       TLMDVbCatch;
begin
  if CatchCount = 0 then
    FTryStmts.EmitByteCode(C)
  else
  begin
    haspntdoloop  := (C.CurExits.DoL <> nil);
    haspntforloop := (C.CurExits.ForL <> nil);
    oldext        := C.CurExits;

    tryitm               := C.Code.BeginProtectedBlock;
    tryitm.HandlerLabel  := C.Code.CreateLabel;
    tryitm.ExceptionVar  := C.Code.AddLocalVarArray(2);
    endL                 := C.Code.CreateLabel;

    { Try }

    FTryStmts.EmitByteCode(C);
    C.Code.EndProtectedBlock;
    C.Code.Emit(icJump, endL);

    { Exception system handler }

    C.Code.BeginExcHdrCode(tryitm);
    C.Code.BindLabel(tryitm.HandlerLabel);
    C.Code.Emit(icSetNamespace, C.CurNamespace);

    oldreraise   := C.CurReraise;
    C.CurReraise := tryitm;

    ext.ProcL := C.Code.CreateLabel;
    ext.ForL  := nil;
    ext.DoL   := nil;
    if haspntdoloop then
      ext.DoL := C.Code.CreateLabel;
    if haspntforloop then
      ext.ForL := C.Code.CreateLabel;
    C.CurExits := ext;

    if (CatchCount = 1) and not Catches[0].HasAs then
    begin
      { Simple catch }

      Catches[0].Stmts.EmitByteCode(C);
      C.Code.Emit(icExceptDone);
      C.Code.Emit(icJump, endL);
    end
    else
    begin
      { Complex catches with 'as' clauses }

      condcnt  := CatchCount;
      elsectch := nil;
      if not Catches[CatchCount - 1].HasAs then
      begin
        Dec(condcnt);
        elsectch := Catches[CatchCount - 1];
      end;

      SetLength(stmtLs, condcnt);
      for i := 0 to High(stmtLs) do
        stmtLs[i] := C.Code.CreateLabel;

      { Dispatching code }

      for i := 0 to condcnt - 1 do
      begin
        Catches[i].Expr.EmitByteCode(C);
        C.Code.Emit(icExceptJmpIfIs, C.Code.AddExcJmp(tryitm, stmtLs[i]));
      end;

      elseL := C.Code.CreateLabel;
      C.Code.Emit(icJump, elseL);

      { Exception bloks stmts }

      for i := 0 to condcnt - 1 do
      begin
        // Conditional 'catch E as Exception'

        onvar          := C.Code.AddLocalVar;
        excns          := Catches[i].CreateNS(C.CurNamespace, onvar);
        oldns          := C.CurNamespace;
        C.CurNamespace := excns;

        C.Code.BindLabel(stmtLs[i]);
        C.Code.Emit(icSetNamespace, excns);
        C.Code.Emit(icExceptToVar, TObject(tryitm.ExceptionVar));
        C.Code.Emit(icAssignLocalVar, TObject(onvar));

        Catches[i].Stmts.EmitByteCode(C);
        C.Code.Emit(icSetNamespace, oldns);

        C.CurNamespace := oldns;

        C.Code.Emit(icExceptDone);
        C.Code.Emit(icJump, endL);
      end;

      // Unconditional last 'catch'

      C.Code.BindLabel(elseL);

      if elsectch <> nil then
      begin
        elsectch.Stmts.EmitByteCode(C);
        C.Code.Emit(icExceptDone);
        C.Code.Emit(icJump, endL);
      end
      else
        C.Code.Emit(isReraise, TObject(tryitm.ExceptionVar)); // Reraise on
                                                              // implicit else.
    end;

    C.CurExits   := oldext;
    C.CurReraise := oldreraise;

    C.Code.EndExcHdrCode(tryitm);

    { Exits proxy handlers }

    if haspntdoloop then
    begin
      C.Code.BindLabel(ext.DoL);
      C.Code.Emit(icExceptDone);
      C.Code.Emit(icJump, oldext.DoL);
    end;

    if haspntforloop then
    begin
      C.Code.BindLabel(ext.ForL);
      C.Code.Emit(icExceptDone);
      C.Code.Emit(icJump, oldext.ForL);
    end;

    C.Code.BindLabel(ext.ProcL);
    C.Code.Emit(icExceptDone);
    if oldext.ProcL <> nil then
      C.Code.Emit(icJump, oldext.ProcL)
    else
      C.Code.Emit(icRet);

    C.Code.BindLabel(endL);
  end;
end;

procedure TLMDVbTryStmt.EmitTryFinally(var C: TLMDContext);
type
  TFinallyReturn = (frNormal, frExitProc, frExitDo, frExitFor);
var
  endL:          TLMDLabel;
  tryitm:        TLMDTry;
  invalidExists: TLMDLabel;
  haspntdoloop:  Boolean;
  haspntforloop: Boolean;
  ext, oldext:   TLMDExitLabels;
  i:             TFinallyReturn;
  frets:         array[TFinallyReturn] of TLMDLabel;
begin
  { Try-finally }

  if (FFinallyStmts.Count = 0) then // Nothing in finally, so
    EmitTryCatch(C)                 // just emit child stmts.
  else
  begin
    FillChar(frets, SizeOf(frets), 0);
    haspntdoloop  := (C.CurExits.DoL <> nil);
    haspntforloop := (C.CurExits.ForL <> nil);
    oldext        := C.CurExits;

    tryitm                := C.Code.BeginProtectedBlock;
    tryitm.FinallyLabel   := C.Code.CreateLabel;
    tryitm.HandlerLabel   := C.Code.CreateLabel;
    tryitm.FinallyRetVar  := C.Code.AddLocalVar;
    frets[frNormal]       := C.Code.CreateLabel;
    frets[frExitProc]     := C.Code.CreateLabel;
    if haspntdoloop then
      frets[frExitDo]     := C.Code.CreateLabel;
    if haspntforloop then
      frets[frExitFor]    := C.Code.CreateLabel;
    tryitm.ExceptionVar   := C.Code.AddLocalVarArray(2);
    endL                  := C.Code.CreateLabel;

    { Try }

    ext.ProcL  := C.Code.CreateLabel;
    ext.ForL   := nil;
    ext.DoL    := nil;
    if haspntdoloop then
      ext.DoL  := C.Code.CreateLabel;
    if haspntforloop then
      ext.ForL := C.Code.CreateLabel;
    C.CurExits := ext;

    EmitTryCatch(C); // Children - all stuff, protected by try-finally.
    C.Code.EndProtectedBlock;
    C.Code.Emit(icCallFinally, tryitm);
    C.Code.BindLabel(frets[frNormal]);
    C.Code.Emit(icJump, endL);

    C.CurExits := oldext;

    { Finally code }

    // Note: This code acts as a lightweight sub-routine and it is
    //       called in following situations:
    // - Immediatelly after try child stmts.
    // - When Exit Sub/Do/For leaves execution away from the try
    //   region.
    // - From exception handler (in case of exception in try child stmts).

    C.Code.BeginExcHdrCode(tryitm);

    invalidExists    := C.Code.CreateLabel;
    C.CurExits.ProcL := invalidExists;  // Executing Exit Sub/Do/For
    C.CurExits.ForL  := invalidExists;  // from finally section is
    C.CurExits.DoL   := invalidExists;  // invalid.

    C.Code.BindLabel(tryitm.FinallyLabel);
    FFinallyStmts.EmitByteCode(C);
    C.Code.Emit(icFinallyRet, tryitm);

    C.CurExits := oldext;
    C.Code.EndExcHdrCode(tryitm);

    { Exits proxy handlers }

    if haspntdoloop then
    begin
      C.Code.BindLabel(ext.DoL);
      C.Code.Emit(icCallFinally, tryitm);
      C.Code.BindLabel(frets[frExitDo]);
      C.Code.Emit(icJump, oldext.DoL);
    end;

    if haspntforloop then
    begin
      C.Code.BindLabel(ext.ForL);
      C.Code.Emit(icCallFinally, tryitm);
      C.Code.BindLabel(frets[frExitFor]);
      C.Code.Emit(icJump, oldext.ForL);
    end;

    C.Code.BindLabel(ext.ProcL);
    C.Code.Emit(icCallFinally, tryitm);
    C.Code.BindLabel(frets[frExitProc]);

    if oldext.ProcL <> nil then
      C.Code.Emit(icJump, oldext.ProcL)
    else
      C.Code.Emit(icRet);

    { Invalid Exits from finally handler }

    C.Code.BindLabel(invalidExists);
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

function TLMDVbTryStmt.GetCatchCount: Integer;
begin
  Result := FCatches.Count;
end;

function TLMDVbTryStmt.GetCatches(AIndex: Integer): TLMDVbCatch;
begin
  Result := TLMDVbCatch(FCatches[AIndex]);
end;

{ TLMDVbCatch }

constructor TLMDVbCatch.Create(AName: Integer; const AStrName: WideString);
begin
  Create;
  FName    := AName;
  FStrName := AStrName;
end;

constructor TLMDVbCatch.Create;
begin
  inherited Create;
  FName      := -1;
  FStmts     := TLMDVbStmtList.Create;
  FNamespace := nil;
end;

function TLMDVbCatch.CreateNS(AParent: TLMDAbstractNamespace;
  AVarIndex: Integer): TLMDAbstractNamespace;
begin
  Assert(FNamespace = nil); // Need a list of Namespaces to
                            // properly free them.
  FNamespace := TLMDVbCatchNamespace.Create(AParent, Self, AVarIndex);
  Result     := FNamespace;
end;

destructor TLMDVbCatch.Destroy;
begin
  FStmts.Free;
  FExpr.Free;
  FNamespace.Free;
  inherited;
end;

function TLMDVbCatch.GetHasAs: Boolean;
begin
  Result := (FStrName <> '');
end;

{ TLMDVbThrowStmt }

destructor TLMDVbThrowStmt.Destroy;
begin
  FExpr.Free;
  inherited;
end;

procedure TLMDVbThrowStmt.DoEmitByteCode(var C: TLMDContext);
begin
  if FExpr = nil then
    C.Code.Emit(isReraise, TObject(C.CurReraise.ExceptionVar))
  else
  begin
    FExpr.EmitByteCode(C);
    C.Code.Emit(icRaise);
  end;
end;

{ TLMDVbCatchNamespace }

function TLMDVbCatchNamespace.CompileTimeFind(
  AName: Integer): TLMDNameSearchRes;
begin
  if AName = FCatch.FName then
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

constructor TLMDVbCatchNamespace.Create(AParent: TLMDAbstractNamespace;
  ACatch: TLMDVbCatch; AVarIndex: Integer);
begin
  inherited Create(AParent);
  FCatch := ACatch;
  FVarIndex := AVarIndex;
end;

procedure TLMDVbCatchNamespace.EnumDebugVars(ALocalsOnly: Boolean;
  AProc: TLMDNamespaceEnumVarsProc);
var
  sres: TLMDNameSearchRes;
begin
  if Parent <> nil then
    Parent.EnumDebugVars(ALocalsOnly, AProc);

  sres.ObjKind       := srLocalVar;
  sres.LocalVarIndex := FVarIndex;
  AProc(FCatch.StrName, sres);
end;

function TLMDVbCatchNamespace.Find(AThread: Pointer; AName: Integer;
  AStrName: PWideString): TLMDNameSearchRes;
begin
  if AName = FCatch.FName then
  begin
    Result.ObjKind       := srLocalVar;
    Result.LocalVarIndex := FVarIndex;
    Exit;
  end;

  Result := Parent.Find(AThread, AName, AStrName);
end;

{ TLMDVbReturnStmt }

destructor TLMDVbReturnStmt.Destroy;
begin
  FExpr.Free;
  inherited;
end;

procedure TLMDVbReturnStmt.DoEmitByteCode(var C: TLMDContext);
begin
  if FExpr <> nil then
  begin
    FExpr.EmitByteCode(C);
    C.Code.Emit(icAssignResult);
  end;

  if C.CurExits.ProcL <> nil then
    C.Code.Emit(icJump, C.CurExits.ProcL)
  else
    C.Code.Emit(icRet);
end;

{ TLMDVbNewExpr }

procedure TLMDVbNewExpr.DoEmitByteCode(var C: TLMDContext;
  AEmitRes: TLMDExprEmitRes; AJmpLabel: TLMDLabel; var AResInStack: Boolean);
begin
  if AEmitRes = erNoRes then
    Items[ItemCount - 1].FIsResultUsed := False;
  InternalEmit(C, False, NewCallInstrProc);
end;

procedure TLMDVbNewExpr.DoEmitRefByteCode(var C: TLMDContext);
begin
  InternalEmit(C, True, NewCallInstrProc);
end;

function TLMDVbNewExpr.NewCallInstrProc(var C: TLMDContext;
  AItem: TLMDVbDesignatorItem; out AInstr: TLMDInstr;
  out ANeedSlot: Boolean): Boolean;
begin
  if AItem = FNewCallItem then
  begin
    AInstr.Code := icNewUnnamedCall;
    AInstr.Data := C.Code.AddCall(AItem.Name, AItem.StrName, AItem.BracketType,
                                  AItem.ArgCount, True, False, True);
    ANeedSlot   := True;
    Result      := True;
  end
  else
    Result := False;
end;

{ TLMDVbEraseStmt }

destructor TLMDVbEraseStmt.Destroy;
begin
  FExpr.Free;
  inherited;
end;

procedure TLMDVbEraseStmt.DoEmitByteCode(var C: TLMDContext);
begin
  FExpr.EmitRefByteCode(C);
  C.Code.Emit(icPushUnassigned);
  C.Code.Emit(icAssignLValue);
end;

{ TLMDVbRedimVarDecl }

procedure TLMDVbRedimVarDecl.AddArrayDim(AExpr: TLMDVbExpression);
begin
  FArrayDims.Add(AExpr);
end;

constructor TLMDVbRedimVarDecl.Create;
begin
  inherited Create;
  FArrayDims  := TList.Create;
end;

destructor TLMDVbRedimVarDecl.Destroy;
var
  i: Integer;
begin
  for i :=0 to ArrayDimCount - 1 do
    TObject(FArrayDims[i]).Free;
  FArrayDims.Free;
  FVarExpr.Free;
  inherited;
end;

procedure TLMDVbRedimVarDecl.EmitArrayDims(var C: TLMDContext);
var
  i: Integer;
begin
  for i := 0 to ArrayDimCount - 1 do
  begin
    C.Code.Emit(icPush0);         // Low bound, always zero in Vb.
    ArrayDims[i].EmitByteCode(C); // High bound.
  end;
end;

function TLMDVbRedimVarDecl.GetArrayDimCount: Integer;
begin
  Result := FArrayDims.Count;
end;

function TLMDVbRedimVarDecl.GetArrayDims(AIndex: Integer): TLMDVbExpression;
begin
  Result := TLMDVbExpression(FArrayDims[AIndex]);
end;

{ TVbIntrinsic }

constructor TVbIntrinsic.Create(const AName: Integer;
  const AStrName: WideString; AKind: TVbIntrinsicKind; AArgsCount: Integer);
begin
  inherited Create(AName, AStrName);

  FKind      := AKind;
  FArgsCount := AArgsCount;
end;

procedure TVbIntrinsic.Execute(AVM: TLMDVMBase; ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
type
  TState = (sOk, sPrmChck, sTpMis, sNotUsed1, sNotUsed2);
const
  STATES: array[TVbIntrinsicKind, TLMDBracketType,
                Boolean, Boolean] of TState =
  (
    { bokProcedure }
    (
      ((sPrmChck,   sOk),       (sTpMis,    sTpMis)),       // bkNon
      ((sPrmChck,   sOk),       (sTpMis,    sTpMis)),       // bkVbRound
      ((sTpMis,     sTpMis),    (sTpMis,    sTpMis)),       // bkRound
      ((sTpMis,     sTpMis),    (sTpMis,    sTpMis))        // bkBlock
    ),
    { bokFunction }
    (
      ((sPrmChck,   sOk),       (sPrmChck,  sOk)),          // bkNon
      ((sPrmChck,   sOk),       (sPrmChck,  sOk)),          // bkVbRound
      ((sTpMis,     sTpMis),    (sTpMis,    sTpMis)),       // bkRound
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

class function TVbIntrinsic.VarToDate(const V: OleVariant): TDateTime;
var
  dt: PVarData;
  s:  WideString;
begin
  dt := FindVarData(V);

  if dt.VType = varOleStr then
  begin
    s      := dt.VOleStr;
    Result := StrToDateTime(s);
  end
  else
    Result := V;
end;

{ TAbs }

procedure TAbs.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
    AResult := Abs(AArgs[0]);
end;

{ TAtn }

procedure TAtn.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := ArcTan(AArgs[0]);
end;

{ TCos }

procedure TCos.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Cos(AArgs[0]);
end;

{ TSin }

procedure TSin.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Sin(AArgs[0]);
end;

{ TTan }

procedure TTan.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Tan(AArgs[0]);
end;

{ TSqr }

procedure TSqr.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Sqrt(AArgs[0]);
end;

{ TCBool }

procedure TCBool.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Boolean(AArgs[0]);
end;

{ TCByte }

procedure TCByte.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType := varByte;         // Direct Byte(AArgs[0]) conversion will
    VByte := Byte(AArgs[0]);  // return varInteger variant value.
  end;
end;

{ TCCur }

procedure TCCur.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Currency(AArgs[0]);
end;

{ TCDate }

procedure TCDate.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := VarToDate(AArgs[0]);
end;

{ TCDbl }

procedure TCDbl.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Double(AArgs[0]);
end;

{ TCInt }

procedure TCInt.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Integer(AArgs[0]); // Unlike MS VBScript, we support all
                                // Variant types, CInt is equivalent
                                // to CLng and converts the value varInteger.
end;

{ TCLng }

procedure TCLng.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Integer(AArgs[0]); 
end;

{ TCSng }

procedure TCSng.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType   := varSingle;         // Direct Single(AArgs[0]) conversion
    VSingle := Single(AArgs[0]);  // will return varDouble variant value.
  end;
end;

{ TCStr }

procedure TCStr.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := WideString(AArgs[0]);
end;

{ TChr }

procedure TChr.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  i: Integer;
  c: AnsiChar;
begin
  i := Integer(AArgs[0]);
  if (i < 0) or (i > 255) then
    VarCastError;

  c       := AnsiChar(i); // Chr function should threat an
  AResult := c;           // argument as ANSI char code.
end;

{ TExp }

procedure TExp.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Exp(AArgs[0]);
end;

{ TInt }

procedure TInt.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  d, i: Extended;
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
  begin
    d := AArgs[0];
    i := Int(d);

    if i > d then  // Int in Vb should convert, for example, -8.4 to -9,
      i := i - 1;  // while Delphi's Int will convert it to -8.
    AResult := i;
  end;
end;

{ TFix }

procedure TFix.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
    AResult := Int(AArgs[0]); // Int in Delphi works just like Fix in Vb,
                              // converting, for example, -8.4 to -8.
end;

{ TLog }

procedure TLog.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Ln(AArgs[0]);
end;

{ TRound }

procedure TRound.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  rndto: OleVariant;
begin
  if ACall.ArgCount = 1 then
    AResult := Round(AArgs[0])
  else if ACall.ArgCount = 2 then
  begin
    rndto := AArgs[1];
    if (rndto < 0) or (rndto > 16) then
      VarCastError;
    AResult := RoundTo(AArgs[0], -rndto);
  end
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);
end;

{ TSgn }

procedure TSgn.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  if VarIsNull(AArgs[0]) then
    VarCastError;

  if AArgs[0] > 0 then
    AResult := OleOne
  else if AArgs[0] < 0 then
    AResult := OleMinusOne
  else
    AResult := OleZero;
end;

{ TOct }

procedure TOct.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  val, rest: Word;   // Like in MS VbScript.
  res:       string;
begin
  val := AArgs[0];
  res := '';

  repeat
    rest := val mod 8;
    val  := val div 8;
    res  := Char(Ord('0') + rest) + res;
  until val = 0;

  AResult := res;
end;

{ THex }

procedure THex.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  val, rest: Word;   // Like in MS VbScript.
  res:       string;
begin
  val := AArgs[0];
  res := '';

  repeat
    rest := val mod 16;
    val  := val div 16;
    if rest < 10 then
      res := Char(Ord('0') + rest) + res
    else
      res := Char(Ord('A') + rest - 10) + res;
  until val = 0;

  AResult := res;
end;

{ TVbvbEmpty }

procedure TvbEmpty.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varEmpty;
  end;
end;

{ TVbvbNull }

procedure TvbNull.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varNull;
  end;
end;

{ TvbSmallInt }

procedure TvbSmallInt.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varSmallint;
  end;
end;

{ TvbInteger }

procedure TvbInteger.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varInteger;
  end;
end;

{ TVbvbSingle }

procedure TvbSingle.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varSingle;
  end;
end;

{ TVbvbDouble }

procedure TvbDouble.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varDouble;
  end;
end;

{ TVbvbCurrency }

procedure TvbCurrency.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varCurrency;
  end;
end;

{ TVbvbDate }

procedure TvbDate.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varDate;
  end;
end;

{ TVbvbString }

procedure TvbString.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varOleStr;
  end;
end;

{ TVbvbObject }

procedure TvbObject.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varDispatch;
  end;
end;

{ TVbvbError }

procedure TvbError.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varError;
  end;
end;

{ TVbvbBoolean }

procedure TvbBoolean.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varBoolean;
  end;
end;

{ TVbvbVariant }

procedure TvbVariant.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varVariant;
  end;
end;

{ TVbvbDataObject }

procedure TvbDataObject.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varUnknown;
  end;
end;

{ TVbvbByte }

procedure TvbByte.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varByte;
  end;
end;

{ TVbvbArray }

procedure TvbArray.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varArray;
  end;
end;

{ TVarType_ }

procedure TVarType_.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Integer(FindVarData(AArgs[0]).VType);
end;

{ TIsArray }

procedure TIsArray.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := (FindVarData(AArgs[0]).VType and varArray) <> 0;
end;

{ TIsDate }

procedure TIsDate.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  v:   PVarData;
  dtm: TDateTime;
begin
  v := FindVarData(AArgs[0]);

  case v.VType of
    varDate:
      AResult := True;
    varOleStr:
      AResult := TryStrToDateTime(string(v.VOleStr), dtm);
  else
    AResult := False;
  end;
end;

{ TIsEmpty }

procedure TIsEmpty.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := (FindVarData(AArgs[0]).VType = varEmpty);
end;

{ TIsNull }

procedure TIsNull.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := (FindVarData(AArgs[0]).VType = varNull);
end;

{ TIsNumeric }

procedure TIsNumeric.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  v: PVarData;
  flt: Extended;
begin
  v := FindVarData(AArgs[0]);

  case v.VType of
    varEmpty,
    varSmallint,
    varInteger,
    varSingle,
    varDouble,
    varCurrency,
    varError,
    varBoolean,
    varShortInt,
    varByte,
    varWord,
    varLongWord,
    varInt64:
      AResult := True;
    {$IFDEF LMDCOMP12}
    varUInt64:
      AResult := True;
    {$ENDIF}
    varOleStr:
      AResult := TryStrToFloat(v.VOleStr, flt);
  else
    AResult := False;
  end;
end;

{ TIsObject }

procedure TIsObject.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := (FindVarData(AArgs[0]).VType = varDispatch);
end;

{ TArray }

procedure TArray.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  bnds: array[0..1] of Integer;
  arr:  Variant;
  i:    Integer;
begin
  bnds[0] := 0;
  bnds[1] := ACall.ArgCount - 1;
  arr     := VarArrayCreate(bnds, varVariant);

  for i := 0 to ACall.ArgCount - 1 do
    VarArrayPut(arr, AArgs[i], i);

  AResult := arr;
end;

{ TLBound }

procedure TLBound.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  dim: Integer;
begin
  dim := 1; // Initialize.

  if ACall.ArgCount = 1 then
    dim := 1
  else if ACall.ArgCount = 2 then
    dim := AArgs[1]
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  AResult := VarArrayLowBound(AArgs[0], dim);
end;

{ TUBound }

procedure TUBound.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  dim: Integer;
begin
  dim := 1; // Initialize.

  if ACall.ArgCount = 1 then
    dim := 1
  else if ACall.ArgCount = 2 then
    dim := AArgs[1]
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  AResult := VarArrayHighBound(AArgs[0], dim);
end;

{ TDate }

procedure TDate.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Date;
end;

{ TNow }

procedure TNow.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Now;
end;

{ TTime }

procedure TTime.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Time;
end;

{ TYear }

procedure TYear.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  y, m, d: Word;
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
  begin
    DecodeDate(AArgs[0], y, m, d);
    AResult := y;
  end;
end;

{ TMonth }

procedure TMonth.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  y, m, d: Word;
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
  begin
    DecodeDate(AArgs[0], y, m, d);
    AResult := m;
  end;
end;

{ TDay }

procedure TDay.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  y, m, d: Word;
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
  begin
    DecodeDate(AArgs[0], y, m, d);
    AResult := d;
  end;
end;

{ THour }

procedure THour.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  h, m, s, ms: Word;
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
  begin
    DecodeTime(AArgs[0], h, m, s, ms);
    AResult := h;
  end;
end;

{ TMinute }

procedure TMinute.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  h, m, s, ms: Word;
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
  begin
    DecodeTime(AArgs[0], h, m, s, ms);
    AResult := m;
  end;
end;

{ TSecond }

procedure TSecond.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  h, m, s, ms: Word;
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
  begin
    DecodeTime(AArgs[0], h, m, s, ms);
    AResult := s;
  end;
end;

{ TWeekday }

procedure TWeekday.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  fsrday, wd: Integer;
  res:        Integer;
  a:          array[0..1] of Char;
begin
  fsrday := 1; // Initialize.

  if ACall.ArgCount = 1 then
    fsrday := 1
  else if ACall.ArgCount = 2 then
    fsrday := AArgs[1]
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
  begin
    if (fsrday < 0) or (fsrday > 7) then
      VarCastError;

    if fsrday = 0 then // Use NLS.
    begin
      if GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IFIRSTDAYOFWEEK,
                       a, SizeOf(a)) = 0 then  // In the range [0..6],
                                               // 0 = Munday.
        RaiseLastOSError;

      fsrday := (Ord(a[0]) - Ord('0')) - 5;
      if fsrday < 1 then
        Inc(fsrday, 7);
    end;

    wd  := DayOfWeek(AArgs[0]); // In the range [1..7], 1 = Sunday.
    res := wd - (fsrday - 1);
    if res < 1 then
      Inc(res, 7);
    AResult := res;
  end;
end;

{ TWeekdayName }

procedure TWeekdayName.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  fsrday, wd: Integer;
  short:      Boolean;
  a:          array[0..1] of Char;
begin
  wd     := 1; // In the range [1..7], 1 = depend of fsrday.
  short  := False;
  fsrday := 1;

  if ACall.ArgCount = 1 then
    wd := AArgs[0]
  else if ACall.ArgCount = 2 then
  begin
    wd    := AArgs[0];
    short := AArgs[1];
  end
  else if ACall.ArgCount = 3 then
  begin
    wd     := AArgs[0];
    short  := AArgs[1];
    fsrday := AArgs[2];
  end
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  if (wd < 1) or (wd > 7) then
    VarCastError;
  if (fsrday < 0) or (fsrday > 7) then
    VarCastError;

  if fsrday = 0 then // Use NLS.
  begin
    if GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IFIRSTDAYOFWEEK,
                     a, SizeOf(a)) = 0 then  // In the range [0..6],
                                             // 0 = Munday.
      RaiseLastOSError;

    fsrday := (Ord(a[0]) - Ord('0')) - 5;
    if fsrday < 1 then
      Inc(fsrday, 7);
  end;

  wd := wd + (fsrday - 1);
  if wd > 7 then
    Dec(wd, 7);

  if short then
    AResult := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames[wd]
  else
    AResult := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames[wd];
end;

{ TMonthName }

procedure TMonthName.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  month: Integer;
  short: Boolean;
begin
  month  := 1; // In the range [1..12].
  short  := False;

  if ACall.ArgCount = 1 then
    month := AArgs[0]
  else if ACall.ArgCount = 2 then
  begin
    month := AArgs[0];
    short := AArgs[1];
  end
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  if (month < 1) or (month > 12) then
    VarCastError;

  if short then
    AResult := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames[month]
  else
    AResult := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[month];
end;

{ TvbUseSystemDayOfWeek }

procedure TvbUseSystemDayOfWeek.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 0;
end;

{ TvbSunday }

procedure TvbSunday.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 1;
end;

{ TvbMonday }

procedure TvbMonday.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 2;
end;

{ TvbTuesday }

procedure TvbTuesday.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 3;
end;

{ TvbWednesday }

procedure TvbWednesday.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 4;
end;

{ TvbThursday }

procedure TvbThursday.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 5;
end;

{ TvbFriday }

procedure TvbFriday.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 6;
end;

{ TvbSaturday }

procedure TvbSaturday.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 7;
end;

{ TTypeName }

procedure TTypeName.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  v:   PVarData;
  res: string;
begin
  v := FindVarData(AArgs[0]);

  case v.VType and varTypeMask of
    varEmpty:     res := 'Empty';
    varNull:      res := 'Null';
    varSmallint:  res := 'SmallInt';
    varInteger:   res := 'Integer';
    varSingle:    res := 'Single';
    varDouble:    res := 'Double';
    varCurrency:  res := 'Currency';
    varDate:      res := 'Date';
    varOleStr:    res := 'String';
    varDispatch:  if v.VDispatch <> nil then
                    res := 'Object'
                  else
                    res := 'Nothing';
    varError:     res := 'Error';
    varBoolean:   res := 'Boolean';
    varVariant:   res := 'Variant';
    varUnknown:   res := 'DataObject';
    varShortInt:  res := 'ShortInt';
    varByte:      res := 'Byte';
    varWord:      res := 'Word';
    varLongWord:  res := 'LongWord';
    varInt64:     res := 'Int64';
    {$IFDEF LMDCOMP12}
    varUInt64:    res := 'UInt64';
    {$ENDIF}
  else
    res := 'Unknown';
  end;

  if (v.VType and varArray) <> 0 then
    res := res + '()';

  AResult := res;
end;

{ TDateSerial }

procedure TDateSerial.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  y, m, d: Integer;
  res:     TDateTime;
begin
  y := AArgs[0];
  m := AArgs[1];
  d := AArgs[2];

  if y > 0 then
  begin
    if y <= 29 then
      y := y + 2000
    else if y <= 99 then
      y := y + 1900;
  end
  else
    y := 2000 + y; // Initially, Y is negative.

  while m > 12 do
  begin
    Inc(y);
    Dec(m, 12);
  end;
  while m < 1 do
  begin
    Dec(y);
    Inc(m, 12);
  end;

  res     := EncodeDate(y, m, 1);
  res     := res + (d - 1);
  AResult := res;
end;

{ TTimeSerial }

procedure TTimeSerial.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  h, m, s: Integer;
  time:    TDateTime;
begin
  h := AArgs[0];
  m := AArgs[1];
  s := AArgs[2];

  time    := (h * (60 * 60) + m * 60 + s) / (24 * 60 * 60);
  AResult := time;
end;

{ TDateValue }

procedure TDateValue.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  date: TDateTime;
begin
  date    := VarToDate(AArgs[0]);
  date    := Trunc(date);
  AResult := date;
end;

{ TTimeValue }

procedure TTimeValue.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  date, time: TDateTime;
begin
  date    := VarToDate(AArgs[0]);
  time    := Frac(date);
  AResult := time;
end;

{ TDateAdd }

procedure TDateAdd.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
label
  LError;
var
  intvl:  WideString;
  intlen: Integer;
  val:    Integer;
  date:   TDateTime;
begin
  intvl  := WideLowerCase(AArgs[0]);
  intlen := Length(intvl);
  val    := AArgs[1];
  date   := VarToDate(AArgs[2]);


  if intlen > 1 then
  begin
    if intvl = 'yyyy' then
       date := IncMonth(date, val * 12) // year
    else if intvl = 'ww' then
      date := date + val * 7            // week
    else
      goto LError;
  end
  else if intlen = 1 then
  begin
    case intvl[1] of
      'd',
      'w',
      'y':    date := date + val;                // day
      'q':    date := IncMonth(date, val * 3);   // quarter
      'm':    date := IncMonth(date, val);       // month
      'h':    date := date + val / 24;           // hour
      'n':    date := date + val / (24 * 60);    // minute
      's':    date := date + val / (24 * 60 * 60)// second
    else
      goto LError;
    end;
  end
  else
    goto LError;

  AResult := date;
  Exit;

LError:
  VarCastError;;
end;

{ TTimer }

procedure TTimer.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Double(Time) * SecsPerDay;
end;

{ TRGB }

procedure TRGB.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  r, g, b: Byte;
begin
  r := AArgs[0];
  g := AArgs[1];
  b := AArgs[2];

  AResult := Windows.RGB(r, g, b);
end;

{ TJoin }

procedure TJoin.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  i:         Integer;
  arr:       OleVariant;
  delim:     WideString;
  low, hght: Integer;
  res:       WideString;
begin
  if ACall.ArgCount = 1 then
  begin
    arr   := AArgs[0];
    delim := ' ';
  end
  else if ACall.ArgCount = 2 then
  begin
    arr   := AArgs[0];
    delim := AArgs[1];
  end
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  if VarArrayDimCount(arr) <> 1 then
    VarCastError;

  res  := '';
  low  := VarArrayLowBound(arr, 1);
  hght := VarArrayHighBound(arr, 1);
  for i := low to hght do
  begin
    res := res + WideString(VarArrayGet(arr, i));
    if i <> hght then
      res := res + delim;
  end;

  AResult := res;
end;

{ TFilter }

procedure TFilter.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  arr:       OleVariant;
  val:       WideString;
  incl:      Boolean;
  txtcmp:    Boolean;
  low, hght: Integer;
  elem:      WideString;
  i:         Integer;
  equals:    Boolean;
  res:       array of WideString;
  cnt:       Integer;
  bnds:      array[0..1] of Integer;
begin
  arr    := AArgs[0];
  val    := AArgs[1];
  incl   := True;
  txtcmp := False;

  if ACall.ArgCount = 2 then
  begin
    incl   := True;
    txtcmp := False;
  end
  else if ACall.ArgCount = 3 then
  begin
    incl   := AArgs[2];
    txtcmp := False;
  end
  else if ACall.ArgCount = 4 then
  begin
    incl   := AArgs[2];
    txtcmp := (AArgs[3] = 1); // vbTextCompare
  end
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  if VarArrayDimCount(arr) <> 1 then
    VarCastError;

  low  := VarArrayLowBound(arr, 1);
  hght := VarArrayHighBound(arr, 1);
  cnt  := 0;
  SetLength(res, 4);

  for i := low to hght do
  begin
    elem := VarArrayGet(arr, i);

    if txtcmp then
      equals := WideSameText(elem, val)
    else
      equals := (elem = val);

    if equals = incl then
    begin
      if Length(res) = cnt then  // Grow.
        SetLength(res, cnt * 2); //
      res[cnt] := elem;
      Inc(cnt);
    end;
  end;

  bnds[0] := 0;
  bnds[1] := cnt - 1;
  AResult := VarArrayCreate(bnds, varVariant);

  for i := 0 to cnt - 1 do
    VarArrayPut(Variant(AResult), res[i], i);
end;

{ TRnd }

procedure TRnd.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := Random;
end;

{ TRandomize }

procedure TRandomize.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  Randomize;
end;

{ TvbBinaryCompare }

procedure TvbBinaryCompare.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 0;
end;

{ TvbTextCompare }

procedure TvbTextCompare.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 1;
end;

{ TCreateObject }

procedure TCreateObject.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := CreateOleObject(AArgs[0]);
end;

{ TGetObject }

procedure TGetObject.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := GetActiveOleObject(AArgs[0]);
end;

{ TAsc }

procedure TAsc.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  s: AnsiString;
begin
  s := AnsiString(AArgs[0]);
  if Length(s) = 0 then
    VarCastError;
  AResult := Ord(s[1]);
end;

{ TUCase }

procedure TUCase.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
    AResult := WideUpperCase(AArgs[0]);
end;

{ TLCase }

procedure TLCase.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
    AResult := WideLowerCase(AArgs[0]);
end;

{ TLen }

procedure TLen.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
    AResult := Length(WideString(AArgs[0]));
end;

{ TLTrim }

procedure TLTrim.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
    AResult := TrimLeft(AArgs[0]);
end;

{ TRTrim }

procedure TRTrim.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
    AResult := TrimRight(AArgs[0]);
end;

{ TTrim }

procedure TTrim.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
    AResult := Trim(AArgs[0]);
end;

{ TSpace }

procedure TSpace.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  n: Integer;
  s: WideString;
  i: Integer;
begin
  n := AArgs[0];
  if n < 0 then
    VarCastError;

  SetLength(s, n);
  for i := 1 to n do
    s[i] := ' ';
  AResult := s;
end;

{ TString }

procedure TString.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  n, c: Integer;
  s:    AnsiString;
  i:    Integer;
begin
  if VarIsNull(AArgs[0]) or VarIsNull(AArgs[1]) then
    AResult := OleNull
  else
  begin
    n := AArgs[0];
    c := AArgs[1];
    if n < 0 then
      VarCastError;

    SetLength(s, n);
    for i := 1 to n do
      s[i] := AnsiChar(c);
    AResult := s;
  end;
end;

{ TStrReverse }

procedure TStrReverse.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  s, res: WideString;
  len:    Integer;
  i:      Integer;
begin
  s   := AArgs[0];
  len := Length(s);

  SetLength(res, len);
  for i := 1 to len do
    res[len - i + 1] := s[i];
  AResult := res;
end;

{ TStrComp }

procedure TStrComp.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  txtcmp: Boolean;
begin
  txtcmp := False;

  if ACall.ArgCount = 2 then
    txtcmp := False
  else if ACall.ArgCount = 3 then
    txtcmp := (AArgs[2] = 1) // vbTextCompare
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  if VarIsNull(AArgs[0]) or VarIsNull(AArgs[1]) then
    AResult := OleNull
  else
  begin
    if txtcmp then
      AResult := -WideCompareText(AArgs[0], AArgs[1])
    else
      AResult := -WideCompareStr(AArgs[0], AArgs[1]);
  end;
end;

{ TLeft }

procedure TLeft.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  s:   WideString;
  len: Integer;
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
  begin
    s   := AArgs[0];
    len := AArgs[1];
    if len < 0 then
      VarCastError;

    s       := Copy(s, 1, len);
    AResult := s;
  end;
end;

{ TMid }

procedure TMid.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  s:          WideString;
  start, len: Integer;
begin
  len := MaxInt;

  if ACall.ArgCount = 2 then
    len := MaxInt
  else if ACall.ArgCount = 3 then
    len := AArgs[2]
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
  begin
    s     := AArgs[0];
    start := AArgs[1];
    if start < 1 then
      VarCastError;
    if len < 0 then
      VarCastError;

    s       := Copy(s, start, len);
    AResult := s;
  end;
end;

{ TRight }

procedure TRight.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  s:   WideString;
  len: Integer;
begin
  if VarIsNull(AArgs[0]) then
    AResult := OleNull
  else
  begin
    s   := AArgs[0];
    len := AArgs[1];
    if len < 0 then
      VarCastError;

    s       := Copy(s, Length(s) - len + 1, Length(s));
    AResult := s;
  end;
end;

{ TSplit }

procedure TSplit.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
label
  LResult;
var
  s, delim:    {$IFDEF LMDCOMP12}WideString{$ELSE}string{$ENDIF};
  res:         array of {$IFDEF LMDCOMP12}WideString{$ELSE}string{$ENDIF};
  sr:          {$IFDEF LMDCOMP12}PWideChar{$ELSE}PChar{$ENDIF};
  cnt, maxcnt: Integer;
  txtcmp:      Boolean;
  start, len:  Integer;
  sopts:       TStringSearchOptions;
  bnds:        array[0..1] of Integer;
  i:           Integer;
begin
  delim  := ' ';
  maxcnt := -1;
  txtcmp := False;

  if (ACall.ArgCount >= 1) and (ACall.ArgCount <= 4) then
  begin
    s := AArgs[0];

    if ACall.ArgCount >= 2 then
      delim := AArgs[1];
    if ACall.ArgCount >= 3 then
      maxcnt := AArgs[2];
    if ACall.ArgCount >= 4 then
      txtcmp := (AArgs[3] = 1); // vbTextCompare
  end
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  if maxcnt = -1 then
    maxcnt := MaxInt;

  cnt := 0;
  SetLength(res, 4);

  { Special cases }

  if (s = '') or (maxcnt = 0) then
    goto LResult;

  if delim = '' then
  begin
    cnt    := 1;
    res[0] := s;
    goto LResult;
  end;

  { Search }

  start := 1;
  sopts := [soDown];
  if not txtcmp then
    Include(sopts, soMatchCase);

  while cnt < maxcnt do
  begin
    sr := SearchBuf(@s[start], Length(s) - start + 1, 0, 0,
                    delim, sopts);
    if sr = nil then
      Break; // while

    len := sr - @s[start];

    if Length(res) = cnt then  // Grow.
      SetLength(res, cnt * 2); //
    res[cnt] := Copy(s, start, len);
    Inc(cnt);

    Inc(start, len + Length(delim));
  end;

  if cnt < maxcnt then         // Add last elem.
  begin
    if Length(res) = cnt then  // Grow.
      SetLength(res, cnt * 2); //
    res[cnt] := Copy(s, start, MaxInt);
    Inc(cnt);
  end;

  { Fill result array }

LResult:
  bnds[0] := 0;
  bnds[1] := cnt - 1;
  AResult := VarArrayCreate(bnds, varVariant);
  for i := 0 to cnt - 1 do
    VarArrayPut(Variant(AResult), res[i], i);
end;

{ TReplace }

procedure TReplace.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  s:           {$IFDEF LMDCOMP12}WideString{$ELSE}string{$ENDIF};
  find:        {$IFDEF LMDCOMP12}WideString{$ELSE}string{$ENDIF};
  rwith:       {$IFDEF LMDCOMP12}WideString{$ELSE}string{$ENDIF};
  sr:          {$IFDEF LMDCOMP12}PWideChar{$ELSE}PChar{$ENDIF};
  idx:         Integer;
  cnt, maxcnt: Integer;
  txtcmp:      Boolean;
  sopts:       TStringSearchOptions;
  start:       Integer;
  from, tail:  Integer;
begin
  idx    := 1;
  maxcnt := -1;
  txtcmp := False;

  if (ACall.ArgCount >= 1) and (ACall.ArgCount <= 6) then
  begin
    s     := AArgs[0];
    find  := AArgs[1];
    rwith := AArgs[2];

    if ACall.ArgCount >= 4 then
      idx := AArgs[3];
    if ACall.ArgCount >= 5 then
      maxcnt := AArgs[4];
    if ACall.ArgCount >= 6 then
      txtcmp := (AArgs[5] = 1); // vbTextCompare
  end
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  if maxcnt = -1 then
    maxcnt := MaxInt;
  s := Copy(s, idx, MaxInt);

  { Special cases }

  if s = '' then
  begin
    AResult := '';
    Exit;
  end;

  if find = '' then
  begin
    AResult := s;
    Exit;
  end;

  { Search/replace }

  cnt   := 0;
  start := 1;
  sopts := [soDown];
  if not txtcmp then
    Include(sopts, soMatchCase);

  while cnt < maxcnt do
  begin
    sr := SearchBuf(@s[start], Length(s) - start + 1, 0, 0, find, sopts);
    if sr = nil then
      Break; // while

    from := (sr - @s[1]) + 1;
    tail := from + Length(find);
    s    := Copy(s, 1, from - 1) + rwith +
            Copy(s, tail, MaxInt);

    start := from + Length(rwith);
    Inc(cnt);
  end;

  AResult := s;
end;

{ InStr }

procedure TInStr.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  s:      {$IFDEF LMDCOMP12}WideString{$ELSE}string{$ENDIF};
  find:   {$IFDEF LMDCOMP12}WideString{$ELSE}string{$ENDIF};
  sr:     {$IFDEF LMDCOMP12}PWideChar{$ELSE}PChar{$ENDIF};
  idx:    Integer;
  txtcmp: Boolean;
  sopts:  TStringSearchOptions;
  len:    Integer;
begin
  idx    := 1;
  txtcmp := False;

  if (ACall.ArgCount >= 2) and (ACall.ArgCount <= 4) then
  begin
    if ACall.ArgCount = 2 then   // Crazy Vb params sequence.
    begin                        //
      s     := AArgs[0];         //
      find  := AArgs[1];         //
    end                          //
    else                         //
    begin                        //
      idx   := AArgs[0];         //
      s     := AArgs[1];         //
      find  := AArgs[2];         //
    end;                         //

    if ACall.ArgCount = 4 then
      txtcmp := (AArgs[3] = 1);  // vbTextCompare
  end
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  if idx < 1 then
    idx := 1;
  len := Length(s) - idx + 1;

  if len <= 0 then
  begin
    AResult := 0;
    Exit;
  end;

  sopts := [soDown];
  if not txtcmp then
    Include(sopts, soMatchCase);
  sr := SearchBuf(@s[idx], len, 0, 0, find, sopts);

  if sr = nil then
    AResult := 0
  else
    AResult := (sr - @s[1]) + 1;
end;

{ InStrRev }

procedure TInStrRev.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  s:      {$IFDEF LMDCOMP12}WideString{$ELSE}string{$ENDIF};
  find:   {$IFDEF LMDCOMP12}WideString{$ELSE}string{$ENDIF};
  sr:     {$IFDEF LMDCOMP12}PWideChar{$ELSE}PChar{$ENDIF};
  idx:    Integer;
  txtcmp: Boolean;
  sopts:  TStringSearchOptions;
  len:    Integer;
begin
  idx    := -1;
  txtcmp := False;

  if (ACall.ArgCount >= 2) and (ACall.ArgCount <= 4) then
  begin
    s     := AArgs[0];
    find  := AArgs[1];

    if ACall.ArgCount >= 3 then  // Unlike InStr function, here
      idx := AArgs[2];           // index is a third parameter.
    if ACall.ArgCount = 4 then
      txtcmp := (AArgs[3] = 1);  // vbTextCompare
  end
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  if (idx = -1) or (idx > Length(s)) then
    idx := Length(s);
  len := idx;

  if len <= 0 then
  begin
    AResult := 0;
    Exit;
  end;

  sopts := []; // No soDown flag.
  if not txtcmp then
    Include(sopts, soMatchCase);
  sr := SearchBuf(@s[1], len, len, 0, find, sopts);

  if sr = nil then
    AResult := 0
  else
    AResult := (sr - @s[1]) + 1;
end;

{ TInputBox }

procedure TInputBox.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
var
  propmt: WideString;
  tittle: WideString;
  defval: WideString;
  s:      string;
begin
  tittle := '';
  defval := '';

  if (ACall.ArgCount >= 1) and (ACall.ArgCount <= 3) then
  begin
    propmt := AArgs[0];
    if ACall.ArgCount >= 2 then
      tittle := AArgs[1];
    if ACall.ArgCount = 3 then
      defval := AArgs[2];
  end
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  s := defval;
  if InputQuery(tittle, propmt, s) then
    AResult := s
  else
    AResult := OleUnassigned;
end;

{ TvbOKOnly }

procedure TvbOKOnly.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 0;
end;

{ TvbOKCancel }

procedure TvbOKCancel.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 1;
end;

{ TvbAbortRetryIgnore }

procedure TvbAbortRetryIgnore.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 2;
end;

{ TvbYesNoCancel }

procedure TvbYesNoCancel.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 3;
end;

{ TvbYesNo }

procedure TvbYesNo.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 4;
end;

{ TvbRetryCancel }

procedure TvbRetryCancel.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 5;
end;

{ TvbCritical }

procedure TvbCritical.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 16;
end;

{ TvbQuestion }

procedure TvbQuestion.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 32;
end;

{ TvbExclamation }

procedure TvbExclamation.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 48;
end;

{ TvbInformation }

procedure TvbInformation.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 64;
end;

{ TvbOK }

procedure TvbOK.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 1;
end;

{ TvbCancel }

procedure TvbCancel.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 2;
end;

{ TvbAbort }

procedure TvbAbort.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 3;
end;

{ TvbRetry }

procedure TvbRetry.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 4;
end;

{ TvbIgnore }

procedure TvbIgnore.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 5;
end;

{ TvbYes }

procedure TvbYes.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 6;
end;

{ TvbNo }

procedure TvbNo.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  AResult := 7;
end;

{ TMsgBox }

procedure TMsgBox.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
const
  BUTTONS: array[0..5] of TMsgDlgButtons = (
    [mbOk],                         // vbOKOnly
    [mbOk, mbCancel],               // vbOKCancel
    [mbAbort, mbRetry, mbIgnore],   // vbAbortRetryIgnore
    [mbYes, mbNo, mbCancel],        // vbYesNoCancel
    [mbYes, mbNo],                  // vbYesNoCancel
    [mbRetry, mbCancel]             // vbRetryCancel
  );
  DLG_KIND: array[0..7] of TMsgDlgType = (
    mtInformation,       // Not specified.
    mtError,             // vbCritical
    mtConfirmation,      // vbQuestion
    mtWarning,           // vbExclamation
    mtInformation,       // vbInformation
    mtInformation,       // Not specified.
    mtInformation,       // Not specified.
    mtInformation        // Not specified.
  );

  BTNS_MASK  = $00000007; // 0000111
  KIND_MASK  = $00000070; // 1110000
  KIND_SHIFT = 4;
var
  promt:  WideString;
  flags:  Integer;
  tittle: WideString;
  btns:   Integer;
  mr:     TModalResult;
begin
  flags  := 0;
  tittle := '';

  if (ACall.ArgCount >= 1) and (ACall.ArgCount <= 3) then
  begin
    promt := AArgs[0];

    if ACall.ArgCount >= 2 then
      flags := AArgs[1];
    if ACall.ArgCount = 3 then
      tittle := AArgs[2];
  end
  else
    ELMDVMRuntime.RaiseError(retInvalidParamCount);

  btns := flags and BTNS_MASK;
  if btns > 5 then
    btns := 0; // vbOKOnly

  mr := MessageDlg(promt, DLG_KIND[(flags and KIND_MASK) shr KIND_SHIFT],
                   BUTTONS[btns], 0);
  case mr of
    mrOk:       AResult := 1;  // vbOK
    mrCancel:   AResult := 2;  // vbCancel
    mrAbort:    AResult := 3;  // vbAbort
    mrRetry:    AResult := 4;  // vbRetry
    mrIgnore:   AResult := 5;  // vbIgnore
    mrYes:      AResult := 6;  // vbYes
    mrNo:       AResult := 7;  // vbNo
  else
    AResult := 0; // For sure.
  end;
end;

{ TGetRef }

procedure TGetRef.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  FVM.MakeEventHandler(AArgs[0], AResult);
end;

procedure TGetRef.Execute(AVM: TLMDVMBase; ACall: TLMDCall;
  AArgs: PLMDVarArray; var AResult: OleVariant);
begin
  FVM := AVM;
  inherited;
end;

{ TvbLongWord }

procedure TvbLongWord.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varLongWord;
  end;
end;

{ TvbShortInt }

procedure TvbShortInt.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varShortInt;
  end;
end;

{ TvbInt64 }

procedure TvbInt64.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varInt64;
  end;
end;

{ TvbUInt64 }

{$IFDEF LMDCOMP12}
procedure TvbUInt64.DoExecute(ACall: TLMDCall; AArgs: PLMDVarArray;
  var AResult: OleVariant);
begin
  with TVarData(AResult) do
  begin
    if (VType and VARDEEPDATA) <> 0 then
      VarClear(AResult);
    VType    := varInteger;
    VInteger := varUInt64;
  end;
end;
{$ENDIF}

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

end.
