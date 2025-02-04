unit sSkinProvider;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//{$DEFINE ACDEBUG}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, sDefaults, menus, ExtCtrls, Buttons, Controls,
  {$IFDEF DELPHI_XE2} UITypes,   {$ENDIF}
  {$IFDEF DELPHI7UP}  Types, Themes, UxTheme,  {$ENDIF}
  {$IFDEF FPC}        LMessages, {$ENDIF}
  {$IFDEF TNTUNICODE} TntWideStrUtils, TntMenus, TntStdCtrls, TntControls, {$ENDIF}
  acntTypes, sConst, sCommondata, acSBUtils,
  sMaskData, sSkinMenus, sSkinManager, acGlow, acThdTimer, acTitleBar, sStyleSimply;

type
{$IFNDEF NOTFORHELP}
  TacLabelColor = record
    Color:      TColor;
    Control:    TControl;
    ParentFont: boolean;
  end;


  TacFormsCouple = record
    Slave,
    Master: TForm;
    Pos: TPoint;
  end;


  TacGraphItem = class(TPersistent)
  public
    Adapter:  TObject;
    Ctrl:     TControl;
    SkinData: TsCommonData;
    Handler:  TacSpeedButtonHandler;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure DoHook(Control: TControl);
  end;


  TacCtrlAdapter = class;
  TacAdapterItem = class(TPersistent)
  protected
    COC: integer;
    Initializing: boolean;
    Adapter: TacCtrlAdapter;
  public
    WinCtrl: TWinControl;
    ScrollWnd: TacMainWnd;
    destructor Destroy; override;
    constructor Create(AAdapter: TacCtrlAdapter; ACtrl: TWinControl); virtual;
    procedure DoHook(Control: TWinControl; SkinParams: TacSkinParams; AThirdLists: TStringLists);
  end;

  PacSkinParams = ^TacSkinParams;

  TsSkinProvider = class;
  TacBorderForm  = class;
  TacSBAnimation = class;

  TacNCHitTest = procedure(var Msg: TWMNcHitTest) of object;
  TacAnimEvent = (aeShowing, aeHiding, aeSkinChanging);
{$ENDIF}

  TsGripMode = (gmNone, gmRightBottom);
  TsResizeMode = (rmStandard, rmBorder);

  TacAfterAnimation = procedure(AnimType: TacAnimEvent) of object;
  TAddItemEvent     = procedure(Item: TComponent; var CanBeAdded: boolean; var SkinSection: string)   of object;
  TAddItemExEvent   = procedure(Item: TComponent; var CanBeAdded: boolean; SkinParams: PacSkinParams) of object;

{$IFNDEF NOTFORHELP}
  TsSystemMenu = class;

  TsCaptionButton = record
    cpState,
    cpGlowID: integer;

    cpRect: TRect;
    cpHitCode: Cardinal;
    cpTimer: TacSBAnimation;
    cpHaveAlignment: boolean;
    cpGlyphType: TacTitleGlyph;
  end;

  PsCaptionButton = ^TsCaptionButton;

  TacAddedTitle = class(TPersistent)
  private
    FShowMainCaption: boolean;
    procedure SetShowMainCaption(const Value: boolean);
  protected
    FFont: TFont;
    FText: acString;
    procedure SetText(const Value: acString);
    procedure SetFont(const Value: TFont);
    procedure Repaint;
  public
    FOwner: TsSkinProvider;
    function FontIsStored: boolean;
    constructor Create; virtual;
    destructor Destroy; override;
  published
    property Font: TFont read FFont write SetFont stored FontIsStored;
    property Text: acString read FText write SetText;
    property ShowMainCaption: boolean read FShowMainCaption write SetShowMainCaption default True;
  end;
{$ENDIF} // NOTFORHELP


  TsTitleButton = class(TCollectionItem)
{$IFNDEF NOTFORHELP}
  private
    FOnMouseUp,
    FOnMouseDown: TMouseEvent;

    FEnabled,
    FVisible,
    FUseSkinData: boolean;

    FName: string;
    FGlyph: TBitmap;
    FHint: acString;
    procedure SetName   (const Value: string);
    procedure SetGlyph  (const Value: TBitmap);
    procedure SetVisible(const Value: boolean);
    procedure MouseDown(BtnIndex: integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseUp  (BtnIndex: integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnGlyphChange(Sender: TObject);
  public
    HintWnd: {$IFDEF TNTUNICODE}TTntCustomHintWindow{$ELSE}THintWindow{$ENDIF};
    Data: TsCaptionButton;
    destructor Destroy; override;
    function GetDisplayName: string; override;
    procedure AssignTo(Dest: TPersistent); override;
    constructor Create(ACollection: TCollection); override;
  published
{$ENDIF} // NOTFORHELP
    property Enabled: boolean read FEnabled write FEnabled default True;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property Hint: acString read FHint write FHint;
    property Name: string read FName write SetName;
    property UseSkinData: boolean read FUseSkinData write FUseSkinData default True;
    property Visible: boolean read FVisible write SetVisible default True;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseUp:   TMouseEvent read FOnMouseUp   write FOnMouseUp;
  end;


  TsTitleButtons = class(TCollection)
{$IFNDEF NOTFORHELP}
  private
    FOwner: TsSkinProvider;
    function  GetItem(Index: Integer): TsTitleButton;
    procedure SetItem(Index: Integer; Value: TsTitleButton);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TsSkinProvider);
    destructor Destroy; override;
{$ENDIF} // NOTFORHELP
    property Items[Index: Integer]: TsTitleButton read GetItem write SetItem; default;
  end;


  TsTitleIcon = class (TPersistent)
{$IFNDEF NOTFORHELP}
  private
    FHeight,
    FWidth: integer;

    FOwner: TsSkinProvider;
    FGlyph: TBitmap;
    FVisible: boolean;
    procedure SetGlyph  (const Value: TBitmap);
    procedure SetVisible(const Value: boolean);
    procedure GlyphChanged(Sender: TObject);
  public
    constructor Create(AOwner: TsSkinProvider);
    destructor Destroy; override;
  published
{$ENDIF} // NOTFORHELP
    property Glyph:   TBitmap read FGlyph   write SetGlyph;
    property Height:  integer read FHeight  write FHeight    default 0;
    property Width:   integer read FWidth   write FWidth     default 0;
    property Visible: boolean read FVisible write SetVisible default True;
  end;


  TacBlurMode = (bmBlurBehind, bmAcrylicBlurBehind);


  TacSystemBlur = class(TPersistent)
{$IFNDEF NOTFORHELP}
  private
    FOwner: TsSkinProvider;
    FActive: boolean;
    FMode: TacBlurMode;
    procedure SetActive(const Value: boolean);
    procedure SetMode(const Value: TacBlurMode);
  public
    constructor Create(AOwner: TsSkinProvider);
    procedure UpdateBlurMode(Force: boolean = False);
  published
{$ENDIF} // NOTFORHELP
    property Active: boolean read FActive write SetActive default False;
    property Mode: TacBlurMode read FMode write SetMode default bmBlurBehind;
  end;


{$IFNDEF NOTFORHELP}
  TacMenuItemPos = (ipTop, ipBottom, ipBeforeClose);

  TacSysSubMenu = class(TPersistent)
  private
    FCaption: string;
    FPosition: TacMenuItemPos;
    FPopupMenu: TPopupMenu;
  public
    constructor Create;//(AOwner: TsSkinProvider);
  published
    property Caption: string read FCaption write FCaption;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    property Position: TacMenuItemPos read FPosition write FPosition default ipBeforeClose;
  end;


  TacFormHeader = class(TPersistent)
  private
    FOwner: TsSkinProvider;
    FAdditionalHeight: integer;
    procedure SetAdditionalHeight(const Value: integer);
  public
    function ScaledAddHeight: integer;
    constructor Create(AOwner: TsSkinProvider);
  published
    property AdditionalHeight: integer read FAdditionalHeight write SetAdditionalHeight default 0;
  end;


  TacLabelsColors = array of TacLabelColor;
{$ENDIF} // NOTFORHELP

{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsSkinProvider = class(TComponent)
{$IFNDEF NOTFORHELP}
  private
    CurrentHT,
    UserBtnIndex,
    FSnapBuffer: integer;

    FUWPMode,
    FScreenSnap,
    FShowAppIcon,
    FMakeSkinMenu,
    FUseGlobalColor,
    FDisabledBlured,
    ControlsChanged,
    FAllowAnimation,
    FDrawClientArea,
    FAllowExtBorders,
    FirstInitialized,
    FAllowSkin3rdParty,
    FAllowBlendOnMoving,
    FDrawNonClientArea: boolean;

    FIconRect,
    FHintRect,
    LastMenuItemRect: TRect;

    FTitleSkin,
    FMenuLineSkin: TsSkinSection;

    FHintTimer:        TacTimer;
    FScaleThread:      TThread;
    FGripMode:         TsGripMode;
    FTitleIcon:        TsTitleIcon;
    FSystemBlur:       TacSystemBlur;
    FGluedForms:       TStringList;
    FResizeMode:       TsResizeMode;
    FAddedTitle:       TacAddedTitle;
    FSysSubMenu:       TacSysSubMenu;
    FTitleButtons:     TsTitleButtons;
    FCaptionAlignment: TAlignment;

    FOnSkinItem:       TAddItemEvent;
    FOnExtHitTest:     TacNCHitTest;
    FOnAfterAnimation: TacAfterAnimation;
    FOnSkinItemEx:     TAddItemExEvent;
    FFormHeader:       TacFormHeader;
    FThirdParty:       TsThirdPartyList;
    FDisabledBlendValue: byte;
    FDisabledBlendColor: TColor;

    procedure MDIMenuHook;
    procedure MDIMenuUnhook;

    procedure OnHintTimer(Sender: TObject);
    procedure StartHintTimer(TitleItem: TacTitleBarItem);
    procedure AnimChangeScale(NewPPI: integer; DoRecreate: boolean);
    procedure OnScaleTimer(Sender: TObject);

    procedure UpdateUWPMode;
    function GetLinesCount: integer; // Returns a count of menu lines
    procedure OnChildMnuClick(Sender: TObject);
    procedure SetCaptionAlignment  (const Value: TAlignment);
    procedure SetDisabledBlendColor(const Value: TColor);
    procedure SetDisabledBlendValue(const Value: byte);
    procedure SetTitleBar          (const Value: TsTitleBar);
    procedure SetTitleButtons      (const Value: TsTitleButtons);
    procedure SetGluedForms        (const Value: TStringList);
    procedure SetResizeMode        (const Value: TsResizeMode);
    procedure SetBoolean           (const Index: Integer; const Value: boolean);
    procedure SetSkinSection       (const Index: Integer; const Value: TsSkinSection);

    function HaveSysMenu: boolean;
    procedure UpdateNCArea(Skinned: boolean);
    procedure InitIndexes;
  protected
    bCapture,
    DoReinit,
    bInProcess,
    MaxRestore,
    FSysExHeight,
    ClearButtons,
    OwnThirdLists,
    FMenuOwnerDraw,
    MenusInitialized: boolean;

    LockCount,
    CYCaption,
    CXSizeFrame,
    CXFixedFrame,
    CXPaddedBorder,
    FLinesCount,
    FHeaderIndex,
    FHeaderHeight,
    FTitleSkinIndex,
    FCaptionSkinIndex: integer;

    FGenData: PsGeneralData;

    NormalBounds,
    LastClientRect: TRect;

    FGlow1,
    FGlow2,
    TempBmp,
    CoverBmp,
    MenuLineBmp: TBitmap;

    MDIMin,
    MDIMax,
    ButtonMin,
    ButtonMax,
    ButtonHelp,
    ButtonClose,
    MDIClose: TsCaptionButton;

    Rects:            TRects;
    HotItem:          TMenuItemData;
    FTitleBar:        TsTitleBar;
    LayerForm,
    CoverForm:        TacGlowForm;
    FormTimer:        TacThreadedTimer;
    FCommonData:      TsScrollWndData;
    SavedLabelColors: TacLabelsColors;

    UWPTemplates: array [boolean] of TBitmap;
    UWPShadowSize: TRect;

    bFlag1,
    RTInit,
    RTEmpty, // SkinProvider exists already
    InAero,
    InMenu,
    fAnimating,
    BigButtons,
    FormActive,
    MenuChanged,
    RgnChanging,
    RightPressed: boolean;

    CaptForm: TacGlowForm;

    VCenter: integer;
    MDIForm: TObject;
    FrameAdapters: TList;
    ShowAction: TShowAction;
    StatusBar: TControl;

    FluentHandles: TList; // List of Controls with supported fluent mode
    FluentUWPMode: boolean;
    FluentBorderStyle: TFormBorderStyle;

{$IFDEF ACDEBUG}
    FRgnChanged: boolean;
    procedure SetRgnChanged(const Value: boolean);
    property RgnChanged: boolean read FRgnChanged write SetRgnChanged default True;
{$ELSE}
    RgnChanged: boolean;
{$ENDIF}

    procedure AdapterRemove;
    procedure AdapterCreate;
    procedure SendToAdapter(Message: TMessage);
    // Painting procedures <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    function  HeaderUsed: boolean;
    procedure PaintForm(DC: hdc; PaintRect: TRect; SendUpdated: boolean = True);
    procedure PaintCaption(DC: hdc);

    procedure PaintTitleContent(CaptWidth: integer);
    procedure PaintTitleItem(Item: TacTitleBarItem; R: TRect; Bmp: TBitmap);
    procedure UpdateLayerForm;

    procedure RepaintButton(i: integer);
  {$IFNDEF FPC}
    procedure RepaintMenuItem(mi: TMenuItem; R: TRect; State: TOwnerDrawState);
  {$ENDIF}
    procedure SaveBGForBtns(CaptWidth: integer; Full: boolean = False);
    procedure RestoreBtnsBG(CaptWidth: integer);

    procedure OurPaintHandler(const Msg: TWMPaint);

  {$IFNDEF DISABLEPREVIEWMODE}
    procedure AC_ASEMSG              (var Message: TMessage);
    procedure AC_WMCopyData          (var Message: TWMCopyData);
  {$ENDIF}
    function AC_SMAlphaCmd_Common    (var Message: TMessage): boolean;
    function AC_SMAlphaCmd_Skinned   (var Message: TMessage): boolean;
    function AC_SMAlphaCmd_Unskinned (var Message: TMessage): boolean;

    procedure AC_CMEnabledChanged    (var Message: TMessage);
    procedure AC_CMFloat             (var Message: TMessage);
    procedure AC_CMMenuChanged       (var Message: TMessage);
    procedure AC_CMMouseEnter        (var Message: TMessage);
    procedure AC_CMRecreateWnd       (var Message: TMessage);
    procedure AC_CMShowingChanged    (var Message: TMessage);
  {$IFNDEF ALITE}
    procedure AC_CMMouseWheel        (var Message: TCMMouseWheel);
  {$ENDIF}
    procedure AC_WMActivate          (var Message: TWMActivate);
    procedure AC_WMActivateApp       (var Message: TMessage);
    procedure AC_WMChildActivate     (var Message: TMessage);
  {$IFNDEF FPC}
    procedure AC_WMContextMenu       (var Message: TMessage);
  {$ENDIF}
    procedure AC_WMControlListChange (var Message: TCMControlListChange);
    procedure AC_WMCreate            (var Message: TMessage);
    procedure AC_WMEnterMenuLoop     (var Message: TMessage);
    procedure AC_WMEraseBkGnd        (var Message: TMessage);
    procedure AC_WMEraseBkGndHandler (aDC: hdc);
    procedure AC_WMExitMenuLoop      (var Message: TMessage);
    procedure AC_WMExitSizeMove      (var Message: TMessage);
    procedure AC_WMGetMinMaxInfo     (var Message: TWMGetMinMaxInfo);
  {$IFNDEF FPC}
    procedure AC_WMInitMenuPopup     (var Message: TWMInitMenuPopup);
  {$ENDIF}
    procedure AC_WMLButtonUp         (var Message: TWMNCLButtonUp);
    procedure AC_WMMDIDestroy        (var Message: TMessage);
    procedure AC_WMMeasureItem       (var Message: TMessage);
    procedure AC_WMMove              (var Message: TMessage);
    procedure AC_WMMouseLeave        (var Message: TMessage);
    procedure AC_WMMouseMove         (var Message: TMessage);
    procedure AC_WMNCActivate        (var Message: TWMNCActivate);
    procedure AC_WMNCCreate          (var Message: TMessage);
    procedure AC_WMNCDestroy;
    procedure AC_WMNCHitTest         (var Message: TMessage);
    procedure AC_WMNCLButtonDblClick (var Message: TMessage);
    procedure AC_WMNCLButtonDown     (var Message: TWMNCLButtonDown);
    procedure AC_WMNCMouseMove       (var Message: TWMNCMouseMove);
    procedure AC_WMNCPaint           (var Message: TMessage);
    procedure AC_WMNCPaintHandler;
    procedure AC_WMNCRButtonDown     (var Message: TWMNCRButtonDown);
    procedure AC_WMNCRButtonUp       (var Message: TWMNCRButtonUp);
    procedure AC_WMNotify            (var Message: TMessage);
    procedure AC_WMPaint             (var Message: TMessage);
    procedure AC_WMParentNotify      (var Message: TMessage);
    procedure AC_WMPrint             (var Message: TMessage);
    procedure AC_WMQueryEndSession   (var Message: TMessage);
    procedure AC_WMSetIcon           (var Message: TMessage);
    procedure AC_WMSetRedraw         (var Message: TMessage);
    procedure AC_WMSetText           (var Message: TMessage);
    procedure AC_WMSettingChange     (var Message: TMessage);
    procedure AC_WMSize              (var Message: TMessage);
    procedure AC_WMSizing            (var Message: TMessage);
    procedure AC_WMShowWindow        (var Message: TMessage);
    procedure AC_WMStyleChanged      (var Message: TMessage);
    procedure AC_WMSysColorChange    (var Message: TMessage);
    procedure AC_WMSysCommand        (var Message: TMessage);
    procedure AC_WMVisibleChanged    (var Message: TMessage);
    procedure AC_WMWindowPosChanged  (var Message: TMessage);
    procedure AC_WMWindowPosChanging (var Message: TWMWindowPosChanging);
  {$IFNDEF NOWNDANIMATION}
    procedure AC_WMWindowPosChanged_Unskinned(var Message: TWMWindowPosChanged);
    procedure AC_CMVisibleChanged_Unskinned  (var Message: TMessage);
    procedure AC_CMShowingChanged_Unskinned  (var Message: TMessage);
    procedure AC_WMClose                     (var Message: TMessage);
    procedure StartMoveForm;
  {$ENDIF}
    // Special calculations <<<<<<<< <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    function HTProcess(var Message: TWMNCHitTest): integer;
    function CursorToPoint(const x, y: integer): TPoint;
    function MDIButtonsNeeded: boolean;
    function RBGripPoint(const ImgIndex: integer): TPoint;
    function FormLeftTop: TPoint;
    function SysButtonsCount: integer;
    function SmallButtonWidth: integer;
    function ButtonHeight: integer;
    function SmallButtonHeight: integer;
    procedure UWPCaptionUpdate(Zoomed: boolean);

    function LimitRect(db: integer; R: TRect; Invert: boolean = False): TRect;
    function CheckEdges(rStatic, rDynamic: TRect; NewX, NewY: integer): TSize;
    procedure CheckNewPosition(var X: integer; var Y: integer);
    function Linked(f: TForm): boolean;
    procedure MoveGluedForms(BlendMoving: boolean = False);
    procedure UpdateSlaveFormsList;
    function UWPNoBorderMode: boolean;

    function SysButtonWidth(const Btn: TsCaptionButton): integer;
    function TitleBtnsWidth: integer;
    function UserButtonWidth(const Btn: TsTitleButton): integer;
    function BarWidth(const i: integer): integer;
    // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    procedure UpdateIconsIndexes;
//    procedure UpdateStatusBar;

    procedure StartMove     (X, Y: Integer);
    procedure StopMove      (X, Y: Integer);
    procedure DrawFormBorder(X, Y: Integer);

    procedure SetHotHT    (const i: integer; const Repaint: boolean = True);
    procedure SetPressedHT(const i: integer);

    function ActualTitleHeight(Max: boolean = False): integer;
    function GetTopCoord: integer; virtual;
    function FormChanged: boolean;
    function IconVisible: boolean;
    function TitleSkinSection: string;
    procedure TryInitMenu;
    procedure CheckSysMenu(const Skinned: boolean);
    procedure InitExBorders(const Active: boolean);
    function UWPTemplate(bActive: boolean): TBitmap;
    function CanDrawNCArea: boolean;
    function SizeFrame: integer;
    function FixedFrame: integer;
    function FramePadding: integer;
    procedure InitSysParams(iPPI: integer);
    function BorderHeight (CheckSkin: boolean = True): integer;

    procedure SetFormState(const Value: Cardinal);
    procedure CalcItems;
    procedure LoadInit;
    procedure InitLabel(const Control: TControl; const Skinned: boolean);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure NewWndProc(var Message: TMessage);

    procedure HookMDI(Active: boolean = True);
    function CaptionWidth: integer;
    function MenuHeight: integer;
    function MenuPresent: boolean;
    function SysRTLAllowed: boolean;
    function FormColor: TColor;

    procedure MdiIcoFormPaint(Sender: TObject);
    procedure UpdateTitleBar;

    procedure FillAlphaClient(Bmp: TBitmap);
  {$IFNDEF FPC}
    procedure InitMenuItems(A: boolean);
  {$ENDIF}
  public
    OldWndProc: TWndMethod;

    biClicked,
    AllowScale,
    FInAnimation,
    SkipAnimation: boolean;
    Form: TForm;
    ListSW: TacScrollWnd;
    FFormState: Cardinal;
    Adapter: TacCtrlAdapter;
    ThirdLists: TStringLists;
    BorderForm: TacBorderForm;
    SystemMenu: TsSystemMenu;

    function IsBlurred: boolean;
    function PaintAll: boolean;
    function OffsetX: integer;
    function OffsetY: integer;
    procedure KillAnimations;
    procedure DropSysMenu(x, y: integer);
    procedure AfterConstruction; override;
    function UWPClientRect: TRect;
    procedure PrepareForm;
    procedure Loaded; override;
    procedure ProcessMessage(Msg: Cardinal; WPar: WPARAM = 0; LPar: LPARAM = 0);
    constructor Create(AOwner: TComponent); override;
    constructor CreateRT(AOwner: TCustomForm; DoInitRT: boolean = True);
    function CaptionHeight(CheckSkin: boolean = True): integer;
    destructor Destroy; override;
    function ShadowSize: TRect;
    procedure RepaintMenu;
    function UpdateMenu: boolean;
    function HeaderHeight: integer; // Height of the header + menu lines
    function BorderWidth(CheckSkin: boolean = True): integer;

    property IconRect: TRect read FIconRect;
    property LinesCount: integer read GetLinesCount;
    property FormState: Cardinal read FFormState write SetFormState;
    property ResizeMode: TsResizeMode read FResizeMode write SetResizeMode default rmStandard;
  published
{$ENDIF} // NOTFORHELP
    property AllowAnimation:     boolean read FAllowAnimation     write FAllowAnimation      default True;
    property AllowBlendOnMoving: boolean read FAllowBlendOnMoving write FAllowBlendOnMoving  default True;
    property AllowSkin3rdParty:  boolean read FAllowSkin3rdParty  write FAllowSkin3rdParty   default True;
    property MakeSkinMenu:       boolean read FMakeSkinMenu       write FMakeSkinMenu        default DefMakeSkinMenu;
    property ScreenSnap:         boolean read FScreenSnap         write FScreenSnap          default False;
    property DisabledBlured:     boolean read FDisabledBlured     write FDisabledBlured      default False;

    property AllowExtBorders:    boolean Index 0 read FAllowExtBorders    write SetBoolean default True;
    property DrawNonClientArea:  boolean Index 1 read FDrawNonClientArea  write SetBoolean default True;
    property ShowAppIcon:        boolean Index 2 read FShowAppIcon        write SetBoolean default True;
    property UseGlobalColor:     boolean Index 3 read FUseGlobalColor     write SetBoolean default True;
    property UWPMode:            boolean Index 4 read FUWPMode            write SetBoolean default False;
    property DrawClientArea:     boolean Index 5 read FDrawClientArea     write SetBoolean default True;

    property TitleSkin:          TsSkinSection Index 0 read FTitleSkin    write SetSkinSection;
    property MenuLineSkin:       TsSkinSection Index 1 read FMenuLineSkin write SetSkinSection;

    property AddedTitle:         TacAddedTitle    read FAddedTitle         write FAddedTitle;
    property CaptionAlignment:   TAlignment       read FCaptionAlignment   write SetCaptionAlignment   default Classes.taLeftJustify;

    property DisabledBlendValue: byte             read FDisabledBlendValue write SetDisabledBlendValue default MaxByte;
    property DisabledBlendColor: TColor           read FDisabledBlendColor write SetDisabledBlendColor default clBlack;
    property FormHeader:         TacFormHeader    read FFormHeader         write FFormHeader;
    property GluedForms:         TStringList      read FGluedForms         write SetGluedForms;
    property SkinData:           TsScrollWndData  read FCommonData         write FCommonData;
    property GripMode:           TsGripMode       read FGripMode           write FGripMode             default gmNone;
    property SnapBuffer:         integer          read FSnapBuffer         write FSnapBuffer           default 10;
    property SysSubMenu:         TacSysSubMenu    read FSysSubMenu         write FSysSubMenu;
    property TitleBar:           TsTitleBar       read FTitleBar           write SetTitleBar;
    property TitleButtons:       TsTitleButtons   read FTitleButtons       write SetTitleButtons;
    property TitleIcon:          TsTitleIcon      read FTitleIcon          write FTitleIcon;
    property ThirdParty:         TsThirdPartyList read FThirdParty         write FThirdParty;
    property SystemBlur:         TacSystemBlur    read FSystemBlur         write FSystemBlur;

    property OnAfterAnimation:   TacAfterAnimation read FOnAfterAnimation write FOnAfterAnimation;
    property OnExtHitTest:       TacNCHitTest      read FOnExtHitTest     write FOnExtHitTest;
    property OnSkinItem:         TAddItemEvent     read FOnSkinItem       write FOnSkinItem;
    property OnSkinItemEx:       TAddItemExEvent   read FOnSkinItemEx     write FOnSkinItemEx;
  end;
{$IFNDEF NOTFORHELP}


  TacSBAnimation = class(TTimer)
  protected
    ABmp: TBitmap;
    AForm: TacGlowForm;
    BorderForm: TacBorderForm;
  public
    CurrentLevel,
    CurrentState,
    MaxIterations: integer;

    SkinData: TsCommonData;
    FormHandle: hwnd;
    PBtnData: PsCaptionButton;
    Up: boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetFormBounds: TRect;
    function Offset: integer;
    function Step: integer;
    procedure MakeForm;
    procedure UpdateForm(const Blend: integer);
    procedure StartAnimation(NewState: integer; ToUp: boolean);
    procedure ChangeState   (NewState: integer; ToUp: boolean);
    procedure MakeImg;
    procedure CheckMouseLeave;
    procedure OnAnimTimer(Sender: TObject);
  end;


  TacBorderForm = class(TPersistent)
  protected
    LastTopLeft,
    LastMousePos: TPoint;

    LeftPressed,
    MainRgnReady,
    acInMouseMsg,
    MovRgnChanged,
    MaxMoving: boolean;

    FOwner: TObject;
    sp: TsSkinProvider;

    ResetRgn: boolean;

    function CanBringForm: boolean;
    procedure BorderProc(var Message: TMessage);

    procedure KillAnimations;
    // Access from owners
    function ButtonMin:   TsCaptionButton;
    function ButtonMax:   TsCaptionButton;
    function ButtonClose: TsCaptionButton;
    function ButtonHelp:  TsCaptionButton;

    function CaptionHeight(CheckSkin: boolean = True): integer;
    function MenuHeight: integer;
    function IconRect: TRect;
    procedure SetHotHT(const i: integer; Repaint: boolean = True);
    function MinTopCoord: integer;
    function FormState: Cardinal;
    procedure UpdateRgn;

    function Ex_WMSetCursor (var Message: TWMSetCursor): boolean;
    function MouseAboveTheShadow(Message: TWMMouse): boolean;
    function GetTopWnd: THandle;
  public
    Locked,
    ExBorderShowing: boolean;
    SkinData: TsCommonData;
    AForm: TacGlowForm;
    OldBorderProc: TWndMethod;
    ParentHandle: THandle;
    ShadowTemplate: TBitmap;
    function Ex_WMNCHitTest(var Message: TWMNCHitTest): integer;
    function ShadowSize: TRect;
    function OffsetX: integer;
    function OffsetY: integer;
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
    function MakeRgn(NewWidth: integer = 0; NewHeight: integer = 0): HRGN;
    procedure CreateNewForm;
    function OwnerHandle: hwnd;
    procedure PaintAll;

    procedure UpdateExBordersPos(Redraw: boolean = True; Blend: byte = MaxByte);
  end;


{$IFDEF TNTUNICODE}
  TsCustomSysMenu = class(TTntPopupMenu)
{$ELSE}
  TsCustomSysMenu = class(TPopupMenu)
{$ENDIF}
  public
    function VisibleClose:   boolean; virtual; abstract;
    function VisibleMax:     boolean; virtual; abstract;
    function VisibleMin:     boolean; virtual; abstract;
    function EnabledMax:     boolean; virtual; abstract;
    function EnabledMin:     boolean; virtual; abstract;
    function EnabledRestore: boolean; virtual; abstract;
  end;


  TsSystemMenu = class(TsCustomSysMenu)
  protected
    SubMenu,
    ItemMove,
    ItemSize,
    ItemClose,
    ItemRestore,
    ItemMinimize,
    ItemMaximize: TMenuItem;

    ExtItemsCount: integer;
    FOwner: TsSkinProvider;
    FForm: TCustomForm;

    procedure RestoreClick (Sender: TObject);
    procedure MoveClick    (Sender: TObject);
    procedure SizeClick    (Sender: TObject);
    procedure MinClick     (Sender: TObject);
    procedure MaxClick     (Sender: TObject);
    procedure CloseClick   (Sender: TObject);
    procedure SkinSelect   (Sender: TObject);
    procedure ExtClick     (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Generate;
    procedure UpdateItems(Full: boolean = False);
    procedure UpdateGlyphs;
    procedure MakeSkinItems;

    function VisibleRestore: boolean;
    function VisibleSize:    boolean;
    function VisibleMin:     boolean; override;
    function VisibleMax:     boolean; override;
    function VisibleClose:   boolean; override;

    function EnabledRestore: boolean; override;
    function EnabledMin:     boolean; override;
    function EnabledMax:     boolean; override;
    function EnabledMove:    boolean;
    function EnabledSize:    boolean;
    function EnabledClose:   boolean;
  end;


{$IFNDEF NOTFORHELP}
  TacAdapterItems = array of TacAdapterItem;
  TacGraphItems = array of TacGraphItem;
{$ENDIF}


  TacCtrlAdapter = class(TPersistent)
{$IFNDEF NOTFORHELP}
  protected
    bFlag: boolean;
    CtrlClass: TObject;
    DefaultSection: string;
    Items: TacAdapterItems;
    GraphItems: TacGraphItems;
    function IsControlSupported(Control: TComponent; ThirdLists: TStringLists): boolean;
    function Count: integer;
    function GetItem(Index: integer): TacAdapterItem;
    function GetCommonData(Index: integer): TsCommonData;
    function IndexOf(Ctrl: TWinControl): integer;
{$ENDIF} // NOTFORHELP
    procedure RemoveItem(Index: integer);
    procedure RemoveAllItems;
    procedure CleanItems;
  public
    Provider: TsSkinProvider;
    procedure AddAllItems(OwnerCtrl: TWinControl = nil);
    procedure AddNewItem(const Ctrl: TSpeedButton); overload;
    procedure AddNewItem(const Ctrl: TWinControl; AThirdLists: TStringLists{ = nil}); overload;
    procedure AddNewItem(const Ctrl: TWinControl; const SkinSection: string; AThirdLists: TStringLists{ = nil}); overload;
    constructor Create(AProvider: TsSkinProvider);
    procedure WndProc(var Message: TMessage);
    destructor Destroy; override;
  end;


  TacMoveTimer = class(TacThreadedTimer)
  public
    BlendValue: byte;
    FormHandle: THandle;
    BorderForm: TacBorderForm;

    BlendStep,
    CurrentBlendValue: real;
    procedure TimeHandler; override;
  end;


const
  // FormStates
  FS_SIZING         = $1;
  FS_BLENDMOVING    = $80;
  FS_ANIMMINIMIZING = $100;
  FS_ANIMCLOSING    = $200;
  FS_ANIMRESTORING  = $400;
  FS_THUMBDRAWING   = $800;
  FS_CHANGING       = $1000;
  FS_ANIMSHOWING    = $2000;

  FS_ANIMMINREST  = FS_ANIMRESTORING or FS_ANIMMINIMIZING;
  FS_ANIMATING    = FS_BLENDMOVING   or FS_ANIMMINREST;
  FS_FULLPAINTING = FS_CHANGING      or FS_BLENDMOVING or FS_ANIMMINIMIZING;

  FS_MAXHEIGHT      = $4000;
  FS_MAXWIDTH       = $8000;
  FS_LOCKED         = $10000;  // Lock for animation
  FS_SCROLLUPDATING = $20000;  // Update ListSW object
  FS_POSCHANGING    = $40000;
  FS_ZOOMING        = $80000;
  FS_DISABLED       = $100000;
  FS_ACTIVATE       = $200000;
  FS_RESTORING      = $400000;
  FS_RECREATING     = $800000;
  FS_SCALING        = $1000000;
  FS_GLASSNEEDED    = $2000000;

  ScrollWidth       = 18;
  IconicHeight      = 26;

  HTUDBTN           = 1000;

var
  ItemsRemoving: boolean = False;

function IsFluentOS: boolean;
function AeroIsEnabled: boolean;
function ForbidSysAnimating: boolean;
procedure InitDwm(const Handle: THandle; const Skinned: boolean; const Repaint: boolean = False);

function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: DWORD; pvAttribute: Pointer; cbAttribute: DWORD): HResult;
procedure DwmInvalidateIconicBitmaps(hwnd: HWND);
{$IFDEF FLUENTCOMP}
procedure acDwmExtendFrameIntoClientArea(hWnd: HWND; const pMarInset: TMargins);
{$ENDIF}

function IsBorderUnchanged(const BorderIndex: integer; const CommonSkinData: TacSkinData): boolean;
procedure UpdateRgn(sp: TsSkinProvider; DoRepaint: boolean = True; AllChildren: boolean = False);
procedure FillArOR (sp: TsSkinProvider);
function GetRgnFromArOR(sp: TsSkinProvider; X: integer = 0; Y: integer = 0): hrgn;
procedure UpdateSkinCaption(SkinProvider: TsSkinProvider);
procedure UpdateProviderThirdNames(sp: TsSkinProvider);
function GetSkinProvider(Cmp: TComponent): TsSkinProvider;
function GetWindowWidth (Handle: hwnd): integer;
function GetClientWidth (Handle: hwnd): integer;
function GetWindowHeight(Handle: hwnd): integer;
function GetClientHeight(Handle: hwnd): integer;

function SkinMenuOffset (const sp: TsSkinProvider): TPoint;
function SkinTitleHeight(const BorderForm: TacBorderForm): integer;
function SkinBorderWidth(const BorderForm: TacBorderForm): integer;
function DiffTitle      (const BorderForm: TacBorderForm): integer;
function DiffBorder     (const BorderForm: TacBorderForm): integer;
function SysBorderWidth (const Handle: hwnd; const BorderForm: TacBorderForm; CheckSkin: boolean = True): integer;
function SysBorderHeight(const Handle: hwnd; const BorderForm: TacBorderForm; CheckSkin: boolean = True): integer;
function SysCaptHeight(sp: TsSkinProvider; iDPI: integer = 0): integer;

{$IFNDEF NOWNDANIMATION}
function StartMinimizing(sp: TsSkinProvider): boolean;
function StartRestoring (sp: TsSkinProvider): boolean;

procedure StartBlendOnMoving (sp: TsSkinProvider; ToMove: boolean = True);
procedure FinishBlendOnMoving(sp: TsSkinProvider; CoverForm: TacGlowForm = nil);
{$ENDIF}
function GetFormImage(sp: TsSkinProvider; CacheReplaced: boolean = False): TBitmap;
function MakeCoverForm(Wnd: THandle; sp: TsSkinProvider = nil; FromScreen: boolean = False; ScrRect: PRect = nil): TacGlowForm;

procedure StartSBAnimation(const Btn: PsCaptionButton; const State: integer; const Iterations: integer; const ToUp: boolean; const SkinProvider: TsSkinProvider; acDialog: pointer = nil);
{$IFNDEF DELPHI6UP}
function GetWindowThreadProcessId(hWnd: THandle; var dwProcessId: DWORD): DWORD; stdcall; overload;
{$ENDIF}
function SetThumbIcon (Handle: HWND; sp: TsSkinProvider; Width, Height: integer): boolean;
function SetPreviewBmp(Handle: HWND; sp: TsSkinProvider): boolean;
function ac_GetSysMetrics(nIndex: Integer; DPI: uint): Integer;
{$ENDIF} // NOTFORHELP

implementation


uses
  math, CommCtrl, ComCtrls, StdCtrls, Dialogs, ImgList, SyncObjs,
{$IFDEF LOGGED}
  sDebugMsgs,
{$ENDIF}
{$IFDEF ADDWEBBROWSER}
  acWB,
{$ENDIF}
{$IFNDEF ALITE}
  sFrameAdapter, sScrollBox, acAlphaHints, acPopupController,
{$ENDIF}
  sVclUtils, sGraphUtils, sSkinProps, sLabel, acntUtils, sMessages, sMDIForm,
  sAlphaGraph, acDials, acAlphaImageList, sThirdParty, acgpUtils, sStatusBar;


const
  FS_MAXBOUNDS = FS_MAXHEIGHT or FS_MAXWIDTH;
  HTITEM = 2000;
  iAlphaNull = 0;

type
  _DWM_BLURBEHIND = packed record
    dwFlags: DWORD;
    fEnable: Bool;
    hRgnBlur: HRGN;
    fTransitionOnMaximized: Bool;
  end;
  PDWM_BLURBEHIND = ^_DWM_BLURBEHIND;
  TDWM_BLURBEHIND = _DWM_BLURBEHIND;


  TacMinTimer = class(TacThreadedTimer)
  protected
    AlphaBmp: TBitmap;
    AlphaFormWasCreated: boolean;
    AlphaOrigin,
    AlphaTo: byte;
    AnimForm: TacGlowForm;
    BlendStep, BlendDel: real;
    BorderForm: TacBorderForm;
    CurrentAlpha,
    CurRight,
    CurLeft,
    CurTop,
    CurBottom: real;

    StepCount,
    XFrom,
    YFrom,
    XTo,
    YTo: integer;

    DelPosX, DelPosY: real;

    DeltaX,
    DeltaY,
    DeltaW,
    DeltaH: real;

    RectFrom,
    RectTo: TRect;

    TBPosition: Cardinal;

    sp: TsSkinProvider;
    FormHandle: THandle;
    SavedImage: TBitmap;
    Minimized: boolean;

    function AlphaFrom: byte;
    function GetRectTo(rFrom: TRect): TRect;
    procedure InitData;
    procedure InitDataRestore;
    procedure UpdateDstRect;
    procedure TimeHandler; override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateOwned(AOwner: TComponent; ChangeEvent: boolean); override;
    destructor Destroy; override;
  end;


var
  hDWMAPI: HMODULE = 0;
  hUser32: HMODULE = 0;

  ntop, nleft, nbottom, nright, nX, nY, nDirection, nMinHeight, nMinWidth, nDC: Integer;
  bMode: Boolean; // True - move, False - size
  deskwnd: HWND;
  formDC: HDC;
  FMDIMenuHook: HHOOK;

  MDIIconsForm: TForm = nil;
  MDICreating: boolean = False;
  ChildProvider: TsSkinProvider = nil;

  GluedArray: array of TacFormsCouple;


_DwmSetIconicThumbnail:         function(hwnd: HWND; hbmp: HBITMAP; dwSITFlags: DWORD): HResult; stdcall;
_DwmSetIconicLivePreviewBitmap: function(hwnd: HWND; hbmp: HBITMAP; var pptClient: TPoint; dwSITFlags: DWORD): HResult; stdcall;
_DwmSetWindowAttribute:         function(hwnd: HWND; dwAttribute: DWORD; pvAttribute: Pointer; cbAttribute: DWORD): HResult; stdcall;
_DwmEnableBlurBehindWindow:     function(hWnd: HWND; const pBlurBehind: PDWM_BLURBEHIND): HRESULT; stdcall;
_DwmInvalidateIconicBitmaps:    function(hwnd: HWND): HResult; stdcall;
_DwmIsCompositionEnabled:       function(out pfEnabled: BOOL): HResult; stdcall;
{$IFDEF FLUENTCOMP}
_DwmExtendFrameIntoClientArea:  function(hWnd: HWND; const pMarInset: TMargins): HResult; stdcall;
{$ENDIF}

ac_GetSystemMetricsForDpi: function(nIndex: Integer; DPI: uint): Integer; stdcall;

const
  ModName = 'DWMAPI.DLL';
  iMinBorderSize = 6;
  iUWPBorderWidth = 2;


type
  TacItemSkinData = class(TObject)
  public
    SkinIndex: integer;
  end;

  PacItemSkinData = ^TacItemSkinData;


procedure InitDwmApi;
begin
  if hDWMAPI = 0 then
    hDWMAPI := LoadLibrary(ModName);
end;


procedure DelFromGluedArray(f: TForm);
var
  n, l: integer;
begin
  l := Length(GluedArray);
  n := 0;
  while n < l do begin
    if GluedArray[n].Slave = f then begin
      if n <> l - 1 then begin
        GluedArray[n].Master := GluedArray[l - 1].Master;
        GluedArray[n].Slave  := GluedArray[l - 1].Slave;
      end;
      SetLength(GluedArray, l - 1);
    end;
    inc(n);
  end;
end;


function SetThumbIcon(Handle: HWND; sp: TsSkinProvider; Width, Height: integer): boolean;
Const
  Flag = 0;
var
  Bmp, BmpForm, SrcBmp: TBitmap;
  w, h: integer;
begin
  Result := False;
  if IsWinVistaUp and (Width <> 0) and (Height <> 0) then begin
    if not Assigned(_DwmSetIconicThumbnail) then begin
      InitDwmApi;
      if hDWMAPI > 0 then begin
        _DwmSetIconicThumbnail := GetProcAddress(hDWMAPI, 'DwmSetIconicThumbnail');
        if not Assigned(_DwmSetIconicThumbnail) then
          Exit;
      end
    end;
    if (sp.FormTimer <> nil) and (sp.FormTimer is TacMinTimer) and TacMinTimer(sp.FormTimer).Minimized then
      SrcBmp := TacMinTimer(sp.FormTimer).SavedImage
    else
      SrcBmp := sp.SkinData.FCacheBmp;

    if (SrcBmp <> nil) and not SrcBmp.Empty then begin
      if Width / Height <= SrcBmp.Width / SrcBmp.Height then begin // Width is a main size
        w := Width;
        h := Round(w * SrcBmp.Height / SrcBmp.Width);
      end
      else begin
        h := Height;
        w := Round(h * SrcBmp.Width / SrcBmp.Height);
      end;
      if (w <> 0) and (h <> 0) then begin
        sp.FormState := sp.FormState or FS_THUMBDRAWING;
        Bmp := CreateBmp32(w, h);
        // Fast out
        Stretch(SrcBmp, Bmp, w, h, ftTriangle);
        if _DwmSetIconicThumbnail(Handle, Bmp.Handle, Flag) <> S_OK then
          Bmp.Free
        else begin
          Result := True;
          if SrcBmp = sp.SkinData.FCacheBmp then begin
            // Full out
            BmpForm := CreateBmp32(SrcBmp);
            BmpForm := GetFormImage(sp);
            Stretch(BmpForm, Bmp, w, h, ftTriangle);
            _DwmSetIconicThumbnail(Handle, Bmp.Handle, Flag);
            FreeAndNil(BmpForm);
            if sp.BorderForm <> nil then
              sp.BorderForm.UpdateExBordersPos(False); // Repaint cache
          end;
          FreeAndNil(Bmp);
          sp.FormState := sp.FormState and not FS_THUMBDRAWING;
        end;
      end;
    end;
  end;
end;


function ac_GetSysMetrics(nIndex: Integer; DPI: uint): Integer;
begin
  if not IsWin8Up then
    Result := GetSystemMetrics(nIndex)
  else begin
    if not Assigned(ac_GetSystemMetricsForDpi) then begin
      hUser32 := LoadLibrary(user32);
      if hUser32 <> 0 then begin
        ac_GetSystemMetricsForDpi := GetProcAddress(hUser32, 'GetSystemMetricsForDpi');
        FreeLibrary(hUser32);
      end;
    end;
    if Assigned(ac_GetSystemMetricsForDpi) then
      Result := ac_GetSystemMetricsForDpi(nIndex, DPI)
    else
      Result := GetSystemMetrics(nIndex);
  end;
end;


function SetPreviewBmp(Handle: HWND; sp: TsSkinProvider): boolean;
const
  Flag = 1;
var
  p: TPoint;
  BmpForm, SrcBmp: TBitmap;
begin
  Result := False;
  if IsWinVistaUp then begin
    if not Assigned(_DwmSetIconicLivePreviewBitmap) then begin
      InitDwmApi;
      if hDWMAPI > 0 then begin
        _DwmSetIconicLivePreviewBitmap := GetProcAddress(hDWMAPI, 'DwmSetIconicLivePreviewBitmap');
        if not Assigned(_DwmSetIconicLivePreviewBitmap) then
          Exit;
      end
    end;
    if (sp.FormTimer <> nil) and (sp.FormTimer is TacMinTimer) and TacMinTimer(sp.FormTimer).Minimized then
      SrcBmp := TacMinTimer(sp.FormTimer).SavedImage
    else
      SrcBmp := sp.SkinData.FCacheBmp;

    if (SrcBmp <> nil) and not SrcBmp.Empty then begin
      sp.FormState := sp.FormState or FS_THUMBDRAWING;
      p := MkPoint;
      if SrcBmp = sp.SkinData.FCacheBmp then begin
        // Full out
        BmpForm := CreateBmp32(SrcBmp);
        BmpForm := GetFormImage(sp);
        Result := _DwmSetIconicLivePreviewBitmap(Handle, BmpForm.Handle, p, Flag) = S_OK;
        FreeAndNil(BmpForm);
        if sp.BorderForm <> nil then
          sp.BorderForm.UpdateExBordersPos(False); // Repaint cache
      end
      else // Fast out
        Result := _DwmSetIconicLivePreviewBitmap(Handle, SrcBmp.Handle, p, Flag) = S_OK;

      sp.FormState := sp.FormState and not FS_THUMBDRAWING;
    end;
  end;
end;


function GetTopWindow: THandle;
begin
  Result := TopWndAfter;
end;


procedure DwmInvalidateIconicBitmaps(hwnd: HWND);
begin
  if IsWinVistaUp then
    if Assigned(_DwmInvalidateIconicBitmaps) then
      _DwmInvalidateIconicBitmaps(hwnd)
    else
      if hDWMAPI > 0 then begin
        _DwmInvalidateIconicBitmaps := GetProcAddress(hDWMAPI, 'DwmInvalidateIconicBitmaps');
        if Assigned(_DwmInvalidateIconicBitmaps) then
          _DwmInvalidateIconicBitmaps(hwnd);
      end;
end;


{$IFDEF FLUENTCOMP}
procedure acDwmExtendFrameIntoClientArea(hWnd: HWND; const pMarInset: TMargins);
begin
  if IsWinVistaUp then begin
    if not Assigned(_DwmExtendFrameIntoClientArea) then
      if hDWMAPI > 0 then
        _DwmExtendFrameIntoClientArea := GetProcAddress(hDWMAPI, 'DwmExtendFrameIntoClientArea');

    if Assigned(_DwmExtendFrameIntoClientArea) then
      _DwmExtendFrameIntoClientArea(hwnd, pMarInset);
  end;
end;
{$ENDIF}


function MakeCoverForm(Wnd: THandle; sp: TsSkinProvider = nil; FromScreen: boolean = False; ScrRect: PRect = nil): TacGlowForm;
var
  DC: hdc;
  R: TRect;
  sd: TsCommonData;
  SubRgn, Rgn: hrgn;
begin
  Result := TacGlowForm.CreateNew(nil);
  if ScrRect = nil then
    GetWindowRect(Wnd, R)
  else
    R := ScrRect^;

  Result.SetBounds(R.Left, R.Top, WidthOf(R), HeightOf(R));
  Result.AlphaBmp := CreateBmp32(Result.Width, Result.Height);
  // Copy the window image
  if not FromScreen and (GetWindowLong(Wnd, GWL_EXSTYLE) and WS_EX_LAYERED = 0) then begin
    DC := GetWindowDC(Wnd);
    try
      BitBlt(Result.AlphaBmp.Canvas.Handle, 0, 0, Result.Width, Result.Height, DC, 0, 0, SRCCOPY);
    finally
      ReleaseDC(Wnd, DC);
    end;
  end
  else begin
    DC := GetDC(0);
    try
      BitBlt(Result.AlphaBmp.Canvas.Handle, 0, 0, Result.Width, Result.Height, DC, R.Left, R.Top, SRCCOPY);
    finally
      ReleaseDC(0, DC);
    end;
  end;
  FillAlphaRect(Result.AlphaBmp, MkRect(Result.AlphaBmp), MaxByte);
  if sp <> nil then begin
    Result.Name := sp.Form.Name + 'Cover';
    sd := sp.SkinData
  end
  else begin
    sd := TsCommonData(TrySendMessage(Wnd, SM_ALPHACMD, AC_GETSKINDATA_HI, 0));
    Result.Name := 'FormCover' + IntToStr(GetTickCount);
  end;

  if sd <> nil then begin
    if (sp <> nil) and sp.UWPNoBorderMode then begin
      FillRect32Excl(Result.AlphaBmp, MkRect(Result.AlphaBmp), sp.UWPClientRect, 0, 0);
      Rgn := 0;//CreateRectRgn(rR.Left, rR.Top, rR.Right, rR.Bottom);
    end
    else begin
      Rgn := GetTransCornersRgn(sd.SkinIndex, Result.AlphaBmp, sd.CommonSkinData);
      if (GetWindowLong(Wnd, GWL_STYLE) and WS_CAPTION <> 0) and (sd.SkinManager.SkinCommonInfo.Sections[ssFormTitle] >= 0) then begin
        SubRgn := GetTransCornersRgn(sd.SkinManager.SkinCommonInfo.Sections[ssFormTitle], Result.AlphaBmp, sd.CommonSkinData);
        if SubRgn <> 0 then begin
          CombineRgn(Rgn, Rgn, SubRgn, RGN_OR);
          DeleteObject(SubRgn);
        end;
      end;
    end;
    if Rgn <> 0 then
      SetWindowRgn(Result.Handle, Rgn, False);
  end;
  SetFormBlendValue(Result.Handle, Result.AlphaBmp, MaxByte);
  SetWindowPos(Result.Handle, TopWndAfter, R.Left{ + 100}, R.Top, 0, 0, SWPA_SHOWZORDER);
//  FreeAndNil(Result.AlphaBmp); // Killed later in a form destructor
end;


function ShellTrayWnd: THandle;
begin
  Result := FindWindow('Shell_TrayWnd', nil);
end;


procedure SetBlurBehindWindow(AHandle: HWND; AEnabled: Boolean; ARGN: HRGN = 0);
const
  DWM_BB_ENABLE = 1;
  DWM_BB_BLURREGION = 2;
var
  BlurBehind: TDWM_BLURBEHIND;
begin
  if (hDWMAPI <> 0) and AeroIsEnabled then
    if not IsWin10Up then begin
      with BlurBehind do begin
        dwFlags := DWM_BB_ENABLE;
        if ARGN <> 0 then
          dwFlags := dwFlags or DWM_BB_BLURREGION;

        fTransitionOnMaximized := False;
        hRgnBlur := ARGN;
        fEnable := AEnabled;
      end;
      if Pointer(@_DwmEnableBlurBehindWindow) <> nil then
        _DwmEnableBlurBehindWindow(AHandle, @BlurBehind);
    end;

  if ARGN <> 0 then
    DeleteObject(ARGN);
end;


{$IFNDEF NOWNDANIMATION}
function StartMinimizing(sp: TsSkinProvider): boolean;
var
  h: THandle;
  Bmp: TBitmap;
  SavedDC: hdc;
  X, Y: integer;
begin
  Result := False;
  if not IsWinVistaUp or AeroIsEnabled then begin
    if sp.SkinData.SkinManager.AnimEffects.Minimizing.Active and sp.SkinData.SkinManager.Effects.AllowAnimation then begin
      Result := True;
      sp.KillAnimations;
      if sp.FormState and FS_ANIMMINIMIZING <> 0 then
        Exit;

      sp.FormState := sp.FormState or FS_ANIMMINIMIZING;
      sp.fAnimating := True;
      if Assigned(sp.FormTimer) and not (sp.FormTimer is TacMinTimer) then
        FreeAndNil(sp.FormTimer);

      if not Assigned(sp.FormTimer) then
        sp.FormTimer := TacMinTimer.CreateOwned(sp, True)
      else
        if sp.FormState and FS_ANIMRESTORING = 0 then
          TacMinTimer(sp.FormTimer).InitData;

      sp.FormState := sp.FormState and not FS_ANIMRESTORING;
      if TacMinTimer(sp.FormTimer).CurrentAlpha >= TacMinTimer(sp.FormTimer).AlphaFrom then // If not in animation already
        if sp.BorderForm <> nil then
          with sp.BorderForm do begin
            UpdateExBordersPos(False); // Repaint cache
            SetBlurBehindWindow(AForm.Handle, False);
            TacMinTimer(sp.FormTimer).SavedImage.Assign(sp.SkinData.FCacheBmp); // Save cache

            Bmp := TacMinTimer(sp.FormTimer).SavedImage;
            sp.FormActive := True;
            sp.SkinData.BGChanged := True;
            sp.PaintAll;
            SavedDC := SaveDC(Bmp.Canvas.Handle);
            X := sp.OffsetX;
            Y := sp.OffsetY;
            ExcludeClipRect(Bmp.Canvas.Handle, X, Y, X + sp.Form.ClientWidth, Y + sp.Form.ClientHeight);
            try
              BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, sp.SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
            finally
              RestoreDC(Bmp.Canvas.Handle, SavedDC);
            end;

            ExBorderShowing := True;
            SetWindowPos(AForm.Handle, GetTopWindow, 0, 0, 0, 0, SWPA_ZORDER);
            SetWindowRgn(AForm.Handle, 0, False);
          end
        else begin
          if TacMinTimer(sp.FormTimer).SavedImage <> nil then
            FreeAndNil(TacMinTimer(sp.FormTimer).SavedImage);

          TacMinTimer(sp.FormTimer).SavedImage := GetFormImage(sp);
          if not sp.FormActive then begin
            sp.FormActive := True;
            sp.SkinData.BGChanged := True;
            sp.PaintAll;
            Bmp := TacMinTimer(sp.FormTimer).SavedImage;
            X := SysBorderWidth(sp.Form.Handle, nil);
            Y := SysCaptHeight(sp) + SysBorderHeight(sp.Form.Handle, nil);
            SavedDC := SaveDC(Bmp.Canvas.Handle);
            try
              ExcludeClipRect(Bmp.Canvas.Handle, X, Y, X + sp.Form.ClientWidth, Y + sp.Form.ClientHeight);
              BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, sp.SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
              if not sp.UWPNoBorderMode then
                FillAlphaRect(Bmp, Rect(0, 0, Bmp.Width, sp.CaptionHeight(True)), MaxByte);
            finally
              RestoreDC(Bmp.Canvas.Handle, SavedDC);
            end;
          end;
        end;

      if (sp.LayerForm <> nil) and IsWindowVisible(sp.LayerForm.Handle) then
        sp.LayerForm.Hide;

      if GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
        SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

      SetLayeredWindowAttributes(sp.Form.Handle, clNone, iAlphaNull, ULW_ALPHA);
      if not AeroIsEnabled then
        Sleep(4 * acTimerInterval); // Antiblinking

      if TacMinTimer(sp.FormTimer).StepCount > 1 then
        sp.FormTimer.Enabled := True
      else
        TacMinTimer(sp.FormTimer).TimeHandler;
    end;
  {$IFDEF D2007}
    if not Application.MainFormOnTaskBar then begin
      if sp.Form = Application.MainForm then
        h := Application.Handle
      else
        h := sp.Form.Handle;
    end
    else
  {$ENDIF}
      h := sp.Form.Handle;

    UpdatePreview(h, True);
    DwmInvalidateIconicBitmaps(h);
  end;
end;


function StartRestoring(sp: TsSkinProvider): boolean;
var
  h: THandle;
begin
  Result := True;
  if Assigned(sp.FormTimer) and (sp.FormTimer is TacMinTimer) and sp.SkinData.SkinManager.AnimEffects.Minimizing.Active and sp.SkinData.SkinManager.Effects.AllowAnimation then
    if sp.FormState and FS_ANIMRESTORING = 0 then begin
      sp.FormState := sp.FormState and not FS_ANIMMINIMIZING;
      sp.FormState := sp.FormState or FS_ANIMRESTORING;
      if sp.SkinData.SkinManager.Options.NativeBordersMaximized and sp.MaxRestore and (sp.BorderForm <> nil) then
        FreeAndNil(sp.BorderForm);

      sp.fAnimating := True;
      sp.SkinData.SkinManager.ShowState := saRestore;
      sp.FormActive := True;
      TacMinTimer(sp.FormTimer).InitDataRestore;
      if sp.BorderForm <> nil then begin
        sp.BorderForm.ExBorderShowing := True;
        if sp.BorderForm.AForm = nil then begin
          sp.BorderForm.CreateNewForm;
          SetFormBlendValue(sp.BorderForm.AForm.Handle, TacMinTimer(sp.FormTimer).AlphaBmp, 0);
        end;
        TacMinTimer(sp.FormTimer).AnimForm := sp.BorderForm.AForm;
        SetWindowPos(sp.BorderForm.AForm.Handle, GetTopWindow, 0, 0, 0, 0, SWPA_ZORDER);

        if GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
          SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

        SetLayeredWindowAttributes(sp.Form.Handle, clNone, iAlphaNull, ULW_ALPHA);
        sp.FormTimer.Enabled := True;
      end
      else
        if (sp.BorderForm <> nil) or not IsWinVistaUp or AeroIsEnabled then begin
          if GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
            SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

          SetLayeredWindowAttributes(sp.Form.Handle, clNone, iAlphaNull, ULW_ALPHA);
          sp.FormTimer.Enabled := True;
        end;

      TacMinTimer(sp.FormTimer).TimeHandler;
  {$IFDEF D2009}
      if not Application.MainFormOnTaskBar and (sp.Form = Application.MainForm) then
        h := Application.Handle
      else
  {$ENDIF}
        h := sp.Form.Handle;

      UpdatePreview(h, False);
    end;

  sp.SkipAnimation := False;
end;


procedure FinishBlendOnMoving(sp: TsSkinProvider; CoverForm: TacGlowForm = nil);
var
  TmpForm: TacGlowForm;
  i, cx, cy: integer;
begin
  if not sp.bFlag1 then begin
    sp.bFlag1 := True;
    if sp.BorderForm <> nil then
      with sp.BorderForm do begin
    {$IFDEF DELPHI7UP}
        if sp.Form.AlphaBlend then
          SetFormBlendValue(AForm.Handle, sp.SkinData.FCacheBmp, sp.Form.AlphaBlendValue)
        else
    {$ENDIF}
          SetFormBlendValue(AForm.Handle, sp.SkinData.FCacheBmp, MaxByte);

        if sp.FSysExHeight then
          cy := sp.ShadowSize.Top + DiffTitle(sp.BorderForm) + SysBorderWidth(sp.Form.Handle, sp.BorderForm, False) //  4 { For MinMax patching }
        else
          cy := sp.BorderForm.OffsetY;

        cx := SkinBorderWidth(sp.BorderForm) - SysBorderWidth(sp.Form.Handle, sp.BorderForm, False) + sp.ShadowSize.Left;
        SetWindowPos(sp.Form.Handle, AForm.HAndle, AForm.Left + cx, AForm.Top + cy, 0, 0, SWP_NOACTIVATE {Activate later} or SWP_NOSENDCHANGING or SWP_NOREDRAW or SWP_NOZORDER or SWP_NOOWNERZORDER or SWP_NOSIZE);
        sp.FormState := sp.FormState and not FS_BLENDMOVING;
        SendAMessage(sp.Form.Handle, AC_UPDATEFLOATITEMS);
    {$IFDEF DELPHI7UP}
        if sp.Form.AlphaBlend then begin
          ExBorderShowing := False;
          UpdateExBordersPos(True);
          SetLayeredWindowAttributes(sp.Form.Handle, clNone, sp.Form.AlphaBlendValue, ULW_ALPHA);
        end
        else
    {$ENDIF}
        begin
          if sp.BorderForm <> nil then
            SetWindowPos(sp.Form.Handle, AForm.Handle, 0, 0, 0, 0, SWPA_ZORDER);

          SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
        end;
        sp.SkinData.BGChanged := True; // Update a form cache (remove images of controls)
        if sp.HeaderUsed then
          SetParentUpdated(sp.Form);

        RedrawWindow(sp.Form.Handle, nil, 0, RDWA_ALLNOW);
//        if sp.Form <> Application.MainForm then
          Sleep(20); // Avoid a blinking
        // Activate
        SetWindowPos(sp.Form.Handle, 0, 0, 0, 0, 0, SWPA_ZORDER);
        if AeroIsEnabled and (sp.Form.Menu <> nil) then
          sp.ProcessMessage(WM_NCPAINT, 0, 0); // Menu repaint

        ExBorderShowing := False;
        UpdateExBordersPos(True); // Redraw and update region and z-order
        if (acMousePos.Y = acWorkRect(acMousePos).Top) and (sp.Form.BorderStyle in [bsSizeable]) and (biMaximize in sp.Form.BorderIcons) then
          sp.Form.WindowState := wsMaximized;
      end
    else begin
  {$IFDEF DELPHI7UP}
      if sp.Form.AlphaBlend then begin
        SetLayeredWindowAttributes(sp.Form.Handle, clNone, sp.Form.AlphaBlendValue, ULW_ALPHA);
        SendAMessage(sp.Form.Handle, AC_UPDATEITEMSALPHA, sp.Form.AlphaBlendValue);
      end
      else
  {$ENDIF}
      begin
        if CoverForm = nil then
          TmpForm := MakeCoverForm(sp.Form.Handle)
        else
          TmpForm := CoverForm;

        SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
        UpdateWindow(sp.Form.Handle);
        if Assigned(sp.FormTimer) then
          sp.FormTimer.Enabled := False;

        RedrawWindow(sp.Form.Handle, nil, 0, RDWA_ALLNOW);
        FreeAndNil(TmpForm);
      end;
      sp.FormState := sp.FormState and not FS_BLENDMOVING;
      SendAMessage(sp.Form.Handle, AC_UPDATEITEMSALPHA, MaxByte);
      SendAMessage(sp.Form.Handle, AC_UPDATEFLOATITEMS);
    end;
    for i := 0 to Length(GluedArray) - 1 do
      with GluedArray[i] do
        if (Master.Handle = sp.Form.Handle) and IsWindowVisible(Slave.Handle) then
          SendAMessage(Slave.Handle, AC_SETALPHA, MaxByte);

    if Assigned(sp.FormTimer) then begin
      TacMoveTimer(sp.FormTimer).CurrentBlendValue := MaxByte;
      FreeAndNil(sp.FormTimer);
    end;
    sp.bFlag1 := False;
  end;
end;


procedure StartBlendOnMoving(sp: TsSkinProvider; ToMove: boolean = True);
var
  TmpForm: TacGlowForm;
begin
  if sp.FormState and FS_BLENDMOVING = 0 then begin
    TmpForm := nil;
    sp.UpdateSlaveFormsList;
    if sp.SkinData.SkinManager.AnimEffects.BlendOnMoving.Active then begin
      sp.FormState := sp.FormState or FS_BLENDMOVING;
      SendAMessage(sp.Form.Handle, AC_UPDATEFLOATBITMAPS);
      if Assigned(sp.FormTimer) then
        FreeAndNil(sp.FormTimer);

      sp.FormTimer := TacMoveTimer.CreateOwned(sp, True);
      with TacMoveTimer(sp.FormTimer) do begin
  {$IFDEF DELPHI7UP}
        if sp.Form.AlphaBlend then
          CurrentBlendValue := sp.Form.AlphaBlendValue
        else
  {$ENDIF}
          CurrentBlendValue := MaxByte;

        BorderForm := sp.BorderForm;
        FormHandle := sp.Form.Handle;
        if sp.AllowBlendOnMoving then
          BlendValue := sp.SkinData.SkinManager.AnimEffects.BlendOnMoving.BlendValue
        else
          BlendValue := MaxByte;

        if sp.SkinData.SkinManager.AnimEffects.BlendOnMoving.Time > acTimerInterval then
          BlendStep := (MaxByte - BlendValue) / (sp.SkinData.SkinManager.AnimEffects.BlendOnMoving.Time / acTimerInterval) // * 2
        else
          BlendStep := MaxByte - BlendValue;

        Interval := acTimerInterval;
      end;
      if sp.BorderForm <> nil then
        with sp.BorderForm do begin
          SendAMessage(sp.Form.Handle, AC_KILLTIMERS);
          UpdateExBordersPos(False);
  {$IFDEF DELPHI7UP}
          if sp.Form.AlphaBlend then
            SetLayeredWindowAttributes(sp.Form.Handle, clNone, iAlphaNull, ULW_ALPHA);
  {$ENDIF}
          ExBorderShowing := True;
          SetWindowPos(sp.Form.Handle, AForm.Handle, 0, 0, 0, 0, SWPA_ZORDER);
          SetFormBlendValue(sp.Form.Handle, nil, 0);
          sp.FormTimer.Enabled := True;

          AForm.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
          MovRgnChanged := False;

          if (LastTopLeft.X <> -1) and (LastTopLeft.Y <> -1) then
            if (LastTopLeft.Y < 0) and IsWinVistaUp then // Avoid of a form auto aligning
              AForm.SetBounds(LastTopLeft.X, LastTopLeft.Y, AForm.Width, AForm.Height);
        end
      else begin
  {$IFDEF DELPHI7UP}
        if not sp.Form.AlphaBlend then
  {$ENDIF}
        begin
          TmpForm := MakeCoverForm(sp.Form.Handle);
          if GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
            SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

          SetLayeredWindowAttributes(sp.Form.Handle, clNone, MaxByte, ULW_ALPHA);
          RedrawWindow(sp.Form.Handle, nil, 0, RDWA_ALLNOW);
          ShowWindow(TmpForm.Handle, SW_HIDE);
        end;
        sp.FormTimer.Enabled := True;
        if ToMove then
          sp.Form.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
      end;
      if ToMove then
        FinishBlendOnMoving(sp, TmpForm);
    end;
  end;
end;
{$ENDIF} // NOWNDANIMATION


function GetFormImage(sp: TsSkinProvider; CacheReplaced: boolean = False): TBitmap;
var
  i: integer;
  SavedDC: hdc;
begin
  with sp, SkinData do
    if FCacheBmp <> nil then begin
      Result := CreateBmp32(FCacheBmp);
{$IFDEF ACDEBUG}
      acDebugAnimBmp := Result;
{$ENDIF}
      Result.Canvas.Lock;
      SavedDC := SaveDC(Result.Canvas.Handle);
      try
        SkinPaintTo(Result, Form, 0, 0, sp);
        if BorderForm = nil then begin
          if sp.UWPMode then
            FillAlphaRect(Result, sp.UWPClientRect, MaxByte)
          else
            FillAlphaRect(Result, MkRect(Result), MaxByte, clFuchsia, sp.Rects);

          for i := 0 to Length(sp.Rects) - 1 do
            FillRect32(Result, sp.Rects[i], 0, 0);
        end;
      finally
        RestoreDC(Result.Canvas.Handle, SavedDC);
        Result.Canvas.UnLock;
{$IFDEF ACDEBUG}
        acDebugAnimBmp := nil;
{$ENDIF}
      end;
      if CacheReplaced then
        FreeAndNil(FCacheBmp);
    end
    else
      Result := nil;
end;


type
  TacAccessDialogWnd = class(TacDialogWnd);

procedure StartSBAnimation(const Btn: PsCaptionButton; const State: integer; const Iterations: integer; const ToUp: boolean; const SkinProvider: TsSkinProvider; acDialog: pointer = nil);
var
  i: integer;
begin
  if not Application.Terminated then
    with Btn^ do
      if cpTimer = nil then begin
        if SkinProvider <> nil then
          with SkinProvider, SkinData.SkinManager.Effects do begin
            cpTimer := TacSBAnimation.Create(SkinProvider);
            cpTimer.BorderForm := BorderForm;
            cpTimer.FormHandle := Form.Handle;
            cpTimer.SkinData   := SkinData;
            i := max(1, integer(AllowAnimation) * Iterations);
          end
        else
          if acDialog <> nil then
            with TacAccessDialogWnd(acDialog), SkinData.SkinManager.Effects do begin
              cpTimer := TacSBAnimation.Create(Application);
              cpTimer.BorderForm := BorderForm;
              cpTimer.FormHandle := CtrlHandle;
              cpTimer.SkinData   := SkinData;
              i := max(1, integer(AllowAnimation) * Iterations);
            end
          else
            Exit;

        if (cpTimer <> nil) and not Application.Terminated then begin
          cpTimer.Enabled := False;
          cpTimer.PBtnData := Btn;
          cpTimer.MaxIterations := i;
          cpTimer.Interval := acTimerInterval;
          cpTimer.StartAnimation(cpState, True);
        end;
      end
      else begin
        if ToUp then
          cpTimer.CurrentState := cpState;

        cpTimer.MaxIterations := Iterations;
        cpTimer.Up := ToUp;
        cpTimer.Enabled := True;
        if cpState = 2 then begin
          FreeAndNil(cpTimer.ABmp);
          if cpTimer.AForm = nil then
            cpTimer.MakeForm;

          cpTimer.MakeImg;
        end;
        cpTimer.CurrentLevel := max(1, integer(cpTimer.SkinData.SkinManager.Effects.AllowAnimation) * Iterations); // Iterations;
      end;
end;


function IsMenuVisible(sp: TsSkinProvider): boolean;
begin
  with sp.Form do
    if (Menu <> nil) {$IFNDEF FPC}and not Menu.AutoMerge{$ENDIF} then
      Result := (Menu.Items.Count > 0) and (FormStyle <> fsMDIChild) and (BorderStyle <> bsDialog)
    else
      Result := False;
end;


function SysBorderWidth(const Handle: hwnd; const BorderForm: TacBorderForm; CheckSkin: boolean = True): integer;
var
  Style: ACNativeInt;
begin
  if CheckSkin then
    Result := SkinBorderWidth(BorderForm)
  else
    Result := 0;

  if Result = 0 then begin
    Style := GetWindowLong(Handle, GWL_STYLE);
    if Style and WS_THICKFRAME <> 0 then
      if (BorderForm = nil) or (BorderForm.SkinData.SkinManager = nil) then begin
        Result := SendAMessage(Handle, AC_GETBORDERWIDTH, MakeWParam(1, 0));
        if IsWin8Up and (BorderForm <> nil) then
          inc(Result, 4);
      end
      else
        Result := SendAMessage(Handle, AC_GETBORDERWIDTH, 1)
    else
      if Style and WS_BORDER <> 0 then begin
        if (BorderForm = nil) or (BorderForm.SkinData.SkinManager = nil) or (BorderForm.SkinData.CommonSkinData.ExDrawMode = 1) and (BorderForm.SkinData.SkinManager.ExtBordersMode = ebmFull) then
          Result := SendAMessage(Handle, AC_GETBORDERWIDTH, MakeWParam(2, 0))
        else
          Result := SendAMessage(Handle, AC_GETBORDERWIDTH, 2);
{$IFDEF DELPHI_11}
        if (WinMajorVer > 6) or (Style and WS_SIZEBOX <> 0) then
          inc(Result, 5);
{$ENDIF}
      end
      else
        Result := SendAMessage(Handle, AC_GETBORDERWIDTH, 3)
  end;
end;


function SysBorderHeight(const Handle: hwnd; const BorderForm: TacBorderForm; CheckSkin: boolean = True): integer;
begin
  if BorderForm = nil {Used in caption only when borders are std} then
    Result := SysBorderWidth(Handle, BorderForm, CheckSkin)
  else
    Result := 0;
end;


function SysCaptHeight(sp: TsSkinProvider; iDPI: integer = 0): integer;
var
  iParam: integer;
begin
  if sp <> nil then begin
    case sp.Form.BorderStyle of
      bsNone, bsSingle, bsSizeable:
        iParam := SM_CYCAPTION;

      bsDialog:
        if IsWin10Up and not IsIconic(sp.Form.Handle) then
          iParam := SM_CYSMCAPTION
        else
          iParam := SM_CYCAPTION

      else
        if IsIconic(sp.Form.Handle) then
          iParam := SM_CYCAPTION
        else
          iParam := SM_CYSMCAPTION;
    end;
    if iDPI = 0 then
      sp.CYCaption := ac_GetSysMetrics(iParam, GetControlPPI(sp.Form))
    else
      sp.CYCaption := ac_GetSysMetrics(iParam, iDPI);

    Result := sp.CYCaption;
  end
  else
    Result := SM_CYCAPTION;
end;


function SkinTitleHeight(const BorderForm: TacBorderForm): integer;
begin
  if BorderForm <> nil then
    with BorderForm, SkinData.CommonSkinData do
      if (sp <> nil) and IsZoomed(sp.Form.Handle) then
        Result := ExMaxHeight
      else
        Result := ExTitleHeight
  else
    Result := 0;
end;


function SkinBorderWidth(const BorderForm: TacBorderForm): integer;
begin
  if (BorderForm <> nil) and (BorderForm.SkinData.SkinManager <> nil) then
    Result := BorderForm.SkinData.CommonSkinData.ExBorderWidth
  else
    Result := 0;
end;


function SkinMenuOffset(const sp: TsSkinProvider): TPoint;
begin
  if sp.BorderForm <> nil then
    with sp, Form do begin
      Result.Y := CaptionHeight - SysCaptHeight(sp) + SysBorderHeight(Handle, BorderForm) - SysBorderHeight(Handle, BorderForm, False);
      Result.X := SysBorderWidth(Handle, BorderForm) - SysBorderWidth(Handle, BorderForm, False);
    end
  else
    Result := MkPoint;
end;


function DiffTitle(const BorderForm: TacBorderForm): integer;
begin
  if BorderForm <> nil then
    with BorderForm do
{      if sp.UWPMode then
        Result := -CaptionHeight(False) - SysBorderWidth(OwnerHandle, BorderForm, False)
      else}
        Result := CaptionHeight - CaptionHeight(False) - SysBorderWidth(OwnerHandle, BorderForm, False)
  else
    Result := 0;
end;


function DiffBorder(const BorderForm: TacBorderForm): integer;
begin
  if BorderForm <> nil then
    with BorderForm do
{      if BorderForm.sp.UWPMode then
        Result := -SysBorderWidth(OwnerHandle, BorderForm, False)
      else}
        Result := SysBorderWidth(OwnerHandle, BorderForm) - SysBorderWidth(OwnerHandle, BorderForm, False)
  else
    Result := 0;
end;


function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: DWORD; pvAttribute: Pointer; cbAttribute: DWORD): HResult;
begin
  if Assigned(_DwmSetWindowAttribute) then
    Result := _DwmSetWindowAttribute(hwnd, dwAttribute, pvAttribute, cbAttribute)
  else begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then begin
      _DwmSetWindowAttribute := GetProcAddress(hDWMAPI, 'DwmSetWindowAttribute');
      if Assigned(_DwmSetWindowAttribute) then
        Result := _DwmSetWindowAttribute(hwnd, dwAttribute, pvAttribute, cbAttribute);

      _DwmEnableBlurBehindWindow := GetProcAddress(hDWMAPI, 'DwmEnableBlurBehindWindow');
    end;
  end;
end;


var
  iAeroStatus: integer = -1;


function AeroIsEnabled: boolean;
var
  b: Longbool;
begin
  if iAeroStatus >= 0 then
    Result := iAeroStatus > 0
  else begin
    Result := False;
    if IsWinVistaUp then begin
      b := False;
      if Assigned(_DwmIsCompositionEnabled) then
        Result := _DwmIsCompositionEnabled(b) = S_OK
      else begin
        InitDwmApi;
        if hDWMAPI > 0 then begin
          _DwmIsCompositionEnabled := GetProcAddress(hDWMAPI, 'DwmIsCompositionEnabled');
          if Assigned(_DwmIsCompositionEnabled) then
            Result := _DwmIsCompositionEnabled(b) = S_OK;
        end
      end;
    end;
    Result := Result and b;
    iAeroStatus := integer(Result);
  end;
end;


function ForbidSysAnimating: boolean;
begin
  Result := not AeroIsEnabled;
end;


procedure InitDwm(const Handle: THandle; const Skinned: boolean; const Repaint: boolean = False);
var
  Policy: Longint;
begin
  if AeroIsEnabled then
    Policy := integer(Skinned); // DWMNCRP_DISABLED (if True) or DWMNCRP_USEWINDOWSTYLE

  DwmSetWindowAttribute(Handle, 3{DWMWA_TRANSITIONS_FORCEDISABLED}, @Policy, Sizeof(Policy));
end;


function IsBorderUnchanged(const BorderIndex: integer; const CommonSkinData: TacSkinData): boolean;
begin
  Result := (BorderIndex < 0) or (CommonSkinData.ma[BorderIndex].ImageCount = 1)
end;


function IsGripVisible(const sp: TsSkinProvider): boolean;
begin
  with sp, Form do
    Result := (GripMode = gmRightBottom) and not IsZoomed(Handle) and ((GetWindowLong(Handle, GWL_STYLE) and WS_SIZEBOX <> 0) or UWPMode and (FluentBorderStyle = bsSizeable));
end;


function InAnimation(const sp: TsSkinProvider): boolean;
begin
  Result := sp.FInAnimation; // Will be changed later for optimizing
end;


procedure PaintGrip(const aDC: hdc; const sp: TsSkinProvider);
var
  i, w1, w2, dx, h1, h2, dy: integer;
  BG: TacBGInfo;
  Bmp: TBitmap;
  p: TPoint;
  sSize: TRect;
begin
  with sp, FCommonData, CommonSkinData do begin
    i := sp.SkinData.CommonSkinData.GripRightBottom;
    if SkinManager.IsValidImgIndex(i) then begin
      Bmp := CreateBmp32(MkSize(ma[i]));
      p := RBGripPoint(i);
      BG.R := MkRect(Bmp);
      BG.PleaseDraw := False;
      FCacheBmp.Canvas.TryLock;
      GetBGInfo(@BG, Form);
      if BG.BgType <> btCache then begin
        FillDC(Bmp.Canvas.Handle, BG.R, BG.Color);
        w1 := ma[gd[SkinIndex].BorderIndex].WR;
        h1 := ma[gd[SkinIndex].BorderIndex].WB;
        w2 := SysBorderWidth(Form.Handle, BorderForm);
        h2 := w2;
        dx := w1 - w2;
        dy := h1 - h2;
        if (dx > 0) and (dy > 0) then begin
          sSize := ShadowSize;
          // Right border
          BitBlt(Bmp.Canvas.Handle, Bmp.Width - dx, 0, dx, Bmp.Height,
                 FCacheBmp.Canvas.Handle, FCacheBmp.Width - w1 - sSize.Right, FCacheBmp.Height - h2 - Bmp.Height - sSize.Bottom, SRCCOPY);
          // Bottom border
          BitBlt(Bmp.Canvas.Handle, 0, Bmp.Height - dy, Bmp.Width, dy,
                 FCacheBmp.Canvas.Handle, FCacheBmp.Width - w2 - Bmp.Width - sSize.Right, FCacheBmp.Height - h1 - sSize.Bottom, SRCCOPY);
        end;
      end
      else
        BitBlt(Bmp.Canvas.Handle, 0, 0, BG.R.Right, BG.R.Bottom, FCacheBmp.Canvas.Handle, p.X, p.Y, SRCCOPY);

      FCacheBmp.Canvas.UnLock;
      DrawSkinGlyph(Bmp, MkPoint, 0, 1, ma[i], MakeCacheInfo(Bmp));
      BitBlt(aDC, p.X, p.Y, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
      FreeAndNil(Bmp);
    end;
  end;
end;


function CtrlIsReadyForHook(const Ctrl: TWinControl): boolean;
begin
  with Ctrl do
    Result := HandleAllocated{$IFDEF TNTUNICODE} and Visible and (Parent <> nil){$ENDIF} // Showing is False when Parent changed
end;


type
  TacCaptForm = class(TacGlowForm)
  public
    SP: TsSkinProvider;
    procedure WndProc(var Message: TMessage); override;
  end;


function MaxBtnOffset(sp: TsSkinProvider; Max: boolean = False): integer;
var
  i1, i2: integer;
begin
  with sp do begin
    i1 := sp.ActualTitleHeight(Max);
    i2 := SysCaptHeight(sp);
    if i1 > i2 + 4 then // If skinned caption height is bigger than unskinned
      Result := i1 - (i2 + 4) {sbwf} // Get difference between captions
    else
      Result := 0;
  end;
end;


procedure TacCaptForm.WndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  YDelta: integer;
  DC: hdc;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_PAINT: begin
      DC := BeginPaint(Handle, PS);
      try
        if (SP <> nil) and (SP.SkinData <> nil) and (SP.SkinData.FCacheBmp <> nil) then
          if SP.BorderForm <> nil then begin // If paint menu only
            YDelta := SP.Form.BorderWidth + SP.LinesCount * SP.MenuHeight + 1;
            BitBlt(DC, 0, 0, Width, Height, SP.SkinData.FCacheBmp.Canvas.Handle, SP.OffsetX - SP.Form.BorderWidth, SP.OffsetY - YDelta, SRCCOPY);
          end
          else
            BitBlt(DC, 0, 0, Width, Height, SP.SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      finally
        EndPaint(Handle, PS);
      end;
    end;

    WM_NCPAINT, WM_ERASEBKGND:
      Message.Result := 1

    else
      inherited;
  end;
end;


type
  TEnumRgnData = record
    Rgn: hrgn;
    OwnerHandle: THandle;
  end;
  PEnumRgnData = ^TEnumRgnData;


procedure acCheckTopWindows(CurWnd: hwnd; var Data: TEnumRgnData);
var
  Wnd: hwnd;
  Rgn: hrgn;
  R, EnumR: TRect;
begin
  Wnd := GetNextWindow(CurWnd, GW_HWNDPREV);
  if Wnd <> 0 then begin
    if IsWindowVisible(Wnd) and (GetParent(Wnd) = 0) then begin
      GetWindowRect(Data.OwnerHandle, R);
      GetWindowRect(Wnd, EnumR);
      if EnumR.Left <> EnumR.Right then begin
        OffsetRect(EnumR, -R.Left, -R.Top);
        Rgn := CreateRectRgn(EnumR.Left, EnumR.Top, EnumR.Right, EnumR.Bottom);
        CombineRgn(Data.Rgn, Data.Rgn, Rgn, RGN_DIFF);
        DeleteObject(Rgn);
      end;
    end;
    acCheckTopWindows(Wnd, Data);
  end;
end;


procedure MakeCaptForm(sp: TsSkinProvider; Full: boolean = False);
var
  DC: hdc;
  cR: TRect;
  Rgn, SubRgn: hrgn;
  EnumData: TEnumRgnData;
  t, h, l, w: integer;
begin
{$IFNDEF ALITE}
  if GetIntController.PopupCount(nil) <= 0 then
{$ENDIF}  
    with sp do
      if CanDrawNCArea and not UWPMode and (Form.Enabled or not DisabledBlured) and not InAnimation(sp) and (Form.WindowState <> wsMinimized) and Form.Showing then
        if (BorderForm = nil) or (Form.Menu <> nil) then begin
          if (Form.FormStyle = fsMDIChild) and (MDISkinProvider <> nil) and
               (TsSkinProvider(MDISkinProvider).LockCount > 0) or (FormState and FS_BLENDMOVING <> 0) then
            Exit;

          if CaptForm = nil then begin
            CaptForm := TacCaptForm.CreateNew(Application);
            CaptForm.Name := sp.Form.Name + 'CaptForm' + IntToStr(GetTickCount);
            TacCaptForm(CaptForm).SP := sp;

            if CaptForm = nil then
              Exit;

            CaptForm.HandleNeeded;
            if not CaptForm.HandleAllocated then begin
              FreeAndNil(CaptForm);
              Exit;
            end;
          end;
          if BorderForm <> nil then begin
            h := MenuHeight * LinesCount + 1;
            t := Form.Top + OffsetY - h - ShadowSize.Top - DiffTitle(BorderForm);
            if IsZoomed(SP.Form.Handle) and (GetWindowLong(SP.Form.Handle, GWL_STYLE) and WS_CAPTION <> 0) then
              dec(t, 4);

            l := Form.Left + SysBorderWidth(Form.Handle, BorderForm, False);
            w := Form.Width - 2 * SysBorderWidth(Form.Handle, BorderForm, False);
          end
          else begin
            h := Form.Height;
            w := Form.Width;
            if (Form.Parent = nil) and (Form.FormStyle <> fsMDIChild) then begin
              t := Form.Top;
              l := Form.Left;
            end
            else begin
              GetWindowRect(Form.Handle, cR);
              t := cR.Top;
              l := cR.Left;
            end;

            if sp.Form.WindowState = wsMaximized then begin
              cR := acWorkRect(sp.Form);
              OffsetRect(cR, -sp.Form.Left, -sp.Form.Top);
              Rgn := CreateRectRgn(cR.Left, cR.Top, cR.Right, cR.Bottom);
            end
            else
              Rgn := GetRgnFromArOR(sp);

            EnumData.Rgn := Rgn;
            EnumData.OwnerHandle := Form.Handle;
            acCheckTopWindows(Form.Handle, EnumData);

            cR := acClientRect(Form.Handle);
            SubRgn := CreateRectRgn(cR.Left, cR.Top, cR.Right, cR.Bottom);
            CombineRgn(Rgn, Rgn, SubRgn, RGN_DIFF);
            DeleteObject(SubRgn);

            if (Form.Parent <> nil) or (Form.FormStyle = fsMDIChild) then begin
              DC := GetDC(Form.Handle);
              if GetClipBox(DC, cR) = NULLREGION then begin
                FreeAndNil(CaptForm);
                ReleaseDC(Form.Handle, DC);
                Exit;
              end;
              if (cR.Left < cR.Right) and (cR.Top < cR.Bottom) then begin
                SubRgn := CreateRectRgn(cR.Left, cR.Top, cR.Right, cR.Bottom);
                CombineRgn(Rgn, Rgn, SubRgn, RGN_AND);
                DeleteObject(SubRgn);
              end;
              ReleaseDC(Form.Handle, DC);
            end;
            SetWindowRgn(CaptForm.Handle, Rgn, False);
          end;
          CaptForm.SetBounds(l, t, w, h);
          if Form.FormStyle = fsMDIChild then
            SetWindowPos(CaptForm.Handle, 0, l, t, Form.Width, HeaderHeight, SWPA_SHOW)
          else
            if GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0 then
              SetWindowPos(CaptForm.Handle, HWND_TOPMOST, l, t, w, h, SWPA_SHOW)
            else
              SetWindowPos(CaptForm.Handle, HWND_TOP{GetNextWindow(sp.Form.Handle, GW_HWNDPREV)}, l, t, w, h, SWPA_SHOW);

          ShowWindow(CaptForm.Handle, SW_SHOWNOACTIVATE);
          RedrawWindow(CaptForm.Handle, nil, 0, RDWA_ERASENOW);
          Sleep(40); // Delay for borders repaint, avoid a blinking
        end;
end;


procedure KillCaptForm(sp: TsSkinProvider);
begin
  FreeAndNil(sp.CaptForm);
end;


procedure FillArOR(sp: TsSkinProvider);
var
  i, j: integer;
  MaskBmp: TBitmap;
begin
  with sp, SkinData, SkinManager, SkinData.CommonSkinData do
    if IsValidIndex(SkinIndex, Length(gd)) then begin
      SetLength(Rects, 0);
      if IsValidImgIndex(gd[SkinIndex].BorderIndex) then begin
        // TopBorderRgn
        AddRgn(Rects, CaptionWidth, ma[gd[SkinIndex].BorderIndex], 0, False);
        // BottomBorderRgn
        AddRgn(Rects, CaptionWidth, ma[gd[SkinIndex].BorderIndex], Form.Height - ma[gd[SkinIndex].BorderIndex].WB, True);
      end
      else
        if sp.FGenData <> nil then
          with sp.FGenData^ do
            if BorderRadius > 0 then begin
              MaskBmp := GetRoundMask(BorderRadius);
              // TopBorderRgn
              AddRgn(Rects, MaskBmp, MkRect(MaskBmp), CaptionWidth, BorderRadius, BorderRadius, BorderRadius, BorderRadius, 0, False, False, TColor($FFFFFFFF));
              // BottomBorderRgn
              AddRgn(Rects, MaskBmp, MkRect(MaskBmp), CaptionWidth, BorderRadius, BorderRadius, BorderRadius, BorderRadius, Form.Height - BorderRadius, True, False, TColor($FFFFFFFF));
            end;
      // TitleRgn
      j := FTitleSkinIndex;
      if IsValidSkinIndex(j) then begin
        i := GetMaskIndex(j, s_BordersMask, SkinData.CommonSkinData);
        if IsValidImgIndex(i) then
          AddRgn(Rects, CaptionWidth, ma[i], 0, False)
        else
          with gd[j] do
            if BorderRadius > 0 then begin
              MaskBmp := GetRoundMask(BorderRadius);
              AddRgn(Rects, MaskBmp, MkRect(MaskBmp), CaptionWidth, BorderRadius, BorderRadius, BorderRadius, BorderRadius, 0, False, False, TColor($FFFFFFFF));
            end;
      end;
    end;
end;


function IsSizeBox(Handle: hWnd): boolean;
begin
  Result := GetWindowLong(Handle, GWL_STYLE) and WS_SIZEBOX <> 0;
end;


function HaveBorder(sp: TsSkinProvider): boolean;
begin
  with sp.Form do
    Result := (BorderStyle <> bsNone) or (GetWindowLong(Handle, GWL_STYLE) and WS_CHILD <> 0) or sp.IsBlurred or (sp.FluentBorderStyle <> bsNone);
end;


procedure UpdateRgn(sp: TsSkinProvider; DoRepaint: boolean = True; AllChildren: boolean = False);
const
  BE_ID = $41A2;
  CM_BEWAIT = CM_BASE + $0C4D;
var
  R: TRect;
  rgn: HRGN;
  sbw, i: integer;
begin
  with sp, Form do
    if CanDrawNCArea and HandleAllocated and not InMenu and (HaveBorder(sp) or (SkinData.SkinManager.gd[SkinData.SkinIndex].BorderRadius > 0) or IsIconic(Handle) or IsSizeBox(Handle)) then begin
      if not FirstInitialized and (TrySendMessage(Handle, CM_BEWAIT, BE_ID, 0) = BE_ID) then
        Exit; // BE compatibility

      if (Parent = nil) or (DragKind <> dkDock) {regions changing disabled when docking used} then begin
        RgnChanging := True;
        if UWPNoBorderMode then begin
          R := sp.UWPClientRect;
          if Form.WindowState = wsMaximized then
            dec(R.Top, SysCaptHeight(sp));

          with R do
            rgn := CreateRectRgn(Left, Top, Right, Bottom);
        end
        else
          if BorderForm <> nil then begin
            if BorderStyle = bsNone then begin
              sbw := 0;
              i := 0;
            end
            else begin
              sbw := SysBorderWidth(Handle, BorderForm, False);
              if FSysExHeight then
                i := SysCaptHeight(sp) + SysBorderWidth(Handle, BorderForm, False)
              else
                i := SysBorderHeight(Handle, BorderForm, False) + SysCaptHeight(sp) + SysBorderWidth(Handle, BorderForm, False);

              if UWPMode and (Form.WindowState = wsMaximized) then
                dec(i, SysCaptHeight(sp));
            end;
            rgn := CreateRectRgn(sbw, i, Width - sbw, Height - sbw);
          end
          else
            if IsZoomed(Handle) and (Constraints.MaxWidth = 0) and (Constraints.MaxHeight = 0) and (FormStyle <> fsMDIChild) then begin
              R := MkRect(Form);
              InflateRect(R, - SysBorderWidth(Handle, BorderForm, False), - SysBorderHeight(Handle, BorderForm, False));
              rgn := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
            end
            else
              rgn := GetRgnFromArOR(sp);

        RgnChanged := False;
        if AllChildren then begin
          if SetWindowRgn(Handle, rgn, DoRepaint{ True - repainting is required }) = 0 then
            CheckLastError;
        end
        else begin
          if SetWindowRgn(sp.Form.Handle, rgn, True) = 0 then
            CheckLastError;

          if DoRepaint and IsWindowVisible(Handle) then begin
            RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_NOCHILDREN);
            ProcessMessage(WM_NCPAINT, 0, 0);
          end;
        end;
        RgnChanging := False;
      end
      else
        SetWindowRgn(Handle, 0, False);
    end;
end;


function GetRgnFromArOR(sp: TsSkinProvider; X: integer = 0; Y: integer = 0): hrgn;
var
  l, i: integer;
  subrgn: HRGN;
begin
  with sp do begin
    l := Length(Rects);
    i := CaptionWidth + X;
    Result := CreateRectRgn(X, Y, i, Form.Height + Y);
    if l > 0 then
      for i := 0 to l - 1 do
        with sp.Rects[i] do begin
          subrgn := CreateRectRgn(Left + X, Top + Y, Right + X, Bottom + Y);
          CombineRgn(Result, Result, subrgn, RGN_DIFF);
          DeleteObject(subrgn);
        end;
  end;
end;


procedure RefreshFormScrolls(SkinProvider: TsSkinProvider; var ListSW: TacScrollWnd; Repaint: boolean);
var
  sp: TacSkinParams;
begin
  with SkinProvider do
    if not (csDestroying in ComponentState) and Form.HandleAllocated and (FormState and FS_SCROLLUPDATING = 0) then begin
      FormState := FormState or FS_SCROLLUPDATING;
      if SkinData.Skinned then begin
        if Assigned(Ac_UninitializeFlatSB) then
          Ac_UninitializeFlatSB(Form.Handle);

        if (ListSW <> nil) and ListSW.Destroyed then
          FreeAndNil(ListSW);

        if ListSW = nil then
          with sp do begin
            SkinSection := '';
            HorzScrollBtnSize := -1;
            VertScrollBtnSize := -1;
            HorzScrollSize := -1;
            VertScrollSize := -1;
            Control := Form;
            ListSW := TacScrollWnd.Create(Form.Handle, SkinData, SkinData.SkinManager, sp, False);
          end;
      end
      else begin
        if ListSW <> nil then
          FreeAndNil(ListSW);

        if Assigned(Ac_InitializeFlatSB) then
          Ac_InitializeFlatSB(Form.Handle);
      end;
      FormState := FormState and not FS_SCROLLUPDATING;
    end;
end;


procedure UpdateSkinCaption(SkinProvider: TsSkinProvider);
var
  DC, SavedDC: hdc;
begin
  with SkinProvider do begin
    if InAnimation(SkinProvider) or not Form.visible or not CanDrawNCArea or
         (csDestroyingHandle in Form.ControlState) or not SkinData.Skinned then
      Exit;

    if (TForm(Form).FormStyle = fsMDIChild) and (Form.WindowState = wsMaximized) then begin
      TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
      DC := GetWindowDC(TsSkinProvider(MDISkinProvider).Form.Handle);
      SavedDC := SaveDC(DC);
      try
        TsSkinProvider(MDISkinProvider).PaintCaption(DC);
      finally
        RestoreDC(DC, SavedDC);
        ReleaseDC(TsSkinProvider(MDISkinProvider).Form.Handle, DC);
      end;
    end
    else
      if BorderForm = nil then begin
        FCommonData.BGChanged := True;
        DC := GetWindowDC(Form.Handle);
        SavedDC := SaveDC(DC);
        try
          if SkinData.FCacheBmp = nil then // Preventing of painting before ExBorders, usually when MainMenu exists
            InitExBorders(SkinData.SkinManager.ExtendedBorders);

          PaintCaption(DC);
        finally
          RestoreDC(DC, SavedDC);
          ReleaseDC(Form.Handle, DC);
        end;
      end
      else begin
        if FGlow1 <> nil then
          FreeAndNil(SkinProvider.FGlow1);

        if FGlow2 <> nil then
          FreeAndNil(SkinProvider.FGlow2);

        FCommonData.BGChanged := True;
        if Form.Menu <> nil then
          ProcessMessage(WM_NCPAINT);

        BorderForm.UpdateExBordersPos;
      end;
  end;
end;


function GetNearestSize(Max: integer): integer;
begin
  case Max of
    -100..47:  Result := 16;
    48..64:  Result := 24
    else     Result := 32
  end;
end;


function GetSkinProvider(Cmp: TComponent): TsSkinProvider;
var
  c: TComponent;
begin
  c := Cmp;
  while Assigned(c) and not (c is TCustomForm) do
    c := c.Owner;

  if c is TCustomForm then
    Result := TsSkinProvider(TrySendMessage(TCustomForm(c).Handle, SM_ALPHACMD, AC_GETPROVIDER_HI, 0))
  else
    Result := nil;
end;


function TitleIconWidth(sp: TsSkinProvider): integer;
begin
  with sp, TitleIcon do
    if IconVisible then
      if Width <> 0 then
        Result := Width
      else
        if Glyph.Width <> 0 then
          Result := Glyph.Width
        else
          Result := GetNearestSize(CaptionHeight - sp.SkinData.CommonSkinData.BITopMargin)
    else
      Result := 0;
end;


function TitleIconHeight(sp: TsSkinProvider): integer;
begin
  with sp, TitleIcon do
    if IconVisible then
      if Height <> 0 then
        Result := Height
      else
        if Glyph.Height <> 0 then
          Result := Glyph.Height
        else
          Result := GetNearestSize(CaptionHeight - sp.SkinData.CommonSkinData.BITopMargin)
    else
      Result := 0;
end;


procedure DrawAppIcon(SkinProvider: TsSkinProvider);
var
  R: TRect;
  Ico: hicon;
  Bmp: TBitmap;
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  iW, iH, x, y, h, w, DeltaS, DeltaD: integer;
begin
  with SkinProvider, TitleIcon do
    if IconVisible then begin
      R := FIconRect;
      if not Glyph.Empty then begin
        if Glyph.PixelFormat <> pf32bit then begin
          Glyph.PixelFormat := pf32bit;
          h := Glyph.Height - 1;
          w := Glyph.Width - 1;
          if InitLine(Glyph, Pointer(S0), DeltaS) then
            for y := 0 to h do begin
              S := Pointer(PAnsiChar(S0) + DeltaS * Y);
              for x := 0 to w do
                with S[x] do
                  if sFuchsia.C <> S[x].SC then
                    SA := MaxByte
            end;
        end;
        Glyph.Transparent := True;
        Glyph.TransparentColor := clFuchsia;

        iW := iff(Width = 0,  Glyph.Width,  Width);
        iH := iff(Height = 0, Glyph.Height, Height);
        if SkinData.SkinManager <> nil then begin
          iW := ScaleInt(iW, SkinProvider.SkinData);
          iH := ScaleInt(iH, SkinProvider.SkinData);
        end;

        if Glyph.PixelFormat = pf32bit then
          if (SkinProvider.TitleIcon.Glyph.Width = iW) or (Glyph.Height = iH) then
            CopyByMask(Rect(R.Left, R.Top, R.Left + Glyph.Width, R.Left + Glyph.Height),
                     MkRect(Glyph), FCommonData.FCacheBmp, Glyph, EmptyCI, False)
          else
            DrawBmp(FCommonData.FCacheBmp.Canvas, Glyph, Rect(R.Left, R.Top, R.Left + iW, R.Top + iH), False)
        else
          FCommonData.FCacheBmp.Canvas.StretchDraw(Rect(R.Left, R.Top, R.Left + iW, R.Top + iH), Glyph);
      end
      else begin
        Bmp := CreateBmp32(R);
        BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
        if TForm(Form).Icon.Handle <> 0 then
          DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, TForm(Form).Icon.Handle, Bmp.Width, Bmp.Height, 0, 0, DI_NORMAL)
        else
          if Application.Icon.Handle <> 0 then begin
            Ico := hicon(SendMessage(Application.{$IFNDEF FPC}Handle{$ELSE}MainFormHandle{$ENDIF}, WM_GETICON, iff(Bmp.Height > 16, 1{ICON_BIG}, 2{ICON_SMALL2}), 0));
            if Ico <> 0 then
              DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, Ico, Bmp.Width, Bmp.Height, 0, 0, DI_NORMAL);
          end
          else begin
            iW := iff(TitleIcon.Width = 0,  max(10, WidthOf(R)), TitleIcon.Width);
            iH := iff(TitleIcon.Height = 0, max(10, HeightOf(R)), TitleIcon.Height);
            if (iH > 16) and (AppIconLarge <> nil) then
              DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, AppIconLarge.Handle, iW, iH, 0, 0, DI_NORMAL)
            else
              if AppIcon <> nil then
                DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, AppIcon.Handle, iW, iH, 0, 0, DI_NORMAL)
              else
                DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, LoadIcon(0, IDI_APPLICATION), Bmp.Width, Bmp.Height, 0, 0, DI_NORMAL);
          end;

        w := Bmp.Width - 1;
        h := Bmp.Height - 1;
        if InitLine(Bmp, Pointer(S0), DeltaS) and InitLine(FCommonData.FCacheBmp, Pointer(D0), DeltaD) then
          for y := max(0, -R.Top) to h do begin
            S := Pointer(PAnsiChar(S0) + DeltaS * Y);
            D := Pointer(PAnsiChar(D0) + DeltaD * (y + R.Top));
            for x := 0 to w do
              with D[x + R.Left] do
                if DI <> S[x].SI then
                  DA := MaxByte
                else
                  DI := S[x].SI;
          end;

        FreeAndNil(Bmp);
      end;
    end;
end;


function GetWindowWidth(Handle: hwnd): integer;
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  Result := WidthOf(R)
end;


function GetClientWidth(Handle: hwnd): integer;
var
  R: TRect;
begin
  GetClientRect(Handle, R);
  Result := WidthOf(R)
end;


function GetWindowHeight(Handle: hwnd): integer;
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  Result := HeightOf(R)
end;


function GetClientHeight(Handle: hwnd): integer;
var
  R: TRect;
begin
  GetClientRect(Handle, R);
  Result := HeightOf(R)
end;


procedure UpdateProviderThirdNames(sp: TsSkinProvider);
var
  i: integer;
begin
  if Assigned(sp) then
    for i := 0 to High(acThirdNames) do
      sp.ThirdParty.SetString(i, sp.ThirdLists[i].Text);
end;


procedure TsSkinProvider.AfterConstruction;
begin
  inherited;
  if Form <> nil then begin
    Load3rdNames(ThirdParty, ThirdLists, OwnThirdLists);
    if not RTEmpty and not RTInit and Assigned(FCommonData.SkinManager) and FCommonData.SkinManager.Active and not (csDesigning in ComponentState) then
      PrepareForm;
  end;
end;


type
  TacScaleThread = class(TThread)
  protected
    p: TPoint;
    lTicks: DWord;
    NewBoundsRect: TRect;
    CanRecreate: boolean;
    FOnTimer: TNotifyEvent;
    TimeEvent: TSimpleEvent;
    SrcBmp, NewAlphaBmp: TBitmap;
    ThreadCoverForm: TacGlowForm;
    OldPPI, DeltaX, DeltaY, DeltaCX, DeltaCY: integer;
    procedure DoTimer;
  public
    procedure Execute; override;
    destructor Destroy; override;
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
  end;


procedure TsSkinProvider.AnimChangeScale(NewPPI: integer; DoRecreate: boolean);
var
  DC: hdc;
  SrcX, SrcY: integer;
begin
  if AllowScale then begin
    FScaleThread := TacScaleThread.Create(True);
    SkinData.CtrlSkinState := SkinData.CtrlSkinState or FS_SCALING;
    SendAMessage(Form.Handle, AC_UPDATEFLOATITEMS);
    with TacScaleThread(FScaleThread) do begin
      Priority := tpHighest;
      CanRecreate := DoRecreate;
      FreeOnTerminate := True;
      TimeEvent := TSimpleEvent.Create;
      TimeEvent.ResetEvent;
      OldPPI := SkinData.CurrentPPI;
      // Make screenshot of form and create layered form
      if BorderForm <> nil then begin
        ThreadCoverForm := BorderForm.AForm;
//        ThreadCoverForm.Name := Form.Name + 'Scale' + IntToStr(GetTickCount);
        BorderForm.Locked := True;
        SetBlurBehindWindow(ThreadCoverForm.Handle, False);
        SrcBmp := TBitmap.Create;
        SrcBmp.Assign(SkinData.FCacheBmp);
        // Copy the window image
        DC := GetDC(0);
        try
          p.x := OffsetX;
          p.y := OffsetY;
          SrcX := Form.Left;
          SrcY := Form.Top;
          if {(Form.BorderStyle <> bsNone) and} not UWPMode then begin
            SrcX := SrcX + SysBorderWidth(Form.Handle, nil, False);
            SrcY := SrcY + SysCaptHeight(Self) + SysBorderHeight(Form.Handle, nil, False);
          end;

          BitBlt(SrcBmp.Canvas.Handle, p.x, p.y, Form.ClientWidth, Form.ClientHeight, DC, SrcX, SrcY, SRCCOPY);

          FillAlphaRect(SrcBmp, Rect(p.x, p.y, p.x + Form.ClientWidth, p.y + Form.ClientHeight), MaxByte);
          p.x := ThreadCoverForm.Left;
          p.y := ThreadCoverForm.Top;
          SetFormBlendValue(ThreadCoverForm.Handle, SrcBmp, MaxByte, @p);
        finally
          ReleaseDC(0{Form.Handle}, DC);
        end;
      end
      else begin
        ThreadCoverForm := MakeCoverForm(Form.Handle);
        SrcBmp := ThreadCoverForm.AlphaBmp;
      end;

      ShowWindow(ThreadCoverForm.Handle, SW_SHOWNA);
      SetWindowRgn(ThreadCoverForm.Handle, 0, False);
      if GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
        SetWindowLong(Form.Handle, GWL_EXSTYLE, GetWindowLong(Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

      SetLayeredWindowAttributes(Form.Handle, clNone, 0, ULW_ALPHA);

      NewBoundsRect.Right := ThreadCoverForm.Width * NewPPI div OldPPI;
      NewBoundsRect.Bottom := ThreadCoverForm.Height * NewPPI div OldPPI;
      NewBoundsRect.Left := ThreadCoverForm.Left - (NewBoundsRect.Right - ThreadCoverForm.Width) div 2;
      NewBoundsRect.Top := ThreadCoverForm.Top - (NewBoundsRect.Bottom - ThreadCoverForm.Height) div 2;

      if NewAlphaBmp <> nil then
        NewAlphaBmp.Free;
        
      NewAlphaBmp := TBitmap.Create;
      NewAlphaBmp.PixelFormat := pf32bit;
      NewAlphaBmp.IgnorePalette := True;
      NewAlphaBmp.Width := ThreadCoverForm.Width;
      NewAlphaBmp.Height := ThreadCoverForm.Height;
      p.x := ThreadCoverForm.Left;
      p.y := ThreadCoverForm.Top;
      OnTimer := OnScaleTimer;
{$IFDEF DELPHI6UP}
  {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}
      Resume;
    end;
  end;
end;


procedure TsSkinProvider.OnScaleTimer(Sender: TObject);
var
  ObscForm: TacGlowForm;
begin
  with TacScaleThread(Sender) do
    if not Terminated then
      if (abs(NewBoundsRect.Right - NewAlphaBmp.Width) > 2) or (abs(NewBoundsRect.Bottom - NewAlphaBmp.Height) > 2) then begin
        lTicks := GetTickCount;
        NewAlphaBmp.Width := NewAlphaBmp.Width + (NewBoundsRect.Right - NewAlphaBmp.Width) div 2;
        NewAlphaBmp.Height := NewAlphaBmp.Height + (NewBoundsRect.Bottom - NewAlphaBmp.Height) div 2;
        acgpStretchRect(NewAlphaBmp, SrcBmp, MkRect(NewAlphaBmp.Width + 1, NewAlphaBmp.Height + 1), MkRect(SrcBmp.Width, SrcBmp.Height));
        SetFormBlendValue(ThreadCoverForm.Handle, NewAlphaBmp, MaxByte, @p);
      end
      else
        if not (msScaleChanging in SkinData.SkinManager.ManagerState) then begin // Finish
          if BorderForm <> nil then begin
            DeltaX := SkinBorderWidth(BorderForm) - SysBorderWidth(Form.Handle, BorderForm, False) + ShadowSize.Left;
            if FSysExHeight then
              DeltaY := ShadowSize.Top + DiffTitle(BorderForm) + SysBorderWidth(Form.Handle, BorderForm, False) //  4 { For MinMax patching }
            else
              DeltaY := BorderForm.OffsetY;
          end
          else begin
            DeltaX := 0;
            DeltaY := NewAlphaBmp.Height - Form.Height;
          end;
          Form.SetBounds(p.x + DeltaX, p.y + DeltaY, Form.Width, Form.Height);
          ObscForm := MakeCoverForm(Form.Handle);
          // Final repainting of the form
          SetWindowLong(Form.Handle, GWL_EXSTYLE, GetWindowLong(Form.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
          if BorderForm <> nil then begin
            SkinData.BGChanged := True;
            BorderForm.Locked := False;
            BorderForm.ExBorderShowing := False;
            BorderForm.UpdateExBordersPos;
            SrcBmp.Free;
          end
          else begin
            ShowWindow(ThreadCoverForm.Handle, SW_HIDE);
            FreeAndNil(ThreadCoverForm);
          end;

          SkinData.CtrlSkinState := SkinData.CtrlSkinState and not FS_SCALING;

          if NewAlphaBmp <> nil then
            FreeAndNil(NewAlphaBmp);

          if CanRecreate and IsWin10Up then begin
            Form.Perform(CM_RECREATEWND, 0, 0);
            SystemBlur.UpdateBlurMode(True);
          end;

          SendAMessage(Form.Handle, AC_UPDATEFLOATITEMS);
          if SkinData.TranspMode > 0 then
            IterateControls(Form, 0, RepaintOpaque);

          ObscForm.Free;

          TimeEvent.Free;
          Terminate;
        end
end;


function TsSkinProvider.BarWidth(const i: integer): integer;
begin
  Result := (FCommonData.CommonSkinData.ma[i].Width) * 2 + TitleBtnsWidth;
end;


function TsSkinProvider.BorderHeight(CheckSkin: boolean = True): integer;
begin
  Result := SysBorderHeight(Form.Handle, BorderForm, CheckSkin) + Form.BorderWidth
end;


function TsSkinProvider.BorderWidth(CheckSkin: boolean = True): integer;
begin
  Result := SysBorderWidth(Form.Handle, BorderForm, CheckSkin) + Form.BorderWidth;
end;


function TsSkinProvider.ButtonHeight: integer;
begin
  with SkinData.CommonSkinData do
    if FCommonData.SkinManager.IsValidImgIndex(TitleGlyphs[tgClose]) then
      Result := ma[TitleGlyphs[tgClose]].Height
    else
      Result := 21;
end;


function TsSkinProvider.SysButtonsCount: integer;
begin
  Result := 0;
  if Assigned(SystemMenu) and HaveSysMenu then begin
    inc(Result);
    if SystemMenu.VisibleMax then
      inc(Result);

    if SystemMenu.VisibleMin then
      inc(Result);

    if (biHelp in Form.BorderIcons) then
      inc(Result);
  end;
end;


function TsSkinProvider.SysButtonWidth(const Btn: TsCaptionButton): integer;
begin
  with SkinData.CommonSkinData do
    if FCommonData.SkinManager.IsValidImgIndex(TitleGlyphs[Btn.cpGlyphType]) then
      Result := ma[TitleGlyphs[Btn.cpGlyphType]].Width
    else
      Result := 21;
end;


function TsSkinProvider.SysRTLAllowed: boolean;
begin
  Result := (Form.BidiMode = bdRightToLeft) and SkinData.SkinManager.ButtonsOptions.AllowRTLSysButtons;
end;


function TsSkinProvider.CaptionHeight(CheckSkin: boolean = True): integer;
begin
  if HaveBorder(Self) and (GetWindowLong(Form.Handle, GWL_STYLE) and WS_CAPTION <> 0) or IsIconic(Form.Handle) then begin
    if CheckSkin then
      Result := SkinTitleHeight(BorderForm)
    else
      Result := 0;

    if FSysExHeight then // Used for GetMinMax message ('Y' can't be smaller then Zero there)
      Result := max(Result, SysCaptHeight(Self) + 4)
    else
      if Result = 0 then
        Result := SysCaptHeight(Self);
  end
  else
    Result := 0;
end;


{$IFNDEF DISABLEPREVIEWMODE}
procedure TrySayHelloToEditor(const aHandle: THandle);
var
  h: hwnd;
  Count: integer;
begin
  if acPreviewNeeded and (acPreviewHandle = 0) then
    with Application do
      if (MainForm <> nil) and MainForm.HandleAllocated and (MainForm.Handle = aHandle) or (MainForm = nil) then begin
        acPreviewHandle := aHandle;
        acPreviewNeeded := False;
        for Count := 0 to 100 do begin
          h := FindWindow(nil, PChar(s_EditorCapt));
          if h <> 0 then begin
            if SendMessage(h, ASE_MSG, ASE_HELLO, LPARAM(aHandle)) = 1 then
              Break;
          end
          else
            Break;
        end;
      end;
end;
{$ENDIF}


procedure SetCaseSens(sl: TStringList; Value: boolean = True); overload;
begin
  {$IFDEF DELPHI6UP} sl.CaseSensitive := Value; {$ENDIF}
end;


constructor TsSkinProvider.Create(AOwner: TComponent);
var
  i: integer;
  sp: TsSkinProvider;
begin
  FrameAdapters := TList.Create;
  FThirdParty := TsThirdPartyList.Create;
  SetLength(ThirdLists, High(acThirdNames) + 1);
  for i := 0 to High(acThirdNames) do begin
    ThirdLists[i] := TStringList.Create;
    SetCaseSens(ThirdLists[i]);
  end;
  if AOwner is TCustomForm then begin
  {$IFNDEF DISABLEPREVIEWMODE}
    acPreviewNeeded := not (csDesigning in ComponentState) and (ParamCount > 0) and (ParamStr(1) = s_PreviewKey); // If called from the SkinEditor for a skin preview (Skin Edit mode)
  {$ENDIF}
    Form := TForm(AOwner);
    if (DefaultManager <> nil) and (DefaultManager.Options.ScaleMode <> smVCL) then
      Form.Scaled := False;

    biClicked := False;
    RTEmpty := False;
    FluentUWPMode := False;
    FluentBorderStyle := bsNone;
//    FluentGlassPaint := False;
    // Search other SkinProvider
    if csDesigning in AOwner.ComponentState then begin
      for i := 0 to Form.ComponentCount - 1 do
        if Form.Components[i] is TsSkinProvider then begin
          Form := nil;
          ShowWarning('Only one instance of the TsSkinProvider component is allowed!');
          Exit;
        end;

      for i := 0 to Form.ComponentCount - 1 do
        if Form.Components[i] is TsTitleBar then begin
          FTitleBar := TsTitleBar(Form.Components[i]);
          Break;
        end;
    end
    else begin
      sp := TsSkinProvider(Form.Perform(SM_ALPHACMD, AC_GETPROVIDER_HI, 0));
      if sp <> nil then
        if sp.RTInit then begin
          FluentBorderStyle := sp.FluentBorderStyle;
          FreeAndNil(sp);
        end
        else
          RTEmpty := True;
    end;

    inherited Create(AOwner);
    FGlow1 := nil;
    FGlow2 := nil;
    RTInit := False;
    StatusBar := nil;

    CYCaption := -1;
    CXSizeFrame := -1;
    CXFixedFrame := -1;
    CXPaddedBorder := -1;

    FDrawNonClientArea := True;
    UWPTemplates[False] := nil;
    UWPTemplates[True] := nil;
    FUWPMode := False;
    FDrawClientArea := True;
    FTitleSkinIndex := -1;
    FHeaderIndex := -1;
    FCaptionSkinIndex := -1;
    FInAnimation := False;
    FAllowAnimation := True;
    FAllowExtBorders := True;
    FAllowBlendOnMoving := True;
    RightPressed := False;
    CoverForm := nil;
    OldWndProc := nil;
    FormTimer := nil;
    FScaleThread := nil;

    fAnimating := False;
    InMenu := False;
    MaxRestore := False;
    ShowAction := saIgnore;
    bCapture := False;
    bInProcess := False;
    DoReinit := False;
    AllowScale := True;

    FCommonData := TsScrollWndData.Create(Self, False);
    FCommonData.SkinSection := s_Form;
    FCommonData.COC := COC_TsSkinProvider;
    if (Form.ControlState <> []) and (Form.BorderStyle <> bsNone) then
      FCommonData.FUpdating := True;

    FAddedTitle := TacAddedTitle.Create;
    FAddedTitle.FOwner := Self;
    FFormHeader := TacFormHeader.Create(Self);

    FResizeMode := rmStandard;
    FUseGlobalColor := True;
    MDIForm := nil;
    InAero := AeroIsEnabled;

    MenuChanged := True;
    FMakeSkinMenu := DefMakeSkinMenu;
    MenusInitialized := False;
    RgnChanged := True;
    RgnChanging := False;
    FScreenSnap := False;
    FSnapBuffer := 10;
    FAllowSkin3rdParty := True;
    FDisabledBlendValue := MaxByte;
    FDisabledBlendColor := clBlack;
    FDisabledBlured := False;

    FShowAppIcon := True;
    FCaptionAlignment := Classes.taLeftJustify;
    FTitleIcon := TsTitleIcon.Create(Self);
    FSystemBlur := TacSystemBlur.Create(Self);
    FTitleButtons := TsTitleButtons.Create(Self);
    FSysSubMenu := TacSysSubMenu.Create;
    FGluedForms := TStringList.Create;

    FGripMode := gmNone;
    ClearButtons := False;

    if not (csDesigning in ComponentState) and not RTEmpty then begin
      Form.DoubleBuffered := False;
      TempBmp := CreateBmp32;
      TempBmp.Canvas.Lock;
      MenuLineBmp := CreateBmp32;
      ClearButtons := True;
      SetLength(Rects, 0);
      FLinesCount := -1;
      OldWndProc := Form.WindowProc;
      Form.WindowProc := NewWndProc;
      FCommonData.WndProc := NewWndProc;
      IntSkinForm(Form);
      FormActive := True;
    end;
  end
  else
    Alert('TsSkinProvider component may be used with forms only!');
end;


destructor TsSkinProvider.Destroy;
var
  i: integer;
begin
  if Assigned(FAddedTitle) then begin
    if FHintTimer <> nil then
      FreeAndNil(FHintTimer);

    FreeAndNil(UWPTemplates[False]);
    FreeAndNil(UWPTemplates[True]);
    InitExBorders(False);
    FreeAndNil(FAddedTitle);
    if not (csDesigning in ComponentState) then begin
      KillAnimations;
      if Form <> nil then begin
        IntUnskinForm(Form);
        Form.WindowProc := OldWndProc;
        if (Form.FormStyle = fsMDIChild) and Assigned(Form.Menu) and Assigned(MDISkinProvider) then
          with TsSkinProvider(MDISkinProvider) do
            if not (csDestroying in ComponentState) and not (csDestroying in Form.ComponentState) then begin
              FCommonData.BGChanged := True;
              FLinesCount := -1;
              ProcessMessage(WM_NCPAINT);
            end;

        if MDISkinProvider = Self then begin
          if MDIForm <> nil then
            HookMDI(False);

          MDISkinProvider := nil;
        end;
      end;
      FreeAndNil(SystemMenu);
      FreeAndnil(TempBmp);
      FreeAndNil(MenuLineBmp);
    end;
  end;

  FrameAdapters.Free;
  if FluentHandles <> nil then
    FluentHandles.Free;

  DelFromGluedArray(Form);
  if ChildProvider = Self then
    ChildProvider := nil;

  if Assigned(FGlow1) then
    FreeAndNil(FGlow1);

  if Assigned(FGlow2) then
    FreeAndNil(FGlow2);

  FreeAndNil(FTitleIcon);
  FreeAndNil(FSystemBlur);
  FreeAndNil(FTitleButtons);
  FreeAndNil(FSysSubMenu);
  FreeAndNil(Adapter);
  FreeAndNil(ListSW);
  FreeAndNil(FCommonData);
  if Assigned(FormTimer) then
    FreeAndNil(FormTimer);

  if Form <> nil then
    UpdateProviderThirdNames(Self);

  for i := 0 to Length(ThirdLists) - 1 do
    if ThirdLists[i] <> nil then
      FreeAndNil(ThirdLists[i]);

  SetLength(ThirdLists, 0);
  FreeAndNil(FThirdParty);
  FreeAndNil(FFormHeader);
  FreeAndNil(FGluedForms);
  FreeAndNil(CoverForm);
  inherited Destroy;
end;


procedure TsSkinProvider.RepaintButton(i: integer);
var
  R: TRect;
  DC, SavedDC: hdc;
  BarItem: TacTitleBarItem;
  CurButton: PsCaptionButton;
  cx, ind, x, y, addY: integer;
  BtnDisabled, BtnLayered: boolean;
begin
  CurButton := nil;
  BarItem := nil;
  case i of
    HTCLOSE:      CurButton := @ButtonClose;
    HTMAXBUTTON:  CurButton := @ButtonMax;
    HTMINBUTTON:  CurButton := @ButtonMin;
    HTHELP:       CurButton := @ButtonHelp;
    HTCHILDCLOSE: CurButton := @MDIClose;
    HTCHILDMAX:   CurButton := @MDIMax;
    HTCHILDMIN:   CurButton := @MDIMin
    else
      if Between(i, HTUDBTN, (HTUDBTN + TitleButtons.Count - 1)) then begin
        if TitleButtons.Items[i - HTUDBTN].Visible then
          CurButton := @TitleButtons.Items[i - HTUDBTN].Data;
      end
      else
        if Assigned(FTitleBar) and Between(i, HTITEM, (HTITEM + FTitleBar.Items.Count - 1)) then
          if FTitleBar.Items[i - HTITEM].Visible then
            BarItem := FTitleBar.Items[i - HTITEM];
  end;
  if (i in [HTCHILDCLOSE]) and not MDIButtonsNeeded then
    Exit;

  if not (msAnimScaling in SkinData.SkinManager.ManagerState) then
    with SkinData.CommonSkinData do begin
      if i >= HTITEM then
        BtnLayered := True
      else // Bar items may be layered only
        BtnLayered := not ((i in [HTCHILDCLOSE..HTCHILDMIN]) or (not FCommonData.SkinManager.Effects.AllowGlowing and (BorderForm = nil)) or (FormState <> 0) or (Form.Parent <> nil) or (Form.FormStyle = fsMDIChild));

      if not BtnLayered then begin
        if (CurButton <> nil) and (CurButton^.cpState <> -1) then
          with CurButton^ do begin
            BtnDisabled := False;

            cx := CaptionWidth - cpRect.Left;
            if SysRTLAllowed then
              BitBlt(FCommonData.FCacheBmp.Canvas.Handle, // Restore a button BG
                   cpRect.Left, cpRect.Top, SysButtonwidth(CurButton^), ButtonHeight, TempBmp.Canvas.Handle, cpRect.Left, cpRect.Top, SRCCOPY)
            else
              BitBlt(FCommonData.FCacheBmp.Canvas.Handle, // Restore a button BG
                   cpRect.Left, cpRect.Top, SysButtonwidth(CurButton^), ButtonHeight, TempBmp.Canvas.Handle, TempBmp.Width - cx, cpRect.Top, SRCCOPY);
            // if Max btn and form is maximized then Norm btn
            if (i = HTMAXBUTTON) and (Form.WindowState = wsMaximized) then
              ind := TitleGlyphs[tgNormal]
            else
              case i of
                HTCHILDMIN: begin
                  ind := TitleGlyphs[cpGlyphType];
                  if ChildProvider <> nil then
                    BtnDisabled := not ChildProvider.SystemMenu.EnabledMin;

                  if BtnDisabled then
                    Exit;
                end;

                HTCHILDMAX: begin // Correction of the Maximize button (may be Normalize)
                  if Assigned(Form.ActiveMDIChild) and (Form.ActiveMDIChild.WindowState = wsMaximized) then
                    ind := TitleGlyphs[tgSmallNormal]
                  else
                    ind := TitleGlyphs[tgSmallMax];

                  if ChildProvider <> nil then
                    BtnDisabled := not ChildProvider.SystemMenu.EnabledRestore;
                end

                else
                  if IsIconic(Form.Handle) then
                    case i of
                      HTMINBUTTON:
                        ind := TitleGlyphs[tgNormal];

                      HTMAXBUTTON: begin
                        ind := TitleGlyphs[tgMax];
                        if not SystemMenu.EnabledMax then
                          BtnDisabled := True;
                      end

                      else
                        ind := TitleGlyphs[cpGlyphType];
                    end
                  else
                    ind := TitleGlyphs[cpGlyphType];
              end;

            if FCommonData.SkinManager.IsValidImgIndex(ind) then // Drawing of the button from skin
              if i < HTUDBTN then // if not user defined
                DrawSkinGlyph(FCommonData.FCacheBmp, Point(cpRect.Left, cpRect.Top),
                              cpState, 1 + integer(not FormActive or BtnDisabled) * integer((cpState = 0) or BtnDisabled),
                              ma[ind], MakeCacheInfo(SkinData.FCacheBmp))
              else
                if TitleButtons.Items[i - HTUDBTN].UseSkinData then
                  DrawSkinGlyph(FCommonData.FCacheBmp, Point(cpRect.Left, cpRect.Top),
                                cpState, 1 + integer(not FormActive) * integer(cpState = 0),
                                ma[ind], MakeCacheInfo(SkinData.FCacheBmp));

            // If user Glyph is defined
            if i >= HTUDBTN then
              with TitleButtons.Items[i - HTUDBTN] do
                if Assigned(Glyph) then
                  if Glyph.PixelFormat = pf32bit then begin
                    x := cpRect.Left + integer(cpState = 2) + (WidthOf(cpRect) - Glyph.Width) div 2;
                    y := cpRect.Top + integer(cpState = 2) + (HeightOf(cpRect) - Glyph.Height) div 2;
                    CopyByMask(Rect(x, y, x + Glyph.Width, y + Glyph.Height),
                               MkRect(Glyph), FCommonData.FCacheBmp,
                               Glyph, MakeCacheInfo(FCommonData.FCacheBmp, x, y), True);
                  end
                  else
                    CopyTransBitmaps(FCommonData.FCacheBmp, Glyph,
                         cpRect.Left + integer(cpState = 2) + (WidthOf(cpRect) - Glyph.Width) div 2,
                         cpRect.Top + integer(cpState = 2) + (HeightOf(cpRect) - Glyph.Height) div 2,
                         TsColor(Glyph.Canvas.Pixels[0, TitleButtons.Items[i - HTUDBTN].Glyph.Height - 1]));

            // Copying to form
            DC := GetWindowDC(Form.Handle);
            SavedDC := SaveDC(DC);
            try
              if BorderForm <> nil then
                if IsZoomed(Form.Handle) then begin
                  if FSysExHeight then
                    addY := ShadowSize.Top + DiffTitle(BorderForm) + 4
                  else
                    addY := BorderForm.OffsetY;

                  BitBlt(DC, cpRect.Left - DiffBorder(Self.BorderForm) - ShadowSize.Left, cpRect.Top - addY, WidthOf(cpRect), HeightOf(cpRect),
                         FCommonData.FCacheBmp.Canvas.Handle, cpRect.Left, cpRect.Top, SRCCOPY)
                end
                else
                  BitBlt(DC, cpRect.Left - DiffBorder(Self.BorderForm) - ShadowSize.Left, cpRect.Top - DiffTitle(Self.BorderForm) - ShadowSize.Top, WidthOf(cpRect), HeightOf(cpRect),
                         FCommonData.FCacheBmp.Canvas.Handle, cpRect.Left, cpRect.Top, SRCCOPY)
              else
                BitBlt(DC, cpRect.Left, cpRect.Top, WidthOf(cpRect), HeightOf(cpRect),
                       FCommonData.FCacheBmp.Canvas.Handle, cpRect.Left, cpRect.Top, SRCCOPY);

              if (cpState = 1) and (i in [HTCLOSE, HTMAXBUTTON, HTMINBUTTON]) then begin
                if Length(SkinData.CommonSkinData.TitleGlows[cpGlyphType]) > 0 then begin
                  if BorderForm <> nil then
                    GetWindowRect(BorderForm.AForm.Handle, R)
                  else
                    GetWindowRect(Form.Handle, R);

                  OffsetRect(R, cpRect.Left, cpRect.Top);
                  R.Right := R.Left + WidthOf(cpRect);
                  R.Bottom := R.Top + HeightOf(cpRect);

                  if FCommonData.SkinManager.Effects.AllowGlowing and (Form.Parent = nil) and (Form.FormStyle <> fsMDIChild) then
                    if cpGlyphType in [tgCloseAlone..tgNormal] then
                      if BorderForm <> nil then
                        cpGlowID := ShowGlow(R, TitleGlows[cpGlyphType], SkinData.CommonSkinData.GlowMargins[cpGlyphType], MaxByte, BorderForm.AForm.Handle, FCommonData)
                      else
                        cpGlowID := ShowGlow(R, TitleGlows[cpGlyphType], SkinData.CommonSkinData.GlowMargins[cpGlyphType], MaxByte, Form.Handle, FCommonData);
                end;
              end
              else
                if CurButton <> nil then
                  HideGlow(cpGlowID);
            finally
              RestoreDC(DC, SavedDC);
              ReleaseDC(Form.Handle, DC);
            end;
          end
        else
          if CurButton <> nil then
            HideGlow(CurButton^.cpGlowID);
      end
      else begin
        ind := max(1, integer(SkinData.SkinManager.Effects.AllowAnimation) * 10);
        // Old title buttons
        if (CurButton <> nil) and (CurButton^.cpState <> -1) then
          case CurButton^.cpState of
            1:   StartSBAnimation(CurButton, CurButton^.cpState, ind, True,  Self);
            2:   StartSBAnimation(CurButton, CurButton^.cpState, 1,   True,  Self)
            else StartSBAnimation(CurButton, CurButton^.cpState, ind, False, Self)
          end
        // Title Bar Items
        else
          if BarItem <> nil then
            if BorderForm <> nil then
              case BarItem.State of
                1:   StartItemAnimation(BarItem, ind, True,  BorderForm.AForm);
                2:   StartItemAnimation(BarItem, ind, True,  BorderForm.AForm)
                else StartItemAnimation(BarItem, ind, False, BorderForm.AForm)
              end
            else
              case BarItem.State of
                1:   StartItemAnimation(BarItem, ind, True);
                2:   StartItemAnimation(BarItem, ind, True)
                else StartItemAnimation(BarItem, ind, False)
              end
      end;
    end;
end;


function TsSkinProvider.HTProcess(var Message: TWMNCHitTest): integer;
const
  DefRESULT = HTCLIENT;
var
  NewP, p: TPoint;
  GripVisible: boolean;
  R, hrect, vrect: TRect;
  ii, i, sbw, SysBtnCount, actBtnIndex, BtnIndex: integer;

  function GetBtnIndex: integer;
  var
    i, c: integer;
  begin
    Result := 0;
    if BorderForm = nil then begin
      if SystemMenu = nil then
        PrepareForm;

      if SystemMenu <> nil then begin
        c := 0;
        if HaveSysMenu and Assigned(SystemMenu) then begin
          inc(c);
          if PtInRect(ButtonClose.cpRect, p) then
            Result := c
          else begin
            if SystemMenu.VisibleMax then begin
              inc(c);
              if PtInRect(ButtonMax.cpRect, p) then begin
                Result := c;
                Exit;
              end;
            end;
            if SystemMenu.VisibleMin then begin
              inc(c);
              if PtInRect(ButtonMin.cpRect, p) then
                Result := c
            end;
            if Result <> 0 then
              Exit;

            if biHelp in Form.BorderIcons then begin
              inc(c);
              if PtInRect(ButtonHelp.cpRect, p) then begin
                Result := c;
                Exit;
              end;
            end;
          end;
        end;
        for i := 0 to TitleButtons.Count - 1 do begin
          inc(c);
          if not TitleButtons[i].Visible then
            Continue;

          if PtInRect(TitleButtons[i].Data.cpRect, p) then begin
            Result := c;
            Exit;
          end;
        end;
        if Assigned(FTitleBar) then
          for i := 0 to FTitleBar.Items.Count - 1 do begin
            inc(c);
            if not FTitleBar.Items[i].Visible then
              Continue;

            if PtInRect(FTitleBar.Items[i].Rect, p) then begin
              if FTitleBar.Items[i].Style in [bsSpacing, bsInfo] then
                Result := 0
              else
                Result := c;

              Exit;
            end;
          end;
      end;
    end;
  end;

begin
  p := CursorToPoint(Message.XPos, Message.YPos);
  Result := DefRESULT;
  BtnIndex := GetBtnIndex;
  if BtnIndex > 0 then begin
    SysBtnCount := 0;
    actBtnIndex := 0;
    if HaveSysMenu then begin
      inc(SysBtnCount);
      if SysBtnCount = BtnIndex then
        actBtnIndex := 1; // Close

      if SystemMenu.VisibleMax then begin
        inc(SysBtnCount);
        if SysBtnCount = BtnIndex then
          actBtnIndex := 2; // Max
      end;

      if SystemMenu.VisibleMin or IsIconic(Form.Handle) then begin
        inc(SysBtnCount);
        if SysBtnCount = BtnIndex then
          actBtnIndex := 3; // Min
      end;

      if biHelp in Form.BorderIcons then begin
        inc(SysBtnCount);
        if SysBtnCount = BtnIndex then
          actBtnIndex := 4; // Help
      end;
    end;
    if BtnIndex <= SysBtnCount then begin
      case actBtnIndex of
        1:
          if HaveSysMenu then
            if SystemMenu.EnabledClose then
              Result := HTCLOSE
            else
              Result := HTCAPTION;

        2:
          if SystemMenu.VisibleMax then
            Result := iff(SystemMenu.EnabledMax or (SystemMenu.EnabledRestore and not IsIconic(Form.Handle)), HTMAXBUTTON, HTCAPTION)
          else
            if (SystemMenu.VisibleMin) or IsIconic(Form.Handle) then
              Result := iff(SystemMenu.EnabledMin, HTMINBUTTON, HTCAPTION)
            else
              if biHelp in Form.BorderIcons then
                Result := HTHELP;

        3:
          if (SystemMenu.VisibleMin) or IsIconic(Form.Handle) then
            if not IsIconic(Form.Handle) then
              Result := iff(SystemMenu.EnabledMin, HTMINBUTTON, HTCAPTION)
            else
              Result := HTMINBUTTON
          else
            if biHelp in Form.BorderIcons then
              Result := HTHELP;

        4:
          if (biHelp in Form.BorderIcons) {and SystemMenu.VisibleMax }then
            Result := HTHELP;
      end;
    end
    else
      if BtnIndex <= TitleButtons.Count + SysBtnCount then begin // UDF button
        BtnIndex := BtnIndex - SysBtnCount - 1;
        if TitleButtons.Items[BtnIndex].Enabled then
          Result := HTUDBTN + BtnIndex;
      end
      else
        if FTitleBar <> nil then begin
          BtnIndex := BtnIndex - SysBtnCount - TitleButtons.Count - 1;
          if FTitleBar.Items[BtnIndex].Enabled and ((FTitleBar.Items[BtnIndex].Style <> bsTab) or not FTitleBar.Items[BtnIndex].Down) then
            Result := HTITEM + BtnIndex;
        end;

    if Result <> DefRESULT then
      Exit;
  end;

  sbw := SysBorderWidth(Form.Handle, BorderForm);
  if (GetWindowLong(Form.Handle, GWL_STYLE) and WS_SIZEBOX <> 0) and (BorderForm = nil) then begin
    if FUWPMode then begin
      if p.Y < OffsetY then
        Result := HTTOP;
    end
    else
      if p.Y < SysBorderHeight(Form.Handle, BorderForm, False) then
        Result := HTTOP;

    if p.Y >= Form.Height - sbw then
      Result := HTBOTTOM;

    if p.X < sbw then
      if Result = HTTOP then
        Result := HTTOPLEFT
      else
        Result := iff(Result = HTBOTTOM, HTBOTTOMLEFT, HTLEFT);

    if p.X >= Form.Width - sbw then
      if Result = HTTOP then
        Result := HTTOPRIGHT
      else
        Result := iff(Result = HTBOTTOM, HTBOTTOMRIGHT, HTRIGHT);

    if Result <> DefRESULT then
      Exit;
  end;
  ii := SysCaptHeight(Self);
  ii := ii + SysBorderHeight(Form.Handle, BorderForm);
  if Between(p.Y, 0, ii) then begin
    if Between(p.Y, SysCaptHeight(Self) + SysBorderHeight(Form.Handle, BorderForm, False), CaptionHeight(False) + SysBorderHeight(Form.Handle, BorderForm, False) + MenuHeight) then begin
      Result := HTMENU;
      Exit;
    end;
    Result := iff(PtInRect(FIconRect, p), HTSYSMENU, HTCAPTION);
  end
  else begin
    ii := ii + GetLinesCount * MenuHeight;
    if p.Y <= ii then begin
      // MDI child buttons
      if MDIButtonsNeeded then begin
        NewP := Point(p.X + ShadowSize.Left + DiffBorder(BorderForm), p.Y + ShadowSize.Top + DiffTitle(BorderForm));
        if PtInRect(MDICLose.cpRect, NewP) then
          Result := HTCHILDCLOSE
        else
          if PtInRect(MDIMax.cpRect, NewP) then
            Result := HTCHILDMAX
          else
            Result := iff(PtInRect(MDIMin.cpRect, NewP), HTCHILDMIN, HTMENU);
      end
      else
        Result := HTMENU;
    end
    else begin
      if IsGripVisible(Self) then
        GripVisible := True
      else
        if Assigned(ListSW) and Assigned(ListSW.sbarVert) and ListSW.sbarVert.fScrollVisible and ListSW.sbarHorz.fScrollVisible then begin
          Ac_GetHScrollRect(ListSW, Form.Handle, hrect);
          Ac_GetVScrollRect(ListSW, Form.Handle, vrect);
          GetWindowRect(Form.Handle, R);
          GripVisible := PtInRect(Rect(hrect.Right - R.Left, hrect.Top - R.Top, vrect.Right - R.Left, hrect.Bottom - R.Top), p)
        end
        else
          GripVisible := False;

      if GripVisible then begin
        i := FCommonData.CommonSkinData.GripRightBottom;
        if FCommonData.SkinManager.IsValidImgIndex(i) then
          if BorderForm <> nil then begin
            if (p.y > RBGripPoint(i).y - DiffTitle(Self.BorderForm) - ShadowSize.Top) and (p.x > RBGripPoint(i).x - DiffBorder(Self.BorderForm) - ShadowSize.Left) then
              Result := HTBOTTOMRIGHT;
          end
          else
            if (p.y > RBGripPoint(i).y) and (p.x > RBGripPoint(i).x) then
              Result := HTBOTTOMRIGHT;
      end;
    end;
  end;
end;


procedure UpdateMainForm(UpdateNow: boolean = True);
var
  Flags: Cardinal;
begin
  if Assigned(MDISkinProvider) then
    with TsSkinProvider(MDISkinProvider) do
      if CanDrawNCArea then begin
        FCommonData.BeginUpdate;
        if Assigned(MDIForm) then
          TsMDIForm(MDIForm).UpdateMDIIconItem;

        FCommonData.BGChanged := True;
        if FGlow1 <> nil then
          FreeAndNil(FGlow1);

        if FGlow2 <> nil then
          FreeAndNil(FGlow2);

        MenuChanged := True;
        FLinesCount := -1;
        FCommonData.EndUpdate;

        Flags := RDW_ERASE or RDW_FRAME or RDW_INTERNALPAINT or RDW_INVALIDATE;
        if UpdateNow then
          Flags := Flags + RDW_UPDATENOW;

        RedrawWindow(Form.ClientHandle, nil, 0, Flags);
        RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE);

        if UpdateNow and (BorderForm <> nil) then
          BorderForm.UpdateExBordersPos;
      end
      else
        RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
end;


function HandleEdge(eDynamic: integer; eStatic, SnapDistance: integer): integer;
begin
  if BetWeen(eDynamic, eStatic - SnapDistance, eStatic + SnapDistance) then
    Result := eDynamic - eStatic
  else
    Result := 0;
end;


function ExtBordersNeeded(sp: TsSkinProvider; Maximized: boolean = False): boolean;
begin
  with sp, SkinData do
    if (SkinData <> nil) and (SkinManager <> nil) and SkinManager.ExtendedBorders and AllowExtBorders and
         (not SkinManager.Options.NativeBordersMaximized or (Form.WindowState <> wsMaximized)) then
      if sp.UWPMode and ((Form.WindowState = wsMaximized) or Maximized) then
        Result := False
      else
        Result := True
  else
    Result := False
end;


function SearchWndByID(ID: LParam; Component: TComponent): TWincontrol;
var
  i, ind: integer;
begin
  Result := nil;
  with Component do
    for i := 0 to ComponentCount - 1 do begin
      if (Components[i] is TWinControl) and TWinControl(Components[i]).HandleAllocated then begin
        ind := GetDlgCtrlID(TWinControl(Components[i]).Handle);
        if ind = integer(ID) then begin
          Result := TWinControl(Components[i]);
          Exit;
        end;
      end;
      Result := SearchWndByID(ID, Components[i]);
      if Result <> nil then
        Exit;
    end;
end;


var
  bChangingFlag: boolean = False;

procedure TsSkinProvider.NewWndProc(var Message: TMessage);
var
  iOldPPI: integer;
  bAutoDPI: boolean;
  M: TMessage;
begin
{$IFDEF LOGGED}
//  if (Form.Tag = 3) {and (Form.WindowState = wsMaximized)} then
//    AddToLog(Message);
{$ENDIF}
  if (Message.Msg <> SM_ALPHACMD) or not AC_SMAlphaCmd_Common(Message) then
    if (csDestroying in Form.ComponentState) or not FCommonData.Skinned then begin
//      AddToLog(Message);
      if (Message.Msg = SM_ALPHACMD) and AC_SMAlphaCmd_Unskinned(Message) then
        Exit;

{$IFNDEF NOWNDANIMATION}
      case Message.Msg of
        CM_VISIBLECHANGED: AC_CMVisibleChanged_Unskinned(Message);
        CM_SHOWINGCHANGED: AC_CMShowingChanged_Unskinned(Message);
        CM_SYSFONTCHANGED: DoReinit := True;
        WM_SETREDRAW: AC_WMSetRedraw(Message);
        WM_PRINT: begin
          if Message.WParam <> 0 then
            FillDC(TWMPaint(Message).DC, MkRect(Form), ColorToRGB(Form.Color));

          Form.Perform(WM_PAINT, Message.WParam, Message.LParam);
          Exit;
        end;

  {$IFNDEF ALITE}
        CM_MOUSEWHEEL: begin
          AC_CMMouseWheel(TCMMouseWheel(Message));
          Exit;
        end;
  {$ENDIF}
      end;
{$ENDIF}
      OldWndProc(Message);
      case Message.Msg of
{$IFNDEF NOWNDANIMATION}
        WM_WINDOWPOSCHANGED: AC_WMWindowPosChanged_Unskinned(TWMWindowPosChanging(Message));
{$ENDIF}
        WM_NCDESTROY: AC_WMNCDestroy;
      end;
    end
    else
      case Message.Msg of
        CM_CHANGED: if (Form.Menu <> nil){ and not Form.Menu.ParentBidiMode} then begin // Update menu after BidiModeChanging
          MenuChanged := True;
          SkinData.BGChanged := True;
          OldWndProc(Message);
        end;
        CM_SYSFONTCHANGED: DoReinit := True;

        WM_DPICHANGED: begin
          if not bChangingFlag and (SkinData.SkinManager <> nil) and not (csDesigning in SkinData.SkinManager.ComponentState) then begin
            bChangingFlag := True;
            bAutoDPI := Self.AllowScale and (SkinData.SkinManager.Options.ScaleMode = smVCL);

            if (SkinData.CurrentPPI <> Message.WParamHi){ or not bAutoDPI} then begin
              InitSysParams(Message.WParamHi);
              SkinData.CommonSkinData := nil;
              RgnChanged := True;
              if bAutoDPI then begin // Update PPI
                FormState := FormState or FS_SCALING;
                SkinData.BGChanged := True;
                SkinData.Updating := True;

                iOldPPI := SkinData.CurrentPPI;
                SkinData.SkinManager.UpdateScale(Form, iOldPPI, Message.WParamHi);

                if ((Application.MainForm = Form) or (Application.MainForm = nil)) and (SkinData.SkinManager.Options.ScaleMode = smVCL) then begin
                  SkinData.SkinManager.Options.PixelsPerInch := Message.WParamHi;
                  IterateImageLists(ScaleImageList, Message.WParamHi);
                end;

                SkinData.Updating := False;
                SkinData.BGChanged := True;
                CalcItems;
                if FFormState and FS_GLASSNEEDED <> 0 then
                  FSystemBlur.UpdateBlurMode;

                PaintAll;

                FormState := FormState and not FS_SCALING;
                M := MakeMessage(SM_ALPHACMD, AC_SETBGCHANGED_HI, 1, 0);
                AlphaBroadCast(Form, M);

                M := MakeMessage(SM_ALPHACMD, AC_REFRESH_HI, LPAram(SkinData.SkinManager), 0);
                AlphaBroadCast(Form, M);

                if BorderForm <> nil then
                  UpdateSkinCaption(Self);
              end
              else begin
                CalcItems;
                if FFormState and FS_GLASSNEEDED <> 0 then
                  FSystemBlur.UpdateBlurMode;

                SkinData.Invalidate;
              end;
            end
            else begin
              SkinData.BGChanged := True;
              SkinData.Invalidate;
            end;
            bChangingFlag := False;
          end;
          inherited;
          Exit;
        end;

        WM_SETCURSOR:
          if (FTitleBar = nil) or not IsValidIndex(CurrentHT - HTITEM, FTitleBar.Items.Count) then // If TitleItem.Cursor is not used
            OldWndProc(Message);

        WM_DWMSENDICONICLIVEPREVIEWBITMAP:
          if ac_ChangeThumbPreviews then // Task menu support when not MainFormOnTaskBar
            Message.Result := LRESULT(SetPreviewBmp(Form.Handle, Self))
          else
            OldWndProc(Message);

        WM_DWMSENDICONICTHUMBNAIL:
          with Message do
            if ac_ChangeThumbPreviews and (LParamHi <> 0) and (LParamLo <> 0) then // Task menu support when not MainFormOnTaskBar
              Result := LRESULT(SetThumbIcon(Form.Handle, Self, LParamHi, LParamLo))
            else
              OldWndProc(Message);

        SM_ALPHACMD: AC_SMAlphaCmd_Skinned(Message);

        CM_WININICHANGE: begin
          OldWndProc(Message);
          if BorderForm <> nil then
            BorderForm.UpdateExBordersPos;
        end;

        WM_SETFOCUS: begin
          OldWndProc(Message);
          if Form.Visible and (BorderForm <> nil) and ((BorderForm.AForm = nil) or not IsWindowVisible(BorderForm.AForm.Handle)) then begin
            FInAnimation := False;
            BorderForm.UpdateExBordersPos(True);
          end;
        end;

        CM_COLORCHANGED:
          if FormState and (FS_ANIMSHOWING or FS_ANIMCLOSING) <> 0 then
            Exit
          else
            if SkinData.CustomColor then
              SkinData.Invalidate;
        WM_NCMOUSEMOVE:       AC_WMNCMouseMove(TWMNCMouseMove(Message));
        WM_SETREDRAW:         AC_WMSetRedraw(Message);
        WM_EXITSIZEMOVE:      AC_WMExitSizeMove(Message);
        WM_GETMINMAXINFO:     AC_WMGetMinMaxInfo(TWMGetMinMaxInfo(Message));
        WM_SETICON:           AC_WMSetIcon(Message);
{$IFNDEF FPC}
        WM_CONTEXTMENU:       AC_WMContextMenu(Message);
        WM_INITMENUPOPUP:     AC_WMInitMenuPopup(TWMInitMenuPopup(Message));
{$ENDIF}
        WM_STYLECHANGED:      AC_WMStyleChanged(Message);
        WM_SHOWWINDOW:        AC_WMShowWindow(Message);
        WM_SETTEXT:           AC_WMSetText(Message);
        CM_ENABLEDCHANGED:    AC_CMEnabledChanged(Message);
        WM_SYSCOLORCHANGE:    AC_WMSysColorChange(Message);
        WM_CHILDACTIVATE:     AC_WMChildActivate(Message);
        WM_SIZE:              AC_WMSize(Message);
        WM_MOVE:              AC_WMMove(Message);
        WM_ENTERMENULOOP:     AC_WMEnterMenuLoop(Message);
        WM_EXITMENULOOP:      AC_WMExitMenuLoop(Message);
        WM_NCHITTEST:         AC_WMNCHitTest(Message);
        WM_SIZING:            AC_WMSizing(Message);
        CM_MOUSEENTER:        AC_CMMouseEnter(Message);
        WM_NCCREATE:          AC_WMNCCreate(Message);
        WM_NCLBUTTONDOWN:     AC_WMNCLButtonDown(TWMNCLButtonDown(Message));
        WM_SETTINGCHANGE:     AC_WMSettingChange(Message);
        WM_MOUSEMOVE:         AC_WMMouseMove(Message);
        WM_NCRBUTTONDOWN:     AC_WMNCRButtonDown(TWMNCRButtonDown(Message));
        WM_NCRBUTTONUP:       AC_WMNCRButtonUp(TWMNCRButtonUp(Message));
        CM_FLOAT:             AC_CMFloat(Message);
        CM_MENUCHANGED:       AC_CMMenuChanged(Message);
        WM_PRINT:             AC_WMPrint(Message);
        WM_NCPAINT:           AC_WMNCPaint(Message);
        WM_ERASEBKGND:        AC_WMEraseBkGnd(Message);
        WM_PAINT:             AC_WMPaint(Message);
        CM_RECREATEWND:       AC_CMRecreateWnd(Message);
        WM_NCACTIVATE:        AC_WMNCActivate(TWMNCActivate(Message));
        WM_ACTIVATE:          AC_WMActivate(TWMActivate(Message));
        WM_ACTIVATEAPP:       AC_WMActivateApp(Message);
        CM_VISIBLECHANGED:    AC_WMVisibleChanged(Message);

        WM_NCLBUTTONDBLCLK:   AC_WMNCLButtonDblClick(Message);
        WM_MEASUREITEM:       AC_WMMeasureItem(Message);
        WM_SYSCOMMAND:        AC_WMSysCommand(Message);
        WM_WINDOWPOSCHANGING: AC_WMWindowPosChanging(TWMWindowPosChanging(Message));
        WM_QUERYENDSESSION:   AC_WMQueryEndSession(Message);
        WM_WINDOWPOSCHANGED:  AC_WMWindowPosChanged(Message);
        WM_CREATE:            AC_WMCreate(Message);
        WM_PARENTNOTIFY:      AC_WMParentNotify(Message);
        WM_NOTIFY:            AC_WMNotify(Message);
        CM_CONTROLLISTCHANGE: AC_WMControlListChange(TCMControlListChange(Message));

        WM_MDIACTIVATE,
        WM_MDIDESTROY:        AC_WMMDIDestroy(Message);

        WM_MOUSELEAVE,
        CM_MOUSELEAVE:        AC_WMMouseLeave(Message);
        WM_NCLBUTTONUP,
        WM_LBUTTONUP:         AC_WMLButtonUp(TWMNCLButtonUp(Message));
        WM_ENTERIDLE:
          if Message.WParam = MSGF_DIALOGBOX then
            OldWndProc(Message)
          else
            Message.Result := 0;
        WM_PRINTCLIENT:;
        CM_BIDIMODECHANGED: begin
          if SkinData.SkinManager <> nil then
            SkinData.SkinManager.FlipImages(Form.BidiMode = bdRightToLeft);
          OldWndProc(Message);
          if BorderForm <> nil then
            BorderForm.UpdateExBordersPos;
        end;
{
        147, Std menu haven't captions if disabled
}
{$IFNDEF ALITE}
        CM_MOUSEWHEEL:        AC_CMMouseWheel(TCMMouseWheel(Message));
{$ENDIF}
{$IFNDEF DISABLEPREVIEWMODE}
        ASE_MSG:              AC_ASEMSG(Message); // Used with ASkinEditor
        WM_COPYDATA:          AC_WMCopyData(TWMCopyData(Message));
{$ENDIF}

        CM_SHOWINGCHANGED:    AC_CMShowingChanged(Message);

{$IFNDEF NOWNDANIMATION}
        WM_CLOSE:             AC_WMClose(Message);
{$ENDIF}
        787: with acMousePos do
          DropSysMenu(X, Y);

        45132, 48205:         Message.Result := 0
        else
          OldWndProc(Message);
      end;
end;


procedure TsSkinProvider.PaintTitleContent(CaptWidth: integer);
var
  i, index, b, x, y: integer;
  Item: TsTitleButton;
  sMan: TsSkinManager;

  // Sys buttons painting
  procedure PaintButton(var Btn: TsCaptionButton; BtnEnabled: boolean);
  begin
    with Btn, sMan, SkinData.CommonSkinData do
      if TitleGlyphs[cpGlyphType] >= 0 then
        DrawSkinGlyph(FCommonData.FCacheBmp, cpRect.TopLeft, cpState * integer(cpTimer = nil),
                    1 + integer(not FormActive or not BtnEnabled or not Form.Enabled) * integer((cpState = 0) or (cpTimer <> nil)),
                    ma[TitleGlyphs[cpGlyphType]], MakeCacheInfo(SkinData.FCacheBmp));
  end;

begin
  if HaveBorder(Self) then begin
    sMan := FCommonData.SkinManager;
    // Copy back stored background
    RestoreBtnsBG(CaptWidth);
    // Paint sys buttons
    if Assigned(SystemMenu) and HaveSysMenu then begin
      PaintButton(ButtonClose, SystemMenu.VisibleClose and SystemMenu.EnabledClose);
      if SystemMenu.VisibleMax then
        PaintButton(ButtonMax, SystemMenu.EnabledMax);

      if SystemMenu.VisibleMin then
        PaintButton(ButtonMin, SystemMenu.EnabledMin);

      if biHelp in Form.BorderIcons then
        PaintButton(ButtonHelp, True);
    end;
    // Paint title buttons
    if (TitleButtons <> nil) and (TitleButtons.Count > 0) then
      for index := 0 to TitleButtons.Count - 1 do
        if TitleButtons.Items[index].Visible then begin
          Item := TitleButtons.Items[index];
          PaintButton(Item.Data, Item.Enabled);
          Item.Data.cpHitCode := HTUDBTN + index;
          if Assigned(Item.Glyph) and not Item.Glyph.Empty then
            if Item.Glyph.PixelFormat = pf32bit then begin
              x := Item.Data.cpRect.Left + (UserButtonWidth(Item) - Item.Glyph.Width) div 2;
              y := Item.Data.cpRect.Top + (ButtonHeight - Item.Glyph.Height) div 2;
              CopyByMask(Rect(x, y, x + Item.Glyph.Width, y + Item.Glyph.Height),
                         MkRect(Item.Glyph), FCommonData.FCacheBmp, Item.Glyph, MakeCacheInfo(FCommonData.FCacheBmp, 0, 0), True);
            end
            else
              CopyTransBitmaps(FCommonData.FCacheBmp, Item.Glyph,
                               Item.Data.cpRect.Left + (UserButtonWidth(Item) - Item.Glyph.Width) div 2,
                               Item.Data.cpRect.Top + (ButtonHeight - Item.Glyph.Height) div 2,
                               TsColor(Item.Glyph.Canvas.Pixels[0, Item.Glyph.Height - 1]));
        end;

    // Paint Bar items
    with FTitleBar do
      if Assigned(FTitleBar) and (Items.Count > 0) then begin
        for index := Items.Count - 1 downto 0 do
          with Items[index] do
            if ((Style <> bsTab) or not Down) and Visible then
              if (Rect.Left > 0) and (Rect.Right < CaptWidth) then
                PaintTitleItem(Items[index], Rect, FCommonData.FCacheBmp);
        // Paint active tab if exists
        for index := Items.Count - 1 downto 0 do
          with Items[index] do
            if (Style = bsTab) and Down and Visible then
              if (Rect.Left > 0) and (Rect.Right < CaptWidth) then
                PaintTitleItem(FTitleBar.Items[index], Rect, FCommonData.FCacheBmp);
      end;
    // Paint MDI child buttons if maximized
    if MDIButtonsNeeded then
      with sMan, SkinData.CommonSkinData do begin
        b := CaptionHeight + SysBorderHeight(Form.Handle, BorderForm) + ShadowSize.Top + (MenuHeight - SmallButtonHeight) div 2 + (GetLinesCount - 1) * MenuHeight; // Buttons top
        if sMan.IsValidImgIndex(TitleGlyphs[MDIMin.cpGlyphType]) then begin
          MDIMin.cpRect := Bounds(CaptWidth - SysBorderWidth(Form.Handle, BorderForm) - 3 * (SmallButtonWidth + 1) - ShadowSize.Right, b, SmallButtonWidth, SmallButtonHeight);
          DrawSkinGlyph(FCommonData.FCacheBmp, MDIMin.cpRect.TopLeft,
                    MDIMin.cpState, 1 + integer(not FormActive or not ChildProvider.SystemMenu.EnabledMin), ma[TitleGlyphs[MDIMin.cpGlyphType]], MakeCacheInfo(SkinData.FCacheBmp));
        end;
        if Assigned(TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild) and { Draw norm. button when maximized }
             (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild.WindowState <> wsMaximized) then
          i := TitleGlyphs[MDIMax.cpGlyphType]
        else
          i := TitleGlyphs[tgSmallNormal];

        MDIMax.cpRect := Bounds(CaptWidth - SysBorderWidth(Form.Handle, BorderForm) - 2 * (SmallButtonWidth + 1) - ShadowSize.Right, b, SmallButtonWidth, SmallButtonHeight);
        if sMan.IsValidImgIndex(i) then
          DrawSkinGlyph(FCommonData.FCacheBmp, MDIMax.cpRect.TopLeft,
                        MDIMax.cpState, 1 + integer(not FormActive or not ChildProvider.SystemMenu.EnabledRestore),
                        ma[i], MakeCacheInfo(SkinData.FCacheBmp));

        if sMan.IsValidImgIndex(TitleGlyphs[MDIClose.cpGlyphType]) then begin
          MDIClose.cpRect := Bounds(CaptWidth - SysBorderWidth(Form.Handle, BorderForm) - SmallButtonWidth - 1 - ShadowSize.Right, b, SmallButtonWidth, SmallButtonHeight);
          DrawSkinGlyph(FCommonData.FCacheBmp, MDIClose.cpRect.TopLeft, MDIClose.cpState, 1 + integer(not FormActive), ma[TitleGlyphs[MDIClose.cpGlyphType]],
                        MakeCacheInfo(SkinData.FCacheBmp));
        end;
      end;
  end;
end;


procedure TsSkinProvider.PaintCaption(DC: hdc);
var
  hh, bh, bw, hmnu, w: integer;
  RDst: TRect;
begin
  w := CaptionWidth;
  with FCommonData do begin
    if BGChanged then begin
      if MenuChanged or (FCacheBmp = nil) or IsBorderUnchanged(CommonSkinData.gd[SkinIndex].BorderIndex, CommonSkinData) or
          (FCacheBmp.Width <> w) or (FCacheBmp.Height <> Form.Height) or not HaveBorder(Self) then // if ready caption BG
        ControlsChanged := not FirstInitialized;

      PaintAll;
      BGChanged := False;
      Updating := False;
    end;

    hmnu := integer(MenuPresent) * (LinesCount * MenuHeight + 1);
    bh := BorderHeight;
    if GetWindowLong(Form.Handle, GWL_STYLE) and WS_CAPTION <> 0 then
      hh := HeaderHeight
    else
      hh := bh;

    bw := BorderWidth;
    if hh <> 0 then
      BitBlt(DC, 0, 0, w, hh, FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY) // Title and menu line update
    else
      if hmnu <> 0 then
        BitBlt(DC, 0, 0, w, hmnu, FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY); // Only menu line update

    RDst.Left := 0;
    RDst.Top := hh;
    RDst.Right := FCommonData.FCacheBmp.Width;
    RDst.Bottom := FCommonData.FCacheBmp.Height - RDst.Top;

    BitBltBorder(DC, RDst.Left, RDst.Top, RDst.Right, RDst.Bottom,
                 FCacheBmp.Canvas.Handle, RDst.Left, RDst.Top, bw, 0, bw, bw);
  end;
end;


procedure TsSkinProvider.PaintForm(DC: hdc; PaintRect: TRect; SendUpdated: boolean = True);
var
  Changed: boolean;
  R: TRect;
begin
  R := Form.ClientRect;
  IntersectClipRect(DC, PaintRect.Left, PaintRect.Top, PaintRect.Right, PaintRect.Bottom);
  with SkinData, SkinManager do begin
    Changed := BGChanged;
    if BGChanged then
      PaintAll;

    if Form.FormStyle <> fsMDIForm then begin
      CopyWinControlCache(Form, FCommonData, Rect(OffsetX + PaintRect.Left, OffsetY + PaintRect.Top, 0, 0), PaintRect, DC, False);
      PaintControls(DC, Form, ControlsChanged or Changed, MkPoint, False);
    end;
    if SendUpdated then begin
      SetParentUpdated(Form);
      SendToAdapter(MakeMessage(SM_ALPHACMD, AC_ENDPARENTUPDATE_HI, 0, 0));
    end;
  end;
  ControlsChanged := False;
end;


procedure ShowHint(Btn: TsTitleButton);
var
  p: TPoint;
begin
  if (Btn.Hint <> '') and (Btn.HintWnd = nil) then begin
    p := acMousePos;
    if HintWindowClass = THintWindow then
      Btn.HintWnd := acShowHintWnd(Btn.Hint, Point(p.X + 8, p.Y + 16))
    else
      acShowHintWnd(Btn.Hint, Point(p.X + 8, p.Y + 16));
  end;
end;


procedure HideHint(Btn: TsTitleButton);
begin
  if Btn.HintWnd <> nil then
    FreeAndNil(Btn.HintWnd);
end;

{$IFNDEF ALITE}
type
  TAccessAlphaHints = class(TsAlphaHints);
{$ENDIF}

procedure TsSkinProvider.SetHotHT(const i: integer; const Repaint: boolean = True);
begin
  if (i <> CurrentHT) and CanDrawNCArea and not (msAnimScaling in SkinData.SkinManager.ManagerState) and not UWPMode then begin
    if HotItem.Item <> nil then begin
  {$IFNDEF FPC}
      RepaintMenuItem(HotItem.Item, HotItem.R, []);
  {$ENDIF}
      HotItem.Item := nil;
    end;
    if FHintTimer <> nil then
      FreeAndNil(FHintTimer);

    if not ((CurrentHT = i) or (CurrentHT = -1) and (i = 0)) then
      if CurrentHT > 0 then begin
{$IFNDEF ALITE}
        if acAlphaHints.Manager <> nil then
          with TAccessAlphaHints(acAlphaHints.Manager) do
            if HideTimer <> nil then
              if i > 0 then
                StartHideTimer
              else
                HideTimer.OnTimer(HideTimer);
{$ENDIF}
        case CurrentHT of
          HTCLOSE:      ButtonClose.cpState := 0;
          HTMAXBUTTON:  ButtonMax.cpState   := 0;
          HTMINBUTTON:  ButtonMin.cpState   := 0;
          HTHELP:       ButtonHelp.cpState  := 0;
          HTCHILDCLOSE: MDIClose.cpState    := 0;
          HTCHILDMAX:   MDIMax.cpState      := 0;
          HTCHILDMIN:   MDIMin.cpState      := 0
          else
            if BetWeen(CurrentHT, HTUDBTN, HTUDBTN + TitleButtons.Count - 1) then begin
              TitleButtons.Items[CurrentHT - HTUDBTN].Data.cpState := 0;
              HideHint(TitleButtons.Items[CurrentHT - HTUDBTN]);
            end
            else
              if BetWeen(CurrentHT, HTITEM, HTITEM + MaxByte) then
                if Assigned(FTitleBar) then
                  if CurrentHT - HTITEM < FTitleBar.Items.Count then
                    with FTitleBar, Items[CurrentHT - HTITEM] do begin
                      if Assigned(OnMouseLeave) then
                        OnMouseLeave(Items[CurrentHT - HTITEM]);

                      SetCursor(Screen.Cursors[crDefault]);
                      State := 0;
                      HideHintWnd(Items[CurrentHT - HTITEM]);
                    end;
        end;
        if Repaint then
          RepaintButton(CurrentHT);
      end;

    CurrentHT := i;
    if biClicked or (CurrentHT <= 0) then
      Exit; // If button is pressed and position of form is changed

    case CurrentHT of
      HTCLOSE:      ButtonClose.cpState := 1;
      HTMAXBUTTON:  ButtonMax.cpState   := 1;
      HTMINBUTTON:  ButtonMin.cpState   := 1;
      HTHELP:       ButtonHelp.cpState  := 1;
      HTCHILDCLOSE: MDIClose.cpState    := 1;
      HTCHILDMAX:   MDIMax.cpState      := 1;
      HTCHILDMIN:   MDIMin.cpState      := 1;

      HTUDBTN..HTUDBTN + MaxByte: begin
        if IsValidIndex(CurrentHT - HTUDBTN, TitleButtons.Count) then begin
          TitleButtons.Items[CurrentHT - HTUDBTN].Data.cpState := 1;
          ShowHint(TitleButtons.Items[CurrentHT - HTUDBTN]);
        end;
      end;

      HTITEM..HTITEM + MaxByte: if Assigned(FTitleBar) then
        if CurrentHT - HTITEM < FTitleBar.Items.Count then begin
          if Assigned(FTitleBar.Items[CurrentHT - HTITEM].OnMouseEnter) then
            FTitleBar.Items[CurrentHT - HTITEM].OnMouseEnter(FTitleBar.Items[CurrentHT - HTITEM]);

          SetCursor(Screen.Cursors[FTitleBar.Items[CurrentHT - HTITEM].Cursor]);
          FTitleBar.Items[CurrentHT - HTITEM].State := 1;
          StartHintTimer(FTitleBar.Items[CurrentHT - HTITEM]);
        end;
    end;
    if Repaint then begin
      RepaintButton(CurrentHT);
      case CurrentHT of
        HTITEM..HTITEM + MaxByte:
          if Assigned(FTitleBar) and (FTitleBar.Items[CurrentHT - HTITEM].State <> 1) then begin
            FTitleBar.Items[CurrentHT - HTITEM].State := 0;
            UpdateSkinCaption(Self); // Title repainting under the Layered wnd
            FTitleBar.Items[CurrentHT - HTITEM].State := 1;
          end;
      end;
    end;
  end;
end;


procedure TsSkinProvider.SetBoolean(const Index: Integer; const Value: boolean);
var
  M: TMessage;
begin
  case Index of
    0: if FAllowExtBorders <> Value then begin
      FAllowExtBorders := Value;
      if [csLoading, csDesigning] * ComponentState = [] then begin
        InitExBorders(True);
        FCommonData.BGChanged := True;
        RedrawWindow(Form.Handle, nil, 0, RDWA_FRAME);
        UpdateRgn(Self);
      end;
    end;

    1: if FDrawNonClientArea <> Value then begin
      FDrawNonClientArea := Value;
      UpdateNCArea(Value);
    end;

    2: if FShowAppIcon <> Value then begin
      FShowAppIcon := Value;
      if not (csDesigning in ComponentState) then begin
        FCommonData.BGChanged := True;
        if Form.Visible then
          UpdateSkinCaption(Self);
      end;
    end;

    3: if FUseGlobalColor <> Value then begin
      FUseGlobalColor := Value;
      if FCommonData.Skinned and Assigned(Form) and Value and not SkinData.CustomColor then
        Form.Color := FCommonData.SkinManager.GetGlobalColor;
    end;

    4: if FUWPMode <> Value then begin
      FluentUWPMode := Value;
      FUWPMode := Value;
      if not Value then
        SystemBlur.FActive := False;

      if [csLoading, csDesigning] * ComponentState = [] then begin
        UpdateUWPMode;
        SystemBlur.UpdateBlurMode;
        if not Value then
          if (Form.BorderStyle = bsNone) and (FluentBorderStyle <> bsNone) then begin
            Form.BorderStyle := FluentBorderStyle;
            FluentBorderStyle := bsNone;
            CheckSysMenu(True);
          end;
      end;
    end;

    5: if FDrawClientArea <> Value then begin
      FDrawClientArea := Value;
      M := MakeMessage(SM_ALPHACMD, AC_SETBGCHANGED_HI, 1, 0);
      AlphaBroadCast(Form, M);
      SkinData.Invalidate;
    end;
  end;
end;


procedure TsSkinProvider.SetPressedHT(const i: integer);
begin
  if (CurrentHT <> i) and (CurrentHT <> 0) then begin
    case CurrentHT of
      HTCLOSE:      ButtonClose.cpState := 0;
      HTMAXBUTTON:  ButtonMax.cpState   := 0;
      HTMINBUTTON:  ButtonMin.cpState   := 0;
      HTHELP:       ButtonHelp.cpState  := 0;
      HTCHILDCLOSE: MDIClose.cpState    := 0;
      HTCHILDMAX:   MDIMax.cpState      := 0;
      HTCHILDMIN:   MDIMin.cpState      := 0
      else
        if BetWeen(CurrentHT, HTUDBTN, HTUDBTN + TitleButtons.Count - 1) then begin
          TitleButtons.Items[CurrentHT - HTUDBTN].Data.cpState := 0;
          HideHint(TitleButtons.Items[CurrentHT - HTUDBTN]);
        end
        else
          if BetWeen(CurrentHT, HTITEM, HTITEM + MaxByte) then
            if Assigned(FTitleBar) then begin
              FTitleBar.Items[CurrentHT - HTITEM].State := 0;
              HideHintWnd(FTitleBar.Items[CurrentHT - HTITEM]);
            end;
    end;
    RepaintButton(CurrentHT);
  end;
  CurrentHT := i;
  case CurrentHT of
    HTCLOSE:
      if SystemMenu.EnabledClose then
        ButtonClose.cpState := 2
      else begin
        CurrentHT := 0;
        Exit;
      end;

    HTMAXBUTTON:
      if SystemMenu.EnabledMax or ((Form.WindowState = wsMaximized) and SystemMenu.EnabledRestore) then
        ButtonMax.cpState := 2
      else begin
        CurrentHT := 0;
        Exit;
      end;

    HTMINBUTTON:
      ButtonMin.cpState := 2;

    HTHELP:
      ButtonHelp.cpState := 2;

    HTCHILDCLOSE:
      MDIClose.cpState := 2;

    HTCHILDMAX:
      if SystemMenu.EnabledMax then
        MDIMax.cpState := 2;

    HTCHILDMIN:
      MDIMin.cpState := 2

    else
      if BetWeen(CurrentHT, HTUDBTN, HTUDBTN + TitleButtons.Count - 1) then begin
        TitleButtons.Items[CurrentHT - HTUDBTN].Data.cpState := 2;
        HideHint(TitleButtons.Items[CurrentHT - HTUDBTN]);
      end
      else
        if BetWeen(CurrentHT, HTITEM, HTITEM + MaxByte) then
          if Assigned(FTitleBar) then begin
            FTitleBar.Items[CurrentHT - HTITEM].State := 2;
            HideHintWnd(FTitleBar.Items[CurrentHT - HTITEM]);
            if FTitleBar.Items[CurrentHT - HTITEM].Style = bsTab then begin
              FreeAndNil(FTitleBar.Items[CurrentHT - HTITEM].Timer);
              CurrentHT := -1;
              Exit; // No animation
            end;
          end;
  end;
  biClicked := True;
  RepaintButton(CurrentHT);
end;


procedure TsSkinProvider.SetResizeMode(const Value: TsResizeMode);
begin
  FResizeMode := rmStandard;
end;


procedure TsSkinProvider.SetSkinSection(const Index: Integer; const Value: TsSkinSection);
begin
  case Index of
    0: if FTitleSkin <> Value then begin
      FTitleSkin := Value;
      FTitleSkinIndex := -1;
      FCommonData.BGChanged := True;
      InitIndexes;
      if not (csDesigning in ComponentState) and Form.Visible then
        if BorderForm <> nil then
          BorderForm.UpdateExBordersPos
        else
          ProcessMessage(WM_NCPAINT, 0, 0);
    end;

    1: if FMenuLineSkin <> Value then begin
      FMenuLineSkin := Value;
      if csDesigning in ComponentState then
        SkinData.Invalidate;
    end;
  end;
end;


type
  TacAccessTitleBar = class(TsTitleBar);


function TsSkinProvider.PaintAll: boolean;
var
  s: acString;
  BG: TacBGInfo;
  CI: TCacheInfo;
  gd: TsGeneralData;
  ts, tsAdded: TSize;
  sMan: TsSkinManager;
  CurrentItem: TMenuItem;

  SavedCanvas, SavedDC: hdc;
  r, rForm, rC, aShadowSize: TRect;
  Iconic, exBorders, ShowCaption: boolean;
  BordIndex, x, w, h, y, fHeight, fWidth, fCaptHeight, iCaptHeight, iDrawMode, iDrawState: integer;
  iOffsetX, iOffsetY, iDiff, ItemProcessed, ChangedIndex, VisIndex, Index, i, sbw, TitleIndex, CY, maxCY: integer;
{$IFNDEF FPC}
  function ProcessMerged(CurrentIndex: integer): boolean;
  var
    i, j, VisJ, w: integer;
    LocalItem: TMenuItem;
  begin
    Result := False;
    if Assigned(Form.ActiveMDIChild) and Assigned(Form.ActiveMDIChild.Menu) then
      for i := ItemProcessed to Form.ActiveMDIChild.Menu.Items.Count - 1 do
        if Form.ActiveMDIChild.Menu.Items[i].Visible then begin
          LocalItem := Form.ActiveMDIChild.Menu.Items[i];
          // If MDI form and included other
          if (LocalItem.GroupIndex > ChangedIndex) and (LocalItem.GroupIndex <= CurrentIndex) then begin
            if not Assigned(LocalItem.OnMeasureItem) or not Assigned(LocalItem.OnAdvancedDrawItem) then
              Continue;

            Result := LocalItem.GroupIndex >= CurrentIndex;
            ChangedIndex := LocalItem.GroupIndex;
            j := i;
            VisJ := j;
            while j < Form.ActiveMDIChild.Menu.Items.Count do begin
              LocalItem := Form.ActiveMDIChild.Menu.Items[j];
              if (LocalItem.GroupIndex > CurrentIndex) and (Index < Form.Menu.Items.Count) then
                Exit;

              GetMenuItemRect(Form.ActiveMDIChild.Handle, Form.ActiveMDIChild.Menu.Handle, VisJ, R);
              LastMenuItemRect := R;
              w := WidthOf(R);
              ChangedIndex := LocalItem.GroupIndex;
              if x + w > Form.Width - 2 * sbw - 2 * TForm(Form).BorderWidth then begin
                x := sbw + aShadowSize.Left;
                inc(y, MenuHeight);
              end;
              r := Rect(x, y, x + w, y + MenuHeight);
              LocalItem.OnAdvancedDrawItem(LocalItem, FCommonData.FCacheBmp.Canvas, R, []);
              x := r.Right;
              ItemProcessed := i + 1;
              inc(j);
              inc(VisIndex);
              inc(VisJ);
            end;
          end;
        end;
  end;
{$ENDIF}
  procedure PaintTitle(CaptWidth: integer);
  begin
    if (iCaptHeight <> 0) and CanDrawNCArea and not FUWPMode then
      with TDstRect(rForm) do begin // Paint title
        CI := MakeCacheInfo(FCommonData.FCacheBmp, 0, 0); // Prepare cache info
        TitleIndex := FTitleSkinIndex;
        if sMan.IsValidSkinIndex(TitleIndex) and not exBorders then
          with FCommonData.CommonSkinData do
            PaintItem(TitleIndex, CI, True, min(integer(FormActive), gd[TitleIndex].States - 1), Rect(DLeft, DTop, DRight, iff(Iconic, DBottom, fCaptHeight)), MkPoint, FCommonData.FCacheBmp, SkinData.CommonSkinData);

        if (FormHeader.AdditionalHeight > 0) and (FHeaderIndex >= 0) then
          PaintItem(FHeaderIndex, CI, True, integer(FormActive), Rect(DLeft, DTop, DRight, fCaptHeight + FormHeader.ScaledAddHeight), MkPoint, FCommonData.FCacheBmp, SkinData.CommonSkinData);

        DrawAppIcon(Self); // Draw app icon
        if SysButtonsCount > 0 then begin // Paint title toolbar if defined in skin
          i := sMan.GetMaskIndex(FCommonData.SkinIndex, s_NormalTitleBar, SkinData.CommonSkinData);
          if sMan.IsValidImgIndex(i) then
            DrawSkinRect(FCommonData.FCacheBmp, Rect(CaptWidth - BarWidth(i), 0, fWidth, h - CY),
                         EmptyCI, FCommonData.CommonSkinData.ma[i], iDrawState, True);
        end;
      end;
  end;

  procedure PaintText;
  var
    cRect: TRect;
    Flags: Cardinal;
    st, sIndex, i: integer;
    SavedTitle: TBitmap;
    TextAlign: TAlignment;
  begin
    if (iCaptHeight <> 0) and CanDrawNCArea and not FUWPMode then begin // Out the title text
      // Receive a caption rect
      if Assigned(FTitleBar) then begin
        if FTitleBar.ShowCaption then begin
          R.Left  := FTitleBar.BarRect.Left + FTitleBar.LeftWidth;
          R.Right := FTitleBar.BarRect.Right - FTitleBar.RightWidth - SkinData.CommonSkinData.Spacing * 2;
        end
        else begin
          R.Left  := FTitleBar.BarRect.Left + FTitleBar.LeftWidth;
          R.Right := FTitleBar.BarRect.Right;
        end;
      end
      else
        if CaptionAlignment <> taCenter then
          if SysRTLAllowed then begin
            R.Right := SkinData.FCacheBmp.Width - (SysBorderWidth(Form.Handle, BorderForm) + integer(IconVisible) * WidthOf(FIconRect, True) + SkinData.CommonSkinData.Spacing +
                      SkinData.CommonSkinData.BIRightMargin + aShadowSize.Right + integer(FCaptionSkinIndex >= 0) * 2);

            R.Left := TitleBtnsWidth + aShadowSize.Right + SysBorderWidth(Form.Handle, BorderForm) + SkinData.CommonSkinData.Spacing;
          end
          else begin
            if IconVisible then
              R.Left := FIconRect.Right + SkinData.CommonSkinData.Spacing
            else
              R.Left := SysBorderWidth(Form.Handle, BorderForm) + SkinData.CommonSkinData.BILeftMargin + aShadowSize.Left + integer(FCaptionSkinIndex >= 0) * 2;

            R.Right := fWidth - TitleBtnsWidth {- 12} - aShadowSize.Right - SysBorderWidth(Form.Handle, BorderForm) - SkinData.CommonSkinData.Spacing;
          end
        else begin
          R.Left := SysBorderWidth(Form.Handle, BorderForm) + aShadowSize.Left;
          R.Right := fWidth - aShadowSize.Right;
        end;

      R.Bottom := fCaptHeight;
      if IsZoomed(Form.Handle) then
        R.Top := iff(BorderForm <> nil, aShadowSize.Top + 1, 3 {SysBorderWidth(Form.Handle, BorderForm, False) div 2 + 1;})
      else
        R.Top := aShadowSize.Top;
      // Adding a vertical offset
      if BorderForm <> nil then begin
        OffsetRect(R, 0, SkinData.CommonSkinData.ExCenterOffs);
        if (Form.WindowState = wsMaximized) and
            (SkinData.CommonSkinData.ExMaxHeight <> 0) and
             (SkinData.CommonSkinData.ExTitleHeight <> SkinData.CommonSkinData.ExMaxHeight) then

          OffsetRect(R, 0, (SkinData.CommonSkinData.ExTitleHeight - SkinData.CommonSkinData.ExMaxHeight) div 2)
      end;
      if Assigned(FTitleBar) then
        ShowCaption := FTitleBar.ShowCaption
      else
        ShowCaption := AddedTitle.ShowMainCaption;

      if not IsRectEmpty(R) then begin
        // Receive a size of the added text
        if {(not Assigned(FTitleBar) or FTitleBar.ShowCaption) and} (FAddedTitle.Text <> '') then begin
          FCommonData.FCacheBmp.Canvas.Font.Assign(FAddedTitle.FFont);
//          if FCommonData.SkinManager.Options.ScaleMode in [smVCL] then
            FCommonData.FCacheBmp.Canvas.Font.Height := ScaleInt(FAddedTitle.FFont.Height, FCommonData);

          acGetTextExtent(FCommonData.FCacheBmp.Canvas.Handle, FAddedTitle.Text, tsAdded);
        end
        else
          tsAdded := MkSize(0, 0);

        if ShowCaption then begin
          // Receive a size of the caption text
          FCommonData.FCacheBmp.Canvas.Font.Handle := acGetTitleFont(SkinData.CommonSkinData.PPI);
          if not (csDesigning in SkinData.SkinManager.ComponentState) then
            FCommonData.FCacheBmp.Canvas.Font.Height := ScaleInt(-13, FCommonData)
          else
            FCommonData.FCacheBmp.Canvas.Font.Height := GetCaptionFontSize;

          if ac_UseSysCharSet then
            FCommonData.FCacheBmp.Canvas.Font.Charset := GetDefFontCharSet
          else
            FCommonData.FCacheBmp.Canvas.Font.Charset := Form.Font.Charset;

          case DefaultManager.Fonts.MainMode of
            fmCustom:
              if DefaultManager.Fonts.MainFont <> '' then
                FCommonData.FCacheBmp.Canvas.Font.Name := DefaultManager.Fonts.MainFont;

            fmFromSkin:
              if DefaultManager.SkinCommonInfo.MainFont <> '' then
                FCommonData.FCacheBmp.Canvas.Font.Name := DefaultManager.SkinCommonInfo.MainFont;
          end;
          s := {$IFDEF TNTUNICODE} WideString(GetWndText(Form.Handle)) {$ELSE} Form.Caption {$ENDIF};
          acGetTextExtent(FCommonData.FCacheBmp.Canvas.Handle, s, ts);
        end
        else begin
          ts := tsAdded;
          tsAdded := MkSize;
        end;
        // Correct a rect with received height of text
        maxCY := max(ts.cy, tsAdded.cy);
        if (sMan.SysFontScale = 0) and (sMan.GetScale > 0) then
          inc(maxCY);

        if FTitleBar = nil then
          R.Top := VCenter - maxCY div 2 - 1
        else
          R.Top := TacAccessTitleBar(FTitleBar).FBarVCenter - maxCY div 2;

        R.Bottom := R.Top + maxCY;
        TextAlign := CaptionAlignment;
        if Form.UseRightToLeftAlignment then
          if TextAlign = Classes.taLeftJustify then
            TextAlign := Classes.taRightJustify
          else
            if TextAlign = Classes.taRightJustify then
              TextAlign := Classes.taLeftJustify;

        case TextAlign of
          Classes.taCenter: begin
            R.Left := max(R.Left, R.Left + (WidthOf(R) - ts.cx - tsAdded.cx - SkinData.CommonSkinData.Spacing) div 2);
            R.Right := min(R.Left + ts.cx, R.Right);
          end;
          Classes.taRightJustify: begin
            i := ts.cx + tsAdded.cx + SkinData.CommonSkinData.Spacing;
            if i < WidthOf(R) then
              R.Left := R.Right - i;
          end;
        end;
        Flags := DT_END_ELLIPSIS or DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX or iff(Form.UseRightToLeftReading, DT_RTLREADING, DT_LEFT);
        if ShowCaption then begin
          cRect := R;
          acDrawText(FCommonData.FCacheBmp.Canvas.Handle, s, cRect, Flags or DT_CALCRECT);
          if FCaptionSkinIndex >= 0 then begin // If Caption panel must be drawn
            InflateRect(cRect, 4, 2);
            SavedTitle := CreateBmp32(fWidth, fCaptHeight);
            BitBlt(SavedTitle.Canvas.Handle, 0, 0, fWidth, fCaptHeight, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
            CI := MakeCacheInfo(SavedTitle, cRect.Left, cRect.Top);
            PaintItem(FCaptionSkinIndex, CI, True, min(integer(FormActive),
                      FCommonData.CommonSkinData.gd[FCaptionSkinIndex].States - 1), cRect, MkPoint, FCommonData.FCacheBmp, SkinData.CommonSkinData);

            FreeAndNil(SavedTitle);
            sIndex := FCaptionSkinIndex;
          end
          else
            sIndex := FTitleSkinIndex;

          if sIndex >= 0 then begin
            // Draw a text glowing
            i := integer(FormActive);
            i := FCommonData.CommonSkinData.gd[sIndex].Props[i].GlowSize;
            if i <> 0 then
              if FormActive then
                acDrawGlowForText(FCommonData.FCacheBmp, PacChar(s), R, Flags, BF_RECT, i, FCommonData.CommonSkinData.gd[sIndex].Props[1].GlowColor, FGlow1)
              else
                acDrawGlowForText(FCommonData.FCacheBmp, PacChar(s), R, Flags, BF_RECT, i, FCommonData.CommonSkinData.gd[sIndex].Props[0].GlowColor, FGlow2);
            // Text output
            FCommonData.FCacheBmp.Canvas.Brush.Style := bsClear;
            if BorderForm = nil then
              acWriteTextEx(FCommonData.FCacheBmp.Canvas, PacChar(s), Form.Enabled, R, Flags, sIndex, FormActive, sMan)
            else
              WriteText32(FCommonData.FCacheBmp, PacChar(s), Form.Enabled, R, Flags, sIndex, integer(FormActive), sMan);
          end;
          R.Left := cRect.Right;
        end
        else
          tsAdded := ts;
        // Additional text
        if FAddedTitle.Text <> '' then begin
          inc(R.Left, SkinData.CommonSkinData.Spacing);
          R.Right := R.Left + tsAdded.cx + 4;
          if (R.Left + 8 < R.Right) and (FTitleSkinIndex >= 0) then begin
            FCommonData.FCacheBmp.Canvas.Font.Assign(FAddedTitle.Font);
//            FCommonData.FCacheBmp.Canvas.Font.Height := FAddedTitle.Font.Height;
//            if FCommonData.SkinManager.Options.ScaleMode in [smOldMode, smVCL] then
              FCommonData.FCacheBmp.Canvas.Font.Height := ScaleInt(FAddedTitle.FFont.Height, FCommonData);

            case FAddedTitle.Font.Color of
              clNone, clWindowText: begin
                st := integer(FormActive);
                FCommonData.FCacheBmp.Canvas.Font.Color := FCommonData.CommonSkinData.gd[FTitleSkinIndex].Props[st].FontColor.Color;
              end
              else
                if not FormActive then
                  FCommonData.FCacheBmp.Canvas.Font.Color := BlendColors(FCommonData.CommonSkinData.gd[FTitleSkinIndex].Props[0].FontColor.Color, FAddedTitle.Font.Color, 127);
            end;

            i := integer(FormActive);
            i := FCommonData.CommonSkinData.gd[FTitleSkinIndex].Props[i].GlowSize;
            if i <> 0 then
              if FormActive then
                acDrawGlowForText(FCommonData.FCacheBmp, PacChar(FAddedTitle.Text), R, Flags, BF_RECT, FTitleSkinIndex, FCommonData.CommonSkinData.gd[FTitleSkinIndex].Props[1].GlowColor, FGlow1)
              else
                acDrawGlowForText(FCommonData.FCacheBmp, PacChar(FAddedTitle.Text), R, Flags, BF_RECT, FTitleSkinIndex, FCommonData.CommonSkinData.gd[FTitleSkinIndex].Props[0].GlowColor, FGlow2);


            if BorderForm = nil then begin
              FCommonData.FCacheBmp.Canvas.Brush.Style := bsClear;
              acWriteTextEx(FCommonData.FCacheBmp.Canvas, PacChar(FAddedTitle.Text), Form.Enabled, R, Flags, FTitleSkinIndex, FormActive, sMan)
            end
            else
              WriteText32(FCommonData.FCacheBmp, PacChar(FAddedTitle.Text), True, R, Flags, FTitleSkinIndex, integer(FormActive), FCommonData.SkinManager);
          end;
        end;
      end;
    end;
  end;

  procedure CheckCorners;
  var
    aRect: TRect;
    CI: TCacheInfo;
    iRadius: integer;
    Radiuses: TacIntValues;
    PRadiuses: PacIntValues;
  begin
    iRadius := SkinData.SkinManager.gd[SkinData.SkinIndex].BorderRadius;
    if iRadius > 0 then begin
      Radiuses.Value0 := iRadius;
      Radiuses.Value1 := iRadius;
      Radiuses.Value2 := iRadius;
      Radiuses.Value3 := iRadius;
      PRadiuses := @Radiuses;

      CI := EmptyCI;
      CI.Bmp := BorderForm.ShadowTemplate;
      CI.Y := 0;
      CI.X := 0;
      CI.Ready := True;
      with SkinData.SkinManager.gd[SkinData.SkinIndex] do
        if BorderWidth > 0 then
          CI.FillColor := Props[integer(FormActive)].BorderColor
        else
          CI.FillColor := Props[integer(FormActive)].Color;

      aRect := MkRect(SkinData.FCacheBmp);
      inc(aRect.Left, aShadowSize.Left);
      inc(aRect.Top, aShadowSize.Top);
      dec(aRect.Right, aShadowSize.Right);
      dec(aRect.Bottom, aShadowSize.Bottom);
      UpdateCorners(gd, SkinData.FCacheBmp, aRect, CI, PRadiuses, True);
    end;
  end;

begin
  ResetLastError;
  Result := True;
  if (csCreating in Form.ControlState) or (FormState and (FS_BLENDMOVING or FS_ANIMCLOSING) <> 0) and (FormState and FS_SCALING = 0) or (SkinData.SkinIndex < 0) then
    Exit;

  if DoReinit then begin
    DoReinit := False;
    InitSysVariables;
    FLinesCount := -1;
    MenuChanged := True;
    FCommonData.BGChanged := True;
    SetWindowPos(Form.Handle, 0, 0, 0, 0, 0, SWPA_FRAMECHANGED);
  end;
  LastMenuItemRect := MkRect; // Reset
  Iconic := IsIconic(Form.Handle) and (Application.MainForm <> Form);
  CY := SysBorderHeight(Form.Handle, BorderForm, False);
  iCaptHeight := CaptionHeight;
  h := 2 * CY + iCaptHeight;
  aShadowSize := ShadowSize;
  fCaptHeight := iCaptHeight + CY + aShadowSize.Top;
  if Iconic then
    fHeight := fCaptHeight - aShadowSize.Top + 2
  else
    fHeight := Form.Height;

  if BorderForm <> nil then begin
    iDiff := DiffBorder(Self.BorderForm);
    fHeight := fHeight + iDiff + DiffTitle(Self.BorderForm) + aShadowSize.Top + aShadowSize.Bottom;
  end
  else
    iDiff := 0;

  fWidth := CaptionWidth;
  sMan := SkinData.SkinManager;
  iDrawState := min(integer(FormActive), FCommonData.CommonSkinData.gd[FCommonData.SkinIndex].States - 1);
  exBorders := (BorderForm <> nil) and (SkinData.CommonSkinData.ExDrawMode = 1) and (SkinData.SkinManager.ExtBordersMode = ebmFull);
  with FCommonData do
    if FCacheBmp = nil then begin // If first loading
      FCacheBmp := CreateBmp32(fWidth, fHeight);
      FCacheBmp.Canvas.Handle;
    end
    else begin
      FCacheBmp.PixelFormat := pf32bit;
      FCacheBmp.Width := fWidth;
      FCacheBmp.Height := fHeight;
    end;

  if (Form.FormStyle = fsMDIForm) and (Form.ActiveMDIChild <> nil) and (Form.ActiveMDIChild.WindowState = wsMaximized) then
    if (fsShowing in Form.ActiveMDIChild.FormState) and MenuChanged then
      Exit;

  ItemProcessed := 0;
  sbw := SysBorderWidth(Form.Handle, BorderForm);
  if UWPMode then
    rForm := UWPClientRect
  else
    rForm := Rect(aShadowSize.Left, aShadowSize.Top, fWidth - aShadowSize.Right, fHeight - aShadowSize.Bottom);

  Result := True;
  if FCommonData.BGChanged then begin
    if SystemBlur.Active then
      FillRect32(FCommonData.FCacheBmp, MkRect(fWidth, fHeight), 0, 0);

    CalcItems;
    CI.Ready := False;
    iOffsetX := OffsetX;
    iOffsetY := OffsetY;
    if sMan.IsValidSkinIndex(FCommonData.SkinIndex) then begin
      if Form.Parent = nil then
        CI := EmptyCI
      else begin
        BG.DrawDC := 0;
        BG.Offset := MkPoint;
        BG.PleaseDraw := False;
        GetBGInfo(@BG, Form.Parent, False);
        if BG.BgType = btNotReady then begin
          FCommonData.Updating := True;
          Result := False;
          Exit;
        end;
        CI := BGInfoToCI(@BG);
      end;
      // Paint the form with borders
      gd := FCommonData.CommonSkinData.gd[FCommonData.SkinIndex];
      if not SystemBlur.Active then
        if (HaveBorder(Self) or (gd.BorderRadius > 0) or (Form.Parent <> nil) and not exBorders) and ((gd.BorderIndex >= 0) or {(gd.BorderRadius > 0) or} (gd.Props[0].BorderColor <> clFuchsia)) and not FUWPMode then
          PaintItem(FCommonData, CI, False, iDrawState, rForm, MkPoint(Form), FCommonData.FCacheBmp, Form.Parent <> nil)
        else begin
          if FCommonData.CustomColor then
            PaintItemBG(FCommonData.SkinIndex, CI, iDrawState, rForm, MkPoint(Form), FCommonData.FCacheBmp, FCommonData.CommonSkinData, -1, -1, ColorToRGB(Form.Color))
          else
            PaintItemBG(FCommonData.SkinIndex, CI, iDrawState, rForm, MkPoint(Form), FCommonData.FCacheBmp, FCommonData.CommonSkinData);

          with gd do begin
            if sMan.IsValidImgIndex(ImgTL) then
              DrawSkinGlyph(FCommonData.FCacheBmp, rForm.TopLeft, iDrawState, 1, FCommonData.CommonSkinData.ma[ImgTL], MakeCacheInfo(FCommonData.FCacheBmp));

            if sMan.IsValidImgIndex(ImgTR) then
              DrawSkinGlyph(FCommonData.FCacheBmp, Point(rForm.Right - FCommonData.CommonSkinData.ma[ImgTR].Width, rForm.Top), iDrawState, 1, FCommonData.CommonSkinData.ma[ImgTR], MakeCacheInfo(FCommonData.FCacheBmp));

            if sMan.IsValidImgIndex(ImgBL) then
              DrawSkinGlyph(FCommonData.FCacheBmp, Point(0, rForm.Bottom - FCommonData.CommonSkinData.ma[ImgBL].Height), iDrawState, 1, FCommonData.CommonSkinData.ma[ImgBL], MakeCacheInfo(FCommonData.FCacheBmp));

            if sMan.IsValidImgIndex(ImgBR) then
              DrawSkinGlyph(FCommonData.FCacheBmp, Point(rForm.Right - FCommonData.CommonSkinData.ma[ImgBR].Width, rForm.Bottom - FCommonData.CommonSkinData.ma[ImgBR].Height), iDrawState, 1, FCommonData.CommonSkinData.ma[ImgBR], MakeCacheInfo(FCommonData.FCacheBmp));
          end;
        end;

      if not exBorders then
        PaintTitle(fWidth);

      CI := MakeCacheInfo(FCommonData.FCacheBmp, iOffsetX, iOffsetY); // Prepare cache info

      if (StatusBar <> nil) then begin
        i := FCommonData.SkinManager.SkinCommonInfo.Sections[ssStatusBar];
        if i >= 0 then
          if FCommonData.SkinManager.gd[i].ReservedBoolean then begin
            R := rForm;
            R.Top := iOffsetY + StatusBar.Top;
            PaintItem(TsStatusBar(StatusBar).SkinData, CI, True, 0, R, MkPoint, SkinData.FCacheBmp, False);
          end;
      end;

{$IFNDEF FPC}
      // Menu line drawing
      if IsMenuVisible(Self) and MenuPresent and (MenuHeight > 0) and CanDrawNCArea and sMan.SkinnedPopups then begin
        if FMenuLineSkin <> '' then
          i := sMan.GetSkinIndex(FMenuLineSkin)
        else
          i := -1;

        if i < 0 then
          i := sMan.SkinCommonInfo.Sections[ssMenuLine]; // Paint menu bar

        if sMan.IsValidSkinIndex(i) then
          PaintItem(i, CI, True, iDrawState,
                     Rect(aShadowSize.Left, fCaptHeight, fWidth - aShadowSize.Right, fCaptHeight + LinesCount * MenuHeight + 1),
                    Point(aShadowSize.Left, fCaptHeight), FCommonData.FCacheBmp, SkinData.CommonSkinData);

        MenuLineBmp.Width  := fWidth - aShadowSize.Left - aShadowSize.Right; // Store bg for Menu line
        MenuLineBmp.Height := LinesCount * MenuHeight + 1;
        y := iOffsetY - LinesCount * MenuHeight - Form.BorderWidth - 1;
        BitBlt(MenuLineBmp.Canvas.Handle, 0, 0, MenuLineBmp.Width, MenuLineBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, iOffsetX - Form.BorderWidth, y, SRCCOPY);
        // Draw maximized child form system icon on menuline
        if ChildIconPresent and (MDISkinProvider = Self) then
          if Form.ActiveMDIChild.Icon.Handle <> 0 then
            DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, sbw + 1 + aShadowSize.Left, fCaptHeight + 1, Form.ActiveMDIChild.Icon.Handle, MenuHeight - 2, MenuHeight - 2, 0, 0, DI_NORMAL)
          else
            if AppIcon <> nil then
              DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, sbw + 1 + aShadowSize.Left, fCaptHeight + 1, AppIcon.Handle, MenuHeight - 2, MenuHeight - 2, 0, 0, DI_NORMAL)
            else
              DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, sbw + 1 + aShadowSize.Left, fCaptHeight + 1, LoadIcon(0, IDI_APPLICATION), MenuHeight - 2, MenuHeight - 2, 0, 0, DI_NORMAL);

        // << Menu items >> //
        x := sbw + aShadowSize.Left;
        y := fCaptHeight;
        ChangedIndex := -1;
        Index := 0;
        VisIndex := 0;
        TryInitMenu;
        while Index < Form.Menu.Items.Count do begin
          if (x = sbw + aShadowSize.Left) and (MDISkinProvider = Self) and ChildIconPresent then begin // Skip Item with child icon
            GetMenuItemRect(Form.Handle, Form.Menu.Handle, 0, R);
            inc(x, WidthOf(R));
            inc(VisIndex);
            Continue;
          end;
          CurrentItem := Form.Menu.Items[Index];
          if (CurrentItem.GroupIndex = ChangedIndex) or ProcessMerged(CurrentItem.GroupIndex) then begin
            inc(Index);
            Continue;
          end
          else begin
            if not CurrentItem.Visible then begin
              inc(Index);
              Continue;
            end;
            if not Assigned(CurrentItem.OnMeasureItem) or not Assigned(CurrentItem.OnAdvancedDrawItem) then
              if not CurrentItem.GetParentMenu.OwnerDraw then begin
                MenusInitialized := False;
                TryInitMenu;
              end
              else
                sMan.SkinableMenus.InitMenuLine(Form.Menu, True);

            if GetMenuItemRect(Form.Handle, Form.Menu.Handle, VisIndex, R) then begin
              LastMenuItemRect := R;
              w := WidthOf(R);
              OffsetRect(R, -Form.Left + iDiff + aShadowSize.Left, -Form.Top + DiffTitle(Self.BorderForm) + aShadowSize.Top + 4 * integer(FSysExHeight));
              if Assigned(CurrentItem.OnAdvancedDrawItem) then begin
                sMan.SkinableMenus.MenuProvider := Self;
                CurrentItem.OnAdvancedDrawItem(CurrentItem, FCommonData.FCacheBmp.Canvas, R, [odNoAccel, odReserved1]);
                sMan.SkinableMenus.MenuProvider := nil;
              end;
              inc(x, w);
            end;

            inc(Index);
            inc(VisIndex);
          end;
        end;
        ProcessMerged(MaxInt);
      end; // End menu drawing
{$ENDIF}
      if not exBorders and (BorderForm <> nil) then
        PaintText;

      // Paint MDIArea
      if (Form.FormStyle = fsMDIForm) and Assigned(MDIForm) then begin
        rC.Left := BorderWidth + GetAlignShift(Form, alLeft) + aShadowSize.Left;
        rC.Top := fCaptHeight + LinesCount * MenuHeight * integer(MenuPresent) + Form.BorderWidth + GetAlignShift(Form, alTop);

        if Menuheight <> 0 then
          inc(rC.Top);

        rC.Right  := fWidth  - BorderWidth - GetAlignShift(Form, alRight)  - aShadowSize.Right;
        rC.Bottom := fHeight - BorderWidth - GetAlignShift(Form, alBottom) - aShadowSize.Bottom;
        CI := MakeCacheInfo(FCommonData.FCacheBmp);
        i := sMan.GetSkinIndex(s_MDIArea);
        PaintItem(i, CI, False, 0, Rect(rC.Left, rC.Top, rC.Right, rC.Bottom), rC.TopLeft, FCommonData.FCacheBmp.Canvas.Handle, SkinData.CommonSkinData);
      end;

      if BorderForm <> nil then
        with FCommonData.CommonSkinData do begin // Painting of form shadow if required
          if FUWPMode then
            BorderForm.ShadowTemplate := UWPTemplate(FormActive)
          else
            if FormActive then
              BorderForm.ShadowTemplate := ShdaTemplate
            else
              BorderForm.ShadowTemplate := ShdiTemplate;

          if BorderForm.ShadowTemplate <> nil then begin
            if FUWPMode then begin
              sbw := (BorderForm.ShadowTemplate.Width - 1) div 2;
              CY := (BorderForm.ShadowTemplate.Height - 1) div 2;
              rC := UWPClientRect;
              dec(rC.Left, aShadowSize.Left);
              dec(rC.Top, aShadowSize.Top);
              inc(rC.Right, aShadowSize.Right);
              inc(rC.Bottom, aShadowSize.Bottom);
              FillRect32Excl(FCommonData.FCacheBmp, MkRect(FCommonData.FCacheBmp), rC, 0, 0);
              PaintControlByTemplate(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, rC,
                  MkRect(BorderForm.ShadowTemplate),
                  Rect(sbw, CY, sbw, CY),
                  aShadowSize, Rect(1, 1, 1, 1), False, False); // For internal shadows - stretch only allowed
            end
            else begin
              i := BorderForm.CaptionHeight;
              if exBorders then begin
                if SkinData.SkinManager.ExtBordersMode = ebmFull then
                  ChangedIndex := SkinData.CommonSkinData.ExBorder // Index of extended border in skin
                else
                  ChangedIndex := -1;

                if ChangedIndex >= 0 then begin
                  iDrawMode := ma[ChangedIndex].DrawMode and BDM_STRETCH;
                  if FHeaderIndex >= 0 then
                    sbw := FormHeader.ScaledAddHeight
                  else
                    sbw := 0;

                  PaintControlByTemplate(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, MkRect(fWidth, fHeight),
                      MkRect(BorderForm.ShadowTemplate),
                      Rect(ma[ChangedIndex].WL, min(ma[ChangedIndex].WT, iCaptHeight + (fHeight - iCaptHeight) div 2),
                           ma[ChangedIndex].WR, min(ma[ChangedIndex].WB, (fHeight - iCaptHeight) div 2)),
                      Rect(aShadowSize.Left + BorderWidth, aShadowSize.Top + i + sbw, aShadowSize.Right + BorderWidth, aShadowSize.Bottom + BorderWidth),//!!! + 2),
                      Rect(iDrawMode, iDrawMode, iDrawMode, iDrawMode), False, False);
                end;
                PaintTitle(fWidth);
                PaintText;
              end
              else begin
                if (SkinData.CommonSkinData.ExBorder >= 0) and (SkinData.SkinManager.ExtBordersMode = ebmFull) then
                  with ma[SkinData.CommonSkinData.ExBorder] do
                    PaintControlByTemplate(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, MkRect(fWidth, fHeight),
                        MkRect(BorderForm.ShadowTemplate), Rect(WL, WT, WR, WB), aShadowSize, // Offsets to content
                        Rect(DrawMode, DrawMode, DrawMode, DrawMode), DrawMode <> 0, False)
                else begin // If internal shadows
                  sbw := (BorderForm.ShadowTemplate.Width - 1) div 2;
                  CY := (BorderForm.ShadowTemplate.Height - 1) div 2;

                  PaintControlByTemplate(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, MkRect(fWidth, fHeight),
                      MkRect(BorderForm.ShadowTemplate),
                      Rect(sbw, CY, sbw, CY),
                      aShadowSize,
                      Rect(1, 1, 1, 1), False, False); // For internal shadows - stretch only allowed

                  CheckCorners;
                end;
                // Draw shadows in corners
                if sMan.IsValidImgIndex(TitleIndex) then
                  TitleIndex := gd[TitleIndex].BorderIndex;

                BordIndex := FCommonData.CommonSkinData.gd[FCommonData.SkinIndex].BorderIndex;
                if sMan.IsValidImgIndex(TitleIndex) then begin // If title mask exists
                  x := ma[TitleIndex].WR;
                  // LeftTop
                  R := Rect(aShadowSize.Left, aShadowSize.Top, aShadowSize.Left + ma[TitleIndex].WL,
                            aShadowSize.Top + ma[TitleIndex].WT);
                  FillTransPixels32(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, R, aShadowSize.TopLeft, TitleIndex, SkinData.CommonSkinData, HTTOPLEFT);
                  // RightTop
                  R := Rect(fWidth - aShadowSize.Right - x, aShadowSize.Top, fWidth - aShadowSize.Right, aShadowSize.Top + ma[TitleIndex].WT);
                  FillTransPixels32(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, R,
                    Point(BorderForm.ShadowTemplate.Width - aShadowSize.Right - x, aShadowSize.Top), TitleIndex, SkinData.CommonSkinData, HTTOPRIGHT);
                end
                else
                  if IsValidIndex(BordIndex, Length(ma)) then begin
                    x := ma[BordIndex].WR;
                    // LeftTop
                    R := Rect(aShadowSize.Left, aShadowSize.Top, aShadowSize.Left + ma[BordIndex].WL, aShadowSize.Top + ma[BordIndex].WT);
                    FillTransPixels32(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, R, aShadowSize.TopLeft, BordIndex, SkinData.CommonSkinData, HTTOPLEFT);
                    // RightTop
                    R := Rect(fWidth - aShadowSize.Right - x,  aShadowSize.Top, fWidth - aShadowSize.Right, aShadowSize.Top + ma[BordIndex].WT);
                    FillTransPixels32(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, R,
                                      Point(max(0, BorderForm.ShadowTemplate.Width - aShadowSize.Right - x), aShadowSize.Top), BordIndex, SkinData.CommonSkinData, HTTOPRIGHT);
                  end;

                if IsValidIndex(BordIndex, Length(ma)) then begin
                  y := ma[BordIndex].WB;
                  x := ma[BordIndex].WR;
                  // LeftBottom
                  R := Rect(aShadowSize.Left, fHeight - aShadowSize.Bottom - y, aShadowSize.Left + ma[BordIndex].WL, fHeight - aShadowSize.Bottom);
                  FillTransPixels32(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, R, Point(aShadowSize.Left, max(0, BorderForm.ShadowTemplate.Height - aShadowSize.Bottom - y)), BordIndex, SkinData.CommonSkinData, HTBOTTOMLEFT);
                  // RightBottom
                  R := Rect(fWidth - aShadowSize.Right - x, fHeight - aShadowSize.Bottom - y, fWidth - aShadowSize.Right, fHeight - aShadowSize.Bottom);
                  FillTransPixels32(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, R,
                    Point(max(0, BorderForm.ShadowTemplate.Width - aShadowSize.Right - x), max(0, BorderForm.ShadowTemplate.Height - aShadowSize.Bottom - y)), BordIndex, SkinData.CommonSkinData, HTBOTTOMRIGHT);
                end;
              end;
            end; // Not UWPMode
          end;
        end;

      if BorderForm = nil then
        PaintText;

      if IsGripVisible(Self) then begin
        FCommonData.BGChanged := False;
        with SkinData.CommonSkinData do
          if sMan.IsValidImgIndex(GripRightBottom) then
            DrawSkinGlyph(FCommonData.FCacheBmp, RBGripPoint(GripRightBottom), 0, 1, ma[GripRightBottom], MakeCacheInfo(FCommonData.FCacheBmp));
      end;
      if (iCaptHeight <> 0) and CanDrawNCArea and not FUWPMode then begin
        SaveBGForBtns(fWidth, True);
        PaintTitleContent(fWidth);
      end;
    end;
    MenuChanged := False;
    FCommonData.BGChanged := False;
    if Assigned(Form.OnPaint) then begin
      if not IsIconic(Form.Handle) then begin
        SavedCanvas := Form.Canvas.Handle;
        Form.Canvas.Handle := SkinData.FCacheBmp.Canvas.Handle;
        SavedDC := SaveDC(Form.Canvas.Handle);
        MoveWindowOrg(Form.Canvas.Handle, iOffsetX, iOffsetY);
        Form.Canvas.TryLock;
        FormState := FormState or FS_BLENDMOVING; // Do not repaint again, skip PaintAll if called
        Form.OnPaint(Form);
        FormState := FormState and not FS_BLENDMOVING;
        Form.Canvas.Unlock;
        RestoreDC(Form.Canvas.Handle, SavedDC);
        Form.Canvas.Handle := SavedCanvas;
      end
      else begin
        FirstInitialized := True;
        SkinData.BGChanged := True; // Call OnPaint later when restored
        FCommonData.Updating := False;
        Exit;
      end;

      if UWPNoBorderMode then begin
        rC := UWPClientRect;
        if Form.BorderStyle in [bsSizeable] then
          FillDCBorder32(FCommonData.FCacheBmp, rC, iUWPBorderWidth, iUWPBorderWidth, iUWPBorderWidth, iUWPBorderWidth, SkinData.SkinManager.Palette[pcBorder]);

        FillRect32Excl(FCommonData.FCacheBmp, MkRect(FCommonData.FCacheBmp), rC, 0, 0);
      end;
    end;
    SkinData.PaintOuterEffects(Form, Point(iOffsetX, iOffsetY));
    FirstInitialized := True;
    FCommonData.BGChanged := False;
  end;
  if Form.Parent = nil then
    FCommonData.Updating := False;
end;


function TsSkinProvider.FormLeftTop: TPoint;
var
  p: TPoint;
  R: TRect;
begin
  if TForm(Form).FormStyle = fsMDIChild then begin
    p := Form.ClientToScreen(MkPoint);
    Result.x := p.x - SysBorderWidth (Form.Handle, BorderForm);
    Result.y := p.y - SysBorderHeight(Form.Handle, BorderForm) - integer(not IsIconic(Form.Handle)) * CaptionHeight;
  end
  else begin
    GetWindowRect(Form.Handle, R);
    Result.x := R.Left;
    Result.y := R.Top;
  end;
end;


function TsSkinProvider.FramePadding: integer;
begin
  if Form.BorderStyle in [bsSizeable, bsSizeToolWin] then
    Result := ac_GetSysMetrics(SM_CXPADDEDBORDER, GetWndPPI(Form.Handle))
  else
    Result := 0;
end;


procedure TsSkinProvider.DropSysMenu(x, y: integer);
var
  mi: TMenuitem;
  SysMenu: HMENU;
  SelItem: ACNativeInt;

  procedure EnableCommandItem(uIDEnableItem: UINT; Enable: Boolean);
  begin
    EnableMenuItem(SysMenu, uIDEnableItem, MF_BYCOMMAND or iff(Enable, MF_ENABLED, MF_GRAYED or MF_DISABLED));
  end;

begin
  if SystemMenu = nil then
    PrepareForm;

  if (SystemMenu = nil) { Skin can't be loaded} {$IFDEF D2005}or (Application.ActiveFormHandle <> Form.Handle) {$ENDIF} then
    Exit;

  with SystemMenu do
{$IFNDEF FPC}
    if SkinData.SkinManager.SkinnedPopups then begin
      UpdateItems((ExtItemsCount > 0) or Assigned(SysSubMenu.PopupMenu));
      if FMakeSkinMenu and (Items.Count > 0) then begin
        SkinData.SkinManager.SkinListController.CheckThread;
        SkinData.SkinManager.SkinListController.UpdateIfNeeded;
        if Items[0].Name = s_SkinSelectItemName then begin
          while Items[0].Count > 0 do begin
            mi := Items[0].Items[0];
            Items[0].Delete(0);
            FreeAndNil(mi);
          end;
          mi := Items[0];
          Items.Delete(0);
          FreeAndNil(mi);
        end;
        MakeSkinItems;
      end;
      SkinData.SkinManager.SkinableMenus.HookPopupMenu(SystemMenu, True);
      WindowHandle := Form.Handle;
      BidiMode := Form.BidiMode;
      ParentBidiMode := False;
      Popup(x, y);
      WindowHandle := 0;
    end
    else
{$ENDIF}
    begin
      // Prevent of painting by system (white line)
      SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) and not WS_VISIBLE);
      //get a modifiable copy of the original sysmenu
      SysMenu := GetSystemMenu(Form.Handle, False);
      //read and emulate states from skin SystemMenu
      with SystemMenu do begin
        EnableCommandItem(SC_RESTORE , VisibleRestore and EnabledRestore);
        EnableCommandItem(SC_MOVE    , EnabledMove    and not IsIconic(Form.Handle));
        EnableCommandItem(SC_SIZE    , VisibleSize    and EnabledSize and (Form.WindowState = wsNormal));
        EnableCommandItem(SC_MINIMIZE, VisibleMin     and EnabledMin);
        EnableCommandItem(SC_MAXIMIZE, VisibleMax     and EnabledMax);
        EnableCommandItem(SC_CLOSE   , VisibleClose   and EnabledClose);
      end;
      SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_VISIBLE);
      //Get menuselection from menu, do not send it on automatically
      SelItem := ACNativeInt(TrackPopupMenu(SysMenu, TPM_LEFTBUTTON or TPM_RIGHTBUTTON or TPM_RETURNCMD, x, y, 0, Form.Handle, nil));
      //If the sysmenu tracking resulted in a selection, post it as a WM_SYSCOMMAND
      if SelItem > 0 then
        PostMessage(Form.Handle, WM_SYSCOMMAND, SelItem, 0);
    end;
end;


function TsSkinProvider.CursorToPoint(const x, y: integer): TPoint;
begin
  Result := FormLeftTop;
  Result.x := x - Result.x;
  Result.y := y - Result.y;
end;


function TsSkinProvider.MenuPresent: boolean;
var
 i, VisibleItems: integer;
begin
  Result := False;
  if (Form.BorderStyle <> bsDialog) and (Form.FormStyle <> fsMDIChild) then
    if (Form.Menu <> nil) {$IFNDEF FPC}and not Form.Menu.AutoMerge{$ENDIF} then begin
      VisibleItems := 0;
      for i := 0 to Form.Menu.Items.Count - 1 do
        if Form.Menu.Items[i].Visible then begin
          inc(VisibleItems);
          Break;
        end;

      if (Form.FormStyle = fsMDIForm) and Assigned(Form.ActiveMDIChild) and Assigned(Form.ActiveMDIChild.Menu) then
        for i := 0 to Form.ActiveMDIChild.Menu.Items.Count - 1 do
          if Form.ActiveMDIChild.Menu.Items[i].Visible then begin
            inc(VisibleItems);
            Break;
          end;

      Result := VisibleItems > 0;
    end;
end;


function TsSkinProvider.OffsetX: integer;
var
  i: integer;
begin
  if BorderForm <> nil then
    Result := BorderWidth + ShadowSize.Left
  else begin
    if Assigned(ListSW) and Assigned(ListSW.sBarVert) and ListSW.sBarVert.fScrollVisible then
      i := GetScrollMetric(ListSW.sBarVert, SM_SCROLLWIDTH)
    else
      i := 0;

    Result := (GetWindowWidth(Form.Handle) - GetClientWidth(Form.Handle) - i) div 2
  end;
end;


function TsSkinProvider.OffsetY: integer;
var
  i: integer;
begin
  if BorderForm <> nil then
    Result := CaptionHeight + LinesCount * MenuHeight + Form.BorderWidth + ShadowSize.Top + integer(MenuHeight <> 0)
  else begin
    if Assigned(ListSW) and Assigned(ListSW.sBarHorz) and ListSW.sBarHorz.fScrollVisible then
      i := GetScrollMetric(ListSW.sBarHorz, SM_SCROLLWIDTH)
    else
      i := 0;

    Result := GetWindowHeight(Form.Handle) - GetClientHeight(Form.Handle) - BorderWidth * integer(GetWindowLong(Form.Handle, GWL_STYLE) and WS_BORDER = WS_BORDER) - i;
  end;
end;


function TsSkinProvider.GetLinesCount: integer;
var
  i, y1, y2: integer;
  R: TRect;
begin
  if FLinesCount <> -1 then
    Result := FLinesCount
  else
    if (Form.Menu <> nil) and (Form.WindowState <> wsMinimized) then begin
      Result := 1;
      if GetMenuItemRect(Form.Handle, Form.Menu.Handle, 0, R) then begin
        y1 := R.Bottom;
        GetClientRect(Form.Handle, R);
        if ListSW <> nil then
          i := integer(ListSW.sBarHorz.fScrollVisible) * GetSystemMetrics(SM_CYHSCROLL)
        else
          i := 0;

        y2 := Form.Top + Form.Height - HeightOf(R) - BorderHeight(False) - i - Form.BorderWidth * 2;
        if y2 > y1 then
          inc(Result, (y2 - y1) div (GetSystemMetrics(SM_CYMENU) - 2));

        FLinesCount := Result;
      end
      else
        Result := 0;
    end
    else
      Result := 0;
end;


procedure TsSkinProvider.Loaded;
begin
  inherited;
  Load3rdNames(ThirdParty, ThirdLists, OwnThirdLists);
  if not RTEmpty and not RTInit and Assigned(FCommonData.SkinManager) and not (csDesigning in ComponentState) and FCommonData.Skinned(True) then
    LoadInit;

  if (Form.BidiMode = bdRightToLeft) and (SkinData.SkinManager <> nil) and SkinData.SkinManager.IsActive then
    SkinData.SkinManager.FlipImages(Form.BidiMode = bdRightToLeft);

  if SystemBlur.Active then
    FFormState := FFormState or FS_GLASSNEEDED;
end;


procedure TsSkinProvider.Notification(AComponent: TComponent; Operation: TOperation);
var
  AThirdLists: TStringLists;
begin
  inherited Notification(AComponent, Operation);
  AThirdLists := nil;
  if AComponent is TsSkinManager then
    case Operation of
      opInsert:
        if not Assigned(SkinData.SkinManager) then
          SkinData.SkinManager := TsSkinManager(AComponent);

      opRemove:
        if AComponent = SkinData.SkinManager then
          SkinData.SkinManager := nil;
    end
  else
    if AComponent is TWinControl then
      case Operation of
        opInsert:
          if Assigned(Adapter) then begin
            if OwnThirdLists then
              AThirdLists := ThirdLists
            else
              AThirdLists := SkinData.SkinManager.ThirdLists;

            if TacCtrlAdapter(Adapter).IsControlSupported(TWincontrol(AComponent), AThirdLists) then
              if FAllowSkin3rdParty then
                TacCtrlAdapter(Adapter).AddNewItem(TWincontrol(AComponent), AThirdLists);
          end;
      end
    else
      if AComponent is TsTitleBar then
        case Operation of
          opInsert:
            if FTitleBar = nil then
              FTitleBar := TsTitleBar(AComponent);

          opRemove:
            FTitleBar := nil;
        end;
end;


procedure TsSkinProvider.FillAlphaClient(Bmp: TBitmap);
var
  cR, R: TRect;
  Rects: TRects;
  cx, i: integer;
begin
  if (BorderForm <> nil) or IsBlurred then begin
    cR := Form.ClientRect;
    OffsetRect(cR, OffsetX, OffsetY);
    if cR.Bottom >= Bmp.Height then
      cR.Bottom := Bmp.Height - 1;

    if IsBlurred and Assigned(FluentHandles) then begin
      cx := SysBorderWidth(Form.Handle, nil, False);
      GetWindowRect(Form.Handle, R);
      SetLength(Rects, FluentHandles.Count);
      for i := 0 to FluentHandles.Count - 1 do
        if TObject(FluentHandles[i]) is TWinControl then begin
          GetWindowRect(TWinControl(FluentHandles[i]).Handle, Rects[i]);
          OffsetRect(Rects[i], -R.Left + ShadowSize.Left - cx, -R.Top + ShadowSize.Top + 4);
        end;
    end
    else
      Rects := nil;

    FillAlphaRect(Bmp, cR, MaxByte, clNone, Rects); // Fill AlphaChannell in client area
  end;
end;


function TsSkinProvider.FixedFrame: integer;
begin
//  if CXFixedFrame < 0 then
    CXFixedFrame := ac_GetSysMetrics(SM_CXFIXEDFRAME, GetControlPPI(Form));

  Result := CXFixedFrame;
end;


function TsSkinProvider.FormChanged: boolean;
begin
  Result := (FCommonData.FCacheBmp = nil) or (CaptionWidth <> FCommonData.FCacheBmp.Width) or (Form.Height <> FCommonData.FCacheBmp.Height)
end;


{$IFNDEF FPC}
procedure TsSkinProvider.RepaintMenuItem(mi: TMenuItem; R: TRect; State: TOwnerDrawState);
var
  DC, SavedDC: hdc;
begin
  SavedDC := 0;
  if MenuPresent and (Form.Menu.FindItem(mi.Handle, fkHandle) <> nil) then begin
    mi.OnAdvancedDrawItem(mi, FCommonData.FCacheBmp.Canvas, R, State);
    DC := GetWindowDC(Form.Handle);
    try
      SavedDC := SaveDC(DC);
      BitBlt(DC, R.Left, R.Top, WidthOf(R), HeightOf(R), FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
    finally
      RestoreDC(DC, SavedDC);
      ReleaseDC(Form.Handle, DC);
    end;
  end;
end;
{$ENDIF}


function TsSkinProvider.SmallButtonWidth: integer;
begin
  with FCommonData.SkinManager, SkinData.CommonSkinData do
    if IsValidImgIndex(TitleGlyphs[tgSmallClose]) then
      Result := ma[TitleGlyphs[tgSmallClose]].Width
    else
      Result := 16;
end;


function TsSkinProvider.SmallButtonHeight: integer;
begin
  with FCommonData.SkinManager, SkinData.CommonSkinData do
    if IsValidImgIndex(TitleGlyphs[tgSmallClose]) then
      Result := ma[TitleGlyphs[tgSmallClose]].Height
    else
      Result := 16;
end;


function TsSkinProvider.HaveSysMenu: boolean;
begin
  Result := biSystemMenu in Form.BorderIcons
end;


function TsSkinProvider.HeaderHeight: integer;
var
  i1, i2: integer;
begin
  if BorderForm <> nil then
    Result := CaptionHeight + SysBorderHeight(Form.Handle, BorderForm, False)
  else
    if CaptionHeight(BorderForm = nil) = 0 then
      Result := GetWindowHeight(Form.Handle) - GetClientHeight(Form.Handle) - integer(GetWindowLong(Form.Handle, GWL_STYLE) and WS_BORDER <> 0) * BorderHeight
    else begin
      i1 := GetWindowHeight(Form.Handle);
      i2 := GetClientHeight(Form.Handle);
      Result := i1 - i2 - BorderHeight;
//      if WinMajorVer >= 10 then
//        inc(Result, BorderHeight);
    end;

  if Result < 0 then
    Result := 0;

  if IsIconic(Form.Handle) then
    inc(Result, SysBorderHeight(Form.Handle, BorderForm, False));

  if SkinData.Skinned and Assigned(ListSW) and Assigned(ListSW.sBarHorz) and ListSW.sBarHorz.fScrollVisible then
    dec(Result, GetScrollMetric(ListSW.sBarHorz, SM_SCROLLWIDTH));
end;


function TsSkinProvider.MDIButtonsNeeded: boolean;
begin
  with Form do
    Result := (ChildProvider <> nil) and
              (FormStyle = fsMDIForm) and
              Assigned(ActiveMDIChild) and
              (ActiveMDIChild.WindowState = wsMaximized) and
              (Menu <> nil) and
              (biSystemMenu in ActiveMDIChild.BorderIcons);
end;


function TsSkinProvider.MenuHeight: integer;
begin
  if IsMenuVisible(Self) then
    Result := ac_GetSysMetrics(SM_CYMENU, GetWndPPI(Form.Handle)) - 1
  else
    Result := 0;
end;


type
  TAccessMenuItem = class(TMenuItem);
  TAccessMenu = class(TMainMenu);

function TsSkinProvider.UpdateMenu: boolean;
begin
  Result := False;
  if not fGlobalFlag then begin
    fGlobalFlag := True;
    if (Form.Menu <> nil) and (Form.Menu.Items.Count > 0) and (Form.Menu.Items[0] <> nil)
        {and (Form.Menu.BiDiMode = bdLeftToRight) Avoiding a Delphi bug when position of menus is wrong (when RTL)} then begin
{$IFNDEF FPC}
      TAccessMenuItem(Form.Menu.Items[0]).MenuChanged(True);
      SkinData.BeginUpdate;
      TAccessMenu(Form.Menu).AdjustBiDiBehavior;
      SkinData.EndUpdate;
{$ENDIF}
      Result := True;
    end;
    fGlobalFlag := False;
  end;
end;


procedure TsSkinProvider.UpdateNCArea(Skinned: boolean);
begin
  if not (csDesigning in ComponentState) and (SkinData.SkinManager <> nil) then
    if Skinned then begin
      CheckSysMenu(True);
      if (Form <> nil) and Form.Showing and SkinData.Skinned then begin
        SkinData.BGChanged := True;
        TryInitMenu;
        InitExBorders(SkinData.SkinManager.ExtendedBorders);
        RedrawWindow(Form.Handle, nil, 0, RDWA_FRAMENOW);
        RefreshFormScrolls(Self, ListSW, False);
      end;
    end
    else begin
      if BorderForm <> nil then
        FreeAndNil(BorderForm);
{$IFNDEF FPC}
      if DrawNonClientArea then
        SkinData.SkinManager.SkinableMenus.InitMenuLine(Form.Menu, False);
{$ENDIF}
      if uxthemeLib <> 0 then
        Ac_SetWindowTheme(Form.Handle, nil, nil);

      if ListSW <> nil then
        FreeAndNil(ListSW);

      if HaveSysMenu then
        SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_SYSMENU);

      if Form.Showing then
        SetWindowRgn(Form.Handle, 0, True);

      SkinData.BGChanged := True;
      RedrawWindow(Form.Handle, nil, 0, RDWA_ALL);
    end;
end;


function TsSkinProvider.IconVisible: boolean;
begin
  with Form do
    Result := TitleIcon.Visible and (BorderStyle in [bsSizeable, bsSingle]) and FShowAppIcon and (GetSystemMenu(Handle, False) <> 0);
end;


procedure TsSkinProvider.SetCaptionAlignment(const Value: TAlignment);
begin
  if FCaptionAlignment <> Value then begin
    FCaptionAlignment := Value;
    FCommonData.BGChanged := True;
    if Form.Visible and not (csDesigning in ComponentState) and SkinData.Skinned then
      UpdateSkinCaption(Self);
  end;
end;


procedure TsSkinProvider.SetTitleButtons(const Value: TsTitleButtons);
begin
  FTitleButtons.Assign(Value);
end;


function TsSkinProvider.RBGripPoint(const ImgIndex :integer): TPoint;
begin
  with FCommonData, CommonSkinData do
    if FCacheBmp <> nil then
      Result := Point(FCacheBmp.Width  - ma[ImgIndex].Width  - SysBorderWidth(Form.Handle, BorderForm) - ShadowSize.Right  - 1,
                      FCacheBmp.Height - ma[ImgIndex].Height - SysBorderWidth(Form.Handle, BorderForm) - ShadowSize.Bottom - 1)
    else
      Result := MkPoint;
end;


{$IFNDEF FPC}
procedure TsSkinProvider.InitMenuItems(A: boolean);
var
  i: integer;

  procedure ProcessComponent(const c: TComponent);
  var
    i: integer;
  begin
    if c <> nil then
      if c is TFrame then
        for i := 0 to c.ComponentCount - 1 do
          ProcessComponent(c.Components[i])
      else
        with FCommonData.SkinManager do
          if c is TMainMenu then begin
            SkinableMenus.InitMenuLine(TMainMenu(c), A and CanDrawNCArea);
            for i := 0 to TMainMenu(c).Items.Count - 1 do
              SkinableMenus.HookItem(TMainMenu(c).Items[i], A and SkinnedPopups);
          end
          else
            if c is TPopupMenu then
              SkinableMenus.HookPopupMenu(TPopupMenu(c), A and SkinnedPopups)
            else
              if c is TMenuItem then
                if not (TMenuItem(c).GetParentMenu is TMainMenu) then
                  SkinableMenus.HookItem(TMenuItem(c), A and SkinnedPopups)
                else
                  for i := 0 to c.ComponentCount - 1 do
                    ProcessComponent(c.Components[i]);
  end;

begin
  if (csDesigning in Form.ComponentState) or (FCommonData.SkinManager.SkinableMenus = nil) or not FCommonData.SkinManager.IsDefault {or not DrawNonClientArea }then
    Exit;

  for i := 0 to Form.ComponentCount - 1 do
    ProcessComponent(Form.Components[i]);
end;
{$ENDIF}


procedure TsSkinProvider.InitSysParams(iPPI: integer);
begin
  CYCaption := -1;
  SysCaptHeight(Self, iPPI);
  CXSizeFrame := ac_GetSysMetrics(SM_CXSIZEFRAME, iPPI);
  CXFixedFrame := ac_GetSysMetrics(SM_CXFIXEDFRAME, iPPI);
  CXPaddedBorder := ac_GetSysMetrics(SM_CXPADDEDBORDER, iPPI);
end;


function TsSkinProvider.IsBlurred: boolean;
begin
  Result := Assigned(FluentHandles) and (FluentHandles.Count > 0) and ((SkinData.TranspMode > 0) or SystemBlur.Active);
end;


procedure TsSkinProvider.StartMove(X, Y: Integer);
begin
  if (ResizeMode = rmBorder) and Form.Enabled then begin
    //Common section
    bInProcess := True;
    deskwnd    := GetDesktopWindow();
    formDC     := GetWindowDC(deskwnd);
    nDC        := SaveDC(formDC);
    ntop       := Form.Top;
    nleft      := Form.Left;
    SetROP2(formDC, R2_NOT);
    if bMode then begin // Move section
      nX := X;
      nY := Y;
      DrawFormBorder(nleft, ntop);
    end
    else
      with Form do begin // Size section
        nMinHeight := Constraints.MinHeight;
        nMinWidth  := Constraints.MinWidth;
        nbottom    := Top + Height;
        nright     := Left + Width;
        DrawFormBorder(0, 0);
      end;
  end;
end;


{$IFNDEF NOWNDANIMATION}
procedure TsSkinProvider.StartMoveForm;
begin
  if not FormActive then begin // If form activating
    FormActive := True;
    SkinData.BGChanged := True;
  end;
  if Form.CanFocus then
    SetFocus(Form.Handle);

  StartBlendOnMoving(Self);
end;
{$ENDIF}


procedure TsSkinProvider.StopMove(X, Y: Integer);
begin
  if ResizeMode = rmBorder then begin
    // Common section
    ReleaseCapture;
    bInProcess := FALSE;
    if bMode then begin // Move section
      DrawFormBorder(nleft, ntop);
      RestoreDC(formDC, nDC);
      ReleaseDC(deskwnd, formDC);
      MoveWindow(Form.handle, nleft, ntop, Form.width, Form.height, TRUE)
    end
    else begin // Size section
      DrawFormBorder(0,0);
      RestoreDC(formDC, nDC);
      ReleaseDC(deskwnd, formDC);
      if not bCapture then
        MoveWindow(Form.handle, nleft, ntop, nright - nleft, nbottom - ntop, TRUE);

      bCapture := FALSE;
    end;
  end;
end;


procedure TsSkinProvider.DrawFormBorder(X, Y: Integer);
var
  pts: array [1..5] of TPoint;
  incX, incY: integer;
  msp: TsSkinProvider;
begin
  if ResizeMode = rmBorder then begin
    if Form.FormStyle = fsMDIChild then begin
      msp := TsSkinProvider(MDISkinProvider);
      incX := msp.Form.Left + SysBorderWidth(msp.Form.Handle, msp.BorderForm) + msp.Form.BorderWidth + 1;
      incY := msp.Form.Top + SysBorderHeight(msp.Form.Handle, msp.BorderForm) * 2 + msp.CaptionHeight + msp.LinesCount * msp.MenuHeight * integer(msp.MenuPresent) + msp.Form.BorderWidth - 2;
      X := X + incX;
      Y := Y + incY;
    end
    else begin
      incX := 0;
      incY := 0;
    end;

    if bMode then begin // Move section
      pts[1] := point(X, Y);
      pts[2] := point(X, Y + Form.Height);
      pts[3] := point(X + Form.Width, Y + Form.Height);
      pts[4] := point(X + Form.Width, Y);
      pts[5] := point(X, Y);
      PolyLine(formDC, pts, 5);
    end
    else begin // Size section
      pts[1].X := nleft   + incX;
      pts[1].Y := ntop    + incY;
      pts[2].X := nleft   + incX;
      pts[2].Y := nbottom + incY;
      pts[3].X := nright  + incX;
      pts[3].Y := nbottom + incY;
      pts[4].X := nright  + incX;
      pts[4].Y := ntop    + incY;
      pts[5].X := nleft   + incX;
      pts[5].Y := ntop    + incY;
      PolyLine(formDC, pts, 5);
    end;
  end;
end;


procedure TsSkinProvider.RepaintMenu;
begin
  SkinData.BGChanged := True;
  MenuChanged := True;
  FLinesCount := -1;
  ProcessMessage(WM_NCPAINT, 0, 0);
end;


function TsSkinProvider.CaptionWidth: integer;
begin
  if IsIconic(Form.Handle) and (Application.MainForm <> Form) then
    Result := 160
  else
    Result := Form.Width + integer(BorderForm <> nil) * 2 * DiffBorder(Self.BorderForm);

  inc(Result, ShadowSize.Left + ShadowSize.Right);
end;


procedure TsSkinProvider.UpdateIconsIndexes;
begin
  BigButtons := Form.BorderStyle in [bsSingle, bsSizeable, bsDialog];
  with FCommonData.SkinManager, SkinData.CommonSkinData do
    if IsValidSkinIndex(SkinCommonInfo.IndexGlobalInfo) then begin
      ButtonMin.cpHitCode   := HTMINBUTTON;
      ButtonMax.cpHitCode   := HTMAXBUTTON;
      ButtonClose.cpHitCode := HTCLOSE;
      if BigButtons then begin
        ButtonMin.cpGlyphType := tgMin;
        ButtonMax.cpGlyphType := tgMax;
        if (SystemMenu <> nil) and (SystemMenu.VisibleMax or SystemMenu.VisibleMin) then
          ButtonClose.cpGlyphType := tgClose
        else
          ButtonClose.cpGlyphType := tgCloseAlone;

        ButtonHelp.cpGlyphType := tgHelp;
        ButtonMin.cpHaveAlignment := True;
      end
      else begin
        ButtonClose.cpGlyphType := tgSmallClose;
        ButtonMin  .cpGlyphType := tgSmallMin;
        ButtonMax  .cpGlyphType := tgSmallMax;
        ButtonHelp .cpGlyphType := tgSmallHelp;
        ButtonMin.cpHaveAlignment := False;
      end;
      ButtonMax  .cpHaveAlignment := ButtonMin.cpHaveAlignment;
      ButtonClose.cpHaveAlignment := ButtonMin.cpHaveAlignment;
      ButtonHelp .cpHaveAlignment := ButtonMin.cpHaveAlignment;

      if (Form.FormStyle = fsMDIForm) and not (csDesigning in ComponentState) then begin
        MDIMin  .cpGlyphType := tgSmallMin;
        MDIMax  .cpGlyphType := tgSmallMax;
        MDIClose.cpGlyphType := tgSmallClose;
        MDIMin  .cpHaveAlignment := False;
        MDIMax  .cpHaveAlignment := False;
        MDIClose.cpHaveAlignment := False;
      end;

      UserBtnIndex := GetMaskIndex(SkinCommonInfo.IndexGlobalInfo, s_TitleButtonMask, SkinData.CommonSkinData);
    end;
end;


function TsSkinProvider.TitleSkinSection: string;
begin
  Result := iff(FTitleSkin = '', s_FormTitle, FTitleSkin);
end;


procedure TsSkinProvider.TryInitMenu;
begin
  if not MenusInitialized and CanDrawNCArea then begin
{$IFNDEF FPC}
    if Form.Menu <> nil then
      SkinData.SkinManager.SkinableMenus.InitMenuLine(Form.Menu, CanDrawNCArea);
{$ENDIF}

    MenusInitialized := UpdateMenu;
  end;
end;


procedure TsSkinProvider.PrepareForm;
begin
  if RTInit or RTEmpty or (FCommonData.SkinManager = nil) or (Form = nil) or not Form.HandleAllocated or not FCommonData.SkinManager.IsActive then
    Exit;

{$IFNDEF FPC}
  if (Form.Menu <> nil) and Form.Menu.OwnerDraw and CanDrawNCArea then begin
    FMenuOwnerDraw := Form.Menu.OwnerDraw;
    MenusInitialized := True;
  end
  else
    FMenuOwnerDraw := False;
{$ENDIF}
  FCommonData.Loaded;
  InitIndexes;
{$IFNDEF FPC}
  if SystemMenu = nil then begin
    SystemMenu := TsSystemMenu.Create(Self);
    SystemMenu.FForm := Form;
    SystemMenu.WindowHandle := 0;
    SystemMenu.UpdateItems;
  end;
  CheckSysMenu(True);
{$ENDIF}
  if ClearButtons and FCommonData.SkinManager.IsActive then begin
    ClearButtons := False;
    if (Form.FormStyle = fsMDIForm) and not (csDesigning in ComponentState) then
      HookMDI;
  end;
  FCommonData.UpdateIndexes;
  UpdateTitleBar;
  UpdateIconsIndexes;

  if Form.FormStyle = fsMDIChild then // If form is MDIChild and menus are merged then
    if Assigned(MDISkinProvider) and
         not (csDestroying in TsSkinProvider(MDISkinProvider).ComponentState) and
           not (csDestroying in TsSkinProvider(MDISkinProvider).Form.ComponentState) and
             SkinData.Skinned then begin

      TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
      TsSkinProvider(MDISkinProvider).FLinesCount := -1;
    end;

  if ([csCreating, csReadingState] * Form.ControlState = []) and not (csLoading in ComponentState) then
    if UseGlobalColor and not SkinData.CustomColor then
      Form.Color := SkinData.SkinManager.GetGlobalColor;

  if SystemMenu <> nil then
    SystemMenu.UpdateGlyphs;

  if not (csLoading in Form.ComponentState) and Form.Showing then
    InitExBorders(SkinData.SkinManager.ExtendedBorders);

  InitIndexes;
end;


procedure TsSkinProvider.HookMDI(Active: boolean);
begin
  if Active then begin
    if not WndIsSkinned(Form.ClientHandle) and Assigned(MDIForm) then
      FreeAndNil(MDIForm);

    if not Assigned(MDIForm) then begin
      MDISkinProvider := Self;
      TsMDIForm(MDIForm) := TsMDIForm.Create(Self);
      if MDIForm <> nil then
        TsMDIForm(MDIForm).ConnectToClient;
    end;
    MDIMenuHook;
  end
  else begin
    MDIMenuUnhook;
    if Assigned(MDIForm) then
      FreeAndNil(MDIForm);
  end;
end;


function TsSkinProvider.TitleBtnsWidth: integer;
var
  i, w: integer;
begin
  with SkinData.CommonSkinData, FCommonData.SkinManager do begin
    Result := BIRightMargin;
    w := integer(BigButtons) * BISpacing;
    if Assigned(SystemMenu) and HaveSysMenu then begin
      inc(Result, SysButtonWidth(ButtonClose));
      if SystemMenu.VisibleMax then
        inc(Result, SysButtonWidth(ButtonMax) + w);

      if SystemMenu.VisibleMin then
        inc(Result, SysButtonWidth(ButtonMin) + w);

      if (biHelp in Form.BorderIcons) then
        inc(Result, SysButtonWidth(ButtonHelp) + w);
    end;
    if TitleButtons.Count > 0 then
      inc(Result, SkinData.CommonSkinData.Spacing);

    for i := 0 to TitleButtons.Count - 1 do
      inc(Result, UserButtonWidth(TitleButtons[i]) + w);
  end;
end;


function TsSkinProvider.UserButtonWidth(const Btn: TsTitleButton): integer;
begin
  if Assigned(Btn.Glyph) then
    Result := Btn.Glyph.Width + 2
  else
    Result := 0;

  with FCommonData.CommonSkinData do
    if FCommonData.SkinManager.IsValidImgIndex(UserBtnIndex) then
      Result := max(Result, ma[UserBtnIndex].Width)
    else
      Result := max(Result, 21);
end;


procedure TsSkinProvider.UWPCaptionUpdate(Zoomed: boolean);
begin
  if UWPMode then
    if Zoomed then
      SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) and not WS_CAPTION)
    else
      if (Form.BorderStyle <> bsNone) and (GetWindowLong(Form.Handle, GWL_STYLE) and WS_CAPTION = 0) then begin
        SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_CAPTION);
        UpdateRgn(Self);
      end;
end;


function TsSkinProvider.UWPClientRect: TRect;
begin
  Result := Form.ClientRect;
  OffsetRect(Result, OffsetX, OffsetY);
  if (Form.BorderStyle in [bsSizeable]) and (BorderForm = nil) then
    InflateRect(Result, iUWPBorderWidth, iUWPBorderWidth);
end;


function TsSkinProvider.UWPNoBorderMode: boolean;
begin
  Result := FUWPMode and (BorderForm = nil);
end;


procedure TsSkinProvider.AdapterCreate;
begin
  if not (csDesigning in ComponentState) and FCommonData.Skinned then begin
    Adapter := TacCtrlAdapter.Create(Self);
    if Form <> nil then
      TacCtrlAdapter(Adapter).AddAllItems(nil);
  end;
end;


{$IFDEF ACDEBUG}
procedure TsSkinProvider.SetRgnChanged(const Value: boolean);
begin
  if FRgnChanged <> Value then begin
    FRgnChanged := Value;
  end;
end;
{$ENDIF}


procedure TsSkinProvider.AdapterRemove;
begin
  if not (csDesigning in ComponentState) then begin
    SendToAdapter(MakeMessage(SM_ALPHACMD, AC_REMOVESKIN_HI, LPARAM(SkinData.SkinManager), 0));
    FreeAndNil(Adapter);
  end;
end;


procedure TsSkinProvider.SendToAdapter(Message: TMessage);
begin
  if not (csDesigning in ComponentState) and Assigned(Adapter) then
    TacCtrlAdapter(Adapter).WndProc(Message)
end;


procedure TsSkinProvider.MdiIcoFormPaint(Sender: TObject);
begin
  with TForm(Sender) do
    BitBlt(Canvas.Handle, 0, 0, 60, GetSystemMetrics(SM_CYMENU) + 3, SkinData.FCacheBmp.Canvas.Handle,
           Form.Width - 60 + SysBorderWidth(Form.Handle, BorderForm) - ShadowSize.Right, CaptionHeight + ShadowSize.Top, SRCCOPY);
end;


function PopupMenuHook(Code: Integer; WParam: WPARAM; var Msg: TMsg): LRESULT; stdcall;
var
  p: TPoint;
  exRect: TRect;
  sp: TsSkinProvider;
begin
  if (Code = MSGF_MENU) and (MDISkinProvider <> nil) then begin
    sp := TsSkinProvider(MDISkinProvider);
    if (sp.Form.Menu <> nil) and (sp.Form.ActiveMDIChild <> nil) and (sp.LastMenuItemRect.Left <> sp.LastMenuItemRect.Right) then begin
{$IFDEF LOGGED}
//      AddToLog(IntToStr(Msg.Message));
{$ENDIF}
      case Msg.Message of
        WM_LBUTTONDOWN, WM_MOUSEMOVE: begin
          p := acMousePos;
          exRect := sp.LastMenuItemRect;
          exRect.Left := sp.LastMenuItemRect.Right;
          exRect.Right := sp.Form.Left + sp.Form.Width;
          if PtInRect(exRect, p) then begin // Skip msg if not allowed in main menu bar
            Result := 1;
            Exit;
          end;
        end;
      end;
    end;
  end;
  Result := CallNextHookEx(FMDIMenuHook, Code, WParam, acUINT(@Msg));
end;


procedure TsSkinProvider.MDIMenuHook;
begin
  if (FMDIMenuHook = 0) and (Form.FormStyle = fsMDIForm) then
    FMDIMenuHook := SetWindowsHookEx(-1 + integer(FMDIMenuHook), TFNHookProc(@PopupMenuHook), 0, GetCurrentThreadID);
end;


procedure TsSkinProvider.MDIMenuUnhook;
begin
  if FMDIMenuHook <> 0 then begin
    UnhookWindowsHookEx(FMDIMenuHook);
    FMDIMenuHook := 0;
  end;
end;


procedure TsSkinProvider.SaveBGForBtns(CaptWidth: integer; Full: boolean = False);
var
  cy, sbh: integer;
begin
  with TempBmp do begin
    Width  := TitleBtnsWidth + SysBorderWidth(Form.Handle, BorderForm) + 10 + ShadowSize.Right;
    sbh := SysBorderHeight(Form.Handle, BorderForm);
    Height := CaptionHeight + sbh + SysBorderWidth(Form.Handle, BorderForm, False) + MenuHeight + ShadowSize.Top;
    cy := iff(Full, TempBmp.Height, CaptionHeight + sbh);

    Canvas.TryLock;
    try
      if SysRTLAllowed then
        BitBlt(Canvas.Handle, 0, 0, Width, cy, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY)
      else
        BitBlt(Canvas.Handle, 0, 0, Width, cy, FCommonData.FCacheBmp.Canvas.Handle, CaptWidth - Width - 1, 0, SRCCOPY);
    finally
      Canvas.Unlock;
    end;
  end;
end;


procedure TsSkinProvider.RestoreBtnsBG(CaptWidth: integer);
begin
  if Assigned(TempBmp) then
    with TempBmp do
      if SysRTLAllowed then
        BitBlt(FCommonData.FCacheBmp.Canvas.Handle, 0, 0, Width, Height, Canvas.Handle, 0, 0, SRCCOPY)
      else
        BitBlt(FCommonData.FCacheBmp.Canvas.Handle, CaptWidth - Width - 1, 0, Width, Height, Canvas.Handle, 0, 0, SRCCOPY);
end;


procedure TsSkinProvider.AC_WMEraseBkGndHandler(aDC: hdc);
var
  DC, SavedDC: hdc;
  cR: TRect;
begin
  if InAero then
    if (GetClipBox(aDC, cR) = NULLREGION) or (WidthOf(cR) = 0) or (HeightOf(cR) = 0) then
      aDC := 0; // New DC is needed

  if (aDC = 0) or (SkinData.PrintDC <> 0) and (aDC <> SkinData.PrintDC) then
    DC := GetDC(Form.Handle)
  else
    DC := aDC;

  try
    FCommonData.Updating := False;
    if not fAnimating and
         not (csDestroying in Form.ComponentState) and
           not ((Form.FormStyle = fsMDIChild) and
             (MDISkinProvider <> nil) and
               not MDICreating and
                 Assigned(TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild) and
                   (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild.WindowState = wsMaximized) and
                     (Form <> TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild)) then begin
      SavedDC := SaveDC(DC);
      ExcludeControls(DC, Form, 0, 0);
      PaintForm(DC, MkRect(Form));
      if IsGripVisible(Self) then begin
        MoveWindowOrg(DC, -OffsetX, -OffsetY);
        PaintGrip(DC, Self);
      end;
      RestoreDC(DC, SavedDC);
      PaintControls(DC, Form, True, MkPoint);

      if not SkinData.SkinManager.Effects.AllowOuterEffects then
        SetParentUpdated(Form);
    end;
  finally
    if DC <> aDC then
      ReleaseDC(Form.Handle, DC);
  end;
end;


procedure TsSkinProvider.AC_WMNCPaintHandler;
var
  i, y, th, ty, sbw, dy: integer;
  DC, SavedDC: hdc;
  bIconic: boolean;

  function UpdateCache: boolean;
  begin
    Result := True;
    if (SkinData.FCacheBmp <> nil) and (SkinData.FCacheBmp.Width = 0) then
      SkinData.BGChanged := True; // If Cache is not ready

    if FCommonData.BGChanged and not PaintAll then
      Result := False;
  end;

begin
  if not MDICreating and {CanDrawNCArea and }(LockCount <= 0) then begin // If not maximized mdi child was created
    if (ResizeMode = rmBorder) and AeroIsEnabled then
      ResizeMode := rmStandard;

    if (Form.FormStyle = fsMDIChild) and
         (MDISkinProvider <> nil) and Assigned(TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild) and
           (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild.WindowState = wsMaximized) and
             (Form <> TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild) then
        Exit;

    TryInitMenu;
    if UpdateCache then begin
      if not RgnChanging and RgnChanged then begin
        bIconic := IsIconic(Form.Handle);
        if HaveBorder(Self) or (SkinData.SkinManager.gd[SkinData.SkinIndex].BorderRadius > 0) or IsSizeBox(Form.Handle) or bIconic then begin
          if bIconic { If form is iconic but shown on taskbar only} and (GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_APPWINDOW <> 0) then
            Exit;

          if BorderForm = nil then
            FillArOR(Self);

          RgnChanged := False;
          if (fsShowing in Form.FormState) and (Form.Position <> poDefault) and (Form.WindowState <> wsMaximized) then
            UpdateRgn(Self, True, True) // Removing of std borders with repaint
          else begin
            UpdateRgn(Self, not InAnimationProcess);// and (Form.Parent <> nil));
            if not SkinData.BGChanged then
              Exit; // If not repainted
          end;
        end
        else
          SetWindowRgn(Form.Handle, 0, False);
      end;
      FCommonData.Updating := False;
      DC := GetWindowDC(Form.Handle);
      SavedDC := SaveDC(DC);
      try
        if BorderForm <> nil then begin
          i := Form.BorderWidth;
          y := CaptionHeight(False);
          sbw := SysBorderWidth(Form.Handle, BorderForm, False);

          inc(y, sbw);
          if FSysExHeight then
            dec(y, 4);

          ty := MenuHeight * LinesCount + integer(IsMenuVisible(Self)) + Form.BorderWidth;
          th := y + ty;
          dy := OffsetY - ty;

          BitBlt(DC, sbw, y,
                 FCommonData.FCacheBmp.Width - ShadowSize.Left - ShadowSize.Right,
                 ty,
                 FCommonData.FCacheBmp.Canvas.Handle, SysBorderWidth(Form.Handle, BorderForm) + ShadowSize.Left, dy, SRCCOPY); // Title and menu line update
          if i <> 0 then begin
            // Left
            BitBlt(DC, sbw, th, i, Form.Height - sbw, FCommonData.FCacheBmp.Canvas.Handle, OffsetX - Form.BorderWidth, OffsetY, SRCCOPY);
            // Bottom
            BitBlt(DC, sbw + Form.BorderWidth, Form.Height - i - sbw, Form.Width - i - sbw - Form.BorderWidth, i, FCommonData.FCacheBmp.Canvas.Handle, BorderWidth + ShadowSize.Left, FCommonData.FCacheBmp.Height - BorderWidth - ShadowSize.Bottom, SRCCOPY); // Bottom border update
            // Right
            BitBlt(DC, Form.Width - i - sbw, th, i, FCommonData.FCacheBmp.Height - sbw, FCommonData.FCacheBmp.Canvas.Handle, FCommonData.FCacheBmp.Width - BorderWidth - ShadowSize.Right, OffsetY, SRCCOPY); // Right border update
          end;
        end
        else
          if not HaveBorder(Self) and IsSizeBox(Form.Handle) and not IsIconic(Form.Handle) then begin
            i := BorderWidth + 3;
            BitBlt(DC, 0, 0, Form.Width, i, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY); // Title and menu line update
            BitBlt(DC, 0, i, i, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, i, SRCCOPY); // Left border update
            BitBlt(DC, i, Form.Height - i, Form.Width - i, i, FCommonData.FCacheBmp.Canvas.Handle, i, Form.Height - i, SRCCOPY); // Bottom border update
            BitBlt(DC, FCommonData.FCacheBmp.Width - i, i, i, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, FCommonData.FCacheBmp.Width - i, i, SRCCOPY); // Right border update
          end
          else
            PaintCaption(DC);
      finally
        RestoreDC(DC, SavedDC);
        ReleaseDC(Form.Handle, DC);
      end;
      RgnChanging := False;
    end;
  end;
end;


function TsSkinProvider.FormColor: TColor;
begin
  if FCommonData.Skinned and not SkinData.CustomColor then
    Result := FCommonData.CommonSkinData.gd[FCommonData.Skinindex].Props[integer(FormActive)].Color
  else
    Result := ColorToRGB(Form.Color);
end;


procedure TsSkinProvider.OurPaintHandler(const Msg: TWMPaint);
var
  SavedDC: hdc;
  PS: TPaintStruct;
  bOldUpdating: boolean;
begin
  if fAnimating or InAnimationProcess and (Msg.DC = 0) or (csDestroying in Form.ComponentState) then begin
    BeginPaint(Form.Handle, PS);
    EndPaint(Form.Handle, PS);
  end
  else begin
    if not InAnimationProcess then begin
//      SkinData.FUpdating := True; // Do not WM_ERASEBKGND
      BeginPaint(Form.Handle, PS);
//      SkinData.FUpdating := False;
    end;
    SavedDC := SaveDC(Form.Canvas.Handle);
    try
      Form.Canvas.TryLock;
      if FormState and FS_SIZING = 0 then begin
        bOldUpdating := FCommonData.FUpdating;
        if Form.Parent <> nil then
          FCommonData.Updating := FCommonData.Updating
        else
          FCommonData.Updating := False;

        if not FCommonData.Updating then
          if not ((Form.FormStyle = fsMDIChild) and
               (MDISkinProvider <> nil) and
                 not MDICreating and
                   Assigned(TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild) and
                     (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild.WindowState = wsMaximized) and
                       (Form <> TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild)) then
            PaintForm(Form.Canvas.Handle, PS.rcPaint, bOldUpdating or not DrawNonClientArea);
      end;
    finally
      Form.Canvas.UnLock;
      RestoreDC(Form.Canvas.Handle, SavedDC);
      Form.Canvas.Handle := 0;
      if not InAnimationProcess then
        EndPaint(Form.Handle, PS);
    end;
  end;
end;


function TsSkinProvider.UWPTemplate(bActive: boolean): TBitmap;
var
  w: integer;
begin
  if UWPTemplates[bActive] = nil then begin
    with SkinData.CommonSkinData do begin
      UWPTemplates[True] := TBitmap.Create;
      UWPTemplates[True].Assign(GetActiveShadow);
      UWPTemplates[False] := TBitmap.Create;
      UWPTemplates[False].Assign(GetPassiveShadow);
      w := WndShadowSize;
      UWPShadowSize := Rect(w, max(0, w - WndShadowOffset), w, max(0, w + WndShadowOffset));
    end;
  end;
  Result := UWPTemplates[bActive];
end;


procedure TsSkinProvider.CheckSysMenu(const Skinned: boolean);
begin
  if Skinned then
    if CanDrawNCArea then begin
      if GetWindowLong(Form.Handle, GWL_STYLE) and WS_SYSMENU <> 0 then
        SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) and not WS_SYSMENU)
    end
    else
      SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_SYSMENU)
  else
    if HaveSysMenu then begin
      SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_SYSMENU);
      // Update title icon (not updated automatically in some cases)
      Form.Perform(WM_SETICON, 0, Form.Perform(WM_GETICON, 0, 0));
    end;
end;


{$IFNDEF FPC}
procedure TsSkinProvider.AC_WMInitMenuPopup(var Message: TWMInitMenuPopup);
var
  s: acString;
  sCut: string;
  c, i: integer;
  mi: TMenuItemInfo;
  TmpItem: TMenuItem;

  function GetItemText(ID: Cardinal; var Caption: acString; var ShortCut: String; uFlag: Cardinal): boolean;
  var
    Text: array[0..MaxByte] of acChar;
  begin
    Result := {$IFDEF TNTUNICODE}GetMenuStringW{$ELSE}GetMenuString{$ENDIF}(Message.MenuPopup, ID, Text, MaxByte, uFlag) <> 0;
  end;
  
begin
  if SkinData.SkinManager.SkinnedPopups then begin
    if Message.SystemMenu then
      EnableMenuItem(Message.MenuPopup, SC_SIZE, MF_BYCOMMAND or MF_GRAYED)
    else
      acCanHookMenu := False; // Menu skinning is supported

    // Remove MDI items
    if Form.WindowMenu <> nil then begin
      i := Form.WindowMenu.Count - 1;
      while i >= 0 do begin
        if Form.WindowMenu.Items[i].Tag and $200 = $200 then
          Form.WindowMenu.Delete(i);

        dec(i);
      end;
    end;
    if (Form.FormStyle = fsMDIForm) and (Form.MDIChildCount > 0) and (Form.WindowMenu <> nil) and //then begin
      (Form.WindowMenu.Handle = Message.MenuPopup) then begin
        for i := 0 to Form.WindowMenu.Count - 1 do
          Form.WindowMenu.Items[i].InitiateAction;
        // Clear old items
        c := GetMenuItemCount(Message.MenuPopup);
        i := c;
        while i >= 0 do begin
          if GetItemText(i, s, sCut, MF_BYPOSITION) then begin
            RemoveMenu(Message.MenuPopup, i, MF_BYPOSITION);
            dec(i);
            Continue;
          end;
          mi.cbSize := SizeOf(mi);
          mi.fMask := MIIM_STATE or MIIM_DATA or MIIM_FTYPE;
          if GetMenuItemInfo(Message.MenuPopup, i, True, mi) then
            if (mi.dwItemData = 0) and (mi.fType and MF_SEPARATOR <> 0) then
              RemoveMenu(Message.MenuPopup, i, MF_BYPOSITION);

          dec(i);
        end;
        if Form.WindowMenu.Items[Form.WindowMenu.Count - 1].Caption <> CharMinus then begin
          TmpItem := TMenuItem.Create(Self);
          TmpItem.Caption := CharMinus;
          Form.WindowMenu.Add(TmpItem);
        end;
        for i := 0 to Form.MDIChildCount - 1 do
          if Form.MDIChildren[i].Visible then begin
            TmpItem := TMenuItem.Create(Self);
            TmpItem.Caption := Form.MDIChildren[i].Caption;
            TmpItem.OnClick := OnChildMnuClick;
            TmpItem.Tag := i;
            if Form.MDIChildren[i] = Form.ActiveMDIChild then
              TmpItem.Checked := True;

            TmpItem.Tag := TmpItem.Tag or $200;
            Form.WindowMenu.Add(TmpItem);
          end;

        Message.Result := 0;
      end
    else
      OldWndProc(TMessage(Message));
  end;
end;
{$ENDIF}


procedure TsSkinProvider.InitExBorders(const Active: boolean);
begin
  if Active and HaveBorder(Self) and
       CanDrawNCArea and
         (Form.Parent = nil) and
           (Form.FormStyle <> fsMDIChild) and
             FAllowExtBorders and
               not ((Form.WindowState = wsMaximized) and
                 SkinData.SkinManager.Options.NativeBordersMaximized) and Form.Showing then begin
    if BorderForm = nil then begin
      BorderForm := TacBorderForm.Create(Self);
      BorderForm.SkinData := FCommonData;
    end;
    FCommonData.BGChanged := True;
    BorderForm.UpdateExBordersPos;
  end
  else
    if BorderForm <> nil then
      FreeAndNil(BorderForm);
end;


procedure TsSkinProvider.AC_WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
var
  R: TRect;
  sbwf, addY: integer;
begin
  if CanDrawNCArea and (Form.BorderStyle <> bsNone) and (Form.FormStyle <> fsMDIChild) and (Form.Parent = nil) then begin
    R := acWorkRect(Form);
    sbwf := SysBorderWidth(Form.Handle, nil, False); // Standard border width
    if UWPMode then
      if (BorderForm <> nil) and not ((Form.WindowState = wsMaximized) and not ExtBordersNeeded(Self)) and not
            ((FormState and FS_ZOOMING <> 0) and SkinData.SkinManager.Options.NativeBordersMaximized) then
        if GetWindowLong(Form.Handle, GWL_STYLE) and WS_CAPTION <> 0 then begin // If for caption is visible
          FSysExHeight := (FormState and FS_ZOOMING <> 0) {IsZoomed(Form.Handle)} and (ActualTitleHeight(True) > (SysCaptHeight(Self) + 4));
          addY := MaxBtnOffset(Self, True);
        end
        else
          addY := 0
      else
        addY := -0
    else begin
      if (BorderForm <> nil) and not ((Form.WindowState = wsMaximized) and not ExtBordersNeeded(Self)) and not
            ((FormState and FS_ZOOMING <> 0) and SkinData.SkinManager.Options.NativeBordersMaximized) then
        if GetWindowLong(Form.Handle, GWL_STYLE) and WS_CAPTION <> 0 then begin // If for caption is visible
          FSysExHeight := (FormState and FS_ZOOMING <> 0) {IsZoomed(Form.Handle)} and (ActualTitleHeight(True) > (SysCaptHeight(Self) + 4));
          addY := MaxBtnOffset(Self, True);
        end
        else
          addY := 0
      else
        addY := 0;
    end;

    with Message.MinMaxInfo^ do begin
      Message.MinMaxInfo^.ptMaxPosition.Y := -sbwf + addY;
      Message.MinMaxInfo^.ptMaxPosition.X := -sbwf;
      sbwf := sbwf * 2;                                                        
      Message.MinMaxInfo^.ptMaxSize.X := WidthOf(R) + sbwf;                    
      Message.MinMaxInfo^.ptMaxSize.Y := HeightOf(R) + sbwf - addY;            
    end;
    Message.Result := 0;
  end;
  OldWndProc(TMessage(Message));
end;


function TsSkinProvider.ShadowSize: TRect;
begin
  if BorderForm <> nil then
    if UWPMode then begin
      if UWPTemplates[True] = nil then
        BorderForm.ShadowTemplate := UWPTemplate(FormActive);

      Result := UWPShadowSize
    end
    else
      Result := SkinData.CommonSkinData.FormShadowSize
  else
    Result := MkRect;
end;


function TsSkinProvider.SizeFrame: integer;
begin
  CXSizeFrame := ac_GetSysMetrics(SM_CXSIZEFRAME, GetControlPPI(Form));
  Result := CXSizeFrame;
end;


procedure TsSkinProvider.KillAnimations;
var
  i: integer;
begin
  if ButtonMin.cpTimer <> nil then
    FreeAndNil(ButtonMin.cpTimer);

  if ButtonMax.cpTimer <> nil then
    FreeAndNil(ButtonMax.cpTimer);

  if ButtonClose.cpTimer <> nil then
    FreeAndNil(ButtonClose.cpTimer);

  if ButtonHelp.cpTimer <> nil then
    FreeAndNil(ButtonHelp.cpTimer);

  if TitleButtons <> nil then
    for i := 0 to TitleButtons.Count - 1 do
      with TitleButtons[i] do
        if Data.cpTimer <> nil then
          FreeAndNil(Data.cpTimer);

  if not (csDestroying in ComponentState) and Assigned(FTitleBar) then
    with FTitleBar do
      for i := 0 to Items.Count - 1 do
        if Items[i].Timer <> nil then
          FreeAndNil(Items[i].Timer);
end;


{$IFNDEF ALITE}
var
  bacWheelFlag: boolean = False;


function FindScrollBox(Ctrl: TWinControl; ScrPoint: TPoint): TsScrollBox;
var
  c: TControl;
begin
  c := Ctrl.ControlAtPos(Ctrl.ScreenToClient(ScrPoint), false, true);
  if c is TWinControl then
    if c is TsScrollBox then
      Result := TsScrollBox(c)
    else
      Result := FindScrollBox(TWinControl(c), ScrPoint)
  else
    Result := nil;
end;


procedure TsSkinProvider.AC_CMMouseWheel(var Message: TCMMouseWheel);
var
  sb: TsScrollBox;
begin
  OldWndProc(TMessage(Message));
  if not bacWheelFlag then begin
    bacWheelFlag := True;
    with Message do
      if Result = 0 then begin
        sb := FindScrollBox(Form, acMousePos);
        if (sb <> nil) and sb.AutoMouseWheel then
          Result := LRESULT(sb.DoMouseWheel(ShiftState, WheelDelta, SmallPointToPoint(Pos)));
      end;

    bacWheelFlag := False;
  end;
end;
{$ENDIF}


constructor TsSkinProvider.CreateRT(AOwner: TCustomForm; DoInitRT: boolean = True);
var
  i: integer;
begin
  Create(AOwner);
  RTInit := True;
  for i := 0 to Form.ComponentCount - 1 do
    if Form.Components[i] is TsTitleBar then
      FTitleBar := TsTitleBar(Form.Components[i]);
end;


procedure TsSkinProvider.LoadInit;
var
  i: integer;
begin
  if Form.HandleAllocated then
    InitDwm(Form.Handle, CanDrawNCArea);

  PrepareForm;
  if Adapter = nil then
    AdapterCreate;

  if Assigned(SystemMenu) then
    SystemMenu.UpdateItems;

  for i := 0 to TitleButtons.Count - 1 do
    with TitleButtons.Items[i] do
      if UseSkinData then
        Data.cpGlyphType := tgUser
      else
        Data.cpGlyphType := tgNone;

  if Assigned(MDIForm) then
    TsMDIForm(MDIForm).ConnectToClient;

  if Form.BorderStyle = bsSizeToolWin then begin
    AllowBlendOnMoving := False; // Not use for dock windows
    UseGlobalColor := True;
  end;
  if (SkinData.SkinManager <> nil) and SkinData.SkinManager.IsActive and Form.HandleAllocated then
  	SetClassLong(Form.Handle, GCL_HBRBACKGROUND, ACNativeInt(SkinData.SkinManager.Brushes[pcMainColor]));
end;


procedure TsSkinProvider.OnChildMnuClick(Sender: TObject);
var
  i: integer;
begin
  i := TMenuItem(Sender).Tag and not $200;
  if i < Form.MDIChildCount then
    Form.MDIChildren[i].BringToFront;
end;


procedure TsSkinProvider.AC_WMNCMouseMove(var Message: TWMNCMouseMove);
var
  M: TWMNCHitTest;
begin
  if Form.Enabled then begin
    FCommonData.SkinManager.ActiveControl := Form.Handle;
    M.Msg := WM_NCHitTest;
    M.XPos := SmallInt(Message.XCursor);
    M.YPos := SmallInt(Message.YCursor);
    M.Unused := 0;
    M.Result := 0;
    Message.HitTest := HTProcess(M);
    case Message.HitTest of
      HTCLOSE, HTMINBUTTON, HTMAXBUTTON, HTHELP, HTUDBTN..HTUDBTN + 100, HTITEM..HTITEM + 100:
        SetHotHT(Message.HitTest); // Title icon hovered

      HTCHILDCLOSE, HTCHILDMAX, HTCHILDMIN:
        SetHotHT(Message.HitTest); // MDI icon hovered

      else begin
        SetHotHT(0);
        OldWndProc(TMessage(Message));
      end;
    end;
  end;
end;


procedure TsSkinProvider.ProcessMessage(Msg: Cardinal; WPar: WPARAM = 0; LPar: LPARAM = 0);
var
  acM: TMessage;
begin
  acM := MakeMessage(Msg, WPar, LPar, 0);
  NewWndProc(acM);
end;


procedure TsSkinProvider.CalcItems;
var
  i, aIndex, FullRight, FullLeft: integer;
  Bar: TacAccessTitleBar;
  FBarRect: TRect;

  procedure ProcSysButton(var Btn: TsCaptionButton; var Index: integer; UserBtn: TsTitleButton = nil);
  var
    w: integer;
  begin
    if UserBtn = nil then
      w := SysButtonWidth(Btn)
    else
      w := UserButtonWidth(UserBtn);
    // Left/Right coords of button
    if SysRTLAllowed then begin
      Btn.cpRect.Left := FBarRect.Left;
      Btn.cpRect.Right := Btn.cpRect.Left + w;
      // New right Offset
      FBarRect.Left := Btn.cpRect.Right + integer(BigButtons) * FCommonData.CommonSkinData.BISpacing;
    end
    else begin
      Btn.cpRect.Right := FBarRect.Right;
      Btn.cpRect.Left := Btn.cpRect.Right - w;
      // New right Offset
      FBarRect.Right := Btn.cpRect.Left - integer(BigButtons) * FCommonData.CommonSkinData.BISpacing;
    end;
    if (Btn.cpHaveAlignment or (UserBtn <> nil )) {If user button or not small} and (FCommonData.SkinManager.SkinCommonInfo.BIVAlign = 1) { Top aligning } then
      Btn.cpRect.Top := FBarRect.Top
    else // va_center
      Btn.cpRect.Top := VCenter - ButtonHeight div 2;

    Btn.cpRect.Bottom := Btn.cpRect.Top + ButtonHeight;
    inc(Index);
  end;

begin
  with FCommonData.CommonSkinData do begin
    // Calc right and left coords of bar
    FullLeft := SysBorderWidth(Form.Handle, BorderForm);// + BILeftMargin + ShadowSize.Left; !!!
    FullRight := CaptionWidth - {BIRightMargin - ShadowSize.Right - }Max(4, SysBorderWidth(Form.Handle, BorderForm));
    if BorderForm <> nil then begin
      // Get top coordinate of the title bar
      FBarRect.Top := GetTopCoord;
      FHeaderHeight := CaptionHeight + ShadowSize.Top;
      // Center of header (vertical)
      VCenter := FHeaderHeight - ActualTitleHeight div 2;
      // Center of header (vertical)
      if (Form.WindowState = wsMaximized) and (ExTitleHeight <> ExMaxHeight) then
        OffsetRect(FIconRect, 0, (ExTitleHeight - ExMaxHeight) div 2 - 2)
      else
        VCenter := VCenter + ExCenterOffs;

      // Calc right and left coords of bar
      inc(FullLeft, BILeftMargin + ShadowSize.Left);
      dec(FullRight, BIRightMargin + ShadowSize.Right);
    end
    else begin
      // Center of header (vertical)
      VCenter := CaptionHeight div 2;// + fPadding div 2;
      if IsZoomed(Form.Handle) then
        if IsWin8Up and (BorderForm <> nil) then
          FBarRect.Top := SizeFrame - 1 + 4
        else
          FBarRect.Top := SizeFrame - 1
      else
        FBarRect.Top := 0;
      // Height of (Caption + Border + TopShadow)
      FHeaderHeight := CaptionHeight + SysBorderHeight(Form.Handle, BorderForm) + ShadowSize.Top;
      inc(VCenter, SysBorderWidth(Form.Handle, nil) div 2);
//      inc(FullLeft, BILeftMargin + ShadowSize.Left); !!!
//      dec(FullRight, BIRightMargin + ShadowSize.Right); !!!
    end;
    // Add offset for maximized window
    if IsZoomed(Form.Handle) then
      inc(VCenter, 2);
    // Calc Icon Rect
    if IconVisible then begin
      i := ScaleInt(TitleIconHeight(Self), SkinData);
      FIconRect.Top := VCenter - i div 2;
      FIconRect.Bottom := FIconRect.Top + i;
      i := ScaleInt(TitleIconWidth(Self), SkinData);
    end
    else
      i := 0;

    if SysRTLAllowed then begin
      FIconRect.Right := FullRight;
      FIconRect.Left := FIconRect.Right - i;

      FBarRect.Right := FIconRect.Left;
      FBarRect.Left := FullLeft;
    end
    else begin
      FIconRect.Left := FullLeft;
//      FBarRect.Left := FIconRect.Right;

      if i > 0 then begin // IconVisible
        if BorderForm <> nil then
          inc(FIconRect.Left, Spacing);

        FIconRect.Right := FIconRect.Left + i;
      end
      else
        FIconRect.Right := FIconRect.Left;

      FBarRect.Left := FIconRect.Right;
      FBarRect.Right := FullRight;
      if i <> 0 then // IconVisible
        inc(FBarRect.Left, Spacing);
    end;

    i := 1;
    // Calc sys buttons and right offset of bar
    if Assigned(SystemMenu) and HaveSysMenu then begin
      if not SysRTLAllowed then begin
        // Close button
        ProcSysButton(ButtonClose, i);
        // Max button
        if SystemMenu.VisibleMax then begin
          if Form.WindowState <> wsMaximized then
            ButtonMax.cpGlyphType := tgMax
          else
            ButtonMax.cpGlyphType := tgNormal;

          ProcSysButton(ButtonMax, i);
        end
        else
          ButtonMax.cpRect.Right := ButtonMax.cpRect.Left; // Is not shown
        // Min button
        if SystemMenu.VisibleMin then begin
          if (Form.WindowState = wsMinimized) and IsIconic(Form.Handle) and (Application.MainForm <> Form) then
            ButtonMin.cpGlyphType := tgNormal // If form is minimized then changing to Normalize
          else
            ButtonMin.cpGlyphType := tgMin;

          ProcSysButton(ButtonMin, i);
        end
        else
          ButtonMin.cpRect.Right := ButtonMin.cpRect.Left; // Is not shown
      end
      else begin
        // Close button
        ProcSysButton(ButtonClose, i);
        // Max button
        if SystemMenu.VisibleMax then begin
          if Form.WindowState <> wsMaximized then
            ButtonMax.cpGlyphType := tgMax
          else
            ButtonMax.cpGlyphType := tgNormal;

          ProcSysButton(ButtonMax, i);
        end
        else
          ButtonMax.cpRect.Right := ButtonMax.cpRect.Left; // Is not shown
        // Min button
        if SystemMenu.VisibleMin then begin
          if (Form.WindowState = wsMinimized) and IsIconic(Form.Handle) and (Application.MainForm <> Form) then
            ButtonMin.cpGlyphType := tgNormal // If form is minimized then changing to Normalize
          else
            ButtonMin.cpGlyphType := tgMin;

          ProcSysButton(ButtonMin, i);
        end
        else
          ButtonMin.cpRect.Right := ButtonMin.cpRect.Left; // Is not shown
      end;
      // Help button
      if biHelp in Form.BorderIcons then begin
        // Spacing between help button and others
        if SysRTLAllowed then
          inc(FBarRect.Left, SkinData.CommonSkinData.Spacing)
        else
          dec(FBarRect.Right, SkinData.CommonSkinData.Spacing);

        ProcSysButton(ButtonHelp, i);
      end
      else
        ButtonHelp.cpRect.Right := ButtonHelp.cpRect.Left; // Is not shown
    end
    else
      ButtonClose.cpRect.Right := ButtonClose.cpRect.Left; // Is not shown

    if TitleButtons.Count > 0 then begin
      // Spacing between old user buttons and others
      if SysRTLAllowed then
        FBarRect.Left := FBarRect.Left + SkinData.CommonSkinData.Spacing
      else
        FBarRect.Right := FBarRect.Right - SkinData.CommonSkinData.Spacing;

      aIndex := 0;
      for i := 0 to TitleButtons.Count - 1 do
        with TitleButtons.Items[i] do
          if Visible then begin
            Data.cpRect.Right := FBarRect.Right;
            if UseSkinData then
              Data.cpGlyphType := tgUser
            else
              Data.cpGlyphType := tgNone;

            ProcSysButton(Data, aIndex, TitleButtons.Items[i]);
                          Data.cpHitCode := HTUDBTN + i;
          end;
    end;
    // Init the TacTitleBar component if defined
    if Assigned(FTitleBar) then begin
      if not FTitleBar.Initialized then
        FTitleBar.UpdateSizes;//(True);

      Bar := TacAccessTitleBar(FTitleBar);
      Bar.FFullRight := FBarRect.Right;
      Bar.FBarRect.Left := FBarRect.Left;
      Bar.FBarRect.Right := FBarRect.Right;
      if SysRTLAllowed then begin
        if FIconRect.Right > FIconRect.Left then
          for i := 0 to Bar.Items.Count - 1 do
            if Bar.Items[i].Visible and (Bar.Items[i].Align = tbaLeft) then begin
              inc(Bar.FBarRect.Left, SkinData.CommonSkinData.Spacing);
              Break;
            end;

        inc(Bar.FBarRect.Left, SkinData.CommonSkinData.Spacing); // Spacing between sys buttons and others
      end
      else
        dec(Bar.FBarRect.Right, SkinData.CommonSkinData.Spacing); // Spacing between sys buttons and others

      Bar.FBarRect.Top := GetTopCoord;
      Bar.FBarRect.Bottom := FHeaderHeight;
      Bar.FBarVCenter := VCenter;
      FBarRect := Bar.FBarRect;
      FTitleBar.CalcSizes;
    end;
  end;
end;


function TsSkinProvider.CanDrawNCArea: boolean;
begin
  Result := FDrawNonClientArea and (SkinData.SkinManager <> nil) and SkinData.SkinManager.Options.DrawNonClientArea;
end;


procedure TsSkinProvider.PaintTitleItem(Item: TacTitleBarItem; R: TRect; Bmp: TBitmap);
var
  ts: TSize;
  s: ACstring;
  gColor: TColor;
  sd: TacSkinData;
  Flags: Cardinal;
  GlyphSize: TSize;
  sMan: TsSkinManager;
  isd: PacItemSkinData;
  TmpBmp, DstBmp: TBitmap;
  idd: TacTitleItemDrawData;
  bR, rArrow, rGlyph, rText, rC: TRect;
  bIndexValid, BlendItem, ParentFont: boolean;
  TxtNdx, i, h, n, sIndex, gSize, iState: integer;

  procedure PaintContent(R: TRect);
  var
    iHeight, iPPI, ArrSize, aSize, cSize, ImgNdx: integer;
    C: TColor;
  begin
    if Item.Caption <> '' then begin
      s := Item.Caption;
      ts := GetStringSize(DstBmp.Canvas.Font.Handle, s, 0, False, MaxInt, fsItalic in Item.FontData.UsedFont.Style);
    end
    else
      ts := MkSize;

    if (Item.Style in [bsMenu, bsButton]) and (Item.DropDownMenu <> nil) then begin
      ArrSize := sd.ArrowSize * 2;
      aSize := ArrSize + sd.Spacing;
    end
    else begin
      ArrSize := 0;
      aSize := 0;
    end;

    C := clNone;
    if not Item.Enabled or not Form.Enabled then
      ImgNdx := Item.DisabledImageIndex
    else
      case Item.State of
        0: begin
          ImgNdx := Item.ImageIndex;
          if SkinData.SkinManager.Effects.DiscoloredGlyphs then
            if bIndexValid then
              C := sd.gd[sIndex].Props[0].Color
            else
              C := iff(FTitleSkinIndex >= 0, sd.gd[FTitleSkinIndex].Props[0].Color, $FFFFFF);
        end;

        1:
          ImgNdx := Item.HotImageIndex

        else
          ImgNdx := Item.PressedImageIndex;
      end;

    if ImgNdx < 0 then
      ImgNdx := Item.ImageIndex;

    iPPI := sd.PPI;
    if Item.StretchImage then
      GlyphSize := MkSize(
              (MulDiv(Item.Width - 2 * (FTitleBar.ItemsMargin + Item.IntXMargin), iPPI, 96)),
              (MulDiv(Item.Height - 2 * (FTitleBar.ItemsMargin + Item.IntXMargin), iPPI, 96)))
    else
      if Assigned(FTitleBar.Images) and IsValidIndex(ImgNdx, GetImageCount(FTitleBar.Images)) then
        GlyphSize := MkSize(GetImageWidth(FTitleBar.Images, ImgNdx, iPPI), GetImageHeight(FTitleBar.Images, ImgNdx, iPPI))
      else
        if Assigned(Item.Glyph) and not Item.Glyph.Empty then
          GlyphSize := MkSize(MulDiv(Item.Glyph.Width, iPPI, 96), MulDiv(Item.Glyph.Height, iPPI, 96))
        else
          GlyphSize := MkSize;

    case Item.Alignment of
      taLeftJustify:
        rGlyph.Left := R.Left + MulDiv((FTitleBar.ItemsMargin + Item.IntXMargin), iPPI, 96);

      taCenter: begin
        if Assigned(FTitleBar.Images) and IsValidIndex(ImgNdx, GetImageCount(FTitleBar.Images)) then
          cSize := GlyphSize.cx
        else
          if Assigned(Item.Glyph) and not Item.Glyph.Empty then
            cSize := Item.Glyph.Width
          else
            cSize := 0;

        if (cSize > 0) and (ts.cx > 0) then
          inc(cSize, MulDiv(Item.Spacing, iPPI, 96));

        rGlyph.Left := max(R.Left, R.Left + (WidthOf(R) - cSize - ts.cx - aSize) div 2);
      end;

      taRightJustify: begin
        if Assigned(FTitleBar.Images) and IsValidIndex(ImgNdx, GetImageCount(FTitleBar.Images)) then
          cSize := GlyphSize.cx + integer(ts.cx > 0) * MulDiv(Item.Spacing, iPPI, 96)
        else
          if Assigned(Item.Glyph) and not Item.Glyph.Empty then
            cSize := Item.Glyph.Width + integer(ts.cx > 0) * MulDiv(Item.Spacing, iPPI, 96)
          else
            cSize := 0;

        rGlyph.Left := R.Left + (MulDiv(Item.Width, iPPI, 96) - cSize - ts.cx - ArrSize - MulDiv(sd.Spacing * 2, iPPI, 96));
      end;
    end;

    ParentFont := False;
    if (iState = 0) and bIndexValid and Item.FontData.UseSysColor then
      if (sd.gd[sIndex].BorderIndex < 0) and (sd.gd[sIndex].Props[iState].Transparency > 50) and
           (SkinData.SkinManager.SkinCommonInfo.Sections[ssFormTitle] >= 0) then begin
        ParentFont := True;
        DstBmp.Canvas.Font.Color := sd.gd[SkinData.SkinManager.SkinCommonInfo.Sections[ssFormTitle]].Props[integer(FormActive)].FontColor.Color;
      end;

    // Glyph rect
    if not Item.AutoSize {and not Item.StretchImage {and VCL} then
      iHeight := MulDiv(Item.Height, iPPI, 96)
    else
      iHeight := Item.Height;

    rGlyph.Top := R.Top + (iHeight - GlyphSize.cy) div 2;
    rGlyph.Bottom := rGlyph.Top + GlyphSize.cy;
    rGlyph.Right := rGlyph.Left + GlyphSize.cx;

    // Text rect
    rText.Left := rGlyph.Right;
    if (GlyphSize.cx <> 0) and (Item.Caption <> '') then
      inc(rText.Left, Item.Spacing * (1 + integer(Item.Style = bsTab)) * iPPI div 96);

    Flags := DT_NOCLIP;
    if Item.Caption <> '' then begin
      Flags := Flags or DT_SINGLELINE or DT_END_ELLIPSIS or DT_TOP;
      rText.Top := R.Top + (iHeight - ts.cy) div 2;
      rText.Bottom := rText.Top + ts.cy;
      rText.Right := min(rText.Left + ts.cx, R.Right);
    end
    else
      rText.Right := rText.Left;

    // Arrow rect
    if ArrSize <> 0 then begin
      rArrow.Left := rText.Right;
      if (rText.Right <> rText.Left) or (rGlyph.Right <> rGlyph.Left) then
        inc(rArrow.Left, sd.Spacing);

      rArrow.Top := R.Top;
      rArrow.Bottom := R.Bottom;
      rArrow.Right := rArrow.Left + ArrSize;
    end
    else
      rArrow.Right := rArrow.Left;

    if Form.BidiMode = bdRightToLeft then begin
      ReflectRect(rGlyph, R, True);
      ReflectRect(rArrow, R, True);
      ReflectRect(rText,  R, True);
      Flags := Flags or DT_RIGHT or DT_RTLREADING;
    end;
    // Draw glyph
    if Assigned(FTitleBar.Images) and IsValidIndex(ImgNdx, GetImageCount(FTitleBar.Images)) then begin
      SetImagesPPI(FTitleBar.Images, iPPI);
      if (FTitleBar.Images is TacImageList) or (FTitleBar.Images is TsVirtualImageList) then
        DrawAlphaImgList(FTitleBar.Images, DstBmp, rGlyph.Left, rGlyph.Top, ImgNdx, 0, C, iState, 1, False, GetPPI(SkinData))
      else
        FTitleBar.Images.Draw(DstBmp.Canvas, rGlyph.Left, rGlyph.Top, ImgNdx);
    end
    else
      if Assigned(Item.Glyph) and not Item.Glyph.Empty then begin
        Item.Glyph.Transparent := True;
        Item.Glyph.TransparentColor := Item.Glyph.Canvas.Pixels[0, 0];
        if Item.Glyph.PixelFormat <> pf32bit then begin
          Item.Glyph.PixelFormat := pf32bit;
          FillAlphaRect(Item.Glyph, MkRect(Item.Glyph), MaxByte);
        end;
        if Item.Glyph.PixelFormat = pf32bit then
          if (iPPI = 96) and not Item.StretchImage then
            CopyBmp32(rGlyph, MkRect(Item.Glyph), DstBmp, Item.Glyph, EmptyCI, False, C, 0, False)
          else
            StretchBmpRect32(DstBmp, rGlyph.Left, rGlyph.Top, GlyphSize.cx, GlyphSize.cy, Item.Glyph, 0, 0, Item.Glyph.Width, Item.Glyph.Height);
      end;

    // Draw text
    if Item.Caption <> '' then begin
      if gSize <> 0 then
        acDrawGlowForText(DstBmp, PacChar(s), rText, Flags, BF_RECT, gSize, gColor, Item.FontData.GlowMask);

      DstBmp.Canvas.Brush.Style := bsClear;
      TxtNdx := iff(not ParentFont and Item.FontData.UseSysColor, sIndex, -1);
      WriteText32(DstBmp, PacChar(s), Form.Enabled, rText, Flags, TxtNdx, iState, FCommonData.SkinManager);
    end
    else
      rText.Right := rText.Left;

    // Draw arrow
    if ArrSize <> 0 then
      if ParentFont then
        DrawArrow(DstBmp, sd.gd[SkinData.SkinManager.SkinCommonInfo.Sections[ssFormTitle]].Props[integer(FormActive)].FontColor.Color, clNone, rArrow, asBottom, 0, 0, 0, SkinData.SkinManager.Options.ActualArrowStyle, GetPPI(SkinData))
      else
        if Item.FontData.UseSysColor and bIndexValid then
          DrawArrow(DstBmp, sd.gd[sIndex].Props[iState].FontColor.Color, clNone, rArrow, asBottom, 0, 0, 0, SkinData.SkinManager.Options.ActualArrowStyle, GetPPI(SkinData))
        else
          DrawArrow(DstBmp, DstBmp.Canvas.Font.Color, clNone, rArrow, asBottom, 0, 0, 0, SkinData.SkinManager.Options.ActualArrowStyle, GetPPI(SkinData))
  end;

  procedure PaintItemSection(sIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer;
                             R: TRect; pP: TPoint; ItemBmp: TBitmap);
  var
    LayeredWndMode: boolean;
    DrawState: integer;
  begin
    with sd do
      if FOwner.IsValidSkinIndex(sIndex) then begin
        LayeredWndMode := True;
        DrawState := min(min(State, gd[sIndex].States), ac_MaxPropsIndex);
        if gd[sIndex].Props[DrawState].Transparency = 100 then
          if gd[sIndex].BorderIndex < 0 then
            LayeredWndMode := False
          else
            if State = 0 then
              LayeredWndMode := ma[gd[sIndex].BorderIndex].DrawMode and BDM_ACTIVEONLY = 0;

        if not LayeredWndMode then
          PaintItem(sIndex, ci, Filling, State, R, pP, ItemBmp.Canvas.Handle, sd)
        else
          PaintItem32(sIndex, Filling, State, R, pP, ItemBmp, sd);
      end;
  end;

begin
  ResetLastError;
  h := HeightOf(R);
  bR := R;
  sMan := SkinData.SkinManager;
  if Item.Data <> nil then begin
    isd := PacItemSkinData(Item.Data);
    sIndex := isd^.SkinIndex;
    bIndexValid := sMan.IsValidSkinIndex(sIndex);
    sd := SkinData.CommonSkinData;
    BlendItem := not Item.Enabled or not Form.Enabled;
    if Item.Style = bsMenu then
      if not FormActive and (Item.State = 0) then
        BlendItem := True;

    if not BlendItem then
      DstBmp := Bmp
    else begin
      DstBmp := CreateBmp32;
      DstBmp.Assign(Bmp); // Copy an image for disabled (semitransparent Btn drawing)
    end;

    if Item.ContentSize.cx = 0 then
      Item.UpdateSize(not Item.AutoSize);

    DstBmp.Canvas.Font.Assign(Item.FontData.UsedFont);
    if bIndexValid then
      iState := min(Item.State, min(sd.gd[sIndex].States - 1, ac_MaxPropsIndex))
    else
      iState := 0;

    if not Item.FontData.UseSysColor then
      DstBmp.Canvas.Font.Color := Item.FontData.Font.Color
    else
      if bIndexValid then
        DstBmp.Canvas.Font.Color := sd.gd[sIndex].Props[iState].FontColor.Color;

    if not Item.FontData.UseSysFontName then
      DstBmp.Canvas.Font.Name := Item.FontData.Font.Name;

    if not Item.FontData.UseSysGlowing then begin
      gSize  := Item.FontData.GlowSize;
      gColor := Item.FontData.GlowColor;
    end
    else
      if bIndexValid then begin
        gSize := min(48, sd.gd[sIndex].Props[iState].GlowSize);
        gColor := sd.gd[sIndex].Props[iState].GlowColor;
      end
      else begin
        gSize  := 0;
        gColor := 0;
      end;

    if not Item.FontData.UseSysSize then
      DstBmp.Canvas.Font.Height := Item.FontData.UsedFont.Height;

    if not Item.FontData.UseSysStyle then
      DstBmp.Canvas.Font.Style := Item.FontData.Font.Style;

    if ac_UseSysCharSet then
      DstBmp.Canvas.Font.Charset := GetDefFontCharSet
    else
      DstBmp.Canvas.Font.Charset := Form.Font.Charset;

    // Clear bmp for a layered window
    if FCommonData.FCacheBmp <> Bmp then
      FillRect32(DstBmp, bR, 0, 0);

    case Item.Style of
      bsMenu: begin
        if not bIndexValid then begin
          n := HeightOf(FTitleBar.BarRect) - 2;
          if h > n then begin
            h := n;
            bR.Bottom := bR.Top + h;
          end;
          TmpBmp := FTitleBar.FDefaultMenuBtn;
          rC.Left := Item.State * (TmpBmp.Width div 3);
          rC.Top := 0;
          rC.Right := rC.Left + (TmpBmp.Width div 3);
          rC.Bottom := TmpBmp.Height;
          PaintItemNoAlpha(DstBmp, FTitleBar.FDefaultMenuBtn, bR, rC, Rect(8, 2, 8, 4));
          // Init default font props
          if Item.FontData.UseSysColor then
            DstBmp.Canvas.Font.Color := clWhite;

          if Item.FontData.UseSysGlowing then begin
            gSize := 2;
            gColor := $000E5A8D;
          end;
        end
        else // Section is defined in a skin
          PaintItemSection(sIndex, MakeCacheInfo(SkinData.FCacheBmp), True, Item.State, bR, Item.Rect.TopLeft, DstBmp);
      end;

      bsTab: begin
        n := HeightOf(FTitleBar.BarRect) - 2;
        if h > n then begin
          h := n;
          bR.Top := bR.Bottom - h;
        end;
        if bIndexValid then begin
          if not Item.Down then begin
            InflateRect(bR, 0, -1);
            OffsetRect(bR, 0, 1);
          end;
          PaintItemSection(sIndex, MakeCacheInfo(Bmp), True, Item.State, bR, bR.TopLeft, DstBmp);
          if Item.FontData.UseSysGlowing then begin
            i := mini(iState, ac_MaxPropsIndex);
            gSize  := sd.gd[sIndex].Props[i].GlowSize;
            gColor := sd.gd[sIndex].Props[i].GlowColor;
          end
        end;
      end;

      bsInfo, bsButton: begin
        PaintItemSection(sIndex, MakeCacheInfo(Bmp), True, Item.State, bR, bR.TopLeft, DstBmp);
        // Init default font props
        if (Item.SkinSection = '') and (Item.State = 0) then begin // Get font color from title if button is not active
          iState := integer(FormActive);
          if Item.FontData.UseSysColor and IsValidIndex(FTitleSkinIndex, Length(sd.gd)) then
            DstBmp.Canvas.Font.Color := sd.gd[FTitleSkinIndex].Props[iState].FontColor.Color
          else
            DstBmp.Canvas.Font.Color := Item.FontData.Font.Color;

          if Item.FontData.UseSysGlowing and IsValidIndex(FTitleSkinIndex, Length(sd.gd)) then begin
            gSize  := sd.gd[FTitleSkinIndex].Props[iState].GlowSize;
            gColor := sd.gd[FTitleSkinIndex].Props[iState].GlowColor;
          end
          else begin
            gSize  := 0;
            gColor := 0;
          end;
          sIndex := FTitleSkinIndex;
        end;
      end

      else
        iState := integer(FormActive);
    end;
    PaintContent(bR);
    if Assigned(Item.OnDrawItem) then begin
      idd.ARect := R;
      idd.Bmp := Bmp;
      Item.OnDrawItem(Item, idd);
    end;
    if BlendItem then begin
      SumBmpRect(Bmp, DstBmp, 127, R, R.TopLeft);
      DstBmp.Free;
    end;
  end;
  CheckLastError;
end;


procedure TsSkinProvider.UpdateTitleBar;
var
  i: integer;
  isd: PacItemSkinData;
  Defined: boolean;

  procedure UpdateItemIndex(i: integer);
  begin
    Defined := False;
    isd := PacItemSkinData(FTitleBar.Items[i].Data);
    isd^.SkinIndex := -1;
    // If custom skin section is defined
    if FTitleBar.Items[i].SkinSection <> '' then begin
      isd^.SkinIndex := SkinData.SkinManager.GetSkinIndex(FTitleBar.Items[i].SkinSection);
      if isd^.SkinIndex >= 0 then
        Defined := True;
    end;
    // Search default skin section
    if not Defined then
      case FTitleBar.Items[i].Style of
        bsButton: isd^.SkinIndex := SkinData.SkinManager.SkinCommonInfo.Sections[ssTBBTN];
        bsMenu:   isd^.SkinIndex := SkinData.SkinManager.SkinCommonInfo.Sections[ssTBMENUBTN];
        bsTab:    isd^.SkinIndex := SkinData.SkinManager.SkinCommonInfo.Sections[ssTBTAB];
      end;
  end;

begin
  if Assigned(FTitleBar) then begin
    FTitleBar.SP := Self;
    for i := 0 to FTitleBar.Items.Count - 1 do begin
      if FTitleBar.Items[i].Data = nil then begin
        isd := new(PacItemSkinData);
        isd^ := TacItemSkinData.Create;
        FTitleBar.Items[i].Data := @(TObject(isd^));
      end;
      UpdateItemIndex(i);
      FTitleBar.Items[i].OnInternalDraw := PaintTitleItem;
    end;
  end;
end;


procedure TsSkinProvider.UpdateUWPMode;
begin
  SkinData.BGChanged := True;
  if BorderForm <> nil then
    BorderForm.UpdateExBordersPos
  else begin
    UpdateRgn(Self);
    RedrawWindow(Form.Handle, nil, 0, RDWA_ALLNOW);
  end;
end;


var
  ac_SetWindowCompositionAttribute: function(Wnd: HWND; const AttrData: TacWinCompAttrData): BOOL; stdcall = nil;


function TsSkinProvider.GetTopCoord: integer;
begin
  if BorderForm <> nil then
    with FCommonData.CommonSkinData do
      if IsZoomed(Form.Handle) then
        Result := ShadowSize.Top + 4
      else
        Result := ShadowSize.Top + BITopMargin
  else
    Result := integer(IsZoomed(Form.Handle)) * 6;
end;


function TsSkinProvider.ActualTitleHeight(Max: boolean = False): integer;
begin
  with FCommonData.SkinManager, SkinData.CommonSkinData do
    Result := iff(Max or (ExMaxHeight <> 0) and IsZoomed(Form.Handle), ExMaxHeight, ExTitleHeight);
end;


procedure TsSkinProvider.SetTitleBar(const Value: TsTitleBar);
begin
  if FTitleBar <> Value then begin
    FTitleBar := Value;
    UpdateSkinCaption(Self);
  end;
end;


procedure TsSkinProvider.InitLabel(const Control: TControl; const Skinned: boolean);
var
  Ndx, FoundNdx, l: integer;
begin
  if Control is TCustomLabel then
    with TLabel(Control) do begin
      FoundNdx := -1;
      l := Length(SavedLabelColors);
      for Ndx := 0 to l - 1 do
        if SavedLabelColors[Ndx].Control = Control then begin
          FoundNdx := Ndx;
          Break;
        end;

      if Skinned then begin
        if Tag and ExceptTag <> ExceptTag then begin
          if FoundNdx < 0 then begin
            SetLength(SavedLabelColors, l + 1);
            SavedLabelColors[l].Control := Control;
            SavedLabelColors[l].Color := TLabel(Control).Font.Color;
            SavedLabelColors[l].ParentFont := ParentFont;
          end;
          if Transparent or SkinData.SkinManager.LabelsOptions.TransparentAlways then
            ControlStyle := ControlStyle - [csOpaque];
          // Otherwise, just change a color when skin is changed
          Font.Color := GetFontColor(Control.Parent, -1,SkinData.SkinManager);
//          Font.Color := DefaultManager.GetGlobalFontColor;
        end;
      end
      else begin
        // If control was found in the array
        if FoundNdx >= 0 then begin
          if SavedLabelColors[FoundNdx].ParentFont then begin
            if not ParentFont then
              ParentFont := True
            else
              if Parent <> nil then
                Font.Color := TacAccessControl(Parent).Font.Color;
          end
          else
            Font.Color := SavedLabelColors[FoundNdx].Color;
          // Remove array item
          SavedLabelColors[FoundNdx].Color   := SavedLabelColors[l - 1].Color;
          SavedLabelColors[FoundNdx].Control := SavedLabelColors[l - 1].Control;
          SetLength(SavedLabelColors, l - 1);
        end;
        if Transparent or SkinData.SkinManager.LabelsOptions.TransparentAlways then
          ControlStyle := ControlStyle + [csOpaque];
      end;
    end;
end;


procedure RepaintHeadCtrl(Ctrl: TControl; Data: integer);
begin
  if Ctrl is TWinControl then begin
    if not (csDestroying in Ctrl.ComponentState) and TWinControl(Ctrl).HandleAllocated then begin
      TrySendMessage(TWinControl(Ctrl).Handle, SM_ALPHACMD, AC_UPDATING_HI + 1, 0);
      TrySendMessage(TWinControl(Ctrl).Handle, SM_ALPHACMD, AC_SETBGCHANGED_HI + 1, 0);
    end;
  end
  else begin
    Ctrl.Perform(SM_ALPHACMD, AC_UPDATING_HI + 1, 0);
    Ctrl.Perform(SM_ALPHACMD, AC_SETBGCHANGED_HI + 1, 0);
  end;
end;


procedure TsSkinProvider.AC_WMNCActivate(var Message: TWMNCActivate);
var
  R: TRect;
  DoUpdate: boolean;

{$IFNDEF ALITE}
  function CheckPopupForms: boolean;
  var
    i: integer;
  begin
    Result := False;
    with GetIntController do
      if (GetIntController <> nil) then
        for i := 0 to Length(FormHandlers) - 1 do
          if FormHandlers[i] <> nil then
            with FormHandlers[i] do
              if not FormHandlers[i].Closed and (ParentForm = Form) and (PopupForm <> nil) and (PopupCtrl <> nil) then begin
                Result := True;
                break;
              end;
  end;
{$ENDIF}

begin
  if FormState and FS_ANIMRESTORING = 0 then begin
    ClearGlows(False, True);
    if not (csDestroying in ComponentState) and CanDrawNCArea and Form.HandleAllocated then begin
      if Form.Showing and HeaderUsed then
        sVCLUtils.IterateControls(Form, FormHeader.ScaledAddHeight, RepaintHeadCtrl);

      if SystemMenu = nil then
        PrepareForm; // If not intitialized (occurs when Scaled = False)

      FormState := FormState or FS_ACTIVATE;
      DoUpdate := FormActive <> TWMNCActivate(Message).Active;
      if FormState and FS_BLENDMOVING = 0 then begin
        if FormActive <> TWMNCActivate(Message).Active then begin
          FormActive := TWMNCActivate(Message).Active;
          SkinData.BGChanged := True;
        end;
{$IFNDEF ALITE}
        if not FormActive then
          FormActive := CheckPopupForms;
{$ENDIF}
      end;
      if not FormActive and (ShowAction = saMaximize) then // <<<<< Caption blinking removing
        ShowAction := saIgnore
      else
        if ShowAction <> saMaximize then begin
          // Check if cache changing is not required
          if SkinData.Skinned then begin
            if FCommonData.CommonSkinData.gd[FCommonData.SkinIndex].BorderIndex >= 0 then begin
              if (SkinData.CommonSkinData.ma[FCommonData.CommonSkinData.gd[FCommonData.SkinIndex].BorderIndex].ImageCount > 1) or (SkinData.CommonSkinData.gd[SkinData.SkinIndex].States > 1) then
                if DoUpdate and (FormState and FS_RESTORING = 0) then
                  FCommonData.BGChanged := True;
            end
            else
              if SkinData.CommonSkinData.gd[SkinData.SkinIndex].States > 1 then
                if DoUpdate then
                  FCommonData.BGChanged := True;
          end
          else
            if DoUpdate then
              FCommonData.BGChanged := True;

          if FormState and FS_SIZING = 0 then
            FCommonData.Updating := False;
        end
        else
          FCommonData.Updating := BorderForm = nil; // >>>>> Caption blinking removing

      if Form.Showing and IsWindowVisible(Form.Handle) then begin
        if Form.Showing and HeaderUsed then begin
          R := Form.ClientRect;
          R.Bottom := R.Top + FormHeader.AdditionalHeight;
          InvalidateRect(Form.Handle, @R, False);
        end;
        if FormActive <> (TWMActivate(Message).Active <> WA_INACTIVE) then
          FCommonData.BGChanged := True;

        if AeroIsEnabled then begin
          if BorderForm = nil then
  {$IFDEF D2007}
            if InAero or Application.MainFormOnTaskBar and (Form <> Application.MainForm) and (Application.MainForm <> nil) and (Application.MainForm.WindowState = wsMinimized) then
            else
  {$ENDIF}
              ProcessMessage(WM_SETREDRAW, 0, 0)
          else
            if (SkinData.FCacheBmp <> nil) and (GetLinesCount > 0) then begin // Menu line hiding
              if BorderForm.AForm = nil then
                BorderForm.CreateNewForm;

              SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False);
  {$IFDEF DELPHI7UP}
              if Form.AlphaBlend then
                SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, Form.AlphaBlendValue)
              else
  {$ENDIF}
                SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, MaxByte);

              SetWindowPos(BorderForm.AForm.Handle, HWND_TOP, 0, 0, 0, 0, SWPA_ZORDER);
            end;

          if not fAnimating and ((BorderForm = nil) or IsMenuVisible(Self)) and not Assigned(Form.OnPaint) {Problem with specifically handled events} then
            MakeCaptForm(Self);
        end
        else // not AeroIsEnabled
          if fAnimating then begin
            if RTInit then
              ProcessMessage(WM_SETREDRAW, 0, 0)
          end
          else
            if not (fsShowing in Form.FormState) {not FormActive} and ((BorderForm = nil) or IsMenuVisible(Self)) and not Assigned(Form.OnPaint) {Problem with specifically handled events} then
              MakeCaptForm(Self);

        if not fAnimating and (FormState and FS_BLENDMOVING = 0) and not AeroIsEnabled then // Forbid a borders painting by system
          if BorderForm <> nil then
            UpdateRgn(Self, False)
          else
            if Application.Mainform <> Form then
              RgnChanged := True;

        OldWndProc(TMessage(Message));

        if (Application.MainForm <> Form) or (Form.WindowState <> wsMinimized) then
          if AeroIsEnabled then begin
            if BorderForm = nil then begin
  {$IFDEF D2007}
              if InAero or Application.MainFormOnTaskBar and (Form <> Application.MainForm) and (Application.MainForm <> nil) and (Application.MainForm.WindowState = wsMinimized) then begin
              end
              else
  {$ENDIF}
              begin
                ProcessMessage(WM_SETREDRAW, 1, 0);
                RedrawWindow(Form.Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_UPDATENOW or RDW_NOERASE);
              end;
            end;
            if not fAnimating then begin
              ProcessMessage(WM_NCPAINT);
              if CaptForm <> nil then
  	          	Sleep(40); // Delay for borders repaint, avoid a blinking

              KillCaptForm(Self);
            end;
          end
          else begin // not AeroIsEnabled
            if fAnimating then begin
              if RTInit then
                ProcessMessage(WM_SETREDRAW, 1, 0)
            end
            else
              if (BorderForm = nil) or IsMenuVisible(Self) then begin
                RedrawWindow(Form.Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_NOERASE or RDW_FRAME);
                KillCaptForm(Self);
              end;

            if RTInit then
              RedrawWindow(Form.Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_NOERASE);
          end;
      end
      else
        OldWndProc(TMessage(Message));

      if Assigned(Form) and
           Form.Visible and
             (Form.FormStyle = fsMDIChild) and
               (fsCreatedMDIChild in Form.FormState) and
                 (fsshowing in Form.FormState) and
                   Assigned(MDISkinProvider) and
                     Assigned(TsSkinProvider(MDISkinProvider).MDIForm) then begin
        TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
        TsSkinProvider(MDISkinProvider).FLinesCount := -1;
        TsMDIForm(TsSkinProvider(MDISkinProvider).MDIForm).UpdateMDIIconItem;

        TrySendMessage(TsSkinProvider(MDISkinProvider).Form.Handle, WM_NCPAINT, 0, 0);
        TrySendMessage(TsSkinProvider(MDISkinProvider).Form.ClientHandle, WM_NCPAINT, 0, 0);
      end;
      if (GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED <> 0) and (FormTimer = nil) then
        ProcessMessage(WM_NCPAINT);

      if csCreating in Form.ControlState then
        Exit;

      if HaveBorder(Self) and (FormState and FS_BLENDMOVING = 0) then
        if MDIButtonsNeeded then begin
          if (TWMActivate(Message).Active <> WA_INACTIVE) or Form.ActiveMDIChild.Active then begin
            FormActive := (TWMActivate(Message).Active <> WA_INACTIVE) or (Form.ActiveMDIChild.Active);
            FLinesCount := -1;
          end;
        end
        else
          if FormActive <> (TWMActivate(Message).Active <> WA_INACTIVE) then begin
            FormActive := TWMActivate(Message).Active <> WA_INACTIVE;
{$IFNDEF ALITE}
            if not FormActive then
              FormActive := CheckPopupForms;
{$ENDIF}
            FLinesCount := -1;
          end;

      FormState := FormState and not FS_ACTIVATE;

      if (FormTimer = nil) or not FormTimer.Enabled then begin
        // If size of form is not initialized yet (wsMaximized)
        GetWindowRect(Form.Handle, R);
        if (WidthOf(R) = Form.Width) or (HeightOf(R) = Form.Height) then begin
          ProcessMessage(WM_NCPAINT);
          if BorderForm <> nil then
            case Form.WindowState of
              wsMaximized:
                if SkinData.SkinManager.Options.NativeBordersMaximized then begin
                  FreeAndNil(BorderForm);
                  UpdateRgn(Self, False);
                end
                else begin
                  BorderForm.UpdateExBordersPos; // Commented for removing of blinking
//                  UpdateLayerVisibility(SkinData, Form.Handle);
                end;

              wsNormal:
                if (FormTimer = nil) or (FormTimer is TacMinTimer) and (TacMinTimer(FormTimer).StepCount > 1) then begin
                  BorderForm.UpdateExBordersPos;
//                  UpdateLayerVisibility(SkinData, Form.Handle);
                end;
            end;
        end;
      end;

      TryInitMenu;
      if FCommonData.Skinned and (Adapter = nil) then
        AdapterCreate;
    end
    else
      OldWndProc(TMessage(Message));

    CleanSupportedList;
  end;
end;


procedure TsSkinProvider.AC_WMActivate(var Message: TWMActivate);
var
  b: boolean;
begin
  OldWndProc(TMessage(Message));
  if (Form <> nil) and Form.Showing then begin
    if ListSW = nil then
      RefreshFormScrolls(Self, ListSW, False);

    if not (csCreating in Form.ControlState) then begin
      FLinesCount := -1;
      if TMessage(Message).WParamLo = 1 then begin
{$IFNDEF FPC}
        if not (csDesigning in SkinData.SkinManager.ComponentState) then
          InitMenuItems(SkinData.Skinned); // Update after skinning in run-time
{$ENDIF}
        if Assigned(SystemMenu) then
          SystemMenu.UpdateItems;

        if not CanDrawNCArea then
          FCommonData.Updating := False;

        b := (Form.BorderStyle = bsNone) and not SystemBlur.Active {Fix bad repaint after popup};
      end
      else
        b := False;

      if b then begin
        UpdateLayerVisibility(SkinData, Form.Handle);
        if HeaderUsed then
          SetParentUpdated(Form);
      end;
    end;
  end;
  UpdateSlaveFormsList;
end;


procedure TsSkinProvider.AC_WMWindowPosChanging(var Message: TWMWindowPosChanging);
var
  cR: TRect;
{$IFNDEF NOWNDANIMATION}
  i: integer;
{$ENDIF}
begin
  if not RgnChanging and not (csLoading in Form.ComponentState) and (Form.FormStyle <> fsMDIChild) then
    with TWMWindowPosChanged(Message) do begin
      if Form.HandleAllocated and
           not IsZoomed(Form.Handle) and
             (WindowPos.Flags and SWP_NOMOVE = 0) and
               ((WindowPos^.X <> 0) or (WindowPos^.Y <> 0)) then

        with WindowPos^ do begin
          if FScreenSnap and Form.Showing then
            CheckNewPosition(X, Y);

          if FormState and FS_MAXBOUNDS <> 0 then begin
            cR := NormalBounds;
            if FormState and FS_MAXHEIGHT <> 0 then begin
              if Form.Top = WindowPos^.Y then begin
                WindowPos^.Y := NormalBounds.Top;
                WindowPos^.cy := WindowPos^.cy - (NormalBounds.Top - Form.Top);
              end
              else
                WindowPos^.cy := NormalBounds.Top + NormalBounds.Bottom;

              FormState := FormState and not FS_MAXHEIGHT;
            end;
            if FormState and FS_MAXWIDTH <> 0 then
              FormState := FormState and not FS_MAXWIDTH;

            Message.Result := 0;
            Exit;
          end;
        end;
{$IFNDEF NOWNDANIMATION}
      if Assigned(SkinData.SkinManager) and acLayered and CanDrawNCArea then
        if not SkipAnimation then
          if ((WindowPos.Flags and SWP_HIDEWINDOW <> 0) or (TWindowPos(WindowPos^).x = -32000)) and
                      (SkinData.FCacheBmp <> nil {it's possible under Aero}) then begin // Window will be hidden
            if not IsIconic(Form.Handle) then begin
              if (SkinData.SkinManager.ShowState <> saMinimize) and IsWindowVisible(Form.Handle) then // Closing
                if FAllowAnimation and SkinData.SkinManager.AnimEffects.FormHide.Active and
                     (SkinData.SkinManager.AnimEffects.FormHide.Time > 0) and
                     SkinData.SkinManager.Effects.AllowAnimation and
                     (FormState and FS_ANIMCLOSING = 0) and
                     (Form.Parent = nil) then begin

                  // Preparing for a hiding animation
                  FormState := FormState or FS_ANIMCLOSING;
                  SkinData.FCacheBmp := GetFormImage(Self, True{Old SkinData.FCacheBmp destroyed});
                  if BorderForm <> nil then begin
                    BorderForm.ExBorderShowing := True;
  {$IFDEF DELPHI7UP}
                    if Form.AlphaBlend then
                      i := Form.AlphaBlendValue
                    else
  {$ENDIF}
                      i := MaxByte;

                    SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False);
                    SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, i);
                    SetWindowPos(BorderForm.AForm.Handle, 0, BorderForm.AForm.Left, BorderForm.AForm.Top, 0, 0, SWPA_SHOWZORDERONLY);
                  end
                  else begin
                    FreeAndNil(CoverForm);
                    CoverForm := MakeCoverForm(Form.Handle, Self);
                  end;
                end;
            end
            // If minimized by Aero shake, but wnd is visible still
            else
              if (Form.WindowState <> wsMinimized) and not IsIconic(Form.Handle) and (TWindowPos(WindowPos^).x = -32000) then begin
                OldWndProc(TMessage(Message));
                StartMinimizing(Self);
                Form.WindowState := wsMinimized;
                Exit;
              end;
          end // if ((WindowPos.Flags and SWP_HIDEWINDOW <> 0...
          else
            if WindowPos.Flags and SWP_SHOWWINDOW <> 0 then begin
              if (BorderForm <> nil) and (BorderForm.AForm = nil) then begin // Update after showing by SWP_SHOW (in ScaleBy)
                BorderForm.CreateNewForm;
                BorderForm.ExBorderShowing := False;
                SkinData.BGChanged := True;
                BorderForm.UpdateExBordersPos();
              end;
              if IsWindowVisible(Form.Handle) then
                SetWindowPos(Form.Handle, 0, 0, 0, 0, 0, SWPA_NOCOPYBITS);
            end;
    end // with TWMWindowPosChanged(Message) do begin ...
    else begin // Resizing of form
      FormState := FormState and not FS_ANIMCLOSING;
      with TWMWindowPosChanging(Message) do
        if (BorderForm <> nil) and
             (BorderForm.AForm <> nil) and
               (WindowPos^.cx <> 0) and
                 (WindowPos^.cy <> 0) and
                   (WindowPos.Flags and SWP_NOACTIVATE <> 0) and
                     (FormState and FS_ANIMMINIMIZING = 0) and
                       (WindowPos.Flags and (SWP_NOMOVE or SWP_NOSIZE) = 0) then
          if ((WindowPos^.cx < LastClientRect.Right) or (WindowPos^.cy < LastClientRect.Bottom)) and
               ((ListSW = nil) or (not ListSW.sBarVert.fScrollVisible and not ListSW.sBarHorz.fScrollVisible)) and
                 BorderForm.AForm.HandleAllocated then
            if not IsIconic(Form.Handle) then begin
              FormState := FormState or FS_SIZING;
              SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn(WindowPos^.cx, WindowPos^.cy), False);
              if BorderForm.AForm <> nil then
                SetWindowPos(Form.Handle, BorderForm.AForm.Handle, 0, 0, 0, 0, SWPA_ZORDER);

              FormState := FormState and not FS_SIZING;
            end
            else begin
              SkinData.BGChanged := True;
              BorderForm.UpdateExBordersPos(True);
            end;
{$ENDIF} // NOWNDANIMATION
    end;

  OldWndProc(TMessage(Message));
end;


const
  StateFlags: array [boolean] of WParam = (SC_MAXIMIZE, SC_RESTORE);


procedure TsSkinProvider.AC_WMLButtonUp(var Message: TWMNCLButtonUp);
var
  p: TPoint;
  hTest: Longint;
  m: TWMNCHitTest;
  Item: TacTitleBarItem;
begin
  if CanDrawNCArea and Form.Enabled then begin
    if (BorderForm <> nil) and (Message.HitTest = HTTRANSPARENT) then
      Message.HitTest := BorderForm.Ex_WMNCHitTest(TWMNCHitTest(Message));

    case Message.HitTest of
      HTCLOSE:
        if SystemMenu.EnabledClose and biClicked then begin
          ButtonClose.cpState := 0;
          TrySendMessage(Form.Handle, WM_SYSCOMMAND, SC_CLOSE, 0);
          if csDestroying in Form.ComponentState then
            Exit;

          KillAnimations;
          if (Form <> nil) and Form.Visible then
            if FCommonData <> nil then begin
//            FCommonData.BGChanged := True; // Clear cache if form closing was cancelled
              SetHotHT(0);
            end;
        end;

      HTMAXBUTTON:
        if SystemMenu.EnabledMax or (Form.WindowState = wsMaximized) and SystemMenu.EnabledRestore then
          if biClicked then begin
            SetHotHT(0);
            RgnChanged := True;
            if Form.FormStyle = fsMDIChild then
              ChildProvider := nil;

            TrySendMessage(Form.Handle, WM_SYSCOMMAND, StateFlags[Form.WindowState = wsMaximized], 0);
            SystemMenu.UpdateItems;
            biClicked := False;
          end
          else begin
            SetHotHT(0);
            OldWndProc(TMessage(Message));
          end;

      HTMINBUTTON:
        if biClicked then begin
          if BorderForm <> nil then
            p := Point(Message.XCursor - BorderForm.AForm.Left, Message.YCursor - BorderForm.AForm.Top)
          else
            p := CursorToPoint(Message.XCursor, Message.YCursor);

          if PtInRect(ButtonMin.cpRect, p) then begin
            SetHotHT(0);
            if Application.MainForm = Form then begin
              SkipAnimation := True;
              TrySendMessage(Form.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
              SkipAnimation := False;
            end
            else
              TrySendMessage(Form.Handle, WM_SYSCOMMAND, iff(IsIconic(Form.Handle), SC_RESTORE, SC_MINIMIZE), 0);

            FCommonData.BGChanged := True;
          end
          else
            OldWndProc(TMessage(Message));
        end
        else begin
          SetHotHT(0);
          OldWndProc(TMessage(Message));
        end;

      HTHELP:
        if biClicked then begin
          TrySendMessage(Form.Handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
          SetHotHT(0);
          SystemMenu.UpdateItems;
          biClicked := False;
          Form.Perform(WM_NCPAINT, 0, 0);
        end
        else
          SetHotHT(0);

      // MDI child buttons
      HTCHILDCLOSE:
        if biClicked then begin
          biClicked := False;
          SendMessage(Form.ActiveMDIChild.Handle, WM_SYSCOMMAND, SC_CLOSE, 0);
          SetHotHT(0, False);
        end;

      HTCHILDMAX: begin
        if biClicked then
          SendMessage(Form.ActiveMDIChild.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);

        biClicked := False;
        SetHotHT(0, False);
      end;

      HTCHILDMIN: begin
        if biClicked then begin
          TsSkinProvider(MDISkinProvider).FCommonData.BeginUpdate;
          biClicked := False;
          SendMessage(Form.ActiveMDIChild.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
        end;
        SetHotHT(0);
      end

      else
        if BetWeen(Message.HitTest, HTUDBTN, HTUDBTN + TitleButtons.Count - 1) then begin
          if biClicked then
            TitleButtons.Items[Message.HitTest - HTUDBTN].MouseUp(Message.HitTest - HTUDBTN, mbLeft, [], Message.XCursor, Message.YCursor);

          biClicked := False;
          SetHotHT(0);
        end
        else
          if BetWeen(Message.HitTest, HTITEM, HTITEM + MaxByte) then begin
            if biClicked and Assigned(FTitleBar) then begin
              Item := FTitleBar.Items[Message.HitTest - HTITEM];
              Item.State := 0; // Reset state
              Item.DoMouseUp(mbLeft, [], Message.XCursor, Message.YCursor);
              if not Item.Visible then begin
                if Assigned(Item.Timer) then
                  FreeAndNil(Item.Timer);
              end
              else
                if not Item.Down then begin
                  with acMousePos do begin
                    m.XPos := X;
                    m.YPos := Y;
                  end;
                  if BorderForm <> nil then
                    hTest := BorderForm.Ex_WMNCHitTest(m)
                  else
                    hTest := HTProcess(m);
                  // Button is hovered still
                  if hTest = Message.HitTest then begin
                    // Show animation to hot State
                    Item.State := 1;
                    if BorderForm <> nil then
                      StartItemAnimation(Item, 1, False, BorderForm.AForm)
                    else
                      StartItemAnimation(Item, 1, False);
                  end;
                  Item.State := 0;
                end;
            end;
          end
          else
            if IsIconic(Form.Handle) then
              if Assigned(MDISkinProvider) then
                DropSysMenu(acMousePos.x + FormLeftTop.X, acMousePos.y)
              else
                OldWndProc(TMessage(Message))
            else
              if (ResizeMode = rmBorder) and Form.Enabled and (Form.WindowState <> wsMaximized) and bInProcess then begin
                // Common section
                p := Form.ClientToScreen(Point(Message.XCursor, Message.YCursor));
                StopMove(p.x, p.y);
                ReleaseCapture;
              end
              else
                OldWndProc(TMessage(Message));

      biClicked := False;
    end;
  end
  else
    OldWndProc(TMessage(Message));
end;


procedure TsSkinProvider.StartHintTimer(TitleItem: TacTitleBarItem);
begin
  if TitleItem.Hint <> '' then begin
    Application.Hint := TitleItem.Hint;
    if TitleItem.ShowHint and Form.ShowHint and Application.ShowHint then begin
      if FHintTimer = nil then
        FHintTimer := TacTimer.Create(nil);

      FHintRect := TitleItem.Rect;
      if BorderForm <> nil then
        OffsetRect(FHintRect, BorderForm.AForm.Left, BorderForm.AForm.Top)
      else
        OffsetRect(FHintRect, Form.Left, Form.Top);

      FHintTimer.FOwner := TitleItem;
      if Application.HintPause > 0 then begin
        FHintTimer.Interval := Application.HintPause;
        FHintTimer.OnTimer := OnHintTimer;
        FHintTimer.Enabled := True;
      end
      else
        ShowHintWnd(TacTitleBarItem(FHintTimer.FOwner));
    end;
  end;
end;


procedure TsSkinProvider.OnHintTimer(Sender: TObject);
begin
  if (FHintTimer <> nil) and (FHintTimer.FOwner <> nil) then begin
    FHintTimer.Enabled := False;
    if PtInRect(FHintRect, acMousePos) then
      ShowHintWnd(TacTitleBarItem(FHintTimer.FOwner));
  end;
end;


procedure TsSkinProvider.AC_WMSize(var Message: TMessage);
var
  cR: TRect;
  acM: TMessage;
  X, Y, i, h1, h2, w1, w2: integer;
  bExtBorderUpdated, UpdateClient: boolean;
begin
  KillAnimations;
  if not SkinData.FUpdating and IsWindowVisible(Form.Handle) and (FormState and FS_ANIMRESTORING = 0) then
    with FCommonData.CommonSkinData do begin
      if IsGripVisible(Self) then
        if FCommonData.SkinManager.IsValidImgIndex(SkinData.CommonSkinData.GripRightBottom) then begin // If grip image is defined in skin
          X := ma[SkinData.CommonSkinData.GripRightBottom].Width;
          Y := ma[SkinData.CommonSkinData.GripRightBottom].Height;
          if (Form.ClientWidth < WidthOf(LastClientRect)) or (Form.ClientHeight < HeightOf(LastClientRect)) then begin
            cR := Rect(Form.ClientWidth - X, Form.ClientHeight - Y, Form.ClientWidth, Form.ClientHeight);
            InvalidateRect(Form.Handle, @cR, False);
          end;
        end;

      if (Form.ClientWidth < WidthOf(LastClientRect)) or (Form.ClientHeight < HeightOf(LastClientRect)) or (WidthOf(LastClientRect) = 0) then begin
        i := FCommonData.SkinManager.GetMaskIndex(FCommonData.SkinIndex, s_ImgTopRight, SkinData.CommonSkinData);
        if i >= 0 then begin
          X := ma[i].Width;
          Y := ma[i].Height;
          cR := Rect(LastClientRect.Right - X, LastClientRect.Bottom - Y, LastClientRect.Right, LastClientRect.Bottom);
          InvalidateRect(Form.Handle, @cR, False);
        end;
        i := FCommonData.SkinManager.GetMaskIndex(FCommonData.SkinIndex, s_ImgBottomRight, SkinData.CommonSkinData);
        if i >= 0 then begin
          X := ma[i].Width;
          Y := ma[i].Height;
          cR := Rect(LastClientRect.Right - X, LastClientRect.Bottom - Y, LastClientRect.Right, LastClientRect.Bottom);
          InvalidateRect(Form.Handle, @cR, False);
        end;
      end;

      if Assigned(FGlow1) then
        FreeAndNil(FGlow1);

      if Assigned(FGlow2) then
        FreeAndNil(FGlow2);

      FLinesCount := -1;
{$IFNDEF NOWNDANIMATION}
      if FormState and FS_BLENDMOVING <> 0 then
        FinishBlendOnMoving(Self);
{$ENDIF}

      // Force updating of ext border if form is going smaller
      if (BorderForm <> nil) and ((WidthOf(LastClientRect) > Form.ClientWidth) or (HeightOf(LastClientRect) > Form.ClientHeight)) then begin
        SkinData.BGChanged := True;
        BorderForm.UpdateExBordersPos(True);
        bExtBorderUpdated := True;
      end
      else    
        bExtBorderUpdated := False;

      if (Form.Parent = nil) and FDrawClientArea and CanDrawNCArea then begin
        if FormState and FS_RESTORING = 0 then
          FCommonData.Updating := True;

        FormState := FormState or FS_SIZING;
        OldWndProc(Message);
        FormState := FormState and not FS_SIZING;
        FCommonData.Updating := False;
      end
      else
        OldWndProc(Message);

      if not InAnimationProcess and ((FormState and FS_ANIMSHOWING = 0) { // Desc 9 } or (Form.WindowState <> wsNormal)) then
        if Form.Showing and (Form.WindowState <> wsMinimized) then begin
          if (FCommonData.BGChanged or FormChanged) and not (IsIconic(Form.Handle) and InAero) then begin
            FCommonData.BGChanged := True;
            if FCommonData.FCacheBmp <> nil then
              UpdateClient := ((FCommonData.FCacheBmp.Width > Form.Width) or (FCommonData.FCacheBmp.Height > Form.Height))
            else
              UpdateClient := False;

            if CanDrawNCArea then begin
              if SkinData.SkinManager.Options.NativeBordersMaximized and (Form.WindowState = wsMaximized) and (BorderForm <> nil) then
                FreeAndNil(BorderForm);

              // If can optimize (Pre-paint the form while is under the BorderForm)
              if (BorderForm <> nil) and not Assigned(Form.OnPaint) then begin // Update extended borders
                if BorderForm.AForm = nil then
                  BorderForm.CreateNewForm;

                if ((ListSW = nil) or (not ListSW.sBarVert.fScrollVisible and not ListSW.sBarHorz.fScrollVisible)) and (ResizeMode = rmStandard) then
                  FormState := FormState or FS_SIZING;

                if not bExtBorderUpdated then
                  BorderForm.UpdateExBordersPos; // If ExtBorder exists already

                FCommonData.Updating := True;
                FormState := FormState and not FS_SIZING;
                BorderForm.ExBorderShowing := True;
                // Move ExtBorder on top
                SetWindowPos(BorderForm.AForm.Handle, SendAMessage(Form.Handle, AC_GETTOPWND), 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER or SWP_NOREDRAW or SWP_NOSIZE or SWP_NOMOVE);
                BorderForm.ExBorderShowing := False;
                RgnChanged := True;
                SendAMessage(Form.Handle, AC_SETFLOATZORDER, 1 {Top});
                UpdateRgn(Self, True, True);
                FCommonData.Updating := False;
              end
              else begin
                RgnChanged := True;
                FillArOR(Self);
                if not fAnimating then // Prevent of invisible form issue, rgn sometimes is wrong
                  UpdateRgn(Self, True, True);
              end;

              if FCommonData.FUpdating then
                Exit;

              h1 := HeightOf(LastClientRect);
              h2 := Form.ClientHeight;
              w1 := WidthOf(LastClientRect);
              w2 := Form.ClientWidth;
              if (SkinData.BGType and BGT_STRETCH <> 0) or
                   (SkinData.BGType and BGT_GRADIENTVERT <> 0) and (h1 <> h2) or
                      (SkinData.BGType and BGT_GRADIENTHORZ <> 0) and (w1 <> w2) or
                         (SkinData.BGType and BGT_STRETCHVERT = BGT_STRETCHVERT) and (h1 <> h2) or
                            (SkinData.BGType and BGT_STRETCHHORZ = BGT_STRETCHHORZ) and (w1 <> w2)
              then begin
                acM := MakeMessage(SM_ALPHACMD, AC_SETCHANGEDIFNECESSARY shl 16 + 1, 0, 0);
                AlphaBroadCast(Form, acM);
              end;
              // If can optimize (Pre-paint the form while is under the BorderForm)
              if (BorderForm <> nil) and
                   ((ListSW = nil) or
                      (ListSW.sBarVert = nil) or
                        (ListSW.sBarHorz = nil) or
                          (not ListSW.sBarVert.fScrollVisible and not ListSW.sBarHorz.fScrollVisible)) then begin // Pre-paint the form while is under the BorderForm

                if BorderForm.AForm = nil then
                  BorderForm.CreateNewForm;
                // Repaint Form
                RedrawWindow(Form.Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW { // Desc 8 } or iff((Form.BorderWidth > 0) or (Form.Menu <> nil), RDW_FRAME, 0));
                // Move ExtBorder back (z-order)
                if (BorderForm <> nil) and (BorderForm.AForm <> nil) then begin
                  SetWindowPos(BorderForm.AForm.Handle, Form.Handle, 0, 0, 0, 0, SWPA_ZORDER);
                  if (BorderForm <> nil) and (BorderForm.AForm <> nil) then
                    SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False); // Update borders region

                  BorderForm.ExBorderShowing := False;
                end
                else
                  UpdateRgn(Self, False);
              end
              else
                RedrawWindow(Form.Handle, nil, 0, RDW_NOFRAME or RDW_NOERASE or RDW_INVALIDATE or RDW_UPDATENOW);

              SetParentUpdated(Form);
            end
            else
              if UpdateClient then
                InvalidateRect(Form.Handle, nil, False);

            if Assigned(Form.OnResize) then
              Form.OnResize(Form);
          end
          else
            if (Form.FormStyle = fsMDIForm) or (Form.FormStyle = fsMDIChild) or (Form.Parent <> nil) then begin
              FillArOR(Self);
              UpdateRgn(Self, True, True) // Update region
            end
            else
              case Message.WParam of
                SIZE_MAXIMIZED:
                  if (Form.FormStyle = fsMDIChild) and (Form.WindowState = wsMaximized) then begin // Repaint MDI child buttons
                    TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
                    TsSkinProvider(MDISkinProvider).MenuChanged := True;
                    RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
                  end;
              end;
        end
        else
          FCommonData.BGChanged := True;

      LastClientRect := MkRect(Form.ClientWidth, Form.ClientHeight);
    end
  else begin
    RgnChanged := True;
    FCommonData.BGChanged := True;
    OldWndProc(Message);
  end;
end;


type
  TAccessManager = class(TsSkinManager);

function TsSkinProvider.AC_SMAlphaCmd_Common(var Message: TMessage): boolean;
var
  i: integer;
  Images: TCustomImageList;
begin
  Result := True;
  case Message.WParamHi of
    AC_LINKOBJ:
      if [csDesigning, csLoading] * ComponentState = [] then
        if Message.WParamLo = 0 then // Remove link
          FrameAdapters.Remove(TObject(Message.LParam))
        else // Add link
          AddObjToList(TObject(Message.LParam), FrameAdapters);

    AC_UPDATEFLOATBITMAPS, AC_UPDATEITEMSALPHA, AC_UPDATEFLOATITEMS, AC_PAINTFLOATITEMS:
      OldWndProc(Message);

    AC_GETDEFSECTION: begin
      Message.Result := 12 + 1;
      Exit;
    end;

    AC_STATUSBAR: begin
      SkinData.BGChanged := True;
      if Message.WParamLo = 0 then
        StatusBar := nil
      else
        StatusBar := TControl(Message.LParam);
    end;

    AC_GETDEFINDEX:
      if FCommonData.SkinManager <> nil then
        if FCommonData.SkinSection <> '' then
          Message.Result := FCommonData.SkinManager.GetSkinIndex(FCommonData.SkinSection) + 1
        else
          if (Form.Parent <> nil) and (Form.BorderStyle = bsNone) then
            Message.Result := FCommonData.SkinManager.SkinCommonInfo.Sections[ssTransparent] + 1
          else
            Message.Result := FCommonData.SkinManager.GetSkinIndex(s_Form) + 1;

    AC_SETSCALE: begin
      KillAnimations;
      SetHotHT(-1);

      CommonMessage(Message, SkinData);
      if TitleBar <> nil then
        TitleBar.Initialized := False;

      SkinData.CommonSkinData := SkinData.SkinManager.CommonSkinData(Message.LParam);
      InitSysParams(Message.LParam);
      AlphaBroadCast(Form, Message);
      OldWndProc(Message);
    end;

    AC_GETSCALE:
      if AllowScale then
        Message.Result := SkinData.CurrentPPI
      else
        Message.Result := -1;

    AC_FONTSCHANGED:
      with TAccessManager(SkinData.SkinManager) do begin
        if AddedTitle.FFont.Name = DefOldFontName then
          AddedTitle.FFont.Name := DefNewFontName;

        if (FTitleBar <> nil) then
          for i := 0 to FTitleBar.Items.Count - 1 do
            with FTitleBar.Items[i] do
              if not FontData.UseSysFontName then
                if FontData.Font.Name = DefOldFontName then begin
                  FontData.Font.Name := DefNewFontName;
                  if AutoSize and FTitleBar.Initialized then
                    UpdateSize(False);
                end;

        UpdateSkinCaption(Self);
        CommonMessage(Message, SkinData);
      end;

    AC_GETTOPWND, AC_SETFLOATZORDER:
      OldWndProc(Message);


    AC_REMOVESKIN:
      if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
        FreeAndNil(ListSW);
        InitDwm(Form.Handle, False);
        CommonMessage(Message, FCommonData);
        FLinesCount := -1;
        FTitleSkinIndex := -1;
        FCaptionSkinIndex := -1;
        SkinData.TranspMode := 0;
        AlphaBroadCast(Form, Message);
        AdapterRemove;
        KillAnimations;
        if Assigned(SkinData.SkinManager) then
          DeleteUnusedBmps(True);

        if (Form <> nil) and not (csDestroying in Form.ComponentState) then begin
          if Assigned(SkinData.SkinManager) then begin
{$IFNDEF FPC}
            InitMenuItems(False);
{$ENDIF}
            CheckSysMenu(False);
            if (Form.FormStyle = fsMDIForm) and (MDIForm <> nil) then
              HookMDI(False);

            if HaveBorder(Self) and not InMenu then
              SetWindowRgn(Form.Handle, 0, True); // Return standard kind

            if Form.Menu <> nil then begin
              Images := Form.Menu.Images;
              Form.Menu.Images := nil;
            end
            else
              Images := nil;

            UpdateMenu;
            if Form.Menu <> nil then
              Form.Menu.Images := Images;

            if UseGlobalColor and not SkinData.CustomColor then
              Form.Color := clBtnFace;

            InitExBorders(False);
{$IFDEF DELPHI7UP}
            if Form.AlphaBlend then
              DoLayered(Form.Handle, True, Form.AlphaBlendValue);
{$ENDIF}
            RedrawWindow(Form.ClientHandle, nil, 0, RDWA_ALLNOW);
          end;
          for i := 0 to Form.ControlCount - 1 do
            if Form.Controls[i] is TLabel then
              InitLabel(Form.Controls[i], False);

          FreeAndNil(FCommonData.FCacheBmp);
          SetClassLong(Form.Handle, GCL_HBRBACKGROUND, ACNativeInt(GetSysColorBrush(COLOR_BTNFACE)));
          SendAMessage(Form.Handle, AC_UPDATEFLOATITEMS);
          if SystemBlur.Active then
            SkinData.TranspMode := 2;

          FSystemBlur.UpdateBlurMode;
        end;
      end
      else begin
        CommonMessage(Message, FCommonData);
        AlphaBroadCast(Form, Message);
      end;

    AC_SETNEWSKIN: begin
      SkinData.CommonSkinData := nil;
      KillAnimations;
      if not (csDestroying in Form.ComponentState) and Assigned(SkinData) then
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and not Assigned(SystemMenu) then
          PrepareForm;

      FSystemBlur.UpdateBlurMode;
      Result := False;
    end;

    AC_GETAPPLICATION:
      Message.Result := LRESULT(Application);

    AC_PARENTCLOFFSET:
      Message.Result := MakeLong(OffsetX, OffsetY);

    AC_CTRLHANDLED:
      Message.Result := 1;

    AC_ENDUPDATE: begin
      if SkinData.CtrlSkinState and ACS_MNUPDATING <> 0 then begin
        SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_MNUPDATING;
        TrySendMessage(Form.Handle, CM_MENUCHANGED, 0, 0);
      end;
      Result := False;
    end;

    AC_GETBG:
      if (FCommonData <> nil) and FCommonData.Skinned then
        with PacBGInfo(Message.LParam)^ do begin
          Offset := MkPoint;
          if FCommonData.BGChanged and (not FCommonData.FUpdating or FInAnimation) then begin
            if (BorderForm = nil) and SkinData.SkinManager.ExtendedBorders and (Form.WindowState <> wsMaximized) and (Form.BorderStyle <> bsNone) then begin
              Result := False; // Broken bg because ext borders are not ready
              Exit;
            end;
            PaintAll;
          end;

          if PleaseDraw then begin
            inc(Offset.X, OffsetX);
            inc(Offset.Y, OffsetY);
          end;
          if Assigned(Form.OnPaint) and (SkinData.FCacheBmp <> nil) then begin
            Bmp := SkinData.FCacheBmp;
            Offset := Point(OffsetX, OffsetY);
            BgType := btCache;
            Exit;
          end;

          if DrawClientArea then
            if FCommonData.Skinned then
              InitBGInfo(FCommonData, PacBGInfo(Message.LParam), min(integer(FormActive), FCommonData.CommonSkinData.gd[FCommonData.SkinIndex].States - 1))
            else
              InitBGInfo(FCommonData, PacBGInfo(Message.LParam), min(integer(FormActive), 0))
          else begin
            Color := ColorToRGB(clBtnFace);
            BgType := btFill;
            Bmp := nil;
          end;

          if BgType = btCache then
            if not PleaseDraw then
              if Bmp = nil then begin
                if FCommonData.BGChanged then
                  PaintAll;

                Bmp := FCommonData.FCacheBmp;
              end;

          with Offset do begin
            X := X + OffsetX;
            if X <> 0 then
              FillRect.Left := max(0, FillRect.Left - X);

            Y := Y + OffsetY;
            if Y <> 0 then
              FillRect.Top  := max(0, FillRect.Top - Y);
          end;
        end
      else
        Result := False
    else
      Result := False;
  end;
end;


function TsSkinProvider.AC_SMAlphaCmd_Unskinned(var Message: TMessage): boolean;
var
  i: integer;
  AThirdLists: TStringLists;
begin
  Result := True;
  AThirdLists := nil;
  case Message.WParamHi of
    AC_PREPARECACHE:
      SkinData.BGChanged := False;

    AC_GETPROVIDER:
      Message.Result := LRESULT(Self); // Used for menuline init

    AC_SETNEWSKIN:
      if not (csDestroying in Form.ComponentState) and Assigned(SkinData) then begin
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          if SystemBlur.Active then
            FFormState := FFormState or FS_GLASSNEEDED;

          SkinData.CommonSkinData := nil;
          KillAnimations;
          DeleteUnusedBmps(True);
          FCommonData.UpdateIndexes;
          FTitleSkinIndex := -1;
          InitIndexes;
          if SkinData.SkinManager <> nil then begin
            if (BorderForm <> nil) and IsZoomed(Form.Handle) then
              FSysExHeight := ActualTitleHeight > (SysCaptHeight(Self) + 4)
            else
              FSysExHeight := False;

            CheckSysMenu(True);
            UpdateIconsIndexes;
            if (Form.FormStyle = fsMDIForm) and (Screen.ActiveForm = Form.ActiveMDIChild) or Form.Active then
              FormActive := True;

            if not (csLoading in SkinData.SkinManager.ComponentState) then begin
              // Menus skinning
              if (Form.Menu <> nil) and FMenuOwnerDraw then
                MenusInitialized := True;
{$IFNDEF FPC}
              InitMenuItems(True); // Update after skinning in run-time
{$ENDIF}
              if not MenusInitialized then
                MenusInitialized := UpdateMenu;

              // Labels skinning
              if Adapter <> nil then begin
                if OwnThirdLists then
                  AThirdLists := ThirdLists
                else
                  AThirdLists := SkinData.SkinManager.ThirdLists;

                for i := 0 to Form.ControlCount - 1 do
                  if (Form.Controls[i] is TLabel) and Adapter.IsControlSupported(Form.Controls[i], AThirdLists) then
                    InitLabel(Form.Controls[i], True);
              end;
            end;
            // Menu Line refresh
            FCommonData.BGChanged := True;
            FLinesCount := -1;
            if TForm(Form).FormStyle = fsMDIForm then
              HookMDI;

            // Update skin data in the TitleBar
            UpdateTitleBar;
            InitDwm(Form.Handle, CanDrawNCArea);
          end;
          if Adapter = nil then
            AdapterCreate
          else
            TacCtrlAdapter(Adapter).AddAllItems(nil);
        end;
      end
      else
        Result := False;

    else
      Result := False;
  end;
end;


function TsSkinProvider.AC_SMAlphaCmd_Skinned(var Message: TMessage): boolean;
var
  i: integer;
begin
  Result := False;
  case Message.WParamHi of
    AC_ANIMSCALE:
      AnimChangeScale(Message.LParamHi, Message.LParamLo <> 0);

    AC_INVALIDATE:
      if Form.HandleAllocated then begin
        SkinData.BGChanged := True;
        RedrawWindow(Form.Handle, nil, 0, iff(Message.WParamLo <> 0, RDWA_ALLNOW, RDWA_ALL));
      end;

    AC_CONTROLLOADED:
      if (Form <> nil) and not (csLoading in Form.ComponentState) then
        if Adapter <> nil then
          if Message.LParam <> 0 then
            TacCtrlAdapter(Adapter).AddAllItems(TWinControl(Message.LParam))
          else
            TacCtrlAdapter(Adapter).AddAllItems(Form);

    AC_PREPARING:
      if FCommonData <> nil then begin
        Message.Result := LRESULT(not InAnimationProcess and (FCommonData.FUpdating));
        Result := True;
      end;

    AC_FLUENTHANDLE: begin
      if Message.WParamLo = 1 then begin
        if FluentHandles = nil then
          FluentHandles := TList.Create;

        if FluentHandles.IndexOf(Pointer(Message.LParam)) < 0 then
          FluentHandles.Add(Pointer(Message.LParam));
      end
      else begin
        if not Assigned(FluentHandles) or (FluentHandles.Count = 0) then
          Exit;

        FluentHandles.Remove(Pointer(Message.LParam));
      end;
    end;

    AC_ENDPARENTUPDATE:
      if FCommonData.FUpdating then
        if not InUpdating(FCommonData, True) then begin
          RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE {or RDW_ALLCHILDREN} or RDW_UPDATENOW);
          SetParentUpdated(Form);
          Result := True;
        end;

    AC_SETBGCHANGED:
      FCommonData.BGChanged := True;

    AC_GETFONTINDEX:
      if (FormHeader.AdditionalHeight > 0) and (FHeaderIndex >= 0) and (PacPaintInfo(Message.LParam).R.Top < FormHeader.ScaledAddHeight) then begin
        PacPaintInfo(Message.LParam)^.FontIndex := FHeaderIndex;
        PacPaintInfo(Message.LParam)^.SkinManager := SkinData.SkinManager;
        Message.Result := 1;
      end
      else
        if (Form.Parent <> nil) and NeedParentFont(SkinData, PacPaintInfo(Message.LParam)^.State) then
          Message.Result := GetFontIndex(Form.Parent, PacPaintInfo(Message.LParam))
        else
          if SkinData.CommonSkinData.gd[SkinData.SkinIndex].States <= PacPaintInfo(Message.LParam)^.State then
            Message.Result := -1 // Use own child font
          else begin
            if DrawClientArea then begin
              PacPaintInfo(Message.LParam)^.FontIndex := SkinData.SkinIndex;
              Message.Result := 1;
            end
            else
              Message.Result := -1;
          end;

    AC_GETBORDERWIDTH: begin
      Result := True;
      case Message.LParamLo of
        1: Message.Result := SizeFrame;
        2: Message.Result := FixedFrame
        else
          if (ListSW <> nil) and (ListSW.cxLeftEdge <> 0) then begin
            Message.Result := ListSW.cxLeftEdge - Form.BorderWidth;
            Exit;
          end
          else begin
            Message.Result := (Form.Width - Form.ClientWidth) div 2 - Form.BorderWidth;
            if Message.Result = 0 then
              case Message.LParamHi of
                1: Message.Result := SizeFrame;
                2: Message.Result := FixedFrame
              end
            else
              Exit;
          end;
      end;
      inc(Message.Result, FramePadding{CXPaddedBorder});
    end;

    AC_SETPOSCHANGING:
      if Message.LParam = 1 then
        FormState := FormState or FS_POSCHANGING
      else
        FormState := FormState and not FS_POSCHANGING;

    AC_SETNCSKINNED: begin
      UpdateNCArea(boolean(Message.LParam));
      Result := True;
    end;

    AC_GETPOSCHANGING:
      Message.Result := integer(FormState and FS_POSCHANGING <> 0);

    AC_SETALPHA: if IsWindowVisible(Form.Handle) then begin
      if BorderForm <> nil then
        SetFormBlendValue(BorderForm.AForm.Handle, BorderForm.SkinData.FCacheBmp, Message.LParam);

      if Message.LParam <> MaxByte then begin
        if GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
          SetWindowLong(Form.Handle, GWL_EXSTYLE, GetWindowLong(Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

        SetLayeredWindowAttributes(Form.Handle, clNone, Message.LParam, ULW_ALPHA);
      end
      else
        if GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED <> 0 then
          while SetWindowLong(Form.Handle, GWL_EXSTYLE, GetWindowLong(Form.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED) = 0 do;
    end;

    AC_NCPAINT: begin
      if Message.LParam = 1 then begin
        FCommonData.BGChanged := True;
        UpdateTitleBar;
      end;
      UpdateSkinCaption(Self);
    end;

    AC_UPDATING: begin
      FCommonData.Updating := Message.WParamLo = 1;
      if FCommonData.Updating then
        FCommonData.BGChanged := True;
    end;

    AC_REFRESH:
      if RefreshNeeded(SkinData, Message) then begin
        if Adapter = nil then
          AdapterCreate
        else
          TacCtrlAdapter(Adapter).AddAllItems(nil);

        if CanDrawNCArea and FDrawClientArea then
          RefreshFormScrolls(Self, ListSW, False);

        FLinesCount := -1;
        if not (csLoading in SkinData.SkinManager.ComponentState) then begin
          UpdateMenu;
{$IFNDEF FPC}
          InitMenuItems(SkinData.Skinned);
{$ENDIF}
        end;
        if HaveBorder(Self) then
          RgnChanged := True;
        // Update skin data in the TitleBar
        UpdateTitleBar;
        if Form.HandleAllocated then begin
          if Form.Visible then begin
            FCommonData.BGChanged := True;
            InitExBorders(SkinData.SkinManager.ExtendedBorders);
            if not InAnimationProcess then
              if (Form.FormStyle = fsMDIForm) and Assigned(Form.ActiveMDIChild) and (Form.ActiveMDIChild.WindowState = wsMaximized) then begin
                ProcessMessage(WM_NCPAINT);
                InvalidateRect(Form.ActiveMDIChild.Handle, nil, True);
              end
              else begin
                RedrawWindow(Form.Handle, nil, 0, RDWA_NOCHILDRENNOW);
                if Form.FormStyle = fsMDIForm then
                  RedrawWindow(Form.ClientHandle, nil, 0, RDWA_NOCHILDRENNOW);
              end;

            if UseGlobalColor and not SkinData.CustomColor then
              Form.Color := SkinData.SkinManager.GetGlobalColor;

            if MDIForm <> nil then
              TsMDIForm(MDIForm).ConnectToClient;

            FCommonData.Updating := False;     // Form image is prepared now
            if SystemMenu <> nil then
              SystemMenu.UpdateGlyphs;

            SendToAdapter(Message);            // Sending message to all child adapted controls
            if BorderForm <> nil then
              BorderForm.UpdateExBordersPos;

            SendAMessage(Form.Handle, AC_UPDATEFLOATITEMS);
          end;
          SetClassLong(Form.Handle, GCL_HBRBACKGROUND, ACNativeInt(SkinData.SkinManager.Brushes[pcMainColor]));
          if FFormState and FS_GLASSNEEDED <> 0 then
            FSystemBlur.UpdateBlurMode;
        end;
      end;

    AC_CHILDCHANGED: with FCommonData, CommonSkinData do begin
      if gd[SkinIndex].Props[0].GradientPercent + gd[SkinIndex].Props[0].ImagePercent > 0 then
        Message.LParam := 1
      else
        Message.LParam := LPARAM((gd[SkinIndex].BorderIndex >= 0) and (ma[gd[SkinIndex].BorderIndex].DrawMode and BDM_FILL <> 0));

      Message.Result := Message.LParam;
      Result := True;
    end;

    AC_GETCONTROLCOLOR: begin
      Message.Result := GetBGColor(SkinData, 0);
      Result := True;
    end;

    AC_KILLTIMERS: begin
      OldWndProc(Message);
      AlphaBroadCast(Form, Message);
      Result := True;
    end;

    AC_GETPROVIDER: begin
      Message.Result := LRESULT(Self);
      Result := True;
    end; // Used for menuline init

    AC_SETNEWSKIN:
      if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
        DeleteUnusedBmps(True);
        FCommonData.UpdateIndexes;
        FreeAndNil(UWPTemplates[False]);
        FreeAndNil(UWPTemplates[True]);
        FTitleSkinIndex := -1;
        InitIndexes;
        if TempBmp <> nil then begin
          TempBmp.Height := 0;
          TempBmp.Width  := 0;
        end;
        if SkinData.SkinManager <> nil then begin
          UpdateIconsIndexes;
          DeleteUnusedBmps(True);
          CheckSysMenu(CanDrawNCArea);
{$IFNDEF FPC}
          SkinData.SkinManager.SkinableMenus.UpdateMenus;
{$ENDIF}
          // Menu Line refresh
          FCommonData.BGChanged := True;
          FLinesCount := -1;
          UpdateTitleBar;

          if TForm(Form).FormStyle = fsMDIForm then
            HookMDI;
        end;
        if Assigned(FTitleBar) then
          for i := 0 to FTitleBar.Items.Count - 1 do
            if FTitleBar.Items[i].Timer <> nil then
              FreeAndNil(FTitleBar.Items[i].Timer);
      end;

    AC_PREPARECACHE:
      if not SkinIsChanging(SkinData) and FCommonData.BGChanged and not FCommonData.FUpdating then begin
        PaintAll;
        if SkinData.BGChanged and ((csCreating in Form.ControlState) or (FormState and (FS_BLENDMOVING or FS_ANIMCLOSING) <> 0) or (SkinData.SkinIndex < 0)) then
          SkinData.BGChanged := False;
      end
      else
        Message.Result := -2; // Do not handle

    AC_MOUSELEAVE: begin
      SetHotHT(-1);
      biClicked := False;
    end;

    AC_BEFORESCROLL:
      if FCommonData.RepaintIfMoved then
        Form.Perform(WM_SETREDRAW, 0, 0);

    AC_AFTERSCROLL:
      if FCommonData.RepaintIfMoved then begin
        Form.Perform(WM_SETREDRAW, 1, 0);
        RedrawWindow(Form.Handle, nil, 0, RDWA_ALLNOW);
        if MDISkinProvider = Self then
          RedrawWindow(Form.ClientHandle, nil, 0, RDW_UPDATENOW or RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_FRAME);
      end;
  end;
end;


procedure TsSkinProvider.AC_CMShowingChanged(var Message: TMessage);
var
  i: integer;
  X: integer;
  M: TMessage;
{$IFNDEF NOWNDANIMATION}
  lInted: boolean;
{$ENDIF}
begin
  if FormState and FS_RECREATING = 0 then
    if (CanDrawNCArea or (Form.BorderStyle = bsNone)) and FDrawClientArea then begin // If first showing
      if Form.Showing then begin
        if FFormState and FS_GLASSNEEDED <> 0 then
          FSystemBlur.UpdateBlurMode;

        if Assigned(SkinData.SkinManager) then begin
          {$IFDEF D2010} if (Form.ClassName <> 'TMessageForm') then{$ENDIF}
          if AllowScale and not (SkinData.SkinManager.Options.ScaleMode in [smOldMode, smVCL]) and not (csDesigning in SkinData.SkinManager.ComponentState) then
            SkinData.SkinManager.UpdateScale(Form);

          if SkinData.SkinManager.UpdateFontName(Form){, SkinData.DefFontHeight} then begin
            M := MakeMessage(SM_ALPHACMD, MakeWParam(0, AC_FONTSCHANGED), LPARAM(SkinData.SkinManager), 0);
            AlphaBroadCast(Form, M);
          end;
        end;

        if Form.FormStyle = fsMDIChild then begin
          if Adapter <> nil then
            TacCtrlAdapter(Adapter).AddAllItems(Form);

          OldWndProc(Message);
          RefreshFormScrolls(Self, ListSW, False);
          if Form.WindowState = wsMaximized then
            UpdateMainForm;

          Exit;
        end;

        if Form.FormStyle = fsMDIForm then
          HookMDI;

        InitDwm(Form.Handle, CanDrawNCArea);
        FormState := FormState and not FS_ANIMCLOSING;
        if BorderForm <> nil then
          BorderForm.ExBorderShowing := False;

        if (FormTimer <> nil) and (FormTimer is TacMinTimer) then
          FreeAndNil(FormTimer);
{$IFNDEF DISABLEPREVIEWMODE}
        if acPreviewNeeded and Form.HandleAllocated and ((Application.MainForm = nil) or (Application.MainForm = Form)) then
          TrySayHelloToEditor(Form.Handle);
{$ENDIF}
        TryInitMenu;
        if Adapter <> nil then
          TacCtrlAdapter(Adapter).AddAllItems(Form);

{$IFNDEF NOWNDANIMATION}

        fAnimating := FAllowAnimation and ((Form.FormStyle = fsMDIChild) or (Form.Parent = nil)) and
                      SkinData.SkinManager.Effects.AllowAnimation and
                      SkinData.SkinManager.AnimEffects.FormShow.Active{$IFNDEF DISABLEPREVIEWMODE} and (acPreviewHandle <> Form.Handle){$ENDIF};

        lInted := False;
  {$IFDEF DELPHI7UP}
        if Form.AlphaBlend then
          X := Form.AlphaBlendValue
        else
  {$ENDIF}
          X := MaxByte;

        if fAnimating then begin
          FCommonData.Updating := True; // Don't draw child controls
          FInAnimation := True;
          lInted := DoLayered(Form.Handle, True, 0);
          if lInted then begin
            if BorderForm = nil then
              FillArOR(Self);

            if Form.WindowState <> wsMaximized then
              UpdateRgn(Self, False);

            RgnChanging := False;
  {$IFDEF DELPHI7UP}
          end
          else begin
  //          X := Form.AlphaBlendValue;
  //          Form.AlphaBlendValue := 0;
  {$ENDIF}
          end;
//          for i := 0 to Form.ControlCount - 1 do
//            if Form.Controls[i].Visible and not (Form.Controls[i] is TCoolBar) then {TCoolBar must have Painting processed for buttons aligning}
//              Form.Controls[i].Perform(WM_SETREDRAW, 0, 0);
        end
        else

{$ENDIF} // NOWNDANIMATION
        begin
          SkinData.Updating := False;
          if (Form.WindowState <> wsMaximized) and (Form.BorderStyle = bsNone) and (SkinData.SkinManager.gd[SkinData.SkinIndex].BorderRadius > 0) then begin
            FillArOR(Self);
            UpdateRgn(Self, False);
          end;
        end;

        InitExBorders(SkinData.SkinManager.ExtendedBorders);
        if fAnimating then
          FormState := FormState or FS_ANIMSHOWING;

        OldWndProc(Message);

        if fAnimating then
          FormState := FormState and not FS_ANIMSHOWING;
{$IFNDEF NOWNDANIMATION}
        if not SkinData.Skinned then // Check if form is not skinned already
          if fAnimating then begin
//            for i := 0 to Form.ControlCount - 1 do
//              if Form.Controls[i].Visible and not (Form.Controls[i] is TCoolBar) then // Some controls may be hidden in OldWndProc
//                Form.Controls[i].Perform(WM_SETREDRAW, 1, 0);

            while SetWindowLong(Form.Handle, GWL_EXSTYLE, GetWindowLong(Form.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED) = 0 do;
            RedrawWindow(Form.Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE);
            RgnChanging := False;
            Exit;
          end;
{$ENDIF}

{$IFDEF DELPHI7UP}
        if X <> MaxByte then
          X := Form.AlphaBlendValue;
{$ENDIF}
        RefreshFormScrolls(Self, ListSW, False);
{$IFNDEF NOWNDANIMATION}
        if fAnimating then begin
//          for i := 0 to Form.ControlCount - 1 do
//            if Form.Controls[i].Visible {// Desc 4} and not (Form.Controls[i] is TCoolBar) then
//              Form.Controls[i].Perform(WM_SETREDRAW, 1, 0);

          if lInted then
            DoLayered(Form.Handle, False);

          fAnimating := False;
          AnimShowForm(Self, SkinData.SkinManager.AnimEffects.FormShow.Time, X, SkinData.SkinManager.AnimEffects.FormShow.Mode);
          if BorderForm = nil then
            UpdateRgn(Self, False);

          RgnChanging := False;
        end
        else
{$ENDIF}
        begin
          SetParentUpdated(Form);
          if BorderForm <> nil then
            RgnChanged := True; // Avoiding of the empty form problem

          RedrawWindow(Form.Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE);
        end;
        LastClientRect := MkRect(Form.ClientWidth, Form.ClientHeight);
      end
      else begin // If not Form.Showing
        if BorderForm <> nil then
          if ((not SkinData.SkinManager.AnimEffects.FormHide.Active or
                (SkinData.SkinManager.AnimEffects.FormHide.Time = 0)) or
                  not FAllowAnimation or not SkinData.SkinManager.Effects.AllowAnimation) then
            FreeAndNil(BorderForm)
          else begin
            // Preparing for a hiding animation
            FormState := FormState or FS_ANIMCLOSING;
            SkinData.FCacheBmp := GetFormImage(Self, True);
            FormState := FormState and not FS_ANIMCLOSING;
            SkinData.BGChanged := False; // Do not update cache
            if (BorderForm.AForm <> nil) and (BorderForm.AForm.HandleAllocated) then begin
{$IFDEF DELPHI7UP}
              if Form.AlphaBlend then
                i := Form.AlphaBlendValue
              else
{$ENDIF}
                i := MaxByte;

              SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False);
              SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, i);
              SetWindowPos(BorderForm.AForm.Handle, 0, BorderForm.AForm.Left, BorderForm.AForm.Top, 0, 0, SWPA_SHOWZORDERONLY);
            end;
          end;

        OldWndProc(Message);
      end;
    end
    else begin // Backgrounds must be drawn by all controls for a blinking prevent
      if FDrawClientArea and Form.Showing then begin
        if (Adapter <> nil) then
          TacCtrlAdapter(Adapter).AddAllItems(Form);

        if Assigned(SkinData.SkinManager) then begin
          {$IFDEF D2010} if (Form.ClassName <> 'TMessageForm') then{$ENDIF}
          if AllowScale and not (SkinData.SkinManager.Options.ScaleMode in [smOldMode, smVCL]) and not (csDesigning in SkinData.SkinManager.ComponentState) then
            SkinData.SkinManager.UpdateScale(Form);

          if SkinData.SkinManager.UpdateFontName(Form){, SkinData.DefFontHeight} then begin
            M := MakeMessage(SM_ALPHACMD, MakeWParam(0, AC_FONTSCHANGED), LPARAM(SkinData.SkinManager), 0);
            AlphaBroadCast(Form, M);
          end;
        end;
      end;

      OldWndProc(Message);
      if AeroIsEnabled and Form.Showing then
        Form.Perform(WM_SETREDRAW, 1, 0);

      SkinData.Updating := False;
      if AeroIsEnabled then
        if not RedrawWindow(Form.Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_UPDATENOW) then
          CheckLastError;
    end
  else
    OldWndProc(Message);
end;


procedure TsSkinProvider.AC_CMShowingChanged_Unskinned(var Message: TMessage);
var
  i: integer;
begin
//  if not (csDestroying in Form.ComponentState) then
  begin
    if CanDrawNCArea and not Application.Terminated and Form.HandleAllocated then // If first showing
      if (Message.WParam = 0) and (SkinData.SkinManager <> nil) and SkinData.SkinManager.IsActive then
        if not IsIconic(Form.Handle) then begin
          if SkinData.SkinManager.ShowState <> saMinimize then // Closing
            if FAllowAnimation and SkinData.SkinManager.AnimEffects.FormHide.Active and
                 SkinData.SkinManager.Effects.AllowAnimation and
                   (FormState and FS_ANIMCLOSING = 0) and
                     (Form.Parent = nil) then begin

              // Preparing for a hiding animation
              FormState := FormState or FS_ANIMCLOSING;
              if BorderForm <> nil then begin
                BorderForm.ExBorderShowing := True;
    {$IFDEF DELPHI7UP}
                if Form.AlphaBlend then
                  i := Form.AlphaBlendValue
                else
    {$ENDIF}
                  i := MaxByte;

                SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False);
                SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, i);
                SetWindowPos(BorderForm.AForm.Handle, 0, BorderForm.AForm.Left, BorderForm.AForm.Top, 0, 0, SWPA_SHOWZORDERONLY);
              end
              else
                if Form.Parent = nil then begin
                  FreeAndNil(CoverForm);
                  CoverForm := MakeCoverForm(Form.Handle);
                end;
            end;
        end
        // If minimized by Aero shake, but wnd is visible still
        else
          if (Form.WindowState <> wsMinimized) and (TWindowPos(TWMWindowPosChanged(Message).WindowPos^).x = -32000) then begin
            OldWndProc(TMessage(Message));
            Form.WindowState := wsMinimized;
            StartMinimizing(Self);
          end;
  end;
end;


procedure TsSkinProvider.AC_WMShowWindow(var Message: TMessage);
var
  i: integer;
begin
  if Form.FormStyle <> fsMDIChild then begin
    if Message.WParam = 1 then begin
      // Updating ExBorders after minimizing by system
      SkipAnimation := False;
      RgnChanged := True;
      if BorderForm <> nil then
        BorderForm.ExBorderShowing := False;

      FormState := FormState and not FS_ANIMRESTORING;
      // RedrawUnder Aero
      if AeroIsEnabled then
        if not InAnimationProcess and (GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0) then
          RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_ALLCHILDREN or RDW_INVALIDATE);
    end;
    // else hiding
    case TWMShowWindow(Message).Status of
      SW_PARENTCLOSING:
        if ShowAction <> saIgnore then
          if IsIconic(Form.Handle) then
            ShowAction := saMinimize
          else
            if IsZoomed(Form.Handle) then
              ShowAction := saMaximize
            else
              ShowAction := saRestore;

      SW_PARENTOPENING:
        if SkinData.SkinManager.AnimEffects.Minimizing.Active and (Application.MainForm = Form) then begin // Restore
          OldWndProc(Message);
          Exit;
        end;
    end;
  end;
  OldWndProc(Message);
  if Message.WParam = 1 then begin
    if (Form.FormStyle = fsMDIChild) and (Form.WindowState = wsMaximized) then
      TsSkinProvider(MDISkinProvider).RepaintMenu;

    if Form.FormStyle = fsMDIForm then
      for i := 0 to Form.MDIChildCount - 1 do
        if not WndIsSkinned(Form.MDIChildren[i].Handle) then
          AddSupportedForm(Form.MDIChildren[i].Handle);

    if (Form.Parent <> nil) and (Form.FormStyle <> fsMDIChild) then
      FCommonData.BGChanged := True;

    if IsWindowVisible(Form.Handle) then
    	SetWindowPos(Form.Handle, 0, 0, 0, 0, 0, SWPA_NOCOPYBITS);
  end;
end;


procedure TsSkinProvider.AC_WMExitSizeMove(var Message: TMessage);
var
  i: integer;
begin
  OldWndProc(Message);
  if (BorderForm <> nil) and (acSupportedList <> nil) then
    for i := 0 to acSupportedList.Count - 1 do
      if acSupportedList[i] <> nil then begin
        if (TacProvider(acSupportedList[i]).CtrlHandle = 0) then
          if TacProvider(acSupportedList[i]).sp <> nil then
            TacProvider(acSupportedList[i]).CtrlHandle := TacProvider(acSupportedList[i]).sp.Form.Handle;

        SendAMessage(TacProvider(acSupportedList[i]).CtrlHandle, AC_INVALIDATE); // Update of some popup Dlgs
      end;
end;


procedure TsSkinProvider.AC_WMSetIcon(var Message: TMessage);
begin
  if not (csLoading in ComponentState) and (Message.LParam <> 0) and not InAnimationProcess and Form.Showing and (FormState and FS_RECREATING = 0) then begin
    if not AeroIsEnabled then begin
      Form.Perform(WM_SETREDRAW, 0, 0);
      OldWndProc(Message);
      Form.Perform(WM_SETREDRAW, 1, 0);
    end
    else
      OldWndProc(Message);

    UpdateSkinCaption(Self);
  end
  else
    OldWndProc(Message);
end;


{$IFNDEF NOWNDANIMATION}
procedure TsSkinProvider.AC_CMVisibleChanged_Unskinned(var Message: TMessage);
var
  i: integer;
begin
  if not (csDestroying in Form.ComponentState) and not Application.Terminated then begin
    if Assigned(SkinData.SkinManager) then begin
      if (Message.WParam = 1) and AllowScale and not (csDesigning in SkinData.SkinManager.ComponentState) {$IFDEF D2010}and (Form.ClassName <> 'TMessageForm'){$ENDIF} then
        SkinData.SkinManager.UpdateScale(Form);

      if not (csDestroying in SkinData.SkinManager.ComponentState) then
        Exit;
    end;
    if CanDrawNCArea and Form.HandleAllocated then // If first showing
      if (Message.WParam = 0) and (SkinData.SkinManager <> nil) and SkinData.SkinManager.IsActive then
        if not IsIconic(Form.Handle) then begin
          if SkinData.SkinManager.ShowState <> saMinimize then // Closing
            if FAllowAnimation and SkinData.SkinManager.AnimEffects.FormHide.Active and
                 SkinData.SkinManager.Effects.AllowAnimation and
                   (FormState and FS_ANIMCLOSING = 0) and
                     (Form.Parent = nil) then begin

              // Preparing for a hiding animation
              FormState := FormState or FS_ANIMCLOSING;
              if BorderForm <> nil then begin
                BorderForm.ExBorderShowing := True;
    {$IFDEF DELPHI7UP}
                if Form.AlphaBlend then
                  i := Form.AlphaBlendValue
                else
    {$ENDIF}
                  i := MaxByte;

                SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False);
                SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, i);
                SetWindowPos(BorderForm.AForm.Handle, 0, BorderForm.AForm.Left, BorderForm.AForm.Top, 0, 0, SWPA_SHOWZORDERONLY);
              end
              else
                if Form.Parent = nil then begin
                  FreeAndNil(CoverForm);
                  CoverForm := MakeCoverForm(Form.Handle);
                end;
            end;
        end
        // If minimized by Aero shake, but wnd is visible still
        else
          if (Form.WindowState <> wsMinimized) and (TWindowPos(TWMWindowPosChanged(Message).WindowPos^).x = -32000) then begin
            OldWndProc(TMessage(Message));
            Form.WindowState := wsMinimized;
            StartMinimizing(Self);
          end;
  end;
end;


procedure TsSkinProvider.AC_WMWindowPosChanged_Unskinned(var Message: TWMWindowPosChanged);
begin
  if Assigned(SkinData.SkinManager) and acLayered then // Patch for BDS
    if (TWMWindowPosChanged(Message).WindowPos.Flags and SWP_HIDEWINDOW <> 0) {$IFDEF D2011} and not Application.Terminated{$ENDIF} then
      if FAllowAnimation and
           not IsIconic(Form.Handle) and
             not SkipAnimation and
               SkinData.SkinManager.Active and
                 CanDrawNCArea and
                   SkinData.SkinManager.Effects.AllowAnimation and
                     SkinData.SkinManager.AnimEffects.FormHide.Active and
                       (SkinData.SkinManager.AnimEffects.FormHide.Time > 0) then begin
        acHideTimer := nil;
        SkipAnimation := True;
        AnimHideForm(Self, SkinData.SkinManager.AnimEffects.FormHide.Time, SkinData.SkinManager.AnimEffects.FormHide.Mode);
        while InAnimationProcess do
          Continue;

        DoLayered(Form.Handle, False);
        SkipAnimation := False;
      end
end;


procedure TsSkinProvider.AC_WMClose(var Message: TMessage);
var
  i: integer;
begin
  if FAllowAnimation and
       SkinData.SkinManager.AnimEffects.FormHide.Active and
         SkinData.SkinManager.Effects.AllowAnimation and
           CanDrawNCArea and
             (FormState and FS_ANIMCLOSING = 0) and
               (Form.Parent = nil) then begin
    OldWndProc(Message);
    if not (csDestroying in Form.ComponentState) then begin // Sometimes form may be destroyed already
      // Preparing for a hiding animation
      FormState := FormState or FS_ANIMCLOSING;
      SkinData.FCacheBmp := GetFormImage(Self, True {old SkinData.FCacheBmp is destroyed});
      FormState := FormState and not FS_ANIMCLOSING;
      SkinData.BGChanged := Assigned(Form.OnCloseQuery);// Update BG if closing was cancelled
      if (BorderForm <> nil) and (BorderForm.AForm <> nil) and (BorderForm.AForm.HandleAllocated) then begin
  {$IFDEF DELPHI7UP}
        if Form.AlphaBlend then
          i := Form.AlphaBlendValue
        else
  {$ENDIF}
          i := MaxByte;

        SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False);
        SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, i);
        SetWindowPos(BorderForm.AForm.Handle, 0, BorderForm.AForm.Left, BorderForm.AForm.Top, 0, 0, SWPA_SHOWZORDERONLY);
      end;
    end;
  end
  else
    OldWndProc(Message);
end;
{$ENDIF} // NOWNDANIMATION


procedure TsSkinProvider.AC_WMSysCommand(var Message: TMessage);
var
  i: integer;
  UpdateClient: boolean;
{$IFNDEF NOWNDANIMATION}
  bAnim: boolean;
{$ENDIF}
begin
  if Form.FormStyle <> fsMDIChild then
    case Message.WParamLo of
      SC_DRAGMOVE:
        Form.Repaint; // Faster switching between a forms (avoid of system delay)

{$IFNDEF NOWNDANIMATION}
      SC_MAXIMIZE: begin
        MaxRestore := False;
        if (BorderForm <> nil) then
          if not ExtBordersNeeded(Self, True) then
            FreeAndNil(BorderForm);

        if (Form.Parent = nil) and (FormTimer <> nil) and TacMinTimer(FormTimer).Minimized then begin
          FormState := FormState or FS_ZOOMING;
          bAnim := acGetAnimation;
          acSetAnimation(False);

          StartRestoring(Self);
          OldWndProc(Message);
          acSetAnimation(bAnim);
          FormState := FormState and not FS_ZOOMING;
          Exit;
        end;
        UWPCaptionUpdate(True);
      end;

      SC_MINIMIZE: begin
        UWPCaptionUpdate(False);
        MaxRestore := IsZoomed(Form.Handle);
        if (Form <> Application.MainForm) and SkinData.SkinManager.AnimEffects.Minimizing.Active then begin
          bAnim := acGetAnimation;
          acSetAnimation(False);
          StartMinimizing(Self);
          OldWndProc(Message);
          acSetAnimation(bAnim);
          Exit;
        end;
      end;

      SC_RESTORE: begin
        if FormState and FS_ANIMCLOSING <> 0 then begin // If all windows were hidden
          FormState := FormState or FS_RESTORING;
          FormState := FormState and not FS_ANIMCLOSING;
          if BorderForm <> nil then
            BorderForm.ExBorderShowing := False;

          bAnim := acGetAnimation;
          acSetAnimation(False);
          OldWndProc(Message);
          acSetAnimation(bAnim);
          FormState := FormState and not FS_RESTORING;
          Exit;
        end
        else
          if {$IFDEF D2007}Application.MainFormOnTaskBar or {$ENDIF} (Form <> Application.MainForm) then
            if IsIconic(Form.Handle) then begin
              FormState := FormState or FS_RESTORING;
              if (FormTimer <> nil) and TacMinTimer(FormTimer).Minimized then
                bAnim := acGetAnimation
              else begin // If was minimized without animation (Win+D)
                bAnim := False;
                if (FormTimer <> nil) then begin
                  TacMinTimer(FormTimer).Minimized := True;
                  if TacMinTimer(FormTimer).AnimForm = nil then
                    TacMinTimer(FormTimer).InitData;
                end;
              end;
              acSetAnimation(False);
              RgnChanged := True;
              StartRestoring(Self);
              SkinData.BGChanged := True;
              if SkinData.SkinManager.Options.NativeBordersMaximized and MaxRestore and (BorderForm <> nil) then
                FreeAndNil(BorderForm);

              OldWndProc(Message);
              if (BorderForm <> nil) and (BorderForm.AForm = nil) then begin
                FInAnimation := False;
                BorderForm.UpdateExBordersPos;
              end;
              acSetAnimation(bAnim);
              FormState := FormState and not FS_RESTORING;
              Exit;
            end
            else
              if (BorderForm <> nil) and (BorderForm.AForm = nil) or (BorderForm = nil) and ExtBordersNeeded(Self) then begin
                if BorderForm <> nil then
                  FreeAndNil(BorderForm);

                InitExBorders(True);
                UpdateRgn(Self, False);
              end;

        MaxRestore := False;
      end
  {$IFDEF D2005}
      else
        if {$IFDEF D2007} Application.MainFormOnTaskBar and {$ENDIF} (Form = Application.MainForm) and IsIconic(Form.Handle) and (Form.Parent = nil) then
          if FormTimer <> nil then begin
            SendMessage(Application.Handle, Message.Msg, Message.WParam, Message.LParam);
            Exit;
          end
          else
            if (BorderForm = nil) and AeroIsEnabled then begin
              OldWndProc(Message);
              RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
              InvalidateRect(Form.Handle, nil, True);
              Exit;
            end;
  {$ENDIF} // D2005
{$ENDIF} // NOWNDANIMATION
    end;

  if (ResizeMode = rmBorder) and Form.Enabled and not bInProcess then
    if $FFF0 and Message.WParam = SC_MOVE then begin         // Move section
      SetCapture(Form.handle);
      bCapture := True;
      bMode := True;
    end
    else
      if $FFF0 and Message.WParam = SC_SIZE then begin    // Size section
        SetCapture(Form.handle);
        nDirection := 0;
        bCapture := True;
        bMode := False;
      end;

  case Form.FormStyle of
    fsMDIChild: begin
      UpdateClient := (Form.WindowState = wsMaximized) and (Message.WParam <> SC_MAXIMIZE) and (Form.WindowState <> wsNormal);
      if UpdateClient and (MDISkinProvider <> nil) then
        TsSkinProvider(MDISkinProvider).FCommonData.BeginUpdate; // Speed rising

      case $FFF0 and Message.WParam of
        SC_CLOSE:
          if MDISkinProvider <> nil then begin
            if Assigned(TsSkinProvider(MDISkinProvider).MDIForm) and UpdateClient then
              UpdateMainForm; // If CloseQuery used then must be repainted before

            TsSkinProvider(MDISkinProvider).InMenu := True;
            OldWndProc(Message);
            if not (csDestroying in Form.ComponentState) and not (csDestroying in ComponentState) then
              SetHotHT(0, False);

            TsSkinProvider(MDISkinProvider).InMenu := False;
            if Assigned(TsSkinProvider(MDISkinProvider).MDIForm) then
              if UpdateClient then
                UpdateMainForm;

            Exit;
          end;

        SC_KEYMENU:
          ;

        SC_RESTORE: begin
          if Form.WindowState = wsMinimized then
            UpdateClient := True;

          if MDICreating then
            Exit;

          OldWndProc(Message);
          SkinData.BGChanged := True;
          if CanDrawNCArea then
            SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) and not WS_SYSMENU);

          RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_ERASE or RDW_INVALIDATE or RDW_UPDATENOW);
          // Updating of childs
          if MDISkinProvider <> nil then
            for i := 0 to TsSkinProvider(MDISkinProvider).Form.MDIChildCount - 1 do
              if TsSkinProvider(MDISkinProvider).Form.MDIChildren[i] <> Form then begin
                if TsSkinProvider(MDISkinProvider).Form.MDIChildren[i].WindowState = wsMaximized then
                  TsSkinProvider(MDISkinProvider).Form.MDIChildren[i].WindowState := wsNormal;

                RedrawWindow(TsSkinProvider(MDISkinProvider).Form.MDIChildren[i].Handle, nil, 0, RDW_FRAME or RDW_INTERNALPAINT or RDW_ERASE or RDW_UPDATENOW);
              end;

          if UpdateClient then
            UpdateMainForm;

          SystemMenu.UpdateItems(True);
          Exit;
        end;

        SC_MINIMIZE: begin
          OldWndProc(Message);
          if UpdateClient then
            UpdateMainForm;

          SystemMenu.UpdateItems(True);
          FCommonData.BGChanged := True;
          UpdateMainForm;
          Exit;
        end;

        SC_MAXIMIZE: begin
          ChildProvider := Self;
          SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) and not WS_VISIBLE);
          OldWndProc(Message);
          SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_VISIBLE);
          RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INTERNALPAINT or RDW_ERASE or RDW_UPDATENOW);
          if (MDISkinProvider <> nil) and Assigned(TsSkinProvider(MDISkinProvider).MDIForm) then
            UpdateMainForm;

          SystemMenu.UpdateItems(True);
          Exit;
        end

        else
          OldWndProc(Message);
      end;
      if MDISkinProvider <> nil then
        TsSkinProvider(MDISkinProvider).FCommonData.EndUpdate;
    end;

    fsMDIForm: begin
      case Message.WParam of
        SC_RESTORE:
          FormState := FormState or FS_RESTORING;
      end;
      OldWndProc(Message);
      case Message.WParam of
        SC_MAXIMIZE, SC_RESTORE, SC_MINIMIZE: begin
          TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
          TsSkinProvider(MDISkinProvider).FLinesCount := -1;
          TrySendMessage(Form.Handle, WM_NCPAINT, 0, 0);
          case Message.WParam of
            SC_MAXIMIZE:
              if BorderForm <> nil then
                if ExtBordersNeeded(Self, True) then
                  BorderForm.UpdateExBordersPos(True)
                else
                  FreeAndNil(BorderForm);

            SC_RESTORE:
              FormState := FormState and not FS_RESTORING;
          end;
          if (Message.WParam = SC_MAXIMIZE) and (BorderForm <> nil) then
            BorderForm.UpdateExBordersPos(True);
        end;
      end;
    end

    else begin
      case Message.WParam of
        SC_MAXIMIZE: begin
          if (BorderForm <> nil) and not ExtBordersNeeded(Self, True) then
            FreeAndNil(BorderForm);

          FormState := FormState or FS_ZOOMING;

          if ACHiddenMaximizing and (GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0) then begin
            SetWindowLong(Form.Handle, GWL_EXSTYLE, GetWindowLong(Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
            SetLayeredWindowAttributes(Form.Handle, clNone, 1, ULW_ALPHA);
            if (BorderForm <> nil) and (BorderForm.AForm <> nil) then begin
              FreeAndNil(BorderForm.AForm);
              BorderForm.ExBorderShowing := True;
            end;
            OldWndProc(Message);
            SetWindowLong(Form.Handle, GWL_EXSTYLE, GetWindowLong(Form.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
          end
          else
            OldWndProc(Message);

          FormState := FormState and not FS_ZOOMING;
          if SystemMenu.VisibleMax then
            CurrentHT := HTMAXBUTTON;

          SetHotHT(0);
        end;
      end;

      OldWndProc(Message);
      case Message.WParam of
        SC_KEYMENU:
          if (TWMSysCommand(Message).Key = VK_SPACE) and HaveSysMenu and HaveBorder(Self) then
            if IsIconic(Form.Handle) then
              DropSysMenu(FormLeftTop.x + SysBorderWidth(Form.Handle, BorderForm), FormLeftTop.y + BorderHeight + HeightOf(FIconRect, True) - 16)
            else
              DropSysMenu(FormLeftTop.x + SysBorderWidth(Form.Handle, BorderForm), FormLeftTop.y + BorderHeight + HeightOf(FIconRect, True));

        SC_RESTORE: begin
          if Message.WParam = SC_MAXIMIZE then
            FormState := FormState and not FS_ZOOMING
          else
            if (FormTimer <> nil) and TacMinTimer(FormTimer).Minimized then
              FreeAndNil(FormTimer); // Kill if not killed yet

          if SystemMenu.VisibleMax then
            CurrentHT := HTMAXBUTTON;

          SetHotHT(0);
          if Message.WParam = SC_RESTORE then begin
            FCommonData.BGChanged := True;
            if not HaveBorder(Self) then
              SetWindowRgn(Form.Handle, 0, True)
            else begin
              if (SkinData.SkinManager <> nil) and
                   SkinData.SkinManager.ExtendedBorders and
                     AllowExtBorders and
                       CanDrawNCArea and
                         (Form.Parent = nil) and
                           (Form.FormStyle <> fsMDIChild) then begin
                FInAnimation := False;
                if BorderForm <> nil then
                  BorderForm.UpdateExBordersPos
                else begin
                  InitExBorders(True);
                  UpdateRgn(Self, True, True);
                end;
              end;
              RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
            end;
          end;
        end;
      end;
    end;
  end;

  case Message.WParamLo of
    SC_MINIMIZE: begin
      if SkinData.SkinManager.AnimEffects.Minimizing.Active then
        fAnimating := False; // Reset if was defined in the StartMinAnimation

      if (BorderForm <> nil) and (BorderForm.AForm <> nil) then
        if FormState and FS_ANIMMINIMIZING = 0 then begin
          BorderForm.ExBorderShowing := True;
          FreeAndNil(BorderForm.AForm);
          BorderForm.ExBorderShowing := False;
        end;
    end;
  end;
end;


procedure TsSkinProvider.AC_WMSetText(var Message: TMessage);
begin
  if Form.HandleAllocated and IsWindowVisible(Form.Handle) and not (csCreating in Form.ControlState) and CanDrawNCArea then begin
    if Assigned(FGlow1) then
      FreeAndNil(FGlow1);

    if Assigned(FGlow2) then
      FreeAndNil(FGlow2);

    if (Form.FormStyle = fsMdiChild) and (Form.WindowState = wsMaximized) then begin
      TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
      MakeCaptForm(TsSkinProvider(MDISkinProvider));
      OldWndProc(Message);
      KillCaptForm(TsSkinProvider(MDISkinProvider));
    end
    else
      if not AeroIsEnabled then begin
        FCommonData.BGChanged := True;
        MakeCaptForm(Self);
        OldWndProc(Message);
        KillCaptForm(Self);
{$IFDEF DELPHI6UP}
  {$IFNDEF DELPHI7UP}
        if Form.AlphaBlend then
  {$ENDIF}
          ProcessMessage(WM_NCPAINT, 0, 0);
{$ENDIF}
      end
      else begin
        if BorderForm = nil then
          MakeCaptForm(Self);

        OldWndProc(Message);
        UpdateSkinCaption(Self);
        if BorderForm = nil then
          KillCaptForm(Self);
      end;

    if BorderForm <> nil then
      BorderForm.UpdateExBordersPos;
  end
  else
    OldWndProc(Message);
end;


procedure TsSkinProvider.AC_CMEnabledChanged(var Message: TMessage);
begin
  OldWndProc(Message);
  if CanDrawNCArea then begin
    if (BorderForm <> nil) and (BorderForm.AForm <> nil) then
      BorderForm.AForm.Enabled := Form.Enabled;

    if (DisabledBlendValue < MaxByte) or FDisabledBlured then begin
      if not Form.Enabled then
        FormState := FormState or FS_DISABLED
      else
        FormState := FormState and not FS_DISABLED;

      UpdateLayerForm;
    end;
    SkinData.BGChanged := True;
    ProcessMessage(WM_NCPAINT, 0, 0);
    if BorderForm <> nil then
      BorderForm.UpdateExBordersPos(True);
  end;
end;


procedure TsSkinProvider.AC_WMChildActivate(var Message: TMessage);
begin
  OldWndProc(Message);
  UpdateMenu;
  if (MDISkinProvider <> nil) and (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild <> nil) then
    if TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild.WindowState = wsMaximized then
      TsMDIForm(TsSkinProvider(MDISkinProvider).MDIForm).UpdateMDIIconItem // Repaint of main form icons and menus
    else
      CheckSysMenu(True); // Reinit of sysmenu
end;


procedure TsSkinProvider.AC_WMEnterMenuLoop(var Message: TMessage);
begin
  if (Form.FormStyle = fsMDIForm) and not InMenu and (Form.ActiveMDIChild <> nil) and (Form.ActiveMDIChild.WindowState = wsMaximized) then begin
    InMenu := True;
    if MDIIconsForm = nil then begin
      MDIIconsForm := TForm.Create(Application);
      MDIIconsForm.BorderStyle := bsNone;
      SetClassLong(MDIIconsForm.Handle, GCL_STYLE, GetClassLong(MDIIconsForm.Handle, GCL_STYLE) and not NCS_DROPSHADOW);
    end;
    with MDIIconsForm do begin
      Tag := ExceptTag;
      Visible := False;
      Name := 'acMDIIcons';
      OnPaint := MdiIcoFormPaint;
      SetWindowPos(Handle, 0, Form.BoundsRect.Right - 60 - SysBorderWidth(Form.Handle, BorderForm, False),
                   Form.Top + SysCaptHeight(Self) + SysBorderWidth(Form.Handle, BorderForm, False), 60,
                   GetSystemMetrics(SM_CYMENU) - 1 + 4, SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOREDRAW);
    end;
  end;
  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMStyleChanged(var Message: TMessage);
var
  bUpdateExBorders: boolean;
begin
  OldWndProc(Message);
  if (SystemMenu <> nil) and (SystemMenu.ItemClose <> nil) and (SystemMenu.ItemClose.Visible <> (biSystemMenu in Form.BorderIcons)) then begin
    SystemMenu.UpdateItems;
    UpdateSkinCaption(Self);
  end
  else
    if (Message.WParam = WParam(GWL_EXSTYLE)) and (FormState and FS_ANIMATING = 0) and CanDrawNCArea then begin
      if GetWindowLong(Form.Handle, GWL_STYLE) and WS_SYSMENU <> 0 then begin
        SkinData.BGChanged := True;
        UpdateIconsIndexes;
        if (BorderForm <> nil) or ExtBordersNeeded(Self) then
          bUpdateExBorders := True
        else begin
          SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) and not WS_SYSMENU);
          bUpdateExBorders := False;
        end
      end
      else
        bUpdateExBorders := ((PStyleStruct(Message.LParam)^.styleNew and WS_EX_LAYERED) <> (PStyleStruct(Message.LParam)^.styleOld and WS_EX_LAYERED)) and
             (BorderForm <> nil) and (FormState and FS_DISABLED = 0); { AlphaBlend is changed }

      if bUpdateExBorders then
        if BorderForm <> nil then
          BorderForm.UpdateExBordersPos
        else
          InitExBorders(SkinData.SkinManager.ExtendedBorders);
    end;
end;


procedure TsSkinProvider.AC_WMSetRedraw(var Message: TMessage);
begin
  if Message.WParam = 1 then
    LockCount := max(0, LockCount - 1)
  else
    inc(LockCount);

  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMMove(var Message: TMessage);
var
  bUpdating: boolean;
begin
  KillAnimations;
  if Form.BorderStyle <> bsNone then
    ClearGlows(False); // Hide a glow effect on a focused control if exists

  if (BorderForm = nil) and Form.Showing then begin
    if ExtBordersNeeded(Self) and not (csLoading in Form.ComponentState) and (FormState and FS_ANIMMINREST = 0) and not IsIconic(Form.Handle) then
      InitExBorders(True);

    if (SkinData.FCacheBmp <> nil) and (Form.Width <> SkinData.FCacheBmp.Width) and (Form.Width <> SkinData.FCacheBmp.Width) then begin
      bUpdating := SkinData.FUpdating;
      SkinData.FUpdating := True;
      OldWndProc(Message); // Desc 5
      SkinData.FUpdating := bUpdating;
    end
    else
      OldWndProc(Message);

    if (Form.Parent <> nil) and Form.Parent.HandleAllocated then
      RedrawWindow(Form.Parent.Handle, nil, 0, RDWA_FRAME);

    MoveGluedForms;
  end
  else
    OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMNCDestroy;
begin
  if (Form.FormStyle = fsMDIChild) and Assigned(MDISkinProvider) then
    with TsSkinProvider(MDISkinProvider) do
      if Assigned(MDIForm) and not (csDestroying in ComponentState) and  not (csDestroying in Form.ComponentState) and SkinData.Skinned(True) then begin
        RepaintMenu;
        if Form.ActiveMDIChild = nil then
          RedrawWindow(Form.ClientHandle, nil, 0, RDW_ERASE or RDW_FRAME or RDW_INTERNALPAINT or RDW_INVALIDATE or RDW_UPDATENOW);
      end;

  if (CoverForm <> nil) and ((acHideTimer = nil) or (TForm(acHideTimer.Form) <> Form)) then // Kill CoverForm if not nil and no animation
    FreeAndNil(CoverForm);
end;


procedure TsSkinProvider.AC_WMSysColorChange(var Message: TMessage);
begin
  OldWndProc(Message);
  UpdateMenu;
end;


procedure TsSkinProvider.AC_WMExitMenuLoop(var Message: TMessage);
begin
  InMenu := False;
  if Assigned(MDIIconsForm) then
    FreeAndNil(MDIIconsForm);

  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMNCHitTest(var Message: TMessage);
var
  i: integer;
  p: TPoint;
begin
  if RTInit then begin
    RTInit := False;
    LoadInit;
  end;
  if (CaptionHeight = 0) or not CanDrawNCArea then
    OldWndProc(Message)
  else begin
    Message.Result := HTProcess(TWMNCHitTest(Message));
    // Hide standard border icons
    if (Message.Result in [HTMAXBUTTON, HTCLOSE, HTMINBUTTON]) and (Form.FormStyle = fsMDIChild) then
      CheckSysMenu(True);

    if Message.Result in [Windows.HTCAPTION, Windows.HTNOWHERE, HTMENU, HTCLIENT, HTLEFT..HTBOTTOMRIGHT] then begin
      if not (Form.HandleAllocated and IsZoomed(Form.Handle)) or not (Message.Result in [HTLEFT..HTBOTTOMRIGHT]) then begin
        if IsGripVisible(Self) then begin
          i := FCommonData.CommonSkinData.GripRightBottom;
          if FCommonData.SkinManager.IsValidImgIndex(i) then begin
            p := CursorToPoint(TWMNCHitTest(Message).XPos, TWMNCHitTest(Message).YPos);
            if BorderForm <> nil then begin
              if (p.y > RBGripPoint(i).y - DiffTitle(Self.BorderForm) - ShadowSize.Top) and (p.x > RBGripPoint(i).x - DiffBorder(Self.BorderForm) - ShadowSize.Left) then begin
                Message.Result := HTBOTTOMRIGHT;
                Exit;
              end;
            end
            else
              if (p.y > RBGripPoint(i).y) and (p.x > RBGripPoint(i).x) then begin
                Message.Result := HTBOTTOMRIGHT;
                Exit;
              end;
          end;
        end;
        OldWndProc(Message);
      end
      else
        Message.Result := HTCLIENT;
    end
    else
      if (ResizeMode = rmBorder) and (nDirection = 0) and Form.Enabled and (Message.Result in [HTCAPTION, HTLEFT..HTBOTTOMRIGHT]) then
        nDirection := Message.Result;
  end;
end;

{$IFNDEF DISABLEPREVIEWMODE}
procedure TsSkinProvider.AC_WMCopyData(var Message: TWMCopyData);
begin
  OldWndProc(TMessage(Message));
  if (Message.Result = 0) and (acPreviewHandle = Form.Handle) and not acSkinPreviewUpdating then begin // SkinManager is upadated by SkinEditor (Preview mode)
    if (Message.CopyDataStruct <> nil) and (Message.From = ASE_HELLO) and (PacSkinEditorData(Message.CopyDataStruct^.lpData)^.Magic = ASE_MSG) then begin
      acSkinPreviewUpdating := True;
      CopyMemory(@DefaultManager.PreviewBuffer, PacSkinEditorData(Message.CopyDataStruct^.lpData), SizeOf(TacSkinEditorData));
      PostMessage(Application.{$IFNDEF FPC}Handle{$ELSE}MainFormHandle{$ENDIF}, SM_ALPHACMD, AC_COPYDATA shl 16, 0);
      acSkinPreviewUpdating := False;
      Message.Result := 1;
    end;
  end;
end;


procedure TsSkinProvider.AC_ASEMSG(var Message: TMessage);
begin
  case Message.WParam of
    ASE_HELLO: OldWndProc(Message);
    ASE_CLOSE: Form.Close;
    ASE_ALIVE: Message.Result := 1;
  end;
end;
{$ENDIF}

{$IFNDEF FPC}
procedure TsSkinProvider.AC_WMContextMenu(var Message: TMessage);
begin
  if Form.PopupMenu <> nil then
    SkinData.SkinManager.SkinableMenus.HookPopupMenu(Form.PopupMenu, SkinData.SkinManager.SkinnedPopups);

  OldWndProc(Message);
end;
{$ENDIF}


procedure TsSkinProvider.AC_WMNCLButtonDown(var Message: TWMNCLButtonDown);
var
  p: TPoint;
  lInted: boolean;
begin
  if CanDrawNCArea and not Application.Terminated then begin
{$IFNDEF ALITE}
    if GetIntController <> nil then
      GetIntController.KillAllForms(nil);
{$ENDIF}
    if (BorderForm <> nil) and (Message.HitTest = HTOBJECT) then begin
      OldWndProc(TMessage(Message));
      Exit;
    end;
    if (BorderForm <> nil) and (Message.HitTest = HTTRANSPARENT) then
      Message.HitTest := BorderForm.Ex_WMNCHitTest(TWMNCHitTest(Message));

    case Message.HitTest of
      HTCLOSE, HTMAXBUTTON, HTMINBUTTON, HTHELP, HTCHILDCLOSE..HTCHILDMIN: begin
        if Assigned(ChildProvider) then
          if (Message.HitTest = HTCHILDMIN) and (not ChildProvider.SystemMenu.EnabledMin or not ChildProvider.SystemMenu.EnabledRestore) then
            Exit;

        SetPressedHT(Message.HitTest);
      end;

      HTMENU:
        OldWndProc(TMessage(Message));

      HTSYSMENU: begin
        Message.Result := 0;
        OldWndProc(TMessage(Message));
        if Message.Result <> 0 then
          Exit;

        SetHotHT(0);
        biClicked := False;
{$IFNDEF FPC}
        if not SkinData.SkinManager.SkinnedPopups then begin // Check and Exit when DblClick and not SkinnedPopups
          Delay(200);
          if SkinData.FUpdating then
            Exit;
        end;
{$ENDIF}
        if Form.FormStyle = fsMDIChild then begin
          if Assigned(MDISkinProvider) then begin
            p := FormLeftTop;
            DropSysMenu(p.x, p.y + SysCaptHeight(Self) + 4 - integer(IsIconic(Form.Handle)) * 16)
          end;
        end
        else
          if SysRTLAllowed then
            DropSysMenu(Form.Left + Form.Width - (FormLeftTop.x + SysBorderWidth(Form.Handle, BorderForm, False) - Form.Left),
                        FormLeftTop.y + BorderHeight + HeightOf(FIconRect, True) + SysBorderHeight(Form.Handle, BorderForm, False))
          else
            DropSysMenu(FormLeftTop.x + SysBorderWidth(Form.Handle, BorderForm, False),
                        FormLeftTop.y + BorderHeight + HeightOf(FIconRect, True) + SysBorderHeight(Form.Handle, BorderForm, False));
      end
      else
        if BetWeen(Message.HitTest, HTUDBTN, HTUDBTN + TitleButtons.Count - 1) then begin
          SetPressedHT(Message.HitTest);
          TitleButtons.Items[Message.HitTest - HTUDBTN].MouseDown(Message.HitTest - HTUDBTN, mbLeft, [], Message.XCursor, Message.YCursor);
          HideHint(TitleButtons.Items[CurrentHT - HTUDBTN]);
        end
        else
          if BetWeen(Message.HitTest, HTITEM, HTITEM + MaxByte) then begin
            if Assigned(FTitleBar) then
              with FTitleBar.Items[Message.HitTest - HTITEM] do begin
{$IFNDEF ALITE}
                if acAlphaHints.Manager <> nil then
                  with TAccessAlphaHints(acAlphaHints.Manager) do
                    if HideTimer <> nil then
                      HideTimer.OnTimer(HideTimer);
{$ENDIF}
                FreeAndNil(FHintTimer);
                if Style <> bsTab then begin
                  if (Style <> bsMenu) or (DropdownMenu = nil) or (DropdownMenu.Items.Count = 0) then
                    SetPressedHT(Message.HitTest);
{$IFNDEF FPC}
                  if SkinData.SkinManager.SkinnedPopups then
                    if (Style in [bsMenu, bsButton]) and (DropDownMenu <> nil) then
                      SkinData.SkinManager.SkinableMenus.HookPopupMenu(DropDownMenu, True);
{$ENDIF}
                end;
                DoMouseDown(mbLeft, [], Message.XCursor, Message.YCursor);
                biClicked := FPressed;
              end;
          end
          else
            if IsIconic(Form.Handle) then
              Form.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0)
            else begin
              SetHotHT(0);
              if (Form.WindowState <> wsMaximized) or (CursorToPoint(0, Message.YCursor).y > SysBorderHeight(Form.Handle, BorderForm) + CaptionHeight) then begin
                SystemParametersInfo(SPI_GETDRAGFULLWINDOWS, 0, @lInted, 0);
                UpdateSlaveFormsList;
                if lInted then begin
                  if (ResizeMode = rmBorder) and Form.Enabled and not (Message.HitTest in [HTMENU]) then begin
                    // If caption pressed then activate form (standard procedure)
                    if Message.HitTest in [HTMENU, HTCAPTION] then
                      OldWndProc(TMessage(Message));

                    bMode := not (Message.HitTest in [HTRIGHT, HTLEFT, HTBOTTOM, HTTOP, HTTOPLEFT, HTTOPRIGHT, HTBOTTOMLEFT, HTBOTTOMRIGHT]);
                    p := Point(Message.XCursor, Message.YCursor);
                    TrySendMessage(Form.Handle, WM_SYSCOMMAND, iff(bMode, SC_MOVE, SC_SIZE), 0);
                    StartMove(p.X, p.Y);
                  end
                  else begin
{$IFNDEF NOWNDANIMATION}
                    if (Message.HitTest = HTCAPTION) and
                         (Form.FormStyle <> fsMDIChild) and
                           SkinData.SkinManager.AnimEffects.BlendOnMoving.Active and
                             not IsIconic(Form.Handle) and
                               not ((SkinData.SkinManager.AnimEffects.BlendOnMoving.BlendValue = MaxByte) or
                                 not AllowBlendOnMoving) then begin
                      StartMoveForm;
                      Exit;
                    end;
{$ENDIF}
                    OldWndProc(TMessage(Message));
                  end
                end
                else
                  OldWndProc(TMessage(Message));
              end
              else begin
                OldWndProc(TMessage(Message));
                if not Form.Active and Form.Enabled and Form.CanFocus then
                  Form.SetFocus; // Focusing if maximized
              end;
            end;
    end
  end
  else
    // Skinned sysmenu
    case Message.HitTest of
      HTSYSMENU: begin
        SetHotHT(0);
        biClicked := False;
        if Form.FormStyle = fsMDIChild then begin
          if Assigned(MDISkinProvider) then begin
            p := FormLeftTop;
            DropSysMenu(p.x, p.y + CaptionHeight + 4);
          end;
        end
        else
          DropSysMenu(FormLeftTop.x + SysBorderWidth(Form.Handle, BorderForm),
                      FormLeftTop.y + BorderHeight + HeightOf(FIconRect) + SysBorderHeight(Form.Handle, BorderForm, False));
      end
      else
        OldWndProc(TMessage(Message));
    end
end;


procedure TsSkinProvider.AC_WMMouseMove(var Message: TMessage);
var
  X, Y: integer;
  p: TPoint;
begin
  if not CommonWndProc(Message, SkinData) then
    OldWndProc(Message);

  SetHotHT(0);
  if (DefaultManager <> nil) and not (csDesigning in DefaultManager.ComponentState) then
    DefaultManager.ActiveControl := Form.Handle;//0;

  if (ResizeMode = rmBorder) and Form.Enabled then begin
    p := Form.ClientToScreen(Point(TWMMouseMove(Message).XPos, TWMMouseMove(Message).YPos));
    X := p.X;
    Y := p.Y;
    if bMode then begin // Move section
      if bCapture then
        bCapture := False;

      if bInProcess then begin
        DrawFormBorder(nLeft, nTop);
        nleft := nleft + (X - nX);
        ntop := nTop + (Y - nY);
        nY := Y;
        nX := X;
        DrawFormBorder(nLeft, nTop);
      end;
    end
    else begin
      // Size section
      if bCapture then begin
        nX := X;
        nY := Y;
        bCapture := False;
      end;
      if bInProcess then begin
        DrawFormBorder(0, 0);
        case nDirection of
          HTLEFT: begin
            nleft := Form.left + X - nX;
            if nright - nleft < nMinWidth then
              nleft := nright - nMinWidth;
          end;

          HTRIGHT: begin
            nright := Form.left + Form.width + X - nX;
            if nright - nleft < nMinWidth then
              nright := Form.left + nMinWidth;
          end;

          HTBOTTOM: begin
            nbottom := Form.top + Form.height + Y - nY;
            if nbottom - ntop < nMinHeight then
              nbottom := Form.top + nMinHeight;
          end;

          HTTOP: begin
            ntop := Form.top + Y - nY;
            if nbottom - ntop < nMinHeight then
              ntop := nbottom - nMinHeight;
          end;

          HTBOTTOMLEFT: begin
            nbottom := Form.top + Form.height + Y - nY;
            if nbottom - ntop < nMinHeight then
              nbottom := Form.top + nMinHeight;

            nleft := Form.left + X - nX;
            if nright - nleft < nMinWidth then
              nleft := nright - nMinWidth;
          end;

          HTTOPRIGHT: begin
            ntop := Form.top + Y - nY;
            if nbottom - ntop < nMinHeight then
              ntop := nbottom - nMinHeight;

            nright := Form.left + Form.width + X - nX;
            if nright - nleft < nMinWidth then
              nright := Form.left + nMinWidth;
          end;

          HTTOPLEFT: begin
            ntop := Form.top + Y - nY;
            if nbottom - ntop < nMinHeight then
              ntop := nbottom - nMinHeight;

            nleft := Form.left + X - nX;
            if nright - nleft < nMinWidth then
              nleft := nright - nMinWidth;
          end

          else begin
            nbottom := Form.top + Form.height + Y - nY;
            if nbottom - ntop < nMinHeight then
              nbottom := Form.top + nMinHeight;

            nright := Form.left + Form.width + X - nX;
            if nright - nleft < nMinWidth then
              nright := Form.left + nMinWidth;
          end;
        end;
        DrawFormBorder(0, 0);
      end;
    end;
  end;
end;


procedure TsSkinProvider.AC_WMSettingChange(var Message: TMessage);
begin
  FCommonData.BGChanged := True;
  if (Message.WParam = SPI_SETWORKAREA) and (FormTimer is TacMinTimer) then
    with TacMinTimer(FormTimer) do begin
      SkinData.BGChanged := True;
      UpdateDstRect;
      CurLeft   := RectTo.Left;
      CurTop    := RectTo.Top;
      CurRight  := RectTo.Right;
      CurBottom := RectTo.Bottom;
    end;

  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMNCRButtonDown(var Message: TWMNCRButtonDown);
var
  Item: TacTitleBarItem;
begin
  if not (Message.HitTest in [HTCAPTION, HTSYSMENU]) then begin
    if BetWeen(Message.HitTest, HTITEM, HTITEM + MaxByte) and Assigned(FTitleBar) then begin
      RightPressed := True;
      Item := FTitleBar.Items[Message.HitTest - HTITEM];
      if Assigned(Item.OnMouseDown) then
        Item.OnMouseDown(Item, mbRight, [], Message.XCursor, Message.YCursor);
    end
    else
      OldWndProc(TMessage(Message));
  end
  else
    RightPressed := True;
end;


procedure TsSkinProvider.AC_WMNCRButtonUp(var Message: TWMNCRButtonUp);
var
  Item: TacTitleBarItem;
begin
  if HaveBorder(Self) then begin
    if (BorderForm <> nil) and (Message.HitTest = HTTRANSPARENT) then
      Message.HitTest := BorderForm.Ex_WMNCHitTest(TWMNCHitTest(Message))
    else
      Message.HitTest := HTProcess(TWMNCHitTest(Message));

    case TWMNCLButtonUp(Message).HitTest of
      HTCAPTION, HTSYSMENU: begin
        if RightPressed then begin
          SetHotHT(0);
          biClicked := False;
          DropSysMenu(TWMNCLButtonUp(Message).XCursor, TWMNCLButtonUp(Message).YCursor);
        end
      end

      else
        if BetWeen(Message.HitTest, HTITEM, HTITEM + MaxByte) then
          if Assigned(FTitleBar) then begin
            Item := FTitleBar.Items[Message.HitTest - HTITEM];
            Item.DoMouseUp(mbRight, [], Message.XCursor, Message.YCursor);
          end;
    end;
  end
  else
    OldWndProc(TMessage(Message));

  RightPressed := False;
end;


procedure TsSkinProvider.AC_WMSizing(var Message: TMessage);
begin
  OldWndProc(Message);
  if BorderForm <> nil then
    BorderForm.UpdateExBordersPos(False);
end;


procedure TsSkinProvider.AC_WMMouseLeave(var Message: TMessage);
begin
  // If not title bar items (solves a problem with tabs hovering)
  if (CurrentHT < HTITEM) or (BorderForm = nil) then
    SetHotHT(-1);

  biClicked := False;
  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_CMMouseEnter(var Message: TMessage);
begin
  // If not title bar items (solves a problem with tabs hovering)
  if BorderForm <> nil then
    SetHotHT(-1);

  biClicked := False;
  OldWndProc(Message);
  FCommonData.SkinManager.ActiveControl := Form.Handle;
  if (BorderForm <> nil) and BorderForm.ResetRgn and (FormState and FS_SIZING = 0) then
    BorderForm.UpdateRgn;
end;


procedure TsSkinProvider.AC_WMNCCreate(var Message: TMessage);
var
  Rgn: hrgn;
begin
  if (SkinData.SkinManager = nil) or (SkinData.SkinManager.Options.ScaleMode = smVCL) then
    EnableNCDpiScaling(Form.Handle);

  OldWndProc(Message);
  if not RTInit then begin
    if Form.FormStyle <> fsMDIChild { Solving the problem with menu } then
      PrepareForm;

    if (Form.BorderStyle = bsNone) and (SkinData.SkinManager.gd[SkinData.SkinIndex].BorderRadius <= 0) then begin
      Rgn := 0;
      if GetWindowRgn(Form.Handle, Rgn) <> NULLREGION then
        SetWindowRgn(Form.Handle, 0, False);
    end
    else
      if CanDrawNCArea then begin
        if SkinData.BGChanged and (BorderForm = nil) and (Form.BorderStyle <> bsNone) and not UWPMode then begin
          PaintAll;
          FillArOR(Self);
        end;
        UpdateRgn(Self, False);
      end;
  end;
end;


procedure TsSkinProvider.AC_CMFloat(var Message: TMessage);
begin
  OldWndProc(Message);
  if ListSW <> nil then
    FreeAndNil(ListSW);

  SendAMessage(Form.Handle, AC_REFRESH, Cardinal(SkinData.SkinManager));
end;


procedure TsSkinProvider.AC_CMMenuChanged(var Message: TMessage);
begin
  if not (fsCreating in Form.FormState) and Form.Visible and not InAnimation(Self) then
    if SkinData.CtrlSkinState and ACS_LOCKED = 0 then begin
      FLinesCount := -1;
      MenuChanged := True; // Menu may be invisible after form opening ????
      if (Form.Menu <> nil) and (Form.Menu.BidiMode = bdLeftToRight) then
        FCommonData.BGChanged := True;
    end;

  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMPrint(var Message: TMessage);
var
  DC, SavedDC: hdc;
  i: integer;
  cR: TRect;
begin
  if not (csLoading in ComponentState) and not (fsCreating in Form.FormState) and not (csDestroying in Form.ComponentState) then begin
    InitDwm(Form.Handle, True);
    if (Form.FormStyle = fsMDIChild) and (MDISkinProvider <> nil) then
      with TsSkinProvider(MDISkinProvider) do
        if Assigned(Form.ActiveMDIChild) and (Form.ActiveMDIChild.WindowState = wsMaximized) and (Form <> Form.ActiveMDIChild) then
          Exit;

    if not MenusInitialized then
      if UpdateMenu then
        MenusInitialized := True;

    // Support of DevEx cxPrintWindow
    if Message.LParam and PRF_ERASEBKGND = PRF_ERASEBKGND then
      ProcessMessage(WM_ERASEBKGND, Message.WParam, Message.LParam)
    else begin
      DC := TWMPaint(Message).DC;
      FCommonData.PrintDC := DC;
      FCommonData.Updating := False;
      if (FCommonData.FCacheBmp = nil) or FCommonData.FCacheBmp.Empty then
        FCommonData.BGChanged := True;

      if BorderForm <> nil then begin
        if FCommonData.BGChanged then
          PaintAll;

        BitBlt(DC, 0, 0, FCommonData.FCacheBmp.Width, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
        MoveWindowOrg(DC, OffsetX, OffsetY);
        GetClientRect(Form.Handle, cR);
        IntersectClipRect(DC, 0, 0, WidthOf(cR), HeightOf(cR));
        if Form.FormStyle <> fsMDIForm then
          PaintControls(DC, Form, True, MkPoint, {0, }FormState and FS_ANIMCLOSING = 0);
      end
      else begin
        if CanDrawNCArea then
          if not HaveBorder(Self) and IsSizeBox(Form.Handle) then begin
            if FCommonData.BGChanged then
              PaintAll;

            i := Form.BorderWidth + 3;
            BitBlt(DC, 0, 0, Form.Width, i, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY); // Title and menu line update
            BitBlt(DC, 0, i, i, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, i, SRCCOPY); // Left border update
            BitBlt(DC, i, Form.Height - i, Form.Width - i, i, FCommonData.FCacheBmp.Canvas.Handle, i, Form.Height - i, SRCCOPY); // Bottom border update
            BitBlt(DC, FCommonData.FCacheBmp.Width - i, i, i, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, FCommonData.FCacheBmp.Width - i, i, SRCCOPY); // Right border update
          end
          else
            if not UWPMode then
              PaintCaption(DC);

        MoveWindowOrg(DC, OffsetX, OffsetY);
        GetClientRect(Form.Handle, cR);
        IntersectClipRect(DC, 0, 0, WidthOf(cR), HeightOf(cR));
        SavedDC := SaveDC(DC);
        PaintForm(DC, MkRect(Form));
        RestoreDC(DC, SavedDC);
      end;
      if Form.FormStyle = fsMDIForm then
        TrySendMessage(Form.ClientHandle, WM_PRINT, WPARAM(DC), 0);

      FCommonData.PrintDC := 0;
      if Assigned(Form.OnPaint) then begin
        Form.Canvas.Handle := DC;
        Form.OnPaint(Form);
        Form.Canvas.Handle := 0;
      end;
    end;
  end;
end;


procedure TsSkinProvider.AC_WMNCPaint(var Message: TMessage);
var
  R: TRect;
begin
  if SystemMenu = nil then
    PrepareForm;

  if CanDrawNCArea then
    if SkinData.CtrlSkinState and (ACS_LOCKED or ACS_MNUPDATING) <> 0 then
      if (IsMenuVisible(Self) and (Form.Menu.WindowHandle = 0)) or (FormState and (FS_ANIMCLOSING or FS_ANIMSHOWING) <> 0) then
        Exit;

  if RTInit then begin
    RTInit := False;
    LoadInit;
  end;
  if not InUpdating(SkinData) then
    if CanDrawNCArea and not (InAnimationProcess and (Form.FormStyle = fsMDIChild)) then begin
      if fAnimating or not Form.Showing or (csLoading in ComponentState) or (csDestroyingHandle in Form.ControlState) or (SystemMenu = nil) then
        Exit;

      if IsIconic(Form.Handle) then
        FCommonData.BGChanged := True
      else begin
        GetWindowRect(Form.Handle, R);
        if (WidthOf(R) <> Form.Width) or (HeightOf(R) <> Form.Height) then
          Exit; // If size of form is not initialized yet (wsMaximized)
      end;

      if not Assigned(Adapter) then
        AdapterCreate; // Preventing of std controls BG erasing before hooking

      if SkinData.FCacheBmp = nil then // Preventing of painting before ExBorders, usually when MainMenu exists
        InitExBorders(SkinData.SkinManager.ExtendedBorders);

      AC_WMNCPaintHandler;
      Message.Result := 0;
    end
    else
      OldWndProc(Message)
  else
    if not CanDrawNCArea then
      OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMEraseBkGnd(var Message: TMessage);
var
  R, cR: TRect;
begin
  if IsWindowVisible(form.Handle) and FDrawClientArea then begin
    if (SkinData.CtrlSkinState and ACS_LOCKED = 0) and not FCommonData.FUpdating then begin
      if not (csPaintCopy in Form.ControlState) and (Message.WParam <> WParam(Message.LParam) {PerformEraseBackground, TntSpeedButtons}) then begin
        if (Form.FormStyle = fsMDIForm) and (Form.ActiveMDIChild <> nil) and (Form.ActiveMDIChild.WindowState = wsMaximized) then begin
          if (Form.FormStyle = fsMDIChild) and (FCommonData.FCacheBmp <> nil) and (MDISkinProvider <> nil) then begin
            GetClientRect(TsSkinProvider(MDISkinProvider).Form.Handle, cR);
            if (PtInRect(cR, Form.BoundsRect.TopLeft) and PtInRect(cR, Form.BoundsRect.BottomRight)) then begin
              FCommonData.FCacheBmp.Height := min(FCommonData.FCacheBmp.Height, CaptionHeight + SysBorderHeight(Form.Handle, BorderForm) + LinesCount * MenuHeight + 1);
              FCommonData.BGChanged := True;
            end
          end;
          AC_WMEraseBkGndHandler(TWMPaint(Message).DC);
          if MDICreating then begin
            MDICreating := False;
            if Form.FormStyle = fsMDIChild then
              ChildProvider := Self;
          end;
        end
        else
          if (FCommonData.FCacheBmp <> nil) and not FCommonData.BGChanged then begin
            if GetClipBox(TWMPaint(Message).DC, R) <> NULLREGION then
              CopyWinControlCache(Form, FCommonData, Rect(OffsetX + R.Left, OffsetY + R.Top, OffsetX + Form.ClientWidth, OffsetY + Form.ClientHeight), R{MkRect(Form.ClientWidth, Form.ClientHeight)}, hdc(TWMPaint(Message).DC), False);

// Desc 14           if not DrawNonClientArea or (Form.FormStyle = fsMDIForm) or (Form.Parent <> nil) then
            SetParentUpdated(Form);
          end;
      end
      else
        if Message.WParam <> 0 then // From PaintTo
          if not FCommonData.BGChanged then
            BitBlt(TWMPaint(Message).DC, 0, 0, Form.Width, Form.Height, FCommonData.FCacheBmp.Canvas.Handle, OffsetX, OffsetY, SRCCOPY);

      Message.Result := 1;
    end;
  end
  else
    OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMPaint(var Message: TMessage);
var
  DC: hdc;
begin
  if FDrawClientArea and (FormState and FS_ANIMRESTORING = 0) then begin
    if csPaintCopy in Form.ControlState then
      Exit; // Implemented in WM_ERASEBKGND

    if (BorderForm <> nil) and not InAnimation(Self) and ((BorderForm.AForm = nil) or not IsWindowVisible(BorderForm.AForm.Handle)) then
      BorderForm.UpdateExBordersPos(False);

    if Form.Showing then begin
      OurPaintHandler(TWMPaint(Message));
      if MDICreating then
        MDICreating := False;

      if Form.FormStyle = fsMDIForm then begin
        if TWMPaint(Message).DC = 0 then
          DC := GetDC(Form.Handle)
        else
          DC := TWMPaint(Message).DC;

        PaintControls(DC, Form, True, MkPoint);
        if TWMPaint(Message).DC = 0 then
          ReleaseDC(Form.Handle, DC);
      end;
      Message.Result := 0;
    end
    else // if (BorderForm <> nil) {$IFDEF DELPHI7UP} or Form.AlphaBlend {$ENDIF} then
      OldWndProc(Message);

    if not CanDrawNCArea and (Form.Menu <> nil) then
      ProcessMessage(WM_NCPAINT, 0, 0);
  end
  else
    OldWndProc(Message);
end;


procedure TsSkinProvider.AC_CMRecreateWnd(var Message: TMessage);
begin
  OldWndProc(TMessage(Message));
{$IFNDEF DISABLEPREVIEWMODE}
  if (acPreviewHandle <> 0) and Form.HandleAllocated then
    TrySayHelloToEditor(Form.Handle);
{$ENDIF}
end;


procedure TsSkinProvider.AC_WMActivateApp(var Message: TMessage);
begin
  OldWndProc(Message);
  if (sPopupCalendar <> nil) and sPopupCalendar.Visible then
    sPopupCalendar.Close;

  if (Message.WParam = 1) and SkinData.SkinManager.AnimEffects.Minimizing.Active and (FormState and FS_ANIMMINIMIZING = 0) then
    if BorderForm <> nil then begin
      if FormState and FS_DISABLED = 0 then
        BorderForm.UpdateExBordersPos(False) // Update z-order ( BDS )
    end
    else
      if (Application.MainForm = Form) and
           (Message.WParam = 1) and
             (Application.MainForm.WindowState = wsMinimized) and
               not IsIconic(Application.MainForm.Handle) and
                 ((FormTimer = nil) or not TacMinTimer(FormTimer).Minimized) then begin // Restore a main form if is not restored still
        Application.MainForm.WindowState := wsNormal;
        InvalidateRect(Application.MainForm.Handle, nil, True);
        RedrawWindow(Application.MainForm.Handle, nil, 0, RDWA_ALLNOW);
      end;
end;


procedure TsSkinProvider.AC_WMMDIDestroy(var Message: TMessage);
begin
  OldWndProc(Message);
  if (Form.FormStyle = fsMDIChild) and Assigned(MDISkinProvider) and not (csDestroying in TsSkinProvider(MDISkinProvider).ComponentState) then
    with TsSkinProvider(MDISkinProvider) do
      if Form.WindowState <> wsMaximized then begin
        MenusInitialized := False;
        Menuchanged := True;
        SkinData.BGChanged := True;
        FLinesCount := -1;
        ProcessMessage(WM_NCPAINT, 0, 0);
      end
      else begin
        SkinData.BGChanged := True;
        ProcessMessage(WM_NCPAINT, 0, 0);
        UpdateMainForm(True);
      end;

  ChildProvider := Self;
end;


procedure TsSkinProvider.AC_WMVisibleChanged(var Message: TMessage);
begin
  if Message.WParam = 1 then begin
    if RTInit then begin
      RTInit := False;
      LoadInit;
      InitExBorders(SkinData.SkinManager.ExtendedBorders);
    end;
    if (SkinData.SkinManager <> nil) and SkinData.SkinManager.IsActive and Form.HandleAllocated then
    	SetClassLong(Form.Handle, GCL_HBRBACKGROUND, ACNativeInt(SkinData.SkinManager.Brushes[pcMainColor]));
  end;
  OldWndProc(Message);
  if Message.WParam = 0 then begin
    if Assigned(SkinData) and Assigned(SkinData.FCacheBmp) and not (csDestroying in Form.ComponentState) then begin
      SkinData.FCacheBmp.Width  := 0;
      SkinData.FCacheBmp.Height := 0;
    end;
    KillAnimations;
  end
  else
    if Form.Parent <> nil then
      SetParentUpdated(Form); // Updating of controls which are not refreshed
end;


procedure TsSkinProvider.AC_WMNCLButtonDblClick(var Message: TMessage);
var
  p: TPoint;
begin
  if (ResizeMode = rmBorder) and bInProcess then begin
    p := Form.ClientToScreen(Point(TWMMouse(Message).XPos, TWMMouse(Message).YPos));
    StopMove(p.x, p.y);
    ReleaseCapture;
    bInProcess := False;
  end;
  case TWMNCHitMessage(Message).HitTest of
    HTSYSMENU: begin
{$IFNDEF FPC}
      if not SkinData.SkinManager.SkinnedPopups then // Check and Exit when DblClick and not SkinnedPopups
{$ENDIF}
        SkinData.Updating := True;

      Form.Close;
    end;

    HTCAPTION: begin
      if HaveSysMenu and (SystemMenu.EnabledMax or SystemMenu.EnabledRestore) or not HaveBorder(Self) and IsIconic(Form.Handle) then begin
        TrySendMessage(Form.Handle, WM_SYSCOMMAND, StateFlags[(Form.WindowState = wsMaximized) or IsIconic(Form.Handle)], 0);
        SystemMenu.UpdateItems;
      end
      else
        if IsIconic(Form.Handle) then begin
          TrySendMessage(Form.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
          SystemMenu.UpdateItems;
          TWMNCHitMessage(Message).HitTest := 0;
        end
        else
          OldWndProc(Message);
    end

    else
      OldWndProc(Message);
  end;
end;


procedure TsSkinProvider.AC_WMMeasureItem(var Message: TMessage);
var
  mi: TMenuItem;
begin
  if (Form.FormStyle = fsMDIForm) and (MDISkinProvider = Self) then
    MDISkinProvider := Self;

{$IFNDEF FPC}
  if IsMenuVisible(Self) and Assigned(SkinData.SkinManager) and CanDrawNCArea and (PMeasureItemStruct(Message.LParam)^.CtlType = ODT_MENU) then begin
    mi := Form.Menu.FindItem(PMeasureItemStruct(Message.LParam)^.itemID, fkCommand);
    if mi <> nil then
      SkinData.SkinManager.SkinableMenus.InitItem(mi, True);
  end;
{$ENDIF}
  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMQueryEndSession(var Message: TMessage);
begin
  FadingForbidden := True;
  if not Application.Terminated then
    while acAnimCount > 0 do
      Application.ProcessMessages;

  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMWindowPosChanged(var Message: TMessage);
begin
  if SkinData.SkinManager.Options.NativeBordersMaximized and (Form.WindowState = wsMaximized) and (BorderForm <> nil) then
    FreeAndNil(BorderForm);

  if Assigned(SkinData.SkinManager) and acLayered and CanDrawNCArea then begin
    UWPCaptionUpdate(Form.WindowState = wsMaximized);
    if (BorderForm <> nil) and Form.HandleAllocated and IsZoomed(Form.Handle) then
      FSysExHeight := ActualTitleHeight > (SysCaptHeight(Self) + 4)
    else
      FSysExHeight := False;
{$IFNDEF NOWNDANIMATION}
    if (TWMWindowPosChanged(Message).WindowPos.Flags and SWP_HIDEWINDOW = SWP_HIDEWINDOW) then
      if not SkipAnimation and (SkinData.FCacheBmp <> nil {it's possible under Aero}) then // Window will be hidden
        if not IsIconic(Form.Handle) then
          if (SkinData.SkinManager.ShowState = saMinimize) and (Form = Application.MainForm) then begin
//            if SkinData.SkinManager.AnimEffects.Minimizing.Active then
            begin
              OldWndProc(Message);
              fAnimating := False;
              if (BorderForm <> nil) and (BorderForm.AForm <> nil) then
                FreeAndNil(BorderForm.AForm);

              Exit;
            end;
          end
          else
            if not (msScaleChanging in SkinData.SkinManager.ManagerState) then begin
              if SkinData.SkinManager.ShowState <> saMinimize then begin // Closing
                if FAllowAnimation and
                     SkinData.SkinManager.AnimEffects.FormHide.Active and
                       (SkinData.SkinManager.AnimEffects.FormHide.Time > 0) and
                         SkinData.SkinManager.Effects.AllowAnimation and (Form.Parent = nil) and (Form.FormStyle <> fsMDIChild) then begin
                  if AeroIsEnabled then
                    DoLayered(Form.Handle, True);

                  OldWndProc(Message);
                  SkipAnimation := True;
                  AnimHideForm(Self, SkinData.SkinManager.AnimEffects.FormHide.Time, SkinData.SkinManager.AnimEffects.FormHide.Mode);
                  if not Application.Terminated then begin
                    if AeroIsEnabled then
                      DoLayered(Form.Handle, False);

                    SkipAnimation := False;
                  end;
                  Exit;
                end
                else // Closing not main form
                  if BorderForm <> nil then
                    FreeAndNil(BorderForm.AForm);
              end
              else // Minimize not main form
                if BorderForm <> nil then
                  FreeAndNil(BorderForm.AForm);
          end;
{$ENDIF}
    OldWndProc(Message);
    if not FInAnimation and (BorderForm <> nil) then begin
      if Form.Visible and not IsIconic(Form.Handle) then begin
        if (TWMWindowPosChanged(Message).WindowPos^.Flags and (SWP_NOREDRAW or SWP_DRAWFRAME) = 0) then
          if FormState and (FS_DISABLED or FS_BLENDMOVING) = 0 then
            if (TWMWindowPosChanged(Message).WindowPos^.Flags and 3 = 3) and (BorderForm.AForm <> nil) then
              if AeroIsEnabled and (Application.MainForm = Form) and (GetActiveWindow = Form.Handle) then
                SetWindowPos(BorderForm.AForm.Handle, BorderForm.GetTopWnd{HWND_TOPMOST}, 0, 0, 0, 0, SWPA_SHOWZORDERONLY)
              else
                SetWindowPos(BorderForm.AForm.Handle, Form.Handle, 0, 0, 0, 0, SWPA_SHOWZORDERONLY)
            else
              BorderForm.UpdateExBordersPos(False); // Update z-order ( BDS )
        end
        else
          if (BorderForm <> nil) and (FormState and FS_ANIMMINREST = 0) and
               IsIconic(Form.Handle) and not Application.Terminated and not (csDestroying in Form.ComponentState) and (Form = Application.MainForm) then
            FreeAndNil(BorderForm.AForm);
      end
    end
  else
    OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMCreate(var Message: TMessage);
begin
  if Form.FormStyle = fsMDIChild then begin
    if MDISkinProvider = nil then
      AddSupportedForm(Application.MainForm.Handle);

    if (MDISkinProvider <> nil) and
         (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild <> nil) and
           (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild.WindowState = wsMaximized) then
      MDICreating := True
    else
      MDICreating := False;
  end;
  OldWndProc(Message);
  if Form.FormStyle <> fsMDIChild then
    PrepareForm; // Problem with MDI menu solving
end;


procedure TsSkinProvider.AC_WMParentNotify(var Message: TMessage);
var
  wctrl: TWinControl;
begin
  OldWndProc(Message);
  if (Form <> nil) and
       not (csLoading in ComponentState) and
         not (csLoading in Form.ComponentState) and
           (Message.WParamLo in [WM_CREATE, WM_DESTROY]) and
             (srThirdParty in SkinData.SkinManager.SkinningRules) then begin
    if Assigned(Adapter) and (Message.WParamLo = WM_CREATE) then
      if Message.LParam <> 0 then begin
{$IFDEF D2007}
//        if not IsWindowVisible(Message.LParam) then
//          Exit;
{$ENDIF}
        wctrl := SearchWndByID(Message.LParam, Application);
        if wctrl = nil then
          TacCtrlAdapter(Adapter).AddAllItems(nil)
        else
          if FAllowSkin3rdParty then
            TacCtrlAdapter(Adapter).AddNewItem(wctrl, ThirdLists);
      end
      else
        TacCtrlAdapter(Adapter).AddAllItems(nil);

    if CanDrawNCArea then
      UpdateScrolls(ListSW, True);
  end
end;


procedure TsSkinProvider.AC_WMNotify(var Message: TMessage);
begin
  OldWndProc(Message);
  case TWMNotify(Message).NMHdr^.code of
    -12: // Visibility of child ctrl is changed
      if Adapter <> nil then
        TacCtrlAdapter(Adapter).AddAllItems(nil);
  end;
end;


procedure TsSkinProvider.AC_WMControlListChange(var Message: TCMControlListChange);
begin
  if Message.Control <> nil then begin
    OldWndProc(TMessage(Message));
    if Message.Control is TWinControl then
      if Adapter <> nil then
        if FAllowSkin3rdParty then
          TacCtrlAdapter(Adapter).AddNewItem(TWinControl(Message.Control), ThirdLists);
  end
  else
    OldWndProc(TMessage(Message));
end;


procedure TsSystemMenu.CloseClick(Sender: TObject);
begin
  Sendmessage(FForm.Handle, WM_SYSCOMMAND, SC_CLOSE, 0);
end;


constructor TsSystemMenu.Create(AOwner: TComponent);
begin
  FOwner := TsSkinProvider(AOwner);
  FForm := FOwner.Form;
  SubMenu := nil;
  inherited Create(AOwner);
  Name := s_SysMenu + IntToStr(GetTickCount);
  Generate;
end;


function TsSystemMenu.EnabledClose: boolean;
var
  mnu: HMENU;
begin
  mnu := GetSystemMenu(FForm.Handle, False);
  if mnu <> 0 then
    Result := GetMenuState(mnu, SC_CLOSE, MF_BYCOMMAND) and MF_DISABLED <> MF_DISABLED
  else
    Result := biSystemMenu in TForm(FForm).BorderIcons;
end;


function TsSystemMenu.EnabledMax: boolean;
begin
  Result := ((TForm(FForm).FormStyle = fsMDIChild) or (FForm.BorderStyle in [bsSingle, bsSizeable])) and (biMaximize in FOwner.Form.BorderIcons);
end;


function TsSystemMenu.EnabledMin: boolean;
begin
  Result := (biMinimize in FOwner.Form.BorderIcons);
end;


function TsSystemMenu.EnabledMove: boolean;
begin
  Result := FForm.WindowState <> wsMaximized;
end;


function TsSystemMenu.EnabledRestore: boolean;
begin
  Result := ((biMaximize in FOwner.Form.BorderIcons) and (FForm.WindowState <> wsNormal)) or (FForm.WindowState = wsMinimized);
end;


function TsSystemMenu.EnabledSize: boolean;
begin
  Result := (FForm.BorderStyle <> bsSingle) and not IsIconic(FForm.Handle);
end;


procedure TsSystemMenu.ExtClick(Sender: TObject);
begin
  PostMessage(FForm.Handle, WM_SYSCOMMAND, TComponent(Sender).Tag, 0);
end;


function CloneMenuitem(SourceItem: TMenuItem): TMenuItem;
var
  i: Integer;
begin
  with SourceItem do begin
    Result := NewItem(Caption, Shortcut, Checked, Enabled, OnClick, HelpContext, Name + 'Copy');
    Result.ImageIndex := SourceItem.ImageIndex;
    for i := 0 to Count - 1 do
      Result.Add(CloneMenuItem(Items[i]));
  end;
end;


procedure TsSystemMenu.Generate;
var
  Menu: HMENU;
  mi: TMenuItem;
  i, c: integer;
  u: UINT;
  s: acString;
  sCut: string;
  TmpItem: TMenuItem;

  function CreateSystemItem(const Caption: acString; const Name: string; EventProc: TNotifyEvent): TMenuItem;
  begin
    Result := TacMenuItem.Create(Self);
    Result.Caption := Caption;
    Result.OnClick := EventProc;
    Result.Name := Name;
  end;

  function GetItemText(ID: Cardinal; var Caption: acString; var ShortCut: String; uFlag: Cardinal; const DefText: string = ''): boolean;
  var
    Text: array [0..MaxByte] of acChar;
{$IFDEF TNTUNICODE}
    ws: WideString;
{$ENDIF}
    P: integer;
  begin
    Result := {$IFDEF TNTUNICODE}GetMenuStringW{$ELSE}GetMenuString{$ENDIF}(Menu, ID, Text, MaxByte, uFlag) <> 0;
    if Result then begin
      P := Pos(#9, Text);
      if P = 0 then
        ShortCut := ''
      else begin
        ShortCut := Copy(Text, P + 1, Length(Text) - P);
{$IFDEF TNTUNICODE}
        ws := Text;
        ws := Copy(ws, 1, P - 1);
        Caption := ws;
        Exit;
{$ELSE}
        StrLCopy(Text, Text, P - 1);
{$ENDIF}
      end;
      Caption := Text;
    end
    else
      Caption := DefText;
  end;

  procedure TrySubMenu(Position: TacMenuItemPos);
  var
    i: integer;
  begin
    with FOwner do
      if (SysSubMenu.Position = Position) and (SysSubMenu.Caption <> '') and (SysSubMenu.PopupMenu <> nil) then begin
        if Position = ipBottom then
          Self.Items.Add(CreateSystemItem(CharMinus, 'ac_BtmDiv', nil));

        SubMenu := CreateSystemItem(SysSubMenu.Caption, 'ac_SubMenu', nil);
        Self.Items.Add(SubMenu);
        for i := 0 to SysSubMenu.PopupMenu.Items.Count - 1 do begin
          mi := CloneMenuitem(SysSubMenu.PopupMenu.Items[i]);
          SubMenu.Add(mi);
        end;
        Images := SysSubMenu.PopupMenu.Images;
        if Position in [ipTop, ipBeforeClose] then
          Self.Items.Add(CreateSystemItem(CharMinus, 'ac_TopDiv', nil));
      end;
  end;

begin
  Items.Clear;
  ExtItemsCount := 0;
  Menu := GetSystemMenu(FForm.Handle, False);
  if Menu <> 0 then begin
    TrySubMenu(ipTop);

    GetItemText(SC_RESTORE, s, sCut, MF_BYCOMMAND, acs_RestoreStr);
    ItemRestore := CreateSystemItem(s, 'acIR', RestoreClick);
    Items.Add(ItemRestore);
    ItemRestore.Tag := SC_RESTORE;

    GetItemText(SC_MOVE, s, sCut, MF_BYCOMMAND, acs_MoveStr);
    ItemMove := CreateSystemItem(s, 'acIM', MoveClick);
    Items.Add(ItemMove);
    ItemMove.Tag := SC_MOVE;

    GetItemText(SC_SIZE, s, sCut, MF_BYCOMMAND, acs_SizeStr);
    ItemSize := CreateSystemItem(s, 'acIS', SizeClick);
    Items.Add(ItemSize);
    ItemSize.Tag := SC_SIZE;

    GetItemText(SC_MINIMIZE, s, sCut, MF_BYCOMMAND, acs_MinimizeStr);
    ItemMinimize := CreateSystemItem(s, 'acIN', MinClick);
    Items.Add(ItemMinimize);
    ItemMinimize.Tag := SC_MINIMIZE;

    GetItemText(SC_MAXIMIZE, s, sCut, MF_BYCOMMAND, acs_MaximizeStr);
    ItemMaximize := CreateSystemItem(s, 'acIX', MaxClick);
    Items.Add(ItemMaximize);
    ItemMaximize.Tag := SC_MAXIMIZE;

{$IFNDEF FPC}
    Items.InsertNewLineAfter(ItemMaximize);
{$ENDIF}
    TmpItem := nil;
    c := GetMenuItemCount(Menu);
    for i := 0 to c - 1 do begin
      u := GetMenuItemID(Menu, i);
      if ((u < $F000) or (u >= $F200)) and GetItemText(i, s, sCut, MF_BYPOSITION) then begin // If some external menuitems are exists
        TmpItem := TacMenuItem.Create(Self);
        TmpItem.Caption := s;
        TmpItem.Tag := ACNativeInt(u);
{$IFNDEF FPC}
        if sCut <> '' then
          TmpItem.ShortCut := TextToShortCut(sCut);
{$ENDIF}
        TmpItem.OnClick := ExtClick;
        Items.Add(TmpItem);
        inc(ExtItemsCount);
      end;
    end;
{$IFNDEF FPC}
    if ExtItemsCount > 0 then
      Self.Items.InsertNewLineAfter(TmpItem);
{$ENDIF}

    TrySubMenu(ipBeforeClose);
    GetItemText(SC_CLOSE, s, sCut, MF_BYCOMMAND, acs_CloseStr);
    ItemClose := CreateSystemItem(s, 'acIC', CloseClick);
{$IFNDEF FPC}
    if sCut <> '' then
      ItemClose.ShortCut := TextToShortCut(sCut);
{$ENDIF}

    Self.Items.Add(ItemClose);
    ItemClose.Tag := SC_CLOSE;
    ItemClose.Enabled := EnabledClose;
    TrySubMenu(ipBottom);
  end;
end;


procedure TsSystemMenu.MakeSkinItems;
var
  sl: TacStringList;
  i: integer;
  SkinItem, TempItem: TMenuItem;
  b: boolean;
begin
  if Assigned(FOwner.SkinData.SkinManager) then begin
    sl := TacStringList.Create;
    FOwner.SkinData.SkinManager.GetSkinNames(sl);
    b := False;
    if sl.Count > 0 then begin
      SkinItem := TacMenuItem.Create(Self);
      SkinItem.Caption := acs_AvailSkins;
      SkinItem.Name := s_SkinSelectItemName;
      Self.Items.Insert(0, SkinItem);
{$IFNDEF FPC}
      Self.Items.InsertNewLineAfter(SkinItem);
{$ENDIF}
      for i := 0 to sl.Count - 1 do begin
        TempItem := TacMenuItem.Create(Self);
        TempItem.Caption := sl[i];
        TempItem.OnClick := SkinSelect;
        TempItem.Name := s_SkinSelectItemName + IntToStr(i);
        TempItem.RadioItem := True;
        if not b and (TempItem.Caption = FOwner.SkinData.SkinManager.SkinName) then begin
          TempItem.Checked := True;
          TempItem.Default := True;
          b := True;
        end;
{$IFNDEF FPC}
        if (i <> 0) and (i mod 20 = 0) then
          TempItem.Break := mbBreak;
{$ENDIF}

        SkinItem.Add(TempItem);
      end;
    end;
    FreeAndNil(sl);
  end;
end;


procedure TsSystemMenu.MaxClick(Sender: TObject);
begin
  Sendmessage(FForm.Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
  UpdateItems;
end;


procedure TsSystemMenu.MinClick(Sender: TObject);
begin
  FOwner.SkipAnimation := True;
  SendMessage(FOwner.Form.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
  FOwner.SkipAnimation := False;
  FOwner.SystemMenu.UpdateItems;
end;


procedure TsSystemMenu.MoveClick(Sender: TObject);
begin
  Sendmessage(FForm.Handle, WM_SYSCOMMAND, SC_MOVE, 0);
end;


procedure TsSystemMenu.RestoreClick(Sender: TObject);
begin
  Sendmessage(FForm.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
  UpdateItems;
end;


procedure TsSystemMenu.SizeClick(Sender: TObject);
begin
  Sendmessage(FForm.Handle, WM_SYSCOMMAND, SC_SIZE, 0);
end;


procedure TsSystemMenu.SkinSelect(Sender: TObject);
var
  sSkinName, sInternalSkin: string;
  iIndex: Integer;
begin
  if Assigned(FOwner.SkinData.SkinManager) then begin
    sSkinName := DelChars(TMenuItem(Sender).Caption, '&');
    sInternalSkin := acs_InternalSkin;
    iIndex := Pos(sInternalSkin, sSkinName);
    if iIndex > 0 then
      sSkinName := Copy(sSkinName, 1, iIndex - 1 + Length(sInternalSkin));

    FOwner.SkinData.SkinManager.SkinName := sSkinName;
  end;
end;


procedure TsSystemMenu.UpdateGlyphs;
begin
//
end;


procedure TsSystemMenu.UpdateItems(Full: boolean = False);
begin
  if Full or (ItemClose = nil) then
    Generate;

  if Assigned(Self) and Assigned(FForm) then begin
    if ItemRestore <> nil then begin
      ItemRestore.Visible := VisibleRestore;
      ItemRestore.Enabled := EnabledRestore;
    end;
    if ItemMove <> nil then begin
      ItemMove.Visible := True;
      ItemMove.Enabled := EnabledMove;
    end;
    if ItemSize <> nil then begin
      ItemSize.Visible := VisibleSize;
      ItemSize.Enabled := EnabledSize;
    end;
    if ItemMinimize <> nil then begin
      ItemMinimize.Visible := VisibleMin;
      ItemMinimize.Enabled := EnabledMin;
    end;
    if ItemMaximize <> nil then begin
      ItemMaximize.Visible := VisibleMax;
      ItemMaximize.Enabled := EnabledMax;
    end;
    if ItemClose <> nil then begin
      ItemClose.Visible := VisibleClose;
      ItemClose.Enabled := EnabledClose;
    end;
  end;
end;


function TsSystemMenu.VisibleClose: boolean;
var
  hMenuHandle: hwnd;
begin
  Result := False;
  if FOwner.HaveSysMenu then begin
    hMenuHandle := GetSystemMenu(FForm.Handle, False);
    if hMenuHandle <> 0 then
      Result := integer(GetMenuState(hMenuHandle, SC_CLOSE, MF_BYCOMMAND)) <> -1
    else
      Result := biSystemMenu in TForm(FForm).BorderIcons;
  end
end;


function TsSystemMenu.VisibleMax: boolean;
begin
  if (Self <> nil) and FOwner.HaveSysMenu then
    Result := (IsIconic(Self.FForm.Handle) {$IFDEF D2009}and not (Application.MainFormOnTaskBar and (FForm = Application.MainForm)){$ENDIF}) or
               (TForm(FForm).FormStyle = fsMDIChild) or
               (((FForm.BorderStyle <> bsSingle) or (biMaximize in FOwner.Form.BorderIcons)) and
                not (FForm.BorderStyle in [bsNone, bsSizeToolWin, bsToolWindow, bsDialog]) and
               FOwner.HaveSysMenu) and (biMaximize in FOwner.Form.BorderIcons)
  else
    Result := False;
end;


function TsSystemMenu.VisibleMin: boolean;
begin
  if (Self <> nil) and FOwner.HaveSysMenu then
    if IsIconic(FForm.Handle) or (TForm(FForm).FormStyle = fsMDIChild) then
      Result := True
    else
      Result := not (FForm.BorderStyle in [bsNone, bsDialog, bsSizeToolWin, bsToolWindow]) and
                ((FForm.BorderStyle <> bsSingle) or (biMinimize in FOwner.Form.BorderIcons)) and
                (biMinimize in FOwner.Form.BorderIcons) and FOwner.HaveSysMenu
  else
    Result := False;
end;


function TsSystemMenu.VisibleRestore: boolean;
begin
  if (Self <> nil) and FOwner.HaveSysMenu then
    Result := (TForm(FForm).FormStyle = fsMDIChild) or not (FForm.BorderStyle in [bsNone, bsDialog, bsSizeToolWin, bsToolWindow]) and FOwner.HaveSysMenu
  else
    Result := False;
end;


function TsSystemMenu.VisibleSize: boolean;
begin
  if Self <> nil then
    Result := (TForm(FForm).FormStyle = fsMDIChild) or ((FForm.BorderStyle <> bsDialog) and (FForm.BorderStyle <> bsNone) and (FForm.BorderStyle <> bsToolWindow))
  else
    Result := False;
end;


constructor TsTitleIcon.Create;
begin
  FOwner := AOwner;
  FGlyph := CreateBmp32;
  FGlyph.OnChange := GlyphChanged;
  FHeight := 0;
  FWidth  := 0;
  FVisible := True;
end;


destructor TsTitleIcon.Destroy;
begin
  FreeAndNil(FGlyph);
  inherited Destroy;
end;


procedure TsTitleIcon.GlyphChanged(Sender: TObject);
begin
  UpdateSkinCaption(FOwner);
end;


procedure TsTitleIcon.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
end;


procedure TsTitleIcon.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then begin
    FVisible := Value;
    if ([csLoading, csDesigning] * FOwner.ComponentState = []) and not FOwner.SkinData.FUpdating then
      UpdateSkinCaption(FOwner);
  end;
end;


constructor TsTitleButtons.Create(AOwner: TsSkinProvider);
begin
  inherited Create(TsTitleButton);
  FOwner := AOwner;
end;


destructor TsTitleButtons.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;


function TsTitleButtons.GetItem(Index: Integer): TsTitleButton;
begin
  Result := TsTitleButton(inherited GetItem(Index))
end;


function TsTitleButtons.GetOwner: TPersistent;
begin
  Result := FOwner;
end;


procedure TsTitleButtons.SetItem(Index: Integer; Value: TsTitleButton);
begin
  inherited SetItem(Index, Value);
end;


procedure TsTitleButton.AssignTo(Dest: TPersistent);
begin
  if Dest = nil then
    inherited
  else begin
    TsTitleButton(Dest).Enabled := Enabled;
    TsTitleButton(Dest).Glyph := Glyph;
    TsTitleButton(Dest).Hint := Hint;
    TsTitleButton(Dest).Name := Name;
    TsTitleButton(Dest).UseSkinData := UseSkinData;
    TsTitleButton(Dest).OnMouseDown := OnMouseDown;
    TsTitleButton(Dest).OnMouseUp := OnMouseUp;
  end;
end;


constructor TsTitleButton.Create(ACollection: TCollection);
begin
  FGlyph := CreateBmp32;
  FGlyph.OnChange := OnGlyphChange;
  FUseSkinData := True;
  FEnabled := True;
  FVisible := True;
  HintWnd := nil;
  inherited Create(ACollection);
  if FName = '' then
    FName := ClassName;
end;


destructor TsTitleButton.Destroy;
begin
  if Data.cpTimer <> nil then
    FreeAndNil(Data.cpTimer);

  FreeAndNil(FGlyph);
  if HintWnd <> nil then
    FreeAndNil(HintWnd);

  inherited Destroy;
end;


function TsTitleButton.GetDisplayName: string;
begin
  Result := Name;
end;


procedure TsTitleButton.MouseDown(BtnIndex: integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseDown) then
    FOnMouseDown(Self, Button, Shift, X, Y);
end;


procedure TsTitleButton.MouseUp(BtnIndex: integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseUp) then
    FOnMouseUp(Self, Button, Shift, X, Y);
end;


procedure TsTitleButton.OnGlyphChange(Sender: TObject);
begin
  if Data.cpTimer <> nil then
    FreeAndNil(Data.cpTimer);
end;


procedure TsTitleButton.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
end;


procedure TsTitleButton.SetName(const Value: string);
begin
  if FName <> Value then
    FName := Value;
end;


procedure TsTitleButton.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then begin
    FVisible := Value;
    UpdateSkinCaption(TsTitleButtons(Collection).FOwner);
  end
end;


procedure TacCtrlAdapter.AddNewItem(const Ctrl: TWinControl; AThirdLists: TStringLists{ = nil});
begin
  AddNewItem(Ctrl, DefaultSection, AThirdLists);
end;


procedure TacCtrlAdapter.AddNewItem(const Ctrl: TWinControl; const SkinSection: string; AThirdLists: TStringLists{ = nil});
var
  Found: boolean;
  CanAdd: boolean;
  sp: TsSkinProvider;
  i, Index, l: integer;
  SkinParams: TacSkinParams;
begin
  if (Ctrl = nil) or (Ctrl.Tag and ExceptTag <> 0) or (Ctrl.Parent = nil) or WndIsSkinned(Ctrl.Handle){GetBoolMsg(Ctrl, AC_CTRLHANDLED)} then
    Exit;

  // Init params
  CanAdd := True;
  SkinParams.SkinSection := SkinSection;
  SkinParams.UseSkinFontColor := True;
  SkinParams.UseSkinColor := True;
  SkinParams.VertScrollSize := -1;
  SkinParams.HorzScrollSize := -1;
  SkinParams.VertScrollBtnSize := -1;
  SkinParams.HorzScrollBtnSize := -1;
  SkinParams.Control := Ctrl;

  if AThirdLists = nil then
    if Provider.OwnThirdLists then
      AThirdLists := Provider.ThirdLists
    else
      AThirdLists := Provider.SkinData.SkinManager.ThirdLists;

  if Assigned(Provider.OnSkinItem) then begin
    Provider.FOnSkinItem(Ctrl, CanAdd, SkinParams.SkinSection);
    if not CanAdd then
      Exit;
  end;

  if Assigned(Provider.FOnSkinItemEx) then begin
    Provider.FOnSkinItemEx(Ctrl, CanAdd, @SkinParams);
    if not CanAdd then
      Exit;
  end;
  if Ctrl is TFrame then begin
{$IFNDEF ALITE}
    with TsFrameAdapter.Create(Ctrl) do Sleep(0);
{$ENDIF}
    Exit;
  end;
  if Ctrl is TForm then begin
    sp := TsSkinProvider.Create(Ctrl);
    sp.SkinData.SkinSection := iff(SkinParams.SkinSection = '', s_Form, SkinParams.SkinSection);
    sp.PrepareForm;
    InitDwm(Ctrl.Handle, True);
    Exit;
  end;

  Index := -1;
  l := Length(Items);
  Found := False;
  for i := 0 to l - 1 do
    if Items[i].WinCtrl = Ctrl then begin // If added in list already, then go to Exit
      Index := i;
      Found := True;
      Break;
    end;

  if Index = -1 then begin
    SetLength(Items, l + 1);
    l := Length(Items);
    Index := l - 1;
    Items[Index] := TacAdapterItem.Create(Self, Ctrl);
  end;
  if Found then begin
    if Assigned(Items[Index].ScrollWnd) and Items[Index].ScrollWnd.Destroyed then begin
      FreeAndNil(Items[Index].ScrollWnd);
      if Items[Index].WinCtrl.Parent <> nil then
        Items[Index].DoHook(Ctrl, SkinParams, AThirdLists);
    end
  end
  else begin
    if Items[Index].WinCtrl.Parent <> nil then
      Items[Index].DoHook(Ctrl, SkinParams, AThirdLists);

    if Index < Length(Items) then
      if Items[Index].ScrollWnd = nil then begin // If no success
        FreeAndNil(Items[Index]);
        SetLength(Items, Index);
      end;
  end;
end;


procedure TacCtrlAdapter.AddNewItem(const Ctrl: TSpeedButton);
var
  i, Index, l: integer;
  Found, CanAdd: boolean;
  SkinParams: TacSkinParams;
begin
  if (Ctrl <> nil) and (Ctrl.Tag and ExceptTag = 0) and (Ctrl.Parent <> nil) and (Ctrl.Perform(SM_ALPHACMD, AC_CTRLHANDLED_HI, 0) <> 1) then begin
    // Init params
    CanAdd := True;
    SkinParams.SkinSection := s_SpeedButton;
    SkinParams.UseSkinFontColor := True;

    if Assigned(Provider.OnSkinItem) then begin
      Provider.FOnSkinItem(Ctrl, CanAdd, SkinParams.SkinSection);
      if not CanAdd then
        Exit;
    end;

    if Assigned(Provider.FOnSkinItemEx) then begin
      Provider.FOnSkinItemEx(Ctrl, CanAdd, @SkinParams);
      if not CanAdd then
        Exit;
    end;

    Index := -1;
    l := Length(GraphItems);
    Found := False;
    for i := 0 to l - 1 do
      if GraphItems[i].Ctrl = Ctrl then begin // If added in list already, then go to Exit
        Index := i;
        Found := True;
        Break;
      end;

    if Index = -1 then begin
      SetLength(GraphItems, l + 1);
      l := Length(GraphItems);
      Index := l - 1;
      GraphItems[Index] := TacGraphItem.Create;
      GraphItems[Index].Adapter := Self;
      GraphItems[Index].Ctrl := Ctrl;
    end;
    GraphItems[Index].SkinData.SkinSection := iff(Ctrl.Flat, s_SpeedButton_Small, s_SpeedButton);
    if Found and Assigned(GraphItems[Index].Handler) and GraphItems[Index].Handler.Destroyed then begin
      FreeAndNil(GraphItems[Index].Handler);
      GraphItems[Index].DoHook(Ctrl);
    end
    else
      if not Found then begin
        if GraphItems[Index].Ctrl.Parent <> nil then
          GraphItems[Index].DoHook(Ctrl);

        if GraphItems[Index].Handler = nil then begin
          FreeAndNil(GraphItems[Index]);
          SetLength(GraphItems, Index);
        end;
      end;
  end;
end;


type
  TacOwnerData = record
    Ctrl: TWinControl;
    ThirdLists: TStringLists;
  end;


procedure TacCtrlAdapter.AddAllItems(OwnerCtrl: TWinControl = nil);
var
  i, j, l: integer;
  sSection: string;
  Owner: TWinControl;
  OwnerArray: array of TacOwnerData;
  AThirdLists: TStringLists;
begin
  AThirdLists := nil;
  if (srThirdParty in Provider.SkinData.SkinManager.SkinningRules) and not bFlag then begin
    bFlag := True;
    SetLength(OwnerArray, 0);
    if OwnerCtrl is TCustomForm then begin
      if Provider.FAllowSkin3rdParty then begin
        l := Length(OwnerArray);
        SetLength(OwnerArray, l + 1);
        if Provider.OwnThirdLists then
          OwnerArray[l].ThirdLists := Provider.ThirdLists
        else
          OwnerArray[l].ThirdLists := Provider.SkinData.SkinManager.ThirdLists;

        if OwnerCtrl = nil then
          OwnerArray[l].Ctrl := Provider.Form
        else
          OwnerArray[l].Ctrl := OwnerCtrl;
      end
      else begin // Check allowed frames
{$IFNDEF ALITE}
        for i := 0 to Provider.FrameAdapters.Count - 1 do
          if TsFrameAdapter(Provider.FrameAdapters.Items[i]).AllowSkin3rdParty then begin
            l := Length(OwnerArray);
            SetLength(OwnerArray, l + 1);
            OwnerArray[l].Ctrl := TsFrameAdapter(Provider.FrameAdapters.Items[i]).GetFrame;
            if TsFrameAdapter(Provider.FrameAdapters.Items[i]).OwnThirdLists then
              OwnerArray[l].ThirdLists := TsFrameAdapter(Provider.FrameAdapters.Items[i]).ThirdLists
            else
              OwnerArray[l].ThirdLists := Provider.SkinData.SkinManager.ThirdLists;
          end;
{$ELSE}
        l := Length(OwnerArray);
        SetLength(OwnerArray, l + 1);
        OwnerArray[l].Ctrl := OwnerCtrl;
        OwnerArray[l].ThirdLists := Provider.SkinData.SkinManager.ThirdLists;
{$ENDIF}
      end
    end
    else
      if (OwnerCtrl is TFrame) and (TrySendMessage(TFrame(OwnerCtrl).Handle, SM_ALPHACMD, MakeWParam(0, 7 {AC_CTRLHANDLED}), 0) = 1) then begin // Check if frame is not allowed
{$IFNDEF ALITE}
        for i := 0 to Provider.FrameAdapters.Count - 1 do
          if (TsFrameAdapter(Provider.FrameAdapters.Items[i]).GetFrame = OwnerCtrl) and TsFrameAdapter(Provider.FrameAdapters.Items[i]).AllowSkin3rdParty then begin
            l := Length(OwnerArray);
            SetLength(OwnerArray, l + 1);
            OwnerArray[l].Ctrl := OwnerCtrl;
            if TsFrameAdapter(Provider.FrameAdapters.Items[i]).OwnThirdLists then
              OwnerArray[l].ThirdLists := TsFrameAdapter(Provider.FrameAdapters.Items[i]).ThirdLists
            else
              OwnerArray[l].ThirdLists := Provider.SkinData.SkinManager.ThirdLists;

            Break;
          end;
{$ELSE}
        l := Length(OwnerArray);
        SetLength(OwnerArray, l + 1);
        OwnerArray[l].Ctrl := OwnerCtrl;
        OwnerArray[l].ThirdLists := Provider.SkinData.SkinManager.ThirdLists;
{$ENDIF}
      end
      else begin
        l := Length(OwnerArray);
        SetLength(OwnerArray, l + 1);
        if OwnerCtrl = nil then
          OwnerArray[l].Ctrl := Provider.Form
        else
          OwnerArray[l].Ctrl := OwnerCtrl;

        if Provider.OwnThirdLists then
          OwnerArray[l].ThirdLists := Provider.ThirdLists
        else
          OwnerArray[l].ThirdLists := Provider.SkinData.SkinManager.ThirdLists;
      end;

    for j := 0 to Length(OwnerArray) - 1 do begin
      Owner := OwnerArray[j].Ctrl;
      AThirdLists := OwnerArray[j].ThirdLists;
      if Owner <> nil then begin
        CleanItems;
        for i := 0 to Owner.ComponentCount - 1 do begin
          if IsControlSupported(Owner.Components[i], AThirdLists) then
            if Owner.Components[i] is TWinControl then begin
              sSection := '';
              AddNewItem(TWinControl(Owner.Components[i]), sSection, AThirdLists);
            end
            else
              if (Owner.Components[i] is TCustomLabel) and not (Owner.Components[i] is TsCustomLabel) then
                Provider.InitLabel(TCustomLabel(Owner.Components[i]), True);

          if Owner.Components[i] is TWinControl then
            if TWinControl(Owner.Components[i]).HandleAllocated then
              if TWinControl(Owner.Components[i]).Parent <> nil then begin
                bFlag := False;
                AddAllItems(TWinControl(Owner.Components[i])); // Recursion
              end;
        end;
        for i := 0 to Owner.ControlCount - 1 do begin
          if IsControlSupported(Owner.Controls[i], AThirdLists) then
            if Owner.Controls[i] is TWinControl then begin
              sSection := '';
              AddNewItem(TWinControl(Owner.Controls[i]), sSection, AThirdLists);
            end
            else
              if Owner.Controls[i] is TLabel then
                Provider.InitLabel(Owner.Controls[i], True)
              else
                if Owner.Controls[i] is TSpeedButton then
                  AddNewItem(TSpeedButton(Owner.Controls[i]));

          if Owner.Controls[i] is TWinControl then
            if TWinControl(Owner.Controls[i]).HandleAllocated then
              if TWinControl(Owner.Controls[i]).Parent <> nil then begin
                bFlag := False;
                AddAllItems(TWinControl(Owner.Controls[i])); // Recursion
              end
        end;
      end;
    end;
    bFlag := False;
  end;
end;


function TacCtrlAdapter.Count: integer;
begin
  Result := Length(Items);
end;


destructor TacCtrlAdapter.Destroy;
begin
  try
    CleanItems;
    RemoveAllItems;
  finally
    inherited Destroy;
  end;
end;


function TacCtrlAdapter.GetCommonData(Index: integer): TsCommonData;
begin
  Result := nil;
end;


function TacCtrlAdapter.GetItem(Index: integer): TacAdapterItem;
begin
  if IsValidIndex(Index, Count) then
    Result := Items[Index]
  else
    Result := nil;
end;


function TacCtrlAdapter.IndexOf(Ctrl: TWinControl): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Length(Items) - 1 do
    if Items[i].WinCtrl = Ctrl then begin
      Result := i;
      Exit;
    end;
end;


procedure TacCtrlAdapter.RemoveItem(Index: integer);
var
  l: integer;
begin
  l := Count;
  if (Index < l) and (l > 0) then begin
    if Items[Index] <> nil then
      FreeAndNil(Items[Index]);

    Items[Index] := Items[l - 1];
    SetLength(Items, l - 1);
  end;
end;


function TacCtrlAdapter.IsControlSupported(Control: TComponent; ThirdLists: TStringLists): boolean;

  function CheckSkinEvent: boolean;
  var
    CanAdd: boolean;
    SkinParams: TacSkinParams;
  begin
    CanAdd := True;
    SkinParams.UseSkinFontColor := True;
    SkinParams.UseSkinColor := True;
    SkinParams.Control := TControl(Control);

    if Assigned(Provider.OnSkinItem) then
      Provider.FOnSkinItem(Control, CanAdd, SkinParams.SkinSection);

    if Assigned(Provider.FOnSkinItemEx) then
      Provider.FOnSkinItemEx(Control, CanAdd, @SkinParams);

    Result := SkinParams.UseSkinFontColor and CanAdd;
  end;

begin
  Result := False;
  if (Control.Tag and ExceptTag <> 0) or ((Control is TWinControl) and not CtrlIsReadyForHook(TWinControl(Control))) then
    Exit;

  if not (Control is TWinControl) or not WndIsSkinned(TWinControl(Control).Handle) then
    if not (Control is TGraphicControl) or (Control is TSpeedButton) then
      if (Control is TFrame) or (Control is TForm) then
        Result := CheckSkinEvent
      else
        Result := SearchSupport(ThirdLists, Control.ClassName) and CheckSkinEvent
    else
      if Control is TCustomLabel then
        Result := CheckSkinEvent
end;


procedure TacCtrlAdapter.RemoveAllItems;
var
  l: integer;
begin
  if not ItemsRemoving then begin
    ItemsRemoving := True;
    while Length(Items) > 0 do begin
      l := Length(Items);
      if (Items[l - 1] <> nil) then
        if not Items[l - 1].ScrollWnd.Destroyed then
          FreeAndNil(Items[l - 1])
        else begin
          if (Items[l - 1].ScrollWnd <> nil) and (Items[l - 1].ScrollWnd.SkinData <> nil) then
            Items[l - 1].ScrollWnd.SkinData.FOwnerControl := nil;

          FreeAndNil(Items[l - 1]);
        end;

      SetLength(Items, l - 1);
    end;
    while Length(GraphItems) > 0 do begin
      l := Length(GraphItems);
      if Application.Terminated then begin
        GraphItems[l - 1].Ctrl := nil;
        GraphItems[l - 1].Handler.Ctrl := nil;
      end;
      FreeAndNil(GraphItems[l - 1]);
      SetLength(GraphItems, l - 1);
    end;
    ItemsRemoving := False;
  end;
end;


procedure TacCtrlAdapter.WndProc(var Message: TMessage);
var
  i, l: integer;
begin
  l := Length(Items) - 1;
  for i := 0 to l do
    with Items[i] do
      if (ScrollWnd <> nil) and not ScrollWnd.Destroyed and (WinCtrl.Parent <> nil) then
        ScrollWnd.ProcessMessage(Message.Msg, Message.WParam, Message.LParam)
{ // Not used for TSpeedButton because we doesn't know control exists still or not (we haven't a message about control destroying) // }
end;


constructor TacCtrlAdapter.Create(AProvider: TsSkinProvider);
begin
  Provider := AProvider;
  Items := nil;
  ItemsRemoving := False;
  bFlag := False;
end;


procedure TacCtrlAdapter.CleanItems;
var
  i, j, l: integer;
begin
  i := 0;
  while i < Length(Items) do begin
    if (Items[i] = nil) or (not Items[i].Initializing and ((Items[i].ScrollWnd = nil) or Items[i].ScrollWnd.Destroyed)) then begin
      if Items[i] <> nil then
        FreeAndNil(Items[i]);

      l := Length(Items);
      for j := i to l - 2 do begin
        Items[j] := Items[j + 1];
        Items[j + 1] := nil;
      end;
      SetLength(Items, Length(Items) - 1);
    end;
    inc(i)
  end;
  i := 0;
  while i < Length(GraphItems) do begin
    if (GraphItems[i] = nil) or (GraphItems[i].Handler = nil) or GraphItems[i].Handler.Destroyed then begin
      if GraphItems[i] <> nil then
        FreeAndNil(GraphItems[i]);

      for j := i to Length(GraphItems) - 2 do begin
        GraphItems[j] := GraphItems[j + 1];
        GraphItems[j + 1] := nil;
      end;
      SetLength(GraphItems, Length(GraphItems) - 1);
    end;
    inc(i);
  end;
end;


constructor TacAdapterItem.Create(AAdapter: TacCtrlAdapter; ACtrl: TWinControl);
begin
  Adapter := AAdapter;
  WinCtrl := ACtrl;
  ScrollWnd := nil;
  ScrollWnd := nil;
  Initializing := False;
end;


destructor TacAdapterItem.Destroy;
begin
  if ScrollWnd <> nil then
    FreeAndNil(ScrollWnd);

  inherited Destroy;
end;


type
  TAccessForm = class(TForm);

const
  WndTypes: array [TacThirdPartyTypes] of TClass = (TacEditWnd, {$IFDEF D2010}TacButtonWnd{$ELSE}TacBtnWnd{$ENDIF}, TacBitBtnWnd,
    TacCheckBoxWnd, TacComboBoxWnd, TacGridWnd, TacGroupBoxWnd, TacListViewWnd, TacPanelWnd, TacTreeViewWnd, TacWWComboBoxWnd, TacGridEhWnd,
    TacVirtualTreeViewWnd, TacPageControlWnd, TacTabControlWnd, TacToolBarVCLWnd, TacStatusBarWnd, TacEditWnd, TacScrollBoxWnd,
    TacSpinWnd, {$IFDEF ADDWEBBROWSER} TacWBWnd, {$ENDIF} TacSBWnd, TacStaticTextWnd, TacNativePaint);


procedure TacAdapterItem.DoHook(Control: TWinControl; SkinParams: TacSkinParams; AThirdLists: TStringLists);

  procedure SearchSupport(const Lists: TStringLists; const ClName: string);
  var
    i, j: integer;
  begin
    for j := 0 to Length(Lists) - 1 do
      for i := 0 to Lists[j].Count - 1 do
        if Lists[j][i] = ClName then begin
          ScrollWnd := TacScrollWndClass(WndTypes[TacThirdPartyTypes(j)]).Create(Control.Handle, nil, Adapter.Provider.SkinData.SkinManager, SkinParams);
          ScrollWnd.Adapter := Adapter;
          Exit;
        end;
  end;

begin
  if (Control.Tag and ExceptTag = 0) and CtrlIsReadyForHook(Control) and not WndIsSkinned(Control.Handle) and (Adapter.Provider.SkinData.SkinManager <> nil) then begin
    WinCtrl := Control;
    SkinParams.Control := Control;
    Initializing := True;
    SearchSupport(AThirdLists, Control.ClassName);
{
    if Adapter.Provider.OwnThirdLists then
      SearchSupport(Adapter.Provider.ThirdLists, Control.ClassName)
    else
      SearchSupport(Adapter.Provider.SkinData.SkinManager.ThirdLists, Control.ClassName);
}
    Initializing := False;
  end;
end;


procedure TacBorderForm.BorderProc(var Message: TMessage);
var
  M2: TWMNCLButtonDown;
  Rgn, NewRgn: hrgn;
  p, Offs: TPoint;
  M: TWMNCHitTest;
  Form: TForm;
  i: integer;
  cR: TRect;
{$IFNDEF NOWNDANIMATION}
  b: byte;
{$ENDIF}
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_DPICHANGED:
      Message.Result := 1; // The message is handled

{    WM_CLOSE,
    144:
      if TsSkinProvider(FOwner).FormState and FS_RECREATING <> 0 then
        Exit;
}
    WM_CANCELMODE, WM_ENABLE:
      OldBorderProc(Message);

    WM_SETFOCUS:
      if (sp <> nil) and (sp.Form <> nil) and not (csDestroying in sp.Form.ComponentState) and IsWindowVisible(sp.Form.Handle) then
        if sp.Form.CanFocus and sp.Form.Enabled and sp.Form.Visible then
          sp.Form.SetFocus;

    WM_NCMOUSEMOVE: begin
      if SkinData.SkinManager.ActiveGraphControl <> nil then
        SkinData.SkinManager.ActiveGraphControl := nil;

      if LeftPressed then begin
        AForm.SetBounds(AForm.Left + acMousePos.X - LastMousePos.X, AForm.Top + acMousePos.Y - LastMousePos.Y, AForm.Width, AForm.Height);
        LastMousePos := acMousePos;
      end
      else begin
        M.XPos := SmallInt(TWMNCMouseMove(Message).XCursor);
        M.YPos := SmallInt(TWMNCMouseMove(Message).YCursor);
        Message.Result := Ex_WMNCHitTest(M);
        case Message.Result of
          HTCLOSE, HTMINBUTTON, HTMAXBUTTON, HTHELP, HTUDBTN..HTITEM + 100:
            SetHotHT(Message.Result) // Title icon hovered
          else begin
            SetHotHT(0);
            if MaxMoving and IsZoomed(TsSkinProvider(FOwner).Form.Handle) then begin
              p := acMousePos;
              if (abs(LastMousePos.X - p.X) > 5) or (abs(LastMousePos.Y - p.Y) > 5) then begin
                ExBorderShowing := True; // Lock visual changes
                TsSkinProvider(FOwner).Form.WindowState := wsNormal;
                p.X := p.X - TsSkinProvider(FOwner).Form.Width div 2;
                p.Y := iff(BetWeen(p.Y, 0, 24), -8, p.Y - 8);

                TsSkinProvider(FOwner).Form.SetBounds(p.X, p.Y, TsSkinProvider(FOwner).Form.Width, TsSkinProvider(FOwner).Form.Height);
                ExBorderShowing := False; // Unlock visual changes
{$IFNDEF NOWNDANIMATION}
                if SkinData.SkinManager.AnimEffects.BlendOnMoving.Active and
                     not ((SkinData.SkinManager.AnimEffects.BlendOnMoving.BlendValue = MaxByte) or not TsSkinProvider(FOwner).AllowBlendOnMoving) then
                  TsSkinProvider(FOwner).StartMoveForm
                else
{$ENDIF}
                begin
                  M2.Msg := WM_NCLBUTTONDOWN;
                  M2.HitTest := HTCAPTION;
                  with acMousePos do begin
                    M2.XCursor := X;
                    M2.YCursor := Y;
                  end;
                  BorderProc(TMessage(M2));
                end;
                MaxMoving := False;
              end;
            end;
          end;
        end;
      end;
    end;

    WM_MOUSEMOVE, WM_LBUTTONDOWN..WM_MBUTTONDBLCLK:
      if MouseAboveTheShadow(TWMMouse(Message)) and (FormState = 0) then begin
        if SkinData.SkinManager.ActiveGraphControl <> nil then
          SkinData.SkinManager.ActiveGraphControl := nil;

        acInMouseMsg := True;
        NewRgn := CreateRectRgn(TWMMouse(Message).XPos, TWMMouse(Message).YPos, TWMMouse(Message).XPos + 1, TWMMouse(Message).YPos + 1);
        Rgn := MakeRgn;
        if Rgn = 0 then
          Rgn := CreateRectRgn(0, 0, AForm.Width, AForm.Height);

        CombineRgn(Rgn, Rgn, NewRgn, RGN_XOR);
        DeleteObject(NewRgn);
        if FOwner is TsSkinProvider then
          if not (fsModal in TAccessForm(TsSkinProvider(FOwner).Form).FormState {Report builder repainting bug} ) then
            SetWindowRgn(AForm.Handle, Rgn, False)
          else
            DeleteObject(Rgn)
        else
          SetWindowRgn(AForm.Handle, Rgn, False);

        ResetRgn := True;
        acInMouseMsg := False;
      end;

    WM_NCHITTEST:
      if MouseAboveTheShadow(TWMMouse(Message)) then begin
        Message.Result := HTTRANSPARENT;
        OldBorderProc(Message);
      end
      else begin
        OldBorderProc(Message);
        Message.Result := LRESULT(Windows.HTOBJECT);
      end;

    WM_NCLBUTTONDBLCLK: begin
      MaxMoving := False;
      if FOwner is TsSkinProvider then
        with TsSkinProvider(FOwner), TWMMouse(Message) do
          if (ResizeMode = rmBorder) and bInProcess then begin
            p := Form.ClientToScreen(Point(XPos, YPos));
            StopMove(p.x, p.y);
            ReleaseCapture;
            bInProcess := False;
          end;

      TWMNCHitMessage(Message).HitTest := Ex_WMNCHitTest(TWMNCHitTest(Message));
      if FOwner is TsSkinProvider then
        case TWMNCHitMessage(Message).HitTest of
          HTSYSMENU:
            SendMessage(OwnerHandle, WM_SYSCOMMAND, SC_CLOSE, 0);

          HTCAPTION:
            with TsSkinProvider(FOwner) do begin
              if HaveSysMenu and (SystemMenu.EnabledMax or SystemMenu.EnabledRestore) or not HaveBorder(TsSkinProvider(FOwner)) and IsIconic(TsSkinProvider(FOwner).Form.Handle) then begin
                SendMessage(Form.Handle, WM_SYSCOMMAND, StateFlags[(Form.WindowState = wsMaximized) or IsIconic(Form.Handle)], 0);
                SystemMenu.UpdateItems;
              end
              else
                if IsIconic(Form.Handle) then begin
                  SendMessage(Form.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
                  SystemMenu.UpdateItems;
                end;

              TWMNCHitMessage(Message).HitTest := 0;
            end;

          HTRIGHT, HTLEFT: begin
            Form := sp.Form;
            if Form.BorderStyle = bsSizeable then
              if FormState and FS_MAXWIDTH <> 0 then begin
                Form.SetBounds(sp.NormalBounds.Left, sp.Form.Top, sp.NormalBounds.Right, Form.Height);
                sp.FormState := sp.FormState and not FS_MAXWIDTH;
              end
              else begin
                cR := acWorkRect(Form);
                i := DiffBorder(Self);
                sp.NormalBounds.Left  := Form.Left;
                sp.NormalBounds.Right := Form.Width;
                Form.SetBounds(cR.Left + i, Form.Top, WidthOf(cR) - 2 * i, Form.Height);
                sp.FormState := sp.FormState or FS_MAXWIDTH;
              end;
          end;

          HTTOP, HTBOTTOM: begin
            Form := sp.Form;
            if Form.BorderStyle = bsSizeable then
              if FormState and FS_MAXHEIGHT <> 0 then begin
                Form.SetBounds(Form.Left, sp.NormalBounds.Top, Form.Width, sp.NormalBounds.Bottom);
                sp.FormState := sp.FormState and not FS_MAXHEIGHT;
              end
              else begin
                cR := acWorkRect(Form);
                i := DiffTitle(Self);
                sp.NormalBounds.Top := Form.Top;
                sp.NormalBounds.Bottom := Form.Height;
                Form.SetBounds(Form.Left, cR.Top + i, Form.Width, HeightOf(cR) - i - DiffBorder(Self));
                sp.FormState := sp.FormState or FS_MAXHEIGHT;
              end;
          end;

          HTITEM..HTITEM + MaxByte:
            with TsSkinProvider(FOwner) do
              if (FOwner is TsSkinProvider) and Assigned(FTitleBar) then
                with TWMNCHitMessage(Message), FTitleBar.Items[HitTest - HTITEM] do begin
                  if Timer <> nil then
                    FreeAndNil(Timer);

                  if (Style in [bsMenu, bsButton]) and ((DropDownMenu = nil) or (DropDownMenu.Items.Count = 0)) then
                    with TsSkinProvider(sp) do begin
                      if (BorderForm <> nil) and (BorderForm.AForm <> nil) then begin
                        SendMessage(BorderForm.AForm.Handle, WM_NCLBUTTONDOWN, Message.WParam, Message.LParam);
                        SendMessage(BorderForm.AForm.Handle, WM_NCLBUTTONUP, Message.WParam, Message.LParam);
                      end;
                    end
                  else
                    DoMouseDown(mbLeft, [], TWMMouse(Message).XPos, TWMMouse(Message).YPos);
                end;
        end;
    end;

    WM_SETCURSOR: begin
      if (FOwner is TsSkinProvider) and Assigned(TsSkinProvider(FOwner).FTitleBar) and IsValidIndex(TsSkinProvider(FOwner).CurrentHT - HTITEM, TsSkinProvider(FOwner).TitleBar.Items.Count) then
      // Skip, if TitleItem.Cursor is used
      else
        if not Ex_WMSetCursor(TWMSetCursor(Message)) then
          OldBorderProc(Message);
    end;

    WM_MOUSEACTIVATE: begin
      Message.Result := MA_NOACTIVATE;
      if CanBringForm then
        SetForegroundWindow(OwnerHandle);
    end;

    WM_NCRBUTTONUP:
      if not MouseAboveTheShadow(TWMMouse(Message)) then begin
        TWMNCLButtonDown(Message).HitTest := HTTRANSPARENT;
        SendMessage(OwnerHandle, Message.Msg, Message.wParam, Message.lParam);
      end;

    WM_NCLBUTTONUP:
      if not MouseAboveTheShadow(TWMMouse(Message)) then begin
        MaxMoving := False;
        TWMNCLButtonDown(Message).HitTest := HTTRANSPARENT;
        SendMessage(OwnerHandle, Message.Msg, Message.wParam, Message.lParam);
      end;

    WM_NCRBUTTONDOWN:
      if not MouseAboveTheShadow(TWMMouse(Message)) then begin
        TWMNCLButtonDown(Message).HitTest := Ex_WMNCHitTest(TWMNCHitTest(Message));
        SendMessage(OwnerHandle, Message.Msg, Message.wParam, Message.lParam);
      end;

    WM_NCLBUTTONDOWN:
      if not MouseAboveTheShadow(TWMMouse(Message)) then begin
{$IFNDEF ALITE}
        if GetIntController <> nil then
          GetIntController.KillAllForms(nil);
{$ENDIF}

        ExBorderShowing := False;
        if not MaxMoving then
          TWMNCLButtonDown(Message).HitTest := HTTRANSPARENT;
{$IFNDEF NOWNDANIMATION}
        i := Ex_WMNCHitTest(TWMNCHitTest(Message));
        case i of
          HTSYSMENU: begin
            SendMessage(OwnerHandle, Message.Msg, i, Message.lParam);
            Exit;
          end;

          HTCAPTION:
            if FOwner is TsSkinProvider then
              if not IsZoomed(OwnerHandle) then begin
                if SkinData.SkinManager.AnimEffects.BlendOnMoving.Active and
                     not IsIconic(OwnerHandle) and not (AeroIsEnabled and
                       ((SkinData.SkinManager.AnimEffects.BlendOnMoving.BlendValue = MaxByte) or
                         not TsSkinProvider(FOwner).AllowBlendOnMoving){ AlphaMoving is not required then begin} ) then begin
                  StartBlendOnMoving(TsSkinProvider(FOwner));
                  Exit;
                end;
              end
              else begin // Emulation of Aero behaviour
                MaxMoving := True;
                LastMousePos := acMousePos;
                Exit;
              end
            else
              if SkinData.SkinManager.AnimEffects.BlendOnMoving.Active then begin
                StartBlendOnMovingDlg(TacDialogWnd(FOwner));
                Exit;
              end;
        end;
        if not MaxMoving then
          TWMNCLButtonDown(Message).HitTest := HTTRANSPARENT;
{$ENDIF}
        SendMessage(OwnerHandle, Message.Msg, Message.wParam, Message.lParam);
      end;

    WM_WINDOWPOSCHANGING:
      if (FOwner is TsSkinProvider) and (FormState and FS_BLENDMOVING <> 0) and (sp.BorderForm <> nil) and (sp.BorderForm.AForm <> nil) then begin
        if TsSkinProvider(FOwner).FScreenSnap and not IsZoomed(TsSkinProvider(FOwner).Form.Handle) then
          with TWMWindowPosChanging(Message) do
            if (WindowPos^.X <> 0) or (WindowPos^.Y <> 0) then begin
                if (SkinData.CommonSkinData.ExDrawMode = 0) or (SkinData.SkinManager.ExtBordersMode <> ebmFull) then begin
                  Offs.X := DiffBorder(Self) + ShadowSize.Left;
                  Offs.Y := DiffTitle(Self)  + ShadowSize.Top;
                end
                else begin
                  Offs.X := DiffBorder(Self) + SkinData.CommonSkinData.ExContentOffs;
                  Offs.Y := DiffTitle(Self)  + SkinData.CommonSkinData.ExContentOffs;
                end;
                // New topleft position of visible form
                p := Point(WindowPos^.X + Offs.X, WindowPos^.Y + Offs.Y);
                TsSkinProvider(FOwner).CheckNewPosition(p.X, p.Y);
                WindowPos^.X := p.X - Offs.X;
                WindowPos^.Y := p.Y - Offs.Y;
              end;

        OldBorderProc(Message);
        sp.BorderForm.LastTopLeft := sp.BorderForm.AForm.BoundsRect.TopLeft;
      end
      else
        OldBorderProc(Message);

{$IFNDEF NOWNDANIMATION}
    WM_SHOWWINDOW:
      if acLayered and (FOwner is TsSkinProvider) and
           not InAnimationProcess{$IFDEF D2007} and Application.MainFormOnTaskBar {$ENDIF} and
             TsSkinProvider(FOwner).CanDrawNCArea and
               (TsSkinProvider(FOwner).Form = Application.MainForm) then begin

        if (Message.WParam = 0) and (Message.LParam in [0, SW_PARENTCLOSING]) then
          if FormState and FS_ANIMMINIMIZING <> 0 then begin
            Message.Result := 0;
            Exit;
          end
          else
            if FormState and FS_ANIMCLOSING = 0 then begin // Prepare cache if closed with Application.MainFormOnTaskBar (Animation in Application terminating)
              if TsSkinProvider(FOwner).AllowAnimation and
                   SkinData.SkinManager.AnimEffects.FormHide.Active and
                     SkinData.SkinManager.Effects.AllowAnimation and
                       (TsSkinProvider(FOwner).SkinData.SkinManager.ShowState <> saMinimize) then begin // Patch for BDS when MainFormOnTaskBAr
                TsSkinProvider(FOwner).FormState := TsSkinProvider(FOwner).FormState or FS_ANIMCLOSING;
                TsSkinProvider(FOwner).SkinData.FCacheBmp := GetFormImage(TsSkinProvider(FOwner), True);
                ExBorderShowing := True;
{$IFDEF DELPHI7UP}
                if TsSkinProvider(FOwner).Form.AlphaBlend then
                  b := TsSkinProvider(FOwner).Form.AlphaBlendValue
                else
{$ENDIF}
                  b := MaxByte;
{$IFDEF D2010}
                if not Application.MainFormOnTaskBar then // Ignore std closing of ext borders
{$ENDIF}
                begin
                  SetFormBlendValue(AForm.Handle, SkinData.FCacheBmp, b);
                  SetWindowRgn(AForm.Handle, MakeRgn, False);
                  SetWindowPos(AForm.Handle, 0, 0, 0, 0, 0, SWPA_SHOWZORDERONLY);
                end;
                Exit;
              end;
            end
            else
              Exit;

        OldBorderProc(Message);
      end
      else
        if TsSkinProvider(FOwner).Form = Application.MainForm then
{$IFDEF D2010}
          if not Application.Terminated and not Application.MainFormOnTaskBar or (Message.WParam = 1) then // Ignore std closing of ext borders
{$ENDIF}
            OldBorderProc(Message);
{$ENDIF}

    WM_MOVE:
      if sp <> nil then begin
        if (sp.FormState and FS_BLENDMOVING <> 0) and ((AForm.Top < MinTopCoord) or MovRgnChanged) then begin
          ResetRgn := True;
          UpdateRgn;
        end;
        sp.MoveGluedForms(True);
      end;

    WM_ERASEBKGND, WM_NCPAINT:;

    WM_WINDOWPOSCHANGED: begin
      KillAnimations;
      OldBorderProc(Message);
      if (sp <> nil) and not (csDestroying in sp.ComponentState) and not (csDestroying in sp.Form.ComponentState) and (AForm <> nil) and not (csDestroying in AForm.ComponentState) then begin
        if (sp.FormTimer = nil) and IsIconic(sp.Form.Handle) then
          if sp.FormState and FS_ANIMMINIMIZING = 0 then begin { Form.WindowState = wsMinimized}
            sp.SkinData.BGChanged := True;
            UpdateExBordersPos(False);
          end;

        if (sp.Form.FormStyle = fsStayOnTop) and AForm.HandleAllocated then
          SetWindowPos(AForm.Handle, iff(AeroIsEnabled and (Application.MainForm = sp.Form) and (GetActiveWindow = sp.Form.Handle), GetTopWnd{HWND_TOPMOST}, sp.Form.Handle),
                      0, 0, 0, 0, SWPA_SHOWZORDERONLY)
      end;
    end

    else
      OldBorderProc(Message);
  end;
end;


constructor TacBorderForm.Create(AOwner: TObject);
begin
  FOwner := AOwner;
  if FOwner is TsSkinProvider then
    sp := TsSkinProvider(FOwner)
  else
    sp := nil;

  LeftPressed := False;
  LastMousePos := Point(-9999, -9999);
  ParentHandle := 0;
  MainRgnReady := False;
  ExBorderShowing := False;
  ResetRgn := False;
  MovRgnChanged := False;
  CreateNewForm;
end;


destructor TacBorderForm.Destroy;
var
  i: integer;
begin
  KillAnimations;
  FreeAndNil(AForm);
  if Assigned(sp) and not (csDestroying in sp.ComponentState) and Assigned(sp.FTitleBar) then
    with sp.FTitleBar do
      if Assigned(Items) then
        for i := 0 to Items.Count - 1 do
          Items[i].ExtForm := nil;

  inherited;
end;


function TacBorderForm.Ex_WMNCHitTest(var Message: TWMNCHitTest): integer;
const
  BtnSpacing = 1;
  DefRESULT = HTTRANSPARENT;
var
  p: TPoint;
  Handle: hwnd;
  SysMenu: TsCustomSysMenu;
  rShadow, R, hrect, vrect: TRect;
  i, SysBtnCount, actBtnIndex, BtnIndex: integer;
  GripVisible, HelpIconVisible, CloseIconVisible: boolean;

  function GetBtnIndex: integer;
  var
    i, c: integer;
  begin
    Result := 0;
    c := 0;
    if FOwner is TsSkinProvider then
      with TsSkinProvider(FOwner) do begin
        if SystemMenu = nil then // not initialize yet
          Exit;

        if HaveSysMenu and Assigned(SystemMenu) then begin
          inc(c);
          if PtInRect(ButtonClose.cpRect, p) then
            Result := c
          else begin
            if SystemMenu.VisibleMax then begin
              inc(c);
              if PtInRect(ButtonMax.cpRect, p) then begin
                Result := c;
                Exit;
              end;
            end;
            if SystemMenu.VisibleMin then begin
              inc(c);
              if PtInRect(ButtonMin.cpRect, p) then
                Result := c;
            end;
            if Result <> 0 then
              Exit;

            if (biHelp in Form.BorderIcons) then begin
              inc(c);
              if PtInRect(ButtonHelp.cpRect, p) then begin
                Result := c;
                Exit;
              end;
            end;
          end;
        end;
        for i := 0 to TitleButtons.Count - 1 do begin
          inc(c);
          if not TitleButtons[i].Visible then
            Continue;

          if PtInRect(TitleButtons[i].Data.cpRect, p) then begin
            Result := c;
            Exit;
          end;
        end;
        // Title bar items
        if FTitleBar <> nil then
          for i := 0 to FTitleBar.Items.Count - 1 do begin
            inc(c);
            if not FTitleBar.Items[i].Visible then
              Continue;

            if PtInRect(FTitleBar.Items[i].Rect, p) then begin
              Result := iff(FTitleBar.Items[i].Style in [bsSpacing, bsInfo], 0, c);
              Exit;
            end;
          end;
      end
    else
      with FOwner as TacDialogWnd do begin
        inc(c);
        if PtInRect(ButtonClose.cpRect, p) then
          Result := c
        else begin
          if TacAccessDialogWnd(FOwner).SystemMenu.VisibleMax then begin
            inc(c);
            if PtInRect(ButtonMax.cpRect, p) then begin
              Result := c;
              Exit;
            end;
          end;
          if TacAccessDialogWnd(FOwner).SystemMenu.VisibleMin then begin
            inc(c);
            if PtInRect(ButtonMin.cpRect, p) then
              Result := c
          end;
          if Result = 0 then
            if TacAccessDialogWnd(FOwner).VisibleHelp then begin
              inc(c);
              if PtInRect(ButtonHelp.cpRect, p) then begin
                Result := c;
                Exit;
              end;
            end;
        end;
      end
  end;

begin
  if FOwner is TsSkinProvider then begin
    Message.Result := Windows.HTNOWHERE;
    if msAnimScaling in TsSkinProvider(FOwner).SkinData.SkinManager.ManagerState then begin
      Result := Windows.HTNOWHERE;
      Exit;
    end;
    if Assigned(sp.FOnExtHitTest) then
      sp.FOnExtHitTest(TWMNcHitTest(Message));

    if Message.Result <> Windows.HTNOWHERE then begin
      Result := Message.Result;
      Exit;
    end;
  end;
  Result := DefRESULT;
  if IsWindowEnabled(OwnerHandle) then begin
    p := Point(Message.XPos - AForm.Left, Message.YPos - AForm.Top);
    if FOwner is TsSkinProvider then begin
      SysMenu := sp.SystemMenu;
      Handle := sp.Form.Handle;
      CloseIconVisible := sp.HaveSysMenu;
    end
    else begin
      SysMenu := TacAccessDialogWnd(FOwner).SystemMenu;
      Handle := TacAccessDialogWnd(FOwner).CtrlHandle;
      CloseIconVisible := TacAccessDialogWnd(FOwner).SystemMenu.VisibleClose;
    end;
    rShadow := ShadowSize;
    HelpIconVisible := GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CONTEXTHELP <> 0;
    with FOwner do begin
      BtnIndex := GetBtnIndex;
      if BtnIndex > 0 then begin
        SysBtnCount := 0;
        actBtnIndex := 0;
        if CloseIconVisible then begin
          inc(SysBtnCount);
          if SysBtnCount = BtnIndex then
            actBtnIndex := 1; // Close

          if SysMenu.VisibleMax then begin
            inc(SysBtnCount);
            if SysBtnCount = BtnIndex then
              actBtnIndex := 2; // Max
          end;
          if SysMenu.VisibleMin or IsIconic(OwnerHandle) then begin
            inc(SysBtnCount);
            if SysBtnCount = BtnIndex then
              actBtnIndex := 3; // Min
          end;
          if HelpIconVisible then begin
            inc(SysBtnCount);
            if SysBtnCount = BtnIndex then
              actBtnIndex := 4; // Help
          end;
        end;
        if BtnIndex <= SysBtnCount then begin
          case actBtnIndex of
            1:
              if CloseIconVisible then
                if FOwner is TsSkinProvider then
                  if sp.SystemMenu.VisibleClose then
                    Result := iff(sp.SystemMenu.EnabledClose, HTCLOSE, HTCAPTION)
                  else
                    Result := Windows.HTNOWHERE
                else
                  Result := iff(TacAccessDialogWnd(FOwner).EnabledClose, HTCLOSE, Windows.HTNOWHERE);

            2:
              if SysMenu.VisibleMax then
                Result := iff(SysMenu.EnabledMax or (SysMenu.EnabledRestore and not IsIconic(Handle)), HTMAXBUTTON, HTCAPTION)
              else
                if (SysMenu.VisibleMin) or IsIconic(Handle) then
                  Result := iff(SysMenu.EnabledMin, HTMINBUTTON, HTCAPTION)
                else
                  if HelpIconVisible then
                    Result := HTHELP;

            3:
              if (SysMenu.VisibleMin) or IsIconic(Handle) then
                if not IsIconic(Handle) then
                  Result := iff(SysMenu.EnabledMin, HTMINBUTTON, HTCAPTION)
                else
                  Result := HTMINBUTTON
              else
                if HelpIconVisible then
                  Result := HTHELP;

            4:
              if HelpIconVisible {and SysMenu.VisibleMax} then
                Result := HTHELP;
          end;
        end
        else
          if FOwner is TsSkinProvider then
            if BtnIndex <= sp.TitleButtons.Count + SysBtnCount then begin // UDF button
              BtnIndex := BtnIndex - SysBtnCount - 1;
              if sp.TitleButtons.Items[BtnIndex].Enabled then
                Result := HTUDBTN + BtnIndex;
            end
            else
              if sp.FTitleBar <> nil then begin
                BtnIndex := BtnIndex - SysBtnCount - sp.TitleButtons.Count - 1;
                if sp.FTitleBar.Items[BtnIndex].Enabled and ((sp.FTitleBar.Items[BtnIndex].Style <> bsTab) or not sp.FTitleBar.Items[BtnIndex].Down) then
                  Result := HTITEM + BtnIndex;
              end;

        if Result <> DefRESULT then
          Exit;
      end;

     if not IsZoomed(Handle) and ((GetWindowLong(Handle, GWL_STYLE) and WS_SIZEBOX <> 0) or (sp <> nil) and (sp.FluentBorderStyle = bsSizeable){ sp.IsBlurred}) then
        with SkinData.CommonSkinData do
          if (ExDrawMode = 1) and (SkinData.SkinManager.ExtBordersMode = ebmFull) {or sp.IsBlurred} then begin // If borders replaced
            i := SysBorderWidth(Handle, Self, False);
            if (i = 0) and (sp <> nil) and sp.UWPMode and (sp.FluentBorderStyle = bsSizeable) then
              i := 4;

            R := Rect(rShadow.Left - ExShadowOffs, rShadow.Top - ExShadowOffsT, AForm.Width - rShadow.Right + ExShadowOffsR, AForm.Height - rShadow.Bottom + ExShadowOffsB);
            if PtInRect(R, p) then begin
              if Between(p.Y, rShadow.Top - ExShadowOffsT, 4{SysBorderWidth(Handle, Self, False)} + rShadow.Top - ExShadowOffsT) then
                Result := HTTOP;

              if Between(p.Y, AForm.Height - i - rShadow.Bottom + ExShadowOffsB, AForm.Height - rShadow.Bottom + ExShadowOffsB) then
                Result := HTBOTTOM;

              if Between(p.X, rShadow.Left - ExShadowOffs, 4 + rShadow.Left - ExShadowOffs) then
                if Result = HTTOP then
                  Result := HTTOPLEFT
                else
                  Result := iff(Result = HTBOTTOM, HTBOTTOMLEFT, HTLEFT);

              if Between(p.X, AForm.Width - 4 - rShadow.Right + ExShadowOffsR, AForm.Width - rShadow.Right + ExShadowOffsR) then
                if Result = HTTOP then
                  Result := HTTOPRIGHT
                else
                  Result := iff(Result = HTBOTTOM, HTBOTTOMRIGHT, HTRIGHT);

              if Result <> DefRESULT then
                Exit;
            end;
          end
          else begin
            i := max(ExBorderWidth, iMinBorderSize);
            if Between(p.Y, rShadow.Top - i, rShadow.Top) then
              Result := HTTOP;

            if Between(p.Y, AForm.Height - rShadow.Bottom, AForm.Height - rShadow.Bottom + i) then
              Result := HTBOTTOM;

            if Between(p.X, rShadow.Left - i, rShadow.Left) then
              if Result = HTTOP then
                Result := HTTOPLEFT
              else
                Result := iff(Result = HTBOTTOM, HTBOTTOMLEFT, HTLEFT);

            if Between(p.X, AForm.Width - rShadow.Right, AForm.Width - rShadow.Right + i) then
              if Result = HTTOP then
                Result := HTTOPRIGHT
              else
                Result := iff(Result = HTBOTTOM, HTBOTTOMRIGHT, HTRIGHT);

            if Result <> DefRESULT then
              Exit;
          end;

      if Between(p.Y, 0, CaptionHeight + SysBorderHeight(OwnerHandle, Self) + rShadow.Top) then
        Result := iff(PtInRect(IconRect, p), HTSYSMENU, HTCAPTION)
      else
        if p.Y <= CaptionHeight + SysBorderHeight(OwnerHandle, Self) + MenuHeight then
          Result := HTMENU
        else
          if PtInRect(Rect(ShadowSize.Left, ShadowSize.Top, AForm.Width - ShadowSize.Right, AForm.Height - ShadowSize.Bottom), p) then begin // Grip?
            GripVisible := False;
            if FOwner is TsSkinProvider then
              with TsSkinProvider(FOwner) do
                if IsGripVisible(TsSkinProvider(FOwner)) then
                  GripVisible := True
                else
                  if Assigned(ListSW) and Assigned(ListSW.sbarVert) and ListSW.sbarVert.fScrollVisible and ListSW.sbarHorz.fScrollVisible then begin
                    Ac_GetHScrollRect(ListSW, Form.Handle, hrect);
                    Ac_GetVScrollRect(ListSW, Form.Handle, vrect);
                    GetWindowRect(Form.Handle, R);
                    GripVisible := PtInRect(Rect(hrect.Right - R.Left, hrect.Top - R.Top, vrect.Right - R.Left, hrect.Bottom - R.Top), p)
                  end;

            if GripVisible then begin
              i := SkinData.CommonSkinData.GripRightBottom;
              if SkinData.SkinManager.IsValidImgIndex(i) then
                if (p.y > TsSkinProvider(FOwner).RBGripPoint(i).y) and (p.x > TsSkinProvider(FOwner).RBGripPoint(i).x) then
                  Result := HTBOTTOMRIGHT;
            end;
          end;
    end;
  end;
end;


function TacBorderForm.Ex_WMSetCursor(var Message: TWMSetCursor): boolean;
var
  M: TWMNCHitTest;
  nCursor: HCURSOR;
begin
  Result := False;
  if (sp = nil) or not (msAnimScaling in TsSkinProvider(sp).SkinData.SkinManager.ManagerState) then begin
    M.Msg := WM_NCHitTest;
    M.XPos := SmallInt(acMousePos.X);
    M.YPos := SmallInt(acMousePos.Y);
    M.Unused := 0;
    M.Result := 0;
    Message.HitTest := {$IFDEF D2009}SmallInt{$ELSE}Word{$ENDIF}(Ex_WMNCHitTest(M));
    if not MouseAboveTheShadow(TWMMouse(M)) then begin
      nCursor := 0;
      case Message.HitTest of
        HTCAPTION, HTMENU:        nCursor := LoadCursor(0, IDC_ARROW);
        HTLEFT, HTRIGHT:          nCursor := LoadCursor(0, IDC_SIZEWE);
        HTTOP, HTBOTTOM:          nCursor := LoadCursor(0, IDC_SIZENS);
        HTTOPRIGHT, HTBOTTOMLEFT: nCursor := LoadCursor(0, IDC_SIZENESW);
        HTTOPLeft, HTBOTTOMRIGHT: nCursor := LoadCursor(0, IDC_SIZENWSE)
      end;
      if nCursor <> 0 then begin
        SetCursor(nCursor);
        Result := True;
      end;
    end;
  end;
end;


function TacBorderForm.MouseAboveTheShadow(Message: TWMMouse): boolean;
var
  p: TPoint;
  i: integer;
begin
  Result := False;
  if (SkinData.SkinManager <> nil) and (FormState and FS_BLENDMOVING = 0) and not (msAnimScaling in SkinData.SkinManager.ManagerState) and not Locked then begin
    UpdateRgn;
    if not (csDestroying in Application.ComponentState) and
         (SkinData <> nil) and
           (AForm <> nil) and
             (Self.SkinData.SkinManager <> nil) and
               Self.SkinData.SkinManager.Active then begin
      if Message.Msg = WM_MOUSEMOVE then
        p := Point(Message.XPos, Message.YPos)
      else
        p := Point(Message.XPos - AForm.Left, Message.YPos - AForm.Top);

      if not IsZoomed(OwnerHandle) then
        with SkinData.CommonSkinData do
          if (ExDrawMode = 1) and (SkinData.SkinManager.ExtBordersMode = ebmFull) then begin
            if (p.Y < ShadowSize.Top - ExShadowOffsT) or
                 (p.Y > AForm.Height - ShadowSize.Bottom + ExShadowOffsB) or
                   (p.X < ShadowSize.Left - ExShadowOffs) or
                     (p.X > AForm.Width - ShadowSize.Right + ExShadowOffsR) then begin
              Result := True;
              SetHotHT(HTTRANSPARENT);
            end;
          end
          else begin
            i := max(iMinBorderSize, ExBorderWidth);
            if (p.Y < ShadowSize.Top - i) or
                 (p.Y > AForm.Height - ShadowSize.Bottom + i) or
                   (p.X < ShadowSize.Left - i) or
                     (p.X > AForm.Width - ShadowSize.Right + i) then begin
              Result := True;
              SetHotHT(HTTRANSPARENT);
            end;
          end;
    end;
  end;
end;


const
  wScreenOffset = {$IFDEF D2010} 90 {$ELSE} {$IFDEF D2009} 86 {$ELSE} 90 {$ENDIF} {$ENDIF};

type
  TOffsetArray = array [0..wScreenOffset] of byte;

  TAccessScreen = class(TComponent)
  public
    Offset: TOffsetArray;
    FAlignLevel: Word;
  end;

  
procedure TacBorderForm.UpdateExBordersPos(Redraw: boolean = True; Blend: byte = MaxByte);
const
//  DebugOffsX = 100; DebugOffsY = 100;
  DebugOffsX = 0; DebugOffsY = 0;
var
  bRgn: hrgn;
  oWnd: THandle;
  FBmpSize: TSize;
  Flags: Cardinal;
  iInsAfter: hwnd;
  SavedDC, DC: hdc;
  ShSize, R, fR: TRect;
  bSizeChanged: boolean;
  FBlend: TBlendFunction;
  p, FBmpTopLeft: TPoint;
  w, h, cy, cx, yAeroTab: integer;

  procedure MakeBluringRgn;
  var
    subrgn: hrgn;
    Offset: integer;

    procedure HandleRect(R: TRect);
    var
      S0, S: PRGBAArray_;
      DeltaS, X, Y, minY, maxY, minX, maxX: integer;
    begin
      minY := max(R.Top, 0);
      maxY := min(R.Bottom, SkinData.FCacheBmp.Height - 1);
      minX := max(R.Left, 0);
      maxX := min(R.Right, SkinData.FCacheBmp.Width - 1);
      if InitLine(SkinData.FCacheBmp, Pointer(S0), DeltaS) then
        for Y := minY to maxY do begin
          S := Pointer(PAnsiChar(S0) + DeltaS * (Y));
          for X := minX to maxX do
            with S[X] do
              if (R = 0) and (G = 0) and (B = 0) then begin // Black color is not blurred
                subrgn := CreateRectRgn(X, Y, X + 1, Y + 1);
                CombineRgn(bRgn, bRgn, subrgn, RGN_DIFF);
                DeleteObject(subrgn);
              end;
        end;
    end;

  begin
    fR := Rect(ShSize.Left - 1, ShSize.Top - 1, AForm.Width - ShSize.Right + 1, AForm.Height - ShSize.Bottom + 1);
    bRgn := CreateRectRgn(fR.Left, fR.Top, fR.Right, fR.Bottom);
    Offset := SkinData.CommonSkinData.ExContentOffs;
    // Top left
    R := Rect(fR.Left, fR.Top, fR.Left + Offset, fR.Top + Offset);
    HandleRect(R);
    // Top rigth
    R := Rect(fR.Right - Offset, fR.Top, fR.Right, fR.Top + Offset);
    HandleRect(R);
    // Bottom left
    R := Rect(fR.Left, fR.Bottom - Offset, fR.Left + Offset, fR.Bottom);
    HandleRect(R);
    // Bottom right
    R := Rect(fR.Right - Offset, fR.Bottom - Offset, fR.Right, fR.Bottom);
    HandleRect(R);
  end;

begin
  if not Locked then
    with FOwner do begin
      oWnd := OwnerHandle;
      if Application.Terminated or ExBorderShowing or (oWnd = 0) or not GetWindowRect(oWnd, fR) or (SkinData.PrintDC <> 0) or InAnimationProcess then
        Exit;

      if (sp <> nil) and (fR.Left <> sp.Form.Left) and not IsIconic(oWnd) or (FormState and (FS_ANIMSHOWING or FS_SCALING) <> 0) then
        Exit; // Window Rect is not correct

      if AForm = nil then
        CreateNewForm;

      if sp <> nil then begin
        if sp.SkinData.CtrlSkinState and ACS_LOCKED <> 0 then
          Exit;

        if InAnimation(sp) or SkinData.FUpdating or not sp.CanDrawNCArea or (TAccessScreen(Screen).FAlignLevel = 1) then
          Exit;

        if (csDestroying in sp.ComponentState) or (csDestroying in sp.Form.ComponentState) then begin
          sp.InitExBorders(False);
          Exit;
        end
        else
          if not (IsWindowVisible(sp.Form.Handle) or ((sp.FormState <> 0) and (sp.FormState <> FS_ACTIVATE))) then begin
            FreeAndNil(AForm);
            SkinData.BGChanged := True; // Whole image will be redrawn later
            Exit;
          end;

        ExBorderShowing := True;
        if sp.Form.FormStyle = fsStayOnTop then begin // Patch for a Delphi problem concerning StayOnTop forms
          if GetActiveWindow = ownd then begin
            if not SetWindowPos(oWnd, HWND_TOP, 0, 0, 0, 0, SWPA_ZORDER) then
              CheckLastError;

            if AForm = nil then
              CreateNewForm;
          end;
        end
        else
          if GetWindowLong(oWnd, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0 then begin
            if not SetWindowPos(oWnd, HWND_TOPMOST, 0, 0, 0, 0, SWPA_ZORDER) then
              CheckLastError;

            if AForm = nil then
              CreateNewForm;
          end;

        if FormState and FS_SIZING = 0 then
          iInsAfter := GetTopWnd
        else
          iInsAfter := 0;

        ExBorderShowing := True;
        yAeroTab := 0;
      end
      else begin // sp = nil
        if not IsWindowVisible(oWnd) then
          Exit; // If dialog is not visible still

        ExBorderShowing := True;
        Flags := GetWindowLong(oWnd, GWL_EXSTYLE);
        if Flags and WS_EX_TOPMOST <> 0 then begin
          if GetActiveWindow = ownd then begin
            if not SetWindowPos(oWnd, HWND_TOPMOST, 0, 0, 0, 0, SWPA_ZORDER) then
              CheckLastError;
          end;
          iInsAfter := HWND_TOPMOST;
        end
        else
          iInsAfter := HWND_TOP;

        yAeroTab := 0;
      end;
      ShSize := ShadowSize;
      cy := OffsetY;
      cx := OffsetX;

      if (FormState and FS_FULLPAINTING <> 0) {or SkinIsChanging(SkinData)} then begin
        if SkinData.BGChanged then begin
          if (sp <> nil) and (sp.FormState and FS_SCALING <> 0) then begin
            sp.FormState := sp.FormState and not FS_BLENDMOVING;
            PaintAll;
            sp.FormState := sp.FormState or FS_BLENDMOVING;
          end
          else
            PaintAll;
        end;

        Redraw := True;
        if sp <> nil then begin
          GetWindowRect(oWnd, R);
          if not InAnimation(sp) and (sp.SkinData.FCacheBmp <> nil) and (R.Right <= acWorkRect(sp.Form).Right) and (R.Bottom <= acWorkRect(sp.Form).Bottom) and not sp.SystemBlur.Active then begin
            // Fast screen copying
            DC := GetWindowDC(oWnd);
            SavedDC := SaveDC(DC);
            try
              R := ACClientRect(oWnd);
              BitBlt(SkinData.FCacheBmp.Canvas.Handle, cx + R.Left, cy + R.Top, WidthOf(R), HeightOf(R), DC, R.Left, R.Top, SRCCOPY);
              FillAlphaRect(SkinData.FCacheBmp, Rect(cx + R.Left, cy + R.Top, cx + R.Left + WidthOf(R), cy + R.Top + HeightOf(R)), MaxByte);
            finally
              RestoreDC(DC, SavedDC);
              ReleaseDC(oWnd, DC);
            end;
          end
          else
            sp.SkinData.FCacheBmp := GetFormImage(sp, True);

          SendAMessage(sp.Form.Handle, AC_PAINTFLOATITEMS, LPARAM(sp.SkinData.FCacheBmp)); // Paint float buttons
        end
        else begin // sp = nil
          DC := GetWindowDC(oWnd);
          SavedDC := SaveDC(DC);
          try
            R := ACClientRect(oWnd);
            BitBlt(SkinData.FCacheBmp.Canvas.Handle, cx + R.Left, cy + R.Top, WidthOf(R), HeightOf(R), DC, R.Left, R.Top, SRCCOPY);
            FillAlphaRect(SkinData.FCacheBmp, Rect(cx + R.Left, cy + R.Top, cx + R.Left + WidthOf(R), cy + R.Top + HeightOf(R)), MaxByte);
          finally
            RestoreDC(DC, SavedDC);
            ReleaseDC(oWnd, DC);
          end;
        end;
      end
      else
        if SkinData.BGChanged then begin
          PaintAll;
          Redraw := True;
          if AForm = nil then begin
            ExBorderShowing := False;
            Exit;
          end;
        end;

      w := SkinData.FCacheBmp.Width;
      h := SkinData.FCacheBmp.Height;

      if iInsAfter = 0 then
        if isIconic(oWnd) or (FormState and FS_SIZING <> 0) then
          iInsAfter := GetNextWindow(oWnd, GW_HWNDPREV)
        else
          iInsAfter := oWnd;

      Flags := SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER;
      if FormState and FS_SIZING <> 0 then
        Flags := Flags or SWP_NOZORDER;

      if Redraw or (AForm.Width <> w) or (AForm.Height <> h) then
        bSizeChanged := True
      else begin
        Flags := Flags or SWP_NOSIZE;
        bSizeChanged := False;
      end;

      if not Redraw then
        Flags := Flags or SWP_NOREDRAW;

      p := Point(fR.Left - cx + DebugOffsX, fr.Top - cy + DebugOffsY);
      if acLayered and bSizeChanged and not acInMouseMsg then begin
        FBmpSize := MkSize(SkinData.FCacheBmp);
        FBmpTopLeft := MkPoint;
  {$IFDEF DELPHI6UP}
        if FOwner is TsSkinProvider and TsSkinProvider(FOwner).Form.AlphaBlend then
          InitBlendData(FBlend, TsSkinProvider(FOwner).Form.AlphaBlendValue)
        else
  {$ENDIF}
          InitBlendData(FBlend, Blend);

        if (AForm.Width <> w) or (AForm.Height <> h) then begin
          AForm.SetBounds(p.X, p.Y, w, h - yAeroTab);
          AForm.Width := w;
          AForm.Height := h;
        end;

        if (FOwner is TsSkinProvider) and (TsSkinProvider(FOwner).Form.WindowState = wsMaximized) then begin // Solving a problem with hidden taskbar
          if yAeroTab <> 0 then
            SkinData.FCacheBmp.Height := SkinData.FCacheBmp.Height - ShSize.Bottom - SysBorderWidth(TsSkinProvider(FOwner).Form.Handle, Self) - yAeroTab;

          FBmpSize.cy := SkinData.FCacheBmp.Height;
          AForm.Height := FBmpSize.cy;
        end;
        AForm.HandleNeeded;
        if AForm.HandleAllocated then begin
  {$IFDEF D2005}
  //        if (sp <> nil) and sp.Form.Enabled and (Application.ModalLevel = 0) then
  //          EnableWindow(AForm.Handle, True); Problem with dialogs covered by ExtBorders of form avoiding
  {$ENDIF}
          if SkinData.SkinManager.Effects.AllowAeroBluring and SkinData.SkinManager.SkinCommonInfo.UseAeroBluring and AeroIsEnabled and (not (FOwner is TsSkinProvider) or not TsSkinProvider(FOwner).UWPMode) then begin
            MakeBluringRgn;
            SetBlurBehindWindow(AForm.Handle, True, bRgn);
          end
          else
            SetBlurBehindWindow(AForm.Handle, False);

          if FormState and FS_BLENDMOVING <> 0 then
            SetWindowRgn(AForm.Handle, MakeRgn, False);

          DC := GetDC(0);
          try
            if not UpdateLayeredWindow(AForm.Handle, DC, @p, @FBmpSize, SkinData.FCacheBmp.Canvas.Handle, @FBmpTopLeft, clNone, @FBlend, ULW_ALPHA) then
              CheckLastError;
          finally
            ReleaseDC(0, DC);
          end;
          if FormState and FS_FULLPAINTING = 0 then
            SetWindowRgn(AForm.Handle, MakeRgn, True);//False); // Change rgn after blend-moving

          if GetWindowLong(AForm.Handle, GWL_STYLE) and WS_VISIBLE = 0 then begin
            if Blend = 0 then
              SetWindowLong(oWnd, GWL_STYLE, GetWindowLong(oWnd, GWL_STYLE) and not WS_VISIBLE); // Preventing of the main form painting

            if not SetWindowPos(AForm.Handle, iInsAfter, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOSIZE or SWP_NOMOVE) then // or SWP_NOOWNERZORDER);
              CheckLastError;

            if Blend = 0 then
              SetWindowLong(oWnd, GWL_STYLE, GetWindowLong(oWnd, GWL_STYLE) or WS_VISIBLE);

            if not MainRgnReady and (Blend = MaxByte) and (FormState and FS_SIZING = 0) then begin
              // Additional update of the form region (avoiding of the empty form issue)
              if sp <> nil then
                sSkinProvider.UpdateRgn(sp, True, True)
              else
                aCDials.UpdateRgn(TacDialogWnd(FOwner), True);

              MainRgnReady := True;
            end;
          end
          else begin
            if not SetWindowPos(AForm.Handle, iInsAfter, 0, 0, 0, 0, Flags or SWP_NOSIZE or SWP_NOMOVE) then
              CheckLastError;

            if not MainRgnReady and (Blend = MaxByte) and (FormState and FS_SIZING = 0) then begin
              // Additional update of the form region (avoiding of the empty form issue)
              if sp <> nil then
                sSkinProvider.UpdateRgn(sp, Redraw)
              else
                aCDials.UpdateRgn(TacDialogWnd(FOwner), Redraw);

              MainRgnReady := True;
            end;
          end;
  {$IFDEF DELPHI7UP}
          if sp <> nil then // Be sure that Form layered correctly
            if sp.Form.AlphaBlend then
              if GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED <> 0 then
                DoLayered(sp.Form.Handle, True, sp.Form.AlphaBlendValue);
  {$ENDIF}
        end;
      end
      else
        if not SetWindowPos(AForm.Handle, iInsAfter, p.X, p.Y, 0, 0, Flags or SWP_NOSIZE) then
          CheckLastError;

      ExBorderShowing := False;
    end;
end;


procedure TacBorderForm.KillAnimations;
begin
  if FOwner is TsSkinProvider then
    TsSkinProvider(FOwner).KillAnimations
  else
    if FOwner is TacDialogWnd then
      TacAccessDialogWnd(FOwner).KillAnimations;
end;


function TacBorderForm.OffsetX: integer;
begin
  Result := SkinBorderWidth(Self) - SysBorderWidth(OwnerHandle, Self, False) + ShadowSize.Left
end;


function TacBorderForm.OffsetY: integer;
var
  i1, i2: integer;
begin
  if (sp <> nil) and sp.FSysExHeight then
    Result := ShadowSize.Top + DiffTitle(Self) + 4 // SysBorderWidth(oWnd, Self, False) { For MinMax patching }
  else begin
    i2 := CaptionHeight(False);
    if i2 <> 0 then
      i1 := SkinTitleHeight(Self)
    else
      i1 := 0;

    Result := ShadowSize.Top - SysBorderWidth(OwnerHandle, Self, False) + i1 - i2;
  end;
end;


function TacBorderForm.OwnerHandle: hwnd;
begin
  if FOwner is TsSkinProvider then
    if TsSkinProvider(FOwner).Form.HandleAllocated then
      Result := TsSkinProvider(FOwner).Form.Handle
    else
      Result := 0
  else
    if FOwner is TacDialogWnd then
      Result := TacAccessDialogWnd(FOwner).CtrlHandle
    else
      Result := 0;
end;


function TacBorderForm.ShadowSize: TRect;
begin
  if sp <> nil then
    Result := sp.ShadowSize
  else
    Result := SkinData.CommonSkinData.FormShadowSize;
end;


procedure TacBorderForm.SetHotHT(const i: integer; Repaint: boolean);
begin
  if FOwner is TsSkinProvider then
    TsSkinProvider(FOwner).SetHotHT(i)
  else
    TacAccessDialogWnd(FOwner).SetHotHT(i);
end;


function TacBorderForm.CanBringForm: boolean;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).Form.Enabled and (GetWindowLong(TsSkinProvider(FOwner).Form.Handle, GWL_EXSTYLE) and WS_EX_NOACTIVATE = 0)
  else
    Result := IsWindowEnabled(OwnerHandle);
end;


function TacBorderForm.CaptionHeight(CheckSkin: boolean = True): integer;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).CaptionHeight(CheckSkin)
  else
    Result := TacAccessDialogWnd(FOwner).CaptionHeight(CheckSkin)
end;


function TacBorderForm.MenuHeight: integer;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).MenuHeight
  else
    Result := 0;
end;


function TacBorderForm.IconRect: TRect;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).IconRect
  else
    Result := TacAccessDialogWnd(FOwner).IconRect
end;


procedure TacBorderForm.PaintAll;
begin
  if FOwner is TsSkinProvider then
    TsSkinProvider(FOwner).PaintAll
  else
    TacAccessDialogWnd(FOwner).PaintAll
end;


function TacBorderForm.ButtonClose: TsCaptionButton;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).ButtonClose
  else
    Result := TacAccessDialogWnd(FOwner).ButtonClose
end;


function TacBorderForm.ButtonHelp: TsCaptionButton;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).ButtonHelp
  else
    Result := TacAccessDialogWnd(FOwner).ButtonHelp
end;


function TacBorderForm.ButtonMax: TsCaptionButton;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).ButtonMax
  else
    Result := TacAccessDialogWnd(FOwner).ButtonMax
end;


function TacBorderForm.ButtonMin: TsCaptionButton;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).ButtonMin
  else
    Result := TacAccessDialogWnd(FOwner).ButtonMin
end;


function TacBorderForm.MakeRgn(NewWidth: integer = 0; NewHeight: integer = 0): HRGN;
var
  R: TRect;
  SubRgn: hrgn;
  fState: Cardinal;
  i, cx, dx: integer;

  function ClientRgn: hrgn;
  var
    cR, rClient, rInt: TRect;
  begin
    if sp <> nil then begin
      cR.Left := sp.OffsetX;
      cR.Top := sp.OffsetY;
      if (fState and FS_SIZING <> 0) and not (fsShowing in sp.Form.FormState) then begin
        if sp.LastClientRect.Right < sp.Form.ClientWidth then
          cR.Right := cR.Left + sp.LastClientRect.Right
        else
          if (NewWidth <> 0) and (NewWidth > sp.Form.Constraints.MinWidth) then
            cR.Right := cR.Left + sp.Form.ClientWidth - (TsSkinProvider(FOwner).Form.Width - NewWidth)
          else
            cR.Right := cR.Left + sp.Form.ClientWidth;

        if sp.LastClientRect.Bottom < sp.Form.ClientHeight then
          cR.Bottom := cR.Top + sp.LastClientRect.Bottom
        else
          if (NewHeight <> 0) and (NewHeight > sp.Form.Constraints.MinHeight) then
            cR.Bottom := cR.Top + sp.Form.ClientHeight - (sp.Form.Height - NewHeight)
          else
            cR.Bottom := cR.Top + sp.Form.ClientHeight;
      end
      else begin
        GetClientRect(sp.Form.Handle, rClient);
        cR.Right := cR.Left + WidthOf(rClient);
        cR.Bottom := cR.Top + HeightOf(rClient);
        if sp.ListSW <> nil then begin
          if (sp.ListSW.sBarVert <> nil) and sp.ListSW.sBarVert.fScrollVisible then
            cR.Right := cR.Right + GetScrollMetric(sp.ListSW.sBarVert, SM_SCROLLWIDTH);

          if (sp.ListSW.sBarVert <> nil) and sp.ListSW.sBarHorz.fScrollVisible then
            cR.Bottom := cR.Bottom + GetScrollMetric(sp.ListSW.sBarHorz, SM_SCROLLWIDTH);
        end;
        if (sp.LinesCount > 0) and (fState and FS_ACTIVATE = 0) then
          dec(cR.Top, sp.LinesCount * sp.MenuHeight);
      end;
    end
    else begin
      cR.Left := TacAccessDialogWnd(FOwner).OffsetX;
      cR.Top := TacAccessDialogWnd(FOwner).OffsetY;
      if fState and FS_SIZING <> 0 then begin
        GetClientRect(TacAccessDialogWnd(FOwner).CtrlHandle, rClient);
        if TacAccessDialogWnd(FOwner).LastClientRect.Right < WidthOf(rClient) then
          cR.Right := cR.Left + TacAccessDialogWnd(FOwner).LastClientRect.Right
        else
          if NewWidth <> 0 then
            cR.Right := cR.Left + WidthOf(rClient) - (TacAccessDialogWnd(FOwner).WndSize.cx - NewWidth)
          else
            cR.Right := cR.Left + WidthOf(rClient);

        if TacAccessDialogWnd(FOwner).LastClientRect.Bottom < HeightOf(rClient) then
          cR.Bottom := cR.Top + TacAccessDialogWnd(FOwner).LastClientRect.Bottom
        else
          if NewHeight <> 0 then
            cR.Bottom := cR.Top + HeightOf(rClient) - (TacAccessDialogWnd(FOwner).WndSize.cy - NewHeight)
          else
            cR.Bottom := cR.Top + HeightOf(rClient);
      end
      else begin
        cR.Left := SkinBorderWidth(Self) + ShadowSize.Left;
        GetClientRect(OwnerHandle, rInt);
        cR.Right := cR.Left + WidthOf(rInt);
        cR.Bottom := SkinData.FCacheBmp.Height - SkinBorderWidth(Self) - ShadowSize.Bottom;
      end;
    end;
    Result := CreateRectRgn(cR.Left, cR.Top, cR.Right, cR.Bottom);
  end;

begin
  if AForm <> nil then begin
    if IsZoomed(OwnerHandle) then begin
      i := SysBorderWidth(OwnerHandle, Self, False);
      cx := i;
      dx := DiffBorder(Self);
      R := Rect(cx + dx + ShadowSize.Left, 4 + ShadowSize.Top, AForm.Width - cx - dx - ShadowSize.Right, AForm.Height - cx - dx - ShadowSize.Bottom);
      Result := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
    end
    else
      Result := 0;

    fState := FormState;
    if fState and FS_CHANGING <> 0 then begin
      if Result = 0 then
        Result := CreateRectRgn(0, 0, AForm.Width, AForm.Height);
    end
    else
      if fState and (FS_FULLPAINTING or FS_ANIMCLOSING) = 0 then begin
        if Result = 0 then
          Result := CreateRectRgn(0, 0, AForm.Width, AForm.Height);// - 400);

        SubRgn := ClientRgn;
        CombineRgn(Result, Result, SubRgn, RGN_XOR);
        DeleteObject(SubRgn);
      end
      else
        if AForm.Top < MinTopCoord then begin
          if Result = 0 then
            Result := CreateRectRgn(0, 0, AForm.Width, AForm.Height);

          SubRgn := CreateRectRgn(0, 0, AForm.Width, MinTopCoord - AForm.Top);
          CombineRgn(Result, Result, SubRgn, RGN_XOR);
          DeleteObject(SubRgn);
          MovRgnChanged := True;
        end
        else
          MovRgnChanged := False;
  end
  else
    Result := 0;
end;


function TacBorderForm.FormState: Cardinal;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).FormState
  else
    Result := TacAccessDialogWnd(FOwner).FormState
end;


function TacBorderForm.GetTopWnd: THandle;
begin
  if sp.Form.FormStyle = fsStayOnTop then // Patch for a Delphi problem concerning StayOnTop forms
    Result := HWND_TOP
  else
    if GetWindowLong(OwnerHandle, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0 then
      Result := HWND_TOPMOST
    else
      Result := OwnerHandle;
end;


procedure TacBorderForm.CreateNewForm;
var
  Flags: ACNativeInt;
begin
  if FormState and FS_ANIMSHOWING = 0 then begin
    MainRgnReady := False;
    AForm := TacGlowForm.CreateNew(nil);
//    AForm.Name := sp.Form.Name + 'Border' + IntToStr(GetTickCount);
    Flags := WS_EX_LAYERED;

    SetWindowLong(AForm.Handle, GWL_EXSTYLE, Flags);
    ParentHandle := ACNativeUInt(SetWindowLong(AForm.Handle, GWL_HWNDPARENT, LONG_PTR(OwnerHandle)));

    OldBorderProc := AForm.WindowProc;
    AForm.WindowProc := BorderProc;
  end;
end;


procedure TacBorderForm.UpdateRgn;
begin
  if ResetRgn then begin
    ResetRgn := False;
    SetWindowRgn(AForm.Handle, MakeRgn, False);
  end;
end;


procedure TacSBAnimation.ChangeState(NewState: integer; ToUp: boolean);
begin
  Up := ToUp;
  Enabled := True;
end;


procedure TacSBAnimation.CheckMouseLeave;
var
  P: TPoint;
  R: TRect;
begin
  if BorderForm <> nil then
    p := Point(acMousePos.X - BorderForm.AForm.Left, acMousePos.Y - BorderForm.AForm.Top)
  else begin
    GetWindowRect(FormHandle, R);
    p := Point(acMousePos.X - R.Left, acMousePos.Y - R.Top);
  end;
  if not PtInRect(PBtnData^.cpRect, P) then begin
    Enabled := False;
    SendMessage(FormHandle, WM_MOUSELEAVE, 0, 0);
  end;
end;


constructor TacSBAnimation.Create(AOwner: TComponent);
begin
  inherited;
  CurrentLevel := 0;
  CurrentState := 0;
  aBmp := nil;
  AForm := nil;
  Up := False;
  OnTimer := OnAnimTimer;
end;


destructor TacSBAnimation.Destroy;
begin
  Enabled := False;
  FreeAndNil(AForm);
  FreeAndNil(ABmp);
  PBtnData^.cpTimer := nil;
  inherited;
end;


function TacSBAnimation.GetFormBounds: TRect;
var
  mOffset: integer;
begin
  if BorderForm <> nil then
    GetWindowRect(BorderForm.AForm.Handle, Result)
  else
    GetWindowRect(FormHandle, Result);

  OffsetRect(Result, PBtnData^.cpRect.Left, PBtnData^.cpRect.Top);
  mOffset := Offset;
  if mOffset <> 0 then
    with SkinData.SkinManager, SkinData.CommonSkinData do
      if (PBtnData^.cpGlyphType in acGlowedGlyphs) and (Length(TitleGlows[PBtnData^.cpGlyphType]) > 0) and (TitleGlows[PBtnData^.cpGlyphType][0] >= 0) then begin
        Result.Left   := Result.Left - mOffset;
        Result.Top    := Result.Top  - mOffset;
        Result.Right  := Result.Left + WidthOf (ma[TitleGlows[PBtnData^.cpGlyphType][0]].R);
        Result.Bottom := Result.Top  + HeightOf(ma[TitleGlows[PBtnData^.cpGlyphType][0]].R);
      end
      else
        mOffset := 0;

  if mOffset = 0 then begin
    Result.Right  := Result.Left + WidthOf(PBtnData^.cpRect, True);
    Result.Bottom := Result.Top + HeightOf(PBtnData^.cpRect, True);
  end;
end;


procedure TacSBAnimation.MakeForm;
begin
  if AForm = nil then begin
    AForm := TacGlowForm.CreateNew(nil);
    SetWindowLong(AForm.Handle, GWL_EXSTYLE, GetWindowLong(AForm.Handle, GWL_EXSTYLE) or WS_EX_TRANSPARENT);
    if (BorderForm <> nil) and (TForm(BorderForm.AForm).FormStyle = fsStayOnTop) then
      SetWindowLong(AForm.Handle, GWL_EXSTYLE, GetWindowLong(AForm.Handle, GWL_EXSTYLE) or WS_EX_TOPMOST);
  end;
end;


procedure TacSBAnimation.MakeImg;
var
  R: TRect;
  b: boolean;
  CI: TCacheInfo;
  S0, S: PRGBAArray_;
  TitleButton: TsTitleButton;
  mi, x, y, j, DeltaS, ImgIndex: integer;
begin
  if (CurrentState <> 0) or (ABmp = nil) then // Updating required
    with SkinData.SkinManager, SkinData.CommonSkinData do begin
      R := GetFormBounds;
      b := Effects.AllowGlowing and (CurrentState = 1) and (PBtnData^.cpHitCode in [HTCLOSE, HTMAXBUTTON, HTMINBUTTON]);
      if (SkinData.FOwnerObject is TsSkinProvider) and (PBtnData^.cpHitCode = HTMINBUTTON) and IsIconic(TsSkinProvider(SkinData.FOwnerObject).Form.Handle) then
        ImgIndex := TitleGlyphs[tgNormal]
      else
        ImgIndex := TitleGlyphs[PBtnData^.cpGlyphType];

      if ImgIndex < 0 then
        mi := -1
      else
        if b and (PBtnData^.cpGlyphType in acGlowedGlyphs) and (Length(TitleGlows[PBtnData^.cpGlyphType]) <> 0) then
          mi := TitleGlows[PBtnData^.cpGlyphType][0]
        else
          mi := -1;

      b := mi >= 0;
      if ABmp = nil then
        ABmp := CreateBmp32(R);

      if b then begin
        with SkinData.SkinManager, SkinData.CommonSkinData do
          if IsValidImgIndex(mi) then
            BitBlt(ABmp.Canvas.Handle, 0, 0, ABmp.Width, ABmp.Height, ma[mi].Bmp.Canvas.Handle, 0, 0, SRCCOPY);
      end
      else begin
        CI.X := PBtnData^.cpRect.Left;
        CI.Y := PBtnData^.cpRect.Top;
        if (SkinData.FOwnerObject is TsSkinProvider) and (TsSkinProvider(SkinData.FOwnerObject).TempBmp <> nil) then begin
          CI.X := CI.X - (TsSkinProvider(SkinData.FOwnerObject).CaptionWidth - TsSkinProvider(SkinData.FOwnerObject).TempBmp.Width - 1);
          CI.Bmp := TsSkinProvider(SkinData.FOwnerObject).TempBmp;
        end
        else
          CI.Bmp := SkinData.FCacheBmp;

        CI.Ready := True;
        FillRect32(ABmp, MkRect(ABmp), 0, 0);
        if ImgIndex >= 0 then
          DrawSkinGlyph(ABmp, MkPoint, PBtnData^.cpState, 1, SkinData.CommonSkinData.ma[ImgIndex], MakeCacheInfo(ABmp));

        if BorderForm = nil then
          if (ImgIndex < 0) or (SkinData.CommonSkinData.ma[ImgIndex].MaskType = 0) then begin
            j := ABmp.Width - 1;
            if InitLine(ABmp, Pointer(S0), DeltaS) then
              for y := 0 to ABmp.Height - 1 do begin // If AlphaChannel must be updated
                S := Pointer(PAnsiChar(S0) + DeltaS * Y);
                for x := 0 to j do
                  with S[x] do
                    if C = clFuchsia then
                      A := MaxByte;
              end;
          end;

        if not AeroIsEnabled and IsWinVistaUp then
          UpdateAlpha(ABmp);
      end;
      if SkinData.FOwnerObject is TsSkinProvider then
        with TsSkinProvider(Self.SkinData.FOwnerObject) do
          if Between(PBtnData^.cpHitCode, HTUDBTN, HTUDBTN + TitleButtons.Count - 1) then begin // User defined button glyph
            j := PBtnData^.cpHitCode - HTUDBTN;
            TitleButton := TitleButtons.Items[j];
            if not TitleButton.Glyph.Empty then
              if TitleButton.Glyph.PixelFormat = pf32bit then begin
                x := (ABmp.Width  - TitleButton.Glyph.Width)  div 2;
                y := (ABmp.Height - TitleButton.Glyph.Height) div 2;
                if (PBtnData^.cpState = 2) then begin
                  inc(x);
                  inc(y);
                end;
                CopyByMask(Rect(x, y, x + TitleButton.Glyph.Width, y + TitleButton.Glyph.Height),
                           MkRect(TitleButton.Glyph), ABmp, TitleButton.Glyph, EmptyCI, True);
              end
              else
                CopyTransBitmaps(ABmp, TitleButton.Glyph,
                                 integer(PBtnData^.cpState = 2) + (WidthOf(PBtnData^.cpRect) - TitleButton.Glyph.Width) div 2,
                                 integer(PBtnData^.cpState = 2) + (HeightOf(PBtnData^.cpRect) - TitleButton.Glyph.Height) div 2,
                                 TsColor(TitleButton.Glyph.Canvas.Pixels[0, TitleButton.Glyph.Height - 1]));
          end;
    end;
end;


function TacSBAnimation.Offset: integer;
begin
  with SkinData.SkinManager, SkinData.CommonSkinData do
    if Effects.AllowGlowing and (CurrentState = 1) and (PBtnData^.cpHitCode in [HTCLOSE, HTMAXBUTTON, HTMINBUTTON]) then
      Result := GlowMargins[PBtnData^.cpGlyphType]
    else
      Result := 0;
end;


procedure TacSBAnimation.OnAnimTimer(Sender: TObject);
begin
  if Enabled then
    if Up then
      if CurrentLevel >= MaxIterations then begin
        CheckMouseLeave;
        if MaxIterations <> -1 then begin
          MaxIterations := -1;
          UpdateForm(MaxByte);
        end;
      end
      else begin
        UpdateForm(max(min(CurrentLevel * Step, MaxByte), 0));
        inc(CurrentLevel);
      end
    else
      if CurrentLevel <= 0 then begin
        CurrentState := -1;
        Enabled := False;
        if ABmp <> nil then
          FreeAndNil(ABmp);

        if AForm <> nil then
          FreeAndNil(AForm);
      end
      else begin
        UpdateForm(max(0, min(CurrentLevel * Step, MaxByte)));
        dec(CurrentLevel);
      end;
end;


procedure TacSBAnimation.StartAnimation(NewState: integer; ToUp : boolean);
begin
  if CurrentState <> NewState then begin
    CurrentState := NewState;
    if NewState <> 0 then begin
      if NewState = 2 then begin
        FreeAndNil(AForm);
        FreeAndNil(ABmp);
      end;
      CurrentLevel := 1;
      Up := ToUp;
      UpdateForm(min(Step, MaxByte));
      inc(CurrentLevel);
    end
    else begin
      Up := False;
      dec(CurrentLevel);
      UpdateForm(min(Step, MaxByte));
    end;
    if Maxiterations > 1 then
      Enabled := True;
  end;
end;


function TacSBAnimation.Step: integer;
begin
  Result := max(MaxByte div MaxIterations, 0);
end;


procedure TacSBAnimation.UpdateForm(const Blend: integer);
var
  DC: hdc;
  R: TRect;
  iInsAfter: hwnd;
  FBmpSize: TSize;
  FBmpTopLeft: TPoint;
  OwnerHandle: THandle;
  FBlend: TBlendFunction;
begin
  if ABmp = nil then
    MakeImg;

  if AForm = nil then
    MakeForm;

  if (ABmp <> nil) and (AForm <> nil) then begin
    FBmpSize := MkSize(ABmp);
    R := GetFormBounds;
    if FBmpSize.cx <> WidthOf(R) then // If image is hiding
      InflateRect(R, (FBmpSize.cx - WidthOf(R)) div 2, (FBmpSize.cy - HeightOf(R)) div 2);

    if BorderForm <> nil then
      OwnerHandle := BorderForm.AForm.Handle
    else
      OwnerHandle := FormHandle;

    if GetWindowLong(OwnerHandle, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0 then
      iInsAfter := HWND_TOPMOST
    else
      iInsAfter := GetNextWindow(OwnerHandle, GW_HWNDPREV);

    // Replacement of SetWindowPos (for Aero)
    AForm.Left := R.Left;
    AForm.Top := R.Top;
    AForm.Width  := FBmpSize.cx;
    AForm.Height := FBmpSize.cy;
    FBmpTopLeft := MkPoint;
    InitBlendData(FBlend, Blend);
    SetWindowPos(AForm.Handle, iInsAfter, 0, 0, 0, 0, SWPA_ZORDER);
    SetWindowLong(AForm.Handle, GWL_EXSTYLE, GetWindowLong(AForm.Handle, GWL_EXSTYLE) or WS_EX_LAYERED or WS_EX_NOACTIVATE or WS_EX_TRANSPARENT);
    DC := GetDC(0);
    try
      UpdateLayeredWindow(AForm.Handle, DC, nil, @FBmpSize, ABmp.Canvas.Handle, @FBmpTopLeft, clNone, @FBlend, ULW_ALPHA);
    finally
      ReleaseDC(0, DC);
    end;
    ShowWindow(AForm.Handle, SW_SHOWNOACTIVATE);
  end;
end;


constructor TacGraphItem.Create;
begin
  SkinData := TsCommonData.Create(Self, True);
  SkinData.COC := COC_TsAdapter;
  Handler := nil;
end;


destructor TacGraphItem.Destroy;
begin
  FreeAndNil(Handler);
  SkinData.ClearLinks;
  FreeAndNil(SkinData);
  inherited Destroy;
end;


procedure TacGraphItem.DoHook(Control: TControl);
begin
  if Control.Tag and ExceptTag = 0 then begin
    Self.Ctrl := Control;
    SkinData.FOwnerControl := Control;
    SkinData.FOwnerObject := TObject(Control);
    Handler := TacSpeedButtonHandler.Create(Ctrl, SkinData, SkinData.SkinManager, SkinData.SkinSection);
  end;
end;


constructor TacAddedTitle.Create;
begin
  FFont := TFont.Create;
  FFont.Color := clNone;
  FShowMainCaption := True;
end;


destructor TacAddedTitle.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;


function TacAddedTitle.FontIsStored: boolean;
begin
  Result := IsCustomFont(nil, FFont);
end;


procedure TacAddedTitle.Repaint;
begin
  if not (csLoading in FOwner.ComponentState) then
    UpdateSkinCaption(FOwner);
end;


procedure TacAddedTitle.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  Repaint;
end;


procedure TacAddedTitle.SetShowMainCaption(const Value: boolean);
begin
  if FShowMainCaption <> Value then begin
    FShowMainCaption := Value;
    Repaint;
  end;
end;


procedure TacAddedTitle.SetText(const Value: acString);
begin
  if FText <> Value then begin
    FText := Value;
    Repaint;
  end;
end;


procedure TacMoveTimer.TimeHandler;
var
  i: integer;
begin
  if Enabled then begin
    if BorderForm <> nil then
      SetFormBlendValue(BorderForm.AForm.Handle, BorderForm.SkinData.FCacheBmp, Round(CurrentBlendValue))
    else begin
      if GetWindowLong(FormHandle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
        SetWindowLong(FormHandle, GWL_EXSTYLE, GetWindowLong(FormHandle, GWL_EXSTYLE) or WS_EX_LAYERED);

      SetLayeredWindowAttributes(FormHandle, clNone, Round(CurrentBlendValue), ULW_ALPHA);
      SendAMessage(FormHandle, AC_UPDATEITEMSALPHA, Round(CurrentBlendValue));
    end;

    for i := 0 to Length(GluedArray) - 1 do
      if GluedArray[i].Master.Handle = FormHandle then
        SendAMessage(GluedArray[i].Slave.Handle, AC_SETALPHA, Round(CurrentBlendValue));

    if CurrentBlendValue > BlendValue then
      CurrentBlendValue := CurrentBlendValue - BlendStep;
  end;
end;


type
  TTBButtonX = packed record
    iBitmap,
    idCommand: Integer;
    fsState,
    fsStyle: Byte;
    bReserved: array [1..6] of Byte;
    dwData: Longint;
    iString: Integer;
  end;

  TacAppInfo = record
    Wnd: THandle;
  end;


{$IFNDEF DELPHI6UP}
function GetWindowThreadProcessId(hWnd: THandle; var dwProcessId: DWORD): DWORD; external user32 name 'GetWindowThreadProcessId';
{$ENDIF}


function GetAppRect: TRect;
const
  Buffer_Size = $1000;
var
  wndR: TRect;
  ai: TacAppInfo;
  si: TSystemInfo;
  ButtonX: TTBButton;
  i, bCount: integer;
  processID: Cardinal;
  ipRemoteBuffer: Pointer;
  hProcess, appHandle: THandle;
  hDesktop, hTray, hRebar, hTask, hToolBar: hwnd;
  ipBytesRead: {$IFDEF DELPHI_XE2}NativeUInt{$ELSE}Cardinal{$ENDIF};
begin
  FillChar(Result, SizeOf(TRect), 0);
  GetSystemInfo(si);
  hDesktop := GetDesktopWindow;
  if hDesktop <> 0 then begin
    hTray := FindWindowEx(hDesktop, 0, 'Shell_TrayWnd', nil);
    if hTray <> 0 then begin
      hRebar := FindWindowEx(hTray, 0, 'ReBarWindow32', nil);
      if hRebar <> 0 then begin
        hTask := FindWindowEx(hReBar, 0, 'MSTaskSwWClass', nil);
        if hTask <> 0 then begin
          hToolBar := FindWindowEx(hTask, 0, 'ToolbarWindow32', nil);
          if hToolBar <> 0 then begin
            bCount := SendMessage(hToolBar, TB_BUTTONCOUNT, 0, 0);
            if bCount > 0 then begin
              processId := 0;
              GetWindowThreadProcessId(hToolBar, processID);
              if processID <> 0 then begin
                hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, processId);
                if hProcess <> 0 then begin
                  ipRemoteBuffer := VirtualAllocEx(hProcess, nil, Buffer_Size, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
                  if ipRemoteBuffer <> nil then begin
                    i := -1;
                    while i < bCount do begin
                      inc(i);
                      if SendMessage(hToolbar, TB_GETBUTTON, i, LPARAM(ipRemoteBuffer)) = 0 then
                        Continue;

                      if not ReadProcessMemory(hProcess, ipRemoteBuffer, @ButtonX, SizeOf(TTBButtonX), ipBytesRead) then
                        Continue;

                      if (ButtonX.fsStyle and $D {not TBSTYLE_BUTTON ...} <> 0) or (ButtonX.fsState and TBSTATE_HIDDEN = TBSTATE_HIDDEN) then
                        Continue;

                      if not ReadProcessMemory(hProcess, Pointer(ButtonX.dwData), @ai, SizeOf(TacAppInfo), ipBytesRead) then
                        Continue;

                      if ipBytesRead = 0 then
                        Continue;
{$IFDEF D2009}
                      if Application.MainFormOnTaskBar and (Application.MainForm <> nil) then
                        appHandle := Application.MainForm.Handle
                      else
{$ENDIF}
                        appHandle := Application.{$IFDEF FPC}MainFormHandle{$ELSE}Handle{$ENDIF};

                      if ai.Wnd = appHandle then begin
                        if SendMessage(hToolBar, TB_GETITEMRECT, i, LPARAM(ipRemoteBuffer)) <> 0 then
                          ReadProcessMemory(hProcess, ipRemoteBuffer, @Result, SizeOf(TRect), ipBytesRead);

                        if ipBytesRead <> 0 then begin
                          GetWindowRect(hToolBar, wndR);
                          OffsetRect(Result, wndR.Left, wndR.Top);
                        end;
                        Break;
                      end;
                    end;
                    VirtualFreeEx(hProcess, ipRemoteBuffer, 0, MEM_RELEASE);
                    CloseHandle(hProcess);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;


function TacMinTimer.AlphaFrom: byte;
begin
  if FOwner is TsSkinProvider then
{$IFDEF DELPHI7UP}
    if TsSkinProvider(FOwner).Form.AlphaBlend then
      Result := TsSkinProvider(FOwner).Form.AlphaBlendValue
    else
{$ENDIF}
      Result := MaxByte
  else
    Result := MaxByte;

  if not IsWinVistaUp or AeroIsEnabled then
    if (sp = nil) and (DefaultManager.AnimEffects.Minimizing.Time > acTimerInterval) or (sp.SkinData.SkinManager.AnimEffects.Minimizing.Time > acTimerInterval) and not Minimized then
      Result := Result div 4; // Animation started not from full Alpha value
end;


constructor TacMinTimer.Create(AOwner: TComponent);
begin
  inherited;
  AnimForm := nil;
  AlphaBmp := nil;
  Minimized := False;
  AlphaFormWasCreated := False;
end;


constructor TacMinTimer.CreateOwned(AOwner: TComponent; ChangeEvent: boolean);
begin
  inherited CreateOwned(AOwner, True);
  InitData;
  SavedImage := CreateBmp32;
end;


destructor TacMinTimer.Destroy;
begin
  if AlphaFormWasCreated and Assigned(AnimForm) then
    FreeAndNil(AnimForm);

  FreeAndNil(SavedImage);
  FreeAndNil(AlphaBmp);
  inherited;
end;


function TacMinTimer.GetRectTo(rFrom: TRect): TRect;
var
  R: TRect;
  w, h, wd2, hd2, wDelta, hDelta, X, Y: integer;
begin
  if ShellTrayWnd <> 0 then begin
    if not AeroIsEnabled then
      Result := GetAppRect
    else
      Result.Left := Result.Right;

    if Result.Left = Result.Right then begin
      w := WidthOf(rFrom);
      h := HeightOf(rFrom);
      wd2 := w div 2;
      hd2 := h div 2;
      wDelta := w div 8;
      hDelta := h div 8;
      GetWindowRect(ShellTrayWnd, R);
      Result := R;
      if R.Top = 0 then
        if R.Left = 0 then
          TBPosition := iff(WidthOf(R) > HeightOf(R), BF_TOP, BF_LEFT)
        else
          TBPosition := BF_RIGHT
      else
        TBPosition := iff(Between(R.Left, -4, 0) {For windows without themes}, BF_BOTTOM, BF_RIGHT);

      X := R.Left + WidthOf(R) div 2;
      Y := R.Top + HeightOf(R) div 2;
      Result := Rect(X - wd2 + wDelta, Y - hd2 + hDelta, X + wd2 - wDelta, Y + hd2 - hDelta);
    end;
  end
  else
    Result := MkRect(0);
end;


procedure TacMinTimer.InitData;
const
  iMinStepCount = 1;
var
  aTime: integer;
begin
  Interval := acTimerInterval div 2;
  if FOwner is TsSkinProvider then begin
    sp := TsSkinProvider(FOwner);
    BorderForm := sp.BorderForm;
  end
  else
    sp := nil;

  aTime := sp.SkinData.SkinManager.AnimEffects.Minimizing.Time;
  StepCount := max(iMinStepCount, aTime div integer(Self.Interval));
  AlphaOrigin := AlphaFrom;
  if FormHandle = 0 then
    FormHandle := sp.Form.Handle;

  CurrentAlpha := AlphaFrom;

  if (CurrentAlpha <= 0) and Minimized then begin // Minimized
    CurLeft   := RectTo.Left;
    CurTop    := RectTo.Top;
    CurRight  := RectTo.Right;
    CurBottom := RectTo.Bottom;
  end
  else
    if CurrentAlpha >= AlphaFrom then begin // Normal
      if (BorderForm <> nil) and (BorderForm.AForm <> nil) then
        RectFrom := BorderForm.AForm.BoundsRect
      else
        GetWindowRect(FormHandle, RectFrom);

      UpdateDstRect;
      CurLeft   := XFrom;
      CurTop    := YFrom;
      CurRight  := CurLeft + WidthOf(RectTo);
      CurBottom := CurTop + HeightOf(RectTo);
    end;

  BlendStep := (AlphaFrom - AlphaTo) / Max(iMinStepCount, StepCount - 1);
  if AlphaBmp = nil then
    AlphaBmp := CreateBmp32(RectFrom)
  else begin
    AlphaBmp.Width  := WidthOf(RectFrom);
    AlphaBmp.Height := HeightOf(RectFrom);
  end;
  SetStretchBltMode(AlphaBmp.Canvas.Handle, 0);
  if BorderForm <> nil then
    AnimForm := BorderForm.AForm
  else begin
    FreeAndNil(AnimForm);
    AnimForm := MakeCoverForm(FormHandle, sp);
    AlphaFormWasCreated := True;
    SetWindowRgn(AnimForm.Handle, 0, False);
  end;
end;


procedure TacMinTimer.InitDataRestore;
var
  StepsCount: integer;
begin
  Interval := acTimerInterval div 2;

  CurLeft := RectFrom.Left + (RectTo.Left - RectFrom.Left) div 4;
  CurTop := RectFrom.Top + max((RectTo.Top - RectFrom.Top) div 4, 80);

  CurRight := CurLeft + WidthOf(RectFrom);
  CurBottom := CurTop + HeightOf(RectFrom);

  StepsCount := sp.SkinData.SkinManager.AnimEffects.Minimizing.Time div Interval + 1;
  CurrentAlpha := 1;
  DelPosX := Power(abs(CurLeft - RectFrom.Left), 1 / StepsCount);
  DelPosY := Power(abs(CurTop - RectFrom.Top), 1 / StepsCount);
  BlendDel := Power(MaxByte, 1 / StepsCount);

  BitBlt(AlphaBmp.Canvas.Handle, 0, 0, AlphaBmp.Width, AlphaBmp.Height, SavedImage.Canvas.Handle, 0, 0, SRCCOPY);
end;


procedure TacMinTimer.TimeHandler;
var
  p: TPoint;
  W, H: real;
  bAnim: boolean;
  ChildSP: TsSkinProvider;
begin
  if not InHandler then begin
    InHandler := True;
    // Check if direction must be changed
    if not Minimized then begin
      if sp.FormState and FS_ANIMRESTORING <> 0 then
        Minimized := True;
    end
    else
      if sp.FormState and FS_ANIMMINIMIZING <> 0 then
        Minimized := False;

    if AnimForm = nil then begin
      Enabled := False;
      InHandler := False;
      Exit;
    end
    else
      if not (csDestroying in AnimForm.ComponentState) then
        AnimForm.HandleNeeded
      else begin // If AnimForm is destroyed already for some reasons, break animation
        Enabled := False;
        sp.fAnimating := False;
        if sp.FormState and FS_ANIMRESTORING <> 0 then begin
          Minimized := False;
          sp.FormState := sp.FormState and not FS_ANIMRESTORING;
        end
        else
          if sp.FormState and FS_ANIMMINIMIZING <> 0 then begin
            Minimized := True;
            sp.FormState := sp.FormState and not FS_ANIMMINIMIZING;
          end;

        InHandler := False;
        Exit;
      end;

    if not AnimForm.HandleAllocated then begin
      Enabled := False;
      InHandler := False;
      Exit;
    end;

    if sp.BorderForm <> nil then
      sp.BorderForm.ExBorderShowing := True;

    // If in minimizing process
    if not Minimized then begin
      FillDC(AlphaBmp.Canvas.Handle, MkRect(AlphaBmp), 0);
      CurLeft   := DeltaX + DeltaW + CurLeft;
      CurRight  := DeltaX - DeltaW + CurRight;
      CurTop    := DeltaY + DeltaH + CurTop;
      CurBottom := DeltaY - DeltaH + CurBottom;
      CurrentAlpha := max(0, CurrentAlpha - BlendStep);
      if CurrentAlpha <= 0 then begin // Finish of animation
        Enabled := False;
        Minimized := True;
        if sp <> nil then begin
          sp.fAnimating := False;
          sp.SetHotHT(0);
          sp.FormState := sp.FormState and not FS_ANIMMINIMIZING;
          SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
          if sp.BorderForm <> nil then begin
            FreeAndNil(sp.BorderForm.AForm);
            AnimForm := nil;
  {$IFDEF D2005}
            if {$IFDEF D2007}Application.MainformOnTaskBar and{$ENDIF} (Application.MainForm <> nil) then
              SetActiveWindow(Application.MainForm.Handle);
  {$ENDIF}
            sp.BorderForm.ExBorderShowing := False;
            sp.BorderForm.UpdateExBordersPos;
          end
          else begin
            FillDC(AlphaBmp.Canvas.Handle, MkRect(AlphaBmp), 0);
            SetFormBlendValue(AnimForm.Handle, AlphaBmp, Round(CurrentAlpha), @p);
            ShowWindow(AnimForm.Handle, SW_HIDE);
            sp.ProcessMessage(WM_NCPAINT);
          end;
        end;
      end
      else begin
        W := max(0, CurRight - CurLeft);
        H := max(0, CurBottom - CurTop);
        StretchBlt(AlphaBmp.Canvas.Handle, 0, 0,
                   Round(W), Round(H), SavedImage.Canvas.Handle, 0, 0, SavedImage.Width, SavedImage.Height, SRCCOPY);

        p := Point(Round(CurLeft), Round(CurTop));
        SetFormBlendValue(AnimForm.Handle, AlphaBmp, Round(CurrentAlpha), @p);
        SetWindowPos(AnimForm.Handle, ShellTrayWnd, 0, 0, 0, 0, SWPA_SHOWZORDERONLY);
      end;
    end
    // If in restoring process
    else begin
      if sp.FormState and FS_RESTORING <> 0 then begin
        InHandler := False;
        Exit;
      end;
      if DelPosX <> 0 then
        CurLeft := RectFrom.Left - (RectFrom.Left - CurLeft) / DelPosX
      else
        CurLeft := RectFrom.Left;
        
      if DelPosY <> 0 then
        CurTop  := RectFrom.Top - (RectFrom.Top - CurTop) / DelPosY
      else
        CurTop  := RectFrom.Top;

      CurRight  := CurLeft + WidthOf(RectFrom);
      CurBottom := CurTop + HeightOf(RectFrom);

      CurrentAlpha := MaxByte - (MaxByte - CurrentAlpha) / BlendDel;

      if (CurrentAlpha >= AlphaFrom - 5) and ((abs(CurLeft - RectFrom.Left) < 1) and (abs(CurTop - RectFrom.Top) < 1)) then begin // Finish of animation
        Enabled := False;
        p := Point(Round(CurLeft), Round(CurTop));
        if IsWinVistaUp and not AeroIsEnabled and (sp.BorderForm <> nil) then begin
          sp.BorderForm.UpdateRgn;
  {$IFDEF DELPHI7UP}
          if (sp <> nil) and sp.Form.AlphaBlend then
            SetFormBlendValue(AnimForm.Handle, SavedImage, sp.Form.AlphaBlendValue, @p)
          else
  {$ENDIF}
            SetFormBlendValue(AnimForm.Handle, SavedImage, MaxByte, @p);
        end
        else
          SetFormBlendValue(AnimForm.Handle, SavedImage, AlphaFrom{Origin}, @p);

        if IsIconic(FormHandle) then begin
          bAnim := acGetAnimation;
          acSetAnimation(False);
          ShowWindow(FormHandle, iff(IsZoomed(FormHandle), SW_SHOWMAXIMIZED, SW_SHOWNOACTIVATE));
          acSetAnimation(bAnim);
        end;
        SetWindowPos(AnimForm.Handle, 0, 0, 0, 0, 0, SWPA_SHOWZORDERONLY);
        if sp.FormState and FS_DISABLED <> 0 then begin
          ShowWindow(AnimForm.Handle, SW_SHOWNA);
          Sleep(50);
        end;
{$IFDEF DELPHI7UP}
        if (sp <> nil) and sp.Form.AlphaBlend then
          SetLayeredWindowAttributes(sp.Form.Handle, clNone, sp.Form.AlphaBlendValue, ULW_ALPHA)
        else
{$ENDIF}
        begin
          SetFormBlendValue(AnimForm.Handle, SavedImage, MaxByte, @p);
          UpdateRgn(sp, False, False)
        end;

        if sp <> nil then begin
          sp.fAnimating := False;
          sp.FormState := sp.FormState and not FS_ANIMRESTORING;
          if sp.BorderForm <> nil then
            if not ExtBordersNeeded(sp) then begin
              sp.BorderForm := nil; // AnimForm will be destroyed later
              if sp.Form <> Application.MainForm then
                sp.SkinData.BGChanged := True;
            end
            else
              sp.BorderForm.ExBorderShowing := False;
        end;
        if (sp.Form.Menu <> nil) and (sp.BorderForm = nil) and AeroIsEnabled then
          sp.SkinData.BGChanged := True; // Menu repaint

        RedrawWindow(FormHandle, nil, 0, RDWA_ALLNOW);

{$IFDEF DELPHI7UP}
        if (sp <> nil) and sp.Form.AlphaBlend then
          SetLayeredWindowAttributes(sp.Form.Handle, clNone, sp.Form.AlphaBlendValue, ULW_ALPHA)
        else
{$ENDIF}
        begin
          if SetWindowLong(FormHandle, GWL_EXSTYLE, GetWindowLong(FormHandle, GWL_EXSTYLE) and not WS_EX_LAYERED) = 0 then
            CheckLastError;
        end;

        Minimized := False;

        if IsWindowEnabled(FormHandle) and IsWindowVisible(FormHandle) then
          if (sp.Form.FormStyle = fsMDIForm) and (sp.Form.ActiveMDIChild <> nil) then begin
            ChildSP := GetSkinProvider(sp.Form.ActiveMDIChild);
            if ChildSP <> nil then begin
              ChildSP.FormActive := True;
              UpdateSkinCaption(ChildSP);
            end;
          end
          else begin
            SetActiveWindow(FormHandle);
            if IsWindowVisible(FormHandle) and IsWindowEnabled(FormHandle) then
              SetFocus(FormHandle);
          end;

        SetWindowPos(AnimForm.Handle, FormHandle, 0, 0, 0, 0, SWPA_SHOWZORDERONLY);
        if (sp <> nil) and (sp.BorderForm <> nil) and (sp.BorderForm.AForm = AnimForm) then begin
          sp.BorderForm.UpdateExBordersPos(True);
          AnimForm := nil;
        end
        else
          FreeAndnil(AnimForm);

        if sp.FormState and FS_DISABLED = FS_DISABLED then
          sp.UpdateLayerForm;

        if Assigned(Application.OnRestore) then
          Application.OnRestore(Application);
      end
      else begin
        p := Point(Round(CurLeft), Round(CurTop));
        SetFormBlendValue(AnimForm.Handle, AlphaBmp, Round(CurrentAlpha), @p);
        SetWindowPos(AnimForm.Handle, ShellTrayWnd, 0, 0, 0, 0, SWPA_SHOWZORDERONLY);
      end;
    end;
    InHandler := False;
  end;
end;


procedure TacMinTimer.UpdateDstRect;
begin
  RectTo := GetRectTo(RectFrom);
  XTo := RectTo.Left;
  YTo := RectTo.Top;
  XFrom := (XTo + RectFrom.Left) div 2;
  YFrom := (YTo + RectFrom.Top) div 2;
  DeltaX := (XTo - XFrom) / StepCount;
  DeltaY := (YTo - YFrom) / StepCount;
  DeltaW := (WidthOf(RectFrom)  - WidthOf(RectTo))  / (2 * StepCount);
  DeltaH := (HeightOf(RectFrom) - HeightOf(RectTo)) / (2 * StepCount);
  AlphaTo := 0;
end;


constructor TacSysSubMenu.Create;
begin
  FPosition := ipBeforeClose;
end;


function TacBorderForm.MinTopCoord: integer;
begin
  Result := acWorkRect(TForm(AForm)).Top;
end;


procedure TsSkinProvider.SetGluedForms(const Value: TStringList);
begin
  FGluedForms.Assign(Value);
end;


function TsSkinProvider.CheckEdges(rStatic, rDynamic: TRect; NewX, NewY: integer): TSize;
begin
  Result := MkSize(HandleEdge(NewX, rStatic.Left, FSnapBuffer), HandleEdge(NewY, rStatic.Top,  FSnapBuffer));
  if Result.cx = 0 then
    Result.cx := HandleEdge(NewX + WidthOf(rDynamic), rStatic.Right, FSnapBuffer);

  if Result.cy = 0 then
    Result.cy := HandleEdge(NewY + HeightOf(rDynamic), rStatic.Bottom, FSnapBuffer);
end;


function TsSkinProvider.LimitRect(db: integer; R: TRect; Invert: boolean = False): TRect;
var
  hw, bw, Ml: integer;
begin
  Result := R;
  Ml := acMinusPlus[Invert];
  if UWPMode then
    with SkinData.CommonSkinData do begin
      if (Form.BorderStyle <> bsNone) and not SystemBlur.Active then begin
        bw := SysBorderWidth(Form.Handle, nil);
        hw := SysCaptHeight(Self);
      end
      else begin // SystemBlur is Active
        bw := 0;
        hw := 0;
      end;
      inc(Result.Left,   bw * Ml);
      inc(Result.Top,   (bw + hw) * Ml);
      dec(Result.Right,  bw * Ml);
      dec(Result.Bottom, bw * Ml);
    end
  else
    if BorderForm <> nil then
      with BorderForm.SkinData.CommonSkinData do begin
        inc(Result.Left,   (-db                    - ExShadowOffs)  * Ml);
        inc(Result.Top,    (-DiffTitle(BorderForm) - ExShadowOffsT) * Ml);
        inc(Result.Right,  ( db                    + ExShadowOffsR) * Ml);
        inc(Result.Bottom, (+db                    + ExShadowOffsB) * Ml);
      end
end;


procedure TsSkinProvider.CheckNewPosition(var X: integer; var Y: integer);
var
  cR, vR, fR: TRect;
  i: integer;
  PosOffset: TSize;

  function CheckWithForm(f: TForm): boolean;
  var
    Rects: array [TacSide] of TRect;
    j: TacSide;
    DiffB: integer;
  begin
    GetWindowRect(f.Handle, vR);
    DiffB := DiffBorder(BorderForm);
    vR := LimitRect(DiffB, vR, True);
    Rects[asLeft]   := LimitRect(DiffB, Rect(cR.Left,  vR.Top,    vR.Left,  vR.Bottom));
    Rects[asTop]    := LimitRect(DiffB, Rect(vR.Left,  cR.Top,    vR.Right, vR.Top));
    Rects[asRight]  := LimitRect(DiffB, Rect(vR.Right, vR.Top,    cR.Right, vR.Bottom));
    Rects[asBottom] := LimitRect(DiffB, Rect(vR.Left,  vR.Bottom, vR.Right, cR.Bottom));
    for j := asLeft to asBottom do
      if (PosOffset.cx = 0) or (PosOffset.cy = 0) then begin
        case j of
          asLeft, asRight: if (fR.Top > Rects[j].Bottom) or (fR.Bottom < Rects[j].Top) then Continue;
          asTop, asBottom: if (fR.Right < Rects[j].Left) or (fR.Left > Rects[j].Right) then Continue;
        end;
        with CheckEdges(Rects[j], fR, X, Y) do begin
          if PosOffset.cx = 0 then
            PosOffset.cx := cx;

          if PosOffset.cy = 0 then
            PosOffset.cy := cy;
        end
      end
      else
        Break;

    Result := (PosOffset.cx <> 0) and (PosOffset.cy <> 0);
  end;

begin
  if FormState and (FS_POSCHANGING or FS_ANIMMINIMIZING or FS_ANIMRESTORING or FS_RESTORING) = 0 then begin
    DelFromGluedArray(Form);
    cR := acWorkRect(Form);
    GetWindowRect(Form.Handle, fR);
    PosOffset := MkSize;
    // Check for glued forms
    for i := 0 to Length(HookedComponents) - 1 do
      if (HookedComponents[i] is TForm) and (HookedComponents[i] <> Form) and TForm(HookedComponents[i]).Visible and not Linked(TForm(HookedComponents[i])) and
          ((TForm(HookedComponents[i]).HostDockSite = nil) or TForm(HookedComponents[i]).Floating) then
        if CheckWithForm(TForm(HookedComponents[i])) then
          Break;

    if (PosOffset.cx = 0) or (PosOffset.cy = 0) then begin // If not changed by glued forms, look for screen
      // Receive new screen coords
      cR := LimitRect(DiffBorder(BorderForm), acWorkRect(Form));
      with CheckEdges(cR, fR, X, Y) do begin
        if PosOffset.cx = 0 then
          PosOffset.cx := cx;

        if PosOffset.cy = 0 then
          PosOffset.cy := cy;
      end;
    end;
    dec(x, PosOffset.cx);
    dec(y, PosOffset.cy);
  end;
end;


function TsSkinProvider.Linked(f: TForm): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to Length(GluedArray) - 1 do
    if (GluedArray[i].Master = Form) and (GluedArray[i].Slave = f) then begin
      Result := True;
      Exit;
    end;
end;


procedure TsSkinProvider.MoveGluedForms(BlendMoving: boolean = False);
var
  j, k: integer;

  procedure UpdateFormPos(Ndx: integer);
  var
    p: TPoint;
  begin
    with GluedArray[Ndx] do begin
      SendAMessage(Slave, AC_SETPOSCHANGING, 1);
      if BlendMoving and (BorderForm <> nil) then begin
        p := BorderForm.AForm.BoundsRect.TopLeft;
        if (SkinData.CommonSkinData.ExDrawMode = 0) or (BorderForm.SkinData.SkinManager.ExtBordersMode <> ebmFull) then begin
          inc(p.X, DiffBorder(BorderForm) + ShadowSize.Left);
          inc(p.Y, DiffTitle(BorderForm)  + ShadowSize.Top);
        end
        else begin
          inc(p.X, DiffBorder(BorderForm) + SkinData.CommonSkinData.ExContentOffs);
          inc(p.Y, DiffTitle(BorderForm)  + SkinData.CommonSkinData.ExContentOffs);
        end;
      end
      else
        p := Master.BoundsRect.TopLeft;

      Slave.SetBounds(p.X + Pos.X, p.Y + Pos.Y, Slave.Width, Slave.Height);
      SendAMessage(Slave, AC_SETPOSCHANGING, 0);
    end;
  end;

begin
  if FormState and FS_POSCHANGING = 0 then
    for j := 0 to GluedForms.Count - 1 do
      for k := 0 to Length(GluedArray) - 1 do
        if (GluedArray[k].Master = Form) and (GluedArray[k].Slave.Name = GluedForms[j]) then
          UpdateFormPos(k);
end;


procedure TsSkinProvider.UpdateSlaveFormsList;
var
  i, j, k, l, ndx: integer;
  R1, R2: TRect;
begin
  for i := 0 to GluedForms.Count - 1 do
    for k := 0 to Length(HookedComponents) - 1 do
      if (HookedComponents[k] is TForm) and (HookedComponents[k] <> Form) and
            TForm(HookedComponents[k]).Visible and (TForm(HookedComponents[k]).Name = GluedForms[i]) then begin

        GetWindowRect(TForm(HookedComponents[k]).Handle, R1);
        GetWindowRect(Form.Handle, R2);
        R1 := LimitRect(DiffBorder(BorderForm), R1, True);
        R2 := LimitRect(DiffBorder(BorderForm), R2, True);
        if (R1.Top = R2.Bottom) or (R1.Left = R2.Right) or (R2.Top = R1.Bottom) or (R2.Left = R1.Right) then begin // Add to list
          l := Length(GluedArray);
          ndx := -1;
          for j := 0 to l - 1 do
            if (GluedArray[j].Master = Form) and (GluedArray[j].Slave = TForm(HookedComponents[k])) then begin
              ndx := j;
              Break;
            end;

          if ndx < 0 then begin
            SetLength(GluedArray, l + 1);
            with GluedArray[l] do begin
              Master := Form;
              Slave := TForm(HookedComponents[k]);
              Pos := Point(TForm(HookedComponents[k]).Left - Form.Left, TForm(HookedComponents[k]).Top - Form.Top);
            end;
          end
          else
            GluedArray[ndx].Pos := Point(TForm(HookedComponents[k]).Left - Form.Left, TForm(HookedComponents[k]).Top - Form.Top);
        end;
      end;
end;


constructor TacFormHeader.Create(AOwner: TsSkinProvider);
begin
  FOwner := AOwner;
  FAdditionalHeight := 0;
end;


function TacFormHeader.ScaledAddHeight: integer;
begin
  Result := ScaleInt(FAdditionalHeight, FOwner.SkinData);
end;


procedure TacFormHeader.SetAdditionalHeight(const Value: integer);
begin
  if FAdditionalHeight <> Value then begin
    FAdditionalHeight := Value;
    if not (csLoading in FOwner.ComponentState) then
      FOwner.SkinData.Invalidate;
  end;
end;


procedure TsSkinProvider.InitIndexes;
begin
  if (FCommonData.SkinManager <> nil)  and (SkinData.SkinIndex >= 0) then    
    with FCommonData.SkinManager, SkinCommonInfo do begin
      FGenData          := @(FCommonData.CommonSkinData.gd[SkinData.SkinIndex]);
      FCaptionSkinIndex := Sections[ssCaption];
      FHeaderIndex      := Sections[ssFormHeader];
      if FTitleSkin <> '' then
        FTitleSkinIndex := GetSkinIndex(FTitleSkin)
      else
        FTitleSkinIndex := Sections[ssFormTitle];
    end
  else begin
    FCaptionSkinIndex := -1;
    FHeaderIndex      := -1;
    FTitleSkinIndex   := -1;
    FGenData          := nil;
  end;
end;


function TsSkinProvider.HeaderUsed: boolean;
begin
  Result := (FormHeader.AdditionalHeight > 0) and (FHeaderIndex >= 0) and (SkinData.CommonSkinData.gd[FHeaderIndex].States > 1);
end;


procedure TsSkinProvider.UpdateLayerForm;
{$IFDEF DELPHI6UP}
var
  FBlend: TBlendFunction;
  p, FBmpTopLeft: TPoint;
  AlphaBmp: TBitmap;
  FBmpSize: TSize;
  C: TsColor;
  R: TRect;
  DC: hdc;
  b: byte;
{$ENDIF}
begin
{$IFDEF DELPHI6UP}
  if not Form.Enabled and IsWindowVisible(Form.HAndle) then begin
    FormActive := False;
    SkinData.BGChanged := True;
    if BorderForm <> nil then
      BorderForm.UpdateExBordersPos(True)
    else
      ProcessMessage(WM_NCPAINT, 0, 0);

    SkinData.BGChanged := True;
    AlphaBmp := GetFormImage(Self, False);
    if LayerForm = nil then begin
      LayerForm := TacGlowForm.CreateNew(nil);
      LayerForm.Name := Form.Name + 'LayerForm';
      LayerForm.Color := 0;
      SetWindowLong(LayerForm.Handle, GWL_EXSTYLE, GetWindowLong(LayerForm.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
    end;
    if BorderForm <> nil then
      if UWPMode then begin
        R := UWPClientRect;
        LayerForm.Left   := BorderForm.AForm.Left;
        LayerForm.Top    := BorderForm.AForm.Top;
        LayerForm.Width  := WidthOf(R);
        LayerForm.Height := HeightOf(R);
      end
      else begin
        LayerForm.Left   := BorderForm.AForm.Left;
        LayerForm.Width  := BorderForm.AForm.Width;
        LayerForm.Top    := BorderForm.AForm.Top;
        LayerForm.Height := BorderForm.AForm.Height;
      end
    else
      if UWPMode then begin
        R := UWPClientRect;
        LayerForm.Left   := Form.Left;
        if IsZoomed(Form.Handle) then
          LayerForm.Top := Form.Top + Form.Top // Correct top if form is maximized
        else
          LayerForm.Top := Form.Top;

        LayerForm.Width  := WidthOf(R);
        LayerForm.Height := HeightOf(R);
      end
      else
        LayerForm.BoundsRect := Form.BoundsRect;

    C.C := FDisabledBlendColor;
    b := MaxByte - FDisabledBlendValue;
    C.R := C.R * b shr 8;
    C.G := C.G * b shr 8;
    C.B := C.B * b shr 8;

    BlendTransBitmap(AlphaBmp, FDisabledBlendValue, C);

    FBmpSize := MkSize(AlphaBmp);
    FBmpTopLeft := MkPoint;
    InitBlendData(FBlend, MaxByte);

    p := Point(LayerForm.Left, LayerForm.Top);
    if FDisabledBlured then begin
      if UWPMode then
        FillRect32Excl(AlphaBmp, MkRect(AlphaBmp), UWPClientRect, SkinData.SkinManager.Palette[pcMainColor], 0)
      else
        if BorderForm <> nil then begin
          R := Rect(BorderForm.ShadowSize.Left, BorderForm.ShadowSize.Top, AlphaBmp.Width - BorderForm.ShadowSize.Right, AlphaBmp.Height - BorderForm.ShadowSize.Bottom);
          FillRect32Excl(AlphaBmp, MkRect(AlphaBmp), R, SkinData.SkinManager.Palette[pcMainColor], 0);
        end;

      acgpBlur(AlphaBmp, 20);
    end;
    if UWPMode then
      FillRect32Excl(AlphaBmp, MkRect(AlphaBmp), UWPClientRect, 0, 0)
    else
      if BorderForm <> nil then begin
        R := Rect(BorderForm.ShadowSize.Left, BorderForm.ShadowSize.Top, AlphaBmp.Width - BorderForm.ShadowSize.Right, AlphaBmp.Height - BorderForm.ShadowSize.Bottom);
        FillRect32Excl(AlphaBmp, MkRect(AlphaBmp), R, 0, 0);
      end;

    DC := GetDC(0);
    try
      UpdateLayeredWindow(LayerForm.Handle, DC, @p, @FBmpSize, AlphaBmp.Canvas.Handle, @FBmpTopLeft, clNone, @FBlend, ULW_ALPHA);
    finally
      ReleaseDC(0, DC);
    end;
    AlphaBmp.Free;
    SetWindowPos(LayerForm.Handle, 0, LayerForm.Left, LayerForm.Top, 0, 0, SWP_NOACTIVATE or SWP_NOREDRAW or SWP_SHOWWINDOW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER {or SWP_NOMOVE }or SWP_NOSIZE);
    LayerForm.Show;
  end
  else
    if LayerForm <> nil then
      FreeAndNil(LayerForm);
{$ENDIF}
end;


procedure TsSkinProvider.SetFormState(const Value: Cardinal);

  procedure CheckValue(aValue: Cardinal);
  begin
    if Value and aValue <> 0 then begin
      if FFormState and aValue = 0 then
        Form.DisableAlign
    end
    else
      if FFormState and aValue <> 0 then
        Form.EnableAlign;
  end;

begin
  CheckValue(FS_ANIMMINIMIZING);
  CheckValue(FS_ANIMRESTORING);
  FFormState := Value;
end;


procedure TsSkinProvider.SetDisabledBlendColor(const Value: TColor);
begin
  if FDisabledBlendColor <> Value then begin
    FDisabledBlendColor := Value;
    if not (csDesigning in ComponentState) then
      UpdateLayerForm;
  end;
end;


procedure TsSkinProvider.SetDisabledBlendValue(const Value: byte);
begin
  if FDisabledBlendValue <> Value then begin
    FDisabledBlendValue := Value;
    if not (csDesigning in ComponentState) then
      UpdateLayerForm;
  end;
end;


procedure TacScaleThread.DoTimer;
begin
  OnTimer(Self);
end;


procedure TacScaleThread.Execute;
var
  term_cause: TWaitResult;
begin
  repeat
    term_cause := TimeEvent.WaitFor(acTimerInterval div 2);
    if term_cause = wrTimeout then
      Synchronize(DoTimer);
  until Terminated or (term_cause <> wrTimeout) or Application.Terminated;
end;


destructor TacScaleThread.Destroy;
begin
  if NewAlphaBmp <> nil then
    NewAlphaBmp.Free;

  inherited;
end;


constructor TacSystemBlur.Create(AOwner: TsSkinProvider);
begin
  FOwner := AOwner;
  FMode := bmBlurBehind;
  FActive := False;
end;


procedure TacSystemBlur.SetActive(const Value: boolean);
begin
  if FActive <> Value then begin
    FActive := Value;
    UpdateBlurMode;
  end;
end;


procedure TacSystemBlur.SetMode(const Value: TacBlurMode);
begin
  if FMode <> Value then begin
    FMode := Value;
    if [csLoading, csDesigning, csDestroying] * FOwner.ComponentState = [] then
      FOwner.Form.Perform(CM_RECREATEWND, 0, 0);

    UpdateBlurMode(True);
  end;
end;


procedure TacSystemBlur.UpdateBlurMode(Force: boolean = False);
var
  data: TacWinCompAttrData;
  accent: TacAccentPolicy;
  ObscForm: TacGlowForm;
{$IFDEF FLUENTCOMP}
  procedure UpdateGlassArea;
  var
    i: integer;
    LMargins: UxTheme.TMargins;
  begin
    if AeroIsEnabled then begin
      FillChar(LMargins, SizeOf(LMargins), 0);
      if Active and (FOwner.FluentHandles <> nil) and (FOwner.FluentHandles.Count > 0) then
        with LMargins do
          for i := 0 to FOwner.FluentHandles.Count - 1 do
            with TControl(FOwner.FluentHandles[i]) do begin
              case Align of
                alCLient: begin
                  FillChar(LMargins, SizeOf(LMargins), -1);
                  Break;
                end;
                alLeft:   cxRightWidth   := max(cxRightWidth, Left + Width);
                alTop:    cyTopHeight    := max(cyTopHeight, Top + Height);
                alRight:  cxLeftWidth    := max(cxLeftWidth, FOwner.Form.ClientWidth - Left);
                alBottom: cyBottomHeight := max(cyBottomHeight, FOwner.Form.Height - Top);
              end;
            end;

      acDwmExtendFrameIntoClientArea(FOwner.Form.Handle, LMargins);
      SetBlurBehindWindow(FOwner.Form.Handle, Active and FOwner.SkinData.Skinned);
    end;
  end;
{$ENDIF}
begin
  if (FOwner.FormState and FS_RECREATING = 0) then
    if [csDesigning, csLoading, csDestroying] * FOwner.ComponentState = [] then
      with FOwner do begin
        if IsFluentOS then begin
          ObscForm := nil;
          if Active and SkinData.Skinned then begin
            if (SkinData.TranspMode = TM_FULL) and not Force then
              Exit;

            if IsWindowVisible(Form.Handle) then
              ObscForm := MakeCoverForm(Form.Handle);

            if SkinData.TranspMode = TM_OPAQUE then begin // Not initialized yet
              if Form.BorderStyle <> bsNone then
                FluentBorderStyle := Form.BorderStyle;

              FluentUWPMode := UWPMode;
              UWPMode := True;
              FOwner.FormState := FOwner.FormState or FS_RECREATING;
              Form.BorderStyle := bsNone;
              FOwner.FormState := FOwner.FormState and not FS_RECREATING;
            end;
            if Mode = bmBlurBehind then
              accent.AccentState := 3 {ACCENT_ENABLE_BLURBEHIND}
            else
              accent.AccentState := 4 {SC_ACCENT_ENABLE_ACRYLICBLURBEHIND};

            accent.GradientColor := 1;
            SkinData.TranspMode := TM_FULL;
          end
          else begin
            if SkinData.TranspMode = TM_OPAQUE then
              Exit;

            if IsWindowVisible(Form.Handle) then
              ObscForm := MakeCoverForm(Form.Handle);

            if not FluentUWPMode then begin
              FOwner.FormState := FOwner.FormState or FS_RECREATING;
              Form.BorderStyle := FluentBorderStyle;
              FOwner.FormState := FOwner.FormState and not FS_RECREATING;
              FluentBorderStyle := bsNone;
            end;
            UWPMode := FluentUWPMode;
            FluentUWPMode := False;
            accent.AccentState := 0 {Disable};
            SkinData.TranspMode := TM_OPAQUE;
          end;
          IterateControls(Form, MakeWParam(AC_DO_BROADCAST, integer(Active)), ChangeTranspMode);
          accent.AccentFlags := 0; // $1E0; // DrawLeftBorder or DrawTopBorder or DrawRightBorder or DrawBottomBorder;
          data.attribute := AC_WCA_ACCENT_POLICY;
          data.dataSize := SizeOf(accent);
          data.pData := @accent;
          ac_SetWindowCompositionAttribute(Form.Handle, data);
          SkinData.BGChanged := True;
          RedrawWindow(Form.Handle, nil, 0, RDWA_ALLNOW);
          if ObscForm <> nil then
            ObscForm.Free;
        end
        else begin
{$IFDEF FLUENTCOMP}
          UpdateGlassArea;
{$ENDIF}
          if Active and SkinData.Skinned then begin
            if (SkinData.TranspMode = TM_FULL) and not Force then
              Exit;

            SkinData.TranspMode := TM_FULL;
          end
          else begin
            if SkinData.TranspMode = TM_OPAQUE then
              Exit;

            SkinData.TranspMode := TM_OPAQUE;
          end;
          IterateControls(Form, MakeWParam(AC_DO_BROADCAST, integer(Active)), ChangeTranspMode);
        end;
        FFormState := FFormState and not FS_GLASSNEEDED;
        SkinData.Invalidate;
      end;
end;


function IsFluentOS: boolean;
begin
  Result := IsWin10Up and Assigned(ac_SetWindowCompositionAttribute);
end;


initialization
  hUser32 := LoadLibrary(user32);
  if hUser32 <> 0 then begin
    ac_SetWindowCompositionAttribute := GetProcAddress(hUser32, 'SetWindowCompositionAttribute');
    FreeLibrary(hUser32);
  end;


finalization
  if hDWMAPI > 0 then
    FreeLibrary(hDWMAPI);

end.
