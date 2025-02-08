unit ElEdits;
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

ElEdits unit
------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

30 November, 2007 (RS)
 - Validation support added to TCustomElEdit;

###############################################################################}
 { TCustomElEdit component. }

{
 todo:
   - System scrollbars scrolling is slow when
     Flat=True and UseXPThemes=True and UseCustomScrollbar=False
   - When scrolling, system scrollbars' frame twitches in the area of their junction.
   - For old custom scrollbars twinkling is seen in the area of their junction.
     see comments in method WMEraseBkgnd.
}

(*

Version History

12/26/2004

  Fixed vertical positioning of large-font text

09/29/2004

  Now FLineHeight :`= Canvas.TextHeight('Wp'), but not
  FLineHeght := Abs(Font.Height);
  Fixed bug with input USA Internation chars.
  Added new event - OnPasteClipboardText

09/06/2004

  Fixed small bug. When press Backspace in line (FLinesInRect + 1), TopLine
  isn't corrected,

08/19/2004

  Fixed a rare bug with deletion of selected text in the last paragraph

03/18/2004

  Improved selection of the whole text (SelectAll command)

03/08/2004

  Fixed the flicker that happened when pressing Tab and WordWrap was on
  Fixed mouse wheel scrolling in cases when WordWrap was on

03/05/2004

  Fixed the bug (infinite loop) with autowrapping the text which contains Tab character

03/03/2004

  Added ClearUndo method.

02/17/2004

  Some fixes in KeyPress handler

12/17/2003

  Added handling of WM_SETTINGCHANGE event to resize scrollbars

12/14/2003

  Fixed Undo actions in TCustomElEdit.SetText method

12/02/2003

  Fixed Scrollbars property setting for Multiline mode being set in design-time

11/24/2003

  Vertical scrolling with MouseWheel has been fixed.

11/06/2003

  Text was not properly repainted when Multiline = true and WordWrap = true
  and the text was re-wrapped. Fixed.

07/29/2003

  Added support for Esperanto diacritic symbols.
 Fixed some issues in Win 9x when charset is eecLowerCase

07/06/2003

  BorderColor* properties added. They control the colors of the border, drawn when Flat is true.

07/02/2003

  Fixed the problem with caret positioning when PasswordChar <> ''

06/17/2003

  Fixed some issues in single-line mode, when Alignment is center
  or right

06/15/2003

  Fixed OnContextPopup event

05/27/2003

  When processing WM_PASTE no case conversion was made. Fixed.

05/15/2003

  MaxLength was not effective when inputting text via IME. Fixed.
  Even though ReadOnly is set to true, IME allowed input. Fixed.

05/12/2003

  No OnChange was fired when using IME editor. Fixed.

04/30/2003

  Fixed repainting of centered and right-aligned text

04/13/2003

  Fixed positioning of text in view when focus enters the control and AutoSelect is in effect

  Fixed Assign method for correct handling of empty lines (#13#10)

04/02/2003

  Fixed WMNCPaint when RightAlignedView = True (for SystemScrollBars).
  Fixed WMEraseBkgnd when BorderStyle = bsNone

03/29/2003

  Changed default for WantReturns in ElEdit to false

03/27/2003

  Fixed drawing of selected text in non-unicode mode

03/24/2003

  Replaced system ScrollBars with ElScrollBars

03/15/2003

  ChangeDisabledText changed to UseDisabledColors
  Added UseDisabledColors, DisabledColor, DisabledFontColor properties

02/15/2003

  Fixed drawing of the text with RightAlignedView property set

02/11/2003

  When new text is set, view is reset to position (0, 0)

01/20/2003

  Added support for chars with carona (c, z, l for slovak language)

12/20/2002

  Fixed issues with sanskrit language.
  Added HighlightAlphaLevel property

12/15/2002

  Added selection color properties

11/29/2002

  Copy to clipboard doesn't work correctly in Windows 9x/ME. Fixed.

11/28/2002

  Fixed processing of Return key
  Fixed processing of numpad numbers for French keyboard layout
  CharCase was ignored. Fixed.

10/30/2002

  Changed processing of numpad numbers
  Fixed sizing of single-line controls when changing font size from large to small

10/29/2002

  Some improvements of work with the system menu

10/27/2002

  Added support for chars with umlaut, grave, tilde, acute or circumflex.
  Wasn't delete selection when MaxLength = Length(Text). Fixed.
  Some internal changes.

10/14/2002

  Some memory leaks fixed in DrawTabbedText

10/10/2002

  Fixed DrawTabbedText

09/26/2002

  Added support for "Group undo" mode.

09/22/2002

  OnKeyDown wasn't called when digits or characters was pressed. Fixed.
  SetLength := 0, doesn't have effect. Fixed.

09/18/2002

  Width of Tab symbols wasn't calculated properly.

09/07/2002

  AutoSize was not taken into account when font was changed. Fixed.

08/29/2002

  Internal optimization and fixes. Fixed OnKeyDown problem. Fixed problem
  with vertical scrollbar visibility.

08/08/2002

  Fixed painting for cases when EditRect.Left or EditRect.Top are not 0.

07/31/2002

  Some internal fixes. If PopupMenu property isn't assigned, will be called
  System Menu for Edit controls.

07/25/2002
  Tab fix. Some fixes for WMKeydown.

07/22/2002

  Fixed vertical alignment of text (spoiled on 07/20/2002)
  Fixed typing of unicode text for special symbols
  Fixed processing of Enter key in Unicode mode

07/17/2002

  Fixed some problems with vertical alignment of single-line text

07/13/2001

  Added SetEditRect method and changed EditRect handling in descendant classes

06/25/2002

  Undo CRLF and Tab insert fixed. Selection fixed. Sets topline
  when scrollbars disabled. Reformat text when control resized.

06/12/2002

  MaxLength now works. Selection bug with Ctrl+Home fixed.
  Misc scrollbars fixed. Fixed bug when insert mutiline text
  with WordWrap is true. VK_DELETE event handler fixed
  (not worked when WordWrap is True)

06/10/2002

  Fixed default for Multiline.
  Fixed height adjustment during form loading
  Fixed some memory leaks

06/08/2002

  Some internal fixes.

06/06/2002

  Add TElEditStrings.AddStrings, .Find and .Exchange, .Put,
  .GetObject (loopback), .PutObject (loopback) methods.
  Memory leaks closed.

05/25/2002

  Fixed setting position for different Aligment values.
  Add NotifyUserChangeOnly, add AdjustHeight method.

05/16/2002

  Fully rewritten code. Other principles of internal work.
  Work of editor now is faster, stronger. Multilevel undo.

04/19/2002

  Fixed assignment of multiline text via Assign.
  Added Scroll method

04/15/2002

  Setting SelText when SelLength = 0 causes insertion of the text.
  Pressing Backspace when SelLength > 0 causes deletion of selected text only now.

04/10/2002

  Alt- and Ctrl- modifiers are no more blocked, so it's possible to press
  Alt+<some key> to enter locale-specific characters and Euro symbol.

04/04/2002

  The text is centered now when Multiline is false and AlignBottom = true

03/26/2002

  Lowercase and Uppercase worked wrong (were mixed). Fixed.
  Clipboard Cut now shares Clipboard Copy technique.

  Clipboard Copy now correctly sets CF_TEXT data
  (there was PChar(SelText) instead of PChar(S)).

  Clipboard Copy now sets CF_TEXT data only under
  non-Windows NT/2000/XP platform because of
  Windows Clipboard autoconvertion feature.

  Clipboard Copy sets CF_UNICODETEXT data under both Unicode
  and non-Unicode modes because of localized text Clipboard
  Paste issues.

  Fixed Clipboard Paste under non-Unicode mode to use
  CF_UNICODETEXT-formatted data when possible
  because of localized text Clipboard Paste issues.

  Clipboard Paste now uses one Clipboard object
  and do not uses wrong Open/Close semantics.

  Clipboard Copy now uses one Clipboard object,
  uses exception-safe Open/Close semantics,
  and written in Paranoid style.

  TElCustomEdit now fills background with Color
  under XP Theming mode too.

03/22/2002

  In multiline mode, when BorderStyle = bsNone, junk was drawn around the control. Fixed.

03/21/2002

  Fixed autosize issues when borders are turned off
  Fixed issues with entering numbers from numeric part of keyboard

03/20/2002

  Transparency issues fixed

03/18/2002

  Ctrl+BkSp and Ctrl+Delete delete words now

03/15/2002

  Pressing Home when cursor is on position 0 removes selection
  Now it's possible to set key in KeyPress to #0.

03/12/2002

  Autosize is now correctly set to true by default
  Combination of Ctrl and Alt does not prevent key from being processed.

03/06/2002

  Added unicode hint

02/26/2002

  Fixed scrollbars

02/23/2002

  Added CharCase property

02/18/2002

  Property UseCustomScrollBars added. Now you can use standard Windows or custom
  scrollbars.
  Support for mouse wheel added.

02/13/2002

  Fixed imageform handling

02/09/2002

  Fixed cursor size/position calculation for non-default fonts

02/01/2002

  Fixed some multiline problems

01/31/2002

  Fixed problems with Lines.Add, Lines.Insert, Lines.Clear
  Siginificantly improved speed of line addition.

  Now the control can handle even 20000 lines
  (although scrolling speed is terrible near the end of the text)

01/18/2002

  Fixed problems with scrollbar updating
  Fixed problems with IME Editors

01/12/2002

  Add AlignBottom public property. Used for vertical align text in single-line
  mode

01/06/2002

  Now the text is updated when Alignment, LeftMargin, RightMargin or TopMargin
  are changed

01/02/2002

  Under Windows XP, now all input converted to Unicode

01/01/2002

  Fixed some problems with painting borders when focus is moved

11/28/2001

  LineBorderActiveColor and LineBorderInactiveColor properties added.
  Fixed the problem with mouse selection of the text

11/16/2001

  Fix small bug in StringToPassword

11/12/2001

  Add SelectAll method come fixes in WMSetFocusMethod. Added code for context
  menu support

11/08/2001

  Solved problem with sending wm_settext in design time

11/04/2001

  Some fixes in PosFromChar, CharFromPos, WMCopy. Moved code which sets
  FLeftChar from MoveCaret to SetSelStart for normal horizontal scrolling

10/31/2001

  Select text with Shift + Left, Shift + Home and Ctrl + Shift + Left,
  bug fixed, set ScrollBars position and range moved to SetScrollBarsInfo.
  Emulate GetTextExtentExPointW for Win9x

10/30/2001

  PasswordChar assignment fixed

10/22/2001

  Some fix in unicode version

10/18/2001

  Add IME support and Unicode version of editor. Some optimization
  works.

10/15/2001

  Multiline editor completed.

10/09/2001

  Add ScrollBars, WordWrap properties to TElEdit class. Declare new class
  TElEditStrings for Multiline and WordWrap features.

*)

interface

uses
  SysUtils,
  Classes,
  Windows,
  Messages,
  Graphics,
  Controls,
  Math,
  Forms,
  StdCtrls,
  Clipbrd,
  Menus,
  {$ifdef LMD_DEBUG}
  Dialogs,
  {$endif}
  TypInfo,
  Themes,
  Types,
  {$IFDEF LMD_UNICODE}
  Imm,
  ExtCtrls,
  {$ENDIF}

  {$ifdef LMD_ELUNISCRIBE}
  ComObj,
  LMDUsp10,
  {$ENDIF}

  LMDUnicode,
  LMDStrings,
  LMDTypes,
  LMDUnicodeStrings,
  LMDElConst,
  LMDSysIn,
  LMDProcs,
  LMDGraph,
  LMDGraphUtils,
  LMDUtils,
  LMDObjectList,
  LMDClass,
  LMDVldBase,
  LMDThemes,

  ElImgFrm,
  ElStack,
  ElVCLUtils,
  ElXPThemedControl,
  ElSBCtrl,
  ElInputProcessor,
  ElEditCmds;

{$ifdef LMD_UNICODE}
const
  {$EXTERNALSYM WM_UNICHAR}
  WM_UNICHAR = $0109;
{$endif}

type
  EElEditorError = class(exception);

  TCustomElEdit = class;

  TElBookmark = record
    FX: integer;
    FY: integer;
  end;

  TElActionType = (atInsert, atDelete, atLineBreak, atGroupBreak, atPaste,
                   atBackSpace, atDeleteSel, atInsertSel);

  TElAction = class(TPersistent)
  protected
    FAction: TElActionType;
    FStartPos, FEndPos: TPoint;
    FStr: TLMDString;
  public
    procedure Assign(Source: TPersistent); override;
    property Action: TElActionType read FAction;
    property CString: TLMDString read FStr;
    property EndPos: TPoint read FEndPos;
    property StartPos: TPoint read FStartPos;
  end;

  TElActionList = class(TPersistent)
  protected
    FAStack: TElStack;
    FMaxUndo: integer;
    FLockCount: integer;
    function GetCanUndo: boolean; virtual;
    procedure SetMaxUndo(const Value: integer); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function PeekItem: TElAction;
    function PopItem: TElAction;
    procedure Clear;
    procedure AddAction(AAction: TElActionType; ASPos, AEPos: TPoint; AStr: TLMDString);
    procedure Lock;
    procedure PushItem(Item: TElAction);
    procedure UnLock;
    property CanUndo: boolean read GetCanUndo;
    property MaxUndo: integer read FMaxUndo write SetMaxUndo default 0;
  end;

  {$IFDEF LMD_UNICODE}
  TElParagraph = class(TLMDWideStringList)
  {$ELSE}
  TElParagraph = class(TLMDMemoryStrings)
  {$ENDIF}
  protected
    {$ifdef LMD_ELUNISCRIBE}
    FScriptControl: TScriptControl;
    FScriptState: TScriptState;
    FScriptStringAnalysis: SCRIPT_STRING_ANALYSIS;
    {$endif}
    FPCount: integer;
    function Get(Index: Integer): TLMDBaseString; override;
    function GetTextStr: TLMDBaseString; override;
    procedure Put(Index: Integer; const S: TLMDBaseString); override;
    procedure SetTextStr(const Value: TLMDBaseString); override;
    {$ifdef LMD_ELUNISCRIBE}
    // Uniscribe functions
    procedure GetStringAnalyse(ACanvas: TCanvas; AStrNo: Integer = -1);
    procedure FreeStringAnalyse;
    procedure Draw(ACanvas: TCanvas; AX, AY: Integer; ASelStart, ASelEnd, AStrNo: Integer);
    function GetXFromOffset(ACanvas: TCanvas; AOffset: Integer; AStrNo: Integer = -1): Integer;
    function GetOffsetFromX(ACanvas: TCanvas; AX: Integer): Integer;
    function GetStrSize(ACanvas: TCanvas; AStrNo: integer): TSize;
    {$endif}
  public
    property Text: TLMDBaseString read GetTextStr write SetTextStr;
  end;

{$warnings off}
  TElParagraphList = class(TLMDObjectList)
  protected
    function Get(Index: Integer): TElParagraph;
    procedure Put(Index: Integer; const Value: TElParagraph);
    procedure Delete(Index: Integer);
  public
    procedure Clear; override;
    property Items[Index: Integer]: TElParagraph read Get write Put; default;
  end;

  {$IFDEF LMD_UNICODE}
  TElEditStrings = class(TLMDWideStringList)
  {$ELSE}
  TElEditStrings = class(TStringList)
  {$ENDIF}
  private
    FElEdit : TCustomElEdit;
    RealStrings : TStringList;
  protected
    FMaxLen : Integer;
    FIdxMaxLen : integer;
    FMaxStr : TLMDString;
    FSaveStr : TLMDString;
    FOnChange : TNotifyEvent;
    FParagraphs: TElParagraphList;

    procedure Reformat;
    procedure Changed; override;

    function Get(Index: integer): TLMDBaseString; override;
    procedure Put(Index: Integer; const S: TLMDBaseString); override;
    procedure SetTextStr(const Value: TLMDBaseString); override;
    function GetTextStr: TLMDBaseString; override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    function GetObject(Index: Integer): TObject; override;
    function GetCount: integer; override;
    procedure ReformatParagraph(Index: integer);
    procedure ReCount(Index: integer);
    function GetParaString(Index: integer): TLMDString;
    procedure SetParaString(Index: integer; const Value: TLMDString);
    function GetParaCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    {$IFDEF LMD_UNICODE}
    procedure AddStrings(Strings: TLMDWideStrings); override;
    {$ELSE}
    procedure AddStrings(Strings: TStrings); override;
    {$ENDIF}
    function Add(const S: TLMDBaseString): Integer; override;
    procedure Insert(Index: Integer; const S: TLMDBaseString); override;
    procedure InsertText(var ACaretX, ACaretY: integer; const S: TLMDBaseString);
    function Find(const S: TLMDBaseString; var Index: Integer): boolean; override;
    procedure Clear; override;
    procedure Delete(Index: integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    procedure IndexToParagraph(index: integer; var Paragraph, ParaIndex: integer);
    procedure CaretToParagraph(ACaretX, ACaretY: integer; var Paragraph, ParaOffs: integer);
    procedure CaretFromParagraph(Paragraph, ParaOffs: integer; var ACaretX, ACaretY: integer);
    function GetReText: TLMDString;
    function CutString(var S: TLMDString; Len: integer; var RealStr: boolean): TLMDString;
    property ParagraphStrings[Index: integer]: TLMDString read GetParaString write SetParaString;
    property ParagraphCount: integer read GetParaCount;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TElTextPainter = class(TObject)
  protected
    FBkColor: TColor;
    FColor: TColor;
    FFont: TFont;
    FEditor: TCustomElEdit;
    procedure SetColor(const AColor: TColor); virtual;
    procedure SetBkColor(const ABkColor: TColor); virtual;
    // ToDo Alex
    function ExtTextOut(const ACanvas: TCanvas; X, Y: Integer; Options: Longint;
                        Rect: PRect; Str: TLMDString; Count: Longint): Boolean; virtual; abstract;
    function GetTextExtentExPoint(const ACanvas: TCanvas; lpszStr: PLMDChar; cchString: integer;
                                     nMaxExtent: integer; var lpnFit: integer;
                                     alpDX: PInteger; var lpSize: TSize): Boolean; virtual; abstract;
  public
    constructor Create(AEditor: TCustomElEdit);
    destructor Destroy;override;
    function CharsFitRight(AWidth : integer; FText : TLMDString; StartPos : integer): Integer; virtual;
    function CharsFitLeft(AWidth : integer; FText: TLMDString; StartPos : integer): Integer; virtual;
    function TextSize(ALine : TLMDString) : TSize; virtual; abstract;
    procedure DrawTabbedText(const ACanvas: TCanvas; X, Y : integer; ARect: TRect; AText : TLMDString; var Size : TSize); virtual;
    property Color: TColor read FColor write SetColor;
    property BkColor: TColor read FBkColor write SetBkColor;
    property Font: TFont read FFont Write FFont;
  end;

  TElWinTextPainter = class(TElTextPainter)
  protected
    // ToDo Alex
    function ExtTextOut(const ACanvas: TCanvas; X, Y: Integer; Options: Longint;
                        Rect: PRect; Str: TLMDString; Count: Longint): Boolean; override;
    function GetTextExtentExPoint(const ACanvas: TCanvas; lpszStr: PLMDChar; cchString: integer;
                                     nMaxExtent: integer; var lpnFit: integer;
                                     alpDX: PInteger; var lpSize: TSize): Boolean; override;
  public
    function TextSize(ALine: TLMDString): TSize; override;
  end;

  TElEditCharCase = ElInputProcessor.TElEditCharCase;
  TElEditScrollDir = (esdLineUp, esdLineDown, esdPageUp, esdPageDown);

  TElKeyPressExEvent = procedure(Sender : TObject; var Key: TElFString) of object;
  TElPasteClipboardEvent = procedure(Sender: TObject; var AClipboardText: TElFString) of object;
  TElCommandEvent = procedure(Sender: TObject; var ACommand: TElCommand; var AChar: Char; var AData: Pointer);

  TCustomElEdit = class(TElXPThemedControl, ILMDValidatedControl)
  protected
    {< ELSCROLLBAR}
    fSBCtrl: TElSBController;
    function GetHorzScrollBar:TElCtrlScrollBarStyles;
    function GetVertScrollBar:TElCtrlScrollBarStyles;
    procedure SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
    procedure SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
    property scbVert: TElCtrlScrollBarStyles read GetVertScrollBar;
    property scbHorz: TElCtrlScrollBarStyles read GetHorzScrollBar;
    property SBCtrl :TElSBController read fSBCtrl;
    {> ELSCROLLBAR}
  protected
    { Protected declarations }
    //Validation support, November 2007, RS
    FScrollBarsAutoShowing: TScrollStyle;
    FValidator: TLMDValidationEntity;
    FValidationMsgString: string;
    FErrorIndication: Boolean;
    FOnValidationError: TLMDValidationErrorEvent;
    //end of Validation support
    FModified : Boolean;
    FEditRect : TRect;
    FLeftMargin : Integer;
    FTopMargin : integer;
    FRightMargin : Integer;
    FMouseClick : boolean;
    FBorderStyle : TBorderStyle;
    FAutoSelect : Boolean;
    FAlignment : TAlignment;
    FReadOnly : Boolean;
    FWantTabs : Boolean;
    FPasswordChar : TLMDChar;
    FMaxLength : Integer;
    FSelected: boolean;
    FSelLength : Integer;
    FSelStartX: integer;
    FSelStartY: integer;
    FSelFirstX: integer;
    FSelFirstY: integer;
    FSelLastX: integer;
    FSelLastY: integer;
    FMultiline: boolean;
    FUserChangesOnly: boolean;
    FTransparent : Boolean;
    FTabString : TLMDString;
    FTabSpaces : integer;
    FHasCaret : boolean;
    FCaretX : integer;
    FCaretY : integer;
    FUpdate: boolean;
    FCueBanner: TLMDString;
    { multi level undo & redo support }
    FUndo: TElActionList;
    FRedo: TElActionList;
    { end }
    { Text drawer object }
    FTextPainter: TElTextPainter;
    FModifyCount : integer;
    FLineHeight : integer;
    FLeftChar : integer;
    FCharsInView : integer;
    FSelecting : boolean;
    FOnChange : TNotifyEvent;
    FOnSelectionChange : TNotifyEvent;
    ForceLeftAlignment : boolean;
    FBackground: TBitmap;
    FUseBackground: Boolean;
    FImgForm: TElImageForm;
    FImgFormChLink: TImgFormChangeLink;
    FBorderSides: TLMDBorderSides;
    FActiveBorderType: TElFlatBorderType;
    FFlat: Boolean;
    FInactiveBorderType: TElFlatBorderType;
    FHandleDialogKeys: Boolean;
    FMouseOver: Boolean;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;

    // Triple click support
    FDoubleClickCX: Integer;
    FDoubleClickCY: Integer;
    FLastClickTime: LongWord;
    FDoubleClickTimeout: LongWord;
    FFirstClickX: Integer;
    FFirstClickY: Integer;
    FClickCount: Byte;

    // String list for Multiline mode
    FElEditList: TElEditStrings;
    // First visible string
    FTopLine: integer;
    FWordWrap: boolean;
    FScrollBars: TScrollStyle;
    FLinesInRect: integer;
    FCharset: Integer;

    // FKeybLayout: HKL;

    FFlatFocusedScrollBars: Boolean;
    FUseCustomScrollBars : Boolean;
    FIgnoreReadOnlyState: Boolean;

    FAlienFocus : boolean;
    FAlignBottom : boolean;
    {$IFDEF LMD_UNICODE}
    FDeadCharList: TElDeadCharList;
    FKeys : WideString;
    FDeadChar: WideChar;
    FCDead: Integer;
    FKeyDown : boolean;
    FHint: TLMDString;
    {$ENDIF}

    FAscent: Integer;
    FDescent: Integer;

    FMouseDownPos: TPoint;

    FWaitForDragging: Boolean;
    FDragging: Boolean;
    FDragAllowed: Boolean;
    FSaveCursor: TCursor;

    FBookmarks: array[0..9] of TElBookmark;

    FRightAlignedText,
    FRightAlignedView: Boolean;
    FAutoSize: Boolean;
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FNotifyUserChangeOnly: Boolean;
    FCharCase: TElEditCharCase;
    FEnd: boolean;
    FWantReturns: Boolean;
    FUseSystemMenu: Boolean;
    FLocalizedSystemMenu: Boolean;

    FHideSelection : Boolean;
    FFocusedSelectColor: TColor;
    FFocusedSelectTextColor: TColor;
    FHideSelectColor: TColor;
    FHideSelectTextColor: TColor;
    FHighlightAlphaLevel: Integer;
    FLinkedControl: TControl;
    FLinkedControlPosition: TElLinkCtlPos;
    FLinkedControlSpacing: Integer;
    FUseDisabledColors: Boolean;
    FDisabledColor: TColor;
    FDisabledFontColor: TColor;
    FOnKeyPressEx: TElKeyPressExEvent;
    FOnPasteClipboardText: TElPasteClipboardEvent;
    FOnAfterPasteClipboardText: TNotifyEvent;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorShadow: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorWindow: TColor;
    FForceSetCaretX: Boolean;

    FDisplayReadOnlyOptions: TElDisplayOptions;

    FCommandCenter: TElKeyCommandList;
    FFirstKey: word;
    FFirstShift: TShiftState;
    FOnBeforeCommand: TElCommandEvent;
    FOnAfterCommand: TElCommandEvent;

    //----> 24.01.07 Add ShortCut to Stress Sign
    FStressShortCut: TShortCut;
    //<---- 24.01.07

    procedure AdjustFocusedRect(var aRect: TRect); virtual;
    procedure SetScrollBarsAutoShowing(const Value: TScrollStyle);

    //Validation support, November 2007, RS
    procedure SetValidationMsgString(val : TLMDString);
    function GetValidationMsgString : TLMDString;
    function GetControl : TControl;
    function GetControlBackBrush : TBrush;
    function GetControlFont : TFont;
    function GetValueToValidate: TLMDString;
    //end of Validation support

    //----> 24.01.07 Add ShortCut to Stress Sign
    procedure SetStressShortCut(Value: TShortCut);
    //<---- 24.01.07

    procedure TriggerTripleClick;

    procedure DrawEditText(Canvas: TCanvas; fl: Integer; FText: TLMDString; ATS: tagSIZE; sx: Integer; sy: Integer); virtual;

    function ScrollBarStylesStored: Boolean;
    procedure SetDisplayReadOnlyOptions(const Value: TElDisplayOptions);
    procedure DisplayOptionsChange(Sender: TObject); virtual;
    procedure ELSettingChange(var Message: TMessage); message EL_SETTINGCHANGE;
    procedure CMCtl3DChanged(var Msg : TMessage); message CM_CTL3DCHANGED;
    procedure WMCaptureChanged(var Msg: TMessage); message WM_CAPTURECHANGED;
    procedure WMKeyDown(var Msg : TWMKeyDown); message WM_KEYDOWN;
    procedure WMCut(var Msg : TMessage); message WM_CUT;
    procedure WMCopy(var Msg : TMessage); message WM_COPY;
    procedure WMPaste(var Msg : TMessage); message WM_PASTE;
    procedure WMClear(var Msg : TMessage); message WM_CLEAR;
    procedure WMGetText(var Message: TWMGetText); message WM_GETTEXT;
    procedure WMGetTextLength(var Message: TWMGetTextLength); message WM_GETTEXTLENGTH;
    procedure WMSetText(var Msg : TWMSetText); message WM_SETTEXT;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure PaintBackground();
    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMEnable(var Msg : TWMEnable); message WM_ENABLE;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMVScroll(var Msg : TWMScroll); message WM_VSCROLL;
    procedure WMHScroll(var Msg : TWMScroll); message WM_HSCROLL;
    procedure WMInputLangChange(var Msg: TMessage); message WM_INPUTLANGCHANGE;
    procedure WMCommand(var Msg: TWMCommand); message WM_COMMAND;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure EMSetRect(var Message: TMessage); message EM_SETRECT;
    procedure EMSetRectNP(var Message: TMessage); message EM_SETRECTNP;
    {$IFDEF LMD_UNICODE}
    procedure WMImeStartComposition(var Message : TMessage); message WM_IME_STARTCOMPOSITION;
    procedure WMImeComposition(var Message: TMessage); message WM_IME_COMPOSITION;
    {$ENDIF}

    procedure WndProc(var Msg: TMessage); override;

    procedure OnHScroll(Sender: TObject; ScrollCode: TElScrollCode;
                        var ScrollPos: Integer; var DoChange : boolean);
    procedure OnVScroll(Sender: TObject; ScrollCode: TElScrollCode;
                        var ScrollPos: Integer; var DoChange : boolean);
    procedure SBChanged(Sender: TObject);

    procedure SetReadOnly(newValue: Boolean); virtual;
    function GetReadOnly: Boolean; virtual;
    procedure SetAlignment(newValue: TAlignment);
    procedure SetLeftMargin(newValue: Integer);
    procedure SetRightMargin(newValue: Integer);
    procedure SetBorderStyle(newValue: TBorderStyle);
    procedure SetTransparent(newValue: Boolean);
    procedure SetHideSelection(newValue : Boolean); virtual;
    function  GetPasswordChar: TLMDString;
    procedure SetPasswordChar(newValue: TLMDString);
    procedure DoSetEditRect(newValue: TRect);
    procedure SetTabSpaces(newValue: integer);
    procedure SetModified(newValue: Boolean);
    function GetSelectedText: TLMDString;
    procedure SetBackground(const Value: TBitmap);
    procedure SetUseBackground(const Value: boolean);
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure ImageFormChange(Sender : TObject);
    procedure DragCanceled; override;
    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    procedure DrawBackground(DC: HDC; R: TRect);
    procedure DrawFlatBorder;
    procedure DrawParentControl(DC: HDC);
    procedure SetScrollBars(const Value: TScrollStyle);
    procedure SetTopLine(const Value: Integer);
    procedure SetCueBanner(const Value: TLMDString);
    procedure UpdateHeight;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;
    procedure BackgroundChanged(Sender: TObject);
    procedure SetFlatFocusedScrollBars(const Value: boolean);

    procedure SetUseCustomScrollBars(newValue : Boolean);

    procedure SetMaxLength(newValue : Integer); virtual;
    function  GetSelStart: integer; virtual;
    procedure SetSelStart(newValue : Integer); virtual;
    procedure SetSelLength(newValue : Integer); virtual;
    function GetSelLength: Integer; virtual;
    procedure SetSelText(const newValue : TLMDString); virtual;
    function  StringToPassword(AString : TLMDString) : TLMDString;
    function  ExpandTabbedString(Text : TLMDString) : TLMDString;
    procedure SetScrollBarsInfo;
    procedure MoveCaret(CharNum : integer);
    procedure MakeCaret;
    procedure RepaintText(Rect : TRect);
    procedure DrawTabbedText(const ACanvas: TCanvas; X, Y : integer; AText : TLMDString; var Size : TSize);

    function CharsFitRight(AWidth : integer; FText : TLMDString; StartPos : integer): Integer;
    function CharsFitLeft(AWidth : integer; FText: TLMDString; StartPos : integer): Integer;
    function GetRightOffsetForBackground: Integer; virtual;

    procedure Change; virtual;
    procedure TriggerSelectionChangeEvent; virtual;
    procedure TriggerBeforeCommand(AData: Pointer; AChar: Char; ACommand: TElCommand); virtual;
    procedure TriggerAfterCommand(AData: Pointer; AChar: Char; ACommand: TElCommand); virtual;
    procedure KeyPress(var Key : Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Paint; override;
    // procedure DrawFrame;
    procedure PaintText(Canvas : TCanvas); virtual;
    procedure PaintCueBanner(Canvas : TCanvas); virtual;
    procedure CreateParams(var Params : TCreateParams); override;
    function IsCursorUnderSelection(AX, AY: Integer): Boolean;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure MouseMove(Shift : TShiftState; X, Y : Integer); override;
    procedure SetImageForm(newValue : TElImageForm); virtual;
    procedure SetFlat(const Value: boolean); virtual;
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetThemedElement: TThemedElement; override;
    function GetLinesCount: Integer;
    procedure SetWordWrap(Value: boolean);
    procedure SetLeftChar(Value: integer);
    procedure SetAutoSize(Value: Boolean);override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure SetLines(Value: TLMDStrings);
    function GetLines: TLMDStrings;
    procedure SetTopMargin(Value: Integer);
    procedure SetAlignBottom(Value: boolean);
    // procedure UpdateFrame;
    procedure CMMouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure DoMouseEnter; virtual;
    procedure DoMouseLeave; virtual;
    procedure Loaded; override;
    procedure SetLineBorderActiveColor(Value: TColor); virtual;
    procedure SetLineBorderInactiveColor(Value: TColor); virtual;
    procedure SetActiveBorderType(const Value: TElFlatBorderType); virtual;
    procedure SetInactiveBorderType(const Value: TElFlatBorderType); virtual;
    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure SetThemeGlobalMode(const Value: Boolean);override;
    procedure SetThemeMode(const Value: TLMDThemeMode);override;
    procedure SetCharCase(Value: TElEditCharCase);
    procedure SetSelection(SelX, SelY: integer);
    procedure UnSelect;
    procedure DeleteSelection;
    procedure InsertText(const AText: TLMDString);
    {$IFDEF LMD_UNICODE}
    procedure WMDeadChar(var Msg : TWMDeadChar); message WM_DEADCHAR;
    procedure WMUniChar(var Msg: TMessage); message WM_UNICHAR;
    {$ENDIF}

    {$IFDEF LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    {$ENDIF}
    procedure SetBottomAlign;
    function GetText: TLMDString;
    function ConvertToCRLF(Str : TLMDString): TLMDString;
    procedure SetCaretX(const value: integer);
    procedure SetCaretY(const value: integer);
    function GetCaretXY: TPoint;
    procedure SetCaretXY(const value: TPoint);
    procedure CorrectLeftChar;
    procedure SetCaretPosition(const X, Y: integer);
    procedure SetMultiline(const Value: boolean);
    procedure SetMaxLevel(const Value: integer);
    function GetMaxLevel: integer;
    function CreateTextPainter: TElTextPainter; virtual;

    procedure EMGetSel(var Message: TMessage); message EM_GETSEL;
    procedure EMGetLine(var Message: TMessage); message EM_GETLINE;
    procedure EMGetLineCount(var Message: TMessage); message EM_GETLINECOUNT;
    procedure EMLineIndex(var Message: TMessage); message EM_LINEINDEX;
    procedure EMSetSel(var Message: TMessage); message EM_SETSEL;
    procedure EMReplaceSel(var Message: TMessage); message EM_REPLACESEL;
    procedure EMGetFirstVisibleLine(var Message: TMessage); message EM_GETFIRSTVISIBLELINE;
    procedure EMScroll(var Message: TMessage); message EM_SCROLL;
    procedure EMLineScroll(var Message: TMessage); message EM_LINESCROLL;
    procedure EMScrollCaret(var Message: TMessage); message EM_SCROLLCARET;
    procedure EMLineFromChar(var Message: TMessage); message EM_LINEFROMCHAR;
    procedure EMPosFromChar(var Message: TMessage); message EM_POSFROMCHAR;
    procedure EMCanUndo(var Message: TMessage); message EM_CANUNDO;
    procedure EMUndo(var Message: TMessage); message EM_UNDO;
    procedure SetEditRect(Value : TRect); virtual;
    procedure DefineProperties(Filer : TFiler); override;
    procedure ReadRTLContent(Reader : TReader);
    procedure SetRightAlignedView(Value: Boolean); virtual;
    procedure SetRightAlignedText(Value: Boolean); virtual;
    procedure SetFocusedSelectColor(Value: TColor); virtual;
    procedure SetFocusedSelectTextColor(Value: TColor); virtual;
    procedure SetHideSelectColor(Value: TColor); virtual;
    procedure SetHideSelectTextColor(Value: TColor); virtual;
    procedure DoChange; virtual;
    procedure SetHighlightAlphaLevel(Value: Integer); virtual;
    procedure SetLinkedControl(Value: TControl);
    procedure UpdateLinkedControl;
    procedure SetLinkedControlPosition(Value: TElLinkCtlPos);
    procedure SetLinkedControlSpacing(Value: Integer);
    function AdjustRectSB(const ARect : TRect): TRect;
    procedure SetUseDisabledColors(Value: Boolean);
    procedure SetDisabledColor(Value: TColor);
    procedure SetDisabledFontColor(Value: TColor);
    procedure ReadChangeDisabledText(Reader : TReader);
    function HasCustomBackground: Boolean;
    procedure ReadLinkCtlPos(Reader : TReader);
    procedure TriggerKeyPressEx(var Key : TLMDString); virtual;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);
    function GetBkColor: TColor; virtual;
    function GetTextColor: TColor; virtual;
    procedure GetThemedElementDetails(var ADetails: TThemedElementDetails); virtual;
//    procedure GetPaintThemedElementDetails(var ADetails: TThemedElementDetails); virtual;

    property RightAlignedText: Boolean read FRightAlignedText write FRightAlignedText default false;
    property RightAlignedView: Boolean read FRightAlignedView write SetRightAlignedView default false;

    property Background: TBitmap read FBackground write SetBackground;
    property UseBackground: Boolean read FUseBackground write SetUseBackground default False;
    property PasswordChar : TLMDString read GetPasswordChar write SetPasswordChar; { Published }
    property MaxLength : Integer read FMaxLength write SetMaxLength default 0; { Published }
    property Transparent : Boolean read FTransparent write SetTransparent default false; { Published }
    property ReadOnly : Boolean read GetReadOnly write SetReadOnly default false; { Published }
    property WantTabs : Boolean read FWantTabs write FWantTabs default false; { Published }
    property Alignment : TAlignment read FAlignment write SetAlignment default taLeftJustify; { Published }
    property BorderStyle : TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle; { Published }
    property AutoSelect : Boolean read FAutoSelect write FAutoSelect default false; { Published }
    property HideSelection : Boolean read FHideSelection write SetHideSelection default true; { Published }

    property EditRect : TRect read FEditRect write DoSetEditRect; { Published }
    property ImageForm: TElImageForm read FImgForm write SetImageForm;
    property Flat: Boolean read FFlat write SetFlat default False;
    property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write
        SetInactiveBorderType default fbtSunkenOuter;

    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars default ssNone;
    property ScrollBarsAutoShowing: TScrollStyle read FScrollBarsAutoShowing write SetScrollBarsAutoShowing default ssNone;

    property ActiveBorderType: TElFlatBorderType read FActiveBorderType write
        SetActiveBorderType default fbtSunken;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default true;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsRight, ebsTop, ebsBottom];
    property CharCase: TElEditCharCase read FCharCase write SetCharCase default
        eecNormal;
    property FlatFocusedScrollBars: Boolean read FFlatFocusedScrollBars write
        SetFlatFocusedScrollBars default False;
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor default clBtnFace;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor default clBtnFace;
    property Lines: TLMDStrings read GetLines write SetLines;
    property MaxUndoLevel : integer read GetMaxLevel write SetMaxLevel default 0;
    property Multiline : boolean read FMultiline write SetMultiline default false;
    property TabSpaces : Integer read FTabSpaces write SetTabSpaces default 4;
    property UseSystemMenu: Boolean read FUseSystemMenu write FUseSystemMenu
        default True;
    property LocalizedSystemMenu: Boolean read FLocalizedSystemMenu write FLocalizedSystemMenu
        default False;
    property WantReturns: Boolean read FWantReturns write FWantReturns default false;
    property WordWrap: boolean read FWordWrap write SetWordWrap default false;

    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnSelectionChange : TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property FocusedSelectColor: TColor read FFocusedSelectColor write
        SetFocusedSelectColor default clHighlight;
    property FocusedSelectTextColor: TColor read FFocusedSelectTextColor write
        SetFocusedSelectTextColor default clHighlightText;
    property HideSelectColor: TColor read FHideSelectColor write SetHideSelectColor
        default clBtnFace;
    property HideSelectTextColor: TColor read FHideSelectTextColor write
        SetHideSelectTextColor default LMDElHideSelectTextColor;
    property HighlightAlphaLevel: Integer read FHighlightAlphaLevel write
        SetHighlightAlphaLevel default 255;
    property LinkedControl: TControl read FLinkedControl write SetLinkedControl;
    property LinkedControlPosition: TElLinkCtlPos read FLinkedControlPosition write
        SetLinkedControlPosition default lcpTopLeft;
    property LinkedControlSpacing: Integer read FLinkedControlSpacing write
        SetLinkedControlSpacing default 0;
    property UseDisabledColors: Boolean read FUseDisabledColors write
        SetUseDisabledColors default false;
    property DisabledColor: TColor read FDisabledColor write SetDisabledColor
        default clBtnFace;
    property DisabledFontColor: TColor read FDisabledFontColor write
        SetDisabledFontColor default clGrayText;
    // candidates to publishing:
    {< ELSCROLLBAR}
    property HorzScrollBarStyles: TElCtrlScrollBarStyles read GetHorzScrollBar
      write SetHorzScrollBar stored ScrollBarStylesStored;
    property VertScrollBarStyles: TElCtrlScrollBarStyles read GetVertScrollBar
      write SetVertScrollBar stored ScrollBarStylesStored;
    {> ELSCROLLBAR}
    property UseCustomScrollBars : Boolean read FUseCustomScrollBars write SetUseCustomScrollBars
      default True;  { Published }
    property OnKeyPressEx: TElKeyPressExEvent read FOnKeyPressEx write
        FOnKeyPressEx;
    property OnPasteClipboardText: TElPasteClipboardEvent read  FOnPasteClipboardText write
        FOnPasteClipboardText;
    property OnAfterPasteClipboardText: TNotifyEvent read FOnAfterPasteClipboardText write FOnAfterPasteClipboardText;
  public
    { Public declarations }
    //Validation support, November 2007, RS
    function SupportsDefaultIndication: boolean;
    property ControlFont : TFont read GetControlFont;
    property ControlBackBrush : TBrush read GetControlBackBrush;
    procedure RespondToError(ErrorLevel: TLMDErrorLevel);
    procedure SetValidator(Validator:TLMDValidationEntity);
    function GetValidator: TLMDValidationEntity;
    //End of Validation support

    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure AdjustHeight; virtual;
    procedure SetText(newValue: TLMDString);
    function GetNextWord(ACaret: TPoint) : TPoint;
    function GetPrevWord(ACaret: TPoint) : TPoint;

    procedure CommandCenter(ACommand: TElCommand; AChar: Char; AData: Pointer); virtual;
    procedure ExecuteCommand(ACommand: TElCommand; AChar: Char; AData: Pointer); virtual;

    //----> 26.01.07
    procedure SetStress(const X, Y: Integer); virtual;
    //<---- 26.01.07
    procedure SetBookmark(const Index: Integer); virtual;
    procedure GotoBookmark(const Index: Integer); virtual;

    function CaretFromChar(const CharNum: integer): TPoint;
    function CharFromCaret(const X, Y: integer): integer;
    function PosFromCaret(const X, Y: integer): TPoint; virtual;
    procedure CaretFromPos(APos: TPoint; var ACaretX, ACaretY: integer); virtual;

    procedure SelectAll;
    procedure CutToClipboard; virtual;
    procedure CopyToClipboard; virtual;
    procedure PasteFromClipboard; virtual;
    procedure Undo;
    procedure ClearUndo;
    procedure Scroll(ScrollDir : TElEditScrollDir);
    procedure ScrollCaret;
    function GetCanUndo: boolean;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property DeadCharList: TElDeadCharList read FDeadCharList;
    property SelStart : Integer read GetSelStart write SetSelStart; { Published }
    property SelLength : Integer read GetSelLength write SetSelLength; { Published }
    property SelText : TLMDString read GetSelectedText write SetSelText; { Published }
    property Modified : Boolean read FModified write SetModified default False; { Public }
    property SelectedText : TLMDString read GetSelectedText;
    property MouseOver: Boolean read FMouseOver;
    property LinesCount: Integer read GetLinesCount;
    property TopLine: Integer read FTopLine write SetTopLine;
    property LeftChar: integer read FLeftChar write SetLeftChar;
    property LeftMargin : Integer read FLeftMargin write SetLeftMargin default 1; { Published }
    property RightMargin : Integer read FRightMargin write SetRightMargin default 1; { Published }

    property HandleDialogKeys: Boolean read FHandleDialogKeys write FHandleDialogKeys default false;
    property Text: TLMDString read GetText write SetText;
    property TopMargin: Integer read FTopMargin write SetTopMargin default 0;
    property AlignBottom : boolean read FAlignBottom write SetAlignBottom default True;

    property CaretX: integer read FCaretX write SetCaretX;
    property CaretY: integer read FCaretY write SetCaretY;
    property CaretXY: TPoint read GetCaretXY write SetCaretXY;
    property CanUndo: boolean read GetCanUndo;
    property DragAllowed: Boolean read FDragAllowed write FDragAllowed default False;
    procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;
    property UseXPThemes;
  published
    property DisplayReadOnlyOptions: TElDisplayOptions read FDisplayReadOnlyOptions write SetDisplayReadOnlyOptions;
    property NotifyUserChangeOnly: Boolean read FNotifyUserChangeOnly write FNotifyUserChangeOnly
      default true; // AND DO NOT CHANGE THIS!!!
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace
        default clBtnFace;
    property BorderColorShadow: TColor read FBorderColorShadow write
        SetBorderColorShadow default clBtnShadow;
    property BorderColorHighlight: TColor read FBorderColorHighlight write
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorWindow: TColor read FBorderColorWindow write
        SetBorderColorWindow default clWindow;
    //----> 24.01.07 Add ShortCut to Stress Sign
    property StressShortCut: TShortCut read FStressShortCut write SetStressShortCut default 0;
    //<---- 24.01.07

    //Validation support, November 2007, RS
    property ValidationMsgString : TLMDString read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read FOnValidationError write FOnValidationError;
    //End of Validation support

    property CueBanner: TLMDString read FCueBanner write SetCueBanner;
    property DoubleBuffered;
    {$IFDEF LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$ENDIF}
    property TabStop default true;
    property ImeMode;
    property ImeName;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;
  end; { TCustomElEdit }

  TCustomElMemo = class(TCustomElEdit)
  public
    constructor Create(AOwner : TComponent); override;
  end;

  TElMemo = class (TCustomElMemo)
  published
    //----> 24.01.07 Add ShortCut to Stress Sign
    property StressShortCut;
    //<---- 24.01.07

    property AutoSize;
    property Alignment;
    property AlignBottom default False;
    property Background;
    property BorderSides;

    property Cursor default crIBeam;

    property CharCase;
    property UseBackground;
    property RightAlignedText;
    property RightAlignedView;
    property PasswordChar;
    property MaxLength;
    property Transparent;
    property FlatFocusedScrollBars;
    property ReadOnly;
    property WantTabs;
    property LeftMargin;
    property RightMargin;
    property TopMargin;
    property BorderStyle;
    property AutoSelect;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;
    property TabSpaces;
    property Lines stored false;
    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;
    property Text;

    property ImageForm;
    property ActiveBorderType;
    property Flat;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property MaxUndoLevel;

    property WantReturns default true;
    property WordWrap;
    property ScrollBars;
    property ScrollBarsAutoShowing;

    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;

    property UseSystemMenu;
    property LocalizedSystemMenu;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;
    property OnKeyPressEx;
    property OnPasteClipboardText;
    property OnAfterPasteClipboardText;

    property Align;

    property Anchors;
    property Color;
    property Constraints;
    property Ctl3D default True;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default False;
    property ParentCtl3D default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

  property OnStartDock;
      property OnEndDock;
  property OnContextPopup;
  end;

  TElEdit = class (TCustomElEdit)
  published
    //----> 24.01.07 Add ShortCut to Stress Sign
    property StressShortCut;
    //<---- 24.01.07

    property AutoSize;
    property Alignment;
    property AlignBottom;
    property Background;
    property BorderSides;

    property Cursor default crIBeam;

    property CharCase;
    property UseBackground;
    property RightAlignedText;
    property RightAlignedView;
    property PasswordChar;
    property MaxLength;
    property Transparent;
    property FlatFocusedScrollBars;
    property ReadOnly;
    property WantTabs;
    property LeftMargin;
    property RightMargin;
    property TopMargin;
    property BorderStyle;
    property AutoSelect;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;
    property TabSpaces;
    property Lines stored false;
    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;
    property Text;

    property ImageForm;
    property ActiveBorderType;
    property Flat;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property MaxUndoLevel;

    property WantReturns;
    property WordWrap;
    property Multiline;
    property ScrollBars;
    property ScrollBarsAutoShowing;

    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;

    property UseSystemMenu;
    property LocalizedSystemMenu;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;
    property OnKeyPressEx;
    property OnPasteClipboardText;

    property Align;

    property Anchors;
    property Color;
    property Constraints;
    property Ctl3D default True;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default false;
    property ParentCtl3D default false;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnStartDock;
    property OnEndDock;
    property OnContextPopup;
  end;

  TIntArray = array[0..MaxInt div sizeof(integer) -1] of integer;
  PIntArray = ^TIntArray;

var
  RepaintAll : boolean = true;
  FlagEdit : boolean;

const
  ElFSpace = {$IFDEF LMD_UNICODE}WideChar(#32){$ELSE}#32{$ENDIF};
  ElFTab = {$IFDEF LMD_UNICODE}WideChar(#9){$ELSE}#9{$ENDIF};
  ElFCR = {$IFDEF LMD_UNICODE}WideChar(#13){$ELSE}#13{$ENDIF};
  ElFLF = {$IFDEF LMD_UNICODE}WideChar(#10){$ELSE}#10{$ENDIF};
  ElFCRLF = {$IFDEF LMD_UNICODE}WideString(#13#10){$ELSE}#13#10{$ENDIF};
  ID_UNDO = 772;
  ID_CUT = 768;
  ID_COPY = 769;
  ID_PASTE = 770;
  ID_DELETE = 771;

implementation

uses
  ElCombos, UxTheme;

// ToDo Alex --> same also available in ElInputProcessor.pas

{$IFDEF LMD_UNICODE}
type
  ToUnicodeProc2 = function(wVirtKey, wScanCode: UINT; const KeyState: TKeyboardState;
                            var pwszBuff; cchBuff: Integer; wFlags: UINT): Integer; stdcall;
var
  ToUnicode : ToUnicodeProc2;
{$ENDIF}

var
  ElWhatIsMenu,
  ElEditMenu,
  ElSysWindowMenu,
  ElMDIWindowMenu,
  ID_SELECTALL: integer;

procedure ElCallSysMenu(const IDOfMenu, Handle, X, Y: Integer; FEdit: TCustomElEdit);
var
  SysMenu: HMENU;
  h: THandle;
  LTempInfo: TMenuItemInfo;
begin
  SysMenu := 0;
  if LMDSIWindowsNTUp then
  begin
    h := GetModuleHandle(PChar('user32.dll'));
    SysMenu := LoadMenu(h, MAKEINTRESOURCE(IDOfMenu));
  end;
  if SysMenu <> 0 then
  try
    SysMenu := GetSubMenu(SysMenu, 0);
    if IDOfMenu = ElEditMenu then
    begin
      if LMDSIWindows2000Up then
      begin
        RemoveMenu(SysMenu, 32769, MF_BYCOMMAND);
        RemoveMenu(SysMenu, 32768, MF_BYCOMMAND);
        RemoveMenu(SysMenu, 32787, MF_BYCOMMAND);
        RemoveMenu(SysMenu, 8, MF_BYPOSITION);
      end;

      if FEdit.FLocalizedSystemMenu then
      begin
        LTempInfo.cbSize := SizeOf(LTempInfo);
        LTempInfo.fMask := MIIM_STRING;

        LTempInfo.dwTypeData := PChar(SLMDUndo);
        SetMenuItemInfo(SysMenu, ID_UNDO, false, LTempInfo);

        LTempInfo.dwTypeData := PChar(SLMDCut);
        SetMenuItemInfo(SysMenu, ID_CUT, false, LTempInfo);

        LTempInfo.dwTypeData := PChar(SLMDCopy);
        SetMenuItemInfo(SysMenu, ID_COPY, false, LTempInfo);

        LTempInfo.dwTypeData := PChar(SLMDPaste);
        SetMenuItemInfo(SysMenu, ID_PASTE, false, LTempInfo);

        LTempInfo.dwTypeData := PChar(SLMDDelete);
        SetMenuItemInfo(SysMenu, ID_DELETE, false, LTempInfo);

        LTempInfo.dwTypeData := PChar(SLMDSelectAll);
        SetMenuItemInfo(SysMenu, ID_SELECTALL, false, LTempInfo);
      end;

      if not FEdit.CanUndo then
        EnableMenuItem(SysMenu, ID_UNDO, MF_GRAYED or MF_BYCOMMAND);
      if FEdit.SelLength = 0 then
      begin
        EnableMenuItem(SysMenu, ID_COPY, MF_GRAYED or MF_BYCOMMAND);
        EnableMenuItem(SysMenu, ID_CUT, MF_GRAYED or MF_BYCOMMAND);
        EnableMenuItem(SysMenu, ID_DELETE, MF_GRAYED or MF_BYCOMMAND);
      end;
      if (not (Clipboard.HasFormat(CF_TEXT) or Clipboard.HasFormat(CF_UNICODETEXT))) or
        FEdit.ReadOnly
      then
        EnableMenuItem(SysMenu, ID_PASTE, MF_GRAYED or MF_BYCOMMAND);

      if (FEdit.SelLength = Length(FEdit.Text)) then
        EnableMenuItem(SysMenu, ID_SELECTALL, MF_GRAYED or MF_BYCOMMAND);

    end;
    TrackPopupMenu(SysMenu, TPM_LEFTALIGN or TPM_RIGHTBUTTON, X, Y, 0, Handle, nil);
  finally
    DestroyMenu(SysMenu);
  end;
end;
// {$endif}

// move to ElVCLUtils.pas
// ToDo Alex
function ElGetTextExtentExPoint(DC: HDC; lpszStr: PLMDChar; cchString: integer;
                                 nMaxExtent: integer; var lpnFit: integer;
                                 alpDX: PInteger; var lpSize: TSize): BOOL;

{$IFDEF LMD_UNICODE}
var
  i : integer;
{$ENDIF}
begin
  Result := false;
  if (Length(lpszStr) = 0) then
  begin
    lpnFit := 0;
    exit;
  end;
  {$IFDEF LMD_UNICODE}
  if LMDSIWindowsNTUp then
   Result := GetTextExtentExPointW(DC, PWideChar(lpszStr), cchString, nMaxExtent,
      @lpnFit,
      alpDX,
      lpSize)
    else
  begin
    i := 0;
    GetTextExtentPoint32W(DC, PWideChar(lpszStr), i + 1, lpSize);
    while lpSize.cx <= nMaxExtent do
    begin
      if Assigned(alpDX) then
      begin
        Move(lpSize.cx, alpDX^, SizeOf(Integer));
        Inc(PChar(alpDX), SizeOf(Integer));
      end;
      inc(i);
      if i > Length(lpszStr) then
      begin
        lpnFit := Length(lpszStr);;
        exit;
      end;
      GetTextExtentPoint32W(DC, PWideChar(lpszStr), i + 1, lpSize);
      end;
    lpnFit := i;
  end;
  {$ELSE}
  Result := GetTextExtentExPointA(DC, PChar(lpszStr), cchString, nMaxExtent, @lpnFit,
    alpDX, lpSize);
  {$ENDIF}
end;

{--*******************************************************************
      Class: TCustomElEdit
*******************************************************************--}
procedure TCustomElEdit.SetPasswordChar(newValue : TLMDString);
{ Sets data member FPasswordChar to newValue. }
begin
  if (PasswordChar <> newValue) then
  begin
    if Length(newValue) > 0 then
      FPasswordChar := newValue[1]
    else
      FPasswordChar := #0;
    Invalidate;
  end; { if }
end; { SetPasswordChar }

function TCustomElEdit.GetPasswordChar : TLMDString;
begin
  if FPasswordChar = #0 then
    result := ''
  else
    result := FPasswordChar;
end;

procedure TCustomElEdit.SetMaxLength(newValue : Integer);
{ Sets data member FMaxLength to newValue. }
begin
  if (FMaxLength <> newValue) and (NewValue >= 0) then
  begin
    FMaxLength := newValue;
    if (FMaxLength > 0) and (Length(Text) > FMaxLength) then
      Text := Copy(Text, 1, FMaxLength);
  end; { if }
end; { SetMaxLength }

function TCustomElEdit.GetSelStart: integer;
begin
  if SelLength = 0 then
    Result := CharFromCaret(CaretX, CaretY)
  else
    Result := CharFromCaret(Min(FSelStartX, FSelFirstX), FSelStartY)
end;

procedure TCustomElEdit.SetSelStart(newValue : Integer);
{ Sets data member FSelStart to newValue. }
var
  FPos: TPoint;
begin
  FPos := CaretFromChar(newValue);
  UnSelect;
  CaretY := FPos.Y;
  CaretX := FPos.X;
  FSelStartX := CaretX;
  FSelStartY := CaretY;
end; { SetSelStart }

procedure TCustomElEdit.SetSelText(const newValue : TLMDString);
var
  fx, fy: integer;
begin
  if FSelected then
    DeleteSelection;
  fx := CaretX;
  fy := CaretY;
  FElEditList.InsertText(fx, fy, newValue);
  SetSelection(fx, fy);
  CaretY := fy;
  CaretX := fx;
  DoChange;
  if not NotifyUserChangeOnly then
    Change;
end;

function TCustomElEdit.GetSelLength: Integer;
begin
  Result := Length(SelText);
end;

procedure TCustomElEdit.SetSelLength(newValue : Integer);
{ Sets data member FSelLength to newValue. }
var
  FPos: TPoint;
begin
  if newValue = 0 then
    UnSelect
  else
  begin
    FPos := CaretFromChar(SelStart + newValue);
    SetSelection(FPos.X, FPos.Y);
    CaretY := FPos.Y;
    CaretX := FPos.X;
  end;
end; { SetSelLength }

procedure TCustomElEdit.ELSettingChange(var Message: TMessage);
begin
  if UseCustomScrollBars then
  begin
    SetEditRect(ClientRect);
    SetScrollBarsInfo;
  end;
end;

procedure TCustomElEdit.SetTransparent(newValue : Boolean);
{ Sets data member FTransparent to newValue. }
begin
  if (FTransparent <> newValue) then
  begin
    FTransparent := newValue;
    if FTransparent then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    if HandleAllocated then
      RecreateWnd;
  end; { if }
end; { SetTransparent }

procedure TCustomElEdit.WMCut(var Msg : TMessage); { private }
begin
  ExecuteCommand(eecCut, #0, nil);
end; {WMCut}

procedure TCustomElEdit.WMCopy(var Msg : TMessage); { private }
begin
  ExecuteCommand(eecCopy, #0, nil);
end; {WMCopy}

procedure TCustomElEdit.WMPaste(var Msg : TMessage); { private }
begin
  ExecuteCommand(eecPaste, #0, nil);
end; {WMPaste}

procedure TCustomElEdit.WMClear(var Msg : TMessage); { private }
begin
  SelText := '';
end; { WMClear }

procedure TCustomElEdit.WMSetText(var Msg : TWMSetText); { private }
var
  {$IFDEF LMD_UNICODE}
  ANewStr : WideString;
  Len : integer;
  Temp : string;
  Dsgn : boolean;
  {$ELSE}
  ANewStr : String;
  {$ENDIF}

begin
  {$IFDEF LMD_UNICODE}
  if (Msg.Unused = 1) or LMDSIUnicodeDelphi then
    ANewStr := LMDWideStrPas(PWideChar(Msg.Text))
  else
  begin
    Temp := StrPas(Msg.Text);
    if (csDesigning in ComponentState) then
      Dsgn := (Pos(Name, Temp) <> 1)
    else
      Dsgn := false;

    if Dsgn then
      ANewStr := LMDWideStrPas(PWideChar(Msg.Text))
      else
    begin
      Len := MultiByteToWideChar(GetACP(), MB_PRECOMPOSED or MB_USEGLYPHCHARS,
                                 PAnsiChar(Temp), Length(Temp), nil, 0);
      if Len > 0 then
      begin
        SetLength(ANewStr, Len);
        MultiByteToWideChar(GetACP(), MB_PRECOMPOSED or MB_USEGLYPHCHARS, PAnsiChar(Temp),
                            Length(Temp), PWideChar(ANewStr), Len)
        end
      else
        ANewStr := '';
    end;
  end;
  {$ELSE}

  ANewStr := StrPas(Msg.Text{PChar(Msg.lParam)});
  {$ENDIF}
  Msg.Result := 0;
  FElEditList.Text := ANewStr;

  if HandleAllocated then
    SetCaretPosition(CaretX, CaretY);
  Msg.Result := 1;
  DoChange;
  if not NotifyUserChangeOnly then
    Change;
  TriggerSelectionChangeEvent;
  if HandleAllocated then
    RepaintText(EditRect);
end; { WMSetText }

procedure TCustomElEdit.GetThemedElementDetails(var ADetails: TThemedElementDetails);
begin
  ADetails.Element := GetThemedElement;
  if LMDSIWindowsVistaUp and (UseThemeMode = ttmPlatform) then
  begin
    ADetails.Part := EP_EDITBORDER_VSCROLL;

    if Focused or MouseOver then
      ADetails.State := Ord(teEditTextHot)
    else
      ADetails.State := 1;
  end
  else
  begin
    ADetails.Part := 0;
    if FMouseOver then
      ADetails.State := 2
    else
      ADetails.State := 0;
  end;
end;

procedure TCustomElEdit.PaintBackground(); { private }
var DC :HDC;
    RW :TRect;
    RC :TRect;
    b  : Boolean;
    LDetail: TThemedElementDetails;
  procedure CallInheritedWOFrame;
  var
    WS, WES :DWORD;
  begin
    try
      WES := GetWindowLong(Handle, GWL_EXSTYLE);
      if WES and WS_EX_CLIENTEDGE <> 0 then
      begin
        WS := 0;
        FPreventStyleChange := True;
        SetWindowLong(Handle, GWL_EXSTYLE, WES and not WS_EX_CLIENTEDGE);
      end
      else
      begin
        WES := 0;
        WS  := GetWindowLong(Handle, GWL_STYLE);
        if WS and WS_BORDER <> 0 then
        begin
          FPreventStyleChange := True;
          SetWindowLong(Handle, GWL_STYLE, WS and not WS_BORDER);
        end
        else
          WS := 0;
      end;
      {
       todo:
         if there are both system scrollbars then default handler will
         fill the frame in the area of their junction
      }
      //inherited;
      if WES <> 0 then
        SetWindowLong(Handle, GWL_EXSTYLE, WES)
      else if WS <> 0 then
        SetWindowLong(Handle, GWL_STYLE, WS);

      if Flat or (not (IsThemed and (BorderStyle = bsNone))) then
        DrawFlatBorder; {under Win9X while changing  SetWindowLong a call to
                         DrawFlatBorder causes never-ending cycle. This is why
                         FPreventStyleChange is introduced}
    finally
      if FPreventStyleChange then
        FPreventStyleChange := False;
    end;
  end;

  procedure PaintCrossSystemScrollbarsArea;
    var
      nFrameSize :Integer;
      RW         :TRect;
  begin
    // paint cross scrollbars area for system scrollbars:
    begin
      GetWindowRect(Handle, RW);
      MapWindowPoints(0, Handle, RW, 2);
      OffsetRect(RW, -RW.Left, -RW.Top);

      if ((GetWindowLong(Handle, GWL_STYLE) and WS_BORDER) = WS_BORDER) then
        nFrameSize := GetSystemMetrics(SM_CXBORDER)
      else
        if ((GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
        nFrameSize := GetSystemMetrics(SM_CXEDGE)
      else
        nFrameSize := 0;

      with RW do
      begin
        if (not RightAlignedView) or (not NewStyleControls) then
        begin
          dec(Right, nFrameSize);
          Left:= Right - GetSystemMetrics(SM_CXVSCROLL);
          dec(Bottom, nFrameSize);
          Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
        end
        else
        begin
          Left   := nFrameSize;
          Right := Left + GetSystemMetrics(SM_CXVSCROLL);
          dec(Bottom, nFrameSize);
          Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
        end;
        Windows.DrawEdge(DC, RW, EDGE_SUNKEN, BF_MIDDLE);
      end;
    end;
  end;

begin
  if FPreventStyleChange then
    exit;

  b := (BorderStyle = bsSingle);

  if IsThemed and (BorderStyle = bsSingle) {and not Transparent} then
  begin
    GetThemedElementDetails(LDetail);
    //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    //if DC = 0 then
      DC := GetWindowDC(Handle);

    if b
       and (not UseCustomScrollBars)
    then
      CallInheritedWOFrame;

    Windows.GetClientRect(Handle, RC);

    if UseCustomScrollBars then
    begin
      if VertScrollBarStyles.Visible then
      begin
        if not RightAlignedView then
          inc(RC.Right, VertScrollBarStyles.Depth)
        else
          dec(RC.Left, VertScrollBarStyles.Depth)
      end;
      if HorzScrollBarStyles.Visible then
        inc(RC.Bottom, HorzScrollBarStyles.Depth);
      end
    else
    begin
      if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
      begin
        if (not RightAlignedView) or (not NewStyleControls) then
          inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL))
        else
          dec(RC.Left, GetSystemMetrics(SM_CXVSCROLL));
      end;
      if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
        inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));

      // paint cross scrollbars area for system scrollbar:
      if (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) and
         (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0)
      then
        PaintCrossSystemScrollbarsArea;
    end;

    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    OffsetRect(RW, -RW.Left, -RW.Top);
    LMDThemeServices.DrawElement(UseThemeMode, DC, LDetail, RW);
    ReleaseDC(Handle, DC);
  end
  else
  begin
    CallInheritedWOFrame;
    if RightAlignedView and (not UseCustomScrollBars) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) and
       (NewStyleControls)
    then
    begin
      //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
      //if DC = 0 then
      DC := GetWindowDC(Handle);
      PaintCrossSystemScrollbarsArea;
      ReleaseDC(Handle, DC);
    end;
  end;

end; { WMNCPaint }

procedure TCustomElEdit.WMEraseBkgnd(var Msg : TWMEraseBkgnd); { private }
var
  ACtl   : TWinControl;
  BgRect,
  R1: TRect;
  //R: TRect;
//  RW     : TRect;
//  sid    : integer;
  //aBrush : HBrush;
  //AColor : TColor;
  //lBmp: TBitmap;
begin
  if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and
   (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
  begin
    if (FImgForm.Control <> Self) then
    begin
      ACtl := FImgForm.GetRealControl;
      R1 := AdjustRectSB(ClientRect);
      BgRect := R1;
      BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);

      BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
      BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

      FImgForm.PaintBkgnd(Msg.DC, R1, Point(BgRect.Left, BgRect.Top), false);
    end;
  end
  else
  if FTransparent and (not IsThemed) then
    DrawParentControl(Msg.DC);
(*  else   //outcommented VB aug 2009: block is redundant
  if (not IsThemed) or LMDApplication.ThemeUseColorProperty then
  begin
    try
      lBmp := TBitmap.Create;
      GetClipBox(Msg.DC, R1);
      IntersectRect(R, ClientRect, R1);
      lBmp.Width := R.Right - R.Left;
      lBmp.Height := R.Bottom - R.Top;
      AColor := GetBkColor;
      ABrush := CreateSolidBrush(ColorToRGB(AColor));
      //FillRect(Msg.DC, R, ABrush); //This causes blinking even when typing, see BTS#721 VB Aug 2009
      FillRect(lBmp.Handle, Rect(0,0,lBmp.Width, lBmp.Height), aBrush);
      BitBlt(Msg.DC, R.Left, R.Top, lBmp.Width, lBmp.Height, lBmp.Handle, 0, 0, SRCCOPY);
      DeleteObject(ABrush);
    finally
      lBmp.Free;
    end;
  end;*)
  Msg.Result := 1;
end;

procedure TCustomElEdit.Paint; { protected }
var
  BMP : TBitmap;
  Rect: TRect;
  R,
  R1, R2 : TRect;
  RW     : TRect;
  aBrush : HBrush;
  AColor : TColor;
  bx, by : integer;
//  LDetail: TThemedEdit;
  LDetails: TThemedElementDetails;
//  LMsg: TMessage;
begin
  if not HandleAllocated then
    exit;
  if Flat and not IsThemed then
    DrawFlatBorder;

  BMP := TBitmap.Create;
  try
    begin
      BMP.Height := ClientHeight;
      BMP.Width := ClientWidth;
    end;
    Rect := Canvas.ClipRect;
    if IsRectEmpty(Rect) then
      Rect := EditRect;

    Rect := AdjustRectSB(Rect);

    if (FImgForm = nil) or (FImgForm.Backgroundtype = bgtColorFill) or
     (csDesigning in FImgForm.GetRealControl.ComponentState) then
    begin
      if Transparent then
        bitblt(Bmp.Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left,
          Rect.Bottom - Rect.Top, Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY)
      else
      if FUseBackground and not FBackground.Empty then
        DrawBackground(BMP.Canvas.Handle, ClientRect)
      else
      if not IsThemed then //vb aug 2009
      begin
        GetClipBox(BMP.Canvas.Handle, R1);
        IntersectRect(R, ClientRect, R1);
        Dec(R.Right, GetRightOffsetForBackground);
        AColor := GetBkColor;
        ABrush := CreateSolidBrush(ColorToRGB(AColor));
        FillRect(BMP.Canvas.Handle, R, ABrush);
        DeleteObject(ABrush);
      end;
    end
    else
    begin
      bitblt(Bmp.Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left,
        Rect.Bottom - Rect.Top, Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY);
    end;

    if IsThemed {and (BorderStyle = bsSingle)} then //vb aug 2009
    begin
      RW := BoundsRect;

      if Parent <> nil then
        MapWindowPoints(Parent.Handle, Handle, RW, 2)
      else
      if ParentWindow <> 0 then
        MapWindowPoints(ParentWindow, Handle, RW, 2);

      GetThemedElementDetails(LDetails);
        bx := GetSystemMetrics(SM_CXBORDER);
      by := GetSystemMetrics(SM_CYBORDER);
      if (BorderStyle = bsNone) then
      begin
        InflateRect(RW, bx, by);
      end;
      if LMDApplication.ThemeUseColorProperty and not (LMDSIWindowsVistaUp and self.InheritsFrom(TCustomElComboBox) and (TElComboBox(self).Style = csDropDownList)) then //vb aug 2009
        begin
          AColor := GetBkColor;
          ABrush := CreateSolidBrush(ColorToRGB(AColor));
          R2 := RW;
          if Focused then
            AdjustFocusedRect(R2);
          FillRect(BMP.Canvas.Handle, R2, ABrush);
          DeleteObject(ABrush);
        end
      else
        LMDThemeServices.DrawElement(UseThemeMode, BMP.Canvas.Handle, LDetails, RW);
      if (BorderStyle = bsNone) then
      begin
        InflateRect(RW, -bx, -by);
      end;
    end;

    BMP.Canvas.Brush.Color := Color;
    BMP.Canvas.Font.Assign(Font);
    PaintText(BMP.Canvas);

    Canvas.CopyRect(Rect, BMP.Canvas, Rect);
    if not Focused then
      if (Text = '') and (FCueBanner <> '') then
        PaintCueBanner(Canvas);

    if (ScrollBars in [ssBoth]) and (FUseCustomScrollBars and Multiline) then
    begin
      // PAINT CROSS SCROLLBARS AREA:
      SetRect(Rect, scbVert.ScrollBarRect.Left,  scbHorz.ScrollBarRect.Top,
                    scbVert.ScrollBarRect.Right, scbHorz.ScrollBarRect.Bottom );
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := scbVert.Color;
      Canvas.FillRect(Rect);
    end;
  finally
    BMP.Free;
  end;

  PaintBackground();
end;

procedure TCustomElEdit.PaintCueBanner(Canvas: TCanvas);
var
  LSize: tagSIZE;
  LDetails: TThemedElementDetails;
  LOldColor: TColor;
  DrawRect: TRect;
  LAddVistaBorder: Integer;
begin
  LDetails.Element := teEdit;
  LDetails.Part := EP_EDITTEXT;
  LDetails.State := 8;
  if IsThemed and LMDSIWindowsVistaUp then
  begin
    LAddVistaBorder := 0;
    if not Multiline then
      LAddVistaBorder := GetSystemMetrics(smXEdge[Ctl3D]);

    DrawRect.Left := EditRect.Left + FLeftMargin + LAddVistaBorder;
    DrawRect.Top  := EditRect.Top + LAddVistaBorder;
    DrawRect.Right := EditRect.Right - FRightMargin;
    DrawRect.Bottom := EditRect.Bottom;
    LMDThemeServices.DrawThemeText(UseThemeMode, Canvas.Handle, LDetails, FCueBanner, Length(FCueBanner), 0, 0, DrawRect)
  end
  else
  begin
    LOldColor := Canvas.Font.Color;
    Canvas.Font.Color := DisabledFontColor;
    DrawTabbedText(Canvas, 1, 1, FCueBanner, LSize);
    Canvas.Font.Color := LOldColor;
  end;
end;

procedure TCustomElEdit.DrawTabbedText(const ACanvas: TCanvas; X, Y : integer; AText : TLMDString; var Size : TSize);
var
  DrawRect: TRect;
begin

  DrawRect.Left := EditRect.Left + FLeftMargin;
  DrawRect.Top  := EditRect.Top;
  DrawRect.Right := EditRect.Right - FRightMargin;
  DrawRect.Bottom := EditRect.Bottom;

  FTextPainter.DrawTabbedText(ACanvas, X, Y, DrawRect, ExpandTabbedString(StringToPassword(AText)), Size);
end;

procedure TCustomElEdit.PaintText(Canvas : TCanvas);
var
  FText : TLMDString;
  sx, sy: integer;
  TS : TSize;
  fl : integer;
//  ls, le : integer;
  LinesToDraw : integer;
  {$ifdef LMD_ELUNISCRIBE}
  i, j, sn, pn, gx: integer;
  LSelStart: Integer;
  LSelEnd: Integer;
  {$ENDIF}
begin
  if not HandleAllocated then
    exit;

  if FHasCaret then
    HideCaret(Handle);

  SetTextColor(Canvas.Handle, ColorToRGB(GetTextColor));
  SetBkColor(Canvas.Handle, ColorToRGB(GetBkColor));
  // paint only visible text lines
  if FTopLine < 0 then
   TopLine := 0;
  LinesToDraw := (FTopLine + FLinesInRect) - 1;
  if (FTopLine + FLinesInRect) > FElEditList.ParagraphCount - 1 then
    LinesToDraw := FElEditList.ParagraphCount - 1;

  {$ifdef LMD_ELUNISCRIBE}
  sn := 0;
  pn := 0;
  {$endif}
  for fl := FTopLine to LinesToDraw do
  begin
    FText := StringToPassword(FElEditList.ParagraphStrings[fl]);
    FCharsInView := CharsFitRight((EditRect.Right - FRightMargin) - (EditRect.Left + FLeftMargin), FText, FLeftChar);
    FText := Copy(FText, FLeftChar + 1, FCharsInView);

    TS := FTextPainter.TextSize(FText);
    case Alignment of
      taRightJustify: sx := (EditRect.Right - FRightMargin) - TS.cx - 2;
      taCenter:       sx := ((EditRect.Right - FRightMargin) div 2) - (TS.cx div 2);
    else
      sx := EditRect.Left + FLeftMargin;
    end;
    Canvas.Brush.Style := bsClear;

    {$ifdef LMD_ELUNISCRIBE}
    if ScriptIsComplex(PWideChar(FText), Length(FText), SIC_COMPLEX) = S_FALSE then
    begin
    {$endif}
      sy := (FLineHeight * ((fl - FTopLine) + 1)) + FTopMargin;
      SetTextAlign(Canvas.Handle, TA_BASELINE or TA_NOUPDATECP or TA_LEFT);
      DrawEditText(Canvas, fl, FText, TS, sx, sy);
    {$ifdef LMD_ELUNISCRIBE}
    end
    else
    begin
      sy := (FLineHeight * ((fl - FTopLine))) + FTopMargin;
      SetTextAlign(Canvas.Handle, TA_TOP or TA_NOUPDATECP or TA_LEFT);
      LSelStart := 0;
      LSelEnd := 0;
      if (SelLength > 0) then
      begin
        if (FSelStartY = fl) and (FSelLastY = fl) then
        begin
          LSelStart := FSelStartX;
          LSelEnd := LSelStart + SelLength;
        end
        else
        if (FSelStartY = fl) then
        begin
          LSelStart := FSelStartX;
          LSelEnd := LSelStart + SelLength;
        end
        else
        if (FSelLastY = fl) then
        begin
          LSelStart := 0;
          LSelEnd := FSelLastX;
        end
        else
        if (FSelStartY < fl) and (FSelLastY > fl) then
        begin
          LSelStart := 0;
          LSelEnd := Length(FText);
        end;
      end;
      FElEditList.IndexToParagraph(fl, i, j);
      if i <> pn then
      begin
        pn := i;
        sn := 0;
      end;
      FText := FElEditList.FParagraphs[i].Get(sn);
      gx := FElEditList.FParagraphs[i].GetStrSize(canvas,sn).cx;
      case Alignment of
        taRightJustify: sx := (EditRect.Right - FRightMargin) - gx - 2;
        taCenter:       sx := ((EditRect.Right - FRightMargin) div 2) - (gx div 2);
      end;
      FElEditList.FParagraphs[i].Draw(Canvas, sx, sy, LSelStart, LSelEnd, sn);
      sn := sn + 1;
      if i <> pn then
      begin
        pn := i;
        sn := 0;
      end;
    end;
    {$endif}

    Canvas.Font.Color := Self.GetTextColor;
    Canvas.Brush.Color := Self.GetBkColor;
  end;

  if FHasCaret then
    ShowCaret(Handle);
end;

procedure TCustomElEdit.Change;
{ Triggers the OnChange event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnChange)) then
    FOnChange(Self);
  //Validation support, November 2007, RS
  if Assigned(FValidator) then
    FValidator.Validate(Self);
end; { TriggerChangeEvent }

procedure TCustomElEdit.TriggerSelectionChangeEvent;
{ Triggers the OnSelectionChange event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnSelectionChange)) then
    FOnSelectionChange(Self);
end;

procedure TCustomElEdit.TriggerTripleClick;
begin
  CommandCenter(eecSelectAll, #0, nil);
end;

{ TriggerSelectionChangeEvent }

procedure TCustomElEdit.SetReadOnly(newValue : Boolean);
{ Sets data member FReadOnly to newValue. }
begin
  if (FReadOnly <> newValue) then
  begin
    FReadOnly := newValue;
    RepaintText(EditRect);
  end; { if }
end; { SetReadOnly }

procedure TCustomElEdit.SetAlignment(newValue : TAlignment);
{ Sets data member FAlignment to newValue. }
begin
  if (FAlignment <> newValue) then
  begin
    FAlignment := newValue;
    if not RightAlignedText then
      if FAlignment <> taLeftJustify then
        WordWrap := True;
    if HandleAllocated then
    begin
      Invalidate;
      if FHasCaret then
        SetCaretPosition(CaretX, CaretY);
    end;
  end; { if }
end; { SetAlignment }

procedure TCustomElEdit.SetLeftMargin(newValue : Integer);
{ Sets data member FLeftMargin to newValue. }
begin
  if (FLeftMargin <> newValue) then
  begin
    FLeftMargin := newValue;
    Invalidate;
    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
  end; { if }
end; { SetLeftMargin }

procedure TCustomElEdit.SetRightMargin(newValue : Integer);
{ Sets data member FRightMargin to newValue. }
begin
  if (FRightMargin <> newValue) then
  begin
    FRightMargin := newValue;
    Invalidate;
    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
  end; { if }
end; { SetRightMargin }

procedure TCustomElEdit.SetBorderStyle(newValue : TBorderStyle);
{ Sets data member FBorderStyle to newValue. }
begin
  if (FBorderStyle <> newValue) then
  begin
    FBorderStyle := newValue;
    if HandleAllocated then
      RecreateWnd;
  end; { if }
end; { SetBorderStyle }

procedure TCustomElEdit.SetHideSelection(newValue : Boolean);
{ Sets data member FHideSelection to newValue. }
begin
  if (FHideSelection <> newValue) then
  begin
    FHideSelection := newValue;
    if not Focused then
       Invalidate;
  end; { if }
end; { SetHideSelection }

function TCustomElEdit.CaretFromChar(const CharNum: integer): TPoint;
var
  i: integer;
  Len: integer;
begin
  Len := 0;
  Result.X := 0;
  Result.Y := 0;
  for i := 0 to FElEditList.Count - 1 do
  begin
    Len := Len + Length(FElEditList.Strings[i]) + 2;
    if Len >= CharNum then
    begin
      FElEditList.CaretFromParagraph(i, (CharNum - (Len - (Length(FElEditList.Strings[i]) + 2))),
        Result.X, Result.Y);
      break;
    end;
  end;
end;

function TCustomElEdit.CharFromCaret(const X, Y: integer): integer;
var
  i: integer;
  P, PO: integer;
begin
  Result := 0;
  FElEditList.CaretToParagraph(X, Y, P, PO);
  for i := 0 to P - 1 do
    inc(Result, Length(FElEditList.Strings[i]) + 2);
  inc(Result, PO);
end;

function TCustomElEdit.PosFromCaret(const X, Y: integer): TPoint;
var
  {$ifdef LMD_ELUNISCRIBE}
  i, j: integer;
  {$endif}
  fy, fx: integer;
  TS: TSize;
  FText1: TLMDString;
  FStr: TLMDString;
begin
  fy := ((FLineHeight * (Y - TopLine)) + FTopMargin + abs(FAscent - FLineHeight));
  Canvas.Font.Assign(Font);

  if (FElEditList.ParagraphCount >= Y) then
  begin
    FText1 := StringToPassword(FElEditList.ParagraphStrings[Y]);
    FStr := Copy(FText1, FLeftChar + 1, (X - FLeftChar));
    FStr := ExpandTabbedString(FStr);
    TS := FTextPainter.TextSize(FStr);
  end
  else
    EElEditorError.CreateFmt('Invalid Y position (%d)', [Y]);

  if X < FLeftChar then
    {$IFNDEF LMD_ELUNISCRIBE}
    fx := -2
    {$ENDIF}
  else
    {$ifdef LMD_ELUNISCRIBE}
    FElEditList.IndexToParagraph(Y, i, j);
    fx := FElEditList.FParagraphs[i].GetXFromOffset(Canvas, X - 1);
    {$else}
    fx := FTextPainter.TextSize(FStr).cx;
    {$endif}

  FText1 := ExpandTabbedString(FText1);

  if (Alignment = taCenter) and (FLeftChar = 0) then
    fX := fX + abs(((EditRect.Right - FRightMargin) div 2) - (FTextPainter.TextSize(FText1).cx div 2));

  if (Alignment = taRightJustify) and (FLeftChar = 0) then
    fX := fX + abs((EditRect.Right - FRightMargin) - FtextPainter.TextSize(FText1).cx) - 2;

  if (Alignment = taLeftJustify) or (FLeftChar > 0) then
    fx := fx + FEditRect.Left + FLeftMargin;

  if fx > (FEditRect.Right - FRightMargin) then
    fx := -2;

  if Y >= (TopLine + FLinesInRect) then
    fy := fy + FEditRect.Bottom;

  Result := Point(fx, fy);
end;

function TCustomElEdit.GetRightOffsetForBackground: Integer;
begin
  Result := 0;
end;

function TCustomElEdit.CharsFitLeft(AWidth : integer; FText: TLMDString;
    StartPos : integer): Integer;
begin
  Result := FTextPainter.CharsFitLeft(AWidth, StringToPassword(FText), StartPos);
end;

function TCustomElEdit.CharsFitRight(AWidth : integer; FText : TLMDString;
    StartPos : integer): Integer;
begin
  Result := FTextPainter.CharsFitRight(AWidth, StringToPassword(FText), StartPos);
end;

procedure TCustomElEdit.CaretFromPos(APos: TPoint; var ACaretX, ACaretY: integer);
var
  fl: integer;
  i, j: Integer;
  {$ifndef LMD_ELUNISCRIBE}
  p: PInteger;
  p1: PInteger;
  sp: PInteger;
  TS: TSize;
  sx, cv: integer;
  // used in multi-row mode
  le: integer;
  // used in tab expansion
  tc,
    tv : integer;
  FText, ST: TLMDString;
  {$endif}
begin
  fl := APos.y div FLineHeight;
  inc(fl, FTopLine);
  if fl < 0 then
    fl := 0;
  if fl > FElEditList.ParagraphCount - 1 then
    fl := FElEditList.ParagraphCount - 1;

  ACaretY := fl;

  {$ifdef LMD_ELUNISCRIBE}
  FElEditList.IndexToParagraph(fl, i, j);
  ACaretX := FElEditList.FParagraphs[i].GetOffsetFromX(Canvas, APos.X);
  {$else}
  ST := FElEditList.ParagraphStrings[fl];

  le := length(ST);

  FText := StringToPassword(Copy(ST, FLeftChar, (le - FLeftChar) + 1));

  if Length(FText) = 0 then
  begin
    ACaretX := FLeftChar;
    exit;
  end;

  TS := FTextPainter.TextSize(FTabString);

  tv := TS.cx;

  tc := 0;

  TS := FTextPainter.TextSize(FText);
  case Alignment of
    taRightJustify: sx := (EditRect.Right - FRightMargin) - TS.cx;
    taCenter: sx := (EditRect.Right - FRightMargin) div 2 - TS.cx div 2;
  else
    sx := EditRect.Left + FLeftMargin;
  end;
  // Inc(sx, FLeftMargin);

  j := Length(FText) - 1;

  GetMem(P, (j + 1) * sizeof (Integer));
  sp := p;
  // in the next line we can ignore margins
  FTextPainter.GetTextExtentExPoint(Canvas, PLMDChar(FText), Length(FText), FtextPainter.TextSize(FText).cx,
    i, p, TS);
  ACaretX := FLeftChar;

  if FText[1] = ElFTab then
  begin
    inc(tc, tv - p^);
    p^ := tv;
    end;
  cv := p^ div 2;
  if sx + cv >= APos.x then
  begin
    FreeMem(sp);
    exit;
  end;
  for i := 0 to j do
  begin
    if i > 0 then
    begin
      if FText[i + 1] = ElFTab then
      begin
        p1 := p;
        dec(p1);
        tc := tc + tv {- (p^ - p1^)}{width of TAB character};
        p^ := p^ + tv - (p^ - p1^){width of TAB character};
        cv := tv div 2;
      end
      else
      begin
        p^ := p^ + tc;
        cv := p^;
        dec(p);
        cv := (cv - p^) div 2;
        inc(p);
        end;
    end;
    if (sx + P^ - cv) > APos.x then
    begin
      ACaretX := (i + FLeftChar);
      FreeMem(sp);
      exit;
    end;
    inc(p);
    end;
  FreeMem(sp);
  ACaretX := Length(FText) + FLeftCHar;
  {$endif}
end;

function TCustomElEdit.GetLinesCount: Integer;
begin
  result := FElEditList.ParagraphCount;
end;

procedure TCustomElEdit.SelectAll;
var
  xCaretX: integer;
  xCaretY: integer;
begin

  xCaretY := FElEditList.ParagraphCount - 1;
  xCaretX := Length(FElEditList.ParagraphStrings[FElEditList.ParagraphCount - 1]);

  CaretY := xCaretY;
  CaretX := xCaretX;
  FSelStartX := 0;
  FSelStartY := 0;
  SetSelection(CaretX, CaretY);

//  TriggerSelectionChangeEvent;
  RepaintText(EditRect);
end;

procedure TCustomElEdit.SetTabSpaces(newValue : Integer);
var
  i: Integer;
begin
  if (FTabSpaces <> newValue) and (newValue > 0) then
  begin
    FTabSpaces := newValue;
    SetLength(FTabString, FTabSpaces);
    for i := 1 to FTabSpaces do
      FTabString[i] := ' ';
    SetCaretPosition(CaretX, CaretY);
    RepaintText(EditRect);
  end; {if}
end;

procedure TCustomElEdit.DoSetEditRect(newValue : TRect);
{ Sets data member FEditRect to newValue. }
begin
  FEditRect := newValue;
  if (FAlignBottom) then
    SetBottomAlign;
  FLinesInRect := (FEditRect.Bottom - FTopMargin) div FLineHeight;
  if (FLinesInRect < 1) and (FEditRect.Bottom - FTopMargin > 0) then
    FLinesInRect := 1;
  SetScrollBarsInfo;
end; { DoSetEditRect }

procedure TCustomElEdit.MakeCaret;
var
  TTM : TLMDTextMetric;
begin
  if HandleAllocated then
  begin
    Canvas.Font.Assign(Font);
    LMDGetTextMetrics(Canvas.Handle, TTM);
    FAscent := TTM.tmAscent;
    FDescent := TTM.tmDescent;
    if fsBold in Font.Style then
      FHasCaret := CreateCaret(Handle, 0, GetSystemMetrics(SM_CXBORDER) * 2, Abs(TTM.tmHeight))
    else
      FHasCaret := CreateCaret(Handle, 0, GetSystemMetrics(SM_CXBORDER), Abs(TTM.tmHeight));
    end;
end;

procedure TCustomElEdit.MoveCaret(CharNum : integer);
var
  FCharPos : TPoint;
begin
  if HandleAllocated then
    FCharPos := Point(FCaretX, FCaretY)
  else
    FCharPos := Point(0, EditRect.Top);

  if FHasCaret then
  begin
    HideCaret(Handle);
    SetCaretPos(FCharPos.X, FCharPos.Y - 1);
    if Transparent then
      RepaintText(EditRect);
    ShowCaret(Handle);
  end;
end;

procedure TCustomElEdit.SetCaretX(const value: integer);
var
  P1,
  P2,
  PI,
  Len,
  TC: integer;
begin
  if (Value <> FCaretX) or (Alignment <> taLeftJustify) or FForceSetCaretX then
  begin
    FCaretX := Value;
    Len := Length(FElEditList.ParagraphStrings[FCaretY]);
    if ((FCaretY < FElEditList.ParagraphCount - 1) and (FCaretX > Len) and (not FEnd)) then
    begin
      FElEditList.IndexToParagraph(CaretY, P1, PI);
      TC := CaretY;
      TC := TC + 1;
      FElEditList.IndexToParagraph(TC, P2, PI);
      if (P1 = P2) then
      begin
        if (FCaretX > Len) then
          FCaretX := 1
        else
          FCaretX := 0;
        CaretY := TC;
      end
      else
      begin
        if (FCaretX > Len) then
        begin
          FCaretX := 0;
          CaretY := TC;
        end;
      end;
    end;
    if ((FCaretY = FElEditList.ParagraphCount - 1) and (FCaretX > Len)) then
      FCaretX := Length(FElEditList.ParagraphStrings[FCaretY]);
    if (FCaretX < 0) and (FCaretY > 0) then
    begin
      FElEditList.IndexToParagraph(CaretY, P1, PI);
      CaretY := CaretY - 1;
      FElEditList.IndexToParagraph(CaretY, P2, PI);
      if FCaretY < FElEditList.ParagraphCount - 1 then
      begin
        if P1 = P2 then
          FCaretX := Length(FElEditList.ParagraphStrings[FCaretY]) - 1
        else
          FCaretX := Length(FElEditList.ParagraphStrings[FCaretY]);
      end
      else
        FCaretX := 0;
    end
    else
    if (FCaretY = 0) and (FCaretX < 0) then
      FCaretX := 0;
    CorrectLeftChar;
    SetCaretPosition(FCaretX, FCaretY);
  end;
end;

procedure TCustomElEdit.SetCaretY(const value: integer);
var
  Len: integer;
begin
  if (FCaretY <> value) then
  begin
    FCaretY := Value;
    if FCaretY > FElEditList.ParagraphCount - 1 then
      FCaretY := FElEditList.ParagraphCount - 1;
    if FCaretY < 0 then
      FCaretY := 0;
    if FCaretY < TopLine then
    begin
      TopLine := FCaretY;
      InvalidateRect(Handle, @FEditRect, HasCustomBackground);
      end;
    if FCaretY >= (TopLine + FLinesInRect) then
    begin
      TopLine := (FCaretY - FLInesInRect) + 1;
      InvalidateRect(Handle, @FEditRect, HasCustomBackground);
      end;

    Len := Length(FElEditList.ParagraphStrings[FCaretY]);

    if FCaretX > Len then
      FCaretX := Len;

    CorrectLeftChar;
    SetCaretPosition(FCaretX, FCaretY);
  end;
end;

function TCustomElEdit.GetCaretXY: TPoint;
begin
  Result := Point(CaretX, CaretY);
end;

procedure TCustomElEdit.SetCaretXY(const Value: TPoint);
begin
  CaretY := Value.Y;
  CaretX := Value.X;
end;

procedure TCustomElEdit.CorrectLeftChar;
var
  FText1: TLMDString;
  TS: TSize;
  i: integer;

begin
  if HandleAllocated then
  begin
    if FElEditList.ParagraphCount > 0 then
      FText1 := FElEditList.ParagraphStrings[CaretY]
    else
      FText1 := '';

    TS := FTextPainter.TextSize(FText1);
    if TS.CX > (EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin) then
      ForceLeftAlignment := true;

    if TS.CX <= (EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin) then
      ForceLeftAlignment := false;
  end;

  if (Alignment = taCenter) and not (ForceLeftAlignment) then
  begin
    // if text width is less than edit width, we center-align the text
    if TS.cx < (EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin) then
    begin
      FLeftChar := 0;
      SetScrollBarsInfo;
    end;
  end;
  if (Alignment = taLeftJustify) or ForceLeftAlignment then
  begin
    if (Alignment = taLeftJustify) then
      i := CharsFitRight((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin), FText1, FLeftChar)
    else
      i := CharsFitLeft((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin), FText1, Length(FText1));

    if ((FCaretX {+ FTabCor}) > FLeftChar + i) then
    begin
      if HandleAllocated then
      begin
        TS := FtextPainter.TextSize(Copy(FText1, FLeftChar + 1, FCaretX - FLeftChar));
        if TS.CX >= ((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin)) then
        begin
          if (Alignment = taLeftJustify) or FMultiline then
            i := CharsFitLeft(((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin)) div 4 * 3, FText1, FCaretX)
          else
            i := CharsFitLeft(((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin)), FText1, FCaretX);

          if (not FWordWrap) or (not Multiline) then
          begin
            FLeftChar := (FCaretX) - i;
            SetScrollBarsInfo;
          end;
          if FLeftChar < 0 then
          begin
            FLeftChar := 0;
            SetScrollBarsInfo;
          end;
          RepaintText(EditRect);
        end;
      end;
    end
    else
    if ((FCaretX <= FLeftChar) and (FLeftChar > 0)) then
    begin
      i := CharsFitLeft(((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin))
        div 4 * 3, FText1, FCaretX);
      if (not FWordWrap) or (not Multiline) then
        FLeftChar := FCaretX - i;
      if FLeftChar < 0 then
        FLeftChar := 0;
      SetScrollBarsInfo;
      if HandleAllocated then
        RepaintText(EditRect);
    end
    else
    if ((Alignment <> taLeftJustify) and (FLeftChar > 0)) then
    begin
      i := CharsFitLeft((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin), FText1, Length(FText1));
      FLeftChar := Length(FText1) - i;
    end;
  end
  else
  if Alignment = taRightJustify then
  begin
    if HandleAllocated then
    begin
      if TS.CX < ((EditRect.Right - FRightMargin) - (EditRect.Left + FLeftMargin)) then
      begin
        if FLeftChar <> 0 then
        begin
          FLeftChar := 0;
          SetScrollBarsInfo;
          RepaintText(EditRect);
        end;
      end
      else
      begin
        i := CharsFitRight((EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin), FText1, FLeftChar);
        if (FCaretX >= FLeftChar + i) then
        begin
          if HandleAllocated then
          begin
            {$ifdef LMD_UNICODE}
            TS := FtextPainter.TextSize(Copy(StringToPassword(FText1), FLeftChar + 1, (FCaretX - FLeftChar) + 1));
            {$else}
            TS := FtextPainter.TextSize(Copy(StringToPassword(FText1), FLeftChar + 1, FCaretX - FLeftChar));
            {$endif}
            if TS.CX >= (EditRect.Right - RightMargin) - (EditRect.Left + LeftMargin) then
            begin
              if (not FWordWrap) or (not Multiline) then
              begin
                FLeftChar := FCaretX - i;
                SetScrollBarsInfo;
              end;
              if FLeftChar < 0 then
              begin
                FLeftChar := 0;
                SetScrollBarsInfo;
              end;
              RepaintText(EditRect);
            end;
          end;
        end
        else
        if ((FCaretX <= FLeftChar) and (FLeftChar > 0))  then
        begin
          FLeftChar := FCaretX;
          SetScrollBarsInfo;
          if FLeftChar < 0 then
          begin
            FLeftChar := 0;
            SetScrollBarsInfo;
          end;
          if HandleAllocated then
            RepaintText(EditRect);
        end;
      end;
    end;
  end;
end;

procedure TCustomElEdit.SetCaretPosition(const X, Y: integer);
var
  FPos: TPoint;
begin

  FPos := PosFromCaret(X, Y);
  if FHasCaret then
  begin
    HideCaret(Handle);
    SetCaretPos(FPos.X, FPos.Y);
    if Transparent or IsThemed then
      RepaintText(EditRect);
    ShowCaret(Handle);
  end;
end;

procedure TCustomElEdit.SetMultiline(const Value: boolean);
begin
  if FMultiline <> Value then
  begin
    FMultiline := Value;
    if Value then
    begin
      AlignBottom := false;
    end;
    if not FMultiline then
     ScrollBars := ssNone;
    if HandleAllocated and (ComponentState * [csLoading, csReading] = []) then
    RecreateWnd
    else
      SetScrollBarsInfo;
    FUpdate := true;
    FElEditList.Text := Text;
    FUpdate := false;
    if HandleAllocated then
      SetEditRect(ClientRect);
  end;
end;

procedure TCustomElEdit.EMGetSel(var Message: TMessage);
var ss, se : integer;
begin
  ss := SelStart;

  if SelLength >= 0 then
    se := ss + SelLength
  else
  begin
    ss := SelStart + SelLength;
    se := SelStart;
  end;
  Message.result := se shr 16 or ss;
  if Message.lParam <> 0 then
    PDWord(Message.lParam)^ := se;
  if Message.wParam <> 0 then
    PDWord(Message.wParam)^ := ss;
  end;

procedure TCustomElEdit.EMGetLine(var Message: TMessage);
var
  S : TLMDString;
  S1: string;
  i : integer;
  begin
  if LMDInRange(Message.wParam, 0, Lines.Count - 1) and (FPasswordChar = #0) then
    S := Lines.Strings[Message.wParam]
  else
    S := '';

  if Message.lParam = 0 then
    Message.Result := 0
  else
  begin
  i := PWord(Pointer(Message.lParam))^;
    S1 := S;
    i := Min(Length(S1), i);
    if i > 0 then
      Move(PChar(S1)^, PChar(Pointer(Message.lParam))^, i);
    Message.Result := i;
  end;
  if not LMDInRange(Message.wParam, 0, Lines.Count - 1) then
    Message.result := 0;
end;

procedure TCustomElEdit.EMGetLineCount(var Message: TMessage);
begin
  Message.Result := Lines.Count;
end;

procedure TCustomElEdit.EMLineIndex(var Message: TMessage);
var
  P, PI: integer;
  fx, fy: integer;
begin
  if (Message.wParam = -1) then
  begin
    FElEditList.IndexToParagraph(CaretY, P, PI);
    FElEditList.CaretFromParagraph(P, 0, fx, fy);
    Message.Result := CharFromCaret(0, fy);
  end;
  if Message.wParam > FElEditList.Count - 1 then
    Message.Result := -1
  else
  begin
    FElEditList.IndexToParagraph(Message.wParam, P, PI);
    FElEditList.CaretFromParagraph(P, 0, fx, fy);
    Message.Result := CharFromCaret(0, Message.wParam);
  end;
end;

procedure TCustomElEdit.EMSetSel(var Message: TMessage);
begin
  if Message.WParam = -1 then
  begin
    UnSelect;
  end
  else
  if (Message.WParam = 0) and (Message.lParam = -1) then
    SelectAll
  else
  begin
    if Message.WParam < Message.lParam then
    begin
      SelStart := Message.lParam;
      SelLength := -(Message.lParam - Message.WParam);
      //if FSelLength = 0 then
      //  RepaintText(EditRect);
    end
    else
    begin
      SelStart := Message.wParam;
      SelLength := (Message.lParam - Message.WParam);
      //if FSelLength = 0 then
      //  RepaintText(EditRect);
    end;
  end;
end;

procedure TCustomElEdit.EMReplaceSel(var Message: TMessage);
var S : string;
begin
  if Message.lParam = 0 then
    exit;
  if Message.wParam <> 0 then
    DeleteSelection;
  S := StrPas(PChar(Pointer(Message.lParam)));
  SetSelText(S);
end;

procedure TCustomElEdit.EMGetFirstVisibleLine(var Message: TMessage);
begin
  Message.Result := Self.TopLine
end;

procedure TCustomElEdit.EMScroll(var Message: TMessage);
begin
  Scroll(TElEditScrollDir(Message.wParam));
  end;

procedure TCustomElEdit.EMLineScroll(var Message: TMessage);
begin
  TopLine := TopLine + Message.lParam;
end;

procedure TCustomElEdit.EMScrollCaret(var Message: TMessage);
begin
  ScrollCaret;
end;

procedure TCustomElEdit.EMLineFromChar(var Message: TMessage);
var
  P, PI : integer;
begin
  FElEditList.IndexToParagraph(CaretFromChar(Message.wParam).Y, P, PI);
  Message.Result := P;
end;

procedure TCustomElEdit.EMPosFromChar(var Message: TMessage);
var
  P : TPoint;
begin
  P := CaretFromChar(Message.wParam);
  P := PosFromCaret(P.X, P.Y);
  Message.Result := P.Y shl 16 or P.X;
end;

function TCustomElEdit.StringToPassword(AString : TLMDString) : TLMDString;
var
  j : integer;
begin
  if FPasswordChar = #0 then
  begin
    Result := AString;
    exit;
  end;
  j := Length(AString);
  SetLength(Result, j);
  while j > 0 do
  begin
    if (AString[j] = ElFCR) or (AString[j] = ElFLF) then
      Result[j] := AString[j]
    else
      Result[j] := FPasswordChar;
    dec(j);
  end;
end;

function TCustomElEdit.ExpandTabbedString(Text : TLMDString) : TLMDString;
var
  i : integer;
  {$IFDEF LMD_UNICODE}
  S : WideString;
  {$ENDIF}
begin
  while {$IFDEF LMD_UNICODE}LMDWidePos(ElFTab, Text){$ELSE}Pos(#9, Text){$ENDIF} > 0 do
  begin
    {$IFDEF LMD_UNICODE}
    S := Text;
    i := LMDWidePos(ElFTab, S);
    LMDWideDelete(S, i, 1);
    LMDWideInsert(FTabString, S, i);
    Text := S;
    {$ELSE}
    i := Pos(#9, Text);
    Delete(Text, i, 1);
    Insert(FTabString, Text, i);
    {$ENDIF}
  end;
  result := Text;
end;

procedure TCustomElEdit.RepaintText(Rect : TRect);
var
  R : TRect;
begin
  if HandleAllocated then
  begin
    // if HasCustomBackground then
    if Transparent then
    begin
      R := EditRect;
      MapWindowPoints(Handle, Parent.Handle, R, 2);
      InvalidateRect(Parent.Handle, @R, true);
      Parent.Update;
    end;
    InvalidateRect(Handle, @Rect, HasCustomBackground);
  end;
end;

procedure TCustomElEdit.CutToClipboard;
begin
  if FPasswordChar <> #0 then
    exit;
  CopyToClipboard;
  if not ReadOnly then
  begin
    DeleteSelection;
    DoChange;
//    if not NotifyUserChangeOnly then
      Change;
    TriggerSelectionChangeEvent;
  end;
end; {CutToClipboard}

procedure TCustomElEdit.CopyToClipboard;
begin
  if FPasswordChar <> #0 then
    exit;
  if FSelected then
    LMDCopyTextToClipboard(GetSelectedText, true);
end; {CopyToClipboard}

type
  TChars = array of Char;

procedure TCustomElEdit.PasteFromClipboard;
var
  Piece: TLMDString;
  GLen, PLen, SLen: integer;
begin
  if FReadOnly then
    exit;

  Piece := LMDGetTextFromClipBoard;

  PLen := Length(Piece);
  GLen := Length(Text);
  if PLen = 0 then
    exit;
  if FSelected then
    SLen := SelLength
  else
    SLen := 0;

  if ((PLen + GLen - SLen) > FMaxLength) and (FMaxLength > 0) then
    Piece := Copy(Piece, 1, (FMaxLength - GLen + SLen));

  if CharCase <> eecNormal then
  begin
    {$IFNDEF LMD_UNICODE}
    if CharCase = eecUppercase then
      Piece := Uppercase(Piece)
    else
      Piece := Lowercase(Piece);
    {$ELSE}
    if CharCase = eecUppercase then
      Piece := LMDWideUppercase(Piece)
    else
      Piece := LMDWideLowercase(Piece);
    if (LMDSIWindowsNTUp) then
      if CharCase = eecUppercase then
        Piece := LMDWideUppercase(Piece)
      else
        Piece := LMDWideLowercase(Piece);
    {$ENDIF}
  end;

  if FSelected then
    DeleteSelection;

  if Assigned(FOnPasteClipboardText) then
    FOnPasteClipboardText(Self, Piece);

  InsertText(Piece);

  if Assigned(FOnAfterPasteClipboardText) then
    FOnAfterPasteClipboardText(Self);
  Change;
end; {PasteFromClipboard}

procedure TCustomElEdit.Undo;
var
  FX, FY: integer;
  AFAction: TElAction;
  FGroup: boolean;
begin
  FGroup := false;
  repeat
  if FUndo.CanUndo then
  begin
    AFAction := FUndo.PopItem;
    with AFAction do
      case FAction of
      atDeleteSel, atDelete, atBackSpace:
        begin
          FRedo.PushItem(AFAction);
          FX := FEndPos.X;
          FY := FEndPos.Y;
          FElEditList.InsertText(FX, FY, FStr);
          CaretXY := FStartPos;
          FSelStartX := CaretX;
          FSelStartY := CaretY;
          if FAction = atDeleteSel then
            if (FStartPos.Y > FY) or ((FStartPos.Y = FY) and (FStartPos.X >= FX)) then
              SetSelection(FEndPos.X, FEndPos.Y)
            else
              SetSelection(FX, FY)
        end;
      atInsert:
        begin
          FRedo.PushItem(AFAction);
          CaretXY := FStartPos;
          FSelStartX := FStartPos.X;
          FSelStartY := FStartPos.Y;
          SetSelection(FEndPos.X, FEndPos.Y);
          FUndo.Lock;
          DeleteSelection;
          FUndo.UnLock;
        end;
        atLineBreak:
          FRedo.PushItem(AFAction);
        atGroupBreak:
          begin
          FGroup := not FGroup;
          AFAction.Free; // <- New
          end;
        end;
      RepaintText(FEditRect);
    end;
  until not FGroup;
  Modified := FUndo.CanUndo;
  DoChange;
  if not NotifyUserChangeOnly then
    Change;
end; {Undo}

procedure TCustomElEdit.ClearUndo;
begin
  FUndo.Clear;
end;

procedure TCustomElEdit.SetModified(newValue : Boolean);
{ Sets data member FModified to newValue. }
begin
//  if newValue then
//    inc(FModifyCount)
//  else
//    dec(FModifyCount);
  FModified := newValue;
end; { SetModified }

procedure TCustomElEdit.CreateParams(var Params : TCreateParams); { protected }
const
  BorderStyles : array[TBorderStyle] of Cardinal = (0, WS_BORDER);
  MultilineStyles: array[boolean] of Cardinal = (0, ES_MULTILINE);
  ScrollBar : array[TScrollStyle] of DWORD = (0, WS_HSCROLL, WS_VSCROLL,
    WS_VSCROLL or WS_HSCROLL);
  LeftSB: array[Boolean] of DWORD = (0, WS_EX_LEFTSCROLLBAR);
  RightText: array[Boolean] of DWORD = (0, WS_EX_RTLREADING or WS_EX_RIGHT);

begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle] or MultilineStyles[FMultiline];
    if  Multiline then
      Style := Style or ScrollBar[FScrollBars];

    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;

    if NewStyleControls then
      ExStyle := ExStyle or LeftSB[RightAlignedView] or RightText[RightAlignedText]
    else
    if UseCustomScrollBars then
      ExStyle := ExStyle or LeftSB[RightAlignedView];

    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
    if Transparent then
      ExStyle := ExStyle or WS_EX_TRANSPARENT;
  end;

  if (BorderStyle = bsSingle) and Flat and (not IsThemed) then
  begin
    Params.Style := Params.Style and (not WS_BORDER);
    Params.ExStyle := Params.ExStyle and (not WS_EX_CLIENTEDGE);
  end;
end; { CreateParams }

procedure TCustomElEdit.WMSetFocus(var Msg : TWMSetFocus); { private }

begin
  inherited;
  if CanFocus or (GetParentForm(Self) = nil) then
  begin
    MakeCaret;
    if FHasCaret then
    begin
      SetCaretPosition(CaretX, CaretY);
      ShowCaret(Handle);
    end;
    if AutoSelect then
    begin
      SelectAll;
      LeftChar := 0;
      TopLine := 0;
    end;
//    if FHideSelection then
      RepaintText(EditRect);
  end;
  FAlienFocus := false;

  if (FTransparent or LMDSIWindowsVistaUp) and HandleAllocated then
    PaintBackground;
//    SendMessage(Handle, WM_NCPAINT, 0, 0);
    // SendMessage(Handle, WM_PAINT, 0, 0);

  if Flat and (not IsThemed) then
    DrawFlatBorder;
end; { WMSetFocus }

procedure TCustomElEdit.WMKillFocus(var Msg : TWMKillFocus); { private }

begin
  if FHasCaret then
  begin
    DestroyCaret;
    FHasCaret := false;
    //if Transparent then RepaintText(EditRect);
  end;
  if Msg.FocusedWnd = 0 then
    FAlienFocus := true;
  inherited;
  if not HandleAllocated then
    exit;
//  if FHideSelection then
    RepaintText(EditRect);
  if Flat and (not IsThemed) then
    DrawFlatBorder;
  if FDragging then
    EndDrag(False);

  if LMDSIWindowsVistaUp and HandleAllocated then
    PaintBackground;
    //SendMessage(Handle, WM_NCPAINT, 0, 0);

    //SendMessage(Handle, WM_PAINT, 0, 0);
end; { WMKillFocus }

procedure TCustomElEdit.WMEnable(var Msg : TWMEnable); { private }
begin
  inherited;
//  if Msg.WParam = 0 then
  if not Msg.Enabled then
  begin
    if FHasCaret then
    begin
      DestroyCaret;
      FHasCaret := false;
    end
  end
  else
  begin
    if Focused then
    begin
      MakeCaret;
    end;
  end;
end; { WMEnable }

procedure TCustomElEdit.WMSize(var Msg : TWMSize); { private }
var
  ACaretX, ACaretY, P, PO: integer;
  OldRect : TRect;
  OldLines, OldTop: integer;
begin
  OldRect := EditRect;
  OldLines := Self.FLinesInRect;
  OldTop := FTopLine;
  inherited;
  if HandleAllocated then
  begin
    if ((not FMultiline) and AutoSize) and
      (ComponentState * [csLoading, csReading, csDestroying] = []) then
      AdjustHeight;
    SetEditRect(ClientRect);
    FElEditList.CaretToParagraph(CaretX, CaretY, P, PO);
    FElEditList.Reformat;
    FElEditList.ReCount(0);
    FElEditList.CaretFromParagraph(P, PO, ACaretX, ACaretY);
    CaretY := ACaretY;
    CaretX := ACaretX;
    FSelStartX := CaretX;
    FSelStartY := CaretY;
    if Multiline and ((OldTop + FLinesInRect) > FElEditList.ParagraphCount) then
      TopLine := TopLine - 1;
    if (Multiline and WordWrap) or (Alignment <> taLeftJustify) then
      RepaintText(EditRect)
    else
    if //((OldRect.Bottom - OldRect.Top) < (EditRect.Bottom - EditRect.Top)) or
       (Multiline and (FLinesInRect > OldLines)) or
       ((OldRect.Right - OldRect.Left) < (EditRect.Right - EditRect.Left)) then
    begin
      RepaintText(EditRect);
    end;
  end;

  if IsThemed or (Flat and (BorderStyle <> bsNone)) then
    DrawFlatBorder;

  end; { WMSize }

function TCustomElEdit.IsCursorUnderSelection(AX, AY: Integer): Boolean;
begin
  Result := False;

  if FSelected then
  begin
    if ((AY > FSelFirstY) and (AY < FSelLastY)) then
    begin
      Result := True;
      exit;
    end;

    if ((AY = FSelFirstY) and (AY = FSelLastY)) then
    begin
      if (AX >= FSelFirstX) and (AX <= FSelLastX) then
        Result := True;
      exit;
    end;

    if (AY = FSelFirstY) and (AX >= FSelFirstX) then
      Result := True;

    if (AY = FSelLastY) and (AX <= FSelLastX) then
      Result := True;
  end;
end;

procedure TCustomElEdit.DragCanceled;
var
  FX, FY: Integer;
begin
  inherited;
  EndDrag(False);
  CaretFromPos(Point(FMouseDownPos.X, FMouseDownPos.Y), FX, FY);
  CaretY := FY;
  CaretX := FX;
end;

procedure TCustomElEdit.DragDrop(Source: TObject; X, Y: Integer);
var
  LDragCopy: Boolean;
  LDragedText: TLMDString;
  LPoint: TPoint;
  LSelLen: Integer;
begin
  if (Source is TCustomElEdit) and not ReadOnly then
  begin
    LDragCopy := ((GetKeyState(VK_CONTROL) and $8000) = $8000) or (Self <> Source);
    LDragedText := TCustomElEdit(Source).SelText;
    LSelLen := TCustomElEdit(Source).SelLength;

    if IsCursorUnderSelection(CaretX, CaretY) then
      UnSelect;

    if ((Self = Source) and (not IsCursorUnderSelection(CaretX, CaretY))) or (Self <> Source) then
    begin
      FUndo.AddAction(atGroupBreak, Point(0, 0), Point(0, 0), '');

      if not LDragCopy then
      begin
        LPoint := CaretXY;
        CommandCenter(eecSelectDelete, #0, nil);
        CaretXY := LPoint;
      end;
      InsertText(LDragedText);
      CaretXY := LPoint;

      FSelStartX := LPoint.X;
      FSelStartY := LPoint.Y;
      SelLength := LSelLen;

      FUndo.AddAction(atGroupBreak, Point(0, 0), Point(0, 0), '')
    end;
  end
  else
    inherited;
end;

procedure TCustomElEdit.DrawEditText(Canvas: TCanvas; fl: Integer; FText: TLMDString; ATS: tagSIZE; sx: Integer; sy: Integer);
var
  Delta: Integer;
  FText1: TLMDString;
  FText2: TLMDString;
  FText3: TLMDString;
  AR: TRect;
  TS: tagSIZE;
begin
  TS := ATS;
  if (HideSelection and not Focused) or ((FSelFirstX = FSelLastX) and
     (FSelFirstY = FSelLastY)) or ((fl < FSelFirstY) or (fl > FSelLastY)) then
    DrawTabbedText(Canvas, SX, SY + EditRect.Top, FText, TS)
  else
  begin
    if fl = FSelFirstY then
    begin
      Delta := FSelFirstX - FLeftChar;

      if Delta < 0 then
        FText1 := ''
      else
        FText1 := Copy(FText, 1, Delta);

      if FSelFirstY = FSelLastY then
      begin
        if Delta < 0 then
        begin
          FText2 := Copy(FText, 1, (FSelLastX - FLeftChar));
          FText3 := Copy(FText, (FSelLastX - FLeftChar) + 1, Length(FText));
        end
        else
        begin
          FText2 := Copy(FText, Delta + 1, (FSelLastX - FSelFirstX));
          FText3 := Copy(FText, Delta + (FSelLastX - FSelFirstX) + 1, Length(FText));
        end;
      end
      else
      begin
        FText2 := Copy(FText, Delta + 1, Length(FText));
        FText3 := '';
      end;
    end
    else
    begin
      Delta := FSelLastX - FLeftChar;
      if fl = FSelLastY then
      begin
        if Delta < 0 then
        begin
          FText1 := '';
          FText2 := '';
          FText3 := Copy(FText, 1, Length(FText));
        end
        else
        begin
          FText1 := '';
          FText2 := Copy(FText, 1, Delta);
          FText3 := Copy(FText, Delta + 1, Length(FText));
        end;
      end
      else
      begin
        FText1 := '';
        FText2 := FText;
        FText3 := '';
      end;
    end;
    SetTextAlign(Canvas.Handle, TA_BASELINE or TA_NOUPDATECP or TA_LEFT);
    if Length(FText1) > 0 then
    begin
      Canvas.Brush.Style := bsClear;
      DrawTabbedText(Canvas, SX, SY + FEditRect.Top, FText1, TS);
      inc(sx, TS.cx);
    end;
    if Length(FText2) > 0 then
    begin
      if HighlightAlphaLevel = 255 then
      begin
        Canvas.Brush.Style := bsSolid;
      end;
      if Focused then
      begin
        Canvas.Brush.Color := FocusedSelectColor;
        Canvas.Font.Color := FocusedSelectTextColor;
      end
      else
      begin
        Canvas.Brush.Color := HideSelectColor;
        Canvas.Font.Color := HideSelectTextColor;
      end;
      DrawTabbedText(Canvas, SX, SY + FEditRect.Top, FText2, TS);
      inc(sx, TS.cx);
      if HighlightAlphaLevel < 255 then
      begin
        AR := Rect(SX - TS.cx, SY + FEditRect.Top - TS.cy, SX, SY + FEditRect.Top);
        LMDAlphaFillRect(Canvas, AR, Windows.GetBkColor(Canvas.Handle), HighlightAlphaLevel);
        Canvas.Brush.Style := bsSolid;
      end;
    end;
    Canvas.Font.Color := Self.GetTextColor;
    Canvas.Brush.Color := Self.GetBkColor;
    if Length(FText3) > 0 then
    begin
      Canvas.Brush.Style := bsClear;
      DrawTabbedText(Canvas, SX, SY + FEditRect.Top, FText3, TS);
    end;
  end;
end;

procedure TCustomElEdit.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  FX, FY: Integer;
begin
  inherited;
  if (Source is TCustomElEdit) and not ReadOnly then
  begin
    Accept := True;

    if GetKeyState(VK_CONTROL) and $8000 = $8000 then
      DragCursor := crMultiDrag
    else
      DragCursor := crDrag;

    CaretFromPos(Point(X, Y), FX, FY);
    CaretY := FY;
    CaretX := FX;
  end;
end;

//???
procedure TCustomElEdit.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }
var
  fx, fy: integer;
  FBeg, FEnd: TPoint;
  b : boolean;
begin
  b := false;
  FMouseDownPos := Point(X, Y);
  if (Enabled) and (CanFocus) and (not (csDesigning in ComponentState)) and
    (GetFocus <> Handle) then
  begin
    if Multiline and (Scrollbars <> ssNone) then
    begin
      if
      PtInRect(Self.scbVert.ScrollBarRect, Point(X, Y)) or
         PtInRect(Self.scbHorz.ScrollBarRect, Point(X, Y))
      then
        exit;
      end;

    FMouseClick := true;
    CaretFromPos(Point(X, Y), FX, FY);
    CaretY := FY;
    CaretX := FX;
    if (FSelStartX <> FX) or (FSelStartY <> FY) then
    begin
      FSelStartX := FX;
      FSelStartY := FY;
      TriggerSelectionChangeEvent;
    end;
//    SetFocus;
    FMouseClick := false;
    if AutoSelect then
      SelectAll;
    b := true;
  end;
  if ssDouble in Shift then
  begin
    CaretFromPos(Point(X, Y), FX, FY);
    CaretY := FY;
    CaretX := FX;
    FBeg := GetPrevWord(CaretXY);
    FEnd := GetNextWord(CaretXY);
    FSelStartX := FBeg.X;
    FSelStartY := FBeg.Y;
    SetSelection(FEnd.X, FEnd.Y);
    CaretXY := FEnd;
    RepaintText(FEditRect);
  end
  else
  if (mbLeft = Button) {and (not FWaitForDragging) }then
  begin
    CaretFromPos(Point(X, Y), FX, FY);
    CaretY := FY;
    CaretX := FX;
    if IsCursorUnderSelection(FX, FY) and (not Dragging) and (FDragAllowed) and (not FWaitForDragging) then
      FWaitForDragging := True
    else
    begin
      if (not (ssShift in Shift)) and (not b) then
      begin
        UnSelect;
        if (FSelStartX <> FX) or (FSelStartY <> FY) then
        begin
          FSelStartX := FX;
          FSelStartY := FY;
          TriggerSelectionChangeEvent;
        end;
      end
      else
        if (not b) then
          SetSelection(CaretX, CaretY);
      RepaintText(EditRect);
      FSelecting := true;
    end;
  end;

  if (Enabled) and (CanFocus) and (not (csDesigning in ComponentState)) and
  (GetFocus <> Handle)
  then
  begin
    if (GetParentForm(Self) <> nil) and (GetParentForm(self).ActiveControl = Self) then
      GetParentForm(self).ActiveControl := nil;
    SetFocus;
  end;
  SetCapture(Handle);
  inherited;
end; { MouseDown }

procedure TCustomElEdit.MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }

begin
  ReleaseCapture;
  if not FSelecting then
  begin
    end
  else
  begin
    FSelecting := false;
//    CaretFromPos(Point(X, Y), FX, FY);
//    if (not (ssShift in Shift)) then
//    begin
//      UnSelect;
//      FSelStartX := FX;
//      FSelStartY := FY;
//    end;
//    TriggerSelectionChangeEvent;
//    RepaintText(EditRect);
  end;
  inherited;
end; { MouseUp }

procedure TCustomElEdit.MouseMove(Shift : TShiftState; X, Y : Integer); { protected }
var
  FX, FY: integer;
begin
  if (FWaitForDragging) then
  begin
    if (ssLeft in Shift) and
       ((abs(FMouseDownPos.X - X) >= GetSystemMetrics(SM_CXDRAG)) and
        (abs(FMouseDownPos.Y - Y) >= GetSystemMetrics(SM_CYDRAG))) then
    begin
      FWaitForDragging := False;
      BeginDrag(False);
    end
    else
      exit;
  end;
  if (Dragging) then
  begin
    CaretFromPos(Point(X, Y), FX, FY);
    CaretY := FY;
    CaretX := FX;
  end
  else
  if {(FSelected) and }(ssLeft in Shift) then
  begin
    FSelected := true;
    CaretFromPos(Point(X, Y), FX, FY);
    SetSelection(FX, FY);
    CaretY := FY;
    CaretX := FX;
//    TriggerSelectionChangeEvent;
    RepaintText(FEditRect);
  end;
  inherited;
end; {MouseMove}

procedure TCustomElEdit.KeyPress(var Key : Char); { protected }
var
  SKey : Char;
begin
  SKey := Key;
  inherited KeyPress(SKey);

  if ((Integer(Key) = 127) or (Integer(Key) = VK_BACK) or
      (Integer(Key) = VK_RETURN) or  (Integer(Key) = VK_ESCAPE) or
      (Integer(Key) = VK_TAB)) or
     (Key = #0) or
     (FSelecting) then
    exit;

  if FReadOnly or (SKey = #0) or (SKey < #32) then
  begin
    {$IFDEF LMD_UNICODE}
    FKeys := '';
    {$ENDIF}
    exit;
  end;

  if ((Length(Text) >= FMaxLength) and (FMaxLength > 0)) and (not FSelected) then
  begin
    {$IFDEF LMD_UNICODE}
    FKeys := '';
    {$ENDIF}
    exit;
  end;

  {$IFDEF LMD_UNICODE}
  if not FKeyDown then
    if Key >= #128 then
    begin
      FKeys := LMDKeyToUnicode(Key);
    end
    else
      FKeys := Key;
  {$ENDIF}

  {$IFDEF LMD_UNICODE}
  CommandCenter(eecChar, SKey, @FKeys);
  FKeyDown := false;
  {$ELSE}
  CommandCenter(eecChar, SKey, nil);
  {$ENDIF}
end;

procedure TCustomElEdit.SetText(newValue: TLMDString);
begin
  if (ComponentState * [csLoading, csReading, csDestroying] <> []) then
  begin
    FElEditList.Text := newValue;
    exit;
  end;
  if (FElEditList.Text <> newValue) then
  begin
    {$IFNDEF LMD_UNICODE}
    if FCharCase = eecUppercase then
      NewValue := Uppercase(NewValue)
    else
    if FCharCase = eecLowercase then
      NewValue := Lowercase(NewValue);
    {$ELSE}
    if FCharCase = eecUppercase then
      NewValue := LMDWideUppercase(NewValue)
    else
    if FCharCase = eecLowercase then
      NewValue := LMDWideLowercase(NewValue);
    {$ENDIF}
    if FElEditList.ParagraphCount > 0 then
    begin
      if not FUserChangesOnly then
      begin
        FUndo.AddAction(atGroupBreak, Point(0, 0), Point(0, 0), '');
        FUndo.AddAction(atDelete, Point(0, 0), Point(FElEditList.ParagraphCount - 1,
                    Length(FElEditList.ParagraphStrings[FElEditList.ParagraphCount - 1])),
                    Text);

        FUndo.AddAction(atInsert, Point(0, 0), Point(Length(newValue), 0), newValue);
        FUndo.AddAction(atGroupBreak, Point(0, 0), Point(0, 0), '');
      end
      else
      begin
        FUndo.Clear;
        FRedo.Clear;
      end;
    end;

    if HandleAllocated then
      SendMessage(Handle, WM_SETTEXT,
      {$IFDEF LMD_UNICODE}
      1, TLMDPtrInt(PWideChar(newValue)))
      {$ELSE}
      0, TLMDPtrInt(PChar(newValue)))
      {$ENDIF}
      else
    begin
      //if not NotifyUserChangeOnly then
      //  Change;
      FElEditList.Text := newValue;
      DoChange;
      if not NotifyUserChangeOnly then
        Change;
    end;
    SetScrollBarsInfo;
  end; { if }
end; { SetText }

function TCustomElEdit.GetNextWord(ACaret: TPoint) : TPoint;
var
  P: {$IFDEF LMD_UNICODE}PWideChar{$ELSE}PChar{$ENDIF};
  j : integer;
  CharNum: integer;
  wasbl : boolean;
  PA, PI: integer;
begin
  FElEditList.CaretToParagraph(ACaret.X, ACaret.Y, PA, PI);
  CharNum := PI;
  {$IFDEF LMD_UNICODE}
  P := PWideChar(FElEditList.Strings[PA]);
  {$ELSE}
  P := PChar(FElEditList.Strings[PA]);
  {$ENDIF}
  inc(P, CharNum);
  wasbl := (p^ in [ElFTab, ElFSpace]);
  if p^ in [ElFCR, ElFLF] then
  begin
    Result := Point(CharNum + 1, PI);
    exit;
  end;
  j := 0;
  while (p^ <> #13) and (p^ <> #10) do
  begin
    if P^ = #0 then
  begin
      if ACaret.Y < FElEditList.ParagraphCount - 1 then
        Result := Point(0, ACaret.Y + 1)
      else
        Result := Point(CharNum, ACaret.Y);
      exit;
    end;
    if ((P + 1)^ = #0) then
    begin
      FElEditList.CaretFromParagraph(PA, Length(FElEditList.Strings[PA]), ACaret.X, ACaret.Y);
      Result := ACaret;
      exit;
    end;
    if wasbl xor (p^ in [ElFTab, ElFSpace]) then
    begin
      while (p^ in [ElFTab, ElFSpace]) do
    begin
        inc(j);
        inc(p);
        end;
      FElEditList.CaretFromParagraph(PA, CharNum + j, ACaret.X, ACaret.Y);
      Result := ACaret;
      exit;
    end;
    inc(j);
    inc(p);
    end;
  Result := Point(CharNum + j, ACaret.Y);
end;

function TCustomElEdit.GetPrevWord(ACaret: TPoint): TPoint;
var
  p : {$IFDEF LMD_UNICODE}PWideChar{$ELSE}PChar{$ENDIF};
  i, j: integer;
  CharNum: integer;
  wasbl : boolean;
  PA, PI: integer;
begin
  FElEditList.CaretToParagraph(ACaret.X, ACaret.Y, PA, PI);
  CharNum := PI;
  {$IFDEF LMD_UNICODE}
  P := PWideChar(FElEditList.Strings[PA]);
  {$ELSE}
  P := PChar(FElEditList.Strings[PA]);
  {$ENDIF}
  inc(P, CharNum);
  wasbl := (p^ in [ElFTab, ElFSpace]);
  if p^ in [ElFCR, ElFLF] then
  begin
    result := Point(CharNum, ACaret.Y);
    exit;
  end;
  i := CharNum;
  j := 0;
  while (p^ <> ElFCR) and (p^ <> ElFLF) do
  begin
    if i < 0 then
    begin
      if PA > 0 then
        FElEditList.CaretFromParagraph(PA - 1, Length(FElEditList.Strings[PA - 1]),
          ACaret.X, ACaret.Y)
      else
        ACaret := Point(0, 0);

      Result := ACaret;
      exit;
    end;
    if wasbl xor (p^ in [ElFTab, ElFSpace]) then
    begin
      while (not (p^ in [ElFTab, ElFSpace])) do
    begin
        dec(i);
        inc(j);
        dec(p);
        if ((i < 0) or (p^ = ElFCR) or (p^ = ElFLF)) then
        break;
      end;
      FElEditList.CaretFromParagraph(PA, CharNum - j + 1, ACaret.X, ACaret.Y);
      Result := ACaret;
      exit;
    end;
    dec(i);
    inc(j);
    dec(p);
    if i = 0 then
    begin
      FElEditList.CaretFromParagraph(PA, 0, ACaret.X, ACaret.Y);
      Result := ACaret;
      exit;
    end;
  end;
  Result := Point(CharNum - j + 1, ACaret.Y);
end;

procedure TCustomElEdit.CommandCenter(ACommand: TElCommand; AChar: Char; AData: Pointer);
begin
  TriggerBeforeCommand(AData, AChar, ACommand);
  ExecuteCommand(ACommand, AChar, AData);
  TriggerAfterCommand(AData, AChar, ACommand);
end;

procedure TCustomElEdit.ExecuteCommand(ACommand: TElCommand; AChar: Char; AData: Pointer);
var
  {$IFDEF LMD_UNICODE}
  S: WideString;
  {$ELSE}
  S: String;
  {$ENDIF}
  FStr: TLMDString;
  FTStr: TLMDString;
  FPos: TPoint;
  P, Pi: Integer;
  FX, FY: Integer;

  {$ifdef LMD_UNICODE}
  LKeys: WideString;
  {$else}
  Key: Char;
  {$endif}

  ANewStr: TLMDString;
  FCarY, FCarX, PO: integer;
  {$IFDEF LMD_UNICODE}
  S1 : WideString;
  S2 : WideString;
  {$ELSE}
  S1 : string;
  S2 : string;
  {$ENDIF}

  function CheckMaxLength: boolean;
  begin
    Result := Boolean(((Length(Text) < FMaxLength) and (FMaxLength > 0)) or (FMaxLength = 0));
  end;

  procedure AcceptText;
  begin
    if CheckMaxLength() then
    begin
      Modified := true;
      InvalidateRect(Handle, @FEditRect, HasCustomBackground);
      DoChange;
      Change;
      TriggerSelectionChangeEvent;
      //SetScrollBarsInfo;
    end
    else
      InvalidateRect(Handle, @FEditRect, HasCustomBackground);
  end;

  procedure DoBackPress;
  begin
    if not ReadOnly then
    begin
      if FSelected then
        DeleteSelection
      else
      begin
        FElEditList.CaretToParagraph(CaretX, CaretY, P, PI);
        FPos := CaretXY;
        if CaretX = 0 then
        begin
          if (PI = 0) and (P > 0) then
          begin
            S := FElEditList.FParagraphs.Items[P].Text;
            CaretY := CaretY - 1;
            CaretX := Length(FElEditList.FParagraphs.Items[P - 1].Strings[FElEditList.FParagraphs.Items[P - 1].Count - 1]);
            FUndo.AddAction(atBackSpace, FPos, CaretXY, ElFCRLF);
            FElEditList.FParagraphs.Items[P - 1].Text := FElEditList.FParagraphs.Items[P - 1].Text + S;
            FElEditList.FParagraphs.Delete(P);
            if (FElEditList.ParagraphCount <= FLinesInRect) and (CaretY < FLinesInRect) then
              TopLine := 0;
            FElEditList.ReformatParagraph(P - 1);
            FElEditList.ReCount(P - 1);
          end
          else
          begin
            CaretX := CaretX - 1;
            {$IFDEF LMD_UNICODE}
            S := FElEditList.ParagraphStrings[CaretY];
            FTStr := Copy(S, CaretX, 1);
            LMDWideDelete(S, CaretX, 1);
            FElEditList.ParagraphStrings[CaretY] := S;
            {$ELSE}
            S := FElEditList.ParagraphStrings[CaretY];
            FTStr := Copy(S, CaretX, 1);
            Delete(S, CaretX, 1);
            FElEditList.ParagraphStrings[CaretY] := S;
            {$ENDIF}
            if PI > 0 then
            begin
              FElEditList.CaretFromParagraph(P, PI - 1, FX, FY);
              CaretY := FY;
              CaretX := FX;
              FSelStartX := CaretX;
              FSelStartY := CaretY;
            end
            else if (P = 0) and (Length(S) = 0) then
              FElEditList.FParagraphs.Delete(0);
            FUndo.AddAction(atBackSpace, FPos, CaretXY, FTStr);
          end;
        end
        else
        begin
          {$IFDEF LMD_UNICODE}
          S := FElEditList.ParagraphStrings[CaretY];
          FTStr := Copy(S, CaretX, 1);
          LMDWideDelete(S, CaretX, 1);
          FElEditList.ParagraphStrings[CaretY] := S;
          {$ELSE}
          S := FElEditList.ParagraphStrings[CaretY];
          FTStr := Copy(S, CaretX, 1);
          Delete(S, CaretX, 1);
          FElEditList.ParagraphStrings[CaretY] := S;
          {$ENDIF}
          FElEditList.CaretFromParagraph(P, PI - 1, FX, FY);
          CaretY := FY;
          CaretX := FX;
          FUndo.AddAction(atBackSpace, FPos, CaretXY, FTStr);
          if FElEditList.ParagraphCount <= FLinesInRect then
            TopLine := 0;
        end;
      end;
      AcceptText;
    end;
  end;

  procedure DoDeletePress;
  begin
    if not ReadOnly then
    begin
      if FSelected then
        DeleteSelection
      else
      begin
        FElEditList.CaretToParagraph(CaretX, CaretY, P, PI);
        if PI < Length(FElEditList.{Paragraph} Strings[P]) then
        begin
          {$IFDEF LMD_UNICODE}
          S := FElEditList.Strings[P];
          FUndo.AddAction(atDelete, CaretXY, CaretXY, Copy(S, CaretX + 1, 1));
          LMDWideDelete(S, PI + 1, 1);
          {$ELSE}
          S := FElEditList.Strings[P];
          FUndo.AddAction(atDelete, CaretXY, CaretXY, Copy(S, CaretX + 1, 1));
          Delete(S, PI + 1, 1);
          {$ENDIF}
          FElEditList.Strings[P] := S;
          FElEditList.ReformatParagraph(P);
          FElEditList.ReCount(P);
        end
        else
        begin
          if (P + 1) < FElEditList.FParagraphs.Count then
          begin
            FUndo.AddAction(atDelete, CaretXY, CaretXY, ElFCRLF);
            S := FElEditList.FParagraphs.Items[P + 1].Text;
            FElEditList.FParagraphs.Items[P].Text := FElEditList.FParagraphs.Items[P].Text + S;
            FElEditList.FParagraphs.Delete(P + 1);
            FElEditList.ReformatParagraph(P);
            FElEditList.ReCount(P);
          end;
        end;
        FElEditList.CaretFromParagraph(P, PI, FX, FY);
        FForceSetCaretX := true;
        CaretY := FY;
        CaretX := FX;
        FForceSetCaretX := false;
        FSelStartX := CaretX;
        FSelStartY := CaretY;
      end;
      if FElEditList.ParagraphCount <= FLinesInRect then
        TopLine := 0;
      AcceptText;
    end;
  end;

  procedure NewLine;
  begin
    // now we can be sure we are getting in, only in multi line mode, without blocking others from
    // getting the return key press event (Key = VK_RETURN) and
    if (FMultiline) and CheckMaxLength() and (not ReadOnly) then
    begin
      if FSelected then
        DeleteSelection;
      FElEditList.CaretToParagraph(CaretX, CaretY, P, PI);
      FX := CaretX;
      FY := CaretY;
      if (PI > 0) then
      begin
        FElEditList.FParagraphs.Insert(P + 1, TElParagraph.Create);
        FStr := FElEditList.FParagraphs.Items[P].Text;
        {$IFDEF LMD_UNICODE}
        FStr := Copy(FStr, PI + 1, Length(FStr) - PI);
        {$ELSE}
        {$ENDIF}
        S := FElEditList.FParagraphs.Items[P].Text;
        {$IFDEF LMD_UNICODE}
        LMDWideDelete(S, PI + 1, Length(S) - PI);
        {$ELSE}
        {$ENDIF}
        FElEditList.FParagraphs.Items[P].Text := S;
        FElEditList.ReformatParagraph(P);
        if CaretX = 0 then
        begin
          FElEditList.FParagraphs.Items[P + 1].Add('');
          FElEditList.FParagraphs.Insert(P + 2, TElParagraph.Create);
          FElEditList.FParagraphs.Items[P + 2].Add(FStr);
          FElEditList.ReformatParagraph(P + 2);
          FUndo.AddAction(atLineBreak, Point((P + 1), 1), Point(0, 0), '');
        end
        else
        begin
          FElEditList.FParagraphs.Items[P + 1].Add(FStr);
          FElEditList.ReformatParagraph(P + 1);
        end;
        FElEditList.ReCount(P);
        CaretY := CaretY + 1;
        CaretX := 0;
        FSelStartX := CaretX;
        FSelStartY := CaretY;
      end;
      if PI = 0 then
      begin
        if FElEditList.FParagraphs.Count = 0 then
          FElEditList.FParagraphs.Items[0].Add('');
        FElEditList.FParagraphs.Insert(P, TElParagraph.Create);
        FElEditList.FParagraphs.Items[P].Add('');
        FElEditList.ReCount(P);
        CaretY := CaretY + 1;
        FSelStartX := CaretX;
        FSelStartY := CaretY;
      end;
      FUndo.AddAction(atInsert, Point(FX, FY), CaretXY, '');
      AcceptText;
    end;
  end;

  procedure TabPress;
  begin
    if WantTabs and CheckMaxLength() then
    begin
      FUndo.AddAction(atGroupBreak, Point(0, 0), Point(0, 0), '');
      if FSelected then
        DeleteSelection;
      FElEditList.CaretToParagraph(CaretX, CaretY, P, PI);
      S := FElEditList.ParagraphStrings[CaretY];
      {$IFDEF LMD_UNICODE}
      LMDWideInsert(ElFTab, S, CaretX + 1);
      {$ELSE}
      {$ENDIF}
      FElEditList.ParagraphStrings[CaretY] := S;
      FElEditList.CaretFromParagraph(P, PI + 1, FX, FY);
      CaretY := FY;
      CaretX := FX;
      FSelStartX := CaretX;
      FSelStartY := CaretY;
      FUndo.AddAction(atInsert, Point(FX, FY), CaretXY, FTabString);
    end;
    AcceptText;
  end;

  procedure InsertStringIntoEditor(LS: TLMDString);
  var
    b: boolean;
    LEditRect: TRect;
  begin
    if CharCase <> eecNormal then
    begin
      {$IFNDEF LMD_UNICODE}
      if CharCase = eecUppercase then
        LS := LMDAnsiUppercase(LS)
      else
        LS := LMDAnsiLowercase(LS);
      {$ELSE}
      if CharCase = eecUppercase then
        LS := LMDWideUppercase(LS)
      else
        LS := LMDWideLowercase(LS);
      {$ENDIF}
    end;

    {$IFDEF LMD_UNICODE}
    TriggerKeyPressEx(LS);
    {$ENDIF}

    if LS <> '' then
    begin
      // begin of group undo actions.
      FUndo.AddAction(atGroupBreak, Point(0, 0), Point(0, 0), '');
      if FSelected then
        DeleteSelection;

      if RightAlignedText then
      begin
        FElEditList.CaretToParagraph(CaretX, CaretY, P, PO);
        S1 := FElEditList.ParagraphStrings[CaretY];
        {$IFDEF LMD_UNICODE}
        LMDWideInsert(LS, S1, (Length(S1) + 1) - CaretX);
        FTStr := LS;
        {$ELSE}
        Insert(LS, S1, CaretX);
        FTStr := LS;
        {$ENDIF}
        FElEditList.ParagraphStrings[CaretY] := S1;
      end
      else
      begin
        FElEditList.CaretToParagraph(CaretX, CaretY, P, PO);
        S1 := FElEditList.ParagraphStrings[CaretY];
        {$IFDEF LMD_UNICODE}
        LMDWideInsert(LS, S1, CaretX + 1);
        FTStr := LS;
        {$ELSE}
        Insert(LS, S1, CaretX + 1);
        FTStr := LS;
        {$ENDIF}
        FElEditList.ParagraphStrings[CaretY] := S1;
      end;

      if (FMaxLength = 0) or (Length(ANewStr) <= FMaxLength) then
      begin
         FPos := CaretXY;
        if RightAlignedText then
          FElEditList.CaretFromParagraph(P, PO, FCarX, FCarY)
        else
          FElEditList.CaretFromParagraph(P, PO + Length(FTStr), FCarX, FCarY);

        CaretY := FCarY;
        CaretX := FCarX;
        b := (FSelStartX <> CaretX) or (FSelStartY <> CaretY);
        FSelStartY := CaretY;
        FSelStartX := CaretX;
        FUndo.AddAction(atInsert, FPos, CaretXY, FTStr);
        Modified := true;
        DoChange;
        Change;
        if b then
          TriggerSelectionChangeEvent;
        if HandleAllocated then
        begin
          LEditRect := FEditRect;
          InvalidateRect(Handle, @LEditRect, HasCustomBackground);
        end;
      end;
      FUndo.AddAction(atGroupBreak, Point(0, 0), Point(0, 0), '');
    end;
  end;

begin
  case ACommand of
  eecLeft:
    begin
      UnSelect;
      CaretX := max(CaretX - 1, 0);
      if (FSelStartY <> FCaretY) or (FSelStartX <> FCaretX) then
      begin
        FSelStartY := FCaretY;
        FSelStartX := FCaretX;
        TriggerSelectionChangeEvent;
      end;
    end;

  eecRight:
    begin
      UnSelect;
      CaretX := CaretX + 1;
      if (FSelStartY <> FCaretY) or (FSelStartX <> FCaretX) then
      begin
        FSelStartY := FCaretY;
        FSelStartX := FCaretX;
        TriggerSelectionChangeEvent;
      end;
    end;

  eecUp:
    begin
      UnSelect;
      CaretY := CaretY - 1;
      if (FSelStartY <> FCaretY) or (FSelStartX <> FCaretX) then
      begin
        FSelStartY := FCaretY;
        FSelStartX := FCaretX;
        TriggerSelectionChangeEvent;
      end;
    end;

  eecDown:
    begin
      UnSelect;
      CaretY := CaretY + 1;
      if (FSelStartY <> FCaretY) or (FSelStartX <> FCaretX) then
      begin
        FSelStartY := FCaretY;
        FSelStartX := FCaretX;
        TriggerSelectionChangeEvent;
      end;
    end;

  eecLineHome:
    begin
      UnSelect;
      CaretX := 0;
      if FSelStartX <> FCaretX then
      begin
        FSelStartX := FCaretX;
        FSelStartY := FCaretY;
        TriggerSelectionChangeEvent;
      end;
    end;

  eecLineEnd:
    begin
      UnSelect;
      FEnd := true;
      CaretX := Length(FElEditList.ParagraphStrings[CaretY]);
      FEnd := false;
      if (FSelStartY <> FCaretY) or (FSelStartX <> FCaretX) then
      begin
        FSelStartY := FCaretY;
        FSelStartX := FCaretX;
        TriggerSelectionChangeEvent;
      end;
    end;

  eecPageUp:
    begin
      UnSelect;
      CaretY := CaretY - FLinesInRect;
      if (FSelStartY <> FCaretY) or (FSelStartX <> FCaretX) then
      begin
        FSelStartY := FCaretY;
        FSelStartX := FCaretX;
        TriggerSelectionChangeEvent;
      end;
    end;

  eecPageDown:
    begin
      UnSelect;
      CaretY := CaretY + FLinesInRect;
      if (FSelStartY <> FCaretY) or (FSelStartX <> FCaretX) then
      begin
        FSelStartY := FCaretY;
        FSelStartX := FCaretX;
        TriggerSelectionChangeEvent;
      end;
    end;

  eecSelectNone:
    UnSelect;

  eecNewLine:
    NewLine;

  eecTab:
    TabPress;

  eecDeleteChar:
    DoDeletePress;

  eecDeletePrevChar:
    DoBackPress;

  eecDeletePrevWord:
    begin
      if FSelected then
        DeleteSelection;
      FPos := GetPrevWord(Point(CaretX - 1, CaretY));
      SetSelection(FPos.X, FPos.Y);
      DeleteSelection;
    end;

  eecDeleteWord:
    begin
      FPos := GetNextWord(CaretXY);
      SetSelection(FPos.X, FPos.Y);
      DeleteSelection;
    end;

  eecPrevWord:
    begin
      FPos := GetPrevWord(Point(CaretX - 1, CaretY));
      if FSelected then
        UnSelect;
      CaretXY := FPos;
      FSelStartX := FCaretX;
      FSelStartY := FCaretY;
      TriggerSelectionChangeEvent;
      RepaintText(EditRect);
    end;

  eecTextHome:
    begin
      if FSelected then
        UnSelect;
      CaretX := 0;
      CaretY := 0;
      if (FSelStartY <> FCaretY) or (FSelStartX <> FCaretX) then
      begin
        FSelStartY := FCaretY;
        FSelStartX := FCaretX;
        TriggerSelectionChangeEvent;
      end;
    end;

  eecTextEnd:
    begin
      if FSelected then
        UnSelect;
      FElEditList.CaretFromParagraph(FElEditList.FParagraphs.Count - 1,
          Length(FElEditList.FParagraphs.Items[FElEditList.FParagraphs.Count - 1].Text),
          FX, FY);
      CaretX := FX;
      CaretY := FY;
      if (FSelStartY <> FCaretY) or (FSelStartX <> FCaretX) then
      begin
        FSelStartY := FCaretY;
        FSelStartX := FCaretX;
        TriggerSelectionChangeEvent;
      end;
    end;

  eecNextWord:
    begin
      FPos := GetNextWord(CaretXY);
      if FSelected then
        UnSelect;
      CaretXY := FPos;
      if (FSelStartY <> FCaretY) or (FSelStartX <> FCaretX) then
      begin
        FSelStartY := FCaretY;
        FSelStartX := FCaretX;
        TriggerSelectionChangeEvent;
      end;
      RepaintText(EditRect);
    end;

  eecChar:
    begin
      {$IFDEF LMD_UNICODE}
      LKeys := WideString(AData^);
      {$else}
      Key := AChar;
      {$endif}

      {$IFDEF LMD_UNICODE}
      S2 := LKeys;
      {$ELSE}
      S2 := Key;
      {$ENDIF}

      InsertStringIntoEditor(S2);
    end;

  eecWideString:
    InsertStringIntoEditor(TLMDString(AData^));

  eecSelectLeft:
    begin
      CaretX := CaretX - 1;
      SetSelection(CaretX, CaretY);
      RepaintText(FEditRect);
    end;

  eecSelectPrevWord:
    begin
      CaretXY := GetPrevWord(Point(CaretX - 1, CaretY));
      SetSelection(CaretX, CaretY);
      RepaintText(FEditRect);
    end;

  eecSelectHome:
    begin
      CaretX := 0;
      SetSelection(CaretX, CaretY);
      RepaintText(FEditRect);
    end;

  eecSelectPrevAll:
    begin
      CaretY := 0;
      CaretX := 0;
      SetSelection(CaretX, CaretY);
      RepaintText(FEditRect);
    end;

  eecSelectRight:
    begin
      CaretX := CaretX + 1;
      SetSelection(CaretX, CaretY);
      RepaintText(FEditRect);
    end;

  eecSelectNextWord:
    begin
      CaretXY := GetNextWord(CaretXY);
      SetSelection(CaretX, CaretY);
      RepaintText(FEditRect);
    end;

  eecSelectEnd:
    begin
      FEnd := true;
      CaretX := Length(FElEditList.ParagraphStrings[CaretY]);
      FEnd := false;
      SetSelection(CaretX, CaretY);
      RepaintText(FEditRect);
    end;

  eecSelectNextAll:
    begin
      CaretY := FElEditList.ParagraphCount;
      CaretX := Length(FElEditList.ParagraphStrings[FElEditList.ParagraphCount - 1]);
      SetSelection(CaretX, CaretY);
      RepaintText(FEditRect);
    end;

  eecSelectUp:
    begin
      CaretY := CaretY - 1;
      SetSelection(CaretX, CaretY);
      RepaintText(FEditRect);
    end;

  eecSelectDown:
    begin
      CaretY := CaretY + 1;
      SetSelection(CaretX, CaretY);
      RepaintText(FEditRect);
    end;

  eecSelectPageUp:
    begin
      CaretY := CaretY - FLinesInRect;
      SetSelection(CaretX, CaretY);
      RepaintText(FEditRect);
    end;

  eecSelectPageDown:
    begin
      CaretY := CaretY + FLinesInRect;
      SetSelection(CaretX, CaretY);
      RepaintText(FEditRect);
    end;

  eecSelectAll:
    SelectAll;

  eecSelectDelete:
    begin
      if FSelected then
        DeleteSelection;
      if NotifyUserChangeOnly then
        Change;
    end;

  eecCut:
  begin
    CutToClipboard;
    Modified := True;
  end;

  eecCopy:
    CopyToClipboard;

  eecPaste:
  begin
    PasteFromClipboard;
    Modified := True;
  end;

  eecUndo:
    Undo;

  eecSetBookmark0,
  eecSetBookmark1,
  eecSetBookmark2,
  eecSetBookmark3,
  eecSetBookmark4,
  eecSetBookmark5,
  eecSetBookmark6,
  eecSetBookmark7,
  eecSetBookmark8,
  eecSetBookmark9:
    SetBookmark(ACommand - eecSetBookmark0);

  eecGotoBookmark0,
  eecGotoBookmark1,
  eecGotoBookmark2,
  eecGotoBookmark3,
  eecGotoBookmark4,
  eecGotoBookmark5,
  eecGotoBookmark6,
  eecGotoBookmark7,
  eecGotoBookmark8,
  eecGotoBookmark9:
    GotoBookmark(ACommand - eecGotoBookmark0);

  //----> 26.01.07
  eecSetStress:
  begin
    SetStress(CaretX,CaretY);
  end;
  //<---- 26.01.07
  end;
end;

//----> 26.01.07
procedure TCustomElEdit.SetStress(const X, Y: Integer);
var
  LStr: WideString;
  LParagraph,LParaOffs: Integer;
begin
  FElEditList.CaretToParagraph(X, Y, LParagraph, LParaOffs);
  LStr := FElEditList.FParagraphs.Items[LParagraph].Text;
  if LStr[LParaOffs] <> #0769 then
  begin
    LMDWideInsert(#0769, LStr, LParaOffs + 1);
    Lines[LParagraph] := LStr;
    FElEditList.ReformatParagraph(LParagraph);
    ExecuteCommand(eecRight, #0, nil);
  end;
end;
//<---- 26.01.07

procedure TCustomElEdit.SetBookmark(const Index: Integer);
begin
  if (FBookmarks[Index].FX = CaretX) and (FBookmarks[Index].FY = CaretY) then
  begin
    FBookmarks[Index].FX := -1;
    FBookmarks[Index].FY := -1;
  end
  else
  begin
    FBookmarks[Index].FX := CaretX;
    FBookmarks[Index].FY := CaretY;
  end;
end;

procedure TCustomElEdit.GotoBookmark(const Index: Integer);
begin
  CaretY := FBookmarks[Index].FY;
  CaretX := FBookmarks[Index].FX;
end;

procedure TCustomElEdit.WMGetDlgCode(var Msg : TWMGetDlgCode); { private }
begin
  Msg.Result := DefWindowProc(Handle, Msg.Msg, TMessage(Msg).wParam, TMessage(Msg).lParam);
  Msg.Result := (Msg.Result and (not DLGC_WANTALLKEYS)) or DLGC_WANTARROWS or DLGC_WANTCHARS
    or DLGC_HASSETSEL;
  if WantTabs then
    Msg.Result := Msg.Result or DLGC_WANTTAB;
  if HandleDialogKeys or (Multiline and WantReturns) then
    Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
end; { WMGetDlgCode }

{$IFDEF LMD_UNICODE}
procedure TCustomElEdit.WMImeStartComposition(var Message: TMessage);
var
  IMC: HIMC;
  LogFont: TLogFont;
  CF: TCompositionForm;
begin
  IMC := ImmGetContext(Handle);
  if (IMC <> 0) then
  begin
    GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @LogFont);
    ImmSetCompositionFont(IMC, @LogFont);
    CF.dwStyle := CFS_RECT;
    CF.rcArea  := EditRect;
    inc(CF.rcArea.Left, LeftMargin);
    dec(CF.rcArea.Right, RightMargin);
    CF.ptCurrentPos := PosFromCaret(CaretX, CaretY);

    ImmSetCompositionWindow(IMC, @CF);
    ImmReleaseContext(Handle, IMC);
  end;
  inherited;
end;

procedure TCustomElEdit.WMImeComposition(var Message: TMessage);
var
  IMC: HIMC;
  S: String;
  SNT: TLMDString;
  Size: Integer;
  StrEnd: PWideChar;
  ImmGetCompositionStringW: TIMECompositionStringProc;
  fx, fy: integer;
  LTextLen, LSNTLen: Integer;
begin
  // Input of word is finished?
  if ((Message.LParam and GCS_RESULTSTR) <> 0) then
  begin
    IMC := ImmGetContext(Handle);
    if (IMC <> 0) and (not ReadOnly) then
    begin
      // NT, 2000, XP?
      if LMDSIWindowsNTUp then
      begin
        try
          SNT := '';
          if GetModuleHandle('IMM32') <> 0 then
          begin
            ImmGetCompositionStringW := GetProcAddress(GetModuleHandle('IMM32'), 'ImmGetCompositionStringW');
            if @ImmGetCompositionStringW <> nil then
            if Assigned(ImmGetCompositionStringW) then
            begin
              Size := ImmGetCompositionStringW(IMC, GCS_RESULTSTR, nil, 0);
              SetLength(SNT, Size);
              LMDFillWideChar(PWideChar(SNT)^, Size, #0);
              ImmGetCompositionStringW(IMC, GCS_RESULTSTR, PWideChar(SNT), Size);
            end;
          end;
        finally
          ImmReleaseContext(Handle, IMC);
        end;
        // remove null symbols
        StrEnd := LMDWideStrScan(PWideChar(SNT), WideChar(#0));
        if StrEnd <> nil then
          SetLength(SNT, StrEnd - PWideChar(SNT));
        end
      else
      begin
        // IME support for Win95-98
        // Unfortunately, should properly work not for all versions
        // (you'll get a line of '?')
        S := '';
        try
          Size := ImmGetCompositionStringA(IMC, GCS_RESULTSTR, nil, 0);
          SetLength(s, Size);
          ImmGetCompositionStringA(IMC, GCS_RESULTSTR, PChar(s), Size);
          finally
          ImmReleaseContext(Handle, IMC);
        end;
        SNT := LMDKeyToUnicode(s);
      end;
      CommandCenter(eecWideString, #0, @SNT);
      exit;

      if FCharCase = eecUppercase then
        SNT := LMDWideUppercase(SNT)
      else
      if FCharCase = eecLowercase then
        SNT := LMDWideLowercase(SNT);

      TriggerKeyPressEx(SNT);

      if SNT <> '' then
      begin
        LTextLen := Length(Text);
        LSNTLen := Length(SNT);

        if ((LTextLen + LSNTLen) > FMaxLength) and (FMaxLength > 0) then
          SNT := Copy(SNT, 1, (FMaxLength - LTextLen));

        if FSelected then
          DeleteSelection;

        fx := CaretX;
        fy := CaretY;

        FElEditList.InsertText(fx, fy, SNT);

        CaretY := fy;
        CaretX := fx;
        FSelStartX := fx;
        FSelStartY := fy;
        RepaintText(FEditRect);

        DoChange;
        Change;
      end;
      Message.Result := 0;
    end
  end
  else
    inherited;
end;
{$ENDIF}

function TCustomElEdit.GetSelectedText: TLMDString;
var
  bP, bPO: integer;
  eP, ePO: integer;
  i: integer;
  // fast;
  L, Size, Count: Integer;
  {$IFDEF LMD_UNICODE}
  P: PWideChar;
  S: WideString;
  {$ELSE}
  P: PChar;
  S: String;
  {$ENDIF}
  begin
   // {!}to do fast getseltext
   FElEditList.CaretToParagraph(FSelFirstX, FSelFirstY, bP, bPO);
   FElEditList.CaretToParagraph(FSelLastX, FSelLastY, eP, ePO);
   if eP = bP then
     Result := Copy(FElEditList.FParagraphs.Items[bP].Text, bPO + 1, (ePO - bPO))
   else
   begin
     Result := Copy(FElEditList.FParagraphs.Items[bP].Text, bPO + 1,
                    Length(FElEditList.FParagraphs.Items[bP].Text)) + ElFCRLF;

     Size := Length(Result);
     Count := Size;
     inc(Size, ePO);
     for I := bP + 1 to eP - 1 do
       Inc(Size, Length(FElEditList.FParagraphs.Items[i].Text) + 2);
     SetLength(Result, Size);
     {$IFDEF LMD_UNICODE}
     P := PWideChar(Result);
     {$ELSE}
     P := PChar(Result);
     {$ENDIF}
     inc(P, Count);
     for I := bP + 1 to eP - 1 do
     begin
       S := FElEditList.FParagraphs.Items[i].Text;
       L := Length(S);
       if L <> 0 then
       begin
       {$IFDEF LMD_UNICODE}
         LMDWideMove(S[1], P^, L);
         {$ELSE}
         Move(S[1], P^, L);
         {$ENDIF}
         Inc(P, L);
       end;
       P^ := #13;
       Inc(P);
       P^ := #10;
       Inc(P);
       end;
     S := Copy(FElEditList.FParagraphs.Items[eP].Text, 1, ePO);
     L := Length(S);
     if L > 0 then
     begin
     {$IFDEF LMD_UNICODE}
       LMDWideMove(S[1], P^, L);
       {$ELSE}
       Move(S[1], P^, L);
       {$ENDIF}
       // Inc(P, L);
     end;
   end;
end;

destructor TCustomElEdit.Destroy;
begin
  Destroying;
  if FHasCaret then
    DestroyCaret();
  FHasCaret := false;
  FreeAndNil(FImgFormChLink);
  FreeAndNil(FTextPainter);
//  FElEditList.FParagraphs.Items[0].Free;
  FreeAndNil(FCommandCenter);
  FreeAndNil(FElEditList);
  FreeAndNil(FDisplayReadOnlyOptions);
  FreeAndNil(FBackground);
  {$ifdef LMD_UNICODE}
  FreeAndNil(FDeadCharList);
  {$endif}
  FUndo.Free;
  FRedo.Free;
  inherited;
end; { Destroy }

constructor TCustomElEdit.Create(AOwner : TComponent);
var
  LTextMetric: TLMDTextMetric;
  DC: HDC;
begin
  BeginCreate;
  NotifyUserChangeOnly := true;
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csCaptureMouse, csOpaque] + [csFixedHeight];
  FMultiline := false;
  FModifyCount := 0;
  FlagEdit := false;
  {$IFDEF LMD_UNICODE}
  FDeadCharList := TElDeadCharList.Create;
  FCDead := 1;
  FDeadChar := #0;
  {$ENDIF}
  FIgnoreReadOnlyState := True;
  FEnd := false;
  FUpdate := false;
  Ctl3D := true;
  FUserChangesOnly := true;
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
  FForceSetCaretX := false;

  FCueBanner := '';
  //----> 24.01.07 Add ShortCut to Stress Sign
  FStressShortCut := 0;
  //<---- 24.01.07

  FLineBorderActiveColor := clBtnFace;
  FLineBorderInactiveColor := clBtnFace;

  FDragging := False;
  FDragAllowed := False;

  SetLeftMargin(1);
  SetRightMargin(1);
  FAlignBottom := true;
  FUseSystemMenu := true;
  FLocalizedSystemMenu := false;

  FTextPainter := CreateTextPainter;
  FTopMargin := 0;
//  if not FAlignBottom then
//    FTopMargin := 1;
  Width := 200;
  Height := 100;
  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChanged;
  // Height := Abs(Font.Height) + GetSystemMetrics(SM_CYBORDER) * 2 + 4;
  FLineHeight := Abs(Font.Height) + 2;
  FEditRect.Right := 100 - GetSystemMetrics(SM_CXBORDER);
  FEditRect.Bottom := Height - GetSystemMetrics(SM_CYBORDER);
  FLinesInRect := (FEditRect.Bottom - FTopMargin) div FLineHeight;
  FTabSpaces := 4;
  FTabString := '    ';
  FTopLine := 0;
  FWantReturns := false;
  FElEditList := TElEditStrings.Create;
  FDisplayReadOnlyOptions := TElDisplayOptions.Create;
  FDisplayReadOnlyOptions.OnChange := DisplayOptionsChange;
  FAutoSize := true;
  FAlienFocus := false;
  FElEditList.FElEdit := Self;

  // Get Font metrics for vertical alignment
  DC := GetDC(0);
  LMDGetTextMetrics(DC, LTextMetric);
  ReleaseDC(0, DC);
  FAscent := LTextMetric.tmAscent;
  FDescent := LTextMetric.tmDescent;

  //  SetScrollBarsInfo;
  FBorderStyle := bsSingle;
  ParentColor := false;
  Color := clWindow;
  Cursor := crIBeam;
  MoveCaret(0);
  FActiveBorderType := fbtSunken;
  FInactiveBorderType := fbtSunkenOuter;
  FModified := False;
  TabStop := true;

  FCommandCenter := TElKeyCommandList.Create;
  FCommandCenter.DefaultKeyBind();

  FBorderSides := AllBorderSides;
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FUseCustomScrollBars := True;
  {< ELSCROLLBAR}
  fSBCtrl := TElSBController.Create(Self);
  // Horizontal:
  fSBCtrl.UseXPThemes := true;
  fSBCtrl.HorzScrollBarStyles.OnScroll := OnHScroll;
  fSBCtrl.HorzScrollBarStyles.OnChange := SBChanged;
  fSBCtrl.HorzScrollBarStyles.Visible :=
    (FUseCustomScrollBars and Multiline) and (ScrollBars in [ssHorizontal, ssBoth]);
  dec(FEditRect.Right, GetSystemMetrics(SM_CXHTHUMB) - 1);
  // Vertical:
  fSBCtrl.VertScrollBarStyles.OnScroll := OnVScroll;
  fSBCtrl.VErtScrollBarStyles.OnChange := SBChanged;
  fSBCtrl.VertScrollBarStyles.Visible :=
    (FUseCustomScrollBars and Multiline) and (ScrollBars in [ssVertical, ssBoth]);
  dec(FEditRect.Bottom, GetSystemMetrics(SM_CYVTHUMB) - 1);
  {> ELSCROLLBAR}
  //  AdjustHeight;
  SetScrollBarsInfo;
  {$IFDEF LMD_UNICODE}
  ToUnicode := GetProcAddress(GetModuleHandle('USER32'), 'ToUnicode');
  {$ENDIF}
  CaretX := 0;
  CaretY := 0;
  FUndo := TElActionList.Create;
  FRedo := TElActionList.Create;

  FHighlightAlphaLevel := 255;
  FHideSelection := true;
  FFocusedSelectColor := clHighlight;
  FFocusedSelectTextColor := clHighlightText;
  FHideSelectColor := clBtnFace;
  FHideSelectTextColor := LMDElHideSelectTextColor;
  FLinkedControlPosition := lcpTopLeft;
  FDisabledColor := clBtnFace;
  FDisabledFontColor := clGrayText;

  // TripleClick
  FDoubleClickCX := GetSystemMetrics(SM_CXDOUBLECLK);
  FDoubleClickCY := GetSystemMetrics(SM_CYDOUBLECLK);
  FDoubleClickTimeout := GetDoubleClickTime();
  EndCreate;
end; { Create }

procedure TCustomElEdit.SetBackground(const Value: TBitmap);
begin
  FBackground.Assign(Value);
end;

procedure TCustomElEdit.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then
      FImgForm.RegisterChanges(FImgFormChLink);
    if HandleAllocated then
    begin
      RecreateWnd;
      Perform(CM_COLORCHANGED, 0, 0);
      end;
  end;
end;

procedure TCustomElEdit.SetUseBackground(const Value: boolean);
begin
  if FUseBackground <> Value then
  begin
    FUseBackground := Value;
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
    end;
end;

(*
procedure TCustomElEdit.WMNCCalcSize(var Message : TWMNCCalcSize);
begin
  if (not LMDSIWindowsVistaUp) or Multiline then
    inherited;
  if (UseThemeMode = ttmNone) and Flat and (not LMDSIWindowsVistaUp) then
  begin
    with Message do
    begin
        CalcSize_Params^.rgrc[0].Left := CalcSize_Params^.rgrc[0].Left + 3;
        CalcSize_Params^.rgrc[0].Top := CalcSize_Params^.rgrc[0].Top + 2;
      end;
    end;
end;
*)


procedure TCustomElEdit.WMNCCalcSize(var Message : TWMNCCalcSize);
begin
  if (BorderStyle = bsSingle) and Flat and (not IsThemed) then
    begin
      inherited;
      if (ebsLeft in BorderSides) then
        inc(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
      if (ebsTop in BorderSides) then
        inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
      if (ebsRight in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
      if (ebsBottom in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));
      if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
        Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
      if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
        Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;
    end
  else
    begin
      begin
          inherited;
          if not (ebsLeft in BorderSides) then
            dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
          if not (ebsTop in BorderSides) then
            dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
          if not (ebsRight in BorderSides) then
            Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
          if not (ebsBottom in BorderSides) then
            Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));

          if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
            Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
          if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
            Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;
        end
      end;
end;

procedure TCustomElEdit.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomElEdit.SetActiveBorderType(const Value: TElFlatBorderType);
begin
  if FActiveBorderType <> Value then
  begin
    FActiveBorderType := Value;
    if Focused or FMouseOver then
      DrawFlatBorder;
    end;
end;

procedure TCustomElEdit.SetFlat(const Value: boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    if HandleAllocated then
      {if Flat then
        Invalidate
      else
      }  RecreateWnd;
    SetScrollBarsInfo;
  end;
end;

procedure TCustomElEdit.SetInactiveBorderType(const Value: TElFlatBorderType);
begin
  if FInactiveBorderType <> Value then
  begin
    FInactiveBorderType := Value;
    if not Focused and not FMouseOver then
      DrawFlatBorder;
    end;
end;

procedure TCustomElEdit.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TCustomElEdit.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElEdit.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  UpdateLinkedControl;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TCustomElEdit.WndProc(var Msg: TMessage);
var
  LClickTime: LongWord;
begin
  inherited WndProc(Msg);
  if (Msg.Msg = WM_LBUTTONDOWN) or (Msg.Msg = WM_LBUTTONDBLCLK) then
    begin
      LClickTime := GetTickCount();
      if (LClickTime - FLastClickTime > FDoubleClickTimeout)
        or (abs(Msg.LParamLo - FFirstClickX) > FDoubleClickCX)
          or (abs(Msg.LParamHi - FFirstClickY) > FDoubleClickCY) then
        begin
          FClickCount := 1;
          FLastClickTime := LClickTime;
        end
      else
      begin
        case FClickCount of
          0, 1:
            begin
              Inc(FClickCount);
              FLastClickTime := LClickTime;
            end;
          2:
            begin
              TriggerTripleClick;
              FClickCount := 0;
              FLastClickTime := 0;
            end;
        end;
      end;
      if (FClickCount = 1) then
        begin
          FFirstClickX := Msg.LParamLo;
          FFirstClickY := Msg.LParamHi;
        end;
    end;
end;

procedure TCustomElEdit.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if FLinkedControl = AComponent then
      LinkedControl := nil;
    if AComponent = FImgForm then
    begin
      ImageForm := nil;
    end;
    //Validation support, November 2007, RS
    if  Assigned(Self.FValidator) and (AComponent = Self.FValidator) then
      Self.SetValidator(nil);
  end;
end;

procedure TCustomElEdit.DrawBackground(DC: HDC; R: TRect);
var
  X, Y: integer;
begin
  if FUseBackground and not FBackground.Empty then
  begin
    X := R.Left; Y := R.Top;
    while Y < R.Bottom do
    begin
      while X < R.Right do
      begin
        BitBlt(DC, X, Y, R.Right - X, R.Bottom - Y,
          FBackground.Canvas.Handle, 0, 0, SRCCOPY);
        Inc(X, FBackground.Width);
      end;
      X := R.Left;
      Inc(Y, FBackground.Height);
    end;
  end;
end;

procedure TCustomElEdit.DrawFlatBorder;
var
  DC : HDC;
  R  : TRect;
  b  : boolean;
  BS : TElFlatBorderType;
  AColor : TColor;
const BordersFlat : array[boolean] of Integer = (0, WS_BORDER);
      Borders3D : array[boolean] of Integer = (0, WS_EX_CLIENTEDGE);
begin
  if not HandleAllocated then
    exit;
  R := Rect(0, 0, Width, Height);
  DC := GetWindowDC(Handle);
  try
    if IsThemed (*and (BorderStyle = bsSingle)*) then
    begin
      (*
      R1 := ClientRect;
      R1.TopLeft := Parent.ScreenToClient(ClientToScreen(R1.TopLeft));

      ax := Left - R1.Left;
      ay := Top  - R1.Top;

      R1 := ClientRect;
      OffsetRect(R1, -ax, -ay);

      with R1 do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
      DrawThemeBackground(Theme, DC, 0, 0, R, nil);
      *)
//      RedrawWindow(Handle, @R, 0, RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);
//      exit;
    end
    else
    begin
      if BorderStyle = bsSingle then
      begin
        b := Focused or FMouseOver;
        if b then
           BS := FActiveBorderType
        else
           BS := FInactiveBorderType;
        if Focused or FMouseOver then
          AColor := LineBorderActiveColor
        else
          AColor := LineBorderInactiveColor;
        if not Flat then
          BS := fbtSunken;
        DrawFlatFrameEx2(DC, R, AColor, Color, b, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
      end;
      if not IsThemed then
      begin
        if (not UseCustomScrollBars) and
           (FFlatFocusedScrollBars or not (Focused or FMouseOver))
        then
          DrawFlatScrollbars(Handle, DC, R,
            (Focused or FMouseOver) and not FFlatFocusedScrollBars,
            ScrollBars, False, False, False,
            GetWindowLong(Handle, GWL_STYLE) or
              BordersFlat[(not Ctl3D) and (BorderStyle = bsSingle)],
            GetWindowLong(Handle, GWL_EXSTYLE) or Borders3D[Ctl3D and (BorderStyle = bsSingle)]
          );
      end;
    end;
  finally
    ReleaseDC(Handle, DC);
  end;
end;

type
  THackWinControl = class(TWinControl)
   ;

procedure TCustomElEdit.DrawParentControl(DC: HDC);
var
  SavedDC: integer;
  P: TPoint;
  R: TRect;
begin
  if Assigned(Parent) then
  begin
    SavedDC := SaveDC(DC);
    try
      P := Parent.ScreenToClient(ClientOrigin);
      MoveWindowOrg(DC, -P.X, -P.Y);
      R := EditRect;
      with r do
        IntersectClipRect(DC, Left, Top, Right, Bottom);
      Parent.Perform(WM_ERASEBKGND, DC, 0);
      Parent.Perform(WM_PAINT, DC, 0);
      THackWinControl(Parent).PaintControls(DC, nil);
    finally
      RestoreDC(DC, SavedDC);
    end;
  end;
end;

//function TCustomElEdit.GetPartIDForBackground: integer;
//begin
//{$IFDEF LMDDISABLE_LMDTHEMES}
//  Result := EP_EDITTEXT;
//{$ELSE}
//  Result := EP_BACKGROUND;
//{$ENDIF}
//end;

function TCustomElEdit.GetThemedElement: TThemedElement;
begin
  Result := teEdit;
end;

procedure TCustomElEdit.SetWordWrap(Value: boolean);
begin
  if (FWordWrap <> Value) then
  begin
    FWordWrap := Value;
    Invalidate;
    SetScrollBarsInfo;
    FElEditList.Reformat;
    FElEditList.ReCount(0);
  end;
end;

procedure TCustomElEdit.SetScrollBars(const Value: TScrollStyle);
begin
    if (FScrollBars <> Value) {and (FMultiline){and ((Value <> ssNone) and (FMultiline)))} then
    begin
      if FMultiline or ((ComponentState * [csReading, csLoading]) <> []) then
        FScrollBars := Value
      else
        FScrollBars := ssNone;
      if HandleAllocated then
      begin
        if (ComponentState * [csLoading, csReading] = []) then
        RecreateWnd;
        SetEditRect(ClientRect);
        SetScrollBarsInfo;
      end;
    end;
end;

procedure TCustomElEdit.SetScrollBarsAutoShowing(const Value: TScrollStyle);
begin
  if FScrollBarsAutoShowing <> Value then
  begin
    FScrollBarsAutoShowing := Value;
    SetScrollBarsInfo;
  end;
end;

procedure TCustomElEdit.WMVScroll(var Msg : TWMScroll);
var
  b : boolean;
  sc: TElScrollCode;
  sp: integer;
begin
 b := false;
 sc := escTrack;
 case Msg.ScrollCode of
   SB_LINEDOWN:
   begin
     sc := escLineDown;
     sp := FTopLine + 1;
   end;
   SB_LINEUP:
   begin
     sc := escLineUp;
     sp := FTopLine - 1;
   end;
   SB_PAGEUP:
   begin
     sc := escPageUp;
     sp := FTopLine - FLinesInRect;
   end;
   SB_PAGEDOWN:
   begin
     sc := escPageDown;
     sp := FTopLine + FLinesInRect;
   end;
   SB_THUMBTRACK:
   begin
     sc := escTrack;
     sp := Msg.Pos;
   end;
   SB_THUMBPOSITION:
   begin
     sc := escPosition;
     sp := Msg.Pos;
   end;
   SB_TOP:
   begin
     sc := escTop;
     sp := 0;
   end;
   SB_BOTTOM:
   begin
     sc := escBottom;
     sp := FElEditList.ParagraphCount - FLinesInRect;
   end;
   SB_ENDSCROLL:
   begin
     sc := escEndScroll;
     sp := FTopLine;
   end;
 end;
 if (sp >= 0) and (sp <= FElEditList.ParagraphCount - 1) then
   OnVScroll(Self, sc, sp, b);
end;

procedure TCustomElEdit.WMHScroll(var Msg : TWMScroll);
var
  b : boolean;
  sc: TElScrollCode;
  sp: integer;
begin
 b := false;
 sc := escTrack;
 case Msg.ScrollCode of
   SB_LINEDOWN:
   begin
     sc := escLineDown;
     sp := FLeftChar + 5;
   end;
   SB_LINEUP:
   begin
     sc := escLineUp;
     sp := FLeftChar - 5;
   end;
   SB_PAGEUP:
   begin
     sc := escPageUp;
     sp := FLeftChar - ClientWidth div 2;
   end;
   SB_PAGEDOWN:
   begin
     sc := escPageDown;
     sp := FLeftChar + ClientWidth div 2;
   end;
   SB_THUMBPOSITION:
   begin
     sc := escPosition;
     sp := Msg.Pos;
   end;
   SB_THUMBTRACK:
   begin
     sc := escTrack;
     sp := Msg.Pos;
   end;
   SB_LEFT:
   begin
     sc := escTop;
     sp := 0;
   end;
   SB_RIGHT:
   begin
     sc := escBottom;
     sp := FElEditList.FMaxLen - scbHorz.Page - 1;
   end;
   SB_ENDSCROLL:
   begin
     sc := escEndScroll;
     sp := FLeftChar;
   end;
 end;
 if (sp >= 0) and (sp <= FElEditList.FMaxLen) then
   OnHScroll(Self, sc, sp, b)
 else
 if (sp < 0) and (FLeftChar > 0) then
 begin
   sp := 0;
   OnHScroll(Self, sc, sp, b);
 end;
end;

procedure TCustomElEdit.WMInputLangChange(var Msg: TMessage);
begin
  FCharSet := Msg.WParam;
  // FKeybLayout := HKL(Msg.LParam);
end;

procedure TCustomElEdit.WMCommand(var Msg: TWMCommand);
begin
  case Msg.ItemID of
  // Select All in Windows 9x/ME - 1025, in NT/2k/XP - 177
  177, 1025:
      ExecuteCommand(eecSelectAll, #0, nil);
  ID_PASTE:
      ExecuteCommand(eecPaste, #0, nil);
  ID_CUT:
      ExecuteCommand(eecCut, #0, nil);
  ID_COPY:
      ExecuteCommand(eecCopy, #0, nil);
  ID_DELETE:
      ExecuteCommand(eecSelectDelete, #0, nil);
  ID_UNDO:
      ExecuteCommand(eecUndo, #0, nil);
  end;
end;

procedure TCustomElEdit.WMMouseWheel(var Msg: TWMMouseWheel);
var
  Dy : integer;
  sl : integer;
begin
  inherited;
  if Multiline then
  begin
    if LMDSIWindowsNT or LMDSIWindows98 then
       SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
    else
       sl := 3;
    if sl = 0 then
      sl := 1;
    Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
    if Dy <> 0 then
    begin
      if (TopLine - Dy) < 0 then
        TopLine := 0
      else
      if TopLine - Dy > FElEditList.ParagraphCount - FLinesInRect then
        TopLine := FElEditList.ParagraphCount - FLinesInRect
      else
        TopLine := TopLine - Dy;
      SetScrollBarsInfo;
      InvalidateRect(Handle, @FEditRect, HasCustomBackground);
    end;
  end;
end;

procedure TCustomElEdit.WMCaptureChanged(var Msg: TMessage);
begin
  inherited;
end;

procedure TCustomElEdit.SetLeftChar(Value: integer);
begin
  if (FLeftChar <> Value) and ((not FWordWrap) or (not Multiline)) then
  begin
    FLeftChar := Value;
    if FLeftChar < 0 then
      FLeftChar := 0;
    if FLeftChar > FElEditList.FMaxLen then
      FLeftChar := FElEditList.FMaxLen;

    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);

    Invalidate;
    SetScrollBarsInfo;
  end;
end;

procedure TCustomElEdit.SetTopLine(const Value: integer);
begin
  if FTopLine <> Value then
  begin
    if Value < 0 then
      if FTopLine = 0 then
        exit
      else FTopLine := 0
    else
      if (Value + FLinesInRect) > FElEditList.ParagraphCount then
      begin
        if (FTopLine = FElEditList.ParagraphCount - FLinesInRect) and (FTopLine > 0) then
          exit;
        //if FTopLine > 0 then
        FTopLine := Min(Value, FElEditList.ParagraphCount - FLinesInRect);
        if FTopLine < 0 then
          FTopLine := 0;
        //else
        //  FTopLine := 0;
      end
      else
        FTopLine := Value;

    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
    Invalidate;
    SetScrollBarsInfo;
  end;
end;

procedure TCustomElEdit.SetScrollBarsInfo;
var
  FMin: integer;
  si  : TScrollInfo;
  FCharsMax: integer;
  FMaxStr: TLMDString;

begin
  if not HandleAllocated then
    exit;
  // Set Scrollbars properties
  // VScroll

  FMin := (FElEditList.ParagraphCount - FLinesInRect);
  if (FMin > 0) then
    begin
      if ScrollBars in [ssVertical, ssBoth] then
        begin
          si.cbSize := SizeOf(Si);
          si.fMask := SIF_RANGE or SIF_POS or SIF_PAGE;
          si.nMin := 0;
          si.nMax := FElEditList.ParagraphCount - 1;
          si.nPage := FLinesInRect;
          si.nPos := TopLine;
          if FScrollBarsAutoShowing in [ssVertical, ssBoth] then
            ShowScrollBar(Handle, SB_VERT, true);
          EnableScrollBar(Handle, SB_VERT, ESB_ENABLE_BOTH);
          SetScrollInfo(Handle, SB_VERT, si, True);
        end
    end
  else
    begin
      //FTopLine := 0;
      if ScrollBars in [ssVertical, ssBoth] then
        begin
          EnableScrollBar(Handle, SB_VERT, ESB_DISABLE_BOTH);
          si.cbSize := sizeof(Si);
          si.fMask := SIF_RANGE;
          si.fMask := si.fMask or SIF_DISABLENOSCROLL;
          si.nMin := 0;
          si.nMax := 0;
          if FScrollBarsAutoShowing in [ssVertical, ssBoth] then
            ShowScrollBar(Handle, SB_VERT, false);
          SetScrollInfo(Handle, SB_VERT, si, True);
          scbVert.SetScrollInfo(si, false{true}); //VB Jun 2010 BTS#721
        end
    end;

    if ScrollBars in [ssHorizontal, ssBoth] then
      begin
        if FElEditList.FParagraphs.Count > 0 then
          FMaxStr := FElEditList.FMaxStr;
        if {((FElEditList.FIdxMaxLen < FElEditList.ParagraphCount) and }
           (FtextPainter.TextSize(FMaxStr).cx >
             ((EditRect.Right - FRightMargin) -
              (EditRect.Left + FLeftMargin))) {or (FLeftChar > 0)} then
          begin
            FCharsMax := CharsFitRight((EditRect.Right - FRightMargin) - (EditRect.Left + FLeftMargin),
              FMaxStr, 0);

            si.cbSize := SizeOf(Si);
            si.fMask := SIF_RANGE or SIF_POS or SIF_PAGE;
            si.nMin := 0;
            si.nMax := FElEditList.FMaxLen;
            si.nPage := FCharsMax - 4;
            si.nPos := FLeftChar;

            EnableScrollBar(Handle, SB_HORZ, ESB_ENABLE_BOTH);
            if FScrollBarsAutoShowing in [ssHorizontal, ssBoth] then
              ShowScrollBar(Handle, SB_HORZ, true);
            SetScrollInfo(Handle, SB_HORZ, si, true);
          end
        else
          begin
            LeftChar := 0;
            EnableScrollBar(Handle, SB_HORZ, ESB_DISABLE_BOTH);
            si.cbSize := sizeof(Si);
            si.fMask := SIF_DISABLENOSCROLL or SIF_RANGE;
            si.nMin := 0;
            si.nMax := 0;
            if FScrollBarsAutoShowing in [ssHorizontal, ssBoth] then
              ShowScrollBar(Handle, SB_HORZ, false);
            SetScrollInfo(Handle, SB_HORZ, si, true);
          end;
      end;

  if (Flat and ((not (Focused or FMouseOver)) or (FlatFocusedScrollBars and
    (not FUseCustomScrollBars) or (not Multiline)))) or IsThemed then
    DrawFlatBorder;
end;

procedure TCustomElEdit.CMFontChanged(var Message: TMessage);
var
  LTextMetric: TLMDTextMetric;
  DC: HDC;
begin
  inherited;
//  FLineHeight := Canvas.TextHeight('Wp'); // at this point Canvas.Font <> Font!!!!!!!! This won't work for large fonts
  if HandleAllocated then
    LMDGetTextMetrics(Canvas.Handle, LTextMetric)
  else
  begin
    DC := GetDC(0);
    LMDGetTextMetrics(DC, LTextMetric);
    ReleaseDC(0, DC);
  end;
  FAscent := LTextMetric.tmAscent;
  FDescent := LTextMetric.tmDescent;

  FLineHeight := Abs(Font.Height) + 2;
  FLinesInRect := (FEditRect.Bottom - FTopMargin) div FLineHeight;
  if ((not FMultiline) and AutoSize) and
    (ComponentState * [csReading, csLoading, csDestroying] = []) then
    AdjustHeight;
  FElEditList.Reformat;
  SetScrollBarsInfo;
  if FHasCaret then
  begin
    DestroyCaret;
    MakeCaret;
    SetCaretPosition(CaretX, CaretY);
    ShowCaret(Handle);
  end;
end;

procedure TCustomElEdit.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    UpdateHeight;
  end;
end;

procedure TCustomElEdit.UpdateHeight;
begin
  if FAutoSize
// EK
//  and (BorderStyle = bsSingle)
  then
    ControlStyle := ControlStyle + [csFixedHeight]
//  else
//    ControlStyle := ControlStyle - [csFixedHeight];
end;

procedure TCustomElEdit.CreateWnd;

begin
  fSBCtrl.Control := nil;
  inherited;

  if fUseCustomScrollBars then
  begin
    fSBCtrl.Control := Self;
    if not fSBCtrl.Active then
    begin
      FUseCustomScrollBars := False;
      fSBCtrl.Control := nil;
    end;
  end;
  FCharsInView := 0;
  SetScrollBarsInfo;
  UpdateHeight;
  if (not (csLoading in ComponentState)) and (not Multiline) and AutoSize then
    AdjustHeight;
  SetEditRect(ClientRect);

  if Flat or IsThemed then
    DrawFlatBorder;
end;

{< ELSCROLLBAR}
procedure TCustomElEdit.DestroyWnd;
begin
  fSBCtrl.Control := nil;
  inherited;
end;

function TCustomElEdit.GetHorzScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_HORZ]);
end;

function TCustomElEdit.GetVertScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_VERT]);
end;

procedure TCustomElEdit.SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_HORZ].Assign(Value);
end;

procedure TCustomElEdit.SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_VERT].Assign(Value);
end;
{> ELSCROLLBAR}

procedure TCustomElEdit.BackgroundChanged(Sender: TObject);
begin
  Invalidate;
  Perform(CM_COLORCHANGED, 0, 0);
  end;

procedure TCustomElEdit.WMGetText(var Message: TWMGetText);
var
  S: String;
begin
  if (not Assigned(FElEditList)) or (Message.TextMax = 0) or (FPasswordChar <> #0) then
  begin
    Message.Result := 0;
  end
  else
  begin
    S := FElEditList.Text;
    if Length(S) > Message.TextMax - 1 then
      SetLength(S, Message.TextMax - 1);
    Message.Result := Length(S);
    Message.Text := PChar(S);
    end;
end;

procedure TCustomElEdit.WMGetTextLength(var Message: TWMGetTextLength);
begin
  if Assigned(FElEditList) then
    Message.Result := Length(FElEditList.Text)
  else
    Message.Result := 0;
end;

procedure TCustomElEdit.SetLines(Value: TLMDStrings);
begin
  FElEditList.Text := Value.Text;
end;

function TCustomElEdit.GetLines: TLMDStrings;
begin
  Result := FElEditList
end;

procedure TCustomElEdit.SetAlignBottom(Value: boolean);
begin
  if (FAlignBottom <> Value) and (not FMultiLine) then
  begin
    FAlignBottom := Value;
//    if FAlignBottom then
//      FTopMargin := FEditRect.Bottom - FLineHeight - 2
//    else
    if (ComponentState * [csLoading, csReading]) = [] then
      FTopMargin := 0;

    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
    Invalidate;
  end
  else
  if Multiline then
  begin
    FAlignBottom := Value;
    FTopMargin := 0;
    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
    Invalidate;
  end;
end;

procedure TCustomElEdit.SetTopMargin(Value: Integer);
begin
  if (FTopMargin <> Value) and (not FAlignBottom) then
  begin
    FTopMargin := Value;
    Invalidate;
    if FHasCaret then
      SetCaretPosition(CaretX, CaretY);
  end;
end;

(*
procedure TCustomElEdit.UpdateFrame;
var R : TRect;
begin
  if not HandleAllocated then exit;
  R := Rect(0, 0, Width, Height);
  RedrawWindow(Handle, @R, 0, rdw_Invalidate or rdw_Frame or rdw_UpdateNow or rdw_NoChildren);
end;
*)

procedure TCustomElEdit.CMMouseEnter(var Msg : TMessage);  { private }
begin
  inherited;
  FMouseOver := true;
  DoMouseEnter;
  if (Flat and not Focused) and (not IsThemed) then
    DrawFlatBorder;
  if (IsThemed and LMDSIWindowsVistaUp) and HandleAllocated then
  begin
    Paint;
    // SendMessage(Handle, WM_NCPAINT, 0, 0);
     SendMessage(Handle, WM_PAINT, 0, 0);
  end;
end;  { CMMouseEnter }

procedure TCustomElEdit.CMMouseLeave(var Msg : TMessage);  { private }
begin
  FMouseOver := false;
  if (Msg.LParam = 0) or (Msg.LParam = TLMDPtrInt(Self)) then
    begin
      if (Flat and not Focused) and (not IsThemed) then
        DrawFlatBorder;
      if (IsThemed and LMDSIWindowsVistaUp) and HandleAllocated then
      begin
        // SendMessage(Handle, WM_NCPAINT, 0, 0);
        SendMessage(Handle, WM_PAINT, 0, 0);
        Paint;
      end;

      DoMouseLeave;
    end;
  inherited;
end;  { CMMouseLeave }

procedure TCustomElEdit.DoMouseEnter;
begin
  if assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TCustomElEdit.DoMouseLeave;
begin
  if assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

procedure TCustomElEdit.Loaded;
begin
  inherited;
  //???
  //  S := FText;
//  FText := '';
//  Text := S;
  if not Multiline then
    Scrollbars := ssNone;
  SetScrollbarsInfo;
  if HandleAllocated then
  begin
    if (not Multiline) and AutoSize then
      AdjustHeight;
    SetEditRect(ClientRect);
  end;
//  DisplayOptionsChange(Self);
  UpdateLinkedControl;
end;

procedure TCustomElEdit.SetFlatFocusedScrollBars(const Value: boolean);
begin
  if FFlatFocusedScrollBars <> Value then
  begin
    FFlatFocusedScrollBars := Value;
    if (Focused) and  Multiline then
      DrawFlatBorder;
    end;
end;

procedure TCustomElEdit.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
      Invalidate;
  end;
end;

procedure TCustomElEdit.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
      Invalidate;
  end;
end;

procedure TCustomElEdit.EMSetRect(var Message: TMessage);
begin
  EditRect := (PRect(Message.lParam))^;
  Invalidate;
end;

procedure TCustomElEdit.EMSetRectNP(var Message: TMessage);
begin
  EditRect := (PRect(Message.lParam))^;
  end;

procedure TCustomElEdit.CMEnabledChanged(var Message: TMessage);

begin
  inherited;
  if IsThemed or UseDisabledColors then
  Invalidate;
end;

procedure TCustomElEdit.SetUseXPThemes(const Value: Boolean);
begin
  inherited;
  fSBCtrl.UseXPThemes := Value;
  if HandleAllocated then
  RecreateWnd;
end;

procedure TCustomElEdit.SetThemeGlobalMode(const Value: Boolean);
begin
  inherited;
  fSBCtrl.ThemeGlobalMode := Value;
  if HandleAllocated then
  RecreateWnd;
end;

procedure TCustomElEdit.SetThemeMode(const Value: TLMDThemeMode);
begin
  inherited;
  fSBCtrl.ThemeMode := Value;
  if HandleAllocated then
  RecreateWnd;
end;

procedure TCustomElEdit.OnHScroll(Sender: TObject; ScrollCode: TElScrollCode;
                                var ScrollPos: Integer; var DoChange : boolean);
begin
  if (FLeftChar <> ScrollPos) then
  begin
    if (scbHorz.Page + ScrollPos) > (FElEditList.FMaxLen) then
      LeftChar := FElEditList.FMaxLen - scbHorz.Page + 1
    else
      LeftChar := ScrollPos;

    DoChange := true;
    DrawFlatBorder;
    end;
end;

procedure TCustomElEdit.OnVScroll(Sender: TObject; ScrollCode: TElScrollCode;
                                var ScrollPos: Integer; var DoChange : boolean);
begin
  if (FTopLine <> ScrollPos) then
  begin
    TopLine := ScrollPos;
    DoChange := true;
    DrawFlatBorder;
    end;
end;

procedure TCustomElEdit.SBChanged(Sender: TObject);
begin
  if FUseCustomScrollBars then
  begin
    FScrollBars := ssNone;
    if (scbVert.Visible) and (scbHorz.Visible) then
      FScrollBars := ssBoth
    else
      if scbVert.Visible then
        FScrollBars := ssVertical
      else
        if scbVert.Visible then
          FScrollBars := ssHorizontal;
  end;
  SetScrollBarsInfo;
  Invalidate;
end;

procedure TCustomElEdit.SetUseCustomScrollBars(newValue : Boolean);
{ Sets data member FUseCustomScrollBars to newValue. }
begin
  if (FUseCustomScrollBars <> newValue) then
  begin
    FUseCustomScrollBars := newValue;
    if not (csDesigning in ComponentState) then
    begin
      {< ELSCROLLBAR}
      if fUseCustomScrollBars then
      begin
        fSBCtrl.Control := nil;
        fSBCtrl.Control := Self;
        if not fSBCtrl.Active then
        begin
          FUseCustomScrollBars := False;
          fSBCtrl.Control := nil;
          exit;
        end;
      end
      else
        fSBCtrl.Control := nil;
      {> ELSCROLLBAR}
      if Multiline then
      begin
        RecreateWnd;
        SetScrollBarsInfo;
      end;
    end;
  end;  { if }
end;  { SetUseCustomScrollBars }

procedure TCustomElEdit.InsertText(const AText: TLMDString);
var
  FX: Integer;
  FY: Integer;
  FPos: TPoint;
begin
  FX := CaretX;
  FY := CaretY;
  FPos := CaretXY;
  FElEditList.InsertText(FX, FY, AText);
  CaretY := FY;
  CaretX := FX;
  DoChange;
  if not NotifyUserChangeOnly then
    Change;
  RepaintText(FEditRect);
  if (FSelStartY <> CaretY) or (FSelStartX <> CaretX) then
  begin
    FSelStartY := CaretY;
    FSelStartX := CaretX;
    TriggerSelectionChangeEvent;
  end;
  FUndo.AddAction(atInsert, FPos, CaretXY, AText);
end;

procedure TCustomElEdit.DeleteSelection;
var
  bP, bPO: integer;
  eP, ePO: integer;
  FX, FY: integer;
  i: integer;
  {$IFDEF LMD_UNICODE}
  S: WideString;
  {$ELSE}
  S: String;
  {$ENDIF}
  FTstr: TLMDString;
begin
  if FSelected and (not ReadOnly) then
  begin
    FTstr := SelText;
    FElEditList.CaretToParagraph(FSelFirstX, FSelFirstY, bP, bPO);
    FElEditList.CaretToParagraph(FSelLastX, FSelLastY, eP, ePO);
    if eP = bP then
    begin
      S := FElEditList.FParagraphs.Items[bP].Text;
      {$IFDEF LMD_UNICODE}
      LMDWideDelete(S, bPO + 1, (ePO - bPO));
      {$ELSE}
      Delete(S, bPO + 1, (ePO - bPO));
      {$ENDIF}
      FElEditList.FParagraphs.Items[bP].Text := S;
    end
    else
    begin
      S := FElEditList.FParagraphs.Items[bP].Text;
      {$IFDEF LMD_UNICODE}
      LMDWideDelete(S, bPO + 1, Length(S));
      {$ELSE}
      Delete(S, bPO + 1, Length(S));
      {$ENDIF}
      FElEditList.FParagraphs.Items[bP].Text := S;
      for i := eP - 1 downto bP + 1 do
        FElEditList.FParagraphs.Delete(i);

      if bp < FElEditList.FParagraphs.Count -1 then
        S := FElEditList.FParagraphs.Items[bP + 1].Text
      else
        S := '';

      {$IFDEF LMD_UNICODE}
      LMDWideDelete(S, 1, ePO);
      {$ELSE}
      Delete(S, 1, ePO);
      {$ENDIF}
      FElEditList.FParagraphs.Items[bP].Text := FElEditList.FParagraphs.Items[bP].Text + S;

      if bp < FElEditList.FParagraphs.Count -1 then
        FElEditList.FParagraphs.Delete(bP + 1);
    end;
    FElEditList.ReformatParagraph(bP);
    FElEditList.ReCount(bP);
    FElEditList.CaretFromParagraph(bP, bPO, FX, FY);
//    FUndo.AddAction(atDeleteSel, CaretXY, Point(FX, FY), FTStr);
    FUndo.AddAction(atDeleteSel, Point(FSelStartX, FSelStartY), Point(FX, FY), FTStr);
    CaretY := FY;
    CaretX := FX;
    FSelStartY := CaretY;
    FSelStartX := CaretX;
    UnSelect;
  end;
end;

procedure TCustomElEdit.UnSelect;
begin
  if FSelected then
  begin
    FSelFirstX := FSelStartX;
    FSelFirstY := FSelStartY;
    FSelLastX := FSelStartX;
    FSelLastY := FSelStartY;
    FSelected := false;
    TriggerSelectionChangeEvent;
    RepaintText(EditRect);
  end;
end;

procedure TCustomElEdit.SetSelection(SelX, SelY: integer);
var
  FOldSelStartX: integer;
  FOldSelStartY: integer;
  FOldSelFirstX: integer;
  FOldSelFirstY: integer;
  FOldSelLastX: integer;
  FOldSelLastY: integer;
begin
  FOldSelStartX := FSelStartX;
  FOldSelStartY := FSelStartY;
  FOldSelFirstX := FSelFirstX;
  FOldSelFirstY := FSelFirstY;
  FOldSelLastX := FSelLastX;
  FOldSelLastY := FSelLastY;
//  if FSelected then
//  begin
    if SelY <= FSelStartY then
    begin
      FSelFirstY := SelY;
      FSelLastY := FSelStartY;
    end
    else
    begin
      FSelFirstY := FSelStartY;
      FSelLastY := SelY;
    end;
    if (SelY < FSelStartY) or ((SelX <= FSelStartX) and (SelY <= FSelStartY)) then
    begin
      FSelFirstX := SelX;
      FSelLastX := FSelStartX;
    end
    else
    begin
      FSelFirstX := FSelStartX;
      FSelLastX := SelX;
    end;
    FSelected := Boolean((FSelFirstX <> FSelLastX) or (FSelFirstY <> FSelLastY));

    if (FOldSelStartX <> FSelStartX) or (FOldSelStartY <> FSelStartY) or
       (FOldSelFirstX <> FSelFirstX) or (FOldSelFirstY <> FSelFirstY) or
       (FOldSelLastX <> FSelLastX) or (FOldSelLastY <> FSelLastY) then
    TriggerSelectionChangeEvent;

//    FSelected := true;
{  end
  else
  begin
    FSelStartX := SelX;
    FSelStartY := SelY;
    FSelFirstX := SelX;
    FSelFirstY := SelY;
    FSelLastX := SelX;
    FSelLastY := SelY;
    FSelected := true;
  end;}
end;

procedure TCustomElEdit.SetCharCase(Value: TElEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    if FCharCase <> eecNormal then
    begin
      if FCharCase = eecUppercase then
        Text := LMDUppercase(Text)
      else
        Text := LMDLowercase(Text);
    end;
  end;
end;

procedure TCustomElEdit.SetCueBanner(const Value: TLMDString);
begin
  if FCueBanner <> Value then
  begin
    FCueBanner := Value;
    Invalidate;
  end;
end;

{$IFDEF LMD_UNICODE}
{------------------------------------------------------------------------------}
procedure TCustomElEdit.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

{------------------------------------------------------------------------------}
procedure TCustomElEdit.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF LMD_UNICODE}

{------------------------------------------------------------------------------}
procedure TCustomElEdit.SetBottomAlign;
begin
  FTopMargin := 0;//FEditRect.Top + (FEditRect.Bottom - FEditRect.Top - FLineHeight) div 2;
end;

procedure TCustomElEdit.Scroll(ScrollDir : TElEditScrollDir);
var Msg : TWMVScroll;
begin
  Msg.Msg := WM_VSCROLL;
  Msg.Pos := 0;
  Msg.ScrollBar := SB_VERT;
  Msg.Result := 0;
  case ScrollDir of
    esdLineUp:
      Msg.ScrollCode := SB_LINEUP;
    esdLineDown:
      Msg.ScrollCode := SB_LINEDOWN;
    esdPageUp:
      Msg.ScrollCode := SB_PAGEUP;
    esdPageDown:
      Msg.ScrollCode := SB_PAGEDOWN;
  end;
  WMVSCroll(Msg);
  end;

procedure TCustomElEdit.SetMaxLevel(const Value: integer);
begin
  if Value >= 0 then
    FUndo.MaxUndo := Value;
end;

function TCustomElEdit.GetMaxLevel: integer;
begin
  Result := FUndo.MaxUndo;
end;

function TCustomElEdit.GetCanUndo: boolean;
begin
  Result := FUndo.CanUndo;
end;

function TCustomElEdit.CreateTextPainter: TElTextPainter;
begin
  Result := TElWinTextPainter.Create(Self);
  end;

procedure TCustomElEdit.ScrollCaret;
begin
  (*
  if Multiline and ((TopLine > Self.FCaretPos.y) or (TopLine + FLinesInRect <= TopLine)) then
    TopLine := Max(0, FCaretPos.y - FLinesInRect shr 1);
  if Multiline then
    SetScrollBarsInfo;

  RepaintText;
  *)
//  SetSelStart(SelStart);
  SetCaretPosition(CaretX, CaretY);
end;

function TCustomElEdit.GetText: TLMDString;
//var
//  {$IFDEF LMD_UNICODE}
//  S: WideString;
//  {$ELSE}
//  S: String;
//  {$ENDIF}
begin
  Result := FElEditList.Text;
//  {$IFDEF LMD_UNICODE}
//  Result := WideCopy(S, 1, Length(S){ - Length(ElFCRLF)});
//  {$ELSE}
//  Result := Copy(S, 1, Length(S){ - Length(ElFCRLF)});
//  {$ENDIF}
end;

function TCustomElEdit.ConvertToCRLF(Str : TLMDString): TLMDString;
var i, j : integer;
    ps, pd : PLMDChar;
    begin
  j := 0;
  for i := 1 to Length(Str) do
    if (Str[i] = #13) and (Str[i+1] <> #10) then
      inc(j);
  if (Length(Str) > 0) and (j > 0) then
  begin
    SetLength(Result, Length(Str) + j);
    ps := @Str[1];
    pd := @Result[1];
    while ps^ <> #0 do
    begin
      if ps^ = #13 then
      begin
        pd^ := ps^; inc(ps); inc(pd);
        if (ps^ <> #10) then
        begin
          pd^ := #10;
          inc(pd);
        end;
      end
      else
      begin
        pd^ := ps^; inc(ps); inc(pd);
      end;
    end;
    end
  else
    Result := Str;
end;

procedure TCustomElEdit.EMCanUndo(var Message: TMessage);
begin
  Message.Result := TLMDPtrInt(CanUndo);
end;

procedure TCustomElEdit.EMUndo(var Message: TMessage);
begin
  Message.Result := TLMDPtrInt(CanUndo);
  ExecuteCommand(eecUndo, #0, nil);
end;

procedure TCustomElEdit.AdjustFocusedRect(var aRect: TRect);
begin
 //do nothing here
end;

procedure TCustomElEdit.AdjustHeight;
var
  DC: HDC;
  SaveFont: HFont;
  SysMetrics: TLMDTextMetric;
  I: Integer;
  Metrics: TLMDTextMetric;
begin
  if not FMultiline then
  begin
    DC := GetDC(0);
    LMDGetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    LMDGetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
    ReleaseDC(0, DC);
// EK
//    if BorderStyle = bsSingle then
//    begin
      if Ctl3D then
        I := GetSystemMetrics(SM_CYEDGE) * 4
      else
        I := GetSystemMetrics(SM_CYBORDER) * 6;
//    end
//    else
//    I := 0;
    Height := Metrics.tmHeight + I;
    // FLinesInRect := (FEditRect.Bottom - FTopMargin) div FLineHeight;
//    if (FAlignBottom) then
//      SetBottomAlign;
  end;
end;

procedure TCustomElEdit.WMKeyDown(var Msg : TWMKeyDown); { private }
{$IFDEF LMD_UNICODE}
var KeyState: TKeyboardState;
    Len : Integer;
    ACharCode : integer;

    s : WideString;

    {.............................................................}
    function IsSpecialLanguage: Boolean;
    var Language: Integer;
    begin
      Language := (GetKeyboardLayout(0) and $FFFF);
      Result := (Language = $0439) {or  //Hindi
                (Language = $0404) or  //Chinese (Taiwan)
                (Language = $0804) or  //Chinese (PRC)
                (Language = $0c04) or  //Chinese (Hong Kong)
                (Language = $1004)};   //Chinese (Singapore)

    end;
    {.............................................................}
{$ENDIF}
begin
  if (Msg.CharCode = VK_RETURN) and (KeyDataToShiftState(Msg.KeyData) = [ssCtrl]) and Multiline then
  begin
    SendMessage(Handle, WM_CHAR, TMessage(Msg).wParam, TMessage(Msg).lParam);
    Msg.CharCode := 0;
    exit;
  end;

  {$IFDEF LMD_UNICODE}

  Len := 0;
  if LMDSIWindowsNTUp {and IsSpecialLanguage } then
  begin
    // Manual translation of key codes to Unicode
    // if Msg.CharCode in [ord('A')..ord('Z'),ord('0')..ord('9'),187..192,220] then

    if not (Msg.CharCode in [8, 9, 13, 27]) then
    begin
      SetLength(s, 5);
      if GetKeyboardState(KeyState) and ((KeyState[VK_CONTROL] and $80)=0) then
      begin
        ACharCode := Msg.CharCode;
// Remark for input numpad digits.
//        if ACharCode in [VK_NUMPAD0 .. VK_NUMPAD9] then
//          ACharCode := Msg.CharCode - VK_NUMPAD0 + ord('0');
        Len := ToUnicode(ACharCode, Msg.KeyData, KeyState, PWideChar(s)^, 5, 0);
        if Len > 1 then
        begin
          SetLength(s, Len);
          if (FDeadChar <> #0) then
          begin
            if FCDead >= 1 then
            begin
              FKeys := s;
              FKeyDown := true;
              SendMessage(Handle, WM_CHAR, Word(FDeadChar), 0);
              FDeadChar := #0;
              FCDead := 0;
            end
            else
              Inc(FCDead);
          end
          else
          begin
            FKeys := s;
            FKeyDown := true;
          end;
        end
        else
        // Dead char support
        if (FDeadChar <> #0) and (Len = 1) then
        begin
          FKeys := FDeadCharList.GetDeadChar(s[1], FDeadChar);
          if FKeys = WideChar(0) then
          begin
            SetLength(s, 2);
            s[2] := s[1];
            s[1] := WideChar(FDeadChar);
            FKeys := s;
          end;
          FDeadChar := #0;
        end
        else
        if Len > 0 then
        begin
          SetLength(s, Len);
          FKeys := s;
          FKeyDown := true;
        end;
      end;
    end;
  end;

  if Len <= 0 then
    inherited
  else
  begin
    inherited;
    Msg.CharCode := 0;
    Msg.Result   := 0;
  end;
  {$ELSE}
  inherited;
  {$ENDIF}
end;

procedure TCustomElEdit.KeyDown(var Key: Word; Shift: TShiftState); { private }
var
  LCommand: TElCommand;

begin
  inherited KeyDown(Key, Shift);

  if FSelecting then
    exit;

  if (not FMultiline) then
  begin
    case Key of
      VK_DOWN : Key := VK_RIGHT;
      VK_UP : Key := VK_LEFT;
      VK_PRIOR : Key := VK_HOME;
      VK_NEXT : Key := VK_END;
    end;
  end;

  if RightAlignedText then
  begin
    case Key of
    VK_LEFT: Key := VK_RIGHT;
    VK_RIGHT: Key := VK_LEFT;
    VK_HOME: Key := VK_END;
    VK_END: Key := VK_HOME;
    end;
  end;

  if FFirstKey > 0 then
  begin
    LCommand := FCommandCenter.Find(Key, Shift, FFirstKey, FFirstShift);
    CommandCenter(LCommand, #0, nil);
    FFirstKey := 0;
    FFirstShift := [];
  end
  else
  begin
    LCommand := FCommandCenter.Find(Key, Shift);
    if LCommand = eecWaitForSecondKey then
    begin
      FFirstKey := Key;
      FFirstShift := Shift;
    end
    else
      if LCommand <> eecNone then
      begin
        CommandCenter(LCommand, #0, nil);
        //Key := 0;
      end
  end;
end; { KeyDown }

//----> 24.01.07 Add ShortCut to Stress Sign
procedure TCustomElEdit.SetStressShortCut(Value: TShortCut);
var LKey: word;
    LShift: TShiftState;
begin
  if Value <> FStressShortCut then
  begin
    FStressShortCut := Value;

    ShortCutToKey(Value,LKey,LShift);
    FCommandCenter.Delete(eecSetStress);
    FCommandCenter.Add(LKey,LShift,eecSetStress,'Set stress sign');
  end;

end;
//<---- 24.01.07

procedure TCustomElEdit.SetEditRect(Value : TRect);
begin
  begin
    if scbVert.Visible then
    begin
      if RightAlignedView then
        //Value.Left := WidthRect(scbVert.ScrollBarRect)
        else
        //Value.Right := Value.Right - WidthRect(scbVert.ScrollBarRect);
        end;
  end;
  begin
    if scbHorz.Visible then
      //Value.Bottom := Value.Bottom - HeightRect(scbHorz.ScrollBarRect);
      end;
  DoSetEditRect(Value);
end;

procedure TCustomElEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  //if not HandleAllocated then
  //  SetEditRect(Rect(0, 0, AWidth, AHeight));
end;

procedure TCustomElEdit.TriggerAfterCommand(AData: Pointer; AChar: Char; ACommand: TElCommand);
begin
  if Assigned(FOnAfterCommand) then
    FOnAfterCommand(Self, ACommand, AChar, AData);
end;

procedure TCustomElEdit.TriggerBeforeCommand(AData: Pointer; AChar: Char; ACommand: TElCommand);
begin
  if Assigned(FOnBeforeCommand) then
    FOnBeforeCommand(Self, ACommand, AChar, AData);
end;

procedure TCustomElEdit.CMCtl3DChanged(var Msg : TMessage);
begin
  inherited;
  if HandleAllocated then
    SetEditRect(ClientRect);
  AdjustHeight;
  Repaint;
end; { CMCtl3DChanged }

function TCustomElEdit.ScrollBarStylesStored: Boolean;
begin
  Result := Multiline and UseCustomScrollBars;
end;

procedure TCustomElEdit.DefineProperties(Filer : TFiler);
begin
  inherited;
  Filer.DefineProperty('LinkControlPosition', ReadLinkCtlPos, nil, false);
  Filer.DefineProperty('RTLContent', ReadRTLContent, nil, false);
  Filer.DefineProperty('ChangeDisabledText', ReadChangeDisabledText, nil, false);
end;

procedure TCustomElEdit.ReadRTLContent(Reader : TReader);
begin
  RightAlignedText := Reader.ReadBoolean;
end;

procedure TCustomElEdit.SetRightAlignedView(Value: Boolean);
begin
  if FRightAlignedView <> Value then
  begin
    FRightAlignedView := Value;
    RecreateWnd;
    end;
end;

procedure TCustomElEdit.SetRightAlignedText(Value: Boolean);
begin
  if FRightAlignedText <> Value then
  begin
    FRightAlignedText := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElEdit.SetFocusedSelectColor(Value: TColor);
begin
  if (FFocusedSelectColor <> Value) then
  begin
    FFocusedSelectColor := Value;
    if (Focused or (not FHideSelection)) then Invalidate;
  end;  {if}
end;

procedure TCustomElEdit.SetFocusedSelectTextColor(Value: TColor);
begin
  if (FFocusedSelectTextColor <> Value) then
  begin
    FFocusedSelectTextColor := Value;
    if (Focused or (not FHideSelection)) then Invalidate;
  end;  {if}
end;

procedure TCustomElEdit.SetHideSelectColor(Value: TColor);
begin
  if (FHideSelectColor <> Value) then
  begin
    FHideSelectColor := Value;
    if not Focused and not FHideSelection then Invalidate;
  end;  {if}
end;

procedure TCustomElEdit.SetHideSelectTextColor(Value: TColor);
begin
  if (FHideSelectTextColor <> Value) then
  begin
    FHideSelectTextColor := Value;
    if not Focused and not FHideSelection then Invalidate;
  end;  {if}
end;

procedure TCustomElEdit.DoChange;
begin
  // intentionally left blank
end;

procedure TCustomElEdit.SetHighlightAlphaLevel(Value: Integer);
begin
  if FHighlightAlphaLevel <> Value then
  begin
    FHighlightAlphaLevel := Value;
  end;
end;

{ ---------------------------------------------------------------------------- }
//Validation support, November 2007, RS
{ ---------------------------------------------------------------------------- }
function TCustomElEdit.GetControlBackBrush: TBrush;
begin
  Result := Self.Brush;
end;

{ ---------------------------------------------------------------------------- }
function TCustomElEdit.GetControl: TControl;
begin
  Result := Self;
end;

{ ---------------------------------------------------------------------------- }
function TCustomElEdit.GetControlFont: TFont;
begin
  Result := Self.Font;
end;

{ ---------------------------------------------------------------------------- }
function TCustomElEdit.GetValidationMsgString: TLMDString;
begin
  Result := Self.FValidationMsgString;
end;

{ ---------------------------------------------------------------------------- }
function TCustomElEdit.GetValueToValidate: TLMDString;
begin
  Result := Self.Text;
end;

{ ---------------------------------------------------------------------------- }
procedure TCustomElEdit.RespondToError(ErrorLevel: TLMDErrorLevel);
begin
  FErrorIndication := ErrorLevel > 0;
  if Assigned(FOnValidationError) and FErrorIndication then
    FOnValidationError(self, ErrorLevel);
end;

{ ---------------------------------------------------------------------------- }
procedure TCustomElEdit.SetValidationMsgString(val: TLMDString);
begin
  Self.FValidationMsgString := val;
end;

{ ---------------------------------------------------------------------------- }
procedure TCustomElEdit.SetValidator(Validator: TLMDValidationEntity);
begin
  if Self.FValidator = Validator then Exit;
//  if Assigned(Self.FValidator) then
//    Self.FValidator.ReleaseControl(Self);
  Self.FValidator := Validator;
  if Assigned(Self.FValidator) then
    begin
      Validator.FreeNotification(Self);
  //    Self.FValidator.AcceptControl(Self);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TCustomElEdit.SupportsDefaultIndication: boolean;
begin
  Result := false;
end;

{ ---------------------------------------------------------------------------- }
function TCustomElEdit.GetValidator: TLMDValidationEntity;
begin
  Result := Self.FValidator;
end;

{ TElEditStrings }

function TElEditStrings.Get(Index: integer): TLMDBaseString;
begin
  Result := FParagraphs.Items[Index].Text;
end;

procedure TElEditStrings.Put(Index: Integer; const S: TLMDBaseString);
begin
  Changing;
  FParagraphs.Items[Index].Text := S;
  Changed;
end;

procedure TElEditStrings.PutObject(Index: Integer; AObject: TObject);
begin
  ;
end;

function TElEditStrings.GetObject(Index: Integer): TObject;
begin
  Result := nil;
end;

function TElEditStrings.GetCount: integer;
begin
  Result := FParagraphs.Count;
end;

function TElEditStrings.CutString(var S: TLMDString;
                   Len: integer; var RealStr: boolean): TLMDString;
var
  CRLFPos : integer;
begin
  if Len = 0 then
  begin
    result := '';
    exit;
  end;
  if not FElEdit.RightAlignedText then
  begin
    {$IFDEF LMD_UNICODE}
    CRLFPos := LMDWidePos(ElFCR, S);
    {$ELSE}
    CRLFPos := Pos(#13, S);
    {$ENDIF}

    if Len = Length(S) then
      Dec(Len);

    if (((CRLFPos = 0) or (CRLFPos > Len)) and (FElEdit.FWordWrap and FElEdit.Multiline) and
      (Length(S) > Len{ + 1})) then
    begin
      CRLFPos := Len;
      // trim line by word boundary
      while CRLFPos > 1 do
        if (S[CRLFPos] = #32) or (S[CRLFPos] = #9) then
          break
        else
          dec(CRLFPos);
      if CRLFPos = 1 then
        CRLFPos := Len;
      // to do
      (*      {$IFDEF LMD_UNICODE}
      LMDWideInsert(ElFCR, WideString(S), CRLFPos);
      {$ELSE}
      Insert(ElFCR, S, CRLFPos);
      {$ENDIF}*)
    end;

    Result := Copy(S, CRLFPos + 1, Length(S));
    S := Copy(S, 1, CRLFPos);
  end
  else
  begin
    {$IFDEF LMD_UNICODE}
    CRLFPos := LMDWideLastPos(ElFCR, S);
    {$ELSE}
    CRLFPos := LMDAnsiLastPos(#13, S);
    {$ENDIF}

    if (((CRLFPos = 0) or ((Length(S) - CRLFPos) - 1 > Len)) and FElEdit.FWordWrap and
      FElEdit.Multiline) then
    begin
      RealStr := false;
      CRLFPos := Length(S) - Len;
      // Cut string on boundary of word
      while CRLFPos < Length(S) do
        if S[CRLFPos] = #32 then
          break
        else
          inc(CRLFPos);
    end
    else
      RealStr := Boolean(RealStrings.IndexOf(IntToStr(Count - 1)) < 0);

    {$IFDEF LMD_UNICODE}
    Result:=Copy(S, 1, CRLFPos - 1);
    S:=Copy(S, CRLFPos + 1, Length(S));
    {$ELSE}
    Result:=System.Copy(S, CRLFPos - 1, Length(S));
    S:=System.Copy(S, 1, CRLFPos);
    {$ENDIF}
  end;
end;

procedure TElEditStrings.IndexToParagraph(index: integer; var Paragraph, ParaIndex: integer);
var
  FBegin, FMiddle, FEnd: integer;
begin
  Paragraph := 0;
  ParaIndex := 0;
  FBegin := 0;
  FEnd := FParagraphs.Count - 1;
  while FBegin <= FEnd do
  begin
    FMiddle := (FBegin + FEnd) shr 1;
    if Index > FParagraphs.Items[FMiddle].FPCount + (FParagraphs.Items[FMiddle].Count - 1) then
      FBegin := FMiddle + 1
    else
    begin
      FEnd := FMiddle - 1;
      if (Index >= FParagraphs.Items[FMiddle].FPCount) and
         (Index <= (FParagraphs.Items[FMiddle].FPCount + FParagraphs.Items[FMiddle].Count - 1)) then
      begin
        Paragraph := FMiddle;
        ParaIndex := Index - FParagraphs.Items[FMiddle].FPCount;
        FBegin := FEnd + 1;
      end;
    end;
  end;
end;

procedure TElEditStrings.CaretToParagraph(ACaretX, ACaretY: integer; var Paragraph, ParaOffs: integer);
var
  i, PI: integer;
begin
  IndexToParagraph(ACaretY, Paragraph, PI);
  ParaOffs := ACaretX;
  for i := 0 to PI - 1 do
    ParaOffs := ParaOffs + Length(FParagraphs.Items[Paragraph].Strings[i]);
  if ParaOffs > Length(Strings[Paragraph]) then
    ParaOffs := Length(Strings[Paragraph]);
  if ParaOffs < 0 then
    ParaOffs := 0;
end;

procedure TElEditStrings.CaretFromParagraph(Paragraph, ParaOffs: integer; var ACaretX,
  ACaretY: integer);
var
  FLen, i: integer;
begin
  ACaretY := FParagraphs.Items[Paragraph].FPCount;
  FLen := Length(FParagraphs.Items[Paragraph].Strings[0]);
  i := 1;
  while ((ParaOffs > FLen) and (FParagraphs.Items[Paragraph].Count > i)) do
  begin
    FLen := FLen + Length(FParagraphs.Items[Paragraph].Strings[i]);
    inc(i);
  end;
  ACaretY := ACaretY + (i - 1);
  ACaretX := abs(FLen - Length(FParagraphs.Items[Paragraph].Strings[i - 1]) - ParaOffs);
  if ACaretX < 0 then
    ACaretX := -1;
end;

function TElEditStrings.GetParaCount: integer;
begin
  if FParagraphs.Count > 0 then
    Result := FParagraphs.Items[FParagraphs.Count - 1].FPCount +
      FParagraphs.Items[FParagraphs.Count - 1].Count
  else
    Result := 0;
end;

function TElEditStrings.GetParaString(Index: integer): TLMDString;
var
  P, Pi: integer;
begin
  IndexToParagraph(Index, P, Pi);
  if FParagraphs.Count > 0 then
    Result := FParagraphs.Items[P].Strings[Pi]
  else
    Result := '';
end;

procedure TElEditStrings.SetParaString(Index: integer; const Value: TLMDString);
var
  P, Pi: integer;
begin
  IndexToParagraph(Index, P, Pi);
  if FParagraphs.Count = 0 then
  begin
    if Index > 0 then
      EElEditorError.CreateFmt('List index outbound (%d)', [Index])
    else
      FParagraphs.Items[P].Strings[Pi] := Value;
  end
  else
  begin
    FParagraphs.Items[P].Strings[Pi] := Value;
    ReformatParagraph(P);
    ReCount(P);
  end;
end;

procedure TElEditStrings.ReCount(Index: integer);
var
  i: integer;
begin
  for i := Index to FParagraphs.Count - 1 do
  begin
    if i = 0 then
      FParagraphs.Items[i].FPCount := 0
    else
      FParagraphs.Items[i].FPCount := FParagraphs.Items[i - 1].FPCount +
        FParagraphs.Items[i - 1].Count;
  end;
  FElEdit.SetScrollBarsInfo;
end;

procedure TElEditStrings.ReformatParagraph(Index: integer);
var
  T: TLMDString;
  S: TLMDString;
  StartPos, i : integer;
  FPara: TElParagraph;
  RStr: boolean;
  FChars: integer;
begin
  FPara := FParagraphs.Items[Index];
  S := FPara.Text;
  FPara.Clear;
  FPara.Add('');
  if Index = FIdxMaxLen then
    FMaxLen := 0;
  if FElEdit.WordWrap and FElEdit.Multiline then
  begin
    i := 0;
    while (i <= FPara.Count - 1) do
    begin
      StartPos := 0;
      if (FElEdit.FTextPainter.TextSize(S).cx + 2) >= (FElEdit.EditRect.Right - FElEdit.RightMargin) then
      begin
        FChars := FElEdit.CharsFitRight((FElEdit.FEditRect.Right - FElEdit.FRightMargin) -
          (FElEdit.EditRect.Left + FElEdit.FLeftMargin), S, StartPos);
        T := CutString(S, FChars, RStr);
        FPara.Put(i, S);
        FPara.Insert(i + 1, T);
        S := T;
      end
      else
        if i = 0 then
          FPara.Put(i, S);
      Inc(i);
    end;
  end
  else
  begin
    i := Length(S);
    if FMaxLen < i then
    begin
      FMaxLen := i;
      FIdxMaxLen := Index;
      FMaxStr := S;
    end;
    FPara.Put(0, S);
  end;
end;

procedure TElEditStrings.Reformat;
var
  i: integer;

begin
  FMaxLen := 0;
  FIdxMaxLen := 0;
  FMaxStr := '';
  for i := 0 to FParagraphs.Count - 1 do
    ReformatParagraph(i);
  FElEdit.SetScrollBarsInfo;
end;

procedure TElEditStrings.Changed;

begin
  inherited;
  if Assigned(FOnChange) then
    FOnChange(Self);
  if FElEdit.HandleAllocated then
  InvalidateRect(FElEdit.Handle, @FElEdit.FEditRect, FElEdit.HasCustomBackground);
  end;

function TElEditStrings.GetTextStr: TLMDBaseString;
var
  I, L, Size, Count: Integer;

  {$IFDEF LMD_UNICODE}
  P: PWideChar;
  S: WideString;
  {$ELSE}
  P: PChar;
  S: String;
  {$ENDIF}
begin
  Count := GetCount;
  Size := 0;
  for I := 0 to Count - 1 do
    Inc(Size, Length(FParagraphs.Items[i].Text) + 2);
  if Size >= 2 then
    Dec(Size, 2);
  SetLength(Result, Size);
  {$IFDEF LMD_UNICODE}
  P := PWideChar(Result);
  {$ELSE}
  P := PChar(Result);
  {$ENDIF}
  for I := 0 to Count - 1 do
  begin
    S := FParagraphs.Items[i].Text;
    L := Length(S);
    if L <> 0 then
    begin
    {$IFDEF LMD_UNICODE}
      LMDWideMove(S[1], P^, L);
      {$ELSE}
      System.Move(S[1], P^, L);
      {$ENDIF}
      Inc(P, L);
    end;
    if (i < Count - 1) then
    begin
    P^ := #13;
      Inc(P);
      P^ := #10;
      Inc(P);
    end
  end;
  end;

{$IFDEF LMD_UNICODE}
procedure TElEditStrings.SetTextStr(const Value: TLMDBaseString);
var
  S: WideString;
  P, Start: PWideChar;
  {$ELSE}
procedure TElEditStrings.SetTextStr(const Value: TLMDBaseString);
var
  S: String;
  P, Start: PChar;
  {$ENDIF}
  i: integer;
begin
  if (Text <> Value) or (FElEdit.FUpdate) then
  begin
    if FElEdit.Multiline then
    begin
      BeginUpdate;
      try
        Clear;
        FParagraphs.Clear;
        {$IFDEF LMD_UNICODE}
        P := PWideChar(Value);
        {$ELSE}
        P := PChar(Value);
        {$ENDIF}
        i := 0;
        if P <> nil then
          while P^ <> #0 do
          begin
            Start := P;
            while not ((P^ = #0) or (P^ = #13) or (P^ = #10)) do
              Inc(P);
        // of IFNDEF CLR
            {$IFDEF LMD_UNICODE}
              LMDWideSetString(S, Start, (P - Start));
              {$ELSE}
              SetString(S, Start, (P - Start));
              {$ENDIF}
            FParagraphs.Add(TElParagraph.Create);
            //FParagraphs.Items[i].FCanvas := FElEdit.Canvas;
            FParagraphs.Items[i].Text := S;
            if (P^ = #13) and ((P + 1)^ = #10) then
            begin
              inc(P, 2);
              if P^ = #0 then
                FParagraphs.Insert(i + 1, TElParagraph.Create);
            end
            else
              if (P^ <> #0) then
                inc(P, 1);
            inc(i);
            end;
      finally
        EndUpdate;
      end;
      Reformat;
      ReCount(0);
    end
    else
    begin
      BeginUpdate;
      try
        Clear;
        FParagraphs.Clear;
        FParagraphs.Items[0].Put(0, Value);
      finally
        EndUpdate;
      end;
    end;
  end;
  (*
  if FElEdit.HandleAllocated then
  begin
    FElEdit.CaretY := 0;
    FElEdit.CaretX := 0;
    FElEdit.LeftChar := 0;
    FElEdit.TopLine := 0;
  end
  else
  *)
  with FElEdit do
  begin
    FCaretY := 0;
    FCaretX := 0;
    FLeftChar := 0;
    FTopLine := 0;

    FSelFirstX := FSelStartX;
    FSelFirstY := FSelStartY;
    FSelLastX := FSelStartX;
    FSelLastY := FSelStartY;
    FSelected := false;
  end;
end;

function TElEditStrings.GetReText: TLMDString;
var
  i: integer;
  ReStr: TLMDString;
begin
  for i := Count - 1 downto 0 do
  begin
    ReStr := ReStr + ParagraphStrings[i];
    if ((RealStrings.IndexOf(IntToStr(i)) >= 0) and (i > 0)) then
      ReStr := ReStr + ElFCR;
  end;
  Result := ReStr;
end;

constructor TElEditStrings.Create;
begin
  inherited;
  // to do
  RealStrings := TStringList.Create;
  FParagraphs := TElParagraphList.Create;
end;

destructor TElEditStrings.Destroy;
begin
  RealStrings.Free;
  FParagraphs.Free;
  inherited;
end;

procedure TElEditStrings.Delete(Index: integer);
begin
  Changing;
  FParagraphs.Delete(Index);
  ReCount(Index);
  Changed;
end;

procedure TElEditStrings.Exchange(Index1, Index2: Integer);
begin
  Changing;
  FParagraphs.Exchange(Index1, Index2);
  Changed;
end;

procedure TElEditStrings.Clear;
begin
  Changing;
  inherited;
  FParagraphs.Clear;
  Changed;
end;

{$IFDEF LMD_UNICODE}
procedure TElEditStrings.AddStrings(Strings: TLMDWideStrings);
{$ELSE}
procedure TElEditStrings.AddStrings(Strings: TStrings);
{$ENDIF}
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Strings.Count - 1 do
      Add(Strings[I]);
  finally
    EndUpdate;
  end;
end;

function TElEditStrings.Add(const S: TLMDBaseString): Integer;
begin
  if FParagraphs.Count > 0 then
    Result := FParagraphs.Count
  else
    Result := 0;
  Insert(Result, S);
end;

function TElEditStrings.Find(const S: TLMDBaseString; var Index: Integer): boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    {$IFDEF LMD_UNICODE}
    C := LMDWideCompareText(Get(i), S);
    {$ELSE}
    C := AnsiCompareText(Get(i), S);
    {$ENDIF}
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

procedure TElEditStrings.Insert(Index: Integer; const S : TLMDBaseString);
var
  {$IFDEF LMD_UNICODE}

  P, Start: PWideChar;

  S1: WideString;
  {$ELSE}

  P, Start: PChar;

  S1: String;
  {$ENDIF}
  i: integer;
  begin
  Changing;
  if FElEdit.FMultiline then
  begin
  {$IFDEF LMD_UNICODE}
    if s = '' then
      P := PWideChar(TLMDString(#13#10))
    else
      P := PWideChar(S);
    {$ELSE}
    if s = '' then
      P := PChar(#13#10)
    else
      P := PChar(S);
    {$ENDIF}
  i := Index;
    while (P^ <> #0) do
    begin
      Start := P;
      while not ((P^ = #13) or (P^ = #10) or (P^ = #0)) do
        Inc(P);
      {$IFDEF LMD_UNICODE}
      LMDWideSetString(S1, Start, (P - Start));
      {$ELSE}
      SetString(S1, Start, (P - Start));
      {$ENDIF}
    // OF ifndef CLR
      FParagraphs.Insert(i, TElParagraph.Create);
      FParagraphs.Items[i].Text := S1;
      ReformatParagraph(i);
      if (P^ = #13) and ((P + 1)^ = #10) then
      begin
        inc(P, 2);
        if (P^ = #0) and (s <> '') then
          FParagraphs.Insert(i + 1, TElParagraph.Create);
      end
      else
        if (P^ <> #0) then inc(P, 1);
      inc(i);
      end;
    ReCount(Index);
  end;
  Changed;
end;

procedure TElEditStrings.InsertText(var ACaretX, ACaretY: integer; const S: TLMDBaseString);
var
  {$IFDEF LMD_UNICODE}
  P, Start: PWideChar;
  S1, D, S2: WideString;
  {$ELSE}
  P, Start: PChar;
  S1, D, S2: String;
  {$ENDIF}
  PA, PO: integer;
  CountBefore: integer;
  FFlag: boolean;
  S2Len: Integer;
  begin
  Changing;
  S2Len := -1;
  FFlag := false;
  CountBefore := Count;
  CaretToParagraph(ACaretX, ACaretY, PA, PO);
  D := Get(PA);

  {$IFDEF LMD_UNICODE}
  P := PWideChar(S);
  {$ELSE}
  P := PChar(S);
  {$ENDIF}
  Start := P;
  while not ((P^ = #13) or (P^ = #10) or (P^ = #0)) do
    Inc(P);
  {$IFDEF LMD_UNICODE}
  LMDWideSetString(S1, Start, (P - Start));
  {$ELSE}
  SetString(S1, Start, (P - Start));
  {$ENDIF}
  if (P^ = #13) and ((P + 1)^ = #10) then
  begin
    if (P + 2)^ <> #0 then
      inc(P, 2)
    else
      FFLag := true;
  end
  else
    if (P^ <> #0) then inc(P, 1);
  if (P^ <> #0) or (S = ElFCRLF) then

  begin
    {$IFDEF LMD_UNICODE}
    S2 := Copy(D, PO + 1, Length(D));
    LMDWideDelete(D, PO + 1, Length(D));
    {$ELSE}
    S2 := System.Copy(D, PO + 1, Length(D));
    System.Delete(D, PO + 1, Length(D));
    {$ENDIF}
    S2Len := Length(S2);
    if not FFlag then
      S2 := P + S2;
    Insert(PA + 1, S2);
  end;
  {$IFDEF LMD_UNICODE}
  LMDWideInsert(S1, D, PO + 1);
  {$ELSE}
  System.Insert(S1, D, PO + 1);
  {$ENDIF}
  FParagraphs.Items[PA].Text := D;
  ReformatParagraph(PA);
  ReCount(PA);
  if S2Len >= 0 then
  begin
    PA := PA + (Count - CountBefore);
    if CountBefore = 0 then
      Dec(PA);
    PO := Length(Strings[PA]) - S2Len;
  end
  else
    PO := PO + Length(S1);
  CaretFromParagraph(PA, PO, ACaretX, ACaretY);
  Changed;
end;
{ TElParagraph }

procedure TElParagraph.SetTextStr(const Value: TLMDBaseString);
begin
  inherited;
end;

function TElParagraph.Get(Index: Integer): TLMDBaseString;
begin
  if ((Count = 0) and (Index = 0)) then
    Add('');
  Result := inherited Get(IndeX);
end;

procedure TElParagraph.Put(Index: Integer; const S: TLMDBaseString);
begin
  if ((Count = 0) and (Index = 0)) then
    Add('');
  inherited Put(Index, S);
end;

function TElParagraph.GetTextStr: TLMDBaseString;
var
  i: integer;
begin
//  Result := inherited GetTextStr;
  Result := '';
  for i := 0 to Count - 1 do
    Result := Result + Get(i);
end;

{$ifdef LMD_ELUNISCRIBE}
procedure TElParagraph.FreeStringAnalyse;
begin
  ScriptStringFree(@FScriptStringAnalysis);
end;

procedure TElParagraph.GetStringAnalyse(ACanvas: TCanvas; AStrNo: Integer = -1);
var
  AText: TLMDString;
begin
  if AStrNo = -1 then
    AText := Text
  else
    AText := Get(AStrNo);
  ScriptStringAnalyse(ACanvas.Handle, PWideChar(AText), Length(AText),
        Length(AText) * 2,
        -1,       // Unicode string
        SSA_GLYPHS or SSA_FALLBACK,
        0,        // no clipping
        @FScriptControl,
        @FScriptState,
        nil,
        nil,
        nil,
        @FScriptStringAnalysis);
end;

procedure TElParagraph.Draw(ACanvas: TCanvas; AX, AY: Integer; ASelStart, ASelEnd, AStrNo: Integer);
begin
  GetStringAnalyse(ACanvas, AStrNo);

  if Assigned(FScriptStringAnalysis) then
  begin
    ScriptStringOut(
        FScriptStringAnalysis,
        AX,
        AY,
        0,
        nil,
        ASelStart,
        ASelEnd,
        FALSE);

    FreeStringAnalyse;
  end;
end;

function TElParagraph.GetStrSize(ACanvas: TCanvas; AStrNo: integer): TSize;
begin
  Result := TSize(Point(0, 0));
  GetStringAnalyse(ACanvas, AStrNo);
  if Assigned(FScriptStringAnalysis) then
  begin
    Result.cx := ScriptString_pSize(FScriptStringAnalysis).cx;
    Result.cy := ScriptString_pSize(FScriptStringAnalysis).cy;
    FreeStringAnalyse;
  end;
end;

function TElParagraph.GetXFromOffset(ACanvas: TCanvas; AOffset: Integer; AStrNo: Integer = -1): Integer;
begin
  Result := 0;
  GetStringAnalyse(ACanvas, AStrNo);
  if Assigned(FScriptStringAnalysis) then
  begin
    ScriptStringCPtoX(FScriptStringAnalysis, AOffset, True, @Result);
    FreeStringAnalyse;
  end;
end;

function TElParagraph.GetOffsetFromX(ACanvas: TCanvas; AX: Integer): Integer;
var
  LTrailing: PInteger;
begin
  Result := 0;
  GetStringAnalyse(ACanvas);
  if Assigned(FScriptStringAnalysis) then
  begin
    if AX < 0 then
      AX := 0;
    ScriptStringXtoCP(FScriptStringAnalysis, AX, @Result, @LTrailing);
    FreeStringAnalyse;
  end;
end;
{$endif}

{ TElParagraphList }

function TElParagraphList.Get(Index: Integer): TElParagraph;
begin
  if ((Count = 0) and (Index = 0)) then
    Add(TElParagraph.Create);
  Result := TElParagraph(inherited Get(Index));
end;

procedure TElParagraphList.Put(Index: Integer; const Value: TElParagraph);
begin
  inherited Put(Index, Value);
end;

procedure TElParagraphList.Delete(Index: integer);
begin
  Get(Index).Free;
  Remove(Get(Index));
end;

procedure TElParagraphList.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    Get(i).Free;
  inherited Clear;
end;

{ TElAction }

procedure TElAction.Assign(Source: TPersistent);
begin
  if (Source is TElAction) then
  begin
    FAction := TElAction(Source).FAction;
    FStartPos := TElAction(Source).FStartPos;
    FEndPos := TElAction(Source).FEndPos;
    FStr := TElAction(Source).FStr;
  end
  else
    inherited Assign(Source);
end;

{ TElActionList }

constructor TElActionList.Create;
begin

  FAStack := TElStack.Create;
  FLockCount := 0;
end;

destructor TElActionList.Destroy;
begin
  while not FAStack.Empty do
    TElAction(FAStack.Pop).Free;
  FAStack.Free;
end;

procedure TElActionList.AddAction(AAction: TElActionType; ASPos,
  AEPos: TPoint; AStr: TLMDString);
var
  NewAction: TElAction;
begin
  if FLockCount = 0 then
  begin
    NewAction := TElAction.Create;
    try
      with NewAction do
      begin
        FAction := AAction;
        FStartPos := ASPos;
        FEndPos := AEPos;
        FStr := AStr;
      end;
      PushItem(NewAction);
    except
      NewAction.Free;
    end;
  end;
end;

function TElActionList.GetCanUndo: boolean;
begin
  Result := not FAStack.Empty;
end;

function TElActionList.PeekItem: TElAction;
begin
  Result := TElAction(FAStack.Last);
end;

function TElActionList.PopItem: TElAction;
begin
  Result := TElAction(FAStack.Pop);
end;

procedure TElActionList.PushItem(Item: TElAction);
begin
  if (FAStack.Count = FMaxUndo) and (FMaxUndo > 0) then
  begin
    TElAction(FAStack.Items[0]).Free;
    FAStack.ShiftUp(1);
  end;
  FAStack.Push(Item);
end;

procedure TElActionList.SetMaxUndo(const Value: integer);
begin
  if FMaxUndo <> Value then
  begin
    if FAStack.Count > Value then
      FAStack.ShiftUp(abs(FMaxUndo - Value));
    FMaxUndo := Value;
  end;
end;

procedure TElActionList.Lock;
begin
  inc(FLockCount);
end;

procedure TElActionList.UnLock;
begin
  if FLockCount > 0 then
    dec(FLockCount);
end;

{$IFDEF LMD_UNICODE}
procedure TCustomElEdit.WMUniChar(var Msg: TMessage);
begin
  FKeys := WideChar(Msg.WParam);
  CommandCenter(eecChar, #0, @FKeys);
  Msg.Result := 0;
end;

procedure TCustomElEdit.WMDeadChar(var Msg : TWMDeadChar);
begin
  FDeadChar := WideChar(Msg.CharCode);
  Msg.Result := 0;
end;
{$ENDIF}

procedure TCustomElEdit.SetLinkedControl(Value: TControl);
begin
  if (FLinkedControl <> Value) and (Value <> Self) then
  begin
    if FLinkedControl <> nil then
      if not (csDestroying in FLinkedControl.ComponentState) then
        FLinkedControl.RemoveFreeNotification(Self);
    FLinkedControl := Value;
    if FLinkedControl <> nil then
      FLinkedControl.FreeNotification(Self);
    UpdateLinkedControl;
  end;
end;

procedure TCustomElEdit.UpdateLinkedControl;
begin
  if FLinkedControl <> nil then
  begin
    case FLinkedControlPosition of
      lcpLeftTop:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top,
          FLinkedControl.Width, FLinkedControl.Height);
      lcpLeftBottom:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top +
          Height - FLinkedControl.Height, FLinkedControl.Width, FLinkedControl.Height);
      lcpLeftCenter:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top +
          (Height - FLinkedControl.Height) div 2, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopLeft:
        FLinkedControl.SetBounds(Left, Top - FLinkedControl.Height - FLinkedControlSpacing,
          FLinkedControl.Width, FLinkedControl.Height);
      lcpTopRight:
        FLinkedControl.SetBounds(Left + Width - FLinkedControl.Width, Top - FLinkedControl.Height -
          FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopCenter:
        FLinkedControl.SetBounds(Left + (Width - FLinkedControl.Width) div 2, Top -
          FLinkedControl.Height - FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightTop:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top, FLinkedControl.Width,
          FLinkedControl.Height);
      lcpRightBottom:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top + Height -
          FLinkedControl.Height, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightCenter:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top +
          (Height - FLinkedControl.Height) div 2, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomLeft:
        FLinkedControl.SetBounds(Left, Top + Height + FLinkedControlSpacing, FLinkedControl.Width,
          FLinkedControl.Height);
      lcpBottomRight:
        FLinkedControl.SetBounds(Left + Width - FLinkedControl.Width, Top + Height +
          FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomCenter:
        FLinkedControl.SetBounds(Left + (Width - FLinkedControl.Width) div 2, Top + Height +
          FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
    end;
  end;
end;

procedure TCustomElEdit.SetDisplayReadOnlyOptions(const Value: TElDisplayOptions);
begin
  FDisplayReadOnlyOptions.Assign(Value);
end;

procedure TCustomElEdit.SetLinkedControlPosition(Value: TElLinkCtlPos);
begin
  if FLinkedControlPosition <> Value then
  begin
    FLinkedControlPosition := Value;
    UpdateLinkedControl;
  end;
end;

procedure TCustomElEdit.SetLinkedControlSpacing(Value: Integer);
begin
  if FLinkedControlSpacing <> Value then
  begin
    FLinkedControlSpacing := Value;
    UpdateLinkedControl;
  end;
end;

function TCustomElEdit.AdjustRectSB(const ARect : TRect): TRect;
begin
  Result := ARect;
end;

procedure TCustomElEdit.SetUseDisabledColors(Value: Boolean);
begin
  if FUseDisabledColors <> Value then
  begin
    FUseDisabledColors := Value;
    if not Enabled then
      RepaintText(EditRect);
  end;
end;

procedure TCustomElEdit.DisplayOptionsChange(Sender: TObject);
begin
  FIgnoreReadOnlyState := not FDisplayReadOnlyOptions.Enabled;
  RepaintText(EditRect);
end;

procedure TCustomElEdit.SetDisabledColor(Value: TColor);
begin
  if FDisabledColor <> Value then
  begin
    FDisabledColor := Value;
    if (not Enabled) and UseDisabledColors then
      RepaintText(EditRect);
  end;
end;

procedure TCustomElEdit.SetDisabledFontColor(Value: TColor);
begin
  if FDisabledFontColor <> Value then
  begin
    FDisabledFontColor := Value;
    if (not Enabled) and UseDisabledColors then
      RepaintText(EditRect);
  end;
end;

procedure TCustomElEdit.ReadChangeDisabledText(Reader : TReader);
begin
  UseDisabledColors := Reader.ReadBoolean;
end;

function TCustomElEdit.HasCustomBackground: Boolean;
begin
  result := false;
  if ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and
    (not (csDesigning in FImgForm.GetRealControl.ComponentState))) or
      FTransparent or IsThemed then
    Result := true;
  end;

procedure TCustomElEdit.ReadLinkCtlPos(Reader : TReader);
var S : String;
begin
  S := Reader.ReadIdent;
  TypInfo.SetEnumProp(Self, 'LinkedControlPosition', S);
  end;

procedure TCustomElEdit.TriggerKeyPressEx(var Key : TLMDString);
begin
  if assigned(FOnKeyPressEx) then
    FOnKeyPressEx(Self, Key);
end;

procedure TCustomElEdit.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;
  Handled: Boolean;
  PopupMenu: TPopupMenu;
begin
  if Message.Result <> 0 then Exit;
  if csDesigning in ComponentState then Exit;

  Pt := SmallPointToPoint(Message.Pos);
  if Pt.X < 0 then
    Temp := Pt
  else
  begin
    Temp := ScreenToClient(Pt);
    if not PtInRect(ClientRect, Temp) then
    begin
      inherited;
      Exit;
    end;
  end;

  Handled := False;
  DoContextPopup(Temp, Handled);
  Message.Result := Ord(Handled);
  if Handled then Exit;

  PopupMenu := GetPopupMenu;
  if Assigned(PopupMenu) then
  begin
    if PopupMenu.AutoPopup then
    begin
      SendCancelMode(nil);
      PopupMenu.PopupComponent := Self;
      if Pt.X < 0 then
        Pt := ClientToScreen(Point(0,0));
      PopupMenu.Popup(Pt.X, Pt.Y);
      Message.Result := 1;
    end;
  end
  else
    if UseSystemMenu then
    begin
      //Pt := ClientToScreen(Pt);
      ElCallSysMenu(ElEditMenu, Handle, Pt.X, Pt.Y, Self);
      ReleaseCapture;
    end;
  end;

procedure TCustomElEdit.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TCustomElEdit.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TCustomElEdit.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TCustomElEdit.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TCustomElEdit.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

function TCustomElEdit.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

function TCustomElEdit.GetBkColor: TColor;
begin
  if UseDisabledColors and (not Enabled) then
    result := DisabledColor
  else
    if (FDisplayReadOnlyOptions.Enabled) and (ReadOnly) then
      Result := FDisplayReadOnlyOptions.BkColor
    else
      Result := Color;
end;

function TCustomElEdit.GetTextColor: TColor;
begin
  if IsThemed then
  begin
    if not Enabled then
      Result := GetSysColor(COLOR_GRAYTEXT)
    else
      if (FDisplayReadOnlyOptions.Enabled) and (ReadOnly) then
        Result := FDisplayReadOnlyOptions.TextColor
      else
      begin
        if Assigned(Font) and (Font.Color <> clNone) then
          Result := Font.Color
        else
          Result := GetSysColor(COLOR_WINDOWTEXT);
      end;
  end
  else
    if not Enabled then
    begin
      if UseDisabledColors then
        result := DisabledFontColor
      else
        result := GetSysColor(COLOR_GRAYTEXT)
    end
    else
      if (FDisplayReadOnlyOptions.Enabled) and (ReadOnly) then
        Result := FDisplayReadOnlyOptions.TextColor
      else
        Result := Font.Color;
end;

procedure TElActionList.Clear;
begin
  while (not FAStack.Empty) do
    PopItem.Free;
  FAStack.Clear;
end;

{ TCustomElMemo }

constructor TCustomElMemo.Create(AOwner : TComponent);
begin
  inherited;
  WantReturns := true;
  Multiline := true;
  Height := 89;
  Width := 185;
end;

{ TElTextPainter }

function TElTextPainter.CharsFitLeft(AWidth : integer; FText: TLMDString;
    StartPos : integer): Integer;
var
  FText1, FText2 : TLMDString;
  i, j, k : integer;
  TS : TSize;
  FSum, FTabs: integer;
  begin
  Result := -1;
  if FEditor <> nil then
  begin
    FText1 := Copy(FText, 1, StartPos);
    k := Length(FText1);
    SetLength(FText2, k);

    for i := 0 to k - 1 do
      FText2[i + 1] := FText1[k - i];

    FText1 := FEditor.ExpandTabbedString(FText2);

    j := Length(FText1) - 1;
    if j = -1 then
    begin
      result := 0;
      exit;
    end;

    if FEditor.HandleAllocated then
      TS := TextSize(FEditor.FTabString);

    j := AWidth;

    // here we can ignore margins
    if FEditor.HandleAllocated then
      GetTextExtentExPoint(FEditor.Canvas, PLMDChar(FText1), Length(FText1), j, i, nil, TS);
    FSum := 0;
    FTabs := 0;
    j := 1;
    while FSum < i do
    begin
      if FText2[j] = ElFTab then
      begin
        inc(FSum, FEditor.FTabSpaces);
        inc(FTabs, FEditor.FTabSpaces - 1)
      end
      else
        inc(FSum);
      inc(j);
    end;

    Result := i - FTabs;
  end;
end;

function TElTextPainter.CharsFitRight(AWidth : integer; FText : TLMDString; StartPos : integer): Integer;
var
  i, j   : integer;
  //tc, tv : integer;
  TS     : TSize;
  FText1 : TLMDString;
  FSum, FTabs: integer;
  begin
  Result := -1;
  if FEditor <> nil then
  begin
    FText := Copy(FText, StartPos + 1, Length(FText));

    FText1 := FEditor.ExpandTabbedString(FText);
    j := Length(FText1) - 1;
    if (j = -1) or (AWidth <= 0) then
    begin
      result := 0;
      exit;
    end;

    j := AWidth; { j contains overall string length }
    i := 0;

    // here we can ignore margins
    if FEditor.HandleAllocated then
      GetTextExtentExPoint(FEditor.Canvas, PLMDChar(FText1), Length(FText1), j, i, nil, TS);
    FSum := 0;
    FTabs := 0;
    j := 1;
    while FSum < i do
    begin
      if FText[j] = ElFTab then
      begin
        inc(FSum, FEditor.FTabSpaces);
        inc(FTabs, FEditor.FTabSpaces - 1)
      end
      else
        inc(FSum);
      inc(j);
    end;

    Result := i - FTabs;
  end;
end;

constructor TElTextPainter.Create(AEditor: TCustomElEdit);
begin

  FEditor := AEditor;
  FFont := FEditor.Font;
end;

destructor TElTextPainter.Destroy;
begin
  ; // nothing to do;
end;

procedure TElTextPainter.DrawTabbedText(const ACanvas: TCanvas; X, Y: Integer; ARect: TRect; AText: TLMDString; var Size: TSize);
begin
  ExtTextOut(ACanvas, X, Y, ETO_CLIPPED, @ARect, AText, Length(AText));
  Size := TextSize(Atext);
end;

procedure TElTextPainter.SetBkColor(const ABkColor: TColor);
begin
  if FBkColor <> ABkColor then
  begin
    FBkColor := ABkColor;
    FEditor.Invalidate;
  end;
end;

procedure TElTextPainter.SetColor(const AColor: TColor);
begin
  if FColor <> AColor then
  begin
    FColor := AColor;
    FEditor.Canvas.Pen.Color := FColor;
    FEditor.Invalidate;
  end;
end;

{ TElWinTextPainter }
function TElWinTextPainter.ExtTextOut(const ACanvas: TCanvas; X, Y, Options: Integer; Rect: PRect; Str: TLMDString; Count: Integer): Boolean;
begin
  result := LMDExtTextOut(ACanvas, X, Y, Options, Rect, Str, Count);
end;

function TElWinTextPainter.GetTextExtentExPoint(const ACanvas: TCanvas; lpszStr:PLMDChar;
  cchString, nMaxExtent: integer; var lpnFit: integer; alpDX: PInteger;
  var lpSize: TSize): Boolean;
begin
  Result := ElGetTextExtentExPoint(ACanvas.Handle, lpszStr, cchString, nMaxExtent, lpnFit, alpDX, lpSize);
end;

function TElWinTextPainter.TextSize(ALine: TLMDString): TSize;
begin
  Result := TSize(Point(0, 0));
  FEditor.Canvas.Font.Assign(Font);
  if FEditor.HandleAllocated then
  {$IFDEF LMD_UNICODE}
    GetTextExtentPoint32W(FEditor.Canvas.Handle, PWideChar(ALine), Length(ALine), Result);
    {$ELSE}
    GetTextExtentPoint32(FEditor.Canvas.Handle, PChar(ALine), Length(ALine), Result);
    {$ENDIF}
  end;

{$hints off}
begin

  ElWhatIsMenu := 4;
  if LMDSIWindowsNTUp then
  begin
    ElEditMenu := 1;
    ElSysWindowMenu := 16;
    ElMDIWindowMenu := 32;
    ID_SELECTALL := 177;
  end
  else
  begin
    ElEditMenu := 3;
    ElSysWindowMenu := 1;
    ElMDIWindowMenu := 2;
    ID_SELECTALL := 1025;
  end;

end.
