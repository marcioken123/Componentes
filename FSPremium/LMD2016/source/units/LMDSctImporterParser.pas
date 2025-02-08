unit LMDSctImporterParser;
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

LMDSctImporterParser unit (YB)
------------------------------
LMD Script Pack Importer Object Pascal parser.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Variants, Dialogs, LMDSctImporterFileUtils,
  LMDSctImporterTree;

type
  {************************* class ELMDPasParseError **************************}

  ELMDPasParseError = class(Exception)
  private
    FSourcePos: Integer;
  public
    constructor Create(const Msg: string; ASourcePos: Integer = -1);
    constructor CreateFmt(const Msg: string; const Args: array of const;
                          ASourcePos: Integer = -1);
    property    SourcePos: Integer read FSourcePos write FSourcePos;
  end;

  {***************************** enum TLMDPasToken ****************************}

  TLMDPasToken = (

    { Identifier }

    ptIdentifier,

    { Constants }

    ptCString,
    ptCInteger,
    ptCFloat,

    { Reserved words }

    ptArray,
    ptAsm,
    ptAutomated,
    ptBegin,
    ptCase,
    ptClass,
    ptConst,
    ptConstructor,
    ptDestructor,
    ptDispinterface,
    ptDo,
    ptDownto,
    ptElse,
    ptEnd,
    ptExcept,
    ptExports,
    ptFile,
    ptFinalization,
    ptFinally,
    ptFor,
    ptFunction,
    ptGoto,
    ptIf,
    ptImplementation,
    ptInherited,
    ptInitialization,
    ptInline,
    ptInterface,
    ptLabel,
    ptLibrary,
    ptNil,
    ptObject,
    ptOf,
    ptOn,
    ptOut,
    ptPacked,
    ptProcedure,
    ptProgram,
    ptProperty,
    ptRaise,
    ptRecord,
    ptRepeat,
    ptResourcestring,
    ptSet,
    ptString,
    ptThen,
    ptThreadvar,
    ptTo,
    ptTry,
    ptType,
    ptUnit,
    ptUntil,
    ptUses,
    ptVar,
    ptWhile,
    ptWith,

    { Operators }

    ptAnd,
    ptAs,
    ptDereference,
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
    ptReference,
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

    { Comment }

    ptComment,
    ptDirective,
    ptIncludeFile,

    { EOf }

    ptEOf
  );
  TLMDPasTokens = set of TLMDPasToken;

  {*************************** class TLMDPasScanner ***************************}

  TLMDPasScannerDirective = (pcdInclude, pcdOther);
  TLMDPasScannerCondKind  = (ckIFDEF, ckIF);

  TLMDPasScannerCondState = record
    IsInElse: Boolean;
    Active:   Boolean;
    C:        PChar; // For debugging only.
  end;

  TLMDPasScannerCond = class
  public
    Parent:      TLMDPasScannerCond;
    ParentState: TLMDPasScannerCondState; // For savepoints.
    Kind:        TLMDPasScannerCondKind;
    IsInElse:    Boolean;
    Active:      Boolean;
    C:           PChar; // For debugging only.
  end;

  TLMDPasScannerFileState = record
    C:        PChar;
    Top:      TLMDPasScannerCond;
    TopState: TLMDPasScannerCondState
  end;

  TLMDPasScannerFile = class
  public
    Parent:      TLMDPasScannerFile;
    ParentState: TLMDPasScannerFileState; // For savepoints.
    Top:         TLMDPasScannerCond;
    SrcRef:      string; // Holds reference to source string to
                         // prevent it been deallocated while
                         // scanning. Optional, empty in some modes.
    Source:      PChar;
    C:           PChar;  // Current char.
  end;

  TLMDPasScannerDefine = class
    Prev:      TLMDPasScannerDefine;
    Name:      string;
    IsDefined: Boolean;
  end;

  TLMDPasScannerSavepoint = record
    Defines:   TLMDPasScannerDefine;
    File_:     TLMDPasScannerFile;
    FileState: TLMDPasScannerFileState;
  end;

  TLMDPasScannerInterpretIf = procedure(Sender: TObject; AExpr: PChar;
                                        out AResult: Boolean) of object;

  TLMDPasScannerMode = (psmNormal, psmInIfDirective);

  TLMDPasScanner = class
  private
    FFileHandler:   TLMDFileHandler;
    FMode:          TLMDPasScannerMode;
    FFiles:         TList;
    FConditions:    TList;
    FDefines:       TList;
    FDefineFirst:   TLMDPasScannerDefine;
    FDefinesLookup: TLMDPasScanner;
    FFile:          TLMDPasScannerFile; // Current file.
    FToken:         TLMDPasToken;
    FTokenPos:      Integer;
    FSData:         string;
    FIData:         Int64;
    FFData:         Extended;
    FOnInterpretIf: TLMDPasScannerInterpretIf;

    procedure AddFile(const ASource: string);
    procedure SaveFile(AFile: TLMDPasScannerFile;
                       out AState: TLMDPasScannerFileState);
    procedure RestoreFile(AFile: TLMDPasScannerFile;
                          const AState: TLMDPasScannerFileState);
    procedure AddCondition(AKind: TLMDPasScannerCondKind; AActive: Boolean);
    procedure SaveCondition(ACond: TLMDPasScannerCond;
                            out AState: TLMDPasScannerCondState);
    procedure RestoreCondition(ACond: TLMDPasScannerCond;
                               const AState: TLMDPasScannerCondState);
    function  FindDefineItem(const AName: string): TLMDPasScannerDefine;
    procedure Clear;
    function  GetIncSource(const AFileName: string): string;
    function  IsActiveContent: Boolean;

    procedure NextChar;
    function  GetCurCharPos: Integer;
    procedure SkipBlanks;
    procedure SkipToNextDirective;
    procedure ScanToken;
    function  ScanDirective(out AValue: string): TLMDPasToken;
    function  ScanNumber(AllowFloat: Boolean; out IntVal: Int64;
                         out FloatVal: Extended): TLMDPasToken;
    function  ScanIdentifier(out CanBeKeyword: Boolean): string;
    function  ScanString: string;
    function  ScanIncludeFileName: string;
    function  DetectReservedWord(const Token: string): TLMDPasToken;
    procedure NextToken;
  protected
    function InterpretIf(AExpr: PChar): Boolean; virtual;
  public
    constructor Create(AFileHandler: TLMDFileHandler);
    destructor Destroy; override;

    procedure Define(const Name: string);
    procedure Undefine(const Name: string);
    function  IsDefined(const Name: string): Boolean;

    function  TokenToStr(Token: TLMDPasToken): string;
    function  GetSavepoint: TLMDPasScannerSavepoint;
    procedure RollbackToSavepoint(S: TLMDPasScannerSavepoint);
    procedure Start(AMode: TLMDPasScannerMode; const Source: string);
    procedure SkipToken;

    property Mode: TLMDPasScannerMode read FMode;
    property Token: TLMDPasToken read FToken;
    property TokenPos: Integer read FTokenPos;
    property SData: string read FSData;
    property IData: Int64 read FIData;
    property FData: Extended read FFData;
    property OnInterpretIf: TLMDPasScannerInterpretIf read FOnInterpretIf write FOnInterpretIf;
  end;

  {**************************** class TLMDPasParser ***************************}

  TLMDParserToken  = TLMDPasToken;
  TLMDParserTokens = TLMDPasTokens;

  TLMDPasParserVisibility   = (pvPrivate, pvProtected, pvPublic, pvPublished);
  TLMDParserMemberKind      = (mkMethod, mkProperty, mkTypeSection,
                               mkConstSection, mkVarSection);
  TLMDPasParserExprType     = (etInteger, etFloat, etString, etPointer,
                               etBoolean, etUnknown);
  TLMDParserRelOp           = (roGreater, roLess, roLessEqual, roGreaterEqual,
                               roNotEqual, roEqual, roIn, roIs, roAs);
  TLMDParserMulOp           = (moMultiply, moDivide, moDiv, moMod, moAnd,
                               moShl, moShr);
  TLMDParserUnaryOp         = (uoNot, uoMinus, uoPlus);
  TLMDParserAddOp           = (aoPlus, aoMinus, aoOr, aoXor);
  TLMDPasParserExprResult   = record
    ConstKind: TLMDPasConstKind;
    Val:       Variant; // Optional.
  end;

  TLMDPasParserFindDirectiveConst = function(const AConstName: string;
                                             out AValue: Variant): Boolean of object;

  TLMDPasParser = class
  private
    FUnit:          TLMDPasUnit;
    FScanner:       TLMDPasScanner;
    FFindConstProc: TLMDPasParserFindDirectiveConst;

    function GetCurToken: TLMDParserToken;
  protected
    procedure InvalidTokenError(AToken: TLMDParserToken);
    procedure StrExpectedError(const AStr: string);
    procedure CheckTokens(ATokens: TLMDParserTokens);
    procedure CheckAndSkipTokens(ATokens: TLMDParserTokens);
    procedure SkipToken;
    property  CurToken: TLMDParserToken read GetCurToken;

    procedure ScannerInterpretIf(Sender: TObject; AExpr: PChar;
                                 out AResult: Boolean);

    function  UnknownExprRes: TLMDPasParserExprResult;
    function  IsValKnown(const R: TLMDPasParserExprResult): Boolean;
    function  AnalyzeRelOp(AOp: TLMDParserRelOp;
                           L, R: TLMDPasParserExprResult): TLMDPasParserExprResult;
    function  AnalyzeAddOp(AOp: TLMDParserAddOp;
                           L, R: TLMDPasParserExprResult): TLMDPasParserExprResult;
    function  AnalyzeMulOp(AOp: TLMDParserMulOp;
                           L, R: TLMDPasParserExprResult): TLMDPasParserExprResult;
    function  AnalyzeUnaryOp(AOp: TLMDParserUnaryOp;
                             R: TLMDPasParserExprResult): TLMDPasParserExprResult;
    procedure AddProc(AProc: TLMDPasProcHeading; AddTo: TLMDPasNamedNodes);
  protected
    procedure ParseUnitInterface;
    procedure ParseUsesClause;
    function  IsPortabilityDirective: Boolean;
    function  TryParsePortabilityDirective: Boolean;
    procedure ParseInterfaceSection;
    procedure ParseInterfaceDecl;
    procedure ParseExportedHeading;
    procedure ParseConstSection;
    function  ParseConstantDecl: TLMDPasConstDecl;
    procedure ParseTypeSection;
    function  ParseTypeDecl: TLMDPasTypeDecl;   // Returns nil in case of forward
                                                // declaration.
    function  IsAnsiStringDecl: Boolean;
    function  ParseAnsiStringDecl: TLMDPasTypeId;
    procedure ParseTemplateParams;
    procedure ParseTemplateParam;
    procedure ParseTemplateConstraint;
    procedure ParseDotNetAttr;
    procedure ParseVarSection;
    procedure ParseVarDecl(Result: TList);
    function  ParseType: TLMDPasType;
    function  IsRestrictedType: Boolean;
    function  ParseRestrictedType(isTObject: Boolean = False): TLMDPasType;
                                             // Returns nil in case of forward
                                             // declaration.
    function  ParseTypeId: TLMDPasTypeId;
    procedure ParseTemplateArg;
    procedure ParseTemplateArgs;
    function  ParseStringType: TLMDPasTypeId;
    function  CanBeSubrangeType: Boolean;
    function  ParseSubrangeType: TLMDPasSubrangeType;
    function  ParseEnumeratedType: TLMDPasEnumType;
    function  ParseEnumeratedTypeElement: string;
    function  ParsePointerType: TLMDPasPointerType;
    function  IsProcedureType: Boolean;
    function  ParseProcedureType: TLMDPasProcType;
    procedure ParseFunctionTypeHeading(AType: TLMDPasProcType);
    procedure ParseProcedureTypeHeading(AType: TLMDPasProcType);
    function  ParseClassRefType: TLMDPasClassRefType;
    function  ParseStrucType: TLMDPasType;
    function  ParseArrayType: TLMDPasArrayTypeBase; // Returns TPasStaticArrayType or
                                                    // TPasDynamicArrayType instance.
    function  ParseRecType: TLMDPasRecordType;
    procedure AddSpecialMethods(AType: TLMDPasRecordType);
    procedure ParseRecMembersSection(AType: TLMDPasRecordType;
                                     AVisibility: TLMDPasParserVisibility);
    procedure ParseRecVariantSection(AType: TLMDPasRecordType);
    procedure ParseRecVariant(AType: TLMDPasRecordType);
    function  ParseSetType: TLMDPasSetType;
    function  ParseFileType: TLMDPasFileType;
    function  ParseClassType(isTObject: Boolean = False): TLMDPasClassType;
                                             // Returns nil in case of forward
                                             // declaration.
    procedure ParseClassHeritage(AType: TLMDPasClassType);
    procedure ParseClassMembersSection(AType: TLMDPasClassType;
                                       AVisibility: TLMDPasParserVisibility);
    function  IsVisibility: Boolean;
    function  ParseVisibility: TLMDPasParserVisibility;
    function  DetectMemberKind: TLMDParserMemberKind;
    procedure ParseFieldDecl(AResult: TLMDPasNamedNodes;
                             AVisibility: TLMDPasParserVisibility;
                             AIsClassField: Boolean);
    function  ParsePropertyDecl(AIsProtected: Boolean): TLMDPasPropertyBase;
    function  ParsePropertySpecifier: string;
    function  ParseMethodDecl(out IsOverride: Boolean): TLMDPasProcHeading; // Returns nil in the
                                                                            // following cases:
                                                                            // - interface method
                                                                            //   renaming,
                                                                            // - class constructor,
                                                                            // - class destructor,
                                                                            // - class operator.
    function  ParseConstructorHeading: TLMDPasProcHeading;
    function  ParseDestructorHeading: TLMDPasProcHeading;
    procedure ParseInnerTypeSection;
    procedure ParseInnerConstSection(AResult: TLMDPasNamedNodes;
                                     AVisibility: TLMDPasParserVisibility);
    procedure ParseInnerVarSection(AResult: TLMDPasNamedNodes;
                                   AVisibility: TLMDPasParserVisibility);
    function  ParseInterfaceType: TLMDPasInterfaceType; // Returns nil in case of
                                                        // forward declaration.
    procedure ParseInterfaceHeritage(AType: TLMDPasInterfaceType);
    procedure ParseInterfaceGuid;
    function  ParseFunctionHeading(IsClassFunc, IsOperator: Boolean): TLMDPasProcHeading;
    function  ParseProcedureHeading(IsClassProc: Boolean): TLMDPasProcHeading;
    procedure ParseFormalParameters(Result: TLMDPasParameters);
    procedure ParseFormalParam(Result: TList);
    procedure ParseTypedConstant;
    procedure ParseArrayConstant;
    procedure ParseRecordConstant;
    function  ParseIdentifier: string;
    procedure ParseIdentList(Result: TStrings = nil);
    procedure ParseFormalParamNames(Result: TStrings = nil);
    function  ParseExpression: TLMDPasParserExprResult;
    function  ParseSimpleExpression: TLMDPasParserExprResult;
    function  ParseTerm: TLMDPasParserExprResult;
    function  ParseFactor: TLMDPasParserExprResult;
    function  ParseRelOp: TLMDParserRelOp;
    function  ParseAddOp: TLMDParserAddOp;
    function  ParseMulOp: TLMDParserMulOp;
    function  ParseDesignator: TLMDPasParserExprResult;
    procedure ParseSetConstructor;
    procedure ParseSetElement;
    function  IsDirective: Boolean;
    procedure ParseDirective(AProc: TLMDPasProcHeading = nil);
    procedure ParseProcDirective(AProc: TLMDPasProcHeading = nil);
    function  IsProcDirective: Boolean;
    function  IsVirtualDirective: Boolean;
    procedure ParseVirtualDirective;
  public
    constructor Create(AFileHandler: TLMDFileHandler;
                       AFindConstProc: TLMDPasParserFindDirectiveConst);
    destructor Destroy; override;

    function  Parse(const ASource: string): TLMDPasUnit;
    function  ParseIfDirective(const AExpr: PChar): TLMDPasParserExprResult;
    procedure Define(const Name: string);
    procedure Undefine(const Name: string);
    function  IsDefined(const Name: string): Boolean;
  end;

implementation

uses
  LMDSctCst;

{***************************** constant PasTokens *****************************}

type
  TPasTokenDescription = record
    S:         string;
    IsKeyword: Boolean;
  end;

const
  PasTokens: array[TLMDPasToken] of TPasTokenDescription = (
    (S: 'identifier';         IsKeyword: False;    ), { ptIdentifier }
    (S: 'string constant';    IsKeyword: False;    ), { ptCString }
    (S: 'number';             IsKeyword: False;    ), { ptCInteger }
    (S: 'real constant';      IsKeyword: False;    ), { ptCFloat }
    (S: 'array';              IsKeyword: True;     ), { ptArray }
    (S: 'asm';                IsKeyword: True;     ), { ptAsm }
    (S: 'automated';          IsKeyword: True;     ), { ptAutomated }
    (S: 'begin';              IsKeyword: True;     ), { ptBegin }
    (S: 'case';               IsKeyword: True;     ), { ptCase }
    (S: 'class';              IsKeyword: True;     ), { ptClass }
    (S: 'const';              IsKeyword: True;     ), { ptConst }
    (S: 'constructor';        IsKeyword: True;     ), { ptConstructor }
    (S: 'destructor';         IsKeyword: True;     ), { ptDestructor }
    (S: 'dispinterface';      IsKeyword: True;     ), { ptDispinterface }
    (S: 'do';                 IsKeyword: True;     ), { ptDo }
    (S: 'downto';             IsKeyword: True;     ), { ptDownto }
    (S: 'else';               IsKeyword: True;     ), { ptElse }
    (S: 'end';                IsKeyword: True;     ), { ptEnd }
    (S: 'except';             IsKeyword: True;     ), { ptExcept }
    (S: 'exports';            IsKeyword: True;     ), { ptExports }
    (S: 'file';               IsKeyword: True;     ), { ptFile }
    (S: 'finalization';       IsKeyword: True;     ), { ptFinalization }
    (S: 'finally';            IsKeyword: True;     ), { ptFinally }
    (S: 'for';                IsKeyword: True;     ), { ptFor }
    (S: 'function';           IsKeyword: True;     ), { ptFunction }
    (S: 'goto';               IsKeyword: True;     ), { ptGoto }
    (S: 'if';                 IsKeyword: True;     ), { ptIf }
    (S: 'implementation';     IsKeyword: True;     ), { ptImplementation }
    (S: 'inherited';          IsKeyword: True;     ), { ptInherited }
    (S: 'initialization';     IsKeyword: True;     ), { ptInitialization }
    (S: 'inline';             IsKeyword: True;     ), { ptInline }
    (S: 'interface';          IsKeyword: True;     ), { ptInterface }
    (S: 'label';              IsKeyword: True;     ), { ptLabel }
    (S: 'library';            IsKeyword: True;     ), { ptLibrary }
    (S: 'nil';                IsKeyword: True;     ), { ptNil }
    (S: 'object';             IsKeyword: True;     ), { ptObject }
    (S: 'of';                 IsKeyword: True;     ), { ptOf }
    (S: 'on';                 IsKeyword: True;     ), { ptOn }
    (S: 'out';                IsKeyword: True;     ), { ptOut }
    (S: 'packed';             IsKeyword: True;     ), { ptPacked }
    (S: 'procedure';          IsKeyword: True;     ), { ptProcedure }
    (S: 'program';            IsKeyword: True;     ), { ptProgram }
    (S: 'property';           IsKeyword: True;     ), { ptProperty }
    (S: 'raise';              IsKeyword: True;     ), { ptRaise }
    (S: 'record';             IsKeyword: True;     ), { ptRecord }
    (S: 'repeat';             IsKeyword: True;     ), { ptRepeat }
    (S: 'resourcestring';     IsKeyword: True;     ), { ptResourcestring }
    (S: 'set';                IsKeyword: True;     ), { ptSet }
    (S: 'string';             IsKeyword: True;     ), { ptString }
    (S: 'then';               IsKeyword: True;     ), { ptThen }
    (S: 'threadvar';          IsKeyword: True;     ), { ptThreadvar }
    (S: 'to';                 IsKeyword: True;     ), { ptTo }
    (S: 'try';                IsKeyword: True;     ), { ptTry }
    (S: 'type';               IsKeyword: True;     ), { ptType }
    (S: 'unit';               IsKeyword: True;     ), { ptUnit }
    (S: 'until';              IsKeyword: True;     ), { ptUntil }
    (S: 'uses';               IsKeyword: True;     ), { ptUses }
    (S: 'var';                IsKeyword: True;     ), { ptVar }
    (S: 'while';              IsKeyword: True;     ), { ptWhile }
    (S: 'with';               IsKeyword: True;     ), { ptWith }
    (S: 'and';                IsKeyword: True;     ), { ptAnd }
    (S: 'as';                 IsKeyword: True;     ), { ptAs }
    (S: '^';                  IsKeyword: False;    ), { ptDereference }
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
    (S: '@';                  IsKeyword: False;    ), { ptReference }
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
    (S: 'comment';            IsKeyword: False;    ), { ptComment }
    (S: 'directive';          IsKeyword: False;    ), { ptDirective }
    (S: 'directive';          IsKeyword: False;    ), { ptIncludeFile }
    (S: 'end of file';        IsKeyword: False;    )  { ptEOf }
  );

const
  IdentifierTokens              = [ptIdentifier];
  IdentListTokens               = IdentifierTokens;
  RelOpTokens                   = [ptGreater] + [ptLess] + [ptLessEqual] +
                                  [ptGreaterEqual] + [ptNotEqual] + [ptEqual] +
                                  [ptIn] + [ptIs] + [ptAs];
  AddOpTokens                   = [ptPlus] + [ptMinus] + [ptOr] + [ptXor];
  MulOpTokens                   = [ptMultiply] + [ptDivide] + [ptDiv] +
                                  [ptMod] + [ptAnd] + [ptShl] + [ptShr];
  SetConstructorTokens          = [ptOpenBlock];
  DesignatorTokens              = IdentifierTokens;
  FactorTokens                  = [ptReference] + DesignatorTokens +
                                  [ptCInteger] + [ptCFloat] + [ptCString] +
                                  [ptNil] + [ptOpenRound] + [ptNot] +
                                  [ptMinus] + [ptPlus] + SetConstructorTokens +
                                  [ptString];
  TermTokens                    = FactorTokens;
  SimpleExpressionTokens        = TermTokens;
  ExpressionTokens              = SimpleExpressionTokens;
  SetElementTokens              = ExpressionTokens;
  DirectiveTokens               = IdentifierTokens + [ptInline];
  PortabilityDirectiveTokens    = IdentifierTokens + [ptLibrary];
  ProcDirectiveTokens           = DirectiveTokens + PortabilityDirectiveTokens +
                                  [ptIdentifier];
  VirtualDirectiveTokens        = [ptIdentifier];
  DotNetAttrTokens              = [ptOpenBlock];
  FunctionHeadingTokens         = [ptFunction];
  ProcedureHeadingTokens        = [ptProcedure];
  FieldDeclTokens               = IdentListTokens;
  PropertyDeclTokens            = [ptClass, ptProperty];
  PropertySpecifierTokens       = IdentifierTokens;
  ConstructorHeadingTokens      = [ptConstructor];
  DestructorHeadingTokens       = [ptDestructor];
  MethodDeclTokens              = ProcedureHeadingTokens + FunctionHeadingTokens +
                                  ConstructorHeadingTokens + DestructorHeadingTokens +
                                  [ptClass];
  InnerTypeSectionTokens        = [ptType];
  InnerConstSectionTokens       = [ptConst];
  InnerVarSectionTokens         = [ptClass, ptVar, ptThreadvar];
  TypeIdTokens                  = IdentifierTokens;
  StringTypeTokens              = [ptString];
  SubrangeTypeTokens            = ExpressionTokens;
  EnumeratedTypeTokens          = [ptOpenRound];
  EnumeratedTypeElementTokens   = IdentifierTokens;
  PointerTypeTokens             = [ptDereference];
  ProcedureTypeTokens           = IdentifierTokens + ProcedureHeadingTokens +
                                  FunctionHeadingTokens;
  FunctionTypeHeadingTokens     = [ptFunction];
  ProcedureTypeHeadingTokens    = [ptProcedure];
  ClassRefTypeTokens            = [ptClass];
  ArrayTypeTokens               = [ptArray];
  RecTypeTokens                 = [ptRecord];
  RecMembersSectionTokens       = DotNetAttrTokens + FieldDeclTokens +
                                  MethodDeclTokens + PropertyDeclTokens +
                                  InnerTypeSectionTokens + InnerConstSectionTokens +
                                  InnerVarSectionTokens;
  RecVariantSectionTokens       = [ptCase];
  RecVariantTokens              = ExpressionTokens;
  SetTypeTokens                 = [ptSet];
  FileTypeTokens                = [ptFile];
  ClassTypeTokens               = [ptClass];
  ClassHeritageTokens           = [ptOpenRound];
  ClassMembersSectionTokens     = DotNetAttrTokens + FieldDeclTokens +
                                  MethodDeclTokens + PropertyDeclTokens +
                                  InnerTypeSectionTokens + InnerConstSectionTokens +
                                  InnerVarSectionTokens;
  VisibilityTokens              = [ptIdentifier];
  InterfaceTypeTokens           = [ptInterface, ptDispinterface];
  InterfaceHeritageTokens       = [ptOpenRound];
  InterfaceGuidTokens           = [ptOpenBlock];
  StrucTypeTokens               = [ptPacked] + ArrayTypeTokens + SetTypeTokens +
                                  FileTypeTokens + RecTypeTokens;
  RestrictedTypeTokens          = ClassTypeTokens + InterfaceTypeTokens;
  TypeTokens                    = TypeIdTokens + StringTypeTokens +
                                  SubrangeTypeTokens + EnumeratedTypeTokens +
                                  PointerTypeTokens + ProcedureTypeTokens +
                                  ClassRefTypeTokens + StrucTypeTokens;
  InterfaceSectionTokens        = [ptInterface];
  ConstSectionTokens            = [ptConst, ptResourcestring];
  TypeSectionTokens             = [ptType];
  VarSectionTokens              = [ptVar, ptThreadvar];
  ExportedHeadingTokens         = DotNetAttrTokens + ProcedureHeadingTokens +
                                  FunctionHeadingTokens;
  InterfaceDeclTokens           = ConstSectionTokens + TypeSectionTokens +
                                  VarSectionTokens + ExportedHeadingTokens +
                                  DotNetAttrTokens;
  ConstantDeclTokens            = IdentifierTokens;
  TypeDeclTokens                = IdentifierTokens;
  AnsiStringDeclTokens          = [ptIdentifier];
  TemplateParamsTokens          = [ptLess];
  TemplateParamTokens           = IdentListTokens;
  TemplateConstraintTokens      = TypeIdTokens + [ptClass, ptRecord,
                                  ptConstructor];
  VarDeclTokens                 = IdentListTokens;
  TemplateArgTokens             = TypeIdTokens + [ptString];
  TemplateArgsTokens            = [ptLess];
  FormalParamTokens             = DotNetAttrTokens + [ptVar] + [ptConst] +
                                  [ptOut] + IdentListTokens;
  FormalParametersTokens        = FormalParamTokens;
  ArrayConstantTokens           = [ptOpenRound];
  RecordConstantTokens          = [ptOpenRound];
  TypedConstantTokens           = ExpressionTokens + RecordConstantTokens +
                                  ArrayConstantTokens;
  UnitInterfaceTokens           = [ptUnit];
  UsesClauseTokens              = [ptUses];

{**************************** class TLMDPasScanner ****************************}
{ --------------------------------- private ---------------------------------- }

procedure TLMDPasScanner.NextChar;
begin
  if (FFile.C <> nil) and (FFile.C^ <> #0) then
    Inc(FFile.C);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.GetCurCharPos: Integer;
begin
  if FFile.C = nil then
    Result := 0
  else
    Result := FFile.C - FFile.Source;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.GetIncSource(const AFileName: string): string;
var
  incpth: string;
  txt:    TStringList;
begin
  if (FFileHandler = nil) or not FFileHandler.FindINCFile(AFileName,
                                                          incpth) then
    raise ELMDPasParseError.CreateFmt(SLMDIncFileNotFound, [AFileName]);

  txt := TStringList.Create;
  try
    txt.LoadFromFile(incpth);
    Result := txt.Text;
  finally
    txt.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.SkipBlanks;
begin
  if FFile.C <> nil then
  begin
    while (FFile.C^ <> #0) and not ((FFile.C^ <= #255) and
                                    (AnsiChar(FFile.C^) in [#33..#255])) do
      Inc(FFile.C);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.ScanToken;
var
  tknpos:  Integer;
  tkn:     TLMDPasToken;
  sdt:     string;
  errc:    Char;
  idt:     Int64;
  fdt:     Extended;
  chckkw:  Boolean;
begin
  tknpos := GetCurCharPos;

  case FFile.C^ of
    '&',
    'A'..'Z',
    'a'..'z',
    '_':          begin
                    sdt := ScanIdentifier(chckkw);
                    tkn := ptIdentifier;
                    if chckkw then
                      tkn := DetectReservedWord(sdt);
                  end;
    '0'..'9',
    '$':          begin
                    tkn := ScanNumber(True, idt, fdt);
                  end;
    '''', '#':    begin
                    sdt := ScanString;
                    tkn := ptCString;
                  end;
    '=':          begin
                    tkn := ptEqual;
                    NextChar;
                  end;
    '>':          begin
                    NextChar;
                    if FFile.C^ = '=' then
                    begin
                      tkn := ptGreaterEqual;
                      NextChar;
                    end
                    else tkn := ptGreater;
                  end;
    '<':          begin
                    NextChar;
                    if FFile.C^ = '=' then
                    begin
                      tkn := ptLessEqual;
                      NextChar;
                    end
                    else if FFile.C^ = '>' then
                    begin
                      tkn := ptNotEqual;
                      NextChar;
                    end
                    else tkn := ptLess;
                  end;
    ':':          begin
                    NextChar;
                    if FFile.C^ = '=' then
                    begin
                      tkn := ptAssignment;
                      NextChar;
                    end
                    else tkn := ptColon;
                  end;
    '/':          begin
                    NextChar;
                    if FFile.C^ = '/' then
                    begin
                      { Comment }

                      NextChar;
                      while not ((FFile.C^ <= #255) and
                                 (AnsiChar(FFile.C^) in [#0, #13, #10])) do
                        NextChar;

                      tkn := ptComment;
                    end
                    else
                      tkn := ptDivide;
                  end;
    '{':          begin
                    { Comment or directive }

                    NextChar;
                    tkn := ptComment;

                    if FFile.C^ = '$' then
                    begin
                      NextChar;
                      tkn := ScanDirective(sdt);
                    end;

                    while not ((FFile.C^ <= #255) and
                               (AnsiChar(FFile.C^) in [#0, '}'])) do
                      NextChar;

                    if FFile.C^ = '}' then
                      NextChar;
                  end;
    '(':          begin
                    NextChar;
                    if FFile.C^ = '*' then
                    begin
                      { Comment or directive }

                      NextChar;
                      tkn := ptComment;

                      if FFile.C^ = '$' then
                      begin
                        NextChar;
                        tkn := ScanDirective(sdt);
                      end;

                      while FFile.C^ <> #0 do
                      begin
                        if FFile.C^ = '*' then
                        begin
                          NextChar;
                          if FFile.C^ = ')' then
                          begin
                            NextChar;
                            Break;
                          end;
                        end
                        else
                          NextChar;
                      end;
                    end
                    else
                      tkn := ptOpenRound;
                  end;
    '.':          begin
                    NextChar;
                    if FFile.C^ = '.' then
                    begin
                      tkn := ptDoublePeriod;
                      NextChar;
                    end
                    else tkn := ptPeriod;
                  end;
    ')':          begin tkn := ptCloseRound; NextChar; end;
    '[':          begin tkn := ptOpenBlock; NextChar; end;
    ']':          begin tkn := ptCloseBlock; NextChar; end;
    ',':          begin tkn := ptComma; NextChar; end;
    '@':          begin tkn := ptReference; NextChar; end;
    '^':          begin tkn := ptDereference; NextChar; end;
    ';':          begin tkn := ptSemiColon; NextChar; end;
    '+':          begin tkn := ptPlus; NextChar; end;
    '-':          begin tkn := ptMinus; NextChar; end;
    '*':          begin tkn := ptMultiply; NextChar; end;
  else
    // So, after long playing with $IF directive I've deducted very strange
    // Delphi's way to handle end of directive:
    //   - The parser interpret any illegal symbol (including '}') as an
    //     identifier, moreover the Delphi scanner seems to not set the string
    //     value of it, so in reported errors the identifier value is just the
    //     value of last parsed real identifier.
    //   - The parser does not handle '*)' in some special way, so it is not
    //     possible to write (*$IF xxx*), because the second '*' will be
    //     interpreted as a multiplication operator.

    if FMode = psmInIfDirective then
    begin
      tkn := ptIdentifier;
      sdt := FFile.C^;
    end
    else
    begin
      errc := FFile.C^;
      NextChar; // Get next char to make ErrorPos proper.
      raise ELMDPasParseError.CreateFmt(SLMDIllegalChar, [errc, Ord(errc)],
                                        GetCurCharPos);
    end;
  end;

  FTokenPos := tknpos;
  FToken    := tkn;

  case tkn of
    ptIdentifier,
    ptCString,
    ptIncludeFile: FSData := sdt;
    ptCInteger:    FIData := idt;
    ptCFloat:      FFData := fdt;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.ScanNumber(AllowFloat: Boolean; out IntVal: Int64;
  out FloatVal: Extended): TLMDPasToken;
var
  cbegin:       PChar;
  isFloat:      Boolean;
  oldCurChar:   PChar;
  s:            string;
  valCode:      Integer;
begin
  cbegin  := FFile.C;
  isFloat := False;

  case FFile.C^ of
    '0'..'9':
      begin
        while (FFile.C^ <= #255) and (AnsiChar(FFile.C^) in ['0'..'9']) do
        begin
          NextChar;
          if (FFile.C^ = '.') and AllowFloat then
          begin
            oldCurChar := FFile.C;
            NextChar;
            if FFile.C^ = '.' then // Handle ptDoublePeriod
              FFile.C := oldCurChar
            else
              isFloat := True;
          end;
        end;
        if (FFile.C^ <= #255) and (AnsiChar(FFile.C^) in ['E', 'e']) and
           AllowFloat then
        begin
          isFloat := True;
          NextChar;

          if (FFile.C^ <= #255) and (AnsiChar(FFile.C^) in ['+', '-']) then
            NextChar;
          while (FFile.C^ <= #255) and (AnsiChar(FFile.C^) in ['0'..'9']) do
            NextChar;
        end;

        SetString(s, cbegin, FFile.C - cbegin);

        if isFloat then
        begin
          Val(s, FloatVal, valCode);
          if valCode <> 0 then
            raise ELMDPasParseError.Create(SLMDWrongFloat, GetCurCharPos);
          Result := ptCFloat;
        end
        else
        begin
          Val(s, IntVal, valCode);
          if valCode <> 0 then
            raise ELMDPasParseError.Create(SLMDWrongInteger, GetCurCharPos);
          Result := ptCInteger;
        end;
      end;
    '$':
      begin
        NextChar;
        while (FFile.C^ <= #255) and
              (AnsiChar(FFile.C^) in ['0'..'9', 'A'..'F', 'a'..'f']) do
          NextChar;

        SetString(s, cbegin, FFile.C - cbegin);
        Val(s, IntVal, valCode);
        if valCode <> 0 then
          raise ELMDPasParseError.Create(SLMDWrongInteger, GetCurCharPos);
        Result := ptCInteger;
      end;
  else
    raise ELMDPasParseError.Create(SLMDWrongInteger, GetCurCharPos);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.SaveCondition(ACond: TLMDPasScannerCond;
  out AState: TLMDPasScannerCondState);
begin
  if ACond <> nil then
  begin
    AState.IsInElse := ACond.IsInElse;
    AState.Active   := ACond.Active;
    AState.C        := ACond.C;
  end;
end;

procedure TLMDPasScanner.SaveFile(AFile: TLMDPasScannerFile;
  out AState: TLMDPasScannerFileState);
begin
  if AFile <> nil then
  begin
    AState.C   := AFile.C;
    AState.Top := AFile.Top;
    SaveCondition(AFile.Top, AState.TopState);
  end;
end;

function TLMDPasScanner.ScanDirective(out AValue: string): TLMDPasToken;
var
  name: string;
  kwd:  Boolean;
begin
  Result := ptDirective;
  Name   := ScanIdentifier(kwd);

  if FMode = psmInIfDirective then
    raise ELMDPasParseError.CreateFmt(SLMDInvalidDirective, [name]);
  SkipBlanks;

  if SameText(name, 'INCLUDE') or SameText(name, 'I') then
  begin
    AValue := ScanIncludeFileName;
    if IsActiveContent then
      Result := ptIncludeFile;
  end
  else if SameText(name, 'DEFINE') then
  begin
    AValue := ScanIdentifier(kwd);
    if (AValue <> '') and IsActiveContent then
      Define(AValue);
  end
  else if SameText(name, 'UNDEF') then
  begin
    AValue := ScanIdentifier(kwd);
    if (AValue <> '') and IsActiveContent then
      Undefine(AValue);
  end
  else if SameText(name, 'IFDEF') then
  begin
    AValue := ScanIdentifier(kwd);
    AddCondition(ckIFDEF, IsDefined(AValue) and IsActiveContent);
  end
  else if SameText(name, 'IFNDEF') then
  begin
    AValue := ScanIdentifier(kwd);
    AddCondition(ckIFDEF, not IsDefined(AValue) and IsActiveContent);
  end
  else if SameText(name, 'IFOPT') then
  begin
    AddCondition(ckIFDEF, False); // Just skip code chunk.
  end
  else if SameText(name, 'ELSE') then
  begin
    if (FFile.Top = nil) or FFile.Top.IsInElse then
      raise ELMDPasParseError.CreateFmt(SLMDInvalidDirective, ['ELSE']);

    FFile.Top.IsInElse := True;
    FFile.Top.Active   := not FFile.Top.Active and ((FFile.Top.Parent = nil) or
                                                    FFile.Top.Parent.Active);
  end
  else if SameText(name, 'ENDIF') then
  begin
    if (FFile.Top = nil) or not (FFile.Top.Kind in [ckIF, ckIFDEF]) then
      raise ELMDPasParseError.CreateFmt(SLMDInvalidDirective, ['ENDIF']);

    FFile.Top := FFile.Top.Parent;
  end
  else if SameText(name, 'IF') then
  begin
    AddCondition(ckIF, IsActiveContent and InterpretIf(FFile.C));
  end
  else if SameText(name, 'ELSEIF') then
  begin
    if (FFile.Top = nil) or (FFile.Top.Kind <> ckIF) or
       FFile.Top.IsInElse then
      raise ELMDPasParseError.CreateFmt(SLMDInvalidDirective, ['ELSEIF']);

    FFile.Top.Active := not FFile.Top.Active and ((FFile.Top.Parent = nil) or
                                                  FFile.Top.Parent.Active) and
                        InterpretIf(FFile.C);
  end
  else if SameText(name, 'IFEND') then
  begin
    if (FFile.Top = nil) or (FFile.Top.Kind <> ckIF) then
      raise ELMDPasParseError.CreateFmt(SLMDInvalidDirective, ['IFEND']);

    FFile.Top := FFile.Top.Parent;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.ScanIdentifier(out CanBeKeyword: Boolean): string;
var
  cbegin: PChar;
begin
  CanBeKeyword := True;
  if FFile.C^ = '&' then
  begin
    NextChar;
    CanBeKeyword := False;
  end;

  cbegin := FFile.C;
  while (FFile.C^ <= #255) and (AnsiChar(FFile.C^) in ['A'..'Z', 'a'..'z',
                                                       '_', '0'..'9']) do
    NextChar;

  SetString(Result, cbegin, FFile.C - cbegin);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.ScanIncludeFileName: string;
var
  cbegin: PChar;
begin
  if FFile.C^ = '''' then
  begin
    NextChar;
    cbegin := FFile.C;

    while not ((FFile.C^ <= #255) and
               (AnsiChar(FFile.C^) in [#0, #13, #10, '''', '}', '*'])) do
      NextChar;
    SetString(Result, cbegin, FFile.C - cbegin);

    if FFile.C^ = '''' then
      NextChar;
  end
  else
  begin
    cbegin := FFile.C;
    while not ((FFile.C^ <= #255) and
               (AnsiChar(FFile.C^) in [#0..#32, '}', '*'])) do
      NextChar;
    SetString(Result, cbegin, FFile.C - cbegin);
  end;

  if ExtractFileExt(Result) = '' then
    Result := ChangeFileExt(Result, '.pas');
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.ScanString: string;
var
  cbegin: PChar;
  s:      string;
  ival:   Int64;
  fval:   Extended;
begin
  Result := '';

  while True do
    case FFile.C^ of
      '''':
        begin
          { Read quoted string }

          cbegin := FFile.C;
          NextChar;
          while True do
          begin
            if (FFile.C^ <= #255) and
               (AnsiChar(FFile.C^) in [#0, #13, #10]) then
            begin
              if FMode = psmInIfDirective then
                Break // like in Delphi, we just stop string literal at
                      // the line end in $IF directive.
              else
                raise ELMDPasParseError.Create(SLMDUnterminatedStr,
                                               GetCurCharPos);
            end;

            if FFile.C^ = '''' then
            begin
              NextChar;
              if FFile.C^ = '''' then
                NextChar
              else
                Break;
            end
            else
              NextChar;
          end;

          SetString(s, cbegin, FFile.C - cbegin);

          if s = '''''' then
            Result := ''
          else
            Result := Result + AnsiDequotedStr(s, '''');
        end;
      '#':
        begin
          { Read char code }

          NextChar;
          ScanNumber(False, ival, fval);
          Result := Result + Chr(Byte(ival));
        end;
    else
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.Clear;
var
  i: Integer;
begin
  for i := 0 to FFiles.Count - 1 do
    TObject(FFiles[i]).Free;
  FFiles.Clear;
  FFile := nil;

  for i := 0 to FConditions.Count - 1 do
    TObject(FConditions[i]).Free;
  FConditions.Clear;

  for i := 0 to FDefines.Count - 1 do
    TObject(FDefines[i]).Free;
  FDefines.Clear;
  FDefineFirst := nil;
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDPasScanner.Create(AFileHandler: TLMDFileHandler);
begin
  inherited Create;
  FFileHandler := AFileHandler;
  FFiles       := TList.Create;
  FConditions  := TList.Create;
  FDefines     := TList.Create;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.AddCondition(AKind: TLMDPasScannerCondKind;
  AActive: Boolean);
var
  cnd: TLMDPasScannerCond;
begin
  cnd := TLMDPasScannerCond.Create;
  try
    cnd.Parent   := FFile.Top;
    cnd.Kind     := AKind;
    cnd.IsInElse := False;
    cnd.Active   := AActive;
    cnd.C        := FFile.C;
    SaveCondition(cnd.Parent, cnd.ParentState);

    FFile.Top := cnd;
    FConditions.Add(cnd);
  except
    cnd.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.AddFile(const ASource: string);
var
  fl: TLMDPasScannerFile;
begin
  fl := TLMDPasScannerFile.Create;
  try
    fl.Parent := FFile;
    fl.SrcRef := ASource;
    fl.Source := PChar(fl.SrcRef);
    fl.C      := fl.Source;
    SaveFile(fl.Parent, fl.ParentState);

    FFiles.Add(fl);
    FFile := fl;
  except
    fl.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.Define(const Name: string);
var
  dfn: TLMDPasScannerDefine;
begin
  dfn := FindDefineItem(Name);
  if (dfn = nil) or not dfn.IsDefined then
  begin
    dfn           := TLMDPasScannerDefine.Create;
    dfn.Prev      := FDefineFirst;
    dfn.Name      := Name;
    dfn.IsDefined := True;

    FDefines.Add(dfn);
    FDefineFirst := dfn;
  end;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDPasScanner.Destroy;
begin
  Clear;
  FFiles.Free;
  FConditions.Free;
  FDefines.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.DetectReservedWord(const Token: string): TLMDPasToken;
var
  i: TLMDPasToken;
begin
  for i := Low(PasTokens) to High(PasTokens) do
    with PasTokens[i] do
      if IsKeyword and SameText(S, Token) then
      begin
        Result := i;
        Exit;
      end;
  Result := ptIdentifier;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.FindDefineItem(
  const AName: string): TLMDPasScannerDefine;
begin
  Result := FDefineFirst;
  while (Result <> nil) and not SameText(Result.Name, AName) do
    Result := Result.Prev;

  if (Result = nil) and (FDefinesLookup <> nil) then
    Result := FDefinesLookup.FindDefineItem(AName);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.NextToken;
var
  eofps: Integer;
begin
  while True do
  begin
    eofps := 0;
    while FFile <> nil do
    begin
      if IsActiveContent then
        SkipBlanks
      else
        SkipToNextDirective;

      if (FFile.C <> nil) and (FFile.C^ <> #0) then
        Break; // inner while
      eofps := GetCurCharPos;
      FFile := FFile.Parent;
    end;

    if FFile = nil then
    begin
      FToken    := ptEOf;
      FTokenPos := eofps;
      Break; // while
    end;

    ScanToken;

    case FToken of
      ptComment,
      ptDirective:    ; // Do nothing, no Break.
      ptIncludeFile:  AddFile(GetIncSource(FSData));
    else
      Break; // while
    end;
  end;
end;

{ --------------------------------- public ----------------------------------- }

function TLMDPasScanner.TokenToStr(Token: TLMDPasToken): string;
begin
  Result := '''' + PasTokens[Token].S + '''';
end;

procedure TLMDPasScanner.Undefine(const Name: string);
var
  dfn: TLMDPasScannerDefine;
begin
  dfn := FindDefineItem(Name);
  if (dfn <> nil) and dfn.IsDefined then
  begin
    dfn           := TLMDPasScannerDefine.Create;
    dfn.Prev      := FDefineFirst;
    dfn.Name      := Name;
    dfn.IsDefined := False;

    FDefines.Add(dfn);
    FDefineFirst := dfn;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.GetSavepoint: TLMDPasScannerSavepoint;
begin
  Result.Defines     := FDefineFirst;
  Result.File_       := FFile;
  SaveFile(FFile, Result.FileState);
  Result.FileState.C := @FFile.Source[FTokenPos]; // Correct position to point
                                                  // to the current token start.
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.InterpretIf(AExpr: PChar): Boolean;
begin
  Result := False;
  if Assigned(FOnInterpretIf) then
    FOnInterpretIf(Self, AExpr, Result);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.IsActiveContent: Boolean;
begin
  Result := (FFile = nil) or (FFile.Top = nil) or FFile.Top.Active;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasScanner.IsDefined(const Name: string): Boolean;
var
  dfn: TLMDPasScannerDefine;
begin
  dfn    := FindDefineItem(Name);
  Result := (dfn <> nil) and dfn.IsDefined;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.RestoreCondition(ACond: TLMDPasScannerCond;
  const AState: TLMDPasScannerCondState);
begin
  if ACond <> nil then
  begin
    ACond.IsInElse := AState.IsInElse;
    ACond.Active   := AState.Active;
    ACond.C        := AState.C;
  end;
end;

procedure TLMDPasScanner.RestoreFile(AFile: TLMDPasScannerFile;
  const AState: TLMDPasScannerFileState);
begin
  if AFile <> nil then
  begin
    AFile.C   := AState.C;
    AFile.Top := AState.Top;
    RestoreCondition(AFile.Top, AState.TopState);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.RollbackToSavepoint(S: TLMDPasScannerSavepoint);
var
  fl:  TLMDPasScannerFile;
  cnd: TLMDPasScannerCond;
begin
  FDefineFirst := S.Defines;
  FFile        := S.File_;
  RestoreFile(FFile, S.FileState);

  fl := FFile;
  while fl.Parent <> nil do
  begin
    RestoreFile(fl.Parent, fl.ParentState);

    cnd := fl.Top;
    while cnd <> nil do
    begin
      RestoreCondition(cnd.Parent, cnd.ParentState);
      cnd := cnd.Parent;
    end;

    fl := fl.Parent;
  end;

  NextToken;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.Start(AMode: TLMDPasScannerMode;
  const Source: string);
begin
  FMode := AMode;
  AddFile(Source);
  NextToken;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.SkipToken;
begin
  NextToken;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasScanner.SkipToNextDirective;
var
  c: PChar;
begin
  if FFile.C <> nil then
  begin
    while True do
      case FFile.C^ of
        #0:     Break; // while
        '''':   begin
                  NextChar;
                  while not ((FFile.C^ <= #255) and
                             (AnsiChar(FFile.C^) in ['''', #13, #10])) do
                    NextChar;
                  if FFile.C^ = '''' then
                    NextChar;
                end;
        '/':    begin
                  NextChar;
                  if FFile.C^ = '/' then
                  begin
                    NextChar;
                    while not ((FFile.C^ <= #255) and
                               (AnsiChar(FFile.C^) in [#13, #10])) do
                      NextChar;
                  end;
                end;
        '{':    begin
                  c := FFile.C;
                  NextChar;

                  if FFile.C^ = '$' then    // Directive found.
                  begin
                    FFile.C := c;
                    Break; // while
                  end;
                end;
        '(':    begin
                  c := FFile.C;
                  NextChar;

                  if FFile.C^ = '*' then
                  begin
                    NextChar;
                    if FFile.C^ = '$' then  // Directive found.
                    begin
                      FFile.C := c;
                      Break; // while
                    end;
                  end;
                end;
      else
        NextChar;
      end;
  end;
end;

{************************** class ELMDPasParseError ***************************}
{ --------------------------------- public ----------------------------------- }

constructor ELMDPasParseError.Create(const Msg: string; ASourcePos: Integer);
begin
  inherited Create(Msg);
  FSourcePos := ASourcePos;
end;
                                                                   
{ ---------------------------------------------------------------------------- }

constructor ELMDPasParseError.CreateFmt(const Msg: string;
  const Args: array of const; ASourcePos: Integer);
begin
  inherited Create(Format(Msg, Args));
  FSourcePos := ASourcePos;
end;

{**************************** class TLMDPasParser *****************************}
{ --------------------------------- private ---------------------------------- }

function TLMDPasParser.GetCurToken: TLMDParserToken;
begin
  Result := FScanner.Token;
end;

{ ------------------------------- protected ---------------------------------- }

procedure TLMDPasParser.InvalidTokenError(AToken: TLMDParserToken);
begin
  raise ELMDPasParseError.CreateFmt(SLMDInvalidToken,
                                    [FScanner.TokenToStr(AToken)],
                                    FScanner.TokenPos);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.StrExpectedError(const AStr: string);
begin
  raise ELMDPasParseError.CreateFmt(SLMDStrExpected, [AStr], FScanner.TokenPos);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.Undefine(const Name: string);
begin
  FScanner.Undefine(Name);
end;

function TLMDPasParser.UnknownExprRes: TLMDPasParserExprResult;
begin
  Result.ConstKind := ckUnknown;
  Result.Val       := Unassigned;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.CheckTokens(ATokens: TLMDParserTokens);
begin
  if not (FScanner.Token in ATokens) then
    InvalidTokenError(FScanner.Token);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.CheckAndSkipTokens(
  ATokens: TLMDParserTokens);
begin
  CheckTokens(ATokens);
  SkipToken;
end;
                                                             
{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ScannerInterpretIf(Sender: TObject; AExpr: PChar;
  out AResult: Boolean);
var
  prs:  TLMDPasParser;
  eres: TLMDPasParserExprResult;
  spos: Integer;
begin
  spos := FScanner.TokenPos;
  prs  := TLMDPasParser.Create(nil, FFindConstProc);
  try
    prs.FScanner.FDefinesLookup := FScanner;
    eres := prs.ParseIfDirective(AExpr);

    if VarType(eres.Val) = varEmpty then
      raise ELMDPasParseError.Create(SLMDTooComplexIfCond + ': ' +
                                     IntToStr(spos), spos);
    AResult := eres.Val;
  finally
    prs.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.SkipToken;
begin
  FScanner.SkipToken;
end;

{ ------------------------------- protected ---------------------------------- }

procedure TLMDPasParser.ParseUnitInterface;
begin
  CheckAndSkipTokens([ptUnit]);

  FUnit.Name := ParseIdentifier;
  while CurToken = ptPeriod do
  begin
    SkipToken;
    FUnit.Name := FUnit.Name + '.' + ParseIdentifier;
  end;
  
  while TryParsePortabilityDirective do
    ;

  CheckAndSkipTokens([ptSemiColon]);
  ParseInterfaceSection;
  CheckAndSkipTokens([ptImplementation]);
end;
                                                                   
{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseUsesClause;
var
  i:     Integer;
  s:     string;
  uses_: TStrings;
  uunit: TLMDPasUsedUnit;
begin
  uses_ := TStringList.Create;
  try
    CheckAndSkipTokens([ptUses]);

    while True do
    begin
      s := ParseIdentifier;
      while CurToken = ptPeriod do
      begin
        SkipToken;
        s := s + '.' + ParseIdentifier;
      end;

      uses_.Add(s);

      if CurToken <> ptComma then
        Break; // while
      SkipToken; 
    end;

    CheckAndSkipTokens([ptSemiColon]);

    for i := 0 to uses_.Count - 1 do
    begin
      uunit := TLMDPasUsedUnit.Create;
      uunit.Name := uses_[i];
      FUnit.Uses_.Add(uunit);
    end;
  finally
    uses_.Free;
  end;
end;
                                                                         
{ ---------------------------------------------------------------------------- }

function TLMDPasParser.TryParsePortabilityDirective: Boolean;
begin
  Result := True;

  if (CurToken = ptIdentifier) and (SameText(FScanner.SData, 'deprecated') or
                                    SameText(FScanner.SData, 'platform')) then
  begin
    SkipToken;
    if CurToken = ptCString then
      SkipToken;
  end
  else if CurToken = ptLibrary then
    SkipToken
  else
    Result := False;
end;
                                                                        
{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseInterfaceSection;
var
  uunit: TLMDPasUsedUnit;
begin
  CheckAndSkipTokens([ptInterface]);

  if not SameText(FUnit.Name, 'System') then
  begin
    uunit := TLMDPasUsedUnit.Create;  // Add 'System' unit.
    uunit.Name := 'System';           //
    FUnit.Uses_.Add(uunit);           //
  end;

  if CurToken in UsesClauseTokens then
    ParseUsesClause;

  while CurToken in InterfaceDeclTokens do
    ParseInterfaceDecl;
end;
                                                                                   
{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseInterfaceDecl;
begin
  CheckTokens(ConstSectionTokens + TypeSectionTokens +
              VarSectionTokens + ExportedHeadingTokens);

  if CurToken in ConstSectionTokens then
    ParseConstSection
  else if CurToken in TypeSectionTokens then
    ParseTypeSection
  else if CurToken in VarSectionTokens then
    ParseVarSection
  else
    ParseExportedHeading;
end;
                                                                          
{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseExportedHeading;
var
  proc: TLMDPasProcHeading;
begin
  CheckTokens(DotNetAttrTokens + ProcedureHeadingTokens + FunctionHeadingTokens);

  if CurToken in (DotNetAttrTokens) then
  begin
    ParseDotNetAttr;
  end;

  if CurToken in ProcedureHeadingTokens then
    proc := ParseProcedureHeading(False)
  else
    proc := ParseFunctionHeading(False, False);
  try
    CheckAndSkipTokens([ptSemiColon]);
    while IsProcDirective do
    begin
      ParseProcDirective(proc);
      if CurToken = ptSemiColon then
        SkipToken;
    end;
  except
    proc.Free;
    raise;
  end;

  AddProc(proc, FUnit.Declarations);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseConstSection;
begin
  CheckAndSkipTokens([ptConst, ptResourcestring]);
  FUnit.Declarations.Add(ParseConstantDecl);
  while CurToken in (ConstantDeclTokens) do
    FUnit.Declarations.Add(ParseConstantDecl);
end;
                                                                        
{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseConstantDecl: TLMDPasConstDecl;
var
  eres: TLMDPasParserExprResult;
begin
  Result := TLMDPasConstDecl.Create;
  try
    Result.Name := ParseIdentifier;
    CheckTokens([ptEqual] + [ptColon]);

    if CurToken = ptEqual then
    begin
      SkipToken;
      eres       := ParseExpression;
      Result.Kind  := eres.ConstKind;
      Result.Type_ := nil;
    end
    else
    begin
      CheckAndSkipTokens([ptColon]);
      Result.Kind  := ckTyped;
      Result.Type_ := ParseType;

      CheckAndSkipTokens([ptEqual]);
      ParseTypedConstant;
    end;

    while TryParsePortabilityDirective do
      ;
    CheckAndSkipTokens([ptSemiColon]);
  except
    Result.Free;
    raise;
  end;
end;
                                                                      
{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseTypeSection;
var
  decl: TLMDPasTypeDecl;
begin
  CheckAndSkipTokens([ptType]);

  CheckTokens(DotNetAttrTokens + TypeDeclTokens);
  if CurToken in (DotNetAttrTokens) then
    ParseDotNetAttr;

  decl := ParseTypeDecl;

  if decl <> nil then       // Not a forward declaration.
    FUnit.Declarations.Add(decl);

  while CurToken in (DotNetAttrTokens + TypeDeclTokens) do
  begin
    if CurToken in DotNetAttrTokens then
      ParseDotNetAttr;

    decl := ParseTypeDecl;
    if decl <> nil then     // Not a forward declaration.
      FUnit.Declarations.Add(decl);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseTypeDecl: TLMDPasTypeDecl;
var
  isProcType: Boolean;
  rec:        TLMDPasRecordType;
begin
  Result := TLMDPasTypeDecl.Create;
  try
    isProcType  := False;
    Result.Name := ParseIdentifier;

    if CurToken in TemplateParamsTokens then
    begin
      ParseTemplateParams;
      Result.IsTemplate := True;
    end;

    CheckAndSkipTokens([ptEqual]);
    CheckTokens([ptType] + TypeTokens + RestrictedTypeTokens);

    if CurToken = ptType then
    begin
      Result.TypeKwd := True;
      SkipToken;
    end;

    CheckTokens(TypeTokens + RestrictedTypeTokens);

    if Result.TypeKwd and IsAnsiStringDecl then
      Result.Type_ := ParseAnsiStringDecl
    else if IsRestrictedType then
      Result.Type_ := ParseRestrictedType(SameText(Result.Name, 'TObject')) // Can return nil.
    else
    begin
      if CurToken in ProcedureTypeTokens then
        isProcType := True;
      Result.Type_ := ParseType;
    end;

    while TryParsePortabilityDirective do
      ;
    CheckAndSkipTokens([ptSemiColon]);

    while isProcType and IsProcDirective do
    begin
      ParseProcDirective(nil);
      if CurToken = ptSemiColon then
        SkipToken;
    end;
  except
    Result.Free;
    raise;
  end;

  if Result.Type_ <> nil then
  begin
    Result.Type_.ParentDecl := Result;

    if Result.Type_ is TLMDPasRecordType then
    begin
      rec := TLMDPasRecordType(Result.Type_);
      AddSpecialMethods(rec);
    end;
  end
  else // Forward declaration.
  begin
    Result.Free;
    Result := nil;
  end;
end;
                                                                      
{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseVarSection;
var
  i:     Integer;
  decls: TList;
begin
  decls := TList.Create;
  try
    try
      CheckAndSkipTokens([ptVar, ptThreadvar]);

      ParseVarDecl(decls);
      while CurToken in VarDeclTokens do
        ParseVarDecl(decls);
    except
      for i := 0 to decls.Count - 1 do
        TLMDPasVarDecl(decls[i]).Free;
      raise;
    end;

    for i := 0 to decls.Count - 1 do
      FUnit.Declarations.Add(TLMDPasVarDecl(decls[i]));
  finally
    decls.Free;
  end;
end;
                                                                        
{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseVarDecl(Result: TList);
var
  i:      Integer;
  sp:     TLMDPasScannerSavepoint;
  parsed: Boolean;
  names:  TStrings;
  type_:  TLMDPasType;
  decl:   TLMDPasVarDecl;
begin
  names := TStringList.Create;
  type_ := nil;
  try
    try
      ParseIdentList(names);
      CheckAndSkipTokens([ptColon]);
      type_ := ParseType;

      while TryParsePortabilityDirective do
        ;

      if ((CurToken = ptIdentifier) and SameText(FScanner.SData, 'absolute')) or
          (CurToken = ptEqual) then
      begin
        if (CurToken = ptIdentifier) and SameText(FScanner.SData, 'absolute') then
        begin
          SkipToken;
          ParseIdentifier;
        end
        else
        begin
          CheckAndSkipTokens([ptEqual]);

          sp     := FScanner.GetSavepoint;
          parsed := False;
          try
            if CurToken in ExpressionTokens then
            begin
              ParseExpression;
              parsed := True;
            end;
          except
            FScanner.RollbackToSavepoint(sp);
          end;
          if not parsed then
            ParseTypedConstant;
        end;
      end;

      while TryParsePortabilityDirective do
        ;

      CheckAndSkipTokens([ptSemiColon]);
    except
      type_.Free;
      raise;
    end;

    for i := 0 to names.Count - 1 do
    begin
      decl := TLMDPasVarDecl.Create;
      decl.Name  := names[i];
      decl.Type_ := type_;

      Result.Add(decl);
    end;
  finally
    names.Free;
  end;
end;
                                                                      
{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseType: TLMDPasType;
var
  sp:     TLMDPasScannerSavepoint;
  parsed: Boolean;
begin
  Result := nil; // Initialize.

  CheckTokens(SubrangeTypeTokens + TypeIdTokens + StringTypeTokens +
              EnumeratedTypeTokens + PointerTypeTokens +
              ProcedureTypeTokens + ClassRefTypeTokens +
              StrucTypeTokens);

  sp     := FScanner.GetSavepoint;
  parsed := False;
  try
    if CanBeSubrangeType then
    begin
      Result := ParseSubrangeType;
      parsed := True;
    end;
  except
    FScanner.RollbackToSavepoint(sp);
  end;

  if not parsed then
  begin
    if IsProcedureType then // Before TypeId
      Result := ParseProcedureType
    else if CurToken in TypeIdTokens then
      Result := ParseTypeId
    else if CurToken in StringTypeTokens then
      Result := ParseStringType
    else if CurToken in EnumeratedTypeTokens then
      Result := ParseEnumeratedType
    else if CurToken in PointerTypeTokens then
      Result := ParsePointerType
    else if CurToken in ClassRefTypeTokens then
      Result := ParseClassRefType
    else
      Result := ParseStrucType;
  end;
end;
                                                                           
{ ---------------------------------------------------------------------------- }

function TLMDPasParser.IsRestrictedType: Boolean;
var
  sp: TLMDPasScannerSavepoint;
begin
  sp     := FScanner.GetSavepoint;
  Result := True;

  if FScanner.Token in [ptClass, ptInterface, ptDispinterface] then
  begin
    FScanner.SkipToken;
    if FScanner.Token = ptOf then
      Result := False;            // Class ref type: 'class of'.
  end
  else
    Result := False;

  FScanner.RollbackToSavepoint(sp);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseRestrictedType(isTObject: Boolean): TLMDPasType;
begin
  CheckTokens(ClassTypeTokens + InterfaceTypeTokens);
  if CurToken in ClassTypeTokens then
    Result := ParseClassType(isTObject) // Can return nil.
  else
    Result := ParseInterfaceType;       // Can return nil.
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseTypeId: TLMDPasTypeId;
var
  qname: string;
begin
  Result := TLMDPasTypeId.Create(FUnit);
  try
    qname := ParseIdentifier;
    while CurToken = ptPeriod do
    begin
      SkipToken;
      qname := qname + '.' + ParseIdentifier;
    end;
    Result.QualName := qname;

    if CurToken in TemplateArgsTokens then
    begin
      ParseTemplateArgs;
      Result.IsTemplate := True;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseStringType: TLMDPasTypeId;
begin
  CheckAndSkipTokens([ptString]);

  if CurToken = ptOpenBlock then
  begin
    SkipToken;
    ParseExpression;
    CheckAndSkipTokens([ptCloseBlock]);
  end;

  Result          := TLMDPasTypeId.Create(FUnit);
  Result.QualName := 'string';
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.AddProc(AProc: TLMDPasProcHeading;
  AddTo: TLMDPasNamedNodes);
var
  nd:    TLMDPasNamedNode;
  group: TLMDPasOverloadGroup;
begin
  if AProc.IsOverload then
  begin
    nd := AddTo.Find(AProc.Name);

    if nd is TLMDPasOverloadGroup then
      group := TLMDPasOverloadGroup(nd)
    else
    begin
      group := TLMDPasOverloadGroup.Create(AProc.Name);
      AddTo.Add(group);
    end;

    group.Procs.Add(AProc);
  end
  else
    AddTo.Add(AProc);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.AddSpecialMethods(AType: TLMDPasRecordType);

  procedure _Add(AProc: TLMDPasProcHeading);
  var
    mr:  TLMDPasNamedNode;
  begin
    mr := AType.Members.Find(AProc.Name);

    if mr is TLMDPasOverloadGroup then
    begin
      AProc.IsOverload := True;
      TLMDPasOverloadGroup(mr).Procs.Add(AProc);
    end
    else
      AType.Members.Add(AProc);
  end;

var
  name:  string;
  cst:   TLMDPasProcHeading;
  cpy:   TLMDPasProcHeading;
  rettp: TLMDPasTypeId;
begin
  Assert(AType.ParentDecl <> nil);
  name := AType.ParentDecl.Name;

  cst          := TLMDPasProcHeading.Create;
  cst.Name     := 'Create';
  cst.FuncKind := ppkConstructor;
  cst.Body     := ppbRecCreate;
  _Add(cst);

  rettp           := TLMDPasTypeId.Create(FUnit);
  rettp.QualName  := name;

  cpy             := TLMDPasProcHeading.Create;
  cpy.Name        := 'Copy';
  cpy.FuncKind    := ppkFunction;
  cpy.ReturnType  := rettp;
  cpy.Body        := ppbRecCopy;
  _Add(cpy);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.AnalyzeAddOp(AOp: TLMDParserAddOp; L,
  R: TLMDPasParserExprResult): TLMDPasParserExprResult;
var
  hasvls: Boolean;
begin
  Result.ConstKind := ckSimple;
  Result.Val       := Unassigned;
  hasvls           := IsValKnown(L) and IsValKnown(R);

  try
    case AOp of
      aoPlus:     begin
                    if (L.ConstKind = ckSet) or (R.ConstKind = ckSet) then
                      Result.ConstKind := ckSet
                    else if hasvls then
                      Result.Val := L.Val + R.Val;
                  end;
      aoMinus:    begin
                    if (L.ConstKind = ckSet) or (R.ConstKind = ckSet) then
                      Result.ConstKind := ckSet
                    else if hasvls then
                      Result.Val := L.Val - R.Val;
                  end;
      aoOr:       if hasvls then Result.Val := L.Val or R.Val;
      aoXor:      if hasvls then Result.Val := L.Val xor R.Val;
    else
      Assert(False);
    end;
  except
    Result.Val := Unassigned;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.AnalyzeMulOp(AOp: TLMDParserMulOp; L,
  R: TLMDPasParserExprResult): TLMDPasParserExprResult;
const
  NaN         =  0.0 / 0.0; // From Math.pas unit.
  Infinity    =  1.0 / 0.0; //
  NegInfinity = -1.0 / 0.0; //
var
  hasvls: Boolean;
begin
  Result.ConstKind := ckSimple;
  Result.Val       := Unassigned;
  hasvls           := IsValKnown(L) and IsValKnown(R);

  try
    case AOp of
      moMultiply:   begin
                      if (L.ConstKind = ckSet) or (R.ConstKind = ckSet) then
                        Result.ConstKind := ckSet
                      else if hasvls then
                        Result.Val := L.Val * R.Val;
                    end;
      moDivide:     if hasvls then
                    begin
                      if R.Val = 0.0 then
                      begin
                        if L.Val = 0.0 then
                          Result.Val := NaN
                        else if L.Val > 0.0 then
                          Result.Val := Infinity
                        else
                          Result.Val := NegInfinity;
                      end
                      else
                        Result.Val := L.Val / R.Val;
                    end;
      moDiv:        if hasvls then Result.Val := L.Val div R.Val;
      moMod:        if hasvls then Result.Val := L.Val mod R.Val;
      moAnd:        if hasvls then Result.Val := L.Val and R.Val;
      moShl:        if hasvls then Result.Val := L.Val shl R.Val;
      moShr:        if hasvls then Result.Val := L.Val shr R.Val;
    else
      Assert(False);
    end;
  except
    Result.Val := Unassigned;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.AnalyzeRelOp(AOp: TLMDParserRelOp; L,
  R: TLMDPasParserExprResult): TLMDPasParserExprResult;
var
  hasvls: Boolean;
begin
  Result.ConstKind := ckSimple;
  Result.Val       := Unassigned;
  hasvls           := IsValKnown(L) and IsValKnown(R);

  try
    case AOp of
      roGreater:        if hasvls then Result.Val := L.Val > R.Val;
      roLess:           if hasvls then Result.Val := L.Val < R.Val;
      roLessEqual:      if hasvls then Result.Val := L.Val <= R.Val;
      roGreaterEqual:   if hasvls then Result.Val := L.Val >= R.Val;
      roNotEqual:       if hasvls then Result.Val := L.Val <> R.Val;
      roEqual:          if hasvls then Result.Val := L.Val = R.Val;
      roIn,
      roIs:
        ; // Do nothing
      roAs:
        Result := UnknownExprRes;
    else
      Assert(False);
    end;
  except
    Result.Val := Unassigned;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.AnalyzeUnaryOp(AOp: TLMDParserUnaryOp;
  R: TLMDPasParserExprResult): TLMDPasParserExprResult;
var
  hasvls: Boolean;
begin
  Result.ConstKind := ckSimple;
  Result.Val       := Unassigned;
  hasvls           := IsValKnown(R);

  try
    case AOp of
      uoNot:    if hasvls then  Result.Val := not R.Val;
      uoMinus:  if hasvls then  Result.Val := -R.Val;
      uoPlus:   if hasvls then  Result.Val := +R.Val;
    else
      Assert(False);
    end;
  except
    Result.Val := Unassigned;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.CanBeSubrangeType: Boolean;
var
  sp: TLMDPasScannerSavepoint;
begin
  Result := FScanner.Token in SubrangeTypeTokens;
  sp     := FScanner.GetSavepoint;

  if Result and (FScanner.Token = ptIdentifier) then
  begin
    SkipToken;

    if FScanner.Token in [ptSemiColon, ptCloseRound, ptIdentifier] then
      Result := False;                      // Guaranteed, that this is
                                            // not a subrange type.
  end;

  FScanner.RollbackToSavepoint(sp);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseSubrangeType: TLMDPasSubrangeType;
begin
  ParseExpression;
  CheckAndSkipTokens([ptDoublePeriod]);
  ParseExpression;

  Result := TLMDPasSubrangeType.Create(FUnit);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseEnumeratedType: TLMDPasEnumType;
begin
  Result := TLMDPasEnumType.Create(FUnit);
  try
    CheckAndSkipTokens([ptOpenRound]);
    Result.Enumerators.Add(ParseEnumeratedTypeElement);
    CheckTokens([ptComma] + [ptCloseRound]);
    while CurToken = ptComma do
    begin
      SkipToken;
      Result.Enumerators.Add(ParseEnumeratedTypeElement);
    end;
    CheckAndSkipTokens([ptCloseRound]);
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseEnumeratedTypeElement: string;
begin
  Result := ParseIdentifier;
  if CurToken = ptEqual then
  begin
    SkipToken;
    ParseExpression;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParsePointerType: TLMDPasPointerType;
begin
  Result := TLMDPasPointerType.Create(FUnit);
  try
    CheckAndSkipTokens([ptDereference]);
    Result.BaseType := ParseTypeId;

    while TryParsePortabilityDirective do
      ;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }


function TLMDPasParser.ParseProcedureType: TLMDPasProcType;
begin
  Result := TLMDPasProcType.Create(FUnit);
  try
    CheckTokens(ProcedureHeadingTokens + FunctionHeadingTokens +
                [ptIdentifier]);

    if (CurToken = ptIdentifier) and SameText(FScanner.SData, 'reference') then
    begin
      Result.IsRefTo := True;
      SkipToken;
      CheckAndSkipTokens([ptTo]);
    end;

    if CurToken in ProcedureTypeHeadingTokens then
      ParseProcedureTypeHeading(Result)
    else
      ParseFunctionTypeHeading(Result);

    if not Result.IsRefTo and (CurToken = ptOf) then
    begin
      SkipToken;
      CheckAndSkipTokens([ptObject]);
      Result.OfObject := True;
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseFunctionTypeHeading(AType: TLMDPasProcType);
var
  sp: TLMDPasScannerSavepoint;
begin
  AType.ProcTypeKind := ptkFunction;

  CheckAndSkipTokens([ptFunction]);
  CheckTokens([ptOpenRound] + [ptColon]);
  if CurToken = ptOpenRound then
  begin
    SkipToken;
    CheckTokens(FormalParametersTokens + [ptCloseRound]);
    ParseFormalParameters(AType.Parameters);
    CheckAndSkipTokens([ptCloseRound]);
  end;
  CheckAndSkipTokens([ptColon]);
  AType.ReturnType := ParseType;

  while True do
  begin
    sp := FScanner.GetSavepoint;

    if CurToken = ptSemiColon then
      SkipToken;
    if IsDirective then
      ParseDirective(nil)
    else
    begin
      FScanner.RollbackToSavepoint(sp);
      Break;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseProcedureTypeHeading(AType: TLMDPasProcType);
var
  sp: TLMDPasScannerSavepoint;
begin
  AType.ProcTypeKind := ptkProcedure;

  CheckAndSkipTokens([ptProcedure]);
  if CurToken = ptOpenRound then
  begin
    SkipToken;
    CheckTokens(FormalParametersTokens + [ptCloseRound]);
    ParseFormalParameters(AType.Parameters);
    CheckAndSkipTokens([ptCloseRound]);
  end;

  while True do
  begin
    sp := FScanner.GetSavepoint;

    if CurToken = ptSemiColon then
      SkipToken;
    if IsDirective then
      ParseDirective(nil)
    else
    begin
      FScanner.RollbackToSavepoint(sp);
      Break;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseClassRefType: TLMDPasClassRefType;
var
  baseType: TLMDPasType;
begin
  CheckAndSkipTokens([ptClass]);
  CheckAndSkipTokens([ptOf]);
  baseType := ParseTypeId;

  Result := TLMDPasClassRefType.Create(FUnit);
  Result.BaseType := baseType;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseStrucType: TLMDPasType;
begin
  CheckTokens([ptPacked] + ArrayTypeTokens + SetTypeTokens +
              FileTypeTokens + RecTypeTokens);
  if CurToken = ptPacked then
    SkipToken;
  CheckTokens(ArrayTypeTokens + SetTypeTokens + FileTypeTokens +
              RecTypeTokens);
  if CurToken in ArrayTypeTokens then
    Result := ParseArrayType
  else if CurToken in SetTypeTokens then
    Result := ParseSetType
  else if CurToken in FileTypeTokens then
    Result := ParseFileType
  else
    Result := ParseRecType;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseArrayType: TLMDPasArrayTypeBase;
var
  isStaticArray: Boolean;
begin
  CheckAndSkipTokens([ptArray]);
  CheckTokens([ptOpenBlock] + [ptOf]);

  isStaticArray := (CurToken = ptOpenBlock);

  if isStaticArray then
    Result := TLMDPasStaticArrayType.Create(FUnit)
  else
    Result := TLMDPasDynamicArrayType.Create(FUnit);
  try
    if isStaticArray then
    begin
      SkipToken;
      TLMDPasStaticArrayType(Result).Bounds.Add(ParseType);
      CheckTokens([ptComma, ptCloseBlock]);
      while CurToken = ptComma do
      begin
        SkipToken;
        TLMDPasStaticArrayType(Result).Bounds.Add(ParseType);
      end;
      CheckAndSkipTokens([ptCloseBlock]);
    end;
    CheckAndSkipTokens([ptOf]);
    Result.ElemType := ParseType;

    while TryParsePortabilityDirective do
      ;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseRecType: TLMDPasRecordType;
begin
  Result := TLMDPasRecordType.Create(FUnit);
  try
    CheckAndSkipTokens([ptRecord]);
    CheckTokens(RecMembersSectionTokens + VisibilityTokens +
                RecVariantSectionTokens + [ptEnd, ptIdentifier]);

    if (CurToken = ptIdentifier) and SameText(FScanner.SData, 'helper') then
    begin
      SkipToken;
      CheckAndSkipTokens([ptFor]);
      Result.HelperFor := ParseTypeId;
    end;

    if (CurToken in RecMembersSectionTokens) and
       not IsVisibility then
      ParseRecMembersSection(Result, pvPublic);
    while IsVisibility do
      ParseRecMembersSection(Result, ParseVisibility);
    if CurToken in RecVariantSectionTokens then
      ParseRecVariantSection(Result);

    CheckAndSkipTokens([ptEnd]);

    while TryParsePortabilityDirective do
      ;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseRecMembersSection(AType: TLMDPasRecordType;
  AVisibility: TLMDPasParserVisibility);
var
  method:     TLMDPasProcHeading;
  prop:       TLMDPasNamedNode;
  isOverride: Boolean;

  function _CurIsField: Boolean;
  var
    sp: TLMDPasScannerSavepoint;
  begin
    sp := FScanner.GetSavepoint;

    if CurToken in DotNetAttrTokens then
      ParseDotNetAttr;
    Result := (CurToken in FieldDeclTokens) and
              not IsVisibility;

    FScanner.RollbackToSavepoint(sp);
  end;

begin
  while _CurIsField do
  begin
    if CurToken in DotNetAttrTokens then
      ParseDotNetAttr;
    ParseFieldDecl(AType.Members, AVisibility, False);
  end;

  while CurToken in (DotNetAttrTokens + MethodDeclTokens +
                     PropertyDeclTokens + InnerTypeSectionTokens +
                     InnerConstSectionTokens + InnerVarSectionTokens) do
  begin
    if CurToken in (DotNetAttrTokens) then
      ParseDotNetAttr;

    case DetectMemberKind of
      mkMethod:
      begin
        method := ParseMethodDecl(isOverride);
        if method <> nil then
        begin
          if AVisibility = pvPublic then
            AddProc(method, AType.Members)
          else
            method.Free;
        end;
      end;
      mkProperty:
      begin
        prop := ParsePropertyDecl(AVisibility = pvProtected);
        if AVisibility = pvPublic then
          AType.Members.Add(prop)
        else
          prop.Free;
      end;
      mkTypeSection:   ParseInnerTypeSection;
      mkConstSection:  ParseInnerConstSection(AType.Members, AVisibility);
      mkVarSection:    ParseInnerVarSection(AType.Members, AVisibility);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseRecVariantSection(AType: TLMDPasRecordType);
var
  sp: TLMDPasScannerSavepoint;
begin
  CheckAndSkipTokens([ptCase]);

  CheckTokens(IdentifierTokens + TypeIdTokens);

  sp := FScanner.GetSavepoint;
  try
    if CurToken in IdentifierTokens then
    begin
      ParseIdentifier;
      CheckAndSkipTokens([ptColon]);
    end;
  except
    FScanner.RollbackToSavepoint(sp);
  end;

  ParseTypeId;
  CheckAndSkipTokens([ptOf]);
  ParseRecVariant(AType);

  while CurToken in RecVariantTokens do
    ParseRecVariant(AType);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseRecVariant(AType: TLMDPasRecordType);
begin
  ParseExpression;
  CheckTokens([ptComma] + [ptColon]);

  while CurToken = ptComma do
  begin
    SkipToken;
    ParseExpression;
  end;

  CheckAndSkipTokens([ptColon]);
  CheckAndSkipTokens([ptOpenRound]);

  while CurToken in FieldDeclTokens do
    ParseFieldDecl(AType.Members, pvPublic, False);
  if CurToken in RecVariantSectionTokens then
    ParseRecVariantSection(AType);

  CheckAndSkipTokens([ptCloseRound]);

  if (CurToken = ptSemiColon) or
     not (CurToken in [ptEnd, ptCloseRound]) then // ptCloseRound here for
                                                  // record's case sections.
    CheckAndSkipTokens([ptSemiColon]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseSetType: TLMDPasSetType;
var
  baseType: TLMDPasType;
begin
  CheckAndSkipTokens([ptSet]);
  CheckAndSkipTokens([ptOf]);
  baseType := ParseType;

  Result := TLMDPasSetType.Create(FUnit);
  Result.BaseType := baseType;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseFileType: TLMDPasFileType;
var
  baseType: TLMDPasType;
begin
  CheckAndSkipTokens([ptFile]);
  CheckAndSkipTokens([ptOf]);
  baseType := ParseType;

  Result := TLMDPasFileType.Create(FUnit);
  Result.BaseType := baseType;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseClassType(isTObject: Boolean): TLMDPasClassType;
var
  hasBody:       Boolean;
  hasHeritage:   Boolean;
  isForwardDecl: Boolean;
begin
  hasHeritage := False;
  Result      := TLMDPasClassType.Create(FUnit);
  try
    CheckAndSkipTokens([ptClass]);
    CheckTokens(ClassHeritageTokens + ClassMembersSectionTokens +
                VisibilityTokens + [ptEnd] + [ptSemiColon] +
                DotNetAttrTokens + [ptIdentifier]);

    if (CurToken = ptIdentifier) and (SameText(FScanner.SData, 'abstract') or
                                      SameText(FScanner.SData, 'sealed')) then
      SkipToken;

    if (CurToken = ptIdentifier) and SameText(FScanner.SData, 'helper') then
    begin
      SkipToken;
      CheckAndSkipTokens([ptFor]);
      Result.HelperFor := ParseTypeId;
    end
    else if CurToken in ClassHeritageTokens then
    begin
      ParseClassHeritage(Result);
      hasHeritage := True;
    end
    else if not isTObject then
    begin
      Result.Ancestor          := TLMDPasTypeId.Create(FUnit);
      Result.Ancestor.QualName := 'TObject';
    end;

    hasBody       := (CurToken <> ptSemiColon);
    isForwardDecl := (not hasHeritage) and (not hasBody);

    if hasBody then
    begin
      if (CurToken in ClassMembersSectionTokens) and
         not IsVisibility then
        ParseClassMembersSection(Result, pvPublished);

      while IsVisibility do
        ParseClassMembersSection(Result, ParseVisibility);

      CheckAndSkipTokens([ptEnd]);
    end;
  except
    Result.Free;
    raise;
  end;

  if isForwardDecl then // Forward declaration.
  begin
    Result.Free;
    Result := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseInnerTypeSection;
var
  decl: TLMDPasTypeDecl;
begin
  CheckAndSkipTokens([ptType]);

  CheckTokens(DotNetAttrTokens + TypeDeclTokens);
  if CurToken in (DotNetAttrTokens) then
    ParseDotNetAttr;

  decl := ParseTypeDecl;
  decl.Free;

  while (CurToken in (DotNetAttrTokens + TypeDeclTokens)) and
        not IsVisibility do
  begin
    if CurToken in DotNetAttrTokens then
      ParseDotNetAttr;

    decl := ParseTypeDecl;
    decl.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseClassHeritage(AType: TLMDPasClassType);
begin
  CheckAndSkipTokens([ptOpenRound]);

  AType.Ancestor := ParseTypeId;
  while CurToken = ptComma do
  begin
    SkipToken;
    ParseTypeId;
  end;

  CheckAndSkipTokens([ptCloseRound]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseInnerVarSection(AResult: TLMDPasNamedNodes;
  AVisibility: TLMDPasParserVisibility);
var
  isClassField: Boolean;
begin
  isClassField := False;
  if CurToken = ptClass then
  begin
    isClassField := True;
    SkipToken;
  end;
  CheckAndSkipTokens([ptVar, ptThreadvar]);

  ParseFieldDecl(AResult, AVisibility, isClassField);
  while (CurToken in  FieldDeclTokens) and
        not IsVisibility do
    ParseFieldDecl(AResult, AVisibility, isClassField);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseVisibility: TLMDPasParserVisibility;
var
  s:      string;
  strict: Boolean;
begin
  Result := pvPrivate; // Initialize.

  if IsVisibility then
  begin
    strict := SameText(FScanner.SData, 'strict');
    if strict then
      SkipToken;

    if CurToken <> ptIdentifier then
      StrExpectedError(SLMDValidClassVis);

    s := LowerCase(FScanner.SData);
    if s = 'private' then
      Result := pvPrivate
    else if s = 'protected' then
    begin
      if strict then
        Result := pvPrivate // Cannot access 'strict protected'
                            // stuff from another unit.
      else
        Result := pvProtected;
    end
    else if s = 'public' then
      Result := pvPublic
    else
      Result := pvPublished;
    SkipToken;
  end
  else
    StrExpectedError(SLMDValidClassVis);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.IsVisibility: Boolean;
begin
  Result := (CurToken = ptIdentifier) and
            (SameText(FScanner.SData, 'strict') or
             SameText(FScanner.SData, 'private') or
             SameText(FScanner.SData, 'protected') or
             SameText(FScanner.SData, 'public') or
             SameText(FScanner.SData, 'published'));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseClassMembersSection(AType: TLMDPasClassType;
  AVisibility: TLMDPasParserVisibility);
var
  method:     TLMDPasProcHeading;
  prop:       TLMDPasNamedNode;
  isOverride: Boolean;

  function _CurIsField: Boolean;
  var
    sp: TLMDPasScannerSavepoint;
  begin
    sp := FScanner.GetSavepoint;

    if CurToken in DotNetAttrTokens then
      ParseDotNetAttr;
    Result := (CurToken in FieldDeclTokens) and
              not IsVisibility;

    FScanner.RollbackToSavepoint(sp);
  end;

begin
  while _CurIsField do
  begin
    if CurToken in DotNetAttrTokens then
      ParseDotNetAttr;
    ParseFieldDecl(AType.Members, AVisibility, False);
  end;

  while CurToken in (DotNetAttrTokens + MethodDeclTokens +
                     PropertyDeclTokens + InnerTypeSectionTokens +
                     InnerConstSectionTokens + InnerVarSectionTokens) do
  begin
    if CurToken in (DotNetAttrTokens) then
      ParseDotNetAttr;

    case DetectMemberKind of
      mkMethod:
      begin
        method := ParseMethodDecl(isOverride);
        if (method <> nil) and (AVisibility in [pvPublic, pvPublished]) and
           (not isOverride) then
          AddProc(method, AType.Members)
        else
          method.Free;
      end;
      mkProperty:
      begin
        prop := ParsePropertyDecl(AVisibility = pvProtected);
                                        // TPasProperty or TPasPropertyRedecl
                                        // instance.

        if ((prop is TLMDPasPropertyRedecl) and
            (AVisibility in [pvPublic, pvPublished])) or
           ((prop is TLMDPasProperty) and
            (AVisibility in [pvProtected, pvPublic, pvPublished])) then
          AType.Members.Add(prop)
        else
          prop.Free;
      end;
      mkTypeSection:   ParseInnerTypeSection;
      mkConstSection:  ParseInnerConstSection(AType.Members, AVisibility);
      mkVarSection:    ParseInnerVarSection(AType.Members, AVisibility);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseInnerConstSection(
  AResult: TLMDPasNamedNodes; AVisibility: TLMDPasParserVisibility);
var
  decl: TLMDPasConstDecl;
begin
  CheckAndSkipTokens([ptConst]);
  decl := ParseConstantDecl;
  if AVisibility in [pvPublic, pvPublished] then
    AResult.Add(decl)
  else
    decl.Free;

  while (CurToken in ConstantDeclTokens) and
        not IsVisibility do
  begin
    decl := ParseConstantDecl;

    if AVisibility in [pvPublic, pvPublished] then
      AResult.Add(decl)
    else
      decl.Free;
  end;
end;

procedure TLMDPasParser.ParseFieldDecl(AResult: TLMDPasNamedNodes;
  AVisibility: TLMDPasParserVisibility; AIsClassField: Boolean);
var
  i:     Integer;
  names: TStrings;
  fldtp: TLMDPasType;
  field: TLMDPasVarDecl;
begin
  names := TStringList.Create;
  fldtp := nil;
  try
    try
      ParseIdentList(names);
      CheckAndSkipTokens([ptColon]);

      fldtp := ParseType;
      while TryParsePortabilityDirective do
        ;


      if (CurToken = ptSemiColon) or
         not (CurToken in [ptEnd, ptCloseRound]) then // ptCloseRound here for
                                                      // record's case sections.
        CheckAndSkipTokens([ptSemiColon]);
    except
      fldtp.Free;
      raise;
    end;

    if AVisibility in [pvPublic, pvPublished] then
    begin
      for i := 0 to names.Count - 1 do
      begin
        field              := TLMDPasVarDecl.Create;
        field.Name         := names[i];
        field.Type_        := fldtp;
        field.IsClassField := AIsClassField;

        AResult.Add(field);
      end;
    end
    else
      fldtp.Free;
  finally
    names.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParsePropertyDecl(
  AIsProtected: Boolean): TLMDPasPropertyBase;
var
  name:        string;
  idRedecl:    Boolean;
  propSpec:    string;
  isClassProp: Boolean;
begin
  isClassProp := False;

  if CurToken = ptClass then
  begin
    isClassProp := True;
    SkipToken;
  end;
  CheckAndSkipTokens([ptProperty]);

  name     := ParseIdentifier;
  idRedecl := not (CurToken in ([ptOpenBlock] + [ptColon]));

  if not idRedecl then
  begin
    Result                              := TLMDPasProperty.Create;
    Result.IsProtected                  := AIsProtected;
    TLMDPasProperty(Result).IsClassProp := isClassProp;
  end
  else
  begin
    Result             := TLMDPasPropertyRedecl.Create;
    Result.IsProtected := AIsProtected;
  end;

  try
    Result.Name := name;

    if not idRedecl then
    begin
      if CurToken = ptOpenBlock then
      begin
        SkipToken;
        CheckTokens(FormalParametersTokens + [ptCloseBlock]);
        ParseFormalParameters(TLMDPasProperty(Result).Parameters);
        CheckAndSkipTokens([ptCloseBlock]);
      end;
      CheckAndSkipTokens([ptColon]);
      TLMDPasProperty(Result).Type_ := ParseType;
    end;

    while CurToken in PropertySpecifierTokens do
    begin
      propSpec := ParsePropertySpecifier;
      if not idRedecl and SameText(propSpec, 'read') then
        TLMDPasProperty(Result).IsReadable := True;
      if not idRedecl and SameText(propSpec, 'write') then
        TLMDPasProperty(Result).IsWritable := True;
    end;
    CheckAndSkipTokens([ptSemiColon]);

    if (CurToken = ptIdentifier) and SameText(FScanner.SData, 'default') then
    begin
      SkipToken;
      Result.IsDefault := True;
      CheckAndSkipTokens([ptSemiColon]);
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParsePropertySpecifier: string;
var
  s: string;
begin
  s := ParseIdentifier;

  if SameText(s, 'index') or SameText(s, 'stored') or
     SameText(s, 'default') or SameText(s, 'read') or
     SameText(s, 'write') or SameText(s, 'dispid') then
    ParseExpression
  else if SameText(s, 'implements') then
  begin
    ParseTypeId;
    while CurToken = ptComma do
    begin
      SkipToken;
      ParseTypeId;
    end;
  end
  else if SameText(s, 'nodefault') or SameText(s, 'readonly') or
          SameText(s, 'writeonly') then
    //Do nothing
  else
    StrExpectedError(SLMDValidPropSpecifier);

  Result := s;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseMethodDecl(
  out IsOverride: Boolean): TLMDPasProcHeading;

  function _TryParseInterfaceMethodRename: Boolean;
  label
    LFalse;
  var
    sp: TLMDPasScannerSavepoint;
  begin
    // Process declarations like this:
    //  function IPersistPropertyBag.InitNew = PersistPropBagInitNew;

    sp     := FScanner.GetSavepoint;
    Result := True;

    if not (CurToken in [ptProcedure, ptFunction]) then
      goto LFalse;
    SkipToken;
    if CurToken <> ptIdentifier then
      goto LFalse;
    SkipToken;
    if CurToken <> ptPeriod then
      goto LFalse;
    SkipToken;
    if CurToken <> ptIdentifier then
      goto LFalse;
    SkipToken;
    if CurToken <> ptEqual then
      goto LFalse;
    SkipToken;
    if CurToken <> ptIdentifier then
      goto LFalse;
    SkipToken;
    Exit;

  LFalse:
    Result := False;
    FScanner.RollbackToSavepoint(sp);
  end;

var
  isClassMethod, isOperator: Boolean;
begin
  IsOverride    := False;
  isClassMethod := False;
  isOperator    := False;

  CheckTokens(ProcedureHeadingTokens + FunctionHeadingTokens +
              ConstructorHeadingTokens + DestructorHeadingTokens +
              [ptClass]);

  if CurToken = ptClass then
  begin
    SkipToken;
    isClassMethod := True;
  end;

  if not _TryParseInterfaceMethodRename then
  begin
    if CurToken in ProcedureHeadingTokens then
      Result := ParseProcedureHeading(isClassMethod)
    else if CurToken in FunctionHeadingTokens then
      Result := ParseFunctionHeading(isClassMethod, False)
    else if CurToken in ConstructorHeadingTokens then
      Result := ParseConstructorHeading
    else if CurToken in DestructorHeadingTokens then
      Result := ParseDestructorHeading
    else if isClassMethod and (CurToken = ptIdentifier) and
            SameText(FScanner.SData, 'operator') then
    begin
      isOperator := True;
      Result     := ParseFunctionHeading(isClassMethod, True);
    end
    else
    begin
      InvalidTokenError(CurToken);
      Result := nil; // Initialize.
    end;
  end
  else
    Result := nil;

  try
    CheckAndSkipTokens([ptSemiColon]);
    if (CurToken = ptIdentifier) and SameText(FScanner.SData, 'reintroduce') then
    begin
      SkipToken;
      CheckAndSkipTokens([ptSemiColon]);
    end;
    while IsProcDirective do
    begin
      ParseProcDirective(Result);
      CheckAndSkipTokens([ptSemiColon]);
    end;
    while IsVirtualDirective do
    begin
      if SameText(FScanner.SData, 'override') then
        IsOverride := True;
      if SameText(FScanner.SData, 'virtual') then
        Result.IsVirtual := True;
      ParseVirtualDirective;
      CheckAndSkipTokens([ptSemiColon]);
    end;
    while IsProcDirective do
    begin
      ParseProcDirective(Result);
      CheckAndSkipTokens([ptSemiColon]);
    end;
    if (CurToken = ptIdentifier) and SameText(FScanner.SData, 'abstract') then
    begin
      SkipToken;
      CheckAndSkipTokens([ptSemiColon]);
    end;
    if (CurToken = ptIdentifier) and SameText(FScanner.SData, 'dispid') then
    begin
      SkipToken;
      ParseExpression;
      CheckAndSkipTokens([ptSemiColon]);
    end;
  except
    Result.Free;
    raise;
  end;

  if isClassMethod and (Result <> nil) and ((Result.FuncKind in [ppkConstructor,
                                                                 ppkDestructor]) or
                                            isOperator) then
  begin
    Result.Free;
    Result := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseConstructorHeading: TLMDPasProcHeading;
begin
  Result := TLMDPasProcHeading.Create;
  try
    Result.FuncKind := ppkConstructor;

    CheckAndSkipTokens([ptConstructor]);
    Result.Name := ParseIdentifier;
    if CurToken = ptOpenRound then
    begin
      SkipToken;
      CheckTokens(FormalParametersTokens + [ptCloseRound]);
      ParseFormalParameters(Result.Parameters);
      CheckAndSkipTokens([ptCloseRound]);
    end;

    while IsDirective do
      ParseDirective(Result);
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseDestructorHeading: TLMDPasProcHeading;
begin
  Result := TLMDPasProcHeading.Create;
  try
    Result.FuncKind := ppkDestructor;

    CheckAndSkipTokens([ptDestructor]);
    Result.Name := ParseIdentifier;
    if CurToken = ptOpenRound then
    begin
      SkipToken;
      CheckTokens(FormalParametersTokens + [ptCloseRound]);
      ParseFormalParameters(Result.Parameters);
      CheckAndSkipTokens([ptCloseRound]);
    end;

    while IsDirective do
      ParseDirective(Result);
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseInterfaceType: TLMDPasInterfaceType;
var
  hasBody:       Boolean;
  hasHeritage:   Boolean;
  isForwardDecl: Boolean;
  isOverride:    Boolean;
  parsed:        Boolean;
  sp:            TLMDPasScannerSavepoint;
  md: TLMDPasProcHeading;
begin
  Result := TLMDPasInterfaceType.Create(FUnit);
  try
    CheckAndSkipTokens([ptInterface , ptDispinterface]);
    CheckTokens(InterfaceHeritageTokens + InterfaceGuidTokens +
                MethodDeclTokens + PropertyDeclTokens +
                DotNetAttrTokens + [ptSemiColon] +
                [ptEnd]);

    hasHeritage := CurToken in InterfaceHeritageTokens;
    if hasHeritage then
      ParseInterfaceHeritage(Result);

    hasBody       := (CurToken <> ptSemiColon);
    isForwardDecl := (not hasHeritage) and (not hasBody);

    if hasBody then
    begin
      parsed := false;
      if CurToken in (InterfaceGuidTokens + DotNetAttrTokens) then
      begin
        sp := FScanner.GetSavepoint;
        try
          ParseInterfaceGuid;
          parsed := true;
        except
          FScanner.RollbackToSavepoint(sp);
        end;
      end
      else
        parsed := true;

      if not parsed then
        ParseDotNetAttr;

      while CurToken in (DotNetAttrTokens + MethodDeclTokens +
                         PropertyDeclTokens)
      do
      begin
        CheckTokens(DotNetAttrTokens + MethodDeclTokens +
                    PropertyDeclTokens);

        if CurToken in (DotNetAttrTokens) then
        begin
          ParseDotNetAttr;
        end;

        if CurToken in MethodDeclTokens then
        begin
          md := ParseMethodDecl(isOverride);
          if md <> nil then
            AddProc(md, Result.Members);
        end
        else
          Result.Members.Add(ParsePropertyDecl(False));
      end;
      CheckAndSkipTokens([ptEnd]);
    end;

  except
    Result.Free;
    raise;
  end;

  if isForwardDecl then // Forward declaration.
  begin
    Result.Free;
    Result := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseInterfaceHeritage(AType: TLMDPasInterfaceType);
begin
  CheckAndSkipTokens([ptOpenRound]);
  ParseIdentList(AType.Interfaces);
  CheckAndSkipTokens([ptCloseRound]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseInterfaceGuid;
begin
  CheckAndSkipTokens([ptOpenBlock]);
  CheckAndSkipTokens([ptCString]);
  CheckAndSkipTokens([ptCloseBlock]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseFunctionHeading(
  IsClassFunc, IsOperator: Boolean): TLMDPasProcHeading;
begin
  Result := TLMDPasProcHeading.Create;
  try
    if IsClassFunc then
      Result.FuncKind := ppkClassFunction
    else
      Result.FuncKind := ppkFunction;

    if not IsOperator then
      CheckAndSkipTokens([ptFunction])
    else
      CheckAndSkipTokens([ptIdentifier]); // operator.

    Result.Name := ParseIdentifier;
    if CurToken in TemplateParamsTokens then
    begin
      ParseTemplateParams;
      Result.IsTemplate := True;
    end;

    if CurToken = ptOpenRound then
    begin
      SkipToken;
      CheckTokens(FormalParametersTokens + [ptCloseRound]);
      ParseFormalParameters(Result.Parameters);
      CheckAndSkipTokens([ptCloseRound]);
    end;

    CheckAndSkipTokens([ptColon]);
    Result.ReturnType := ParseType;

    while IsDirective do
      ParseDirective(Result);
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseProcedureHeading(
  IsClassProc: Boolean): TLMDPasProcHeading;
begin
  Result := TLMDPasProcHeading.Create;
  try
    if IsClassProc then
      Result.FuncKind := ppkClassProcedure
    else
      Result.FuncKind := ppkProcedure;

    CheckAndSkipTokens([ptProcedure]);

    Result.Name := ParseIdentifier;
    if CurToken in TemplateParamsTokens then
    begin
      ParseTemplateParams;
      Result.IsTemplate := True;
    end;

    if CurToken = ptOpenRound then
    begin
      SkipToken;
      CheckTokens(FormalParametersTokens + [ptCloseRound]);
      ParseFormalParameters(Result.Parameters);
      CheckAndSkipTokens([ptCloseRound]);
    end;
    while IsDirective do
      ParseDirective(Result);

  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }


procedure TLMDPasParser.ParseFormalParameters(Result: TLMDPasParameters);
var
  i:      Integer;
  params: TList;
begin
  params := TList.Create;
  try
    try

      if CurToken in FormalParamTokens then
      begin
        ParseFormalParam(params);
        while CurToken = ptSemiColon do
        begin
          SkipToken;
          ParseFormalParam(params);
        end;
      end;

    except
      for i := 0 to params.Count - 1 do
        TLMDPasParameter(params[i]).Free;
      raise;
    end;

    for i := 0 to params.Count - 1 do
      Result.Add(TLMDPasParameter(params[i]));
  finally
    params.Free;
  end;
end;

procedure TLMDPasParser.ParseFormalParamNames(Result: TStrings);
var
  s: string;
begin
  if CurToken in (DotNetAttrTokens) then
  begin
    ParseDotNetAttr;
  end;

  s := ParseIdentifier;
  if Result <> nil then
    Result.Add(s);
  while CurToken = ptComma do
  begin
    SkipToken;

    if CurToken in (DotNetAttrTokens) then
    begin
      ParseDotNetAttr;
    end;

    s := ParseIdentifier;
    if Result <> nil then
      Result.Add(s);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseFormalParam(Result: TList);
var
  i:              Integer;
  hasModifier:    Boolean;
  sp, sp2:        TLMDPasScannerSavepoint;
  parsed2:        Boolean;
  names:          TStrings;
  modifier:       TLMDPasParameterModifier;
  type_:          TLMDPasType;
  isArrayOfConst: Boolean;
  isOptional:     Boolean;
  param:          TLMDPasParameter;
begin
  names          := TStringList.Create;
  type_          := nil;
  modifier       := ppmNone;
  isArrayOfConst := False;
  isOptional     := False;
  try
    try
      CheckTokens(DotNetAttrTokens +
                  [ptVar] + [ptConst] + [ptOut] +
                  IdentListTokens);

      hasModifier := False;
      if CurToken in (DotNetAttrTokens) then
      begin
        ParseDotNetAttr;
      end;

      if CurToken in ([ptVar] + [ptConst] + [ptOut]) then
      begin
        case CurToken of
          ptVar:    modifier := ppmVar;
          ptConst:  modifier := ppmConst;
          ptOut:    modifier := ppmOut;
        end;

        SkipToken;
        hasModifier := True;
      end;

      ParseFormalParamNames(names);

      sp := FScanner.GetSavepoint;
      try
        CheckAndSkipTokens([ptColon]);
        CheckTokens([ptArray] + TypeTokens);

        sp2     := FScanner.GetSavepoint;
        parsed2 := False;
        try
          if CurToken = ptArray then
          begin
            SkipToken;
            CheckAndSkipTokens([ptOf]);
            CheckAndSkipTokens([ptConst]);

            isArrayOfConst := True;

            parsed2 := True;
          end;
        except
          FScanner.RollbackToSavepoint(sp2);
        end;

        if not parsed2 then
        begin
          type_ := ParseType;
          if CurToken = ptEqual then
          begin
            SkipToken;
            ParseExpression;
            isOptional := True;
          end;
        end;
      except
        if not hasModifier then
          raise;
        type_.Free;
        type_          := nil;
        isArrayOfConst := False;
        FScanner.RollbackToSavepoint(sp);
      end;

      for i := 0 to names.Count - 1 do
      begin
        param := TLMDPasParameter.Create;
        param.Name           := names[i];
        param.Modifier       := modifier;
        param.Type_          := type_;
        param.IsArrayOfConst := isArrayOfConst;
        param.IsOptional     := isOptional;
        Result.Add(param);
      end;
    except
      type_.Free;
      raise;
    end;
  finally
    names.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseTypedConstant;
var
  sp:     TLMDPasScannerSavepoint;
  parsed: Boolean;
begin
  CheckTokens(ExpressionTokens + RecordConstantTokens +
              ArrayConstantTokens);

  sp := FScanner.GetSavepoint;

  parsed := False;
  try
    if CurToken in ExpressionTokens then
    begin
      ParseExpression;
      parsed := True;
    end;
  except
    FScanner.RollbackToSavepoint(sp);
  end;
  if parsed then
    Exit;

  parsed := False;
  try
    if CurToken in RecordConstantTokens then
    begin
      ParseRecordConstant;
      parsed := True;
    end;
  except
    FScanner.RollbackToSavepoint(sp);
  end;
  if parsed then
    Exit;

  ParseArrayConstant;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseArrayConstant;
begin
  CheckAndSkipTokens([ptOpenRound]);
  ParseTypedConstant;
  CheckTokens([ptComma] + [ptCloseRound]);

  while CurToken = ptComma do
  begin
    SkipToken;
    ParseTypedConstant;
  end;

  CheckAndSkipTokens([ptCloseRound]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseRecordConstant;
begin
  CheckAndSkipTokens([ptOpenRound]);
  CheckTokens(IdentifierTokens + [ptCloseRound]);

  while CurToken in IdentifierTokens do
  begin
    ParseIdentifier;
    CheckAndSkipTokens([ptColon]);
    ParseTypedConstant;

    if (CurToken = ptSemiColon) or (CurToken <> ptCloseRound) then
      CheckAndSkipTokens([ptSemiColon]);
  end;

  CheckAndSkipTokens([ptCloseRound]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseIdentifier: string;
begin
  CheckTokens([ptIdentifier]);
  Result := FScanner.SData;
  SkipToken;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseIdentList(Result: TStrings);
var
  s: string;
begin
  s := ParseIdentifier;
  if Result <> nil then
    Result.Add(s);
  while CurToken = ptComma do
  begin
    SkipToken;
    s := ParseIdentifier;
    if Result <> nil then
      Result.Add(s);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseExpression: TLMDPasParserExprResult;
var
  right: TLMDPasParserExprResult;
  relop: TLMDParserRelOp;
begin
  Result := ParseSimpleExpression;

  while CurToken in RelOpTokens do
  begin
    relop  := ParseRelOp;
    right  := ParseSimpleExpression;
    Result := AnalyzeRelOp(relop, Result, right);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseSimpleExpression: TLMDPasParserExprResult;
var
  right: TLMDPasParserExprResult;
  addop: TLMDParserAddOp;
begin
  Result := ParseTerm;

  while CurToken in AddOpTokens do
  begin
    addop  := ParseAddOp;
    right  := ParseTerm;
    Result := AnalyzeAddOp(addop, Result, right);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseTemplateArg;
begin
  if CurToken = ptString then
    SkipToken
  else
    CheckAndSkipTokens(TypeIdTokens);
end;

procedure TLMDPasParser.ParseTemplateArgs;
begin
  CheckAndSkipTokens([ptLess]);

  ParseTemplateArg;
  while CurToken = ptComma do
  begin
    SkipToken;
    ParseTemplateArg;
  end;

  CheckAndSkipTokens([ptGreater]);
end;

procedure TLMDPasParser.ParseTemplateConstraint;
begin
  if CurToken in [ptClass, ptRecord, ptConstructor] then
    SkipToken
  else
    ParseTypeId;
end;

procedure TLMDPasParser.ParseTemplateParam;
begin
  ParseIdentList;

  if CurToken = ptColon then
  begin
    SkipToken;

    ParseTemplateConstraint;
    while CurToken = ptComma do
    begin
      SkipToken;
      ParseTemplateConstraint;
    end;
  end;
end;

procedure TLMDPasParser.ParseTemplateParams;
begin
  CheckAndSkipTokens([ptLess]);

  ParseTemplateParam;
  while CurToken = ptSemiColon do
  begin
    SkipToken;
    ParseTemplateParam;
  end;

  CheckAndSkipTokens([ptGreater]);
end;

function TLMDPasParser.ParseTerm: TLMDPasParserExprResult;
var
  right: TLMDPasParserExprResult;
  mulop: TLMDParserMulOp;
begin
  Result := ParseFactor;

  while CurToken in MulOpTokens do
  begin
    mulop  := ParseMulOp;
    right  := ParseFactor;
    Result := AnalyzeMulOp(mulop, Result, right);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseFactor: TLMDPasParserExprResult;
const
  MaxDouble: Extended = 1.7e+308; // From Math.pas unit.
var
  unrop: TLMDParserUnaryOp;
  right: TLMDPasParserExprResult;
begin
  Result := UnknownExprRes;
  CheckTokens([ptReference] + DesignatorTokens + [ptCInteger] + [ptCFloat] +
              [ptCString] + [ptNil] + [ptOpenRound] + [ptNot] + [ptMinus] +
              [ptPlus] + SetConstructorTokens + [ptString]);

  if CurToken in ([ptReference] + DesignatorTokens) then
  begin
    CheckTokens([ptReference] + DesignatorTokens);

    if CurToken = ptReference then
    begin
      SkipToken;
      ParseDesignator;
    end
    else
      Result := ParseDesignator;
  end
  else if (CurToken in [ptCInteger, ptCFloat, ptCString, ptNil])
  then
  begin
    case CurToken of
      ptCInteger:   begin
                      Result.ConstKind  := ckSimple;
                      Result.Val        := FScanner.IData;
                    end;
      ptCFloat:     begin
                      Result.ConstKind  := ckSimple;
                      if FScanner.FData > MaxDouble then  // Yes. This is wrong.
                        Result.Val      := MaxDouble
                      else
                        Result.Val      := FScanner.FData;
                    end;
      ptCString:    begin
                      Result.ConstKind  := ckSimple;
                      Result.Val        := FScanner.SData;
                    end;
      ptNil:        begin
                      Result.ConstKind  := ckNil;
                      Result.Val        := Unassigned; // Clear.
                      with TVarData(Result.Val) do
                      begin
                        VType     := varDispatch;
                        VDispatch := nil;
                      end;
                    end;
    else
      Assert(False);
    end;

    SkipToken;
  end
  else if CurToken = ptOpenRound then
  begin
    SkipToken;
    Result := ParseExpression;
    CheckAndSkipTokens([ptCloseRound]);
  end
  else if CurToken in [ptNot, ptMinus, ptPlus] then
  begin
    unrop := TLMDParserUnaryOp(-1); // Initialize.
    case CurToken of
      ptNot:    unrop := uoNot;
      ptMinus:  unrop := uoMinus;
      ptPlus:   unrop := uoPlus;
    else
      Assert(False);
    end;

    SkipToken;
    right  := ParseFactor;
    Result := AnalyzeUnaryOp(unrop, right);
  end
  else if CurToken in SetConstructorTokens then
  begin
    ParseSetConstructor;
    Result.ConstKind := ckSet;
  end
  else
  begin
    CheckAndSkipTokens([ptString]);
    CheckAndSkipTokens([ptOpenRound]);
    Result := ParseExpression;
    CheckAndSkipTokens([ptCloseRound]);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseRelOp: TLMDParserRelOp;
begin
  Result := TLMDParserRelOp(-1); // Initialize.
  CheckTokens([ptGreater] + [ptLess] + [ptLessEqual] + [ptGreaterEqual] +
              [ptNotEqual] + [ptEqual] + [ptIn] + [ptIs] + [ptAs]);

  case CurToken of
    ptGreater:        Result := roGreater;
    ptLess:           Result := roLess;
    ptLessEqual:      Result := roLessEqual;
    ptGreaterEqual:   Result := roGreaterEqual;
    ptNotEqual:       Result := roNotEqual;
    ptEqual:          Result := roEqual;
    ptIn:             Result := roIn;
    ptIs:             Result := roIs;
    ptAs:             Result := roAs;
  else
    Assert(False);
  end;
  SkipToken;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseAddOp: TLMDParserAddOp;
begin
  Result := TLMDParserAddOp(-1); // Initialize.
  CheckTokens([ptPlus] + [ptMinus] + [ptOr] + [ptXor]);

  case CurToken of
    ptPlus:   Result := aoPlus;
    ptMinus:  Result := aoMinus;
    ptOr:     Result := aoOr;
    ptXor:    Result := aoXor;
  else
    Assert(False);
  end;
  SkipToken;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseAnsiStringDecl: TLMDPasTypeId;
begin
  CheckAndSkipTokens([ptIdentifier]);
  CheckAndSkipTokens([ptOpenRound]);
  ParseExpression;
  CheckAndSkipTokens([ptCloseRound]);

  Result := TLMDPasTypeId.Create(FUnit);
  Result.QualName := 'AnsiString';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseMulOp: TLMDParserMulOp;
begin
  Result := TLMDParserMulOp(-1); // Initialize.
  CheckTokens([ptMultiply] + [ptDivide] + [ptDiv] + [ptMod] + [ptAnd] +
              [ptShl] + [ptShr]);

  case CurToken of
    ptMultiply:   Result := moMultiply;
    ptDivide:     Result := moDivide;
    ptDiv:        Result := moDiv;
    ptMod:        Result := moMod;
    ptAnd:        Result := moAnd;
    ptShl:        Result := moShl;
    ptShr:        Result := moShr;
  else
    Assert(False);
  end;

  SkipToken;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseDotNetAttr;
var
    Brackets: Integer;
begin
  Brackets := 0;
  CheckTokens([ptOpenBlock]);

  repeat
    if CurToken = ptOpenBlock then
      Inc(Brackets)
    else if CurToken = ptCloseBlock then
      Dec(Brackets);

    SkipToken;
  until Brackets = 0;

  if CurToken in DotNetAttrTokens then
    ParseDotNetAttr;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseDesignator: TLMDPasParserExprResult;
var
  id, val: string;
  v:       Variant;
begin
  Result := UnknownExprRes;
  id     := ParseIdentifier;

  if SameText(id, 'TRUE') or SameText(id, 'FALSE') then
  begin
    Result.ConstKind := ckSimple;
    Result.Val       := SameText(id, 'TRUE');
    Exit;
  end
  else if FScanner.Mode = psmInIfDirective then
  begin
    if SameText(id, 'Defined') then
    begin
      CheckAndSkipTokens([ptOpenRound]);
      val := ParseIdentifier;
      CheckAndSkipTokens([ptCloseRound]);

      Result.ConstKind := ckSimple;
      Result.Val       := FScanner.IsDefined(val);
      Exit;
    end
    else if Assigned(FFindConstProc) and FFindConstProc(id, v) then
    begin
      Result.ConstKind := ckSimple;
      Result.Val       := v;
      Exit;
    end;
  end;

  while CurToken in ([ptPeriod] + [ptOpenBlock] +
                     [ptOpenRound] + [ptDereference]) do
  begin
    if CurToken = ptPeriod then
    begin
      SkipToken;
      ParseIdentifier;
    end
    else if CurToken = ptOpenBlock then
    begin
      SkipToken;
      ParseExpression;

      CheckTokens([ptComma] + [ptCloseBlock]);
      while CurToken = ptComma do
      begin
        SkipToken;
        ParseExpression;
      end;

      CheckAndSkipTokens([ptCloseBlock]);
    end
    else if CurToken = ptOpenRound then
    begin
      SkipToken;
      CheckTokens(ExpressionTokens + [ptCloseRound]);

      if CurToken in ExpressionTokens then
      begin
        ParseExpression;
        while CurToken = ptComma do
        begin
          SkipToken;
          ParseExpression;
        end;
      end;

      CheckAndSkipTokens([ptCloseRound]);
    end
    else
      CheckAndSkipTokens([ptDereference]);

    Result := UnknownExprRes; // We do not support analyzing of complex
                              // designators.
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseSetConstructor;
begin
  CheckAndSkipTokens([ptOpenBlock]);

  CheckTokens(SetElementTokens + [ptCloseBlock]);
  if CurToken in SetElementTokens then
  begin
    ParseSetElement;
    while CurToken = ptComma do
    begin
      SkipToken;
      ParseSetElement;
    end;
  end;

  CheckAndSkipTokens([ptCloseBlock]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseSetElement;
begin
  ParseExpression;

  if CurToken = ptDoublePeriod then
  begin
    SkipToken;
    ParseExpression;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.IsAnsiStringDecl: Boolean;
var
  sp: TLMDPasScannerSavepoint;
begin
  Result := (FScanner.Token = ptIdentifier) and
            SameText(FScanner.SData, 'ANSISTRING');

  if Result then
  begin
    sp := FScanner.GetSavepoint;

    FScanner.SkipToken;
    Result := FScanner.Token = ptOpenRound;

    FScanner.RollbackToSavepoint(sp);
  end;
end;

function TLMDPasParser.IsDefined(const Name: string): Boolean;
begin
  Result := FScanner.IsDefined(Name);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.IsDirective: Boolean;
begin
  Result := ((CurToken = ptIdentifier) and
             (SameText(FScanner.SData, 'cdecl') or
              SameText(FScanner.SData, 'register') or
              SameText(FScanner.SData, 'export') or
              SameText(FScanner.SData, 'near') or
              SameText(FScanner.SData, 'far') or
              SameText(FScanner.SData, 'overload') or
              SameText(FScanner.SData, 'pascal') or
              SameText(FScanner.SData, 'safecall') or
              SameText(FScanner.SData, 'stdcall') or
              SameText(FScanner.SData, 'varargs') or
              SameText(FScanner.SData, 'assembler') or
              SameText(FScanner.SData, 'static'))) or
            (CurToken = ptInline);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseDirective(AProc: TLMDPasProcHeading);
begin
  if IsDirective then
  begin
    if (CurToken = ptIdentifier) and (AProc <> nil) and
       SameText(FScanner.SData, 'overload') then
      AProc.IsOverload := True;

    SkipToken;
  end
  else
    StrExpectedError(SLMDValidDirective);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.IsPortabilityDirective: Boolean;
begin
  Result := ((CurToken = ptIdentifier) and
             (SameText(FScanner.SData, 'deprecated') or
              SameText(FScanner.SData, 'platform'))) or
            (CurToken = ptLibrary);
end;

function TLMDPasParser.IsProcDirective: Boolean;
begin
  Result := IsDirective or IsPortabilityDirective or
            ((CurToken = ptIdentifier) and
             (SameText(FScanner.SData, 'forward') or
              SameText(FScanner.SData, 'external')));
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.IsProcedureType: Boolean;
var
  sp: TLMDPasScannerSavepoint;
begin
  Result := False;

  if CurToken in (ProcedureHeadingTokens +
                  FunctionHeadingTokens) then
    Result := True
  else if (CurToken = ptIdentifier) and
          SameText(FScanner.SData, 'reference') then
  begin
    sp := FScanner.GetSavepoint;

    SkipToken;
    Result := (CurToken = ptTo);

    FScanner.RollbackToSavepoint(sp);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseProcDirective(AProc: TLMDPasProcHeading);
begin
  CheckTokens(ProcDirectiveTokens);

  if IsDirective then
    ParseDirective(AProc)
  else if TryParsePortabilityDirective then
  begin
    // Do nothing.
  end
  else if (CurToken = ptIdentifier) and SameText(FScanner.SData, 'forward') then
    SkipToken
  else if (CurToken = ptIdentifier) and SameText(FScanner.SData, 'external') then
  begin
    SkipToken;
    if CurToken <> ptSemiColon then
    begin
      ParseExpression;
      if (CurToken = ptIdentifier) and SameText(FScanner.SData, 'name') then
      begin
        SkipToken;
        ParseExpression;
      end;
    end;
  end
  else
    StrExpectedError(SLMDValidDirective);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.IsValKnown(const R: TLMDPasParserExprResult): Boolean;
begin
  Result := (TVarData(R.Val).VType <> varEmpty);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.IsVirtualDirective: Boolean;
begin
  Result := (CurToken = ptIdentifier) and
            (SameText(FScanner.SData, 'virtual') or
             SameText(FScanner.SData, 'dynamic') or
             SameText(FScanner.SData, 'override') or
             SameText(FScanner.SData, 'message'));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.ParseVirtualDirective;
begin
  if not IsVirtualDirective then
    StrExpectedError(SLMDValidDirective);
  if SameText(FScanner.SData, 'message') then
  begin
    SkipToken;
    ParseExpression;
  end
  else
    SkipToken;
end;

{ ----------------------------------- public --------------------------------- }

constructor TLMDPasParser.Create(AFileHandler: TLMDFileHandler;
  AFindConstProc: TLMDPasParserFindDirectiveConst);
begin
  inherited Create;
  FScanner               := TLMDPasScanner.Create(AFileHandler);
  FScanner.OnInterpretIf := ScannerInterpretIf;
  FFindConstProc         := AFindConstProc;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasParser.Define(const Name: string);
begin
  FScanner.Define(Name);
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDPasParser.Destroy;
begin
  FScanner.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.DetectMemberKind: TLMDParserMemberKind;
var
  sp: TLMDPasScannerSavepoint;
begin
  case CurToken of
    ptClass:      begin
                    sp := FScanner.GetSavepoint;
                    SkipToken;

                    case CurToken of
                      ptProperty:   Result := mkProperty;
                      ptVar,
                      ptThreadvar:  Result := mkVarSection;
                    else
                      Result := mkMethod;
                    end;

                    FScanner.RollbackToSavepoint(sp);
                  end;
    ptProperty:   Result := mkProperty;
    ptType:       Result := mkTypeSection;
    ptConst:      Result := mkConstSection;
    ptVar,
    ptThreadvar:  Result := mkVarSection;
  else
    Result := mkMethod;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.Parse(const ASource: string): TLMDPasUnit;
begin
  FUnit := TLMDPasUnit.Create;
  try
    FScanner.Start(psmNormal, ASource);
    ParseUnitInterface; // Replace me.
  except
    FreeAndNil(FUnit);
    raise;
  end;
  Result := FUnit;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParser.ParseIfDirective(
  const AExpr: PChar): TLMDPasParserExprResult;
begin
  FScanner.Start(psmInIfDirective, AExpr);
  Result := ParseExpression;
end;

{ ---------------------------------------------------------------------------- }

end.
