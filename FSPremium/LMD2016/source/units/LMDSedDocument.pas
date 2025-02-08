unit LMDSedDocument;
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

LMDSedDocument unit (VT)
------------------------
This unit contains TLMDEditDocument related classes for LMD-Tools Syntax Edit
packages.

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Graphics, Windows, Types, intfLMDBase, LMDTypes,
  LMDStrings, LMDUnicodeEncodings, LMDSedUtils, LMDHashTable, LMDArrayUtils,
  LMDRegExpr;

const
  LMDDefaultUndoLimit = 1024;
  MAX_LINE_LENGTH_TO_PARSE = 1000;

type
  ELMDEditDocError = class(Exception);


  {********************************* ILMDMark *********************************}

  ILMDMarkers = interface;

  ILMDMark = interface(IInterface)
    ['{D57D8C11-2B83-4A2D-8091-400AE49E7C1A}']
    function  get_Pos: Integer;
    procedure set_Name(AName: TLMDString);
    function  get_Name: TLMDString;
    function  get_Data: TLMDDataTag;
    procedure set_Data(AData: TLMDDataTag);
    function  get_IsValid: Boolean;
    function  get_Line: Integer;
    function  get_Column: Integer;
    function  get_Collection: ILMDMarkers;

    procedure NotifyDataChanged;
    procedure DeleteFromCollection;

    property Pos: Integer read get_Pos;
    property Name: TLMDString read get_Name write set_Name;
    property Data: TLMDDataTag read get_Data write set_Data;
    property IsValid: Boolean read get_IsValid;
    property Line: Integer read get_Line;
    property Column: Integer read get_Column;
    property Collection: ILMDMarkers read get_Collection;
  end;

  {******************************* ILMDLineMark *******************************}

  // Breakpoint properties, given from debugger.
  TLMDBreakpointKind = (mkBreakActive, mkBreakDisabled, mkBreakInactive);
  TLMDDebugFrameKind = (fkFrame, fkFrameTop, fkFrameActive);

  ILMDLineMark = ILMDMark {$IFDEF LMDCOMP10} deprecated {$ENDIF};
  ILMDLineMarkers = ILMDMarkers {$IFDEF LMDCOMP10} deprecated {$ENDIF};
  TLMDLineMarkKind = TLMDBreakpointKind {$IFDEF LMDCOMP10} deprecated {$ENDIF};

  {******************************** ILMDMarkers *******************************}

  TLMDMarkArray     = array of ILMDMark;
  TLMDLineMarkArray = TLMDMarkArray {$IFDEF LMDCOMP10} deprecated {$ENDIF};

  TLMDMarkEnumFunction = procedure(AMark: ILMDMark; AData: Pointer;
                                   var StopHere: Boolean) of object;

  ILMDMarkers = interface(IInterface)
    ['{7D9A6443-8CC7-42A5-95EB-84E56884B838}']
    function  GetMarksBySegment(AStart, ACount: Integer): TLMDMarkArray;
    function  GetMarksCountByLines(AStartLine, ACount: Integer): Integer;
    function  GetMarksByLines(AStartLine, ACount: Integer): TLMDMarkArray;
    function  GetLastLineMark(ALine: Integer): ILMDMark;

    function  CreateMarkAtLine(ALine: Integer): ILMDMark;
    function  CreateMarkAtCol(ALine, AColumn: Integer): ILMDMark;
    function  CreateMarkAtOffset(AOffset: Integer): ILMDMark;

    procedure DeleteMark(const AMark: ILMDMark);
    procedure DeleteMarksAtLine(ALine: Integer);
    procedure DeleteLastMarkAtLine(ALine: Integer);

    procedure Clear;
    function  get_Count: Integer;
    property  Count: Integer read get_Count;
    function  Marks(AIndex: Integer): ILMDMark;
    function  FindByName(const AName: TLMDString): ILMDMark;

    function  EnumMarkers(AEnumerator: TLMDMarkEnumFunction;
                          AData: Pointer = nil): ILMDMark;

    function  EnumMarkersByLines(AStartLine, ACount: Integer;
                                 AEnumerator: TLMDMarkEnumFunction;
                                 AData: Pointer = nil): ILMDMark;

    function  EnumMarkersByOffset(AStartOffset, ACount: Integer;
                                  AEnumerator: TLMDMarkEnumFunction;
                                  AData: Pointer = nil): ILMDMark;
  end;


  {***************************** Find/replace features ************************}

  TLMDEditSearchOption = (soCaseSensitive, soRegexp, soRegexpSubstitute,
                          soWholeWords,
                          soConfirmReplace);
  TLMDEditSearchOptions  = set of TLMDEditSearchOption;

  TLMDEditSearchDirection = (sdForward, sdBackward);

  TLMDEditReplaceAction = (raReplaceAuto,
                           raReplacedByCallback,
                           raGoNext,
                           raCancel);

  TLMDEditFindReplaceState = class;

  TLMDEditReplaceEvent = procedure(Sender: TObject;
                                   const AState: TLMDEditFindReplaceState;
                                   var ReplacedCount: Integer;
                                   var Action: TLMDEditReplaceAction) of object;

  TLMDEditFindReplaceState = class
  protected
    constructor Create;
  public
    FoundSegment: TLMDSegment;
    FoundRegex: TLMDRegExp;

    Start: Integer;
    EndM: ILMDMark;

    Pattern, Replacement: TLMDString;
    Options: TLMDEditSearchOptions;
    Direction: TLMDEditSearchDirection;

    LastReplaceAction: TLMDEditReplaceAction;
    OnReplace: TLMDEditReplaceEvent;

    Internal: TObject;

    destructor Destroy; override;
  end;

  {**************************** TLMDSyntaxParserBase **************************}

  TLMDEditAttributesSetEnum = (asBackgroundColor, asTextColor, asFontStyle,
                               asCustomAttributes);

  TLMDEditAttributesSet = set of TLMDEditAttributesSetEnum;

  TLMDEditAttributes = record
    CustomAttributes: TLMDStringHashTable;

    BackgroundColor: TColor;
    TextColor:       TColor;
    FontStyle:       TFontStyles;
    AttributesSet:   TLMDEditAttributesSet;
  end;

  TLMDEditParsedToken = record
    Seg: TLMDSegment;
    Attrs: TLMDEditAttributes;
    TokenID: Integer;
  end;

  TLMDEditParsedTokenArray = array of TLMDEditParsedToken;

  TLMDTokenHandler = class
  public
    procedure HandleToken(const ASeg: TLMDSegment; ATokenID: Integer;
                          const Attributes: TLMDEditAttributes); virtual; abstract;
  end;

  TLMDEditDocument = class;

  TLMDEditParsedLine = class
  public
    function TokenCount: Integer; virtual; abstract;
    function GetTokenIdx(ACol: Integer): Integer; virtual; abstract;
    function GetTokens(AStart, ACount: Integer; var Arr: TLMDEditParsedTokenArray): Integer; virtual; abstract;
  end;

  TLMDEditParserBase = class
  protected
    FDoc: TLMDEditDocument;
    FMaxLineLengthToParse: Integer;

    procedure SetDocument(ADoc: TLMDEditDocument); virtual;
  public
    constructor Create;
    destructor Destroy; override;

    function  GetDocument: TLMDEditDocument; virtual;

    function  GetFoldLevel(ALine: Integer): Integer; virtual;

    function  GetParentLine(ALine: Integer): Integer; virtual;
    function  GetFoldEnd(ALineStart: Integer): Integer; virtual;
    function  GetFoldStart(ALineEnd: Integer): Integer; virtual;

    function  IsFoldStart(ALine: Integer): Boolean; virtual;
    function  IsFoldEnd(ALine: Integer): Boolean; virtual;
    procedure EnsureLineParsed(ALine: Integer); virtual;

    property  MaxLineLengthToParse: Integer read FMaxLineLengthToParse;
    procedure SetMaxLineLengthToParse(AValue: Integer); virtual;

    procedure MarkTokens(ALine: Integer; const AHandler: TLMDTokenHandler); virtual;

    //Do not call Free on result! Parser owns it!
    function  GetParsedLine(ALine: Integer): TLMDEditParsedLine; virtual;

    procedure LineChanged(ALine: Integer); virtual;
    procedure LinesChangedFrom(AStart: Integer); virtual;

    procedure Refresh; virtual;
    function  GetAllTokenIDs(const ATokenName: TLMDString): TLMDIntArray; virtual;
  end;

  {**************************** TLMDDocumentListener **************************}

  TLMDDocumentListener = class
  public
    procedure BeforeRefresh; virtual;
    procedure AfterRefresh; virtual;

    procedure BeforeSettingsRefresh; virtual;
    procedure AfterSettingsRefresh; virtual;

    // Fires before any document markers change, and before any other
    // markers event.
    procedure BeforeMarkChange; virtual;

    procedure MarksDeleting(AMarkers: ILMDMarkers;
                            const AMarks: TLMDMarkArray); virtual;
    procedure MarkCreated(AMarkers: ILMDMarkers;
                          const AMark: ILMDMark); virtual;
    procedure MarkSettingsChanged(AMarkers: ILMDMarkers;
                                  const AMark: ILMDMark); virtual;

    // Fires after any document markers change, and after any other markers
    // event.
    procedure AfterMarkChange; virtual;

    procedure BeforeInsert(AStart, ALength: Integer); virtual;
    procedure AfterInsert(AStart, ALength: Integer); virtual;

    procedure BeforeDelete(AStart, ALength: Integer); virtual;
    procedure AfterDelete(AStart, ALength: Integer); virtual;

    procedure BeforeCompoundEdit(AFreezeOnCompoundEdit: Boolean); virtual;
    procedure AfterCompoundEdit(AFreezeOnCompoundEdit: Boolean); virtual;

    procedure DoUserEventAfterDocChange; virtual;

    procedure DocumentDestroing; virtual;
  end;

  {************************** TLMDDocumentInternal ****************************}

  TLMDDocUndoInfo = class
  public
    function Merge(ANewInfo: TLMDDocUndoInfo): Boolean; virtual;
    function Clone: TLMDDocUndoInfo; virtual; abstract;
  end;

  TLMDDocumentInternal = class
  private
    FDoc: TLMDEditDocument;
  public
    constructor Create(ADoc: TLMDEditDocument);

    function GetCanRedo(AAuthorID: Integer): Boolean;
    function GetCanUndo(AAuthorID: Integer): Boolean;

    procedure Undo(AAuthorID: Integer;
                  {owns:me} ANewInfo: TLMDDocUndoInfo;
                  {owns:caller} var OldInfo: TLMDDocUndoInfo);
    procedure Redo(AAuthorID: Integer;
                  {owns:me} ANewInfo: TLMDDocUndoInfo;
                  {owns:caller} var OldInfo: TLMDDocUndoInfo);


    procedure InsertSeg(AIdx: Integer; ASeg: TLMDSegment; AAuthorID: Integer;
                        {owns:me} AOldInfo: TLMDDocUndoInfo; ADoFreeSeg: Boolean);

    procedure InsertStr(AIdx: Integer; const AStr: TLMDString; AAuthorID: Integer;
                        {owns:me} AOldInfo: TLMDDocUndoInfo);

    procedure Delete(AStart, ACount, AAuthorID: Integer;
                     {owns:me} AOldInfo: TLMDDocUndoInfo);

    procedure ReplaceSeg(AStart, ACount: Integer; const ASeg: TLMDSegment;
                         AAuthorID: Integer; AOldInfo: TLMDDocUndoInfo);

    procedure ReplaceStr(AStart, ACount: Integer; const AStr: TLMDString;
                         AAuthorID: Integer; AOldInfo: TLMDDocUndoInfo);

    procedure PushCustomAction(AAuthorID: Integer;
                              {owns:me} AOldInfo: TLMDDocUndoInfo);

    procedure BeginCompoundAction(AAuthorID: Integer;
                                  {owns:me} AOldInfo: TLMDDocUndoInfo;
                                  AFreezeViews: Boolean);

    function GetNextAuthorID: Integer;

    procedure LockMarkers;
    procedure LockChanges;
    procedure UnlockMarkers;
    procedure UnlockChanges;

    //Low-level functions
    procedure AddListener(const ALst: TLMDDocumentListener);
    procedure RemoveListener(const ALst: TLMDDocumentListener);
  end;

  {******************* TLMDEditParserSchemeCollectionItem *********************}

  TLMDEditParserSchemeCollectionItem = class;

  TLMDEditParserSchemeStrings = class (TLMDMemoryStrings)
  private
    FParent: TLMDEditParserSchemeCollectionItem;
  public
    constructor Create(AParent: TLMDEditParserSchemeCollectionItem);
    property Parent: TLMDEditParserSchemeCollectionItem read FParent write FParent;
  end;

  TLMDEditParserSchemeCollectionItem = class(TCollectionItem)
  private
    FScheme: TLMDEditParserSchemeStrings;
    FName:   string;

    procedure SetScheme(AScheme: TLMDEditParserSchemeStrings);
    procedure SetName(const AName: string);
    procedure SchemeChange(Sender: TObject);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
  published
    property Name: string read FName write SetName;
    property Scheme: TLMDEditParserSchemeStrings read FScheme write SetScheme;
  end;

  {********************** TLMDEditParserSchemeCollection **********************}

  TLMDEditParserSchemeCollection = class(TCollection)
  private
    FParent: TLMDEditDocument;

    procedure CheckSetSchemeName(const AName: string);
    function  GetItem(Index: Integer): TLMDEditParserSchemeCollectionItem;
    procedure SetItem(Index: Integer; Value: TLMDEditParserSchemeCollectionItem);
  protected
    function  GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AParent: TLMDEditDocument);

    procedure LoadFromFiles(const AFiles: array of TLMDString);
    procedure LoadFromDirectory(ADir, AFileExt: string);
    function  FindItem(const AName: TLMDString): TLMDEditParserSchemeCollectionItem;

    function Add: TLMDEditParserSchemeCollectionItem;
    function Insert(Index: Integer): TLMDEditParserSchemeCollectionItem;

    property Items[Index: Integer]: TLMDEditParserSchemeCollectionItem
              read GetItem write SetItem; default;

    property Parent: TLMDEditDocument read FParent write FParent;
  end;

  {****************************** TLMDEditDocument ****************************}

  TLMDSyntaxSchemeRef = type TLMDString;
  TLMDColorSchemeRef = type TLMDString;
  TLMDCodePageRef = type Integer;

  TLMDLineSeparator = (lsCR, lsLF, lsCRLF);

  TLMDMarkEvent = procedure (Sender: TLMDEditDocument;
                             ACollection: ILMDMarkers;
                             const AMark: ILMDMark) of object;

  TLMDDocStatusChange  = (dcInsert, dcDelete, dcCompoundChange,
                          dcMarkersCreated,
                          dcMarkSettingsChanged,
                          dcMarkersDeleted,
                          dcCodePagePropsChanged,
                          dcModifiedPropertyChanged);

  TLMDDocStatusChanges = set of TLMDDocStatusChange;

  TLMDDocChangedEvent = procedure (Sender: TLMDEditDocument;
                                   AChanges: TLMDDocStatusChanges) of object;

  TLMDDocLinesChanged = procedure(Sender: TLMDEditDocument;
                                  AFirstLine, ACount: Integer) of object;

  {***************************** The Document itself ************************}

  TLMDEditDocument = class(TComponent, ILMDComponent)
  private
    FAbout:               TLMDAboutVar;
    FLastAuthorID:        Integer;
    FLineSeparator:       TLMDLineSeparator;
    FLineSeparatorStr:    TLMDString;
    FStorage:             TObject;
    FStorageLst:          TObject;
    FLineManager:         TObject;
    FUndoManager:         TObject;
    FInternal:            TLMDDocumentInternal;
    FMarkManager:         TObject;
    FBookmarks:           ILMDMarkers;
    FBreakpoints:         ILMDMarkers;
    FDebugFrameLines:     ILMDMarkers;
    FLines:               TLMDStrings;
    FSyntaxSchemes:       TLMDEditParserSchemeCollection;
    FColorSchemes:        TLMDEditParserSchemeCollection;
    FSyntaxScheme:        TLMDSyntaxSchemeRef;
    FColorScheme:         TLMDColorSchemeRef;
    FListeners:           TList;
    FCustomListeners:     TList;
    FParser:              TLMDEditParserBase;
    FCompoundEditCnt:     Integer;
    FInUndo:              Boolean;
    FReadOnly:            Boolean;
    FChangesLockCnt:      Integer;
    FMarkersLockCnt:      Integer;
    FChanges:             TLMDDocStatusChanges;
    FWordSeparators:      TLMDString;
    FFullWordSeparators:  TLMDString;
    FDelayedEventLock:    Integer;
    FOnMarkDeleting:      TLMDMarkEvent;
    FOnMarkCreating:      TLMDMarkEvent;
    FOnDocChanged:        TLMDDocChangedEvent;

    FModified:            Boolean;
    FModifiedFixed:       Boolean;
    FUndoCountNoMod:      Integer;

    FInConstructor:       Boolean;
    FEncoding:            TLMDEncoding;
    FCodePageUsePreamble: Boolean;
    FOnLinesChanged:      TLMDDocLinesChanged;

    // Secret interface.

    function GetCanRedo(AAuthorID: Integer): Boolean;
    function GetCanUndo(AAuthorID: Integer): Boolean;

    procedure UndoLow(AAuthorID: Integer;
                  {owns:me} ANewInfo: TLMDDocUndoInfo;
                  {owns:caller} var OldInfo: TLMDDocUndoInfo);
    procedure RedoLow(AAuthorID: Integer;
                  {owns:me} ANewInfo: TLMDDocUndoInfo;
                  {owns:caller} var OldInfo: TLMDDocUndoInfo);


    function  InsideCRLF_LF(AOffset: Integer): Boolean;
    function  InsideCRLF_CR(AOffset: Integer): Boolean;

    procedure InsertSegLow(AStart: Integer; ASeg: TLMDSegment; AAuthorID: Integer;
                           {owns:me} AOldInfo: TLMDDocUndoInfo;
                           ADoFreeSeg: Boolean);

    procedure InsertStrLow(AStart: Integer; AStr: TLMDString;
                           AAuthorID: Integer;
                           {owns:me} AOldInfo: TLMDDocUndoInfo);

    procedure DeleteLow(AStart, ACount, AAuthorID: Integer;
                        {owns:me} AOldInfo: TLMDDocUndoInfo);

    procedure ReplaceSegLow(AStart, ACount: Integer;
                            const ASeg: TLMDSegment;
                            AAuthorID: Integer;
                            AOldInfo: TLMDDocUndoInfo);

    procedure ReplaceStrLow(AStart, ACount: Integer; const AStr: TLMDString;
                            AAuthorID: Integer; AOldInfo: TLMDDocUndoInfo);

    procedure PushCustomAction(AAuthorID: Integer;
                              {owns:me} AOldInfo: TLMDDocUndoInfo);

    procedure BeginCompoundAction(AAuthorID: Integer;
                                 {owns:me} AOldInfo: TLMDDocUndoInfo;
                                 AFreezeViews: Boolean);

    function GetNextAuthorID: Integer;

    procedure LockMarkers;
    procedure LockChanges;
    procedure UnlockMarkers;
    procedure UnlockChanges;

    function LoadSyntaxFromColl(const ASchemeName: TLMDString): TLMDString;
    function LoadColorFromColl(const ASchemeName: TLMDString): TLMDString;

    procedure FireBeforeRefresh;
    procedure FireAfterRefresh;
    procedure FireBeforeSettingsRefresh;
    procedure FireAfterSettingsRefresh;

    function  GetLst(i: Integer): TLMDDocumentListener;
    function  GetCustLst(i: Integer): TLMDDocumentListener;

    procedure FireDestroing;

    procedure DoBeforeMarkChange;
    procedure DoAfterMarkChange;

    procedure FireMarksDeleting(AMarkers: ILMDMarkers;
                                AMarks: TLMDMarkArray);

    procedure FireMarkCreated(AMarkers: ILMDMarkers;
                              AMark: ILMDMark);

    procedure FireMarkSettingsChanged(AMarkers: ILMDMarkers;
                                      AMark: ILMDMark);

    procedure FireBeforeInsert(AStart, ACount: Integer);
    procedure FireAfterInsert(AStart, ACount: Integer);

    procedure FireBeforeDelete(AStart, ACount: Integer);
    procedure FireAfterDelete(AStart, ACount: Integer);

    procedure FireBeforeCompoundEdit(AFreezeViews: Boolean);
    procedure FireAfterCompoundEdit(AFreezeViews: Boolean);

    procedure FireParser(AFirstLine, ACount: Integer);

    procedure CheckSyntaxSchemeName(ASchemeName: TLMDString);
    procedure CheckColorSchemeName(ASchemeName: TLMDString);
    procedure CheckLoadingSyntaxSchemeName(ASchemeName: TLMDString);
    procedure CheckLoadingColorSchemeName(ASchemeName: TLMDString);

    procedure CheckNotUpdating;
    procedure CheckChangesLock;
    procedure CheckReadOnly;
    procedure CheckMarkersLock;
    procedure CheckCanUndoRedo(AUndo: Boolean; AAuthorID: Integer);
    procedure CheckInCompoundEdit;
    procedure CheckCustomMarkersValid(AMarkers: IInterface);
    procedure CheckSegValid(const ASeg: TLMDSegment);

    procedure CheckOffset(AOffset: Integer);
    procedure CheckSearchOffset(AOffset: Integer);
    procedure CheckInsOffset(AOffset: Integer);

    procedure CheckLineIdx(ALine: Integer);
    procedure CheckLineIdxCol(ALine, AColumn: Integer);

    procedure SetUndoLimit(ALimit: Integer);
    function  GetUndoLimit: Integer;
    procedure SetWordSeparators(const ASep: TLMDString);

    procedure SetLineSeparator(ASep: TLMDLineSeparator);

    procedure SetSyntaxSchemes(ASchemes: TLMDEditParserSchemeCollection);
    procedure SetColorSchemes(ASchemes: TLMDEditParserSchemeCollection);

    procedure UpdateActiveSchemes;
    procedure AllSchemesChanged;
    procedure SchemeChanged(AScheme: TLMDEditParserSchemeCollectionItem);

    procedure SetActiveSyntaxScheme(ASchemeName: TLMDSyntaxSchemeRef);
    procedure SetActiveColorScheme(ASchemeName: TLMDColorSchemeRef);

    procedure SetLines(ALines: TLMDStrings);

    function  GetMaxLineLengthToParse: Integer;
    procedure SetMaxLineLengthToParse(AValue: Integer);

    // All line ends are unchanged after refresh, all marks are saved,
    // undo is saved too.

    procedure RefreshWithSettings;
    procedure StorageBeforeRefresh;
    procedure StorageAfterRefresh;

    function  GetLine(ALine: Integer): TLMDSegment;
    function  GetLineStr(ALine: Integer): TLMDString;
    function  IsWordSeparatorsStored: Boolean;

    function  GetSep(const ASep: TLMDString): TLMDString;

    function  FindNearWordStart(AOffset, AMaxCount: Integer;
                                ABackward, AAllowOffset: Boolean;
                                const ASeparators: TLMDString): Integer;

    function  FindNearWordEnd(AOffset, AMaxCount: Integer;
                              ABackward, AAllowOffset: Boolean;
                              const ASeparators: TLMDString): Integer;

    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;

    procedure SetParser(const AParser: TLMDEditParserBase);

    function  GetChars: TLMDCharSeq;
    function  GetCharsCount: Integer;
    function  GetLinesCount: Integer;

    function  GetCanUndoProp: Boolean;
    function  GetCanRedoProp: Boolean;

    function  GetInsideCompoundEdit: Boolean;

    procedure SetReadOnly(AReadOnly: Boolean);

    function  GetCodePage: TLMDCodePageRef;
    procedure SetCodePage(const Value: TLMDCodePageRef);
    function  GetCodePageName: string;
    procedure SetCodePageName(const Value: string);
    procedure SetCodePageUsePreamble(const Value: Boolean);

    procedure ResetChanges;
    procedure ResetModified;
    procedure SetModFixed;
    procedure SetModifiedByChange;
    procedure SetModifiedByUndoRedo;
    procedure SetUndoCountNoMod;
    function  GetModified: Boolean;
    procedure SetModified(const Value: Boolean);

    //Listeners
    procedure AddInternalListener(const ALst: TLMDDocumentListener);
    procedure RemoveInternalListener(const ALst: TLMDDocumentListener);

    //Internal find/replace functions
    function FindPatternNextLow(ANewStart: Integer;
                                AState: TLMDEditFindReplaceState;
                                AFirstTime: Boolean): Boolean;

    function ReplacePatternNextLow(ANewStart: Integer;
                                   AState: TLMDEditFindReplaceState;
                                   AFirstTime: Boolean): Boolean;
    function GetOnLineMarkCreating: TLMDMarkEvent; deprecated;
    function GetOnLineMarkDeleting: TLMDMarkEvent; deprecated;

  protected
    function  GetInternal: TLMDDocumentInternal;
    procedure DoLinesChanged(AFirstLine, ACount: Integer); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    function GetFullWordSeparators: TLMDString;

    property  LineSeparatorStr: TLMDString read FLineSeparatorStr;

    property  Chars: TLMDCharSeq read GetChars;
    property  CharsCount: Integer read GetCharsCount;
    property  LinesCount: Integer read GetLinesCount;

    property  LineSegments[ALine: Integer]: TLMDSegment read GetLine;

    function  GetParser: TLMDEditParserBase;

    property  Bookmarks: ILMDMarkers read FBookmarks;
    property  Breakpoints: ILMDMarkers read FBreakpoints;
    property  DebugFrameLines: ILMDMarkers read FDebugFrameLines;

    function  GetBreakpointKind(const ABreak: ILMDMark): TLMDBreakpointKind;
    procedure SetBreakpointKind(const ABreak: ILMDMark; AKind: TLMDBreakpointKind);

    function  GetDebugFrameKind(const AFrameMark: ILMDMark): TLMDDebugFrameKind;
    procedure SetDebugFrameKind(const AFrameMark: ILMDMark; AKind: TLMDDebugFrameKind);

    function  CreateCustomMarkers(AKeepMarks, ALineBound: Boolean;
                                  AProduceEvents: Boolean): ILMDMarkers;
    function  CreateCustomLineMarkers(AKeepMarks, AProduceEvents: Boolean): ILMDMarkers; deprecated;

    procedure DetachCustomMarkers(AMarkers: ILMDMarkers);

    procedure BeginCompoundEdit(AFreezeViews: Boolean = True);
    procedure EndCompoundEdit(AFreezeViews: Boolean = True);
    property  InsideCompoundEdit: Boolean read GetInsideCompoundEdit;

    procedure InsertSeg(AStart: Integer; const ASeg: TLMDSegment);
    procedure ReplaceSeg(AStart, ACount: Integer; const ASeg: TLMDSegment);

    procedure Insert(AStart: Integer; const AStr: TLMDString);
    procedure InsertLine(ALine: Integer; const AStr: TLMDString);

    procedure AppendLine(const AStr: TLMDString);

    procedure Replace(AStart, ACount: Integer; const AStr: TLMDString);

    procedure Delete(AStart, ACount: Integer);
    procedure DeleteLine(ALine: Integer);

    function  GetLineByOffset(AOffset: Integer): Integer;
    function  GetLineWithCr(ALine: Integer): TLMDSegment;
    function  GetLineEndKind(ALine: Integer; out Res: TLMDLineSeparator): Boolean;

    procedure Clear;
    procedure ClearNoUndo;

    procedure Undo;
    procedure Redo;
    procedure ClearUndo;

    property  CanUndo: Boolean read GetCanUndoProp;
    property  CanRedo: Boolean read GetCanRedoProp;
    property  Modified: Boolean read GetModified write SetModified;

    property  CodePageName: string read GetCodePageName write SetCodePageName;

    //Find words
    function  FindNextWord(AOffset, AMaxCount: Integer; const ASeparators: TLMDString = ''): TLMDSegment;
    function  FindPrevWord(AOffset, AMaxCount: Integer; const ASeparators: TLMDString = ''): TLMDSegment;

    function  FindNextWordStart(AOffset, AMaxCount: Integer; const ASeparators: TLMDString = ''): Integer;
    function  FindPrevWordStart(AOffset, AMaxCount: Integer; const ASeparators: TLMDString = ''): Integer;

    function  FindNextWordEnd(AOffset, AMaxCount: Integer; const ASeparators: TLMDString = ''): Integer;
    function  FindPrevWordEnd(AOffset, AMaxCount: Integer; const ASeparators: TLMDString = ''): Integer;

    function  FindNearWord(AOffset, AMaxCount: Integer; ABackward: Boolean;
                           const ASeparators: TLMDString = ''): TLMDSegment;

    //Pattern search
    function  FindPatternFirst(AOffset: Integer;
                               const APattern: TLMDString):
                               TLMDEditFindReplaceState; overload;

    function  FindPatternFirst(AOffset: Integer;
                               const APattern: TLMDString;
                               AOpts: TLMDEditSearchOptions):
                               TLMDEditFindReplaceState; overload;

    function  FindPatternFirst(AOffset, AMaxCount: Integer;
                               const APattern: TLMDString;
                               AOpts: TLMDEditSearchOptions):
                               TLMDEditFindReplaceState; overload;

    function  FindPatternFirst(AOffset, AMaxCount: Integer;
                               const APattern: TLMDString;
                               AOpts: TLMDEditSearchOptions;
                               ADirection: TLMDEditSearchDirection):
                               TLMDEditFindReplaceState; overload;

    function  FindPatternNext(ANewStart: Integer; AState: TLMDEditFindReplaceState): Boolean; overload;
    function  FindPatternNext(AState: TLMDEditFindReplaceState): Boolean; overload;

    procedure FindPatternClose(AState: TLMDEditFindReplaceState);

    //Pattern replace
    function  ReplacePatternFirst( AOffset: Integer;
                                   const APattern: TLMDString;
                                   const AReplacement: TLMDString;
                                   AOpts: TLMDEditSearchOptions):
                                   TLMDEditFindReplaceState; overload;

    function  ReplacePatternFirst( AOffset, AMaxCount: Integer;
                                   const APattern: TLMDString;
                                   const AReplacement: TLMDString;
                                   AOpts: TLMDEditSearchOptions):
                                   TLMDEditFindReplaceState; overload;

    function  ReplacePatternFirst( AOffset, AMaxCount: Integer;
                                   const APattern: TLMDString;
                                   const AReplacement: TLMDString;
                                   AOpts: TLMDEditSearchOptions;
                                   ADirection: TLMDEditSearchDirection):
                                   TLMDEditFindReplaceState; overload;

    function  ReplacePatternFirst( AOffset, AMaxCount: Integer;
                                   const APattern: TLMDString;
                                   const AReplacement: TLMDString;
                                   AOpts: TLMDEditSearchOptions;
                                   ADirection: TLMDEditSearchDirection;
                                   AReplaceCallback: TLMDEditReplaceEvent):
                                   TLMDEditFindReplaceState; overload;

    function  ReplacePatternNext(AState: TLMDEditFindReplaceState): Boolean; overload;
    function  ReplacePatternNext(ANewStart: Integer; AState: TLMDEditFindReplaceState): Boolean; overload;

    procedure ReplacePatternClose(AState: TLMDEditFindReplaceState);

    function  ReplacePatternAll(const APattern: TLMDString;
                                const AReplacement: TLMDString):
                                TLMDEditFindReplaceState; overload;

    function  ReplacePatternAll(const APattern: TLMDString;
                                const AReplacement: TLMDString;
                                AOpts: TLMDEditSearchOptions):
                                TLMDEditFindReplaceState; overload;

    function  ReplacePatternAll(AOffset: Integer;
                                const APattern: TLMDString;
                                const AReplacement: TLMDString):
                                TLMDEditFindReplaceState; overload;

    function  ReplacePatternAll(AOffset: Integer;
                                const APattern: TLMDString;
                                const AReplacement: TLMDString;
                                AOpts: TLMDEditSearchOptions):
                                TLMDEditFindReplaceState; overload;

    function  ReplacePatternAll(AOffset, AMaxCount: Integer;
                                const APattern: TLMDString;
                                const AReplacement: TLMDString;
                                AOpts: TLMDEditSearchOptions):
                                TLMDEditFindReplaceState; overload;

    function  ReplacePatternAll(AOffset, AMaxCount: Integer;
                                const APattern: TLMDString;
                                const AReplacement: TLMDString;
                                AOpts: TLMDEditSearchOptions;
                                ADirection: TLMDEditSearchDirection;
                                AReplaceCallback: TLMDEditReplaceEvent):
                                TLMDEditFindReplaceState; overload;

    procedure LoadFromFile(const AFileName: TLMDString); overload;
    procedure LoadFromFile(const AFileName: TLMDString;
                           ACodePage: Integer); overload;
    procedure LoadFromFile(const AFileName: TLMDString;
                           ADefaultCodePage: Integer;
                           AUnicodeAutodetect: Boolean); overload;

    procedure LoadFromStream(Stream: TStream); overload;
    procedure LoadFromStream(Stream: TStream;
                             ACodePage: Integer); overload;
    procedure LoadFromStream(Stream: TStream;
                             ADefaultCodePage: Integer;
                             AUnicodeAutodetect: Boolean); overload;

    procedure SaveToFile(const AFileName: TLMDString); overload;
    procedure SaveToFile(const AFileName: TLMDString;
                         ACodePage: Integer); overload;
    procedure SaveToFile(const AFileName: TLMDString;
                         ACodePage: Integer; AUsePreamble: Boolean); overload;

    procedure SaveToStream(AStream: TStream); overload;
    procedure SaveToStream(AStream: TStream; ACodePage: Integer); overload;
    procedure SaveToStream(AStream: TStream;
                           ACodePage: Integer;
                           AUsePreamble: Boolean); overload;

    //Low-level functions
    procedure AddListener(const ALst: TLMDDocumentListener);
    procedure RemoveListener(const ALst: TLMDDocumentListener);

    procedure BeginUpdate;
    procedure EndUpdate(AWithEvent: Boolean = True);

  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;

    property Lines: TLMDStrings read  FLines write SetLines;

    property CodePage: TLMDCodePageRef read GetCodePage
                                       write SetCodePage default CP_ACP;

    property CodePageUsePreamble: Boolean read FCodePageUsePreamble
                                          write SetCodePageUsePreamble
                                          default false;

    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property UndoLimit: Integer read GetUndoLimit write SetUndoLimit default LMDDefaultUndoLimit;
    property WordSeparators: TLMDString read FWordSeparators write SetWordSeparators stored IsWordSeparatorsStored;

    property LineSeparator: TLMDLineSeparator read FLineSeparator write SetLineSeparator default lsCRLF;

    property SyntaxSchemes: TLMDEditParserSchemeCollection read FSyntaxSchemes write SetSyntaxSchemes;
    property ColorSchemes: TLMDEditParserSchemeCollection read FColorSchemes write SetColorSchemes;

    property ActiveSyntaxScheme: TLMDSyntaxSchemeRef read FSyntaxScheme write SetActiveSyntaxScheme;
    property ActiveColorScheme: TLMDColorSchemeRef read FColorScheme write SetActiveColorScheme;

    property MaxLineLengthToParse: Integer read GetMaxLineLengthToParse write SetMaxLineLengthToParse default MAX_LINE_LENGTH_TO_PARSE;

    property OnMarkDeleting: TLMDMarkEvent read FOnMarkDeleting write FOnMarkDeleting;
    property OnMarkCreating:  TLMDMarkEvent read FOnMarkCreating write FOnMarkCreating;

    property OnLineMarkDeleting: TLMDMarkEvent read GetOnLineMarkDeleting write FOnMarkDeleting;
    property OnLineMarkCreating:  TLMDMarkEvent read GetOnLineMarkCreating write FOnMarkCreating;

    property OnLinesChanged: TLMDDocLinesChanged read FOnLinesChanged write FOnLinesChanged;
    property OnDocChanged: TLMDDocChangedEvent read FOnDocChanged write FOnDocChanged;
  end;

  {Helper class for FindPattern/ReplacePattern}
  TLMDRegexCharSeqSource = class(TLMDRegexSource)
  protected
    FSeq: TLMDCharSeq;
    procedure FillBuffer; override;
  public
    procedure ResetBuffer; override;
    constructor Create(const ASeq: TLMDCharSeq);
  end;

function LMDDefaultWordSeparators: TLMDString;
function LMDAllLineSeparators: TLMDString;

implementation

uses
  Math, LMDProcs, LMDSedParser, LMDUnicode, LMDSedConst, Dialogs;
{$IFDEF LMDDEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

type

  TSearchInternal = class
  public
    Doc: TLMDEditDocument;
    ReSrc: TLMDRegexCharSeqSource;
    Markers: ILMDMarkers;

    destructor Destroy; override;
  end;


  {************************* TLMDTextStorageListener **************************}

  TLMDTextStorageListener = class
    procedure BeforeRefresh; virtual; abstract;
    procedure AfterRefresh;  virtual; abstract;
  end;

  {***************************** TLMDTextStorage ******************************}

  TLMDTextStorage = class (TLMDCharSeq)
  private
    FListener: TLMDTextStorageListener;
  protected
    procedure FireBeforeRefresh;
    procedure FireAfterRefresh;
  public
    constructor Create(ABufSize: Integer);
    destructor Destroy; override;

    procedure SetListener(ALst: TLMDTextStorageListener); virtual;

    procedure SetText(const ASeg: TLMDSegment); virtual; abstract;
    procedure Insert(AIdx: Integer; const ASeg: TLMDSegment); virtual; abstract;
    procedure Delete(AIdx, ALength: Integer); virtual; abstract;
  end;

  {********************************** TMark ***********************************}

  TMark = class;

  IMarkInternal = interface(IInterface)
  ['{9F0FD510-053E-4DE8-B5F4-135FDB3C0E99}']
    function GetImpl: TMark;
  end;

  TMarkCollection = class;

  TMark = class (TInterfacedObject, ILMDMark, IMarkInternal)
  private
    FData:        TLMDDataTag;
    FKind:        Integer;
    FValid:       Boolean;
    FPos:         Integer;
    FLine:        Integer;
    FColumn:      Integer;
    FName:        TLMDString;

    procedure CheckValid;
  public
    Parent:      TMarkCollection;

    constructor Create(APos: Integer; AParent: TMarkCollection);

    function  get_Line: Integer;
    function  get_Column: Integer;

    function  get_Pos: Integer;

    procedure set_Name(AName: TLMDString);
    function  get_Name: TLMDString;

    function  get_IsValid: Boolean;
    function  get_Collection: ILMDMarkers;

    function  get_Data: TLMDDataTag;
    procedure set_Data(AData: TLMDDataTag);
    procedure NotifyDataChanged;
    procedure DeleteFromCollection;

    function  GetBreakKind: TLMDBreakpointKind;
    procedure SetBreakKind(AKind: TLMDBreakpointKind);

    function  GetDebugFrameKind: TLMDDebugFrameKind;
    procedure SetStackFrameKind(AKind: TLMDDebugFrameKind);

    function  GetImpl: TMark;
  end;

  {****************************** TMarkCollection *****************************}

  TMarkEnd = record
    Mark: TMark;
  end;

  TMarkEnds = array of TMarkEnd;

  TMarkManager = class;

  TMarkRange = record
    Start: Integer;
    Count: Integer;
  end;

  TMarkCollection = class(TInterfacedObject, ILMDMarkers)
  private
    FEventLock:     Integer;
    FProduceEvents: Boolean;
    FDisposed:      Boolean;
    FLineBound:     Boolean;
    FKeepMarks:     Boolean;
    FParent:        TMarkManager;
    FMarks:         TMarkEnds;
    FMarksCount:    Integer;
    FSearchCoord:   Integer;

    function Doc: TLMDEditDocument;

    procedure CheckNotDisposed;
    procedure CheckPos(APos: Integer);
    procedure CheckLineIdx(ALine: Integer);
    procedure CheckLineIdxCol(ALine, AColumn: Integer);
    procedure CheckLineRange(ALine, ALinesCount: Integer);
    procedure CheckRange(AStart, ACount: Integer);
    procedure CheckMarkValidForDelete(const AMark: ILMDMark);

    procedure InsMark(AMark: TMark);
    procedure DelMarkByPos(const AMarkI: ILMDMark);
    procedure DelMarksRange(AStart, ACount: Integer);

    procedure SetMarksCount(ANewCount: Integer);

    function  FindBound(AStart, AEnd, APos: Integer; ALower: Boolean): Integer;
    function  UpperBound(APos: Integer): Integer;
    function  LowerBound(APos: Integer): Integer;
    procedure CopyMarks(ASrc, ADest, ACount, OldMarksCount: Integer);
    procedure ReleaseMark(AIdx: Integer);

    function  CanKeepMarks(ADeletingCount: Integer): Boolean;

    procedure GetPosRangeBySegment(AStart, ACount: Integer; out ALo, AUp: Integer);
    procedure GetPosRangeForDelete(AStart, ACount: Integer; out ALo, AUp: Integer);

    procedure DeleteIMarkLow(const AMark: ILMDMark);
    procedure ClearLow;

    procedure DoBeforeChange;
    procedure FireMarksDeleting(const AMarks: TLMDMarkArray);
    procedure FireMarkDeleting(const AMark: ILMDMark);
    procedure FireMarkCreated(const AMark: ILMDMark);
    procedure DoAfterChange;
    procedure FireMarkSettingsChanged(const AMark: ILMDMark);

    function GetMarksByLinesLow(AStartLine, ACount: Integer): TMarkRange;
  protected
    function  LineMarks(AIndex: Integer): ILMDMark;
    function  CreateMarkAtLine(ALine: Integer): ILMDMark;
    function  CreateMarkAtCol(ALine, AColumn: Integer): ILMDMark;
    function  CreateMarkAtOffset(AOffset: Integer): ILMDMark;

    function  FindMarkByName(const AName: TLMDString): ILMDMark;

  public
    constructor Create(AParent: TMarkManager;
                       ALineBound, AKeepMarks, AProduceEvents: Boolean);
    destructor Destroy; override;
    procedure  Dispose(AWithEvents: Boolean);

    procedure ContentInserted(AStart, ACount: Integer);
    procedure ContentDeleting(AStart, ACount: Integer);
    function  GetMarksToDelete(AStart, ACount: Integer;
                               AWithKeep: Boolean): TLMDMarkArray;

    function  GetMarksBySegment(AStart, ACount: Integer): TLMDMarkArray;
    function  GetMarksByLines(AStartLine, ACount: Integer): TLMDMarkArray;
    function  GetMarksCountByLines(AStartLine, ACount: Integer): Integer;

    function  CreateMark(APos: Integer): ILMDMark;

    function  ILMDMarkers.CreateMarkAtLine = CreateMarkAtLine;
    function  ILMDMarkers.CreateMarkAtCol = CreateMarkAtCol;
    function  ILMDMarkers.CreateMarkAtOffset = CreateMarkAtOffset;
    function  ILMDMarkers.Marks = LineMarks;

    function  ILMDMarkers.FindByName = FindMarkByName;

    function  EnumMarkers(AEnumerator: TLMDMarkEnumFunction;
                          AData: Pointer = nil): ILMDMark;

    function  EnumMarkersByLines(AStartLine, ACount: Integer;
                                 AEnumerator: TLMDMarkEnumFunction;
                                 AData: Pointer = nil): ILMDMark;

    function  EnumMarkersByOffset(AStartOffset, ACount: Integer;
                                  AEnumerator: TLMDMarkEnumFunction;
                                  AData: Pointer = nil): ILMDMark;

    function  GetLastLineMark(ALine: Integer): ILMDMark;

    procedure DeleteMark(const AMark: ILMDMark);

    procedure DeleteMarksAtLine(ALine: Integer);
    procedure DeleteLastMarkAtLine(ALine: Integer);

    procedure Clear;

    function get_Count: Integer;
    function Marks(AIndex: Integer): ILMDMark;

    property ProduceEvents: Boolean read FProduceEvents write FProduceEvents;
  end;

  {******************************* TMarkManager *******************************}

  TMarkManager = class
  private
    FMarks:  TList;
    FIMarks: TInterfaceList;
    FDoc:    TLMDEditDocument;
  public
    constructor Create(ADoc: TLMDEditDocument);
    destructor  Destroy; override;

    function  CreateMarks(ALineBound, AKeepMarks,
                          AProduceEvents: Boolean): ILMDMarkers;

    function  HasMarks(AMarks: IInterface): Boolean;
    procedure ReleaseMarks(AMarks: IInterface);

    function  GetMarks(AIdx: Integer): TMarkCollection;

    function  MarksCount: Integer;

    procedure ContentInserted(AStart, ACount: Integer);
    procedure ContentDeleting(AStart, ACount: Integer);

    procedure  ClearAllMarks;
    procedure  SetDocument(ADoc: TLMDEditDocument);
  end;

  {*********************** TDocumentStorageListener ***************************}

  TDocumentStorageListener = class(TLMDTextStorageListener)
  private
    FDoc: TLMDEditDocument;
  public
    constructor Create(ADoc: TLMDEditDocument);

    procedure BeforeRefresh; override;
    procedure AfterRefresh;  override;
  end;

  {************************* TDocumentStringsProxy ****************************}

  TDocumentStringsProxy = class(TLMDStrings)
  private
    FParent: TLMDEditDocument;
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AParent: TLMDEditDocument);

    procedure Assign(Source: TPersistent); override;
    function  Get(Index: Integer): TLMDBaseString; override;

    function  GetCount: Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;

    procedure Insert(Index: Integer; const S: TLMDBaseString); override;

    procedure SetUpdateState(Updating: Boolean); override;

    procedure LoadFromFile(const FileName: TLMDBaseString); override;

    procedure LoadFromStream(Stream: TStream); override;

    procedure SaveToStream(Stream: TStream); override;
  end;

  {****************************** TGapStorage *********************************}

  TGapStorage = class(TLMDTextStorage)
  private
    FArr:       TLMDCharArray;
    FGapStart:  Integer;
    FGapEnd:    Integer;
    FGapSize:   Integer;

    procedure MoveGapStart(AStart: Integer);
    procedure MoveGapEnd(AEnd: Integer);
    procedure Init;
    procedure EnsureCapacity(ACap: Integer);

    procedure CheckSegValid(const ASeg: TLMDSegment);
    procedure CheckInsIdx(AIdx: Integer);
    procedure CheckIdx(AIdx: Integer);
    procedure CheckRange(AIdx, ACount: Integer);
    procedure AdjustGap;
  protected
    procedure FillBuffer(ABufferStart, ABufferEnd: Integer); override;
  public
    constructor Create(AGapSize: Integer = LMDDefaultUndoLimit);
    destructor Destroy; override;

    procedure SetText(const ASeg: TLMDSegment); override;
    procedure Insert(AIdx: Integer; const ASeg: TLMDSegment); override;
    procedure Delete(AIdx: Integer; ACount: Integer); override;
  end;

  {***************************** TUndoActionList ******************************}

  TUndoAction = class;
  TUndoManager = class;

  TUndoActionList = class
  private
    FLastUndo: TUndoAction;
    FLastRedo: TUndoAction;
  public
    UndoCount: Integer;
    RedoCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure PushUndo(Act: TUndoAction);
    procedure PushRedo(Act: TUndoAction);

    function  PopUndo: TUndoAction;
    function  PopRedo: TUndoAction;

    function  TopUndo: TUndoAction;
    function  TopRedo: TUndoAction;

    procedure CutRedo;

    procedure DeleteFirstUndo;

    procedure SwapUndoRedo;
  end;

  {********************************* TUndoAction ******************************}

  TUndoAction = class
  public
    Prev:             TUndoAction;
    Parent:           TUndoManager;
    AuthorID:         Integer;
    IsAuthorsCommon:  Boolean;
    Info:             TLMDDocUndoInfo;
    CanMerge:         Boolean;
  public
    constructor Create(AParent: TUndoManager;
                       AAuthorID: Integer;
                       AOldInfo: TLMDDocUndoInfo);
    destructor Destroy; override;

    // Returns inverse action if Result=Self then inverse is action itself
    // otherwise, creates new action.
    function Exec: TUndoAction; virtual; abstract;

    // Merges with info from ANewAction, and owns ANewAction
    // caller _should_not_free merged ANewAction, it can't use
    // merged action.
    function Merge(ANewAction: TUndoAction): Boolean; virtual; abstract;

    function CloneInfo: TLMDDocUndoInfo;
  end;

  {****************************** TDummyAction ********************************}

  TDummyAction = class (TUndoAction)
  public
    constructor Create(AParent: TUndoManager;
                       AAuthorID: Integer;
                       AOldInfo: TLMDDocUndoInfo);

    function Exec: TUndoAction; override;
    function Merge(ANewAction: TUndoAction): Boolean; override;
  end;

  {******************************* TDeleteAction ******************************}

  TDeleteAction = class (TUndoAction)
  private
    Start: Integer;
    Count: Integer;
  public
    constructor Create(AStart, ACount: Integer;
                       AParent: TUndoManager;
                       AAuthorID: Integer;
                       AOldInfo: TLMDDocUndoInfo);

    function Exec: TUndoAction; override;
    function Merge(ANewAction: TUndoAction): Boolean; override;
  end;

  {******************************** TInsertAction *****************************}

  TInsertAction = class (TUndoAction)
  private
    Start: Integer;
    Count: Integer;
    Store: TLMDTextStorage;

    procedure Append(AStart, ACount: Integer);
    procedure Prepend(AStart, ACount: Integer);
  public
    constructor Create(AStart, ACount: Integer;
                       AParent: TUndoManager;
                       AAuthorID: Integer;
                       AOldInfo: TLMDDocUndoInfo);
    destructor Destroy; override;

    function Exec: TUndoAction; override;
    function Merge(ANewAction: TUndoAction): Boolean; override;
  end;

  {****************************** TCompoundAction *****************************}

  // Assert: for all actions in FActList:
  //  Action.AuthorID = TCompoundAction.AuthorID
  //    Authors is always same here.
  //  Action.Info=nil (only top-level actions supports info).

  TCompoundAction = class (TUndoAction)
  private
    FActList: TUndoActionList;
  public
    constructor Create(AParent: TUndoManager;
                       AAuthorID: Integer;
                       AOldInfo: TLMDDocUndoInfo);
    destructor Destroy; override;

    function Exec: TUndoAction; override;
    function Merge(ANewAction: TUndoAction): Boolean; override;
  end;

  {******************************** TUndoManager ******************************}

  TUndoManager = class
  private
    FLimit:         Integer;
    FCompoundEdit:  Boolean;
    FActList:       TUndoActionList;

    procedure PushAction(Act: TUndoAction);
    function HaveLimit: Boolean;
  public
    Doc: TLMDEditDocument;
  public
    constructor Create(ADoc: TLMDEditDocument; ALimit: Integer);
    destructor Destroy; override;

    function CanRedo(AAuthorID: Integer): Boolean;
    function CanUndo(AAuthorID: Integer): Boolean;

    procedure SetTopUndoCantMerge;
    function UndoCount: Integer;
    procedure Undo(AAuthorID: Integer;
                   ANewInfo: TLMDDocUndoInfo;
                   var OldInfo: TLMDDocUndoInfo);
    procedure Redo(AAuthorID: Integer;
                   ANewInfo: TLMDDocUndoInfo;
                   var OldInfo: TLMDDocUndoInfo);

    property Limit: Integer read FLimit write FLimit;

    procedure ContentInserted(AStart, ACount, AAuthorID: Integer;
                              AOldInfo: TLMDDocUndoInfo);
    procedure ContentDeleting(AStart, ACount, AAuthorID: Integer;
                              AOldInfo: TLMDDocUndoInfo);
    procedure PushCustomAction(AAuthorID: Integer;
                               AOldInfo: TLMDDocUndoInfo);

    procedure BeginCompoundAction(AAuthorID: Integer;
                                  AOldInfo: TLMDDocUndoInfo);
    procedure EndCompoundAction;

    function  InsideCompoundAction: Boolean;

    procedure Clear;

    procedure SetLimit(ALimit: Integer);
  end;

  {******************************* TLineManager *******************************}

  TLineManResult = record
    FirstChangedLine:   Integer;
    ChangedLinesCount:  Integer;
  end;

  TLineManager = class
  private
    FDoc:   TLMDEditDocument;
    FCount: Integer;
    FEnds:  TLMDIntArray;
    FChars: TLMDCharSeq;

    procedure CheckCapacity(ANewCount: Integer);
  public
    constructor Create(ADoc: TLMDEditDocument);

    function  Count: integer;
    function  GetAt(AIdx: Integer): TLMDSegment;
    function  GetLineStart(AIdx: Integer): Integer;
    function  GetLineByOffset(AOffset: Integer): Integer;
    function  GetLineEndKind(ALine: Integer; out Res: TLMDLineSeparator): Boolean;
    procedure Refresh;

    function ContentInserted(AStart, ALength: Integer): TLineManResult;
    function ContentDeleting(AStart, ALength: Integer): TLineManResult;
  end;

const
  DefaultGapSize         = 5000;
  LineSepShift           = 30;
  LineSepLnMask: Integer = 1 shl LineSepShift;
  LineStartMask: Integer = (1 shl LineSepShift) - 1;


function MakeFindState(AOffset, AMaxCount: Integer;
                       const APattern: TLMDString;
                       AOpts: TLMDEditSearchOptions;
                       ADirection: TLMDEditSearchDirection;
                       ADoc: TLMDEditDocument):
                       TLMDEditFindReplaceState;
var
    State: TLMDEditFindReplaceState;
    ReSrc: TLMDRegexCharSeqSource;
    Internal: TSearchInternal;
    EndM: Integer;
begin
  State := TLMDEditFindReplaceState.Create;

  try
    State.Start := AOffset;
    State.Pattern := APattern;
    State.Options := AOpts;
    State.Direction := ADirection;
    State.LastReplaceAction := raCancel;

    Internal := TSearchInternal.Create;
    Internal.Doc := ADoc;
    State.Internal := Internal;
    Internal.Markers := ADoc.CreateCustomMarkers(true, false, false);

    if ADirection = sdForward then
    begin
      if AMaxCount <> -1 then
        EndM := Min(ADoc.CharsCount, AOffset + AMaxCount)
      else
        EndM := ADoc.CharsCount;
    end
    else
    begin
      if AMaxCount <> -1 then
        EndM := Max(0, AOffset - AMaxCount)
      else
        EndM := 0;
    end;

    State.EndM := Internal.Markers.CreateMarkAtOffset(EndM);

    if soRegexp in AOpts then
    begin
      State.FoundRegex := TLMDRegExp.Create;

      if soCaseSensitive in AOpts then
        State.FoundRegex.ModifierI := False
      else
        State.FoundRegex.ModifierI := True;

      State.FoundRegex.ModifierM := True;
      State.FoundRegex.Expression := APattern;

      ReSrc := TLMDRegexCharSeqSource.Create(ADoc.Chars);
      State.FoundRegex.InputSource := ReSrc;

      Internal.ReSrc := ReSrc;
    end
    else
      State.FoundRegex := nil;

    State.FoundSegment := LMDSegment(AOffset, 0, ADoc.Chars);
  except
    on E: Exception do
    begin
      FreeAndNil(State);
      Raise;
    end;
  end;

  Result := State;
end;

{*********************************** TMark ************************************}
{------------------------------------------------------------------------------}

procedure TMark.CheckValid;

  procedure RaiseInvalidMark;
  begin
    raise ELMDEditDocError.Create(SLMDSedDocInvalidMarkUsed);
  end;

begin
  if not FValid then
    RaiseInvalidMark;
end;

{------------------------------------------------------------------------------}

constructor TMark.Create(APos: Integer; AParent: TMarkCollection);
begin
  inherited Create;

  FKind := 0;
  FPos := APos; Parent := AParent;
  FLine := -1;
  FColumn := -1;
  FValid := True;
  FName := '';
  FData := nil;
end;

procedure TMark.DeleteFromCollection;
var
    M: ILMDMark;
begin
  CheckValid;

  M := self as ILMDMark;
  Parent.DeleteMark(M);
end;

{------------------------------------------------------------------------------}

function TMark.get_Name: TLMDString;
begin
  CheckValid;
  Result := FName;
end;

{------------------------------------------------------------------------------}

function TMark.get_Line: Integer;
begin
  if not FValid then //CheckValid Inlined partially
    CheckValid;

  if FLine = -1 then
    FLine := Parent.Doc.GetLineByOffset(FPos);

  Result := FLine;
end;

{------------------------------------------------------------------------------}

function TMark.get_Pos: Integer;
begin
  if not FValid then //CheckValid Inlined partially
    CheckValid;

  Result := FPos;
end;

{------------------------------------------------------------------------------}

function TMark.get_Collection: ILMDMarkers;
begin
  Result := Parent;
end;

{------------------------------------------------------------------------------}

function TMark.get_Column: Integer;
begin
  if not FValid then //CheckValid Inlined partially
    CheckValid;

  if FLine = -1 then
  begin
    FLine := Parent.Doc.GetLineByOffset(FPos);
    FColumn := FPos - Parent.Doc.LineSegments[FLine].Start;
  end;

  Result := FLine;
end;

{------------------------------------------------------------------------------}

function TMark.get_Data: TLMDDataTag;
begin
  Result := FData;
end;

{------------------------------------------------------------------------------}

function TMark.GetBreakKind: TLMDBreakpointKind;
begin
  Result := TLMDBreakpointKind(FKind);
end;

{------------------------------------------------------------------------------}

function  TMark.GetImpl: TMark;
begin
  result := self;
end;

function TMark.GetDebugFrameKind: TLMDDebugFrameKind;
begin
  Result := TLMDDebugFrameKind(FKind);
end;

{------------------------------------------------------------------------------}

procedure TMark.set_Data(AData: TLMDDataTag);
begin
  CheckValid;

  if FData<>AData then
  begin
    Parent.DoBeforeChange;
    try
      Parent.FireMarkSettingsChanged(Self);
      FData := AData
    finally
      Parent.DoAfterChange
    end
  end
end;

{------------------------------------------------------------------------------}

procedure TMark.NotifyDataChanged;
begin
  CheckValid;

  Parent.DoBeforeChange;
  try
    Parent.FireMarkSettingsChanged(Self);
  finally
    Parent.DoAfterChange;
  end;
end;

{------------------------------------------------------------------------------}

procedure TMark.SetBreakKind(AKind: TLMDBreakpointKind);
begin
  CheckValid;

  if FKind <> Integer(AKind) then
  begin
    Parent.DoBeforeChange;
    try
      Parent.FireMarkSettingsChanged(Self);
      FKind := Integer(AKind);
    finally
      Parent.DoAfterChange
    end
  end
end;

procedure TMark.SetStackFrameKind(AKind: TLMDDebugFrameKind);
begin
  CheckValid;

  if FKind <> Integer(AKind) then
  begin
    Parent.DoBeforeChange;
    try
      Parent.FireMarkSettingsChanged(Self);
      FKind := Integer(AKind);
    finally
      Parent.DoAfterChange
    end
  end
end;

{------------------------------------------------------------------------------}

procedure TMark.set_Name(AName: TLMDString);
begin
  CheckValid;

  if FName<>AName then
  begin
    Parent.DoBeforeChange;
    try
      FName := AName;
      Parent.FireMarkSettingsChanged(Self)
    finally
      Parent.DoAfterChange
    end
  end
end;

{------------------------------------------------------------------------------}

function TMark.get_IsValid: Boolean;
begin
  Result := FValid;
end;

{******************************* TMarkCollection ******************************}
{------------------------------------------------------------------------------}

constructor TMarkCollection.Create(AParent: TMarkManager;
                                   ALineBound, AKeepMarks,
                                   AProduceEvents: Boolean);
begin
  inherited Create;

  FDisposed := False;
  FParent := AParent;

  FMarksCount := 0;
  FLineBound := ALineBound;
  FKeepMarks := AKeepMarks;
  FProduceEvents := AProduceEvents;
  FEventLock := 0;
end;

function TMarkCollection.CreateMarkAtCol(ALine, AColumn: Integer): ILMDMark;
var
  Pos: Integer;
begin
  CheckNotDisposed;
  CheckLineIdxCol(ALine, AColumn);

  DoBeforeChange;
  try
    Pos := Doc.LineSegments[ALine].Start + AColumn;

    Result := CreateMark(Pos);
  finally
    DoAfterChange;
  end;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.ClearLow;
begin
  CheckNotDisposed;
  DelMarksRange(0, FMarksCount);
end;

{------------------------------------------------------------------------------}

destructor TMarkCollection.Destroy;
begin
  if not FDisposed then
    Dispose(False);

  inherited;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.Dispose(AWithEvents: Boolean);
begin
  if AWithEvents then
    Clear
  else
    ClearLow;

  FParent := nil;

  FDisposed := True;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.Clear;

  function GetMarksLoc: TLMDMarkArray;
  var
    i: Integer;
  begin
    SetLength(Result, FMarksCount);
    for i := 0 to FMarksCount-1 do
      Result[i] := FMarks[i].Mark;
  end;

begin
  CheckNotDisposed;

  if FMarksCount>0 then
  begin
    DoBeforeChange;
    try
      if FProduceEvents then
        FireMarksDeleting(GetMarksLoc);
      ClearLow;
    finally
      DoAfterChange
    end
  end
end;

{------------------------------------------------------------------------------}

function TMarkCollection.get_Count: Integer;
begin
  CheckNotDisposed;
  Result := FMarksCount
end;

{------------------------------------------------------------------------------}

function TMarkCollection.Marks(AIndex: Integer): ILMDMark;
begin
  CheckNotDisposed;
  Result := FMarks[AIndex].Mark;
end;

{------------------------------------------------------------------------------}

function TMarkCollection.Doc: TLMDEditDocument;
begin
  Result := FParent.FDoc;
end;

function TMarkCollection.EnumMarkers(AEnumerator: TLMDMarkEnumFunction;
                                     AData: Pointer): ILMDMark;
begin
  Result := EnumMarkersByOffset(0, -1, AEnumerator,  AData);
end;


function TMarkCollection.EnumMarkersByLines(AStartLine, ACount: Integer;
                                            AEnumerator: TLMDMarkEnumFunction;
                                            AData: Pointer): ILMDMark;
var
  i: Integer; range: TMarkRange;
  Stop: Boolean;
  M: ILMDMark;
begin
  Result := nil;
  if (FMarksCount = 0) or (ACount = 0) then
    Exit;

  CheckNotDisposed;
  CheckLineRange(AStartLine, ACount);

  Range := GetMarksByLinesLow(AStartLine, ACount);

  Stop := false;
  for i := 0 to range.Count - 1 do
  begin
    M := FMarks[i + range.Start].Mark;
    AEnumerator(M, AData, Stop);
    if Stop then
    begin
      Result := M;
      Break;
    end;
  end;
end;

function TMarkCollection.EnumMarkersByOffset(AStartOffset, ACount: Integer;
                                             AEnumerator: TLMDMarkEnumFunction;
                                             AData: Pointer): ILMDMark;
var
  i, lo, up: Integer;
  Stop: Boolean;
  M: ILMDMark;
begin
  Result := nil;
  if (FMarksCount = 0) or (ACount = 0) then
    Exit;

  CheckNotDisposed;
  CheckRange(AStartOffset, ACount);

  GetPosRangeBySegment(AStartOffset, ACount, lo, up);
  if up-lo > 1 then
  begin
    Stop := false;
    for i := lo + 1 to up - 1 do
    begin
      M := FMarks[i].Mark;
      AEnumerator(M, AData, Stop);
      if Stop then
      begin
        Result := M;
        Break;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.CheckNotDisposed;

  procedure RaiseDisposed;
  begin
    raise ELMDEditDocError.Create(SLMDSedDocDisposedMarkersUsed);
  end;

begin
  if FDisposed then
    RaiseDisposed;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.CheckPos(APos: Integer);
begin
  Doc.CheckInsOffset(APos);
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.CheckLineIdx(ALine: Integer);
begin
  Doc.CheckLineIdx(ALine);
end;

procedure TMarkCollection.CheckLineIdxCol(ALine, AColumn: Integer);
begin
  Doc.CheckLineIdxCol(ALine, AColumn);
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.CheckLineRange(ALine, ALinesCount: Integer);
begin
  CheckLineIdx(ALine);
  CheckLineIdx(ALine+ALinesCount-1);
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.CheckRange(AStart, ACount: Integer);
begin
  CheckPos(AStart);
  if ACount>0 then
    CheckPos(AStart+ACount-1)
  else
    CheckPos(AStart+ACount);
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.SetMarksCount(ANewCount: Integer);
var
  i, NewLn: Integer;
begin
  for i := ANewCount to FMarksCount-1 do
    FMarks[i].Mark := nil;

  NewLn := GetNewArrLength(ANewCount, Length(FMarks));
  if NewLn<>-1 then
    SetLength(FMarks, NewLn);

  FMarksCount := ANewCount;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.CheckMarkValidForDelete(const AMark: ILMDMark);

  procedure RaiseInvalid;
  begin
    raise ELMDEditDocError.Create(SLMDSedDocCantRemoveInvalidMarker);
  end;

begin
  if not AMark.IsValid then
    RaiseInvalid;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.ReleaseMark(AIdx: Integer);
begin
  FMarks[AIdx].Mark._Release;

  FMarks[AIdx].Mark := nil;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.InsMark(AMark: TMark);
var
  idx: Integer; OldCnt, Pos: Integer;
begin
  Pos := AMark.get_Pos;
  CheckPos(Pos);

  idx := UpperBound(Pos);

  OldCnt := FMarksCount;
  SetMarksCount(FMarksCount+1);

  if idx<OldCnt then
    CopyMarks(idx, idx+1, OldCnt-idx, OldCnt);

  AMark._AddRef;

  FMarks[idx].Mark  := AMark;
  FMarks[idx].Mark.FValid := True;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.DelMarkByPos(const AMarkI: ILMDMark);
var
  idx: Integer; Pos: Integer;
  Itf, Itf2: IInterface;
begin
  CheckMarkValidForDelete(AMarkI);

  Pos := AMarkI.get_Pos;

  idx := LowerBound(Pos)+1;
  Itf := AMarkI as IInterface;

  Itf2 := nil;
  while (idx<FMarksCount) and (FMarks[idx].Mark.FPos=Pos) do
  begin
    Itf2 := FMarks[idx].Mark as IInterface;

    if Itf2 <> Itf then
      Inc(idx)
    else
      Break;
  end;

  Assert((idx<FMarksCount) and (Itf2=Itf));

  DelMarksRange(idx, 1);
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.DelMarksRange(AStart, ACount: Integer);
var
  i, aend: Integer;
begin
  if ACount=0 then
    Exit;

  aend := AStart + ACount;

  for i := AStart to aend - 1 do
  begin
    FMarks[i].Mark.FValid := False;
    ReleaseMark(i);
  end;

  if aend < FMarksCount then
    CopyMarks(aend, AStart, FMarksCount-aend, FMarksCount);

  SetMarksCount(FMarksCount-ACount);
end;

{------------------------------------------------------------------------------}

function TMarkCollection.CanKeepMarks(ADeletingCount: Integer): Boolean;
begin
  Result := FKeepMarks;
end;

{------------------------------------------------------------------------------}

function TMarkCollection.FindBound(AStart, AEnd, APos: Integer;
  ALower: Boolean): Integer;
var
  Cmp, Mid: Integer;
begin
  if FMarksCount>0 then
    while AStart<>AEnd do
    begin
      if not ALower then
        Mid := AStart + ((AEnd - AStart) div 2)
      else
        Mid := AEnd - ((AEnd - AStart) div 2);

      if Mid=-1 then
        Cmp := 1
      else if Mid=FMarksCount then
        Cmp := MaxInt
      else
        Cmp := FMarks[Mid].Mark.FPos - APos;

      if not ALower then
      begin
        if Cmp>0 then
          AEnd := Mid
        else
          AStart := Mid + 1
      end
      else
      begin
        if Cmp<0 then
          AStart := Mid
        else
          AEnd := Mid-1
      end
    end;

  Result := AStart
end;

{------------------------------------------------------------------------------}

function TMarkCollection.UpperBound(APos: Integer): Integer;
begin
  FSearchCoord := APos;
  Result := FindBound(0, FMarksCount, APos, False);
  Assert((Result>=FMarksCount) or (FMarks[Result].Mark.FPos>APos));
end;

{------------------------------------------------------------------------------}

function TMarkCollection.LowerBound(APos: Integer): Integer;
begin
  FSearchCoord := APos;
  Result := FindBound(-1, FMarksCount, APos, True);
  Assert((Result<0) or (FMarks[Result].Mark.FPos<APos));
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.CopyMarks(ASrc, ADest, ACount,
  OldMarksCount: Integer);
begin
  if ACount=0 then
    Exit;

  System.Move(FMarks[ASrc], FMarks[ADest], ACount*Sizeof(FMarks[ASrc]));
end;

{------------------------------------------------------------------------------}

function TMarkCollection.CreateMark(APos: Integer): ILMDMark;
var
  Mark: TMark;
begin
  CheckNotDisposed;
  CheckPos(APos);

  DoBeforeChange;
  try
    Mark := TMark.Create(APos, Self);

    InsMark(Mark);
    Result := Mark;

    FireMarkCreated(Result);
  finally
    DoAfterChange
  end
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.DeleteIMarkLow(const AMark: ILMDMark);
begin
  CheckNotDisposed;

  DelMarkByPos(AMark);
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.DoBeforeChange;
begin
  if FProduceEvents and (FEventLock=0) then
    FParent.FDoc.DoBeforeMarkChange;

  Inc(FEventLock);
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.FireMarksDeleting(const AMarks: TLMDMarkArray);
begin
  if FProduceEvents then
    FParent.FDoc.FireMarksDeleting(self, AMarks);
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.FireMarkDeleting(const AMark: ILMDMark);
var
  Marks: TLMDMarkArray;
begin
  if not FProduceEvents then
    Exit;

  SetLength(Marks, 1);
  Marks[0] := AMark;
  FireMarksDeleting(Marks);
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.FireMarkCreated(const AMark: ILMDMark);
begin
  if FProduceEvents then
    FParent.FDoc.FireMarkCreated(self, AMark);
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.DoAfterChange;
begin
  Dec(FEventLock);

  if FProduceEvents and (FEventLock=0) then
    FParent.FDoc.DoAfterMarkChange;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.FireMarkSettingsChanged(const AMark: ILMDMark);
begin
  if FProduceEvents then
    FParent.FDoc.FireMarkSettingsChanged(self, AMark);
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.DeleteMark(const AMark: ILMDMark);
begin
  CheckNotDisposed;
  CheckMarkValidForDelete(AMark);

  DoBeforeChange;
  try
    FireMarkDeleting(AMark);
    DeleteIMarkLow(AMark);
  finally
    DoAfterChange;
  end;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.DeleteMarksAtLine(ALine: Integer);
var
  i: Integer; range: TMarkRange; Marks: TLMDMarkArray;
begin
  CheckNotDisposed;
  CheckLineIdx(ALine);

  range := GetMarksByLinesLow(ALine, 1);
  if range.Count>0 then
  begin
    DoBeforeChange;
    try
      SetLength(marks, range.Count);
      for i := 0 to range.Count - 1 do
        Marks[i] := FMarks[i+range.Start].Mark;

      FireMarksDeleting(Marks);

      DelMarksRange(range.Start, range.Count);
    finally
      DoAfterChange
    end
  end
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.DeleteLastMarkAtLine(ALine: Integer);
var
  range: TMarkRange;
  Last: ILMDMark;
  aend: Integer;
begin
  CheckNotDisposed;
  CheckLineIdx(ALine);

  range := GetMarksByLinesLow(ALine, 1);
  if range.Count>0 then
  begin
    DoBeforeChange;
    try
      aend := range.Start + range.Count - 1;

      Last := FMarks[aend].Mark;

      FireMarkDeleting(Last);

      range.Start := aend;
      range.Count := 1;
      DelMarksRange(range.Start, range.Count);
    finally
      DoAfterChange
    end;
  end
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.GetPosRangeBySegment(AStart, ACount: Integer;
  out ALo, AUp: Integer);
begin
  CheckNotDisposed;
  CheckRange(AStart, ACount);

  ALo := LowerBound(AStart);
  AUp := UpperBound(AStart + ACount - 1);
end;

{------------------------------------------------------------------------------}

procedure  TMarkCollection.GetPosRangeForDelete(AStart, ACount: Integer;
  out ALo, AUp: Integer);
var
  LnS, LnE, RangeCount: Integer;
begin
  CheckNotDisposed;
  CheckRange(AStart, ACount);

  RangeCount := ACount;
  if FLineBound then
  begin
    LnE := Doc.GetLineByOffset(AStart + ACount);
    if Doc.LineSegments[LnE].Start = (AStart + ACount) then
      Inc(RangeCount);
  end;

  GetPosRangeBySegment(AStart, RangeCount, ALo, AUp);
  if FLineBound and (AUp-ALo>1) and (ACount<>FParent.FDoc.CharsCount) then
  begin
    LnS := Doc.GetLineByOffset(AStart);
    if ACount<=Doc.LineSegments[LnS].Count then
      while (ALo+1<AUp) and (FMarks[ALo+1].Mark.FPos=AStart) do
        Inc(ALo);

    LnE := Doc.GetLineByOffset(AStart+ACount);
    if (LnE<>LnS) and (Doc.LineSegments[LnS].Count=0) then
      while (AUp>0) and (FMarks[AUp-1].Mark.FPos=AStart+ACount) do
        Dec(AUp);
  end;
end;

{------------------------------------------------------------------------------}

function TMarkCollection.GetMarksBySegment(AStart,
  ACount: Integer): TLMDMarkArray;
var
  i, lo, up: Integer;
begin
  SetLength(Result, 0);
  if (FMarksCount = 0) or (ACount = 0) then
    Exit;

  CheckNotDisposed;
  CheckRange(AStart, ACount);

  GetPosRangeBySegment(AStart, ACount, lo, up);
  if up-lo > 1 then
  begin
    SetLength(Result, up-lo-1);
    for i := lo+1 to up-1 do
      Result[i-lo-1] := FMarks[i].Mark;
  end;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.ContentDeleting(AStart, ACount: Integer);
var
  lo, up, i, SavePoint: Integer;
  LnS, LnE: Integer;
begin
  CheckNotDisposed;
  if (FMarksCount=0) or (ACount=0) then
    Exit;

  CheckRange(AStart, ACount);

  GetPosRangeForDelete(AStart, ACount, lo, up);

  if FLineBound then
  begin
    LnS := Doc.GetLineByOffset(AStart);
    LnE := Doc.GetLineByOffset(AStart+ACount);
  end
  else
  begin
    LnS := 0;
    LnE := 0;
  end;

  if up-lo>1 then
  begin
    if CanKeepMarks(ACount)  then
    begin
      if FLineBound then
        SavePoint := Doc.LineSegments[LnS].Start
      else
        SavePoint := AStart;

      Inc(lo);
      while (lo<up) do
      begin
        FMarks[lo].Mark.FPos := SavePoint;
        if FLineBound then
          FMarks[lo].Mark.FLine := LnS;
        Inc(lo);
      end;
      Dec(lo);
    end
    else
      DelMarksRange(lo+1, up-lo-1);
  end;

  for i := lo+1 to FMarksCount-1 do
  begin
    Dec(FMarks[i].Mark.FPos, ACount);
    if FLineBound then
      with FMarks[i].Mark do
        if FLine <> -1 then
          Dec(FLine, LnE-LnS);
  end;
end;

{------------------------------------------------------------------------------}

function TMarkCollection.GetMarksToDelete(AStart, ACount: Integer;
                                          AWithKeep: Boolean): TLMDMarkArray;
var
  i, lo, up: Integer;
begin
  CheckNotDisposed;
  if (FMarksCount=0) or (ACount=0) then
    Exit;

  CheckRange(AStart, ACount);

  GetPosRangeForDelete(AStart, ACount, lo, up);
  if (up-lo > 1) and (not (AWithKeep and CanKeepMarks(ACount))) then
  begin
    SetLength(Result, up-lo-1);

    for i := lo + 1 to up - 1  do
      Result[i-lo-1] := FMarks[i].Mark;
  end;
end;

{------------------------------------------------------------------------------}

procedure TMarkCollection.ContentInserted(AStart, ACount: Integer);
var
  i, lo, LnE, LnS: Integer;
begin
  CheckNotDisposed;
  if (FMarksCount=0) or (ACount=0) then
    Exit;

  CheckRange(AStart, ACount);

  Lo := LowerBound(AStart);

  if FLineBound then
  begin
    LnS := Doc.GetLineByOffset(AStart);
    LnE := Doc.GetLineByOffset(AStart+ACount);

    if Doc.LineSegments[LnE].Start<>AStart+ACount then
    begin
      i := Lo+1;
      while (i<FMarksCount) and (FMarks[i].Mark.FPos=AStart) do
        Inc(i);

      Lo := i-1;
    end;
  end
  else
  begin
    LnS := 0;
    LnE := 0;
  end;

  for i := lo+1 to FMarksCount - 1 do
  begin
    Inc(FMarks[i].Mark.FPos, ACount);

    if FLineBound then
      with FMarks[i].Mark do
        if FLine <> -1 then
          Inc(FLine, LnE-LnS);
  end;
end;

{------------------------------------------------------------------------------}

function TMarkCollection.GetMarksByLinesLow(AStartLine,
  ACount: Integer): TMarkRange;
var
  ostart, oend, lo, up: Integer;
begin
  CheckNotDisposed;
  CheckLineRange(AStartLine, ACount);

  ostart := Doc.LineSegments[AStartLine].Start;
  oend := LMDSegEnd(Doc.LineSegments[AStartLine+ACount-1])+1;

  GetPosRangeBySegment(ostart, oend-ostart+1, lo, up);

  Result.Start := lo+1;
  Result.Count := up-Result.Start;
end;

{------------------------------------------------------------------------------}

function TMarkCollection.GetMarksByLines(AStartLine,
                                         ACount: Integer): TLMDMarkArray;
var
  i: Integer; range: TMarkRange;
begin
  CheckNotDisposed;
  CheckLineRange(AStartLine, ACount);

  range := GetMarksByLinesLow(AStartLine, ACount);

  SetLength(Result, range.Count);

  for i:=0 to range.Count-1 do
    Result[i] := FMarks[i + range.Start].Mark;
end;

{------------------------------------------------------------------------------}

function TMarkCollection.GetMarksCountByLines(AStartLine,
  ACount: Integer): Integer;
begin
  CheckNotDisposed;
  CheckLineRange(AStartLine, ACount);

  Result := GetMarksByLinesLow(AStartLine, ACount).Count;
end;

{------------------------------------------------------------------------------}

function TMarkCollection.LineMarks(AIndex: Integer): ILMDMark;
begin
  CheckNotDisposed;
  Result := FMarks[AIndex].Mark;
end;

{------------------------------------------------------------------------------}

function TMarkCollection.CreateMarkAtLine(ALine: Integer): ILMDMark;
var
  Pos: Integer;
begin
  CheckNotDisposed;
  CheckLineIdx(ALine);

  DoBeforeChange;
  try
    Pos := Doc.LineSegments[ALine].Start;
    Result := CreateMark(Pos);
  finally
    DoAfterChange;
  end;
end;

function TMarkCollection.CreateMarkAtOffset(AOffset: Integer): ILMDLineMark;
begin
  Result := CreateMark(AOffset);
end;

{------------------------------------------------------------------------------}

function  TMarkCollection.FindMarkByName(const AName: TLMDString): ILMDMark;
var i: Integer;
begin
  result := nil;

  for i:=0 to get_Count-1 do
    if FMarks[i].Mark.get_Name=AName then
    begin
      result := FMarks[i].Mark;
      Exit;
    end;
end;

{------------------------------------------------------------------------------}

function TMarkCollection.GetLastLineMark(ALine: Integer): ILMDLineMark;
var
  range: TMarkRange;
begin
  range := GetMarksByLinesLow(ALine, 1);

  if range.Count > 0 then
    Result := FMarks[range.Start + range.Count - 1].Mark
  else
    Result := nil;
end;

{******************************* TMarkManager *********************************}
{------------------------------------------------------------------------------}

procedure TMarkManager.ContentDeleting(AStart, ACount: Integer);
var
  i: Integer;
begin
  for i := 0 to MarksCount - 1 do
    GetMarks(i).ContentDeleting(AStart, ACount);
end;

{------------------------------------------------------------------------------}

procedure TMarkManager.ContentInserted(AStart, ACount: Integer);
var
  i: Integer;
begin
  for i := 0 to MarksCount - 1 do
    GetMarks(i).ContentInserted(AStart, ACount)
end;

{------------------------------------------------------------------------------}

constructor TMarkManager.Create(ADoc: TLMDEditDocument);
begin
  inherited Create;

  FMarks := TList.Create;
  FIMarks := TInterfaceList.Create;
  FDoc := ADoc;
end;

{------------------------------------------------------------------------------}

function TMarkManager.CreateMarks(ALineBound, AKeepMarks, AProduceEvents: Boolean): ILMDMarkers;
var
  Coll: TMarkCollection;
  Itf: IInterface;
begin
  coll := TMarkCollection.Create(Self, ALineBound, AKeepMarks, AProduceEvents);
  FMarks.Add(coll);

  Itf := coll as IInterface;
  FIMarks.Add(Itf);

  Result := Itf as ILMDMarkers;
end;

{------------------------------------------------------------------------------}

function TMarkManager.HasMarks(AMarks: IInterface): Boolean;
begin
  Result := FIMarks.IndexOf(AMarks) <> -1;
end;

{------------------------------------------------------------------------------}

procedure TMarkManager.ReleaseMarks(AMarks: IInterface);
var
  i: Integer;
begin
  i := FIMarks.IndexOf(AMarks);

  GetMarks(i).Dispose(True);

  FMarks.Delete(i);
  FIMarks.Delete(i);
end;

{------------------------------------------------------------------------------}

procedure TMarkManager.ClearAllMarks;
var
  i: Integer;
begin
  for i := 0 to MarksCount - 1 do
    GetMarks(i).Dispose(True);

  FIMarks.Clear;
  FMarks.Clear;
end;

{------------------------------------------------------------------------------}

procedure TMarkManager.SetDocument(ADoc: TLMDEditDocument);
begin
  ClearAllMarks;
  FDoc := ADoc;
end;

{------------------------------------------------------------------------------}

function TMarkManager.GetMarks(AIdx: Integer): TMarkCollection;
begin
  Assert((AIdx >=0) and (AIdx < FMarks.Count));

  Result := TMarkCollection(FMarks[AIdx]);
end;

{------------------------------------------------------------------------------}

function TMarkManager.MarksCount: Integer;
begin
  Result := FMarks.Count;
end;

{------------------------------------------------------------------------------}

destructor TMarkManager.Destroy;
begin
  FIMarks.Clear;
  FMarks.Clear;

  FMarks.Free;
  FIMarks.Free;
  FDoc := nil;

  inherited;
end;

{********************************* TGapStorage ********************************}
{------------------------------------------------------------------------------}

constructor TGapStorage.Create(AGapSize: Integer);
begin
  inherited Create(512);
  FGapSize := AGapSize;
  Init;
end;

destructor TGapStorage.Destroy;
begin
  inherited;

  SetLength(FArr, 0);
  FArr := nil;
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.FillBuffer(ABufferStart, ABufferEnd: Integer);
var
  GapCnt, Cnt: Integer;
begin
  Cnt := ABufferEnd - ABufferStart;
  GapCnt := FGapEnd - FGapStart;

  if FGapStart >= ABufferEnd then
    LMDCharArrayCopy(FArr, ABufferStart, FBuffer, 0, Cnt)
  else if ABufferStart >= FGapStart then
    LMDCharArrayCopy(FArr, ABufferStart + GapCnt, FBuffer, 0, Cnt)
  else
  begin
    Cnt := FGapStart - ABufferStart;
    LMDCharArrayCopy(FArr, ABufferStart, FBuffer, 0, Cnt);
    LMDCharArrayCopy(FArr, FGapEnd, FBuffer, Cnt, ABufferEnd-FGapStart);
  end;
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.EnsureCapacity(ACap: Integer);
begin
  if (ACap >= Length(FArr)) or ((Length(FArr) div (ACap + 1)) > 4) then
    SetLength(FArr, (ACap * 3) div 2);
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.CheckIdx(AIdx: Integer);

  procedure RaiseInvalidIdx;
  begin
    raise ELMDEditDocError.CreateFmt(SLMDSedDocInvalidCharIndex, [0, FCount-1]);
  end;

begin
  if not LMDInRange(AIdx, 0, FCount-1) then
    RaiseInvalidIdx;
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.CheckSegValid(const ASeg: TLMDSegment);
  procedure RaiseInvalidSeg;
  begin
    raise ELMDEditDocError.Create(SLMDSedDocInvalidSegment);
  end;
begin
  if not LMDSegIsValid(ASeg) then
    RaiseInvalidSeg;
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.CheckInsIdx(AIdx: Integer);
  procedure RaiseInvalidInsIdx;
  begin
    raise ELMDEditDocError.CreateFmt(SLMDSedDocInvalidCharInsIndex, [AIdx, 0, FCount]);
  end;
begin
  if not LMDInRange(AIdx, 0, FCount) then
    RaiseInvalidInsIdx;
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.CheckRange(AIdx, ACount: Integer);

  procedure RaiseRange;
  begin
    raise ELMDEditDocError.CreateFmt(SLMDSedInvalidRangeOrder, [AIdx, AIdx+ACount]);
  end;

begin
  if ACount<0 then
    RaiseRange;

  CheckIdx(AIdx);
  CheckIdx(AIdx+ACount-1);
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.Init;
begin
  SetLength(FArr, 0);
  FCount := 0;
  FGapStart := 0;
  FGapEnd := 0;
  ResetBuffer;
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.Insert(AIdx: Integer; const ASeg: TLMDSegment);
begin
  CheckInsIdx(AIdx);
  CheckSegValid(ASeg);

  MoveGapStart(AIdx);

  if (FGapEnd - FGapStart) < ASeg.Count then
  begin
    EnsureCapacity(FCount + ASeg.Count + FGapSize);
    MoveGapEnd(AIdx + ASeg.Count + FGapSize);
  end;

  LMDSegCopyToArray(ASeg, FArr, AIdx);
  Inc(FGapStart, ASeg.Count);
  Inc(FCount, ASeg.Count);

  ResetBuffer;
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.MoveGapEnd(AEnd: Integer);
var
  Cnt: Integer;
begin
  // Jedit : FCount - FGapStart (such shorthand...).
  Cnt := FCount + (FGapEnd - FGapStart) - FGapEnd;
  if Cnt > 0 then
    LMDCharArrayCopy(FArr, FGapEnd, FArr, AEnd, Cnt);
  FGapEnd := AEnd;
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.MoveGapStart(AStart: Integer);
var
  LNewEnd: Integer;
begin
  LNewEnd := FGapEnd + (AStart - FGapStart);
  if AStart > FGapStart then
    LMDCharArrayCopy(FArr, FGapEnd, FArr, FGapStart, AStart - FGapStart)
  else if AStart < FGapStart  then
    LMDCharArrayCopy(FArr, AStart, FArr, LNewEnd, FGapStart - AStart);

  FGapStart := AStart;
  FGapEnd := LNewEnd;
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.Delete(AIdx, ACount: Integer);
begin
  CheckRange(AIdx, ACount);

  if ACount = 0 then
    Exit;

  MoveGapStart(AIdx);
  Inc(FGapEnd, ACount);
  Dec(FCount, ACount);

  AdjustGap;
  ResetBuffer;
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.SetText(const ASeg: TLMDSegment);
begin
  Init;
  CheckSegValid(ASeg);
  Insert(0, ASeg);
end;

{------------------------------------------------------------------------------}

procedure TGapStorage.AdjustGap;
var
  FullCnt, Sz: Integer;
begin
  Sz := FGapEnd - FGapStart;

  if (Sz > FGapSize) and ((Sz shr 5) > FCount) then
  begin
    FullCnt := FCount + Sz;
    Sz := FullCnt - FGapEnd;
    if Sz > 0 then
      LMDCharArrayCopy(FArr, FGapEnd, FArr, FGapStart + FGapSize, Sz);

    FGapEnd := FGapStart + FGapSize;
    SetLength(FArr, FGapEnd + Sz);

    ResetBuffer;
  end;
end;

{********************************* TUndoAction ********************************}
{------------------------------------------------------------------------------}

constructor TUndoAction.Create(AParent: TUndoManager;
  AAuthorID: Integer; AOldInfo: TLMDDocUndoInfo);
begin
  inherited Create;

  Parent := AParent;
  AuthorID := AAuthorID;
  Info := AOldInfo;
  IsAuthorsCommon := True;
  Prev := nil;
  CanMerge := true;
end;

{------------------------------------------------------------------------------}

destructor TUndoAction.Destroy;
begin
  if Info<>nil then
    Info.Free;

  inherited;
end;

{------------------------------------------------------------------------------}

function TUndoAction.CloneInfo: TLMDDocUndoInfo;
begin
  if Info<>nil then
    Result := Info.Clone
  else
    Result := nil;
end;

{******************************* TDummyAction *********************************}
{------------------------------------------------------------------------------}

function TDummyAction.Exec: TUndoAction;
begin
  Result := Self;
end;

{------------------------------------------------------------------------------}

function TDummyAction.Merge(ANewAction: TUndoAction): Boolean;
begin
  Result := (Info<>nil) and
            (ANewAction.Info<>nil) and
            Info.Merge(ANewAction.Info);

  if Result then
    ANewAction.Free;
end;

{------------------------------------------------------------------------------}

constructor TDummyAction.Create(AParent: TUndoManager;
  AAuthorID: Integer; AOldInfo: TLMDDocUndoInfo);
begin
  inherited Create(AParent, AAuthorID, AOldInfo);
  IsAuthorsCommon := False;
end;

{******************************* TDeleteAction ********************************}
{------------------------------------------------------------------------------}

function TDeleteAction.Exec: TUndoAction;
begin
  Result := TInsertAction.Create(Start, Count, Parent, AuthorID, CloneInfo);
  Result.CanMerge := CanMerge;

  Parent.Doc.Delete(Start, Count);
end;

{------------------------------------------------------------------------------}

function TDeleteAction.Merge(ANewAction: TUndoAction): Boolean;
var
  Act: TDeleteAction;
begin
  Result := CanMerge and (ANewAction is TDeleteAction);
  if Result then
  begin
    Act := TDeleteAction(ANewAction);

    Result := (Act.AuthorID=AuthorID) and (Start+Count = Act.Start);
    if Result then
    begin
      Inc(Count, Act.Count);
      ANewAction.Free;
    end;
  end;
end;

{------------------------------------------------------------------------------}

constructor TDeleteAction.Create(AStart, ACount: Integer;
  AParent: TUndoManager; AAuthorID: Integer; AOldInfo: TLMDDocUndoInfo);
begin
  inherited Create(AParent, AAuthorID, AOldInfo);

  Start := AStart;
  Count := ACount;
end;

{****************************** TInsertAction *********************************}
{------------------------------------------------------------------------------}

procedure TInsertAction.Append(AStart, ACount: Integer);
begin
  Assert(Store.Count<>0);
  Store.Insert(Count, LMDSegment(AStart, ACount, Parent.Doc.Chars));
end;

{------------------------------------------------------------------------------}

procedure TInsertAction.Prepend(AStart, ACount: Integer);
begin
  Assert(Store.Count<>0);
  Store.Insert(0, LMDSegment(AStart, ACount, Parent.Doc.Chars));
end;

{------------------------------------------------------------------------------}

function TInsertAction.Exec: TUndoAction;
begin
  Assert(Count=Store.Count);
  Parent.Doc.InsertSeg(Start, LMDSegment(0, Count, Store));

  Result := TDeleteAction.Create(Start, Count, Parent, AuthorID, CloneInfo);
  Result.CanMerge := CanMerge;
end;

{------------------------------------------------------------------------------}

function TInsertAction.Merge(ANewAction: TUndoAction): Boolean;
var
  Act: TInsertAction;
begin
  Result := CanMerge and (ANewAction is TInsertAction);
  if Result then
  begin
    Act := TInsertAction(ANewAction);

    Result := Act.AuthorID=AuthorID;
    if Result then
    begin
      if Start = (Act.Start+Act.Count) then // Delete backward.
        Prepend(Act.Start, Act.Count)
      else if Start = Act.Start then // Delete forward.
        Append(Act.Start, Act.Count)
      else
        Result := False;

      if Result then
      begin
        Start := Act.Start;
        Inc(Count, Act.Count);
        ANewAction.Free;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

constructor TInsertAction.Create(AStart, ACount: Integer;
  AParent: TUndoManager; AAuthorID: Integer; AOldInfo: TLMDDocUndoInfo);
begin
  inherited Create(AParent, AAuthorID, AOldInfo);

  Start := AStart;
  Count := ACount;
  Store := TGapStorage.Create(10);
  Store.Insert(0, LMDSegment(Start, Count, Parent.Doc.Chars));
end;

{------------------------------------------------------------------------------}

destructor TInsertAction.Destroy;
begin
  FreeAndNil(Store);

  inherited;
end;

{****************************** TCompoundAction *******************************}
{------------------------------------------------------------------------------}

constructor TCompoundAction.Create(AParent: TUndoManager;
  AAuthorID: Integer; AOldInfo: TLMDDocUndoInfo);
begin
  inherited Create(AParent, AAuthorID, AOldInfo);
  FActList := TUndoActionList.Create;
end;

{------------------------------------------------------------------------------}

destructor TCompoundAction.Destroy;
begin
  FActList.Free;

  inherited;
end;

{------------------------------------------------------------------------------}

function TCompoundAction.Exec: TUndoAction;
var
  act, newAct: TUndoAction;
begin
  Assert(FActList.RedoCount=0);

  Parent.Doc.BeginCompoundEdit;
  try
    while FActList.UndoCount>0 do
    begin
      act := FActList.PopUndo;
      newAct := act.Exec;
      if act<>newAct then
        act.Free;

      FActList.PushRedo(newAct);
    end;
  finally
    Parent.Doc.EndCompoundEdit;
  end;

  FActList.SwapUndoRedo; // Inverse self.
  Result := Self;
end;

{------------------------------------------------------------------------------}

function TCompoundAction.Merge(ANewAction: TUndoAction): Boolean;
var
  Merged: Boolean;
begin
  Result := Parent.InsideCompoundAction and (not (ANewAction is TCompoundAction)) ;

  if Result then
  begin
    Result := ((ANewAction is TDeleteAction) or
               (ANewAction is TInsertAction))
              and
              (ANewAction.AuthorID=-1)
              and
              (ANewAction.Info=nil);

    Assert(Result);

    Assert(FActList.RedoCount=0);

    Merged := (FActList.UndoCount>0) and
              (FActList.TopUndo.Merge(ANewAction));

    if not Merged then
      FActList.PushUndo(ANewAction);
  end;
end;

{------------------------------------------------------------------------------}

function ProcessAction(var Act: TUndoAction; ANewInfo: TLMDDocUndoInfo;
  var OldInfo: TLMDDocUndoInfo; AAuthorID: Integer): Boolean;
var
  newAct: TUndoAction;
begin
  Result := Act.IsAuthorsCommon or (Act.AuthorID=AAuthorID);
  if Result then
  begin
    if Act.AuthorID=AAuthorID then
      OldInfo := Act.CloneInfo
    else
      OldInfo := nil;
  end;

  newAct := Act.Exec;

  if Act<>newAct then
    Act.Free;

  if newAct.AuthorID=AAuthorID then
  begin
    newAct.Info.Free;
    newAct.Info := ANewInfo;
  end
  else if ANewInfo<>nil then
    ANewInfo.Free;

  Act := newAct;
end;

{******************************** TUndoManager ********************************}
{------------------------------------------------------------------------------}

function TUndoManager.HaveLimit: Boolean;
begin
  Result := FActList.UndoCount < FLimit;
end;

procedure TUndoManager.Undo(AAuthorID: Integer;  ANewInfo: TLMDDocUndoInfo;
                            var OldInfo: TLMDDocUndoInfo);
var
  Act: TUndoAction; Stop: Boolean;
begin
  Assert(CanUndo(AAuthorID));

  Stop := False;
  while not Stop do
  begin
    Act := FActList.PopUndo;

    Stop := ProcessAction(Act, ANewInfo, OldInfo, AAuthorID);

    FActList.PushRedo(Act);
  end;
end;

{------------------------------------------------------------------------------}

function TUndoManager.UndoCount: Integer;
begin
  Result := FActList.UndoCount;
end;

{------------------------------------------------------------------------------}

procedure TUndoManager.Redo(AAuthorID: Integer;
  ANewInfo: TLMDDocUndoInfo; var OldInfo: TLMDDocUndoInfo);
var
  Act: TUndoAction; Stop: Boolean;
begin
  Assert(CanRedo(AAuthorID));

  Stop := False;
  while not Stop do
  begin
    Act := FActList.PopRedo;

    Stop := ProcessAction(Act, ANewInfo, OldInfo, AAuthorID);

    FActList.PushUndo(Act);
  end;
end;

{------------------------------------------------------------------------------}

function FindActionForAuthor(Act: TUndoAction; AAuthorID: Integer): TUndoAction;
begin
  while (Act<>nil) and (Act.AuthorID<>AAuthorID) and (not Act.IsAuthorsCommon)
  do
    Act := Act.Prev;

  Result := Act;
end;

{------------------------------------------------------------------------------}

function TUndoManager.CanRedo(AAuthorID: Integer): Boolean;
begin
  if InsideCompoundAction then
    Result := false
  else
    Result := FindActionForAuthor(FActList.TopRedo, AAuthorID)<>nil;
end;

{------------------------------------------------------------------------------}

function TUndoManager.CanUndo(AAuthorID: Integer): Boolean;
begin
  if InsideCompoundAction then
    Result := false
  else
    Result := FindActionForAuthor(FActList.TopUndo, AAuthorID) <> nil;
end;

{------------------------------------------------------------------------------}

procedure TUndoManager.PushAction(Act: TUndoAction);
var
  Merged: Boolean;
begin
  FActList.CutRedo;

  Merged := (FActList.UndoCount > 0) and
            (FActList.TopUndo.Merge(Act));

  if not Merged then
  begin
    FActList.PushUndo(Act);

    if FActList.UndoCount > FLimit then
      FActList.DeleteFirstUndo;
  end;
end;

{------------------------------------------------------------------------------}

procedure TUndoManager.ContentInserted(AStart, ACount, AAuthorID: Integer;
  AOldInfo: TLMDDocUndoInfo);
begin
  if HaveLimit then
    PushAction(TDeleteAction.Create(AStart, ACount, Self, AAuthorID, AOldInfo));
end;

{------------------------------------------------------------------------------}

procedure TUndoManager.ContentDeleting(AStart, ACount, AAuthorID: Integer;
  AOldInfo: TLMDDocUndoInfo);
begin
  if HaveLimit then
    PushAction(TInsertAction.Create(AStart, ACount, Self, AAuthorID, AOldInfo));
end;

{------------------------------------------------------------------------------}

procedure TUndoManager.PushCustomAction(AAuthorID: Integer;
  AOldInfo: TLMDDocUndoInfo);
begin
  if HaveLimit then
    PushAction(TDummyAction.Create(Self, AAuthorID, AOldInfo));
end;

{------------------------------------------------------------------------------}

procedure TUndoManager.BeginCompoundAction(AAuthorID: Integer;
  AOldInfo: TLMDDocUndoInfo);
begin
  Assert(not FCompoundEdit);

  FCompoundEdit := True;

  if HaveLimit then
    PushAction(TCompoundAction.Create(Self, AAuthorID, AOldInfo));
end;

{------------------------------------------------------------------------------}

procedure TUndoManager.EndCompoundAction;
begin
  Assert(FCompoundEdit);
  FCompoundEdit := False;
end;

{------------------------------------------------------------------------------}

function TUndoManager.InsideCompoundAction: Boolean;
begin
  Result := FCompoundEdit;
end;

{------------------------------------------------------------------------------}

procedure TUndoManager.Clear;
begin
  Assert(not FCompoundEdit);

  FActList.Free;
  FActList := TUndoActionList.Create;
end;

{------------------------------------------------------------------------------}

constructor TUndoManager.Create(ADoc: TLMDEditDocument; ALimit: Integer);
begin
  inherited Create;
  FLimit := ALimit;

  Doc := ADoc;
  FActList := TUndoActionList.Create;
end;

{------------------------------------------------------------------------------}

destructor TUndoManager.Destroy;
begin
  FActList.Free;

  inherited;
end;

{------------------------------------------------------------------------------}

procedure TUndoManager.SetLimit(ALimit: Integer);
begin
  if FActList.UndoCount + FActList.RedoCount > ALimit then
  begin
    FActList.CutRedo;

    while FActList.UndoCount>ALimit do
      FActList.DeleteFirstUndo;
  end;

  FLimit := ALimit;
end;

{------------------------------------------------------------------------------}

procedure TUndoManager.SetTopUndoCantMerge;
begin
  if FActList.UndoCount > 0 then
    FActList.TopUndo.CanMerge := false;
end;

{******************************* TUndoActionList ******************************}
{------------------------------------------------------------------------------}

procedure TUndoActionList.PushUndo(Act: TUndoAction);
begin
  Act.Prev := FLastUndo;

  FLastUndo := Act;
  Inc(UndoCount);
end;

{------------------------------------------------------------------------------}

procedure TUndoActionList.PushRedo(Act: TUndoAction);
begin
  Act.Prev := FLastRedo;

  FLastRedo := Act;
  Inc(RedoCount);
end;

{------------------------------------------------------------------------------}

function TUndoActionList.PopUndo: TUndoAction;
begin
  Assert(FLastUndo<>nil);
  Assert(UndoCount>0);

  Result := FLastUndo;
  FLastUndo := FLastUndo.Prev;
  Dec(UndoCount);
end;

{------------------------------------------------------------------------------}

function TUndoActionList.PopRedo: TUndoAction;
begin
  Assert(FLastRedo<>nil);
  Assert(RedoCount>0);

  Result := FLastRedo;
  FLastRedo := FLastRedo.Prev;
  Dec(RedoCount);
end;

{------------------------------------------------------------------------------}

function TUndoActionList.TopUndo: TUndoAction;
begin
  Result := FLastUndo;
end;

{------------------------------------------------------------------------------}

function TUndoActionList.TopRedo: TUndoAction;
begin
  Result := FLastRedo;
end;

{------------------------------------------------------------------------------}

procedure TUndoActionList.CutRedo;
begin
  while TopRedo<>nil do
    PopRedo.Free;
end;

{------------------------------------------------------------------------------}

procedure TUndoActionList.DeleteFirstUndo;
var
  Act, Next: TUndoAction;
begin
  Act := FLastUndo;

  Next := nil;
  while Act.Prev<>nil do
  begin
    Next := Act;

    Act := Act.Prev;
  end;

  if Act=FLastUndo then
    FLastUndo := nil;

  if Next<>nil then
    Next.Prev := nil;

  Act.Free;
  Dec(UndoCount);
end;

{------------------------------------------------------------------------------}

procedure TUndoActionList.SwapUndoRedo;
var
  tmp: TUndoAction; tmpC: Integer;
begin
  tmp := FLastUndo;
  FLastUndo := FLastRedo;
  FLastRedo := tmp;

  tmpC := UndoCount;
  UndoCount := RedoCount;
  RedoCount := tmpC;
end;

{------------------------------------------------------------------------------}

constructor TUndoActionList.Create;
begin
  inherited;

  FLastRedo := nil;
  FLastUndo := nil;
  UndoCount := 0;
  RedoCount := 0;
end;

{------------------------------------------------------------------------------}

destructor TUndoActionList.Destroy;
begin
  while TopRedo<>nil do
    PopRedo.Free;

  while TopUndo<>nil do
    PopUndo.Free;

  inherited;
end;

{******************************* TLMDDocUndoInfo ******************************}
{------------------------------------------------------------------------------}

function TLMDDocUndoInfo.Merge(ANewInfo: TLMDDocUndoInfo): Boolean;
begin
  Result := False;
end;

{**************************** TLMDDocumentInternal ****************************}
{------------------------------------------------------------------------------}

function TLMDDocumentInternal.GetCanRedo(AAuthorID: Integer): Boolean;
begin
  Result := FDoc.GetCanRedo(AAuthorID);
end;

{------------------------------------------------------------------------------}

function TLMDDocumentInternal.GetCanUndo(AAuthorID: Integer): Boolean;
begin
  Result := FDoc.GetCanUndo(AAuthorID);
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentInternal.Undo(AAuthorID: Integer;
  ANewInfo: TLMDDocUndoInfo; var OldInfo: TLMDDocUndoInfo);
begin
  FDoc.UndoLow(AAuthorID, ANewInfo, OldInfo);
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentInternal.Redo(AAuthorID: Integer;
  ANewInfo: TLMDDocUndoInfo; var OldInfo: TLMDDocUndoInfo);
begin
  FDoc.RedoLow(AAuthorID, ANewInfo, OldInfo);
end;

procedure TLMDDocumentInternal.RemoveListener(const ALst: TLMDDocumentListener);
begin
  FDoc.RemoveInternalListener(ALst);
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentInternal.InsertSeg(AIdx: Integer; ASeg: TLMDSegment;
                                         AAuthorID: Integer;
                                         AOldInfo: TLMDDocUndoInfo;
                                         ADoFreeSeg: Boolean);
begin
  FDoc.InsertSegLow(AIdx, ASeg, AAuthorID, AOldInfo, ADoFreeSeg);
end;

procedure TLMDDocumentInternal.InsertStr(AIdx: Integer; const AStr: TLMDString;
                                         AAuthorID: Integer;
                                         AOldInfo: TLMDDocUndoInfo);
begin
  FDoc.InsertStrLow(AIdx, AStr, AAuthorID, AOldInfo);
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentInternal.Delete(AStart, ACount, AAuthorID: Integer;
  AOldInfo: TLMDDocUndoInfo);
begin
  FDoc.DeleteLow(AStart, ACount, AAuthorID, AOldInfo);
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentInternal.ReplaceSeg(AStart, ACount: Integer;
                                          const ASeg: TLMDSegment;
                                          AAuthorID: Integer;
                                          AOldInfo: TLMDDocUndoInfo);
begin
  FDoc.ReplaceSegLow(AStart, ACount, ASeg, AAuthorID, AOldInfo);
end;

procedure TLMDDocumentInternal.ReplaceStr(AStart, ACount: Integer;
                                          const AStr: TLMDString;
                                          AAuthorID: Integer;
                                          AOldInfo: TLMDDocUndoInfo);
begin
  FDoc.ReplaceStrLow(AStart, ACount, AStr, AAuthorID, AOldInfo);
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentInternal.PushCustomAction(AAuthorID: Integer;
  AOldInfo: TLMDDocUndoInfo);
begin
  FDoc.PushCustomAction(AAuthorID, AOldInfo);
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentInternal.AddListener(const ALst: TLMDDocumentListener);
begin
  FDoc.AddInternalListener(ALst);
end;

procedure TLMDDocumentInternal.BeginCompoundAction(AAuthorID: Integer;
                                                   AOldInfo: TLMDDocUndoInfo;
                                                   AFreezeViews: Boolean);
begin
  FDoc.BeginCompoundAction(AAuthorID, AOldInfo, AFreezeViews);
end;

{------------------------------------------------------------------------------}

constructor TLMDDocumentInternal.Create(ADoc: TLMDEditDocument);
begin
  inherited Create;
  FDoc := ADoc;
end;

{------------------------------------------------------------------------------}

function TLMDDocumentInternal.GetNextAuthorID: Integer;
begin
  Result := FDoc.GetNextAuthorID;
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentInternal.LockMarkers;
begin
  FDoc.LockMarkers;
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentInternal.LockChanges;
begin
  FDoc.LockChanges;
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentInternal.UnlockMarkers;
begin
  FDoc.UnlockMarkers;
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentInternal.UnlockChanges;
begin
  FDoc.UnlockChanges;
end;

{********************************* TLineManager *******************************}
{------------------------------------------------------------------------------}

function TLineManager.Count: integer;
begin
  Result := FCount;
end;

{------------------------------------------------------------------------------}

function  TLineManager.GetLineStart(AIdx: Integer): Integer;
var
  En, SepLn: Integer;
begin
  if (AIdx < 0) or (AIdx >= FCount) then
    FDoc.CheckLineIdx(AIdx);

  if AIdx = 0 then
    Result := 0
  else
  begin
    En := FEnds[AIdx-1];
    Result := En and LineStartMask;
    SepLn := ((En and LineSepLnMask) shr LineSepShift) + 1;

    Inc(Result, SepLn);
  end;
end;

{------------------------------------------------------------------------------}

function TLineManager.GetAt(AIdx: Integer): TLMDSegment;
var
  En, SepLn: Integer;
begin
  if (AIdx < 0) or (AIdx >= FCount) then
    FDoc.CheckLineIdx(AIdx);

  Result.Source := FDoc.Chars;

  if AIdx = 0 then
  begin
    Result.Start := 0;
    Result.Count := FEnds[AIdx] and LineStartMask;
  end
  else
  begin
    En := FEnds[AIdx - 1];
    SepLn := ((En and LineSepLnMask) shr LineSepShift) + 1;

    Result.Start := (En and LineStartMask) + SepLn;
    Result.Count := (FEnds[AIdx] and LineStartMask) - Result.Start;
  end;
end;

{------------------------------------------------------------------------------}

constructor TLineManager.Create(ADoc: TLMDEditDocument);
begin
  inherited Create;
  FDoc := ADoc;

  Refresh;
end;

{------------------------------------------------------------------------------}

procedure TLineManager.Refresh;
begin
  FChars := FDoc.Chars;

  FCount := 1;
  SetLength(FEnds, 1);
  FEnds[0] := 0;

  ContentInserted(0, FDoc.CharsCount);
end;

{------------------------------------------------------------------------------}

function TLineManager.ContentDeleting(AStart, ALength: Integer): TLineManResult;
var
  LineS, LineE, L, E, AEnd, DelCount: Integer;
begin
  LineS := 0;
  Result.FirstChangedLine := LineS;
  Result.ChangedLinesCount := 0;

  if ALength=0 then
    Exit;

  AEnd := AStart + ALength;

  LineS := GetLineByOffset(AStart);
  LineE := GetLineByOffset(AEnd);

  DelCount := LineE-LineS;

  Assert(LineE<>FCount);

  if DelCount>0 then
    LMDIntArrayCopy(FEnds, LineE, FEnds, LineS, FCount-LineE);

  Dec(FCount, DelCount);
  CheckCapacity(FCount);

  for L := LineS to FCount - 1 do
  begin
    E := FEnds[L];
    FEnds[L] := ((E and LineStartMask) - ALength) or (E and LineSepLnMask);
  end;

  Result.FirstChangedLine := LineS;
  Result.ChangedLinesCount := DelCount + 1;
end;

{------------------------------------------------------------------------------}

procedure TLineManager.CheckCapacity(ANewCount: Integer);
var
  NewLn: Integer;
begin
  NewLn := GetNewArrLength(ANewCount, Length(FEnds));
  if NewLn <> -1 then
    SetLength(FEnds, NewLn);
end;

{------------------------------------------------------------------------------}

function TLineManager.ContentInserted(AStart, ALength: Integer): TLineManResult;
var
  S, Start, AEnd,
  InsLine, L, InsCount,
  FirstCR, FirstCRLn, CrLn: Integer;
  c: TLMDChar;  CrLF: Boolean;
begin
  InsLine := GetLineByOffset(AStart);

  Result.FirstChangedLine := InsLine;
  Result.ChangedLinesCount := 0;

  if ALength=0 then
    Exit;

  AEnd := AStart + ALength;

  FirstCR := -1;
  FirstCRLn := -1;
  Start := AStart;
  InsCount := 0;

  if (Start>0) and
     (FChars[Start]=LMDLF) and
     (FChars[Start-1]=LMDCR)
  then
  begin
    Assert(FEnds[InsLine-1] and LineSepLnMask = 0);
    FEnds[InsLine-1] := FEnds[InsLine-1] or LineSepLnMask;
    Inc(Start);
  end;

  while Start < AEnd do
  begin
    c := FChars[Start];
    if (c=LMDCR) or (c=LMDLF) then
    begin
      CrLf := (c=LMDCR) and (Start+1<AEnd) and (FChars[Start+1]=LMDLF);
      if FirstCR=-1 then
      begin
        FirstCR := Start;
        if CrLf then
          FirstCRLn := 2
        else
          FirstCRLn := 1;
      end;

      if CrLf then
        Inc(Start);

      Inc(InsCount);
    end;

    Inc(Start);
  end;

  CheckCapacity(FCount+InsCount);

  if (InsLine < FCount) and (InsCount>0) then
    LMDIntArrayCopy(FEnds, InsLine, FEnds, InsLine+InsCount, FCount-InsLine);

  L := InsLine;
  if FirstCR<>-1 then
  begin
    Assert(InsCount>0);

    FEnds[InsLine] := FirstCR or ((FirstCRLn-1) shL LineSepShift);
    L := InsLine + 1;

    Start := FirstCR + FirstCRLn;
    while Start < AEnd do
    begin
      c := FChars[Start];
      if (c=LMDCR) or (c=LMDLF) then
      begin
        CrLf := (c=LMDCR) and (Start+1<AEnd) and (FChars[Start+1]=LMDLF);
        if CrLf then
          CrLn := 2
        else
          CrLn := 1;

        FEnds[L] := Start or ((CrLn-1) shL LineSepShift);

        if CrLf then
          Inc(Start);

        Inc(L);
      end;

      Inc(Start);
    end;
  end;

  Inc(FCount, InsCount);
  while L<FCount do
  begin
    S := FEnds[L];
    FEnds[L] := ((S and LineStartMask) + ALength) or
                (S and LineSepLnMask);
    Inc(L);
  end;

  Result.ChangedLinesCount := InsCount;
end;

{------------------------------------------------------------------------------}

function TLineManager.GetLineByOffset(AOffset: Integer): Integer;
var
  AStart, AEnd, Mid: Integer;
begin
  FDoc.CheckInsOffset(AOffset);

  AStart := 0;
  AEnd := FCount-1;

  while AStart < AEnd do
  begin
    Mid := (AStart + AEnd) div 2;

    if (FEnds[Mid] and LineStartMask) < AOffset then
      AStart := Mid + 1
    else
      AEnd := Mid;
  end;

  Result := AStart;
end;

{------------------------------------------------------------------------------}

function TLineManager.GetLineEndKind(ALine: Integer; out Res: TLMDLineSeparator): Boolean;
var
    En, ChIdx, SepLn: Integer;
    Ch: TLMDChar;
begin
  if (ALine < 0) or (ALine >= FCount)  then
    FDoc.CheckLineIdx(ALine);

  Result := ALine < FCount - 1;

  if Result then
  begin
    En := FEnds[ALine];
    SepLn := ((En and LineSepLnMask) shr LineSepShift) + 1;

    if SepLn = 2 then
      Res := lsCRLF
    else
    begin
      ChIdx := En and LineStartMask;
      Ch := TLMDTextStorage(FDoc.FStorage).Chars[ChIdx];
      if Ch = LMDCr then
        Res := lsCR
      else
        Res := lsLF;
    end;
  end;
end;

{******************************* TLMDTextStorage ******************************}
{------------------------------------------------------------------------------}

constructor TLMDTextStorage.Create(ABufSize: Integer);
begin
  inherited Create(ABufSize);

  FListener := nil;
end;

{------------------------------------------------------------------------------}

destructor TLMDTextStorage.Destroy;
begin
  FListener := nil;
end;

{------------------------------------------------------------------------------}

procedure TLMDTextStorage.FireBeforeRefresh;
begin
  FListener.BeforeRefresh;
end;

{------------------------------------------------------------------------------}

procedure TLMDTextStorage.FireAfterRefresh;
begin
  FListener.AfterRefresh;
end;

{------------------------------------------------------------------------------}

procedure TLMDTextStorage.SetListener(ALst: TLMDTextStorageListener);
begin
  FListener := ALst;
end;

{************************* TDocumentStorageListener ***************************}
{------------------------------------------------------------------------------}

constructor TDocumentStorageListener.Create(ADoc: TLMDEditDocument);
begin
  inherited Create;
  FDoc := ADoc;
end;

{------------------------------------------------------------------------------}

procedure TDocumentStorageListener.BeforeRefresh;
begin
  FDoc.StorageBeforeRefresh;
end;

{------------------------------------------------------------------------------}

procedure TDocumentStorageListener.AfterRefresh;
begin
  FDoc.StorageAfterRefresh;
end;

{**************************** TDocumentStringsProxy ***************************}
{------------------------------------------------------------------------------}

constructor TDocumentStringsProxy.Create(AParent: TLMDEditDocument);
begin
  inherited Create;
  FParent := AParent;
end;

{------------------------------------------------------------------------------}

function  TDocumentStringsProxy.Get(Index: Integer): TLMDBaseString;
begin
  Result := FParent.GetLineStr(Index);
end;

{------------------------------------------------------------------------------}
function TDocumentStringsProxy.GetCount: Integer;
begin
  Result := FParent.LinesCount;
end;

{------------------------------------------------------------------------------}

procedure TDocumentStringsProxy.Assign(Source: TPersistent);
var
    OldLim: Integer;
begin
  FParent.CheckReadOnly;
  FParent.CheckNotUpdating;

  if Source=Self then
    Exit;

  FParent.BeginUpdate;
  try
    OldLim := FParent.UndoLimit;
    try
      FParent.SetUndoLimit(0);
      inherited;
    finally
      FParent.SetUndoLimit(OldLim);
    end;

    FParent.ResetModified;
  finally
    FParent.EndUpdate(true);
  end;
end;

{------------------------------------------------------------------------------}

procedure TDocumentStringsProxy.Clear;
begin
  FParent.CheckReadOnly;
  FParent.CheckChangesLock;

  FParent.Clear;
end;

{------------------------------------------------------------------------------}

procedure TDocumentStringsProxy.DefineProperties(Filer: TFiler);
var
    OldLim: Integer;
    InLoad: Boolean;
begin
  InLoad := (csLoading in FParent.ComponentState) or
            (csReading in FParent.ComponentState);
  OldLim := FParent.UndoLimit;
  try
    FParent.UndoLimit := 0;

    inherited;
  finally
    FParent.UndoLimit := OldLim;
  end;

  if InLoad then
  begin
    FParent.ResetModified;
    FParent.ResetChanges;
  end;
end;

{------------------------------------------------------------------------------}

procedure TDocumentStringsProxy.Delete(Index: Integer);
begin
  FParent.CheckReadOnly;
  FParent.CheckChangesLock;

  FParent.DeleteLine(Index);
end;

{------------------------------------------------------------------------------}

procedure TDocumentStringsProxy.Insert(Index: Integer; const S: TLMDBaseString);
begin
  FParent.CheckReadOnly;
  FParent.CheckChangesLock;

  FParent.InsertLine(Index, S);
end;

{------------------------------------------------------------------------------}

procedure TDocumentStringsProxy.SaveToStream(Stream: TStream);
begin
  FParent.SaveToStream(Stream);
end;

{------------------------------------------------------------------------------}

procedure TDocumentStringsProxy.SetUpdateState(Updating: Boolean);
begin
  if Updating then
  begin
    FParent.CheckReadOnly;
    FParent.BeginCompoundEdit;
  end
  else
    FParent.EndCompoundEdit;
end;

{------------------------------------------------------------------------------}

procedure TDocumentStringsProxy.LoadFromFile(const FileName: TLMDBaseString);
begin
  FParent.LoadFromFile(FileName);
end;

{------------------------------------------------------------------------------}

procedure TDocumentStringsProxy.LoadFromStream(Stream: TStream);
begin
  FParent.LoadFromStream(Stream);
end;

{*********************** TLMDEditParserSchemeCollectionItem ***********************}
{------------------------------------------------------------------------------}

constructor TLMDEditParserSchemeStrings.Create(AParent: TLMDEditParserSchemeCollectionItem);
begin
  inherited Create;

  Assert(AParent<>nil);
  FParent := AParent;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserSchemeCollectionItem.SetScheme(AScheme: TLMDEditParserSchemeStrings);
begin
  if AScheme <> FScheme then
    FScheme.Assign(AScheme);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserSchemeCollectionItem.SetName(const AName: string);
begin
  if (FName <> AName) then
  begin
    TLMDEditParserSchemeCollection(Collection).CheckSetSchemeName(AName);

    FName := AName;
    Changed(False);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditParserSchemeCollectionItem.GetDisplayName: string;
begin
  if FName<>'' then
    Result := FName
  else
    Result := inherited GetDisplayName;
end;

{------------------------------------------------------------------------------}

constructor TLMDEditParserSchemeCollectionItem.Create(Collection: TCollection);
var
  i: Integer;
  Prefix, S: string;
  Coll: TLMDEditParserSchemeCollection;
begin
  inherited Create(Collection);

  FScheme := TLMDEditParserSchemeStrings.Create(self);

  FScheme.OnChange := SchemeChange;

  Coll := TLMDEditParserSchemeCollection(Collection);
  if Coll=Coll.FParent.ColorSchemes then
    Prefix := 'Color'
  else if Coll=Coll.FParent.SyntaxSchemes then
    Prefix := 'Syntax'
  else
    Assert(False);

  i := Index;
  S := Format('%sScheme%d', [Prefix, i]);
  while TLMDEditParserSchemeCollection(Collection).FindItem(S)<>nil do
  begin
    Inc(i);
    S := Format('%sScheme%d', [Prefix, i]);
  end;

  FName := S;
end;

{------------------------------------------------------------------------------}

destructor TLMDEditParserSchemeCollectionItem.Destroy;
begin
  FScheme.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserSchemeCollectionItem.Assign(Source: TPersistent);
var
  src: TLMDEditParserSchemeCollectionItem;
begin
  if Source is TLMDEditParserSchemeCollectionItem then
  begin
    src := TLMDEditParserSchemeCollectionItem(Source);

    if src.FScheme.Text<>FScheme.Text then
    begin
      FScheme.Assign(src.FScheme);
      FName := src.FName;

      Changed(False);
    end;
  end
  else
    inherited Assign(Source);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserSchemeCollectionItem.SchemeChange(Sender: TObject);
begin
  Changed(False);
end;

{************************** TLMDEditParserSchemeCollection ************************}
{------------------------------------------------------------------------------}

procedure TLMDEditParserSchemeCollection.CheckSetSchemeName(const AName: string);
begin
  if (AName='') or (FindItem(AName)<>nil) then
    raise ELMDEditDocError.Create(SLMDSedInvalidSchemeName);
end;

{------------------------------------------------------------------------------}

function TLMDEditParserSchemeCollection.GetItem(
  Index: Integer): TLMDEditParserSchemeCollectionItem;
begin
  Result := TLMDEditParserSchemeCollectionItem(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserSchemeCollection.SetItem(Index: Integer;
  Value: TLMDEditParserSchemeCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{------------------------------------------------------------------------------}

function TLMDEditParserSchemeCollection.FindItem(
  const AName: TLMDString): TLMDEditParserSchemeCollectionItem;
var
  i: Integer;
begin
  Result := nil;

  for i := 0 to Count - 1 do
    if Items[i].DisplayName=AName then
    begin
      Result := Items[i];

      Break;
    end;
end;

{------------------------------------------------------------------------------}

function TLMDEditParserSchemeCollection.GetOwner: TPersistent;
begin
  Result := Self.FParent;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserSchemeCollection.Update(Item: TCollectionItem);
begin
  if Item<>nil then
    FParent.SchemeChanged(TLMDEditParserSchemeCollectionItem(Item))
  else
    FParent.AllSchemesChanged;

  inherited Update(Item);
end;

{------------------------------------------------------------------------------}

constructor TLMDEditParserSchemeCollection.Create(AParent: TLMDEditDocument);
begin
  if (AParent=nil) or (not AParent.FInConstructor) then
    raise ELMDEditDocError.Create(SLMDSedDocInternalClassCreate);

  inherited Create(TLMDEditParserSchemeCollectionItem);
  FParent := AParent;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserSchemeCollection.LoadFromDirectory(ADir,
  AFileExt: string);
var
  sr:    TSearchRec;
  res:   Integer;
  path:  TLMDString;
  files: array of TLMDString;
begin
  SetLength(files, 0);
  res := FindFirst(IncludeTrailingBackslash(ADir) + '*.*',
                   faAnyFile, sr);
  try
    if res = 0 then
    repeat
      if (sr.Name <> '.') and (sr.Name <> '..') and
         ((faDirectory and sr.Attr) = 0) then
      begin
        path := LMDSlashAdd(ADir) + sr.Name;

        if LMDLowerCase(ExtractFileExt(path)) =
           LMDLowerCase('.' + AFileExt) then
        begin
          SetLength(files, Length(files) + 1);
          files[High(files)] := path;
        end;
      end;
    until FindNext(sr) <> 0;

    LoadFromFiles(files);
  finally
    SysUtils.FindClose(sr);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserSchemeCollection.LoadFromFiles(
  const AFiles: array of TLMDString);
var
  i, j: Integer;
  item: TLMDEditParserSchemeCollectionItem;
  nm:   TLMDString;
begin
  BeginUpdate;
  try
    Clear;

    for i := 0 to High(AFiles) do
      if FileExists(AFiles[i]) then
      begin
        nm := ChangeFileExt(ExtractFileName(AFiles[i]), '');

        for j := Length(nm) downto 1 do
          if (nm[j] = '.') and (j > 1) then
          begin
            nm := Copy(nm, 1, j - 1);
            Break;
          end;

        item := Add;
        try
          item.Name := nm;
          item.FScheme.LoadFromFile(AFiles[i]);
        except
          item.Free;
          raise;
        end;
      end;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditParserSchemeCollection.Add: TLMDEditParserSchemeCollectionItem;
begin
  Result := TLMDEditParserSchemeCollectionItem(inherited Add);
end;

{------------------------------------------------------------------------------}

function TLMDEditParserSchemeCollection.Insert(Index: Integer): TLMDEditParserSchemeCollectionItem;
begin
  Result := TLMDEditParserSchemeCollectionItem(inherited Insert(Index));
end;

{****************************** TLMDEditDocument ******************************}
{------------------------------------------------------------------------------}

constructor TLMDEditDocument.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FInConstructor := true;

  FReadOnly := false;
  FLineSeparator := lsCRLF;
  FLineSeparatorStr := LMDCRLF;

  FLastAuthorID := 0;

  FChangesLockCnt := 0;
  FMarkersLockCnt := 0;

  FStorage := TGapStorage.Create;
  FStorageLst := TDocumentStorageListener.Create(Self);
  TLMDTextStorage(FStorage).SetListener(TDocumentStorageListener(FStorageLst));

  FLineManager := TLineManager.Create(Self);

  FUndoManager := TUndoManager.Create(Self, LMDDefaultUndoLimit);
  FInternal := TLMDDocumentInternal.Create(Self);

  FMarkManager := TMarkManager.Create(Self);

  FListeners := TList.Create;
  FCustomListeners := TList.Create;

  FCompoundEditCnt := 0;
  FInUndo   := False;

  FBookmarks := TMarkManager(FMarkManager).CreateMarks(True, True, True);
  FBreakpoints := TMarkManager(FMarkManager).CreateMarks(True, False, True);
  FDebugFrameLines := TMarkManager(FMarkManager).CreateMarks(True, False, True);

  FLines := TDocumentStringsProxy.Create(Self);
  FWordSeparators  := LMDDefaultWordSeparators;
  FFullWordSeparators  := LMDDefaultWordSeparators+LMDAllLineSeparators+LMDSpace+LMDTab;

  FSyntaxSchemes := TLMDEditParserSchemeCollection.Create(Self);
  FColorSchemes := TLMDEditParserSchemeCollection.Create(Self);

  SetParser(TLMDEditParser.Create);

  FEncoding := TLMDEncoding.GetEncoding(CP_ACP);
  FCodePageUsePreamble := false;
  ResetModified;
  ResetChanges;

  FInConstructor := false;
end;

{------------------------------------------------------------------------------}

destructor TLMDEditDocument.Destroy;
begin
  while InsideCompoundEdit do
    EndCompoundEdit;

  FireDestroing;
  FMarkManager.Free;

  FParser.Free;

  FListeners.Free;
  FCustomListeners.Free;

  FUndoManager.Free;
  FLineManager.Free;
  FLines.Free;

  FStorage.Free;

  FBookmarks := nil;
  FBreakpoints := nil;
  FDebugFrameLines := nil;

  FStorageLst.Free;

  FInternal.Free;

  FSyntaxSchemes.Free;
  FColorSchemes.Free;

  FEncoding.Free;

  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.AddInternalListener(const ALst: TLMDDocumentListener);
begin
  Assert(not InsideCompoundEdit);

  if FListeners.IndexOf(ALst)=-1 then
    FListeners.Add(ALst);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.RemoveInternalListener(const ALst: TLMDDocumentListener);
begin
  FListeners.Remove(ALst);
end;

procedure TLMDEditDocument.RemoveListener(const ALst: TLMDDocumentListener);
begin
  FCustomListeners.Remove(ALst);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.LoadSyntaxFromColl(const ASchemeName: TLMDString): TLMDString;
begin
  CheckLoadingSyntaxSchemeName(ASchemeName);

  Result := FSyntaxSchemes.FindItem(ASchemeName).Scheme.Text;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.LoadColorFromColl(const ASchemeName: TLMDString): TLMDString;
begin
  CheckLoadingColorSchemeName(ASchemeName);

  Result := FColorSchemes.FindItem(ASchemeName).Scheme.Text;
end;

procedure TLMDEditDocument.LoadFromFile(const AFileName: TLMDString;
                                        ADefaultCodePage: Integer;
                                        AUnicodeAutodetect: Boolean);
var
    Stream: TStream;
begin
  Stream := TFileStream.Create(AFileName, fmOpenRead);
  try
    LoadFromStream(Stream, ADefaultCodePage, AUnicodeAutodetect);
  finally
    Stream.Free;
  end;
end;

procedure TLMDEditDocument.LoadFromStream(Stream: TStream; ACodePage: Integer);
begin
  LoadFromStream(Stream, ACodePage, false);
end;

procedure TLMDEditDocument.LoadFromFile(const AFileName: TLMDString;
                                        ACodePage: Integer);
begin
  LoadFromFile(AFileName, ACodePage, false);
end;

procedure TLMDEditDocument.LoadFromFile(const AFileName: TLMDString);
begin
  LoadFromFile(AFileName, CodePage);
end;

procedure TLMDEditDocument.LoadFromStream(Stream: TStream);
begin
  LoadFromStream(Stream, CodePage);
end;

procedure TLMDEditDocument.LoadFromStream(Stream: TStream;
                                          ADefaultCodePage: Integer;
                                          AUnicodeAutodetect: Boolean);
const BytesCntMax = 1024;

var OldLim: Integer;
    Bfr: TLMDWideCharArray;
    BfrCnt: Integer;
    Str: TLMDString;
    StrW: WideString;
    Bytes: TLMDByteArray;
    BytesPos: Integer;
    BytesCnt: Integer;
    HasPreamble: Boolean;

function GetBlock: Boolean;
var
    OldCnt: Integer;
    Cnt: Integer;
    PreambleUsed: Boolean;

    BCntTmp: Integer;

begin
  Assert(BytesPos <= BytesCntMax);
  Assert(BytesCnt <= BytesCntMax);

  if BytesPos <> 0 then
  begin
    Cnt := BytesCnt - BytesPos;
    if Cnt <> 0 then
    begin
      System.Move(Bytes[BytesPos], Bytes[0],
                  (BytesCnt - BytesPos) * Sizeof(Bytes[0]));
    end;

    BytesPos := 0;
    BytesCnt := Cnt;
  end
  else
    BytesCnt := 0;

  BytesCnt := BytesCnt + Stream.Read(Bytes[BytesCnt], BytesCntMax - BytesCnt);

  //Assert: we are at correct MB char sequence here
  try
    PreambleUsed := FEncoding.StartsFromMyPreamble(Bytes, 0, BytesCnt);
    HasPreamble := HasPreamble or PreambleUsed;
    Cnt := FEncoding.ReadBuffer(Bfr, 0, Bytes, 0, BytesCnt);

    BCntTmp := BytesCnt;
    OldCnt := Cnt;
    while (Cnt>1) and (Cnt=OldCnt) do
    begin
      Dec(BCntTmp);
      Cnt := FEncoding.ReadBuffer(Bfr, 0, Bytes, 0, BCntTmp);
    end;
  except
    on ELMDEncodingError do
    begin
      Result := False;
      Exit;
    end;
  end;

  BytesPos := FEncoding.GetRequiredByteBufferSize(Bfr, 0, Cnt, PreambleUsed);

  BytesPos := Min(BytesPos, BytesCnt);
  Result := Cnt<>0;
  BfrCnt := Cnt;
end;

var
    Detect: TLMDEncodingDetect;
    Seq: TLMDSeqFromString;
begin
  HasPreamble := false;

  CheckReadOnly;
  CheckNotUpdating;

  OldLim := UndoLimit;

  UndoLimit := 0;
  BeginUpdate;
  try
    Clear;

    if AUnicodeAutodetect then
    begin
      Detect := TLMDEncoding.TryDetectEncoding(Stream);
      if Detect.Detected then
      begin
        CodePage := Detect.CodePage;
        CodePageUsePreamble := Detect.PreambleUsed;
      end
      else
      begin
        CodePage := ADefaultCodePage;
        CodePageUsePreamble := false;
      end;
    end
    else
    begin
      CodePage := ADefaultCodePage;
      CodePageUsePreamble := false;
    end;

    FireBeforeRefresh;
    try
      SetLength(Bytes, BytesCntMax);

      BfrCnt := 0;
      BytesCnt := 0;
      BytesPos := 0;
      Seq := TLMDSeqFromString.Create('');
      while GetBlock do
      begin
        Str := '';

        LMDWideSetString(StrW, @Bfr[0], BfrCnt);
        Str := StrW;

        Seq.Reset(Str);
        TGapStorage(FStorage).Insert(TGapStorage(FStorage).Count, LMDSegment(Seq));
      end;
      Seq.Free;

      TLineManager(FLineManager).Refresh;
      FParser.LinesChangedFrom(0);

      CodePageUsePreamble := CodePageUsePreamble or HasPreamble;

      ResetModified;

      UndoLimit := OldLim;
    finally
      FireAfterRefresh;
    end;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireBeforeRefresh;
var
  i: Integer;
begin
  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).BeforeRefresh;

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).BeforeRefresh;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireAfterRefresh;
var
  i: Integer;
begin
  for i := 0 to FListeners.Count - 1 do
    GetLst(i).AfterRefresh;

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).AfterRefresh;

  /////

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).DoUserEventAfterDocChange;

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).DoUserEventAfterDocChange;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireBeforeSettingsRefresh;
var
  i: Integer;
begin
  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).BeforeSettingsRefresh;

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).BeforeSettingsRefresh;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetLst(i: Integer): TLMDDocumentListener;
begin
  Assert((i >=0) and (i < FListeners.Count));

  Result := TLMDDocumentListener(FListeners[i]);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetCustLst(i: Integer): TLMDDocumentListener;
begin
  Assert((i >=0) and (i < FCustomListeners.Count));

  Result := TLMDDocumentListener(FCustomListeners[i]);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireAfterSettingsRefresh;
var
  i: Integer;
begin
  for i := 0 to FListeners.Count - 1 do
    GetLst(i).AfterSettingsRefresh;

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).AfterSettingsRefresh;

  /////

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).DoUserEventAfterDocChange;

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).DoUserEventAfterDocChange;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireDestroing;
var
  i: Integer;
  lst: TList;
begin
  lst := TList.Create;
  try
    for i := 0 to FCustomListeners.Count - 1 do
      lst.Add(GetCustLst(i));

    for i := 0 to lst.Count - 1 do
      TLMDDocumentListener(lst[i]).DocumentDestroing;

    lst.Clear;

    for i := 0 to FListeners.Count - 1 do
      lst.Add(GetLst(i));

    for i := 0 to lst.Count - 1 do
      TLMDDocumentListener(lst[i]).DocumentDestroing;
  finally
    lst.Free;
  end
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.DoBeforeMarkChange;
var
  i: Integer;
begin
  CheckMarkersLock;
  BeginUpdate;

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).BeforeMarkChange;

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).BeforeMarkChange;
end;

procedure TLMDEditDocument.DoLinesChanged(AFirstLine, ACount: Integer);
begin
  if Assigned(FOnLinesChanged) then
    FOnLinesChanged(Self, AFirstLine, ACount);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.DoAfterMarkChange;
var
  i: Integer;
begin
  for i := 0 to FListeners.Count - 1 do
    GetLst(i).AfterMarkChange;

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).AfterMarkChange;

  /////

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).DoUserEventAfterDocChange;

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).DoUserEventAfterDocChange;

  /////

  EndUpdate;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireMarksDeleting(AMarkers: ILMDMarkers;
                                             AMarks: TLMDMarkArray);
var
  i: Integer;
begin
  Assert(AMarkers <> nil);

  if Assigned(FOnMarkDeleting) then
  try
    LockChanges;

    for i := 0 to Length(AMarks) - 1 do
      FOnMarkDeleting(Self, AMarkers, AMarks[i]);
  finally
    UnlockChanges;
  end;

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).MarksDeleting(AMarkers, AMarks);

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).MarksDeleting(AMarkers, AMarks);

  Include(FChanges, dcMarkersDeleted);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireMarkCreated(AMarkers: ILMDMarkers;
                                           AMark: ILMDMark);
var
  i: Integer;
begin
  if Assigned(FOnMarkCreating) then
  try
    LockChanges;

    if Assigned(FOnMarkCreating) then
      FOnMarkCreating(Self, AMarkers, AMark);
  finally
    UnlockChanges;
  end;

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).MarkCreated(AMarkers, AMark);

  Include(FChanges, dcMarkersCreated);

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).MarkCreated(AMarkers, AMark);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireMarkSettingsChanged(AMarkers: ILMDMarkers;
                                                   AMark: ILMDMark);
var
  i: Integer;
begin
  for i := 0 to FListeners.Count - 1 do
    GetLst(i).MarkSettingsChanged(AMarkers, AMark);

  Include(FChanges, dcMarkSettingsChanged);

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).MarkSettingsChanged(AMarkers, AMark);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireBeforeInsert(AStart, ACount: Integer);
var
  i: Integer;
begin
  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).BeforeInsert(AStart, ACount);

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).BeforeInsert(AStart, ACount);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireAfterInsert(AStart, ACount: Integer);
var
  i: Integer;
begin
  for i := 0 to FListeners.Count - 1 do
    GetLst(i).AfterInsert(AStart, ACount);

  Include(FChanges, dcInsert);

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).AfterInsert(AStart, ACount);

  ////

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).DoUserEventAfterDocChange;

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).DoUserEventAfterDocChange;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireBeforeDelete(AStart, ACount: Integer);
var
  i: Integer;
begin
  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).BeforeDelete(AStart, ACount);

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).BeforeDelete(AStart, ACount);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireAfterDelete(AStart, ACount: Integer);
var
  i: Integer;
begin
  for i := 0 to FListeners.Count - 1 do
    GetLst(i).AfterDelete(AStart, ACount);

  Include(FChanges, dcDelete);

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).AfterDelete(AStart, ACount);

  ///////

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).DoUserEventAfterDocChange;

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).DoUserEventAfterDocChange;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireBeforeCompoundEdit(AFreezeViews: Boolean);
var
  i: Integer;
begin
  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).BeforeCompoundEdit(AFreezeViews);

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).BeforeCompoundEdit(AFreezeViews);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireAfterCompoundEdit(AFreezeViews: Boolean);
var
  i: Integer;
begin
  for i := 0 to FListeners.Count - 1 do
    GetLst(i).AfterCompoundEdit(AFreezeViews);

  Include(FChanges, dcCompoundChange);

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).AfterCompoundEdit(AFreezeViews);

  ///////

  for i := 0 to FListeners.Count - 1 do
    GetLst(i).DoUserEventAfterDocChange;

  for i := 0 to FCustomListeners.Count - 1 do
    GetCustLst(i).DoUserEventAfterDocChange;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FireParser(AFirstLine, ACount: Integer);
begin
  DoLinesChanged(AFirstLine, ACount);

  if FParser <> nil then
  begin
    if ACount > 0 then
      FParser.LinesChangedFrom(AFirstLine)
    else
      FParser.LineChanged(AFirstLine);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckSyntaxSchemeName(ASchemeName: TLMDString);
begin
  if not ((ASchemeName='') or (FSyntaxSchemes.FindItem(ASchemeName)<>nil)) then
    raise ELMDEditDocError.Create(SLMDSedDocSyntaxSchemeNotFound+ASchemeName);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckColorSchemeName(ASchemeName: TLMDString);
begin
  if not ((ASchemeName='') or (FColorSchemes.FindItem(ASchemeName)<>nil)) then
    raise ELMDEditDocError.Create(SLMDSedDocColorSchemeNotFound+ASchemeName);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckLoadingSyntaxSchemeName(ASchemeName: TLMDString);
begin
  if not (FSyntaxSchemes.FindItem(ASchemeName)<>nil) then
    raise ELMDEditDocError.Create(SLMDSedDocSyntaxSchemeNotFound+ASchemeName);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckLoadingColorSchemeName(ASchemeName: TLMDString);
begin
  if not (FColorSchemes.FindItem(ASchemeName)<>nil) then
    raise ELMDEditDocError.Create(SLMDSedDocColorSchemeNotFound+ASchemeName);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckNotUpdating;
  procedure RaiseUpdating;
  begin
    raise ELMDEditDocError.Create(SLMDSedDocMethodInUpdatingState);
  end;
begin
  if InsideCompoundEdit then
    RaiseUpdating;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckChangesLock;
  procedure RaiseLocked;
  begin
    raise ELMDEditDocError.Create(SLMDSedDocChangesLocked);
  end;
begin
  if not (FChangesLockCnt=0) then
    RaiseLocked;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckReadOnly;
  procedure RaiseReadOnly;
  begin
    raise ELMDEditDocError.Create(SLMDSedDocReadOnly);
  end;
begin
  if FReadOnly then
    RaiseReadOnly;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckMarkersLock;
  procedure RaiseLocked;
  begin
    raise ELMDEditDocError.Create(SLMDSedDocMarkersLocked);
  end;
begin
  if not (FMarkersLockCnt=0) then
    RaiseLocked;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckCanUndoRedo(AUndo: Boolean; AAuthorID: Integer);

const RK_UNDO=1; RK_UNDO_AUTHOR=2; RK_REDO=3; RK_REDO_AUTHOR=4;
  procedure RaiseErr(AKind: Integer);
  begin
    case AKind of
      RK_UNDO: raise ELMDEditDocError.Create(SLMDSedDocCantUndo);
      RK_UNDO_AUTHOR: raise ELMDEditDocError.CreateFmt(SLMDSedDocCantUndoForAuthor, [AAuthorID]);
      RK_REDO: raise ELMDEditDocError.Create(SLMDSedDocCantRedo);
      RK_REDO_AUTHOR: raise ELMDEditDocError.CreateFmt(SLMDSedDocCantRedoForAuthor, [AAuthorID]);
    else
      Assert(False);
    end;
  end;

begin
  if AUndo then
  begin
    if not GetCanUndo(AAuthorID) then
    begin
      if AAuthorID=-1 then
        RaiseErr(RK_UNDO)
      else
        RaiseErr(RK_UNDO_AUTHOR)
    end;
  end
  else
  begin
    if not GetCanRedo(AAuthorID) then
    begin
      if AAuthorID=-1 then
        RaiseErr(RK_REDO)
      else
        RaiseErr(RK_REDO_AUTHOR)
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckInCompoundEdit;
  procedure RaiseCompEdit;
  begin
    raise ELMDEditDocError.Create(SLMDSedDocNotInCompoundEdit);
  end;
begin
  if not InsideCompoundEdit then
    RaiseCompEdit;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckCustomMarkersValid(AMarkers: IInterface);
  procedure RaiseInvalid;
  begin
    raise ELMDEditDocError.Create(SLMDSedDocInvalidCustomMarkers);
  end;
begin
  if (AMarkers=nil) or
     (not TMarkManager(FMarkManager).HasMarks(AMarkers))
  then
    RaiseInvalid
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckSegValid(const ASeg: TLMDSegment);
  procedure RaiseInvalid;
  begin
    raise ELMDEditDocError.Create(SLMDSedDocInvalidSegment);
  end;
begin
  if not LMDSegIsValid(ASeg) then
    RaiseInvalid;
end;

procedure TLMDEditDocument.SetModFixed;
var
    Cnt: Integer;
    oldFix: Boolean;
begin
  if not FModifiedFixed then
  begin
    Cnt := TUndoManager(FUndoManager).UndoCount;
    if (Cnt>0) and (Cnt=UndoLimit) then
    begin
      Dec(FUndoCountNoMod);

      oldFix := GetModified;

      FModifiedFixed := FUndoCountNoMod < 0;

      FUndoCountNoMod := 0;

      if oldFix<>GetModified then
        Include(FChanges, dcModifiedPropertyChanged);
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.BeginUpdate;
begin
  Inc(FDelayedEventLock);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.EndUpdate(AWithEvent: Boolean = True);
begin
  Assert(FDelayedEventLock>0);
  Dec(FDelayedEventLock);

  if AWithEvent and (FDelayedEventLock=0) and
     Assigned(FOnDocChanged) and (FChanges<>[])
  then
  begin
    FOnDocChanged(Self, FChanges);
    FChanges := [];
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetChars: TLMDCharSeq;
begin
  Result := TLMDTextStorage(FStorage);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetCharsCount: Integer;
begin
  Result := TLMDTextStorage(FStorage).Count;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetCodePage: TLMDCodePageRef;
begin
  Result := FEncoding.CodePage;
end;

function TLMDEditDocument.GetCodePageName: string;
begin
  Result := FEncoding.Name;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetLinesCount: Integer;
begin
  Result := TLineManager(FLineManager).Count;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetParser: TLMDEditParserBase;
begin
  Result := FParser;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckLineIdx(ALine: Integer);
  procedure RaiseLineIdx;
  begin
    raise ELMDEditDocError.CreateFmt(SLMDSedInvalidLineIdx, [ALine, 0, LinesCount - 1]);
  end;
begin
  if not LMDInRange(ALine, 0, LinesCount - 1) then
    RaiseLineIdx;
end;

procedure TLMDEditDocument.CheckLineIdxCol(ALine, AColumn: Integer);
var
    Cnt: Integer;

  procedure RaiseErr;
  begin
    raise ELMDEditDocError.CreateFmt(SLMDSedInvalidLineColIdx,
                                     [AColumn, Cnt - 1]);
  end;
begin
  CheckLineIdx(ALine);
  Cnt := LineSegments[ALine].Count;

  if not LMDInRange(AColumn, 0, Cnt - 1) then
    RaiseErr;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckSearchOffset(AOffset: Integer);
  procedure RaiseSearchOffset;
  begin
    raise ELMDEditDocError.CreateFmt(SLMDSedDocInvalidOffsetToSearch,
                                      [AOffset, 0, Chars.Count]);
  end;
begin
  if not LMDInRange(AOffset, 0, Chars.Count) then
    RaiseSearchOffset;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckOffset(AOffset: Integer);
  procedure RaiseOffset;
  begin
    raise ELMDEditDocError.CreateFmt(SLMDSedDocInvalidOffset,
                                      [AOffset, 0, Chars.Count - 1]);
  end;
begin
  if not LMDInRange(AOffset, 0, Chars.Count - 1) then
    RaiseOffset;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.CheckInsOffset(AOffset: Integer);
  procedure RaiseInsOffset;
  begin
    raise ELMDEditDocError.CreateFmt(SLMDSedDocInvalidCharInsIndex,
                                      [AOffset, 0, Chars.Count]);
  end;
begin
  if not LMDInRange(AOffset, 0, Chars.Count) then
    RaiseInsOffset;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.LockMarkers;
begin
  Assert(FMarkersLockCnt>=0);

  Inc(FMarkersLockCnt)
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.LockChanges;
begin
  Assert(FChangesLockCnt>=0);

  Inc(FChangesLockCnt);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.UnlockMarkers;
begin
  Assert(FMarkersLockCnt>0);

  Dec(FMarkersLockCnt)
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.UnlockChanges;
begin
  Assert(FChangesLockCnt>0);

  Dec(FChangesLockCnt);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetFullWordSeparators: TLMDString;
begin
  Result := FFullWordSeparators;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetParser(const AParser: TLMDEditParserBase);
begin
  if FParser<>nil then
  begin
    TLMDEditParser(FParser).SetSchemeLoaders(nil, nil);
    FParser.SetDocument(nil);
  end;

  FParser := AParser;

  if FParser<>nil then
  begin
    FParser.SetDocument(Self);
    TLMDEditParser(FParser).SetSchemeLoaders(LoadSyntaxFromColl, LoadColorFromColl);
    UpdateActiveSchemes;
  end;
end;

{------------------------------------------------------------------------------}

function GetBreakMark(ADoc: TLMDEditDocument; const ABreak: ILMDLineMark): TMark;
var
    MarkInt: IMarkInternal;
begin
  if ABreak.Collection <> ADoc.FBreakpoints then
    raise ELMDEditDocError.Create(SLMDSedDocBreakpointExpectedByMethod);

  MarkInt := ABreak as IMarkInternal;
  Result := MarkInt.GetImpl;
end;

function GetDebugFrameMark(ADoc: TLMDEditDocument; const AFrm: ILMDLineMark): TMark;
var
    MarkInt: IMarkInternal;
begin
  if AFrm.Collection <> ADoc.FDebugFrameLines then
    raise ELMDEditDocError.Create(SLMDSedDocDbgStackExpectedByMethod);

  MarkInt := AFrm as IMarkInternal;
  Result := MarkInt.GetImpl;
end;

function  TLMDEditDocument.GetBreakpointKind(const ABreak: ILMDLineMark): TLMDBreakpointKind;
begin
  result := GetBreakMark(self, ABreak).GetBreakKind;
end;

procedure  TLMDEditDocument.SetBreakpointKind(const ABreak: ILMDLineMark; AKind: TLMDBreakpointKind);
begin
  GetBreakMark(self, ABreak).SetBreakKind(AKind);
end;
{------------------------------------------------------------------------------}

function TLMDEditDocument.CreateCustomMarkers(AKeepMarks, ALineBound: Boolean;
                                              AProduceEvents: Boolean): ILMDMarkers;
begin
  BeginUpdate;
  try
    Result := TMarkManager(FMarkManager).CreateMarks(ALineBound, AKeepMarks,
                                                     AProduceEvents);
  finally
    EndUpdate(False);
  end
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.CreateCustomLineMarkers(AKeepMarks,
                                                  AProduceEvents: Boolean): ILMDMarkers;
begin
  Result := CreateCustomMarkers(AKeepMarks, true, AProduceEvents);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.DetachCustomMarkers(AMarkers: ILMDMarkers);
var
  Itf, Itf2: IInterface;
begin
  Itf := AMarkers as IInterface;

  CheckCustomMarkersValid(Itf);

  Itf2 := Bookmarks as IInterface;

  if Itf=Itf2 then
    raise ELMDEditDocError.Create(SLMDSedDocCantDetachDocumentMarkers);

  Itf2 := Breakpoints as IInterface;

  if Itf = Itf2 then
    raise ELMDEditDocError.Create(SLMDSedDocCantDetachDocumentMarkers);

  Itf2 := DebugFrameLines as IInterface;

  if Itf = Itf2 then
    raise ELMDEditDocError.Create(SLMDSedDocCantDetachDocumentMarkers);

  BeginUpdate;
  try
    TMarkManager(FMarkManager).ReleaseMarks(Itf);
  finally
    EndUpdate(False);
  end
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.BeginCompoundEdit(AFreezeViews: Boolean);
begin
  CheckReadOnly;
  CheckChangesLock;

  BeginCompoundAction(-1, nil, AFreezeViews);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.EndCompoundEdit(AFreezeViews: Boolean = True);
begin
  CheckChangesLock;
  CheckInCompoundEdit;

  Assert(FCompoundEditCnt>0);
  Dec(FCompoundEditCnt);

  if FCompoundEditCnt=0 then
  begin
    if not FInUndo then
      TUndoManager(FUndoManager).EndCompoundAction;

    if csLoading in ComponentState then
      ClearUndo;

    SetModFixed;

    FireAfterCompoundEdit(AFreezeViews);
  end;

  EndUpdate;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetInsideCompoundEdit: Boolean;
begin
  Result := FCompoundEditCnt > 0;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetReadOnly(AReadOnly: Boolean);
begin
  FireBeforeSettingsRefresh;

  FReadOnly := AReadOnly;

  FireAfterSettingsRefresh;
end;
{------------------------------------------------------------------------------}

function TLMDEditDocument.GetLine(ALine: Integer): TLMDSegment;
begin
  if (LinesCount=0) and (ALine=0) then
    Result := LMDSegment(0, 0, Chars)
  else
  begin
    CheckLineIdx(ALine);
    Result := TLineManager(FLineManager).GetAt(ALine);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetLineStr(ALine: Integer): TLMDString;
begin
  CheckLineIdx(ALine);

  Result := LMDSegToString( GetLine(ALine) )
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.Insert(AStart: Integer; const AStr: TLMDString);
var
  Seg: TLMDSegment;
begin
  CheckReadOnly;
  CheckChangesLock;

  try
    Seg := LMDSegFromString(AStr);
    Self.InsertSeg(AStart, Seg);
  finally
    LMDSegFree(Seg);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.InsertLine(ALine: Integer; const AStr: TLMDString);
begin
  CheckReadOnly;
  CheckChangesLock;

  if ALine=LinesCount then
    AppendLine(AStr)
  else
    Insert(LineSegments[ALine].Start, AStr+LineSeparatorStr);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.AppendLine(const AStr: TLMDString);
begin
  CheckReadOnly;
  CheckChangesLock;

  BeginUpdate;
  try
    if CharsCount>0 then
      Insert(CharsCount, LineSeparatorStr+AStr)
    else
      Insert(CharsCount, AStr);
  finally
    EndUpdate
  end
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.Replace(AStart, ACount: Integer; const AStr: TLMDString);
var
  Seg: TLMDSegment;
begin
  CheckReadOnly;
  CheckChangesLock;

  Seg := LMDSegFromString(AStr);
  try
    Self.ReplaceSeg(AStart, ACount, Seg);
  finally
    LMDSegFree(Seg);
  end;
end;

function TLMDEditDocument.ReplacePatternAll(AOffset: Integer; const APattern,
                                            AReplacement: TLMDString;
                                            AOpts: TLMDEditSearchOptions):
                                            TLMDEditFindReplaceState;
begin
  Result := ReplacePatternAll(AOffset, -1, APattern, AReplacement, AOpts);
end;

function TLMDEditDocument.ReplacePatternAll(AOffset, AMaxCount: Integer;
                                            const APattern, AReplacement: TLMDString;
                                            AOpts: TLMDEditSearchOptions):
                                            TLMDEditFindReplaceState;
var
    Dummy: TLMDEditReplaceEvent;
begin
  Dummy := nil;
  Result := ReplacePatternAll(AOffset, AMaxCount, APattern, AReplacement, AOpts,
                              sdForward, Dummy);
end;

function TLMDEditDocument.ReplacePatternAll(AOffset: Integer;
                                            const APattern,
                                                  AReplacement: TLMDString):
                                            TLMDEditFindReplaceState;
begin
  Result := ReplacePatternAll(AOffset, -1, APattern, AReplacement, []);
end;

function TLMDEditDocument.ReplacePatternAll(const APattern,
                                                  AReplacement: TLMDString):
                                            TLMDEditFindReplaceState;
begin
  Result := ReplacePatternAll(APattern, AReplacement, []);
end;

function TLMDEditDocument.ReplacePatternAll(const APattern,
                                                  AReplacement: TLMDString;
                                           AOpts: TLMDEditSearchOptions):
                                           TLMDEditFindReplaceState;
begin
  Result := ReplacePatternAll(0, -1, APattern, AReplacement, AOpts);
end;

function TLMDEditDocument.ReplacePatternAll(AOffset, AMaxCount: Integer;
                                            const APattern, AReplacement: TLMDString;
                                            AOpts: TLMDEditSearchOptions;
                                            ADirection: TLMDEditSearchDirection;
                                            AReplaceCallback: TLMDEditReplaceEvent):
                                            TLMDEditFindReplaceState;
var
    State: TLMDEditFindReplaceState;
begin
  BeginCompoundEdit;
  try
    State := ReplacePatternFirst(AOffset, AMaxCount,
                                 APattern, AReplacement,
                                 AOpts, ADirection,
                                 AReplaceCallback);

    while ReplacePatternNext(State) and
         (State.LastReplaceAction <> raCancel) do
      ;

    Result := State;
  finally
    EndCompoundEdit;
  end;
end;

procedure TLMDEditDocument.ReplacePatternClose(AState: TLMDEditFindReplaceState);
begin
  FindPatternClose(AState);
end;

function TLMDEditDocument.ReplacePatternFirst(AOffset, AMaxCount: Integer;
                                              const APattern, AReplacement: TLMDString;
                                              AOpts: TLMDEditSearchOptions):
                                              TLMDEditFindReplaceState;
begin
  Result := ReplacePatternFirst(AOffset, AMaxCount, APattern, AReplacement, AOpts,
                                sdForward);
end;

function TLMDEditDocument.ReplacePatternFirst(AOffset: Integer;
                                              const APattern, AReplacement: TLMDString;
                                              AOpts: TLMDEditSearchOptions):
                                              TLMDEditFindReplaceState;
begin
  Result := ReplacePatternFirst(AOffset, -1, APattern, AReplacement, AOpts,
                                sdForward);
end;

function TLMDEditDocument.ReplacePatternFirst(AOffset, AMaxCount: Integer;
                                              const APattern,
                                              AReplacement: TLMDString;
                                              AOpts: TLMDEditSearchOptions;
                                              ADirection: TLMDEditSearchDirection;
                                              AReplaceCallback: TLMDEditReplaceEvent):
                                              TLMDEditFindReplaceState;
var
  State: TLMDEditFindReplaceState;
begin
  State := MakeFindState(AOffset, AMaxCount, APattern, AOpts, ADirection, Self);
  State.Replacement := AReplacement;
  State.OnReplace := AReplaceCallback;

  if ReplacePatternNextLow(-1, State, true) then
    Result := State
  else
  begin
    State.Free;
    Result := nil;
  end;
end;

function TLMDEditDocument.ReplacePatternNext(AState: TLMDEditFindReplaceState): Boolean;
begin
  Result := ReplacePatternNext(-1, AState);
end;

function TLMDEditDocument.ReplacePatternNext(ANewStart: Integer;
                                             AState: TLMDEditFindReplaceState): Boolean;
begin
  Result := ReplacePatternNextLow(ANewStart, AState, false);
end;

function TLMDEditDocument.ReplacePatternNextLow(ANewStart: Integer;
                                                AState: TLMDEditFindReplaceState;
                                                AFirstTime: Boolean): Boolean;
var
  ReplacedCount: Integer;
  Act: TLMDEditReplaceAction;
  ReplText: TLMDString;
begin
  Result := FindPatternNextLow(ANewStart, AState, AFirstTime);

  if Result then
  begin
    Act := raReplaceAuto;
    ReplacedCount := AState.FoundSegment.Count;

    if Assigned(AState.OnReplace) then
    begin
      AState.OnReplace(self, AState, ReplacedCount, Act);
      ReplacedCount := LMDMinMax(ReplacedCount, 0,
                                 CharsCount - AState.FoundSegment.Start);
    end;

    case Act of
      raReplaceAuto:
      begin
        if (soRegexp in AState.Options) and
           (soRegexpSubstitute in AState.Options) then
          ReplText := AState.FoundRegex.Substitute(AState.Replacement)
        else
          ReplText := AState.Replacement;

        Replace(AState.FoundSegment.Start, AState.FoundSegment.Count, ReplText);
        AState.FoundSegment.Count := Length(ReplText);
      end;
      raReplacedByCallback:
        AState.FoundSegment.Count := ReplacedCount;
      raGoNext:
        ; //Do nothing
      raCancel:
        Result := false;
    else
      Assert(false);
    end;

    AState.LastReplaceAction := Act;
  end;
end;

function TLMDEditDocument.ReplacePatternFirst(AOffset, AMaxCount: Integer;
                                              const APattern: TLMDString;
                                              const AReplacement: TLMDString;
                                              AOpts: TLMDEditSearchOptions;
                                              ADirection: TLMDEditSearchDirection):
                                              TLMDEditFindReplaceState;
var
    Dummy: TLMDEditReplaceEvent;
begin
  Dummy := nil;
  Result := ReplacePatternFirst(AOffset, AMaxCount,
                                APattern, AReplacement,
                                AOpts, ADirection, Dummy);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.InsertSeg(AStart: Integer; const ASeg: TLMDSegment);
begin
  CheckReadOnly;
  CheckChangesLock;

  InsertSegLow(AStart, ASeg, -1, nil, false);
end;

procedure TLMDEditDocument.InsertStrLow(AStart: Integer; AStr: TLMDString;
  AAuthorID: Integer; AOldInfo: TLMDDocUndoInfo);
begin
  InsertSegLow(AStart, LMDSegFromString(AStr), AAuthorID, AOldInfo, true);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.InsideCRLF_CR(AOffset: Integer): Boolean;
begin
  Result := LMDInRange(AOffset, 0, CharsCount-2) and
            (Chars[AOffset]=LMDCR) and
            (Chars[AOffset+1]=LMDLF);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.InsideCRLF_LF(AOffset: Integer): Boolean;
begin
  Result := LMDInRange(AOffset, 1, CharsCount-1) and
            (Chars[AOffset]=LMDLF) and
            (Chars[AOffset-1]=LMDCR);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.DeleteLine(ALine: Integer);
var
  Seg: TLMDSegment;
begin
  CheckReadOnly;
  CheckChangesLock;
  CheckLineIdx(ALine);

  if (LinesCount=1) or (ALine<>LinesCount-1) then
    Seg := GetLineWithCr(ALine)
  else
  begin
    Seg.Start := LMDSegEnd( LineSegments[ALine-1] ) + 1;
    Seg.Count := LMDSegEnd( LineSegments[ALine] ) - Seg.Start + 1;
  end;

  Delete(Seg.Start, Seg.Count);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetLineByOffset(AOffset: Integer): Integer;
begin
  Result := TLineManager(FLineManager).GetLineByOffset(AOffset);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetLineWithCr(ALine: Integer): TLMDSegment;
var
  NextStart: Integer;
  LineSeg: TLMDSegment;
begin
  if (LinesCount=0) and (ALine=0) then
    Result := LMDSegment(0, 0, Chars)
  else
  begin
    CheckLineIdx(ALine);

    LineSeg := TLineManager(FLineManager).GetAt(ALine);

    if ALine < LinesCount - 1 then
      NextStart := TLineManager(FLineManager).GetLineStart(ALine+1)
    else
      NextStart := LineSeg.Source.Count;

    Result := LineSeg;
    Result.Count := NextStart - Result.Start;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetLineEndKind(ALine: Integer; out Res: TLMDLineSeparator): Boolean;
begin
  Result := TLineManager(FLineManager).GetLineEndKind(ALine, Res);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.Delete(AStart, ACount: Integer);
begin
  CheckReadOnly;
  CheckChangesLock;

  DeleteLow(AStart, ACount, -1, nil);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.Clear;
begin
  CheckReadOnly;
  CheckChangesLock;

  Delete(0, CharsCount);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.ClearNoUndo;
var
  OldUndoLimit: Integer;
begin
  CheckReadOnly;
  CheckChangesLock;
  CheckNotUpdating;

  BeginUpdate;

  try
    OldUndoLimit := UndoLimit;
    try
      UndoLimit := 0;
      Clear;
    finally
      UndoLimit := OldUndoLimit;
    end;

    ResetModified;
  finally
    EndUpdate(true);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.ReplaceSeg(AStart, ACount: Integer;
                                      const ASeg: TLMDSegment);
begin
  CheckReadOnly;
  CheckChangesLock;

  ReplaceSegLow(AStart, ACount, ASeg, -1, nil);
end;

procedure TLMDEditDocument.ReplaceStrLow(AStart, ACount: Integer;
                                      const AStr: TLMDString;
                                      AAuthorID: Integer;
                                      AOldInfo: TLMDDocUndoInfo);
var
    Seg: TLMDSegment;
begin
  Seg := LMDSegFromString(AStr);
  try
    ReplaceSegLow(AStart, ACount, Seg, AAuthorID, AOldInfo);
  finally
    LMDSegFree(Seg);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.ResetChanges;
begin
  FChanges := [];
end;

procedure TLMDEditDocument.ResetModified;
var
    oldMod: Boolean;
begin
  oldMod := GetModified;

  FModified := false;
  FModifiedFixed := false;

  FUndoCountNoMod := 0;

  if oldMod<>GetModified then
    Include(FChanges, dcModifiedPropertyChanged);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.Redo;
var
  dummy: TLMDDocUndoInfo;
begin
  CheckReadOnly;
  CheckChangesLock;

  RedoLow(-1, nil, dummy);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetCanUndoProp: Boolean;
begin
  Result := GetCanUndo(-1);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetCanRedoProp: Boolean;
begin
  Result := GetCanRedo(-1);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.ClearUndo;
var
    oldMod: Boolean;
begin
  CheckNotUpdating;

  BeginUpdate;
  oldMod := GetModified;

  try
    if not FModifiedFixed then
      FModifiedFixed := TUndoManager(FUndoManager).UndoCount<>FUndoCountNoMod;

    FUndoCountNoMod := 0;

    TUndoManager(FUndoManager).Clear;
  finally
    if oldMod<>GetModified then
      Include(FChanges, dcModifiedPropertyChanged);

    EndUpdate(true);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_SYNTAX;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetInternal: TLMDDocumentInternal;
begin
  Result := FInternal;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetCanRedo(AAuthorID: Integer): Boolean;
begin
  Result := TUndoManager(FUndoManager).CanRedo(AAuthorID);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetCanUndo(AAuthorID: Integer): Boolean;
begin
  Result := TUndoManager(FUndoManager).CanUndo(AAuthorID);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.UndoLow(AAuthorID: Integer;
                                ANewInfo: TLMDDocUndoInfo;
                                var OldInfo: TLMDDocUndoInfo);
begin
  CheckReadOnly;
  CheckChangesLock;
  CheckNotUpdating;
  CheckCanUndoRedo(True, AAuthorID);

  FInUndo := True;
  BeginUpdate;
  try
    TUndoManager(FUndoManager).Undo(AAuthorID, ANewInfo, OldInfo);
  finally
    FInUndo := False;

    SetModifiedByUndoRedo;
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.RedoLow(AAuthorID: Integer;
                                ANewInfo: TLMDDocUndoInfo;
                                var OldInfo: TLMDDocUndoInfo);
begin
  CheckReadOnly;
  CheckChangesLock;
  CheckNotUpdating;
  CheckCanUndoRedo(False, AAuthorID);

  FInUndo := True;
  BeginUpdate;
  try
    TUndoManager(FUndoManager).Redo(AAuthorID, ANewInfo, OldInfo);
  finally
    SetModifiedByUndoRedo;
    FInUndo := False;
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.InsertSegLow(AStart: Integer; ASeg: TLMDSegment;
                                     AAuthorID: Integer;
                                     AOldInfo: TLMDDocUndoInfo;
                                     ADoFreeSeg: Boolean);
var
  LRes: TLineManResult;
  Seg: TLMDSegment;
  DoFreeSeg: Boolean;
begin
  CheckReadOnly;
  CheckChangesLock;
  CheckSegValid(ASeg);
  CheckInsOffset(AStart);

  DoFreeSeg := False;
  try
    if ASeg.Count=0 then
      Exit;

    if InsideCRLF_LF(AStart) then
    begin
      BeginCompoundAction(AAuthorID, AOldInfo, true);
      try
        DeleteLow(AStart-1, 2, AAuthorID, AOldInfo);

        InsertSegLow(AStart-1, LMDSegFromString(LMDCR), AAuthorID, AOldInfo, true);
        InsertSegLow(AStart, ASeg, AAuthorID, AOldInfo, false);
        InsertSegLow(AStart+ASeg.Count, LMDSegFromString(LMDLF), AAuthorID, AOldInfo, true);
      finally
        EndCompoundEdit(true);
      end;
    end
    else
    begin
      BeginUpdate;
      try
        DoFreeSeg := ASeg.Source=Chars;
        if DoFreeSeg then
          Seg := LMDSegFromString( LMDSegToString(ASeg) ) // [opt!]
        else
          Seg := ASeg;

        FireBeforeInsert(AStart, Seg.Count);

        TLMDTextStorage(FStorage).Insert(AStart, Seg);

        LRes := TLineManager(FLineManager).ContentInserted(AStart, Seg.Count);

        if not FInUndo then
          TUndoManager(FUndoManager).ContentInserted(AStart, Seg.Count,
                                                     AAuthorID, AOldInfo);

        TMarkManager(FMarkManager).ContentInserted(AStart, Seg.Count);

        FireParser(LRes.FirstChangedLine, LRes.ChangedLinesCount);
        FireAfterInsert(AStart, Seg.Count)
      finally
        if DoFreeSeg then
          LMDSegFree(Seg);

        SetModifiedByChange;
        EndUpdate;
      end;
    end;
  finally
    if ADoFreeSeg then
      LMDSegFree(ASeg);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.DeleteLow(AStart, ACount, AAuthorID: Integer;
  AOldInfo: TLMDDocUndoInfo);
var
  LRes: TLineManResult;
  i: Integer;
  MarkMgr: TMarkManager;
  MarkColl: TMarkCollection;
  BmkColl: TMarkCollection;
  Marks: TLMDMarkArray;
  BmkI, I2: IInterface;
begin
  BmkColl := nil;
  CheckReadOnly;
  CheckChangesLock;

  if ACount = 0 then
  begin
    CheckInsOffset(AStart);
    Exit;
  end;

  CheckOffset(AStart);
  CheckOffset(AStart + ACount - 1);

  if InsideCRLF_LF(AStart) or InsideCRLF_CR(AStart+ACount-1) then
  begin
    BeginCompoundAction(AAuthorID, AOldInfo, true);
    try
      if InsideCRLF_LF(AStart) then
      begin
        DeleteLow(AStart-1, ACount+1, AAuthorID, AOldInfo);
        InsertSegLow(AStart-1, LMDSegFromString(LMDCR), AAuthorID, AOldInfo, true);
      end
      else
      begin
        DeleteLow(AStart, ACount+1, AAuthorID, AOldInfo);
        InsertSegLow(AStart, LMDSegFromString(LMDLF), AAuthorID, AOldInfo, true);
      end;
    finally
      EndCompoundEdit(true);
    end;
  end
  else
  begin
    BmkI := FBookmarks as IInterface;

    BeginUpdate;
    try
      MarkMgr := TMarkManager(FMarkManager);
      SetLength(Marks, 0);
      for i := 0 to MarkMgr.MarksCount-1 do
      begin
        MarkColl := MarkMgr.GetMarks(i);
        if MarkColl.ProduceEvents then
        begin
          if ACount=CharsCount then
            I2 := MarkColl as IInterface
          else
            I2 := nil;

          if (ACount=CharsCount) and (BmkI=I2) then
          begin
            BmkColl := MarkColl;
            Marks := MarkColl.GetMarksToDelete(AStart, ACount, false)
          end
          else
            Marks := MarkColl.GetMarksToDelete(AStart, ACount, true);

          if Length(Marks)<>0 then
          begin
            DoBeforeMarkChange;
            MarkColl.ProduceEvents := false;
            try
              FireMarksDeleting(MarkColl, Marks);
            finally
              MarkColl.ProduceEvents := true;
              DoAfterMarkChange;
            end;
          end
        end;
      end;

      if ACount = CharsCount then
      begin
        Assert(BmkColl<>nil);
        BmkColl.FProduceEvents := false;
        BmkColl.Clear;
        BmkColl.FProduceEvents := true;
      end;

      FireBeforeDelete(AStart, ACount);

      if not FInUndo then
        TUndoManager(FUndoManager).ContentDeleting(AStart, ACount, AAuthorID, AOldInfo);

      MarkMgr.ContentDeleting(AStart, ACount);

      LRes := TLineManager(FLineManager).ContentDeleting(AStart, ACount);

      TLMDTextStorage(FStorage).Delete(AStart, ACount);

      SetModifiedByChange;

      FireParser(LRes.FirstChangedLine, LRes.ChangedLinesCount);

      FireAfterDelete(AStart, ACount);
    finally
      EndUpdate;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.ReplaceSegLow(AStart, ACount: Integer;
                                      const ASeg: TLMDSegment;
                                      AAuthorID: Integer;
                                      AOldInfo: TLMDDocUndoInfo);
begin
  CheckReadOnly;
  CheckChangesLock;
  CheckSegValid(ASeg);

  BeginUpdate;
  try
    BeginCompoundAction(AAuthorID, AOldInfo, true);
    try
      if ACount=0 then
        CheckInsOffset(AStart)
      else
      begin
        CheckOffset(AStart);
        CheckOffset(AStart+ACount-1);
      end;

      DeleteLow(AStart, ACount, -1, nil);
      InsertSegLow(AStart, ASeg, -1, nil, false);
    finally
      EndCompoundEdit;
    end;
  finally
    SetModifiedByChange;
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.PushCustomAction(AAuthorID: Integer;
                                            AOldInfo: TLMDDocUndoInfo);
begin
  TUndoManager(FUndoManager).PushCustomAction(AAuthorID, AOldInfo);

  Assert((not FInUndo) and (not InsideCompoundEdit));
  SetModFixed;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.BeginCompoundAction(AAuthorID: Integer;
                                               AOldInfo: TLMDDocUndoInfo;
                                               AFreezeViews: Boolean);
begin
  CheckReadOnly;
  CheckChangesLock;

  BeginUpdate;

  Inc(FCompoundEditCnt);
  if FCompoundEditCnt=1 then
  begin
    FireBeforeCompoundEdit(AFreezeViews);

    if (not FInUndo) and (FCompoundEditCnt=1) then
      TUndoManager(FUndoManager).BeginCompoundAction(AAuthorID, AOldInfo);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetModified: Boolean;
begin
  Result := FModifiedFixed or FModified;
end;

function TLMDEditDocument.GetNextAuthorID: Integer;
begin
  Inc(FLastAuthorID);
  Result := FLastAuthorID;
end;

function TLMDEditDocument.GetOnLineMarkCreating: TLMDMarkEvent;
begin
  Result := FOnMarkCreating;
end;

function TLMDEditDocument.GetOnLineMarkDeleting: TLMDMarkEvent;
begin
  Result := FOnMarkDeleting;
end;

{------------------------------------------------------------------------------}

function  TLMDEditDocument.FindNearWordEnd(AOffset, AMaxCount: Integer;
                                           ABackward, AAllowOffset: Boolean;
                                           const ASeparators: TLMDString): Integer;
var
  Pos, PosN, MaxPos, Dir: Integer;
  Sep: TLMDString;
begin
  Sep := GetSep(ASeparators);

  if (AMaxCount=0) or (Length(Sep)=0) then
  begin
    Result := -1;
    Exit;
  end;

  CheckSearchOffset(AOffset);

  if AMaxCount=-1 then
    AMaxCount := MAXINT;

  if ABackward then
  begin
    Dir := -1;
    AMaxCount := Min(AMaxCount, AOffset+1);
    MaxPos := AOffset - AMaxCount;
  end
  else
  begin
    Dir := 1;
    AMaxCount := Min(AMaxCount, CharsCount-AOffset);
    MaxPos := AOffset + AMaxCount;
  end;

  if AOffset<>CharsCount then
    Pos := LMDSeqPosOneOfGen(Sep, Chars, AOffset, AMaxCount, ABackward, True)
  else if CharsCount>0 then
    Pos := LMDSeqPosOneOfGen(Sep, Chars, AOffset-1, AMaxCount-1, ABackward, True)
  else
    Pos := -1;

  if Pos<>-1 then
  begin
    if ABackward then
    begin
      if Pos=AOffset then
      begin
        PosN := LMDSeqPosOneOfGen(Sep, Chars, Pos, Pos-MaxPos, True, False);

        if PosN=-1 then
          Pos := -1
        else
          Pos := LMDSeqPosOneOfGen(Sep, Chars, PosN, PosN-MaxPos, True, True);
      end;
    end
    else
    begin
      PosN := LMDSeqPosOneOfGen(Sep, Chars, Pos, MaxPos-Pos, False, False);

      if PosN=-1 then
        Pos := MaxPos-1
      else
        Pos := PosN-1;
    end;

    if (AOffset=Pos) and (not AAllowOffset) then
      Pos := FindNearWordEnd(Pos+Dir, AMaxCount-1, ABackward, true, Sep);
  end;

  Result := Pos;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetSep(const ASep: TLMDString): TLMDString;
begin
  if ASep = '' then
    Result := FFullWordSeparators
  else
    Result := ASep + LMDSpace + LMDTab + LMDCRLF;
end;

function TLMDEditDocument.GetDebugFrameKind(
  const AFrameMark: ILMDLineMark): TLMDDebugFrameKind;
begin
  result := GetDebugFrameMark(self, AFrameMark).GetDebugFrameKind;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.FindNearWordStart(AOffset, AMaxCount: Integer;
                                            ABackward, AAllowOffset: Boolean;
                                            const ASeparators: TLMDString): Integer;
var
  Pos, PosN, MaxPos: Integer;
  Sep: TLMDString;
begin
  if AMaxCount=-1 then
    AMaxCount := MAXINT div 2;

  Sep := GetSep(ASeparators);

  Assert(AMaxCount >= 0);
  if (AMaxCount=0) or (Length(Sep)=0) then
  begin
    Result := -1;
    Exit;
  end;

  CheckSearchOffset(AOffset);

  if ABackward then
  begin
    AMaxCount := Min(AMaxCount, AOffset+1);
    MaxPos := AOffset - AMaxCount;
  end
  else
  begin
    AMaxCount := Min(AMaxCount, CharsCount-AOffset);
    MaxPos := AOffset + AMaxCount;
  end;

  if AOffset <> CharsCount then
    Pos := LMDSeqPosOneOfGen(Sep, Chars, AOffset, AMaxCount, ABackward, True)
  else if CharsCount > 0 then
    Pos := LMDSeqPosOneOfGen(Sep, Chars, AOffset-1, AMaxCount-1, ABackward, True)
  else
    Pos := -1;

  if Pos <> -1 then
  begin
    if ABackward then
    begin
      PosN := LMDSeqPosOneOfGen(Sep, Chars, Pos, Pos-MaxPos, True, False);

      if PosN<>-1 then
        Pos := PosN+1
      else if AMaxCount>1 then
        Pos := MaxPos+1;

      if (Pos=AOffset) and (not AAllowOffset) then
      begin
        Dec(Pos);
        Pos := FindNearWordStart(Pos, Pos-MaxPos, True, False, Sep)
      end;
    end
    else
    begin
      if Pos=AOffset then
      begin
        PosN := LMDSeqPosOneOfGen(Sep, Chars, Pos, MaxPos-Pos, False, False);

        if PosN=-1 then
          Pos := -1
        else
          Pos := LMDSeqPosOneOfGen(Sep, Chars, PosN, MaxPos-PosN, False, True);
      end;
    end;
  end;

  Result := Pos;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.FindNextWordStart(AOffset, AMaxCount: Integer; const ASeparators: TLMDString): Integer;
begin
  Result := FindNearWordStart(AOffset, AMaxCount, False, False, ASeparators);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.FindPrevWordStart(AOffset, AMaxCount: Integer; const ASeparators: TLMDString): Integer;
begin
  Result := FindNearWordStart(AOffset, AMaxCount, True, False, ASeparators);
end;

{------------------------------------------------------------------------------}

function  TLMDEditDocument.FindNextWordEnd(AOffset, AMaxCount: Integer; const ASeparators: TLMDString): Integer;
begin
  Result := FindNearWordEnd(AOffset, AMaxCount, false, false, ASeparators);
end;

{------------------------------------------------------------------------------}

function  TLMDEditDocument.FindPrevWordEnd(AOffset, AMaxCount: Integer; const ASeparators: TLMDString): Integer;
begin
  Result := FindNearWordEnd(AOffset, AMaxCount, true, false, ASeparators);
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.FindNearWord(AOffset, AMaxCount: Integer;
                                       ABackward: Boolean;
                                       const ASeparators: TLMDString): TLMDSegment;
var
  Pos: Integer;
  Sep: TLMDString;
begin
  CheckSearchOffset(AOffset);

  Sep := GetSep(ASeparators);

  Result.Start := FindNearWordStart(AOffset, AMaxCount, ABackward, True, Sep);
  if Result.Start=-1 then
    Result := LMDBadSegment
  else
  begin
    Pos := LMDSeqPosOneOf(Sep, Chars, Result.Start);
    if Pos = -1 then
      Pos := CharsCount;

    Result.Count := Pos - Result.Start;
    Result.Source := Chars;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.FindNextWord(AOffset, AMaxCount: Integer; const ASeparators: TLMDString): TLMDSegment;
begin
  Result := FindNearWord(AOffset, AMaxCount, False, ASeparators);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.FindPatternClose(AState: TLMDEditFindReplaceState);
begin
  AState.Free;
end;

function TLMDEditDocument.FindPatternFirst(AOffset, AMaxCount: Integer;
                                           const APattern: TLMDString;
                                           AOpts: TLMDEditSearchOptions;
                                           ADirection: TLMDEditSearchDirection):
                                           TLMDEditFindReplaceState;
var
  State: TLMDEditFindReplaceState;
begin
  State := MakeFindState(AOffset, AMaxCount, APattern, AOpts, ADirection, Self);
  try
    if not FindPatternNextLow(-1, State, true) then
      FreeAndNil(State);
  except
    on E: Exception do
    begin
      FreeAndNil(State);
      Raise;
    end;
  end;

  Result := State;
end;

function TLMDEditDocument.FindPatternNext(AState: TLMDEditFindReplaceState): Boolean;
begin
  Result := FindPatternNext(-1, AState);
end;

function TLMDEditDocument.FindPatternNext(ANewStart: Integer;
                                          AState: TLMDEditFindReplaceState): Boolean;
begin
  Result := FindPatternNextLow(ANewStart, AState, false);
end;

function TLMDEditDocument.FindPatternNextLow(ANewStart: Integer;
                                             AState: TLMDEditFindReplaceState;
                                             AFirstTime: Boolean): Boolean;
var
  Text, WS: TLMDString;

  Re: TLMDRegExp;
  FoundLn: Integer;
  L, R: TLMDChar;
  NewPos: Integer;
  EndPos: Integer;

  Offset: Integer;
  OldOff: Integer;
begin
  Result := false;

  if (AState = nil) or (AState.Pattern = '') then
    Exit;

  if ANewStart = -1 then
  begin
    if AState.Direction = sdBackward then
      Offset := AState.FoundSegment.Start
    else
      Offset := LMDSegEnd(AState.FoundSegment) + 1
  end
  else
    Offset := LMDMinMax(ANewStart, 0, CharsCount);

  WS := GetFullWordSeparators;
  Text := AState.Pattern;

  EndPos := AState.EndM.Pos;
  repeat
    if soRegexp in AState.Options then
    begin
      Re := AState.FoundRegex;
      Re.InputSource.ResetBuffer;//for case when text was changed before this func call

      Re.ModifierS := false;
      Re.Expression := Text;

      if AState.Direction = sdBackward then
      begin
        if Re.Exec(EndPos, Offset-EndPos) and
           ((Re.MatchPos[0] + Re.MatchLen[0]) <= Offset)
        then
        begin
          NewPos := Re.MatchPos[0];
          FoundLn := Re.MatchLen[0];

          while Re.ExecNext do
          begin
            if (Re.MatchPos[0] + Re.MatchLen[0]) < Offset then
            begin
              NewPos := Re.MatchPos[0];
              FoundLn := Re.MatchLen[0];
            end
            else
              Break;
          end;

          //Restore the groups found in last succesful search
          Re.Exec(NewPos, FoundLn);

          Offset := NewPos;
        end
        else
        begin
          Offset := -1;
          FoundLn := 0;
        end;
      end
      else
      begin
        if Re.Exec(Offset, EndPos-Offset) then
        begin
          OldOff := Offset;

          Offset := Re.MatchPos[0];
          FoundLn := Re.MatchLen[0];

          if (FoundLn = 0) and (OldOff = Offset) and (not AFirstTime)  then
          begin
            if Offset = Chars.Count then
            begin
              Offset := -1;
              FoundLn := 0;
            end
            else
            begin
              if (Chars[Offset] = LMDCR) and
                 (Offset < Chars.Count - 1) and
                 (Chars[Offset + 1] = LMDLF)
              then
                Inc(Offset, 2)
              else
                Inc(Offset, 1);

              if Re.Exec(Offset, EndPos-Offset) then
              begin
                Offset := Re.MatchPos[0];
                FoundLn := Re.MatchLen[0];
              end
              else
              begin
                Offset := -1;
                FoundLn := 0;
              end;
            end;
          end;
        end
        else
        begin
          Offset := -1;
          FoundLn := 0;
        end;
      end;
    end
    else
    begin
      FoundLn := Length(Text);

      if AState.Direction = sdForward then
      begin
        if soCaseSensitive in AState.Options then
          Offset := LMDSeqPos(Text, Chars, Offset, EndPos-Offset)
        else
          Offset := LMDSeqPosCI(Text, Chars, Offset, EndPos-Offset);
      end
      else
      begin
        if soCaseSensitive in AState.Options then
          Offset := LMDSeqPosBack(Text, Chars, Offset-1, Offset-EndPos-1)
        else
          Offset := LMDSeqPosBackCI(Text, Chars, Offset-1, Offset-EndPos-1);
      end;
    end;

    if Offset<>-1 then
    begin
      if Offset > 0 then
        L := Chars[Offset-1]
      else
        L := ' ';

      if (Offset + FoundLn) < CharsCount-1 then
        R := Chars[Offset + FoundLn]
      else
        R := ' ';

      if (not (soWholeWords in AState.Options)) or
         ( (soWholeWords in AState.Options) and
           (Pos(L, WS) > 0) and
           (Pos(R, WS) > 0))
      then
        Break
      else if AState.Direction=sdForward then
        Offset := Offset + FoundLn
      else
        Offset := Offset - 1;

      if AState.Direction=sdForward then
      begin
        if Offset > EndPos then
          Offset := -1;
      end
      else
      begin
        if Offset < EndPos then
          Offset := -1;
      end;
    end;
  until Offset = -1;

  Result := Offset <> -1;

  if Result then
    AState.FoundSegment := LMDSegment(Offset, FoundLn, Chars);
end;

function TLMDEditDocument.FindPatternFirst(AOffset: Integer;
                                           const APattern: TLMDString):
                                           TLMDEditFindReplaceState;
begin
  Result := FindPatternFirst(AOffset, APattern, []);
end;

function TLMDEditDocument.FindPatternFirst(AOffset: Integer;
                                           const APattern: TLMDString;
                                           AOpts: TLMDEditSearchOptions):
                                           TLMDEditFindReplaceState;
begin
  Result := FindPatternFirst(AOffset, -1, APattern, AOpts);
end;

function TLMDEditDocument.FindPatternFirst(AOffset, AMaxCount: Integer;
                                           const APattern: TLMDString;
                                           AOpts: TLMDEditSearchOptions):
                                           TLMDEditFindReplaceState;
begin
  Result := FindPatternFirst(AOffset, AMaxCount, APattern, AOpts, sdForward);
end;

function TLMDEditDocument.FindPrevWord(AOffset, AMaxCount: Integer; const ASeparators: TLMDString): TLMDSegment;
begin
  Result := FindNearWord(AOffset, AMaxCount, True, ASeparators);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.Undo;
var
  dummy: TLMDDocUndoInfo;
begin
  CheckReadOnly;
  CheckChangesLock;

  UndoLow(-1, nil, dummy);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetUndoCountNoMod;
begin
  FUndoCountNoMod := TUndoManager(FUndoManager).UndoCount;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetUndoLimit(ALimit: Integer);
var
    OldCnt, NewCnt: Integer;
    oldMod: Boolean;
begin
  CheckNotUpdating;
  CheckChangesLock;

  BeginUpdate;
  try
    OldCnt := TUndoManager(FUndoManager).UndoCount;

    TUndoManager(FUndoManager).SetLimit(ALimit);

    NewCnt := TUndoManager(FUndoManager).UndoCount;

    oldMod := GetModified;
    FModifiedFixed := FModifiedFixed or (NewCnt < OldCnt);

    if oldMod<>GetModified then
      Include(FChanges, dcModifiedPropertyChanged);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.GetUndoLimit: Integer;
begin
  Result := TUndoManager(FUndoManager).FLimit;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetWordSeparators(const ASep: TLMDString);
var
  i: Integer;
  S: TLMDString;
begin
  if FWordSeparators=ASep then
    Exit;

  FireBeforeSettingsRefresh;

  try
    FWordSeparators := ASep;
    FFullWordSeparators := ASep;

    S := LMDAllLineSeparators;
    S := S+LMDSpace;
    S := S+LMDTab;

    for i := 1 to Length(S) do
      if LMDPosEx(S[i], FFullWordSeparators, 1)=0 then
        FFullWordSeparators := FFullWordSeparators + S[i];

    RefreshWithSettings;
  finally
    FireAfterSettingsRefresh;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetLineSeparator(ASep: TLMDLineSeparator);
begin
  if FLineSeparator=ASep then
    Exit;

  FireBeforeSettingsRefresh;
  try
    FLineSeparator := ASep;
    case FLineSeparator of
      lsCR: FLineSeparatorStr := LMDCR;
      lsLF: FLineSeparatorStr := LMDLF;
      lsCRLF: FLineSeparatorStr := LMDCRLF;
    end;

    RefreshWithSettings;
  finally
    FireAfterSettingsRefresh;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetModified(const Value: Boolean);
var
    oldMod: Boolean;
begin
  BeginUpdate;
  try
    oldMod := GetModified;

    if Value then
      FModified := true
    else
      ResetModified;

    if oldMod<>GetModified then
      Include(FChanges, dcModifiedPropertyChanged);
  finally
    EndUpdate(true);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetModifiedByChange;
var
  oldMod: Boolean;
begin
  oldMod := GetModified;

  FModified := true;

  if (not FInUndo) and (not InsideCompoundEdit) then
    SetModFixed;

  if oldMod<>GetModified then
    Include(FChanges, dcModifiedPropertyChanged);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetModifiedByUndoRedo;
var
    oldMod: Boolean;
begin
  Assert(not InsideCompoundEdit);

  oldMod := GetModified;
  FModified := TUndoManager(FUndoManager).UndoCount <> FUndoCountNoMod;

  if oldMod<>GetModified then
    Include(FChanges, dcModifiedPropertyChanged);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetDebugFrameKind(const AFrameMark: ILMDLineMark;
  AKind: TLMDDebugFrameKind);
begin
  GetDebugFrameMark(self, AFrameMark).SetStackFrameKind(AKind);
end;

procedure TLMDEditDocument.SetSyntaxSchemes(ASchemes: TLMDEditParserSchemeCollection);
begin
  if FSyntaxSchemes<>ASchemes then
    FSyntaxSchemes.Assign(ASchemes);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetCodePage(const Value: TLMDCodePageRef);
var
    NewEnc: TLMDEncoding;
begin
  BeginUpdate;

  try
    if Value<>GetCodePage then
    begin
      NewEnc := TLMDEncoding.GetEncoding(Value);
      FEncoding.Free;
      FEncoding := NewEnc;

      Include(FChanges, dcCodePagePropsChanged);
    end;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetCodePageName(const Value: string);
var
    NewEnc: TLMDEncoding;
begin
  if Value<>GetCodePageName then
  begin
    NewEnc := TLMDEncoding.GetEncoding(Value);
    FEncoding.Free;
    FEncoding := NewEnc;
  end;
end;

procedure TLMDEditDocument.SetCodePageUsePreamble(const Value: Boolean);
begin
  BeginUpdate;
  try
    if Value<>FCodePageUsePreamble then
      Include(FChanges, dcCodePagePropsChanged);

    FCodePageUsePreamble := Value;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetColorSchemes(ASchemes: TLMDEditParserSchemeCollection);
begin
  if FColorSchemes<>ASchemes then
    FColorSchemes.Assign(ASchemes);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.UpdateActiveSchemes;
begin
  if (FColorScheme='') or (FSyntaxScheme='') then
  begin
    FireBeforeSettingsRefresh;

    try
      TLMDEditParser(FParser).UnloadSchemes;
      FParser.Refresh;
    finally
      FireAfterSettingsRefresh;
    end;
  end
  else
  begin
    FireBeforeSettingsRefresh;

    try
      try
        TLMDEditParser(FParser).LoadSchemeDoc(FSyntaxScheme, FColorScheme);
      except
        on E: ELMDSyntaxSchemeLoadError do
        begin
          TLMDEditParser(FParser).UnloadSchemes;
          FSyntaxScheme := '';

          if not (csLoading in ComponentState) then
            raise;
        end;

        on E: ELMDColorSchemeLoadError do
        begin
          TLMDEditParser(FParser).UnloadSchemes;
          FColorScheme := '';

          if not (csLoading in ComponentState) then
            raise;
        end;
      end;

      FParser.Refresh;
    finally
      FireAfterSettingsRefresh;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.AddListener(const ALst: TLMDDocumentListener);
begin
  CheckNotUpdating;

  if FCustomListeners.IndexOf(ALst)=-1 then
    FCustomListeners.Add(ALst);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.AllSchemesChanged;
begin
  if FSyntaxSchemes.FindItem(FSyntaxScheme)=nil then
    FSyntaxScheme := '';

  if FColorSchemes.FindItem(FColorScheme)=nil then
    FColorScheme := '';

  UpdateActiveSchemes;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SaveToFile(const AFileName: TLMDString;
                                      ACodePage: Integer;
                                      AUsePreamble: Boolean);
var
    Stream: TStream;
begin
  Stream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(Stream, ACodePage, AUsePreamble);
  finally
    Stream.Free;
  end;
end;

procedure TLMDEditDocument.SaveToFile(const AFileName: TLMDString);
begin
  SaveToFile(AFileName, CodePage);
end;

procedure TLMDEditDocument.SaveToFile(const AFileName: TLMDString;
                                      ACodePage: Integer);
begin
  SaveToFile(AFileName, ACodePage, CodePageUsePreamble);
end;

procedure TLMDEditDocument.SaveToStream(AStream: TStream);
begin
  SaveToStream(AStream, CodePage, CodePageUsePreamble);
end;

procedure TLMDEditDocument.SaveToStream(AStream: TStream; ACodePage: Integer;
                                        AUsePreamble: Boolean);
var
    Arr: TLMDWideCharArray;
    Line: TLMDString;
    LineW: WideString;
    i, j: Integer;
    Seg: TLMDSegment;
    Enc: TLMDEncoding;
begin
  BeginUpdate;
  try
    if ACodePage=FEncoding.CodePage then
    begin
      Assert(CodePage=FEncoding.CodePage);
      Enc := FEncoding;
    end
    else
      Enc := TLMDEncoding.GetEncoding(ACodePage);

    try
      for i := 0 to LinesCount - 1 do
      begin
        Seg := GetLineWithCr(i);
        Line := LMDSegToString(Seg);
        LineW := Line;
        SetLength(Arr, Length(LineW));
        for j:=1 to Length(LineW) do
          Arr[j-1] := LineW[j];

        Enc.WriteStream(Arr, AStream, (i=0) and AUsePreamble);
      end;

      ResetModified;
      SetUndoCountNoMod;
      TUndoManager(FUndoManager).SetTopUndoCantMerge;
    finally
      if Enc<>FEncoding then
        Enc.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TLMDEditDocument.SaveToStream(AStream: TStream; ACodePage: Integer);
begin
  SaveToStream(AStream, ACodePage, CodePageUsePreamble);
end;

procedure TLMDEditDocument.SchemeChanged(AScheme: TLMDEditParserSchemeCollectionItem);
begin
  UpdateActiveSchemes;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetActiveSyntaxScheme(ASchemeName: TLMDSyntaxSchemeRef);
begin
  if FSyntaxScheme<>ASchemeName then
  begin
    CheckSyntaxSchemeName(ASchemeName);

    FSyntaxScheme := ASchemeName;

    UpdateActiveSchemes;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetActiveColorScheme(ASchemeName: TLMDColorSchemeRef);
begin
  if FColorScheme<>ASchemeName then
  begin
    CheckColorSchemeName(ASchemeName);

    FColorScheme := ASchemeName;

    UpdateActiveSchemes;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetLines(ALines: TLMDStrings);
begin
  CheckReadOnly;
  CheckChangesLock;
  CheckNotUpdating;

  if ALines <> FLines then
    FLines.Assign(ALines);
end;

{------------------------------------------------------------------------------}

function  TLMDEditDocument.GetMaxLineLengthToParse: Integer;
begin
  Result := FParser.MaxLineLengthToParse;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.SetMaxLineLengthToParse(AValue: Integer);
begin
  FireBeforeSettingsRefresh;

  FParser.SetMaxLineLengthToParse(AValue);

  FireAfterSettingsRefresh;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.StorageBeforeRefresh;
begin
  TUndoManager(FUndoManager).Clear;

  TMarkManager(FMarkManager).ClearAllMarks;
  FireBeforeRefresh;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.StorageAfterRefresh;
begin
  ResetModified;

  TLineManager(FLineManager).Refresh;
  FParser.Refresh;
  FireAfterRefresh;
end;

{------------------------------------------------------------------------------}

function TLMDEditDocument.IsWordSeparatorsStored: Boolean;
begin
  Result := (FWordSeparators <> LMDDefaultWordSeparators);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditDocument.RefreshWithSettings;
begin
  FParser.Refresh;
end;

{------------------------------------------------------------------------------}

function LMDDefaultWordSeparators: TLMDString;
begin
  Result := '[]()<>{};.,''"#@&*!^:-+=/\~`%|';
end;

{------------------------------------------------------------------------------}

function LMDAllLineSeparators: TLMDString;
begin
  Result := LMDCR;
  Result := Result + LMDLF;
  Result := Result + LMDFF;
end;

{**************************** TLMDDocumentListener ****************************}
{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.BeforeRefresh;
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.AfterRefresh;
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.BeforeSettingsRefresh;
begin

end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.AfterSettingsRefresh;
begin

end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.MarksDeleting(AMarkers: ILMDMarkers;
                                             const AMarks: TLMDMarkArray);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.MarkCreated(AMarkers: ILMDMarkers;
                                           const AMark: ILMDMark);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.MarkSettingsChanged(AMarkers: ILMDMarkers;
                                                   const AMark: ILMDMark);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.BeforeInsert(AStart, ALength: Integer);
begin

end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.BeforeMarkChange;
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.AfterInsert(AStart, ALength: Integer);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.AfterMarkChange;
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.BeforeDelete(AStart, ALength: Integer);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.AfterDelete(AStart, ALength: Integer);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.BeforeCompoundEdit(AFreezeOnCompoundEdit: Boolean);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.AfterCompoundEdit(AFreezeOnCompoundEdit: Boolean);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.DocumentDestroing;
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDDocumentListener.DoUserEventAfterDocChange;
begin
end;

{*************************** TLMDEditParserBase *****************************}
{------------------------------------------------------------------------------}

constructor TLMDEditParserBase.Create;
begin
  inherited;
  FDoc := nil;
  FMaxLineLengthToParse := MAX_LINE_LENGTH_TO_PARSE;
end;

{------------------------------------------------------------------------------}

destructor TLMDEditParserBase.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDEditParserBase.GetDocument: TLMDEditDocument;
begin
  Result := FDoc;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserBase.SetDocument(ADoc: TLMDEditDocument);
begin
  FDoc := ADoc;
end;

{------------------------------------------------------------------------------}

function TLMDEditParserBase.GetFoldLevel(ALine: Integer): Integer;
begin
  Result := 0;
end;

{------------------------------------------------------------------------------}

function TLMDEditParserBase.GetParentLine(ALine: Integer): Integer;
begin
  Result := -1;
end;

function TLMDEditParserBase.GetAllTokenIDs(const ATokenName: TLMDString): TLMDIntArray;
begin
  SetLength(Result, 0);
end;

{------------------------------------------------------------------------------}

function TLMDEditParserBase.GetFoldEnd(ALineStart: Integer): Integer;
begin
  Result := -1;
end;

{------------------------------------------------------------------------------}

function TLMDEditParserBase.GetFoldStart(ALineEnd: Integer): Integer;
begin
  Result := -1;
end;

{------------------------------------------------------------------------------}

function TLMDEditParserBase.IsFoldStart(ALine: Integer): Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}

function TLMDEditParserBase.IsFoldEnd(ALine: Integer): Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserBase.SetMaxLineLengthToParse(AValue: Integer);
begin
  FMaxLineLengthToParse := AValue;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserBase.EnsureLineParsed(ALine: Integer);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserBase.Refresh;
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserBase.MarkTokens(ALine: Integer;
                                        const AHandler: TLMDTokenHandler);
var
  Attrs: TLMDEditAttributes;
begin
  Attrs.AttributesSet := [];
  AHandler.HandleToken(FDoc.LineSegments[ALine], 0, Attrs);
end;

{------------------------------------------------------------------------------}

function TLMDEditParserBase.GetParsedLine(ALine: Integer): TLMDEditParsedLine;
begin
  Result := nil;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserBase.LineChanged(ALine: Integer);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDEditParserBase.LinesChangedFrom(AStart: Integer);
begin
end;

{------------------------------------------------------------------------------}

{$IFDEF LMDDEBUGTRACE}

initialization
  {$I C3.INC}
{$ENDIF}

{ TLMDEditFindReplaceState }

constructor TLMDEditFindReplaceState.Create;
begin
  inherited;
end;

destructor TLMDEditFindReplaceState.Destroy;
begin
  FoundRegex.Free;
  Internal.Free;

  inherited;
end;

{ TRegexSource }

procedure TLMDRegexCharSeqSource.FillBuffer;
var
  i: Integer;
begin
  for i := FBufferStart to FBufferEnd-1 do
    FBuffer[i - FBufferStart] := Integer(FSeq[i]);
end;

procedure TLMDRegexCharSeqSource.ResetBuffer;
begin
  FIdxStart := 0;
  BaseIndex := FIdxStart;
  Count := FSeq.Count;
  FIdxEnd := Count;

  inherited;
end;

{------------------------------------------------------------------------------}

constructor TLMDRegexCharSeqSource.Create(const ASeq: TLMDCharSeq);
begin
  inherited Create(256, ASeq.Count);
  FSeq := ASeq;

  ResetBuffer;
end;

{ TSearchInternal }

destructor TSearchInternal.Destroy;
begin
  ReSrc.Free;

  if Markers<>nil then
  begin
    Markers.Clear;
    Doc.DetachCustomMarkers(Markers);
    Markers := nil;
  end;

  inherited;
end;

end.
