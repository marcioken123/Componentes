unit LMDRegExpr;
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

LMDREGEXPR unit - Core Regular Expression Library (AH)
------------------------------------------------------
This unit implements the core Regular Expression library used in all LMD
Innovative packages. This code is based on TRegExpr code by Andrey V. Sorokin,
see description below for more info. Used with author agreement.

ToDo
-------
Implement \S, \W, \D working in ranges ([...]).
* Unicode character properties \p(Lu), \p(Ll) etc

Changes
-------

Release 8.0 (February 2006)
 - Initial Release


--------------------------------------------------------------------------------
TLMDRegExpr class library
Delphi Regular Expressions

Copyright (c) 1999-2004 Andrey V. Sorokin, St.Petersburg, Russia

You may use this software in any kind of development,
including comercial, redistribute, and modify it freely,
under the following restrictions :
1. This software is provided as it is, without any kind of
  warranty given. Use it at Your own risk. The author is not
  responsible for any consequences of use of this software.
2. The origin of this software may not be mispresented, You
  must not claim that You wrote the original software. If
  You use this software in any kind of product, it would be
  appreciated that there in a information box, or in the
  documentation would be an acknowledgement like

   Partial Copyright (c) 2004 Andrey V. Sorokin
                              http://RegExpStudio.com
                              mailto:anso@mail.ru

3. You may not have any income from distributing this source
  (or altered version of it) to other developers. When You
  use this product in a comercial package, the source may
  not be charged seperatly.
4. Altered versions must be plainly marked as such, and must
  not be misrepresented as being the original software.
5. RegExp Studio application and all the visual components as
  well as documentation is not part of the TLMDRegExpr library
  and is not free for usage.

                                  mailto:anso@mail.ru
                                  http://RegExpStudio.com
                                  http://anso.da.ru/

###############################################################################}

interface

// ======== Define options for TRegExpr engine
{$DEFINE LMD_RE_PCODE_DUMP}// p-code dumping (see Dump method)

uses
  Classes, SysUtils,
  LMDCustomComponent, LMDFiles, LMDStrings, LMDTypes, LMDUnicode, LMDArrayUtils;

type

  TLMDRegexSource = class
  protected
    FBuffer: TLMDIntArray;
    FBufferSize: Integer;
    FBoundGap: Integer;

    FBufferStart: Integer;
    FBufferEnd: Integer;

    FIdxStart, FIdxEnd: Integer;

    procedure FillBuffer; virtual; abstract;
    constructor Create(ABufSize, AInitCount: Integer);
  public

    Count, BaseIndex: Integer;

    //Set external buffer to use
    procedure SetBuffer(ABuffer: TLMDIntArray);

    //Resets contents of char buffer for case when contents of
    //char source has changed
    procedure ResetBuffer; virtual;

    function  GetCode(AIdx: Integer): Integer;
    property  Codes[AIdx: Integer]: Integer read GetCode; default;
  end;

  TLMDRegexStringSource = class(TLMDRegexSource)
  protected
    FStr: TLMDString;
    procedure FillBuffer; override;
  public
    constructor Create(const AStr: TLMDString);
  end;

  TLMDSetOfByte = set of Byte;

  TLMDCharRange = record
    Min: Integer;
    Max: Integer;
  end;

  TLMDCharSet = class
  private
    FRangesCount: Integer;
    FRanges:      array of TLMDCharRange;
    FHaveRanges:  Boolean;
    FInverted: Boolean;

    {$IFDEF LMD_UNICODE}
    FCategories: TLMDUnicodeCategories;
    {$ENDIF}
    FHaveCategories: Boolean;

    procedure CheckNotInverted;
  public
    AnsiSet:   TLMDSetOfByte;
    IsAnsiSet: Boolean;

    constructor Create; overload;
    constructor Create(ACh: Integer); overload;
    constructor Create(const AStr: TLMDString); overload;
    constructor Create(ACat: TLMDUnicodeCategory); overload;
    constructor Create(ACats: TLMDUnicodeCategories); overload;
    constructor Create(AMin, AMax: Integer); overload;

    function  Contains(ACh: Integer): Boolean; overload;

    function  Contains(ACh: TLMDChar): Boolean; overload;
    function  ContainsAll(const AStr: TLMDString): Boolean;

    procedure IncludeChar(ACh: Integer);
    procedure IncludeChars(const AStr: TLMDString);

    procedure IncludeCat(ACat: TLMDUnicodeCategory);
    procedure IncludeCats(ACats: TLMDUnicodeCategories);

    procedure IncludeRange(AMin, AMax: Integer);

    procedure Clear;

    procedure Invert;

    procedure Assign(AOther: TLMDCharSet);
  end;

  TLMDInvertCaseFunction = function(const ACh: Integer): Integer of object;

  TLMDBoyerMooreSearch = class
  private
    FPattern:    TLMDIntArray;
    FPatternInv: TLMDIntArray;

    FSkip:   TLMDIntArray;
    FSuffix: TLMDIntArray;

    FIgnoreCase: Boolean;

    FSkipTableSize, FSkipHashMask, FPatEnd: Integer;

    FInvertCase: TLMDInvertCaseFunction;

    function InvertCase(ACh: Integer): Integer;
    function GetSkipIndex(ACh: Integer): Integer;
  public
    constructor Create(ASkipTableSize, ASkipHashMask: Integer; AInvertCase: TLMDInvertCaseFunction);
    procedure Prepare(const APattern: TLMDIntArray; AIgnoreCase: Boolean);

    function Search(const AInput: TLMDRegexSource; AOffset: Integer; ACount: Integer=-1): Integer;

  end;

  //In codes-mode, this function resolves string code name to integer code value
  TLMDIntCodeResolveFunction = function(const ACodeName: TLMDString): Integer of object;
  TLMDREOp = type Integer; // internal p-code type

  TLMDRegexNode = class
  public
    Op:      TLMDREOp;
    TinySet: TLMDIntArray;

    ExactStr:      TLMDIntArray;
    ExactStrInvC:  TLMDIntArray;
    ExactChar:     Integer; //First char of ExactStr, for speed
    ExactCharInvC: Integer;
    ExactVarId:    Integer;

    SetHash: TLMDCharSet;

    BackRef: Integer;

    MinBrace: Integer;
    MaxBrace: Integer;

    LoopTo: TLMDRegexNode;
    NextOp: TLMDRegexNode;

    PrevNode: TLMDRegexNode;
    NextNode: TLMDRegexNode;

    constructor Create(AOp: TLMDREOp);
    destructor Destroy; override;
  end;

  TLMDRegExp = class;
  TLMDRegExprReplaceFunction = function(ARegExpr: TLMDRegExp): TLMDString of object;

  //Callback to get external variable for regexp ( $0...$9 ).
  TLMDRegExprVariableGetter = procedure(AId: Integer;
                                        var ARes: TLMDIntArray) of object;

  TLMDRegExp = class
  protected
    FInput: TLMDRegexSource;
    FOwnsInput: Boolean;
    FCodesResolver: TLMDIntCodeResolveFunction;

    FVarGetter:     TLMDRegExprVariableGetter;
    FVariablesList: TList;//Nodes list, referred to external variables
    FVarsOptsOk:   Boolean; //External variables loaded and expression rebuilt with them

    FStartp: TLMDIntArray; // founded expr starting points
    FEndp:   TLMDIntArray; // founded expr end points

    FLoopStack:    TLMDIntArray; // state before entering loop
    FLoopStackIdx: Integer; // 0 - out of all loops

    // The "internal use only" fields to pass info from compile
    // to execute that permits the execute phase to run lots faster on
    // simple cases.
    // Regstart and reganch permit very fast decisions on suitable starting points
    // for a match, cutting down the work a lot.  Regmust permits fast rejection
    // of lines that cannot possibly match.  The regmust tests are costly enough
    // that regcomp() supplies a regmust only if the r.e. contains something
    // potentially expensive (at present, the only such thing detected is * or +
    // at the start of the r.e., which can involve a lot of backup).
    FBMSearch:     TLMDBoyerMooreSearch;
    FRegStart:     TLMDRegexNode; // Node that _must_ begin a match;
    FRegAnch:      Boolean;
    FRegmustExact: TLMDRegexNode; // string (pointer into program) that match must include, or nil
    FFirstCharSet: TLMDSetOfByte;
    FFirstCharSetHasUnicode: Boolean;

    // work variables for Exec's routins - save stack in recursion}
    FReginput:   Integer; // String-input pointer.
    FSavedReginput: Integer;
    FInputStart: Integer; // Pointer to first char of input string.
    FInputEnd:   Integer; // Pointer to char AFTER last char of input string
    FNeedMore: Boolean;

    // work variables for compiler's routines
    FExpr:     TLMDString; // source of compiled r.e.
    FParse:    Integer;  // Input-scan indes.
    FParseEnd: Integer;
    FSubexpCount:  Integer; // count.
    FIgnoredChars: TLMDCharSet;
    FRangeSet: TLMDCharSet;

    FLastError: Integer; // see Error, LastError

    FExprIsCompiled: Boolean; // true if r.e. successfully compiled

    FModifiers:     Integer; // modifiers
    FCompModifiers: Integer; // compiler's copy of modifiers
    FProgModifiers: Integer; // modifiers values from last programm compilation
    FCompiledFlags: Integer;

    FSpaceChars:     TLMDString;
    FWordChars:      TLMDString;
    FWordSeparators: TLMDString;
    FLineSeparators: TLMDString;

    FWordCharsSet: TLMDCharSet;
    FWordSepsSet: TLMDCharSet;
    FLineSeparatorsSet: TLMDCharSet;
    FDigitsSet: TLMDCharSet;
    FHexDigCharSet: TLMDCharSet;

    FLinePairedSeparatorAssigned: Boolean;
    FLinePairedSeparatorHead, FLinePairedSeparatorTail: TLMDChar;

    FInvertCase: TLMDInvertCaseFunction;

    FProgrammFirst: TLMDRegexNode;
    FProgrammLast:  TLMDRegexNode;

    procedure SetSubExpCountLow(ACount: Integer);
    procedure SetInput(const AInput: TLMDRegexSource; AOwnIt: Boolean);
    function CompModifier(AMod: Integer): Boolean;
    function HexDig(ch: TLMDChar): Integer;
    function UnQuoteChar(var AIdx: Integer; const AStr: TLMDString;
                         AStrEnd: Integer): TLMDChar;

    function TryParseUnicodeCat(var AIdx: Integer; var ACats: TLMDUnicodeCategories;
                                const AStr: TLMDString): Boolean;

    function ParseIntCode(var AIdx: Integer; const AStr: TLMDString): Integer;

    function InvertCase(ACh: Integer): Integer;
    procedure SetInvertCaseFn(AInvertCase: TLMDInvertCaseFunction);

    // Mark programm as have to be [re]compiled
    procedure InvalidateProgramm;

    // Check if we can use precompiled r.e. or
    // [re]compile it if something changed
    function IsProgrammOk: Boolean;

    function GetExpression: TLMDString;
    procedure SetExpression(const s: TLMDString);

    function GetModifierStr: TLMDString;

    // Parse AModifiers string and return true and set AModifiersInt
    // if it's in format 'ismxrg-ismxrg'.
    function ParseModifiersStr(const AStr: TLMDString; AStart, AEnd: Integer; var AModifiersInt: Integer): Boolean;

    procedure SetModifierStr(const AModifiers: TLMDString);

    function GetModifier(AIndex: Integer): Boolean;
    procedure SetModifier(AIndex: Integer; ASet: Boolean);

    procedure CheckInCodesMode(const AConstruct: TLMDString);
    procedure CheckNotInCodesMode(const AConstruct: TLMDString);

    // Default handler raise exception ERegExpr with
    // Message = ErrorMsg (AErrorID), ErrorCode = AErrorID
    // and CompilerErrorPos = value of property CompilerErrorPos.
    procedure Error(AErrorID: Integer; AErrPos: Integer=-1); virtual; // error handler.

    {==================== Compiler section ===================}

    // compile a regular expression into internal code
    function CompileRegExpr: Boolean;

    procedure PrepareVarsOpts;

    // set the next-pointer at the end of a node chain
    procedure Tail(ALinkTo: TLMDRegexNode; ANode: TLMDRegexNode);

    // regoptail - regtail on operand of first argument; nop if operandless
    procedure OpTail(ALinkTo: TLMDRegexNode; ANode: TLMDRegexNode);//Tail for BRANCH's arg

    // regnode - emit a node, return location
    function EmitNode(AOp: TLMDREOp): TLMDRegexNode;

    // insert an operator in front of already-emitted operand
    // Means changing the operand.
    procedure InsertOperator(AOp: TLMDREOp; var AOpnd: TLMDRegexNode);

    function ParseNumExpr(AStart, AEnd: Integer): Integer;

    // regular expression, i.e. main body or parenthesized thing
    function ParseReg(AParenNo: Integer; var AFlagp: Integer): TLMDRegexNode;

    // one alternative of an | operator
    function ParseBranch(var AFlagp: Integer): TLMDRegexNode;

    // something followed by possible [*+?]
    function ParsePiece(var AFlagp: Integer): TLMDRegexNode;

    // the lowest level
    function ParseAtom(var AFlagp: Integer): TLMDRegexNode;

    procedure AdvanceParse;
    function  NextParse: Integer;
    procedure AdvanceParseEx(var ParseIdx: Integer);
    function  NextParseEx(ParseIdx: Integer): Integer;

    // current pos in r.e. - for error hanling
    function GetCompilerErrorPos: Integer;

    {===================== Mathing section ===================}

    // repeatedly match something simple, report how many
    function RegRepeat(ANode: TLMDRegexNode; AMax: Integer): Integer;

    // recursively matching routine
    function MatchPrim(ANode: TLMDRegexNode): Boolean;

    procedure ClearMatches;

    // Exec for AInputString
    function ExecPrim(AOffset, ACount: Integer): Boolean;

    function GetSubExprMatchCount: Integer;
    function GetMatchPos(Idx: Integer): Integer;
    function GetMatchLen(Idx: Integer): Integer;
    function GetMatch(Idx: Integer): TLMDString;

    procedure SetWordChars(const AStr: TLMDString);
    procedure SetWordSeparators(const AStr: TLMDString);
    procedure SetSpaceChars(const AStr: TLMDString);
    procedure SetLineSeparators(const AStr: TLMDString);
    procedure SetLinePairedSeparator(const AStr: TLMDString);
    function  GetLinePairedSeparator: TLMDString;

    procedure AddWordSet(ASet: TLMDCharSet);
    procedure AddWordSepsSet(ASet: TLMDCharSet);
    procedure AddSpaceSet(ASet: TLMDCharSet);
    procedure AddLineSepSet(ASet: TLMDCharSet);
    procedure AddDigitsSet(ASet: TLMDCharSet);
    procedure AddHexDigitsSet(ASet: TLMDCharSet);
    procedure AddIgnoredCharSet(ASet: TLMDCharSet);

    procedure CheckInputSourceIsString;

    function GetInputText: TLMDString;
    procedure SetInputText(const AStr: TLMDString);

    function GetInputSource: TLMDRegexSource;
    procedure SetInputSource(ASrc: TLMDRegexSource);
  public
    constructor Create;
    destructor Destroy; override;

    function CompiledSubExpCount: Integer;
    class function SubExpMaxCount: Integer;
    // Regular expression.
    // For optimization, TRegExpr will automatically compiles it into 'P-code'
    // (You can see it with help of Dump method) and stores in internal
    // structures. Real [re]compilation occures only when it really needed -
    // while calling Exec[Next], Substitute, Dump, etc
    // and only if Expression or other P-code affected properties was changed
    // after last [re]compilation.
    // If any errors while [re]compilation occures, Error method is called
    // (by default Error raises exception - see below)
    property Expression: TLMDString Read GetExpression Write SetExpression;

    // Set/get default values of r.e.syntax modifiers. Modifiers in
    // r.e. (?ismx-ismx) will replace this default values.
    // If you try to set unsupported modifier, Error will be called
    // (by defaul Error raises exception ERegExpr).
    property ModifierStr: TLMDString Read GetModifierStr Write SetModifierStr;

    // Modifier /i - caseinsensitive, initialized from RegExprModifierI
    property ModifierI: Boolean index 1 Read GetModifier Write SetModifier;

    // Modifier /s - '.' works as any char (else as [^\n]),
    // , initialized from RegExprModifierS
    property ModifierS: Boolean index 3 Read GetModifier Write SetModifier;

    // Switching off modifier /g switchs all operators in
    // non-greedy style, so if ModifierG = False, then
    // all '*' works as '*?', all '+' as '+?' and so on.
    // , initialized from RegExprModifierG
    property ModifierG: Boolean index 4 Read GetModifier Write SetModifier;

    // Treat string as multiple lines. That is, change `^' and `$' from
    // matching at only the very start or end of the string to the start
    // or end of any line anywhere within the string.
    // , initialized from RegExprModifierM
    property ModifierM: Boolean index 5 Read GetModifier Write SetModifier;

    // Modifier /x - eXtended syntax, allow r.e. text formatting,
    // see description in the help. Initialized from RegExprModifierX
    property ModifierX: Boolean index 6 Read GetModifier Write SetModifier;

    // Modifier /a - found expresion should be acnhored to search start
    //(see http://muffin.doit.org/docs/api/gnu.regexp.RE.html#REG_ANCHORINDEX)
    property ModifierA: Boolean index 7 Read GetModifier Write SetModifier;

    // Modifier /c - binary integer codes-mode
    // In this mode only those constructions work:
    //  (), [], ? (greedy option), +?{} (iterators), (?x) - extented mode and inline comments
    //  ^$, {some_code_name with spaces} or some_code_name_no_spaces.
    // All constructions as \s\S\w\W\d\D\b\B\p\P\U\x\X and arbitary chars does not work,
    // all functions as Replace/Substitute/Split/GetMatch does not work too.
    // Also, any modifiers except (?x) and ModifierX, ModifierG, ModifierA does not work in this mode.
    //
    //To convert code names to real int codes, event CodesResolver used.
    property ModifierC: Boolean index 8 Read GetModifier Write SetModifier;

    property CodesResolver: TLMDIntCodeResolveFunction read FCodesResolver write FCodesResolver;
    property VariablesGetter: TLMDRegExprVariableGetter read FVarGetter write FVarGetter;

    property InputText: TLMDString read GetInputText write SetInputText;
    property InputSource: TLMDRegexSource read GetInputSource write SetInputSource;

    function Exec: Boolean; overload;
    function Exec(AOffset: Integer): Boolean; overload;
    function Exec(AOffset, ACount: Integer): Boolean; overload;
    function Exec(AOffset, ACount: Integer; var ANeedMoreSource: Boolean): Boolean; overload;

    // find next match:
    //    ExecNext;
    // works same as
    //    if MatchLen [0] = 0 then ExecPos (MatchPos [0] + 1)
    //     else ExecPos (MatchPos [0] + MatchLen [0]);
    // but it's more simpler !
    // Raises exception if used without preceeding SUCCESSFUL call to
    // Exec* (Exec, ExecPos, ExecNext). So You always must use something like
    // if Exec (InputString) then repeat { proceed results} until not ExecNext;
    function ExecNext: Boolean; overload;

    // Returns ATemplate with '$&' or '$0' replaced by whole r.e.
    // occurence and '$n' replaced by occurence of subexpression #n.
    // Since v.0.929 '$' used instead of '\' (for future extensions
    // and for more Perl-compatibility) and accept more then one digit.
    // If you want place into template raw '$' or '\', use prefix '\'
    // Example: '1\$ is $2\\rub\\' -> '1$ is <Match[2]>\rub\'
    // If you want to place raw digit after '$n' you must delimit
    // n with curly braces '{}'.
    // Example: 'a$12bc' -> 'a<Match[12]>bc'
    // 'a${1}2bc' -> 'a<Match[1]>2bc'.
    function Substitute(const ATemplate: TLMDString): TLMDString;

    // Split AInputStr into APieces by r.e. occurencies
    // Internally calls Exec[Next]
    procedure Split(APieces: TLMDStrings);

    function  Replace(const AReplaceStr: TLMDString;
                      AUseSubstitution: Boolean = False): TLMDString;

    function  ReplaceEx(AReplaceFunc: TLMDRegExprReplaceFunction): TLMDString;

    // Number of subexpressions has been found in last Exec* call.
    // If there are no subexpr. but whole expr was found (Exec* returned True),
    // then MatchCount=0, if no subexpressions nor whole
    // r.e. found (Exec* returned false) then MatchCount=-1.
    // Note, that some subexpr. may be not found and for such
    // subexpr. MathPos=MatchLen=-1 and Match=''.
    // For example: Expression := '(1)?2(3)?';
    //  Exec ('123'): MatchCount=2, Match[0]='123', [1]='1', [2]='3'
    //  Exec ('12'): MatchCount=1, Match[0]='12', [1]='1'
    //  Exec ('23'): MatchCount=2, Match[0]='23', [1]='', [2]='3'
    //  Exec ('2'): MatchCount=0, Match[0]='2'
    //  Exec ('7') - return False: MatchCount=-1
    property MatchCount: Integer Read GetSubExprMatchCount;

    // pos of entrance subexpr. #Idx into tested in last Exec*
    // string. First subexpr. have Idx=1, last - MatchCount,
    // whole r.e. have Idx=0.
    // Returns -1 if in r.e. no such subexpr. or this subexpr.
    // not found in input string.
    property MatchPos[Idx: Integer]: Integer Read GetMatchPos;

    // len of entrance subexpr. #Idx r.e. into tested in last Exec*
    // string. First subexpr. have Idx=1, last - MatchCount,
    // whole r.e. have Idx=0.
    // Returns -1 if in r.e. no such subexpr. or this subexpr.
    // not found in input string.
    // Remember - MatchLen may be 0 (if r.e. match empty string) !
    property MatchLen[Idx: Integer]: Integer Read GetMatchLen;

    // == copy (InputString, MatchPos [Idx], MatchLen [Idx])
    // Returns '' if in r.e. no such subexpr. or this subexpr.
    // not found in input string.
    property Match[Idx: Integer]: TLMDString Read GetMatch;

    // Returns ID of last error, 0 if no errors (unusable if
    // Error method raises exception) and clear internal status
    // into 0 (no errors).
    function LastError: Integer;

    // Returns Error message for error with ID = AErrorID.
    function ErrorMsg(AErrorID: Integer): TLMDString; virtual;

    // Returns pos in r.e. there compiler stopped.
    // Usefull for error diagnostics
    property CompilerErrorPos: Integer Read GetCompilerErrorPos;

    // Contains chars, treated as /s (initially filled with RegExprSpaceChars
    // global constant)
    property SpaceChars: TLMDString Read FSpaceChars Write SetSpaceChars;

    // Contains chars, treated as /w (initially filled with RegExprWordChars
    // global constant)
    property WordChars: TLMDString Read FWordChars Write SetWordChars;

    property WordSeparators: TLMDString Read FWordSeparators Write SetWordSeparators;

    // line separators (like \n in Unix)
    property LineSeparators: TLMDString Read FLineSeparators Write SetLineSeparators;

    // paired line separator (like \r\n in DOS and Windows).
    // must contain exactly two chars or no chars at all
    property LinePairedSeparator: TLMDString Read GetLinePairedSeparator Write SetLinePairedSeparator;

    // Converts Ch into upper case if it in lower case or in lower
    // if it in upper (uses current system local setings)
    class function InvertCaseFunction(const Ch: Integer): Integer;

    // Set this property if you want to override case-insensitive functionality.
    // Create set it to RegExprInvertCaseFunction (InvertCaseFunction by default)
    property InvertCaseFn: TLMDInvertCaseFunction Read FInvertCase Write SetInvertCaseFn;

    // [Re]compile r.e. Usefull for example for GUI r.e. editors (to check
    // all properties validity).
    procedure Compile;

    {$IFDEF LMD_RE_PCODE_DUMP}
    // dump a compiled regexp in vaguely comprehensible form
    function Dump: TLMDString;
    {$ENDIF}

    function  GetFirstCharSetAnsi(var HasUnicode: Boolean): TLMDSetOfByte;
    //External vars changed. At first Exec, we will rebulid them, and optimization info too.
    procedure InvalidateVariables;
    //Does expression use external variable references? $0-$9
    function  HasVariables: Boolean;
    //Max id for external variable
    function  MaxVariableId: Integer;
    //Get found internal group bounds, as variable.
    function  GetVarByID(AId: Integer; var AStart, ACount: Integer): Boolean;
  end;

type
  // obsolete from LMD VCL 2007 on
  PPCRECalloutBlock = Pointer;
  TLMDCalloutEvent = procedure(Sender: TObject; const Data: PPCRECalloutBlock) of object;

  TLMDRegOptions = class(TPersistent)
  private
    FFlags: Integer;
    FOnChange: TNotifyEvent;
    function GetCaseLess: Boolean;
    function GetExtended: Boolean;
    function GetMultiLine: Boolean;
    function GetSingleLine: Boolean;
    function GetUngreedy: Boolean;
    function GetUTF8: Boolean;
    procedure SetCaseLess(const Value: Boolean);
    procedure SetExtended(const Value: Boolean);
    procedure SetMultiLine(const Value: Boolean);
    procedure SetSingleLine(const Value: Boolean);
    procedure SetUngreedy(const Value: Boolean);
    procedure SetUTF8(const Value: Boolean);
    procedure TriggerChange;
  protected
    property Flags: Integer read FFlags;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create;
  published
    property eroCaseLess: Boolean read GetCaseLess write SetCaseLess default True;
    property eroSingleLine: Boolean read GetSingleLine write SetSingleLine default True;
    property eroMultiLine: Boolean read GetMultiLine write SetMultiLine default False;
    property eroExtendedMode: Boolean read GetExtended write SetExtended default True;
    property eroUngreedyMode: Boolean read GetUngreedy write SetUngreedy default False;
    property eroUTF8: Boolean read GetUTF8 write SetUTF8 default False;
  end;

  TLMDRegExpHeader = record
    Id: Longint;
    Flags: Integer;
  end;

  TLMDRegExpr = class(TLMDCustomComponent)
  protected
    FRegExprEngine: TLMDRegExp;
    FOptions: TLMDRegOptions;
    FOnCalloutEvent: TLMDCalloutEvent;
    procedure Compile;
    function GetMatch(i: Integer): TLMDString;
    function GetMatchLen(i: Integer): integer;
    function GetMatchPos(i: Integer): integer;
    function GetNumMatches: Integer;
    function GetExpr: TLMDRegExString;
    procedure SetExpr(const Value: TLMDRegExString);
    function GetInputText: TLMDString;
    procedure SetInputText(const Value: TLMDString);
    procedure DoChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Study; // deprecated;

    procedure SaveToStream(AStream: TStream);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToFile(AFileName: TLMDString);
    procedure LoadFromFile(AFileName: TLMDString);

    function Exec: boolean; overload;
    function Exec(const AInputText: TLMDString): Boolean; overload;

    function ExecNext: Boolean;
    function ExecPos(AStartOffs: Integer): boolean;

    procedure Split(AInputText: TLMDString; AResult: TLMDStrings); overload;
    procedure Split(AResult: TLMDStrings); overload;

    function Substitute(const ATemplate: TLMDString): TLMDString;

    function Replace(const AReplace: TLMDString; AUseTemplates: Boolean): TLMDString; overload;
    function Replace(const AInputText: TLMDString; const AReplace: TLMDString; AUseTemplates: Boolean): TLMDString; overload;

    property Match[i: Integer]: TLMDString read GetMatch;
    property MatchPos[i: Integer]: integer read GetMatchPos;
    property MatchLen[i: Integer]: integer read GetMatchLen;
    property MatchCount: Integer read GetNumMatches;

  published
    property About;
    property Options: TLMDRegOptions read FOptions;

    property Expression: TLMDRegExString read GetExpr write SetExpr;
    property InputText: TLMDString read GetInputText Write SetInputText;

    property OnCallout: TLMDCalloutEvent read FOnCalloutEvent write FOnCalloutEvent;
  end;

  ELMDRegExprError = class(Exception)
  public
    ErrorCode: Integer;
    CompilerErrorPos: Integer;
  end;

  ELMDCharSetError = class(Exception);

 // true if string AInputString match regular expression ARegExpr
 // ! will raise exeption if syntax errors in ARegExpr
function LMDExecRegExpr(const ARegExpr, AInputStr: TLMDString): Boolean;

function LMDExecMatchesRegExpr(const ARegExpr, AInputStr: TLMDString; AMatches: TLMDStrings): Boolean;

// Split AInputStr into APieces by r.e. ARegExpr occurencies
procedure LMDSplitRegExpr(const ARegExpr, AInputStr: TLMDString;
                       APieces: TLMDStrings);

// Returns AInputStr with r.e. occurencies replaced by AReplaceStr
// If AUseSubstitution is true, then AReplaceStr will be used
// as template for Substitution methods.
// For example:
//  ReplaceRegExpr ('({-i}block|var)\s*\(\s*([^ ]*)\s*\)\s*',
//   'BLOCK( test1)', 'def "$1" value "$2"', True)
//  will return:  def 'BLOCK' value 'test1'
//  ReplaceRegExpr ('({-i}block|var)\s*\(\s*([^ ]*)\s*\)\s*',
//   'BLOCK( test1)', 'def "$1" value "$2"')
//   will return:  def "$1" value "$2"
function LMDReplaceRegExpr(const ARegExpr, AInputStr, AReplaceStr: TLMDString;
                           AUseSubstitution: Boolean = False): TLMDString;

// Replace all metachars with its safe representation,
// for example 'abc$cd.(' converts into 'abc\$cd\.\('
// This function usefull for r.e. autogeneration from
// user input
function LMDQuoteRegExprMetaChars(const AStr: TLMDString): TLMDString;

implementation

uses
  Math, LMDRTLConst, LMDProcs;

const
  // Cannot be more than NSUBEXPMAX=255
  // Be carefull - don't use values which overflow CLOSE opcode
  // (in this case you'll get compiler erorr).
  // Big NSUBEXP will cause more slow work and more stack required
  NSUBEXP = 16; // max number of subexpression

  LOOP_STACK_MAX = 20; // max depth of loops stack

  FullUnicodeCatSet: TLMDUnicodeCategories =
      [Low(TLMDUnicodeCategory)..High(TLMDUnicodeCategory)];

  FullAnsiCharSet = [Low(Byte) .. High(Byte)];
  MaxBracesArg    = High(Integer) - 1; // max value for {n,m} arguments

  // if range includes more then TinySetLen chars,
  // then use full (32 bytes) ANYOFFULL instead of ANYOF[BUT]TINYSET
  // !!! Attention ! If you change TinySetLen, you must
  // change code marked as "//!!!TinySet"
  // Don't change it! It's defined by internal TRegExpr design.
  TinySetLen = 3;

  MaskModI = 1;  // modifier /i bit in fModifiers
  MaskModS = 4;  // -"- /s
  MaskModG = 8;  // -"- /g
  MaskModM = 16; // -"- /m
  MaskModX = 32; // -"- /x

  MaskModA = 64; // Modifier /a - found expresion should be acnhored to search start
  //(see http://muffin.doit.org/docs/api/gnu.regexp.RE.html#REG_ANCHORINDEX)
  MaskModC = 128; //Special mode work for integer codes, not chars.!!!!

  MaskModNonCap = 256;//Internal use, in compilation.
                      //(?:   ( bebebe ) ) <== subgroup in outer non-capturing group
                      //                       should be non-capturing too

  EscChar = '\'; // 'Escape'-char ('\' in common r.e.) used for escaping metachars (\w, \d etc).
  RegExprModifierI: Boolean = False;    // default value for ModifierI
  RegExprModifierS: Boolean = True;     // default value for ModifierS
  RegExprModifierG: Boolean = True;     // default value for ModifierG
  RegExprModifierM: Boolean = False;    // default value for ModifierM
  RegExprModifierX: Boolean = False;    // default value for ModifierX

var
  //default value for WordChars
  RegExprWordChars: TLMDString;

  //default value for Numbers
  RegExprNumberChars: TLMDString;

  RegExprSpaceChars: TLMDString;

  RegExprLineSeparators: TLMDString;
  RegExprLinePairedSeparator: TLMDString;

  // Any modification must be synchronized with QuoteRegExprMetaChars !!!
  META: TLMDString;
  QUANTIFIERS_BEG: TLMDString;

const

  ///////////////////////////////////////////////////////////////////////////////

  // Flags to be passed up and down, in TLMDRegExp functions
  HASWIDTH = 01; // Known never to match nil string.
  SIMPLE   = 02; // Simple enough to be STAR/PLUS/BRACES operand.
  SPSTART  = 04; // Starts with * or +.
  WORST    = 0;  // Worst case.

  ///////////////////////////////////////////////////////////////////////////////
  ///
  // name            opcode    opnd? meaning
  EEND     = TLMDREOp(0);  // -    End of program
  BOL      = TLMDREOp(1);  // -    Match "" at beginning of line
  EOL      = TLMDREOp(2);  // -    Match "" at end of line
  ANY      = TLMDREOp(3);  // -    Match any one character
  ANYOF    = TLMDREOp(4);  // Str  Match any character in string Str
  ANYBUT   = TLMDREOp(5);  // Str  Match any char. not in string Str
  BRANCH   = TLMDREOp(6);  // Node Match this alternative, or the next
  BACK     = TLMDREOp(7);  // -    Jump backward (Next < 0)
  EXACTLY  = TLMDREOp(8);  // Str  Match string Str
  NOTHING  = TLMDREOp(9);  // -    Match empty string
  STAR     = TLMDREOp(10); // Node Match this (simple) thing 0 or more times
  PLUS     = TLMDREOp(11); // Node Match this (simple) thing 1 or more times
  ANYDIGIT = TLMDREOp(12); // -    Match any digit (equiv [0-9])
  NOTDIGIT = TLMDREOp(13); // -    Match not digit (equiv [0-9])

  BRACES    = TLMDREOp(18); // Node,Min,Max Match this (simple) thing from Min to Max times.
  //      Min and Max are TREBracesArg
  COMMENT   = TLMDREOp(19); // -    Comment ;)
  EXACTLYCI = TLMDREOp(20); // Str  Match string Str case insensitive
  ANYOFCI   = TLMDREOp(21); // Str  Match any character in string Str, case insensitive
  ANYBUTCI  = TLMDREOp(22); // Str  Match any char. not in string Str, case insensitive
  LOOPENTRY = TLMDREOp(23); // Node Start of loop (Node - LOOP for this loop)
  LOOP      = TLMDREOp(24); // Node,Min,Max,LoopEntryJmp - back jump for LOOPENTRY.
  //      Min and Max are TREBracesArg
  //      Node - next node in sequence,
  //      LoopEntryJmp - associated LOOPENTRY node addr
  ANYOFTINYSET = TLMDREOp(25); // Chrs Match any one char from Chrs (exactly TinySetLen chars)
  ANYBUTTINYSET = TLMDREOp(26); // Chrs Match any one char not in Chrs (exactly TinySetLen chars)
  ANYOFFULLSET = TLMDREOp(27); // Set  Match any one char from set of char
  // - very fast (one CPU instruction !) but takes 32 bytes of p-code
  BSUBEXP   = TLMDREOp(28); // Idx  Match previously matched subexpression #Idx (stored as TLMDChar)
  BSUBEXPCI = TLMDREOp(29); // Idx  -"- in case-insensitive mode

  // Non-Greedy Style Ops
  STARNG   = TLMDREOp(30); // Same as START but in non-greedy mode
  PLUSNG   = TLMDREOp(31); // Same as PLUS but in non-greedy mode
  BRACESNG = TLMDREOp(32); // Same as BRACES but in non-greedy mode
  LOOPNG   = TLMDREOp(33); // Same as LOOP but in non-greedy mode

  // Multiline mode \m
  BOLML = TLMDREOp(34);  // -    Match "" at beginning of line
  EOLML = TLMDREOp(35);  // -    Match "" at end of line
  ANYML = TLMDREOp(36);  // -    Match any one character

  // Word boundary
  BOUND    = TLMDREOp(37);  // Match "" between words
  NOTBOUND = TLMDREOp(38);  // Match "" not between words
  LOOKAHEAD = TLMDREOp(39); // Operator for (?= lookahead) constructions

  // !!! Change OPEN value if you add new opcodes !!!
  //      OPEN + 1 is \1, etc.
  Open  = TLMDREOp(40); // -    Mark this point in input as start of \n

  // -    Analogous to OPEN.
  Close = TLMDREOp(Ord(Open) + NSUBEXP);
  // !!! Don't add new OpCodes after CLOSE !!!

  // programm is essentially a linear encoding
  // of a nondeterministic finite-state machine (aka syntax charts or
  // "railroad normal form" in parsing technology).  Each node is an opcode
  // plus a "next" pointer, possibly plus an operand.  "Next" pointers of
  // all nodes except BRANCH implement concatenation; a "next" pointer with
  // a BRANCH on both ends of it is connecting two alternatives.  (Here we
  // have one of the subtle syntax dependencies:  an individual BRANCH (as
  // opposed to a collection of them) is never concatenated with anything
  // because of operator precedence.)  The operand of some types of node is
  // a literal string; for others, it is a node leading into a sub-FSM.  In
  // particular, the operand of a BRANCH node is the first node of the branch.
  // (NB this is *not* a tree structure:  the tail of the branch connects
  // to the thing following the set of BRANCHes.)  The opcodes are:

  // Opcodes description:

  // BRANCH The set of branches constituting a single choice are hooked
  //      together with their "next" pointers, since precedence prevents
  //      anything being concatenated to any individual branch.  The
  //      "next" pointer of the last BRANCH in a choice points to the
  //      thing following the whole choice.  This is also where the
  //      final "next" pointer of each individual branch points; each
  //      branch starts with the operand node of a BRANCH node.
  // BACK Normal "next" pointers all implicitly point forward; BACK
  //      exists to make loop structures possible.
  // STAR,PLUS,BRACES '?', and complex '*' and '+', are implemented as
  //      circular BRANCH structures using BACK. Complex '{min,max}'
  //      - as pair LOOPENTRY-LOOP (see below). Simple cases (one
  //      character per match) are implemented with STAR, PLUS and
  //      BRACES for speed and to minimize recursive plunges.
  // LOOPENTRY,LOOP {min,max} are implemented as special pair
  //      LOOPENTRY-LOOP. Each LOOPENTRY initialize loopstack for
  //      current level.
  // OPEN,CLOSE are numbered at compile time.
  ///////////////////////////////////////////////////////////////////////

constructor TLMDBoyerMooreSearch.Create(ASkipTableSize, ASkipHashMask: Integer; AInvertCase: TLMDInvertCaseFunction);
begin
  inherited Create;
  FInvertCase    := AInvertCase;
  FSkipTableSize := ASkipTableSize;
  FSkipHashMask  := ASkipHashMask;
end;

function TLMDBoyerMooreSearch.InvertCase(ACh: Integer): Integer;
begin
  if Assigned(self.FInvertCase) then
    Result := FInvertCase(ACh)
  else
    Result := TLMDRegExp.InvertCaseFunction(ACh);
end;

function TLMDBoyerMooreSearch.GetSkipIndex(ACh: Integer): Integer;
begin
  Result := ACh and FSkipHashMask;
end;

function TLMDBoyerMooreSearch.Search(const AInput: TLMDRegexSource;
                                     AOffset: Integer; ACount: Integer=-1): Integer;
var
  pos, badCh, goodSuffix, inputEnd, skipId, PatLn: Integer;
  ch: Integer;
label
  start;

begin
  if (AOffset >= AInput.BaseIndex+AInput.Count) or (AOffset < AInput.BaseIndex) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AOffset]);

  PatLn    := Length(FPattern);
  if (ACount=-1) then
    ACount := AInput.Count - AOffset;

  inputEnd := Min(AInput.Count, AOffset + ACount) - 1 + AInput.BaseIndex;
  Result   := -1;

  start:
    while (AOffset + PatLn - 1) <= inputEnd do
    begin
      for pos := FPatEnd downto 0 do
      begin
        ch := AInput[AOffset + pos];

        if (ch <> FPattern[pos]) and
           ((not FIgnoreCase) or (ch <> FPatternInv[pos]))
        then
        begin
          badCh      := pos - FSkip[GetSkipIndex(ch)];
          goodSuffix := FSuffix[pos];

          if badCh > goodSuffix then
            skipId := badCh
          else
            skipId := goodSuffix;

          Inc(AOffset, skipId);

          goto start;
        end;
      end;
      Result := AOffset;
      Exit;
    end;
end;

procedure TLMDBoyerMooreSearch.Prepare(const APattern: TLMDIntArray; AIgnoreCase: Boolean);

  procedure PrepareSkip;
  var
    i, j: Integer;
  begin
    SetLength(FSkip, FSkipTableSize);

    for i := 0 to FSkipTableSize - 1 do
      FSkip[i] := 0;

    if Length(FPattern) = 0 then
      Exit;

    i := 0;
    repeat
      j := i;

      FSkip[GetSkipIndex(FPattern[j])] := i;

      if FIgnoreCase then
        FSkip[GetSkipIndex(FPatternInv[j])] := i;

      Inc(i);
    until i >= Length(FPattern);

  end;

  procedure PrepareSuffix;
  var
    tmp: TLMDIntArray;
    i, j, k, ii, jj, Lin: Integer;
  begin
    Lin := Length(FPattern);

    j := Lin + 1;
    SetLength(FSuffix, j);
    SetLength(tmp, j);

    for i := 0 to Lin do
    begin
      tmp[i]     := 0;
      FSuffix[i] := 0;
    end;

    tmp[Lin] := j;

    for i := Lin downto 1 do
    begin
      ii := i - 1;
      jj := j - 1;

      while (j <= Lin) and
            (FPattern[ii] <> FPattern[jj]) and
            ((not FIgnoreCase) or (FPatternInv[ii] <> FPattern[jj]))
      do
      begin
        if FSuffix[j] = 0 then
          FSuffix[j] := j - i;

        j := tmp[j];
      end;

      Dec(j);
      tmp[i - 1] := j;

    end;

    k := tmp[0];

    for j := 0 to Lin do
    begin
      if j > 0 then
      begin
        if FSuffix[j] = 0 then
          FSuffix[j - 1] := k
        else
          FSuffix[j - 1] := FSuffix[j];
      end;

      if j = k then
        k := tmp[k];
    end;
  end;

var
  i: Integer;
begin
  FIgnoreCase := AIgnoreCase;

  FPattern := APattern;
  SetLength(FPatternInv, Length(FPattern));
  FPatEnd := Length(FPattern) - 1;

  for i := 0 to FPatEnd do
    FPatternInv[i] := InvertCase(FPattern[i]);

  PrepareSkip;
  PrepareSuffix;
end;
///////////////////////////////////////////////////////////////////////

constructor TLMDRegexNode.Create(AOp: TLMDREOp);
begin
  inherited Create;

  Op   := AOp;

  SetLength(ExactStr, 0);
  SetLength(ExactStrInvC, 0);
  SetLength(TinySet, 0);
  ExactChar := -1;
  ExactCharInvC := -1;

  SetHash := TLMDCharSet.Create;

  MinBrace := -1;
  MaxBrace := -1;
  BackRef  := -1;

  LoopTo := nil;
  NextOp := nil;

  PrevNode := nil;
  NextNode := nil;

  ExactVarId := -1;
end;

destructor TLMDRegexNode.Destroy;
begin
  self.SetHash.Free;
  inherited;
end;

///////////////////////////////////////////////////////////////////////

procedure TLMDCharSet.CheckNotInverted;
begin
  if FInverted then
    raise ELMDCharSetError.Create('Can''t invoke this method after Invert!');
end;

constructor TLMDCharSet.Create;
begin
  inherited;
  Clear;
end;

function TLMDCharSet.Contains(ACh: Integer): Boolean;

  function InRanges: Boolean;
  var
    i, s, e, m: Integer;
  begin

    if FRangesCount < 4 then
    begin
      i      := 0;
      Result := False;

      while i < FRangesCount do
      begin
        if (Ord(ACh) < FRanges[i].Min) or (Ord(ACh) > FRanges[i].Max) then
          Inc(i)
        else
        begin
          Result := True;
          Exit;
        end;
      end;
    end
    else
    begin
      s := 0;
      e := FRangesCount - 1;

      while s < e do
      begin
        m := (s + e) div 2;

        if FRanges[m].Max < Ord(ACh) then
          s := m + 1
        else
          e := m;
      end;

      Result := (FRanges[s].Min <= Ord(ACh)) and (FRanges[s].Max >= Ord(ACh));
    end;
  end;

begin
{$IFDEF LMD_UNICODE}
  if IsAnsiSet then
      result := Ord(ACh) in AnsiSet
  else
  begin
    if not FInverted then
    begin
      if Ord(ACh)<=High(byte) then
        result := Ord(ACh) in AnsiSet
      else
      begin
        result := FHaveCategories and (LMDWideGetCharCategory(WideChar(ACh)) in FCategories);
        if not result then
          result := FHaveRanges and InRanges
      end
    end
    else
    begin
      if Ord(ACh)<=High(byte) then
        result := not (Ord(ACh) in AnsiSet)
      else
      begin
        result := not (FHaveCategories and (LMDWideGetCharCategory(WideChar(ACh)) in FCategories));
        if result then
          result := not (FHaveRanges and InRanges)
      end
    end
  end
{$ELSE}
  Result := Ord(ACh) in AnsiSet;
{$ENDIF}
end;

function TLMDCharSet.Contains(ACh: TLMDChar): Boolean;
begin
  result := Contains(Ord(ACh));
end;

function TLMDCharSet.ContainsAll(const AStr: TLMDString): Boolean;
var
  i: Integer;
begin
  for i := 1 to Length(AStr) do
    if not Contains(AStr[i]) then
    begin
      Result := False;
      EXIT;
    end;

  Result := True;
end;

constructor TLMDCharSet.Create(const AStr: TLMDString);
begin
  inherited Create();
  Clear;
  IncludeChars(AStr);
end;

constructor TLMDCharSet.Create(ACh: Integer);
begin
  inherited Create();
  Clear;
  IncludeChar(ACh);
end;

constructor TLMDCharSet.Create(ACat: TLMDUnicodeCategory);
begin
  inherited Create();
  Clear;
  IncludeCat(ACat);
end;

constructor TLMDCharSet.Create(ACats: TLMDUnicodeCategories);
begin
  inherited Create();
  Clear;
  IncludeCats(ACats);
end;

constructor TLMDCharSet.Create(AMin, AMax: Integer);
begin
  inherited Create();
  Clear;
  IncludeRange(AMin, AMax);
end;

procedure TLMDCharSet.IncludeChar(ACh: Integer);
begin
  CheckNotInverted;

  if not Contains(ACh) then
    IncludeRange(ACh, ACh);
end;

procedure TLMDCharSet.IncludeChars(const AStr: TLMDString);
var
  i: Integer;
begin
  CheckNotInverted;

  for i := 1 to Length(AStr) do
    IncludeChar(Ord(AStr[i]));
end;

procedure TLMDCharSet.Clear;
begin
  IsAnsiSet   := True;
  AnsiSet     := [];
  {$IFDEF LMD_UNICODE} FCategories := []; {$ENDIF}

  FHaveCategories := False;
  FHaveRanges := False;
  FInverted := False;

  FRangesCount := 0;
end;

procedure TLMDCharSet.IncludeCats(ACats: TLMDUnicodeCategories);
var
  LCat: TLMDUnicodeCategory;
begin
  for LCat := Low(TLMDUnicodeCategory) to High(TLMDUnicodeCategory) do
    if LCat in ACats then
      IncludeCat(LCat)
end;

procedure TLMDCharSet.IncludeCat(ACat: TLMDUnicodeCategory);
{$IFDEF LMD_UNICODE}
var
  c: Byte;
begin
  CheckNotInverted;

  FHaveCategories := True;
  IsAnsiSet   := sizeof(TLMDChar) = sizeof(Byte);
  FCategories := FCategories + [ACat];

  case ACat of
    ukLu:  //Letter, Uppercase
    begin
      for c := $41 to $5a do
        AnsiSet := AnsiSet + [c];

      for c := $C0 to $D6 do
        AnsiSet := AnsiSet + [c];

      for c := $D8 to $DE do
        AnsiSet := AnsiSet + [c];
    end;

    ukLl: //Letter, Lowercase
    begin
      for c := $61 to $7a do
        AnsiSet := AnsiSet + [c];

      AnsiSet := AnsiSet + [$aa, $b5, $ba];

      for c := $df to $f6 do
        AnsiSet := AnsiSet + [c];

      for c := $f8 to $ff do
        AnsiSet := AnsiSet + [c];
    end;

    ukLt: ;    //Letter, Titlecase
    ukLm: ;    //Letter, Modifier
    ukLo: ;    //Letter, Other
    ukMn: ;    //Mark, Non-Spacing
    ukMc: ;    //Mark, Spacing Combining
    ukMe: ;    //Mark, Enclosing

    ukNd: //Number, Decimal
    begin
      for c := $30 to $39 do
        AnsiSet := AnsiSet + [c];
    end;

    ukNl: ;    //Number, Letter
    ukNo:      //Number, Other
    begin
      AnsiSet := AnsiSet + [$B2, $B3, $B9];

      for c := $BC to $BE do
        AnsiSet := AnsiSet + [c];
    end;

    ukPc: AnsiSet := AnsiSet + [$5F];    //Punctuation, Connector

    ukPd: AnsiSet := AnsiSet + [$2D, $AD];    //Punctuation, Dash

    ukPs: AnsiSet := AnsiSet + [$28, $5B, $7B];    //Punctuation, Open

    ukPe: AnsiSet := AnsiSet + [$29, $5D, $7D];    //Punctuation, Close

    ukPi: AnsiSet := AnsiSet + [$AB];    //Punctuation, Initial quote

    ukPf: AnsiSet := AnsiSet + [$BB];    //Punctuation, Final quote

    ukPo:
    begin
      for c := $21 to $23 do
        AnsiSet := AnsiSet + [c];

      for c := $25 to $27 do
        AnsiSet := AnsiSet + [c];

      AnsiSet := AnsiSet + [$2a, $2c, $2e, $2f, $3a, $3b, $3f, $40, $5c, $a1, $b7, $bf];
    end;

    ukSm:
    begin
      AnsiSet := AnsiSet + [$2B];

      for c := $3C to $3E do
        AnsiSet := AnsiSet + [c];

      AnsiSet := AnsiSet + [$7c, $7e, $ac, $b1, $d7, $f7];
    end;

    ukSc: AnsiSet := AnsiSet + [$24, $A2, $A3, $A4, $A5];    //Symbol, Currency

    ukSk: AnsiSet := AnsiSet + [$5E, $60, $A8, $AF, $B4, $B8];    //Symbol, Modifier

    ukSo: AnsiSet := AnsiSet + [$A6, $A7, $A9, $AE, $B0, $B6];    //Symbol, Other

    ukZs: AnsiSet := AnsiSet + [$20, $A0];    //Separator, Space

    ukZl: ;    //Separator, Line
    ukZp: ;    //Separator, Paragraph

    ukCc: //Other, Control
    begin
      for c := $0 to $1F do
        AnsiSet := AnsiSet + [c];

      for c := $7F to $9F do
        AnsiSet := AnsiSet + [c];
    end;

    ukCf: ;    //Other, Format

    ukCs: ;    //Other, Surrogate
    ukCo: ;    //Other, Private Use
    ukCn: ;    //Other, Not Assigned Not in ASCII and Latin-1

    else
      Assert(False, 'TLMDCharSet.IncludeCat: unknown category')
  end;
end;
{$ELSE}
begin
  raise ELMDCharSetError.Create('Unicode categories does not work in Ansi mode!');
end;
{$ENDIF}

procedure TLMDCharSet.IncludeRange(AMin, AMax: Integer);

  procedure CopyRanges(ADst, ASrc, ALength: Integer);
  var
    i: Integer;
  begin
    if ALength = 0 then
      Exit;

    if (ADst >= ASrc) and (ADst <= ASrc + ALength) then
      for i := ALength - 1 downto 0 do
        FRanges[ADst + i] := FRanges[ASrc + i]
    else
      for i := 0 to ALength - 1 do
        FRanges[ADst + i] := FRanges[ASrc + i];
  end;

  procedure Resize(ANewCount: Integer);
  begin
    if (Length(FRanges) < ANewCount) or
       ((Length(FRanges) div (ANewCount + 1)) > 4)
    then
      SetLength(FRanges, 3 * ANewCount);

    FRangesCount := ANewCount;
  end;

var
  iMin, iMax, oMin, oMinE, oMax: Integer;
begin
  CheckNotInverted;
  if AMin>AMax then
    raise ELMDCharSetError.Create('IncludeRange: AMin should be <= AMax');

  oMin := Ord(AMin);
  oMax := Ord(AMax);

  oMinE := Min(oMax, High(Byte));
  while oMin <= oMinE do
  begin
    AnsiSet := AnsiSet + [Ord(AMin)];
    Inc(oMin);
    Inc(AMin);
  end;
  if oMin > oMax then
    Exit;
  //////////

  iMin := FRangesCount;
  iMax := -1;
  while (iMin > 0) and ((FRanges[iMin - 1].Max + 1) >= oMin) do
    Dec(iMin);

  while ((iMax + 1) < FRangesCount) and ((FRanges[iMax + 1].Min - 1) <= oMax) do
    Inc(iMax);

  if (iMin > iMax) then //New range, not merged
  begin
    Resize(FRangesCount + 1);

    if iMin < (FRangesCount - 1) then
      CopyRanges(iMin + 1, iMin, FRangesCount - iMin - 1);

    FRanges[iMin].Min := oMin;
    FRanges[iMin].Max := oMax;
  end
  else  //this range is merged with range on its left or right side
  begin
    FRanges[iMin].Min := Min(oMin, FRanges[iMin].Min);
    FRanges[iMin].Max := Max(oMax, FRanges[iMax].Max);

    if (iMin < iMax) and (iMax < (FRangesCount - 1)) then
      CopyRanges(iMin + 1, iMax + 1, FRangesCount - iMax - 1);

    Resize(FRangesCount - (iMax - iMin));
  end;

  FHaveRanges := True;
  IsAnsiSet   := False;
end;

procedure TLMDCharSet.Invert;
begin
  FInverted := True;
  if IsAnsiSet then
    AnsiSet := FullAnsiCharSet - AnsiSet;
end;

procedure TLMDCharSet.Assign(AOther: TLMDCharSet);
var
  i: Integer;
begin
  {$IFDEF LMD_UNICODE} FCategories := AOther.FCategories; {$ENDIF}
  FHaveCategories := AOther.FHaveCategories;
  FHaveRanges := AOther.FHaveRanges;
  FRangesCount := AOther.FRangesCount;
  FInverted := AOther.FInverted;
  AnsiSet   := AOther.AnsiSet;
  IsAnsiSet := AOther.IsAnsiSet;

  SetLength(FRanges, Length(AOther.FRanges));

  for i := 0 to FRangesCount - 1 do
  begin
    FRanges[i].Min := AOther.FRanges[i].Min;
    FRanges[i].Max := AOther.FRanges[i].Max;
  end;
end;

 {=============================================================}
 {===================== Global functions ======================}
 {=============================================================}

function LMDExecRegExpr(const ARegExpr, AInputStr: TLMDString): Boolean;
var
  r: TLMDRegExp;
begin
  r := TLMDRegExp.Create;
  try
    r.Expression := ARegExpr;
    r.InputText := AInputStr;
    Result := r.Exec;
  finally
    r.Free;
  end;
end;

function LMDExecMatchesRegExpr(const ARegExpr, AInputStr: TLMDString; AMatches: TLMDStrings): Boolean;
var
  r: TLMDRegExp;
  i: integer;
begin
  r := TLMDRegExp.Create;
  try
    r.Expression := ARegExpr;
    r.InputText := AInputStr;
    Result := r.Exec;
    if Result then
    begin
      AMatches.Clear;
      AMatches.Add(r.Match[0]);
      for i := 1 to r.MatchCount do
        AMatches.Add(r.Match[i]);
    end;
  finally
    r.Free;
  end;
end;

// Split AInputStr into APieces by r.e. ARegExpr occurencies
procedure LMDSplitRegExpr(const ARegExpr, AInputStr: TLMDString;
                       APieces: TLMDStrings);
var
  r: TLMDRegExp;
begin
  APieces.Clear;
  r := TLMDRegExp.Create;
  try
    r.Expression := ARegExpr;
    r.InputText := AInputStr;

    r.Split(APieces);
  finally
    r.Free;
  end;
end;

function LMDReplaceRegExpr(const ARegExpr, AInputStr, AReplaceStr: TLMDString;
                           AUseSubstitution: Boolean = False): TLMDString;
begin
  with TLMDRegExp.Create do
  try
    Expression := ARegExpr;
    InputText  := AInputStr;

    Result     := Replace(AReplaceStr, AUseSubstitution);
  finally
    Free;
  end;
end;

function LMDQuoteRegExprMetaChars(const AStr: TLMDString): TLMDString;
var
  i, i0, Len: Integer;
  RegExprMetaSet: TLMDString;
begin
  RegExprMetaSet := META + ']}'; // - this last are additional to META.
                                 // Very similar to META array, but slighly changed.
                                 // !Any changes in META array must be synchronized with this set.

  Result := '';
  Len    := Length(AStr);
  i      := 1;
  i0     := i;
  while i <= Len do
  begin
    if Pos(AStr[i], RegExprMetaSet) > 0 then
    begin
      Result := Result + Copy(AStr, i0, i - i0) + EscChar + AStr[i];
      i0     := i + 1;
    end;
    Inc(i);
  end;
  Result := Result + Copy(AStr, i0, MaxInt); // Tail
end;

 {=============================================================}
 {================== Error handling section ===================}
 {=============================================================}

const
  reeOk = 0;
  reeCompNullArgument = 100;
  reeCompRegexpTooBig = 101;
  reeCompParseRegTooManyBrackets = 102;
  reeCompParseRegUnmatchedBrackets = 103;
  reeCompParseRegUnmatchedBrackets2 = 104;
  reeCompParseRegJunkOnEnd = 105;
  reePlusStarOperandCouldBeEmpty = 106;
  reeNestedSQP = 107;
  reeBadHexDigit = 108;
  reeInvalidRange = 109;
  reeParseAtomTrailingBackSlash = 110;
  reeNoHexCodeAfterBSlashX = 111;
  reeHexCodeAfterBSlashXTooBig = 112;
  reeUnmatchedSqBrackets = 113;
  reeInternalUrp = 114;
  reeQPSBFollowsNothing = 115;
  reeTrailingBackSlash = 116;
  reeRarseAtomInternalDisaster = 119;
  reeBRACESArgTooBig = 122;
  reeBracesMinParamGreaterMax = 124;
  reeUnclosedComment = 125;
  reeComplexBracesNotImplemented = 126;
  reeUrecognizedModifier = 127;
  reeBadLinePairedSeparator = 128;
  reeBracesNotBalanced = 129;
  reeNegativeSetNotSupportedInRanges = 130;
  reeUnicodeCategoriesNotSupportedInAnsi = 131;
  reeMalformedUnicodeCategory = 132;
  reeUnicodeCharHexCodesNotSupportedInAnsi = 133;
  reeSubstituteMalformedVariable = 134;
  reeCodesResolverNotAssigned = 135;
  reeMalformedIntCode = 136;
  reeCannotResolveIntCode = 137;
  reeThisConstructRequiresIntCodesMode = 138;
  reeThisConstructNotWorkingInIntCodesMode = 139;
  reeCodesModeIsIncompatibeWithOthers = 140;
  reeComplexBracesNotImplementedForLookahead = 141;

  reeRegRepeatCalledInappropriately = 1000;
  reeMatchPrimMemoryCorruption = 1001;
  reeMatchPrimCorruptedPointers = 1002;
  reeNoExpression = 1003;
  reeCorruptedProgram = 1004;
  reeExecNextWithoutExec = 1007;
  reeGetInputStringWithoutInputString = 1008;
  reeDumpCorruptedOpcode = 1011;
  reeModifierUnsupported = 1013;
  reeLoopStackExceeded = 1014;
  reeLoopWithoutEntry = 1015;
  reeThisOperationNotWorkingInIntCodesMode = 1016;
  reeBadPCodeImported = 2000;
  reeInputSourceIsNotString = 2001;
  reeInputSourceNotSet = 2002;

function TLMDRegExp.ErrorMsg(AErrorID: Integer): TLMDString;
begin
  case AErrorID of
    reeOk: Result := SLMDOk;
    reeCompNullArgument: Result := SLMDCompNullArgument;
    reeCompRegexpTooBig: Result := SLMDCompRegexpTooBig;
    reeCompParseRegTooManyBrackets: Result := SLMDCompParseRegTooManyBrackets;
    reeCompParseRegUnmatchedBrackets: Result := SLMDCompParseRegUnmatchedBrackets;
    reeCompParseRegUnmatchedBrackets2: Result := SLMDCompParseRegUnmatchedBrackets2;
    reeCompParseRegJunkOnEnd: Result := SLMDCompParseRegJunkOnEnd;
    reePlusStarOperandCouldBeEmpty: Result := SLMDPlusStarOperandCouldBeEmpty;

    reeNestedSQP: Result := SLMDNestedSQP;
    reeBadHexDigit: Result := SLMDBadHexDigit;
    reeInvalidRange: Result := SLMDInvalidRange;
    reeParseAtomTrailingBackSlash: Result := SLMDParseAtomTrailingBackSlash;
    reeNoHexCodeAfterBSlashX: Result := SLMDNoHexCodeAfterBSlashX;
    reeHexCodeAfterBSlashXTooBig: Result := SLMDHexCodeAfterBSlashXTooBig;
    reeUnmatchedSqBrackets: Result := SLMDUnmatchedSqBrackets;
    reeInternalUrp: Result := SLMDInternalUrp;
    reeQPSBFollowsNothing: Result := SLMDQPSBFollowsNothing;
    reeTrailingBackSlash: Result := SLMDTrailingBackSlash;
    reeRarseAtomInternalDisaster: Result := SLMDRarseAtomInternalDisaster;
    reeBRACESArgTooBig: Result := SLMDBRACESArgTooBig;
    reeBracesMinParamGreaterMax: Result := SLMDBracesMinParamGreaterMax;
    reeBracesNotBalanced: Result := SLMDBracesNotBalanced;
    reeUnclosedComment: Result := SLMDUnclosedComment;
    reeUrecognizedModifier: Result := SLMDUrecognizedModifier;
    reeBadLinePairedSeparator: Result := SLMDBadLinePairedSeparator;
    reeRegRepeatCalledInappropriately: Result := SLMDRegRepeatCalledInappropriately;
    reeMatchPrimMemoryCorruption: Result := SLMDMatchPrimMemoryCorruption;
    reeMatchPrimCorruptedPointers: Result := SLMDMatchPrimCorruptedPointers;
    reeNoExpression: Result      := SLMDNoExpression;
    reeCorruptedProgram: Result  := SLMDCorruptedProgram;
    reeExecNextWithoutExec: Result := SLMDExecNextWithoutExec;
    reeGetInputStringWithoutInputString: Result := SLMDGetInputStringWithoutInputString;
    reeDumpCorruptedOpcode: Result := SLMDDumpCorruptedOpcode;
    reeLoopStackExceeded: Result := SLMDLoopStackExceeded;
    reeLoopWithoutEntry: Result  := SLMDLoopWithoutEntry;
    reeModifierUnsupported: Result := SLMDModifierUnsupported;
    reeComplexBracesNotImplementedForLookahead: Result := SLMDComplexBracesNotImplementedForLookahead;

    reeBadPCodeImported: Result := SLMDBadPCodeImported;
    reeNegativeSetNotSupportedInRanges: Result := SLMDNegativeSetNotSupportedInRanges;
    reeUnicodeCategoriesNotSupportedInAnsi: Result := SLMDUnicodeCategoriesNotSupportedInAnsi;
    reeMalformedUnicodeCategory: Result := SLMDMalformedUnicodeCategory;
    reeUnicodeCharHexCodesNotSupportedInAnsi: Result := SLMDUnicodeCharHexCodesNotSupportedInAnsi;
    reeSubstituteMalformedVariable: Result := SLMDSubstituteMalformedVariable;
    reeCodesResolverNotAssigned: Result := SLMDCodesResolverNotAssigned;
    reeMalformedIntCode: Result := SLMDMalformedIntCode;
    reeCannotResolveIntCode: Result := SLMDCannotResolveIntCode;
    reeThisConstructRequiresIntCodesMode: Result := SLMDThisConstructRequiresIntCodesMode;
    reeThisConstructNotWorkingInIntCodesMode: Result := SLMDThisConstructNotWorkingInIntCodesMode;
    reeCodesModeIsIncompatibeWithOthers: Result := SLMDCodesModeIsIncompatibeWithOthers;
    reeThisOperationNotWorkingInIntCodesMode: Result := SLMDThisOperationNotWorkingInIntCodesMode;
    reeInputSourceIsNotString: Result := SLMDInputSourceIsNotString;
    reeInputSourceNotSet: Result := SLMDInputSourceNotSet;
    else
      Result := SLMDUnknownError;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.LastError: Integer;
begin
  Result     := FLastError;
  FLastError := reeOk;
end;

{ ---------------------------------------------------------------------------- }

 {=============================================================}
 {===================== Common section ========================}
 {=============================================================}

function TLMDRegExp.CompiledSubExpCount: Integer;
begin
  result := FSubexpCount;
end;

class function TLMDRegExp.SubExpMaxCount: Integer;
begin
  result := NSUBEXP;
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.AddHexDigitsSet(ASet: TLMDCharSet);
begin
  ASet.IncludeRange(Ord('0'), Ord('9'));
  ASet.IncludeRange(Ord('a'), Ord('f'));
  ASet.IncludeRange(Ord('A'), Ord('F'));
end;

{$IFDEF LMD_UNICODE}

procedure TLMDRegExp.AddWordSet(ASet: TLMDCharSet);
begin
  ASet.IncludeCat(ukLl);
  ASet.IncludeCat(ukLt);
  ASet.IncludeCat(ukLu);
  ASet.IncludeCat(ukNd);
  ASet.IncludeCat(ukNl);
  ASet.IncludeCat(ukNo);
  ASet.IncludeCat(ukPc);

  ASet.IncludeChars(FWordChars);
end;

procedure TLMDRegExp.AddLineSepSet(ASet: TLMDCharSet);
begin
  ASet.IncludeCat(ukZl);
  ASet.IncludeCat(ukZp);
  ASet.IncludeChars(FLineSeparators);
end;

procedure TLMDRegExp.AddDigitsSet(ASet: TLMDCharSet);
begin
  ASet.IncludeCat(ukNd);
  ASet.IncludeCat(ukNl);
  ASet.IncludeChars(RegExprNumberChars);
end;

procedure TLMDRegExp.AddIgnoredCharSet(ASet: TLMDCharSet);
begin
  ASet.IncludeCat(ukZl);
  ASet.IncludeCat(ukZs);
  ASet.IncludeCat(ukZp);
  ASet.IncludeChars(FSpaceChars + FLineSeparators);
end;

procedure TLMDRegExp.AddSpaceSet(ASet: TLMDCharSet);
begin
  ASet.IncludeCat(ukZs);
  ASet.IncludeChars(FSpaceChars);
end;

procedure TLMDRegExp.AddWordSepsSet(ASet: TLMDCharSet);
begin
  AddSpaceSet(ASet);
  ASet.IncludeChars(FWordSeparators);
end;

{$ELSE}

procedure TLMDRegExp.AddWordSepsSet(ASet: TLMDCharSet);
begin
  AddSpaceSet(ASet);
  ASet.IncludeChars(FWordSeparators);
end;

procedure TLMDRegExp.AddWordSet(ASet: TLMDCharSet);
begin
  ASet.IncludeChars(FWordChars);
end;

procedure TLMDRegExp.AddLineSepSet(ASet: TLMDCharSet);
begin
  ASet.IncludeChars(FLineSeparators);
end;

procedure TLMDRegExp.AddDigitsSet(ASet: TLMDCharSet);
begin
  ASet.IncludeChars(RegExprNumberChars);
end;

procedure TLMDRegExp.AddIgnoredCharSet(ASet: TLMDCharSet);
begin
  ASet.IncludeChars(FSpaceChars + FLineSeparators);
end;

procedure TLMDRegExp.AddSpaceSet(ASet: TLMDCharSet);
begin
  ASet.IncludeChars(FSpaceChars);
end;

{$ENDIF}

constructor TLMDRegExp.Create;
begin
  inherited;

  SetSubExpCountLow(0);
  FInput := nil;
  FOwnsInput := false;

  SetLength(FStartp, 1);
  SetLength(FEndp, 1);
  SetLength(FLoopStack, LOOP_STACK_MAX + 1);

  FExpr := '';

  FExprIsCompiled := False;

  FInvertCase := nil;

  FLineSeparators := RegExprLineSeparators;
  FSpaceChars := RegExprSpaceChars;
  FWordChars  := RegExprWordChars;

  FProgrammFirst := nil;
  FProgrammLast  := nil;

  FLineSeparatorsSet := TLMDCharSet.Create;
  FIgnoredChars := TLMDCharSet.Create;
  FWordCharsSet := TLMDCharSet.Create;
  FWordSepsSet := TLMDCharSet.Create;
  FDigitsSet := TLMDCharSet.Create;
  FHexDigCharSet := TLMDCharSet.Create;

  FRangeSet := TLMDCharSet.Create;

  FVariablesList := TList.Create;

  InvalidateProgramm;

  ModifierI := RegExprModifierI;
  ModifierS := RegExprModifierS;
  ModifierG := RegExprModifierG;
  ModifierM := RegExprModifierM;
  ModifierX := RegExprModifierX;

  LinePairedSeparator := RegExprLinePairedSeparator;

  FBMSearch := TLMDBoyerMooreSearch.Create(256, $FF, FInvertCase);

  FVarsOptsOk := false;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDRegExp.Destroy;
begin
  InvalidateProgramm;

  FBMSearch.Free;
  FLineSeparatorsSet.Free;
  FIgnoredChars.Free;
  FWordCharsSet.Free;
  FWordSepsSet.Free;
  FDigitsSet.Free;
  FHexDigCharSet.Free;

  FRangeSet.Free;

  if FOwnsInput then
    FInput.Free;

  FVariablesList.Free;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDRegExp.InvertCaseFunction(const Ch: Integer): Integer;
var C: TLMDChar;
begin
  C := TLMDChar(Ch);

  Result := Integer(LMDLowerCaseChar(C));
  if Result = Ch then
    Result := Integer(LMDUpperCaseChar(C));
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.GetExpression: TLMDString;
begin
  Result := FExpr;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.SetExpression(const s: TLMDString);
begin
  if (s <> FExpr) or (not FExprIsCompiled) then
    begin
      FExprIsCompiled := False;
      FExpr := s;
      if FExpr <> '' then
        Compile;
    end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.GetSubExprMatchCount: Integer;
var
  i: Integer;
begin
  Result := 0;

  for i := 1 to FSubexpCount-1 do
    if (FStartp[i] <> -1) and (FEndp[i] <> -1) then
      Inc(Result)
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.GetMatchPos(Idx: Integer): Integer;
begin
  if (Idx >= 0) and (Idx < FSubexpCount) and
     (FStartp[Idx] <> -1) and (FEndp[Idx] <> -1)
  then
    Result := FStartp[Idx]
  else
    Result := -1;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.GetMatchLen(Idx: Integer): Integer;
begin
  if (Idx >= 0) and (Idx < FSubexpCount) and
     (FStartp[Idx] <> -1) and (FEndp[Idx] <> -1)
  then
    Result := FEndp[Idx] - FStartp[Idx]
  else
    Result := -1;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.GetMatch(Idx: Integer): TLMDString;
var Arr: TLMDCharArray; i: Integer;
begin
  CheckNotInCodesMode('TLMDRegExp.GetMatch');

  SetLength(Result, 0);

  if (Idx >= 0) and (Idx < FSubexpCount)  and
     (FStartp[Idx] <> -1) and (FEndp[Idx] <> -1)
  then
  begin
    SetLength(Arr, GetMatchLen(Idx));

    for i := FStartp[Idx] to FEndp[Idx] - 1 do
      Arr[i - FStartp[Idx]] := TLMDChar(FInput[i]);

    Result := LMDCharArrayToString(Arr, 0, Length(Arr));
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.GetModifierStr: TLMDString;
begin
  Result := '-';

  if ModifierI then
    Result := 'i' + Result
  else
    Result := Result + 'i';

  if ModifierS then
    Result := 's' + Result
  else
    Result := Result + 's';

  if ModifierG then
    Result := 'g' + Result
  else
    Result := Result + 'g';

  if ModifierM then
    Result := 'm' + Result
  else
    Result := Result + 'm';

  if ModifierX then
    Result := 'x' + Result
  else
    Result := Result + 'x';

  if Result[length(Result)] = '-' then
    SetLength(Result, length(Result) - 1);
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.ParseModifiersStr(const AStr: TLMDString;
                                       AStart, AEnd: Integer;
                                       var AModifiersInt: Integer): Boolean;
var
  i:    Integer;
  IsOn: Boolean;
  Mask: Integer;
begin
  Result := True;
  IsOn   := True;
  for i := AStart to AEnd do
  begin
    if AStr[i] = '-' then
      IsOn := False
    else
    begin
      if Pos(AStr[i], 'iI') > 0 then
      begin
        CheckNotInCodesMode('Modifier: i or I');
        Mask := MaskModI;
      end
      else
      if Pos(AStr[i], 'sS') > 0 then
      begin
        CheckNotInCodesMode('Modifier: s or S');
        Mask := MaskModS;
      end
      else
      if Pos(AStr[i], 'gG') > 0 then
      begin
        CheckNotInCodesMode('Modifier: g or G');
        Mask := MaskModG;
      end
      else
      if Pos(AStr[i], 'mM') > 0 then
      begin
        CheckNotInCodesMode('Modifier: m or M');
        Mask := MaskModM;
      end
      else
      if Pos(AStr[i], 'xX') > 0 then
        Mask := MaskModX
      else
      begin
        {$IFNDEF LMDCOMP24}Mask := 0;{$ENDIF} // Initialize.
        Result := False;
        Exit;
      end;

      if IsOn then
        AModifiersInt := AModifiersInt or Mask
      else
        AModifiersInt := AModifiersInt and not Mask;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.SetModifierStr(const AModifiers: TLMDString);
begin
  InvalidateProgramm;

  if not ParseModifiersStr(AModifiers, 0, Length(AModifiers), FModifiers) then
    Error(reeModifierUnsupported);

  InvalidateProgramm;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.GetModifier(AIndex: Integer): Boolean;
var
  Mask: Integer;
begin
  Mask := 0;
  case AIndex of
    1: Mask := MaskModI;
    3: Mask := MaskModS;
    4: Mask := MaskModG;
    5: Mask := MaskModM;
    6: Mask := MaskModX;
    7: Mask := MaskModA;
    8: Mask := MaskModC;
    else
      Error(reeModifierUnsupported);
  end;
  Result := (FModifiers and Mask) <> 0;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.SetModifier(AIndex: Integer; ASet: Boolean);
var
  Mask: Integer;
begin
  Mask := 0;
  InvalidateProgramm;

  case AIndex of
    1: Mask := MaskModI;
    3: Mask := MaskModS;
    4: Mask := MaskModG;
    5: Mask := MaskModM;
    6: Mask := MaskModX;
    7: Mask := MaskModA;
    8: Mask := MaskModC;
    else
      Error(reeModifierUnsupported);
  end;

  if Mask=MaskModC then
  begin
    if (FModifiers and (not (MaskModX or MaskModA or MaskModC or MaskModG)))<>0
    then
      Error(reeCodesModeIsIncompatibeWithOthers);
  end
  else if Mask<>MaskModX then
  begin
    if ModifierC then
      Error(reeCodesModeIsIncompatibeWithOthers);
  end;

  if ASet then
    FModifiers := FModifiers or Mask
  else
    FModifiers := FModifiers and not Mask;

  InvalidateProgramm;
end;

{ ---------------------------------------------------------------------------- }

{=============================================================}
{==================== Compiler section =======================}
{=============================================================}

procedure TLMDRegExp.SetInput(const AInput: TLMDRegexSource; AOwnIt: Boolean);
begin
  if FOwnsInput and (FInput<>nil) then
    FInput.Free;

  FOwnsInput := AOwnIt;
  FInput := AInput;
end;

function TLMDRegExp.CompModifier(AMod: Integer): Boolean;
begin
  result := (FCompModifiers and AMod) <> 0
end;

function TLMDRegExp.HexDig(ch: TLMDChar): Integer;//Unicode?
begin
  if (ch >= 'a') and (ch <= 'f') then
    ch := TLMDChar(Ord(ch) - (Ord('a') - Ord('A')));

  if not FHexDigCharSet.Contains(ch) then
    Error(reeBadHexDigit);

  Result := Ord(ch) - Ord('0');

  if ch >= 'A' then
    Result := Result - (Ord('A') - Ord('9') - 1);
end;

function TLMDRegExp.UnQuoteChar(var AIdx: Integer;
                                 const AStr: TLMDString;
                                 AStrEnd: Integer): TLMDChar;
var
  Ch: TLMDChar; UMode: Boolean; Start: Integer;
begin
  Ch := AStr[AIdx];
  case Ch of
    't': // tab (HT/TAB)
    begin
      Result := LMDTab;
    end;

    'n': // newline (NL)
    begin
      Result := LMDLF;
    end;

    'r':  // car.return (CR)
    begin
      Result := LMDCR;
    end;

    'f': // form feed (FF)
    begin
      Result := LMDFF;
    end;

    'a': // alarm (bell) (BEL)
    begin
      Result := LMDBEL;
    end;

    'e': // escape (ESC)
    begin
      Result := LMDESCAPE;
    end;

    'x', 'u', 'U':
    begin // hex char
      Result := #0;

      Start := AIdx;
      UMode := (Ch='u') or (Ch='U');

    {$IFNDEF LMD_UNICODE}
      if UMode then
        Error(reeUnicodeCharHexCodesNotSupportedInAnsi);
    {$ENDIF}

      Inc(AIdx);
      if AIdx >= AStrEnd then
        Error(reeNoHexCodeAfterBSlashX);

      Ch := AStr[AIdx];
      if (Ch = '{') or UMode then // \x{nnnn} or \Unnnn
      begin
        if Ch='{' then
          Inc(AIdx);

        while AIdx < AStrEnd do
        begin
          Ch := AStr[AIdx];

          if FHexDigCharSet.Contains(Ch)  then
          begin
            // HexDig will cause Error if bad hex digit found
            if ((Ord(Result) shr (SizeOf(TLMDChar) * 8 - 4)) and $F) <> 0 then
              Error(reeHexCodeAfterBSlashXTooBig);

            Result := TLMDChar((Ord(Result) shl 4) or HexDig(Ch));
          end
          else
            BREAK;

          Inc(AIdx);
        end;

        if (UMode and (AIdx-Start=1)) or
           ((not UMode) and
            ((AIdx=AStrEnd) or (AStr[AIdx]<>'}')))
        then
          Error(reeNoHexCodeAfterBSlashX);

        if UMode then //step back to last char of \u00FF (we should be at last char after return)
          Dec(AIdx);
      end
      else
      begin
        Result := TLMDChar(HexDig(Ch));

        Inc(AIdx);
        if AIdx >= AStrEnd then  // HexDig will cause Error if bad hex digit found
          Error(reeNoHexCodeAfterBSlashX);

        Ch     := AStr[AIdx];
        Result := TLMDChar((Ord(Result) shl 4) or HexDig(Ch));
      end;
    end;
    else
      Result := Ch;
  end;
end;

function TLMDRegExp.ParseIntCode(var AIdx: Integer; const AStr: TLMDString): Integer;
var Name: TLMDString; i, ib, ie: Integer; ok, quoted: Boolean;
begin
  i := AIdx;
  Result := -1;
  ok := i < FParseEnd;

  if ok then
  begin
    quoted := AStr[i]='{';
    if quoted then
      AdvanceParseEx(i);

    Name := '';
    ib := i;
    ie := i;
    while not ( (ie = FParseEnd) or
                (quoted and (AStr[ie] = '}')) or
                ((not quoted) and FIgnoredChars.Contains(AStr[ie])) )
    do
    begin
      if AStr[ie]='\' then
        Inc(ie);

      if ie < FParseEnd then
      begin
        Name := Name + AStr[ie];
        Inc(ie);
      end;
    end;

    if quoted then
      ok := (i < FParseEnd) and (ib < ie) and (AStr[i] = '}')
    else
      ok := ib<ie;

    if not ok then
      Error(reeMalformedUnicodeCategory);

    if not Assigned(FCodesResolver) then
      Error(reeCodesResolverNotAssigned);

    Assert(Length(Name)>0);
    Result := FCodesResolver(Name);

    AIdx := ie-1;
  end;

  ok := Result<>-1;
  if not ok then
    Error(reeCannotResolveIntCode);
end;

function TLMDRegExp.TryParseUnicodeCat(var AIdx: Integer;
                                        var ACats: TLMDUnicodeCategories;
                                        const AStr: TLMDString): Boolean;
var i, ib, ie: Integer;

function GetCat: Boolean;
var ie2: Integer;
begin
  ie2 := ie-1;
  Result := (ie2=ib) or (ie2=(ib+1));

  if not Result then
    Exit;

  case AStr[ib] of
    'L':
    begin
      if ib=ie2 then
        ACats := [ukLl, ukLu, ukLt, ukLm, ukLo]
      else
        case AStr[ie2] of
          'l': ACats := [ukLl];
          'u': ACats := [ukLu];
          't': ACats := [ukLt];
          'm': ACats := [ukLm];
          'o': ACats := [ukLo];
        end;
    end;

    'M':
    begin
      if ib=ie2 then
        ACats := [ukMn, ukMc, ukMe]
      else
        case AStr[ie2] of
          'n': ACats := [ukMn];
          'c': ACats := [ukMc];
          'e': ACats := [ukMe];
        end;
    end;

    'Z':
    begin
      if ib=ie2 then
        ACats := [ukZs, ukZl, ukZp]
      else
        case AStr[ie2] of
         's': ACats := [ukZs];
         'l': ACats := [ukZl];
         'p': ACats := [ukZp];
        end;
    end;

    'S':
    begin
      if ib=ie2 then
        ACats := [ukSm, ukSc, ukSk, ukSo]
      else
        case AStr[ie2] of
          'm': ACats := [ukSm];
          'c': ACats := [ukSc];
          'k': ACats := [ukSk];
          'o': ACats := [ukSo];
        end;
    end;

    'N':
    begin
      if ib=ie2 then
        ACats := [ukNd, ukNl, ukNo]
      else
        case AStr[ie2] of
          'd': ACats := [ukNd];
          'l': ACats := [ukNl];
          'o': ACats := [ukNo];
        end;
    end;

    'P':
    begin
      if ib=ie2 then
        ACats := [ukPd, ukPs, ukPe, ukPi, ukPf, ukPc, ukPo]
      else
        case AStr[ie2] of
          'd': ACats := [ukPd];
          's': ACats := [ukPs];
          'e': ACats := [ukPe];
          'i': ACats := [ukPi];
          'f': ACats := [ukPf];
          'c': ACats := [ukPc];
          'o': ACats := [ukPo];
        end;
    end;

    'C':
    begin
      if ib=ie2 then
        ACats := [ukCc, ukCf, ukCo, ukCs, ukCn]
      else
        case AStr[ie2] of
          'c': ACats := [ukCc];
          'f': ACats := [ukCf];
          'o': ACats := [ukCo];
          's': ACats := [ukCs];
          'n': ACats := [ukCn];
        end;
    end;
  end;

  Result := ACats<>[];
end;

begin
  Assert(not (CompModifier(MaskModX) and FIgnoredChars.Contains(TLMDChar('}'))));

  ACats := [];
  i := AIdx;
  Inc(i);
  Result := (i < FParseEnd) and (AStr[i] = '{');

  if Result then
  begin
    AdvanceParseEx(i);

    ib := i;
    ie := i;
    if CompModifier(MaskModX) then
      while (ie<FParseEnd) and (not FIgnoredChars.Contains(AStr[ie])) and
            (AStr[ie]<>'}')
      do
        Inc(ie)
    else
      while (ie<FParseEnd) and (AStr[ie]<>'}') do
        Inc(ie);

    i := ie-1;
    AdvanceParseEx(i);

    Result := (i<FParseEnd) and (ib<ie) and (AStr[i]='}') and GetCat;

    if not Result then
      Error(reeMalformedUnicodeCategory);

    AIdx := i
  end;
end;

procedure TLMDRegExp.SetInvertCaseFn(AInvertCase: TLMDInvertCaseFunction);
begin
  FInvertCase := AInvertCase;
  FBMSearch.FInvertCase := FInvertCase;

  InvalidateProgramm;
end;

function TLMDRegExp.InvertCase(ACh: Integer): Integer;
begin
  if Assigned(self.FInvertCase) then
    Result := FInvertCase(ACh)
  else
    Result := TLMDRegExp.InvertCaseFunction(ACh);
end;

procedure TLMDRegExp.InvalidateProgramm;
var
  Node, Tmp: TLMDRegexNode;
begin
  FExprIsCompiled := false;

  ClearMatches;

  FCompiledFlags := 0;
  Node := FProgrammFirst;
  while Node <> nil do
  begin
    Tmp  := Node;
    Node := Node.NextNode;
    Tmp.Free;
  end;

  FProgrammFirst := nil;
  FProgrammLast  := nil;

  // can we optimize line separators by using sets?
  FLineSeparatorsSet.Clear;
  AddLineSepSet(FLineSeparatorsSet);

  FWordCharsSet.Clear;
  AddWordSet(FWordCharsSet);

  FDigitsSet.Clear;
  AddDigitsSet(FDigitsSet);

  FIgnoredChars.Clear;
  AddIgnoredCharSet(FIgnoredChars);

  FHexDigCharSet.Clear;
  AddHexDigitsSet(FHexDigCharSet);

  SetSubExpCountLow(0);

  FVariablesList.Clear;
  FVarsOptsOk := false;

  FFirstCharSetHasUnicode := false;
  FFirstCharSet := [];

  FRegStart := nil;
  FRegAnch := false;
  FRegmustExact := nil;

  FReginput := -1;
  FSavedReginput := -1;

  FInputStart := -1;
  FInputEnd := -1;

  FNeedMore := false;

  FParse := -1;
  FParseEnd := -1;

  FSubexpCount := -1;

  FRangeSet.Clear;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.Compile;
begin
  if FExpr = '' then // No Expression assigned
    Error(reeNoExpression);

  CompileRegExpr;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.IsProgrammOk: Boolean;
begin
  Result := False;

  // check modifiers
  if FModifiers <> FProgModifiers then
    InvalidateProgramm;

  // [Re]compile if needed
  if FProgrammFirst = nil then
    Compile;

  // check [re]compiled programm
  if FProgrammFirst = nil then // error was set/raised by Compile (was reeExecAfterCompErr)
    EXIT
  else
    Result := True;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.Tail(ALinkTo: TLMDRegexNode; ANode: TLMDRegexNode);
// set the next-pointer at the end of a node chain
var
  scan: TLMDRegexNode;
  temp: TLMDRegexNode;
begin
  // Find last node.
  scan := ALinkTo;
  repeat
    temp := scan.NextOp;
    if temp = nil then
      BREAK;
    scan := temp;
  until False;

  // Set Next 'pointer'
  scan.NextOp := ANode;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.OpTail(ALinkTo: TLMDRegexNode; ANode: TLMDRegexNode);
// regtail on operand of first argument; nop if operandless
begin
  // "Operandless" and "op != BRANCH" are synonymous in practice.
  if (ALinkTo = nil) or (ALinkTo.Op <> BRANCH) then
    EXIT;
  Tail(ALinkTo.NextNode, ANode);
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.EmitNode(AOp: TLMDREOp): TLMDRegexNode;
  // emit a node, return location
begin
  Result := TLMDRegexNode.Create(AOp);

  if FProgrammFirst = nil then
    FProgrammFirst := Result;

  if FProgrammLast <> nil then
    FProgrammLast.NextNode := Result;

  Result.PrevNode := FProgrammLast;
  Result.NextNode := nil;

  FProgrammLast := Result;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.InsertOperator(AOp: TLMDREOp; var AOpnd: TLMDRegexNode);
 // insert an operator in front of already-emitted operand
 // Means relocating the operand.
var
  Node: TLMDRegexNode;
begin
  Node := TLMDRegexNode.Create(AOp);
  Node.PrevNode := AOpnd.PrevNode;
  Node.NextNode := AOpnd;

  Node.PrevNode.NextNode := Node;
  Node.NextNode.PrevNode := Node;

  AOpnd := Node;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.CompileRegExpr: Boolean;
  // compile a regular expression into internal code
  // We can't allocate space until we know how big the compiled form will be,
  // but we can't compile it (and thus know how big it is) until we've got a
  // place to put the code.  So we cheat:  we compile it twice, once with code
  // generation turned off and size counting turned on, and once "for real".
  // This also means that we don't allocate space until we are sure that the
  // thing really will compile successfully, and we never have to move the
  // code and thus invalidate pointers into it.  (Note that it has to be in
  // one piece because free() must be able to free it all.)
  // Beware that the optimization-preparation code in here knows about some
  // of the structure of the compiled regexp.

  procedure OptimizeRe;

  var
    Node, Next: TLMDRegexNode;

    procedure RemoveNext;
    var
      N, NewNext: TLMDRegexNode;
    begin
      NewNext := Next.NextNode;
      N := FProgrammFirst;
      while N <> nil do
      begin
        if (N <> Next) then
        begin
          if N.NextOp = Next then
            N.NextOp := Next.NextOp;

          if N.LoopTo = Next then
            N.LoopTo := Next.NextOp;
        end;

        N := N.NextNode;
      end;

      Node.NextNode := NewNext;

      if NewNext <> nil then
        NewNext.PrevNode := Node;

      Next.Free;
    end;

  begin
    Node := FProgrammFirst;
    while Node <> nil do
    begin
      Next := Node.NextNode;
      if (Next <> nil) and (Next.Op = COMMENT) then
      begin
        RemoveNext;
        Continue;
      end;

      Node := Next;
    end;
  end;

begin
  Result := False; // life too dark

  FParse := -1; // for correct error handling
  try
    InvalidateProgramm;

    if Expression = '' then
      Error(reeCompNullArgument);

    // well, may it's paranoia. I'll check it later...
    FProgModifiers := FModifiers;

    // First pass: determine size, legality.
    FCompModifiers := FModifiers;
    FParseEnd := Length(FExpr) + 1;
    SetSubExpCountLow(1);
    FParse    := 0;
    AdvanceParse;
    if ParseReg(-1, FCompiledFlags) = nil then
    begin
      InvalidateProgramm;
      EXIT;
    end;

    OptimizeRe;

    if not HasVariables then
      PrepareVarsOpts;

    Result := True;
  finally
    if not Result then
      InvalidateProgramm;

    FExprIsCompiled := Result;
  end;

end;

{ ---------------------------------------------------------------------------- }

 // something followed by possible [*+?{]
 // Note that the branching code sequences used for ? and the general cases
 // of * and + and { are somewhat optimized:  they use the same NOTHING node as
 // both the endmarker for their branch list and the body of the last branch.
 // It might seem that this node could be dispensed with entirely, but the
 // endmarker role is not redundant.
function TLMDRegExp.ParseNumExpr(AStart, AEnd: Integer): Integer;
begin
  Result := 0;
  if AEnd - AStart + 1 > 8 then // prevent stupid scanning
    Error(reeBRACESArgTooBig);

  while AStart <= AEnd do
  begin
    Result := Result * 10 + (Ord(FExpr[AStart]) - Ord('0'));
    Inc(AStart);
  end;

  if (Result > MaxBracesArg) or (Result < 0) then
    Error(reeBRACESArgTooBig);
end;

function TLMDRegExp.ParseReg(AParenNo: Integer; var AFlagp: Integer): TLMDRegexNode;
  // regular expression, i.e. main body or parenthesized thing
  // Caller must absorb opening parenthesis.
  // Combining parenthesis handling with the base level of regular expression
  // is a trifle forced, but the need to tie the tails of the branches to what
  // follows makes it hard to avoid.
var
  ret:   TLMDRegexNode;
  br, ender: TLMDRegexNode;
  parno: Integer;
  flags: Integer;
  SavedModifiers: Integer;
begin
  AFlagp := HASWIDTH; // Tentatively.
  parno  := 0; // eliminate compiler stupid warning
  SavedModifiers := FCompModifiers;

  // Make an OPEN node, if parenthesized.
  if AParenNo <> -1 then
  begin
    if FSubexpCount >= NSUBEXP then
      Error(reeCompParseRegTooManyBrackets);

    if AParenNo <> 0 then //Zero group num used for non-capturing group (?: bebebe )
    begin
      parno := FSubexpCount;
      SetSubExpCountLow(FSubexpCount + 1);
      ret := EmitNode(TLMDREOp(Ord(Open) + parno));
    end
    else
      ret := EmitNode(TLMDREOp(Ord(Open)));
  end
  else
    ret := nil;

  // Pick up the branches, linking them together.
  br := ParseBranch(flags);
  if br = nil then
  begin
    Result := nil;
    EXIT;
  end;

  if ret <> nil then
    Tail(ret, br) // OPEN -> first.
  else
    ret := br;

  if (flags and HASWIDTH) = 0 then
    AFlagp := AFlagp and not HASWIDTH;

  AFlagp := AFlagp or flags and SPSTART;

  while (FParse < FParseEnd) and (FExpr[FParse] = '|') do
  begin
    AdvanceParse;
    br := ParseBranch(flags);
    if br = nil then
    begin
      Result := nil;
      EXIT;
    end;

    Tail(ret, br); // BRANCH -> BRANCH.
    if (flags and HASWIDTH) = 0 then
      AFlagp := AFlagp and not HASWIDTH;

    AFlagp := AFlagp or flags and SPSTART;
  end;

  // Make a closing node, and hook it on the end.
  if AParenNo <> -1 then
  begin
    if AParenNo <> 0 then  //Zero group num used for non-capturing group (?: bebebe )
      ender := EmitNode(TLMDREOp(Ord(Close) + parno))
    else
      ender := EmitNode(TLMDREOp(Ord(Close)));
  end
  else
    ender := EmitNode(EEND);

  Tail(ret, ender);

  // Hook the tails of the branches to the closing node.
  br := ret;
  while br <> nil do
  begin
    OpTail(br, ender);
    br := br.NextOp;
  end;

  // Check for proper termination.
  if AParenNo <> -1 then
  begin
    if (FParse >= FParseEnd) or (FExpr[FParse] <> ')') then
      Error(reeCompParseRegUnmatchedBrackets)
    else
      AdvanceParse; // skip trailing ')'
  end;

  if (AParenNo = -1) and (FParse < FParseEnd) then
  begin
    if (FParse < FParseEnd) and (FExpr[FParse] = ')') then
      Error(reeCompParseRegUnmatchedBrackets2)
    else
      Error(reeCompParseRegJunkOnEnd);
  end;

  FCompModifiers := SavedModifiers; // restore modifiers of parent
  Result := ret;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.ParseBranch(var AFlagp: Integer): TLMDRegexNode;
  // one alternative of an | operator
  // Implements the concatenation operator.
var
  ret, chain, latest: TLMDRegexNode;
  flags: Integer;
begin
  AFlagp := WORST; // Tentatively.

  ret   := EmitNode(BRANCH);
  chain := nil;
  while (FParse < FParseEnd) and
        (FExpr[FParse] <> '|') and
        (FExpr[FParse] <> ')') do
  begin
    latest := ParsePiece(flags);

    if latest = nil then
    begin
      Result := nil;
      EXIT;
    end;

    AFlagp := AFlagp or flags and HASWIDTH;

    if chain = nil then // First piece.
      AFlagp := AFlagp or flags and SPSTART
    else if (chain <> latest) then
      Tail(chain, latest);

    chain := latest;
  end;

  if chain = nil then
    EmitNode(NOTHING);

  Result := ret;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.ParsePiece(var AFlagp: Integer): TLMDRegexNode;
var
  op, opNext, rp: TLMDChar;
  NonGreedyOp, NonGreedyCh: Boolean;
  TheOp:    TLMDREOp;
  NextNode: TLMDRegexNode;
  flags:    Integer;
  BracesMin, Bracesmax: Integer;
  p, savedparse, NextP: Integer;

  procedure EmitComplexBraces(ABracesMin, ABracesMax: Integer; ANonGreedyOp: Boolean);
  begin
    if ANonGreedyOp then
      TheOp := LOOPNG
    else
      TheOp := LOOP;

    if Result.Op=LOOKAHEAD then
      Error(reeComplexBracesNotImplementedForLookahead);

    InsertOperator(LOOPENTRY, Result);
    //Was:  ..=>[Atom]=>.. (Result=Atom)
    //Now:  ..=>[LOOPENTRY]=>[Atom]=>... (Result=Braces)

    NextNode := EmitNode(TheOp);
    NextNode.MinBrace := ABracesMin;
    NextNode.MaxBrace := ABracesMax;
    NextNode.LoopTo := Result.NextNode; // back to Atom after LOOPENTRY

    Tail(Result, NextNode); // LOOPENTRY -> LOOP
    Tail(Result.NextNode, NextNode); // Atom -> LOOP
  end;

  procedure EmitSimpleBraces(ABracesMin, ABracesMax: Integer; ANonGreedyOp: Boolean);
  begin
    if ANonGreedyOp then
      TheOp := BRACESNG
    else
      TheOp := BRACES;

    InsertOperator(TheOp, Result);
    //Was:  ..=>[Atom]=>.. (Result=Atom)
    //Now:  ..=>[Braces]=>[Atom]=>... (Result=Braces)

    Result.MinBrace := ABracesMin;
    Result.MaxBrace := ABracesMax;
  end;

begin
  Result := ParseAtom(flags);
  if Result = nil then
    EXIT;

  if FParse < FParseEnd then
    op := FExpr[FParse]
  else
    op := #0;

  NextP := NextParse;
  if NextP < FParseEnd then
    opNext := FExpr[NextP]
  else
    opNext := #0;

  if not ((op = '*') or (op = '+') or (op = '?') or (op = '{')) then
  begin
    AFlagp := flags;
    EXIT;
  end;

  if ((flags and HASWIDTH) = 0) and (op <> '?') then
    Error(reePlusStarOperandCouldBeEmpty);

  NonGreedyCh := opNext = '?';
  NonGreedyOp := NonGreedyCh or (not CompModifier(MaskModG));

  case op of
    '*':
    begin
      AFlagp      := WORST or SPSTART;

      if (flags and SIMPLE) = 0 then
      begin
        if NonGreedyOp then
          EmitComplexBraces(0, MaxBracesArg, NonGreedyOp)
        else
        begin // Emit x* as (x&|), where & means "self".
          InsertOperator(BRANCH, Result);  // Either x
          OpTail(Result, EmitNode(BACK)); // and loop
          OpTail(Result, Result);          // back
          Tail(Result, EmitNode(BRANCH)); // or
          Tail(Result, EmitNode(NOTHING));// nil.
        end;
      end
      else
      begin // Simple
        if NonGreedyOp then
          TheOp := STARNG
        else
          TheOp := STAR;

        InsertOperator(TheOp, Result);
      end;

      if NonGreedyCh then
        Inc(FParse); // Skip extra char ('?')
    end; { of case '*'}

    '+':
    begin
      AFlagp      := WORST or SPSTART or HASWIDTH;

      if (flags and SIMPLE) = 0 then
      begin
        if NonGreedyOp then
          EmitComplexBraces(1, MaxBracesArg, NonGreedyOp)
        else
        begin // Emit x+ as x(&|), where & means "self".
          NextNode := EmitNode(BRANCH);      // Either
          Tail(Result, NextNode);
          Tail(EmitNode(BACK), Result);     // loop back
          Tail(NextNode, EmitNode(BRANCH)); // or
          Tail(Result, EmitNode(NOTHING));  // nil.
        end;
      end
      else
      begin // Simple
        if NonGreedyOp then
          TheOp := PLUSNG
        else
          TheOp := PLUS;

        InsertOperator(TheOp, Result);
      end;

      if NonGreedyCh then // Skip extra char ('?')
        Inc(FParse);
    end; { of case '+'}
    '?':
    begin
      AFlagp      := WORST;

      if NonGreedyOp then // We emit x?? as x{0,1}?
      begin
        if (flags and SIMPLE) = 0 then
          EmitComplexBraces(0, 1, NonGreedyOp)
        else
          EmitSimpleBraces(0, 1, NonGreedyOp);
      end
      else
      begin // greedy '?'
        InsertOperator(BRANCH, Result); // Either x
        Tail(Result, EmitNode(BRANCH));  // or
        NextNode := EmitNode(NOTHING); // nil.
        Tail(Result, NextNode);
        OpTail(Result, NextNode);
      end;
      if NonGreedyCh then
        Inc(FParse); // Skip extra char ('?')
    end; { of case '?'}
    '{':
    begin
      savedparse := FParse;
      Inc(FParse);
      p := FParse;
      while (FParse < FParseEnd) and (FExpr[FParse]>='0') and (FExpr[FParse]<='9') do  // <min> MUST appear
        Inc(FParse);

      if FParse < FParseEnd then
        rp := FExpr[FParse]
      else
        rp := #0;

      if (p = FParse) or ((rp <> '}') and (rp <> ',')) then
      begin
        FParse := savedparse;
        AFlagp := flags;

        Error(reeBracesNotBalanced);
      end;

      BracesMin := ParseNumExpr(p, FParse - 1);

      if rp = ',' then
      begin
        Inc(FParse);
        p := FParse;

        while (FParse < FParseEnd) and (FExpr[FParse]>='0') and (FExpr[FParse]<='9') do
          Inc(FParse);

        if FParse < FParseEnd then
          rp := FExpr[FParse]
        else
          rp := #0;

        if rp <> '}' then
        begin
          FParse := savedparse;
          AFlagp := flags;

          Error(reeBracesNotBalanced);
        end;

        if p = FParse then
          BracesMax := MaxBracesArg
        else
          BracesMax := ParseNumExpr(p, FParse - 1);
      end
      else
        BracesMax := BracesMin; // {n} == {n,n}

      if BracesMin > BracesMax then
        Error(reeBracesMinParamGreaterMax);

      if BracesMin > 0 then
        AFlagp := WORST;

      if BracesMax > 0 then
        AFlagp := AFlagp or HASWIDTH or SPSTART;

      NextP := NextParse;
      NonGreedyCh := (NextP < FParseEnd) and (FExpr[NextP] = '?');
      NonGreedyOp := NonGreedyCh or (not CompModifier(MaskModG));

      if (flags and SIMPLE) <> 0 then
        EmitSimpleBraces(BracesMin, BracesMax, NonGreedyOp)
      else
        EmitComplexBraces(BracesMin, BracesMax, NonGreedyOp);

      if NonGreedyCh then
        Inc(FParse); // Skip extra char '?'

    end; { of case '{'}
    else
      Error(reeInternalUrp); // here we can't be
  end; { of case op}

  AdvanceParse;

  if FParse < FParseEnd then
    rp := FExpr[FParse]
  else
    rp := #0;

  if (rp = '*') or (rp = '+') or (rp = '?') or (rp = '{') then
    Error(reeNestedSQP);
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.NextParseEx(ParseIdx: Integer): Integer;
begin
  Result := ParseIdx + 1;

  if CompModifier(MaskModX) or CompModifier(MaskModC) then
    while (Result < FParseEnd) and (FIgnoredChars.Contains(FExpr[Result])) do
        Inc(Result);
end;

function TLMDRegExp.NextParse: Integer;
begin
  Result := NextParseEx(FParse);
end;

procedure TLMDRegExp.AdvanceParse;
begin
  FParse := NextParse;
end;

procedure TLMDRegExp.AdvanceParseEx(var ParseIdx: Integer);
begin
  ParseIdx := NextParseEx(ParseIdx);
end;

function TLMDRegExp.ParseAtom(var AFlagp: Integer): TLMDRegexNode;
  // the lowest level
  // Optimization:  gobbles an entire sequence of ordinary characters so that
  // it can turn them into a single node, which is smaller to store and
  // faster to run.  Backslashed characters are exceptions, each becoming a
  // separate node; the code is simpler that way and it's not worth fixing.
var
  ret:      TLMDRegexNode;
  flags:    Integer;
  RangeBeg, RangeEnd: Integer;
  CanBeRange: Boolean;
  len:      Integer;
  begmodfs: Integer;

  RangeIsCI:    Boolean;
  RangeLen:     Integer;
  RangeTinySet: TLMDIntArray;

  function EmitExactly(const AStr: TLMDIntArray): TLMDRegexNode; overload;
  var
    i:   Integer;
    Op:  TLMDREOp;
    Inv: TLMDIntArray;
  begin
    SetLength(Inv, 0);

    if CompModifier(MaskModI) then
    begin
      Op := EXACTLYCI;

      SetLength(Inv, Length(AStr));
      for i := 0 to Length(AStr)-1 do
        Inv[i] := InvertCase(AStr[i]);
    end
    else
      Op := EXACTLY;

    ret := EmitNode(Op);

    ret.ExactStr     := AStr;
    ret.ExactStrInvC := Inv;

    ret.ExactChar     := ret.ExactStr[0];
    if Length(ret.ExactStrInvC)>0 then
      ret.ExactCharInvC := ret.ExactStrInvC[0];

    AFlagp := AFlagp or HASWIDTH or SIMPLE;

    Result := ret;
  end;

  function EmitExactly(const AChar: Integer): TLMDRegexNode; overload;
  var Arr: TLMDIntArray;
  begin
    SetLength(Arr, 1);
    Arr[0] := AChar;

    result := EmitExactly(Arr);
  end;

  function EmitRange(AOpCode: TLMDREOp): TLMDRegexNode;
  begin
    case AOpCode of
      ANYBUTCI, ANYBUT:
        Result := EmitNode(ANYBUTTINYSET);
      else // ANYOFCI, ANYOF
        Result := EmitNode(ANYOFTINYSET);
    end;

    case AOpCode of
      ANYBUTCI, ANYOFCI:
        RangeIsCI := True;
      else // ANYBUT, ANYOF
        RangeIsCI := False;
    end;

    RangeBeg := -1;
    RangeEnd := -1;

    RangeLen := 0;
    FRangeSet.Clear;
    SetLength(RangeTinySet, 0);
  end;

  procedure EmitRangeCPrim(b: Integer);
  var L: Integer;
  begin
    if FRangeSet.Contains(b) then
      EXIT;

    FRangeSet.IncludeChar(b);

    if RangeLen <= TinySetLen then
    begin
      Inc(RangeLen);

      L := Length(RangeTinySet);
      SetLength(RangeTinySet, L+1);
      RangeTinySet[L] := b;
    end;
  end;

  procedure EmitRangeC(b: Integer);
  var
    i, L: Integer;
  begin
    CanBeRange := False;
    if b <> -1 then
    begin
      EmitRangeCPrim(b);
      if RangeIsCI then
        EmitRangeCPrim(InvertCase(b));
    end
    else
    begin
      // impossible, but who knows..
      Assert(RangeLen > 0, 'TRegExpr.ParseAtom(subroutine EmitRangeC): empty range');

      if RangeLen <= TinySetLen then
      begin
        // emit "tiny set"
        L := Length(RangeTinySet);
        FProgrammLast.TinySet := Copy(RangeTinySet, 0, L);
        SetLength(FProgrammLast.TinySet, TinySetLen);

        for i := L to TinySetLen-1 do
          if L>0 then
            FProgrammLast.TinySet[i] := RangeTinySet[L-1]
          else
            FProgrammLast.TinySet[i] := -1;
      end
      else
      begin
        if FProgrammLast.Op = ANYBUTTINYSET then
          FRangeSet.Invert;
        FProgrammLast.Op := ANYOFFULLSET;
        FProgrammLast.SetHash.Assign(FRangeSet);
      end;
    end;
  end;

  procedure EmitSimpleRangeC(b: Integer);
  begin
    RangeBeg := b;
    EmitRangeC(b);
    CanBeRange := True;
  end;

  procedure EmitWordChars;
  begin
    AddWordSet(FRangeSet);
    RangeLen := MaxInt;
  end;

  procedure EmitSpaceChars;
  begin
    AddSpaceSet(FRangeSet);
    RangeLen := MaxInt;
  end;

  procedure EmitNumberChars;
  begin
    AddDigitsSet(FRangeSet);
    RangeLen := MaxInt;
  end;

  procedure EmitRangeMinMax(AMin, AMax: Integer);
  begin
    FRangeSet.IncludeRange(AMin, AMax);
    RangeLen := MaxInt;
  end;

  procedure EmitRangeCats(ACats: TLMDUnicodeCategories);
  begin
    FRangeSet.IncludeCats(ACats);
    RangeLen := MaxInt;
  end;

  function strcspn(const s1: TLMDString; s1Start: Integer; const s2: TLMDString): Integer;
    // find length of initial segment of s1 consisting
    // entirely of characters not from s2
  var
    scan1, scan2, Ln1, Ln2: Integer;
  begin
    Result := 0;
    scan1  := s1Start;
    Ln2    := Length(s2);
    Ln1    := Length(s1);
    while scan1 <= Ln1 do
    begin
      scan2 := 1;
      while scan2 <= Ln2 do
        if s1[scan1] = s2[scan2] then
          exit
        else
          Inc(scan2);

      Inc(Result);
      Inc(scan1);
    end;
  end;

  function UnQuoteInt(var AIdx: Integer;
                      const AStr: TLMDString;
                      AStrEnd: Integer): Integer;
  begin
    CheckNotInCodesMode('Some escaped symbol \...');
    Result := Ord(UnQuoteChar(AIdx, AStr, AStrEnd));
  end;

var
{$IFDEF LMD_UNICODE}
  OldParse: Integer;
{$ENDIF}
  BackRef, NextP, Code, L: Integer;
  Exact:   TLMDIntArray;
  Cats: TLMDUnicodeCategories;
  op: TLMDChar;
  LookAh, NoCap: Boolean;
begin
  AFlagp := WORST; // Tentatively.

  FRangeSet.Clear;

  Assert(FParse < FParseEnd);
  op := FExpr[FParse];
  Inc(FParse);

  case op of
    '^':
      if (not CompModifier(MaskModM)) or
         (CompModifier(MaskModC)) or
         ((FLineSeparators = '') and not FLinePairedSeparatorAssigned)
      then
        ret := EmitNode(BOL)
      else
        ret := EmitNode(BOLML);

    '$':
    begin
      if FParse<FParseEnd then
        Code := StrToIntDef(FExpr[FParse], -1)
      else
        Code := -1;

      if CompModifier(MaskModX) and ((Code>=0) and (Code<=9))//External variable syntax
      then
      begin
        ret := EmitExactly(0);
        ret.ExactVarId := Code;

        FVariablesList.Add(ret);
        Inc(FParse);
      end
      else if (not CompModifier(MaskModM)) or
              (CompModifier(MaskModC)) or
              ((FLineSeparators = '') and
                not FLinePairedSeparatorAssigned)
      then
        ret := EmitNode(EOL)
      else
        ret := EmitNode(EOLML);
    end;

    '.':
      if CompModifier(MaskModS) or CompModifier(MaskModC) then
      begin
        ret    := EmitNode(ANY);
        AFlagp := AFlagp or HASWIDTH or SIMPLE;
      end
      else
      begin // not /s, so emit [^:LineSeparators:]
        ret    := EmitNode(ANYML);
        AFlagp := AFlagp or HASWIDTH; // not so simple ;)
      end;

    '[':
    begin
      if (FParse < FParseEnd) and (FExpr[FParse] = '^') then // Complement of range.
      begin
        if CompModifier(MaskModI) then
          ret := EmitRange(ANYBUTCI)
        else
          ret := EmitRange(ANYBUT);

        Inc(FParse);
      end
      else if CompModifier(MaskModI) then
        ret := EmitRange(ANYOFCI)
      else
        ret := EmitRange(ANYOF);

      CanBeRange := False;

      if (FParse < FParseEnd) and (FExpr[FParse] = ']') then
      begin
        CheckNotInCodesMode('Range special case: []-a] -> '']'' .. ''a''');
        EmitSimpleRangeC(Ord(FExpr[FParse])); // []-a] -> ']' .. 'a'
        Inc(FParse);
      end;

      Dec(FParse);
      AdvanceParse;

      while (FParse < FParseEnd) and (FExpr[FParse] <> ']') do
      begin
        NextP := NextParse;
        if (FExpr[FParse] = '-') and
           (NextP < FParseEnd)   and
           (FExpr[NextP] <> ']') and
           CanBeRange
        then
        begin //process range end
          FParse := NextP;

          RangeEnd := Ord(FExpr[FParse]);
          if RangeEnd = Ord(EscChar) then
          begin
            NextP := NextParse;

            if (NextP < FParseEnd) and
               (Pos(FExpr[NextP], 'dDsSwWpP') > 0) //sets cat't be range ends
            then
            begin
              CheckNotInCodesMode('Ranges special case: [a - \s] or [a - \w] etc.');
              EmitRangeC(Ord('-')); // or treat as error ?!!
              CONTINUE;
            end;
            Inc(FParse);

            RangeEnd := UnQuoteInt(FParse, FExpr, FParseEnd);
          end
          else if CompModifier(MaskModC) then
            RangeEnd := ParseIntCode(FParse, FExpr);

          // standard r.e. handling
          if RangeBeg > RangeEnd then
            Error(reeInvalidRange);

          EmitRangeMinMax(RangeBeg, RangeEnd);
          AdvanceParse;
        end
        else
        begin
          CanBeRange := false;

          if FExpr[FParse] = EscChar then
          begin
            Inc(FParse);
            if FParse >= FParseEnd then
              Error(reeParseAtomTrailingBackSlash);

            case FExpr[FParse] of // r.e.extensions
              'd':
              begin
                CheckNotInCodesMode('Range member: \d');
                EmitNumberChars;
              end;
              'w':
              begin
                CheckNotInCodesMode('Range member: \w');
                EmitWordChars;
              end;

              's':
              begin
                CheckNotInCodesMode('Range member: \s');
                EmitSpaceChars;
              end;

              'P', 'p':
              begin
                CheckNotInCodesMode('Range member: unicode category: \P{..} or \p{..}');

                {$IFDEF LMD_UNICODE}
                OldParse := FParse;
                {$ENDIF}
                if TryParseUnicodeCat(FParse, Cats, FExpr) then
                begin
                {$IFDEF LMD_UNICODE}
                  if FExpr[OldParse]='P' then
                    Cats := FullUnicodeCatSet - Cats;

                  EmitRangeCats(Cats);
                {$ELSE}
                  Error(reeUnicodeCategoriesNotSupportedInAnsi);
                {$ENDIF}
                end
                else
                  EmitSimpleRangeC(Ord(UnQuoteChar(FParse, FExpr, FParseEnd)));
              end;

              'S', 'D', 'W':
              begin
                CheckNotInCodesMode('Range member: \S or D or \W');
                Error(reeNegativeSetNotSupportedInRanges);
              end

              else
                EmitSimpleRangeC(UnQuoteInt(FParse, FExpr, FParseEnd));
            end; { of case}
          end
          else
          begin
            if CompModifier(MaskModC) then
              EmitSimpleRangeC(ParseIntCode(FParse, FExpr))
            else
              EmitSimpleRangeC(Ord(FExpr[FParse]));
          end;
          AdvanceParse;
        end;
      end; { of while}

      EmitRangeC(-1);
      if (FParse >= FParseEnd) or (FExpr[FParse] <> ']') then
        Error(reeUnmatchedSqBrackets);

      AdvanceParse;
      AFlagp := AFlagp or HASWIDTH or SIMPLE;
    end;

    '(':
    begin
      if ((FParse < FParseEnd-1) and
          (FExpr[FParse] = '?') and
          ((FExpr[FParse+1] = ':') or (FExpr[FParse+1] = '='))) or
         CompModifier(MaskModNonCap)
      then //This is non-captured or lookahead group
      begin
        FCompModifiers := FCompModifiers or MaskModNonCap;
        LookAh := (FParse < FParseEnd-1) and (FExpr[FParse+1] = '=');
        NoCap :=  (FParse < FParseEnd-1) and (FExpr[FParse+1] = ':');

        if LookAh or NoCap then
          Inc(FParse, 2);

        ret := ParseReg(0, flags);//lookahead group is non-capturing too

        if ret = nil then
        begin
          Result := nil;
          EXIT;
        end;

        if LookAh then
        begin
          InsertOperator(LOOKAHEAD, ret);
          //Was:  ..=>[Atom]=>.. (Result=Atom)
          //Now:  ..=>[LOOKAHEAD]=>[Atom]=>... (Result=Braces)

        end;
        AFlagp := AFlagp or flags and (HASWIDTH or SPSTART);
      end
      else if (FParse < FParseEnd) and (FExpr[FParse] = '?') then
      begin
        //check for extended Perl syntax : (?..)
        if (FParse + 1 < FParseEnd) and (FExpr[FParse + 1] = '#') then // (?#comment)
        begin
          Inc(FParse, 2); // find closing ')'

          while (FParse < FParseEnd) and (FExpr[FParse] <> ')') do
            Inc(FParse);

          if FParse >= FParseEnd then
            Error(reeUnclosedComment);

          AdvanceParse; // skip ')'
          ret := EmitNode(COMMENT); // comment
        end
        else
        begin // modifiers ?
          Inc(FParse); // skip '?'
          begmodfs := FParse;

          while (FParse < FParseEnd) and (FExpr[FParse] <> ')') do
            Inc(FParse);

          if (FParse >= FParseEnd) or
             (not ParseModifiersStr(FExpr, begmodfs, FParse - 1, FCompModifiers))
          then
            Error(reeUrecognizedModifier);

          AdvanceParse; // skip ')'
          ret := EmitNode(COMMENT); // comment
        end;
      end
      else
      begin
        ret := ParseReg(1, flags);
        if ret = nil then
        begin
          Result := nil;
          EXIT;
        end;
        AFlagp := AFlagp or flags and (HASWIDTH or SPSTART);
      end;
    end;

    #0, '|', ')': // Supposed to be caught earlier.
    begin
      Error(reeInternalUrp);
    end;

    '?', '+', '*':
    begin
      Error(reeQPSBFollowsNothing);
    end;

    EscChar:
    begin
      if FParse >= FParseEnd then
        Error(reeTrailingBackSlash);

      case FExpr[FParse] of // r.e.extensions
        'b':
        begin
          CheckNotInCodesMode('\b');
          ret := EmitNode(BOUND);
        end;
        'B':
        begin
          CheckNotInCodesMode('\B');
          ret := EmitNode(NOTBOUND);
        end;

        'A': ret := EmitNode(BOL);
        'Z': ret := EmitNode(EOL);

        'd':
        begin // r.e.extension - any digit ('0' .. '9')
          CheckNotInCodesMode('Anydigit: \d');
          ret    := EmitNode(ANYDIGIT);
          AFlagp := AFlagp or HASWIDTH or SIMPLE;
        end;

        'D':
        begin // r.e.extension - not digit ('0' .. '9')
          CheckNotInCodesMode('Notdigit: \d');
          ret    := EmitNode(NOTDIGIT);
          AFlagp := AFlagp or HASWIDTH or SIMPLE;
        end;

        's':
        begin // r.e.extension - any space char
          CheckNotInCodesMode('Anyspace: \s');
          ret := EmitRange(ANYOF);
          EmitSpaceChars;
          EmitRangeC(-1);
          AFlagp := AFlagp or HASWIDTH or SIMPLE;
        end;

        'S':
        begin // r.e.extension - not space char
          CheckNotInCodesMode('Notspace: \d');
          ret := EmitRange(ANYBUT);
          EmitSpaceChars;
          EmitRangeC(-1);
          AFlagp := AFlagp or HASWIDTH or SIMPLE;
        end;

        'w':
        begin // r.e.extension - any english char / digit / '_'
          CheckNotInCodesMode('Word symbol: \w');
          ret := EmitRange(ANYOF);
          EmitWordChars;
          EmitRangeC(-1);
          AFlagp := AFlagp or HASWIDTH or SIMPLE;
        end;

        'W':
        begin // r.e.extension - not english char / digit / '_'
          CheckNotInCodesMode('Non-word symbol: \W');
          ret := EmitRange(ANYBUT);
          EmitWordChars;
          EmitRangeC(-1);
          AFlagp := AFlagp or HASWIDTH or SIMPLE;
        end;

        'p', 'P':
        begin
        {$IFDEF LMD_UNICODE}
          OldParse := FParse;

          CheckNotInCodesMode('Unicode category: \p or \P');

          if TryParseUnicodeCat(FParse, Cats, FExpr) then
          begin
            ret := EmitRange(ANYOF);

            if FExpr[OldParse]='P' then
              Cats := FullUnicodeCatSet - Cats;

            EmitRangeCats(Cats);
            EmitRangeC(-1);
            AFlagp := AFlagp or HASWIDTH or SIMPLE;
          end
          else
            ret := EmitExactly(UnQuoteInt(FParse, FExpr, FParseEnd));

        {$ELSE}
          Error(reeUnicodeCategoriesNotSupportedInAnsi);
        {$ENDIF}

        end
        else
        begin
          if (FExpr[FParse] >= '0') and (FExpr[FParse] <= '9') then
          begin
            NextP := FParse;
            while (FExpr[NextP] >= '0') and (FExpr[NextP] <= '9') do
              Inc(NextP);

            BackRef := ParseNumExpr(FParse, NextP-1);
            if CompModifier(MaskModI) then
              ret := EmitNode(BSUBEXPCI)
            else
              ret := EmitNode(BSUBEXP);

            ret.BackRef := BackRef;
            AFlagp      := AFlagp or HASWIDTH or SIMPLE;
          end
          else
          begin
            Code := UnQuoteInt(FParse, FExpr, FParseEnd);
            ret := EmitExactly(Code);
          end;
        end
      end; { of case}
      AdvanceParse;
    end;
    else
    begin
      Dec(FParse);
      if CompModifier(MaskModX) and // check for eXtended syntax
        ((FExpr[FParse] = '#') or FIgnoredChars.Contains(FExpr[FParse])) then
      begin //\x
        if FExpr[FParse] = '#' then
        begin // Skip eXtended comment

          // find comment terminator (group of \n and/or \r)
          while (FParse < FParseEnd) and
                (not FLineSeparatorsSet.Contains(FExpr[FParse]))
          do
            Inc(FParse);

          // skip comment terminator
          while (FParse < FParseEnd) and
                FLineSeparatorsSet.Contains(FExpr[FParse])
          do
            Inc(FParse); // attempt to support different type of line separators
        end
        else
        begin // Skip the blanks!
          while (FParse < FParseEnd) and
                FIgnoredChars.Contains(FExpr[FParse])
          do
            Inc(FParse);
        end;
        ret := EmitNode(COMMENT); // comment
      end
      else
      begin
        len := strcspn(FExpr, FParse, META);
        if len <= 0 then
        begin
          if FExpr[FParse] <> '{' then
            Error(reeRarseAtomInternalDisaster)
          else
            len := strcspn(FExpr, FParse+1, META) + 1; // bad {n,m} - compile as EXATLY
        end;

        if (FParse+len) < FParseEnd then // Back off clear of ?+*{ operand.
        begin
          if (len > 1) and
             (Pos(FExpr[FParse+len], QUANTIFIERS_BEG)>0)
          then
            Dec(len);
        end;

        AFlagp := AFlagp or HASWIDTH;

        if len = 1 then
          AFlagp := AFlagp or SIMPLE;

        if CompModifier(MaskModC) then
        begin
          SetLength(Exact, 1);
          Exact[0] := ParseIntCode(FParse, FExpr);
          AdvanceParse;
        end
        else
        begin
          SetLength(Exact, 0);

          while (len > 0) and
                ((not CompModifier(MaskModX)) or
                 (FExpr[FParse] <> '#'))
          do
          begin
            if (not CompModifier(MaskModX)) or
               (not FIgnoredChars.Contains(FExpr[FParse]))
            then
            begin
              L := Length(Exact);
              SetLength(Exact, L+1);
              Exact[L] := Ord(FExpr[FParse]);
            end;

            Inc(FParse);
            Dec(len);
          end;
        end;

        ret := EmitExactly(Exact);
      end; { of if not comment}
    end;   { of case else}
  end; { of case}

  Result := ret;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.GetCompilerErrorPos: Integer;
begin
  Result := FParse;
end;

{ ---------------------------------------------------------------------------- }

 {=============================================================}
 {===================== Matching section ======================}
 {=============================================================}

procedure TLMDRegExp.PrepareVarsOpts;

  function FindFirstNoaltAtom(Node: TLMDRegexNode): TLMDRegexNode;
  var
    NextOp: TLMDRegexNode;
  begin
    Result := nil;

    NextOp := Node.NextOp;

    case Node.Op of
      BRANCH:
      begin
        Assert(NextOp <> nil);

        //this branch does not lead to some alternative
        if (NextOp.Op <> BRANCH) and (NextOp.Op <> NOTHING) then
          Result := FindFirstNoaltAtom(Node.NextNode);
      end;

      LOOPENTRY: //'Complex braces'
      begin
        Assert((NextOp.Op = LOOP) or (NextOp.Op = LOOPNG));

        if NextOp.MinBrace > 0 then
          Result := FindFirstNoaltAtom(NextOp.LoopTo);
      end;

      LOOKAHEAD:
      begin
        Result := FindFirstNoaltAtom(Node.NextNode);
      end;

      Open .. TLMDREOp(Ord(Open) + NSUBEXP - 1):
      begin
        Result := FindFirstNoaltAtom(NextOp);
      end;

      Close .. TLMDREOp(Ord(Close) + NSUBEXP - 1):
      begin
        Assert(False);
      end;

      BRACES, BRACESNG: //simple braces
        if Node.MinBrace > 0 then
          Result := FindFirstNoaltAtom(Node.NextNode);

      PLUS, PLUSNG: //simple braces
        Result := FindFirstNoaltAtom(Node.NextNode)

      else
        Result := Node
    end;
  end;

  procedure PrepareFirstNode;
  var
    scan, longestExact: TLMDRegexNode;
    len:   Integer;
  begin
    FRegStart := nil; // Worst-case defaults.
    FRegAnch := False;
    FRegmustExact := nil;
    scan := FProgrammFirst; // First BRANCH.
    Assert(FProgrammFirst<>nil);

    if (scan.NextOp <> nil) and (scan.NextOp.Op = EEND) then
    begin // Only one top-level choice.

      // If there's something expensive in the r.e., find the longest
      // literal string that must appear and make it the regmust.  Resolve
      // ties in favor of later strings, since the regstart check works
      // with the beginning of the r.e. and avoiding duplication
      // strengthens checking.  Not a strong reason, but sufficient in the
      // absence of others.
      if ((FCompiledFlags and SPSTART) <> 0) and (not ModifierA) then
      begin
        longestExact := nil;
        len  := 0;
        scan := scan.NextNode; // First BRANCH.

        while scan <> nil do
        begin
          if ((scan.Op = EXACTLY) or (scan.Op = EXACTLYCI)) and
             (Length(scan.ExactStr) >= len)
          then
          begin
            longestExact := scan;
            len := Length(longestExact.ExactStr);
          end;
          scan := scan.NextOp;
        end;

        FRegmustExact := longestExact;

        if FRegmustExact <> nil then
          FBMSearch.Prepare(FRegmustExact.ExactStr,
                            ModifierI or (FRegmustExact.Op = EXACTLYCI));
      end;

      // Starting-point info.
      FRegStart := FindFirstNoaltAtom(FProgrammFirst);
      if FRegStart <> nil then
      begin
        case FRegStart.Op of
          EXACTLY, EXACTLYCI:
            FBMSearch.Prepare(FRegStart.ExactStr,
                              ModifierI or (FRegStart.Op = EXACTLYCI));

          BOL:
          begin
            FRegAnch  := True;
            FRegStart := nil;
          end;

          ANYDIGIT, NOTDIGIT, ANYOFTINYSET, ANYBUTTINYSET, ANYOFFULLSET: ;

          else
            FRegStart := nil
        end;
      end;
    end;
  end;

  procedure PrepareVars;
  var i, j: Integer; N: TLMDRegexNode;
  begin
    for i:=0 to FVariablesList.Count-1 do
    begin
      N := TLMDRegexNode(FVariablesList[i]);

      if Assigned(FVarGetter) then
        FVarGetter(N.ExactVarId, N.ExactStr)
      else
        SetLength(N.ExactStr, 0);

      SetLength(N.ExactStrInvC, Length(N.ExactStr));

      for j:=0 to Length(N.ExactStr)-1 do
        N.ExactStrInvC[j] := InvertCase(N.ExactStr[j]);

      if Length(N.ExactStr)>0 then
      begin
        N.ExactChar := N.ExactStr[0];
        N.ExactCharInvC := N.ExactStrInvC[0];
      end
      else
      begin
        N.ExactChar := -1;
        N.ExactCharInvC := -1;
      end;
    end;
  end;

  procedure PrepareFirstCharSet(AStartNode: TLMDRegexNode);
  var
    scan:    TLMDRegexNode; // Current node.
    Next:    TLMDRegexNode; // Next node.
    opnd:    TLMDRegexNode;
    min_cnt, i: Integer;
  begin
    scan := AStartNode;
    while scan <> nil do
    begin
      Next := scan.NextOp;
      case scan.Op of
        BSUBEXP, BSUBEXPCI:
        begin
          FFirstCharSet := FullAnsiCharSet; // :((( we cannot
                                            // optimize r.e. if it starts
                                            // with back reference
          FFirstCharSetHasUnicode := true;

          EXIT;
        end;

        BOL, BOLML: ;

        EOL, EOLML:
        begin
          Include(FFirstCharSet, 0);

          FFirstCharSet := FFirstCharSet + FLineSeparatorsSet.AnsiSet;
          FFirstCharSetHasUnicode :=
              FFirstCharSetHasUnicode or (not FLineSeparatorsSet.IsAnsiSet);

          EXIT;
        end;

        BOUND, NOTBOUND: ;

        ANY, ANYML: // we can better define ANYML !!!
        begin
          FFirstCharSet := FullAnsiCharSet;
          FFirstCharSetHasUnicode := true;
          EXIT;
        end;

        ANYDIGIT:
        begin
          FFirstCharSet := FFirstCharSet + fDigitsSet.AnsiSet;
          FFirstCharSetHasUnicode := FFirstCharSetHasUnicode or
                                     (not fDigitsSet.IsAnsiSet);

          EXIT;
        end;

        NOTDIGIT:
        begin
          FFirstCharSet := FFirstCharSet +
                           (FullAnsiCharSet - FDigitsSet.AnsiSet);
          FFirstCharSetHasUnicode := FFirstCharSetHasUnicode or
                                     (not fDigitsSet.IsAnsiSet);

          EXIT;
        end;

        EXACTLYCI:
        begin
          if Ord(scan.ExactChar)<=High(Byte) then
            Include(FFirstCharSet, Ord(scan.ExactChar))
          else
            FFirstCharSetHasUnicode := true;

          if Ord(scan.ExactCharInvC)<=High(Byte) then
            Include(FFirstCharSet, Ord(scan.ExactCharInvC))
          else
            FFirstCharSetHasUnicode := true;

          EXIT;
        end;

        EXACTLY:
        begin
          if Ord(scan.ExactChar)<=High(Byte) then
            Include(FFirstCharSet, Ord(scan.ExactChar))
          else
            FFirstCharSetHasUnicode := true;

          EXIT;
        end;

        ANYOFFULLSET:
        begin
          if (not scan.SetHash.FInverted) or (scan.SetHash.IsAnsiSet) then
            FFirstCharSet := FFirstCharSet + scan.SetHash.AnsiSet
          else
            FFirstCharSet := FFirstCharSet +
                             (FullAnsiCharSet - scan.SetHash.AnsiSet);

          FFirstCharSetHasUnicode := FFirstCharSetHasUnicode or
                                     (not scan.SetHash.IsAnsiSet);

          EXIT;
        end;

        ANYOFTINYSET:
        begin
          //!!!TinySet
          for i := 0 to 2 do
            if Ord(scan.TinySet[i])<=High(Byte) then
              Include(FFirstCharSet, Ord(scan.TinySet[i]))
            else
              FFirstCharSetHasUnicode := true;
          // ...                                                      // up to TinySetLen
          EXIT;
        end;

        ANYBUTTINYSET:
        begin
          //!!!TinySet

          FFirstCharSetHasUnicode := true;
          FFirstCharSet := FullAnsiCharSet;

          for i := 0 to 2 do
            if Ord(scan.TinySet[i])<=High(Byte) then
              Exclude(FFirstCharSet, Ord(scan.TinySet[i]));
          // ...                                                     // up to TinySetLen
          EXIT;
        end;

        NOTHING: ;
        COMMENT: ;
        BACK: ;

        Open .. TLMDREOp(Ord(Open) + NSUBEXP - 1):
        begin
          PrepareFirstCharSet(Next);
          EXIT;
        end;

        Close .. TLMDREOp(Ord(Close) + NSUBEXP - 1):
        begin
          if Next<>nil then
            PrepareFirstCharSet(Next);
          EXIT;
        end;

        BRANCH:
        begin
          if (Next.Op <> BRANCH) then // No choice.
            Next := scan.NextNode // Avoid recursion.
          else
          begin
            repeat
              PrepareFirstCharSet(scan.NextNode);
              scan := scan.NextOp;
            until (scan = nil) or (scan.Op <> BRANCH);

            EXIT;
          end;
        end;

        LOOKAHEAD:
        begin
          PrepareFirstCharSet(scan.NextNode);
          EXIT;
        end;

        LOOPENTRY:
        begin
          PrepareFirstCharSet(Next); // execute LOOP
          EXIT;
        end;

        LOOP, LOOPNG:
        begin
          opnd    := scan.LoopTo;
          min_cnt := scan.MinBrace;
          PrepareFirstCharSet(opnd);

          if min_cnt = 0 then
            PrepareFirstCharSet(Next);

          EXIT;
        end;

        STAR, STARNG:
          PrepareFirstCharSet(scan.NextNode);

        PLUS, PLUSNG:
        begin
          PrepareFirstCharSet(scan.NextNode);
          EXIT;
        end;

        BRACES, BRACESNG:
        begin
          opnd    := scan.NextNode;
          min_cnt := scan.MinBrace; // BRACES
          PrepareFirstCharSet(opnd);
          if min_cnt > 0 then
            EXIT;
        end;

        EEND:
        begin
          FFirstCharSet := FullAnsiCharSet;
          EXIT;
        end;

        else
          Error(reeMatchPrimMemoryCorruption);
      end; { of case scan^}
      scan := Next;
    end; { of while scan <> nil}
  end;

begin
  if FVarsOptsOk then  //If variables got changed, remake optiomization info using it
    Exit;

  PrepareVars;
  PrepareFirstNode;

  FFirstCharSet := [];
  FFirstCharSetHasUnicode := true;
  PrepareFirstCharSet(FProgrammFirst);

  FVarsOptsOk := true;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.RegRepeat(ANode: TLMDRegexNode; AMax: Integer): Integer;
  // repeatedly match something simple, report how many

var
  scan:      Integer;
  TheMax:    Integer;
  Ch, InvCh: Integer;
  sestart, seend, opnd: Integer;
begin
  Result := 0;
  scan   := FReginput;
  TheMax := FInputEnd - scan;// eliminate (scan < fInputEnd) check

  if TheMax > AMax then
    TheMax := AMax;

  case ANode.Op of
    ANY:
    begin
      // note - ANYML cannot be proceeded in regrepeat because can skip
      // more than one char at once
      Result := TheMax;
      Inc(scan, Result);
    end;

    EXACTLY:
    begin // in opnd can be only ONE char
      Ch := ANode.ExactChar;

      while (Result < TheMax) and
        (Ch = FInput[scan]) do
      begin
        Inc(Result);
        Inc(scan);
      end;
    end;

    EXACTLYCI:
    begin // in opnd can be only ONE char
      Ch    := ANode.ExactChar;
      InvCh := ANode.ExactCharInvC;

      while (Result < TheMax) and
        ((Ch = FInput[scan]) or (InvCh = FInput[scan])) do
      begin
        Inc(Result);
        Inc(scan);
      end;
    end;
    BSUBEXP:
    begin
      sestart := FStartp[ANode.BackRef];

      if sestart = -1 then
        EXIT;

      seend := FEndp[ANode.BackRef];

      if seend = -1 then
        EXIT;

      repeat
        opnd := sestart;
        while opnd < seend do
        begin
          if (scan >= FInputEnd) or (FInput[scan] <> FInput[opnd]) then
            EXIT;

          Inc(scan);
          Inc(opnd);
        end;

        Inc(Result);
        FReginput := scan;
      until Result >= AMax;
    end;
    BSUBEXPCI:
    begin
      sestart := FStartp[ANode.BackRef];

      if sestart = -1 then
        EXIT;

      seend := FEndp[ANode.BackRef];

      if seend = -1 then
        EXIT;

      repeat
        opnd := sestart;

        while opnd < seend do
        begin
          if (scan >= FInputEnd) or
             ((FInput[scan] <> FInput[opnd]) and
              (FInput[scan] <> InvertCase(FInput[opnd])))
          then
            EXIT;
          Inc(scan);
          Inc(opnd);
        end;

        Inc(Result);
        FReginput := scan;
      until Result >= AMax;

    end;

    ANYDIGIT:
      if FDigitsSet.IsAnsiSet then
        while (Result < TheMax) and ((Ord(FInput[scan]) in FDigitsSet.AnsiSet)) do
        begin
          Inc(Result);
          Inc(scan);
        end
      else
        while (Result < TheMax) and FDigitsSet.Contains(FInput[scan]) do
        begin
          Inc(Result);
          Inc(scan);
        end;

    NOTDIGIT:
      if FDigitsSet.IsAnsiSet then
        while (Result < TheMax) and (not ((Ord(FInput[scan]) in FDigitsSet.AnsiSet))) do
        begin
          Inc(Result);
          Inc(scan);
        end
      else
        while (Result < TheMax) and (not FDigitsSet.Contains(FInput[scan])) do
        begin
          Inc(Result);
          Inc(scan);
        end;

    ANYOFTINYSET:
    begin
      while (Result < TheMax) and
        ((FInput[scan] = ANode.TinySet[0]) or
         (FInput[scan] = ANode.TinySet[1]) or
         (FInput[scan] = ANode.TinySet[2])) do
      begin
        Inc(Result);
        Inc(scan);
      end;
    end;

    ANYBUTTINYSET:
    begin
      while (Result < TheMax) and
        (FInput[scan] <> ANode.TinySet[0]) and
        (FInput[scan] <> ANode.TinySet[1]) and
        (FInput[scan] <> ANode.TinySet[2]) do
      begin
        Inc(Result);
        Inc(scan);
      end;
    end;

    ANYOFFULLSET:
    begin
      if ANode.SetHash.IsAnsiSet then
        while (Result < TheMax) and (Ord(FInput[scan]) in ANode.SetHash.AnsiSet) do
        begin
          Inc(Result);
          Inc(scan);
        end
      else
        while (Result < TheMax) and ANode.SetHash.Contains(FInput[scan]) do
        begin
          Inc(Result);
          Inc(scan);
        end;
    end;

    else
    begin // Oh dear. Called inappropriately.
      Result := 0; // Best compromise.
      Error(reeRegRepeatCalledInappropriately);
    end;
  end; { of case}
  FReginput := scan;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.MatchPrim(ANode: TLMDRegexNode): Boolean;
type
  TData = record
    scan:   TLMDRegexNode; // Current node.
    nxt:    TLMDRegexNode; // Next node.
    i, len: Integer;
    opnd:   Integer;
    bstart, bend: Integer;
    no:     Integer;
    save:   Integer;
    nextch: Integer;
    bracesMin, bracesMax: Integer; // we use Integer instead of TREBracesArg for better support */+
    savedLoopStack: array [1 .. LOOP_STACK_MAX] of Integer; // :(( very bad for recursion
    savedLoopStackIdx: Integer;
    prevAtWord, atWord: Boolean;
  end;

  // recursively matching routine
  // Conceptually the strategy is simple:  check to see whether the current
  // node matches, call self recursively to see whether the rest matches,
  // and then act accordingly.  In practice we make some effort to avoid
  // recursion, in particular by going through "ordinary" nodes (that don't
  // need to know whether the rest of the match failed) by a loop instead of
  // by recursion.
var
  d: ^TData;
begin
  New(d);
  try
    Result := False;
    d.scan := ANode;

    while d.scan <> nil do
    begin
      //If last group was lookahead group, then check saved text pointer
      case d.scan.Op of
        LOOKAHEAD,
        NOTHING,
        COMMENT,
        BACK,
        CLOSE,
        BRANCH,
        EEND: ;
      else
        if FSavedReginput<>-1 then  //We want to test some non-lookahead operator
        begin
          FReginput := FSavedReginput;
          FSavedReginput := -1;
        end;
      end;

      d.nxt := d.scan.NextOp;

      case d.scan.Op of
        NOTBOUND,
        BOUND:
        begin
          if FWordCharsSet.IsAnsiSet then
          begin
            d.prevAtWord := (FReginput > FInputStart) and
              (not (Ord(FInput[FReginput - 1]) in FWordSepsSet.AnsiSet)) and
              ((Ord(FInput[FReginput - 1]) in FWordCharsSet.AnsiSet));

            d.atWord := (FReginput < FInputEnd) and
              (not (Ord(FInput[FReginput]) in FWordSepsSet.AnsiSet)) and
              (Ord(FInput[FReginput]) in FWordCharsSet.AnsiSet);
          end
          else
          begin
            d.prevAtWord := (FReginput > FInputStart) and
                            (not FWordSepsSet.Contains(FInput[FReginput - 1])) and
                            FWordCharsSet.Contains(FInput[FReginput - 1]);

            d.atWord     := (FReginput < FInputEnd) and
                           (not FWordSepsSet.Contains(FInput[FReginput])) and
                            FWordCharsSet.Contains(FInput[FReginput]);
          end;

          if (d.scan.Op = BOUND) xor
             (((not d.prevAtWord) and d.atWord) or
              ((d.prevAtWord and (not d.atWord))))
          then
            EXIT;
        end;

        BOL: if FReginput > FInputStart then
            EXIT;
        EOL: if FReginput < FInputEnd then
            EXIT;
        BOLML:
          if FReginput > FInputStart then
          begin
            d.nextch := FInput[FReginput - 1];
            if (d.nextch <> Ord(FLinePairedSeparatorTail)) or
               ((FReginput - 1) <= FInputStart) or
                (FInput[FReginput - 2] <> Ord(FLinePairedSeparatorHead))
            then
            begin
              if (d.nextch = Ord(FLinePairedSeparatorHead)) and
                 (FInput[FReginput] = Ord(FLinePairedSeparatorTail))
              then
                EXIT; // don't stop between paired separator

              if FLineSeparatorsSet.IsAnsiSet then
              begin
                if not (Ord(d.nextch) in FLineSeparatorsSet.AnsiSet) then
                  EXIT;
              end
              else
              begin
                if not FLineSeparatorsSet.Contains(d.nextch) then
                  EXIT;
              end;
            end;
          end;
        EOLML:
          if FReginput < FInputEnd then
          begin
            d.nextch := FInput[FReginput];
            if (d.nextch <> Ord(FLinePairedSeparatorHead)) or
               (FReginput + 1 = FInputEnd)          or
               (FInput[FReginput + 1] <> Ord(FLinePairedSeparatorTail))
            then
            begin
              if (d.nextch = Ord(FLinePairedSeparatorTail)) and
                 (FReginput > FInputStart) and
                 (FInput[FReginput - 1] = Ord(FLinePairedSeparatorHead))
              then
                EXIT; // don't stop between paired separator

              if FLineSeparatorsSet.IsAnsiSet then
              begin
                if not (Ord(d.nextch) in FLineSeparatorsSet.AnsiSet) then
                  EXIT;
              end
              else
              begin
                if not FLineSeparatorsSet.Contains(d.nextch) then
                  EXIT;
              end;
            end;
          end;

        ANY:
        begin
          if FReginput = FInputEnd then
          begin
            FNeedMore := true;
            EXIT;
          end;

          Inc(FReginput);
        end;
        ANYML:
        begin
          if (FReginput = FInputEnd) or
             ((FReginput + 1 <> FInputEnd) and
              (FInput[FReginput] = Ord(FLinePairedSeparatorHead)) and
              (FInput[FReginput + 1] = Ord(FLinePairedSeparatorTail)))
          then
            Exit;

          if FLineSeparatorsSet.IsAnsiSet then
          begin
            if Ord(FInput[FReginput]) in FLineSeparatorsSet.AnsiSet then
              Exit;
          end
          else
          begin
            if FLineSeparatorsSet.Contains(FInput[FReginput]) then
              Exit;
          end;

          Inc(FReginput);
        end;
        ANYDIGIT:
        begin
          if (FReginput = FInputEnd) then
            EXIT;

          if FDigitsSet.IsAnsiSet then
          begin
            if not (Ord(FInput[FReginput]) in FDigitsSet.AnsiSet) then
              EXIT;
          end
          else
          begin
            if not FDigitsSet.Contains(FInput[FReginput]) then
              EXIT;
          end;

          Inc(FReginput);
        end;
        NOTDIGIT:
        begin
          if (FReginput = FInputEnd) then
            EXIT;

          if FDigitsSet.IsAnsiSet then
          begin
            if Ord(FInput[FReginput]) in FDigitsSet.AnsiSet then
              EXIT;
          end
          else
          begin
            if FDigitsSet.Contains(FInput[FReginput]) then
              EXIT;
          end;

          Inc(FReginput);
        end;

        EXACTLYCI:
        begin
          if Length(d.scan.ExactStr)<>0 then
          begin
            // Inline the first character, for speed.
            if (FReginput = FInputEnd) or
               ((d.scan.ExactChar <> FInput[FReginput]) and
                (d.scan.ExactCharInvC <> FInput[FReginput]))
            then
              EXIT;

            d.len  := Length(d.scan.ExactStr);
            d.no   := d.len;
            d.opnd := 0;
            d.save := FReginput;
            while d.no > 1 do
            begin
              Inc(d.save);
              Inc(d.opnd);

              if (d.save = FInputEnd) or
                 ((d.scan.ExactStr[d.opnd] <> FInput[d.save]) and
                  (d.scan.ExactStrInvC[d.opnd] <> FInput[d.save]))
              then
                EXIT;

              Dec(d.no);
            end;

            Inc(FReginput, d.len);
          end;
        end;

        EXACTLY:
        begin
          if Length(d.scan.ExactStr) <> 0 then
          begin
            if FReginput = FInputEnd then
            begin
              FNeedMore := true;
              EXIT;
            end;

            // Inline the first character, for speed.
            if d.scan.ExactChar <> FInput[FReginput] then
              EXIT;

            d.len  := Length(d.scan.ExactStr);
            d.no   := d.len;
            d.save := FReginput;
            d.opnd := 0;
            while d.no > 1 do
            begin
              Inc(d.save);
              Inc(d.opnd);

              if d.save = FInputEnd then
              begin
                FNeedMore := true;
                EXIT;
              end;

              if d.scan.ExactStr[d.opnd] <> FInput[d.save] then
                EXIT;

              Dec(d.no);
            end;

            Inc(FReginput, d.len);
          end;
        end;

        BSUBEXP:
        begin //###0.936
          d.no     := d.scan.BackRef;
          d.bstart := FStartp[d.no];
          d.bend   := FEndp[d.no];

          if (d.bstart = -1) or (d.bend = -1) then
            EXIT;

          if (FReginput + (d.bend - d.bstart) > FInputEnd)
          then
          begin
            FNeedMore := true;
            EXIT;
          end;

          d.save := FReginput;
          d.opnd := d.bstart;
          while d.opnd < d.bend do
          begin
            if FInput[d.save] <> FInput[d.opnd] then
              EXIT;

            Inc(d.save);
            Inc(d.opnd);
          end;

          FReginput := d.save;
        end;

        BSUBEXPCI:
        begin
          d.no     := d.scan.BackRef;
          d.bstart := FStartp[d.no];
          d.bend   := FEndp[d.no];

          if (d.bstart = -1) or (d.bend = -1) or
             (FReginput + (d.bend - d.bstart) > FInputEnd)
          then
            EXIT;

          d.save := FReginput;
          d.opnd := d.bstart;

          while d.opnd < d.bend do
          begin
            if (d.save = FInputEnd) or
               ((FInput[d.save] <> FInput[d.opnd]) and
                (FInput[d.save] <> InvertCase(FInput[d.opnd])))
            then
              EXIT;

            Inc(d.save);
            Inc(d.opnd);
          end;

          FReginput := d.save;
        end;

        ANYOFTINYSET:
        begin
          if FReginput = FInputEnd then
          begin
            FNeedMore := true;
            EXIT;
          end;

          if  ((FInput[FReginput] <> d.scan.TinySet[0]) and
               (FInput[FReginput] <> d.scan.TinySet[1]) and
               (FInput[FReginput] <> d.scan.TinySet[2]))
          then
            EXIT;

          Inc(FReginput);
        end;

        ANYBUTTINYSET:
        begin
          if FReginput = FInputEnd then
          begin
            FNeedMore := true;
            EXIT;
          end;

          if ((FInput[FReginput] = d.scan.TinySet[0]) or
              (FInput[FReginput] = d.scan.TinySet[1]) or
              (FInput[FReginput] = d.scan.TinySet[2]))
          then
            EXIT;

          Inc(FReginput);
        end;

        ANYOFFULLSET:
        begin
          if FReginput = FInputEnd then
          begin
            FNeedMore := true;
            EXIT;
          end;

          if d.scan.SetHash.IsAnsiSet then
          begin
            if not (Ord(FInput[FReginput]) in d.scan.SetHash.AnsiSet) then
              EXIT;
          end
          else
          begin
            if not d.scan.SetHash.Contains(FInput[FReginput]) then
              EXIT;
          end;

          Inc(FReginput);
        end;

        NOTHING: ;
        COMMENT: ;
        BACK: ;

        LOOKAHEAD:
        begin
          d.save := FReginput;

          if FSavedReginput<>-1 then
          begin
            FReginput := FSavedReginput;
            FSavedReginput := -1;
          end;

          if MatchPrim(d.scan.NextNode) then
          begin
            if FSavedReginput=-1 then
              FSavedReginput := FReginput;

            FReginput := d.save;
          end
          else
            Exit;
        end;

        Open .. TLMDREOp(Ord(Open) + NSUBEXP - 1):
        begin
          d.no     := Ord(d.scan.Op) - Ord(Open);

          if d.no<>0 then
          begin
            d.save   := FStartp[d.no];
            FStartp[d.no] := FReginput;
          end
          else  //Zero group num used for non-capturing group (?: bebe )
            d.save := -1;

          Result := MatchPrim(d.nxt);

          if (not Result) and (d.no<>0) then
            FStartp[d.no] := d.save;

          EXIT;
        end;

        Close .. TLMDREOp(Ord(Close) + NSUBEXP - 1):
        begin
          d.no := Ord(d.scan.Op) - Ord(Close);

          if d.no<>0 then
          begin
            d.save      := FEndp[d.no];
            FEndp[d.no] := FReginput;
          end
          else  //Zero group num used for non-capturing group (?: bebe )
            d.save := -1;

          if d.nxt<>nil then
            Result    := MatchPrim(d.nxt)
          else
            Result    := true;

          if (not Result) and (d.no<>0) then
            FEndp[d.no] := d.save;

          EXIT;
        end;

        BRANCH:
        begin
          if (d.nxt.Op <> BRANCH) then
            d.nxt := d.scan.NextNode // Avoid recursion
          else
          begin
            repeat
              d.save   := FReginput;
              Result := MatchPrim(d.scan.NextNode);

              if Result then
                EXIT;

              FReginput := d.save;
              d.scan    := d.scan.NextOp;
            until (d.scan = nil) or (d.scan.Op <> BRANCH);

            EXIT;
          end;

        end;

        LOOPENTRY:
        begin
          d.no := FLoopStackIdx;
          Inc(FLoopStackIdx);

          if FLoopStackIdx > LOOP_STACK_MAX then
            Error(reeLoopStackExceeded);

          d.save   := FReginput;
          FLoopStack[FLoopStackIdx] := 0; // init loop counter
          Result := MatchPrim(d.nxt); // execute LOOP
          FLoopStackIdx := d.no; // cleanup

          if Result then
            EXIT;

          FReginput := d.save;
          EXIT;
        end;

        LOOP, LOOPNG:
        begin
          if FLoopStackIdx <= 0 then
            Error(reeLoopWithoutEntry);

          d.bracesMin := d.scan.MinBrace;
          d.bracesMax := d.scan.MaxBrace;

          d.save := FReginput;

          if FLoopStack[FLoopStackIdx] >= d.bracesMin then // Min alredy matched - we can work
          begin
            if d.scan.Op = LOOP then
            begin
              // greedy way - first try to max deep of greed ;)
              if FLoopStack[FLoopStackIdx] < d.bracesMax then
              begin
                Inc(FLoopStack[FLoopStackIdx]);
                d.no     := FLoopStackIdx;
                Result := MatchPrim(d.scan.LoopTo);
                FLoopStackIdx := d.no;

                if Result then
                  EXIT;

                FReginput := d.save;
              end;
              //Dec(FLoopStackIdx); // Fail. May be we are too greedy? ;)

              Result := MatchPrim(d.nxt);
              if not Result then
                FReginput := d.save;

              EXIT;
            end
            else
            begin
              // non-greedy - try just now
              Result := MatchPrim(d.nxt);
              if Result then
                EXIT
              else
                FReginput := d.save; // failed - move d.Next and try again

              if FLoopStack[FLoopStackIdx] < d.bracesMax then
              begin
                Inc(FLoopStack[FLoopStackIdx]);
                d.no     := FLoopStackIdx;
                Result := MatchPrim(d.scan.LoopTo);
                FLoopStackIdx := d.no;

                if Result then
                  EXIT;
                FReginput := d.save;
              end;
              //Dec(FLoopStackIdx); // Failed - back up
              EXIT;
            end;
          end
          else
          begin // first match a min_cnt times
            Inc(FLoopStack[FLoopStackIdx]);
            d.no     := FLoopStackIdx;
            Result := MatchPrim(d.scan.LoopTo);
            FLoopStackIdx := d.no;

            if Result then
              EXIT;

            Dec(FLoopStack[FLoopStackIdx]);
            FReginput := d.save;
            EXIT;
          end;
        end;

        STAR, PLUS, BRACES, STARNG, PLUSNG, BRACESNG:
        begin
          // Lookahead to avoid useless match attempts when we know
          // what character comes d.Next.
          d.nextch := 0;
          if d.nxt.Op = EXACTLY then
            d.nextch := d.nxt.ExactChar;

          d.bracesMax := MaxInt; // infinite loop for * and +

          if (d.scan.Op = STAR) or (d.scan.Op = STARNG) then
            d.bracesMin := 0  // STAR
          else
          if (d.scan.Op = PLUS) or (d.scan.Op = PLUSNG) then
            d.bracesMin := 1 // PLUS
          else
          begin // BRACES
            d.bracesMin := d.scan.MinBrace;
            d.bracesMax := d.scan.MaxBrace;
          end;

          d.save := FReginput;

          if (d.scan.Op = PLUSNG) or (d.scan.Op = STARNG) or (d.scan.Op = BRACESNG) then
          begin
            //non-greedy mode
            d.bracesMax := RegRepeat(d.scan.NextNode, d.bracesMax); // don't repeat more than BracesMax
            // Now we know real Max limit to move forward (for recursion 'back up')
            // In some cases it can be faster to check only Min positions first,
            // but after that we have to check every position separtely instead
            // of fast scannig in loop.
            d.no := d.bracesMin;

            while d.no <= d.bracesMax do
            begin
              FReginput := d.save + d.no;
              // If it could work, try it.
              if (d.nextch = 0) or ((FReginput < FInputEnd) and (FInput[FReginput] = d.nextch)) then
              begin
                d.i := 1;
                while d.i <= LOOP_STACK_MAX do // for i := 1 to LOOP_STACK_MAX do
                begin
                  d.savedLoopStack[d.i] := FLoopStack[d.i];
                  Inc(d.i);
                end;
                d.savedLoopStackIdx := FLoopStackIdx;

                if MatchPrim(d.nxt) then
                begin
                  Result := True;
                  EXIT;
                end;

                d.i := 1;
                while d.i <= LOOP_STACK_MAX do // for i := 1 to LOOP_STACK_MAX do
                begin
                  FLoopStack[d.i] := d.savedLoopStack[d.i];
                  Inc(d.i);
                end;
                FLoopStackIdx := d.savedLoopStackIdx;
              end;

              Inc(d.no); // Couldn't or didn't - move forward.
            end; { of while}

            FNeedMore := FNeedMore or (FReginput=FInputEnd);
            EXIT;
          end
          else
          begin // greedy mode
            d.no := RegRepeat(d.scan.NextNode, d.bracesMax); // don't repeat more than max_cnt
            FNeedMore := FNeedMore or (FReginput=FInputEnd);

            while d.no >= d.bracesMin do
            begin
              // If it could work, try it.
              if (d.nextch = 0) or ((FReginput < FInputEnd) and (FInput[FReginput] = d.nextch)) then
              begin
                d.i := 1;
                while d.i <= LOOP_STACK_MAX do // for i := 1 to LOOP_STACK_MAX do
                begin
                  d.savedLoopStack[d.i] := FLoopStack[d.i];
                  Inc(d.i);
                end;
                d.savedLoopStackIdx := FLoopStackIdx;

                if MatchPrim(d.nxt) then
                begin
                  Result := True;
                  EXIT;
                end;

                d.i := 1;
                while d.i <= LOOP_STACK_MAX do // for i := 1 to LOOP_STACK_MAX do
                begin
                  FLoopStack[d.i] := d.savedLoopStack[d.i];
                  Inc(d.i);
                end;
                FLoopStackIdx := d.savedLoopStackIdx;
              end;

              Dec(d.no); // Couldn't or didn't - back up.
              FReginput := d.save + d.no;
            end; { of while}
            EXIT;
          end;
        end;

        EEND:
        begin
          Result := True;  // Success!
          EXIT;
        end;

        else
          Error(reeMatchPrimMemoryCorruption);

      end; { of case d.scan.Op}
      d.scan := d.nxt;
    end; { of while d.scan <> nil}

    // We get here only if there's trouble -- normally "case EEND" is the
    // terminating point.
    Error(reeMatchPrimCorruptedPointers);
  finally
    Dispose(d);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.GetFirstCharSetAnsi(var HasUnicode: Boolean): TLMDSetOfByte;
begin
  PrepareVarsOpts;

  Result := FFirstCharSet;
  HasUnicode := FFirstCharSetHasUnicode;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.InvalidateVariables;
begin
  if HasVariables then
    FVarsOptsOk := false;
end;

function  TLMDRegExp.HasVariables: Boolean;
begin
  result := FVariablesList.Count>0;
end;

{ ---------------------------------------------------------------------------- }

function  TLMDRegExp.MaxVariableId: Integer;
begin
  result := CompiledSubExpCount-1;
end;

{ ---------------------------------------------------------------------------- }

function  TLMDRegExp.GetVarByID(AId: Integer; var AStart, ACount: Integer): Boolean;
begin
  result := (AId<=MaxVariableId) and (FStartp[AId]<>-1) and (FEndp[AId]<>-1);
  if result then
  begin
    AStart := FStartp[AId];
    ACount := FEndp[AId] - AStart;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.CheckInputSourceIsString;
begin
  if FInput = nil then
    Error(reeInputSourceNotSet);

  if not (FInput is TLMDRegexStringSource) then
    Error(reeInputSourceIsNotString);
end;

function TLMDRegExp.GetInputText: TLMDString;
begin
  if FInput = nil then
  begin
    result := '';
    Exit;
  end;

  CheckInputSourceIsString;
  result := TLMDRegexStringSource(FInput).FStr
end;

procedure TLMDRegExp.SetInputText(const AStr: TLMDString);
begin
  if Length(AStr)<>0 then
    SetInput(TLMDRegexStringSource.Create(AStr), true)
  else
    SetInput(TLMDRegexStringSource.Create(''), true);
end;

function TLMDRegExp.GetInputSource: TLMDRegexSource;
begin
  result := FInput;
end;

procedure TLMDRegExp.SetInputSource(ASrc: TLMDRegexSource);
begin
  if FInput=ASrc then
    Exit;

  SetInput(ASrc, false);
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.Exec: Boolean;
begin
  if FInput = nil then
    Error(reeInputSourceNotSet);

  Result := Exec(FInput.BaseIndex, -1);
end;

function TLMDRegExp.Exec(AOffset: Integer): Boolean;
begin
  Result := Exec(AOffset, -1);
end;

function TLMDRegExp.Exec(AOffset, ACount: Integer;
                         var ANeedMoreSource: Boolean): Boolean;
begin
  ANeedMoreSource := false;
  result := Exec(AOffset, ACount);
  ANeedMoreSource := FNeedMore;
end;

function TLMDRegExp.Exec(AOffset, ACount: Integer): Boolean;
begin
  if FInput=nil then
    Error(reeInputSourceNotSet);

  Result := ExecPrim(AOffset, ACount);
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.Substitute(const ATemplate: TLMDString): TLMDString;
  // perform substitutions after a regexp match
var
  TemplateLen: Integer;
  TemplateBeg, TemplateEnd: Integer;
  p, p0, ResultPtr: Integer;
  ResultLen: Integer;
  n:  Integer;
  Ch: TLMDChar;
  Res: TLMDCharArray;

  function ParseVarName(var APtr: Integer): Integer;
    // extract name of variable (digits, may be enclosed with
    // curly braces) from APtr^, uses TemplateEnd
  var
    p: Integer;
    Delimited: Boolean;
  begin
    Result := 0;
    p      := APtr;
    Delimited := (p < TemplateEnd) and (ATemplate[p] = '{');
    if Delimited then
      Inc(p); // skip left curly brace

    if (p < TemplateEnd) and (ATemplate[p] = '&') then
      Inc(p) // this is '$&' or '${&}'
    else
      while (p < TemplateEnd) and
            (Ord(ATemplate[p]) >= Ord('0')) and
            (Ord(ATemplate[p]) <= Ord('9'))
      do
      begin
        Result := Result * 10 + (Ord(ATemplate[p]) - Ord('0'));
        Inc(p);
      end;

    if Delimited then
    begin
      if (p < TemplateEnd) and (ATemplate[p] = '}') then
        Inc(p) // skip right curly brace
      else
      begin
        Error(reeSubstituteMalformedVariable, p);
        p := APtr; // isn't properly terminated
      end;
    end;

    if p = APtr then
      Result := -1; // no valid digits found or no right curly brace

    APtr := p;
  end;

begin
  // Check programm and input string
  if not IsProgrammOk then
    EXIT;

  if ModifierC then
    Error(reeThisOperationNotWorkingInIntCodesMode);

  // Prepare for working
  TemplateLen := Length(ATemplate);
  if TemplateLen = 0 then
  begin // prevent nil pointers
    Result := '';
    EXIT;
  end;

  TemplateBeg := 1;
  TemplateEnd := TemplateBeg + TemplateLen;
  // Count result length for speed optimization.
  ResultLen := 0;
  p := TemplateBeg;
  while p < TemplateEnd do
  begin
    Ch := ATemplate[p];
    Inc(p);
    if Ch = '$' then
      n := ParseVarName(p)
    else
      n := -1;

    if n >= 0 then
    begin
      if (n < FSubexpCount) and (FStartp[n]<>-1) and (FEndp[n]<>-1) then
        Inc(ResultLen, FEndp[n] - FStartp[n]);
    end
    else
    begin
      if (Ch = EscChar) and (p < TemplateEnd) then // quoted or special char followed
      begin
        UnQuoteChar(p, ATemplate, TemplateEnd);
        Inc(p);
      end;

      Inc(ResultLen);
    end;
  end;

  // Get memory. We do it once and it significant speed up work !
  if ResultLen = 0 then
  begin
    Result := '';
    EXIT;
  end;
  SetLength(Res, ResultLen);

  // Fill Result
  ResultPtr := 0;
  p := TemplateBeg;
  while p < TemplateEnd do
  begin
    Ch := ATemplate[p];
    Inc(p);
    if Ch = '$' then
      n := ParseVarName(p)
    else
      n := -1;

    if n >= 0 then
    begin
      p0 := FStartp[n];
      if (n < FSubexpCount) and (p0<>-1) and (FEndp[n]<>-1) then
        while p0 < FEndp[n] do
        begin
          Res[ResultPtr] := TLMDChar(FInput[p0]);
          Inc(ResultPtr);
          Inc(p0);
        end;
    end
    else
    begin
      if (Ch = EscChar) and (p < TemplateEnd) then // quoted or special char followed
      begin
        Ch := UnQuoteChar(p, ATemplate, TemplateEnd);
        Inc(p);
      end;

      Res[ResultPtr] := Ch;
      Inc(ResultPtr);
    end;
  end;

  Result := LMDCharArrayToString(Res, 0, Length(Res))
end;

// Split AInputStr into APieces by r.e. occurencies
// Internally calls Exec[Next]
procedure TLMDRegExp.Split(APieces: TLMDStrings);
var
  PrevPos : integer;
begin
  if ModifierC then
    Error(reeThisOperationNotWorkingInIntCodesMode);

  CheckInputSourceIsString;

  PrevPos := 1;

  if Exec then
  repeat
    APieces.Add (Copy(TLMDRegexStringSource(FInput).FStr,
                      PrevPos, MatchPos [0] - PrevPos));

    PrevPos := MatchPos [0] + MatchLen [0];
  until not ExecNext;

  if FInput.Count >= PrevPos then
    APieces.Add (Copy (TLMDRegexStringSource(FInput).FStr, PrevPos,
                       FInput.Count - PrevPos + 1)); // Tail
end;

function TLMDRegExp.Replace(const AReplaceStr: TLMDString;
                            AUseSubstitution: Boolean = False): TLMDString;
var
  PrevPos: Integer;
begin
  if ModifierC then
    Error(reeThisOperationNotWorkingInIntCodesMode);

  CheckInputSourceIsString;

  Result  := '';
  PrevPos := 1;

  if Exec then
    repeat
      Result := Result + Copy(TLMDRegexStringSource(FInput).FStr,
                              PrevPos, MatchPos[0] - PrevPos);

      if AUseSubstitution then
        Result := Result + Substitute(AReplaceStr)
      else
        Result := Result + AReplaceStr;

      PrevPos := MatchPos[0] + MatchLen[0];
    until not ExecNext;

  Result := Result + Copy(TLMDRegexStringSource(FInput).FStr,
                          PrevPos, MaxInt); // Tail
end;

function TLMDRegExp.ReplaceEx(AReplaceFunc: TLMDRegExprReplaceFunction): TLMDString;
var
  PrevPos: Integer;
begin
  if ModifierC then
    Error(reeThisOperationNotWorkingInIntCodesMode);

  CheckInputSourceIsString;

  Result  := '';
  PrevPos := 1;

  if Exec then
    repeat
      Result  := Result + Copy(TLMDRegexStringSource(FInput).FStr,
                               PrevPos, MatchPos[0] - PrevPos) +
                 AReplaceFunc(Self);

      PrevPos := MatchPos[0] + MatchLen[0];
    until not ExecNext;

  Result := Result + Copy(TLMDRegexStringSource(FInput).FStr,
                          PrevPos, MaxInt); // Tail
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.ClearMatches; //clears matchs array
var
  i: Integer;
begin
  //clears matchs array
  for i := 0 to FSubexpCount - 1 do
  begin
    FStartp[i] := -1;
    FEndp[i]   := -1;
  end;
end;

function TLMDRegExp.ExecPrim(AOffset, ACount: Integer): Boolean;

  function RegMatch(AStart: Integer): Boolean;
    // try match at specific point
  begin
    FSavedReginput := -1;
    FReginput := AStart;
    Result    := MatchPrim(FProgrammFirst);
    if Result then
    begin
      FStartp[0] := AStart;
      FEndp[0]   := FReginput;
    end;

    FNeedMore := FNeedMore or (FReginput = FInputEnd);
  end;

  function AcceptChar(AIdx: Integer): Boolean;
  var Ch: Integer;
  begin
    if AIdx <> FInputEnd then
    begin
      Ch := FInput[AIdx];

      result := ((Ch <= High(Byte)) and (Ch in FFirstCharSet)) or
                ((Ch > High(Byte)) and FFirstCharSetHasUnicode)
    end
    else
      result := true;
  end;

var
  s: Integer;
  StartPtr: Integer;
begin
  FNeedMore := false;
  Result := False; // Be paranoid...

  // ensure that Match cleared either if optimization tricks or some error
  // will lead to leaving ExecPrim without actual search. That is
  // important for ExecNext logic and so on.
  ClearMatches;

  if not IsProgrammOk then
    EXIT;

  //Check that the start position is not negative
  if AOffset > (FInput.Count + FInput.BaseIndex) then
    EXIT;//For ExecNext

  if AOffset < FInput.BaseIndex then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AOffset]);

  PrepareVarsOpts;
  Assert((FFirstCharSet<>[]) or FFirstCharSetHasUnicode);

  FInputStart := FInput.BaseIndex; //Start of segment

  // Pointer to end of input stream - for
  // pascal-style string processing
  FInputEnd   := FInput.Count + FInput.BaseIndex;
  if ACount <> -1 then
  begin

    if ACount < 0 then
      ACount := 0;

    FInputEnd := Min(FInputEnd, AOffset + ACount);
  end;

  ////////////////////////////////////////////////////////////

  StartPtr := AOffset;

  // no loops started
  FLoopStackIdx := 0;

  if (FRegmustExact <> nil) then //Input string is too short
    if StartPtr + Length(FRegmustExact.ExactStr) > FInputEnd then
    begin
      FNeedMore := true;
      EXIT;
    end;

  if FRegAnch or CompModifier(MaskModA) then
  begin
    Result := AcceptChar(StartPtr) and RegMatch(StartPtr);

    EXIT;
  end;

  if (FRegmustExact <> nil) and (FRegStart = nil) then
  begin
    if StartPtr<>FInputEnd then
      s := FBMSearch.Search(FInput, StartPtr)
    else
      s := -1;

    if s = -1 then
      EXIT;
  end;       // Messy cases:  unanchored match.

  if FRegStart <> nil then  // We know what char it must start with.
  begin
    s := StartPtr;

    repeat
      case FRegStart.Op of
        EXACTLY, EXACTLYCI:
        begin
          if s<>FInputEnd then
            s := FBMSearch.Search(FInput, s)
          else
            s := -1;
        end;

        NOTDIGIT:
        begin
          if FDigitsSet.IsAnsiSet then
            while (s < FInputEnd) and (FInput[s] in FDigitsSet.AnsiSet) do
              Inc(s)
          else
            while (s < FInputEnd) and FDigitsSet.Contains(FInput[s]) do
              Inc(s);
        end;

        ANYDIGIT:
        begin
          if FDigitsSet.IsAnsiSet then
            while (s < FInputEnd) and (not (FInput[s] in FDigitsSet.AnsiSet)) do
              Inc(s)
          else
            while (s < FInputEnd) and (not FDigitsSet.Contains(FInput[s])) do
              Inc(s);
        end;

        ANYBUTTINYSET:
        begin
          while (s < FInputEnd) and
             ((FInput[s] = FRegStart.TinySet[0]) or
              (FInput[s] = FRegStart.TinySet[1]) or
              (FInput[s] = FRegStart.TinySet[2]))
          do
            Inc(s);
        end;

        ANYOFTINYSET:
        begin
          while (s < FInputEnd) and
             ((FInput[s] <> FRegStart.TinySet[0]) and
              (FInput[s] <> FRegStart.TinySet[1]) and
              (FInput[s] <> FRegStart.TinySet[2]))
          do
            Inc(s);
        end;

        ANYOFFULLSET:
        begin
          if FRegStart.SetHash.IsAnsiSet then
            while (s < FInputEnd) and
                  (not (FInput[s] in FRegStart.SetHash.AnsiSet))
            do
              Inc(s)
          else
            while (s < FInputEnd) and
                  (not FRegStart.SetHash.Contains(FInput[s]))
            do
              Inc(s);
        end;

        else
          Assert(false);
      end;

      if s >= FInputEnd then
        s := -1;

      if s <> -1 then
      begin
        Result := RegMatch(s);
        if Result then
          EXIT
        else
          ClearMatches;

        Inc(s);
      end;

    until s = -1;
  end
  else
  begin     // We don't - general case.
    s := StartPtr;

    repeat
      if AcceptChar(s) then
        Result := RegMatch(s);

      Inc(s);

      if Result or (s > FInputEnd) then // Exit on a match or after testing the end-of-string.
        EXIT
      else
        ClearMatches
    until False;
  end;

  // Failure
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.ExecNext: Boolean;
var
  offset: Integer;
begin
  if (FInput=nil) or (FStartp[0] = -1) or (FEndp[0] = -1) then
    Error(reeExecNextWithoutExec);

  Offset := FEndp[0]{ + 1};

  if FEndp[0] = FStartp[0] then
    Inc(Offset); // prevent infinite looping if empty string match r.e.

  Result := ExecPrim(Offset, FInputEnd-Offset);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.SetSpaceChars(const AStr: TLMDString);
begin
  if AStr <> FSpaceChars then
  begin
    FSpaceChars := AStr;
    InvalidateProgramm;
  end;
end;

procedure TLMDRegExp.SetSubExpCountLow(ACount: Integer);
begin
  FSubexpCount := ACount;
  SetLength(FStartp, ACount);
  SetLength(FEndp, ACount);
end;

procedure TLMDRegExp.SetWordChars(const AStr: TLMDString);
begin
  if AStr <> FWordChars then
  begin
    FWordChars := AStr;
    InvalidateProgramm;
  end;
end;

procedure TLMDRegExp.SetWordSeparators(const AStr: TLMDString);
begin
  if AStr <> FWordSeparators then
  begin
    FWordSeparators := AStr;
    InvalidateProgramm;
  end;
end;

procedure TLMDRegExp.SetLineSeparators(const AStr: TLMDString);
begin
  if AStr <> FLineSeparators then
  begin
    FLineSeparators := AStr;
    InvalidateProgramm;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRegExp.SetLinePairedSeparator(const AStr: TLMDString);
begin
  if length(AStr) = 2 then
  begin
    if AStr[1] = AStr[2] then
    begin
      // it's impossible for our 'one-point' checking to support
      // two chars separator for identical chars
      Error(reeBadLinePairedSeparator);
      EXIT;
    end;

    if not FLinePairedSeparatorAssigned or (AStr[1] <> FLinePairedSeparatorHead) or (AStr[2] <> FLinePairedSeparatorTail) then
    begin
      FLinePairedSeparatorAssigned := True;
      FLinePairedSeparatorHead     := AStr[1];
      FLinePairedSeparatorTail     := AStr[2];
      InvalidateProgramm;
    end;
  end
  else
  if length(AStr) = 0 then
  begin
    if FLinePairedSeparatorAssigned then
    begin
      FLinePairedSeparatorAssigned := False;
      InvalidateProgramm;
    end;
  end
  else
    Error(reeBadLinePairedSeparator);
end;

{ ---------------------------------------------------------------------------- }

function TLMDRegExp.GetLinePairedSeparator: TLMDString;
begin
  if FLinePairedSeparatorAssigned then
  begin
  {$IFDEF LMD_UNICODE}
    // Here is some UniCode 'magic'
    // If You do know better decision to concatenate
    // two WideChars, please, let me know!
    Result := FLinePairedSeparatorHead;
    Result := Result + FLinePairedSeparatorTail;
  {$ELSE}
    Result := fLinePairedSeparatorHead + fLinePairedSeparatorTail;
  {$ENDIF}
  end
  else
    Result := '';
end;

{ ---------------------------------------------------------------------------- }

 {=============================================================}
 {====================== Debug section ========================}
 {=============================================================}

{$IFDEF LMD_RE_PCODE_DUMP}

function DumpOpCore(AOp: TLMDREOp): TLMDString;
// printable representation of opcode
begin
  case AOp of
    BOL: Result      := 'BOL';
    EOL: Result      := 'EOL';
    BOLML: Result    := 'BOLML';
    EOLML: Result    := 'EOLML';
    BOUND: Result    := 'BOUND';
    NOTBOUND: Result := 'NOTBOUND';
    ANY: Result      := 'ANY';
    ANYML: Result    := 'ANYML';
    ANYDIGIT: Result := 'ANYDIGIT';
    NOTDIGIT: Result := 'NOTDIGIT';
    ANYOF:
    begin
      Result := 'ANYOF SHOULD NOT BE HERE !!!';
      Assert(False);
    end;
    ANYBUT:
    begin
      Result := 'ANYBUT SHOULD NOT BE HERE !!!';
      Assert(False);
    end;
    ANYOFCI:
    begin
      Result := 'ANYOFCI SHOULD NOT BE HERE !!!';
      Assert(False);
    end;
    ANYBUTCI:
    begin
      Result := 'ANYBUTCI SHOULD NOT BE HERE !!!';
      Assert(False);
    end;
    BRANCH: Result := 'BRANCH';
    EXACTLY: Result := 'EXACTLY';
    EXACTLYCI: Result := 'EXACTLY/CI';
    NOTHING: Result := 'NOTHING';
    COMMENT: Result := 'COMMENT';
    BACK: Result := 'BACK';
    EEND: Result := 'END';
    BSUBEXP: Result := 'BSUBEXP';
    BSUBEXPCI: Result := 'BSUBEXP/CI';
    Open .. TLMDREOp(Ord(Open) + NSUBEXP - 1):
      Result     := Format('OPEN[%d]', [Ord(AOp) - Ord(Open)]);
    Close .. TLMDREOp(Ord(Close) + NSUBEXP - 1):
      Result     := Format('CLOSE[%d]', [Ord(AOp) - Ord(Close)]);
    STAR: Result := 'STAR';
    PLUS: Result := 'PLUS';
    BRACES: Result := 'BRACES';
    LOOPENTRY: Result := 'LOOPENTRY';
    LOOP: Result := 'LOOP';
    LOOPNG: Result := 'LOOPNG';
    ANYOFTINYSET: Result := 'ANYOFTINYSET';
    ANYBUTTINYSET: Result := 'ANYBUTTINYSET';
    ANYOFFULLSET: Result := 'ANYOFFULLSET';
    STARNG: Result := 'STARNG';
    PLUSNG: Result := 'PLUSNG';
    BRACESNG: Result := 'BRACESNG';
    LOOKAHEAD: Result := 'LOOKAHEAD';

    else
      Result := '';
  end;
end;

function TLMDRegExp.Dump: TLMDString;

  function DumpOp(AOp: TLMDREOp): TLMDString;
    // printable representation of opcode
  begin
    Result := DumpOpCore(AOp);
    if Result='' then
      Error(reeDumpCorruptedOpcode);

    Result := ':' + Result;
  end;

  function NodePos(ANode: TLMDRegexNode): Integer;
  var
    N: TLMDRegexNode;
  begin
    N      := FProgrammFirst;
    Result := 0;
    while N <> ANode do
    begin
      Inc(Result);
      N := N.NextNode;
    end;
  end;

  function ArrToStr(const Arr: TLMDIntArray): TLMDString;
  var i: Integer; CArr: TLMDCharArray;
  begin
    SetLength(Result, 0);
    SetLength(CArr, Length(Arr));

    for i := 0 to Length(Arr)-1 do
      CArr[i] := TLMDChar(Arr[i]);

    Result := LMDCharArrayToString(CArr, 0, Length(CArr));
  end;

  function DumpNodeContents(ANode: TLMDRegexNode): TLMDString;

  var
    res: TLMDString;
    Ch:  TLMDChar;
  begin

    case ANode.Op of
      EXACTLY, EXACTLYCI: res := ArrToStr(ANode.ExactStr);
      ANYOFTINYSET, ANYBUTTINYSET: res := ArrToStr(ANode.TinySet);
      BSUBEXP, BSUBEXPCI: res := ' \' + IntToStr(ANode.BackRef);

      ANYOFFULLSET:
      begin
        for Ch := Low(TLMDChar) to High(TLMDChar) do
        {$IFDEF LMD_UNICODE}
          if ANode.SetHash.Contains(Ch) and (Ord(Ch) <= High(byte)) then
        {$ELSE}
          if ANode.SetHash.Contains(Ch) then
        {$ENDIF}
          begin
            if Ord(Ch) < Ord(' ') then
              res := Result + '#' + IntToStr(Ord(Ch))
            else
              res := res + Ch;
          end;
      end;

      BRACES, BRACESNG:
        res := Format('{%d,%d}', [ANode.MinBrace, ANode.MaxBrace]);

      LOOP, LOOPNG:
        res := Format(' -> (%d) {%d,%d}',
          [NodePos(ANode.LoopTo), //'LoopTo' absolute index
          ANode.MinBrace, ANode.MaxBrace])

      else
        res := '';
    end;

    Result := res;
  end;

  function DumpFirstCharSet: TLMDString;
  {$IFDEF LMD_UNICODE}
  begin
    Result := '';
  end;
  {$ELSE}
  var
    Ch: TLMDChar;
  begin
    Result := '';
    if FFirstCharSet=[] then
      Exit;

    Result := LMDCRLF+'FirstCharSet:';
    for Ch := Low(TLMDChar) to High(TLMDChar) do
     if Ord(Ch) in FFirstCharSet then
     begin
      if Ord(Ch) < Ord(' ') then
        Result := Result + '#' + IntToStr(Ord(Ch))
      else
        Result := Result + Ch
     end;
  end;
  {$ENDIF}

  // dump a regexp in vaguely comprehensible form
var
  s:    TLMDRegexNode;
  op:   TLMDREOp; // Arbitrary non-END op.
  Next: TLMDRegexNode;

begin
  if not IsProgrammOk then
    EXIT;

  op     := EXACTLY;
  Result := '';
  s      := FProgrammFirst;
  while op <> EEND do // While that wasn't END last time...
  begin
    op     := s.Op;
    Result := Result + Format('%2d%s', [NodePos(s), DumpOp(s.Op)]); // Where, what.
    Next   := s.NextOp;

    if Next = nil then
      Result := Result + ' (0) '
    else
    begin
      Result := Result + Format(' (%d) ', [NodePos(Next)]);
    end;

    Result := Result + DumpNodeContents(s);

    Result := Result + LMDCRLF;
    s      := s.NextNode;
  end; { of while}

  // Header fields of interest.

  if FRegStart <> nil then
  begin
    Result := Result + LMDCRLF + 'start' + DumpOp(FRegStart.Op) + LMDCRLF + DumpNodeContents(FRegStart);
  end;

  if FRegAnch then
    Result := Result + 'anchored ';

  if FRegmustExact <> nil then
    Result := Result + LMDCRLF + 'must have ' + ArrToStr(FRegmustExact.ExactStr);

  Result := Result + DumpFirstCharSet;

  Result := Result + LMDCRLF;
end;

{ ---------------------------------------------------------------------------- }

{$ENDIF}

procedure TLMDRegExp.CheckInCodesMode(const AConstruct: TLMDString);
begin
  if not CompModifier(MaskModC) then
    Error(reeThisConstructRequiresIntCodesMode);
end;

procedure TLMDRegExp.CheckNotInCodesMode(const AConstruct: TLMDString);
begin
  if CompModifier(MaskModC) then
    Error(reeThisConstructNotWorkingInIntCodesMode);
end;

procedure TLMDRegExp.Error(AErrorID: Integer; AErrPos: Integer);
var
  e: ELMDRegExprError;
begin
  if AErrPos=-1 then
    AErrPos := CompilerErrorPos;

  FLastError := AErrorID; // dummy stub - useless because will raise exception

  if AErrorID < 1000 then // compilation error ? yes - show error pos
    e := ELMDRegExprError.Create(Format('%s (pos: %d)',
                                        [ErrorMsg(AErrorID), AErrPos]))
  else
    e := ELMDRegExprError.Create(ErrorMsg(AErrorID));

  e.ErrorCode := AErrorID;
  e.CompilerErrorPos := AErrPos;
  raise e;
end;

{ ---------------------------------------------------------------------------- }

{ ILMDRegexSource }

constructor TLMDRegexSource.Create(ABufSize, AInitCount: Integer);
begin
  inherited Create;

  FIdxStart := 0;
  FIdxEnd := 0;
  FBufferStart := -1;
  FBufferEnd := 0;

  FBufferSize := ABufSize;
  FBoundGap := 5;
  SetLength(FBuffer, ABufSize);
  BaseIndex := 0;
  Count := AInitCount;
end;

procedure TLMDRegexSource.ResetBuffer;
begin
  FBufferStart := -1;
  FBufferEnd := -1;
end;

function TLMDRegexSource.GetCode(AIdx: Integer): Integer;
begin
  if (AIdx<FBufferStart) or (AIdx>=FBufferEnd) then
  begin
    Assert(LMDInRange(AIdx, FIdxStart, FIdxEnd-1));

    if AIdx>=FBufferEnd then
    begin
      FBufferStart := AIdx - FBoundGap;
      FBufferEnd := FBufferStart + FBufferSize;
    end
    else
    begin
      FBufferEnd := AIdx + FBoundGap + 1;
      FBufferStart := FBufferEnd - FBufferSize;
    end;

    if FBufferStart<FIdxStart then
    begin
      FBufferStart := FIdxStart;

      FBufferEnd := FBufferStart + FBufferSize;
      if FBufferEnd>FIdxEnd then
        FBufferEnd := FIdxEnd;
    end;

    if FBufferEnd>FIdxEnd then
    begin
      FBufferEnd := FIdxEnd;

      FBufferStart := FBufferEnd - FBufferSize;
      if FBufferStart<FIdxStart then
        FBufferStart := FIdxStart;
    end;

    Assert((AIdx>=FBufferStart) and (AIdx<FBufferEnd));
    FillBuffer;
  end;

  result := FBuffer[AIdx - FBufferStart];
end;

procedure TLMDRegexSource.SetBuffer(ABuffer: TLMDIntArray);
begin
  FBuffer := ABuffer;
  FBufferSize := Length(FBuffer);

  ResetBuffer;
end;

////
constructor TLMDRegexStringSource.Create(const AStr: TLMDString);
begin
  inherited Create(256, Length(AStr));
  FStr := AStr;
  FIdxStart := 1;
  FIdxEnd := Length(AStr)+1;
  BaseIndex := FIdxStart;
end;

procedure TLMDRegexStringSource.FillBuffer;
var i: Integer;
begin
  for i := FBufferStart to FBufferEnd-1 do
    FBuffer[i - FBufferStart] := Integer(FStr[i]);
end;

const
  GId = $45524C45;

{ TLMDRegExpr }

procedure TLMDRegExpr.Compile;
begin
  FRegExprEngine.Compile;
end;

procedure TLMDRegExpr.Study;
begin
  // nothing to do.. deprecated
end;

constructor TLMDRegExpr.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegExprEngine := TLMDRegExp.Create;
  FOptions := TLMDRegOptions.Create;
  FOptions.FOnChange := DoChange;
end;

destructor TLMDRegExpr.Destroy;
begin
  FRegExprEngine.Free;
  FOptions.Free;
  inherited;
end;

function TLMDRegExpr.Exec: boolean;
begin
  Result := FRegExprEngine.Exec;
end;

function TLMDRegExpr.Exec(const AInputText: TLMDString): Boolean;
begin
  FRegExprEngine.InputText := AInputText;
  Result := FRegExprEngine.Exec;
end;

function TLMDRegExpr.ExecPos(AStartOffs: integer): boolean;
begin
  Result := FRegExprEngine.Exec(AStartOffs);
end;

function TLMDRegExpr.ExecNext: Boolean;
begin
  Result := FRegExprEngine.ExecNext;
end;

procedure TLMDRegExpr.Split(AInputText: TLMDString; AResult: TLMDStrings);
begin
  FRegExprEngine.InputText := AInputText;
  Split(AResult);
end;

procedure TLMDRegExpr.Split(AResult: TLMDStrings);
begin
  AResult.BeginUpdate;
  try
    AResult.Clear;
    FRegExprEngine.Split(AResult);
  finally
    AResult.EndUpdate;
  end;
end;

function TLMDRegExpr.Substitute(const ATemplate: TLMDString): TLMDString;
begin
  Result := FRegExprEngine.Substitute(ATemplate);
end;

function TLMDRegExpr.Replace(const AReplace: TLMDString; AUseTemplates: Boolean): TLMDString;
begin
  Result := FRegExprEngine.Replace(AReplace, AUseTemplates);
end;

function TLMDRegExpr.Replace(const AInputText: TLMDString; const AReplace: TLMDString; AUseTemplates: Boolean): TLMDString;
begin
  FRegExprEngine.InputText := AInputText;
  Result := Replace(AReplace, AUseTemplates);
end;

function TLMDRegExpr.GetMatch(i: Integer): TLMDString;
begin
  Result := FRegExprEngine.Match[i];
end;

function TLMDRegExpr.GetMatchLen(i: Integer): integer;
begin
  Result := FRegExprEngine.MatchLen[i];
end;

function TLMDRegExpr.GetMatchPos(i: Integer): integer;
begin
  Result := FRegExprEngine.MatchPos[i];
end;

function TLMDRegExpr.GetNumMatches: Integer;
begin
  Result := FRegExprEngine.MatchCount + 1;
end;

procedure TLMDRegExpr.SetExpr(const Value: TLMDRegExString);
begin
  if Value <> FRegExprEngine.Expression then
    FRegExprEngine.Expression := Value;
end;

function TLMDRegExpr.GetExpr: TLMDRegExString;
begin
  Result := FRegExprEngine.Expression;
end;

function TLMDRegExpr.GetInputText: TLMDString;
begin
  Result := FRegExprEngine.InputText;
end;

procedure TLMDRegExpr.SetInputText(const Value: TLMDString);
begin
  FRegExprEngine.InputText := Value;
end;

procedure TLMDRegExpr.DoChange(Sender: TObject);
begin
  FRegExprEngine.ModifierG := not FOptions.eroUngreedyMode;
  FRegExprEngine.ModifierS := FOptions.eroSingleLine;
  FRegExprEngine.ModifierM := FOptions.eroMultiLine;
  FRegExprEngine.ModifierI := FOptions.eroCaseLess;
  FRegExprEngine.ModifierX := FOptions.eroExtendedMode;
end;

procedure TLMDRegExpr.LoadFromStream(AStream: TStream);
var
  LHdr: TLMDRegExpHeader;
  LStr: TLMDString;
begin
  AStream.Read(LHdr, SizeOf(LHdr));
  if LHdr.Id = GId then
  begin
    Options.FFlags := LHdr.Flags;
    LMDReadStringFromStream(AStream, LStr);
    FRegExprEngine.Expression := LStr;
    LMDReadStringFromStream(AStream, LStr);
    FRegExprEngine.InputText := LStr;
  end;
end;

procedure TLMDRegExpr.SaveToStream(AStream: TStream);
var
  LHdr: TLMDRegExpHeader;
  LStr: TLMDString;
begin
  LHdr.Id := GId;
  LHdr.Flags := Options.Flags;
  AStream.Write(LHdr, SizeOf(LHdr));
  LStr := FRegExprEngine.Expression;
  LMDWriteStringToStream(AStream, LStr);
  LStr := FRegExprEngine.InputText;
  LMDWriteStringToStream(AStream, LStr);
end;

procedure TLMDRegExpr.LoadFromFile(AFileName: TLMDString);
var
  LFile: TLMDFileStream;
begin
  LFile := TLMDFileStream.Create(AFileName, fmOpenRead);
  LoadFromStream(LFile);
  LFile.Free;
end;

procedure TLMDRegExpr.SaveToFile(AFileName: TLMDString);
var
  LFile: TLMDFileStream;
begin
  LFile := TLMDFileStream.Create(AFileName, fmCreate, fmShareDenyWrite);
  SaveToStream(LFile);
  LFile.Free;
end;

{ TLMDRegOptions }
const
  // Options
  PCRE_CASELESS = $0001;
  PCRE_MULTILINE = $0002;
  PCRE_DOTALL = $0004;
  PCRE_EXTENDED = $0008;
  PCRE_ANCHORED = $0010;
  PCRE_DOLLAR_ENDONLY = $0020;
  PCRE_EXTRA = $0040;
  PCRE_NOTBOL = $0080;
  PCRE_NOTEOL = $0100;
  PCRE_UNGREEDY = $0200;
  PCRE_NOTEMPTY = $0400;
  PCRE_UTF8 = $0800;
  PCRE_NO_AUTO_CAPTURE = $1000;

constructor TLMDRegOptions.Create;
begin
  inherited Create;
  FFlags := PCRE_CASELESS or PCRE_EXTENDED or PCRE_DOTALL;
end;

function TLMDRegOptions.GetCaseLess: Boolean;
begin
  Result := ((FFlags and not PCRE_CASELESS) <> FFlags);
end;

function TLMDRegOptions.GetExtended: Boolean;
begin
  Result := ((FFlags and not PCRE_EXTENDED) <> FFlags);
end;

function TLMDRegOptions.GetMultiLine: Boolean;
begin
  Result := ((FFlags and not PCRE_MULTILINE) <> FFlags);
end;

function TLMDRegOptions.GetSingleLine: Boolean;
begin
  Result := ((FFlags and not PCRE_DOTALL) <> FFlags);
end;

function TLMDRegOptions.GetUngreedy: Boolean;
begin
  Result := ((FFlags and not PCRE_UNGREEDY) <> FFlags);
end;

function TLMDRegOptions.GetUTF8: Boolean;
begin
  Result := ((FFlags and not PCRE_UTF8) <> FFlags);
end;

procedure TLMDRegOptions.SetCaseLess(const Value: Boolean);
begin
  if Value then
    FFlags := FFlags or PCRE_CASELESS
  else
    FFlags := FFlags and not PCRE_CASELESS;
  TriggerChange;
end;

procedure TLMDRegOptions.SetExtended(const Value: Boolean);
begin
  if Value then
    FFlags := FFlags or PCRE_EXTENDED
  else
    FFlags := FFlags and not PCRE_EXTENDED;
  TriggerChange;
end;

procedure TLMDRegOptions.SetMultiLine(const Value: Boolean);
begin
  if Value then
    FFlags := FFlags or PCRE_MULTILINE
  else
    FFlags := FFlags and not PCRE_MULTILINE;
  TriggerChange;
end;

procedure TLMDRegOptions.SetSingleLine(const Value: Boolean);
begin
  if Value then
    FFlags := FFlags or PCRE_DOTALL
  else
    FFlags := FFlags and not PCRE_DOTALL;
  TriggerChange;
end;

procedure TLMDRegOptions.SetUngreedy(const Value: Boolean);
begin
  if Value then
    FFlags := FFlags or PCRE_UNGREEDY
  else
    FFlags := FFlags and not PCRE_UNGREEDY;
  TriggerChange;
end;

procedure TLMDRegOptions.SetUTF8(const Value: Boolean);
begin
  if Value then
    FFlags := FFlags or PCRE_UTF8
  else
    FFlags := FFlags and not PCRE_UTF8;
  TriggerChange;
end;

procedure TLMDRegOptions.TriggerChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{$IFNDEF LMD_UNICODE}
var
  c: TLMDChar;
{$ENDIF}

initialization
  RegExprLineSeparators := LMDCRLF;
  RegExprLinePairedSeparator := LMDCRLF;

  // Any modification must be synchronized with QuoteRegExprMetaChars !!!
  META := '^$.[()|?+*{'+EscChar;
  QUANTIFIERS_BEG := '*+?{';

  //Stupid Delphi6
  RegExprSpaceChars := LMDSpace;
  RegExprSpaceChars := RegExprSpaceChars + LMDTab;

{$IFNDEF LMD_UNICODE}

  //Here we fill for current OEM locale:
  //  RegExprWordChars, RegExprNumberChars
  for c := Low(TLMDChar) to High(TLMDChar) do
  begin
    if LMDAnsiIsNumeric(c) then
    begin
      RegExprNumberChars := RegExprNumberChars + c;
      RegExprWordChars := RegExprWordChars + c
    end
    else if LMDAnsiIsAlpha(c) then
      RegExprWordChars := RegExprWordChars + c
  end;

  RegExprWordChars := RegExprWordChars + '_';

{$ENDIF}

end.
