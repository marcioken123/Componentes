unit ElPopBtn;
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

ElPopBtn unit
-------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, TypInfo, Classes, Math, Windows, Messages, Graphics, Controls, Forms,
  Buttons, CommCtrl, Menus, ExtCtrls, Types, ImgList, ActnList, Themes,

  LMDThemes, LMDClass, LMDProcs, LMDUtils, LMDPNGImage, LMDDebugUnit, LMDHTMLUnit, LMDTypes,
  LMDGlyphs, LMDGraph, LMDGraphUtils,

  ElBtnCtl, ElCGControl, LMDElConst,  ElImgFrm, ElStyleMan, ElSndMap,
  ElVCLUtils;

type
  TPullDownEvent = procedure(Sender : TObject) of object;

  TElSpeedButton = class(TElCustomGraphicControl)
  private
    FTransparentColor : TColor;
    FAutoSize : Boolean;
    FNormalImage : TBitmap;
    FDisabledImage : TBitmap;
    FMouseInImage : TBitmap;
    FPressedImage : TBitmap;
    FFlat : Boolean;
    FDrawEdge : Boolean;
    FPressed : boolean;
    FOver : boolean;
    FPullTimer : TTimer;
    FPullDownBtn : TMouseButton;
    FPullDownInterval : Integer;
    FPullDownEnabled : Boolean;
    FPullDownMenu : TPopupMenu;
    FTransparent : Boolean;
    FOnPullDown : TPullDownEvent;
    FImages: TCustomImageList;
    FUseImageList: Boolean;
    FChLink: TChangeLink;
    procedure ChangeSize;
    procedure SetPullDownMenu(newValue : TPopupMenu);
    procedure SetTransparent(newValue : Boolean);
    procedure SetDrawEdge(newValue : Boolean);
    procedure SetFlat(newValue : Boolean);
    procedure SetNormalImage(newValue : TBitmap);
    procedure SetDisabledImage(newValue : TBitmap);
    procedure SetMouseInImage(newValue : TBitmap);
    procedure SetPressedImage(newValue : TBitmap);
    procedure SetTransparentColor(newValue : TColor);
    procedure WMMouseMove(var Msg : TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure SetImages(const Value: TCustomImageList);
    procedure SetUseImageList(const Value: Boolean);
  protected
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    procedure SetAutoSize(newValue : boolean);  override;
    procedure TriggerPullDownEvent; virtual;
    procedure Paint; override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure OnTimer(Sender : TObject);
    procedure StartTimer;
    procedure PullMenu;
    procedure ImagesChanged(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    {$ifdef LMD_UNICODE}
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    procedure SetHint(Value: TLMDString);
    {$endif}
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function InCircle(X, Y : integer) : Boolean; virtual;
  published
    property PullDownBtn: TMouseButton read FPullDownBtn write FPullDownBtn; { Published }
    property PullDownInterval : Integer read FPullDownInterval write FPullDownInterval default 1000; { Published }
    property PullDownEnabled : Boolean read FPullDownEnabled write FPullDownEnabled default false; { Published }
    property PullDownMenu : TPopupMenu read FPullDownMenu write SetPullDownMenu; { Published }
    property Transparent : Boolean read FTransparent write SetTransparent default true; { Published }
    property OnPullDown : TPullDownEvent read FOnPullDown write FOnPullDown;
    property DrawEdge : Boolean read FDrawEdge write SetDrawEdge default False; { Published }
    property Flat: Boolean read FFlat write SetFlat default False; { Published }
    property NormalImage : TBitmap read FNormalImage write SetNormalImage; { Published }
    property DisabledImage : TBitmap read FDisabledImage write SetDisabledImage; { Published }
    property MouseInImage : TBitmap read FMouseInImage write SetMouseInImage; { Published }
    property PressedImage : TBitmap read FPressedImage write SetPressedImage; { Published }
    property AutoSize : Boolean read FAutoSize write SetAutoSize default true; { Published }
    property TransparentColor : TColor read FTransparentColor write SetTransparentColor default clNone; { Published }
    property UseImageList: Boolean read FUseImageList write SetUseImageList;
    property Images: TCustomImageList read FImages write SetImages;

    //VCL properties
    property Align;
    property Color nodefault;
    property DragCursor;
    property DragMode;
    property ParentColor;
    property Enabled;
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnDragOver;
    property OnDragDrop;

    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation default doNoOrient;
    property Floating;
    property DragKind;

  end; { TElSpeedButton }
  TPopupPlace = (ppDown, ppRight, ppTop);

  {$WARNINGS OFF}
  {$hints off}
  TCustomElPopupButton = class(TElButtonControl)
  private
    function GetResizableButtonImage: Boolean;
    procedure SetResizableButtonImage(const Value: Boolean);
    procedure SetGlyphMaskUsage(const Value: TLMDGlyphListMaskUsage);
  protected
    FDblClicked: Boolean;
    FNumGlyphs: Integer;
    FCursor: TCursor;
    FShadowsUseCustom : boolean;
    FShadowBtnHighlight,
    FShadowBtnShadow,
    FShadowBtnDkShadow : TColor;
    FBackground : TBitmap;
    FShadowFollowsColor : boolean;
    FDownBackground : TBitmap;
    FHotBackground: TBitmap;
    FBackgroundDrawBorder : boolean;
    FThinFrame : Boolean;
    FHotImages      : TCustomImageList;
    FAlphaHotImages : TCustomImageList;
    FAlphaDisabledImages : TCustomImageList;
    FAlphaDownImages: TCustomImageList;
    FAlphaImageList : TCustomImageList;
    FDisabledImages : TCustomImageList;
    FDownImages     : TCustomImageList;
    FImageList      : TCustomImageList;
    FOldStyled : Boolean;
    FUseImageList : boolean;
    FUseIcon : Boolean;

    FSoundMap : TElSoundMap;
    FDownSound : TElSoundName;
    FUpSound : TElSoundName;
    FClickSound : TElSoundName;
    FArrowClickSound : TElSoundName;

    FIsSwitch : Boolean;
    FShowGlyph : Boolean;
    FShowText : Boolean;
    FUseArrow : Boolean;
    FShowFocus : Boolean;
    FMultiLine : Boolean;
    FGroupIndex : Integer;
    FGlyph : TLMDButtonGlyph;
    FDown : Boolean;
    FArrDown : boolean;
    FInMenu,
    FIgnoreClick  : boolean;
    FDragging : Boolean;
    FAllowAllUp : Boolean;
    FLayout : TButtonLayout;
    FSpacing : Integer;
    FMargin : Integer;
    FFlat : Boolean;
    FMouseInArrow,
    FMouseInControl : Boolean;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FDisableAp : boolean;
    FPopupPlace : TPopupPlace;
    FDefault : Boolean;
    FCancel : Boolean;
    FActive : Boolean;
    FModalResult : TModalResult;
    FClicksDisabled : Boolean;
    FAChLink,
    FANChLink,
    FADChLink,
    FAHChLink,
    FChLink,
    FNChLink,
    FDChLink,
    FHChLink: TChangeLink;
    FFocusOnClick : Boolean;
    FPullDownMenu : TPopupMenu;
    FOnArrowClick : TNotifyEvent;
    FImgForm : TElImageForm;
    FImgFormChLink  : TImgFormChangeLink;
    FShowBorder   : boolean;
    FAdjustSpaceForGlyph: Boolean;
    FIsHTML  : Boolean;
    FRender  : TLMDHTMLRender;
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    FOrigState,
    FState : TLMDExButtonState;
    FDrawDefaultFrame: Boolean;
    FImageIsAlphaBlended: Boolean;
    FDrawFocusFrame: Boolean;
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;
    FTextRect: TRect;
    FChangeDisabledText: Boolean;
    FAlignment : TAlignment;
    FOldCapture : HWND;
    FIgnoreMouseDown: Boolean;

    FGlyphMaskUsage: TLMDGlyphListMaskUsage;

    procedure SetAlignment(Value: TAlignment);

    procedure SetIsHTML(Value: Boolean);

    procedure SetShowBorder(newValue : boolean);
    procedure ImageFormChange(Sender : TObject);
    procedure SetImageForm(newValue : TElImageForm);
    procedure SetPullDownMenu(newValue : TPopupMenu);
    procedure SetDefault(Value : Boolean);
    procedure SetPopupPlace(Value : TPopupPlace);
    procedure SetDisableAp(Value : boolean);
    procedure GlyphChanged(Sender : TObject);
    procedure UpdateExclusive;
    procedure SetHotBackground(const Value: TBitmap);
    function GetGlyph : TBitmap;
    procedure SetGlyph(Value : TBitmap);
    function GetPNGGlyph : TLMDPNGObject;
    procedure SetPNGGlyph(Value : TLMDPNGObject);
    procedure SetUsePng(const Value: boolean);
    function GetUsePng: Boolean;

    function GetNumGlyphs : TNumGlyphs;
    procedure SetNumGlyphs(Value : TNumGlyphs);
    procedure SetDown(Value : Boolean);
    procedure SetAllowAllUp(Value : Boolean);
    procedure SetGroupIndex(Value : Integer);
    procedure SetLayout(Value : TButtonLayout);
    procedure SetSpacing(Value : Integer);
    procedure SetMargin(Value : Integer);
    procedure UpdateTracking;
    procedure IntMouseEnter;
    procedure IntMouseLeave;
    procedure IntEnabledChanged;
    function IntKeyDown(var Key: Word; Shift: TShiftState) : boolean;
    procedure IntKeyUp(var Key: Word; Shift: TShiftState);
    procedure IntTextChanged;
    procedure CMMouseEnter(var Message : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message : TMessage); message CM_MOUSELEAVE;
    procedure CMEnter(var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;

    procedure WMKeyDown(var Message : TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Msg: TWMKeyUp); message WM_KEYUP;
    procedure WMLButtonDblClk(var Message : TWMLButtonDown); message WM_LBUTTONDBLCLK;
    procedure CMEnabledChanged(var Message : TMessage); message CM_ENABLEDCHANGED;
    procedure CMButtonPressed(var Message : TMessage); message CM_BUTTONPRESSED;
    procedure CMDialogChar(var Message : TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMDialogKey(var Message : TCMDialogKey); message CM_DIALOGKEY;
    procedure CMFontChanged(var Message : TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message : TMessage); message CM_TEXTCHANGED;
    procedure CMColorChanged(var Message : TMessage); message CM_COLORCHANGED;
    procedure CMSysColorChange(var Message : TMessage); message CM_SYSCOLORCHANGE;
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;

    procedure CMFocusChanged(var Message : TCMFocusChanged); message CM_FOCUSCHANGED;

    procedure CNCommand(var Message : TWMCommand); message CN_COMMAND;
    procedure SetShowFocus(newValue : Boolean);
    procedure SetShowGlyph(newValue : Boolean);
    procedure SetShowText(newValue : Boolean);
    function GetIcon : TIcon;
    procedure SetIcon(newValue : TIcon);
    procedure SetIsSwitch(newValue : Boolean);

    procedure SetSoundMap(newValue : TElSoundMap);

    procedure SetImageIndex(newValue : Integer);
    function GetImageIndex : integer;
    procedure SetUseIcon(newValue : Boolean);
    procedure SetImageList(newValue : TCustomImageList);
    procedure SetAlphaImageList(newValue: TCustomImageList);
    procedure SetUseImageList(newValue : Boolean);
    function GetUseImageList : boolean;
    procedure SetOldStyled(newValue : Boolean);
    procedure SetHotImages(newValue : TCustomImageList);
    procedure SetAlphaHotImages(newValue : TCustomImageList);
    procedure SetDownImages(newValue : TCustomImageList);
    procedure SetAlphaDownImages(newValue : TCustomImageList);
    procedure SetDisabledImages(newValue : TCustomImageList);
    procedure SetAlphaDisabledImages(newValue : TCustomImageList);
    procedure ImagesChanged(Sender : TObject);
    procedure SetThinFrame(newValue : Boolean);
    procedure SetBackground(newValue : TBitmap);
    procedure SetDownBackground(newValue : TBitmap);
    procedure SetBackgroundDrawBorder(Value : boolean);
    procedure SetShadowFollowsColor(Value : Boolean);
    procedure SetShadowsUseCustom(Value : Boolean);
    procedure SetShadowBtnHighlight(Value : TColor);
    procedure SetShadowBtnShadow(Value : TColor);
    procedure SetShadowBtnDkShadow(Value : TColor);
    procedure SetAdjustSpaceForGlyph(Value: Boolean);
    procedure SetLinkPopupMenu(newValue : TPopupMenu);
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
    procedure DoLinkPopup(MousePos : TPoint);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image
        : TBitmap);
    procedure TriggerLinkClickEvent(HRef : TLMDString); virtual;
    procedure SetUseArrow(newValue : boolean); virtual;

    function GetPalette : HPALETTE; override;
    procedure Loaded; override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState;
      X, Y : Integer); override;
    procedure MouseMove(Shift : TShiftState; X, Y : Integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState;
      X, Y : Integer); override;
    procedure Paint; override;
    procedure CreateParams(var Params : TCreateParams); override;
    procedure CreateWnd; override;
    procedure SetButtonStyle(ADefault : Boolean); virtual;
    procedure WndProc(var Message : TMessage); override;
    procedure SetFlat(Value : Boolean); virtual;
    function GetChecked : Boolean; override;
    procedure SetChecked(newValue : Boolean); override;

    function GetActionLinkClass : TControlActionLinkClass; override;
    procedure ActionChange(Sender : TObject; CheckDefaults : Boolean); override;

    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    property ClicksDisabled : Boolean read FClicksDisabled write FClicksDisabled;
    procedure Notification(AComponent : TComponent; operation : TOperation); override;

    procedure SetDrawDefaultFrame(Value: Boolean);
    function GetArrowSize: Integer; virtual;
    function DoSaveShadows: Boolean;
    procedure SetImageIsAlphaBlended(Value: Boolean);
    procedure SetDrawFocusFrame(Value: Boolean);
    procedure SetCursor(Value: TCursor); virtual;
    procedure SetChangeDisabledText(Value: Boolean);
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    property PullDownMenu : TPopupMenu read FPullDownMenu write SetPullDownMenu; { Published }
    property PopupPlace : TPopupPlace read FPopupPlace write SetPopupPlace default ppDown;
    property DisableAutoPopup : boolean read FDisableAp write SetDisableAp default false;
    property Cancel : Boolean read FCancel write FCancel default False;
    property Default : Boolean read FDefault write SetDefault default False;
    property ModalResult : TModalResult read FModalResult write FModalResult default 0;
    property AllowAllUp : Boolean read FAllowAllUp write SetAllowAllUp default False;
    property GroupIndex : Integer read FGroupIndex write SetGroupIndex default 0;
    property Down : Boolean read FDown write SetDown default False;
    property Flat : Boolean read FFlat write SetFlat default False;
    property Glyph : TBitmap read GetGlyph write SetGlyph;
    property PngGlyph: TLMDPNGObject read GetPngGlyph write SetPngGlyph;
    property UsePng: boolean read GetUsePng write SetUsePng default False;
    property Layout : TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Margin : Integer read FMargin write SetMargin default -1;
    property NumGlyphs : TNumGlyphs read GetNumGlyphs write SetNumGlyphs default 1;
    property Spacing : Integer read FSpacing write SetSpacing default 4;
    property ShowFocus : Boolean read FShowFocus write SetShowFocus default true;
    property UseArrow : Boolean read FUseArrow write SetUseArrow default False;
    property ShadowFollowsColor : boolean read FShadowFollowsColor write SetShadowFollowsColor default true;
    property ShowGlyph : Boolean read FShowGlyph write SetShowGlyph default true;
    property ShowText : Boolean read FShowText write SetShowText default true;
    property OnArrowClick : TNotifyEvent read FOnArrowClick write FOnArrowClick;
    property Icon : TIcon read GetIcon write SetIcon;
    property UseIcon : Boolean read FUseIcon write SetUseIcon default False;
    property IsSwitch : Boolean read FIsSwitch write SetIsSwitch default False;
    property FocusOnClick : Boolean read FFocusOnClick write FFocusOnClick default False;

    property DownSound : TElSoundName read FDownSound write FDownSound;
    property UpSound : TElSoundName read FUpSound write FUpSound;
    property ClickSound : TElSoundName read FClickSound write FClickSound; { Published }
    property ArrowClickSound : TElSoundName read FArrowClickSound write FArrowClickSound; { Published }
    property SoundMap : TElSoundMap read FSoundMap write SetSoundMap;

    property ImageIndex : Integer read GetImageIndex write SetImageIndex default -1;
    property Images : TCustomImageList read FImageList write SetImageList;
    property AlphaForImages : TCustomImageList read FAlphaImageList write SetAlphaImageList;
    property DownImages : TCustomImageList read FDownImages write SetDownImages;
    property AlphaForDownImages : TCustomImageList read FAlphaDownImages write SetAlphaDownImages;
    property HotImages : TCustomImageList read FHotImages write SetHotImages;
    property AlphaForHotImages : TCustomImageList read FAlphaHotImages write SetAlphaHotImages;
    property DisabledImages : TCustomImageList read FDisabledImages write SetDisabledImages;
    property AlphaForDisabledImages : TCustomImageList read FAlphaDisabledImages write SetAlphaDisabledImages;
    property ImageForm      : TElImageForm read FImgForm write SetImageForm;
    property ShowBorder     : boolean read FShowBorder write SetShowBorder default True;

    property ShadowsUseCustom  : boolean read FShadowsUseCustom write SetShadowsUseCustom default False;
    property ShadowBtnHighlight: TColor read FShadowBtnHighlight write SetShadowBtnHighlight stored DoSaveShadows;
    property ShadowBtnShadow   : TColor read FShadowBtnShadow write   SetShadowBtnShadow stored DoSaveShadows;
    property ShadowBtnDkShadow : TColor read FShadowBtnDkShadow write SetShadowBtnDkShadow stored DoSaveShadows;

    property UseImageList : Boolean read GetUseImageList write SetUseImageList default False;
    property OldStyled : Boolean read FOldStyled write SetOldStyled default False;
    property ThinFrame : Boolean read FThinFrame write SetThinFrame default False;
    property Background : TBitmap read FBackground write SetBackground;
    property DownBackground : TBitmap read FDownBackground write SetDownBackground;  { Protected }
    property HotBackground: TBitmap read FHotBackground write SetHotBackground;
    property BackgroundDrawBorder : boolean read FBackgroundDrawBorder write SetBackgroundDrawBorder default False;
    property AdjustSpaceForGlyph: Boolean read FAdjustSpaceForGlyph write
        SetAdjustSpaceForGlyph default true;
    property DrawDefaultFrame: Boolean read FDrawDefaultFrame write
        SetDrawDefaultFrame default True;
    property DrawFocusFrame: Boolean read FDrawFocusFrame write SetDrawFocusFrame
        default false;
    property ImageIsAlphaBlended: Boolean read FImageIsAlphaBlended write
        SetImageIsAlphaBlended default false;
    property ChangeDisabledText: Boolean read FChangeDisabledText write
        SetChangeDisabledText default true;

    property IsHTML : Boolean read FIsHTML write SetIsHTML default false;
    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write
        FOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write
        FOnLinkClick;
    property LinkColor: TColor read FLinkColor write SetLinkColor default clBlue;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle default [fsUnderline];
    property Cursor: TCursor read FCursor write SetCursor default crDefault;

    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property GlyphMaskUsage: TLMDGlyphListMaskUsage read FGlyphMaskUsage write SetGlyphMaskUsage default muGlyphList;

    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;


  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure AClick(Arrow : boolean); virtual;
    procedure Click; override;
    procedure ButtonClick; virtual;
    property MouseInControl : Boolean read FMouseInControl;
    property MouseInArrow : Boolean read FMouseInArrow;
    property ResizableButtonImage: Boolean read GetResizableButtonImage write SetResizableButtonImage;
  end;
  {$hints on}
  {$WARNINGS ON}

  TElPopupButton = class(TCustomElPopupButton)
  protected
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadImageIsAlphaBlended(Reader : TReader);
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    //    property ImageIsAlphaBlended;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property UsePng;
    property PngGlyph;
    property OnMouseEnter;
    property OnMouseLeave;
    property Alignment;
    property Background;
    property BackgroundDrawBorder;
    property DownBackground;
    property HotBackground;
    property ImageIndex;
    property UseImageList;
    property Images;
    property AlphaForImages;
    property AlphaForHotImages;
    property AlphaForDisabledImages;
    property AlphaForDownImages;
    property HotImages;
    property DisabledImages;
    property DrawDefaultFrame;
    property DrawFocusFrame;
    property PullDownMenu;
    property PopupPlace;
    property DisableAutoPopup;
    property Cancel;
    property Default;
    property ModalResult;
    property MoneyFlat;
    property MoneyFlatActiveColor;
    property MoneyFlatInactiveColor;
    property MoneyFlatDownColor;
    property AdjustSpaceForGlyph;
    property AllowAllUp;
    property GroupIndex;
    property GlyphMaskUsage;
    property Down;
    property Flat;
    property Glyph;
    property ImageForm;
    property IsHTML;

    property LinkColor;
    property LinkPopupMenu;
    property LinkStyle;
    property Layout;
    property Margin;

    property NumGlyphs;
    property ShadowFollowsColor;
    property ShadowsUseCustom;
    property ShadowBtnHighlight;
    property ShadowBtnShadow;
    property ShadowBtnDkShadow;

    property ShowFocus;
    property ShowGlyph;
    property ShowText;
    property Spacing;
    property UseArrow;
    property IsSwitch;
    property FocusOnClick;
    property OnArrowClick;
    property Icon;
    property UseIcon;
    property ThinFrame;
    property TextDrawType;
    property Transparent;

    property DownSound;
    property UpSound;
    property ClickSound;
    property ArrowClickSound;
    property SoundMap;

    property DownImages;
    property ShowBorder;
    property OldStyled;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;

    // VCL properties
    property Caption;
    property Cursor;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property HelpContext;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;

    property OnImageNeeded;
    property OnLinkClick;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;

    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation default doNoOrient;
    property Floating;
    property BevelKind;
    property DoubleBuffered default False;
    property DragKind;

    property OnStartDock;
    property OnEndDock;

    property OnContextPopup;
  end;

  TElPopupButtonActionLink = class(TElButtonActionlink)
  protected
    procedure SetImageIndex(Value: Integer); override;
    procedure SetChecked(Value : boolean); override;
    function IsCaptionLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
  end;

{$WARNINGS OFF}
  {$hints off}
  TCustomElGraphicButton = class(TElCustomGraphicControl)
  private
    procedure SetGlyphMaskUsage(const Value: TLMDGlyphListMaskUsage);
    procedure SetParentThemeMode(const Value: boolean);
  protected
    FDblClicked: Boolean;
    FCreating : integer;
    FNumGlyphs: Integer;
    FMenuWindowProc: TWndMethod;
    FCursor: TCursor;
    FShadowsUseCustom : boolean;
    FShadowBtnHighlight,
    FShadowBtnShadow,
    FShadowBtnDkShadow : TColor;
    FBackground : TBitmap;
    FShadowFollowsColor : boolean;
    FDownBackground : TBitmap;
    FBackgroundDrawBorder : boolean;
    FThinFrame : Boolean;
    FAlphaImageList,
    FAlphaHotImages,
    FAlphaDownImages,
    FAlphaDisabledImages,
    FHotImages,
    FDownImages,
    FDisabledImages,
    FImageList : TCustomImageList;
    FHotBackground: TBitmap;
    FOldStyled : Boolean;
    FUseImageList : boolean;
    FUseIcon : Boolean;

    FSoundMap : TElSoundMap;
    FDownSound : TElSoundName;
    FUpSound : TElSoundName;
    FClickSound : TElSoundName;
    FArrowClickSound : TElSoundName;

    FIsSwitch : Boolean;
    FShowGlyph: Boolean;
    FShowText : Boolean;
    FUseArrow : Boolean;
    FMultiLine : Boolean;
    FGroupIndex : Integer;
    FGlyph : TLMDButtonGlyph;
    FDown : Boolean;
    FArrDown : boolean;
    FInMenu,
    FIgnoreClick  : boolean;
    FDragging : Boolean;
    FAllowAllUp : Boolean;
    FLayout : TButtonLayout;
    FSpacing : Integer;
    FMargin : Integer;
    FFlat : Boolean;
    FMouseInArrow,
    FMouseInControl : Boolean;
    FDisableAp : boolean;
    FPopupPlace : TPopupPlace;
    FDefault : Boolean;
    FCancel : Boolean;
    FModalResult : TModalResult;
    FClicksDisabled : Boolean;
    FAChLink,
    FAHChLink,
    FANChLink,
    FADChLink,
    FChLink,
    FNChLink,
    FDChLink,
    FHChLink : TChangeLink;
    FPullDownMenu : TPopupMenu;
    FOnArrowClick : TNotifyEvent;
    FTransparent  : boolean;
    FTextDrawType : TLMDTextDrawType;
    FImgForm      : TElImageForm;
    FImgFormChLink  : TImgFormChangeLink;
    FStyleMgrLink : TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    FShowBorder   : boolean;
    FAdjustSpaceForGlyph: Boolean;
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;
    FIsHTML  : Boolean;
    FRender  : TLMDHTMLRender;
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    FWnd: HWND;
    FAlignment: TAlignment;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;

    FGlyphMaskUsage: TLMDGlyphListMaskUsage;

    procedure SetAlignment(Value: TAlignment);
    procedure SetIsHTML(Value: Boolean);
    function  IsColorStored : boolean;
    procedure SetShowBorder(newValue : boolean);
    procedure ImageFormChange(Sender : TObject);
    procedure SetImageForm(newValue : TElImageForm);
    procedure SetTransparent(newValue : Boolean); virtual;
    procedure SetTextDrawType(newValue : TLMDTextDrawType);
    procedure SetPullDownMenu(newValue : TPopupMenu);

    procedure SetPopupPlace(Value : TPopupPlace);
    procedure SetDisableAp(Value : boolean);
    procedure GlyphChanged(Sender : TObject);
    procedure UpdateExclusive;
    function GetGlyph : TBitmap;
    procedure SetGlyph(Value : TBitmap);
    function GetNumGlyphs : TNumGlyphs;
    procedure SetNumGlyphs(Value : TNumGlyphs);
    function GetPNGGlyph : TLMDPNGObject;
    procedure SetPNGGlyph(Value : TLMDPNGObject);
    procedure SetUsePng(const Value: boolean);
    function GetUsePng: Boolean;
    procedure SetDown(Value : Boolean);
    procedure SetAllowAllUp(Value : Boolean);
    procedure SetGroupIndex(Value : Integer);
    procedure SetLayout(Value : TButtonLayout); virtual;
    procedure SetSpacing(Value : Integer); virtual;
    procedure SetMargin(Value : Integer); virtual;
    procedure UpdateTracking;

    procedure IntMouseEnter;
    procedure IntMouseLeave;
    procedure IntEnabledChanged;
    procedure IntTextChanged;

    procedure WMLButtonDblClk(var Message : TWMLButtonDown); message WM_LBUTTONDBLCLK;
    procedure CMEnabledChanged(var Message : TMessage); message CM_ENABLEDCHANGED;
    procedure CMButtonPressed(var Message : TMessage); message CM_BUTTONPRESSED;
    procedure CMDialogKey(var Message : TCMDialogKey); message CM_DIALOGKEY;
    procedure CMDialogChar(var Message : TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message : TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message : TMessage); message CM_TEXTCHANGED;
    procedure CMColorChanged(var Message : TMessage); message CM_COLORCHANGED;
    procedure CMSysColorChange(var Message : TMessage); message CM_SYSCOLORCHANGE;
    procedure CMMouseEnter(var Message : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message : TMessage); message CM_MOUSELEAVE;
    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED; //(VB theme engine transition)
    procedure SetShowGlyph(newValue: Boolean); virtual;
    procedure SetShowText(newValue : Boolean); virtual;
    function GetIcon : TIcon;
    procedure SetIcon(newValue : TIcon);
    procedure SetIsSwitch(newValue : Boolean);

    procedure SetSoundMap(newValue : TElSoundMap);

    procedure SetImageIndex(newValue : Integer); virtual;
    function GetImageIndex : integer;
    procedure SetUseIcon(newValue : Boolean); virtual;
    procedure SetImageList(newValue : TCustomImageList); virtual;
    procedure SetAlphaImageList(newValue: TCustomImageList); virtual;
    procedure SetUseImageList(newValue : Boolean); virtual;
    function GetUseImageList : boolean;
    procedure SetOldStyled(newValue : Boolean);
    procedure SetDownImages(newValue : TCustomImageList);
    procedure SetAlphaDownImages(newValue : TCustomImageList);
    procedure SetHotImages(newValue : TCustomImageList);
    procedure SetAlphaHotImages(newValue : TCustomImageList);
    procedure SetDisabledImages(newValue : TCustomImageList);
    procedure SetAlphaDisabledImages(newValue : TCustomImageList);
    procedure ImagesChanged(Sender : TObject); virtual;
    procedure SetThinFrame(newValue : Boolean);
    procedure SetBackground(newValue : TBitmap);
    procedure SetDownBackground(newValue : TBitmap);
    procedure SetBackgroundDrawBorder(Value : boolean);
    procedure SetShadowFollowsColor(Value : Boolean);
    procedure SetShadowsUseCustom(Value : Boolean);
    procedure SetShadowBtnHighlight(Value : TColor);
    procedure SetShadowBtnShadow(Value : TColor);
    procedure SetShadowBtnDkShadow(Value : TColor);
    procedure SetAdjustSpaceForGlyph(Value: Boolean);

    procedure SetThemeGlobalMode(const Value: Boolean);
    procedure SetUseXPThemes(const Value: Boolean);
    procedure ReadUseXPThemes(Reader: TReader);
    procedure SetThemeMode(const Value: TLMDThemeMode); virtual;
    function GetUseXPThemes: Boolean;
    procedure DoThemeChanged; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure SetHotBackground(const Value: TBitmap);
  protected
    FParentThemeMode: boolean;
    FThemeGlobalMode: Boolean;
    FThemeMode: TLMDThemeMode;
    FOrigState,
    FState : TLMDExButtonState;
    FCaption: TLMDString;
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    FMoneyFlat: Boolean;
    FMoneyFlatDownColor: TColor;
    FMoneyFlatActiveColor: TColor;
    FMoneyFlatInactiveColor: TColor;
    FShortcutsEnabled: Boolean;
    FImageIsAlphaBlended: Boolean;
    FTextRect: TRect;
    FChangeDisabledText: Boolean;

    procedure SetLinkPopupMenu(newValue : TPopupMenu);
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
    procedure DoLinkPopup(MousePos : TPoint);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image: TBitmap);
    procedure TriggerLinkClickEvent(HRef : TLMDString); virtual;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure SetUseArrow(newValue : boolean); virtual;
    function GetPalette : HPALETTE; override;
    procedure Loaded; override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState;
      X, Y : Integer); override;
    procedure MouseMove(Shift : TShiftState; X, Y : Integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState;
      X, Y : Integer); override;
    procedure Paint; override;
    procedure WndProc(var Message : TMessage); override;
    procedure SetFlat(Value : Boolean); virtual;
    function GetChecked : Boolean; virtual;
    procedure SetChecked(newValue : Boolean); virtual;

    function GetActionLinkClass : TControlActionLinkClass; override;
    procedure ActionChange(Sender : TObject; CheckDefaults : Boolean); override;

    function DoSaveShadows : boolean;

    {$ifdef LMD_UNICODE}
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    {$endif}

    procedure Notification(AComponent : TComponent; operation : TOperation); override;

    procedure SetCaption(Value: TLMDString);
    procedure IFMRepaintChildren(var Message: TMessage); message IFM_REPAINTCHILDREN;
    function GetDetails: TThemedElementDetails; virtual;
    function GetTextDetails: TThemedElementDetails; virtual;
    function GetArrowDetails: TThemedElementDetails; virtual;
    function GetArrowSize: Integer; virtual;

    procedure DrawThemedBackground(Canvas : TCanvas); virtual;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    function MeasureButton(LockHeight : boolean): TPoint; virtual;

    procedure SetMoneyFlat(Value: Boolean);
    procedure SetMoneyFlatDownColor(Value: TColor);
    procedure SetMoneyFlatActiveColor(Value: TColor);
    procedure SetMoneyFlatInactiveColor(Value: TColor);
    function GetMoneyFlat: Boolean;

    procedure IntWndProc(var Message : TMessage);
    procedure DoPullMenu; virtual;
    procedure SetShortcutsEnabled(Value: Boolean);
    function Focused: Boolean; virtual;
    procedure SetImageIsAlphaBlended(Value: Boolean);
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    {$endif}
    procedure SetCursor(Value: TCursor); virtual;
    procedure SetChangeDisabledText(Value: Boolean);
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure StyleMgrChange(Sender : TObject);
    procedure UpdateStyle;

    function GetShowGlyph: Boolean; virtual;
    procedure DoClick; virtual;
    procedure BeginCreate;
    procedure EndCreate;

    function UseThemeMode: TLMDThemeMode;
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    //new V9
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;

    property ClicksDisabled : Boolean read FClicksDisabled write FClicksDisabled;
    property PullDownMenu : TPopupMenu read FPullDownMenu write SetPullDownMenu; { Published }
    property PopupPlace : TPopupPlace read FPopupPlace write SetPopupPlace default ppDown;
    property DisableAutoPopup : boolean read FDisableAp write SetDisableAp default false;
    property Cancel : Boolean read FCancel write FCancel default False;
    property ModalResult : TModalResult read FModalResult write FModalResult default 0;
    property AllowAllUp : Boolean read FAllowAllUp write SetAllowAllUp default False;
    property GroupIndex : Integer read FGroupIndex write SetGroupIndex default 0;
    property Down : Boolean read FDown write SetDown default False;
    property Flat : Boolean read FFlat write SetFlat default false;
    property Glyph : TBitmap read GetGlyph write SetGlyph;
    property Layout : TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Margin : Integer read FMargin write SetMargin default -1;
    property NumGlyphs : TNumGlyphs read GetNumGlyphs write SetNumGlyphs default 1;
    property Spacing : Integer read FSpacing write SetSpacing default 4;
    property PngGlyph: TLMDPNGObject read GetPngGlyph write SetPngGlyph;
    property UsePng: boolean read GetUsePng write SetUsePng default False;
    property UseArrow : Boolean read FUseArrow write SetUseArrow default False;
    property ShadowFollowsColor : boolean read FShadowFollowsColor write SetShadowFollowsColor default true;
    property ShowGlyph: Boolean read GetShowGlyph write SetShowGlyph default true;
    property ShowText : Boolean read FShowText write SetShowText default true;
    property OnArrowClick : TNotifyEvent read FOnArrowClick write FOnArrowClick;
    property Icon : TIcon read GetIcon write SetIcon;
    property UseIcon : Boolean read FUseIcon write SetUseIcon default false; { Protected }
    property IsSwitch : Boolean read FIsSwitch write SetIsSwitch default false;

    property DownSound : TElSoundName read FDownSound write FDownSound; { Published }
    property UpSound : TElSoundName read FUpSound write FUpSound; { Published }
    property ClickSound : TElSoundName read FClickSound write FClickSound; { Published }
    property ArrowClickSound : TElSoundName read FArrowClickSound write FArrowClickSound; { Published }
    property SoundMap : TElSoundMap read FSoundMap write SetSoundMap;

    property ImageIndex : Integer read GetImageIndex write SetImageIndex default -1;
    property Images : TCustomImageList read FImageList write SetImageList;
    property AlphaForImages: TCustomImageList read FAlphaImageList write SetAlphaImageList;
    property AlphaForHotImages : TCustomImageList read FAlphaHotImages write SetAlphaHotImages;
    property AlphaForDisabledImages : TCustomImageList read FAlphaDisabledImages write SetAlphaDisabledImages;
    property AlphaForDownImages : TCustomImageList read FAlphaDownImages write SetAlphaDownImages;
    property HotImages : TCustomImageList read FHotImages write SetHotImages;
    property DisabledImages : TCustomImageList read FDisabledImages write SetDisabledImages;
    property DownImages     : TCustomImageList read FDownImages write SetDownImages;
    property ImageForm      : TElImageForm read FImgForm write SetImageForm;
    property ShowBorder     : boolean read FShowBorder write SetShowBorder default true;

    property ShadowsUseCustom  : boolean read FShadowsUseCustom write SetShadowsUseCustom default false;
    property ShadowBtnHighlight: TColor read FShadowBtnHighlight write SetShadowBtnHighlight stored DoSaveShadows default $00F7F7F5;
    property ShadowBtnShadow   : TColor read FShadowBtnShadow write   SetShadowBtnShadow stored DoSaveShadows default $00767A60;
    property ShadowBtnDkShadow : TColor read FShadowBtnDkShadow write SetShadowBtnDkShadow stored DoSaveShadows default $00595C48;

    property UseImageList : Boolean read GetUseImageList write SetUseImageList default false; { Protected }
    property OldStyled : Boolean read FOldStyled write SetOldStyled default false; { Protected }
    property ThinFrame : Boolean read FThinFrame write SetThinFrame default false;  { Protected }
    property Background : TBitmap read FBackground write SetBackground;  { Protected }
    property DownBackground : TBitmap read FDownBackground write SetDownBackground;  { Protected }
    property HotBackground: TBitmap read FHotBackground write SetHotBackground;
    property BackgroundDrawBorder : boolean read FBackgroundDrawBorder write SetBackgroundDrawBorder default false;
    property Transparent : boolean read FTransparent write SetTransparent default false;
    property TextDrawType : TLMDTextDrawType read FTextDrawType write SetTextDrawType default tdtNormal; { Published }
    property Checked : Boolean read GetChecked write SetChecked default false; { Protected }
    property Color stored IsColorStored nodefault;
    property AdjustSpaceForGlyph: Boolean read FAdjustSpaceForGlyph write
        SetAdjustSpaceForGlyph default true;
    property Caption: TLMDString read FCaption write SetCaption;
    property MoneyFlat: Boolean read GetMoneyFlat write SetMoneyFlat default false;
    property MoneyFlatDownColor: TColor read FMoneyFlatDownColor write
        SetMoneyFlatDownColor stored GetMoneyFlat;
    property MoneyFlatActiveColor: TColor read FMoneyFlatActiveColor write
        SetMoneyFlatActiveColor  stored GetMoneyFlat;
    property MoneyFlatInactiveColor: TColor read FMoneyFlatInactiveColor write
        SetMoneyFlatInactiveColor  stored GetMoneyFlat;
    property ImageIsAlphaBlended: Boolean read FImageIsAlphaBlended write
        SetImageIsAlphaBlended default false;
    property ChangeDisabledText: Boolean read FChangeDisabledText write
        SetChangeDisabledText default true;
    property Alignment: TAlignment read FAlignment write SetAlignment default
        taCenter;

    property IsHTML : Boolean read FIsHTML write SetIsHTML default false;

    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write
        FOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write
        FOnLinkClick;
    property LinkColor: TColor read FLinkColor write SetLinkColor default clBlue;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle default [fsUnderline];
    property Cursor: TCursor read FCursor write SetCursor default crDefault;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function IsThemed: Boolean;
    procedure AClick(Arrow : boolean); virtual;
    procedure Click; override;
    procedure ButtonClick; virtual;
    property MouseInControl : Boolean read FMouseInControl;
    property MouseInArrow : Boolean read FMouseInArrow;
    property MenuWindowProc: TWndMethod read FMenuWindowProc write FMenuWindowProc;
    property ShortcutsEnabled: Boolean read FShortcutsEnabled write
        SetShortcutsEnabled default false;

    property GlyphMaskUsage: TLMDGlyphListMaskUsage read FGlyphMaskUsage write SetGlyphMaskUsage default muGlyphList;

  published
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
  end;
  {$hints on}
{$WARNINGS ON}

  TCustomElGraphicButtonClass = class of TCustomElGraphicButton;

  TElGraphicButton = class(TCustomElGraphicButton)
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadImageIsAlphaBlended(Reader : TReader);
  public
    property UseXPThemes;
    constructor Create(aOwner: TComponent); override;
  published
    property GlyphMaskUsage;
    property UsePng;
    property PngGlyph;
    property OnMouseEnter;
    property OnMouseLeave;
    property Alignment;
    property Background;
    property BackgroundDrawBorder;
    property DownBackground;
    property HotBackground;
//    property ImageIsAlphaBlended;
    property ImageIndex;
    property UseImageList;
    property Images;
    property HotImages;
    property DisabledImages;
    property AlphaForImages;
    property AlphaForHotImages;
    property AlphaForDisabledImages;
    property AlphaForDownImages;
    property PullDownMenu;
    property PopupPlace;
    property DisableAutoPopup;
    property Cancel;
    property ChangeDisabledText;

    property ModalResult;

    property MoneyFlat;
    property MoneyFlatInactiveColor;
    property MoneyFlatActiveColor;
    property MoneyFlatDownColor;

    property AdjustSpaceForGlyph;
    property AllowAllUp;
    property GroupIndex;
    property Down;
    property Flat;
    property Glyph;
    property ImageForm;
    property IsHTML;

    property Layout;

    property Margin;
    property NumGlyphs;
    property ShadowFollowsColor;
    property ShadowsUseCustom;
    property ShadowBtnHighlight;
    property ShadowBtnShadow;
    property ShadowBtnDkShadow;

    property ShowGlyph;
    property ShowText;
    property Spacing;
    property UseArrow;
    property IsSwitch;
    property OnArrowClick;
    property Icon;
    property LinkColor;
    property LinkPopupMenu;
    property LinkStyle;
    property UseIcon;
    property ThinFrame;
    property TextDrawType;
    property Transparent;

    property DownSound;
    property UpSound;
    property ClickSound;
    property ArrowClickSound;
    property SoundMap;

    property DownImages;
    property ShowBorder;
    property ShortcutsEnabled;
    property OldStyled;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;
    // VCL properties
    property Caption;
    property Cursor;
    property Enabled;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnImageNeeded;
    property OnLinkClick;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;

    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation default doNoOrient;
    property Floating;
    property DragKind;

    property OnStartDock;
    property OnEndDock;

    property OnContextPopup;

  end;

  TElGraphicButtonActionLink = class(TControlActionLink)
  protected
    FClient : TCustomElGraphicButton;
    procedure AssignClient(AClient : TObject); override;
    function IsCheckedLinked : Boolean; override;
    function IsImageIndexLinked : Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsCaptionLinked: Boolean; override;

    procedure SetImageIndex(Value: Integer); override;
    procedure SetChecked(Value : Boolean); override;
    procedure SetCaption(const Value: string); override;
    procedure SetHint(const Value: string); override;
    public
  end;

var
  MenuCancelMsg : Cardinal;

function GetMenuHandle(AMenu : TMenu) : HMENU;

implementation
uses
  ElMenus ,
  uxTheme,
  ElXPThemedControl;

function GetMenuHandle(AMenu : TMenu) : HMENU;
begin

  if AMenu is TElPopupMenu then
  begin
    result := TElPopupMenu(AMenu).Handle
  end
  else
  if AMenu is TElMainMenu then
  begin
    result := TElMainMenu(AMenu).Handle
  end
  else
    result := AMenu.Handle;
end;

type
TProxyGlyph = class(TLMDButtonGlyph)

end;

// =============================================================================

procedure TElPopupButton.MouseDown;
begin
  inherited;
end;

procedure TElPopupButton.ReadImageIsAlphaBlended(Reader : TReader);
begin
  Reader.ReadBoolean;
end;

constructor TElPopupButton.Create(AOwner: TComponent);
begin
  inherited;
  FParentThemeMode := true;
end;

procedure TElPopupButton.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ImageIsAlphaBlended', ReadImageIsAlphaBlended, nil, false);
end;

procedure TElPopupButton.WMMouseActivate(var Message: TWMMouseActivate);
begin
//  Message.Result := MA_ACTIVATE;
  (*
  try
    if CanFocus and TabStop then
    begin
      SetFocus;
      if GetFocus <> Handle then
        FIgnoreMouseDown := true;
    end;
  except
  end;
  *)
  inherited;
end;

// =============================================================================

procedure TElGraphicButton.ReadImageIsAlphaBlended(Reader : TReader);
begin
  Reader.ReadBoolean;
end;

constructor TElGraphicButton.Create(aOwner: TComponent);
begin
  inherited;
  FParentThemeMode := true;
end;

procedure TElGraphicButton.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ImageIsAlphaBlended', ReadImageIsAlphaBlended, nil, false);
end;

// =============================================================================

function TCustomElPopupButton.GetChecked : Boolean;
begin
  result := Down;
end;

procedure TCustomElPopupButton.SetChecked(newValue : Boolean);
begin
  Down := newValue;
end;

procedure TCustomElPopupButton.SetDefault(Value : Boolean);
var
  Form : TCustomForm;
begin
  if FDefault <> Value then
  begin
    FDefault := Value;
    if HandleAllocated then
    begin
      Form := GetParentForm(Self);
      if Form <> nil then
      Form.Perform(CM_FOCUSCHANGED, 0, TLMDPtrUInt(Form.ActiveControl));
      end;
    if DrawDefaultFrame then
      Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetPopupPlace(Value : TPopupPlace);
begin
  FPopupPlace := Value;
end;

procedure TCustomElPopupButton.SetDisableAp(Value : boolean);
begin
  FDisableAp := Value;
end;

procedure TCustomElPopupButton.Paint;
var
  PaintRect, R,

  R1, BgRect : TRect;
  ACtl   : TWinControl;
  ax, ay, dx : integer;
  GlRect, ArrRect    : TRect;
  Offset     : TPoint;
  dw : integer;
  aw : integer;
  AColor : TColor;
  OldP,
  P      : TPoint;
  SaveIL : TCustomImageList;
  SaveAIL : TCustomImageList;
  GlyphState : TLMDExButtonState;
  RClip   : TRect;
  Canvas  : TCanvas;
  Bitmap  : TBitmap;
  b: Boolean;
  LThemeMode : TLMDThemeMode;
  LDetail: TThemedButton;
  LArrDetail: TThemedButton;
  lFlag1, lFlag2: cardinal;

  procedure DrawButtonFrameEx(DC : HDC; rc : TRect; Focused : boolean; Pushed : boolean; ButtonColor : TColor; Thin : boolean);
  begin
    if ShadowsUseCustom then
       ElVCLUtils.DrawButtonFrameEx2(DC, rc, Focused, Pushed, ButtonColor, Thin,
         ColorToRGB(FShadowBtnHighlight), ColorToRGB(FShadowBtnDkShadow), ColorToRGB(Color), ColorToRGB(FShadowBtnShadow), AllBorderSides)
    else
       ElVCLUtils.DrawButtonFrameEx3(DC, rc, Focused, Pushed, ButtonColor, Thin, AllBorderSides);
  end;

  procedure DrawButtonBackgroundImage( BMP: TBitmap);
  var
    Img : TImage;
  begin
    Img := TImage.Create(self);
    try
      Img.Transparent := BMP.Transparent;
      Img.AutoSize := false;
      Img.Stretch := True;
      Img.Width := Width;
      Img.Height := Height;
      Img.Picture.Assign(Bmp);
      Canvas.StretchDraw(Rect(0, 0, Width, Height),Img.Picture.Bitmap);
    finally
      Img.Free;
    End;
  end;

begin
  LDetail := tbPushButtonNormal;
  SaveIL := nil;
  SaveAIL := nil;
  Bitmap := Tbitmap.Create;
  Bitmap.Handle := CreateCompatibleBitmap(Self.Canvas.Handle, ClientWidth, ClientHeight);
  Canvas := Bitmap.Canvas;
  bitblt(Bitmap.Canvas.Handle, 0, 0, Bitmap.Width, Bitmap.Height, Self.Canvas.Handle, 0, 0, SRCCOPY);
  LThemeMode := UseThemeMode;

  if Assigned(Parent) and (LThemeMode <> ttmNone) and ([csDesigning] * ComponentState = []) then
    begin
      //DrawThemeParentBackground(Handle, Self.Canvas.Handle, ClientRect);
      P := Point(Left, Top);
      SetMapMode(Bitmap.Canvas.Handle, MM_ANISOTROPIC);
      SetViewPortOrgEx(Bitmap.Canvas.Handle, -P.x, -P.y, @OldP);
      SendMessage(Parent.Handle, WM_ERASEBKGND, Bitmap.Canvas.Handle, Bitmap.Canvas.Handle);
      SetViewPortOrgEx(Bitmap.Canvas.Handle, OldP.x, OldP.y, nil);
      SetMapMode(Bitmap.Canvas.Handle, MM_TEXT);
    end;

  if (not Enabled) or (Assigned(Parent) and (not Parent.Enabled)) then
    begin
      FState := ebsDisabled;
      FDragging := False;
    end
  else
    if FState = ebsDisabled then
      if FDown and (GroupIndex <> 0) then
        FState := ebsExclusive
      else
        FState := ebsUp;
  Canvas.Font := Self.Font;
  PaintRect := ClientRect;

  if FShadowFollowsColor then
    AColor := Color
  else
    AColor := clBtnFace;

  if LThemeMode = ttmNone then
    begin
      if not Transparent then
        begin
          if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
            begin
              if (FImgForm.Control <> Self) then
                begin
                  ACtl := FImgForm.GetRealControl;
                  R1 := PaintRect;
                  BgRect := R1;
                  BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
                  P := Parent.ClientToScreen(Point(Left, Top));
                  ax := BgRect.Left - P.x;
                  ay := BgRect.Top - P.y;

                  BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
                  BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
                  BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
                  FImgForm.PaintBkgnd(Canvas.Handle, R1, Point(BgRect.Left - ax, BgRect.Top - ay), false);
                end
            end;
          begin  // ??
            Canvas.Brush.Color := Color;
            if (FMouseInControl) and ((not FDown) and (not (FState in [ebsDown, ebsExclusive]))) then
            begin
              if (not FHotBackground.Empty) then
                DrawButtonBackgroundImage(FHotBackground)
              else
                if (FImgForm = nil) or (csDesigning in FImgForm.GetRealControl.ComponentState) then
                  Canvas.FillRect(PaintRect);
            end
            else if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) then
              begin
                if (not FDownBackground.Empty) then
                  begin
                    //Canvas.CopyRect(ClientRect, DownBackground.Canvas, Rect(0, 0, DownBackground.Width, DownBackground.Height))
                    DrawButtonBackgroundImage(DownBackground);
                  end
                else
                  if (FImgForm = nil) or (csDesigning in FImgForm.GetRealControl.ComponentState) then
                    Canvas.FillRect(PaintRect);
              end
            else
              begin
                if (not Background.Empty) then
                  //Canvas.CopyRect(ClientRect, Background.Canvas, Rect(0, 0, Background.Width, Background.Height))
                  DrawButtonBackgroundImage(Background)
                else
                  if (FImgForm = nil) or (csDesigning in FImgForm.GetRealControl.ComponentState) then
                    Canvas.FillRect(PaintRect);
              end;
          end;
        end
      else
        begin
          GetClipBox(Self.Canvas.Handle, PaintRect);
          OffsetRect(PaintRect, Left, Top);
          RedrawWindow(Parent.Handle, @PaintRect, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);
          OffsetRect(PaintRect, -Left, -Top);
          bitblt(Canvas.Handle, PaintRect.Left, PaintRect.Top, PaintRect.Right - PaintRect.Left, PaintRect.Bottom - PaintRect.Top, Self.Canvas.Handle, PaintRect.Left, PaintRect.Top, SRCCOPY);
        end;
      PaintRect := ClientRect;
    end;

  dw := 0;
  dx := 4;
  aw := 0;

  if (LThemeMode = ttmNone) and ((Default and DrawDefaultFrame) or (Focused and DrawFocusFrame)) then
    begin
      if FUseArrow then
        begin
          dw := GetArrowSize;
          aw := dw;
          Dec(PaintRect.Right, dw);
        end;

      if MoneyFlat then
        begin
          if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
            Canvas.Brush.Color := MoneyFlatDownColor
          else
          if (FMouseInControl or FMouseInArrow) and (FState <> ebsDisabled) then
            Canvas.Brush.Color := MoneyFlatActiveColor
          else
            Canvas.Brush.Color := MoneyFlatInactiveColor;
          Canvas.FrameRect(PaintRect);
          PaintRect := ClientRect;
          if not FUseArrow then
            InflateRect(PaintRect, -1, -1);
        end
      else
        begin
          if not OldStyled then
            Canvas.Brush.Color := clBtnShadow
          else
            Canvas.Brush.Color := cl3DDkShadow;
           Canvas.FrameRect(PaintRect);
          PaintRect := ClientRect;
          if not FUseArrow then
            InflateRect(PaintRect, -1, -1);
        end;
    end;

  if (LThemeMode = ttmNone) then
    begin
      if not FFlat then
        begin
          if FUseArrow then
            begin
              dw := GetArrowSize;
              aw := dw;
              Dec(PaintRect.Right, dw);
            end;
          if ((Background.Empty) or (BackgroundDrawBorder)) and (ShowBorder or (csDesigning in ComponentState)) then
            begin
              if MoneyFlat then
                begin
                  if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
                    Canvas.Brush.Color := MoneyFlatDownColor
                  else
                  if (FMouseInControl or FMouseInArrow) and (FState <> ebsDisabled) then
                    Canvas.Brush.Color := MoneyFlatActiveColor
                  else
                    Canvas.Brush.Color := MoneyFlatInactiveColor;
                  Canvas.FrameRect(PaintRect);
                end
              else
                begin
                  if OldStyled or ((FMouseInControl or Focused) and
                     (not ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])))) then
                     DrawButtonFrameEx(Canvas.Handle, PaintRect, (not ThinFrame),
                                     (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]), AColor, ThinFrame)
                  else
                     DrawButtonFrameEx(Canvas.Handle, PaintRect, FOldStyled,
                                     (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]), AColor, ThinFrame);
                end;
            end;
        end
      else
        begin
          if FUseArrow then
            begin
              dw := GetArrowSize;
              aw := dw;
              Dec(PaintRect.Right, dw);
            end;
          if MoneyFlat then
            begin
              if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
                Canvas.Brush.Color := MoneyFlatDownColor
              else
                if (FMouseInControl or FMouseInArrow) and (FState <> ebsDisabled) then
                  Canvas.Brush.Color := MoneyFlatActiveColor
                else
                  Canvas.Brush.Color := MoneyFlatInactiveColor;
              Canvas.FrameRect(PaintRect);
            end
          else
          begin
            if (FDown and FIsSwitch) or (FState in [ebsDown, {ebsArrDown, }ebsExclusive]) or
              ((FMouseInControl or FMouseInArrow) and (FState <> ebsDisabled)) or Focused or
              (csDesigning in ComponentState) then
              begin
                if ((Background.Empty) or (BackgroundDrawBorder)) and ShowBorder then
                     DrawButtonFrameEx(Canvas.Handle, PaintRect, false, //OldStyled or ((FMouseInControl or Focused)) and (not ThinFrame),
                                     (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]), AColor, true{ThinFrame});
              end;
          end;
        end;

      // draw the rectangle for the arrow
      if FUseArrow then
        begin
          if dw = 0 then
            begin
              dw := GetArrowSize;
              Dec(PaintRect.Right, dw);
            end;
          ArrRect := Rect(PaintRect.Right, 0, PaintRect.Right + dw, Height);
          if Default and DrawDefaultFrame then
            InflateRect(ArrRect, 0, -1);
          Canvas.Brush.Color := Color;
          if ((Background.Empty) or (BackgroundDrawBorder)) and FShowBorder then
          begin
            if MoneyFlat then
              begin
                if (FState in [ebsDown, ebsArrDown]) then
                  Canvas.Brush.Color := MoneyFlatDownColor
                else
                if (FMouseInControl or FMouseInArrow) and (FState <> ebsDisabled) then
                  Canvas.Brush.Color := MoneyFlatActiveColor
                else
                  Canvas.Brush.Color := MoneyFlatInactiveColor;
                Canvas.FrameRect(ArrRect);
              end
            else
              begin
                if ((not FFlat) or ((FMouseInControl or FMouseInArrow) or
                    (FState in [ebsArrDown, ebsExclusive])
                     or (csDesigning in ComponentState))) then
                     begin
                       b := (FMouseInArrow or FOldStyled) and (not(FThinFrame or FDown));
                       DrawButtonFrameEx(Canvas.Handle, ArrRect, (b), (FState in [ebsDown, ebsArrDown]), AColor, ThinFrame);
       //           DrawButtonFrameEx(Canvas.Handle, ArrRect, (FMouseInArrow or FOldStyled) and (not FThinFrame) and (not FDown), (FState in [ebsDown, ebsArrDown]), AColor, ThinFrame);
                     end;
              end;
          end;
          LMDDrawArrow(Canvas, eadDown, ArrRect, Font.Color, FState <> ebsDisabled);
        end;
    end
  else
    begin
      //DrawThemeBackground(Theme, Canvas.Handle, BP_PUSHBUTTON, 0, PaintRect, nil);
      if not Enabled then
        LDetail := tbPushButtonDisabled
      else
        if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
          LDetail := tbPushButtonPressed
        else
          if FMouseInControl or FMouseInArrow then
            LDetail := tbPushButtonHot
          else
            if (Default and DrawDefaultFrame) or Focused then
              LDetail := tbPushButtonDefaulted
            else
              LDetail := tbPushButtonNormal;
      if FUseArrow then
        begin
          dw := GetArrowSize;
          aw := dw;
          //Dec(PaintRect.Right, dw);
        end;
      RClip := Canvas.ClipRect;
      LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail, PaintRect, LMDRectToPtr(RClip));

      if FUseArrow then
        begin
          RClip := Canvas.ClipRect;
          if not Enabled then
            LArrDetail := tbPushButtonDisabled
          else
            if FState in [ebsArrDown, ebsExclusive] then
              LArrDetail := tbPushButtonPressed
            else
              if FMouseInControl or FMouseInArrow then
                LArrDetail := tbPushButtonHot
              else
                LArrDetail := tbPushButtonNormal;

          RClip := PaintRect;
          RClip.Left := PaintRect.Right - dw;
          if FMouseInArrow then
            LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LArrDetail, PaintRect, LMDRectToPtr(RClip));

          ArrRect := Rect(PaintRect.Right - dw, PaintRect.Top, PaintRect.Right - dx, PaintRect.Bottom);
          InflateREct(ArrRect, 0, -dx);
          if LArrDetail = tbPushButtonDisabled then
            begin
              lFlag1 := BDR_SUNKENINNER;
              lFlag2 := BF_LEFT or BF_SOFT;
            end
          else
            begin
              lFlag1 := BDR_SUNKENOUTER;
              lFlag2 := BF_LEFT or BF_SOFT;
            end;

          LMDThemeServices.DrawThemeEdge(lThemeMode, Canvas.Handle, teToolBar, TP_BUTTON, TS_HOT, ArrRect,
            lFlag1, lFlag2, LMDRectToPtr(ArrRect));
          LMDDrawArrow(Canvas, eadDown, ArrRect, Font.Color, FState <> ebsDisabled);
        end;
    end;

  Offset.x := 0;
  Offset.y := 0;

  if (FState in [ebsDown, ebsExclusive]) or (FDown and FIsSwitch) then
    begin
      if (FState = ebsExclusive) or
         (UseImageList and ((DownImages = nil) or (DownImages = Images))) or
         (UseIcon) or
         ((not UseImageList) {and (UseIcon)} and (NumGlyphs < 2)) then
        begin
          Offset.X := 1;
          Offset.Y := 1;
        end;
    end;

  if not (Layout = blGlyphRight) then
    inc(PaintRect.Right, dw);

  if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (FDownImages <> nil) then
    begin
      SaveIL := TProxyGlyph(FGlyph).ImageList;
      SaveAIL := TProxyGlyph(FGlyph).AlphaImageList;
      TProxyGlyph(FGlyph).ImageList := FDownImages;
      TProxyGlyph(FGlyph).AlphaImageList := FAlphaDownImages;
    end;

  if (TProxyGlyph(FGlyph).ImageList = Self.FDisabledImages) and (FDisabledImages <> nil) and (FState = ebsDisabled) then
    GlyphState := ebsUp
  else
    GlyphState := FState;

  if AdjustSpaceForGlyph then
    begin
      if (not FThinFrame) or IsThemed then
        InflateRect(PaintRect, -2, -2)
      else
        InflateRect(PaintRect, -1, -1);
    end;
  if FShowFocus then
    InflateRect(PaintRect, -2, -2);
  if IsHTML then
    begin
      FRender.Data.DefaultColor := Font.Color;
      FRender.Data.DefaultBgColor := clNone;
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.LinkColor := LinkColor;
      FRender.Data.LinkStyle := LinkStyle;
      FRender.Data.Charset := Font.Charset;
    end;

  GlRect := PaintRect;
  if FUseArrow and (ThemeMode <> ttmNone) then
    GlRect.Right := GlRect.Right - dw;

  if (not ParentFont) then
    FTextRect := FGlyph.Draw(Canvas, GlRect, Offset, Caption, FLayout, FMargin,
                 FSpacing, FState, GlyphState, Alignment, true, FMultiline, (Focused and FShowFocus), FShowGlyph,
                 FShowText, Aw, TextDrawType, Color, ttmNone, ThemeServices.GetElementDetails(LDetail), true, ImageIsAlphaBlended, IsHTML, FRender, FChangeDisabledText, GlyphMaskUsage)
  else
    FTextRect := FGlyph.Draw(Canvas, GlRect, Offset, Caption, FLayout, FMargin,
                 FSpacing, FState, GlyphState, Alignment, true, FMultiline, (Focused and FShowFocus), FShowGlyph,
                 FShowText, Aw, TextDrawType, Color, LThemeMode, ThemeServices.GetElementDetails(LDetail), true, ImageIsAlphaBlended, IsHTML, FRender, FChangeDisabledText, GlyphMaskUsage);

  if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (FDownImages <> nil) then
    begin
      TProxyGlyph(FGlyph).ImageList := SaveIL;
      TProxyGlyph(FGlyph).AlphaImageList := SaveAIL;
    end;
  if (Focused and FShowFocus) then
    begin
      R := PaintRect;
      dec(R.right, dw);
      InflateRect(R, 1, 1);
      Canvas.Pen.Color := clWindowFrame;
      Canvas.Brush.Color := clBtnFace;
      DrawFocusRect(Canvas.Handle, R);
    end;

  bitblt(Self.Canvas.Handle, 0, 0, ClientWidth, ClientHeight, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
  Bitmap.Free;
end;

{$HINTS OFF}
procedure TCustomElPopupButton.AClick;
var
  q : TPoint;
  i : THandle;
var
  Form : TCustomForm;

const
  Buttons: array[TTrackButton] of Word = (TPM_RIGHTBUTTON, TPM_LEFTBUTTON);

begin
  Form := GetParentForm(Self);
  if Form <> nil then Form.ModalResult := ModalResult;
  if Arrow then
  begin

    if SoundMap <> nil then SoundMap.Play(ArrowClickSound);

    if Assigned(FOnArrowClick) then FOnArrowClick(Self);
  end
  else
  begin

    if SoundMap <> nil then SoundMap.Play(ClickSound);

    inherited Click;
    //FMouseInControl := false;
    Invalidate;
  end;
  if (PullDownMenu = nil) or (FDisableAp) or ((not Arrow) and FUseArrow) then
  begin
    //FState := ebsUp;
    //FMouseInArrow := false;
    //FMouseInControl := false;
    exit;
  end;
  PullDownMenu.PopupComponent := Self;
  PullDownMenu.AutoPopup := True;
  q.X := 0;
  q.Y := 0;
  q := ClientToScreen(q);

  if FPopupPlace = ppRight then
  begin
    q.x := q.X + Width;
    q.y := q.Y - 1;
    //PullDownMenu.Popup(q.X + Width, q.Y - 1);
  end else
  if FPopupPlace = ppDown then
  begin
    q.x := q.X - 1;
    q.y := q.Y + height;
    //PullDownMenu.Popup(q.X - 1, q.Y + Height)
  end
  else
  begin
    q.x := q.x - 1;
    q.y := q.y - GetSystemMetrics(SM_CYMENU) * PullDownMenu.Items.Count - GetSystemMetrics(SM_CXEDGE);
    //PullDownMenu.Popup(q.X - 1, q.Y - GetSystemMetrics(SM_CYMENU) * PullDownMenu.Items.Count);
  end;

  PullDownMenu.PopupComponent := Self;
  if not FUseArrow then
  begin
    FState := ebsDown;
    FOrigState := ebsDown;
    Invalidate;
  end;
  FInMenu := true;
  if Assigned(PullDownMenu.OnPopup) then
    PullDownMenu.OnPopup(PullDownMenu);

  if PullDownMenu is TElPopupMenu then
    TrackElPopupMenu(TElPopupMenu(PullDownMenu).Items,
     TPM_LEFTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON,
     q.X, q.Y, Handle )
  else
    TrackPopupMenu(GetMenuHandle(PullDownMenu),
      TPM_LEFTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON,
      q.X, q.Y,
      0,
      Handle,
      nil);

  FState := ebsUp;
  end;

{$HINTS ON}
procedure TCustomElPopupButton.CreateParams(var Params : TCreateParams);
//const
//  ButtonStyles : array[Boolean] of DWORD = (BS_PUSHBUTTON, BS_DEFPUSHBUTTON);
begin
  inherited CreateParams(Params);
  //Params.Style := Params.Style or ButtonStyles[FDefault];
end;

procedure TCustomElPopupButton.CreateWnd;

begin
  inherited;
  FActive := FDefault;
end;

procedure TCustomElPopupButton.CNCommand(var Message : TWMCommand);
begin
  if Message.NotifyCode = BN_CLICKED then
    Click;
end;

procedure TCustomElPopupButton.CMDialogChar(var Message : TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
    begin
      SetFocus;
      Click;
      if GroupIndex <> 0 then
        SetDown (not FDown);
      Result := 1;
    end
    else
      inherited;
end;

procedure TCustomElPopupButton.CMDialogKey(var Message : TCMDialogKey);
begin
  with Message do
    if (((CharCode = VK_RETURN) and FDefault) or
      ((CharCode = VK_ESCAPE) and FCancel)) and
      (KeyDataToShiftState(Message.KeyData) = []) and CanFocus then
    begin
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TCustomElPopupButton.CMFocusChanged(var Message : TCMFocusChanged);
var
  b : boolean;
begin
  b := FActive;
  FActive := Message.Sender = Self;
  SetButtonStyle(FActive);
  if b <> FActive then
     Invalidate;
  inherited;
end;

procedure TCustomElPopupButton.UpdateExclusive;
var
  Msg : TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg := CM_BUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := TLMDPtrUInt(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
  end;
end;

procedure TCustomElPopupButton.GlyphChanged(Sender : TObject);
begin
  if (not (csLoading in ComponentState)) and
     (not UseIcon) and (not UseImageList) then
  Invalidate;
end;

function TCustomElPopupButton.GetPalette : HPALETTE;
begin
  Result := Glyph.Palette;
end;

function TCustomElPopupButton.GetGlyph : TBitmap;
begin
  Result := FGlyph.Glyph;
end;

procedure TCustomElPopupButton.SetGlyph(Value : TBitmap);
begin
  FGlyph.Glyph := Value;
  FGlyph.ResetNumGlyphs;
  Invalidate;
end;

function TCustomElPopupButton.GetPNGGlyph : TLMDPNGObject;

begin
  Result := FGlyph.PngGlyph;
end;

function TCustomElPopupButton.GetResizableButtonImage: Boolean;
begin
  Result := FGlyph.Resizable;
end;

procedure TCustomElPopupButton.SetPNGGlyph(Value : TLMDPNGObject);

begin
  FGlyph.PngGlyph := Value;
  FGlyph.ResetNumGlyphs;
  Invalidate;
end;

procedure TCustomElPopupButton.SetUsePng(const Value: boolean);
begin
  FGlyph.UsePng := Value;
  FGlyph.ResetNumGlyphs;
  Invalidate;
end;

function TCustomElPopupButton.GetUsePng: Boolean;
begin
  Result := FGlyph.UsePng;
end;

function TCustomElPopupButton.GetNumGlyphs : TNumGlyphs;
begin
  Result := FGlyph.NumGlyphs;
end;

procedure TCustomElPopupButton.SetNumGlyphs(Value : TNumGlyphs);
begin
  if Value < 0 then
    Value := 1
  else if Value > 4 then
    Value := 4;
  // if Value <> FNumGlyphs then
  begin
    FNumGlyphs := Value;
    if (ComponentState * [csReading, csLoading] = []) then
    begin
      FGlyph.NumGlyphs := Value;
      Invalidate;
    end;
  end;
end;

procedure TCustomElPopupButton.SetDown(Value : Boolean);
begin
  if csLoading in ComponentState then
  begin
    FDown := value;
    exit;
  end;
  if (FGroupIndex = 0) and (not FIsSwitch) then Value := False;
  if FDown and (not FAllowAllUp) and (not FIsSwitch) then Exit;
  if FDown <> Value then
  begin
    FDown := Value;
    if Value then
    begin
  if SoundMap <> nil then SoundMap.Play(DownSound);
  if FIsSwitch then
        FState := ebsDown
      else
        FState := ebsExclusive;
      Invalidate;
    end
    else
    begin
  if SoundMap <> nil then SoundMap.Play(UpSound);
  FState := ebsUp;
      Invalidate;
    end;
    if Value then UpdateExclusive;
  end;
end;

procedure TCustomElPopupButton.SetFlat(Value : Boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    if Value then
    begin
      OldStyled := false;
    end;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetGroupIndex(Value : Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

procedure TCustomElPopupButton.SetLayout(Value : TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetMargin(Value : Integer);
begin
  if (Value <> FMargin) and (Value >= -1) then
  begin
    FMargin := Value;
    if FMargin = -1 then
      FAlignment := taCenter;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetSpacing(Value : Integer);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetAllowAllUp(Value : Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

procedure TCustomElPopupButton.WMLButtonDblClk(var Message : TWMLButtonDown);
begin
  inherited;
//  if FDown then DblClick;
  DblClick;
end;

procedure TCustomElPopupButton.UpdateTracking;
var
  P : TPoint;
begin
  if not Enabled then FMouseInControl := false;

  if FFlat and Enabled then
  begin
    GetCursorPos(P);
    FMouseInControl := not (FindDragTarget(P, True) = Self);
    if Enabled and FMouseInControl then
      Perform(CM_MOUSELEAVE, 0, 0)
    else
      Perform(CM_MOUSEENTER, 0, 0);
    end;
end;

procedure TCustomElPopupButton.Loaded;
var
  State : TLMDExButtonState;
begin
  inherited Loaded;
  if Enabled then
    State := ebsUp
  else
    State := ebsDisabled;
  if FUseImageList then
    TProxyGlyph(FGlyph).UseImageList := true;
  TProxyGlyph(FGlyph).CreateButtonGlyph(State);
  TProxyGlyph(FGlyph).NumGlyphs := FNumGlyphs;
  if FDown then
  begin
    FDown := false;
    Down := true;
  end;
  Invalidate;
end;

procedure TCustomElPopupButton.IntEnabledChanged;
const
  NewState : array[Boolean] of TLMDExButtonState = (ebsDisabled, ebsUp);
begin
  if FGlyph <> nil then
  begin
    TProxyGlyph(FGlyph).CreateButtonGlyph(NewState[Enabled]);
    if UseImageList then
    begin
      if (not Enabled) and (FDisabledImages <> nil) then
      begin
         TProxyGlyph(FGlyph).ImageList := FDisabledImages;
         TProxyGlyph(FGlyph).AlphaImageList := FAlphaDisabledImages;
         end else
      begin
         TProxyGlyph(FGlyph).ImageList := FImageList;
         TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      end;
    end;
  end;
  UpdateTracking;
  Invalidate;
end;

procedure TCustomElPopupButton.CMEnabledChanged(var Message : TMessage);
begin
  inherited;
  IntEnabledChanged;
end;

procedure TCustomElPopupButton.CMButtonPressed(var Message : TMessage);
var
  Sender : TCustomElPopupButton;
  begin
  if Message.WParam = WPARAM(FGroupIndex) then
  begin
    Sender := TCustomElPopupButton(Message.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FDown := False;

        if SoundMap <> nil then SoundMap.Play(UpSound);

        FState := ebsUp;
        Invalidate;
      end;
      FAllowAllUp := Sender.AllowAllUp;
    end;
  end;
end;

procedure TCustomElPopupButton.CMFontChanged(var Message : TMessage);
begin
  Invalidate;
end;

procedure TCustomElPopupButton.CMColorChanged(var Message : TMessage);
var ButtonColor : TColor;
    hls1, hls2, hls3, hls4 : integer;
    lum : integer;

begin
  inherited;
  if not ShadowsUseCustom then
  begin
    ButtonColor := ColorToRGB(Color);

    hls1 := RGBtoHLS(ButtonColor);
    hls2 := hls1;
    hls3 := hls1;
    hls4 := hls1;

    lum := Hi(LoWord(hls3));
    hls1 := (Min(239, (Hi(LoWord(hls3))  + lum div 3)) shl 8) or (hls1 and $FF00FF);
    hls2 := (Min(239, (Hi(LoWord(hls3))  - lum div 2)) shl 8) or (hls2 and $FF00FF);
    hls4 := (Min(239, (Hi(LoWord(hls3))  - lum div 3)) shl 8) or (hls4 and $FF00FF);

    FShadowBtnHighlight := HLStoRGB(hls1);
    FShadowBtnDkShadow  := HLStoRGB(hls2);
    FShadowBtnShadow    := HLStoRGB(hls4);
  end;
  Invalidate;
end;

procedure TCustomElPopupButton.CMTextChanged(var Message : TMessage);
begin
  inherited;
  IntTextChanged;
end;

procedure TCustomElPopupButton.CMSysColorChange(var Message : TMessage);
begin
  with TProxyGlyph(FGlyph) do
  begin
    Invalidate;
    CreateButtonGlyph(FState);
  end;
end;

procedure TCustomElPopupButton.CMMouseEnter(var Message : TMessage);
begin
  inherited;
  IntMouseEnter;
end;

procedure TCustomElPopupButton.CMMouseLeave(var Message : TMessage);
begin
  inherited;
  IntMouseLeave;
end;

procedure TCustomElPopupButton.MouseDown(Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
var
  l : integer;

var
  P : TPoint;
  R : TRect;
  href : TLMDString;

begin
  if FIgnoreMouseDown then
  begin
    FIgnoreMouseDown := false;
    ReleaseCapture;
    exit;
  end;
  if ssDouble in Shift then
    FDblClicked := True;
  if IsHTML then
  begin
    P.x := X;
    P.y := Y;
    R := FTextRect;
    if IsHTML and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
      exit;
  end;
  FOrigState := ebsUp;
  if (csDesigning in ComponentState) or ((Parent <> nil) and (csDesigning in Parent.ComponentState)) then exit;
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then
  begin
    if FFocusOnClick then
      SetFocus;
    l := GetArrowSize;
    if (not FDown) and ((FUseArrow and not LMDInRange(X, Width - l, Width)) or not FUseArrow) then
    begin
      FState := ebsDown;

      if SoundMap <> nil then SoundMap.Play(DownSound);

      Invalidate;
    end
    else
    if (not FArrDown) and (FUseArrow and LMDInRange(X, Width - l, Width)) then
    begin

      if SoundMap <> nil then SoundMap.Play(DownSound);

      if FIgnoreClick then
        FIgnoreClick := false
      else
      begin
        FState := ebsArrDown;
        Invalidate;
        FOrigState := ebsArrDown;
        AClick(true);
        if not FInMenu then
          FDragging := true;
      end;
      exit;
    end;
    FDragging := True;
    FMouseInControl := true;
  end
  else
  if (Button <> mbLeft) then
    FIgnoreClick := false;
end;

procedure TCustomElPopupButton.MouseMove(Shift : TShiftState; X, Y : Integer);
var
  NewState : TLMDExButtonState;
var
  l   : integer;
  b        : boolean;
begin
  inherited MouseMove(Shift, X, Y);
  if FDragging then
  begin
    if (not FDown) and (not FArrDown) then
      NewState := ebsUp
    else
      NewState := ebsExclusive;
    if (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
    begin
      if FDown then
        NewState := ebsExclusive
      else
      begin
        l := GetArrowSize;
        // if not FFlat then inc(l, 4);
        if (FUseArrow and LMDInRange(X, Width - l, Width)) then
          NewState := ebsArrDown
        else
          NewState := ebsDown;
      end;
    end
    else
    begin
      if UseArrow then
      begin
        FMouseInArrow := false;
        Invalidate;
      end;
    end;
    if NewState <> FState then
    begin
      FState := NewState;
      if FState = ebsDown then
      begin

        if SoundMap <> nil then SoundMap.Play(DownSound);

      end
      else if FState = ebsUp then

        if SoundMap <> nil then SoundMap.Play(UpSound);

      UpdateTracking;
      Invalidate;
    end;
  end
  else
  if UseArrow then
  begin
    //b := FMouseInArrow;
    FMouseInArrow := X > ClientWidth - GetArrowSize;

    if FMouseInArrow then
    begin
      b := FMouseInControl = false;
      FMouseInControl := false;
    end
    else
    begin
      b := FMouseInControl = false;
      FMouseInControl := true;
    end;

    if b <> FMouseInArrow then
      Invalidate;
  end;
end;

procedure TCustomElPopupButton.MouseUp(Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
var
  DoClick : Boolean;
  ArrClick : Boolean;
  l : integer;
  P : TPoint;
  R : TRect;
  href : TLMDString;
begin
  inherited;
  if IsHTML then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    R := FTextRect;

    if IsHTML and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
    begin
      TriggerLinkClickEvent(href);
      exit;
    end;
  end;
  if FDragging and (Button = mbLeft) then
  begin
    FDragging := False;
    DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
    l := GetArrowSize;
    ArrClick := (FUseArrow and LMDInRange(X, Width - l, Width));
    if FGroupIndex = 0 then
    begin
      if FIsSwitch and (not ArrClick) then
      begin
        if FOrigState <> ebsArrDown then
        begin
          FDown := not FDown;
          if FDown then
          begin
            FState := ebsDown;

            if SoundMap <> nil then SoundMap.Play(DownSound);

          end
          else
          begin
            FState := ebsUp;

            if SoundMap <> nil then SoundMap.Play(UpSound);

          end;
        end else
        begin
          FState := ebsUp;

          if SoundMap <> nil then SoundMap.Play(UpSound);

        end;
      end
      else
      begin
        if ArrClick and FInMenu then
          DoClick := false
        else
        begin
          FState := ebsUp;

          if SoundMap <> nil then SoundMap.Play(UpSound);

        end;
      end;
      FMouseInControl := PtInRect(ClientRect, Point(X, Y));
      if not FMouseInControl then IntMouseLeave;
      if not (FState in [ebsExclusive, ebsArrDown, ebsDown]) then Invalidate;
    end
    else
    if DoClick then
    begin
      SetDown(not FDown);
      if FDown or FArrDown then Invalidate;
    end
    else
    begin
      if FDown then FState := ebsExclusive;
      Invalidate;
    end;
    if DoClick then
//      if FDblClicked then
//        DblClick
//      else
        AClick(ArrClick);
  end;
  FDblClicked := False;
end;

procedure TCustomElPopupButton.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;
  Handled: Boolean;
  href : TLMDString;
  R    : TRect;
begin
  if csDesigning in ComponentState then Exit;

  Pt := ScreenToClient(SmallPointToPoint(Message.Pos));
  if IsHTML then
  begin
    R := FTextRect;
    if (LinkPopupMenu <> nil) and FRender.IsCursorOverLink(Point(Pt.X - R.Left, Pt.Y - R.Top), Point(0, 0), R, href) then
    begin
      Handled := False;
      Temp := ClientToScreen(Pt);
      DoContextPopup(Temp, Handled);
      Message.Result := Ord(Handled);
      if Handled then Exit;

      DoLinkPopup(ClientToScreen(Pt));
      Message.Result := 1;
    end
    else
      inherited
  end
  else
  inherited;
end;

procedure TCustomElPopupButton.WMRButtonUp(var Message: TWMRButtonUp);

begin
  inherited;
end;

procedure TCustomElPopupButton.SetButtonStyle(ADefault : Boolean);
const
  BS_MASK = $000F;
var
  Style : Word;
begin
  if HandleAllocated then
  begin
    if ADefault then
      Style := BS_DEFPUSHBUTTON
    else
      Style := BS_PUSHBUTTON;
    if GetWindowLong(Handle, GWL_STYLE) and BS_MASK <> Style then
      SendMessage(Handle, BM_SETSTYLE, Style, 1);
  end;
end;

type
  TMenuItemEx = class(TMenuItem);

{$HINTS OFF}
procedure TCustomElPopupButton.WndProc(var Message : TMessage);
var P : TPoint;
    I : Integer;
    MenuItem: TMenuItem;
    FindKind: TFindItemKind;
    ContextID: Integer;
    DC: HDC;
    R : TRect;
    Item: Integer;

begin
  if TLMDPtrUInt(Message.Msg) = MenuCancelMsg then
  begin
    FInMenu := false;
    FDragging := false;
    FArrDown := false;
    FState := ebsUp;
    FMouseInControl := false;
    FMouseInArrow := false;
    Invalidate;
    Exit;
  end;

  //if FInMenu then
  try
    case Message.Msg of

      WM_COMMAND,
      WM_INITMENUPOPUP,
      WM_MENUSELECT,
      WM_DRAWITEM,
      WM_MEASUREITEM,
      WM_MENUCHAR,
      WM_HELP:
        begin
          if (PulldownMenu is TElPopupMenu) then
            exit;
          with Message do
            SendMessage(PopupList.Window, Msg, wParam, lParam);
        end;

      WM_EXITMENULOOP:
        begin
          GetCursorPos(P);
          P := ScreenToClient(P);
          FDragging := true;
          PostMessage(Handle, MenuCancelMsg, 0, 0);
          if PtInRect(Rect(ClientWidth - GetArrowSize, 0, ClientWidth, ClientHeight), P) then
             FIgnoreClick := true;
          with Message do
               SendMessage(PopupList.Window, Msg, wParam, lParam);
          end;
      WM_QUERYENDSESSION:
        begin
          Message.result := 1;
          exit;
        end;
      end;
  except
    Application.HandleException(Self);
  end;
  if Message.Msg = CN_COMMAND then
    if FClicksDisabled then Exit;
  inherited WndProc(Message);
end;

{$HINTS ON}
procedure TCustomElPopupButton.WMKeyUp(var Msg: TWMKeyUp);

begin
  IntKeyUp(Msg.CharCode, KeyDataToShiftState(Msg.KeyData));
  inherited;
end;

procedure TCustomElPopupButton.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  inherited;
  Msg.Result := DLGC_BUTTON or DLGC_WANTALLKEYS;
end;

procedure TCustomElPopupButton.WMKeyDown(var Message : TWMKeyDown); { private }

begin
  if not IntKeyDown(Message.CharCode, KeyDataToShiftState(Message.KeyData)) then
  inherited;
end; { WMKeyDown }

procedure TCustomElPopupButton.SetShowFocus(newValue : Boolean);
begin
  if (FShowFocus <> newValue) then
  begin
    FShowFocus := newValue;
    if Focused then
    Invalidate;
  end; { if }
end; { SetShowFocus }

procedure TCustomElPopupButton.SetUseArrow(newValue : Boolean);
begin
  if (FUseArrow <> newValue) then
  begin
    FUseArrow := newValue;
    Invalidate;
  end; { if }
end; { SetUseArrow }

procedure TCustomElPopupButton.SetShowGlyph(newValue : Boolean);
begin
  if (FShowGlyph <> newValue) then
  begin
    FShowGlyph := newValue;
    Invalidate;
  end; { if }
end; { SetShowGlyph }

procedure TCustomElPopupButton.SetShowText(newValue : Boolean);
begin
  if (FShowText <> newValue) then
  begin
    FShowText := newValue;
    Invalidate;
  end; { if }
end; { SetShowText }

procedure TCustomElPopupButton.SetPullDownMenu(newValue : TPopupMenu);
begin
  if (FPullDownMenu <> newValue) then
  begin
    if (FPullDownMenu <> nil) and (not (csDestroying in FPullDownMenu.ComponentState)) then
      FPullDownMenu.RemoveFreeNotification(Self);
    FPullDownMenu := newValue;
    if FPullDownMenu = nil then
      FDisableAp := true
    else
    begin
      FDisableAp := false;
      FPulldownMenu.FreeNotification(Self);
    end;
  end; { if }
end;

procedure TCustomElPopupButton.SetResizableButtonImage(const Value: Boolean);
begin
  FGlyph.Resizable := Value;
end;

{ SetPullDownMenu }

function TCustomElPopupButton.GetIcon : TIcon;
begin
  result := FGlyph.Icon;
end;

procedure TCustomElPopupButton.SetIcon(newValue : TIcon);
begin
  FGlyph.Icon.Assign(newValue);
end;

procedure TCustomElPopupButton.SetIsSwitch(newValue : Boolean);
begin
  if (FIsSwitch <> newValue) then
  begin
    if not NewValue then
    begin
      FDown := false;
      FState := ebsUp;
    end;
    FIsSwitch := newValue;
  end;
end;

procedure TCustomElPopupButton.SetSoundMap(newValue : TElSoundMap);
begin
  if (FSoundMap <> newValue) then
  begin
    if FSoundMap <> nil then
      FSoundMap.RemoveFreeNotification(Self);
    FSoundMap := newValue;
    if FSoundMap <> nil then
      FSoundMap.FreeNotification(Self);
    end;
end; { SetSoundMap }

procedure TCustomElPopupButton.SetShowBorder;
begin
  if FShowBorder <> newValue then
  begin
    FShowBorder := newValue;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElPopupButton.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if (FImgForm <> nil) and (not (csDestroying in FImgForm.ComponentState)) then
      FImgForm.RemoveFreeNotification(Self);
    if FImgForm <> nil then
      FImgForm.UnRegisterChanges(FImgFormChLink);
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then
      FImgForm.RegisterChanges(FImgFormChLink);
    if HandleAllocated then Invalidate;
  end;
end;

procedure TCustomElPopupButton.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin

    if (AComponent = FSoundMap) then SoundMap := nil;

    if (AComponent = FImageList) then Images := nil;
    if (AComponent = FAlphaImageList) then AlphaForImages := nil;
    if (AComponent = FAlphaHotImages) then AlphaForHotImages := nil;
    if (AComponent = FAlphaDownImages) then AlphaForDownImages := nil;
    if (AComponent = FAlphaDisabledImages) then AlphaForDisabledImages := nil;
    if (AComponent = FHotImages) then HotImages := nil;
    if (AComponent = FDownImages) then DownImages := nil;
    if (AComponent = FDisabledImages) then DisabledImages := nil;
    if AComponent = FPullDownMenu then PullDownMenu :=nil;
   if AComponent = LinkPopupMenu then
     LinkPopupMenu := nil;
   if AComponent = FImgForm then ImageForm := nil;
    end; { if }
end; { Notification }

function TCustomElPopupButton.GetImageIndex : integer;
begin
  result := TProxyGlyph(FGlyph).ImageIndex;
end;

procedure TCustomElPopupButton.SetImageIndex(newValue : Integer);
begin
  if (TProxyGlyph(FGlyph).ImageIndex <> newValue) then
  begin
    TProxyGlyph(FGlyph).ImageIndex := newValue;
    if TProxyGlyph(FGlyph).UseImageList then
      Invalidate;
  end; {if}
end;

procedure TCustomElPopupButton.SetImageList(newValue : TCustomImageList);
var b : boolean;
begin
  if FImageList <> newValue then
  begin
    b := FImageList = nil;
    if not b then
    begin
      FImageList.UnregisterChanges(FChLink);
      if (not (csDestroying in FImageList.ComponentState)) then
        FImageList.RemoveFreeNotification(Self);
      end;
    FImageList := newValue;
    if FImageList <> nil then
    begin
      FImageList.RegisterChanges(FChLink);
      FImageList.FreeNotification(Self);
    end;
    TProxyGlyph(FGlyph).ImageList := newValue;
    if FImageList = nil then
      UseImageList := false
    else
    if b and (not (csLoading in ComponentState)) then UseImageList := true;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetAlphaImageList(newValue : TCustomImageList);
var b : boolean;
begin
  if FAlphaImageList <> newValue then
  begin
    b := FAlphaImageList = nil;
    if not b then
    begin
      FAlphaImageList.UnregisterChanges(FAChLink);
      if (not (csDestroying in FImageList.ComponentState)) then
        FAlphaImageList.RemoveFreeNotification(Self);
      end;
    FAlphaImageList := newValue;
    if FAlphaImageList <> nil then
    begin
      FAlphaImageList.RegisterChanges(FAChLink);
      FAlphaImageList.FreeNotification(Self);
    end;
    TProxyGlyph(FGlyph).AlphaImageList := newValue;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetUseIcon(newValue : Boolean);
begin
  if (FUseIcon <> newValue) then
  begin
    FUseIcon := newValue;
    FGlyph.UseIcon := newValue;
    if not UseImageList then Invalidate;
  end; { if }
end; { SetUseIcon }

function TCustomElPopupButton.GetUseImageList : boolean;
begin
  result := FUseImageList;
end;

procedure TCustomElPopupButton.SetUseImageList(newValue : Boolean);
begin
  if (UseImageList <> newValue) then
  begin
    FUseImageList := newValue;
    if not (csLoading in ComponentState) then
    begin
      TProxyGlyph(FGlyph).UseImageList := newValue;
      Invalidate;
    end;
  end; { if }
end; { SetUseImageList }

procedure TCustomElPopupButton.SetOldStyled(newValue : Boolean);
{ Sets data member FOldStyled to newValue. }
begin
  if (FOldStyled <> newValue) then
  begin
    if not (newValue and Flat) then
    begin
      FOldStyled := newValue;
      Repaint;
    end;
  end; { if }
end; { SetOldStyled }

procedure TCustomElPopupButton.ImagesChanged(Sender : TObject);
begin
  if FUseImageList then
  begin
    if (FMouseInControl and Enabled) and (Sender = Images) then Invalidate else
    if (not Enabled) and (Sender = DisabledImages) then Invalidate else
    if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (Sender = DownImages) then Invalidate else
    if Sender = FImageList then Invalidate;
  end else
  begin
    if (Sender = FBackGround) or ((Sender = FHotBackground) and (FMouseInControl)) or
         ((Sender = FDownBackground) and (FDown and FIsSwitch) or
         (FState in [ebsDown, ebsExclusive]))  then Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetDownImages(newValue : TCustomImageList);
begin
  if (FDownImages <> newValue) then
  begin
    if FDownImages <> nil then
    begin
      if (not (csDestroying in FDownImages.ComponentState)) then
        FDownImages.RemoveFreeNotification(Self);
      FDownImages.UnregisterChanges(FNChLink);
    end;
    FDownImages := newValue;
    if FDownImages <> nil then FDownImages.RegisterChanges(FNChLink);
    if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) then
    begin
      if newValue = nil then
        TProxyGlyph(FGlyph).ImageList := FImageList
      else
        TProxyGlyph(FGlyph).ImageList := newValue;
      Invalidate;
    end;
    if FDownImages <> nil then
      FDownImages.FreeNotification(Self);
  end;  { if }
end;

procedure TCustomElPopupButton.SetAlphaDownImages(newValue : TCustomImageList);
begin
  if (FAlphaDownImages <> newValue) then
  begin
    if FAlphaDownImages <> nil then
    begin
      if (not (csDestroying in FAlphaDownImages.ComponentState)) then
        FAlphaDownImages.RemoveFreeNotification(Self);
      FAlphaDownImages.UnregisterChanges(FANChLink);
    end;
    FAlphaDownImages := newValue;
    if FAlphaDownImages <> nil then FAlphaDownImages.RegisterChanges(FANChLink);
    if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) then
    begin
      if newValue = nil then
        TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList
      else
        TProxyGlyph(FGlyph).AlphaImageList := newValue;
      Invalidate;
    end;
    if FAlphaDownImages <> nil then
      FAlphaDownImages.FreeNotification(Self);
  end;  { if }
end;

procedure TCustomElPopupButton.SetHotBackground(const Value: TBitmap);
begin
  FHotBackground.Assign(Value);
end;

procedure TCustomElPopupButton.SetHotImages(newValue : TCustomImageList);
begin
  if (FHotImages <> newValue) then
  begin
    if FHotImages <> nil then
    begin
      if (not (csDestroying in FHotImages.ComponentState)) then
        FHotImages.RemoveFreeNotification(Self);
      FHotImages.UnregisterChanges(FHChLink);
    end;
    FHotImages := newValue;
    if FHotImages <> nil then
    begin
      FHotImages.RegisterChanges(FHChLink);
      FHotImages.FreeNotification(Self);
    end;
    if FMouseInControl then
    begin
      if newValue = nil then
        TProxyGlyph(FGlyph).ImageList := FImageList
      else
        TProxyGlyph(FGlyph).ImageList := newValue;
      Invalidate;
    end;
  end;  { if }
end;  { SetHotImages }

procedure TCustomElPopupButton.SetAlphaHotImages(newValue : TCustomImageList);
begin
  if (FAlphaHotImages <> newValue) then
  begin
    if FAlphaHotImages <> nil then
    begin
      if (not (csDestroying in FAlphaHotImages.ComponentState)) then
        FAlphaHotImages.RemoveFreeNotification(Self);
      FAlphaHotImages.UnregisterChanges(FAHChLink);
    end;
    FAlphaHotImages := newValue;
    if FAlphaHotImages <> nil then
    begin
      FAlphaHotImages.RegisterChanges(FAHChLink);
      FAlphaHotImages.FreeNotification(Self);
    end;
    if FMouseInControl then
    begin
      if newValue = nil then
        TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList
      else
        TProxyGlyph(FGlyph).AlphaImageList := newValue;
      Invalidate;
    end;
  end;  { if }
end;  { SetAlphaHotImages }

procedure TCustomElPopupButton.SetDisabledImages(newValue : TCustomImageList);
begin
  if (FDisabledImages <> newValue) then
  begin
    if FDisabledImages <> nil then
    begin
      if (not (csDestroying in FDisabledImages.ComponentState)) then
        FDisabledImages.RemoveFreeNotification(Self);
      FDisabledImages.UnregisterChanges(FDChLink);
    end;
    FDisabledImages := newValue;
    if FDisabledImages <> nil then
    begin
      FDisabledImages.RegisterChanges(FDChLink);
      FDisabledImages.FreeNotification(Self);
    end;
    if not Enabled then
    begin
      if newValue <> nil then
        TProxyGlyph(FGlyph).ImageList := newValue
      else
        TProxyGlyph(FGlyph).ImageList := FImageList;
      Invalidate;
    end;
  end;  { if }
end;  { SetDisabledImages }

procedure TCustomElPopupButton.SetAlphaDisabledImages(newValue : TCustomImageList);
begin
  if (FAlphaDisabledImages <> newValue) then
  begin
    if FAlphaDisabledImages <> nil then
    begin
      if (not (csDestroying in FAlphaDisabledImages.ComponentState)) then
        FAlphaDisabledImages.RemoveFreeNotification(Self);
      FAlphaDisabledImages.UnregisterChanges(FADChLink);
    end;
    FAlphaDisabledImages := newValue;
    if FAlphaDisabledImages <> nil then
    begin
      FAlphaDisabledImages.RegisterChanges(FADChLink);
      FAlphaDisabledImages.FreeNotification(Self);
    end;
    if not Enabled then
    begin
      if newValue <> nil then
        TProxyGlyph(FGlyph).AlphaImageList := newValue
      else
        TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      Invalidate;
    end;
  end;  { if }
end;  { SetAlphaDisabledImages }

procedure TCustomElPopupButton.CMEnter(var Msg: TCMEnter);
begin
  inherited;
  Invalidate;
end;

procedure TCustomElPopupButton.CMExit(var Msg: TCMExit);
begin
  inherited;
  Invalidate;
end;

function TCustomElPopupButton.GetActionLinkClass : TControlActionLinkClass;
begin
  result := TElPopupButtonActionLink;
end;

procedure TCustomElPopupButton.ActionChange(Sender : TObject; CheckDefaults : Boolean);
{$ifdef LMD_UNICODE}
var
  PropInfo: PPropInfo;
{$endif}
begin
  inherited;
  if Action is TAction then
  begin
    ImageIndex := TAction(Action).ImageIndex;
    Down := TAction(Action).Checked;
{$ifdef LMD_UNICODE}
    PropInfo := TypInfo.GetPropInfo(Sender.ClassInfo, 'Hint');
    if (PropInfo <> nil) and (PropInfo.PropType^.Kind = tkWString) then
      Hint := GetWideStrProp(Sender, 'Hint')
    else
{$endif}
      Hint := TAction(Sender).Hint;
{$ifdef LMD_UNICODE}
    PropInfo := TypInfo.GetPropInfo(Sender.ClassInfo, 'Caption');
    if (PropInfo <> nil) and (PropInfo.PropType^.Kind = tkWString) then
      Self.Caption := GetWideStrProp(Sender, 'Caption')
    else
{$endif}
      Self.Caption := TAction(Sender).Caption;
  end;
end;

procedure TCustomElPopupButton.SetThinFrame(newValue : Boolean);
{ Sets data member FThinFrame to newValue. }
begin
  if (FThinFrame <> newValue) then
  begin
    FThinFrame := newValue;
    if newValue then FOldStyled := false;
    if OldStyled or ((FMouseInControl or Focused) and (not (FState in [ebsDown, ebsExclusive]))) then Invalidate;
  end;  { if }
end;  { SetThinFrame }

procedure TCustomElPopupButton.SetShadowsUseCustom(Value : Boolean);
begin
  if Value <> FShadowsUseCustom then
  begin
    FShadowsUseCustom := Value;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetShadowBtnHighlight(Value : TColor);
begin
  if Value <> FShadowBtnHighlight then
  begin
    FShadowBtnHighlight := Value;
    if FShadowsUseCustom then Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetShadowBtnShadow(Value : TColor);
begin
  if Value <> FShadowBtnShadow then
  begin
    FShadowBtnShadow := Value;
    if FShadowsUseCustom then Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetShadowBtnDkShadow(Value : TColor);
begin
  if Value <> FShadowBtnDkShadow then
  begin
    FShadowBtnDkShadow := Value;
    if FShadowsUseCustom then Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetShadowFollowsColor(Value : Boolean);
begin
  if Value <> FShadowFollowsColor then
  begin
    FShadowFollowsColor := Value;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetBackgroundDrawBorder(Value : boolean);
begin
  if Value <> FBackgroundDrawBorder then
  begin
    FBackgroundDrawBorder := Value;
    if not FBackground.Empty then Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetDownBackground(newValue : TBitmap);
{ Sets data member FDownBackground to newValue. }
begin
  FDownBackground.Assign(newValue);
end;  { SetDownBackground }

procedure TCustomElPopupButton.SetBackground(newValue : TBitmap);
{ Sets data member FBackground to newValue. }
begin
  FBackground.Assign(newValue);
end;  { SetBackground }

procedure TCustomElPopupButton.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    if FIsHTML then
    begin
      FRender := TLMDHTMLRender.Create;
      FRender.OnImageNeeded := TriggerImageNeededEvent;
    end
    else
    begin
      FRender.Free;
      FRender := nil;
    end;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
  begin
    FLinkColor := newValue;
    if HandleAllocated then
      Invalidate;
  end;  { if }
end;  { SetLinkColor }

procedure TCustomElPopupButton.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  if (FLinkPopupMenu <> newValue) then
  begin
    if (FLinkPopupMenu <> nil) and (not (csDestroying in FLinkPopupMenu.ComponentState)) then
      FLinkPopupMenu.RemoveFreeNotification(Self);
    FLinkPopupMenu := newValue;
    if (newValue <> nil) then
       newValue.FreeNotification(Self);
  end;  { if }
end;  { SetLinkPopupMenu }

procedure TCustomElPopupButton.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
  begin
    FLinkStyle := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkStyle }

procedure TCustomElPopupButton.DoLinkPopup(MousePos : TPoint);
begin
  if (FLinkPopupMenu <> nil) and FLinkPopupMenu.AutoPopup then
  begin
    SendCancelMode(nil);
    FLinkPopupMenu.PopupComponent := Self;
    if MousePos.X < 0 then
      MousePos := ClientToScreen(Point(0,0));
    FLinkPopupMenu.Popup(MousePos.X, MousePos.Y);
  end;
end;

procedure TCustomElPopupButton.TriggerImageNeededEvent(Sender : TObject; Src :
    TLMDString; var Image : TBitmap);
begin
  Image := nil;
  if (assigned(FOnImageNeeded)) then
      FOnImageNeeded(Self, Src, Image);
end;  { TriggerImageNeededEvent }

procedure TCustomElPopupButton.TriggerLinkClickEvent(HRef : TLMDString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

constructor TCustomElPopupButton.Create(AOwner : TComponent);
begin
  BeginCreate;
  inherited Create(AOwner);
  FNumGlyphs := 1;
  FGlyphMaskUsage := muGlyphList;
  ControlStyle := [csReflector, csSetCaption, csCaptureMouse, csDoubleClicks, csOpaque];
  Width := 75;
  Height := 25;
  FDblClicked := False;
  FAlignment := taCenter;
  TabStop := True;
  FMultiLine := False;
  FGlyph := TProxyGlyph.Create;
  FGlyph.OnChange := GlyphChanged;
  FFocusOnClick := False;
  FFlat := false;
  FSpacing := 4;
  FMargin := -1;
  FLayout := blGlyphLeft;
  Inc(ButtonCount);
  FUseArrow := False;
  FShowText := true;
  FShowGlyph := true;
  TProxyGlyph(FGlyph).ImageIndex := -1;
  Font.Color := clBtnText;
  ParentFont := True;
  FAdjustSpaceForGlyph := true;
  FChangeDisabledText := true;

  FChLink  := TChangeLink.Create; FChLink.OnChange := ImagesChanged;
  FAChLink  := TChangeLink.Create; FAChLink.OnChange := ImagesChanged;
  FDChLink := TChangeLink.Create; FDChLink.OnChange := ImagesChanged;
  FADChLink := TChangeLink.Create; FADChLink.OnChange := ImagesChanged;
  FHChLink := TChangeLink.Create; FHChLink.OnChange := ImagesChanged;
  FAHChLink := TChangeLink.Create; FAHChLink.OnChange := ImagesChanged;
  FNChLink := TChangeLink.Create; FNChLink.OnChange := ImagesChanged;
  FANChLink := TChangeLink.Create; FANChLink.OnChange := ImagesChanged;
  FBackground := TBitmap.Create;
  FDownBackground := TBitmap.Create;
  FHotBackground := TBitmap.Create;
  FShadowFollowsColor := true;
  FImgFormChLink  := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FShowBorder := true;
  FShowFocus := true;
  FDrawDefaultFrame := True;
  FLinkStyle := [fsUnderline];
  FLinkColor := clBlue;
  UseXPThemes := true;

  EndCreate;
end;

destructor TCustomElPopupButton.Destroy;
begin
  ImageForm := nil;
  FImgFormChLink.Free;
  UseArrow := false;
  FDownBackground.Free;
  FBackground.Free;
  FHotBackground.Free;
  Dec(ButtonCount);
  FChLink.Free;
  FAChLink.Free;
  FDChLink.Free;
  FADChLink.Free;
  FHChLink.Free;
  FAHChLink.Free;
  FNChLink.Free;
  FANChLink.Free;
  if ButtonCount = 0 then
  begin
    Pattern.Free;
    Pattern := nil;
  end;
  FGlyph.Free;

  UseXPThemes := false;

  if IsHTML then
    FRender.Free;
  FRender := nil;
  inherited Destroy;
end;

procedure TCustomElPopupButton.SetAdjustSpaceForGlyph(Value: Boolean);
begin
  if FAdjustSpaceForGlyph <> Value then
  begin
    FAdjustSpaceForGlyph := Value;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TCustomElPopupButton.Click;
begin
  AClick(false);
end;

procedure TCustomElPopupButton.ButtonClick;
var
  First, Last: Integer;
begin
  if not FDown then
  begin
    FState := ebsDown;
    Repaint;
  end;
  First := GetTickCount;
  repeat
    Last := GetTickCount;
  until ((Last - First) >= 25) or (Last < First);
  FState := ebsUp;
  if GroupIndex = 0 then
  begin
    Click;
    Repaint;
  end
  else
  begin
    Down := not Down;
    Click;
  end;
end;

procedure TCustomElPopupButton.SetDrawDefaultFrame(Value: Boolean);
begin
  if FDrawDefaultFrame <> Value then
  begin
    FDrawDefaultFrame := Value;
    if Default then
      Invalidate;
  end;
end;

function TCustomElPopupButton.GetArrowSize: Integer;
var
  PS  : TSize;
  lThemeMode : TLMDThemeMode;
  LDetail: TThemedComboBox;
begin
  lThemeMode := UseThemeMode;
  if lThemeMode <> ttmNone then
    begin
      LDetail := tcDropDownButtonNormal;
      if LMDThemeServices.GetThemePartSize(lThemeMode, 0, ThemeServices.GetElementDetails(LDetail), PS) then
        begin
          Result := PS.cx;
          Inc(Result);
          if Result < 13 then
            Result := 13;
        end
      else
        Result := 13;
    end
  else
    begin
      Result := 13;
      if not FFlat then inc(Result, 2);
    end
end;

function TCustomElPopupButton.IntKeyDown;
begin
  result := false;
  if
     (Key = VK_SPACE)
    and Focused and
    (Shift = []) and CanFocus then
  begin
    if FState <> ebsDown then
    begin
      FState := ebsDown;

      if SoundMap <> nil then SoundMap.Play(DownSound);

      Invalidate;
    end;
    Result := false;
  end
  else
  if (
    (Key = VK_RETURN)
    and Focused) and
    (Shift = []) and CanFocus then
  begin
    if FIsSwitch then
    begin
      FDown := not FDown;
      if not FDown then
      begin
        FState := ebsUp;

        if SoundMap <> nil then SoundMap.Play(UpSound);

      end;
    end
    else
    begin
      FState := ebsUp;

      if SoundMap <> nil then SoundMap.Play(UpSound);

    end;
    Invalidate;
    Click;
    result := false;
  end
  else
  if
    (Key = VK_ESCAPE)
    and (Shift = []) then
  begin
    //result := true;
    GetParentForm(Self).Perform(CM_DIALOGKEY, Key, ShiftStateToKeyData(Shift))
    end
  else
  if
    (Key = VK_DOWN)
    and (Shift = [ssAlt]) and
    Enabled and FUseArrow and Assigned(FPullDownMenu) and (FPullDownMenu.AutoPopup) then
  begin
    // result := true;
    AClick(true)
  end;
end;

procedure TCustomElPopupButton.IntKeyUp;
begin
  if (
     (Key = VK_SPACE)
     and Focused) and (Shift = []) and CanFocus then
  begin
    if GroupIndex <> 0 then
    begin
      SetDown(not FDown);
    end
    else
    if FIsSwitch then
    begin
      FDown := not FDown;
      if not FDown then
      begin
        FState := ebsUp;

        if SoundMap <> nil then SoundMap.Play(UpSound);

      end;
    end
    else
    begin
      FState := ebsUp;

      if SoundMap <> nil then SoundMap.Play(UpSound);

    end;
    Invalidate;
    Click;
  end;
end;

procedure TCustomElPopupButton.IntMouseEnter;
var P     : TPoint;
    b     : boolean;
begin
  b := false;
  if Enabled then
  begin
    if (not OldStyled) or IsThemed then
      b := true;

    if UseArrow then
    begin
      GetCursorPos(P);
      P := ScreenToClient(P);
      FMouseInArrow := P.X > ClientWidth - GetArrowSize;
      if not FMouseInArrow then
        FMouseInControl := true;
    end
    else
      FMouseInControl := true;

    if UseImageList then
    begin
      if FHotImages <> nil then
      begin
        if TProxyGlyph(FGlyph).ImageList <> FHotImages then
          b := true;
        TProxyGlyph(FGlyph).ImageList := FHotImages;
        TProxyGlyph(FGlyph).AlphaImageList := FAlphaHotImages;
        end
      else
      begin
        if TProxyGlyph(FGlyph).ImageList <> FImageList then
          b := true;
        TProxyGlyph(FGlyph).ImageList := FImageList;
        TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList;
        end;
    end;
    if b then
      Invalidate;
  end;
  if assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TCustomElPopupButton.IntTextChanged;
begin
  if (Pos(#13#10, Caption) > 0)
  and (not IsHTML)
  then
    FMultiline := true
  else
    FMultiline := false;
  Invalidate;
end;

procedure TCustomElPopupButton.IntMouseLeave;
var b : boolean;
begin
  b := false;
  if not OldStyled or IsThemed then
    b := true;
  if Enabled and (not FDragging) then
  begin
    if UseImageList and (HotImages <> nil) then
    begin
      if TProxyGlyph(FGlyph).ImageList <> FImageList then
        b := true;
      TProxyGlyph(FGlyph).ImageList := FImageList;
      TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      end;
  end;
  if FMouseInControl or FMouseInArrow then
    b := true;
  FMouseInControl := False;
  FMouseInArrow := false;
  if assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
  if b then
    Invalidate;
end;

function TCustomElPopupButton.DoSaveShadows: Boolean;
begin
  result := ShadowsUseCustom and not (ShadowFollowsColor);
end;

procedure TCustomElPopupButton.SetImageIsAlphaBlended(Value: Boolean);
begin
  if FImageIsAlphaBlended <> Value then
  begin
    FImageIsAlphaBlended := Value;
//    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetDrawFocusFrame(Value: Boolean);
begin
  if FDrawFocusFrame <> Value then
  begin
    FDrawFocusFrame := Value;
    if Focused then
      Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetCursor(Value: TCursor);
var P : TPoint;
    R : TRect;
    href : TLMDString;
begin
  if (FCursor <> Value) then
  begin
    FCursor := Value;
    if IsHTML then
    begin
      GetCursorPos(P);
      P := ScreenToClient(P);
      R := FTextRect;
      if FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
        inherited Cursor := crHandPoint
      else
        inherited Cursor := FCursor;
    end
    else
    inherited Cursor := FCursor;
  end;  { if }
end;  { SetCursor }

procedure TCustomElPopupButton.SetChangeDisabledText(Value: Boolean);
begin
  if FChangeDisabledText <> Value then
  begin
    FChangeDisabledText := Value;
    if FState = ebsDisabled then
      Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    if (FAlignment <> taCenter) and (FMargin = -1) then
      FMargin := 0;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  (*if not IsThemed then
    Message.Result := 1
  else
    inherited;
  *)
  Message.Result := 1;
end;

procedure TElSpeedButton.SetPullDownMenu(newValue : TPopupMenu);
begin
  if (FPullDownMenu <> newValue) then
  begin
    FPullDownMenu := newValue;
    if FPullDownMenu = nil then FPullDownEnabled := false;
  end; { if }
end;

{ SetPullDownMenu }

procedure TElSpeedButton.SetTransparent(newValue : Boolean);
begin
  if (FTransparent <> newValue) then
  begin
    FTransparent := newValue;
    Repaint;
  end; { if }
end; { SetTransparent }

procedure TElSpeedButton.Paint; { protected }
var
  xx, yy : integer;
  Bmp : TBitmap;
  IL : TCustomImageList;
  LIndex: Integer;

begin
  Bmp := nil;
  with Canvas do
  begin
    if not Transparent then
    begin
      pen.color := Color;
      Brush.Color := Color;
      Ellipse(1, 1, width - 2, height - 2); { fill inner button }
    end;
    if FUseImageList and Assigned(FImages) then
    begin
      LIndex := 0;
      if not Enabled then
        LIndex := 3
      else if (not FPressed) and (not FOver) then
        LIndex := 0
      else if FPressed then
        LIndex := 2
      else if FOver then
        LIndex := 1;
      xx := ClientWidth div 2 - FImages.width div 2;
      if (FImages.width mod 2) <> 0 then
        dec(xx);
      yy := ClientHeight div 2 - FImages.Height div 2;
      if (FImages.height mod 2) <> 0 then
        dec(yy);
      FImages.Draw(Canvas, xx, yy, LIndex);
    end
    else
    begin
      if not Enabled then
        Bmp := FDisabledImage
      else if (not FPressed) and (not FOver) then
        Bmp := FNormalImage
      else if FPressed then
        Bmp := FPressedImage
      else if FOver then
        Bmp := FMouseInImage;
      if not Assigned(Bmp) or (Bmp.Empty) then
        Bmp := FNormalImage;
      if (Bmp <> nil) and (not Bmp.Empty) then
      begin
        IL := TCustomImageList.Create(self);
        xx := self.ClientWidth div 2 - Bmp.width div 2;
        if (bmp.width mod 2) <> 0 then
          dec(xx);
        yy := self.ClientHeight div 2 - Bmp.Height div 2;
        if (bmp.height mod 2) <> 0 then
          dec(yy);
        Brush.Color := Color;
        Il.Height := Bmp.Height;
        IL.Width := Bmp.Width;
        IL.AddMasked(Bmp, FTransparentColor);
        IL.DrawingStyle := dsNormal;
        IL.BkColor := clNone;
        IL.Draw(Canvas, XX, YY, 0);
        IL.Free;
      end;
    end;
    if FDrawEdge then
    begin
      if (not FPressed) and ((FOver and FDrawEdge) or (not Flat)) or (csDesigning in ComponentState) then
      begin
        pen.color := clBtnHighlight; { highlighted edge }
        Arc(0, 0, width - 1, height - 1, width div 5 * 4, height div 5, width div 5, height div 5 * 4);
        pen.color := clBtnShadow; { shadowed edge }
        Arc(0, 0, width - 1, height - 1, width div 5, height div 5 * 4, width div 5 * 4, height div 5);
      end
      else if (FPressed and FDrawEdge) then
      begin
        pen.color := clBtnShadow; { shadowed edge }
        Arc(0, 0, width - 1, height - 1, width div 5 * 4, height div 5, width div 5, height div 5 * 4);
        pen.color := clBtnHighlight; { highlighted edge }
        Arc(0, 0, width - 1, height - 1, width div 5, height div 5 * 4, width div 5 * 4, height div 5);
      end;
    end;
  end;
end; { Paint }

procedure TElSpeedButton.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }
begin
  if InCircle(X, Y) then
  begin
    FPressed := true;
    if FPullDownEnabled and (FPullDownBtn = Button) then
      StartTimer
    else
    begin
      FPullTimer.Free;
      FPullTimer := nil;
    end;
    Repaint;
  end;
  inherited;
end; { MouseDown }

procedure TElSpeedButton.MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }
begin
  if FPressed then
  begin
    FPressed := false;
    begin
      FPullTimer.Free;
      FPullTimer := nil;
    end;
    Repaint;
  end;
  inherited;
end;

procedure TElSpeedButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
    if (AComponent = FImages) then
      Images := nil;
  end;
end;

{ MouseUp }

procedure TElSpeedButton.TriggerPullDownEvent;
begin
  if (assigned(FOnPullDown)) then
    FOnPullDown(Self);
end; { TriggerPullDownEvent }

procedure TElSpeedButton.SetDrawEdge(newValue : Boolean);
begin
  if (FDrawEdge <> newValue) then
  begin
    FDrawEdge := newValue;
    Repaint;
  end; { if }
end; { SetDrawEdge }

procedure TElSpeedButton.WMMouseMove(var Msg : TWMMouseMove); { private }
begin
  if (InCircle(Msg.XPos, Msg.YPos) and not FOver) then
  begin
    FOver := true;
    if ((MK_LBUTTON or MK_MBUTTON or MK_RBUTTON) and Msg.Keys) > 0 then FPressed := true;
    Repaint;
  end
  else if ((not InCircle(Msg.XPos, Msg.YPos)) and FOver) then
  begin
    FOver := false;
    FPressed := false;
    Repaint;
  end;
  inherited;
end; { WMMouseMove }

procedure TElSpeedButton.CMMouseLeave(var Msg : TMessage); { private }
var
  b : boolean;
begin
  inherited;
  b := false;
  if FPressed then
  begin
    FPressed := false;
    b := true;
  end;
  if FOver then
  begin
    FOver := false;
    b := true;
  end;
  if b then Repaint;
end; { CMMouseLeave }

procedure TElSpeedButton.ImagesChanged(Sender: TObject);
begin
  if FUseImageList then
  begin
    if Sender = FImages then
      Invalidate
  end
end;

function TElSpeedButton.InCircle(X, Y : integer) : Boolean; { public }
var
  xx, yy, ll : integer;
begin
  xx := abs(X - ClientWidth div 2);
  yy := abs(Y - ClientHeight div 2);
  ll := ClientWidth div 2;
  result := (sqr(xx) + sqr(yy)) <= sqr(ll);
end; { InCircle }

procedure TElSpeedButton.SetFlat(newValue : Boolean);
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    Repaint;
  end; { if }
end;

procedure TElSpeedButton.SetImages(const Value: TCustomImageList);
begin
  if (FImages <> Value) then
  begin
    if FImages <> nil then
    begin
      if (not (csDestroying in FImages.ComponentState)) then
        FImages.RemoveFreeNotification(Self);
      FImages.UnregisterChanges(FChLink);
    end;
    FImages := Value;
    if FImages <> nil then
      FImages.FreeNotification(Self);
    if FImages <> nil then
      FImages.RegisterChanges(FChLink);

    Invalidate;
  end;  { if }
end;

{ SetFlat }

procedure TElSpeedButton.SetNormalImage(newValue : TBitmap);
begin
  FNormalImage.Assign(newValue);
  if FAutoSize then
  begin
    ChangeSize;
  end;
  //if Enabled then Repaint;
end; { SetNormalImage }

procedure TElSpeedButton.SetDisabledImage(newValue : TBitmap);
begin
  FDisabledImage.Assign(newValue);
  if FAutoSize then
  begin
    ChangeSize;
  end;
  if not Enabled then Repaint;
end; { SetDisabledImage }

procedure TElSpeedButton.ChangeSize;
var
  LSizeH, LSizeW: integer;
begin
  if FAutoSize then
  begin
    LSizeH := max(FNormalImage.Height, FMouseInImage.Height);
    LSizeW := max(FNormalImage.Width, FMouseInImage.Width);
    LSizeH := max(LSizeH, FPressedImage.Height);
    LSizeW := max(LSizeW, FPressedImage.Width);
    LSizeH := max(LSizeH, FDisabledImage.Height);
    LSizeW := max(LSizeW, FDisabledImage.Width);
    ClientWidth := 3 + Trunc(sqrt(sqr(LSizeH) + sqr(LSizeW)));
    ClientHeight := ClientWidth;
  end;
end;

procedure TElSpeedButton.SetMouseInImage(newValue : TBitmap);
begin
  FMouseInImage.Assign(newValue);
  if FAutoSize then
  begin
    ChangeSize;
  end;
  if FOver then Repaint;
end; { SetMouseInImage }

procedure TElSpeedButton.SetPressedImage(newValue : TBitmap);
begin
  FPressedImage.Assign(newValue);
  if FAutoSize then
  begin
    ChangeSize;
  end;
  if FPressed then Repaint;
end; { SetPressedImage }

destructor TElSpeedButton.Destroy;
begin
  FNormalImage.Free;
  FDisabledImage.Free;
  FMouseInImage.Free;
  FPressedImage.Free;
  FChLink.Free;
  if FPullTimer <> nil then FPullTimer.Free;
  inherited Destroy;
end;

{ Destroy }

constructor TElSpeedButton.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FPullTimer := nil;
  FPullDownInterval := 1000;
  FPullDownEnabled := false;
  FTransparent := true;
  FDrawEdge := False;
  FNormalImage := TBitmap.Create;
  FDisabledImage := TBitmap.Create;
  FMouseInImage := TBitmap.Create;
  FPressedImage := TBitmap.Create;
  FAutoSize := true;
  Color := clBtnFace;
  FTransparentColor := clNone;
  FChLink := TChangeLink.Create();
  FChLink.OnChange := ImagesChanged;
  Width := 20;
  Height := 20;
end; { Create }

procedure TElSpeedButton.SetAutoSize(newValue : boolean);
begin
  inherited;
  if FAutoSize <> newValue then
  begin
    FAutoSize := newValue;
    if FAutoSize then
    begin
      ChangeSize;
    end;
  end;
end;

procedure TElSpeedButton.SetTransparentColor(newValue : TColor);
begin
  if (FTransparentColor <> newValue) then
  begin
    FTransparentColor := newValue;
    FNormalImage.TransparentColor := newValue;
    FDisabledImage.TransparentColor := newValue;
    FMouseInImage.TransparentColor := newValue;
    FPressedImage.TransparentColor := newValue;
    Repaint;
  end; { if }
end;

procedure TElSpeedButton.SetUseImageList(const Value: Boolean);
begin
  if FUseImageList <> Value then
  begin
    FUseImageList := Value;
    Invalidate;
  end;
end;

{ SetTransparentColor }

procedure TElSpeedButton.WMEraseBkgnd(var Msg : TWMEraseBkgnd); { private }
begin
  Msg.Result := 1;
end; { WMEraseBkgnd }

procedure TElSpeedButton.StartTimer;
begin
  if FPullDownInterval > 0 then
  begin
    if FPullTimer = nil then FPullTimer := TTimer.Create(self);
    FPullTimer.Interval := FPullDownInterval;
    FPullTimer.OnTimer := OnTimer;
    FPullTimer.Enabled := true;
  end
  else
    PullMenu;
end;

procedure TElSpeedButton.OnTimer(Sender : TObject);
begin
  FPullTimer.Enabled := false;
  PullMenu;
end;

procedure TElSpeedButton.PullMenu;
var
  P : TPoint;
begin
  TriggerPullDownEvent;
  if FPullDownMenu <> nil then
  begin
    if FPullDownMenu.Alignment = paLeft then
    begin
      P.X := 0;
      P.Y := Height + 1;
    end
    else if FPullDownMenu.Alignment = paRight then
    begin
      P.X := Width;
      P.Y := Height + 1;
    end
    else
    begin
      P.X := Width div 2;
      P.Y := Height + 1;
    end;
    P := ClientToScreen(P);
    FPullDownMenu.Popup(P.X, P.Y);
  end;
end;

{$IFDEF LMD_UNICODE}
procedure TElSpeedButton.CMHintShow(var Message: TMessage);
begin
  inherited;
end;

procedure TElSpeedButton.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

function TElPopupButtonActionLink.IsCaptionLinked: Boolean;
{$ifdef LMD_UNICODE}
var
  PropInfo: PPropInfo;
{$endif}
begin
{$ifdef LMD_UNICODE}
  PropInfo := TypInfo.GetPropInfo(Action.ClassInfo, 'Caption');
  if (PropInfo <> nil) and (PropInfo.PropType^.Kind = tkWString) then
    Result := (Action is TCustomAction) and (TCustomElPopupButton(FClient).Caption = GetWideStrProp(Action, 'Caption'))
  else
{$endif}
    Result := inherited IsCaptionLinked;
end;

function TElPopupButtonActionLink.IsHintLinked: Boolean;
{$ifdef LMD_UNICODE}
var
  PropInfo: PPropInfo;
{$endif}
begin
{$ifdef LMD_UNICODE}
  PropInfo := TypInfo.GetPropInfo(Action.ClassInfo, 'Hint');
  if (PropInfo <> nil) and (PropInfo.PropType^.Kind = tkWString) then
    Result := (Action is TCustomAction) and (TCustomElPopupButton(FClient).Hint = GetWideStrProp(Action, 'Hint'))
  else
{$endif}
    Result := inherited IsHintLinked;
end;

procedure TElPopupButtonActionLink.SetChecked(Value : boolean);
begin
  if IsCheckedLinked then
  begin
    with TCustomElPopupButton(FClient) do
    begin
      ClicksDisabled := True;
      try
        Checked := Value;
      finally
        ClicksDisabled := False;
      end;
    end;
  end;
end;

procedure TElPopupButtonActionLink.SetImageIndex(Value: Integer);
begin
  if FClient is TCustomElPopupButton then
  begin
    TCustomElPopupButton(FClient).ImageIndex := value;
  end;
end;

// =============================================================================

function TCustomElGraphicButton.GetChecked : Boolean;
begin
  result := Down;
end;

procedure TCustomElGraphicButton.SetChecked(newValue : Boolean);
begin
  Down := newValue;
end;

procedure TCustomElGraphicButton.SetPopupPlace(Value : TPopupPlace);
begin
  FPopupPlace := Value;
end;

procedure TCustomElGraphicButton.SetDisableAp(Value : boolean);
begin
  FDisableAp := Value;
end;

function TCustomElGraphicButton.IsColorStored : boolean;
begin
  result := not ParentColor;
end;

procedure TCustomElGraphicButton.SetShowBorder;
begin
  if FShowBorder <> newValue then
  begin
    FShowBorder := newValue;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElGraphicButton.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      if (FImgForm <> nil) and (not (csDestroying in FImgForm.ComponentState)) then
        FImgForm.RemoveFreeNotification(Self);
      FImgForm.UnRegisterChanges(FImgFormChLink);
    end;
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then FImgForm.RegisterChanges(FImgFormChLink);
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.Paint;
var
  PaintRect,
  R1, BgRect : TRect;
  ACtl    : TWinControl;
  ax, ay : integer;
  P      : TPoint;
  ArrRect : TRect;
  Offset : TPoint;
  dw : integer;
  aw : integer;
  AColor : TColor;
  SaveIL : TCustomImageList;
  SaveAIL : TCustomImageList;
  GlyphState : TLMDExButtonState;
  RClip   : TRect;
  Bitmap  : TBitmap;
  Canvas  : TCanvas;
  LThemeMode : TLMDThemeMode;

  procedure DrawButtonFrameEx(DC : HDC; rc : TRect; Focused : boolean; Pushed : boolean; ButtonColor : TColor; Thin : boolean);
  begin
    if ShadowsUseCustom then
       ElVCLUtils.DrawButtonFrameEx2(DC, rc, Focused, Pushed, ButtonColor, Thin, ColorToRGB(FShadowBtnHighlight), ColorToRGB(FShadowBtnDkShadow), ColorToRGB(Color), ColorToRGB(FShadowBtnShadow), AllBorderSides)
    else
       ElVCLUtils.DrawButtonFrameEx3(DC, rc, Focused, Pushed, ButtonColor, Thin, AllBorderSides);
  end;
  procedure DrawButtonBackgroundImage(BMP: TBitmap);
  var
    Img : TImage;
  begin
    Img := TImage.Create(self);
    try
      Img.Transparent := BMP.Transparent;
      Img.AutoSize := false;
      Img.Stretch := True;
      Img.Width := Width;
      Img.Height := Height;
      Img.Picture.Assign(Bmp);
      Canvas.StretchDraw(Rect(0, 0, Width, Height),Img.Picture.Bitmap);
    finally
      Img.Free;
    End;
  end;
begin
  SaveIL := nil;
  SaveAIL := nil;
  Bitmap := Tbitmap.Create;
  Bitmap.Handle := CreateCompatibleBitmap(Self.Canvas.Handle, ClientWidth, ClientHeight);
  Canvas := Bitmap.Canvas;
  LThemeMode := UseThemeMode;
  bitblt(Bitmap.Canvas.Handle, 0, 0, Bitmap.Width, Bitmap.Height, Self.Canvas.Handle, 0, 0, SRCCOPY);
  if (not Enabled) or (Assigned(Parent) and (not Parent.Enabled)) then
  begin
    FState := ebsDisabled;
    FDragging := False;
  end
  else
  if FState = ebsDisabled then
    if FDown and (GroupIndex <> 0) then
      FState := ebsExclusive
    else
      FState := ebsUp;
  Canvas.Font := Self.Font;
  PaintRect := ClientRect;

  if FShadowFollowsColor then
    AColor := Color
  else
    AColor := clBtnFace;

  if LThemeMode = ttmNone then
  begin
    if not Transparent then
    begin
      if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
      begin
        ACtl := FImgForm.GetRealControl;
        R1 := PaintRect;
        BgRect := R1;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        P := Parent.ClientToScreen(Point(Left, Top));
        ax := BgRect.Left - P.x;
        ay := BgRect.Top - P.y;

        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
        FImgForm.PaintBkgnd(Canvas.Handle, R1, Point(BgRect.Left - ax, BgRect.Top - ay), false);
      end;
      begin
        Canvas.Brush.Color := Color;
        if (FMouseInControl) then
        begin
          if (not FHotBackground.Empty) then
            DrawButtonBackgroundImage(HotBackground)
          else
            if (FImgForm = nil) or (csDesigning in FImgForm.GetRealControl.ComponentState) then
              Canvas.FillRect(PaintRect);
        end
        else
        if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (not FDownBackground.Empty) then
        begin
          if (not FDownBackground.Empty) then
            DrawButtonBackgroundImage(DownBackground)
          else
            if (FImgForm = nil) or (csDesigning in FImgForm.GetRealControl.ComponentState) then
              Canvas.FillRect(PaintRect);
        end
        else
        begin
          if (not Background.Empty) then
            DrawButtonBackgroundImage(Background)
          else
          if (FImgForm = nil) or (csDesigning in FImgForm.GetRealControl.ComponentState) then
          Canvas.FillRect(PaintRect);
        end;
      end;
    end
    else
    begin
      bitblt(Bitmap.Canvas.Handle, 0, 0, ClientWidth, ClientHeight, Self.Canvas.Handle, 0, 0, SRCCOPY);
    end;
    PaintRect := ClientRect;
  end;

  dw := 0;
  aw := 0;

  if LThemeMode = ttmNone then
  begin
    if not FFlat then
    begin
      if FUseArrow then
      begin
        dw := GetArrowSize;
        aw := dw;
        Dec(PaintRect.Right, dw);
      end;
      if ((Background.Empty) or (BackgroundDrawBorder)) and ShowBorder then
      begin
        if MoneyFlat then
        begin
          if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
            Canvas.Brush.Color := MoneyFlatDownColor
          else
          if (FMouseInControl or FMouseInArrow or Focused) and (FState <> ebsDisabled) then
            Canvas.Brush.Color := MoneyFlatActiveColor
          else
            Canvas.Brush.Color := MoneyFlatInactiveColor;
          Canvas.FrameRect(PaintRect);
          InflateRect(PaintRect, -1, -1);
        end
        else
        begin
          DrawButtonFrameEx(Canvas.Handle, PaintRect, OldStyled or ((FMouseInControl or Focused)) and (not ThinFrame),
                             (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]), AColor, ThinFrame);
        end;
      end;
    end
    else
    begin
      if FUseArrow then
      begin
        dw := GetArrowSize;
        aw := dw;
        Dec(PaintRect.Right, dw);
        end;
      if MoneyFlat then
      begin
        if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
          Canvas.Brush.Color := MoneyFlatDownColor
        else
        if (FMouseInControl or FMouseInArrow or Focused) and (FState <> ebsDisabled) then
          Canvas.Brush.Color := MoneyFlatActiveColor
        else
          Canvas.Brush.Color := MoneyFlatInactiveColor;
        Canvas.FrameRect(PaintRect);
        InflateRect(PaintRect, -1, -1);
      end
      else
      begin
        if (FDown and FIsSwitch) or (FState in [ebsDown, {ebsArrDown, }ebsExclusive]) or
          ((FMouseInControl or FMouseInArrow or Focused) and (FState <> ebsDisabled)) or (csDesigning in ComponentState) then
        begin
          if ((Background.Empty) or (BackgroundDrawBorder)) and ShowBorder then
             DrawButtonFrameEx(Canvas.Handle, PaintRect, false, //OldStyled or ((FMouseInControl or Focused)) and (not ThinFrame),
                             (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]), AColor, true{ThinFrame});
        end;
      end;
    end;

    // draw the rectangle for the arrow
    if FUseArrow then
    begin
      if dw = 0 then
      begin
        dw := GetArrowSize;
        Dec(PaintRect.Right, dw);
      end;
      ArrRect := Rect(PaintRect.Right, 0, PaintRect.Right + dw, Height);

      Canvas.Brush.Color := Color;

      if ((Background.Empty) or (BackgroundDrawBorder)) and FShowBorder then
      begin
        if MoneyFlat then
        begin
          if (FState in [ebsArrDown, ebsDown]) then
            Canvas.Brush.Color := MoneyFlatDownColor
          else
          if (FMouseInControl or FMouseInArrow or Focused) and (FState <> ebsDisabled) then
            Canvas.Brush.Color := MoneyFlatActiveColor
          else
            Canvas.Brush.Color := MoneyFlatInactiveColor;
          Canvas.FrameRect(ArrRect);
        end
        else
        begin
          if ((not FFlat) or ((FMouseInControl or FMouseInArrow or Focused) or
              (FState in [ebsArrDown, ebsExclusive])
               or (csDesigning in ComponentState))) then
          DrawButtonFrameEx(Canvas.Handle, ArrRect, ({FMouseInArrow or }FOldStyled) and (not FThinFrame) and (not FDown), (FState in [ebsDown, ebsArrDown]), AColor, ThinFrame or Flat);
        end;
      end;
      LMDDrawArrow(Canvas, eadDown, ArrRect, Font.Color, FState <> ebsDisabled);
    end;
  end
  else
  begin
    //DrawThemedBackground(Canvas);
    if FUseArrow then
    begin
      dw := GetArrowSize;
      aw := dw;
      Dec(PaintRect.Right, dw);
    end;
    RClip := Canvas.ClipRect;
    LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, GetDetails, PaintRect, LMDRectToPtr(RClip));
    if FUseArrow then
      begin
        if dw = 0 then
        begin
          dw := GetArrowSize();
          Dec(PaintRect.Right, dw);
        end;
        ArrRect := Rect(PaintRect.Right, PaintRect.Top, PaintRect.Right + dw, PaintRect.Bottom);

        RClip := Canvas.ClipRect;
        LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, GetArrowDetails, ArrRect, LMDRectToPtr(RClip));
      end;
  end;

  Offset.x := 0;
  Offset.y := 0;

  if (FState in [ebsDown, ebsExclusive]) or (FDown and FIsSwitch) then
  begin
    if (FState = ebsExclusive) or
       (UseImageList and ((DownImages = nil) or (DownImages = Images))) or
       (UseIcon) or
       ((not UseImageList) and {(UseIcon) and} (NumGlyphs < 2)) then
    begin
      Offset.X := 1;
      Offset.Y := 1;
    end;
  end;
  if not (Layout = blGlyphRight) then
    inc(PaintRect.Right, dw);

  if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (FDownImages <> nil) then
  begin
    SaveIL := TProxyGlyph(FGlyph).ImageList;
    SaveAIL := TProxyGlyph(FGlyph).AlphaImageList;
    TProxyGlyph(FGlyph).ImageList := FDownImages;
    TProxyGlyph(FGlyph).AlphaImageList := FAlphaDownImages;
  end;

  if (TProxyGlyph(FGlyph).ImageList = Self.FDisabledImages) and (FDisabledImages <> nil) and (FState = ebsDisabled) then
    GlyphState := ebsUp
  else
    GlyphState := FState;

  if AdjustSpaceForGlyph then
  begin
    if (not FThinFrame) then
      InflateRect(PaintRect, -2, -2)
    else
      InflateRect(PaintRect, -1, -1);
  end;
  if IsHTML then
  begin
    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultBgColor := clNone;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.LinkColor := LinkColor;
    FRender.Data.LinkStyle := LinkStyle;
    FRender.Data.Charset := Font.Charset;
  end;
  FTextRect := FGlyph.Draw(Canvas, PaintRect, Offset, Caption, FLayout, FMargin,
    FSpacing, FState, GlyphState, Alignment, true, FMultiline, false, ShowGlyph,
    FShowText, Aw, TextDrawType, Color,
    LThemeMode, GetTextDetails,
    ShortcutsEnabled, ImageIsAlphaBlended, IsHTML, FRender, FChangeDisabledText, FGlyphMaskUsage);
//  Canvas.Stop;

  if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (FDownImages <> nil) then
  begin
    TProxyGlyph(FGlyph).ImageList := SaveIL;
    TProxyGlyph(FGlyph).AlphaImageList := SaveAIL;
  end;
  bitblt(Self.Canvas.Handle, 0, 0, ClientWidth, ClientHeight, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
  Bitmap.Free;
end;

{$HINTS OFF}
procedure TCustomElGraphicButton.AClick;
var
  Form : TCustomForm;

const
   Buttons: array[TTrackButton] of Word = (TPM_RIGHTBUTTON, TPM_LEFTBUTTON);

begin
  Form := GetParentForm(Self);
  if Form <> nil then Form.ModalResult := ModalResult;
  if Arrow then
  begin
    if SoundMap <> nil then SoundMap.Play(ArrowClickSound);
    if Assigned(FOnArrowClick) then FOnArrowClick(Self);
  end
  else
  begin
    if SoundMap <> nil then SoundMap.Play(ClickSound);
    DoClick;
    //FMouseInControl := false;
    Invalidate;
  end;
  if (PullDownMenu = nil) or (FDisableAp) or ((not Arrow) and FUseArrow) then exit;
  DoPullMenu;
end;

{$HINTS ON}
procedure TCustomElGraphicButton.CMDialogKey(var Message : TCMDialogKey);
begin
  with Message do
    if ShortcutsEnabled and ((((CharCode = VK_RETURN) and FDefault) or
      ((CharCode = VK_ESCAPE) and FCancel)) and
      (KeyDataToShiftState(Message.KeyData) = [])) and Enabled and Visible then
    begin
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TCustomElGraphicButton.CMDialogChar(var Message : TCMDialogChar);
begin
  with Message do
    if (HiByte(GetKeyState(VK_MENU)) > 0) and ShortcutsEnabled and IsAccel(CharCode, Caption) and Enabled and Visible then
    begin
      if PullDownMenu is TElPopupMenu then
        TElPopupMenu(PulldownMenu).InitialSelect := true;
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TCustomElGraphicButton.UpdateExclusive;
var
  Msg : TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg := CM_BUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := TLMDPtrUInt(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
    end;
end;

procedure TCustomElGraphicButton.GlyphChanged(Sender : TObject);
begin
  if (not (csLoading in ComponentState)) and
     (not UseIcon) and (not UseImageList) then
  Invalidate;
end;

function TCustomElGraphicButton.GetPalette : HPALETTE;
begin
  Result := Glyph.Palette;
end;

function TCustomElGraphicButton.GetGlyph : TBitmap;
begin
  Result := FGlyph.Glyph;
end;

procedure TCustomElGraphicButton.SetGlyph(Value : TBitmap);
begin
  FGlyph.Glyph := Value;
  FGlyph.ResetNumGlyphs;
  Invalidate;
end;

function TCustomElGraphicButton.GetNumGlyphs : TNumGlyphs;
begin
  Result := FGlyph.NumGlyphs;
end;

procedure TCustomElGraphicButton.SetNumGlyphs(Value : TNumGlyphs);
begin
  if Value < 0 then
    Value := 1
  else if Value > 4 then
    Value := 4;
  // if Value <> FNumGlyphs then
  begin
    FNumGlyphs := Value;
    if (ComponentState * [csReading, csLoading] = []) then
    begin
      FGlyph.NumGlyphs := Value;
      Invalidate;
    end;
  end;
end;

function TCustomElGraphicButton.GetPNGGlyph : TLMDPNGObject;

begin
  Result := FGlyph.PngGlyph;
end;

procedure TCustomElGraphicButton.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

procedure TCustomElGraphicButton.SetPNGGlyph(Value : TLMDPNGObject);

begin
  FGlyph.PngGlyph := Value;
  FGlyph.ResetNumGlyphs;
  Invalidate;
end;

procedure TCustomElGraphicButton.SetUsePng(const Value: boolean);
begin
  FGlyph.UsePng := Value;
  FGlyph.ResetNumGlyphs;
  Invalidate;
end;

function TCustomElGraphicButton.GetUsePng: Boolean;
begin
  Result := FGlyph.UsePng;
end;

procedure TCustomElGraphicButton.SetDown(Value : Boolean);
begin
  if csLoading in ComponentState then
  begin
    FDown := value;
    exit;
  end;
  if (FGroupIndex = 0) and (not FIsSwitch) then
    Value := False;
  if FDown and (not FAllowAllUp) and (not FIsSwitch) then
    Exit;
  if FDown <> Value then
  begin
    FDown := Value;
    if Value then
    begin
      if SoundMap <> nil then
        SoundMap.Play(DownSound);
      if FIsSwitch then
        FState := ebsDown
      else
        FState := ebsExclusive;
      Invalidate;
    end
    else
    begin
      if SoundMap <> nil then
        SoundMap.Play(UpSound);
      FState := ebsUp;
      Invalidate;
    end;
    if Value then
      UpdateExclusive;
  end;
end;

procedure TCustomElGraphicButton.SetFlat(Value : Boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    if Value then
    begin
      OldStyled := false;
    end;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetGroupIndex(Value : Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

procedure TCustomElGraphicButton.SetLayout(Value : TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetMargin(Value : Integer);
begin
  if (Value <> FMargin) and (Value >= -1) then
  begin
    FMargin := Value;
    if FMargin = -1 then
      FAlignment := taCenter;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetSpacing(Value : Integer);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetAllowAllUp(Value : Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

procedure TCustomElGraphicButton.UpdateTracking;
var
  P : TPoint;
begin
  if not Enabled then
    FMouseInControl := false;

  if FFlat and Enabled then
  begin
    GetCursorPos(P);
    FMouseInControl := not (FindDragTarget(P, True) = Self);
    if Enabled and FMouseInControl then
      Perform(CM_MOUSELEAVE, 0, 0)
    else
      Perform(CM_MOUSEENTER, 0, 0);
    end;
end;

procedure TCustomElGraphicButton.Loaded;
var
  State : TLMDExButtonState;
begin
  inherited Loaded;
  if Enabled then
    State := ebsUp
  else
    State := ebsDisabled;
  if FUseImageList then
    TProxyGlyph(FGlyph).UseImageList := true;
  TProxyGlyph(FGlyph).CreateButtonGlyph(State);
  TProxyGlyph(FGlyph).NumGlyphs := FNumGlyphs;
  if FDown then
  begin
    FDown := false;
    Down := true;
  end;
  UpdateStyle;
  Invalidate;
end;

procedure TCustomElGraphicButton.CMEnabledChanged(var Message : TMessage);

begin
  inherited;
  IntEnabledChanged;
end;

procedure TCustomElGraphicButton.CMButtonPressed(var Message : TMessage);
var
  Sender : TCustomElGraphicButton;
begin
  if Message.WParam = WPARAM(FGroupIndex) then
  begin
    Sender := TCustomElGraphicButton(Message.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FDown := False;

        if SoundMap <> nil then SoundMap.Play(UpSound);

        FState := ebsUp;
        Invalidate;
      end;
      FAllowAllUp := Sender.AllowAllUp;
    end;
  end;
end;

procedure TCustomElGraphicButton.CMFontChanged(var Message : TMessage);

begin
  inherited;
  Invalidate;
end;

procedure TCustomElGraphicButton.CMColorChanged(var Message : TMessage);
var ButtonColor : TColor;
    hls1, hls2, hls3, hls4 : integer;
    lum : integer;

begin
  inherited;
  if not ShadowsUseCustom then
  begin
    ButtonColor := ColorToRGB(Color);

    hls1 := RGBtoHLS(ButtonColor);
    hls2 := hls1;
    hls3 := hls1;
    hls4 := hls1;

    lum := Hi(LoWord(hls3));
    hls1 := (Min(239, (Hi(LoWord(hls3))  + lum div 3)) shl 8) or (hls1 and $FF00FF);
    hls2 := (Min(239, (Hi(LoWord(hls3))  - lum div 2)) shl 8) or (hls2 and $FF00FF);
    hls4 := (Min(239, (Hi(LoWord(hls3))  - lum div 3)) shl 8) or (hls4 and $FF00FF);

    FShadowBtnHighlight := HLStoRGB(hls1);
    FShadowBtnDkShadow  := HLStoRGB(hls2);
    FShadowBtnShadow    := HLStoRGB(hls4);
  end;
  Invalidate;
end;

procedure TCustomElGraphicButton.CMTextChanged(var Message : TMessage);
begin
  IntTextChanged;
end;

procedure TCustomElGraphicButton.CMSysColorChange(var Message : TMessage);
begin
  with TProxyGlyph(FGlyph) do
  begin
    Invalidate;
    CreateButtonGlyph(FState);
  end;
end;

procedure TCustomElGraphicButton.CMMouseEnter(var Message : TMessage);
begin
  inherited;
  IntMouseEnter;
  (*
  DoInv := false;
  if IsThemed then
    DoInv := true;
  if (not FMouseInControl) and Enabled then
  begin
    if UseArrow then
    begin
      GetCursorPos(P);
      P := ScreenToClient(P);
      FMouseInArrow := P.X > ClientWidth - GetArrowSize;
      if not FMouseInArrow then
        FMouseInControl := true;
    end
    else
      FMouseInControl := true;
    DoInv := true;

    if UseImageList then
    begin
      if FHotImages <> nil then
      begin
        TProxyGlyph(FGlyph).ImageList := FHotImages
        TProxyGlyph(FGlyph).AlphaImageList := FAlphaHotImages
      end else
      begin
        TProxyGlyph(FGlyph).ImageList := FImageList;
        TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      end;
      DoInv := FHotImages <> FImageList;
    end;
  end;
  if DoInv then Invalidate;
  *)
end;

procedure TCustomElGraphicButton.CMMouseLeave(var Message : TMessage);
// var DoInv : boolean;
begin
  inherited;
  IntMouseLeave;
  (*
  DoInv := false;
  if IsThemed then
    DoInv := true;
  if FMousEInArrow then
    DoInv := true;
  if FMouseInControl and Enabled and not FDragging then
  begin
    if UseImageList and (HotImages <> nil) then
    begin
      TProxyGlyph(FGlyph).ImageList := FImageList;
      TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      DoInv := FHotImages <> FImageList;
    end;
    if Flat or (not (OldStyled or ThinFrame)) then DoInv := true;
  end;
  FMouseInControl := False;
  FMouseInArrow := false;
  if DoInv then Invalidate;
  *)
end;

procedure TCustomElGraphicButton.MouseDown(Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
var
  l : integer;

var
  P : TPoint;
  R : TRect;
  href : TLMDString;

begin
  if ssDouble in Shift then
    FDblClicked := True;
  if IsHTML then
  begin
    P.x := X;
    P.y := Y;
    R := FTextRect;
    if IsHTML and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
      exit;
  end;
  FOrigState := ebsUp;
  if (csDesigning in ComponentState) or ((Parent <> nil) and (csDesigning in Parent.ComponentState)) then exit;
//  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then
  begin
    l := GetArrowSize;
    if (not FDown) and ((FUseArrow and not LMDInRange(X, Width - l, Width)) or not FUseArrow) then
    begin
      FState := ebsDown;

      if SoundMap <> nil then SoundMap.Play(DownSound);

      Invalidate;
    end
    else
    if (not FArrDown) and (FUseArrow and LMDInRange(X, Width - l, Width)) then
    begin

      if SoundMap <> nil then SoundMap.Play(DownSound);

      if FIgnoreClick then
        FIgnoreClick := false
      else
      begin
        FState := ebsArrDown;
        Invalidate;
        FOrigState := ebsArrDown;
        if PullDownMenu is TElPopupMenu then
          TElPopupMenu(PulldownMenu).InitialSelect := false;
        AClick(true);
        if not FInMenu then
          FDragging := true;
      end;
      exit;
    end;
    FDragging := True;
    FMouseInControl := true;
  end else if (Button <> mbLeft) then FIgnoreClick := false;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomElGraphicButton.MouseMove(Shift : TShiftState; X, Y : Integer);
var
  NewState : TLMDExButtonState;
var
  l : integer;
  b : boolean;
begin
  inherited MouseMove(Shift, X, Y);
  if FDragging then
  begin
    if (not FDown) and (not FArrDown) then
      NewState := ebsUp
    else
      NewState := ebsExclusive;
    if (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
    begin
      if FDown then
        NewState := ebsExclusive
      else
      begin
        l := GetArrowSize;
        // if not FFlat then inc(l, 4);
        if (FUseArrow and LMDInRange(X, Width - l, Width)) then
          NewState := ebsArrDown
        else
          NewState := ebsDown;
      end;
    end
    else
    begin
      if UseArrow then
      begin
        FMouseInArrow := false;
        Invalidate;
      end;
    end;
    if NewState <> FState then
    begin
      FState := NewState;
      if FState = ebsDown then
      begin

        if SoundMap <> nil then SoundMap.Play(DownSound);

      end
      else if FState = ebsUp then

        if SoundMap <> nil then SoundMap.Play(UpSound);

      UpdateTracking;
      Invalidate;
    end;
  end
  else
  if UseArrow then
  begin
    //b := FMouseInArrow;
    FMouseInArrow := X > ClientWidth - GetArrowSize;

    if FMouseInArrow then
    begin
      b := FMouseInControl = false;
      FMouseInControl := false;
    end
    else
    begin
      b := FMouseInControl = false;
      FMouseInControl := true;
    end;
    if b <> FMouseInArrow then
      Invalidate;
  end;
end;

procedure TCustomElGraphicButton.MouseUp(Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
var
  DoClick : Boolean;
  ArrClick : Boolean;
  l : integer;
  P : TPoint;
  R : TRect;
  href : TLMDString;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if IsHTML then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    R := FTextRect;

    if IsHTML and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
    begin
      TriggerLinkClickEvent(href);
      exit;
    end;
  end;
  if FDragging and (Button = mbLeft) then
  begin
    FDragging := False;
    DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
    l := GetArrowSize;
    ArrClick := (FUseArrow and LMDInRange(X, Width - l, Width));
    if FGroupIndex = 0 then
    begin
      if FIsSwitch and (not ArrClick) then
      begin
        if FOrigState <> ebsArrDown then
        begin
          if DoClick then
          begin
            FDown := not FDown;
            if FDown then
            begin
              FState := ebsDown;
  if SoundMap <> nil then SoundMap.Play(DownSound);
  end
            else
            begin
              FState := ebsUp;
  if SoundMap <> nil then SoundMap.Play(UpSound);
  end;
          end;
        end else
        begin
          FState := ebsUp;

          if SoundMap <> nil then SoundMap.Play(UpSound);

        end;
      end
      else
      begin
        if ArrClick and FInMenu then
          DoClick := false
        else
        begin
          FState := ebsUp;

          if SoundMap <> nil then SoundMap.Play(UpSound);

        end;
      end;
      FMouseInControl := PtInRect(ClientRect, Point(X, Y));
      if not FMouseInControl then
        IntMouseLeave;
      if not (FState in [ebsExclusive, ebsArrDown, ebsDown]) then
        Invalidate;
    end
    else
    if DoClick then
    begin
      SetDown(not FDown);
      if FDown or FArrDown then Invalidate;
    end
    else
    begin
      if FDown then
        FState := ebsExclusive;
      Invalidate;
    end;
    if DoClick then
    begin
      if PullDownMenu is TElPopupMenu then
        TElPopupMenu(PulldownMenu).InitialSelect := false;
//      if not FDblClicked then
//        DblClick
//      else
        AClick(ArrClick);
    end;
  end;
  FDblClicked := False;
end;

{$HINTS OFF}
procedure TCustomElGraphicButton.WndProc(var Message : TMessage);
var P : TPoint;
    I : Integer;
    MenuItem: TMenuItem;
    FindKind: TFindItemKind;
    ContextID: Integer;
    DC: HDC;
    R : TRect;
    Item: Integer;

begin
  if TLMDPtrUInt(Message.Msg) = MenuCancelMsg then
  begin
    FInMenu := false;
    FDragging := false;
    FArrDown := false;
    FState := ebsUp;
    Perform(CM_MOUSELEAVE, 0, 0);
    Exit;
  end;

  //if FInMenu then
  try
    case Message.Msg of
      WM_THEMECHANGED: //EL_THEMECHANGED -> WM_THEMECHANGED theme engine transition (VB)
        ELThemeChanged(Message);

      WM_COMMAND,
      WM_INITMENUPOPUP,
      WM_MENUSELECT,
      WM_DRAWITEM,
      WM_MEASUREITEM,
      WM_MENUCHAR,
      WM_HELP:
        if (PulldownMenu is TElPopupMenu) then
          exit
        else
        with Message do
            SendMessage(PopupList.Window, Msg, wParam, lParam);

      WM_EXITMENULOOP:
        begin
          GetCursorPos(P);
          P := ScreenToClient(P);
          FDragging := true;
          PostMessage(FWND, MenuCancelMsg, TLMDPtrInt(Self), 0);
          if PtInRect(Rect(ClientWidth - GetArrowSize, 0, ClientWidth, ClientHeight), P) then
             FIgnoreClick := true;
          if not (PulldownMenu is TElPopupMenu) then
            with Message do
               SendMessage(PopupList.Window, Msg, wParam, lParam);
          end;
      WM_QUERYENDSESSION:
        begin
          Message.Result := 1;
          exit;
        end;
      end
  except
    Application.HandleException(Self);
  end;
  if Message.Msg = CN_COMMAND then
    if FClicksDisabled then Exit;
  inherited WndProc(Message);
end;
{$HINTS ON}

procedure TCustomElGraphicButton.SetUseArrow(newValue : Boolean);
begin
  if (FUseArrow <> newValue) then
  begin
    FUseArrow := newValue;
    Invalidate;
  end; { if }
end; { SetUseArrow }

procedure TCustomElGraphicButton.SetShowGlyph(newValue: Boolean);
begin
  if (FShowGlyph <> newValue) then
  begin
    FShowGlyph := newValue;
    Invalidate;
  end; { if }
end; { SetShowGlyph }

procedure TCustomElGraphicButton.SetShowText(newValue : Boolean);
begin
  if (FShowText <> newValue) then
  begin
    FShowText := newValue;
    Invalidate;
  end; { if }
end; { SetShowText }

procedure TCustomElGraphicButton.SetPullDownMenu(newValue : TPopupMenu);
begin
  if (FPullDownMenu <> newValue) then
  begin
    if (FPullDownMenu <> nil) and (not (csDestroying in FPullDownMenu.ComponentState)) then
      FPulldownMenu.RemoveFreeNotification(Self);
    FPullDownMenu := newValue;
    if FPullDownMenu = nil then
      FDisableAp := true
    else
    begin
      FDisableAp := false;
      FPulldownMenu.FreeNotification(Self);
    end;
  end; { if }
end; { SetPullDownMenu }

function TCustomElGraphicButton.GetIcon : TIcon;
begin
  result := FGlyph.Icon;
end;

procedure TCustomElGraphicButton.SetIcon(newValue : TIcon);
begin
  FGlyph.Icon.Assign(newValue);
end;

procedure TCustomElGraphicButton.SetIsSwitch(newValue : Boolean);
begin
  if (FIsSwitch <> newValue) then
    FIsSwitch := newValue;
end;

procedure TCustomElGraphicButton.SetSoundMap(newValue : TElSoundMap);
begin
  if (FSoundMap <> newValue) then
  begin
    if FSoundMap <> nil then
      FSoundMap.RemoveFreeNotification(Self);
    FSoundMap := newValue;
    if FSoundMap <> nil then
      FSoundMap.FreeNotification(Self);
    end;
end; { SetSoundMap }

procedure TCustomElGraphicButton.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin

    if (AComponent = FSoundMap) then SoundMap := nil;

    if (AComponent = FImageList) then Images := nil;
    if (AComponent = FAlphaImageList) then AlphaForImages := nil;
    if (AComponent = FAlphaHotImages) then AlphaForHotImages := nil;
    if (AComponent = FAlphaDownImages) then AlphaForDownImages := nil;
    if (AComponent = FAlphaDisabledImages) then AlphaForDisabledImages := nil;
    if (AComponent = FHotImages) then HotImages := nil;
    if (AComponent = FDownImages) then DownImages := nil;
    if (AComponent = FDisabledImages) then DisabledImages := nil;
    if AComponent = FPullDownMenu then PullDownMenu :=nil;
    if AComponent = LinkPopupMenu then
      LinkPopupMenu := nil;
    if AComponent = FImgForm then ImageForm := nil;
    end; { if }
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
end; { Notification }

function TCustomElGraphicButton.GetImageIndex : integer;
begin
  result := TProxyGlyph(FGlyph).ImageIndex;
end;

procedure TCustomElGraphicButton.SetImageIndex(newValue : Integer);
begin
  if (TProxyGlyph(FGlyph).ImageIndex <> newValue) then
  begin
    TProxyGlyph(FGlyph).ImageIndex := newValue;
    if TProxyGlyph(FGlyph).UseImageList then Invalidate;
  end; {if}
end;

procedure TCustomElGraphicButton.SetImageList(newValue : TCustomImageList);
var b : boolean;
begin
  if FImageList <> newValue then
  begin
    b := FImageList = nil;
    if not b then
    begin
      if (not (csDestroying in FImageList.ComponentState)) then
        FImageList.RemoveFreeNotification(Self);
      FImageList.UnregisterChanges(FChLink);
    end;
    FImageList := newValue;
    if FImageList <> nil then
    begin
      FImageList.RegisterChanges(FChLink);
      FImageList.FreeNotification(Self);
    end;
    TProxyGlyph(FGlyph).ImageList := newValue;
    if FImageList = nil then
      UseImageList := false
    else
    if b and (not (csLoading in ComponentState)) then
      UseImageList := true;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetAlphaImageList(newValue : TCustomImageList);
var b : boolean;
begin
  if FAlphaImageList <> newValue then
  begin
    b := FAlphaImageList = nil;
    if not b then
    begin
      if (not (csDestroying in FAlphaImageList.ComponentState)) then
        FAlphaImageList.RemoveFreeNotification(Self);
      FAlphaImageList.UnregisterChanges(FAChLink);
    end;
    FAlphaImageList := newValue;
    if FAlphaImageList <> nil then
    begin
      FAlphaImageList.RegisterChanges(FAChLink);
      FAlphaImageList.FreeNotification(Self);
    end;
    TProxyGlyph(FGlyph).AlphaImageList := newValue;
{
    if FImageList = nil then
      UseImageList := false
    else
    if b and (not (csLoading in ComponentState)) then
      UseImageList := true;
}
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetUseIcon(newValue : Boolean);
begin
  if (FUseIcon <> newValue) then
  begin
    FUseIcon := newValue;
    FGlyph.UseIcon := newValue;
    if not UseImageList then Invalidate;
  end; { if }
end; { SetUseIcon }

function TCustomElGraphicButton.GetUseImageList : boolean;
begin
  result := FUseImageList;
end;

procedure TCustomElGraphicButton.SetUseImageList(newValue : Boolean);
begin
  if (UseImageList <> newValue) then
  begin
    FUseImageList := newValue;
    if not (csLoading in ComponentState) then
    begin
      TProxyGlyph(FGlyph).UseImageList := newValue;
      Invalidate;
    end;
  end; { if }
end; { SetUseImageList }

procedure TCustomElGraphicButton.SetOldStyled(newValue : Boolean);
{ Sets data member FOldStyled to newValue. }
begin
  if (FOldStyled <> newValue) then
  begin
    if not (newValue and Flat) then
    begin
      FOldStyled := newValue;
      Repaint;
    end;
  end; { if }
end; { SetOldStyled }

procedure TCustomElGraphicButton.ImagesChanged(Sender : TObject);
begin
  if FUseImageList then
  begin
    if (FMouseInControl and Enabled) and (Sender = Images) then Invalidate else
    if (not Enabled) and (Sender = DisabledImages) then Invalidate else
    if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (Sender = DownImages) then Invalidate else
    if Sender = FImageList then Invalidate;
  end else
  begin
    if (Sender = FBackGround) or ((Sender = FHotBackground) and (FMouseInControl)) or
         ((Sender = FDownBackground) and (FDown and FIsSwitch) or
         (FState in [ebsDown, ebsExclusive]))  then Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetDownImages(newValue : TCustomImageList);
begin
  if (FDownImages <> newValue) then
  begin
    if FDownImages <> nil then
    begin
      if (not (csDestroying in FDownImages.ComponentState)) then
        FDownImages.RemoveFreeNotification(Self);
      FDownImages.UnregisterChanges(FNChLink);
    end;
    FDownImages := newValue;
    if FDownImages <> nil then FDownImages.FreeNotification(Self);
    if FDownImages <> nil then FDownImages.RegisterChanges(FNChLink);
    if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) then
    begin
      if newValue = nil then
        TProxyGlyph(FGlyph).ImageList := FImageList
      else
        TProxyGlyph(FGlyph).ImageList := newValue;
      Invalidate;
    end;
  end;  { if }
end;

procedure TCustomElGraphicButton.SetAlphaDownImages(newValue : TCustomImageList);
begin
  if (FAlphaDownImages <> newValue) then
  begin
    if FAlphaDownImages <> nil then
    begin
      if (not (csDestroying in FAlphaDownImages.ComponentState)) then
        FAlphaDownImages.RemoveFreeNotification(Self);
      FAlphaDownImages.UnregisterChanges(FANChLink);
    end;
    FAlphaDownImages := newValue;
    if FAlphaDownImages <> nil then FAlphaDownImages.RegisterChanges(FANChLink);
    if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) then
    begin
      if newValue = nil then
        TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList
      else
        TProxyGlyph(FGlyph).AlphaImageList := newValue;

      Invalidate;
    end;
    if FAlphaDownImages <> nil then FAlphaDownImages.FreeNotification(Self);
  end;  { if }
end;

procedure TCustomElGraphicButton.SetHotBackground(const Value: TBitmap);
begin
  FHotBackground.Assign(Value);
end;

procedure TCustomElGraphicButton.SetHotImages(newValue : TCustomImageList);
begin
  if (FHotImages <> newValue) then
  begin
    if FHotImages <> nil then
    begin
      if (not (csDestroying in FHotImages.ComponentState)) then
        FHotImages.RemoveFreeNotification(Self);
      FHotImages.UnregisterChanges(FHChLink);
    end;
    FHotImages := newValue;
    if FHotImages <> nil then
    begin
      FHotImages.RegisterChanges(FHChLink);
      FHotImages.FreeNotification(Self);
    end;
    if FMouseInControl then
    begin
      if newValue = nil then TProxyGlyph(FGlyph).ImageList := FImageList else TProxyGlyph(FGlyph).ImageList := newValue;
      Invalidate;
    end;
  end;  { if }
end;  { SetHotImages }

procedure TCustomElGraphicButton.SetAlphaHotImages(newValue : TCustomImageList);
begin
  if (FAlphaHotImages <> newValue) then
  begin
    if FAlphaHotImages <> nil then
    begin
      if (not (csDestroying in FAlphaHotImages.ComponentState)) then
        FAlphaHotImages.RemoveFreeNotification(Self);
      FAlphaHotImages.UnregisterChanges(FAHChLink);
    end;
    FAlphaHotImages := newValue;
    if FAlphaHotImages <> nil then
    begin
      FAlphaHotImages.RegisterChanges(FAHChLink);
      FAlphaHotImages.FreeNotification(Self);
    end;
    if FMouseInControl then
    begin
      if newValue = nil then
        TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList
      else
        TProxyGlyph(FGlyph).AlphaImageList := newValue;
      Invalidate;
    end;
  end;  { if }
end;  { SetAlphaHotImages }

procedure TCustomElGraphicButton.SetDisabledImages(newValue : TCustomImageList);
begin
  if (FDisabledImages <> newValue) then
  begin
    if FDisabledImages <> nil then
    begin
      if (not (csDestroying in FDisabledImages.ComponentState)) then
        FDisabledImages.RemoveFreeNotification(Self);
      FDisabledImages.UnregisterChanges(FDChLink);
    end;
    FDisabledImages := newValue;
    if FDisabledImages <> nil then
    begin
      FDisabledImages.RegisterChanges(FDChLink);
      FDisabledImages.FreeNotification(Self);
    end;
    if not Enabled then
    begin
      if newValue <> nil then
        TProxyGlyph(FGlyph).ImageList := newValue
      else
        TProxyGlyph(FGlyph).ImageList := FImageList;
      Invalidate;
    end;
  end;  { if }
end;  { SetDisabledImages }

procedure TCustomElGraphicButton.SetAlphaDisabledImages(newValue : TCustomImageList);
begin
  if (FAlphaDisabledImages <> newValue) then
  begin
    if FAlphaDisabledImages <> nil then
    begin
      if (not (csDestroying in FAlphaDisabledImages.ComponentState)) then
        FAlphaDisabledImages.RemoveFreeNotification(Self);
      FAlphaDisabledImages.UnregisterChanges(FADChLink);
    end;
    FAlphaDisabledImages := newValue;
    if FAlphaDisabledImages <> nil then
    begin
      FAlphaDisabledImages.RegisterChanges(FADChLink);
      FAlphaDisabledImages.FreeNotification(Self);
    end;
    if not Enabled then
    begin
      if newValue <> nil then
        TProxyGlyph(FGlyph).AlphaImageList := newValue
      else
        TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      Invalidate;
    end;
  end;  { if }
end;  { SetAlphaDisabledImages }

function TCustomElGraphicButton.GetActionLinkClass : TControlActionLinkClass;
begin
  result := TElGraphicButtonActionLink;
end;

procedure TCustomElGraphicButton.ActionChange(Sender : TObject; CheckDefaults : Boolean);
{$ifdef LMD_UNICODE}
var
  PropInfo: PPropInfo;
{$endif}
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
  begin
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Checked = False) then
        Self.Checked := Checked;
    end;
    if Sender is TAction then
    begin
      Enabled := TAction(Sender).Enabled;
      Visible := TAction(Sender).Visible;
{$ifdef LMD_UNICODE}
      PropInfo := TypInfo.GetPropInfo(Sender.ClassInfo, 'Hint');
      if (PropInfo <> nil) and (PropInfo.PropType^.Kind = tkWString) then
        Hint := GetWideStrProp(Sender, 'Hint')
      else
{$endif}
        Hint := TAction(Sender).Hint;
      if TAction(Sender).ShortCut > 0 then
        Hint := Hint + ' ('+ShortCutToText(TAction(Sender).ShortCut)+')';
{$ifdef LMD_UNICODE}
      PropInfo := TypInfo.GetPropInfo(Sender.ClassInfo, 'Caption');
      if (PropInfo <> nil) and (PropInfo.PropType^.Kind = tkWString) then
        Self.Caption := GetWideStrProp(Sender, 'Caption')
      else
{$endif}
        Self.Caption := TAction(Sender).Caption;
      ImageIndex := TAction(Sender).ImageIndex;
      Down := TAction(Sender).Checked;
    end;
  end;
end;

procedure TCustomElGraphicButton.SetThinFrame(newValue : Boolean);
{ Sets data member FThinFrame to newValue. }
begin
  if (FThinFrame <> newValue) then
  begin
    FThinFrame := newValue;
    if newValue then FOldStyled := false;
    if OldStyled or (FMouseInControl and (not (FState in [ebsDown, ebsExclusive]))) then Invalidate;
  end;  { if }
end;  { SetThinFrame }

procedure TCustomElGraphicButton.SetShadowsUseCustom(Value : Boolean);
begin
  if Value <> FShadowsUseCustom then
  begin
    FShadowsUseCustom := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetShadowBtnHighlight(Value : TColor);
begin
  if Value <> FShadowBtnHighlight then
  begin
    FShadowBtnHighlight := Value;
    if FShadowsUseCustom then Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetShadowBtnShadow(Value : TColor);
begin
  if Value <> FShadowBtnShadow then
  begin
    FShadowBtnShadow := Value;
    if FShadowsUseCustom then Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetShadowBtnDkShadow(Value : TColor);
begin
  if Value <> FShadowBtnDkShadow then
  begin
    FShadowBtnDkShadow := Value;
    if FShadowsUseCustom then Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetShadowFollowsColor(Value : Boolean);
begin
  if Value <> FShadowFollowsColor then
  begin
    FShadowFollowsColor := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetBackgroundDrawBorder(Value : boolean);
begin
  if Value <> FBackgroundDrawBorder then
  begin
    FBackgroundDrawBorder := Value;
    if not FBackground.Empty then Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetDownBackground(newValue : TBitmap);
{ Sets data member FDownBackground to newValue. }
begin
  FDownBackground.Assign(newValue);
end;  { SetDownBackground }

procedure TCustomElGraphicButton.SetBackground(newValue : TBitmap);
{ Sets data member FBackground to newValue. }
begin
  FBackground.Assign(newValue);
end;  { SetBackground }

procedure TCustomElGraphicButton.SetTextDrawType(newValue : TLMDTextDrawType);
begin
  if (FTextDrawType <> newValue) then
  begin
    FTextDrawType := newValue;
    Invalidate;
  end; { if }
end; { SetTextDrawType }

procedure TCustomElGraphicButton.SetTransparent(newValue : Boolean);
var R : TRect;
begin
  if (FTransparent <> newValue) then
  begin
    FTransparent := newValue;
    if FTransparent then
    begin
      ControlStyle := ControlStyle - [csOpaque];
      R := Rect(Left, Top, Left + Width, Top + Height);
      if (Parent <> nil) and Parent.HandleAllocated then
        InvalidateRect(Parent.Handle, @R, false);
      Invalidate;
    end
    else
    begin
      ControlStyle := ControlStyle + [csOpaque];
      Invalidate;
    end;
  end; { if }
end; { SetTransparent }

constructor TCustomElGraphicButton.Create(AOwner : TComponent);
begin
  BeginCreate;
  inherited Create(AOwner);
  FNumGlyphs := 1;
  FGlyphMaskUsage := muGlyphList;
  ControlStyle := [csReflector, csSetCaption, csCaptureMouse, csDoubleClicks];
  Width := 75;
  Height := 25;
  FDblClicked := False;
  FAlignment := taCenter;
  FChangeDisabledText := true;
  FMultiLine := False;
  FGlyph := TProxyGlyph.Create;
  FGlyph.OnChange := GlyphChanged;
  FFlat := false;
  FSpacing := 4;
  FMargin := -1;
  FLayout := blGlyphLeft;
  Inc(ButtonCount);
  FUseArrow := False;
  FShowText := true;
  FShowGlyph := true;
  TProxyGlyph(FGlyph).FImageIndex := -1;
  PInteger(@Color)^ := clBtnFace;
  PInteger(@Font.Color)^ := clBtnText;
  FAChLink  := TChangeLink.Create; FAChLink.OnChange := ImagesChanged;
  FChLink  := TChangeLink.Create; FChLink.OnChange := ImagesChanged;
  FDChLink := TChangeLink.Create; FDChLink.OnChange := ImagesChanged;
  FADChLink := TChangeLink.Create; FADChLink.OnChange := ImagesChanged;
  FHChLink := TChangeLink.Create; FHChLink.OnChange := ImagesChanged;
  FAHChLink := TChangeLink.Create; FAHChLink.OnChange := ImagesChanged;
  FNChLink := TChangeLink.Create; FNChLink.OnChange := ImagesChanged;
  FANChLink := TChangeLink.Create; FANChLink.OnChange := ImagesChanged;
  FBackground := TBitmap.Create;
  FDownBackground := TBitmap.Create;
  FHotBackground := TBitmap.Create;
  FShadowFollowsColor := true;
  MenuWindowProc := WndProc;
  {$warnings off}
  FWnd := AllocateHWND(IntWndProc);
  {$warnings on}
  FImgFormChLink  := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FShowBorder := true;
  FAdjustSpaceForGlyph := true;
  ThemeMode := ttmPlatform;
  FLinkStyle := [fsUnderline];
  FLinkColor := clBlue;
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
  EndCreate;
end;

destructor TCustomElGraphicButton.Destroy;
begin
  UseArrow := false;
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
  ImageForm := nil;
  FImgFormChLink.Free;
  {$warnings off}
  DeallocateHWnd(FWnd);
  {$warnings on}
  FDownBackground.Free;
  FBackground.Free;
  FHotBackground.Free;
  Dec(ButtonCount);
  FChLink.Free;
  FAChLink.Free;
  FDChLink.Free;
  FADChLink.Free;
  FHChLink.Free;
  FAHChLink.Free;
  FNChLink.Free;
  FANChLink.Free;

  (*
  if ButtonCount = 0 then
  begin
    Pattern.Free;
    Pattern := nil;
  end;
  *)
  FGlyph.Free;
  UseXPThemes := false;
  if IsHTML then
    FRender.Free;
  FRender := nil;
  inherited Destroy;
end;

procedure TCustomElGraphicButton.SetAdjustSpaceForGlyph(Value: Boolean);
begin
  if FAdjustSpaceForGlyph <> Value then
  begin
    FAdjustSpaceForGlyph := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetCaption(Value: TLMDString);
begin
  if FCaption <> Value then
  begin
    inherited Caption := '';
    FCaption := Value;
    inherited Caption := Value;
  end;
end;

procedure TCustomElGraphicButton.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
end;

procedure TCustomElGraphicButton.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
  end;
//    if XPThemesAvailable then
//      Invalidate;
end;

procedure TCustomElGraphicButton.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

procedure TCustomElGraphicButton.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

procedure TCustomElGraphicButton.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
    begin
      FThemeGlobalMode := Value;
      DoThemeChanged;
    end;
end;

function TCustomElGraphicButton.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

procedure TCustomElGraphicButton.DoThemeChanged;
begin
  Invalidate;
end;

function TCustomElGraphicButton.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

function TCustomElGraphicButton.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

procedure TCustomElGraphicButton.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

procedure TCustomElGraphicButton.ELThemeChanged(var Message: TMessage);
begin
  DoThemeChanged;
  Message.Result := 1;
end;

function TCustomElGraphicButton.GetDetails: TThemedElementDetails;
begin
  if not Enabled then
    result := ThemeServices.GetElementDetails(tbPushButtonDisabled)
  else
  if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
    result := ThemeServices.GetElementDetails(tbPushButtonPressed)
  else
  if FMouseInControl or FMouseInArrow then
    result := ThemeServices.GetElementDetails(tbPushButtonHot)
  else
    result := ThemeServices.GetElementDetails(tbPushButtonNormal);
end;

function TCustomElGraphicButton.GetTextDetails: TThemedElementDetails;
begin
  if not Enabled then
    result := ThemeServices.GetElementDetails(tbPushButtonDisabled)
  else
  if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
    result := ThemeServices.GetElementDetails(tbPushButtonPressed)
  else
  if FMouseInControl or FMouseInArrow then
    result := ThemeServices.GetElementDetails(tbPushButtonHot)
  else
    result := ThemeServices.GetElementDetails(tbPushButtonNormal);
end;

function TCustomElGraphicButton.GetArrowDetails: TThemedElementDetails;
begin
  if not Enabled then
    result := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
  else
  if FState in [ebsArrDown, ebsExclusive] then
    result := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
  else
  if FMouseInControl or FMouseInArrow or Focused then
    result := ThemeServices.GetElementDetails(tcDropDownButtonHot)
  else
    result := ThemeServices.GetElementDetails(tcDropDownButtonNormal);
end;

function TCustomElGraphicButton.GetArrowSize: Integer;
var
  PS  : TSize;
  LThemeMode : TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  if LThemeMode <> ttmNone then
    begin
     if LMDThemeServices.GetThemePartSize(LThemeMode, 0, GetArrowDetails, PS) then
        begin
          Result := PS.cx;
          Inc(Result);
          if Result < 13 then
            Result := 13;
        end
      else
        Result := 13;
    end
  else
  begin
    Result := 13;
    if not FFlat then inc(Result, 2);
  end
end;

procedure TCustomElGraphicButton.IntEnabledChanged;
const
  NewState: array[Boolean] of TLMDExButtonState = (ebsDisabled, ebsUp);
begin
  TProxyGlyph(FGlyph).CreateButtonGlyph(NewState[Enabled]);
  if UseImageList then
  begin
    if ((not Enabled) or (Assigned(Parent) and (not Parent.Enabled))) and (FDisabledImages <> nil) then
    begin
      TProxyGlyph(FGlyph).ImageList := FDisabledImages;
      TProxyGlyph(FGlyph).AlphaImageList := FAlphaDisabledImages;
    end
    else
    begin
      TProxyGlyph(FGlyph).ImageList := FImageList;
      TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList;
    end;
  end;
  UpdateTracking;
  Invalidate;
end;

procedure TCustomElGraphicButton.IntMouseEnter;
var P     : TPoint;
    b     : boolean;
begin
  b := false;
  if Enabled then
  begin
    if (not OldStyled) or IsThemed then
      b := true;

    if UseArrow then
    begin
      GetCursorPos(P);
      P := ScreenToClient(P);
      FMouseInArrow := P.X > ClientWidth - GetArrowSize;
      if not FMouseInArrow then
        FMouseInControl := true;
    end
    else
      FMouseInControl := true;

    if UseImageList then
    begin
      if FHotImages <> nil then
      begin
        if TProxyGlyph(FGlyph).ImageList <> FHotImages then
          b := true;
        TProxyGlyph(FGlyph).ImageList := FHotImages;
        TProxyGlyph(FGlyph).AlphaImageList := FAlphaHotImages;
        end
      else
      begin
        if TProxyGlyph(FGlyph).ImageList <> FImageList then
          b := true;
        TProxyGlyph(FGlyph).ImageList := FImageList;
        TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      end;
    end;
    if b then
    begin
      Invalidate;
    end;
  end;
  if assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TCustomElGraphicButton.IntTextChanged;
begin
  if (Pos(#13#10, Caption) > 0)
  and (not IsHTML)
  then
    FMultiline := true
  else
    FMultiline := false;
  Invalidate;
end;

procedure TCustomElGraphicButton.IntMouseLeave;
var b : boolean;
begin
  b := false;
  if (not OldStyled) or IsThemed then
    b := true;
  if Enabled and (not FDragging) then
  begin
    if UseImageList and (HotImages <> nil) then
    begin
      if TProxyGlyph(FGlyph).ImageList <> FImageList then
        b := true;
      TProxyGlyph(FGlyph).ImageList := FImageList;
      TProxyGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      end;
  end;
  if FMouseInControl or FMouseInArrow then
    b := true;
  FMouseInControl := False;
  FMouseInArrow := false;
  if assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
  if b then
    Invalidate;
end;

procedure TCustomElGraphicButton.DrawThemedBackground(Canvas : TCanvas);
begin
  if not Transparent then
  begin
    LMDThemeServices.DrawElement(UseThemeMode, Canvas.Handle, GetDetails, ClientRect);
//    DrawThemeBackground(Theme, Canvas.Handle, BP_PUSHBUTTON, 0, ClientRect, nil);
  end;
end;

procedure TCustomElGraphicButton.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;
  Handled: Boolean;
  href : TLMDString;
  R    : TRect;
begin
  if csDesigning in ComponentState then Exit;

  Pt := ScreenToClient(SmallPointToPoint(Message.Pos));
  if IsHTML then
  begin
    R := FTextRect;
    if (LinkPopupMenu <> nil) and FRender.IsCursorOverLink(Point(Pt.X - R.Left, Pt.Y - R.Top), Point(0, 0), R, href) then
    begin
      Handled := False;
      Temp := ClientToScreen(Pt);
      DoContextPopup(Temp, Handled);
      Message.Result := Ord(Handled);
      if Handled then Exit;

      DoLinkPopup(ClientToScreen(Pt));
      Message.Result := 1;
    end
    else
      inherited
  end
  else
  inherited;
end;

procedure TCustomElGraphicButton.WMRButtonUp(var Message: TWMRButtonUp);

begin
  inherited;
end;

procedure TCustomElGraphicButton.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  (*if Parent <> nil then
  begin
    Windows.SetParent(FWnd, Parent.Handle);
    SetWindowPos(FWnd, HWND_BOTTOM, Left, Top, Width, Height, SWP_HIDEWINDOW);
  end;
  *)
end;

function TCustomElGraphicButton.MeasureButton(LockHeight : boolean): TPoint;
var Aw : integer;
    inR,
    R  : TRect;
    AHeight : integer;
  LThemeMode : TLMDThemeMode;
  LDetails: TThemedElementDetails;
begin
  LThemeMode := UseThemeMode;
  LDetails := GetDetails;
  Canvas.Font.Assign(Font);
  if UseArrow then
  begin
    aw := GetArrowSize;
    if LThemeMode <> ttmNone then
    begin
      r := Rect(0, 0, aw, aw);
      LMDThemeServices.GetThemeBackgroundExtent(LThemeMode, Canvas.Handle, LDetails, R, inR);
      aw := inR.Right - inR.Left;
    end;
    end
  else
    aw := 0;

  R := Rect(0, 0, Width, Height);
  if LThemeMode <> ttmNone then
  begin
    inR := LMDThemeServices.ContentRect(LThemeMode, Canvas.Handle, LDetails, R);
    if EqualRect(R, inR) then
      InflateRect(inR, -2, -2);
    inR := Rect(0,
                0,
                R.Right - R.Left + (R.Left - InR.Left + InR.Right - R.Right),
                R.Bottom - R.Top + (R.Top - InR.Top + InR.Bottom - R.Bottom));
  end
  else
  begin
    inR := R;
    dec(inR.Right, 4);
    dec(inR.Bottom, 4);
    end;
  if LockHeight then
    AHeight := inR.Bottom
  else
    AHeight := 0;
  result := Point(
         FGlyph.CalcButtonWidth(Canvas, AHeight, Point(0, 0),
             Caption, Layout, Margin, Spacing,
             ShowGlyph, ShowText, FMultiline, aw,
             ttmNone,
             LDetails, true
             , IsHTML, FRender),
         0);
  result.y := AHeight + R.Bottom - inR.Bottom;

  inc(result.x, R.Right - inR.Right);
end; { MeasureButton }

function TCustomElGraphicButton.GetMoneyFlat: Boolean;
begin
  Result := FMoneyFlat;
end;

procedure TCustomElGraphicButton.SetMoneyFlat(Value: Boolean);
begin
  if FMoneyFlat <> Value then
  begin
    FMoneyFlat := Value;
    Invalidate;
    end;
end;

procedure TCustomElGraphicButton.SetMoneyFlatDownColor(Value: TColor);
begin
  if FMoneyFlatDownColor <> Value then
  begin
    FMoneyFlatDownColor := Value;
    if MoneyFlat then Invalidate;
    end;
end;

procedure TCustomElGraphicButton.SetMoneyFlatActiveColor(Value: TColor);
begin
  if FMoneyFlatActiveColor <> Value then
  begin
    FMoneyFlatActiveColor := Value;
    if MoneyFlat then Invalidate;
    end;
end;

procedure TCustomElGraphicButton.SetMoneyFlatInactiveColor(Value: TColor);
begin
  if FMoneyFlatInactiveColor <> Value then
  begin
    FMoneyFlatInactiveColor := Value;
    if MoneyFlat then Invalidate;
    end;
end;

function TCustomElGraphicButton.DoSaveShadows : boolean;
begin
  result := ShadowsUseCustom and not (ShadowFollowsColor);
end;

procedure TCustomElGraphicButton.Click;
begin
  AClick(false);
end;

procedure TCustomElGraphicButton.IntWndProc(var Message : TMessage);
begin
  if @WindowProc <> nil then
    WindowProc(Message)
  else
    WndProc(Message);
end;

procedure TCustomElGraphicButton.DoPullMenu;
var
  q : TPoint;
  LNMon: integer;
  LMon: TMonitor;
begin
  PullDownMenu.PopupComponent := Self;
  PullDownMenu.AutoPopup := True;
  q.X := 0;
  q.Y := 0;
  q := ClientToScreen(q);

  if FPopupPlace = ppRight then
  begin
    q.x := q.X + Width;
    q.y := q.Y;
  end else
  if FPopupPlace = ppDown then
  begin
    q.x := q.X;
    if (PullDownMenu.IsRightToLeft) or ((PullDownMenu is TElPopupMenu) and (TElPopupMenu(PullDownMenu).RightToLeft)) then
      q.x := q.X + Width;
    q.y := q.Y + height;
  end
  else
  begin
    q.x := q.x - 1;
    q.y := q.y - GetSystemMetrics(SM_CYMENU) * PullDownMenu.Items.Count;
    //PullDownMenu.Popup(q.X - 1, q.Y - GetSystemMetrics(SM_CYMENU) * PullDownMenu.Items.Count);
  end;

  LMon := Screen.MonitorFromPoint(q);
  if not Assigned(LMon) then
    Exit;
  LNMon := LMon.MonitorNum;

  if (q.x - Screen.Monitors[LNMon].Left) < 0 then
    q.x := Screen.Monitors[LNMon].Left;
  if q.y + Screen.Monitors[LNMon].Top < 0 then
    q.y := Screen.Monitors[LNMon].Top;

  PullDownMenu.PopupComponent := Self;
  if not FUseArrow then
  begin
    FState := ebsDown;
    FOrigState := ebsDown;
    Invalidate;
  end;
  FInMenu := true;
  if Assigned(PullDownMenu.OnPopup) then
    PullDownMenu.OnPopup(PullDownMenu);

  if PullDownMenu is TElPopupMenu then
  begin
    TrackElPopupMenu(TElPopupMenu(PullDownMenu).Items,
     TPM_LEFTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON,
     q.X, q.Y, FWND);
    FState := ebsUp;
  end
  else
  begin
    PullDownMenu.Popup(q.X, q.Y);
  FState := ebsUp;
    PostMessage(FWnd, WM_EXITMENULOOP, 0, 0);
  end;
// This code doesn't initialize menu under Windows Vista+ and Delphi 2009+
//    TrackPopupMenu(GetMenuHandle(PullDownMenu),
//      TPM_LEFTALIGN or TPM_LEF TBUTTON or TPM_RIGHTBUTTON,
//      q.X, q.Y,
//      0,
//      FWND,
//      nil);

end;

procedure TCustomElGraphicButton.SetShortcutsEnabled(Value: Boolean);
begin
  if FShortcutsEnabled <> Value then
  begin
    FShortcutsEnabled := Value;
    Invalidate;
  end;
end;

function TCustomElGraphicButton.Focused: Boolean;
begin
  Result := false;
end;

procedure TCustomElGraphicButton.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    if FIsHTML then
    begin
      FRender := TLMDHTMLRender.Create;
      FRender.OnImageNeeded := TriggerImageNeededEvent;
    end
    else
    begin
      FRender.Free;
      FRender := nil;
    end;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
  begin
    FLinkColor := newValue;
    Invalidate;
  end;  { if }
end;  { SetLinkColor }

procedure TCustomElGraphicButton.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  if (FLinkPopupMenu <> newValue) then
  begin
    if (FLinkPopupMenu <> nil) and (not (csDestroying in FLinkPopupMenu.ComponentState)) then
      FLinkPopupMenu.RemoveFreeNotification(Self);
    FLinkPopupMenu := newValue;
    if (newValue <> nil) then
       newValue.FreeNotification(Self);
  end;  { if }
end;  { SetLinkPopupMenu }

procedure TCustomElGraphicButton.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
  begin
    FLinkStyle := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkStyle }

procedure TCustomElGraphicButton.DoLinkPopup(MousePos : TPoint);
begin
  if (FLinkPopupMenu <> nil) and FLinkPopupMenu.AutoPopup then
  begin
    SendCancelMode(nil);
    FLinkPopupMenu.PopupComponent := Self;
    if MousePos.X < 0 then
      MousePos := ClientToScreen(Point(0,0));
    FLinkPopupMenu.Popup(MousePos.X, MousePos.Y);
  end;
end;

procedure TCustomElGraphicButton.TriggerImageNeededEvent(Sender : TObject; Src :
    TLMDString; var Image : TBitmap);
begin
  Image := nil;
  if (assigned(FOnImageNeeded)) then
      FOnImageNeeded(Self, Src, Image);
end;  { TriggerImageNeededEvent }

procedure TCustomElGraphicButton.TriggerLinkClickEvent(HRef : TLMDString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

procedure TCustomElGraphicButton.SetImageIsAlphaBlended(Value: Boolean);
begin
  if FImageIsAlphaBlended <> Value then
  begin
    FImageIsAlphaBlended := Value;
//    Invalidate;
  end;
end;

{$ifdef LMD_UNICODE}

procedure TCustomElGraphicButton.CMHintShow(var Message: TMessage);

var
  //T: WideChar;
  HintInfo : PHintInfo;
  //l : integer;
  S : String;
  WS : WideString;

  function AddShortcutToHint(WS : WideString) : WideString;
  begin
    if (WS <> '') and (ActionLink.Action is TCustomAction) and (TCustomAction(ActionLink.Action).ShortCut <> scNone) then
    begin
      result := WS + ' (' + ShortCutToText(TCustomAction(ActionLink.Action).ShortCut) + ')';
    end
    else
      result := WS;
  end;

begin
  HintInfo := PHintInfo(Message.lParam);
  if Length(FHint) = 0 then
  begin
    HintInfo.hintStr := '';
    exit;
  end;

  S := GetShortHint(inherited Hint);
  if HintInfo.HintStr = S then
  begin
    WS := LMDWideGetShortHint(FHint);
    if Application.HintShortCuts and (ActionLink <> nil) then
      WS := AddShortcutToHint(WS);
    end
  else
  begin
    if Application.HintShortCuts and (ActionLink <> nil) then
      WS := AddShortcutToHint(FHint)
    else
    WS := FHint;

    S := WS;
  end;

  //outcommented VB Dec 2008
  (*
  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
  *)
  end;

procedure TCustomElGraphicButton.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;

{$endif}

procedure TCustomElGraphicButton.SetCursor(Value: TCursor);
var P : TPoint;
    R : TRect;
    href : TLMDString;
begin
  if (FCursor <> Value) then
  begin
    FCursor := Value;
    if IsHTML then
    begin
      GetCursorPos(P);
      P := ScreenToClient(P);
      R := FTextRect;
      if FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
        inherited Cursor := crHandPoint
      else
        inherited Cursor := FCursor;
    end
    else
    inherited Cursor := FCursor;
  end;  { if }
end;  { SetCursor }

procedure TCustomElGraphicButton.SetChangeDisabledText(Value: Boolean);
begin
  if FChangeDisabledText <> Value then
  begin
    FChangeDisabledText := Value;
    if FState = ebsDisabled then
      Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    if (FAlignment <> taCenter) and (FMargin = -1) then
      FMargin := 0;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.ButtonClick;
var
  First, Last: Integer;
begin
  if not FDown then
  begin
    FState := ebsDown;
    Repaint;
  end;
  First := GetTickCount;
  repeat
    Last := GetTickCount;
  until ((Last - First) >= 25) or (Last < First);
  FState := ebsUp;
  if GroupIndex = 0 then
  begin
    Click;
    Repaint;
  end
  else
  begin
    Down := not Down;
    Click;
  end;
end;

procedure TCustomElGraphicButton.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    if (FStyleManager <> nil) then
       FStyleManager.UnregisterChanges(FStyleMgrLink);
    FStyleManager := Value;
    if FStyleManager <> nil then
    begin
      FStyleManager.FreeNotification(Self);
      FStyleManager.RegisterChanges(FStyleMgrLink);
      UpdateStyle;
    end;
  end;
end;

procedure TCustomElGraphicButton.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TCustomElGraphicButton.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
end;

procedure TCustomElGraphicButton.UpdateStyle;
var
  R: TRect;
begin
  if ComponentState * [csLoading, csReading] <> [] then
    exit;
  if FStyleManager <> nil then
  begin
    FStyleManager.ApplyStyle(Self, StyleName);
    if Visible then
    begin
      if Transparent and (Parent <> nil) and Parent.HandleAllocated and Parent.Visible then
      begin
        R := Rect(Left, Top, Left + Width, Top + Height);
        InvalidateRect(Parent.Handle, @R, false);
      end;
      Invalidate;
    end;
  end;
end;

function TCustomElGraphicButton.GetShowGlyph: Boolean;
begin
  Result := FShowGlyph;
end;

procedure TCustomElGraphicButton.DoClick;
begin
  inherited Click;
end;

procedure TCustomElGraphicButton.BeginCreate;
begin
  inc(FCreating);
end;

procedure TCustomElGraphicButton.EndCreate;
begin
  dec(FCreating);
  if FCreating = 0 then
    begin
      if not (csDesigning in ComponentState) then
        StyleManager := DefaultStyleManager;
    end;
end;

procedure TElGraphicButtonActionLink.SetImageIndex(Value: Integer);
begin
  if FClient is TCustomElGraphicButton then
  begin
    TCustomElGraphicButton(FClient).ImageIndex := value;
  end;
end;

procedure TElGraphicButtonActionLink.AssignClient(AClient : TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as TCustomElGraphicButton;
end;

function TElGraphicButtonActionLink.IsCheckedLinked : Boolean;
begin
  Result := inherited IsCheckedLinked and
    (FClient.Checked = (Action as TCustomAction).Checked);
end;

function TElGraphicButtonActionLink.IsImageIndexLinked : Boolean;
begin
  result := true;
end;

procedure TElGraphicButtonActionLink.SetChecked(Value : Boolean);
begin
  if IsCheckedLinked then
  begin
    FClient.ClicksDisabled := True;
    try
      FClient.Checked := Value;
    finally
      FClient.ClicksDisabled := False;
    end;
  end;
end;

procedure TElGraphicButtonActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then
    FClient.Caption := Value;
  inherited;
end;

procedure TElGraphicButtonActionLink.SetHint;
begin
  if IsHintLinked then
    FClient.Hint := Value;
  inherited;
end;

function TElGraphicButtonActionLink.IsCaptionLinked : Boolean;
{$ifdef LMD_UNICODE}
var
  PropInfo: PPropInfo;
{$endif}
begin
  Result := false;
{$ifdef LMD_UNICODE}
  PropInfo := TypInfo.GetPropInfo(Action.ClassInfo, 'Caption');
  if (PropInfo <> nil) and (PropInfo.PropType^.Kind = tkWString) then
    Result := (Action is TCustomAction) and (TCustomElGraphicButton(FClient).Caption = GetWideStrProp(Action, 'Caption'))
  else
{$endif}
    if FClient is TCustomElGraphicButton then
      Result := TCustomElGraphicButton(FClient).Caption = (Action as TCustomAction).Caption;
end;

function TElGraphicButtonActionLink.IsHintLinked: Boolean;
{$ifdef LMD_UNICODE}
var
  PropInfo: PPropInfo;
{$endif}
begin
  Result := false;
{$ifdef LMD_UNICODE}
  PropInfo := TypInfo.GetPropInfo(Action.ClassInfo, 'Caption');
  if (PropInfo <> nil) and (PropInfo.PropType^.Kind = tkWString) then
    Result := (Action is TCustomAction) and (TCustomElGraphicButton(FClient).Hint = GetWideStrProp(Action, 'Hint'))
  else
{$endif}
    if FClient is TCustomElGraphicButton then
      Result := TCustomElGraphicButton(FClient).Hint = StrPas(PChar((Action as TCustomAction).Hint));
end;

procedure TCustomElGraphicButton.WMLButtonDblClk(var Message: TWMLButtonDown);
begin
  inherited;
//  if FDown then DblClick;
  DblClick;
end;

procedure TCustomElPopupButton.SetGlyphMaskUsage(
  const Value: TLMDGlyphListMaskUsage);
begin
  FGlyphMaskUsage := Value;
  Repaint;
end;

procedure TCustomElGraphicButton.SetGlyphMaskUsage(
  const Value: TLMDGlyphListMaskUsage);
begin
  FGlyphMaskUsage := Value;
end;

{ TProxyGlyph }


initialization
  MenuCancelMsg := RegisterWindowMessage('El - Cancel pulldown menu');
end.
