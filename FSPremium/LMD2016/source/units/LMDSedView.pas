unit LMDSedView;
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

LMDSedView unit (VT)
---------------------
This unit contains the editor view related classes for LMD-Tools Syntax Edit
packages.

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Controls, SysUtils, StdCtrls, ExtCtrls,
  Graphics, RichEdit, ImgList, ComCtrls, Contnrs, Types, Forms, intfLMDBase,
  ActiveX, ComObj, LMDArrayUtils, LMDStrings, LMDTypes, LMDProcs,
  LMDSedDocument, LMDSedUtils, LMDHashTable, LMDPrinter, ActnList, Variants;

const
  LMDSED_CLIPBOARD_FORMAT = 'LMD Syntax Editor Control Block Type';
  MAX_SCROLL: Integer     = 32767;
  MAX_HORIZ_SCROLL = 500;
  STORED_VIEW_DOC_LIMIT = 100;
  SCROLL_TIMER_BASE = 100;
  MAX_TAB_WIDTH = 200;

  COMPLETION_TIMEOUT  = 500;
  COMPLETION_TIMEOUT_USE  = true;
  COMPLETION_MINCHARS = 3;
  COMPLETION_CASESENS = false;
  COMPLETION_NOCOMBO_ONLY = true;
  COMPLETION_ITEM_HEIGHT = 16;
  DEFAULT_HIGHLIGHT_BG = clYellow;//[asBackgroundColor]
  DEFAULT_HIGHLIGHT_TEXT = clBlack;//[asBackgroundColor]

type

  ELMDEditViewError = class(Exception);

  TLMDCustomEditView  = class;

  {******************************* TLMDEditCommand ****************************}

  TLMDEditCommandMode = (cmForView, cmForCompletion, cmForIncSearch);
  TLMDEditCommandModes = set of TLMDEditCommandMode;

  TLMDEditCommand =
  (
    sedLeft,
    sedRight,
    sedUp,
    sedDown,
    sedLineHome,
    sedLineEnd,
    sedNextWord,
    sedPrevWord,
    sedPageUp,
    sedPageDown,
    sedPageHome,
    sedPageEnd,
    sedTextHome,
    sedTextEnd,

    sedUndo,
    sedRedo,
    sedCut,
    sedCopy,
    sedPaste,
    sedDeletePrevChar,
    sedDeleteChar,
    sedDeletePrevWord,
    sedDeleteWord,
    sedDeleteLine,
    sedDeleteToLineEnd,
    sedDeleteToLineWrap,

    sedChar,
    sedStr,

    sedNewLine,
    sedTab,
    sedIndent,
    sedUnIndent,
    sedIndentToPrevIndent,
    sedUnIndentToPrevIndent,
    sedBackspaceOrUnindent,
    sedTabOrIndent,

    sedScrollUp,
    sedScrollDown,

    sedSelectLeft,
    sedSelectRight,
    sedSelectPrevWord,
    sedSelectNextWord,
    sedSelectUp,
    sedSelectDown,
    sedSelectPageUp,
    sedSelectPageDown,
    sedSelectPageHome,
    sedSelectPageEnd,
    sedSelectLineHome,
    sedSelectLineEnd,
    sedSelectTextHome,
    sedSelectTextEnd,

    sedSelectLeftBlock,
    sedSelectRightBlock,
    sedSelectPrevWordBlock,
    sedSelectNextWordBlock,
    sedSelectUpBlock,
    sedSelectDownBlock,
    sedSelectPageUpBlock,
    sedSelectPageDownBlock,
    sedSelectPageHomeBlock,
    sedSelectPageEndBlock,
    sedSelectLineHomeBlock,
    sedSelectLineEndBlock,
    sedSelectTextHomeBlock,
    sedSelectTextEndBlock,

    sedSelectAll,
    sedSelectNone,

    sedToggleOverwrite,

    sedCompletionShow,

    sedCompletionUp,
    sedCompletionDown,
    sedCompletionCommit,
    sedCompletionCancel,
    sedCompletionBack,
    sedCompletionLeft,
    sedCompletionRight,
    sedCompletionPgUp,
    sedCompletionPgDown,
    sedCompletionHome,
    sedCompletionEnd,

    sedIncrementalSearchStart,
    sedIncrementalSearchAddChar,
    sedIncrementalSearchBack,
    sedIncrementalSearchForward,
    sedIncrementalSearchCancel
  );

  TLMDEditCommandItem = class;
  TLMDEditCommandList = class;

  {************************ TLMDEditCommandBinding ****************************}

  TLMDEditCommandBinding  = class(TCollectionItem)
  private
    FShortcut: TShortCut;
    FShortcut2: TShortCut;

    procedure CheckShortcuts(AShortcut, AShortcut2: TShortCut;
                             AModes: TLMDEditCommandModes);

    procedure SetShortcut(AShortcut: TShortCut);
    procedure SetShortcut2(AShortcut: TShortCut);
    function  GetParentItem: TLMDEditCommandItem;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;

    property ParentItem: TLMDEditCommandItem read GetParentItem;
  published
    property Shortcut: TShortcut read FShortcut write SetShortcut;
    property Shortcut2: TShortcut read FShortcut2 write SetShortcut2;
  end;

  {************************ TLMDEditCommandBindings ***************************}

  TLMDEditCommandBindings = class(TCollection)
  private
    FParentItem: TLMDEditCommandItem;

    function  GetItem(Index: Integer): TLMDEditCommandBinding;
    procedure SetItem(Index: Integer; Value: TLMDEditCommandBinding);
  protected
    function  GetOwner: TPersistent; override;
  public
    constructor Create(AParentItem: TLMDEditCommandItem);

    function Add: TLMDEditCommandBinding;

    property Items[Index: Integer]: TLMDEditCommandBinding read GetItem write SetItem; default;
  end;

  {************************ TLMDEditCommandItem *******************************}

  TLMDEditCommandItem = class(TCollectionItem)
  private
    FBindings: TLMDEditCommandBindings;
    FEditable: Boolean;
    FModes: TLMDEditCommandModes;

    FCommand: TLMDEditCommand;

    procedure SetCommand(ACommand: TLMDEditCommand);

    procedure SetBindings(ABindings: TLMDEditCommandBindings);
    function GetDescription: TLMDString;
    function GetCategory: TLMDString;
    function Parent: TLMDEditCommandList;

  public
    constructor Create(Collection: TCollection); override;
    destructor  Destroy; override;
    procedure   Assign(Source: TPersistent); override;

  published
    property Bindings: TLMDEditCommandBindings read FBindings write SetBindings;
    property Command: TLMDEditCommand read FCommand write SetCommand;
    property Description: TLMDString read GetDescription;
    property Category: TLMDString read GetCategory;

    property Editable: Boolean read FEditable write FEditable;
    property Modes: TLMDEditCommandModes read FModes write FModes;
  end;

  {************************ TLMDEditCommandList *******************************}


  TLMDEditCommandList = class(TCollection)
  private
    FParent: TLMDCustomEditView;

    function  GetItem(Index: Integer): TLMDEditCommandItem;
    procedure SetItem(Index: Integer; Value: TLMDEditCommandItem);

    procedure CheckBindingSet(ABind: TLMDEditCommandBinding;
                              AShortcut, AShortcut2: TShortcut;
                              AModes: TLMDEditCommandModes);

    procedure CheckCommandSet(AItem: TLMDEditCommandItem;
                              ACommand: TLMDEditCommand);
  protected
    function  GetOwner: TPersistent; override;
  public
    constructor Create(AParent: TLMDCustomEditView);

    function FindBinding(AKey: word; AShiftState: TShiftState;
                         AKey2: word; AShiftState2: TShiftState;
                         AModes: TLMDEditCommandModes):
                         TLMDEditCommandBinding; overload;

    function FindBinding(AShortcut, AShortcut2: TShortCut;
                         AModes: TLMDEditCommandModes):
                         TLMDEditCommandBinding; overload;

    function FindBinding(AKey: word; AShiftState: TShiftState;
                         AModes: TLMDEditCommandModes):
                         TLMDEditCommandBinding; overload;

    function FindBinding(AShortcut: TShortCut;
                         AModes: TLMDEditCommandModes):
                         TLMDEditCommandBinding; overload;

    function FindCommand(ACmd: TLMDEditCommand): TLMDEditCommandItem;

    function Add: TLMDEditCommandItem;
    property Items[Index: Integer]: TLMDEditCommandItem read GetItem write SetItem; default;

    property Parent: TLMDCustomEditView read FParent;
  end;

  {****************************** General types *******************************}

  TLMDViewSetting = (vsShowWrapRuler,
                     vsHideShowScrollbars,
                     vsOverwrite,
                     vsUseTabs,
                     vsHighlightSelectedLine,
                     vsAutoIndent,
                     vsKeepBlanks,
                     vsCursorBoundToChars,
                     vsRightClickMovesCursor,
                     vsBackspaceUnindents,
                     vsDragDropEditing,
                     vsPreciseScrollbars);

  TLMDViewCompletionType = (ctDocumentText,
                            ctCustom,
                            ctCustomOwnerDrawFixed,
                            ctCustomOwnerDrawVariable,
                            ctDisabled);

  TLMDViewSettings = set of TLMDViewSetting;

  TLMDViewWrapMode = (wmNoWrap, wmWrapToRuler, wmWrapToWindow);

  TLMDViewStatusChange = (scCursor, scSelection,
                          scFont, scViewSettings,
                          scGutterSettings,
                          scHScroll, scVScroll,
                          scScreenSize, scWrapSettings,
                          scFolds);

  TLMDViewStatusChanges = set of TLMDViewStatusChange;

  TLMDViewStatusChangeEvent = procedure(AView: TLMDCustomEditView;
                                        AChanges: TLMDViewStatusChanges) of object;

  TLMDEditInternalState = (siWaitDrag, siDoubleClicked, siScrolling,
                           siMouseSelectByWords, siMouseSelectByLines,
                           siScrollbarsUpdating,
                           siComplWordTyping,
                           siComplListShown,
                           siComplTimer,
                           siIncrementalSearch,
                           siDestroing,
                           siPainting,
                           siScrollforceAvoidAdges);

  TLMDEditInternalStates =  set of TLMDEditInternalState;
  TLMDEditScreenMarks    = array of TLMDMarkArray;

  {****************************** TLMDSpecialChars ****************************}

  TLMDSpecialCharKind = (skTabTail, skTabHead, skSpace, skCR, skLF, skCRLF,
                         skLineWrap, skFoldedLineEnd, skLineNumberBullet);
  TLMDSpecialCharKinds = set of TLMDSpecialCharKind;


  TLMDViewPartParent = class
  public
    procedure BeginChange; virtual; abstract;
    procedure EndChange(AResetCache: Boolean); virtual; abstract;
    function  GetOwnerComponent: TComponent; virtual; abstract;
  end;

  TLMDSpecialChars = class(TPersistent)
  private
    FParent:           TLMDViewPartParent;
    FCharset:          TFontCharset;
    FUseCharset:       Boolean;
    FShowChars:        array[Low(TLMDSpecialCharKind)..
                             High(TLMDSpecialCharKind)] of TLMDChar;
    FShowCharsDefault: array[Low(TLMDSpecialCharKind)..
                             High(TLMDSpecialCharKind)] of TLMDChar;
    FShowCharKinds:    TLMDSpecialCharKinds;

    procedure SetChar(AKind: TLMDSpecialCharKind; AChar: TLMDString);
    function  GetChar(AKind: TLMDSpecialCharKind): TLMDString;

    procedure SetChar_TabTail(AChar: TLMDString);
    function  GetChar_TabTail: TLMDString;
    function  IsStored_TabTail: Boolean;

    procedure SetChar_TabHead(AChar: TLMDString);
    function  GetChar_TabHead: TLMDString;
    function  IsStored_TabHead: Boolean;

    procedure SetChar_Space(AChar: TLMDString);
    function  GetChar_Space: TLMDString;
    function  IsStored_Space: Boolean;

    procedure SetChar_CR(AChar: TLMDString);
    function  GetChar_CR: TLMDString;
    function  IsStored_CR: Boolean;

    procedure SetChar_LF(AChar: TLMDString);
    function  GetChar_LF: TLMDString;
    function  IsStored_LF: Boolean;

    procedure SetChar_CRLF(AChar: TLMDString);
    function  GetChar_CRLF: TLMDString;
    function  IsStored_CRLF: Boolean;

    procedure SetChar_LineWrap(AChar: TLMDString);
    function  GetChar_LineWrap: TLMDString;
    function  IsStored_LineWrap: Boolean;

    procedure SetChar_FoldedLineEnd(AChar: TLMDString);
    function  GetChar_FoldedLineEnd: TLMDString;
    function  IsStored_FoldedLineEnd: Boolean;

    procedure SetChar_LineNumberBullet(AChar: TLMDString);
    function  GetChar_LineNumberBullet: TLMDString;
    function  IsStored_LineNumberBullet: Boolean;

    function GetDecodedChar(AKind: TLMDSpecialCharKind): TLMDChar;
    function IsStored(AKind: TLMDSpecialCharKind): Boolean;

    procedure SetShowCharKinds(AKinds: TLMDSpecialCharKinds);

    procedure SetCharSet(ACharset: TFontCharset);
    procedure SetUseCharSet(AUse: Boolean);
  protected
    function  GetOwner: TPersistent; override;
  public
    constructor Create(AParent: TLMDViewPartParent);
    procedure   Assign(Source: TPersistent); override;
  published
    property Charset: TFontCharset read FCharset write SetCharSet default ANSI_CHARSET;
    property UseCharset: Boolean read FUseCharset write SetUseCharSet default True;

    property TabTailShowChar: TLMDString read GetChar_TabTail
                                         write SetChar_TabTail
                                         stored IsStored_TabTail;

    property TabHeadShowChar: TLMDString read GetChar_TabHead
                                         write SetChar_TabHead
                                         stored IsStored_TabHead;

    property SpaceShowChar: TLMDString read GetChar_Space
                                       write SetChar_Space
                                       stored IsStored_Space;

    property CRShowChar: TLMDString read GetChar_CR
                                    write SetChar_CR
                                    stored IsStored_CR;

    property LFShowChar: TLMDString read GetChar_LF
                                    write SetChar_LF
                                    stored IsStored_LF;

    property CRLFShowChar: TLMDString read GetChar_CRLF
                                      write SetChar_CRLF
                                      stored IsStored_CRLF;

    property LineWrapShowChar: TLMDString read GetChar_LineWrap
                                          write SetChar_LineWrap
                                          stored IsStored_LineWrap;

    property FoldedLineEndShowChar: TLMDString read GetChar_FoldedLineEnd
                                               write SetChar_FoldedLineEnd
                                               stored IsStored_FoldedLineEnd;

    property LineNumberBulletChar: TLMDString read GetChar_LineNumberBullet
                                              write SetChar_LineNumberBullet
                                              stored IsStored_LineNumberBullet;

    property ShowCharKinds:  TLMDSpecialCharKinds read FShowCharKinds
                                                  write SetShowCharKinds
                                                  default [skFoldedLineEnd];
  end;

  {******************************* TLMDGutterBar ******************************}

  TLMDGutterBarKind = (gbBookmarkBar, gbBreakpointBar, gbLineNumberBar,
                       gbFoldBar, gbWrapBar, gbCustom);

  TLMDGutterBars = class;
  TLMDGutter     = class;

  TLMDGutterBar = class(TCollectionItem)
  private
    FParent:  TLMDGutterBars;
    FGutter:  TLMDGutter;
    FWidth:   Integer;
    FKind:    TLMDGutterBarKind;
    FVisible: Boolean;
    FLeftPadding: Integer;
    FRightPadding: Integer;

    procedure SetKind(Value: TLMDGutterBarKind);
    procedure SetWidth(Value: Integer);
    function  GetWidth: Integer;
    procedure SetVisible(Value: Boolean);
    procedure SetLeftPadding(Value: Integer);
    procedure SetRightPadding(const Value: Integer);
    function  GetFullWidth: Integer;
  public
    constructor Create(Collection: TCollection); override;
    procedure   Assign(Source: TPersistent); override;

    property FullWidth: Integer read GetFullWidth;
  published
    property Kind: TLMDGutterBarKind read FKind write SetKind default gbCustom;
    property Width: Integer read GetWidth write SetWidth default 14;
    property LeftPadding: Integer read FLeftPadding write SetLeftPadding default 2;
    property RightPadding: Integer read FRightPadding write SetRightPadding default 2;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  {****************************** TLMDGutterBars ******************************}

  TLMDGutterBars = class(TCollection)
  private
    FGutter: TLMDGutter;

    function  GetItem(Index: Integer): TLMDGutterBar;
    procedure SetItem(Index: Integer; Value: TLMDGutterBar);
  protected
    function  GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AParent: TLMDGutter);

    function Add: TLMDGutterBar;
    function AddItem(Item: TLMDGutterBar; Index: Integer): TLMDGutterBar;
    function Insert(Index: Integer): TLMDGutterBar;
    property Items[Index: Integer]: TLMDGutterBar read GetItem write SetItem; default;
  end;

  {********************************* TLMDGutter *******************************}

  TLMDGutterSetting = (gsPaintWrapsOnLineNumberBar);
  TLMDGutterSettings = set of TLMDGutterSetting;

  TLMDGutter = class(TPersistent)
  private
    FInConstructor:         Boolean;
    FParent:                TLMDCustomEditView;
    FBars:                  TLMDGutterBars;
    FBookmarkImg:           Graphics.TBitmap;
    FFoldPlusImg:           Graphics.TBitmap;
    FFoldMinusImg:          Graphics.TBitmap;
    FFoldEndImg:            Graphics.TBitmap;
    FBreakActiveImg:        Graphics.TBitmap;
    FBreakInactiveImg:      Graphics.TBitmap;
    FBreakDisabledImg:      Graphics.TBitmap;
    FWrapLineBarImg:        Graphics.TBitmap;
    FDebugFrameTopImg:      Graphics.TBitmap;
    FDebugFrameActiveImg:   Graphics.TBitmap;
    FDebugFrameImg:         Graphics.TBitmap;
    FBookmarksBarBg:        TColor;
    FBookmarksBarTextColor: TColor;
    FLinesBarBg:            TColor;
    FLinesBarTextColor:     TColor;
    FFoldsBarLineColor:     TColor;
    FFoldsBarBg:            TColor;
    FCustomBarBg:           TColor;
    FLineNumberingInterval: Integer;
    FSettings:              TLMDGutterSettings;

    procedure BeginUpdate;
    procedure EndUpdate;

    procedure SetBars(ABars: TLMDGutterBars);

    procedure SetBookmarksBarBg(AColor: TColor);
    procedure SetBookmarksBarTextColor(AColor: TColor);
    procedure SetLinesBarTextColor(AColor: TColor);
    procedure SetLinesBarBg(AColor: TColor);
    procedure SetLineNumberingInterval(AValue: Integer);
    procedure SetFoldsBarLineColor(AColor: TColor);
    procedure SetFoldsBarBg(AColor: TColor);
    procedure SetCustomBarBg(AColor: TColor);

    procedure SetDebugFrameTopImg(AImg: Graphics.TBitmap);
    procedure SetDebugFrameActiveImg(AImg: Graphics.TBitmap);
    procedure StackDebugFrameImg(AImg: Graphics.TBitmap);

    procedure SetBookmarkImg(AImg: Graphics.TBitmap);
    procedure SetBreakActiveImg(AImg: Graphics.TBitmap);
    procedure SetBreakInactiveImg(AImg: Graphics.TBitmap);
    procedure SetBreakDisabledImg(AImg: Graphics.TBitmap);
    procedure SetFoldPlusImg(AImg: Graphics.TBitmap);
    procedure SetFoldMinusImg(AImg: Graphics.TBitmap);
    procedure SetFoldEndImg(AImg: Graphics.TBitmap);
    procedure SetWrapLineBarImg(AImg: Graphics.TBitmap);
    procedure SetSettings(ASettings: TLMDGutterSettings);

    function  GetBreakImageForDrawing(const AProps): Graphics.TBitmap;
    function  GetBookImageForDrawing(const AMark: ILMDLineMark): Graphics.TBitmap;
    function  GetFoldImageForDrawing(AExpanded: Boolean): Graphics.TBitmap;
    function  GetWrapImageForDrawing: Graphics.TBitmap;
    function  GetDbgImageForDrawing(const AProps): Graphics.TBitmap;

    function  IsBarsStored: Boolean;
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AParent: TLMDCustomEditView);
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    function  GetWidth: Integer;
  published
    property  BookmarksBarBg: TColor read FBookmarksBarBg write SetBookmarksBarBg default 14215660; //RGB(236, 233, 216)
    property  BookmarksBarTextColor: TColor read FBookmarksBarTextColor write SetBookmarksBarTextColor default clBlack;

    property  LinesBarTextColor: TColor read FLinesBarTextColor write SetLinesBarTextColor default 13408665; //RGB(153, 153, 204)
    property  LinesBarBg: TColor read FLinesBarBg write SetLinesBarBg default 16053492;//RGB(244, 244, 244)
    property  LineNumberingInterval: Integer read FLineNumberingInterval write SetLineNumberingInterval default 10;
    property  FoldsBarLineColor: TColor read FFoldsBarLineColor write SetFoldsBarLineColor default 13408665; //RGB(153, 153, 204)
    property  FoldsBarBg: TColor read FFoldsBarBg write SetFoldsBarBg default 16053492;//RGB(244, 244, 244)
    property  CustomBarBg: TColor read FCustomBarBg write SetCustomBarBg default 16053492;//RGB(244, 244, 244)

    property  Bars: TLMDGutterBars read FBars write SetBars  stored IsBarsStored;
    property  Settings: TLMDGutterSettings read FSettings write SetSettings  default [gsPaintWrapsOnLineNumberBar];

    property BookmarkImg: Graphics.TBitmap read FBookmarkImg write SetBookmarkImg;
    property BreakActiveImg: Graphics.TBitmap read FBreakActiveImg write SetBreakActiveImg;
    property BreakInactiveImg: Graphics.TBitmap read FBreakInactiveImg write SetBreakInactiveImg;
    property BreakDisabledImg: Graphics.TBitmap read FBreakDisabledImg write SetBreakDisabledImg;
    property FoldPlusImg: Graphics.TBitmap read FFoldPlusImg write SetFoldPlusImg;
    property FoldMinusImg: Graphics.TBitmap read FFoldMinusImg write SetFoldMinusImg;
    property FoldEndImg: Graphics.TBitmap read FFoldEndImg write SetFoldEndImg;
    property WrapLineBarImg: Graphics.TBitmap read FWrapLineBarImg write SetWrapLineBarImg;
    property DebugFrameTopImg: Graphics.TBitmap read FDebugFrameTopImg write SetDebugFrameTopImg;
    property DebugFrameActiveImg: Graphics.TBitmap read FDebugFrameActiveImg write SetDebugFrameActiveImg;
    property DebugFrameImg: Graphics.TBitmap read FDebugFrameImg write StackDebugFrameImg;
  end;

  TLMDGutterClickParams = record
    ScrollLine: Integer;
    Bar:        TLMDGutterBar;
    Shift:      TShiftState;
    Button:     TMouseButton;
  end;

  TLMDGutterClickEvent = procedure(AView: TLMDCustomEditView;
                                   const AParams: TLMDGutterClickParams;
                                   var Handled: Boolean) of object;

  TLMDGutterCustomDefaultPainter = procedure(AScreenLine: Integer;
                                             ABar: TLMDGutterBar;
                                             ABarPaintKind: TLMDGutterBarKind;
                                             ACanvas: TCanvas;
                                             ARect: TRect)
                                             of object;

  TLMDGutterPaintParams = record
    ScreenLine:     Integer;
    Bar:            TLMDGutterBar;
    Canvas:         TCanvas;
    Rect:           TRect;

    DefaultPainter: TLMDGutterCustomDefaultPainter;
  end;

  TLMDGutterPaintEvent = procedure(AView: TLMDCustomEditView;
                                   const AParams: TLMDGutterPaintParams;
                                   var PaintOk: Boolean) of object;


  TLMDCursorMoveDirection = (mdForward, mdBackward);
  TLMDCursorMoveUnit      = (muLine, muChar, muWord);

  TMouseCursorEvent = procedure(Sender: TObject; const AScrollPos: TPoint;
                                var ACursor: TCursor) of object;

  TKeyPressWEvent = procedure(Sender: TObject; var Key: TLMDChar) of object;

  {***************************** View -related find/replace features ************************}

  TLMDEditViewSearchStart  = (ssCursor, ssTextStartEnd);

  TLMDEditViewSearchState = (stNothing, stInSearch, stInReplace);

  TLMDEditViewReplaceAllBounds = (rbAllText, rbSelection);

  TLMDEditNotFoundAction = (saCancel, saGoStartEnd);

  TLMDEditNotFoundEvent = procedure(Sender: TObject;
                                    var Action: TLMDEditNotFoundAction) of object;

  TLMDEditSearchArguments = record
    Search: TLMDString;
    Replace: TLMDString;

    Options: TLMDEditSearchOptions;
    Direction: TLMDEditSearchDirection;
    Start: TLMDEditViewSearchStart;
  end;

  {************************** TLMDEditViewPrintTask ***************************}

  TLMDEditViewPrintOption = (poPrintHiddenText,
                             poPrintLineNumbers,
                             poPrintSpecialChars);

  TLMDEditViewPrintOptions = set of TLMDEditViewPrintOption;

  TLMDEditViewPrintTask = class(TComponent)
  private
    FPrinter: TLMDPrinter;
    FView: TLMDCustomEditView;
    FFont: TFont;
    FUpdatetingFont: Boolean;
    FViewFont: Boolean;
    FPrintOptions: TLMDEditViewPrintOptions;
    FPagesPrepared: Boolean;
    FRenderer: TLMDPrintRendererBase;
    FPartParent: TLMDViewPartParent;
    FSpecialChars: TLMDSpecialChars;

    procedure ResetSpecChars;
    procedure SetPrintOptions(const Value: TLMDEditViewPrintOptions);
    procedure SetView(const Value: TLMDCustomEditView);
    function  IsFontStored: Boolean;
    procedure SetFont(const Value: TFont);
    procedure SetViewFont(const Value: Boolean);
    procedure SetTaskPrinter(const Value: TLMDPrinter);
    procedure InternalSetView(const Value: TLMDCustomEditView);
    procedure InternalSetPrinter(const Value: TLMDPrinter);
    procedure CheckPrinterAssigned;
    procedure CheckViewAssigned;
    procedure CheckPagesPrepared;
    procedure CheckPagesNotPrepared;
    procedure UpdateViewFont;
    procedure FontChanged(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    function  GetRenderer: TLMDPrintRendererBase;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure PreparePages;
    function  PagesCount: Integer;
    procedure FinalizePages;
    procedure Print; overload;
    procedure Print(AStart, ACount: Integer); overload;
    procedure ExecPrintPreviewDlg;
    procedure ExecPrintDlg;
  published
    property PrintOptions: TLMDEditViewPrintOptions read FPrintOptions write SetPrintOptions;
    property View: TLMDCustomEditView read FView write SetView;
    property Printer: TLMDPrinter read FPrinter write SetTaskPrinter;
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property ViewFont: Boolean read FViewFont write SetViewFont default True;
  end;

  {**************************** TLMDCustomEditView ****************************}

  TLMDEditPaintTextArgs = record
    ScreenLine: Integer;
    BgRect: TRect;
    ContentRect: TRect;
    Cache: TObject;
    Canvas: TCanvas;

    DefaultFont: TFont;
    DefaultBgColor: TColor;
    DefaultColor: TColor;

    LineHeight: Integer;

    PrintMode: Boolean;
    PrintOptions: TLMDEditViewPrintOptions;
  end;

  TLMDEditBeforeCommandEvent = procedure(Sender: TObject;
                                         var ACommand: TLMDEditCommand;
                                         var Arg: Variant;
                                         var AllowExec: Boolean) of object;

  TLMDEditAfterCommandEvent = procedure(Sender: TObject;
                                        ACommand: TLMDEditCommand;
                                        const Arg: Variant) of object;

  TLMDEditGetLineAttrsEvent = procedure(Sender: TObject;
                                        AScrollLine: Integer;
                                        var Attributes: TLMDEditAttributes;
                                        var OverrideTokens: Boolean) of object;

  TOffsetPoint = record
    Offset: Integer;
    InCharOffset: Integer;
  end;

  TLMDEditCompletionSettings = class(TPersistent)
  private
    FParent:        TLMDCustomEditView;

    procedure BeginUpdate;
    procedure EndUpdate;

    function GetMinChars: Integer;
    function GetShowTimeout: Integer;
    function GetDontShowComboForOnlyMatch: Boolean;
    function GetCaseSensitive: Boolean;
    function GetCompletionType: TLMDViewCompletionType;
    function GetItemHeight: Integer;
    function GetWordSeparators: TLMDString;
    function GetShowCompletionOnTimeout: Boolean;

    procedure SetMinChars(Value: Integer);
    procedure SetShowTimeout(Value: Integer);
    procedure SetDontShowComboForOnlyMatch(Value: Boolean);
    procedure SetCaseSensitive(Value: Boolean);
    procedure SetCompletionType(Value: TLMDViewCompletionType);
    procedure SetItemHeight(Value: Integer);
    procedure SetWordSeparators(const Value: TLMDString);
    procedure SetShowCompletionOnTimeout(Value: Boolean);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AParent: TLMDCustomEditView);

    procedure Assign(Source: TPersistent); override;
  published
    property ShowTimeout: Integer read GetShowTimeout write SetShowTimeout
                                  default COMPLETION_TIMEOUT;

    property ShowCompletionOnTimeout: Boolean read GetShowCompletionOnTimeout
                                              write SetShowCompletionOnTimeout
                                              default COMPLETION_TIMEOUT_USE;

    property MinChars: Integer read GetMinChars write SetMinChars
                               default COMPLETION_MINCHARS;

    property DontShowComboForOnlyMatch: Boolean
                                        read GetDontShowComboForOnlyMatch
                                        write SetDontShowComboForOnlyMatch
                                        default COMPLETION_NOCOMBO_ONLY;

    property CaseSensitive: Boolean
                            read GetCaseSensitive
                            write SetCaseSensitive
                            default COMPLETION_CASESENS;

    property CompletionType: TLMDViewCompletionType
                             read GetCompletionType
                             write SetCompletionType
                             default ctDocumentText;

    property ItemHeight: Integer read GetItemHeight write SetItemHeight
                                 default COMPLETION_ITEM_HEIGHT;

    property WordSeparators: TLMDString read GetWordSeparators
                                        write SetWordSeparators;
  end;

  TLMDEditFillCompletionCause = (fcForced, fcTimeout, fcWordEnd);
  TLMDEditReplaceCompletionCause = (rcCompletionList, rcWordEnd);

  TLMDEditFillCompletionListEvent = procedure(Sender: TObject;
                                              Items: TStrings;
                                              CursorPoint: TPoint;
                                              Cause: TLMDEditFillCompletionCause;
                                              const LeftPart: TLMDString;
                                              var PosForCombo: TPoint;
                                              var Handled: Boolean)
                                              of object;

  TLMDEditReplaceForCompletionResultEvent = procedure(Sender: TObject;
                                                      Items: TStrings;
                                                      ItemIndex: Integer;
                                                      CursorPoint: TPoint;
                                                      Cause: TLMDEditReplaceCompletionCause;
                                                      var Handled: Boolean)
                                                      of object;



  TLMDEditDrawCompletionItemEvent = procedure(Sender: TObject;
                                              AItems: TStrings;
                                              Index: Integer;
                                              Rect: TRect;
                                              State: TOwnerDrawState;
                                              Canvas: TCanvas) of object;

  TLMDEditMeasureCompletionItemEvent = procedure(Sender: TObject;
                                                 AItems: TStrings;
                                                 Index: Integer;
                                                 Canvas: TCanvas;
                                                 var Height: Integer) of object;

  TLMDEditScreenPart = (spText, spGutterText, spGutterPastText, spPastText);



  TLMDEditHighlightPropsSet = set of (psTextColor, psBackgroundColor, psFontStyle);

  TLMDEditHighlightSettings = class(TPersistent)
  private
    FParent:      TLMDCustomEditView;

    FHlSettings:  TLMDEditAttributes;
    FUseHl:       Boolean;
    FPropsSet:    TLMDEditHighlightPropsSet;

    procedure BeginUpdate;
    procedure EndUpdate;

    function GetBgColor:      TColor;
    function GetFontStyle:    TFontStyles;
    function GetTextColor:    TColor;
    function GetUseHighlight: Boolean;

    procedure SetBgColor(const Value: TColor);
    procedure SetFontStyle(const Value: TFontStyles);
    procedure SetPropsSet(const Value: TLMDEditHighlightPropsSet);
    procedure SetTextColor(const Value: TColor);
    procedure SetUseHighlight(const Value: Boolean);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AParent: TLMDCustomEditView);

    procedure Assign(Source: TPersistent); override;
  published
    property TextColor: TColor read GetTextColor write SetTextColor default DEFAULT_HIGHLIGHT_TEXT;
    property BackgroundColor: TColor read GetBgColor write SetBgColor default DEFAULT_HIGHLIGHT_BG;
    property FontStyle: TFontStyles read GetFontStyle write SetFontStyle default [];

    property PropsSet: TLMDEditHighlightPropsSet read FPropsSet write SetPropsSet default [psBackgroundColor];

    property UseHighlight: Boolean read GetUseHighlight write SetUseHighlight default true;
  end;

  TLMDCustomEditView = class(TCustomControl, ILMDComponent
                             {$IFDEF LMDCOMP7}, IDropTarget (*BCB6 bug*) {$ENDIF})
  private
    FAuthorID:                  Integer;
    FScreenCache:               TObject;
    FDocLst:                    TLMDDocumentListener;
    FDocInternal:               TLMDDocumentInternal;
    FDummyDoc:                  TLMDEditDocument;
    FFDoc:                      TLMDEditDocument;
    FUpdatingCnt:               Integer;
    FFullRepaint:               Boolean;
    FScreenMarksChanged:        Boolean;
    FOldGutterWidth:            Integer;
    FChangesLock:               Integer;
    FLineHeight:                Integer;
    FGutterWidth:               Integer;
    FGutter:                    TLMDGutter;
    FGutterBarsEmpty:           Boolean;
    FSpecialChars:              TLMDSpecialChars;
    FInsCaret:                  Boolean;
    FViewSettings:              TLMDViewSettings;
    FFont:                      TFont;
    FFontBold:                  TFont;
    FFontMetrics:               TTextMetric;
    FWrapRulerColor:            TColor;
    FReadOnlyBgColor:           TColor;
    FSelectedLineBg:            TColor;
    FBreakpointLineColor:       TColor;
    FBreakpointLineBg:          TColor;
    FSelectionBg:               TColor;
    FSelectionColor:            TColor;
    FTabWidth:                  Integer;
    FIndentWidth:               Integer;
    FCaretShown:                Boolean;
    FLastOffsetForUndo:         Integer;
    FCursorMaxHoriz:            Integer;
    FMaxHorizScroll:            Integer;
    FOnScroll:                  TScrollEvent;
    FOnGutterPaint:             TLMDGutterPaintEvent;
    FOnStatusChanged:           TLMDViewStatusChangeEvent;
    FStatusChanges:             TLMDViewStatusChanges;

    FDefaultCommands:           TLMDEditCommandList;
    FCustomCommands:            TLMDEditCommandList;
    FPressedShortcut:           TShortCut;
    FPressedShortcutDefault:    Boolean;

    FLineBmp:                   Graphics.TBitmap;

    ///windowing vars
    FAbout:                   TLMDAboutVar;

    //Key1: Doc offset
    //Key2: Win offset
    FCachedWin:               TLMDSedIntConversionCache;

    FMouseWheelAcc:           Integer;
    FIgnoreKeyPress:          Boolean;
    FScrollDirX:              Integer;
    FScrollDirY:              Integer;
    FScrollBarVisibleX:       Boolean;
    FScrollBarVisibleY:       Boolean;
    FScrollTimer:             TTimer;
    FScrollTimerBase:         Integer;
    FMouseDownX:              Integer;
    FMouseDownY:              Integer;
    FCursorBeforeDrag:        TOffsetPoint;
    FLastDoubleClickTime:     TDateTime;
    FSysDoubleClickTime:      TDateTime;
    FBorderStyle:             TBorderStyle;
    FScrollBars:              TScrollStyle;
    FGutterCursor:            TCursor;
    FWantReturns, FWantTabs:  Boolean;
    FOnMouseCursor:           TMouseCursorEvent;
    FOnGutterClick:           TLMDGutterClickEvent;
    FOnKeyPressW:             TKeyPressWEvent;
    FOnNotFound:              TLMDEditNotFoundEvent;
    FOnReplaceFound:          TLMDEditReplaceEvent;

    FOnBeforeCommand:         TLMDEditBeforeCommandEvent;
    FOnAfterCommand:          TLMDEditAfterCommandEvent;
    FOnGetLineAttrs:          TLMDEditGetLineAttrsEvent;

    FAddictCheckTokens:       TLMDStrings;
    FAddictCheckTokenIds:     TLMDIntArray;

    FOldPen, FOldBrush:       TPersistent;
    FDoCoUninit:              Boolean;

    FPartParent:              TLMDViewPartParent;

    FTokensBuffer:            TLMDEditParsedTokenArray;

    //Completion
    FCompletionTimer:         TTimer;
    FCompletionList:          TCustomListBox;
    FCompletionTimeout:       Integer;
    FCompletionMinChars:      Integer;
    FCompletionType:          TLMDViewCompletionType;
    FCompletionCaseSens:      Boolean;
    FCompletionMinWidth:      Integer;
    FCompletionNoComboForOnly: Boolean;
    FComplStrHash:            TLMDStringHashTable;
    FComplWordSep:            TLMDString;
    FComplUseTimeout:         Boolean;
    FCmdModesLock:            Integer;

    FComplSettings:           TLMDEditCompletionSettings;

    FComplOnFill:             TLMDEditFillCompletionListEvent;
    FComplCommit:             TLMDEditReplaceForCompletionResultEvent;
    FComplOnDraw:             TLMDEditDrawCompletionItemEvent;
    FComplOnMeasure:          TLMDEditMeasureCompletionItemEvent;

    FHighlightSettings:       TLMDEditHighlightSettings;

    FReadOnly:                Boolean;

    FLineNumScreenCursor:     HCURSOR;
    FDebugFrameTopLineColor: TColor;
    FDebugFrameActiveLineColor: TColor;
    FDebugFrameLineColor: TColor;
    FDebugFrameTopLineBg: TColor;
    FDebugFrameActiveLineBg: TColor;
    FDebugFrameLineBg: TColor;

    FPrintTasks: TList;

    procedure ClearPrintTasks;
    procedure UpdatePrintTasksFont;

    procedure BeginChangeCommon;
    procedure EndChangeCommon(AFullRepaint, ABlockEvent: Boolean);

    function  AuthorID: Integer;

    procedure AddInternalState(AState: TLMDEditInternalState);
    procedure RemoveInternalState(AState: TLMDEditInternalState); overload;
    procedure RemoveInternalState(AState: TLMDEditInternalStates); overload;
    procedure RemoveInternalStateForPublics(AState: TLMDEditInternalStates); overload;

    // Document events.

    procedure BeginDocEdit;
    procedure EndDocEdit;

    procedure BeforeInsert(AStart, ACount: Integer);
    procedure AfterInsert(AStart, ACount: Integer);
    procedure BeforeDelete(AStart, ACount: Integer);
    procedure AfterDelete(AStart, ACount: Integer);

    procedure DocumentDestroing;
    procedure BeforeCompoundEdit(AFreezeViews: Boolean);
    procedure AfterCompoundEdit(AFreezeViews: Boolean);

    procedure AfterMarkChange;
    procedure BeforeMarkChange;
    procedure MarkSettingsChanged(AMarkers: ILMDMarkers;
                                  const AMark: ILMDMark);

    procedure DoUserEventAfterDocChange;

    procedure DetachFromDocument(AStoreDoc: Boolean);
    procedure AttachToDocument;

    procedure RecalkScreenVars;
    function  ScreenHeightFullVis: Integer;

    function  IsScreenPointInSelection(AScreenPoint: TPoint): Boolean;
    procedure SetSpecialChars(const Value: TLMDSpecialChars);

    // Color.
    procedure SetReadOnlyBgColor(AColor: TColor);
    procedure SetWrapRulerColor(AColor: TColor);
    procedure SetSelectedLineBg(AColor: TColor);
    procedure SetBreakpointLineColor(AColor: TColor);
    procedure SetBreakpointLineBg(AColor: TColor);
    procedure SetSelectionBg(AColor: TColor);
    procedure SetSelectionColor(AColor: TColor);
    procedure SetGutter(AGutter: TLMDGutter);

    // Caret.
    function  NeedInsCaret: Boolean;
    procedure CreateViewCaret;
    procedure DestroyViewCaret;
    procedure HideViewCaret(AForce: Boolean);
    procedure UpdateViewCaret(AForceUpdate: Boolean = false);

    procedure BeginUpdateLow;
    procedure EndUpdateLow;

    procedure SaveOldScreenParams;
    procedure ResetScreenMarksChanged;

    function NoWrap: Boolean;//Shortcut for WrapMode=wmNoWrap

    // Settings changers (can change screen size etc).

    procedure BeforeDocRefresh;
    procedure AfterDocRefresh;

    procedure BeforeDocSettingsRefresh;
    procedure AfterDocSettingsRefresh;

    procedure UpdateWinStyle;

    procedure SetDocument(ADoc: TLMDEditDocument);
    procedure SetDocumentLow(ADoc: TLMDEditDocument; AStoreOldDoc: Boolean);
    procedure SetViewSettings(ASettings: TLMDViewSettings);
    procedure SetWrapRulerWidth(AWidth: Integer);
    procedure SetWrapMode(AMode: TLMDViewWrapMode);
    procedure SetTabWidth(AWidth: Integer);
    procedure SetIndentWidth(AWidth: Integer);
    procedure SetFont(AFont: TFont);
    procedure OnFontChange(Sender: TObject);
    procedure SetSyntaxCheckTokens(ATokens: TLMDStrings);

    // Functions for public properties

    procedure SetReadOnly(Value: Boolean);
    function GetScreenHeight: Integer;
    function GetLinesOnScreenScroll: Integer;//Real screen size

    function  GetCursorAsOffset: Integer;
    procedure SetCursorAsOffset(AOffset: Integer);

    function  GetCanCopy: Boolean;
    function  GetCanCut: Boolean;
    function  GetCanPaste: Boolean;

    function  GetCanUndo: Boolean;
    function  GetCanRedo: Boolean;

    procedure SetCustomCommands(ACommands: TLMDEditCommandList);

    function  GetSelectedText: TLMDString;
    procedure SetSelectedText(const AStr: TLMDString);

    function  GetWrapRulerWidth: Integer;
    function  GetWrapMode: TLMDViewWrapMode;

    // Selection, cursor, scroll changers.
    procedure SetSelStart(AStart: TPoint);
    procedure SetSelEnd(AEnd: TPoint);
    function  GetSelStart: TPoint;
    function  GetSelEnd: TPoint;
    function  GetSelBlockMode: Boolean;
    procedure SetSelBlockMode(ABlockMode: Boolean);

    function  GetSelAvail: Boolean;
    function  GetSelStartNorm: TPoint;
    function  GetSelEndNorm: TPoint;

    procedure SetCursorPos(APoint: TPoint);
    procedure SetCursorPosEx(APoint: TPoint;
                             ACorrectDir: Integer;
                             ABlock: Boolean);

    function  GetCursorPos: TPoint;
    function  GetCursorPosX: Integer;
    procedure SetCursorPosX(X: Integer);
    function  GetCursorPosY: Integer;
    procedure SetCursorPosY(Y: Integer);

    procedure ScrollToCursorLow(AvoidScreenEdge: Boolean);

    procedure SaveCursorMaxHoriz;
    procedure CorrectCursorToMaxHoriz;

    function  GetSelOffsetStart: Integer;
    function  GetSelOffsetEnd: Integer;

    procedure SetSelOffsetStart(AOffset: Integer);
    procedure SetSelOffsetEnd(AOffset: Integer);
    function  GetStoreDocSettingsLimit: Integer;
    procedure SetStoreDocSettingsLimit(ALimit: Integer);
    procedure SetDebugFrameActiveLineBg(const AColor: TColor);
    procedure SetDebugFrameActiveLineColor(const AColor: TColor);
    procedure SetDebugFrameLineBg(const AColor: TColor);
    procedure SetDebugFrameLineColor(const AColor: TColor);
    procedure SetDebugFrameTopLineBg(const AColor: TColor);
    procedure SetDebugFrameTopLineColor(const AColor: TColor);

    property  SelStartN: TPoint read GetSelStartNorm; // Short name for internal usage
    property  SelEndN: TPoint read GetSelEndNorm; // Short name for internal usage

    procedure SetBorderStyle(AStyle: TBorderStyle);

    // Scroll.
    procedure ScrollVertWithCode(ALineOffset: Integer; ACode: TScrollCode;
                                 AWithEvent: Boolean);
    procedure SetHorizScrollWithCode(AScroll: Integer; ACode: TScrollCode);
    procedure SetHorizScroll(AScroll: Integer);
    procedure SetTopLineScroll(ALine: Integer);
    procedure SetTopLinePhysical(ALine: Integer);
    function  GetHorizScroll: Integer;
    function  GetTopLinePhysical: Integer;
    function  GetTopLineScroll: Integer;

    // Screen invalidate, setup.
    procedure InvalidateScreen(AFull: Boolean);

    //Private conversions
    function ScreenPosToScrollLow(AScreen: TPoint; DoCheck: Boolean = True): TPoint;
    function ScreenToPhysical(AScreen: Integer): Integer;
    function ScreenToScroll(AScreen: Integer): Integer;
    function ScreenPosToScroll(AScreen: TPoint): TPoint;
    function ScreenLineToClient(AScreen: Integer): TRect;
    function ClientToScreenPos(AClient: TPoint; out ScreenPart: TLMDEditScreenPart): TPoint;
    function ClientToGutterScreen(AClient: TPoint;
                                  out AScreenLine: Integer;
                                  out ABarHere: TLMDGutterBar): Boolean;
    function LastLineScroll: Integer;

    procedure CorrectSelPointsBlockMode(var AStart, AEnd: TPoint);

    //Windowing
    procedure UpdateMouseCursor;

    procedure WMChar(var Msg: TWMChar); message WM_CHAR;

    procedure ScrollTimerHandler(Sender: TObject);

    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Msg: TWMSetFocus);   message WM_SETFOCUS;

    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMCaptureChanged(var Msg: TMessage); message WM_CAPTURECHANGED;

    procedure WMHScroll(var Msg: TWMScroll); message WM_HSCROLL;
    procedure WMVScroll(var Msg: TWMScroll); message WM_VSCROLL;

    procedure WMClear(var Msg: TMessage); message WM_CLEAR;
    procedure WMCopy(var Message: TMessage); message WM_COPY;
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;

    procedure WMGetText(var Msg: TWMGetText); message WM_GETTEXT;
    procedure WMGetTextLength(var Msg: TWMGetTextLength); message WM_GETTEXTLENGTH;

    procedure SetScrollBars(AScrollbars: TScrollStyle);
    procedure SetScrollTimerBase(ABaseInt: Integer);

    procedure SetMaxHorizScroll(AMaxHorizScroll: Integer);
    function  MaxHorizScrollActual: Integer;

    //No HorizScroll here
    function  CharsOnScreen: Integer;
    //No HorizScroll here
    procedure UpdateScrollbars;

    //Keyboard
    procedure FillDefaultKeybindings;

    procedure DrawBmp(ACnv: TCanvas; ABmp: Graphics.TBitmap;
                      const R: TRect;
                      Alignement: TAlignment = taCenter);

  protected
    FState: TLMDEditInternalStates;
    FSearchArgs: TLMDEditSearchArguments;
    FSearchState: TLMDEditViewSearchState;
    FSearchNumOfReplacements: Integer;
    FSearchStateBag: TLMDEditFindReplaceState;

    FSearchIncJumps: Contnrs.TObjectList;

    function DragEnterI(const dataObj: IDataObject; grfKeyState: Longint;
                       pt: TPoint; var dwEffect: Longint): HResult; stdcall;

    function DragOverI(grfKeyState: Longint; pt: TPoint;
                      var dwEffect: Longint): HResult; stdcall;

    function DragLeaveI: HResult; stdcall;

    function DropI(const dataObj: IDataObject;
                  grfKeyState: Longint; pt: TPoint;
                  var dwEffect: Longint): HResult; stdcall;

    {$IFDEF LMDCOMP7}(*BCB6 bug*)
    function IDropTarget.DragEnter = DragEnterI;
    function IDropTarget.DragOver = DragOverI;
    function IDropTarget.DragLeave = DragLeaveI;
    function IDropTarget.Drop = DropI;
    {$ENDIF}

    /////////////////////////////////////////////////////////////////////
    ///////////// EM_*** messages and Addict-related functions  /////////
    /////////////////////////////////////////////////////////////////////

    // the (Windows edit controls) character position system considers every line
    // break as a single character, even if CRLF is being used. The SyntaxEdit
    // offset coordinate system on the other hand counts each and every character.
    // Here we "fix" this issue.
    function WinCharPosToOffset(ACharPos: Integer): Integer;
    function WinCharPosToScrollPos(ACharPos: Integer): TPoint;
    function OffsetToWinCharPos(AOffset: Integer): Integer;
    function ScrollPosToWinCharPos(APos: TPoint): Integer;
    function GetScrollLineSeg_Addict(ALine: Integer): TLMDSegment;

    procedure UpdateAddictCheckTokenIds;
    procedure ClearAddictCheckTokenIds;
    function  HasAddictCheckToken(ATokenId: Integer): Boolean;
    function  AddictCheckTokenCount: Integer;

    procedure EM_SetReadOnly(var AMsg: TMessage); message EM_SETREADONLY;
    procedure EM_GetModify(var AMsg: TMessage); message EM_GETMODIFY;
    procedure EM_SetModify(var AMsg: TMessage); message EM_SETMODIFY;
    procedure EM_ReplaceSel(var AMsg: TMessage); message EM_REPLACESEL;
    procedure EM_GetSel(var AMsg: TMessage); message EM_GETSEL;
    procedure EM_SetSel(var AMsg: TMessage); message EM_SETSEL;
    procedure EM_LineFromChar(var AMsg: TMessage); message EM_LINEFROMCHAR;
    procedure EM_LineFromCharEx(var AMsg: TMessage); message EM_EXLINEFROMCHAR;
    procedure EM_CharFromPos(var AMsg: TMessage); message EM_CHARFROMPOS;
    procedure EM_EmptyUndoBuffer(var AMsg: TMessage); message EM_EMPTYUNDOBUFFER;
    procedure EM_LineIndex(var AMsg: TMessage); message EM_LINEINDEX;
    procedure EM_PosFromChar(var AMsg: TMessage); message EM_POSFROMCHAR;
    procedure EM_CanUndo(var AMsg: TMessage); message EM_CANUNDO;
    procedure EM_Undo(var AMsg: TMessage); message EM_UNDO;
    procedure EM_LineLength(var AMsg: TMessage); message EM_LINELENGTH;
    procedure EM_GetFirstVisibleLine(var AMsg: TMessage); message EM_GETFIRSTVISIBLELINE;
    procedure EM_GetLineCount(var AMsg: TMessage); message EM_GETLINECOUNT;
    procedure EM_GetLine(var AMsg: TMessage); message EM_GETLINE;
    procedure EM_LineScroll(var AMsg: TMessage); message EM_LINESCROLL;
    procedure EM_ExGetSel(var AMsg: TMessage); message EM_EXGETSEL;
    procedure EM_GetSelText(var AMsg: TMessage); message EM_GETSELTEXT;
    procedure EM_GetCharFormat(var AMsg: TMessage); message EM_GETCHARFORMAT;
    procedure EM_FormatRange(var AMsg: TMessage); message EM_FORMATRANGE;

    // Events.
    procedure FireOnScroll(var ANewPos: Integer; ACode: TScrollCode;
                           AVert: Boolean);
    function  FireOnGutterPaint(const Args: TLMDEditPaintTextArgs;
                                ABar: TLMDGutterBar): Boolean;

    procedure AddStatusChange(AChange: TLMDViewStatusChange); overload;
    procedure AddStatusChange(AChanges: TLMDViewStatusChanges); overload;
    procedure FireOnStatusChanged;

    //For ancestor
    function  GetCanvas: TCanvas; virtual;
    function  GetDrawRect: TRect; virtual;
    procedure Beep; virtual;

    //Changes in ancestor.
    procedure DrawRectChanged;

    //Utilites for ancestor.
    function Parser: TLMDEditParserBase;
    function MyDoc: TLMDEditDocument;

    //ILMDComponent
    function getLMDPackage: TLMDPackageID;

    // Checks.
    procedure CheckRequiredState(AMode: TLMDEditInternalState; RequireHave: Boolean);
    procedure CheckChangesLock;
    procedure CheckGutterBarVisible(ABar: TLMDGutterBar);
    procedure CheckDocumentIsSet;
    procedure CheckInSearchMode;
    procedure CheckInReplaceMode;
    procedure CheckNotReadOnly;
    function  IsDocumentSet: Boolean;
    function  IsReadOnly: Boolean;

    procedure LockChangeLock;
    procedure UnlockChangeLock;

    function  IsUpdating: Boolean;

    procedure LockForViewEvent;
    procedure UnlockForViewEvent;

    //Incremental search
    procedure IncrementalSearchInit;
    procedure IncrementalSearchAddChar(Ch: TLMDChar);
    procedure IncrementalSearchBackward;
    function IncrementalSearchForward: Boolean;
    procedure IncrementalSearchCancel;
    function GetInIncrementalSearch: Boolean;


    //Auto-completion
    procedure CompletionTimerHandler(Sender: TObject);

    procedure StopCompletionTimer;

    procedure StartCompletionTimer;

    procedure CheckShowCompletionList(AllowInsideWord: Boolean;
                                      ACause: TLMDEditFillCompletionCause;
                                      AllowNoCombo: Boolean);
    procedure HideCompletionList;

    function  FillCompletionList(AItems: TStrings;
                                 AScrollPoint: TPoint;
                                 ACause: TLMDEditFillCompletionCause;
                                 var AComboPos: TPoint): Integer;

    procedure CommitCompletion(AScrollPoint: TPoint;
                               ACause: TLMDEditReplaceCompletionCause);

    procedure CompletionOnClick(Sender: TObject);

    procedure SetComplSettings(ASettings: TLMDEditCompletionSettings);

    procedure SetHighlightSettings(ASettings: TLMDEditHighlightSettings);

    function GetComplSeparators: TLMDString;

    procedure CompletionDrawHandler(Control: TWinControl; Index: Integer;
                                    Rect: TRect; State: TOwnerDrawState);

    procedure CompletionMeasureHandler(Control: TWinControl; Index: Integer;
                                       var Height: Integer);

    // Painting.
    procedure Paint; override;
    procedure PaintTo(ACanvas: TCanvas; const ARect: TRect);
    procedure PaintGutterLine(Args: TLMDEditPaintTextArgs); virtual;
    procedure PaintTextLine(const Args: TLMDEditPaintTextArgs;
                            const SelScrS, SelScrE: TPoint); virtual;
    procedure PaintLineNumber(const Args: TLMDEditPaintTextArgs); virtual;
    procedure DefaultGutterPaint(const Args: TLMDEditPaintTextArgs; ABar: TLMDGutterBar; APaintKind: TLMDGutterBarKind); virtual;
    procedure DefaultGutterPaintCbk(AScreenLine: Integer;
                                    ABar: TLMDGutterBar;
                                    APaintKind: TLMDGutterBarKind;
                                    ACanvas: TCanvas;
                                    APaintRect: TRect);

    // Settings changers (can change screen size etc).
    procedure BeginSettingsChange;
    procedure EndSettingsChange(ABlockEvent, AResetCache: Boolean);

    //Cursor utilites
    function  IsCursorInScreenBounds: Boolean;

    function  CreateCursorUndoInfo: TLMDDocUndoInfo;
    function  CreateUndoInfo(AOffPt: TOffsetPoint): TLMDDocUndoInfo;
    procedure SetCursorAsUndoInfo(AInfo: TLMDDocUndoInfo);


    //GUI move/delete utilites
    function  UI_GetCursorMovePoint(ADirection: TLMDCursorMoveDirection;
                                    AUnit: TLMDCursorMoveUnit;
                                    AWithSel, ABlock: Boolean): TPoint; overload;

    function  UI_GetCursorMovePoint(APoint: TPoint;
                                    ADirection: TLMDCursorMoveDirection;
                                    AUnit: TLMDCursorMoveUnit;
                                    AWithSel, ABlock: Boolean): TPoint; overload;

    procedure UI_MoveCursorToOffGen(AOffPt: TOffsetPoint;
                                    AWithSel, ABlock: Boolean);
    function  UI_MoveCursorTo(ADirection: TLMDCursorMoveDirection;
                              AUnit: TLMDCursorMoveUnit;
                              AWithSel, ABlock: Boolean): Boolean;
    procedure UI_MoveCursorByPage(ADown, AWithSelect, ABlock: Boolean);

    procedure UI_Delete(ADirection: TLMDCursorMoveDirection; AUnit: TLMDCursorMoveUnit);
    procedure UI_UndoRedo(AUndo: Boolean);
    function  UI_CanUndoRedo(AUndo: Boolean): Boolean;
    procedure UI_ScrollUpDown(AUp: Boolean);
    procedure UI_BackspaceOrUnindent;
    procedure UI_IndentOrTab;

    procedure UI_IndentSelection(AUnindent, AUsePrevIndent: Boolean);
    procedure MoveCursorAndSelToBounds;

    procedure SetSelection(AStartOffset, AEndOffset: TOffsetPoint;
                           ABlockMode: Boolean); overload;

    //Finds first mathed line (match to AFindGreater)
    function  FindIndentSeg(AFindStartLine: Integer;
                            AVisWidth: Integer;
                            AFindGreater: Boolean;
                            out FoundWidth: Integer;
                            out FoundSeg: TLMDSegment): Boolean;

    function  FindIndentStr(AFindStartLine: Integer;
                            AVisWidth: Integer;
                            AFindGreater: Boolean): TLMDString;

    function  FindNoSpaceOffset(APhysLine: Integer; AVisibleOnly: Boolean = true): Integer;

    function  MoveToIndentPos(AMovePoint: TPoint; ABackward: Boolean): Boolean;

    //AStartOffset  - start char of deleted fragment
    procedure DeleteInScrollEx(AScrollStart, AScrollEnd: TPoint;
                               RememberCursor: Boolean;
                               out AStartOffset: TOffsetPoint); overload;

    function UI_DeleteToLineEnd(AToScrollEnd: Boolean): Boolean;
    function UI_DeleteLine: Boolean;

    // Low-level search/replace functions
    procedure FreeSearchState;

    procedure AskForReplaceAction(AForReplaceAll: Boolean;
                                  const AState: TLMDEditFindReplaceState;
                                  var ReplacedCount: Integer;
                                  var Action: TLMDEditReplaceAction);

    function  AskForNotFound: TLMDEditNotFoundAction;

    procedure ReplaceNextProc(Sender: TObject;
                              const AState: TLMDEditFindReplaceState;
                              var ReplacedCount: Integer;
                              var Action: TLMDEditReplaceAction);

    procedure ReplaceAllProc(Sender: TObject;
                             const AState: TLMDEditFindReplaceState;
                             var ReplacedCount: Integer;
                             var Action: TLMDEditReplaceAction);

    function SearchNextLow(AFirstTime: Boolean): Boolean;

    function FindNextEndOrStartOfWord(APt: TPoint; AFwd: Boolean): TPoint;
    function FindNextEndOrStartOfLine(APt: TPoint; AFwd: Boolean): TPoint;

    //Windowing
    procedure Loaded; override;
    procedure Resize; override;
    function  CanResize(var NewWidth, NewHeight: Integer): Boolean; override;

    procedure FireGutterClick(AButton: TMouseButton; AShift: TShiftState;
                              ClientPoint: TPoint; Handled: Boolean);
    procedure FireGetMouseCursor(const AScrollPos: TPoint; var ACursor: TCursor);

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
                        Integer); override;

    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton;
                      Shift: TShiftState; X, Y: Integer); override;
    procedure CheckStartScrollTimer(X, Y: Integer; AStartAtEdge: Boolean);
    procedure StopScrollTimer;

    procedure DragCanceled; override;
    procedure DragOver(Source: TObject; X, Y: Integer;
                       State: TDragState; var Accept: Boolean); override;

    function  DoMouseWheel(Shift: TShiftState; WheelDelta:
                           Integer; MousePos: TPoint): Boolean; override;


    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyPressW(var Key: TLMDChar); virtual;
    procedure DoKeyPressW(var AMsg: TWMKey);

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure CreateHandle; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;

    // Properties.

    procedure DefineProperties(AFiler: TFiler); override;
    procedure LoadGutterBarsEmpty(AReader: TReader);
    procedure SaveGutterBarsEmpty(AWriter: TWriter);
    procedure ReadState(AReader: TReader); override;

    property ScrollBars: TScrollStyle  read FScrollBars write SetScrollBars default ssBoth;

    property GutterCursor: TCursor read FGutterCursor write FGutterCursor default crDefault;
    property ScrollTimeBaseInterval: Integer read FScrollTimerBase write SetScrollTimerBase default SCROLL_TIMER_BASE;

    property WantReturns: boolean read FWantReturns write FWantReturns default True;
    property WantTabs: boolean read FWantTabs write FWantTabs default True;

    property OnGetMouseCursor: TMouseCursorEvent read FOnMouseCursor write FOnMouseCursor;
    property OnGutterClick: TLMDGutterClickEvent read FOnGutterClick write FOnGutterClick;
    property OnKeyPressW: TKeyPressWEvent read FOnKeyPressW write FOnKeyPressW;
    property OnBeforeCommand: TLMDEditBeforeCommandEvent read FOnBeforeCommand write FOnBeforeCommand;
    property OnAfterCommand: TLMDEditAfterCommandEvent read FOnAfterCommand write FOnAfterCommand;
    property OnGetLineAttributes: TLMDEditGetLineAttrsEvent read FOnGetLineAttrs write FOnGetLineAttrs;

    property  MaxHorizScroll: Integer read FMaxHorizScroll write SetMaxHorizScroll default MAX_HORIZ_SCROLL;
    property  HorizScroll: Integer read GetHorizScroll write SetHorizScroll default 0;
    property  ViewSettings: TLMDViewSettings read FViewSettings write SetViewSettings
                default [vsHideShowScrollbars, vsAutoIndent,
                         vsHighlightSelectedLine, vsRightClickMovesCursor,
                         vsDragDropEditing];

    property  ReadOnlyBgColor: TColor read FReadOnlyBgColor write SetReadOnlyBgColor default clSilver;
    property  WrapRulerColor: TColor read FWrapRulerColor write SetWrapRulerColor default clGray;
    property  SelectedLineBg: TColor read FSelectedLineBg write SetSelectedLineBg default 15138810; //RGB(250, 255, 230)

    property  BreakpointLineColor: TColor read FBreakpointLineColor write SetBreakpointLineColor default clBlack;
    property  BreakpointLineBg: TColor read FBreakpointLineBg write SetBreakpointLineBg default 16762823; //RGB(199, 199, 255)

    property  DebugFrameLineColor: TColor read FDebugFrameLineColor write SetDebugFrameLineColor default clBlack;
    property  DebugFrameLineBg: TColor read FDebugFrameLineBg write SetDebugFrameLineBg default 15134702; //RGB(204, 153, 153)

    property  DebugFrameActiveLineColor: TColor read FDebugFrameActiveLineColor write SetDebugFrameActiveLineColor default clBlack;
    property  DebugFrameActiveLineBg: TColor read FDebugFrameActiveLineBg write SetDebugFrameActiveLineBg default 10066380; //RGB(204, 153, 153)

    property  DebugFrameTopLineColor: TColor read FDebugFrameTopLineColor write SetDebugFrameTopLineColor default clBlack;
    property  DebugFrameTopLineBg: TColor read FDebugFrameTopLineBg write SetDebugFrameTopLineBg default 10066380; //RGB(204, 153, 153)

    property  SelectionBg: TColor read FSelectionBg write SetSelectionBg default 10841427; // RGB(83, 109, 165)
    property  SelectionColor: TColor read FSelectionColor write SetSelectionColor default clWhite;

    property  WrapRulerWidth: Integer read GetWrapRulerWidth write SetWrapRulerWidth default 80;
    property  WrapMode: TLMDViewWrapMode read GetWrapMode write SetWrapMode default wmNoWrap;

    property  TabWidth: Integer read FTabWidth write SetTabWidth default 8;
    property  IndentWidth: Integer read FIndentWidth write SetIndentWidth default 4;

    property  SelectionStart: TPoint read GetSelStart write SetSelStart;
    property  SelectionEnd: TPoint read GetSelEnd write SetSelEnd;
    property  SelectionBlockMode: Boolean read GetSelBlockMode write SetSelBlockMode;

    property  SelectionStartNorm: TPoint read GetSelStartNorm;
    property  SelectionEndNorm: TPoint read GetSelEndNorm;

    property  SelectionOffsetStart: Integer read  GetSelOffsetStart
                                            write SetSelOffsetStart;

    property  SelectionOffsetEnd: Integer read  GetSelOffsetEnd
                                          write SetSelOffsetEnd;

    property  Font: TFont read FFont write SetFont;

    property TopLineScroll: Integer read GetTopLineScroll write SetTopLineScroll;
    property TopLinePhysical: Integer read GetTopLinePhysical write SetTopLinePhysical;

    property SelAvail: Boolean read GetSelAvail;

    property Gutter: TLMDGutter read FGutter write SetGutter;

    property SpecialChars: TLMDSpecialChars read FSpecialChars write SetSpecialChars;
    // Events.
    property OnScroll: TScrollEvent read FOnScroll write FOnScroll;

    property OnGutterPaint:  TLMDGutterPaintEvent read FOnGutterPaint
                                               write FOnGutterPaint;

    property OnStatusChanged: TLMDViewStatusChangeEvent read FOnStatusChanged
                                                     write FOnStatusChanged;
    property OnNotFound: TLMDEditNotFoundEvent read FOnNotFound write FOnNotFound;
    property OnReplaceFound: TLMDEditReplaceEvent read FOnReplaceFound write FOnReplaceFound;

    property OnFillCompletionList: TLMDEditFillCompletionListEvent
                                   read FComplOnFill write FComplOnFill;

    property OnCompletionReplace: TLMDEditReplaceForCompletionResultEvent
                                  read FComplCommit write FComplCommit;

    property OnCompletionCustomDraw: TLMDEditDrawCompletionItemEvent
                                     read FComplOnDraw write FComplOnDraw;

    property OnCompletionMeasureItem: TLMDEditMeasureCompletionItemEvent
                                      read FComplOnMeasure
                                      write FComplOnMeasure;

    // Screen size, scroll.

    property ScreenHeight: Integer read GetScreenHeight;
    property LinesOnScreenScroll: Integer read GetLinesOnScreenScroll;//Real screen size

    // Scroll, cursor, selection.
    property  CursorPos: TPoint read GetCursorPos write SetCursorPos;
    property  CursorPosX: Integer read GetCursorPosX write SetCursorPosX;
    property  CursorPosY: Integer read GetCursorPosY write SetCursorPosY;
    property  CursorOffset: Integer read GetCursorAsOffset write SetCursorAsOffset;

    //Copy/paste
    property  CanCopy: Boolean read GetCanCopy;
    property  CanCut: Boolean read GetCanCut;
    property  CanPaste: Boolean read GetCanPaste;

    property  CanUndo: Boolean read GetCanUndo;
    property  CanRedo: Boolean read GetCanRedo;

    //
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;

    property StoreDocSettingsLimit: Integer read GetStoreDocSettingsLimit
                                            write SetStoreDocSettingsLimit
                                            default STORED_VIEW_DOC_LIMIT;

    property  CompletionSettings: TLMDEditCompletionSettings
                                  read FComplSettings
                                  write SetComplSettings;

    property  HighlightSettings: TLMDEditHighlightSettings
                                  read FHighlightSettings
                                  write SetHighlightSettings;

    property ReadOnly: Boolean read FReadOnly write SetReadOnly default false;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure InvokeCommand(ACommand: TLMDEditCommand;
                            AArg: Variant;
                            AllowCommandEvents: Boolean); overload;

    procedure InvokeCommand(ACommand: TLMDEditCommand;
                            AllowCommandEvents: Boolean); overload;

    function  GetDefaultKeyBindings: TLMDEditCommandList;

    // Folds, visivility.

    function  GetNextVisibleLine(ALine: Integer): Integer;
    function  GetPrevVisibleLine(ALine: Integer): Integer;
    procedure Fold(APhysLine: Integer; All: Boolean);
    procedure Unfold(APhysLine: Integer; All: Boolean);
    procedure FoldAllIn(AOuterFold: Integer; TopOnly: Boolean);
    procedure UnfoldAllIn(AOuterFold: Integer; TopOnly: Boolean);

    procedure EnsureVisible(ALine: Integer);
    procedure EnsureOffsetIsVisible(AOffset: Integer);

    function  IsLineStartVisible(APhysLine: Integer): Boolean;
    function  IsOffsetVisible(AOffset: Integer): Boolean;
    function  IsCollapsedFold(APhysLine: Integer): Boolean;
    function  IsFoldStart(APhysLine: Integer): Boolean;

    function GetVisibleCountScroll: Integer;

    // Coordinates conversion.
    function GutterLineToClient(AScreenLine: Integer; ABar: TLMDGutterBar): TRect;
    function ClientToGutter(AClient: TPoint;
                            out AScrollLine: Integer;
                            out ABarHere: TLMDGutterBar): Boolean;

    function ClientToScrollPos(AClient: TPoint;
                               out ScreenPart: TLMDEditScreenPart): TPoint; overload;
    function ClientToScrollPos(AClient: TPoint): TPoint; overload;

    function ScrollPosToClient(AScrollPos: TPoint;
                               out OutOfScreen: Boolean): TRect;

    function PhysicalToScroll(ALine: Integer): Integer;
    function ScrollToPhysical(ALine: Integer): Integer;
    procedure ScrollPosToPhysical(APoint: TPoint; out APhysLine, ACol: Integer);

    function OffsetToScrollPos(AOffset: Integer): TPoint;
    function ScrollPosToNearestOffset(AScroll: TPoint): Integer;

    // Scroll, cursor, selection.

    procedure SetSelection( AStart, AEnd: TPoint;
                            ABlockMode: Boolean); overload;

    procedure SetSelection( AStartOffset, AEndOffset: Integer;
                            ABlockMode: Boolean); overload;

    procedure CancelSelection;

    procedure ScrollVertBy(ALineOffset: Integer);

    procedure ScrollToCursor;
    procedure ScrollToPos(AScrollPos: TPoint); overload;
    procedure ScrollToPos(AScrollPos: TPoint; AvoidScreenEdge: Boolean); overload;

    // Others.
    procedure DeleteInScroll(AScrollStart, AScrollEnd: TPoint);
    procedure DeleteInScrollEx(AScrollStart, AScrollEnd: TPoint;
                               out AStartOffset: TOffsetPoint); overload;

    procedure DeleteInScrollBlock(AScrollStart, AScrollEnd: TPoint;
                                  out AStartOffset: TOffsetPoint);

    procedure InsertInScroll(AScroll: TPoint; const AStr: TLMDString);

    //AStartOffset  - start char of inserted fragment
    //AEndOffset    - char "after the end"

    procedure InsertInScrollBlock(AScroll: TPoint; const AStr: TLMDString;
                                  out AMaxWidth: Integer;
                                  out AStartOffset, AEndOffset: TOffsetPoint); overload;

    procedure InsertInScrollBlock(AScroll: TPoint; const AStr: TLMDString;
                                  out AMaxWidth: Integer;
                                  out AStartOffset, AEndOffset: Integer); overload;

    procedure InsertInScrollEx(AScroll: TPoint; const AStr: TLMDString;
                               out AStartOffset, AEndOffset: Integer); overload;
    procedure InsertInScrollEx(AScroll: TPoint; const AStr: TLMDString;
                               RememberCursor: Boolean;
                               out AStartOffset, AEndOffset: Integer;
                               AWithSpacesBefore: Boolean); overload;

    procedure ReplaceInScroll(AScrollStart, AScrollEnd: TPoint;
                              const AStr: TLMDString);

    //AStartOffset  - start char of new fragment
    //AEndOffset    - char "after the end"
    procedure ReplaceInScrollEx(AScrollStart, AScrollEnd: TPoint;
                                const AStr: TLMDString;
                                out AStartOffset, AEndOffset: Integer); overload;

    procedure ReplaceInScrollEx(AScrollStart, AScrollEnd: TPoint;
                                const AStr: TLMDString;
                                RememberCursor: Boolean;
                                out AStartOffset, AEndOffset: Integer); overload;


    function CreateScrollTextSeqAdapter(AScrollStart, AScrollEnd: TPoint;
                                        ABlock: Boolean): TLMDCharSeq;

    // GUI functions (helpers for keyboard input).

    function  GetWordUnderCursor: TLMDString;

    procedure GotoBookmark(const AName: TLMDString);
    procedure GotoBreakpoint(const AName: TLMDString);
    procedure GotoPhysLine(ALine: Integer);
    procedure GotoOffset(AOffset: Integer);

    procedure SelectAll;
    procedure DeleteSelected;
    procedure CopySelection;
    procedure CutSelection;
    procedure Paste;

    procedure IndentSelection(AUsePrevIndent: Boolean = false);
    procedure UnindentSelection(AUsePrevIndent: Boolean = false);

    procedure InsertTabAtCursor(AOverwrite: Boolean);
    procedure InsertReturnAtCursor(AOverwrite: Boolean);
    procedure InsertCharAtCursor(AChar: TLMDChar; ACount: Integer; AOverwrite: Boolean);
    procedure InsertAtCursor(const AStr: TLMDString; AOverwrite: Boolean);
    procedure DeleteCharLeft;
    procedure DeleteCharRight;
    procedure DeleteWordLeft;
    procedure DeleteWordRight;

    procedure Undo;
    procedure Redo;

    procedure MoveToNextWord(AWithSelect, ABlock: Boolean);
    procedure MoveToPrevWord(AWithSelect, ABlock: Boolean);
    procedure MoveToNextChar(AWithSelect, ABlock: Boolean);
    procedure MoveToPrevChar(AWithSelect, ABlock: Boolean);
    procedure MoveToNextLine(AWithSelect, ABlock: Boolean);
    procedure MoveToPrevLine(AWithSelect, ABlock: Boolean);
    procedure MoveToFirstScreenLine(AWithSelect, ABlock: Boolean);
    procedure MoveToLastScreenLine(AWithSelect, ABlock: Boolean);
    procedure MoveToNextPage(AWithSelect, ABlock: Boolean);
    procedure MoveToPrevPage(AWithSelect, ABlock: Boolean);
    procedure MoveToLineStart(AWithSelect, ABlock: Boolean);
    procedure MoveToLineEnd(AWithSelect, ABlock: Boolean);
    procedure MoveToTextStart(AWithSelect, ABlock: Boolean);
    procedure MoveToTextEnd(AWithSelect, ABlock: Boolean);
    procedure ScrollUp;
    procedure ScrollDown;

    function  CompletionFillListDef(AItems: TStrings;
                                    ACursorPoint: TPoint;
                                    ACause: TLMDEditFillCompletionCause;
                                    var APosForCombo: TPoint): Integer;

    procedure DragDrop(Source: TObject; X, Y: Integer); override;

    procedure BeginUpdate;
    procedure EndUpdate; overload;
    procedure EndUpdate(AFullRepaint: Boolean); overload;

    procedure InvalidateScrollLine(AScrollLine: Integer);

    function  SearchFirst(const Args: TLMDEditSearchArguments): Boolean;
    function  SearchNext: Boolean;

    function  ReplaceFirst(const Args: TLMDEditSearchArguments): Boolean;
    function  ReplaceNext: Boolean;

    function  ReplaceAll(const Args: TLMDEditSearchArguments;
                         ABounds: TLMDEditViewReplaceAllBounds): Boolean;

    procedure AssignSearchReplaceArgs(const Args: TLMDEditSearchArguments;
                                      AState: TLMDEditViewSearchState);

    procedure AddHighlight(AStart, ACount: Integer);
    procedure RemoveHighlight(AStart, ACount: Integer);
    procedure ClearHighlight;

    property  SearchState: TLMDEditViewSearchState read FSearchState;
    property  SearchLastArgs: TLMDEditSearchArguments read FSearchArgs;
    property  SearchLastNumReplacements: Integer read FSearchNumOfReplacements;

    property InIncrementalSearch: Boolean read GetInIncrementalSearch;

    property  CustomKeyBindings: TLMDEditCommandList read FCustomCommands
                                                     write SetCustomCommands;

    property  SyntaxCheckTokens: TLMDStrings read FAddictCheckTokens
                                             write SetSyntaxCheckTokens;

    property  Document: TLMDEditDocument read FFDoc write SetDocument;

    property  SelectedText: TLMDString read GetSelectedText write SetSelectedText;

  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
  end;

  {******************************* TLMDEditView *******************************}

  TLMDEditView = class(TLMDCustomEditView)
  public
    property ScreenHeight;
    property LinesOnScreenScroll;

    property TopLineScroll;
    property TopLinePhysical;
    property HorizScroll;
    property SelectionStart;
    property SelectionEnd;
    property SelAvail;
    property SelectionOffsetStart;
    property SelectionOffsetEnd;
    property SelectionBlockMode;

    property CursorPos;
    property CursorPosX;
    property CursorPosY;
    property CursorOffset;

    property CanCopy;
    property CanCut;
    property CanPaste;

    property CanUndo;
    property CanRedo;

    property SelectedText;
  published
    property Align;
    property Anchors;
    property Constraints;
    property ShowHint;
    property Visible;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    property Ctl3D;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property TabOrder;
    property TabStop default True;
    property Document;
    property ViewSettings;
    property TabWidth;
    property IndentWidth;
    property WrapMode;
    property WrapRulerWidth;
    property WantReturns;
    property WantTabs;
    property Color default clWhite;
    property Cursor default crIBeam;
    property ReadOnlyBgColor;
    property WrapRulerColor;
    property SelectedLineBg;
    property BreakpointLineColor;
    property BreakpointLineBg;

    property DebugFrameLineColor;
    property DebugFrameLineBg;

    property DebugFrameActiveLineColor;
    property DebugFrameActiveLineBg;

    property DebugFrameTopLineColor;
    property DebugFrameTopLineBg;

    property SelectionBg;
    property SelectionColor;
    property Font;
    property Gutter;
    property SpecialChars;
    property CustomKeyBindings;
    property SyntaxCheckTokens;
    property ScrollBars;
    property StoreDocSettingsLimit;
    property CompletionSettings;
    property HighlightSettings;
    property MaxHorizScroll;

    property ReadOnly;

    property OnScroll;
    property OnGetMouseCursor;
    property OnGutterClick;
    property OnGutterPaint;
    property OnStatusChanged;
    property OnNotFound;
    property OnReplaceFound;

    property OnFillCompletionList;
    property OnCompletionReplace;
    property OnCompletionCustomDraw;
    property OnCompletionMeasureItem;

    property OnKeyPressW;
    property OnBeforeCommand;
    property OnAfterCommand;
    property OnGetLineAttributes;
    property OnKeyDown;
    property OnKeyUp;
    property OnClick;
    property OnContextPopup;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnEnter;
    property OnExit;
    property OnResize;
  end;

function LMDSedClipboadFormat: UINT;

const
  SpecialCharsLineSpaces: TLMDSpecialCharKinds = [skTabTail, skTabHead,
                                                  skSpace];

implementation

{.$define MY_SED_LOG}
{.$define MY_SED_MORE_DEBUG}

uses
  Math, ShellApi, Menus, Dialogs, SyncObjs,
  {$ifdef MY_SED_LOG}LMDLogMessage, {$endif}
  {$IFDEF LMDCOMP17}System.UITypes,{$ENDIF}
  LMDUnicodeControl, LMDUnicode, LMDUtils, LMDRegExpr, LMDSedConst;

{$IFDEF LMDDEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

type
  PCharRange = ^TCharRange;

  TDocAccess      = class(TLMDEditDocument);
  THackWinControl = class(TWinControl);

  TScreenCacheValidItem = (csScreen,
                           csCursor,//Cursor point correctness
                           csFolds,//folding structures consistency
                           csConversionCaches
                           );

  TScreenCacheValid     = set of TScreenCacheValidItem;

  TScrollCorrectCause = (scForSelection, scForCursor);
  TScrollCorrectDirection = (scForward, scBackward);

  TLMDScreenLineProp = (// Line is first screen line of wrapped sublines
                        // of some physical line
                        lpFirstWrap,
                        // Same as lpFirstWrap
                        lpLastWrap,
                        // Line has a bookmark
                        lpBookmark,
                        // Line has a breakpoint
                        lpBreakpointActive,
                        lpBreakpointInactive,
                        lpBreakpointDisabled,

                        //Debugger stack frame
                        lpFrame,
                        lpFrameTop,
                        lpFrameActive,

                        // Line is a start of some fold
                        lpFoldStart,
                        lpCollapsedFold,
                        // Line is a end of some non-collapsed, of course fold
                        lpFoldEnd);

  // The flags set of line on screen. They are used for painting operations
  TLMDScreenLineProps = set of TLMDScreenLineProp;


  {******************************* TAttrsCache *********************************}

  TAttrsCacheItem = class
  public
    Code: Integer;
    Font: HFont;
    FontObj: TFont;

    Next: TAttrsCacheItem;
  end;

  TAttrsCacheItemArr = array of TAttrsCacheItem;

  TAttrsCache = class
  private
    FItems: TAttrsCacheItemArr;
    FHashMask: Integer;
    FFont: TFont;
  public
    constructor Create(AFont: TFont);

    destructor Destroy; override;
    function GetFont(AFs: TFontStyles; ACharset: TFontCharset): HFont;
    procedure Reset(AFont: TFont);
  end;

  {******************************* TCursorUndoInfo ****************************}

  TCursorUndoInfo = class(TLMDDocUndoInfo)
  public
    OffPt: TOffsetPoint;
    WordTyping: Boolean;

    constructor Create(AOffPt: TOffsetPoint; AWordTyping: Boolean);
    function    Clone: TLMDDocUndoInfo; override;
  end;

  {*********************************** TChunk *********************************}

  TChunk = record
    Attrs:    TLMDEditAttributes;
    AttrsWeight: Integer;
    CharSet:  TFontCharset;

    StateOffset: Integer;
    StateOffsetCount: Integer;

    Chars:    TLMDCharArray;
    CharsCount:  Integer;

    CanMerge: Boolean;
    IsTail: Boolean;
  end;

  PChunk = ^TChunk;

  TChunkArray = array of TChunk;

  TWrapParserState = record
    Offset: Integer;
    X: Integer;
    XPix: Integer;
    Y: Integer;

    Y_OffsetStart: Integer; {where X=0}
    PhysLine: Integer;

    VisWidth: Integer;
    PixWidth: Integer;

    HighlightIdx: Integer;

    Attrs: TLMDEditAttributes;
    AttrsWeight: Integer;

    IsTail: Boolean;
    IsTab: Boolean;
    IsStable: Boolean;
  end;

  TWP_Condition = (wpByOffset, wpByXY, wpByXPixY);

  TScrollLineInfo = record
    PhysicalLine:  Integer;
    ContentSegment: TLMDSegment;
    VisProps:       TLMDScreenLineProps;
  end;

  PScrollLineInfo = ^TScrollLineInfo;

  TScreenOffsetItemFlags = set of (soTail, soTab, soStable);
  TScreenOffsetItem = packed record
    VisW: Byte;
    PixW: Word;

    VisX: Integer;
    PixX: Integer;

    Flags: TScreenOffsetItemFlags;
  end;

  PScreenOffsetItem = ^TScreenOffsetItem;

  TScreenOffsetItemArr = array of TScreenOffsetItem;

  TScreenLineInfo = record
    ScrollInfo: TScrollLineInfo;

    Dirty:     Boolean;

    StartState: TWrapParserState;

    StartWordOff: Integer;
    EndWordOff: Integer;

    XBoundStart, XBoundCount: Integer;

    Chunks: TChunkArray;
    ChunksCount: Integer;

    //Visible offsets (tail offset too), from StartState.Offset
    Offsets: TScreenOffsetItemArr;
    OffsetsCount: Integer;
  end;

  PScreenLineInfo = ^TScreenLineInfo;

  TScreenLinesArray = array of TScreenLineInfo;
  TScreenCache     = class;

  {******************************* THiddenEntry *******************************}

  THiddenEntry = class
  public
    KeyLine: Integer;
    KeyMark: ILMDLineMark;
  public
    destructor Destroy; override;
  end;

  THiddenStart      = class;
  THiddenEnd        = class;

  {******************************* THiddenStart *******************************}

  THiddenStart = class(THiddenEntry)
  public
    EEnd: THiddenEnd;
  end;

  {******************************** THiddenEnd ********************************}

  THiddenStartArray = array of THiddenStart;

  THiddenEnd = class(THiddenEntry)
  public
    Starts: THiddenStartArray;

    procedure RemoveFromStarts(AStart: THiddenStart);
    procedure ShrinkStarts;
  end;

  {**************************** THiddenHashTraits *****************************}

  THiddenHashTraits = class(TLMDHashTableTraits)
  public
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

  {*************************** THiddenStartTraits *****************************}

  THiddenStartTraits = class(THiddenHashTraits)
  public
    class function OnUpdate(AItem: TObject): TLMDHashUpdateAction; override;
  end;

  {**************************** THiddenEndTraits ******************************}

  THiddenEndTraits = class(THiddenHashTraits)
  public
    class function OnUpdate(AItem: TObject): TLMDHashUpdateAction; override;
  end;

  {**************************** TParserFold ****************************}

  TParserFold = record
    StartLine: Integer;
    EndLine: Integer;
    ParentLine: Integer;
  end;

  {**************************** TOffsetPoint ****************************}

  TOffsetPointMark = record
    CharMark: ILMDMark;
    InCharOffset: Integer;
  end;

  {**************************** TStoredView ***************************}

  TStoredView = class;

  TStoredViewData = class(TLMDDocumentListener)
  private
    FCache: TScreenCache;
    FDocument: TLMDEditDocument;
    FCursorMarkers: ILMDMarkers;
    FParent: TStoredView;

    procedure RemoveFromParent;
  public
    Cursor: ILMDMark;
    SelStart: ILMDMark;
    SelEnd: ILMDMark;
    ScreenStart: ILMDMark;
    SelBlockMode: Boolean;

    Folds: ILMDMarkers;

    //1. Creates all markers from AParent.
    //2. Registers a listener in Parent's Document
    constructor Create(AParent: TStoredView);

    //1. Destroys all markers
    //1. Unregisters the listener
    destructor Destroy; override;

    //Removes itself from FData (with destruction) (1)
    procedure BeforeRefresh; override;

    //If ALength=Doc.CharsCount, then (1)
    procedure BeforeDelete(AStart, ALength: Integer); override;

    //(1)
    procedure DocumentDestroing; override;
  end;

  TStoredViewDataArray = array of TStoredViewData;

  TStoredView = class
  private
    FData: TStoredViewDataArray;
    FDataLimit: Integer;
    FParent: TScreenCache;
  public
    constructor Create(AParent: TScreenCache; ALimit: Integer);

    //Removes all items from FData
    destructor Destroy; override;

    //Creates new item in FData.
    //Assert: Current doc is unique
    procedure AttachCurrentDoc;

    //Result: nil if not found
    function GetDataByDoc(ADocument: TLMDEditDocument): TStoredViewData;

    //Assert: AData exists, and FData contains it
    procedure RemoveData(AData: TStoredViewData);

    procedure SetDataLimit(ALimit: Integer);
    function  GetDataLimit: Integer;
  end;

  TCharWidthCacheItem = class
  public
    Code: Integer;
    Width: Integer;

    Next: TCharWidthCacheItem;
  end;

  TCharWidthCacheItemArray = array of TCharWidthCacheItem;

  TCharWidthCache = class
  private
    FSize: Integer;
    FItems: TCharWidthCacheItemArray;

    function CalkHash(AChar: TLMDChar; ACharSet: TFontCharSet;
                      AFs: TFontStyles;
                      out Code: Integer): Integer;
  public
    constructor Create;
    destructor Destroy; override;

    function GetCharWidth(AChar: TLMDChar; ACharSet: TFontCharSet;
                          AFs: TFontStyles): Integer;
    procedure SetCharWidth(AChar: TLMDChar; ACharSet: TFontCharSet;
                           AFs: TFontStyles; AWidth: Integer);
    procedure Clear;
  end;
  {****************************** TScreenCache ********************************}

  TWP_InvisibleOffsetError = class(Exception)
  end;

  TWP_CacheItem = class
  public
    State: TWrapParserState;
    Next: TWP_CacheItem;
  end;

  TWP_CacheItemArray = array of TWP_CacheItem;
  TWP_CacheStateArray = array of TWrapParserState;

  TWP_Cache = class
  private
    FCacheItems: TWP_CacheItemArray;
    FCacheMaxCount: Integer;
    FCacheCount: Integer;
    FCacheItemsFirst: TWP_CacheItem;
    FCacheItemsLast: TWP_CacheItem;

    FSeqItems: TWP_CacheStateArray;
    FSeqItemsCount: Integer;
    FSeqItemsInterval: Integer;

    //Finds item with fields <= cond (upper bound)
    //Returns -1, if all items are > cond, or no items present
    function UpperBoundCache(Offset, X, Y: Integer; Cond: TWP_Condition): Integer;

    function UpperBoundSeq(Offset, X, Y: Integer; Cond: TWP_Condition): Integer;

    procedure MoveCacheItems(AStart, ADest, ACount: Integer);
  public
    LastSeqOffset: Integer;

    constructor Create(AMaxCount, ASeqItemsInterval: Integer);

    destructor Destroy; override;

    //Finds state with Offset < AOffset (lower bound),
    //and if this position is not safe, moves back to the safe position,
    //and removes everything after this safe position
    //
    //Changes: Count, LastOffset
    //Removes items from linked list, changes First and Last
    procedure Invalidate(AOffset: Integer);

    //Finds state with Offset > AOffset (upper bound)
    //Assert: Prev state offset <> AOffset (no duplicates)
    //Inserts item before it, links item to FLast
    //Removes item from FFirst
    procedure PutState(const AState: TWrapParserState);

    procedure AddStateSeq(const AState: TWrapParserState; AChunkOutput: Boolean);

    //Finds state with fields <= than cond (lower bound)
    //Returns: true, if found
    //         false, if all states are > cond
    function GetNearestState(Offset, X, Y: Integer; Cond: TWP_Condition;
                             var Res: TWrapParserState): Boolean;
  end;

  TSARange = record
    Start: Integer;
    Count: Integer;
  end;
  TSARanges = array of TSARange;

  THighlightsSparse = class
  private
    procedure DelRanges(AIdx, ACount: Integer);
    procedure InsRange(AIdx: Integer);

  public
    Ranges: TSARanges;
    RangesCnt: Integer;

    constructor Create;

    //AStart + ACount <= Chars.Count
    procedure AddRange(AStart, ACount: Integer);
    //AStart + ACount <= Chars.Count
    function RemoveRange(AStart, ACount: Integer): Boolean;
    procedure Clear;

    //Returns: -1, if RangesCnt = 0
    //         RangeIdx if AOffset in Range
    //         RangeIdx of range with Start > AOffset if AOffset not in Range
    //         RangesCnt if AOffset = Chars.Count
    function FindRangeIdx(AOffset: Integer): Integer;

    procedure BeforeDelete(AStart, ACount: Integer);
    procedure AfterInsert(AStart, ACount: Integer);
  end;

  TScreenCache = class
  {$ifdef LMDCOMP10}strict{$endif} private
    FStoredView:            TStoredView;

    FValidState:            TScreenCacheValid;
    FScreenIsBuilding:      Boolean;

    FCharCache:             TCharWidthCache;
    FWPCache:               TWP_Cache;
    FWPTokenArr:            TLMDEditParsedTokenArray;

    FHiddenStarts:          TLMDHashTable;
    FHiddenEnds:            TLMDHashTable;
    FHiddenMarks:           ILMDMarkers;
    FCursorMarks:           ILMDMarkers;

    FScreenLines:           TScreenLinesArray;
    FVisibleCountScroll:    Integer;
    FVisibleCountScrollBar: Integer;
    FFirstLineScroll:       Integer;
    FFirstLineSkew:         Integer;
    FFirstLinePhysical:     Integer;
    FFirstInvalidOffset:    Integer;
    FWrapMode:              TLMDViewWrapMode;
    FTabWidth:              Integer;
    FFixedWrapWidth:        Integer;

    FScreenHeightLines:     Integer;
    FScreenWidthPixels:     Integer;
    FCursorPos:             TOffsetPointMark;
    FSelStart:              TOffsetPointMark;
    FSelEnd:                TOffsetPointMark;
    FSelBlock:              Boolean;
    FHorizScroll:           Integer;
    FHorizScrollPixels:     Integer;

    FFont:                  TFont;
    FDefaultAttrs:          TLMDEditAttributes;
    FCanvas:                TCanvas;
    FSpecChars:             TLMDSpecialChars;
    FSpaceCharW:            Integer;
    FSeparatorsSet:         TLMDCharSet;
    FAddictSeparatorsSet:   TLMDCharSet;

    FSpecialCharsSeq:       TLMDSeqFromString;

    FSpecialCharsMap:       array[Low(TLMDSpecialCharKind)..
                                  High(TLMDSpecialCharKind)]
                            of TLMDSegment;

    FSpecialCharsCharSetMap: array[Low(TLMDSpecialCharKind)..
                                  High(TLMDSpecialCharKind)]
                              of TFontCharset;

    FOldScreenHeightLines:      Integer;
    FOldScreenWidthPixels:      Integer;
    FOldLinesOnScreenScroll:    Integer;
    FOldHScrollPixels:          Integer;
    FOldFirstLine:              Integer;
    FOldCursorPos:              TOffsetPoint;
    FOldSelStart:               TOffsetPoint;
    FOldSelEnd:                 TOffsetPoint;
    FOldSelBlock:               Boolean;

    FHighlights:                THighlightsSparse;
    FHighlightAttrs:            TLMDEditAttributes;
    FHighlightUse:              Boolean;

    FAttrsCache:                TAttrsCache;
    /////////////////////////////////////////////////////
    /// MarkTokens and its states
    ///


    //Returns:
    //
    //Cond=wpByOffset:
    //  State with Offset = Target.Offet, State.X,Y is correspondent to State.Offset
    //  If Offset > MaxOffset ==> Stop on MaxOffset
    //  If Offset is invisible ==> Stop on next visible line start
    //
    //Cond=wpByXY, wpByXPixY:
    //  State with Y=Target.Y, X <= Target.X
    //
    //  Allows Y = VisibleCountScroll = 0,
    //         Stops at last Y for Y >  VisibleCountScroll-1
    //
    //Chunks:
    //   Tail chunks: VisWidth=0, Offset: undefined
    //   Other chunks: VisWidth=CharsCount
    function WP_MoveToState(const AStart: TWrapParserState;
                            const Target: TWrapParserState;
                            Cond: TWP_Condition;
                            DoChunkOutput: Boolean;
                            ChunkOutput: PScreenLineInfo): TWrapParserState;

    function WP_GetNearestCached(Offset, X, Y: Integer; Cond: TWP_Condition;
                                 var Res: TWrapParserState): Boolean;

    procedure WP_InvalidateCached(AOffset: Integer);

    procedure WP_InitZeroState(var AState: TWrapParserState);
    function WP_GetStateOff(AOffset: Integer; AOverFolds: Boolean): TWrapParserState;
    function WP_GetState(X, Y: Integer; IsXPix: Boolean; DoCheckY: Boolean): TWrapParserState; overload;
    function WP_FillChunks(AStart: TWrapParserState;
                           APixWidth: Integer;
                           AScreenLine: PScreenLineInfo):
                           TWrapParserState;

    function GetTailSpecCharWidth(AKind: TLMDSpecialCharKind): Integer;

    function GetSegWidth(ASeg: TLMDSegment;
                         AFs: TFontStyles;
                         ACharSet: TFontCharSet): Integer;

    //////////
    /// Screen
    procedure RefreshScreenLinesEnumerator(AMark: ILMDMark; AData: Pointer; var StopHere: Boolean);
    procedure RefreshScreenLines;
    procedure SetDirtyFrom(AStartScreen: Integer);
    procedure UnsetScreenLineDirty(ALine: Integer);
    procedure SetDirty(AStartScreen, AEndScreen: Integer); overload;
    procedure SetDirtyForSel(const  OldS, OldE,
                                    NewS, NewE: TOffsetPoint;
                             AOldBlockMode, ABlockMode: Boolean);

    //////////////
    //Conversions
    function  MarkPtToScrollPt(const APoint: TOffsetPointMark): TPoint;

    function  MarkPtToOffsetPt(const APoint: TOffsetPointMark): TOffsetPoint;

    procedure OffsetPtToMarkPt(AOffPt: TOffsetPoint;
                               var OldVal: TOffsetPointMark);

    procedure GetTabWidths(const AState: TWrapParserState;
                           out ATailW, AHeadW: Integer);
    //Relative to tab (inside)
    procedure ScreenPosToPixFromTab(const AState: TWrapParserState;
                                    TabOff: Integer;
                                    out AStart, ACount: Integer);

    //Relative to tab (inside)
    function  ScreenPixToPosFromTab(const AState: TWrapParserState;
                                    APixOff: Integer): Integer;

    ///////////////////////
    ////State, other
    ///
    procedure CorrectAllParams;

    procedure CheckValidState(ANeedState: TScreenCacheValid);
    procedure AddValidState(ANeedState: TScreenCacheValidItem);
    procedure DelValidState(ANeedState: TScreenCacheValid);
    function  GetStatusChanges: TLMDViewStatusChanges;

    procedure ResetVars(AClearCursor: Boolean);

    function  GetStoreDocSettingsLimit: Integer;
    procedure SetStoreDocSettingsLimit(ALimit: Integer);

    function  ActualWrapWidth: Integer;

    //Adjusts caches to correspond document's content
    procedure Reset(AClearCursor: Boolean);
    ////////////////
    ///  Folds

    procedure UnfoldLow(ALine: Integer; All: Boolean);

    procedure ClearHiddens;
    procedure AddToHidden(const AFold: TParserFold);
    procedure RemoveFromHidden(AStartEntry: THiddenStart;
                               AEndEntry: THiddenEnd);


    ///////////////////////
    ///  Selection, cursor
    procedure SetSelStart(APoint: TPoint);
    procedure SetSelEnd(APoint: TPoint);

    procedure SetHorizScroll(const AScroll: Integer);

    function  GetCursorPos: TPoint;
    function  GetSelStart: TPoint;
    function  GetSelEnd: TPoint;

    function GetCursorOffset: TOffsetPoint;
    function GetSelEndOffset: TOffsetPoint;
    function GetSelStartOffset: TOffsetPoint;
  private
    //////////////////////
    //Checks
    procedure CheckScreenWidthArg(AWidth: Integer);
    procedure CheckScreenHeightArg(AHeight: Integer);
    procedure CheckScrollPosForOffset(AScroll: TPoint);
    procedure CheckScrollRangeForOffset(AStart, AEnd: TPoint);
    procedure CheckLineForFold(ALine: Integer);
    procedure CheckLineForUnfold(ALine: Integer);
    procedure CheckLineIsFold(ALine: Integer);

    procedure CheckTabWidth(AWidth: Integer);
    procedure CheckScrollLineIdx(AScrollLine: Integer; AWithCount: Boolean = false);
    procedure CheckPhysLineIdx(APhysLine: Integer);
    procedure CheckScreenLineIdx(AScreenLine: Integer);
    procedure CheckOffsetForScroll(AOffset: Integer; ACheckCR: Boolean);
    procedure CheckOffsetRange(AStart, ACount: Integer);
    function  IsOffsetInsideCR(AOffset: Integer; var GoodOffset: Integer): Boolean;
    procedure CorrectOffsetPtCR(var AOffsetPt: TOffsetPoint);

    function Parser: TLMDEditParserBase;
    function Buffer: TLMDCharSeq;
    function Doc: TLMDEditDocument;

    procedure DoDelayedUpdate;
    procedure CheckScreenAndRefresh;

    procedure CheckTextChangeScrollBar(AStart, ACount: Integer);
  public
    Parent: TLMDCustomEditView;
  public
    constructor Create(AParent: TLMDCustomEditView;
                       AWrapMode: TLMDViewWrapMode;
                       ATabWidth: Integer;
                       AScreenWidthPixels: Integer;
                       AScreenHeightLines: Integer;
                       AWrapWidth: Integer;
                       AFont: TFont;
                       ACanvas: TCanvas;
                       ASpecChars: TLMDSpecialChars);

    destructor Destroy; override;

    //////////////////////////////
    ///Document
    ///
    procedure AttachToDocument;
    procedure DetachFromDocument(AStoreDoc: Boolean);

    procedure BeforeDelete(AStart, ACount: Integer);
    procedure AfterInsert(AStart, ACount: Integer);
    procedure DocumentRefresh;
    procedure ResetPreserve;

    /////////////////////////////
    ///  Hightlight
    ///

    procedure AddHighlight(AStart, ACount: Integer);
    procedure RemoveHighlight(AStart, ACount: Integer);
    procedure ClearHighlights;
    procedure SetHighlightAttrs(const Attrs: TLMDEditAttributes;
                                AUse: Boolean);

    function  HighlightAttrs: TLMDEditAttributes;
    function  HighlightUse: Boolean;

    ////////////////////////////////////////////////
    //Cache settings
    procedure SetFont(AFont: TFont);
    procedure SetCanvas(ACanvas: TCanvas);

    procedure SetWrapMode(AMode: TLMDViewWrapMode);
    function  WrapMode: TLMDViewWrapMode;
    procedure SetWrapWidth(AWidth: Integer);
    function  WrapWidth: Integer;
    function  WrapWidthPixels: Integer;

    procedure SetTabWidth(AWidth: Integer);
    function  TabWidth: Integer;

    function NoWrap: Boolean;

    function GetFont(AFs: TFontStyles; ACharset: TFontCharset): HFont;
    function GetCharWidth(AChar: TLMDChar;
                          AFs: TFontStyles;
                          ACharSet: TFontCharSet): Integer;
    ////////////////////////////////////////
    //Scroll space
    function CalkVisibleCountScroll: Integer;
    function CalkVisibleCountScrollBar(AForceRecalk: Boolean): Integer;
    function AfterLastScroll(Y: Integer): Boolean;
    procedure CorrectToLastScroll(var Y: Integer);
    procedure CorrectCursorSelPos(var Pt: TPoint);
    procedure CorrectPhysY(var Y: Integer);

    function FirstLineScroll: Integer;
    function FirstLinePhysical: Integer;
    function LastLineScroll: Integer;

    function GetNextVisibleLine(ALine: Integer; ADoCheck: Boolean): Integer;
    function GetPrevVisibleLine(ALine: Integer; ADoCheck: Boolean): Integer;

    function  ScreenCount(ALine: Integer): Integer;

    procedure CorrectScrollPoint(var APoint: TPoint;
                                 AWhatFor: TScrollCorrectCause;
                                 ADirection: TScrollCorrectDirection;
                                 ABlock: Boolean); overload;

    procedure CorrectScrollPoint(var APoint: TOffsetPoint;
                                 AWhatFor: TScrollCorrectCause;
                                 ADirection: TScrollCorrectDirection;
                                 ACorrectAfterWrapFwd: Boolean;
                                 ABlock: Boolean); overload;

    function GetScrollLineVisWidth(ALine: Integer): Integer;
    function GetScrollLineInfo(ALine: Integer): TScrollLineInfo;
    function GetScrollLineOffStart(ALine: Integer): Integer;

    procedure GetPhysLineVisibleBounds(ALine: Integer;
                                       out AFirst, ALast: TOffsetPoint);

    function WP_GetStateOverFolds(AOffset: Integer): TWrapParserState;

    //Returns the last point char of line (last char of last tab),
    //end-of-line position, or just last char in line
    function GetScrollLineOffLast(ALine: Integer): TOffsetPoint;

    /////////////////////////////////////////////////
    //Screen
    //Maximal count of screen lines (screen size)
    procedure SetScreenSize(APixWidth, ALinesHeight: Integer);

    property  ScreenHeightLines: Integer read FScreenHeightLines;
    property  ScreenWidthPixels: Integer read FScreenWidthPixels;

    //Real screen size
    function LinesOnScreenScroll: Integer;
    function OldLinesOnScreenScroll: Integer;

    function  GetScreenLine(ALine: Integer): TScrollLineInfo;
    function  GetScreenLineStart(ALine: Integer): TWrapParserState;
    function  GetScreenLineWordStart(ALine: Integer): Integer;
    function  GetScreenLineWordEnd(ALine: Integer): Integer;
    function  GetScreenLineChunks(ALine: Integer; out Cnt: Integer): PChunk;
    function  GetScreenLineProps(ALine: Integer): TLMDScreenLineProps;

    //With respect of HorizScroll, first and last visible scroll X on line
    procedure GetScreenLineXBounds(AScreenLine: Integer; out AStart, ACount: Integer);
    function  GetScreenLineLastX(AScreenLine: Integer): Integer;
    function  GetScreenLineFirstX(AScreenLine: Integer): Integer;

    // Gives range:
    //  X-range [StartScr.X, EndSrc.X)   - (EndSrc.X - excluding)
    //  Y-range [StartScr.Y, EndSrc.Y]   - both incliding
    // Returns true, if selection is visible (with respect of [HorizScrollPixels, ScreenSizePixels])
    function  SelectionToScreen(out StartScr, EndScr: TPoint): Boolean;

    property  HorizScroll: Integer read FHorizScroll write SetHorizScroll;
    property  HorizScrollPixels: Integer read FHorizScrollPixels;
    /////////////////////////////////
    ///  Conversions
    ///
    function  ScreenToPhysical(AScreen: Integer): Integer;
    function  ScrollToPhysical(AScroll: Integer): Integer;
    //Where is first scroll line, corresponding to that physical
    function  PhysicalToScroll(APhys: Integer): Integer;
    function  ScreenToScroll(AScreen: Integer; DoCheck: Boolean=True): Integer;
    function  ScrollToScreen(AScrollLine: Integer; DoCheck: Boolean=True): Integer;

    function  ScreenPosToScroll(AScreen: TPoint; DoCheck: Boolean = True): TPoint;
    function  ScrollPosToScreen(AScroll: TPoint; DoCheck: Boolean = True): TPoint;

    function WP_GetState(AOffset: Integer): TWrapParserState; overload;
    //Relative to HScrollPixels
    //Returns true, if AStart is on the screen
    function  ScreenPosToScreenPix(AScreen: TPoint;
                                   out AStart, ACount: Integer;
                                   AScreenOnly: Boolean): Boolean;
    procedure ScrollPosToScreenPix(AScroll: TPoint; out AStart, ACount: Integer);
    //Relative to HScrollPixels
    function  ScreenPixToScreenPos(APixW: Integer; AScreenLine: Integer): Integer;
    function  ScreenPixToScrollPos(APixW: Integer; AScrollLine: Integer): Integer;

    function  ScrollXToPixelsFixed(ACol: Integer): Integer;
    function  PixelsToScrollXFixed(AXPix: Integer; ARoundToBigger: Boolean): Integer;

    function FindOffsetInVisibleScreen(AOffset: Integer): Integer;
    function FirstCharOnScreen: Integer;

    function OffsetToScroll(AOffset: Integer): TPoint;
    function ScrollToNearestOffset(AScroll: TPoint): Integer;

    //Gives X-positions of scroll point bounds:
    // .. [0  x  1] ...  ==> [..] is Tab; 0, 1 are Left,Right; x is AScroll
    procedure  GetScrollCharScrollBounds(AScroll: TPoint;
                                         var Left, Right: Integer);

    function  ScrollPtToOffsetPt(AScrollPoint: TPoint): TOffsetPoint;

    function  OffsetPtToScrollPt(APoint: TOffsetPoint): TPoint;

    function  CalkPointVisWidth(AOffPt: TOffsetPoint): Integer; overload;
    function  CalkPointVisWidth(AOffset: Integer): Integer; overload;
    /////////////////////////
    ///  Folds
    ///
    procedure Fold(ALine: Integer; All: Boolean);
    procedure Unfold(ALine: Integer; All: Boolean);

    procedure FoldAllIn(AOuterFold: Integer; TopOnly: Boolean; ARunUpdate: Boolean=true);
    procedure UnfoldAllIn(AOuterFold: Integer; TopOnly: Boolean);

    function IsCollapsedFold(ALine: Integer): Boolean;

    function  IsLineStartVisible(ALine: Integer): Boolean;
    function  IsOffsetVisible(AOffset: Integer): Boolean;
    procedure EnsureOffsetIsVisible(AOffset: Integer);
    function GetNearestValidOffset(AOffset: Integer): Integer;


    /////////////////////////////////////
    ///  Cursor, selection, first line
    ///
    procedure Scroll(AOffset: Integer);
    procedure SetFirstLineAsScroll(ALine: Integer);

    function  IsScrollInScreenBounds(AScrollPos: TPoint): Boolean;
    function  IsScrollInScreenYBounds(AScrollLine: Integer): Boolean;
    function  IsCursorInScreenYBounds: Boolean;
    function  IsCursorInScreenBounds: Boolean;


    procedure SetCursorOffset(AOffPt: TOffsetPoint;
                              ACorrectDir: TScrollCorrectDirection;
                              ABlock: Boolean);
    procedure SetCursorPos(APoint: TPoint; ACorrectDir: TScrollCorrectDirection; ABlock: Boolean);
    property  CursorPos: TPoint read GetCursorPos;

    property  SelStart: TPoint read GetSelStart write SetSelStart;
    property  SelEnd: TPoint read GetSelEnd write SetSelEnd;
    function  SelAvail: Boolean;

    procedure SetSelection(AStart, AEnd: TPoint; ABlock: Boolean); overload;
    procedure SetSelection(AStart, AEnd: TOffsetPoint; ABlock: Boolean); overload;

    function  SelStartN: TPoint;
    function  SelEndN: TPoint;

    property  CursorOffset: TOffsetPoint read GetCursorOffset;
    property  SelStartOffset: TOffsetPoint read GetSelStartOffset;
    property  SelEndOffset: TOffsetPoint read GetSelEndOffset;
    property  SelBlockMode: Boolean read FSelBlock;

    property  StoreDocSettingsLimit: Integer read GetStoreDocSettingsLimit
                                             write SetStoreDocSettingsLimit;
    ///////////////////////////////////
    ///  Status changes, dirty lines
    ///
    property  StatusChanges: TLMDViewStatusChanges read GetStatusChanges;
    procedure ResetStatusChanges;

    procedure SetDirty(AScr: Integer); overload;
    procedure SetDirtyScroll(AScrollLine: Integer);
    function  IsScreenLineDirty(ALine: Integer): Boolean;
    procedure UnsetDirties;
  end;

  {********************************* TViewLst *********************************}

  TViewLst = class(TLMDDocumentListener)
  public
    Parent: TLMDCustomEditView;

    constructor Create(AParent: TLMDCustomEditView);

    procedure BeforeInsert(AStart, ACount: Integer); override;
    procedure AfterInsert(AStart, ACount: Integer); override;
    procedure BeforeDelete(AStart, ACount: Integer); override;
    procedure AfterDelete(AStart, ACount: Integer); override;
    procedure BeforeRefresh; override;
    procedure AfterRefresh; override;
    procedure BeforeSettingsRefresh; override;
    procedure AfterSettingsRefresh; override;
    procedure DocumentDestroing;  override;
    procedure BeforeCompoundEdit(AFreezeViews: Boolean); override;
    procedure AfterCompoundEdit(AFreezeViews: Boolean);  override;
    procedure DoUserEventAfterDocChange; override;

    procedure AfterMarkChange; override;
    procedure BeforeMarkChange; override;

    procedure MarkSettingsChanged(AMarkers: ILMDMarkers;
                                  const AMark: ILMDMark); override;

  end;

  {******************************** TSpacedSeq ********************************}

  TSpacedSeq = class(TLMDCharSeq)
  private
    FSeg: TLMDSegment;
    FSpacesBefore, FSpacesAfter: Integer;
  protected
    procedure FillBuffer(ABufferStart, ABufferEnd: Integer); override;
  public
    constructor Create;

    procedure Reset(const ASeg: TLMDSegment; ASpacesBefore, ASpacesAfter: Integer);
  end;

  TSquaredSeq = class(TLMDSeqFromString)
  public
    constructor Create(AView: TLMDCustomEditView;
                       AStart, AEnd: TPoint);
  end;

  TViewOpCallback = procedure(AView: TLMDCustomEditView; AData: array of const);

  TDefaultKeyBinding = record
    Key: Word;
    Shift: TShiftState;
    Descr: TLMDString;
    Cat: TLMDString;
    Editable: Boolean;
    Modes: TLMDEditCommandModes;
    Command: TLMDEditCommand;
  end;

  TViewRenderer = class(TLMDPrintRendererBase)
  private
    FTask: TLMDEditViewPrintTask;
    FScrSize: TPoint;

    FPagesCount: Integer;
    FSelectedPagesCount: Integer;

    FPageWidth, FPageHeight: Integer;
    FLineHeight: Integer;
    FGutterWidth: Integer;
    FGutterLeftPadding: Integer;
    FDpi: Integer;
    FFont: TFont;
    FCache: TScreenCache;
    FAttrsCache: TObject;

    FSelStartScr: TPoint;
    FSelEndScr: TPoint;
  public
    constructor Create(ATask: TLMDEditViewPrintTask);

    procedure PreparePages(APageWidth, APageHeight: Integer;
                           ACanvas: TCanvas); override;

    procedure FinalizePages; override;

    function  GetPagesCount(ARange: TLMDPrintOperationRange): Integer; override;

    procedure DrawPage(ARange: TLMDPrintOperationRange;
                       ANum: Integer; APoint: TPoint;
                       ACanvas: TCanvas); override;
  end;

  TViewPartParent = class(TLMDViewPartParent)
  public
    View: TLMDCustomEditView;

    constructor Create(AView: TLMDCustomEditView);

    procedure BeginChange; override;
    procedure EndChange(AResetCache: Boolean); override;
    function  GetOwnerComponent: TComponent; override;
  end;

  TViewTaskPartParent = class(TLMDViewPartParent)
  public
    Task: TLMDEditViewPrintTask;

    constructor Create(ATask: TLMDEditViewPrintTask);

    procedure BeginChange; override;
    procedure EndChange(AResetCache: Boolean); override;
    function  GetOwnerComponent: TComponent; override;
  end;

  TComplResizeCorner = (rcTopLeft, rcTopRight, rcBottomLeft, rcBottomRight);
  TComplList = class(TCustomListBox)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure CreateWnd; override;

    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SetCursor;

    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMNCButtonDown(var Message: TWMNCLBUTTONDOWN); message WM_NCLBUTTONDOWN;

    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    procedure MouseUp(Button: TMouseButton;
                      Shift: TShiftState; X, Y: Integer); override;
  public
    Cursor: TCursor;
    Corner: TComplResizeCorner;
    IsVisible: Boolean;

    constructor Create(AOwner: TComponent); override;

    property OnClick;
    property OnDrawItem;
    property OnMeasureItem;
    property ItemHeight;
    property Style;

    procedure Show(AVisible: Boolean; X, Y: Integer);
  end;

{------------------------------------------------------------------------------}
  TIncSearchJump = class
  public
    Start: Integer;
    Text: TLMDString;

    constructor Create(AStart: Integer; AText: TLMDString);
  end;
{------------------------------------------------------------------------------}

const
  csAllValid = [Low(TScreenCacheValidItem)..High(TScreenCacheValidItem)];
  siComplAll = [siComplWordTyping, siComplListShown];
  siComplIncSearch = [siComplWordTyping, siComplListShown, siIncrementalSearch];

  DEF_GUTTER_BARS: array[0..3] of TLMDGutterBarKind = (
    gbBreakpointBar, gbBookmarkBar, gbLineNumberBar, gbFoldBar);
  DEF_GUTTER_BAR_WIDTH = 14;
  DEF_GUTTER_BAR_PADDING = 2;
  WRAP_CACHE_MAX_SIZE = 1000;
  WRAP_CACHE_OFFSET_INTERVAL = 1000;
  MAX_ADDICT_WORD_LENGTH = 100;

  LMDSystemColor = $FF000000;
var
  AllSpaces:           TLMDString;
  EditClipboadFormat:  UINT;

  DefBookmarkImg:      Graphics.TBitmap;
  DefBreakActiveImg:   Graphics.TBitmap;
  DefBreakInactiveImg: Graphics.TBitmap;
  DefBreakDisabledImg: Graphics.TBitmap;
  DefFoldPlusImg:      Graphics.TBitmap;
  DefFoldMinusImg:     Graphics.TBitmap;
  DefWrapLineImg:      Graphics.TBitmap;
  DefDbgTopImg:        Graphics.TBitmap;
  DefDbgActiveImg:     Graphics.TBitmap;

  DefaultKeyBindings: array of TDefaultKeyBinding;

  DummyScreenLine: TScreenLineInfo;
  ChunkWithSpace: TChunk;

{------------------------------------------------------------------------------}

procedure SetTextColor(ADC: HDC; AColor: TColor);
begin
  if (AColor and LMDSystemColor) <> 0 then
  begin
    AColor := AColor and (not LMDSystemColor);
    AColor := GetSysColor(AColor);
  end;

  Windows.SetTextColor(ADC, AColor);
end;

procedure SetBkColor(ADC: HDC; AColor: TColor);
begin
  if (AColor and LMDSystemColor) <> 0 then
  begin
    AColor := AColor and (not LMDSystemColor);
    AColor := GetSysColor(AColor);
  end;

  Windows.SetBkColor(ADC, AColor);  
end;

procedure ChunkInit(Chunk: PChunk);
begin
  Chunk.Attrs.AttributesSet := [];
  Chunk.AttrsWeight := 0;

  Chunk.StateOffset := -1;
  Chunk.StateOffsetCount := 0;

  Chunk.CharSet := 0;

  Chunk.CharsCount := 0;
  SetLength(Chunk.Chars, 0);

  Chunk.CanMerge := false;
  Chunk.IsTail := false;
end;

{------------------------------------------------------------------------------}

function GetAttrsFontStyle(const Attrs: TLMDEditAttributes;
                           const DefAttrs: TLMDEditAttributes): TFontStyles;
begin
  if asFontStyle in Attrs.AttributesSet then
    Result := Attrs.FontStyle + DefAttrs.FontStyle
  else
    Result := DefAttrs.FontStyle;
end;

function CombineAttrs(const Attrs: TLMDEditAttributes;
                      const DefAttrs: TLMDEditAttributes): TLMDEditAttributes;
begin
  if asFontStyle in Attrs.AttributesSet then
    Result.FontStyle := Attrs.FontStyle + DefAttrs.FontStyle
  else
    Result.FontStyle := DefAttrs.FontStyle;

  if asBackgroundColor in Attrs.AttributesSet then
    Result.BackgroundColor := Attrs.BackgroundColor
  else
    Result.BackgroundColor := DefAttrs.BackgroundColor;

  if asTextColor in Attrs.AttributesSet then
    Result.TextColor := Attrs.TextColor
  else
    Result.TextColor := DefAttrs.TextColor;

  Result.CustomAttributes := nil;
  Result.AttributesSet := Attrs.AttributesSet + DefAttrs.AttributesSet;
end;

procedure InitDefImages;

  function _GetImg(const Name: string): Graphics.TBitmap;
  begin
    Result                 := SedGetResourceImage(Name);
    Result.TransparentMode := tmAuto;
    Result.Transparent     := True;
  end;

begin
  DefBookmarkImg      := _GetImg('BOOKMARK');
  DefBreakActiveImg   := _GetImg('BREAK_ACTIVE');
  DefBreakDisabledImg := _GetImg('BREAK_DISABLED');
  DefBreakInactiveImg := _GetImg('BREAK_INACTIVE');
  DefFoldPlusImg      := _GetImg('FOLD_PLUS');
  DefFoldMinusImg     := _GetImg('FOLD_MINUS');
  DefWrapLineImg      := _GetImg('WRAP_LINE');
  DefDbgTopImg        := _GetImg('DBG_TOP');
  DefDbgActiveImg     := _GetImg('DBG_ACTIVE');
end;

{------------------------------------------------------------------------------}

procedure ShortCutToKeys(AShortcut: TShortCut;
                         out AKey: Word;
                         out AShift: TShiftState);
begin
  AKey := AShortcut and (not (scShift or scCtrl or scAlt));
  AShift := [];

  if (scShift and AShortcut)<>0 then
    Include(AShift, ssShift);

  if (scCtrl and AShortcut)<>0 then
    Include(AShift, ssCtrl);

  if (scAlt and AShortcut)<>0 then
    Include(AShift, ssAlt);
end;

{------------------------------------------------------------------------------}

procedure FinDefImages;
begin
  DefBookmarkImg.Free;
  DefFoldPlusImg.Free;
  DefFoldMinusImg.Free;
  DefBreakActiveImg.Free;
  DefBreakInactiveImg.Free;
  DefBreakDisabledImg.Free;
  DefWrapLineImg.Free;
  DefDbgTopImg.Free;
  DefDbgActiveImg.Free;
end;

{------------------------------------------------------------------------------}

function AttributesEquals(const Attr1: TLMDEditAttributes;
                          const Attr2: TLMDEditAttributes): Boolean;
begin
  Result := (Attr1.AttributesSet = Attr2.AttributesSet) and
            (Attr1.BackgroundColor = Attr2.BackgroundColor) and
            (Attr1.TextColor = Attr2.TextColor) and
            (Attr1.FontStyle = Attr2.FontStyle);
end;

procedure AddSegToCharArray(var Arr: TLMDCharArray; var ArrCnt: Integer;
                            const Seg: TLMDSegment);
var
    i: Integer;
begin
  if Length(Arr) < (ArrCnt + Seg.Count) then
    SetLength(Arr, ((ArrCnt + Seg.Count) * 3) div 2);

  for i := ArrCnt to ArrCnt+Seg.Count-1 do
    Arr[i] := Seg.Source[Seg.Start + i - ArrCnt];

  ArrCnt := ArrCnt + Seg.Count;
end;

{------------------------------------------------------------------------------}

function OffsetPt(AOffset: Integer; AInCharOffset: Integer = 0): TOffsetPoint; overload;
begin
  Result.Offset := AOffset;
  Result.InCharOffset := AInCharOffset;
end;

{------------------------------------------------------------------------------}

function CmpOffsetPt(const APt1, APt2: TOffsetPoint): Integer; overload;
begin
  Result := APt1.Offset - APt2.Offset;
  if Result=0 then
    Result := APt1.InCharOffset - APt2.InCharOffset;
end;

function CmpOffsetPt(const APt1: TOffsetPoint; const APt2: TOffsetPointMark): Integer; overload;
begin
  Result := APt1.Offset - APt2.CharMark.Pos;
  if Result=0 then
    Result := APt1.InCharOffset - APt2.InCharOffset;
end;

{*************************** THiddenHashTraits ********************************}
{------------------------------------------------------------------------------}

class function THiddenHashTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := MakeIntHash(THiddenEntry(AItem).KeyLine);
end;

{------------------------------------------------------------------------------}

class function THiddenHashTraits.MakeHashK(const AKey): Integer;
begin
  Result := MakeIntHash(Integer(AKey));
end;

{------------------------------------------------------------------------------}

class function THiddenHashTraits.Compare(const AKey; AItem: TObject): Boolean;
begin
  Result := THiddenEntry(AItem).KeyLine = Integer(AKey);
end;

{***************************** THiddenStartTraits *****************************}
{------------------------------------------------------------------------------}

class function THiddenStartTraits.OnUpdate(AItem: TObject): TLMDHashUpdateAction;
var
  SEntry: THiddenStart;
  EEntry: THiddenEnd;
begin
  SEntry := THiddenStart(AItem);
  EEntry := SEntry.EEnd;

  Result := uaNothing;

  if (not (SEntry.KeyMark.IsValid and EEntry.KeyMark.IsValid)) or
     (SEntry.KeyMark.Line=EEntry.KeyMark.Line)  then
  begin
    EEntry.RemoveFromStarts(SEntry);

    if SEntry.KeyMark.IsValid then
      SEntry.KeyMark.DeleteFromCollection;

    Result := uaDelete;
  end
  else if SEntry.KeyLine<>SEntry.KeyMark.Line then
    SEntry.KeyLine := SEntry.KeyMark.Line;
end;

{****************************** THiddenEndTraits ******************************}
{------------------------------------------------------------------------------}

class function THiddenEndTraits.OnUpdate(AItem: TObject): TLMDHashUpdateAction;
var
  EEntry: THiddenEnd;
  i, L: Integer;
begin
  EEntry := THiddenEnd(AItem);

  Result := uaNothing;
  EEntry.ShrinkStarts;
  L := Length(EEntry.Starts);

  if (not EEntry.KeyMark.IsValid) or (L=0) then
  begin
    Result := uaDelete;

    { TODO : Should not happen }
    {$ifdef MY_SED_MORE_DEBUG}
    Assert(L=0);
    {$endif}

    if L<>0 then
    begin
      for i := 0 to L - 1 do
        EEntry.RemoveFromStarts(EEntry.Starts[0]);

      EEntry.ShrinkStarts;
    end;

    if EEntry.KeyMark.IsValid then
      EEntry.KeyMark.DeleteFromCollection;
  end
  else if EEntry.KeyLine<>EEntry.KeyMark.Line then
    EEntry.KeyLine := EEntry.KeyMark.Line;

  if Result <> uaDelete then
  begin
    Assert(EEntry.KeyLine=EEntry.KeyMark.Line);
    Assert(L>0);

    for i:=0 to L-1 do
    begin
      {$ifdef MY_SED_MORE_DEBUG}
      Assert(EEntry.Starts[i].KeyLine=EEntry.Starts[i].KeyMark.Line);
      {$endif}

      Assert(EEntry.Starts[i].KeyLine < EEntry.KeyLine);
    end;
  end;
end;

{******************************** THiddenEntry ********************************}
{------------------------------------------------------------------------------}

destructor THiddenEntry.Destroy;
begin
  Self.KeyMark := nil;
  Self.KeyLine := -1;

  inherited;
end;

{******************************** THiddenEnd **********************************}
{------------------------------------------------------------------------------}

procedure THiddenEnd.RemoveFromStarts(AStart: THiddenStart);
var
  i, L: Integer;
begin
  L := Length(Starts);
  Assert(L>0);

  i := 0;
  while i<>L do
    if Starts[i]=AStart then
      Break
    else
      Inc(i);

  Assert(i<>L);

  while i<>L-1 do
  begin
    Starts[i] := Starts[i+1];
    Inc(i);
  end;

  Starts[i] := nil;
end;

{------------------------------------------------------------------------------}

procedure THiddenEnd.ShrinkStarts;
var
  i, L: Integer;
begin
  L := Length(Starts);
  i := 0;
  while (i<L) and (Starts[i]<>nil) do
    Inc(i);

  if i<>L then
    SetLength(Starts, i);
end;

{------------------------------------------------------------------------------}

function ComparePoints(P1, P2: TPoint): Integer;
begin
  if P1.Y = P2.Y then
    Result := P1.X - P2.X
  else
    Result := P1.Y - P2.Y
end;

{------------------------------------------------------------------------------}

function GetTabWidth(AVisPosition, AMaxTabWidth: Integer): Integer;
begin
  Result := (AVisPosition div AMaxTabWidth) * AMaxTabWidth + AMaxTabWidth -
             AVisPosition;
end;

{------------------------------------------------------------------------------}

procedure DestroyChunkLines(var ALines: TScreenLinesArray);
var
  i: Integer;
begin
  for i := 0 to Length(ALines)-1 do
  begin
    ALines[i].ChunksCount := 0;

    SetLength(ALines[i].Chunks, 0);
    SetLength(ALines[i].Offsets, 0);
    ALines[i].OffsetsCount := -1;
  end;
end;

{******************************** TScreenCache ********************************}
{------------------------------------------------------------------------------}

function TScreenCache.Parser: TLMDEditParserBase;
begin
  Result := Doc.GetParser;
end;

{------------------------------------------------------------------------------}

function TScreenCache.Buffer: TLMDCharSeq;
begin
  Result := Doc.Chars;
end;

{------------------------------------------------------------------------------}

function TScreenCache.Doc: TLMDEditDocument;
begin
  Result := Parent.MyDoc;
end;

{------------------------------------------------------------------------------}

function  TScreenCache.NoWrap: Boolean;
begin
  Result := FWrapMode=wmNoWrap;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckPhysLineIdx(APhysLine: Integer);
  procedure RaiseErr;
  begin
    raise ELMDEditViewError.CreateFmt(SLMDSedViewBadPhysLineIdx,
                                      [APhysLine, 0, Doc.LinesCount-1]);
  end;
begin
  if not LMDInRange(APhysLine, 0, Doc.LinesCount-1) then
    RaiseErr;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckScreenWidthArg(AWidth: Integer);
begin
  if AWidth < 1 then
    raise ELMDEditViewError.CreateFmt(SLMDSedViewBadScreenWidth, [AWidth]);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckScreenHeightArg(AHeight: Integer);
begin
  if AHeight < 1 then
    raise ELMDEditViewError.CreateFmt(SLMDSedViewBadScreenHeight, [AHeight]);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckScrollPosForOffset(AScroll: TPoint);

  procedure RaiseErr;
  begin
    if AScroll.X < 0 then
       raise ELMDEditViewError.Create(SLMDSedViewBadNegativeScrollXInPos)
    else if AScroll.Y < 0 then
       raise ELMDEditViewError.Create(SLMDSedViewBadNegativeScrollYInPos)
    else
      raise ELMDEditViewError.CreateFmt(SLMDSedViewBadScrollPosForOffset,
                                        [AScroll.Y, 0, CalkVisibleCountScroll-1]);
  end;

begin
  CheckValidState([csFolds, csConversionCaches]);

  if (AScroll.X < 0) or (AScroll.Y < 0) or AfterLastScroll(AScroll.Y) then
    RaiseErr;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckScrollRangeForOffset(AStart, AEnd: TPoint);
  procedure RaiseErr;
  begin
    raise ELMDEditViewError.CreateFmt(SLMDSedViewBadScrollRangeOrder,
      [AStart.X, AStart.Y, AEnd.X, AEnd.Y]);
  end;
begin
  CheckScrollPosForOffset(AStart);
  CheckScrollPosForOffset(AEnd);

  if (AStart.Y > AEnd.Y) or ((AStart.Y = AEnd.Y) and (AStart.X > AEnd.X)) then
    RaiseErr;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckLineForFold(ALine: Integer);
  procedure RaiseErr;
  begin
    raise ELMDEditViewError.CreateFmt(SLMDSedViewCollapsedLineOp, [ALine]);
  end;
begin
  CheckLineIsFold(ALine);
  CheckValidState([csFolds]);

  if IsCollapsedFold(ALine) then
    RaiseErr;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckLineForUnfold(ALine: Integer);

  procedure RaiseErr;
  begin
    raise ELMDEditViewError.CreateFmt(SLMDSedViewNotCollapsedLineOp, [ALine]);
  end;

begin
  CheckValidState([csFolds]);

  if not IsCollapsedFold(ALine) then
    RaiseErr;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckLineIsFold(ALine: Integer);

  procedure RaiseErr;
  begin
    raise ELMDEditViewError.CreateFmt(SLMDSedViewOpWithFoldOnly, [ALine]);
  end;

begin
  CheckValidState([csFolds]);

  if not Parser.IsFoldStart(ALine) then
    RaiseErr;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckTabWidth(AWidth: Integer);
begin
  if (AWidth < 1) or (AWidth > MAX_TAB_WIDTH) then
    raise ELMDEditViewError.CreateFmt(SLMDSedViewBadTabWidth, [AWidth, 1, MAX_TAB_WIDTH]);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckScrollLineIdx(AScrollLine: Integer; AWithCount: Boolean);
var
    Last: Integer;

  procedure RaiseErr;
  begin
    if AScrollLine < 0 then
       raise ELMDEditViewError.Create(SLMDSedViewBadNegativeScrollY)
    else
       raise ELMDEditViewError.CreateFmt(SLMDSedViewBadScrollLine,
                                        [AScrollLine, 0, Last]);
  end;
begin
  CheckValidState([csFolds, csConversionCaches]);

  Last := AScrollLine;
  CorrectToLastScroll(Last);
  if AWithCount then
    Inc(Last);

  if (AScrollLine < 0) or (AScrollLine > Last) then
    RaiseErr;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckScreenLineIdx(AScreenLine: Integer);

  procedure RaiseErr;
  begin
    raise ELMDEditViewError.CreateFmt(SLMDSedViewBadScreenLine,
      [AScreenLine, 0, LinesOnScreenScroll-1]);
  end;

begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);

  if not LMDInRange(AScreenLine, 0, LinesOnScreenScroll - 1) then
    RaiseErr;
end;

{------------------------------------------------------------------------------}

function TScreenCache.IsOffsetInsideCR(AOffset: Integer;
                                       var GoodOffset: Integer): Boolean;
var
  Ln: Integer; Seg: TLMDSegment;
begin
  Ln := Doc.GetLineByOffset(AOffset);
  Seg := Doc.LineSegments[Ln];

  Result := (AOffset < Seg.Start) or (AOffset > (Seg.Start + Seg.Count));

  if Result then
    GoodOffset := Seg.Start
  else
    GoodOffset := AOffset;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CorrectOffsetPtCR(var AOffsetPt: TOffsetPoint);
var
    Off: Integer;
begin
  if IsOffsetInsideCR(AOffsetPt.Offset, Off) then
  begin
    AOffsetPt.Offset := Off;
    AOffsetPt.InCharOffset := 0;
  end;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CorrectCursorSelPos(var Pt: TPoint);
begin
  CheckValidState([csConversionCaches, csFolds]);

  Pt.X := Max(0, Pt.X);
  Pt.Y := Max(0, Pt.Y);
  CorrectToLastScroll(Pt.Y);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CorrectPhysY(var Y: Integer);
begin
  Y := Min(Y, Doc.LinesCount - 1);
  Y := Max(0, Y);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckOffsetForScroll(AOffset: Integer; ACheckCR: Boolean);
  procedure RaiseErr;
  begin
    raise ELMDEditViewError.CreateFmt(SLMDSedViewBadOffsetForScroll, [AOffset]);
  end;

  var
      Dummy: Integer;
begin
  Exit;

  if not LMDInRange(AOffset, 0, Buffer.Count) then
    RaiseErr;

  if ACheckCR and IsOffsetInsideCR(AOffset, Dummy) then
    RaiseErr;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckOffsetRange(AStart, ACount: Integer);
  procedure RaiseErr;
  begin
    raise ELMDEditViewError.CreateFmt(SLMDSedViewBadOffsetRange, [AStart, ACount]);
  end;

  var
      Dummy: Integer;
begin
  if ACount < 0 then
    RaiseErr;

  if not LMDInRange(AStart, 0, Buffer.Count) then
    RaiseErr;

  if not LMDInRange(AStart + ACount, 0, Buffer.Count) then
    RaiseErr;

  if IsOffsetInsideCR(AStart, Dummy) then
    RaiseErr;

  if IsOffsetInsideCR(AStart + ACount, Dummy) then
    RaiseErr;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckValidState(ANeedState: TScreenCacheValid);
begin
  if csScreen in ANeedState then
    Assert(csScreen in FValidState);

  if csCursor in ANeedState then
    Assert(csCursor in FValidState);

  if csFolds in ANeedState then
    Assert(csFolds in FValidState);

  if csConversionCaches in ANeedState then
    Assert(csConversionCaches in FValidState);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.AddValidState(ANeedState: TScreenCacheValidItem);
begin
  Include(FValidState, ANeedState);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.DelValidState(ANeedState: TScreenCacheValid);
begin
  FValidState := FValidState - ANeedState;
end;

{------------------------------------------------------------------------------}

function TScreenCache.GetCharWidth(AChar: TLMDChar;
                                   AFs: TFontStyles;
                                   ACharSet: TFontCharSet): Integer;
var
    HF: HFONT;
begin
  Result := FCharCache.GetCharWidth(AChar, ACharSet, AFs);

  if Result = -1 then
  begin
    if FCanvas <> nil then
    begin
      HF := FAttrsCache.GetFont(AFs, ACharSet);
      SelectObject(FCanvas.Handle, HF);

      Result := LMDSedCharWidth(FCanvas, AChar);
    end
    else
      Result := FSpaceCharW;

    FCharCache.SetCharWidth(AChar, ACharSet, AFs, Result);
  end;
end;

function TScreenCache.GetSegWidth(ASeg: TLMDSegment;
                                  AFs: TFontStyles;
                                  ACharSet: TFontCharSet): Integer;
var
    i: Integer;
begin
  Result := 0;
  for i := ASeg.Start to ASeg.Start + ASeg.Count - 1 do
    Result := Result + GetCharWidth(ASeg.Source[i], AFs, ACharSet);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.ResetVars(AClearCursor: Boolean);
var
    Cnt: Integer;
    Str: TLMDString;
    Ch: TLMDChar;
    spec: TLMDSpecialCharKind;
    Sz: TSize;
begin
  FCharCache.Clear;
  WP_InvalidateCached(0);

  FVisibleCountScroll   := -1;
  FVisibleCountScrollBar := -1;

  FFirstLinePhysical := 0;
  FFirstLineScroll   := -1;
  FFirstLineSkew     := 0;
  FValidState        := [];

  FFirstInvalidOffset := 0;

  if AClearCursor then
  begin
    if FCursorMarks<>nil then
    begin
      FCursorMarks.Clear;

      FCursorPos.InCharOffset := 0;
      FCursorPos.CharMark := FCursorMarks.CreateMarkAtOffset(0);

      FSelStart.InCharOffset := 0;
      FSelStart.CharMark := FCursorMarks.CreateMarkAtOffset(0);

      FSelEnd.InCharOffset := 0;
      FSelEnd.CharMark := FCursorMarks.CreateMarkAtOffset(0);
    end;
  end;

  FHorizScroll := 0;
  FHorizScrollPixels := 0;

  DestroyChunkLines(FScreenLines);
  SetLength(FScreenLines, 0);

  FSpaceCharW := -1;
  if FCanvas <> nil then
    FSpaceCharW := GetCharWidth(LMDSpace, [], FFont.Charset)
  else
  begin
    Sz := SedGetFontScreenSize(FFont);

    FSpaceCharW := Sz.cx;
  end;

  FDefaultAttrs.AttributesSet := [];
  FDefaultAttrs.BackgroundColor := clWhite;
  FDefaultAttrs.TextColor := FFont.Color;
  FDefaultAttrs.FontStyle := FFont.Style;
  FDefaultAttrs.CustomAttributes := nil;

  FSeparatorsSet.Clear;
  FSeparatorsSet.IncludeChars(Doc.GetFullWordSeparators);

  FAddictSeparatorsSet.Clear;

{$IFDEF LMD_UNICODE}
  FAddictSeparatorsSet.IncludeCats([ukLu, ukLl, ukLt, ukNd, ukNl]);
{$ELSE}
  FAddictSeparatorsSet.IncludeChars('~!@#$%^&*()}{|\?><<,./\][=-_+`');
{$ENDIF}
  FAddictSeparatorsSet.Invert;

  for spec := Low(spec) to High(spec) do
  begin
    if spec in FSpecChars.ShowCharKinds then
    begin
      if FSpecChars.UseCharSet then
        FSpecialCharsCharSetMap[spec] := FSpecChars.Charset
      else
        FSpecialCharsCharSetMap[spec] := FFont.Charset;

      Ch := FSpecChars.GetDecodedChar(spec);
    end
    else
    begin
      Ch := ' ';
      FSpecialCharsCharSetMap[spec] := FFont.Charset;
    end;

    Cnt := 1;
    if spec <> skTabTail then
      Str := Str + Ch
    else
    begin
      //We should add enough chars for maximal tab width
      Str := Str + LMDFillString(TabWidth-1, Ch);

      if skTabHead in FSpecChars.ShowCharKinds then
        Ch := FSpecChars.GetDecodedChar(skTabHead)
      else
        Ch := ' ';

      Str := Str + Ch;
      Cnt := TabWidth;
    end;

    FSpecialCharsMap[spec] := LMDSegment(Length(Str)-Cnt, Cnt, FSpecialCharsSeq);
  end;

  FSpecialCharsSeq.Reset(Str);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.Reset(AClearCursor: Boolean);//W+L+
begin
  ResetVars(AClearCursor);
  if AClearCursor then
    ClearHiddens;

  DoDelayedUpdate;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.ResetPreserve;
var
  Sc, First, Horiz: Integer;
begin
  First := FFirstLinePhysical;
  Horiz := FHorizScroll;

  Reset(false);

  First := LMDMinMax(First, 0, Doc.LinesCount-1);
  EnsureOffsetIsVisible(Doc.LineSegments[First].Start);

  Sc := PhysicalToScroll(First);
  SetFirstLineAsScroll(Sc);

  if WrapMode<>wmWrapToWindow then
    SetHorizScroll(Horiz);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.SetFont(AFont: TFont);
begin
  FFont := AFont;

  FAttrsCache.Reset(FFont);
    
  ResetPreserve;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.SetWrapMode(AMode: TLMDViewWrapMode);
begin
  if AMode=FWrapMode then
    Exit;

  FWrapMode := AMode;
  ResetPreserve;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.SetWrapWidth(AWidth: Integer);
begin
  if AWidth = FFixedWrapWidth then
    Exit;

  FFixedWrapWidth := AWidth;

  if FWrapMode = wmWrapToRuler then
    ResetPreserve;
end;

{------------------------------------------------------------------------------}

function  TScreenCache.WrapWidth: Integer;
begin
  Result := FFixedWrapWidth;
end;

{------------------------------------------------------------------------------}

function  TScreenCache.WrapWidthPixels: Integer;
begin
  Result := ScrollXToPixelsFixed(WrapWidth);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.SetTabWidth(AWidth: Integer);
begin
  if AWidth=FTabWidth then
    Exit;

  Assert(AWidth > 0);

  FTabWidth := AWidth;
  ResetPreserve;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.SetCanvas(ACanvas: TCanvas);
begin
  if ACanvas = FCanvas then
    Exit;

  FCanvas := ACanvas;
  ResetPreserve;
end;

{------------------------------------------------------------------------------}

function  TScreenCache.TabWidth: Integer;
begin
  Result := FTabWidth;
end;

{------------------------------------------------------------------------------}

function  TScreenCache.WrapMode: TLMDViewWrapMode;
begin
  Result := FWrapMode;
end;

{------------------------------------------------------------------------------}

constructor TScreenCache.Create(AParent: TLMDCustomEditView;
                                AWrapMode: TLMDViewWrapMode;
                                ATabWidth: Integer;
                                AScreenWidthPixels: Integer;
                                AScreenHeightLines: Integer;
                                AWrapWidth: Integer;
                                AFont: TFont;
                                ACanvas: TCanvas;
                                ASpecChars: TLMDSpecialChars);
begin
  inherited Create;

  FScreenIsBuilding := false;
  SetLength(FWPTokenArr, 512);

  FHighlights := THighlightsSparse.Create;
  FHighlightUse := true;
  FHighlightAttrs.CustomAttributes := nil;
  FHighlightAttrs.AttributesSet := [asBackgroundColor];
  FHighlightAttrs.BackgroundColor := DEFAULT_HIGHLIGHT_BG;
  FHighlightAttrs.FontStyle := [];
  FHighlightAttrs.TextColor := DEFAULT_HIGHLIGHT_TEXT;

  FSpecialCharsSeq := TLMDSeqFromString.Create('');
  FSeparatorsSet := TLMDCharSet.Create;
  FAddictSeparatorsSet := TLMDCharSet.Create;
  FCharCache := TCharWidthCache.Create;
  FWPCache := TWP_Cache.Create(WRAP_CACHE_MAX_SIZE, WRAP_CACHE_OFFSET_INTERVAL);
  FFont := AFont;
  FCanvas := ACanvas;
  FSpecChars := ASpecChars;

  FSpaceCharW := -1;

  FOldScreenHeightLines  := 0;
  FOldScreenWidthPixels  := 0;

  FOldLinesOnScreenScroll := 0;
  FOldHScrollPixels := 0;
  FOldFirstLine := 0;
  FOldCursorPos := OffsetPt(0, 0);
  FOldSelStart := OffsetPt(0, 0);
  FOldSelEnd := OffsetPt(0, 0);
  FOldSelBlock := false;

  Parent := AParent;

  FWrapMode             := AWrapMode;
  FFixedWrapWidth       := AWrapWidth;
  FTabWidth             := ATabWidth;
  FScreenWidthPixels    := AScreenWidthPixels;
  FScreenHeightLines    := AScreenHeightLines;

  FHiddenStarts := TLMDHashTable.Create(THiddenStartTraits, True);
  FHiddenEnds := TLMDHashTable.Create(THiddenEndTraits, True);

  FCursorMarks := nil;
  FCursorPos.CharMark := nil;
  FSelStart.CharMark := nil;
  FSelEnd.CharMark := nil;
  FCursorPos.InCharOffset := 0;
  FSelStart.InCharOffset := 0;
  FSelEnd.InCharOffset := 0;
  FSelBlock := false;

  FStoredView := TStoredView.Create(self, STORED_VIEW_DOC_LIMIT);

  FAttrsCache := TAttrsCache.Create(FFont);

  ResetVars(true);
end;

{------------------------------------------------------------------------------}

destructor TScreenCache.Destroy;
begin
  DestroyChunkLines(FScreenLines);

  FHiddenStarts.Free;
  FHiddenEnds.Free;
  FHiddenMarks := nil;
  FCursorMarks := nil;
  FCursorPos.CharMark := nil;
  FSelStart.CharMark := nil;
  FSelEnd.CharMark := nil;

  FStoredView.Free;

  FCharCache.Free;
  FSeparatorsSet.Free;
  FAddictSeparatorsSet.Free;
  FSpecialCharsSeq.Free;
  FWPCache.Free;

  FHighlights.Free;

  FAttrsCache.Free;
    
  inherited;
end;

{------------------------------------------------------------------------------}

function TScreenCache.IsLineStartVisible(ALine: Integer): Boolean;//L-
begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckPhysLineIdx(ALine);

  Result := IsOffsetVisible(Doc.LineSegments[ALine].Start);
end;

{------------------------------------------------------------------------------}

function  TScreenCache.IsCollapsedFold(ALine: Integer): Boolean;//L-
begin
  CheckPhysLineIdx(ALine);

  Result := FHiddenStarts.Find(ALine)<>nil;
end;

{------------------------------------------------------------------------------}

function  TScreenCache.IsScrollInScreenBounds(AScrollPos: TPoint): Boolean;
var
    XS, XCnt, Y: Integer;
begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);

  Result := IsScrollInScreenYBounds(AScrollPos.Y);
  if Result then
  begin
    Y := ScrollToScreen(AScrollPos.Y);

    GetScreenLineXBounds(Y, XS, XCnt);

    Result := LMDInRange(AScrollPos.X, XS, XS+XCnt-1);
  end;
end;

{------------------------------------------------------------------------------}

function  TScreenCache.IsScrollInScreenYBounds(AScrollLine: Integer): Boolean;
begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);

  Result := LMDInRange(AScrollLine, FirstLineScroll, LastLineScroll);
end;

{------------------------------------------------------------------------------}

function TScreenCache.IsCursorInScreenBounds: Boolean;
begin
  Result := IsScrollInScreenBounds(CursorPos);
end;

function TScreenCache.IsCursorInScreenYBounds: Boolean;
begin
  Result := IsScrollInScreenYBounds(CursorPos.Y);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.ClearHiddens;
begin
  FHiddenStarts.Clear;
  FHiddenEnds.Clear;
  if FHiddenMarks<>nil then
    FHiddenMarks.Clear;
end;

procedure TScreenCache.CorrectAllParams;

  function EnsureVis(AOff: TOffsetPointMark): TOffsetPoint;
  var
      off: Integer;
  begin
    Result := MarkPtToOffsetPt(AOff);
    off := GetNearestValidOffset(Result.Offset);
    if off <> Result.Offset then
      Result := OffsetPt(off);
  end;

var
  NewCursor, NewSelStart, NewSelEnd: TOffsetPoint;
begin
  CheckValidState([csFolds, csConversionCaches, csScreen]);

  NewCursor := EnsureVis(FCursorPos);
  CorrectScrollPoint(NewCursor, scForCursor, scBackward, true, FSelBlock);

  NewSelStart := EnsureVis(FSelStart);
  NewSelEnd := EnsureVis(FSelEnd);

  if (CmpOffsetPt(NewSelStart, FSelStart) <> 0) or
     (CmpOffsetPt(NewSelEnd, FSelEnd) <> 0)
  then
  begin
    NewSelStart := NewCursor;
    NewSelEnd := NewCursor;
  end;

  CorrectScrollPoint(NewSelStart, scForSelection, scBackward, true, FSelBlock);
  CorrectScrollPoint(NewSelEnd,   scForSelection, scBackward, true, FSelBlock);

  if (CmpOffsetPt(NewCursor, FCursorPos) <> 0) or
     (CmpOffsetPt(NewSelStart, FSelStart) <> 0) or
     (CmpOffsetPt(NewSelEnd, FSelEnd) <> 0)
  then
    SetDirtyFrom(0);
  {TODO: check selection change}

  OffsetPtToMarkPt(NewCursor, FCursorPos);
  OffsetPtToMarkPt(NewSelStart, FSelStart);
  OffsetPtToMarkPt(NewSelEnd, FSelEnd);

  AddValidState(csCursor);
end;

procedure TScreenCache.CorrectScrollPoint(var APoint: TPoint;
                                          AWhatFor: TScrollCorrectCause;
                                          ADirection: TScrollCorrectDirection;
                                          ABlock: Boolean);
var
  OffPt: TOffsetPoint;
begin
  CheckValidState([csFolds, csConversionCaches]);

  OffPt := ScrollPtToOffsetPt(APoint);

  CorrectScrollPoint(OffPt, AWhatFor, ADirection, true, ABlock);

  APoint := OffsetPtToScrollPt(OffPt);
end;

procedure TScreenCache.CorrectScrollPoint(var APoint: TOffsetPoint;
                                          AWhatFor: TScrollCorrectCause;
                                          ADirection: TScrollCorrectDirection;
                                          ACorrectAfterWrapFwd: Boolean;
                                          ABlock: Boolean);
var
  BoundToChars: Boolean;
  State: TWrapParserState;
  Ln, PixS, Dummy, Off, PixCnt: Integer;
  Pt: TPoint;
begin
  CheckValidState([csFolds, csConversionCaches]);

  BoundToChars := (vsCursorBoundToChars in Parent.ViewSettings) and
                  (not ABlock);

  Assert(LMDInRange(APoint.Offset, 0, Buffer.Count));
  Assert(APoint.InCharOffset >= 0);

  CorrectOffsetPtCR(APoint);

  ///
  State := WP_GetState(APoint.Offset);
  if (not State.IsTail) then
  begin
    if APoint.InCharOffset > State.VisWidth-1 then
    begin
      if not ACorrectAfterWrapFwd then
        APoint.InCharOffset := State.VisWidth-1
      else if IsOffsetVisible(APoint.Offset+1) then
      begin
        Inc(APoint.Offset);
        APoint.InCharOffset := 0;
      end
      else
      begin
        Ln := GetNextVisibleLine(State.PhysLine, true);
        if Ln < Doc.LinesCount then
          APoint := OffsetPt(Doc.LineSegments[Ln].Start)
        else
          APoint.InCharOffset := State.VisWidth-1;
      end;
    end
    else if BoundToChars then
    begin
      if (ADirection = scForward) and
         (APoint.InCharOffset > 0) and
         IsOffsetVisible(APoint.Offset)
      then
          Inc(APoint.Offset);

      APoint.InCharOffset := 0;
    end;
  end
  else if ((AWhatFor = scForSelection) or BoundToChars) and
          (not SelBlockMode)
  then
    APoint.InCharOffset := 0
  else if (not NoWrap) and (APoint.InCharOffset > 0) then
  begin
    Pt.Y := State.Y;
    Pt.X := State.X + APoint.InCharOffset;

    ScrollPosToScreenPix(Pt, PixS, PixCnt);
    if PixS + PixCnt > ActualWrapWidth then
    begin
      if ACorrectAfterWrapFwd and
         (APoint.Offset < Buffer.Count)
      then
      begin
        Off := APoint.Offset;

        Inc(APoint.Offset);
        while IsOffsetInsideCR(APoint.Offset, Dummy) do
          Inc(APoint.Offset);

        if not IsOffsetVisible(APoint.Offset) then
          APoint.Offset := Off;

        APoint.InCharOffset := 0;
      end
      else
      begin
        Pt.X := ScreenPixToScrollPos(ActualWrapWidth-1, Pt.Y);

        APoint.InCharOffset := Pt.X - State.X;
      end;
    end;
  end;

  CheckOffsetForScroll(APoint.Offset, true);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.AttachToDocument;

procedure RestoreFrom(AData: TStoredViewData);

function GetPos(const AMark: ILMDMark): TOffsetPoint;
begin
  Result.InCharOffset := 0;

  if (AMark<>nil) and AMark.IsValid then
    Result.Offset := AMark.Pos
  else
    Result.Offset := 0;

  CorrectOffsetPtCR(Result);

  EnsureOffsetIsVisible(Result.Offset);
end;

var
    i, Ln, StartF: Integer;
    Off, Off1: TOffsetPoint;
    Pos: TPoint;
    M: ILMDLineMark;
begin
  ///
  Off := GetPos(AData.ScreenStart);
  Pos := OffsetPtToScrollPt(Off);
  SetFirstLineAsScroll(Pos.Y);
  ///

  Off := GetPos(AData.Cursor);
  SetCursorOffset(Off, scBackward, AData.SelBlockMode);

  Off := GetPos(AData.SelStart);
  Off1 := GetPos(AData.SelEnd);

  SetSelection(Off, Off1, AData.SelBlockMode);

  Ln := AData.Folds.Count;

  for i := 0 to Ln - 1 do
  begin
    M := AData.Folds.Marks(i);

    if M.IsValid then
    begin
      StartF := M.Line;
      if Parser.IsFoldStart(StartF) and (not IsCollapsedFold(StartF)) then
        Fold(StartF, false);
    end;
  end;
end;

var
    Data: TStoredViewData;
begin
  Assert(FHiddenMarks=nil);
  Assert(FCursorMarks=nil);

  FHiddenMarks := Doc.CreateCustomLineMarkers(False, False);
  FCursorMarks := Doc.CreateCustomMarkers(True, False, False);

  Assert(FCursorPos.CharMark=nil);
  FCursorPos.CharMark := FCursorMarks.CreateMarkAtOffset(0);
  FCursorPos.InCharOffset := 0;

  Assert(FSelStart.CharMark=nil);
  FSelStart.CharMark := FCursorMarks.CreateMarkAtOffset(0);
  FSelStart.InCharOffset := 0;

  Assert(FSelEnd.CharMark=nil);
  FSelEnd.CharMark := FCursorMarks.CreateMarkAtOffset(0);
  FSelEnd.InCharOffset := 0;

  Reset(true);

  Data := FStoredView.GetDataByDoc(Doc);
  if Data <> nil then
  begin
    RestoreFrom(Data);
    FStoredView.RemoveData(Data);
  end;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.DetachFromDocument(AStoreDoc: Boolean);
begin
  FHighlights.Clear;

  if AStoreDoc then
    FStoredView.AttachCurrentDoc;

  ClearHiddens;
  Assert(FHiddenMarks<>nil);

  Doc.DetachCustomMarkers(FHiddenMarks);
  FHiddenMarks := nil;

  FCursorMarks.Clear;
  Doc.DetachCustomMarkers(FCursorMarks);
  FCursorMarks := nil;

  FCursorPos.CharMark := nil;
  FSelEnd.CharMark := nil;
  FSelStart.CharMark := nil;
end;

{------------------------------------------------------------------------------}
function TScreenCache.ActualWrapWidth: Integer;
begin
  case FWrapMode of
    wmNoWrap: Result := MaxInt;
    wmWrapToRuler: Result := WrapWidthPixels;
    wmWrapToWindow: Result := FScreenWidthPixels;
  else
    Result := -1;
    Assert(false);
  end;
end;

procedure TScreenCache.AddToHidden(const AFold: TParserFold);
var
  AStart, AEnd: ILMDLineMark;
  Cnt, EndL:    Integer;
  SEntry:       THiddenStart;
  EEntry:       THiddenEnd;

  procedure CreateEntry(IsStart: Boolean);
  begin
    if not IsStart then
    begin
      EEntry := THiddenEnd.Create;

      EEntry.KeyLine := AEnd.Line;
      EEntry.KeyMark := AEnd;//inc reference count

      SetLength(EEntry.Starts, 1);
      EEntry.Starts[0] := SEntry;

      SEntry.EEnd := EEntry;

      FHiddenEnds.Add(EEntry);
    end
    else
    begin
      SEntry := THiddenStart.Create;

      SEntry.KeyLine := AStart.Line;
      SEntry.KeyMark := AStart;
      SEntry.EEnd := nil;

      FHiddenStarts.Add(SEntry);
    end;
  end;

  procedure AddToEndEntry;
  var
    start, i, j, L: Integer;
  begin
    i := 0;

    L := Length(EEntry.Starts);
    Assert(L>0);

    start := AStart.Line;

    while i<L do
      if EEntry.Starts[i].KeyLine > start then
        Break
      else
        Inc(i);

    SetLength(EEntry.Starts, L+1);
    for j := L-1 downto i do
      EEntry.Starts[j+1] := EEntry.Starts[j];

    EEntry.Starts[i] := SEntry;

    SEntry.EEnd := EEntry;
  end;

begin
  //(**) - in case of multiple fold starts on same line,
  //       we will process outer starts only. see Cache.Fold comment (***) also
  if AFold.StartLine=AFold.ParentLine then
    Exit;

  Assert(FHiddenStarts.Find(AFold.StartLine)=nil);
  Assert(AFold.EndLine>AFold.StartLine);

  Cnt := FHiddenMarks.GetMarksCountByLines(AFold.StartLine, 1);
  Assert(Cnt=0);

  AStart := FHiddenMarks.CreateMarkAtLine(AFold.StartLine);

  AEnd := FHiddenMarks.GetLastLineMark(AFold.EndLine);

  if AEnd=nil then
    AEnd := FHiddenMarks.CreateMarkAtLine(AFold.EndLine);

  CreateEntry(True);

  EndL := AEnd.Line;
  EEntry := THiddenEnd(FHiddenEnds.Find(EndL));

  if EEntry=nil then
    CreateEntry(False)
  else
    AddToEndEntry;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.RemoveFromHidden(AStartEntry: THiddenStart;
  AEndEntry: THiddenEnd);
var
  Mark: ILMDLineMark;
  Ok: Boolean;
begin
  Assert(AStartEntry<>nil);
  Assert(AEndEntry<>nil);
  Assert(AStartEntry.KeyMark.Line=AStartEntry.KeyLine);
  Assert(AEndEntry.KeyMark.Line=AEndEntry.KeyLine);

  Mark := AStartEntry.KeyMark;

  AEndEntry.RemoveFromStarts(AStartEntry);
  AEndEntry.ShrinkStarts;

  Ok := FHiddenStarts.Remove(AStartEntry.KeyLine);
  Assert(Ok);

  FHiddenMarks.DeleteMark(Mark);

  // if all starts of this end are removed,
  // then remove end too
  if Length(AEndEntry.Starts)=0 then
  begin
    Mark := AEndEntry.KeyMark;

    Ok := FHiddenEnds.Remove(AEndEntry.KeyLine);
    Assert(Ok);
    
    FHiddenMarks.DeleteMark(Mark);
  end;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.SetHorizScroll(const AScroll: Integer);
begin
  CheckValidState(csAllValid);

  if AScroll <> FHorizScroll then
  begin
    Assert(AScroll >= 0);

    FHorizScroll := AScroll;
    FHorizScrollPixels := ScrollXToPixelsFixed(FHorizScroll);

    DelValidState([csScreen]);

    DoDelayedUpdate;
    SetDirtyFrom(0);
  end;
end;

{------------------------------------------------------------------------------}

{
  1. Update hidden FoldID cache.
  2. Update Scroll-variables:
      * decrement them...
      * if first line is inside fold:
          set first line as fold end
  3. Update screen cache: cases:
     1) First line after end of fold or
        last screen line is before start of fold: do nothing
     2) First line is inside fold or before start of fold
        * regenerate cache from start (more easy)
        * set screen dirty from fold start
}

procedure TScreenCache.Fold(ALine: Integer; All: Boolean);//V+L-S+
var
  EndLine: Integer;
  AFold: TParserFold;
begin
  CheckValidState([csFolds]);
  CheckLineForFold(ALine);

  //Update first line and VisibleCount
  EndLine := Parser.GetFoldEnd(ALine);

  if IsLineStartVisible(ALine) then
  begin
    DelValidState([csScreen, csConversionCaches, csCursor]);

    //Last, we move screen cache and recalk it
    //Also, we recalk scroll and firstline variables
    if LMDInRange(FFirstLinePhysical, ALine+1, EndLine) then
    begin
      FFirstLinePhysical := ALine;
      FFirstLineSkew := 0;
    end;

    FFirstInvalidOffset := Doc.LineSegments[ALine].Start;

    FVisibleCountScrollBar := -1;
  end;

  AFold.StartLine := ALine;
  AFold.EndLine := EndLine;

  //(***)
  /// Parser.IsFoldStart/GetFoldEnd -
  //  they works on outer nodes in case of multiple fold starts/ends
  //  on _same_ line
  //  See AddToHidden (**) comment also
  AFold.ParentLine := -1;

  AddToHidden(AFold);

  if All then
    FoldAllIn(ALine, False, False);

  DoDelayedUpdate;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.FoldAllIn(AOuterFold: Integer; TopOnly: Boolean; ARunUpdate: Boolean);
var
  L, LE, FS, FE: Integer;
  Entry:         THiddenStart;
  AFold:         TParserFold;
begin
  CheckValidState([csFolds]);

  FS := AOuterFold;
  if FS = -1 then
    FE := Doc.LinesCount - 1
  else if IsCollapsedFold(FS) then
  begin
    Entry := THiddenStart(FHiddenStarts.Find(FS));
    FE := Entry.EEnd.KeyLine;
  end
  else
  begin
    CheckLineForFold(FS);
    FE := Parser.GetFoldEnd(FS);
  end;

  L := FS + 1;
  while L < FE do
  begin
    Entry := THiddenStart(FHiddenStarts.Find(L));

    if Entry <> nil then //collapsed fold
    begin
      if TopOnly then
        L := GetNextVisibleLine(L, False) //jump over folded top line
      else
      begin
        LE := Entry.EEnd.KeyLine;
        if not (Parser.IsFoldStart(L) and Parser.IsFoldEnd(LE)) then
          UnfoldLow(L, False)
        else
          L := L+1;
      end;
    end
    else if Parser.IsFoldStart(L) then
    begin
      DelValidState([csScreen, csCursor, csConversionCaches]);

      FVisibleCountScrollBar := -1;

      if FFirstInvalidOffset = -1 then
        FFirstInvalidOffset := Doc.LineSegments[L].Start
      else
        FFirstInvalidOffset := Min(Doc.LineSegments[L].Start, FFirstInvalidOffset);

      AFold.StartLine := L;
      AFold.EndLine := Parser.GetFoldEnd(L);

      //(***)
      AFold.ParentLine := -1;

      AddToHidden(AFold);

      if LMDInRange(FFirstLinePhysical, AFold.StartLine+1, AFold.EndLine) then
      begin
        FFirstLinePhysical := AFold.StartLine;
        FFirstLineScroll := -1;
        FFirstLineSkew := 0;
      end;

      if TopOnly then
        L := GetNextVisibleLine(L, False)
      else
        L := L+1;
    end
    else
      L := L+1;
  end;

  if ARunUpdate then
    DoDelayedUpdate;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.UnfoldAllIn(AOuterFold: Integer; TopOnly: Boolean);
var
  L, LE, FS, FE: Integer;
  Entry:         THiddenStart;
begin
  CheckValidState([csFolds]);

  FS := AOuterFold;
  if FS=-1 then
    FE := Doc.LinesCount-1
  else if IsCollapsedFold(FS) then
  begin
    Entry := THiddenStart(FHiddenStarts.Find(FS));
    FE := Entry.EEnd.KeyLine;
  end
  else
  begin
    CheckLineIsFold(FS);
    FE := Parser.GetFoldEnd(FS);
  end;

  L := FS+1;
  while L<FE do
  begin
    if IsCollapsedFold(L) then
    begin
      DelValidState([csScreen, csConversionCaches]);

      FVisibleCountScrollBar := -1;

      if FFirstInvalidOffset = -1 then
        FFirstInvalidOffset := Doc.LineSegments[L].Start
      else
        FFirstInvalidOffset := Min(FFirstInvalidOffset, Doc.LineSegments[L].Start);

      LE := GetNextVisibleLine(L, False);
      UnfoldLow(L, not TopOnly);
      L := LE;
    end
    else
      L := L+1;
  end;

  DoDelayedUpdate;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.UnfoldLow(ALine: Integer; All: Boolean);
var
  L, EndLine: Integer;
  Entry:      THiddenStart;
begin
  CheckValidState([csFolds]);
  CheckLineForUnfold(ALine);

  Entry := THiddenStart(FHiddenStarts.Find(ALine));
  Assert(Entry <> nil);

  EndLine := Entry.EEnd.KeyLine;
  Assert(EndLine > ALine);

  if All then
  begin
    for L := ALine to EndLine-1 do
    begin
      Entry := THiddenStart(FHiddenStarts.Find(L));
      if Entry <> nil then
        RemoveFromHidden(Entry, Entry.EEnd);
    end;
  end
  else
    RemoveFromHidden(Entry, Entry.EEnd);
end;

{------------------------------------------------------------------------------}

function TScreenCache.SelAvail: Boolean;
begin
  Result := not LMDPointsEqual(SelStart, SelEnd);
end;

function TScreenCache.SelectionToScreen(out StartScr, EndScr: TPoint): Boolean;
begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);

  StartScr := ScrollPosToScreen(SelStartN, false);
  EndScr := ScrollPosToScreen(SelEndN, false);

  Result := SelAvail and (EndScr.Y >= 0) and (StartScr.Y < LinesOnScreenScroll);

  StartScr.Y := Max(StartScr.Y, 0);
  EndScr.Y := Min(EndScr.Y, LinesOnScreenScroll-1);
end;

function TScreenCache.SelEndN: TPoint;
begin
  if ComparePoints(SelEnd, SelStart)>0 then
    Result := SelEnd
  else
    Result := SelStart;
end;

function TScreenCache.SelStartN: TPoint;
begin
  if ComparePoints(SelEnd, SelStart) > 0 then
    Result := SelStart
  else
    Result := SelEnd;
end;

procedure TScreenCache.SetCursorOffset(AOffPt: TOffsetPoint;
                                       ACorrectDir: TScrollCorrectDirection;
                                       ABlock: Boolean);
begin
  if (AOffPt.Offset = FCursorPos.CharMark.Pos) and
     (AOffPt.InCharOffset = FCursorPos.InCharOffset) and
     (ABlock = FSelBlock)
  then
    Exit;

  CheckValidState(csAllValid);
  CheckOffsetForScroll(AOffPt.Offset, false);

  if FSelBlock <> ABlock then
    SetDirtyFrom(0);

  FSelBlock := ABlock;

  if IsCursorInScreenBounds then
    SetDirty(ScrollToScreen(CursorPos.Y));

  CorrectOffsetPtCR(AOffPt);
  EnsureOffsetIsVisible(AOffPt.Offset);
  CorrectScrollPoint(AOffPt, scForCursor, ACorrectDir, true, FSelBlock);

  OffsetPtToMarkPt(AOffPt, FCursorPos);

  if IsCursorInScreenBounds then
    SetDirty(ScrollToScreen(CursorPos.Y));
end;

procedure TScreenCache.SetCursorPos(APoint: TPoint;
                                    ACorrectDir: TScrollCorrectDirection;
                                    ABlock: Boolean);
begin
  CorrectCursorSelPos(APoint);

  SetCursorOffset( ScrollPtToOffsetPt(APoint), ACorrectDir, ABlock );
end;

procedure TScreenCache.SetSelStart(APoint: TPoint);
begin
  SetSelection(APoint, SelEnd, SelBlockMode);
end;

procedure TScreenCache.SetStoreDocSettingsLimit(ALimit: Integer);
begin
  FStoredView.SetDataLimit(ALimit);
end;

procedure TScreenCache.SetSelection(AStart, AEnd: TOffsetPoint;
                                    ABlock: Boolean);
var
  Dir: TScrollCorrectDirection;
  OldS, OldE: TOffsetPoint;
begin
  CheckValidState(csAllValid);

  CheckOffsetForScroll(AStart.Offset, false);
  CheckOffsetForScroll(AEnd.Offset, false);

  CorrectOffsetPtCR(AStart);
  CorrectOffsetPtCR(AEnd);

  EnsureOffsetIsVisible(AStart.Offset);
  EnsureOffsetIsVisible(AEnd.Offset);

  if (AStart.Offset > SelStartOffset.Offset) or
     ((AStart.Offset = SelStartOffset.Offset) and
      (AStart.InCharOffset > SelStartOffset.InCharOffset))
  then
    Dir := scForward
  else
    Dir := scBackward;

  CorrectScrollPoint(AStart, scForSelection, Dir, true, ABlock);

  if (AEnd.Offset > SelEndOffset.Offset) or
     ((AEnd.Offset = SelEndOffset.Offset) and
      (AEnd.InCharOffset > SelEndOffset.InCharOffset))
  then
    Dir := scForward
  else
    Dir := scBackward;

  CorrectScrollPoint(AEnd, scForSelection, Dir, true, ABlock);

  OldS := MarkPtToOffsetPt(FSelStart);
  OldE := MarkPtToOffsetPt(FSelEnd);

  SetDirtyForSel(OldS, OldE, AStart, AEnd, FSelBlock, ABlock);

  OffsetPtToMarkPt(AStart, FSelStart);
  OffsetPtToMarkPt(AEnd, FSelEnd);
  FSelBlock := ABlock;
end;

procedure TScreenCache.SetSelection(AStart, AEnd: TPoint; ABlock: Boolean);
begin
  CorrectCursorSelPos(AStart);
  CorrectCursorSelPos(AEnd);

  SetSelection(ScrollPtToOffsetPt(AStart),
               ScrollPtToOffsetPt(AEnd),
               ABlock);
end;

procedure TScreenCache.SetSelEnd(APoint: TPoint);
begin
  SetSelection(SelStart, APoint, SelBlockMode);
end;

{------------------------------------------------------------------------------}

{
  1. Update fold cache.
  2. If fold start is visible, then:
    1. increment scroll variables, (FirstLine - if fold is above FirstLine)
      if fold is in screen range:
        1. Move screen cache after fold end
        2. Update screen cache in fold
}

procedure TScreenCache.Unfold(ALine: Integer; All: Boolean);
begin
  CheckValidState([csFolds]);
  CheckLineForUnfold(ALine);

  if IsLineStartVisible(ALine) then
  begin
    DelValidState([csScreen, csConversionCaches]);
    FFirstInvalidOffset := Doc.LineSegments[ALine].Start;

    FVisibleCountScrollBar := -1;
  end;

  UnfoldLow(ALine, All);

  DoDelayedUpdate;
end;

{------------------------------------------------------------------------------}

function TScreenCache.GetCursorOffset: TOffsetPoint;
begin
  Result := MarkPtToOffsetPt(FCursorPos);
end;

{------------------------------------------------------------------------------}

function TScreenCache.GetCursorPos: TPoint;
begin
  Result := MarkPtToScrollPt(FCursorPos);
end;

function TScreenCache.GetFont(AFs: TFontStyles; ACharset: TFontCharset): HFont;
begin
  Result := FAttrsCache.GetFont(AFs, ACharset);
end;

{------------------------------------------------------------------------------}

function TScreenCache.GetNextVisibleLine(ALine: Integer;
  ADoCheck: Boolean): Integer;
var
  Entry: THiddenStart;
begin
  CheckValidState([csFolds]);

  if ADoCheck then
    CheckPhysLineIdx(ALine);

  // Assert:  ALine is visible.
  // All entries in FHiddenStarts are valid line starts (all the invalid was
  // removed in DoDelayedUpdate)

  Entry := THiddenStart(FHiddenStarts.Find(ALine));

  if Entry=nil then
    Result := ALine + 1
  else
  begin
    Assert(Entry.KeyLine<Entry.EEnd.KeyLine);

    Result := Entry.EEnd.KeyLine+1;
  end;
end;

{------------------------------------------------------------------------------}

function TScreenCache.GetPrevVisibleLine(ALine: Integer;
  ADoCheck: Boolean): Integer;
var
  Prev:  Integer;
  Entry: THiddenEnd;
begin
  CheckValidState([csFolds]);

  if ADoCheck and (ALine<>Doc.LinesCount) then
    CheckPhysLineIdx(ALine);

  // Assert:  ALine is visible
  // All entries in FHiddenEnds are valid line ends (all the invalid was
  // removed in DoDelayedUpdate)

  Prev := ALine-1;
  Entry := THiddenEnd(FHiddenEnds.Find(Prev));
  if Entry=nil then
    Result := Prev
  else
  begin
    Assert(Length(Entry.Starts)>0);
    Result := Entry.Starts[0].KeyLine;
    Assert(Result<Entry.KeyLine);
  end;
end;

{------------------------------------------------------------------------------}

function TScreenCache.ScrollToPhysical(AScroll: Integer): Integer;
begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckScrollLineIdx(AScroll, true);

  Result := WP_GetState(0, AScroll, false, true).PhysLine;
end;

{------------------------------------------------------------------------------}

function TScreenCache.PhysicalToScroll(APhys: Integer): Integer;
var
  Res: TWrapParserState;
  Off: Integer;

  procedure RaiseErr;
  begin
    raise ELMDEditViewError.CreateFmt(SLMDSedViewInvisibleLine, [APhys]);
  end;

begin
  CheckValidState([csFolds, csConversionCaches]);

  if APhys=Doc.LinesCount then
    Result := CalkVisibleCountScroll
  else
  begin
    CheckPhysLineIdx(APhys);

    Off := Doc.LineSegments[APhys].Start;
    try
      Res := WP_GetState(Off);
      Result := Res.Y;
    except
      on E: TWP_InvisibleOffsetError do
      begin
        RaiseErr;
        Result := -1;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

function TScreenCache.ScreenCount(ALine: Integer): Integer;//W+V-
var
    Y: Integer;
begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckPhysLineIdx(ALine);

  Y := GetNextVisibleLine(ALine, false);
  Result := PhysicalToScroll(Y) - PhysicalToScroll(ALine);
end;

{------------------------------------------------------------------------------}

function  TScreenCache.ScreenToScroll(AScreen: Integer;
  DoCheck: Boolean): Integer;
begin
  CheckValidState([csFolds, csConversionCaches]);

  if DoCheck then
    CheckScreenLineIdx(AScreen);

  Result := FirstLineScroll+AScreen;
end;

{------------------------------------------------------------------------------}

function  TScreenCache.ScrollToScreen(AScrollLine: Integer;
  DoCheck: Boolean): Integer;

  procedure RaiseErr;
  begin
    raise ELMDEditViewError.CreateFmt(SLMDSedViewBadScrollLineToScrConvert,
      [AScrollLine, FirstLineScroll, FirstLineScroll+LinesOnScreenScroll-1]);
  end;

begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckScrollLineIdx(AScrollLine);

  Result := AScrollLine - FirstLineScroll;
  if DoCheck then
  begin
    CheckValidState([csScreen]);

    if not LMDInRange(Result, 0, LinesOnScreenScroll-1) then
      RaiseErr;
  end;
end;

{------------------------------------------------------------------------------}

function TScreenCache.ScreenToPhysical(AScreen: Integer): Integer;
begin
  CheckValidState([csScreen]);
  CheckScreenLineIdx(AScreen);

  Result := FScreenLines[AScreen].ScrollInfo.PhysicalLine;
end;

{------------------------------------------------------------------------------}
procedure TScreenCache.BeforeDelete(AStart, ACount: Integer);
var
  StartLn, EndLn: Integer;
begin
  if ACount = 0 then
    Exit;

  DelValidState([csScreen, csCursor, csFolds, csConversionCaches]);

  if FFirstInvalidOffset = -1  then
    FFirstInvalidOffset := AStart
  else
    FFirstInvalidOffset := Min(FFirstInvalidOffset, AStart);

  StartLn := Doc.GetLineByOffset(AStart);
  EndLn := Doc.GetLineByOffset(AStart+ACount);

  //Correct first line, if needed
  if LMDInRange(FFirstLinePhysical, StartLn, EndLn) then
    FFirstLinePhysical := StartLn
  else if EndLn < FFirstLinePhysical then
    Dec(FFirstLinePhysical, EndLn-StartLn);

  CheckTextChangeScrollBar(AStart, ACount);

  FHighlights.BeforeDelete(AStart, ACount);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.DocumentRefresh;
begin
  FHighlights.Clear;

  ResetPreserve;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.AddHighlight(AStart, ACount: Integer);
begin
  CheckOffsetRange(AStart, ACount);

  FHighlights.AddRange(AStart, ACount);

  DelValidState([csScreen, csConversionCaches]);

  if FFirstInvalidOffset = -1  then
    FFirstInvalidOffset := AStart
  else
    FFirstInvalidOffset := Min(FFirstInvalidOffset, AStart);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.RemoveHighlight(AStart, ACount: Integer);
begin
  CheckOffsetRange(AStart, ACount);

  if FHighlights.RemoveRange(AStart, ACount) then
  begin
    DelValidState([csScreen, csConversionCaches]);

    if FFirstInvalidOffset = -1  then
      FFirstInvalidOffset := AStart
    else
      FFirstInvalidOffset := Min(FFirstInvalidOffset, AStart);
  end;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.ClearHighlights;
var
    FirstInv: Integer;
begin
  if FHighlights.RangesCnt > 0 then
    FirstInv := FHighlights.Ranges[0].Start
  else
    FirstInv := -1;

  FHighlights.Clear;

  if FirstInv <> -1 then
  begin
    DelValidState([csScreen, csConversionCaches]);

    if FFirstInvalidOffset = -1  then
      FFirstInvalidOffset := FirstInv
    else
      FFirstInvalidOffset := Min(FFirstInvalidOffset, FirstInv);
  end;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.SetHighlightAttrs(const Attrs: TLMDEditAttributes;
                                        AUse: Boolean);
begin
  FHighlightAttrs := Attrs;
  FHighlightUse := AUse;

  if FHighlights.RangesCnt > 0 then
    ResetPreserve;
end;

{------------------------------------------------------------------------------}

function TScreenCache.HighlightAttrs: TLMDEditAttributes;
begin
  Result := FHighlightAttrs;
end;

{------------------------------------------------------------------------------}

function TScreenCache.HighlightUse: Boolean;
begin
  Result := FHighlightUse;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.AfterInsert(AStart, ACount: Integer);
var
  StartLn, EndLn, InsCount: Integer;
begin
  if ACount=0 then
    Exit;

  DelValidState([csScreen, csCursor, csFolds, csConversionCaches]);

  /////

  StartLn := Doc.GetLineByOffset(AStart);
  EndLn := Doc.GetLineByOffset(AStart+ACount);
  InsCount := EndLn-StartLn;

  if StartLn < FFirstLinePhysical then
    Inc(FFirstLinePhysical, InsCount);

  if FFirstInvalidOffset = -1  then
    FFirstInvalidOffset := AStart
  else
    FFirstInvalidOffset := Min(FFirstInvalidOffset, AStart);

  CheckTextChangeScrollBar(AStart, ACount);

  FHighlights.AfterInsert(AStart, ACount);
end;

{------------------------------------------------------------------------------}

procedure  TScreenCache.DoDelayedUpdate;//S+W+

  procedure CheckHiddens(AfterUpdate: Boolean);
  {$ifdef MY_SED_MORE_DEBUG}
  var
      List: TList;
      i, j, L: Integer;
      Entry: THiddenStart;
      EEntry: THiddenEnd;
  begin
    List := TList.Create;
    try
      FHiddenStarts.GetAll(List);

      for i := 0 to List.Count - 1 do
      begin
        Entry := THiddenStart(List[i]);

        Assert(FHiddenStarts.Find(Entry.KeyLine)=Entry);
        Assert(Entry.EEnd<>nil);

        if AfterUpdate then
        begin
          Assert(Entry.KeyMark.IsValid);
          Assert(Entry.EEnd.KeyMark.IsValid);

          Assert(Entry.KeyLine = Entry.KeyMark.Line);
          Assert(FHiddenEnds.Find(Entry.EEnd.KeyLine)=Entry.EEnd);
          Assert(Entry.EEnd.KeyLine = Entry.EEnd.KeyMark.Line);
        end;

        j := 0;
        L := Length(Entry.EEnd.Starts);
        Assert(L<>0);

        while j <> L do
        begin
          if Entry.EEnd.Starts[j]=Entry then
            Break;

          Inc(j);
        end;

        Assert(j<>L);
      end;

      List.Clear;

      FHiddenEnds.GetAll(List);

      for i := 0 to List.Count - 1 do
      begin
        EEntry := THiddenEnd(List[i]);

        Assert(FHiddenEnds.Find(EEntry.KeyLine)=EEntry);

        if AfterUpdate then
        begin
          Assert(EEntry.KeyMark.IsValid);
          Assert(EEntry.KeyLine = EEntry.KeyMark.Line);
        end;

        j := 0;
        L := Length(EEntry.Starts);
        Assert(L<>0);

        while j <> L do
        begin
          Entry := EEntry.Starts[j];

          Assert(Entry<>nil);
          Assert(Entry.EEnd=EEntry);

          if AfterUpdate then
          begin
            Assert(Entry.KeyMark.IsValid);
            Assert(Entry.KeyLine=Entry.KeyMark.Line);
          end;

          Assert(FHiddenStarts.Find(Entry.KeyLine)=Entry);

          Inc(j);
        end;
      end;
    finally
      List.Free;
    end;
  end;
  {$else}
  begin end;
  {$endif}

  procedure RefreshHiddenFolds;
  var
      OldS, OldE: Integer;
  begin
    OldS := FHiddenStarts.Count;
    OldE := FHiddenEnds.Count;

    CheckHiddens(false);

    FHiddenStarts.Update;
    FHiddenEnds.Update;

    CheckHiddens(true);

    if (FHiddenStarts.Count <> OldS) or (FHiddenEnds.Count <> OldE) then
    begin
      DelValidState([csConversionCaches]);
      FFirstInvalidOffset := 0;

      FVisibleCountScrollBar := -1;
    end;
  end;

var
    Y, Ph: Integer;
begin
  if not (csFolds in FValidState) then
  begin
    RefreshHiddenFolds;
    AddValidState(csFolds);
  end;

  if not (csConversionCaches in FValidState) then
  begin
    Assert(FFirstInvalidOffset <> -1);

    WP_InvalidateCached(FFirstInvalidOffset);
    AddValidState(csConversionCaches);

    Assert(FFirstLinePhysical >= 0);

    FFirstLineScroll := PhysicalToScroll(FFirstLinePhysical);

    Y := FFirstLineScroll + FFirstLineSkew;
    CorrectToLastScroll(Y);
    FFirstLineSkew := Y - FFirstLineScroll;

    Ph := ScrollToPhysical(Y);
    if Ph <> FFirstLinePhysical then
    begin
      Assert(Ph > FFirstLinePhysical);

      FFirstLinePhysical := Max(0, FFirstLinePhysical - 1);
      FFirstLineScroll := PhysicalToScroll(FFirstLinePhysical);

      Y := PhysicalToScroll(FFirstLinePhysical + 1);
      FFirstLineSkew := Y - FFirstLineScroll - 1;
    end;

    Assert(FFirstLineSkew >= 0);

    FFirstInvalidOffset := -1;
    FVisibleCountScroll := -1;
  end;

  if not (csScreen in FValidState) then
    CheckScreenAndRefresh;

  if not (csCursor in FValidState) then
  begin
    CorrectAllParams;

    AddValidState(csCursor);
  end;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.GetScreenLineXBounds(AScreenLine: Integer;
                                           out AStart, ACount: Integer);
begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);
  CheckScreenLineIdx(AScreenLine);

  AStart := FScreenLines[AScreenLine].XBoundStart;
  ACount := FScreenLines[AScreenLine].XBoundCount;
end;

function  TScreenCache.GetScreenLineLastX(AScreenLine: Integer): Integer;
var
    St, Cnt: Integer;
begin
  GetScreenLineXBounds(AScreenLine, St, Cnt);
  Result := St + Cnt - 1;
end;

{------------------------------------------------------------------------------}
function  TScreenCache.GetScreenLineFirstX(AScreenLine: Integer): Integer;
var
    St, Cnt: Integer;
begin
  GetScreenLineXBounds(AScreenLine, St, Cnt);
  Result := St;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CheckTextChangeScrollBar(AStart, ACount: Integer);
var
  i: Integer; ch: TLMDChar;
begin
  for i := AStart to AStart + ACount - 1 do
  begin
    Ch := Doc.Chars[i];
    if (Ch = LMDCR) or (Ch = LMDLF) then
    begin
      FVisibleCountScrollBar := -1;
      Break;
    end;
  end;
end;

procedure TScreenCache.CheckScreenAndRefresh;//V+

function ChunkEquals(ACh1, ACh2: PChunk): Boolean;
var
    i: Integer;
begin
  Result := (ACh1.CharSet=ACh2.CharSet) and
            (ACh1.CharsCount=ACh2.CharsCount) and
             AttributesEquals(ACh1.Attrs, ACh2.Attrs);

  if Result then
    for i := 0 to ACh1.CharsCount - 1 do
    begin
      Result := ACh1.Chars[i]=ACh2.Chars[i];
      if not Result then
        Break;
    end;
end;

var
  OldScreen: TScreenLinesArray;
  i: Integer;
  ChunkOld, ChunkNew: PChunk;
  ChunkCnt: Integer;
begin
  CheckValidState([csFolds, csConversionCaches]);

  SetLength(OldScreen, Length(FScreenLines));
  for i := 0 to Length(FScreenLines) - 1 do
  begin
    OldScreen[i] := FScreenLines[i];
    OldScreen[i].Offsets := Copy(FScreenLines[i].Offsets);

    SetLength(FScreenLines[i].Offsets, 0);
  end;

  SetLength(FScreenLines, 0);

  RefreshScreenLines;
  UnsetDirties;

  for i := 0 to Min(Length(OldScreen), Length(FScreenLines))-1 do
  begin
    if  (OldScreen[i].ScrollInfo.VisProps <> FScreenLines[i].ScrollInfo.VisProps) or
        (OldScreen[i].ChunksCount <> FScreenLines[i].ChunksCount)
    then
    begin
      SetDirty(i);
      Continue;
    end;

    ChunkCnt := OldScreen[i].ChunksCount;
    if ChunkCnt > 0 then
    begin
      ChunkOld := @OldScreen[i].Chunks[0];
      ChunkNew := @FScreenLines[i].Chunks[0];
    end
    else
    begin
      ChunkOld := nil;
      ChunkNew := nil;
    end;

    while (ChunkCnt <> 0) and ChunkEquals(ChunkOld, ChunkNew) do
    begin
      Dec(ChunkCnt);
      Inc(ChunkOld);
      Inc(ChunkNew);
    end;

    if ChunkCnt > 0 then
      SetDirty(i);
  end;

  for i := 0 to Min(Length(OldScreen), Length(FScreenLines))-1 do
    if OldScreen[i].Dirty then
      FScreenLines[i].Dirty := true;

  if Length(FScreenLines) > Length(OldScreen) then
    SetDirtyFrom(Length(OldScreen));

  DestroyChunkLines(OldScreen);
end;

procedure TScreenCache.ResetStatusChanges;
begin
  FOldScreenHeightLines  := FScreenHeightLines;
  FOldScreenWidthPixels  := FScreenWidthPixels;

  FOldLinesOnScreenScroll := LinesOnScreenScroll;
  FOldHScrollPixels := HorizScrollPixels;
  FOldFirstLine := FirstLineScroll;
  FOldCursorPos := MarkPtToOffsetPt(FCursorPos);
  FOldSelStart := MarkPtToOffsetPt(FSelStart);
  FOldSelEnd := MarkPtToOffsetPt(FSelEnd);
  FOldSelBlock := FSelBlock;
end;

{------------------------------------------------------------------------------}

/////////////////////////////////////////////////////
///Screen operations
///

{
  1. Move first line (or first line 'skew' variable)
  2. Copy screen lines array
  3. Refresh new lines in screen lines array
}

procedure TScreenCache.Scroll(AOffset: Integer);
var
  NewSc, NewPh: Integer;
begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);

  if AOffset=0 then
    Exit;

  NewSc := Max(0, FirstLineScroll+AOffset);
  CorrectToLastScroll(NewSc);

  if NewSc <> FirstLineScroll then
  begin
    NewPh := ScrollToPhysical(NewSc);

    DelValidState([csScreen]);

    //Set first line variables
    FFirstLineScroll := PhysicalToScroll(NewPh);
    FFirstLineSkew   := NewSc-FFirstLineScroll;
    Assert(LMDInRange(FFirstLineSkew, 0, ScreenCount(NewPh)-1));

    FFirstLinePhysical := NewPh;

    DoDelayedUpdate;
    SetDirtyFrom(0);
  end;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.GetTabWidths(const AState: TWrapParserState;
                                    out ATailW, AHeadW: Integer);
var
    Seg: TLMDSegment;
    Charset: TFontCharset;
    Ch: TLMDChar;
    Fs: TFontStyles;
begin
  Seg := FSpecialCharsMap[skTabTail];
  Charset := FSpecialCharsCharSetMap[skTabTail];

  Ch := LMDSegAt(Seg.Count-1, Seg);

  Fs := GetAttrsFontStyle(AState.Attrs, FDefaultAttrs);
  AHeadW := GetCharWidth(Ch, Fs, Charset);

  Ch := LMDSegAt(0, Seg);
  ATailW := GetCharWidth(Ch, Fs, Charset);
end;

procedure TScreenCache.ScreenPosToPixFromTab(const AState: TWrapParserState;
                                             TabOff: Integer;
                                             out AStart, ACount: Integer);
var
    TailW, HeadW: Integer;
begin
  Assert(AState.IsTab);
  Assert(TabOff < AState.VisWidth);
  Assert(TabOff >= 0);

  GetTabWidths(AState, TailW, HeadW);

  AStart := AState.XPix + (TailW * TabOff);
  if TabOff = AState.VisWidth-1 then
    ACount := HeadW
  else
    ACount := TailW;
end;

function  TScreenCache.ScreenPixToPosFromTab(const AState: TWrapParserState;
                                             APixOff: Integer): Integer;
var
    TailW, HeadW: Integer;
begin
  Assert(AState.IsTab);
  Assert(APixOff < AState.PixWidth);
  Assert(APixOff >= 0);

  GetTabWidths(AState, TailW, HeadW);

  if APixOff >= (AState.PixWidth - HeadW) then
    Result := AState.VisWidth - 1
  else
    Result := APixOff div TailW;

  Result := Result + AState.X;
end;


function  TScreenCache.ScreenPosToScreenPix(AScreen: TPoint;
                                            out AStart, ACount: Integer;
                                            AScreenOnly: Boolean): Boolean;
var
    Scrl: TPoint;
begin
  CheckValidState([csFolds, csScreen, csConversionCaches]);

  Scrl := ScreenPosToScroll(AScreen, false);
  Result := IsScrollInScreenBounds(Scrl);

  if Result or (not AScreenOnly) then
    ScrollPosToScreenPix(Scrl, AStart, ACount);
end;

procedure TScreenCache.ScrollPosToScreenPix(AScroll: TPoint; out AStart, ACount: Integer);
var
    Res: TWrapParserState;
    dx: Integer;
begin
  Assert(AScroll.X >= 0);

  CheckValidState([csFolds, csConversionCaches]);
  CheckScrollLineIdx(AScroll.Y);

  Res := WP_GetState(AScroll.X, AScroll.Y, false, true);

  if Res.IsTab then
  begin
    dx := Min(AScroll.X - Res.X, Res.VisWidth-1);
    ScreenPosToPixFromTab(Res, dx, AStart, ACount);
  end
  else
  begin
    AStart := Res.XPix;
    ACount := Res.PixWidth;
  end;

  AStart := AStart - HorizScrollPixels;

  dx := AScroll.X - (Res.X + Res.VisWidth - 1);
  if dx > 0 then
  begin
    Inc(AStart, ACount + ScrollXToPixelsFixed(dx-1));
    ACount := ScrollXToPixelsFixed(1);
  end;
end;
{------------------------------------------------------------------------------}

function  TScreenCache.ScrollXToPixelsFixed(ACol: Integer): Integer;
begin
  Result := FSpaceCharW * ACol;
end;

{------------------------------------------------------------------------------}

function  TScreenCache.PixelsToScrollXFixed(AXPix: Integer; ARoundToBigger: Boolean): Integer;
begin
  Result := AXPix div FSpaceCharW;

  if ARoundToBigger and (AXPix mod FSpaceCharW <> 0) then
    Inc(Result, Sign(Result));
end;

{------------------------------------------------------------------------------}

function  TScreenCache.ScreenPixToScreenPos(APixW: Integer;
                                            AScreenLine: Integer): Integer;
begin
  Result := ScreenPixToScrollPos(APixW, AScreenLine + FirstLineScroll);
end;

{------------------------------------------------------------------------------}

function  TScreenCache.ScreenPixToScrollPos(APixW: Integer; AScrollLine: Integer): Integer;
var
    Res: TWrapParserState;
    dx: Integer;
begin
  CheckValidState([csFolds, csConversionCaches]);

  APixW := APixW + HorizScrollPixels;
  Assert(APixW >= 0);

  Res := WP_GetState(APixW, AScrollLine, true, true);

  if Res.IsTab then
  begin
    dx := Min(Res.PixWidth-1, APixW - Res.XPix);
    Result := ScreenPixToPosFromTab(Res, dx);
  end
  else
    Result := Res.X;

  dx := APixW - (Res.XPix + Res.PixWidth);

  if dx >= 0 then
    Result := Result + 1 + PixelsToScrollXFixed(dx, false);
end;

{------------------------------------------------------------------------------}

function TScreenCache.ScrollPosToScreen(AScroll: TPoint; DoCheck: Boolean): TPoint;
begin
  Result.Y := ScrollToScreen(AScroll.Y, DoCheck);
  Result.X := AScroll.X;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.OffsetPtToMarkPt(AOffPt: TOffsetPoint;
                                        var OldVal: TOffsetPointMark);
begin
  Assert(OldVal.CharMark<>nil);
  Assert(OldVal.CharMark.IsValid);

  OldVal.CharMark.DeleteFromCollection;

  OldVal.CharMark := nil;
  OldVal.CharMark := FCursorMarks.CreateMarkAtOffset(AOffPt.Offset);
  OldVal.InCharOffset := AOffPt.InCharOffset;
end;

{------------------------------------------------------------------------------}
function TScreenCache.ScrollPtToOffsetPt(AScrollPoint: TPoint): TOffsetPoint;
var
  Res: TWrapParserState;
begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckScrollLineIdx(AScrollPoint.Y);

  Res := WP_GetState(AScrollPoint.X, AScrollPoint.Y, false, true);

  Result.Offset := Res.Offset;
  Result.InCharOffset := AScrollPoint.X - Res.X;
end;
{------------------------------------------------------------------------------}

function  TScreenCache.OffsetPtToScrollPt(APoint: TOffsetPoint): TPoint;
begin
  Result := OffsetToScroll(APoint.Offset);
  Inc(Result.X, APoint.InCharOffset);
end;

{------------------------------------------------------------------------------}

function  TScreenCache.CalkPointVisWidth(AOffset: Integer): Integer;
begin
  Result := CalkPointVisWidth(OffsetPt(AOffset));
end;

{------------------------------------------------------------------------------}

function  TScreenCache.CalkPointVisWidth(AOffPt: TOffsetPoint): Integer;
var
    Ph, i: Integer;
begin
  CheckOffsetForScroll(AOffPt.Offset, true);

  Ph := Doc.GetLineByOffset(AOffPt.Offset);

  Result := 0;
  for i := Doc.LineSegments[Ph].Start to AOffPt.Offset-1 do
  begin
    if Buffer[i] <> LMDTab then
      Inc(Result)
    else
      Result := Result + GetTabWidth(Result, FTabWidth);
  end;

  Result := Result + AOffPt.InCharOffset;
end;

{------------------------------------------------------------------------------}

function  TScreenCache.IsOffsetVisible(AOffset: Integer): Boolean;
var
  Res: TWrapParserState;
begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckOffsetForScroll(AOffset, true);

  Res := WP_GetStateOverFolds(AOffset);

  Result := Res.Offset = AOffset;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.EnsureOffsetIsVisible(AOffset: Integer);
var
  Line, Ph, NewPh: Integer;
  Sc: Integer;
  Res: TWrapParserState;
  Last: TOffsetPoint;
begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckOffsetForScroll(AOffset, true);

  Line := Doc.GetLineByOffset(AOffset);
  Res := WP_GetStateOverFolds(AOffset);

  if Res.Offset<>AOffset then
    Ph := GetPrevVisibleLine(Res.PhysLine, true)
  else
    Ph := Line;

  while Ph <> Line do
  begin
    Assert(Ph < Line);

    NewPh := GetNextVisibleLine(Ph, False);
    if NewPh > Line then
    begin
      Unfold(Ph, false);
      CheckValidState(csAllValid);
    end
    else
      Ph := NewPh;
  end;

  if IsCollapsedFold(Line) then
  begin
    Sc := PhysicalToScroll(Line);
    Last := GetScrollLineOffLast(Sc);

    if (AOffset > Last.Offset) then
      Unfold(Line, False);
  end;

  CheckValidState(csAllValid);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.SetFirstLineAsScroll(ALine: Integer);
begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);
  Scroll(ALine - FirstLineScroll);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.RefreshScreenLines;
var
    Ln, LnScr, LnE, Ph, StartX, EndX, CountX: Integer;
    StartR, EndR: TWrapParserState;
    ScrLine: PScreenLineInfo;
    Bmk, Brk: ILMDLineMark;
    PixS, PixCnt, i, y0_off, ye_off: Integer;
begin
  CheckValidState([csFolds, csConversionCaches]);
  DelValidState([csScreen]);

  Assert(Length(FScreenLines)=0);

  Ln := FirstLineScroll;
  LnE := Ln + ScreenHeightLines;
  LnScr := 0;

  FScreenIsBuilding := true;
  try
    while (Ln < LnE) and (not AfterLastScroll(Ln)) do
    begin
      if Length(FScreenLines) <= LnScr then
        SetLength(FScreenLines, ((LnScr+1)*3) div 2);

      ScrLine := @FScreenLines[LnScr];

      StartR := WP_GetState(HorizScrollPixels, Ln, true, true);
      Ph := StartR.PhysLine;

      StartX := ScreenPixToScreenPos(0, LnScr);
      ScrollPosToScreenPix(Point(StartX, Ln), PixS, PixCnt);
      if PixS < 0 then
      begin
        Assert(PixS + PixCnt >= 0);

        Inc(StartX);
      end;

      EndX   := ScreenPixToScreenPos(ScreenWidthPixels-1, LnScr);

      CountX := EndX - StartX + 1;

      ScrLine.ScrollInfo := GetScrollLineInfo(Ln);
      ScrLine.Dirty := true;
      ScrLine.StartState := StartR;
      ScrLine.XBoundStart := StartX;
      ScrLine.XBoundCount := CountX;
      ScrLine.ChunksCount := 0;
      ScrLine.OffsetsCount := 0;

      Bmk := Doc.Bookmarks.GetLastLineMark(Ph);
      Brk := Doc.Breakpoints.GetLastLineMark(Ph);

      if Bmk <> nil then
        Include(ScrLine.ScrollInfo.VisProps, lpBookmark);

      if Brk <> nil then
      begin
        with ScrLine.ScrollInfo do
          case Doc.GetBreakpointKind(Brk) of
            mkBreakActive: Include(VisProps, lpBreakpointActive);
            mkBreakDisabled: Include(VisProps, lpBreakpointDisabled);
            mkBreakInactive: Include(VisProps, lpBreakpointInactive);
          end;
      end;

      Doc.DebugFrameLines.EnumMarkersByLines(Ph, 1,
                                             RefreshScreenLinesEnumerator,
                                             @ScrLine.ScrollInfo);

      EndR := WP_FillChunks(StartR, ScreenWidthPixels, ScrLine);

      /////
      i := ScrLine.StartState.Offset;
      y0_off := Max(i - MAX_ADDICT_WORD_LENGTH, ScrLine.StartState.Y_OffsetStart);
      while i > y0_off do
      begin
        if (i < Doc.CharsCount) and FAddictSeparatorsSet.Contains(Buffer[i]) then
          Break;

        Dec(i);
      end;

      ScrLine.StartWordOff := i;
      /////
      i := EndR.Offset;
      ye_off := Min(i + MAX_ADDICT_WORD_LENGTH, LMDSegEnd(ScrLine.ScrollInfo.ContentSegment));
      while i <= ye_off do
      begin
        if (i < Doc.CharsCount) and FAddictSeparatorsSet.Contains(Buffer[i]) then
          Break;

        Inc(i);
      end;

      ScrLine.EndWordOff := i;
      /////

      Inc(Ln);
      Inc(LnScr);
    end;

    if Length(FScreenLines) > LnScr then
      SetLength(FScreenLines, LnScr);

    AddValidState(csScreen);
  finally
    FScreenIsBuilding := false;
  end;
end;

procedure TScreenCache.RefreshScreenLinesEnumerator(AMark: ILMDMark;
                                                    AData: Pointer;
                                                    var StopHere: Boolean);

var
    ScrInfo: PScrollLineInfo;
begin
  ScrInfo := PScrollLineInfo(AData);

  case Doc.GetDebugFrameKind(AMark) of
    fkFrame:       Include(ScrInfo.VisProps, lpFrame);
    fkFrameTop:    Include(ScrInfo.VisProps, lpFrameTop);
    fkFrameActive: Include(ScrInfo.VisProps, lpFrameActive);
  end;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.SetDirtyFrom(AStartScreen: Integer);
begin
  SetDirty(AStartScreen, LinesOnScreenScroll - 1);
end;

procedure TScreenCache.SetDirtyScroll(AScrollLine: Integer);
var
  ln: Integer;
begin
  ln := ScrollToScreen(AScrollLine, False);
  if (ln >= 0) and (ln < LinesOnScreenScroll) then
    SetDirty(ln);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.SetDirty(AScr: Integer);
begin
  SetDirty(AScr, AScr);
end;

procedure TScreenCache.SetDirtyForSel(const OldS, OldE,
                                            NewS, NewE: TOffsetPoint;
                                      AOldBlockMode, ABlockMode: Boolean);
var
    Arr: array[0..3] of TPoint;

  function ToScr(const Pt: TOffsetPoint): TPoint;
  begin
    Result := OffsetPtToScrollPt(Pt);

    Result.Y := LMDMinMax(Result.Y - FirstLineScroll, 0, LinesOnScreenScroll - 1);
  end;

  procedure InsPt(Pt: TPoint; Pos: Integer);
  begin
    while (Pos > 0) and (ComparePoints(Pt, Arr[Pos - 1]) < 0) do
    begin
      Arr[Pos] := Arr[Pos - 1];
      Dec(Pos);
    end;

    Arr[Pos] := Pt;
  end;
begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);

  if AOldBlockMode <> ABlockMode then
    SetDirtyFrom(0)
  else
  begin
    Arr[0] := ToScr(OldS);
    InsPt(ToScr(OldE), 1);//Insertion sort
    InsPt(ToScr(NewS), 2);
    InsPt(ToScr(NewE), 3);

    if SelBlockMode and ((Arr[0].X <> Arr[1].X) or (Arr[2].X <> Arr[3].X)) then
      SetDirty(Arr[0].Y, Arr[3].Y)
    else
    begin
      if ComparePoints(Arr[0], Arr[1]) <> 0 then
        SetDirty(Arr[0].Y, Arr[1].Y);//Set widen range as dirty

      if ComparePoints(Arr[2], Arr[3]) <> 0 then
        SetDirty(Arr[2].Y, Arr[3].Y);//Set widen range as dirty
    end;
  end;
end;

procedure TScreenCache.SetDirty(AStartScreen, AEndScreen: Integer);
var
  i: Integer;
begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);
  CheckScreenLineIdx(AStartScreen); CheckScreenLineIdx(AEndScreen);
  Assert(AStartScreen <= AEndScreen);

  for i:=AStartScreen to AEndScreen do
    FScreenLines[i].Dirty := True;
end;

{------------------------------------------------------------------------------}

function  TScreenCache.IsScreenLineDirty(ALine: Integer): Boolean;
begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);

  CheckScreenLineIdx(ALine);

  Result  := FScreenLines[ALine].Dirty;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.UnsetScreenLineDirty(ALine: Integer);
begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);
  CheckScreenLineIdx(ALine);

  FScreenLines[ALine].Dirty := False;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.UnsetDirties;
var
  i: Integer;
begin
  for i := 0 to LinesOnScreenScroll-1 do
    UnsetScreenLineDirty(i)
end;

{------------------------------------------------------------------------------}

function  TScreenCache.GetScreenLine(ALine: Integer): TScrollLineInfo;
begin
  CheckScreenLineIdx(ALine);
  Result := FScreenLines[ALine].ScrollInfo;
end;

function  TScreenCache.GetScreenLineStart(ALine: Integer): TWrapParserState;
begin
  CheckScreenLineIdx(ALine);
  Result := FScreenLines[ALine].StartState;
end;

function TScreenCache.GetScreenLineWordStart(ALine: Integer): Integer;
begin
  CheckScreenLineIdx(ALine);
  Result := FScreenLines[ALine].StartWordOff;
end;

function TScreenCache.GetScreenLineWordEnd(ALine: Integer): Integer;
begin
  CheckScreenLineIdx(ALine);
  Result := FScreenLines[ALine].EndWordOff;
end;

function  TScreenCache.GetScreenLineChunks(ALine: Integer; out Cnt: Integer): PChunk;
begin
  CheckScreenLineIdx(ALine);

  Cnt := FScreenLines[ALine].ChunksCount;

  if Cnt > 0 then
    Result := @FScreenLines[ALine].Chunks[0]
  else
    Result := nil;
end;
{------------------------------------------------------------------------------}

function  TScreenCache.GetScreenLineProps(ALine: Integer): TLMDScreenLineProps;
begin
  CheckValidState(csAllValid);
  CheckScreenLineIdx(ALine);

  Result := FScreenLines[ALine].ScrollInfo.VisProps;
end;

{------------------------------------------------------------------------------}

function TScreenCache.ScreenPosToScroll(AScreen: TPoint;
  DoCheck: Boolean): TPoint;
begin
  Result.X := AScreen.X;
  Result.Y := ScreenToScroll(AScreen.Y, DoCheck);
end;

{------------------------------------------------------------------------------}

function TScreenCache.GetScrollLineVisWidth(ALine: Integer): Integer;
var
  Res: TWrapParserState;
begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckScrollLineIdx(ALine);

  Res := WP_GetState(MaxInt, ALine, false, true);

  if not Res.IsTail then
    Result := Res.X + Res.VisWidth
  else
    Result := Res.X;
end;

{------------------------------------------------------------------------------}

function TScreenCache.GetScrollLineOffStart(ALine: Integer): Integer;
var
  Res: TWrapParserState;
begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckScrollLineIdx(ALine);

  Res := WP_GetState(0, ALine, false, true);

  Result := Res.Offset;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.GetPhysLineVisibleBounds(ALine: Integer;
                                                out AFirst, ALast: TOffsetPoint);
var
    Y: Integer;
    Seg: TLMDSegment;
begin
  CheckValidState([csFolds, csConversionCaches]);

  Seg := Doc.LineSegments[ALine];
  AFirst := OffsetPt( Seg.Start );

  if IsCollapsedFold(ALine) then
  begin
    Y := PhysicalToScroll(ALine);
    ALast := GetScrollLineOffLast(Y);
  end
  else
    ALast := OffsetPt( LMDSegEnd(Seg) + 1 );
end;

{------------------------------------------------------------------------------}

function TScreenCache.GetScrollLineOffLast(ALine: Integer): TOffsetPoint;
var
  Res: TWrapParserState;
begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckScrollLineIdx(ALine);

  if NoWrap then
  begin
    Res := WP_GetState(0, ALine, false, true);

    Result.Offset := LMDSegEnd(Doc.LineSegments[Res.PhysLine])+1;
    Result.InCharOffset := 0;
  end
  else
  begin
    Res := WP_GetState(MaxInt, ALine, false, true);

    Result.Offset := Res.Offset;
    Result.InCharOffset := Res.VisWidth - 1;
  end;
end;

{------------------------------------------------------------------------------}

function TScreenCache.GetScrollLineInfo(ALine: Integer): TScrollLineInfo;
var
    Res: TWrapParserState;
begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckScrollLineIdx(ALine);

  if NoWrap then
  begin
    Res := WP_GetState(0, ALine, false, true);
    Res.IsTail := true;
  end
  else
    Res := WP_GetState(MaxInt, ALine, false, true);

  Result.PhysicalLine := Res.PhysLine;

  Result.VisProps := [];

  if Res.IsTail then
    Include(Result.VisProps, lpLastWrap);

  if Res.Y_OffsetStart =
     Doc.LineSegments[Result.PhysicalLine].Start
  then
    Include(Result.VisProps, lpFirstWrap);

  if Parser.IsFoldStart(Result.PhysicalLine) then
    Include(Result.VisProps, lpFoldStart);

  if Parser.IsFoldEnd(Result.PhysicalLine) then
    Include(Result.VisProps, lpFoldEnd);

  if IsCollapsedFold(Result.PhysicalLine) then
    Include(Result.VisProps, lpCollapsedFold);

  Result.ContentSegment.Start := Res.Y_OffsetStart;

  if NoWrap then
    Result.ContentSegment.Count := Doc.LineSegments[Res.PhysLine].Count
  else
    Result.ContentSegment.Count := Res.Offset - Res.Y_OffsetStart;

  Result.ContentSegment.Source := Buffer;

  if not Res.IsTail then
    Inc(Result.ContentSegment.Count);
end;

{------------------------------------------------------------------------------}

function TScreenCache.ScrollToNearestOffset(AScroll: TPoint): Integer;
begin
  Result := ScrollPtToOffsetPt(AScroll).Offset;
end;

{------------------------------------------------------------------------------}

procedure  TScreenCache.GetScrollCharScrollBounds(AScroll: TPoint;
  var Left, Right: Integer);
var
    Res: TWrapParserState;
begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckScrollLineIdx(AScroll.Y);

  Res := WP_GetState(AScroll.X, AScroll.Y, false, true);

  Left := Res.X;
  Right := Max(AScroll.X, Res.X + Res.VisWidth);
end;

{------------------------------------------------------------------------------}
function TScreenCache.GetSelEnd: TPoint;
begin
  Result := MarkPtToScrollPt(FSelEnd);
end;

function TScreenCache.GetSelEndOffset: TOffsetPoint;
begin
  Result := MarkPtToOffsetPt(FSelEnd);
end;

function TScreenCache.GetSelStart: TPoint;
begin
  Result := MarkPtToScrollPt(FSelStart);
end;

function TScreenCache.GetSelStartOffset: TOffsetPoint;
begin
  Result := MarkPtToOffsetPt(FSelStart);
end;

function TScreenCache.GetStatusChanges: TLMDViewStatusChanges;
var
    Changes: TLMDViewStatusChanges;
begin
  Changes := [];
  CheckValidState(csAllValid);

  if (FOldScreenHeightLines<>FScreenHeightLines) or
     (FOldScreenWidthPixels<>FScreenWidthPixels)
  then
    Include(Changes, scScreenSize);

  if FOldHScrollPixels<>HorizScrollPixels then
    Include(Changes, scHScroll);

  if FOldFirstLine<>FirstLineScroll then
    Include(Changes, scVScroll);

  if FOldLinesOnScreenScroll<>LinesOnScreenScroll then
    Include(Changes, scScreenSize);

  if CmpOffsetPt(FOldCursorPos, FCursorPos)<>0 then
    Include(Changes, scCursor);

  if (CmpOffsetPt(FOldSelStart, FSelStart)<>0) or
     (CmpOffsetPt(FOldSelEnd, FSelEnd)<>0)
  then
    Include(Changes, scSelection);

  Result := Changes;
end;

function TScreenCache.GetStoreDocSettingsLimit: Integer;
begin
  Result := FStoredView.GetDataLimit;
end;

{------------------------------------------------------------------------------}

function TScreenCache.FirstCharOnScreen: Integer;
begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);

  Result := GetScrollLineOffStart(FirstLineScroll);
end;

function TScreenCache.FindOffsetInVisibleScreen(AOffset: Integer): Integer;
var
    L, R, M: Integer;
    Start: Integer;
    Seg: TLMDSegment;
    First, Last: Integer;
begin
  CheckValidState([csScreen, csFolds, csConversionCaches]);

  Assert(Length(FScreenLines) > 0);
  Seg := FScreenLines[0].ScrollInfo.ContentSegment;
  First := Seg.Start;

  Seg := FScreenLines[LinesOnScreenScroll-1].ScrollInfo.ContentSegment;

  Last := FScreenLines[LinesOnScreenScroll-1].StartState.Offset;
  Last := Last + FScreenLines[LinesOnScreenScroll-1].OffsetsCount;

  Result := -1;
  if (AOffset >= First) and (AOffset < Last) then
  begin
    L := 0; R := LinesOnScreenScroll;
    while L < R do
    begin
      M := (L + R) div 2;
      Start := FScreenLines[M].ScrollInfo.ContentSegment.Start;

      if Start <= AOffset then
        L := M + 1
      else
        R := M;
    end;

    Assert(L > 0);
    Dec(L);

    Result := L;
  end;
end;

{------------------------------------------------------------------------------}

function TScreenCache.GetNearestValidOffset(AOffset: Integer): Integer;
var
  l: Integer;
  Pt: TOffsetPoint;
begin
  CheckValidState([csFolds, csConversionCaches]);

  Pt := OffsetPt(AOffset);
  CorrectOffsetPtCR(Pt);

  if IsOffsetVisible(Pt.Offset) then
    Result := Pt.Offset
  else
  begin
    l := Doc.GetLineByOffset(Pt.Offset);

    while not IsLineStartVisible(l) do
    begin
      repeat
        Dec(l);
        Assert(l>=0);
      until IsCollapsedFold(l);
    end;

    l := PhysicalToScroll(l);
    Result := GetScrollLineOffLast(l).Offset;
  end;

  Result := LMDMinMax(Result, 0, Doc.CharsCount);
end;

function  TScreenCache.OffsetToScroll(AOffset: Integer): TPoint;
var
    Res: TWrapParserState;

    procedure RaiseErr;
    begin
      raise ELMDEditViewError.CreateFmt(SLMDSedViewInvisibleOffset, [AOffset]);
    end;

begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckOffsetForScroll(AOffset, true);

  try
    Res := WP_GetState(AOffset);
    Result.Y := Res.Y;
    Result.X := Res.X;
  except
    on E: TWP_InvisibleOffsetError do
      RaiseErr;
  end;
end;

{------------------------------------------------------------------------------}

function  TScreenCache.MarkPtToOffsetPt(const APoint: TOffsetPointMark): TOffsetPoint;
begin
  Result.Offset := APoint.CharMark.Pos;
  Result.InCharOffset := APoint.InCharOffset;
end;

{------------------------------------------------------------------------------}

function TScreenCache.MarkPtToScrollPt(const APoint: TOffsetPointMark): TPoint;
begin
  Result := OffsetPtToScrollPt(MarkPtToOffsetPt(APoint));
end;

{------------------------------------------------------------------------------}
function TScreenCache.LinesOnScreenScroll: Integer;
begin
  CheckValidState([csConversionCaches, csScreen, csFolds]);

  Result := Length(FScreenLines);
end;

{------------------------------------------------------------------------------}

function TScreenCache.OldLinesOnScreenScroll: Integer;
begin
  Result := FOldLinesOnScreenScroll;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.SetScreenSize(APixWidth, ALinesHeight: Integer);
begin
  CheckValidState(csAllValid);
  CheckScreenWidthArg(APixWidth);
  CheckScreenHeightArg(ALinesHeight);

  if (APixWidth = FScreenWidthPixels) and (ALinesHeight = FScreenHeightLines) then
    Exit;

  FScreenHeightLines := ALinesHeight;

  if (APixWidth <> FScreenWidthPixels) and (FWrapMode = wmWrapToWindow) then
  begin
    FScreenWidthPixels := APixWidth;

    ResetPreserve;
  end
  else
  begin
    FScreenWidthPixels := APixWidth;

    DelValidState([csScreen]);
    DoDelayedUpdate;
  end;
end;

{------------------------------------------------------------------------------}
function TScreenCache.FirstLinePhysical: Integer;
begin
  Result := FFirstLinePhysical;
end;

{------------------------------------------------------------------------------}

function TScreenCache.LastLineScroll: Integer;
begin
  CheckValidState([csConversionCaches, csScreen, csFolds]);

  Result := FirstLineScroll + LinesOnScreenScroll - 1;
end;

{------------------------------------------------------------------------------}

function TScreenCache.FirstLineScroll: Integer;
begin
  CheckValidState([csConversionCaches, csFolds]);

  Result := FFirstLineScroll + FFirstLineSkew;
end;

{------------------------------------------------------------------------------}

function TScreenCache.CalkVisibleCountScroll: Integer;
begin
  CheckValidState([csFolds, csConversionCaches]);

  if FVisibleCountScroll = -1 then
  begin
    FVisibleCountScroll := MaxInt;
    CorrectToLastScroll(FVisibleCountScroll);

    Inc(FVisibleCountScroll);
  end;

  Result := FVisibleCountScroll;
end;

{------------------------------------------------------------------------------}

function TScreenCache.CalkVisibleCountScrollBar(AForceRecalk: Boolean): Integer;
begin
  CheckValidState([csFolds, csConversionCaches]);

  if (FVisibleCountScrollBar = -1) or AForceRecalk then
    FVisibleCountScrollBar := CalkVisibleCountScroll;

  Result := FVisibleCountScrollBar;
end;

{------------------------------------------------------------------------------}

function TScreenCache.GetTailSpecCharWidth(AKind: TLMDSpecialCharKind): Integer;
var
    Seg: TLMDSegment;
    ChSet: TFontCharset;
begin
  Result := 0;

  Assert(AKind in [skCR, skLF, skCRLF, skLineWrap, skFoldedLineEnd]);

  if AKind in FSpecChars.ShowCharKinds then
  begin
    ChSet := FSpecialCharsCharSetMap[AKind];
    Seg := FSpecialCharsMap[AKind];

    Result := GetSegWidth(Seg, FDefaultAttrs.FontStyle, ChSet);
  end
end;

{------------------------------------------------------------------------------}

constructor TWP_Cache.Create(AMaxCount, ASeqItemsInterval: Integer);
begin
  inherited Create;

  FSeqItemsInterval := ASeqItemsInterval;
  FSeqItemsCount := 0;
  SetLength(FSeqItems, 0);

  LastSeqOffset := - (MaxInt div 2);

  FCacheMaxCount := AMaxCount;
  FCacheCount := 0;
  SetLength(FCacheItems, 0);

  FCacheItemsFirst := nil;
  FCacheItemsLast := nil;
end;

{------------------------------------------------------------------------------}

destructor TWP_Cache.Destroy;
var
    i: Integer;
begin
  for i := 0 to FCacheCount-1 do
    if FCacheItems[i]<>nil then
      FCacheItems[i].Free;

  SetLength(FCacheItems, 0);
  SetLength(FSeqItems, 0);
end;

{------------------------------------------------------------------------------}

function CompareState(const State: TWrapParserState;
                      Offset, X, Y: Integer; Cond: TWP_Condition): Integer;
begin
  case Cond of
    wpByOffset:
      Result := State.Offset - Offset;

    wpByXY:
    begin
      Result := State.Y - Y;
      if Result = 0 then
        Result := State.X - X;
    end;

    wpByXPixY:
    begin
      Result := State.Y - Y;
      if Result = 0 then
        Result := State.XPix - X;
    end;
  else
    Assert(false);
    Result := 0;
  end;
end;

function TWP_Cache.UpperBoundCache(Offset, X, Y: Integer; Cond: TWP_Condition): Integer;
var
    L, R, M: Integer;
begin
  L := 0; R := FCacheCount;

  while L < R do
  begin
    M := (L + R) div 2;

    if CompareState(FCacheItems[M].State, Offset, X, Y, Cond) <= 0 then
      L := M+1
    else
      R := M;
  end;

  //Here State[L] > Cond
  Assert(L <= R);
  Result := L-1;//Then, State[L-1] <= Cond
end;

function TWP_Cache.UpperBoundSeq(Offset, X, Y: Integer; Cond: TWP_Condition): Integer;
var
    L, R, M: Integer;
begin
  L := 0; R := FSeqItemsCount;

  while L < R do
  begin
    M := (L + R) div 2;

    if CompareState(FSeqItems[M], Offset, X, Y, Cond) <= 0 then
      L := M+1
    else
      R := M;
  end;

  //Here State[L] > Cond
  Result := L-1;//Then, State[L-1] <= Cond
end;

procedure TWP_Cache.MoveCacheItems(AStart, ADest, ACount: Integer);
begin
  if ACount=0 then
    Exit;

  System.Move(FCacheItems[AStart], FCacheItems[ADest], ACount * SizeOf(TWP_CacheItem));
end;

{------------------------------------------------------------------------------}

procedure TWP_Cache.Invalidate(AOffset: Integer);
var
    i, Cnt: Integer;
begin
  //Cache invalidate
  i := UpperBoundCache(AOffset, -1, -1, wpByOffset);

  while (i>=0) and
        ((not FCacheItems[i].State.IsStable) or
         (FCacheItems[i].State.Offset = AOffset))
  do
   Dec(i);

  //Here CacheItems[i] is stable and < AOffset
  Inc(i);
  Cnt := i;
  while i < FCacheCount do
  begin
    FCacheItems[i].Free;
    FCacheItems[i] := nil;

    Inc(i);
  end;

  FCacheCount := Cnt;
  if FCacheCount > 0 then
  begin
    FCacheItemsFirst := FCacheItems[0];
    FCacheItemsFirst.Next := nil;
  end
  else
    FCacheItemsFirst := nil;

  FCacheItemsLast := FCacheItemsFirst;

  for i:=1 to FCacheCount-1 do
  begin
    FCacheItemsLast.Next := FCacheItems[i];
    FCacheItemsLast := FCacheItemsLast.Next;
    FCacheItemsLast.Next := nil; 
  end;

  //Invalidate states sequence

  i := UpperBoundSeq(AOffset, -1, -1, wpByOffset);
  FSeqItemsCount := Max(0, i);

  if FSeqItemsCount > 0 then
    LastSeqOffset := FSeqItems[FSeqItemsCount-1].Offset
  else
    LastSeqOffset := - (MaxInt div 2);
end;

{------------------------------------------------------------------------------}

procedure TWP_Cache.AddStateSeq(const AState: TWrapParserState; AChunkOutput: Boolean);
var
    i, Diff: Integer;
begin
  Diff := AState.Offset - LastSeqOffset;
  if Diff = 0 then
    Exit;

  if Diff > FSeqItemsInterval then
  begin
    Inc(FSeqItemsCount);
    if Length(FSeqItems) < FSeqItemsCount then
      SetLength(FSeqItems, (FSeqItemsCount * 3) div 2);

    FSeqItems[FSeqItemsCount-1] := AState;
    LastSeqOffset := AState.Offset;
  end
  else if (not AChunkOutput) and (Diff < 0) then
  begin
    i := UpperBoundSeq(AState.Offset, -1, -1, wpByOffset);

    if (i >= 0) and
       ((AState.Offset - FSeqItems[i].Offset)   > FSeqItemsInterval * 3) and
       ((FSeqItems[i+1].Offset - AState.Offset) > FSeqItemsInterval * 3)
    then
    begin
      FSeqItemsCount := i+2;
      FSeqItems[FSeqItemsCount-1] := AState;
      LastSeqOffset := AState.Offset;
    end;
  end;
end;

procedure TWP_Cache.PutState(const AState: TWrapParserState);

const PUT_DIFF = 1;

var
    d, d1, i, j: Integer;
    itm: TWP_CacheItem;
begin
  i := UpperBoundCache(AState.Offset, -1, -1, wpByOffset) + 1;

  d := MAXINT div 2;
  d1 := MAXINT div 2;

  //Move to nearest
  if i < FCacheCount then
    d := FCacheItems[i].State.Offset - AState.Offset;

  if i > 0 then
    d1 := AState.Offset - FCacheItems[i-1].State.Offset;

  if (d < PUT_DIFF) or (d1 < PUT_DIFF) then
  begin
    //Replace
    if d1 > PUT_DIFF then
      FCacheItems[i].State := AState;
  end
  else
  begin
    if FCacheCount = FCacheMaxCount then
    begin
      Assert(FCacheItemsFirst <> nil);

      j := UpperBoundCache(FCacheItemsFirst.State.Offset, -1, -1, wpByOffset);
      Assert((j >= 0) and (j < FCacheCount));

      itm := FCacheItems[j];
      Assert(FCacheItemsFirst = itm);

      FCacheItemsFirst := FCacheItemsFirst.Next;
      Assert(FCacheItemsFirst <> nil);

      itm.Next := nil;
      if i > j then
        Dec(i);

      MoveCacheItems(j+1, j, FCacheCount-j-1);

      Dec(FCacheCount);
      FCacheItems[FCacheCount] := nil;
    end
    else
      itm := TWP_CacheItem.Create;

    Inc(FCacheCount);
    if Length(FCacheItems) < FCacheCount then
      SetLength(FCacheItems, (FCacheCount*3) div 2);

    MoveCacheItems(i, i+1, FCacheCount-i-1);

    FCacheItems[i] := itm;
    if FCacheItemsLast = nil then
    begin
      FCacheItemsLast := itm;
      FCacheItemsFirst := FCacheItemsLast;
      FCacheItemsLast.Next := nil;
    end
    else
    begin
      FCacheItemsLast.Next := itm;
      FCacheItemsLast := FCacheItemsLast.Next;
      FCacheItemsLast.Next := nil;
    end;

    itm.State := AState;
  end;
end;

{------------------------------------------------------------------------------}

function TWP_Cache.GetNearestState(Offset, X, Y: Integer; Cond: TWP_Condition;
                                   var Res: TWrapParserState): Boolean;
var
    i, j, d1, yd: Integer;
    UseSeq: Boolean;
begin
  i := UpperBoundCache(Offset, X, Y, Cond);
  if i<>-1 then
    d1 := CompareState(FCacheItems[i].State, Offset, X, Y, Cond)
  else
    d1 := MaxInt;

  Result := d1=0;
  if Result then
    Res := FCacheItems[i].State
  else
  begin
    j := UpperBoundSeq(Offset, X, Y, Cond);

    Result := (i<>-1) or (j<>-1);

    if Result then
    begin
      UseSeq := i=-1;
      if (not UseSeq) and (j<>-1) then
      begin
        case Cond of
          wpByXY,
          wpByXPixY:
            yd := (Y - FSeqItems[j].Y) - (Y - FCacheItems[i].State.Y);
        else
          yd := 0;
        end;

        case Cond of
          wpByOffset: UseSeq := (Offset - FSeqItems[j].Offset) <
                                (Offset - FCacheItems[i].State.Offset);

          wpByXY:
            UseSeq := (yd < 0) or
                      ((yd=0) and
                       ((X - FSeqItems[j].X) < (X - FCacheItems[i].State.X)));

          wpByXPixY:
            UseSeq := (yd < 0) or
                      ((yd=0) and
                       ((X - FSeqItems[j].XPix) < (X - FCacheItems[i].State.XPix)));
        else
          Assert(false);
        end;
      end;

      if UseSeq then
        Res := FSeqItems[j]
      else
        Res := FCacheItems[i].State;
    end;
  end;
end;

{------------------------------------------------------------------------------}
{$HINTS OFF}//Stupid D2005 compiler hints

function TScreenCache.WP_MoveToState(const AStart: TWrapParserState;
                                     const Target: TWrapParserState;
                                     Cond: TWP_Condition;
                                     DoChunkOutput: Boolean;
                                     ChunkOutput: PScreenLineInfo):
                                     TWrapParserState;

var
    WrapW: Integer;
    Found: Boolean;
    Seq: TLMDCharSeq;

    //Phys line state

    Ln, LnCnt, LnLast, LnFirst, Col: Integer;
    TailCR, TailCollapsed, TailWrap: Integer;
    TailKind: TLMDSpecialCharKind;
    IsCollapsed: Boolean;

    TokLine: TLMDEditParsedLine;
    TokBase: Integer;
    TokCnt: Integer;
    TokenArrLength: Integer;

    //Scroll pos state
    State: TWrapParserState;
    Tok: Integer;

    BreakState: TWrapParserState;
    BreakStateHard: Boolean;
    BreakStateTok: Integer;
    BreakStateBase: Integer;
    BreakStateChunk: Integer;

    ResCand: TWrapParserState;
    ResCandChunk: Integer;
    HaveResCand: Boolean;
    SpecCharSet: TFontCharset;

    //Assert: Ln <= LinesCount
    //Inits line vars
    procedure InitLine;
    var
      CrKind: TLMDSpecialCharKind;
      LnSeg: TLMDSegment;
      Ok, HighlightInRange: Boolean;
      SepKind: TLMDLineSeparator;
    begin
      TailCR := 0;
      TailCollapsed := 0;
      IsCollapsed := false;

      if Ln < LnCnt - 1 then
      begin
        IsCollapsed := IsCollapsedFold(Ln);
        if IsCollapsed then
          TailCollapsed := GetTailSpecCharWidth(skFoldedLineEnd);

        CrKind := skSpace;

        Ok := Doc.GetLineEndKind(Ln, SepKind);
        Assert(Ok);

        case SepKind of
          lsCRLF: CrKind := skCRLF;
          lsLF: CrKind := skLF;
          lsCR: CrKind := skCR;
        else
          Assert(false);
        end;

        TailCR := GetTailSpecCharWidth(CrKind);

        TailKind := CrKind;
      end;

      TokLine := nil;
      TokBase := 0;
      TokCnt := 0;

      if Ln <> LnCnt then
      begin
        LnSeg := Doc.LineSegments[Ln];
        LnLast := LnSeg.Start + LnSeg.Count;
        LnFirst := LnSeg.Start;

        if Col < LnSeg.Count then
        begin
          TokLine := Parser.GetParsedLine(Ln);

          if TokLine.TokenCount > 0 then
          begin
            if Col <> 0 then
              TokBase := TokLine.GetTokenIdx(Col);

            TokCnt := TokLine.GetTokens(TokBase, TokenArrLength, FWPTokenArr);
          end
          else
          begin
            FWPTokenArr[0].Attrs := FDefaultAttrs;
            FWPTokenArr[0].TokenID := 0;
            FWPTokenArr[0].Seg := LnSeg;

            TokBase := 0;
            TokCnt := 1;
          end;
        end;
      end
      else
      begin
        LnLast := Seq.Count;

        Inc(LnLast);//Invalid offset for invalid line

        LnFirst := LnLast;
      end;

      Tok := 0;
      if Tok < TokCnt then
        State.Attrs := CombineAttrs(FWPTokenArr[Tok].Attrs, FDefaultAttrs)
      else
        State.Attrs := FDefaultAttrs;

      if HighlightUse then
      begin
        HighlightInRange := (State.HighlightIdx < FHighlights.RangesCnt) and
                            (LnFirst + Col >= FHighlights.Ranges[State.HighlightIdx].Start);

        if HighlightInRange then
        begin
          State.Attrs := CombineAttrs(FHighlightAttrs, State.Attrs);
          State.AttrsWeight := 1;
        end
        else
          State.AttrsWeight := 0;
      end;

      Col := 0;

      BreakState := State;
      BreakStateHard := false;
      BreakStateTok := Tok;
      BreakStateBase := TokBase;
    end;

    //Save the state to cache, if needed
    //Assert (A2): State should be stable here:
    //             the changes in offsets after State.Offset
    //             should not affect State.X/Y position
    //
    procedure SaveState; //State.Offset may be = LnLast
    begin
      Assert(State.IsStable);
      FWPCache.AddStateSeq(State, DoChunkOutput or FScreenIsBuilding);
    end;

    function AddChunk: PChunk;
    begin
      if Length(ChunkOutput.Chunks) <= ChunkOutput.ChunksCount then
        SetLength(ChunkOutput.Chunks, ((ChunkOutput.ChunksCount + 1) * 3) div 2);

      Result := @ChunkOutput.Chunks[ChunkOutput.ChunksCount];

      ChunkInit(Result);
      Inc(ChunkOutput.ChunksCount);
    end;

    //Puts current char/attrs into chunks list, merging with last chunk,
    //if possible
    procedure AddStateToChunks(const ASeg: TLMDSegment;
                               ACharSet: TFontCharset;
                               const Attrs: TLMDEditAttributes;
                               AttrsWeight: Integer;
                               CanMerge: Boolean);
    var
        Chunk: PChunk;
    begin
      if ChunkOutput.ChunksCount = 0 then
      begin
        Chunk := AddChunk;

        Chunk.Attrs := Attrs;
        Chunk.AttrsWeight := AttrsWeight;
        Chunk.CharSet := ACharSet;
        AddSegToCharArray(Chunk.Chars, Chunk.CharsCount, ASeg);

        Chunk.StateOffset := State.Offset;
        Chunk.StateOffsetCount := 1;

        Chunk.CanMerge := CanMerge;
      end
      else
      begin
        Chunk := @ChunkOutput.Chunks[ChunkOutput.ChunksCount - 1];

        if AttributesEquals(Attrs, Chunk.Attrs) and
           (Chunk.CharSet = ACharSet) and
           (Chunk.AttrsWeight = AttrsWeight) and
           Chunk.CanMerge and CanMerge
        then
        begin
          AddSegToCharArray(Chunk.Chars, Chunk.CharsCount, ASeg);

          Inc(Chunk.StateOffsetCount);
        end
        else
        begin
          Chunk := AddChunk;

          Chunk.Attrs := Attrs;
          Chunk.AttrsWeight := AttrsWeight;
          Chunk.CharSet := ACharSet;
          Chunk.CanMerge := CanMerge;

          Chunk.StateOffset := State.Offset;
          Chunk.StateOffsetCount := 1;

          AddSegToCharArray(Chunk.Chars, Chunk.CharsCount, ASeg);
        end;
      end;

      Chunk.IsTail := State.IsTail;

      if not State.IsTail then
      begin
        Inc(ChunkOutput.OffsetsCount);
        if Length(ChunkOutput.Offsets) < ChunkOutput.OffsetsCount then
          SetLength(ChunkOutput.Offsets, (ChunkOutput.OffsetsCount * 3) div 2);

        with ChunkOutput.Offsets[ChunkOutput.OffsetsCount-1] do
        begin
          VisW := State.VisWidth;
          PixW := State.PixWidth;

          VisX := State.X;
          PixX := State.XPix;

          Flags := [];

          if State.IsTab then
            Include(Flags, soTab);

          if State.IsStable then
            Include(Flags, soStable);
        end;
      end;
    end;

    //Cuts chunk line to state, backward
    //Assert: (A4) State=BreakState
    //Chunk part with offset > State.Offset will be cut
    //Assert: If State=Tab, then we should find this chunk, and Chunk.Offset=State.Offset
    //        otherwise: we can find tail chunks here, if State.Offset is at line end
    //        we can find some shunk, and find the char by offset
    //        If State.X > LastChunk.X+LastChunk.XWidth, then we'll _have_ last chunk here
    //
    procedure CutChunksToState(AChunkBefore: Integer);
    var
        ChunkI, Off: Integer;
        Chunk: PChunk;
    begin
      if AChunkBefore = -1 then
        ChunkI := 0
      else
        ChunkI := AChunkBefore;

      while ChunkI <> ChunkOutput.ChunksCount do
      begin
        with ChunkOutput.Chunks[ChunkI] do
          Off := StateOffset + StateOffsetCount;

        if State.Offset < Off then
          Break;

        Inc(ChunkI);
      end;

      if ChunkI <> ChunkOutput.ChunksCount then
      begin
        Chunk := @ChunkOutput.Chunks[ChunkI];

        Assert(Chunk.StateOffset <= State.Offset);

        if Chunk.StateOffsetCount > 1 then
        begin
          Assert(Chunk.StateOffsetCount = Chunk.CharsCount);

          Chunk.StateOffsetCount := State.Offset - Chunk.StateOffset + 1;
          Chunk.CharsCount := Chunk.StateOffsetCount;
        end;

        if not Chunk.IsTail then
        begin
          ChunkOutput.ChunksCount := ChunkI + 1;
          SetLength(ChunkOutput.Chunks, ChunkOutput.ChunksCount);
        end;
      end;
    end;

    procedure InitStatesForLine;
    begin
      BreakStateBase := TokBase;
      BreakState := State;
      ResCand := State;
      BreakStateHard := false;
      HaveResCand := false;

      BreakStateChunk := -1;
      ResCandChunk := -1;
    end;

    procedure InitHighlightIdx(ALine: Integer);
    begin
      if Ln <> LnCnt then
        State.HighlightIdx := FHighlights.FindRangeIdx(Doc.LineSegments[Ln].Start)
      else
        State.HighlightIdx := FHighlights.RangesCnt;
    end;

var
    CharW, CharPix, Off, OffE, OffS, Cnt, NewY: Integer;
    Ch: TLMDChar;
    CharSet, FontCharSet: TFontCharset;
    Seg: TLMDSegment;
    IsBreakable: Boolean;
    IsParen: Boolean;
    IsTab: Boolean;
    NoWrapOpt, Jump: Boolean;
    SpaceSpec, TokenChanged: Boolean;
    HighlightInRange: Boolean;
begin
  CheckValidState([csFolds]);

  CharPix := 0;//stupid D2005 compiler warning
  ChunkOutput.OffsetsCount := 0;

  TokenArrLength := Length(FWPTokenArr);

  NoWrapOpt := NoWrap;
  Seq := Buffer;

  FontCharSet := FFont.Charset;
  if FSpecChars.UseCharset then
    SpecCharSet := FSpecChars.Charset
  else
    SpecCharSet := FontCharset;

  TailWrap := GetTailSpecCharWidth(skLineWrap);

  LnCnt := Doc.LinesCount;
  Ln := AStart.PhysLine;
  if Ln < LnCnt then
    Col := AStart.Offset - Doc.LineSegments[Ln].Start
  else
    Col := 0;

  WrapW := ActualWrapWidth;

  if DoChunkOutput then
  begin
    Assert(ChunkOutput.ChunksCount = 0);
    Assert(Cond = wpByXPixY);
    Assert(AStart.Y = Target.Y);
  end;

  State := AStart;
  Found := false;

  SpaceSpec := skSpace in FSpecChars.ShowCharKinds;

  InitStatesForLine;

  InitLine;
  while (not Found) and (Ln < LnCnt) do
  begin
    Off := State.Offset;

    IsTab := false;

    if Off < LnLast then
    begin
      Ch := Seq[Off];
      CharW := 1;

      //Get char width
      case Ch of
        LMDTab:
        begin
          IsTab := true;

          CharSet := FSpecialCharsCharSetMap[skTabTail];

          Seg := FSpecialCharsMap[skTabTail];
          CharW := GetTabWidth(State.X, TabWidth);

          Assert(Seg.Count >= CharW);
          Inc(Seg.Start, Seg.Count - CharW);
          Dec(Seg.Count, Seg.Count - CharW);

          CharPix := GetSegWidth(Seg, State.Attrs.FontStyle, CharSet);
        end;

        LMDSpace:
        begin
          Seg := FSpecialCharsMap[skSpace];
          CharSet := FSpecialCharsCharSetMap[skSpace];

          if SpaceSpec then
            CharPix := GetSegWidth(Seg, State.Attrs.FontStyle, CharSet)
          else
            CharPix := FSpaceCharW;
        end;
      else
        Seg := LMDSegment(Off, 1, Seq);
        CharSet := FontCharSet;

        CharPix := GetCharWidth(Ch, State.Attrs.FontStyle, CharSet);
      end;
    end
    else
    begin
      Ch := #0;
      CharPix := TailCR + TailCollapsed;

      CharW := 1;

      CharSet := FontCharSet;
      Seg := LMDBadSegment;
    end;

    if (State.XPix + CharPix < WrapW) or (Off = State.Y_OffsetStart) then
    begin
      State.VisWidth := CharW;
      State.PixWidth := CharPix;
      State.IsTail := Off = LnLast;
      State.IsTab := IsTab;

      if State.IsTail and (State.PixWidth=0) then
        State.PixWidth := FSpaceCharW;

      //Is Off breakable? Can i wrap line after Off?
      IsParen := (Ch='(') or (Ch='{') or (Ch='[');
      IsBreakable := FSeparatorsSet.Contains(Ch) and (not IsParen);

      if NoWrapOpt or
         (Off=State.Y_OffsetStart) or
         ((State.XPix + CharPix + TailWrap < WrapW) and //Can it contain a 'wrap line' spec char?
          (Off < LnLast-2) and //Do not wrap last char
          ((not BreakStateHard) or IsBreakable))
      then
      begin
        State.IsStable := true;
        BreakStateHard := IsBreakable;
        BreakState := State;
        BreakStateTok := Tok;
        BreakStateBase := TokBase;

        BreakStateChunk := ChunkOutput.ChunksCount - 1;

        SaveState;//A2
      end;

      //Set result candidate
      if not HaveResCand then
      begin
        if not HaveResCand then
          case Cond of
            wpByOffset: HaveResCand := Target.Offset <= Off; //(*)

            wpByXY:     HaveResCand := (Target.Y = State.Y) and
                                       ((Off=LnLast) or ((State.X + CharW) > Target.X));

            wpByXPixY:  HaveResCand := (Target.Y = State.Y) and
                                       ((Off=LnLast) or ((State.XPix + CharPix) > Target.XPix));
          else
            Assert(false);
          end;

        if HaveResCand then
        begin
          ResCand := State;

          ResCandChunk := ChunkOutput.ChunksCount - 1;
        end;
      end;

      if DoChunkOutput then
      begin
        if State.Offset < LnLast  then
          AddStateToChunks(Seg, CharSet, State.Attrs, State.AttrsWeight,
                           (not IsTab) and (Seg.Count=1))
        else
        begin
          if TailCR<>0 then
          begin
            Seg := FSpecialCharsMap[TailKind];
            AddStateToChunks(Seg, SpecCharSet, State.Attrs, State.AttrsWeight, false);
          end;

          if TailCollapsed<>0 then
          begin
            Seg := FSpecialCharsMap[skFoldedLineEnd];
            AddStateToChunks(Seg, SpecCharSet, State.Attrs, State.AttrsWeight, false);
          end;
        end;
      end;

      //Check for exit
      Found := HaveResCand and
               ((ResCand.Offset <= BreakState.Offset) or (Off=LnLast));

      //Move state by one char
      if not Found then
      begin
        Jump := NoWrapOpt;
        if Jump then
          case Cond of
            wpByOffset: Jump := Target.Offset > LnLast;
            wpByXY, wpByXPixY: Jump := Target.Y > State.Y;
          end;

        if (not Jump) and (State.Offset < LnLast) then
        begin
          State.IsTail := false;
          State.IsStable := false;
          Inc(State.Offset);

          Inc(State.X, CharW);
          Inc(State.XPix, CharPix);

          TokenChanged := State.Offset > LMDSegEnd(FWPTokenArr[Tok].Seg);

          if TokenChanged then
          begin
            Inc(Tok);

            if (State.Offset < LnLast) and (Tok >= TokCnt) then
            begin
              Assert(TokLine <> nil);

              TokCnt := TokLine.GetTokens(TokBase + TokCnt,
                                          TokenArrLength,
                                          FWPTokenArr);

              Assert(TokCnt > 0);
              Tok := 0;
            end;

            if Tok < TokCnt then
              State.Attrs := CombineAttrs(FWPTokenArr[Tok].Attrs, FDefaultAttrs)
            else
              State.Attrs := FDefaultAttrs;
          end;

          if HighlightUse and (State.HighlightIdx < FHighlights.RangesCnt)  then
          begin
            with FHighlights.Ranges[State.HighlightIdx] do
            begin
              OffS := Start;
              OffE := Start + Count;
            end;

            if (State.Offset = OffS) or
               (TokenChanged and (State.Offset > OffS) and (State.Offset < OffE))
            then
            begin
              State.Attrs := CombineAttrs(FHighlightAttrs, State.Attrs);
              State.AttrsWeight := 1;
            end
            else if State.Offset >= OffE then
            begin
              Inc(State.HighlightIdx);

              HighlightInRange := (State.HighlightIdx < FHighlights.RangesCnt) and
                                  (State.Offset >=
                                   FHighlights.Ranges[State.HighlightIdx].Start);

              State.AttrsWeight := 0;
              if HighlightInRange then
              begin
                State.Attrs := CombineAttrs(FHighlightAttrs, State.Attrs);
                State.AttrsWeight := 1;
              end
              else if (State.Offset < LnLast) and (Tok < TokCnt) then
                State.Attrs := CombineAttrs(FWPTokenArr[Tok].Attrs, FDefaultAttrs)
              else
                State.Attrs := FDefaultAttrs;
            end;
          end;
        end
        else
        begin
          if Jump then
          begin
            NewY := State.Y;

            case Cond of
              wpByOffset:
              begin
                while (Ln<>LnCnt) and (LMDSegEnd(Doc.LineSegments[Ln])+1 < Target.Offset) do
                begin
                  Ln := GetNextVisibleLine(Ln, false);
                  Inc(NewY);
                end;
              end;

              wpByXY, wpByXPixY:
              begin
                while (Ln<>LnCnt) and (NewY <> Target.Y) do
                begin
                  Ln := GetNextVisibleLine(Ln, false);
                  Inc(NewY);
                end;
              end;
            end;

            State.Y := NewY - 1;
          end
          else
            Ln := GetNextVisibleLine(Ln, false);

          InitHighlightIdx(Ln);
          InitLine;

          State.X := 0;
          State.XPix := 0;

          State.Offset := LnFirst;

          State.PhysLine := Ln;

          Inc(State.Y);
          State.Y_OffsetStart := State.Offset;

          State.VisWidth := -1;
          State.PixWidth := -1;
          State.IsTail := false;
          State.IsStable := false;

          InitStatesForLine;
        end;
      end
      else
      begin
        State := ResCand;

        if DoChunkOutput then
          CutChunksToState(ResCandChunk);
      end;
    end
    else
    begin
      State := BreakState;
      Tok := BreakStateTok;
      if BreakStateBase <> TokBase then
      begin
        TokBase := BreakStateBase;
        Assert(TokLine <> nil);

        TokCnt := TokLine.GetTokens(TokBase, TokenArrLength, FWPTokenArr);
      end;

      Assert(State.X >= 0);
      Assert(State.XPix >= 0);

      if DoChunkOutput then
      begin
        CutChunksToState(BreakStateChunk);

        if TailWrap <> 0 then
        begin
          Seg := FSpecialCharsMap[skLineWrap];
          AddStateToChunks(Seg, SpecCharSet, State.Attrs, State.AttrsWeight, false);
        end;
      end;

      case Cond of
        wpByOffset: Assert(Target.Offset > State.Offset); //Should be caught in (*)

        wpByXY,
        wpByXPixY:
          Found := Target.Y = State.Y;
      else
        Assert(false);
      end;

      if not Found then
      begin
        if IsCollapsed then
        begin
          Ln := GetNextVisibleLine(Ln, true);

          InitHighlightIdx(Ln);
          InitLine;

          State.Offset := LnFirst;
          State.PhysLine := Ln;
        end
        else
          Inc(State.Offset);

        State.IsStable := false;
        State.IsTail := false;
        State.X := 0;
        State.XPix := 0;
        Inc(State.Y);

        State.VisWidth := -1;
        State.PixWidth := -1;

        State.Y_OffsetStart := State.Offset;

        InitStatesForLine;
      end;
    end;
  end;

  Result := State;

  //(A1), (A2)
  case Cond of
    wpByXY:     if Result.Y = Target.Y then
                  Assert(Result.X <= Target.X);

    wpByXPixY:  if Result.Y = Target.Y then
                  Assert(Result.XPix <= Target.XPix);
  end;

  if Result.X=0 then
    Assert(Result.XPix=0);

  if DoChunkOutput then
  begin
    ChunkOutput.OffsetsCount := Result.Offset - AStart.Offset + 1;
    SetLength(ChunkOutput.Offsets, ChunkOutput.OffsetsCount);

    if Result.IsTail then
    begin
      Cnt := ChunkOutput.OffsetsCount;

      with ChunkOutput.Offsets[Cnt - 1] do
      begin
        VisW := Result.VisWidth;
        PixW := Result.PixWidth;

        VisX := Result.X;
        PixX := Result.XPix;

        Flags := [soTail];

        if Result.IsTab then
          Include(Flags, soTab);

        if Result.IsStable then
          Include(Flags, soStable);
      end;
    end;
  end;
end;
{$HINTS ON}//Stupid D2005 compiler hints

function TScreenCache.WP_GetNearestCached(Offset, X, Y: Integer;
                                          Cond: TWP_Condition;
                                          var Res: TWrapParserState): Boolean;
var
    X0, i, Scr, OffS, OffE: Integer;
    itm: PScreenOffsetItem;
    Chunk: PChunk;
    ChunkCnt: Integer;

  procedure AdvanceState;
  begin
    Inc(i);
    Inc(itm);

    if (ChunkCnt <> 0) and
       (i >= Chunk.StateOffset + Chunk.StateOffsetCount)
    then
    begin
      Inc(Chunk);
      Dec(ChunkCnt);
    end;
  end;

begin
  CheckValidState([csFolds, csConversionCaches]);

  Result := false;

  if csScreen in FValidState then
  begin
    case cond of
      wpByOffset: Scr := FindOffsetInVisibleScreen(Offset);
      wpByXY,
      wpByXPixY: Scr := Y - FirstLineScroll;
    else
      Scr := -1;
    end;

    if (Scr >= 0) and (Scr < LinesOnScreenScroll) then
    begin
      Chunk := nil;
      itm := nil;

      with FScreenLines[Scr] do
      begin
        Res := StartState;

        OffS := Res.Offset;
        i := OffS;
        OffE := OffS + OffsetsCount - 1;

        ChunkCnt := ChunksCount;
        if ChunkCnt > 0 then
          Chunk := @Chunks[0];

        if OffsetsCount > 0 then
          itm := @Offsets[0];
      end;

      case Cond of
        wpByOffset:
        begin
          Result := (Offset >= OffS) and (Offset <= OffE);
          if Result then
          begin
            OffE := Min(OffE, Offset);
            while i < OffE do
              AdvanceState;

            Assert(i = Offset);
          end;
        end;

        wpByXY:
        begin
          X0 := Res.X;
          while (X0 < X) and (i < OffE) do
          begin
            AdvanceState;

            X0 := itm.VisX;
          end;

          Result := X = X0;
        end;

        wpByXPixY:
        begin
          X0 := Res.XPix;
          while (X0 < X) and (i < OffE) do
          begin
            AdvanceState;

            X0 := itm.PixX;
          end;

          Result := X = X0;
        end;
      end;
    end;
  end;

  if Result then
  begin
    Res.Offset := i;
    Res.X := itm.VisX;
    Res.XPix := itm.PixX;
    Res.VisWidth := itm.VisW;
    Res.PixWidth := itm.PixW;

    Res.IsTail   := soTail   in itm.Flags;
    Res.IsTab    := soTab    in itm.Flags;
    Res.IsStable := soStable in itm.Flags;

    if ChunkCnt <> 0 then
    begin
      Res.Attrs := Chunk.Attrs;
      Res.AttrsWeight := Chunk.AttrsWeight;
    end
    else
      Res.Attrs := FDefaultAttrs;
  end
  else
    Result := FWPCache.GetNearestState(Offset, X, Y, Cond, Res)
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.WP_InvalidateCached(AOffset: Integer);
begin
  FWPCache.Invalidate(AOffset);
end;

{------------------------------------------------------------------------------}

function TScreenCache.WP_GetStateOverFolds(AOffset: Integer): TWrapParserState;
begin
  Result := WP_GetStateOff(AOffset, true);
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.WP_InitZeroState(var AState: TWrapParserState);
begin
  AState.Offset := 0;
  AState.X := 0;
  AState.XPix := 0;
  AState.Y := 0;
  AState.Y_OffsetStart := 0;
  AState.PhysLine := 0;
  AState.VisWidth := 0;
  AState.PixWidth := 0;
  AState.IsTail := true;
  AState.IsStable := false;
  AState.Attrs.AttributesSet := [];

  AState.HighlightIdx := 0;

  AState.AttrsWeight := 0;
end;

{------------------------------------------------------------------------------}

function TScreenCache.WP_GetStateOff(AOffset: Integer; AOverFolds: Boolean): TWrapParserState;

procedure RaiseErr;
begin
  raise TWP_InvisibleOffsetError.CreateFmt('Invisible offset given to WP_GetState: %d',
                                      [AOffset]);
end;

var
    State, Target: TWrapParserState;
    Ok: Boolean;
begin
  CheckValidState([csFolds, csConversionCaches]);
  CheckOffsetForScroll(AOffset, true);

  Ok := WP_GetNearestCached(AOffset, -1, -1, wpByOffset, State);

  if Ok and (State.Offset=AOffset) then
    Result := State
  else
  begin
    Assert((not Ok) or (State.Offset < AOffset));

    if not Ok then
      WP_InitZeroState(State);

    Target.Offset := AOffset;
    Target.Y := -1;
    Target.X := -1;
    Target.XPix := -1;

    Result := WP_MoveToState(State, Target, wpByOffset, false, @DummyScreenLine);

    if (not AOverFolds) and (Result.Offset<>AOffset) then
      RaiseErr;

    if Result.Offset=AOffset then
      FWPCache.PutState(Result);
  end;
end;

{------------------------------------------------------------------------------}

function TScreenCache.WP_GetState(AOffset: Integer): TWrapParserState;
begin
  Result := WP_GetStateOff(AOffset, false);
end;

{------------------------------------------------------------------------------}

function TScreenCache.WP_GetState(X, Y: Integer; IsXPix: Boolean; DoCheckY: Boolean): TWrapParserState;
var
    State, Target: TWrapParserState;
    Cond: TWP_Condition;
    Ok: Boolean;

  procedure RaiseErr;
  begin
      raise ELMDEditViewError.CreateFmt(SLMDSedViewBadScrollLine,
                                        [Y, 0, State.Y]);
  end;


begin
  Assert(X >= 0);
  Assert(Y >= 0);
  CheckValidState([csFolds, csConversionCaches]);

  if IsXPix then
    Cond := wpByXPixY
  else
    Cond := wpByXY;

  Ok := WP_GetNearestCached(-1, X, Y, Cond, State);

  if Ok and (Cond=wpByXPixY) and (Y=State.Y) and (X=State.XPix) then
    Result := State
  else if Ok and (Cond=wpByXY) and (Y=State.Y) and (X=State.X) then
    Result := State
  else
  begin
    if not Ok then
      WP_InitZeroState(State);

    Target.Offset := -1;
    Target.X := -1;
    Target.XPix := -1;

    if IsXPix then
    begin
      Cond := wpByXPixY;
      Target.XPix := X;
    end
    else
    begin
      Cond := wpByXY;
      Target.X := X;
    end;
    Target.Y := Y;

    Result := WP_MoveToState(State, Target, Cond, false, @DummyScreenLine);

    if (Y = Result.Y) and
       ((IsXPix and (X >= Result.XPix)) or ((not IsXPix) and (X >= Result.X)))
    then
      FWPCache.PutState(Result);
  end;

  if DoCheckY and (Result.Y <> Y) then
  begin
    Assert(Y > Result.Y);
    RaiseErr;
  end;
end;

{------------------------------------------------------------------------------}

function TScreenCache.WP_FillChunks(AStart: TWrapParserState;
                                    APixWidth: Integer;
                                    AScreenLine: PScreenLineInfo):
                                    TWrapParserState;
var
    Dest: TWrapParserState;
begin
  AScreenLine.ChunksCount := 0;

  Dest.Y := AStart.Y;
  Dest.XPix := AStart.XPix + APixWidth;
  Result := WP_MoveToState(AStart, Dest, wpByXPixY, true, AScreenLine);
end;
{------------------------------------------------------------------------------}

function TScreenCache.AfterLastScroll(Y: Integer): Boolean;
var
    YNew: Integer;
begin
  YNew := Y;
  CorrectToLastScroll(Y);

  Result := YNew > Y;
end;

{------------------------------------------------------------------------------}

procedure TScreenCache.CorrectToLastScroll(var Y: Integer);
var
    Res: TWrapParserState;
begin
  //Assert(Y >= 0);
  Y := Max(0, Y);
  CheckValidState([csFolds, csConversionCaches]);

  if (csScreen in FValidState) and LMDInRange(Y, FirstLineScroll, LastLineScroll) then
    Exit;

  Res := WP_GetState(0, Y, false, false);

  if Res.PhysLine = Doc.LinesCount  then
    Y := Res.Y - 1
  else
    Y := Res.Y;
end;

{********************************** TViewLst **********************************}
{------------------------------------------------------------------------------}

constructor TViewLst.Create(AParent: TLMDCustomEditView);
begin
  inherited Create;

  Assert(AParent<>nil);
  Parent := AParent;
end;

{------------------------------------------------------------------------------}

procedure TViewLst.BeforeInsert(AStart, ACount: Integer);
begin
  Parent.BeforeInsert(AStart, ACount)
end;

{------------------------------------------------------------------------------}

procedure TViewLst.AfterInsert(AStart, ACount: Integer);
begin
  Parent.AfterInsert(AStart, ACount)
end;

{------------------------------------------------------------------------------}

procedure TViewLst.BeforeDelete(AStart, ACount: Integer);
begin
  Parent.BeforeDelete(AStart, ACount);
end;

{------------------------------------------------------------------------------}

procedure TViewLst.AfterDelete(AStart, ACount: Integer);
begin
  Parent.AfterDelete(AStart, ACount);
end;

{------------------------------------------------------------------------------}

procedure TViewLst.BeforeRefresh;
begin
  Parent.BeforeDocRefresh;
end;

{------------------------------------------------------------------------------}

procedure TViewLst.AfterRefresh;
begin
  Parent.AfterDocRefresh;
end;

{------------------------------------------------------------------------------}

procedure TViewLst.BeforeSettingsRefresh;
begin
  Parent.BeforeDocSettingsRefresh;
end;

{------------------------------------------------------------------------------}
procedure TViewLst.AfterSettingsRefresh;
begin
  Parent.AfterDocSettingsRefresh;
end;

{------------------------------------------------------------------------------}

procedure TViewLst.DocumentDestroing;
begin
  Parent.DocumentDestroing;
end;

procedure TViewLst.DoUserEventAfterDocChange;
begin
  Parent.DoUserEventAfterDocChange;
end;

{------------------------------------------------------------------------------}

procedure TViewLst.MarkSettingsChanged(AMarkers: ILMDMarkers;
                                       const AMark: ILMDMark);
begin
  Parent.MarkSettingsChanged(AMarkers, AMark)
end;

{------------------------------------------------------------------------------}

procedure TViewLst.AfterMarkChange;
begin
  Parent.AfterMarkChange
end;

{------------------------------------------------------------------------------}

procedure TViewLst.BeforeMarkChange;
begin
  Parent.BeforeMarkChange
end;

{------------------------------------------------------------------------------}

procedure TViewLst.BeforeCompoundEdit(AFreezeViews: Boolean);
begin
  Parent.BeforeCompoundEdit(AFreezeViews);
end;

{------------------------------------------------------------------------------}

procedure TViewLst.AfterCompoundEdit(AFreezeViews: Boolean);
begin
  Parent.AfterCompoundEdit(AFreezeViews);
end;

{******************************** TSpacedSeq **********************************}
{------------------------------------------------------------------------------}

constructor TSpacedSeq.Create;
begin
  inherited Create(256);

  Self.Reset(LMDBadSegment, -1, -1);
end;

{------------------------------------------------------------------------------}

procedure TSpacedSeq.Reset(const ASeg: TLMDSegment;
  ASpacesBefore, ASpacesAfter: Integer);
begin
  FSeg := ASeg;
  FSpacesBefore := ASpacesBefore;
  FSpacesAfter := ASpacesAfter;

  FCount := FSeg.Count + FSpacesBefore + FSpacesAfter;

  ResetBuffer;
end;

{------------------------------------------------------------------------------}

procedure TSpacedSeq.FillBuffer(ABufferStart, ABufferEnd: Integer);
var
  i: Integer;
begin
  for i := ABufferStart to ABufferEnd-1 do
    if LMDInRange(i, FSpacesBefore, FSpacesBefore+FSeg.Count) then
      Buffer[i - ABufferStart] := LMDSegAt(i - FSpacesBefore, FSeg)
    else
      Buffer[i - ABufferStart] := LMDSpace;
end;


{******************************* TLMDGutterBar ********************************}
{------------------------------------------------------------------------------}

procedure TLMDGutterBar.SetKind(Value: TLMDGutterBarKind);
begin
  if FKind <> Value then
  begin
    FKind := Value;
    Changed(False)
  end
end;

procedure TLMDGutterBar.SetLeftPadding(Value: Integer);
begin
  if FLeftPadding <> Value then
  begin
    if Value<0 then
      raise ELMDEditViewError.Create(SLMDSedViewInvalidGutterBarPadding);

    FLeftPadding := Value;
    Changed(False);
  end;
end;

procedure TLMDGutterBar.SetRightPadding(const Value: Integer);
begin
  if FRightPadding <> Value then
  begin
    if Value<0 then
      raise ELMDEditViewError.Create(SLMDSedViewInvalidGutterBarPadding);

    FRightPadding := Value;
    Changed(False);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutterBar.SetWidth(Value: Integer);
begin
  if FWidth <> Value then
  begin
    if Value<=0 then
      raise ELMDEditViewError.Create(SLMDSedViewInvalidGutterBarWidth);

    FWidth := Value;
    Changed(False);
  end
end;

{------------------------------------------------------------------------------}

function TLMDGutterBar.GetFullWidth: Integer;
begin
  Result := Width + LeftPadding + RightPadding;
end;

{------------------------------------------------------------------------------}

function TLMDGutterBar.GetWidth: Integer;
var MaxNum: TLMDString; View: TLMDCustomEditView;
begin
  if FKind<>gbLineNumberBar then
    Result := FWidth
  else
  begin
    View := FParent.FGutter.FParent;
    if View.HandleAllocated then
    begin
      MaxNum := IntToStr(View.MyDoc.LinesCount);
      View.Canvas.Font := View.Font;
      Result := Max(FWidth, View.Canvas.TextWidth(MaxNum));
    end
    else
      Result := FWidth;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutterBar.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(False);
  end;
end;

{------------------------------------------------------------------------------}

constructor TLMDGutterBar.Create(Collection: TCollection);
begin
  FParent := Collection as TLMDGutterBars;
  FGutter := FParent.FGutter;

  FKind := gbCustom;

  FLeftPadding := DEF_GUTTER_BAR_PADDING;
  FRightPadding := DEF_GUTTER_BAR_PADDING;
  FWidth   := DEF_GUTTER_BAR_WIDTH;
  FVisible := True;

  inherited Create(Collection);
end;

{------------------------------------------------------------------------------}

procedure TLMDGutterBar.Assign(Source: TPersistent);
var
  src:        TLMDGutterBar;
  hasChanged: Boolean;
begin
  if Source is TLMDGutterBar then
  begin
    src := TLMDGutterBar(Source);

    hasChanged := (FWidth<>Src.Width) or (FLeftPadding<>Src.LeftPadding) or
                  (FRightPadding<>Src.RightPadding) or
                  (FVisible<>Src.Visible);

    FWidth := Src.Width;
    FRightPadding := Src.RightPadding;
    FLeftPadding := Src.LeftPadding;
    FKind := Src.Kind;
    FVisible := Src.Visible;

    if hasChanged then
      Changed(False);
  end
  else
    inherited Assign(Source)
end;

{***************************** TLMDGutterBars *********************************}
{------------------------------------------------------------------------------}

function TLMDGutterBars.GetItem(Index: Integer): TLMDGutterBar;
begin
  Result := TLMDGutterBar(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}

procedure TLMDGutterBars.SetItem(Index: Integer; Value: TLMDGutterBar);
begin
  inherited SetItem(Index, Value);
end;

{------------------------------------------------------------------------------}

function TLMDGutterBars.GetOwner: TPersistent;
begin
  Result := Self.FGutter;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutterBars.Update(Item: TCollectionItem);
begin
  inherited Update(Item);

  FGutter.BeginUpdate;
  FGutter.EndUpdate;
end;

{------------------------------------------------------------------------------}

constructor TLMDGutterBars.Create(AParent: TLMDGutter);
begin
  if (AParent=nil) or (AParent.Bars<>nil) then
    raise ELMDEditViewError.Create(SLMDSedViewInternalClassCreate);

  FGutter := AParent;
  inherited Create(TLMDGutterBar);
end;

{------------------------------------------------------------------------------}

function TLMDGutterBars.Add: TLMDGutterBar;
begin
  Result := TLMDGutterBar(inherited Add);
end;

{------------------------------------------------------------------------------}

function TLMDGutterBars.AddItem(Item: TLMDGutterBar;
  Index: Integer): TLMDGutterBar;
begin
  if Item = nil then
    Result := TLMDGutterBar.Create(Self)
  else
    Result := Item;

  if Assigned(Result) then
  begin
    Result.Collection := Self;
    if Index < 0 then
      Index := Count - 1;

    Result.Index := Index
  end
end;

{------------------------------------------------------------------------------}

function TLMDGutterBars.Insert(Index: Integer): TLMDGutterBar;
begin
  Result := AddItem(nil, Index)
end;

{******************************** TLMDGutter **********************************}
{------------------------------------------------------------------------------}

constructor TLMDGutter.Create(AParent: TLMDCustomEditView);

  function GetImg(Name: string): Graphics.TBitmap;
  begin
    Result := SedGetResourceImage(Name);
    Result.TransparentMode := tmAuto;
    Result.Transparent := True
  end;

var i: Integer;
begin
  if (AParent=nil) or (AParent.Gutter<>nil) then
    raise ELMDEditViewError.Create(SLMDSedViewInternalClassCreate);

  inherited Create;

  try
    FInConstructor := true;

    FParent := AParent;

    FBookmarksBarBg := RGB(236, 233, 216);
    FBookmarksBarTextColor := clBlack;
    FLinesBarBg := RGB(244, 244, 244);
    FLinesBarTextColor := RGB(153, 153, 204);
    FLineNumberingInterval := 10;
    FFoldsBarLineColor := FLinesBarTextColor;
    FFoldsBarBg := FLinesBarBg;
    FCustomBarBg := FLinesBarBg;

    FBookmarkImg      := Graphics.TBitmap.Create;
    FBreakActiveImg   := Graphics.TBitmap.Create;
    FBreakDisabledImg := Graphics.TBitmap.Create;
    FBreakInactiveImg := Graphics.TBitmap.Create;
    FFoldPlusImg      := Graphics.TBitmap.Create;
    FFoldMinusImg     := Graphics.TBitmap.Create;
    FFoldEndImg       := Graphics.TBitmap.Create;
    FWrapLineBarImg   := Graphics.TBitmap.Create;

    FDebugFrameTopImg     := Graphics.TBitmap.Create;
    FDebugFrameActiveImg  := Graphics.TBitmap.Create;
    FDebugFrameImg        := Graphics.TBitmap.Create;

    FBars := nil;//this for TLMDGutterBars.Create
    FBars := TLMDGutterBars.Create(Self);

    for i:=0 to Length(DEF_GUTTER_BARS)-1 do
      FBars.Add.Kind := DEF_GUTTER_BARS[i];

    FSettings := [gsPaintWrapsOnLineNumberBar];
  finally
    FInConstructor := false;
  end;
end;

{------------------------------------------------------------------------------}

destructor TLMDGutter.Destroy;
begin
  FBookmarkImg.Free;
  FBreakActiveImg.Free;
  FBreakInactiveImg.Free;
  FBreakDisabledImg.Free;
  FFoldPlusImg.Free;
  FFoldMinusImg.Free;
  FFoldEndImg.Free;
  FWrapLineBarImg.Free;

  FDebugFrameTopImg.Free;
  FDebugFrameActiveImg.Free;
  FDebugFrameImg.Free;

  FBars.Free;

  inherited Destroy;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.Assign(Source: TPersistent);
var
  src: TLMDGutter;
begin
  if Source=Self then
    Exit;

  if Source is TLMDGutter then
  begin
    src := TLMDGutter(source);

    FParent.BeginSettingsChange;
    try
      FBookmarkImg.Assign(src.FBookmarkImg);
      FBreakActiveImg.Assign(src.FBreakActiveImg);
      FBreakInactiveImg.Assign(src.FBreakInactiveImg);
      FBreakDisabledImg.Assign(src.FBreakDisabledImg);
      FFoldPlusImg.Assign(src.FFoldPlusImg);
      FFoldMinusImg.Assign(src.FFoldMinusImg);
      FFoldEndImg.Assign(src.FFoldEndImg);

      FDebugFrameTopImg.Assign(src.FDebugFrameTopImg);
      FDebugFrameActiveImg.Assign(src.FDebugFrameActiveImg);
      FDebugFrameImg.Assign(src.FDebugFrameImg);

      FParent := src.FParent;
      FLinesBarBg := src.FLinesBarBg;
      FLinesBarTextColor := src.FLinesBarTextColor;
      FLineNumberingInterval := src.FLineNumberingInterval;
      FFoldsBarBg := src.FFoldsBarBg;
      FFoldsBarLineColor := src.FFoldsBarLineColor;

      FBookmarksBarBg := src.FBookmarksBarBg;

      FBars.Assign(src.FBars);

      FParent.AddStatusChange(scGutterSettings);
    finally
      FParent.EndSettingsChange(false, false);
    end;
  end
  else
    inherited Assign(Source);
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.BeginUpdate;
begin
  if FInConstructor then
    Exit;

  FParent.BeginSettingsChange;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.EndUpdate;
begin
  if FInConstructor then
    Exit;

  FParent.AddStatusChange(scGutterSettings);
  FParent.EndSettingsChange(false, false);
end;

{------------------------------------------------------------------------------}

function TLMDGutter.GetWidth: Integer;
var
  i: Integer;
begin
  Result := 0;

  for i := 0 to FBars.Count-1 do
    if FBars[i].Visible then
      Inc(Result, FBars[i].FullWidth)
end;

function TLMDGutter.GetWrapImageForDrawing: Graphics.TBitmap;
begin
  if not FWrapLineBarImg.Empty then
    Result := FWrapLineBarImg
  else
    Result := DefWrapLineImg;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetDebugFrameTopImg(AImg: Graphics.TBitmap);
begin
  BeginUpdate;
  try
    FDebugFrameTopImg.Assign(AImg);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetDebugFrameActiveImg(AImg: Graphics.TBitmap);
begin
  BeginUpdate;
  try
    FDebugFrameActiveImg.Assign(AImg);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.StackDebugFrameImg(AImg: Graphics.TBitmap);
begin
  BeginUpdate;
  try
    FDebugFrameImg.Assign(AImg);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetBookmarkImg(AImg: Graphics.TBitmap);
begin
  BeginUpdate;
  try
    FBookmarkImg.Assign(AImg);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetBreakActiveImg(AImg: Graphics.TBitmap);
begin
  BeginUpdate;
  try
    FBreakActiveImg.Assign(AImg);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetBreakInactiveImg(AImg: Graphics.TBitmap);
begin
  BeginUpdate;
  try
    FBreakInactiveImg.Assign(AImg);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetBreakDisabledImg(AImg: Graphics.TBitmap);
begin
  BeginUpdate;
  try
    FBreakDisabledImg.Assign(AImg);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetFoldPlusImg(AImg: Graphics.TBitmap);
begin
  BeginUpdate;
  try
    FFoldPlusImg.Assign(AImg);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetFoldMinusImg(AImg: Graphics.TBitmap);
begin
  BeginUpdate;
  try
    FFoldMinusImg.Assign(AImg);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetFoldEndImg(AImg: Graphics.TBitmap);
begin
  BeginUpdate;
  try
    FFoldEndImg.Assign(AImg);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDGutter.GetBookImageForDrawing(
  const AMark: ILMDLineMark): Graphics.TBitmap;
begin
  if not FBookmarkImg.Empty then
    Result := FBookmarkImg
  else
    Result := DefBookmarkImg;
end;

{------------------------------------------------------------------------------}

function TLMDGutter.GetBreakImageForDrawing(const AProps): Graphics.TBitmap;
var
    Props: TLMDScreenLineProps;
begin
  Props := TLMDScreenLineProps(AProps);
  Result := nil;

  if lpBreakpointActive in Props then
  begin
    if not FBreakActiveImg.Empty then
      Result := FBreakActiveImg
    else
      Result := DefBreakActiveImg;
  end
  else if lpBreakpointDisabled in Props then
  begin
    if not FBreakDisabledImg.Empty then
      Result := FBreakDisabledImg
    else
      Result := DefBreakDisabledImg;
  end
  else if lpBreakpointInactive in Props then
  begin
    if not FBreakInactiveImg.Empty then
      Result := FBreakInactiveImg
    else
      Result := DefBreakInactiveImg;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDGutter.GetDbgImageForDrawing(const AProps): Graphics.TBitmap;
var
    Props: TLMDScreenLineProps;
begin
  Props := TLMDScreenLineProps(AProps);
  Result := nil;

  if lpFrameActive in Props then
  begin
    if not FDebugFrameActiveImg.Empty then
      Result := FDebugFrameActiveImg
    else
      Result := DefDbgActiveImg;
  end
  else if lpFrameTop in Props then
  begin
    if not FDebugFrameTopImg.Empty then
      Result := FDebugFrameTopImg
    else
      Result := DefDbgTopImg;
  end
  else if lpFrame in Props then
  begin
    if not FDebugFrameImg.Empty then
      Result := FDebugFrameImg;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDGutter.GetFoldImageForDrawing(
  AExpanded: Boolean): Graphics.TBitmap;
begin
  if AExpanded then
  begin
    if not FFoldMinusImg.Empty then
      Result := FFoldMinusImg
    else
      Result := DefFoldMinusImg;
  end
  else
  begin
    if not FFoldPlusImg.Empty then
      Result := FFoldPlusImg
    else
      Result := DefFoldPlusImg;
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDGutter.IsBarsStored: Boolean;
var i: Integer;
begin
  Result := Bars.Count<>Length(DEF_GUTTER_BARS);

  if not Result then
    for i:=0 to Bars.Count-1 do
      if (Bars[i].Kind<>DEF_GUTTER_BARS[i]) or
         (Bars[i].Width<>DEF_GUTTER_BAR_WIDTH) or
         (Bars[i].LeftPadding<>DEF_GUTTER_BAR_PADDING) or
         (Bars[i].RightPadding<>DEF_GUTTER_BAR_PADDING) or
         (not Bars[i].Visible)
      then
      begin
        Result := true;
        Exit;
      end;
end;

{------------------------------------------------------------------------------}

function TLMDGutter.GetOwner: TPersistent;
begin
  Result := FParent;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetBars(ABars: TLMDGutterBars);
begin
  if ABars=FBars then
    Exit;

  BeginUpdate;
  try
    FBars.Assign(ABars);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetLineNumberingInterval(AValue: Integer);//UD-UV+E+
begin
  if AValue=FLineNumberingInterval then
    Exit;

  BeginUpdate;
  try
    FLineNumberingInterval := AValue;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetBookmarksBarBg(AColor: TColor);
begin
  if AColor=FBookmarksBarBg then
    Exit;

  BeginUpdate;
  try
    FBookmarksBarBg := AColor;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGutter.SetBookmarksBarTextColor(AColor: TColor);
begin
  if AColor=FBookmarksBarTextColor then
    Exit;

  BeginUpdate;
  try
    FBookmarksBarTextColor := AColor;
  finally
    EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}

procedure TLMDGutter.SetLinesBarTextColor(AColor: TColor);
begin
  if AColor=FLinesBarTextColor then
    Exit;

  BeginUpdate;
  try
    FLinesBarTextColor := AColor;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGutter.SetSettings(ASettings: TLMDGutterSettings);
begin
  if ASettings=FSettings then
    Exit;

  BeginUpdate;
  try
    FSettings := ASettings;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGutter.SetWrapLineBarImg(AImg: Graphics.TBitmap);
begin
  BeginUpdate;
  try
    FWrapLineBarImg.Assign(AImg);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetLinesBarBg(AColor: TColor);
begin
  if AColor=FLinesBarBg then
    Exit;

  BeginUpdate;
  try
    FLinesBarBg := AColor;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetFoldsBarLineColor(AColor: TColor);
begin
  if AColor=FFoldsBarLineColor then
    Exit;

  BeginUpdate;
  try
    FFoldsBarLineColor := AColor;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetFoldsBarBg(AColor: TColor);
begin
  if AColor=FFoldsBarBg then
    Exit;

  BeginUpdate;
  try
    FFoldsBarBg := AColor;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGutter.SetCustomBarBg(AColor: TColor);
begin
  if AColor=FCustomBarBg then
    Exit;

  BeginUpdate;
  try
    FCustomBarBg := AColor;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TComplList.WMLButtonDown(var Message: TWMLButtonDown);
var
    LI: Integer;
begin
  if Cursor <> crDefault then
    MouseCapture := true
  else
  begin
    LI := ItemAtPos(Point(Message.XPos, Message.YPos), True);

    if LI <> -1 then
    begin
      ItemIndex := LI;
      Click;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TComplList.WMNCButtonDown(var Message: TWMNCLBUTTONDOWN);
begin
  if Cursor <> crDefault then
    MouseCapture := true
  else
    inherited;
end;

{------------------------------------------------------------------------------}

procedure TComplList.WMMouseActivate(var Message: TWMMouseActivate);
begin
  Message.Result := MA_NOACTIVATE;
end;

{------------------------------------------------------------------------------}

procedure TComplList.CreateWindowHandle(const Params: TCreateParams);
begin
  LMDCreateControlHandle(Self, Params, 'LISTBOX');
end;

{------------------------------------------------------------------------------}

procedure TComplList.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
end;

{------------------------------------------------------------------------------}

procedure TComplList.WMSetCursor(var Msg: TWMSetCursor);

const Diff = 3;
var
  P: TPoint;
  NewCr: TCursor;
begin
  Windows.GetCursorPos(P);
  P := ScreenToClient(P);

  NewCr := crDefault;

  case Corner of
    rcTopLeft:
      if (P.X <= Diff) and (P.Y <= Diff) then
        NewCr := crSizeNWSE
      else if (P.X <= Diff) and (P.Y > Diff) then
        NewCr := crSizeWE
      else if (P.X > Diff) and (P.Y <= Diff) then
        NewCr := crSizeNS;

    rcTopRight:
      if (P.X >= (Width - Diff)) and (P.Y <= Diff) then
        NewCr := crSizeNESW
      else if (P.X >= (Width - Diff)) and (P.Y > Diff) then
        NewCr := crSizeWE
      else if (P.X < (Width - Diff))   and (P.Y <= Diff) then
        NewCr := crSizeNS;

    rcBottomLeft:
      if (P.X <= Diff) and (P.Y >= (Height - Diff)) then
        NewCr := crSizeNESW
      else if (P.X <= Diff) and (P.Y < (Height - Diff)) then
        NewCr := crSizeWE
      else if (P.X > Diff) and (P.Y >= (Height - Diff)) then
        NewCr := crSizeNS;

    rcBottomRight:
      if (P.X >= (Width - Diff)) and (P.Y >= (Height - Diff)) then
        NewCr := crSizeNWSE
      else if (P.X >= (Width - Diff)) and (P.Y < (Height - Diff)) then
        NewCr := crSizeWE
      else if (P.X < (Width - Diff)) and (P.Y >= (Height - Diff)) then
        NewCr := crSizeNS;
  end;

  Cursor := NewCr;
  SetCursor(Screen.Cursors[NewCr]);
end;

{------------------------------------------------------------------------------}

procedure TComplList.MouseMove(Shift: TShiftState; X, Y: Integer);
var
    LI: Integer;
begin
  if (Cursor <> crDefault) and MouseCapture then
  begin
    case Corner of
      rcTopLeft:
      begin
        case Cursor of
          crSizeNWSE:
          begin
            if (Height - Y) >= Constraints.MinHeight then
            begin
              Top := Top + Y;
              Height := Height - Y;
            end;

            if (Width - X) >= Constraints.MinWidth then
            begin
              Left := Left + X;
              Width := Width - X;
            end;
          end;

          crSizeWE:
          begin
            if (Width - X) >= Constraints.MinWidth then
            begin
              Left := Left + X;
              Width := Width - X;
            end;
          end;

          crSizeNS:
          begin
            if (Height - Y) >= Constraints.MinHeight then
            begin
              Top := Top + Y;
              Height := Height - Y;
            end;
          end;
        end;
      end;

      rcTopRight:
      begin
        case Cursor of
          crSizeNESW:
          begin
            if (Height - Y) >= Constraints.MinHeight then
            begin
              Top := Top + Y;
              Height := Height - Y;
            end;

            Width := X;
          end;

          crSizeWE:
            Width := X;

          crSizeNS:
          begin
            if (Height - Y) >= Constraints.MinHeight then
            begin
              Top := Top + Y;
              Height := Height - Y;
            end;
          end;
        end;
      end;

      rcBottomLeft:
      begin
        case Cursor of
          crSizeNESW:
          begin
            Height := Y;

            if (Width - X) >= Constraints.MinWidth then
            begin
              Left := Left + X;
              Width := Width - X;
            end;
          end;

          crSizeWE:
          begin
            if (Width - X) >= Constraints.MinWidth then
            begin
              Left := Left + X;
              Width := Width - X;
            end;
          end;

          crSizeNS:
            Height := Y;
        end;
      end;

      rcBottomRight:
      begin
        case Cursor of
          crSizeNWSE:
          begin
            Height := Y;
            Width := X;
          end;

          crSizeWE:
            Width := X;

          crSizeNS:
            Height := Y;
        end;
      end;
    end;
  end
  else
  begin
    LI := ItemAtPos(Point(X, Y), True);

    if LI <> -1 then
      ItemIndex := LI;
  end;
end;

{------------------------------------------------------------------------------}

procedure TComplList.MouseUp(Button: TMouseButton;
                             Shift: TShiftState; X, Y: Integer);
begin
  MouseCapture := false;
end;

{------------------------------------------------------------------------------}

procedure TComplList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  with Params do
  begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

{------------------------------------------------------------------------------}
constructor TComplList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle + [csNoDesignVisible];
  ParentColor  := False;

  IsVisible := false;
  Corner := rcTopLeft;
end;

{------------------------------------------------------------------------------}
procedure TComplList.Show(AVisible: Boolean; X, Y: Integer);
begin
  if AVisible then
    SetWindowPos(Handle, HWND_TOP, X, Y, 0, 0,
                 SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW)
  else
    SetWindowPos(Handle, 0, 0, 0, 0, 0,
                 SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or
                 SWP_NOACTIVATE or SWP_HIDEWINDOW);

  IsVisible := AVisible;
end;

{******************************* TSparceArray *********************************}
{------------------------------------------------------------------------------}

procedure THighlightsSparse.DelRanges(AIdx, ACount: Integer);
var
    IdE: Integer;
begin
  if ACount=0 then
    Exit;

  IdE := AIdx + ACount;
  if IdE < RangesCnt then
  begin
    Move(Ranges[IdE], Ranges[AIdx], (RangesCnt - IdE) * SizeOf(Ranges[AIdx]));
  end;

  Dec(RangesCnt, ACount);
  if Length(Ranges) > (RangesCnt+1)*5 then
    SetLength(Ranges, RangesCnt);
end;

{------------------------------------------------------------------------------}

procedure THighlightsSparse.InsRange(AIdx: Integer);
begin
  if Length(Ranges) = RangesCnt then
    SetLength(Ranges, ((RangesCnt + 1) * 3) div 2);

  if AIdx < RangesCnt then
  begin
    Move(Ranges[AIdx], Ranges[AIdx + 1], (RangesCnt - AIdx) * SizeOf(Ranges[AIdx]));
  end;

  Inc(RangesCnt);
end;

{------------------------------------------------------------------------------}

constructor THighlightsSparse.Create;
begin
  inherited Create;

  SetLength(Ranges, 0);
  RangesCnt := 0;
end;

{------------------------------------------------------------------------------}

procedure THighlightsSparse.AddRange(AStart, ACount: Integer);
var
    HitS, HitE: Boolean;
    IdS, IdE, offE: Integer;
begin
  if ACount = 0 then
    Exit;

  IdS := FindRangeIdx(AStart);
  IdE := FindRangeIdx(AStart + ACount - 1);

  HitS := (IdS < RangesCnt) and (Ranges[IdS].Start <= AStart);
  HitE := (IdE < RangesCnt) and (Ranges[IdE].Start < AStart + ACount);

  if IdS = IdE then
  begin
    if (not HitS) and (not HitE) then
    begin
      InsRange(IdS);

      Ranges[IdS].Start := AStart;
      Ranges[IdS].Count := ACount;
    end
    else if (not HitS) and HitE then
    begin
      OffE := Ranges[IdS].Start + Ranges[IdS].Count;
      Ranges[IdS].Start := AStart;
      Ranges[IdS].Count := OffE - Ranges[IdS].Start;
    end
    else
      Assert(HitS and HitE);
  end
  else
  begin
    if IdE <> RangesCnt then
      OffE := Min(Ranges[IdE].Start, AStart + ACount)
    else
      OffE := AStart + ACount;

    if not HitS then
      Ranges[IdS].Start := AStart;

    Ranges[IdS].Count := OffE - Ranges[IdS].Start;

    DelRanges(IdS + 1, IdE - IdS - 1);
  end;
end;

{------------------------------------------------------------------------------}

function THighlightsSparse.RemoveRange(AStart, ACount: Integer): Boolean;
var
    HitS, HitE: Boolean;
    IdS, IdE, offE: Integer;
begin
  Result := ACount <> 0;
  if not Result then
    Exit;

  IdS := FindRangeIdx(AStart);
  IdE := FindRangeIdx(AStart + ACount);

  HitS := (IdS < RangesCnt) and (Ranges[IdS].Start < AStart);
  HitE := (IdE < RangesCnt) and (Ranges[IdE].Start < AStart + ACount);

  if IdS <> IdE then
  begin
    if (not HitS) and (not HitE) then
      DelRanges(IdS, IdE - IdS)
    else if HitS and (not HitE) then
    begin
      DelRanges(IdS + 1, IdE - IdS - 1);
      Ranges[IdS].Count := AStart - Ranges[IdS].Start;
    end
    else if not HitS and HitE then
    begin
      OffE := Ranges[IdE].Start + Ranges[IdE].Count;
      Ranges[IdE].Start := AStart + ACount;
      Ranges[IdE].Count := OffE - Ranges[IdE].Start;

      DelRanges(IdS, IdE - IdS);
    end
    else if HitS and HitE then
    begin
      OffE := Ranges[IdE].Start + Ranges[IdE].Count;
      DelRanges(IdS+1, IdE - IdS);

      Ranges[IdS].Count := OffE - Ranges[IdS].Start;
    end
    else
      Assert(false);
  end
  else if IdS <> RangesCnt then
  begin
    OffE := Ranges[IdS].Start + Ranges[IdS].Count;
    if not HitS and HitE then
    begin
      Ranges[IdS].Start := AStart + ACount;
      Ranges[IdS].Count := OffE - Ranges[IdS].Start;
    end
    else if HitS and HitE then
    begin
      InsRange(IdS + 1);
      Ranges[IdS].Count := AStart - Ranges[IdS].Start;

      Ranges[IdS + 1].Start := AStart + ACount;
      Ranges[IdS + 1].Count := OffE - Ranges[IdS + 1].Start;
    end
    else
      Assert(not (HitS or HitE));
  end;
end;
{------------------------------------------------------------------------------}

procedure THighlightsSparse.Clear;
begin
  DelRanges(0, RangesCnt);
end;

{------------------------------------------------------------------------------}

function THighlightsSparse.FindRangeIdx(AOffset: Integer): Integer;
var
    S, E, M, OffE: Integer;
begin
  S := 0;
  E := RangesCnt;

  while S <> E do
  begin
    M := (S + E) div 2;

    with Ranges[M] do
      OffE := Start + Count;

    if OffE <= AOffset then
      S := M + 1
    else
      E := M;
  end;

  //Assert: OffE > AOffset
  if S <> 0 then
    Assert(Ranges[S-1].Start + Ranges[S-1].Count <= AOffset);

  if S <> RangesCnt then
    Assert(Ranges[S].Start + Ranges[S].Count > AOffset);

  Result := S;
end;

{------------------------------------------------------------------------------}

procedure THighlightsSparse.BeforeDelete(AStart, ACount: Integer);
var
    HitS, HitE: Boolean;
    i, offE, IdS, IdE: Integer;
begin
  if (ACount = 0) or (RangesCnt = 0) then
    Exit;

  IdS := FindRangeIdx(AStart);
  IdE := FindRangeIdx(AStart + ACount);

  HitS := (IdS < RangesCnt) and (Ranges[IdS].Start < AStart);
  HitE := (IdE < RangesCnt) and (Ranges[IdE].Start < AStart + ACount);

  if IdS <> IdE then
  begin
    if (not HitS) and (not HitE) then
      DelRanges(IdS, IdE - IdS)
    else if HitS and (not HitE) then
    begin
      DelRanges(IdS + 1, IdE - IdS - 1);
      Ranges[IdS].Count := AStart - Ranges[IdS].Start;

      Inc(IdS);
    end
    else if not HitS and HitE then
    begin
      OffE := Ranges[IdE].Start + Ranges[IdE].Count;
      Ranges[IdE].Start := AStart + ACount;
      Ranges[IdE].Count := OffE - Ranges[IdE].Start;

      DelRanges(IdS, IdE - IdS);
    end
    else if HitS and HitE then
    begin
      OffE := Ranges[IdE].Start + Ranges[IdE].Count;
      DelRanges(IdS+1, IdE - IdS);

      Ranges[IdS].Count := OffE - Ranges[IdS].Start;

      Inc(IdS);
    end
    else
      Assert(false);
  end
  else if IdS <> RangesCnt then
  begin
    OffE := Ranges[IdS].Start + Ranges[IdS].Count;
    if not HitS and HitE then
    begin
      Ranges[IdS].Start := AStart + ACount;
      Ranges[IdS].Count := OffE - Ranges[IdS].Start;
    end
    else if HitS and HitE then
    begin
      Dec(Ranges[IdS].Count, ACount);

      Inc(IdS);
    end
    else
      Assert(not (HitS or HitE));
  end;

  for i := IdS to RangesCnt-1 do
    Dec(Ranges[i].Start, ACount);
end;

{------------------------------------------------------------------------------}

procedure THighlightsSparse.AfterInsert(AStart, ACount: Integer);
var
    HitS: Boolean;
    i, IdS: Integer;
begin
  if (ACount = 0) or (RangesCnt = 0) then
    Exit;

  IdS := FindRangeIdx(AStart);

  HitS := (IdS < RangesCnt) and (Ranges[IdS].Start < AStart);

  if HitS then
  begin
    Inc(Ranges[IdS].Count, ACount);
    Inc(IdS);
  end;

  for i := IdS to RangesCnt-1 do
    Inc(Ranges[i].Start, ACount);
end;

{******************************* TCursorUndoInfo ******************************}
{------------------------------------------------------------------------------}

constructor TCursorUndoInfo.Create(AOffPt: TOffsetPoint; AWordTyping: Boolean);
begin
  inherited Create;

  OffPt := AOffPt;
  WordTyping := AWordTyping;
end;

{------------------------------------------------------------------------------}

function TCursorUndoInfo.Clone: TLMDDocUndoInfo;
begin
  Result := TCursorUndoInfo.Create(OffPt, WordTyping);
end;

{------------------------------------------------------------------------------}

function Cache(AView: TLMDCustomEditView): TScreenCache;
begin
  Result := TScreenCache(AView.FScreenCache);
  Result.DoDelayedUpdate;
end;

{------------------------------------------------------------------------------}

function CacheDelayed(AView: TLMDCustomEditView): TScreenCache;
begin
  Result := TScreenCache(AView.FScreenCache);
end;

{**************************** TLMDCustomEditView *******************************}

procedure TLMDCustomEditView.BeginChangeCommon;
begin
  CheckChangesLock;

  if not IsUpdating then
  begin
    SaveOldScreenParams;
    if FCaretShown then
      HideViewCaret(false);
  end;

  BeginUpdateLow;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_GetModify(var AMsg: TMessage);
begin
  if siDestroing in FState then
    Exit;

  if Assigned(Document) then
    AMsg.Result := Integer(Document.Modified)
  else
    AMsg.Result := 0;
end;

procedure TLMDCustomEditView.EM_SetModify(var AMsg: TMessage);
begin
  if siDestroing in FState then
    Exit;

  if Assigned(Document) then
    Document.Modified := AMsg.wParam <> 0;
end;

procedure TLMDCustomEditView.EM_CanUndo(var AMsg: TMessage);
begin
  if siDestroing in FState then
    Exit;

  AMsg.Result := Ord(CanUndo);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_CharFromPos(var AMsg: TMessage);
var
    P, SP: TPoint; XS, XCnt: Integer;
    Part: TLMDEditScreenPart;
begin
  if siDestroing in FState then
    Exit;

  if (AMsg.lParam = 0) or (not Assigned(Document)) then
    AMsg.Result := -1
  else
  begin
    P := PPoint(AMsg.lParam)^;

    SP := ClientToScreenPos(P, Part);

    case Part of
      spText: ;

      spGutterText,
      spGutterPastText:
      begin
        Cache(self).GetScreenLineXBounds(SP.Y, XS, XCnt);
        SP.X := XS;
      end;

      spPastText:
        SP.X := Cache(self).GetScrollLineVisWidth(SP.Y);
    else
      Assert(false);
    end;

    SP := ScreenPosToScrollLow(SP);
    AMsg.Result := ScrollPosToWinCharPos(SP);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_EmptyUndoBuffer(var AMsg: TMessage);
begin
  if siDestroing in FState then
    Exit;

  if Assigned(Document) then
  begin
    if Document.InsideCompoundEdit then
      Document.EndCompoundEdit;

    Document.ClearUndo;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_GetCharFormat(var AMsg: TMessage);

type PCharFormat = ^TCHARFORMAT;

var
    Format: PCHARFORMAT;
    LogFont: TLogFont;
    i: Integer;
    Name: string;
begin
  if siDestroing in FState then
    Exit;

  Format := PCHARFORMAT(AMsg.LParam);
  Format.dwMask := 0;

  if fsBold in Font.Style then
  begin
    Format.dwMask := Format.dwMask or CFM_BOLD;
    Format.dwEffects := Format.dwEffects or CFE_BOLD;
  end;

  if fsItalic in Font.Style then
  begin
    Format.dwMask := Format.dwMask or CFM_ITALIC;
    Format.dwEffects := Format.dwEffects or CFE_ITALIC;
  end;

  if fsUnderline in Font.Style then
  begin
    Format.dwMask := Format.dwMask or CFM_UNDERLINE;
    Format.dwEffects := Format.dwEffects or CFE_UNDERLINE;
  end;

  if fsStrikeOut in Font.Style then
  begin
    Format.dwMask := Format.dwMask or CFM_STRIKEOUT;
    Format.dwEffects := Format.dwEffects or CFE_STRIKEOUT;
  end;

  Format.dwMask := LongInt(Cardinal(Format.dwMask) or CFM_CHARSET);
  Format.dwMask := LongInt(Cardinal(Format.dwMask) or CFM_SIZE);
  Format.dwMask := LongInt(Cardinal(Format.dwMask) or CFM_FACE);

  GetObject(Font.Handle, SizeOf(LogFont), @LogFont);
  Format.bCharSet := LogFont.lfCharSet;
  Format.bPitchAndFamily := LogFont.lfPitchAndFamily;

  Name := Font.Name;
  for i := 0 to Length(Name) - 1 do
    Format.szFaceName[i] := Name[i+1];

  Format.szFaceName[Length(Name)] := #0;

  Format.yHeight := Font.Size * 20;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_GetFirstVisibleLine(var AMsg: TMessage);
begin
  if siDestroing in FState then
    Exit;

  AMsg.Result := TopLineScroll;
end;

{------------------------------------------------------------------------------}

procedure CopyArrToPtr(Arr: TLMDCharArray;
                       ACount: Integer;
                       Addr: LongInt);
var
    Ptr: PLMDChar;
    Ptr2: PLMDChar;
begin
  Ptr := PLMDChar(Addr);

  if ACount > 0 then
  begin
    Ptr2 := @Arr[0];
    Move(Ptr2^, Ptr^, ACount * Sizeof(TLMDChar));
  end
  else
    Ptr^ := #0;
end;

procedure TLMDCustomEditView.EM_GetLine(var AMsg: TMessage);
var
  LnSeg, Seg: TLMDSegment;
  Ln: DWORD;

  Arr: TLMDCharArray;
  Ph, i, t, L, Col, Cnt: Integer;
  Ch: TLMDChar;
  Ok: Boolean;

  TokLine: TLMDEditParsedLine;
  TokBase: Integer;
  TokCnt: Integer;
  Tok: Integer;
begin
  if siDestroing in FState then
    Exit;

  AMsg.Result := 0;

  if Assigned(Document) and (AMsg.wParam <> WPARAM(-1)) and
    (not Cache(self).AfterLastScroll(AMsg.wParam))
  then
  begin
    L := Max(0, AMsg.wParam);
    Cache(Self).CorrectToLastScroll(L);

    Ph := Cache(Self).ScrollToPhysical(L);

    LnSeg := MyDoc.LineSegments[Ph];

    Seg := GetScrollLineSeg_Addict(L);

    Col := Seg.Start - LnSeg.Start;
    Assert(Col >= 0);

    TokBase := 0;
    TokCnt := 0;
    Tok := 0;

    if Ph < MyDoc.LinesCount then
    begin
      TokLine := Parser.GetParsedLine(Ph);
      if (TokLine.TokenCount > 0) and (Col < LnSeg.Count) then
      begin
        TokBase := TokLine.GetTokenIdx(Col);

        TokCnt := TokLine.GetTokens(TokBase,
                                    Length(FTokensBuffer),
                                    FTokensBuffer);
      end;
    end
    else
      TokLine := nil;

    SetLength(Arr, 0);

    for i := 0 to Seg.Count - 1 do
    begin
      if (TokCnt > 0) and
         (i > (LMDSegEnd(FTokensBuffer[Tok].Seg) - Seg.Start))
      then
      begin
        Inc(Tok);

        if Tok = TokCnt then
        begin
          TokBase := TokBase + TokLine.GetTokens(TokBase + TokCnt, Length(FTokensBuffer), FTokensBuffer);
          Tok := 0;
        end;
      end;

      Ok := (AddictCheckTokenCount = 0) or
            (TokCnt = 0) or
            HasAddictCheckToken(FTokensBuffer[Tok].TokenID);

      if Ok then
        Ch := Seg.Source[Seg.Start + i]
      else
        Ch := LMDSpace;

      if Length(Arr) = 0 then
      begin
        if Ch <> LMDSpace then
        begin
          SetLength(Arr, Seg.Count);

          for t := 0 to i-1 do
            Arr[t] := LMDSpace;

          Arr[i] := Ch;
        end;
      end
      else
        Arr[i] := Ch;
    end;

    Ln := PWORD(AMsg.LParam)^;

    Cnt := Min(Length(Arr), Ln);

    CopyArrToPtr(Arr, Cnt, AMsg.LParam);

    AMsg.Result := Cnt;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_GetLineCount(var AMsg: TMessage);
begin
  if siDestroing in FState then
    Exit;

  if siPainting in FState then
    AMsg.Result := TopLineScroll + LinesOnScreenScroll
  else
    AMsg.Result := GetVisibleCountScroll;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_GetSel(var AMsg: TMessage);
var
    S, E, T: Integer;
begin
  if siDestroing in FState then
    Exit;

  if SelAvail and Assigned(Document) then
  begin
    S := OffsetToWinCharPos(SelectionOffsetStart);
    E := OffsetToWinCharPos(SelectionOffsetEnd);
    if S > E then
    begin
      T := S;
      S := E;
      E := T;
    end;
  end
  else
  begin
    S := OffsetToWinCharPos(CursorOffset);
    E := OffsetToWinCharPos(CursorOffset);
  end;

  if AMsg.wParam<>0 then
    PLongint(AMsg.wParam)^ := S;

  if AMsg.lParam<>0 then
    PLongint(AMsg.lParam)^ := E;

  if S > High(Short) then
    S := -1;

  if E > High(Short) then
    E := -1;

  AMsg.Result := (E shl 16) or S;
end;

procedure TLMDCustomEditView.EM_GetSelText(var AMsg: TMessage);
var
    S, E: Integer;
    Arr: TLMDCharArray;
    Seg: TLMDSegment;
begin
  if siDestroing in FState then
    Exit;

  if AMsg.lParam <> 0 then
  begin
    S := Min(SelectionOffsetStart, SelectionOffsetEnd);
    E := Max(SelectionOffsetStart, SelectionOffsetEnd);

    Seg := LMDSegment(S, E - S, MyDoc.Chars);
    SetLength(Arr, Seg.Count);
    LMDSegCopyToArray(Seg, Arr, 0);

    CopyArrToPtr(Arr, Seg.Count, AMsg.lParam);

    AMsg.Result := E - S;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_LineFromChar(var AMsg: TMessage);
var Off: Integer;
begin
  if siDestroing in FState then
    Exit;

  if Assigned(Document) then
  begin
    Off := WinCharPosToOffset(AMsg.wParam);
    AMsg.Result := OffsetToScrollPos(Off).Y;
  end
  else
    AMsg.Result := -1;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_LineFromCharEx(var AMsg: TMessage);
var
    Off: Integer;
begin
  if siDestroing in FState then
    Exit;

  if Assigned(Document) then
  begin
    Off := WinCharPosToOffset(AMsg.lParam);
    AMsg.Result := OffsetToScrollPos(Off).Y;
  end
  else
    AMsg.Result := -1;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_LineIndex(var AMsg: TMessage);
var
    L: Integer;
    WinOff: Integer;
    Seg: TLMDSegment;
begin
  if siDestroing in FState then
    Exit;

  L := AMsg.wParam;
  if L = -1 then
    L := CursorPosY;

  if not Cache(self).AfterLastScroll(L) then
  begin
    Seg := GetScrollLineSeg_Addict(L);

    WinOff := OffsetToWinCharPos(Seg.Start);
    AMsg.Result := WinOff;
  end
  else
    AMsg.Result := -1;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_LineLength(var AMsg: TMessage);
var
    Ch, OS, OE: Integer;
    SegS, SegE: TLMDSegment;
    LS, LE: Integer;
    PS, PE: TPoint;
    Seg: TLMDSegment;
begin
  if siDestroing in FState then
    Exit;

  Ch := AMsg.WParam;

  if Ch = -1 then
  begin
    if SelAvail then
    begin
      PS := SelStartN;
      PE := SelEndN;

      OS := ScrollPosToNearestOffset(PS);
      OE := ScrollPosToNearestOffset(PE);

      SegS := GetScrollLineSeg_Addict(PS.Y);
      SegE := GetScrollLineSeg_Addict(PE.Y);

      LS := LMDMinMax(OS - SegS.Start,              0, SegS.Count);
      LE := LMDMinMax(SegE.Start + SegE.Count - OE, 0, SegE.Count);

      
      AMsg.Result := LS + LE;
    end
    else
      AMsg.Result := 0;
  end
  else
  begin
    Ch := WinCharPosToOffset(Ch);

    if Ch >= MyDoc.CharsCount then
      AMsg.Result := 0
    else
    begin
      PS := OffsetToScrollPos(Ch);
      Seg := GetScrollLineSeg_Addict(PS.Y);
      AMsg.Result := Seg.Count;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_LineScroll(var AMsg: TMessage);
begin
  if siDestroing in FState then
    Exit;

  AMsg.Result := 1;
  if AMsg.lParam <> 0 then
    ScrollVertWithCode(AMsg.lParam, scPosition, false);

  if AMsg.wParam <> 0 then
    HorizScroll := Max(0, HorizScroll + Integer(AMsg.wParam));
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_ExGetSel(var AMsg: TMessage);
var
    Rng: PCharRange; S, E: Integer;
begin
  if siDestroing in FState then
    Exit;

  Rng := PCharRange(AMsg.lParam);
  S := OffsetToWinCharPos(SelectionOffsetStart);
  E := OffsetToWinCharPos(SelectionOffsetEnd);

  Rng.cpMin := Min(S, E);
  Rng.cpMax := Max(S, E);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_FormatRange(var AMsg: TMessage);

type
  PFormatRange = ^TFormatRange;

var
  Range: PFormatRange;
  EndC: Integer;
  EndSc: Integer;
  Cnv: TCanvas;

  OffsetX     :Integer;
  OffsetY     :Integer;
  Rect: TRect;
  Seg: TLMDSegment;
begin
  if (siDestroing in FState) or (LinesOnScreenScroll=0) then
    Exit;

  Range := PFormatRange(AMsg.LParam);
  if Range=nil then
    Exit;

  Assert(AMsg.WParam<>0);//Very limited support of EM_FormatRange for Addict only

  EndC := Range.chrg.cpMax;
  Seg := GetScrollLineSeg_Addict(LinesOnScreenScroll-1);
  EndSc := LMDSegEnd(Seg);

  if EndC=-1 then
    EndC := EndSc
  else
    EndC := Min(EndSc, EndC);

  AMsg.Result := EndC;

  OffsetX := 1440 div GetDeviceCaps( Range.hdcTarget, LOGPIXELSX );
  OffsetY := 1440 div GetDeviceCaps( Range.hdcTarget, LOGPIXELSY );

  Rect.Left := Range.rcPage.Left div OffsetX;
  Rect.Right := Range.rcPage.Right div OffsetX;
  Rect.Top := Range.rcPage.Top div OffsetY;
  Rect.Bottom := Range.rcPage.Bottom div OffsetY;

  Cnv := TCanvas.Create;
  try
    Cnv.Handle := Range.hdcTarget;

    PaintTo(Cnv, Rect);
  finally
    Cnv.Free;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_PosFromChar(var AMsg: TMessage);
var
  Pt   : TPoint;
  Dummy: Boolean;
  Off: Integer;
  State: TWrapParserState;
begin
  if siDestroing in FState then
    Exit;

  if Assigned(Document) then
  begin
    try
      Off := WinCharPosToOffset(AMsg.lParam);
      State := Cache(self).WP_GetStateOverFolds(Off);
      if State.Offset <> Off then
      begin
        Dec(State.Y);
        State.X := MAXINT;
      end;

      Pt := Point(State.X, State.Y);
      Pt := ScrollPosToClient(Pt, Dummy).TopLeft;
    except
      on E: Exception do
        raise;
    end;
  end
  else
    Pt := Point(0, 0);

  if AMsg.wParam <> 0 then
    PPoint(AMsg.wParam)^ := Pt;

  AMsg.Result := (Pt.Y shl 16) or Pt.X;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_ReplaceSel(var AMsg: TMessage);
var
    Txt: TLMDString;
begin
  if siDestroing in FState then
    Exit;

  if IsReadOnly or (not Assigned(Document)) then
    Exit;

  Txt := PLMDChar(AMsg.LParam);

  SetSelectedText(Txt);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_SetReadOnly(var AMsg: TMessage);
begin
  if siDestroing in FState then
    Exit;

  AMsg.Result := 0;
  SetReadOnly(AMsg.wParam <> 0);
  AMsg.Result := 1;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_SetSel(var AMsg: TMessage);
begin
  if siDestroing in FState then
    Exit;

  if not Assigned(Document) then
    Exit;

  if AMsg.wParam = WPARAM(-1) then
    CancelSelection
  else if (AMsg.wParam = 0) and (AMsg.lParam = -1) then
    SelectAll
  else
    SetSelection(WinCharPosToOffset(AMsg.wParam),
                 WinCharPosToOffset(AMsg.lParam),
                 false);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EM_Undo(var AMsg: TMessage);
begin
  if siDestroing in FState then
    Exit;

  AMsg.Result := Ord(CanUndo);

  if CanUndo then
    Undo;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EndChangeCommon(AFullRepaint, ABlockEvent: Boolean);
var
    L, Top, MaxScr: Integer;
begin
  FFullRepaint := FFullRepaint or AFullRepaint;

  EndUpdateLow;

  if not IsUpdating then
  begin
    RecalkScreenVars;
    CacheDelayed(self).DoDelayedUpdate;

    MaxScr := 5;
    Cache(self).CorrectToLastScroll(MaxScr);
    if Cache(self).LinesOnScreenScroll < MaxScr then
    begin
      Top := TopLineScroll + ScreenHeightFullVis - 1;
      Cache(self).CorrectToLastScroll(Top);
      Top := Max(0, Top - ScreenHeightFullVis + 1);
      if TopLineScroll <> Top then
        Cache(self).SetFirstLineAsScroll(Top);
    end;

    FStatusChanges := FStatusChanges + Cache(self).StatusChanges;

    if FScreenMarksChanged then
    begin
      Cache(self).CheckScreenAndRefresh;

      for L := 0 to LinesOnScreenScroll - 1 do
        if ([lpBookmark, lpBreakpointActive, lpBreakpointInactive,
             lpBreakpointDisabled,
             lpFrame, lpFrameTop, lpFrameActive] *
            Cache(self).GetScreenLineProps(L)) <> []
        then
          Cache(self).SetDirty(L);
    end;

    FFullRepaint := FFullRepaint or (scScreenSize in FStatusChanges);

    InvalidateScreen(FFullRepaint);

    UpdateViewCaret;

    FFullRepaint := False;

    if not ABlockEvent then
      FireOnStatusChanged;
  end;

  if (not IsUpdating) and HandleAllocated then
    UpdateScrollbars;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.BeginDocEdit;
begin
  BeginChangeCommon;

  RemoveInternalStateForPublics(siComplIncSearch);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EndDocEdit;//UD+D+UV+LK+
begin
  EndChangeCommon(False, true);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.BeforeInsert(AStart, ACount: Integer);
begin
  FCachedWin.InvalidateFromKey1(AStart);

  BeginDocEdit;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.AfterInsert(AStart, ACount: Integer);
begin
  CacheDelayed(Self).AfterInsert(AStart, ACount);
  FLastOffsetForUndo := AStart + ACount;
  EndDocEdit;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.BeforeDelete(AStart, ACount: Integer);

begin
  FCachedWin.InvalidateFromKey1(AStart);

  BeginDocEdit;

  CacheDelayed(Self).BeforeDelete(AStart, ACount);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.AfterDelete(AStart, ACount: Integer);
begin
  FLastOffsetForUndo := AStart;
  EndDocEdit;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DocumentDestroing;//UD-
begin
  SetDocumentLow(nil, false);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.BeforeCompoundEdit(AFreezeViews: Boolean);
begin
  if AFreezeViews then
    BeginDocEdit;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.AfterCompoundEdit(AFreezeViews: Boolean);
begin
  if AFreezeViews then
    EndDocEdit;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.BeforeMarkChange;
begin
  BeginDocEdit;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.AfterMarkChange;
begin
  FScreenMarksChanged := true;
  EndDocEdit;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MarkSettingsChanged(AMarkers: ILMDMarkers;
                                                 const AMark: ILMDMark);
begin
  FScreenMarksChanged := true;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DetachFromDocument(AStoreDoc: Boolean);
begin
  RemoveInternalState(siComplIncSearch);

  ResetScreenMarksChanged;

  Cache(Self).DetachFromDocument(AStoreDoc);

  FDocInternal.RemoveListener(FDocLst);

  FreeSearchState;

  FAuthorID := -1;
  ClearAddictCheckTokenIds;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.AttachToDocument;
begin
  CacheDelayed(self).AttachToDocument;

  FDocInternal := TDocAccess(MyDoc).GetInternal;

  FDocInternal.AddListener(FDocLst);
  FAuthorID := FDocInternal.GetNextAuthorID;

  FCachedWin.InvalidateFromKey1(0);

  UpdateAddictCheckTokenIds;
end;

function TLMDCustomEditView.AuthorID: Integer;
begin
  if MyDoc.InsideCompoundEdit then
    Result := -1
  else
    Result := FAuthorID;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.AddInternalState(AState: TLMDEditInternalState);
begin
  if AState in FState then
    Exit;

  Include(FState, AState);

  if AState = siIncrementalSearch then
    IncrementalSearchInit;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.RemoveInternalState(AState: TLMDEditInternalState);
begin
  if not (AState in FState) then
    Exit;

  case AState of
    siComplWordTyping: ;

    siComplListShown:
    begin
      if siComplListShown in FState then
        HideCompletionList;
    end;

    siComplTimer:
      StopCompletionTimer;

    siIncrementalSearch:
      IncrementalSearchCancel;
  end;


  Exclude(FState, AState);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.RemoveInternalState(AState: TLMDEditInternalStates);
var
    s: TLMDEditInternalState;
begin
  for s := Low(s) to High(s) do
    if s in AState then
      RemoveInternalState(s);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.RemoveInternalStateForPublics(AState: TLMDEditInternalStates);
begin
  if FCmdModesLock = 0 then
    RemoveInternalState(AState);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.AddictCheckTokenCount: Integer;
begin
  Result := Length(FAddictCheckTokenIds);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.LockForViewEvent;
begin
  LockChangeLock;
  FDocInternal.LockMarkers;
  FDocInternal.LockChanges;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UnlockForViewEvent;
begin
  FDocInternal.UnlockMarkers;
  FDocInternal.UnlockChanges;
  UnlockChangeLock;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.IncrementalSearchInit;
begin
  AddStatusChange(scViewSettings);

  RemoveInternalState(siComplAll);
  CancelSelection;

  FreeSearchState;
  FSearchState := stInSearch;
  FSearchArgs.Search := '';
  FSearchArgs.Replace := '';
  FSearchArgs.Direction := sdForward;
  FSearchArgs.Start := ssCursor;
  FSearchArgs.Options := [];
  FSearchIncJumps.Clear;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.IncrementalSearchAddChar(Ch: TLMDChar);
var
    OldS: TLMDString;
    OldCr: Integer;
begin
  OldS := FSearchArgs.Search;
  OldCr := CursorOffset;

  FSearchArgs.Search := FSearchArgs.Search + Ch;

  if not SearchFirst(FSearchArgs) then
  begin
    FSearchArgs.Search := OldS;
    Beep;
  end
  else
    FSearchIncJumps.Add(TIncSearchJump.Create(OldCr, OldS));
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.IncrementalSearchBackward;
var
    OldS: TLMDString;
    Jmp: TIncSearchJump;
begin
  BeginUpdate;
  try
    OldS := FSearchArgs.Search;
                              // a aaa aaa aaa aaa aaa aaab aaabcdef
    if Length(OldS) <> 0 then
    begin
      FSearchArgs.Search := Copy(OldS, 1, Length(OldS)-1);

      if FSearchIncJumps.Count > 0 then
      begin
        Jmp := TIncSearchJump( FSearchIncJumps.Last );

        CursorOffset := Min(MyDoc.CharsCount,
                            Jmp.Start + Length(FSearchArgs.Search));

        FSearchArgs.Direction := sdBackward;
        try
          CancelSelection;
          SearchFirst(FSearchArgs);
        finally
          FreeSearchState;
          FSearchArgs.Direction := sdForward;

          FSearchIncJumps.Delete(FSearchIncJumps.Count - 1);
        end;

        ScrollToCursor;
      end
      else
        Beep;
    end
    else
      RemoveInternalState(siIncrementalSearch);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.IncrementalSearchForward: Boolean;
begin
  Result := Length(FSearchArgs.Search) > 0;

  if Result then
  begin
    if SelAvail then
      CursorPos := SelEndN;

    Result := SearchNextLow(false);
  end
  else
    Beep;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.IncrementalSearchCancel;
begin
  BeginUpdate;
  try
    AddStatusChange(scViewSettings);

    FSearchIncJumps.Clear;

    CursorPos := SelectionEndNorm;
    CancelSelection;
    ScrollToCursor;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetInIncrementalSearch: Boolean;
begin
  Result := siIncrementalSearch in FState;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CompletionTimerHandler(Sender: TObject);
begin
  RemoveInternalState([siComplTimer]);

  if not (siDestroing in FState) then
    CheckShowCompletionList(true, fcTimeout, false);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.StopCompletionTimer;
begin
  FCompletionTimer.Enabled := false;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.StartCompletionTimer;
begin
  FCompletionTimer.Enabled := true;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CheckShowCompletionList(AllowInsideWord: Boolean;
                                                     ACause: TLMDEditFillCompletionCause;
                                                     AllowNoCombo: Boolean);
var
    Cnt: Integer;
    P: TPoint;
    R: TRect;
    OutOf: Boolean;
    TopLeft: TPoint;
    CrBottom, CrRight: Boolean;
    Corner: TComplResizeCorner;
    ComboPos: TPoint;
begin
  if HandleAllocated and (FCompletionType <> ctDisabled) then
  begin
    RemoveInternalState(siComplTimer);

    Cnt := FillCompletionList(FCompletionList.Items, CursorPos,
                              ACause, ComboPos);

    if Cnt > 0 then
    begin
      if ((Cnt = 1) and FCompletionNoComboForOnly and AllowNoCombo) or
         (ACause = fcWordEnd)
      then
      begin
        FCompletionList.ItemIndex := 0;
        if ACause = fcWordEnd then
          CommitCompletion(CursorPos, rcWordEnd)
        else
          CommitCompletion(CursorPos, rcCompletionList);
      end
      else
      begin
        P := ComboPos;
        ScrollToPos(P);

        R := ScrollPosToClient(P, OutOf);
        Assert(not OutOf);

        AddInternalState(siComplListShown);
        if not TComplList(FCompletionList).IsVisible then
        begin
          TopLeft := LMDBadPoint;

          CrBottom := (Screen.Height - ClientToScreen(R.BottomRight).
                       Y) >= FCompletionList.Height;

          if CrBottom then
            TopLeft.Y := R.Bottom
          else
            TopLeft.Y := R.Top - FCompletionList.Height;

          CrRight := (Screen.Width - ClientToScreen(R.BottomRight).
                      X) >= FCompletionList.Width;

          if CrRight then
            TopLeft.X := R.Left
          else
          begin
            P := OffsetToScrollPos(CursorOffset);
            ScrollToPos(P);

            R := ScrollPosToClient(P, OutOf);
            Assert(not OutOf);

            TopLeft.X := R.Left - FCompletionList.Width;
          end;

          Corner := rcBottomRight;
          if CrRight and CrBottom then
            Corner := rcBottomRight
          else if CrRight and (not CrBottom) then
            Corner := rcTopRight
          else if (not CrRight) and (not CrBottom) then
            Corner := rcTopLeft
          else if (not CrRight) and CrBottom then
            Corner := rcBottomLeft
          else
            Assert(false);

          TComplList(FCompletionList).Corner := Corner;

          TopLeft := ClientToScreen(TopLeft);

          TComplList(FCompletionList).Show(true, TopLeft.X, TopLeft.Y);
        end;
        FCompletionList.ItemIndex := 0;
      end;
    end
    else
      RemoveInternalState(siComplListShown);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CommitCompletion(AScrollPoint: TPoint;
                                              ACause: TLMDEditReplaceCompletionCause);
var
    Seg: TLMDSegment;
    Repl: TLMDString;
    OffPt: TOffsetPoint;
    Handled: Boolean;
begin
  Assert(FCompletionList.Count > 0);
  Assert(FCompletionList.ItemIndex >= 0);

  Handled := false;

  if Assigned(FComplCommit) then
    FComplCommit(self, FCompletionList.Items, FCompletionList.ItemIndex,
                 AScrollPoint, ACause, Handled);

  if not Handled then
  begin
    Repl := FCompletionList.Items[FCompletionList.ItemIndex];

    OffPt := Cache(self).ScrollPtToOffsetPt(AScrollPoint);
    Seg := MyDoc.FindNearWord(OffPt.Offset, -1, true, GetComplSeparators);

    if (OffPt.Offset >= Seg.Start) and
       ((OffPt.Offset <= LMDSegEnd(Seg)+1))
    then
      MyDoc.Replace(Seg.Start, Seg.Count, Repl);

    ScrollToPos(AScrollPoint);
  end;

  RemoveInternalState(siComplAll);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CompletionOnClick(Sender: TObject);
begin
  CommitCompletion(CursorPos, rcCompletionList);
  SetFocus;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetComplSettings(ASettings: TLMDEditCompletionSettings);
begin
  if ASettings = FComplSettings then
    Exit;

  BeginSettingsChange;
  try
    FComplSettings.Assign(ASettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetHighlightSettings(ASettings: TLMDEditHighlightSettings);
begin
  if ASettings = FHighlightSettings then
    Exit;

  BeginSettingsChange;
  try
    FHighlightSettings.Assign(ASettings);
  finally
    EndSettingsChange(false, true);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetComplSeparators: TLMDString;
begin
  if FComplWordSep = '' then
    Result := MyDoc.GetFullWordSeparators + '{}()[],./?''":;\|*&%^$#@!' + LMDSpace + LMDTab
  else
    Result := FComplWordSep + LMDSpace + LMDTab + LMDCRLF;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CompletionDrawHandler(Control: TWinControl;
                                                   Index: Integer;
                                                   Rect: TRect;
                                                   State: TOwnerDrawState);
var
    Lst: TComplList;
begin
  Lst := Control as TComplList;

  if Assigned(FComplOnDraw) then
    FComplOnDraw(self, Lst.Items, Index, Rect, State, Lst.Canvas);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CompletionMeasureHandler(Control: TWinControl; Index: Integer;
                                                      var Height: Integer);
var
    Lst: TComplList;
begin
  Lst := Control as TComplList;

  if Assigned(FComplOnDraw) then
    FComplOnMeasure(self, Lst.Items, Index, Lst.Canvas, Height);
end;


{------------------------------------------------------------------------------}

function  TLMDCustomEditView.CompletionFillListDef(AItems: TStrings;
                                                   ACursorPoint: TPoint;
                                                   ACause: TLMDEditFillCompletionCause;
                                                   var APosForCombo: TPoint): Integer;
var
    Str: string;
    MinCh: Integer;
    OffPt: TOffsetPoint;
    Seg: TLMDSegment;
    LeftPart: TLMDString;

    Re: TLMDRegExp;
    ReSrc: TLMDRegexCharSeqSource;
begin
  Result := 0;

  if ACause in [fcForced, fcWordEnd] then
    MinCh := 1
  else
    MinCh := FCompletionMinChars;

  OffPt := Cache(self).ScrollPtToOffsetPt(ACursorPoint);

  Seg := MyDoc.FindNearWord(OffPt.Offset, -1, true, GetComplSeparators);
  Seg.Count := OffPt.Offset - Seg.Start;

  if (OffPt.InCharOffset = 0) and
     (Seg.Count > 0) and
     ((OffPt.Offset - Seg.Start) >= MinCh) and
     (OffPt.Offset <= LMDSegEnd(Seg)+1)  and
     ((OffPt.Offset = LMDSegEnd(Seg)+1) or (ACause <> fcTimeout))
  then
  begin
    APosForCombo := OffsetToScrollPos(Seg.Start);

    AItems.BeginUpdate;
    try
      FComplStrHash.Clear;

      LeftPart := LMDQuoteRegExprMetaChars(LMDSegToString(Seg));

      Re := TLMDRegExp.Create;
      ReSrc := TLMDRegexCharSeqSource.Create(MyDoc.Chars);

      try
        Re.InputSource := ReSrc;
        Re.WordSeparators := GetComplSeparators;
        Re.Expression := '\b'+ LeftPart +'[^ \s \n \r \t ]*?\b';
        Re.ModifierI := not FCompletionCaseSens;

        if Re.Exec then
        begin
          repeat
            Seg := LMDSegment(Re.MatchPos[0], Re.MatchLen[0], MyDoc.Chars);

            if not LMDInRange(OffPt.Offset,
                              Seg.Start, LMDSegEnd(Seg)+1)
            then
            begin
              Str := LMDSegToString(Seg);
              if FCompletionCaseSens then
                Str := LMDLowerCase(Str);

              if not FComplStrHash.HasKey(Str) then
              begin
                AItems.Add( LMDSegToString(Seg) );
                FComplStrHash.Add(Str, '');

                Inc(Result);
              end;
            end;

          until not Re.ExecNext;
        end;
      finally
        Re.Free;
        ReSrc.Free;
      end;
    finally
      AItems.EndUpdate;
    end;
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.FillCompletionList(AItems: TStrings;
                                                AScrollPoint: TPoint;
                                                ACause: TLMDEditFillCompletionCause;
                                                var AComboPos: TPoint): Integer;
var
    LeftPart: TLMDString;
    Seg: TLMDSegment;
    Off: TOffsetPoint;
    Handled: Boolean;
begin
  Result := 0;
  AItems.BeginUpdate;
  try
    AItems.Clear;

    case FCompletionType of
      ctDocumentText:
        case ACause of
          fcForced,
          fcTimeout: Result := CompletionFillListDef(AItems, AScrollPoint, ACause,
                                                     AComboPos);
          fcWordEnd: ;
        else
          Assert(false);
        end;

      ctCustom,
      ctCustomOwnerDrawFixed,
      ctCustomOwnerDrawVariable:
      begin
        if Assigned(FComplOnFill) then
        begin
          Off := Cache(self).ScrollPtToOffsetPt(AScrollPoint);

          Seg := MyDoc.FindNearWord(Off.Offset, -1, true, GetComplSeparators);

          if LMDInRange(Off.Offset, Seg.Start, LMDSegEnd(Seg)+1) then
          begin
            Seg.Count := Off.Offset - Seg.Start;
            LeftPart := LMDSegToString(Seg);
          end
          else
            LeftPart := '';

          if LMDSegIsBad(Seg) then
            AComboPos := AScrollPoint
          else
            AComboPos := OffsetToScrollPos(Seg.Start);

          Handled := false;

          FComplOnFill(self, AItems, AScrollPoint, ACause,
                       LeftPart, AComboPos, Handled);

          if not Handled then
            CompletionFillListDef(AItems, AScrollPoint, ACause, AComboPos);

          Result := AItems.Count;
        end;
      end;

      ctDisabled: ;
    end;
  finally
    AItems.EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.HideCompletionList;
begin
  TComplList(FCompletionList).Show(false, 0, 0);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.Parser: TLMDEditParserBase;
begin
  Result := MyDoc.GetParser;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.MyDoc: TLMDEditDocument;
begin
  if FFDoc<>nil then
    Result := FFDoc
  else
    Result := FDummyDoc;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CheckRequiredState(AMode: TLMDEditInternalState;
                                                RequireHave: Boolean);
var
    Err: Boolean;
begin
  Err := ((not (AMode in FState)) and RequireHave) or
         ((AMode in FState) and (not RequireHave));

  if Err then
  begin
    case AMode of
      siComplListShown:
      begin
        if RequireHave then
          raise ELMDEditViewError.Create(SLMDSedViewComplListShownRequired)
        else
          raise ELMDEditViewError.Create(SLMDSedViewNoComplListShownRequired)
      end;

      siIncrementalSearch:
      begin
        if RequireHave then
          raise ELMDEditViewError.Create(SLMDSedViewIncrementalSearchModeRequired)
        else
          raise ELMDEditViewError.Create(SLMDSedViewNoIncrementalSearchModeRequired)
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CheckChangesLock;

  procedure RaiseChangeLock;
  begin
    raise ELMDEditViewError.Create(SLMDSedViewChangesLocked);
  end;

begin
  if FChangesLock<>0 then
    RaiseChangeLock;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CheckGutterBarVisible(ABar: TLMDGutterBar);

  procedure RaiseGutterBarVisible;
  begin
    raise ELMDEditViewError.Create(SLMDSedViewGutterBarInvalid);
  end;

begin
  if (ABar.FGutter<>FGutter) or (not ABar.Visible) then
    RaiseGutterBarVisible;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.LockChangeLock;
begin
  Inc(FChangesLock);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UnlockChangeLock;
begin
  Assert(FChangesLock>0);
  Dec(FChangesLock);
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.IsDocumentSet: Boolean;
begin
  Result := Document<>nil;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.IsReadOnly: Boolean;
begin
  Result := ReadOnly or ((MyDoc <> FDummyDoc) and MyDoc.ReadOnly);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CheckDocumentIsSet;

  procedure RaiseErr;
  begin
    raise ELMDEditViewError.Create(SLMDSedViewDocNotSet);
  end;

begin
  if not IsDocumentSet then
    RaiseErr;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CheckInSearchMode;
begin
  if FSearchState<>stInSearch then
    raise ELMDEditViewError.Create(SLMDSedViewNotInSearchMode);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CheckInReplaceMode;
begin
  if FSearchState<>stInReplace then
    raise ELMDEditViewError.Create(SLMDSedViewNotInReplaceMode);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CheckNotReadOnly;
begin
  if IsReadOnly then
    raise ELMDEditViewError.Create(SLMDSedViewIsReadOnly);
end;

procedure TLMDCustomEditView.CheckStartScrollTimer(X, Y: Integer;
                                                   AStartAtEdge: Boolean);
var
    R: TRect;
    Edge: Integer;
begin
  FScrollDirY := 0;
  FScrollDirX := 0;

  if AStartAtEdge then
    Edge := 3
  else
    Edge := 0;

  R := GetDrawRect;

  if not LMDInRange(Y, R.Top+Edge, R.Bottom-Edge) then
  begin
    if Y < R.Top+Edge then
      FScrollDirY := -1
    else
      FScrollDirY := 1
  end;

  if not LMDInRange(X, R.Left + FGutter.GetWidth + Edge, R.Right-Edge) then
  begin
    if X < R.Left + FGutterWidth + Edge then
      FScrollDirX := -1
    else
      FScrollDirX := 1;
  end;

  FScrollTimer.Interval := FScrollTimerBase;
  FScrollTimer.Enabled := Focused and ((FScrollDirX<>0) or (FScrollDirY<>0));
end;

{------------------------------------------------------------------------------}

constructor TLMDCustomEditView.Create(AOwner: TComponent);
const
  EditStyle = [csClickEvents,
               csDoubleClicks
               (*D6 don't support themes*)
               {$IFDEF LMDCOMP7}, csNeedsBorderPaint {$ENDIF}];
var
    Dct: Cardinal;

begin
  inherited Create(AOwner);

  ///
  FLineNumScreenCursor := LoadCursor(HInstance, 'LINENUM_CURSOR');

  FReadOnly := false;
  FCompletionTimeout  := COMPLETION_TIMEOUT;
  FCompletionMinChars := COMPLETION_MINCHARS;

  FComplStrHash := TLMDStringHashTable.Create;

  FCompletionTimer := TTimer.Create(nil);
  FCompletionTimer.Enabled := false;
  FCompletionTimer.Interval := FCompletionTimeout;
  FCompletionTimer.OnTimer := CompletionTimerHandler;

  FCompletionList := TComplList.Create(nil);
  TComplList(FCompletionList).ItemHeight := COMPLETION_ITEM_HEIGHT;

  TComplList(FCompletionList).Visible := False;
  TComplList(FCompletionList).Parent := Self;

  TComplList(FCompletionList).OnClick := CompletionOnClick;
  TComplList(FCompletionList).OnDrawItem := CompletionDrawHandler;
  TComplList(FCompletionList).OnMeasureItem := CompletionMeasureHandler;

  FCompletionList.Constraints.MinHeight := FCompletionList.Height;
  FCompletionList.Constraints.MinWidth := FCompletionList.Width;
  FCompletionList.Constraints.MaxHeight := 0;
  FCompletionList.Constraints.MaxWidth := 0;

  FCompletionType := ctDocumentText;
  FCompletionCaseSens := COMPLETION_CASESENS;
  FCompletionMinWidth := FCompletionList.Width;
  FCompletionNoComboForOnly := COMPLETION_NOCOMBO_ONLY;

  FComplSettings := TLMDEditCompletionSettings.Create(self);

  FComplWordSep := '';

  FCmdModesLock := 0;

  FComplUseTimeout := COMPLETION_TIMEOUT_USE;
  ///

  if NewStyleControls then
    ControlStyle := EditStyle
  else
    ControlStyle := EditStyle + [csFramed];

  FLineBmp := TBitmap.Create;

  SetLength(FTokensBuffer, 40);

  FScreenMarksChanged := false;

  FPartParent := TViewPartParent.Create(self);

  if not LMDDisableOleinit then
    FDoCoUninit := OleInitialize(nil) = S_OK;

  FCursorMaxHoriz := 0;
  FMaxHorizScroll := MAX_HORIZ_SCROLL;

  FOldPen := TPen.Create;
  FOldBrush := TBrush.Create;

  FCachedWin := TLMDSedIntConversionCache.Create(50);

  FScrollBarVisibleY := false;
  FScrollBarVisibleX := false;

  Width := 185;
  Height := 89;
  TabStop := True;

  FFDoc := nil;
  FDocInternal := nil;

  FCaretShown := False;
  FFullRepaint := True;

  FLineHeight := -1;

  FUpdatingCnt := 0;
  FChangesLock := 0;

  ///Default view settings
  FViewSettings := [vsHideShowScrollbars,
                    vsAutoIndent,
                    vsHighlightSelectedLine,
                    vsRightClickMovesCursor,
                    vsDragDropEditing];

  FReadOnlyBgColor := clSilver;
  FWrapRulerColor := clGray;

  FSelectedLineBg := RGB(250, 255, 230);//250 - 255 - 230
  FBreakpointLineColor := clBlack;
  FBreakpointLineBg := RGB(199, 199, 255);
  FSelectionColor := clWhite;
  FSelectionBg := RGB(83, 109, 165);

  FDebugFrameTopLineBg := RGB(204, 153, 153);//255 238 98 - yellow
  FDebugFrameTopLineColor := clBlack;

  FDebugFrameActiveLineBg := RGB(204, 153, 153);
  FDebugFrameActiveLineColor := clBlack;

  FDebugFrameLineBg := RGB(238, 239, 230);
  FDebugFrameLineColor := clBlack;

  FTabWidth := 8;
  FIndentWidth := 4;

  FDummyDoc := TLMDEditDocument.Create(nil);
  FDummyDoc.ReadOnly := true;

  FDocLst := TViewLst.Create(Self);

  FFont := TFont.Create;
  FFont.Name := 'Courier New';
  FFont.Size := 10;
  FFont.Color := clWindowText;
  FFont.OnChange := OnFontChange;

  FFontBold := TFont.Create;
  LMDSedAssignFont(FFontBold, FFont, FFont.Charset);
  FFontBold.Style := FFontBold.Style + [fsBold];

  FSpecialChars := TLMDSpecialChars.Create(FPartParent);

  FScreenCache := TScreenCache.Create(Self, wmNoWrap, FTabWidth, 100, 1, 80,
                                      FFont, nil, FSpecialChars);

  Color := clBackground;

  FAddictCheckTokens := TLMDMemoryStrings.Create;

  ClearAddictCheckTokenIds;

  AttachToDocument;

  FGutterBarsEmpty := false;
  FGutter := nil;//this for TLMDGutter.Create
  FGutter := TLMDGutter.Create(Self);
  RecalkScreenVars;

  FInsCaret := NeedInsCaret;

  FScrollTimerBase := SCROLL_TIMER_BASE;
  FMouseDownX := -1;
  FMouseDownY := -1;
  FCursorBeforeDrag := OffsetPt(0, 0);

  FBorderStyle := bsSingle;
  FScrollBars := ssBoth;
  FWantTabs := True;
  FWantReturns := True;
  FMouseWheelAcc := 0;

  FSearchState := stNothing;
  FSearchIncJumps := Contnrs.TObjectList.Create;
  FSearchIncJumps.OwnsObjects := true;

  Cursor := crIBeam;
  Color := clWhite;
  FScrollTimer := TTimer.Create(nil);
  FScrollTimer.Interval := FScrollTimerBase;
  FScrollTimer.OnTimer := ScrollTimerHandler;
  FScrollTimer.Enabled := False;
  InvalidateScreen(True);

  FDefaultCommands := TLMDEditCommandList.Create(self);

  FCustomCommands := nil;//this for TLMDEditCommandList.Create
  FCustomCommands := TLMDEditCommandList.Create(self);

  FPressedShortcut := 0;
  FillDefaultKeybindings;

  Dct := GetDoubleClickTime;

  FSysDoubleClickTime := LMDMsecsToTime(Dct);
  FLastDoubleClickTime := 0;

  FSearchNumOfReplacements := 0;
  FStatusChanges := [];

  FHighlightSettings := TLMDEditHighlightSettings.Create(self);

  FPrintTasks := TList.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDCustomEditView.Destroy;
begin
  AddInternalState(siDestroing);
  RemoveInternalState(siComplIncSearch);

  DetachFromDocument(false);
  StopScrollTimer;
  StopCompletionTimer;

  ClearPrintTasks;
  FPrintTasks.Free;

  //
  FHighlightSettings.Free;

  //
  FComplSettings.Free;
  FCompletionTimer.Free;
  FCompletionList.Free;
  FComplStrHash.Free;
  //

  FScrollTimer.Free;

  FUpdatingCnt := 0;
  FChangesLock := 0;

  FGutter.Free;
  FDummyDoc.Free;
  FDocLst.Free;
  FScreenCache.Free;
  FFont.Free;
  FFontBold.Free;

  FSpecialChars.Free;

  FDefaultCommands.Free;
  FCustomCommands.Free;

  FAddictCheckTokens.Free;

  FCachedWin.Free;

  FOldPen.Free;
  FOldBrush.Free;

  FPartParent.Free;

  if not LMDDisableOleinit and FDoCoUninit then
    OleUninitialize;

  FLineBmp.Free;

  FSearchIncJumps.Free;

  inherited Destroy;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetDefaultKeyBindings: TLMDEditCommandList;
begin
  Result := FDefaultCommands;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.InvokeCommand(ACommand: TLMDEditCommand;
                                           AArg: Variant;
                                           AllowCommandEvents: Boolean);

type
    TBehaviour = (bhNoComplete, bhInOpenCombo,
                  bhSepWordTyping, bhCompleteDisabled);
var
    Changeable, Overwrite: Boolean;
    Str: TLMDString;
    Dummy: Variant;
    DoInvoke: Boolean;
    Beh: TBehaviour;

procedure InvokeCommandLow(ACommand: TLMDEditCommand; ADoLock: Boolean);
begin
  if ADoLock then
    Inc(FCmdModesLock);

  try

    if (siIncrementalSearch in FState) and
       (not (ACommand in [sedIncrementalSearchStart,
                          sedIncrementalSearchCancel,
                          sedIncrementalSearchForward,
                          sedIncrementalSearchBack,
                          sedNewLine,
                          sedIncrementalSearchAddChar]))
    then
      RemoveInternalState(siIncrementalSearch);

    case ACommand of
      sedLeft:      MoveToPrevChar(false, false);
      sedRight:     MoveToNextChar(false, false);
      sedUp:        MoveToPrevLine(false, false);
      sedDown:      MoveToNextLine(false, false);
      sedLineHome:  MoveToLineStart(false, false);
      sedLineEnd:   MoveToLineEnd(false, false);
      sedNextWord:  MoveToNextWord(false, false);
      sedPrevWord:  MoveToPrevWord(false, false);
      sedPageUp:    MoveToPrevPage(false, false);
      sedPageDown:  MoveToNextPage(false, false);
      sedPageHome:  MoveToFirstScreenLine(false, false);
      sedPageEnd:   MoveToLastScreenLine(false, false);

      sedTextHome:  MoveToTextStart(false, false);
      sedTextEnd:   MoveToTextEnd(false, false);

      sedScrollUp:   ScrollUp;
      sedScrollDown: ScrollDown;

      sedUndo:
        if Changeable then
          Undo
        else
          Beep;

      sedRedo:
        if Changeable then
          Redo
        else
          Beep;

      sedCut:
        if Changeable then
          CutSelection
        else
          Beep;

      sedCopy: CopySelection;

      sedPaste:
        if Changeable then
          Paste
        else
          Beep;

      sedDeletePrevChar:
        if Changeable then
        begin
          if SelAvail then
            DeleteSelected
          else
            DeleteCharLeft;
        end
        else
          Beep;

      sedDeleteChar:
        if Changeable then
        begin
          if SelAvail then
            DeleteSelected
          else
            DeleteCharRight;
        end
        else
          Beep;

      sedDeletePrevWord:
        if Changeable then
        begin
          if SelAvail then
            DeleteSelected
          else
            DeleteWordLeft;
        end
        else
          Beep;

      sedDeleteWord:
        if Changeable then
        begin
          if SelAvail then
            DeleteSelected
          else
            DeleteWordRight;
        end
        else
          Beep;

      sedDeleteToLineEnd:
        if not (Changeable and UI_DeleteToLineEnd(false)) then
          Beep;

      sedDeleteToLineWrap:
        if not (Changeable and UI_DeleteToLineEnd(true)) then
          Beep;

      sedDeleteLine:
        if not (Changeable and UI_DeleteLine) then
          Beep;

      sedChar:
        if Changeable then
        begin
          if  VarType(AArg) <> VarType(Dummy) then
          begin
            Str := AArg;
            InsertCharAtCursor(Str[1], 1, Overwrite);
          end;
        end
        else
          Beep;

      sedStr:
        if Changeable then
        begin
          if  VarType(AArg)<>VarType(Dummy) then
          begin
            Str := AArg;
            InsertAtCursor(Str, Overwrite);
          end;
        end
        else
          Beep;

      sedNewLine:
        if Changeable then
        begin
          if siIncrementalSearch in FState then
            RemoveInternalState(siIncrementalSearch)
          else
          begin
            BeginUpdate;
            try
              if SelAvail then
                DeleteSelected;
              InsertReturnAtCursor(Overwrite);
            finally
              EndUpdate;
            end;
          end;
        end
        else
          Beep;

      sedTab:
        if Changeable then
          InsertTabAtCursor(Overwrite)
        else
          Beep;

      sedIndent:
        if Changeable then
          IndentSelection(false)
        else
          Beep;

      sedUnIndent:
        if Changeable then
          UnindentSelection(false)
        else
          Beep;

      sedIndentToPrevIndent:
        if Changeable then
          IndentSelection(true)
        else
          Beep;

      sedUnIndentToPrevIndent:
        if Changeable then
          UnindentSelection(true)
        else
          Beep;

      sedBackspaceOrUnindent:
      begin
        if Changeable then
        begin
          if vsBackspaceUnindents in ViewSettings then
            UI_BackspaceOrUnindent
          else
            InvokeCommand(sedDeletePrevChar, Dummy, false);
        end
        else
          Beep;
      end;

      sedTabOrIndent:
      begin
        if Changeable then
        begin
          if vsAutoIndent in ViewSettings then
            UI_IndentOrTab
          else
            InvokeCommand(sedTab, Dummy, false);
        end
        else
          Beep;
      end;

      sedSelectLeft:          MoveToPrevChar(true, false);
      sedSelectRight:         MoveToNextChar(true, false);
      sedSelectLineHome:      MoveToLineStart(true, false);
      sedSelectLineEnd:       MoveToLineEnd(true, false);
      sedSelectPrevWord:      MoveToPrevWord(true, false);
      sedSelectNextWord:      MoveToNextWord(true, false);
      sedSelectUp:            MoveToPrevLine(true, false);
      sedSelectDown:          MoveToNextLine(true, false);
      sedSelectPageUp:        MoveToPrevPage(true, false);
      sedSelectPageDown:      MoveToNextPage(true, false);
      sedSelectAll:           SelectAll;
      sedSelectTextHome:      MoveToTextStart(true, false);
      sedSelectTextEnd:       MoveToTextEnd(true, false);
      sedSelectPageHome:      MoveToFirstScreenLine(true, false);
      sedSelectPageEnd:       MoveToLastScreenLine(true, false);

      sedSelectLeftBlock:     MoveToPrevChar(true, true);
      sedSelectRightBlock:    MoveToNextChar(true, true);
      sedSelectLineHomeBlock: MoveToLineStart(true, true);
      sedSelectLineEndBlock:  MoveToLineEnd(true, true);
      sedSelectPrevWordBlock: MoveToPrevWord(true, true);
      sedSelectNextWordBlock: MoveToNextWord(true, true);
      sedSelectUpBlock:       MoveToPrevLine(true, true);
      sedSelectDownBlock:     MoveToNextLine(true, true);
      sedSelectPageUpBlock:   MoveToPrevPage(true, true);
      sedSelectPageDownBlock: MoveToNextPage(true, true);

      sedSelectTextHomeBlock: MoveToTextStart(true, true);
      sedSelectTextEndBlock:  MoveToTextEnd(true, true);
      sedSelectPageHomeBlock: MoveToFirstScreenLine(true, true);
      sedSelectPageEndBlock:  MoveToLastScreenLine(true, true);

      sedSelectNone:          CancelSelection;

      sedToggleOverwrite:
        if Overwrite then
          ViewSettings := ViewSettings - [vsOverwrite]
        else
          ViewSettings := ViewSettings + [vsOverwrite];

      sedCompletionShow:
      begin
        CheckRequiredState(siIncrementalSearch, false);

        CheckShowCompletionList(false, fcForced, true);
      end;

      //Search commands

      sedIncrementalSearchStart:
      begin
        CheckRequiredState(siComplListShown, false);
        CheckRequiredState(siIncrementalSearch, false);

        AddInternalState(siIncrementalSearch);
      end;

      sedIncrementalSearchCancel:
        RemoveInternalState(siIncrementalSearch);

      sedIncrementalSearchForward:
      begin
        CheckRequiredState(siComplListShown, false);
        CheckRequiredState(siIncrementalSearch, true);

        IncrementalSearchForward;
      end;

      sedIncrementalSearchBack:
      begin
        CheckRequiredState(siComplListShown, false);
        CheckRequiredState(siIncrementalSearch, true);

        IncrementalSearchBackward;
      end;

      sedIncrementalSearchAddChar:
      begin
        CheckRequiredState(siComplListShown, false);
        CheckRequiredState(siIncrementalSearch, true);

        Str := AArg;
        IncrementalSearchAddChar(Str[1]);
      end;

      sedCompletionUp,      sedCompletionDown,  sedCompletionCommit,
      sedCompletionCancel,  sedCompletionBack,  sedCompletionLeft,
      sedCompletionRight,   sedCompletionPgUp,  sedCompletionPgDown,
      sedCompletionHome,    sedCompletionEnd:
      begin
        CheckRequiredState(siIncrementalSearch, false);
        CheckRequiredState(siComplListShown, true);
      end;
    else
      Assert(false);
    end;

    case ACommand of
      sedTextHome, sedTextEnd, sedLineHome, sedLineEnd, sedNextWord,
      sedPrevWord, sedLeft,    sedRight,    sedUndo,    sedRedo,
      sedCut,      sedCopy,    sedPaste,    sedDeletePrevChar,
      sedDeleteChar,           sedDeletePrevWord,
      sedDeleteWord,           sedDeleteLine,
      sedDeleteToLineEnd,      sedChar,     sedNewLine,
      sedTab,     sedIndent,   sedUnIndent, sedIndentToPrevIndent,
      sedUnIndentToPrevIndent, sedBackspaceOrUnindent,
      sedTabOrIndent,          sedDeleteToLineWrap,

      sedSelectLeft,           sedSelectRight,
      sedSelectPrevWord,       sedSelectNextWord,        sedSelectLineHome,
      sedSelectLineEnd,        sedSelectTextHome,        sedSelectTextEnd,

      sedSelectLeftBlock,      sedSelectRightBlock,
      sedSelectPrevWordBlock,  sedSelectNextWordBlock,   sedSelectLineHomeBlock,
      sedSelectLineEndBlock,   sedSelectTextHomeBlock,   sedSelectTextEndBlock,

      sedIncrementalSearchAddChar, sedIncrementalSearchBack,
      sedIncrementalSearchForward:
      begin
        SaveCursorMaxHoriz;
      end;

      sedUp,       sedDown,        sedPageUp,     sedPageDown, sedPageHome,
      sedPageEnd,  sedScrollUp,    sedScrollDown,

      sedSelectUp,      sedSelectDown,      sedSelectPageUp,
      sedSelectPageDown,           sedSelectPageHome,  sedSelectPageEnd,

      sedSelectUpBlock, sedSelectDownBlock, sedSelectPageUpBlock,
      sedSelectPageDownBlock,      sedSelectPageHomeBlock,
      sedSelectPageEndBlock:
      begin
        CorrectCursorToMaxHoriz;
      end;
    end;
  finally
    if ADoLock then
      Dec(FCmdModesLock);
  end;
end;

function CursorInSep: Boolean;
var
    L, R: TLMDChar;
begin
  if CursorOffset = 0 then
    L := LMDSpace
  else
    L := MyDoc.Chars[CursorOffset-1];

  if CursorOffset = MyDoc.CharsCount then
    R := LMDSpace
  else
    R := MyDoc.Chars[CursorOffset];

  Result := (LMDPosEx(L, GetComplSeparators, 1) > 0) and
            (LMDPosEx(R, GetComplSeparators, 1) > 0);
end;

function CursorAtWordBounds: Boolean;
var
    L, R: TLMDChar;
begin
  if CursorOffset = 0 then
    L := LMDSpace
  else
    L := MyDoc.Chars[CursorOffset-1];

  if CursorOffset = MyDoc.CharsCount then
    R := LMDSpace
  else
    R := MyDoc.Chars[CursorOffset];

  Result := (LMDPosEx(L, GetComplSeparators, 1) = 0) and
            (LMDPosEx(R, GetComplSeparators, 1) > 0);
end;

function CmdIsWordChar: Boolean;
var
    Ch: TLMDChar;
    S: TLMDString;
begin
  Result := ACommand = sedChar;

  if Result then
  begin
    S := AArg;
    Ch := S[1];
    Result := LMDPosEx(Ch, GetComplSeparators, 1) = 0;
  end;
end;

function CmdIsSepChar: Boolean;
var
    Ch: TLMDChar;
    S: TLMDString;
begin
  if ACommand = sedChar then
  begin
    S := AArg;
    Ch := S[1];
    Result := LMDPosEx(Ch, GetComplSeparators, 1) > 0;
  end
  else
    Result := ACommand in [sedTab, sedTabOrIndent, sedNewLine];
end;

var
    DoLock: Boolean;
begin
  DoInvoke := true;

  if AllowCommandEvents and Assigned(FOnBeforeCommand) then
    FOnBeforeCommand(self, ACommand, AArg, DoInvoke);

  if not DoInvoke then
    Exit;

  Dummy := Unassigned;
  Changeable := IsDocumentSet and (not IsReadOnly);
  Overwrite := vsOverwrite in ViewSettings;

  BeginUpdate;
  try
    //Determine the behaviour

    if FCompletionType <> ctDisabled then
    begin
      if CursorInSep and CmdIsWordChar then
      begin
        AddInternalState(siComplWordTyping);

        if siComplListShown in FState then
          Beh := bhInOpenCombo
        else
          Beh := bhNoComplete;
      end
      else if siComplListShown in FState then
        Beh := bhInOpenCombo
      else if CmdIsSepChar and (siComplWordTyping in FState) then
        Beh := bhSepWordTyping
      else
        Beh := bhNoComplete;
    end
    else
      Beh := bhCompleteDisabled;

    DoLock := siIncrementalSearch in FState;
    case Beh of
      bhCompleteDisabled:
      begin
        InvokeCommandLow(ACommand, DoLock);
      end;

      bhNoComplete:
      begin
        DoLock := DoLock or CmdIsWordChar or (ACommand in [sedUndo,
                                              sedDeletePrevChar,
                                              sedBackspaceOrUnindent]);

        InvokeCommandLow(ACommand, DoLock);

        if CursorAtWordBounds and CmdIsWordChar and FComplUseTimeout then //type at end of word
        begin
          AddInternalState(siComplTimer);
          StartCompletionTimer;
        end
        else
          RemoveInternalState(siComplTimer);
      end;

      bhInOpenCombo:
      begin
        Assert(not (siComplTimer in FState));
        Assert(not FCompletionTimer.Enabled);

        case ACommand of
          sedChar:
          begin
            if CmdIsSepChar then
            begin
              CommitCompletion(CursorPos, rcCompletionList);
              InvokeCommandLow(ACommand, true);
            end
            else
            begin
              InvokeCommandLow(ACommand, true);
              CheckShowCompletionList(false, fcForced, false);
            end;
          end;

          sedCompletionUp,
          sedCompletionPgUp:
          begin
            if FCompletionList.ItemIndex = 0 then
              FCompletionList.ItemIndex := FCompletionList.Count - 1
            else
              FCompletionList.ItemIndex := FCompletionList.ItemIndex - 1;
          end;

          sedCompletionDown,
          sedCompletionPgDown:
          begin
            if FCompletionList.ItemIndex = FCompletionList.Count - 1 then
              FCompletionList.ItemIndex := 0
            else
              FCompletionList.ItemIndex := FCompletionList.ItemIndex + 1;
          end;

          sedCompletionHome:
          begin
            FCompletionList.ItemIndex := 0;
          end;

          sedCompletionEnd:
          begin
            FCompletionList.ItemIndex := FCompletionList.Count - 1;
          end;

          sedCompletionCommit:
          begin
            CommitCompletion(CursorPos, rcCompletionList);
            RemoveInternalState(siComplWordTyping);
          end;

          sedCompletionCancel:
            RemoveInternalState([siComplListShown, siComplTimer]);

          sedCompletionBack:
          begin
            InvokeCommandLow(sedDeletePrevChar, true);
            CheckShowCompletionList(false, fcForced, false);
          end;

          sedCompletionLeft:
          begin
            InvokeCommandLow(sedLeft, true);
            CheckShowCompletionList(true, fcForced, false);
            RemoveInternalState(siComplWordTyping);
          end;

          sedCompletionRight:
          begin
            InvokeCommandLow(sedRight, true);
            CheckShowCompletionList(true, fcForced, false);
            RemoveInternalState(siComplWordTyping);
          end;
        end;

        if not (CmdIsWordChar and CursorAtWordBounds) then
          RemoveInternalState(siComplWordTyping);
      end;

      bhSepWordTyping:
      begin
        FDocInternal.BeginCompoundAction(FAuthorID, CreateCursorUndoInfo, false);
        try
          CheckShowCompletionList(false, fcWordEnd, true);
          InvokeCommandLow(ACommand, false);
        finally
          MyDoc.EndCompoundEdit(false);
        end;

        RemoveInternalState(siComplListShown);
        RemoveInternalState(siComplTimer);
        RemoveInternalState(siComplWordTyping);
      end;
    else
      Assert(false);
    end;
  finally
    EndUpdate;
  end;

  if AllowCommandEvents and Assigned(FOnAfterCommand) then
    FOnAfterCommand(self, ACommand, AArg);
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.ScreenHeightFullVis: Integer;
begin
  if FLineHeight * ScreenHeight > LMDRectHeight(GetDrawRect) then
    Result := ScreenHeight - 1
  else
    Result := ScreenHeight;

  Result := Max(1, Result);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.RecalkScreenVars;
var
  Sz:   TSize;
  ScreenH, ScreenW: Integer;
  W, H: Integer;
  Cnv: TCanvas;
  SaveFont: HFont;
begin
  if HandleAllocated then
    Cnv := self.Canvas
  else
    Cnv := nil;

  if Cnv <> nil then
    Sz := SedGetFontSize(FFontBold, Cnv)
  else
    Sz := SedGetFontScreenSize(FFontBold);

  FLineHeight := Sz.cy;

  FGutterWidth := FGutter.GetWidth;

  if HandleAllocated then
  begin
    W := LMDRectWidth( GetDrawRect );
    H := LMDRectHeight( GetDrawRect );

    ScreenH := Max(1, H div FLineHeight);
    if (H mod FLineHeight) <> 0 then
      Inc(ScreenH);

    ScreenW := Max(1, W - FGutterWidth);

    SaveFont := SelectObject(Cnv.Handle, FFont.Handle);
    GetTextMetrics(Cnv.Handle, FFontMetrics);
    SelectObject(Cnv.Handle, SaveFont);
  end
  else
  begin
    ScreenH := Max(FLineHeight*2, Height);
    ScreenW := ScreenH;
  end;

  Cache(Self).SetCanvas(Cnv);
  Cache(Self).SetScreenSize(ScreenW, ScreenH);
end;

{------------------------------------------------------------------------------}

function  TLMDSpecialChars.GetOwner: TPersistent;
begin
  Result := FParent.GetOwnerComponent;
end;

{------------------------------------------------------------------------------}

constructor TLMDSpecialChars.Create(AParent: TLMDViewPartParent);
var Kind: TLMDSpecialCharKind;
begin
  if AParent=nil then
    raise ELMDEditViewError.Create(SLMDSedViewInternalClassCreate);

  inherited Create;

  FParent := AParent;

  FCharset := 0;//Ansi charset by default. It should have all the fancy letters

  {$IFDEF LMD_UNICODE}
    FUseCharset := True;

    FShowCharsDefault[skTabTail] := #$2500;
    FShowCharsDefault[skTabHead] := #$25BA;
    FShowCharsDefault[skSpace] := #$2219;
    FShowCharsDefault[skCR] := #$00B6;
    FShowCharsDefault[skLF] := #$00B6;
    FShowCharsDefault[skCRLF] := #$00B6;
    FShowCharsDefault[skLineWrap] := #$00AC;
    FShowCharsDefault[skFoldedLineEnd] := #$2026;
    FShowCharsDefault[skLineNumberBullet] := #$00B7;
  {$ELSE}
    FUseCharset := True;

    FShowCharsDefault[skTabTail] := #$BB;
    FShowCharsDefault[skTabHead] := #$BB;
    FShowCharsDefault[skSpace] := #$B7;
    FShowCharsDefault[skCR] := #$B6;
    FShowCharsDefault[skLF] := #$B6;
    FShowCharsDefault[skCRLF] := #$B6;
    FShowCharsDefault[skLineWrap] := #$AC;
    FShowCharsDefault[skFoldedLineEnd] := #$A8;
    FShowCharsDefault[skLineNumberBullet] := #$B7;
  {$ENDIF}

  for Kind:=Low(Kind) to High(Kind) do
    FShowChars[Kind] := FShowCharsDefault[Kind];

  FShowCharKinds := [skFoldedLineEnd];
end;

{------------------------------------------------------------------------------}

procedure TLMDSpecialChars.Assign(Source: TPersistent);
var
  Src: TLMDSpecialChars;
  Kind: TLMDSpecialCharKind;
begin
  if Source is TLMDSpecialChars then
  begin
    FParent.BeginChange;
    try
      Src := TLMDSpecialChars(Source);

      Charset := Src.Charset;
      UseCharset := Src.UseCharset;

      for Kind := Low(Kind) to High(Kind) do
        FShowChars[Kind] := Src.FShowChars[Kind];

      ShowCharKinds := Src.ShowCharKinds;
    finally
      FParent.EndChange(true);
    end;
  end
  else
    inherited Assign(Source);
end;

{------------------------------------------------------------------------------}

function TLMDSpecialChars.GetDecodedChar(AKind: TLMDSpecialCharKind): TLMDChar;
begin
  Result := FShowChars[AKind];
end;

{------------------------------------------------------------------------------}

function TLMDSpecialChars.IsStored(AKind: TLMDSpecialCharKind): Boolean;
begin
  Result := FShowChars[AKind] <> FShowCharsDefault[AKind];
end;

{------------------------------------------------------------------------------}

function TLMDSpecialChars.GetChar(AKind: TLMDSpecialCharKind): TLMDString;
var Ch: TLMDChar; CharValid: Boolean;
begin
  Ch := FShowChars[AKind];

  CharValid := (Ord(Ch)>=20)
               {$IFDEF LMD_UNICODE} and (Ord(Ch)<=255) {$ENDIF};

  if CharValid then
    Result := Ch
  else
    Result := '#'+IntToStr(Ord(Ch));
end;

{------------------------------------------------------------------------------}
procedure TLMDSpecialChars.SetChar_TabTail(AChar: TLMDString);
begin
  SetChar(skTabTail, AChar);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.GetChar_TabTail: TLMDString;
begin
  Result := GetChar(skTabTail);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.IsStored_TabTail: Boolean;
begin
  Result := IsStored(skTabTail);
end;

{------------------------------------------------------------------------------}
procedure TLMDSpecialChars.SetChar_TabHead(AChar: TLMDString);
begin
  SetChar(skTabHead, AChar);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.GetChar_TabHead: TLMDString;
begin
  Result := GetChar(skTabHead);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.IsStored_TabHead: Boolean;
begin
  Result := IsStored(skTabHead);
end;

{------------------------------------------------------------------------------}
procedure TLMDSpecialChars.SetChar_Space(AChar: TLMDString);
begin
  SetChar(skSpace, AChar);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.GetChar_Space: TLMDString;
begin
  Result := GetChar(skSpace);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.IsStored_Space: Boolean;
begin
  Result := IsStored(skSpace);
end;

{------------------------------------------------------------------------------}
procedure TLMDSpecialChars.SetChar_CR(AChar: TLMDString);
begin
  SetChar(skCR, AChar);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.GetChar_CR: TLMDString;
begin
  Result := GetChar(skCR);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.IsStored_CR: Boolean;
begin
  Result := IsStored(skCR);
end;

{------------------------------------------------------------------------------}
procedure TLMDSpecialChars.SetChar_LF(AChar: TLMDString);
begin
  SetChar(skLF, AChar);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.GetChar_LF: TLMDString;
begin
  Result := GetChar(skLF);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.IsStored_LF: Boolean;
begin
  Result := IsStored(skLF);
end;

{------------------------------------------------------------------------------}
procedure TLMDSpecialChars.SetChar_CRLF(AChar: TLMDString);
begin
  SetChar(skCRLF, AChar);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.GetChar_CRLF: TLMDString;
begin
  Result := GetChar(skCRLF);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.IsStored_CRLF: Boolean;
begin
  Result := IsStored(skCRLF);
end;

{------------------------------------------------------------------------------}
procedure TLMDSpecialChars.SetChar_LineWrap(AChar: TLMDString);
begin
  SetChar(skLineWrap, AChar);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.GetChar_LineWrap: TLMDString;
begin
  Result := GetChar(skLineWrap);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.IsStored_LineWrap: Boolean;
begin
  Result := IsStored(skLineWrap);
end;

{------------------------------------------------------------------------------}
procedure TLMDSpecialChars.SetChar_FoldedLineEnd(AChar: TLMDString);
begin
  SetChar(skFoldedLineEnd, AChar);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.GetChar_FoldedLineEnd: TLMDString;
begin
  Result := GetChar(skFoldedLineEnd);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.IsStored_FoldedLineEnd: Boolean;
begin
  Result := IsStored(skFoldedLineEnd);
end;

{------------------------------------------------------------------------------}
procedure TLMDSpecialChars.SetChar_LineNumberBullet(AChar: TLMDString);
begin
  SetChar(skLineNumberBullet, AChar);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.GetChar_LineNumberBullet: TLMDString;
begin
  Result := GetChar(skLineNumberBullet);
end;

{------------------------------------------------------------------------------}
function TLMDSpecialChars.IsStored_LineNumberBullet: Boolean;
begin
  Result := IsStored(skLineNumberBullet);
end;

{------------------------------------------------------------------------------}

procedure TLMDSpecialChars.SetChar(AKind: TLMDSpecialCharKind; AChar: TLMDString);
var Ch: TLMDChar; Code: Integer;
begin
  if Length(AChar)=0 then
    raise ELMDEditViewError.Create(SLMDSedViewBadSpecialChar);

  if AChar[1]='#' then
  begin
    Code := StrToIntDef(Copy(AChar, 2, Length(AChar)-1), -1);
    if (Code=-1) or (Code>Ord(High(TLMDChar))) then
    begin
      if csLoading in FParent.GetOwnerComponent.ComponentState then
        Ch := FShowCharsDefault[AKind]
      else
        raise ELMDEditViewError.Create(SLMDSedViewBadSpecialChar);
    end
    else
      Ch := TLMDChar(Code);
  end
  else
  begin
    if Length(AChar)<>1 then
      raise ELMDEditViewError.Create(SLMDSedViewBadSpecialChar);

    Ch := AChar[1];
  end;

  if FShowChars[AKind]=AChar then
    Exit;

  FParent.BeginChange;
  try
    FShowChars[AKind] := Ch;
  finally
    FParent.EndChange(true);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDSpecialChars.SetShowCharKinds(AKinds: TLMDSpecialCharKinds);
begin
  if FShowCharKinds=AKinds then
    Exit;

  FParent.BeginChange;
  try
    if (skTabTail in AKinds) or (skTabHead in AKinds) then
      AKinds := AKinds + [skTabTail, skTabHead];

    FShowCharKinds := AKinds;
  finally
    FParent.EndChange(true);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDSpecialChars.SetCharSet(ACharset: TFontCharset);
begin
  if FCharset=ACharset then
    Exit;

  FParent.BeginChange;
  try
    FCharset := ACharset;
  finally
    FParent.EndChange(true);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDSpecialChars.SetUseCharSet(AUse: Boolean);
begin
  if FUseCharset=AUse then
    Exit;

  FParent.BeginChange;
  try
    FUseCharset := AUse;
  finally
    FParent.EndChange(true);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.BeginSettingsChange;//UD-LK-
begin
  BeginChangeCommon;

  RemoveInternalState(siComplIncSearch);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EndSettingsChange(ABlockEvent, AResetCache: Boolean);
begin
  FCachedWin.InvalidateFromKey1(0);

  if AResetCache then
    CacheDelayed(self).ResetPreserve;

  EndChangeCommon(True, ABlockEvent);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.BeforeDocRefresh;
begin
  BeginSettingsChange;

  RemoveInternalState(siComplIncSearch);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.AfterDocRefresh;
begin
  FCachedWin.InvalidateFromKey1(0);

  CacheDelayed(Self).DocumentRefresh;

  EndChangeCommon(True, True);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.BeforeDocSettingsRefresh;
begin
  BeginSettingsChange;

  RemoveInternalState(siComplAll);
  HorizScroll := 0;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.AfterDocSettingsRefresh;
begin
  UpdateAddictCheckTokenIds;

  EndSettingsChange(true, true);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetWrapRulerWidth(AWidth: Integer);
begin
  if AWidth=WrapRulerWidth then
    Exit;

  BeginSettingsChange;
  try
    Cache(Self).SetWrapWidth(AWidth);
    AddStatusChange(scWrapSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

procedure TLMDCustomEditView.StopScrollTimer;
begin
  FScrollTimer.Enabled := false;
  FScrollDirX := 0;
  FScrollDirY := 0;  
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetWrapMode(AMode: TLMDViewWrapMode);
begin
  if AMode=GetWrapMode then
    Exit;

  case AMode of
    wmNoWrap: ;
    wmWrapToRuler: ;
    wmWrapToWindow: ;
  else
    AMode := wmNoWrap;
  end;

  BeginSettingsChange;
  try
    Cache(Self).SetWrapMode(AMode);
    UpdateWinStyle;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetDocument(ADoc: TLMDEditDocument);
begin
  SetDocumentLow(ADoc, Document<>nil);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetDocumentLow(ADoc: TLMDEditDocument;
                                            AStoreOldDoc: Boolean);
begin
  if FFDoc=ADoc then
    Exit;

  BeginSettingsChange;
  try
    DetachFromDocument(AStoreOldDoc);

    ////
    FFDoc := ADoc;

    //
    AttachToDocument;
  finally
    EndSettingsChange(true, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetViewSettings(ASettings: TLMDViewSettings);
begin
  if ASettings=FViewSettings then
    Exit;

  BeginSettingsChange;
  try
    FViewSettings := ASettings;
    RecalkScreenVars;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetTabWidth(AWidth: Integer);
begin
  if AWidth=FTabWidth then
    Exit;

  BeginSettingsChange;
  try
    Cache(Self).CheckTabWidth(FTabWidth);
    
    FTabWidth := AWidth;

    AddStatusChange(scViewSettings);
    Cache(Self).SetTabWidth(FTabWidth);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.OnFontChange(Sender: TObject);//UD-
begin
  BeginSettingsChange;
  try
    LMDSedAssignFont(FFontBold, FFont, FFont.Charset);
    FFontBold.Style := FFontBold.Style + [fsBold];

    Cache(self).SetFont(FFont);
    RecalkScreenVars;
    AddStatusChange(scFont);

    UpdatePrintTasksFont;
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetFont(AFont: TFont);//UD-UV+
begin
  if FFont = AFont then
    Exit;

  FFont.OnChange := nil;
  FFont.Assign(AFont);
  FFont.OnChange := OnFontChange;
  OnFontChange(FFont);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetWordUnderCursor: TLMDString;
var
    Seg: TLMDSegment;
begin
  Result := '';

  Seg := MyDoc.FindNearWord(CursorOffset, -1, true);
  if not LMDSegIsBad(Seg) then
  begin
    if LMDInRange(CursorOffset, Seg.Start, LMDSegEnd(Seg)) then
      Result := LMDSegToString(Seg);
  end;
end;

function  TLMDCustomEditView.GetWrapMode: TLMDViewWrapMode;
begin
  Result := Cache(Self).WrapMode;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetWrapRulerWidth: Integer;
begin
  Result := Cache(Self).WrapWidth;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetReadOnlyBgColor(AColor: TColor);
begin
  if AColor=FReadOnlyBgColor then
    Exit;

  BeginSettingsChange;
  try
    FReadOnlyBgColor := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetWrapRulerColor(AColor: TColor);
begin
  if AColor=FWrapRulerColor then
    Exit;

  BeginSettingsChange;
  try
    FWrapRulerColor := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetSelectedLineBg(AColor: TColor);
begin
  if AColor=FSelectedLineBg then
    Exit;

  BeginSettingsChange;
  try
    FSelectedLineBg := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetBreakpointLineColor(AColor: TColor);
begin
  if AColor=FBreakpointLineColor then
    Exit;

  BeginSettingsChange;
  try
    FBreakpointLineColor := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetBorderStyle(AStyle: TBorderStyle);
begin
  if FBorderStyle=AStyle then
    Exit;

  RemoveInternalState(siComplAll);

  FBorderStyle := AStyle;
  RecreateWnd;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetBreakpointLineBg(AColor: TColor);
begin
  if AColor=FBreakpointLineBg then
    Exit;

  BeginSettingsChange;
  try
    FBreakpointLineBg := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetSelectionBg(AColor: TColor);
begin
  if AColor=FSelectionBg then
    Exit;

  BeginSettingsChange;
  try
    FSelectionBg := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetSelectionColor(AColor: TColor);
begin
  if AColor=FSelectionColor then
    Exit;

  BeginSettingsChange;
  try
    FSelectionColor := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetGutter(AGutter: TLMDGutter);
begin
  if AGutter=FGutter then
    Exit;

  BeginSettingsChange;
  try
    FGutter.Assign(AGutter);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetSelStart(AStart: TPoint);
begin
  SetSelection(AStart, GetSelEnd, SelectionBlockMode);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetSelEnd(AEnd: TPoint);
begin
  SetSelection(GetSelStart, AEnd, SelectionBlockMode);
end;

procedure TLMDCustomEditView.SetSelOffsetStart(AOffset: Integer);
begin
  SetSelection(AOffset, SelectionOffsetEnd, SelectionBlockMode);
end;

procedure TLMDCustomEditView.SetSelOffsetEnd(AOffset: Integer);
begin
  SetSelection(SelectionOffsetStart, AOffset, SelectionBlockMode);
end;

function  TLMDCustomEditView.GetSelStart: TPoint;
begin
  Result := Cache(self).SelStart;
end;

function  TLMDCustomEditView.GetSelEnd: TPoint;
begin
  Result := Cache(self).SelEnd;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetSelBlockMode: Boolean;
begin
  Result := Cache(self).SelBlockMode;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetSelBlockMode(ABlockMode: Boolean);
begin
  SetSelection(GetSelStart, GetSelEnd, ABlockMode);
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetSelStartNorm: TPoint;
begin
  Result := Cache(self).SelStartN;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetSelEndNorm: TPoint;
begin
  Result := Cache(self).SelEndN;
end;

function TLMDCustomEditView.GetSelOffsetEnd: Integer;
begin
  Result := Cache(self).SelEndOffset.Offset;
end;

function TLMDCustomEditView.GetSelOffsetStart: Integer;
begin
  Result := Cache(self).SelStartOffset.Offset;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetReadOnly(Value: Boolean);
begin
  if Value = FReadOnly then
    Exit;

  BeginSettingsChange;
  try
    FReadOnly := Value;
    AddStatusChange(scViewSettings);
    RemoveInternalState(siComplIncSearch);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetScreenHeight: Integer;
begin
  Result := Cache(self).ScreenHeightLines;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.NoWrap: Boolean;
begin
  Result := WrapMode=wmNoWrap;
end;

{------------------------------------------------------------------------------}

//Real screen size
function TLMDCustomEditView.GetLinesOnScreenScroll: Integer;//L+
begin
  Result := Cache(Self).LinesOnScreenScroll;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetTopLineScroll: Integer;//L+
begin
  Result := Cache(Self).FirstLineScroll;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetTopLinePhysical: Integer;//L+
begin
  Result := Cache(Self).FirstLinePhysical;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.LastLineScroll: Integer;
begin
  Result := Cache(self).LastLineScroll;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetNextVisibleLine(ALine: Integer): Integer;
begin
  Result := CacheDelayed(Self).GetNextVisibleLine(ALine, True);
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetPrevVisibleLine(ALine: Integer): Integer;
begin
  Result := CacheDelayed(Self).GetPrevVisibleLine(ALine, True);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ScreenToPhysical(AScreen: Integer): Integer;
begin
  Result := Cache(Self).ScreenToPhysical(AScreen);
end;

function TLMDCustomEditView.ScreenToScroll(AScreen: Integer): Integer;
begin
  Result := Cache(Self).ScreenToScroll(AScreen);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ScrollToPhysical(ALine: Integer): Integer;
begin
  Result := Cache(Self).ScrollToPhysical(ALine);
end;

procedure TLMDCustomEditView.ScrollPosToPhysical(APoint: TPoint;
                                                 out APhysLine, ACol: Integer);
var
    Off: TOffsetPoint;
begin
  Off := Cache(self).ScrollPtToOffsetPt(APoint);

  APhysLine := MyDoc.GetLineByOffset(Off.Offset);
  ACol := Off.Offset - MyDoc.LineSegments[APhysLine].Start + Off.InCharOffset; 
end;

procedure TLMDCustomEditView.ScrollToPos(AScrollPos: TPoint);
begin
  ScrollToPos(AScrollPos, true);
end;

procedure TLMDCustomEditView.ScrollToPos(AScrollPos: TPoint;
  AvoidScreenEdge: Boolean);
var
  Add, ScH, Y: Integer; Scr: TPoint;
  XStart, XCnt, XStartPix, XCntPix, HScroll: Integer;
begin
  Cache(self).CheckScrollLineIdx(AScrollPos.Y);

  ScH := ScreenHeightFullVis;

  if  LMDInRange(AScrollPos.Y, TopLineScroll, TopLineScroll+ScH-1) and
      Cache(self).IsScrollInScreenBounds(AScrollPos)
  then
    Exit;

  if AvoidScreenEdge or (siScrollforceAvoidAdges in FState) then
    Add := Max(0, Min(4, ScH-1))
  else
    Add := 0;

  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplAll);

    if AScrollPos.Y < TopLineScroll then
      TopLineScroll := AScrollPos.Y - Add
    else if AScrollPos.Y > TopLineScroll + ScH - 1 then
    begin
      Y := AScrollPos.Y + 1 + Add;

      TopLineScroll := Y - ScH;
    end;

    if not Cache(self).IsScrollInScreenBounds(AScrollPos) then
    begin
      Assert(Cache(self).IsScrollInScreenYBounds(AScrollPos.Y));

      Scr := Cache(self).ScrollPosToScreen(AScrollPos);
      Cache(self).GetScreenLineXBounds(Scr.Y, XStart, XCnt);

      if Scr.X < XStart then
      begin
        XStart := Max(0, Scr.X - Add - 1);

        Scr := Point(XStart, Scr.Y);
        Cache(self).ScreenPosToScreenPix(Scr, XStartPix, XCntPix, false);
      end
      else
      begin
        Assert(Scr.X >= XStart + XCnt);

        XStart := Max(0, Scr.X + Add);

        Scr := Point(XStart, Scr.Y);
        Cache(self).ScreenPosToScreenPix(Scr, XStartPix, XCntPix, false);
        XStartPix := XStartPix + XCntPix - Cache(self).ScreenWidthPixels;
      end;

      HScroll := Cache(self).PixelsToScrollXFixed(XStartPix, false);
      if HScroll=0 then
        HScroll := Sign(XStartPix);

      HorizScroll := HorizScroll + HScroll;
    end;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.PhysicalToScroll(ALine: Integer): Integer;
begin
  Result := Cache(Self).PhysicalToScroll(ALine);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CancelSelection;
begin
  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplAll);

    Cache(self).SetSelection(Cache(self).CursorOffset,
                             Cache(self).CursorOffset,
                             false);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetVisibleCountScroll: Integer;//L+
begin
  Result := Cache(Self).CalkVisibleCountScroll;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.IsLineStartVisible(APhysLine: Integer): Boolean;
begin
  Result := CacheDelayed(Self).IsLineStartVisible(APhysLine);
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.IsOffsetVisible(AOffset: Integer): Boolean;
begin
  Cache(Self).CheckOffsetForScroll(AOffset, true);

  Result := CacheDelayed(Self).IsOffsetVisible(AOffset);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.IsCollapsedFold(APhysLine: Integer): Boolean;
begin
  Result := CacheDelayed(Self).IsCollapsedFold(APhysLine);
end;

function  TLMDCustomEditView.IsFoldStart(APhysLine: Integer): Boolean;
begin
  Cache(self).CheckPhysLineIdx(APhysLine);
  Result := Parser.IsFoldStart(APhysLine);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EnsureVisible(ALine: Integer);
begin
  if ALine<MyDoc.LinesCount then
    EnsureOffsetIsVisible(MyDoc.LineSegments[ALine].Start);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EnsureOffsetIsVisible(AOffset: Integer);
begin
  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplIncSearch);

    Cache(Self).EnsureOffsetIsVisible(AOffset);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetStoreDocSettingsLimit: Integer;
begin
  Result := Cache(self).StoreDocSettingsLimit;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.FreeSearchState;
begin
  case FSearchState of
    stInSearch: MyDoc.FindPatternClose(FSearchStateBag) ;
    stInReplace: MyDoc.ReplacePatternClose(FSearchStateBag) ;
    stNothing: Assert(FSearchStateBag=nil);
  else
    Assert(false);
  end;

  FSearchStateBag := nil;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.IsUpdating: Boolean;
begin
  Result := FUpdatingCnt > 0;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.IsCursorInScreenBounds: Boolean;
begin
  Result := Cache(self).IsCursorInScreenBounds;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.NeedInsCaret: Boolean;
begin
  Result  := not (vsOverwrite in ViewSettings);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CreateViewCaret;
var
  cw, ch: Integer; R: TRect; outof: Boolean;
begin
  Assert(HandleAllocated);
  Assert(Focused);

  FInsCaret := not (vsOverwrite in ViewSettings);
  if FInsCaret then
    cw := 2
  else
  begin
    Assert(Cache(self).IsCursorInScreenBounds);

    R := ScrollPosToClient(CursorPos, outof); Assert(not outof);
    cw := R.Right - R.Left;
  end;

  ch := FLineHeight;

  Windows.CreateCaret(Self.Handle, 0, cw, ch);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.HasAddictCheckToken(ATokenID: Integer): Boolean;
var
    L, i: Integer;
begin
  L := Length(FAddictCheckTokenIds);
  if L > 10 then
    Result := LMDIntArrayBinarySearch(ATokenId, FAddictCheckTokenIds) <> -1
  else
  begin
    Result := false;

    for i := 0 to L - 1 do
    begin
      Result := FAddictCheckTokenIds[i] = ATokenID;
      if Result or (FAddictCheckTokenIds[i] > ATokenID) then
        Exit;
    end;
  end;
end;

procedure TLMDCustomEditView.HideViewCaret(AForce: Boolean);
begin
  if HandleAllocated and (Focused or AForce) then
  begin
    Windows.HideCaret(Handle);
    FCaretShown := False;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DestroyViewCaret;
begin
  Assert(HandleAllocated);

  Windows.DestroyCaret;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UpdateViewCaret(AForceUpdate: Boolean);
var
  p, p0: TPoint; ok, WasShown, outof: Boolean;
begin
  WasShown := FCaretShown;
  FCaretShown := HandleAllocated and Focused and IsCursorInScreenBounds;

  if FCaretShown then
  begin
    ok := GetCaretPos(p0);
    p := ScrollPosToClient(CursorPos, outof).TopLeft;

    if AForceUpdate or
       (not ok) or
       (not WasShown) or
       (not LMDPointsEqual(p, p0))
    then
    begin
      if not outof then
      begin
        if not WasShown then
          CreateViewCaret;

        Windows.SetCaretPos(p.x, p.y);
        Windows.ShowCaret(Handle);
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.BeginUpdateLow;
begin
  Assert(FUpdatingCnt>=0);
  Inc(FUpdatingCnt);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EndUpdateLow;
begin
  Assert(FUpdatingCnt>0);
  Dec(FUpdatingCnt);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SaveOldScreenParams;
begin
  Assert(not IsUpdating);

  FOldGutterWidth := FGutter.GetWidth;

  ResetScreenMarksChanged;

  Cache(self).ResetStatusChanges;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.ResetScreenMarksChanged;
begin
  FScreenMarksChanged := false;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.DragEnterI(
                const dataObj: IDataObject;
                grfKeyState: Longint;
                pt: TPoint;
                var dwEffect: Longint): HResult;

begin
  RemoveInternalState(siComplAll);

  if IsReadOnly then
    Result  := S_FALSE
  else
  begin
    DragOverI(grfKeyState, pt, dwEffect);

    Result  := S_OK;
  end;
end;

function TLMDCustomEditView.DragOverI(grfKeyState: Longint;
                  pt: TPoint;
                  var dwEffect: Longint): HResult;
var
    Accept: Boolean;
begin
  pt := ScreenToClient(pt);
  DragOver(nil, pt.X, pt.Y, dsDragMove, Accept);

  if Accept then
  begin
    if (grfKeyState and MK_CONTROL) <> 0 then
      dwEffect := DROPEFFECT_COPY
    else
      dwEffect := DROPEFFECT_MOVE;
  end
  else
    dwEffect := DROPEFFECT_NONE;

  Result  := S_OK;
end;

function TLMDCustomEditView.DragLeaveI: HResult;
begin
  Result := S_OK;
end;

function TLMDCustomEditView.DropI(const dataObj: IDataObject;
              grfKeyState: Longint; pt: TPoint;
              var dwEffect: Longint): HResult;
var
  aFmtEtc: TFormatEtc;
  aStgMed: TStgMedium;
  pData: Pointer;
  Str: TLMDString;
  AnsiStr: AnsiString;
  StartOff, EndOff: Integer;
  hr: HResult;
begin
  {Make certain the data rendering is available}

  RemoveInternalState(siComplAll);

  with aFmtEtc do
  begin
    cfFormat := CF_UNICODETEXT;
    ptd := nil;
    dwAspect := DVASPECT_CONTENT;
    lindex := -1;
    tymed := TYMED_HGLOBAL;
  end;

  {Get the data}
  hr := dataObj.GetData(aFmtEtc, aStgMed);
  if not Succeeded(hr) then
  begin
    aFmtEtc.cfFormat := CF_TEXT;
    hr := dataObj.GetData(aFmtEtc, aStgMed);
  end;

  if Succeeded(hr) then
  begin
    try
      {Lock the global memory handle to get a pointer to the data}
      pData := GlobalLock(aStgMed.hGlobal);
      if aFmtEtc.cfFormat = CF_TEXT then
      begin
        AnsiStr := PAnsiChar(pData);
        Str := TLMDString(AnsiStr);
      end
      else if aFmtEtc.cfFormat = CF_UNICODETEXT then
        Str := PWideChar(pData)
      else
        Assert(false);
    finally
      {Finished with the pointer}
      GlobalUnlock(aStgMed.hGlobal);
      {Free the memory}
      ReleaseStgMedium(aStgMed);
    end;

    BeginUpdate;
    try
      InsertInScrollEx(CursorPos, Str, true, StartOff, EndOff, false);
      StartOff := EndOff - Length(Str);
      SetSelection(StartOff, EndOff, false);
      CursorOffset := StartOff;
    finally
      EndUpdate;
    end;

    if (grfKeyState and MK_CONTROL) <> 0 then
      dwEffect := DROPEFFECT_COPY
    else
      dwEffect := DROPEFFECT_MOVE;
  end
  else
    dwEffect := DROPEFFECT_NONE;

  Result := S_OK;
end;

//////////////////////////////

function TLMDCustomEditView.WinCharPosToOffset(ACharPos: Integer): Integer;
var
    off, i, L, Cnt, D: Integer;

begin
  CheckDocumentIsSet;

  if FCachedWin.Count=0 then
  begin
    i := 0;
    L := 0;
  end
  else
  begin
    FCachedWin.FindNearestByKey2(ACharPos, off, i, L);
    Assert(off=MyDoc.LineSegments[L].Start);
  end;

  Cnt := MyDoc.LinesCount;

  if ACharPos >= i then
  begin
    repeat
      Inc(i, MyDoc.LineSegments[L].Count+1);
      Inc(L);
    until (ACharPos < i) or (L=Cnt);
  end
  else
  begin
    while (L > 0) and
          (ACharPos < (i - MyDoc.LineSegments[L-1].Count - 1))
    do
    begin
      Dec(i, MyDoc.LineSegments[L-1].Count+1);
      Dec(L);
    end;
  end;

  //Assert: Line[L].Start > ACharPos, i=Line[L].Start
  if L = 0 then
    L := 1;
    
  D := i - ACharPos - 2;
  Result := LMDSegEnd(MyDoc.LineSegments[L-1]) - D;

  Result := LMDMinMax(Result, 0, MyDoc.CharsCount);

  D := MyDoc.LineSegments[L-1].Count;
  FCachedWin.AddByKey2(MyDoc.LineSegments[L-1].Start, i-D-1, L-1);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.WinCharPosToScrollPos(ACharPos: Integer): TPoint;
begin
  Result := OffsetToScrollPos(WinCharPosToOffset(ACharPos));
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DeleteInScroll(AScrollStart, AScrollEnd: TPoint);
var
  Dummy: TOffsetPoint;
begin
  CheckNotReadOnly;

  DeleteInScrollEx(AScrollStart, AScrollEnd, False, Dummy);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DeleteInScrollEx(AScrollStart, AScrollEnd: TPoint;
  RememberCursor: Boolean; out AStartOffset: TOffsetPoint);
var
  Dummy: Integer;
  StartPt: TOffsetPoint;
  EndPt: TOffsetPoint;
  Ln, LnE: Integer;
begin
  StartPt := Cache(self).ScrollPtToOffsetPt(AScrollStart);
  EndPt := Cache(self).ScrollPtToOffsetPt(AScrollEnd);
  Ln := MyDoc.GetLineByOffset(StartPt.Offset);
  LnE := LMDSegEnd(MyDoc.LineSegments[Ln]) + 1;

  if (StartPt.Offset <> LnE) or (EndPt.Offset <> LnE) then
  begin
    ReplaceInScrollEx(AScrollStart, AScrollEnd, '',
                      RememberCursor, Dummy, AStartOffset.Offset);
    AStartOffset.InCharOffset := 0;
  end
  else
    AStartOffset := StartPt;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DeleteInScrollEx(AScrollStart, AScrollEnd: TPoint;
                                              out AStartOffset: TOffsetPoint);
begin
  CheckNotReadOnly;

  DeleteInScrollEx(AScrollStart, AScrollEnd, false, AStartOffset);
end;

procedure TLMDCustomEditView.DeleteInScrollBlock(AScrollStart,
                                                 AScrollEnd: TPoint;
                                                 out AStartOffset: TOffsetPoint);
var
  L: Integer;
  SelS, SelE, P1, P2:  TPoint;
begin
  CheckDocumentIsSet;
  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);
    SelS := AScrollStart;
    SelE := AScrollEnd;
    CorrectSelPointsBlockMode(SelS, SelE);

    FDocInternal.BeginCompoundAction(FAuthorID, CreateCursorUndoInfo, true);
    try
      for L := SelE.Y downto SelS.Y do
      begin
        P1 := Point(SelS.X, L);
        P2 := Point(SelE.X, L);

        DeleteInScrollEx(P1, P2, false, AStartOffset);
      end;
    finally
      MyDoc.EndCompoundEdit(true);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TLMDCustomEditView.InsertInScrollBlock(AScroll: TPoint;
                                const AStr: TLMDString;
                                out AMaxWidth: Integer;
                                out AStartOffset, AEndOffset: Integer);
var
  StartPt, EndPt: TOffsetPoint;
begin
  InsertInScrollBlock(AScroll, AStr, AMaxWidth, StartPt, EndPt);

  AStartOffset := StartPt.Offset;
  AEndOffset := EndPt.Offset;
end;

procedure TLMDCustomEditView.InsertInScrollBlock( AScroll: TPoint;
                                                  const AStr: TLMDString;
                                                  out AMaxWidth: Integer;
                                                  out AStartOffset,
                                                      AEndOffset: TOffsetPoint);
var
  S: TLMDString;
  i, i0, X, Y, Y0: Integer;
  OffS, OffE: Integer;
  P1, P2: TPoint;
begin
  AMaxWidth := 0;

  if Length(AStr) > 0 then
  begin
    FDocInternal.BeginCompoundAction(FAuthorID, CreateCursorUndoInfo, true);
    try
      AStartOffset := OffsetPt(-1);
      AEndOffset   := OffsetPt(-1);

      X := AScroll.X;
      Y := AScroll.Y;

      i := 1;
      i0 := i;
      while i0 <= Length(AStr) do
      begin
        while (i <= Length(AStr)) and (AStr[i] <> LMDCR) and
              (AStr[i] <> LMDLF)
        do
          Inc(i);

        if i <> i0 then
        begin
          S := Copy(AStr, i0, i - i0);

          repeat
            Y0 := Y;
            Cache(self).CorrectToLastScroll(Y0);
            if Y <> Y0 then
              MyDoc.Lines.Add('');
          until Y0 = Y;

          InsertInScrollEx(Point(X, Y), S, false, OffS, OffE, false);

          P1 := Cache(self).OffsetToScroll(OffS);
          P2 := Cache(self).OffsetToScroll(OffE);
          if P2.X >= P1.X then
            AMaxWidth := Max(AMaxWidth, P2.X - P1.X);

          if AStartOffset.Offset = -1 then
            AStartOffset := OffsetPt(OffS);

          AEndOffset := OffsetPt(OffE);
        end;

        if i <= Length(AStr) then
        begin
          if AStr[i] = LMDLF then
            Inc(i)
          else if AStr[i] = LMDCR then
          begin
            Inc(i);
            if (i <= Length(AStr)) and (AStr[i] = LMDLF) then
              Inc(i);
          end
          else
            Assert(false);
        end;

        i0 := i;
        Inc(Y);
      end;
    finally
      MyDoc.EndCompoundEdit(true);
    end;
  end
  else
  begin
    AStartOffset := Cache(self).ScrollPtToOffsetPt(AScroll);
    AEndOffset := AStartOffset;
  end;
end;

procedure TLMDCustomEditView.InsertInScrollEx(AScroll: TPoint;
                                              const AStr: TLMDString;
                                              out AStartOffset,
                                                  AEndOffset: Integer);
begin
  InsertInScrollEx(AScroll, AStr, false, AStartOffset, AEndOffset, true);
end;


procedure TLMDCustomEditView.ReplaceInScroll(AScrollStart, AScrollEnd: TPoint;
                                             const AStr: TLMDString);
var Dummy: Integer;
begin
  CheckNotReadOnly;
  ReplaceInScrollEx(AScrollStart, AScrollEnd, AStr, Dummy, Dummy);
end;

procedure TLMDCustomEditView.ReplaceInScrollEx(AScrollStart, AScrollEnd: TPoint;
                                               const AStr: TLMDString;
                                               out AStartOffset,
                                                   AEndOffset: Integer);
begin
  ReplaceInScrollEx(AScrollStart, AScrollEnd, AStr, false,
                    AStartOffset, AEndOffset);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.InsertInScroll(AScroll: TPoint;
                                            const AStr: TLMDString);
var Dummy: Integer;
begin
  CheckNotReadOnly;

  InsertInScrollEx(AScroll, AStr, Dummy, Dummy);
end;

{------------------------------------------------------------------------------}

procedure InsSpacesAt(ASpaces, AOffset: Integer; AInfo: TLMDDocUndoInfo;
                      AView: TLMDCustomEditView);
begin
  AView.FDocInternal.InsertStr(AOffset,
                               LMDFillString(ASpaces, LMDSpace),
                               AView.AuthorID, AInfo);
end;

{------------------------------------------------------------------------------}

//UD-D-L+S+
procedure TLMDCustomEditView.InsertInScrollEx(AScroll: TPoint;
                                              const AStr: TLMDString;
                                              RememberCursor: Boolean;
                                              out AStartOffset,
                                                  AEndOffset: Integer;
                                              AWithSpacesBefore: Boolean);
var
  Off, Left, Right, Spaces: Integer;
  OffsetPt: TOffsetPoint;
  Compound: Boolean;
  info:     TLMDDocUndoInfo;
  Last: TOffsetPoint;
begin
  CheckDocumentIsSet;

  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplAll);
    RemoveInternalState(siIncrementalSearch);

    Cache(Self).CheckScrollPosForOffset(AScroll);

    if RememberCursor then
      info := CreateCursorUndoInfo
    else
      info := nil;

    Compound := False;

    OffsetPt := Cache(Self).ScrollPtToOffsetPt(AScroll);
    Off := OffsetPt.Offset;

    Cache(Self).GetScrollCharScrollBounds(AScroll, Left, Right);
    Last := Cache(Self).GetScrollLineOffLast(AScroll.Y);

    AStartOffset := Off;

    Assert(OffsetPt.Offset <= Last.Offset);

    if CmpOffsetPt(OffsetPt, Last) > 0 then
    begin
      Assert(OffsetPt.Offset = Last.Offset);

      Spaces := OffsetPt.InCharOffset - Last.InCharOffset;
      Compound := True;

      FDocInternal.BeginCompoundAction(AuthorID, info, true);
      info := nil;
      InsSpacesAt(Spaces, Off, nil, Self);

      Inc(Off, Spaces);
      if not AWithSpacesBefore then
        AStartOffset := Off;

      FDocInternal.InsertStr(Off, AStr, AuthorID, info);
      Inc(Off, Length(AStr));
    end
    else if Left <> AScroll.X then
    begin
      Compound := True;
      FDocInternal.BeginCompoundAction(AuthorID, info, true);

      FDocInternal.Delete(Off, 1, AuthorID, nil);

      Spaces := AScroll.X - Left;
      Assert(Spaces > 0);
      InsSpacesAt(Spaces, Off, nil, Self);

      Inc(Off, Spaces);

      FDocInternal.InsertStr(Off, AStr, AuthorID, nil);
      Inc(Off, Length(AStr));

      Spaces := Right - AScroll.X;
      Assert(Spaces >= 0);
      InsSpacesAt(Spaces, Off, nil, Self);
    end
    else
    begin
      FDocInternal.InsertStr(Off, AStr, AuthorID, info);
      Inc(Off, Length(AStr));
    end;

    AEndOffset := Off;

    if Compound then
      MyDoc.EndCompoundEdit;
  finally
    EndUpdate;
  end
end;

{------------------------------------------------------------------------------}

//UD-D-L-S+
procedure TLMDCustomEditView.ReplaceInScrollEx(AScrollStart, AScrollEnd: TPoint;
                                               const AStr: TLMDString;
                                               RememberCursor: Boolean;
                                               out AStartOffset,
                                                   AEndOffset: Integer);
var
  OffsetS, OffsetE: Integer;
  LeftS, RightS, LeftE, RightE, SpacesBefore, SpacesAfter: Integer;
  Compound: Boolean;
  info:     TLMDDocUndoInfo;
begin
  CheckDocumentIsSet;

  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplAll);
    RemoveInternalState(siIncrementalSearch);

    Cache(Self).CheckScrollRangeForOffset(AScrollStart, AScrollEnd);

    if RememberCursor then
      info := CreateCursorUndoInfo
    else
      info := nil;

    OffsetS := Cache(Self).ScrollToNearestOffset(AScrollStart);
    OffsetE := Cache(Self).ScrollToNearestOffset(AScrollEnd);

    Cache(Self).GetScrollCharScrollBounds(AScrollStart, LeftS, RightS);
    Cache(Self).GetScrollCharScrollBounds(AScrollEnd, LeftE, RightE);

    SpacesBefore := AScrollStart.X - LeftS;
    if AScrollEnd.X <> LeftE then
      SpacesAfter := RightE - AScrollEnd.X
    else
      SpacesAfter := 0;

    Compound := (SpacesBefore>0) or (SpacesAfter>0) or (Length(AStr)>0);
    if Compound then
    begin
      FDocInternal.BeginCompoundAction(AuthorID, info, true);
      info := nil;
    end;

    if SpacesAfter>0 then
      Inc(OffsetE);

    AStartOffset := OffsetS;

    FDocInternal.Delete(OffsetS, OffsetE-OffsetS, AuthorID, info);

    if Compound then
    begin
      InsSpacesAt(SpacesBefore, OffsetS, info, Self);
      Inc(OffsetS, SpacesBefore);

      if Length(AStr) > 0 then
        FDocInternal.InsertStr(OffsetS, AStr, AuthorID, info);

      Inc(OffsetS, Length(AStr));
      AEndOffset := OffsetS;

      InsSpacesAt(SpacesAfter, OffsetS, info, Self);

      MyDoc.EndCompoundEdit;
    end
    else
      AEndOffset := OffsetS;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DeleteSelected; //UD-L-S+C+
var
  SelS, SelE:  TPoint;
  OffsetPt: TOffsetPoint;
  SelBlock: Boolean;
begin
  if (not SelAvail) then
    Exit;

  CheckDocumentIsSet;
  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    SelS := GetSelStartNorm;
    SelE := GetSelEndNorm;

    SelBlock := Cache(self).SelBlockMode;
    CancelSelection;

    if SelBlock then
      DeleteInScrollBlock(SelS, SelE, OffsetPt)
    else
      DeleteInScrollEx(SelS, SelE, True, OffsetPt);

    CursorPos := Cache(self).OffsetPtToScrollPt(OffsetPt);
    ScrollToCursorLow(true);
    CancelSelection;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SelectAll;
begin
  RemoveInternalState(siComplIncSearch);

  SetSelection(0, MyDoc.CharsCount, false);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CopySelection;
var
  Seq: TLMDCharSeq;
begin
  if not SelAvail then
    Exit;

  CheckDocumentIsSet;

  Seq := CreateScrollTextSeqAdapter(SelStartN, SelEndN, SelectionBlockMode);

  try
    LMDSetClipboardText(LMDSegment(0, Seq.Count, Seq), SelectionBlockMode);
  finally
    Seq.Free;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CutSelection;
begin
  if not SelAvail then
    Exit;

  CheckNotReadOnly;
  CheckDocumentIsSet;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    CopySelection;
    DeleteSelected;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.Paste;
var
  Str: TLMDString;
  RectBlock: Boolean;
  Dummy, EndOffset: Integer;
begin
  CheckNotReadOnly;
  CheckDocumentIsSet;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    LMDGetClipboardText(Str, RectBlock);

    if Length(Str) > 0 then
    begin
      EndOffset := -1;
      FDocInternal.BeginCompoundAction(FAuthorID, CreateCursorUndoInfo, true);
      try
        if RectBlock then
          InsertInScrollBlock(CursorPos, Str, Dummy, Dummy, EndOffset)
        else
          InsertAtCursor(Str, False);
      finally
        MyDoc.EndCompoundEdit(true);

        if EndOffset <> -1 then
        begin
          CursorOffset := EndOffset;
          ScrollToCursor;
        end;
      end;
    end;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function GetIndentEndPhysLine(AView: TLMDCustomEditView;
                              AScroll: TPoint): Integer;
var
  Seg: TLMDSegment;
  Ph, Off: Integer;
begin
  Off := AView.ScrollPosToNearestOffset(AScroll);
  Ph := AView.MyDoc.GetLineByOffset(Off);
  Seg := AView.MyDoc.LineSegments[Ph];

  if Seg.Start=Off then
    Result := AView.GetPrevVisibleLine(Ph)
  else
    Result := Ph;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.IndentSelection(AUsePrevIndent: Boolean);
begin
  UI_IndentSelection(false, AUsePrevIndent);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UI_IndentSelection(AUnindent, AUsePrevIndent: Boolean);
var Ph, PhE, NoSp: Integer;
    Seg: TLMDSegment;
    Ok: Boolean;
    CurW, FoundW: Integer;
    Diff: Integer;
    S: TLMDString;
begin
  CheckNotReadOnly;
  CheckDocumentIsSet;

  Ph := ScrollToPhysical(SelStartN.Y);

  if not LMDPointsEqual(SelStartN, SelEndN) then
    PhE := GetIndentEndPhysLine(self, SelEndN)
  else
    PhE := ScrollToPhysical(SelEndN.Y);

  PhE := GetNextVisibleLine(PhE);

  MyDoc.BeginCompoundEdit;
  try
    RemoveInternalState(siComplIncSearch);

    MoveCursorAndSelToBounds;

    NoSp := FindNoSpaceOffset(Ph, false);
    if NoSp <> -1 then
      CurW := Cache(self).CalkPointVisWidth(NoSp)
    else
      CurW := 0;

    if AUsePrevIndent then
    begin
      Ok := (Ph > 0) and
            FindIndentSeg(GetPrevVisibleLine(Ph), CurW, not AUnindent, FoundW, Seg);

      if Ok then
        Diff := FoundW - CurW
      else if AUnindent then
        Diff := - CurW
      else
        Diff := IndentWidth;
    end
    else if AUnindent then
      Diff := - Min(IndentWidth, CurW)
    else
      Diff := IndentWidth;

    while Ph < PhE do
    begin
      Seg := MyDoc.LineSegments[Ph];

      NoSp := FindNoSpaceOffset(Ph, false);
      if NoSp<>-1 then
      begin
        CurW := CacheDelayed(self).CalkPointVisWidth(NoSp);

        S := LMDFillString(Max(CurW + Diff, 0), LMDSpace);

        MyDoc.Replace(Seg.Start, NoSp-Seg.Start, S);
      end;

      Inc(Ph);
    end;
  finally
    MyDoc.EndCompoundEdit;
  end;
end;

procedure TLMDCustomEditView.UnindentSelection(AUsePrevIndent: Boolean);
begin
  UI_IndentSelection(true, AUsePrevIndent);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetCanCopy: Boolean;
begin
  result := IsDocumentSet and SelAvail;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetCanPaste: Boolean;
begin
  result := IsDocumentSet and LMDCanGetClipboardText and (not IsReadOnly);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetCanCut: Boolean;
begin
  result := IsDocumentSet and SelAvail and (not IsReadOnly);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.CreateScrollTextSeqAdapter(AScrollStart,
                          AScrollEnd: TPoint; ABlock: Boolean): TLMDCharSeq;
var
  OffsetS, OffsetE: Integer;
  LeftS, RightS, LeftE, RightE, SpacesBefore, SpacesAfter: Integer;
  Seq: TSpacedSeq;
begin
  CheckDocumentIsSet;

  Cache(Self).CheckScrollRangeForOffset(AScrollStart, AScrollEnd);

  if ABlock then
    Result := TSquaredSeq.Create(self, AScrollStart, AScrollEnd)
  else
  begin
    OffsetS := Cache(Self).ScrollToNearestOffset(AScrollStart);
    OffsetE := Cache(Self).ScrollToNearestOffset(AScrollEnd);

    Cache(Self).GetScrollCharScrollBounds(AScrollStart, LeftS, RightS);
    Cache(Self).GetScrollCharScrollBounds(AScrollEnd, LeftE, RightE);

    SpacesBefore := 0;

    if AScrollStart.X <> LeftS then
    begin
      SpacesBefore := RightS - AScrollStart.X;
      Inc(OffsetS);
    end;

    SpacesAfter := AScrollEnd.X - LeftE;
    if SpacesAfter > 0 then
      Dec(OffsetE);

    Seq := TSpacedSeq.Create;
    Seq.Reset(LMDSegment(OffsetS, OffsetE-OffsetS, MyDoc.Chars),
              SpacesBefore, SpacesAfter);

    Result := Seq;
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.UI_GetCursorMovePoint(ADirection: TLMDCursorMoveDirection;
                                                   AUnit: TLMDCursorMoveUnit;
                                                   AWithSel, ABlock: Boolean): TPoint;
begin
  Result := UI_GetCursorMovePoint(CursorPos, ADirection, AUnit, AWithSel, ABlock);
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.UI_GetCursorMovePoint(APoint: TPoint;
                                         ADirection: TLMDCursorMoveDirection;
                                         AUnit: TLMDCursorMoveUnit;
                                         AWithSel, ABlock: Boolean): TPoint;

  function FitsLine(X, Y: Integer; ForceCut:Boolean;
                    out MaxX: Integer): Boolean;
  var
      Inf: TScrollLineInfo;
      Last, OffPt: TOffsetPoint;
      BoundChars: Boolean;
  begin
    MaxX := 0;
    Result := false;

    if X < 0 then
      Exit;

    BoundChars := (vsCursorBoundToChars in ViewSettings) and
                  (not ABlock);

    OffPt := Cache(self).ScrollPtToOffsetPt(Point(X, Y));
    Last := Cache(self).GetScrollLineOffLast(Y);

    Result := CmpOffsetPt(OffPt, Last) <= 0;
    if not Result then
    begin
      MaxX := Cache(self).OffsetPtToScrollPt(Last).X;
      Inf := Cache(Self).GetScrollLineInfo(Y);

      Result := not (ForceCut or
                     (not (lpLastWrap in Inf.VisProps)) or
                     BoundChars);
    end;
  end;

  function CutXToMax(X, Y: Integer; ForceCut: Boolean): Integer;
  var
      MaxX: Integer;
  begin
    if FitsLine(X, Y, ForceCut, MaxX) then
      Result := X
    else
      Result := MaxX;
  end;

var
  HaveNextLine: Boolean;
  Cnt, WordS: Integer;
  X, Y: Integer;
  OffPt, CurLast: TOffsetPoint;
  Add: Integer;
  MaxX: Integer;
  XPix, XPCnt: Integer;
  Inf: TScrollLineInfo;
begin
  Result := LMDBadPoint;

  if ADirection = mdForward then
    Add := 1
  else
    Add := -1;

  HaveNextLine := (APoint.Y + Add >= 0) and
                  (not Cache(Self).AfterLastScroll(APoint.Y+Add));

  if AWithSel then
    HaveNextLine := HaveNextLine and
                    ((not ABlock) or (AUnit = muLine));

  case AUnit of
    muLine:
      if HaveNextLine then
      begin
        Cache(self).ScrollPosToScreenPix(APoint, XPix, XPCnt);

        Y := APoint.Y+Add;

        X := Cache(self).ScreenPixToScrollPos(XPix, Y);

        Result := Point(CutXToMax(X, Y, false), Y);
      end;

    muChar:
    begin
      if FitsLine(APoint.X+Add, APoint.Y, false, MaxX) then
      begin
        Result := Point(APoint.X + Add, APoint.Y);
        case ADirection of
          mdForward: Cache(self).CorrectScrollPoint(Result, scForCursor,
                                                    scForward, ABlock);
          mdBackward: Cache(self).CorrectScrollPoint(Result, scForCursor,
                                                     scBackward, ABlock);
        else
          Assert(false);
        end;
      end
      else if HaveNextLine then
      begin
        Y := APoint.Y + Add;

        case ADirection of
          mdForward: Result := Point(0, Y);
          mdBackward: Result := Point(CutXToMax(MaxInt, Y, true), Y);
        end;
      end;
    end;

    muWord:
    begin
      OffPt := Cache(self).ScrollPtToOffsetPt(APoint);
      Inf := Cache(self).GetScrollLineInfo(APoint.Y);

      if ADirection = mdForward then
      begin
        Cnt := LMDSegEnd(Inf.ContentSegment) + 1 - OffPt.Offset;
        WordS := MyDoc.FindNextWordStart(OffPt.Offset, Cnt);
      end
      else
      begin
        Cnt := OffPt.Offset - Inf.ContentSegment.Start + 1;
        WordS := MyDoc.FindPrevWordStart(OffPt.Offset, Cnt);
      end;

      if WordS = -1 then
      begin
        case ADirection of
          mdForward:
          begin
            CurLast := Cache(self).GetScrollLineOffLast(APoint.Y);

            if CmpOffsetPt(OffPt, CurLast) < 0 then
              Result := Cache(self).OffsetPtToScrollPt(CurLast)
            else if HaveNextLine then
            begin
              Y := APoint.Y + Add;

              Inf := Cache(self).GetScrollLineInfo(Y);

              Cnt := Inf.ContentSegment.Count;
              WordS := MyDoc.FindNextWordStart(Inf.ContentSegment.Start, Cnt);

              if WordS = -1 then
                Result := Point(0, Y)
              else
                Result := OffsetToScrollPos(WordS);
            end;
          end;

          mdBackward:
          begin
            if HaveNextLine then
            begin
              Y := APoint.Y + Add;
              Result := Point(CutXToMax(MaxInt, Y, true), Y);
            end
            else if APoint.X > 0 then
              Result := Point(0, APoint.Y);
          end;
        end;
      end
      else
        Result := OffsetToScrollPos(WordS);
    end;
  end;
end;

procedure TLMDCustomEditView.UI_IndentOrTab;
var
    Ln: Integer;
    Pt: TPoint;
    Ok: Boolean;
    CurW: Integer;
    FoundW: Integer;
    FoundSeg: TLMDSegment;
    Seg: TLMDSegment;
    Off: Integer;
    Overwrite: Boolean;
begin
  Ln := ScrollToPhysical(CursorPosY);
  Overwrite := vsOverwrite in ViewSettings;

  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplAll);

    Off := FindNoSpaceOffset(Ln);

    if ((Off <> -1) and (Off < CursorOffset)) or (Ln = 0) or SelAvail then
      InvokeCommand(sedTab, false)
    else
    begin
      if Overwrite then
        CurW := CursorPosX
      else
        CurW := Cache(self).CalkPointVisWidth(CursorOffset);

      Ok := FindIndentSeg(GetPrevVisibleLine(Ln), CurW, true, FoundW, FoundSeg);
      if Ok then
      begin
        if (not Overwrite) or (CurW < FoundW) then
        begin
          if Overwrite then
          begin
            Pt := Point(FoundW, CursorPosY);
            Cache(self).CorrectScrollPoint(Pt, scForCursor, scBackward, false);

            if LMDPointsEqual(Pt, CursorPos) then
              InvokeCommand(sedTab, false)
            else
            begin
              FDocInternal.PushCustomAction(FAuthorID, CreateCursorUndoInfo);
              CursorPosX := FoundW;

              ScrollToCursorLow(false);
            end;
          end
          else
          begin
            Seg := MyDoc.LineSegments[Ln];

            MyDoc.ReplaceSeg(Seg.Start, CursorOffset-Seg.Start, FoundSeg);
            MoveCursorAndSelToBounds;

            ScrollToCursorLow(false);
          end;
        end
        else
          InvokeCommand(sedTab, false);
      end
      else
        InvokeCommand(sedTab, false);
    end;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UI_MoveCursorToOffGen(AOffPt: TOffsetPoint;
  AWithSel, ABlock: Boolean);
begin
  BeginUpdate;
  try
    Cache(self).SetCursorOffset(AOffPt, scForward, ABlock);

    if AWithSel then
      Cache(self).SetSelection(Cache(self).SelStartOffset, AOffPt, ABlock)
    else
      Cache(self).SetSelection(AOffPt, AOffPt, false);

    ScrollToCursorLow(true);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.UI_MoveCursorTo(ADirection: TLMDCursorMoveDirection;
                                             AUnit: TLMDCursorMoveUnit;
                                             AWithSel, ABlock: Boolean): Boolean;
var
  NewCr: TPoint;
begin
  Result := False;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    ScrollToCursorLow(false);

    NewCr := UI_GetCursorMovePoint(ADirection, AUnit, AWithSel, ABlock);
    if LMDIsBadPoint(NewCr) then
      Beep
    else
    begin
      SetCursorPosEx(NewCr, Ord(scBackward), ABlock);
      ScrollToCursorLow(false);

      if AWithSel and IsDocumentSet then
        SetSelection(SelectionStart, CursorPos, ABlock)
      else
        CancelSelection;

      Result := True;
    end;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToNextWord(AWithSelect, ABlock: Boolean);
begin
  UI_MoveCursorTo(mdForward, muWord, AWithSelect, ABlock)
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToPrevWord(AWithSelect, ABlock: Boolean);
begin
  UI_MoveCursorTo(mdBackward, muWord, AWithSelect, ABlock)
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToNextChar(AWithSelect, ABlock: Boolean);
begin
  UI_MoveCursorTo(mdForward, muChar, AWithSelect, ABlock)
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToPrevChar(AWithSelect, ABlock: Boolean);
begin
  UI_MoveCursorTo(mdBackward, muChar, AWithSelect, ABlock)
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToNextLine(AWithSelect, ABlock: Boolean);
begin
  UI_MoveCursorTo(mdForward, muLine, AWithSelect, ABlock)
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToPrevLine(AWithSelect, ABlock: Boolean);
begin
  UI_MoveCursorTo(mdBackward, muLine, AWithSelect, ABlock)
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UI_MoveCursorByPage(ADown, AWithSelect, ABlock: Boolean);
var
  NewFirst, Add, Y: Integer;
begin
  BeginUpdate;
  try
    if ADown then
      Add := 1
    else
      Add := -1;

    NewFirst := TopLineScroll + (Cache(self).ScreenHeightLines * Add);

    Y := Max(0, CursorPosY + (NewFirst - TopLineScroll));
    Cache(self).CorrectToLastScroll(Y);

    CursorPosY := Y;

    ScrollVertWithCode(NewFirst - TopLineScroll, scPosition, False);

    if AWithSelect then
      SetSelection(SelectionStart, CursorPos, ABlock)
    else
      CancelSelection;

    ScrollToCursorLow(false);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToNextPage(AWithSelect, ABlock: Boolean);
begin
  UI_MoveCursorByPage(True, AWithSelect, ABlock);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveCursorAndSelToBounds;
begin
  BeginUpdate;
  try
    CursorPos := OffsetToScrollPos(CursorOffset);
    SelectionStart := OffsetToScrollPos(SelectionOffsetStart);
    SelectionEnd := OffsetToScrollPos(SelectionOffsetEnd);
  finally
    EndUpdate;
  end;
end;

procedure TLMDCustomEditView.MoveToFirstScreenLine(AWithSelect, ABlock: Boolean);
begin
  BeginUpdate;
  try
    CursorPosY := TopLineScroll;

    if AWithSelect then
      SetSelection(SelectionStart, CursorPos, ABlock)
    else
      CancelSelection;
  finally
    EndUpdate;
  end;
end;

function TLMDCustomEditView.MoveToIndentPos(AMovePoint: TPoint;
                                            ABackward: Boolean): Boolean;

function GetPos(ALine: Integer; out AOffset: Integer): Integer;
var
    Seg: TLMDSegment;
begin
  Seg := MyDoc.LineSegments[ALine];

  AOffset := LMDSeqPosOneNotOf(AllSpaces, Seg.Source, Seg.Start, Seg.Count);

  if AOffset <> -1 then
    Result := Cache(self).CalkPointVisWidth(AOffset)
  else
    Result := 0;
end;

var
    Ln, PrevLn, LnStart: Integer;
    Pos, Off, PrevPos: Integer;
    Str: TLMDString;
    Seg: TLMDSegment;
    P0: TPoint;
begin
  MyDoc.BeginCompoundEdit(true);
  try
    RemoveInternalStateForPublics(siComplAll);

    Ln := ScrollToPhysical(AMovePoint.Y);

    InvokeCommand(sedChar, ' ', false);
    InvokeCommand(sedDeletePrevChar, false);

    Pos := Cache(self).CalkPointVisWidth(CursorOffset);

    PrevLn := Ln-1;
    if PrevLn >= 0 then
      PrevPos := GetPos(PrevLn, Off)
    else
    begin
      PrevPos := 0;
      Off := -1;
    end;

    if ABackward then
    begin
      while (PrevLn>0) and ((Pos<=PrevPos) or (Off=-1))
      do
      begin
        Dec(PrevLn);
        PrevPos := GetPos(PrevLn, Off);
      end;

      if (PrevLn=-1) or (Off=-1) then
        Str := ''
      else
      begin
        LnStart := MyDoc.LineSegments[PrevLn].Start;
        Seg := LMDSegment(LnStart, Off-LnStart, MyDoc.Chars);
        Str := LMDSegToString(Seg);
      end;

      Result := true;
    end
    else
    begin
      while (PrevLn>0) and (Off=-1) do
      begin
        Dec(PrevLn);
        PrevPos := GetPos(PrevLn, Off);
      end;

      Result := (PrevLn<>-1) and (Off<>-1) and (PrevPos > Pos);
      if Result then
      begin
        LnStart := MyDoc.LineSegments[PrevLn].Start;
        Seg := LMDSegment(LnStart, Off-LnStart, MyDoc.Chars);
        Str := LMDSegToString(Seg);
      end;
    end;

    if Result then
    begin
      P0 := Point(0, PhysicalToScroll(Ln));

      ReplaceInScroll(P0, AMovePoint, Str);
    end;
  finally
    MyDoc.EndCompoundEdit(true);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToLastScreenLine(AWithSelect, ABlock: Boolean);
begin
  BeginUpdate;
  try
    CursorPosY := TopLineScroll + LinesOnScreenScroll - 1;

    if AWithSelect then
      SetSelection(SelectionStart, CursorPos, ABlock)
    else
      CancelSelection;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToPrevPage(AWithSelect, ABlock: Boolean);
begin
  UI_MoveCursorByPage(False, AWithSelect, ABlock);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToLineStart(AWithSelect, ABlock: Boolean);
var
    OffPt: TOffsetPoint;
begin
  OffPt.Offset := Cache(self).GetScrollLineOffStart(CursorPosY);
  OffPt.InCharOffset := 0;

  UI_MoveCursorToOffGen(OffPt, AWithSelect, ABlock);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToLineEnd(AWithSelect, ABlock: Boolean);
begin
  UI_MoveCursorToOffGen(Cache(self).GetScrollLineOffLast(CursorPosY),
                        AWithSelect, ABlock);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToTextStart(AWithSelect, ABlock: Boolean);
begin
  UI_MoveCursorToOffGen(OffsetPt(0), AWithSelect, ABlock);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MoveToTextEnd(AWithSelect, ABlock: Boolean);
begin
  UI_MoveCursorToOffGen(OffsetPt(MyDoc.CharsCount), AWithSelect, ABlock);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.ScrollUp;
begin
  UI_ScrollUpDown(True);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.ScrollDown;
begin
  UI_ScrollUpDown(False);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.InsertTabAtCursor(AOverwrite: Boolean);
var
  NextTab, TabSz: Integer;
  OutWrap:        Boolean;
  NewCr:          TPoint;
  Str:            TLMDString;
  Last, OffPt:    TOffsetPoint;
begin
  if not AOverwrite then
    CheckNotReadOnly;

  CheckDocumentIsSet;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    NextTab := CursorPosX + GetTabWidth(CursorPosX, TabWidth);

    if AOverwrite then
    begin
      OffPt := Cache(self).ScrollPtToOffsetPt(Point(NextTab, CursorPos.Y));
      Last  := Cache(self).GetScrollLineOffLast(CursorPos.Y);
      Assert(OffPt.Offset <= Last.Offset);

      OutWrap := (not NoWrap) and (CmpOffsetPt(OffPt, Last) >= 0);

      CancelSelection;

      NewCr := LMDBadPoint;

      if not OutWrap then
        NewCr := Point(NextTab, CursorPosY)
      else if not Cache(self).AfterLastScroll(CursorPos.Y+1) then
        NewCr := Point(0, CursorPos.Y+1)
      else
        Beep;

      if not LMDIsBadPoint(NewCr) then
      begin
        FDocInternal.PushCustomAction(AuthorID, CreateCursorUndoInfo);
        CursorPos := NewCr;

        ScrollToCursorLow(false);
      end;
    end
    else
    begin
      if vsUseTabs in ViewSettings then
        Str := LMDTab
      else
      begin
        TabSz := NextTab - CursorPosX;
        Assert(TabSz > 0);
                
        Str := LMDFillString(TabSz, LMDSpace);
      end;

      InsertAtCursor(Str, False);
      ScrollToCursorLow(false);      
      CancelSelection;
    end;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.InsertReturnAtCursor(AOverwrite: Boolean);
var
  Dummy, EndOffset: Integer;
  Str: TLMDString;
  Ph, CntB, CntF, Off: Integer;
  LineSeg: TLMDSegment;
  InsPoint, NewCr, ReplS,ReplE: TPoint;
  Indent: TLMDString;
  SpacesLeft, SpacesRight, BeyEnd,
  CutSpaces, DoCut: Boolean;
  CrOff, LastOff: TOffsetPoint;
begin
  CheckDocumentIsSet;

  Indent := '';

  if vsAutoIndent in ViewSettings then
  begin
    Ph := MyDoc.GetLineByOffset(CursorOffset);
    Indent := FindIndentStr(Ph, 0, true);
  end;

  CutSpaces := not (vsKeepBlanks in ViewSettings);
  DoCut := false;

  FDocInternal.BeginCompoundAction(FAuthorID, CreateCursorUndoInfo, true);
  try
    RemoveInternalState(siComplIncSearch);

    InsPoint := CursorPos;
    NewCr := LMDBadPoint;

    Ph := ScrollToPhysical(CursorPosY);
    LineSeg := MyDoc.LineSegments[Ph];
    CntB := CursorOffset - Lineseg.Start;
    CntF := LMDSegEnd(Lineseg) - CursorOffset + 1;

    LastOff := Cache(self).GetScrollLineOffLast(CursorPosY);
    CrOff := Cache(self).CursorOffset;

    BeyEnd := CmpOffsetPt(CrOff, LastOff) > 0;
    SpacesRight := (not BeyEnd) and
                   (LMDSeqPosOneNotOf(AllSpaces, LineSeg.Source,
                                      CrOff.Offset, CntF)=-1);

    SpacesLeft := (not BeyEnd) and (CrOff.Offset > 0) and
                  (LMDSeqPosOneNotOfBack(AllSpaces, LineSeg.Source,
                                         CrOff.Offset-1, CntB)=-1);

    if LineSeg.Count=0 then
    begin
      InsPoint := Point(0, CursorPos.Y);
      NewCr := LMDBadPoint;
    end
    else if (CrOff.Offset = LineSeg.Start) or SpacesLeft then
    begin
      if CutSpaces then
      begin
        InsPoint := OffsetToScrollPos(LineSeg.Start);
        NewCr := Point(CursorPos.X, CursorPos.Y + 1);
        Indent := '';
      end
      else
      begin
        if SpacesRight then
        begin
          InsPoint := OffsetToScrollPos(CrOff.Offset);
          NewCr := LMDBadPoint;
        end
        else
        begin
          InsPoint := OffsetToScrollPos(LineSeg.Start);
          NewCr := Point(CursorPos.X, CursorPos.Y + 1);
          Indent := '';
        end;
      end;
    end
    else
    begin
      if BeyEnd then
        InsPoint := OffsetToScrollPos(CursorOffset)
      else
        InsPoint := CursorPos;

      NewCr := LMDBadPoint;
    end;

    Str := MyDoc.LineSeparatorStr+Indent;

    if DoCut then
      ReplaceInScrollEx(ReplS, ReplE, Str, true, Dummy, EndOffset)
    else
      InsertInScrollEx(InsPoint, Str, true, Dummy, EndOffset, true);

    EnsureOffsetIsVisible(EndOffset);
    if not LMDIsBadPoint(NewCr) then
      CursorPos := NewCr
    else
      CursorOffset := EndOffset;

    Cache(Self).SetDirtyScroll(CursorPos.Y - 1); // EB: Update current-line
    Cache(Self).SetDirtyScroll(CursorPos.Y);     //     background, in case the line
                                                 //     itself was not changed, e.g.
                                                 //     when cursor was at the end of
                                                 //     line.
    ScrollToCursorLow(false);

    CancelSelection;

    if CutSpaces then
    begin
      Ph := MyDoc.GetLineByOffset(CursorOffset);
      LineSeg := MyDoc.LineSegments[Ph];

      CntF := LMDSegEnd(LineSeg) - CursorOffset + 1;
      Off := LMDSeqPosOneNotOf(AllSpaces, LineSeg.Source, CursorOffset, CntF);

      if Off = -1 then
        MyDoc.Delete(CursorOffset, CntF);

      LineSeg := MyDoc.LineSegments[Ph-1];

      if LineSeg.Count > 0 then
        Off := LMDSeqPosOneNotOfBack(AllSpaces, LineSeg.Source,
                                     LMDSegEnd(LineSeg), LineSeg.Count)
      else
        Off := -1;

      if Off = -1 then
        Off := LineSeg.Start - 1;

      MyDoc.Delete(Off+1, LMDSegEnd(LineSeg) - Off);
    end;
  finally
    MyDoc.EndCompoundEdit(true);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.InsertCharAtCursor(AChar: TLMDChar;
                                                ACount: Integer;
                                                AOverwrite: Boolean);
begin
  CheckNotReadOnly;
  CheckDocumentIsSet;

  InsertAtCursor(LMDFillString(ACount, AChar), AOverwrite);
end;

{------------------------------------------------------------------------------}


procedure TLMDCustomEditView.InsertAtCursor(const AStr: TLMDString;
                                            AOverwrite: Boolean);
var
  Dummy, EndOffset, OffD, CurY, CurX: Integer;
  AtWrap: Boolean;
  LineInfo: TScrollLineInfo;
  CurOff, LastOff: TOffsetPoint;
begin
  CheckNotReadOnly;
  CheckDocumentIsSet;

  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplAll);
    RemoveInternalState(siIncrementalSearch);

    ScrollToCursorLow(false);

    CurY := CursorPos.Y;
    CurX := CursorPos.X;
    CurOff := Cache(self).CursorOffset;
    LastOff := Cache(Self).GetScrollLineOffLast(CurY);

    LineInfo := Cache(Self).GetScrollLineInfo(CurY);

    OffD := CmpOffsetPt(CurOff, LastOff);
    AtWrap := (not (lpLastWrap in LineInfo.VisProps)) and (OffD=0);

    if SelAvail then
    begin
      MyDoc.BeginCompoundEdit;
      try
        DeleteSelected;
        InsertInScrollEx(CursorPos, AStr, True, Dummy, EndOffset, true);
      finally
        MyDoc.EndCompoundEdit;
      end;
    end
    else if AOverwrite and ((OffD < 0) or AtWrap) then
      ReplaceInScrollEx(CursorPos, Point(CurX+1, CurY), AStr, True, Dummy, EndOffset)
    else
      InsertInScrollEx(CursorPos, AStr, True, Dummy, EndOffset, true);

    EnsureOffsetIsVisible(EndOffset);
    CursorOffset := EndOffset;

    CancelSelection;
    ScrollToCursorLow(false);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UI_Delete(ADirection: TLMDCursorMoveDirection;
                                       AUnit: TLMDCursorMoveUnit);
var
  NewCr, OldCr: TPoint;
  Str: TLMDString;
  Handled: Boolean;
  Spaces, StartOffset, EndOffset, CrPh: Integer;
  Info: TScrollLineInfo;
  LastOff, CrOff: TOffsetPoint;
  CrDiff: Integer;
begin
  CheckNotReadOnly;
  CheckDocumentIsSet;

  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplAll);
    RemoveInternalState(siIncrementalSearch);

    CancelSelection;

    Handled := False;

    Info    := Cache(Self).GetScrollLineInfo(CursorPosY);
    LastOff := Cache(Self).GetScrollLineOffLast(CursorPosY);
    CrOff   := Cache(self).CursorOffset;
    CrDiff  := CmpOffsetPt(CrOff, LastOff);

    if (ADirection=mdBackward) and (AUnit=muChar) then
    begin
      //move to last line char, when we are beyond of line end
      Handled := CrDiff > 0;
      if Handled then
      begin
        FDocInternal.PushCustomAction(AuthorID, CreateCursorUndoInfo);
        Cache(self).SetCursorOffset(LastOff, scBackward, false);
      end;
    end;

    if not Handled then
    begin
      Handled := (ADirection = mdForward) and (CrDiff >= 0);//merge two lines
      if Handled then
      begin
        NewCr := LMDBadPoint;
        CrPh := ScrollToPhysical(CursorPosY);

        if (not Cache(self).AfterLastScroll(CursorPosY+1)) or
           IsCollapsedFold(CrPh)
        then
        begin
          if CrPh < MyDoc.LinesCount-1 then
            EnsureVisible(CrPh+1);

          ///
          if AUnit = muWord then
            NewCr := UI_GetCursorMovePoint(ADirection, AUnit, false, false)
          else if AUnit=muChar then
            NewCr := Point(0, CursorPosY+1);

          if not LMDIsBadPoint(NewCr) then
          begin
            if Cache(Self).ScrollToNearestOffset(NewCr)=CrOff.Offset then
              NewCr := UI_GetCursorMovePoint(NewCr, ADirection, AUnit, false, false);

            Assert(not LMDIsBadPoint(NewCr));

            Spaces := CrOff.InCharOffset - LastOff.InCharOffset;
            Str := LMDFillString(Spaces, LMDSpace);

            ReplaceInScrollEx(Cache(self).OffsetPtToScrollPt(LastOff), NewCr,
                              Str, True, StartOffset, EndOffset);

            if Spaces <> 0 then
              SetCursorAsOffset(EndOffset)
            else
              SetCursorAsOffset(StartOffset);
          end;
        end;

        if LMDIsBadPoint(NewCr) then
          Beep;
      end;
    end;

    if not Handled then  //delete to new moving point
    begin
      NewCr := UI_GetCursorMovePoint(ADirection, AUnit, false, false);

      if not LMDIsBadPoint(NewCr) then
      begin
        CrPh := ScrollToPhysical(NewCr.Y);
        while (NewCr.Y<>CursorPosY) and IsCollapsedFold(CrPh) do
        begin
          EnsureVisible(CrPh+1);
          NewCr := UI_GetCursorMovePoint(ADirection, AUnit, false, false);
          CrPh := ScrollToPhysical(NewCr.Y);
        end;

        if (not LMDIsBadPoint(NewCr)) and (NewCr.Y <> CursorPosY) then
          NewCr := UI_GetCursorMovePoint(ADirection, AUnit, false, false);

        if ComparePoints(CursorPos, NewCr) > 0 then
        begin
          OldCr := NewCr;
          NewCr := CursorPos;
        end
        else
          OldCr := CursorPos;

        if not LMDIsBadPoint(NewCr) then
        begin
          DeleteInScrollEx(OldCr, NewCr, True, CrOff);
          SetCursorAsOffset(CrOff.Offset);
        end
        else
          Beep;
      end
      else
        Beep;
    end;

    ScrollToCursorLow(true);

    // EB: Update current-line background in case the actual content of the
    //     screen-line was not changed (so, line was not dirtied by content
    //     comparison routine).

    Cache(Self).SetDirtyScroll(CursorPos.Y);
    if CursorPos.Y < LastLineScroll then
      Cache(Self).SetDirtyScroll(CursorPos.Y + 1);
  finally
    EndUpdate;
  end;
end;

function TLMDCustomEditView.UI_DeleteLine: Boolean;
var
    Pos: TPoint;
    Off, Ln: Integer;
    Seg: TLMDSegment;
begin
  BeginUpdate;

  try
    RemoveInternalStateForPublics(siComplIncSearch);

    Off := CursorOffset;
    Ln := MyDoc.GetLineByOffset(Off);
    Pos := CursorPos;

    Result := MyDoc.CharsCount > 0;
    if Result then
    begin
      Seg := MyDoc.GetLineWithCr(Ln);
      if Seg.Count=0 then
      begin
        Assert(Ln>0);
        Dec(Ln);
        Seg := MyDoc.GetLineWithCr(Ln);
      end;

      FDocInternal.Delete(Seg.Start, Seg.Count,
                          FAuthorID, CreateCursorUndoInfo);
      Pos.Y := PhysicalToScroll(Ln);
      CursorPos := Pos;
    end;
  finally
    EndUpdate;
  end;
end;

function TLMDCustomEditView.UI_DeleteToLineEnd(AToScrollEnd: Boolean): Boolean;
var
    Ph, EndOff, LineW: Integer;
    PEnd: TPoint;
    OffsetPt: TOffsetPoint;
begin
  if AToScrollEnd then
  begin
    LineW := Cache(self).GetScrollLineVisWidth(CursorPosY);

    Result := CursorPosX < LineW;
    if Result then
    begin
      PEnd := Point(LineW, CursorPosY);
      DeleteInScrollEx(CursorPos, PEnd, True, OffsetPt);
    end;
  end
  else
  begin
    Ph := ScrollToPhysical(CursorPosY);
    EndOff := LMDSegEnd(MyDoc.LineSegments[Ph])+1;

    EnsureOffsetIsVisible(EndOff);
    PEnd := OffsetToScrollPos(EndOff);

    Result := (PEnd.Y > CursorPosY) or
              ((PEnd.Y = CursorPosY) and (PEnd.X > CursorPosX));

    if Result then
      DeleteInScrollEx(CursorPos, PEnd, True, OffsetPt);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DeleteCharLeft;
begin
  UI_Delete(mdBackward, muChar)
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DeleteCharRight;
begin
  RemoveInternalState(siComplIncSearch);

  UI_Delete(mdForward, muChar)
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DeleteWordLeft;
begin
  RemoveInternalState(siComplIncSearch);

  UI_Delete(mdBackward, muWord)
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DeleteWordRight;
begin
  RemoveInternalState(siComplIncSearch);

  UI_Delete(mdForward, muWord);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UI_BackspaceOrUnindent;
var
  i: Integer;
  Ln, LnStart, Cnt: Integer;
  CurW, FoundW: Integer;
  Ok: Boolean;
  FoundSeg: TLMDSegment;
  State: TWrapParserState;
begin
  Ln := MyDoc.GetLineByOffset(CursorOffset);
  LnStart := MyDoc.LineSegments[Ln].Start;
  Cnt := CursorOffset - LnStart;
  State := Cache(self).WP_GetState(CursorOffset);

  Ok := (Ln > 0) and (not SelAvail);
  if Ok then
  begin
    i := LMDSeqPosOneNotOfBack(AllSpaces, MyDoc.Chars, CursorOffset-1, Cnt);

    Ok := (i = -1) and
          (State.IsTail or (Pos(MyDoc.Chars[CursorOffset], AllSpaces)=0));
  end;

  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplIncSearch);

    if not Ok then
      InvokeCommand(sedDeletePrevChar, false)
    else
    begin
      CurW := Cache(self).CalkPointVisWidth(Cache(self).CursorOffset);

      Ok := FindIndentSeg(GetPrevVisibleLine(Ln), CurW, false, FoundW, FoundSeg);
      if Ok then
      begin
        if State.IsTail and
          (State.X <= FoundW) and
          (State.Y_OffsetStart = LnStart)
        then
        begin
          FDocInternal.PushCustomAction(FAuthorID, CreateCursorUndoInfo);
          CursorPosX := FoundW;
        end
        else
        begin
          FDocInternal.ReplaceSeg(LnStart, Cnt, FoundSeg,
                                  FAuthorID, CreateCursorUndoInfo);

          CursorPos := OffsetToScrollPos(CursorOffset);
        end;
      end
      else
        InvokeCommand(sedDeletePrevChar, false)
    end;
  finally
    EndUpdate;
  end;
end;

function TLMDCustomEditView.UI_CanUndoRedo(AUndo: Boolean): Boolean;
begin
  Result := (Document<>nil) and
            (AUndo and FDocInternal.GetCanUndo(AuthorID)) or
            ((not AUndo) and FDocInternal.GetCanRedo(AuthorID));
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UI_UndoRedo(AUndo: Boolean);
var
  oldInfo: TLMDDocUndoInfo;
  info:    TCursorUndoInfo;
begin
  CheckDocumentIsSet;

  if not UI_CanUndoRedo(AUndo) then
  begin
    Beep;
    Exit;
  end;

  BeginUpdate;

  info := nil;
  try
    RemoveInternalState(siComplIncSearch);

    FLastOffsetForUndo := -1;
    if AUndo then
      FDocInternal.Undo(AuthorID, CreateCursorUndoInfo, oldInfo)
    else
      FDocInternal.Redo(AuthorID, CreateCursorUndoInfo, oldInfo);

    if oldInfo <> nil then
    begin
      Assert(oldInfo is TCursorUndoInfo);

      info := TCursorUndoInfo(oldInfo);
      SetCursorAsUndoInfo(info);
    end
    else if FLastOffsetForUndo <> -1 then
    begin
      EnsureOffsetIsVisible(FLastOffsetForUndo);
      CursorPos := OffsetToScrollPos(FLastOffsetForUndo);
    end;

    CancelSelection;
    ScrollToCursorLow(false);
  finally
    if info<>nil then
      info.Free;

    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UI_ScrollUpDown(AUp: Boolean);
var
  OldY, Add: Integer;
  WasVis: Boolean;
begin
  if AUp then
    Add := -1
  else
    Add := 1;

  BeginUpdate;
  try
    OldY := TopLineScroll;

    WasVis := Cache(self).IsCursorInScreenYBounds;
    ScrollVertBy(Add);

    if WasVis and (not Cache(self).IsCursorInScreenYBounds) then
      CursorPosY := CursorPosY + Add;
  finally
    EndUpdate;
  end;

  if OldY = TopLineScroll then
    Beep;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.Undo;
begin
  CheckNotReadOnly;
  UI_UndoRedo(True);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.Redo;
begin
  CheckNotReadOnly;
  UI_UndoRedo(False);
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetCanUndo: Boolean;
begin
  Result := UI_CanUndoRedo(True);
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetCanRedo: Boolean;
begin
  Result := UI_CanUndoRedo(False);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.BeginUpdate;
begin
  BeginChangeCommon;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EndUpdate;
begin
  EndChangeCommon(False, False);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.EndUpdate(AFullRepaint: Boolean);
begin
  EndChangeCommon(AFullRepaint, False);
end;

{------------------------------------------------------------------------------}

procedure SetCursorForSearch(AView: TLMDCustomEditView;
                             const AOpts: TLMDEditSearchArguments);
begin
  AView.CheckDocumentIsSet;

  AView.FSearchArgs := AOpts;
  if AOpts.Start<>ssCursor then
  begin
    case AOpts.Direction of
      sdForward: AView.CursorOffset := 0;
      sdBackward: AView.CursorOffset := AView.MyDoc.CharsCount;
    else
      Assert(false);
    end;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.SearchFirst(
  const Args: TLMDEditSearchArguments): Boolean;
begin
  CheckDocumentIsSet;

  FreeSearchState;
  FSearchState := stInSearch;
  FSearchArgs := Args;

  RemoveInternalStateForPublics(siComplIncSearch);
  Result := SearchNextLow(true);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.AskForNotFound: TLMDEditNotFoundAction;
var
  Res: Integer;
  Msg: TLMDString;
  Btns: TMsgDlgButtons;
begin
  Result := saCancel;

  if ((FSearchArgs.Direction=sdForward) and
      (CursorOffset > 0)) or
     ((FSearchArgs.Direction=sdBackward) and
      (CursorOffset < MyDoc.CharsCount))
  then
  begin
    if Assigned(FOnNotFound) then
      FOnNotFound(self, Result)
    else
    begin
      if FSearchArgs.Direction = sdForward then
        Msg := SLMDSedDlgContinueSearchFromStart
      else
        Msg := SLMDSedDlgContinueSearchFromEnd;

      Btns := [mbYes, mbNo];
      Res := MessageDlg(Msg, mtConfirmation, Btns, -1);
      case Res of
        mrYes: Result := saGoStartEnd;
        mrNo,
        mrCancel: Result := saCancel;
      else
        Assert(false);
      end;
    end;
  end;
end;

//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
procedure TLMDCustomEditView.AskForReplaceAction(AForReplaceAll: Boolean;
  const AState: TLMDEditFindReplaceState; var ReplacedCount: Integer;
  var Action: TLMDEditReplaceAction);
const
  Y_Margin = 32;
var
  Res: Integer;
  Msg: TLMDString;
  Btns: TMsgDlgButtons;
  FoundStart, FoundLength: Integer;

  ClientRect, CharRect, CharRectE, WinRect: TRect;
  Dlg: TForm;

  W, H, Y: Integer;
  DiffTop, DiffBottom, DiffLeft, DiffRight: Integer;

  SelEndCut: TPoint;
  Dummy: Boolean;

  procedure SelectFound;
  var
    Off, Off1: Integer;
  begin
    BeginUpdate;
    Include(FState, siScrollforceAvoidAdges);
    try
      Off  := FoundStart;
      Off1 := FoundStart + FoundLength;

      SetSelection(Off, Off1, false);

      if AState.Direction = sdForward then
        CursorOffset := SelectionOffsetEnd
      else
        CursorOffset := SelectionOffsetStart;

      ScrollToPos(SelectionEndNorm, true);
      ScrollToPos(SelectionStartNorm, true);
    finally
      Exclude(FState, siScrollforceAvoidAdges);
      EndUpdate;
    end;
  end;

begin
  CheckNotReadOnly;
  CheckDocumentIsSet;
  CheckInReplaceMode;

  RemoveInternalState(siComplAll);

  FoundStart := AState.FoundSegment.Start;
  FoundLength := AState.FoundSegment.Count;

  Action := raReplaceAuto;
  if Assigned(FOnReplaceFound) then
  begin
    SelectFound;
    FOnReplaceFound(self, AState, ReplacedCount, Action);
  end
  else if soConfirmReplace in FSearchArgs.Options then
  begin
    SelectFound;

    Msg := Format(SLMDSedDlgReplaceConfirm, [FSearchArgs.Search]);

    if AForReplaceAll then
      Btns := [mbYes, mbNo, mbCancel]
    else
      Btns := [mbYes, mbNo];

    if SelectionEndNorm.Y > SelectionStartNorm.Y then
    begin
      W := Cache(self).GetScrollLineVisWidth(SelectionStartNorm.Y);
      SelEndCut := Point(W, SelectionStartNorm.Y);
    end
    else
      SelEndCut := SelectionEndNorm;

    Y := Cache(self).ScrollToScreen(SelEndCut.Y);

    SelEndCut.X := Min(Cache(self).GetScreenLineLastX(Y), SelEndCut.X);

    ClientRect := GetDrawRect;
    Inc(ClientRect.Left, FGutterWidth);
    CharRect := ScrollPosToClient(SelectionStartNorm, Dummy);
    Assert(not Dummy);
    CharRectE := ScrollPosToClient(SelEndCut, Dummy);
    Assert(not Dummy);

    GetWindowRect(Handle, WinRect);

    Inc(CharRect.Left, WinRect.Left);
    Inc(CharRect.Top, WinRect.Top);
    Inc(CharRect.Right, WinRect.Left);
    Inc(CharRect.Bottom, WinRect.Top);

    Inc(CharRectE.Left, WinRect.Left);
    Inc(CharRectE.Top, WinRect.Top);
    Inc(CharRectE.Right, WinRect.Left);
    Inc(CharRectE.Bottom, WinRect.Top);

    Inc(ClientRect.Left, WinRect.Left);
    Inc(ClientRect.Top, WinRect.Top);
    Inc(ClientRect.Right, WinRect.Left);
    Inc(ClientRect.Bottom, WinRect.Top);

    Dlg := CreateMessageDialog(Msg, mtConfirmation, Btns);

    H := Dlg.Height;
    W := Dlg.Width;

    ///
    DiffTop := CharRect.Top - H - ClientRect.Top;
    DiffBottom := ClientRect.Bottom - (CharRect.Bottom + H);

    DiffTop := Max(0, DiffTop);
    DiffBottom := Max(0, DiffBottom);

    if DiffTop > DiffBottom then
      Dlg.Top := ClientRect.Top + DiffTop - Y_Margin
    else if DiffTop < DiffBottom then
      Dlg.Top := ClientRect.Bottom - DiffBottom - H + Y_Margin;

    ///
    DiffLeft := CharRectE.Right - W - ClientRect.Left;
    DiffRight := ClientRect.Right - (CharRect.Left + W);

    DiffLeft := Max(0, DiffLeft);
    DiffRight := Max(0, DiffRight);

    if DiffLeft > DiffRight then
      Dlg.Left := ClientRect.Left + DiffLeft
    else if DiffLeft < DiffRight then
      Dlg.Left := CharRect.Left;

    Res := Dlg.ShowModal;

    case Res of
      mrYes: Action := raReplaceAuto;
      mrNo: Action := raGoNext;

      mrCancel:
      begin
        if AForReplaceAll then
          Action := raCancel
        else
          Action := raGoNext;
      end
    else
      Assert(false);
    end;
  end;

  case Action of
    raReplaceAuto: Inc(FSearchNumOfReplacements);
    raReplacedByCallback: Inc(FSearchNumOfReplacements);
    raGoNext,
    raCancel: ;
  else
    Assert(false);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.FindNextEndOrStartOfWord(APt: TPoint; AFwd: Boolean): TPoint;
var
    Cnt: Integer;
    WE, WS, NextLnOff, OffPt, Last: TOffsetPoint;
    First, Y: Integer;
begin
  First := Cache(self).GetScrollLineOffStart(APt.Y);
  Last := Cache(self).GetScrollLineOffLast(APt.Y);

  OffPt := Cache(self).ScrollPtToOffsetPt(APt);

  if AFwd then
  begin
    Y := APt.Y + 1;
    Cache(self).CorrectToLastScroll(Y);
    if Y > APt.Y then
      NextLnOff := OffsetPt( Cache(self).GetScrollLineOffStart(Y) )
    else
      NextLnOff := Last;

    Cnt := Last.Offset - OffPt.Offset;

    WE := OffsetPt( MyDoc.FindNextWordEnd(OffPt.Offset, Cnt) );
    WS := OffsetPt( MyDoc.FindNextWordStart(OffPt.Offset, Cnt) );
    Assert(WE.Offset <= Last.Offset);

    if WE.Offset = -1 then
      WE := NextLnOff
    else
      Inc(WE.Offset);

    if WS.Offset = -1 then
      WS := NextLnOff;
  end
  else
  begin
    Cnt := OffPt.Offset - First;

    WE := OffsetPt( MyDoc.FindPrevWordEnd(OffPt.Offset, Cnt) );
    WS := OffsetPt( MyDoc.FindPrevWordStart(OffPt.Offset, Cnt) );

    Assert(WE.Offset <= Last.Offset);

    if WE.Offset = -1 then
      WE := OffsetPt(First)
    else
      Inc(WE.Offset);

    if WS.Offset = -1 then
      WS := OffsetPt(First);
  end;

  if AFwd then
  begin
    if CmpOffsetPt(WS, WE) < 0 then
      OffPt := WS
    else
      OffPt := WE;
  end
  else
  begin
    if CmpOffsetPt(WS, WE) < 0 then
      OffPt := WE
    else
      OffPt := WS;
  end;

  Result := Cache(self).OffsetPtToScrollPt(OffPt);
end;

function TLMDCustomEditView.FindNoSpaceOffset(APhysLine: Integer; AVisibleOnly: Boolean): Integer;
var
    LineS, LineE: TOffsetPoint;
    Seg: TLMDSegment;
begin
  if AVisibleOnly then
    Cache(self).GetPhysLineVisibleBounds(APhysLine, LineS, LineE)
  else
  begin
    Seg := MyDoc.LineSegments[APhysLine];
    
    LineS := OffsetPt(Seg.Start);
    LineE := OffsetPt(LMDSegEnd(Seg) + 1);
  end;

  Result := LMDSeqPosOneNotOf(AllSpaces, MyDoc.Chars,
                              LineS.Offset, LineE.Offset - LineS.Offset);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.FindIndentSeg(AFindStartLine: Integer;
                                          AVisWidth: Integer;
                                          AFindGreater: Boolean;
                                          out FoundWidth: Integer;
                                          out FoundSeg: TLMDSegment): Boolean;

function GetPos(ALine: Integer; out AOffset: Integer): Integer;
begin
  AOffset := FindNoSpaceOffset(ALine);

  if AOffset <> -1 then
    Result := Cache(self).CalkPointVisWidth(AOffset)
  else
    Result := 0;
end;


var
    Ln, LnStart: Integer;
    Pos, Off: Integer;
begin
  Assert(AFindStartLine >= 0);
  Assert(AVisWidth >= 0);

  Ln := AFindStartLine;
  Pos := GetPos(Ln, Off);

  if not AFindGreater then
  begin
    while (Ln > 0) and ((Pos >= AVisWidth) or (Off=-1)) do
    begin
      Ln := GetPrevVisibleLine(Ln);
      Pos := GetPos(Ln, Off);
    end;

    Result := (Off <> -1) and (Pos < AVisWidth);
  end
  else
  begin
    while (Ln > 0) and (Off = -1) do
    begin
      Ln := GetPrevVisibleLine(Ln);
      Pos := GetPos(Ln, Off);
    end;

    Result := (Off <> -1) and (Pos > AVisWidth);
  end;

  if Result then
  begin
    LnStart := MyDoc.LineSegments[Ln].Start;

    FoundSeg := LMDSegment(LnStart, Off-LnStart, MyDoc.Chars);
    FoundWidth := Pos;
  end;
end;

function TLMDCustomEditView.FindIndentStr(AFindStartLine,
                                          AVisWidth: Integer;
                                          AFindGreater: Boolean): TLMDString;
var
    Seg: TLMDSegment; Dummy: Integer;
    Ok: Boolean;
begin
  Ok := FindIndentSeg(AFindStartLine, AVisWidth, AFindGreater, Dummy, Seg);

  if Ok then  
    Result := LMDSegToString(Seg)
  else
    Result := '';
end;

function TLMDCustomEditView.FindNextEndOrStartOfLine(APt: TPoint;
                                                     AFwd: Boolean): TPoint;
var
    L: Integer;
    OffS, OffE: TOffsetPoint;
begin
  L := ScrollToPhysical(APt.Y);

  Cache(self).GetPhysLineVisibleBounds(L, OffS, OffE);

  if AFwd then
    Result := Cache(self).OffsetPtToScrollPt(OffE)
  else
    Result := Cache(self).OffsetPtToScrollPt(OffS);
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.SearchNext: Boolean;
begin
  if siIncrementalSearch in FState then
    Result := IncrementalSearchForward
  else
    Result := SearchNextLow(false);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.SearchNextLow(AFirstTime: Boolean): Boolean;
var
  FoundStart, FoundLength: Integer;
  Start, MaxCnt, Dummy: Integer;
  OldCursor: TPoint;

  DoLock: Boolean;
begin
  DoLock := siIncrementalSearch in FState;
  if DoLock then
    Inc(FCmdModesLock);

  try
    CheckDocumentIsSet;
    CheckInSearchMode;

    RemoveInternalState(siComplAll);
    OldCursor := CursorPos;

    if FSearchStateBag = nil then
    begin
      FSearchNumOfReplacements := 0;

      SetCursorForSearch(self, FSearchArgs);

      Start := CursorOffset;

      case FSearchArgs.Direction of
        sdForward: MaxCnt := MyDoc.CharsCount - Start;
        sdBackward: MaxCnt := Start;
      else
        MaxCnt := -1;
        Assert(false);
      end;

      FSearchStateBag := MyDoc.FindPatternFirst(Start, MaxCnt,
                                                FSearchArgs.Search,
                                                FSearchArgs.Options,
                                                FSearchArgs.Direction);
      Result := FSearchStateBag <> nil;
    end
    else
      Result := MyDoc.FindPatternNext(CursorOffset, FSearchStateBag);

    if Result then
    begin
      FoundStart  := FSearchStateBag.FoundSegment.Start;
      FoundLength := FSearchStateBag.FoundSegment.Count;

      if Cache(self).IsOffsetInsideCR(FoundStart, Dummy) then
        Dec(FoundStart);

      if Cache(self).IsOffsetInsideCR(FoundStart+FoundLength, Dummy) then
        Inc(FoundLength);

      BeginUpdate;
      Include(FState, siScrollforceAvoidAdges);
      try
        if (FSearchArgs.Direction = sdForward) and
           (not (siIncrementalSearch in FState))
        then
        begin
          CursorOffset := FoundStart+FoundLength;
          SetSelection(FoundStart, CursorOffset, false);
        end
        else
        begin
          CursorOffset := FoundStart;
          SetSelection(FoundStart+FoundLength, CursorOffset, false);
        end;

        ScrollToCursor;
      finally
        Exclude(FState, siScrollforceAvoidAdges);
        EndUpdate;
      end;
    end
    else
    begin
      Result := (not AFirstTime) or (not (siIncrementalSearch in FState));
      if Result then
      begin
        Result := AskForNotFound = saGoStartEnd;

        if Result then
        begin
          if FSearchArgs.Direction = sdForward then
            CursorOffset := 0
          else
            CursorOffset := MyDoc.CharsCount;

          Result := SearchFirst(FSearchArgs);
        end
      end;
    end;

    if not Result then
      CursorPos := OldCursor;
  finally
    if DoLock then
      Dec(FCmdModesLock);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ReplaceFirst(
  const Args: TLMDEditSearchArguments): Boolean;
begin
  CheckNotReadOnly;
  CheckDocumentIsSet;

  RemoveInternalState(siComplIncSearch);

  FreeSearchState;

  FSearchState := stInReplace;
  FSearchNumOfReplacements := 0;
  FSearchArgs := Args;

  Result := ReplaceNext;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ReplaceNext: Boolean;
var
  Start, MaxCnt: Integer;
  Tmp: TLMDEditFindReplaceState;
  Found: TLMDSegment;
  OldCursor: TPoint;
begin
  CheckNotReadOnly;
  CheckDocumentIsSet;
  CheckInReplaceMode;

  RemoveInternalState(siComplIncSearch);

  OldCursor := CursorPos;

  Start := CursorOffset;

  case FSearchArgs.Direction of
    sdForward:  MaxCnt := MyDoc.CharsCount - Start;
    sdBackward: MaxCnt := Start;
  else
    MaxCnt := -1;
    Assert(false);
  end;

  if FSearchStateBag = nil then
  begin
    FSearchNumOfReplacements := 0;

    SetCursorForSearch(self, FSearchArgs);

    Start := CursorOffset;

    case FSearchArgs.Direction of
      sdForward: MaxCnt := MyDoc.CharsCount - Start;
      sdBackward: MaxCnt := Start;
    else
      MaxCnt := -1;
      Assert(false);
    end;

    FSearchStateBag := MyDoc.FindPatternFirst(Start,
                                              MaxCnt,
                                              FSearchArgs.Search,
                                              FSearchArgs.Options,
                                              FSearchArgs.Direction);
    Result := FSearchStateBag <> nil;
  end
  else
    Result := MyDoc.FindPatternNext(CursorOffset, FSearchStateBag);

  if Result then
  begin
    FDocInternal.BeginCompoundAction(AuthorID, CreateCursorUndoInfo, false);
    try
      Tmp := MyDoc.ReplacePatternFirst(Start, MaxCnt,
                                       FSearchArgs.Search,
                                       FSearchArgs.Replace,
                                       FSearchArgs.Options,
                                       FSearchArgs.Direction,
                                       ReplaceNextProc);
      if Tmp <> nil then
      begin
        Found := Tmp.FoundSegment;

        MyDoc.ReplacePatternClose(Tmp);

        if FSearchArgs.Direction = sdBackward then
          CursorOffset := Found.Start
        else
          CursorOffset := LMDSegEnd(Found) + 1;

        CancelSelection;
        ScrollToCursor;
      end;
    finally
      MyDoc.EndCompoundEdit(false);
    end;
  end
  else if AskForNotFound = saGoStartEnd then
  begin
    FDocInternal.PushCustomAction(AuthorID, CreateCursorUndoInfo);

    if FSearchArgs.Direction=sdForward then
      CursorOffset := 0
    else
      CursorOffset := MyDoc.CharsCount;
    Result := ReplaceFirst(FSearchArgs);
  end
  else
    Result := false;

  if (not Result) or (FSearchNumOfReplacements = 0) then
    CursorPos := OldCursor;
end;

procedure TLMDCustomEditView.ReplaceNextProc(Sender: TObject;
  const AState: TLMDEditFindReplaceState; var ReplacedCount: Integer;
  var Action: TLMDEditReplaceAction);
begin
  AskForReplaceAction(false, AState, ReplacedCount, Action);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.AssignSearchReplaceArgs(
  const Args: TLMDEditSearchArguments; AState: TLMDEditViewSearchState);
begin
  RemoveInternalState(siComplIncSearch);

  FreeSearchState;

  FSearchArgs := Args;
  FSearchState := AState;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.AddHighlight(AStart, ACount: Integer);
begin
  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplAll);

    Cache(Self).AddHighlight(AStart, ACount);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.RemoveHighlight(AStart, ACount: Integer);
begin
  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplAll);

    Cache(Self).RemoveHighlight(AStart, ACount);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.ClearHighlight;
begin
  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplAll);

    Cache(Self).ClearHighlights;
  finally
    EndUpdate;
  end;
end;

procedure TLMDCustomEditView.ClearPrintTasks;
begin
  while FPrintTasks.Count > 0 do
    TLMDEditViewPrintTask(FPrintTasks[0]).InternalSetView(nil);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ReplaceAll(const Args: TLMDEditSearchArguments;
                                       ABounds: TLMDEditViewReplaceAllBounds): Boolean;
var
  Start, EndBound: Integer;
  DoConfirm: Boolean;
begin
  CheckNotReadOnly;
  CheckDocumentIsSet;

  RemoveInternalState(siComplIncSearch);
  FreeSearchState;

  FSearchNumOfReplacements := 0;

  FSearchState := stInReplace;

  FSearchArgs := Args;

  Start := -1;
  EndBound := -1;

  if ABounds = rbAllText then
  begin
    case FSearchArgs.Start of
      ssCursor:
      begin
        case FSearchArgs.Direction of
          sdForward:
          begin
            Start := CursorOffset;
            EndBound := MyDoc.CharsCount;
          end;
          sdBackward:
          begin
            Start := CursorOffset;
            EndBound := 0;
          end;
        else
          Assert(false);
        end;
      end;

      ssTextStartEnd:
      begin
        case FSearchArgs.Direction of
          sdForward:
          begin
            Start := 0;
            EndBound := MyDoc.CharsCount;
          end;
          sdBackward:
          begin
            Start := MyDoc.CharsCount;
            EndBound := 0;
          end;
        else
          Assert(false);
        end;
      end
    else
      Assert(false);
    end;
  end
  else
  begin
    FSearchArgs.Direction := sdForward;

    Start := ScrollPosToNearestOffset(GetSelStartNorm);
    EndBound := ScrollPosToNearestOffset(GetSelEndNorm);
  end;

  Result := false;

  DoConfirm := soConfirmReplace in FSearchArgs.Options;

  FDocInternal.BeginCompoundAction(AuthorID, CreateCursorUndoInfo,
                                   not DoConfirm);

  try
    FSearchNumOfReplacements := 0;

    FSearchStateBag := MyDoc.ReplacePatternAll(Start, Abs(EndBound - Start),
                                               FSearchArgs.Search,
                                               FSearchArgs.Replace,
                                               FSearchArgs.Options,
                                               FSearchArgs.Direction,
                                               ReplaceAllProc);
    Result := FSearchStateBag<>nil;
  finally
    FSearchArgs.Direction := FSearchArgs.Direction;

    if Result then
    begin
      CursorOffset := LMDSegEnd(FSearchStateBag.FoundSegment)+1;
      CancelSelection;
      ScrollToCursorLow(true);
    end;

    MyDoc.EndCompoundEdit(not DoConfirm);
  end;
end;

procedure TLMDCustomEditView.ReplaceAllProc(Sender: TObject;
                                            const AState: TLMDEditFindReplaceState;
                                            var ReplacedCount: Integer;
                                            var Action: TLMDEditReplaceAction);
begin
  AskForReplaceAction(true, AState, ReplacedCount, Action);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ScreenLineToClient(AScreen: Integer): TRect;
var
  DR: TRect;
begin
  DR := GetDrawRect;
  Result.Left := DR.Left;
  Result.Right := DR.Right;
  Result.Top := DR.Top + AScreen * FLineHeight;
  Result.Bottom := Result.Top + FLineHeight;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GutterLineToClient(AScreenLine: Integer;
  ABar: TLMDGutterBar): TRect;
var
  res: TRect;
  i:   Integer;
begin
  CheckGutterBarVisible(ABar);

  res := ScreenLineToClient(AScreenLine);
  res.Left := 0;
  res.Right := 0;

  for i := 0 to ABar.Index-1 do
    if FGutter.Bars[i].Visible then
      Inc(res.Left, FGutter.Bars[i].FullWidth);

  res.Right := res.Left + ABar.FullWidth;

  Result := res;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ClientToScreenPos(AClient: TPoint;
                                              out ScreenPart: TLMDEditScreenPart): TPoint;

begin
  Result.Y := AClient.Y div FLineHeight;

  if AClient.X  < FGutterWidth then
  begin
    if Result.Y < LinesOnScreenScroll then
      ScreenPart := spGutterText
    else
      ScreenPart := spGutterPastText;
  end
  else if Result.Y < LinesOnScreenScroll then
    ScreenPart := spText
  else
    ScreenPart := spPastText;

  Result.Y := LMDMinMax(Result.Y, 0, LinesOnScreenScroll-1);
  Result.X := Cache(self).ScreenPixToScreenPos(Max(0, AClient.X - FGutterWidth),
                                               Result.Y);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ClientToScrollPos(AClient: TPoint): TPoint;
var
    Part: TLMDEditScreenPart;
begin
  Result := ClientToScrollPos(AClient, Part);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ClientToScrollPos(AClient: TPoint;
                                              out ScreenPart: TLMDEditScreenPart): TPoint;
begin
  Result := ScreenPosToScroll(ClientToScreenPos(AClient, ScreenPart));
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ScrollPosToClient(AScrollPos: TPoint;
                                              out OutOfScreen: Boolean): TRect;
var
    XS, XCnt: Integer;
    R: TRect;
    Scr: TPoint;
begin
  Scr := Cache(self).ScrollPosToScreen(AScrollPos, false);
  XS := 0;
  XCnt := 0;

  OutOfScreen := (Scr.Y < 0) or (Scr.Y >= LinesOnScreenScroll);
  if not OutOfScreen then
    OutOfScreen := not Cache(self).ScreenPosToScreenPix(Scr, XS, XCnt, true);

  R := ScreenLineToClient(Scr.Y);

//  if not OutOfScreen then
  begin
    R.Left  := R.Left + FGutterWidth + XS;
    R.Right := R.Left + XCnt;
  end;
{
  else
  begin
    R.Left  := FGutterWidth - 1;
    R.Right := FGutterWidth;
  end;
}
  Result := R;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ClientToGutterScreen(AClient: TPoint;
                  out AScreenLine: Integer;
                  out ABarHere: TLMDGutterBar): Boolean;
var
  Scr:  TPoint;
  i, x: Integer;
  Part: TLMDEditScreenPart;
begin
  Result := false;
  AScreenLine := -1;

  if AClient.X < 0 then
    Exit;

  Scr := ClientToScreenPos(AClient, Part);
  Result := Part=spGutterText;
  if Result then
  begin
    AScreenLine := Scr.Y;

    x := 0;
    i := 0;
    ABarHere := nil;

    while (i<FGutter.Bars.Count) and (x <= AClient.X) do
    begin
      if FGutter.Bars[i].Visible then
      begin
        ABarHere := FGutter.Bars[i];
        Inc(x, ABarHere.FullWidth);
      end;

      Inc(i);
    end;

    Assert( ABarHere <> nil );
  end;
end;

procedure TLMDCustomEditView.ClearAddictCheckTokenIds;
begin
  SetLength(FAddictCheckTokenIds, 0);
end;

function TLMDCustomEditView.ClientToGutter(AClient: TPoint;
                                           out AScrollLine: Integer;
                                           out ABarHere: TLMDGutterBar): Boolean;
var Scrn: Integer;
begin
  result := ClientToGutterScreen(AClient, Scrn, ABarHere);
  if result then
    AScrollLine := ScreenToScroll(Scrn);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ScreenPosToScroll(AScreen: TPoint): TPoint;
begin
  Result := ScreenPosToScrollLow(AScreen, false);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ScreenPosToScrollLow(AScreen: TPoint;
  DoCheck: Boolean): TPoint;
begin
  Result := Cache(Self).ScreenPosToScroll(AScreen, DoCheck);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ScrollPosToWinCharPos(APos: TPoint): Integer;
begin
  Result := OffsetToWinCharPos(ScrollPosToNearestOffset(APos));
end;

function TLMDCustomEditView.GetScrollLineSeg_Addict(ALine: Integer): TLMDSegment;
var
    L: Integer;
begin
  L := ALine - Cache(self).FirstLineScroll;

  if (siPainting in FState) and LMDInRange(L, 0, LinesOnScreenScroll-1) then
  begin
    Result.Start := Cache(self).GetScreenLineWordStart(L);
    Result.Count := Cache(self).GetScreenLineWordEnd(L) - Result.Start;

    Result.Source := MyDoc.Chars;
  end
  else
    Result := Cache(self).GetScrollLineInfo(ALine).ContentSegment;
end;
{------------------------------------------------------------------------------}

function TLMDCustomEditView.OffsetToScrollPos(AOffset: Integer): TPoint;
begin
  Result := Cache(Self).OffsetToScroll(AOffset);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.OffsetToWinCharPos(AOffset: Integer): Integer;
var
    off, i, L, Cnt, D: Integer;
    OffPt: TOffsetPoint;
begin
  Assert((AOffset >= 0) and (AOffset <= MyDoc.CharsCount));
   
  if FCachedWin.Count=0 then
  begin
    i := 0;
    L := 0;
  end
  else
  begin
    OffPt := OffsetPt(AOffset);
    Cache(self).CorrectOffsetPtCR(OffPt);

    FCachedWin.FindNearestByKey1(AOffset, off, i, L);
    Assert(off=MyDoc.LineSegments[L].Start);
  end;

  Cnt := MyDoc.LinesCount;

  if (L < Cnt) and (MyDoc.LineSegments[L].Start <= AOffset) then
  begin
    repeat
      Inc(i, MyDoc.LineSegments[L].Count+1);
      Inc(L);
    until (L = Cnt) or (MyDoc.LineSegments[L].Start > AOffset);
  end
  else
  begin
    while (L > 0) and (MyDoc.LineSegments[L-1].Start > AOffset) do
    begin
      Dec(i, MyDoc.LineSegments[L-1].Count+1);
      Dec(L);
    end;
  end;

  //Assert: Lines[L].Start > AOffset

  D := LMDSegEnd(MyDoc.LineSegments[L-1]) - AOffset + 1;
  Result := i - D - 1;

  D := MyDoc.LineSegments[L-1].Count;
  FCachedWin.AddByKey1(MyDoc.LineSegments[L-1].Start, i-D-1, L-1);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.ScrollPosToNearestOffset(AScroll: TPoint): Integer;
begin
  Cache(Self).CheckScrollPosForOffset(AScroll);

  Result := Cache(Self).ScrollToNearestOffset(AScroll);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.ScrollVertBy(ALineOffset: Integer);
begin
  BeginUpdate;
  try
    TopLineScroll := TopLineScroll + ALineOffset;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetCursorAsOffset: Integer;
begin
  Result := ScrollPosToNearestOffset(GetCursorPos);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetSelAvail: Boolean;
begin
  Result := Cache(self).SelAvail;
end;

{------------------------------------------------------------------------------}

//AStart, AEnd: are points in Scroll-coordinates (as for cursor)
procedure TLMDCustomEditView.SetSelection(AStart, AEnd: TPoint;
                                          ABlockMode: Boolean);//D+S+R+W+
begin
  Cache(self).CorrectCursorSelPos(AStart);
  Cache(self).CorrectCursorSelPos(AEnd);

  SetSelection(Cache(self).ScrollPtToOffsetPt(AStart),
               Cache(self).ScrollPtToOffsetPt(AEnd),
               ABlockMode);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetSelection(AStartOffset, AEndOffset: TOffsetPoint;
                                          ABlockMode: Boolean);
begin
  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplIncSearch);

    Cache(Self).SetSelection(AStartOffset, AEndOffset, ABlockMode);

    if Cache(self).SelAvail then
      Cache(Self).SetCursorOffset(AEndOffset, scBackward, ABlockMode);

    ScrollToCursorLow(false);
  finally
    EndUpdate;
  end;
end;

procedure TLMDCustomEditView.SetSelection(AStartOffset, AEndOffset: Integer;
                                          ABlockMode: Boolean);
begin
  SetSelection(OffsetPt(AStartOffset), OffsetPt(AEndOffset), ABlockMode);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.ScrollToCursorLow(AvoidScreenEdge: Boolean);
begin
  ScrollToPos(CursorPos, AvoidScreenEdge);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SaveCursorMaxHoriz;
var
    XS, XCnt: Integer;
begin
  Cache(self).ScrollPosToScreenPix(CursorPos, XS, XCnt);
  FCursorMaxHoriz := XS;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CorrectCursorToMaxHoriz;
var
    WithSelS, WithSelE: Boolean;
    MxPt, LastOff: TOffsetPoint;
    MxH, CrP, Cnt: Integer;
begin
  BeginUpdate;
  try
    Cache(self).ScrollPosToScreenPix(CursorPos, CrP, Cnt);

    if CrP <> FCursorMaxHoriz then
    begin
      MxH := Cache(self).ScreenPixToScrollPos(FCursorMaxHoriz, CursorPosY);
      MxPt := Cache(self).ScrollPtToOffsetPt(Point(MxH, CursorPosY));

      LastOff := Cache(self).GetScrollLineOffLast(CursorPosY);
      if CmpOffsetPt(MxPt, LastOff) > 0 then
        MxPt := LastOff;

      WithSelS := LMDPointsEqual(CursorPos, SelectionStart);
      WithSelE := LMDPointsEqual(CursorPos, SelectionEnd);

      Cache(self).SetCursorOffset(MxPt, scBackward, SelectionBlockMode);
      if WithSelS then
        Cache(self).SelStart := CursorPos;

      if WithSelE then
        Cache(self).SelEnd := CursorPos;
    end;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CorrectSelPointsBlockMode(var AStart, AEnd: TPoint);
var
  XS, XE: Integer;
  P: TPoint;
begin
  if ComparePoints(AStart, AEnd) > 0 then
  begin
    P := AStart;
    AStart := AEnd;
    AEnd := P;
  end;

  if (AStart.Y <> AEnd.Y) and (AStart.X = AEnd.X) then
    AEnd.X := AEnd.X + 1;

  XS := Min(AStart.X, AEnd.X);
  XE := Max(AStart.X, AEnd.X);

  AStart.X := XS;
  AEnd.X := XE;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.ScrollToCursor;
begin
  ScrollToCursorLow(true);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetCursorAsOffset(AOffset: Integer);
begin
  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplIncSearch);

    Cache(Self).SetCursorOffset(OffsetPt(AOffset), scBackward, SelectionBlockMode);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetTopLineScroll(ALine: Integer);
begin
  CheckDocumentIsSet;

  ALine := Max(0, ALine) + ScreenHeightFullVis - 1;
  Cache(self).CorrectToLastScroll(ALine);
  ALine := ALine - ScreenHeightFullVis + 1;

  if ALine = TopLineScroll then
    Exit;

  BeginUpdate;
  try
    RemoveInternalStateForPublics([siComplListShown, siComplTimer]);

    Cache(Self).SetFirstLineAsScroll(ALine);

    if TopLineScroll <> ALine then
      AddStatusChange(scVScroll);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetTopLinePhysical(ALine: Integer);
begin
  if ALine=GetTopLinePhysical then
    Exit;

  CheckDocumentIsSet;

  RemoveInternalStateForPublics([siComplListShown, siComplTimer]);

  Cache(Self).CorrectPhysY(ALine);
  EnsureVisible(ALine);

  SetTopLineScroll(PhysicalToScroll(ALine));
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetHorizScroll(AScroll: Integer);//H+
begin
  SetHorizScrollWithCode(AScroll, scPosition);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetHorizScrollWithCode(AScroll: Integer;
                                                    ACode: TScrollCode);
begin
  if (AScroll=HorizScroll) or (WrapMode=wmWrapToWindow) then
    Exit;

  BeginUpdate;
  try
    RemoveInternalStateForPublics([siComplListShown, siComplTimer]);

    AScroll := Max(0, AScroll);

    FireOnScroll(AScroll, ACode, False);
    AScroll := Max(0, AScroll);

    Cache(Self).HorizScroll := AScroll;
  finally
    EndUpdate(True);
  end;
end;

procedure TLMDCustomEditView.SetIndentWidth(AWidth: Integer);
begin
  if AWidth=FIndentWidth then
    Exit;

  BeginSettingsChange;
  try
    FIndentWidth := AWidth;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.ScrollVertWithCode(ALineOffset: Integer;
                                                ACode: TScrollCode;
                                                AWithEvent: Boolean);
var
  NewFirstLine: Integer;
begin
  if ALineOffset=0 then
    Exit;

  NewFirstLine := Max(0, TopLineScroll + ALineOffset);
  Cache(self).CorrectToLastScroll(NewFirstLine);

  BeginUpdate;
  try
    RemoveInternalStateForPublics([siComplListShown, siComplTimer]);

    if AWithEvent then
    begin
      FireOnScroll(NewFirstLine, ACode, True);

      NewFirstLine := Max(0, NewFirstLine);
      Cache(self).CorrectToLastScroll(NewFirstLine);
    end;

    TopLineScroll := NewFirstLine;
  finally
    EndUpdate(True);
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetCursorPosX: Integer;
begin
  Result := CursorPos.X;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetCursorPosEx(APoint: TPoint;
                                            ACorrectDir: Integer;
                                            ABlock: Boolean);
begin
  if LMDPointsEqual(CursorPos, APoint) and
     (SelectionBlockMode = ABlock)
  then
    Exit;

  BeginUpdate;
  try
    RemoveInternalStateForPublics(siComplAll);

    Cache(self).SetCursorPos( APoint,
                              TScrollCorrectDirection(ACorrectDir),
                              ABlock);
  finally
    EndUpdate;
  end;
end;

procedure TLMDCustomEditView.SetCursorPosX(X: Integer);
begin
  SetCursorPos(Point(X, CursorPos.Y));
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetCursorPosY: Integer;
begin
  Result := CursorPos.Y;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetCursorPosY(Y: Integer);
begin
  SetCursorPos(Point(CursorPos.X, Y));
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetCustomCommands(ACommands: TLMDEditCommandList);
begin
  if ACommands=FCustomCommands then
    Exit;

  FCustomCommands.Assign(ACommands);
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetSelectedText: TLMDString;
var
    Seq: TLMDCharSeq;
begin
  Seq := CreateScrollTextSeqAdapter(SelectionStartNorm,
                                    SelectionEndNorm,
                                    SelectionBlockMode);
  try
    Result := LMDSeqToString(Seq);
  finally
    Seq.Free;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetSelectedText(const AStr: TLMDString);
var
    P1, P2: TPoint;
    StartOffPt, EndOffPt: TOffsetPoint;
    StartOff, EndOff, MaxWidth: Integer;
    Inverse: Boolean;
begin
  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    Inverse := not LMDPointsEqual(SelectionStartNorm, SelectionStart);

    if SelectionBlockMode then
    begin
      FDocInternal.BeginCompoundAction(FAuthorID, CreateCursorUndoInfo, true);
      try
        if SelAvail then
          DeleteSelected;

        InsertInScrollBlock(CursorPos, AStr, MaxWidth, StartOffPt, EndOffPt);

        P1 := Cache(self).OffsetPtToScrollPt(StartOffPt);
        P2 := Cache(self).OffsetPtToScrollPt(EndOffPt);
        P2.X := P1.X + MaxWidth;

        if Inverse then
        begin
          CursorPos := P2;
          SetSelection(P2, P1, true);
        end
        else
        begin
          CursorPos := P1;
          SetSelection(P1, P2, true);
        end;

      finally
        MyDoc.EndCompoundEdit(true);
      end;
    end
    else
    begin
      if SelAvail then
      begin
        P1 := SelectionStartNorm;
        P2 := SelectionEndNorm;
      end
      else
      begin
        P1 := CursorPos;
        P2 := CursorPos;
      end;

      ReplaceInScrollEx(P1, P2, AStr, true, StartOff, EndOff);

      StartOff := EndOff - Length(AStr);

      if Inverse then
      begin
        CursorOffset := StartOff;
        SetSelection(EndOff, StartOff, SelectionBlockMode);
      end
      else
      begin
        CursorOffset := EndOff;
        SetSelection(StartOff, EndOff, SelectionBlockMode);
      end;
    end;

  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.CreateUndoInfo(AOffPt: TOffsetPoint): TLMDDocUndoInfo;
begin
  if MyDoc.InsideCompoundEdit then
    Result := nil
  else
    Result := TCursorUndoInfo.Create(AOffPt, siComplWordTyping in FState);
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.CreateCursorUndoInfo: TLMDDocUndoInfo;
begin
  Result := CreateUndoInfo(Cache(self).CursorOffset);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetCursorAsUndoInfo(AInfo: TLMDDocUndoInfo);
var
  Info: TCursorUndoInfo;
  Off: Integer;
begin
  CheckDocumentIsSet;
  BeginUpdate;
  try
    RemoveInternalState(siComplAll);

    Info := TCursorUndoInfo(AInfo);

    if LMDInRange(Info.OffPt.Offset, 0, MyDoc.CharsCount) then
    begin
      if Cache(self).IsOffsetInsideCR(Info.OffPt.Offset, Off) then
      begin
        Info.OffPt.Offset := Off;
        Info.OffPt.InCharOffset := 0;
      end;
    end
    else
    begin
      Info.OffPt.Offset := MyDoc.CharsCount;
      Info.OffPt.InCharOffset := 0;
    end;

    EnsureOffsetIsVisible(Info.OffPt.Offset);

    Cache(self).SetCursorOffset(Info.OffPt, scBackward, SelectionBlockMode);

    if Info.WordTyping then
      AddInternalState(siComplWordTyping);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetCursorPos(APoint: TPoint); //U+D+S+C+W+H+L+
begin
  SetCursorPosEx(APoint, Ord(scBackward), SelectionBlockMode);
  SaveCursorMaxHoriz;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.GetCursorPos: TPoint;
begin
  Result := Cache(self).CursorPos;
end;
{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.Fold(APhysLine: Integer; All: Boolean);
begin
  CheckDocumentIsSet;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    Cache(Self).Fold(APhysLine, All);

    AddStatusChange(scFolds);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.FoldAllIn(AOuterFold: Integer; TopOnly: Boolean);
begin
  CheckDocumentIsSet;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    if AOuterFold<>-1 then
      Cache(Self).CheckPhysLineIdx(AOuterFold);

    Cache(Self).FoldAllIn(AOuterFold, TopOnly);

    AddStatusChange(scFolds);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UnfoldAllIn(AOuterFold: Integer; TopOnly: Boolean);
var
  WasCursorVis: Boolean;
begin
  CheckDocumentIsSet;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    if AOuterFold<>-1 then
      Cache(Self).CheckPhysLineIdx(AOuterFold);

    WasCursorVis := IsCursorInScreenBounds;

    Cache(Self).UnfoldAllIn(AOuterFold, TopOnly);
    AddStatusChange(scFolds);

    if WasCursorVis and (not IsCursorInScreenBounds) then
      ScrollToCursorLow(false);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.Unfold(APhysLine: Integer; All: Boolean);
var
  WasCursorVis: Boolean;
begin
  CheckDocumentIsSet;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    Cache(Self).CheckPhysLineIdx(APhysLine);
    WasCursorVis := IsCursorInScreenBounds;

    Cache(Self).Unfold(APhysLine, All);

    if WasCursorVis and (not IsCursorInScreenBounds) then
      ScrollToCursorLow(false);

    AddStatusChange(scFolds);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DefaultGutterPaint(const Args: TLMDEditPaintTextArgs;
                                                ABar: TLMDGutterBar;
                                                APaintKind: TLMDGutterBarKind);

var
  Cnv: TCanvas;
  Line: TScrollLineInfo;
  Bmk: ILMDLineMark;

  R: TRect;
  X, Y: Integer;
  HaveLine, NotAfterLast, FirstWrap,
  Handled, LastWrap, FoldStart, FoldEnd: Boolean;
  Nr: Integer;
  ScreenLine: Integer;
  LnArgs: TLMDEditPaintTextArgs;
  Bmp: Graphics.TBitmap;
  HF: HFONT;
  NrStr: TLMDString;
begin
  ScreenLine := Args.ScreenLine;
  NotAfterLast := LMDInRange(ScreenLine, 0, LinesOnScreenScroll-1);
  HaveLine := NotAfterLast;
  FirstWrap := False;
  LastWrap := False;
  FoldStart := False;
  FoldEnd := False;

  if HaveLine then
  begin
    Line := Cache(Self).GetScreenLine(ScreenLine);
    FirstWrap := lpFirstWrap in Line.VisProps;
    LastWrap := lpLastWrap in Line.VisProps;
    FoldStart := lpFoldStart in Line.VisProps;
    FoldEnd := lpFoldEnd in Line.VisProps;

    if FirstWrap then
      Bmk := MyDoc.Bookmarks.GetLastLineMark(Line.PhysicalLine);
  end
  else
    Line.VisProps := [];

  Cnv := Args.Canvas;
  HF := Cache(self).GetFont(Args.DefaultFont.Style, Args.DefaultFont.Charset);
  SelectObject(Cnv.Handle, HF);

  R := Args.BgRect;

  case APaintKind of
    gbCustom:
    begin
      Cnv.Brush.Color := FGutter.CustomBarBg;
      Cnv.FillRect(R);
    end;

    gbBookmarkBar,
    gbWrapBar,
    gbBreakpointBar:
    begin
      Cnv.Brush.Color := FGutter.BookmarksBarBg;
      Cnv.FillRect(R);

      Inc(R.Left, ABar.LeftPadding);
      Dec(R.Right, ABar.RightPadding);

      case APaintKind of
        gbBookmarkBar:
        begin
          if Bmk <> nil then
          begin
            DrawBmp(Cnv, FGutter.GetBookImageForDrawing(Bmk), R);
            Nr := StrToIntDef(Bmk.Name, -1);
            if Nr <> -1 then
            begin
              NrStr := Bmk.Name;

              SetTextColor(Cnv.Handle, ColorToRGB(FGutter.BookmarksBarTextColor));
              SetBkMode(Cnv.Handle, TRANSPARENT);
              LMDSedTextRect(Cnv.Handle, R, R.Left + 2, R.Top + 1,
                             PLMDChar(NrStr), Length(NrStr), true);
            end;
          end;
        end;

        gbBreakpointBar:
        begin
          Bmp := FGutter.GetBreakImageForDrawing(Line.VisProps);
          if Bmp <> nil then
            DrawBmp(Cnv, Bmp, R);

          Bmp := FGutter.GetDbgImageForDrawing(Line.VisProps);
          if Bmp <> nil then
            DrawBmp(Cnv, Bmp, R);
        end;

        gbWrapBar:
        begin
          if HaveLine and (not FirstWrap)  then
            DrawBmp(Cnv, FGutter.GetWrapImageForDrawing, R);
        end;
      end;
    end;

    gbLineNumberBar:
    begin
      LnArgs := Args;

      LnArgs.BgRect := R;

      LnArgs.ContentRect := R;
      LnArgs.ContentRect.Right := Max(R.Left, R.Right - ABar.RightPadding);
      LnArgs.ContentRect.Left := Min(R.Right, R.Left + ABar.LeftPadding);

      LnArgs.DefaultBgColor := FGutter.LinesBarBg;
      LnArgs.DefaultColor := FGutter.LinesBarTextColor;

      PaintLineNumber(LnArgs);
    end;

    gbFoldBar:
    begin
      Cnv.Brush.Color := FGutter.FoldsBarBg;
      Cnv.Pen.Color := FGutter.FoldsBarLineColor;
      Cnv.FillRect(R);

      Inc(R.Left, ABar.LeftPadding);
      Dec(R.Right, ABar.RightPadding);

      Handled := False;
      if HaveLine and FirstWrap then
      begin
        Handled := True;
        if IsCollapsedFold(Line.PhysicalLine) then
          DrawBmp(Cnv, FGutter.GetFoldImageForDrawing(False), R)
        else if FoldStart then
          DrawBmp(Cnv, FGutter.GetFoldImageForDrawing(True), R)
        else
          Handled := False;
      end;

      if not Handled then
      begin
        if HaveLine and LastWrap and FoldEnd then
        begin
          if not FGutter.FoldEndImg.Empty then
            DrawBmp(Cnv, FGutter.FoldEndImg, R)
          else
          begin
            X := R.Left + LMDRectWidth(R) div 2;
            Y := R.Top + LMDRectHeight(R) div 2;

            Cnv.MoveTo(X, R.Top);
            Cnv.LineTo(X, Y);
            Cnv.LineTo(R.Right, Y);
            Cnv.MoveTo(X, Y);
            Cnv.LineTo(X, R.Bottom);
          end;
        end
        else if NotAfterLast then
        begin
          X := R.Left + LMDRectWidth(R) div 2;
          Cnv.MoveTo(X, R.Top);
          Cnv.LineTo(X, R.Bottom);
        end;
      end;
    end
  end
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DefaultGutterPaintCbk(AScreenLine: Integer;
                                                   ABar: TLMDGutterBar;
                                                   APaintKind: TLMDGutterBarKind;
                                                   ACanvas: TCanvas;
                                                   APaintRect: TRect);
var
    Args: TLMDEditPaintTextArgs;
begin
  Args.ScreenLine := AScreenLine;

  Args.BgRect := APaintRect;
  Args.ContentRect := APaintRect;

  Args.Cache := Cache(Self);
  Args.Canvas := ACanvas;

  Args.DefaultFont := FFont;
  Args.DefaultBgColor := Color;
  Args.DefaultColor := FFont.Color;

  Args.LineHeight := FLineHeight;
  Args.PrintMode := false;
  Args.PrintOptions := [];

  DefaultGutterPaint(Args, ABar, APaintKind);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.PaintGutterLine(Args: TLMDEditPaintTextArgs);//E+
var
  PaintOk: Boolean;
  i:       Integer;
begin
  for i := 0 to FGutter.Bars.Count-1 do
  begin
    if not FGutter.Bars[i].Visible then
      Continue;

    Args.BgRect := GutterLineToClient(Args.ScreenLine, FGutter.Bars[i]);
    Args.ContentRect := Args.BgRect;

    PaintOk := FireOnGutterPaint(Args, FGutter.Bars[i]);

    if not PaintOk then
      DefaultGutterPaint(Args, FGutter.Bars[i], FGutter.Bars[i].Kind);
  end
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.PaintLineNumber(const Args: TLMDEditPaintTextArgs);
var
  HaveLine, FirstWrap: Boolean;
  Line: TScrollLineInfo;
  SNum: string;
  WNum: Integer;
  X, Y: Integer;
  Che: TScreenCache;
  Cnv: TCanvas;
  HCnv: HDC;
  Ch: TLMDChar;
  CharSet: TFontCharSet;
  HF: HFONT;

  procedure SetCnvF;
  begin
    HF := Che.GetFont(Args.DefaultFont.Style, Charset);
    SelectObject(HCnv, HF);
    SetTextColor(HCnv, Args.DefaultColor);
    SetBkColor(HCnv, Args.DefaultBgColor);
  end;

begin
  Che := Args.Cache as TScreenCache;
  Cnv := Args.Canvas;
  HCnv := Cnv.Handle;
  CharSet := Args.DefaultFont.Charset;

  HaveLine := LMDInRange(Args.ScreenLine, 0, Che.LinesOnScreenScroll - 1);

  if HaveLine then
  begin
    Line := Che.GetScreenLine(Args.ScreenLine);
    FirstWrap := lpFirstWrap in Line.VisProps;
  end
  else
    FirstWrap := false;

  if HaveLine and FirstWrap and
     ((Line.PhysicalLine=0) or
      (((Line.PhysicalLine+1) mod FGutter.LineNumberingInterval)=0))
  then
  begin
    SetCnvF;

    SNum := IntToStr(Line.PhysicalLine+1);
    WNum := LMDSedTextWidth(Cnv, SNum);

    LMDSedTextRect(Cnv, Args.BgRect,
                   Args.ContentRect.Right-WNum, Args.ContentRect.Top, SNum);
  end
  else if (FirstWrap or Args.PrintMode) and HaveLine then
  begin
    if FSpecialChars.UseCharset then
      CharSet := FSpecialChars.Charset
    else
      CharSet := Args.DefaultFont.Charset;

    SetCnvF;

    Ch := FSpecialChars.GetDecodedChar(skLineNumberBullet);

    WNum := LMDSedTextWidth(Cnv, Ch);

    X := Args.ContentRect.Right - WNum;
    Y := Args.ContentRect.Bottom - Args.LineHeight;

    LMDSedTextRect(Cnv, Args.BgRect, X, Y, Ch);
  end
  else if HaveLine and (gsPaintWrapsOnLineNumberBar in Gutter.Settings) then
  begin
    FillRect(HCnv, Args.BgRect, HBrush(Args.DefaultBgColor));
    DrawBmp(Cnv, Gutter.GetWrapImageForDrawing, Args.ContentRect, taRightJustify);
  end
  else
  begin
    FillRect(HCnv, Args.BgRect, HBrush(Args.DefaultBgColor));
    Cnv.FillRect(Args.BgRect);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.PaintTextLine(const Args: TLMDEditPaintTextArgs;
                                           const SelScrS, SelScrE: TPoint);

const
      BpFlags: array[0..2] of TLMDScreenLineProp =
              (lpBreakpointActive, lpFrameTop, lpFrameActive);
var
  Bgs: array[0..2] of TColor;
  Fgs: array[0..2] of TColor;

  Che: TScreenCache;
  HCnv: THandle;

  CursorY: Integer;
  ALine: Integer;
  AScrollLine: Integer;
  ARect: TRect;

  APrintMode: Boolean;

  DefaultAttrs: TLMDEditAttributes;
  DefaultAttrsWeight: Integer;

  CurrentAttrs: TLMDEditAttributes;
  CurrentAttrsCharset: TFontCharset;
  CurrentAttrsWeight: Integer;

  function UseCursorLineColor: Boolean;
  var
    Cursor:  Boolean;
  begin
    if vsHighlightSelectedLine in ViewSettings then
    begin
      Cursor := CursorY = AScrollLine;

      Result := (Cursor and
                      ( ((SelScrS.X = SelScrE.X) and (SelScrS.Y = SelScrE.Y)) or
                         not LMDInRange(AScrollLine, SelScrS.Y, SelScrE.Y)) )
    end
    else
      Result := false;
  end;

  procedure SetTailStyle(const AScLine: TScrollLineInfo);
  var
      i: Integer;
      Handled: Boolean;
  begin
    if APrintMode then
    begin
      CurrentAttrs.AttributesSet := [];
      CurrentAttrsWeight := 0;
      Exit;
    end;

    CurrentAttrs.AttributesSet := [asBackgroundColor];

    Handled := false;
    for i := Low(BpFlags) to High(BpFlags) do
      if BpFlags[i] in AScLine.VisProps then
      begin
        CurrentAttrs.BackgroundColor := Bgs[i];
        CurrentAttrsWeight := 0;

        Handled := true;
      end;

    if not Handled then
    begin
      if lpFrame in AScLine.VisProps then
      begin
        CurrentAttrs.BackgroundColor := DebugFrameLineBg;
        CurrentAttrsWeight := 0;
      end
      else if IsReadOnly then
        CurrentAttrs.BackgroundColor := ReadOnlyBgColor
      else if UseCursorLineColor then
      begin
        CurrentAttrs.BackgroundColor := SelectedLineBg;
        CurrentAttrsWeight := 0;
      end
      else
        CurrentAttrs.AttributesSet := [];
    end;
  end;

  procedure SetSelectionStyle(AChunk: PChunk;
                              const AScLine: TScrollLineInfo);
  var
      i: Integer;
      Handled: Boolean;
  begin
    CurrentAttrs.AttributesSet := [];
    CurrentAttrsWeight := 1;

    if AChunk <> nil then
    begin
      CurrentAttrsCharset := AChunk.CharSet;

      if asFontStyle in AChunk.Attrs.AttributesSet then
      begin
        CurrentAttrs.FontStyle := AChunk.Attrs.FontStyle;

        Include(CurrentAttrs.AttributesSet, asFontStyle);
      end;
    end;

    Handled := false;
    for i := Low(BpFlags) to High(BpFlags) do
      if BpFlags[i] in AScLine.VisProps then
      begin
        CurrentAttrs.BackgroundColor := Fgs[i];
        CurrentAttrs.TextColor := Bgs[i];

        Handled := true;
      end;

    if not Handled then
    begin
      CurrentAttrs.BackgroundColor := SelectionBg;
      CurrentAttrs.TextColor := SelectionColor;
    end;

    Include(CurrentAttrs.AttributesSet, asBackgroundColor);
    Include(CurrentAttrs.AttributesSet, asTextColor);
  end;

  procedure ApplyCurAttributes(ABkOnly: Boolean = false);
  var
      st, std: TLMDEditAttributesSet;
      fs: TFontStyles;
      ovr: Boolean;
      HF: HFont;
  begin
    st := CurrentAttrs.AttributesSet;
    std := DefaultAttrs.AttributesSet;
    ovr := DefaultAttrsWeight > CurrentAttrsWeight;

    if not ABkOnly then
    begin
      if not (asFontStyle in st) then
        fs := DefaultAttrs.FontStyle
      else
        fs := DefaultAttrs.FontStyle + CurrentAttrs.FontStyle;

      HF := Che.GetFont(fs, CurrentAttrsCharset);
      SelectObject(HCnv, HF);

      if ((asTextColor in std) and ovr) or (not (asTextColor in st)) then
        SetTextColor(HCnv, ColorToRGB(DefaultAttrs.TextColor))
      else
        SetTextColor(HCnv, ColorToRGB(CurrentAttrs.TextColor));
    end;

    if ((asBackgroundColor in std) and ovr) or (not (asBackgroundColor in st))
    then
      SetBkColor(HCnv, ColorToRGB(DefaultAttrs.BackgroundColor))
    else
      SetBkColor(HCnv, ColorToRGB(CurrentAttrs.BackgroundColor));
  end;

  procedure PaintRect(const ARect: TRect);
  begin
	  ExtTextOut(HCnv, 0, 0, ETO_OPAQUE, @ARect, nil, 0, nil);
  end;

  function PaintText(AStartX: Integer; APaintBG: Boolean): Integer;
  var
    ScLine: TScrollLineInfo;
    Chunk: PChunk;

    procedure SetChunkStyle(AChunk: PChunk);
    var
        i: Integer;
        Handled: Boolean;
    begin
      CurrentAttrsWeight := AChunk.AttrsWeight;
      CurrentAttrs.AttributesSet := [];
      CurrentAttrsCharset := AChunk.CharSet;

      Handled := false;
      if not APrintMode then
      begin
        for i := Low(BpFlags) to High(BpFlags) do
          if BpFlags[i] in ScLine.VisProps then
          begin
            CurrentAttrs.BackgroundColor := Bgs[i];
            CurrentAttrs.TextColor := Fgs[i];

            Include(CurrentAttrs.AttributesSet, asBackgroundColor);
            Include(CurrentAttrs.AttributesSet, asTextColor);
            Handled := true;
          end;
      end;

      if not Handled then
      begin
        if asBackgroundColor in AChunk.Attrs.AttributesSet then
        begin
          if (not APrintMode) and
             (AChunk.Attrs.BackgroundColor = DefaultAttrs.BackgroundColor)
          then
          begin
            if lpFrame in ScLine.VisProps then
              CurrentAttrs.BackgroundColor := DebugFrameLineBg
            else if IsReadOnly then
              CurrentAttrs.BackgroundColor := ReadOnlyBgColor
            else if UseCursorLineColor then
              CurrentAttrs.BackgroundColor := SelectedLineBg
            else
              CurrentAttrs.BackgroundColor := AChunk.Attrs.BackgroundColor;
          end
          else
            CurrentAttrs.BackgroundColor := AChunk.Attrs.BackgroundColor;

          Include(CurrentAttrs.AttributesSet, asBackgroundColor);
        end
        else if not APrintMode then
        begin
          if lpFrame in ScLine.VisProps then
          begin
            CurrentAttrs.BackgroundColor := DebugFrameLineBg;
            Include(CurrentAttrs.AttributesSet, asBackgroundColor);
          end
          else if not (asBackgroundColor in DefaultAttrs.AttributesSet) then
          begin
            Include(CurrentAttrs.AttributesSet, asBackgroundColor);

            if IsReadOnly then
              CurrentAttrs.BackgroundColor := FReadOnlyBgColor
            else if UseCursorLineColor then
              CurrentAttrs.BackgroundColor := SelectedLineBg
            else
              Exclude(CurrentAttrs.AttributesSet, asBackgroundColor);
          end;
        end;

        Include(CurrentAttrs.AttributesSet, asTextColor);
        if asTextColor in AChunk.Attrs.AttributesSet then
          CurrentAttrs.TextColor := AChunk.Attrs.TextColor
        else if lpFrame in ScLine.VisProps then
          CurrentAttrs.TextColor := DebugFrameLineColor
        else
          Exclude(CurrentAttrs.AttributesSet, asTextColor);
      end;

      if asFontStyle in AChunk.Attrs.AttributesSet then
      begin
        CurrentAttrs.FontStyle := AChunk.Attrs.FontStyle;
        Include(CurrentAttrs.AttributesSet, asFontStyle);
      end;
    end;

    type TPartArr = array[0..2] of Integer;
    type TIsSelArr = array[0..2] of Boolean;

    procedure GetSelectedParts(AScrPos, AVisWidth: Integer;
                               var Parts: TPartArr;
                               var IsSel: TIsSelArr);
    var
      X, Y: Integer;
      Ok: Boolean;
      ScrS, ScrE: TPoint;
    begin
      IsSel[0] := False;

      Parts[0] := AVisWidth;
      Parts[1] := 0;
      Parts[2] := 0;

      if APrintMode then
        Exit;

      ScrS := SelScrS;
      ScrE := SelScrE;
      if Che.SelBlockMode then
        CorrectSelPointsBlockMode(ScrS, ScrE);

      X := AScrPos;
      Y := AScrollLine;

      Ok := LMDInRange(Y, ScrS.Y, ScrE.Y);
      if Che.SelBlockMode then
      begin
        Ok := Ok and (X < ScrE.X) and (X + AVisWidth > ScrS.X);
      end
      else
      begin
        Ok := Ok and ( (Y <> ScrS.Y) or (X + AVisWidth > ScrS.X) ) and
                     ( (Y <> ScrE.Y) or (X < ScrE.X) );
      end;

      if Ok then
      begin
        if (not Che.SelBlockMode) and (ScrS.Y < Y) then
          ScrS.X  := X
        else
          ScrS.X := LMDMinMax(ScrS.X, X, X + AVisWidth);

        if (not Che.SelBlockMode) and (ScrE.Y > Y) then
          ScrE.X  := X + AVisWidth
        else
          ScrE.X := LMDMinMax(ScrE.X, X, X + AVisWidth);

        IsSel[0] := X >= ScrS.X;
        if IsSel[0] then
        begin
          Parts[0] := ScrE.X - X;
          IsSel[1] := False;
          Parts[1] := AVisWidth - Parts[0];
        end
        else
        begin
          Parts[0] := ScrS.X - X;

          IsSel[1] := True;
          Parts[1] := ScrE.X - ScrS.X;

          IsSel[2] := False;
          Parts[2] := X + AVisWidth - ScrE.X;
        end;
      end;
    end;

  var
    Parts: TPartArr;
    IsSel: TIsSelArr;
    cnt, i, il, j, W, s: Integer;
    X, ScrollX: Integer;
    R: TRect;
    StartS: TWrapParserState;
    ChunkCnt: Integer;
    Fs: TFontStyles;

  begin
    ///

    if ALine < Che.LinesOnScreenScroll then
    begin
      ScLine := Che.GetScreenLine(ALine);
      Chunk := Che.GetScreenLineChunks(ALine, ChunkCnt);
      StartS := Che.GetScreenLineStart(ALine);

      X := AStartX + StartS.XPix - Che.HorizScrollPixels;
      ScrollX := StartS.X;
    end
    else
    begin
      ScLine.VisProps := [];
      ChunkCnt := 0;
      Chunk := nil;
      X := AStartX;
      ScrollX := 0;
    end;

    if lpLastWrap in ScLine.VisProps then
      cnt := 2
    else
      cnt := 1;

    repeat
      while ChunkCnt <> 0 do
      begin
        S := 0;

        GetSelectedParts(ScrollX, Chunk.CharsCount, Parts, IsSel);
        for i := 0 to 2 do
        begin
          if Parts[i]=0 then
            Continue;

          if IsSel[i] then
            SetSelectionStyle(Chunk, ScLine)
          else
            SetChunkStyle(Chunk);

          R := ARect;

          if FFontMetrics.tmInternalLeading > 0 then
            il := 0
          else
            il := 0;

          if not (asFontStyle in CurrentAttrs.AttributesSet)
          then
            Fs := DefaultAttrs.FontStyle
          else
            Fs := DefaultAttrs.FontStyle + CurrentAttrs.FontStyle;

          W := 0;
          for j := s to s + Parts[i] - 1 do
            W := W + Che.GetCharWidth(Chunk.Chars[j], Fs, CurrentAttrsCharset);

          R.Left := Max(X, R.Left);
          R.Right := Max(R.Left, X + W);

          if R.Left < R.Right then
          begin
            if APaintBG then
            begin
              ApplyCurAttributes(true);
              PaintRect(R)
            end
            else
            begin
              for j := s to s + Parts[i] - 1 do
                if Chunk.Chars[j] <> LMDSpace then
                  begin
                    ApplyCurAttributes;

                    R.Right := ARect.Right;
                    LMDSedTextRect(HCnv, R, X, R.Top - il, @Chunk.Chars[s], Parts[i], true);

                    Break;
                  end;
            end;
          end;

          X := X + W;
          S := S + Parts[i];

          Inc(ScrollX, Parts[i]);
        end;

        Inc(Chunk);
        Dec(ChunkCnt);
      end;

      if not APrintMode then
      begin
        Chunk := @ChunkWithSpace;
        ChunkCnt := 1;
      end;

      Dec(cnt);
    until cnt = 0;

    SetTailStyle(ScLine);

    Result := Max(0, X - AStartX);
  end;

var
  X, Ruler, SelS, SelE, Cnt: Integer;
  DefOvr: Boolean;
  ScrS, ScrE: TPoint;
  ScLine: TScrollLineInfo;
begin
  Bgs[0] := BreakpointLineBg;       Bgs[1] := DebugFrameTopLineBg;
  Bgs[2] := DebugFrameActiveLineBg;

  Fgs[0] := BreakpointLineColor;    Fgs[1] := DebugFrameTopLineColor;
  Fgs[2] := DebugFrameActiveLineColor;

  ////
  CursorY := self.CursorPosY;
  ALine := Args.ScreenLine;

  APrintMode := Args.PrintMode;

  Che := Args.Cache as TScreenCache;

  if APrintMode then
  begin
    ARect := Args.BgRect;

    HCnv := Args.Canvas.Handle;
  end
  else
  begin
    ARect.TopLeft := Point(0, 0);
    ARect.Right := Args.BgRect.Right - Args.BgRect.Left;
    ARect.Bottom := Args.BgRect.Bottom - Args.BgRect.Top;

    FLineBmp.Width := ARect.Right;
    FLineBmp.Height := ARect.Bottom;

    FLineBmp.Canvas.Pen.Color := FWrapRulerColor;
    HCnv := FLineBmp.Canvas.Handle;
  end;

  AScrollLine := Che.ScreenToScroll(ALine, false);
  ////////////////////

  DefaultAttrs.BackgroundColor := Args.DefaultBgColor;
  DefaultAttrs.TextColor := Args.DefaultColor;
  DefaultAttrs.FontStyle := Args.DefaultFont.Style;
  DefaultAttrs.CustomAttributes := nil;
  DefaultAttrs.AttributesSet := [];

  DefOvr := false;
  if (not APrintMode) and
     Assigned(OnGetLineAttributes) and
     (ALine < Che.LinesOnScreenScroll)
  then
    OnGetLineAttributes(Self, ScreenToScroll(ALine), DefaultAttrs,
                        DefOvr);

  if DefOvr then
    DefaultAttrsWeight := 1
  else
    DefaultAttrsWeight := 0;

  if not (asBackgroundColor in DefaultAttrs.AttributesSet) then
    DefaultAttrs.BackgroundColor := Args.DefaultBgColor;

  if not (asTextColor in DefaultAttrs.AttributesSet) then
    DefaultAttrs.TextColor := Args.DefaultColor;

  if not (asFontStyle in DefaultAttrs.AttributesSet) then
    DefaultAttrs.FontStyle := Args.DefaultFont.Style;

  Include(DefaultAttrs.AttributesSet, asFontStyle);
  DefaultAttrs.CustomAttributes := nil;
  ////////////////////
  CurrentAttrsWeight := 0;
  CurrentAttrs.AttributesSet := [];
  CurrentAttrsCharset := Args.DefaultFont.Charset;

  ApplyCurAttributes;
  PaintRect(ARect);

  X := ARect.Left + PaintText(ARect.Left, true);
  ////

  if X < ARect.Right then
  begin
    ApplyCurAttributes(true);
    PaintRect(Rect(X, ARect.Top, ARect.Right, ARect.Bottom));
  end;

  X := PaintText(ARect.Left, false);
  if Che.SelBlockMode and (not APrintMode) then
  begin
    if LMDInRange(AScrollLine, SelScrS.Y, SelScrE.Y) then
    begin
      ScrS := SelScrS;
      ScrE := SelScrE;
      CorrectSelPointsBlockMode(ScrS, ScrE);

      ScrS.Y := AScrollLine;
      ScrE.Y := ScrS.Y;

      Che.ScrollPosToScreenPix(ScrS, SelS, Cnt);
      Che.ScrollPosToScreenPix(ScrE, SelE, Cnt);

      if SelE > X then
      begin
        ScLine := Che.GetScreenLine(ALine);

        SetSelectionStyle(nil, ScLine);
        ApplyCurAttributes;

        SelS := Max(SelS, X);
        PaintRect(Rect(SelS, ARect.Top, SelE, ARect.Bottom));
      end;
    end;
  end;

  ////////////////////

  if (vsShowWrapRuler in FViewSettings) and not APrintMode then
  begin
    Ruler := WrapRulerWidth - HorizScroll;
    if Ruler > 0 then
    begin
      Ruler := ARect.Left + Che.ScrollXToPixelsFixed(Ruler);

      Windows.MoveToEx(HCnv, Ruler, ARect.Top, nil);
      Windows.LineTo(HCnv, Ruler, ARect.Bottom);
    end;
  end;

  if not APrintMode then
    Args.Canvas.Draw(Args.BgRect.Left, Args.BgRect.Top, FLineBmp);
end;

procedure TLMDCustomEditView.PaintTo(ACanvas: TCanvas; const ARect: TRect);
var
  i:     Integer;
  DR, R: TRect;
  Args: TLMDEditPaintTextArgs;
  SelScrS, SelScrE: TPoint;
begin
  try
    AddInternalState(siPainting);
    LockForViewEvent;

    SelScrS := Cache(self).SelStartN;
    SelScrE := Cache(self).SelEndN;

    DR := ARect;
    for i := 0 to Cache(self).ScreenHeightLines - 1 do
    begin
      R.Top    := DR.Top + FLineHeight * i;
      R.Bottom := R.Top + FLineHeight;
      R.Left   := 0;
      R.Right  := FGutterWidth;

      Args.ScreenLine := i;
      Args.BgRect := R;
      Args.ContentRect := R;
      Args.Cache := Cache(Self);
      Args.Canvas := ACanvas;
      Args.DefaultFont := FFont;
      Args.DefaultBgColor := Color;
      Args.DefaultColor := FFont.Color;
      Args.LineHeight := FLineHeight;
      Args.PrintMode := false;
      Args.PrintOptions := [];

      PaintGutterLine(Args);

      R.Left   := FGutterWidth;
      R.Right  := DR.Right;

      Args.ContentRect := R;
      Args.BgRect := R;

      PaintTextLine(Args, SelScrS, SelScrE);
    end;

  finally
    UnlockForViewEvent;
    RemoveInternalState(siPainting);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.IsScreenPointInSelection(
  AScreenPoint: TPoint): Boolean;//L+
var
  StartScr, EndScr, P: TPoint;
begin
  P := AScreenPoint;

  Result := Cache(self).SelectionToScreen(StartScr, EndScr) and
            LMDInRange(P.Y, StartScr.Y, EndScr.Y);

  if Result then
  begin
    if SelectionBlockMode then
      Result := LMDInRange(P.X, StartScr.X, EndScr.X)
    else
      Result := ((P.Y > StartScr.Y) or (P.X >= StartScr.X)) and
                ((P.Y < EndScr.Y) or (P.X < EndScr.X))
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.FireOnScroll(var ANewPos: Integer;
  ACode: TScrollCode; AVert: Boolean);
begin
  if Assigned(FOnScroll) then
    FOnScroll(Self, ACode, ANewPos);
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.FireOnGutterPaint(const Args: TLMDEditPaintTextArgs;
                                               ABar: TLMDGutterBar): Boolean;
var
  ok:     Boolean;
  Params: TLMDGutterPaintParams;
begin
  ok := False;
  if Assigned(FOnGutterPaint) and (ABar.Kind=gbCustom) then
  begin
    Params.ScreenLine := Args.ScreenLine;
    Params.Bar := ABar;
    Params.DefaultPainter := DefaultGutterPaintCbk;
    Params.Canvas := Args.Canvas;
    Params.Rect := Args.BgRect;

    LockForViewEvent;
    try
      FOldPen.Assign(Params.Canvas.Pen);
      FOldBrush.Assign(Params.Canvas.Brush);

      FOnGutterPaint(Self, Params, ok);
    finally
      UnlockForViewEvent;

      Params.Canvas.Pen.Assign(FOldPen);
      Params.Canvas.Brush.Assign(FOldBrush);
    end;
  end;
  Result := ok;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.AddStatusChange(AChange: TLMDViewStatusChange);
begin
  Include(FStatusChanges, AChange);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.AddStatusChange(AChanges: TLMDViewStatusChanges);
begin
  FStatusChanges := FStatusChanges + AChanges;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.FireOnStatusChanged;
begin
  if (Assigned(FOnStatusChanged) and (FStatusChanges<>[])) and
      (not (csLoading in ComponentState)) and
      (not (csReading in ComponentState))
  then
    FOnStatusChanged(Self, FStatusChanges);

  FStatusChanges := [];
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.InvalidateScreen(AFull: Boolean);//D-L+
var
  i: Integer;
  Ln: Integer;
  DoUpdate: Boolean;
begin
  Assert(not IsUpdating);

  if not HandleAllocated then
    Exit;

  AFull := AFull or (FGutterWidth<>FOldGutterWidth);
  DoUpdate := AFull;

  if AFull then
    SedInvalidateRect(Handle, GetDrawRect)
  else
  begin
    Ln := Max(Cache(self).OldLinesOnScreenScroll, LinesOnScreenScroll);
    for i := 0 to Ln-1 do
      if (i>=LinesOnScreenScroll) or Cache(Self).IsScreenLineDirty(i) then
      begin
        SedInvalidateRect(Handle, ScreenLineToClient(i));
        DoUpdate := true;
      end;
  end;

  Cache(Self).UnsetDirties;

  if DoUpdate then
    UpdateWindow(Handle);
end;

procedure TLMDCustomEditView.InvalidateScrollLine(AScrollLine: Integer);
var
    Scr: Integer;
begin
  if LMDInRange(AScrollLine, TopLineScroll, LastLineScroll) then
  begin
    Scr := AScrollLine - TopLineScroll;
    SedInvalidateRect(Handle, ScreenLineToClient(Scr));
  end;
end;

procedure TLMDCustomEditView.InvokeCommand(ACommand: TLMDEditCommand;
                                           AllowCommandEvents: Boolean);
var
    Dummy: Variant;
begin
  Dummy := Unassigned;
  InvokeCommand(ACommand, Dummy, AllowCommandEvents);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.Paint;//S+C+L+UD-UV-EE+E+
begin
  if siDestroing in FState then
    Exit;

  PaintTo(GetCanvas, GetDrawRect);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DragCanceled;
begin
  if siDestroing in FState then
    Exit;

  StopScrollTimer;

  BeginUpdate;
  try
    Cache(self).SetCursorOffset(FCursorBeforeDrag, scBackward, SelectionBlockMode);
    FCursorBeforeDrag.Offset := -1;
    FCursorBeforeDrag.InCharOffset := -1;
  finally
    EndUpdate;
  end;

  inherited;
end;

procedure TLMDCustomEditView.DragDrop(Source: TObject; X, Y: Integer);
var
  Str: TLMDString;
  SrcView: TLMDCustomEditView;
  DoDrop, DropMove: Boolean;
  StartS, EndS, Cr: TPoint;
  StartOff, EndOff, MaxWidth: Integer;
  Info: TLMDDocUndoInfo;
  Off: TOffsetPoint;
begin
  Assert(not (siDestroing in FState));

  if  (Document <> nil) and
      (not Document.ReadOnly)  and
      (not ReadOnly) and
      (Source is TLMDCustomEditView) and
      TLMDCustomEditView(Source).SelAvail
  then
  begin
    inherited;

    SrcView := Source as TLMDCustomEditView;

    RemoveInternalState(siComplIncSearch);

    StopScrollTimer;
    if SrcView <> self then
      SrcView.StopScrollTimer;

    DropMove := (GetKeyState(VK_CONTROL) >= 0) and
                (not SrcView.IsReadOnly) and
                (not ReadOnly);

    if Source <> Self then
      DoDrop := True
    else
    begin
      StartS := SelStartN;
      EndS := SelEndN;
      Cr := CursorPos;

      if SelectionBlockMode then
      begin
        CorrectSelPointsBlockMode(StartS, EndS);
        DoDrop := not (LMDInRange(Cr.Y, StartS.Y, EndS.Y) and
                       LMDInRange(Cr.X, StartS.X, EndS.X));
      end
      else
        DoDrop := (Cr.Y < StartS.Y) or
                  ((Cr.Y = StartS.Y) and (Cr.X < StartS.X)) or
                  (Cr.Y > EndS.Y) or
                  ((Cr.Y = EndS.Y) and (Cr.X > EndS.X));
    end;

    if DoDrop then
    begin
      Str := SrcView.GetSelectedText;

      if SrcView = self then
        Info := CreateUndoInfo(FCursorBeforeDrag)
      else
        Info := CreateCursorUndoInfo;

      FDocInternal.BeginCompoundAction(FAuthorID, Info, true);
      try
        if DropMove then
        begin
          StartS := SrcView.SelectionStartNorm;
          EndS := SrcView.SelectionEndNorm;

          if SrcView.SelectionBlockMode then
            SrcView.DeleteInScrollBlock(StartS, EndS, Off)
          else
            SrcView.DeleteInScroll(StartS, EndS);
        end;

        if SrcView.SelectionBlockMode then
        begin
          InsertInScrollBlock(CursorPos, Str, MaxWidth, StartOff, EndOff);

          StartS := Cache(self).OffsetToScroll(StartOff);
          EndS := Cache(self).OffsetToScroll(EndOff);
          EndS.X := StartS.X + MaxWidth;

          SetSelection(StartS, EndS, true);
        end
        else
        begin
          InsertInScrollEx(CursorPos, Str, false, StartOff, EndOff, true);
          SetSelection(StartOff, EndOff, false);
        end;

        CursorOffset := StartOff;
        if SrcView <> self then
          SrcView.CancelSelection;
      finally
        Document.EndCompoundEdit(true);
      end;

      FCursorBeforeDrag.Offset := -1;
      FCursorBeforeDrag.InCharOffset := -1;

      SrcView.FCursorBeforeDrag.Offset := -1;
      SrcView.FCursorBeforeDrag.InCharOffset := -1;
    end;
  end
  else
    inherited;
end;

procedure TLMDCustomEditView.DragOver(Source: TObject; X, Y: Integer;
                                      State: TDragState;
                                      var Accept: Boolean);
var
  StartS, EndS, Cr: TPoint;
  DoDrop: Boolean;
begin
  if IsReadOnly or (siDestroing in FState) then
  begin
    Accept := false;
    Exit;
  end;

  inherited;

  if (Document <> nil) and
     (not Document.ReadOnly) and
     ((Source is TLMDCustomEditView) or (Source = nil))  then
  begin
    Accept := PtInRect(GetDrawRect, Point(X, Y));

    if Source <> nil then
    begin
      if not Accept then
        DragCursor := crNo
      //Ctrl is pressed => change cursor to indicate copy instead of move
      else if GetKeyState(VK_CONTROL) < 0 then
        DragCursor := crMultiDrag
      else
        DragCursor := crDrag;
    end;

    if Accept and (State <> dsDragLeave) then
    begin
      if not Focused then
        SetFocus;

      CursorPos := ClientToScrollPos(Point(X, Y));
    end;

    if (Source <> Self) and (Source <> nil) then
    begin
      if (Source as TLMDCustomEditView).IsReadOnly then
        DragCursor := crMultiDrag;

      (Source as TLMDCustomEditView).DragCursor := Self.DragCursor;
    end
    else if Source = Self then
    begin
      StartS := SelStartN;
      EndS := SelEndN;
      Cr := CursorPos;

      if SelectionBlockMode then
      begin
        CorrectSelPointsBlockMode(StartS, EndS);
        DoDrop := not (LMDInRange(Cr.Y, StartS.Y, EndS.Y) and
                       LMDInRange(Cr.X, StartS.X, EndS.X));
      end
      else
        DoDrop := (Cr.Y < StartS.Y) or
                  ((Cr.Y = StartS.Y) and (Cr.X < StartS.X)) or
                  (Cr.Y > EndS.Y) or
                  ((Cr.Y = EndS.Y) and (Cr.X > EndS.X));


      if DoDrop then
        DragCursor := crDrag
      else
        DragCursor := crNoDrop;
    end;
  end;

  CheckStartScrollTimer(X, Y, true);
end;

procedure TLMDCustomEditView.DrawBmp(ACnv: TCanvas; ABmp: Graphics.TBitmap;
                                     const R: TRect;
                                     Alignement: TAlignment);
var
  X, Y: Integer;
begin
  if Assigned(ABmp) then
  begin
    X := -1;
    case Alignement of
      taLeftJustify:
        X := R.Left;

      taRightJustify:
        X := R.Left + (LMDRectWidth(R) - ABmp.Width);

      taCenter:
        X := R.Left + ((LMDRectWidth(R) - ABmp.Width) div 2);
    else
      Assert(false);
    end;

    Y := R.Top + ((LMDRectHeight(R) - ABmp.Height) div 2);
    ACnv.Draw(X, Y, ABmp);
  end;
end;

procedure TLMDCustomEditView.DrawRectChanged;
begin
  BeginSettingsChange;
  try
    RemoveInternalState([siComplTimer, siComplListShown]);

    RecalkScreenVars;
  finally
    EndSettingsChange(false, false);
  end;
end;

{***************************** TLMDEditCustomView *****************************}
{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CreateHandle;
var
    Stl: DWORD;
begin
  Assert(not (siDestroing in FState));

  inherited;

  Stl := GetWindowLong( Handle, GWL_STYLE);
  SetWindowLong(Handle, GWL_STYLE,  Stl or ES_MULTILINE);

  BeginUpdate;
  EndUpdate(true);

  (*BCB6 bug*)
  {$IFDEF LMDCOMP7} OleCheck(RegisterDragDrop(Handle, Self)); {$ENDIF}
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
  ClassStylesOff = CS_VREDRAW or CS_HREDRAW;

var
  ClsName: AnsiString;
begin
  Assert(not (siDestroing in FState));

  inherited CreateParams(Params);

  with Params do
  begin
    WindowClass.Style := WindowClass.Style and not ClassStylesOff;
    Style := Style or ES_AUTOVSCROLL or ES_MULTILINE or
             BorderStyles[FBorderStyle];

    if NewStyleControls and Ctl3D and (fBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;

    ClsName := AnsiString(LMDReplaceRegExpr('(?i)lmd', ClassName, 'L_M_D'));

    StrPCopy(WinClassName, {$IFDEF LMDCOMP12}String{$ENDIF}(ClsName));
  end;

end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CreateWnd;
begin
  Assert(not (siDestroing in FState));

  inherited;

  UpdateWinStyle;
  if not IsUpdating then
    UpdateScrollBars;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DestroyWnd;
begin
  RemoveInternalState(siComplAll);

  {$IFDEF LMDCOMP7} (*BCB6 bug*)
  if HandleAllocated then
    RevokeDragDrop(Handle);
  {$ENDIF}

  RecalkScreenVars;
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.CreateWindowHandle(const Params: TCreateParams);
begin
  Assert(not (siDestroing in FState));

  LMDCreateControlHandle(Self, Params, '');
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetCanvas: TCanvas;
begin
  Result := Self.Canvas;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.GetDrawRect: TRect;
begin
  Result := GetClientRect;
end;

function TLMDCustomEditView.GetHorizScroll: Integer;
begin
  Result := Cache(self).HorizScroll;
end;

{------------------------------------------------------------------------------}

function TLMDCustomEditView.CharsOnScreen: Integer;
var
    Last: Integer;
    LastOff: TOffsetPoint;
begin
  Last := TopLineScroll + ScreenHeightFullVis - 1;
  Cache(self).CorrectToLastScroll(Last);

  LastOff := Cache(self).GetScrollLineOffLast(Last);

  Result := LastOff.Offset - Cache(self).FirstCharOnScreen + 1;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UpdateScrollbars;
const
  MAX_SCROLL: Integer = 32767;
var
  OldInfo, ScrollInfo: TScrollInfo;
  MaxW, MaxH:          Integer;
  Ok:                  Boolean;
  SbVisible:           Boolean;

  procedure SetBars(AKind: Integer);
  var
    FVis: Boolean;
  begin
    ScrollInfo.cbSize := sizeof(ScrollInfo);
    ScrollInfo.fMask := SIF_PAGE or SIF_RANGE or SIF_POS;

    OldInfo.cbSize := sizeof(OldInfo);
    OldInfo.fMask := SIF_PAGE or SIF_RANGE or SIF_POS;
    Ok := GetScrollInfo(Handle, AKind, OldInfo);

    case AKind of
      SB_VERT: FVis := FScrollBarVisibleY;
      SB_HORZ: FVis := FScrollBarVisibleX;
    else
      FVis := false;
      Assert(false);
    end;

    SbVisible  := not(vsHideShowScrollbars in ViewSettings) or
                  (ScrollInfo.nMax >= Integer(ScrollInfo.nPage));

    Ok := Ok and
          (OldInfo.nMin=ScrollInfo.nMin)    and
          (OldInfo.nMax=ScrollInfo.nMax)    and
          (OldInfo.nPage=ScrollInfo.nPage)  and
          (OldInfo.nPos=ScrollInfo.nPos)    and
          (SbVisible=FVis);

    if not Ok then
    begin
      SetScrollInfo(Handle, AKind, ScrollInfo, True);

//    The following code was disabled, because it produce scroll bar flickers
//    while typing text. Scroll bar temparary become re-drawn with old, win95
//    like look (without accounting to visual styles).
//
//      if (ScrollInfo.nPos = 0) and (ScrollInfo.nMax < Integer(ScrollInfo.nPage)) then
//        EnableScrollBar(Handle, AKind, ESB_DISABLE_BOTH)
//      else
//      begin
//        EnableScrollBar(Handle, AKind, ESB_ENABLE_BOTH);
//        if (ScrollInfo.nPos = 0) then
//          EnableScrollBar(Handle, AKind, ESB_DISABLE_UP)
//        else if (ScrollInfo.nPos > (ScrollInfo.nMax - Integer(ScrollInfo.nPage))) then
//          EnableScrollBar(Handle, AKind, ESB_DISABLE_DOWN)
//      end;

      ShowScrollBar(Handle, AKind, SbVisible);

      case AKind of
        SB_VERT: FScrollBarVisibleY := SbVisible;
        SB_HORZ: FScrollBarVisibleX := SbVisible;
      else
        Assert(false);
      end;
    end;
  end;

var
    CursorVis: Boolean;
    First, X: Integer;
    OldS: TScrollInfo;
begin
  Assert(not IsUpdating);

  if siScrollbarsUpdating in FState then
    Exit;
  Include(FState, siScrollbarsUpdating);

  CursorVis := IsCursorInScreenBounds;
  try
    if FScrollBars <> {$IFNDEF LMDCOMP17}StdCtrls.{$ENDIF}ssNone then
    begin
      if (FScrollBars in [ssBoth, ssHorizontal]) and
         (WrapMode <> wmWrapToWindow)
      then
      begin
        MaxW := MaxHorizScrollActual;
        FMaxHorizScroll := MaxW;

        X := Cache(self).PixelsToScrollXFixed(Cache(self).ScreenWidthPixels, false);
        ScrollInfo.nMin := 0;
        ScrollInfo.nMax := MaxW;
        ScrollInfo.nPage := X;
        ScrollInfo.nPos := HorizScroll;

        if MaxW > MAX_SCROLL then
        begin
          ScrollInfo.nMax := MAX_SCROLL;
          ScrollInfo.nPage := MulDiv(MAX_SCROLL, ScrollInfo.nPage, MaxW);
          ScrollInfo.nPos := MulDiv(MAX_SCROLL, ScrollInfo.nPos, MaxW);
        end;

        SetBars(SB_HORZ);
      end
      else
      begin
        ShowScrollBar(Handle, SB_HORZ, False);
        FScrollBarVisibleX := false;
      end;

      if FScrollBars in [ssBoth, ssVertical] then
      begin
        if vsPreciseScrollbars in FViewSettings then
        begin
          MaxH := Cache(self).CalkVisibleCountScrollBar(false) - 1;
          ScrollInfo.nPage := ScreenHeightFullVis;
          ScrollInfo.nPos := TopLineScroll;

          if MaxH < (ScrollInfo.nPos + Integer(ScrollInfo.nPage) - 1) then
          begin
            MaxH := ScrollInfo.nPos + Integer(ScrollInfo.nPage) - 1;
            Cache(self).CalkVisibleCountScrollBar(true);
          end;
        end
        else if NoWrap then
        begin
          MaxH := GetVisibleCountScroll - 1;
          ScrollInfo.nPage := ScreenHeightFullVis;
          ScrollInfo.nPos := TopLineScroll;
        end
        else
        begin
          MaxH := MyDoc.CharsCount;

          ScrollInfo.nPage := CharsOnScreen;

          First := Cache(self).FirstCharOnScreen;

          ScrollInfo.nPos := First;
        end;

        ScrollInfo.nMin := 0;
        ScrollInfo.nMax := MaxH;

        if MaxH >= MAX_SCROLL then
        begin
          OldS := ScrollInfo;
          ScrollInfo.nPage := MulDiv(MAX_SCROLL, ScrollInfo.nPage, MaxH);
          ScrollInfo.nMax := MAX_SCROLL;
          ScrollInfo.nPos := MulDiv(MAX_SCROLL, ScrollInfo.nPos, MaxH);

          if (OldS.nPos > (OldS.nMax - Integer(OldS.nPage))) and
             (ScrollInfo.nPos <=
              (ScrollInfo.nMax - Integer(ScrollInfo.nPage)))
          then
            ScrollInfo.nPos := ScrollInfo.nMax -
                               Integer(ScrollInfo.nPage) + 1;
        end;

        SetBars(SB_VERT);
      end
      else
      begin
        ShowScrollBar(Handle, SB_VERT, False);
        FScrollBarVisibleY := false;
      end;
    end
    else
    begin
      ShowScrollBar(Handle, SB_BOTH, False);
      FScrollBarVisibleY := false;
      FScrollBarVisibleX := false;
    end;
  finally
    Exclude(FState, siScrollbarsUpdating);
  end;

  if CursorVis and (not IsCursorInScreenBounds) then
    ScrollToCursor;
end;

procedure TLMDCustomEditView.UpdateAddictCheckTokenIds;
var
    i, j, k, L: Integer;
    Parser: TLMDEditParserBase;
    Strs: TLMDMemoryStrings;
    S: TLMDString;
    Arr: TLMDIntArray;
begin
  SetLength(Arr, 0);
  ClearAddictCheckTokenIds;

  Strs := TLMDMemoryStrings.Create;
  try
    Parser := MyDoc.GetParser;

    for i := 0 to FAddictCheckTokens.Count - 1 do
    begin
      S := FAddictCheckTokens[i];
      LMDSplitRegExpr('\s+', S, Strs);

      for j := 0 to Strs.Count - 1 do
      begin
        Arr := Parser.GetAllTokenIDs(Strs[j]);
        for k := 0 to Length(Arr) - 1 do
        begin
          L := Length(FAddictCheckTokenIds);
          SetLength(FAddictCheckTokenIds, L+1);

          FAddictCheckTokenIds[L] := Arr[k];
        end;
      end;
    end;

    if Length(FAddictCheckTokenIds)>0 then
      LMDIntArrayShortSort(0, Length(FAddictCheckTokenIds)-1, FAddictCheckTokenIds);
  finally
    Strs.Free;
  end;
end;

procedure TLMDCustomEditView.UpdateWinStyle;
var
    OldS, Style: DWORD;
begin
  if HandleAllocated then
  begin
    OldS := GetWindowLong(Handle, GWL_STYLE);
    if WrapMode <> wmNoWrap then
      Style := OldS or ES_MULTILINE
    else
      Style := OldS and (not ES_MULTILINE);

    if OldS <> Style then
    begin
      RemoveInternalState(siComplAll);

      SetWindowLong(Handle, GWL_STYLE, Style);
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MouseDown(Button: TMouseButton;
 Shift: TShiftState; X, Y: Integer);
var
  Scrn, Scrl: TPoint;
  R: TRect;
  GutterHandled, ScrInSel, OutOf, BlockSel: Boolean;
  Ph, ScrLine, Off: Integer; Bar: TLMDGutterBar;
  Info: TScrollLineInfo;
  WordL, WordR: TLMDSegment;
  LineSeg: TLMDSegment;
  Part: TLMDEditScreenPart;
  LineS, LineE: TOffsetPoint;

  function TripleClick: Boolean;
  var
      Diff: TDateTime;
  begin
    Diff := Time - FLastDoubleClickTime;
    Result := Diff <= FSysDoubleClickTime;
  end;

  procedure SetupSelectByLines;
  begin
    MouseCapture := True;
    Exclude(FState, siWaitDrag);
    Include(FState, siMouseSelectByLines);

    SetSelection(LineS, LineE, false);
    SetCursorPos(Point(0, Scrl.Y));
    ScrollToCursor;

    FLastDoubleClickTime := 0;
  end;

begin
  if siDestroing in FState then
    Exit;

  inherited MouseDown(Button, Shift, X, Y);
  MouseCapture := False;

  BlockSel := ssAlt in Shift;

  FMouseDownX := X;
  FMouseDownY := Y;
  FCursorBeforeDrag := Cache(self).CursorOffset;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    GutterHandled := false;

    Scrn := ClientToScreenPos(Point(X, Y), Part);
    if (Part = spText) and (not ((ssDouble in Shift) or TripleClick)) then
    begin
      //Correct the screen point for better mouse selection experience
      Scrl := ScreenPosToScrollLow(Scrn);
      R := ScrollPosToClient(Scrl, OutOf);
      if (not OutOf) and PtInRect(R, Point(X, Y)) then
      begin
        if (X - R.Left) >= (R.Right - X) then
          Inc(Scrn.X);
      end;
    end;

    case part of
      spGutterText,
      spGutterPastText:
        FireGutterClick(Button, Shift, Point(X, Y), GutterHandled);
    end;

    if not GutterHandled then
    begin
      Scrl := ScreenPosToScrollLow(Scrn);
      Cache(self).CorrectScrollPoint(Scrl, scForCursor, scBackward, BlockSel);
      ScrInSel := IsScreenPointInSelection(Scrn);

      Info := Cache(self).GetScrollLineInfo(Scrl.Y);
      Cache(self).GetPhysLineVisibleBounds(Info.PhysicalLine, LineS, LineE);

      case Part of
        spText,
        spPastText,
        spGutterPastText:
        begin
          if (Button = mbRight) and (not ScrInSel) and
             (vsRightClickMovesCursor in FViewSettings)
          then
          begin
            CursorPos := Scrl;
            CancelSelection;
          end
          else if Button = mbLeft then
          begin
            LineSeg.Start := LineS.Offset;
            LineSeg.Count := LineE.Offset - LineS.Offset;

            LineSeg.Source := MyDoc.Chars;

            if (not ScrInSel) or (ssDouble in Shift) then
              CursorPos := Scrl;

            if ssDouble in Shift then
            begin
              MouseCapture := True;

              Exclude(FState, siWaitDrag);
              Include(FState, siMouseSelectByWords);

              Off := CursorOffset;

              if Off <> LineS.Offset then
                WordL := MyDoc.FindPrevWord(Off, Off - LineS.Offset + 1)
              else
                WordL := LMDBadSegment;

              WordR := MyDoc.FindNextWord(Off, LineE.Offset - Off);

              if (not LMDSegIsBad(WordL)) and
                 (LMDSegIsBad(WordR) or
                  ((Off-LMDSegEnd(WordL)) < (WordR.Start-Off)))
              then
                SetSelection(WordL.Start, Min(LineE.Offset, LMDSegEnd(WordL)+1), BlockSel)
              else if not LMDSegIsBad(WordR) then
                SetSelection(WordR.Start, Min(LineE.Offset, LMDSegEnd(WordR)+1), BlockSel)
              else
                SetSelection(LineS, LineE, BlockSel);

              FLastDoubleClickTime := Time;
            end
            else if TripleClick then
              SetupSelectByLines
            else
            begin
              MouseCapture := True;

              if (vsDragDropEditing in ViewSettings) and
                 (part = spText) and ScrInSel
              then
                Include(FState, siWaitDrag)
              else
              begin
                Exclude(FState, siWaitDrag);

                if ScrInSel then
                begin
                  CursorPos := Scrl;
                  CancelSelection;
                end
                else if not (siDoubleClicked in FState) then
                begin
                  if ssShift in Shift then
                    SetSelection(SelectionStart, Scrl, BlockSel)
                  else
                    CancelSelection;
                end
              end
            end;
          end;

          ScrollToCursor;
          SaveCursorMaxHoriz;
        end;

        spGutterText:
        begin
          ClientToGutterScreen(Point(X, Y), ScrLine, Bar);

          if (Bar.Kind=gbFoldBar) and (Button=mbLeft) then
          begin
            Ph := ScreenToPhysical(ScrLine);

            if IsCollapsedFold(Ph) then
              Unfold(Ph, ssCtrl in Shift)
            else if IsFoldStart(Ph) then
              Fold(Ph, ssCtrl in Shift);
          end
          else if (Bar.Kind=gbLineNumberBar) and (Button=mbLeft) then
            SetupSelectByLines;
        end;
      else
        Assert(false);
      end;
    end;
  finally
    EndUpdate;
  end;

  ///
  Windows.SetFocus(Handle);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Scr, P, OldCursor: TPoint;
  DirFwd: Boolean;
  GoodDiff: Boolean;
  BlockSel: Boolean;
begin
  if siDestroing in FState then
    Exit;

  inherited MouseMove(Shift, x, y);

  if MouseCapture and (siWaitDrag in FState) then
  begin
    if (Abs(FMouseDownX - X) >= GetSystemMetrics(SM_CXDRAG))
      or (Abs(FMouseDownY - Y) >= GetSystemMetrics(SM_CYDRAG)) then
    begin
      Exclude(FState, siWaitDrag);
      BeginDrag(False);
    end;
  end
  else if (ssLeft in Shift) and MouseCapture then
  begin
    BeginUpdate;
    try
      BlockSel := ssAlt in Shift;

      Scr := ClientToScrollPos(Point(X, Y));
      CheckStartScrollTimer(X, Y, false);

      if IsDocumentSet then
      begin
        DirFwd := (SelectionStart.Y < CursorPos.Y) or
                  ((SelectionStart.Y = CursorPos.Y) and
                   (SelectionStart.X < CursorPos.X));

        GoodDiff := Abs(X - FMouseDownX) >= 3;
        if GoodDiff then
        begin
          OldCursor := CursorPos;
          CursorPos := Scr;

          if siMouseSelectByWords in FState then
          begin
            if BlockSel then
              P := CursorPos
            else
              P := FindNextEndOrStartOfWord(CursorPos, DirFwd);

            SetSelection( SelectionStart, P, BlockSel);
          end
          else if siMouseSelectByLines in FState then
          begin
            SetSelection( SelectionStart,
                          FindNextEndOrStartOfLine(CursorPos, DirFwd),
                          false);

            P := Point(0, SelectionEnd.Y);
            ScrollToPos(P);
          end
          else if not LMDPointsEqual(OldCursor, CursorPos) then
          begin
            if (not BlockSel) or SelAvail then
              SetSelection( SelectionStart, CursorPos, BlockSel)
            else
              SetSelection( OldCursor, CursorPos, BlockSel);
          end;
        end;
      end
      else
        CursorPos := Scr;

      SaveCursorMaxHoriz;
    finally
      EndUpdate;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.MouseUp(Button: TMouseButton;
                                     Shift: TShiftState;
                                     X, Y: Integer);
begin
  if siDestroing in FState then
    Exit;

  inherited MouseUp(Button, Shift, X, Y);

  StopScrollTimer;
  MouseCapture := False;

  if (Button = mbRight) and (Shift = [ssRight]) and Assigned(PopupMenu) then
    Exit;

  BeginUpdate;

  try
    if FState * [siDoubleClicked, siWaitDrag] = [siWaitDrag] then
    begin
      CursorPos := ClientToScrollPos(Point(X, Y));

      if not (ssShift in Shift) then
        CancelSelection
      else
        Cache(self).SelEnd := CursorPos;

      SaveCursorMaxHoriz;

      Exclude(FState, siWaitDrag);
    end;

    Exclude(FState, siDoubleClicked);
    Exclude(FState, siMouseSelectByWords);
    Exclude(FState, siMouseSelectByLines);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.KeyPress(var Key: Char);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.KeyPressW(var Key: TLMDChar);
var Str: TLMDString;
begin
  if (Key >= #32) and (Key <> #127) then
  begin
    Str := Key;

    if siIncrementalSearch in FState then
      InvokeCommand(sedIncrementalSearchAddChar, Str, true)
    else
      InvokeCommand(sedChar, Str, true);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DoKeyPressW(var AMsg: TWMKey);
var
  Form: TCustomForm;
  Key: TLMDChar;
begin
  if FIgnoreKeyPress then
  begin
    FIgnoreKeyPress := False;
    Exit;
  end;

  Key := TLMDChar(AMsg.CharCode);

  Form := GetParentForm(Self);
  if (Form <> nil) and (Form <> TWinControl(Self)) and Form.KeyPreview and
    (Key <= High(AnsiChar)) and THackWinControl(Form).DoKeyPress(AMsg)
  then
    Exit;

  Key := LMDGetCharFromMsg(AMsg);

  if (csNoStdEvents in ControlStyle) then
    Exit;

  if Assigned(FOnKeyPressW) then
    FOnKeyPressW(Self, Key);

  if TLMDChar(Key) <> #0 then
    KeyPressW(Key);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.Beep;
begin
  SysUtils.Beep;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.KeyDown(var Key: Word; Shift: TShiftState);

var
    Handled: Boolean;

procedure CancelCommand;
begin
  FPressedShortcut := 0;
  FPressedShortcutDefault := false;
end;

procedure ExecDefaultCmd(ACommand: TLMDEditCommand);
var
    Itm: TLMDEditCommandItem;
begin
  Itm := FCustomCommands.FindCommand(ACommand);
  if Itm = nil then
  begin
    InvokeCommand(ACommand, true);
    Handled := true;
  end;

  CancelCommand;
end;

procedure ExecCmd(ACommand: TLMDEditCommand);
begin
  InvokeCommand(ACommand, true);
  Handled := true;
  CancelCommand;
end;

var
  Bind: TLMDEditCommandBinding;
  LShift: TShiftState;
  LKey: Word;
  Mode: TLMDEditCommandMode;
begin
  if siDestroing in FState then
    Exit;

  BeginUpdate;
  try
    inherited;

    Handled := false;
    FIgnoreKeyPress := True;

    if siIncrementalSearch in FState then
      Mode := cmForIncSearch
    else if siComplListShown in FState then
      Mode := cmForCompletion
    else
      Mode := cmForView;

    if ((Shift = [ssAlt, ssCtrl]) or (Shift = [ssAlt, ssCtrl, ssShift])) and
       (not (Key in [VK_LBUTTON..VK_ESCAPE])) and
       (not (Key in [VK_PRIOR..VK_HELP]))
    then
    begin
       //AltGr combination for European users
       FIgnoreKeyPress := false;
    end
    else
    begin
      if FPressedShortcut = 0 then
      begin
        Bind := FCustomCommands.FindBinding(Key, Shift, [Mode]);
        if Bind <> nil then
        begin
          if Bind.Shortcut2 = 0 then
            ExecCmd(Bind.ParentItem.Command)
          else
          begin
            FPressedShortcut := Bind.Shortcut;
            FPressedShortcutDefault := false;
          end;
        end
        else if FDefaultCommands.FindBinding(Key, Shift, [Mode]) <> nil then
        begin
          Bind := FDefaultCommands.FindBinding(Key, Shift, [Mode]);
          if Bind.Shortcut2 = 0 then
            ExecDefaultCmd(Bind.ParentItem.Command)
          else
          begin
            FPressedShortcut := Bind.Shortcut;
            FPressedShortcutDefault := true;
          end;
        end;

        if not Handled then
          FIgnoreKeyPress := ssCtrl in Shift
        else
        begin
          Key := 0;
          FIgnoreKeyPress := true;
        end;
      end
      else
      begin
        if Key = VK_ESCAPE then
          CancelCommand
        else
        begin
          ShortCutToKeys(FPressedShortcut, LKey, LShift);

          if FPressedShortcutDefault then
          begin
            Bind := FDefaultCommands.FindBinding(LKey, LShift, Key, Shift, [Mode]);
            if Bind <> nil then
              ExecDefaultCmd(Bind.ParentItem.Command)
            else
              CancelCommand;
          end
          else
          begin
            Bind := FCustomCommands.FindBinding(LKey, LShift, Key, Shift, [Mode]);
            if Bind <> nil then
              ExecCmd(Bind.ParentItem.Command)
            else
            begin
              Bind := FDefaultCommands.FindBinding(LKey, LShift, Key, Shift, [Mode]);
              if Bind <> nil then
                ExecDefaultCmd(Bind.ParentItem.Command)
              else
                CancelCommand;
            end;
          end;

          if not Handled then
            FIgnoreKeyPress := ssCtrl in Shift
          else
          begin
            FIgnoreKeyPress := true;
            Key := 0;
          end;
        end;
      end;
    end;
  finally
    EndUpdate
  end
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.ScrollTimerHandler(Sender: TObject);
begin
  if not Focused then
  begin
    StopScrollTimer;
    Exit;
  end;

  Assert((FScrollDirX<>0) or (FScrollDirY<>0));

  BeginUpdate;
  try
    if FScrollDirY<>0 then
      ScrollVertWithCode(FScrollDirY, scPosition, false);

    if FScrollDirX<>0 then
      HorizScroll := Max(0, HorizScroll + FScrollDirX);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;

  if siDestroing in FState then
    Exit;

  Self.HideViewCaret(true);
  Self.DestroyViewCaret;
  StopScrollTimer;

  RemoveInternalState([siComplTimer, siComplListShown]);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMSetCursor(var Msg: TWMSetCursor);
begin
  if siDestroing in FState then
  begin
    inherited;
    Exit;
  end;

  if (Msg.HitTest = HTCLIENT) and (Msg.CursorWnd = Handle) and
    not(csDesigning in ComponentState) then
  begin
    UpdateMouseCursor;
  end
  else
    inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.UpdateMouseCursor;
var
  Win: TPoint;
  Scr: TPoint;
  Part: TLMDEditScreenPart;
  NewCursor: TCursor;
  Bar: TLMDGutterBar;
  Ln: Integer;
begin
  Windows.GetCursorPos(Win);
  Win := ScreenToClient(Win);

  if (Win.X < FGutterWidth) then
  begin
    if ClientToGutter(Win, Ln, Bar) and (Bar <> nil) and
       (Bar.Kind = gbLineNumberBar)
    then
      SetCursor(FLineNumScreenCursor)
    else
      SetCursor(Screen.Cursors[FGutterCursor])
  end
  else
  begin
    Scr := ClientToScreenPos(Win, Part);

    if vsDragDropEditing in ViewSettings then
    begin
      if IsScreenPointInSelection(Scr) then
        NewCursor := crArrow
      else
        NewCursor := crIBeam;
    end
    else
      NewCursor := crIBeam;

    try
      FireGetMouseCursor(ScreenPosToScrollLow(Scr, false), NewCursor)
    finally
      SetCursor(Screen.Cursors[NewCursor])
    end
  end;
end;

procedure TLMDCustomEditView.UpdatePrintTasksFont;
var
  i: Integer;
begin
  for i := 0 to FPrintTasks.Count - 1 do
    TLMDEditViewPrintTask(FPrintTasks[i]).UpdateViewFont;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMSetFocus(var Msg: TWMSetFocus);
begin
  if siDestroing in FState then
    Exit;

  if Focused then
  begin
    GetParentForm(Self).ActiveControl := Self;

    UpdateViewCaret;

    StopCompletionTimer;
    RemoveInternalState([siComplTimer, siComplListShown]);
  end;
end;

{------------------------------------------------------------------------------}


procedure TLMDCustomEditView.Loaded;
begin
  Assert(not (siDestroing in FState));

  inherited;

  DrawRectChanged;
end;

procedure TLMDCustomEditView.Resize;
begin
  if siDestroing in FState then
    Exit;

  DrawRectChanged;

  inherited;
end;

function TLMDCustomEditView.CanResize(var NewWidth,
                                          NewHeight: Integer): Boolean;
var
    MinW, MinH: Integer;
    ScrollBarW: Integer;
begin
  if siDestroing in FState then
  begin
    Result := false;
    Exit;
  end;

  Result := inherited CanResize(NewWidth, NewHeight);

  if Result then
  begin
    ScrollBarW := Width - ClientWidth;
    Assert(FLineHeight > 0);
    Assert(FGutterWidth >= 0);

    MinW := FGutterWidth + ScrollBarW;
    MinH := FLineHeight;

    if NewWidth < MinW then
    begin
      Result := false;
      NewWidth := MinW;
    end;

    if NewHeight < MinH then
    begin
      Result := false;
      NewHeight := MinH;
    end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result := 1;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMChar(var Msg: TWMChar);
begin
  if siDestroing in FState then
    Exit;

  DoKeyPressW(Msg);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMClear(var Msg: TMessage);
begin
  if siDestroing in FState then
    Exit;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    if not IsDocumentSet then
      Beep
    else
      MyDoc.Clear;
  finally
    EndUpdate(True);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;

  if siDestroing in FState then
    Exit;

  Msg.Result := Msg.Result or DLGC_WANTARROWS or DLGC_WANTCHARS;
  if FWantTabs then
    Msg.Result := Msg.Result or DLGC_WANTTAB;
  if FWantReturns then
    Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMCaptureChanged(var Msg: TMessage);
begin
  if siDestroing in FState then
    Exit;

  StopScrollTimer;

  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMCopy(var Message: TMessage);
begin
  if siDestroing in FState then
    Exit;

  if not IsDocumentSet then
    Beep
  else
    CopySelection;

  Message.Result := ord(True);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMCut(var Message: TMessage);
begin
  if siDestroing in FState then
    Exit;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    if not IsDocumentSet then
      Beep
    else
      CutSelection;
  finally
    Message.Result := ord(True);
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMPaste(var Message: TMessage);
begin
  if siDestroing in FState then
    Exit;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    if not IsDocumentSet then
      Beep
    else
      Paste;
  finally
    Message.Result := ord(True);
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMGetText(var Msg: TWMGetText);
var
  Seg: TLMDSegment;
  Cnt: Integer;
begin
  if siDestroing in FState then
    Exit;

  if Msg.TextMax <> WPARAM(-1) then
    Cnt := Min(Msg.TextMax, MyDoc.CharsCount)
  else
    Cnt := MyDoc.CharsCount;

  Seg := LMDSegment(0, Cnt, MyDoc.Chars);

  LMDSegCopyToPtr(Seg, PLMDChar(Msg.Text));
  Msg.Result := Seg.Count;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMGetTextLength(var Msg: TWMGetTextLength);
begin
  if siDestroing in FState then
    Exit;

  Msg.Result := MyDoc.CharsCount;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMHScroll(var Msg: TWMScroll);
var
  MaxW, HScroll, ScrW: integer;
  ScrollCode: TScrollCode;
begin
  if siDestroing in FState then
    Exit;

  BeginUpdate;

  try
    RemoveInternalState([siComplListShown, siComplTimer]);

    HScroll := HorizScroll;
    ScrollCode := scTop;
    case Msg.ScrollCode of
        // Scrolls to start / end of the line
      SB_LEFT: ScrollCode := scTop;
      SB_RIGHT: ScrollCode := scBottom;
      SB_LINERIGHT: ScrollCode := scLineUp;
      SB_LINELEFT: ScrollCode := scLineDown;
      SB_PAGERIGHT: ScrollCode := scPageUp;
      SB_PAGELEFT: ScrollCode := scPageDown;
      SB_THUMBPOSITION: ScrollCode := scPosition;
      SB_THUMBTRACK: ScrollCode := scTrack;
      SB_ENDSCROLL: ScrollCode := scEndScroll;
    else
      Assert(False)
    end;

    with Cache(self) do
      ScrW := PixelsToScrollXFixed(ScreenWidthPixels, false);

    MaxW := MaxHorizScrollActual;
    case Msg.ScrollCode of
        // Scrolls to start / end of the line
      SB_LEFT: HScroll := 0;
      SB_RIGHT: HScroll := MaxW - ScrW + 1;
        // Scrolls one char left / right
      SB_LINERIGHT: HScroll := HScroll + 1;
      SB_LINELEFT: HScroll := HScroll - 1;
        // Scrolls one page of chars left / right
      SB_PAGERIGHT: HScroll := HScroll + ScrW;
      SB_PAGELEFT: HScroll := HScroll - ScrW;
        // Scrolls to the current scroll bar position
      SB_THUMBPOSITION,
      SB_THUMBTRACK:
      begin
        Include(FState, siScrolling);

        if MaxW > MAX_SCROLL then
          HScroll := MulDiv(MaxW, Msg.Pos, MAX_SCROLL)
        else
          HScroll := Msg.Pos;
      end;

      SB_ENDSCROLL: Exclude(FState, siScrolling);
    end;


    HScroll := Min(HScroll, MaxW);

    SetHorizScrollWithCode(HScroll, ScrollCode);
  finally
    EndUpdate;
    Msg.Result := 0;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.WMVScroll(var Msg: TWMScroll);
var
  VScroll, MaxV, Page, Pos: integer;
  ScrollCode: TScrollCode;
begin
  if siDestroing in FState then
    Exit;

  BeginUpdate;

  try
    RemoveInternalState([siComplListShown, siComplTimer]);

    VScroll := TopLineScroll;
    Msg.Result := 0;

    ScrollCode := scTop;
    case Msg.ScrollCode of
      SB_TOP: ScrollCode := scTop;
      SB_BOTTOM: ScrollCode := scBottom;
      SB_LINEDOWN: ScrollCode := scLineDown;
      SB_LINEUP: ScrollCode := scLineUp;
      SB_PAGEDOWN: ScrollCode := scPageDown;
      SB_PAGEUP: ScrollCode := scPageUp;
      SB_THUMBPOSITION: ScrollCode := scPosition;
      SB_THUMBTRACK: ScrollCode := scTrack;
      SB_ENDSCROLL: ScrollCode := scEndScroll;
    else
      Assert(False)
    end;

    case Msg.ScrollCode of
      SB_TOP: VScroll := 0;
      SB_BOTTOM: VScroll := GetVisibleCountScroll;
      SB_LINEDOWN: VScroll := VScroll + 1;
      SB_LINEUP: VScroll := VScroll - 1;
      SB_PAGEDOWN: VScroll := VScroll + ScreenHeightFullVis;
      SB_PAGEUP: VScroll := VScroll - ScreenHeightFullVis;
      SB_THUMBPOSITION,
      SB_THUMBTRACK:
        begin
          Include(FState, siScrolling);

          if vsPreciseScrollbars in FViewSettings then
          begin
            MaxV := Cache(self).CalkVisibleCountScrollBar(false) - 1;
            Page := ScreenHeightFullVis;
            Pos := TopLineScroll;

            if MaxV < (Pos + Page - 1) then
            begin
              MaxV := Pos + Page - 1;
              Cache(self).CalkVisibleCountScrollBar(true);
            end;

            if MaxV >= MAX_SCROLL then
              VScroll := MulDiv(MaxV - Page, Msg.Pos, MAX_SCROLL)
            else
              VScroll := Msg.Pos;
          end
          else if NoWrap then
          begin
            if GetVisibleCountScroll >= MAX_SCROLL then
              VScroll := MulDiv(GetVisibleCountScroll - ScreenHeightFullVis,
                                Msg.Pos, MAX_SCROLL)
            else
              VScroll := Msg.Pos;
          end
          else
          begin
            if MyDoc.CharsCount >= MAX_SCROLL then
              VScroll := MulDiv(MyDoc.CharsCount - CharsOnScreen,
                                Msg.Pos, MAX_SCROLL)
            else
              VScroll := Msg.Pos;

            VScroll := Cache(self).GetNearestValidOffset(VScroll);
            VScroll := Cache(self).OffsetToScroll(VScroll).Y;
          end;
        end;
      SB_ENDSCROLL:
        Exclude(FState, siScrolling);
    end;

    ScrollVertWithCode(VScroll - TopLineScroll, ScrollCode, True);
  finally
    EndUpdate;
    Msg.Result := 0;
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDCustomEditView.DoMouseWheel(Shift: TShiftState; WheelDelta:
                                          Integer; MousePos: TPoint): Boolean;
var
  Delta: Integer;
  WheelClicks: Integer;
  NewFirst: Integer;
begin
  if siDestroing in FState then
  begin
    Result := false;
    Exit;
  end;

  Result := (csDesigning in ComponentState) or
            inherited DoMouseWheel(Shift, WheelDelta, MousePos);

  if Result then
    Exit;

  BeginUpdate;
  try
    if GetKeyState(VK_CONTROL) >= 0 then
      Delta := Mouse.WheelScrollLines
    else
      Delta := Cache(self).ScreenHeightLines;

    Inc(FMouseWheelAcc, WheelDelta);
    WheelClicks := FMouseWheelAcc div WHEEL_DELTA;
    FMouseWheelAcc := FMouseWheelAcc mod WHEEL_DELTA;
    if (Delta = Integer(WHEEL_PAGESCROLL)) or
       (Delta > Cache(self).ScreenHeightLines)
    then
      Delta := Cache(self).ScreenHeightLines;

    NewFirst := Max(0, TopLineScroll - (Delta * WheelClicks));
    Cache(self).CorrectToLastScroll(NewFirst);

    FireOnScroll(NewFirst, scPosition, True);

    TopLineScroll := NewFirst;
  finally
    Result := true;
    EndUpdate;
  end
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DoUserEventAfterDocChange;
begin
  if not IsUpdating then
    FireOnStatusChanged;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetScrollBars(AScrollbars: TScrollStyle);
begin
  if FScrollBars=AScrollbars then
    Exit;

  BeginSettingsChange;
  try
    FScrollBars := AScrollbars;
    DrawRectChanged;
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetScrollTimerBase(ABaseInt: Integer);
begin
  FScrollTimerBase := LMDMinMax(ABaseInt, 100, 1000);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetMaxHorizScroll(AMaxHorizScroll: Integer);
begin
  BeginUpdate;

  FMaxHorizScroll := Max(0, AMaxHorizScroll);

  EndUpdate;
end;
{------------------------------------------------------------------------------}

function  TLMDCustomEditView.MaxHorizScrollActual: Integer;
var
    X, XCnt: Integer;
begin
  Cache(self).ScrollPosToScreenPix(CursorPos, X, XCnt);
  X := X + Cache(self).HorizScrollPixels;
  X := Cache(self).PixelsToScrollXFixed(X+XCnt, true);

  Result := Max(HorizScroll, Max(MaxHorizScroll, X));
end;
{------------------------------------------------------------------------------}

function TLMDCustomEditView.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_SYNTAX;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.FireGutterClick(AButton: TMouseButton;
                                             AShift: TShiftState;
                                             ClientPoint: TPoint;
                                             Handled: Boolean);
var
  ScreenLine: Integer;
  BarHere: TLMDGutterBar;
  Params: TLMDGutterClickParams;
begin
  if  Assigned(FOnGutterClick) and
      ClientToGutterScreen(ClientPoint, ScreenLine, BarHere)
  then
  begin
    Params.ScrollLine := ScreenToScroll(ScreenLine);
    Params.Bar := BarHere;
    Params.Shift := AShift;
    Params.Button := AButton;

    FOnGutterClick(Self, Params, Handled);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.FireGetMouseCursor(const AScrollPos: TPoint;
  var ACursor: TCursor);
begin
  if Assigned(FOnMouseCursor) then
    FOnMouseCursor(Self, AScrollPos, ACursor);
end;

{------------------------------------------------------------------------------}

function LMDSedClipboadFormat: UINT;
begin
  if EditClipboadFormat = 0 then
    EditClipboadFormat := RegisterClipboardFormat(LMDSED_CLIPBOARD_FORMAT);

  Result := EditClipboadFormat;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetSpecialChars(const Value: TLMDSpecialChars);
begin
  FSpecialChars.Assign(Value);
end;

procedure TLMDCustomEditView.SetDebugFrameActiveLineBg(const AColor: TColor);
begin
  if AColor = FDebugFrameActiveLineBg then
    Exit;

  BeginSettingsChange;
  try
    FDebugFrameActiveLineBg := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

procedure TLMDCustomEditView.SetDebugFrameActiveLineColor(const AColor: TColor);
begin
  if AColor = FDebugFrameActiveLineColor then
    Exit;

  BeginSettingsChange;
  try
    FDebugFrameActiveLineColor := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

procedure TLMDCustomEditView.SetDebugFrameLineBg(const AColor: TColor);
begin
  if AColor = FDebugFrameLineBg then
    Exit;

  BeginSettingsChange;
  try
    FDebugFrameLineBg := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

procedure TLMDCustomEditView.SetDebugFrameLineColor(const AColor: TColor);
begin
  if AColor = FDebugFrameLineColor then
    Exit;

  BeginSettingsChange;
  try
    FDebugFrameLineColor := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

procedure TLMDCustomEditView.SetDebugFrameTopLineBg(const AColor: TColor);
begin
  if AColor = FDebugFrameTopLineBg then
    Exit;

  BeginSettingsChange;
  try
    FDebugFrameTopLineBg := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

procedure TLMDCustomEditView.SetDebugFrameTopLineColor(const AColor: TColor);
begin
  if AColor = FDebugFrameTopLineColor then
    Exit;

  BeginSettingsChange;
  try
    FDebugFrameTopLineColor := AColor;
    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

procedure TLMDCustomEditView.SetStoreDocSettingsLimit(ALimit: Integer);
begin
  if ALimit <> StoreDocSettingsLimit then
   Cache(self).StoreDocSettingsLimit := ALimit;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SetSyntaxCheckTokens(ATokens: TLMDStrings);
begin
  if ATokens=FAddictCheckTokens then
    Exit;

  BeginSettingsChange;
  try
    FAddictCheckTokens.Assign(ATokens);
    UpdateAddictCheckTokenIds;

    AddStatusChange(scViewSettings);
  finally
    EndSettingsChange(false, false);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.GotoBookmark(const AName: TLMDString);
var
    Mark: ILMDLineMark;
begin
  RemoveInternalState(siComplIncSearch);

  Mark := MyDoc.Bookmarks.FindByName(AName);
  if Mark<>nil then
    GotoOffset(Mark.Pos);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.GotoBreakpoint(const AName: TLMDString);
var Mark: ILMDLineMark;
begin
  RemoveInternalState(siComplIncSearch);

  Mark := MyDoc.Breakpoints.FindByName(AName);
  if Mark<>nil then
    GotoOffset(Mark.Pos);
end;

procedure TLMDCustomEditView.GotoOffset(AOffset: Integer);
begin
  CheckDocumentIsSet;

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    CursorOffset := AOffset;

    if not IsCursorInScreenBounds then
      ScrollToCursorLow(true);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.GotoPhysLine(ALine: Integer);
var Scr: Integer;
begin
  CheckDocumentIsSet;
  Cache(self).CheckPhysLineIdx(ALine);

  BeginUpdate;
  try
    RemoveInternalState(siComplIncSearch);

    EnsureVisible(ALine);

    Scr := PhysicalToScroll(ALine);
    CursorPosY := Scr;
    if not Cache(self).IsCursorInScreenYBounds then
      ScrollToCursorLow(true);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.ReadState(AReader: TReader);
begin
  Assert(not (siDestroing in FState));

  inherited;

  if FGutterBarsEmpty then
   FGutter.Bars.Clear;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.FillDefaultKeybindings;
var
    i: Integer;
    Item: TLMDEditCommandItem;
    Kb: TDefaultKeyBinding;
    Sc: TShortCut;
    B: TLMDEditCommandBinding;
begin
  for i := Low(DefaultKeyBindings) to High(DefaultKeyBindings) do
  begin
    Kb := DefaultKeyBindings[i];

    Item := FDefaultCommands.FindCommand(Kb.Command);
    if Item = nil then
    begin
      Item := FDefaultCommands.Add;
      Item.Command := Kb.Command;
    end;
    Item.Editable := Kb.Editable;
    Item.Modes := Item.Modes + Kb.Modes;

    Sc := Shortcut(Kb.Key, Kb.Shift);

    B := Item.Bindings.Add;

    B.Shortcut := Sc;
    B.Shortcut2 := 0;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.DefineProperties(AFiler: TFiler);
begin
  Assert(not (siDestroing in FState));

  inherited;
  AFiler.DefineProperty('GutterBarsEmpty', LoadGutterBarsEmpty, SaveGutterBarsEmpty, true);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.LoadGutterBarsEmpty(AReader: TReader);
begin
  FGutterBarsEmpty := AReader.ReadBoolean;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomEditView.SaveGutterBarsEmpty(AWriter: TWriter);
begin
  AWriter.WriteBoolean(FGutter.Bars.Count=0);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCommandBinding.CheckShortcuts(AShortcut,
                                                AShortcut2: TShortCut;
                                                AModes: TLMDEditCommandModes);
begin
  ParentItem.Parent.CheckBindingSet(self, AShortcut, AShortcut2, AModes);
end;

{------------------------------------------------------------------------------}

constructor TLMDEditCommandBinding.Create(Collection: TCollection);
begin
  inherited;

  FShortcut := 0;
  FShortcut2 := 0;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCommandBinding.Assign(Source: TPersistent);
var
    Src: TLMDEditCommandBinding;
begin
  if Source is TLMDEditCommandBinding then
  begin
    Src := Source as TLMDEditCommandBinding;

    CheckShortcuts(Src.Shortcut, Src.Shortcut2, ParentItem.Modes);

    FShortcut := Src.Shortcut;
    FShortcut2 := Src.Shortcut2;
  end
  else
    inherited Assign(Source);
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandBinding.GetParentItem: TLMDEditCommandItem;
begin
  Result := TLMDEditCommandBindings(Collection).GetOwner as TLMDEditCommandItem;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCommandBinding.SetShortcut(AShortcut: TShortCut);
begin
  if FShortcut<>AShortcut then
  begin
    CheckShortcuts(AShortcut, FShortcut2, ParentItem.Modes);

    FShortcut := AShortcut;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCommandBinding.SetShortcut2(AShortcut: TShortCut);
begin
  if FShortcut2<>AShortcut then
  begin
    CheckShortcuts(FShortcut, AShortcut, ParentItem.Modes);

    FShortcut2 := AShortcut;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandBindings.Add: TLMDEditCommandBinding;
begin
  Result := TLMDEditCommandBinding(inherited Add);
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandBindings.GetItem(Index: Integer): TLMDEditCommandBinding;
begin
  Result := TLMDEditCommandBinding( inherited GetItem(Index) );
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCommandBindings.SetItem(Index: Integer;
                                          Value: TLMDEditCommandBinding);
begin
  inherited SetItem(Index, Value);
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandBindings.GetOwner: TPersistent;
begin
  Result := FParentItem;
end;

{------------------------------------------------------------------------------}

constructor TLMDEditCommandBindings.Create(AParentItem: TLMDEditCommandItem);
begin
  FParentItem := AParentItem;

  inherited Create(TLMDEditCommandBinding);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCommandItem.Assign(Source: TPersistent);
var
    Src: TLMDEditCommandItem;
begin
  if Source is TLMDEditCommandItem then
  begin
    Src := Source as TLMDEditCommandItem;

    FCommand := Src.Command;

    FEditable := Src.Editable;
    FModes := Src.Modes;

    FBindings.Assign(Src.Bindings);

    Changed(False);
  end
  else
    inherited Assign(Source);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCommandItem.SetBindings(ABindings: TLMDEditCommandBindings);
begin
  if FBindings<>ABindings then
    FBindings.Assign(ABindings);
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandItem.GetDescription: TLMDString;
var
    i: Integer;
begin
  Result := '';

  for i := Low(DefaultKeyBindings) to High(DefaultKeyBindings) do
    if DefaultKeyBindings[i].Command=Self.Command then
    begin
      Result := DefaultKeyBindings[i].Descr;
      Break;
    end;
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandItem.GetCategory: TLMDString;
var
    i: Integer;
begin
  Result := '';

  for i := Low(DefaultKeyBindings) to High(DefaultKeyBindings) do
    if DefaultKeyBindings[i].Command = Self.Command then
    begin
      Result := DefaultKeyBindings[i].Cat;
      Break;
    end;
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandItem.Parent: TLMDEditCommandList;
begin
  Result := TLMDEditCommandList(Collection);
end;

{------------------------------------------------------------------------------}

constructor TLMDEditCommandItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);

  FCommand := sedChar;
  FEditable := false;
  FModes := [];

  FBindings := TLMDEditCommandBindings.Create(self);
end;

{------------------------------------------------------------------------------}

destructor TLMDEditCommandItem.Destroy;
begin
  FBindings.Free;

  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCommandItem.SetCommand(ACommand: TLMDEditCommand);
begin
  if FCommand<>ACommand then
  begin
    Parent.CheckCommandSet(self, ACommand);
    FCommand := ACommand;

    Changed(false);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandList.Add: TLMDEditCommandItem;
begin
  Result := TLMDEditCommandItem(inherited Add);
end;

{------------------------------------------------------------------------------}

constructor TLMDEditCommandList.Create(AParent: TLMDCustomEditView);
begin
  if (AParent = nil) or (AParent.CustomKeyBindings <> nil) then
    raise ELMDEditViewError.Create(SLMDSedViewInternalClassCreate);

  FParent := AParent;

  inherited Create(TLMDEditCommandItem);
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandList.FindBinding(AKey: word; AShiftState: TShiftState;
                                         AKey2: word; AShiftState2: TShiftState;
                                         AModes: TLMDEditCommandModes): TLMDEditCommandBinding;
var
    Sc, Sc2: TShortCut;
begin
  Sc := Shortcut(AKey, AShiftState);
  Sc2 := Shortcut(AKey2, AShiftState2);

  Result := FindBinding(Sc, Sc2, AModes);
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandList.FindBinding(AShortcut, AShortcut2: TShortCut;
                                         AModes: TLMDEditCommandModes):
                                         TLMDEditCommandBinding;
var
    i, j: Integer;
    B: TLMDEditCommandBinding;
begin
  Result := nil;

  for i := 0 to Count - 1 do
  begin
    if (Items[i].Modes * AModes) <> [] then
    begin
      for j := 0 to Items[i].Bindings.Count - 1 do
      begin
        B := Items[i].Bindings[j];

        if (B.Shortcut=AShortcut) and (B.Shortcut2=AShortcut2) then
        begin
          Result := B;

          Exit;
        end;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandList.FindBinding(AKey: word;
                                         AShiftState: TShiftState;
                                         AModes: TLMDEditCommandModes): TLMDEditCommandBinding;
var
    Sc: TShortCut;
begin
  Sc := Shortcut(AKey, AShiftState);
  Result := FindBinding(Sc, AModes);
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandList.FindBinding(AShortcut: TShortCut;
                                         AModes: TLMDEditCommandModes):
                                         TLMDEditCommandBinding;
var
    i, j: Integer;
    B: TLMDEditCommandBinding;
    Bnds: TLMDEditCommandBindings;
begin
  Result := nil;

  for i := 0 to Count - 1 do
  begin
    if (AModes * Items[i].Modes) <> [] then
    begin
      Bnds := Items[i].Bindings;
      for j := 0 to Bnds.Count - 1 do
      begin
        B := Bnds[j];

        if B.Shortcut = AShortcut then
        begin
          Result := B;

          Exit;
        end;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandList.FindCommand(ACmd: TLMDEditCommand): TLMDEditCommandItem;
var
    i: Integer;
begin
  Result := nil;

  for i := 0 to Count - 1 do
    if Items[i].Command = ACmd then
    begin
      Result := Items[i];
      Break;
    end;
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandList.GetItem(Index: Integer): TLMDEditCommandItem;
begin
  Result := TLMDEditCommandItem( inherited GetItem(Index) );
end;

{------------------------------------------------------------------------------}

function TLMDEditCommandList.GetOwner: TPersistent;
begin
  Result := FParent;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCommandList.SetItem(Index: Integer;
  Value: TLMDEditCommandItem);
begin
  inherited SetItem(Index, Value);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCommandList.CheckBindingSet(ABind: TLMDEditCommandBinding;
                                              AShortcut, AShortcut2: TShortcut;
                                              AModes: TLMDEditCommandModes);
var
    i, j: Integer;
    B: TLMDEditCommandBinding;
begin
  for i := 0 to Count - 1 do
  begin
    if (AModes * Items[i].Modes) <> [] then
    begin
      for j := 0 to Items[i].Bindings.Count - 1 do
      begin
        B := Items[i].Bindings[j];

        if (B<>ABind) and (B.Shortcut=AShortcut) and
           (B.Shortcut2=AShortcut2)
        then
          raise ELMDEditViewError.Create(SLMDSedViewUniqueCommandBinding);
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCommandList.CheckCommandSet(AItem: TLMDEditCommandItem;
                                              ACommand: TLMDEditCommand);
var
    i: Integer;
begin
  for i := 0 to Count - 1 do
    if (AItem <> Items[i]) and (Items[i].Command = ACommand) then
      raise ELMDEditViewError.Create(SLMDSedViewUniqueCommand);
end;

{------------------------------------------------------------------------------}

procedure FillDefaultKeybindings;

var i: Integer;

procedure Add(AKey: Word; AShift: TShiftState;
              const ADescr: TLMDString;
              const ACat: TLMDString;
              ACmd: TLMDEditCommand;
              AEditable: Boolean = true;
              AModes: TLMDEditCommandModes = [cmForView]);
begin
  Assert(Length(DefaultKeyBindings)>i);

  DefaultKeyBindings[i].Key := AKey;
  DefaultKeyBindings[i].Shift := AShift;
  DefaultKeyBindings[i].Descr := ADescr;
  DefaultKeyBindings[i].Cat := ACat;
  DefaultKeyBindings[i].Command := ACmd;
  DefaultKeyBindings[i].Editable := AEditable;
  DefaultKeyBindings[i].Modes := AModes;

  Inc(i);
end;

begin
  i := 0;
  SetLength(DefaultKeyBindings, 86);

  Add(VK_UP, [], SLMDSedCmdUp,
      SLMDSedCmdCatMovement, sedUp,
      true, [cmForView, cmForIncSearch]);
  Add(VK_UP, [ssShift], SLMDSedCmdSelectUp,
      SLMDSedCmdCatSelection, sedSelectUp,
      true, [cmForView, cmForIncSearch]);
  Add(VK_UP, [ssCtrl], SLMDSedCmdScrollUp,
      SLMDSedCmdCatMovement, sedScrollUp,
      true, [cmForView, cmForIncSearch]);
  ///

  Add(VK_DOWN, [], SLMDSedCmdDown, SLMDSedCmdCatMovement,
      sedDown,
      true, [cmForView, cmForIncSearch]);
  Add(VK_DOWN, [ssShift], SLMDSedCmdSelectDown,
      SLMDSedCmdCatSelection, sedSelectDown,
      true, [cmForView, cmForIncSearch]);
  Add(VK_DOWN, [ssCtrl], SLMDSedCmdScrollDown,
      SLMDSedCmdCatMovement, sedScrollDown,
      true, [cmForView, cmForIncSearch]);
  ////

  Add(VK_LEFT, [], SLMDSedCmdLeft, SLMDSedCmdCatMovement,
      sedLeft,
      true, [cmForView, cmForIncSearch]);
  Add(VK_LEFT, [ssShift], SLMDSedCmdSelectLeft,
      SLMDSedCmdCatSelection, sedSelectLeft,
      true, [cmForView, cmForIncSearch]);
  Add(VK_LEFT, [ssCtrl], SLMDSedCmdPrevWord,
      SLMDSedCmdCatMovement, sedPrevWord,
      true, [cmForView, cmForIncSearch]);
  Add(VK_LEFT, [ssShift, ssCtrl],
      SLMDSedCmdSelectPrevWord, SLMDSedCmdCatSelection, sedSelectPrevWord,
      true, [cmForView, cmForIncSearch]);
  ///

  Add(VK_RIGHT, [], SLMDSedCmdRight, SLMDSedCmdCatMovement,
      sedRight,
      true, [cmForView, cmForIncSearch]);
  Add(VK_RIGHT, [ssShift], SLMDSedCmdSelectRight,
      SLMDSedCmdCatSelection, sedSelectRight,
      true, [cmForView, cmForIncSearch]);
  Add(VK_RIGHT, [ssShift, ssCtrl],
      SLMDSedCmdSelectNextWord, SLMDSedCmdCatSelection, sedSelectNextWord,
      true, [cmForView, cmForIncSearch]);
  Add(VK_RIGHT, [ssCtrl], SLMDSedCmdNextWord,
      SLMDSedCmdCatMovement, sedNextWord,
      true, [cmForView, cmForIncSearch]);
  ////

  Add(VK_INSERT, [], SLMDSedCmdToggleOverwrite, SLMDSedCmdCatOther,
      sedToggleOverwrite);
  Add(VK_INSERT, [ssCtrl], SLMDSedCmdCopy,
      SLMDSedCmdCatClipboard, sedCopy);
  Add(VK_INSERT, [ssShift], SLMDSedCmdPaste,
      SLMDSedCmdCatClipboard, sedPaste);
  ////

  Add(VK_PRIOR, [], SLMDSedCmdPageUp, SLMDSedCmdCatMovement,
      sedPageUp,
      true, [cmForView, cmForIncSearch]);
  Add(VK_PRIOR, [ssShift], SLMDSedCmdSelectPageUp,
      SLMDSedCmdCatSelection, sedSelectPageUp,
      true, [cmForView, cmForIncSearch]);
  Add(VK_PRIOR, [ssCtrl], SLMDSedCmdPageHome,
      SLMDSedCmdCatMovement, sedPageHome,
      true, [cmForView, cmForIncSearch]);
  Add(VK_PRIOR, [ssCtrl, ssShift],
      SLMDSedCmdSelectPageHome, SLMDSedCmdCatSelection, sedSelectPageHome,
      true, [cmForView, cmForIncSearch]);
  ////

  Add(VK_NEXT, [], SLMDSedCmdPageDown, SLMDSedCmdCatMovement,
      sedPageDown,
      true, [cmForView, cmForIncSearch]);
  Add(VK_NEXT, [ssShift], SLMDSedCmdSelectPageDown,
      SLMDSedCmdCatSelection, sedSelectPageDown,
      true, [cmForView, cmForIncSearch]);
  Add(VK_NEXT, [ssCtrl], SLMDSedCmdPageEnd,
      SLMDSedCmdCatMovement, sedPageEnd,
      true, [cmForView, cmForIncSearch]);
  Add(VK_NEXT, [ssCtrl, ssShift],
      SLMDSedCmdSelectPageEnd, SLMDSedCmdCatSelection, sedSelectPageEnd,
      true, [cmForView, cmForIncSearch]);
  ///

  Add(VK_HOME, [], SLMDSedCmdLineHome, SLMDSedCmdCatMovement,
      sedLineHome,
      true, [cmForView, cmForIncSearch]);
  Add(VK_HOME, [ssCtrl], SLMDSedCmdTextHome,
      SLMDSedCmdCatMovement, sedTextHome,
      true, [cmForView, cmForIncSearch]);
  Add(VK_HOME, [ssShift], SLMDSedCmdSelectLineHome,
      SLMDSedCmdCatSelection, sedSelectLineHome,
      true, [cmForView, cmForIncSearch]);
  Add(VK_HOME, [ssCtrl, ssShift],
      SLMDSedCmdSelectTextHome, SLMDSedCmdCatSelection, sedSelectTextHome,
      true, [cmForView, cmForIncSearch]);
  ///

  Add(VK_END, [], SLMDSedCmdLineEnd, SLMDSedCmdCatMovement,
      sedLineEnd,
      true, [cmForView, cmForIncSearch]);
  Add(VK_END, [ssCtrl], SLMDSedCmdTextEnd,
      SLMDSedCmdCatMovement, sedTextEnd,
      true, [cmForView, cmForIncSearch]);
  Add(VK_END, [ssShift], SLMDSedCmdSelectLineEnd,
      SLMDSedCmdCatSelection, sedSelectLineEnd,
      true, [cmForView, cmForIncSearch]);
  Add(VK_END, [ssCtrl, ssShift],
      SLMDSedCmdSelectTextEnd, SLMDSedCmdCatSelection, sedSelectTextEnd,
      true, [cmForView, cmForIncSearch]);
  ///

  Add(VK_BACK, [ssCtrl, ssAlt], SLMDSedCmdDeletePrevChar, SLMDSedCmdCatDeletion,
      sedDeletePrevChar,
      true, [cmForView, cmForIncSearch]);
  Add(VK_BACK, [ssShift], SLMDSedCmdDeletePrevChar, SLMDSedCmdCatDeletion,
      sedDeletePrevChar,
      true, [cmForView, cmForIncSearch]);

  Add(VK_BACK, [ssCtrl], SLMDSedCmdDeletePrevWord,
      SLMDSedCmdCatDeletion, sedDeletePrevWord,
      true, [cmForView, cmForIncSearch]);

  Add(VK_DELETE, [], SLMDSedCmdDeleteChar, SLMDSedCmdCatDeletion,
      sedDeleteChar,
      true, [cmForView, cmForIncSearch]);
  Add(VK_DELETE, [ssShift], SLMDSedCmdDeleteChar, SLMDSedCmdCatDeletion,
      sedDeleteChar,
      true, [cmForView, cmForIncSearch]);
  Add(VK_DELETE, [ssCtrl], SLMDSedCmdDeleteWord,
      SLMDSedCmdCatDeletion, sedDeleteWord,
      true, [cmForView, cmForIncSearch]);
  Add(ord('K'), [ssCtrl], SLMDSedCmdDeleteToLineEnd,
      SLMDSedCmdCatDeletion, sedDeleteToLineEnd);
  Add(ord('K'), [ssCtrl, ssShift], SLMDSedCmdDeleteToLineWrap,
      SLMDSedCmdCatDeletion, sedDeleteToLineWrap);
  Add(ord('Y'), [ssCtrl], SLMDSedCmdDeleteLine,
      SLMDSedCmdCatDeletion, sedDeleteLine);
  ///

  Add(ord('Z'), [ssCtrl],
      SLMDSedCmdUndo, SLMDSedCmdCatOther, sedUndo);
  Add(ord('Z'), [ssCtrl, ssShift],
      SLMDSedCmdRedo, SLMDSedCmdCatOther, sedRedo);
  Add(ord('C'), [ssCtrl],
      SLMDSedCmdCopy, SLMDSedCmdCatClipboard, sedCopy);
  Add(ord('X'), [ssCtrl],
      SLMDSedCmdCut, SLMDSedCmdCatClipboard, sedCut);
  Add(ord('A'), [ssCtrl],
      SLMDSedCmdSelectAll, SLMDSedCmdCatSelection, sedSelectAll);
  Add(ord('V'), [ssCtrl],
      SLMDSedCmdPaste, SLMDSedCmdCatClipboard, sedPaste);
  Add(ord('I'), [ssCtrl, ssShift],
      SLMDSedCmdIndent, SLMDSedCmdCatIndent, sedIndent);
  Add(ord('U'), [ssCtrl, ssShift],
      SLMDSedCmdUnindent, SLMDSedCmdCatIndent, sedUnIndent);
  Add(ord('I'), [ssCtrl],
      SLMDSedCmdIndentToPrev, SLMDSedCmdCatIndent, sedIndentToPrevIndent);
  Add(ord('U'), [ssCtrl],
      SLMDSedCmdUnindentToPrev, SLMDSedCmdCatIndent, sedUnIndentToPrevIndent);
  Add(VK_TAB, [ssCtrl], SLMDSedCmdTab, SLMDSedCmdCatOther,
      sedTab);
  Add(VK_RETURN, [], SLMDSedCmdNewLine, SLMDSedCmdCatOther,
      sedNewLine,
      true, [cmForView, cmForIncSearch]);

  Add(VK_BACK, [], SLMDSedCmdBackspaceOrUnindent, SLMDSedCmdCatOther,
      sedBackspaceOrUnindent);
  Add(VK_TAB, [], SLMDSedCmdTabOrIndent, SLMDSedCmdCatOther,
      sedTabOrIndent);

  Add(ord(' '), [ssCtrl], SLMDSedCmdCompletionShow, SLMDSedCmdCatOther,
      sedCompletionShow);

  ///
  Add(VK_UP,   [], '', '', sedCompletionUp,   false, [cmForCompletion]);
  Add(VK_DOWN, [], '', '', sedCompletionDown, false, [cmForCompletion]);

  Add(VK_RETURN, [], '', '', sedCompletionCommit, false, [cmForCompletion]);
  Add(VK_ESCAPE, [], '', '', sedCompletionCancel, false, [cmForCompletion]);

  Add(VK_BACK, [], '', '', sedCompletionBack, false, [cmForCompletion]);

  Add(VK_LEFT, [], '', '', sedCompletionLeft, false, [cmForCompletion]);
  Add(VK_RIGHT, [], '', '', sedCompletionRight, false, [cmForCompletion]);

  Add(VK_PRIOR, [], '', '', sedCompletionPgUp, false, [cmForCompletion]);
  Add(VK_NEXT, [], '', '', sedCompletionPgDown, false, [cmForCompletion]);

  Add(VK_HOME, [], '', '', sedCompletionHome, false, [cmForCompletion]);
  Add(VK_END, [], '', '', sedCompletionEnd, false, [cmForCompletion]);

  ///
  Add(ord('E'), [ssCtrl], SLMDSedCmdIncSearchStart, SLMDSedCmdCatIncSearch,
      sedIncrementalSearchStart, true, [cmForView]);

  Add(VK_BACK, [], SLMDSedCmdIncSearchBack, SLMDSedCmdCatIncSearch,
      sedIncrementalSearchBack, true, [cmForIncSearch]);

  Add(VK_F3, [], SLMDSedCmdIncSearchFwd, SLMDSedCmdCatIncSearch,
      sedIncrementalSearchForward, true, [cmForIncSearch]);

  Add(VK_ESCAPE, [], '', '', sedIncrementalSearchCancel, false, [cmForIncSearch]);

  Add(VK_UP, [ssShift, ssAlt], SLMDSedCmdSelectUpBlock,
      SLMDSedCmdCatSelectionBlock, sedSelectUpBlock,
      true, [cmForView]);
  Add(VK_DOWN, [ssShift, ssAlt], SLMDSedCmdSelectDownBlock,
      SLMDSedCmdCatSelectionBlock, sedSelectDownBlock,
      true, [cmForView]);
  Add(VK_LEFT, [ssShift, ssAlt], SLMDSedCmdSelectLeftBlock,
      SLMDSedCmdCatSelectionBlock, sedSelectLeftBlock,
      true, [cmForView]);
  Add(VK_LEFT, [ssShift, ssCtrl, ssAlt],
      SLMDSedCmdSelectPrevWordBlock, SLMDSedCmdCatSelectionBlock, sedSelectPrevWordBlock,
      true, [cmForView]);
  Add(VK_RIGHT, [ssShift, ssAlt], SLMDSedCmdSelectRightBlock,
      SLMDSedCmdCatSelectionBlock, sedSelectRightBlock,
      true, [cmForView]);
  Add(VK_RIGHT, [ssShift, ssCtrl, ssAlt],
      SLMDSedCmdSelectNextWordBlock, SLMDSedCmdCatSelectionBlock, sedSelectNextWordBlock,
      true, [cmForView]);

  Add(VK_PRIOR, [ssShift, ssAlt], SLMDSedCmdSelectPageUpBlock,
      SLMDSedCmdCatSelectionBlock, sedSelectPageUpBlock,
      true, [cmForView]);
  Add(VK_PRIOR, [ssCtrl, ssShift, ssAlt],
      SLMDSedCmdSelectPageHomeBlock, SLMDSedCmdCatSelectionBlock, sedSelectPageHomeBlock,
      true, [cmForView]);
  Add(VK_NEXT, [ssShift, ssAlt], SLMDSedCmdSelectPageDownBlock,
      SLMDSedCmdCatSelectionBlock, sedSelectPageDownBlock,
      true, [cmForView]);
  Add(VK_NEXT, [ssCtrl, ssShift, ssAlt],
      SLMDSedCmdSelectPageEndBlock, SLMDSedCmdCatSelectionBlock, sedSelectPageEndBlock,
      true, [cmForView]);
  Add(VK_HOME, [ssShift, ssAlt], SLMDSedCmdSelectLineHomeBlock,
      SLMDSedCmdCatSelectionBlock, sedSelectLineHomeBlock,
      true, [cmForView]);
  Add(VK_HOME, [ssCtrl, ssShift, ssAlt],
      SLMDSedCmdSelectTextHomeBlock, SLMDSedCmdCatSelectionBlock, sedSelectTextHomeBlock,
      true, [cmForView]);
  Add(VK_END, [ssShift, ssAlt], SLMDSedCmdSelectLineEndBlock,
      SLMDSedCmdCatSelectionBlock, sedSelectLineEndBlock,
      true, [cmForView]);
  Add(VK_END, [ssCtrl, ssShift, ssAlt],
      SLMDSedCmdSelectTextEndBlock, SLMDSedCmdCatSelectionBlock, sedSelectTextEndBlock,
      true, [cmForView]);
  ////

  Assert(Length(DefaultKeyBindings)=i);
end;

{------------------------------------------------------------------------------}

{ TEditRenderer }

constructor TViewRenderer.Create(ATask: TLMDEditViewPrintTask);
begin
  inherited Create;

  FTask := ATask;
  FPagesCount := 0;
  FSelectedPagesCount := 0;

  FSelStartScr := LMDBadPoint;
  FSelEndScr := LMDBadPoint;

  FAttrsCache := nil;
  FCache := nil;
end;

procedure TViewRenderer.DrawPage(ARange: TLMDPrintOperationRange;
                                 ANum: Integer; APoint: TPoint;
                                 ACanvas: TCanvas);

procedure PaintPrintGutter(ALine, Top, Bottom: Integer);
var
    Args: TLMDEditPaintTextArgs;
begin
  if poPrintLineNumbers in FTask.PrintOptions then
  begin
    Args.ScreenLine := ALine;
    Args.BgRect := Rect(APoint.X, Top, APoint.X + FGutterWidth, Bottom);
    Args.ContentRect := Args.BgRect;

    Dec(Args.ContentRect.Right, FGutterLeftPadding);
    Args.ContentRect.Right := Max(Args.ContentRect.Right, Args.ContentRect.Left+1);

    Args.Cache := FCache;
    Args.Canvas := ACanvas;
    Args.DefaultFont := FFont;
    Args.DefaultColor := FFont.Color;
    Args.DefaultBgColor := FTask.FView.Color;
    Args.LineHeight := FLineHeight;
    Args.PrintMode := true;
    Args.PrintOptions := FTask.PrintOptions;

    FTask.FView.PaintLineNumber(Args);
  end;
end;

procedure PaintTextLine(ALine: Integer; ARect: TRect);
var
    Args: TLMDEditPaintTextArgs;
begin
  Args.ScreenLine := ALine;
  Args.BgRect := ARect;
  Args.ContentRect := ARect;

  Args.Cache := FCache;
  Args.Canvas := ACanvas;
  Args.DefaultFont := FFont;
  Args.DefaultColor := FFont.Color;
  Args.DefaultBgColor := FTask.View.Color;
  Args.LineHeight := FLineHeight;
  Args.PrintMode := true;
  Args.PrintOptions := FTask.PrintOptions;

  FTask.FView.PaintTextLine(Args, Point(0, 0), Point(0, 0));
end;

var
    L: Integer;
    DR, R: TRect;
begin
    case ARange of
      orAll: FCache.SetFirstLineAsScroll(ANum * FScrSize.Y);
      orSelection: FCache.SetFirstLineAsScroll(FSelStartScr.Y +
                                               (ANum * FScrSize.Y));
    else
      Assert(false);
    end;

    DR := Rect(APoint.X, APoint.Y,
               APoint.X + FPageWidth, APoint.Y + FPageHeight);

    for L := 0 to FScrSize.Y - 1 do
    begin
      if (ARange=orSelection) and (FCache.ScreenToScroll(L) > FSelEndScr.Y) then
        Break;

      R.Top    := DR.Top + FLineHeight * L;
      R.Bottom := R.Top + FLineHeight;

      PaintPrintGutter(L, R.Top, R.Bottom);

      R.Left   := DR.Left + FGutterWidth;
      R.Right  := DR.Right;

      PaintTextLine(L, R);
    end;
end;

procedure TViewRenderer.FinalizePages;
begin
  FreeAndNil(FCache);
  FreeAndNil(FAttrsCache);

  FScrSize := LMDBadPoint;
  FPagesCount := -1;
  FDpi := -1;
  FLineHeight := -1;
  FreeAndNil(FFont);

  FSelStartScr := LMDBadPoint;
  FSelEndScr := LMDBadPoint;
end;

function TViewRenderer.GetPagesCount(ARange: TLMDPrintOperationRange): Integer;
begin
  case ARange of
    orAll: Result := FPagesCount;
    orSelection: Result := FSelectedPagesCount;
  else
    Result := -1;
    Assert(false);
  end;
end;

procedure TViewRenderer.PreparePages(APageWidth, APageHeight: Integer;
                                     ACanvas: TCanvas);
var
  Sz: TSize;
  Cnt, i: Integer;
  TextWidth: Integer;
  PhM, SelSt, SelEn: Integer;
  OldFont: HFont;
begin
  FPageWidth := APageWidth;
  FPageHeight := APageHeight;

  FDpi := GetDeviceCaps(ACanvas.Handle, LOGPIXELSY);
  FFont := TFont.Create;

  FFont.Name := FTask.Font.Name;
  FFont.Charset := FTask.Font.Charset;
  FFont.PixelsPerInch := FDpi;
  FFont.Size := FTask.Font.Size;
  FFont.Style := FTask.Font.Style;
  FFont.Color := FTask.Font.Color;

  OldFont := SelectObject(ACanvas.Handle, FFont.Handle);
  try
    Sz := SedGetFontSize(FFont, ACanvas);
    FLineHeight := Sz.cy + (Sz.cy div 10);//Need extra inter line space for metafile

    PhM := FTask.View.MyDoc.LinesCount-1;

    if poPrintLineNumbers in FTask.PrintOptions then
    begin
      FGutterLeftPadding := LMDSedTextWidth(ACanvas, 'x');
      FGutterWidth := LMDSedTextWidth(ACanvas, IntToStr(PhM)) + FGutterLeftPadding;
    end
    else
      FGutterWidth := 0;

    TextWidth := FPageWidth - FGutterWidth;

    FScrSize.X := TextWidth;
    FScrSize.Y := FPageHeight div FLineHeight;

    FTask.ResetSpecChars;
    FCache := TScreenCache.Create(FTask.View, wmWrapToWindow, FTask.View.TabWidth,
                                  FScrSize.X, FScrSize.Y, FTask.View.WrapRulerWidth,
                                  FFont, ACanvas, FTask.FSpecialChars);

    FCache.AttachToDocument;

    FAttrsCache := TAttrsCache.Create(FFont);

    if not (poPrintHiddenText in FTask.PrintOptions) then
    begin
      i := 0;

      while i < FTask.FView.MyDoc.LinesCount do
      begin
        if FTask.View.IsCollapsedFold(i) then
        begin
          FCache.Fold(i, false);

          i := FTask.View.GetNextVisibleLine(i);
        end
        else
          Inc(i);
      end;
    end;

    Cnt := FCache.CalkVisibleCountScroll;

    FPagesCount := Cnt div FScrSize.Y;
    Inc(FPagesCount, Min(1, Cnt mod FScrSize.Y));

    if FTask.FView.SelAvail then
    begin
      SelSt := FTask.FView.SelectionOffsetStart;
      SelEn := FTask.FView.SelectionOffsetEnd;

      if SelSt < SelEn then
        FSelStartScr := FCache.OffsetToScroll(SelSt)
      else
        FSelStartScr := FCache.OffsetToScroll(SelEn);

      if SelSt < SelEn then
        FSelEndScr := FCache.OffsetToScroll(SelEn)
      else
        FSelEndScr := FCache.OffsetToScroll(SelSt);

      Assert(FSelStartScr.Y <= FSelEndScr.Y);

      Cnt := FSelEndScr.Y - FSelStartScr.Y + 1;
      FSelectedPagesCount := Cnt div FScrSize.Y;
      Inc(FSelectedPagesCount, Min(1, Cnt mod FScrSize.Y));
    end
    else
      FSelectedPagesCount := 0;
  finally
    SelectObject(ACanvas.Handle, OldFont);
  end;
end;

{ TLMDEditViewPrintTask }

constructor TLMDEditViewPrintTask.Create(AOwner: TComponent);
begin
  inherited;

  FView := nil;

  FPartParent := TViewTaskPartParent.Create(self);
  FSpecialChars := TLMDSpecialChars.Create(FPartParent);

  FPagesPrepared := false;
  FRenderer      := TViewRenderer.Create(self);
  FFont          := TFont.Create;
  FFont.OnChange := FontChanged;
  FViewFont      := True;
end;

destructor TLMDEditViewPrintTask.Destroy;
begin
  if FPagesPrepared then
    FinalizePages;
  InternalSetPrinter(nil);
  InternalSetView(nil);

  FRenderer.Free;
  FSpecialChars.Free;
  FPartParent.Free;
  FFont.Free;

  inherited;
end;

procedure TLMDEditViewPrintTask.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (AComponent = FPrinter) and (Operation = opRemove) then
    InternalSetPrinter(nil);

  inherited;
end;

function TLMDEditViewPrintTask.GetRenderer: TLMDPrintRendererBase;
begin
  Result := FRenderer;
end;

procedure TLMDEditViewPrintTask.InternalSetPrinter(const Value: TLMDPrinter);
begin
  if FPrinter <> Value then
  begin
    if FPagesPrepared then
      FinalizePages;

    if FPrinter <> nil then
      FPrinter.RemoveFreeNotification(self);
    FPrinter := Value;
    if FPrinter <> nil then
      FPrinter.FreeNotification(self);
  end;
end;

procedure TLMDEditViewPrintTask.InternalSetView(
  const Value: TLMDCustomEditView);
begin
  if Value <> FView then
  begin
    if FPagesPrepared then
      FinalizePages;

    if FView <> nil then
      FView.FPrintTasks.Remove(Self);
    FView := Value;
    if FView <> nil then
      FView.FPrintTasks.Add(Self);

    if FView <> nil then
      FSpecialChars.Assign(FView.SpecialChars);
    ResetSpecChars;
    UpdateViewFont;
  end;
end;

function TLMDEditViewPrintTask.IsFontStored: Boolean;
begin
  Result := not FViewFont;
end;

procedure TLMDEditViewPrintTask.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TLMDEditViewPrintTask.SetPrintOptions(
                const Value: TLMDEditViewPrintOptions);
begin
  CheckPagesNotPrepared;

  FPrintOptions := Value;
  ResetSpecChars;
end;

procedure TLMDEditViewPrintTask.ResetSpecChars;
begin
  if (not (poPrintSpecialChars in PrintOptions)) or (View = nil) then
    FSpecialChars.ShowCharKinds := []
  else
    FSpecialChars.ShowCharKinds := View.SpecialChars.ShowCharKinds;
end;

procedure TLMDEditViewPrintTask.SetView(const Value: TLMDCustomEditView);
begin
  CheckPagesNotPrepared;
  InternalSetView(Value);
end;

procedure TLMDEditViewPrintTask.SetViewFont(const Value: Boolean);
begin
  if FViewFont <> Value then
  begin
    FViewFont := Value;
    UpdateViewFont;
  end;
end;

procedure TLMDEditViewPrintTask.UpdateViewFont;
begin
  if FViewFont and (FView <> nil) and not FUpdatetingFont then
  begin
    FUpdatetingFont := True;
    try
      FFont.Assign(FView.Font);
    finally
      FUpdatetingFont := False;
    end;
  end;
end;

{------------------------------------------------------------------------------}

{ TLMDEditViewPrintTask }

procedure TLMDEditViewPrintTask.CheckPagesNotPrepared;
begin
  if FPagesPrepared then
    raise ELMDEditViewError.Create(SLMDSedTaskPagesNotFinalized);
end;

procedure TLMDEditViewPrintTask.CheckPagesPrepared;
begin
  if not FPagesPrepared then
    raise ELMDEditViewError.Create(SLMDSedTaskPagesNotPrepared);
end;

procedure TLMDEditViewPrintTask.CheckPrinterAssigned;
begin
  if FPrinter = nil then
    raise ELMDEditViewError.Create(SLMDSedTaskPrinterNotAssigned);
end;

procedure TLMDEditViewPrintTask.CheckViewAssigned;
begin
  if FView = nil then
    raise ELMDEditViewError.Create(SLMDSedTaskViewNotAssigned);
end;

procedure TLMDEditViewPrintTask.ExecPrintDlg;
begin
  CheckPrinterAssigned;
  CheckViewAssigned;  
  CheckPagesPrepared;

  FPrinter.ExecPrintDlg;
end;

procedure TLMDEditViewPrintTask.ExecPrintPreviewDlg;
begin
  CheckPrinterAssigned;
  CheckViewAssigned;
  CheckPagesPrepared;

  FPrinter.ExecPreviewDlg;
end;

procedure TLMDEditViewPrintTask.FinalizePages;
begin
  CheckPagesPrepared;
  CheckViewAssigned;
  CheckPrinterAssigned;

  FPrinter.FinalizePages;

  FPagesPrepared := false;
end;

procedure TLMDEditViewPrintTask.FontChanged(Sender: TObject);
begin
  if not FUpdatetingFont then
    FViewFont := False;
end;

function TLMDEditViewPrintTask.PagesCount: Integer;
begin
  CheckPrinterAssigned;
  CheckViewAssigned;  
  CheckPagesPrepared;

  Result := FPrinter.GetPagesCount(orAll);
end;

procedure TLMDEditViewPrintTask.PreparePages;
begin
  CheckPrinterAssigned;
  CheckViewAssigned;
  CheckPagesNotPrepared;

  FPrinter.PreparePages(GetRenderer);

  FPagesPrepared := true;
end;

procedure TLMDEditViewPrintTask.Print(AStart, ACount: Integer);
begin
  CheckPrinterAssigned;
  CheckViewAssigned;
  CheckPagesPrepared;

  FPrinter.PrintPages(orAll, AStart, ACount);
end;

procedure TLMDEditViewPrintTask.Print;
begin
  CheckPrinterAssigned;
  CheckViewAssigned;
  CheckPagesPrepared;

  Print(0, PagesCount-1);
end;

procedure TLMDEditViewPrintTask.SetTaskPrinter(const Value: TLMDPrinter);
begin
  CheckPagesNotPrepared;
  InternalSetPrinter(Value);
end;

{------------------------------------------------------------------------------}
{ TStoredView }

procedure TStoredView.AttachCurrentDoc;
var
    i, Ln: Integer;
begin
  if FDataLimit < 2 then
    Exit;

  Ln := Length(FData);
  if Ln<FDataLimit then
  begin
    Inc(Ln);
    SetLength(FData, Ln);
  end
  else
  begin
    FData[0].Free;
    FData[0] := nil;

    for i := 0 to Ln - 2 do
      FData[i] := FData[i+1];

    FData[Ln-1] := nil;
  end;

  FData[Ln-1] := TStoredViewData.Create(self);
end;

constructor TStoredView.Create(AParent: TScreenCache; ALimit: Integer);
begin
  inherited Create;
  
  FParent := AParent;
  FDataLimit := ALimit+1;
  SetLength(FData, 0);  
end;

destructor TStoredView.Destroy;
begin
  while Length(FData) > 0 do
    RemoveData(FData[0]);

  inherited;
end;

function TStoredView.GetDataByDoc(ADocument: TLMDEditDocument): TStoredViewData;
var
    i: Integer;
begin
  Result := nil;

  for i := 0 to Length(FData) - 1 do
    if FData[i].FDocument=ADocument then
    begin
      Result := FData[i];
      Break;
    end;
end;

function TStoredView.GetDataLimit: Integer;
begin
  Result := FDataLimit - 1;
end;

procedure TStoredView.RemoveData(AData: TStoredViewData);
var
    i, found: Integer;
begin
  found := -1;

  for i := 0 to Length(FData) - 1 do
    if FData[i]=AData then
    begin
      found := i;
      Break;
    end;

  Assert(found<>-1);

  FData[found].Free;
  for i := found to Length(FData) - 2 do
    FData[i] := FData[i+1];

  SetLength(FData, Length(FData)-1);
end;

procedure TStoredView.SetDataLimit(ALimit: Integer);
var
    i, Rem: Integer;
begin
  ALimit := ALimit + 1;
  
  if ALimit<Length(FData) then
  begin
    Rem := Length(FData)-ALimit;
    for i := 0 to Rem-1 do
    begin
      FData[i].Free;
      FData[i] := nil;
    end;

    for i := Rem to Length(FData) - 1 do
      FData[i-Rem] := FData[i];

    SetLength(FData, ALimit);
  end;

  FDataLimit := ALimit;
end;

{ TStoredViewData }

procedure TStoredViewData.BeforeDelete(AStart, ALength: Integer);
begin
  if ALength = FDocument.CharsCount then
    RemoveFromParent;
end;

procedure TStoredViewData.BeforeRefresh;
begin
  RemoveFromParent;
end;

constructor TStoredViewData.Create(AParent: TStoredView);
var
    Off, i: Integer;
begin
  inherited Create;

  FParent := AParent;
  FCache := FParent.FParent;
  FDocument := FCache.Doc;

  FCursorMarkers := FDocument.CreateCustomMarkers(true, false, false);
  Folds := FDocument.CreateCustomLineMarkers(false, false);

  Off := FCache.CursorOffset.Offset;
  if Off <> 0 then
    Cursor := FCursorMarkers.CreateMarkAtOffset(Off)
  else
    Cursor := nil;

  Off := FCache.SelStartOffset.Offset;
  if Off <> 0 then
    SelStart := FCursorMarkers.CreateMarkAtOffset(Off)
  else
    SelStart := nil;

  Off := FCache.SelEndOffset.Offset;
  if Off <> 0 then
    SelEnd := FCursorMarkers.CreateMarkAtOffset(Off)
  else
    SelEnd := nil;

  Assert(FCache.LinesOnScreenScroll > 0);

  Off := FCache.ScrollToNearestOffset(Point(FCache.GetScreenLineFirstX(0),
                                            FCache.FirstLineScroll));

  if Off <> 0 then
    ScreenStart := FCursorMarkers.CreateMarkAtOffset(Off)
  else
    ScreenStart := nil;

  SelBlockMode := FCache.SelBlockMode;

  for i := 0 to FDocument.LinesCount - 1 do
  begin
    if FCache.IsCollapsedFold(i) then
      Folds.CreateMarkAtLine(i);
  end;

  FDocument.AddListener(self);
end;

destructor TStoredViewData.Destroy;
begin
  FCursorMarkers.Clear;
  Folds.Clear;

  Cursor := nil;
  SelStart := nil;
  SelEnd := nil;
  ScreenStart := nil;

  FDocument.DetachCustomMarkers(Folds);
  FDocument.DetachCustomMarkers(FCursorMarkers);

  Folds := nil;
  FCursorMarkers := nil;

  FDocument.RemoveListener(self);

  inherited;
end;

procedure TStoredViewData.DocumentDestroing;
begin
  RemoveFromParent;
end;

procedure TStoredViewData.RemoveFromParent;
begin
  FParent.RemoveData(self);
end;

{ TCharWidthCache }

procedure TCharWidthCache.Clear;
var
    itm, tmp: TCharWidthCacheItem;
    i: Integer;
begin
  for i := 0 to FSize - 1 do
  begin
    itm := FItems[i];
    while itm<>nil do
    begin
      tmp := itm;
      itm := itm.Next;
      tmp.Free;
    end;

    FItems[i] := nil;
  end;
end;

function TCharWidthCache.CalkHash(AChar: TLMDChar; ACharSet: TFontCharSet;
                                  AFs: TFontStyles;
                                  out Code: Integer): Integer;
var
    Fsi: Integer;
begin
  Assert(SizeOf(AFs)=1);

  Fsi := PByte(@AFs)^;

  Code := Ord(AChar) or (Fsi shl 16) or (Byte(ACharSet) shl 24);

  Result := Code + not (Code shl 9);
  Result := Result xor   (Result shr 14);
  Result := Result +     (Result shl 4);
  Result := Result xor   (Result shr 10);
end;

constructor TCharWidthCache.Create;
begin
  inherited Create;

  FSize := 1024;
  SetLength(FItems, FSize);
end;

destructor TCharWidthCache.Destroy;
begin
  Clear;
  inherited;
end;

function TCharWidthCache.GetCharWidth(AChar: TLMDChar; ACharSet: TFontCharSet;
                                      AFs: TFontStyles): Integer;
var
  itm: TCharWidthCacheItem;
  Hash: Integer;
  Code: Integer;
begin
  Hash := CalkHash(AChar, ACharSet, AFs, Code);
  itm := FItems[Hash and (FSize-1)];

  while (itm <> nil) and (itm.Code <> Code) do
    itm := itm.Next;

  if itm <> nil then
    Result := itm.Width
  else
    Result := -1;
end;

{------------------------------------------------------------------------------}

procedure TCharWidthCache.SetCharWidth(AChar: TLMDChar; ACharSet: TFontCharSet;
                                       AFs: TFontStyles;
                                       AWidth: Integer);
var
  CurItm, NewItm: TCharWidthCacheItem;
  idx: Integer;
  Hash: Integer;
  Code: Integer;
begin
  Hash := CalkHash(AChar, ACharSet, AFs, Code);
  idx := Hash and (FSize-1);

  CurItm := FItems[idx];

  NewItm := TCharWidthCacheItem.Create;

  NewItm.Code := Code;
  NewItm.Width := AWidth;

  NewItm.Next := nil;

  if CurItm = nil then
    FItems[idx] := NewItm
  else
  begin
    while CurItm.Next <> nil do
      CurItm := CurItm.Next;

    CurItm.Next := NewItm;
  end;
end;

{------------------------------------------------------------------------------}

constructor TViewPartParent.Create(AView: TLMDCustomEditView);
begin
  inherited Create;

  View := AView;
end;

{------------------------------------------------------------------------------}

procedure TViewPartParent.BeginChange;
begin
  View.BeginSettingsChange;
end;

{------------------------------------------------------------------------------}

procedure TViewPartParent.EndChange(AResetCache: Boolean);
begin
  View.AddStatusChange(scViewSettings);
  View.EndSettingsChange(false, AResetCache);
end;

{------------------------------------------------------------------------------}

function  TViewPartParent.GetOwnerComponent: TComponent;
begin
  Result := View;
end;

{------------------------------------------------------------------------------}

constructor TViewTaskPartParent.Create(ATask: TLMDEditViewPrintTask);
begin
  inherited Create;

  Task := ATask;
end;

{------------------------------------------------------------------------------}

procedure TViewTaskPartParent.BeginChange;
begin
end;

{------------------------------------------------------------------------------}

procedure TViewTaskPartParent.EndChange(AResetCache: Boolean);
begin
end;

{------------------------------------------------------------------------------}

function  TViewTaskPartParent.GetOwnerComponent: TComponent;
begin
  Result := nil;
  Assert(false);
end;

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
{ TLMDEditCompletionSettings }
{------------------------------------------------------------------------------}

procedure TLMDEditCompletionSettings.Assign(Source: TPersistent);
var
  src: TLMDEditCompletionSettings;
begin
  if Source = Self then
    Exit;

  if Source is TLMDEditCompletionSettings then
  begin
    src := TLMDEditCompletionSettings(source);

    BeginUpdate;
    try
      ShowTimeout := src.ShowTimeout;
      ShowCompletionOnTimeout := src.ShowCompletionOnTimeout;
      MinChars := src.MinChars;
      DontShowComboForOnlyMatch := src.DontShowComboForOnlyMatch;
      CompletionType := src.CompletionType;
      CaseSensitive := src.CaseSensitive;
      ItemHeight := src.ItemHeight;
      WordSeparators := src.WordSeparators;
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCompletionSettings.BeginUpdate;
begin
  FParent.BeginSettingsChange;
end;

{------------------------------------------------------------------------------}

constructor TLMDEditCompletionSettings.Create(AParent: TLMDCustomEditView);
begin
  if (AParent = nil) or (AParent.CompletionSettings <> nil) then
    raise ELMDEditViewError.Create(SLMDSedViewInternalClassCreate);

  inherited Create;

  FParent := AParent;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCompletionSettings.EndUpdate;
begin
  FParent.AddStatusChange(scViewSettings);
  FParent.EndSettingsChange(false, false);
end;

{------------------------------------------------------------------------------}

function TLMDEditCompletionSettings.GetMinChars: Integer;
begin
  Result := FParent.FCompletionMinChars;
end;

{------------------------------------------------------------------------------}

function TLMDEditCompletionSettings.GetOwner: TPersistent;
begin
  Result := FParent;
end;

{------------------------------------------------------------------------------}

function TLMDEditCompletionSettings.GetShowTimeout: Integer;
begin
  Result := FParent.FCompletionTimeout;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCompletionSettings.SetMinChars(Value: Integer);
begin
  if Value = MinChars then
    Exit;

  BeginUpdate;
  try
    FParent.FCompletionMinChars := Value;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCompletionSettings.SetShowTimeout(Value: Integer);
begin
  if Value = ShowTimeout then
    Exit;

  BeginUpdate;
  try
    FParent.FCompletionTimeout := Value;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCompletionSettings.SetDontShowComboForOnlyMatch(Value: Boolean);
begin
  if Value = DontShowComboForOnlyMatch then
    Exit;

  BeginUpdate;
  try
    FParent.FCompletionNoComboForOnly := Value;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCompletionSettings.SetCaseSensitive(Value: Boolean);
begin
  if Value = CaseSensitive then
    Exit;

  BeginUpdate;
  try
    FParent.FCompletionCaseSens := Value;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDEditCompletionSettings.GetDontShowComboForOnlyMatch: Boolean;
begin
  Result := FParent.FCompletionNoComboForOnly;
end;

{------------------------------------------------------------------------------}

function TLMDEditCompletionSettings.GetCaseSensitive: Boolean;
begin
  Result := FParent.FCompletionCaseSens;
end;

{------------------------------------------------------------------------------}

function TLMDEditCompletionSettings.GetCompletionType: TLMDViewCompletionType;
begin
  Result := FParent.FCompletionType;
end;

{------------------------------------------------------------------------------}

function TLMDEditCompletionSettings.GetItemHeight: Integer;
begin
  Result := TComplList(FParent.FCompletionList).ItemHeight;
end;

{------------------------------------------------------------------------------}

function TLMDEditCompletionSettings.GetWordSeparators: TLMDString;
begin
  Result := FParent.FComplWordSep;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCompletionSettings.SetItemHeight(Value: Integer);
begin
  if Value = ItemHeight then
    Exit;

  BeginUpdate;
  try
    TComplList(FParent.FCompletionList).ItemHeight := Value;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCompletionSettings.SetWordSeparators(const Value: TLMDString);
begin
  if Value = WordSeparators then
    Exit;

  BeginUpdate;
  try
    FParent.FComplWordSep := Value;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDEditCompletionSettings.GetShowCompletionOnTimeout: Boolean;
begin
  Result := FParent.FComplUseTimeout;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCompletionSettings.SetShowCompletionOnTimeout(Value: Boolean);
begin
  if Value = ShowCompletionOnTimeout then
    Exit;

  BeginUpdate;
  try
    FParent.FComplUseTimeout := Value;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditCompletionSettings.SetCompletionType(Value: TLMDViewCompletionType);
begin
  if Value = CompletionType then
    Exit;

  BeginUpdate;
  try
    FParent.FCompletionType := Value;

    with FParent.FCompletionList as TComplList do
    begin
      if Value = ctCustomOwnerDrawFixed then
        Style := lbOwnerDrawFixed
      else if Value = ctCustomOwnerDrawVariable then
        Style := lbOwnerDrawVariable
      else
        Style := lbStandard;
    end;

  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
{ TLMDEditHighlightSettings }
{------------------------------------------------------------------------------}

procedure TLMDEditHighlightSettings.Assign(Source: TPersistent);
var
  src: TLMDEditHighlightSettings;
begin
  if Source = Self then
    Exit;

  if Source is TLMDEditHighlightSettings then
  begin
    src := TLMDEditHighlightSettings(source);

    BeginUpdate;
    try
      FParent := src.FParent;

      TextColor := src.TextColor;
      BackgroundColor := src.BackgroundColor;
      FontStyle := src.FontStyle;

      PropsSet := src.PropsSet;

      UseHighlight := src.UseHighlight;
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

{------------------------------------------------------------------------------}

procedure TLMDEditHighlightSettings.BeginUpdate;
begin
  FParent.BeginSettingsChange;
end;

{------------------------------------------------------------------------------}

constructor TLMDEditHighlightSettings.Create(AParent: TLMDCustomEditView);
begin
  if (AParent = nil) or (AParent.HighlightSettings <> nil) then
    raise ELMDEditViewError.Create(SLMDSedViewInternalClassCreate);

  inherited Create;

  FHlSettings.CustomAttributes := nil;
  FHlSettings.BackgroundColor := DEFAULT_HIGHLIGHT_BG;
  FHlSettings.TextColor := DEFAULT_HIGHLIGHT_TEXT;
  FHlSettings.FontStyle := [];
  FHlSettings.AttributesSet := [asBackgroundColor];

  FPropsSet := [psBackgroundColor];

  FUseHl := true;

  FParent := AParent;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditHighlightSettings.EndUpdate;
begin
  Cache(FParent).SetHighlightAttrs(FHlSettings, FUseHl);
  FParent.AddStatusChange(scViewSettings);

  FParent.EndSettingsChange(false, true);
end;

{------------------------------------------------------------------------------}

function TLMDEditHighlightSettings.GetBgColor: TColor;
begin
  Result := FHlSettings.BackgroundColor;
end;

{------------------------------------------------------------------------------}

function TLMDEditHighlightSettings.GetFontStyle: TFontStyles;
begin
  Result := FHlSettings.FontStyle;
end;

{------------------------------------------------------------------------------}

function TLMDEditHighlightSettings.GetOwner: TPersistent;
begin
  Result := FParent;
end;

{------------------------------------------------------------------------------}

function TLMDEditHighlightSettings.GetTextColor: TColor;
begin
  Result := FHlSettings.TextColor;
end;

{------------------------------------------------------------------------------}

function TLMDEditHighlightSettings.GetUseHighlight: Boolean;
begin
  Result := FUseHl;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditHighlightSettings.SetBgColor(const Value: TColor);
begin
  if Value = BackgroundColor then
    Exit;

  BeginUpdate;
  try
    FHlSettings.BackgroundColor := Value;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditHighlightSettings.SetFontStyle(const Value: TFontStyles);
begin
  if Value = FontStyle then
    Exit;

  BeginUpdate;
  try
    FHlSettings.FontStyle := Value;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditHighlightSettings.SetPropsSet(
                          const Value: TLMDEditHighlightPropsSet);
begin
  if PropsSet = Value then
    Exit;

  BeginUpdate;
  try
    FPropsSet := Value;

    FHlSettings.AttributesSet := [];

    if psTextColor in FPropsSet then
      Include(FHlSettings.AttributesSet, asTextColor);

    if psBackgroundColor in FPropsSet then
      Include(FHlSettings.AttributesSet, asBackgroundColor);

    if psFontStyle in FPropsSet then
      Include(FHlSettings.AttributesSet, asFontStyle);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditHighlightSettings.SetTextColor(const Value: TColor);
begin
  if TextColor = Value then
    Exit;

  BeginUpdate;
  try
    FHlSettings.TextColor := Value;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEditHighlightSettings.SetUseHighlight(const Value: Boolean);
begin
  if UseHighlight = Value then
    Exit;

  BeginUpdate;
  try
    FUseHl := Value;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

constructor TIncSearchJump.Create(AStart: Integer; AText: TLMDString);
begin
  inherited Create;

  Start := AStart;
  Text := AText;
end;

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

constructor TAttrsCache.Create(AFont: TFont);
var
    i: Integer;
begin
  FFont := AFont;
  FHashMask := 63;

  SetLength(FItems, FHashMask + 1);
  for i := 0 to Length(FItems) - 1 do
    FItems[i] := nil;

  Reset(AFont);
end;

{------------------------------------------------------------------------------}

destructor TAttrsCache.Destroy;
begin
  Reset(nil);
end;

{------------------------------------------------------------------------------}

function TAttrsCache.GetFont(AFs: TFontStyles; ACharset: TFontCharset): HFont;
var
    Code: Integer;
    Fsi: Integer;
    Hash: Integer;
    itm: TAttrsCacheItem;
    i: Integer;
begin
  Assert(SizeOf(AFs)=1);

  Fsi := PByte(@AFs)^;

  Code := Fsi or (Byte(ACharSet) shl 16);

  Hash := Code + not (Code shl 9);
  Hash := Hash xor   (Hash shr 14);
  Hash := Hash +     (Hash shl 4);
  Hash := Hash xor   (Hash shr 10);

  i := Hash and FHashMask;
  itm := FItems[i];
  while (itm <> nil) and (itm.Code <> Code) do
    itm := itm.Next;

  if itm = nil then
  begin
    itm := TAttrsCacheItem.Create;
    itm.Code := Code;

    itm.FontObj := TFont.Create;
    LMDSedAssignFont(itm.FontObj, FFont, ACharset);
    itm.FontObj.Style := AFs;

    itm.Font := itm.FontObj.Handle;

    itm.Next := FItems[i];
    FItems[i] := itm;
  end;

  Result := itm.Font;
end;

{------------------------------------------------------------------------------}

procedure TAttrsCache.Reset(AFont: TFont);
var
    i: Integer;
    itm, tmp: TAttrsCacheItem;
begin
  FFont := AFont;
  for i := 0 to FHashMask do
  begin
    itm := FItems[i];

    while itm <> nil do
    begin
      itm.FontObj.Free;
      tmp := itm;

      itm := itm.Next;
      tmp.Free;
    end;

    FItems[i] := nil;
  end;

  if AFont <> nil then
    GetFont(AFont.Style, AFont.Charset);
end;

{------------------------------------------------------------------------------}
{ TSquaredSeq }

constructor TSquaredSeq.Create(AView: TLMDCustomEditView; AStart, AEnd: TPoint);
var
  L, i, j, TabW, LnE, Ph: Integer;
  LeftS, RightS: Integer;
  SpacesBefore, SpacesAfter: Integer;
  BufCnt: Integer;
  P1, P2, P: TPoint;
  ACache: TScreenCache;
  StartPt, EndPt: TOffsetPoint;
  Ch: TLMDChar;

  procedure AddChar(ACh: TLMDChar);
  begin
    if Length(FArr) = BufCnt then
      SetLength(FArr, ((BufCnt + 1) * 3) div 2);

    FArr[BufCnt] := ACh;
    Inc(BufCnt);
  end;
begin
  inherited Create('');

  ACache := Cache(AView);
  BufCnt := 0;

  AView.CorrectSelPointsBlockMode(AStart, AEnd);

  for L := AStart.Y to AEnd.Y do
  begin
    P1 := Point(AStart.X, L);
    P2 := Point(AEnd.X, L);
    if P1.X = P2.X then
      Continue;

    StartPt := ACache.ScrollPtToOffsetPt(P1);
    EndPt := ACache.ScrollPtToOffsetPt(P2);

    Ph := AView.MyDoc.GetLineByOffset(StartPt.Offset);
    LnE := LMDSegEnd(AView.MyDoc.LineSegments[Ph]) + 1;

    if StartPt.Offset = EndPt.Offset then
    begin
      SpacesBefore := 0;
      if StartPt.Offset <> LnE then
        SpacesAfter := EndPt.InCharOffset - StartPt.InCharOffset
      else
        SpacesAfter := 0;
    end
    else
    begin
      ACache.GetScrollCharScrollBounds(P1, LeftS, RightS);

      StartPt.InCharOffset := 0;
      if P1.X <> LeftS then
      begin
        SpacesBefore := RightS - P1.X;
        Inc(StartPt.Offset);
      end
      else
        SpacesBefore := 0;

      if EndPt.Offset <> LnE then
        SpacesAfter := EndPt.InCharOffset
      else
        SpacesAfter := 0;
    end;

    for i := 0 to SpacesBefore - 1 do
      AddChar(LMDSpace);

    for i := StartPt.Offset to EndPt.Offset - 1 do
    begin
      Ch := ACache.Doc.Chars[i];
      if Ch = LMDTab then
      begin
        P := ACache.OffsetToScroll(i);
        TabW := GetTabWidth(P.X, AView.TabWidth);
        for j := 0 to TabW - 1 do
          AddChar(LMDSpace);
      end
      else
        AddChar(Ch);
    end;

    for i := 0 to SpacesAfter - 1 do
      AddChar(LMDSpace);

    if L < AEnd.Y then
    begin
      AddChar(LMDCR);
      AddChar(LMDLF);
    end;
  end;

  SetLength(FArr, BufCnt);
  FCount := BufCnt;

  ResetBuffer;
end;

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

initialization

  {$IFDEF LMDDEBUGTRACE}
    {$I C3.INC}
  {$ENDIF}

  AllSpaces := LMDSpace;
  AllSpaces := AllSpaces + LMDTab;//Stupid D5
  InitDefImages;
  FillDefaultKeybindings;

  ChunkInit(@ChunkWithSpace);
  ChunkWithSpace.CharSet := 0;
  SetLength(ChunkWithSpace.Chars, 1);
  ChunkWithSpace.CharsCount := 1;
  ChunkWithSpace.Chars[0] := LMDSpace;
  ChunkWithSpace.IsTail := true;

{------------------------------------------------------------------------------}

finalization
  FinDefImages;
{------------------------------------------------------------------------------}
end.
