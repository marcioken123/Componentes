unit ElCurrEdit;
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

ElCurrEdit unit
---------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

12 February, 2008 (EK)
 - Validation support added;

###############################################################################}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  StdCtrls,
  Forms,
  Math,
  Types,
  Menus,
  ImgList,
  Clipbrd,
  Themes,

  LMDTypes,
  LMDClass,
  LMDThemes,
  LMDUtils,
  LMDGraph,
  LMDGraphUtils,
  LMDElConst,
  LMDVldBase,

  ElXPThemedControl,
  ElPopBtn,
  ElEdits,
  {$ifndef NO_CALC_IN_CURREDIT}
  ElCalc,
  {$endif}
  ElVCLUtils;

const
  CURRBTNCOUNT = 2;
  CURRBTNMIN = 0;
  CURRBTNMAX = CURRBTNCOUNT - 1;
  CURRPARTMIN = 1;
  CURRPARTMAX = 2;
type
  TElCurrPartEdit = class(TElEdit)
  private
    FIsIntegerPart: boolean;
    OnPoint: TNotifyEvent;
    OnLeftPoint: TNotifyEvent;
    FSaveAlpha: Boolean;
    FSKey: Word;
  protected
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    function GetTextColor: TColor; override;
  public
    procedure CopyToClipboard; override;
    procedure CutToClipboard; override;
    procedure PasteFromClipboard; override;
    property SKey:Word read FSKey write FSKey;
    property SaveAlpha:Boolean read FSaveAlpha write FSaveAlpha;
  end;

  IntEditClass = TElCurrPartEdit;

  TElCurrencySymbolPosition = (ecsPosLeft, ecsPosRight);

  TElGraphicButtons = array[CURRBTNMIN..CURRBTNMAX] of TElGraphicButton;
  TElGraphBtnsNotifyEvent = array[CURRBTNMIN..CURRBTNMAX] of TNotifyEvent;

  {$ifndef NO_CALC_IN_CURREDIT}
  TElCalculatorFormCurrEdit = class(TElCalculatorForm)
  private
    fModalResult: integer;
  end;
  {$endif}

  TElCurrencyEdit = class(TElXPThemedControl, ILMDValidatedControl)
  protected
    FValidator: TLMDValidationEntity;
    FValidationMsgString: TLMDString;
    FErrorIndication: Boolean;
    FOnValidationError: TLMDValidationErrorEvent;
    FIgnoreReadOnlyState: Boolean;
    FValueUndefined: Boolean;
    FUseThousandSeparator: Boolean;
    FAbsValue: Currency;
    FDecimalPlaces: Byte;
    FUseSystemDecimalPlaces: Boolean;
    FCurrencySymbol: TLMDString;
    FCurrencySymbolPosition: TElCurrencySymbolPosition;
    FUseSystemCurrencySymbol: Boolean;
    FBorderStyle: TBorderStyle;
    FFlat: boolean;
    FActiveBorderType: TElFlatBorderType;
    FInactiveBorderType: TElFlatBorderType;
    FMouseOver: boolean;
    FModified: boolean;
    FDWidth: integer;
    FSWidth: integer;
    FBWidth: integer;
    FSignWidth: integer;
    FDSWidth: integer;
    FHideSelection : Boolean;
    FFocusedSelectColor: TColor;
    FFocusedSelectTextColor: TColor;
    FHideSelectColor: TColor;
    FHideSelectTextColor: TColor;

    FOnChange: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FBorderSides: TLMDBorderSides;

    FPartEditors: array[CURRPARTMIN..CURRPARTMAX] of IntEditClass;
    FButtons: TElGraphicButtons;
    FButtonClicks: TElGraphBtnsNotifyEvent;
    FEnableSign: Boolean;
    FSign: Boolean;
    FNegativeValueTextColor: TColor;
    FNegativeSignColor: TColor;
    FHandleDialogKeys: Boolean;
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
{$IFDEF LMD_UNICODE}
    FHint: TLMDString;
{$ENDIF}
    FUseDisabledColors: Boolean;
    {$ifndef NO_CALC_IN_CURREDIT}
    { Calculator fields}
    FCalcDlgResetValue: Boolean;
    fCalcDlgElCalculatorForm: TElCalculatorFormCurrEdit;
    fCalcDlgModal: Boolean;
    fCalcDlgButtonGlyphDefault: Boolean;

    fCalcDlgCaption: TCaption;
    fCalcDlgShowControlButtons: Boolean;
    fCalcDlgDigitButtonFont: TFont;
    fCalcDlgMemoryButtonFont: TFont;
    fCalcDlgOperatorButtonFont: TFont;
    fCalcDlgServiceButtonFont: TFont;
    fCalcDlgOnError: TElMathErrorEvent;
    fCalcDlgOnShow: TNotifyEvent;
    fCalcDlgOnClose: TNotifyEvent;

    fCalcDlgButtonGlyphOnChange: TNotifyEvent; {saved old event}
    fCalcDlgOnButtonClick: TNotifyEvent;
    fCalcDlgOnDeactivate: TElCalcDeactivateEvent;
    fCalcDlgOnFormShow: TNotifyEvent;
    fCalcDlgDefZeroValue:Boolean;
    { End of: Calculator fields}
    {$endif}
    FHighlightAlphaLevel: Integer;
    FLinkedControlPosition: TElLinkCtlPos;
    FLinkedControl: TControl;
    FLinkedControlSpacing: Integer;
    FDisabledColor: TColor;
    FDisabledFontColor: TColor;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorShadow: TColor;
    FBorderColorWindow: TColor;
    FCalcDlgButtonShortcut: TShortcut;
    FButtonShortCut: TShortCut;
    FDisplayReadOnlyOptions: TElDisplayOptions;

    function GetButtonIsSwitch: boolean;
    procedure SetButtonIsSwitch(const Value: boolean);
    procedure SetCalcDlgDigitButtonFont(const Value: TFont);
    procedure SetCalcDlgMemoryButtonFont(const Value: TFont);
    procedure SetCalcDlgOperatorButtonFont(const Value: TFont);
    procedure SetCalcDlgServiceButtonFont(const Value: TFont);

    function GetBkColor: TColor; virtual;
    function GetTextColor: TColor; virtual;
    procedure SetDisplayReadOnlyOptions(const Value: TElDisplayOptions);
    procedure DisplayOptionsChange(Sender: TObject);

    procedure SetValueUndefined(Value: Boolean); virtual;
    procedure SetUseThousandSeparator(Value: Boolean);
    function FracValue(AValue: Currency): string;
    procedure SetDecimalPlaces(const Value: Byte);
    procedure SetUseSystemDecimalPlaces(const Value: Boolean);
    function FindPart(Editor: IntEditClass): integer;
    procedure SetFlat(const Value: boolean);
    procedure SetActiveBorderType(const Value: TElFlatBorderType);
    procedure SetInactiveBorderType(const Value: TElFlatBorderType);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure UpdateFrame;
    procedure SetModified(Value: boolean);
    procedure UpdateParts;
    procedure UpdatePartsWidth;
    procedure SetCurrencySymbol(const Value: TLMDString);
    procedure SetUseSystemCurrencySymbol(const Value: Boolean);
    procedure SetCurrencySymbolPosition(const Value: TElCurrencySymbolPosition);
    { Buttons Index Properties}
    function GetButton(Index:Integer):TElGraphicButton;
    function GetButtonCaption(Index: Integer): TLMDString;
    function GetButtonColor(Index: Integer): TColor;
    function GetButtonDown(Index: Integer): Boolean;
    function GetButtonEnabled(Index: Integer): Boolean;
    function GetButtonFlat(Index: Integer): Boolean;
    function GetButtonVisible(Index: Integer): Boolean;
    function GetButtonWidth(Index: Integer): Integer;
    function GetButtonUseIcon(Index: Integer): Boolean;
    function GetButtonGlyph(Index: Integer): TBitmap;
    function GetButtonHint(Index: Integer): TLMDString;
    function GetButtonIcon(Index: Integer): TIcon;
    function GetButtonNumGlyphs(Index: Integer): integer;
    function GetButtonPopupPlace(Index: Integer): TPopupPlace;
    function GetButtonPullDownMenu(Index: Integer): TPopupMenu;
    function GetButtonUseImageList(Index: Integer): Boolean;
    function GetOnButtonClick(Index: Integer): TNotifyEvent;
    procedure SetButtonCaption(Index: Integer; Value: TLMDString);
    procedure SetButtonColor(const Index: Integer; const Value: TColor);
    procedure SetButtonDown(const Index: Integer; const Value: Boolean);
    procedure SetButtonEnabled(const Index: Integer; const Value: Boolean);
    procedure SetButtonFlat(const Index: Integer; const Value: Boolean);
    procedure SetButtonVisible(const Index: Integer; const Value: Boolean);
    procedure SetButtonWidth(const Index, Value: Integer);
    procedure SetButtonUseIcon(const Index: Integer; const Value: Boolean);
    procedure SetButtonGlyph(const Index: Integer; const Value: TBitmap);
    procedure SetButtonHint(const Index: Integer; const Value: TLMDString);
    procedure SetButtonIcon(const Index: Integer; const Value: TIcon);
    procedure SetButtonNumGlyphs(const Index, Value: integer);
    procedure SetButtonPopupPlace(const Index: Integer; const Value:
      TPopupPlace);
    procedure SetButtonPullDownMenu(const Index: Integer; const Value:
      TPopupMenu);
    procedure SetButtonUseImageList(const Index: Integer; const Value: Boolean);
    procedure SetOnButtonClick(const Index: Integer; const Value: TNotifyEvent);
      { TNotifyEvent }
    function GetButtonDisabledImages(Index: Integer): TCustomImageList;
    function GetButtonDownImages(Index: Integer): TCustomImageList;
    function GetButtonHotImages(Index: Integer): TCustomImageList;
    function GetButtonImageList(Index: Integer): TCustomImageList;
    function GetAlphaButtonDisabledImages(Index: Integer): TCustomImageList;
    function GetAlphaButtonDownImages(Index: Integer): TCustomImageList;
    function GetAlphaButtonHotImages(Index: Integer): TCustomImageList;
    function GetAlphaButtonImageList(Index: Integer): TCustomImageList;
    function GetButtonImageIndex(Index: Integer): TImageIndex;
    procedure SetButtonDisabledImages(const Index: Integer; const Value:
      TCustomImageList);
    procedure SetButtonDownImages(const Index: Integer; const Value:
      TCustomImageList);
    procedure SetButtonHotImages(const Index: Integer; const Value: TCustomImageList);
    procedure SetButtonImageList(const Index: Integer; const Value: TCustomImageList);
    procedure SetAlphaButtonDisabledImages(const Index: Integer; const Value:
      TCustomImageList);
    procedure SetAlphaButtonDownImages(const Index: Integer; const Value:
      TCustomImageList);
    procedure SetAlphaButtonHotImages(const Index: Integer; const Value: TCustomImageList);
    procedure SetAlphaButtonImageList(const Index: Integer; const Value: TCustomImageList);
    procedure SetButtonImageIndex(const Index: Integer; const Value:
      TImageIndex);
     {Calculator Button}
    {$ifndef NO_CALC_IN_CURREDIT}
    procedure SetCalcDlgModal(Value: Boolean);
    procedure SetCalcDlgButtonGlyphDefault(Value: Boolean);
    procedure CalcDlgButtonClick(Sender: TObject);
    procedure CalcDlgButtonGlyph_OnChanged(Sender: TObject);
    procedure CalcDlg_OnFormClose(Sender: TObject; var Action: TCloseAction);
    procedure CalcDlg_OnFormDestroy(Sender: TObject);
    procedure CalcDlg_OnDeactivate(Sender: TObject; var ModalResult: Integer);
    procedure CalcDlg_bCancelClick(Sender: TObject);
    procedure CalcDlg_bOKClick(Sender: TObject);
    function NeedStroredButtonGlyph(const Index: Integer): Boolean;
    procedure LoadCalcDlgButtonGlyphDefault;
    procedure CalcDlgFormShow(Sender: TObject);
    {$endif NO_CALC_IN_CURREDIT}
    { End of: Buttons Index Properties}
    procedure ButtonClickTransfer(Sender: TObject);
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure SetEnableSign(const Value: Boolean);
    function GetSignValue: Currency;
    procedure SetSign(const Value: Boolean);
    procedure SetSignValue(const Value: Currency);
    procedure SetAutoSelect(const Value: Boolean);
    function GetAutoSelect: Boolean;
    procedure SetNegativeSignColor(const Value: TColor);
    procedure SetNegativeValueTextColor(const Value: TColor);
    procedure SetupPartsFont;
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
    procedure OnEditorClick(Sender: TObject);
    procedure OnEditorDblClick(Sender: TObject);
    procedure OnEditorEndDrag(Sender: TObject; Target: TObject; X: Integer; Y:
      Integer);
    procedure OnEditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnEditorMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X: Integer; Y: Integer);
    procedure OnEditorMouseMove(Sender: TObject; Shift: TShiftState; X: Integer;
      Y: Integer);
    procedure OnEditorMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X: Integer; Y: Integer);
    procedure OnEditorStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure OnEditorKeyPress(Sender: TObject; var Key: Char);
    procedure OnEditorDragDrop(Sender: TObject; Source: TObject; X: Integer; Y:
      Integer);
    procedure OnEditorDragOver(Sender: TObject; Source: TObject; X: Integer; Y:
      Integer; State: TDragState; var Accept: Boolean);

    function StoreCurrencySymbol: Boolean;
    function StoreDecimalPlaces: Boolean;

    procedure SetAbsValue(const Value: Currency);
    procedure DrawFlatBorder(DC: HDC);

    procedure AdjustEditorPositions; virtual;

    procedure CMCtl3DChanged(var Msg: TMessage); message CM_CTL3DCHANGED;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message
      CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message
      CM_SYSCOLORCHANGE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure PaintBorder;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMWinIniChange(var Msg: TWMWinIniChange); message CM_WININICHANGE;

    procedure DoOnChange; dynamic;
    procedure DoMouseEnter; dynamic;
    procedure DoMouseLeave; dynamic;

    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure OnEditorChange(Sender: TObject);
    procedure OnEditorEnter(Sender: TObject);
    procedure OnEditorExit(Sender: TObject);
    procedure OnEditorPoint(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure OnEditorLeftPoint(Sender: TObject);
    procedure OnEditorKeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    function GetThemedElement: TThemedElement; override;
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    {$IFDEF LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$ENDIF}
    procedure SetUseDisabledColors(Value: Boolean);
    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure SetFocusedSelectColor(newValue: TColor);
    procedure SetFocusedSelectTextColor(newValue: TColor);
    procedure SetHideSelectColor(newValue: TColor);
    procedure SetHideSelectTextColor(newValue: TColor);
    function GetHideSelection: Boolean;
    procedure SetHideSelection(Value: Boolean);
    procedure SetHighlightAlphaLevel(Value: Integer);
    procedure UpdateLinkedControl;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetLinkedControlPosition(Value: TElLinkCtlPos);
    procedure SetLinkedControl(Value: TControl);
    procedure SetLinkedControlSpacing(Value: Integer);
    procedure SetDisabledColor(Value: TColor);
    procedure SetDisabledFontColor(Value: TColor);
    function GetButtonThinFrame(Index: Integer): Boolean;
    procedure SetButtonThinFrame(Index: Integer; Value: Boolean);
    function GetButtonOldStyled(Index: Integer): Boolean;
    procedure SetButtonOldStyled(Index: Integer; Value: Boolean);
    function GetButtonShowBorder(Index: Integer): Boolean;
    procedure SetButtonShowBorder(Index: Integer; Value: Boolean);
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
    procedure SetValidationMsgString(val : TLMDString);
    function GetValidationMsgString : TLMDString;
    function GetControl : TControl;
    function GetControlBackBrush : TBrush;
    function GetControlFont : TFont;
    function GetValueToValidate: TLMDString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Loaded; override;
    function SupportsDefaultIndication: boolean;
    property ControlFont : TFont read GetControlFont;
    property ControlBackBrush : TBrush read GetControlBackBrush;
    procedure RespondToError(ErrorLevel: TLMDErrorLevel);
    procedure SetValidator(Validator:TLMDValidationEntity);
    function GetValidator: TLMDValidationEntity;

    property MouseOver: boolean read FMouseOver;
    property Modified: boolean read FModified write SetModified;
    property AbsoluteValue: Currency read FAbsValue write SetAbsValue;

    property Buttons[Index:Integer]: TElGraphicButton read GetButton;
  published
{$IFDEF LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
{$ENDIF}
    property ValidationMsgString : TLMDString read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read FOnValidationError write FOnValidationError;
    property DisplayReadOnlyOptions: TElDisplayOptions read FDisplayReadOnlyOptions write SetDisplayReadOnlyOptions;
    property ValueUndefined: Boolean read FValueUndefined write SetValueUndefined default false;
    property UseThousandSeparator: Boolean read FUseThousandSeparator write SetUseThousandSeparator default false;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property AutoSelect: Boolean read GetAutoSelect write SetAutoSelect default
      True;
    property ButtonIsSwitch: boolean read GetButtonIsSwitch write SetButtonIsSwitch;
    property Value: Currency read GetSignValue write SetSignValue;
    property Sign: Boolean read FSign write SetSign stored false;
    property EnableSign: Boolean read FEnableSign write SetEnableSign default
      False;

    property NegativeSignColor: TColor read FNegativeSignColor write
      SetNegativeSignColor default clNone;
    property NegativeValueTextColor: TColor read FNegativeValueTextColor write
      SetNegativeValueTextColor default clNone;

    property DecimalPlaces: Byte read FDecimalPlaces write SetDecimalPlaces
      stored StoreDecimalPlaces;
    property UseSystemDecimalPlaces: Boolean read FUseSystemDecimalPlaces write
      SetUseSystemDecimalPlaces default True;

    property CurrencySymbol: TLMDString read FCurrencySymbol write
    SetCurrencySymbol stored StoreCurrencySymbol;
    property CurrencySymbolPosition: TElCurrencySymbolPosition read
      FCurrencySymbolPosition write SetCurrencySymbolPosition stored
      StoreCurrencySymbol default ecsPosRight;
    property UseSystemCurrencySymbol: Boolean read FUseSystemCurrencySymbol write
      SetUseSystemCurrencySymbol default False;

    property ButtonCaption: TLMDString index 0 read GetButtonCaption write
      SetButtonCaption;
    property ButtonColor: TColor index 0 read GetButtonColor write SetButtonColor
      default clBtnFace;
    property ButtonDown: Boolean index 0 read GetButtonDown write SetButtonDown
      default false;
    property ButtonEnabled: Boolean index 0 read GetButtonEnabled write
      SetButtonEnabled default true;
    property ButtonFlat: Boolean index 0 read GetButtonFlat write SetButtonFlat
      default false;
    property ButtonUseIcon: Boolean index 0 read GetButtonUseIcon write
      SetButtonUseIcon default false;
    property ButtonVisible: Boolean index 0 read GetButtonVisible write
      SetButtonVisible default false;
    property ButtonWidth: Integer index 0 read GetButtonWidth write
      SetButtonWidth default 15;
    property ButtonGlyph: TBitmap index 0 read GetButtonGlyph write
      SetButtonGlyph;
    property ButtonHint: TLMDString index 0 read GetButtonHint write SetButtonHint;
    property ButtonIcon: TIcon index 0 read GetButtonIcon write SetButtonIcon;
    property ButtonNumGlyphs: integer index 0 read GetButtonNumGlyphs write
      SetButtonNumGlyphs default 1;
    {$ifndef NO_CALC_IN_CURREDIT}
    property CalcDlgButtonCaption: TLMDString index 1 read GetButtonCaption write
      SetButtonCaption;
    property CalcDlgButtonColor: TColor index 1 read GetButtonColor write
      SetButtonColor default clBtnFace;
    property CalcDlgButtonEnabled: Boolean index 1 read GetButtonEnabled write
      SetButtonEnabled default true;
    property CalcDlgButtonUseIcon: Boolean index 1 read GetButtonUseIcon write
      SetButtonUseIcon default false;
    property CalcDlgButtonVisible: Boolean index 1 read GetButtonVisible write
      SetButtonVisible default false;
    property CalcDlgButtonWidth: Integer index 1 read GetButtonWidth write
      SetButtonWidth default 15;
    property CalcDlgButtonGlyph: TBitmap index 1 read GetButtonGlyph write
      SetButtonGlyph stored NeedStroredButtonGlyph;
    property CalcDlgButtonHint: TLMDString index 1 read GetButtonHint write
      SetButtonHint;
    property CalcDlgButtonIcon: TIcon index 1 read GetButtonIcon write
      SetButtonIcon;
    property CalcDlgButtonNumGlyphs: integer index 1 read GetButtonNumGlyphs
      write SetButtonNumGlyphs default 1;
    property CalcDlgButtonUseImageList: Boolean index 1 read
      GetButtonUseImageList write SetButtonUseImageList default false;
    property CalcDlgButtonImages: TCustomImageList index 1 read GetButtonImageList
      write SetButtonImageList;
    property CalcDlgButtonDownImages: TCustomImageList index 1 read GetButtonDownImages
      write SetButtonDownImages;
    property CalcDlgButtonHotImages: TCustomImageList index 1 read GetButtonHotImages
      write SetButtonHotImages;
    property CalcDlgButtonDisabledImages: TCustomImageList index 1 read
      GetButtonDisabledImages write SetButtonDisabledImages;
    property CalcDlgButtonAlphaForImages: TCustomImageList index 1 read GetAlphaButtonImageList
      write SetAlphaButtonImageList;
    property CalcDlgButtonAlphaForDownImages: TCustomImageList index 1 read GetAlphaButtonDownImages
      write SetAlphaButtonDownImages;
    property CalcDlgButtonAlphaForHotImages: TCustomImageList index 1 read GetAlphaButtonHotImages
      write SetAlphaButtonHotImages;
    property CalcDlgButtonAlphaForDisabledImages: TCustomImageList index 1 read
      GetAlphaButtonDisabledImages write SetAlphaButtonDisabledImages;
    property CalcDlgButtonImageIndex: TImageIndex index 1 read
      GetButtonImageIndex write SetButtonImageIndex;
    property CalcDlgOnButtonClick: TNotifyEvent read fCalcDlgOnButtonClick write
      fCalcDlgOnButtonClick;
    property CalcDlgButtonGlyphDefault: Boolean read fCalcDlgButtonGlyphDefault
      write SetCalcDlgButtonGlyphDefault default True;
    property CalcDlgModal: Boolean read fCalcDlgModal write SetCalcDlgModal
      default False;
    property CalcDlgMemoryButtonFont: TFont read fCalcDlgMemoryButtonFont write
      SetCalcDlgMemoryButtonFont;
    property CalcDlgDigitButtonFont: TFont read fCalcDlgDigitButtonFont write
      SetCalcDlgDigitButtonFont;
    property CalcDlgOperatorButtonFont: TFont read fCalcDlgOperatorButtonFont
      write SetCalcDlgOperatorButtonFont;
    property CalcDlgServiceButtonFont: TFont read fCalcDlgServiceButtonFont write
      SetCalcDlgServiceButtonFont;
    property CalcDlgCaption: TCaption read fCalcDlgCaption write
      fCalcDlgCaption;
    property CalcDlgOnError: TElMathErrorEvent read fCalcDlgOnError write
      fCalcDlgOnError;
    property CalcDlgOnShow: TNotifyEvent read fCalcDlgOnShow write
      fCalcDlgOnShow;
    property CalcDlgOnClose: TNotifyEvent read fCalcDlgOnClose write
      fCalcDlgOnClose;
    property CalcDlgOnDeactivate: TElCalcDeactivateEvent read
      fCalcDlgOnDeactivate write fCalcDlgOnDeactivate;
    property CalcDlgShowControlButtons: Boolean read fCalcDlgShowControlButtons
      write fCalcDlgShowControlButtons default true;
    property CalcDlgDefZeroValue: Boolean read fCalcDlgDefZeroValue write
      fCalcDlgDefZeroValue default True;
    property CalcDlgResetValue: Boolean read FCalcDlgResetValue write
      FCalcDlgResetValue default False;
    {$endif}
    property ButtonPopupPlace: TPopupPlace index 0 read GetButtonPopupPlace write
      SetButtonPopupPlace default ppDown;
    property ButtonPullDownMenu: TPopupMenu index 0 read GetButtonPullDownMenu
      write SetButtonPullDownMenu;
{     property CalcDlgButtonPullDownMenu : TPopupMenu index 1 read GetButtonPullDownMenu write SetButtonPullDownMenu;}
    property ButtonUseImageList: Boolean index 0 read GetButtonUseImageList write
      SetButtonUseImageList default false;
    property ButtonImages: TCustomImageList index 0 read GetButtonImageList write
      SetButtonImageList;
    property ButtonDownImages: TCustomImageList index 0 read GetButtonDownImages write
      SetButtonDownImages;
    property ButtonHotImages: TCustomImageList index 0 read GetButtonHotImages write
      SetButtonHotImages;
    property ButtonDisabledImages: TCustomImageList index 0 read
      GetButtonDisabledImages write SetButtonDisabledImages;
    property ButtonAlphaForImages: TCustomImageList index 0 read GetAlphaButtonImageList write
      SetAlphaButtonImageList;
    property ButtonAlphaForDownImages: TCustomImageList index 0 read GetAlphaButtonDownImages write
      SetAlphaButtonDownImages;
    property ButtonAlphaForHotImages: TCustomImageList index 0 read GetAlphaButtonHotImages write
      SetAlphaButtonHotImages;
    property ButtonAlphaForDisabledImages: TCustomImageList index 0 read
      GetAlphaButtonDisabledImages write SetAlphaButtonDisabledImages;
    property ButtonImageIndex: TImageIndex index 0 read GetButtonImageIndex write
      SetButtonImageIndex default -1;
    property OnButtonClick: TNotifyEvent index 0 read GetOnButtonClick write
      SetOnButtonClick;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle
      default bsSingle;
    property Flat: boolean read FFlat write SetFlat default false;
    property ActiveBorderType: TElFlatBorderType read FActiveBorderType write
      SetActiveBorderType default fbtSunken;
    property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write
      SetInactiveBorderType default fbtSunkenOuter;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides;
    property HandleDialogKeys: Boolean read FHandleDialogKeys write
      FHandleDialogKeys default False;
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
      SetLineBorderActiveColor;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
      SetLineBorderInactiveColor;
    property UseDisabledColors: Boolean read FUseDisabledColors write
      SetUseDisabledColors default false;
    property HideSelection: Boolean read GetHideSelection write SetHideSelection default True;
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
    property LinkedControlPosition: TElLinkCtlPos read FLinkedControlPosition write
        SetLinkedControlPosition default lcpTopLeft;
    property LinkedControl: TControl read FLinkedControl write SetLinkedControl;
    property LinkedControlSpacing: Integer read FLinkedControlSpacing write
        SetLinkedControlSpacing default 0;
    property DisabledColor: TColor read FDisabledColor write SetDisabledColor
        default clBtnFace;
    property DisabledFontColor: TColor read FDisabledFontColor write
        SetDisabledFontColor default clGrayText;
    property ButtonThinFrame: Boolean index 0 read GetButtonThinFrame write
        SetButtonThinFrame default false;
    property CalcDlgButtonFlat: Boolean index 1 read GetButtonFlat write
        SetButtonFlat default false;
    property CalcDlgButtonThinFrame: Boolean index 1 read GetButtonThinFrame write
        SetButtonThinFrame default false;
    property ButtonOldStyled: Boolean index 0 read GetButtonOldStyled write
        SetButtonOldStyled default false;
    property CalcDlgButtonOldStyled: Boolean index 1 read GetButtonOldStyled write
        SetButtonOldStyled default false;
    property ButtonShowBorder: Boolean index 0 read GetButtonShowBorder write
        SetButtonShowBorder default false;
    property CalcDlgButtonShowBorder: Boolean index 1 read GetButtonShowBorder
        write SetButtonShowBorder default false;
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace
        default clBtnFace;
    property BorderColorHighlight: TColor read FBorderColorHighlight write
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorShadow: TColor read FBorderColorShadow write
        SetBorderColorShadow default clBtnShadow;
    property BorderColorWindow: TColor read FBorderColorWindow write
        SetBorderColorWindow default clWindow;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;

    property Anchors;

    property Color;

    property Constraints;

    property Ctl3D;
    property DragCursor;

    property DragKind;

    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default false;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default true;
    property Visible;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;

    property OnClick;

    property OnContextPopup;

    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;

    property OnEndDock;
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

    property OnStartDrag;
    property CalcDlgButtonShortcut: TShortcut read FCalcDlgButtonShortcut write
        FCalcDlgButtonShortcut default 32808;
    property ButtonShortCut: TShortCut read FButtonShortCut write FButtonShortCut;
  end;

implementation

uses
  LMDSysIn, UxTheme;

const
  SSignStr = string(' -');

type
  THackWinControl = class(TWinControl)
  end;

type
  THackEdit = class(TElEdit);

  TElCurrEditButton = class(TElGraphicButton)
  protected
    procedure DrawThemedBackground(Canvas: TCanvas); override;
  end;

{
********************************** TElCurrPartEdit ***********************************
}
function TElCurrPartEdit.GetTextColor: TColor;
var
  LOwner: TElCurrencyEdit;
begin
  LOwner := Owner as TElCurrencyEdit;
  if (LOwner.NegativeValueTextColor <> clNone) and LOwner.Sign then
    Result := LOwner.NegativeValueTextColor
  else
    Result := inherited GetTextColor();
end;

procedure TElCurrPartEdit.WMNCPaint(var Msg: TWMNCPaint);
begin
  Msg.Result := 0;
end;

procedure TElCurrPartEdit.WMChar(var Message: TWMChar);
begin
  if (TWMChar(Message).CharCode = Ord({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator))
  or (TWMChar(Message).CharCode = Ord('.'))
    or (TWMChar(Message).CharCode = Ord(',')) then
    if Assigned(OnPoint) then
    begin
      OnPoint(Self);
    end
    else
  else
  begin
    if FIsIntegerPart then
    begin
      if
        (TWMChar(Message).CharCode = Ord('-'))
        and Assigned(Parent) and (Parent is TElCurrencyEdit)
        and TElCurrencyEdit(Parent).EnableSign then
      begin
        TElCurrencyEdit(Parent).Sign := not TElCurrencyEdit(Parent).Sign;
        TElCurrencyEdit(Parent).SetModified(True);
        Message.Result := 0;
        Exit;
      end;
    end
    else
    begin
      if (SelStart = Length(Text)) and (SelLength=0) then
      begin
        if (TWMChar(Message).CharCode in [Ord('0')..Ord('9')]) and TElCurrencyEdit(Parent).FValueUndefined then
          text := '00'
        else
        begin
          TWMChar(Message).CharCode := 0;
          exit;
        end;
      end;
    end;
    if not (TWMChar(Message).CharCode in [Ord('0')..Ord('9')]) then
      TWMChar(Message).CharCode := 0;
    inherited;
  end;
end;

procedure TElCurrPartEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if TElCurrencyEdit(Parent).HandleDialogKeys then
    Message.Result := Message.Result or DLGC_WANTALLKEYS;
  Message.Result := Message.Result and not DLGC_WANTCHARS;
end;

procedure TElCurrPartEdit.WMKeyDown(var Message: TWMKeyDown);
{$IFNDEF LMDCOMP9}
  function ShortCutFromMessage(Message: TWMKey): TShortCut;
  const
    AltMask = $20000000;
  begin
    Result := Byte(Message.CharCode);
    if Result = 0 then
      Exit;
    if GetKeyState(VK_SHIFT) < 0 then Inc(Result, scShift);
    if GetKeyState(VK_CONTROL) < 0 then Inc(Result, scCtrl);
    if Message.KeyData and AltMask <> 0 then Inc(Result, scAlt);
  end;

{$ENDIF}
  procedure CheckKey;
  var
    SC: TShortCut;
    LCtrlV: TShortCut;
  begin
    if FSaveAlpha then
      FSKey := Message.CharCode
    else
      FSKey := 0;

    LCtrlV := 86;
    Inc(LCtrlV, scCtrl);

    SC := ShortCutFromMessage(Message);
    if not ((Message.CharCode in [Ord('0')..Ord('9'), Ord('-'), VK_SUBTRACT, VK_NUMPAD0..VK_NUMPAD9,
      VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN, VK_TAB, VK_HOME, VK_END, VK_DELETE, VK_BACK{, VK_ESCAPE}])
      or (SC = TElCurrencyEdit(Owner).CalcDlgButtonShortcut)
      or (SC = TElCurrencyEdit(Owner).ButtonShortCut)
      or (SC = LCtrlV))
    then
      Message.CharCode := 0;
  end;

begin
  if (Message.CharCode = VK_LEFT) and (KeyDataToShiftState(Message.KeyData) = [])
    then
  begin
    if (SelStart = 0) then
    begin
      if Assigned(OnLeftPoint) then
        OnLeftPoint(Self);
    end
    else
    begin
      CheckKey;
      inherited;
    end;
  end
  else
    if (Message.CharCode = VK_RIGHT) and
    (KeyDataToShiftState(Message.KeyData) = []) then
  begin
    if (SelStart = Length(Text)) then
    begin
      if Assigned(OnPoint) then
        OnPoint(Self)
    end
    else
    begin
      CheckKey;
      inherited;
    end;
  end
  else
  if (Message.CharCode = VK_DELETE) then
  begin
    if FIsIntegerPart and (Text='0') then
    begin
      Message.CharCode := 0;
      exit;
    end
    else
    inherited;
  end
  else
  if (Message.CharCode =  VK_BACK) then
  begin
    if (not FIsIntegerPart) and (SelStart = 0) then
    begin
      TElCurrencyEdit(Parent).FPartEditors[1].AutoSelect := False;
      TElCurrencyEdit(Parent).FPartEditors[1].SetFocus;
      TElCurrencyEdit(Parent).FPartEditors[1].AutoSelect := True;
      TElCurrencyEdit(Parent).FPartEditors[1].SelStart :=
        Length(TElCurrencyEdit(Parent).FPartEditors[1].Text);
      Message.CharCode := 0;
      exit;
    end;
    if FIsIntegerPart and (Length(Text)=1) and (SelStart=1) then
    begin
      if Text <> '0' then
      begin
        Text := '0';
        SelStart := 1;
        Change;
      end;
      Message.CharCode := 0;
      exit;
    end;
    inherited;
  end
  else
  if (Message.CharCode in [Ord('0')..Ord('9')]) then
  begin
    if FIsIntegerPart and (Length(Text)=1) and (SelStart = 1) and (Text = '0') then
      Text := '';
    inherited;
  end
  else
  begin
    CheckKey;
    inherited;
  end;
end;

procedure TElCurrPartEdit.CreateParams(var Params: TCreateParams);
begin
  FBorderStyle := bsNone;
  FTransparent := True;
  inherited;
end;

procedure TElCurrPartEdit.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) or
    ES_NUMBER);
end;

procedure TElCurrPartEdit.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  with Parent as TElCurrencyEdit do
    if HandleAllocated and (FFlat or IsThemed) then
      DrawFlatBorder(0);
end;

procedure TElCurrPartEdit.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  with Parent as TElCurrencyEdit do
    if FFlat or IsThemed then
      DrawFlatBorder(0);
end;

procedure TElCurrPartEdit.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
//  if LMDSIWindowsVistaUp then
//    Dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[ctl3d]));
//  Dec(Message.CalcSize_Params.rgrc[0].Top, Trunc(GetSystemMetrics(smYEdge[ctl3d]) / 2));
end;
{
********************************** TElCurrencyEdit ***********************************
}

procedure TElCurrencyEdit.SetAbsValue(const Value: Currency);
begin
  if Value >= 0.0 then
  begin
    if (FAbsValue <> Value) or (Value = 0) then
    begin
      FAbsValue := Value;
      UpdateParts;
    end;
  end;
end;

procedure TElCurrencyEdit.UpdateParts;
var
  LValue: Extended;

function SimpleRoundTo(const AValue: Double; const ADigit: TRoundToRange = -2): Double;
var
  LFactor: Double;
begin
  LFactor := IntPower(10, ADigit);
  Result := Trunc((AValue / LFactor) + 0.5) * LFactor;
end;

begin
  if FValueUndefined then
  begin
    FPartEditors[1].Text := '';
    FPartEditors[2].Text := '';
  end
  else
  begin
    if FUseThousandSeparator then
      FPartEditors[1].Text := FloatToStrF(Trunc(SimpleRoundTo(FAbsValue, -DecimalPlaces)),ffNumber,18,0)
    else
    begin
      LValue := SimpleRoundTo(FAbsValue, -DecimalPlaces);
      FPartEditors[1].Text := IntToStr(Trunc(LValue));
    end;
    FPartEditors[2].Text := FracValue(FAbsValue);
  end;
  UpdatePartsWidth;
end;

constructor TElCurrencyEdit.Create(AOwner: TComponent);
var
  I: Integer;
begin
  BeginCreate;
  inherited Create(AOwner);
  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];

  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;

  FBorderStyle := bsSingle;
  FDecimalPlaces := {$IFDEF LMDCOMP17}FormatSettings.{$ELSE}SysUtils.{$ENDIF}CurrencyDecimals;
  FUseSystemDecimalPlaces := True;
  FCurrencySymbol := '';
  FCurrencySymbolPosition := ecsPosRight;
  FUseSystemCurrencySymbol := False;
  FEnableSign := False;
  FSign := False;
  FNegativeValueTextColor := clNone;
  FNegativeSignColor := clNone;

  FDisplayReadOnlyOptions := TElDisplayOptions.Create;
  FDisplayReadOnlyOptions.OnChange := DisplayOptionsChange;

  for i := 1 to 2 do
  begin
    FPartEditors[i] := IntEditClass.Create(Self);

    with FPartEditors[i] do
    begin
      Parent := Self;
      ReadOnly := False;
      BorderStyle := bsNone;
      OnChange := OnEditorChange;
      OnExit := OnEditorExit;
      OnPoint := OnEditorPoint;
      OnLeftPoint := OnEditorLeftPoint;
      OnKeyDown := OnEditorKeyDown;
      OnKeyPress := OnEditorKeyPress;
      OnKeyUp := OnEditorKeyUp;
      OnStartDrag := OnEditorStartDrag;
      OnEndDrag := OnEditorEndDrag;
      OnDragOver := OnEditorDragOver;
      OnDragDrop := OnEditorDragDrop;
      OnMouseDown := OnEditorMouseDown;
      OnMouseMove := OnEditorMouseMove;
      OnMouseUp := OnEditorMouseUp;
      OnClick := OnEditorClick;
      OnDblClick := OnEditorDblClick;

      LeftMargin := 0;
      if i = 1 then
        RightMargin := 0
      else
        RightMargin := 2;
      AutoSelect := True;
      AutoSize := false;
      if i = 1 then
        Text := '0'
      else
        Text := '00';
      ParentColor := False;
      Color := Self.Color;
      ParentFont := False;
      Font := Self.Font;
      TabStop := false;
      FSKey := 0;
      FSaveAlpha := false;
      //RightMargin := 0;
    end;
  end;
  FPartEditors[1].Alignment := taRightJustify;
  FPartEditors[2].Alignment := taLeftJustify;
  FPartEditors[2].MaxLength := 0;
  FPartEditors[1].FIsIntegerPart := true;

  FInactiveBorderType := fbtSunkenOuter;
  FActiveBorderType := fbtSunken;

  TabStop := true;
  Width := 100;
  Height := 21;
  ParentColor := false;
  Color := clWindow;
  HighlightAlphaLevel := 255;
  FLinkedControlPosition := lcpTopLeft;
  FDisabledColor := clBtnFace;
  FDisabledFontColor := clGrayText;

  for i := CURRBTNMIN to CURRBTNMAX do
  begin
    FButtons[i] := TElCurrEditButton.Create(nil);
    with FButtons[i] do
    begin
      AdjustSpaceForGlyph := false;
      ParentColor := false;
      Color := clBtnFace;
      Parent := Self;
      OnClick := ButtonClickTransfer;
      Width := GetSystemMetrics(SM_CXVSCROLL);
      Flat := false;
      Visible := false;
      if csDesigning in ComponentState then
        Enabled := false;
    end;
  end;

  CalcDlgButtonShortcut := Shortcut(VK_DOWN, [ssAlt]);

  FHideSelection := true;
  FFocusedSelectColor := clHighlight;
  FFocusedSelectTextColor := clHighlightText;
  FHideSelectColor := clBtnFace;
  FHideSelectTextColor := LMDElHideSelectTextColor;

  {$ifndef NO_CALC_IN_CURREDIT}
  {Calculator Properties:}
  fCalcDlgDigitButtonFont := TFont.Create;
  fCalcDlgMemoryButtonFont := TFont.Create;
  fCalcDlgOperatorButtonFont := TFont.Create;
  fCalcDlgServiceButtonFont := TFont.Create;
  fCalcDlgShowControlButtons := True;
  fButtons[1].OnClick := CalcDlgButtonClick;

  fCalcDlgButtonGlyphOnChange := CalcDlgButtonGlyph.OnChange;
  CalcDlgButtonGlyph.OnChange := CalcDlgButtonGlyph_OnChanged;
  fCalcDlgButtonGlyphDefault  := True;
  CalcDlgDefZeroValue         := True;
  FCalcDlgResetValue := False;
  {$endif}
  FIgnoreReadOnlyState := false;
  EndCreate;
end;

destructor TElCurrencyEdit.Destroy;
var
  I: Integer;
begin
  for I := CURRBTNMIN to CURRBTNMAX do
  begin
    FButtons[I].Free;
  end;
  {$ifndef NO_CALC_IN_CURREDIT}
  FreeAndNil(fCalcDlgDigitButtonFont);
  FreeAndNil(fCalcDlgMemoryButtonFont);
  FreeAndNil(fCalcDlgOperatorButtonFont);
  FreeAndNil(fCalcDlgServiceButtonFont);
  {$endif}
  FreeAndNil(FDisplayReadOnlyOptions);
  inherited Destroy;
end;

procedure TElCurrencyEdit.DrawFlatBorder(DC: HDC);
var
  BorderType: TElFlatBorderType;
  MustRelease: boolean;
  R,
    R1: TRect;
  b: boolean;
  ax, ay: integer;
  AColor: TColor;
  LDetail: TThemedEdit;
  LDetails: TThemedElementDetails;
  LUseThemeMode: TLMDThemeMode;
begin
  LUseThemeMode := UseThemeMode;
  if ((not FFlat) and (LUseThemeMode = ttmNone)) or (BorderStyle = bsNone) then
    exit;

  MustRelease := (DC = 0);
  if MustRelease then DC := GetWindowDC(Handle);
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);

  try
    if (LUseThemeMode <> ttmNone) then
    begin
      LDetail := teEditTextNormal;
      if not Enabled then
      begin
        LDetail := teEditTextDisabled;
      end;
      R1 := ClientRect;
      R1.TopLeft := Parent.ScreenToClient(ClientToScreen(R1.TopLeft));

      ax := Left - R1.Left;
      ay := Top - R1.Top;

      R1 := ClientRect;
      OffsetRect(R1, -ax, -ay);

      with R1 do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);

    if LMDSIWindowsVistaUp then
    begin
      LDetails.Element := teEdit;
      LDetails.Part := EP_EDITBORDER_NOSCROLL;
      LDetails.State := ETS_NORMAL;
      if not Enabled then
        LDetails.State := ETS_DISABLED
      else
      if Focused or FPartEditors[1].Focused or FPartEditors[2].Focused then
        LDetails.State := ETS_SELECTED
      else
      if FMouseOver or FPartEditors[1].MouseOver or FPartEditors[2].MouseOver then
        LDetails.State := ETS_HOT;
      LMDThemeServices.DrawElement(UseThemeMode, DC, LDetails, R);
    end
    else
      LMDThemeServices.DrawElement(UseThemeMode, DC, LDetail, R);

    end
    else
    begin
      b := Focused or (GetParent(GetFocus) = Handle) or FMouseOver;
      if b then
        BorderType := FActiveBorderType
      else
        BorderType := FInactiveBorderType;
      if b then
        AColor := LineBorderActiveColor
      else
        AColor := LineBorderInactiveColor;

      DrawFlatFrameEx2(DC, R, AColor, Color, b, Enabled, FBorderSides,
        BorderType, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
    end;
  finally
    if MustRelease then
      ReleaseDC(Handle, DC);
  end;
end;

procedure TElCurrencyEdit.Paint;
var
  cx: integer;
  s: string;
  eh: integer;
  R: TRect;
  ay: Integer;
  LDetail: TThemedEdit;
  LAddVistaVert: Integer;
  LUseThemeMode: TLMDThemeMode;
  function GetEditorHeight: integer;
  var //I : integer;
    DC: HDC;
    SysMetrics,
      Metrics: TLMDTextMetric;
    SaveFont: HFont;
  begin
    DC := GetDC(0);
    LMDGetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    LMDGetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
    ReleaseDC(0, DC);
      //I := GetSystemMetrics(SM_CYEDGE) * 2;
    result := Metrics.tmHeight { + I};
  end;

begin
  LUseThemeMode := UseThemeMode;
  LAddVistaVert := 0;
  if LMDSIWindowsVistaUp then
    LAddVistaVert := GetSystemMetrics(smYEdge[ctl3d]);
  if FFlat and not IsThemed then
    DrawFlatBorder(Canvas.Handle);

  Canvas.Brush.Color := GetBkColor;

  if (not LMDApplication.ThemeUseColorProperty) and (LUseThemeMode <> ttmNone) then
  begin
    R := Rect(0, 0, Width, Height);
    ay := abs(R.Bottom - ClientRect.Bottom);
    OffsetRect(R, -ay, -ay);
    InflateRect(R, ay, ay);
    if (ReadOnly and (not FIgnoreReadOnlyState)) then
      LDetail := teEditTextReadOnly
    else
    if not Enabled then
      LDetail := teEditTextDisabled
    else
      LDetail := teEditTextNormal;
    LMDThemeServices.DrawElement(UseThemeMode, Canvas.Handle, LDetail, R);
  end
  else
    Canvas.FillRect(ClientRect);
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(Font);

  Canvas.Font.Color := GetTextColor;

  eh := FPartEditors[1].FLineHeight + FPartEditors[1].TopMargin;
  SetTextAlign(Canvas.Handle, TA_BASELINE or TA_NOUPDATECP or TA_LEFT);

  if DecimalPlaces > 0 then
  begin
    cx := ClientWidth;
    Dec(cx, FBWidth + FDWidth + FDSWidth);
    if CurrencySymbolPosition = ecsPosRight then
    begin
      Dec(cx, FSWidth);
    end;
    S := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator;
    TextOut(Canvas.Handle, cx - 1, eh + LAddVistaVert, PChar(S), Length(S));
  end;

  if CurrencySymbol <> '' then
  begin
    if CurrencySymbolPosition = ecsPosLeft then
    begin
      cx := FSignWidth;
    end
    else
    begin
      cx := ClientWidth - FSWidth - FBWidth;
    end;
    S := CurrencySymbol;
    TextOut(Canvas.Handle, cx, eh + Trunc(LAddVistaVert / 2), PChar(S), Length(S));
  end;

  if Sign then
  begin
    S := SSignStr;
    Canvas.Font.Color := GetTextColor;
    TextOut(Canvas.Handle, 0, eh, PChar(S), Length(S));
  end;
  // SetTextAlign(Canvas.Handle, TA_BOTTOM);

  PaintBorder();
end;

procedure TElCurrencyEdit.AdjustEditorPositions;
var
  x: integer;
  h: integer;
  I: Integer;
  w: Integer;
  le: Integer;

begin
  x := ClientWidth;
  h := ClientHeight;

  FBWidth := 0;
  for I := CURRBTNMAX downto CURRBTNMIN do
  begin
    if FButtons[I].Visible then
    begin
      w := FButtons[I].Width;
      FButtons[I].BoundsRect := Rect(x - w, 0, x, h);
      Dec(x, w);
      Inc(FBWidth, w);
    end;
  end;
  le := FSignWidth;
  if CurrencySymbolPosition = ecsPosLeft then
  begin
    Inc(le, FSWidth);
  end
  else
  begin
    Dec(x, FSWidth);
  end;
  Dec(x, FDWidth);
  FPartEditors[1].BoundsRect := Rect(le, 0, x - FDSWidth, h);
  FPartEditors[2].BoundsRect := Rect(x, 0, x + FDWidth, h);
  for i := 1 to 2 do
  begin
    FPartEditors[i].AlignBottom := true;
    //FPartEditors[i].TopMargin := (ClientHeight - Abs(Font.Height)) div 2;
  end;

  Invalidate;
end;

procedure TElCurrencyEdit.CMColorChanged(var Message: TMessage);
var
  i: integer;
begin
  inherited;
  for i := 1 to 2 do
    FPartEditors[i].Color := Color;
end;

procedure TElCurrencyEdit.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := True;
  if FFlat and (not Focused) and (not IsThemed) then
    DrawFlatBorder(0);
  DoMouseEnter;
end;

procedure TElCurrencyEdit.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
//  if (Msg.LParam = 0) or (Msg.LParam = TLMDPtrInt(Self)) then
  begin
    FMouseOver := False;
    if FFlat and (not Focused) and (not IsThemed) then
      DrawFlatBorder(0);
    DoMouseLeave;
  end;
end;

procedure TElCurrencyEdit.CMEnabledChanged(var Message: TMessage);
var
  i: integer;
begin
  inherited;
  for i := 1 to 2 do
    FPartEditors[i].Enabled := Enabled;
  Invalidate;
  UpdateFrame;
end;

procedure TElCurrencyEdit.CMFontChanged(var Message: TMessage);
begin
  inherited;
  SetupPartsFont;
  UpdatePartsWidth;
  // AdjustEditorPositions;
  UpdateFrame;
end;

procedure TElCurrencyEdit.CMSysColorChange(var Message: TMessage);
var
  i: integer;
begin
  inherited;
  for i := 1 to 2 do
    FPartEditors[i].Color := Color;
  Invalidate;
  UpdateFrame;
end;

procedure TElCurrencyEdit.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
var R : TRect;
    Br: HBRUSH;
begin
  R := Rect(FPartEditors[2].Left + FPartEditors[2].Width, 0, ClientWidth, ClientHeight);
  BR := CreateSolidBrush(ColorToRGB(Color));
  FillRect(Msg.DC, R, BR);
  DeleteObject(BR);
  Msg.result := 1;
end;

procedure TElCurrencyEdit.PaintBorder();
var
  DC: HDC;
begin
  if not Flat and (BorderStyle = bsSingle) then
    inherited;
  if Flat or IsThemed then
  begin
    //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    //if DC = 0 then
    begin
      DC := GetWindowDC(Handle);
    end;
    DrawFlatBorder(DC);
    ReleaseDC(Handle, DC);
  end;
end;

procedure TElCurrencyEdit.WMSetFocus(var Msg: TWMSetFocus);
var
  R    :TWinControl;
  Part :Integer;
begin
  inherited;
  R := FindControl(Msg.FocusedWnd);
  if R <> nil then
  begin
    Part := FindPart(IntEditClass(R));
    if Part < 1 then
      Part := 1
    else
    begin
      THackWinControl(Parent).SelectNext(Self, false, true);
      exit;
    end;
  end
  else
    Part := 1;
  FPartEditors[Part].SelectAll;
  FPartEditors[Part].SetFocus;
  if FFlat and not FMouseOver then
    DrawFlatBorder(0);
end;

procedure TElCurrencyEdit.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if not HandleAllocated then exit;
  if FFlat and not FMouseOver then
    DrawFlatBorder(0);
end;

procedure TElCurrencyEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  AdjustEditorPositions;
  if IsThemed or (Flat and (BorderStyle <> bsNone)) then
    DrawFlatBorder(0);
end;

procedure TElCurrencyEdit.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if not (csLoading in ComponentState) then
    UpdatePartsWidth;
end;

function TElCurrencyEdit.FindPart(Editor: IntEditClass): integer;
begin
  result := -1;
  if Editor = FPartEditors[1] then
    result := 1
  else
    if Editor = FPartEditors[2] then
    result := 2;
end;

procedure TElCurrencyEdit.OnEditorChange(Sender: TObject);
var
  i, j, l: integer;
  p: integer;
  s: string;
  cp: TPoint;
  LTemp: Currency;
begin
  p := FindPart(IntEditClass(Sender));
  cp := THackEdit(Sender).GetCaretXY;
  S := IntEditClass(Sender).Text;
  l := length(s);
  if FValueUndefined and (l > 0) then
  begin
    FValueUndefined := false;
    UpdateParts;
  end;
  while pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator,s) > 0 do
  begin
    i := pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator,s);
    s := copy(s,0,i-1)+copy(s,i+1,length(s)-1);
  end;

  if p = 1 then
  begin
    if S='' then
    begin
      FPartEditors[1].Text := '0';
      S := '0';
    end;
    Val(S, i, j);
    if (j = 0) then
    begin
      FAbsValue := i + FAbsValue - Trunc(FAbsValue);
      if FUseThousandSeparator then
        FPartEditors[1].Text := FloatToStrF(Trunc(FAbsValue),ffNumber,18,0)
      else
        FPartEditors[1].Text := IntToStr(Trunc(FAbsValue));
      SetModified(true);
      if abs(length(FPartEditors[1].Text) - l) = 1 then
        cp.X := cp.X + length(FPartEditors[1].Text) - l;
      THackEdit(Sender).SetCaretXY(cp);
      exit;
    end
    else
    begin
      if S[j] = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator then
      begin
        S := Copy(S, 1, Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, S) + DecimalPlaces);
        if TryStrToCurr(s, LTemp) then
        begin
          FAbsValue := LTemp;
          if FUseThousandSeparator then
            FPartEditors[1].Text := FloatToStrF(Trunc(FAbsValue),ffNumber,18,0)
          else
            FPartEditors[1].Text := IntToStr(Trunc(FAbsValue));
          FPartEditors[2].Text := FracValue(LTemp);
          SetModified(true);
          if abs(length(FPartEditors[1].Text) - l) = 1 then
            cp.X := cp.X + length(FPartEditors[1].Text) - l;
          THackEdit(Sender).SetCaretXY(cp);
          exit;
        end;
      end;
    end;
    if Length(s) > 0 then
    begin
      if IntEditClass(Sender).HandleAllocated then
        i := IntEditClass(Sender).SelStart
      else
        i := 0;
      if FUseThousandSeparator then
        FPartEditors[1].Text := FloatToStrF(Trunc(FAbsValue), ffNumber, 18, 0)
      else
        FPartEditors[1].Text := IntToStr(Trunc(FAbsValue));
      if IntEditClass(Sender).HandleAllocated then
        IntEditClass(Sender).SelStart := Min(i,
          Length(IntEditClass(Sender).Text));
    end;
  end
  else
  begin
    if Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, S) = 0 then
    begin
      S := '0' + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator + Copy(S, 1, DecimalPlaces);
      FAbsValue := StrToCurr(S) + Trunc(FAbsValue);
      UpdatePartsWidth;
      SetModified(true);

      if Length(S) > 0 then
      begin
        if IntEditClass(Sender).HandleAllocated then
          i := IntEditClass(Sender).SelStart
        else
          i := 0;
        FPartEditors[2].Text := FracValue(FAbsValue);
        UpdatePartsWidth;
        if IntEditClass(Sender).HandleAllocated then
          IntEditClass(Sender).SelStart := Min(i,
            Length(IntEditClass(Sender).Text));
      end;
    end
    else
    begin
      S := Copy(S, 1, Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, S) + DecimalPlaces);
      if TryStrToCurr(s, LTemp) then
      begin
        FAbsValue := LTemp;
        if FUseThousandSeparator then
          FPartEditors[1].Text := FloatToStrF(Trunc(FAbsValue),ffNumber,18,0)
        else
          FPartEditors[1].Text := IntToStr(Trunc(FAbsValue));
        FPartEditors[2].Text := FracValue(LTemp);
        SetModified(true);
        if abs(length(FPartEditors[2].Text) - l) = 1 then
          cp.X := cp.X + length(FPartEditors[2].Text) - l;
        THackEdit(FPartEditors[2]).SetCaretXY(cp);
        exit;
      end;
    end;
  end;
end;

procedure TElCurrencyEdit.OnEditorEnter(Sender: TObject);
begin
//  IntEditClass(Sender).SelStart := 0;
//  IntEditClass(Sender).SelLength := 0;
end;

procedure TElCurrencyEdit.OnEditorExit(Sender: TObject);
begin
  IntEditClass(Sender).SelLength := 0;
  if (IntEditClass(Sender).Text = '') and not ValueUndefined then
  begin
    if Sender = FPartEditors[1] then
    begin
      if FUseThousandSeparator then
        FPartEditors[1].Text := FloatToStrF(Trunc(FAbsValue),ffNumber,18,0)
      else
        FPartEditors[1].Text := IntToStr(Trunc(FAbsValue));
    end
    else
      if Sender = FPartEditors[2] then
      if FAbsValue - Trunc(FAbsValue) = 0 then
        FPartEditors[2].Text := '0'
      else
        FPartEditors[2].Text := FracValue(FAbsValue);
    OnEditorChange(Sender);
  end;
  if (GetFocus <> FPartEditors[1].Handle) and (GetFocus <> FPartEditors[2].Handle) then
    DoExit;
end;

procedure TElCurrencyEdit.OnEditorKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  KeyDown(Key, Shift);
end;

procedure TElCurrencyEdit.OnEditorPoint(Sender: TObject);
begin
  if Sender = FPartEditors[1] then
  begin
    FPartEditors[2].AutoSelect := False;
    FPartEditors[2].CaretX := 0;
    FPartEditors[2].SetFocus;
    FPartEditors[1].SelStart := 0;
    FPartEditors[2].AutoSelect := True;
  end;
end;

procedure TElCurrencyEdit.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
  {$ifndef NO_CALC_IN_CURREDIT}
  if fCalcDlgButtonGlyphDefault and CalcDlgButtonGlyph.Empty then
    LoadCalcDlgButtonGlyphDefault;
  {$endif}
end;

procedure TElCurrencyEdit.SetInactiveBorderType(const Value: TElFlatBorderType);
begin
  if FInactiveBorderType <> Value then
  begin
    FInactiveBorderType := Value;
    if (not Focused) and (not FMouseOver) then
      UpdateFrame;
  end;
end;

procedure TElCurrencyEdit.SetActiveBorderType(const Value: TElFlatBorderType);
begin
  if FActiveBorderType <> Value then
  begin
    FActiveBorderType := Value;
    if (Focused or FMouseOver) then
      UpdateFrame;
  end;
end;

procedure TElCurrencyEdit.SetFlat(const Value: boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    if HandleAllocated then
      if Flat then
        Invalidate
      else
        RecreateWnd;
  end;
end;

procedure TElCurrencyEdit.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TElCurrencyEdit.SetModified(Value: boolean);
begin
  FModified := Value;
  if FModified then
    DoOnChange;
end;

procedure TElCurrencyEdit.DoMouseEnter;
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TElCurrencyEdit.DoMouseLeave;
begin
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

procedure TElCurrencyEdit.UpdateFrame;
var
  R: TRect;
begin
  if Flat and HandleAllocated then
  begin
    R := Rect(0, 0, Width, Height);
    if (BorderStyle = bsSingle) and (not (csDestroying in ComponentState)) and
      (HandleAllocated) then
      RedrawWindow(Handle, @R, 0, rdw_Invalidate or rdw_UpdateNow or rdw_Frame);
  end;
end;

procedure TElCurrencyEdit.OnEditorLeftPoint(Sender: TObject);
begin
  if (Sender = FPartEditors[2]) then
  begin
    FPartEditors[1].AutoSelect := False;
    FPartEditors[1].SetFocus;
    FPartEditors[1].SelStart := Length(FPartEditors[1].Text);
    FPartEditors[1].AutoSelect := True;
  end;
end;

procedure TElCurrencyEdit.UpdatePartsWidth;
var
  S: AnsiString;
  IC: Char;
  CW: Integer;
begin
  if HandleAllocated then
  begin
    Canvas.Font.Assign(Font);

    // calculate sign symbol width in pixels
    if EnableSign then
      FSignWidth := Canvas.TextWidth(SSignStr)
    else
      FSignWidth := 0;

    // calculate decimal separator width in pixels
    FDSWidth := Canvas.TextWidth({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator);

    // calculate fractional part editor width in pixels
    FDWidth := 0;
    if DecimalPlaces > 0 then
    begin
      SetLength(S, DecimalPlaces);
      for IC := '0' to '9' do
      begin
        FillChar(S[1], DecimalPlaces, IC);
        CW := Canvas.TextWidth(String(S));
        if CW > FDWidth then
        begin
          FDWidth := CW;
        end;
      end;
      // caret space
      Inc(FDWidth, FPartEditors[2].LeftMargin + FPartEditors[2].RightMargin);
    end;

    // calculate currency symbol width in pixels
    if CurrencySymbol <> '' then
      FSWidth := Canvas.TextWidth(CurrencySymbol)
    else
      FSWidth := 0;
    // adjust editor parts placement
    AdjustEditorPositions;
  end;
end;

procedure TElCurrencyEdit.Loaded;
begin
  inherited;
  if FSign then
  begin
    FSign := false;
    SetSign(true);
  end;
  SetupPartsFont;
  UpdatePartsWidth;
//  DisplayOptionsChange(Self);
  UpdateLinkedControl;
  Perform(CM_SHOWINGCHANGED, 0, 0);
end;

function TElCurrencyEdit.FracValue(AValue: Currency): string;
var
  IPos: Integer;
begin
  Result := CurrToStrF(AValue, ffFixed, DecimalPlaces);
  IPos := Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, Result);
  if IPos > 0 then
    Result := Copy(Result, Succ(IPos), Length(Result))
  else
    Result := '';
  while Length(Result) < DecimalPlaces do
    Result := Result + '0';
end;

procedure TElCurrencyEdit.SetDecimalPlaces(const Value: Byte);
begin
  if FDecimalPlaces <> Value then
  begin
    FDecimalPlaces := Value;
    FUseSystemDecimalPlaces := False;
    UpdateParts;
  end;
end;

procedure TElCurrencyEdit.SetUseSystemDecimalPlaces(const Value: Boolean);
begin
  if FUseSystemDecimalPlaces <> Value then
  begin
    if Value then
    begin
      DecimalPlaces := {$IFDEF LMDCOMP17}FormatSettings.{$ELSE}SysUtils.{$ENDIF}CurrencyDecimals;
    end;
    FUseSystemDecimalPlaces := Value;
  end;
end;

function TElCurrencyEdit.StoreDecimalPlaces: Boolean;
begin
  Result := not FUseSystemDecimalPlaces;
end;

procedure TElCurrencyEdit.DoOnChange;
begin
  if Assigned(FOnChange) then
  begin
    FOnChange(Self);
  end;
  if Assigned(Self.FValidator) then
    Self.FValidator.Validate(Self);
end;

procedure TElCurrencyEdit.SetCurrencySymbol(const Value: TLMDString);
begin
  if FCurrencySymbol <> Value then
  begin
    FCurrencySymbol := Value;
    UpdatePartsWidth;
    FUseSystemCurrencySymbol := False;
    Invalidate;
  end;
end;

procedure TElCurrencyEdit.SetUseSystemCurrencySymbol(const Value: Boolean);
begin
  if FUseSystemCurrencySymbol <> Value then
  begin
    if Value then
    begin
      CurrencySymbol := {$IFDEF LMDCOMP17}FormatSettings.{$ELSE}SysUtils.{$ENDIF}CurrencyString;
      case {$IFDEF LMDCOMP17}FormatSettings.{$ELSE}SysUtils.{$ENDIF}CurrencyFormat of
        0: CurrencySymbolPosition := ecsPosLeft;
        1: CurrencySymbolPosition := ecsPosRight;
        2:
          begin
            CurrencySymbolPosition := ecsPosLeft;
            CurrencySymbol := CurrencySymbol + ' ';
          end;
        3:
          begin
            CurrencySymbolPosition := ecsPosRight;
            CurrencySymbol := ' ' + CurrencySymbol;
          end;
      end;
    end;
    FUseSystemCurrencySymbol := Value;
  end;
end;

function TElCurrencyEdit.StoreCurrencySymbol: Boolean;
begin
  Result := not FUseSystemCurrencySymbol;
end;

procedure TElCurrencyEdit.SetCurrencySymbolPosition(
  const Value: TElCurrencySymbolPosition);
begin
  if FCurrencySymbolPosition <> Value then
  begin
    FCurrencySymbolPosition := Value;
    FUseSystemCurrencySymbol := False;
    if HandleAllocated then
      AdjustEditorPositions;
  end;
end;

procedure TElCurrencyEdit.CMWinIniChange(var Msg: TWMWinIniChange);
begin
  inherited;
  Msg.Result := 0;
  if Application.UpdateFormatSettings then
  begin
    if UseSystemDecimalPlaces then
    begin
      UseSystemDecimalPlaces := False;
      UseSystemDecimalPlaces := True;
    end;
    if UseSystemCurrencySymbol then
    begin
      UseSystemCurrencySymbol := False;
      UseSystemCurrencySymbol := True;
    end;
    Invalidate;
  end;
end;

function TElCurrencyEdit.GetButton(Index: Integer): TElGraphicButton;
begin
  Result := FButtons[Index];
end;

function TElCurrencyEdit.GetButtonCaption(Index: Integer): TLMDString;
begin
  Result := FButtons[Index].Caption;
end;

function TElCurrencyEdit.GetButtonColor(Index: Integer): TColor;
begin
  Result := FButtons[Index].Color;
end;

function TElCurrencyEdit.GetButtonDown(Index: Integer): Boolean;
begin
  Result := FButtons[Index].Down;
end;

function TElCurrencyEdit.GetButtonEnabled(Index: Integer): Boolean;
begin
  Result := FButtons[Index].Enabled;
end;

function TElCurrencyEdit.GetButtonFlat(Index: Integer): Boolean;
begin
  Result := FButtons[Index].Flat;
end;

function TElCurrencyEdit.GetButtonVisible(Index: Integer): Boolean;
begin
  Result := FButtons[Index].Visible;
end;

function TElCurrencyEdit.GetButtonWidth(Index: Integer): Integer;
begin
  Result := FButtons[Index].Width;
end;

function TElCurrencyEdit.GetButtonUseIcon(Index: Integer): Boolean;
begin
  Result := FButtons[Index].UseIcon;
end;

function TElCurrencyEdit.GetButtonGlyph(Index: Integer): TBitmap;
begin
  Result := FButtons[Index].Glyph;
end;

function TElCurrencyEdit.GetButtonHint(Index: Integer): TLMDString;
begin
  Result := FButtons[Index].Hint;

end;

function TElCurrencyEdit.GetButtonIcon(Index: Integer): TIcon;
begin
  Result := FButtons[Index].Icon;
end;

function TElCurrencyEdit.GetButtonNumGlyphs(Index: Integer): integer;
begin
  Result := FButtons[Index].NumGlyphs;
end;

function TElCurrencyEdit.GetButtonPopupPlace(Index: Integer): TPopupPlace;
begin
  Result := FButtons[Index].PopupPlace;
end;

function TElCurrencyEdit.GetButtonPullDownMenu(Index: Integer): TPopupMenu;
begin
  Result := FButtons[Index].PullDownMenu;
end;

function TElCurrencyEdit.GetButtonUseImageList(Index: Integer): Boolean;
begin
  Result := FButtons[Index].UseImageList;
end;

function TElCurrencyEdit.GetOnButtonClick(Index: Integer): TNotifyEvent;
begin
  Result := FButtonClicks[Index];
end;

procedure TElCurrencyEdit.SetButtonCaption(Index: Integer; Value: TLMDString);
begin
  FButtons[Index].Caption := Value;
end;

procedure TElCurrencyEdit.SetButtonColor(const Index: Integer;
  const Value: TColor);
begin
  FButtons[Index].Color := Value;
end;

procedure TElCurrencyEdit.SetButtonDown(const Index: Integer;
  const Value: Boolean);
begin
  FButtons[Index].Down := Value;
end;

procedure TElCurrencyEdit.SetButtonEnabled(const Index: Integer;
  const Value: Boolean);
begin
  FButtons[Index].Enabled := Value;
end;

procedure TElCurrencyEdit.SetButtonFlat(const Index: Integer;
  const Value: Boolean);
begin
  FButtons[Index].Flat := Value;
end;

procedure TElCurrencyEdit.SetButtonVisible(const Index: Integer;
  const Value: Boolean);
begin
  if FButtons[Index].Visible <> Value then
  begin
    FButtons[Index].Visible := Value;
    AdjustEditorPositions;
  end;
end;

procedure TElCurrencyEdit.SetButtonWidth(const Index, Value: Integer);
begin
  if FButtons[Index].Width <> Value then
  begin
    FButtons[Index].Width := Value;
    if Visible and FButtons[Index].Visible then AdjustEditorPositions;
  end;
end;

procedure TElCurrencyEdit.SetButtonUseIcon(const Index: Integer;
  const Value: Boolean);
begin
  FButtons[Index].UseIcon := Value;
end;

procedure TElCurrencyEdit.SetButtonGlyph(const Index: Integer;
  const Value: TBitmap);
begin
  FButtons[Index].Glyph := Value;
end;

procedure TElCurrencyEdit.SetButtonHint(const Index: Integer; const Value: TLMDString);
begin
  FButtons[Index].Hint := Value;
end;

procedure TElCurrencyEdit.SetButtonIcon(const Index: Integer;
  const Value: TIcon);
begin
  FButtons[Index].Icon := Value;
end;

procedure TElCurrencyEdit.SetButtonNumGlyphs(const Index, Value: integer);
begin
  FButtons[Index].NumGlyphs := Value;
end;

procedure TElCurrencyEdit.SetButtonPopupPlace(const Index: Integer;
  const Value: TPopupPlace);
begin
  FButtons[Index].PopupPlace := Value;
end;

procedure TElCurrencyEdit.SetButtonPullDownMenu(const Index: Integer;
  const Value: TPopupMenu);
begin
  FButtons[Index].PullDownMenu := Value;
end;

procedure TElCurrencyEdit.SetButtonUseImageList(const Index: Integer;
  const Value: Boolean);
begin
  FButtons[Index].UseImageList := Value;
end;

procedure TElCurrencyEdit.SetOnButtonClick(const Index: Integer;
  const Value: TNotifyEvent);
begin
  FButtonClicks[Index] := Value;
end;

procedure TElCurrencyEdit.ButtonClickTransfer(Sender: TObject);
var
  I: Integer;
begin
  for I := CURRBTNMIN to CURRBTNMAX do
  begin
    if Sender = FButtons[I] then
    begin
      if Assigned(FButtonClicks[I]) then FButtonClicks[I](Self);
      Break;
    end;
  end;
end;

function TElCurrencyEdit.GetButtonDisabledImages(Index: Integer): TCustomImageList;
begin
  Result := FButtons[Index].DisabledImages;
end;

function TElCurrencyEdit.GetAlphaButtonDisabledImages(Index: Integer): TCustomImageList;
begin
  Result := FButtons[Index].AlphaForDisabledImages;
end;

function TElCurrencyEdit.GetButtonDownImages(Index: Integer): TCustomImageList;
begin
  Result := FButtons[Index].DownImages;
end;

function TElCurrencyEdit.GetAlphaButtonDownImages(Index: Integer): TCustomImageList;
begin
  Result := FButtons[Index].AlphaForDownImages;
end;

function TElCurrencyEdit.GetButtonHotImages(Index: Integer): TCustomImageList;
begin
  Result := FButtons[Index].HotImages;
end;

function TElCurrencyEdit.GetAlphaButtonHotImages(Index: Integer): TCustomImageList;
begin
  Result := FButtons[Index].AlphaForHotImages;
end;

function TElCurrencyEdit.GetButtonImageList(Index: Integer): TCustomImageList;
begin
  Result := FButtons[Index].Images;
end;

function TElCurrencyEdit.GetAlphaButtonImageList(Index: Integer): TCustomImageList;
begin
  Result := FButtons[Index].AlphaForImages;
end;

function TElCurrencyEdit.GetButtonImageIndex(Index: Integer): TImageIndex;
begin
  Result := FButtons[Index].ImageIndex;
end;

procedure TElCurrencyEdit.SetButtonDisabledImages(const Index: Integer;
  const Value: TCustomImageList);
begin
  FButtons[Index].DisabledImages := Value;
end;

procedure TElCurrencyEdit.SetAlphaButtonDisabledImages(const Index: Integer;
  const Value: TCustomImageList);
begin
  FButtons[Index].AlphaForDisabledImages := Value;
end;

procedure TElCurrencyEdit.SetButtonDownImages(const Index: Integer;
  const Value: TCustomImageList);
begin
  FButtons[Index].DownImages := Value;
end;

procedure TElCurrencyEdit.SetAlphaButtonDownImages(const Index: Integer;
  const Value: TCustomImageList);
begin
  FButtons[Index].AlphaForDownImages := Value;
end;

procedure TElCurrencyEdit.SetButtonHotImages(const Index: Integer;
  const Value: TCustomImageList);
begin
  FButtons[Index].HotImages := Value;
end;

procedure TElCurrencyEdit.SetAlphaButtonHotImages(const Index: Integer;
  const Value: TCustomImageList);
begin
  FButtons[Index].AlphaForHotImages := Value;
end;

procedure TElCurrencyEdit.SetButtonImageList(const Index: Integer;
  const Value: TCustomImageList);
begin
  FButtons[Index].Images := Value;
end;

procedure TElCurrencyEdit.SetAlphaButtonImageList(const Index: Integer;
  const Value: TCustomImageList);
begin
  FButtons[Index].AlphaForImages := Value;
end;

procedure TElCurrencyEdit.SetButtonImageIndex(const Index: Integer;
  const Value: TImageIndex);
begin
  FButtons[Index].ImageIndex := Value;
end;

procedure TElCurrencyEdit.SetEnableSign(const Value: Boolean);
begin
  if FEnableSign <> Value then
  begin
    FEnableSign := Value;
    if FSign and not EnableSign then
    begin
      Sign := False;
    end;
    UpdatePartsWidth;
  end;
end;

{$ifndef NO_CALC_IN_CURREDIT}
procedure TElCurrencyEdit.SetCalcDlgButtonGlyphDefault(Value: Boolean);
begin
  if fCalcDlgButtonGlyphDefault <> Value then
  begin
    if Value then
    begin
      LoadCalcDlgButtonGlyphDefault;
    end
    else
    begin
      CalcDlgButtonGlyph := nil;
    end;
    fCalcDlgButtonGlyphDefault := Value;

    if (not (csLoading in Componentstate)) then Invalidate;
  end;
end;

procedure TElCurrencyEdit.CalcDlgFormShow(Sender: TObject);

  procedure CalculatePosition(ElCalcForm: TElCalculatorFormCurrEdit);
  var
    P: TPoint;
    ElCalcForm_Height: Integer;
  begin
    // calculate position of calculator window
    ElCalcForm_Height := ElCalcForm.Height;
    P := Parent.ClientToScreen(Point(Left, Top));

    // calculate dialog height
    if P.Y + ElCalcForm_Height < ElVCLUtils.GetDesktopBottom then
    begin // bottom
      ElCalcForm.Top := P.Y + Height;
    end
    else
    begin // top
      ElCalcForm.Top := P.Y - ElCalcForm_Height;
    end;

    // calculate dialog width
    if P.X + ElCalcForm.Width < ElVCLUtils.GetDesktopRight then
    begin
      ElCalcForm.Left := P.X;
      // correct horizontal position
      if ElCalcForm.Left < ElVCLUtils.GetDesktopLeft then
        ElCalcForm.Left := ElVCLUtils.GetDesktopLeft;
    end
    else
    begin
      ElCalcForm.Left := ElVCLUtils.GetDesktopRight - ElCalcForm.Width;
    end;
  end;

begin
  if Assigned(fCalcDlgOnFormShow) then fCalcDlgOnFormShow(Sender);
  CalculatePosition(fCalcDlgElCalculatorForm);
end;

procedure TElCurrencyEdit.CalcDlgButtonClick(Sender: TObject);

  procedure PrepareDlg(ElCalcForm: TElCalculatorFormCurrEdit);
  var
    i: Integer;
  begin
    for i := 0 to 9 do
      (ElCalcForm.FindComponent('b' + IntToStr(i)) as TElGraphicButton).Font :=
        fCalcDlgDigitButtonFont;
    for i := 1 to 4 do
      (ElCalcForm.FindComponent(ElMemoryButtons[i]) as TElGraphicButton).Font :=
        fCalcDlgMemoryButtonFont;
    for i := 1 to 3 do
      (ElCalcForm.FindComponent(ElServiceButtons[i]) as TElGraphicButton).Font :=
        fCalcDlgServiceButtonFont;
    for i := 1 to 10 do
      (ElCalcForm.FindComponent(ElOperatorButtons[i]) as TElGraphicButton).Font :=
        fCalcDlgOperatorButtonFont;
  end;

var
  fModalMode: Boolean;

begin
  //if ReadOnly then
  //  exit;

  // SetFocus;

  if Assigned(fCalcDlgOnButtonClick) then
    fCalcDlgOnButtonClick(Sender);

  FreeAndNil(fCalcDlgElCalculatorForm);

  fModalMode := fCalcDlgModal;

  fCalcDlgElCalculatorForm := TElCalculatorFormCurrEdit.Create(Self);
  try
    {init dialog properties and calculate dialog position}

    fCalcDlgElCalculatorForm.Position := poDesigned;
    fCalcDlgOnFormShow := fCalcDlgElCalculatorForm.OnShow;
    fCalcDlgElCalculatorForm.OnShow := CalcDlgFormShow;
    PrepareDlg(fCalcDlgElCalculatorForm);
    fCalcDlgElCalculatorForm.Caption := fCalcDlgCaption;
    if fCalcDlgElCalculatorForm.Caption = '' then
      fCalcDlgElCalculatorForm.DialogStyle := edsPopup;

    if CalcDlgDefZeroValue then
      fCalcDlgElCalculatorForm.Value := 0
    else
      fCalcDlgElCalculatorForm.Value := Value;

    fCalcDlgElCalculatorForm.FNew := FCalcDlgResetValue;
    fCalcDlgElCalculatorForm.OnDestroy := CalcDlg_OnFormDestroy;
    fCalcDlgElCalculatorForm.OnClose := CalcDlg_OnFormClose;
    fCalcDlgElCalculatorForm.OnError := fCalcDlgOnError;
    fCalcDlgElCalculatorForm.OnDeactivate := CalcDlg_OnDeactivate;
    fCalcDlgElCalculatorForm.FShowControlButtons := fCalcDlgShowControlButtons;
    {show dialog}

    if Assigned(fCalcDlgOnShow) then fCalcDlgOnShow(Sender);

    if fModalMode then
    begin // Modal Mode

      if (fCalcDlgElCalculatorForm.ShowModal = mrOK) and (not ReadOnly) then
      begin
        Value := fCalcDlgElCalculatorForm.Value;
        SetModified(True);
      end;

    end
    else
    begin // No Modal Mode
      fCalcDlgElCalculatorForm.fModalResult := mrCancel;
      fCalcDlgElCalculatorForm.bCancel.OnClick := CalcDlg_bCancelClick;
      fCalcDlgElCalculatorForm.bOK.OnClick := CalcDlg_bOKClick;

      fCalcDlgElCalculatorForm.Show;
    end;

  finally
    if fModalMode then

      FreeAndNil(fCalcDlgElCalculatorForm);

  end;
end;

procedure TElCurrencyEdit.SetCalcDlgModal(Value: Boolean);
begin
  if fCalcDlgElCalculatorForm = nil then
    fCalcDlgModal := Value;
  // allow change when dialog not showing
  // else raise Exception.Create('Cannot change when dialog is executing')
end;

procedure TElCurrencyEdit.CalcDlg_OnFormClose(Sender: TObject; var Action:
  TCloseAction);
begin
  fCalcDlgElCalculatorForm.OnClose := nil;
  Action := caFree;
  if (fCalcDlgElCalculatorForm.fModalResult = mrOK) and (not ReadOnly) then
  begin
    Value := fCalcDlgElCalculatorForm.Value;
    SetModified(True);
  end;
  if Assigned(FCalcDlgOnClose) then
    FCalcDlgOnClose(Self);
end;

procedure TElCurrencyEdit.CalcDlg_OnFormDestroy(Sender: TObject);
begin
  fCalcDlgElCalculatorForm := nil;
end;

procedure TElCurrencyEdit.CalcDlg_bCancelClick(Sender: TObject);
begin
  fCalcDlgElCalculatorForm.fModalResult := mrCancel;
  fCalcDlgElCalculatorForm.Close;
end;

procedure TElCurrencyEdit.CalcDlg_bOKClick(Sender: TObject);
begin
  fCalcDlgElCalculatorForm.fModalResult := mrOK;
  fCalcDlgElCalculatorForm.Close;
end;

procedure TElCurrencyEdit.CalcDlg_OnDeactivate(Sender: TObject; var ModalResult:
  Integer);
begin
  if fCalcDlgElCalculatorForm = nil then
    exit;

  if Assigned(fCalcDlgOnDeactivate) then
    CalcDlgOnDeactivate(sender, ModalResult);

  if not fCalcDlgModal then
  begin
    fCalcDlgElCalculatorForm.FModalResult := mrOk;
    fCalcDlgElCalculatorForm.Close;
  end;
end;

procedure TElCurrencyEdit.CalcDlgButtonGlyph_OnChanged(Sender: TObject);
begin
  fCalcDlgButtonGlyphDefault := False;
  if Assigned(fCalcDlgButtonGlyphOnChange) then
    fCalcDlgButtonGlyphOnChange(Sender);
end;

function TElCurrencyEdit.NeedStroredButtonGlyph(const Index: Integer): Boolean;
begin
  if Index = 1 then
    Result := not fCalcDlgButtonGlyphDefault
  else
    Result := True;
end;

procedure TElCurrencyEdit.LoadCalcDlgButtonGlyphDefault;
begin
  ElCalc.LoadCalculatorDefaultGlyph(CalcDlgButtonGlyph);
  fCalcDlgButtonGlyphDefault := True;
end;
{$endif}

procedure TElCurrencyEdit.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TElCurrencyEdit.WMNCCalcSize(var Message: TWMNCCalcSize);

begin
  inherited;
  if LMDSIWindowsVistaUp then
  begin
    Dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smYEdge[ctl3D]) div 2);
    Dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smXEdge[ctl3D]) div 2);
    Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smXEdge[ctl3D]) div 2);
    Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smYEdge[ctl3D]) div 2);
    exit;
  end;

  if (BorderStyle = bsSingle) and (not IsThemed) then
    begin
     if not (ebsLeft in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
      if not (ebsTop in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
      if not (ebsRight in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smXEdge[Ctl3D]));
      if not (ebsBottom in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smYEdge[Ctl3D]));
      end;
end;

function TElCurrencyEdit.GetSignValue: Currency;
begin
  if Sign then
  begin
    Result := -FAbsValue;
  end
  else
  begin
    Result := FAbsValue;
  end;
end;

procedure TElCurrencyEdit.SetSign(const Value: Boolean);
begin
  if FSign <> Value then
  begin
    if Value and ((not EnableSign) and (ComponentState * [csLoading, csReading] = [])) then Exit;
    FSign := Value;
    SetupPartsFont;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TElCurrencyEdit.SetSignValue(const Value: Currency);
begin
  FValueUndefined := false;
  if Value < 0.0 then
  begin
    SetSign(True);
    SetAbsValue(-Value);
  end
  else
  begin
    SetSign(False);
    SetAbsValue(Value);
  end;
end;

procedure TElCurrencyEdit.SetAutoSelect(const Value: Boolean);
begin
  if AutoSelect <> Value then
  begin
    FPartEditors[1].AutoSelect := Value;
    FPartEditors[2].AutoSelect := Value;
  end;
end;

function TElCurrencyEdit.GetAutoSelect: Boolean;
begin
  Result := FPartEditors[1].AutoSelect;
end;

procedure TElCurrencyEdit.SetNegativeSignColor(const Value: TColor);
begin
  if FNegativeSignColor <> Value then
  begin
    FNegativeSignColor := Value;
    if Sign then
    begin
      Invalidate;
    end;
  end;
end;

procedure TElCurrencyEdit.SetNegativeValueTextColor(const Value: TColor);
begin
  if FNegativeValueTextColor <> Value then
  begin
    FNegativeValueTextColor := Value;
    if Sign then
    begin
      SetupPartsFont;
    end;
  end;
end;

procedure TElCurrencyEdit.SetupPartsFont;
var
  F: TFont;
  I: Integer;
begin
  if Sign and (NegativeValueTextColor <> clNone) then
  begin
    F := TFont.Create;
    try
      F.Assign(Font);
      F.Color := NegativeValueTextColor;
      for I := 1 to 2 do
        FPartEditors[I].Font := F;
    finally
      F.Free;
    end;
  end
  else
  begin
    for I := 1 to 2 do
    begin
      FPartEditors[I].Font := Font;
      if FPartEditors[I].HandleAllocated then
         FPartEditors[I].Canvas.Font.Assign(Font);
    end;
  end;
end;

function TElCurrencyEdit.GetReadOnly: Boolean;
begin
  Result := FPartEditors[1].ReadOnly;
end;

procedure TElCurrencyEdit.SetReadOnly(const Value: Boolean);
var
  I: Integer;
begin
  for I := 1 to 2 do
    FPartEditors[I].ReadOnly := Value;
  Invalidate;
end;

procedure TElCurrencyEdit.OnEditorClick(Sender: TObject);
begin
  Click;
end; { ClickHandler }

procedure TElCurrencyEdit.OnEditorDblClick(Sender: TObject);
begin
  DblClick;
end; { DblClickHandler }

procedure TElCurrencyEdit.OnEditorEndDrag(Sender: TObject; Target: TObject; X:
  Integer; Y: Integer);
begin
  DoEndDrag(Target, X, Y);
end; { EndDragHandler }

procedure TElCurrencyEdit.OnEditorKeyUp(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  KeyUp(Key, Shift);
end; { KeyUpHandler }

procedure TElCurrencyEdit.OnEditorMouseDown(Sender: TObject; Button:
  TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
begin
  MouseDown(Button, Shift, X, Y);
end; { MouseDownHandler }

procedure TElCurrencyEdit.OnEditorMouseMove(Sender: TObject; Shift: TShiftState;
  X: Integer; Y: Integer);
begin
  MouseMove(Shift, X, Y);
end; { MouseMoveHandler }

procedure TElCurrencyEdit.OnEditorMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X: Integer; Y: Integer);
begin
  MouseUp(Button, Shift, X, Y);
end; { MouseUpHandler }

procedure TElCurrencyEdit.OnEditorStartDrag(Sender: TObject; var DragObject:
  TDragObject);
begin
  DoStartDrag(DragObject);
end; { StartDragHandler }

procedure TElCurrencyEdit.OnEditorKeyPress(Sender: TObject; var Key: Char);
begin
  KeyPress(Key);
end; { KeyPressHandler }

procedure TElCurrencyEdit.OnEditorDragDrop(Sender: TObject; Source: TObject; X:
  Integer; Y: Integer);
begin
  DragDrop(Source, X, Y);
end; { DragDropHandler }

procedure TElCurrencyEdit.OnEditorDragOver(Sender: TObject; Source: TObject; X:
  Integer; Y: Integer; State: TDragState; var Accept: Boolean);
begin
  DragOver(Source, X, Y, State, Accept);
end; { DragOverHandler }

function TElCurrencyEdit.GetThemedElement: TThemedElement;
begin
  Result := teEdit;
end;

procedure TElCurrencyEdit.CMCtl3DChanged(var Msg: TMessage);
begin
  inherited;
  RecreateWnd;
  // SetEditRect;
end; { CMCtl3DChanged }

procedure TElCurrencyEdit.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
      if HandleAllocated then
        DrawFlatBorder(0);
  end;
end;

procedure TElCurrencyEdit.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
      if HandleAllocated then
        DrawFlatBorder(0);
  end;
end;

{$IFDEF LMD_UNICODE}
procedure TElCurrencyEdit.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

procedure TElCurrencyEdit.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

procedure TElCurrencyEdit.SetUseDisabledColors(Value: Boolean);
var
  i: integer;
begin
  if FUseDisabledColors <> Value then
  begin
    FUseDisabledColors := Value;
    for I := 1 to 2 do
    begin
      FPartEditors[I].UseDisabledColors := Value;
    end;
    Invalidate;
  end;
end;

procedure TElCurrencyEdit.SetUseXPThemes(const Value: Boolean);
var i : integer;
begin
  inherited;
  FPartEditors[1].UseXPThemes := Value;
  FPartEditors[2].UseXPThemes := Value;
  for i := CURRBTNMIN to CURRBTNMAX do
    FButtons[i].UseXPThemes := Value;
end;

procedure TElCurrencyEdit.SetFocusedSelectColor(newValue: TColor);
var i : integer;
begin
  if FFocusedSelectColor <> Value then
  begin
    FFocusedSelectColor := newValue;
    for i := CURRPARTMIN to CURRPARTMAX do
      FPartEditors[i].FocusedSelectColor := newValue;
  end;
end;

procedure TElCurrencyEdit.SetFocusedSelectTextColor(newValue: TColor);
var i : integer;
begin
  if FFocusedSelectTextColor <> Value then
  begin
    FFocusedSelectTextColor := newValue;
    for i := CURRPARTMIN to CURRPARTMAX do
      FPartEditors[i].FocusedSelectTextColor := newValue;
  end;
end;

procedure TElCurrencyEdit.SetHideSelectColor(newValue: TColor);
var i : integer;
begin
  if FHideSelectColor <> Value then
  begin
    FHideSelectColor := newValue;
    for i := CURRPARTMIN to CURRPARTMAX do
      FPartEditors[i].HideSelectColor := newValue;
  end;
end;

procedure TElCurrencyEdit.SetHideSelectTextColor(newValue: TColor);
var i : integer;
begin
  if (FHideSelectTextColor <> newValue) then
  begin
    FHideSelectTextColor := newValue;
    for i := CURRPARTMIN to CURRPARTMAX do
      FPartEditors[i].FHideSelectTextColor := newValue;
  end;  {if}
end;

function TElCurrencyEdit.GetHideSelection: Boolean;
begin
  Result := FHideSelection;
end;

procedure TElCurrencyEdit.SetHideSelection(Value: Boolean);
var i : integer;
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    for i := CURRPARTMIN to CURRPARTMAX do
      FPartEditors[i].HideSelection := Value;
  end;
end;

procedure TElCurrencyEdit.SetHighlightAlphaLevel(Value: Integer);
var i : integer;
begin
  if FHighlightAlphaLevel <> Value then
  begin
    FHighlightAlphaLevel := Value;
    for i := CURRPARTMIN to CURRPARTMAX do
      FPartEditors[i].HighlightAlphaLevel := Value;
  end;
end;

procedure TElCurrencyEdit.UpdateLinkedControl;
begin
  if FLinkedControl <> nil then
  begin
    case FLinkedControlPosition of
      lcpLeftTop:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top, FLinkedControl.Width, FLinkedControl.Height);
      lcpLeftBottom:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top + Height - FLinkedControl.Height, FLinkedControl.Width, FLinkedControl.Height);
      lcpLeftCenter:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top + (Height - FLinkedControl.Height) div 2, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopLeft:
        FLinkedControl.SetBounds(Left, Top - FLinkedControl.Height - FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopRight:
        FLinkedControl.SetBounds(Left + Width - FLinkedControl.Width, Top - FLinkedControl.Height - FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopCenter:
        FLinkedControl.SetBounds(Left + (Width - FLinkedControl.Width) div 2, Top - FLinkedControl.Height - FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightTop:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightBottom:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top + Height - FLinkedControl.Height, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightCenter:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top + (Height - FLinkedControl.Height) div 2, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomLeft:
        FLinkedControl.SetBounds(Left, Top + Height + FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomRight:
        FLinkedControl.SetBounds(Left + Width - FLinkedControl.Width, Top + Height + FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomCenter:
        FLinkedControl.SetBounds(Left + (Width - FLinkedControl.Width) div 2, Top + Height + FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
    end;
  end;
end;

procedure TElCurrencyEdit.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if FLinkedControl = AComponent then
      LinkedControl := nil;
    if  Assigned(Self.FValidator) and (AComponent = Self.FValidator) then
      Self.SetValidator(nil);
  end;
end;

procedure TElCurrencyEdit.SetLinkedControlPosition(Value: TElLinkCtlPos);
begin
  if FLinkedControlPosition <> Value then
  begin
    FLinkedControlPosition := Value;
    UpdateLinkedControl;
  end;
end;

procedure TElCurrencyEdit.SetLinkedControl(Value: TControl);
begin
  if (FLinkedControl <> Value) and (Value <> Self) then
  begin
    if (FLinkedControl <> nil) then
      if not (csDestroying in FLinkedControl.ComponentState) then
        FLinkedControl.RemoveFreeNotification(Self);
    FLinkedControl := Value;
    if FLinkedControl <> nil then
      FLinkedControl.FreeNotification(Self);
    UpdateLinkedControl;
  end;
end;

procedure TElCurrencyEdit.SetLinkedControlSpacing(Value: Integer);
begin
  if FLinkedControlSpacing <> Value then
  begin
    FLinkedControlSpacing := Value;
    UpdateLinkedControl;
  end;
end;

procedure TElCurrencyEdit.SetDisabledColor(Value: TColor);
var i : integer;
begin
  if FDisabledColor <> Value then
  begin
    FDisabledColor := Value;
    for I := 1 to 2 do
    begin
      FPartEditors[I].DisabledColor := Value;
    end;
  end;
end;

procedure TElCurrencyEdit.SetDisabledFontColor(Value: TColor);
var i : integer;
begin
  if FDisabledFontColor <> Value then
  begin
    FDisabledFontColor := Value;
    for I := 1 to 2 do
    begin
      FPartEditors[I].DisabledFontColor := Value;
    end;
  end;
end;

function TElCurrencyEdit.GetButtonThinFrame(Index: Integer): Boolean;
begin
  Result := FButtons[Index].ThinFrame;
end;

procedure TElCurrencyEdit.SetButtonThinFrame(Index: Integer; Value: Boolean);
begin
  FButtons[Index].ThinFrame := Value;
end;

function TElCurrencyEdit.GetButtonOldStyled(Index: Integer): Boolean;
begin
  Result := FButtons[Index].OldStyled;
end;

procedure TElCurrencyEdit.SetButtonOldStyled(Index: Integer; Value: Boolean);
begin
  FButtons[Index].OldStyled := Value;
end;

function TElCurrencyEdit.GetButtonShowBorder(Index: Integer): Boolean;
begin
  Result := FButtons[Index].ShowBorder;
end;

procedure TElCurrencyEdit.SetButtonShowBorder(Index: Integer; Value: Boolean);
begin
  FButtons[Index].ShowBorder := Value;
end;

procedure TElCurrencyEdit.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElCurrencyEdit.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElCurrencyEdit.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElCurrencyEdit.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElCurrencyEdit.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElCurrencyEdit.KeyDown(var Key : Word; Shift : TShiftState);
var
  SC : TShortcut;
begin
  if Key = 0 then
  begin
    inherited;
    exit;
  end;
  SC := Shortcut(Key, Shift);

  if (SC = FButtonShortCut) and (FButtons[0].Visible) and (FButtons[0].Enabled) then
    FButtons[0].Click
  else
    if (SC = FCalcDlgButtonShortcut) and (FButtons[1].Visible) and (FButtons[1].Enabled) then
      FButtons[1].Click
    else
  //if (Key = VK_TAB) and (Shift = [ssShift]) then
  // begin
      inherited;
end; { KeyDown }

procedure TElCurrEditButton.DrawThemedBackground(Canvas: TCanvas);
begin
  inherited;
end;

procedure TElCurrencyEdit.SetUseThousandSeparator(Value: Boolean);
begin
  FUseThousandSeparator := Value;
  if FUseThousandSeparator then
    FPartEditors[1].Text := FloatToStrF(Trunc(FAbsValue),ffNumber,18,0)
  else
    FPartEditors[1].Text := IntToStr(Trunc(FAbsValue));
end;

procedure TElCurrPartEdit.CopyToClipboard;
var Clip  : TClipboard;
  {$IFDEF LMD_UNICODE}
    s: WideString;
  {$ELSE}
    s : String;
  {$ENDIF LMD_UNICODE}
    i: integer;
begin
  Clip := Clipboard;
  Clip.Open;
  s := GetSelectedText;
  while pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator,s) > 0 do
  begin
    i := pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator,s);
    s := copy(s,0,i-1)+copy(s,i+1,length(s)-1);
  end;
  Clip.AsText := s;
  Clip.Close;
end;

procedure TElCurrPartEdit.CutToClipboard;
begin
  if ReadOnly then exit;
  CopyToClipboard;
  text := '0';
  Change;
end;

procedure TElCurrPartEdit.PasteFromClipboard;
begin
  if ReadOnly then exit;
  inherited;
  //Change;
end;

procedure TElCurrencyEdit.SetValueUndefined(Value: Boolean);
begin
  if FValueUndefined <> Value then
  begin
    Self.Value := 0;
    FValueUndefined := Value;
    UpdateParts;
  end;
end;

function TElCurrencyEdit.GetButtonIsSwitch: boolean;
begin
  result := FButtons[0].IsSwitch;
end;

procedure TElCurrencyEdit.SetButtonIsSwitch(const Value: boolean);
begin
  if FButtons[0].IsSwitch <> Value then
    FButtons[0].IsSwitch := Value;
end;

procedure TElCurrencyEdit.SetCalcDlgDigitButtonFont(const Value: TFont);
begin
  fCalcDlgDigitButtonFont.Assign(Value);
end;

procedure TElCurrencyEdit.SetCalcDlgMemoryButtonFont(const Value: TFont);
begin
  fCalcDlgMemoryButtonFont.Assign(Value);
end;

procedure TElCurrencyEdit.SetCalcDlgOperatorButtonFont(const Value: TFont);
begin
  fCalcDlgOperatorButtonFont.Assign(Value);
end;

procedure TElCurrencyEdit.SetCalcDlgServiceButtonFont(const Value: TFont);
begin
  fCalcDlgServiceButtonFont.Assign(Value);
end;

function TElCurrencyEdit.GetBkColor: TColor;
begin
  if UseDisabledColors and (not Enabled) then
    result := DisabledColor
  else
    if (FDisplayReadOnlyOptions.Enabled) and (ReadOnly) then
      Result := FDisplayReadOnlyOptions.BkColor
    else
      Result := Color;
end;

function TElCurrencyEdit.GetTextColor: TColor;
begin
  if (NegativeSignColor <> clNone) and Sign then
  begin
    Canvas.Font.Color := NegativeSignColor;
    Result := NegativeSignColor;
  end
  else
    if UseThemeMode <> ttmNone then
    begin
      if not Enabled then
        Result := GetSysColor(COLOR_GRAYTEXT)
      else
        if (FDisplayReadOnlyOptions.Enabled) and (ReadOnly) then
          Result := FDisplayReadOnlyOptions.TextColor
        else
          Result := GetSysColor(COLOR_WINDOWTEXT);
    end
    else
    begin
      if UseDisabledColors and (not Enabled) then
        result := DisabledFontColor
      else
        if (FDisplayReadOnlyOptions.Enabled) and (ReadOnly) then
          Result := FDisplayReadOnlyOptions.TextColor
        else
          Result := Font.Color;
    end;
end;

procedure TElCurrencyEdit.SetDisplayReadOnlyOptions(const Value: TElDisplayOptions);
begin
  FDisplayReadOnlyOptions.Assign(Value);
  FPartEditors[1].DisplayReadOnlyOptions.Assign(Value);
  FPartEditors[2].DisplayReadOnlyOptions.Assign(Value);
end;

procedure TElCurrencyEdit.DisplayOptionsChange(Sender: TObject);
begin
  FIgnoreReadOnlyState := not FDisplayReadOnlyOptions.Enabled;
  FPartEditors[1].DisplayReadOnlyOptions.Assign(FDisplayReadOnlyOptions);
  FPartEditors[2].DisplayReadOnlyOptions.Assign(FDisplayReadOnlyOptions);
  Invalidate;
end;

function TElCurrencyEdit.GetControl: TControl;
begin
  Result := Self;
end;

function TElCurrencyEdit.GetControlBackBrush: TBrush;
begin
  Result := Self.Brush;
end;

function TElCurrencyEdit.GetControlFont: TFont;
begin
  Result := Self.Font;
end;

function TElCurrencyEdit.GetValidationMsgString: TLMDString;
begin
  Result := Self.FValidationMsgString;
end;

function TElCurrencyEdit.GetValidator: TLMDValidationEntity;
begin
  Result := Self.FValidator;
end;

function TElCurrencyEdit.GetValueToValidate: TLMDString;
begin
  Result := CurrToStr(Self.Value);
end;

procedure TElCurrencyEdit.SetValidationMsgString(val: TLMDString);
begin
  Self.FValidationMsgString := val;
end;

procedure TElCurrencyEdit.SetValidator(Validator:TLMDValidationEntity);
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

procedure TElCurrencyEdit.RespondToError(ErrorLevel: TLMDErrorLevel);
begin
  FErrorIndication := ErrorLevel > 0;
  if Assigned(FOnValidationError) and FErrorIndication then
    FOnValidationError(self, ErrorLevel);
end;

function TElCurrencyEdit.SupportsDefaultIndication: boolean;
begin
  Result := false;
end;

end.
