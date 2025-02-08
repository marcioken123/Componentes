unit ElPgCtl;
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

ElPgCtl unit
------------

Changes
-------
Release 7.1 (June 2009)
- Fixed initial tabs refreshment (see BTS #711)

Release 6.08 (June 2008)
[+] TabMarginLeft, TabMarginRight properties added. Defines the space before and
    after tabs area.

Release 6.01 (March 2008)
- TElPageControl: ShowAccelChar property added (bts 539)

December 2007 (EK)

[+] OnDrawTabsBackground: event was added to draw space behind tabs.
    It has effect only if UseXPThemes is off.

Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Windows, Math, Messages, Consts, Graphics, Controls, Forms,
  Menus, CommCtrl, ExtCtrls, ImgList, Types, Themes, UxTheme,

  ElSndMap, ElPanel, ElImgFrm, ElStyleMan, ElVCLUtils, ElXPThemedControl,

  LMDTypes, LMDSysIn, LMDProcs,
  LMDThemes, LMDClass, LMDUnicode, LMDStrings, LMDObjectList, LMDUnicodeStrings, LMDGraph;

const
  PM_REFRESHACTIVEPAGE = WM_USER + 7434;

type
  TElTabStyle = (etsTabs, etsButtons, etsFlatButtons, etsNetTabs, etsFlatTabs, etsModernAngledTabs, etsAngledTabs, etsBitmapTabs);
  TElTabPosition = (etpTop, etpBottom, etpRight, etpLeft);
  TElTabDrawState = (edsBackground, edsEdges, edsContents);
  TElPageScrollBtnState = (pbsNone, pbsLeftBtnOver, pbsLeftBtnDown, pbsLeftBtnHeld,
                           pbsRightBtnOver, pbsRightBtnDown, pbsRightBtnHeld);
  TElCloseBtnMode = (cbmNone, cbmActive, cbmAll);

  TElPageControl = class;
  TElTabSheet = class;
  TElTab = class;

  TElMeasureTabEvent = procedure(Sender: TObject; Canvas: TCanvas; Page: TElTabSheet; var Size: TSize) of object;

  TElPaintTabEvent = procedure(Sender: TObject; Canvas: TCanvas; Page:
    TElTabSheet; Rect: TRect; DrawStep: TElTabDrawState; var DefaultDrawing:
    boolean) of object;

  TElTabGetImageEvent = procedure(Sender: TObject; PageIndex: integer;
    var ImageIndex: integer) of object;
  TElTabChangingEvent = procedure(Sender: TObject; NewPage: TElTabSheet;
    var AllowChange: Boolean) of object;
  TElDrawTabsBackgroundEvent = procedure (Sender:TObject; Canvas: TCanvas; Rect:TRect) of object;

  TElTabSheet = class(TCustomControl)
  protected
    FOnShow: TNotifyEvent;
    FOnHide: TNotifyEvent;
    FTabColor: TColor;
    FPageControl: TElPageControl;
    FImageIndex: integer;
    FTabVisible: Boolean;
    FCaption: TLMDString;
    FTabEnabled: Boolean;
    FTabMenu: TPopupMenu;
{$IFDEF LMD_UNICODE}
    FHint: TLMDString;
{$ENDIF}
    FUseTabColor: Boolean;
    FUseFontForTabs: Boolean;
    FCloseBtnEnabled: Boolean;
    FTabShowing: Boolean;
    FRect: TRect;
    FComplete: boolean;
    FLine: integer;
    FShown: boolean;
    FShowCloseButton: Boolean;
    FCloseBtnRect: TRect;
    FCloseBtnDown: boolean;
    FCloseBtnOwer: boolean;
    FStyleMgrLink: TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    FCreating: Integer;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMShowingChanged(var Message: TMessage); message
      CM_SHOWINGCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message
      CM_ENABLEDCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;

    procedure WMEraseBkgnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message
      WM_LBUTTONDBLCLK;
    procedure SetTabShowing(Value: Boolean);
    procedure UpdateTabShowing;
    function GetPageIndex: Integer;
    procedure SetPageIndex(Value: Integer);
//    function GetBtnTheme: TLMDThemeMode;
//    function GetScrollTheme: TLMDThemeMode;
//    function GetCloseBtnTheme: TLMDThemeMode;
//    function GetTabTheme: TLMDThemeMode;
    function GetUseXPThemes: Boolean;
    procedure SetShowCloseButton(Value: Boolean);

    procedure TriggerShowEvent; virtual;
    procedure TriggerHideEvent; virtual;
    procedure SetTabColor(Value: TColor);
    procedure SetPageControl(Value: TElPageControl);
    procedure SetImageIndex(Value: integer);
    procedure SetTabVisible(Value: Boolean);
    procedure SetCaption(Value: TLMDString);
    function GetCaption: TLMDString;
    function GetTabIndex: Integer; virtual;

    procedure SetTabEnabled(Value: Boolean);
    procedure SetTabMenu(Value: TPopupMenu);
    procedure CreateWnd; override;
    procedure ReadState(Reader: TReader); override;
    procedure SetStyleManager(Value: TElStyleManager); virtual;
    procedure SetStyleName(const Value: string); virtual;
    procedure StyleMgrChange(Sender: TObject);
    procedure UpdateStyle;
    {$IFDEF LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$ENDIF}
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;

    procedure SetUseTabColor(Value: Boolean);
    function CloseButtonVisible: Boolean;
    procedure SetUseFontForTabs(Value: Boolean);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetCloseBtnEnabled(Value: Boolean);
    function GetInheritedHint: string;
    procedure BeginCreate;
    procedure EndCreate;

    property TabShowing: Boolean read FTabShowing;
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DestroyHandle; {$ifdef LMDCOMP9}override;{$endif}
    procedure SelectFirst;
    function IsThemed: Boolean;
    property TabIndex: Integer read GetTabIndex;
//    property TabTheme: TLMDThemeMode read GetTabTheme;
//    property BtnTheme: TLMDThemeMode read GetBtnTheme;
//    property ScrollTheme: TLMDThemeMode read GetScrollTheme;
//    property CloseBtnTheme: TLMDThemeMode read GetCloseBtnTheme;
    property UseXPThemes: Boolean read GetUseXPThemes;
  published
    property TabColor: TColor read FTabColor write SetTabColor default
      clBtnFace;

    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;

    property PageControl: TElPageControl read FPageControl write SetPageControl;
    property ImageIndex: integer read FImageIndex write SetImageIndex default
      -1;
    property TabVisible: Boolean read FTabVisible write SetTabVisible default
      true;
    property Caption: TLMDString read GetCaption write SetCaption;
    property PageIndex: Integer read GetPageIndex write SetPageIndex stored
      False;
    property TabEnabled: Boolean read FTabEnabled write SetTabEnabled default
      true;
    property TabMenu: TPopupMenu read FTabMenu write SetTabMenu;
    property UseTabColor: Boolean read FUseTabColor write SetUseTabColor default
    false;
    property ShowCloseButton: Boolean read FShowCloseButton write
    SetShowCloseButton default false;
{$IFDEF LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
{$ENDIF}
    property UseFontForTabs: Boolean read FUseFontForTabs write SetUseFontForTabs
    default true;
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    property CloseBtnEnabled: Boolean read FCloseBtnEnabled write
    SetCloseBtnEnabled default true;

    // inherited properties
    property Color default clBtnFace;
    property ParentColor default false;
    property Visible;

    property BorderWidth;
    property Constraints;
    property DragMode;
    property Enabled;
    property Font;
    property ParentFont;
    property Left stored false;
    property Top stored false;
    property Height stored False;
    property Width stored False;

    property OnContextPopup;

    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnResize;

    property OnStartDrag;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    {$IFDEF LMCCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
  end;

  TElTabClass = class of TElTab;
  TElTabSheetClass = class of TElTabSheet;

  TElPageCloseQueryEvent = procedure(Sender: TObject; Page: TElTabSheet;
    var CanClose: Boolean) of object;

  TElPageControl = class(TElXPThemedControl)
  protected
    FTabMarginLeft, FTabMarginRight: integer;
    FSize: TSize;
    FDenyChanging: Boolean;
    FBTab: TBitmap;
    FActiveTab: TBitmap;
    FCloseButton: TBitmap;

    FTab: TElTab;
//    FTabCaptions: TLMDStrings;
    FRecalcTabPos: Boolean;
    FLines: Integer;
    FScrollLeftRect,
      FScrollRightRect: TRect;
    FTabsPos: TPoint;
    FTabsSize: TSize;
    FMemDC: HDC;
    FScrollBtnState: TElPageScrollBtnState;
    FSaveCapture: HWND;
    FScrollTimer: TTimer;
    FTabIndex: integer;
    FHintCoords: TPoint;
    FHintTimer: TTimer;
    FHintWnd: THintWindow;
    FNoDTAlert: Boolean;
    FDragTab: TElTabSheet;
    FDoStartDrag: integer;
    FDragPos : TPoint;
    FDraggablePages: boolean;

    FActivateSound: TElSoundName;

    FActivePage: TElTabSheet;
    FActiveTabColor: TColor;
    //FBackground: TBitmap;
    //FBackgroundType: TLMDBackgroundType;
    FDownTab: TElTabSheet;
    FDrawFocus: Boolean;
    FDummyCaption: string;
    FFirstTab: TElTabSheet;
    FNoSetFirstTab: boolean;
    FFlat: Boolean;
    FGradientEndColor: TColor;
    FGradientStartColor: TColor;
    FGradientSteps: Integer;
    FHotTrack: Boolean;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FAImageChangeLink: TChangeLink;
    FAlphaImages: TCustomImageList;

    FImgForm: TElImageForm;
    FImgFormChLink: TImgFormChangeLink;

    FInactiveTabColor: TColor;
    FMinTabHeight: Integer;
    FMinTabWidth: Integer;
    FMultiLine: Boolean;
    FNewDockSheet: TElTabSheet;
    FOnChange: TNotifyEvent;
    FOnGetImageIndex: TElTabGetImageEvent;
    FOnMeasureTab: TElMeasureTabEvent;
    FOnChanging: TElTabChangingEvent;
    FPages: TLMDObjectList;
    FRaggedRight: Boolean;
    FScrollOpposite: Boolean;
    FShowBorder: Boolean;
    FShowImages: Boolean;
    FShowTabs: Boolean;

    FSoundMap: TElSoundMap;

    FStyle: TElTabStyle;
    FTabHeight: DWORD;
    FTabPosition: TElTabPosition;
    FTabWidth: DWORD;
    //FTmpBmp: TBitmap;
    FTrackTab: TElTabSheet;
    FUndockingPage: TElTabSheet;
    FDockMouseDown: Boolean;
    FDockMousePos: TPoint;

    FTabBkColor: TColor;

    FOnClosePageQuery: TElPageCloseQueryEvent;
    FHotTrackFont: TFont;
    FShowTabHints: Boolean;
    FSavvyMode: Boolean;
    FFlatTabBorderColor: TColor;
    FTabBkColorNetStyle: TColor;
    FVerticalSideCaptions: Boolean;
    FActiveTabFont: TFont;
    FUseActiveTabFont: Boolean;
    FTabCursor: TCursor;
    {$IFDEF LMD_UNICODE}
    FHint: TLMDString;
{$ENDIF}
    FOnDrawTab: TElPaintTabEvent;
    FOnDrawTabsBackground: TElDrawTabsBackgroundEvent;
    FDefaultPage: TElTabSheet;
    FCloseBtnMode: TElCloseBtnMode;
    FCenterTabCaptions: Boolean;
    FUpdateCount: Integer;
    FUpdated: Integer;
    FTabClass: TElTabClass;
    FTabSheetClass: TElTabSheetClass;
    FShowAccelChar: Boolean;

    procedure BmpActiveTabChanged(Sender: TObject);
    procedure BmpTabChanged(Sender: TObject);
    procedure BmpCloseButtonChanged(Sender: TObject);
    procedure SetShowAccelChar(Value: Boolean);
    procedure Resize; override;
    procedure SetTabMarginLeft(Value: integer);
    procedure SetTabMarginRight(Value: integer);
//    function GetThemedClassName: TLMDThemedItem; override;
    function GetThemedElement: TThemedElement; override;
    function CanChange(NewPage: TElTabSheet; FireOnChanging: Boolean = True): Boolean; virtual;
    function CanScrollLeft: Boolean;
    procedure Change; virtual;
    procedure ChangeActivePage(Page: TElTabSheet); virtual;
    procedure DoDrawTabs(ACanvas: TCanvas; Rect: TRect; DoDraw: boolean; var Size:
        TSize); virtual;
//    function GetBtnTheme: HTheme;
//    function GetScrollTheme: HTheme;
//    function GetTabTheme: HTheme;
    function MeasureSheet(ACanvas: TCanvas; Sheet: TElTabSheet): TSize;

    procedure DoThemeChanged; override;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
      WM_WINDOWPOSCHANGED;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;

    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMLButtonDown(var Message: TWMLBUTTONDOWN); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLBUTTONUP); message WM_LBUTTONUP;
    procedure WMRButtonUp(var Message: TWMRBUTTONUP); message WM_RBUTTONUP;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMDockNotification(var Message: TCMDockNotification); message CM_DOCKNOTIFICATION;

    procedure CMControlListChange(var Message: TMessage); message CM_CONTROLLISTCHANGE;
    procedure CMFocusChanged(var Message: TMessage); message CM_FOCUSCHANGED;
    procedure CMUnDockClient(var Message: TCMUnDockClient); message CM_UNDOCKCLIENT;
    procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;

    procedure CMParentFontChanged(var Msg: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;

    procedure SelectFirstTab;
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DockOver(Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
    procedure DoRemoveDockClient(Client: TControl); override;

    function GetActivePageIndex: Integer;

    function GetDockClientFromMousePos(MousePos: TPoint): TControl;

    function GetPageCount: Integer;

    function GetPageFromDockClient(Client: TControl): TElTabSheet;

    function GetPages(index: integer): TelTabSheet;

    procedure GetSiteInfo(Client: TControl; var InfluenceRect: TRect; MousePos:
      TPoint; var CanDock: Boolean); override;

    function GetBitmapActiveTab: TBitmap;
    function GetBitmapCloseBtn: TBitmap;
    function GetBitmapTab: TBitmap;
    procedure SetBitmapActiveTab(const Value: TBitmap);
    procedure SetBitmapCloseBtn(const Value: TBitmap);
    procedure SetBitmapTab(const Value: TBitmap);

    function GetTabIndex: Integer;
    // procedure ImageChange(Sender : TObject);
    procedure ImageFormChange(Sender: TObject);
    procedure ImageListChange(Sender: TObject);
    procedure InsertPage(TabSheet: TElTabSheet); virtual;
    procedure MakeTabVisible(ATabSheet: TElTabSheet);
    procedure RebuildTabs(ResetFirstItem: boolean);
    // procedure RedoTmpBmp;
    procedure RemovePage(TabSheet: TElTabSheet); virtual;
    procedure SetActivePage(Value: TElTabSheet);
    procedure SetActivePageIndex(const Value: Integer);
    procedure SetActiveTabColor(Value: TColor);
    //procedure SetBackground(newValue: TBitmap);
    //procedure SetBackgroundType(newValue: TLMDBackgroundType);
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetDrawFocus(Value: Boolean);
    procedure SetFirstTab(Value: TElTabSheet);
    function GetLastTab: TElTabSheet;
    procedure SetFlat(newValue: Boolean);
    //procedure SetGradientEndColor(newValue : TColor);
    //procedure SetGradientStartColor(newValue : TColor);
    //procedure SetGradientSteps(newValue : integer);
    procedure SetHotTrack(newValue: Boolean);

    procedure SetImageForm(newValue: TElImageForm);

    procedure SetImages(newValue: TCustomImageList);
    procedure SetAlphaImages(newValue: TCustomImageList);
    procedure SetInactiveTabColor(Value: TColor);
    procedure SetMinTabHeight(Value: Integer);
    procedure SetMinTabWidth(Value: Integer);
    procedure SetMultiLine(newValue: Boolean);
    procedure SetRaggedRight(const Value: Boolean);
    procedure SetScrollOpposite(const Value: Boolean);
    procedure SetShowBorder(Value: Boolean);
    procedure SetShowImages(newValue: Boolean);
    procedure SetShowTabs(Value: Boolean);
    procedure SetStyle(newValue: TElTabStyle);
    procedure SetTabHeight(newValue: DWORD);
    procedure SetTabIndex(const Value: integer);
    procedure SetTabPosition(newValue: TElTabPosition);
    procedure SetTabWidth(newValue: DWORD);
    procedure ShowControl(AControl: TControl); override;
    procedure UpdateActivePage; virtual;
    procedure UpdateTab(TabSheet: TElTabSheet);
    function CanScrollRight: Boolean;
    procedure SetHotTrackFont(Value: TFont);
    procedure HotTrackFontChange(Sender: TObject);
    procedure Paint; override;
    procedure SetScrollBtnState(Value: TElPageScrollBtnState);
    procedure SetTrackTab(Value: TElTabSheet);
    procedure OnScrollTimer(Sender: TObject);
    procedure SetTabBkColor(Value: TColor);
    function HasVisibleTabs: Boolean;
    function DoHitTest(X, Y: integer; var Res: LRESULT): boolean;
    procedure UpdateMultilineOrder;
    procedure TriggerGetImageEvent(PageIndex: integer; var ImageIndex: integer);
      virtual;
    procedure TriggerMeasureTabEvent(Canvas: TCanvas; Page: TElTabSheet; var
      Size: TSize); virtual;

    procedure IFMRepaintChildren(var Message: TMessage); message
      IFM_REPAINTCHILDREN;

    procedure IFMEffectiveSize(var Message: TMessage); message
      IFM_EFFECTIVESIZE;
    procedure IFMCanPaintBkgnd(var Message: TMessage); message
      IFM_CANPAINTBKGND;
    procedure PMRefreshActivePage(var Message: TMessage); message PM_REFRESHACTIVEPAGE;
    procedure OnHintTimer(Sender: TObject); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetSavvyMode(Value: Boolean);
    procedure SetFlatTabBorderColor(Value: TColor);
    procedure SetTabBkColorNetStyle(Value: TColor);
    procedure SetVerticalSideCaptions(Value: Boolean);
    procedure SetDraggablePages(Value: boolean);
    {$IFDEF LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$ENDIF}
    procedure SetActiveTabFont(Value: TFont);
    procedure SetUseActiveTabFont(Value: Boolean);
    procedure ActiveTabFontChange(Sender: TObject);
    procedure Loaded; override;
    procedure TriggerDrawTabEvent(Canvas: TCanvas; Page: TElTabSheet; Rect:
      TRect; DrawStep:
      TElTabDrawState; var DefaultDrawing: boolean); virtual;
    procedure SetCloseButtonMode(Value: TElCloseBtnMode);
    procedure TriggerClosePageQueryEvent(Sheet: TElTabSheet; var CanClose:
      boolean); virtual;
    procedure ChangeScale(M, D: Integer); override;
    procedure WndProc(var Message: TMessage); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure SetCenterTabCaptions(Value: Boolean);
    procedure ReadDrawFocus(Reader: TReader);
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure IntMouseDown(XPos, YPos : integer);
    procedure IntLButtonUp(XPos, YPos : integer);
    procedure IntRButtonUp(XPos, YPos : integer);
    procedure IntMouseMove(XPos, YPos : integer);
    procedure IntKeyDown(var Key : Word);
    procedure Realign;
    procedure RecalcTabPositions;
    function CalcTabAreaSize: TSize; virtual;
    procedure DrawTabs(ACanvas: TCanvas; R: TRect; DoDraw: boolean; var Size: TSize);
    function GetRotatedFont(Canvas: TCanvas; RotationAngle: integer): HFont;
    procedure ReorderPages(MaxRows: integer);
    procedure SetTabClass(Value: TElTabClass);
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure CMVisiblechanged(var Message: TMessage); message CM_VISIBLECHANGED;
    property ScrollBtnState: TElPageScrollBtnState read FScrollBtnState write SetScrollBtnState;
//    property TabTheme: HTheme read GetTabTheme;
    property TabSheetClass: TElTabSheetClass read FTabSheetClass write FTabSheetClass;
    function IsFontStored: boolean;
    (*
    property Background: TBitmap read FBackground write SetBackground;
    property BackgroundType: TLMDBackgroundType read FBackgroundType write
        SetBackgroundType default bgtColorFill;
    property GradientEndColor: TColor read FGradientEndColor write
        SetGradientEndColor;
    property GradientStartColor: TColor read FGradientStartColor write
        SetGradientStartColor;
    property GradientSteps: Integer read FGradientSteps write SetGradientSteps default 16;
    *)

//  function GetBtnThemeHandle: HTheme;
//  function GetScrollThemeHandle: HTheme;
//  function GetCloseBtnThemeHandle: HTheme;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindNextPage(CurPage: TElTabSheet; GoForward, CheckTabVisible,
      CheckTabEnabled: Boolean): TElTabSheet;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SelectNextPage(GoForward: Boolean);
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function TabFromPoint(Point: TPoint): TElTabSheet;
    procedure UpdateTabs(Immediate: boolean);
    function NewPage: TElTabSheet; virtual;
    procedure BeginUpdate;
    procedure EndUpdate;
    property ActivePageIndex: Integer read GetActivePageIndex write SetActivePageIndex;
    property FirstTab: TElTabSheet read FFirstTab write SetFirstTab;
    property LastTab: TElTabSheet read GetLastTab;
    property PageCount: Integer read GetPageCount;
    property Pages[index: integer]: TElTabSheet read GetPages;
    property TrackTab: TElTabSheet read FTrackTab write SetTrackTab;
//    property BtnTheme: HTheme read GetBtnThemeHandle;
//    property ScrollTheme: HTheme read GetScrollThemeHandle;
//    property CloseBtnTheme: HTheme read GetCloseBtnThemeHandle;
    property TabBkColorNetStyle: TColor read FTabBkColorNetStyle write
      SetTabBkColorNetStyle nodefault;
    property TabClass: TElTabClass read FTabClass write SetTabClass;
  published

    property ActivateSound: TElSoundName read FActivateSound write
      FActivateSound;

    property ActiveTabColor: TColor read FActiveTabColor write SetActiveTabColor default clBtnFace;
    property Color default clBtnFace;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar default true;
    property DrawFocusRect: Boolean read FDrawFocus write SetDrawFocus default false;
    property Flat: Boolean read FFlat write SetFlat default false;
    property HotTrack: Boolean read FHotTrack write SetHotTrack default true;

    property ImageForm: TElImageForm read FImgForm write SetImageForm;

    property Images: TCustomImageList read FImages write SetImages;
    property AlphaForImages: TCustomImageList read FAlphaImages write SetAlphaImages;
    property InactiveTabColor: TColor read FInactiveTabColor write SetInactiveTabColor default clBtnFace;
    property MinTabHeight: Integer read FMinTabHeight write SetMinTabHeight default 40;
    property MinTabWidth: Integer read FMinTabWidth write SetMinTabWidth default 40;
    property Multiline: Boolean read FMultiLine write SetMultiLine default false;
    property OnChanging: TElTabChangingEvent read FOnChanging write FOnChanging;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnGetImageIndex: TElTabGetImageEvent read FOnGetImageIndex write FOnGetImageIndex;
    property OnMeasureTab: TElMeasureTabEvent read FOnMeasureTab write FOnMeasureTab;
    property RaggedRight: Boolean read FRaggedRight write SetRaggedRight default false;
    property ScrollOpposite: Boolean read FScrollOpposite write SetScrollOpposite
      default false;
    property ShowBorder: Boolean read FShowBorder write SetShowBorder default
      true;
    property ShowImages: Boolean read FShowImages write SetShowImages default
      true;
    property ShowTabs: Boolean read FShowTabs write SetShowTabs default true;

    property SoundMap: TElSoundMap read FSoundMap write FSoundMap;

    property BitmapTab: TBitmap read GetBitmapTab write SetBitmapTab;
    property BitmapActiveTab: TBitmap read GetBitmapActiveTab write SetBitmapActiveTab;
    property BitmapCloseButton: TBitmap read GetBitmapCloseBtn write SetBitmapCloseBtn;

    property Style: TElTabStyle read FStyle write SetStyle default etsTabs;
    property TabHeight: DWORD read FTabHeight write SetTabHeight default 0;
    property TabIndex: Integer read GetTabIndex write SetTabIndex default -1;
    property TabPosition: TElTabPosition read FTabPosition write SetTabPosition
      default etpTop;
    property TabWidth: DWORD read FTabWidth write SetTabWidth default 0;
    property HotTrackFont: TFont read FHotTrackFont write SetHotTrackFont stored IsFontStored;
    property TabBkColor: TColor read FTabBkColor write SetTabBkColor default
    clBtnFace;
    property ActivePage: TElTabSheet read FActivePage write SetActivePage;
    property ShowTabHints: Boolean read FShowTabHints write FShowTabHints default
    true;
    property SavvyMode: Boolean read FSavvyMode write SetSavvyMode default
      false;
    property FlatTabBorderColor: TColor read FFlatTabBorderColor write
      SetFlatTabBorderColor default clBtnShadow;
    property VerticalSideCaptions: Boolean read FVerticalSideCaptions write
    SetVerticalSideCaptions default true;
    property DraggablePages: boolean read FDraggablePages write SetDraggablePages
      default false;
    property ActiveTabFont: TFont read FActiveTabFont write SetActiveTabFont;
    property UseActiveTabFont: Boolean read FUseActiveTabFont write
    SetUseActiveTabFont default false;
    property TabCursor: TCursor read FTabCursor write FTabCursor default
      crDefault;
    property OnDrawTab: TElPaintTabEvent read FOnDrawTab write FOnDrawTab;
    property DefaultPage: TElTabSheet read FDefaultPage write FDefaultPage;
    property CloseButtonMode: TElCloseBtnMode read FCloseBtnMode write
      SetCloseButtonMode default cbmNone;
    property CenterTabCaptions: Boolean read FCenterTabCaptions write
    SetCenterTabCaptions default false;
    property OnDrawTabsBackground: TElDrawTabsBackgroundEvent read FOnDrawTabsBackground write
    FOnDrawTabsBackground;

{$IFDEF LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
{$ENDIF}
    property TabMarginLeft: integer read FTabMarginLeft write SetTabMarginLeft default 0;
    property TabMarginRight: integer read FTabMarginRight write SetTabMarginRight default 0;

    property OnResize;

    property OnClosePageQuery: TElPageCloseQueryEvent read FOnClosePageQuery
      write FOnClosePageQuery;
    property Align;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property TabOrder;
    property TabStop;
    property ShowHint;
    property Visible;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;

    property OnDblClick;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnEnter;
    property OnExit;

    property OnContextPopup;

    property Anchors;
    property Constraints;
    property DockSite;
    property DockOrientation;
    property DragKind;

    property OnStartDock;
    property OnUnDock;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
  end;

  TElTab = class(TObject)
  private
    FOwner: TElPageControl;
    procedure Draw(ACanvas: TCanvas; R: TRect; TabSheet: TElTabSheet);
//    function GetBtnTheme: TLMDThemeMode;
//    function GetScrollTheme: TLMDThemeMode;
//    function GetTabTheme: TLMDThemeMode;
//    function GetCloseBtnTheme: TLMDThemeMode;
    function GetTabPosition: TElTabPosition;
  protected
    function GetOuterMargin: Integer; virtual;
    function GetInnerMargin: Integer; virtual;
    procedure DrawTabContents(Canvas: TCanvas; R: TRect; TabSheet: TElTabSheet); virtual;
    procedure DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my: integer); virtual;
    function CanDrawTab(ActiveDraw: boolean): Boolean; virtual;
    function GetAscend: Integer; virtual;
    procedure AdjustDrawingSize(Active: boolean; var R: TRect); virtual;
    procedure AdjustTabSize(var Size: TSize); virtual;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet: TElTabSheet); virtual;
    procedure DrawTabLine(Canvas: TCanvas; R: TRect); virtual;
    procedure FillSpace(Canvas: TCanvas; Rect: TRect); virtual;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet); virtual;
    procedure DrawButtons(Canvas: TCanvas; LeftRect, RightRect: TRect; CSL, CSR: boolean); virtual;
    function GetRowMargin: Integer; virtual;

    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet: TElTabSheet); virtual; abstract;
    procedure DrawCloseButton(Canvas: TCanvas; var R: TRect; TabSheet: TElTabSheet); virtual;
    procedure DrawThemedCloseButton(Canvas: TCanvas; var R: TRect; TabSheet: TElTabSheet); virtual;
    function GetContentMargin: Integer; virtual;
    procedure FixupTab(Canvas: TCanvas; R: TRect; TabSheet: TElTabSheet); virtual;
    procedure AdjustFocusRect(var R: TRect); virtual;
//    property TabTheme: HTheme read GetTabTheme;
//    property BtnTheme: HTheme read GetBtnTheme;
//    property ScrollTheme: HTheme read GetScrollTheme;
//    property CloseBtnTheme: HTheme read GetCloseBtnTheme;
    property TabPosition: TElTabPosition read GetTabPosition;
  public
    constructor Create(Owner: TElPageControl); virtual;
    function IsThemed: Boolean;
  end;

  TElBitmapTab = class(TElTab)
  private
    FTab: TBitmap;
    FActiveTab: TBitmap;
    FCloseButton: TBitmap;
  protected
    function GetInnerMargin: Integer; override;
    function GetContentMargin: Integer; override;
    function GetOuterMargin: Integer; override;
    procedure AdjustTabSize(var Size: TSize); override;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet: TElTabSheet); override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet); override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect;
      TabSheet: TElTabSheet); override;
    procedure DrawTab(Canvas: TCanvas; Active: Boolean; R: TRect);
    procedure DrawCloseButton(Canvas: TCanvas; var R: TRect;
      TabSheet: TElTabSheet); override;
    procedure DrawTabLine(Canvas: TCanvas; R: TRect); override;
  public
    constructor Create(Owner: TElPageControl); override;
    destructor Destroy(); override;
  end;

  TElStdTab = class(TElTab)
  private
  protected
    function GetOuterMargin: Integer; override;
    function CanDrawTab(ActiveDraw: boolean): Boolean; override;
    function GetAscend: Integer; override;
    procedure AdjustDrawingSize(Active: boolean; var R: TRect); override;
    procedure AdjustTabSize(var Size: TSize); override;
    procedure DrawTabLine(Canvas: TCanvas; R: TRect); override;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet:
      TElTabSheet); override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
  public
  end;

  TElBtnTab = class(TElTab)
  private
  protected
    function GetInnerMargin: Integer; override;
    procedure DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my: integer);
      override;
    procedure AdjustTabSize(var Size: TSize); override;
    function GetRowMargin: Integer; override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
  end;

  TElFlatBtnTab = class(TElTab)
  private
  protected
    function GetInnerMargin: Integer; override;
    procedure DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my: integer);
      override;
    procedure AdjustTabSize(var Size: TSize); override;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet:
      TElTabSheet); override;
    function GetRowMargin: Integer; override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
  end;

  TElNetTab = class(TElTab)
  private
  protected
    procedure AdjustTabSize(var Size: TSize); override;
    function GetInnerMargin: Integer; override;
    procedure DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my: integer);
      override;
    function CanDrawTab(ActiveDraw: boolean): Boolean; override;
    procedure AdjustDrawingSize(Active: boolean; var R: TRect); override;
    function GetOuterMargin: Integer; override;
    procedure DrawTabLine(Canvas: TCanvas; R: TRect); override;
    function GetAscend: Integer; override;
    procedure FillSpace(Canvas: TCanvas; Rect: TRect); override;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet:
      TElTabSheet); override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    procedure DrawButtons(Canvas: TCanvas; LeftRect, RightRect: TRect; CSL, CSR:
      boolean); override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
  end;

  TEl2DFlatTab = class(TElTab)
  private
  protected
    procedure AdjustDrawingSize(Active: boolean; var R: TRect); override;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet:
      TElTabSheet); override;
    procedure AdjustTabSize(var Size: TSize); override;
    function CanDrawTab(ActiveDraw: boolean): Boolean; override;
    procedure DrawTabLine(Canvas: TCanvas; R: TRect); override;
    function GetAscend: Integer; override;
    function GetInnerMargin: Integer; override;
    function GetOuterMargin: Integer; override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
  end;

  TElModernAngledTab = class(TElTab)
  private
    SaveDCState: Integer;
  protected
    function CanDrawTab(ActiveDraw: boolean): Boolean; override;
    procedure DrawButtons(Canvas: TCanvas; LeftRect, RightRect: TRect; CSL, CSR: boolean); override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
    procedure DrawTabLine(Canvas: TCanvas; R: TRect); override;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet:
      TElTabSheet); override;
    procedure AdjustDrawingSize(Active: boolean; var R: TRect); override;
    procedure AdjustTabSize(var Size: TSize); override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    function GetAscend: Integer; override;
    function GetInnerMargin: Integer; override;
    function GetOuterMargin: Integer; override;
    function GetContentMargin: Integer; override;
    procedure CreateTabPoints(R: TRect; var APoints: array of TPoint);
    procedure FixupTab(Canvas: TCanvas; R: TRect; TabSheet: TElTabSheet);
      override;
    procedure AdjustFocusRect(var R: TRect); override;
  end;

  TElAngledTab = class(TElTab)
  private
    SaveDCState: Integer;
  protected
    function CanDrawTab(ActiveDraw: boolean): Boolean; override;
    procedure DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
      TElTabSheet);
      override;
    procedure DrawTabLine(Canvas: TCanvas; R: TRect); override;
    procedure AdjustFillSize(After: boolean; var R: TRect; TabSheet:
      TElTabSheet); override;
    procedure AdjustDrawingSize(Active: boolean; var R: TRect); override;
    procedure AdjustTabSize(var Size: TSize); override;
    procedure FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
      override;
    function GetAscend: Integer; override;
    function GetInnerMargin: Integer; override;
    function GetOuterMargin: Integer; override;
    function GetContentMargin: Integer; override;
    procedure CreateTabPoints(R: TRect; var APoints: array of TPoint);
    procedure FixupTab(Canvas: TCanvas; R: TRect; TabSheet: TElTabSheet);
      override;
    procedure AdjustFocusRect(var R: TRect); override;
  end;

procedure DrawXPTabEdges(ATabTheme: TLMDThemeMode; ADetails: TThemedElementDetails; Canvas: TCanvas; var R: TRect; ATabPosition: TElTabPosition);

// procedure DrawXPTabEdges(ATabTheme: HTheme; iPartId, iStateId: Integer; Canvas: TCanvas; var R: TRect; ATabPosition: TElTabPosition);

implementation

uses
  LMDUtils,
  LMDBmp,
  LMDGraphUtils;

const
  Margin = 4;
  ButtonWidth = 15;
  AngledOffset = 10;
  AccelFlags: array[boolean] of Cardinal = (DT_NOPREFIX, 0);
  // var TotalRepaints : integer;

// procedure DrawXPTabEdges(ATabTheme: HTheme; iPartId, iStateId: Integer; Canvas: TCanvas; var R: TRect; ATabPosition: TElTabPosition);
procedure DrawXPTabEdges(ATabTheme: TLMDThemeMode; ADetails: TThemedElementDetails; Canvas: TCanvas; var R: TRect; ATabPosition: TElTabPosition);
var
  TmpBmp, TmpBmp1: TBitmap;
  R1: TRect;
begin
  if (R.Bottom < R.Top) or (R.Right < R.Left) then
    exit;
  TmpBmp := TBitmap.Create;
  TmpBmp1 := TBitmap.Create;
  try
    TmpBmp1.Width := R.Right - R.Left;
    TmpBmp1.Height := R.Bottom - R.Top;
    if (ATabPosition = etpLeft) or (ATabPosition =  etpRight) then
    begin
      TmpBmp.Width := R.Bottom - R.Top;
      TmpBmp.Height := R.Right - R.Left;
      TmpBmp.Handle := CreateCompatibleBitmap(Canvas.Handle, R.Bottom - R.Top,R.Right - R.Left);
    end
    else
    begin
      TmpBmp.Width := R.Right - R.Left;
      TmpBmp.Height := R.Bottom - R.Top;
      TmpBmp.Handle := CreateCompatibleBitmap(Canvas.Handle, R.Right - R.Left, R.Bottom - R.Top);
    end;
    R1 := Rect(0,0,TmpBmp.Width,TmpBmp.Height);
    TmpBmp.PixelFormat := pf32bit;

    {$IFDEF LMDCOMP16}
    if StyleServices.Enabled and not StyleServices.IsSystemStyle then
    begin
      StyleServices.DrawElement(TmpBmp.Canvas.Handle, ThemeServices.GetElementDetails(ttBody), R1);
      StyleServices.DrawElement(TmpBmp.Canvas.Handle, aDetails, R1);
    end
    else
    {$ENDIF}
    LMDThemeServices.DrawElement(ATabTheme, TmpBmp.Canvas.Handle, ADetails, R1, nil);
    R1 := LMDThemeServices.ContentRect(ATabTheme, TmpBmp.Canvas.Handle, ADetails, R1);
    case ATabPosition of
      etpLeft:
      begin
        LMDBmpRotate(TmpBmp, TmpBmp1, 90 * Pi / 180);
        bitblt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
          TmpBmp1.Canvas.Handle, 0, 0, SRCCOPY);
      end;
      etpRight:
      begin
        LMDBmpRotate(TmpBmp, TmpBmp1, 270 * Pi / 180);
        bitblt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
          TmpBmp1.Canvas.Handle, 0, 0, SRCCOPY);
      end;
      etpTop:
        bitblt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
          TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
      etpBottom:
      begin
        if R.Right - R.Left > 0 then
          LMDBmpFlipVertical(TmpBmp, TmpBmp1);
        bitblt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
          TmpBmp1.Canvas.Handle, 0, 0, SRCCOPY);
      end;
    end;
  finally
    TmpBmp.Free;
    TmpBmp1.Free;
  end;
end;

procedure IntMapWindowPoints(SrcWnd, DstWnd: HWND; var Rect: TRect; Transform: integer);

begin
  ScreenToClient(DstWnd, Rect.TopLeft);
  ScreenToClient(DstWnd, Rect.BottomRight);
  end;

procedure TElTabSheet.TriggerShowEvent;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

procedure TElTabSheet.TriggerHideEvent;
begin
  if Assigned(FOnHide) then FOnHide(Self);
end;

procedure TElTabSheet.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Showing then
    TriggerShowEvent
  else
    if not Showing then
      TriggerHideEvent;
  (*
  if TabVisible and (FPageControl <> nil) then
    FPageControl.RebuildTabs(false);
  *)
end;

constructor TElTabSheet.Create(AOwner: TComponent);
begin

  BeginCreate;
  inherited;

  Color := clBtnFace;
  TabColor := clBtnFace;
  Align := alClient;
  ControlStyle := ControlStyle + [csAcceptsControls];
  ControlStyle := ControlStyle - [csNoDesignVisible];
  Visible := false;
  FTabVisible := true;
  FTabEnabled := true;
  FImageIndex := -1;
  FShowCloseButton := false;
  FCloseBtnDown := false;
  FCloseBtnOwer := false;
  CloseBtnEnabled := true;
  FUseFontForTabs := true;
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
  EndCreate;
end;

procedure TElTabSheet.SetTabColor(Value: TColor);
begin
  if FTabColor <> Value then
  begin
    FTabColor := Value;
    if Parent <> nil then
      TElPageControl(Parent).UpdateTab(Self);
  end;
end;

procedure TElTabSheet.SetPageControl(Value: TElPageControl);
begin
  if FPageControl <> Value then
  begin
    if FPageControl <> nil then
      FPageControl.RemovePage(Self);
    FPageControl := Value;
    Parent := FPageControl;
    if FPageControl <> nil then
    begin
      FPageControl.InsertPage(Self);
      if TabVisible and (FPageControl <> nil) then
        FPageControl.UpdateTab(Self);

      if FPageControl.ActivePage = nil then
        FPageControl.ActivePage := Self;
      ParentColor := FPageControl.ParentColor;
    end;
    if  IsThemed and HandleAllocated then
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or
        SWP_NOZORDER or SWP_FRAMECHANGED);
  end;
end;

procedure TElTabSheet.SetImageIndex(Value: integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    if TabVisible and (FPageControl <> nil) then
      FPageControl.UpdateTab(Self);
  end;
end;

procedure TElTabSheet.SetTabVisible(Value: Boolean);
begin
  if FTabVisible <> Value then
  begin
    FTabVisible := Value;
    UpdateTabShowing;
  end;
end;

procedure TElTabSheet.SelectFirst;
begin
  inherited SelectFirst;
end;

procedure TElTabSheet.SetCaption(Value: TLMDString);
begin
//  if FPageControl.FTabCaptions.Strings[TabIndex] <> Value then
  if FCaption <> Value then
  begin
//    FPageControl.FTabCaptions.Strings[TabIndex] := Value;
    FCaption := Value;
    if TabVisible and (FPageControl <> nil) then
      FPageControl.RebuildTabs(false);
  end;
end;

function TElTabSheet.GetCaption: TLMDString;
begin
//  Result := '';
//  if (TabIndex >= 0) and (TabIndex < FPageControl.FTabCaptions.Count) then
//    Result := FPageControl.FTabCaptions.Strings[TabIndex];
  Result := FCaption;
end;

procedure TElTabSheet.SetTabShowing(Value: Boolean);
begin
  if FTabShowing <> Value then
  begin
    FTabShowing := Value;
    FPageControl.RebuildTabs(true);
  end;
end;

procedure TElTabSheet.UpdateTabShowing;
begin
  SetTabShowing((FPageControl <> nil) and FTabVisible);
end;

function TElTabSheet.GetPageIndex: Integer;
begin
  if FPageControl <> nil then
    Result := FPageControl.FPages.IndexOf(Self)
  else
    Result := -1;
end;

procedure TElTabSheet.SetPageIndex(Value: Integer);
var
  i, MaxPageIndex: Integer;
begin
  if FPageControl <> nil then
  begin
    MaxPageIndex := FPageControl.FPages.Count - 1;
    if Value > MaxPageIndex then
      raise
        EListError.CreateFmt('%d is an invalid PageIndex value.  PageIndex must be ' +
        'between 0 and %d', [Value, MaxPageIndex]);
    i := TabIndex;
    FPageControl.FPages.Move(PageIndex, Value);
    if i >= 0 then
      FPageControl.RebuildTabs(false);
  end;
end;

procedure TElTabSheet.CMFontChanged(var Message: TMessage);

begin
  if TabVisible and (FPageControl <> nil) then
    FPageControl.RebuildTabs(false);
  inherited;
  //Invalidate;
end;

procedure TElTabSheet.CMEnabledChanged(var Message: TMessage);

begin
  inherited;
  if TabVisible and (FPageControl <> nil) then
    FPageControl.RebuildTabs(false);
  Invalidate;
end;

destructor TElTabSheet.Destroy;
begin
  if FPageControl <> nil then
  begin
    FPageControl.RemovePage(Self);
  end;
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
  inherited;
end;

procedure TElTabSheet.DestroyHandle;
begin
  inherited DestroyHandle;
end;

function TElTabSheet.GetTabIndex: Integer;
var
  i: integer;
begin
  result := 0;
  if not FTabShowing then
    result := -1
  else
    for i := 0 to PageIndex - 1 do
      if TElTabSheet(FPageControl.FPages[I]).FTabShowing then
        Inc(result);
end;

procedure TElTabSheet.Notification(AComponent: TComponent; Operation:
  TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
    begin
      if (AComponent = PageControl) then
        PageControl := nil;
      if AComponent = FTabMenu then
        TabMenu := nil;
      if (AComponent = FStyleManager) then
        StyleManager := nil;
    end;
end;

procedure TElTabSheet.SetShowCloseButton(Value: Boolean);
begin
  if Value <> ShowCloseButton then
  begin
    FCloseBtnDown := false;
    FCloseBtnOwer := false;
    FShowCloseButton := Value;
    if HandleAllocated and (FPageControl <> nil) and
      (FPageControl.CloseButtonMode <> cbmNone) then
      FPageControl.UpdateTabs(true);
  end;
end;

procedure TElTabSheet.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if HandleAllocated and (FPageControl <> nil) then
    FPageControl.DblClick;
end;

procedure TElTabSheet.WMEraseBkgnd(var Msg: TWMEraseBkGnd);
var
  R, RW, R1, R2: TRect;
  s: integer;
  ACtl: TWinControl;
  BgRect: TRect;

  Canvas: TCanvas;
  LThemeMode: TLMDThemeMode;
  LIsThemed: boolean;
  //BorderSize: Integer;
  //Details: TThemedElementDetails;
begin
  if (not DoubleBuffered) or (TMessage(Msg).wParam = WPARAM(TMessage(Msg).lParam)) then
  begin
    LIsThemed := IsThemed;
    if LIsThemed then
      LThemeMode := FPageControl.UseThemeMode
    else
      LThemeMode := ttmNone;
    if LIsThemed then
    begin
      (*{$IFDEF LMDCOMP16}
      if (PageControl <> nil) and (PageControl.Style = etsTabs) and StyleServices.Enabled then
      begin
        GetWindowRect(Handle, R);
        OffsetRect(R, -R.Left, -R.Top);
        BorderSize := ClientToParent(Point(0, 0)).X;
        InflateRect(R, BorderSize, BorderSize);
        Details := StyleServices.GetElementDetails(ttPane);
        StyleServices.DrawElement(Msg.DC, Details, R);
        Msg.Result := 1;
      end
      else
      {$ENDIF}*)
      begin
      GetWindowRect(Handle, RW);
      IntMapWindowPoints(0, Handle, RW, 2);

      R2 := RW;
      // hide borders
      if PageControl.ShowBorder then
        s := 1
      else
        s := 2;
      // this conversion has been made intentionally to hide borders that might be not drawn
      RW := ClientRect;

      R1 := LMDThemeServices.ContentRect(LThemeMode, Msg.DC, ThemeServices.GetElementDetails(ttPane), RW);
      Inc(RW.Left, (RW.Left - R1.Left) * s);
      Inc(RW.Top, (RW.Top - R1.Top) * s);
      Inc(RW.Right, (RW.Right - R1.Right) * s);
      Inc(RW.Bottom, (RW.Bottom - R1.Bottom) * s);

      if PageControl.ShowTabs and (PageControl.Style in [etsTabs, etsNetTabs,
        etsFlatTabs, etsModernAngledTabs, etsAngledTabs, etsBitmapTabs]) then
      begin
        case PageControl.TabPosition of
          etpTop: RW.Top := RW.Top + (R2.Top - R1.Top);
          etpBottom: RW.Bottom := RW.Bottom + (R2.Bottom - R1.Bottom);
          etpRight: RW.Right := RW.Right + (R2.Right - R1.Right);
          etpLeft: RW.Left := RW.Left + (R2.Left - R1.Left);
        end;
      end;
      R := ClientRect;

      LMDThemeServices.DrawElement(LThemeMode, Msg.DC, ThemeServices.GetElementDetails(ttPane), RW, nil);
      end
    end
    else
    begin
      Canvas := Self.Canvas;
      Canvas.Handle := Msg.DC;

      R := ClientRect;

      if (FPageControl <> nil) and (FPageControl.FImgForm <> nil) and (not
        (csDesigning in FPageControl.FImgForm.ComponentState)) then
      begin
        if (FPageControl.FImgForm.Control <> Self) then
        begin
          if (FPageControl.FImgForm.Control <> FPageControl) then
          begin
            ACtl := FPageControl.FImgForm.GetRealControl;
            BgRect := R;
            BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
            BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
          end
          else
          begin
            ACtl := FPageControl.FImgForm.GetRealControl;
            BgRect := R;
            BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
            BgRect.TopLeft := ACtl.Parent.ScreenToClient(BgRect.TopLeft);
            Dec(BgRect.Left, FPageControl.Left);
            Dec(BgRect.Top, FPageControl.Top);
          end;
          FPageControl.FImgForm.PaintBkgnd(Canvas.Handle, R, BgRect.TopLeft,
            false);
        end;
      end
      else

      begin
        Canvas.Brush.Style := bsSolid;
        Canvas.Brush.Color := Color;
        Canvas.FillRect(R);
      end;
      Canvas.Handle := 0;
    end;
  end;
  Msg.result := 1;
end;

procedure TElTabSheet.SetTabEnabled(Value: Boolean);
begin
  if FTabEnabled <> Value then
  begin
    FTabEnabled := Value;
    if TabShowing then
      FPageControl.UpdateTabs(false);
  end;
end;

procedure TElTabSheet.SetTabMenu(Value: TPopupMenu);
begin
  if FTabMenu <> Value then
  begin

    if FTabMenu <> nil then
      if not (csDestroying in FTabMenu.ComponentState) then
        FTabMenu.RemoveFreeNotification(Self);

    FTabMenu := Value;
    if FTabMenu <> nil then
      FTabMenu.FreeNotification(Self);
  end;
end;

procedure TElTabSheet.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
    begin
      if (FStyleManager <> nil) and (not (csDestroying in
        FStyleManager.ComponentState)) then
        FStyleManager.RemoveFreeNotification(Self);
      if FStyleManager <> nil then
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

procedure TElTabSheet.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TElTabSheet.StyleMgrChange(Sender: TObject);
begin
  UpdateStyle;
end;

procedure TElTabSheet.UpdateStyle;
begin
  if ComponentState * [csLoading, csReading] <> [] then
    exit;
  if FStyleManager <> nil then
  begin
    if HandleAllocated and Visible then
      SendMessage(Handle, WM_SETREDRAW, 0, 0);
    FStyleManager.ApplyStyle(Self, StyleName);
    if HandleAllocated and Visible then
    begin
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
      Invalidate;
    end;
  end;
end;

(*
function TElPageControl.CanChange(NewPage : TElTabSheet): Boolean;
begin
  result := True;
  if Assigned(FOnChanging) then FOnChanging(Self, NewPage, result);
end;
*)

function TElPageControl.CanScrollLeft: Boolean;
var
  i: integer;
begin
  result := false;
  if Multiline or (FirstTab = nil) then
    exit
  else
    for i := FirstTab.PageIndex - 1 downto 0 do
    begin
      if TElTabSheet(FPages[i]).TabVisible then
      begin
        result := true;
        exit;
      end;
    end;
end;

function TElPageControl.CanChange(NewPage: TElTabSheet; FireOnChanging: Boolean = True): Boolean;
begin
  result := (NewPage = nil) or (NewPage.TabEnabled or (csDesigning in
    ComponentState));
  if Assigned(FOnChanging) and (FireOnChanging) then
    FOnChanging(Self, NewPage, result);
end;

procedure TElPageControl.Change;
begin
  if SoundMap <> nil then
    SoundMap.Play(FActivateSound);

  if Assigned(FOnChange) and not FDenyChanging then
    FOnChange(Self);
end;

procedure TElPageControl.ChangeActivePage(Page: TElTabSheet);
var
  ParentForm: TCustomForm;
begin
  if FActivePage <> Page then
  begin
    ParentForm := GetParentForm(Self);
    if (ParentForm <> nil) and (FActivePage <> nil) and
      FActivePage.ContainsControl(ParentForm.ActiveControl) then
    begin
      ParentForm.ActiveControl := FActivePage;
      if ParentForm.ActiveControl <> FActivePage then
      begin
        TabIndex := FActivePage.TabIndex;
        exit;
      end;
    end;
    if FActivePage <> nil then
    begin
      FActivePage.Visible := False;
      if FSavvyMode then
        FActivePage.DestroyHandle;
      FActivePage := Page;
      Invalidate;
    end;
    if Page <> nil then
    begin
      Page.Visible := True;
      Page.BringToFront;
      // Realign;
      if (ParentForm <> nil) and (FActivePage <> nil) and
        (ParentForm.ActiveControl = FActivePage) then
        if Page.CanFocus then
          ParentForm.ActiveControl := Page
        else
          ParentForm.ActiveControl := Self;
    end;
    FActivePage := Page;
    if HandleAllocated then
    Realign;

    Invalidate;

    if FSavvyMode and (FActivePage <> nil) and HandleAllocated and (not
      FActivePage.HandleAllocated) then
      FActivePage.UpdateControlState;
    if (ParentForm <> nil) and (FActivePage <> nil) and
      (ParentForm.ActiveControl = FActivePage) then
      FActivePage.SelectFirst;
    Change;
  end;
end;

procedure TElPageControl.CMControlListChange(var Message: TMessage);

begin
  inherited;
  if not (csDestroying in ComponentState) and (TObject(Message.wParam) is TElTabSheet)
  then
  begin
    //HandleNeeded;
    //RebuildTabs(false);
  end;
end;

procedure TElPageControl.CMDesignHitTest(var Message: TCMDesignHitTest);
var
  ATabSheet: TElTabSheet;
  P: TPoint;
  Px: TPoint;
  i: LRESULT;
begin
  Px := SmallPointToPoint(Message.Pos);
  i := HTNOWHERE;
  if DoHitTest(Px.x, Px.y, i) then
    Message.Result := 1;

  P := Px;
  ATabSheet := TabFromPoint(P);
  if (ATabSheet <> nil) and (ATabSheet <> ActivePage) then
  begin
    Message.result := 1;
  end;
end;

procedure TElPageControl.CMDialogKey(var Message: TCMDialogKey);
begin
  if (Focused or Windows.IsChild(Handle, Windows.GetFocus)) and
    (Message.CharCode = VK_TAB) and (GetKeyState(VK_CONTROL) < 0) and
    ShowTabs then
  begin
    SelectNextPage(GetKeyState(VK_SHIFT) >= 0);
    Message.result := 1;
  end
  else
    inherited;
end;

procedure TElPageControl.CMDockClient(var Message: TCMDockClient);

var
  IsVisible: Boolean;
  DockCtl: TControl;
begin
  Message.result := 0;
  FDockMouseDown := False;
  FNewDockSheet := TElTabSheet.Create(Self);
  try
    try
      DockCtl := Message.DockSource.Control;
      if DockCtl is TCustomForm then
        FNewDockSheet.Caption := TCustomForm(DockCtl).Caption;
      FNewDockSheet.PageControl := Self;
      DockCtl.Dock(Self, Message.DockSource.DockRect);
      except
      FNewDockSheet.Free;
      raise;
    end;
    IsVisible := DockCtl.Visible;
    FNewDockSheet.TabVisible := IsVisible;
    FNewDockSheet.Caption := DockCtl.Name;
    if IsVisible then
      ActivePage := FNewDockSheet;
    DockCtl.Align := alClient;
  finally
    FNewDockSheet := nil;
  end;
end;

procedure TElPageControl.CMDockNotification(var Message: TCMDockNotification);
var
  I: integer;
  S: string;
  Page: TElTabSheet;
begin
  Page := GetPageFromDockClient(Message.Client);
  if Page <> nil then
    case Message.NotifyRec.ClientMsg of
      WM_SETTEXT:
        begin
          S := PChar(Message.NotifyRec.MsgLParam);
          { Search for first CR/LF and end string there }
          for i := 1 to Length(S) do
            if AnsiChar(S[i]) in [#13, #10] then
            begin
              SetLength(S, i - 1);
              Break;
            end;
          Page.Caption := S;
        end;
      CM_VISIBLECHANGED:
        Page.TabVisible := Boolean(Message.NotifyRec.MsgWParam);
    end;
  inherited;
end;

procedure TElPageControl.CMFocusChanged(var Message: TMessage);

begin
  inherited;
  UpdateTabs(false);
end;

procedure TElPageControl.CMParentFontChanged(var Msg: TMessage);

begin
  inherited;
  if ParentFont then
  begin
    HotTrackFont.Assign(Font);
    FHotTrackFont.Color := clBlue; // clHighlight;
    if not UseActiveTabFont then
      ActiveTabFont.Assign(Font);
  end;
end;

procedure TElPageControl.CMFontChanged(var Message: TMessage);

begin
  inherited;
//  if ParentFont then
//  begin
//    HotTrackFont.Name := Font.Name;
//    HotTrackFont.Size := Font.Size;
//  end;
  Canvas.Font.Assign(Font);
  UpdateTabs(false);
end;

procedure TElPageControl.CMColorChanged(var Message: TMessage);

begin
  inherited;
  if not HasVisibleTabs then
    Invalidate;
  if (Style = etsNetTabs) and not (csLoading in ComponentState) then
    TabBkColorNetStyle := IncColor(Color, 20, 20, 20);
  if ShowBorder then
    UpdateTabs(false);
end;

procedure TElPageControl.CMSysColorChange(var Message: TMessage);

begin
  inherited;
  if not HasVisibleTabs then
    Invalidate;
  UpdateTabs(false);
end;

procedure TElPageControl.CMUnDockClient(var Message: TCMUnDockClient);

var
  Page: TElTabSheet;
begin
  inherited;
  Message.result := 0;
  Page := GetPageFromDockClient(Message.Client);
  if Page <> nil then
  begin
    FUndockingPage := Page;
    Message.Client.Align := alNone;
    end;
end;

procedure TElPageControl.SelectFirstTab;
var
  i: integer;
begin
  if (FirstTab = nil) and (not (csLoading in ComponentState)) then
  begin
    for i := 0 to FPages.Count - 1 do
    begin
      if TElTabSheet(FPages[i]).TabVisible then
      begin
        FirstTab := TElTabSheet(FPages[i]);
        break;
      end;
    end;
  end;
end;

procedure TElPageControl.CreateHandle;
begin
  inherited CreateHandle;
  SelectFirstTab;
end;

procedure TElPageControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or WS_CLIPCHILDREN;
  Params.WindowClass.style := Params.WindowClass.style or CS_HREDRAW or
    CS_VREDRAW;
end;

procedure TElPageControl.DockOver(Source: TDragDockObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  Source.DockRect := R;
  DoDockOver(Source, X, Y, State, Accept);
end;

procedure TElPageControl.DoAddDockClient(Client: TControl; const ARect: TRect);
begin
  if FNewDockSheet <> nil then
    Client.Parent := FNewDockSheet;
end;

procedure TElPageControl.DoRemoveDockClient(Client: TControl);
var
  APage: TElTabSheet;
begin
  if (FUndockingPage <> nil) and not (csDestroying in ComponentState) then
  begin
    APage := FindNextPage(ActivePage, true, true, false);
    FUndockingPage.Free;
    FUndockingPage := nil;
    ActivePage := APage;
  end;
end;

function TElPageControl.GetActivePageIndex: Integer;
begin
  if ActivePage <> nil then
    Result := ActivePage.GetPageIndex
  else
    Result := -1;
end;

procedure TElPageControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: integer;
begin
  for i := 0 to FPages.Count - 1 do
    Proc(TComponent(FPages[i]));
end;

function TElPageControl.GetDockClientFromMousePos(MousePos: TPoint): TControl;
var
  Page: TElTabSheet;
begin
  Result := nil;
  if DockSite then
  begin
    Page := TabFromPoint(MousePos);
    if (Page <> nil) and (Page.ControlCount > 0) then
    begin
      Result := Page.Controls[0];
      if Result.HostDockSite <> Self then
        Result := nil;
    end;
  end;
end;

function TElPageControl.GetPageCount: integer;
begin
  result := 0;
  if Assigned(FPages) then
    result := FPages.Count;
end; { GetPageCount }

function TElPageControl.GetPageFromDockClient(Client: TControl): TElTabSheet;
var
  i: integer;
begin
  result := nil;
  if (Client = nil) or (FPages = nil) then
  begin
    for i := 0 to PageCount - 1 do
    begin
      if (Client.Parent = Pages[i]) and (Client.HostDockSite = Self) then
      begin
        result := Pages[i];
        exit;
      end;
    end;
  end;
end;

function TElPageControl.GetPages(index: integer): TelTabSheet;
{ Returns the value of data member FPages[index ]. }
begin
  result := TElTabSheet(FPages[index]);
end; { GetPages }

procedure TElPageControl.GetSiteInfo(Client: TControl; var InfluenceRect: TRect;
  MousePos: TPoint; var CanDock: Boolean);
begin
  CanDock := GetPageFromDockClient(Client) = nil;
  inherited GetSiteInfo(Client, InfluenceRect, MousePos, CanDock);
end;

function TElPageControl.GetTabIndex: integer;
var
  i: integer;
begin
  result := -1;
  if ActivePage <> nil then
  begin
    if ActivePage.TabShowing then
      result := ActivePage.TabIndex
    else
    begin
      for i := ActivePage.PageIndex + 1 to PageCount - 1 do
        if Pages[i].TabShowing then
        begin
          result := Pages[i].TabIndex;
          break;
        end;
      if result = -1 then
      begin
        for i := ActivePage.PageIndex - 1 downto 0 do
          if Pages[i].TabShowing then
          begin
            result := Pages[i].TabIndex;
            break;
          end;
      end;
    end;
  end;
end;

(*
procedure TElPageControl.ImageChange(Sender : TObject);
begin
  if ((FBackground.Height = 0) or (FBackground.Width = 0)) then
    BackgroundType := bgtColorFill
  else
  begin
    RedoTmpBmp;
    Invalidate;
    if ActivePAge <> nil then
      ActivePage.Invalidate;
  end;
end;
*)

procedure TElPageControl.ImageFormChange(Sender: TObject);
begin
  // RedoTmpBmp;
  Invalidate;
  UpdateTabs(false);
  if ActivePage <> nil then
    ActivePage.Invalidate;
end;

procedure TElPageControl.ImageListChange(Sender: TObject);
begin
  RebuildTabs(false);
end;

procedure TElPageControl.InsertPage(TabSheet: TElTabSheet);
var
  b: boolean;
begin
  b := HasVisibleTabs;
  if FPages.IndexOf(TabSheet) = -1 then
  begin
    FPages.Add(TabSheet);
    TabSheet.FPageControl := Self;
    SetWindowPos(TabSheet.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOOWNERZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or
      SWP_FRAMECHANGED);
    TabSheet.UpdateTabShowing;
    RecalcTabPositions;
    if Multiline then UpdateMultilineOrder;
    if (b <> HasVisibleTabs) or Multiline then
      RebuildTabs(false);
    Invalidate;
    //Update;
  end;
end;

procedure TElPageControl.MakeTabVisible(ATabSheet: TElTabSheet);
begin
  if HandleAllocated and ShowTabs then
  begin
    if (not Multiline) then
    begin
      if (FirstTab <> nil) then
      begin
        if FirstTab.PageIndex < ATabSheet.PageIndex then
        begin
          if (not ATabSheet.FShown) or not ATabSheet.FComplete then
          begin
            if not ATabSheet.TabVisible then
              exit;
            while (not ATabSheet.FComplete) and (FirstTab <> ATabSheet) do
            begin
              FRecalcTabPos := true;
              FirstTab := FindNextPage(FirstTab, true, true, false);
            end;
          end;
        end
        else
        if FirstTab.PageIndex > ATabSheet.PageIndex then
          FirstTab := ATabSheet;
      end
      else
        FirstTab := ATabSheet;
    end;
  end;
end;

procedure TElPageControl.RebuildTabs(ResetFirstItem: boolean);
begin
  if FUpdateCount > 0 then
  begin
    if ResetFirstItem then
      FUpdated := FUpdated or $00020000
    else
      FUpdated := FUpdated or $00010000;
  end
  else
  begin
    if ResetFirstItem and (FPages.Count > 0) then
    begin
     // if (not Multiline) or (FLines = 1) then
      begin
        FFirstTab := FindNextPage(nil, true, true, false);
        RecalcTabPositions;
        if Multiline then
          UpdateMultilineOrder;
      end;
    end;
    //UpdateTabs(false);
    if HandleAllocated then
      Realign;
    Invalidate;
  end;
end;

(*
procedure TElPageControl.RedoTmpBmp;
var BgRect,
    BgRect2 : TRect;
begin
  if BackgroundType in [bgtHorzGradient, bgtVertGradient, bgtColorFill, bgtCenterBitmap] then
  begin
    FTmpBmp.FreeImage;
  end else
  begin
    if (ClientWidth <> 0) and (ClientHeight <> 0) then
    begin
      FTmpBmp.Height := ClientHeight - 1;
      FTmpBmp.Width := ClientWidth - 1;
      BgRect := ClientRect;
      BgRect2 := BgRect;
      OffsetRect(BgRect2, BgRect2.Left, BgRect2.Top);
      LMDExtDrawBkgnd(FTmpBmp.Canvas.Handle, BgRect, BgRect, BgRect, BgRect2, false, Color, Color,  Background, BackgroundType);
    end;
  end;
end;
*)

procedure TElPageControl.RemovePage(TabSheet: TElTabSheet);
var
  NextTab: TElTabSheet;
  b, b1: boolean;
begin
  b := hasVisibleTabs;
//  FTabCaptions.Delete(TabSheet.TabIndex);
  if FFirstTab = TabSheet then
    FFirstTab := FindNextPage(FFirstTab, true, not (csDesigning in
      ComponentState), false);
  b1 := TabSheet = ActivePage;
  if b1 then
    NextTab := FindNextPage(TabSheet, True, not (csDesigning in ComponentState),
      false)
  else
    NextTab := nil;

  if DefaultPage = TabSheet then
    DefaultPage := nil;
  if NextTab = TabSheet then NextTab := nil;
  TabSheet.FPageControl := nil;
  FPages.Remove(TabSheet);

  if FUndockingPage = Tabsheet then
    FUndockingPage := nil;

  if FDownTab = TabSheet then
    FDownTab := nil;
  if FTrackTab = TabSheet then
    FTrackTab := nil;
  if FirstTab = TabSheet then
    FFirstTab := nil;

  if b1 then
    SetActivePage(NextTab);
  RecalcTabPositions;
  if Multiline then UpdateMultilineOrder;
  if (b <> HasVisibleTabs) or Multiline then
  begin
    RebuildTabs(false);
  end;
  Invalidate;
end;

procedure TElPageControl.SetActivePage(Value: TElTabSheet);
var
  LForm: TCustomForm;
begin
  if FActivePage <> Value then
  begin
    LForm := GetParentForm(self);
    if (csLoading in ComponentState) then
      FActivePage := Value
    else
    begin
      if ((Value <> nil) and (Value.PageControl <> Self)) or (not CanChange(Value)) then
        exit;
      ChangeActivePage(Value);
      if Value = nil then
        TabIndex := -1
      else
      begin
        if Value = FActivePage then
          if Value.TabIndex <> -1 then
            TabIndex := Value.TabIndex;
        MakeTabVisible(Value);
      end;
      if Assigned(LForm) and (LForm.Enabled and LForm.Visible) then
      begin
        if (Enabled and Visible) and Multiline then
          SetFocus;
      end;
      UpdateMultilineOrder;
      UpdateTabs(false);
    end;
    if ComponentState * [csReading, csReading, csLoading, csDestroying] = [] then
    begin
      if not FNoDTAlert then
        if (LForm <> nil) and (LForm.Designer <> nil) then
          LForm.Designer.Modified;

      FNoDTAlert := false;
    end;
  end;
end;

procedure TElPageControl.SetActivePageIndex(const Value: Integer);
begin
  if (Value > -1) and (Value < PageCount) then
    ActivePage := Pages[Value]
  else
    ActivePage := nil;
end;

procedure TElPageControl.SetActiveTabColor(Value: TColor);
begin
  if FActiveTabColor <> Value then
  begin
    FActiveTabColor := Value;
    if ShowTabs and (ActivePage <> nil) and (ActivePage.TabShowing) then
      UpdateTabs(false);
  end;
end;

(*
procedure TElPageControl.SetBackground(newValue: TBitmap);
begin
  FBackground.Assign(newValue);
  if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap]) then BackgroundType := bgtColorFill;
end; {SetBackground}

procedure TElPageControl.SetBackgroundType(newValue: TLMDBackgroundType);
begin
  if (FBackgroundType <> newValue) then
  begin
    FBackgroundType := newValue;
    if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
       then FBackgroundType := bgtColorFill;
    RedoTmpBmp;
    Invalidate;
    if ActivePage <> nil then
      ActivePage.Invalidate;
  end; {if}
end; {SetBackgroundType}
*)

procedure TElPageControl.SetChildOrder(Child: TComponent; Order: Integer);
begin
  TElTabSheet(Child).PageIndex := Order;
end;

procedure TElPageControl.SetDrawFocus(Value: Boolean);
begin
  if FDrawFocus <> Value then
  begin
    FDrawFocus := Value;
    UpdateTabs(false);
  end;
end;

procedure TElPageControl.SetFirstTab(Value: TElTabSheet);
begin
  if FFirstTab <> Value then
  begin
    FFirstTab := Value;
    //if not Multiline then
    if FRecalcTabPos then
    begin
      RecalcTabPositions;
      if Multiline then
        UpdateMultilineOrder;
    end
    else
      UpdateTabs(false);
  end;
end;

function TElPageControl.GetLastTab: TElTabSheet;
begin
  Result := Pages[PageCount - 1];
end;

procedure TElPageControl.SetFlat(newValue: Boolean);
{ Sets data member FFlatButtons to newValue. }
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    UpdateTabs(false);
    Invalidate;
  end; { if }
end; { SetFlatButtons }

(*

procedure TElPageControl.SetGradientEndColor(newValue : TColor);
{ Sets data member FGradientEndColor to newValue. }
begin
  if (FGradientEndColor <> newValue) then
  begin
    FGradientEndColor := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then
    begin
      if ActivePage <> nil then
        ActivePage.Invalidate;
    end;
  end;  { if }
end;  { SetGradientEndColor }

procedure TElPageControl.SetGradientStartColor(newValue : TColor);
{ Sets data member FGradientStartColor to newValue. }
begin
  if (FGradientStartColor <> newValue) then
  begin
    FGradientStartColor := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then
    begin
      if ActivePage <> nil then
        ActivePage.Invalidate;
    end;
  end;  { if }
end;  { SetGradientStartColor }

procedure TElPageControl.SetGradientSteps(newValue : integer);
{ Sets data member FGradientSteps to newValue. }
begin
  if (FGradientSteps <> newValue) and (newValue > 0) then
  begin
    FGradientSteps := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then
    begin
      if ActivePage <> nil then
        ActivePage.Invalidate;
    end;
  end;  { if }
end;  { SetGradientSteps }

*)

procedure TElPageControl.SetHotTrack(newValue: Boolean);
{ Sets data member FHotTrack to newValue. }
begin
  if (FHotTrack <> newValue) then
  begin
    FHotTrack := newValue;
    UpdateTabs(false);
  end; { if }
end; { SetHotTrack }

procedure TElPageControl.SetImageForm(newValue: TElImageForm);
begin
  if (FImgForm <> newValue) then
  begin
    if FImgForm <> nil then
    begin

      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);

      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    FImgForm := newValue;
    if (newValue <> nil) then
    begin
      newValue.FreeNotification(Self);
      FImgForm.RegisterChanges(FImgFormChLink);
    end;
    UpdateTabs(false);
    if not (csDesigning in ComponentState) then
    begin
      if ActivePage <> nil then
        ActivePage.Invalidate;
    end;
  end; { if }
end; { SetImageForm }

procedure TElPageControl.SetImages(newValue: TCustomImageList);
{ Sets data member FImages to newValue. }
begin
  if (FImages <> newValue) then
  begin
    if FImages <> nil then
    begin

      if not (csDestroying in FImages.ComponentState) then
        FImages.RemoveFreeNotification(Self);

      FImages.UnRegisterChanges(FImageChangeLink);
    end;
    FImages := newValue;
    if FImages <> nil then
    begin
      FImages.RegisterChanges(FImageChangeLink);
      FImages.FreeNotification(Self);
    end;
    RebuildTabs(false);
  end; { if }
end; { SetImages }

procedure TElPageControl.SetAlphaImages(newValue: TCustomImageList);
{ Sets data member FAlphaImages to newValue. }
begin
  if (FAlphaImages <> newValue) then
  begin
    if FAlphaImages <> nil then
    begin

      if not (csDestroying in FAlphaImages.ComponentState) then
        FAlphaImages.RemoveFreeNotification(Self);

      FAlphaImages.UnRegisterChanges(FAImageChangeLink);
    end;
    FAlphaImages := newValue;
    if FAlphaImages <> nil then
    begin
      FAlphaImages.RegisterChanges(FAImageChangeLink);
      FAlphaImages.FreeNotification(Self);
    end;
    RebuildTabs(false);
  end; { if }
end; { SetAlphaImages }

procedure TElPageControl.SetInactiveTabColor(Value: TColor);
begin
  if FInactiveTabColor <> Value then
  begin
    FInactiveTabColor := Value;
    if ShowTabs then
      UpdateTabs(false);
  end;
end;

procedure TElPageControl.SetMinTabHeight(Value: Integer);
begin
  if FMinTabHeight <> Value then
  begin
    FMinTabHeight := Value;
    RebuildTabs(false);
  end;
end;

procedure TElPageControl.SetMinTabWidth(Value: Integer);
begin
  if FMinTabWidth <> Value then
  begin
    FMinTabWidth := Value;
    RebuildTabs(false);
  end;
end;

procedure TElPageControl.SetMultiLine(newValue: Boolean);
{ Sets data member FMultiLine to newValue. }
begin
  if (FMultiLine <> newValue) then
  begin
    if newValue and ((Style = etsAngledTabs) or (Style = etsModernAngledTabs)) then
      raise
        Exception.Create('Multiline style is not supported for angled tabs');
    FMultiLine := newValue;
    RebuildTabs(true);
  end; { if }
end; { SetMultiLine }

procedure TElPageControl.SetRaggedRight(const Value: Boolean);
begin
  if (FRaggedRight <> Value) then
  begin
    FRaggedRight := Value;
    if Multiline then
      RebuildTabs(true);
  end;
end;

procedure TElPageControl.SetScrollOpposite(const Value: Boolean);
begin
  if (FScrollOpposite <> Value) then
  begin
    FScrollOpposite := Value;
    if Multiline then
      UpdateTabs(false);
  end;
end;

procedure TElPageControl.SetShowBorder(Value: Boolean);
begin
  if FShowBorder <> Value then
  begin
    FShowBorder := Value;
    RebuildTabs(true);
    if (UseThemeMode <> ttmNone) and (ActivePage <> nil) and ActivePAge.HandleAllocated then
    begin
      ActivePage.Invalidate;
      SetWindowPos(ActivePage.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or
        SWP_NOZORDER or SWP_FRAMECHANGED);
      //RedrawWindow(ActivePage.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
    end;
    Invalidate;
    Realign;
    if ActivePage <> nil then ActivePage.Invalidate;
    if (csDesigning in ComponentState) then
      Update;
  end;
end;

procedure TElPageControl.SetShowImages(newValue: Boolean);
{ Sets data member FShowImages to newValue. }
begin
  if (FShowImages <> newValue) then
  begin
    FShowImages := newValue;
    RebuildTabs(false);
  end; { if }
end; { SetShowImages }

procedure TElPageControl.SetShowTabs(Value: Boolean);
begin
  if FShowTabs <> Value then
  begin
    FShowTabs := Value;
    RebuildTabs(false);
  end;
end;

procedure TElPageControl.SetStyle(newValue: TElTabStyle);
{ Sets data member FButtonStyle to newValue. }
begin
  if (FStyle <> newValue) then
  begin
    FStyle := newValue;
    case FStyle of
      etsTabs: TabClass := TElStdTab;
      etsButtons: TabClass := TElBtnTab;
      etsFlatButtons: TabClass := TElFlatBtnTab;
      etsNetTabs:
        begin
          TabClass := TElNetTab;
          if not (csLoading in ComponentState) then
            TabBkColorNetStyle := IncColor(Color, 20, 20, 20);
        end;
      etsFlatTabs: TabClass := TEl2DFlatTab;
      etsBitmapTabs:
        begin
          TabClass := TElBitmapTab;
          if Assigned(FTab) and (FTab is TElBitmapTab) then
          begin
            (FTab as TElBitmapTab).FActiveTab.Assign(FActiveTab);
            (FTab as TElBitmapTab).FActiveTab.TransparentColor := (FTab as TElBitmapTab).FActiveTab.Canvas.Pixels[1,
                                 (FTab as TElBitmapTab).FActiveTab.Height - 1];
            (FTab as TElBitmapTab).FCloseButton.Assign(FCloseButton);
            (FTab as TElBitmapTab).FTab.Assign(FBTab);
            (FTab as TElBitmapTab).FTab.TransparentColor := (FTab as TElBitmapTab).FTab.Canvas.Pixels[1,
                                 (FTab as TElBitmapTab).FTab.Height - 1];
          end;
        end;
      etsAngledTabs:
        if Multiline then
          raise
            Exception.Create('Multiline style is not supported for angled tabs')
        else
          TabClass := TElAngledTab;
      etsModernAngledTabs:
        if Multiline then
          raise
            Exception.Create('Multiline style is not supported for angled tabs')
        else
          TabClass := TElModernAngledTab;
      end;
    RebuildTabs(false);
    Invalidate;
  end; { if }
end; { SetButtonStyle }

procedure TElPageControl.BmpActiveTabChanged(Sender: TObject);
begin
  if Assigned(FTab) and (FTab is TElBitmapTab) then
    (FTab as TElBitmapTab).FActiveTab.Assign(FActiveTab);
end;

procedure TElPageControl.BmpTabChanged(Sender: TObject);
begin
  if Assigned(FTab) and (FTab is TElBitmapTab) then
    (FTab as TElBitmapTab).FTab.Assign(FBTab);
end;

procedure TElPageControl.BmpCloseButtonChanged(Sender: TObject);
begin
  if Assigned(FTab) and (FTab is TElBitmapTab) then
    (FTab as TElBitmapTab).FCloseButton.Assign(FCloseButton);
end;

procedure TElPageControl.SetTabHeight(newValue: DWORD);
{ Sets data member FTabHeight to newValue. }
begin
  if (FTabHeight <> newValue) then
  begin
    FTabHeight := newValue;
    RebuildTabs(false);
  end; { if }
end; { SetTabHeight }

procedure TElPageControl.SetTabIndex(const Value: integer);
var
  APage: TElTabSheet;
  i, r: integer;
begin
  if csLoading in ComponentState then
    FTabIndex := Value
  else
    if Value <> -1 then
  begin
    r := 0;
    for i := 0 to FPages.Count - 1 do
    begin
      if Pages[i].TabVisible then
      begin
        if (R = Value) then
        begin
          APage := Pages[i];
          if (APage <> nil) and (APage <> ActivePage) then
            ActivePage := APage;
          break;
        end;
        inc(r);
      end;
    end;
  end
  else
    ActivePage := nil;
end;

procedure TElPageControl.SetTabPosition(newValue: TElTabPosition);
begin
  if (FTabPosition <> newValue) then
  begin
    FTabPosition := newValue;
    RebuildTabs(true);
    realign;
  end; { if }
end; { SetTabPosition }

procedure TElPageControl.SetTabWidth(newValue: DWORD);
{ Sets data member FTabWidth to newValue. }
begin
  if (FTabWidth <> newValue) then
  begin
    FTabWidth := newValue;
    RebuildTabs(false);
  end; { if }
end; { SetTabWidth }

procedure TElPageControl.ShowControl(AControl: TControl);
begin
  if (AControl is TElTabSheet) and (TElTabSheet(AControl).PageControl = Self) then
    SetActivePage(TElTabSheet(AControl));
  inherited ShowControl(AControl);
end;

procedure TElPageControl.TriggerMeasureTabEvent(Canvas: TCanvas; Page:
  TElTabSheet; var Size: TSize);
begin
  Size.cx := 0;
  Size.cy := 0;
  if Assigned(OnMeasureTab) then
    OnMeasureTab(Self, Canvas, Page, Size);
end;

procedure TElPageControl.UpdateActivePage;
begin
  if TabIndex >= 0 then
    SetActivePage(TElTabSheet(FPages[TabIndex]))
  else
    SetActivePage(nil);
end;

procedure TElPageControl.UpdateTab(TabSheet: TElTabSheet);
begin
  UpdateTabs(false);
end;

procedure TElPageControl.WMEraseBkgnd(var Msg: TWMEraseBkGnd);
begin
  if Assigned(Parent) and (Parent is TForm) and TForm(Parent).DoubleBuffered then
    inherited
  else
    Msg.result := 1;
end;

procedure TElPageControl.WMSize(var Msg: TWMSize);
begin
  inherited;
  FSize.cx := Msg.Width;
  FSize.cy := Msg.Height;
end; { WMSize }

{unction TElPageControl.GetBtnThemeHandle: HTheme;
begin
  result := LMDThemeService.Theme[tiButton];
end;

function TElPageControl.GetScrollThemeHandle: HTheme;
begin
  result := LMDThemeService.Theme[tiSpin]
end;

function TElPageControl.GetCloseBtnThemeHandle: HTheme;
begin
  result := LMDThemeService.Theme[tiWindow];
end;
}
constructor TElPageControl.Create(AOwner: TComponent);
begin
  BeginCreate;
  inherited;

  inherited TabStop := true;
  ControlStyle := [csDoubleClicks, csOpaque];
  FShowAccelChar := True;
  FPages := TLMDObjectList.Create;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FAImageChangeLink := TChangeLink.Create;
  FAImageChangeLink.OnChange := ImageListChange;
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;

(*
  FBackground := TBitmap.Create;
  FBackground.OnChange := ImageChange;
  FBackgroundType := bgtColorFill;
  FGradientSteps := 16;
*)

  // Create container for captions of tabs
//  FTabCaptions := TLMDMemoryStrings.Create;
  FTabSheetClass := TElTabSheet;
  FDockMouseDown := False;

  FVerticalSideCaptions := true;
  //FTmpBmp := TBitmap.Create;
  FActiveTabColor := clBtnFace;
  FInactiveTabColor := clBtnFace;
  Color := clBtnFace;
  FShowBorder := true;
  FTabIndex := -1;
  Width := 289;
  Height := 193;
  FMinTabWidth := 40;
  FMinTabHeight := 40;
  FShowImages := true;
  FShowTabs := true;
  TabClass := TElStdTab;
  FHotTrack := true;
  FHotTrackFont := TFont.Create;
  FHotTrackFont.OnChange := HotTrackFontChange;
  FHotTrackFont.Color := clBlue; // clHighlight;
  FActiveTabFont := TFont.Create;
  FActiveTabFont.OnChange := ActiveTabFontChange;
  FTabBkColor := clBtnFace;
  FShowTabHints := true;
  FHintTimer := TTimer.Create(nil);
  FHintTimer.OnTimer := OnHintTimer;
  FlatTabBorderColor := clBtnShadow;
  FDoStartDrag := -1;
  FTabsSize.cx := -1;
  FTabsSize.cy := -1;
  FDraggablePages := false;
  FTabCursor := crDefault;

  FBTab := TBitmap.Create;
  FBTab.OnChange := BmpTabChanged;
  FActiveTab := TBitmap.Create;
  FActiveTab.OnChange := BmpActiveTabChanged;
  FCloseButton := TBitmap.Create;
  FCloseButton.OnChange := BmpCloseButtonChanged;
  FBTab.TransparentMode := tmFixed;
  FBTab.Transparent := True;
  FActiveTab.TransparentMode := tmFixed;
  FActiveTab.Transparent := True;
  FDenyChanging := False;
  EndCreate;
end;

destructor TElPageControl.Destroy;
var
  i: integer;
begin
  FHintTimer.Free;
  if FHintWnd <> nil then
    ShowWindow(FHintWnd.Handle, SW_HIDE);
  FHintTimer := nil;
  if FScrollTimer <> nil then
    FScrollTimer.Free;
  FScrollTimer := nil;
  for i := 0 to FPages.Count - 1 do
    TElTabSheet(FPages[i]).FPageControl := nil;
  FreeAndNil(FActiveTabFont);
  FreeAndNil(FHotTrackFont);
  FreeAndNil(FImageChangeLink);
  FreeAndNil(FAImageChangeLink);
  FreeAndNil(FPages);
//  FreeAndNil(FTabCaptions);

  FreeAndNil(FImgFormChLink);

  //FBackground.Free;
  //FTmpBmp.Free;
  FreeAndNil(FTab);
  FreeAndNil(FBTab);
  FreeAndNil(FActiveTab);
  FreeAndNil(FCloseButton);
  inherited;
end;

function TElPageControl.FindNextPage(CurPage: TElTabSheet; GoForward,
  CheckTabVisible, CheckTabEnabled: Boolean): TElTabSheet;
var
  i, StartIndex: integer;
begin
  if FPages.Count <> 0 then
  begin
    StartIndex := FPages.IndexOf(CurPage);
    if StartIndex = -1 then
      if GoForward then
        StartIndex := FPages.Count - 1
      else
        StartIndex := 0;
    i := StartIndex;
    repeat
      if GoForward then
      begin
        Inc(I);
        if i = FPages.Count then
          i := 0;
      end
      else
      begin
        if i = 0 then
          i := FPages.Count;
        Dec(I);
      end;
      result := TElTabSheet(FPages[i]);
      if (not CheckTabVisible or result.TabVisible) and
        ((not CheckTabEnabled) or (Result.TabEnabled or (csDesigning in
          ComponentState))) then
        exit;
    until i = StartIndex;
  end;
  result := nil;
end;

procedure TElPageControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FImages) then
      Images := nil;
    if (AComponent = FAlphaImages) then
      AlphaForImages := nil;
    if (AComponent = FImgForm) then
      ImageForm := nil;
    if AComponent = SoundMap then
      SoundMap := nil;
  end;
end;

procedure TElPageControl.SelectNextPage(GoForward: Boolean);
var
  Page: TElTabSheet;
begin
  Page := FindNextPage(ActivePage, GoForward, True, True);
  if (Page <> nil) and (Page <> ActivePage) then
  begin
//    TabIndex := Page.TabIndex;
    SetActivePage(Page);
//    Change;
  end;
end;

procedure TElPageControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  // UpdateTabs;
end;

function TElPageControl.TabFromPoint(Point: TPoint): TElTabSheet;
var
  i: integer;
  ASheet: TElTabSheet;
  R: TRect;
begin
  if (ActivePage <> nil) and ActivePage.FShown then
  begin
    R := ActivePage.FRect;
    Inc(R.Right);
    Inc(R.Bottom);
    if PtInRect(R, Point) then
    begin
      result := ActivePage;
      exit;
    end;
  end;
  for i := 0 to FPages.Count - 1 do
  begin
    ASheet := TElTabSheet(FPages[i]);
    if (ASheet <> ActivePage) and (ASheet.FShown) then
    begin
      R := ASheet.FRect;
      Inc(R.Right);
      Inc(R.Bottom);
      if PtInRect(R, Point) then
      begin
        result := ASheet;
        exit;
      end;
    end;
  end;
  result := nil;
end;

procedure TElPageControl.UpdateTabs(Immediate: boolean);
var
  R: TRect;
//  Flags: integer;
  P: PRect;
  ASize : TSize;
begin
  if (not HandleAllocated) or (not ShowTabs) then exit;
  if FUpdateCount > 0 then
  begin
    if Immediate then
      FUpdated := FUpdated or $0002
    else
      FUpdated := FUpdated or $0001;
  end
  else
  begin
    FUpdated := 0;
    //R := BoundsRect;
    //OffsetRect(R, -Left, -Top);
    ASize := FTabsSize;
    case TabPosition of
      etpLeft: R := Rect(0, 0, ASize.cx, ASize.cy);
      etpRight: R := Rect(Width - ASize.cx, 0, Width, ASize.cy);
      etpTop: R := Rect(0, 0, ASize.cx, ASize.cy);
      etpBottom: R := Rect(0, Height - ASize.cy, ASize.cx, Height);
    end;

    (*
    Flags := RDW_INVALIDATE or RDW_NOCHILDREN;
    if Immediate then
      Flags := Flags or RDW_ERASENOW or RDW_UPDATENOW;
    *)
    P := nil;
    case TabPosition of
      etpLeft:
        if Width >= FTabsSize.cx then P := @R;
      etpRight:
        if Width >= FTabsSize.cx then P := @R;
      etpTop:
        if Height >= FTabsSize.cy then P := @R;
      etpBottom:
        if Height >= FTabsSize.cy then P := @R;
    end;
    // SendDebug('UpdateTabs at ' + IntToStr(GetTickCount));

  //  RedrawWindow(Handle, P, 0, Flags);
    if P <> nil then
      InvalidateRect(Handle, P, false)
    else
    begin
      R := ClientRect;
      P := @R;
      InvalidateRect(Handle, P, false);
      end;
    if Immediate then Update;
    end;
end;

function TElPageControl.CanScrollRight: Boolean;
var
  i: integer;
begin
  result := false;
  if Multiline or (FirstTab = nil) then
    exit
  else
  begin
    for i := FirstTab.PageIndex to FPages.Count - 1 do
    begin
      if TElTabSheet(FPages[i]).TabVisible and (not
        TElTabSheet(FPages[i]).FComplete) then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

procedure TElPageControl.SetHotTrackFont(Value: TFont);
begin
  FHotTrackFont.Assign(Value);
end;

procedure TElPageControl.HotTrackFontChange(Sender: TObject);
begin
  if HotTrack and (FTrackTab <> nil) then
    UpdateTabs(false);
end;

procedure TElPageControl.Paint;
var
  R,
    R1: TRect;
  DC: HDC;
  {.$else}
  //DC : ElVCLUtils.HDC;
  TmpBmp: TBitmap;

  ACtl: TWinControl;
  ax,
    ay: integer;
  P: TPoint;

  ASize: TSize;
  Clp: TRect;
  BorderSides: TLMDBorderSides;
  HasVP : boolean;
  LThemeMode: TLMDThemeMode;
begin
  //R := inherited GetClientRect;
  R := ClientRect;
  // OffsetRect(R, -R.Left, -R.Top);
  DC := Canvas.Handle;
  HasVP := HasVisibleTabs;
  LThemeMode := UseThemeMode;
  if ShowTabs and HasVP then
  begin
    TmpBmp := TBitmap.Create;
    TmpBmp.Width := R.Right - R.Left;
    TmpBmp.Height := R.Bottom - R.Top;
    TmpBmp.Handle := CreateCompatibleBitmap(DC, R.Right - R.Left, R.Bottom - R.Top);
    TmpBmp.Canvas.Lock;
  end
  else
    TmpBmp := nil;

  ASize := FTabsSize;
  R := ClientRect;

  if ShowBorder and (Style in [etsTabs, etsNetTabs, etsFlatTabs, etsModernAngledTabs, etsAngledTabs, etsBitmapTabs])
    and (LThemeMode = ttmNone) then
  begin
    if ShowTabs and HasVP then
    begin
      case TabPosition of
        etpLeft: R := Rect(ASize.cx{ - GetSystemMetrics(SM_CXEDGE)}, 0, Width,
          ASize.cy);
        etpRight: R := Rect(0, 0, Width - ASize.cx {+
          GetSystemMetrics(SM_CXEDGE)}, ASize.cy);
        etpTop: R := Rect(0, ASize.cy{ - GetSystemMetrics(SM_CYEDGE)}, Width,
          Height);
        etpBottom: R := Rect(0, 0, Width, Height - ASize.cy{ +
          GetSystemMetrics(SM_CYEDGE)});
      end;
    end
    else
    begin
      R := ClientRect;
    end;
    BorderSides := AllBorderSides;
    if ShowTabs and HasVisibleTabs then
      case TabPosition of
        etpLeft: Exclude(BorderSides, ebsLeft);
        etpRight: Exclude(BorderSides, ebsRight);
        etpTop: Exclude(BorderSides, ebsTop);
        etpBottom: Exclude(BorderSides, ebsBottom);
      end;

    if Style in [etsFlatTabs, etsModernAngledTabs] then
    begin
      if FActivePage.UseTabColor then
        DrawFlatFrameEx2(DC, R, {FlatTabBorderColor}ColorDarker(FActivePage.TabColor, 60), {Color}FActivePage.TabColor, false, true,
          BorderSides, fbtColorLineBorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow)
      else
        DrawFlatFrameEx2(DC, R, FlatTabBorderColor, Color, false, true,
          BorderSides, fbtColorLineBorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow)
    end
    else
    begin
      DrawButtonFrameEx3(Canvas.Handle, R, not Flat, false, clBtnFace{Color}, false, BorderSides);
      if not Flat then
        InflateRect(R, -2, -2)
      else
        InflateRect(R, -1, -1);
    end;
    //
  end;
  if ShowTabs and HasVP then
  begin
    case TabPosition of
      etpLeft: R := Rect(0, 0, ASize.cx, ASize.cy);
      etpRight: R := Rect(Width - ASize.cx, 0, Width, ASize.cy);
      etpTop: R := Rect(0, 0, ASize.cx, ASize.cy);
      etpBottom: R := Rect(0, Height - ASize.cy, ASize.cx, Height);
    end;

    bitblt(TmpBmp.Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
      DC, R.Left, R.Top, { 0, 0,} SRCCOPY);

    if IsThemed then
      DrawThemeParentBackground(Handle, TmpBmp.Canvas.Handle, @R);
    DrawTabs(TmpBmp.Canvas, R, true, ASize);

    Clp := R;

    bitblt(DC, Clp.Left, Clp.Top, Clp.Right - Clp.Left, Clp.Bottom - Clp.Top,
      TmpBmp.Canvas.Handle, Clp.Left, Clp.Top, { 0, 0,} SRCCOPY);
    TmpBmp.Canvas.Unlock;
    TmpBmp.Free;
  end;
  if HasVP then exit;

  //R := ClientRect;
  R1 := Canvas.ClipRect;

  if LThemeMode <> ttmNone then
  begin
    LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, ttBody, R, LMDRectToPtr(R1));
    Exit;
  end;

  if (FImgForm <> nil) and (not (csDesigning in
    FImgForm.GetRealControl.ComponentState)) then
  begin
    if (FImgForm.Control <> Self) then
    begin
      ACtl := FImgForm.GetRealControl;
      R1 := R;
      R.TopLeft := ClientToScreen(R.TopLeft);
      P := Parent.ClientToScreen(Point(Left, Top));
      ax := R.Left - P.x;
      ay := R.Top - P.y;

      R.BottomRight := ClientToScreen(R.BottomRight);
      R.TopLeft := ACtl.ScreenToClient(R.TopLeft);
      R.BottomRight := ACtl.ScreenToClient(R.BottomRight);

      FImgForm.PaintBkgnd(Handle, R1, Point(R.Left - ax, R.Top - ay), false);
    end;
  end
  else

  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(R);
  end;
end;

procedure TElPageControl.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  DockCtl: TControl;
begin
  inherited;
  DblClick;
  DockCtl := GetDockClientFromMousePos(SmallPointToPoint(Message.Pos));
  if DockCtl <> nil then
    DockCtl.ManualDock(nil, nil, alNone);
end;

procedure TElPageControl.WMKeyDown(var Message: TWMKeyDown);

begin
  inherited;
  IntKeyDown(Message.CharCode);
  end;

procedure TElPageControl.SetScrollBtnState(Value: TElPageScrollBtnState);
begin
  if FScrollBtnState <> Value then
  begin
    if (not (FScrollBtnState in [pbsLeftBtnDown, pbsRightBtnDown])) and
      (Value in [pbsLeftBtnDown, pbsRightBtnDown]) then
    begin
      FScrollTimer := TTimer.Create(nil);
      FScrollTimer.Enabled := false;
      FScrollTimer.OnTimer := OnScrollTimer;
      FScrollTimer.Interval := 250;
      FScrollTimer.Enabled := true;
    end;
    FScrollBtnState := Value;
    if not (FScrollBtnState in [pbsLeftBtnDown, pbsRightBtnDown]) then
    begin
      FScrollTimer.Free;
      FScrollTimer := nil;
    end;
    UpdateTabs(false);
  end;
end;

procedure TElPageControl.SetTrackTab(Value: TElTabSheet);
begin
  if FTrackTab <> Value then
  begin
    FTrackTab := Value;
    if HotTrack or IsThemed then
      UpdateTabs(false);
  end;
end;

procedure TElPageControl.SetShowAccelChar(Value: Boolean);
begin
  if FShowAccelChar <> Value then
  begin
    FShowAccelChar := Value;
    Realign;
    Invalidate;
  end;
end;

procedure TElPageControl.WMLButtonDown(var Message: TWMLBUTTONDOWN);
begin

  if DragMode = dmAutomatic then
  begin
    BeginAutoDrag;
    Exit;
  end;

  inherited;
  //with ScreenToClient(Point(Message.XPos, Message.YPos)) do
    IntMouseDown(Message.XPos, Message.YPos);
end;

procedure TElPageControl.WMLButtonUp(var Message: TWMLBUTTONUP);
begin
  inherited;
  IntLButtonUp(Message.XPos, Message.YPos);
end;

function TElPageControl.DoHitTest(X, Y: integer; var Res: LRESULT): boolean;
var
  P: TPoint;
  R: TRect;
  ASheet: TElTabSheet;
begin
  R.TopLeft := FTabsPos;
  R.Right := FTabsPos.x + FTabsSize.cx;
  R.Bottom := FTabsPos.y + FTabsSize.cy;

  p := Point(X, Y);

  result := false;

  if PtInRect(FScrollLeftRect, p) then
  begin
    if ScrollBtnState = pbsNone then
      ScrollBtnState := pbsLeftBtnOver
    else
      if ScrollBtnState = pbsLeftBtnHeld then
      ScrollBtnState := pbsLeftBtnDown
    else
      if ScrollBtnState = pbsRightBtnDown then
      ScrollBtnState := pbsRightBtnHeld
    else
      if ScrollBtnState = pbsRightBtnOver then
      ScrollBtnState := pbsNone;
    result := true;
  end
  else
  begin
    if ScrollBtnState = pbsLeftBtnDown then
      ScrollBtnState := pbsLeftBtnHeld
    else
      if ScrollBtnState = pbsLeftBtnOver then
      ScrollBtnState := pbsNone;

    if PtInRect(FScrollRightRect, p) then
    begin
      if ScrollBtnState = pbsNone then
        ScrollBtnState := pbsRightBtnOver
      else
        if ScrollBtnState = pbsRightBtnHeld then
        ScrollBtnState := pbsRightBtnDown;
      result := true;
    end
    else
      if ScrollBtnState = pbsRightBtnOver then
      ScrollBtnState := pbsNone
    else
      if ScrollBtnState = pbsRightBtnDown then
      ScrollBtnState := pbsRightBtnHeld;
  end;

  if PtInRect(R, P) then
  begin
    ASheet := TabFromPoint(p);
    if (ASheet <> nil) and (ASheet.TabEnabled or (csDesigning in ComponentState)) then
    begin
      TrackTab := ASheet;
      exit;
    end
  end;
  TrackTab := nil;
  (*if (ScrollBtnState in [pbsLeftBtnOver, pbsRightBtnOver]) then
    ScrollBtnState := pbsNone;*)
end;

procedure TElPageControl.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    with ScreenToClient(Point(Message.XPos, Message.YPos)) do
      DoHitTest(X, Y, Message.Result);
end;

procedure TElPageControl.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if (Message.LParam = 0) or (Message.LParam = TLMDPtrInt(Self)) then
    begin
      TrackTab := nil;
      if (ScrollBtnState in [pbsLeftBtnOver, pbsRightBtnOver]) then
        ScrollBtnState := pbsNone;
      if FHintWnd <> nil then
        ShowWindow(FhintWnd.Handle, SW_HIDE);
        FHintTimer.Enabled := false;

      FDoStartDrag := -1;
      perform(WM_SETCURSOR, Handle, 0);
    end;
  if FDockMouseDown then
    FDockMouseDown := False;
end;

procedure TElPageControl.OnScrollTimer(Sender: TObject);
begin
  if (ScrollBtnState = pbsLeftBtnDown) and (CanScrollLeft) then
    FirstTab := FindNextPage(FirstTab, false, true, false)
  else
    if (ScrollBtnState = pbsRightBtnDown) and (CanScrollRight) then
    FirstTab := FindNextPage(FirstTab, true, true, false)
  {else
    FScrollTimer.Enabled := false
  }
    ;
end;

procedure TElPageControl.SetTabBkColor(Value: TColor);
begin
  if FTabBkColor <> Value then
  begin
    FTabBkColor := Value;
    UpdateTabs(false);
  end;
end;

function TElPageControl.HasVisibleTabs: Boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to FPages.Count - 1 do
  begin
    if TElTabSheet(FPages[i]).TabVisible then
    begin
      result := true;
      exit;
    end;
  end;
end;

function TElPageControl.NewPage: TElTabSheet;
begin
//  FTabCaptions.Add('');
  Result := FTabSheetClass.Create(Self);
  Result.PageControl := Self;
end;

procedure TElPageControl.Loaded;
begin
  Realign;
  inherited;
  FDenyChanging := True;
  if Style = etsBitmapTabs then
  begin
    if Assigned(FTab) and (FTab is TElBitmapTab) then
    begin
      (FTab as TElBitmapTab).FActiveTab.Assign(FActiveTab);
      (FTab as TElBitmapTab).FActiveTab.TransparentColor := (FTab as TElBitmapTab).FActiveTab.Canvas.Pixels[1,
                           (FTab as TElBitmapTab).FActiveTab.Height - 1];
      (FTab as TElBitmapTab).FCloseButton.Assign(FCloseButton);
      (FTab as TElBitmapTab).FTab.Assign(FBTab);
      (FTab as TElBitmapTab).FTab.TransparentColor := (FTab as TElBitmapTab).FTab.Canvas.Pixels[1,
                           (FTab as TElBitmapTab).FTab.Height - 1];
    end;
  end;
  FNoDTAlert := true;
  HandleNeeded;

  RecalcTabPositions;

  SelectFirstTab;

  // UpdateTabs(true);

  if ActivePage <> nil then
    ActivePage.Visible := true;
  TabBkColorNetStyle := IncColor(ColorToRGB(Color), 20, 20, 20);
  if (DefaultPage <> nil) and (DefaultPage.PageControl = Self)
    {and (DefaultPage.tabVisible)} then
    ActivePage := DefaultPage
  else
    FNoSetFirstTab := false;
  UpdateStyle;
  FDenyChanging := False;
end;

procedure TElPageControl.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
 Message.Result := {DLGC_WANTALLKEYS or }DLGC_WANTARROWS;
end;

procedure TElPageControl.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  PostMessage(Handle, PM_REFRESHACTIVEPAGE, 0, 0);
  // if Multiline then
end;

procedure TElPageControl.Resize;
begin
  inherited;
  RebuildTabs(true);
end;

procedure TElPageControl.SetTabMarginLeft(Value: integer);
var
  n: integer;
begin
  if Value <> FTabMarginLeft then
  begin
    if (TabPosition in [etpLeft, etpRight]) then
      n := Height
    else
      n := Width;
    if LMDInRange(Value, 0, n - FTabMarginRight - 2) then
    begin
      FTabMarginLeft := Value;
    end;
    RecalcTabPositions;
    Invalidate;
  end;
end;

procedure TElPageControl.SetTabMarginRight(Value: integer);
var
  n: integer;
begin
  if Value <> FTabMarginRight then
  begin
    if (TabPosition in [etpLeft, etpRight]) then
      n := Height
    else
      n := Width;
    if LMDInRange(Value, 0, n - FTabMarginLeft - 2) then
    begin
      FTabMarginRight := Value;
    end;
    RecalcTabPositions;
    Invalidate;
  end;
end;

procedure TElPageControl.UpdateMultilineOrder;
var
  i: integer;
begin
  if MultiLine and (ActivePage <> nil) and (Style in [etsTabs, etsNetTabs,
    etsFlatTabs, etsModernAngledTabs, etsAngledTabs, etsBitmapTabs]) then
  begin
    if (ActivePage.FLine < FLines - 1) then
    begin
      for i := 0 to FPages.Count - 1 do
      begin
        if TElTabSheet(FPages[i]).FLine = ActivePage.FLine + 1 then
        begin
          FirstTab := TElTabSheet(FPages[i]);
          RecalcTabPositions;
          break;
        end;
      end;
    end;
  end;
end;

procedure TElPageControl.TriggerGetImageEvent(PageIndex: integer; var
  ImageIndex: integer);
begin
  if assigned(FOnGetImageIndex) then
    FOnGetImageIndex(Self, PageIndex, ImageIndex);
end;

procedure TElPageControl.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  if ShowTabs then
    UpdateTabs(false);
  Broadcast(Message);
end;

procedure TElPageControl.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TElPageControl.IFMEffectiveSize(var Message: TMessage);
var
  LRect: TRect;
begin
  inherited;
  if Message.lParam <> 0 then
  begin
    LRect := BoundsRect;
    OffsetRect(LRect, -Left, -Top);
    PRect(Message.lParam)^ := LRect;
    end;
end;

procedure TElPageControl.IFMCanPaintBkgnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

procedure TElPageControl.PMRefreshActivePage(var Message: TMessage);
var
  ASheet: TElTabSheet;
begin
  ASheet := ActivePage;
  if ASheet <> nil then
  begin
    if CanChange(ASheet, false) then
      FActivePage := nil
    else
      ASheet := FindNextPage(ASheet, True, True, True);
    ActivePage := ASheet;
  end;
end;

procedure TElPageControl.WMRButtonUp(var Message: TWMRBUTTONUP);
begin
  inherited;
  //with ScreenToClient(Point(Message.XPos, Message.YPos)) do
  IntRButtonUp(Message.XPos, Message.YPos);
end;

procedure TElPageControl.SetDraggablePages(Value: boolean);
begin
  FDraggablePages := Value;
  FDoStartDrag := -1;
end;

procedure TElPageControl.SetCloseButtonMode(Value: TElCloseBtnMode);
begin
  if FCloseBtnMode <> Value then
  begin
    FCloseBtnMode := Value;
    RebuildTabs(false);
  end;
end;

constructor TElTab.Create(Owner: TElPageControl);
begin
  inherited Create;
  FOwner := Owner;
end;

function TElTab.GetOuterMargin: Integer;
begin
  Result := 0;
end;

function TElTab.GetInnerMargin: Integer;
begin
  Result := 0;
end;

procedure TElTab.DrawTabContents(Canvas: TCanvas; R: TRect; TabSheet: TElTabSheet);
var
  FPageControl: TElPageControl;

  SR, R2: TRect;
  Bmp: TBitmap;
  amBMP: TBitmap;
  AFont: HFont;
  i: integer;
  Size: TSize;
  ImIdx: integer;
  aPosition: TElTabPosition;
  TmpBmp, TmpBmp1: TBitmap;
  R1: TRect;
const
  CenterFlags: array[boolean] of Cardinal = (DT_LEFT, DT_CENTER);
  SingleLineFlags: array[boolean] of Cardinal = (DT_SINGLELINE, 0);

begin
  FPageControl := FOwner;
  SR := R;
  if (FPageControl.FActivePage = TabSheet) and (FPageControl.UseActiveTabFont) then
    Canvas.Font.Assign(FPageControl.ActiveTabFont)
  else
    if FPageControl.HotTrack and (FPageControl.FTrackTab = TabSheet) and (TabSheet.TabEnabled) then
    Canvas.Font.Assign(FPageControl.HotTrackFont)
  else
    if (not TabSheet.ParentFont) and TabSheet.UseFontForTabs then
    Canvas.Font.Assign(TabSheet.Font)
  else
    Canvas.Font.Assign(FPageControl.Font);
  if (not TabSheet.TabEnabled) then
    Canvas.Font.Color := clBtnShadow;

  AFont := FOwner.GetRotatedFont(Canvas, 0);
  Canvas.Font.Handle := AFont;

  case FPageControl.TabPosition of
    etpTop,
      etpBottom:
      begin
        inc(R.Left, GetContentMargin);
        dec(R.Right, GetContentMargin);
      end;
    etpLeft,
      etpRight:
      begin
        if FPageControl.VerticalSideCaptions then
        begin
          dec(R.Bottom, GetContentMargin);
          inc(R.Top, GetContentMargin);
        end
        else
        begin
          inc(R.Left, GetContentMargin);
          dec(R.Right, GetContentMargin);
        end;
      end;
  end;
  if (R.Bottom < R.Top) or (R.Right < R.Left) then
    exit;

  if (not FPageControl.VerticalSideCaptions) then
    aPosition := etpTop
  else
    aPosition := FPageControl.FTabPosition;

  imidx := TabSheet.ImageIndex;
  if imidx = -1 then
    FPageControl.TriggerGetImageEvent(TabSheet.PageIndex, imidx);

  if (FPageControl.Images <> nil) and (FPageControl.ShowImages) and (imidx <> -1)
    then
  begin
    if LMDInRange(ImIdx, 0, FPageControl.Images.Count - 1) then
    begin
      BMP := TBitmap.Create;
      BMP.Width := FPageControl.Images.Width;
      BMP.Height := FPageControl.Images.Height;

      case aPosition of
        etpTop,
          etpBottom:
          begin
            R2.Left := R.Left;
            R2.Top := R.Top + Max(0, (R.Bottom - R.Top - bmp.Height) div 2);
            R2.Right := Min(R.Right, R.Left + Bmp.Width);
            R2.Bottom := Min(R.Bottom, R2.Top + Bmp.Height);
          end;
        etpLeft:
          begin
            R2.Top := Max(R.Top, R.Bottom - Bmp.Height);
            R2.Left := R.Left + Max(0, (R.Right - R.Left - bmp.Width) div 2);
            R2.Bottom := R.Bottom;
            R2.Right := Min(R.Right, R.Left + Bmp.Width);
          end;
        etpRight:
          begin
            R2.Top := R.Top;
            R2.Left := R.Left + Max(0, (R.Right - R.Left - bmp.Width) div 2);
            R2.Bottom := Min(R.Bottom, R2.Top + Bmp.Height);
            R2.Right := Min(R.Right, R.Left + Bmp.Width);
          end;
      end;

      Bmp.Canvas.CopyRect(Rect(0, 0, R2.Right - R2.Left, R2.Bottom - R2.Top),
        Canvas, R2);

      FPageControl.Images.Draw(BMP.Canvas, 0, 0, ImIdx);

      if Assigned(FPageControl.AlphaForImages) and (LMDInRange(ImIdx, 0,
        FPageControl.AlphaForImages.Count - 1)) then
      begin
        amBMP := TBitmap.Create;
        amBMP.Width := FPageControl.AlphaForImages.Width;
        amBMP.Height := FPageControl.AlphaForImages.Height;
        ImageList_DrawEx(FPageControl.AlphaForImages.Handle, ImIdx,
          amBMP.Canvas.Handle, 0, 0, 0, 0,
          clNone, clNone, ILD_Normal);

        AlphaCopyRect2(Canvas.Handle, R2, BMP.Canvas.Handle,
          Rect(0, 0, R2.Right - R2.Left, R2.Bottom - R2.Top), amBMP, 255);

        amBMP.Free;
      end
      else

        Canvas.CopyRect(R2, BMP.Canvas, Rect(0, 0, R2.Right - R2.Left, R2.Bottom
          - R2.Top));

      BMP.Free;
    end;
    case aPosition of
      etpTop,
        etpBottom:
        inc(R.Left, FPageControl.Images.Width + Margin);
      etpLeft:
        dec(R.Bottom, FPageControl.Images.Height + Margin);
      etpRight:
        inc(R.Top, FPageControl.Images.Height + Margin);
    end;
  end;

{$IFDEF LMD_UNICODE}
  if LMDWidePos(LMDWideCRLF, TabSheet.Caption) > 0 then
{$ELSE}
  if Pos(LMDAnsiCRLF, TabSheet.Caption) > 0 then
{$ENDIF}
  begin
    LMDDrawText(Canvas.Handle,
     TabSheet.Caption,
      Length(TabSheet.Caption), R2, DT_CALCRECT);
    Size.cx := R2.Right - R2.Left;
    Size.cy := R2.Bottom - R2.Top;
  end
  else

{$IFDEF LMD_UNICODE}
    GetTextExtentPoint32W(Canvas.Handle, PWideChar(TabSheet.Caption),
      Length(TabSheet.Caption), Size);
{$ELSE}
    GetTextExtentPoint32(Canvas.Handle, PChar(TabSheet.Caption),
      Length(TabSheet.Caption), Size);
{$ENDIF}

  if (FPageControl.TabPosition in [etpLeft, etpRight]) and
    FPageControl.VerticalSideCaptions then
  begin
    i := Size.cx;
    Size.cx := Size.cy;
    Size.cy := i;
  end;
  if (FPageControl.TabPosition in [etpLeft, etpRight]) and
    FPageControl.VerticalSideCaptions then
  begin
    R.Left := Max(R.Left, R.Left + (R.Right - R.Left - Size.cx) div 2);
  end
  else
  begin
    R.Top := Max(R.Top, R.Top + (R.Bottom - R.Top - Size.cy) div 2);
  end;
  Canvas.Brush.Style := bsClear;

  if (FPageControl.UseThemeMode <> ttmNone) and (FPageControl.Style in [etsButtons, etsFlatButtons]) then
  begin
    if (FPageControl.FActivePage = TabSheet) then
      Canvas.Font.Color := LMDThemeServices.GetThemeColor(FPageControl.UseThemeMode, teButton, BP_PUSHBUTTON, PBS_NORMAL, TMT_TEXTCOLOR)
    else if FPageControl.HotTrack and (FPageControl.FTrackTab = TabSheet) and (TabSheet.TabEnabled) then
      Canvas.Font.Color := LMDThemeServices.GetThemeColor(FPageControl.UseThemeMode, teButton, BP_PUSHBUTTON, PBS_HOT, TMT_TEXTCOLOR)
  end;

  if aPosition in [etpTop, etpBottom] then
    LMDDrawText(Canvas.Handle, TabSheet.Caption,
      Length(TabSheet.Caption), R, SingleLineFlags[LMDWidePos(LMDWideCRLF,
      TabSheet.Caption) > 0] or CenterFlags[FPageControl.CenterTabCaptions] or AccelFlags[FPageControl.ShowAccelChar])
  else
  begin
    TmpBmp := TBitmap.Create;
    TmpBmp1 := TBitmap.Create;
    try
      R1 := Rect(0,0,R.Bottom - R.Top,R.Right - R.Left);
      TmpBmp1.Width := R.Right - R.Left;
      TmpBmp1.Height := R.Bottom - R.Top;
      TmpBmp1.PixelFormat := pf32bit;
      TmpBmp.Width := R.Bottom - R.Top;
      TmpBmp.Height := R.Right - R.Left;
      TmpBmp.PixelFormat := pf32bit;

      TmpBmp.Canvas.Font.Assign(Canvas.Font);

      BitBlt(TmpBmp1.Canvas.Handle, 0, 0, TmpBmp1.Width, TmpBmp1.Height, Canvas.Handle, R.Left, R.Top, SRCCOPY);
      case APosition of
        etpLeft:
        begin
          LMDBmpRotate(TmpBmp1, TmpBmp, 270 * Pi / 180);
        end;
        etpRight:
        begin
          LMDBmpRotate(TmpBmp1, TmpBmp, 90 * Pi / 180);
        end;
      end;
      TmpBmp.Canvas.Brush.Style := bsClear;
      LMDDrawText(TmpBmp.Canvas.Handle, TabSheet.Caption,
        Length(TabSheet.Caption), R1, SingleLineFlags[LMDWidePos(LMDWideCRLF,
        TabSheet.Caption) > 0] or CenterFlags[FPageControl.CenterTabCaptions] or AccelFlags[FPageControl.ShowAccelChar]);
      case APosition of
        etpLeft:
        begin
          LMDBmpRotate(TmpBmp, TmpBmp1, 90 * Pi / 180);
          BitBlt(Canvas.Handle, R.Left, R.Top, TmpBmp1.Width, TmpBmp1.Height, TmpBmp1.Canvas.Handle, 0, 0, SRCCOPY);
//          Canvas.Draw(R.Left, R.Top, TmpBmp1);
        end;
        etpRight:
        begin
          LMDBmpRotate(TmpBmp, TmpBmp1, 270 * Pi / 180);
          BitBlt(Canvas.Handle, R.Left, R.Top, TmpBmp1.Width, TmpBmp1.Height, TmpBmp1.Canvas.Handle, 0, 0, SRCCOPY);
//          Canvas.Draw(R.Left, R.Top, TmpBmp1);
        end;
      end;
    finally
      TmpBmp.Free;
      TmpBmp1.Free;
    end;
  end;

  if FPageControl.DrawFocusRect and FPageControl.Focused and
    (TabSheet = FPageControl.ActivePage) then
  begin
    Canvas.Pen.Color := FPageControl.Font.Color;
    AdjustFocusRect(SR);
    ElVCLUtils.DrawFocus(Canvas, SR);
    end;
  end;

procedure TElTab.DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my:
  integer);
begin
  // intentionally left blank
end;

function TElTab.CanDrawTab(ActiveDraw: boolean): Boolean;
begin
  result := not ActiveDraw;
end;

procedure TElTab.AdjustDrawingSize(Active: boolean; var R: TRect);
begin
  // intentionally left blank
end;

function TElTab.GetAscend: Integer;
begin
  Result := 0;
end;

procedure TElTab.Draw(ACanvas: TCanvas; R: TRect; TabSheet: TElTabSheet);
var
  DefDraw: boolean;
  PgCtl: TElPageControl;
begin
  if (R.Bottom < R.Top) or (R.Right < R.Left) then
    exit;
  PgCtl := FOwner;
  PgCtl.TriggerDrawTabEvent(ACanvas, TabSheet, r, edsBackground, DefDraw);
  if DefDraw then
    FillTab(ACanvas, R, TabSheet);

  PgCtl.TriggerDrawTabEvent(ACanvas, TabSheet, r, edsEdges, DefDraw);
  if DefDraw then
    DrawTabEdges(ACanvas, R, TabSheet);
  if TabSheet.CloseButtonVisible then
    DrawCloseButton(ACanvas, R, TabSheet);
  InflateRect(R, -(Margin div 2), -(Margin div 2));
  PgCtl.TriggerDrawTabEvent(ACanvas, TabSheet, r, edsContents, DefDraw);
  if DefDraw then
    DrawTabContents(ACanvas, R, TabSheet);
  InflateRect(R, Margin div 2, Margin div 2);
  FixupTab(ACanvas, R, TabSheet);
end;

procedure TElTab.DrawThemedCloseButton(Canvas: TCanvas; var R: TRect; TabSheet: TElTabSheet);
var
  // LDetails: TThemedWindow;
  LDetails2: TThemedElementDetails;
begin
  with TabSheet do
    if not CloseBtnEnabled then
      // LDetails := twMDISysButtonDisabled
      LDetails2.State := CBS_DISABLED
//      iStateId := SBS_DISABLED
    else
      if (PageIndex > -1) and (PageIndex = FPageControl.ActivePageIndex) then
        if FCloseBtnDown then
          // LDetails := twMDISysButtonPushed
          LDetails2.State := CBS_PUSHED
//          iStateId := SBS_PUSHED
        else
          if FCloseBtnOwer then
            // LDetails := twMDISysButtonHot
            LDetails2.State := CBS_HOT
//            iStateId := SBS_HOT
          else
//            iStateId := SBS_NORMAL
            LDetails2.State := CBS_NORMAL
            // LDetails := twMDISysButtonNormal
      else
//        iStateId := SBS_NORMAL;
        // LDetails := twMDISysButtonNormal;
        LDetails2.State := CBS_NORMAL;
  LDetails2.Element := teWindow;
  LDetails2.Part := WP_SMALLCLOSEBUTTON;
   LMDThemeServices.DrawElement(FOwner.UseThemeMode, Canvas.Handle, LDetails2, R, nil);
  //  LMDThemeServices.DrawElement(FOwner.UseThemeMode, Canvas.Handle, LDetails, R, nil);
//  DrawThemeBackground(CloseBtnTheme, Canvas.Handle, WP_SMALLCLOSEBUTTON, iStateId, R, nil)
end;

procedure TElTab.DrawCloseButton(Canvas: TCanvas; var R: TRect; TabSheet:
  TElTabSheet);
const
  HMargin = Margin div 2;
var
//  iStateId: integer;
  sx, sy: integer;
//  pc: integer;
  tr: Trect;
begin
  sx := GetSystemMetrics(SM_CXSMSIZE);//SM_CXMENUSIZE {SM_CXSIZE});
  sy := GetSystemMetrics(SM_CYSMSIZE);//SM_CYMENUSIZE {SM_CYSIZE});
  if R.Bottom - R.Top - Margin < sy then
  begin
    dec(sx, (sy - (R.Bottom - R.Top - Margin)));
    dec(sy, (sy - (R.Bottom - R.Top - Margin)));
    if sx < 0 then sx := 0;
    if sy < 0 then sy := 0;
  end;
{
  if IsThemeApplied then
  begin
    sx := sx - sx div 4;
    sy := sy - sy div 4;
  end;
}
  case FOwner.TabPosition of
    etpTop:
      begin
        TabSheet.FCloseBtnRect := Rect(R.Right - HMargin - sx,
          R.Top + HMargin,
          R.Right - HMargin,
          R.Top + HMargin + sy);
        if (FOwner.Style = etsAngledTabs) or (FOwner.Style = etsModernAngledTabs) then
          OffsetRect(TabSheet.FCloseBtnRect, -Margin, Margin);
        R.Right := TabSheet.FCloseBtnRect.Left;
      end;
    etpBottom:
      begin
        TabSheet.FCloseBtnRect := Rect(R.Right - HMargin - sy,
          R.Bottom - HMargin - sy,
          R.Right - HMargin,
          R.Bottom - HMargin);
        R.Right := TabSheet.FCloseBtnRect.Left;
        if (FOwner.Style = etsAngledTabs) and (FOwner.Style = etsModernAngledTabs) then
          OffsetRect(TabSheet.FCloseBtnRect, -Margin, -Margin);
        end;
    etpLeft:
      begin
        TabSheet.FCloseBtnRect := Rect(R.Left + HMargin,
          R.Top + HMargin,
          R.Left - HMargin + sx,
          R.Top - HMargin + sy);
        if (FOwner.Style = etsAngledTabs) and (FOwner.Style = etsModernAngledTabs) then
          OffsetRect(TabSheet.FCloseBtnRect, Margin, Margin);
        R.Top := TabSheet.FCloseBtnRect.Bottom;
      end;
    etpRight:
      begin
        TabSheet.FCloseBtnRect := Rect(R.Right + HMargin - sy,
          R.Bottom + HMargin - sy,
          R.Right - HMargin,
          R.Bottom - HMargin);
        if (FOwner.Style = etsAngledTabs) and (FOwner.Style = etsModernAngledTabs) then
          OffsetRect(TabSheet.FCloseBtnRect, -Margin, -Margin);
        R.Bottom := TabSheet.FCloseBtnRect.Top;
      end;
  end;

  tr := TabSheet.FCloseBtnRect;

  if IsThemed then
  begin
    DrawThemedCloseButton(Canvas, tr, TabSheet);
  end
  else
  begin
    DrawButtonFrameEx3(Canvas.Handle, tr, not FOwner.Flat,
      TabSheet.CloseBtnEnabled and TabSheet.FCloseBtnDown and (TabSheet.PageIndex = FOwner.ActivePageIndex),
      FOwner.Color, false, AllBorderSides);
    //    pc := Canvas.Pen.Color;
    if TabSheet.CloseBtnEnabled then
    begin
      Canvas.Pen.Color := clBtnText;
      with Canvas do
        with tr do
        begin
          MoveTo(Left + 1 + 3, Top + 1 + 3);
          LineTo(Right - 1 - 4, Bottom - 1 - 4);
          MoveTo(Left + 1 + 3, Bottom - 1 - 5);
          LineTo(Right - 1 - 4, Top + 1 + 2);

          MoveTo(Left + 1 + 3 + 1, Top + 1 + 3);
          LineTo(Right - 1 - 4 + 1, Bottom - 1 - 4);
          MoveTo(Left + 1 + 3 + 1, Bottom - 1 - 5);
          LineTo(Right - 1 - 4 + 1, Top + 1 + 2);
        end;
    end
    else
    begin
      Canvas.Pen.Color := clBtnHighlight;
      OffsetRect(tr, 1, 1);
      with Canvas do
        with tr do
        begin
          MoveTo(Left + 1 + 3, Top + 1 + 3);
          LineTo(Right - 1 - 4, Bottom - 1 - 4);
          MoveTo(Left + 1 + 3, Bottom - 1 - 5);
          LineTo(Right - 1 - 4, Top + 1 + 2);

          MoveTo(Left + 1 + 3 + 1, Top + 1 + 3);
          LineTo(Right - 1 - 4 + 1, Bottom - 1 - 4);
          MoveTo(Left + 1 + 3 + 1, Bottom - 1 - 5);
          LineTo(Right - 1 - 4 + 1, Top + 1 + 2);
        end;
      Canvas.Pen.Color := clBtnShadow;
      OffsetRect(tr, -1, -1);
      with Canvas do
        with tr do
        begin
          MoveTo(Left + 1 + 3, Top + 1 + 3);
          LineTo(Right - 1 - 4, Bottom - 1 - 4);
          MoveTo(Left + 1 + 3, Bottom - 1 - 5);
          LineTo(Right - 1 - 4, Top + 1 + 2);

          MoveTo(Left + 1 + 3 + 1, Top + 1 + 3);
          LineTo(Right - 1 - 4 + 1, Bottom - 1 - 4);
          MoveTo(Left + 1 + 3 + 1, Bottom - 1 - 5);
          LineTo(Right - 1 - 4 + 1, Top + 1 + 2);
        end;
    end;
//    Canvas.Pen.Color := pc;
  end;
end;

procedure TElTab.AdjustTabSize(var Size: TSize);
begin
  // intentionally left blank
end;

procedure TElTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet: TElTabSheet);
begin
  if After then
    InflateRect(R, 1, 1)
  else
    InflateRect(R, -1, -1);
end;

procedure TElTab.DrawTabLine(Canvas: TCanvas; R: TRect);
begin
  // intentionally left blank
end;

procedure TElTab.FillSpace(Canvas: TCanvas; Rect: TRect);
//var
//  R: TRect;
//  OldP: TPoint;
begin
  if IsThemed and not (csDesigning in FOwner.ComponentState) then
  begin
//    R := Rect;
//    OldP := Point(FOwner.Left, FOwner.Top);
//    SetMapMode(Canvas.Handle, MM_ANISOTROPIC);
//    SetViewPortOrgEx(Canvas.Handle, -OldP.x, -OldP.y, @OldP);
//    SendMessage(FOwner.Parent.Handle, WM_ERASEBKGND, Canvas.Handle, 0);
//    SetViewPortOrgEx(Canvas.Handle, OldP.x, OldP.y, nil);
//    SetMapMode(Canvas.Handle, MM_TEXT);
  end
  else
  begin
    Canvas.Brush.Color := FOwner.TabBkColor;
    Canvas.FillRect(Rect);
  end;
end;

procedure TElTab.FillTab(Canvas: TCanvas; Rect: TRect; TabSheet:
  TElTabSheet);
begin
  AdjustFillSize(false, Rect, TabSheet);

  if (FOwner.FImgForm = nil) or (csDesigning in
    FOwner.ComponentState) then

  begin
    Canvas.Brush.Style := bsSolid;
    if TabSheet.UseTabColor then
      Canvas.Brush.Color := TabSheet.TabColor
    else
      if TabSheet = FOwner.FActivePage then
      Canvas.Brush.Color := FOwner.FActiveTabColor
    else
      Canvas.Brush.Color := FOwner.FInactiveTabColor;
    Canvas.FillRect(Rect);
  end;
  AdjustFillSize(true, Rect, TabSheet);
end;

procedure TElTab.DrawButtons(Canvas: TCanvas; LeftRect, RightRect: TRect; CSL,
  CSR: boolean);
var
//  iPartId: Integer;
//  iStateId: Integer;
  LDetails: TThemedElementDetails;
  LThemeMode: TLMDThemeMode;
  LIsThemed: boolean;
begin
  LIsThemed := IsThemed;
  if LIsThemed then
    LThemeMode := FOwner.UseThemeMode
  else
    LThemeMode := ttmNone;
  if LIsThemed then
  begin
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      if FOwner.TabPosition = etpLeft then
        LDetails.Part := SPNP_DOWN
      else
        LDetails.Part := SPNP_UP;
      if CSL then
      begin
        if FOwner.ScrollBtnState = pbsLeftBtnDown then
        begin
          LDetails.State := DNS_PRESSED;
        end
        else
        begin
          LDetails.State := DNS_NORMAL;
        end;
      end
      else
      begin
        LDetails.State := DNS_DISABLED;
      end;
    end
    else
    begin
      LDetails.Part := SPNP_DOWNHORZ;
      if CSL then
      begin
        if FOwner.ScrollBtnState = pbsLeftBtnDown then
        begin
          LDetails.State := DNHZS_PRESSED;
        end
        else
        begin
          LDetails.State := DNHZS_NORMAL;
        end;
      end
      else
      begin
        LDetails.State := DNHZS_DISABLED;
      end;
    end;
    LDetails.Element := teSpin;
    LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetails, LeftRect, nil);
//    DrawThemeBackground(ScrollTheme, Canvas.Handle, iPartId, iStateId, LeftRect, nil);
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      if FOwner.TabPosition = etpLeft then
        LDetails.Part := SPNP_UP
      else
        LDetails.Part := SPNP_DOWN;
      if CSR then
      begin
        if FOwner.ScrollBtnState = pbsRightBtnDown then
        begin
          LDetails.State := UPS_PRESSED;
        end
        else
        begin
          LDetails.State := UPS_NORMAL;
        end;
      end
      else
      begin
        LDetails.State := UPS_DISABLED;
      end;
    end
    else
    begin
      LDetails.Part := SPNP_UPHORZ;
      if CSR then
      begin
        if FOwner.ScrollBtnState = pbsRightBtnDown then
        begin
          LDetails.State := UPHZS_PRESSED;
        end
        else
        begin
          LDetails.State := UPHZS_NORMAL;
        end;
      end
      else
      begin
        LDetails.State := UPHZS_DISABLED;
      end;
    end;
    LDetails.Element := teSpin;
    LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetails, RightRect, nil);
//    DrawThemeBackground(ScrollTheme, Canvas.Handle, iPartId, iStateId, RightRect, nil);
    end
  else
  begin
    DrawButtonFrameEx3(Canvas.Handle, LeftRect, not FOwner.Flat,
      FOwner.ScrollBtnState = pbsLeftBtnDown,
        FOwner.Color, false, AllBorderSides);
    DrawButtonFrameEx3(Canvas.Handle, RightRect, not FOwner.Flat,
      FOwner.ScrollBtnState = pbsRightBtnDown,
        FOwner.Color, false, AllBorderSides);
    case FOwner.TabPosition of
      etpTop,
        etpBottom:
        begin
          LMDDrawArrow(Canvas, eadLeft, LeftRect, clBtnText, csl);
          LMDDrawArrow(Canvas, eadRight, RightRect, clBtnText, csr);
        end;
      etpLeft:
        begin
          LMDDrawArrow(Canvas, eadDown, LeftRect, clBtnText, csl);
          LMDDrawArrow(Canvas, eadUp, RightRect, clBtnText, csr);
        end;
      etpRight:
        begin
          LMDDrawArrow(Canvas, eadUp, LeftRect, clBtnText, csl);
          LMDDrawArrow(Canvas, eadDown, RightRect, clBtnText, csr);
        end;
    end;
  end;
end;

function TElTab.GetRowMargin: Integer;
begin
  Result := 0;
end;

function TElStdTab.GetOuterMargin: Integer;
begin
  Result := 2;
end;

function TElStdTab.CanDrawTab(ActiveDraw: boolean): Boolean;
begin
  result := ActiveDraw;
end;

function TElStdTab.GetAscend: Integer;
begin
  Result := 2;
end;

procedure TElStdTab.AdjustDrawingSize(Active: boolean; var R: TRect);
var
  FPageControl: TElPageControl;
begin
  if Active then
  begin
    FPageControl := FOwner;
    case FPageControl.TabPosition of
      etpLeft:
        begin
          //inc(R.Right);
          dec(R.Left, GetAscend);
          inc(R.Bottom, GetOuterMargin);
          dec(R.Top, GetOuterMargin);
        end;
      etpTop:
        begin
          //inc(R.Top);
          dec(R.Top, GetAscend);
          dec(R.Left, GetOuterMargin);
          inc(R.Right, GetOuterMargin);
        end;
      etpRight:
        begin
          //dec(R.Left);
          inc(R.Right, GetAscend);
          inc(R.Bottom, GetOuterMargin);
          dec(R.Top, GetOuterMargin);
        end;
      etpBottom:
        begin
          dec(R.Top);
          inc(R.Bottom, GetAscend);
          dec(R.Left, GetOuterMargin);
          inc(R.Right, GetOuterMargin);
        end;
    end;
  end;
end;

procedure TElStdTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
  TElTabSheet);
const
  ROUND_CORNER_SIZE = 2;
var
//  iPartId: Integer;
//  iStateId: Integer;
  LDetails: TThemedElementDetails;
  LThemeMode: TLMDThemeMode;
  LIsThemed: boolean;
  {$IFDEF LMDCOMP16}
  LTabState: TThemedTab;
  {$ENDIF}
begin
  LIsThemed := IsThemed;
  if LIsThemed then
    LThemeMode := FOwner.UseThemeMode
  else
    LThemeMode := ttmNone;
  if LIsThemed {and (TabPosition = etpTop)} then
  begin
    {$IFDEF LMDCOMP16}
    if StyleServices.Enabled then
    begin
      lTabState := ttTabDontCare;
      with FOwner do
      case TabPosition of
        etpTop:
          begin
            if TabSheet = FOwner.FActivePage then
              lTabState := ttTabItemSelected
            else if (TabSheet = FTrackTab) and MouseInClient then
              lTabState := ttTabItemHot
            else
              lTabState := ttTabItemNormal;
          end;
        etpLeft:
          begin
            if TabSheet = FOwner.FActivePage then
              lTabState := ttTabItemLeftEdgeSelected
            else if (TabSheet = FTrackTab) and MouseInClient then
              lTabState := ttTabItemLeftEdgeHot
            else
              lTabState := ttTabItemLeftEdgeNormal;
          end;
        etpBottom:
          begin
            if TabSheet = FOwner.FActivePage then
              lTabState := ttTabItemBothEdgeSelected
            else if (TabSheet = FTrackTab) and MouseInClient then
              lTabState := ttTabItemBothEdgeHot
            else
              lTabState := ttTabItemBothEdgeNormal;
          end;
        etpRight:
          begin
            if TabSheet = FOwner.FActivePage then
              lTabState := ttTabItemRightEdgeSelected
            else if (TabSheet = FTrackTab) and MouseInClient then
              lTabState := ttTabItemRightEdgeHot
            else
              lTabState := ttTabItemRightEdgeNormal;
          end;
      end;
      lDetails := StyleServices.GetElementDetails(lTabState);
    end
    else
    {$ENDIF}
    begin
    LDetails.Part := TABP_TOPTABITEM;
    if (TabSheet = FOwner.FActivePage) and (TabSheet.TabEnabled) then
    begin
      LDetails.State := TIS_SELECTED;
    end
    else
    begin
      if TabSheet = FOwner.FTrackTab then
      begin
        LDetails.State := TIS_HOT;
      end
      else
      begin
        if TabSheet = FOwner.FDownTab then
        begin
          LDetails.State := TIS_FOCUSED;
        end
        else
        begin
          LDetails.State := TIS_NORMAL;
        end;
      end;
    end;
    if not TabSheet.Enabled then
    begin
      LDetails.State := TIS_DISABLED;
    end;
    case FOwner.TabPosition of
      etpLeft:
        inc(R.Right, 1);
      etpRight:
        dec(R.Left, 1);
      etpTop:
        inc(R.Bottom, 1);
      etpBottom:
        dec(R.Bottom, 1);
    end;
      LDetails.Element := teTab;
    end;

    DrawXPTabEdges(LThemeMode, LDetails, Canvas, R, TabPosition);

    case FOwner.TabPosition of
      etpLeft:
        dec(R.Right, 1);
      etpRight:
        inc(R.Left, 1);
      etpTop:
        dec(R.Bottom, 1);
      etpBottom:
        inc(R.Bottom, 1);
    end;
  end
  else
  begin
    Canvas.Pen.Color := clBtnHighlight;
    case FOwner.TabPosition of
      etpLeft:
        with Canvas do
        begin
          MoveTo(r.right - 1, r.top);
          LineTo(r.left + ROUND_CORNER_SIZE, r.top);
          LineTo(r.left, r.top + ROUND_CORNER_SIZE);
          LineTo(r.left, r.bottom - ROUND_CORNER_SIZE);

          (* shadow *)
          if FOwner.Flat then
            Pen.Color := clBtnShadow
          else
            Pen.Color := cl3DDkShadow;
          MoveTo(r.left + 1, r.bottom - 2);
          LineTo(r.left + ROUND_CORNER_SIZE, r.bottom - 1);
          LineTo(r.right - 1, r.bottom - 1);

          (* shade *)
          if not FOwner.Flat then
          begin
            Pen.Color := clBtnShadow;
            MoveTo(r.left + ROUND_CORNER_SIZE, r.bottom - 2);
            LineTo(r.right - 1, r.bottom - 2);
          end;
          if TabSheet = FOwner.FActivePage then
            if FOwner.ShowBorder then
            begin
              if not FOwner.Flat then
              begin
                Pixels[R.Right - 1, R.Bottom - 2] := clBtnShadow;
                Pixels[R.Right - 1, R.Bottom - 1] := cl3DDkShadow;
              end
              else
              begin
                Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
              end;
              end;
        end;
      etpTop:
        with Canvas do
        begin
          (* highlight *)
          Pen.Color := clBtnHighlight;
          MoveTo(r.left, r.bottom - 1);
          LineTo(r.left, r.top + ROUND_CORNER_SIZE);
          LineTo(r.left + ROUND_CORNER_SIZE, r.top);
          LineTo(r.right - ROUND_CORNER_SIZE, r.top);

          (* shadow *)
          if FOwner.Flat then
            Pen.Color := clBtnShadow
          else
            Pen.Color := cl3DDkShadow;
          // SelectObject(dc, hbPen);
          MoveTo(R.right - 2, R.Top + 1);
          LineTo(R.right - 1, r.top + ROUND_CORNER_SIZE);
          LineTo(R.right - 1, r.bottom);

          (* shade *)
          if not FOwner.Flat then
          begin
            Pen.Color := clBtnShadow;
            MoveTo(r.right - 2, r.top + ROUND_CORNER_SIZE);
            LineTo(r.right - 2, r.bottom - 1);
          end;
        end;
      etpRight:
        with Canvas do
        begin
          MoveTo(r.left + 1, r.top);
          LineTo(r.right - ROUND_CORNER_SIZE - 1, r.top);
          LineTo(r.right - 1, r.top + ROUND_CORNER_SIZE);

          (* shadow *)
          if FOwner.Flat then
            Pen.Color := clBtnShadow
          else
            Pen.Color := cl3DDkShadow;
          LineTo(r.right - 1, r.bottom - ROUND_CORNER_SIZE - 1);
          LineTo(r.right - ROUND_CORNER_SIZE - 1, r.bottom - 1);
          LineTo(r.left, r.bottom - 1);

          (* shade *)
          if not FOwner.Flat then
          begin
            Pen.Color := clBtnShadow;
            MoveTo(r.right - 2, r.top + 2);
            LineTo(r.right - 2, r.bottom - 2);
            MoveTo(r.right - 3, r.bottom - 2);
            LineTo(r.left - 1, r.bottom - 2);
          end;
        end;
      etpBottom:
        with Canvas do
        begin
          (* highlight *)

          MoveTo(r.left, r.top + 2);
          LineTo(r.left, r.bottom - ROUND_CORNER_SIZE - 1);
          LineTo(r.left + ROUND_CORNER_SIZE, r.bottom - 1);

          (* shadow *)
          if FOwner.Flat then
            Pen.Color := clBtnShadow
          else
            Pen.Color := cl3DDkShadow;
          LineTo(r.right - ROUND_CORNER_SIZE - 1, r.bottom - 1);
          LineTo(r.right, r.bottom - ROUND_CORNER_SIZE - 2);
          MoveTo(r.right - 1, r.bottom - ROUND_CORNER_SIZE - 1);
          LineTo(r.right - 1, r.top + 1);

          (* shade *)
          if not FOwner.Flat then
          begin
            Pen.Color := clBtnShadow;
            MoveTo(r.left + ROUND_CORNER_SIZE, r.bottom - 2);
            LineTo(r.right - 2, r.bottom - 2);
            MoveTo(r.right - 2, r.bottom - ROUND_CORNER_SIZE - 1);
            LineTo(r.right - 2, r.top);
          end;
        end;
    end;
    InflateRect(r, -1, -1);
  end;
end;

procedure TElStdTab.AdjustTabSize(var Size: TSize);
var
  R,
    R1: TRect;
  LCx, LCy: Integer;
  LThemeMode: TLMDThemeMode;
  LIsThemed: boolean;
begin
  LIsThemed := IsThemed;
  if LIsThemed then
    LThemeMode := FOwner.UseThemeMode
  else
    LThemeMode := ttmNone;
  LCx := Size.cx;
  LCy := Size.cy;
  if LIsThemed then
  begin

    R := Rect(0, 0, Size.cx, Size.cy);
    R1 := LMDThemeServices.ContentRect(LThemeMode, FOwner.Canvas.Handle, ThemeServices.GetElementDetails(ttTopTabItemSelected), R);
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      inc(Lcy, (R1.Left - R.Left) + (R.Right - R1.Right));
      inc(Lcx, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
    end
    else
    begin
      inc(Lcx, (R1.Left - R.Left) + (R.Right - R1.Right));
      inc(Lcy, (R1.Top - R.Top) + (R.Bottom - R1.Bottom));
    end;
  end
  else
  begin
    inc(Lcx, 2);
    inc(Lcy, 2);
  end;
  Size.cx := LCx;
  Size.cy := LCy;
end;

procedure TElStdTab.DrawTabLine(Canvas: TCanvas; R: TRect);
var
  ASheet: TElTabSheet;
  R1: TRect;
  LThemeMode: TLMDThemeMode;
  LIsThemed: boolean;
begin
  LIsThemed := IsThemed;
  if LIsThemed then
    LThemeMode := FOwner.UseThemeMode
  else
    LThemeMode := ttmNone;
  ASheet := FOwner.ActivePage;

  if LIsThemed then
  begin
    case FOwner.TabPosition of
      etpTop:
        begin
          R.Top := R.Bottom - 1;
          inc(R.Bottom, 2);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            // InflateRect(R1, 1, 0);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpBottom:
        begin
//          if FOwner.Flat then
//            R.Bottom := R.Top + 1
//          else
          begin
            R.Bottom := R.Top + 2;
            dec(R.Top);
          end;
          dec(R.Top);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            // InflateRect(R1, 1, 0);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpLeft:
        begin
          R.Left := R.Right - 1;
          inc(R.Right);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
//            InflateRect(R1, 0, 1);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpRight:
        begin
//          if FOwner.Flat then
//            R.Right := R.Left + 1
//          else
            R.Right := R.Left + 2;
          dec(R.Left, 1);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
//            InflateRect(R1, 0, 1);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
    end;
    LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, ttPane, R, nil);
//    DrawThemeBackground(TabTheme, Canvas.Handle, TABP_PANE, 0, R, nil);
    exit;
  end;
  with Canvas do
    case FOwner.TabPosition of
      etpTop:
        begin
          Pen.Color := clBtnHighlight;
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Bottom - 1);
            LineTo(R.Right, R.Bottom - 1);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Bottom - 1);
              LineTo(ASheet.FRect.Left  - 1, R.Bottom - 1);
            end;
            if ASheet.FRect.Right + 2 < R.Right then
            begin
              MoveTo(ASheet.FRect.Right  + 1, R.Bottom - 1);
              LineTo(R.Right, R.Bottom - 1);
            end;
          end;
        end;
      etpBottom:
        begin
          R.Bottom := R.Top + 2;
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            if FOwner.Flat then
              DrawEdge(Handle, R, BDR_RAISEDINNER, BF_BOTTOM)
            else
              DrawEdge(Handle, R, BDR_RAISED, BF_BOTTOM);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              R1 := Rect(R.Left, R.Top, ASheet.FRect.Left - 1, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_BOTTOM)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_BOTTOM);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              R1 := Rect(ASheet.FRect.Right - 1, R.Top, R.Right, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_BOTTOM)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_BOTTOM);
            end;
          end;

          if FOwner.ShowBorder then
          begin
            Pixels[R.Left, R.Bottom - 1] := clBtnHighlight;
            Pixels[R.Left, R.Bottom - 2] := clBtnHighlight;
            if FOwner.Flat then
              Pixels[R.Right - 1, R.Bottom - 2] := clBtnShadow
            else
              Pixels[R.Right - 1, R.Bottom - 2] := cl3DDkShadow;
            end;
        end;
      etpLeft:
        begin
          Pen.Color := clBtnHighlight;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Right - 1, R.Top);
            LineTo(R.Right - 1, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Right - 1, R.Top);
              LineTo(R.Right - 1, ASheet.FRect.Top - 1);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Right - 1, ASheet.FRect.Bottom);
              LineTo(R.Right - 1, R.Bottom);
            end;
          end;
          if FOwner.ShowBorder then
          begin
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
            end;
          inc(R.Bottom);
        end;
      etpRight:
        begin
          R.Right := R.Left + 2;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            if FOwner.Flat then
              DrawEdge(Handle, R, BDR_RAISEDINNER, BF_RIGHT)
            else
              DrawEdge(Handle, R, BDR_RAISED, BF_RIGHT);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              R1 := Rect(R.Left, R.Top, R.Right, ASheet.FRect.Top);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_RIGHT)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_RIGHT);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              R1 := Rect(R.Left, ASheet.FRect.Bottom - 1, R.Right, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_RIGHT)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_RIGHT);
            end;
          end;

          if FOwner.ShowBorder then
          begin
            Pixels[R.Right - 2, R.Top] := clBtnHighlight;
            Pixels[R.Right - 1, R.Top] := clBtnHighlight;
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 2, R.Bottom] := cl3DDkShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 2, R.Bottom] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
            end;
          inc(R.Bottom);
        end;
    end;
end;

procedure TElStdTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet:
  TElTabSheet);
begin
  inherited;
  if TabSheet = FOwner.FActivePage then
    case FOwner.TabPosition of
      etpTop:
        begin
          if After then
          begin
            dec(R.Right);
            dec(R.Bottom);
          end
          else
          begin
            inc(R.Right);
            inc(R.Bottom);
          end;
        end;
      etpBottom:
        begin
          if After then
          begin
            inc(R.Top);
          //inc(R.Bottom);
          //dec(R.Right);
          end
          else
          begin
            dec(R.Top);
          //dec(R.Bottom);
          // inc(R.Right);
          end;
        end;
      etpLeft:
        begin
          if After then
          begin
          //dec(R.Left);
            dec(R.Right);
          //dec(R.Bottom);
          end
          else
          begin
          //inc(R.Left);
            inc(R.Right);
          //inc(R.Bottom);
          end;
        end;
      etpRight:
        begin
          if After then
          begin
            inc(R.Left, 2);
          //dec(R.Right);
          //dec(R.Bottom);
          end
          else
            dec(R.Left, 2);
          //inc(R.Right);
          //inc(R.Bottom);
        end;
    end
  else
  begin
    case FOwner.TabPosition of
      etpBottom:
        begin
        end;
      etpRight:
        begin
        end;
    end;
  end;
end;

procedure TElStdTab.FillTab(Canvas: TCanvas; Rect: TRect; TabSheet:
  TElTabSheet);

//var
//  ACtl: TWinControl;
//  BgRect: TRect;

begin
  AdjustFillSize(false, Rect, TabSheet);

  if (FOwner.FImgForm = nil) or (csDesigning in
    FOwner.ComponentState) then

  begin
    Canvas.Brush.Style := bsSolid;
    if TabSheet.UseTabColor then
      Canvas.Brush.Color := TabSheet.TabColor
    else
      if TabSheet = FOwner.FActivePage then
      Canvas.Brush.Color := FOwner.FActiveTabColor
    else
      Canvas.Brush.Color := FOwner.FInactiveTabColor;
    Canvas.FillRect(Rect);

  end;
//  else
//   if TabSheet = FOwner.FActivePage then
//  begin
//    if (FOwner.FImgForm.Control <> FOwner) then
//    begin
//      ACtl := FOwner.FImgForm.GetRealControl;
//
//      BgRect.Left := FOwner.Left;
//      BgRect.Top := FOwner.Top;
//
//      BgRect.TopLeft :=
//        FOwner.Parent.ClientToScreen(BgRect.TopLeft);
//      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
//
//      FOwner.FImgForm.PaintBkgnd(Canvas.Handle, Rect,
//        BgRect.TopLeft, false);
//    end;
//
//  end;
  AdjustFillSize(true, Rect, TabSheet);
end;

function TElBtnTab.GetInnerMargin: Integer;
begin
  Result := Margin;
end;

procedure TElBtnTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
  TElTabSheet);
var
  b: boolean;
//  iPartId: Integer;
//  iStateId: Integer;
  LDetails: TThemedButton;
begin

  if IsThemed then
  begin
//    iPartId := BP_PUSHBUTTON;
    if TabSheet.Enabled then
    begin
      if TabSheet = FOwner.FActivePage then
      begin
        LDetails := tbPushButtonPressed;
      end
      else
      begin
        if TabSheet = FOwner.FTrackTab then
        begin
          LDetails := tbPushButtonHot;
//          iStateId := PBS_HOT;
        end
        else
        begin
          if TabSheet = FOwner.FDownTab then
          begin
            LDetails := tbPushButtonPressed;
//            iStateId := PBS_PRESSED;
          end
          else
          begin
            LDetails := tbPushButtonNormal;
//            iStateId := PBS_NORMAL;
          end;
        end;
      end;
    end
    else
    begin
      LDetails := tbPushButtonDisabled;
      //iStateId := PBS_DISABLED;
    end;

    LMDThemeServices.DrawElement(FOwner.UseThemeMode, Canvas.Handle, LDetails, R, nil);
    R := LMDThemeServices.ContentRect(FOwner.UseThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetails), R);
    end
  else
  begin
    b := (TabSheet = FOwner.ActivePage) or
      ((TabSheet = FOwner.FDownTab) and
      (TabSheet = FOwner.FTrackTab));
    DrawButtonFrameEx3(Canvas.Handle, R, not FOwner.Flat, b,
      FOwner.ActiveTabColor, FOwner.Flat, AllBorderSides);
    InflateRect(R, -2, -2);
    end;
end;

procedure TElBtnTab.DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my:
  integer);
begin
  case FOwner.TabPosition of
    etpTop,
      etpBottom:
      begin
        inc(cx, GetInnerMargin);
      end;
    etpLeft:
      begin
        inc(cy, GetInnerMargin);
      end;
    etpRight:
      begin
        inc(cy, GetInnerMargin);
      end;
  end;
end;

procedure TElBtnTab.AdjustTabSize(var Size: TSize);
var
  R,
    R1: TRect;
//  pid,
//    sid: integer;
begin
  if IsThemed then
  begin
//    pid := BP_PUSHBUTTON;
//    sid := PBS_HOT;//here
    R := Rect(0, 0, Size.cx, Size.cy);
    R1 := LMDThemeServices.ContentRect(FOwner.UseThemeMode, FOwner.Canvas.Handle, ThemeServices.GetElementDetails(tbPushButtonHot), R);
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      Size.cy := Size.cy + (R1.Left - R.Left) + (R.Right - R1.Right);
      Size.cx := Size.cx + (R1.Top - R.Top) + (R.Bottom - R1.Bottom);
    end
    else
    begin
      Size.cx := Size.cx + (R1.Left - R.Left) + (R.Right - R1.Right);
      Size.cy := Size.cy + (R1.Top - R.Top) + (R.Bottom - R1.Bottom);
    end;
  end
  else
  begin
    Size.cx := Size.cx + 4;
    Size.cy := Size.cy + 4;
  end;
end;

function TElBtnTab.GetRowMargin: Integer;
begin
  Result := 2;
end;

function TElFlatBtnTab.GetInnerMargin: Integer;
begin
  Result := Margin * 2 + 2;
end;

procedure TElFlatBtnTab.DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx,
  my: integer);
begin
  if not IsThemed then
  begin
    case FOwner.TabPosition of
      etpTop,
        etpBottom:
        begin
          inc(cx, (GetInnerMargin - 2) div 2);
          Canvas.Pen.Color := clBtnShadow;
          Canvas.MoveTo(cx - 1, cy);
          Canvas.LineTo(cx - 1, cy + my);
          Canvas.Pen.Color := clBtnHighlight;
          Canvas.MoveTo(cx, cy);
          Canvas.LineTo(cx, cy + my);
          inc(cx, (GetInnerMargin - 2) div 2);
        end;
      etpLeft:
        begin
          dec(cy, (GetInnerMargin - 2) div 2);

          Canvas.Pen.Color := clBtnHighlight;
          Canvas.MoveTo(cx, cy + 1);
          Canvas.LineTo(cx + mx, cy + 1);
          Canvas.Pen.Color := clBtnShadow;
          Canvas.MoveTo(cx, cy);
          Canvas.LineTo(cx + mx, cy);
          dec(cy, (GetInnerMargin - 2) div 2);
        end;
      etpRight:
        begin
          inc(cy, (GetInnerMargin - 2) div 2);

          Canvas.Pen.Color := clBtnShadow;
          Canvas.MoveTo(cx, cy - 1);
          Canvas.LineTo(cx + mx, cy - 1);
          Canvas.Pen.Color := clBtnHighlight;
          Canvas.MoveTo(cx, cy);
          Canvas.LineTo(cx + mx, cy);

          inc(cy, (GetInnerMargin - 2) div 2);
        end;
    end;
  end
  else
    inherited;
  end;

procedure TElFlatBtnTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet
  : TElTabSheet);
var
//  iPartId: Integer;
//  iStateId: Integer;
  LDetail: TThemedButton;
  LThemeMode: TLMDThemeMode;
  LIsThemed: boolean;
begin
  LIsThemed := IsThemed;
  if LIsThemed then
    LThemeMode := FOwner.UseThemeMode
  else
    LThemeMode := ttmNone;
  if LIsThemed then
  begin
//    iPartId := BP_PUSHBUTTON;
    if TabSheet.Enabled then
    begin
      if TabSheet = FOwner.FActivePage then
      begin
        LDetail := tbPushButtonPressed;
//        iStateId := PBS_PRESSED;
      end
      else
      begin
        if TabSheet = FOwner.FTrackTab then
        begin
          LDetail := tbPushButtonHot;
//          iStateId := PBS_HOT;
        end
        else
        begin
          if TabSheet = FOwner.FDownTab then
          begin
//            iStateId := PBS_PRESSED;
            LDetail := tbPushButtonPressed;
          end
          else
          begin
//            iStateId := PBS_NORMAL;
            LDetail := tbPushButtonNormal;
          end;
        end;
      end;
    end
    else
    begin
      // iStateId := PBS_DISABLED;
      LDetail := tbPushButtonDisabled;
    end;
    if LDetail <> tbPushButtonNormal then
      LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail, R, nil);
    R := LMDThemeServices.ContentRect(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail), R);
  end
  else
  begin
    if TabSheet = FOwner.FActivePage then
    begin
      DrawButtonFrameEx3(Canvas.Handle, R, false, true,
        FOwner.ActiveTabColor, FOwner.Flat, AllBorderSides);
    end
    else
      if (TabSheet = FOwner.FDownTab) and
      (TabSheet = FOwner.FTrackTab) then
    begin
      DrawButtonFrameEx3(Canvas.Handle, R, false, true,
        FOwner.ActiveTabColor, FOwner.Flat, AllBorderSides);
    end
    else
      if TabSheet = FOwner.FTrackTab then
    begin
      DrawButtonFrameEx3(Canvas.Handle, R, false, false,
        FOwner.InactiveTabColor, FOwner.Flat, AllBorderSides);
    end;
    InflateRect(R, -2, -2);
  end;
end;

procedure TElFlatBtnTab.AdjustTabSize(var Size: TSize);
var
  R,
    R1: TRect;
//  pid,
//    sid: integer;
//  LDetail: TThemedButton;
begin
  if IsThemed then
  begin
//    pid := BP_PUSHBUTTON;
//    sid := PBS_HOT;
    R := Rect(0, 0, Size.cx, Size.cy);
    R1 := LMDThemeServices.ContentRect(FOwner.UseThemeMode, FOwner.Canvas.Handle, ThemeServices.GetElementDetails(tbPushButtonHot), R);
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      Size.cy := Size.cy + (R1.Left - R.Left) + (R.Right - R1.Right);
      Size.cx := Size.cx + (R1.Top - R.Top) + (R.Bottom - R1.Bottom);
    end
    else
    begin
      Size.cx := Size.cx + (R1.Left - R.Left) + (R.Right - R1.Right);
      Size.cy := Size.cy + (R1.Top - R.Top) + (R.Bottom - R1.Bottom);
    end;
  end
  else
  begin
    Size.cx := Size.cx + 4;
    Size.cy := Size.cy + 4;
  end;
end;

procedure TElFlatBtnTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet
  : TElTabSheet);
begin
  if (TabSheet = FOwner.FActivePage) or
    (TabSheet = FOwner.FDownTab) or
    (TabSheet = FOwner.FTrackTab) then
  begin
    if After then
      InflateRect(R, 1, 1)
    else
      InflateRect(R, -1, -1);
  end;
end;

function TElFlatBtnTab.GetRowMargin: Integer;
begin
  Result := 2;
end;

procedure TElNetTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
  TElTabSheet);
var
  iPartId: Integer;
  iStateId: Integer;
  LDetails: TThemedElementDetails;
begin
  if IsThemed {and (TabPosition = etpTop)} then
  begin
    if TabSheet = FOwner.FActivePage then
    begin
      iPartId := TABP_TOPTABITEM;
      iStateId := TIS_SELECTED;
    end
    else
    begin
      iPartId := TABP_TABITEM;
      if TabSheet = FOwner.FTrackTab then
      begin
        iStateId := TIS_HOT;
      end
      else
      begin
        if TabSheet = FOwner.FDownTab then
        begin
          iStateId := TIS_FOCUSED;
          // LDetail := ttTabItemFocused;
        end
        else
        begin
//          LDetail := ttTabItemNormal;
          iStateId := TIS_NORMAL;
        end;
      end;
    end;
    if not TabSheet.Enabled then
    begin
      iStateId := TIS_DISABLED;
    end;
    case FOwner.TabPosition of
      etpLeft:
        inc(R.Right, 1);
      etpRight:
        dec(R.Left, 1);
      etpTop:
        inc(R.Bottom, 1);
      etpBottom:
        dec(R.Bottom, 1);
    end;

    LDetails.Element := teTab;
    LDetails.Part := iPartId;
    LDetails.State := iStateId;
    DrawXPTabEdges(FOwner.UseThemeMode, LDetails, Canvas, R, TabPosition);

//    DrawXPTabEdges(TabTheme, iPartId, iStateId, Canvas, R, TabPosition);

//    DrawThemeBackground(TabTheme, Canvas.Handle, iPartId, iStateId, R, nil);
//    GetThemeBackgroundContentRect(TabTheme, Canvas.Handle, iPartId, iStateId, R, {$ifndef LMDDISABLE_LMDTHEMES}R{$else}@R{$endif});
    case FOwner.TabPosition of
      etpLeft:
        dec(R.Right, 1);
      etpRight:
        inc(R.Left, 1);
      etpTop:
        dec(R.Bottom, 1);
      etpBottom:
        inc(R.Bottom, 1);
    end;
  end
  else
  begin
    if TabSheet = FOwner.FActivePage then
    begin
      Canvas.Pen.Color := IncColor(clBtnHighlight, 20, 20, 20);

      case FOwner.TabPosition of
        etpLeft:
          with Canvas do
          begin
            MoveTo(r.right - 1, r.top);
            LineTo(r.left, r.top);
            LineTo(r.left, r.bottom + 1);

            (* shadow *)
            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;
            MoveTo(r.left + 1, r.bottom);
            LineTo(r.right, r.bottom);
          end;
        etpTop:
          with Canvas do
          begin
            (* highlight *)
            MoveTo(r.left, r.bottom - 1);
            LineTo(r.left, r.top);
            LineTo(r.right, r.top);

            (* shadow *)
            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;
            MoveTo(r.right - 1, r.top + 1);
            LineTo(r.right - 1, r.bottom - 1);
          end;
        etpRight:
          with Canvas do
          begin
            MoveTo(r.left, r.top);
            LineTo(r.right, r.top);

            (* shadow *)
            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;
            LineTo(r.right, r.bottom + 1);
            MoveTo(r.left, r.bottom);
            LineTo(r.right, r.bottom);
          end;
        etpBottom:
          with Canvas do
          begin
            (* highlight *)

            MoveTo(r.left, r.top);
            LineTo(r.left, r.bottom + 1);

            (* shadow *)
            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;

            MoveTo(r.right, r.top);
            LineTo(r.right, r.bottom);
            LineTo(r.left, r.bottom);
          end;
      end;
    end;
    InflateRect(r, -1, -1);
  end;
end;

procedure TElNetTab.AdjustTabSize(var Size: TSize);
var
  R, R1: TRect;
begin
  if IsThemed then
  begin
//    pid := TABP_TOPTABITEM;
//    sid := TIS_SELECTED;
    R := Rect(0, 0, Size.cx, Size.cy);
    R1 := LMDThemeServices.ContentRect(FOwner.UseThemeMode, FOwner.Canvas.Handle, ThemeServices.GetElementDetails(ttTopTabItemSelected), R);
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      Size.cy := Size.cy + (R1.Left - R.Left) + (R.Right - R1.Right);
      Size.cx := Size.cx + (R1.Top - R.Top) + (R.Bottom - R1.Bottom);
    end
    else
    begin
      Size.cx := Size.cx + (R1.Left - R.Left) + (R.Right - R1.Right);
      Size.cy := Size.cy + (R1.Top - R.Top) + (R.Bottom - R1.Bottom);
    end;
  end
  else
  begin
    Size.cx := Size.cx + 4;
    Size.cy := Size.cy + 4;
  end;
end;

function TElNetTab.GetInnerMargin: Integer;
begin
  Result := 3;
end;

procedure TElNetTab.DrawSpace(Canvas: TCanvas; var cx, cy: integer; mx, my:
  integer);
begin
  if IsThemed and (TabPosition = etpTop) then
  begin
    inherited;
  end
  else
  begin
    case FOwner.TabPosition of
      etpTop:
        begin
          inc(cx, GetInnerMargin div 2);
          Canvas.Pen.Color := clBtnFace;
          Canvas.MoveTo(cx, cy);
          Canvas.LineTo(cx, cy + my - GetInnerMargin - 1);
          inc(cx, GetInnerMargin div 2);
        end;
      etpBottom:
        begin
          inc(cx, GetInnerMargin div 2);
          Canvas.Pen.Color := clBtnFace;
          Canvas.MoveTo(cx, cy + GetInnerMargin);
          Canvas.LineTo(cx, cy + my - 1);
          inc(cx, GetInnerMargin div 2);
        end;
      etpLeft:
        begin
          dec(cy, GetInnerMargin div 2);
          Canvas.Pen.Color := clBtnFace;
          Canvas.MoveTo(cx, cy);
          Canvas.LineTo(cx + mx - GetInnerMargin - 1, cy);
          dec(cy, GetInnerMargin div 2);
        end;
      etpRight:
        begin
          inc(cy, GetInnerMargin div 2);
          Canvas.Pen.Color := clBtnFace;
          Canvas.MoveTo(cx + GetInnerMargin, cy);
          Canvas.LineTo(cx + mx, cy);
          inc(cy, GetInnerMargin div 2);
        end;
    end;
  end;
end;

function TElNetTab.CanDrawTab(ActiveDraw: boolean): Boolean;
begin
  result := ActiveDraw;
end;

procedure TElNetTab.AdjustDrawingSize(Active: boolean; var R: TRect);
var
  FPageControl: TElPageControl;
begin
  if Active then
  begin
    FPageControl := FOwner;
    case FPageControl.TabPosition of
      etpLeft:
        begin
          inc(R.Bottom);
          dec(R.Top);
        end;
      etpTop:
        begin
          dec(R.Left);
          inc(R.Right);
        end;
      etpRight:
        begin
          inc(R.Bottom);
          dec(R.Top);
        end;
      etpBottom:
        begin
          dec(R.Left);
          inc(R.Right);
        end;
    end;
  end;
end;

function TElNetTab.GetOuterMargin: Integer;
begin
  Result := 4;
end;

procedure TElNetTab.DrawTabLine(Canvas: TCanvas; R: TRect);
var
  ASheet: TElTabSheet;
  R1: TRect;
begin
  ASheet := FOwner.ActivePage;

  (*
  if IsThemeApplied then
  begin
    case FOwner.TabPosition of
      etpTop:
        begin
          R.Top := R.Bottom - 1;
          inc(R.Bottom, 2);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            with R1 do
              ExcludeCliprect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpBottom:
        begin
          R.Bottom := R.Top + 1;
          dec(R.Top);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            with R1 do
              ExcludeCliprect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpLeft:
        begin
          R.Left := R.Right - 2;
          //inc(R.Right);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            with R1 do
              ExcludeCliprect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
      etpRight:
        begin
          R.Right := R.Left + 2;
          dec(R.Left, 1);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            with R1 do
              ExcludeCliprect(Canvas.Handle, Left, Top, Right, Bottom);
          end;
        end;
    end;
    DrawThemeBackground(TabTheme, Canvas.Handle, TABP_PANE, 0, R, nil);
    exit;
  end;
  *)

  if IsThemed then
  begin
    case FOwner.TabPosition of
      etpTop:
        begin
          R.Top := R.Bottom - 1;
          inc(R.Bottom, 2);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            // InflateRect(R1, 1, 0);

            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
            end;
        end;
      etpBottom:
        begin
          if FOwner.Flat then
            R.Bottom := R.Top + 1
          else
            R.Bottom := R.Top + 2;
          dec(R.Top);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            // InflateRect(R1, 1, 0);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
            end;
        end;
      etpLeft:
        begin
          R.Left := R.Right - 2;
          //inc(R.Right);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
//            InflateRect(R1, 0, 1);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
            end;
        end;
      etpRight:
        begin
          if FOwner.Flat then
            R.Right := R.Left + 1
          else
            R.Right := R.Left + 2;
          dec(R.Left, 1);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
 //           InflateRect(R1, 0, 1);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
            end;
        end;
    end;
    LMDThemeServices.DrawElement(FOwner.UseThemeMode, Canvas.Handle, ttPane, R, nil);
//    DrawThemeBackground(TabTheme, Canvas.Handle, TABP_PANE, 0, R, nil);
    exit;
  end;
  ASheet := FOwner.ActivePage;
  with Canvas do
    case FOwner.TabPosition of
      etpTop:
        begin
          Pen.Color := clBtnHighlight;
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Bottom - 1);
            LineTo(R.Right, R.Bottom - 1);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Bottom - 1);
              LineTo(ASheet.FRect.Left, R.Bottom - 1);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              MoveTo(ASheet.FRect.Right, R.Bottom - 1);
              LineTo(R.Right, R.Bottom - 1);
            end;
          end;
        end;
      etpBottom:
        begin
          if not FOwner.Flat then
            Pen.Color := cl3DDkShadow
          else
            Pen.Color := clBtnShadow;
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Top);
            LineTo(R.Right, R.Top);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Top);
              LineTo(ASheet.FRect.Left, R.Top);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              MoveTo(ASheet.FRect.Right + 1, R.Top);
              LineTo(R.Right, R.Top);
            end;
          end;
        end;
      etpLeft:
        begin
          Pen.Color := clBtnHighlight;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Right - 1, R.Top);
            LineTo(R.Right - 1, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Right - 1, R.Top);
              LineTo(R.Right - 1, ASheet.FRect.Top);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Right - 1, ASheet.FRect.Bottom);
              LineTo(R.Right - 1, R.Bottom);
            end;
          end;
          if FOwner.ShowBorder then
          begin
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
            end;
          inc(R.Bottom);
        end;
      etpRight:
        begin
          if not FOwner.Flat then
            Pen.Color := cl3DDkShadow
          else
            Pen.Color := clBtnShadow;

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Top);
            LineTo(R.Left, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Left, R.Top);
              LineTo(R.Left, ASheet.FRect.Top);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Left, ASheet.FRect.Bottom + 1);
              LineTo(R.Left, R.Bottom);
            end;
          end;

        (*
        if FOwner.ShowBorder then
        begin
          Pixels[R.Right - 2, R.Top] := clBtnHighlight;
          Pixels[R.Right - 1, R.Top] := clBtnHighlight;
          if not FOwner.Flat then
          begin
            Pixels[R.Right - 2, R.Bottom] := cl3DDkShadow;
            Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
          end
          else
          begin
            Pixels[R.Right - 2, R.Bottom] := clBtnShadow;
            Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
          end;
        end;
        inc(R.Bottom);
        *)
        end;
    end;
end;

(*
begin
  with Canvas do
  case FOwner.TabPosition of
    etpTop:
      begin
        Pen.Color := clBtnHighlight;
        MoveTo(R.Left, R.Bottom - 1);
        LineTo(R.Right, R.Bottom - 1);
      end;
    etpBottom:
      begin
        if not FOwner.Flat then
          Pen.Color := cl3DDkShadow
        else
          Pen.Color := clBtnShadow;
        MoveTo(R.Left, R.Top);
        LineTo(R.Right, R.Top);
      end;
    etpLeft:
      begin
        Pen.Color := clBtnHighlight;
        Dec(R.Bottom);
        MoveTo(R.Right - 1, R.Top);
        LineTo(R.Right - 1, R.Bottom);
        if FOwner.ShowBorder then
        begin
          if not FOwner.Flat then
          begin
            Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
            Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
          end
          else
          begin
            Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
          end;
        end;
        inc(R.Bottom);
      end;
    etpRight:
      begin
        if not FOwner.Flat then
          Pen.Color := cl3DDkShadow
        else
          Pen.Color := clBtnShadow;
        MoveTo(R.Left, R.Top);
        LineTo(R.Left, R.Bottom);
      end;
  end;
end;
*)

function TElNetTab.GetAscend: Integer;
begin
  Result := 2;
end;

procedure TElNetTab.FillSpace(Canvas: TCanvas; Rect: TRect);
begin
  if IsThemed {and (TabPosition = etpTop)} then
  begin
    inherited;
  end
  else
  begin
    Canvas.Brush.Color := FOwner.TabBkColorNetStyle;
    Canvas.FillRect(Rect);
  end;
end;

procedure TElNetTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet:
  TElTabSheet);
begin
  inherited;
  if TabSheet = FOwner.FActivePage then
    case FOwner.TabPosition of
      etpTop:
        begin
          if After then
          begin
            dec(R.Right);
            dec(R.Bottom);
          end
          else
          begin
            inc(R.Right);
            inc(R.Bottom);
          end;
        end;
      etpBottom:
        begin
          if After then
          begin
            inc(R.Top, 2);
            dec(R.Bottom);
            dec(R.Right);
          end
          else
          begin
            dec(R.Top, 2);
            inc(R.Bottom);
            inc(R.Right);
          end;
        end;
      etpLeft:
        begin
          if After then
          begin
            dec(R.Right, 2);
            dec(R.Bottom);
          end
          else
          begin
            inc(R.Right, 2);
            inc(R.Bottom);
          end;
        end;
      etpRight:
        begin
          if After then
          begin
            inc(R.Left, 2);
            dec(R.Right);
            dec(R.Bottom);
          end
          else
            dec(R.Left, 2);
          inc(R.Right);
          inc(R.Bottom);
        end;
    end;
end;

procedure TElNetTab.FillTab(Canvas: TCanvas; Rect: TRect; TabSheet:
  TElTabSheet);
begin
  if TabSheet = FOwner.FActivePage then inherited;
end;

procedure TElNetTab.DrawButtons(Canvas: TCanvas; LeftRect, RightRect: TRect;
  CSL, CSR: boolean);
var
  PageControl: TElPageControl;
  ColorRight,
    ColorLeft: TColor;
begin
  if IsThemed then
  begin
    inherited;
  end
  else
  begin
    PageControl := FOwner;

    if CSL and (PageControl.FScrollBtnState in [pbsLeftBtnOver, pbsLeftBtnDown])
      then
      DrawButtonFrameEx3(Canvas.Handle, LeftRect, false,
        PageControl.FScrollBtnState = pbsLeftBtnDown, PageControl.Color,
          PageControl.Flat, AllBorderSides);
    if CSR and (PageControl.FScrollBtnState in [pbsRightBtnOver,
      pbsRightBtnDown]) then
      DrawButtonFrameEx3(Canvas.Handle, RightRect, false,
        PageControl.FScrollBtnState = pbsRightBtnDown, PageControl.Color,
          PageControl.Flat, AllBorderSides);

    if PageControl.FScrollBtnState = pbsLeftBtnDown then
      ColorLeft := clBtnHighlight
    else
      ColorLeft := cl3DDkShadow;
    if PageControl.FScrollBtnState = pbsRightBtnDown then
      ColorRight := clBtnHighlight
    else
      ColorRight := cl3DDkShadow;

    case PageControl.TabPosition of
      etpTop,
        etpBottom:
        begin
          LMDDrawArrow(Canvas, eadLeft, LeftRect, ColorLeft, csl);
          LMDDrawArrow(Canvas, eadRight, RightRect, ColorRight, csr);
        end;
      etpLeft:
        begin
          LMDDrawArrow(Canvas, eadDown, LeftRect, ColorLeft, csl);
          LMDDrawArrow(Canvas, eadUp, RightRect, ColorRight, csr);
        end;
      etpRight:
        begin
          LMDDrawArrow(Canvas, eadUp, LeftRect, ColorLeft, csl);
          LMDDrawArrow(Canvas, eadDown, RightRect, ColorRight, csr);
        end;
    end;
  end;
end;

{
function TElPageControl.GetThemedClassName: TLMDThemedItem;
begin
  Result := tiTab;
end;
}

function TElPageControl.GetThemedElement: TThemedElement;
begin
  Result := teTab;
end;

procedure TElPageControl.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  if FDoStartDrag = 1 then
    Message.Result := 1
  else
  begin
    with Message do
      if CursorWnd = Handle then
      begin
        GetCursorPos(P);
        p := ScreenToClient(p);
        if ShowTabs and (TabFromPoint(p) <> nil) then
        begin
          Windows.SetCursor(Screen.Cursors[TabCursor]);
          Message.Result := 1;
        end
        else
          inherited;
      end
      else
        inherited;
  end;
end;

type THackHintWindow = class(THintWindow) end;

procedure TElPageControl.OnHintTimer(Sender: TObject);
var
  ASheet: TElTabSheet;
  R: TRect;
  P: TPoint;
  mx, my: integer;
  S: string;

  function GetCursorHeightMargin: Integer;
  var
    IconInfo: TIconInfo;
    BitmapInfoSize: DWORD;
    BitmapBitsSize: DWORD;
    Bitmap: PBitmapInfoHeader;
    Bits: Pointer;
    BytesPerScanline, ImageSize: DWORD;
  {$WARNINGS OFF}

  function FindScanline(Source: Pointer; MaxLen: Cardinal; Value: Cardinal): Cardinal;
  {$ifdef LMDX64}
  var
    i: Cardinal;
  begin
    i := 0;
    while i < MaxLen do
    begin
      if PByte(TLMDPtrUInt(Source) + i)^ = Value then
        break;
      inc(i);
    end;
    Result := i;
  end;
  {$else}assembler;
  asm
    PUSH    ECX
    MOV     ECX,EDX
    MOV     EDX,EDI
    MOV     EDI,EAX
    POP     EAX
    REPE    SCASB
    MOV     EAX,ECX
    MOV     EDI,EDX
  end;
  {$endif}

  begin
      { Default value is entire icon height }
    Result := GetSystemMetrics(SM_CYCURSOR);
    if GetIconInfo(GetCursor, IconInfo) then
    try
      GetDIBSizes(IconInfo.hbmMask, BitmapInfoSize, BitmapBitsSize);
      Bitmap := AllocMem(BitmapInfoSize + BitmapBitsSize);
      try
        Bits := Pointer(TLMDPtrInt(Bitmap) + BitmapInfoSize);
        if GetDIB(IconInfo.hbmMask, 0, Bitmap^, Bits^) and
          (Bitmap^.biBitCount = 1) then
        begin
            { Point Bits to the end of this bottom-up bitmap }
          with Bitmap^ do
          begin
            BytesPerScanline := ((biWidth * biBitCount + 31) and not 31) div 8;
            ImageSize := biWidth * BytesPerScanline;
            Bits := Pointer(TLMDPtrInt(Bits) + BitmapBitsSize - ImageSize);
              { Use the width to determine the height since another mask bitmap
                may immediately follow }
            Result := FindScanline(Bits, ImageSize, $FF);
              { In case the and mask is blank, look for an empty scanline in the
                xor mask. }
            if (Result = 0) and (biHeight >= 2 * biWidth) then
              Result := FindScanline(Pointer(TLMDPtrInt(Bits) - ImageSize),
                ImageSize, $00);
            Result := Result div BytesPerScanline;
          end;
          Dec(Result, IconInfo.yHotSpot);
        end;
      finally
        FreeMem(Bitmap, BitmapInfoSize + BitmapBitsSize);
      end;
    finally
      if IconInfo.hbmColor <> 0 then DeleteObject(IconInfo.hbmColor);
      if IconInfo.hbmMask <> 0 then DeleteObject(IconInfo.hbmMask);
    end;
    end;

  function GetHint(Control: TElTabSheet): string;
  var
    HintInfo: THintInfo;
    CanShow: Boolean;
    begin
    HintInfo.HintControl := Control;
    HintInfo.HintPos := P;
    Inc(HintInfo.HintPos.Y, GetCursorHeightMargin);
    HintInfo.HintMaxWidth := Screen.Width;
    HintInfo.HintColor := Application.HintColor;
    HintInfo.CursorRect := Control.BoundsRect;
    HintInfo.HintStr := GetShortHint(TElTabSheet(Control).GetInheritedHint);
    HintInfo.ReshowTimeout := 0;
    HintInfo.HideTimeout := Application.HintHidePause;
    HintInfo.HintWindowClass := HintWindowClass;
    HintInfo.HintData := nil;
    CanShow := Control.Perform(CM_HINTSHOW, 0, TLMDPtrUInt(@HintInfo)) = 0;
    if CanShow and Assigned(Application.OnShowHint) then
      Application.OnShowHint(HintInfo.HintStr, CanShow, HintInfo);
    if CanShow and (HintInfo.HintStr <> '') then
    begin
      result := HintInfo.HintStr;
    end;
  end;

begin
  FHintTimer.Enabled := false;
  if not HandleAllocated then exit;

  ASheet := TabFromPoint(FHintCoords);
  P := ClientToScreen(FHintCoords);

  if ASheet = nil then exit;
  S := GetHint(ASheet);
  if StrLen(PChar(S)) = 0 then
  exit;
  if FHintWnd = nil then
    FHintWnd := HintWindowClass.Create(Self);

  FHintWnd.
  Canvas.Font.Charset := Font.Charset;

  mx := Screen.DesktopWidth + Screen.DesktopLeft;
  my := Screen.DesktopHeight + Screen.DesktopTop;

  R := FHintWnd.CalcHintRect(Screen.Width, S, nil);
  OffsetRect(R, P.X, P.Y + GetCursorHeightMargin);
  if R.Left < Screen.DesktopLeft then
    OffsetRect(R, Screen.DesktopLeft - R.Left, 0);
  if R.Top < Screen.DesktopTop then
    OffsetRect(R, 0, Screen.DesktopTop - R.Top);

  if R.Right > mx then OffsetRect(R, -(R.Right - mx), 0);
  if R.Bottom > my then OffsetRect(R, -(R.Bottom - my), 0);

  Application.HideHint;
  FHintWnd.Hide;
  FHintWnd.Color := Application.HintColor;
  FHintWnd.ActivateHint(R, S);
end;

procedure TElPageControl.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  IntMouseMove(Message.XPos, Message.YPos);
end;

procedure TElPageControl.ELThemeChanged(var Message: TMessage);
begin
  if IsThemed and UseXPThemes then
  begin
    SetWindowPos(
      Handle,
      0,
      0, 0, 0, 0,
      SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER
      );
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
    Realign;
  end;
  Message.Result := 1;
end;

procedure TElPageControl.SetSavvyMode(Value: Boolean);
var
  i: integer;
begin
  if FSavvyMode <> Value then
  begin
    FSavvyMode := Value;
    for i := 0 to PageCount - 1 do
      if FSavvyMode then
      begin
        if (Pages[i] <> ActivePage) and (Pages[i].HandleAllocated) then
          Pages[i].DestroyHandle;
      end
      else
      begin
        if (Pages[i] <> ActivePage) and (not Pages[i].HandleAllocated) then
          Pages[i].UpdateControlState;
      end;
  end;
end;

procedure TElPageControl.SetFlatTabBorderColor(Value: TColor);
begin
  if FFlatTabBorderColor <> Value then
  begin
    FFlatTabBorderColor := Value;
    if Style = etsFlatTabs then
    begin
      if ShowTabs then
        UpdateTabs(false);
      if (ActivePage <> nil) and ActivePage.Visible then
        ActivePage.Invalidate;
    end;
  end;
end;

procedure TElPageControl.SetTabBkColorNetStyle(Value: TColor);
begin
  if FTabBkColorNetStyle <> Value then
  begin
    FTabBkColorNetStyle := Value;
    if (Style = etsNetTabs) and ShowTabs then
      UpdateTabs(false);
  end;
end;

procedure TElPageControl.SetVerticalSideCaptions(Value: Boolean);
begin
  if FVerticalSideCaptions <> Value then
  begin
    FVerticalSideCaptions := Value;
    RebuildTabs(true);
  end;
  end;

{$IFDEF LMD_UNICODE}
{------------------------------------------------------------------------------}
procedure TElPageControl.CMHintShow(var Message:TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

{------------------------------------------------------------------------------}
procedure TElPageControl.SetHint(Value: TLMDString);
begin
//
end;
{$ENDIF}

procedure TElPageControl.SetActiveTabFont(Value: TFont);
begin
  FActiveTabFont.Assign(Value);
end;

procedure TElPageControl.SetUseActiveTabFont(Value: Boolean);
begin
  if FUseActiveTabFont <> Value then
  begin
    FUseActiveTabFont := Value;
    if ShowTabs then
      UpdateTabs(true);
  end;
end;

procedure TElPageControl.ActiveTabFontChange(Sender: TObject);
begin
  if (FActivePage <> nil) and UseActiveTabFont and ShowTabs then
    UpdateTabs(false);
end;

procedure TElPageControl.TriggerDrawTabEvent(Canvas: TCanvas; Page: TElTabSheet;
  Rect: TRect;
  DrawStep: TElTabDrawState; var DefaultDrawing: boolean);
begin
  DefaultDrawing := true;
  if assigned(FOnDrawTab) then
    FOnDrawTab(Self, Canvas, Page, Rect, DrawStep, DefaultDrawing);
end;

procedure TElPageControl.TriggerClosePageQueryEvent(Sheet: TElTabSheet; var
  CanClose: boolean);
begin
  if assigned(FOnClosePageQuery) then FOnClosePageQuery(Self, Sheet, CanClose);
end;
(*
procedure TElPageControl.ChangeScale(M, D: Integer);
begin
  inherited;
  ActiveTabFont.Size := MulDiv(ActiveTabFont.Size, M, D);
  HotTrackFont.Size := MulDiv(HotTrackFont.Size, M, D);
end;
*)

procedure TElPageControl.ChangeScale(M, D: Integer);
begin
  inherited;

  if not ParentFont then
  begin
    ActiveTabFont.Size := MulDiv(ActiveTabFont.Size, M, D);
    HotTrackFont.Size := MulDiv(HotTrackFont.Size, M, D);
  end;
end;
procedure TElPageControl.WndProc(var Message: TMessage);

type
  LPRECT = ^TRect;
  LPTTCItem = ^TTCItem;

var
  i: integer;
  begin
  case Message.Msg of
    TCM_GETCURSEL:
      Message.Result := TabIndex;
    TCM_SETCURSEL:
      begin
        Message.Result := TabIndex;
        TabIndex := Message.WParam;
      end;
    TCM_ADJUSTRECT:
{
Calculates a tab control's display area given a window rectangle, or calculates the window rectangle
that would correspond to a specified display area. You can send this message explicitly or by using
the TabCtrl_AdjustRect macro.

TCM_ADJUSTRECT
    wParam = (WPARAM) (BOOL) fLarger;
    lParam = (LPARAM) (LPRECT) prc;

Parameters
fLarger
Operation to perform. If this parameter is TRUE, prc specifies a display rectangle and receives the
corresponding window rectangle. If this parameter is FALSE, prc specifies a window rectangle and
receives the corresponding display area.
prc
Address of a RECT structure that specifies the given rectangle and receives the calculated rectangle.
Return Values
No return value.

Remarks
This message applies only to tab controls that are at the top. It does not apply to tab controls
that are on the sides or bottom.
}
      begin
        Message.Result := 0;
        if Assigned(LPRECT(Message.LParam)) then
          with LPRECT(Message.LParam)^ do
            if Boolean(Message.WParam) then
        begin
              Left := FTabsPos.X;
              Top := FTabsPos.Y;
              Right := FTabsSize.cx;
              Bottom := FTabsSize.cy;
            end
            else
            begin
              Left := FTabsPos.X;
              Top := FTabsPos.Y;
              Right := FTabsSize.cx;
              Bottom := FTabsSize.cy;
            end;
        end;
    TCM_DELETEALLITEMS:
      begin
        try
          for i := FPages.Count - 1 downto 0 do
            TElTabSheet(FPages[i]).Free;
          Message.Result := LRESULT(True);
        except
          Message.Result := LRESULT(False);
        end;
      end;
    TCM_DELETEITEM:
      begin
        try
          i := Message.WParam;
          Message.Result := LRESULT((FPages.Count > 0) and (i >= 0) and (i <
            FPages.Count));
          if Boolean(Message.Result) then TElTabSheet(FPages[i]).Free;
        except
          Message.Result := LRESULT(False);
        end;
      end;

    TCM_DESELECTALL:
      Message.Result := Message.WParam;

    TCM_GETCURFOCUS: //??? (or TabFromPoint ... )
      Message.Result := TabIndex;
    TCM_SETCURFOCUS:
        {
        Remarks
        If the tab control has the TCS_BUTTONS style (button mode), the tab with the focus may be different
        from the selected tab. For example, when a tab is selected, the user can press the arrow keys to set
        the focus to a different tab without changing the selected tab. In button mode, TCM_SETCURFOCUS sets
        the input focus to the button associated with the specified tab, but it does not change the selected tab.
        }
      begin
        i := Message.WParam;
        if (FPages.Count > 0) and
          (i >= 0) and
          (i < FPages.Count) then
          TabIndex := i;
      end;

    TCM_GETEXTENDEDSTYLE,
      TCM_SETEXTENDEDSTYLE: // TCS_EX_FLATSEPARATORS, TCS_EX_REGISTERDROP
      Message.Result := 0;

    TCM_GETIMAGELIST:
      begin
        if Assigned(Images) then
          Message.Result := Images.Handle
        else
          Message.Result := 0;
      end;
    TCM_GETITEM:
      begin
        i := Message.WParam;
        Message.Result := LRESULT(
          (FPages.Count > 0) and
          (i >= 0) and
          (i < FPages.Count) and
          Assigned(LPTTCItem(Message.LParam))
          );
        if Boolean(Message.Result) then
        try
          with LPTTCItem(Message.LParam)^ do
          begin // ???
                {mask: UINT;
                dwState: UINT;
                dwStateMask: UINT;
                pszText: PAnsiChar;
                cchTextMax: Integer;
                iImage: Integer;
                lParam: LPARAM;}
            if (mask xor TCIF_TEXT) <> 0 then
              pszText := PChar(Pages[i].Caption);
              if (mask xor TCIF_IMAGE) <> 0 then
            begin
              iImage := Pages[i].ImageIndex;
              if iImage = -1 then
                TriggerGetImageEvent(Pages[i].PageIndex, iImage);
            end;
                // TCIF_PARAM unsuported
          end;
          Message.Result := LRESULT(True);
        except
          Message.Result := LRESULT(False);
        end;
      end;
    TCM_GETITEMCOUNT:
      Message.Result := PageCount;
    TCM_GETITEMRECT:
      begin
        try
          i := Message.WParam;
          Message.Result := LRESULT(
            (FPages.Count > 0) and
            (i >= 0) and
            (i < FPages.Count) and
            Assigned(LPRECT(Message.LParam))
            );
          if Boolean(Message.Result) then
          begin
            with LPRECT(Message.LParam)^ do
            begin //???
              Left := 0;
              Top := 0;
              Right := 0;
              Bottom := 0;
            end;
            end;
        except
          Message.Result := LRESULT(False);
        end;
      end;
    TCM_GETROWCOUNT: //???
      Message.Result := 0;
    TCM_GETTOOLTIPS:
      Message.Result := 0;

    TCM_GETUNICODEFORMAT:
      Message.Result := 1;
    TCM_HIGHLIGHTITEM:
      Message.Result := 0;

    TCM_HITTEST:
      Message.Result := TabIndex;
    TCM_INSERTITEM:
      begin
        with NewPage do
        begin
          i := Message.WParam;
          if PageIndex <> i then
            if (i >= 0) and
              (i < FPages.Count) then
              PageIndex := 1
            else
              PageIndex := FPages.Count - 1;
          Message.Result := PageIndex;
          if Assigned(LPTTCItem(Message.LParam)) then
          begin
            with LPTTCItem(Message.LParam)^ do
          begin
                   {
                      tagTCITEMA = packed record
                        mask: UINT;
                        dwState: UINT;
                        dwStateMask: UINT;
                        pszText: PAnsiChar;
                        cchTextMax: Integer;
                        iImage: Integer;
                        lParam: LPARAM;
                      end;
                   }
              if (mask xor TCIF_TEXT) <> 0 then
                Caption := StrPas(pszText);
                if (mask xor TCIF_IMAGE) <> 0 then
                ImageIndex := iImage;
                   // TCIF_PARAM unsuported
            end;
          end;
        end;
        Message.Result := TabIndex;
      end;
    TCM_REMOVEIMAGE:
      begin
        i := Message.WParam;
        if Assigned(Images) and (i >= 0) and (i < Images.Count) then
          Images.Delete(i);
      end;
    TCM_SETIMAGELIST:
      begin
        if Assigned(Images) then
        begin
          Message.Result := Images.Handle;
          Images.Handle := Message.LParam;
        end
        else
        begin
          Message.Result := 0;
          if Message.LParam <> 0 then
            with TCustomImageList.Create(Self) do
              Handle := Message.LParam;
        end;
      end;
    TCM_SETITEM:
      begin
        i := Message.WParam;
        Message.Result := LRESULT(
          (FPages.Count > 0) and
          (i >= 0) and
          (i < FPages.Count) and
          Assigned(LPTTCItem(Message.LParam))
          );
        if Boolean(Message.Result) then
        begin
          with LPTTCItem(Message.LParam)^ do
          begin
            if (mask xor TCIF_TEXT) <> 0 then
              Pages[i].Caption := StrPas(pszText);
              if (mask xor TCIF_IMAGE) <> 0 then
              Pages[i].ImageIndex := iImage;
          end;
        end;
      end;
    TCM_SETITEMEXTRA: // no supported TabSheet user binary metadata
      Message.Result := LRESULT(False);
    TCM_SETITEMSIZE:
      begin
        Message.Result := MAKELPARAM(TabWidth, TabHeight);
        TabWidth := LoWord(Message.LParam);
        TabHeight := HiWord(Message.LParam);
      end;

    TCM_SETMINTABWIDTH:
      begin
        Message.Result := MinTabWidth;
        MinTabWidth := Message.LParam;
      end;

    TCM_SETPADDING: ;
    TCM_SETTOOLTIPS: ;

    TCM_SETUNICODEFORMAT:
      Message.Result := 1;
  else

    if (TLMDPtrUInt(Message.Msg) = ParentControlRepaintedMessage) and (Message.lParam <> TLMDPtrInt(Self)) then
      begin
        Invalidate;
        if ActivePage <> nil then
          ActivePage.Invalidate;
      end
    else
      inherited;
  end;
end;

procedure TElPageControl.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('BorderWidth', FakeInteger, nil, false);
    Filer.DefineProperty('Caption', FakeStr, nil, false);
    Filer.DefineProperty('FirstTab', FakeStr, nil, false);
  end;
  Filer.DefineProperty('DrawFocus', ReadDrawFocus, nil, false);
end;

procedure TElPageControl.SetCenterTabCaptions(Value: Boolean);
begin
  if FCenterTabCaptions <> Value then
  begin
    FCenterTabCaptions := Value;
    if ShowTabs then
      UpdateTabs(false);
  end;
end;

procedure TElPageControl.BeginUpdate;
begin
  inc(FUpdateCount);
  (*
  if (FUpdateCount = 1) and HandleAllocated then
    SendMessage(Handle, WM_SETREDRAW, 0, 0);
  *)
end;

procedure TElPageControl.EndUpdate;
begin
  dec(FUpdateCount);
  (*
  if (FUpdateCount = 0) and HandleAllocated then
  begin
    SendMessage(Handle, WM_SETREDRAW, 1, 0);
    Invalidate;
  end;
  *)
  if (FUpdateCount = 0) and (FUpdated > 0) then
  begin
    if FUpdated shr 16 = 2 then
    begin
      RebuildTabs(true);
      exit;
    end
    else
      if FUpdated shr 16 = 1 then
      RebuildTabs(false);

    if FUpdated and $0000FFFF = 1 then
      UpdateTabs(false)
    else
      if FUpdated and $0000FFFF = 2 then
      UpdateTabs(true);
  end;
end;

procedure TElPageControl.ReadDrawFocus(Reader: TReader);
begin
  DrawFocusRect := Reader.ReadBoolean;
end;

procedure TElPageControl.AdjustClientRect(var Rect: TRect);
var
  ASize: TSize;
  EdgeSize: integer;
begin
  inherited;
  if ShowTabs then
  begin
    if (FTabsSize.cx = -1) and (FTabsSize.cy = -1) then
    begin
      ASize := CalcTabAreaSize;
      FTabsSize := ASize;
    end
    else
      ASize := FTabsSize;

    if (not IsThemed) and ((ShowBorder and (Style in [etsTabs, etsNetTabs,
      etsFlatTabs, etsModernAngledTabs, etsAngledTabs, etsBitmapTabs])) and HasVisibleTabs) then
    begin
      begin
        if TabPosition in [etpTop, etpBottom] then
          EdgeSize := GetSystemMetrics(SM_CXEDGE)
        else
          EdgeSize := GetSystemMetrics(SM_CYEDGE);
        end;
    end
    else
    begin
      EdgeSize := 0;
    end;
    case TabPosition of
      etpTop:
        begin
          ASize.cy := min(ASize.cy, Rect.Bottom - Rect.Top);
          inc(Rect.Top, ASize.cy - EdgeSize);
          FTabsPos.x := 0;
          FTabsPos.y := 0;
        end;
      etpBottom:
        begin
          {if ASize.cy > 0 then
            inc(ASize.cy);
          } ASize.cy := min(ASize.cy, Rect.Bottom - Rect.Top);
          dec(Rect.Bottom, ASize.cy - EdgeSize);
          FTabsPos.x := 0;
          FTabsPos.y := Height - ASize.cy;
        end;
      etpRight:
        begin
          {if ASize.cx > 0 then
            inc(ASize.cx);
          }
          ASize.cx := min(ASize.cx, Rect.Right - Rect.Left);
          dec(Rect.Right, ASize.cx - EdgeSize);
          FTabsPos.x := Width - ASize.cx;
          FTabsPos.y := 0;
        end;
      etpLeft:
        begin
          ASize.cx := min(ASize.cx, Rect.Right - Rect.Left);
          inc(Rect.Left, ASize.cx - EdgeSize);
          FTabsPos.x := 0;
          FTabsPos.y := 0;
        end;
    end;
  end
  else
  begin
    FTabsSize.cx := 0;
    FTabsSize.cy := 0;
  end;
  if (not IsThemed) and ShowBorder and (Style in [etsTabs, etsNetTabs,
    etsFlatTabs, etsModernAngledTabs, etsAngledTabs, etsBitmapTabs]) then
    InflateRect(rect, -GetSystemMetrics(SM_CXEDGE),
      -GetSystemMetrics(SM_CYEDGE));
end;

procedure TElPageControl.IntMouseDown(XPos, YPos : integer);
var
  p: TPoint;
  TabSheet: TElTabSheet;
  DockCtl: TControl;
begin
  p := Point(XPos, YPos);
  TabSheet := TabFromPoint(P);

  if FDraggablePages and Assigned(TabSheet) and (not PtInRect(TabSheet.FCloseBtnRect, p)) then
  begin
    FDragPos := Point(XPos, YPos);
    FDoStartDrag := 0;
    // FDragTab := FActivePage;
    if FMultiLine then
      FDragTab := FActivePage;
  end;

  // TabSheet := nil;

  if PtInRect(FScrollLeftRect, p) then
  begin
    if CanScrollLeft then
    begin
      ScrollBtnState := pbsLeftBtnDown;
      FirstTab := FindNextPage(FirstTab, false, true, false);
    end;
    exit;
  end
  else
  if PtInRect(FScrollRightRect, p) then
  begin
    if CanScrollRight then
    begin
      ScrollBtnState := pbsRightBtnDown;
      FirstTab := FindNextPage(FirstTab, true, true, false);
    end;
    exit;
  end
  else
  begin
    if TabSheet <> nil then
    begin
      if PtInRect(TabSheet.FCloseBtnRect, p) and TabSheet.CloseButtonVisible and
        TabSheet.CloseBtnEnabled and (not (csDesigning in ComponentState)) then
      begin
        TabSheet.FCloseBtnDown := true;
        UpdateTab(TabSheet);
{
        if Assigned(FOnClosePageQuery) then
          FOnClosePageQuery(Self, CanClose, TabSheet)
        else
          CanClose := true;
        if CanClose then RemovePage(TabSheet);
}
      end;
      if (Style in [etsTabs, etsNetTabs, etsFlatTabs, etsModernAngledTabs, etsAngledTabs, etsBitmapTabs]) then
      begin
        if ActivePage <> TabSheet then
          ActivePage := TabSheet
        else
          if CanFocus and not Focused then
            try
          SetFocus;
            except
              // do nothing
            end;
      end
      else
      begin
        if (TabSheet.TabEnabled or (csDesigning in ComponentState)) then
        begin
          FDownTab := TabSheet;
          UpdateTabs(false);
        end;
      end;
    end;
  end;

  if (Style in [etsTabs, etsNetTabs, etsFlatTabs, etsModernAngledTabs, etsAngledTabs, etsBitmapTabs]) then
  begin
    DockCtl := GetDockClientFromMousePos(P);
    if (DockCtl <> nil) then
    begin
      FDockMouseDown := True;
      FDockMousePos := P;
    end;
//    DockCtl.BeginDrag(False);
  end;

  if FDraggablePages and (not FMultiLine) then
    FDragTab := FActivePage;
end;

procedure TElPageControl.IntRButtonUp(XPos, YPos : integer);
var
  p : TPoint;
  TabSheet : TElTabSheet;
  Menu     : TPopupMenu;
begin
  (*
  if FSaveCapture <> 0 then
    SetCapture(FSaveCapture)
  else
    ReleaseCapture;
  FSaveCapture := 0;
  *)
  p := Point(XPos, YPos);
  //dec(p.x, Left);
  //dec(p.y, Top);
  if (not PtInRect(FScrollRightRect, p)) and (not PtInRect(FScrollLeftRect, p))
    then
  begin
    Menu := nil;
    TabSheet := TabFromPoint(P);
    if (TabSheet <> nil) then
    begin
      Menu := TabSheet.TabMenu;
      if Menu = nil then
        Menu := TabSheet.PopupMenu;
      if Menu <> nil then
        Menu.PopupComponent := TabSheet;
    end;
    if Menu = nil then
    begin
      Menu := PopupMenu;
      if Menu <> nil then
        Menu.PopupComponent := Self;
    end;
    if Menu <> nil then
    begin
      Inc(P.x, Left);
      inc(p.y, Top);
      P := Parent.ClientToScreen(p);
      Menu.Popup(p.X, p.Y);
    end;
  end;
end;

procedure TElPageControl.IntLButtonUp(XPos, YPos : integer);
var
  p: TPoint;
  TabSheet, SwpPage: TElTabSheet;
  oldpos, newpos, i: integer;
  canclose: boolean;
begin
  FDockMouseDown := False;
  if FSaveCapture <> 0 then
    SetCapture(FSaveCapture)
  else
    ReleaseCapture;
  FSaveCapture := 0;
  if (FTrackTab <> nil) and (FTrackTab = FDownTab) and (Style in [etsButtons,
    etsFlatButtons]) then
  begin
    if ActivePage <> FTrackTab then
      ActivePage := FTrackTab
    else
      if CanFocus and not Focused then
        try
      SetFocus;
        except
          // do nothing
        end;
  end;
  FDownTab := nil;
  ScrollBtnState := pbsNone;

  p := Point(XPos, YPos);

  TabSheet := TabFromPoint(p);

  if (TabSheet <> nil) and TabSheet.FCloseBtnDown and
    PtInRect(TabSheet.FCloseBtnRect, p) then
  begin
    CanClose := true;
    TriggerClosePageQueryEvent(TabSheet, CanClose);
    if CanClose then
    begin
      RemovePage(TabSheet);
      TabSheet.Free;
      TabSheet := nil;
    end
    else
    begin
      TabSheet.FCloseBtnDown := false;
      UpdateTab(TabSheet);
    end;
  end;

  if (FDraggablePages) and (FDoStartDrag = 1) and (TabSheet <> nil) then
  begin
{
    p.x := TWMNCMouseMove(Message).XCursor;
    p.y := TWMNCMouseMove(Message).YCursor;
    p := parent.ScreenToClient(p);
    dec(p.x, left);
    dec(p.y, top);
}
    if TabSheet <> FActivePage then
    begin
      oldpos := FDragTab.PageIndex;
(*
      if FMultiLine then
      begin
        FDragTab.PageIndex := TabSheet.PageIndex;
        TabSheet.PageIndex := oldpos;
        ActivePageIndex := {oldpos}FDragTab.PageIndex;
      end
      else
      begin
*)
      newpos := TabSheet.PageIndex;
      if oldpos < newpos then
      begin
        i := oldpos + 1;
        while (i <= newpos) do
        begin
          SwpPage := GetPages(i);
          SwpPage.PageIndex := i - 1;
          inc(i);
        end;
        dec(i);
      end
      else
      begin
        i := oldpos - 1;
        while (i >= newpos) do
        begin
          SwpPage := GetPages(i);
          SwpPage.PageIndex := i + 1;
          dec(i);
        end;
        inc(i);
      end;

      FDragTab.PageIndex := i;
      ActivePageIndex := i;
//      end;
      RebuildTabs(true);
    end;
  end;
  FDoStartDrag := -1;
  perform(WM_SETCURSOR, Handle, 0);
end;

procedure TElPageControl.IntMouseMove(XPos, YPos : integer);
var
  p: TPoint;
  TabSheet: TElTabSheet;
  DockCtl: TControl;

  function GetDistance(AFirstPoint, ASecondPoint: TPoint): Integer;
  begin
    Result := Round(Sqrt(sqr(ASecondPoint.X - AFirstPoint.X) + sqr(ASecondPoint.Y - AFirstPoint.Y)));
  end;

begin
  p := Point(XPos, YPos);

  TabSheet := TabFromPoint(p);

{  if (TabSheet <> nil) and TabSheet.FCloseBtnDown and not
    PtInRect(TabSheet.FCloseBtnRect, p) then
  begin
    TabSheet.FCloseBtnDown := false;
    UpdateTab(TabSheet);
  end;}

  if Assigned(TabSheet) then
  begin
    if PtInRect(TabSheet.FCloseBtnRect, p) then
    begin
      if not TabSheet.FCloseBtnOwer then
      begin
        TabSheet.FCloseBtnOwer := True;
        UpdateTab(TabSheet);
      end
    end
    else
    begin
      if TabSheet.FCloseBtnDown or TabSheet.FCloseBtnOwer then
      begin
        TabSheet.FCloseBtnOwer := False;
        TabSheet.FCloseBtnDown := false;
        UpdateTab(TabSheet);
      end;
    end;
  end;
  if (FDraggablePages) and (FDoStartDrag > -1) and ((FDragPos.x <> P.x) or (FDragPos.y <> P.y)) then
  begin
    if FDragTab = TabSheet then
    begin
      if FDoStartDrag = 0 then
      begin
        FDoStartDrag := 1;
        SetCursor(Screen.Cursors[DragCursor]);
      end;
    end
    else
      if FDoStartDrag = 0 then
      FDoStartDrag := -1;
  end;

  if (FHintCoords.x <> XPos) or
     (FHintCoords.y <> YPos) then
  begin
    if FHintWnd <> nil then
    ShowWindow(FhintWnd.Handle, SW_HIDE);
    FHintTimer.Enabled := false;
    if TabSheet <> nil then
    begin
      FHintCoords := Point(XPos, YPos);
      if ShowTabHints then
        FHintTimer.Enabled := true;
    end;
  end;

  if FDockMouseDown then
  begin
    DockCtl := GetDockClientFromMousePos(P);
    if (DockCtl <> nil) and (GetDistance(FDockMousePos, P) >= 5) then
      DockCtl.BeginDrag(False);
  end;
end;

procedure TElPageControl.IntKeyDown(var Key : Word);
var
  Done: Boolean;
  tmp: TElTabSheet;
  tmpidx: integer;
begin
  if ShowTabs then
  begin
    case Key of
      VK_LEFT:
      begin
          Done := False;
          tmpidx := ActivePageIndex;
          while (tmpidx > 0) and not Done do
          begin
            tmpidx := tmpidx - 1;
            tmp := Pages[tmpidx];
            Done := tmp.TabVisible and tmp.TabEnabled;
          end;
          if Done then
            ActivePageIndex := tmpidx;
          Key := 0;
        end;
      VK_RIGHT:
      begin
          Done := False;
          tmpidx := ActivePageIndex;
          while (tmpidx < PageCount - 1) and not Done do
          begin
            tmpidx := tmpidx + 1;
            tmp := Pages[tmpidx];
            Done := tmp.TabVisible and tmp.TabEnabled;
          end;
          if Done then
            ActivePageIndex := tmpidx;
          Key := 0;
        end;
    end;
  end;
end;

procedure TElPageControl.Realign;
var R : TRect;
    i : integer;
begin
  FTabsSize.cx := -1;
  FTabsSize.cy := -1;
  R := ClientRect;
  AdjustClientRect(R);
  for i := 0 to PageCount - 1 do
  begin
    Pages[i].BoundsRect := R;
  end;
  if FActivePage <> nil then
  begin
    //FActivePage.BoundsRect := R;
    //FActivePage.BoundsRect := Rect(2,2, 500, 300);
    // AlignControls(nil, R);
    //AlignControls(FActivePage, R);
    //FActivePage.AlignControls(nil, R);
  end;
end;

procedure TElPageControl.RecalcTabPositions;
var HasVP : boolean;
    R     : TRect;
    TmpBmp: TBitmap;
    ASize : TSize;
    DC : HDC;

  function HasVisiblePages: boolean;
  var
    i: integer;
  begin
    result := true;
    for i := 0 to FPages.Count - 1 do
    begin
      if Pages[i].Visible then
        exit;
    end;
    result := false;
  end;

begin
  FRecalcTabPos := true;
  HasVP := HasVisibleTabs;
  if HasVP and HandleAllocated then
  begin
    if (FTabsSize.cx = -1) and (FTabsSize.cy = -1) then
    begin
      ASize := CalcTabAreaSize;
      FTabsSize := ASize;
    end
    else
      ASize := FTabsSize;

    case TabPosition of
      etpLeft: R := Rect(0, 0, ASize.cx, ASize.cy);
      etpRight: R := Rect(Width - ASize.cx, 0, Width, ASize.cy);
      etpTop: R := Rect(0, 0, ASize.cx, ASize.cy);
      etpBottom: R := Rect(0, Height - ASize.cy, ASize.cx, Height);
    end;
    TmpBmp := TBitmap.Create;
    TmpBmp.Width := R.Right - R.Left;
    TmpBmp.Height := R.Bottom - R.Top;
    DC := GetDC(Handle);
    TmpBmp.Handle := CreateCompatibleBitmap(DC, R.Right - R.Left, R.Bottom -
      R.Top);
    ReleaseDC(Handle, DC);
    DrawTabs(TmpBmp.Canvas, R, false, ASize);
    TmpBmp.Free;
  end;

  FRecalcTabPos := false;
end;

function TElPageControl.CalcTabAreaSize: TSize;
var
  R: TRect;
begin
  if ShowTabs then
  begin
    R := BoundsRect;
    OffsetRect(R, -Left, -Top);
    Result.cx := 0;
    Result.cy := 0;
    DrawTabs(Canvas, R, false, Result);
  end
  else
  begin
    Result.cx := 0;
    Result.cy := 0;
  end;
end;

procedure TElPageControl.DoDrawTabs(ACanvas: TCanvas; Rect: TRect; DoDraw: boolean; var Size: TSize);
var
  i, j: integer;
  SheetSize: TSize;
  sx, sy,
    cx, cy: integer;
  mx, my: integer;
  tx, ty: integer;
  TR: TRect;
  First,
    sf: boolean;
  curMargin: integer;
  ASheet,
    ASheet2: TElTabSheet;
  csl,
    csr: boolean;
  ScrollRect: TRect;
  bmp: TBitmap;
  brfl,
    dap: boolean;
  curRow: integer;
  b: boolean;
  begin
  if FirstTab <> nil then
    j := FPages.IndexOf(FirstTab)
  else
    j := 0;

  sx := 0;
  sy := 0;

  if Multiline then
  begin
    // Multiline drawing
    SetRectEmpty(FScrollLeftRect);
    SetRectEmpty(FScrollRightRect);

    mx := 0;
    my := 0;
    if (TabPosition in [etpLeft, etpRight]) then
    begin
      tx := 0;
      ty := FTabMarginLeft;
    end
    else
    begin
      tx := FTabMarginLeft;
      ty := 0;
    end;
    curRow := 0;

    // first determine where the tabs will be located
    i := j;
    sf := true;
    First := true;
    brfl := false;
    if (FPages.Count > 0) then
    repeat
      ASheet := TElTabSheet(FPages[i]);
      if (not sf) and (i = j) then break;
      sf := false;
      if ASheet.TabVisible then
      begin
        SheetSize := MeasureSheet(ACanvas, ASheet);
        if DoDraw or FRecalcTabPos then
        begin
          ASheet.FRect.Right := SheetSize.cx;
          ASheet.FRect.Bottom := SheetSize.cy;
        end;

        case TabPosition of
          etpTop,
            etpBottom:
            begin
              if not First then
                CurMargin := FTab.GetInnerMargin
              else
                CurMargin := 0;
              if brfl or (tx + SheetSize.cx + CurMargin > Width - FTabMarginRight)
                then
              begin
              // go to new row
                inc(ty, my + FTab.GetRowMargin);
                mx := 0;
                inc(CurRow);
                if (tx + SheetSize.cx + CurMargin > Width - FTabMarginRight) then
                begin
                  if First then
                  begin
                    SheetSize.cx := Width - FTab.GetOuterMargin * 2 - FTabMarginRight;
                    ASheet.FRect.Right := Width - FTab.GetOuterMargin * 2 - FTabMarginRight;
                  end;
                end;
                tx := FTabMarginLeft + FTab.GetOuterMargin;
                First := true;
              end
              else
              begin
                First := false;
              end;
              tx := tx + SheetSize.cx + CurMargin;
              my := Max(my, SheetSize.cy);
              if DoDraw or FRecalcTabPos then
                ASheet.FLine := CurRow;
            end;
          etpLeft,
            etpRight:
            begin
              if not First then
                CurMargin := FTab.GetInnerMargin
              else
                CurMargin := 0;
              if brfl or (ty + SheetSize.cy + CurMargin > Height - FTabMarginRight) then
              begin
              // go to new row
                inc(tx, mx + FTab.GetRowMargin);
                my := 0;
                inc(CurRow);
                if (ty + SheetSize.cy + CurMargin > Height - FTabMarginRight) then
                begin
                  if First then
                  begin
                    SheetSize.cy := Height - FTab.GetOuterMargin * 2 - FTabMarginRight;
                    ASheet.FRect.Bottom := Height - FTab.GetOuterMargin * 2 - FTabMarginRight;
                  end;
                end;
                ty := FTab.GetOuterMargin + FTabMarginLeft;
                First := true;
              end
              else
              begin
                First := false;
              end;
              ty := ty + SheetSize.cy + FTab.GetInnerMargin;
              mx := Max(mx, SheetSize.cx);
              if DoDraw or FRecalcTabPos then
                ASheet.FLine := CurRow;
            end;
        end;
        brfl := false;
      end;

    // increment counter
      inc(i);
      if i = FPages.Count then
      begin
        i := 0;
        brfl := true;
      end;
    until false;

    if (FPages.Count > 0) then
    begin
      case TabPosition of
        etpTop,
          etpBottom:
          begin
            inc(ty, FTab.GetAscend + my);
            if DoDraw or FRecalcTabPos then
              for i := 0 to FPages.Count - 1 do
              begin
                ASheet := TElTabSheet(FPages[i]);
                if ASheet.TabVisible then
                  ASheet.FRect.Bottom := my;
              end;
          end;
        etpLeft,
          etpRight:
          begin
            inc(tx, FTab.GetAscend + mx);
            if DoDraw or FRecalcTabPos then
              for i := 0 to FPages.Count - 1 do
              begin
                ASheet := TElTabSheet(FPages[i]);
                if ASheet.TabVisible then
                  ASheet.FRect.Right := mx;
              end;
          end;
      end;
    end;

    case TabPosition of
      etpTop,
        etpBottom:
        begin
          Size.cx := Width;
          Size.cy := ty;
        end;
      etpLeft,
        etpRight:
        begin
          Size.cy := Height;
          Size.cx := tx;
        end;
    end;

    // if we do not need painting, just return the size
    if not (DoDraw or FRecalcTabPos) then
      exit;

    FLines := CurRow + 1;

    if (FPages.Count > 0) then
      if not RaggedRight then
        ReorderPages(CurRow + 1);

    if not DoDraw then exit;

    for i := 0 to FPages.Count - 1 do
    begin
      if TElTabSheet(FPages[i]).TabVisible then
      begin
        if TabPosition in [etpLeft, etpRight] then
        begin
          TElTabSheet(FPages[i]).FRect.Right :=
            TElTabSheet(FPages[i]).FRect.Left + mx;
          end
        else
        begin
          TElTabSheet(FPages[i]).FRect.Bottom :=
            TElTabSheet(FPages[i]).FRect.Top + my;
          end;
      end;
    end;

    ASheet2 := nil;

    // define "reference points" that are used during painting
      case TabPosition of
        etpTop:
          begin
            sx := FTabMarginLeft;
            sy := 0;
            if (FPages.Count > 0) then
              inc(sy, FTab.GetAscend);
          end;
        etpBottom:
          begin
            sx := FTabMarginLeft;
            sy := Height - my;
            if (FPages.Count > 0) then
              dec(sy, FTab.GetAscend);
          end;
        etpLeft:
          begin
            sx := 0;
            sy := FTabMarginLeft;
            //OLD sy := Height - 1;

            if (FPages.Count > 0) then
              inc(sx, FTab.GetAscend);
          end;
        etpRight:
          begin
            sx := Width - mx;
            sy := FTabMarginLeft;
            if (FPages.Count > 0) then
              dec(sx, FTab.GetAscend);
          end;
      end;

    cx := sx;
    cy := sy;

    // perform drawing
    i := j;
    sf := true;
    CurRow := -1;
    if (FPages.Count > 0) then
      repeat
        ASheet := TElTabSheet(FPages[i]);
        if (not sf) and (i = j) then break;
        sf := false;
      // only draw visible tabs
        if ASheet.TabVisible then
        begin
        // if new row is started,
          if ASheet.FLine <> CurRow then
          begin
          // set start coords for the new page
          // First := true;
          // ASheet2 := nil;
            if CurRow >= 0 then
              case TabPosition of
                etpTop:
                  begin
                    cx := sx;
                    cy := cy + my + FTab.GetRowMargin;
                  end;
                etpBottom:
                  begin
                    cx := sx;
                    cy := cy - my - FTab.GetRowMargin;
                  end;
                etpLeft:
                  begin
                    cy := sy;
                    cx := cx + mx + FTab.GetRowMargin;
                  end;
                etpRight:
                  begin
                    cy := sy;
                    cx := cx - mx - FTab.GetRowMargin;
                  end;
              end;
            CurRow := ASheet.FLine;

            case TabPosition of
              etpTop,
                etpBottom:
                inc(cx, FTab.GetOuterMargin);
              etpLeft:
              //OLD dec(cy, FTab.GetOuterMargin);
                inc(cy, FTab.GetOuterMargin);
              etpRight:
                inc(cy, FTab.GetOuterMargin);
            end
          end
          else
          begin
            case TabPosition of
              etpTop,
                etpBottom:
                inc(cx, ASheet2.FRect.Right - ASheet2.FRect.Left);
              etpLeft:
              //OLD dec(cy, ASheet2.FRect.Bottom - ASheet2.FRect.Top);
                inc(cy, ASheet2.FRect.Bottom - ASheet2.FRect.Top);
              etpRight:
                inc(cy, ASheet2.FRect.Bottom - ASheet2.FRect.Top);
            end;
            if not FRecalcTabPos then
              FTab.DrawSpace(ACanvas, cx, cy, mx, my);
          end;

        //if FPageControl.TabPosition <> etpLeft then
          begin
          // define size for the tab
            TR.Left := cx;
            TR.Top := cy;
            TR.Right := cx + ASheet.FRect.Right;
            TR.Bottom := cy + ASheet.FRect.Bottom;
        {end
        else
        begin
          TR.Left  := cx;
          TR.Top   := cy - ASheet.FRect.Bottom - 1;
          TR.Right := cx + ASheet.FRect.Right;
          TR.Bottom:= cy;
        }
          end;

          ASheet.FRect := TR;
          FTab.AdjustDrawingSize(false, TR);
          ASheet.FComplete := true;

          if ((ASheet <> ActivePage) or FTab.CanDrawTab(false)) then
          begin
            FTab.Draw(ACanvas, TR, ASheet);
            ASheet.FShown := true;
          end;
          ASheet2 := ASheet;
        // First := false;
        end;

      // increment counter
        inc(i);
        if i = FPages.Count then
          i := 0;
      until false;

    ASheet := ActivePage;
    if (ASheet <> nil) and FTab.CanDrawTab(true) {and ASheet.FTabShowing} then
    begin
      TR := ASheet.FRect;
      FTab.AdjustDrawingSize(true, TR);
      ASheet.FComplete := true;
      FTab.Draw(ACanvas, TR, ASheet);
      ASheet.FShown := true;
    end;
    if not FRecalcTabPos then
      FTab.DrawTabLine(ACanvas, Rect);
  end
  else
  begin
    mx := 0;
    my := 0;
    if (TabPosition in [etpLeft, etpRight]) then
    begin
      tx := 0;
      ty := FTabMarginLeft;
    end
    else
    begin
      tx := FTabMarginLeft;
      ty := 0;
    end;

    // measure tabs
    for i := 0 to FPages.Count - 1 do
    begin
      ASheet := TElTabSheet(FPages[i]);
      if (not ASheet.TabVisible) then
        Continue;
      SheetSize := MeasureSheet(ACanvas, ASheet);

      mx := Max(mx, SheetSize.cx);
      my := Max(my, SheetSize.cy);
      // calculate total height/width
      case TabPosition of
        etpTop,
          etpBottom:
          tx := tx + SheetSize.cx + FTab.GetInnerMargin;
        etpLeft,
          etpRight:
          ty := ty + SheetSize.cy + FTab.GetInnerMargin;
      end;
      // possibly store the size of the sheet for further references
      if DoDraw or FRecalcTabPos then
      begin
        ASheet.FRect.Right := SheetSize.cx;
        ASheet.FRect.Bottom := SheetSize.cy;
      end;
    end;

    if (FPages.Count > 0) then
    begin
      case TabPosition of
        etpTop,
          etpBottom:
          begin
            if DoDraw or FRecalcTabPos then
              for i := 0 to FPages.Count - 1 do
              begin
                ASheet := TElTabSheet(FPages[i]);
                if ASheet.TabVisible then
                  ASheet.FRect.Bottom := my;
              end;
          end;
        etpLeft,
          etpRight:
          begin
            if DoDraw or FRecalcTabPos then
              for i := 0 to FPages.Count - 1 do
              begin
                ASheet := TElTabSheet(FPages[i]);
                if ASheet.TabVisible then
                  ASheet.FRect.Right := mx;
              end;
          end;
      end;
    end;

    case TabPosition of
      etpTop,
        etpBottom:
        begin
          Size.cx := Width;
          Size.cy := my;
          if ShowTabs and HasVisibleTabs then
            Size.cy := Size.cy + FTab.GetAscend;
            //inc(Size.cy, FTab.GetAscend);
        end;
      etpLeft,
        etpRight:
        begin
          Size.cy := Height;
          Size.cx := mx;
          if ShowTabs and HasVisibleTabs then
            Size.cx := Size.cx + FTab.GetAscend;
        end;
    end;

    // if drawing was not required, we just return the size of the tabs area
    if not (DoDraw or FRecalcTabPos) then exit;

    // add side margins
    if TabPosition in [etpLeft, etpRight] then
      inc(ty, FTab.GetOuterMargin * 2)
    else
      inc(tx, FTab.GetOuterMargin * 2);

    // now we define max bounds for the tabs
    case TabPosition of
      etpTop,
        etpBottom:
        mx := Width - FTabMarginRight;
      etpLeft,
        etpRight:
        my := Height - FTabMarginRight;
    end;

    case TabPosition of
      etpTop:
        begin
          sx := FTabMarginLeft;
          sy := 0;
        end;
      etpBottom:
        begin
          sx := FTabMarginLeft;
          sy := Height - my;
          if (FPages.Count > 0) then
            dec(sy, FTab.GetAscend);
        end;
      etpLeft:
        begin
          sx := 0;
          sy := FTabMarginLeft;
        end;
      etpRight:
        begin
          sx := Width - mx;
          sy := FTabMarginLeft;
          if (FPages.Count > 0) then
            dec(sx, FTab.GetAscend);
        end;
    end;

    cx := sx;
    cy := sy;

    if (FPages.Count > 0) then
    begin
      case TabPosition of
        etpTop:
          inc(cy, FTab.GetAscend);
        etpLeft:
          inc(cx, FTab.GetAscend);
      end;
    end;

    ASheet2 := nil;
    // ASheet := nil;
    First := true;
    dap := false;
    // copy background to be drawn for arrows
    case TabPosition of
      etpTop,
        etpBottom:
        begin
          FScrollLeftRect :=Classes.Rect(Rect.Right - 2 * GetSystemMetrics(SM_CXHSCROLL) - FTabMarginRight,
              Rect.Top + Margin,
            Rect.Right - GetSystemMetrics(SM_CXHSCROLL) - FTabMarginRight, Rect.Top + Margin +
              GetSystemMetrics(SM_CYHSCROLL));
          FScrollRightRect :=Classes.Rect(Rect.Right - GetSystemMetrics(SM_CXHSCROLL) - FTabMarginRight, Rect.Top +
              Margin, Rect.Right - FTabMarginRight, Rect.Top + Margin + GetSystemMetrics(SM_CYHSCROLL));
          ScrollRect :=Classes.Rect(Rect.Right - 2 * GetSystemMetrics(SM_CXHSCROLL) - FTabMarginRight,
              Rect.Top + Margin, Rect.Right - FTabMarginRight, Rect.Top + Margin + GetSystemMetrics(SM_CYHSCROLL));
        end;
      etpLeft:
        begin
          FScrollRightRect :=Classes.Rect(Rect.Left + Margin, Rect.Bottom - 2 *
              GetSystemMetrics(SM_CYVSCROLL) - FTabMarginRight,
            Rect.Left + Margin + GetSystemMetrics(SM_CXVSCROLL), Rect.Bottom -
              GetSystemMetrics(SM_CYVSCROLL) - FTabMarginRight);
          FScrollLeftRect :=Classes.Rect(Rect.Left + Margin, Rect.Bottom -
              GetSystemMetrics(SM_CYVSCROLL) - FTabMarginRight,
            Rect.Left + Margin + GetSystemMetrics(SM_CXVSCROLL), Rect.Bottom - FTabMarginRight);
          ScrollRect :=Classes.Rect(Rect.Left + Margin, Rect.Bottom - 2 *
              GetSystemMetrics(SM_CYVSCROLL) - FTabMarginRight,
            Rect.Left + Margin + GetSystemMetrics(SM_CXVSCROLL), Rect.Bottom - FTabMarginRight);
        end;
      etpRight:
        begin
          FScrollLeftRect :=Classes.Rect(Rect.Left + Margin, Rect.Bottom - 2 *
              GetSystemMetrics(SM_CYVSCROLL) - FTabMarginRight,
            Rect.Left + Margin + GetSystemMetrics(SM_CXVSCROLL), Rect.Bottom -
              GetSystemMetrics(SM_CYVSCROLL) - FTabMarginRight);
          FScrollRightRect :=Classes.Rect(Rect.Left + Margin, Rect.Bottom -
              GetSystemMetrics(SM_CYVSCROLL) - FTabMarginRight,
            Rect.Left + Margin + GetSystemMetrics(SM_CXVSCROLL), Rect.Bottom - FTabMarginRight);
          ScrollRect :=Classes.Rect(Rect.Left + Margin, Rect.Bottom - 2 *
              GetSystemMetrics(SM_CYVSCROLL) - FTabMarginRight,
            Rect.Left + Margin + GetSystemMetrics(SM_CXVSCROLL), Rect.Bottom - FTabMarginRight);
        end;
    end;
    Bmp := nil;
    if not FRecalcTabPos then
    begin
      Bmp := TBitmap.Create;
      Bmp.Width := ScrollRect.Right - ScrollRect.Left;
      Bmp.Height := ScrollRect.Bottom - ScrollRect.Top;
      Bmp.Canvas.CopyRect(Classes.Rect(0, 0, Bmp.Width, Bmp.Height), ACanvas,
        ScrollRect);
    end;

    ASheet := nil;

    // draw tabs one by one
    for i := j to FPages.Count - 1 do
    begin
      if (not TElTabSheet(FPages[i]).TabVisible) then Continue;
      ASheet := TElTabSheet(FPages[i]);
      case TabPosition of
        etpTop,
          etpBottom:
          if cx > mx then break;
        etpLeft:
          if cy > my then break;
        etpRight:
          if cy > my then break;
      end;
      if not First then
        case TabPosition of
          etpTop, etpBottom:
            if ASheet2.FRect.Right > mx then break;
          etpLeft, etpRight:
            if ASheet2.FRect.Bottom > my then break;
        end;
      // for tabs make an offset for the first tab
      if First then
        case TabPosition of
          etpTop,
            etpBottom:
            inc(cx, FTab.GetOuterMargin);
          etpLeft:
            inc(cy, FTab.GetOuterMargin);
          etpRight:
            inc(cy, FTab.GetOuterMargin);
        end
      else
      begin
        case TabPosition of
          etpTop,
            etpBottom:
            inc(cx, ASheet2.FRect.Right - ASheet2.FRect.Left);
          etpLeft:
            inc(cy, ASheet2.FRect.Bottom - ASheet2.FRect.Top);
          etpRight:
            inc(cy, ASheet2.FRect.Bottom - ASheet2.FRect.Top);
        end;
        if not FRecalcTabPos then
          FTab.DrawSpace(ACanvas, cx, cy, mx, my);
      end;

      // if TabPosition <> etpLeft then
      begin
        // define size for the tab
        TR.Left := cx;
        TR.Top := cy;
        TR.Right := cx + ASheet.FRect.Right;
        TR.Bottom := cy + ASheet.FRect.Bottom;
      end;

      ASheet.FRect := TR;
      FTab.AdjustDrawingSize(false, TR);
      case TabPosition of
        etpTop,
          etpBottom:
          begin
            b := CanScrollLeft or (TR.Right > mx);
            if b then
            begin
              if (TR.Right <= ScrollRect.Left) then
                ASheet.FComplete := true;
            end
            else
              if (TR.Right <= mx) then
              ASheet.FComplete := true;
            if not ASheet.FComplete then
              TR.Right := min(TR.Right, ScrollRect.Right);
          end;
        etpLeft, etpRight:
          begin
            b := CanScrollLeft or (TR.Bottom > my);
            if b then
            begin
              if (TR.Bottom <= ScrollRect.Bottom) then
                ASheet.FComplete := true;
            end
            else
              if (TR.Bottom <= my) then
              ASheet.FComplete := true;
            if not ASheet.FComplete then
              TR.Bottom := min(TR.Bottom, ScrollRect.Bottom);
          end;
      end;

      if (ASheet = ActivePage) then dap := true;
      if ((ASheet <> ActivePage) or FTab.CanDrawTab(false)) then
      begin
        if not FRecalcTabPos then
          FTab.Draw(ACanvas, TR, ASheet);
        ASheet.FShown := true;
      end;
      ASheet2 := ASheet;
      First := false;
    end;
    if ASheet <> nil then
    begin
      case TabPosition of
        etpTop,
          etpBottom:
          if (tx > Width) and
            (ASheet.FRect.Right > Width - FTab.GetOuterMargin)
              then
            ASheet.FComplete := false;
        etpLeft,
          etpRight:
          if (ty > Height) and
            (ASheet.FRect.Bottom > Height - FTab.GetOuterMargin)
              then
            ASheet.FComplete := false;
      end;
    end;

    // draw ActivePage if we are in Tabs style
    ASheet := ActivePage;
    if (ASheet <> nil) and FTab.CanDrawTab(true) and ASheet.FTabShowing and dap then
    begin
      TR := ASheet.FRect;
      FTab.AdjustDrawingSize(true, TR);
      case TabPosition of
        etpTop,
          etpBottom:
          begin
            b := CanScrollLeft or (TR.Right > mx);
            if b then
            begin
              if (TR.Right <= ScrollRect.Left) then
                ASheet.FComplete := true;
            end
            else
              if (TR.Right <= mx) then
              ASheet.FComplete := true;
            if not ASheet.FComplete then
              TR.Right := min(TR.Right, ScrollRect.Right);
          end;
        etpLeft, etpRight:
          begin
            b := CanScrollLeft or (TR.Bottom > my);
            if b then
            begin
              if (TR.Bottom <= ScrollRect.Bottom) then
                ASheet.FComplete := true;
            end
            else
              if (TR.Bottom <= my) then
              ASheet.FComplete := true;
            if not ASheet.FComplete then
              TR.Bottom := min(TR.Bottom, ScrollRect.Bottom);
          end;
      end;

      if not FRecalcTabPos then
        FTab.Draw(ACanvas, TR, ASheet);
      ASheet.FShown := true;
      ASheet.FRect := TR;
    end;

    ACanvas.Pen.Style := psSolid;
    if not FRecalcTabPos then
      FTab.DrawTabLine(ACanvas, Rect);

    csl := CanScrollLeft;
    csr := CanScrollRight;
    if csl or csr then
    begin
      if not FRecalcTabPos then
      begin
        ACanvas.CopyRect(ScrollRect, Bmp.Canvas, Classes.Rect(0, 0, Bmp.Width,
          Bmp.Height));
        FTab.DrawButtons(ACanvas, FScrollLeftRect,
          FScrollRightRect, csl, csr);
      end;
    end
    else
    begin
      SetRectEmpty(FScrollLeftRect);
      SetRectEmpty(FScrollRightRect);
    end;
    if not FRecalcTabPos then Bmp.Free;
  end;
end;

procedure TElPageControl.DrawTabs(ACanvas: TCanvas; R: TRect; DoDraw: boolean;
    var Size: TSize);
var
  i: integer;
  ASheet: TElTabSheet;

  BgRect: TRect;
  ACtl: TWinControl;

begin
  if DoDraw then

    if not IsThemed and (FImgForm <> nil) and (not
      (csDesigning in ComponentState)) then
    begin
      if (FImgForm.Control <> Self) then
      begin
        ACtl := FImgForm.GetRealControl;

        BgRect.Left := Left;
        BgRect.Top := Top;

        BgRect.TopLeft := Parent.ClientToScreen(BgRect.TopLeft);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
      end
      else
        BgRect.TopLeft := R.TopLeft;

      FImgForm.PaintBkgnd(ACanvas.Handle, R, BgRect.TopLeft,
        false);
    end
    else
      if Assigned(FOnDrawTabsBackground) and (not IsThemed) then
        FOnDrawTabsBackground(Self, ACanvas, R)
      else
        FTab.FillSpace(ACanvas, R);

  if DoDraw or FRecalcTabPos then
  begin
    FLines := 0;

    for i := 0 to FPages.Count - 1 do
    begin
      ASheet := TElTabSheet(FPages[i]);
      SetRectEmpty(ASheet.FRect);
      ASheet.FLine := -1;
      ASheet.FComplete := false;
      ASheet.FShown := false;
    end;
  end;
  DoDrawTabs(ACanvas, R, DoDraw, Size);
end;

{
function TElPageControl.GetBtnTheme: HTheme;
begin
  Result := LMDThemeService.Theme[tiButton];
end;
}

function TElPageControl.GetRotatedFont(Canvas: TCanvas; RotationAngle:
    integer): HFont;
var
  LogFont: TLogFont;
begin
  GetObject(Canvas.Font.Handle, SizeOf(LogFont), @LogFont);
  with LogFont do
  begin
    if (RotationAngle <> lfEscapement) and (FVerticalSideCaptions)
      then
    begin
      if RotationAngle = 0 then
        lfOutPrecision := OUT_DEFAULT_PRECIS
      else
        lfOutPrecision := OUT_TT_ONLY_PRECIS;
      lfEscapement := RotationAngle;
      lfOrientation := lfEscapement;
    end;
  end;
  Result := CreateFontIndirect(LogFont);
end;

function TElPageControl.GetBitmapActiveTab: TBitmap;
begin
  Result := nil;
  if Assigned(FActiveTab) then
    Result := FActiveTab;
//  if Assigned(FTab) and (FTab is TElBitmapTab) then
//    Result := (FTab as TElBitmapTab).FActiveTab;
end;

function TElPageControl.GetBitmapCloseBtn: TBitmap;
begin
  Result := nil;
  if Assigned(FCloseButton) then
    Result := FCloseButton;
//  if Assigned(FTab) and (FTab is TElBitmapTab) then
//    Result := (FTab as TElBitmapTab).FCloseButton;
end;

function TElPageControl.GetBitmapTab: TBitmap;
begin
  Result := nil;
  if Assigned(FBTab) then
    Result := FBTab;
//  if Assigned(FTab) and (FTab is TElBitmapTab) then
//    Result := (FTab as TElBitmapTab).FTab;
end;

procedure TElPageControl.SetBitmapActiveTab(const Value: TBitmap);
begin
  if Assigned(FTab) and (FTab is TElBitmapTab) then
  begin
    (FTab as TElBitmapTab).FActiveTab.Assign(Value);
    (FTab as TElBitmapTab).FActiveTab.TransparentColor := (FTab as TElBitmapTab).FActiveTab.Canvas.Pixels[1,
                         (FTab as TElBitmapTab).FActiveTab.Height - 1];
  end;
  FActiveTab.Assign(value);
end;

procedure TElPageControl.SetBitmapCloseBtn(const Value: TBitmap);
begin
  if Assigned(FTab) and (FTab is TElBitmapTab) then
    (FTab as TElBitmapTab).FCloseButton.Assign(Value);
  FCloseButton.Assign(Value);
end;

procedure TElPageControl.SetBitmapTab(const Value: TBitmap);
begin
  if Assigned(FTab) and (FTab is TElBitmapTab) then
  begin
    (FTab as TElBitmapTab).FTab.Assign(Value);
    (FTab as TElBitmapTab).FTab.TransparentColor := (FTab as TElBitmapTab).FTab.Canvas.Pixels[1,
                         (FTab as TElBitmapTab).FTab.Height - 1];
  end;
  FBTab.Assign(Value);
end;

{
function TElPageControl.GetScrollTheme: HTheme;
begin
  Result := ScrollTheme;
end;
}

{
function TElPageControl.GetTabTheme: HTheme;
begin
  Result := Theme;
end;
}

function TElPageControl.MeasureSheet(ACanvas: TCanvas; Sheet: TElTabSheet): TSize;
var
  AFont: HFont;
  R,
    R1: TRect;
  t, i: integer;

  TM: TLMDTextMetric;
//  sid: integer;
  ACaption,
    TCaption: TLMDString;
  P: PLMDChar;
  imidx: integer;
  LDetails: TThemedElementDetails;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  begin
    TriggerMeasureTabEvent(ACanvas, Sheet, result);
    if (Result.cx = 0) and (Result.cy = 0) then
    begin
      if (FActivePage = Sheet) and (UseActiveTabFont) then
        ACanvas.Font.Assign(ActiveTabFont)
      else
        if HotTrack and (FTrackTab = Sheet) then
        ACanvas.Font.Assign(HotTrackFont)
      else
        if (not Sheet.ParentFont) and Sheet.UseFontForTabs then
        ACanvas.Font.Assign(Sheet.Font)
      else
        ACanvas.Font.Assign(Font);

      if FVerticalSideCaptions then
      begin
        case TabPosition of
          etpLeft:
            AFont := GetRotatedFont(ACanvas, 900);
          etpRight:
            AFont := GetRotatedFont(ACanvas, -900);
        else
          AFont := GetRotatedFont(ACanvas, 0);
        end;
        ACanvas.Font.Handle := AFont;
      end;
      R.Left := 0;
      R.Top := 0;
      R.Right := 0;
      R.Bottom := 0;
      if Length(Sheet.Caption) = 0 then
      begin
        LMDGetTextMetrics(ACanvas.Handle, TM);
        t := Abs(TM.tmHeight);

        if (TabPosition in [etpLeft, etpRight]) and VerticalSideCaptions then
        begin
          Result.cx := t;
          Result.cy := Max(10, MinTabHeight);
        end
        else
        begin
          Result.cy := t;
          Result.cx := Max(10, MinTabWidth);
        end;
        if (FImages <> nil) and ShowImages and (Sheet.ImageIndex >= 0) then
          case TabPosition of
            etpTop,
              etpBottom:
              begin
                Result.cx := Result.cx + FImages.Width + Margin;
                if (Result.cy < FImages.Height) then
                  Result.cy := FImages.Height;
              end;
            etpLeft,
              etpRight:
              begin
                if VerticalSideCaptions then
                begin
                  Result.cy := Result.cy + FImages.Height + Margin;
                  if (Result.cx < FImages.Width) then
                    Result.cx := FImages.Width;
                end
                else
                begin
                  Result.cx := Result.cx + FImages.Width + Margin;
                  if (Result.cy < FImages.Height) then
                    Result.cy := FImages.Height;
                end;
              end;
          end;
      end
      else
        with ACanvas do
        begin
          ACaption := Sheet.Caption;

          if LThemeMode <> ttmNone then
          begin
            if (FTab is TElStdTab) or (FTab is TElNetTab) or (FTab is
              TEl2DFlatTab) then
            begin
              LDetails.Element := teTab;
              LDetails.Part := TABP_TABITEM;
              if not Sheet.Enabled then
                LDetails.State := TIS_DISABLED
                // sid := TIS_DISABLED
              else
                if Sheet = FActivePage then
              begin
                LDetails.Part := TABP_TOPTABITEM;
                LDetails.State := TTIS_SELECTED;
              end
              else
              begin
                LDetails.Part := TABP_TABITEM;
                if Sheet = FTrackTab then
                begin
                  LDetails.State := TIS_HOT;
                end
                else
                begin
                  if Sheet = FDownTab then
                  begin
                    LDetails.State := TIS_FOCUSED;
                  end
                  else
                  begin
                    LDetails.State := TIS_NORMAL;
                  end;
                end;
              end;
            //pid := TABP_TOPTABITEM;
            //sid := TTIS_SELECTED;
            end
            else
            begin
              LDetails.Element := teButton;
              LDetails.Part := BP_PUSHBUTTON;
              if Sheet.Enabled then
              begin
                if Sheet = FActivePage then
                begin
                  LDetails.State := PBS_PRESSED;
                end
                else
                begin
                  if Sheet = FTrackTab then
                  begin
                    LDetails.State := PBS_HOT;
                  end
                  else
                  begin
                    if Sheet = FDownTab then
                    begin
                      LDetails.State := PBS_PRESSED;
                    end
                    else
                    begin
                      LDetails.State := PBS_PRESSED;//PBS_NORMAL;
                    end;
                  end;
                end;
              end
              else
              begin
                LDetails.State := PBS_DISABLED;
              end;
            end;

            {
            if (FTab is TElStdTab) or (FTab is TElNetTab) or (FTab is
              TEl2DFlatTab) then
              ATheme := TabTheme
            else
              ATheme := BtnTheme;
            }

{$IFDEF LMD_UNICODE}
            if LMDWidePos(LMDWideCRLF, ACaption) > 0 then
{$ELSE}
            if Pos(LMDAnsiCRLF, ACaption) > 0 then
{$ENDIF}
              lMDDrawText(Handle, ACaption, Length(ACaption), R, DT_CALCRECT or AccelFlags[ShowAccelChar])

            else
            begin
              LMDThemeServices.GetThemeTextExtent(LThemeMode, Handle, LDetails,
                ACaption, Length(ACaption), DT_LEFT or AccelFlags[ShowAccelChar], nil, R);
//              GetThemeTextExtent(ATheme, Handle, pid, sid,
            end;
            Result.cx := R.Right - R.Left;
            Result.cy := R.Bottom - R.Top;
            if (TabPosition in [etpLeft, etpRight]) and VerticalSideCaptions
              then
            begin
              i := Result.cx;
              Result.cx := Result.cy;
              Result.cy := i;
            end;
            if (FImages <> nil) and ShowImages and (Sheet.ImageIndex >= 0) then
              case TabPosition of
                etpTop,
                  etpBottom:
                  begin
                    Result.cx := Result.cx + FImages.Width + Margin;
                    if (Result.cy < FImages.Height) then
                      Result.cy := FImages.Height;
                  end;
                etpLeft,
                  etpRight:
                  begin
                    if VerticalSideCaptions then
                    begin
                      Result.cy := Result.cy + FImages.Height + Margin;
                      if (Result.cx < FImages.Width) then
                        Result.cx := FImages.Width;
                    end
                    else
                    begin
                      Result.cx := Result.cx + FImages.Width + Margin;
                      if (Result.cy < FImages.Height) then
                        Result.cy := FImages.Height;
                    end;
                  end;
              end;
            if (not (FTab is TElFlatBtnTab)) or (LDetails.State <> PBS_NORMAL) then
            begin
              R1 := LMDThemeServices.ContentRect(LThemeMode, Handle, LDetails, R);
              if (TabPosition in [etpLeft, etpRight]) and VerticalSideCaptions
                then
              begin
                Result.cy := Result.cy + (R1.Left - R.Left) + (R.Right - R1.Right);
                Result.cx := Result.cx + (R1.Top - R.Top) + (R.Bottom - R1.Bottom);
              end
              else
              begin
                Result.cx := Result.cx + (R1.Left - R.Left) + (R.Right - R1.Right);
                Result.cy := Result.cy + (R1.Top - R.Top) + (R.Bottom - R1.Bottom);
              end;
            end;
          end
          else
          begin
            if (not (TabPosition in [etpLeft, etpRight])) or (not VerticalSideCaptions) then
            begin
              TCaption := '';
              P := PLMDChar(ACaption);
              while P^ <> #0 do
              begin
                if (not FShowAccelChar) or (P^ <> '&') then
                begin
                  TCaption := TCaption + P^;
                  inc(p);
                end
                else
                begin
                  inc(p);
                  if P^ = '&' then
                  begin
                    TCaption := TCaption + P^;
                    inc(p);
                  end;
                end;
              end;
              ACaption := TCaption;
            end;

{$IFDEF LMD_UNICODE}
            if LMDWidePos(LMDWideCRLF, ACaption) > 0 then
{$ELSE}
            if Pos(LMDAnsiCRLF, ACaption) > 0 then
{$ENDIF}
            begin
              LMDDrawText(Handle, ACaption, Length(ACaption), R, DT_CALCRECT or AccelFlags[ShowAccelChar]);
              Result.cx := R.Right - R.Left;
              Result.cy := R.Bottom - R.Top;
            end
            else
{$IFDEF LMD_UNICODE}
              GetTextExtentPoint32W(Handle, PWideChar(ACaption),
                Length(ACaption), Result);
              {$ELSE}
              GetTextExtentPoint32(Handle, PChar(ACaption), Length(ACaption),
                Result);
{$ENDIF}
            if (TabPosition in [etpLeft, etpRight]) and VerticalSideCaptions then
            begin
              i := Result.cx;
              Result.cx := Result.cy;
              Result.cy := i;
            end;

            imidx := Sheet.ImageIndex;
            if imidx = -1 then
              TriggerGetImageEvent(Sheet.PageIndex, imidx);
            if (FImages <> nil) and ShowImages and (imidx <> -1) then
              case TabPosition of
                etpTop,
                  etpBottom:
                  begin
                    Result.cx := Result.cx + FImages.Width + Margin;
                    if (Result.cy < FImages.Height) then
                      Result.cy := FImages.Height;
                  end;
                etpLeft,
                  etpRight:
                  begin
                    if VerticalSideCaptions then
                    begin
                      Result.cy := Result.cy + FImages.Height + Margin;
                      if (Result.cx < FImages.Width) then
                        Result.cx := FImages.Width;
                    end
                    else
                    begin
                      Result.cx := Result.cx + FImages.Width + Margin;
                      if (Result.cy < FImages.Height) then
                        Result.cy := FImages.Height;
                    end;
                  end;
              end;
          end;
        end;
      case TabPosition of
        etpTop,
          etpBottom:
          begin
            Result.cx := Result.cx + Margin * 2 + Margin;
            Result.cy := Result.cy + Margin;
          end;
        etpLeft,
          etpRight:
          begin
            if VerticalSideCaptions then
            begin
              Result.cy := Result.cy + Margin * 2 + Margin;
              Result.cx := Result.cx + Margin;
            end
            else
            begin
              Result.cx := Result.cx + Margin * 2 + Margin;
              Result.cy := Result.cy + Margin;
            end;
          end;
      end;
      if Sheet.CloseButtonVisible then
      begin
        i := min(GetSystemMetrics(SM_CXSMSIZE {SM_CXMENUSIZE}), Result.cy - 1);
        Result.cx := Result.cx + i + Margin div 2;
      end;

      FTab.AdjustTabSize(Result);

      if TabWidth > 0 then
        Result.cx := TabWidth;
      if TabHeight > 0 then
        Result.cy := TabHeight;
    end;
  end;
end;

procedure TElPageControl.ReorderPages(MaxRows: integer);
var
  TmpSheet,
    BreakSheet: TElTabSheet;

  function TabsOnRow(RowIndex: integer; var LastTab: TElTabSheet): integer;
  var
    i: integer;
    ASheet: TElTabSheet;
  begin
    Result := 0;
    LastTab := nil;
    for i := 0 to FPages.Count - 1 do
    begin
      ASheet := TElTabSheet(FPages[i]);
      if ASheet.TabVisible then
      begin
        if ASheet.FLine = RowIndex then
        begin
          LastTab := ASheet;
          inc(Result);
        end;
      end;
    end;
  end;

  function DoReorder(BreakSheet: TElTabSheet): integer;
  var
    CurRow: integer;
    i, j: integer;
    mx, my,
      tx, ty: integer;
    ASheet: TElTabSheet;
    sf,
      First,
      brfl: boolean;
    SheetSize: TSize;
    CurMargin: integer;
  begin
    mx := 0;
    my := 0;
    if (TabPosition in [etpLeft, etpRight]) then
    begin
      tx := 0;
      ty := FTabMarginLeft;
    end
    else
    begin
      tx := FTabMarginLeft;
      ty := 0;
    end;

    CurRow := 0;

      if FirstTab <> nil then
        j := FPages.IndexOf(FirstTab)
      else
        j := 0;

    i := j;
    sf := true;
    First := true;
    brfl := false;
    repeat
      ASheet := TElTabSheet(FPages[i]);
      if (not sf) and (i = j) then break;
      sf := false;
      if ASheet.TabVisible then
      begin
        SheetSize.cx := ASheet.FRect.Right;
        SheetSize.cy := ASheet.FRect.Bottom;

        case TabPosition of
          etpTop,
            etpBottom:
            begin
              if not First then
                CurMargin := FTab.GetInnerMargin
              else
                CurMargin := 0;
              if (ASheet = BreakSheet) or brfl or (tx + SheetSize.cx + CurMargin > Width - FTabMarginRight) then
              begin
                  // go to new row
                inc(ty, my + FTab.GetRowMargin);
                mx := 0;
                inc(CurRow);
                if (tx + SheetSize.cx + CurMargin > Width - FTabMarginRight) then
                begin
                  if First then
                  begin
                    SheetSize.cx := Width - FTab.GetOuterMargin * 2 - FTabMarginRight;
                    ASheet.FRect.Right := Width - FTab.GetOuterMargin * 2 - FTabMarginRight;
                  end;
                end;
                tx := FTab.GetOuterMargin + FTabMarginLeft;
                First := true;
              end
              else
              begin
                First := false;
              end;
              tx := tx + SheetSize.cx + CurMargin;
              my := Max(my, SheetSize.cy);
              ASheet.FLine := CurRow;
            end;
          etpLeft,
            etpRight:
            begin
              if not First then
                CurMargin := FTab.GetInnerMargin
              else
                CurMargin := 0;
              if (ASheet = BreakSheet) or brfl or (ty + SheetSize.cy + CurMargin > Height - FTabMarginRight) then
              begin
                  // go to new row
                inc(tx, mx + FTab.GetRowMargin);
                my := 0;
                inc(CurRow);
                if (ty + SheetSize.cy + CurMargin > Height - FTabMarginRight) then
                begin
                  if First then
                  begin
                    SheetSize.cy := Height - FTab.GetOuterMargin * 2 - FTabMarginRight;
                    ASheet.FRect.Bottom := Height - FTab.GetOuterMargin * 2 - FTabMarginRight;
                  end;
                end;
                ty := FTab.GetOuterMargin + FTabMarginLeft;
                First := true;
              end
              else
              begin
                First := false;
              end;
              ty := ty + SheetSize.cy + FTab.GetInnerMargin;
              mx := Max(mx, SheetSize.cx);
              ASheet.FLine := CurRow;
            end;
        end;
        brfl := false;
      end;

        // increment counter
      inc(i);
      if i = FPages.Count then
      begin
        i := 0;
        brfl := true;
      end;
    until false;

    result := CurRow + 1;
  end;

  procedure AlignTabs(MaxRows: integer);
  var
    i, j: integer;
    L: TLMDObjectList;
    ASheet: TElTabSheet;
    tx,
      ty: integer;
    acc,
      res,
      scale: double;
    togo,
    leftto: integer;
    Width : integer;
    R1,
    RW    : TRect;
    s     : integer;
    begin
    L := TLMDObjectList.Create;
    for i := 0 to MaxRows - 1 do
    begin
       // build a row
      L.Clear;
      for j := 0 to FPages.Count - 1 do
      begin
        ASheet := TElTabSheet(FPages[j]);
        if ASheet.TabVisible then
        begin
          if ASheet.FLine = i then
          begin
            L.Add(ASheet);
          end;
        end;
      end;
      if (TabPosition in [etpLeft, etpRight]) then
      begin
        tx := 0;
        ty := 0;
      end
      else
      begin
        tx := 0;
        ty := 0;
      end;
      acc := 0;
      togo := 0;
      leftto := 0;
      if L.Count = 0 then
      begin
        inc(tx);
        inc(ty);
      end
      else
      for j := 0 to L.Count - 1 do
      begin
        Width := Self.Width;
        if IsThemed then
        begin
          RW := GetClientRect;
          if ShowBorder then
            s := 1
          else
            s := 0;

          if Canvas.Handle <> 0 then
          begin
            R1 := LMDThemeServices.ContentRect(UseThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(ttPane), RW);
            Inc(Width, (RW.Left - R1.Left) * s);
          end;
        end;
        //        for j := 0 to L.Count - 1 do
//        begin
          case TabPosition of
            etpLeft,
              etpRight:
              begin
                inc(ty, TElTabSheet(L[j]).FRect.Bottom);
                if j > 0 then inc(ty, FTab.GetInnerMargin);
              end;
            etpTop,
              etpBottom:
              begin
                inc(tx, TElTabSheet(L[j]).FRect.Right);
                if j > 0 then inc(tx, FTab.GetInnerMargin);
              end;
          end;
//        end;
      end;
      scale := 1;
      case TabPosition of
        etpLeft,
          etpRight:
          begin
            scale := (Height - FTab.GetOuterMargin * 2 - FTabMarginRight - FTabMarginLeft) / ty;
            leftto := Height - FTab.GetOuterMargin * 2 - FTabMarginRight - FTabMarginLeft;
          end;
        etpTop,
          etpBottom:
          begin
            scale := (Width - FTab.GetOuterMargin * 2 - FTabMarginRight - FTabMarginLeft) / tx;
            leftto := Width - FTab.GetOuterMargin * 2 - FTabMarginRight - FTabMarginLeft;
          end;
      end;

      for j := 0 to L.Count - 1 do
      begin
        case TabPosition of
          etpLeft,
            etpRight:
            begin
              res := TElTabSheet(L[j]).FRect.Bottom * scale;
              acc := acc + frac(res);
              TElTabSheet(L[j]).FRect.Bottom := Trunc(res);
              inc(togo, Trunc(res));
            end;
          etpTop,
            etpBottom:
            begin
              res := TElTabSheet(L[j]).FRect.Right * scale;
              acc := acc + frac(res);
              TElTabSheet(L[j]).FRect.Right := Trunc(res);
              inc(togo, Trunc(res));
            end;
        end;
      end;
      if (L.Count > 0) and (acc > 0) then
      begin
        case TabPosition of
          etpLeft,
            etpRight:
            begin
              inc(TElTabSheet(L.Last).FRect.Bottom, round(acc));
              if togo + round(acc) > leftto then
              begin
                dec(TElTabSheet(L.Last).FRect.Bottom);
                end;
            end;
          etpTop,
            etpBottom:
            begin
              inc(TElTabSheet(L.Last).FRect.Right, round(acc));
              if togo + round(acc) > leftto then
              begin
                dec(TElTabSheet(L.Last).FRect.Right);
                end;
            end;
        end;
      end;
    end;
    L.Free;
  end;

begin
  if MaxRows > 1 then
  begin
    if TabsOnRow(MaxRows - 1, TmpSheet) < TabsOnRow(MaxRows - 2, BreakSheet) - 1
      then
    begin
      if DoReorder(BreakSheet) > MaxRows then
        DoReorder(nil);
    end;
  end;
  AlignTabs(MaxRows);
end;

procedure TElPageControl.SetTabClass(Value: TElTabClass);
begin
  if FTabClass <> Value then
  begin
    if FTab <> nil then
      FTab.Free;
    FTabClass := Value;
    FTab := FTabClass.Create(Self);
  end;
end;

procedure TElPageControl.WMMouseWheel(var Msg: TWMMouseWheel);
var
  Dy : integer;
  sl : integer;
  LPos: TPoint;
begin
  LPos := ScreenToClient(Point(Msg.XPos, Msg.YPos));
  if Multiline and (Focused or (LMDPointInRect(LPos, Rect(FTabsPos.X, FTabsPos.Y, FTabsPos.X + FTabsSize.cx, FTabsPos.Y + FTabsSize.cy)))) then
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
      if DY > 0 then
      begin
        if TabIndex > 0 then
          TabIndex := TabIndex - 1;
      end
      else
      begin
        if TabIndex < PageCount - 1 then
          TabIndex := TabIndex + 1;
      end
    end;
  end;
end;

function TElTabSheet.IsThemed: Boolean;
begin
  Result := Assigned(PageControl) and PageControl.IsThemed;
end;

{
function TElTabSheet.GetBtnTheme: HTheme;
begin
  if Assigned(PageControl) then
    Result := PageControl.BtnTheme
  else
    Result := 0;
end;

function TElTabSheet.GetScrollTheme: HTheme;
begin
  if Assigned(PageControl) then
    Result := PageControl.ScrollTheme
  else
    Result := 0;
end;

function TElTabSheet.GetTabTheme: HTheme;
begin
  if Assigned(PageControl) then
    Result := PageControl.Theme
  else
    Result := 0;
end;

function TElTabSheet.GetCloseBtnTheme: HTheme;
begin
  if Assigned(PageControl) then
    Result := PageControl.CloseBtnTheme
  else
    Result := 0;
end;
}

procedure TElTabSheet.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  R, R1: TRect;

begin
  if IsThemed then
    begin
      if PageControl.ShowBorder then
        begin
          R := Message.CalcSize_Params.rgrc[0];
          inherited;
          R := Message.CalcSize_Params.rgrc[0];
          R1 := LMDThemeServices.ContentRect(FPageControl.UseThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(ttPane), R);
          Message.CalcSize_Params.rgrc[0] := R1;
          end;
    end
  else
    inherited;
end;

procedure TElTabSheet.WMNCPaint(var Message: TWMNCPaint);
var
  RC, R1, R2, RW: TRect;
  DC: HDC;
  s: integer;
  LThemeMode: TLMDThemeMode;
  //Details: TThemedElementDetails;
begin
  if not IsThemed then
  begin
    inherited;
  end
  (*{$IFDEF LMDCOMP16}
  else
  if StyleServices.Enabled and (BorderWidth > 0) then
  begin
    DC := GetWindowDC(Handle);
    try
      R1 := ClientRect;
      OffsetRect(R1, BorderWidth, BorderWidth);
      with R1 do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
      SetWindowOrgEx(DC, -BorderWidth, -BorderWidth, nil);
      Details := StyleServices.GetElementDetails(ttBody);
      StyleServices.DrawParentBackground(Handle, DC, Details, False);
    finally
      ReleaseDC(Handle, DC);
    end;
    Message.Result := 0;
  end
  {$ENDIF}*)
  else
  begin
    LThemeMode := FPageControl.UseThemeMode;
    DC := GetWindowDC(Handle);
    Windows.GetClientRect(Handle, RC);
    GetWindowRect(Handle, RW);
    IntMapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    OffsetRect(RW, -RW.Left, -RW.Top);
    R2 := RW;

    if PageControl.ShowBorder then
      s := 0
    else
      s := 1;

    R1 := LMDThemeServices.ContentRect(LThemeMode, DC, ThemeServices.GetElementDetails(ttPane), RW);
    Inc(RW.Left, (RW.Left - R1.Left) * s);
    Inc(RW.Top, (RW.Top - R1.Top) * s);
    Inc(RW.Right, (RW.Right - R1.Right) * s);
    Inc(RW.Bottom, (RW.Bottom - R1.Bottom) * s);

    if PageControl.ShowTabs and (PageControl.Style in [etsTabs, etsNetTabs,
      etsFlatTabs, etsModernAngledTabs, etsAngledTabs, etsBitmapTabs]) then
    begin
      case PageControl.TabPosition of
        etpTop: RW.Top := RW.Top + (R2.Top - R1.Top);
        etpBottom: RW.Bottom := RW.Bottom + (R2.Bottom - R1.Bottom);
        etpRight: RW.Right := RW.Right + (R2.Right - R1.Right);
        etpLeft: RW.Left := RW.Left + (R2.Left - R1.Left);
      end;
    end;

    LMDThemeServices.DrawElement(LThemeMode, DC, ttPane, RW, LMDRectToPtr(R2));
    ReleaseDC(Handle, DC);
  end;
end;

{
function TElTab.GetBtnTheme: HTheme;
begin
  if Assigned(FOwner) then
  begin
    Result := FOwner.BtnTheme;
  end
  else
  begin
    Result := 0;
  end;
end;

function TElTab.GetScrollTheme: HTheme;
begin
  if Assigned(FOwner) then
  begin
    Result := FOwner.ScrollTheme;
  end
  else
  begin
    Result := 0;
  end;
end;

function TElTab.GetTabTheme: HTheme;
begin
  if Assigned(FOwner) then
  begin
    Result := FOwner.TabTheme;
  end
  else
  begin
    Result := 0;
  end;
end;

function TElTab.GetCloseBtnTheme: HTheme;
begin
  if Assigned(FOwner) then
  begin
    Result := FOwner.CloseBtnTheme;
  end
  else
  begin
    Result := 0;
  end;
end;
}

function TElTab.IsThemed: Boolean;
begin
  Result := Assigned(FOwner) and FOwner.IsThemed;
end;

function TElTab.GetTabPosition: TElTabPosition;
begin
  Result := etpTop;
  if Assigned(FOwner) and Assigned(FOwner) then
  begin
    Result := FOwner.TabPosition;
  end;
end;

function TElTab.GetContentMargin: Integer;
begin
  Result := Margin;
end;

procedure TElTab.FixupTab(Canvas: TCanvas; R: TRect; TabSheet: TElTabSheet);
begin
  // intentionally left blank
end;

procedure TElTab.AdjustFocusRect(var R: TRect);
begin
  // intentionally left blank
end;

procedure TElBtnTab.FillTab(Canvas: TCanvas; Rect: TRect;
  TabSheet: TElTabSheet);
begin
  if not IsThemed then
  begin
    inherited;
  end;
end;

procedure TElFlatBtnTab.FillTab(Canvas: TCanvas; Rect: TRect;
  TabSheet: TElTabSheet);
begin
  if not IsThemed then
  begin
    inherited;
  end;
end;

procedure TElTabSheet.ELThemeChanged(var Message: TMessage);
begin
  if IsThemed and UseXPThemes then
  begin
    SetWindowPos(
      Handle,
      0,
      0, 0, 0, 0,
      SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER
      );
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
  end;
  Message.Result := 1;
end;

function TElTabSheet.GetUseXPThemes: Boolean;
begin
  Result := Assigned(PageControl) and PageControl.UseXPThemes;
end;

procedure TElTabSheet.CreateWnd;
begin
  inherited;
  if IsThemed then
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_FRAMECHANGED);
end;

procedure TElTabSheet.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);

  if Reader.Parent is TElPageControl then
    PageControl := TElPageControl(Reader.Parent);
end;

procedure TElTabSheet.CMDialogChar(var Message: TCMDialogChar);
begin
  if Enabled and TabVisible and ({not} PageControl.ShowAccelChar) and FPageControl.CanFocus and IsAccel(Message.CharCode, Caption) then
  begin
    FPageControl.ActivePage := Self;
    Message.Result := 1;
  end
  else
    inherited;
end;

{$IFDEF LMD_UNICODE}
{------------------------------------------------------------------------------}
procedure TElTabSheet.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

{------------------------------------------------------------------------------}
procedure TElTabSheet.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

procedure TElTabSheet.SetUseTabColor(Value: Boolean);
begin
  if FUseTabColor <> Value then
  begin
    FUseTabColor := Value;
    if Parent <> nil then
      TElPageControl(Parent).UpdateTab(Self);
  end;
end;

function TElTabSheet.CloseButtonVisible: Boolean;
begin
  Result := ShowCloseButton and
    ((FPageControl = nil) or
    ((FPageControl.CloseButtonMode = cbmAll) or
    ((FPageControl.CloseButtonMode = cbmActive) and
    (FPageControl.ActivePage = self)
    )
    )
    );
end;

procedure TElTabSheet.SetUseFontForTabs(Value: Boolean);
begin
  if FUseFontForTabs <> Value then
  begin
    FUseFontForTabs := Value;
    if (not ParentFont) and TabVisible and (FPageControl <> nil) then
      FPageControl.RebuildTabs(false);
  end;
end;

procedure TElTabSheet.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or WS_CLIPCHILDREN;
  Params.WindowClass.style := Params.WindowClass.style or CS_HREDRAW or
    CS_VREDRAW;
end;

procedure TElTabSheet.SetCloseBtnEnabled(Value: Boolean);
begin
  if FCloseBtnEnabled <> Value then
  begin
    FCloseBtnEnabled := Value;
    if Parent <> nil then
      TElPageControl(Parent).UpdateTab(Self);
  end;
end;

function TElTabSheet.GetInheritedHint: string;
begin
  Result := inherited Hint;
end;

procedure TElTabSheet.BeginCreate;
begin
  inc(FCreating);
end;

procedure TElTabSheet.EndCreate;
begin
  dec(FCreating);
  if FCreating = 0 then
    begin
      if not (csDesigning in ComponentState) then
        StyleManager := DefaultStyleManager;
    end;
end;

procedure TEl2DFlatTab.AdjustDrawingSize(Active: boolean; var R: TRect);
var
  FPageControl: TElPageControl;
begin
  if Active then
  begin
    FPageControl := FOwner;
    case FPageControl.TabPosition of
      etpLeft:
        begin
          inc(R.Bottom);
          dec(R.Top);
        end;
      etpTop:
        begin
          dec(R.Left);
          inc(R.Right);
        end;
      etpRight:
        begin
          inc(R.Bottom);
          dec(R.Top);
        end;
      etpBottom:
        begin
          dec(R.Left);
          inc(R.Right);
        end;
    end;
  end;
end;

procedure TEl2DFlatTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet
  : TElTabSheet);
begin
  inherited;
  if TabSheet = FOwner.FActivePage then
    case FOwner.TabPosition of
      etpTop:
        begin
          if After then
          begin
            dec(R.Right);
            dec(R.Bottom);
          end
          else
          begin
            inc(R.Right);
            inc(R.Bottom);
          end;
        end;
      etpBottom:
        begin
          if After then
          begin
            inc(R.Top);
            dec(R.Bottom);
            dec(R.Right);
          end
          else
          begin
            dec(R.Top);
            inc(R.Bottom);
            inc(R.Right);
          end;
        end;
      etpLeft:
        begin
          if After then
          begin
            dec(R.Right);
            dec(R.Bottom);
          end
          else
          begin
            inc(R.Right);
            inc(R.Bottom);
          end;
        end;
      etpRight:
        begin
          if After then
          begin
            inc(R.Left);
            dec(R.Right);
            dec(R.Bottom);
          end
          else
            dec(R.Left);
          inc(R.Right);
          inc(R.Bottom);
        end;
    end;
end;

procedure TEl2DFlatTab.AdjustTabSize(var Size: TSize);
var
  R,
    R1: TRect;
//  pid,
//    sid: integer;
begin
  if IsThemed then
  begin
//    pid := TABP_TOPTABITEM;
//    sid := TIS_SELECTED;
    R := Rect(0, 0, Size.cx, Size.cy);
    R1 := LMDThemeServices.ContentRect(FOwner.UseThemeMode, FOwner.Canvas.Handle, ThemeServices.GetElementDetails(ttTopTabItemSelected), R);
    if FOwner.TabPosition in [etpLeft, etpRight] then
    begin
      Size.cy := Size.cy + (R1.Left - R.Left) + (R.Right - R1.Right);
      Size.cx := Size.cx + (R1.Top - R.Top) + (R.Bottom - R1.Bottom);
    end
    else
    begin
      Size.cx := Size.cx + (R1.Left - R.Left) + (R.Right - R1.Right);
      Size.cy := Size.cy + (R1.Top - R.Top) + (R.Bottom - R1.Bottom);
    end;
  end
  else
  begin
    Size.cx := Size.cx + 2;
    Size.cy := Size.cy + 2;
  end;
end;

function TEl2DFlatTab.CanDrawTab(ActiveDraw: boolean): Boolean;
begin
  result := ActiveDraw;
end;

procedure TEl2DFlatTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
  TElTabSheet);
var
  iPartId: Integer;
  iStateId: Integer;
  LDetails: TThemedElementDetails;
  LThemeMode: TLMDThemeMode;
begin
  if IsThemed {and (TabPosition = etpTop)} then
  begin
    LDetails.Element := teTab;
    LThemeMode := FOwner.UseThemeMode;
    if TabSheet = FOwner.FActivePage then
    begin
      iPartId := TABP_TOPTABITEM;
      iStateId := TIS_SELECTED;
    end
    else
    begin
      iPartId := TABP_TABITEM;
      if TabSheet = FOwner.FTrackTab then
      begin
        iStateId := TIS_HOT;
      end
      else
      begin
        if TabSheet = FOwner.FDownTab then
        begin
          iStateId := TIS_FOCUSED;
        end
        else
        begin
          iStateId := TIS_NORMAL;
        end;
      end;
    end;
    if not TabSheet.Enabled then
    begin
      iStateId := TIS_DISABLED;
    end;
    if (iStateId <> TIS_NORMAL) or (iPartId = TABP_TOPTABITEM) then
    begin
      LDetails.State := iStateId;
      LDetails.Part := iPartId;
      DrawXPTabEdges(LThemeMode, LDetails, Canvas, R, TabPosition);
//      DrawXPTabEdges(TabTheme, iPartId, iStateId, Canvas, R, TabPosition);
      end
    else
    begin
      LDetails := ThemeServices.GetElementDetails(ttBody);
      DrawXPTabEdges(LThemeMode, LDetails, Canvas, R, TabPosition);
//      DrawXPTabEdges(TabTheme, TABP_BODY, 0, Canvas, R, TabPosition);
    end;
  end
  else
  begin
    if TabSheet = FOwner.FActivePage then
    begin
      Canvas.Pen.Color := FOwner.FlatTabBorderColor;
        // IncColor(clBtnHighlight, 20, 20, 20);

      case FOwner.TabPosition of
        etpLeft:
          with Canvas do
          begin
            MoveTo(r.right - 1, r.top);
            LineTo(r.left, r.top);
            LineTo(r.left, r.bottom + 1);

            MoveTo(r.left + 1, r.bottom);
            LineTo(r.right, r.bottom);
          end;
        etpTop:
          with Canvas do
          begin
            (* highlight *)
            MoveTo(r.left, r.bottom - 1);
            LineTo(r.left, r.top);
            LineTo(r.right, r.top);

            MoveTo(r.right - 1, r.top + 1);
            LineTo(r.right - 1, r.bottom - 1);
          end;
        etpRight:
          with Canvas do
          begin
            MoveTo(r.left, r.top);
            LineTo(r.right, r.top);

            LineTo(r.right, r.bottom + 1);
            MoveTo(r.left, r.bottom);
            LineTo(r.right, r.bottom);
          end;
        etpBottom:
          with Canvas do
          begin
            (* highlight *)

            MoveTo(r.left, r.top);
            LineTo(r.left, r.bottom + 1);

            MoveTo(r.right, r.top);
            LineTo(r.right, r.bottom);
            LineTo(r.left, r.bottom);
          end;
      end;
    end;
    InflateRect(r, -1, -1);
  end;
end;

procedure TEl2DFlatTab.DrawTabLine(Canvas: TCanvas; R: TRect);
var
  ASheet: TElTabSheet;
  R1: TRect;
begin
  ASheet := FOwner.ActivePage;

  if IsThemed then
  begin
    case FOwner.TabPosition of
      etpTop:
        begin
          R.Top := R.Bottom - 1;
          inc(R.Bottom, 2);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
            end;
        end;
      etpBottom:
        begin
          R.Bottom := R.Top + 1;
          dec(R.Top);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
            end;
        end;
      etpLeft:
        begin
          R.Left := R.Right - 2;
          //inc(R.Right);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
            end;
        end;
      etpRight:
        begin
          R.Right := R.Left + 2;
          dec(R.Left, 1);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
            end;
        end;
    end;
    LMDThemeServices.DrawElement(FOwner.UseThemeMode, Canvas.Handle, ttPane, R, nil);
//    DrawThemeBackground(TabTheme, Canvas.Handle, TABP_PANE, 0, R, nil);
    exit;
  end;
  Canvas.Pen.Color := FOwner.FlatTabBorderColor;

  ASheet := FOwner.ActivePage;
  with Canvas do
    case FOwner.TabPosition of
      etpTop:
        begin
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Bottom - 1);
            LineTo(R.Right, R.Bottom - 1);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Bottom - 1);
              LineTo(ASheet.FRect.Left, R.Bottom - 1);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              MoveTo(ASheet.FRect.Right - 1, R.Bottom - 1);
              LineTo(R.Right, R.Bottom - 1);
            end;
          end;
        end;
      etpBottom:
        begin
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Top);
            LineTo(R.Right, R.Top);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Top);
              LineTo(ASheet.FRect.Left, R.Top);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              MoveTo(ASheet.FRect.Right + 1, R.Top);
              LineTo(R.Right, R.Top);
            end;
          end;
        end;
      etpLeft:
        begin
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Right - 1, R.Top);
            LineTo(R.Right - 1, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Right - 1, R.Top);
              LineTo(R.Right - 1, ASheet.FRect.Top);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Right - 1, ASheet.FRect.Bottom + 1);
              LineTo(R.Right - 1, R.Bottom);
            end;
          end;
          inc(R.Bottom);
        end;
      etpRight:
        begin

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Top);
            LineTo(R.Left, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Left, R.Top);
              LineTo(R.Left, ASheet.FRect.Top);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Left, ASheet.FRect.Bottom + 1);
              LineTo(R.Left, R.Bottom);
            end;
          end;

        (*
        if FOwner.ShowBorder then
        begin
          Pixels[R.Right - 2, R.Top] := clBtnHighlight;
          Pixels[R.Right - 1, R.Top] := clBtnHighlight;
          if not FOwner.Flat then
          begin
            Pixels[R.Right - 2, R.Bottom] := cl3DDkShadow;
            Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
          end
          else
          begin
            Pixels[R.Right - 2, R.Bottom] := clBtnShadow;
            Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
          end;
        end;
        inc(R.Bottom);
        *)
        end;
    end;
end;

function TEl2DFlatTab.GetAscend: Integer;
begin
  Result := 2;
end;

function TEl2DFlatTab.GetInnerMargin: Integer;
begin
  Result := 2;
end;

function TEl2DFlatTab.GetOuterMargin: Integer;
begin
  Result := 4;
end;

procedure TEl2DFlatTab.FillTab(Canvas: TCanvas; Rect: TRect; TabSheet:
  TElTabSheet);

var
  ACtl: TWinControl;
  BgRect: TRect;

begin
  AdjustFillSize(false, Rect, TabSheet);

  if (FOwner.FImgForm = nil) or (csDesigning in
    FOwner.ComponentState) then

  begin
    Canvas.Brush.Style := bsSolid;
    if TabSheet.UseTabColor then
      Canvas.Brush.Color := TabSheet.TabColor
    else
      if TabSheet = FOwner.FActivePage then
      Canvas.Brush.Color := FOwner.FActiveTabColor
    else
      Canvas.Brush.Color := FOwner.FInactiveTabColor;
    Canvas.FillRect(Rect);

  end
  else
  if TabSheet = FOwner.FActivePage then
  begin
    if (FOwner.FImgForm.Control <> FOwner) then
    begin
      ACtl := FOwner.FImgForm.GetRealControl;

      BgRect.Left := FOwner.Left;
      BgRect.Top := FOwner.Top;

      BgRect.TopLeft :=
        FOwner.Parent.ClientToScreen(BgRect.TopLeft);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);

      FOwner.FImgForm.PaintBkgnd(Canvas.Handle, Rect,
        BgRect.TopLeft, false);
    end;

  end;
  AdjustFillSize(true, Rect, TabSheet);
end;

{ ------------------------ TElModernAngledTab ---------------------------- }

function TElModernAngledTab.CanDrawTab(ActiveDraw: boolean): Boolean;
begin
  result := true //not ActiveDraw;
end;

procedure TElModernAngledTab.DrawButtons(Canvas: TCanvas; LeftRect, RightRect: TRect;
  CSL, CSR: boolean);
var
  PageControl: TElPageControl;
  ColorRight,
    ColorLeft: TColor;
begin
  if IsThemed then
  begin
    inherited;
  end
  else
  begin
    PageControl := FOwner;

    if CSL and (PageControl.FScrollBtnState in [pbsLeftBtnOver, pbsLeftBtnDown])
      then
      DrawButtonFrameEx3(Canvas.Handle, LeftRect, false,
        PageControl.FScrollBtnState = pbsLeftBtnDown, PageControl.Color,
          PageControl.Flat, AllBorderSides);
    if CSR and (PageControl.FScrollBtnState in [pbsRightBtnOver,
      pbsRightBtnDown]) then
      DrawButtonFrameEx3(Canvas.Handle, RightRect, false,
        PageControl.FScrollBtnState = pbsRightBtnDown, PageControl.Color,
          PageControl.Flat, AllBorderSides);

    if PageControl.FScrollBtnState = pbsLeftBtnDown then
      ColorLeft := clBtnHighlight
    else
      ColorLeft := cl3DDkShadow;
    if PageControl.FScrollBtnState = pbsRightBtnDown then
      ColorRight := clBtnHighlight
    else
      ColorRight := cl3DDkShadow;

    case PageControl.TabPosition of
      etpTop,
        etpBottom:
        begin
          LMDDrawArrow(Canvas, eadLeft, LeftRect, ColorLeft, csl);
          LMDDrawArrow(Canvas, eadRight, RightRect, ColorRight, csr);
        end;
      etpLeft:
        begin
          LMDDrawArrow(Canvas, eadDown, LeftRect, ColorLeft, csl);
          LMDDrawArrow(Canvas, eadUp, RightRect, ColorRight, csr);
        end;
      etpRight:
        begin
          LMDDrawArrow(Canvas, eadUp, LeftRect, ColorLeft, csl);
          LMDDrawArrow(Canvas, eadDown, RightRect, ColorRight, csr);
        end;
    end;
  end;
end;

procedure TElModernAngledTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet: TElTabSheet);
var
  LTmpBmp: TBitmap;
  LTmpRect: TRect;
  LDCState: Integer;
  LRgn: HRGN;
begin
  begin
//    if TabSheet = FOwner.FActivePage then
    LTmpBmp := TBitmap.Create;
    try
      LTmpRect := R;
      OffsetRect(LTmpRect, -LTmpRect.Left, -LTmpRect.Top);

      LTmpBmp.HandleType := bmDIB;
      LTmpBmp.Width := LTmpRect.Right;
      LTmpBmp.Height := LTmpRect.Bottom;
      LTmpBmp.Canvas.CopyRect(LTmpRect, Canvas, R);

      if TabSheet.UseTabColor then
        Canvas.Pen.Color := ColorDarker(TabSheet.TabColor, 60)
      else
        Canvas.Pen.Color := clBlack;

      LTmpBmp.Canvas.CopyRect(LTmpRect, Canvas, R);
      LTmpBmp.Canvas.Brush.Color := RGB($50, $50, $50);
      LTmpBmp.Canvas.FillRect(LTmpRect);

      case FOwner.TabPosition of
        etpLeft:
          with Canvas do
          begin
            LDCState := SaveDC(Canvas.Handle);

            LRgn := CreateRectRgnIndirect(R);
            if GetClipRgn(Canvas.Handle, LRgn) = 1 then
            begin
              OffsetClipRgn(Canvas.Handle, 3, 5);
              ExtSelectClipRgn(Canvas.Handle, LRgn, RGN_DIFF);
              OffsetClipRgn(Canvas.Handle, 0, -3);
            end;

            AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 30, true);
            OffsetClipRgn(Canvas.Handle, 1, 2);
            AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 60, true);

//            if (TabSheet <> FOwner.ActivePage) and (TabSheet <> FOwner.FirstTab) then
            if (FOwner.FPages.IndexOf(TabSheet) > FOwner.FPages.IndexOf(FOwner.FActivePage)) then
            begin
              OffsetClipRgn(Canvas.Handle, 0, -((R.Bottom - R.Top) - (AngledOffset - 2)));
              AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 60, true);
              OffsetClipRgn(Canvas.Handle, 1, 2);
              AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 30, true);
            end;

            RestoreDC(Canvas.Handle, LDCState);

            LTmpBmp.Canvas.CopyRect(LTmpRect, Canvas, R);
            LMDDrawSmoothLine(LTmpBmp, LTmpRect.Left, LTmpRect.Bottom - AngledOffset, LTmpRect.Right, LTmpRect.Bottom + 1, Pen.Color);
            LMDDrawSmoothLine(LTmpBmp, LTmpRect.Left, LTmpRect.Bottom - AngledOffset, LTmpRect.Left, LTmpRect.Top + AngledOffset, Pen.Color);
            LMDDrawSmoothLine(LTmpBmp, LTmpRect.Left, LTmpRect.Top + AngledOffset, LTmpRect.Right + 2, LTmpRect.Top - 1, Pen.Color);
            Canvas.CopyRect(R, LTmpBmp.Canvas, LTmpRect);
          end;
        etpTop:
          with Canvas do
          begin
            LDCState := SaveDC(Canvas.Handle);

            LRgn := CreateRectRgnIndirect(R);
            if GetClipRgn(Canvas.Handle, LRgn) = 1 then
            begin
              OffsetClipRgn(Canvas.Handle, 5, 3);
              ExtSelectClipRgn(Canvas.Handle, LRgn, RGN_DIFF);
              OffsetClipRgn(Canvas.Handle, -2, 0);
            end;

            AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 60, true);
            OffsetClipRgn(Canvas.Handle, 1, 1);
            AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 30, true);

//            if (TabSheet <> FOwner.ActivePage) and (TabSheet <> FOwner.FirstTab) then
            if (FOwner.FPages.IndexOf(TabSheet) > FOwner.FPages.IndexOf(FOwner.FActivePage)) then
            begin
              OffsetClipRgn(Canvas.Handle, -((R.Right - R.Left) - (AngledOffset - 2)), 0);
              AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 60, true);
              OffsetClipRgn(Canvas.Handle, 2, 1);
              AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 30, true);
            end;

            RestoreDC(Canvas.Handle, LDCState);

            LTmpBmp.Canvas.CopyRect(LTmpRect, Canvas, R);
            LMDDrawSmoothLine(LTmpBmp, LTmpRect.left + AngledOffset{ - 1}, LTmpRect.Top, LTmpRect.Left, LTmpRect.Bottom - 1, Pen.Color);
            LMDDrawSmoothLine(LTmpBmp, LTmpRect.Left + AngledOffset{ - 1}, LTmpRect.Top, LTmpRect.Right - AngledOffset, LTmpRect.Top, Pen.Color);
            LMDDrawSmoothLine(LTmpBmp, (LTmpRect.Right - AngledOffset) - 1, LTmpRect.Top, LTmpRect.Right - 1, LTmpRect.Bottom - 1, Pen.Color);
            Canvas.CopyRect(R, LTmpBmp.Canvas, LTmpRect);
          end;
        etpRight:
          with Canvas do
          begin
            LDCState := SaveDC(Canvas.Handle);

            LRgn := CreateRectRgnIndirect(R);
            if GetClipRgn(Canvas.Handle, LRgn) = 1 then
            begin
              OffsetClipRgn(Canvas.Handle, -3, 5);
              ExtSelectClipRgn(Canvas.Handle, LRgn, RGN_DIFF);
              OffsetClipRgn(Canvas.Handle, 0, -3);
            end;

            AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 30, true);
            OffsetClipRgn(Canvas.Handle, 1, 2);
            AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 60, true);

//            if (TabSheet <> FOwner.ActivePage) and (TabSheet <> FOwner.FirstTab) then
            if (FOwner.FPages.IndexOf(TabSheet) > FOwner.FPages.IndexOf(FOwner.FActivePage)) then
            begin
              OffsetClipRgn(Canvas.Handle, 0, -((R.Bottom - R.Top) - (AngledOffset) + 2));
              AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 60, true);
              OffsetClipRgn(Canvas.Handle, 1, 2);
              AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 30, true);
            end;

            RestoreDC(Canvas.Handle, LDCState);

            LTmpBmp.Canvas.CopyRect(LTmpRect, Canvas, R);
            LMDDrawSmoothLine(LTmpBmp, LTmpRect.left, LTmpRect.Top, LTmpRect.Right - 1, LTmpRect.Top + AngledOffset + 1, Pen.Color);
            LMDDrawSmoothLine(LTmpBmp, LTmpRect.Right - 1, LTmpRect.Top + AngledOffset, LTmpRect.Right - 1, LTmpRect.Bottom - AngledOffset, Pen.Color);
            LMDDrawSmoothLine(LTmpBmp, LTmpRect.Right - 1, LTmpRect.Bottom - AngledOffset, LTmpRect.Left, LTmpRect.Bottom, Pen.Color);
            Canvas.CopyRect(R, LTmpBmp.Canvas, LTmpRect);
          end;
        etpBottom:
          with Canvas do
          begin
            LDCState := SaveDC(Canvas.Handle);

            LRgn := CreateRectRgnIndirect(R);
            if GetClipRgn(Canvas.Handle, LRgn) = 1 then
            begin
              OffsetClipRgn(Canvas.Handle, 5, -3);
              ExtSelectClipRgn(Canvas.Handle, LRgn, RGN_DIFF);
              OffsetClipRgn(Canvas.Handle, -2, 0);
            end;

            AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 60, true);
            OffsetClipRgn(Canvas.Handle, 1, -1);
            AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 30, true);

            if (FOwner.FPages.IndexOf(TabSheet) > FOwner.FPages.IndexOf(FOwner.FActivePage)) then
//            if (TabSheet <> FOwner.ActivePage) and (TabSheet <> FOwner.FirstTab) then
            begin
              OffsetClipRgn(Canvas.Handle, -((R.Right - R.Left) - (AngledOffset - 2)), -2);
              AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 60, true);
              OffsetClipRgn(Canvas.Handle, 2, -1);
              AlphaCopyRect(Canvas.Handle, R, LTmpBmp.Canvas.Handle, LTmpRect, 30, true);
            end;
            RestoreDC(Canvas.Handle, LDCState);
            LTmpBmp.Canvas.CopyRect(LTmpRect, Canvas, R);
            LMDDrawSmoothLine(LTmpBmp, LTmpRect.left, LTmpRect.Top, LTmpRect.Left + AngledOffset + 1, LTmpRect.Bottom - 1, Pen.Color);
            LMDDrawSmoothLine(LTmpBmp, LTmpRect.Left + AngledOffset, LTmpRect.Bottom - 1, LTmpRect.Right - AngledOffset, LTmpRect.Bottom - 1, Pen.Color);
            LMDDrawSmoothLine(LTmpBmp, LTmpRect.Right - AngledOffset, LTmpRect.Bottom - 1, LTmpRect.Right, LTmpRect.Top, Pen.Color);
            Canvas.CopyRect(R, LTmpBmp.Canvas, LTmpRect);
          end;
      end;
    finally
      FreeAndNil(LTmpBmp);
    end;
    InflateRect(r, -1, -1);
  end;
end;

procedure TElModernAngledTab.DrawTabLine(Canvas: TCanvas; R: TRect);
var
  ASheet: TElTabSheet;
  R1: TRect;
begin
  ASheet := FOwner.ActivePage;

  with Canvas do
    case FOwner.TabPosition of
      etpTop:
        begin
          if ASheet.UseTabColor then
          begin
            Pen.Color := ColorDarker(ASheet.FTabColor, 70);
            Pen.Width := 2;
          end
          else
            Pen.Color := cl3DDkShadow;

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Bottom - 1);
            LineTo(R.Right, R.Bottom - 1);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Bottom - 1);
              LineTo(ASheet.FRect.Left { - 2}, R.Bottom - 1);
            end;
            if ASheet.FRect.Right - 1 < R.Right then
            begin
              MoveTo(ASheet.FRect.Right{ + 1}, R.Bottom - 1);
              LineTo(R.Right, R.Bottom - 1);
            end;
          end;
        end;
      etpBottom:
        begin
          if FOwner.Flat then
            R.Bottom := R.Top + 1
          else
            R.Bottom := R.Top + 2;

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            if FOwner.Flat then
              DrawEdge(Handle, R, BDR_RAISEDINNER, BF_BOTTOM)
            else
              DrawEdge(Handle, R, BDR_RAISED, BF_BOTTOM);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              R1 := Rect(R.Left, R.Top, ASheet.FRect.Left + 1, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_BOTTOM)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_BOTTOM);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              R1 := Rect(ASheet.FRect.Right - 1, R.Top, R.Right, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_BOTTOM)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_BOTTOM);
            end;
          end;

          if FOwner.ShowBorder then
          begin
            Pixels[R.Left, R.Bottom - 1] := clBtnHighlight;
            Pixels[R.Left, R.Bottom - 2] := clBtnHighlight;
            if FOwner.Flat then
              Pixels[R.Right - 1, R.Bottom - 2] := clBtnShadow
            else
              Pixels[R.Right - 1, R.Bottom - 2] := cl3DDkShadow;
          end;
        end;
      etpLeft:
        begin
          Canvas.Pen.Color := clRed;
          Canvas.Pen.Color := clBtnHighlight;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Right - 1, R.Top);
            LineTo(R.Right - 1, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Right - 1, R.Top);
              LineTo(R.Right - 1, ASheet.FRect.Top + 1);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Right - 1, ASheet.FRect.Bottom + 1);
              LineTo(R.Right - 1, R.Bottom);
            end;
          end;
          if FOwner.ShowBorder then
          begin
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
          end;
          inc(R.Bottom);
        end;
      etpRight:
        begin
          if FOwner.Flat then
            R.Right := R.Left + 1
          else
            R.Right := R.Left + 2;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            if FOwner.Flat then
              DrawEdge(Handle, R, BDR_RAISEDINNER, BF_RIGHT)
            else
              DrawEdge(Handle, R, BDR_RAISED, BF_RIGHT);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              R1 := Rect(R.Left, R.Top, R.Right, ASheet.FRect.Top + 1);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_RIGHT)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_RIGHT);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              R1 := Rect(R.Left, ASheet.FRect.Bottom - 1, R.Right, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_RIGHT)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_RIGHT);
            end;
          end;

          if FOwner.ShowBorder then
          begin
            Pixels[R.Right - 2, R.Top] := clBtnHighlight;
            Pixels[R.Right - 1, R.Top] := clBtnHighlight;
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 2, R.Bottom] := cl3DDkShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 2, R.Bottom] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
          end;
          inc(R.Bottom);
        end;
    end;
end;

procedure TElModernAngledTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet
  : TElTabSheet);
begin
  inherited;
  //if TabSheet = FOwner.FActivePage then
  case FOwner.TabPosition of
    etpTop:
      begin
        if After then
        begin
          dec(R.Right);
          dec(R.Bottom);
        end
        else
        begin
          inc(R.Right);
          inc(R.Bottom);
        end;
      end;
    etpBottom:
      begin
        if After then
        begin
          inc(R.Top);
          //inc(R.Bottom);
          //dec(R.Right);
        end
        else
        begin
          dec(R.Top);
          //dec(R.Bottom);
          // inc(R.Right);
        end;
      end;
    etpLeft:
      begin
        if After then
        begin
          //dec(R.Left);
          dec(R.Right);
          //dec(R.Bottom);
        end
        else
        begin
          //inc(R.Left);
          inc(R.Right);
          //inc(R.Bottom);
        end;
      end;
    etpRight:
      begin
        if After then
        begin
          inc(R.Left, 2);
          //dec(R.Right);
          //dec(R.Bottom);
        end
        else
          dec(R.Left, 2);
          //inc(R.Right);
          //inc(R.Bottom);
      end;
  (*
  end
  else
  begin
    case FOwner.TabPosition of
      etpBottom:
        begin
        end;
      etpRight:
        begin
        end;
    end;
  *)
  end;
end;

procedure TElModernAngledTab.AdjustDrawingSize(Active: boolean; var R: TRect);
var
  FPageControl: TElPageControl;
begin
  //if Active then
  begin
    FPageControl := FOwner;
    case FPageControl.TabPosition of
      etpLeft:
        begin
          //inc(R.Right);
          dec(R.Left, GetAscend);
          inc(R.Bottom, GetOuterMargin);
          dec(R.Top, GetOuterMargin);
        end;
      etpTop:
        begin
          //inc(R.Top);
          dec(R.Top, GetAscend);
          dec(R.Left, GetOuterMargin);
          inc(R.Right, GetOuterMargin);
        end;
      etpRight:
        begin
          //dec(R.Left);
          inc(R.Right, GetAscend);
          inc(R.Bottom, GetOuterMargin);
          dec(R.Top, GetOuterMargin);
        end;
      etpBottom:
        begin
          dec(R.Top);
          inc(R.Bottom, GetAscend);
          dec(R.Left, GetOuterMargin);
          inc(R.Right, GetOuterMargin);
        end;
    end;
  end;
end;

procedure TElModernAngledTab.AdjustTabSize(var Size: TSize);
begin
  if FOwner.TabPosition in [etpLeft, etpRight] then
  begin
    Size.cy := Size.cy + 2 + AngledOffset;
    Size.cx := Size.cx + 2;
  end
  else
  begin
    Size.cx := Size.cx + 2 + AngledOffset;
    Size.cy := Size.cy + 2;
  end;
end;

procedure TElModernAngledTab.FillTab(Canvas: TCanvas; Rect: TRect; TabSheet:TElTabSheet);
var

  ACtl: TWinControl;
  BgRect: TRect;
  Color1, Color2, Color3, Color4: TColor;
  Points: array[0..4] of TPoint;
  r: TRect;
  NRgn: HRgn;
  pc: integer;
  LGrStyle: TLMDGradientStyle;
begin
  R := Rect;
  AdjustFillSize(false, Rect, TabSheet);

  CreateTabPoints(R, Points);
  pc := 4;
//  if (TabSheet <> FOwner.FActivePage) and
//    (TabSheet <> FOwner.FirstTab) then
  if (FOwner.FPages.IndexOf(TabSheet) > FOwner.FPages.IndexOf(FOwner.FActivePage)) then
  begin
    case FOwner.TabPosition of
      etpLeft:
        begin
          Points[3] := Point(R.Left + (R.Right - R.Left) div 2, R.Top +
            AngledOffset div 2);
          Points[4] := Point(R.Right, R.Top + AngledOffset - 1);
        end;
      etpTop:
        begin
          Points[0] := Point((R.Left + AngledOffset div 2) - 1, (R.Top + (R.Bottom - R.Top) div 2) + 1);
          Points[4] := Point(R.Left + AngledOffset - 1, R.Bottom);
        end;
      etpRight:
        begin
          Points[0] := Point(R.Left + (R.Right - R.Left - 1) div 2, R.Top +
            AngledOffset div 2);
          Points[4] := Point(R.Left, R.Top + AngledOffset - 1);
        end;
      etpBottom:
        begin
          Points[0] := Point(R.Left + AngledOffset div 2, R.Top + (R.Bottom -
            R.Top) div 2);
          Points[4] := Point(R.Left + AngledOffset, R.Top);
        end;
    end;
    pc := 5;
  end;

  SaveDCState := SaveDC(Canvas.Handle);
  NRgn := CreatePolygonRgn(Points, pc, WINDING);
  SelectClipRgn(Canvas.Handle, NRgn);

  if (FOwner.FImgForm = nil) or (csDesigning in
    FOwner.ComponentState) then

  begin
    Canvas.Brush.Style := bsSolid;
    if FOwner.TabPosition in [etpTop, etpBottom] then
      LGrStyle := gstVertical
    else
      LGrStyle := gstHorizontal;
    if TabSheet.UseTabColor then
      Canvas.Brush.Color := TabSheet.TabColor
    else
      if TabSheet = FOwner.FActivePage then
      Canvas.Brush.Color := FOwner.FActiveTabColor
    else
      Canvas.Brush.Color := FOwner.FInactiveTabColor;

    if TabSheet.UseTabColor then
      Canvas.Brush.Color := TabSheet.FTabColor;
    if FOwner.TabPosition in [etpTop, etpLeft] then
    begin
      Color2 := TabSheet.Color;
      Color1 := TabSheet.FTabColor;
      Color3 := clBtnHighlight;
      Color4 := clBtnFace;
    end
    else
    begin
      Color1 := TabSheet.Color;
      Color2 := TabSheet.FTabColor;
      Color4 := clBtnHighlight;
      Color3 := clBtnFace;
    end;
    if TabSheet = FOwner.FActivePage then
      LMDGradientPaint(Canvas, Rect, Color1, Color2, 20, LGrStyle, 0, 0)
    else
      if TabSheet.UseTabColor then
        LMDGradientPaint(Canvas.Handle, Rect, Color1, Color2, 20, LGrStyle, 0, 0)
      else
        LMDGradientPaint(Canvas.Handle, Rect, Color3, Color4, 20, LGrStyle, 0, 0);

//    GradientFill(Canvas.Handle, Types.Rect(Rect.Left, Rect.Top, Rect.Right, Rect.Top + 3), clActiveCaption, clGradientActiveCaption, 3, true);
//    GradientFill(Canvas.Handle, Rect, clBtnHighlight, clBtnShadow, 20, true);
    Canvas.Brush.Style := bsClear;

  end
  else
    if TabSheet = FOwner.FActivePage then
  begin
    if (FOwner.FImgForm.Control <> FOwner) then
    begin
      ACtl := FOwner.FImgForm.GetRealControl;

      BgRect.Left := FOwner.Left;
      BgRect.Top := FOwner.Top;

      BgRect.TopLeft :=
        FOwner.Parent.ClientToScreen(BgRect.TopLeft);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);

      FOwner.FImgForm.PaintBkgnd(Canvas.Handle, Rect,
        BgRect.TopLeft, false);
    end;

  end;
  DeleteObject(NRgn);
  AdjustFillSize(true, Rect, TabSheet);
end;

function TElModernAngledTab.GetAscend: Integer;
begin
  Result := 1;
end;

function TElModernAngledTab.GetInnerMargin: Integer;
begin
  Result := -5;
end;

function TElModernAngledTab.GetOuterMargin: Integer;
begin
  Result := 4;
end;

function TElModernAngledTab.GetContentMargin: Integer;
begin
  Result := AngledOffset;
end;

procedure TElModernAngledTab.CreateTabPoints(R: TRect; var APoints: array of TPoint);
var
  LIdx: Integer;
begin
  LIdx := Low(APoints);
  case FOwner.TabPosition of
    etpLeft:
      begin
        APoints[LIdx] := Point(r.Right - 1, r.bottom + 1);
        Inc(LIdx);
        APoints[LIdx] := Point(r.left, r.bottom - AngledOffset {+ 1});
        Inc(LIdx);
        APoints[LIdx] := Point(r.left, r.top + AngledOffset {- 1});
        Inc(LIdx);
        APoints[LIdx] := Point(r.Right + 1, r.top - 1);
      end;
    etpTop:
      begin
        APoints[LIdx] := Point(r.left - 2, r.bottom);
        Inc(LIdx);
        APoints[LIdx] := Point(r.left + AngledOffset{ - 1}, r.top);
        Inc(LIdx);
        APoints[LIdx] := Point(r.right - AngledOffset{ + 1}, r.top);
        Inc(LIdx);
        APoints[LIdx] := Point(r.right + 1, r.bottom);
      end;
    etpRight:
      begin
        APoints[LIdx] := Point(r.left, r.top { - 1});
        Inc(LIdx);
        APoints[LIdx] := Point(r.right, r.top + AngledOffset {- 1});
        Inc(LIdx);
        APoints[LIdx] := Point(r.right, r.bottom - AngledOffset);
        Inc(LIdx);
        APoints[LIdx] := Point(r.left, r.bottom);
      end;
    etpBottom:
      begin
        APoints[LIdx] := Point(r.left {- 1}, r.top);
        Inc(LIdx);
        APoints[LIdx] := Point(r.left + AngledOffset {- 1}, r.bottom);
        Inc(LIdx);
        APoints[LIdx] := Point(r.right - AngledOffset + 1, r.bottom);
        Inc(LIdx);
        APoints[LIdx] := Point(r.right + 1, r.top);
      end;
  end;
end;

procedure TElModernAngledTab.FixupTab(Canvas: TCanvas; R: TRect; TabSheet:
  TElTabSheet);
begin
  RestoreDC(Canvas.Handle, SaveDCState);
end;

procedure TElModernAngledTab.AdjustFocusRect(var R: TRect);
begin
  if FOwner.TabPosition in [etpLeft, etpRight] then
  begin
    InflateRect(R, 0, -5);
  end
  else
  begin
    InflateRect(R, -5, 0);
  end;
  // AdjustDrawingSize(FOwner.FActivePage = TabSheet, R);
  inherited;
end;

{ ------------------------ TElAngledTab ---------------------------- }

function TElAngledTab.CanDrawTab(ActiveDraw: boolean): Boolean;
begin
  result := true //not ActiveDraw;
end;

procedure TElAngledTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet:
  TElTabSheet);
begin
  begin
    // if TabSheet = FOwner.FActivePage then
    begin
      Canvas.Pen.Color := clBtnShadow;

      case FOwner.TabPosition of
        etpLeft:
          with Canvas do
          begin
            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;

            MoveTo(r.right, r.bottom + 1);
            LineTo(r.left, r.bottom - AngledOffset);
            if not FOwner.Flat then
            begin
              Canvas.Pen.Color := clBtnShadow;
              MoveTo(r.right, r.bottom - 1);
              LineTo(r.left, r.bottom - AngledOffset - 1);
            end;

            Canvas.Pen.Color := clBtnHighlight;
            LineTo(r.left, r.top + AngledOffset);
            LineTo(R.right, r.top - 1);
          end;
        etpTop:
          with Canvas do
          begin
            Canvas.Pen.Color := clBtnHighlight;
            MoveTo(r.left, r.bottom - 1);
            LineTo(r.left + AngledOffset - 1, r.top);
            LineTo(r.right - AngledOffset, r.top);

            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;

            LineTo(r.right, r.bottom - 1);
            if not FOwner.Flat then
            begin
              Canvas.Pen.Color := clBtnShadow;
              MoveTo(r.right - 1, r.bottom - 1);
              LineTo(R.right - AngledOffset - 1, r.top);
            end;
          end;
        etpRight:
          with Canvas do
          begin
            Canvas.Pen.Color := clBtnHighlight;
            MoveTo(r.left, r.top);
            LineTo(r.right - 1, r.top + AngledOffset);

            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;

            LineTo(r.right - 1, r.bottom - AngledOffset);
            LineTo(r.left, r.bottom);

            if not FOwner.Flat then
            begin
              Canvas.Pen.Color := clBtnShadow;
              MoveTo(r.left, r.bottom - 1);
              LineTo(r.right - 1, r.bottom - AngledOffset - 1);
              MoveTo(r.right - 2, r.bottom - AngledOffset - 1);
              LineTo(r.right - 2, r.top + AngledOffset);
            end;
          end;
        etpBottom:
          with Canvas do
          begin
            (* highlight *)
            Canvas.Pen.Color := cl3DDkShadow;
            Canvas.Pen.Color := clBtnHighlight;

            MoveTo(r.left { - 1}, r.top);
            LineTo(r.left + AngledOffset {- 1}, r.bottom - 1);

            if FOwner.Flat then
              Pen.Color := clBtnShadow
            else
              Pen.Color := cl3DDkShadow;
            MoveTo(r.left + AngledOffset, r.bottom - 1);
            LineTo(r.right - AngledOffset, r.bottom - 1);
            LineTo(r.right, r.top);

            if not FOwner.Flat then
            begin
              Canvas.Pen.Color := clBtnShadow;
              MoveTo(r.left + AngledOffset + 1, r.bottom - 2);
              LineTo(r.right - AngledOffset, r.bottom - 2);
              MoveTo(r.right - 1, r.top);
              LineTo(r.right - AngledOffset - 1, r.bottom - 1);
            end;
          end;
      end;
    end;
    InflateRect(r, -1, -1);
  end;
end;

procedure TElAngledTab.DrawTabLine(Canvas: TCanvas; R: TRect);
var
  ASheet: TElTabSheet;
  R1: TRect;
begin
  ASheet := FOwner.ActivePage;

  with Canvas do
    case FOwner.TabPosition of
      etpTop:
        begin
          Pen.Color := clBtnHighlight;
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Bottom - 1);
            LineTo(R.Right, R.Bottom - 1);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Bottom - 1);
              LineTo(ASheet.FRect.Left { - 2}, R.Bottom - 1);
            end;
            if ASheet.FRect.Right - 1 < R.Right then
            begin
              MoveTo(ASheet.FRect.Right + 1, R.Bottom - 1);
              LineTo(R.Right, R.Bottom - 1);
            end;
          end;
        end;
      etpBottom:
        begin
          if FOwner.Flat then
            R.Bottom := R.Top + 1
          else
            R.Bottom := R.Top + 2;

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            if FOwner.Flat then
              DrawEdge(Handle, R, BDR_RAISEDINNER, BF_BOTTOM)
            else
              DrawEdge(Handle, R, BDR_RAISED, BF_BOTTOM);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              R1 := Rect(R.Left, R.Top, ASheet.FRect.Left + 1, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_BOTTOM)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_BOTTOM);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              R1 := Rect(ASheet.FRect.Right - 1, R.Top, R.Right, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_BOTTOM)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_BOTTOM);
            end;
          end;

          if FOwner.ShowBorder then
          begin
            Pixels[R.Left, R.Bottom - 1] := clBtnHighlight;
            Pixels[R.Left, R.Bottom - 2] := clBtnHighlight;
            if FOwner.Flat then
              Pixels[R.Right - 1, R.Bottom - 2] := clBtnShadow
            else
              Pixels[R.Right - 1, R.Bottom - 2] := cl3DDkShadow;
          end;
        end;
      etpLeft:
        begin
          Canvas.Pen.Color := clRed;
          Canvas.Pen.Color := clBtnHighlight;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Right - 1, R.Top);
            LineTo(R.Right - 1, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Right - 1, R.Top);
              LineTo(R.Right - 1, ASheet.FRect.Top + 1);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Right - 1, ASheet.FRect.Bottom + 1);
              LineTo(R.Right - 1, R.Bottom);
            end;
          end;
          if FOwner.ShowBorder then
          begin
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
          end;
          inc(R.Bottom);
        end;
      etpRight:
        begin
          if FOwner.Flat then
            R.Right := R.Left + 1
          else
            R.Right := R.Left + 2;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            if FOwner.Flat then
              DrawEdge(Handle, R, BDR_RAISEDINNER, BF_RIGHT)
            else
              DrawEdge(Handle, R, BDR_RAISED, BF_RIGHT);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              R1 := Rect(R.Left, R.Top, R.Right, ASheet.FRect.Top + 1);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_RIGHT)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_RIGHT);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              R1 := Rect(R.Left, ASheet.FRect.Bottom - 1, R.Right, R.Bottom);
              if FOwner.Flat then
                DrawEdge(Handle, R1, BDR_RAISEDINNER, BF_RIGHT)
              else
                DrawEdge(Handle, R1, BDR_RAISED, BF_RIGHT);
            end;
          end;

          if FOwner.ShowBorder then
          begin
            Pixels[R.Right - 2, R.Top] := clBtnHighlight;
            Pixels[R.Right - 1, R.Top] := clBtnHighlight;
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 2, R.Bottom] := cl3DDkShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 2, R.Bottom] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
          end;
          inc(R.Bottom);
        end;
    end;
end;

procedure TElAngledTab.AdjustFillSize(After: boolean; var R: TRect; TabSheet
  : TElTabSheet);
begin
  inherited;
  //if TabSheet = FOwner.FActivePage then
  case FOwner.TabPosition of
    etpTop:
      begin
        if After then
        begin
          dec(R.Right);
          dec(R.Bottom);
        end
        else
        begin
          inc(R.Right);
          inc(R.Bottom);
        end;
      end;
    etpBottom:
      begin
        if After then
        begin
          inc(R.Top);
          //inc(R.Bottom);
          //dec(R.Right);
        end
        else
        begin
          dec(R.Top);
          //dec(R.Bottom);
          // inc(R.Right);
        end;
      end;
    etpLeft:
      begin
        if After then
        begin
          //dec(R.Left);
          dec(R.Right);
          //dec(R.Bottom);
        end
        else
        begin
          //inc(R.Left);
          inc(R.Right);
          //inc(R.Bottom);
        end;
      end;
    etpRight:
      begin
        if After then
        begin
          inc(R.Left, 2);
          //dec(R.Right);
          //dec(R.Bottom);
        end
        else
          dec(R.Left, 2);
          //inc(R.Right);
          //inc(R.Bottom);
      end;
  (*
  end
  else
  begin
    case FOwner.TabPosition of
      etpBottom:
        begin
        end;
      etpRight:
        begin
        end;
    end;
  *)
  end;
end;

procedure TElAngledTab.AdjustDrawingSize(Active: boolean; var R: TRect);
var
  FPageControl: TElPageControl;
begin
  //if Active then
  begin
    FPageControl := FOwner;
    case FPageControl.TabPosition of
      etpLeft:
        begin
          //inc(R.Right);
          dec(R.Left, GetAscend);
          inc(R.Bottom, GetOuterMargin);
          dec(R.Top, GetOuterMargin);
        end;
      etpTop:
        begin
          //inc(R.Top);
          dec(R.Top, GetAscend);
          dec(R.Left, GetOuterMargin);
          inc(R.Right, GetOuterMargin);
        end;
      etpRight:
        begin
          //dec(R.Left);
          inc(R.Right, GetAscend);
          inc(R.Bottom, GetOuterMargin);
          dec(R.Top, GetOuterMargin);
        end;
      etpBottom:
        begin
          dec(R.Top);
          inc(R.Bottom, GetAscend);
          dec(R.Left, GetOuterMargin);
          inc(R.Right, GetOuterMargin);
        end;
    end;
  end;
end;

procedure TElAngledTab.AdjustTabSize(var Size: TSize);
begin
  if FOwner.TabPosition in [etpLeft, etpRight] then
  begin
    Size.cy := Size.cy + 2 + AngledOffset;
    Size.cx := Size.cx + 2;
  end
  else
  begin
    Size.cx := Size.cx + 2 + AngledOffset;
    Size.cy := Size.cy + 2;
  end;
end;

procedure TElAngledTab.FillTab(Canvas: TCanvas; Rect: TRect; TabSheet: TElTabSheet);
var

  ACtl: TWinControl;
  BgRect: TRect;

  Points: array[0..4] of TPoint;
  r: TRect;
  NRgn: HRgn;
  pc: integer;
begin
  R := Rect;
  AdjustFillSize(false, Rect, TabSheet);

  CreateTabPoints(R, Points);
  pc := 4;
//  if (TabSheet <> FOwner.FActivePage) and
//    (TabSheet <> FOwner.FirstTab) then
  if (FOwner.FPages.IndexOf(TabSheet) > FOwner.FPages.IndexOf(FOwner.FActivePage)) then
  begin
    case FOwner.TabPosition of
      etpLeft:
        begin
          Points[3] := Point(R.Left + (R.Right - R.Left) div 2, R.Top +
            AngledOffset div 2);
          Points[4] := Point(R.Right, R.Top + AngledOffset - 1);
        end;
      etpTop:
        begin
          Points[0] := Point(R.Left + AngledOffset div 2, R.Top + (R.Bottom -
            R.Top) div 2);
          Points[4] := Point(R.Left + AngledOffset, R.Bottom);
        end;
      etpRight:
        begin
          Points[0] := Point(R.Left + (R.Right - R.Left - 1) div 2, R.Top +
            AngledOffset div 2);
          Points[4] := Point(R.Left, R.Top + AngledOffset - 1);
        end;
      etpBottom:
        begin
          Points[0] := Point(R.Left + AngledOffset div 2, R.Top + (R.Bottom -
            R.Top) div 2);
          Points[4] := Point(R.Left + AngledOffset, R.Top);
        end;
    end;
    pc := 5;
  end;

  SaveDCState := SaveDC(Canvas.Handle);
  NRgn := CreatePolygonRgn(Points, pc, WINDING);
  SelectClipRgn(Canvas.Handle, NRgn);

  if (FOwner.FImgForm = nil) or (csDesigning in
    FOwner.ComponentState) then

  begin
    Canvas.Brush.Style := bsSolid;
    if TabSheet.UseTabColor then
      Canvas.Brush.Color := TabSheet.TabColor
    else
      if TabSheet = FOwner.FActivePage then
      Canvas.Brush.Color := FOwner.FActiveTabColor
    else
      Canvas.Brush.Color := FOwner.FInactiveTabColor;
    FillRgn(Canvas.Handle, NRgn, Canvas.Brush.Handle);
    Canvas.Brush.Style := bsClear;

  end
  else
    if TabSheet = FOwner.FActivePage then
  begin
    if (FOwner.FImgForm.Control <> FOwner) then
    begin
      ACtl := FOwner.FImgForm.GetRealControl;

      BgRect.Left := FOwner.Left;
      BgRect.Top := FOwner.Top;

      BgRect.TopLeft :=
        FOwner.Parent.ClientToScreen(BgRect.TopLeft);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);

      FOwner.FImgForm.PaintBkgnd(Canvas.Handle, Rect,
        BgRect.TopLeft, false);
    end;

  end;
  DeleteObject(NRgn);
  AdjustFillSize(true, Rect, TabSheet);
end;

function TElAngledTab.GetAscend: Integer;
begin
  Result := 2;
end;

function TElAngledTab.GetInnerMargin: Integer;
begin
  Result := -5;
end;

function TElAngledTab.GetOuterMargin: Integer;
begin
  Result := 4;
end;

function TElAngledTab.GetContentMargin: Integer;
begin
  Result := AngledOffset;
end;

procedure TElAngledTab.CreateTabPoints(R: TRect; var APoints: array of TPoint);
var
  LIdx: Integer;
begin
  LIdx := Low(APoints);
  case FOwner.TabPosition of
    etpLeft:
      begin
        APoints[LIdx] := Point(r.right, r.bottom + 1);
        Inc(LIdx);
        APoints[LIdx] := Point(r.left, r.bottom - AngledOffset {+ 1});
        Inc(LIdx);
        APoints[LIdx] := Point(r.left, r.top + AngledOffset {- 1});
        Inc(LIdx);
        APoints[LIdx] := Point(r.right, r.top - 1);
      end;
    etpTop:
      begin
        APoints[LIdx] := Point(r.left - 1, r.bottom);
        Inc(LIdx);
        APoints[LIdx] := Point(r.left + AngledOffset - 1, r.top);
        Inc(LIdx);
        APoints[LIdx] := Point(r.right - AngledOffset + 1, r.top);
        Inc(LIdx);
        APoints[LIdx] := Point(r.right + 1, r.bottom);
      end;
    etpRight:
      begin
        APoints[LIdx] := Point(r.left, r.top { - 1});
        Inc(LIdx);
        APoints[LIdx] := Point(r.right, r.top + AngledOffset {- 1});
        Inc(LIdx);
        APoints[LIdx] := Point(r.right, r.bottom - AngledOffset);
        Inc(LIdx);
        APoints[LIdx] := Point(r.left, r.bottom);
      end;
    etpBottom:
      begin
        APoints[LIdx] := Point(r.left {- 1}, r.top);
        Inc(LIdx);
        APoints[LIdx] := Point(r.left + AngledOffset {- 1}, r.bottom);
        Inc(LIdx);
        APoints[LIdx] := Point(r.right - AngledOffset + 1, r.bottom);
        Inc(LIdx);
        APoints[LIdx] := Point(r.right + 1, r.top);
      end;
  end;
end;

procedure TElAngledTab.FixupTab(Canvas: TCanvas; R: TRect; TabSheet:
  TElTabSheet);
begin
  RestoreDC(Canvas.Handle, SaveDCState);
end;

procedure TElAngledTab.AdjustFocusRect(var R: TRect);
begin
  if FOwner.TabPosition in [etpLeft, etpRight] then
  begin
    InflateRect(R, 0, -5);
  end
  else
  begin
    InflateRect(R, -5, 0);
  end;
  // AdjustDrawingSize(FOwner.FActivePage = TabSheet, R);
  inherited;
end;

{ TElBitmapTab }

procedure TElBitmapTab.AdjustFillSize(After: boolean; var R: TRect;
  TabSheet: TElTabSheet);
begin
  inherited;
//  Inc(R.Bottom, FTab.Height);
//  Dec(R.Top, FTab.Width);
end;

procedure TElBitmapTab.AdjustTabSize(var Size: TSize);
begin
  inherited;
  case FOwner.TabPosition of
  etpTop, etpBottom:
  begin
    if Size.cx < FTab.Width then
      Size.cx := FTab.Width;
    Size.cy := FTab.Height;
  end;
  etpRight, etpLeft:
  begin
    if Size.cy < FTab.Width then
      Size.cy := FTab.Width;
    Size.cx := FTab.Height;
  end;
  end;
end;

procedure TElBitmapTab.DrawCloseButton(Canvas: TCanvas; var R: TRect; TabSheet: TElTabSheet);
const
  HMargin = Margin div 2;
var
//  iStateId: integer;
  sx, sy: integer;
  tr: Trect;
begin
  if Assigned(FCloseButton) and not FCloseButton.Empty then
  begin
    sx := FCloseButton.Width;
    sy := FCloseButton.Height;
  end
  else
  begin
    sx := GetSystemMetrics(SM_CXSMSIZE); //SM_CXMENUSIZE);
    sy := GetSystemMetrics(SM_CYSMSIZE); //SM_CYMENUSIZE);
  end;
  if R.Bottom - R.Top - Margin < sy then
  begin
    dec(sx, (sy - (R.Bottom - R.Top - Margin)));
    dec(sy, (sy - (R.Bottom - R.Top - Margin)));
    if sx < 0 then sx := 0;
    if sy < 0 then sy := 0;
  end;
  case FOwner.TabPosition of
    etpTop:
      begin
        TabSheet.FCloseBtnRect := Rect(R.Right - HMargin - sx - 1,
          R.Top + HMargin,
          R.Right - HMargin - 1,
          R.Top + HMargin + sy);
          R.Right := TabSheet.FCloseBtnRect.Left;
      end;
    etpBottom:
      begin
        TabSheet.FCloseBtnRect := Rect(R.Right - HMargin - sy - 1,
          R.Bottom - HMargin - sy,
          R.Right - HMargin - 1,
          R.Bottom - HMargin);
          R.Right := TabSheet.FCloseBtnRect.Left;
        end;
    etpLeft:
      begin
        TabSheet.FCloseBtnRect := Rect(R.Left + HMargin + 1,
          R.Top + HMargin,
          R.Left - HMargin + sx + 1,
          R.Top - HMargin + sy);
          R.Top := TabSheet.FCloseBtnRect.Bottom;
      end;
    etpRight:
      begin
        TabSheet.FCloseBtnRect := Rect(R.Right + HMargin - sy - 1,
          R.Bottom + HMargin - sy,
          R.Right - HMargin - 1,
          R.Bottom - HMargin);
          R.Bottom := TabSheet.FCloseBtnRect.Top;
      end;
  end;

  tr := TabSheet.FCloseBtnRect;
  if Assigned(FCloseButton) and not FCloseButton.Empty then
  begin
    with TabSheet do
      if FCloseBtnDown and (PageIndex > -1) and (PageIndex = FPageControl.ActivePageIndex) then
        OffsetRect(tr, 1, 1);
    LMDTransparentBlt(Canvas.Handle, tr.Left, tr.Top, tr.Right - tr.Left, tr.Bottom - tr.Top, FCloseButton.Canvas.Handle, 0, 0, FCloseButton.Width, FCloseButton.Height, FCloseButton.TransparentColor);
//    Canvas.Draw(tr.Left, tr.Top, FCloseButton);
  end
  else
    if IsThemed then
    begin
      DrawThemedCloseButton(Canvas, tr, TabSheet);
    end
    else
    begin
      DrawButtonFrameEx3(Canvas.Handle, tr, not FOwner.Flat,
        TabSheet.CloseBtnEnabled and TabSheet.FCloseBtnDown and (TabSheet.PageIndex = FOwner.ActivePageIndex),
        FOwner.Color, false, AllBorderSides);
      if TabSheet.CloseBtnEnabled then
      begin
        Canvas.Pen.Color := clBtnText;
        with Canvas do
          with tr do
          begin
            MoveTo(Left + 1 + 3, Top + 1 + 3);
            LineTo(Right - 1 - 4, Bottom - 1 - 4);
            MoveTo(Left + 1 + 3, Bottom - 1 - 5);
            LineTo(Right - 1 - 4, Top + 1 + 2);
            MoveTo(Left + 1 + 3 + 1, Top + 1 + 3);
            LineTo(Right - 1 - 4 + 1, Bottom - 1 - 4);
            MoveTo(Left + 1 + 3 + 1, Bottom - 1 - 5);
            LineTo(Right - 1 - 4 + 1, Top + 1 + 2);
          end;
      end
      else
      begin
        Canvas.Pen.Color := clBtnHighlight;
        OffsetRect(tr, 1, 1);
        with Canvas do
          with tr do
          begin
            MoveTo(Left + 1 + 3, Top + 1 + 3);
            LineTo(Right - 1 - 4, Bottom - 1 - 4);
            MoveTo(Left + 1 + 3, Bottom - 1 - 5);
            LineTo(Right - 1 - 4, Top + 1 + 2);
            MoveTo(Left + 1 + 3 + 1, Top + 1 + 3);
            LineTo(Right - 1 - 4 + 1, Bottom - 1 - 4);
            MoveTo(Left + 1 + 3 + 1, Bottom - 1 - 5);
            LineTo(Right - 1 - 4 + 1, Top + 1 + 2);
          end;
        Canvas.Pen.Color := clBtnShadow;
        OffsetRect(tr, -1, -1);
        with Canvas do
          with tr do
          begin
            MoveTo(Left + 1 + 3, Top + 1 + 3);
            LineTo(Right - 1 - 4, Bottom - 1 - 4);
            MoveTo(Left + 1 + 3, Bottom - 1 - 5);
            LineTo(Right - 1 - 4, Top + 1 + 2);
            MoveTo(Left + 1 + 3 + 1, Top + 1 + 3);
            LineTo(Right - 1 - 4 + 1, Bottom - 1 - 4);
            MoveTo(Left + 1 + 3 + 1, Bottom - 1 - 5);
            LineTo(Right - 1 - 4 + 1, Top + 1 + 2);
          end;
      end;
  end;
end;

procedure TElBitmapTab.DrawTab(Canvas: TCanvas; Active: Boolean; R: TRect);
const
  LBetween = 0;

var
  LSource, LTab: TBitmap;
  LTmpBmp: TBitmap;
  LMiddleBegin: Integer;

  procedure TransparentHorzTiledPaint(ACanvas: TCanvas; ALeft, ATop, AWidth: Integer; ABitmap: TBitmap);
  var
    i: Integer;
    LEnd: Integer;
  begin
    LEnd := (AWidth div (ABitmap.Width));
    for i := 0 to LEnd do
      Canvas.Draw(ALeft + (i * ABitmap.Width), ATop, ABitmap);
  end;

  procedure TransparentVertTiledPaint(ACanvas: TCanvas; ALeft, ATop, AHeight: Integer; ABitmap: TBitmap);
  var
    i: Integer;
    LEnd: Integer;
  begin
    LEnd := (AHeight div (ABitmap.Height));
    for i := 0 to LEnd do
      Canvas.Draw(ALeft, ATop + (i * ABitmap.Height), ABitmap);
  end;

begin
  if Active then
    LSource := FActiveTab
  else
    LSource := FTab;

  LTab := TBitmap.Create;

  LTmpBmp := TBitmap.Create;
  LTmpBmp.TransparentColor := LSource.TransparentColor;
  LTmpBmp.TransparentMode := LSource.TransparentMode;
  LTmpBmp.Transparent := LSource.Transparent;

  case FOwner.TabPosition of
    etpTop, etpBottom:
    begin
      LTmpBmp.Height := LSource.Height;
      LMiddleBegin := (LSource.Width div 2);
      LTmpBmp.Width := LMiddleBegin;

      if FOwner.TabPosition = etpBottom then
      begin
        LMDBmpRotate(LSource, LTab, Pi); // rotate on 180 degrees
        LMDBmpFlipVertical(LSource, LTab);
      end
      else
        LTab.Assign(LSource);

      // Begin of Tab
      LTmpBmp.Canvas.CopyRect(Rect(0, 0, LTmpBmp.Width, LTmpBmp.Height), LTab.Canvas, Rect(0, 0, LTmpBmp.Width, LTmpBmp.Height));
      Canvas.Draw(R.Left, R.Top - 1, LTmpBmp);

      // End of Tab
      LTmpBmp.Canvas.CopyRect(Rect(0, 0, LTmpBmp.Width, LTmpBmp.Height), LTab.Canvas, Rect(LTmpBmp.Width + 2, 0, LTab.Width, LTab.Height));
      Canvas.Draw((R.Right - LTmpBmp.Width) + LBetween, R.Top - 1, LTmpBmp);

      // Middle of Tab
      LTmpBmp.Width := 2;
      LTmpBmp.Canvas.CopyRect(Rect(0, 0, 2, LTmpBmp.Height), LTab.Canvas, Rect(LMiddleBegin, 0, LMiddleBegin + 2, LTab.Height));
      TransparentHorzTiledPaint(Canvas, (R.Left + LMiddleBegin), R.Top - 1, (R.Right - R.Left) - (LMiddleBegin * 2) + LBetween, LTmpBmp);
    end;
    etpRight, etpLeft:
    begin
      LTmpBmp.Width := LSource.Height;
      LMiddleBegin := (LSource.Width div 2);
      LTmpBmp.Height := LMiddleBegin;

      if FOwner.TabPosition = etpLeft then
      begin
        LMDBmpRotate(LSource, LTab, 90 * Pi / 180); // rotate on 90 degrees
        LMDBmpFlipVertical(LTab, LTab);
      end
      else
        LMDBmpRotate(LSource, LTab, 270 * Pi / 180); // rotate on 270 degrees

      // Begin of Tab
      LTmpBmp.Canvas.CopyRect(Rect(0, 0, LTmpBmp.Width, LTmpBmp.Height), LTab.Canvas, Rect(0, 0, LTmpBmp.Width, LTmpBmp.Height));
      Canvas.Draw(R.Left - 1, R.Top, LTmpBmp);

      // End of Tab
      LTmpBmp.Canvas.CopyRect(Rect(0, 0, LTmpBmp.Width, LTmpBmp.Height), LTab.Canvas, Rect(0, LTmpBmp.Height + 2, LTab.Width, LTab.Height));
      Canvas.Draw(R.Left - 1, (R.Bottom - LTmpBmp.Height) + LBetween, LTmpBmp);

      // Middle of Tab
      LTmpBmp.Height := 2;
      LTmpBmp.Canvas.CopyRect(Rect(0, 0, LTmpBmp.Width, 2), LTab.Canvas, Rect(0, LMiddleBegin, LTab.Width, LMiddleBegin + 2));
      TransparentVertTiledPaint(Canvas, R.Left - 1, R.Top + (LMiddleBegin - 1), (R.Bottom - R.Top) - (LMiddleBegin * 2) + LBetween, LTmpBmp);
    end;
  end;
  LTmpBmp.Free;
  LTab.Free;
end;

procedure TElBitmapTab.DrawTabEdges(Canvas: TCanvas; var R: TRect; TabSheet: TElTabSheet);
begin
//  Inherited;
end;

procedure TElBitmapTab.FillTab(Canvas: TCanvas; Rect: TRect;
  TabSheet: TElTabSheet);
begin
  inherited;
  AdjustFillSize(False, Rect, TabSheet);
  DrawTab(Canvas, Boolean(TabSheet = FOwner.ActivePage), Rect)
end;

function TElBitmapTab.GetContentMargin: Integer;
begin
  Result := Margin; //17
end;

function TElBitmapTab.GetOuterMargin: Integer;
begin
  Result := 0;
end;

function TElBitmapTab.GetInnerMargin: Integer;
begin
  Result := 0;
end;

constructor TElBitmapTab.Create(Owner: TElPageControl);
begin
  inherited;
  FTab := TBitmap.Create;
  FActiveTab := TBitmap.Create;
  FCloseButton := TBitmap.Create;
  FTab.TransparentMode := tmFixed;
  FTab.Transparent := True;
  FActiveTab.TransparentMode := tmFixed;
  FActiveTab.Transparent := True;
end;

destructor TElBitmapTab.Destroy();
begin
  if Assigned(FTab) then
    FreeAndNil(FTab);
  if Assigned(FActiveTab) then
    FreeAndNil(FActiveTab);
  if Assigned(FCloseButton) then
    FreeAndNil(FCloseButton);
  inherited;
end;

procedure TElBitmapTab.DrawTabLine(Canvas: TCanvas; R: TRect);
var
  ASheet: TElTabSheet;
  R1: TRect;
begin
  ASheet := FOwner.ActivePage;
  if IsThemed then
  begin
    case FOwner.TabPosition of
      etpTop:
        begin
          R.Top := R.Bottom - 1;
          inc(R.Bottom, 2);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            // InflateRect(R1, 1, 0);

            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
            end;
        end;
      etpBottom:
        begin
          if FOwner.Flat then
            R.Bottom := R.Top + 1
          else
            R.Bottom := R.Top + 2;
          dec(R.Top);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(ASheet.FRect.Left, R.Top, ASheet.FRect.Right, R.Bottom);
            // InflateRect(R1, 1, 0);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
            end;
        end;
      etpLeft:
        begin
          R.Left := R.Right - 2;
          //inc(R.Right);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            InflateRect(R1, 0, 1);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
            end;
        end;
      etpRight:
        begin
          if FOwner.Flat then
            R.Right := R.Left + 1
          else
            R.Right := R.Left + 2;
          dec(R.Left, 1);
          if (ASheet <> nil) and ASheet.FShown then
          begin
            R1 := Rect(R.Left, ASheet.FRect.Top, R.Right, ASheet.FRect.Bottom);
            InflateRect(R1, 0, 1);
            with R1 do
            ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
            end;
        end;
    end;
    LMDThemeServices.DrawElement(FOwner.UseThemeMode, Canvas.Handle, ttBody, R, nil);
//    DrawThemeBackground(TabTheme, Canvas.Handle, TABP_PANE, 0, R, nil);
    exit;
  end;
  ASheet := FOwner.ActivePage;
  with Canvas do
    case FOwner.TabPosition of
      etpTop:
        begin
          Pen.Color := clBtnHighlight;
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Bottom - 1);
            LineTo(R.Right, R.Bottom - 1);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Bottom - 1);
              LineTo(ASheet.FRect.Left, R.Bottom - 1);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              MoveTo(ASheet.FRect.Right, R.Bottom - 1);
              LineTo(R.Right, R.Bottom - 1);
            end;
          end;
        end;
      etpBottom:
        begin
          if not FOwner.Flat then
            Pen.Color := cl3DDkShadow
          else
            Pen.Color := clBtnShadow;
          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Top);
            LineTo(R.Right, R.Top);
          end
          else
          begin
            if ASheet.FRect.Left > 0 then
            begin
              MoveTo(R.Left, R.Top);
              LineTo(ASheet.FRect.Left, R.Top);
            end;
            if ASheet.FRect.Right < R.Right then
            begin
              MoveTo(ASheet.FRect.Right + 1, R.Top);
              LineTo(R.Right, R.Top);
            end;
          end;
        end;
      etpLeft:
        begin
          Pen.Color := clBtnHighlight;
          Dec(R.Bottom);

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Right - 1, R.Top);
            LineTo(R.Right - 1, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Right - 1, R.Top);
              LineTo(R.Right - 1, ASheet.FRect.Top);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Right - 1, ASheet.FRect.Bottom);
              LineTo(R.Right - 1, R.Bottom);
            end;
          end;
          if FOwner.ShowBorder then
          begin
            if not FOwner.Flat then
            begin
              Pixels[R.Right - 1, R.Bottom - 1] := clBtnShadow;
              Pixels[R.Right - 1, R.Bottom] := cl3DDkShadow;
            end
            else
            begin
              Pixels[R.Right - 1, R.Bottom] := clBtnShadow;
            end;
            end;
          inc(R.Bottom);
        end;
      etpRight:
        begin
          if not FOwner.Flat then
            Pen.Color := cl3DDkShadow
          else
            Pen.Color := clBtnShadow;

          if (ASheet = nil) or (not ASheet.FShown) then
          begin
            MoveTo(R.Left, R.Top);
            LineTo(R.Left, R.Bottom);
          end
          else
          begin
            if ASheet.FRect.Top > 0 then
            begin
              MoveTo(R.Left, R.Top);
              LineTo(R.Left, ASheet.FRect.Top);
            end;
            if ASheet.FRect.Bottom < R.Bottom then
            begin
              MoveTo(R.Left, ASheet.FRect.Bottom + 1);
              LineTo(R.Left, R.Bottom);
            end;
          end;
        end;
    end;
end;

procedure TElPageControl.CMVisiblechanged(var Message: TMessage);
const
  ShowFlags: array[Boolean] of Word = (
    SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_NOACTIVATE + SWP_HIDEWINDOW,
    SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_NOACTIVATE + SWP_SHOWWINDOW);
begin
  inherited;
  SetWindowPos(Handle, 0, 0, 0, 0, 0, ShowFlags[Visible]);
end;

function TElPageControl.IsFontStored: boolean;
begin
  Result := not ParentFont;
end;

procedure TElPageControl.DoThemeChanged;
begin
  inherited;
  if HandleAllocated then
  begin
    SetWindowPos(
      Handle,
      0,
      0, 0, 0, 0,
      SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER
      );
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
    Realign;
  end;
end;

initialization

  // TotalRepaints := 0;

finalization

end.
