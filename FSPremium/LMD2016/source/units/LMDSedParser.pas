unit LMDSedParser;
{$I LMDCmps.inc}
{$IFDEF LMD_DEBUG} {$R+} {$ENDIF}

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

LMDSedParser unit (VT)
----------------------
This unit contains the parser for LMD-Tools Syntax Edit packages.

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, LMDTypes, LMDSedDocument, LMDHashTable, LMDXml, LMDRegExpr;

type
  ELMDEditParserError       = class(Exception);
  ELMDSyntaxSchemeLoadError = class(ELMDEditParserError);
  ELMDColorSchemeLoadError  = class(ELMDEditParserError);

  {******************************** TLMDParser ********************************}

  TLMDEditParserSchemeLoader = function(
    const ASchemeName: TLMDString): TLMDString of object;

  TLMDEditParser = class(TLMDEditParserBase)
  private
    FImpl: TObject;

    function GetSchemesDir: TLMDString;
    function GetAttrsDir: TLMDString;

    procedure SetSchemesDir(ADir: TLMDString);
    procedure SetAttrsDir(ADir: TLMDString);

  protected
    procedure SetDocument(ADoc: TLMDEditDocument); override;
  public
    constructor Create;
    destructor Destroy; override;

    procedure UnloadSchemes;
    procedure LoadSchemeDoc(const ADocName, AttrsDocName: TLMDString);
    procedure SetSchemeLoaders(ASyntaxLoader, AColorLoader: TLMDEditParserSchemeLoader);

    procedure MarkTokens(ALine: Integer; const AHandler: TLMDTokenHandler); override;

    function  GetParsedLine(ALine: Integer): TLMDEditParsedLine; override;

    procedure LineChanged(ALine: Integer); override;
    procedure LinesChangedFrom(AStart: Integer); override;
    procedure Refresh; override;

    function  GetParentLine(ALine: Integer): Integer; override;
    function  GetFoldEnd(ALineStart: Integer): Integer; override;
    function  GetFoldStart(ALineEnd: Integer): Integer; override;

    function  IsFoldStart(ALine: Integer): Boolean; override;
    function  IsFoldEnd(ALine: Integer): Boolean; override;

    procedure  EnsureLineParsed(ALine: Integer); override;

    function  GetAllTokenIDs(const ATokenName: TLMDString): TLMDIntArray; override;

    procedure SetMaxLineLengthToParse(AValue: Integer); override;

    property SchemesDir: TLMDString read GetSchemesDir write SetSchemesDir;
    property AttrsDir:  TLMDString read GetAttrsDir write SetAttrsDir;
  end;

  procedure LMDDecodeTokenXML(const ANode: ILMDXmlNode;
                              var Attrs: TLMDEditAttributes;
                              var AName: TLMDString);

implementation
uses
  Contnrs, Math, Graphics, Windows, LMDUnicode, LMDArrayUtils,
  LMDStack, LMDStrings, LMDProcs, LMDSedConst, LMDSedUtils;

{$IFDEF LMDDEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

type
  TKeywordMap = class;
  TParserImpl = class;

  {******************************** TTokenProps *******************************}

  TTokenProps = class
  public
    Name:             TLMDString;
    ID:               Integer;
    Attributes:       TLMDEditAttributes;
    DefaultContentID: Integer;
    ContentMap:       TKeywordMap;
    ContentMapCI:     TKeywordMap;
  public
    constructor Create(const ANode: ILMDXmlNode=nil); overload;
    destructor Destroy; override;
  end;

  TTokenPropsArray = array of TTokenProps;

  {******************************** TKeywordMap *******************************}

  TKeyword = class
  public
    ID:   Integer;
    Word: TLMDString;
    Next: TKeyword;
  end;

  TKeywordMap = class
  private
    FIndexMask:   Integer;
    FCount:       Integer;
    FIgnoreCase:  Boolean;
    FMap:         array of TKeyword;

    procedure Grow;
    procedure Rehash(AOldLength: Integer);

    function KeywordEquals(AKw: TKeyword; const AStr: TLMDString): Boolean; overload;
    function KeywordEquals(AKw: TKeyword; const ASeq: TLMDCharSeq;
                           AStart, ACount: Integer): Boolean; overload;

    procedure InsertKw(const AKw: TKeyword); overload;
  public
    constructor Create(AIgnoreCase: Boolean);
    destructor Destroy; override;

    procedure AddWord(const AWord: TLMDString); overload;
    function Contains(const AStr: TLMDString): Boolean;

    function GetKeyword(const AStr: TLMDString): TKeyword; overload;
    function GetKeyword(const ASeq: TLMDCharSeq;
                        AStart, ACount: Integer): TKeyword; overload;
  end;

  {************************** TScheme related classes *************************}

  TScheme = class;

  // Ends are indexes 'after the end' of corresponding token.
  //
  // Starts and ends should be sorted and should not overlap (in opposite to
  // TRegexp.Match[..]). Also, all Starts and Ends should be valid indexes.

  TMatchRec = record
    Starts:     array of Integer;
    Ends:       array of Integer;
    Count:      Integer;
    InnerStart,
    InnerCount: Integer;
  end;

  TRulePart = (rpBegin, rpEnd);

  TRuleBase = class
  public
    Priority:              Integer;
    AcceptedAnsiChars:     TLMDSetOfByte;
    AcceptUnicodeChars:    Boolean;
    EndAcceptedAnsiChars:  TLMDSetOfByte;
    EndAcceptUnicodeChars: Boolean;
  end;

  TRulePartsTokens = array[rpBegin..rpEnd] of TTokenPropsArray;
  TRuleHasTokens = array[rpBegin..rpEnd] of Boolean;

  TRule = class(TRuleBase)
  private
    FXml:               TLMDString;
    FScheme:            TScheme;
    FInnerContentGroup: Integer;

    procedure SetupRulePartArray(APart: TRulePart; ACount: Integer);
    constructor Create(const ANode: ILMDXmlNode; const AScheme: TScheme;
                       ADefPriority: Integer);
  public
    Name: TLMDString;

    Tokens:          TRulePartsTokens;
    HasTokens:       TRuleHasTokens;
    InnerSchemeName: TLMDString;
    InnerScheme:     TScheme;
    CloseInnerSchemesOnMatchEnd: Boolean;

    ChainedBlockRule: TRule;
    ChainedBlockRuleName:   TLMDString;

    IsBlockRule:     Boolean;
  public
    function Match(AStart, ACount: Integer;
                   AParserState: Integer;
                   var Match: TMatchRec): Boolean; virtual; abstract;

    function MatchEnd(AStart, ACount: Integer;
                      AParserState: Integer;
                      var Match: TMatchRec): Boolean; virtual; abstract;

    class function CreateRule(const ANode: ILMDXmlNode; AScheme: TScheme): TRule;

    function  NeedVariables: Boolean; virtual;
    procedure BindVariables(AFiller: TLMDRegExprVariableGetter); virtual;
    function  MaxVarId: Integer; virtual;
    function  GetVariable(AId: Integer; var AStart, ACount: Integer): Boolean; virtual;
  end;

  TRulesArray  = array of TRule;
  TSyntaxBlock = class;

  TRuleRef = class
  public
    Rule:     TRule;
    SynBlock: TSyntaxBlock;
    Next:     TRuleRef;
  end;

  TRulesHash = class
  private
    FAnsiHashSize: Integer;
    FAnsiHash:     array of TRuleRef;
    FUnicodeRules: TRuleRef;
  public
    Count: Integer;
  public
    constructor Create;
    destructor  Destroy; override;

    procedure Clear;
    procedure AddRule(ARuleBase: TRuleBase; ARule: TRule; ASynBlock: TSyntaxBlock);
    function  GetRuleChain(ACode: Integer): TRuleRef;
  end;

  TSyntaxBlock = class(TRuleBase)
  private
    FParser: TParserImpl;
    FXml:    TLMDString;
  public
    MinLines:       Integer;
    Capture:        Boolean;
    StartRegex:     TLMDRegExp;
    EndRegex:       TLMDRegExp;
    StartGroupUsed: Integer;
    EndGroupUsed:   Integer;
  public
    constructor Create(const ANode: ILMDXmlNode; AScheme: TScheme);
    destructor Destroy; override;

    function CreateRe(const AStr: TLMDString): TLMDRegExp;
  end;

  TScheme = class
  private
    FParser:          TParserImpl;
    FLoading:         Boolean;
    FRules:           TRulesArray;
    FSyntaxBlocks:    array of TSyntaxBlock;
    FSynTokensToSkip: TLMDString;
  public
    AllIgnoreCase:      Boolean;
    SkipSyntaxTokens:   array of Boolean;
    Name:               TLMDString;
    ParentSchemes:      array of TScheme;
    ParentSchemeNames:  array of TLMDString;
    DefaultToken:       TTokenProps; // Reference. Don't destroy.
    Keywords:           TKeywordMap;
    KeywordsIgnoreCase: Boolean;
    RulesHash:          TRulesHash;
    SynBlocksHash:      TRulesHash;
    SyntaxTailMaxLength: Integer;

    MoreWordSeparators: TLMDString;
    MoreWordChars: TLMDString;
  public
    constructor Create(const ANode: ILMDXmlNode;
                       const ADocName: TLMDString;
                       const AParser: TParserImpl);
    destructor  Destroy; override;

    function  FindRule(const AName: TLMDString): TRule;
    procedure AddRule(ARule: TRule);
    procedure SetupRuleChains;
    procedure SetupRuleBlockChains;
    procedure SetupSynChains;
    procedure SetupSkipTokens;
  end;

  {******************************** TParserNode *******************************}

  TParserNode = class
  public
    StartLine:    Integer;
    EndLine:      Integer;
    Parent:       TParserNode;
    SchemeParent: TParserNode;
    Childs:       array of TParserNode;
    ChildCount:   Integer;
  public
    constructor Create;
  end;

  {******************************** TParserTree *******************************}

  TParserTree = class
  private
    FStartsHash: TLMDHashTable;
    FEndsHash:   TLMDHashTable;

    procedure SetChildCount(ANode: TParserNode; ACount: Integer);
    procedure FreeNode(ANode: TParserNode);
    procedure FreeNodeRec(AParent: TParserNode);
  public
    Root:          TParserNode;
    LastKnownLine: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    function LineStartToNode(ALine: Integer): TParserNode; // Returns nil, if line is not start of node.
    function LineEndToNode(ALine: Integer): TParserNode;   // Returns nil, if line is not end of node.

    function  FindParent(ALine: Integer): TParserNode;
    function  AddAsLast(AParent: TParserNode; ALine: Integer): TParserNode;
    procedure CommitLastNode(ANode: TParserNode);
    procedure KillFrom(ALine: Integer);
  end;

  {******************************* TContextItem *******************************}

  TPartBlockKind = (pbStart, pbEnd, pbNothing);

  TOpenBlock = record
    Block:          TSyntaxBlock;
    StartLine:      Integer;
    EndLine:        Integer;
    HasNode:        Boolean;
    DontCreateNode: Boolean;

    Variables:      array of TLMDIntArray;
  end;

  TContextItem = class
  public
    Prev:                     TContextItem;
    CheckEndParentContext:    Boolean;

    EndOfScheme:              Integer;
    Scheme:                   TScheme; // TParserContextItem does not owns scheme.
    SchemeEndRule:            TRule;
    CurrentOpenNode:          TParserNode;
    ParentNode:               TParserNode;
    SyntaxTail:               TLMDIntArray;
    SyntaxTailCount:          Integer;
    SyntaxTailPos:            Integer;
    PartBlock:                TSyntaxBlock;
    PartRef:                  TRuleRef;
    PartBlockKind:            TPartBlockKind;
    PartBlockFirstLine:       Integer;
    PartBlockLastLine:        Integer;

    DefaultAttributes:        TLMDEditAttributes;
    OwnsCustomAttributes:     Boolean;

    OpenSyntaxBlocks:         array of TOpenBlock;
    OpenSyntaxBlocksCount:    Integer;
    Variables:                array of TLMDSegment;
  public
    constructor Create;
    destructor  Destroy; override;

    procedure Clear;
    procedure Assign(AOther: TContextItem);

    procedure GetVariable(AId: Integer; var ARes: TLMDIntArray);
    procedure GetSyntaxVariable(AId: Integer; var ARes: TLMDIntArray);
  end;

  {******************************* TParserContext *****************************}

  TParserContext = class
  private
    FItemsLast:   TContextItem;
    FTrash:       TContextItem;
    FTrashCount:  Integer;
    FTrashMax:    Integer;
    FItemsCount:  Integer;

    procedure TailItem(AItem: TContextItem; var ATail: TContextItem);
  public
    Line:         Integer;
    LastTreeLine: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Push(const AItem: TContextItem);
    procedure Pop;
    function LastItem: TContextItem;
    function Count: Integer;

    function Clone: TParserContext;

    function CloneItem(AItem: TContextItem): TContextItem;
    function CreateItem: TContextItem;

    procedure Clear;
  end;

  {****************************** TSynRegexSource *****************************}

  TSynRegexSource = class (TLMDRegexSource)
  private
    FCtxItem: TContextItem;
  protected
    procedure FillBuffer; override;
  public
    procedure Bind(ACtxItem: TContextItem);

    procedure Reset;
  end;

  {***************************** TCharsRegexSource ****************************}

  TCharsRegexSource = class(TLMDRegexSource)
  protected
    FSeq: TLMDCharSeq;
    procedure FillBuffer; override;
  public
    constructor Create;

    procedure Bind(const ASeq: TLMDCharSeq; AStart, AEnd: Integer);
  end;

  {******************************** TContextCache *****************************}

  TSchemesArray = array of TScheme;

  TContextCache = class
  private
    // [start0, Context0], [start1, Context1] .. [startN, ContextN],
    // [Lines.Count, nil] <-- Bound element.
    FItems:      array of TParserContext;
    FItemsCount: Integer;

    function FindContextId(ALine: Integer): Integer;
  public
    constructor Create;
    destructor Destroy; override;

    // Return: Result.Line <= ALine.
    function GetContext(ALine: Integer): TParserContext;

    function GetLastContext: TParserContext;

    // TContextCache will own AContext.
    procedure AddContext(ALine: Integer; AContext: TParserContext);

    // Kill cache items below ALine.
    procedure KillFrom(ALine: Integer);
  end;

  {******************************** TTokensLineItem ***************************}

  TTokenLineItem = record
    Token:             TTokenProps;
    RuntimeAttributes: TLMDEditAttributes;
    OwnsCustomAttrs:   Boolean;
    Start:             Integer;
    Count:             Integer;
  end;

  {********************************** TTokenLine ******************************}

  TTokenLine = class(TLMDEditParsedLine)
  private
    FPrev: TTokenLine;
    FNext: TTokenLine;

    FTokens:     array of TTokenLineItem;
    FTokenCount: Integer;

    FChars: TLMDCharSeq;
  public
    Line:       Integer;

    constructor Create;

    procedure  AddItem(const AItem: TTokenLineItem);
    procedure  Clear;

    function TokenCount: Integer; override;

    function GetTokenIdx(ACol: Integer): Integer; override;

    function GetTokens(AStart, ACount: Integer;
                       var Arr: TLMDEditParsedTokenArray): Integer; override;
  end;

  {******************************* TTokenLineTraits ***************************}

  TTokenLineTraits = class(TLMDHashTableTraits)
  public
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

  {********************************* TTokenCache ******************************}

  TTokenCacheItem = class
  public
    TokLine: TTokenLine;
    Next: TTokenCacheItem;
  end;

  TTokenCacheItemArr = array of TTokenCacheItem;

  TTokenCache = class
  private
    FCount:     Integer;
    FHashCount: Integer;
    FHash: TTokenCacheItemArr;
    FHashMask: Integer;

    FTrashTail: TTokenLine;
    FListHead:  TTokenLine;
    FListTail:  TTokenLine;

    procedure Detach(ALine: TTokenLine);
    procedure MoveToHead(ALine: TTokenLine);
    procedure MoveToTrash(ALine: TTokenLine);

    procedure HashFree;
    procedure HashRemove(ALine: Integer);
    procedure HashAdd(ALine: TTokenLine);
    function  HashFind(ALine: Integer): TTokenLine;
  public
    MaxCount: Integer;
  public
    constructor Create(AMaxSize: Integer);
    destructor Destroy; override;

    function  GetLine(ALine: Integer): TTokenLine;
    function  CreateLine(ALine: Integer; AChars: TLMDCharSeq): TTokenLine;
    procedure KillFrom(ALine: Integer);
  end;

  {******************************** TParserImpl *******************************}

  TParserImpl = class
  private
    FDoc:                       TLMDEditDocument;
    FSyntaxLoader:              TLMDEditParserSchemeLoader;
    FColorLoader:               TLMDEditParserSchemeLoader;
    FContextSaveInterval:       Integer;
    FMatch:                     TMatchRec;
    FMaxSubExp:                 Integer;

    FMaxLineLengthToParse:      Integer;
    FMaxLnTokens:               TRulePartsTokens;

    FSchemeLoaded:              Boolean;
    FParseTree:                 TParserTree;
    FChars:                     TLMDCharSeq;
    FCharsInput:                TCharsRegexSource;
    FSyntaxInput:               TSynRegexSource;
    FIgnoredChars:              TLMDCharSet;
    FTokenID:                   Integer;
    FTokenKeyword:              TTokenProps;
    FTokenProps:                TLMDMemoryStrings;
    FInheritPath:               TLMDMemoryStrings;
    FSchemesDir:                TLMDString;
    FAttrsDir:                  TLMDString;
    FContextCache:              TContextCache;
    FTokenCache:                TTokenCache;
    FSchemes:                   TSchemesArray;
    FRootSc:                    TScheme;
    FCurScheme:                 TScheme;
    FCurRule:                   TRule;
    FCurBlock:                  TSyntaxBlock;
    FCurDocName,
    FCurDocPath:                TLMDString;
    FLastValidLine:             Integer;
    FOldVars:                   array of TLMDSegment;

    FDummyTokLine:              TTokenLine;

    function CreateRe(const AStr: TLMDString): TLMDRegExp;
    function GetSchemeByName(const AName: TLMDString): TScheme;
    procedure AddScheme(AScheme: TScheme);
    procedure ClearSchemes;

    procedure SetCurrentDoc(const AName, APath: TLMDString);
    procedure SetCurrentScheme(AScheme: TScheme);
    procedure SetCurrentRule(ARule: TRule; ASynRule: TSyntaxBlock);

    procedure RaiseSyntaxSchemeError(const AMessage: TLMDString);
    procedure RaiseSyntaxDocError(const AMessage: TLMDString);
    procedure RaiseSyntaxSchemeErrorF(const AMessage: TLMDString; const Args: array of const);
    procedure RaiseSyntaxDocErrorF(const AMessage: TLMDString; const Args: array of const);

    procedure KillCachesFrom(ALine: Integer);
    procedure BuildCachesFrom(ALine: Integer);

    function GetAttrsDir: TLMDString;
    procedure LoadBaseTokenAtts(const AttrsDocName: TLMDString);

    function GetTokenProps(const ATokenName: TLMDString): TTokenProps;
    function AddTokenProps(AProps: TTokenProps): Integer;
    function FindTokenID(const ATokenName: TLMDString): Integer;
    function MaxTokenID: Integer;

    function ResolveIntCode(const ACodeName: TLMDString): Integer;


  public
    constructor CreateImpl(ATokenCacheSize, AContextSaveInterval: Integer);
    destructor Destroy; override;

    procedure LoadSchemeDoc(const ADocName, AttrsDocName: TLMDString);
    procedure UnloadSchemes;

    procedure SetSchemeLoaders(ASyntaxLoader, AColorLoader: TLMDEditParserSchemeLoader);

    procedure SetDocument(ADoc: TLMDEditDocument);

    procedure SetMaxLineLengthToParse(AValue: Integer);

    procedure MarkTokens(ALine: Integer;
                         AHandler: TLMDTokenHandler);

    function  GetParsedLine(ALine: Integer): TLMDEditParsedLine;

    procedure LineChanged(ALine: Integer);
    procedure LinesChangedFrom(AStart: Integer);
    procedure Refresh;

    function  GetParentLine(ALine: Integer): Integer;
    function  GetFoldEnd(ALineStart: Integer): Integer;
    function  GetFoldStart(ALineEnd: Integer): Integer;

    function  IsFoldStart(ALine: Integer): Boolean;
    function  IsFoldEnd(ALine: Integer): Boolean;
    procedure EnsureLineParsed(ALine: Integer);

    function  GetAllTokenIDs(const ATokenName: TLMDString): TLMDIntArray;

    function  IsSchemeLoaded: Boolean;

    property SchemesDir: TLMDString read FSchemesDir write FSchemesDir;
    property AttrsDir:  TLMDString read GetAttrsDir write FAttrsDir;
  end;

  {******************************* TRegexRule *********************************}

  TRegexRule = class (TRule)
  private
    StartRegex,
    EndRegex:   TLMDRegExp;
    LineBound:  Boolean;

    procedure MakeMatch(ARegex: TLMDRegExp; var Match: TMatchRec;
                        APart: TRulePart);
  public
    constructor Create(const ANode: ILMDXmlNode; AScheme: TScheme);
    destructor Destroy; override;

    function Match(AStart, ACount: Integer;
                   AParserState: Integer;
                   var Match: TMatchRec): Boolean; override;
    function MatchEnd(AStart, ACount: Integer;
                      AParserState: Integer;
                      var Match: TMatchRec): Boolean; override;

    function  NeedVariables: Boolean; override;
    procedure BindVariables(AFiller: TLMDRegExprVariableGetter); override;

    function  MaxVarId: Integer; override;
    function  GetVariable(AId: Integer; var AStart, ACount: Integer): Boolean; override;
  end;

  {******************************* TKeywordsRule ******************************}

  TKeywordsRule = class (TRule)
  public
    Regex: TLMDRegExp;
  public
    constructor Create(const ANode: ILMDXmlNode; const AScheme: TScheme);
    destructor Destroy; override;

    function Match(AStart, ACount: Integer;
                   AParserState: Integer;
                   var Match: TMatchRec): Boolean; override;
    function MatchEnd(AStart, ACount: Integer;
                      AParserState: Integer;
                      var Match: TMatchRec): Boolean; override;
  end;

  TRegexCreator = function(const AStr: TLMDString): TLMDRegExp of object;

  {********************** TParserNodeStartTraits  *****************************}

  TParserNodeStartTraits = class(TLMDHashTableTraits)
  public
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

  {*********************** TParserNodeEndTraits *******************************}

  TParserNodeEndTraits = class(TLMDHashTableTraits)
  public
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

{------------------------------------------------------------------------------}

const
  PARSER_STATE_LINE_BOUND = 1;
  SYNTAX_TAIL_MAX_LENGTH = 500;
var
  DIVIDERS: TLMDString;
  SCHEME_DOC_EXTENSION: TLMDString;
  SCHEME_DOC_SEPARATOR: TLMDString;

{------------------------------------------------------------------------------}

function GetInt(const ANode: ILMDXmlNode; Attr: TLMDString;
  AParser: TParserImpl; AMin: Integer = 0; AMax: Integer = MAXINT): Integer;
begin
  Result := -1;
  try
    if not ANode.AttrExists(Attr) then
      AParser.RaiseSyntaxSchemeErrorF(SLMDSedIntAttirbuteRequired, [Attr]);

    Result := StrToInt(ANode.GetAttr(Attr));

    if not LMDInRange(Result, AMin, AMax) then
      AParser.RaiseSyntaxSchemeErrorF(SLMDSedIntAttrRangeRequired,
                                      [Attr, Result, AMin, AMax]);
  except
    on E: EConvertError do
      AParser.RaiseSyntaxSchemeErrorF(SLMDSedBadIntAttribute, [Attr]);
  end;
end;

{------------------------------------------------------------------------------}

procedure AssignAttrs(var ADest: TLMDEditAttributes;
                      var ADestOwnsCustom: Boolean;
                      const ASrc: TLMDEditAttributes;
                      const ASrcOwnsCustom: Boolean);
begin
  if ASrcOwnsCustom then
  begin
    if ADestOwnsCustom then
    begin
      Assert(ADest.CustomAttributes<>nil);
      ADest.CustomAttributes.Assign(ASrc.CustomAttributes);
    end
    else
    begin
      ADestOwnsCustom := true;
      ADest.CustomAttributes := ASrc.CustomAttributes.Clone;
    end;
  end
  else
  begin
    if ADestOwnsCustom then
    begin
      Assert(ADest.CustomAttributes<>nil);
      ADest.CustomAttributes.Free;
    end;

    ADest.CustomAttributes := ASrc.CustomAttributes;

    ADestOwnsCustom := false;
  end;

  ADest.BackgroundColor := ASrc.BackgroundColor;
  ADest.TextColor := ASrc.TextColor;
  ADest.FontStyle := ASrc.FontStyle;
  ADest.AttributesSet := ASrc.AttributesSet;
end;

{------------------------------------------------------------------------------}

procedure FreeAttrs(var Attrs: TLMDEditAttributes;
                    var OwnsCustom: Boolean);
begin
  if Attrs.CustomAttributes<>nil then
  begin
    Assert(asCustomAttributes in Attrs.AttributesSet);

    if OwnsCustom then
      Attrs.CustomAttributes.Free;
  end;

  Attrs.AttributesSet := [];
  Attrs.CustomAttributes := nil;
  OwnsCustom := false;
end;

{------------------------------------------------------------------------------}

procedure InitAttrs(out Attrs: TLMDEditAttributes;
                    out OwnsCustom: Boolean);
begin
  Attrs.CustomAttributes := nil;

  Attrs.BackgroundColor := 0;
  Attrs.TextColor := 0;
  Attrs.FontStyle := [];
  Attrs.AttributesSet := [];

  OwnsCustom := false;
end;

{------------------------------------------------------------------------------}

function GetBool(const ANode: ILMDXmlNode; Attr: TLMDString;
                 AParser: TParserImpl): Boolean;
var
  R: TLMDString;
begin
  if not ANode.AttrExists(Attr) then
    AParser.RaiseSyntaxSchemeErrorF(SLMDSedBoolAttributeRequired, [Attr]);

  Result := False;
  R := LMDLowerCase(ANode.GetAttr(Attr));
  if (R='1') or (R='true') then
    Result := True
  else if (R<>'0') and (R<>'false') then
    AParser.RaiseSyntaxSchemeErrorF(SLMDSedBadBoolAttribute, [Attr]);
end;

{------------------------------------------------------------------------------}

function GetRegexGen(const ANode, ASubNode: ILMDXmlNode;
  const AttrName: TLMDString; AParser: TParserImpl;
  AIgnoreCase, AOptional: Boolean;
  ACreator: TRegexCreator=nil): TLMDRegExp; overload;
var
  re: TLMDString;
begin
  Result := nil;
  try
    re := ANode.GetAttr(AttrName);
    if (re='') and (ASubNode <> nil) then
      re := ASubNode.Text;

    if re = '' then
    begin
      if AOptional then
        Exit;

      if ASubNode = nil then
        AParser.RaiseSyntaxSchemeErrorF(SLMDSedEmptyRegexAttribute,
                                        [AttrName, ANode.NodeName])
      else if ASubNode <> ANode then
        AParser.RaiseSyntaxSchemeErrorF(SLMDSedEmptyRegexSubNode,
                                        [ASubNode.NodeName, ANode.NodeName])
      else
        AParser.RaiseSyntaxSchemeErrorF(SLMDSedEmptyRegexNodeText,
                                        [AttrName, ANode.NodeName]);
    end;

    if not Assigned(ACreator) then
      Result := AParser.CreateRe(re)
    else
      Result := ACreator(re);

    if not Result.ModifierC then
    begin
      Result.ModifierI := AIgnoreCase;
      Result.Compile;
    end;
  except
    on E: ELMDRegExprError do
    begin
      Result := nil;

      if ASubNode = nil then
        AParser.RaiseSyntaxSchemeErrorF(SLMDSedBadRegexAttribute,
          [AttrName, ANode.NodeName, re, E.Message])
      else if ASubNode <> ANode then
        AParser.RaiseSyntaxSchemeErrorF(SLMDSedBadRegexSubNode,
          [ASubNode.NodeName, ANode.NodeName, re, E.Message])
      else
        AParser.RaiseSyntaxSchemeErrorF(SLMDSedBadRegexNodeText,
          [ANode.NodeName, re, E.Message]);
    end;
  end;
end;

{------------------------------------------------------------------------------}

function GetRegex(const ANode, ASubNode: ILMDXmlNode;
  const AttrName: TLMDString; AParser: TParserImpl;
  AIgnoreCase: Boolean;
  ACreator: TRegexCreator=nil): TLMDRegExp; overload;
begin
  result := GetRegexGen(ANode, ASubNode, AttrName, AParser,
                        AIgnoreCase, false, ACreator);
end;

{------------------------------------------------------------------------------}

function GetRegex(const ANode: ILMDXmlNode;
  const ASubNodeName, AttrName: TLMDString; AParser: TParserImpl;
  AIgnoreCase: Boolean;
  ACreator: TRegexCreator = nil): TLMDRegExp; overload;
var
  SubNode: ILMDXmlNode;
begin
  if ASubNodeName<>'' then
    SubNode := ANode.SelectSingleNode(ASubNodeName)
  else
    SubNode := nil;

  Result := GetRegexGen(ANode, SubNode, AttrName, AParser, AIgnoreCase, false, ACreator);
end;

function GetRegexOpt(const ANode: ILMDXmlNode;
                     const ASubNodeName, AttrName: TLMDString;
                     AParser: TParserImpl;
                     AIgnoreCase: Boolean;
                     ACreator: TRegexCreator = nil): TLMDRegExp; overload;
var
  SubNode: ILMDXmlNode;
begin
  if ASubNodeName <> '' then
    SubNode := ANode.SelectSingleNode(ASubNodeName)
  else
    SubNode := nil;

  Result := GetRegexGen(ANode, SubNode, AttrName, AParser,
                        AIgnoreCase, true, ACreator);
end;

const MoreWordSeparatorsAttr: TLMDString = 'moreWordSeparators';
const MoreWordCharsAttr: TLMDString = 'moreWordChars';

function FirstChUpper(const AStr: TLMDString): TLMDString;
begin
  Result := AStr;
  if Length(Result)<>0 then
    Result[1] := LMDUpperCaseChar(Result[1]);
end;

procedure AddWordSeps(ARe: TLMDRegExp; const ANode: ILMDXmlNode;
                      const APrefix: string);
var
    Nm: string;
    val: TLMDString;
begin
  if APrefix='' then
    Nm := MoreWordSeparatorsAttr
  else
    Nm := APrefix + '_' + MoreWordSeparatorsAttr;

  Assert(ANode<>nil);
  Assert(ARe<>nil);

  if ANode.AttrExists(Nm) then
  begin
    val := ANode.GetAttr(Nm);

    ARe.WordSeparators := ARe.WordSeparators + val;
    ARe.Compile;
  end;
end;

procedure AddWordChars(ARe: TLMDRegExp; const ANode: ILMDXmlNode;
                      const APrefix: string);
var
    Nm: string;
    val: TLMDString;
begin
  if APrefix='' then
    Nm := MoreWordCharsAttr
  else
    Nm := APrefix + '_' + MoreWordCharsAttr;

  Assert(ANode<>nil);
  Assert(ARe<>nil);

  if ANode.AttrExists(Nm) then
  begin
    val := ANode.GetAttr(Nm);

    ARe.WordChars := ARe.WordChars + val;
    ARe.Compile;
  end;
end;

procedure AddWordSepsChars(ARe: TLMDRegExp; const ANode: ILMDXmlNode;
                           const APrefix: string;
                           AScheme: TScheme);
begin
  AddWordSeps(ARe, ANode, APrefix);
  ARe.WordSeparators := ARe.WordSeparators + AScheme.MoreWordSeparators;

  AddWordChars(ARe, ANode, APrefix);
  ARe.WordChars := ARe.WordChars + AScheme.MoreWordChars;

  ARe.Compile;
end;

{******************************** TKeywordMap *********************************}
{------------------------------------------------------------------------------}

procedure TKeywordMap.Grow;
begin
  if Length(FMap)=0 then
    SetLength(FMap, 4)
  else
    SetLength(FMap, Length(FMap)*2);

  FIndexMask := High(FMap);
end;

{------------------------------------------------------------------------------}

procedure TKeywordMap.Rehash(AOldLength: Integer);
var
  i:         Integer;
  cur, next: TKeyword;
begin
  for i := AOldLength - 1 downto 0 do
  begin
    cur := FMap[i];
    FMap[i] := nil;

    while cur<>nil do
    begin
      next := cur.Next;
      InsertKw(cur);
      cur := next;
    end;
  end;
end;

{------------------------------------------------------------------------------}

function TKeywordMap.KeywordEquals(AKw: TKeyword;
  const AStr: TLMDString): Boolean;
var
  i, ie:  Integer;
  c1, c2: TLMDChar;
begin
  Result := Length(AKw.Word)=Length(AStr);
  if not Result then
    Exit;

  Result := True;
  ie := Length(AStr);
  for i := 1 to ie do
  begin
    c1 := AStr[i];
    c2 := AKw.Word[i];

    Result := c1=c2;
    if not Result then
    begin
      if FIgnoreCase then
      begin
        c1 := LMDUpperCaseChar(c1);
        c2 := LMDUpperCaseChar(c2);

        Result := c1=c2;
        if not Result then
          Exit;
      end
      else
        Exit;
    end;
  end;
end;
               
{------------------------------------------------------------------------------}

function TKeywordMap.KeywordEquals(AKw: TKeyword; const ASeq: TLMDCharSeq;
  AStart, ACount: Integer): Boolean;
var
  i, j, ie, st, eend: Integer;
  c1, c2: TLMDChar;
begin
  Result := Length(AKw.Word)=ACount;
  if not Result then
    Exit;

  Result := True;
  eend := AStart+ACount;

  j := 1;
  if AStart<>eend then
    repeat

      ASeq.AssureIdx(AStart);

      st := AStart-ASeq.BufferStart;
      ie := Min(eend, ASeq.BufferEnd)-ASeq.BufferStart-1;

      for i := st to ie do
      begin
        c1 := ASeq.Buffer[i];
        c2 := AKw.Word[j];

        Result := c1=c2;
        if not Result then
        begin
          if FIgnoreCase then
          begin
            c1 := LMDUpperCaseChar(c1);
            c2 := LMDUpperCaseChar(c2);

            Result := c1=c2;
            if not Result then
              Exit;
          end
          else
            Exit;
        end;

        Inc(j);
      end;

      Inc(AStart, ie-st+1);
    until AStart=eend;
end;

{------------------------------------------------------------------------------}

procedure TKeywordMap.InsertKw(const AKw: TKeyword);
var
  i:  Integer;
  kw: TKeyword;
begin
  i := MakeStrHash(AKw.Word, 1, Length(AKw.Word), FIgnoreCase) and FIndexMask;

  if FMap[i]=nil then
  begin
    FMap[i] := AKw;
    FMap[i].Next := nil
  end
  else
  begin
    kw := FMap[i];
    while kw.Next<>nil do
      kw := kw.Next;

    kw.Next := AKw;
    AKw.Next := nil;
  end
end;

{------------------------------------------------------------------------------}

procedure TKeywordMap.AddWord(const AWord: TLMDString);
var
  oldLn: Integer;
  kw:    TKeyword;
begin
  if Contains(AWord) then
    Exit;

  oldLn := Length(FMap);
  if FCount >= oldLn then
  begin
    Grow;
    Rehash(oldLn);
  end;

  kw := TKeyword.Create;
  kw.Word := AWord;
  kw.ID := -1;
  kw.Next := nil;

  InsertKw(kw);

  Inc(FCount);
end;
                  
{------------------------------------------------------------------------------}

function TKeywordMap.Contains(const AStr: TLMDString): Boolean;
begin
  Result := GetKeyword(AStr)<>nil;
end;

function TKeywordMap.GetKeyword(const AStr: TLMDString): TKeyword;
var
  id: Integer;
begin
  Result := nil;
  if FCount=0 then
    Exit;

  id := MakeStrHash(AStr, 1, Length(AStr), FIgnoreCase) and FIndexMask;

  Result := FMap[id];
  while Result<>nil do
  begin
    if KeywordEquals(Result, AStr) then
      Exit;

    Result :=Result.Next
  end;
end;
         
{------------------------------------------------------------------------------}

function TKeywordMap.GetKeyword(const ASeq: TLMDCharSeq;
  AStart, ACount: Integer): TKeyword;
var
  id: Integer;
begin
  Result := nil;
  if FCount=0 then
    Exit;
  
  id := MakeSeqHash(ASeq, AStart, ACount, FIgnoreCase) and FIndexMask;

  Result := FMap[id];
  while Result<>nil do
  begin
    if KeywordEquals(Result, ASeq, AStart, ACount) then
      Exit;

    Result :=Result.Next
  end;
end;
  
{------------------------------------------------------------------------------}

constructor TKeywordMap.Create(AIgnoreCase: Boolean);
begin
  inherited Create;

  FIndexMask := 0;
  FCount := 0;
  FIgnoreCase := AIgnoreCase;
end;
     
{------------------------------------------------------------------------------}

destructor TKeywordMap.Destroy;
var
  i:       Integer;
  tmp, Kw: TKeyword;
begin
  for i := 0 to Length(FMap)-1 do
    if FMap[i]<>nil then
    begin
      kw := FMap[i];
      repeat
        tmp := kw;
        kw := kw.Next;
        tmp.Free;
      until kw=nil;
    end;

  inherited;
end;

{****************************** TRulesHash ************************************}
{------------------------------------------------------------------------------}

constructor TRulesHash.Create;
begin
  inherited Create;

  Count := 0;
  FAnsiHashSize  := 256;
  SetLength(FAnsiHash, FAnsiHashSize);
  FUnicodeRules := nil;
end;
               
{------------------------------------------------------------------------------}

destructor TRulesHash.Destroy;
begin
  Clear;
  inherited;
end;
          
{------------------------------------------------------------------------------}

procedure TRulesHash.Clear;

  procedure ClearRules(Ref: TRuleRef);
  var
    Tmp: TRuleRef;
  begin
    while Ref<>nil do
    begin
      Tmp := Ref;
      Ref := Ref.Next;

      Tmp.Next := nil;
      Tmp.Rule := nil;
      Tmp.Free;
    end;
  end;

var
  i: Integer;
begin
  for i := 0 to FAnsiHashSize - 1 do
  begin
    ClearRules(FAnsiHash[i]);

    FAnsiHash[i] := nil;
  end;

  ClearRules(FUnicodeRules);
  Count := 0;
end;
   
{------------------------------------------------------------------------------}

procedure TRulesHash.AddRule(ARuleBase: TRuleBase; ARule: TRule;
  ASynBlock: TSyntaxBlock);
var
  b: Byte;

  procedure AddRuleLow(var ARefStart: TRuleRef);
  var
    ref, prev, newref: TRuleRef;
  begin
    newref := TRuleRef.Create;
    newref.Rule := ARule;
    newref.SynBlock := ASynBlock;
    newref.Next := nil;

    prev := nil;
    ref := ARefStart;

    if ARule<>nil then
    begin
      while (ref<>nil) and (ref.Rule.Priority>=ARuleBase.Priority) do
      begin
        prev := ref;
        ref := ref.Next;
      end
    end
    else
    begin
      Assert(ASynBlock<>nil);

      while (ref<>nil) and (ref.SynBlock.Priority>=ARuleBase.Priority) do
      begin
        prev := ref;
        ref := ref.Next;
      end
    end;

    if prev=nil then
      ARefStart := newref
    else
      prev.Next := newref;

    newref.Next := ref;
  end;

  function ExistsIn(ARefStart: TRuleRef): Boolean;
  begin
    while ARefStart<>nil do
      if (ARefStart.Rule=ARuleBase) or (ARefStart.SynBlock=ARuleBase) then
        Break
      else
        ARefStart := ARefStart.Next;

    Result := ARefStart<>nil;
  end;

begin
  for b := Low(Byte) to High(Byte) do
    if b in ARuleBase.AcceptedAnsiChars then
      if not ExistsIn(FAnsiHash[b mod FAnsiHashSize]) then
        AddRuleLow(FAnsiHash[b mod FAnsiHashSize]);

  if ARuleBase.AcceptUnicodeChars then
    if not ExistsIn(FUnicodeRules) then
      AddRuleLow(FUnicodeRules);

  Inc(Count);
end;

{------------------------------------------------------------------------------}

function TRulesHash.GetRuleChain(ACode: Integer): TRuleRef;
begin
  if ord(ACode)>High(Byte) then
    Result := FUnicodeRules
  else
    Result := FAnsiHash[ ord(ACode) mod FAnsiHashSize ];
end;

{********************************** TScheme ***********************************}
{------------------------------------------------------------------------------}

constructor TScheme.Create(const ANode: ILMDXmlNode;
                           const ADocName: TLMDString;
                           const AParser: TParserImpl);

  procedure AddParent(const AParent: TLMDString);
  var
    L : Integer;
  begin
    if AParent<>'' then
    begin
      L := Length(ParentSchemeNames);
      SetLength(ParentSchemeNames, L+1);
      ParentSchemeNames[L] := AParent;
    end
    else
      FParser.RaiseSyntaxSchemeError(SLMDSedEmptyInheritAttribute);
  end;

  procedure AddSynBlock(const ASynBlock: TSyntaxBlock);
  var
    L : Integer;
  begin
    L := Length(FSyntaxBlocks);
    SetLength(FSyntaxBlocks, L+1);
    FSyntaxBlocks[L] := ASynBlock;
  end;

var
  Nodes: ILMDXmlNodeList;
  i, j: Integer;
  Rule: TRule;
  S: TLMDString;
  N: ILMDXmlNode;
  Strings: TLMDMemoryStrings;
begin
  inherited Create;

  RulesHash := TRulesHash.Create;
  SynBlocksHash := TRulesHash.Create;

  FParser := AParser;
  FLoading := False;

  Name := ANode.GetAttr('name');
  if Name='' then
    FParser.RaiseSyntaxSchemeError(SLMDSedUnnamedScheme);

  Name := ADocName+SCHEME_DOC_SEPARATOR+Name;//Make full name

  FParser.SetCurrentScheme(Self);

  AllIgnoreCase := False;
  if ANode.AttrExists('allIgnoreCase') then
    AllIgnoreCase := GetBool(ANode, 'allIgnoreCase', FParser);

  if ANode.AttrExists('keywordsIgnoreCase') then
    KeywordsIgnoreCase := GetBool(ANode, 'keywordsIgnoreCase', FParser)
  else
    KeywordsIgnoreCase := AllIgnoreCase;

  if ANode.AttrExists(MoreWordSeparatorsAttr) then
    MoreWordSeparators := ANode.GetAttr(MoreWordSeparatorsAttr)
  else
  begin
    N := ANode.SelectSingleNode(FirstChUpper(MoreWordSeparatorsAttr));
    if N<>nil then
      MoreWordSeparators := N.Text;
  end;

  if ANode.AttrExists(MoreWordCharsAttr) then
    MoreWordChars := ANode.GetAttr(MoreWordCharsAttr)
  else
  begin
    N := ANode.SelectSingleNode(FirstChUpper(MoreWordCharsAttr));
    if N<>nil then
      MoreWordChars := N.Text;
  end;

  Keywords := TKeywordMap.Create(KeywordsIgnoreCase);

  if ANode.AttrExists('inherit') then
  begin
    S := ANode.GetAttr('inherit');
    AddParent(S);
  end;

  if ANode.AttrExists('inherit0') then
  begin
    S := ANode.GetAttr('inherit0');
    AddParent(S);
  end;

  i := 1;
  repeat
    S := '';

    if ANode.AttrExists(Format('inherit%d', [i])) then
    begin
      S := ANode.GetAttr(Format('inherit%d', [i]));
      AddParent(S);
    end;

    Inc(i);
  until S='';

  Nodes := ANode.SelectNodes('Inherit');
  for i := 0 to Nodes.Count - 1 do
  begin
    N := Nodes[i];
    S := N.GetAttr('scheme');
    if (S<>'') then
      AddParent(S)
    else
      AddParent(N.Text)
  end;

  SetLength(ParentSchemes, Length(ParentSchemeNames));

  DefaultToken := FParser.GetTokenProps(ANode.GetAttr('defaultToken',
                                                      'default'));

  nodes := ANode.SelectNodes('Regex');
  for i := 0 to nodes.Count - 1 do
  begin
    Rule := TRule.CreateRule(nodes[i], Self);
    AddRule(Rule);
  end;

  nodes := ANode.SelectNodes('RegexBlock');
  for i := 0 to nodes.Count - 1 do
  begin
    Rule := TRule.CreateRule(nodes[i], Self);
    AddRule(Rule);
  end;

  nodes := ANode.SelectNodes('ChainBlock');
  for i := 0 to nodes.Count - 1 do
  begin
    Rule := TRule.CreateRule(nodes[i], Self);
    AddRule(Rule);
  end;

  nodes := ANode.SelectNodes('Keyword');
  for i := 0 to nodes.Count - 1 do
  begin
    S := LMDTrim(nodes[i].Text);
    if S='' then
      FParser.RaiseSyntaxSchemeError(SLMDSedEmptyKeywordNode);

    Keywords.AddWord(S);
  end;

  nodes := ANode.SelectNodes('Keywords');
  for i := 0 to nodes.Count - 1 do
  begin
    S := LMDTrim(nodes[i].Text);
    if S='' then
      FParser.RaiseSyntaxSchemeError(SLMDSedEmptyKeywordsList);

    Strings := TLMDMemoryStrings.Create;
    try
      Strings.Clear;
      LMDSplitRegExpr('\s+', S, Strings);

      for j := 0 to Strings.Count - 1 do
      begin
        S := LMDTrim(Strings[j]);
        if not Keywords.Contains(S) then
          Keywords.AddWord(S);
      end;
    finally
      Strings.Free;
    end;
  end;

  N := ANode.SelectSingleNode('KeywordRegex');
  if N<>nil then
  begin
    Rule := TRule.CreateRule(N, Self);
    AddRule(Rule);
  end;

  nodes := ANode.SelectNodes('SyntaxBlock');
  for i := 0 to nodes.Count - 1 do
    AddSynBlock(TSyntaxBlock.Create(nodes[i], self));

  FSynTokensToSkip := '';
  nodes := ANode.SelectNodes('SkipSyntaxToken');
  for i := 0 to nodes.Count - 1 do
  begin
    if nodes[i].AttrExists('token') then
      S := nodes[i].GetAttr('token')
    else
      S := nodes[i].Text;

    FSynTokensToSkip := FSynTokensToSkip + S + ' ';
  end;
  FSynTokensToSkip := LMDTrim(FSynTokensToSkip);

  SyntaxTailMaxLength := SYNTAX_TAIL_MAX_LENGTH;
  if ANode.AttrExists('syntaxTailMaxLength') then
    SyntaxTailMaxLength := GetInt(ANode, 'syntaxTailMaxLength', FParser);
end;

{------------------------------------------------------------------------------}

destructor TScheme.Destroy;
var
  i: Integer;
begin
  RulesHash.Free;
  SynBlocksHash.Free;

  Keywords.Free;

  for i := 0 to Length(FRules) - 1 do
    FRules[i].Free;

  for i := 0 to Length(FSyntaxBlocks) - 1 do
    FSyntaxBlocks[i].Free;

  inherited;
end;
         
{------------------------------------------------------------------------------}

procedure TScheme.AddRule(ARule: TRule);
var
  L: Integer;
begin
  L := Length(FRules);
  SetLength(FRules, L+1);

  FRules[L] := ARule;
end;

function  TScheme.FindRule(const AName: TLMDString): TRule;
var i: Integer;
begin
  Result := nil;
  for i:=0 to Length(FRules)-1 do
    if FRules[i].Name=AName then
    begin
      Result := FRules[i];
      Exit;
    end;
end;
{------------------------------------------------------------------------------}

procedure TScheme.SetupRuleChains;

  procedure SetupLow(ASc: TScheme);
  var
    i: Integer;
  begin
    for i := 0 to Length(ASc.FRules)-1 do
      Self.RulesHash.AddRule(ASc.FRules[i], ASc.FRules[i], nil);

    for i := 0 to Length(ASc.ParentSchemes)-1 do
      SetupLow(ASc.ParentSchemes[i]);
  end;

begin
  SetupLow(Self);
end;

{------------------------------------------------------------------------------}

procedure TScheme.SetupRuleBlockChains;
var
  i: Integer; N: TLMDString;
begin
  for i:=0 to Length(FRules)-1 do
  begin
    N := FRules[i].ChainedBlockRuleName;
    if N<>'' then
    begin
      FRules[i].ChainedBlockRule := FindRule(N);
      if FRules[i].ChainedBlockRule=nil then
        FParser.RaiseSyntaxDocErrorF(SLMDSedChainBlockNotFound, [N]);
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TScheme.SetupSynChains;

  procedure SetupLow(ASc: TScheme);
  var
    i: Integer;
  begin
    for i := 0 to Length(ASc.FSyntaxBlocks)-1 do
      Self.SynBlocksHash.AddRule(ASc.FSyntaxBlocks[i], nil, ASc.FSyntaxBlocks[i]);

    for i := 0 to Length(ASc.ParentSchemes)-1 do
      SetupLow(ASc.ParentSchemes[i]);
  end;

begin
  SetupLow(Self);
end;

{------------------------------------------------------------------------------}

procedure TScheme.SetupSkipTokens;
var
  Ln, i, id, ie: Integer;
  N, S:          TLMDString;
  slst:          TList;

  procedure GetSkipTokens(AScheme: TScheme; var S: TLMDString);
  var
    i: Integer;
    p: TScheme;
  begin
    if AScheme.FSynTokensToSkip <> '' then
    begin
      if S <> '' then
        S := S + ' ';
      S := S + AScheme.FSynTokensToSkip;
    end;

    for i := 0 to High(AScheme.ParentSchemes) do
    begin
      p := AScheme.ParentSchemes[i];
      if slst.IndexOf(p) <> -1 then
        Continue;

      slst.Add(p); // Strange, but circualar references
                   // are exist in schemes parentship.
      GetSkipTokens(p, S);
    end;
  end;

begin
  SetLength(SkipSyntaxTokens, FParser.MaxTokenID + 1);
  for i := 0 to High(SkipSyntaxTokens) do
    SkipSyntaxTokens[i] := False;

  slst := TList.Create;
  try
    S := '';
    GetSkipTokens(Self, S);
  finally
    slst.Free;
  end;

  // Scan attribute list.
  i := 1;
  Ln := Length(S);
  repeat
    while (i<=Ln) and (LMDPosEx(S[i], DIVIDERS, 1)>0) do
      Inc(i);

    // i = Ln + 1 or S[i] <> ' '.
    ie := i;
    while (ie<=Ln) and (LMDPosEx(S[ie], DIVIDERS, 1)=0) do
      Inc(ie);

    if ie>i then
    begin
      N := Copy(S, i, ie-i);

      id := FParser.FindTokenID(N);
      if id<>-1 then
        SkipSyntaxTokens[id] := True;
    end;

    i := ie;
  until i>ln;
end;

{******************************** TSyntaxBlock ********************************}
{------------------------------------------------------------------------------}

function TSyntaxBlock.CreateRe(const AStr: TLMDString): TLMDRegExp;
begin
  Result := TLMDRegExp.Create;
  try
    Result.ModifierI := False;
    Result.ModifierS := False;
    Result.ModifierG := True;
    Result.ModifierM := False;

    Result.ModifierA := True;
    Result.ModifierX := True;
    Result.ModifierC := True;

    Result.CodesResolver := FParser.ResolveIntCode;
    Result.Expression := AStr;
  except
    on E: Exception do
    begin
      FreeAndNil(Result);

      Raise;
    end;
  end;
end;

{------------------------------------------------------------------------------}

constructor TSyntaxBlock.Create(const ANode: ILMDXmlNode;
  AScheme: TScheme);
begin
  inherited Create;

  FParser := AScheme.FParser;
  FParser.SetCurrentRule(nil, Self);
  FXml := ANode.XML;

  StartRegex := GetRegex(ANode, 'Start', 'start', FParser, false, CreateRe);
  EndRegex := GetRegex(ANode, 'End', 'end', FParser, false, CreateRe);

  Capture := False;
  if ANode.AttrExists('capture') then
    Capture := GetBool(ANode, 'capture', FParser);

  StartGroupUsed := 0;
  if ANode.AttrExists('startGroupUsed') then
    StartGroupUsed := GetInt(ANode, 'startGroupUsed', FParser);

  if not LMDInRange(StartGroupUsed, 0, StartRegex.CompiledSubExpCount-1)
  then
    FParser.RaiseSyntaxSchemeErrorF(SLMDSedStartGroupUsedBadIndex,
                                    [StartRegex.CompiledSubExpCount]);
  EndGroupUsed := 0;
  if EndRegex<>nil then
  begin
    if ANode.AttrExists('endGroupUsed') then
      EndGroupUsed := GetInt(ANode, 'endGroupUsed', FParser);

    if not LMDInRange(EndGroupUsed, 0, EndRegex.CompiledSubExpCount-1)
    then
      FParser.RaiseSyntaxSchemeErrorF(SLMDSedEndGroupUsedBadIndex,
                                      [EndRegex.CompiledSubExpCount]);
  end;

  Priority := 0;
  if ANode.AttrExists('priority') then
    Priority := GetInt(ANode, 'priority', FParser);

  MinLines := 2;
  if ANode.AttrExists('minLines') then
    MinLines := Max(2, GetInt(ANode, 'minLines', FParser, 1));

  AcceptedAnsiChars := StartRegex.GetFirstCharSetAnsi(AcceptUnicodeChars);
  EndAcceptedAnsiChars := EndRegex.GetFirstCharSetAnsi(EndAcceptUnicodeChars)
end;

{------------------------------------------------------------------------------}

destructor TSyntaxBlock.Destroy;
begin
  StartRegex.Free;
  EndRegex.Free;

  inherited;
end;

{******************************** TTokenProps *********************************}
{------------------------------------------------------------------------------}

procedure LMDDecodeTokenXML(const ANode: ILMDXmlNode;
                            var Attrs: TLMDEditAttributes;
                            var AName: TLMDString);

  procedure AddAttr(const AStr: TLMDString);
  var
      s: TLMDString;
  begin
    s := LMDTrim(LMDLowerCase(AStr));

    if s='bold' then
      Include(Attrs.FontStyle, fsBold)
    else if s='italic' then
      Include(Attrs.FontStyle, fsItalic)
    else if s='strikeout' then
      Include(Attrs.FontStyle, fsStrikeOut)
    else if s='underline' then
      Include(Attrs.FontStyle, fsUnderline)
    else
      raise ELMDColorSchemeLoadError.Create(SLMDSedInvalidFontStyle+AStr);

    Include(Attrs.AttributesSet, asFontStyle);
  end;

var
  S:         TLMDString;
  Color:     TColor;
  i, j, ie, ln: Integer;
  CustomNodes, Nodes2: ILMDXmlNodeList;
  Node, Node2: ILMDXmlNode;
begin
  if Attrs.CustomAttributes <> nil then
    raise EInvalidArgument.Create(SLMDSedDecodeAttributesBadArgument);

  Attrs.AttributesSet := [];
  Attrs.FontStyle := [];

  AName := ANode.GetAttr('name');
  if AName = '' then
    raise ELMDColorSchemeLoadError.Create(SLMDSedTokenShouldHaveNameAttr);

  S := ANode.GetAttr('backgroundColor');
  if StrToColorHtml(S, Color) then
  begin
    Attrs.BackgroundColor := Color;
    Include(Attrs.AttributesSet, asBackgroundColor);
  end
  else if S<>'' then
    raise ELMDColorSchemeLoadError.Create(SLMDSedInvalidBgColor);

  S := ANode.GetAttr('textColor');
  if StrToColorHtml(S, Color) then
  begin
    Attrs.TextColor := Color;
    Include(Attrs.AttributesSet, asTextColor);
  end
  else if S<>'' then
    raise ELMDColorSchemeLoadError.Create(SLMDSedInvalidTextColor);

  S := ANode.GetAttr('fontStyle');
  ln := Length(S);

  i := 1;

  // Scan attribute list.
  repeat
    while (i <= Ln) and (LMDPosEx(S[i], DIVIDERS, 1) > 0) do
      Inc(i);

    // i = Ln + 1 or S[i] <> ' '.
    ie := i;
    while (ie <= Ln) and (LMDPosEx(S[ie], DIVIDERS, 1) = 0) do
      Inc(ie);

    if ie > i then
      AddAttr(Copy(S, i, ie-i));

    i := ie;
  until i > ln;

  CustomNodes := ANode.SelectNodes('CustomAttributes');

  for i := 0 to CustomNodes.Count - 1 do
  begin
    Node := CustomNodes[i];
    Nodes2 := Node.ChildNodes;

    for j := 0 to Nodes2.Count - 1 do
    begin
      Node2 := Nodes2[j];

      if Attrs.CustomAttributes = nil then
      begin
        Attrs.CustomAttributes := TLMDStringHashTable.Create(false);
        Include(Attrs.AttributesSet, asCustomAttributes);
      end;

      Assert(Length(LMDTrim(Node2.NodeName))<>0);
      Attrs.CustomAttributes.SetOrAdd(LMDTrim(Node2.NodeName), LMDTrim(Node2.Text));
    end;
  end;
end;


constructor TTokenProps.Create(const ANode: ILMDXmlNode);
begin
  inherited Create;

  Attributes.CustomAttributes := nil;
  Attributes.AttributesSet := [];

  DefaultContentID := -1;
  ContentMap := TKeywordMap.Create(False);
  ContentMapCI := TKeywordMap.Create(True);

  if ANode=nil then
    Exit;

  LMDDecodeTokenXML(ANode, Attributes, Name);
end;

{------------------------------------------------------------------------------}

destructor TTokenProps.Destroy;
var
    Owns: Boolean;
begin
  ContentMap.Free;
  ContentMapCI.Free;

  Owns := true;
  FreeAttrs(Attributes, Owns);

  inherited;
end;

{******************************** TParserImpl *********************************}
{------------------------------------------------------------------------------}

procedure TParserImpl.AddScheme(AScheme: TScheme);
var
  L: Integer;
begin
  L := Length(FSchemes);
  SetLength(FSchemes, L+1);
  FSchemes[L] := AScheme;
end;
   
{------------------------------------------------------------------------------}

function TParserImpl.GetSchemeByName(const AName: TLMDString): TScheme;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Length(FSchemes) - 1 do
    if FSchemes[i].Name=AName then
    begin
      Result := FSchemes[i];
      Break;
    end;
end;

{------------------------------------------------------------------------------}

procedure TParserImpl.ClearSchemes;
var
  i: Integer;
begin
  for i := 0 to Length(FSchemes) - 1 do
    FSchemes[i].Free;

  SetLength(FSchemes, 0);
  FRootSc := nil;

  for i := 0 to FTokenProps.Count - 1 do
    FTokenProps.Objects[i].Free;

  FTokenProps.Clear;
end;
    
{------------------------------------------------------------------------------}

constructor TParserImpl.CreateImpl(ATokenCacheSize,
  AContextSaveInterval: Integer);
begin
  inherited Create;

  FDummyTokLine := TTokenLine.Create;

  FMaxLineLengthToParse := MAX_LINE_LENGTH_TO_PARSE;

  FMaxSubExp := TLMDRegExp.SubExpMaxCount;
  SetLength(FMatch.Starts, FMaxSubExp);
  SetLength(FMatch.Ends, FMaxSubExp);

  FContextSaveInterval := AContextSaveInterval;
  FSchemeLoaded := False;

  FIgnoredChars := TLMDCharSet.Create;

  FIgnoredChars.IncludeRange(0, $20);
  {$IFDEF LMD_UNICODE}
  FIgnoredChars.IncludeCat(ukZl);
  FIgnoredChars.IncludeCat(ukZp);
  FIgnoredChars.IncludeCat(ukZs);
  FIgnoredChars.IncludeCat(ukCc);
  FIgnoredChars.IncludeCat(ukCs);
  FIgnoredChars.IncludeCat(ukCo);
  FIgnoredChars.IncludeCat(ukCf);
  {$ENDIF}

  FContextCache := TContextCache.Create;
  FTokenCache := TTokenCache.Create(ATokenCacheSize);
  FInheritPath := TLMDMemoryStrings.Create;
  FTokenProps := TLMDMemoryStrings.Create;

  FParseTree := TParserTree.Create;

  FSyntaxInput := TSynRegexSource.Create(32, 0);
  FCharsInput := TCharsRegexSource.Create;

  FChars := nil;

  FSyntaxLoader := nil;
  FColorLoader := nil;
end;
          
{------------------------------------------------------------------------------}

destructor TParserImpl.Destroy;
begin
  ClearSchemes;
  FInheritPath.Free;
  FContextCache.Free;

  FTokenProps.Free;
  FTokenCache.Free;
  FIgnoredChars.Free;
  FParseTree.Free;
  FSyntaxInput.Free;
  FCharsInput.Free;

  FDummyTokLine.Free;
end;
             
{------------------------------------------------------------------------------}

procedure TParserImpl.LoadSchemeDoc(const ADocName, AttrsDocName: TLMDString);

  function FullSchemeName(AScName, ALocDocName: TLMDString): TLMDString;
  var
    DocS: Integer;
  begin
    DocS := LMDPosEx(SCHEME_DOC_SEPARATOR, AScName, 1);
    if DocS=0 then
      result := ALocDocName+SCHEME_DOC_SEPARATOR+AScName
    else
      result := AScName;
  end;

  function DocFromSchemeName(const AName: TLMDString): TLMDString;
  var
    DocS: Integer;
  begin
    DocS := LMDPosEx(SCHEME_DOC_SEPARATOR, AName, 1);
    if DocS>0 then
      Result := Copy(AName, 1, DocS-1)
    else
      Result := ADocName;
  end;

  procedure LoadTokenAliases(const ANodes: ILMDXmlNodeList);
  var
      FullName, Name, BaseName: TLMDString;
      Props, BaseProps: TTokenProps;

      Node: ILMDXmlNode;
      i: Integer;
  begin
    for i := 0 to ANodes.Count - 1 do
    begin
      Node := ANodes[i];

      Name := LMDTrim(Node.GetAttr('name'));

      if Name='' then
        RaiseSyntaxDocError(SLMDSedEmptyTokenName);

      if FTokenProps.IndexOf(Name)<>-1 then
        RaiseSyntaxDocErrorF(SLMDSedUniqueTokenName, [Name]);

      FullName := FCurDocName + '.' + Name;
      if FTokenProps.IndexOf(FullName)<>-1 then
        RaiseSyntaxDocErrorF(SLMDSedUniqueTokenName, [FullName]);

{     This is bad for empty color schemes...
 
      BaseName := LMDTrim(Node.GetAttr('baseToken'));

      if (FTokenProps.IndexOf(BaseName)=-1) or (BaseName='') then
        RaiseSyntaxDocErrorF(SLMDSedInvalidTokenReference, ['baseToken']);
}
    end;

    for i := 0 to ANodes.Count - 1 do
    begin
      Name := LMDTrim(Node.GetAttr('name'));
      BaseName := LMDTrim(Node.GetAttr('baseToken'));
      FullName := FCurDocName + '.' + Name;

      BaseProps := GetTokenProps(BaseName);
      Props := GetTokenProps(FullName);

      Props.Attributes := BaseProps.Attributes;
    end;
  end;

  procedure DocToSchemes(const ADocName: TLMDString; var RootSc: TScheme);
  var
    Doc:    ILMDXmlDocument;
    Node:   ILMDXmlNode;
    RootSn: TLMDString;
    Sc:     TScheme;
    Docp:   TLMDString;
    Nodes:  ILMDXmlNodeList;
    i:      Integer;
  begin
    try
      if Assigned(FSyntaxLoader) then
      begin
        Doc := LMDLoadXmlDocumentFromXML(FSyntaxLoader(ADocName));
        Docp := ADocName;
      end
      else
      begin
        Docp := LMDSlashAdd(Self.FSchemesDir) + LMDTrim(ADocName) + SCHEME_DOC_EXTENSION;
        Doc := LMDLoadXmlDocument(Docp);
      end;
    except
      on E: Exception do
      begin
        raise ELMDSyntaxSchemeLoadError.CreateFmt(SLMDSedErrorLoadingSyntaxScheme,
                                                  [E.ClassName, E.Message]);
      end;
    end;

    SetCurrentDoc(ADocName, Docp);

    Node := Doc.SelectSingleNode('SchemeList');
    if Node=nil then
      RaiseSyntaxDocError(SLMDSedDocumentShouldHaveSchemeList);

    RootSn := Node.GetAttr('root');
    if RootSn='' then
      RaiseSyntaxDocError(SLMDSedSchemeListShouldNameRoot);

    LoadTokenAliases(Node.SelectNodes('TokenAlias'));

    RootSc := nil;
    nodes := Node.SelectNodes('Scheme');
    for i := 0 to nodes.Count - 1 do
    begin
      Sc := TScheme.Create(nodes[i], ADocName, Self);
      AddScheme(Sc);

      if Sc.Name=FullSchemeName(RootSn, ADocName) then
        RootSc := Sc;
    end;

    if RootSc=nil then
      RaiseSyntaxDocErrorF(SLMDSedRootSchemeNotFound, [RootSn]);
  end;

  function ForceGetScheme(const AScName: TLMDString): TScheme;
  var
    Ref: TScheme;
    Doc: TLMDString;
  begin
    Ref := GetSchemeByName(FullSchemeName(AScName, ADocName));
    if Ref=nil then
    begin
      Doc := DocFromSchemeName(AScName);
      if Doc='' then
        RaiseSyntaxSchemeErrorF(SLMDSedCantFindSchemeDocument, [AScName]);

      DocToSchemes(Doc, Ref);

      Ref := GetSchemeByName(FullSchemeName(AScName, ADocName));
    end;
    if Ref=nil then
      RaiseSyntaxSchemeErrorF(SLMDSedCantFindSchemeByRef, [AScName]);

    Result := Ref;
  end;

  procedure CheckRefs(ASc: TScheme);

    function GetInhPath: TLMDString;
    var
      i: Integer;
    begin
      Result := '';
      for i := 0 to FInheritPath.Count-1 do
      begin
        Result := Result + FInheritPath[i];
        if i<FInheritPath.Count-1 then
          Result := Result + ' -> ';
      end;
    end;

  var
    Ref:  TScheme;
    Rule: TRule;
    i:    Integer;
    S:    TLMDString;
    ScDoc: TLMDString;
  begin
    ASc.FLoading := True;

    SetCurrentScheme(ASc);

    ScDoc := DocFromSchemeName(ASc.Name);

    for i := 0 to Length(ASc.ParentSchemeNames) - 1 do
    begin
      S := LMDTrim(ASc.ParentSchemeNames[i]);

      FInheritPath.Add(S);

      Ref := ForceGetScheme(FullSchemeName(S, ScDoc));
      if Ref.FLoading then
        RaiseSyntaxSchemeError(SLMDSedCyclicInheritance+GetInhPath);

      CheckRefs(Ref);

      ASc.ParentSchemes[i] := Ref;

      FInheritPath.Delete(FInheritPath.Count-1);
    end;

    for i := 0 to Length(ASc.FRules)-1 do
    begin
      Rule := ASc.FRules[i];

      if Rule.InnerSchemeName<>'' then
      begin
        S := Rule.InnerSchemeName;
        Ref := ForceGetScheme(FullSchemeName(S, ScDoc));
        if not Ref.FLoading then
          CheckRefs(Ref);

        Rule.InnerScheme := Ref;
      end;
    end;

    SetCurrentScheme(ASc);

    ASc.SetupRuleChains;
    ASc.SetupSynChains;
    ASc.SetupSkipTokens;
    ASc.SetupRuleBlockChains;

    ASc.FLoading := False;
  end;

begin
  UnloadSchemes;

  FTokenID := -1;
  LoadBaseTokenAtts(AttrsDocName);

  DocToSchemes(ADocName, FRootSc);

  FInheritPath.Clear;
  CheckRefs(FRootSc);

  FTokenKeyword := GetTokenProps('keyword');
  FSchemeLoaded := True;

  SetLength(FMaxLnTokens[rpBegin], 2);
  FMaxLnTokens[rpBegin][0] := nil;
  FMaxLnTokens[rpBegin][1] := GetTokenProps('default');
  SetLength(FMaxLnTokens[rpEnd], 0);
end;

{------------------------------------------------------------------------------}

procedure TParserImpl.UnloadSchemes;
begin
  KillCachesFrom(0);
  ClearSchemes;
  FSchemeLoaded := False;
end;
       
{------------------------------------------------------------------------------}

procedure TParserImpl.SetSchemeLoaders(ASyntaxLoader,
                                       AColorLoader:
                                       TLMDEditParserSchemeLoader);
begin
  FSyntaxLoader := ASyntaxLoader;
  FColorLoader := AColorLoader;
end;
                          
{------------------------------------------------------------------------------}

procedure TParserImpl.SetCurrentDoc(const AName, APath: TLMDString);
begin
  FCurDocName := AName;
  FCurDocPath := APath;
end;
      
{------------------------------------------------------------------------------}

procedure TParserImpl.SetCurrentScheme(AScheme: TScheme);
begin
  FCurScheme := AScheme;
  FCurRule := nil;
  FCurBlock := nil;
end;
   
{------------------------------------------------------------------------------}

procedure TParserImpl.SetCurrentRule(ARule: TRule; ASynRule: TSyntaxBlock);
begin
  FCurRule := ARule;
  FCurBlock := ASynRule;
end;

{------------------------------------------------------------------------------}

procedure TParserImpl.RaiseSyntaxSchemeError(const AMessage: TLMDString);
var
  S: TLMDString;
begin
  S := SLMDSedSchemeLoadError+LMDCRLF+'%s'+LMDCRLF+'--------'+
       SLMDSedCurrentDocIs+LMDCRLF+
       SLMDSedCurrentSchemeNameIs+LMDCRLF;

  if FCurRule<>nil then
    S := S + Format(SLMDSedCurrentRuleCodeIs+LMDCRLF+'--------'+'%s'+LMDCRLF+'--------',
                    [FCurRule.FXml]);

  if FCurBlock<>nil then
    S := S + Format(SLMDSedCurrentBlockCodeIs+LMDCRLF+'--------'+'%s'+LMDCRLF+'--------',
                    [FCurBlock.FXml]);

  S := Format(S, [AMessage, FCurDocName, FCurDocPath, FCurScheme.Name]);

  raise ELMDSyntaxSchemeLoadError.Create(S);
end;
     
{------------------------------------------------------------------------------}

procedure TParserImpl.RaiseSyntaxDocError(const AMessage: TLMDString);
var
  S: TLMDString;
begin
  S := SLMDSedDocumentLoadingError+LMDCRLF+'%s'+LMDCRLF+'--------'+
       SLMDSedCurrentDocIs;

  S := Format(S, [AMessage, FCurDocName, FCurDocPath]);

  raise ELMDSyntaxSchemeLoadError.Create(S);
end;
      
{------------------------------------------------------------------------------}

procedure TParserImpl.RaiseSyntaxSchemeErrorF(const AMessage: TLMDString;
  const Args: array of const);
begin
  RaiseSyntaxSchemeError(Format(AMessage, Args));
end;
        
{------------------------------------------------------------------------------}

procedure TParserImpl.RaiseSyntaxDocErrorF(const AMessage: TLMDString;
  const Args: array of const);
begin
  RaiseSyntaxDocError(Format(AMessage, Args));
end;
      
{------------------------------------------------------------------------------}

function TParserImpl.CreateRe(const AStr: TLMDString): TLMDRegExp;
var
    Res: TLMDRegExp;
begin
  Res := TLMDRegExp.Create;
  try
    Res.Expression := AStr;
    Res.ModifierA := True;
    Res.ModifierX := True;
    Res.Compile;
  except
    on E: Exception do
    begin
      FreeAndNil(Res);

      raise;
    end;
  end;

  Result := Res;
end;

{------------------------------------------------------------------------------}

function TParserImpl.GetAttrsDir: TLMDString;
begin
  if FAttrsDir='' then
    Result := FSchemesDir
  else
    Result := FAttrsDir;
end;
      
{------------------------------------------------------------------------------}

function TParserImpl.GetAllTokenIDs(const ATokenName: TLMDString): TLMDIntArray;
var
    i, L, PL, TL: Integer;
    prop: TTokenProps;
    sub: TLMDString;
begin
  SetLength(Result, 0);

  for i := 0 to FTokenProps.Count - 1 do
  begin
    prop := FTokenProps.Objects[i] as TTokenProps;

    PL := Length(prop.Name);
    TL := Length(ATokenName);
    if PL > TL then
      sub := Copy(prop.Name, PL - TL, TL+1)
    else
      sub := '';

    if (sub=('.'+ATokenName)) or (prop.Name=ATokenName) then
    begin
      L := Length(Result);
      SetLength(Result, L+1);

      Result[L] := prop.ID;
    end;
  end;
end;

function TParserImpl.GetTokenProps(const ATokenName: TLMDString): TTokenProps;
var
  id:    Integer;
  props: TTokenProps;
  dummy: Boolean;
begin
  id := FTokenProps.IndexOf(ATokenName);

  if (id=-1) then
    id := FTokenProps.IndexOf(FCurDocName + '.' + ATokenName);

  if id=-1 then
  begin
    props := TTokenProps.Create;
    props.Name := FCurDocName + '.' + ATokenName;

    InitAttrs(props.Attributes, dummy);

    id := AddTokenProps(props);
  end;

  Result := TTokenProps(FTokenProps.Objects[id]);
end;
        
{------------------------------------------------------------------------------}

function TParserImpl.AddTokenProps(AProps: TTokenProps): Integer;
begin
  Result := FTokenProps.Add(AProps.Name);
  AProps.ID := Result;
  FTokenProps.Objects[Result] := AProps;

  Inc(FTokenID);
  AProps.DefaultContentID := FTokenID;
end;

{------------------------------------------------------------------------------}

function TParserImpl.FindTokenID(const ATokenName: TLMDString): Integer;
var
  id: Integer;
begin
  id := FTokenProps.IndexOf(ATokenName);
  if id<>-1 then
    Result := TTokenProps(FTokenProps.Objects[id]).ID
  else
    Result := -1;
end;
    
{------------------------------------------------------------------------------}

function TParserImpl.MaxTokenID: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FTokenProps.Count-1 do
    Result := Max(Result, TTokenProps(FTokenProps.Objects[i]).ID);
end;
   
{------------------------------------------------------------------------------}

function TParserImpl.ResolveIntCode(const ACodeName: TLMDString): Integer;
var
  dot:        Integer;
  token, txt: TLMDString;
  props:      TTokenProps;
  kw:         TKeyword;
begin
  dot := LMDPosEx(':', ACodeName, 1);

  if dot>0 then
  begin
    token := LMDTrim(Copy(ACodeName, 1, dot-1));

    if dot<=Length(ACodeName) then
      txt := LMDTrim(Copy(ACodeName, dot+1, Length(ACodeName)-dot));
  end
  else
    token := LMDTrim(ACodeName);

  if token='kw' then
    token := 'keyword'
  else if token='sym' then
    token := 'symbol'
  else if token='' then
    RaiseSyntaxSchemeError(SLMDSedBadIntCodeName+ACodeName);

  props := GetTokenProps(token);

  if txt<>'' then
  begin
    kw := props.ContentMap.GetKeyword(txt);
    if kw=nil then
    begin
      Inc(FTokenID);

      props.ContentMap.AddWord(txt);
      kw := props.ContentMap.GetKeyword(txt);
      kw.ID := FTokenID;

      Assert(props.ContentMapCI.GetKeyword(txt)=nil);

      props.ContentMapCI.AddWord(txt);
      kw := props.ContentMapCI.GetKeyword(txt);
      kw.ID := FTokenID;
    end;

    Result := kw.ID;
  end
  else
    Result := props.DefaultContentID;
end;

{------------------------------------------------------------------------------}

procedure TParserImpl.LoadBaseTokenAtts(const AttrsDocName: TLMDString);
var
  Docp, S:  TLMDString;
  Node:     ILMDXmlNode;
  Nodes:    ILMDXmlNodeList;
  Doc:      ILMDXmlDocument;
  i:        Integer;
  props:    TTokenProps;

  procedure RaiseColorErr(const AMsg: TLMDString; const Args: array of const); overload;
  var
    Msg: TLMDString;
  begin
    Msg := Format(AMsg, Args);

    raise ELMDColorSchemeLoadError.CreateFmt('%s'+LMDCRLF+SLMDSedAttributesDocIs,
                                             [Msg, Docp]);
  end;

  procedure RaiseColorErr(const AMsg: TLMDString); overload;
  begin
    RaiseColorErr(AMsg, []);
  end;

begin
  try
    if Assigned(FColorLoader) then
    begin
      Docp := AttrsDocName;
      Doc := LMDLoadXmlDocumentFromXML(FColorLoader(AttrsDocName));
    end
    else
    begin
      Docp := LMDSlashAdd(Self.GetAttrsDir) + LMDTrim(AttrsDocName) + SCHEME_DOC_EXTENSION;
      Doc := LMDLoadXmlDocument(Docp);
    end;
  except
    on E: Exception do
    begin
      S := SLMDSedErrorLoadingColorScheme;
      raise ELMDColorSchemeLoadError.CreateFmt(S, [E.ClassName, E.Message]);
    end;
  end;

  Node := Doc.SelectSingleNode('Attributes');
  if Node=nil then
    RaiseColorErr(SLMDSedAttributesDocNoRootNode);

  Nodes := Node.SelectNodes('Token');

  for i := 0 to Nodes.Count - 1 do
  begin
    Node := Nodes[i];

    try
      props := TTokenProps.Create(Node);
      if FTokenProps.IndexOf(props.Name)<>-1 then
      begin
        S := props.Name;
        FTokenProps.Free;
        RaiseColorErr(SLMDSedUniqueTokenName, [S]);
      end;

      AddTokenProps(props);
    except
      on E: ELMDColorSchemeLoadError do
        RaiseColorErr(SLMDSedTokenNodeReadingError, [E.Message]);
    end;
  end;
end;

{********************************** TRule *************************************}
{------------------------------------------------------------------------------}

procedure TRule.SetupRulePartArray(APart: TRulePart; ACount: Integer);
var
  i: Integer;
begin
  SetLength(Tokens[APart], ACount);
  for i := 0 to ACount-1 do
  begin
    Tokens[APart][i] := nil;
    InnerSchemeName := '';
    InnerScheme := nil;
  end;
end;
      
{------------------------------------------------------------------------------}

constructor TRule.Create(const ANode: ILMDXmlNode; const AScheme: TScheme;
  ADefPriority: Integer);
begin
  inherited Create;

  CloseInnerSchemesOnMatchEnd := false;
  Name := '';

  SetLength(Tokens[rpBegin], 0);
  SetLength(Tokens[rpEnd], 0);

  InnerSchemeName := '';
  InnerScheme := nil;
  ChainedBlockRuleName := '';

  ChainedBlockRule := nil;
  FInnerContentGroup := -1;

  IsBlockRule := False;
  AcceptedAnsiChars := [];
  AcceptUnicodeChars := False;

  FScheme := AScheme;

  FXml := ANode.XML;
  AScheme.FParser.SetCurrentRule(Self, nil);

  SetupRulePartArray(rpBegin, 0);
  SetupRulePartArray(rpEnd, 0);

  Priority := ADefPriority;
  if ANode.AttrExists('priority') then
    Priority := GetInt(ANode, 'priority', FScheme.FParser);
end;

{------------------------------------------------------------------------------}

class function TRule.CreateRule(const ANode: ILMDXmlNode;
  AScheme: TScheme): TRule;
var
  T: TLMDString;
begin
  T := LMDTrim(LMDLowerCase(ANode.NodeName));

  Result := nil;
  if (T='regex') or (T='regexblock') or (T='chainblock') then
    Result := TRegexRule.Create(ANode, AScheme)
  else if T='keywordregex' then
    Result := TKeywordsRule.Create(ANode, AScheme)
  else
    Assert(False, Format('TRule.CreateRule: %s', [T]));
end;

{------------------------------------------------------------------------------}

procedure TRule.BindVariables(AFiller: TLMDRegExprVariableGetter);
begin
end;

{------------------------------------------------------------------------------}

function TRule.NeedVariables: Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------------------}

function  TRule.MaxVarId: Integer;
begin
  result := -1;
end;

{------------------------------------------------------------------------------}

function  TRule.GetVariable(AId: Integer; var AStart, ACount: Integer): Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------------------}


{********************************* TRegexRule *********************************}
{------------------------------------------------------------------------------}

constructor TRegexRule.Create(const ANode: ILMDXmlNode; AScheme: TScheme);

  function LoadTokens(APart: TRulePart; ACount: Integer;
                      const APrefix: TLMDString;
                      const LNode: ILMDXmlNode): Integer;
  var
    i:    Integer;
    N, S: TLMDString;
  begin
    SetupRulePartArray(APart, ACount);

    Result := 0;

    for i := 0 to ACount - 1 do
    begin
      N := Format('%stoken%d', [APrefix, i]);
      if not LNode.AttrExists(N) then
        Continue;

      S := LNode.GetAttr(N);
      if S<>'' then
        Tokens[APart][i] := FScheme.FParser.GetTokenProps(S)
      else
        FScheme.FParser.RaiseSyntaxSchemeErrorF(SLMDSedInvalidTokenReference, [N]);

      Inc(Result);
    end;
  end;
var
  T:   TLMDString;
  N:   ILMDXmlNode;
  Cnt: Integer;
begin
  inherited Create(ANode, AScheme, 0);

  StartRegex := nil;
  EndRegex := nil;

  LineBound := False;
  if ANode.AttrExists('lineBound') then
    LineBound := GetBool(ANode, 'lineBound', FScheme.FParser);

  T := LMDTrim(LMDLowerCase(ANode.NodeName));

  if T = 'regex' then
  begin
    StartRegex := GetRegex(ANode, ANode, 'regex', FScheme.FParser, FScheme.AllIgnoreCase);
    AddWordSepsChars(StartRegex, ANode, '', FScheme);

    Cnt := LoadTokens(rpBegin, StartRegex.CompiledSubExpCount, '', ANode);
    if ANode.AttrExists('innerScheme') then
    begin
      if Cnt > 0 then
        FScheme.FParser.RaiseSyntaxSchemeError(SLMDSedRegexNodeInnerSchemeTokenBoth);

      InnerSchemeName := ANode.GetAttr('innerScheme');

      if InnerSchemeName = '' then
        FScheme.FParser.RaiseSyntaxSchemeError(SLMDSedInvalidInnerScheme);
    end;
  end
  else if (T = 'regexblock') or (T = 'chainblock') then
  begin
    HasTokens[rpBegin] := false;
    StartRegex := nil;

    if (T = 'regexblock') then
    begin
      N := ANode.SelectSingleNode('Start');
      StartRegex := GetRegex(ANode, N, 'start', FScheme.FParser, FScheme.AllIgnoreCase);
      if N <> nil then
        AddWordSepsChars(StartRegex, N, '', FScheme)
      else
        AddWordSepsChars(StartRegex, ANode, 'start', FScheme);

      Cnt := 0;
      if N <> nil then
        Cnt := LoadTokens(rpBegin, StartRegex.CompiledSubExpCount, '', N);

      if (N = nil) or (Cnt = 0) then
        Cnt := LoadTokens(rpBegin, StartRegex.CompiledSubExpCount, 'start_', ANode);

      HasTokens[rpBegin] := Cnt > 0;

      CloseInnerSchemesOnMatchEnd := ANode.AttrExists('closeInnerSchemes') and
                                     GetBool(ANode, 'closeInnerSchemes', FScheme.FParser);

      if FInnerContentGroup >= StartRegex.CompiledSubExpCount then
        FScheme.FParser.RaiseSyntaxSchemeErrorF(SLMDSedInnerContentGoupBadIndex,
                                                [StartRegex.CompiledSubExpCount]);
    end
    else if (T = 'chainblock') then
    begin
      Name := '';
      if ANode.AttrExists('name') then
        Name := FScheme.Name + SCHEME_DOC_SEPARATOR + ANode.GetAttr('name');

      if (Name = '') or (FScheme.FindRule(Name) <> nil) then
        FScheme.FParser.RaiseSyntaxSchemeError(SLMDSedChainBlockShouldHaveUniqueNameInScheme);
    end
    else
      Assert(False, Format('TRegexRule.CreateRule: %s', [T]));


    N := ANode.SelectSingleNode('End');
    EndRegex := GetRegex(ANode, N, 'end', FScheme.FParser, FScheme.AllIgnoreCase);
    if N <> nil then
      AddWordSepsChars(EndRegex, N, '', FScheme)
    else
      AddWordSepsChars(EndRegex, ANode, 'end', FScheme);

    Cnt := 0;
    if N <> nil then
      Cnt := LoadTokens(rpEnd, EndRegex.CompiledSubExpCount, '', N);

    if (N = nil) or (Cnt = 0) then
      Cnt := LoadTokens(rpEnd, EndRegex.CompiledSubExpCount, 'end_', ANode);

    HasTokens[rpEnd] := Cnt > 0;

    InnerSchemeName := ANode.GetAttr('innerScheme');

    if InnerSchemeName = '' then
      FScheme.FParser.RaiseSyntaxSchemeError(SLMDSedInvalidInnerScheme);

    ChainedBlockRuleName := '';
    if ANode.AttrExists('chainBlock') then
      ChainedBlockRuleName := FScheme.Name + SCHEME_DOC_SEPARATOR + ANode.GetAttr('chainBlock');

    IsBlockRule := True;
  end
  else
    Assert(False, Format('TRegexRule.CreateRule: %s', [T]));

  if (InnerSchemeName <> '') and ANode.AttrExists('innerContentGroup') then
    FInnerContentGroup := GetInt(ANode, 'innerContentGroup', FScheme.FParser);

  if StartRegex <> nil then
    AcceptedAnsiChars := StartRegex.GetFirstCharSetAnsi(AcceptUnicodeChars)
  else
  begin
    AcceptedAnsiChars := [];
    AcceptUnicodeChars := false;
  end;

  EndAcceptedAnsiChars := [];
  EndAcceptUnicodeChars := False;

  if EndRegex<>nil then
    EndAcceptedAnsiChars := EndRegex.GetFirstCharSetAnsi(EndAcceptUnicodeChars);
end;

{------------------------------------------------------------------------------}

destructor TRegexRule.Destroy;
begin
  StartRegex.Free;
  EndRegex.Free;

  inherited;
end;

{------------------------------------------------------------------------------}

procedure TRegexRule.MakeMatch(ARegex: TLMDRegExp;
  var Match: TMatchRec; APart: TRulePart);
var
  i, j, ie: Integer;
begin
  Match.Count := ARegex.CompiledSubExpCount;

  ie := Match.Count-1;
  Assert(ie+1 = Length(Self.Tokens[APart]) );

  for i := 0 to ie do
    if (i=0) or (Self.Tokens[APart][i]<>nil) then
    begin
      Match.Starts[i] := ARegex.MatchPos[i];
      Match.Ends[i] := ARegex.MatchPos[i] + ARegex.MatchLen[i];
    end
    else
    begin
      Match.Starts[i] := -1;
      Match.Ends[i] := -1;
    end;

  for i := ie downto 2 do // Matched tokens should not overlap.
  begin
    for j := i-1 downto 1 do
    begin
      Assert((Match.Starts[i]=-1) or (Match.Starts[j] <= Match.Starts[i]));

      if Match.Ends[j] >= Match.Ends[i] then
      begin
        Match.Starts[i] := -1;
        Match.Ends[i] := -1;

        Continue;
      end;
    end;
  end;

  if FInnerContentGroup<>-1 then
  begin
    Match.InnerStart := ARegex.MatchPos[FInnerContentGroup];
    Match.InnerCount := ARegex.MatchLen[FInnerContentGroup];
  end
  else
  begin
    Match.InnerStart := -1;
    Match.InnerCount := 0;
  end;
end;

{------------------------------------------------------------------------------}

function TRegexRule.Match(AStart, ACount, AParserState: Integer;
  var Match: TMatchRec): Boolean;
begin
  Result := False;

  if LineBound and ((AParserState and PARSER_STATE_LINE_BOUND)=0) then
    Exit;

  StartRegex.InputSource := FScheme.FParser.FCharsInput;
  Result := StartRegex.Exec(AStart, ACount);
  if Result then
    MakeMatch(StartRegex, Match, rpBegin);
end;

{------------------------------------------------------------------------------}

function TRegexRule.MatchEnd(AStart, ACount, AParserState: Integer;
  var Match: TMatchRec): Boolean;
var
  o: Integer;
  Inp: TCharsRegexSource;
begin
  Result := False;
  Assert(EndRegex<>nil);

  if LineBound and ((AParserState and PARSER_STATE_LINE_BOUND)=0) then
    Exit;

  Inp := FScheme.FParser.FCharsInput;
  if AStart<Inp.BaseIndex+Inp.Count then
  begin
    o := Ord(FScheme.FParser.FChars[AStart]);

    Result := ( (o>High(Byte)) and EndAcceptUnicodeChars) or
              ( (o<=High(Byte)) and (o in EndAcceptedAnsiChars));
  end
  else
    Result := true;

  if Result then
  begin
    EndRegex.InputSource := Inp;
    Result := EndRegex.Exec(AStart, ACount);
    if Result then
      MakeMatch(EndRegex, Match, rpEnd);
  end;
end;

{------------------------------------------------------------------------------}

procedure TRegexRule.BindVariables(AFiller: TLMDRegExprVariableGetter);
begin
  Assert(EndRegex<>nil);

  EndRegex.InvalidateVariables;
  EndRegex.VariablesGetter := AFiller;

  EndAcceptedAnsiChars := EndRegex.GetFirstCharSetAnsi(EndAcceptUnicodeChars);
end;

{------------------------------------------------------------------------------}

function  TRegexRule.NeedVariables: Boolean;
begin
  result := (EndRegex<>nil) and EndRegex.HasVariables;
end;

{------------------------------------------------------------------------------}

function  TRegexRule.MaxVarId: Integer;
begin
  result := StartRegex.MaxVariableId;
end;

{------------------------------------------------------------------------------}

function  TRegexRule.GetVariable(AId: Integer; var AStart, ACount: Integer): Boolean;
begin
  result := StartRegex.GetVarByID(AId, AStart, ACount);
end;


{******************************* TKeywordsRule ********************************}
{------------------------------------------------------------------------------}

constructor TKeywordsRule.Create(const ANode: ILMDXmlNode;
                                 const AScheme: TScheme);
begin
  inherited Create(ANode, AScheme, -1); // Keywords should have lowest
                                        // default priority.

  Regex := GetRegex(ANode, ANode, 'regex', FScheme.FParser, FScheme.KeywordsIgnoreCase);
  AddWordSepsChars(Regex, ANode, '', FScheme);

  SetupRulePartArray(rpBegin, 3);
  Tokens[rpBegin][1] := FScheme.FParser.GetTokenProps('keyword');
  Tokens[rpBegin][2] := FScheme.FParser.GetTokenProps('id');

  AcceptedAnsiChars := Regex.GetFirstCharSetAnsi(AcceptUnicodeChars);
end;

{------------------------------------------------------------------------------}

destructor TKeywordsRule.Destroy;
begin
  Regex.Free;
end;

{------------------------------------------------------------------------------}

function TKeywordsRule.Match(AStart, ACount: Integer;
  AParserState: Integer; var Match: TMatchRec): Boolean;
begin
  Regex.InputSource := FScheme.FParser.FCharsInput;

  Result := Regex.Exec(AStart, ACount);

  if Result then
  begin
    ACount := Regex.MatchLen[0];

    Match.Starts[0] := AStart;
    Match.Ends[0] := AStart+ACount;

    if FScheme.Keywords.GetKeyword( FScheme.FParser.FChars, AStart, ACount)<>nil
    then
    begin
      Match.Starts[1] := AStart;
      Match.Ends[1] := AStart+ACount;

      Match.Starts[2] := -1;
      Match.Ends[2] := -1;
    end
    else
    begin
      Match.Starts[1] := -1;
      Match.Ends[1] := -1;

      Match.Starts[2] := AStart;
      Match.Ends[2] := AStart+ACount;
    end;

    Match.InnerStart := -1;
    Match.InnerCount := 0;

    Match.Count := 3;
  end;
end;

{------------------------------------------------------------------------------}

function TKeywordsRule.MatchEnd(AStart, ACount: Integer;
  AParserState: Integer; var Match: TMatchRec): Boolean;
begin
  Result := False;
  Assert(False);
end;


{******************************** TContextItem ********************************}
{------------------------------------------------------------------------------}

constructor TContextItem.Create;
begin
  inherited;

  OwnsCustomAttributes := false;
  Clear;
end;

destructor TContextItem.Destroy;
begin
  FreeAttrs(DefaultAttributes, OwnsCustomAttributes);
  
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TContextItem.Assign(AOther: TContextItem);
var
  i, j: Integer;
begin
  CheckEndParentContext := AOther.CheckEndParentContext;

  Scheme := AOther.Scheme;
  SchemeEndRule := AOther.SchemeEndRule;
  CurrentOpenNode := AOther.CurrentOpenNode;
  ParentNode := AOther.ParentNode;
  SyntaxTailCount := AOther.SyntaxTailCount;
  SyntaxTailPos := AOther.SyntaxTailPos;

  SetLength(SyntaxTail, Length(AOther.SyntaxTail));

  for i := 0 to SyntaxTailCount - 1 do
    SyntaxTail[i] := AOther.SyntaxTail[i];

  AssignAttrs(DefaultAttributes, OwnsCustomAttributes,
              AOther.DefaultAttributes, AOther.OwnsCustomAttributes);

  PartRef := AOther.PartRef;
  PartBlock := AOther.PartBlock;

  PartBlockKind := AOther.PartBlockKind;
  PartBlockFirstLine := AOther.PartBlockFirstLine;
  PartBlockLastLine := AOther.PartBlockLastLine;

  OpenSyntaxBlocksCount := AOther.OpenSyntaxBlocksCount;
  SetLength(OpenSyntaxBlocks, Length(AOther.OpenSyntaxBlocks));
  for i := 0 to Length(OpenSyntaxBlocks) - 1 do
  begin
    OpenSyntaxBlocks[i]  := AOther.OpenSyntaxBlocks[i];
    OpenSyntaxBlocks[i].Variables := Copy(AOther.OpenSyntaxBlocks[i].Variables);
    for j:=0 to Length(OpenSyntaxBlocks[i].Variables)-1 do
      OpenSyntaxBlocks[i].Variables[j] := Copy(AOther.OpenSyntaxBlocks[i].Variables[j])
  end;

  SetLength(Variables, Length(AOther.Variables));
  for i := 0 to Length(Variables) - 1 do
    Variables[i]  := AOther.Variables[i];
end;

procedure  TContextItem.GetVariable(AId: Integer; var ARes: TLMDIntArray);
var st, i: Integer;
begin
  if (AId>=Length(Variables)) or
     LMDSegIsBad(Variables[AId]) or
     (Variables[AId].Count=0)
  then
    SetLength(ARes, 0)
  else
  begin
    st := Variables[AId].Start;
    Setlength(ARes, Variables[AId].Count);
    for i:=0 to Variables[AId].Count-1 do
      ARes[i] := Ord(Variables[AId].Source[st+i]);
  end;
end;

procedure TContextItem.GetSyntaxVariable(AId: Integer; var ARes: TLMDIntArray);
var i, L, Count: Integer;
begin
  L := OpenSyntaxBlocksCount-1;
  Assert(OpenSyntaxBlocksCount>0);

  Count := Length(OpenSyntaxBlocks[L].Variables[AId]);

  SetLength(ARes, Count);
  for i:=0 to Count-1 do
    ARes[i] := OpenSyntaxBlocks[L].Variables[AId][i];
end;
{------------------------------------------------------------------------------}

procedure TContextItem.Clear;
begin
  EndOfScheme := -1;
  Prev := nil;
  Scheme := nil;
  SchemeEndRule := nil;
  CurrentOpenNode := nil;
  ParentNode := nil;
  SyntaxTailCount := 0;
  SyntaxTailPos := 0;

  DefaultAttributes.AttributesSet := [];
  DefaultAttributes.TextColor := 0;
  DefaultAttributes.BackgroundColor := 0;
  DefaultAttributes.FontStyle := [];

  if OwnsCustomAttributes then
    DefaultAttributes.CustomAttributes.Free;

  OwnsCustomAttributes := false;
  DefaultAttributes.CustomAttributes := nil;

  OpenSyntaxBlocksCount := 0;
  PartRef := nil;
  PartBlock := nil;
  PartBlockLastLine := -1;
  PartBlockFirstLine := -1;
  PartBlockKind := pbNothing;
  SetLength(Variables, 0);

  CheckEndParentContext := false;
end;

{******************************** TParserContext ******************************}
{------------------------------------------------------------------------------}

constructor TParserContext.Create;
begin
  inherited;

  FTrashCount := 0;
  FTrashMax := 10;
  FTrash := nil;
  FItemsLast := nil;
  FItemsCount := 0;

  Line := -1;
  LastTreeLine := -1;
end;
        
{------------------------------------------------------------------------------}

destructor TParserContext.Destroy;
var
  item: TContextItem;
begin
  while FItemsLast<>nil do
  begin
    item := FItemsLast;
    FItemsLast := FItemsLast.Prev;

    item.Free;
  end;

  while FTrash<>nil do
  begin
    item := FTrash;
    FTrash := FTrash.Prev;

    item.Free;
  end;

  inherited;
end;
         
{------------------------------------------------------------------------------}

function TParserContext.Count: Integer;
begin
  Result := FItemsCount;
end;
      
{------------------------------------------------------------------------------}

function TParserContext.LastItem: TContextItem;
begin
  Result := FItemsLast;
end;
   
{------------------------------------------------------------------------------}

procedure TParserContext.TailItem(AItem: TContextItem;
  var ATail: TContextItem);
begin
  AItem.Prev := ATail;
  ATail := AItem;
end;
            
{------------------------------------------------------------------------------}

procedure TParserContext.Push(const AItem: TContextItem);
begin
  TailItem(AItem, FItemsLast);
  Inc(FItemsCount);
end;

{------------------------------------------------------------------------------}

procedure TParserContext.Clear;
begin
  while FItemsCount>0 do
    Pop;

  Line := -1;
  LastTreeLine := -1;
end;
       
{------------------------------------------------------------------------------}

function TParserContext.CreateItem: TContextItem;
begin
  if FTrashCount=0 then
    Result := TContextItem.Create
  else
  begin
    Assert(FTrash<>nil);

    Dec(FTrashCount);

    Result := FTrash;
    FTrash := FTrash.Prev;

    Result.Clear;
  end;
end;
     
{------------------------------------------------------------------------------}

procedure TParserContext.Pop;
var
  Last: TContextItem;
begin
  Assert(FItemsCount>1);
  Assert(FItemsLast<>nil);

  Last := FItemsLast;
  FItemsLast := Last.Prev;

  if FTrashCount<FTrashMax then
  begin
    Last.Clear;

    TailItem(Last, FTrash);
    Inc(FTrashCount);
  end
  else
    Last.Free;

  Dec(FItemsCount);
end;
          
{------------------------------------------------------------------------------}

function TParserContext.Clone: TParserContext;
var
  item, last, newitem: TContextItem;
begin
  Result := TParserContext.Create;
  Result.Line := Line;
  Result.LastTreeLine := LastTreeLine;

  last := nil;
  item := FItemsLast;

  while item<>nil do
  begin
    newitem := CloneItem(item);
    newitem.Prev := last;
    last := newitem;

    item := item.Prev;
  end;

  while last<>nil do
  begin
    item := last;
    last := last.Prev;

    Result.Push(item);
  end;
end;
             
{------------------------------------------------------------------------------}

function TParserContext.CloneItem(AItem: TContextItem): TContextItem;
begin
  Result := CreateItem;
  Result.Assign(AItem);
end;

{******************************** TSynRegexSource *****************************}
{------------------------------------------------------------------------------}

procedure TSynRegexSource.FillBuffer;
var
  i: Integer;
begin
  for i := FBufferStart to FBufferEnd-1 do
    FBuffer[i - FBufferStart] := FCtxItem.SyntaxTail[i];
end;
      
{------------------------------------------------------------------------------}

procedure TSynRegexSource.Bind(ACtxItem: TContextItem);
begin
  FCtxItem := ACtxItem;
  Reset;
  FIdxEnd := FCtxItem.SyntaxTailCount;
  Count := FCtxItem.SyntaxTailCount;
end;
     
{------------------------------------------------------------------------------}

procedure TSynRegexSource.Reset;
begin
  ResetBuffer;
end;

{***************************** TCharsRegexSource ******************************}
{------------------------------------------------------------------------------}

procedure TCharsRegexSource.FillBuffer;
var
  i: Integer;
begin
  for i := FBufferStart to FBufferEnd-1 do
    FBuffer[i - FBufferStart] := Integer(FSeq[i]);
end;
     
{------------------------------------------------------------------------------}

constructor TCharsRegexSource.Create;
begin
  inherited Create(128, 0);
  FSeq := nil;
end;

{------------------------------------------------------------------------------}

procedure TCharsRegexSource.Bind(const ASeq: TLMDCharSeq; AStart, AEnd: Integer);
begin
  FSeq := ASeq;
  ResetBuffer;

  BaseIndex := AStart;
  FIdxStart := AStart;
  FIdxEnd := AEnd;
  Count := AEnd-AStart;
end;

{******************************** TContextCache *******************************}
{------------------------------------------------------------------------------}

constructor TContextCache.Create;
begin
  inherited;
  FItemsCount := 0;
end;
     
{------------------------------------------------------------------------------}

destructor TContextCache.Destroy;
var
  i: Integer;
begin
  for i := 0 to FItemsCount-1 do
    FItems[i].Free;

  inherited;
end;
      
{------------------------------------------------------------------------------}

function TContextCache.FindContextId(ALine: Integer): Integer;
var
  istart, iend, m: Integer;
begin
  istart := 0;
  iend := FItemsCount;

  while istart<>iend do
  begin
    m := (istart + iend) div 2;

    if FItems[m].Line < ALine then
      istart := m + 1
    else
      iend := m;
  end;
  //FItems[istart].StartLine >= ALine

  Result := istart;
end;
     
{------------------------------------------------------------------------------}

function TContextCache.GetContext(ALine: Integer): TParserContext;
var
  l: Integer;
begin
  Result := nil;
  if FItemsCount=0 then
    Exit;

  l := FindContextId(ALine);

  if (l=FItemsCount) or (FItems[l].Line>ALine) then
    Result := FItems[l-1]
  else
  begin
    Result := FItems[l];
    Assert(Result.Line=ALine);
  end;
end;
       
{------------------------------------------------------------------------------}

function TContextCache.GetLastContext: TParserContext;
begin
  if FItemsCount>0 then
    Result := FItems[FItemsCount-1]
  else
    Result := nil;
end;
    
{------------------------------------------------------------------------------}

procedure TContextCache.KillFrom(ALine: Integer);
var
  i, oldCount: Integer;
begin
  oldCount := FItemsCount;
  FItemsCount := FindContextId(ALine);

  for i := FItemsCount to oldCount - 1 do
  begin
    FItems[i].Free;
    FItems[i] := nil;
  end;
end;
          
{------------------------------------------------------------------------------}

procedure TContextCache.AddContext(ALine: Integer;
  AContext: TParserContext);
var
  NewLn: Integer;
begin
  Assert((FItemsCount=0) or (ALine>GetLastContext.Line));

  Inc(FItemsCount);
  NewLn := GetNewArrLength(FItemsCount, Length(FItems));
  if NewLn<>-1 then
    SetLength(FItems, NewLn);

  FItems[FItemsCount-1] := AContext;
  FItems[FItemsCount-1].Line := ALine;
end;

{***************************** TTokenLineTraits *******************************}
{------------------------------------------------------------------------------}

class function TTokenLineTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := TLMDHashTable.IntHash(TTokenLine(AItem).Line);
end;

{------------------------------------------------------------------------------}

class function TTokenLineTraits.MakeHashK(const AKey): Integer;
begin
  Result := TLMDHashTable.IntHash(Integer(AKey));
end;

{------------------------------------------------------------------------------}

class function TTokenLineTraits.Compare(const AKey; AItem: TObject): Boolean;
begin
  Result := Integer(AKey) = TTokenLine(AItem).Line;
end;

{********************************* TTokenCache ********************************}
{------------------------------------------------------------------------------}

procedure TTokenCache.Detach(ALine: TTokenLine);
begin
  if FListTail=ALine then
    FListTail := ALine.FPrev;

  if FListHead=ALine then
    FListHead := ALine.FNext;

  if ALine.FNext<>nil then
    ALine.FNext.FPrev := ALine.FPrev;

  if ALine.FPrev<>nil then
    ALine.FPrev.FNext := ALine.FNext;

  ALine.FPrev := nil;
  ALine.FNext := nil;
end;
      
{------------------------------------------------------------------------------}

procedure TTokenCache.MoveToHead(ALine: TTokenLine);
begin
  // Move line to head.
  Detach(ALine);

  if FListHead<>nil then
    FListHead.FPrev := ALine;

  ALine.FNext := FListHead;
  ALine.FPrev := nil;

  FListHead := ALine;

  if FListTail=nil then
    FListTail := ALine;
end;
     
{------------------------------------------------------------------------------}

procedure TTokenCache.MoveToTrash(ALine: TTokenLine);
begin
  HashRemove(ALine.Line);

  Detach(ALine);
  ALine.Clear;

  ALine.FPrev := FTrashTail;
  ALine.FNext := nil;
  FTrashTail := ALine;

  Dec(FCount);
end;

{------------------------------------------------------------------------------}

procedure TTokenCache.HashFree;
var
    i: Integer;
    tmp, itm: TTokenCacheItem;
begin
  for i := 0 to FHashMask do
  begin
    itm := FHash[i];

    while itm <> nil do
    begin
      tmp := itm;
      itm := itm.Next;

      tmp.Free;
    end;
  end;

  SetLength(FHash, 0);
  FHashCount := 0;
end;

{------------------------------------------------------------------------------}

procedure TTokenCache.HashRemove(ALine: Integer);
var
    i: Integer;
    prev, itm: TTokenCacheItem;
begin
  i := MakeIntHash(ALine) and FHashMask;

  prev := nil;
  itm := FHash[i];
  while itm <> nil do
  begin
    if itm.TokLine.Line = ALine then
    begin
      if prev <> nil then
        prev.Next := itm.Next
      else
        FHash[i] := itm.Next;

      itm.Free;

      Dec(FHashCount);
      Exit;
    end
    else
    begin
      prev := itm;

      itm := itm.Next;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TTokenCache.HashAdd(ALine: TTokenLine);
var
    i: Integer;
    itm: TTokenCacheItem;
begin
  i := MakeIntHash(ALine.Line) and FHashMask;

  itm := TTokenCacheItem.Create;

  itm.TokLine := ALine;
  itm.Next := FHash[i];

  FHash[i] := itm;

  Inc(FHashCount);
end;

{------------------------------------------------------------------------------}

function  TTokenCache.HashFind(ALine: Integer): TTokenLine;
var
    i, h: Integer;
    itm: TTokenCacheItem;
begin
  Result := nil;

  H := ALine + (not (ALine shl 9));
  H := H xor (H shr 14);
  H := H + (H shl 4);
  H := H xor (H shr 10);

  i := H and FHashMask;

  itm := FHash[i];
  while itm <> nil do
  begin
    if itm.TokLine.Line = ALine then
    begin
      Result := itm.TokLine;
      Exit;
    end
    else
      itm := itm.Next;
  end;
end;

{------------------------------------------------------------------------------}

constructor TTokenCache.Create(AMaxSize: Integer);
begin
  inherited Create;

  MaxCount := AMaxSize;
  FCount := 0;

  FHashCount := 0;
  FHashMask := 255;
  SetLength(FHash, FHashMask + 1);

  FListHead := nil;
  FListTail := nil;
  FTrashTail := nil;
end;

{------------------------------------------------------------------------------}

destructor TTokenCache.Destroy;
var
  Line, tmp: TTokenLine;
begin
  HashFree;

  Line := FListTail;
  while Line <> nil do
  begin
    tmp := Line;
    Line := tmp.FPrev;

    tmp.Free;
  end;

  Line := FTrashTail;
  while Line<>nil do
  begin
    tmp := Line;
    Line := tmp.FPrev;

    tmp.Free;
  end;

  inherited;
end;
   
{------------------------------------------------------------------------------}

function TTokenCache.GetLine(ALine: Integer): TTokenLine;
begin
  Result := HashFind(ALine);

  if Result <> nil then
    MoveToHead(Result);
end;

{------------------------------------------------------------------------------}

function TTokenCache.CreateLine(ALine: Integer; AChars: TLMDCharSeq): TTokenLine;
begin
  Assert(HashFind(ALine)=nil);

  if FCount < MaxCount then
  begin
    if FTrashTail=nil then
      Result := TTokenLine.Create
    else
    begin
      Result := FTrashTail;
      FTrashTail := Result.FPrev;

      Result.FPrev := nil;
      Assert(Result.FNext=nil);
      Assert(Result.Line=-1);
    end;

    Inc(FCount);
    MoveToHead(Result);
  end
  else
  begin
    Result := FListTail;
    HashRemove(Result.Line);
    MoveToHead(Result);
    Result.Clear;
  end;

  Result.FChars := AChars;
  Result.Line := ALine;
  HashAdd(Result);
end;
   
{------------------------------------------------------------------------------}

procedure TTokenCache.KillFrom(ALine: Integer);
var
  line, old: TTokenLine;
begin
  line := FListHead;
  while line<>nil do
  begin
    if line.Line>=ALine then
    begin
      old := line;
      line := line.FNext;

      MoveToTrash(old);
    end
    else
      line := line.FNext;
  end;
end;

{********************************* TTokenLine *********************************}
{------------------------------------------------------------------------------}

constructor TTokenLine.Create;
begin
  inherited;

  FChars := nil;
  Clear;

  FPrev := nil;
  FNext := nil;
end;

{------------------------------------------------------------------------------}

procedure TTokenLine.AddItem(const AItem: TTokenLineItem);
var
  NewLn: Integer;
begin
  if FTokenCount>0 then
    with FTokens[FTokenCount-1] do
      Assert(AItem.Start=(Start+Count));

  if (FTokenCount>0) and (AItem.Token=FTokens[FTokenCount-1].Token) then
    Inc(FTokens[FTokenCount-1].Count, AItem.Count)
  else
  begin
    Inc(FTokenCount);

    NewLn := GetNewArrLength(FTokenCount, Length(FTokens));
    if NewLn<>-1 then
      SetLength(FTokens, NewLn);

    FTokens[FTokenCount-1] := AItem;
  end;
end;
  
{------------------------------------------------------------------------------}

procedure TTokenLine.Clear;
var
    i: Integer;
begin
  for i := 0 to FTokenCount - 1 do
  begin
    if FTokens[i].OwnsCustomAttrs then
      FreeAttrs(FTokens[i].RuntimeAttributes, FTokens[i].OwnsCustomAttrs);
  end;

  FTokenCount := 0;
  Line := -1;
end;

{------------------------------------------------------------------------------}

function TTokenLine.TokenCount: Integer;
begin
  Result := FTokenCount;
end;

{------------------------------------------------------------------------------}

function TTokenLine.GetTokenIdx(ACol: Integer): Integer;

  procedure RaiseErr;
  begin
    raise ELMDEditParserError.Create(SLMDSedEmptyTokenLine);
  end;

var
    Off, L, R, M: Integer;
begin
  if FTokenCount = 0 then
    RaiseErr;

  Off := FTokens[0].Start + ACol;
  L := 0; R := FTokenCount;

  while L < R do
  begin
    M := (L + R) div 2;

    if FTokens[M].Start <= Off then
      L := M+1
    else
      R := M;
  end;

  Assert(L > 0);
  Result := L - 1;
end;

{------------------------------------------------------------------------------}

function TTokenLine.GetTokens(AStart, ACount: Integer;
                              var Arr: TLMDEditParsedTokenArray): Integer;
var
    i, Ln: Integer;
    PItm: ^TTokenLineItem;
    PArr: ^TLMDEditParsedToken;
    Seg: TLMDSegment;


  procedure RaiseErr;
  begin
    raise ELMDEditParserError.CreateFmt(SLMDSedBadTokenIdx, [AStart, 0, FTokenCount-1]);
  end;
begin
  if AStart >= FTokenCount then
    RaiseErr;

  i := 0;
  Ln := Min(Length(Arr), Min(FTokenCount - AStart, ACount));

  while i < Ln do
  begin
    PItm := @FTokens[AStart + i];
    PArr := @Arr[i];

    PArr.Attrs := PItm.RuntimeAttributes;
    PArr.TokenID := PItm.Token.ID;

    Seg.Start := PItm.Start;
    Seg.Count := PItm.Count;
    Seg.Source := FChars;

    PArr.Seg := Seg;

    Inc(i);
  end;

  Result := Ln;
end;

{*************************** TParserNodeStartTraits ***************************}
{------------------------------------------------------------------------------}

class function TParserNodeStartTraits.Compare(const AKey;
  AItem: TObject): Boolean;
begin
  Result := Integer(AKey) = TParserNode(AItem).StartLine;
end;
      
{------------------------------------------------------------------------------}

class function TParserNodeStartTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := TLMDHashTable.IntHash(TParserNode(AItem).StartLine);
end;
     
{------------------------------------------------------------------------------}

class function TParserNodeStartTraits.MakeHashK(const AKey): Integer;
begin
  Result := TLMDHashTable.IntHash(Integer(AKey));
end;

{*************************** TParserNodeEndTraits *****************************}
{------------------------------------------------------------------------------}

class function TParserNodeEndTraits.Compare(const AKey; AItem: TObject): Boolean;
begin
  Result := Integer(AKey) = TParserNode(AItem).EndLine;
end;
      
{------------------------------------------------------------------------------}

class function TParserNodeEndTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := TLMDHashTable.IntHash(TParserNode(AItem).EndLine);
end;
      
{------------------------------------------------------------------------------}

class function TParserNodeEndTraits.MakeHashK(const AKey): Integer;
begin
  Result := TLMDHashTable.IntHash(Integer(AKey));
end;

{******************************** TParserNode *********************************}
{------------------------------------------------------------------------------}

constructor TParserNode.Create;
begin
  inherited;

  StartLine := -1;
  EndLine := -1;
  Parent := nil;
  SchemeParent := nil;
  ChildCount := 0;
end;

{********************************* TParserTree ********************************}
{------------------------------------------------------------------------------}

procedure TParserTree.FreeNode(ANode: TParserNode);
var
  o: TObject;
begin
  Assert(ANode.StartLine <> -1);

  o := FStartsHash.Find(ANode.StartLine);
  Assert(o <> nil);

  if o = ANode then
    FStartsHash.Remove(ANode.StartLine);

  if ANode.EndLine <> -1 then
  begin
    o := FEndsHash.Find(ANode.EndLine);
    Assert(o <> nil);

    if o = ANode then
      FEndsHash.Remove(ANode.EndLine);
  end;

  ANode.Free;
end;

{------------------------------------------------------------------------------}

procedure TParserTree.SetChildCount(ANode: TParserNode; ACount: Integer);
var
  I, NewLn: Integer;
begin
  if ANode.ChildCount=ACount then
    Exit;

  if ANode.ChildCount>ACount then
    for I := ACount to ANode.ChildCount - 1 do
    begin
      if ANode.Childs[i]<>nil then
        FreeNodeRec(ANode.Childs[i]);

      ANode.Childs[i] := nil;
    end;

  NewLn := GetNewArrLength(ACount, Length(ANode.Childs));
  if NewLn<>-1 then
    SetLength(ANode.Childs, NewLn);

  ANode.ChildCount := ACount;
end;
            
{------------------------------------------------------------------------------}

function TParserTree.AddAsLast(AParent: TParserNode;
  ALine: Integer): TParserNode;
var
  l: Integer;
begin
  l := AParent.ChildCount+1;
  SetChildCount(AParent, l);

  Result := TParserNode.Create;
  AParent.Childs[l-1] := Result;

  Result.Parent := AParent;
  Result.StartLine := ALine;

  if FStartsHash.Find(ALine) = nil then
    FStartsHash.Add(Result);

  Assert(ALine>=LastKnownLine);
  LastKnownLine := ALine;
end;
           
{------------------------------------------------------------------------------}

procedure TParserTree.CommitLastNode(ANode: TParserNode);
begin
  if FEndsHash.Find(ANode.EndLine)<>nil then
    FEndsHash.Remove(ANode.EndLine);

  FEndsHash.Add(ANode);

  Assert(ANode.EndLine>=LastKnownLine);
  LastKnownLine := ANode.EndLine;
end;
       
{------------------------------------------------------------------------------}

constructor TParserTree.Create;
begin
  inherited Create;

  LastKnownLine := -1;
  FStartsHash := TLMDHashTable.Create(TParserNodeStartTraits);
  FEndsHash := TLMDHashTable.Create(TParserNodeEndTraits);

  Root := TParserNode.Create;
end;
            
{------------------------------------------------------------------------------}

destructor TParserTree.Destroy;
begin
  KillFrom(0);
  Root.Free;
  FStartsHash.Free;
  FEndsHash.Free;
  inherited;
end;
         
{------------------------------------------------------------------------------}

function TParserTree.FindParent(ALine: Integer): TParserNode;

  function FindParentLow(ANode: TParserNode): TParserNode;
  var
    istart, iend,
    m, l:          Integer;
    child:         TParserNode;
  begin
    Assert(ALine>=ANode.StartLine);
    if ANode.EndLine<>-1 then
      Assert(ANode.EndLine >= ALine);

    istart := 0;
    iend := ANode.ChildCount;

    while istart<>iend do
    begin
      m := istart + ((iend - istart) div 2);

      if m=ANode.ChildCount then
        l := MaxInt
      else
        l := ANode.Childs[m].StartLine;

      if l > ALine then
        iend := m
      else
        istart := m + 1
    end;
    //ANode.Childs[istart].StartLine > ALine

    if istart=0 then
      Result := ANode // Will give outer (most parent) node while multiple
                      // starts at same line.
    else
    begin
      Child := ANode.Childs[istart-1];

      if (Child.StartLine<ALine) and ((Child.EndLine=-1) or (ALine<=Child.EndLine)) then
        Result := FindParentLow(Child) // Will give inner (most child) node
                                       // while multiple ends at same line.
      else
        Result := ANode;
    end;

    Assert(Result.StartLine <= ALine);
    if Result.EndLine<>-1 then
      Assert(Result.EndLine >= ALine);
  end;

begin
  Result := FindParentLow(Root);
end;

{------------------------------------------------------------------------------}

procedure TParserTree.FreeNodeRec(AParent: TParserNode);
var
  i: Integer;
begin
  for i := 0 to AParent.ChildCount-1 do
    FreeNodeRec(AParent.Childs[i]);

  FreeNode(AParent);
end;

{------------------------------------------------------------------------------}

procedure TParserTree.KillFrom(ALine: Integer);

  procedure KillFromLow(ANode: TParserNode);
  var
    i, istart,
    iend, m:   Integer;
    o:         TObject;
  begin
    Assert(ALine > ANode.StartLine);

    if (ANode.EndLine <> -1) and (ALine > ANode.EndLine) then
    begin
      LastKnownLine := ANode.EndLine;
      Exit;
    end;

    istart := 0;
    iend := ANode.ChildCount;

    while istart <> iend do
    begin
      m := (istart + iend) div 2;

      if ANode.Childs[m].StartLine < ALine then
        istart := m + 1
      else
        iend := m;
    end;
    // Lower bound
    // ANode.Childs[m].StartLine >= ALine

    for i := istart to ANode.ChildCount - 1 do
      FreeNodeRec(ANode.Childs[i]);

    ANode.ChildCount := istart;

    if istart > 0 then
      KillFromLow(ANode.Childs[istart - 1])
    else
      LastKnownLine := ANode.StartLine;

    if ANode.EndLine <> -1 then
    begin
      o := FEndsHash.Find(ANode.EndLine);
      Assert(o <> nil);

      if o = ANode then
        FEndsHash.Remove(ANode.EndLine)
      else
      begin
        //It's some of my parents (ANode)
        Assert( TParserNode(o).StartLine <= ANode.StartLine );
      end;

      ANode.EndLine := -1;
    end;
  end;

begin
  KillFromLow(Root);
end;

{------------------------------------------------------------------------------}

function TParserTree.LineStartToNode(ALine: Integer): TParserNode;
begin
  Result := TParserNode( FStartsHash.Find(ALine) );
end;

{------------------------------------------------------------------------------}

function TParserTree.LineEndToNode(ALine: Integer): TParserNode;
begin
  Result := TParserNode( FEndsHash.Find(ALine) );
end;

{******************************** TParserImpl *********************************}
{------------------------------------------------------------------------------}

procedure TParserImpl.SetDocument(ADoc: TLMDEditDocument);
begin
  Refresh;

  Assert(ADoc<>nil);
  FDoc := ADoc;
end;

procedure TParserImpl.SetMaxLineLengthToParse(AValue: Integer);
begin
  Refresh;

  FMaxLineLengthToParse := AValue;
end;

{------------------------------------------------------------------------------}

procedure TParserImpl.LineChanged(ALine: Integer);
begin
  LinesChangedFrom(ALine);
end;
  
{------------------------------------------------------------------------------}

procedure TParserImpl.LinesChangedFrom(AStart: Integer);
begin
  KillCachesFrom(AStart);
end;
   
{------------------------------------------------------------------------------}

procedure TParserImpl.Refresh;
begin
  KillCachesFrom(0);
end;
   
{------------------------------------------------------------------------------}

procedure TParserImpl.KillCachesFrom(ALine: Integer);
var
  LastTreeLine: Integer;
begin
  FContextCache.KillFrom(ALine);

  if FContextCache.GetLastContext <> nil then
  begin
    LastTreeLine := FContextCache.GetLastContext.LastTreeLine;
    ALine := FContextCache.GetLastContext.Line;
  end
  else
  begin
    ALine := 0;
    LastTreeLine := -1;
  end;

  Assert(LastTreeLine < ALine);

  FTokenCache.KillFrom(ALine);
  FParseTree.KillFrom(LastTreeLine+1);
  FLastValidLine := ALine-1;
end;

{------------------------------------------------------------------------------}

function  TParserImpl.GetParsedLine(ALine: Integer): TLMDEditParsedLine;

  procedure RaiseErr;
  begin
    raise ELMDEditParserError.CreateFmt(SLMDSedInvalidLineIdx,
                                        [ALine, 0, FDoc.LinesCount-1]);
  end;

begin
  if ALine >= FDoc.LinesCount then
    RaiseErr;

  if FSchemeLoaded then
  begin
    Result := FTokenCache.GetLine(ALine);
    if Result = nil then
      BuildCachesFrom(ALine);

    Result := FTokenCache.GetLine(ALine);
  end
  else
    Result := FDummyTokLine;
end;

procedure TParserImpl.MarkTokens(ALine: Integer;
                                 AHandler: TLMDTokenHandler);
var
  TokLine:   TTokenLine;
  i, Ln, id: Integer;
  LineSeg, Seg:       TLMDSegment;
  Attrs:     TLMDEditAttributes;
begin
  Assert(ALine < FDoc.LinesCount);

  if FSchemeLoaded then
  begin
    TokLine := FTokenCache.GetLine(ALine);
    if TokLine=nil then
      BuildCachesFrom(ALine);

    LineSeg := FDoc.LineSegments[ALine];
    TokLine := FTokenCache.GetLine(ALine);

    Ln := TokLine.TokenCount;
    for i:=0 to Ln-1 do
    begin
      Seg := LMDSegment(TokLine.FTokens[i].Start,
                        TokLine.FTokens[i].Count,
                        FChars);

      id := TokLine.FTokens[i].Token.ID;

      AHandler.HandleToken(Seg, id, TokLine.FTokens[i].RuntimeAttributes);
    end;
  end
  else
  begin
    Seg := FDoc.LineSegments[ALine];

    Attrs.BackgroundColor := clBackground;
    Attrs.TextColor := clCaptionText;
    Attrs.AttributesSet := [asBackgroundColor, asTextColor];
    Attrs.FontStyle := [];
    Attrs.CustomAttributes := nil;

    AHandler.HandleToken(Seg, 0, Attrs);
  end;
end;

{------------------------------------------------------------------------------}

procedure TParserImpl.BuildCachesFrom(ALine: Integer);

var
  TokenLine:   TTokenLine;
  LineSeg:     TLMDSegment;
  CurLine:     Integer;
  ParserState: Integer;
  CharsCount:  Integer;

  procedure SetAttrs(const Defaults: TLMDEditAttributes;
                     DefaultsOwnsCustom: Boolean;
                     const NewAttrs: TLMDEditAttributes;
                     var Dest: TLMDEditAttributes;
                     var DestOwnsCustom: Boolean);
  var
    aset: TLMDEditAttributesSet;
  begin
    aset := NewAttrs.AttributesSet;

    Dest := Defaults;
    Dest.CustomAttributes := nil;

    if asBackgroundColor in aset then
      Dest.BackgroundColor := NewAttrs.BackgroundColor;

    if asTextColor in aset then
      Dest.TextColor := NewAttrs.TextColor;

    if asFontStyle in aset then
      Dest.FontStyle := Dest.FontStyle + NewAttrs.FontStyle;

    if (asCustomAttributes in aset) and
       (asCustomAttributes in Defaults.AttributesSet)
    then
    begin
      Assert(Defaults.CustomAttributes<>nil);
      Assert(NewAttrs.CustomAttributes<>nil);

      Dest.CustomAttributes := Defaults.CustomAttributes.Clone;
      Dest.CustomAttributes.Merge(NewAttrs.CustomAttributes);
      DestOwnsCustom := true;
    end
    else if asCustomAttributes in aset then
    begin
      Assert(NewAttrs.CustomAttributes<>nil);

      Dest.CustomAttributes := NewAttrs.CustomAttributes;
      DestOwnsCustom := false;
    end
    else if asCustomAttributes in Defaults.AttributesSet then
    begin
      Assert(Defaults.CustomAttributes<>nil);

      DestOwnsCustom := DefaultsOwnsCustom;

      if DefaultsOwnsCustom then
        Dest.CustomAttributes := Defaults.CustomAttributes.Clone
      else
        Dest.CustomAttributes := Defaults.CustomAttributes;
    end;

    Dest.AttributesSet := Dest.AttributesSet + aset;
  end;

  procedure ProcessLine(AContext: TParserContext;
                        ADoTokensLine, ADoTree: Boolean);

  var
    CtxItem:       TContextItem;
    LineItem:      TTokenLineItem;
    SynTokenAdded: Boolean;

    procedure TailCut;
    begin
      if CtxItem.SyntaxTailCount>0 then
        CtxItem.SyntaxTail[0] := -1;

      CtxItem.SyntaxTailCount := 0;
      CtxItem.SyntaxTailPos := 0;
      CtxItem.PartRef := nil;

      FSyntaxInput.Reset;
    end;

    procedure ContextPop;
    begin
      AContext.Pop;
      CtxItem := AContext.LastItem;
      SynTokenAdded := False;
    end;

    procedure ContextPush(AItem: TContextItem);
    begin
      AContext.Push(AItem);
    end;

    procedure TailAddToken(AProps: TTokenProps; AStart, ACount: Integer);
    var
      id, L, NewLn: Integer;
      kw:           TKeyword;
      map:          TKeywordMap;
    begin
      if (not ADoTree) or
         (CtxItem.Scheme.SynBlocksHash=nil) or
         (CtxItem.Scheme.SynBlocksHash.Count=0)
      then
        Exit;

      if CtxItem.Scheme.SkipSyntaxTokens[AProps.ID] then
        Exit;

      if CtxItem.Scheme.AllIgnoreCase or
         ((AProps=FTokenKeyword) and CtxItem.Scheme.KeywordsIgnoreCase)
      then
        map := AProps.ContentMapCI
      else
        map := AProps.ContentMap;

      if AStart<>-1 then
        kw := map.GetKeyword(FChars, AStart, ACount)
      else
        kw := nil;

      if kw<>nil then
        id := kw.ID
      else
        id := AProps.DefaultContentID;

      Inc(CtxItem.SyntaxTailCount);
      L := CtxItem.SyntaxTailCount;

      NewLn := GetNewArrLength(L, Length(CtxItem.SyntaxTail));
      if NewLn<>-1 then
        SetLength(CtxItem.SyntaxTail, NewLn);

      CtxItem.SyntaxTail[L-1] := id;
      SynTokenAdded := True;
    end;

    function TopBlock: TOpenBlock;
    begin
      Result := CtxItem.OpenSyntaxBlocks[CtxItem.OpenSyntaxBlocksCount-1];
    end;

    procedure CloseBlock;
      procedure PopBlock;
      begin
        Dec(CtxItem.OpenSyntaxBlocksCount);
        with CtxItem.OpenSyntaxBlocks[CtxItem.OpenSyntaxBlocksCount] do
        begin
          Block := nil;
          StartLine := -1;
          EndLine := -1;
          HasNode := False;
        end;
      end;

    var
      top:  TOpenBlock;
      CurN: TParserNode;
    begin
      Assert(CtxItem.OpenSyntaxBlocksCount>0);
      top := TopBlock;

      if top.HasNode then
      begin
        // Close node.
        Assert(top.Block.Capture);

        CurN := CtxItem.CurrentOpenNode;

        CtxItem.CurrentOpenNode := CurN.SchemeParent;
        CtxItem.ParentNode := CurN.Parent;

        if ADoTree then
        begin
          CurN.EndLine := CtxItem.PartBlockLastLine;
          FParseTree.CommitLastNode(CurN);
        end
        else
          Assert(CurN.EndLine=CtxItem.PartBlockLastLine);
      end;

      PopBlock;
    end;

    function TryOpenBlock(AItem: TContextItem; AIdx: Integer; AForce: Boolean): Boolean;
    var
      NewNode:  TParserNode;
      Diff:     Integer;
      DoCreate: Boolean;
      Prev: TContextItem;
    begin
      if AIdx >= 0 then
      begin
        with AItem.OpenSyntaxBlocks[AIdx] do
        begin
          Diff := CurLine - StartLine;

          DoCreate := (Block.Capture and (not HasNode) and
                       (not DontCreateNode)) and
                       (AForce or (Diff >= Block.MinLines))
        end;
      end
      else
        DoCreate := False;

      if AIdx > 0 then
        Result := TryOpenBlock(AItem, AIdx-1, DoCreate)
      else if AItem.Prev = nil then
        Result := True
      else if AItem.Prev.PartBlockKind = pbNothing then
        Result := TryOpenBlock(AItem.Prev, AItem.Prev.OpenSyntaxBlocksCount-1, DoCreate)
      else
        Result := False;

      if DoCreate and Result then
      begin
        Prev := AItem.Prev;

        while (AItem.ParentNode = nil) and (Prev <> nil) do
        begin
          AItem.ParentNode := Prev.ParentNode;
          Prev := Prev.Prev;
        end;

        NewNode := FParseTree.AddAsLast(AItem.ParentNode,
                                        AItem.OpenSyntaxBlocks[AIdx].StartLine);
        NewNode.EndLine := -1;
        NewNode.SchemeParent := AItem.CurrentOpenNode;

        AItem.CurrentOpenNode := NewNode;
        AItem.ParentNode := NewNode;

        AItem.OpenSyntaxBlocks[AIdx].HasNode := True;
      end;
    end;

    procedure ProcessSynCache(AEndOfTokens: Boolean);

      procedure PushBlock(const ABlock: TSyntaxBlock;
                          AStart, AEnd: Integer;
                          ADontCreate: Boolean);
      var
        L, NewLn: Integer;

        StartRe, EndRe: TLMDRegExp;
        VarCnt, i, j, Start, Count: Integer;
      begin
        Inc(CtxItem.OpenSyntaxBlocksCount);
        L := CtxItem.OpenSyntaxBlocksCount;

        NewLn := GetNewArrLength(L, Length(CtxItem.OpenSyntaxBlocks));
        if NewLn <> -1 then
          SetLength(CtxItem.OpenSyntaxBlocks, NewLn);

        with CtxItem.OpenSyntaxBlocks[L-1] do
        begin
          Block := ABlock;
          StartLine := AStart;
          EndLine := AEnd;
          HasNode := False;
          DontCreateNode := ADontCreate;

          StartRe := Block.StartRegex;
          EndRe := Block.EndRegex;

          if EndRe.HasVariables then
          begin
            VarCnt := StartRe.MaxVariableId + 1;
            SetLength(Variables, VarCnt);

            for i := 0 to VarCnt - 1 do
            begin
              if not StartRe.GetVarByID(i, Start, Count) then
              begin
                Start := -1;
                Count := 0;
              end;

              SetLength(Variables[i], Count);
              for j := 0 to Count - 1 do
                Variables[i][j] := CtxItem.SyntaxTail[j + Start];
            end
          end
          else
            SetLength(Variables, 0);
        end;

        if (ABlock.Capture) and (not ADontCreate) then
          TryOpenBlock(CtxItem, L-1, False);
      end;

      procedure ClearPartBlock;
      begin
        CtxItem.PartBlockKind := pbNothing;
        CtxItem.PartRef := nil;
        CtxItem.PartBlock := nil;
        CtxItem.PartBlockFirstLine := -1;
        CtxItem.PartBlockLastLine := -1;
      end;

      procedure TryStartBlock(Cnt: Integer; out NeedMore, Found: Boolean;
        out Re: TLMDRegExp);
      var
        Code:  Integer;
        Block: TSyntaxBlock;
        Ref:   TRuleRef;
      begin
        Found := False; NeedMore := False;

        if CtxItem.OpenSyntaxBlocksCount > 0 then // Find closing expression.
        begin
          Block := TopBlock.Block;
          Re := Block.EndRegex;

          Code := CtxItem.SyntaxTail[CtxItem.SyntaxTailPos];

          Found := ( (Code > High(Byte)) and Block.EndAcceptUnicodeChars) or
                   ( (Code <= High(Byte)) and (Code in Block.EndAcceptedAnsiChars));

          if Found then
          begin
            { TODO : Optimize it??? }
            if Re.HasVariables then
            begin
              Re.VariablesGetter := CtxItem.GetSyntaxVariable;
              Re.InvalidateVariables;
            end;

            Re.InputSource := FSyntaxInput;
            Found := Re.Exec(CtxItem.SyntaxTailPos, Cnt, NeedMore);
          end;

          if Found or NeedMore then
          begin
            CtxItem.PartBlockKind := pbEnd;
            CtxItem.PartBlock := Block;
            CtxItem.PartRef := nil;
            CtxItem.PartBlockFirstLine := CurLine;
            CtxItem.PartBlockLastLine := CurLine;
          end;
        end;

        if not (Found or NeedMore) then // Find open expression.
        begin
          Code := CtxItem.SyntaxTail[CtxItem.SyntaxTailPos];

          Ref := CtxItem.Scheme.SynBlocksHash.GetRuleChain(Code);
          while Ref <> nil do
          begin
            Re := Ref.SynBlock.StartRegex;
            Re.InputSource := FSyntaxInput;

            Found := Re.Exec(CtxItem.SyntaxTailPos, Cnt, NeedMore);
            if Found or NeedMore then
            begin
              CtxItem.PartBlockKind := pbStart;
              CtxItem.PartBlock := nil;
              CtxItem.PartRef := Ref;
              CtxItem.PartBlockFirstLine := CurLine;
              CtxItem.PartBlockLastLine := CurLine;

              Break;
            end;

            Ref := Ref.Next;
          end;
        end;
      end;


    type
      TState = (stTest, stHandle);
    var
      Re:              TLMDRegExp;
      state:           TState;
      NeedMore, Found: Boolean;
      Group, Cnt:      Integer;
      Kind:            TPartBlockKind;
    begin
      if (not ADoTree) or
         (CtxItem.Scheme.SynBlocksHash = nil) or
         (CtxItem.Scheme.SynBlocksHash.Count = 0) or
         (CtxItem.SyntaxTailCount = 0)
      then
        Exit;

      if not (SynTokenAdded or AEndOfTokens) then
        Exit;

      FSyntaxInput.Bind(CtxItem);

      // Here: (Pos=0)--------        - just new tokens  - pbNothing
      //       ------Pos=====#----    - partial match with new tokens added - not pbNothing

      state := stTest;
      while CtxItem.SyntaxTailPos < CtxItem.SyntaxTailCount do
      begin
        Cnt := CtxItem.SyntaxTailCount - CtxItem.SyntaxTailPos;

        case state of
          stTest:
          begin
            Kind := CtxItem.PartBlockKind;

            case Kind of
              pbNothing:
                TryStartBlock(Cnt, NeedMore, Found, Re);

              pbStart, pbEnd:
              begin
                if Kind = pbStart then
                  Re := CtxItem.PartRef.SynBlock.StartRegex
                else
                  Re := CtxItem.PartBlock.EndRegex;

                Re.InputSource := FSyntaxInput;
                Found := Re.Exec(CtxItem.SyntaxTailPos, Cnt, NeedMore);
              end;
            end;

            if Found or NeedMore then
              state := stHandle
            else if (Kind = pbStart) and (CtxItem.PartRef.Next <> nil) then
              CtxItem.PartRef := CtxItem.PartRef.Next
            else
            begin
              Inc(CtxItem.SyntaxTailPos);
              ClearPartBlock;
            end;
          end;

          stHandle:
          begin
            if not Found then // NeedMore=True. will wait...
              Break;

            Group := -1;
            CtxItem.PartBlockLastLine := CurLine;

            case CtxItem.PartBlockKind of
              pbStart:
              begin
                // If  (not NeedMore) or .... => we don't need be greedy
                // when we have Found = True.
                Group := CtxItem.PartRef.SynBlock.StartGroupUsed;

                PushBlock(CtxItem.PartRef.SynBlock,
                          CtxItem.PartBlockFirstLine,
                          CtxItem.PartBlockLastLine,
                          FParseTree.LineEndToNode(CtxItem.PartBlockFirstLine) <> nil);

                NeedMore := False;
              end;

              pbEnd:
              begin
                Group := CtxItem.PartBlock.EndGroupUsed;
                CloseBlock;
                NeedMore := False;
              end;

              else
                Assert(False);
            end;

            if not NeedMore then
            begin
              ClearPartBlock;

              if Re.MatchPos[Group]<>-1 then
                CtxItem.SyntaxTailPos := Re.MatchPos[group] + Re.MatchLen[group]
              else
                CtxItem.SyntaxTailPos := Re.MatchPos[0] + Re.MatchLen[0];

              state := stTest;
            end
            else
              Break; // Will wait...
          end;
        end;
      end;


      // Here: -------Pos#        - end of tokens pool
      //       ------Pos=====#    - partial match (need more tokens)

      if AEndOfTokens then
        while CtxItem.OpenSyntaxBlocksCount>0 do
        begin
          if CtxItem.PartBlockKind <> pbEnd then
          begin
            CtxItem.PartBlockKind := pbEnd;
            CtxItem.PartBlock := TopBlock.Block;
            CtxItem.PartRef := nil;
            CtxItem.PartBlockFirstLine := CurLine;
          end;

          CtxItem.PartBlockLastLine := CurLine;

          CloseBlock;
        end;

      if CtxItem.SyntaxTailPos=CtxItem.SyntaxTailCount then
        TailCut
      else if CtxItem.SyntaxTailPos<>0 then
      begin
        LMDIntArrayCopy(CtxItem.SyntaxTail, CtxItem.SyntaxTailPos,
                        CtxItem.SyntaxTail, 0,
                        CtxItem.SyntaxTailCount-CtxItem.SyntaxTailPos);

        CtxItem.SyntaxTailCount := CtxItem.SyntaxTailCount -
                                   CtxItem.SyntaxTailPos;
        CtxItem.SyntaxTailPos := 0;
        CtxItem.SyntaxTail[CtxItem.SyntaxTailCount] := -1;
      end;

      if CtxItem.SyntaxTailCount>CtxItem.Scheme.SyntaxTailMaxLength then
      begin
        TailCut;
        CtxItem.PartBlockKind := pbNothing;
      end;

      SynTokenAdded := False;
    end;

    procedure ProcessOpenNodes(AItem: TContextItem);
    var
      i:  Integer;
      ok: Boolean;
    begin
      if not ADoTree then
        Exit;

      ok := False;
      while (AItem <> nil) and (not ok) do
      begin

        for i := AItem.OpenSyntaxBlocksCount - 1 downto 0 do
        begin
          with AItem.OpenSyntaxBlocks[i] do
            if Block.Capture and (not (HasNode or DontCreateNode)) then
              ok := TryOpenBlock(AItem, i, False);

          if ok then
            Break;
        end;

        AItem := AItem.Prev;
      end;
    end;

    procedure ProcessOldDefault(AOldEnd, ANewStart: Integer);
    var
      i, st, ie, start, eend: Integer;
      foundChar:              Boolean;
      Dummy: TLMDEditAttributes;
    begin
      if (not ADoTokensLine) or (AOldEnd = ANewStart) then
        Exit;

      Assert(AOldEnd < ANewStart);

      LineItem.Start := AOldEnd;
      LineItem.Count := ANewStart - AOldEnd;

      LineItem.Token := CtxItem.Scheme.DefaultToken;

      Dummy.AttributesSet := [];
      Dummy.CustomAttributes := nil;

      SetAttrs(CtxItem.DefaultAttributes, CtxItem.OwnsCustomAttributes,
               Dummy,
               LineItem.RuntimeAttributes, LineItem.OwnsCustomAttrs);

      TokenLine.AddItem(LineItem);

      start := AOldEnd;
      eend := ANewStart;

      foundChar := False;
      repeat
        FChars.AssureIdx(start);
        st := start - FChars.BufferStart;

        ie := Min(eend, FChars.BufferEnd) - FChars.BufferStart - 1;

        for i := st to ie do
        begin
          foundChar := not FIgnoredChars.Contains(FChars.Buffer[i]);
          if foundChar then
            Break;
        end;

        Inc(start, ie-st+1);
      until foundChar or (start=eend);

      if foundChar then
        TailAddToken(CtxItem.Scheme.DefaultToken, -1, 0);
    end;

    function ProcessMatch(const ATokens: TRulePartsTokens;
                          APart: TRulePart;
                          AStart: Integer;
                          AOldEnd: Integer;
                          const AMatch: TMatchRec): Integer;
    var
      i, old, ie: Integer;
    begin
      ProcessOldDefault(AOldEnd, AStart);
      ie := AMatch.Count - 1;

      old := AStart;

      if AMatch.Starts[0] = AMatch.Ends[0] then
      begin
        i := 0;
        while i <= ie do
        begin
          if ATokens[APart][i]<>nil then
          begin
            TailAddToken(ATokens[APart][i], -1, 0);

            Break;
          end;

          Inc(i);
        end;

        if i > ie then
          TailAddToken(CtxItem.Scheme.DefaultToken, -1, 0);

        Result := AMatch.Ends[0];
      end
      else
      begin
        if ATokens[APart][0] <> nil then
        begin
          LineItem.Start := AMatch.Starts[0];
          LineItem.Count := AMatch.Ends[0] - LineItem.Start;
          LineItem.Token := ATokens[APart][0];

          if ADoTokensLine then
          begin
            SetAttrs(CtxItem.DefaultAttributes, CtxItem.OwnsCustomAttributes,
                     LineItem.Token.Attributes,
                     LineItem.RuntimeAttributes, LineItem.OwnsCustomAttrs);

            TokenLine.AddItem(LineItem);
          end;

          TailAddToken(LineItem.Token, LineItem.Start, LineItem.Count);
          Result := AMatch.Ends[0];
        end
        else
        begin
          for i := 1 to ie do
          begin
            if AMatch.Starts[i] = -1 then
              Continue;

            if (i > 0) and (old < AMatch.Starts[i]) then // 'Default' token.
              ProcessOldDefault(old, AMatch.Starts[i]);

            LineItem.Start := AMatch.Starts[i];
            LineItem.Count := AMatch.Ends[i] - LineItem.Start;
            LineItem.Token := ATokens[APart][i];

            if ADoTokensLine then
            begin
              SetAttrs(CtxItem.DefaultAttributes, CtxItem.OwnsCustomAttributes,
                       LineItem.Token.Attributes,
                       LineItem.RuntimeAttributes, LineItem.OwnsCustomAttrs);

              TokenLine.AddItem(LineItem);
            end;

            TailAddToken(LineItem.Token, LineItem.Start, LineItem.Count);

            old := AMatch.Ends[i];
          end;

          Result := AMatch.Ends[0];
          ProcessOldDefault(old, Result);
        end;
      end;
    end;

    function EndOfScheme(AIdx: Integer): Boolean;
    begin
      Result := (CtxItem.EndOfScheme <> -1) and (AIdx >= CtxItem.EndOfScheme);
    end;

    procedure EnterRuleScheme(ARule: TRule);
    var
      OldItem: TContextItem;
    begin
      OldItem := CtxItem;
      CtxItem := AContext.CreateItem;

      CtxItem.Scheme := ARule.InnerScheme;
      CtxItem.SchemeEndRule := ARule;
      CtxItem.CheckEndParentContext := OldItem.CheckEndParentContext or
                                       ((OldItem.SchemeEndRule <> nil) and
                                        OldItem.SchemeEndRule.CloseInnerSchemesOnMatchEnd);

      if ARule.IsBlockRule then
        CtxItem.EndOfScheme := -1
      else
        CtxItem.EndOfScheme := FMatch.Ends[0];

      SetAttrs(OldItem.DefaultAttributes, OldItem.OwnsCustomAttributes,
               CtxItem.Scheme.DefaultToken.Attributes,
               CtxItem.DefaultAttributes,
               CtxItem.OwnsCustomAttributes);

      TailCut;

      ContextPush(CtxItem);
    end;

  var
    Handled:              Boolean;
    i, j, ie, imax, old:  Integer;
    Ch:                   TLMDChar;
    ChainedBlockRule, Rule: TRule; RuleRef: TRuleRef;
    OldVarsCnt, v: Integer;
    ParentCtx: TContextItem;
  begin
    SynTokenAdded := False;
    ParserState := (ParserState or PARSER_STATE_LINE_BOUND);

    // Here:
    {
      TokenLine : nil or something (if ADoTokensLine)
      LineSeg: valid segment
      KeywordsProps: something or nil
      ParserState: Integer;

      CurLine: const
      CharsCount: const
    }

    CtxItem := AContext.LastItem;
    ProcessOpenNodes(CtxItem);

    i := LineSeg.Start;
    old := i;
    ie := LMDSegEnd(LineSeg)+1;
    imax := i + FMaxLineLengthToParse;

    SynTokenAdded := False;
    while i <= ie do
    begin
      // Ignored chars.
      if i <> ie then
      begin
        Ch := FChars[i];
        { //We should think more about spaces. We need those in some schemes.
        if (not EndOfScheme(i)) and
            FIgnoredChars.Contains(Ch)
        then
        begin
          Inc(i);
          Continue;
        end;
       }
      end
      else
        Ch := #$0;

      // End rule.
      Handled :=  EndOfScheme(i) or
                  ((CtxItem.SchemeEndRule <> nil) and
                    CtxItem.SchemeEndRule.IsBlockRule and
                    CtxItem.SchemeEndRule.MatchEnd(i, ie-i, ParserState, FMatch));

      if (not Handled) and CtxItem.CheckEndParentContext then
      begin
        ParentCtx := CtxItem.Prev;
        while (ParentCtx <> nil) and (not Handled) do
        begin
          Handled := ((ParentCtx.EndOfScheme <> -1) and (i >= ParentCtx.EndOfScheme));
          if not Handled then
          begin
            Handled := ((ParentCtx.SchemeEndRule <> nil) and
                       ParentCtx.SchemeEndRule.IsBlockRule and
                       ParentCtx.SchemeEndRule.MatchEnd(i, ie-i, ParserState, FMatch));

            if Handled then
            begin
              FMatch.Starts[0] := i;
              FMatch.Ends[0] := i;
              FMatch.Count := 1;

              FMatch.InnerStart := -1;
              FMatch.InnerCount := 0;
            end;
          end;

          ParentCtx := ParentCtx.Prev;
        end;

      end;

      if Handled then
      begin
        if CtxItem.SchemeEndRule.IsBlockRule then
          i := ProcessMatch(CtxItem.SchemeEndRule.Tokens, rpEnd, i, old, FMatch)
        else
          ProcessOldDefault(old, i);

        old := i;
        ProcessSynCache(True);

        //
        ChainedBlockRule := CtxItem.SchemeEndRule.ChainedBlockRule;
        if ChainedBlockRule <> nil then
        begin
          OldVarsCnt := Length(CtxItem.Variables);
          if Length(FOldVars) < OldVarsCnt then
            SetLength(FOldVars, OldVarsCnt);

          for v := 0 to OldVarsCnt - 1 do
            FOldVars[v] := CtxItem.Variables[v];
        end
        else
          OldVarsCnt := 0;
        //

        repeat
          ContextPop;
        until not EndOfScheme(i);

        if ChainedBlockRule <> nil then
        begin
          EnterRuleScheme(ChainedBlockRule);

          SetLength(CtxItem.Variables, OldVarsCnt);
          for v := 0 to OldVarsCnt - 1 do
            CtxItem.Variables[v] := FOldVars[v];

          ChainedBlockRule.BindVariables(CtxItem.GetVariable);
        end
        else if (CtxItem.SchemeEndRule <> nil) and CtxItem.SchemeEndRule.IsBlockRule then
          CtxItem.SchemeEndRule.BindVariables(CtxItem.GetVariable);
      end
      else // Rules - simple and with inner schemes.
      begin
        if i <> ie then
        begin
          if i < imax then
            RuleRef := CtxItem.Scheme.RulesHash.GetRuleChain(Ord(Ch))
          else
          begin
            Handled := true;
            RuleRef := nil;

            FMatch.Starts[0] := i;
            FMatch.Ends[0] := ie;

            FMatch.Starts[1] := i;
            FMatch.Ends[1] := ie;

            FMatch.Starts[2] := -1;
            FMatch.Ends[2] := -1;

            FMatch.InnerStart := -1;
            FMatch.InnerCount := 0;

            FMatch.Count := 3;

            i := ProcessMatch(FMaxLnTokens, rpBegin, i, old, FMatch);
            old := i;
          end
        end
        else
          RuleRef := CtxItem.Scheme.RulesHash.GetRuleChain(0);//Used for empty line

        while (RuleRef <> nil) and (not Handled) do
        begin
          Rule := RuleRef.Rule;

          if CtxItem.EndOfScheme = -1 then
            Handled := Rule.Match(i, ie-i, ParserState, FMatch)
          else
            Handled := Rule.Match(i, CtxItem.EndOfScheme-i, ParserState, FMatch);

          if Handled then
          begin
            if Rule.InnerScheme = nil then
            begin
              i := ProcessMatch(Rule.Tokens, rpBegin, i, old, FMatch);
              old := i;
            end
            else
            begin
              ProcessOldDefault(old, i);
              old := i;

              // Add whole subscheme to syntax cache as its default token.
              TailAddToken(Rule.InnerScheme.DefaultToken,
                           FMatch.InnerStart, FMatch.InnerCount);

              ProcessSynCache(False);

              ///
              EnterRuleScheme(Rule);

              if Rule.NeedVariables then
              begin
                SetLength(CtxItem.Variables, Rule.MaxVarId+1);
                for j:=0 to Rule.MaxVarId do
                  if Rule.GetVariable(j,
                                      CtxItem.Variables[j].Start,
                                      CtxItem.Variables[j].Count)
                  then
                    CtxItem.Variables[j].Source := FChars
                  else
                    CtxItem.Variables[j] := LMDBadSegment;

                Rule.BindVariables(CtxItem.GetVariable);
              end;
              ///

              if Rule.HasTokens[rpBegin] then
              begin
                i := ProcessMatch(Rule.Tokens, rpBegin, i, old, FMatch);
                old := i;
              end;

              // Here:
              // CtxItem: Empty tail, empty OpenSyntaxBlocks, no partial block.
            end;
          end
          else
            RuleRef := RuleRef.Next;
        end;
      end;

      if not Handled then
        Inc(i);

      ParserState := ParserState and (not PARSER_STATE_LINE_BOUND);
    end;

    if old<ie then
      ProcessOldDefault(old, Min(i, ie)); // Process spaces at end of line.

    ProcessSynCache(i=CharsCount);

    while EndOfScheme(i) do
      ContextPop;

    ProcessOpenNodes(AContext.LastItem);
  end;

  procedure ClearMatch;
  var
    i: Integer;
  begin
    for i := 0 to FMaxSubExp-1 do
    begin
      FMatch.Starts[i] := -1;
      FMatch.Ends[i] := -1;
    end;

    FMatch.Count := 0;
    FMatch.InnerStart := -1;
    FMatch.InnerCount := 0;
  end;

var
  CtxItem: TContextItem;
  StartL, EndL, LastSave, LinesCount: Integer;
  Context, LastContext, NewContext, Clone: TParserContext;
  DoTokCache, DoTree: Boolean;
  LinesForward: Integer;
  UpperTokCache: Integer;
begin
  ClearMatch;

  LinesForward := (FTokenCache.MaxCount div 2) + 1;
  UpperTokCache := FTokenCache.MaxCount div 3;
  ParserState := 0;
  FChars := FDoc.Chars;
  CharsCount := FChars.Count;

  Context := FContextCache.GetContext(ALine);
  if Context = nil then
  begin
    Context := TParserContext.Create;
    Context.LastTreeLine := FParseTree.LastKnownLine;
    Assert(Context.LastTreeLine = -1);

    CtxItem := Context.CreateItem;

    CtxItem.Scheme := FRootSc;
    CtxItem.DefaultAttributes := FRootSc.DefaultToken.Attributes;
    CtxItem.ParentNode := FParseTree.Root;

    Context.Push(CtxItem);

    FContextCache.AddContext(0, Context);
  end;

  StartL := Context.Line;
  LinesCount := FDoc.LinesCount;
  EndL := Min(LinesCount, ALine + LinesForward);

  LastContext := FContextCache.GetLastContext;
  Assert(LastContext.Line = FLastValidLine + 1);

  NewContext := Context.Clone;

  // Assert: LastNode.StartLine <= LastContext.Line.
  CurLine := StartL;
  LastSave := StartL;
  while CurLine < EndL do
  begin
    LineSeg := FDoc.LineSegments[CurLine];
    FCharsInput.Bind(FDoc.Chars, LineSeg.Start, LineSeg.Start+LineSeg.Count);

    if CurLine=FLastValidLine then
    begin
      NewContext.Free;
      NewContext := LastContext.Clone;
    end;

    DoTree := CurLine > FLastValidLine;

    DoTokCache := (CurLine >= ALine) or
                  ((ALine - CurLine) <= UpperTokCache);

    if DoTokCache then
    begin
      TokenLine := FTokenCache.GetLine(CurLine);
      DoTokCache := TokenLine=nil;
    end;

    if DoTokCache then
      TokenLine := FTokenCache.CreateLine(CurLine, FChars)
    else
      TokenLine := nil;

    ProcessLine(NewContext, DoTokCache, DoTree);

    Inc(CurLine);

    if (CurLine>FLastValidLine+1) and
       (((CurLine-LastSave) > FContextSaveInterval) or (CurLine=EndL))
    then
    begin
      Clone := NewContext.Clone;
      Clone.LastTreeLine := FParseTree.LastKnownLine; // Clone will have it.

      FContextCache.AddContext(CurLine, Clone);
      NewContext.LastTreeLine := -1;

      LastSave := CurLine;
    end;
  end;

  if FLastValidLine<EndL-1 then
    FLastValidLine := EndL-1;

  // Can't lose ALine from cache!
  Assert(FTokenCache.GetLine(ALine)<>nil);

  NewContext.Free;
  // Assert: LastNode.StartLine <= LastContext.Line.
end;

{------------------------------------------------------------------------------}

function  TParserImpl.GetParentLine(ALine: Integer): Integer;
var
  Node: TParserNode;
begin
  EnsureLineParsed(ALine);
  Node   := FParseTree.FindParent(ALine);
  Result := Node.StartLine;
end;

{------------------------------------------------------------------------------}

function  TParserImpl.GetFoldEnd(ALineStart: Integer): Integer;
var
  Node: TParserNode;
begin
  Assert(LMDInRange(ALineStart, 0, FDoc.LinesCount-1));
  EnsureLineParsed(ALineStart);

  Assert(IsFoldStart(ALineStart));

  Node := FParseTree.LineStartToNode(ALineStart);
  Assert(Node<>nil);

  while (Node.EndLine=-1) and (FLastValidLine<FDoc.LinesCount-1) do
    BuildCachesFrom(FLastValidLine+1);

  Result := Node.EndLine;

  if Result=-1 then
    Result := FDoc.LinesCount-1;
end;

{------------------------------------------------------------------------------}

function  TParserImpl.GetFoldStart(ALineEnd: Integer): Integer;
var
  Node: TParserNode;
begin
  Assert(LMDInRange(ALineEnd, 0, FDoc.LinesCount-1));

  EnsureLineParsed(ALineEnd);
    
  Assert(IsFoldEnd(ALineEnd));
  
  Node := FParseTree.LineEndToNode(ALineEnd);
  Assert(Node<>nil);

  Result := Node.StartLine;
  Assert(Result<>-1);
end;
       
{------------------------------------------------------------------------------}

function TParserImpl.IsFoldStart(ALine: Integer): Boolean;
begin
  EnsureLineParsed(ALine);
  Result := FParseTree.LineStartToNode(ALine)<>nil;
end;
      
{------------------------------------------------------------------------------}

function TParserImpl.IsFoldEnd(ALine: Integer): Boolean;
begin
  EnsureLineParsed(ALine);
  Result := FParseTree.LineEndToNode(ALine)<>nil;
end;
    
{------------------------------------------------------------------------------}

procedure  TParserImpl.EnsureLineParsed(ALine: Integer);
begin
  Assert(ALine<FDoc.LinesCount);

  if ALine>FLastValidLine then
    BuildCachesFrom(ALine);
end;

{------------------------------------------------------------------------------}

function  TParserImpl.IsSchemeLoaded: Boolean;
begin
  Result := FSchemeLoaded;
end;

{********************************* TLMDEditParser *********************************}
{------------------------------------------------------------------------------}

constructor TLMDEditParser.Create;
begin
  inherited;
  FImpl := TParserImpl.CreateImpl(201, 50);
end;
  
{------------------------------------------------------------------------------}

destructor TLMDEditParser.Destroy;
begin
  FImpl.Free;
  inherited;
end;
      
{------------------------------------------------------------------------------}

function TLMDEditParser.GetAttrsDir: TLMDString;
begin
  Result := TParserImpl(FImpl).AttrsDir;
end;
   
{------------------------------------------------------------------------------}

function TLMDEditParser.GetFoldEnd(ALineStart: Integer): Integer;
begin
  if TParserImpl(FImpl).IsSchemeLoaded then
    Result := TParserImpl(FImpl).GetFoldEnd(ALineStart)
  else
    Result := inherited GetFoldEnd(ALineStart);
end;
   
{------------------------------------------------------------------------------}

function TLMDEditParser.GetFoldStart(ALineEnd: Integer): Integer;
begin
  if TParserImpl(FImpl).IsSchemeLoaded then
    Result := TParserImpl(FImpl).GetFoldStart(ALineEnd)
  else
    Result := inherited GetFoldStart(ALineEnd);
end;
     
{------------------------------------------------------------------------------}

function TLMDEditParser.GetParentLine(ALine: Integer): Integer;
begin
  if TParserImpl(FImpl).IsSchemeLoaded then
    Result := TParserImpl(FImpl).GetParentLine(ALine)
  else
    Result := inherited GetParentLine(ALine);
end;
   
{------------------------------------------------------------------------------}

function TLMDEditParser.GetSchemesDir: TLMDString;
begin
  Result := TParserImpl(FImpl).SchemesDir;
end;

function  TLMDEditParser.GetAllTokenIDs(const ATokenName: TLMDString): TLMDIntArray;
begin
  if TParserImpl(FImpl).IsSchemeLoaded then
    Result := TParserImpl(FImpl).GetAllTokenIDs(ATokenName)
  else
    Result := inherited GetAllTokenIDs(ATokenName);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParser.SetMaxLineLengthToParse(AValue: Integer);
begin
  if AValue <> MaxLineLengthToParse then
  begin
    inherited SetMaxLineLengthToParse(AValue);

    TParserImpl(FImpl).SetMaxLineLengthToParse(AValue);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditParser.IsFoldEnd(ALine: Integer): Boolean;
begin
  if TParserImpl(FImpl).IsSchemeLoaded then
    Result := TParserImpl(FImpl).IsFoldEnd(ALine)
  else
    Result := inherited IsFoldEnd(ALine);
end;
      
{------------------------------------------------------------------------------}

procedure TLMDEditParser.EnsureLineParsed(ALine: Integer);
begin
  if TParserImpl(FImpl).IsSchemeLoaded then
    TParserImpl(FImpl).EnsureLineParsed(ALine);
end;

{------------------------------------------------------------------------------}

function TLMDEditParser.IsFoldStart(ALine: Integer): Boolean;
begin
  if TParserImpl(FImpl).IsSchemeLoaded then
    Result := TParserImpl(FImpl).IsFoldStart(ALine)
  else
    Result := inherited IsFoldStart(ALine);
end;
   
{------------------------------------------------------------------------------}

procedure TLMDEditParser.LineChanged(ALine: Integer);
begin
  if TParserImpl(FImpl).IsSchemeLoaded then
    TParserImpl(FImpl).LineChanged(ALine);
end;
    
{------------------------------------------------------------------------------}

procedure TLMDEditParser.LinesChangedFrom(AStart: Integer);
begin
  if TParserImpl(FImpl).IsSchemeLoaded then
    TParserImpl(FImpl).LinesChangedFrom(AStart);
end;
     
{------------------------------------------------------------------------------}

procedure TLMDEditParser.LoadSchemeDoc(const ADocName, AttrsDocName: TLMDString);
begin
  TParserImpl(FImpl).LoadSchemeDoc(ADocName, AttrsDocName);
end;
      
{------------------------------------------------------------------------------}

procedure TLMDEditParser.UnloadSchemes;
begin
  TParserImpl(FImpl).UnloadSchemes;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParser.SetSchemeLoaders(ASyntaxLoader,
  AColorLoader: TLMDEditParserSchemeLoader);
begin
  TParserImpl(FImpl).SetSchemeLoaders(ASyntaxLoader, AColorLoader);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParser.MarkTokens(ALine: Integer;
                                    const AHandler: TLMDTokenHandler);
begin
  TParserImpl(FImpl).MarkTokens(ALine, AHandler);
end;

{------------------------------------------------------------------------------}

function  TLMDEditParser.GetParsedLine(ALine: Integer): TLMDEditParsedLine;
begin
  Result := TParserImpl(FImpl).GetParsedLine(ALine);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParser.Refresh;
begin
  if TParserImpl(FImpl).IsSchemeLoaded then
    TParserImpl(FImpl).Refresh
  else
    inherited;
end;
      
{------------------------------------------------------------------------------}

procedure TLMDEditParser.SetAttrsDir(ADir: TLMDString);
begin
  TParserImpl(FImpl).AttrsDir := ADir;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParser.SetDocument(ADoc: TLMDEditDocument);
begin
  inherited;
  TParserImpl(FImpl).SetDocument(ADoc);
end;
    
{------------------------------------------------------------------------------}

procedure TLMDEditParser.SetSchemesDir(ADir: TLMDString);
begin
  TParserImpl(FImpl).SchemesDir := ADir;
end;
    
{------------------------------------------------------------------------------}

initialization

{$IFDEF LMDDEBUGTRACE}
  {$I C1.INC}
{$ENDIF}

  SCHEME_DOC_EXTENSION := '.xml';
  SCHEME_DOC_SEPARATOR := '.';

  DIVIDERS := LMDSpace;
  DIVIDERS := DIVIDERS + LMDTab;
  DIVIDERS := DIVIDERS + ',;';
{------------------------------------------------------------------------------}

end.

