unit ElCombos;
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

ElCombos unit
-------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Graphics, Forms, TypInfo,
  Menus, LMDTypes,  Types,  Buttons, StdCtrls,
  Themes,ImgList, Imm,
  LMDThemes, LMDGraphUtils, LMDUnicodeStrings, LMDClass,
  LMDGraph, LMDProcs, LMDStrings {$ifdef LMD_UNICODE}, LMDUnicode{$endif},
  ElVCLUtils, ElImgFrm, ElPopBtn, ElSBCtrl, ElInputProcessor, ElEdits, ElListBox, ElBtnEdit,
  ElFrmPers;

type
  // type defs for fontlistbox/-combo (not the best place, but serves compatibility)
  TElFontSampleMode = (fsmFontName, fsmFontSample, fsmBoth, fsmNoSample);
  TElFontDevice = (efdScreen, efdPrinter, efdBoth);
  TElFontComboOption = (foAnsiOnly, foTrueTypeOnly, foIncludeOEMFonts,
                        foIncludeSymbolFonts, foOEMFontsOnly,
                        foScalableOnly, foExcludeAtPrefixedFonts);
  TElFontComboOptions = set of TElFontComboOption;
  /// ---

  TCustomElComboBox = class;

  TElAutoHistoryItemAddEvent = procedure(Sender: TObject; const aString:
    TLMDString; const aIdx: Integer) of object;
  TElAutoHistoryItemMoveEvent = procedure(Sender: TObject; const aString:
    TLMDString; const aIdx: Integer) of object;
  TElAutoHistoryDirection = (ahdFirst, ahdLast);

  TElComboBoxBeforeSelectValueEvent = procedure(Sender: TObject; AnIndex: Integer; var AnAllow: Boolean) of object;

  TElComboListBox = class(TElListBox)
  private
    FCombo: TCustomElComboBox;
    FIsContextMenuUp: Boolean;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure CNCommand(var Msg: TWMCommand); message CN_COMMAND;
  protected
    procedure ResetContent; override;
    procedure CreateParams(var Params: TCreateParams); override;
    function GetBackground: TBitmap; override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure WndProc(var Message: TMessage); override;
    procedure DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState); override;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure UpdateItemHeight; override;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TCustomElComboBox = class(TCustomElButtonEdit)
  protected
    FAutoCompletionProcessByAnyChange: Boolean;
    FForceItemHeight: boolean;
    FSaveSize : TSize;
    FUseSaveSize: boolean;
    FIgnoreFocus: Boolean;
    FChangeAllowed: Boolean;
    FDropDownWidth: Integer;
    FAutoCompletion: Boolean;
    FTextBefoCompletation: TLMDString;
    FAutoHistory: boolean;
    FAutoHistoryDirection: TElAutoHistoryDirection;
    FAutoHistoryLimit: Integer;
    FOnAutoHistoryItemAdd: TELAutoHistoryItemAddEvent;
    FOnAutoHistoryItemMove: TELAutoHistoryItemMoveEvent;

    Input : TElKeyboardInput;
    SearchTextTimeoutThread : TThread;

    FAltBtnAlign: TLeftRight;
    FDropDownCount: integer;
    FForm: TForm;
    FItemIndex: Integer;
    FListBox: TElComboListBox;
    FOnAltBtnClick: TNotifyEvent;
    FOnDropDown: TNotifyEvent;
    FOnCloseUp: TNotifyEvent;
    FArrowColor,
      FSaveColor: TColor;
    FSaveFlat: boolean;
    FForcedText: boolean;
    FIgnoreItemIdx: boolean;
    FOldActive: Boolean;
    FCanDrop,
      FDroppedDown: boolean;
    FForcedTextClear: Boolean;
    FAdjustDropDownPos: Boolean;
    FHorizontalScroll: Boolean;
    FStyle: TComboBoxStyle;
    FOnDrawItem: TDrawItemEvent;
    FOnMeasureItem: TMeasureItemEvent;
    FEditCanvas: TCanvas;
    FCanvas: TCanvas;
    FDropDownAlignment: TAlignment;
    FIncrementalSearchTimeout: Integer;
    FShowGripper: Boolean;
    FOnSelect: TNotifyEvent;
    FAutoCompleteUseCase: Boolean;
    FWMKeyDown: Boolean;
    FOwnReadOnly: Boolean;

    FOnBeforeSelectValue: TElComboBoxBeforeSelectValueEvent;

    procedure Select; dynamic;
    function GetItemHeight: Integer;
    procedure ChangeBtnGlyph;
    procedure SetItemHeight(Value: Integer);
    procedure SetForceItemHeight(const Value: boolean);
    procedure ComboWndProc(var Message: TMessage; ComboWnd: THandle;
      ComboProc: Pointer); virtual;
    function GetListTransparentSelection: Boolean;
    procedure SetListTransparentSelection(Value: Boolean);
    procedure SetDropDownWidth(const Value: Integer);
    procedure CMCancelMode(var Msg: TCMCancelMode); message CM_CANCELMODE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure DoChange; override;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMMButtonDblClk(var Message: TWMMButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure EMSetReadOnly(var Msg: TMessage); message EM_SETREADONLY;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    function GetThemedElement: TThemedElement; override;
    procedure GetThemedElementDetails(var ADetails: TThemedElementDetails); override;
    procedure ButtonClick(Sender: TObject);
    procedure GetDropDownValue;
    function GetDroppedDown: boolean;
    function GetListBoxPopup: TPopupMenu;
    procedure SetListBoxPopup(Value: TPopupMenu);
    function GetItems: TLMDStrings;
    function GetListColor: TColor;
    function GetListInvertSelection: boolean;
    function GetSorted: boolean;
    function GetUseBackground: boolean;
    procedure ListBoxClick(Sender: TObject);
    procedure SetDropDownCount(const Value: integer);
    procedure SetDroppedDown(const Value: boolean);
    procedure SetCanDrop(const Value: boolean);
    procedure SetItemIndex(const Value: Integer);
    procedure SetItems(const Value: TLMDStrings);
    procedure SetListColor(const Value: TColor);
    procedure SetListInvertSelection(const Value: boolean);
    procedure SetSorted(const Value: boolean);
    procedure SetUseBackground(const Value: boolean);
    function GetDroppedIndex: integer;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure SetHorizontalScroll(const Value: Boolean);
    function GetRightOffsetForBackground: Integer; override;
  protected
    procedure AdjustFocusedRect(var aRect: TRect); override;
    procedure AdjustRegion; virtual;
    function GetCurrentStyle: TComboBoxStyle; virtual;
    procedure MeasureItem(Index: Integer; var Height: Integer); virtual;
    procedure DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState); virtual;

    function GetListImageForm: TElImageForm;
    procedure SetListImageForm(newValue: TElImageForm);

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;

    function GetDropDownHeight: Integer; virtual;
    procedure DoDropDown; virtual;
    procedure DoCloseUp; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    function GetBtnArrowColor: TColor; virtual;
    procedure SetBtnArrowColor(newValue: TColor); virtual;

    procedure SetAltBtnAlign(Value: TLeftRight);
    procedure DoAutoComplete; virtual;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure SetReadOnly(Value: boolean); override;
    function GetReadOnly: Boolean; override;
    procedure SetLineBorderActiveColor(Value: TColor); override;
    procedure SetLineBorderInactiveColor(Value: TColor); override;
    procedure SetActiveBorderType(const Value: TElFlatBorderType); override;
    procedure SetInactiveBorderType(const Value: TElFlatBorderType); override;
    procedure SetFlat(const Value: boolean); override;
    function GetButtonClass: TCustomElGraphicButtonClass; override;
    function GetAltButtonClass: TCustomElGraphicButtonClass; override;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure DestroyWnd; override;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    function GetShowLineHint: Boolean;
    procedure SetShowLineHint(Value: Boolean);
    procedure SetStyle(Value: TComboBoxStyle); virtual;
    function GetEditHandle: HWND;
    procedure SetDropDownAlignment(Value: TAlignment);
    function GetRightAlignedView:Boolean;
    procedure SetRightAlignedView(Value: Boolean); override;
    procedure SetRightAlignedText(Value: Boolean); override;
    procedure SetFocusedSelectColor(newValue: TColor); override;
    procedure SetFocusedSelectTextColor(newValue: TColor); override;
    procedure SetHighlightAlphaLevel(Value: Integer); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadBtnColor(Reader: TReader);

    function GetTextFromItem(Index: integer): TLMDString; virtual;
    procedure ReadBtnArrowColor(Reader: TReader);
    procedure ReadBtnFlat(Reader: TReader);
    procedure ReadBtnTransparent(Reader: TReader);
    procedure ReadAltBtnColor(Reader: TReader);
    procedure ReadAltBtnFlat(Reader: TReader);
    procedure ReadAltBtnTransparent(Reader: TReader);
    procedure ReadAltBtnVisible(Reader: TReader);
    procedure ReadAltBtnWidth(Reader: TReader);
    procedure ReadAltBtnPosition(Reader: TReader);
    function GetAltBtnGlyph: TBitmap;
    procedure SetAltBtnGlyph(Value: TBitmap);
    procedure ReadReadOnly(Reader: TReader);
    function GetItemWidth(Index: Integer): Integer; virtual;
    procedure DoExit; override;
    procedure SetUseXPThemes(const Value : boolean); override;
    procedure SetThemeGlobalMode(const Value: Boolean);override;
    procedure SetThemeMode(const Value: TLMDThemeMode);override;
    procedure DoThemeChanged; override;
    procedure PaintText(Canvas : TCanvas); override;
    {$IFDEF LMD_UNICODE}
    procedure WMDeadChar(var Message: TWMDeadChar); message WM_DEADCHAR;
    procedure WMIMEComposition(var Message: TMessage); message WM_IME_COMPOSITION;
    procedure WMIMEStartComposition(var Message: TMessage); message WM_IME_STARTCOMPOSITION;
    {$ENDIF}
    procedure StartClearSearchTimeoutThread;
    procedure StopClearSearchTimeoutThread;
    function DoPerformSearch(SearchText : TLMDString; AFromIndex: Integer = 0): boolean; virtual;
    procedure SearchTextTimeout(Sender : TObject);
    function DoCompareItems(SearchText : TLMDString; ItemIndex : integer): Boolean; virtual;
    function GetImages: TCustomImageList;
    procedure SetImages(Value: TCustomImageList);
    function GetAlphaForImages: TCustomImageList;
    procedure SetAlphaForImages(Value: TCustomImageList);
    procedure SetEditRect(Value : TRect); override;
    function GetHorzScrollBar:TElCtrlScrollBarStyles;
    function GetVertScrollBar:TElCtrlScrollBarStyles;
    function GetUseCustomScrollBars:Boolean;
    procedure SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
    procedure SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
    procedure SetUseCustomScrollBars(const Value :Boolean);
    procedure SetShowGripper(Value: Boolean);

    property EditHandle: HWND read GetEditHandle;

    property ButtonArrowColor: TColor read GetBtnArrowColor write
    SetBtnArrowColor default clBtnText; { Published }
    property AltBtnGlyph: TBitmap read GetAltBtnGlyph stored False;

    property CanDrop: boolean read FCanDrop write SetCanDrop default True;
    property DropDownCount: Integer read FDropDownCount write SetDropDownCount
    default 8;
    property DropDownWidth: Integer read FDropDownWidth write SetDropDownWidth
    default -1;
    property ListTransparentSelection: Boolean read GetListTransparentSelection
    write SetListTransparentSelection default false;
    property AutoCompletion: Boolean read FAutoCompletion write FAutoCompletion
    default False;
    property AutoCompletionProcessByAnyChange: Boolean read FAutoCompletionProcessByAnyChange write FAutoCompletionProcessByAnyChange default True;
    property Items: TLMDStrings read GetItems write SetItems;
    property ListColor: TColor read GetListColor write SetListColor default
    clWindow;

    property ListImageForm: TElImageForm read GetListImageForm write
    SetListImageForm;

    property ListInvertSelection: boolean read GetListInvertSelection write
    SetListInvertSelection default False;
    property Sorted: boolean read GetSorted write SetSorted default False;
    property UseBackground: boolean read GetUseBackground write SetUseBackground
    default False;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property AdjustDropDownPos: Boolean read FAdjustDropDownPos write
    FAdjustDropDownPos default true;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property ShowLineHint: Boolean read GetShowLineHint write SetShowLineHint
    default false;
    property HorizontalScroll: Boolean read FHorizontalScroll write SetHorizontalScroll default false;
    property Style: TComboBoxStyle read FStyle write SetStyle default csDropDown;
    property ItemHeight: Integer read GetItemHeight write SetItemHeight;
    property OnDrawItem: TDrawItemEvent read FOnDrawItem write FOnDrawItem;
    property OnMeasureItem: TMeasureItemEvent read FOnMeasureItem write
    FOnMeasureItem;
    property DropDownAlignment: TAlignment read FDropDownAlignment write
    SetDropDownAlignment default taRightJustify;

    property ForcedTextClear: Boolean read FForcedTextClear write FForcedTextClear default False;
    property AutoHistory: boolean read FAutoHistory write FAutoHistory default False;
    property AutoHistoryDirection: TElAutoHistoryDirection read
      FAutoHistoryDirection write FAutoHistoryDirection default ahdFirst;
    property AutoHistoryLimit: Integer read FAutoHistoryLimit write
      FAutoHistoryLimit default 25;
    property OnAutoHistoryItemAdd: TElAutoHistoryItemAddEvent read
      FOnAutoHistoryItemAdd write FOnAutoHistoryItemAdd;
    property OnAutoHistoryItemMove: TElAutoHistoryItemMoveEvent read
      FOnAutoHistoryItemMove write FOnAutoHistoryItemMove;
    property IncrementalSearchTimeout: Integer read FIncrementalSearchTimeout write
        FIncrementalSearchTimeout default 500;
    property Images: TCustomImageList read GetImages write SetImages;
    property AlphaForImages: TCustomImageList read GetAlphaForImages write
        SetAlphaForImages;
    property ShowGripper: Boolean read FShowGripper write SetShowGripper default
        false;
  {< ELSCROLLBAR}
    property HorzScrollBarStyles: TElCtrlScrollBarStyles read GetHorzScrollBar
      write SetHorzScrollBar;
    property VertScrollBarStyles: TElCtrlScrollBarStyles read GetVertScrollBar
      write SetVertScrollBar;
    property UseCustomScrollBars:Boolean read GetUseCustomScrollBars write SetUseCustomScrollBars
      default True;
    property RightAlignedView: Boolean read GetRightAlignedView write
          SetRightAlignedView default false;
  {> ELSCROLLBAR}
    function GetSelectedItemIndex: Integer;
    procedure SelectItem(Previous : boolean);
    function GetBkColor: TColor; override;
    function GetTextColor: TColor; override;
    property OnSelect: TNotifyEvent read FOnSelect write FOnSelect;
    property AutoCompleteUseCase: Boolean read FAutoCompleteUseCase write
        FAutoCompleteUseCase default false;
    function GetHideFocusRect(): Boolean;
    procedure SetHideFocusRect(AValue: Boolean);
    procedure SetSaveUnicode(const AValue: Boolean);
    function GetSaveUnicode: boolean;
    property OnBeforeSelectValue: TElComboBoxBeforeSelectValueEvent read FOnBeforeSelectValue write FOnBeforeSelectValue;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ListBox: TElComboListBox read FListBox;
    procedure Click; override;
    procedure CloseUp(AcceptValue: boolean); virtual;
    procedure DropDown; virtual;
    procedure AutoHistoryUpdate;
    property ListBoxPopupMenu: TPopupMenu read GetListBoxPopup write SetListBoxPopup;
    property Canvas: TCanvas read FCanvas;
    property DroppedDown: boolean read GetDroppedDown write SetDroppedDown;
    property DroppedIndex: integer read GetDroppedIndex;
    property Ctl3D;
    property ForceItemHeight: boolean read FForceItemHeight write SetForceItemHeight default false;
    property ParentCtl3D;
    property SelectedItemIndex: Integer read GetSelectedItemIndex;
    property HideFocusRect: Boolean read GetHideFocusRect write SetHideFocusRect;
    property SaveUnicode: boolean read GetSaveUnicode write SetSaveUnicode;
  end;

  TElComboBox = class(TCustomElComboBox)
  published
    property SaveUnicode;
    property StressShortCut;
    property ButtonArrowColor;

    property CanDrop;
    property DropDownCount;
    property DropDownWidth;
    property ListTransparentSelection;
    property AutoCompletion;
    property AutoCompleteUseCase;
    property AutoCompletionProcessByAnyChange;
    property Items;
    property ListColor;

    property ListImageForm;

    property ListInvertSelection;
    property Sorted;
    property UseBackground;
    property OnDropDown;
    property OnCloseUp;
    property AdjustDropDownPos;
    property ItemIndex;
    property ShowLineHint;
    property HorizontalScroll;
    property Style;
    property ItemHeight;
    property OnDrawItem;
    property OnMeasureItem;
    property DropDownAlignment;
    property ShowGripper;

    {< ELSCROLLBAR}
    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;
    property RightAlignedView;
    {> ELSCROLLBAR}

    property ForceItemHeight;

    property OnSelect;
    property AutoHistory;
    property AutoHistoryDirection;
    property AutoHistoryLimit;
    // property OnAutoCompletion;
    property OnAutoHistoryItemAdd;
    property OnAutoHistoryItemMove;

    // inherited from TCustomElButtonEdit
    property AlignBottom;
    property CharCase;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AutoSize;
    property ReadOnly;
    property MaxLength;
    property BorderSides;
    property Transparent;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;
    property ListBoxPopupMenu;
    property ImageForm;

    property IncrementalSearchTimeout;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;
    property OnKeyPressEx;

    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;
    property Text;

    property ForcedTextClear;
    // inherited from TCustomElEdit
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseSystemMenu;

    property Alignment;
    property AutoSelect default true;

    property Background;
    property ButtonCaption;

    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;

    property ButtonColor;
    property ButtonEnabled;
    property ButtonFlat;
    property ButtonHint;
    property ButtonOldStyled;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;
    property ButtonShowBorder;
    property ButtonVisible;
    property ButtonWidth;

    property AltButtonCaption;

    property AltButtonClickSound;
    property AltButtonDownSound;
    property AltButtonUpSound;
    property AltButtonSoundMap;

    property AltButtonColor;
    property AltButtonDown;
    property AltButtonEnabled;
    property AltButtonFlat;
    property AltButtonGlyph;
    property AltButtonHint;
    property AltButtonIsSwitch;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonOldStyled;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShowBorder;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonVisible;
    property AltButtonWidth;
    property AltButtonPngGlyph;
    property AltButtonUsePng;
    property OnAltButtonClick;

    // VCL properties
    property BorderStyle;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;

    property OnEndDock;

    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnStartDock;

    property OnContextPopup;
    property Anchors;
    property Constraints;
    property DockOrientation default doNoOrient;
    property Floating;
    property DoubleBuffered default False;
    property DragKind;
    property OnBeforeSelectValue;
    property HideFocusRect;
  end;

implementation

uses
  ElXPThemedControl,
  LMDSysIn,
  UxTheme,
  Math;

{ TElComboButton }

type
  TElComboButton = class(TCustomElGraphicButton)
  protected
    function GetShowGlyph: Boolean; override;
  end;

  TElComboDropDownButton = class(TElComboButton)
  protected
    function GetDetails: TThemedElementDetails; override;
  end;

{ TElComboListBox }

constructor TElComboListBox.Create(AOwner: TComponent);
begin
  inherited;
  FCombo := TCustomElComboBox(AOwner);
  FIsContextMenuUp := False;
  ActiveBorderType := fbtLineBorder;
  InactiveBorderType := fbtLineBorder;
  LineBorderActiveColor := clWindowFrame;
  LineBorderInactiveColor := clWindowFrame;
  Flat := True;
  // UseXPThemes := UseXPThemes;
  TabStop := False;
  HideSelectColor := clHighlight;
  HideSelectTextColor := clHighlightText;
  HideSelection := false;
end;

procedure TElComboListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
end;

function TElComboListBox.GetBackground: TBitmap;
begin
  Result := FCombo.Background;
end;

procedure TElComboListBox.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  MouseCapture := True;
end;

procedure TElComboListBox.DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState);
begin
  if (FCombo.FStyle = csOwnerDrawFixed) or (FCombo.FStyle = csOwnerDrawVariable) then
  begin
    FCombo.FCanvas := Canvas;
    FCombo.DrawItem(Index, R, State);
  end
  else
    inherited DrawItem(Index, R, State);
end;

procedure TElComboListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  if FCombo.FStyle = csOwnerDrawVariable then
    FCombo.MeasureItem(Index, Height)
  else
    inherited;
end;

procedure TElComboListBox.WndProc(var Message: TMessage);
begin
  if FCombo <> nil then
    FCombo.ComboWndProc(Message, 0, nil);
  inherited WndProc(Message);
end;

procedure TElComboListBox.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  MouseCapture := False;
  // Click;
  FCombo.CloseUp({(not FCombo.ReadOnly) and} PtInRect(ClientRect, Point(Msg.XPos, Msg.YPos)));
end;

procedure TElComboListBox.WMMouseActivate(var Msg: TWMMouseActivate);
begin
  Msg.Result := MA_NOACTIVATE;
end;

procedure TElComboListBox.WMMouseMove(var Msg: TWMMouseMove);
var
  Index: integer;
begin
  if Items.Count>0 then
  with Msg do
  begin
    Index := ItemIndex;
    if (YPos >= ClientHeight) then
    begin
      if Index >= 0 then Inc(Index);
    end
    else
    if YPos >= 0 then
      Index := Perform(LB_ITEMFROMPOINT, 0, MakeLParam(XPos, YPos));
    if MouseCapture and
      ((XPos < 0) or (XPos > ClientWidth) or ((Index = 0) and (YPos < 0)) or
      ((Index = Items.Count) and (YPos > ClientHeight))) then
      Index := -1;
    if ((YPos < 0) and (Index > 0)) or (Index = Items.Count) then
      Dec(Index);
    if (Index<>ItemIndex) and (Index>=0) and (Index<Items.Count) then
    begin
      if Multiselect and (ItemIndex>=0) and (not Selected[ItemIndex]) then
      begin
        Canvas.Font := Font;
        Canvas.Brush := Brush;
        DrawItem(ItemIndex, ItemRect(ItemIndex), []);
      end;

      ItemIndex := Index;
      {
      FCombo.FChangeAllowed := false;
      //FCombo.FForcedText := true;
      FCombo.ItemIndex := Index;
      //FCombo.FForcedText := false;
      FCombo.FChangeAllowed := true;
      {}

      //??? syncronize text and generate events ???

      if Multiselect and(ItemIndex>=0) then
      begin
        Canvas.Font := Font;
        Canvas.Brush := Brush;
        DrawItem(ItemIndex, ItemRect(ItemIndex), [odSelected]);
      end;
      if (FCombo<>nil) then
        FCombo.Select;
    end;
  end;
  inherited;
end;

procedure TElComboListBox.WMKeyDown(var Message: TWMKeyDown);
var
  OldItemIndex: Integer;
begin
  OldItemIndex := ItemIndex;
//  Self.Items.BeginUpdate;
  inherited;
//  Self.Items.EndUpdate;
  if (FCombo<>nil) and(OldItemIndex <> ItemIndex) then
  begin
    // Repaint for WMMouseMove selected Item
    if Multiselect and (OldItemIndex>=0) and (not Selected[OldItemIndex]) then
    begin
      Canvas.Font := Font;
      Canvas.Brush := Brush;
      DrawItem(OldItemIndex, ItemRect(OldItemIndex), []);
    end;
    FCombo.Select;
  end;
end;

procedure TElComboListBox.ResetContent;
begin
  inherited;
  if not FCombo.ReadOnly then
  begin
    Fcombo.FForcedText := true;
    FCombo.ItemIndex := -1;
    Fcombo.FForcedText := false;
  end
  else
    FCombo.ItemIndex := -1;
end;

procedure TElComboListBox.CNCommand(var Msg: TWMCommand);
begin
  inherited;
  {
  if TWMCommand(Msg).NotifyCode = LBN_SELCHANGE then
  begin
    FCombo.FChangeAllowed := false;
    FCombo.ItemIndex := ItemIndex;
    FCombo.FChangeAllowed := true;
  end;
  }
end;

procedure TElComboListBox.WMNCPaint(var Message: TWMNCPaint);
var
  DC : HDC;
  R: TRect;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  inherited;
  if FCombo.ShowGripper then
  begin
    DC := GetWindowDC(FCombo.FForm.Handle);
    // paint frame:
    GetWindowRect(FCombo.FForm.Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL)-1;
    if (LThemeMode <> ttmNone) and (BorderStyle = bsSingle) then
      LMDThemeServices.DrawElement(LThemeMode, DC, tcComboBoxDontCare, R)
    else
      with FCombo do
        ElVCLUtils.DrawFlatFrameEx2(DC, R, clWindowFrame, Color{?}, False, True,
          [ebsLeft, ebsRight, ebsBottom], fbtColorLineBorder, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorwindow);
    // fill rect:
    GetWindowRect(FCombo.FForm.Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    InflateRect(R, -GetSystemMetrics(SM_CXEDGE), 0);
    Dec(R.Bottom, GetSystemMetrics(SM_CYEDGE));
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL)+2;
    if FCombo.IsThemed then
      begin
        FillRect(DC, R, HBRUSH(LMDThemeServices.GetThemeSysColor(LThemeMode, teComboBox, clBtnFace) + 1));
        R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
        LMDThemeServices.DrawElement(LThemeMode, DC, tsGripper, R);
      end
    else
      DrawFrameControl(DC, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);
    ReleaseDC(Handle, DC);
  end;
end;

procedure TElComboListBox.UpdateItemHeight;
var tm : TLMDTextMetric;
begin
  if not FCombo.ForceItemHeight then
    if not (FCombo.Style in [csOwnerDrawFixed, csOwnerDrawVariable]) then
    begin
      LMDGetTextMetrics(Canvas.Handle, tm);
      FItemHeight := tm.tmHeight;
      Perform(LB_SETITEMHEIGHT, 0, FItemHeight);
    end;
end;

procedure TElComboListBox.WMContextMenu(var Message: TWMContextMenu);
begin
  FIsContextMenuUp := True;
  inherited;
end;

{ TCustomElComboBox }

procedure TCustomElComboBox.ButtonClick(Sender: TObject);
begin
  SetFocus;
  DropDown;
end;

procedure TCustomElComboBox.Click;
begin
  inherited;
  if FForm.Visible then
    CloseUp(False);
end;

procedure TCustomElComboBox.CloseUp(AcceptValue: boolean);
var
  R: TRect;
  LAllow: Boolean;
begin
  if ReadOnly then
    AcceptValue := False;
    if AcceptValue then
  begin
    LAllow := True;
    if Assigned(FOnBeforeSelectValue) then
      FOnBeforeSelectValue(Self, FListBox.ItemIndex, LAllow);
    if not LAllow then
      exit;
    GetDropDownValue;
    Modified := True;
    if NotifyUserChangeOnly then
      Change;
  end;
  FDroppedDown := false;
  TElComboButton(FButton).Down := false;
  DoCloseUp;
  // DoDropDown;
  if (ReadOnly or FReadOnly or (Style = csDropDownList)) and Visible then
  begin
    SendMessage(Handle, EM_SETSEL, -1, -1);
    HideCaret(Handle);
    Invalidate;
  end;
  if FForm.Visible then
  begin
    GetWindowRect(FForm.Handle, R);
    FSaveSize.cx := R.Right - R.Left;
    FSaveSize.cy := R.Bottom - R.Top;
    FUseSaveSize := true;
    SetWindowPos(FForm.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FForm.Visible := False;
  end;

  if LMDSIWindowsVistaUp then
    Invalidate;
end;

procedure TCustomElComboBox.CMCancelMode(var Msg: TCMCancelMode);
begin
  if DroppedDown and (Msg.Sender <> Self) and (Msg.Sender <> FButton) and (Msg.Sender <> FListBox)
    and (Msg.Sender <> FForm) then
    if not FListBox.FIsContextMenuUp then
      CloseUp(False)
    else
      FListBox.FIsContextMenuUp := False;
end;

procedure TCustomElComboBox.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  FButton.Enabled := Enabled;
  ChangeBtnGlyph;
  (*if Enabled then
     Color := FSaveColor
  else
  begin
    FSaveColor := Color;
    Color := clbtnFace//clBtnShadow;
  end;
  *)
end;

procedure TCustomElComboBox.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  FListBox.Font.Assign(Font);
  FListBox.SelectedFont.Assign(Font);
  FListBox.SelectedFont.Color := clHighlightText;

  Invalidate;
end;

procedure TCustomElComboBox.WMKeyDown(var Message: TWMKeyDown);
begin
  FWMKeyDown := True;
  // ??? Browsing keys  VK_HOME, VK_END do not get to the list handler - they are handled by editor :(
  if (Message.CharCode = VK_RETURN) and FForm.Visible then
  begin
    CloseUp(true);
    Message.CharCode := 0;
    Message.Result := 1;
  end;
  if FOwnReadOnly or FReadOnly then
  begin
    if (not FOwnReadOnly) and AutoCompletion then
    begin
      if Length(Input.Text) = 0 then
        FTextBefoCompletation := Text;
      Input.WMKeyDown(Message);
      if (not DoPerformSearch(Input.Text, -1)) then
        if (Length(Input.Text) > 1) and (Input.IsRepeatSymbolString) then
        begin
          Input.Reset;
          Input.WMKeyDown(Message);
          DoPerformSearch(Input.Text, -1);
        end
        else
          Input.Reset
    end;
    inherited;
    if HandleAllocated then
    begin
      HideCaret(Handle);
      SendMessage(Handle, EM_SETSEL, -1, -1);
    end;
  end
  else
  begin
    inherited;
  end;
end;

procedure TCustomElComboBox.CNCommand(var Message: TWMCommand);
begin
  if (Message.NotifyCode = EN_UPDATE) and (FOwnReadOnly or FReadOnly) then
  begin
    HideCaret(Handle);
  end
  else
    inherited;
end;

procedure TCustomElComboBox.CMColorChanged(var Message: TMessage);
begin
  inherited;
  FListBox.Color := Color;
end;

procedure TCustomElComboBox.WMLButtonUp(var Message: TWMLButtonUp);
begin
  {
  if FButton.InCapture then
  begin
    FButton.MouseUp(mbLeft, KeyDataToShiftState(Message.Keys), Message.XPos, Message.YPos);
  end
  else
  if FAltButton.InCapture then
  begin
    FAltButton.MouseUp(mbLeft, KeyDataToShiftState(Message.Keys), Message.XPos, Message.YPos);
  end
  else
  }
  if FReadOnly then
  begin
    with Message do
      MouseUp(mbLeft, KeysToShiftState(Keys), XPos, YPos);
    SendMessage(Handle, EM_SETSEL, -1, -1);
    HideCaret(Handle);
    exit;
  end;
//  if FReadOnly then
//  begin
//    HideCaret(Handle);
//    exit;
//  end;
  inherited;
end;

procedure TCustomElComboBox.WMMButtonDblClk(var Message: TWMMButtonDblClk);
begin
  if FReadOnly then
  begin
    Message.Result := 0;
    with Message do
      MouseDown(mbMiddle, KeysToShiftState(Keys) + [ssDouble], XPos, YPos);
    SendMessage(Handle, EM_SETSEL, -1, -1);
    HideCaret(Handle);
  end
  else
//    if FReadOnly then
//    begin
//      HideCaret(Handle);
//      exit;
//    end
//    else
      inherited;
end;

procedure TCustomElComboBox.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if FReadOnly and (Style <> csDropDown) and ButtonVisible then
  begin
    SendCancelMode(Self);
    if csClickEvents in ControlStyle then
      ControlState := ControlState + [csClicked];
    if not (csNoStdEvents in ControlStyle) then
      with Message do
        MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
    DroppedDown := not DroppedDown;
    SendMessage(Handle, EM_SETSEL, -1, -1);
    HideCaret(Handle);
  end
  else
    inherited;
end;

procedure TCustomElComboBox.EMSetReadOnly(var Msg: TMessage);
begin
  if Boolean(Msg.wParam) then
  begin
    if GetFocus = Handle then
      HideCaret(Handle);
    if Items.IndexOf(inherited Text) = -1 then
    begin
      FForcedText := true;
      Text := '';
      FForcedText := false;
    end;
  end;
end;

procedure TCustomElComboBox.WMMouseWheel(var Msg: TWMMouseWheel);
var
  Dy: integer;
  sl: integer;
begin
  //if IsWinNT or IsWin98 then SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE) else sl := 3;
  //if sl = 0 then
  if CanDrop then
  begin
    sl := 1;
    Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
    if Dy <> 0 then
    begin
      if Self.DroppedDown then
      begin
        if LMDInRange(FListBox.ItemIndex - dy, 0, Items.Count - 1 ) then
        begin
          //Self.Items.BeginUpdate;
          FListBox.ItemIndex := FListBox.ItemIndex - dy;
          //Self.Items.EndUpdate;
          {
          FChangeAllowed := false;
          ItemIndex := FListBox.ItemIndex - dy;
          FChangeAllowed := true;
          Change;
          {}
          if not ReadOnly then
            Select;
        end;
      end
      else
      if LMDInRange(ItemIndex - dy, 0, Items.Count - 1) and not ReadOnly then
      begin
        ItemIndex := ItemIndex - dy;
        Modified := True;
        if NotifyUserChangeOnly then
          Change;
        Select;
      end;
    end;
  end;
end; { WMMouseWheel }

procedure TCustomElComboBox.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;

  Handled: Boolean;

  PopupMenu: TPopupMenu;
begin
  if FReadOnly or FOwnReadOnly then
  begin
    Pt.x := Message.XPos;
    Pt.y := Message.YPos;
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
    if (PopupMenu <> nil) and PopupMenu.AutoPopup then
    begin
      SendCancelMode(nil);
      PopupMenu.PopupComponent := Self;
      if Pt.X < 0 then
        Pt := ClientToScreen(Point(0, 0));
      PopupMenu.Popup(Pt.X, Pt.Y);
    end;
    Message.Result := 1;
  end
  else
    inherited;
end;

procedure TCustomElComboBox.WMSetCursor(var Msg: TWMSetCursor);
begin
  if FOwnReadOnly or FReadOnly then
    Windows.SetCursor(Screen.Cursors[crArrow])
  else
    inherited;
end;

procedure TCustomElComboBox.DoChange;
begin
  if not FIgnoreItemIdx then
  begin
    if ReadOnly and not FForcedText then
      if (Items.IndexOf(inherited Text) = -1) and (ItemIndex <> -1) then
        inherited Text := Items[ItemIndex];
//    FForcedText := true;
    FForcedText := not (GetCurrentStyle = csDropDownList);
    ItemIndex := Items.IndexOf(inherited Text);
    FForcedText := false;
  end;
end;

function TCustomElComboBox.GetSelectedItemIndex: Integer;
begin
  Result := FListBox.ItemIndex;
end;

procedure TCustomElComboBox.Select;
begin
  if Assigned(FOnSelect) then
    FOnSelect(Self);
end;

function TCustomElComboBox.GetHideFocusRect;
begin
  Result := False;
  if Assigned(FListBox) then
   Result := FListBox.HideFocusRect
end;

procedure TCustomElComboBox.SetHideFocusRect;
begin
  if Assigned(FListBox) then
   FListBox.HideFocusRect := AValue;
end;

type
  TTrickyForm = class(TForm)
  private
    FCombo: TCustomElComboBox;
    procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure WMNCHitTest(var Msg : TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMEnterSizeMove(var Message: TMessage); message WM_ENTERSIZEMOVE;
    procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;
  public
    constructor CreateNew(AOwner : TComponent; Dummy : integer =
        0);  override;
  end;

procedure TTrickyForm.CreateParams(var Params: TCreateParams); { protected }
var
  LShadow: BOOL;
begin
  inherited CreateParams(Params);

  if LMDSIWindowsXPUp then
  begin
    LShadow := False;
    SystemParametersInfo({$IFDEF LMDCOMP7}SPI_GETDROPSHADOW{$ELSE}$1024{$ENDIF}, 0, @LShadow, 0);
    if LShadow then
      Params.WindowClass.style := Params.WindowClass.style or {$IFDEF LMDCOMP7}CS_DROPSHADOW{$ELSE}$20000{$ENDIF};
  end;

  with Params do
  begin
    Style := Style or WS_POPUP{ or WS_BORDER};
    ExStyle := ExStyle or WS_EX_TOOLWINDOW;
    WndParent := GetDesktopWindow;
  end;
end; { CreateParams }

constructor TTrickyForm.CreateNew(AOwner : TComponent; Dummy
    : integer = 0);
begin
  inherited CreateNew(nil);
  FCombo := TCustomElComboBox(AOwner);
end;

procedure TTrickyForm.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
var
  tp : PMinMaxInfo;
  begin
  inherited;
  tp := Message.MinMaxInfo;
  tp.ptMinTrackSize.y := FCombo.ItemHeight;

  if FCombo.HorizontalScroll then
  begin
    if FCombo.UseCustomScrollBars then
      inc(tp.ptMinTrackSize.y, FCombo.HorzScrollBarStyles.Depth)
    else
      inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYHSCROLL));
  end;

  if FCombo.ShowGripper then
    inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYHSCROLL));
  inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYBORDER) * 2);
  Message.Result := 1;
end;

procedure TTrickyForm.WMNCHitTest(var Msg : TWMNCHitTest);
var
  R : TRect;
begin
  inherited;
  if FCombo.FShowGripper and
    (Msg.Result <> HTVSCROLL) and (Msg.Result <> HTHSCROLL){}
  then
  begin
    R := BoundsRect;
    OffsetRect(R, -Left, -Top);
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);
    R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
    if PtInRect(R, ScreenToClient(SmallPointToPoint(Msg.Pos))) then
      Msg.Result := HTBOTTOMRIGHT
    else
    if R.Top < ScreenToClient(SmallPointToPoint(Msg.Pos)).Y then
      Msg.Result := HTNOWHERE;
  end;
end;

procedure TTrickyForm.WMMouseActivate(var Msg: TWMMouseActivate);
begin
  Msg.Result := MA_NOACTIVATE;
end;

procedure TTrickyForm.WMSetFocus(var Message: TWMSetFocus);
begin
  Windows.SetFocus(Message.FocusedWnd);
end;

procedure TTrickyForm.WMEnterSizeMove(var Message: TMessage);
begin
  inherited;
  FCombo.FIgnoreFocus := true;
end;

procedure TTrickyForm.WMExitSizeMove(var Message: TMessage);
var AForm : TCustomForm;
begin
  AForm := GetParentForm(FCombo);
  if (AForm <> nil) and (AForm.CanFocus) then
    AForm.SetFocus;

  Windows.SetFocus(FCombo.Handle);
  FCombo.FIgnoreFocus := false;
  inherited;
end;

procedure TTrickyForm.WMWindowPosChanged(var Message: TWMWindowPosChanged);
var
  adj : integer;
begin
  inherited;
  if FCombo.ShowGripper then
    adj := GetSystemMetrics(SM_CYHSCROLL)
  else
    adj := 0;
  FCombo.FListBox.SetBounds(0, 0, Message.WindowPos.cx, Message.WindowPos.cy - adj);
end;

constructor TCustomElComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  BeginCreate;
  inherited OnButtonClick := ButtonClick;
  TElComboDropDownButton(FButton).IsSwitch := true;
  FEditCanvas := inherited Canvas;
  FCanvas := FEditCanvas;
  NotifyUserChangeOnly := true;
  Multiline := false;
  FCanDrop := true;
  FDropDownCount := 8;
  FDropDownWidth := -1;
  FItemIndex := -1;
  FArrowColor := clRed;
  ButtonArrowColor := clBtnText;
  FAdjustDropDownPos := true;
  FAutoCompletionProcessByAnyChange := True;
  FForcedTextClear := False;

  ControlStyle := ControlStyle - [csCaptureMouse, csFixedHeight];

  FFocusedSelectColor := clHighlight;

  FWMKeyDown := False;
  Input := TElKeyboardInput.Create;

  FForm := TTrickyForm.CreateNew(Self);
  FForm.Visible := False;
  FForm.BorderStyle := bsNone;

  with TElFormPersist.Create(FForm) do
    TopMost := true;

  FListBox := TElComboListBox.Create(Self);
  FListBox.StyleManager := nil;
  FListBox.Parent := FForm;
  // FListBox.Align := alClient;
  FListBox.UseXPThemes := UseXPThemes;
  FListBox.OnClick := ListBoxClick;
  {< ELSCROLLBAR}
  FListBox.UseCustomScrollBars := True;
  {> ELSCROLLBAR}

  AutoSelect := true;
  FIncrementalSearchTimeout := 500;
  FDropDownAlignment := taRightJustify;
  AutoCompletion := False;
  AutoHistory := False;
  AutoHistoryDirection := ahdFirst;
  FAutoHistoryLimit := 25;
  FTextBefoCompletation := '';
  FForceItemHeight := false;
  EndCreate;
end;

{< ELSCROLLBAR}
function TCustomElComboBox.GetHorzScrollBar:TElCtrlScrollBarStyles;
begin
  Result := FListBox.HorzScrollBarStyles;
end;

function TCustomElComboBox.GetVertScrollBar:TElCtrlScrollBarStyles;
begin
  Result := FListBox.VertScrollBarStyles;
end;

function TCustomElComboBox.GetUseCustomScrollBars:Boolean;
begin
  Result := FListBox.UseCustomScrollBars;
end;

procedure TCustomElComboBox.SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  FListBox.HorzScrollBarStyles.Assign(Value);
end;

procedure TCustomElComboBox.SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  FListBox.VertScrollBarStyles.Assign(Value);
end;

procedure TCustomElComboBox.SetUseCustomScrollBars(const Value :Boolean);
begin
  FListBox.UseCustomScrollBars := Value;
  inherited UseCustomScrollBars := Value;
end;
{> ELSCROLLBAR}

procedure TCustomElComboBox.AutoHistoryUpdate;
var
  ix: Integer;
  vString : TLMDString;
begin
  if (Text <> '') then
  begin
    ix := Items.IndexOf(Text);
    if ix <> -1 then
    begin
      { Entry is already in list. Let's move it}
      { Must save and restore since call to Move clears Text }
      vString := Text;
      if FAutoHistoryDirection = ahdFirst then
        Items.Move(ix, 0)
      else
        Items.Move(ix, pred(Items.Count));
      Text := vString;
      if Assigned(FOnAutoHistoryItemMove) then
        FOnAutoHistoryItemMove(self, Text, ix);
    end
    else
    begin
      if FAutoHistoryDirection = ahdLast then
      begin
        if (FAutoHistoryLimit > 0) and (Items.Count >= FAutoHistoryLimit) then
          Items.Delete(0);
        Items.Add(Text);
      end else
      begin
        if (FAutoHistoryLimit > 0) and (Items.Count >= FAutoHistoryLimit) then
          Items.Delete(Items.Count - 1);
        Items.Insert(0,Text);
      end;
      if Assigned(FOnAutoHistoryItemAdd) then
        FOnAutoHistoryItemAdd(self, Text, Items.IndexOf(Text));
    end;
  end;
end;

procedure TCustomElComboBox.CreateParams(var Params: TCreateParams);
const
  ComboBoxStyles: array[TComboBoxStyle] of DWORD = (
    CBS_DROPDOWN, CBS_SIMPLE, CBS_DROPDOWNLIST,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWFIXED,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWVARIABLE);
begin
  inherited;
//  CreateSubClass(Params, 'COMBOBOX');
  Params.Style := Params.Style or WS_CLIPCHILDREN or ComboBoxStyles[FStyle];
  //with Params do
  //Style :=  Style or (WS_VSCROLL or CBS_HASSTRINGS or CBS_AUTOHSCROLL);
end;

procedure TCustomElComboBox.CreateWnd;
begin
  inherited;
  AdjustRegion;
end;

{
const
  ComboBoxStyles: array[TComboBoxStyle] of DWORD = (
    CBS_DROPDOWN, CBS_SIMPLE, CBS_DROPDOWNLIST,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWFIXED,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWVARIABLE);
  CharCases: array[TEditCharCase] of DWORD = (0, CBS_UPPERCASE, CBS_LOWERCASE);
  Sorts: array[Boolean] of DWORD = (0, CBS_SORT);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'COMBOBOX');
  with Params do
  begin
    Style := Style or (WS_VSCROLL or CBS_HASSTRINGS or CBS_AUTOHSCROLL) or
      ComboBoxStyles[FStyle] or Sorts[FSorted] or CharCases[FCharCase];
  end;
end;
}

procedure TCustomElComboBox.ELThemeChanged(var Message: TMessage);
begin
  // Delphi 2k7 fix
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  if Showing and (ComponentState * [csLoading, csReading] = []) then
    RecreateWnd;
  inherited; //<- VB Sep 2010 have to get to DoThemeChanged so that ChangeBtnGlyph is called
end;

function TCustomElComboBox.GetListImageForm: TElImageForm;
begin
  result := FListBox.ImageForm;
end;

procedure TCustomElComboBox.SetListImageForm(newValue: TElImageForm);
begin
  FListBox.ImageForm := newValue;
end;

destructor TCustomElComboBox.Destroy;
begin
  FListBox.Free;
  FForm.Free;
  StopClearSearchTimeoutThread;
  FreeAndNil(Input);
  inherited;
end;

procedure TCustomElComboBox.DoDropDown;
begin
  if Assigned(FOnDropDown) then FOnDropDown(Self);
end;

procedure TCustomElComboBox.DoCloseUp;
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self);
end;

function TCustomElComboBox.GetDropDownHeight: Integer;
var
  i, vBrdr,
  CurItemHeight :Integer;
begin
  vBrdr := 0; // GetSystemMetrics(SM_CYBORDER);
  Result := 0;
  if FListBox.Items.Count = 0 then
    Result := FListBox.ItemHeight + vBrdr * 2
  else
  if FStyle = csOwnerDrawVariable then
    for i := 0 to Min(FListBox.Items.Count - 1, FDropDownCount) do
    begin
      CurItemHeight := ItemHeight;
      FListBox.MeasureItem(i, CurItemHeight);
      Inc(Result, CurItemHeight + vBrdr * 2);
    end
  else
    if FListBox.Items.Count < FDropDownCount then
      Result := FListBox.ItemHeight * FListBox.Items.Count + vBrdr * 2
    else
      Result := FListBox.ItemHeight * FDropDownCount + vBrdr * 2;
end;

procedure TCustomElComboBox.DropDown;
var
  P, P1: TPoint;
  PF: TCustomForm;
  FormHeight : integer;
begin
  // Fix fsMDIForm
  PF := GetParentForm(Self);

  if FForm.Visible then
  begin
    if TForm(PF).FormStyle = fsMDIForm then
    begin
      PBoolean(@PF.Active)^ := FOldActive;
      end;
    CloseUp(False);
  end
  else
  if CanDrop then
  begin
    if not Focused then
      SetFocus;
    if FOwnReadOnly or FReadOnly or (Style = csDropDownList) then
    begin
      SendMessage(Handle, EM_SETSEL, -1, -1);
      HideCaret(Handle);
    end;
    FDroppedDown := true;
    FIgnoreFocus := True;
    DoDropDown;
    FIgnoreFocus := False;
    FIgnoreItemIdx := true;
    FForcedText := true;

    if TForm(PF).FormStyle = fsMDIForm then
    begin
      FOldActive := PF.Active;
      PBoolean(@PF.Active)^ := True;
    end;

    if ShowGripper and Self.FUseSaveSize then
    begin
      FForm.Width := FSaveSize.cx;
      FForm.Height := FSaveSize.cy;
    end
    else
    begin
      if FDropDownWidth > 0 then
        FForm.Width := FDropDownWidth
      else
        FForm.Width := Width;

      FormHeight := GetDropDownHeight;
      FForcedText := false;
      FormHeight := FormHeight + GetSystemMetrics(SM_CYEDGE) * 2;

      if HorizontalScroll = true then
        // Extra calculation must be done, to check if the extra-height is needed :cool:
        FormHeight := FormHeight + GetSystemMetrics(SM_CYHSCROLL);
      if ShowGripper then
        FormHeight := FormHeight + GetSystemMetrics(SM_CYHSCROLL);

      FForm.Height := FormHeight;
    end;

    FIgnoreItemIdx := false;

    P := Parent.ClientToScreen(Point(Left, Top));
    Inc(P.X, Width);
    Inc(P.Y, Height);

    if (FDropDownAlignment = taRightJustify) xor RightAlignedView then
      Dec(P.X, FForm.Width)
    else
      Dec(P.X, self.Width);

    if P.Y + FForm.Height > GetDesktopBottom then
      P.Y := P.Y - FForm.Height - Height;

    if (P.X + FForm.Width > GetDesktopRight) then
    begin
      P1 := P;
      P1.x := (Left + Width) - FForm.Width;
      P1 := Parent.ClientToScreen(P1);
      P.X := P1.x;
    end;

    if AdjustDropDownPos then
    begin
      P1 := Point(0, PF.ClientHeight);
      P1 := PF.ClientToScreen(P1);
      if P.Y + FForm.Height > P1.y then
      begin
        P1 := Point(0, 0);
        P1 := PF.ClientToScreen(P1);
        if P.Y - Height - FForm.Height >= P1.y then
          P.Y := P.Y - Height - FForm.Height;
      end;
    end;
    FListBox.UseXPThemes := UseXPThemes;
    FListBox.ItemIndex := ItemIndex;

    // FListBox.SetBounds(0, 0, FForm.ClientWidth, FForm.ClientHeight - GetSystemMetrics(SM_CYHSCROLL));
    SetWindowPos(FForm.Handle, HWND_TOPMOST, P.X, P.Y, 0, 0,
      SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOSIZE);
    TElComboButton(FButton).Down := true;
    FForm.Visible := True;
    SetWindowPos(FForm.Handle, HWND_TOPMOST, P.X, P.Y, 0, 0,
      SWP_NOACTIVATE or SWP_NOSIZE);
  end
  else
    TElComboButton(FButton).Down := false;
  invalidate;
end;

procedure TCustomElComboBox.GetDropDownValue;
begin
  FItemIndex := FListBox.ItemIndex;
  if FItemIndex > -1 then
    Text := FListBox.Items[FItemIndex]
  else
    Text := '';
  if AutoSelect and (Text <> '') then
  begin
    SelectAll;
    Self.LeftChar := 0;
  end;
end;

function TCustomElComboBox.GetListBoxPopup: TPopupMenu;
begin
  Result := FListBox.PopupMenu;
end;

procedure TCustomElComboBox.SetListBoxPopup(Value: TPopupMenu);
begin
  FListBox.PopupMenu := Value;
end;

function TCustomElComboBox.GetDroppedDown: boolean;
begin
  Result := FDroppedDown;
end;

function TCustomElComboBox.GetItems: TLMDStrings;
begin
  Result := FListBox.Items;
end;

function TCustomElComboBox.GetListColor: TColor;
begin
  Result := FListBox.Color;
end;

function TCustomElComboBox.GetListInvertSelection: boolean;
begin
  Result := FListBox.InvertSelection;
end;

function TCustomElComboBox.GetSorted: boolean;
begin
  Result := FListBox.Sorted;
end;

function TCustomElComboBox.GetUseBackground: boolean;
begin
  Result := inherited UseBackground;
end;

procedure TCustomElComboBox.KeyDown(var Key: Word; Shift: TShiftState);

  procedure IntKeyDown(var Key: Word; Shift: TShiftState);
  begin
    if Assigned(OnKeyDown) then OnKeyDown(Self, Key, Shift);
  end;

begin
  {
  if ShortCut(Key, Shift) = ButtonShortCut then
  begin
    Key := #0;
    DropDown;
  end;
  }
  {
  else
  if AutoCompletion and not FForm.Visible and (Shift = []) and (not ReadOnly) then
  begin
    if Key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_HOME, VK_END] then
      DoAutoComplete;
  end;
  }
  IntKeyDown(Key, Shift);
  if ((Key = VK_DOWN) or (Key = VK_UP)) then
  begin
    if Key <> 0 then
    begin
      if Shift = [ssAlt] then
        DropDown
      else
      // if not (ssCtrl in Shift) then
      begin
        if  not ReadOnly then
        begin
          if FForm.Visible then
            FListBox.Perform(WM_KEYDOWN, Key, 0)
          else
          if CanDrop then
            SelectItem(Key = VK_UP);
        end;
        Key := 0;
      end
    end
  end
  else
  if ((Key = VK_NEXT) or (Key = VK_PRIOR)) and FForm.Visible then
  begin
    if Key <> 0 then
      FListBox.Perform(WM_KEYDOWN, Key, 0);
    Key := 0;
  end
  else
  if (Key = VK_ESCAPE) and FForm.Visible then
  begin
    if Key <> 0 then
      CloseUp(False);
    Key := 0;
  end
  else
  if (Key = VK_F4) and (Shift = []) then
  begin
    DroppedDown := not DroppedDown;
  end
  else
  if (Key = VK_RETURN) and FForm.Visible then
  begin
    if Key <> 0 then
      CloseUp(true);
    Key := 0;
  end;
  if (Style in [csDropDown, csSimple]) then
    inherited;
end;

procedure TCustomElComboBox.ListBoxClick(Sender: TObject);
begin
  if (FListBox.ItemIndex = -1) and (FListBox.Items.Count > 0) then
    FListBox.ItemIndex := 0;
  // We change index only after closing !!!
  {
  FIgnoreItemIdx := true;
  ItemIndex := FListBox.ItemIndex;
  LeftChar := 0;
  FIgnoreItemIdx := false;
  if NotifyUserChangeOnly then
    Change;
  {}
end;

procedure TCustomElComboBox.Loaded;
var
  i: integer;
begin
  inherited;
  FListBox.RecreateWnd;
  i := FItemIndex;
  if LMDInRange(i, 0, Items.Count - 1) then
  begin
    FItemIndex := -2;
    ItemIndex := i;
  end
  else
    ItemIndex := -1;
end;

procedure TCustomElComboBox.SetDropDownCount(const Value: integer);
begin
  if (FDropDownCount <> Value) and (Value > 0) then
    FDropDownCount := Value;
end;

procedure TCustomElComboBox.SetCanDrop(const Value: boolean);
begin
  if FCanDrop <> Value then
  begin
    FCanDrop := Value;
    // FButton.KeepColor := not CanDrop;
    FButton.Enabled := Value;
    if (not FCanDrop) then
      SetDroppedDown(false);
  end;
end;

procedure TCustomElComboBox.SetDroppedDown(const Value: boolean);
begin
  if GetDroppedDown <> Value then DropDown;
end;

procedure TCustomElComboBox.SetItemIndex(const Value: Integer);
var
  ChAllowed: boolean;
begin
  if ComponentState * [csLoading, csReading] <> [] then
    FItemIndex := Value
  else
  begin
    ChAllowed := FChangeAllowed;
    if FListBox.ItemIndex <> Value then
    begin
      FListBox.OnClick := nil;
      FListBox.ItemIndex := Value;
      FListBox.OnClick := ListBoxClick;
    end;
    //if not DroppedDown then
    begin
      FItemIndex := Value;
      if not FForcedText then
      begin
        FIgnoreItemIdx := true;
        if (Value = -1) then
        begin
          if (not (GetCurrentStyle in [csDropDown, csSimple])) or FForcedTextClear then
            inherited Text := '';
        end
        else
        begin
          inherited Text := Items[Value];
        end;
        FIgnoreItemIdx := false;
        SelectAll;
        LeftChar := 0;
      end;
    end;
    if ChAllowed and NotifyUserChangeOnly then
      Change;
  end;
end;

procedure TCustomElComboBox.SetItems(const Value: TLMDStrings);
begin
  FListBox.Items.Assign(Value);
end;

procedure TCustomElComboBox.SetListColor(const Value: TColor);
begin
  FListBox.Color := Value;
end;

procedure TCustomElComboBox.SetListInvertSelection(const Value: boolean);
begin
  FListBox.InvertSelection := Value;
end;

procedure TCustomElComboBox.SetSorted(const Value: boolean);
begin
  FListBox.Sorted := Value;
end;

procedure TCustomElComboBox.SetStyle(Value: TComboBoxStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    FReadOnly := (not (Style in [csDropDown, csSimple])) or FOwnReadOnly;
    FIgnoreReadOnlyState := not FOwnReadOnly;
//    FReadOnly := FStyle <> csDropDown;
//    FIgnoreReadOnlyState := FStyle <> csDropDown;
    if FStyle = csOwnerDrawVariable then
      FListBox.Style := lbOwnerDrawVariable
    else
      FListBox.Style := lbOwnerDrawFixed;
    RecreateWnd;
  end;
end;

procedure TCustomElComboBox.ComboWndProc(var Message: TMessage; ComboWnd: THandle; ComboProc: Pointer);
begin
//
end;

function TCustomElComboBox.GetItemHeight: Integer;
begin
  Result := FListBox.ItemHeight;
end;

procedure TCustomElComboBox.SetItemHeight(Value: Integer);
begin
  FListBox.ItemHeight := Value;
end;

procedure TCustomElComboBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  if Assigned(FOnMeasureItem) then FOnMeasureItem(Self, Index, Height);
end;

procedure TCustomElComboBox.DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState);
begin
  if Assigned(FOnDrawItem) then FOnDrawItem(Self, Index, R, State);
end;

function TCustomElComboBox.GetEditHandle: HWND;
begin
  Result := Handle;
end;

procedure TCustomElComboBox.SetDropDownAlignment(Value: TAlignment);
begin
  if Value <> taCenter then
    FDropDownAlignment := Value;
end;

procedure TCustomElComboBox.SetUseBackground(const Value: boolean);
begin
  if GetUseBackground <> Value then
  begin
    inherited UseBackground := Value;
    FListBox.UseBackground := Value;
  end;
end;

function TCustomElComboBox.GetDroppedIndex: integer;
begin
  result := FListBox.ItemIndex;
end;

procedure TCustomElComboBox.WMKillFocus(var Msg: TWMKillFocus);
begin
  if not HandleAllocated then
    exit;

  inherited;

  if DroppedDown and (not FIgnoreFocus) then
    CloseUp(False);

  if LMDSIWindowsVistaUp and (FButton <> nil) then
    FButton.Invalidate;
end;

procedure TCustomElComboBox.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if (Style = csDropDownList) then
    SendMessage(Handle, EM_SETSEL, -1, -1);
  if FOwnReadOnly or FReadOnly then
    HideCaret(Handle);
end;

function TCustomElComboBox.GetBtnArrowColor: TColor;
{ Returns the value for the BtnArrowColor property. }
begin
  GetBtnArrowColor := FArrowColor;
end; { GetBtnArrowColor }

procedure TCustomElComboBox.SetBtnArrowColor(newValue: TColor);
begin
  if FArrowColor <> newValue then
  begin
    FArrowColor := newValue;
    ChangeBtnGlyph;
    Invalidate;
  end;
end; { SetBtnArrowColor }

procedure TCustomElComboBox.ChangeBtnGlyph;
var
  FGlyph: TBitmap;
begin
  if (not IsThemed) or (not TElComboButton(FButton).IsThemed) then
  begin
    FGlyph := TBitmap.Create;
    FGlyph.PixelFormat := pf24bit;
    FGlyph.Width := 9;
    FGlyph.Height := 5;
    if Assigned(Screen) then
    begin
      FGlyph.Width := MulDiv(FGlyph.Width, Screen.PixelsPerInch, 96);
      FGlyph.Height := MulDiv(FGlyph.Height, Screen.PixelsPerInch, 96);
    end;
    FGlyph.TransparentMode := tmFixed;
    FGlyph.TransparentColor := clGreen;
    FGlyph.Canvas.Brush.Color := TElComboButton(FButton).Color;
    FGlyph.Canvas.FillRect(Rect(0, 0, FGlyph.Width, FGlyph.Height));
    LMDDrawArrow(FGlyph.Canvas, eadDown, Rect(0, 1, FGlyph.Width, FGlyph.Height), FArrowColor, Enabled);
    TElComboButton(FButton).Glyph := FGlyph;
    FGlyph.Free;
  end;
end;

procedure TCustomElComboBox.SetAltBtnAlign(Value: TLeftRight);
begin
  FAltBtnAlign := Value;
  if HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end;

function TCustomElComboBox.GetListTransparentSelection: Boolean;
begin
  Result := FListBox.TransparentSelection;
end;

procedure TCustomElComboBox.SetListTransparentSelection(Value: Boolean);
begin
  FListBox.TransparentSelection := Value;
end;

procedure TCustomElComboBox.SetDropDownWidth(const Value: Integer);
begin
  if Value < 1 then
    FDropDownWidth := -1
  else
    FDropDownWidth := Value;
end;

procedure TCustomElComboBox.DoAutoComplete;
var
  i: integer;
  S,
    S1: TLMDString;
  ssl : Integer;
  b : boolean;
begin
  ssl := SelStart;
  S := Copy(Text, 1, ssl);
  if Length(S) > 0 then
  begin
    for i := 0 to Pred(FListBox.Items.Count) do
    begin
      S1 := GetTextFromItem(i);

      if AutoCompleteUseCase then
        b := (S = Copy(S1, 1, Length(S))) and (Length(S1) > Length(S))
      else
{$IFDEF LMD_UNICODE}
      b := (LMDWideLowercase(S) = LMDWideLowercase(Copy(S1, 1, Length(S)))) and (Length(S1) >= Length(S));
{$ELSE}
      b := (Lowercase(S) = Lowercase(Copy(S1, 1, Length(S)))) and (Length(S1) >= Length(S));
{$ENDIF}
      if b then
      begin
        Text := S1;
        SelStart := ssl;
        SelLength := Length(Text) - ssl;
        CaretX := ssl;
        // SelStart := ssl;
        //LeftChar := 0;
        Break;
      end;
    end;
  end;
end;

procedure TCustomElComboBox.WMChar(var Message: TWMChar);
begin
  if FWMKeyDown then
  begin
    inherited;
    if AutoCompletion and (not (FOwnReadOnly or FReadOnly )) and (Message.CharCode <> VK_BACK{=8}) then
      if ((SelStart + SelLength) = Length(Text)) or FAutoCompletionProcessByAnyChange  then
        DoAutoComplete;
  end
  else
  begin
    Input.WMChar(Message);
    if (not FOwnReadOnly) and AutoCompletion then
    begin
      if Length(Input.Text) = 0 then
        FTextBefoCompletation := Text;
      if (not DoPerformSearch(Input.Text, -1)) then
        if (Length(Input.Text) > 1) and (Input.IsRepeatSymbolString) then
        begin
          Input.Reset;
          Input.WMChar(Message);
          DoPerformSearch(Input.Text, -1);
        end
        else
          Input.Reset;
    end;
  end;
end;

procedure TCustomElComboBox.SetReadOnly(Value: boolean);
begin
  if FOwnReadOnly <> Value then
  begin
    FOwnReadOnly := Value;
//    inherited ReadOnly := Value;
    FReadOnly := (not (Style in [csDropDown, csSimple])) or FOwnReadOnly;
    FIgnoreReadOnlyState := not FOwnReadOnly or not DisplayReadOnlyOptions.Enabled;
    if ReadOnly then
    begin
      ControlStyle := ControlStyle - [csDoubleClicks];
    end
    else
    begin
      ControlStyle := ControlStyle + [csDoubleClicks];
  //    Style := csDropDown;
    end;
    Invalidate;
  end;
end;

procedure TCustomElComboBox.SetActiveBorderType(const Value: TElFlatBorderType);
begin
  inherited;
  if Assigned(FListBox) then
    FListBox.ActiveBorderType := Value;
  if HandleAllocated then
    FButton.Invalidate;
end;

procedure TCustomElComboBox.SetInactiveBorderType(const Value: TElFlatBorderType);
begin
  inherited;
  if Assigned(FListBox) then
    FListBox.InactiveBorderType := Value;
  if HandleAllocated then
    FButton.Invalidate;
end;

procedure TCustomElComboBox.SetLineBorderActiveColor(Value: TColor);
begin
  inherited;
  if Assigned(FListBox) then
    FListBox.LineBorderActiveColor := Value;
  if HandleAllocated then
    FButton.Invalidate;
end;

procedure TCustomElComboBox.SetLineBorderInactiveColor(Value: TColor);
begin
  inherited;
  if Assigned(FListBox) then
    FListBox.LineBorderInactiveColor := Value;
  if HandleAllocated then
    FButton.Invalidate;
end;

procedure TCustomElComboBox.SetFlat(const Value: boolean);
begin
  inherited;
  if HandleAllocated then
    FButton.Invalidate;
end;

function TCustomElComboBox.GetButtonClass: TCustomElGraphicButtonClass;
begin
  Result := TElComboDropDownButton;
end;

function TCustomElComboBox.GetAltButtonClass: TCustomElGraphicButtonClass;
begin
  Result := TElComboButton;
end;

procedure TCustomElComboBox.CMDialogKey(var Message: TCMDialogKey);
begin
  if (Message.CharCode = VK_RETURN) and FForm.Visible then
  begin
    CloseUp(true);
    Message.result := 1;
  end
  else
    if (Message.CharCode = VK_ESCAPE) then
    begin
      if FForm.Visible then
      begin
        CloseUp(false);
        Message.result := 1;
      end
      else
      begin
        if Length(Input.Text) > 0 then
          Text := FTextBefoCompletation;
        Input.Reset;
      end;
    end
    else
      inherited;
end;

procedure TCustomElComboBox.DestroyWnd;
begin
  if DroppedDown then
    CloseUp(false);
  inherited;
end;

procedure TCustomElComboBox.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if DroppedDown then
    Message.result := Message.Result or DLGC_WANTALLKEYS;
end;

function TCustomElComboBox.GetShowLineHint: Boolean;
begin
  Result := FListBox.ShowLineHint;
end;

procedure TCustomElComboBox.SetShowLineHint(Value: Boolean);
begin
  FListBox.ShowLineHint := Value;
end;

procedure TCustomElComboBox.SetHorizontalScroll(const Value: Boolean);
begin
  if FHorizontalScroll <> Value then
  begin
    FHorizontalScroll := Value;
    FListBox.HorizontalScroll := Value;
    if DroppedDown then
    begin
      if Value then
        FForm.Height := FForm.Height + GetSystemMetrics(SM_CYHSCROLL)
      else
        FForm.Height := FForm.Height - GetSystemMetrics(SM_CYHSCROLL);
    end;
  end;
end;

function TCustomElComboBox.GetRightAlignedView:Boolean;
begin
  Result := FRightAlignedView;
end;

procedure TCustomElComboBox.SetRightAlignedView(Value: Boolean);
begin
  inherited;
  FListBox.RightAlignedView := RightAlignedView;
  if HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end;

procedure TCustomElComboBox.SetRightAlignedText(Value: Boolean);
begin
  inherited;
  FListBox.RightAlignedText := RightAlignedText;
  if HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end;

procedure TCustomElComboBox.SetFocusedSelectColor(newValue: TColor);
begin
  inherited;
  FListBox.FocusedSelectColor := newValue;
  FListBox.HideSelectColor := newValue;
end;

procedure TCustomElComboBox.SetFocusedSelectTextColor(newValue: TColor);
begin
  inherited;
  FListBox.FocusedSelectTextColor := newValue;
  FListBox.HideSelectTextColor := newValue;
end;

procedure TCustomElComboBox.SetHighlightAlphaLevel(Value: Integer);
begin
  inherited;
  FListBox.HighlightAlphaLevel := Value;
end;

procedure TCustomElComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  // Fake Properties:
  with GetElReader do
  begin
    Filer.DefineProperty('ListSelectedColor', FakeIdent, nil, false);
    Filer.DefineProperty('ListSelectedFontColor', FakeIdent, nil, false);
    Filer.DefineProperty('UseCustomScrollbars', FakeBoolean, nil, false);
    Filer.DefineProperty('VertScrollbarStyles', FakeValue, nil, false);
    Filer.DefineProperty('HorzScrollbarStyles', FakeValue, nil, false);
    Filer.DefineProperty('UseCustomScrollbars', FakeBoolean, nil, false);
    Filer.DefineProperty('BtnDrawFrame', FakeBoolean, nil, false);
    Filer.DefineProperty('AltBtnDrawFrame', FakeBoolean, nil, false);
  end;
  // Other properties:
  Filer.DefineProperty('BtnColor', ReadBtnColor, nil, false);
  Filer.DefineProperty('BtnArrowColor', ReadBtnArrowColor, nil, false);
  Filer.DefineProperty('BtnFlat', ReadBtnFlat, nil, false);
  Filer.DefineProperty('BtnTransparent', ReadBtnTransparent, nil, false);
  Filer.DefineProperty('AltBtnColor', ReadAltBtnColor, nil, false);
  Filer.DefineProperty('AltBtnFlat', ReadBtnFlat, nil, false);
  Filer.DefineProperty('AltBtnTransparent', ReadAltBtnTransparent, nil, false);
  Filer.DefineProperty('AltBtnVisible', ReadAltBtnVisible, nil, false);
  Filer.DefineProperty('AltBtnWidth', ReadAltBtnWidth, nil, false);
  Filer.DefineProperty('AltBtnPosition', ReadAltBtnPosition, nil, false);
  // Filer.DefineProperty('ReadOnly', ReadReadOnly, nil, false);
end;

procedure TCustomElComboBox.ReadBtnColor(Reader: TReader);
var
  C: integer;
begin
  C := ButtonColor;
  IdentToColor(Reader.ReadIdent, C);
  ButtonColor := C;
end;

function TCustomElComboBox.GetTextFromItem(Index: integer): TLMDString;
begin
  Result := Items[Index];
end;

function TCustomElComboBox.GetThemedElement: TThemedElement;
begin
  Result := teComboBox;
end;

procedure TCustomElComboBox.GetThemedElementDetails(var ADetails: TThemedElementDetails);
begin
  inherited;

  if LMDSIWindowsVistaUp and (UseThemeMode = ttmPlatform) then
  begin
    ADetails.Element := GetThemedElement;
    if Style = csDropDownList then
    begin
      ADetails.Part := CP_READONLY;
      ADetails.State := CBXS_NORMAL;
      if FMouseOver then
        ADetails.State := CBXS_HOT;

      if Focused and (DroppedDown) then
        ADetails.State := CBXS_PRESSED;
    end;
    if Style = csDropDown then
    begin
      ADetails.Part := CP_BORDER;
      ADetails.State := CBXS_NORMAL;
      if FMouseOver then
        ADetails.State := CBXS_HOT;
      if Focused and (DroppedDown) then
        ADetails.State := CBXS_PRESSED;
    end;
  end;
end;

(*
procedure TCustomElComboBox.GetPaintThemedElementDetails(var ADetails: TThemedElementDetails);
begin
  if LMDSIWindowsVistaUp then
    if Style = csDropDownList then
    begin
      ADetails.Element := teComboBox;
      ADetails.Part := CP_READONLY;
      ADetails.State := CBXS_NORMAL;
      if Focused then
        ADetails.State := CBXS_PRESSED
      else
      if FMouseOver then
        ADetails.State := CBXS_HOT;
    end;
end;
*)

procedure TCustomElComboBox.ReadBtnArrowColor(Reader: TReader);
var
  C: integer;
begin
  C := ButtonArrowColor;
  IdentToColor(Reader.ReadIdent, C);
  ButtonArrowColor := C;
end;

procedure TCustomElComboBox.ReadBtnFlat(Reader: TReader);
begin
  ButtonFlat := Reader.ReadBoolean;
end;

procedure TCustomElComboBox.ReadBtnTransparent(Reader: TReader);
begin
  ButtonTransparent := Reader.ReadBoolean;
end;

procedure TCustomElComboBox.ReadAltBtnColor(Reader: TReader);
var
  C: integer;
begin
  C := AltButtonColor;
  IdentToColor(Reader.ReadIdent, C);
  AltButtonColor := C;
end;

procedure TCustomElComboBox.ReadAltBtnFlat(Reader: TReader);
begin
  AltButtonFlat := Reader.ReadBoolean;
end;

procedure TCustomElComboBox.ReadAltBtnTransparent(Reader: TReader);
begin
  AltButtonTransparent := Reader.ReadBoolean;
end;

procedure TCustomElComboBox.ReadAltBtnVisible(Reader: TReader);
begin
  AltButtonVisible := Reader.ReadBoolean;
end;

procedure TCustomElComboBox.ReadAltBtnWidth(Reader: TReader);
begin
  AltButtonWidth := Reader.ReadInteger;
end;

procedure TCustomElComboBox.ReadAltBtnPosition(Reader: TReader);
var
  S: string;
begin
  S := Reader.ReadIdent;
  if s = 'taRightJustify' then
    AltButtonPosition := taRightJustify
  else
    AltButtonPosition := taLeftJustify;
end;

function TCustomElComboBox.GetAltBtnGlyph: TBitmap;
begin
  Result := AltButtonGlyph;
end;

procedure TCustomElComboBox.SetAltBtnGlyph(Value: TBitmap);
begin
  AltButtonGlyph := Value;
end;

procedure TCustomElComboBox.ReadReadOnly(Reader: TReader);
begin
  if Reader.ReadBoolean then
    FOwnReadOnly := True;
//    Self.Style := csDropDownList;
end;

function TCustomElComboBox.GetItemWidth(Index: Integer): Integer;
var
  S: TLMDString;
  ARect: TRect;
begin
  S := Items[Index] + 'W';
  SetRectEmpty(ARect);
  LMDDrawText(Canvas.Handle, S, Length(S), ARect,
    DT_CALCRECT);
  result := ARect.Right;
end;

procedure TCustomElComboBox.DoExit;
begin
  if FAutoHistory and (Text <> '') then
    AutoHistoryUpdate;

  inherited;
end;

procedure TCustomElComboBox.DoThemeChanged;
begin
  inherited;
  ChangeBtnGlyph;
end;

procedure TCustomElComboBox.SetUseXPThemes(const Value : boolean);
begin
  inherited;
  if Assigned(FListBox) then
    FListBox.UseXPThemes := Value;
end;

procedure TCustomElComboBox.SetThemeGlobalMode(const Value: Boolean);
begin
  inherited;
  if Assigned(FListBox) then
    FListBox.ThemeGlobalMode := Value;
end;

procedure TCustomElComboBox.SetThemeMode(const Value: TLMDThemeMode);
begin
  inherited;
  if Assigned(FListBox) then
    FListBox.ThemeMode := Value;
end;

function TCustomElComboBox.GetRightOffsetForBackground: Integer;
begin
//    Result := GetSystemMetrics(SM_CXVSCROLL) + 2
  if FButton.Visible and (not FRightAlignedView) then
    Result := FButton.Width
  else
    Result := 0;
end;

procedure TCustomElComboBox.PaintText(Canvas : TCanvas);
var
  R: TRect;
  T: TOwnerDrawState;
  LOldBkColor: TColor;
begin
  if (FItemIndex > -1) and ((FStyle = csOwnerDrawFixed) or (FStyle = csOwnerDrawVariable)) then
  begin
    R := EditRect;
    FCanvas := Canvas;

    T := [odComboBoxEdit];

    DrawItem(FItemIndex, R, T);
  end
  else
  begin
    if (Style = csDropDownList) then
    begin
      if AutoCompletion and (Length(Input.Text) > 0) then
      begin
        FSelLength := Length(Input.Text);
        FCaretX := FSelLength;
        FCaretY := 0;
        FSelFirstX := 0;
        FSelLastX := Length(Input.Text);
//        SendMessage(Handle, EM_SETSEL, 0, Length(Input.Text))
      end
      else
//        SendMessage(Handle, EM_SETSEL, -1, -1);
      HideCaret(Handle);
    end;{}
    if Focused and (Style = csDropDownList) then
    begin
      R := ClientRect;
      if ButtonVisible then
        R.Right := R.Right - GetSystemMetrics(SM_CXVSCROLL) - 1;
      if (not DroppedDown) and (not LMDSIWindowsVistaUp) then
      begin
        LOldBkColor := Canvas.Brush.Color;
        Canvas.Brush.Color := GetBkColor;
        if FRightAlignedView and FButton.Visible then
        begin
          OffsetRect(R, FButton.Width, 0);
          Dec(R.Right, 1);
        end;

        Canvas.FillRect(R);
        Canvas.DrawFocusRect(R);
        Canvas.Brush.Color := LOldBkColor;
      end;
      end;

    if LMDSIWindowsVistaUp and Focused and (Style = csDropDownList) and IsThemed then
    begin
      LOldBkColor := FocusedSelectTextColor;
      FFocusedSelectTextColor := Font.Color;
      inherited;
      FFocusedSelectTextColor := LOldBkColor;
    end
    else
      inherited;
  end;
end;

{$IFDEF LMD_UNICODE}
procedure TCustomElComboBox.WMDeadChar(var Message: TWMDeadChar);
begin
  inherited;
  if (Style <> csDropDown) and AutoCompletion then
  begin
    Input.WMDeadChar(Message);
  end;
end;

procedure TCustomElComboBox.WMIMEComposition(var Message: TMessage);
begin
  inherited;
  if (Style <> csDropDown) and AutoCompletion and not FOwnReadOnly then
  begin
    if Length(Input.Text) = 0 then
      FTextBefoCompletation := Text;
    Input.WMImeComposition(Message);
    if (not DoPerformSearch(Input.Text)) then
      if (Length(Input.Text) = 2) and (Input.Text[1] = Input.Text[2]) then
      begin
        Input.Reset;
        Input.WMImeComposition(Message);
        DoPerformSearch(Input.Text, -1);
      end
      else
        Input.Reset;
  end;
end;

procedure TCustomElComboBox.WMIMEStartComposition(var Message: TMessage);
var
  IMC: HIMC;
  LogFont: TLogFont;
  CF: TCompositionForm;
begin
  inherited;
  if (Style <> csDropDown) and AutoCompletion then
  begin
    IMC := ImmGetContext(Handle);
    if IMC <> 0 then
    begin
      GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @LogFont);
      ImmSetCompositionFont(IMC, @LogFont);
      CF.dwStyle := CFS_RECT;
      CF.rcArea  := ClientRect;
      CF.ptCurrentPos := Point(0, 0);

      ImmSetCompositionWindow(IMC, @CF);
      ImmReleaseContext(Handle, IMC);
    end;
  end;
end;
{$ENDIF}

procedure TCustomElComboBox.StartClearSearchTimeoutThread;
begin
  if Assigned (SearchTextTimeoutThread) then
    TSearchTextTimeoutThread(SearchTextTimeoutThread).KeepAlive := True
  else
  begin
    SearchTextTimeoutThread := TSearchTextTimeoutThread.Create ;
    SearchTextTimeoutThread.OnTerminate := SearchTextTimeout ;
    SearchTextTimeoutThread.Resume
  end;
  TSearchTextTimeoutThread(SearchTextTimeoutThread).IncrementalSearchTimeout := FIncrementalSearchTimeout;
end;

procedure TCustomElComboBox.StopClearSearchTimeoutThread;
begin
  if Assigned (SearchTextTimeoutThread) then
  begin
    SearchTextTimeoutThread.OnTerminate := nil ;
    SearchTextTimeoutThread.Terminate ;

    SearchTextTimeoutThread := nil
  end
end ;

function TCustomElComboBox.DoPerformSearch(SearchText : TLMDString; AFromIndex: Integer = 0): Boolean;
var
  liIndex : Integer ;
  ItemText  : TLMDString;
  i: Integer;
begin
  Result := False;
  if (SearchText <> '') and (Items.Count > 0) then
  begin
    if AFromIndex = -1 then
    begin
      AFromIndex := ItemIndex;
      if AFromIndex < 0 then
        AFromIndex := 0;
      if (Length(SearchText) = 1) and DoCompareItems(SearchText, AFromIndex) then
        AFromIndex := ItemIndex + 1;
      if AFromIndex = Items.Count then
        AFromIndex := 0;
    end;
    for i := 0 to 1 do
    begin
      for liIndex := AFromIndex to (Items.Count - 1) do
      begin
        ItemText := Items[liIndex];

        if DoCompareItems(SearchText, liIndex) then
        begin
          if ItemIndex <> liIndex then
          begin
            ItemIndex := liIndex;
            Modified := True;
            Change;
          end;
          Result := True;
          Break;
        end;
      end;

      if AFromIndex = 0 then
        Break;

      if not Result then
        AFromIndex := 0
      else
        Break;
    end;

    StartClearSearchTimeoutThread;
  end;
end;

procedure TCustomElComboBox.SearchTextTimeout(Sender : TObject);
begin
  SearchTextTimeoutThread := nil ;
  Input.Reset;
  Invalidate;
end;

function TCustomElComboBox.DoCompareItems(SearchText : TLMDString; ItemIndex : integer): Boolean;
begin
  if AutoCompleteUseCase then
    Result := (SearchText = Copy(Items[ItemIndex], 1, Length(SearchText)))
  else
  {$ifdef LMD_UNICODE}
    Result := LMDWideSameText(SearchText, Copy(Items[ItemIndex], 1, Length(SearchText)));
  {$else}
    Result := LMDAnsiSameText(SearchText, Copy (Items[ItemIndex], 1, Length(SearchText)));
  {$endif}
end;

function TCustomElComboBox.GetImages: TCustomImageList;
begin
  Result := FListBox.Images;
end;

procedure TCustomElComboBox.SetImages(Value: TCustomImageList);
begin
  FListBox.Images := Value;
end;

function TCustomElComboBox.GetAlphaForImages: TCustomImageList;
begin
  Result := FListBox.AlphaForImages;
end;

procedure TCustomElComboBox.SetAlphaForImages(Value: TCustomImageList);
begin
  FListBox.AlphaForImages := Value;
end;

procedure TCustomElComboBox.SetEditRect(Value : TRect);
var
  LOldLeftMargin: Integer;
begin
  LOldLeftMargin := LeftMargin;
  if (Images <> nil) then
    LeftMargin := Images.Width + LOldLeftMargin
  else
    LeftMargin := LOldLeftMargin;

  inherited SetEditRect(Value);
end;

procedure TCustomElComboBox.SetShowGripper(Value: Boolean);
begin
  if FShowGripper <> Value then
  begin
    FShowGripper := Value;
    SetWindowPos(FForm.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE or SWP_FRAMECHANGED);
  end;
end;

procedure TCustomElComboBox.SelectItem(Previous : boolean);
var
  LAllow: Boolean;
  LIndex: Integer;
begin
  if Previous and (ItemIndex > 0) then
  begin
    LIndex := ItemIndex - 1;

    if Assigned(FOnBeforeSelectValue) then
      for LIndex := ItemIndex - 1 downto 0 do
      begin
        LAllow := True;
        FOnBeforeSelectValue(Self, LIndex, LAllow);
        if LAllow = True then
          Break;
      end;

    if not LAllow then
      exit;
      FChangeAllowed := true;
    ItemIndex := LIndex;
    FChangeAllowed := false;
    Modified := True;
  end;
  if (not Previous) and (ItemIndex < Items.Count - 1) then
  begin

    LIndex := ItemIndex + 1;

    if Assigned(FOnBeforeSelectValue) then
      for LIndex := ItemIndex + 1 to Items.Count - 1 do
      begin
        LAllow := True;
        FOnBeforeSelectValue(Self, LIndex, LAllow);
        if LAllow = True then
          Break;
      end;

    if not LAllow then
      exit;

    FChangeAllowed := true;
    ItemIndex := LIndex;
    FChangeAllowed := false;
    Modified := True;
  end;
end;

function TCustomElComboBox.GetBkColor: TColor;
begin
  if (Focused and Enabled) and (not (Style in [csDropDown, csSimple])) then
  begin
    if DroppedDown then
      Result := color
    else
      Result := FocusedSelectColor;
  end
  else
    Result := inherited GetBkColor;
end;

function TCustomElComboBox.GetTextColor: TColor;
begin
  if (Focused and Enabled) and (not (Style in [csDropDown, csSimple])) then
  begin
    if DroppedDown then
      Result := Font.Color
    else
      if not AutoCompletion or (AutoCompletion and (Length(Input.Text) = 0)) then
        Result :=  FocusedSelectTextColor
      else
        Result := DisabledFontColor;
  end
  else
    Result := inherited GetTextColor;
end;

function TCustomElComboBox.GetReadOnly: Boolean;
begin
  Result := FOwnReadOnly;
end;

function TCustomElComboBox.GetCurrentStyle: TComboBoxStyle;
begin
  Result := FStyle;
end;

procedure TCustomElComboBox.SetSaveUnicode(const aValue: boolean);
begin
  {$IFNDEF LMD_NATIVEUNICODE}
  {$IFDEF LMD_UNICODE}
  Items.SaveUnicode := aValue;
  {$ENDIF}
  {$ENDIF}
end;

function TCustomElComboBox.GetSaveUnicode: boolean;
begin
  {$IFNDEF LMD_NATIVEUNICODE}
  {$IFDEF LMD_UNICODE}
  result := Items.SaveUnicode;
  {$ELSE}
  result := false;
  {$ENDIF}
  {$ELSE}
  result := true;
  {$ENDIF}
end;

procedure TCustomElComboBox.SetForceItemHeight(const Value: boolean);
begin
  if FForceItemHeight <> Value then
    FForceItemHeight := Value;
end;

procedure TCustomElComboBox.WMSize(var Msg: TWMSize);
begin
  inherited;
  AdjustRegion;
end;

procedure TCustomElComboBox.AdjustFocusedRect(var aRect: TRect);
begin
  if FButton.Visible or AltButtonVisible then
    aRect := EditRect;
end;

procedure TCustomElComboBox.AdjustRegion;
var
  lRgn: HRGN;
  lPart: Integer;
  lDC: HDC;
begin
  if IsThemed then
  begin
   if (Style = csDropDownList) then
      lPart := CP_READONLY
    else
      lPart := CP_BORDER;
    lDC := GetDC(0);
    try
      if GetThemeBackgroundRegion(ThemeServices.Theme[teComboBox], lDC, LPart, CBXS_NORMAL, Rect(0, 0, Width, Height), LRgn) = S_OK then
        SetWindowRgn(Handle, LRgn, true);
    finally
      ReleaseDC(0, lDC);
    end;
  end;
end;

{ TElComboButton }
function TElComboDropDownButton.GetDetails: TThemedElementDetails;
begin
  Result.Element := teComboBox;

  if LMDSIWindowsVistaUp and (UseThemeMode = ttmPlatform) then
  begin
    Result.Part := CP_DROPDOWNBUTTONRIGHT;
    if Parent is TCustomElComboBox then
      if TCustomElComboBox(Parent).RightAlignedView then
        Result.Part := CP_DROPDOWNBUTTONLEFT;

    if TElComboBox(Parent).Style = csDropDownList then
      Result.State := CBXS_NORMAL
    else
    begin
      if not Enabled then
        Result.State := CBXS_DISABLED
      else
        if FState in [ebsDown, ebsExclusive] then
          Result.State := CBXS_PRESSED
      else
        if FMouseInControl or FMouseInArrow or Focused then
          Result.State := CBXS_HOT
        else
          if TElComboBox(Parent).MouseOver and (TElComboBox(Parent).Style = csDropDownList) then
          begin
            Result.State := CBXS_NORMAL;
          end
          else
          begin
              Result.State :=  CBXS_NORMAL;
          end;
    end
  end
  else
  begin
    if not Enabled then
      result := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
    else
      if FState in [ebsDown, ebsExclusive] then
      result := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
    else
      if FMouseInControl or FMouseInArrow or Focused then
        result := ThemeServices.GetElementDetails(tcDropDownButtonHot)
      else
        if TElComboBox(Parent).MouseOver and (TElComboBox(Parent).Style = csDropDownList) then
          result := ThemeServices.GetElementDetails(tcDropDownButtonHot)
        else
            result := ThemeServices.GetElementDetails(tcDropDownButtonNormal);
  end;
end;

function TElComboButton.GetShowGlyph: Boolean;
begin
  if Assigned(Parent) then
  begin
    Result := (not TCustomElComboBox(Parent).IsThemed) or (TCustomElComboBox(Parent).FAltButton = Self);
  end
  else
    result := true;
end;

end.
