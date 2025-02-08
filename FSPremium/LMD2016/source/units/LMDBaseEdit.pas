unit LMDBaseEdit;
{$I lmdcmps.Inc}

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

LMDBaseEdit unit (JH)
--------------------
Base component for text input controls

Comments
--------
about the rects used in the control (and provided to its descendant classes)
- InnerRect : the rect in which something can be painted
- PaintRect : the inner rect without added controls (as buttons)
               - this rect is repainted by calling RepaintBack
- TextRect  : the rect in which the text is displayed
              (located somewhere in the paintrect)
the TextRect and the PaintRect must not be equal! the difference between them
can be used for custom painting!

Changes
-------
Release 8.03 (December 2007)

 + FoundAtPos method for getting first symbol of found string when IsUpdating=true [VB];
 - Search method ignored IsUpdating status, which caused scrolling and flashing
   when multiple search is performed - fixed [VB];
 - If the word is the last in file, search did not find it - fixed [VB];
 - Index out of bounds error in .net when S&R the last word - fixed [VB];
 - Search with WholeWords = true bug fixed [VB].

-------
Release 8.0 (December 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Clipbrd, Menus, LMDTypes,
  LMDCaret, LMDConst, LMDUtils, LMDProcs, LMDGraph, LMDClass, intfLMDFaceControllerEditable,
  LMDBase, LMDBoundLabel, LMD3DCaption, LMDDynLIFOBuffer, LMDVldBase,
  {$IFDEF LMD_UNICODE}
  Imm,
  {$ENDIF}
  LMDCustomBevelPanel;

type

  TLMDUndoRecord = record
    newText,             //text to be inserted
    oldText : TLMDString;//TObject;    //text to be replaced
    selstart, sellength,
    newlength,
    current : Integer;
  end;

  PLMDUndoRecord = ^TLMDUndoRecord;

  TLMDSearchStart = (stTop, stBottom, stCursor);
  TLMDSearchDirection = (sdUp, sdDown);

  TLMDEditOption = (eoNarrowHeight, eoSuppressDefaultMenu, eoUserLocale, eoAllowCopy, eoAllowCut, eoAllowPaste);
  TLMDEditOptions = set of TLMDEditOption;

  TLMDDelimiters = Set of AnsiChar;

  TLMDTextChangeEvent=procedure(sender:TObject;At : Integer) of object;

  {$IFDEF LMD_UNICODE}
  TIMECompStringProc = function(hImc: HIMC; dWord1: DWORD; lpBuf: pointer; dwBufLen: DWORD): Longint; stdcall;
  {$ENDIF}

  {$IFDEF LMDCOMP16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TLMDBaseEdit = class(TLMDCustomBevelPanel, ILMDFaceControllerEditable,
                       ILMDValidatedControl)
  private
    FMousePos      : TSmallPoint;
    FCaret         : TLMDCaret;
    FTabEnter,
    FEnableKeyInput,
    FHasBoundLabel,
    FSaveRes,
    FDraggingAllowed,
    FAskForLoop,
    FRedoing,
    FUndoing,
    FCanUndo,
    FCanRedo       : Boolean;

    FOptions       : TLMDEditOptions;

    FAlignment     : TAlignment;

    FFont3D        : TLMD3DCaption;

    FCursor        : TCursor; //needed to save the selected mouse cursor when dragging

    // 7.0 RM
    FTimerID       : TLMDTimer;
    FTextRectBorderY,
    // -----
    //FUpdateCount,
    FPrevCharPos,
    FFirstLine,                    //first visible line (multiline)
    FMaxLength,                    //max length of input
    FSelLength     : Integer;      //length of selection

    FUndoBuffer,
    FRedoBuffer    : TLMDDynLIFOBuffer;

    FHighTextColor,
    FHighBackColor : TColor;

    FDragging, //moving text with the mouse
    FLeftButtonPressed,
    FGetFocusOnMouseAbove,
    FOEMConvert,
    FAutoSelect,
    FModified,
    FReadOnly,
    FInsert,
    FHideSelection : Boolean;

    FDelimiters    : TLMDDelimiters;

    FOnTextChange  : TLMDTextChangeEvent;
    FOnCursorPosChanged,
    FOnModified,
    FOnChange      : TNotifyEvent;

    FCharCase      : TEditCharCase;

    //support of bound labels, JH April 02
    FEditLabel    : TLMDBoundLabel;
    FLabelPosition: TLabelPosition;
    FLabelSpacing : Integer;
    FLabelSync:Boolean;
    FUseGlobalTimer: Boolean;

    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
    procedure SetHasLabel(aValue: Boolean);
    procedure SetLabelSync(const Value: Boolean);
    // 7.0
    procedure ReadEditLabel(Stream: TStream);

    procedure CMLMDBOUNDLABELCHANGE(var Message: TMessage); message CM_LMDBOUNDLABELCHANGE;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMEnabledChanged (var Message : TMessage); message CM_ENABLEDCHANGED;
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMTextChanged(var Msg: TMessage);message CM_TEXTCHANGED;
    // --

    procedure SetFont3D (aValue : TLMD3DCaption);
    procedure SetInteger (Index : Integer; aValue : Integer);
    procedure SetAlignment (aValue : TAlignment);
    procedure SetBoolean (Index : Integer; aValue : Boolean);
    function GetBoolean (Index : Integer): Boolean; //VT Oct 2009
    procedure SetCaretVal (aValue : TLMDCaret);
    procedure SetCharCase (aValue : TEditCharCase);
    procedure pSetText (const aValue : TLMDString);
    function GetText : TLMDString;

    procedure SetSelText (aValue : TLMDString);
    function GetSelText : TLMDString;

    procedure DoUndo (Sender : TObject);
    procedure DoCopy (Sender : TObject);
    procedure DoCut (Sender : TObject);
    procedure DoPaste (Sender : TObject);
    procedure DoClear (Sender : TObject);
    procedure DoOnTimer (Sender : TObject);
    procedure DoSelectAll (Sender : TObject);
    procedure DoLeftMouseBtn;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure UpdateCaret;
    procedure CMFontChanged (var Msg : TMessage); message CM_FONTCHANGED;
    procedure WMChar(var Msg : TWMChar); message WM_CHAR;
    {$IFDEF LMD_UNICODE}
    procedure WMImeStartComposition(var Message : TMessage); message WM_IME_STARTCOMPOSITION;
    procedure WMImeComposition(var Message: TMessage); message WM_IME_COMPOSITION;
    {$ENDIF}
    procedure WMClear(var Msg : TWMClear); message WM_CLEAR;
    procedure WMCopy(var Msg : TWMCopy); message WM_COPY;
    procedure WMCut(var Msg : TWMCut); message WM_CUT;
    procedure WMPaste(var Msg : TWMPaste); message WM_PASTE;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMLButtonDblClk(var Msg : TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg : TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp (var Msg : TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMRButtonUp (var Msg : TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMMouseActivate(var Msg : TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMMouseMove(var Msg : TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    //
    //procedure CMEnter(var Message: TCMGOTFOCUS);message CM_ENTER;
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
    //
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetText(var Msg : TWMSetText); message WM_SETTEXT;
    procedure WMGetText(var Msg : TWMGetText); message WM_GETTEXT;
    procedure WMGetTextLength(var Message : TMessage); message WM_GETTEXTLENGTH;
    procedure WMQuit(var Msg : TWMQuit); message WM_QUIT;
    procedure EMCANUNDO (var Message : TMessage); message EM_CANUNDO;
    procedure EMCHARFROMPOS (var Message : TMessage); message EM_CHARFROMPOS;
    procedure EMEMPTYUNDOBUFFER (var Message : TMessage); message EM_EMPTYUNDOBUFFER;
    procedure EMFMTLINES (var Message : TMessage); message EM_FMTLINES;
    procedure EMGETFIRSTVISIBLELINE (var Message : TMessage); message EM_GETFIRSTVISIBLELINE;
    procedure EMGETHANDLE (var Message : TMessage); message EM_GETHANDLE;
    procedure EMGETLIMITTEXT (var Message : TMessage); message EM_GETLIMITTEXT;
    procedure EMGETLINE (var Message : TMessage); message EM_GETLINE;
    procedure EMGETLINECOUNT (var Message : TMessage); message EM_GETLINECOUNT;
    procedure EMGETMARGINS (var Message : TMessage); message EM_GETMARGINS;
    procedure EMGETMODIFY (var Message : TMessage); message EM_GETMODIFY;
    procedure EMGETPASSWORDCHAR (var Message : TMessage); message EM_GETPASSWORDCHAR;
    procedure EMGETRECT (var Message : TMessage); message EM_GETRECT;
    procedure EMGETSEL (var Message : TMessage); message EM_GETSEL;
    procedure EMGETTHUMB (var Message : TMessage); message EM_GETTHUMB;
    procedure EMGETWORDBREAKPROC (var Message : TMessage); message EM_GETWORDBREAKPROC;
    procedure EMLIMITTEXT (var Message : TMessage); message EM_LIMITTEXT;
    procedure EMLINEFROMCHAR (var Message : TMessage); message EM_LINEFROMCHAR;
    procedure EMLINEINDEX (var Message : TMessage); message EM_LINEINDEX;
    procedure EMLINELENGTH (var Message : TMessage); message EM_LINELENGTH;
    procedure EMLINESCROLL (var Message : TMessage); message EM_LINESCROLL;
    procedure EMPOSFROMCHAR (var Message : TMessage); message EM_POSFROMCHAR;
    procedure EMREPLACESEL (var Message : TMessage); message EM_REPLACESEL;
    procedure EMSCROLL (var Message : TMessage); message EM_SCROLL;
    procedure EMSCROLLCARET (var Message : TMessage); message EM_SCROLLCARET;
    procedure EMSETHANDLE (var Message : TMessage); message EM_SETHANDLE;
//    procedure EMSETLIMITTEXT (var Message : TMessage); message EM_SETLIMITTEXT;
    procedure EMSETMARGINS (var Message : TMessage); message EM_SETMARGINS;
    procedure EMSETMODIFY (var Message : TMessage); message EM_SETMODIFY;
    procedure EMSETPASSWORDCHAR (var Message : TMessage); message EM_SETPASSWORDCHAR;
    procedure EMSETREADONLY (var Message : TMessage); message EM_SETREADONLY;
    procedure EMSETRECT (var Message : TMessage); message EM_SETRECT;
    procedure EMSETRECTNP (var Message : TMessage); message EM_SETRECTNP;
    procedure EMSETSEL (var Message : TMessage); message EM_SETSEL;
    procedure EMSETTABSTOPS (var Message : TMessage); message EM_SETTABSTOPS;
//    procedure EMSETWORDBREAK (var Message : TMessage); message EM_SETWORDBREAK;
    procedure EMSETWORDBREAKPROC (var Message : TMessage); message EM_SETWORDBREAKPROC;
    procedure EMUNDO (var Message : TMessage); message EM_UNDO;
    procedure SetOptions(const Value: TLMDEditOptions);
  protected
    //For SpinEdit controls
    FForceOverwriteMode: boolean;
    // Triple click support
    FDoubleClickCX: Integer;
    FDoubleClickCY: Integer;
    FLastClickTime: LongWord;
    FDoubleClickTimeout: LongWord;
    FFirstClickX: Integer;
    FFirstClickY: Integer;
    FClickCount: Byte;

    //Validation support, May 2006, RS
    FValidator: TLMDValidationEntity;
    FValidationMsgString: TLMDString;
    FErrorIndication: Boolean;
    FOnValidationError: TLMDValidationErrorEvent;
    FBack          : TBitmap;
    //we need to redefine this var because of the limitation to word size of the inherited Text
    FText          : TLMDString;
    FCursor2EndOnSelectAll,
    FUserSelect,   //is user allowed to select text by himself?
    //FNoUpdate,     //internally used - if true EndUpdate will not call DrawText!
    FOutBuffered,
    FSelMode,
    FSettingText,
    FNoSelection   : Boolean;
    FInnerRect,
    FPaintRect,
    FTextRect      : TRect;
    //FColumn and FSelStart must be accessible without calling
    //SetInteger (it would call itself recursivley)
    FCurrentChar,
    FLineStart,
    FLineEnd,
    FSelStart,                     //selection start
    FHiddenLeft    : Integer;
    FIsDeleting    : boolean;
    FFoundAtPos: integer;
    FSearching: boolean;
    FIsPasting: boolean;
    function GetEmptyText: TLMDString; virtual;
    //Validation support, May 2006, RS
    procedure SetValidationMsgString(val : TLMDString);
    function GetValidationMsgString : TLMDString;
    function GetControl : TControl;
    function GetControlBackBrush : TBrush;
    function GetControlFont : TFont;
    function GetValueToValidate: TLMDString; virtual;
    procedure SetupRects; virtual;
    procedure CreateBack; virtual;
    procedure FillControl; override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); dynamic;
    function CalcMouseCol(XPos : Integer) : Integer; virtual; abstract;
    function CalcMouseRow(YPos : Integer) : Integer; virtual; abstract;
    procedure DoAlignmentChange; virtual;
    procedure SetCaret; virtual; abstract;
    function BackOneMore: Boolean; virtual; //default false, otherwise backspace will delete the char before the selection in addition
    procedure Change;virtual;
    procedure GetChange (Sender : TObject); override;
    function GetReadOnly: Boolean; override;
    procedure SetNewText; virtual; abstract;
    procedure GetNewText; virtual; abstract;
    procedure DrawEditText(from : Integer); virtual; abstract;
    function CalcMousePos(Pos : TSmallPoint) : Integer; virtual; abstract;
    function RowHeight (s : TLMDString) : Integer; virtual;
    function RowWidth (s : TLMDString) : Integer;
    procedure CursorPosChanged; virtual;
    procedure ChangedText (At : Integer); virtual;
    procedure BeforeChangeText; virtual;
    procedure FinishedSetSelText; virtual;
    procedure HandleInsertText (at : Integer;var aValue : TLMDString); virtual;
    procedure HandleReplaceText (at : Integer;aValue : TLMDString); virtual;
    procedure RepaintBack(aRect : TRect); virtual;
    function  AllowedOperation(textToInsert : TLMDString) : Boolean; virtual;
    procedure DoDestroyBufferEntry (Sender : TObject; item : Pointer);
    function  AllowCopyPaste : Boolean; virtual;
    function  RedrawOnExit: Boolean; virtual; //JH March 2002
    function  RedrawOnEnter: Boolean; virtual; //JH March 2002
    procedure DoThemeChanged; override; //JH March 2002

    procedure SetLMDCaretPos (X, Y : integer);

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift : TShiftState); override;
    procedure RestoreBorderFront; override;
    procedure RestoreBorderBack; override;

    //support of bound label, April 02
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetParent(AParent: TWinControl); override;

    // 7.0 -----------------------------------------------
    //procedure GetChildren(Proc: TGetChildProc; Root: TComponent);override;
    procedure DefineProperties(Filer:TFiler);override;

    procedure DestroyWindowHandle; override;

    procedure Loaded; override;
    procedure Paint; override;

    function fcGetModified: Boolean; virtual;
    function fcGetReadOnly: Boolean; virtual;
    function fcGetInvalidData: Boolean; virtual;

    // ---
    property EditLabel: TLMDBoundLabel read FEditLabel;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing default 3;
    property HasBoundLabel: Boolean read FHasBoundLabel write SetHasLabel;
    //----------------------------------------------------

    // 7.1 -----------------------------------------------
    function GetListMode:Boolean; virtual;
    // ---

    procedure FreeTimer;

    procedure ModifyTextRect; virtual;
    procedure ModifyPaintRect; virtual;
    procedure ModifyInnerRect; virtual;

    procedure WndProc(var Msg: TMessage); override;
    procedure TriggerTripleClick;

    property Undoing : Boolean read FUndoing;
    property TabOnEnter: Boolean read FTabEnter write FTabEnter default false;

    //bounded label support, April 02, JH
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition default lpAbove;
    property LabelSync:Boolean read FLabelSync write SetLabelSync default false;
    property DraggingAllowed : Boolean read FDraggingAllowed write FDraggingAllowed default true;
    property EnableKeyInput: Boolean read FEnableKeyInput write FEnableKeyInput;
    property Options : TLMDEditOptions read FOptions write SetOptions default [eoAllowCopy, eoAllowCut, eoAllowPaste];

    function ToUpperCase(const S: string): string;
    function ToLowerCase(const S: string): string;


  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
    //Validation support, May 2006, RS
    function SupportsDefaultIndication: boolean;
    property ControlFont : TFont read GetControlFont;
    property ControlBackBrush : TBrush read GetControlBackBrush;
    procedure RespondToError(ErrorLevel: TLMDErrorLevel);
    procedure SetValidator(Validator:TLMDValidationEntity);
    function GetValidator: TLMDValidationEntity;
    // 7.0
    //procedure BeginUpdate;
    //procedure EndUpdate;
    procedure EndUpdate(repaint: Boolean=false);override; // 7.0 RM
    // ---
    //support of bound label, JH April 02
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure SetupEditLabel;
    //

    procedure SetSelection;
    //selects the current word with the start, end of line and the space as delimiters
    procedure SelectCurrentWord; virtual;
    procedure SelectRightWord;
    procedure SelectLeftWord;

    procedure SetSelTextBuf(Buffer: PLMDChar);
    function GetSelTextBuf(Buffer: PLMDChar; BufSize: Integer): Integer; virtual;

    function Search (s : TLMDString;from : TLMDSearchStart;caseSensitive, wholeWords : Boolean;
                      direction : TLMDSearchDirection) : Boolean;
    function SearchAndReplace (s, r : TLMDString;from : TLMDSearchStart;caseSensitive, wholeWords : Boolean;
                      direction : TLMDSearchDirection; ask, all : Boolean) : Boolean;
    function FoundAtPos: integer;

    procedure GotoParaStart;
    procedure GotoParaEnd;
    procedure GotoNextWord;
    procedure GotoPrevWord;
    function GetCurrentWord : TLMDString;
    function GetLength : Integer;

    function CountWords : Integer;

    procedure Replace (start, count : Integer; s : TLMDString);
    procedure Upper (start, count : Integer);
    procedure Lower (start, count : Integer);
    function Cut (start, count : Integer) : TLMDString;
    procedure Add (const S : TLMDString);
    procedure Insert (at : Integer; const S : TLMDString);
    function Copy (start, count : Integer) : TLMDString;

    //select all text in the EditControl
    procedure SelectAll;
    procedure Clear; virtual;
    procedure ClearSelection;
    procedure CopyToClipboard;
    procedure CutToClipboard; virtual; //needs to be overridden in db version
    procedure PasteFromClipboard; virtual; //needs to be overridden in db version
    procedure Undo;
    procedure ClearUndo;
    procedure Redo;

    property Text : TLMDString read GetText write pSetText stored true;

    property CurrentChar : Integer index 5 read FCurrentChar write SetInteger;

    property Delimiters : TLMDDelimiters read FDelimiters write FDelimiters;

    property Font;
    property Font3D : TLMD3DCaption read FFont3D write SetFont3D;

    property MaxLength : Integer index 0 read FMaxLength write SetInteger default 0;
    property SelStart : Integer index 1 read FSelStart write SetInteger default 0;
    property SelLength : Integer index 2 read FSelLength write SetInteger default 0;
    property FirstLine : Integer read FFirstLine;

    property SelText : TLMDString read GetSelText write SetSelText;
    property HideSelection : Boolean index 0 read GetBoolean write SetBoolean default true;
    property Alignment : TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property ReadOnly : Boolean index 1 read GetBoolean write SetBoolean default false;
    property Modified : Boolean index 2 read GetBoolean write SetBoolean default false;
    property AutoSelect : Boolean index 4 read GetBoolean write SetBoolean default false;
    property OEMConvert : Boolean index 5 read GetBoolean write SetBoolean default false;
    property CharCase : TEditCharCase read FCharCase write SetCharCase default ecNormal;
//    property MouseAbove : Boolean read FMouseAbove;

    property AskForLoop : Boolean read FAskForLoop write FAskForLoop default true;
    property CtlXP; // for compatibility
  published
    property About;
    property Align;
//    property BorderStyle;
    property BackFX;
    property FaceController;
    property HighlightBack : TColor read FHighBackColor write FHighBackColor default clHighLight;
    property HighlightText : TColor read FHighTextColor write FhighTextColor default clHighLightText;
    property Bevel;
    property FocusOnMouseAbove : Boolean index 6 read GetBoolean write SetBoolean default false;
    property Caret : TLMDCaret read FCaret write SetCaretVal;
    property Color default clWindow;
    property Cursor default crIBeam;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Flat;
    property Hint;
    property ImageList;
    property ImageIndex;
    property ImeMode;
    property ImeName;
    property ListIndex;
    property ParentColor default false;
    property ParentCtl3D;
    property ParentShowHint;
    property ParentThemeMode default true;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default true;
    property Tag;
    property Transparent;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;
    // 7.0 RM
    property UseGlobalTimer:Boolean read FUseGlobalTimer write FUseGlobalTimer default false;
    // ---
    property Visible;

    property OnCursorPosChanged : TNotifyEvent read FOnCursorPosChanged write FOnCursorPosChanged;
    property OnTextChangedAt : TLMDTextChangeEvent read FOnTextChange write FOnTextChange;
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property OnModified : TNotifyEvent read FOnModified write FOnModified;
    property OnContextPopup;
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
    property OnStartDrag;
    property OnAfterEnter;
    property OnAfterExit;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseWheel;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    //Validation support, May 2006, RS
    property ValidationMsgString : TLMDString read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read FOnValidationError write FOnValidationError;

    {$IFDEF LMDCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
  end;

implementation

uses
  Types, Themes,
  {$IFDEF LMD_UNICODE}
  LMDUnicode,
  LMDSysIn,
  {$ENDIF}
  LMDThemes, LMDGraphUtils, LMDStrings;

{ ------------------------------ TLMDBaseEdit ------------------------------ }
{ ---------------------------------- private --------------------------------- }
procedure TLMDBaseEdit.SetLabelPosition(const Value: TLabelPosition);
var
  P: TPoint;
begin
  if not Assigned(FEditLabel) then exit;
  FLabelPosition := Value;
  if [csLoading, csReading]*ComponentState<>[] then exit;
  case Value of
    lpAbove: P := Point(Left, Top - FEditLabel.Height - FLabelSpacing);
    lpBelow: P := Point(Left, Top + Height + FLabelSpacing);
    lpLeft : P := Point(Left - FEditLabel.Width - FLabelSpacing, Top);
    lpRight: P := Point(Left + Width + FLabelSpacing, Top);
  end;
  if not FLabelSync then
    FEditLabel.SetBounds(P.x, P.y, FEditLabel.Width, FEditLabel.Height)
  else
    if Value in [lpAbove, lpBelow] then
      FEditLabel.SetBounds(P.x, P.y, self.Width, FEditLabel.Height)
    else
      FEditLabel.SetBounds(P.x, P.y, FEditLabel.Width, self.Height);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetLabelSync(const Value: Boolean);
begin
  if FLabelSync<>Value then
    begin
      FLabelSync := Value;
      if FLabelSync then
        if Assigned(FEditLabel) and FEditLabel.AutoSize then
          FEditLabel.AutoSize:=false;
      SetLabelPosition(FLabelPosition);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetHasLabel(aValue: Boolean);
begin
  if aValue <> FHasBoundLabel then
    begin
      if aValue then
        SetupEditLabel
      else
        begin
          FreeAndNil(FEditLabel);
          FHasBoundLabel:=false;
        end;
    end;
end;

 // 7.0
{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.ReadEditLabel(Stream:TStream{Reader});
begin
  Stream.ReadComponent(FEditLabel);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.CMLMDBOUNDLABELCHANGE(var Message: TMessage);
begin
  SetLabelPosition(FLabelPosition);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseEdit.CMTextChanged(var Msg: TMessage);
begin
  // prevent changes during creation or reading from stream
//  if isUpdating or ([csReading, csLoading]*ComponentState<>[]) then exit;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  if Assigned (FEditLabel) then
    FEditLabel.Visible := Visible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.CMBiDiModeChanged(var Message: TMessage);
begin
  inherited;
  if Assigned (FEditLabel) then
    FEditLabel.BiDiMode := BiDiMode;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetInteger (Index : Integer; aValue : Integer);
begin
  case Index of
    0 : begin
          FMaxLength := aValue;
        end;
    1 : begin
          FSelStart := aValue;
        end;
    2 : if aValue <> FSelLength then //added 211099 JH
          begin
            FSelLength := aValue;
            if FSelLength = 0 then              //added 260404 JH
              FSelStart := FCurrentChar;        //added 260404 JH
            if not IsUpdating then
              DrawEditText (-1);
          end;
    5 : // set FCurrentChar
        begin
          FPrevCharPos := FCurrentChar;
          if aValue > Length (FText) + 1 then
            aValue := Length (FText) + 1;
          if aValue < 1 then
            aValue := 1;
          FCurrentChar := aValue;
          if not IsUpdating then
            begin
              SetSelection;
              CursorPosChanged;
            end;
        end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetAlignment (aValue : TAlignment);
begin
  if aValue <> FAlignment then
    begin
      FAlignment := aValue;
      //FHiddenLeft should be zero for a new Alignment
      //it is only unequal to zero if Alignment had been taLeftJustify with no wordwrapping
      //this point of source is only executed if someone switches to taCenter or taRight
      //(all other possibilities are unimportant)
      FHiddenLeft := 0;
      DoAlignmentChange;
      DrawEditText (-1);
      SetCaret;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetBoolean(Index : Integer): Boolean;
begin
  case Index of
    0 : Result := FHideSelection;
    1 : Result := FReadOnly;
    2 : Result := FModified;
    4 : Result := FAutoSelect;
    5 : Result := FOEMConvert;
    6 : Result := FGetFocusOnMouseAbove;
  else
    Result := false;
    Assert(false);
  end;
end;

procedure TLMDBaseEdit.SetBoolean (Index : Integer; aValue : Boolean);
begin
  //VT Oct 2009. Fixed control flickering in some cases
  if GetBoolean(Index) = aValue then
    Exit;

  case Index of
    0 : FHideSelection := aValue;
    1 : begin
          FReadOnly := aValue;
          //added June 02 -> redraw control if invalidate is enabled
          //otherwise control will stay "readonly"
          //if it currently does not have the focus
          if IsThemed then Invalidate;
        end;
    2 : if FModified <> aValue then
          begin
            FModified := aValue;
            if Assigned (FOnModified) then
              FOnModified (self);
          end;
    4 : FAutoSelect := aValue;
    5 : FOEMConvert := aValue;
    6 : FGetFocusOnMouseAbove := aValue;
  else
    Assert(false);
  end;

  if Assigned(FaceController) then
    FaceController.StateChanged(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetFont3D (aValue : TLMD3DCaption);
begin
  FFont3D.Assign (aValue);
  Perform(CM_FONTCHANGED, 0, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetCaretVal (aValue : TLMDCaret);
begin
  FCaret.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetCharCase (aValue : TEditCharCase);
begin
  FCharCase := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.pSetText (const aValue : TLMDString);
begin
  if aValue <> FText then
    begin
      if (FMaxLength <> 0) and (Length (aValue) > FMaxLength) then
        FText := System.Copy(aValue, 1, FMaxLength)
      else
        FText := aValue;
      FHiddenLeft := 0;
      CurrentChar := 1;
      SelLength := 0;
      SetNewText;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetText : TLMDString;
begin
  result := FText;
  GetNewText;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.DoUndo (Sender : TObject);
begin
  Undo;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.DoCopy (Sender : TObject);
begin
  CopyToClipboard;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.DoCut (Sender : TObject);
begin
  CutToClipboard;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.DoPaste (Sender : TObject);
begin
  PasteFromClipboard;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.DoClear (Sender : TObject);
begin
  ClearSelection;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.DoSelectAll (Sender : TObject);
begin
  SelectAll;
end;

{ ---------------------------------------------------------------------------- }
//RowHeight is a virtual function which should be used to calculate the height of one row in the output
function TLMDBaseEdit.RowHeight (s : TLMDString) : Integer;
begin
  // 7.0
  if IsUpdating then         // for the case no valid Canvas is available or in constructor
    result:=LMDGetFontHeight(Font)
  else
    result := LMDGetTextHeight(Canvas, s);
  // ---
  if FFont3D.Style in [tdSunkenShadow, tdRaisedShadow, tdShadow] then
    result := result + FFont3D.ShadowDepth;
end;

{ ---------------------------------------------------------------------------- }
//RowWidth is a virtual function which should be uses to calculate the space text needs
function TLMDBaseEdit.RowWidth (s : TLMDString) : Integer;
var
  aRect : TRect;
begin
  aRect := FTextRect;

  LMDDrawTextCalcExt(Canvas, s, FFont3D, aRect, GetFont, false,
                     false, 0, 0);
  if s = '' then
    aRect := Rect (0,0,0,0);
  result := aRect.Right - aRect.Left;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.CursorPosChanged;
begin
  SetCaret;
  if Assigned (FOnCursorPosChanged) then FOnCursorPosChanged(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetSelText (aValue : TLMDString);
var
  hc,
  i  : Integer;
  p  : PLMDUndoRecord; //for undo
  s  : TLMDString;
  lForcePos: boolean;

{$IFNDEF LMDCOMP12}
  ans: AnsiString;
{$ENDIF}
begin
  if not AllowedOperation(aValue) then exit;
  FIsDeleting := (aValue = '');
  lForcePos := false;
  if (aValue = '') and (SelLength > 0) then
    begin
      aValue := GetEmptyText;
      lForcePos := true;
    end;
  //convert the text from char to oem and back (especially useful for filenames)
  if (FOemConvert) and (aValue <> '') then
    begin

      {$IFNDEF LMDCOMP12}
      // Todo Check this
      ans := AnsiString(aValue);
      CharToOem (PChar(ans), PChar(ans));
      OemToChar (PChar(ans), PChar(ans));
      aValue := TLMDString(ans);
      {$ENDIF}

    end;

  //this function does in BaseEdit nothing but can be overwritten in descendant classes
  BeforeChangeText;

  New(p);
  p^.current := FCurrentChar;
  p^.selstart := FSelStart;
  p^.sellength := FSelLength;
  p^.newlength := Length(aValue);
  s := SelText;
  p^.oldText := S;
  p^.newText := aValue;

  if not FUndoing then //if change refers to a undo place string in redo buffer
    begin
      FCanUndo := true;
      FUndoBuffer.Put (p);
      if not FRedoing then
        begin
          FRedoBuffer.Clear;
          FCanRedo := false;
        end;
    end
  else
    begin
      FCanRedo := true;
      FRedoBuffer.Put (p);
    end;

  // old, one step undo, removed by JH FUndoString := Text; //save the current string

  //save pos where the changes are made
  i := SelStart;

  //if there is selected text then delete it
  if (FSelLength <> 0) and (Length(FText) >= FSelStart+FSelLength - 1) then
    begin
      //if the lineend is marked include the #10 into the deletion process
      if FSelStart+FSelLength-1 >= 1 then // VB 14 March 2005
        if FText[FSelStart+FSelLength-1] = #13 then
          inc (FSelLength);
      //if we have started with the selection on a #10 then include the pred char (#13)
      if FSelStart >= 1 then // VB 14 March 2005
        if FText[FSelStart] = #10 then
          begin
            dec (FSelStart);
            inc(FSelLength);
          end;
    end
  else //if there is no selected text but insertmode is set to overwrite delete current char
    begin
      //if we are not at the end of the text (if the text is empty this would rise a general protection fault) and the current char is a #10 go to the #13
      //otherwise we run into the risk of separating a #13#10 pair or just delete the #10
      if (Length(FText) <> 0) and (Length(FText) >= FSelStart) and (FText [FSelStart] = #10) then dec (FSelStart);
      //if we are in overwriting mode
      if (not (emInsert in LMDApplication.EditMode) or FForceOverwriteMode) and not FIsPasting then
        begin
          //just mark the current char
          FSelLength := 1;
          //if we are on a #13 include the #10
          if FSelStart <= Length (FText) then //added 20.04 JH
            if FText[FSelStart] = #13 then inc (FSelLength);
        end;
    end;
  //if there is selected text
  //if FSelLength <> 0 then
    begin
      //this function does in BaseEdit nothing but can be overwritten in descendant classes
      //in TLMDMemo e.g. it decrements the rowcounter ...
      HandleReplaceText (FSelStart, System.Copy(FText, FSelStart, FSelLength));

      //delete the text
      Delete (FText, FSelStart, FSelLength);
      //there is no longer selected text
      FSelLength := 0;
      //save the current SelStart pos (from now on new cursor pos) in hc
      hc := FSelStart;
    end;

  //move down here 21.02. JH
  //this function does in BaseEdit nothing  but can be overwritten in descendant classes
  HandleInsertText (FSelStart, aValue);

  //if there is no length limit or text shorter than MaxLength then insert new text
  if (MaxLength = 0) or (Length(FText) + Length(aValue) <= MaxLength) then
    begin
      //insert the text
      if FIsPasting and (SelLength > 0) then //Vb Nov 2009 - to make paste from clpbrd work for meMask
        System.Delete(FText, SelStart, SelLength);
      System.Insert(aValue, FText, FSelStart);
      //save the new relevant cursor pos (at the end of the inserted text)
      if not lForcePos then
        hc := FSelStart + Length(aValue);
    end;

  //we have modified the text ...
  Modified := True;

  //rise the OnChangedTextAt event
  ChangedText (i);

  //needed to set the cursor to the right pos - 6.11. eins nach oben (wieder nach unten, 10.11?)
  CurrentChar := hc;

  //if there had been lots of selected text the cursor could be far behind the last char
  if (FCurrentChar > Length(FText) + 1) and (Length (FText) > 0) then
    CurrentChar := Length(FText) + 1;

  //the following two lines are needed to correct these values after a capital letter has been entered, for correcting the cursor pos
  //the shift has been pressed to (selection mode ...)
  if not (IsUpdating and FSearching) then
    begin
      BeginUpdate;
      SelLength := 0;
      EndUpdate(true);
    end;
  SelStart := CurrentChar;
  FinishedSetSelText;
end;

{ ---------------------------------------------------------------------------- }
//GetSelText returns the selected text
function TLMDBaseEdit.GetSelText : TLMDString;
begin
  result := System.Copy(Text, FSelStart, FSelLength);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.GetChange(Sender : TObject);
begin
  inherited GetChange (Sender);
  //if Assigned(FOnChange) then FOnChange (self);   // RM Oct 2003
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetReadOnly: Boolean;
begin
  result := FReadOnly;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMChar(var Msg : TWMChar);
begin
  if not FEnableKeyInput then exit; //do not accept keys if not enabled, JH April 02
  DoKeyPress (Msg); //5.0 JH
  //get all char - keystokes
  if Msg.CharCode > 31
  {not (Msg.CharCode in [VK_BACK, VK_ESCAPE, VK_RETURN, 1])} {and
    not (emCtrl in LMDApplication.EditMode)} then
    begin
      //tell the SetSelection func that there is no need for doing some selection just an upper char was entered
      FInsert := true;
      //insert the new char in the text (depending on the chosen charCase)
      case CharCase of
        ecNormal : SelText := Char (Msg.CharCode);
        ecUpperCase : SelText := ToUpperCase(Char (Msg.CharCode));
        ecLowerCase : SelText := ToLowerCase(Char (Msg.CharCode));
      end;
      FInsert := false;
    end;
//  Msg.Result := 0;
//  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.UpdateCaret;
begin
  FCaret.FontHeight := RowHeight ('Qp'); //returns correct value in TLMDMemo
  FCaret.BuildCaret;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.CMFontChanged (var Msg : TMessage);
begin //added 02.11. JH
  inherited;
  if HandleAllocated and Focused then
    begin
      UpdateCaret;
      Caret.Enable;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMClear(var Msg : TWMClear);
begin
  SelText := '';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMCopy(var Msg : TWMCopy);
begin
  CopyToClipboard;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMPaste(var Msg : TWMPaste);
begin
  if FEnableKeyInput then
    PasteFromClipBoard;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMCut(var Msg : TWMCut);
begin
  CutToClipBoard;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMSize(var Msg : TWMSize);
begin
//  SetupRects;
  inherited;
  if Focused then //if added Aug 2001, otherwise bitmap buffering the background
                  //is created if not really needed (see other changes of August)
                  //Back bitmap now only be present if the control is focused.
    CreateBack
  else
    SetupRects
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
begin
  Msg.Result := 1;
end;

{ ---------------------------------------------------------------------------- }
//WMLButtonDblClick selects the current word
procedure TLMDBaseEdit.WMLButtonDblClk(var Msg : TWMLButtonDblClk);
begin
  inherited;
  if not Enabled then exit;

  if not FUserSelect then exit; //get our here if the user is not allowed to select text
  BeginUpdate;
  SelectCurrentWord;
  EndUpdate(true);
  DrawEditText (FCurrentChar);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMLButtonDown(var Msg : TWMLButtonDown);
begin
  inherited;
  if not Enabled then exit;

  FLeftButtonPressed := true;
  if not Focused and Enabled then
    SetFocus;
  DoLeftMouseBtn;
  // 7.0 RM
  if not Assigned(FTimerID) then
    FTimerID:=TLMDTimer.Create(200, DoOnTimer, True, FUseGlobalTimer);
  //-----
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.DoLeftMouseBtn;
var
  i,
  oldsel : Integer;
begin
{  if not Focused then //moved to WMLbuttonDown => otherwise error on excpetion (timer launched, will take focus again :-( )
    SetFocus;}

  oldsel := SelLength;
  i := CalcMousePos(FMousePos);
  if FDraggingAllowed and not FDragging and (i > FSelStart) and (i < FSelStart + FSelLength) then
    begin
      FCursor := Screen.Cursor;
      FDragging := true;
      Screen.Cursor := crDrag;
    end;
  CurrentChar := i;
  if oldsel <> SelLength then
    DrawEditText (FCurrentChar);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.DoOnTimer (Sender: TObject);
begin
  if HandleAllocated then
  begin
    if FSelLength <> 0 then
      FSelMode := true;
    DoLeftMouseBtn;
    FSelMode := false;
  end
  else
    FreeTimer;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMLButtonUp (var Msg : TWMLButtonUp);
var
  s : TLMDString;
  i : Integer;
begin
  inherited;

  //LMDApplication.Timer[FTimerID].Enabled := false;
  FreeTimer;

  FLeftButtonPressed := false;
  if FDragging then
    begin
      Screen.Cursor := FCursor;
      FDragging := false;
      //if we have not moved the mouse cursor away from the selected text it was just a single click
      if (FCurrentChar >= FSelStart) and (FCurrentChar <= FSelStart+FSelLength) then
        begin
          SelLength := 0;
          SelStart := FCurrentChar;
          DrawEditText (-1);
          exit;
        end;
      i := FCurrentChar;
      s := SelText;
      if (s[length(s)] = #13) then //added March 05 VB, otherwise #13#10 will be broken apart
        begin
          dec(FSelLength);
          s := SelText;
        end;
      //the dragged text will be removed
      SelText := '';
      if i > SelStart then //dragged to bottom
        dec (i, Length(s));
      if i <= Length(FText) then      // Added Feb 05 VB
       if FText[i] = #10 then dec(i, 1);
      //does all neccessary updatings
      CurrentChar := i;
      SelText := s;
      DrawEditText (i);
      //does all neccessary updatings
      CurrentChar := i;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMRButtonUp (var Msg : TWMRButtonUp);
var
  selfPopup : TPopupMenu;
  new       : TMenuItem;
  Pos       : TPoint;
  handled   : Boolean;
begin
  //get out here if the control if disabled
  if not Enabled then exit;

  Pos := Point(Msg.Xpos, Msg.YPos);
  //OnContextPopup menu handling added JH, Jan 04
  handled := false;

  if Assigned (OnContextPopup) then
    OnContextPopup (self, Pos, handled);

  if handled then exit;

  //get out here if the default menu shall been displayed
  if eoSuppressDefaultMenu in FOptions then exit;

  //the control is enabled so we can go on
  selfPopup := nil; //to avoid compiler warning
  if Assigned (PopupMenu) then
    begin
      inherited;
      Exit;
    end;

  try
    Pos := ClientToScreen (Point(Pos.X, Pos.Y));
    selfPopup := TPopupMenu.Create (self);
    with selfPopup do
      begin
        new := TMenuItem.Create (selfPopup);
        new.Caption := IDS_UNDO;
        new.Enabled := FCanUndo;
        new.OnClick := DoUndo;
        Items.Add (new);

        new := TMenuItem.Create (selfPopup);
        new.Caption := '-';
        Items.Add (new);

        if (eoAllowCut in FOptions) then
        begin
          new := TMenuItem.Create (selfPopup);
          new.Caption := IDS_CUT;
          new.Enabled := (FSelLength > 0) and not ReadOnly;
          new.OnClick := DoCut;
          Items.Add (new);
        end;

        if (eoAllowCopy in FOptions) then
        begin
          new := TMenuItem.Create (selfPopup);
          new.Caption := IDS_COPY;
          new.Enabled := (FSelLength > 0);
          new.OnClick := DoCopy;
          Items.Add (new);
        end;

        if (eoAllowPaste in FOptions) then
        begin
          new := TMenuItem.Create (selfPopup);
          new.Caption := IDS_INSERT;
          new.Enabled := (Clipboard.HasFormat (CF_TEXT) or Clipboard.HasFormat(CF_UNICODETEXT)) and not (ReadOnly);
          new.OnClick := DoPaste;
          Items.Add (new);
        end;

        new := TMenuItem.Create (selfPopup);
        new.Caption := IDS_DELETE;
        new.Enabled := (FSelLength > 0);
        new.OnClick := DoClear;
        Items.Add (new);

        new := TMenuItem.Create (selfPopup);
        new.Caption := '-';
        Items.Add (new);

        new := TMenuItem.Create (selfPopup);
        new.Caption := IDS_SELECTALL;
        new.Enabled := (Length (Text) > 0);
        new.OnClick := DoSelectAll;
        Items.Add (new);

        Popup (Pos.X, Pos.Y);

        Application.ProcessMessages;
      end;
  finally
    selfPopup.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMMouseActivate(var Msg : TWMMouseActivate);
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMMouseMove(var Msg : TWMMouseMove);
var
  i : Integer;
begin
  inherited;
  if not Enabled then exit;

  FMousePos := Msg.Pos;
  if Msg.Keys = 1 then
    begin
      if FUserSelect then
        FSelMode := true;
      i := CurrentChar;
      CurrentChar := CalcMousePos (Msg.Pos);
      FSelMode := false;
      if i <> CurrentChar then // to avoid flicker
        DrawEditText(FCurrentChar);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  inherited;
  Msg.Result := Msg.Result or DLGC_WANTCHARS or DLGC_WANTARROWS;
end;

{ ---------------------------------------------------------------------------- }
//procedure TLMDBaseEdit.CMEnter(var Message: TCMGOTFOCUS);
procedure TLMDBaseEdit.WMSetFocus(var Msg : TWMSetFocus);
begin
  inherited;

  //init the back
  CreateBack; //added Aug 2001, JH -> if out buffered and save res the
  //background has to be restored

  if Caret.Style = csDefault then
    begin
      Canvas.Font := GetFont;
      Caret.FontHeight := RowHeight ('Qp');
    end;

  Caret.BuildCaret;
  Caret.Enable;

  if RedrawOnEnter then DrawEditText (-1);

  if Flat then
    begin
      RestoreBorderFront; //this is needed if the window which containes the edit control lost the focus
      if IsThemed then DrawEditText (-1);
    end;

  if not GetListMode then
    begin
      FNoSelection := false; //line moved here by JH, has to be done always on
                             //entering, depending on NOTHING!!
                             //otherwise highlighted text will not be visible

      if (FHideSelection) or (FAutoSelect) then
        begin
          //if FAutoSelect then SelectAll;
          if AutoSelect and not (csLButtonDown in ControlState) then SelectAll;  //RM
          //      FNoSelection := false;
          if SelLength <> 0 then
            DrawEditText(-1);
        end;
    end;

  SetCaret;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMKillFocus(var Msg : TWMKillFocus);
begin
  if ((FHideSelection) and (SelLength > 0)) and not GetListMode then
    begin
      FNoSelection := true;
      DrawEditText(-1);
    end;
  inherited;
  if RedrawOnExit then DrawEditText (-1);
  Caret.DestroyCaret;
  //added Aug 2001, if FSaveRes is true background bitmap will be discarded
  //this will help saving GDI ressources
  if (FSaveRes) and Assigned(FBack) then
    begin
      FBack.Free;
      FBack := nil;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMSetText(var Msg : TWMSetText);
begin
  inherited;
  if not FSettingText then
    SetNewText;
  GetChange(nil); //15.07.
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMGetText(var Msg : TWMGetText);
begin
  inherited;
  if not FSettingText then
    GetNewText;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMQuit(var Msg : TWMQuit);
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  // 6.11
  if csDesigning in ComponentState then exit;
  // --
  if FGetFocusOnMouseAbove and Enabled then
    SetFocus
  else
    if IsThemed and Flat then Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  // 6.11
  if csDesigning in ComponentState then
    exit;
  // --
  if IsThemed and Flat then DrawEditText (-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WMGetTextLength(var Message : TMessage);
begin
  Message.result := Length (FText);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMCANUNDO (var Message : TMessage);
begin
  //returns true if undo is possible
  Message.result := LRESULT(FCanUndo);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMCHARFROMPOS (var Message : TMessage);
begin  //EM_CHARFROMPOS
  //returns the char index and the row index nearest to the specified pos
  Message.Result := MakeLong(CalcMouseCol (Message.lParamLo),
                             CalcMouseRow (Message.lParamHi));
{
  Message.ResultLo := CalcMouseRow (Message.lParamLo);
  Message.ResultHi := CalcMouseCol (Message.lParamHi);
}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMEMPTYUNDOBUFFER (var Message : TMessage);
begin  //EM_EMTPYUNDOBUFFER
  //clears the undo buffer -> undo not possible
  FUndoBuffer.Clear;
//  FUndoString := '';
  FCanUndo := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMFMTLINES (var Message : TMessage);
begin  //EM_FMTLINES
  //only affects WM_GETTEXT and EM_GETHANDLE
  //will return #13#13#10 for a linebreak due to wordwrapping
  //FSoftLineBreak := Boolean (Message.wParam);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMGETFIRSTVISIBLELINE (var Message : TMessage);
begin  //EM_GETFIRSTVISIBLELINE
  //first (zero based) line index or first (zero based) char index (single line edits)
  //should be overwritten by descendant classes!!
  Message.result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMGETHANDLE (var Message : TMessage);
begin  //EM_GETHANDLE
  //handle to the currently allocated memory for the multiline edit controls text
  Message.result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMGETLIMITTEXT (var Message : TMessage);
begin  //EM_GETLIMITTEXT
  Message.result := FMaxLength;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBaseEdit.EMGETLINE (var Message : TMessage);
begin  //EM_GETLINE
  //retrieves the content of the line given in wParam to the adress in lParam
  CopyMemory (Pointer(Message.lParam), @FText, Length(FText));
  //result contains the amount of chars copied
  Message.result := Length(FText);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMGETLINECOUNT (var Message : TMessage);
begin  //EM_GETLINECOUNT
  Message.result := 1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMGETMARGINS (var Message : TMessage);
begin  //EM_GETMARGINS
  //left margin in loResult, right margin in hiResult
  Message.result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMGETMODIFY (var Message : TMessage);
begin  //EM_GETMODIFY
  Message.result := LRESULT(FModified);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMGETPASSWORDCHAR (var Message : TMessage);
begin  //EM_GETPASSWORDCHAR
  //returns the password char
  Message.result := 0;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBaseEdit.EMGETRECT (var Message : TMessage);
begin  //EM_GETRECT
  if  Message.lParam <> 0 then
  PRect(Message.lParam)^ := FTextRect;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMGETSEL (var Message : TMessage);
const
  cor  = 1; //added 16.01.01, JH, formally the value was one to large
begin  //EM_GETSEL

  if Message.wParam <> 0 then
    PInteger(Message.wParam)^ := FSelStart-1;
  if Message.lParam <> 0 then
    PInteger(Message.lParam)^ := FSelStart + FSelLength - cor;

{  (Message.wParam) := FSelStart - 1;
  (Message.lParam) := FSelStart + FSelLength;}
  Message.ResultLo := FSelStart-1;
  Message.ResultHi := FSelStart + FSelLength - cor;
  end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMGETTHUMB (var Message : TMessage);
begin  //EM_GETTHUMB
  //returns the pos of the scroll box (multiline control)
  Message.result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMGETWORDBREAKPROC (var Message : TMessage);
begin  //EM_GETWORDBREAKPROC
  //this will be always 0
  Message.result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMLIMITTEXT (var Message : TMessage);
begin  //EM_LIMITTEXT
  FMaxLength := Message.wParam;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMLINEFROMCHAR (var Message : TMessage);
begin  //EM_LINEFROMCHAR
  case Message.wParam of
  {$ifdef LMDCOMP16}
  $7FFFFFFF
  {$else}
  -1
  {$endif}
   : {ich} Message.result := 0
    else
      Message.result := 0;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMLINEINDEX (var Message : TMessage);
begin  //EM_LINEINDEX
  //absolute char nr of line
  case Message.wParam of
  {$ifdef LMDCOMP16}
  $7FFFFFFF
  {$else}
  -1
  {$endif}
   : {return index of current line} Message.Result := 0;
  else //return index of line specified in wParam
    Message.Result := 0;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMLINELENGTH (var Message : TMessage);
begin  //EM_LINELENGTH
  case Message.wParam of
  {$ifdef LMDCOMP16}
  $7FFFFFFF
  {$else}
  -1
  {$endif}
   : Message.result := Length(FText);
   else
     Message.result := Length(FText);
   end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMLINESCROLL (var Message : TMessage);
begin  //EM_LINESCROLL
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMPOSFROMCHAR (var Message : TMessage);
var
  P: TPoint;
begin  //EM_POSFROMCHAR
  if  Message.wParam <> 0 then
    begin
      P := Point(FTextRect.Left + RowWidth (System.Copy(FText, 1, Message.lParam)) -
            FHiddenLeft,0);

      PPoint(Message.wParam)^ := P;

    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMREPLACESEL (var Message : TMessage);
begin  //EM_REPLACESEL

  SelText := PChar (Message.LParam);

  if not Boolean(Message.wParam) then
    Clearundo;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMSCROLL (var Message : TMessage);
begin  //EM_SCROLL
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMSCROLLCARET (var Message : TMessage);
begin  //EM_SCROLLCARET
  //makes the caret visible (if its outside the displayable area)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMSETHANDLE (var Message : TMessage);
begin  //EM_SETHANDLE
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDBaseEdit.EMSETLIMITTEXT (var Message : TMessage);
begin
end;}

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMSETMARGINS (var Message : TMessage);
begin  //EM_SETMARGINS
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMSETMODIFY (var Message : TMessage);
begin  //EM_SETMODIFY
  Modified := Boolean(Message.wParam);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMSETPASSWORDCHAR (var Message : TMessage);
begin  //EM_SETPASSWORDCHAR
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMSETREADONLY (var Message : TMessage);
begin  //EM_SETREADONLY
  ReadOnly := Boolean (Message.wParam);
  Message.result := 1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMSETRECT (var Message : TMessage);
begin  //EM_SETRECT
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMSETRECTNP (var Message : TMessage);
begin  //EM_SETRECTNP
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMSETSEL (var Message : TMessage);
begin  //EM_SETSEL
  {$ifdef LMDCOMP16}
  if Message.wParam = $7FFFFFFF then
  {$else}
  if Message.wParam = -1 then
  {$endif}
  begin
    SelLength := 0;
    exit;
  end;
  if (Message.wParam = 0) and (Message.lParam = -1) then begin SelectAll; exit; end;
  CurrentChar := Message.wParam + 1;
//  SelStart := Message.wParam + 1; //replaced by line above 02.09.99
  SelLength := Message.lParam - SelStart + 1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMSETTABSTOPS (var Message : TMessage);
begin  //EM_SETTABSTOPS
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDBaseEdit.EMSETWORDBREAK (var Message : TMessage);
begin
end;}

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMSETWORDBREAKPROC (var Message : TMessage);
begin  //EM_SETWORDBREAKPROC
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EMUNDO (var Message : TMessage);
begin  //EM_UNDO
  Undo;
  Message.result := LRESULT(FCanUndo);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if Assigned (FEditLabel) then
    FEditLabel.Enabled := Enabled;
  DrawEditText(-1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.Change;
begin
  if Assigned (FOnChange) then FOnChange (self);
  //Validation support, May 2006, RS
  if Assigned(Self.FValidator) then
    Self.FValidator.Validate(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.ChangedText(At : Integer);
begin
  if isUpdating then exit; //added 211099 JH, changed RM 10-2003

  DrawEditText (FCurrentChar);

  if csLoading in ComponentState then Exit;

  //the text has changed => rise the OnTextChangedAt event
  if Assigned (FOnTextChange) then FOnTextChange (self, At);

  //new from 4.5x on, OnChange will be risen as well
  Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.BeforeChangeText;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.FinishedSetSelText;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.HandleInsertText (at : Integer;var aValue : TLMDString);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.HandleReplaceText(at: Integer; aValue: TLMDString);
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.RepaintBack(aRect: TRect);
var
  myCanvas:      TCanvas;
  OldRgn, MyRgn: HRGN;
  lThemeMode:    TLMDThemeMode;
  r:             Integer;
begin
  if FOutBuffered and (FBack <> nil) then
    myCanvas := FBack.Canvas
  else
    myCanvas := Canvas;

  //first check for transparent background
  if CheckOptimized and BackDrawArea(myCanvas, aRect, Point(0 ,0), 0) then
    Exit;
  //no transparent background

  //*** added April 2002, JH

  //transparency has higher priority than xp theme background

  //none of the xp edit control states will be drawn (inner of)
  //if control is transparent!! even disabled edit control stay transparent!

  lThemeMode := UseThemeMode;

  if lThemeMode <> ttmNone then
  begin
    //Clip region might be already set in descendant classes -
    //we have to get current clip region

    OldRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(myCanvas.Handle, OldRgn);
    with aRect do
      MyRgn := CreateRectRgn(Left, Top, Right, Bottom);
    if r = 1 then
      CombineRgn(MyRgn, MyRgn, OldRgn, RGN_AND);
    SelectClipRgn(myCanvas.Handle, MyRgn);

    myCanvas.Brush.Style := bsSolid; // Some strange bug is fixed here. To
                                     // reproduce: select and then deselect
                                     // some text in lmd-memo with VCL Styles
                                     // turned on. Without this line the
                                     // background will be painted as white,
                                     // independed of style's back color.
    DrawThemeBevel(lThemeMode, myCanvas, ClientRect);

    if r = 1 then
      SelectClipRgn(myCanvas.Handle, OldRgn)
    else
      SelectClipRgn(myCanvas.Handle, 0);
    DeleteObject(MyRgn);
    DeleteObject(OldRgn);

  //  if not LMDApplication.ThemeUseColorProperty then  //VB March 2008
    Exit;
  end;

  //color has lower priority than xp theme background
  //(unless LMDApplication.ThemeUseColorProperty is set to true) VB March 2008
  //***

  myCanvas.Brush.Color := GetBackColor; // VCL styles do not return ecFillColor
                                        // for edits. So, there no way to
                                        // override GetBackColor properly.
  myCanvas.Brush.Style := bsSolid;
  myCanvas.FillRect(aRect);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.AllowedOperation(textToInsert : TLMDString) : Boolean;
begin
  result := not ReadOnly;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBaseEdit.DoDestroyBufferEntry (Sender : TObject; item : Pointer);

begin
{
  FreeMem (PLMDUndoRecord(item)^.newText);
  FreeMem (PLMDUndoRecord(item)^.oldText);
}

  Dispose (PLMDUndoRecord(item));

end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.AllowCopyPaste : Boolean;
begin
  result := [eoAllowCopy, eoAllowPaste] * FOptions = [eoAllowCopy, eoAllowPaste];
end;

{ ---------------------------------------------------------------------------- }
//if this method returns true the controls content will be repainted if it
//looses the focus
function TLMDBaseEdit.RedrawOnExit: Boolean;
begin
  result := (IsThemed and Flat);
end;

{ ---------------------------------------------------------------------------- }
//if this method returns true the controls content will be repainted if it
//gets the focus
function TLMDBaseEdit.RedrawOnEnter: Boolean;
begin
  result := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.DoThemeChanged;
begin
  inherited;
  RecreateWnd;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetListMode:Boolean;
begin
  result:=False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetLMDCaretPos (x,y : Integer);
begin
  if FCaret.Style = csUnder then
    inc (Y, LMDGetTextHeight (Canvas, 'Qp') - 3);
  if FCaret.Style = csUnderBlock then
    inc (Y, LMDGetTextHeight (Canvas, 'Qp') - FCaret.Height - 2);
  SetCaretPos (X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
  M: TLMDEditModes;
begin
  inherited KeyDown (Key, Shift);
  M := LMDApplication.EditMode;
  if ssAlt in Shift then
    M := M + [emAlt]
  else
    M := M - [emAlt];
  if ssCtrl in Shift then
    M := M + [emCtrl]
  else
    M := M - [emCtrl];
  if ssShift in Shift then
    M := M + [emShift]
  else
    M := M - [emShift];

  if  LMDApplication.EditMode <> M  then
    LMDApplication.EditMode := M;
  GetCommandKey (Key, Shift);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.KeyUp(var Key: Word; Shift : TShiftState);
var
  M: TLMDEditModes;
begin
  inherited KeyUp (Key, Shift);
  M := LMDApplication.EditMode;
  if ssAlt in Shift then
    M := M + [emAlt]
  else
    M := M - [emAlt];
  if ssCtrl in Shift then
    M := M + [emCtrl]
  else
    M := M - [emCtrl];
  if ssShift in Shift then
    M := M + [emShift]
  else
    M := M - [emShift];
  if  LMDApplication.EditMode <> M  then
    LMDApplication.EditMode := M;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.RestoreBorderFront;
begin
  if (IsThemed and (GetBevel.Mode = bmWindows)) then
    begin
      if Transparent then
        Invalidate
      else
        if Flat then DrawEditText (-1);
    end
  else
    inherited RestoreBorderFront;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.RestoreBorderBack;
begin
  if IsThemed then
    begin
      if Transparent then
        Invalidate
      else
        if Flat then DrawEditText (-1);
    end
  else
    inherited RestoreBorderBack;
//  else
//    Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
  //Validation support, May 2006, RS
  if  Assigned(Self.FValidator) and (AComponent = Self.FValidator) then
    Self.SetValidator(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetName(const Value: TComponentName);
begin
  if Assigned (FEditLabel) and (csDesigning in ComponentState) and ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
    FEditLabel.Caption := Value;
  inherited SetName(Value);
  {if csDesigning in ComponentState then
    Text := '';}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetOptions(const Value: TLMDEditOptions);
begin
  FOptions := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if FEditLabel = nil then exit;
  FEditLabel.Parent := AParent;
  FEditLabel.Visible := True;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDBaseEdit.BeginUpdate;
begin
  inc (FUpdateCount);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.EndUpdate;
begin
  inherited EndUpdate;
  if Repaint and not isUpdating then
    DrawEditText(-1);
  {if FUpdateCount > 0 then
    Dec (FUpdateCount)
  else
    if not FNoUpdate then
      DrawText(-1);}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.FreeTimer;
begin
  // 7.0 RM
  if Assigned(FTimerID) then
    begin
      FTimerID.Enabled := false;
      FTimerID.OnTimer := nil;
      FreeAndNil(FTimerID);
    end;
  // -----
end;

{ -------------------------------- public ------------------------------------ }
procedure TLMDBaseEdit.SetSelection;
begin
  if FInsert then exit; //just an upper char has been entered
  if FDragging then exit; //we are moving the selected text
  if not FUserSelect and (emShift in LMDApplication.EditMode) then
    LMDApplication.EditMode := LMDApplication.EditMode - [emShift];

  if (emShift in LMDApplication.EditMode) or (FSelMode) then
    begin
      //no previuos selected text
      if FSelLength = 0 then
        begin
          //get the difference of the current and the previous cursor pos
          FSelLength := Abs(FPrevCharPos - FCurrentChar);
          //if cursor went left reset SelStart
          if FCurrentChar < FPrevCharPos then
            FSelStart := FCurrentChar;
        end
      else
        if FCurrentChar > FSelStart then // we are stepping right
          if FCurrentChar < FSelstart + FSelLength then // we are in the selected text or left of it
            if FCurrentChar > FPrevCharPos then // we are at the top of sel text stepping right
              begin
                FSelLength := (FSelStart + FSelLength) - FCurrentChar;
                FSelStart := FCurrentChar;
              end
            else // we are at the end of sel text stepping left
              FSelLength := FCurrentChar - FSelStart
          else
            if FPrevCharPos > FSelStart then
              FSelLength := FCurrentChar - FSelStart // just expand the selection to the new CurrentChar
            else // toggle the sel direction
              begin
                FSelStart := FSelStart + FSelLength;
                FSelLength := FCurrentChar - FSelStart;
              end
        else
          if (FPrevCharPos = FSelStart) then // we are stepping left (expanding sel Text)
            begin
              FSelLength := FSelStart - FCurrentChar + FSelLength;
              FSelStart := FCurrentChar;
            end
          else
            begin // we toggle the sel direction : FCurrentChar some text OldSelStart SelectedText PreviousCurrentChar
              FSelLength := FSelStart - FCurrentChar;
              FSelStart := FCurrentChar;
            end
    end
  else
    begin
      FSelLength := 0; //no more selection
      FSelStart := FCurrentChar;
    end;
end;

{ ---------------------------------------------------------------------------- }
//SelectCurrentWord selects the active word
procedure TLMDBaseEdit.SelectCurrentWord;
var
  i, L : Integer;
begin
  //if there is no text there is nothing to select
  if Text = '' then exit;
  //make a copy of the cursor pos
  i := FCurrentChar;
  L := Length(Text);
  if (i > L) then i := L; // Added Feb 05 VB

  if (i > 1) and (i <= L) and LMDCharInSet(FText[i], FDelimiters) then //we are behind the word to be selected
    dec(i);
  //search for a left border of the word
  if  (i <= L)  then
    while (i > 1) and not LMDCharInSet(Text[i], FDelimiters)  do
      dec (i);
  //select from the first letter on the right side of the border on
  if i <> 1 then inc(i);
  //set the selection start to the point
  FSelStart := i;
  //reset i to the current cursor pos
  i := FCurrentChar;
  //search for a right border
  while (i <= L) and not LMDCharInSet(Text[i], FDelimiters) do
    inc(i);
  //set the length of the selection (calculated pos - previous calc pos (SelStart)
  SelLength := i - SelStart;
end;

{ ---------------------------------------------------------------------------- }
//SelectRightWord selects the right side of the current word (from cursor pos)
procedure TLMDBaseEdit.SelectRightWord;
var
  i, L : Integer;
begin
  i := FCurrentChar;
  L := Length(Text);
  SelLength := 0; // Added Feb 05 VB
  //go left until the end of text is reached or an delimiter is found
  while (i < L) and not LMDCharInSet(Text[i], FDelimiters) do
    inc (i);
  if (i <= L) and LMDCharInSet(Text[i], FDelimiters)
    then dec(i);
  SelStart := FCurrentChar;
  SelLength := i - FSelStart + 1;
end;

{ ---------------------------------------------------------------------------- }
//SelectLeftWord selects the left side of the current word (from cursor pos)
procedure TLMDBaseEdit.SelectLeftWord;
var
  i, L : Integer;
begin
  i := FCurrentChar;
  L := Length(Text);
  SelLength := 0; // Added 18 Feb 05 VB
  if  i <= L  then
    while (i > 1) and not LMDCharInSet(Text[i], FDelimiters)  do
      dec (i);
  if (i <= L) and LMDCharInSet(Text[i], FDelimiters) then
    inc(i);
  SelStart := i;
  SelLength := FCurrentChar - i;
end;

{ ---------------------------------------------------------------------------- }
//Search goes through the text looking out for s it returns true if it was found
function TLMDBaseEdit.Search (s : TLMDString;from : TLMDSearchStart;caseSensitive, wholeWords : Boolean;
                              direction : TLMDSearchDirection) : Boolean;
var
  i,
  pos : Integer;
  cancel,
  found : Boolean;
  s2 : TLMDString;
begin
  result := false;
  FFoundAtPos := 0;
  if Length (Text) = 0 then exit;
  FSearching := true;
  found := false;
  cancel := false;
  //make all letters UpperCase if there is no case sensitivity
  if not caseSensitive then
    s := {*Ansi*}UpperCase (s);
  pos := 0; //to avoid compiler warning
  //get starting point (absolute char position)
  case from of
    stTop : pos := 1;
    stBottom : pos := Length(Text);
    stCursor : if FCurrentChar <= Length(Text) then
                 pos := FCurrentChar
               else
                 pos := Length(Text);
  end;
  //set toCheck string
  s2 := '';
  while (not found) and (not cancel) do
    begin
      //concat a new letter to the toCheck string s2
      //and get to the next char depending on the search direction
      case direction of
        sdUp : begin s2 := Text[Pos] + s2; dec(Pos); end;
        sdDown : begin s2 := s2 + Text[Pos]; inc(Pos); end;
      end;
      //if the toCheck string s2 and s have the same length
      if Length (s2) = Length (s) then
        begin
          //if caseSensitive just compare
          if caseSensitive then
            begin
              found := (s2 = s);
            end
          else //make all letters of s2 Uppercase (those of s are already UpperCased) and compare
            found := ({*Ansi*}UpperCase (s2) = s);
          if (found) and (wholeWords) then
            case direction of
              sdDown:
                if (pos + 1 < Length (FText)) and (pos - Length(s) > 1) then
                  if not LMDCharInSet(Text[pos - Length(s) - 1], FDelimiters) or
                     not LMDCharInSet(Text[pos], FDelimiters) then
                    found := false;
              sdUp:
                if (pos > 0) and (pos + Length(s) < Length(Text)) then
                  if not LMDCharInSet(Text[pos + Length(s) + 1], FDelimiters) or
                     not LMDCharInSet(Text[pos], FDelimiters) then
                    found := false;
            end;
          //delete the case depended oldest char of the toCheck string
          case direction of
            sdUp : Delete (s2, Length(s2), 1);
            sdDown : Delete (s2, 1, 1);
          end;
        end;
      case direction of
        sdUp : if Pos <= 0 then
                 if (FAskForLoop) and (Application.MessageBox (int_Ref(IDS_SEARCHMSG1), int_Ref(IDS_SEARCH), MB_YESNO) = IDYES) then
                   begin
                     pos := Length(text);
                     s2 := '';
                   end
                 else
                   cancel := true;
        sdDown : if Pos > Length(Text) then
                   if (FAskForLoop) and (Application.MessageBox (int_Ref(IDS_SEARCHMSG2), int_Ref(IDS_SEARCH), MB_YESNO) = IDYES) then
                     begin
                       pos := 1;
                       s2 := '';
                     end
                   else
                     cancel := true;
      end;
    end; //end while
  // if s has been found then set SelStart to pos and set the SelLength
  if found then
    begin
      //to make the compiler happy
      i := 0;
      case direction of
        sdDown : i := Pos - Length(s);
        sdUp : i := Pos + 1;
      end;
      CurrentChar := i; //make first letter of the found text visible
      CurrentChar := Pos; //go to the last letter of the found text
      FFoundAtPos := i;
      SelStart := i; //set selection on found text
      SelLength := Length (s);
    end;
  //return found
  result := found;
  FSearching := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.SearchAndReplace (s, r : TLMDString;from : TLMDSearchStart;caseSensitive, wholeWords : Boolean;
                      direction : TLMDSearchDirection; ask, all : Boolean) : Boolean;
begin
  //nothing done (or canceled)
  result := false;
  //while something to replace is found
  while Search (s, from, caseSensitive, wholeWords, direction) do
    begin
      from := stCursor;
      if ask then //if the user wants to be asked
        if not all then //if not all at once add this choice
          case MessageDlg (IDS_REPLACE+'?', mtConfirmation, [mbYES,mbNO,mbAll, mbCancel],0) of
             mrAll : all := true;
             mrYes : begin result := true; SelText := r; end;
             mrCancel : begin result := false; exit; end;
             mrNo :; //is about to be ignored
          end
        else //ask to replace each one
          begin
            case MessageDlg (IDS_REPLACE+'?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
              mrCancel : begin result := false; Exit; end;
              mrYes : begin result := true; SelText := r; end;
              mrNo:; //...
            end;
          end
      else //if not ask then replace
        begin
          SelText := r;
          result := true;
        end;
      if not all then exit;
      SelLength := 0;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.FoundAtPos: integer;
begin
  result := FFoundAtPos;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.GotoParaStart;
var
  i : Integer;
begin
  //search for a linefeed char or the first char at all
  i := FCurrentChar;
  while (i > 1) and (Text [i-1] <> #10) do
    dec(i);
  CurrentChar := i;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.GotoParaEnd;
var
  i, L : Integer;
begin
  //search for a carriage return or the last char at all
  L := Length(Text) + 1;
  i := FCurrentChar;

  if  i > 0 then
    while (i < L) and (Text [i] <> #13) do
       inc(i);
  CurrentChar := i;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.GotoNextWord;
begin
  if (FCurrentChar < Length(Text))
      and LMDCharInSet(Text[FCurrentChar], FDelimiters) then
    CurrentChar := CurrentChar + 1;
  while (FCurrentChar <= Length(Text))
        and not LMDCharInSet(Text[FCurrentChar], FDelimiters) do
    CurrentChar := CurrentChar + 1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.GotoPrevWord;
var
  i, L : Integer;
begin
  i := CurrentChar;
  L := Length(Text);
  if (i > L) then i := L;  // Added Feb 05 VB
  if (i > 1) and (i <= L) and LMDCharInSet(Text[i], Delimiters)  then
    dec (i);
  if  (i <= L) then
    while (i > 1) and not LMDCharInSet(Text[i], Delimiters) do
      dec (i);
  Currentchar := i;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetCurrentWord : TLMDString;
var
  i, j, L : Integer;
begin
  i := CurrentChar;
  L := Length(Text);
  if i > L then i := L; // Added Feb 05 VB
  if (i > 1) and (i <= L) and LMDCharInSet(Text[i], FDelimiters)  then
    dec(i);
  if  (i <= L) then
    while (i > 1) and not LMDCharInSet(Text[i], FDelimiters)  do
      dec (i);
  j := CurrentChar;
  while (j < L) and not LMDCharInSet(Text[j], FDelimiters) do
    inc(j);
  result := System.Copy(Text, i, j - i);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetLength : Integer;
begin
  result := Length (FText);
end;

{ ---------------------------------------------------------------------------- }

function TLMDBaseEdit.CountWords : Integer;
var
  Source, SourceEnd : integer;
  B: Boolean;
begin
  result := 0;
  B := False;
  Source := 1;
  SourceEnd := Source + Length(Text);
  //step through the whole text
  while (Source < SourceEnd) do
    begin
      //get to the next char
      inc(Source);
      //if this char is a delimiter than we have found another word
      if  LMDCharInSet(Text[Source], FDelimiters) then
        begin
          if  B then
            inc(result);
          B := False;
        end
      else
        B := True;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.Replace (start, count : Integer; s : TLMDString);
var
  oSS, oSL : Integer;
begin
  oSS := SelStart;
  oSL := SelLength;

  SelStart := start;
  SelLength := count;
  SelText := s;

  SelStart := oSS;
  SelLength := oSL;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.Upper (start, count : Integer);
begin
  Replace (start, count, {*Ansi*}UpperCase (System.Copy(FText, start, count)));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.Lower (start, count : Integer);
begin
  Replace (start, count, {*Ansi*}LowerCase (System.Copy(FText, start, count)));
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.Cut (start, count : Integer) : TLMDString;
begin
  SelStart := start;
  SelLength := count;

  result := SelText;
  SelText := '';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.Add (const S : TLMDString);
begin
  Text := FText + S;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.Insert (at : Integer; const S : TLMDString);
begin
  SelLength := 0;
  SelStart := at;
  SelText := S;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.Copy (start, count : Integer) : TLMDString;
begin
  result := System.Copy(FText, start, count);
end;

{ ---------------------------------------------------------------------------- }
//SelectAll selects the whole text
procedure TLMDBaseEdit.SelectAll;
begin
  if FCursor2EndOnSelectAll then
    GotoParaEnd;
  FSelStart := 1;
  FSelLength := Length (Text);
  DrawEditText (-1);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBaseEdit.SetSelTextBuf(Buffer: PLMDChar);
begin
  SelText := TLMDString (Buffer);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetSelTextBuf(Buffer: PLMDChar; BufSize: Integer): Integer;
begin
  if SelLength <= BufSize then
    Buffer := PLMDChar (SelText)
  else
    Buffer := PLMDChar (System.Copy(SelText, 1, BufSize));
  result := Length (TLMDString (Buffer));
end;

{ ---------------------------------------------------------------------------- }
//Clear deletes the whole text
procedure TLMDBaseEdit.Clear;
begin
  SelectAll;
  SelText := '';
end;

{ ---------------------------------------------------------------------------- }
//ClearSelection deletes the current selection
procedure TLMDBaseEdit.ClearSelection;
begin
  SelText := '';
end;

{ ---------------------------------------------------------------------------- }
//CopyToClipboard copies the current selection into the Clipboard
procedure TLMDBaseEdit.CopyToClipboard;
begin
  if (eoAllowCopy in FOptions) then
    LMDCopyTextToClipBoard(SelText, false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.CutToClipboard;
begin
  if (eoAllowCut in FOptions) then
  begin
    LMDCopyTextToClipBoard(SelText, false);
    SelText := '';
  end;  
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.PasteFromClipboard;
begin
  if (eoAllowPaste in FOptions) then
  begin
    FIsPasting := true;
    SelText := LMDGetTextFromClipBoard;
    FIsPasting := false;
  end;  
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.Undo;
var
  p : PLMDUndoRecord;
  //s : TLMDString;
begin
  if (FCanUndo) and (FUndoBuffer.Count <> 0) then
    begin
      FUndoing := true;

      p := PLMDUndoRecord(FUndoBuffer.Get);

      //replace the inserted text by the old text
      SelStart := p.SelStart;
      SelLength := p.newlength;
//      SetLength (s, p.selLength);
      SelText := System.Copy(p.oldText, 1, p.selLength);

      FUndoing := false;

      if FUndoBuffer.Count = 0 then FCanUndo := false;

      //FUndoString;
      CurrentChar := p.current;
      FSelStart := p.SelStart;
      SelLength := p.SelLength;

//      FreeMem (p^.oldText);
//      FreeMem (p^.newText);

      Dispose (p); //free undo record

    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.ClearUndo;
begin
  FRedoBuffer.Clear;
  FUndoBuffer.Clear;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.ReDo;
var
  p : PLMDUndoRecord;
  //s : TLMDString;
begin
  if FCanRedo then
    begin
      FRedoing := true;
      p := PLMDUndoRecord(FRedoBuffer.Get);

      SelStart := p.SelStart;
      SelLength := p.newLength;
      SelText := System.Copy(p.oldText, 1, p.selLength);

//      SetLength (s, p.selLength);
//      CopyMemory (PChar(s), p.oldText, p.selLength);
//      SelText := s;

      CurrentChar := p.current;
      FSelStart := p.SelStart;
      SelLength := p.SelLength;

      if FRedoBuffer.Count = 0 then FCanReDo := false;

//      FreeMem (p^.oldText);
//      FreeMem (p^.newText);

      Dispose (p); //free undo record

    end;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDBaseEdit.Create (AOwner : TComponent);
begin
  inherited Create (AOwner);
  //ControlStyle:=ControlStyle + [csOpaque] - [csSetCaption, csAcceptsControls, csParentBackground];
  ControlStyle:=ControlStyle + [csOpaque] - [csSetCaption, csAcceptsControls{$IFDEF LMDCOMP7}, csParentBackground{$ENDIF}];
  {$IFNDEF LMDCOMP7}
  BeginUpdate;
  ParentBackground := false;
  EndUpdate;
  {$ENDIF}
  FForceOverwriteMode := false;
  FFoundAtPos := 0;
  FSearching := false;
  FOptions := [eoAllowCopy, eoAllowCut, eoAllowPaste];
  FTextRectBorderY := 1;
  Height := 21;

  FFont3D := TLMD3DCaption.Create;
  FFont3D.OnChange := GetChange;
  Bevel.Mode := bmWindows;
  FCaret := TLMDCaret.CreateExt(self);
  FCaret.Col := 1;

  //FNoUpdate := false; //if true EndUpdate will not Call DrawText if FUpDateCount = 0!!

  FDraggingAllowed := true;

  FUndoBuffer := TLMDDynLIFOBuffer.Create;
  FUndoBuffer.OnDestroyItem := DoDestroyBufferEntry;
  FRedoBuffer := TLMDDynLIFOBuffer.Create;
  FRedoBuffer.OnDestroyItem := DoDestroyBufferEntry;

  Cursor := crIBeam;
  Color  := clWindow;  //7.0 RM

  FTabEnter := false;

  FCursor2EndOnSelectAll := false;

  FHideSelection := true;
  FAutoSelect := false;
  FDragging := false;
  FModified   := false;
  FReadOnly   := false;
  FOEMConvert := false;
  FInsert     := false; //needed during char input of a captial letter
  FGetFocusOnMouseAbove := false;
  FLeftButtonPressed := false;
  FNoSelection := true; //changed from false to true because of MaskEdit (meDate) 02/2000 JH
  FSettingText := false;
  FUserSelect := true;

  FAlignment := taLeftJustify;

  FHiddenLeft := 0;
  TabStop     := true;
  FDelimiters := [' '];

  FCurrentChar := 1;
  FPrevCharPos := 1; //contains previous value of FCurrentCharPos
  FFirstLine  := 1;

  FMaxLength  := 0;
  FSelStart   := 1;
  FSelLength  := 0;
  FCanUndo    := true;
  FCanRedo    := false;
  FUndoing    := false;
  FRedoing    := false;

  FHighBackColor := clHighLight;
  FHighTextColor := clHighLightText;

  FTimerId := nil;

  FOutBuffered := true;
  FBack := nil;
  FPaintRect := Rect (-1,-1,-1,-1);

  FAskForLoop := true;
  FSaveRes := true;

  // Bound label Support
  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  FEditLabel := nil;
  FHasBoundLabel := false;
  FEnableKeyInput := true;

  // TripleClick
  FDoubleClickCX := GetSystemMetrics(SM_CXDOUBLECLK);
  FDoubleClickCY := GetSystemMetrics(SM_CYDOUBLECLK);
  FDoubleClickTimeout := GetDoubleClickTime();

  FIsPasting := false;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDBaseEdit.Destroy;
begin
  if FBack <> nil then
    begin
      FBack.Free;
      FBack := nil;
    end;

  FreeTimer;

  FRedoBuffer.Free;
  FUndoBuffer.Free;

  FCaret.Free;

  FFont3D.OnChange := nil;
  FFont3D.Free;

  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBaseEdit.DestroyWindowHandle;
begin
  //We should destroy the timer here, because its actions
  //require some painting-repainting, and because of that, self.Handle <> 0
  FreeTimer;

  inherited;
end;

{ ---------------------------------------------------------------------------- }
//Paint just paints the border
procedure TLMDBaseEdit.Paint;
var
  lThemeMode: TLMDThemeMode;
begin
  if isUpdating or ([csLoading,csReading, csDestroying]*ComponentState<>[]) then
    Exit;  // RM 10-03

  FillControl;

  if Focused or not Flat or (csDesigning in ComponentState) or IsThemed then
  begin
    lThemeMode := UseThemeMode;
    if (lThemeMode <> ttmNone) and (GetBevel.Mode = bmWindows) then
      DrawThemeBevel(lThemeMode, Canvas, GetClientRect)
    else
      GetBevel.PaintBevel(Canvas, GetClientRect, Transparent)
  end
  else
    RestoreBorderBack;
  SetCaret;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.Loaded;
begin
  inherited Loaded;
  SetLabelPosition(FLabelPosition);  // Nov 03 RM, otherwise Left position does not work
  SetupRects; //inserted Aug 2001, JH -> was formally done in CreateBack
  Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetupEditLabel;
begin
  if Assigned(FEditLabel) then exit;
  FHasBoundLabel:=true;
  FEditLabel := TLMDBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  FEditLabel.FocusControl := Self;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.ModifyTextRect;
begin
  //gives the descandand classes the opportunity to modify the TextRect
  if IsThemed then
    begin
      Inc(FTextRect.Left);
      Inc(FTextRect.Top);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.ModifyPaintRect;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.ModifyInnerRect;
var
  lThemeMode: TLMDThemeMode;
  //c: TColor;

   procedure getXPContentRect;
   var
     box : TThemedEdit;
   begin
      box := teEditTextNormal;
      if Focused then box := teEditTextFocused;
      if MouseAbove then box := teEditTextFocused;
      if ReadOnly then box := teEditTextReadOnly;
      if not Enabled then box := teEditTextDisabled;

      {$IFDEF LMDCOMP16}
      if not (csDesigning in ComponentState) and StyleServices.Enabled and  not StyleServices.IsSystemStyle then
      begin
        InflateRect(FInnerRect, -2, -2);
        //<-- quick and dirty workaround - to be reworked [VB]
        //StyleServices.GetElementColor(ThemeServices.GetElementDetails(box), ecFillColor, c);
        //Color := c;
        //-->
      end
      else
        FInnerRect := LMDThemeServices.ContentRect(lThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(box), FInnerRect);
      {$ELSE}
      FInnerRect := LMDThemeServices.ContentRect(lThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(box), FInnerRect);
      {$ENDIF}
   end;

begin
  lThemeMode := UseThemeMode;
  //gives the descendand classes the opportunity to modify the PaintRect
  if (lThemeMode <> ttmNone) and (GetBevel.Mode = bmWindows) then
    getXPContentRect
  else
    InflateRect (FInnerRect, -GetBevel.BevelExtend, -GetBevel.BevelExtend);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.WndProc(var Msg: TMessage);
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

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.TriggerTripleClick;
begin
  if FDragging then
    begin
      Screen.Cursor := FCursor;
      FDragging := false;
    end;
  SelectAll;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.CreateBack;
begin
  if not FOutBuffered then exit;
  if FBack = nil then
    FBack := TBitmap.Create;
  FBack.Width := Width;
  FBack.Height := Height;
  RepaintBack (GetClientRect);

  FInnerRect := GetClientRect;

  ModifyInnerRect;

  //FInnerRect is the control less the border

  FPaintRect := FInnerRect;
  //FPaintRect is the whole area to be repainted in DrawText
  //change it if you would like adding controls to the edit
  ModifyPaintRect;

  FTextRect := FPaintRect;

  if eoNarrowHeight in FOptions then
    FTextRectBorderY := 0
  else
    FTextRectBorderY := 1;

  InflateRect (FTextRect, -1, -FTextRectBorderY);
  //change FTextRect if you would like to paint several graphical items on a side by yourself

  ModifyTextRect;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  if FHasBoundLabel then
    Filer.DefineBinaryProperty('SubLabel', ReadEditLabel, nil, false);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.fcGetModified: Boolean;
begin
  result := Modified;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.fcGetReadOnly: Boolean;
begin
  result := ReadOnly;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.fcGetInvalidData: Boolean;
begin
  //Result is now defined by the last validation result; May 2006, RS
  Result := Self.FErrorIndication;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetupRects;
begin
  if isUpdating or ([csLoading,csReading, csDestroying]*ComponentState<>[]) then exit;  // RM 10-03

  FInnerRect := GetClientRect;

  //FInnerRect is the control less the border

  ModifyInnerRect;

  FPaintRect := FInnerRect;
{  Inc (FPaintRect.Left);
  Inc (FPaintRect.Top);
  Dec (FPaintRect.Right);
  Dec (FPaintRect.Bottom);}
  //FPaintRect is the whole area to be repainted in DrawText
  //change it if you would like adding controls to the edit
  ModifyPaintRect;

  if eoNarrowHeight in FOptions then
    FTextRectBorderY := 0
  else
    FTextRectBorderY := 1;

  FTextRect := FPaintRect;
  InflateRect (FTextRect, -1, -FTextRectBorderY);
  //change FTextRect if you would like to paint several graphical items on a side by yourself

  ModifyTextRect;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseEdit.FillControl;
begin
  inherited FillControl;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
var
  oldsel,
  i : Integer;
//  aControl: TWinControl;

  //special find next control method which iterates through all parent controls
  //until there a re no more parent control or the next control according
  //to the taborder has been found
  {function FindNextControl(GoForward, CheckTabStop, CheckParent: Boolean): TWinControl;
  var
    I, StartIndex: Integer;
    List: TList;
    aControl,
    aParent : TWinControl;
  begin
    Result := nil;
    aParent := self.Parent;
    aControl := self;
    while not Assigned (Result) and Assigned (aParent) do
      begin
        List := TList.Create;
        try
          aParent.GetTabOrderList(List);
          if List.Count > 0 then
          begin
            StartIndex := List.IndexOf(aControl);
            if StartIndex = -1 then
              if GoForward then StartIndex := List.Count - 1 else StartIndex := 0;
            I := StartIndex;
            repeat
              if GoForward then
              begin
                Inc(I);
                if I = List.Count then I := 0;
              end else
              begin
                if I = 0 then I := List.Count;
                Dec(I);
              end;
              aControl := TWinControl(List[I]);
              if aControl.CanFocus and
                (not CheckTabStop or aControl.TabStop) and
                (not CheckParent or (aControl.Parent = Self)) and
                (self <> aControl) then
                Result := aControl;
            until (Result <> nil) or (I = StartIndex);
          end;
        finally
          List.Free;
        end;
        aControl := aParent;
        if not Assigned (result) then aParent := aParent.Parent;
      end;
  end;}

  // returns true if only Ctrl is pressed (and not when ALT Gr = Ctrl+Alt)
  function CheckCtrlOnlyMode:Boolean;
  begin
    result:=(emCtrl in LMDApplication.EditMode) and not (emAlt in LMDApplication.EditMode);
  end;

begin
  oldSel := SelLength;
  if not Enabled then exit;
  Case KeyCode of
    VK_RETURN : if FTabEnter and not (emCtrl in LMDApplication.EditMode) then
                  begin
                    {aControl := FindNextControl(not (emShift in LMDApplication.EditMode), true, false);
                    if Assigned (aControl) then
                      aControl.SetFocus;}
                    SendMessage (GetTopParentHandle, WM_NEXTDLGCTL, 0, 0);
                    inherited;
                  end;
    VK_INSERT : //no special command => just switch from insert to overwrite or vice versa
                if (emShift in LMDApplication.EditMode) and FEnableKeyInput then
                  PasteFromClipBoard
                else
                  if emCtrl in LMDApplication.EditMode then
                    CopyToClipboard
                  else
                    if not (emAlt in LMDApplication.EditMode) then
                      if emInsert in LMDApplication.EditMode then
                        LMDApplication.EditMode := LMDApplication.EditMode - [emInsert]
                      else
                        LMDApplication.EditMode := LMDApplication.EditMode + [emInsert];
    VK_HOME : begin
                if emCtrl in LMDApplication.EditMode then
                  CurrentChar := 1
                else
                  GotoParaStart;
              end;
    VK_END : begin
               GotoParaEnd;
             end;
    VK_LEFT : if FCurrentChar > 1 then
                begin
                  i := FCurrentChar - 1;
                  if Text[i] = #10 then
                    CurrentChar := i - 1
                  else
                    CurrentChar := i;
                  if (emCtrl in LMDApplication.EditMode) then
                    GotoPrevWord;
                end else //added 260404 JH
                   if not (emShift in LMDApplication.EditMode) then
                     SelLength := 0;
    VK_RIGHT : if (FCurrentChar < Length(Text)+1) and (Length (Text) <> 0) then
                 begin
                   CurrentChar := FCurrentChar + 1;
                   if FCurrentChar <= Length(Text) then // Added Feb 05 VB
                     if Text[FCurrentChar] = #10 then
                       CurrentChar := FCurrentChar + 1; // will be dec by 1
                   if (emCtrl in LMDApplication.EditMode) then
                     GotoNextWord;
                 end else //added JH Nov 03
                   if not (emShift in LMDApplication.EditMode) then
                     SelLength := 0;
    VK_DELETE : if FEnableKeyInput then
                 if emShift in LMDApplication.EditMode then
                   CutToClipboard
                 else
                   begin
                     if (not ReadOnly) and (Length(Text) > 0) then
                       begin
                         //if there is no selected text select the next char
                         if FSelLength = 0 then
                           FSelLength := 1;
                         SelText := '';
                       end;
                   end;
    VK_ESCAPE : SelLength := 0;
    VK_BACK : if FEnableKeyInput and (not ReadOnly) and (FSelStart >= 1) then
                begin
                  //we are on the first char without having selected text => just get out here (4.01)
                  if (FCurrentChar = 1) and (FSelStart = 1) and (FSelLength = 0) then exit;
                  //if there is no selected text to delete select the previous char
//                  BeginUpdate;
                  if (SelLength = 0) or (BackOneMore) then
                    begin
                      SelStart := FCurrentChar - 1;
                      SelLength := SelLength + 1;
                    end;
                  SelText := '';
                  if FText = '' then  //VB aug 2005 (bts262)
                    FHiddenLeft := 0;
//                  EndUpdate;
                end;
    Ord('X') : if FEnableKeyInput and CheckCtrlOnlyMode then
                 begin
                   CutToClipboard;
                   KeyCode := 0;
                 end;
    Ord('V') : if FEnableKeyInput and CheckCtrlOnlyMode then
                 begin
                   PasteFromClipBoard;
                   KeyCode := 0;
                 end;
    //sets Strg - C to CopyToClipBoard
    Ord('C') : if CheckCtrlOnlyMode then
                 begin
                   CopyToClipboard;
                   KeyCode := 0;
                 end;
    //sets Strg - A to SelectAll
    Ord('A') : if CheckCtrlOnlyMode then
                 begin
                   SelectAll;
                   KeyCode := 0;
                 end;
  end;
  if oldsel <> SelLength then
    DrawEditText (FCurrentChar);
end; // end of procedure GetcommandKey

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.DoAlignmentChange;
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.BackOneMore: Boolean;
begin
  result := false;
end;

{ ---------------------------------------------------------------------------- }
//Validation support, May 2006, RS
{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetControlBackBrush: TBrush;
begin
  Result := Self.Brush;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetControl: TControl;
begin
  Result := Self;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetControlFont: TFont;
begin
  Result := Self.Font;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetValidationMsgString: TLMDString;
begin
  Result := Self.FValidationMsgString;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetValueToValidate: TLMDString;
begin
  Result := Self.Text;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.RespondToError(ErrorLevel: TLMDErrorLevel);
begin
  FErrorIndication := ErrorLevel > 0;
  if Assigned(FOnValidationError) and FErrorIndication then
    FOnValidationError(self, ErrorLevel);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetValidationMsgString(val: TLMDString);
begin
  Self.FValidationMsgString := val;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseEdit.SetValidator(Validator: TLMDValidationEntity);
begin
  if Self.FValidator = Validator then Exit;
//  if Assigned(Self.FValidator) then
//    Self.FValidator.ReleaseControl(Self);
  Self.FValidator := Validator;
  if Assigned(Self.FValidator) then
    begin
      Validator.FreeNotification(Self);
//      Self.FValidator.AcceptControl(Self);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.SupportsDefaultIndication: boolean;
begin
  Result := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.GetValidator: TLMDValidationEntity;
begin
  Result := Self.FValidator;
end;

function TLMDBaseEdit.GetEmptyText: TLMDString;
begin
  result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.ToLowerCase(const S: string): string;
begin
  {$IFDEF LMDCOMP9}
  if eoUserLocale in Options then
    result := LowerCase(S, loUserLocale)
  else
  {$ENDIF}
    result := LowerCase(S);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseEdit.ToUpperCase(const S: string): string;
begin
  {$IFDEF LMDCOMP9}
  if eoUserLocale in Options then
    result := UpperCase(S, loUserLocale)
  else
  {$ENDIF}
    result := UpperCase(S);
end;


{$IFDEF LMD_UNICODE}
procedure TLMDBaseEdit.WMImeStartComposition(var Message: TMessage);
var
  IMC: HIMC;
  LogFont: TLogFont;
  CF: TCompositionForm;
  pos: TPoint;
begin
  IMC := ImmGetContext(Handle);
  if (IMC <> 0) then
    begin
      GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @LogFont);
      ImmSetCompositionFont(IMC, @LogFont);
      CF.dwStyle := CFS_RECT;
      CF.rcArea  := FTextRect;
      GetCaretPos(pos);
      CF.ptCurrentPos := pos;
      ImmSetCompositionWindow(IMC, @CF);
      ImmReleaseContext(Handle, IMC);
    end;
  inherited;
end;

procedure TLMDBaseEdit.WMImeComposition(var Message: TMessage);
var
  IMC: HIMC;
  S: String;
  SNT: TLMDString;
  Size: Integer;
  StrEnd: PWideChar;
  ImmGetCompositionStringW: TIMECompStringProc;
begin
  if not FEnableKeyInput then
    exit;
  if ((Message.LParam and GCS_RESULTSTR) <> 0) then
    begin
      IMC := ImmGetContext(Handle);
      if (IMC <> 0) and (not ReadOnly) then
        begin
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
          HandleInsertText(CurrentChar, SNT);
          FInsert := true;
          case CharCase of
            ecNormal : SelText := SNT;
            ecUpperCase : SelText := WideUpperCase(SNT);
            ecLowerCase : SelText := WideLowerCase(SNT);
          end;
          FInsert := false;
          Message.Result := 0;
        end
    end
  else
    inherited;
end;
{$ENDIF}


end.
