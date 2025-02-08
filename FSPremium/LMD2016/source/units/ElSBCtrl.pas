unit ElSBCtrl;
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

ElSBCtrl unit
-------------
System ScrollBar replacement component

ToDo
----
+ when scrollbar goes beyond window boundary it erases frame (system scrollbar does the same)
- when changing activation position of SB needs to be restored. See new TCustomFormCaption.SetActive
- add support of ELPACK_USE_IMAGEFORM
-? form support

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Windows, Messages, Graphics, Controls, Forms, ExtCtrls, StdCtrls,
  Types,  Classes, Themes,

  LMDThemes, LMDClass,
  LMDDebugUnit,  ElVCLUtils,
  {$IFDEF LMD_UNICODE}LMDUnicodeStrings,{$ENDIF}
  LMDSysIn, LMDProcs, LMDGraphUtils, LMDTypes, LMDHTMLUnit,

  ElXPThemedControl, ElImgFrm, ElComponent, ElHintWnd, ElHook, ElSBHook;

type
  TElScrollHintNeededEvent = procedure(Sender :TObject; TrackPosition :Integer;
    var Hint :TLMDString) of object;

  TElScrollBarPart = (sbpNowhere,
    sbpLeftArrow, sbpRightSndArrow {actually pointing to the left},
    sbpRightArrow, sbpLeftSndArrow {actually pointing to the right},
    sbpThumb, sbpLeftTop, sbpRightBottom);

  TElScrollHitTestEvent = procedure(Sender :TObject; X, Y :Integer; var Part :TElScrollBarPart;
    var DefaultTest :Boolean) of object;

  TElScrollDrawPartEvent = procedure(Sender :TObject; Canvas :TCanvas; R :TRect;
    Part :TElScrollBarPart; Enabled, Focused, Pressed :Boolean; var DefaultDraw :Boolean) of object;

  TElPaintCrossScrollBarsAreaEvent = procedure(Sender :TObject; Canvas :TCanvas; R :TRect;
    var DefaultDraw :Boolean) of object;

  TElScrollCode = (escLineUp, escLineDown, escPageUp, escPageDown, escPosition, escTrack, escTop,
    escBottom, escEndScroll, escSndLineUp, escSndLineDown);

  TElSBScrollEvent = procedure(Sender :TObject; ScrollCode :TElScrollCode; var ScrollPos :Integer;
                               var DoChange :Boolean) of object;

  TElSecButtonsKind = (sbkOpposite, sbkPage, sbkCustom);
  TElScrollThumbMode = (etmFixed, etmAuto);

  TElSBController = class;

  TElSBHandlerCustom = class(TPersistent)
  private
    { ScrollInfo system data }
    fMin                  :Integer;
    fMax                  :Integer;
    fPage                 :Integer;
    fPosition             :Integer;
    fTrackPos             :Integer;

    fKind                 :TScrollBarKind;
    fBarFlag              :Integer;
    fLeft, fTop,
    fWidth, fHeight       :Integer;
    fScrollBarRect        :TRect;
    fSBController         :TElSBController;
    fEnabled              :Boolean;
    fUseSystemMetrics     :Boolean;
    fThumbPos             :Integer;
    fThumbSize            :Integer;
    fMinThumbSize         :Integer;
    fThumbMode            :TElScrollThumbMode;
    fNoSunkenThumb        :Boolean;
    fButtonSize           :Integer;
    fFlat                 :Boolean;
    fActiveFlat           :Boolean;
    fMouseInControl       :Boolean;
    fThinFrame            :Boolean;
    fShowBorder           :Boolean;
    fDrawArrowFrames      :Boolean;
    fDrawBars             :Boolean;
    fBarOffset            :Cardinal;
    fColor                :TColor;
    //<abb 2014>
    fThumbColor           :TColor;
    //</abb 2014>
    fBarColor             :TColor;
    fArrowColor           :TColor;
    fArrowHotTrackColor   :TColor;
    fShowLeftArrows       :Boolean;
    fShowRightArrows      :Boolean;
    fChangeColorsOnScroll :Boolean;
    fBitmapOwner          :Boolean;
    fBlendBackground      :Boolean;
    fShowTrackHint        :Boolean;
    fNoDisableButtons     :Boolean;
    fOwnerDraw            :Boolean;
    fSecondaryButtons     :Boolean;
    fSecondBtnKind        :TElSecButtonsKind;
    fIsHTML               :Boolean;
    fOnChange             :TNotifyEvent;
    fOnScroll             :TElSBScrollEvent;
    fOnDrawPart           :TElScrollDrawPartEvent;
    fOnScrollHintNeeded   :TElScrollHintNeededEvent;
    fScrollTimer          :TTimer;
    fThumbOffset,
    fOrigPos,
    fOrigCoord            :Integer;
    fPressedIn,
    fOrigPressedIn,
    fMouseOver            :TElScrollBarPart;
    fHintWnd              :TElHintWindow;
    fPressedPos           :TPoint;
    fPressed              :Boolean;
    fTracking             :Boolean;
    fScrollTracking       :Boolean;
    fNoScrollMessages     :Boolean;
    fAltDisablingArrows   :Boolean;
    fOnHitTest            :TElScrollHitTestEvent;
    fVisible              :Boolean;
    FThemeGlobalMode: Boolean;
    FThemeMode : TLMDThemeMode;
    procedure SetKind(newValue: TScrollBarKind);
    procedure SetPosition(newValue: Integer);
    procedure SetMax(newValue: Integer);
    procedure SetMin(newValue: Integer);
    procedure SetPage(newValue: Integer);
    function GetVisible:Boolean;
    procedure SetVisible(Value:Boolean);
    procedure IntMouseButton(Pressed :Boolean; Btn :TMouseButton; XPos, YPos :SmallInt);
    procedure IntMouseMove(XPos, YPos :SmallInt);
    procedure IntMouseEnter(bRedraw:Boolean);
    procedure IntMouseLeave(bRedraw:Boolean);
    procedure Invalidate;
    procedure SetColor(Value:TColor);
    //<abb 2014>
    procedure SetThumbColor(Value:TColor);
    //</abb 2014>

    //not usage
    //function GetCanvas:TCanvas;

    function ClientRect:TRect;
    procedure SetEnabled(Value:Boolean);
    function GetFocused:Boolean;
    function GetHandleAllocated:Boolean;
    function GetHandle:THandle;
    function Perform(Msg: Cardinal; WParam, LParam: Longint): Longint;
    function GetControlOwner:TComponent;
    function GetComponentState:TComponentState;
    function GetControl:TWinControl;
    procedure DoSetPosition(newValue :Integer; Redraw :Boolean);
    procedure DoSetMax(newValue :Integer; Redraw :Boolean);
    procedure DoSetMin(newValue :Integer; Redraw :Boolean);
    procedure DoSetPage(newValue :Integer; Redraw :Boolean);
    function  ShadowColor: TColor;
    function  LighterColor: TColor;
    procedure SetFlat(newValue: Boolean);
    procedure SetActiveFlat(newValue: Boolean);
    procedure WMMouseWheel(var Msg: TMessage);
    procedure OnScrollTimer(Sender: TObject);
  private
    procedure SetButtonSize(newValue: Integer);
    procedure SetThumbMode(newValue: TElScrollThumbMode);
    procedure SetThumbSize(newValue: Integer);
    function  GetAutoThumbSize :Integer;
    function  GetThumbPos :Integer;
    function  GetTopBtns :Integer;
    function  GetBottomBtns :Integer;
    function  AdjustThumbPos :Integer; virtual;
    function  UpdateThumbPos :Integer; virtual;
    procedure SetMinThumbSize(newValue: Integer);
    procedure SetSecondaryButtons(newValue: Boolean);
    procedure SetOwnerDraw(newValue: Boolean);
    procedure SetSecondBtnKind(newValue: TElSecButtonsKind);

    procedure SetNoDisableButtons(newValue: Boolean);
    procedure UpdateScrollingRegion;
    procedure ShowHintAt(APosition, X, Y: Integer);
    function  GetButtonSize :Integer;
    procedure SetIsDesigning(newValue :Boolean);
    function  GetIsDesigning :Boolean;
    procedure SetBlendBackground(newValue: Boolean);
    procedure SetShowLeftArrows(newValue: Boolean);
    procedure SetShowRightArrows(newValue: Boolean);
    procedure SetNoSunkenThumb(newValue: Boolean);
    procedure SetUseSystemMetrics(value: Boolean);
    procedure UpdateSystemMetrics;
    procedure SetArrowColor(newValue: TColor);
    procedure SetArrowHotTrackColor(newValue: TColor);
    procedure SetShowBorder(newValue: Boolean);
    procedure SetDrawBars(const Value: Boolean);
    procedure SetDrawArrowFrames(const Value: Boolean);
    procedure SetThinFrame(newValue: Boolean);
    procedure SetBarColor(const Value: TColor);
    procedure SetBarOffset(const Value: Cardinal);
    function RightBtnsEnabled: Boolean;
    function LeftBtnsEnabled: Boolean;
    procedure RebuildBackground;
    procedure SetAltDisablingArrows(const Value: Boolean);
    function GetThumbSize: Integer;

    function GetUseXPThemes: Boolean;
    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure ReadUseXPThemes(Reader: TReader);
    procedure SetUseXPThemes(const Value: Boolean);
  protected

    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;
    function GetDepth:Integer;
    //not usage
    //function GetSize:Integer;
    procedure SetDepth(Value :Integer);
    function  NoUseSystemMetrics:Boolean;
    function GetImageForm: TElImageForm;
    procedure SetImageForm(Value: TElImageForm);
    procedure ReadThinFramesProperty(Reader: TReader);
    procedure ReadDrawFramesProperty(Reader: TReader);
    procedure CreateScrollTimer; virtual;
    procedure DestroyScrollTimer; virtual;
    procedure DefineProperties(Filer : TFiler); override;
  protected
    fCanvas         :TCanvas;
    fHintColor      :TColor;
    fHintTextColor  :TColor;
    {$IFDEF LMD_UNICODE}
    fHint           :TLMDString;
    {$ENDIF IFDEF LMD_UNICODE}
    fSysBkColor     :Boolean;
    fStep           :Integer;
    fUseSystemStep  :Boolean;
    procedure TriggerChangeEvent; virtual;
    procedure TriggerScrollEvent(ScrollCode: TElScrollCode; var ScrollPos: Integer;
      var DoChange: Boolean); virtual;
    procedure TriggerScrollHintNeededEvent(TrackPosition: Integer; var Hint: TLMDString); virtual;
    {procedure KeyDown(var Key: Word; Shift: TShiftState);}
    procedure SetSysBkColor(Value: Boolean);
    procedure TriggerHitTestEvent(X, Y :Integer; var Part :TElScrollBarPart;
              var DefaultTest :Boolean); virtual;
    {$IFDEF LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    {$ENDIF IFDEF LMD_UNICODE}
    {not usage}{property Canvas:TCanvas read GetCanvas;}
    property Focused:Boolean read GetFocused;
    property Control: TWinControl read GetControl;
    property Handle:THandle read GetHandle;
    property HandleAllocated:Boolean read GetHandleAllocated;
    property Owner:TComponent read GetControlOwner;
    property ComponentState:TComponentState read GetComponentState;
    {do not publishihed:}
    property Left:Integer read fLeft write fLeft;
    property Top:Integer read fTop write fTop;
    property Width:Integer read fWidth write fWidth;
    property Height:Integer read fHeight write fHeight;{}
    //todo: -> SystemColor
    //property ParentColor default True;
    property Kind: TScrollBarKind read fKind write SetKind; { Private }
    property IsDesigning: Boolean read GetIsDesigning write SetIsDesigning default False;
    property NoScrollMessages: Boolean read fNoScrollMessages write fNoScrollMessages default True;
    // Read Only Properties:
    property TrackPos :Integer read fTrackPos;
    property ThumbPos :Integer read fThumbPos;
    property MouseInControl :Boolean read fMouseInControl;
    property MouseOver :TElScrollBarPart read fMouseOver;
    property Tracking :Boolean read fTracking;
    property Pressed :Boolean read fPressed;
    property PressedIn :TElScrollBarPart read fPressedIn;
    property ScrollTimer: TTimer read fScrollTimer;
  public
    { Public declarations }
    constructor Create(AController:TElSBController);
    destructor Destroy; override;
    function IsThemed: Boolean;
    function GetHitTest(X, Y :Integer) :TElScrollBarPart;
    procedure Paint(Canvas:TCanvas);
    {not usage}{procedure EndScroll;}
    function SetScrollInfo(ScrollInfo: TScrollInfo; Redraw: BOOL): Integer;
    procedure SyncScrollInfoFromSystem(bRedraw:Boolean);
    procedure SyncScrollInfo(const SI:TScrollInfo; bRedraw:Boolean);
    procedure Assign(Source: TPersistent); override;
    property BarFlag:Integer read fBarFlag;
  {candidates to publishing}
  // property fields:
    // active properties:
    property Visible:Boolean read GetVisible write SetVisible default True;
    property Position: Integer read fPosition write SetPosition default 0;
    property Min: Integer read fMin write SetMin default 0;
    property Max: Integer read fMax write SetMax default -1;
    property ScrollTracking: Boolean read fScrollTracking write fScrollTracking default False;
    property Page: Integer read fPage write SetPage default 14;
    property Enabled:Boolean read fEnabled write SetEnabled default True;
    // style properties:
    property Depth:Integer read GetDepth write SetDepth stored NoUseSystemMetrics;
    {not usage}{property Size:Integer read GetSize;}
    property Step:Integer read fStep write fStep default 1;
    property UseSystemStep:Boolean read fUseSystemStep write fUseSystemStep default True;
    property Flat: Boolean read fFlat write SetFlat default True;
    property ActiveFlat: Boolean read fActiveFlat write SetActiveFlat default False;
    property ButtonSize: Integer read GetButtonSize write SetButtonSize default 17;
    property ThumbMode: TElScrollThumbMode read fThumbMode write SetThumbMode default etmAuto;
    property ThumbSize: Integer read GetThumbSize write SetThumbSize default 0;
    property MinThumbSize: Integer read fMinThumbSize write SetMinThumbSize default 12;
    property SecondaryButtons: Boolean read fSecondaryButtons write SetSecondaryButtons
      default False;
    property SecondBtnKind: TElSecButtonsKind read fSecondBtnKind write SetSecondBtnKind
      default sbkOpposite;
    property NoDisableButtons: Boolean read fNoDisableButtons write SetNoDisableButtons
      default False;
    property ShowTrackHint: Boolean read fShowTrackHint write fShowTrackHint default False;
    property Color:TColor read fColor write SetColor default clBtnFace;
    property ThumbColor:TColor read fThumbColor write SetThumbColor default clBtnFace;
    property ChangeColorsOnScroll: Boolean read fChangeColorsOnScroll write fChangeColorsOnScroll
      default True;
    property BlendBackground: Boolean read fBlendBackground write SetBlendBackground default True;
    property ShowLeftArrows: Boolean read fShowLeftArrows write SetShowLeftArrows default True;
    property ShowRightArrows: Boolean read fShowRightArrows write SetShowRightArrows default True;
    property NoSunkenThumb: Boolean read fNoSunkenThumb write SetNoSunkenThumb default False;
    property UseSystemMetrics: Boolean read fUseSystemMetrics write SetUseSystemMetrics
      default True;
    property ShowBorder: Boolean read fShowBorder write SetShowBorder default True;
    property DrawArrowFrames: Boolean read fDrawArrowFrames write SetDrawArrowFrames default True;
    property DrawBars: Boolean read fDrawBars write SetDrawBars default True;
    property BarOffset: Cardinal read fBarOffset write SetBarOffset default 2;
    property BarColor: TColor read fBarColor write SetBarColor default clBtnShadow;
    property IsHTML: Boolean read fIsHTML write fIsHTML default False;
    property ArrowColor: TColor read fArrowColor write SetArrowColor default clBtnText;
    property ArrowHotTrackColor: TColor read fArrowHotTrackColor write SetArrowHotTrackColor
      default clHighlight;
    property ThinFrame: Boolean read fThinFrame write SetThinFrame default False;
    property HintColor: TColor read fHintColor write fHintColor default clInfoBk;
    property HintTextColor: TColor read fHintTextColor write fHintTextColor default clInfoText;
    property SystemBkColor :Boolean read fSysBkColor write SetSysBkColor default True;
    property AltDisablingArrows: Boolean read fAltDisablingArrows write
        SetAltDisablingArrows default True;
    {$IFDEF LMD_UNICODE}
    property Hint: TLMDString read fHint write SetHint;
    {$ENDIF IFDEF LMD_UNICODE}
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property OwnerDraw: Boolean read fOwnerDraw write SetOwnerDraw default False;
  // property events:
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
    property OnHitTest: TElScrollHitTestEvent read fOnHitTest write fOnHitTest;
    property OnScroll: TElSBScrollEvent read fOnScroll write fOnScroll;
    property OnScrollHintNeeded: TElScrollHintNeededEvent read fOnScrollHintNeeded
      write fOnScrollHintNeeded;
    property OnDrawPart: TElScrollDrawPartEvent read fOnDrawPart write fOnDrawPart;
    property ScrollBarRect :TRect read fScrollBarRect;
  end; { TElSBHandlerCustom }

  TElSBHandlerCustomClass = class of TElSBHandlerCustom;

  TElCtrlScrollBarStyles = class(TElSBHandlerCustom)
  published
    property ActiveFlat;
    property AltDisablingArrows;
    property ArrowColor;
    property ArrowHotTrackColor;
    property BarOffset;
    property BarColor;
    property BlendBackground;
    property ButtonSize;
    property ChangeColorsOnScroll;
    property Color default clBtnFace;
    property ThumbColor default clBtnFace;
    //property Depth; mapped to TElScrollBarStyles.Width property:
    property Width: Integer read GetDepth write SetDepth stored NoUseSystemMetrics;
    property DrawArrowFrames;
    property DrawBars;
    property ShowBorder;
    property Flat;
    property HintColor;
    property HintTextColor;
    property IsHTML; {??? is this for hint ???}
    property MinThumbSize;
    property NoDisableButtons;
    property NoSunkenThumb;
    property OwnerDraw;
    property SecondaryButtons;
    property SecondBtnKind;
    property ShowLeftArrows;
    property ShowRightArrows;
    property ShowTrackHint;
    property Step;
    property SystemBkColor;
    property ThinFrame;
    property ThumbMode;
    property ThumbSize;
    property UseSystemMetrics;
    property UseSystemStep;
    property ThemeMode;
    property ThemeGlobalMode;
    property ImageForm: TElImageForm read GetImageForm write SetImageForm;
    // events:
    property OnChange;
  end;

  {IFDEF _SB_HOOKIMPEXP_}
  TSaveWMSetRedraw = (wmsrUnknown, wmsrFalse, wmsrTrue, wmsrFalseNeddRestore);
  {ENDIF IFDEF _SB_HOOKIMPEXP_}

  TScrollBarTracking = (sbtrNone, sbtrHorizontal, sbtrVertical, sbtrBoth);

  TElSBController = class(TElComponent)
  protected
    fElHook             :TElHook;
  private
    fSaveCapture        :HWND;
    FWinCtrl            :TScrollingWinControl;
    fHElSB              :TElSBHandlerCustom;
    fVElSB              :TElSBHandlerCustom;
    fPreventStyleChange :Boolean;
    // size of each window border:
    cxLeftEdge          :Integer;
    cxRightEdge         :Integer;
    cyTopEdge           :Integer;
    cyBottomEdge        :Integer;
    // theme:
    FThemeGlobalMode: Boolean;
    FThemeMode : TLMDThemeMode;

    fEmulateMouseWhell  :Boolean;
    fOnPaintCrossScrollBarsArea :TElPaintCrossScrollBarsAreaEvent;
    {IFDEF _SB_HOOKIMPEXP_}
    fSaveWMSetRedraw    :TSaveWMSetRedraw;
    fVSavePos           :Integer;
    fHSavePos           :Integer;
    {ENDIF IFDEF _SB_HOOKIMPEXP_}
    fUpdateCount        :Integer;
    FScrollControl      :TWinControl;
    FScrollBarsTracking: TScrollBarTracking;

    function GetUseXPThemes: Boolean;
    procedure SetUseXPThemes(Value:Boolean);
    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure ReadUseXPThemes(Reader: TReader);

    function GetControl:TWinControl;
    function GetControlHandleAllocated:Boolean;
    procedure SetControl(Value:TWinControl);
    procedure SetScrollBarStyles(BarFlag: Integer; Value: TElSBHandlerCustom);
    function GetScrollBarsTracking: TScrollBarTracking;
    procedure SetScrollBarsTracking(Value: TScrollBarTracking);
    function GetActive:Boolean;
  protected
    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;
    procedure DefineProperties(Filer:TFiler);override;

    function GetScrollBar(BarFlag :Integer):TElSBHandlerCustom;
    procedure PaintScrollBar(BarFlag:Integer);
    procedure SyncScrollInfos(BarFlag: Integer; bRedraw:Boolean);
    procedure HandleCtrlMsgBefore(Sender: TObject; var Msg: TMessage; var Handled: Boolean);
    procedure HandleCtrlMsgAfter(Sender: TObject; var Msg: TMessage; var Handled: Boolean);
    procedure NCPaintScrollBars(WinStyle, ExStyle:Integer);
    function NCPaint(var Msg:TMessage):Boolean;
    function NCActivate(var Msg:TMessage):Boolean;
    function NCCalcSize(var Msg:TMessage):Boolean;
    function MouseEventHandler(var Msg: TMessage):Boolean;
    function SBFilterMouseEventHandler(var Msg: TMessage):Boolean;
    function WMNCHitTest(var Msg :TWMNCHitTest):Boolean;
    procedure WMCancelMode(var Msg: TWMCancelMode);
    procedure SetCaptureMouse(bGrab:Boolean);
    procedure ElSBScrollEvent( Sender :TObject; ScrollCode :TElScrollCode; var ScrollPos :Integer;
      var DoChange :Boolean);
    procedure InitiateNCCalcSize;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function IsScrollingWinControl:Boolean;
    function GetElSBHandlerClass:TElSBHandlerCustomClass; virtual;
    procedure UpdateSystemMetrics(bRedraw:Boolean);
    procedure CreateScrollHook; virtual;
    procedure DestroyScrollHook; virtual;
    // Begin: ScrollBar API:
    procedure SyncScrollInfo(BarFlag: Integer; const SI:TScrollInfo; bRedraw:BOOL); stdcall;
    procedure ELSettingChange(var Message: TMessage); message EL_SETTINGCHANGE;
    // End:   ScrollBar API:
    property EmulateMouseWhell:Boolean read fEmulateMouseWhell write fEmulateMouseWhell
      default False;
    property ControlHandleAllocated:Boolean read GetControlHandleAllocated;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    function IsThemed: Boolean;
    function GetCrossScrollBarsRect:TRect;
    function DoShowScrollBar(wBar: Integer; bShow: BOOL): BOOL;
    procedure BeginUpdate;
    procedure EndUpdate;
    function InternalHitTest(X: integer; Y: integer): integer;
    property ScrollBar[BarFlag: Integer]: TElSBHandlerCustom read GetScrollBar;
    property Active:Boolean read GetActive;
    property ScrollBarsTracking: TScrollBarTracking read GetScrollBarsTracking
      write SetScrollBarsTracking default sbtrNone;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
  published
    property  Control:TWinControl read GetControl write SetControl; //???:  move to published
    property HorzScrollBarStyles: TElSBHandlerCustom index SB_HORZ read fHElSB
      write SetScrollBarStyles;
    property VertScrollBarStyles: TElSBHandlerCustom index SB_VERT read fVElSB
      write SetScrollBarStyles;
    property OnPaintCrossScrollBarsArea :TElPaintCrossScrollBarsAreaEvent
      read  fOnPaintCrossScrollBarsArea
      write fOnPaintCrossScrollBarsArea;
  end; { TElSBController }

  // for not TScrollingWinControl Control Container:
  TElCtrlScrollBarStylesTracking = class(TElCtrlScrollBarStyles)
  published
    property ScrollTracking;
  end;

  TElSBControllerTracking = class(TElSBController)
  protected
    function GetElSBHandlerClass:TElSBHandlerCustomClass; override;
  end;

(*
{$IFDEF MONITORING_MESSAGES}
var
  bMonitorMessage:Boolean;
{$ENDIF}
*)

function HeightRect(const R:TRect):Integer;
function WidthRect(const R:TRect):Integer;

implementation

(*
{$IFDEF MONITORING_MESSAGES}
uses MonitorMessage;

function MessageToStr(const WM_Number: Integer): String;
begin
  if DWORD(WM_Number) = WM_ELSCROLLBAR then
    Result := 'WM_ELSCROLLBAR'
  else
  case WM_Number of
    WM_NCMOUSELEAVE:
      Result := 'WM_NCMOUSELEAVE';
    WM_THEMECHANGED:
      Result := 'WM_THEMECHANGED';
    EL_THEMECHANGED:
      Result := 'EL_THEMECHANGED';
    //WM_APPBARNOTIFY:
    //  Result := 'WM_APPBARNOTIFY';
    IFM_EFFECTIVESIZE:
      Result := 'IFM_EFFECTIVESIZE';
    IFM_REPAINTCHILDREN:
      Result := 'IFM_REPAINTCHILDREN';
    IFM_CANPAINTBKGND:
      Result := 'IFM_CANPAINTBKGND';
    //WM_REMOVEELHOOK:
    //  Result := 'WM_REMOVEELHOOK';
    //WM_RECREATEELHOOK:
    //  Result := 'WM_RECREATEELHOOK';
    //WM_MENUBARMSG1:
    //  Result := 'WM_MENUBARMSG1';
    //PM_REFRESHACTIVEPAGE:
    //  Result := 'PM_REFRESHACTIVEPAGE';
    //EL_NOTIFYICON:
    //  Result := 'EL_NOTIFYICON';
    //TM_CLOSEINPLACEEDITOR:
    //  Result := 'TM_CLOSEINPLACEEDITOR';
    WM_ISTHEMEDCONTROL:
      Result := 'WM_ISTHEMEDCONTROL';
    WM_UPDATESBFRAME:
      Result := 'WM_UPDATESBFRAME';
    else
      Result := MonitorMessage.MessageToStr(WM_Number);
  end;
end;
{$ENDIF}
*)

function HeightRect(const R:TRect):Integer;
begin
  with R do
    Result := Bottom-Top+1;
end;

function WidthRect(const R:TRect):Integer;
begin
  with R do
    Result := Right-Left+1;
end;

(*
function LMDPointInRect(const P:TPoint; const R:TRect):Boolean;
begin
  with P,R do
  Result :=
     (X>=Left) and (X<=Right ) and
     (Y>=Top ) and (Y<=Bottom);
end;
*)

function MaxSB(a, b :Integer) :Integer;
begin
  if a < b then
    Result := b
  else
    Result := a;
end;

function MinSB(a, b :Integer) :Integer;
begin
  if a > b then
    Result := b
  else
    Result := a;
end;

{ TElSBHandlerCustom }

var
  fBlendBitmap: TBitmap;

procedure TElSBHandlerCustom.SetKind(newValue: TScrollBarKind);
begin
  if (fKind <> newValue) then
  begin
    fKind := newValue;
    if (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      if fUseSystemMetrics then
      begin
        fUseSystemMetrics := False;
        UseSystemMetrics := True;
      end
      else
      begin
        fThumbPos := AdjustThumbPos;
        Invalidate;
      end;
    end;
  end;
end;

procedure TElSBHandlerCustom.DefineProperties(Filer : TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('Enabled', FakeBoolean, nil, False);
  // old properties:
  Filer.DefineProperty('ThinFrames', ReadThinFramesProperty, nil, False);
  Filer.DefineProperty('DrawFrames', ReadDrawFramesProperty, nil, False);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

procedure TElSBHandlerCustom.ReadThinFramesProperty(Reader: TReader);
begin
  ThinFrame := Reader.ReadBoolean;
end;

procedure TElSBHandlerCustom.ReadDrawFramesProperty(Reader: TReader);
begin
  ShowBorder := Reader.ReadBoolean;
end;

procedure TElSBHandlerCustom.DoSetPosition(newValue: Integer; Redraw: Boolean);
  var
    op       :Integer;
    DoChange :Boolean;
begin
  if (fPosition <> newValue) then
  begin
    op := fPosition;
    if not (csLoading in ComponentState) then
    begin
      if newValue < fMin then
        fPosition := fMin
      else
        if newValue > fMax then
          fPosition := fMax
        else
          fPosition := newValue;
      fThumbPos := AdjustThumbPos;
    end
    else
      fPosition := newValue;
    if Redraw and (OP <> fPosition) then
    begin
      if fNoDisableButtons and (OP <> FMin) and (Position <> FMin) and (OP <> FMax) and (Position <> FMax) then
        UpdateScrollingRegion
      else
        Invalidate;
    end;
    TriggerScrollEvent(escPosition, newValue, DoChange);
  end;
end;

procedure TElSBHandlerCustom.DoSetMax(newValue: Integer; Redraw: Boolean);
begin
  if (fMax <> newValue) then
  begin
    fMax := newValue;
    if not (csLoading in ComponentState) then
    begin
      if fMin >= fMax then
        fMax := fMin;
      fPage := MinSB(fPage, fMax - fMin + 1);
      fThumbPos := AdjustThumbPos;
      if HandleAllocated then
        Invalidate;
    end;
    if fPosition > fMax then
      SetPosition(Max)
    else
      if Redraw then
        Invalidate;
  end;
end;

procedure TElSBHandlerCustom.DoSetMin(newValue: Integer; Redraw: Boolean);
begin
  if (fMin <> newValue) then
  begin
    fMin := newValue;
    if not (csLoading in ComponentState) then
    begin
      if fMin >= fMax then
        fMax := fMin;
      fPage := MinSB(fPage, fMax - fMin + 1);
      fThumbPos := AdjustThumbPos;
      if HandleAllocated then
        Invalidate;
    end;
    if fPosition < fMin then
      SetPosition(Min)
    else
      if Redraw then
        Invalidate;
  end;
end;

procedure TElSBHandlerCustom.DoSetPage(newValue: Integer; Redraw: Boolean);
begin
  if (fPage <> newValue) and (newValue >= 0) then
  begin
    fPage := newValue;
    if (not (csLoading in ComponentState)) and HandleAllocated then
      Invalidate;
  end;
end;

procedure TElSBHandlerCustom.SetPosition(newValue: Integer);
begin
  DoSetPosition(newValue, (not (csLoading in ComponentState)) and HandleAllocated);
end;

procedure TElSBHandlerCustom.SetMax(newValue: Integer);
begin
  DoSetMax(newValue, not (csLoading in ComponentState) and HandleAllocated);
end;

procedure TElSBHandlerCustom.SetMin(newValue: Integer);
{ Sets data member fMin to newValue. }
begin
  DoSetMin(newValue, not (csLoading in ComponentState) and HandleAllocated);
end;

procedure TElSBHandlerCustom.SetFlat(newValue: Boolean);
{ Sets data member fFlat to newValue. }
begin
  if (fFlat <> newValue) then
  begin
    fFlat := newValue;
    if not (csLoading in ComponentState) and HandleAllocated then
      Invalidate;
  end; { if }
end;

procedure TElSBHandlerCustom.SetActiveFlat(newValue: Boolean);
{ Sets data member fActiveFlat to newValue. }
begin
  if (fActiveFlat <> newValue) then
  begin
    fActiveFlat := newValue;
    if Assigned(Control) and (fMouseInControl or Control.Focused) then
      Invalidate;
  end;
end;

procedure TElSBHandlerCustom.IntMouseButton(Pressed :Boolean; Btn :TMouseButton;
  XPos, YPos :SmallInt);
  var
    FHit        :TElScrollBarPart;
    ScrollCode  :TElScrollCode;
    NewPos      :Integer;
    DoChange    :Boolean;
    AX, AY      :Integer;
    PrevPressed :Boolean;
begin
  if Btn <> mbLeft then
    exit;
  if Pressed then
  begin
    fPressedIn := GetHitTest(XPos, YPos);
    FHit := fPressedIn;
    PrevPressed := fPressed;
    if not fPressed then
    begin
      fOrigPressedIn := fPressedIn;
      fPressed := True;
      ScrollCode := escSndLineUp;
      case fPressedIn of
        sbpNowhere:
          exit;
        sbpThumb:
          begin
            fPressed := (Page < Max - Min + 1) and (Max - Min <> 0);
            if fPressed then
            begin
              if Kind = sbHorizontal then
                fOrigCoord := XPos
              else
                fOrigCoord := YPos;
              fOrigPos := Position;
              fThumbOffset := fOrigCoord - GetThumbPos;
              if fShowTrackHint then
              begin
                if Kind = sbHorizontal then
                begin
                  AY := -5;
                  AX := fThumbPos - 2;
                end
                else
                begin
                  AX := -2;
                  AY := fThumbPos - 2;
                end;
                if Assigned(Control.Parent) and (not (csDesigning in Control.Parent.ComponentState))
                then
                  ShowHintAt(Position, AX, AY);
              end;
            end;
          end;
        sbpLeftTop:
          begin
            ScrollCode := escPageUp;
            NewPos := MaxSB(fMin, fPosition - fPage);
            fPressed := LeftBtnsEnabled;
          end;
        sbpRightBottom:
          begin
            ScrollCode := escPageDown;
            NewPos := MinSB(fMax, fPosition + fPage);
            fPressed := RightBtnsEnabled;
          end;
        sbpLeftArrow:
          begin
            ScrollCode := escLineUp;
            NewPos := MaxSB(fMin, fPosition - fStep);
            fPressed := LeftBtnsEnabled;
          end;
        sbpRightArrow:
          begin
            ScrollCode := escLineDown;
            NewPos := MinSB(fMax, fPosition + fStep);
            fPressed := RightBtnsEnabled;
          end;
        sbpRightSndArrow:
          begin
            case fSecondBtnKind of
              sbkOpposite:
                begin
                  ScrollCode := escLineUp;
                  NewPos := MaxSB(fMin, fPosition - fStep);
                  fPressed := LeftBtnsEnabled;
                end;
              sbkPage:
                begin
                  ScrollCode := escPageDown;
                  NewPos := MinSB(fMax, fPosition + fPage);
                  fPressed := RightBtnsEnabled;
                end;
              sbkCustom:
                begin
                  ScrollCode := escSndLineUp;
                  NewPos := fPosition;
                end;
            end;
          end;
        sbpLeftSndArrow:
          begin
            case fSecondBtnKind of
              sbkOpposite:
                begin
                  ScrollCode := escLineDown;
                  NewPos := MinSB(fMax, fPosition + fStep);
                  fPressed := RightBtnsEnabled;
                end;
              sbkPage:
                begin
                  ScrollCode := escPageUp;
                  NewPos := MaxSB(fMin, fPosition - fPage);
                  fPressed := LeftBtnsEnabled;
                end;
              sbkCustom:
                begin
                  ScrollCode := escSndLineDown;
                  NewPos := fPosition;
                end;
            end;
          end;
      end;
      if fPressed or (NoDisableButtons and (fPressedIn <> sbpThumb)) then
      begin
        fPressed := True;
        fSBController.SetCaptureMouse(True);
        if fPressedIn <> sbpThumb then
        begin
          fPressedPos.x := XPos;
          fPressedPos.y := YPos;
          fScrollTimer.Interval := {ElVCLUtils.}GetKeybTimes(SPI_GETKEYBOARDDELAY);
          fScrollTimer.Enabled := True;
          TriggerScrollEvent(ScrollCode, NewPos, DoChange);
          if DoChange and (NewPos <> Position) then
          begin
            Position := NewPos;
            TriggerChangeEvent;
          end;
        end
        else
          UpdateScrollingRegion;
      end
      else
        fPressedIn := sbpNowhere;
    end;
    if (FHit <> fPressedIn) or (not PrevPressed) then
      Invalidate;
  end
  else// if not Pressed then
  begin
    if fPressed then
    begin
      fScrollTimer.Enabled := False;
      fSBController.SetCaptureMouse(False);
      fPressed := False;
      if fTrackPos <> -1 then
      begin
        fTracking := False;
        fTrackPos := -1;
      end;
      if fPressedIn = sbpThumb then
      begin
        if fHintWnd <> nil then
        begin
          fHintWnd.Free;
          fHintWnd := nil;
        end;
        NewPos := UpdateThumbPos;
        TriggerScrollEvent(escPosition, NewPos, DoChange);
        if DoChange and (NewPos <> Position) then
        begin
          Position := NewPos;
          TriggerChangeEvent;
        end;
        fThumbPos := AdjustThumbPos;
      end
      else
        if fPressedIn <> sbpNowhere then
        begin
          NewPos := Position;
          TriggerScrollEvent(escEndScroll, NewPos, DoChange);
          if DoChange and (NewPos <> Position) then
          begin
            Position := NewPos;
            TriggerChangeEvent;
          end;
          fThumbPos := AdjustThumbPos;
        end;
      fPressedIn := sbpNowhere;
      Invalidate;
    end
    else
      fSBController.SetCaptureMouse(False);
  end;
end;

procedure TElSBHandlerCustom.IntMouseMove(XPos, YPos :SmallInt);
  var
    OldMouseOver     :TElScrollBarPart;
    ATS, OP, NP, CS  :Integer;
    DoChange         :Boolean;
    AX, AY           :Integer;
begin
  if not fPressed then
  begin
    OldMouseOver := fMouseOver;
    fMouseOver := GetHitTest(XPos, YPos);
    if fMouseOver <> OldMouseOver then
      Invalidate;
  end
  else
  begin
    if fTrackPos = -1 then
    begin
      fTracking := True;
      fTrackPos := fThumbOffset;
    end;
    if fPressedIn = sbpThumb then
    begin
      if Kind = sbHorizontal then
      begin
        CS := Width;
        OP := FThumbPos;
        if ((XPos < 0) and (Abs(XPos) > CS shr 1)) or
          ((XPos > CS) and (XPos - CS > CS shr 1)) then
        begin
          fThumbPos := fOrigCoord - fThumbOffset;
          NP := UpdateThumbPos;
          UpdateScrollingRegion;
        end
        else
        begin
          if fThumbMode = etmFixed then
            ATS := ThumbSize
          else
            ATS := GetAutoThumbSize;
          fThumbPos := XPos - fThumbOffset;
          if fThumbPos < ButtonSize * (GetTopBtns) then
            fThumbPos := ButtonSize * (GetTopBtns)
          else
          if fThumbPos > (CS - ButtonSize * (GetBottomBtns) - ATS) then
            fThumbPos := CS - ButtonSize * (GetBottomBtns) - ATS;

          NP := UpdateThumbPos;
          if (not NoScrollMessages)and Assigned(Control.Parent) then
            SendMessage(Control.Parent.Handle,
              WM_HSCROLL, NP shl 16 + SB_THUMBPOSITION, Control.Handle);
          TriggerScrollEvent(escTrack, NP, DoChange);
          if OP <> FThumbPos then
            UpdateScrollingRegion;
        end;
      end
      else // if Kind = sbVertival then
      begin
        CS := Height;
        OP := FThumbPos;
        if ((YPos < 0) and (Abs(YPos) > CS shr 1)) or
           ((YPos > CS) and (YPos - CS > CS shr 1)) then
        begin
          fThumbPos := fOrigCoord - fThumbOffset;
          NP := UpdateThumbPos;
          UpdateScrollingRegion;
        end
        else
        begin
          if fThumbMode = etmFixed then
            ATS := ThumbSize
          else
            ATS := GetAutoThumbSize;
          fThumbPos := YPos - fThumbOffset;
          if fThumbPos < ButtonSize * (GetTopBtns) then
            fThumbPos := ButtonSize * (GetTopBtns)
          else
            if fThumbPos > (CS - ButtonSize * (GetBottomBtns) - ATS) then
              fThumbPos := CS - ButtonSize * (GetBottomBtns) - ATS;
          NP := UpdateThumbPos;
          if (not NoScrollMessages) and Assigned(Control.Parent) then
            SendMessage(Control.Parent.Handle,
              WM_VSCROLL, NP shl 16 + SB_THUMBPOSITION, Control.Handle);
          TriggerScrollEvent(escTrack, NP, Dochange);
          if OP <> fThumbPos then
            UpdateScrollingRegion;
        end;
      end;
      if fShowTrackHint and (OP <> FThumbPos) then
      begin
        if Kind = sbHorizontal then
        begin
          AY := -5;
          AX := fThumbPos - 2;
        end
        else
        begin
          AX := -2;
          AY := fThumbPos - 2;
        end;
        ShowHintAt(NP, AX, AY);
      end;
    end
    else
    begin
      OldMouseOver := fMouseOver;
      fMouseOver := GetHitTest(XPos, YPos);
      if fMouseOver <> fPressedIn then
        fScrollTimer.Enabled := False
      else
        if OldMouseOver <> fMouseOver then
        begin
          if (fPressedIn <> sbpThumb) then
            fScrollTimer.Enabled := True;
        end;
      if OldMouseOver <> fMouseOver then
        Invalidate;
    end;
  end;
end;

procedure TElSBHandlerCustom.IntMouseEnter(bRedraw:Boolean);
begin
  fMouseInControl := True;
  if bRedraw and (Flat and (not ActiveFlat)) or IsThemed then
    Invalidate;
end;

procedure TElSBHandlerCustom.IntMouseLeave(bRedraw:Boolean);
begin
  fMouseInControl := False;
  if bRedraw and (Flat and (not ActiveFlat)) or IsThemed() or
     (fMouseOver in [sbpLeftArrow, sbpRightSndArrow, sbpRightArrow, sbpLeftSndArrow])
  then
    Invalidate;
  fMouseOver := sbpNowhere;
end;

function TElSBHandlerCustom.ShadowColor: TColor;
  var
    hlscol, rgbcol :Cardinal;
    lum            :Integer;
begin
  if Color = clBtnFace then
    Result := clBtnShadow
  else
  begin
    rgbcol := ColorToRGB(Color);
    hlscol := RGBtoHLS(rgbcol);
    lum := Hi(hlscol and $0000FFFF);
    hlscol := Cardinal((MinSB(255, (Hi(hlscol and $0000FFFF) - lum div 4)) shl 8)) or
      (hlscol and $FF00FF);
    Result := HLStoRGB(hlscol);
  end;
end;

function TElSBHandlerCustom.LighterColor: TColor;
  var
    hlscol, rgbcol :TColor;
    lum            :Integer;
begin
  if Color = clBtnFace then
    Result := clBtnHighlight
  else
  begin
    rgbcol := ColorToRGB(Color);
    hlscol := RGBtoHLS(rgbcol);
    lum := Hi(hlscol and $0000FFFF);
    hlscol := Cardinal(
                ( MinSB( 255, (Hi(hlscol and $0000FFFF) + lum div 4) ) shl 8)
              ) or Cardinal( hlscol and $FF00FF );
    Result := HLStoRGB(hlscol);
  end;
end;

procedure TElSBHandlerCustom.Paint(Canvas:TCanvas); { public }
  var
    R1, R2       :TRect;
    ATS          :Integer;
    b, e         :Boolean;
    DefDraw      :Boolean;
    TransBk      :Boolean;
    aW, aH, aSh  :Integer;
    TmpCanvas    :TCanvas;
    ArrColors    :array[Boolean] of TColor;
    RClip        :TRect;
    bWinEnabled  :Boolean;
    LDetail: TThemedScrollBar;
    procedure FillBackground(Rect: TRect);
    var
      C: TColor;
    begin
    if not TransBk then
    begin
      if (BlendBackground and (not SystemBkColor))
      or (SystemBkColor and (GetSysColor(COLOR_SCROLLBAR) = GetSysColor(COLOR_BTNFACE)))
      then
      begin
        TmpCanvas.Brush.Bitmap := fBlendBitmap;
        TmpCanvas.FillRect(Rect);
        TmpCanvas.Brush.Bitmap := nil;
        TmpCanvas.Brush.Color := Color;
        TmpCanvas.Brush.Style := bsSolid;
      end
      else
      begin
        c := LMDThemeServices.GetThemeColor(UseThemeMode, teScrollBar, 0, 0, 1601 {TMT_SCROLLBAR});
        if IsThemed and (C <> clNone) then
        begin
          TmpCanvas.Brush.Color := C;
        end
        else
        begin
          if SystemBkColor then
            TmpCanvas.Brush.Color := clScrollbar
          else
            TmpCanvas.Brush.Color := Color;
        end;
        TmpCanvas.FillRect(Rect);
        TmpCanvas.Brush.Color := Color;
        TmpCanvas.Brush.Style := bsSolid;
      end;
    end;
  end;

  procedure FillShadow(Rect: TRect);
  begin
    if (not IsThemed()) and not TransBk then
    begin
      TmpCanvas.Brush.Color := ShadowColor;
      TmpCanvas.FillRect(Rect);
      TmpCanvas.Brush.Color := Color;
    end;
  end;

  procedure FillArrowFrame(Rect: TRect);
    var
      OldColor: TColor;
      LDetail: TThemedScrollBar;
  begin
    if IsThemed() then
    begin
      RClip := TmpCanvas.ClipRect;
      if Kind = sbHorizontal then
      begin
        LDetail := tsThumbBtnHorzNormal;
      end
      else
      begin
        LDetail := tsThumbBtnVertNormal;
      end;
      LMDThemeServices.DrawElement(UseThemeMode, TmpCanvas.Handle, LDetail, Rect, LMDRectToPtr(RClip));
      end
    else
    begin
      if not TransBk then
      begin
        OldColor := TmpCanvas.Brush.Color;
        if fDrawArrowFrames then
        begin
          TmpCanvas.Brush.Color := Color;
          TmpCanvas.FillRect(Rect)
        end
        else
        begin
          FillBackground(Rect);
        end;
        TmpCanvas.Brush.Color := OldColor;
      end;
    end;
  end;

var
  bHandlingOtherSB: Boolean;
  LThemeMode : TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;

  bWinEnabled := IsWindowEnabled(Handle);

  if (kind = sbHorizontal) then
    bHandlingOtherSB := fSBController.fVElSB.Visible and fSBController.fVElSB.fPressed
  else
    bHandlingOtherSB := fSBController.fHElSB.Visible and fSBController.fHElSB.fPressed;

  TmpCanvas := Canvas;

  RClip := Canvas.ClipRect;
  ArrColors[False] := ArrowColor;
  ArrColors[True] := ArrowHotTrackColor;

  TmpCanvas.Brush.Color := Color;
  R2 := ClientRect;
  R1 := R2;
  TransBk := False;

  TmpCanvas.Brush.Style := bsSolid;
  R2 := ClientRect;
  R1 := R2;
  if (kind = sbHorizontal) then  // ******************
  begin                          // ** HORIZONTAL   **
    if fShowLeftArrows then      // ******************
    begin
      R1.Right := R1.Left + ButtonSize;
      R2.Left := R1.Right;
      if LThemeMode <> ttmNone then
      begin
        if (LeftBtnsEnabled or NoDisableButtons) and Enabled and bWinEnabled then
        begin
          if bHandlingOtherSB then
            LDetail := tsArrowBtnLeftNormal
          else
          if (fPressedIn = sbpLeftArrow) and (fMouseOver = fPressedIn) then
          begin
            LDetail := tsArrowBtnLeftPressed;
          end
          else
          begin
            if (not fPressed) and fMouseInControl and (fMouseOver = sbpLeftArrow) then
            begin
              LDetail := tsArrowBtnLeftHot;
            end
            else
            begin
              LDetail := tsArrowBtnLeftNormal;
            end;
          end;
        end
        else
        begin
          LDetail := tsArrowBtnLeftDisabled;
        end;
        LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
        end
      else
      begin
        FillArrowFrame(R1);
        // Focused:
        b := (not bHandlingOtherSB) and ( (not Flat) or
             ( (not fPressed) and fMouseInControl and (not fActiveFlat) and
               (fMouseOver = sbpLeftArrow) and (LeftBtnsEnabled or NoDisableButtons)
             ));
        DefDraw := True;
        if OwnerDraw and Assigned(fOnDrawPart) then
        begin
          fOnDrawPart(Self, TmpCanvas, R1, sbpLeftArrow, LeftBtnsEnabled, b,
            // pushed:
            (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpLeftArrow) and
              (fMouseOver = fPressedIn),
            DefDraw);
        end;
        if DefDraw then
        begin
          if fDrawArrowFrames then
            DrawButtonFrameEx3(TmpCanvas.Handle, R1, b,
              // pushed:
              (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpLeftArrow) and
                (fMouseOver = fPressedIn),
              Color, ThinFrame, AllBorderSides);
          LMDDrawArrow(TmpCanvas, eadLeft, R1,
            ArrColors[ (not bHandlingOtherSB) and (fMouseOver = sbpLeftArrow)],
            (Enabled and bWinEnabled) and (LeftBtnsEnabled or NoDisableButtons) );
        end;
      end;
    end;

    if fShowRightArrows then
    begin
      R1 := R2;
      R1.Left := R1.Right - ButtonSize;
      R2.Right := R1.Left;
      if LThemeMode <> ttmNone then
      begin
        if ( (RightBtnsEnabled or NoDisableButtons) and Enabled and bWinEnabled) then
        begin
          if bHandlingOtherSB then
            LDetail := tsArrowBtnRightNormal
          else
          if (fPressedIn = sbpRightArrow) and (fMouseOver = fPressedIn) then
          begin
            LDetail := tsArrowBtnRightPressed;
          end
          else
          begin
            if (not fPressed) and fMouseInControl and (fMouseOver = sbpRightArrow) then
            begin
              LDetail := tsArrowBtnRightHot;
            end
            else
            begin
              LDetail := tsArrowBtnRightNormal;
            end;
          end;
        end
        else
        begin
          LDetail := tsArrowBtnRightDisabled;
        end;
        LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
        end
      else
      begin
        FillArrowFrame(R1);
        // Focused:
        b := (not bHandlingOtherSB) and (
             (not Flat) or ((not fPressed) and fMouseInControl and (not fActiveFlat) and
             (fMouseOver = sbpRightArrow) and (RightBtnsEnabled or NoDisableButtons)
             ));
        DefDraw := True;
        if OwnerDraw and Assigned(fOnDrawPart) then
        begin
          fOnDrawPart(Self, TmpCanvas, R1, sbpRightArrow, RightBtnsEnabled, b,
            // pushed:
            (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpRightArrow) and
              (fMouseOver = fPressedIn),
            DefDraw);
        end;
        if DefDraw then
        begin
          if fDrawArrowFrames then
            DrawButtonFrameEx3(TmpCanvas.Handle, R1, b,
              // pushed:
              (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpRightArrow) and
                (fMouseOver = fPressedIn),
              Color, ThinFrame, AllBorderSides);
          LMDDrawArrow(TmpCanvas, eadRight, R1,
            ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpRightArrow)],
            (Enabled and bWinEnabled) and  (RightBtnsEnabled or NoDisableButtons) );
        end;
      end;
    end;

    if fSecondaryButtons then
    begin
      if fShowLeftArrows then
      begin
        R1 := R2;
        R1.Right := R1.Left + ButtonSize;
        R2.Left := R1.Right;
        if (fSecondBtnKind = sbkOpposite) and (LThemeMode <> ttmNone) then
        begin
          if (RightBtnsEnabled or NoDisableButtons) and Enabled and bWinEnabled then
          begin
            if bHandlingOtherSB then
              LDetail := tsArrowBtnRightNormal
            else
            if (fPressedIn = sbpLeftSndArrow) and (fMouseOver = fPressedIn) then
            begin
              LDetail := tsArrowBtnRightPressed;
            end
            else
            begin
              if (not fPressed) and fMouseInControl and (fMouseOver = sbpLeftSndArrow) then
              begin
                LDetail := tsArrowBtnRightHot;
              end
              else
              begin
                LDetail := tsArrowBtnRightNormal;
              end;
            end;
          end
          else
          begin
            LDetail := tsArrowBtnRightDisabled;
          end;
          LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
          end
        else
        begin
          FillArrowFrame(R1);
          e := (Enabled and bWinEnabled) and
               ( ( (fSecondBtnKind <> sbkOpposite) and LeftBtnsEnabled  ) or
                 ( (fSecondBtnKind = sbkOpposite)  and RightBtnsEnabled ) or
                 (fSecondBtnKind = sbkCustom) or NoDisableButtons
               );
          b := (not bHandlingOtherSB) and (
               (not Flat) or
               ( (not fPressed) and fMouseInControl and (not fActiveFlat) and
                 (fMouseOver = sbpLeftSndArrow) and e
               ));
          DefDraw := True;
          if OwnerDraw and Assigned(fOnDrawPart) then
          begin
            fOnDrawPart(Self, TmpCanvas, R1, sbpLeftSndArrow, e, b,
              // pushed:
              (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpLeftSndArrow) and
                (fMouseOver = fPressedIn),
              DefDraw);
          end;
          if DefDraw then
          begin
            if LThemeMode <> ttmNone then
            begin
              RClip := TmpCanvas.ClipRect;
              if (not e) or (not (Enabled and bWinEnabled)) then
              begin
                LDetail := tsThumbBtnHorzDisabled;
              end
              else
              begin
                if bHandlingOtherSB then
                  LDetail := tsThumbBtnHorzNormal
                else
                if (fPressedIn = sbpLeftSndArrow) and (fMouseOver = fPressedIn) then
                begin
                  LDetail := tsThumbBtnHorzPressed;
                end
                else
                begin
                  if (not fPressed) and fMouseInControl and (fMouseOver = sbpLeftSndArrow) then
                  begin
                    LDetail := tsThumbBtnHorzHot;
                  end
                  else
                  begin
                    LDetail := tsThumbBtnHorzNormal;
                  end;
                end;
              end;
              LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
              end
            else
            begin
              if fDrawArrowFrames then
                DrawButtonFrameEx3(TmpCanvas.Handle, R1, b,
                // pushed:
                  (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpLeftSndArrow) and
                    (fMouseOver = fPressedIn),
                  Color, ThinFrame, AllBorderSides);
            end;
            if fSecondBtnKind = sbkPage then
            begin
              OffsetRect(R1, 1, 0);
              LMDDrawArrow(TmpCanvas, eadLeft, R1,
                ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpLeftSndArrow)], e);
              OffsetRect(R1, -3, 0);
              LMDDrawArrow(TmpCanvas, eadLeft, R1,
                ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpLeftSndArrow)], e);
              OffsetRect(R1, 2, 0);
            end
            else
              LMDDrawArrow(TmpCanvas, eadRight, R1,
                ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpLeftSndArrow)], e);
          end;
        end;
      end;

      if fShowRightArrows then
      begin
        R1 := R2;
        R1.Left := R1.Right - ButtonSize;
        R2.Right := R1.Left;
        if (fSecondBtnKind = sbkOpposite) and (LThemeMode <> ttmNone) then
        begin
          if (LeftBtnsEnabled or NoDisableButtons) and Enabled and bWinEnabled then
          begin
            if bHandlingOtherSB then
              LDetail := tsArrowBtnLeftNormal
            else
            if (fPressedIn = sbpRightSndArrow) and (fMouseOver = fPressedIn) then
            begin
              LDetail := tsArrowBtnLeftPressed;
            end
            else
            begin
              if (not fPressed) and fMouseInControl and (fMouseOver = sbpRightSndArrow) then
              begin
                LDetail := tsArrowBtnLeftHot;
              end
              else
              begin
                LDetail := tsArrowBtnLeftNormal;
              end;
            end;
          end
          else
          begin
            LDetail := tsArrowBtnLeftDisabled;
          end;
          LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
          end
        else
        begin
          FillArrowFrame(R1);
          e := (Enabled and bWinEnabled) and
               ( ( (fSecondBtnKind <> sbkOpposite) and RightBtnsEnabled ) or
                 ( (fSecondBtnKind = sbkOpposite)  and LeftBtnsEnabled  ) or
                 (fSecondBtnKind = sbkCustom) or NoDisableButtons
               );
          // focused:
          b := (not bHandlingOtherSB) and (
               (not Flat) or
               ( (not fPressed) and fMouseInControl and (not fActiveFlat) and
                 (fMouseOver = sbpRightSndArrow) and e
               ));
          DefDraw := True;
          if OwnerDraw and Assigned(fOnDrawPart) then
          begin
            fOnDrawPart(Self, TmpCanvas, R1, sbpRightSndArrow, e, b,
              // pushed:
              (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpRightSndArrow) and
                (fMouseOver = fPressedIn),
              DefDraw);
          end;
          if DefDraw then
          begin
            if (LThemeMode <> ttmNone) then
            begin
              RClip := TmpCanvas.ClipRect;
              if (not e) or (not (Enabled and bWinEnabled)) then
              begin
                LDetail := tsThumbBtnHorzDisabled;
              end
              else
              begin
                if bHandlingOtherSB then
                  LDetail := tsThumbBtnHorzNormal
                else
                if (fPressedIn = sbpRightSndArrow) and (fMouseOver = fPressedIn) then
                begin
                  LDetail := tsThumbBtnHorzPressed;
                end
                else
                begin
                  if (not fPressed) and fMouseInControl and (fMouseOver = sbpRightSndArrow) then
                  begin
                    LDetail := tsThumbBtnHorzHot;
                  end
                  else
                  begin
                    LDetail := tsThumbBtnHorzNormal;
                  end;
                end;
              end;
              LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
              end
            else
            begin
              if fDrawArrowFrames then
                DrawButtonFrameEx3(TmpCanvas.Handle, R1, b,
                  // pushed:
                  (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpRightSndArrow) and
                    (fMouseOver = fPressedIn),
                  Color, ThinFrame, AllBorderSides);
            end;
            if fSecondBtnKind = sbkPage then
            begin
              OffsetRect(R1, 2, 0);
              LMDDrawArrow(TmpCanvas, eadRight, R1,
                ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpRightSndArrow)], e);
              OffsetRect(R1, -3, 0);
              LMDDrawArrow(TmpCanvas, eadRight, R1,
                ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpRightSndArrow)], e);
              OffsetRect(R1, 1, 0);
            end
            else
              LMDDrawArrow(TmpCanvas, eadLeft, R1,
                ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpRightSndArrow)], e);
          end;
        end;
      end;
    end;

    if fThumbMode = etmFixed then
      ATS := ThumbSize
    else
      ATS := GetAutoThumbSize;
    if (ATS > 0) and Enabled and ((LThemeMode <> ttmNone) or ((LThemeMode = ttmNone) and bWinEnabled)) then
    begin

      // first draw the left part of the scroll fields
      DefDraw := True;

      R2.Right := fThumbPos;
      if fOwnerDraw and Assigned(fOnDrawPart) then
      begin
        fOnDrawPart(Self, TmpCanvas, R2, sbpLeftTop, Enabled and bWinEnabled, Focused,
          (not bHandlingOtherSB) and (fPressedIn = sbpLeftTop) and (fMouseOver = fPressedIn),
          DefDraw);
      end;
      if DefDraw then
      begin
        if IsThemed() then
        begin
          if (not (Enabled and bWinEnabled)) then
          begin
            LDetail := tsUpperTrackHorzDisabled;
          end
          else
          begin
            if bHandlingOtherSB then
              LDetail := tsUpperTrackHorzNormal
            else
            if (fPressedIn = sbpLeftTop) and (fMouseOver = fPressedIn) then
            begin
              LDetail := tsUpperTrackHorzPressed;
            end
            else
            begin
              if (not fPressed) and fMouseInControl and (fMouseOver = sbpLeftTop) then
              begin
                LDetail := tsUpperTrackHorzHot;
              end
              else
              begin
                LDetail := tsUpperTrackHorzNormal;
              end;
            end;
          end;
          LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R2, LMDRectToPtr(RClip));
          end
        else
        begin
          if (not bHandlingOtherSB) and fMouseInControl{???} and (fPressedIn = sbpLeftTop) and
            (fMouseOver = fPressedIn) and ChangeColorsOnScroll
          then
            FillShadow(R2)
          else
            FillBackground(R2);
        end;
      end;

      R1 := ClientRect;
      R1.Left := fThumbPos;
      R1.Right := R1.Left + ATS;
      // focused:
      b := (not bHandlingOtherSB) and (
           (not Flat)
           or
           ( fMouseInControl and (not fActiveFlat)) and
             ( (fMouseOver = sbpThumb) and
             ( (Max >= Min + 1) and (fPage < (Max - Min)) )
           ));
      DefDraw := True;
      if fOwnerDraw and Assigned(fOnDrawPart) then
      begin
        fOnDrawPart(Self, TmpCanvas, R1, sbpThumb, Enabled and bWinEnabled, b,
          // pushed:
          (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpThumb),
          DefDraw);
      end;
      if DefDraw then
      begin
        if (LThemeMode <> ttmNone) then
        begin
          if not (Enabled and bWinEnabled) then
          begin
            LDetail := tsThumbBtnHorzDisabled;
          end
          else
          begin
            if bHandlingOtherSB then
              LDetail := tsThumbBtnHorzNormal
            else
            if (fPressedIn = sbpThumb) then
            begin
              LDetail := tsThumbBtnHorzPressed;
            end
            else
            begin
              if (not fPressed) and fMouseInControl and (fMouseOver = sbpThumb) then
              begin
                LDetail := tsThumbBtnHorzHot;
              end
              else
              begin
                LDetail := tsThumbBtnHorzNormal;
              end;
            end;
          end;
          LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
          if fDrawBars then
          begin
            R1 := LMDThemeServices.ContentRect(LThemeMode, TmpCanvas.Handle, ThemeServices.GetElementDetails(LDetail), R1);
            if not (Enabled and bWinEnabled) then
            begin
              LDetail := tsGripperHorzDisabled;
            end
            else
            begin
              if bHandlingOtherSB then
                LDetail := tsGripperHorzNormal
              else
              if (fPressedIn = sbpThumb) then
              begin
                LDetail := tsGripperHorzPressed;
              end
              else
              begin
                if (not fPressed) and fMouseInControl and (fMouseOver = sbpThumb) then
                begin
                  LDetail := tsGripperHorzHot;
                end
                else
                begin
                  LDetail := tsGripperHorzNormal;
                end;
              end;
            end;
            LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
          end;
        end
        else
        begin
          TmpCanvas.Brush.Color := ThumbColor;
          if not TransBk then
            TmpCanvas.FillRect(R1);
          if fShowBorder then
            DrawButtonFrameEx3(TmpCanvas.Handle, R1, b,
              // pushed:
              (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpThumb) and
                (not NoSunkenThumb),
              Color, ThinFrame, AllBorderSides);
          TmpCanvas.Brush.Color := Color;
          if fDrawBars and (ATS > 14) then
          begin
            aH := fBarOffset;
            if fShowBorder then Inc(aH);
            if (b) and (fPressedIn = sbpThumb) and (not NoSunkenThumb) then
              aSh := 1
            else
              aSh := 0;
            if (R1.Bottom - R1.Top) >= aH + aH + 3 then
            begin
              with R1 do
              begin
                aW := (Right + Left) shr 1;
              end;
              Inc(aW, aSh);
              with TmpCanvas do
              begin
                Pen.Color := fBarColor;
                MoveTo(aW - 1, R1.Top + aH + aSh);
                LineTo(aW - 1, R1.Bottom - aH + aSh);
                MoveTo(aW - 3, R1.Top + aH + aSh);
                LineTo(aW - 3, R1.Bottom - aH + aSh);
                MoveTo(aW + 1, R1.Top + aH + aSh);
                LineTo(aW + 1, R1.Bottom - aH + aSh);
                MoveTo(aW + 3, R1.Top + aH + aSh);
                LineTo(aW + 3, R1.Bottom - aH + aSh);
              end;
            end;
          end;
        end;//of: if IsThemed() then
      end;

      // then draw the right part of the scroll fields
      R2.Left := fThumbPos + ATS;
      R2.Right := Width - ButtonSize * GetBottomBtns;
      if fOwnerDraw and Assigned(fOnDrawPart) then
      begin
        fOnDrawPart(Self, TmpCanvas, R2, sbpRightBottom, Enabled and bWinEnabled, Focused,
          // pushed:
          (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpRightBottom) and
            (fMouseOver = fPressedIn),
          DefDraw);
      end;
      if DefDraw then
      begin
        if (LThemeMode <> ttmNone) then
        begin
          if not (Enabled and bWinEnabled) then
          begin
            LDetail := tsLowerTrackHorzDisabled;
          end
          else
          begin
            if bHandlingOtherSB then
              LDetail := tsLowerTrackHorzNormal
            else
            if (fPressedIn = sbpRightBottom) and (fMouseOver = fPressedIn) then
            begin
              LDetail := tsLowerTrackHorzPressed;
            end
            else
            begin
              if (not fPressed) and fMouseInControl and (fMouseOver = sbpRightBottom) then
              begin
                LDetail := tsLowerTrackHorzHot;
              end
              else
              begin
                LDetail := tsLowerTrackHorzNormal;
              end;
            end;
          end;
          LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R2, LMDRectToPtr(RClip));
          end
        else
        begin
          if (not bHandlingOtherSB) and fMouseInControl{???} and (fPressedIn = sbpRightBottom) and
            (fMouseOver = fPressedIn) and ChangeColorsOnScroll
          then
          begin
            FillShadow(R2);
          end
          else
          begin
            FillBackground(R2);
          end;
        end;
      end;
    end
    else
    begin
      DefDraw := True;
      if fOwnerDraw and Assigned(fOnDrawPart) then
      begin
        fOnDrawPart(Self, TmpCanvas, R2, sbpNowhere, Enabled and bWinEnabled, Focused, False,
          DefDraw);
      end;
      if DefDraw then
      begin
        if (LThemeMode <> ttmNone) then
        begin
          LDetail := tsLowerTrackHorzDisabled;
          LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R2, LMDRectToPtr(RClip));
          end
        else
        if not TransBk then
          FillBackground(R2);
      end;
    end;
  end                            // ******************
  else                           // **   VERTICAL   **
  begin                          // ******************
    if fShowLeftArrows then
    begin
      R1.Bottom := R1.Top + ButtonSize;
      R2.Top := R1.Bottom;
      if (LThemeMode <> ttmNone) then
      begin
        if (LeftBtnsEnabled or NoDisableButtons) and Enabled and bWinEnabled then
        begin
          if bHandlingOtherSB then
            LDetail := tsArrowBtnUpNormal
          else
          if (fPressedIn = sbpLeftArrow) and (fMouseOver = fPressedIn) then
          begin
            LDetail := tsArrowBtnUpPressed;
          end
          else
          begin
            if (not fPressed) and fMouseInControl and (fMouseOver = sbpLeftArrow) then
            begin
              LDetail := tsArrowBtnUpHot;
            end
            else
            begin
              LDetail := tsArrowBtnUpNormal;
            end;
          end;
        end
        else
        begin
          LDetail := tsArrowBtnUpDisabled;
        end;
        LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle,  LDetail, R1, LMDRectToPtr(RClip));
        end
      else
      begin
        FillArrowFrame(R1);
        // focused:
        b := (not bHandlingOtherSB) and (
             (not Flat) or
             ( (not fPressed) and fMouseInControl and (not fActiveFlat) and
               (fMouseOver = sbpLeftArrow) and (LeftBtnsEnabled or NoDisableButtons)
             ));
        DefDraw := True;
        if OwnerDraw and Assigned(fOnDrawPart) then
        begin
          fOnDrawPart(Self, TmpCanvas, R1, sbpLeftArrow, LeftBtnsEnabled, b,
            // pushed:
            (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpLeftArrow) and
              (fMouseOver = fPressedIn),
            DefDraw);
        end;
        if DefDraw then
        begin
          if fDrawArrowFrames then
            DrawButtonFrameEx3(TmpCanvas.Handle, R1, b,
              // pushed:
              (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpLeftArrow) and
                (fMouseOver = fPressedIn),
              Color, ThinFrame, AllBorderSides);
          LMDDrawArrow(TmpCanvas, eadUp, R1,
            ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpLeftArrow)],
            (Enabled and bWinEnabled) and (LeftBtnsEnabled or NoDisableButtons) );
        end;
      end;
    end;

    if Self.fShowRightArrows then
    begin
      R1 := R2;
      R1.Top := R1.Bottom - ButtonSize;
      R2.Bottom := R1.Top;
      if (LThemeMode <> ttmNone) then
      begin
        if (RightBtnsEnabled or NoDisableButtons) and Enabled and bWinEnabled then
        begin
          if bHandlingOtherSB then
            LDetail := tsArrowBtnDownNormal
          else
          if (fPressedIn = sbpRightArrow) and (fMouseOver = fPressedIn) then
          begin
            LDetail := tsArrowBtnDownPressed;
          end
          else
          begin
            if (not fPressed) and fMouseInControl and (fMouseOver = sbpRightArrow) then
            begin
              LDetail := tsArrowBtnDownHot;
            end
            else
            begin
              LDetail := tsArrowBtnDownNormal;
            end;
          end;
        end
        else
        begin
          LDetail := tsArrowBtnDownDisabled;
        end;
        LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle,  LDetail, R1, LMDRectToPtr(RClip));
        end
      else
      begin
        FillArrowFrame(R1);
        // focused:
        b := (not bHandlingOtherSB) and (
             (not Flat) or
             ((not fPressed) and fMouseInControl and (not fActiveFlat) and
             (fMouseOver = sbpRightArrow) and (RightBtnsEnabled or NoDisableButtons)
             ));
        DefDraw := True;
        if OwnerDraw and Assigned(fOnDrawPart) then
        begin
          fOnDrawPart(Self, TmpCanvas, R1, sbpRightArrow, RightBtnsEnabled, b,
            // pushed:
            (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpRightArrow) and
              (fMouseOver = fPressedIn),
            DefDraw);
        end;
        if DefDraw then
        begin
          if fDrawArrowFrames then
            DrawButtonFrameEx3(TmpCanvas.Handle, R1, b,
              // pushed:
              (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpRightArrow) and
                (fMouseOver = fPressedIn),
              Color, ThinFrame, AllBorderSides);
          LMDDrawArrow(TmpCanvas, eadDown, R1,
            ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpRightArrow)],
            (Enabled and bWinEnabled) and (RightBtnsEnabled or NoDisableButtons) );
        end;
      end;
    end;

    if fSecondaryButtons then
    begin
      if fShowLeftArrows then
      begin
        R1 := R2;
        R1.Bottom := R1.Top + ButtonSize;
        R2.Top := R1.Bottom;
        if (fSecondBtnKind = sbkOpposite) and (LThemeMode <> ttmNone) then
        begin
          if (RightBtnsEnabled or NoDisableButtons) and Enabled and bWinEnabled then
          begin
            if bHandlingOtherSB then
              LDetail := tsArrowBtnDownNormal
            else
            if (fPressedIn = sbpLeftSndArrow) and (fMouseOver = fPressedIn) then
            begin
              LDetail := tsArrowBtnDownPressed;
            end
            else
            begin
              if (not fPressed) and fMouseInControl and (fMouseOver = sbpLeftSndArrow) then
              begin
                LDetail := tsArrowBtnDownHot;
              end
              else
              begin
                LDetail := tsArrowBtnDownNormal;
              end;
            end;
          end
          else
          begin
            LDetail := tsArrowBtnDownDisabled;
          end;
          LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
          end
        else
        begin
          FillArrowFrame(R1);
          e := (Enabled and bWinEnabled) and
               ( ( (fSecondBtnKind <> sbkOpposite) and LeftBtnsEnabled  ) or
                 ( (fSecondBtnKind = sbkOpposite)  and RightBtnsEnabled ) or
                 (fSecondBtnKind = sbkCustom) or NoDisableButtons
               );
          // focused:
          b := (not bHandlingOtherSB) and (
               (not Flat) or
               ( (not fPressed) and fMouseInControl and (not fActiveFlat) and
                 (fMouseOver = sbpLeftSndArrow) and e
               ));
          DefDraw := True;
          if OwnerDraw and Assigned(fOnDrawPart) then
          begin
            fOnDrawPart(Self, TmpCanvas, R1, sbpLeftSndArrow, e, b,
              // pushed:
              (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpLeftSndArrow) and
                (fMouseOver = fPressedIn),
              DefDraw);
          end;
          if DefDraw then
          begin
            if (LThemeMode <> ttmNone) then
            begin
              RClip := TmpCanvas.ClipRect;
              if (not e) or (not (Enabled and bWinEnabled)) then
              begin
                LDetail := tsThumbBtnHorzDisabled;
              end
              else
              begin
                if bHandlingOtherSB then
                  LDetail := tsThumbBtnHorzNormal
                else
                if (fPressedIn = sbpLeftSndArrow) and (fMouseOver = fPressedIn) then
                begin
                  LDetail := tsThumbBtnHorzPressed;
                end
                else
                begin
                  if (not fPressed) and fMouseInControl and (fMouseOver = sbpLeftSndArrow) then
                  begin
                    LDetail := tsThumbBtnHorzHot;
                  end
                  else
                  begin
                    LDetail := tsThumbBtnHorzNormal;
                  end;
                end;
              end;
              LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
              end
            else
            begin
              if fDrawArrowFrames then
                DrawButtonFrameEx3(TmpCanvas.Handle, R1, b,
                  // pushed:
                  (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpLeftSndArrow) and
                    (fMouseOver = fPressedIn),
                  Color, ThinFrame, AllBorderSides);
            end;
            if fSecondBtnKind = sbkPage then
            begin
              OffsetRect(R1, 0, 1);
              LMDDrawArrow(TmpCanvas, eadUp, R1,
                ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpLeftSndArrow)], e);
              OffsetRect(R1, 0, -3);
              LMDDrawArrow(TmpCanvas, eadUp, R1,
                ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpLeftSndArrow)], e);
              OffsetRect(R1, 0, 2);
            end
            else
              LMDDrawArrow(TmpCanvas, eadDown, R1,
                ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpLeftSndArrow)], e);
          end;
        end;
      end;
      if fShowRightArrows then
      begin
        R1 := R2;
        R1.Top := R1.Bottom - ButtonSize;
        R2.Bottom := R1.Top;
        if (fSecondBtnKind = sbkOpposite) and (LThemeMode <> ttmNone) then
        begin
          if (LeftBtnsEnabled or NoDisableButtons) and Enabled and bWinEnabled then
          begin
            if bHandlingOtherSB then
              LDetail := tsArrowBtnUpNormal
            else
            if (fPressedIn = sbpRightSndArrow) and (fMouseOver = fPressedIn) then
            begin
              LDetail := tsArrowBtnUpPressed;
            end
            else
            begin
              if (not fPressed) and fMouseInControl and (fMouseOver = sbpRightSndArrow) then
              begin
                LDetail := tsArrowBtnUpHot;
              end
              else
              begin
                LDetail := tsArrowBtnUpNormal;
              end;
            end;
          end
          else
          begin
            LDetail := tsArrowBtnUpDisabled;
          end;
          LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
          end
        else
        begin
          FillArrowFrame(R1);
          e := (Enabled and bWinEnabled) and
               ( ( (fSecondBtnKind <> sbkOpposite) and RightBtnsEnabled ) or
                 ( (fSecondBtnKind = sbkOpposite)  and LeftBtnsEnabled  ) or
                 (fSecondBtnKind = sbkCustom) or NoDisableButtons
               );
          // focused:
          b := (not bHandlingOtherSB) and (
               (not Flat) or
               ( (not fPressed) and fMouseInControl and (not fActiveFlat) and
                 (fMouseOver = sbpRightSndArrow) and e
               ));
          DefDraw := True;
          if OwnerDraw and Assigned(fOnDrawPart) then
          begin
            fOnDrawPart(Self, TmpCanvas, R1, sbpRightSndArrow, e, b,
              // pushed:
              (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpRightSndArrow) and
                (fMouseOver = fPressedIn),
              DefDraw);
          end;
          if DefDraw then
          begin
            if (LThemeMode <> ttmNone) then
            begin
              RClip := TmpCanvas.ClipRect;
              if (not e) or (not (Enabled and bWinEnabled)) then
              begin
                LDetail := tsThumbBtnHorzDisabled;
              end
              else
              begin
                if bHandlingOtherSB then
                  LDetail := tsThumbBtnHorzNormal
                else
                if (fPressedIn = sbpRightSndArrow) and (fMouseOver = fPressedIn) then
                begin
                  LDetail := tsThumbBtnHorzPressed;
                end
                else
                begin
                  if (not fPressed) and fMouseInControl and (fMouseOver = sbpRightSndArrow) then
                  begin
                    LDetail := tsThumbBtnHorzHot;
                  end
                  else
                  begin
                    LDetail := tsThumbBtnHorzNormal;
                  end;
                end;
              end;
              LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
              end
            else
            begin
              if fDrawArrowFrames then
                DrawButtonFrameEx3(TmpCanvas.Handle, R1, b,
                  // pushed:
                  (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpRightSndArrow) and
                    (fMouseOver = fPressedIn),
                  Color, ThinFrame, AllBorderSides);
            end;
            if fSecondBtnKind = sbkPage then
            begin
              OffsetRect(R1, 0, 2);
              LMDDrawArrow(TmpCanvas, eadDown, R1,
                ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpRightSndArrow)], e);
              OffsetRect(R1, 0, -3);
              LMDDrawArrow(TmpCanvas, eadDown, R1,
                ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpRightSndArrow)], e);
              OffsetRect(R1, 0, 1);
            end
            else
              LMDDrawArrow(TmpCanvas, eadUp, R1,
                ArrColors[(not bHandlingOtherSB) and (fMouseOver = sbpRightSndArrow)], e);
          end;
        end;
      end;
    end;

    if fThumbMode = etmFixed then
      ATS := ThumbSize
    else
      ATS := GetAutoThumbSize;
    if (ATS > 0) and Enabled  and ((LThemeMode <> ttmNone) or ((LThemeMode = ttmNone) and bWinEnabled)) then
    begin

      // first draw the left part of the scroll fields
      DefDraw := True;

      R2.Bottom := fThumbPos;
      if fOwnerDraw and Assigned(fOnDrawPart) then
      begin
        fOnDrawPart(Self, TmpCanvas, R2, sbpLeftTop, Enabled and bWinEnabled, Focused,
          // pushed:
          (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpLeftTop) and
            (fMouseOver = fPressedIn),
          DefDraw);
      end;
      if DefDraw then
      begin
        if (LThemeMode <> ttmNone) then
        begin
          if (not ( Enabled and bWinEnabled)) then
          begin
            LDetail := tsUpperTrackVertDisabled;
          end
          else
          begin
            if bHandlingOtherSB then
              LDetail := tsUpperTrackVertNormal
            else
            if (fPressedIn = sbpLeftTop) and (fMouseOver = fPressedIn) then
            begin
              LDetail := tsUpperTrackVertPressed;
            end
            else
            begin
              if (not fPressed) and fMouseInControl and (fMouseOver = sbpLeftTop) then
              begin
                LDetail := tsUpperTrackVertHot;
              end
              else
              begin
                LDetail := tsUpperTrackVertNormal;
              end;
            end;
          end;
          LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R2, LMDRectToPtr(RClip));
          end
        else
        begin
          if (not bHandlingOtherSB) and fMouseInControl{???} and (fPressedIn = sbpLeftTop) and
            (fMouseOver = fPressedIn) and ChangeColorsOnScroll
          then
          begin
            FillShadow(R2);
          end
          else
          begin
            FillBackground(R2);
          end;
        end;
      end;

      R1 := ClientRect;
      R1.Top := fThumbPos;
      R1.Bottom := R1.Top + ATS;
      // focused:
      b := (not bHandlingOtherSB) and (
           (not Flat)
           or
           ( fMouseInControl and (not fActiveFlat)) and
             ( (fMouseOver = sbpThumb) and
             ( (Max >= Min + 1) and (fPage < (Max - Min)) )
           ));

      DefDraw := True;
      if fOwnerDraw and Assigned(fOnDrawPart) then
      begin
        fOnDrawPart(Self, TmpCanvas, R1, sbpThumb, Enabled and bWinEnabled, b,
          // pushed:
          (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpThumb),
          DefDraw);
      end;
      if DefDraw then
      begin
        if (LThemeMode <> ttmNone) then
        begin
          if (not (Enabled and bWinEnabled)) then
          begin
            LDetail := tsThumbBtnVertDisabled;
          end
          else
          begin
            if bHandlingOtherSB then
              LDetail := tsThumbBtnVertNormal
            else
            if (fPressedIn = sbpThumb) then
            begin
              LDetail := tsThumbBtnVertPressed;
            end
            else
            begin
              if (not fPressed) and fMouseInControl and (fMouseOver = sbpThumb) then
              begin
                LDetail := tsThumbBtnVertHot;
              end
              else
              begin
                LDetail := tsThumbBtnVertNormal;
              end;
            end;
          end;
          LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
          if fDrawBars then
          begin
            R1 := LMDThemeServices.ContentRect(LThemeMode, TmpCanvas.Handle, ThemeServices.GetElementDetails(LDetail), R1);
            if not (Enabled and bWinEnabled) then
            begin
              LDetail := tsGripperVertDisabled;
            end
            else
            begin
              if bHandlingOtherSB then
                LDetail := tsGripperVertNormal
              else
              if (fPressedIn = sbpThumb) then
              begin
                LDetail := tsGripperVertPressed;
              end
              else
              begin
                if (not fPressed) and fMouseInControl and (fMouseOver = sbpThumb) then
                begin
                  LDetail := tsGripperVertHot;
                end
                else
                begin
                  LDetail := tsGripperVertNormal;
                end;
              end;
            end;
            LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
          end;
        end
        else
        begin
          TmpCanvas.Brush.Color := ThumbColor;
          if not TransBk then
            TmpCanvas.FillRect(R1);
          if fShowBorder then
            DrawButtonFrameEx3(TmpCanvas.Handle, R1, b,
              // pushed:
              (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpThumb) and
                (not NoSunkenThumb),
              Color, ThinFrame, AllBorderSides);
          if fDrawBars and (ATS > 14) then
          begin
            aH := fBarOffset;
            if fShowBorder then Inc(aH);
            if (b) and (fPressedIn = sbpThumb) and (not NoSunkenThumb) then
              aSh := 1
            else
              aSh := 0;
            if (R1.Right - R1.Left) >= aH + aH + 3 then
            begin
              with R1 do
              begin
                aW := (Bottom + Top) shr 1;
              end;
              Inc(aW, aSh);
              with TmpCanvas do
              begin
                Pen.Color := fBarColor;
                MoveTo(R1.Left + aH + aSh, aW - 1);
                LineTo(R1.Right - aH + aSh, aW - 1);
                MoveTo(R1.Left + aH + aSh, aW - 3);
                LineTo(R1.Right - aH + aSh, aW - 3);
                MoveTo(R1.Left + aH + aSh, aW + 1);
                LineTo(R1.Right - aH + aSh, aW + 1);
                MoveTo(R1.Left + aH + aSh, aW + 3);
                LineTo(R1.Right - aH + aSh, aW + 3);
              end;
            end;
          end;
        end;
      end;

      // then draw the right part of the scroll fields
      R2.Top := fThumbPos + ATS;
      R2.Bottom := Height;
      Dec(R2.Bottom, ButtonSize * GetBottomBtns);
      if fOwnerDraw and Assigned(fOnDrawPart) then
      begin
        fOnDrawPart(Self, TmpCanvas, R2, sbpRightBottom, Enabled and bWinEnabled, Focused,
          // pushed:
          (not bHandlingOtherSB) and fMouseInControl and (fPressedIn = sbpRightBottom) and
            (fMouseOver = fPressedIn),
          DefDraw);
      end;
      if DefDraw then
      begin
        if (LThemeMode <> ttmNone) then
        begin
          if (not (Enabled and bWinEnabled)) then
          begin
            LDetail := tsLowerTrackVertDisabled;
          end
          else
          begin
            if bHandlingOtherSB then
              LDetail := tsLowerTrackVertNormal
            else
            if (fPressedIn = sbpRightBottom) and (fMouseOver = fPressedIn) then
            begin
              LDetail := tsLowerTrackVertPressed;
            end
            else
            begin
              if (not fPressed) and fMouseInControl and (fMouseOver = sbpRightBottom) then
              begin
                LDetail := tsLowerTrackVertHot;
              end
              else
              begin
                LDetail := tsLowerTrackVertNormal;
              end;
            end;
          end;
          LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R2, LMDRectToPtr(RClip));
          end
        else
        begin
          if (not bHandlingOtherSB) and fMouseInControl{???} and (fPressedIn = sbpRightBottom) and
            (fMouseOver = fPressedIn) and ChangeColorsOnScroll
          then
          begin
            FillShadow(R2);
          end
          else
          begin
            FillBackground(R2);
          end;
        end;
      end;
    end
    else
    begin
      DefDraw := True;
      if fOwnerDraw and Assigned(fOnDrawPart) then
      begin
        fOnDrawPart(Self, TmpCanvas, R2, sbpNowhere, Enabled and bWinEnabled, Focused, False,
          DefDraw);
      end;
      if DefDraw then
      begin
      if (LThemeMode <> ttmNone) then
        begin
          LDetail := tsLowerTrackVertDisabled;
          LMDThemeServices.DrawElement(LThemeMode, TmpCanvas.Handle, LDetail, R2, LMDRectToPtr(RClip));
          end
        else
      if not TransBk then
          FillBackground(R2);
      end;
    end;
  end;
end;

procedure TElSBHandlerCustom.ShowHintAt(APosition, X, Y: Integer);
  var
    HintText :TLMDString;
    R        :TRect;
    P        :TPoint;
    mx, my   :Integer;
  function ClientToHintScreen(const Point:TPoint):TPoint;
  begin
    Result := Control.ClientToScreen(Point);
    with fSBController do
      if Kind = sbHorizontal then
      begin
        if (GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_LEFTSCROLLBAR)=0 then
          dec(Result.X, cxLeftEdge)
        else
          dec(Result.X, cxLeftEdge);
        inc(Result.Y, fHElSB.fScrollBarRect.Bottom+cyBottomEdge+fHElSB.Depth);
      end
      else
      begin
        if (GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_LEFTSCROLLBAR)=0 then
          inc(Result.X, fHElSB.fScrollBarRect.Right-cxLeftEdge)
        else
          dec(Result.X, fVElSB.Depth+cxLeftEdge);
        dec(Result.Y, cyTopEdge);
      end;
  end;

begin
  P := ClientToHintScreen(Point(X, Y));
  HintText := '';
  TriggerScrollHintNeededEvent(APosition, HintText);
  if Length(HintText)=0 then
    exit; // debug: HintText := ' ';
  if fHintWnd = nil then
    fHintWnd := TElHintWindow.Create(nil);

//???: todo:
//???  fHintWnd.Font.Assign(Font);
//???  fHintWnd.Font.Color := clInfoText;
//???  fHintWnd.Font.Charset := Font.Charset;

  fHintWnd.IsHTML := IsHTML;

  fHintWnd.Canvas.Font.Assign(fHintWnd.Font);

  mx := Screen.DesktopWidth + Screen.DesktopLeft;
  my := Screen.DesktopHeight + Screen.DesktopTop;

  {$IFDEF LMD_UNICODE}
  //R := fHintWnd.CalcHintRectW(mx, HintText, nil);
  R := fHintWnd.CalcHintRect(mx, HintText, nil);
  {$ELSE}
  R := fHintWnd.CalcHintRect(mx, HintText, nil);
  {$ENDIF}
  OffsetRect(R, P.X - (R.Right - R.Left + 1), P.Y - (R.Bottom - R.Top + 1));

  if R.Left < Screen.DesktopLeft then
    OffsetRect(R, Screen.DesktopLeft - R.Left, 0);
  if R.Top < Screen.DesktopTop then
    OffsetRect(R, 0, Screen.DesktopTop - R.Top);

  if R.Right > mx then OffsetRect(R, -(R.Right - mx), 0);
  if R.Bottom > my then OffsetRect(R, -(R.Bottom - my), 0);

  fHintWnd.Color := clInfoBk;
  {$IFDEF LMD_UNICODE}
  fHintWnd.ActivateHintW(R, HintText);
  {$ELSE}
  fHintWnd.ActivateHint(R, HintText);
  {$ENDIF}
end;

procedure TElSBHandlerCustom.TriggerChangeEvent;
begin
  if (assigned(fOnChange)) then
    fOnChange(Self);
end;

procedure TElSBHandlerCustom.TriggerScrollEvent(ScrollCode: TElScrollCode;
  var ScrollPos: Integer; var DoChange: Boolean);
begin
  DoChange := True;
  fSBController.ElSBScrollEvent(Self, ScrollCode, ScrollPos, DoChange);
  if DoChange and (Assigned(fOnScroll)) then // and (ScrollPos <> fPosition) then
  begin
    ScrollPos := fPosition;
    fOnScroll(Self, ScrollCode, ScrollPos, DoChange);
  end;
end;

procedure TElSBHandlerCustom.TriggerScrollHintNeededEvent(TrackPosition: Integer;
  var Hint: TLMDString);
begin
  if (assigned(fOnScrollHintNeeded)) then
    fOnScrollHintNeeded(Self, TrackPosition, Hint);
end;

function TElSBHandlerCustom.GetHitTest(X, Y: Integer): TElScrollBarPart;
  var
    BS      :Integer;
    CS      :Integer;
    ATS     :Integer;
    Default :Boolean;
begin
  TriggerHitTestEvent(X, Y, Result, Default);
  if not Default then
    exit;
  if Kind = sbHorizontal then
  begin
    if (Y < 0) or (Y > Height) then
    begin
      Result := sbpNowhere;
      exit;
    end;
    CS := Width;
    if CS > ButtonSize * (GetTopBtns + GetBottomBtns) then
      BS := ButtonSize
    else
      BS := CS div (GetTopBtns + GetBottomBtns);
    if fShowLeftArrows and LMDInRange(X, 0, BS) then
    begin
      Result := sbpLeftArrow;
      exit;
    end
    else
      if fShowRightArrows and (CS - X < BS) then
      begin
        Result := sbpRightArrow;
        exit;
      end;
    if fSecondaryButtons then
    begin
      if fShowLeftArrows and LMDInRange(X, BS, BS shl 1) then
      begin
        Result := sbpLeftSndArrow;
        exit;
      end
      else
        if fShowRightArrows and LMDInRange(X, CS - BS shl 1, CS - BS) then
        begin
          Result := sbpRightSndArrow;
          exit;
        end;
    end;

    BS := GetThumbPos;
    if BS = -1 then
    begin
      Result := sbpNowhere;
      exit;
    end;
    if X < BS then
    begin
      Result := sbpLeftTop;
      exit;
    end;
    if fThumbMode = etmFixed then
      ATS := ThumbSize
    else
      ATS := GetAutoThumbSize;
    if X >= BS + ATS then
    begin
      Result := sbpRightBottom;
      exit;
    end;
    Result := sbpThumb;
  end
  else // if Kind = sbVertical then
  begin
    if (X < 0) or (X > Width) then
    begin
      Result := sbpNowhere;
      exit;
    end;
    CS := Height;
    if CS > ButtonSize * (GetTopBtns + GetBottomBtns) then
      BS := ButtonSize
    else
      BS := CS div (GetTopBtns + GetBottomBtns);
    if fShowLeftArrows and LMDInRange(Y, 0, BS) then
    begin
      Result := sbpLeftArrow;
      exit;
    end
    else
      if Self.fShowRightArrows and (CS - Y < BS) then
      begin
        Result := sbpRightArrow;
        exit;
      end;
    if SecondaryButtons then
    begin
      if fShowLeftArrows and LMDInRange(Y, BS, BS shl 1) then
      begin
        Result := sbpLeftSndArrow;
        exit;
      end
      else
        if fShowRightArrows and LMDInRange(Y, CS - BS shl 1, CS - BS) then
        begin
          Result := sbpRightSndArrow;
          exit;
        end;
    end;
    BS := GetThumbPos;
    if BS = -1 then
    begin
      Result := sbpNowhere;
      exit;
    end;
    if Y < BS then
    begin
      Result := sbpLeftTop;
      exit;
    end;
    if fThumbMode = etmFixed then
      ATS := ThumbSize
    else
      ATS := GetAutoThumbSize;
    if Y >= BS + ATS then
    begin
      Result := sbpRightBottom;
      exit;
    end;
    Result := sbpThumb;
  end;
end;

//debug:
{
const
  cElScrollCode: array[TElScrollCode]of String =(
    'escLineUp', 'escLineDown', 'escPageUp', 'escPageDown',
    'escPosition', 'escTrack', 'escTop', 'escBottom', 'escEndScroll',
    'escSndLineUp', 'escSndLineDown');
}

procedure TElSBHandlerCustom.OnScrollTimer(Sender: TObject);
  var
    ScrollCode  :TElScrollCode;
    NewPos      :Integer;
    DoChange    :Boolean;
    CP          :TPoint;
    fPage       :Integer;
begin
try
  fPage := Self.fPage;
  if fPage = 0 then
    fPage := 1;
  fScrollTimer.Interval := GetKeybTimes(SPI_GETKEYBOARDSPEED);
  GetCursorPos(CP);
  CP := Control.ScreenToClient(CP);
  inc(CP.Y, fSBController.cyTopEdge);
  inc(CP.X, fSBController.cxLeftEdge);
  if (fSBController.fVElSB.Visible) and
     ((GetWindowLong(Control.Handle, GWL_EXSTYLE) and WS_EX_LEFTSCROLLBAR)<>0) then
    inc(CP.X, fSBController.fVElSB.Depth);

  dec(CP.Y, fScrollBarRect.Top);
  dec(CP.X, fScrollBarRect.Left);

  DoChange := True;

  ScrollCode := escSndLineUp;

  case fPressedIn of
    sbpLeftTop:
      begin
        ScrollCode := escPageUp;
        with CP do
          if GetHitTest(X, Y) = sbpLeftTop then
            NewPos := MaxSB(fMin, fPosition - fPage)
          else
            NewPos := Position;
      end;
    sbpRightBottom:
      begin
        ScrollCode := escPageDown;
        with CP do
          if GetHitTest(X, Y) = sbpRightBottom then
            NewPos := MinSB(fMax, fPosition + fPage)
          else
            NewPos := Position;
      end;
    sbpLeftArrow:
      begin
        ScrollCode := escLineUp;
        NewPos := MaxSB(fMin, fPosition - fStep);
      end;
    sbpRightArrow:
      begin
        ScrollCode := escLineDown;
        NewPos := MinSB(fMax, fPosition + fStep);
      end;
    sbpRightSndArrow:
      begin
        case fSecondBtnKind of
          sbkOpposite:
            begin
              ScrollCode := escLineUp;
              NewPos := MaxSB(fMin, fPosition - fStep);
            end;
          sbkPage:
            begin
              ScrollCode := escPageDown;
              NewPos := MinSB(fMax, fPosition + fPage);
            end;
          sbkCustom:
            begin
              ScrollCode := escSndLineUp;
              NewPos := fPosition;
            end;
        end;
      end;
    sbpLeftSndArrow:
      begin
        case fSecondBtnKind of
          sbkOpposite:
            begin
              ScrollCode := escLineDown;
              NewPos := MinSB(fMax, fPosition + fStep);
            end;
          sbkPage:
            begin
              ScrollCode := escPageUp;
              NewPos := MaxSB(fMin, fPosition - fPage);
            end;
          sbkCustom:
            begin
              ScrollCode := escSndLineDown;
              NewPos := fPosition;
            end;
        end;
      end;
    else
      exit;
  end;
  //debug:
  //if NewPos <> fPosition then
  //  LMDDebug('OnScrollTimer, Code='+cElScrollCode[ScrollCode]+', NewPos='+IntToStr(NewPos)+', CurPos='+IntToStr(fPosition));
  if (NewPos <> Position) then {if traced to the beginning/end, then no need to generate dublicates - this is why twinkling when scrolling to the end or beginning}
  begin
    TriggerScrollEvent(ScrollCode, NewPos, DoChange);
    if DoChange and (NewPos <> Position) then
    begin
      Position := NewPos;
      TriggerChangeEvent;
    end;
  end;
except
  on e:exception do
  begin
    LMDDebug( PChar('ERROR: OnScrollTimer ('+IntToStr(fBarFlag)+'): '+e.Message) );
    end;
end;
end;

function TElSBHandlerCustom.GetTopBtns: Integer;
begin
  if not fShowLeftArrows then
    Result := 0
  else
    if Self.fSecondaryButtons then
      Result := 2
    else
      Result := 1;
end;

function TElSBHandlerCustom.GetBottomBtns: Integer;
begin
  if not fShowRightArrows then
    Result := 0
  else
    if Self.fSecondaryButtons then
      Result := 2
    else
      Result := 1;
end;

function TElSBHandlerCustom.GetThumbPos: Integer;
begin
  Result := fThumbPos;
end;

function TElSBHandlerCustom.UpdateThumbPos: Integer;
  var
    CS   :Integer;
    ATS  :Integer;
begin
  if Kind = sbHorizontal then
    CS := Width
  else
    CS := Height;
  if fThumbMode = etmFixed then
    ATS := ThumbSize
  else
    ATS := GetAutoThumbSize;
  Result := MulDiv(fThumbPos - ButtonSize * GetTopBtns, (Max - Min + 1) -
    MinSB((Page), (Max - Min + 1)), (CS - ButtonSize * (GetTopBtns + GetBottomBtns) - ATS))
    + Min;
end;

function TElSBHandlerCustom.AdjustThumbPos: Integer;
  var
    CS, ATS, XX, TB, BB: Integer;
begin
  if Kind = sbHorizontal then
    CS := Width
  else
    CS := Height;
  if fThumbMode = etmFixed then
    ATS := ThumbSize
  else
    ATS := GetAutoThumbSize;
  TB := GetTopBtns;
  BB := GetBottomBtns;
  if (CS > (ButtonSize * (TB + BB) + ATS)) and (Max > Min - 1) then
  begin
    XX := MinSB(Max + 1 - Page, Position) - Min;
    Result := ButtonSize * TB
      + MaxSB(0, MulDiv((CS - ButtonSize * (TB + BB) - ATS),
      XX, (Max - Min + 1) - MinSB((Page), (Max - Min + 1))));
  end
  else
    Result := ButtonSize * TB;
end;

function TElSBHandlerCustom.GetButtonSize: Integer;
  var
    CS, AButtonSize :Integer;
begin
  if fUseSystemMetrics then
  begin
    if Kind = sbHorizontal then
      AButtonSize := GetSystemMetrics(SM_CXHSCROLL)
    else
      AButtonSize := GetSystemMetrics(SM_CYVSCROLL);
    end
  else
    AButtonSize := fButtonSize;
  if Kind = sbHorizontal then
    CS := Width
  else
    CS := Height;
  if CS < AButtonSize * (GetTopBtns + GetBottomBtns) then
    Result := CS div (GetTopBtns + GetBottomBtns)
  else
    Result := AButtonSize;
end;

function TElSBHandlerCustom.GetAutoThumbSize: Integer;
  var
    CS, FW, TB, BB, BS, APage :Integer;
begin
  APage := fPage;
  if Kind = sbHorizontal then
    CS := Width
  else
    CS := Height;
  TB := GetTopBtns;
  BB := GetBottomBtns;
  BS := ButtonSize;
  FW := CS - (ButtonSize * (TB + BB));
  if FW < 0 then
    Result := 0
  else
  begin
    if (APage = 0) then
    begin
      if (Max < Min + 1) or (APage > (Max - Min)) then
        Result := (CS - BS * (TB + BB))
      else
        if Kind = sbHorizontal then
          Result := GetSystemMetrics(SM_CXHTHUMB)
        else
          Result := GetSystemMetrics(SM_CYVTHUMB);
        end
    else
    begin
      if (Max < Min + 1) or (APage > (Max - Min)) then
        Result := (CS - BS * (TB + BB))
      else
        Result := MulDiv(MinSB(APage, (Max - Min + 1)), (CS - BS * (TB + BB)),
          (Max - Min + 1));
    end;
    if Result < fMinThumbSize then
      Result := fMinThumbSize;
    if Result > FW then
      Result := 0;
  end;
end;

procedure TElSBHandlerCustom.SetButtonSize(newValue: Integer);
{ Sets data member fButtonSize to newValue. }
begin
  if (fButtonSize <> newValue) and (newValue > 0) then
  begin
    if (not HandleAllocated) or
       ( ( (kind = sbHorizontal) and (newValue shl 1 <= Width ) ) or
         ( (kind = sbVertical)   and (newValue shl 1 <= Height) )
       )
    then
    begin
      fButtonSize := newValue;
      if (not (csLoading in ComponentState)) and HandleAllocated then
      begin
        fThumbPos := AdjustThumbPos;
        Invalidate;
      end;
    end;
  end;
end;

procedure TElSBHandlerCustom.SetThumbMode(newValue: TElScrollThumbMode);
{ Sets data member fThumbMode to newValue. }
begin
  if (fThumbMode <> newValue) then
  begin
    fThumbMode := newValue;
    if UseSystemMetrics and (ThumbMode = etmFixed) then
    begin
      if Kind = sbHorizontal then
        ThumbSize := GetSystemMetrics(SM_CXHTHUMB)
      else
        ThumbSize := GetSystemMetrics(SM_CYVTHUMB);
      end;
    if (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      fThumbPos := AdjustThumbPos;
      Invalidate;
    end;
  end;
end;

procedure TElSBHandlerCustom.SetThumbSize(newValue: Integer);
begin
  if (fThumbSize <> newValue) and (newValue > 0) then
  begin
    fThumbSize := newValue;
    if (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      fThumbPos := AdjustThumbPos;
      Invalidate;
    end;
  end;
end;

procedure TElSBHandlerCustom.SetMinThumbSize(newValue: Integer);
{ Sets data member fMinThumbSize to newValue. }
begin
  if (fMinThumbSize <> newValue) and (newValue > 0) then
  begin
    fMinThumbSize := newValue;
    if (ThumbMode = etmAuto) and (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      fThumbPos := AdjustThumbPos;
      Invalidate;
    end;
  end;
end;

procedure TElSBHandlerCustom.SetPage(newValue: Integer);
{ Sets data member fPage to newValue. }
begin
  DoSetPage(newValue, not (csLoading in ComponentState) and HandleAllocated);
end;

procedure TElSBHandlerCustom.SetSecondaryButtons(newValue: Boolean);
{ Sets data member fSecondaryButtons to newValue. }
begin
  if (fSecondaryButtons <> newValue) then
  begin
    fSecondaryButtons := newValue;
    if (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      fThumbPos := AdjustThumbPos;
      Invalidate;
    end;
  end;
end;

procedure TElSBHandlerCustom.SetSecondBtnKind(newValue: TElSecButtonsKind);
begin
  if newValue <> fSecondBtnKind then
  begin
    fSecondBtnKind := newValue;
    if fSecondaryButtons and (not (csLoading in ComponentState)) and HandleAllocated then
      Invalidate;
  end;
end;

procedure TElSBHandlerCustom.SetOwnerDraw(newValue: Boolean);
{ Sets data member fOwnerDraw to newValue. }
begin
  if (fOwnerDraw <> newValue) then
  begin
    fOwnerDraw := newValue;
    Invalidate;
  end;
end;

procedure TElSBHandlerCustom.SetNoDisableButtons(newValue: Boolean);
{ Sets data member fNoDisableButtons to newValue. }
begin
  if (fNoDisableButtons <> newValue) then
  begin
    fNoDisableButtons := newValue;
    Invalidate;
  end;
end;

procedure TElSBHandlerCustom.UpdateScrollingRegion;
begin
  Perform( WM_ELSCROLLBAR, ELSB_PAINT, fBarFlag);
end;

function TElSBHandlerCustom.GetIsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

procedure TElSBHandlerCustom.SetIsDesigning(newValue: Boolean);
begin
  //???:
  //SetDesigning(newValue);
end;

procedure TElSBHandlerCustom.SetBlendBackground(newValue: Boolean);
begin
  if (fBlendBackground <> newValue) then
  begin
    fBlendBackground := newValue;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TElSBHandlerCustom.SetShowLeftArrows(newValue: Boolean);
{ Sets data member fShowLeftArrows to newValue. }
begin
  if (fShowLeftArrows <> newValue) then
  begin
    fShowLeftArrows := newValue;
    if (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      fThumbPos := AdjustThumbPos;
      Invalidate;
    end;
  end;
end;

procedure TElSBHandlerCustom.SetShowRightArrows(newValue: Boolean);
{ Sets data member fShowRightArrows to newValue. }
begin
  if (fShowRightArrows <> newValue) then
  begin
    fShowRightArrows := newValue;
    if (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      fThumbPos := AdjustThumbPos;
      Invalidate;
    end;
  end;
end;

procedure TElSBHandlerCustom.UpdateSystemMetrics;
begin
  if fUseSystemMetrics then
  begin
    fUseSystemMetrics := False;
    UseSystemMetrics  := True;
  end;
end;

procedure TElSBHandlerCustom.SetUseSystemMetrics(value: Boolean);
  begin
  if fUseSystemMetrics <> value then
  begin
    fUseSystemMetrics := Value;
    if (csLoading in ComponentState) or
       ((Owner <> nil) and (csLoading in Owner.ComponentState)) or
       (not HandleAllocated)
    then
      exit;
    if Value then
    begin
      if Kind = sbHorizontal then
      begin
        begin
          ButtonSize := GetSystemMetrics(SM_CXHSCROLL);
          Height := GetSystemMetrics(SM_CXVSCROLL);
        end;
        end
      else
      begin
        begin
          ButtonSize := GetSystemMetrics(SM_CYVSCROLL);
          Width := GetSystemMetrics(SM_CYHSCROLL);
        end;
        end;
      if HandleAllocated then
      begin
        fThumbPos := AdjustThumbPos;
        fSBController.InitiateNCCalcSize;
      end;
    end
    else
      if HandleAllocated then
      begin
        fThumbPos := AdjustThumbPos;
        fSBController.InitiateNCCalcSize;
      end;
  end;
end;

function TElSBHandlerCustom.NoUseSystemMetrics:Boolean;
begin
  Result := not fUseSystemMetrics;
end;
procedure TElSBHandlerCustom.SetNoSunkenThumb(newValue: Boolean);
{ Sets data member fNoSunkenThumb to newValue. }
begin
  if (fNoSunkenThumb <> newValue) then
  begin
    fNoSunkenThumb := newValue;
    if fPressedIn = sbpThumb then Invalidate;
  end;
end;

procedure TElSBHandlerCustom.SetArrowColor(newValue: TColor);
{ Sets data member fArrowColor to newValue. }
begin
  if (fArrowColor <> newValue) then
  begin
    fArrowColor := newValue;
    Invalidate;
  end;
end;

procedure TElSBHandlerCustom.SetArrowHotTrackColor(newValue: TColor);
{ Sets data member fArrowHotTrackColor to newValue. }
begin
  if (fArrowHotTrackColor <> newValue) then
  begin
    fArrowHotTrackColor := newValue;
    Invalidate;
  end;
end;

procedure TElSBHandlerCustom.SetShowBorder(newValue: Boolean);
{ Sets data member fShowBorder to newValue. }
begin
  if (fShowBorder <> newValue) then
  begin
    fShowBorder := newValue;
    if not newValue then fDrawArrowFrames := False;
    Invalidate;
  end;
end;

procedure TElSBHandlerCustom.SetThinFrame(newValue: Boolean);
{ Sets data member fThinFrame to newValue. }
begin
  if (fThinFrame <> newValue) then
  begin
    fThinFrame := newValue;
    Invalidate;
  end;
end;

destructor TElSBHandlerCustom.Destroy;
begin
  if (FCanvas <> nil) then
  begin
    if (Control <> nil) and Control.HandleAllocated then
      ReleaseDC(Control.Handle, FCanvas.Handle);
    FCanvas.Handle := 0;
  end;

  fCanvas.Free;
  DestroyScrollTimer;
  inherited;
end;

procedure TElSBHandlerCustom.DestroyScrollTimer;
begin
  if Assigned(fScrollTimer) then
    FreeAndNil(fScrollTimer);
end;

constructor TElSBHandlerCustom.Create(AController:TElSBController);
begin
  inherited Create; //dummy code
  //ParentColor := True;
  fColor := clBtnFace;
  //<abb 2014>
  fThumbColor := clBtnFace;
  //</abb 2014>
  fSBController := AController;

//  CreateScrollTimer;

  Width := 121;
  Height := GetSystemMetrics(SM_CYHSCROLL);
  fKind := sbHorizontal;
  fFlat := True;
  fMinThumbSize := 12;
  fThumbMode := etmAuto;
  fMin := 0;
  fMax := -1;
  fPosition := -1;//fMin-1;
  fPage := 14;
  fTrackPos := -1;
  fStep := 1;
  fUseSystemStep := True;
  fButtonSize := 17;
  BlendBackground := True;
  fShowLeftArrows := True;
  fShowRightArrows := True;
  fChangeColorsOnScroll := True;
  FThemeMode := ttmPlatform;
  fVisible := True;
  UseSystemMetrics := True;
  fArrowColor := clBtnText;
  fArrowHotTrackColor := clHighlight;
  fAltDisablingArrows := True;
  fHintColor := clInfoBk;
  fHintTextColor := clInfoText;
  fSysBkColor := True;
  fShowBorder := True;
  fDrawArrowFrames := True;
  fDrawBars := True;
  fBarOffset := 2;
  fBarColor := clBtnShadow;
  fNoScrollMessages := True;
  if fBlendBitmap = nil then
  begin
    fBitmapOwner := True;
    fBlendBitmap := TBitmap.Create;
    fBlendBitmap.Width := 8;
    fBlendBitmap.Height := 8;
  end;
  RebuildBackground;
end;

procedure TElSBHandlerCustom.CreateScrollTimer;
begin
  fScrollTimer := TTimer.Create(nil);
  fScrollTimer.Enabled := False;
  fScrollTimer.OnTimer := OnScrollTimer;
end;

procedure TElSBHandlerCustom.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
    Invalidate;
  end;
end;

function TElSBHandlerCustom.SetScrollInfo(ScrollInfo: TScrollInfo;
    Redraw: BOOL): Integer;
var
  fRecalcFrame :Boolean;
  fVisible     :Boolean;
begin
  if ScrollInfo.cbSize < sizeof(TScrollInfo) then
    begin
      Result := Position;
      exit;
    end;

  fRecalcFrame := False;

  with ScrollInfo do
  begin
    if (fMask and SIF_RANGE) <> 0 then
      begin
        if (nMin <= nMax) then
          begin
            if (fMask and SIF_POS) <> 0 then
              begin
                if (nPos < nMin) then
                  nPos := nMin
                else
                  if (nPos > nMax) then
                    nPos := nMax;
                fPosition := nPos;
                fMin := nMin;
                fMax := nMax;
                if (fMask and SIF_PAGE) <> 0 then
                  fPage := nPage;
              end
            else
              begin
                if LMDInRange(fPosition, nMin, nMax) then
                  begin
                    fMin := nMin;
                    fMax := nMax;
                    if (fMask and SIF_PAGE) <> 0 then
                      fPage := nPage;
                  end;
              end;
          end;
        fThumbPos := AdjustThumbPos;
      end// SIF_RANGE
    else
      if (fMask and SIF_POS) <> 0 then
        begin
          if LMDInRange(nPos, fMin, fMax) then
            begin
              if (fMask and SIF_PAGE) <> 0 then
                fPage := nPage;
              fPosition := nPos;
              fThumbPos := AdjustThumbPos;
            end;
        end//SIF_POS
    else
      if (fMask and SIF_PAGE) <> 0 then
        begin
          fPage := nPage;
          fThumbPos := AdjustThumbPos;
        end;//SIF_PAGE

    fVisible := Visible;
    if (fMask and SIF_DISABLENOSCROLL) <> 0 then
      begin
        if fVisible then
          begin
            fSBController.DoShowScrollBar(fBarFlag, True);
            fRecalcFrame := True;
          end
      end
    else
      begin
        if (Page > Max) or
           ((Page = Max) and (Max = 0)) or
           (Max  <= Min) then
          begin
            if fVisible then
              begin
                fSBController.DoShowScrollBar(fBarFlag, True);
                fRecalcFrame := True;
              end;
          end
        else
          begin
            if fVisible then
              begin
                fSBController.DoShowScrollBar(fBarFlag, True);
                fRecalcFrame := True;
              end;
          end;
      end;
  end;
  if Redraw and HandleAllocated then
    begin
      if not fRecalcFrame then
        SendMessage(Control.Handle, WM_NCPAINT, WPARAM(1), 0)
      else
        fSBController.InitiateNCCalcSize;
    end;
  Result := fPosition;
end;

function TElSBHandlerCustom.RightBtnsEnabled: Boolean;
begin
  if fAltDisablingArrows then
  begin
    Result := (Position < fMax - fPage + 1) and (Page <= fMax - fMin);
  end
  else
    Result := (Position < fMax) and (Page <= fMax - fMin);
end;

function TElSBHandlerCustom.LeftBtnsEnabled: Boolean;
begin
  Result := (Position > Min) and (Page <= fMax - fMin);
end;

procedure TElSBHandlerCustom.SetSysBkColor(Value: Boolean);
begin
  if fSysBkColor <> Value then
  begin
    fSysBkColor := Value;
    Invalidate;
  end;
end;

procedure TElSBHandlerCustom.RebuildBackground;
  var
    i, j :Integer;
begin
  if fBitmapOwner then
  begin
    with fBlendBitmap.Canvas do
    begin
      for i := 0 to 7 do
        for j := 0 to 7 do
          if ((j xor i) and 1) <> 0 then
            Pixels[i, j] := Color
          else
            Pixels[i, j] := LighterColor;
      end;
  end;
end;

procedure TElSBHandlerCustom.SetAltDisablingArrows(const Value: Boolean);
begin
  // Since we synchronize with system scrollbar and it never scrolls to the end,
  // then by default we always set AltDisablingArrows = True
  {
  if fAltDisablingArrows <> Value then
  begin
    fAltDisablingArrows := Value;
    Invalidate;
  end;
  {}
end;

function TElSBHandlerCustom.GetThumbSize: Integer;

begin
  Result := fThumbSize;

  if fUseSystemMetrics then
  begin
    if Kind = sbHorizontal then
    begin
      if ThumbMode = etmFixed then
      Result := GetSystemMetrics(SM_CXHTHUMB);
      end
    else
    begin
      if ThumbMode = etmFixed then
      Result := GetSystemMetrics(SM_CYVTHUMB);
      end;

  end;
end;

procedure TElSBHandlerCustom.SetDrawArrowFrames(const Value: Boolean);
begin
  if (fDrawArrowFrames <> Value) then
  begin
    fDrawArrowFrames := Value;
    Invalidate;
  end;
end;

procedure TElSBHandlerCustom.SetDrawBars(const Value: Boolean);
begin
  if (fDrawBars <> Value) then
  begin
    fDrawBars := Value;
    Invalidate;
  end;
end;

procedure TElSBHandlerCustom.SetBarColor(const Value: TColor);
begin
  if (fBarColor <> Value) then
  begin
    fBarColor := Value;
    Invalidate;
  end;
end;

procedure TElSBHandlerCustom.SetBarOffset(const Value: Cardinal);
begin
  if (fBarOffset <> Value) then
  begin
    fBarOffset := Value;
    Invalidate;
  end;
end;

procedure TElSBHandlerCustom.TriggerHitTestEvent(X, Y :Integer; var Part :
    TElScrollBarPart; var DefaultTest :Boolean);
begin
  DefaultTest := True;
  if assigned(OnHitTest) then
    OnHitTest(Self, X, Y, Part, DefaultTest);
end;

procedure TElSBHandlerCustom.WMMouseWheel(var Msg: TMessage);
  var
    Dy, i, sl  :Integer;
    ScrollCode :TElScrollCode;
    NewPos     :Integer;
    DoChange   :Boolean;
begin
  inherited;
  if LMDSIWindowsNTUp or LMDSIWindows98 then
    SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
  else
    sl := 3;

  if sl = 0 then sl := 1;
  Dy := TWMMouseWheel(Msg).WheelDelta div (MOUSE_WHEEL_DELTA div sl);
  if Dy <> 0 then
  begin
    DoChange := True;
    for i := 1 to Abs(Dy) do
    begin
      NewPos := Position - LMDSign(Dy);
      if Dy < 0 then
        ScrollCode := escLineDown
      else
        ScrollCode := escLineUp;
      TriggerScrollEvent(ScrollCode, NewPos, DoChange);
      if DoChange and (NewPos <> Position) then
      begin
        Position := NewPos;
        TriggerChangeEvent;
      end
      else
        Break;
    end;
    NewPos := Position;
    DoChange := True;
    ScrollCode := escEndScroll;
    TriggerScrollEvent(ScrollCode, NewPos, DoChange);
    if DoChange and (NewPos <> Position) then
    begin
      Position := NewPos;
      TriggerChangeEvent;
    end;
  end;
end;

function TElSBHandlerCustom.IsThemed:Boolean;
begin
  Result := (UseThemeMode <> ttmNone) and fSBController.IsThemed;
end;

procedure TElSBHandlerCustom.Invalidate;
begin
  if fSBController.fUpdateCount=0 then
    Perform( WM_ELSCROLLBAR, ELSB_PAINT, fBarFlag);
end;

procedure TElSBHandlerCustom.SetColor(Value:TColor);
begin
  if Value<>fColor then
  begin
    fColor := Value;
    Invalidate;
  end;
end;

//<abb 2014>
procedure TElSBHandlerCustom.SetThumbColor(Value:TColor);
begin
  if Value<>fThumbColor then
  begin
    fThumbColor := Value;
    Invalidate;
  end;
end;
//</abb 2014>

function TElSBHandlerCustom.ClientRect:TRect;
begin
  //???
  SetRect(Result, 0,0, Width, Height);
end;

procedure TElSBHandlerCustom.SetEnabled(Value:Boolean);
begin
  if fEnabled<>Value then
  begin
    fEnabled := Value;
    Invalidate;
  end;
end;

function TElSBHandlerCustom.GetFocused:Boolean;
begin
  Result := Control.Focused;
end;

{function TElSBHandlerCustom.ClientToScreen(const Point:TPoint):TPoint;
begin
  Result := Control.ClientToScreen(Point);
  with fSBController do
    if Kind = sbHorizontal then
    begin
      if (GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_LEFTSCROLLBAR)=0 then
        dec(Result.X, cxLeftEdge)
      else
        dec(Result.X, cxLeftEdge);
      inc(Result.Y, fHElSB.fScrollBarRect.Bottom+cyBottomEdge+fHElSB.Depth);
    end
    else
    begin
      if (GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_LEFTSCROLLBAR)=0 then
        inc(Result.X, fHElSB.fScrollBarRect.Right-cxLeftEdge)
      else
        dec(Result.X, fVElSB.Depth+cxLeftEdge);
      dec(Result.Y, cyTopEdge);
    end;
end;{}

function TElSBHandlerCustom.GetHandleAllocated:Boolean;
begin
  Result := Assigned(Control) and Control.HandleAllocated;
end;

function TElSBHandlerCustom.GetHandle:THandle;
begin
  if Assigned(Control) then
    Result := Control.Handle
  else
    Result := 0;
end;

function TElSBHandlerCustom.Perform(Msg: Cardinal; WParam, LParam: Longint): Longint;
begin
  Result := Control.Perform(Msg, WParam, LParam);
end;

function TElSBHandlerCustom.GetControlOwner:TComponent;
begin
  if Assigned(Control) then
    Result := Control.Owner
  else
    Result := nil;
end;

procedure TElSBHandlerCustom.SyncScrollInfo(const SI:TScrollInfo; bRedraw:Boolean);
  var
    bNeedBothRedraw :Boolean;
    vSize :Integer;
    sSI:TScrollInfo;
begin  // Synchronize Scroll Bar with System ScrollInfo:
  (*{$IFDEF LMD_DEBUGMESSAGES}
  LMDDebug( PChar('  '+Control.Name+':SyncScrollInfo;  Redraw='+IntToStr(Byte(bRedraw))) );
  {$ENDIF IFDEF LMD_DEBUGMESSAGES}*)
  with Control do
  begin
    sSI := SI;
    if not Windows.GetScrollInfo(Handle, fBarFlag, sSI) then
      sSI := SI;
    //RANGE:
    if (sSI.fMask and SIF_RANGE) <> 0 then
    begin
      if fBarFlag = SB_HORZ then
        vSize := Control.Width - fSBController.fVElSB.Depth
      else
        vSize := Control.Height - fSBController.fHElSB.Depth;
      bNeedBothRedraw := ((fMax-fMin)<vSize) and
                         ((sSI.nMax-sSI.nMin)>=vSize);
      fMin := sSI.nMin;
      fMax := sSI.nMax;
    end
    else
      bNeedBothRedraw := False;
    //PAGE:
    if (sSI.fMask and SIF_PAGE) <> 0 then
      fPage := sSI.nPage;
    //POS:
    if (sSI.fMask and SIF_POS) <> 0 then
      fPosition := sSI.nPos;
    //TRACKPOS:
    if (sSI.fMask and SIF_TRACKPOS) <> 0 then
      fTrackPos := sSI.nTrackPos;
    fThumbPos := AdjustThumbPos;

    //???
    Self.fEnabled := ((SI.fMask and SIF_DISABLENOSCROLL)=0) and (fMax>fMin);
    //Self.fEnabled := {((SI.fMask and SIF_DISABLENOSCROLL)=0)and{}((Page*fMax-fMin)>Self.Size{});
    //Self.fEnabled := {((SI.fMask and SIF_DISABLENOSCROLL)=0)and{}((fMax/fPage -fMin)>0{});

    if bRedraw then
    begin
      if not bNeedBothRedraw then
        Perform( WM_ELSCROLLBAR, ELSB_PAINT, fBarFlag)
      else
        Perform( WM_ELSCROLLBAR, ELSB_PAINT, SB_BOTH);
    end
    else
    if bNeedBothRedraw then
    begin
      if fBarFlag = SB_HORZ then
        Perform( WM_ELSCROLLBAR, ELSB_PAINT, SB_VERT)
      else
        Perform( WM_ELSCROLLBAR, ELSB_PAINT, SB_HORZ)
    end;
  end;
end;

procedure TElSBHandlerCustom.Assign(Source: TPersistent);
begin
  if Source is TElSBHandlerCustom then
  with TElSBHandlerCustom(Source) do
    begin
      // properties:
      Self.ActiveFlat           := ActiveFlat;
      Self.AltDisablingArrows   := AltDisablingArrows;
      Self.ArrowColor           := ArrowColor;
      Self.ArrowHotTrackColor   := ArrowHotTrackColor;
      Self.BarOffset            := BarOffset;
      Self.BarColor             := BarColor;
      Self.BlendBackground      := BlendBackground;
      Self.ButtonSize           := ButtonSize;
      Self.ChangeColorsOnScroll := ChangeColorsOnScroll;
      Self.Color                := Color;
      //<abb 2014>
      Self.ThumbColor           := ThumbColor;
      //</abb 2014>
      Self.Depth                := Depth;
      Self.DrawArrowFrames      := DrawArrowFrames;
      Self.DrawBars             := DrawBars;
      Self.ShowBorder           := ShowBorder;
      Self.Flat                 := Flat;
      //{$IFDEF LMD_UNICODE}
      //Self.Hint                 := Hint;
      //{$ENDIF}
      Self.HintColor            := HintColor;
      Self.HintTextColor        := HintTextColor;
      Self.IsHTML               := IsHTML;
      Self.MinThumbSize         := MinThumbSize;
      Self.NoDisableButtons     := NoDisableButtons;
      Self.NoSunkenThumb        := NoSunkenThumb;
      Self.OwnerDraw            := OwnerDraw;
      Self.SecondaryButtons     := SecondaryButtons;
      Self.SecondBtnKind        := SecondBtnKind;
      Self.ShowLeftArrows       := ShowLeftArrows;
      Self.ShowRightArrows      := ShowRightArrows;
      Self.ShowTrackHint        := ShowTrackHint;
      Self.Step                 := Step;
      Self.SystemBkColor        := SystemBkColor;
      Self.ThinFrame            := ThinFrame;
      Self.ThumbMode            := ThumbMode;
      Self.ThumbSize            := ThumbSize;
      Self.UseSystemMetrics     := UseSystemMetrics;
      Self.UseSystemStep        := UseSystemStep;
      Self.UseXPThemes          := UseXPThemes;
      // events:
      Self.OnChange             := OnChange;
      //Self.OnHitTest            := OnHitTest;
      //Self.OnScroll             := OnScroll;
      //Self.OnScrollHintNeeded   := OnScrollHintNeeded;
      //Self.OnDrawPart           := OnDrawPart;

      // for not TScrollingWinControl Control Container:
      Self.fScrollTracking      := fScrollTracking;
    end
  else
    inherited Assign(Source);
end;

procedure TElSBHandlerCustom.SyncScrollInfoFromSystem(bRedraw:Boolean);
  var
    SI :TScrollInfo;
begin // Synchronize Scoll Bar with System ScrollInfo:
  if Assigned(Control) then
    with Control do
    if HandleAllocated then
    begin
      (*{$IFDEF LMD_DEBUGMESSAGES}
      LMDDebug( PChar(Control.Name+':SyncScrollInfoFromSystem; Redraw='+IntToStr(Byte(bRedraw))) );
      {$ENDIF IFDEF LMD_DEBUGMESSAGES}*)
      SI.cbSize := SizeOf(TScrollInfo);
      SI.fMask := SIF_ALL;
      if Windows.GetScrollInfo( Handle, fBarFlag, SI) then
        SyncScrollInfo(SI, bRedraw);
    end
    else
    begin
      fPosition := -1;
      fTrackPos := -1;
      fThumbPos := 0;
    end;
end;

function TElSBHandlerCustom.GetComponentState:TComponentState;
begin
  if Assigned(fSBController.Owner) then
    Result := fSBController.Owner.ComponentState
  else
    Result := fSBController.ComponentState;
end;

function TElSBHandlerCustom.GetControl:TWinControl;
begin
  Result := fSBController.Control;
end;

function TElSBHandlerCustom.GetDepth:Integer;
begin
// Depth: for horiz ScrollBar it's height, for vert it's width.
  if Kind = sbHorizontal then
    Result := Height
  else
    Result := Width;
end;

{
function TElSBHandlerCustom.GetSize:Integer;
begin
  if Kind = sbHorizontal then
    Result := Width
  else
    Result := Height;
end;
}

procedure TElSBHandlerCustom.SetDepth(Value :Integer);
begin
  if (fSBController.Control=nil) or ((not fUseSystemMetrics) and (Depth<>Value)) then
  begin
    if Kind = sbHorizontal then
      Height := Value
    else
      Width  := Value;
    fSBController.InitiateNCCalcSize; // - Update Control
  end;
end;

function TElSBHandlerCustom.GetImageForm: TElImageForm;
begin
  Result := nil;
end;

procedure TElSBHandlerCustom.SetImageForm(Value: TElImageForm);
begin
end;

function TElSBHandlerCustom.GetVisible:Boolean;
begin
  if HandleAllocated then
  begin
    if not fSBController.fPreventStyleChange then
    begin
      if fBarFlag = SB_HORZ then
        Result := (WS_HSCROLL and GetWindowLong(Control.Handle, GWL_STYLE))<>0
      else
        Result := (WS_VSCROLL and GetWindowLong(Control.Handle, GWL_STYLE))<>0;
      if Result<>fVisible then
        fVisible := Result;
    end
    else
      Result := fVisible;
  end
  else
    Result := fVisible;
end;

procedure TElSBHandlerCustom.SetVisible(Value:Boolean);
  var
    ScrollInfo :TScrollInfo;
begin
  fVisible := Value;
  if HandleAllocated and (not Value) and (Max>Min) then
  begin
    ScrollInfo.cbSize := SizeOf(ScrollInfo);
    ScrollInfo.fMask := SIF_RANGE;
    ScrollInfo.nMin := 0;
    ScrollInfo.nMax := 0;
    Windows.SetScrollInfo(Control.Handle, fBarFlag, ScrollInfo, False);
    Control.Perform( WM_ELSCROLLBAR, ELSB_PAINT, fBarFlag);
  end;
end;

{$IFDEF LMD_UNICODE}
procedure TElSBHandlerCustom.SetHint(Value: TLMDString);

  var
    S :String;
   i, l  :Integer;
   T     :WideChar;
    begin
  fHint := Value;

  S := fHint;
  i := Length(S);
  l := Length(S) + 1 + Length(fHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;
  Move(fHint[1], S[i + 2], Length(fHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));
  // ???:
  Control.Hint := S;
  end;
{$ENDIF IFDEF LMD_UNICODE}

procedure TElSBHandlerCustom.DoThemeChanged;
begin
  Invalidate;
end;

function TElSBHandlerCustom.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

procedure TElSBHandlerCustom.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

procedure TElSBHandlerCustom.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

procedure TElSBHandlerCustom.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

function TElSBHandlerCustom.UseThemeMode: TLMDThemeMode;
begin
  if FThemeGlobalMode then
    result := LMDApplication.ThemeGlobalMode
  else
    result := FThemeMode;
  result := LMDThemeServices.UseTheme(result);
end;

{ TElSBController }

constructor TElSBController.Create(AOwner: TComponent);
begin
  inherited;
  FThemeMode := ttmPlatform;
  FThemeGlobalMode := False;
  CreateScrollHook;
  // Horizontal Scroll Bar:
  fHElSB  := GetElSBHandlerClass.Create(Self);
  fHElSB.fKind := sbHorizontal;
  fHElSB.fBarFlag := SB_HORZ;
  // Vertical Scroll Bar:
  fVElSB  := GetElSBHandlerClass.Create(Self);
  fVElSB.fKind := sbVertical;
  fVElSB.Width := fHElSB.Height;
  fVElSB.Height:= fHElSB.Width;
  fVElSB.fBarFlag := SB_VERT;
end;

procedure TElSBController.CreateScrollHook;
begin
  // Windows messages contoller:
  fElHook := TElHook.Create(nil);
  fElHook.OnBeforeProcess := HandleCtrlMsgBefore;
  fElHook.OnAfterProcess := HandleCtrlMsgAfter;
end;

function TElSBController.GetActive:Boolean;
begin
  Result := Assigned(Control) and SystemScrollBarHooked;
end;

procedure TElSBController.DestroyScrollHook;
begin
  if Assigned(fElHook) then
    FreeAndNil(fElHook);
end;

destructor TElSBController.Destroy;
begin
  FreeAndNil(fHElSB);
  FreeAndNil(fVElSB);
  DestroyScrollHook;
  inherited;
end;

procedure TElSBController.SetUseXPThemes(Value:Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
    DoThemeChanged;
  end;
end;

procedure TElSBController.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove)and(AComponent=Control) then
    Control := nil;
  inherited Notification(AComponent, Operation);
end; { Notification }

function TElSBController.IsThemed :Boolean;
begin
  result := UseThemeMode <> ttmNone;
{  // ElUxTheme.pas:
  Result := XPThemesAvailable and Assigned(Control);
  if Result then
  begin
    if not UseXPThemes then
      Result := GetWindowTheme(Control.Handle)<>0
    else
    begin
      // Force Theme for other controls
      Result := (Theme <> 0);
    end;
  end;}
end;

function TElSBController.GetControl: TWinControl;
begin
  if fElHook<>nil then
    Result := TWinControl(fElHook.Control)
  else
    Result := nil;
end;

function TElSBController.GetControlHandleAllocated:Boolean;
begin
  Result := Assigned(fElHook) and Assigned(fElHook.Control) and (TWinControl(fElHook.Control).HandleAllocated);
end;

function TElSBController.GetScrollBar(BarFlag: Integer): TElSBHandlerCustom;
begin
  if BarFlag = SB_HORZ then
    Result := fHElSB
  else
    Result := fVElSB;
end;

procedure TElSBController.SetControl(Value: TWinControl);

  procedure SyncScrollingWinCtrlScrollBar(CSB:TControlScrollBar; SBH: TElSBHandlerCustom);
  begin
    // Synchronize Scrolbars with TScrollingWinControl:
    SBH.fMin        := 0;
    SBH.fMax        := CSB.Range;
    SBH.fPosition   := CSB.Position;
    SBH.fVisible    := CSB.Visible
  end;

begin
  {IFDEF _SB_HOOKIMPEXP_}
  fSaveWMSetRedraw := wmsrTrue;
  {ENDIF IFDEF _SB_HOOKIMPEXP_}
  if FScrollControl <> Value then
  begin
    FScrollControl := Value;
    DestroyScrollHook;
    fVElSB.DestroyScrollTimer;
    fHElSB.DestroyScrollTimer;
//    fElHook.Active := False;
//    fVElSB.fScrollTimer.Enabled := False;
//    fHElSB.fScrollTimer.Enabled := False;
    // Release mouse capture:
    if fSaveCapture <> 0 then
    begin
      ReleaseCapture;
      SetCapture(fSaveCapture);
      fSaveCapture := 0;
    end;
    FWinCtrl := nil;
    if (fUpdateCount=0) and (Value=nil) and ControlHandleAllocated then // InitiateNCCalcSize:
      SetWindowPos(Control.Handle, 0,
      //Rect:
        //Control.Left, Control.Top, Control.Width, Control.Height,
        0, 0, 0, 0,
      //Flags:
        SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE or
        SWP_FRAMECHANGED or SWP_DRAWFRAME
      );

    if not SystemScrollBarHooked then
      exit;

    if Assigned(Value) then
    begin
      CreateScrollHook;
      fElHook.Control := FScrollControl;
      fHElSB.CreateScrollTimer;
      fVElSB.CreateScrollTimer;
      //VCL Controls
      if Value is TScrollingWinControl then
      begin
        FWinCtrl := TScrollingWinControl(Value);
        SyncScrollingWinCtrlScrollBar(FWinCtrl.HorzScrollBar, fHElSB);
        SyncScrollingWinCtrlScrollBar(FWinCtrl.VertScrollBar, fVElSB);
      end;
      if Control.HandleAllocated then
        SyncScrollInfos(SB_BOTH, False);
      UpdateSystemMetrics(False);
      fElHook.Active := True;
      if fUpdateCount>0 then
      begin
        if Value=nil then
          fUpdateCount := 0;
        exit;
      end;
      if Value=nil then
        fUpdateCount := 0;
      InitiateNCCalcSize;
      if Value.Visible and Value.HandleAllocated then
        RedrawWindow(Value.Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME or RDW_ALLCHILDREN);
    end;
  end;
end;

procedure TElSBController.SetScrollBarStyles(BarFlag: Integer; Value: TElSBHandlerCustom);
begin
  ScrollBar[BarFlag].Assign(Value);
end;

function TElSBController.GetScrollBarsTracking: TScrollBarTracking;
var
  bH, bV :Boolean;
begin
  bH := HorzScrollBarStyles.ScrollTracking;
  bV := VertScrollBarStyles.ScrollTracking;
  if bH and bV then
    Result := sbtrBoth
  else
  if bH then
    Result := sbtrHorizontal
  else
  if bV then
    Result := sbtrVertical
  else
    Result := sbtrNone;
end;

procedure TElSBController.SetScrollBarsTracking(Value: TScrollBarTracking);
begin
  if FScrollBarsTracking<>Value then
  begin
    FScrollBarsTracking := Value;
    case FScrollBarsTracking of
      sbtrNone:
        begin
          VertScrollBarStyles.ScrollTracking := False;
          HorzScrollBarStyles.ScrollTracking := False;
        end;
      sbtrHorizontal:
        begin
          VertScrollBarStyles.ScrollTracking := False;
          HorzScrollBarStyles.ScrollTracking := True;
        end;
      sbtrVertical:
        begin
          VertScrollBarStyles.ScrollTracking := True;
          HorzScrollBarStyles.ScrollTracking := False;
        end;
      sbtrBoth:
        begin
          VertScrollBarStyles.ScrollTracking := True;
          HorzScrollBarStyles.ScrollTracking := True;
        end;
    end;
  end;
end;

procedure TElSBController.SyncScrollInfos(BarFlag: Integer; bRedraw: Boolean);
begin
  if BarFlag = SB_HORZ then
    fHElSB.SyncScrollInfoFromSystem(bRedraw)
  else
  if BarFlag = SB_VERT then
    fVElSB.SyncScrollInfoFromSystem(bRedraw)
  else
  begin
    fHElSB.SyncScrollInfoFromSystem(bRedraw);
    fVElSB.SyncScrollInfoFromSystem(bRedraw);
  end;
end;

procedure TElSBController.PaintScrollBar(BarFlag: Integer);
  var
    BM      :TBitMap;
    SB      :TElSBHandlerCustom;
    vCanvas :TCanvas;
    wSize   :Integer;
    hSize   :Integer;
begin
  if BarFlag=SB_BOTH then
  begin
    PaintScrollBar(SB_HORZ);
    PaintScrollBar(SB_VERT);
    exit;
  end;

  if ((BarFlag=SB_HORZ)and(not ((GetWindowLong(Control.Handle, GWL_STYLE) and WS_HSCROLL)<>0)))
    or
    ((BarFlag=SB_VERT)and(not ((GetWindowLong(Control.Handle, GWL_STYLE) and WS_VSCROLL)<>0)))
  then
    exit;

  SB := ScrollBar[BarFlag];

  if not Control.HandleAllocated then
    exit;

  with SB do
  begin
    wSize := WidthRect(fScrollBarRect);
    hSize := HeightRect(fScrollBarRect);
    if (BarFlag=SB_HORZ)
       and // scrollbar completely is not located in the window
       (fScrollBarRect.Bottom > (HeightRect(Control.BoundsRect)-cyBottomEdge))
    then
    begin
      dec(hSize, fScrollBarRect.Bottom -
        (HeightRect(Control.BoundsRect)-cyBottomEdge+1) + cyBottomEdge - 1
      );
    end;
  end;
  if (wSize<=0) or (hSize<=0) then
    exit;

  vCanvas := TCanvas.Create;
  vCanvas.Handle := GetWindowDC(Control.Handle);

  try
    BM := nil;
    try
      with SB do
      begin
        BM := TBitMap.Create;
        BM.Width  := wSize;
        BM.Height := hSize;
        try
          // Paint to memory bitmap:
          SB.Paint(BM.Canvas);
          // debug:
          //BM.SaveToFile('ELSCROLLBAR-TMP.BMP');
          // Paint scrollbar bitmap image to window instead of system scrollbar:
          with fScrollBarRect do
            vCanvas.Draw(Left, Top, BM);
        except
          on e:exception do
          begin
            LMDDebug( PChar('ERROR: 1) PaintScrollBar ('+IntToStr(BarFlag)+'): '+e.Message) );
            end;
        end;
      end;
    finally
      ReleaseDC(Control.Handle, vCanvas.Handle);
      vCanvas.Handle := 0;
      vCanvas.Free;
      BM.Free;
    end;
  except
    on e:exception do
    begin
      LMDDebug( PChar('ERROR: 2) PaintScrollBar ('+IntToStr(BarFlag)+'): '+e.Message) );
      end;
  end;
end;

type
  TWinControlProtected = class(TWinControl)
  end;

function TElSBController.NCCalcSize(var Msg:TMessage):Boolean;
  var
    WinStyle, ExStyle  :Integer;
    fIsHSB, fIsVSB     :Boolean;
    fRightAlignedView  :Boolean;
    fPrevNCRect        :TRect;
    fNCRect            : PRect;
    begin
  Result := TWMNCCalcSize(Msg).CalcValidRects;
  if not Result then
    exit;
  with Control, TWMNCCalcSize(Msg).CalcSize_Params^ do
  begin
    WinStyle := GetWindowLong(Handle, GWL_STYLE);
    fIsHSB := (WinStyle and WS_HSCROLL)<>0;
    fIsVSB := (WinStyle and WS_VSCROLL)<>0;

    if not (fIsVSB or fIsHSB) then
    begin
      fVElSB.fScrollBarRect := Rect(-1,-1,-1,-1);
      fHElSB.fScrollBarRect := Rect(-1,-1,-1,-1);
      Result := False;
      exit;
    end;

    ExStyle := GetWindowLong(Handle, GWL_EXSTYLE);
    fRightAlignedView := fIsVSB and ( (ExStyle and WS_EX_LEFTSCROLLBAR)<>0 );

    if Msg.WParam = 0 then
      fPrevNCRect := PRect(Msg.LParam)^
      else
      fPrevNCRect := rgrc[0];
      // CALL OLD HANDLER without ScrollBars:
    fPreventStyleChange := True;
    try
      // HIDE SCROLLBAR STYLE:
      if fIsHSB or fIsVSB then
        SetWindowLong(Handle, GWL_STYLE, WinStyle and not(WS_VSCROLL or WS_HSCROLL));
      // call old handler:
      Msg.Result := Control.Perform(WM_NCCALCSIZE, Msg.WParam, Msg.LParam);
      // RESTORE SCROLLBAR STYLE:
      if fIsHSB or fIsVSB then
        SetWindowLong(Handle, GWL_STYLE, WinStyle);
    finally
      fPreventStyleChange := False;
    end;

    if Msg.WParam = 0 then
      fNCRect := PRect(Msg.LParam)
    else
      fNCRect := @rgrc[0];
    // calculate what the size of each window border is:
    cxLeftEdge   := fNCRect.Left - fPrevNCRect.Left;
    cxRightEdge  := fPrevNCRect.Right - fNCRect.Right;
    cyTopEdge    := fNCRect.Top - fPrevNCRect.Top;
    cyBottomEdge := fPrevNCRect.Bottom - fNCRect.Bottom;

 // NCCALCSIZE CLIENT RECT (remove ScrollBars):

    if fIsHSB then
    begin
      if HeightRect(fNCRect^) >= fHElSB.Depth then
        dec(fNCRect.Bottom, fHElSB.Depth)
      else
        fNCRect.Bottom := fNCRect.Top;
      fHElSB.fThumbPos := fHElSB.AdjustThumbPos;
    end;
    if fIsVSB then
    begin
      if WidthRect(fNCRect^) >= fVElSB.Depth then
      begin
        if not fRightAlignedView then
          dec(fNCRect.Right, fVElSB.Depth)
        else
          inc(fNCRect.Left,  fVElSB.Depth);
      end
      else
      begin
        if not fRightAlignedView then
          fNCRect.Right := fNCRect.Left
        else
          fNCRect.Left := fNCRect.Right;
      end;
      fVElSB.fThumbPos := fVElSB.AdjustThumbPos;
    end;

 // CALCULATE SCROLLBAR RECT (position):
    //HORIZONTAL CROLLBAR RECT:
    if fIsHSB then
    begin
      if fIsVSB and fRightAlignedView then
      begin
        fHElSB.fScrollBarRect.Left   := cxLeftEdge + fVElSB.Depth;
        fHElSB.fScrollBarRect.Right  := fVElSB.Depth + WidthRect(fNCRect^);
      end
      else
      begin
        fHElSB.fScrollBarRect.Left   := cxLeftEdge;
        fHElSB.fScrollBarRect.Right  := WidthRect(fNCRect^);
      end;
      //fHElSB.fScrollBarRect.Right  := fHElSB.fScrollBarRect.Left + WidthRect(fNCRect^)-cxLeftEdge;
      if (Control is TCustomForm) then
        inc(fHElSB.fScrollBarRect.Right, 2)
      else
      if (not TWinControlProtected(Control).Ctl3D) then
      dec(fHElSB.fScrollBarRect.Right);
      fHElSB.fScrollBarRect.Top := fNCRect.Bottom - fNCRect.Top + cyTopEdge;
      fHElSB.fScrollBarRect.Bottom := fHElSB.fScrollBarRect.Top + fHElSB.Depth-1{?};
      fHElSB.Width  := WidthRect(fHElSB.fScrollBarRect);
    end;
    //VERTICAL CROLLBAR RECT:
    if fIsVSB then
    begin
      if not fRightAlignedView then
      begin
        fVElSB.fScrollBarRect.Left := cxLeftEdge + (fNCRect.Right - fNCRect.Left);
        fVElSB.fScrollBarRect.Right := fVElSB.fScrollBarRect.Left + fVElSB.Depth-1{?};
      end
      else
      begin
        fVElSB.fScrollBarRect.Left := cxLeftEdge;
        fVElSB.fScrollBarRect.Right := fVElSB.fScrollBarRect.Left + fVElSB.Depth-1;
      end;
      fVElSB.fScrollBarRect.Top   := cyTopEdge;
      fVElSB.fScrollBarRect.Bottom  := fVElSB.fScrollBarRect.Top + (fNCRect.Bottom - fNCRect.Top) - 1;
      fVElSB.Height  := HeightRect(fVElSB.fScrollBarRect);
    end;
  end;//of: with Control, TWMNCCalcSize(Msg).CalcSize_Params^
end;

function TElSBController.NCPaint(var Msg: TMessage):Boolean;
  var
    WinStyle, ExStyle :Integer;
begin
  with Control do
  begin
    WinStyle := GetWindowLong(Handle, GWL_STYLE);
    Result := ((WinStyle and WS_HSCROLL)<>0)or((WinStyle and WS_VSCROLL)<>0);
    if not Result then
      exit;
    ExStyle := GetWindowLong(Handle, GWL_EXSTYLE);
//    NCPaintScrollBars(WinStyle, ExStyle);
    fPreventStyleChange := True;
    try
      SetWindowLong(Handle, GWL_STYLE, WinStyle and not(WS_VSCROLL or WS_HSCROLL));
      Msg.Result := Perform(WM_NCPAINT, Msg.WParam, Msg.LParam);
      SetWindowLong(Handle, GWL_STYLE, WinStyle);
    finally
      fPreventStyleChange := False;
    end;
    NCPaintScrollBars(WinStyle, ExStyle);
  end;//of: with Control
end;

function TElSBController.GetCrossScrollBarsRect:TRect;
begin
  if fHElSB.Visible and fVElSB.Visible then
  begin
    SetRect(Result, fVElSB.fScrollBarRect.Left, fHElSB.fScrollBarRect.Top,
                    fVElSB.fScrollBarRect.Right+1{?}, fHElSB.fScrollBarRect.Bottom+1{?} );
    if // scrollbar completely is not located in the window
      (fHElSB.fScrollBarRect.Bottom > (HeightRect(Control.BoundsRect)-cyBottomEdge))
    then
      dec(Result.Bottom, fHElSB.fScrollBarRect.Bottom -
        (HeightRect(Control.BoundsRect)-cyBottomEdge+1) + cyBottomEdge - 1
      );
  end
  else
    SetRect(Result, -1, -1,
                    -1, -1 );
end;

function TElSBController.DoShowScrollBar(wBar: Integer; bShow: BOOL): BOOL;
  var
    SBFlag :Integer;
begin
   if not ControlHandleAllocated then
   begin
     Result := False;
     exit;
   end;
   if(wBar = SB_HORZ ) or (wBar = SB_BOTH) then
   begin
     if bShow then
       SBFlag := WS_HSCROLL
     else
       SBFlag := not WS_HSCROLL
   end
   else
     SBFlag := 0;
   if(wBar = SB_VERT ) or (wBar = SB_BOTH) then
     if bShow then
       SBFlag := SBFlag or WS_VSCROLL
     else
       SBFlag := SBFlag or (not WS_VSCROLL);
   if (SBFlag<>0) then
     SetWindowLong(Control.Handle, GWL_STYLE, GetWindowLong(Control.Handle, GWL_STYLE) or SBFlag );
   Result := True;
end;

procedure TElSBController.BeginUpdate;
begin
  inc(fUpdateCount);
end;

procedure TElSBController.EndUpdate;
begin
  dec(fUpdateCount);
end;

type
  TCustomFormProtected = class(TCustomForm)
  end;

procedure TElSBController.NCPaintScrollBars(WinStyle, ExStyle:Integer);
  var
    DrawRect :TRect;
    DefDraw  :Boolean;
    vCanvas  :TCanvas;
    sbState  :DWORD; // or PartID
    LDetails: TThemedElementDetails;
    LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  with Control do
  begin
// PAINT CROSS SCROLLBARS AREA:
    LDetails.Element := teStatus;
    LDetails.Part := 3; //SP_GRIPPER
    if ((WinStyle and WS_HSCROLL)<>0)and((WinStyle and WS_VSCROLL)<>0) then
    begin
      DrawRect := GetCrossScrollBarsRect;
      sbState := DFCS_SCROLLSIZEGRIPRIGHT;
      if (ExStyle and WS_EX_LEFTSCROLLBAR)<>0 then
      begin
        inc(DrawRect.Right, 1);
        if (LThemeMode <> ttmNone) then
          LDetails.State := 2 //CBS_SCROLLSIZEGRIPRIGHT
        else
          sbState := DFCS_SCROLLSIZEGRIPRIGHT;
      end
      else
      begin
        if (LThemeMode <> ttmNone) then
          LDetails.State := 1 //CBS_SCROLLSIZEGRIP
        else
          sbState := DFCS_SCROLLSIZEGRIP;
      end;

      DefDraw := True;
      vCanvas := TCanvas.Create;
      try
        vCanvas.Handle := GetWindowDC(Handle);
        vCanvas.Brush.Color := clBtnFace;
        vCanvas.Pen.Color := clBtnFace;
        if Assigned(fOnPaintCrossScrollBarsArea) then
          fOnPaintCrossScrollBarsArea( Control, vCanvas, DrawRect, DefDraw);
        if DefDraw then
        begin
          if (not (Control is TCustomForm))
             or
             ( not (TCustomFormProtected(Control).BorderStyle in [bsSizeable, bsSizeToolWin]) )
          then
          begin
            if (LThemeMode <> ttmNone) then
              FillRect(vCanvas.Handle, DrawRect, HBRUSH(LMDThemeServices.GetThemeSysColor(UseThemeMode, teScrollBar, clBtnFace) + 1))
            else
              //<abb 2014>
              if sbState = DFCS_SCROLLSIZEGRIP then
                DrawFrameControl(vCanvas.Handle, DrawRect, DFC_SCROLL, sbState)
              else
                Windows.DrawEdge(vCanvas.Handle, DrawRect, EDGE_SUNKEN, BF_MIDDLE);
              //<//abb 2014>
          end
          else
          begin
            if LThemeMode <> ttmNone then
            begin
              FillRect(vCanvas.Handle, DrawRect, HBRUSH(LMDThemeServices.GetThemeSysColor(UseThemeMode, teScrollBar, clBtnFace) + 1));
              LMDThemeServices.DrawElement(LThemeMode, vCanvas.Handle, LDetails, DrawRect);
            end
            else
              DrawFrameControl(vCanvas.Handle, DrawRect, DFC_SCROLL, sbState);
          end;
        end;
      finally
        ReleaseDC(Handle, vCanvas.Handle);
        vCanvas.Handle := 0;
        vCanvas.Free;
      end;
    end;
// PAINT SCROLLBARS:
    // Override drawing Horizontal Scrollbar:
    if (WinStyle and WS_HSCROLL)<>0 then
      Control.Perform( WM_ELSCROLLBAR, ELSB_PAINT, SB_HORZ);
    // Override drawing Vertical Scrollbar:
    if (WinStyle and WS_VSCROLL)<>0 then
      Control.Perform( WM_ELSCROLLBAR, ELSB_PAINT, SB_VERT);
  end;//of: with Control
end;

function TElSBController.NCActivate(var Msg:TMessage):Boolean;
  var
    WinStyle, ExStyle :Integer;
begin
  with Control do
  begin
    WinStyle := GetWindowLong(Handle, GWL_STYLE);
    Result := ((WinStyle and WS_HSCROLL)<>0)or((WinStyle and WS_VSCROLL)<>0);
    if not Result then
      exit;
    ExStyle := GetWindowLong(Handle, GWL_EXSTYLE);
    fPreventStyleChange := True;
    try
      // HIDE SCROLLBAR STYLE
      SetWindowLong(Handle, GWL_STYLE, WinStyle and not(WS_VSCROLL or WS_HSCROLL));
      Msg.Result := Perform(WM_NCACTIVATE, Msg.WParam, Msg.LParam);
      // RESTORE SCROLLBAR STYLE
      SetWindowLong(Handle, GWL_STYLE, WinStyle);
    finally
      fPreventStyleChange := False;
    end;
    NCPaintScrollBars(WinStyle, ExStyle);
    //???
    //SetCaptureMouse(True);
  end;//of: with Control
end;

procedure TElSBController.SetCaptureMouse(bGrab:Boolean);
begin
  if bGrab then
  begin
    if GetCapture <> Control.Handle then
    begin
      fSaveCapture := GetCapture;
      ReleaseCapture;
      SetCapture(Control.Handle);
    end;
    end
  else
  begin
    if (GetCapture = Control.Handle)or(fSaveCapture<>0) then
    begin
      ReleaseCapture;
      fSaveCapture := 0;
    end;
    end;
end;

procedure TElSBController.WMCancelMode(var Msg: TWMCancelMode);
  var
    WinStyle :Integer;
begin
  SetCaptureMouse(False);
  WinStyle := GetWindowLong(Control.Handle, GWL_STYLE);
  if ((WinStyle and WS_HSCROLL)<>0) and
     ( fHElSB.Pressed or fHElSB.Tracking )
  then
  begin
    if fHElSB.MouseInControl then
      fHElSB.IntMouseLeave(False);
    fHElSB.IntMouseButton(False, mbLeft, -1, -1);
  end;
  if ((WinStyle and WS_VSCROLL)<>0) and
     ( fVElSB.Pressed or fVElSB.Tracking )
  then
  begin
    if fVElSB.MouseInControl then
      fVElSB.IntMouseLeave(False);
    fVElSB.IntMouseButton(False, mbLeft, -1, -1);
  end;
end;

(*
{$IFDEF MONITORING_MESSAGES}
const
  c_array_filter :array[0..22{30{}]of integer =
  (WM_NCHITTEST, WM_SETCURSOR, WM_MOUSEMOVE, LB_GETTOPINDEX, CM_MOUSEENTER,
   WM_NCMOUSEMOVE, CM_MOUSELEAVE, WM_NCMOUSELEAVE, CM_DIALOGKEY, CM_DIALOGCHAR,
   WM_MOUSEACTIVATE, WM_NCLBUTTONDOWN, CN_CTLCOLORLISTBOX, WM_LBUTTONUP,
   WM_CAPTURECHANGED,WM_NCLBUTTONDBLCLK, CN_DRAWITEM, CM_CANCELMODE, WM_KILLFOCUS,
   CN_COMMAND, WM_DESTROY, WM_NCDESTROY, WM_CTLCOLORSTATIC{,
   WM_IME_SETCONTEXT, WM_IME_NOTIFY,
   WM_ERASEBKGND, WM_PAINT, WM_CAPTURECHANGED, WM_MOUSEACTIVATE, CM_INVALIDATE,
   WM_NCPAINT{}
   );
function not_in_filter(msg:integer):boolean;
var i:integer;
begin
  for i:=0 to High(c_array_filter) do
    if c_array_filter[i]=msg then
    begin
      Result := False;
      exit;
    end;{}
  Result := True;
end;
{$ENDIF}
*)

procedure TElSBController.HandleCtrlMsgBefore(Sender: TObject;
  var Msg: TMessage; var Handled: Boolean);

begin
try
  if (not SystemScrollBarHooked) or (fUpdateCount<>0) then
    exit;
  (*{$IFDEF MONITORING_MESSAGES}
  if (bMonitorMessage) and (not fPreventStyleChange) and not_in_filter(Msg.Msg) then
  begin
    if Msg.Msg <> WM_ELSCROLLBAR then
      LMDDebug('BEFORE: '+MessageToStr(Msg.Msg)+', wParam='+IntToStr(Msg.wParam)+', lParam='+IntToStr(Msg.lParam))
    else
    if Msg.WParam = ELSB_GETCONTROLLER then
      LMDDebug( 'BEFORE: WM_ELSCROLLBAR, ELSB_GETCONTROLLER' )
    else
    if Msg.WParam = ELSB_PAINT then
    begin
      case Msg.LParam of
        SB_HORZ : LMDDebug( 'BEFORE: WM_ELSCROLLBAR [ ELSB_PAINT, SB_HORZ ]' );
        SB_VERT : LMDDebug( 'BEFORE: WM_ELSCROLLBAR [ ELSB_PAINT, SB_VERT ]' );
        else      LMDDebug( 'BEFORE: WM_ELSCROLLBAR [ ELSB_PAINT, SB_BOTH ]' );
      end
    end
    else
    if Msg.WParam = ELSB_SYNCSI then
      LMDDebug( 'BEFORE: WM_ELSCROLLBAR, ELSB_SYNCSI' );
  end;
  {$ENDIF} *)

  if Msg.Msg = WM_ELSCROLLBAR then
  begin
   Handled := True;
   try
   case Msg.WParam of
     ELSB_GETCONTROLLER:  // check of window to override system scrollbar paint
       begin
         Msg.Result := DWord(Self);
         if Msg.lParam<>0 then
           PInteger(Msg.lParam)^ := Msg.Result
         else
           Msg.Result := 0;
       end;
     ELSB_PAINT:          // Paint SCROLLBAR. LPARAM contain (SB_HORZ, SB_VERT)
       begin
         if Msg.LParam in [SB_HORZ, SB_VERT] then
           PaintScrollBar(Msg.LParam)
         else // SB_BOTH
           PaintScrollBar(SB_BOTH);
       end;
     ELSB_SYNCSI:
       if Msg.LParam<>0 then with PELSBSyncScrollInfo(Msg.LParam)^ do if Assigned(pSI) then
       begin
         SyncScrollInfo(BarFlag, pSI^, bRedraw);
       end;
   end;//of: case Msg.WParam of
   except
   end;
  end//of: if Msg.Msg = WM_ELSCROLLBAR

  else
// HOOKED SYSTEM MESSAGES:
  case Msg.Msg of
    WM_NCCALCSIZE:
      begin
         if not fPreventStyleChange then
         begin
           Handled := NCCalcSize(Msg);
         end;
      end;
    WM_NCPAINT:
      begin
         if not fPreventStyleChange then
           Handled := NCPaint(Msg);
      end;
    WM_NCACTIVATE:
      begin
        // scrollbar is painted for forms therefore we intercept
         if not fPreventStyleChange then
           Handled := NCActivate(Msg);
      end;
    //WM_WINDOWPOSCHANGED,
    WM_STYLECHANGING,
    WM_STYLECHANGED:
      begin
        if fPreventStyleChange then
          Handled := True;
      end;
    WM_NCHITTEST:
      begin
        Handled := WMNCHitTest(TWMNCHitTest(Msg));
      end;
     WM_NCLBUTTONDOWN
    ,WM_NCLBUTTONUP {not always occur, this is why WM_LBUTTONUP is needed}
    ,WM_LBUTTONUP
    ,WM_NCLBUTTONDBLCLK
    ,WM_NCMOUSEMOVE
    ,WM_NCMOUSELEAVE
    ,WM_MOUSEMOVE
    ,WM_MOUSELEAVE
    ,CM_MOUSELEAVE
    ,CM_EXIT:
       Handled := MouseEventHandler(Msg);
     WM_CANCELMODE:
       WMCancelMode(TWMCancelMode(Msg));
     //???:
     {WM_ACTIVATE:
       if Msg.WParam=WA_INACTIVE then
          begin
            //MouseEventHandler(Msg);
            SetCaptureMouse(True);
          end;{}
    {WM_CHANGEUISTATE:
      if Msg.WParam=UISF_HIDEFOCUS then
      begin
        ShowMessage('WM_CHANGEUISTATE(UISF_HIDEFOCUS)');
        fHElSB.IntMouseButton(False, mbLeft, -1, -1);
      end;{}
     WM_NCRBUTTONDOWN
    ,WM_NCRBUTTONUP
    ,WM_NCRBUTTONDBLCLK
    ,WM_NCMBUTTONDOWN
    ,WM_NCMBUTTONUP
    ,WM_NCMBUTTONDBLCLK:
       Handled := SBFilterMouseEventHandler(Msg);
    //WM_MOUSEHOVER
    //WM_NCMOUSEHOVER
    WM_MOUSEWHEEL:
      begin
        if EmulateMouseWhell then
        begin
          Handled := True;
          if fVElSB.Visible then
            fVElSB.WMMouseWheel(Msg);
        end;
      end;
    {IFDEF _SB_HOOKIMPEXP_}
    WM_SETREDRAW:
      if IsHookImpExp then
      begin
        if (LongBool(TWMSetRedraw(Msg).Redraw)=True) then
        begin
          if fSaveWMSetRedraw = wmsrFalseNeddRestore then
          begin
            // do not allow WM_SETREDRAW to True when in scrolling is processing
            Msg.Result :=0;
            Handled := True;
          end
          else
          fSaveWMSetRedraw := wmsrTrue;
        end
        else
          fSaveWMSetRedraw := wmsrFalse;
      end;
    WM_HSCROLL, WM_VSCROLL:
      if IsHookImpExp then
      begin
        if Control.Visible and (TWMScroll(Msg).ScrollCode in [SB_LINEUP..SB_RIGHT]) then
        begin
          if fSaveWMSetRedraw = wmsrTrue then
          begin
            Control.Perform(WM_SETREDRAW, 0, 0);
            fSaveWMSetRedraw := wmsrFalseNeddRestore;
          end
          else
          begin
            Control.Perform(WM_SETREDRAW, 0, 0);
          end;
          if Msg.Msg = WM_VSCROLL then
            fVSavePos := fVElSB.Position
          else
            fHSavePos := fHElSB.Position;
        end;

      end;
    WM_KEYDOWN:
      if IsHookImpExp then
      begin
        if fVElSB.Visible then
          fVSavePos := fVElSB.Position;
        if fHElSB.Visible then
          fHSavePos := fHElSB.Position;
      end;
    {ENDIF IFDEF _SB_HOOKIMPEXP_}
    (*
    WM_HSCROLL:
      begin // paint when Tracking
        if (fHElSB.Position = TWMScroll(Msg).Pos) and
           ( (TWMScroll(Msg).ScrollCode = SB_THUMBTRACK) or
             (TWMScroll(Msg).ScrollCode = SB_THUMBPOSITION)
           )
          then // skip duplicated messages
            Handled := True;
        {
        // paint when Tracking
        {if (TWMScroll(Msg).ScrollCode = SB_THUMBTRACK) and
           (not IsScrollingWinControl) and
           (fHElSB.Visible) and (fHElSB.fScrollTracking)
        then
          fHElSB.Position := TWMScroll(Msg).Pos;{}
        }
      end;
    WM_VSCROLL:
      begin // paint when Tracking
        if (fVElSB.Position = TWMScroll(Msg).Pos) and
           ( (TWMScroll(Msg).ScrollCode = SB_THUMBTRACK) or
             (TWMScroll(Msg).ScrollCode = SB_THUMBPOSITION)
           )
          then // skip duplicated messages
            Handled := True;
        // paint when Tracking
        //{if (TWMScroll(Msg).ScrollCode = SB_THUMBTRACK) and
        //   (not IsScrollingWinControl) and
        //   (fVElSB.Visible) and (fVElSB.fScrollTracking)
        //then
        //  fVElSB.Position := TWMScroll(Msg).Pos;{}
      end;
    //*)
    WM_THEMECHANGED:  //EL_THEMECHANGED
     ;
    //WM_SETTINGCHANGE,
    CM_WININICHANGE:
      begin
        if (Msg.wParam=SPI_SETNONCLIENTMETRICS) then
        begin
          UpdateSystemMetrics(False);
          InitiateNCCalcSize;
          RedrawWindow(Control.Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME or RDW_ALLCHILDREN);
        end;
        //if Msg.Msg = WM_SETTINGCHANGE then
        //  Msg.Result := 0;
      end;
  end;//of: case Msg.Msg
except
  on e:exception do
  begin
    LMDDebug( PChar('ERROR: TElSBController.HandleCtrlMsgBefore( Message='+IntToStr(Msg.Msg)+'): '+e.Message) );
  end;
end;
end;

procedure TElSBController.HandleCtrlMsgAfter(Sender: TObject; var Msg: TMessage; var Handled: Boolean);

  {IFDEF _SB_HOOKIMPEXP_}
  procedure InvalidateChildren(C:TWinControl; bNCPaint: Boolean);
  var
    i: Integer;
  begin
    //LMDDebug(Control.Name+':InvalidateChildren');
    C.Invalidate;
    if bNCPaint then
      C.Perform(WM_NCPAINT, 1, 0);
    for i := 0 to C.ControlCount -1 do
    begin
      if (C.Controls[i] is TWinControl) and C.Controls[i].Visible then
        InvalidateChildren( TWinControl(C.Controls[i]), True );
    end;
  end;
  //  var
  //    WinStyle: Integer;
  {ENDIF IFDEF _SB_HOOKIMPEXP_}
begin
try
  if (not SystemScrollBarHooked) or (fUpdateCount<>0) then
    exit;
  (*
  {$IFDEF MONITORING_MESSAGES}
  if (bMonitorMessage) and (not fPreventStyleChange) and not_in_filter(Msg.Msg) and
     (Msg.Msg <> WM_ELSCROLLBAR) then
    LMDDebug('AFTER:  '+MessageToStr(Msg.Msg)+', wParam='+IntToStr(Msg.wParam)+', lParam='+IntToStr(Msg.lParam));
  {$ENDIF}
  *)

  case Msg.Msg of
    {???Form:
    WM_SYSCOMMAND:
      begin
        if TWMSysCommand(Msg).CmdType and $FFF0 = SC_RESTORE then
          InitiateNCCalcSize;
      end;{}
    WM_SIZE:
      begin
        if (Msg.WParam=SIZE_RESTORED) and Control.Visible then
          InitiateNCCalcSize;
    {Somehow length of the scrollbar doesn't match current window size,
     (looks like microsoft forgot to query NC_CalcSize).
          todo:
          ??? Have to replace by recalc of fScrollBarRect by length - will twinkle less}
      end;
    WM_WINDOWPOSCHANGED,
    WM_ENABLE:
      begin
        if Control.Visible then
          Control.Perform( WM_ELSCROLLBAR, ELSB_PAINT, SB_BOTH);
      end;
    {IFDEF _SB_HOOKIMPEXP_}
    WM_KEYDOWN:
      if IsHookImpExp then
      begin
  {
          Under WinXP - srcollbar twinkles.
          Under Wi98 VMWare - scrollbar doesn't twinkle !!!
        }
        if fVElSB.Visible and (fVElSB.fPosition <>GetScrollbarPos(Control.Handle, SB_VERT)) then
          fVElSB.SyncScrollInfoFromSystem(Control.Visible and
            (fSaveWMSetRedraw <> wmsrFalse) and (fSaveWMSetRedraw <> wmsrFalseNeddRestore){});
        if fHElSB.Visible and (fHElSB.fPosition <>GetScrollbarPos(Control.Handle, SB_HORZ)) then
          fHElSB.SyncScrollInfoFromSystem(Control.Visible and
            (fSaveWMSetRedraw <> wmsrFalse) and (fSaveWMSetRedraw <> wmsrFalseNeddRestore){});
      end;
    {ENDIF IFDEF _SB_HOOKIMPEXP_}
    WM_SETREDRAW:
      begin
        if (LongBool(TWMSetRedraw(Msg).Redraw)=True) and Control.Visible then
        begin
          if fVElSB.Visible then
            fVElSB.SyncScrollInfoFromSystem( (not (Control is TElXPThemedControl)){} );
          if fHElSB.Visible then
            fHElSB.SyncScrollInfoFromSystem( (not (Control is TElXPThemedControl)){} );
        end;
      end;
    {IFDEF _SB_HOOKIMPEXP_}
    WM_HSCROLL, WM_VSCROLL:
      if IsHookImpExp then
      begin
        if Control.Visible and (TWMScroll(Msg).ScrollCode in [SB_LINEUP..SB_RIGHT]) then
        begin
          if fSaveWMSetRedraw = wmsrFalseNeddRestore then
          begin
            // of no use
            //with fHElSB.fScrollBarRect do
            //  ExcludeClipRect(Control.Handle, Left, Top, Right, Bottom);

            {
            // unfortunately TElScrollBox doesn't work this way
            WinStyle := GetWindowLong(Control.Handle, GWL_STYLE);
            fPreventStyleChange := True;
            try
              // HIDE SCROLLBAR STYLE:
              SetWindowLong(Control.Handle, GWL_STYLE, WinStyle and not(WS_VSCROLL or WS_HSCROLL));

              fSaveWMSetRedraw := wmsrFalse;
              Control.Perform(WM_SETREDRAW, 1, 0);

              // RESTORE SCROLLBAR STYLE:
              SetWindowLong(Control.Handle, GWL_STYLE, WinStyle);
            finally
              fPreventStyleChange := False;

              if (Msg.Msg = WM_VSCROLL)and(fVSavePos <> fVElSB.Position) then
                Control.Perform( WM_ELSCROLLBAR, ELSB_PAINT, SB_VERT)
              else
              if (Msg.Msg = WM_HSCROLL)and(fHSavePos <> fHElSB.Position)
              then
                Control.Perform( WM_ELSCROLLBAR, ELSB_PAINT, SB_HORZ);
            end;
            {}

            fSaveWMSetRedraw := wmsrFalse;
            Control.Perform(WM_SETREDRAW, 1, 0);

            if ( (Msg.Msg = WM_VSCROLL)and(fVSavePos <> fVElSB.Position) )
               or
               ( (Msg.Msg = WM_HSCROLL)and(fHSavePos <> fHElSB.Position) )
            then
            begin
              InvalidateChildren(Control, False);
              {
              Control.Invalidate;
              //RedrawWindow(Control.Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE);
              RedrawWindow(Control.Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME or RDW_ALLCHILDREN);
              {}
            end;
          end;
        end;
      end;
    {ENDIF IFDEF _SB_HOOKIMPEXP_}
  end;
except
  on e:exception do
  begin
    LMDDebug( PChar('ERROR: TElSBController.HandleCtrlMsgAfter( Message='+IntToStr(Msg.Msg)+'): '+e.Message) );
  end;
end;
end;

function TElSBController.SBFilterMouseEventHandler(var Msg: TMessage):Boolean;
begin
  {
   todo:
     filter only scrollbar area
  with TWMNCRButtonDown(Msg) do
    vP := Control.ScreenToClient(Point(XCursor, YCursor))
  }
  Result := False; // - not filtered
end;

function TElSBController.MouseEventHandler(var Msg: TMessage): Boolean;

  var
    WinStyle       :Integer;
    fIsHSB, fIsVSB :Boolean;
    fInHSB, fInVSB :Boolean;
//    fInCrossSB     :Boolean; //???
    SRH, SRV       :TRect;
    hP, vP         :TPoint;
begin
  Result := False;
  //**************
  with Control do
  begin
    WinStyle := GetWindowLong(Handle, GWL_STYLE);
    fIsHSB := (WinStyle and WS_HSCROLL)<>0;
    fIsVSB := (WinStyle and WS_VSCROLL)<>0;
    if (not fIsHSB) and (not fIsVSB) then
      exit;
    if (Msg.Msg = WM_MOUSELEAVE) or
       (Msg.Msg = CM_MOUSELEAVE) or
       (Msg.Msg = CM_EXIT) or
       (Msg.Msg = WM_NCMOUSELEAVE)
    then
    begin
      if fIsHSB then
      begin
        fHElSB.IntMouseLeave(True);
      end;
      if fIsVSB then
      begin
        fVElSB.IntMouseLeave(True);
      end;
    end
    else // handle only left button mouse messages:
    begin
      //  Handle the next messages:
      //
      //    WM_NCLBUTTONDOWN,
      //    WM_NCLBUTTONDBLCLK
      //
      //    WM_NCLBUTTONUP
      //    WM_LBUTTONUP
      //
      //    WM_NCMOUSEMOVE
      //    WM_MOUSEMOVE

      // CONVERT COORDINATES

        // Screen cursor to client window:
        // common (screen cursor to client window):
        if Msg.Msg <> WM_MOUSEMOVE then
          with TWMNCLButtonDown(Msg) do
            hP := Control.ScreenToClient(Point(XCursor, YCursor))
        else
          with TWMNCLButtonDown(Msg) do
            hP := Point(XCursor, YCursor);
        inc(hP.Y, cyTopEdge);
        inc(hP.X, cxLeftEdge);
        if fIsVSB and ((GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_LEFTSCROLLBAR)<>0) then
          inc(hP.X, fVElSB.Depth);
        vP := hP;
        // horizontal:
        if fIsHSB then
        begin
          SRH := fHElSB.fScrollBarRect;
          fInHSB := LMDPointInRect(hP, SRH) // check up an accessory vP of area SB:
            and // scrollbar completely is not located in the window
            (hP.Y < (HeightRect(Control.BoundsRect)-cyBottomEdge));
        end
        else
        begin
          fInHSB := False;
        end;
        //vertical:
        if fIsVSB then
        begin
          if not fInHSB then
          begin
            SRV := fVElSB.fScrollBarRect;
            fInVSB := LMDPointInRect(vP, SRV);
          end
          else
          begin
            fInVSB := False;
          end;
        end
        else
        begin
          fInVSB := False;
        end;

        //fInCrossSB := (not fInHSB) and (not fInVSB) and
        //  LMDPointInRect(vP, GetCrossScrollBarsRect);

      // filtered captured messages ... :
      Result :=
      //**************
         ( fIsVSB and (fInVSB or fVElSB.fTracking or fVElSB.fPressed) )
         or
         ( fIsHSB and (fInHSB or fHElSB.fTracking or fHElSB.fPressed) );

      // ******************
      // **  HORIZONTAL  **
      // ******************
      if fIsHSB then
      begin
        if fInHSB and fIsVSB and (fVElSB.fPressed or fVElSB.fTracking) then
          fInHSB := False;

        if fInHSB then
        begin
          // map vP to horizontal client SCROLLBAR:
          dec(hP.X, SRH.Left);
          dec(hP.Y, SRH.Top);
          if not fHElSB.MouseInControl then
            fHElSB.IntMouseEnter(False);
          case Msg.Msg of
            WM_NCLBUTTONDOWN, WM_NCLBUTTONDBLCLK:
              begin
                //???
                //if (not Control.Focused) and Control.Visible and IsWindowEnabled(Handle) then
                //  Control.SetFocus;
                fHElSB.IntMouseButton(True, mbLeft, hP.X, hP.Y);
              end;
            WM_NCLBUTTONUP, WM_LBUTTONUP:
              fHElSB.IntMouseButton(False, mbLeft, hP.X, hP.Y);
            WM_NCMOUSEMOVE, WM_MOUSEMOVE:
              fHElSB.IntMouseMove(hP.X, hP.Y);
          end;
        end
        else  // mouse not in ScrollBar Area
        begin
          case Msg.Msg of
              WM_NCMOUSEMOVE, WM_MOUSEMOVE:
                begin
                  if fHElSB.MouseInControl then
                    fHElSB.IntMouseLeave(False);
                  fHElSB.IntMouseMove(hP.X, hP.Y); { if outcommented then scrolling is ingored }
                                                   { out of scroll area. good as a variant     }
                end;
              WM_NCLBUTTONUP, WM_LBUTTONUP:
                begin
                  if fHElSB.MouseInControl then
                    fHElSB.IntMouseLeave(False);
                  fHElSB.IntMouseButton(False, mbLeft, hP.X, hP.Y);
                end;
              WM_NCLBUTTONDOWN, WM_NCLBUTTONDBLCLK:
                begin
                  if fHElSB.MouseInControl then
                    fHElSB.IntMouseLeave(False);
                  if fHElSB.Tracking then
                    fHElSB.IntMouseButton(True, mbLeft, -1, -1);
                  if not fInVSB then
                    Result := False;
                end;
          end;//of: case  Msg.Msg
        end;//of: if Point in SB Rect
      end;//of: if Horizontal
      // ****************
      // **  VERTICAL  **
      // ****************
      if fIsVSB then
      begin
        if fInVSB and fIsHSB and (fHElSB.fPressed or fHElSB.fTracking) then
          fInVSB := False;

        if fInVSB then
        begin
          // map vP to vertival client SCROLLBAR:
          dec(vP.X, SRV.Left);
          dec(vP.Y, SRV.Top);
          if not fVElSB.MouseInControl then
            fVElSB.IntMouseEnter(False);
          case Msg.Msg of
            WM_NCLBUTTONDOWN, WM_NCLBUTTONDBLCLK:
              begin
                //???
                //if (Windows.GetFocus<>Control.Handle) and isWindowVisible(Control.Handle) and IsWindowEnabled(Control.Handle) then
                //  Windows.SetFocus(Control.Handle);
                fVElSB.IntMouseButton(True, mbLeft, vP.X, vP.Y);
              end;
            WM_NCLBUTTONUP, WM_LBUTTONUP:
              fVElSB.IntMouseButton(False, mbLeft, vP.X, vP.Y);
            WM_NCMOUSEMOVE, WM_MOUSEMOVE:
              fVElSB.IntMouseMove(vP.X, vP.Y);
          end;//of: case Msg.Msg
        end//of: Point in SB Rect
        else// if Point not in SB Rect:
        begin
          case Msg.Msg of
              WM_NCMOUSEMOVE, WM_MOUSEMOVE:
                begin
                  if fVElSB.MouseInControl then
                    fVElSB.IntMouseLeave(False);
                  fVElSB.IntMouseMove(vP.X, vP.Y);  { if outcommented then scrolling is ingored }
                                                    { out of scroll area. good as a variant }
                end;
              WM_NCLBUTTONUP, WM_LBUTTONUP:
                begin
                  fVElSB.IntMouseButton(False, mbLeft, vP.X, vP.Y);
                  if fVElSB.MouseInControl then
                    fVElSB.IntMouseLeave(False);
                end;
              WM_NCLBUTTONDOWN, WM_NCLBUTTONDBLCLK:
                begin
                  if fVElSB.Tracking then
                    fVElSB.IntMouseButton(True, mbLeft, vP.X, vP.Y);
                  if fVElSB.MouseInControl then
                    fVElSB.IntMouseLeave(False);
                end;
          end;//of: case Msg.Msg
        end;//of: if Point in SB Rect
      end;//of: if Vertical

      {
      if fInCrossSB and (
        (Msg.Msg = WM_NCLBUTTONDOWN) or
        (Msg.Msg = WM_NCLBUTTONDBLCLK) or
        (Msg.Msg = WM_NCLBUTTONUP) or
        (Msg.Msg = WM_LBUTTONUP)
      )
      then
      begin
        if (not Control.Focused) and IsWindowEnabled(Handle) then
          Control.SetFocus;
      end
      else{}

      // Allow handle WM_NCMOUSEMOSE
      if Result and (Msg.Msg = WM_NCMOUSEMOVE) then
      begin
        with TWMNCLButtonDown(Msg) do
        begin
          XCursor := -1;
          YCursor := -1;
        end;
        Result := False;
      end;

    end;//of: if Msg.Msg =
  end;//of: with Control
end; //of: TElSBController.MouseEventHandler

function TElSBController.InternalHitTest(X: integer; Y: integer): integer;
  var
    vP :TPoint;
    fIsHSB, fIsVSB :Boolean;
    ExStyle: Integer;
    bRightAlignedView: Boolean;
    R: TRect;
begin
  Result := HTNOWHERE;
  fIsHSB := fHElSB.Visible;
  fIsVSB := fVElSB.Visible;
  if not (fIsHSB or fIsVSB) then
    exit;

  vP := Control.ScreenToClient( Point(X, Y) );
  inc(vP.Y, cyTopEdge);
  inc(vP.X, cxLeftEdge);

  ExStyle := GetWindowLong(Control.Handle, GWL_EXSTYLE);
  bRightAlignedView := fIsVSB and ( (ExStyle and WS_EX_LEFTSCROLLBAR)<>0 );

  if bRightAlignedView then
    inc(vP.X, fVElSB.Depth);

//HORIZONTAL:
  if fIsHSB then
  begin
    if LMDPointInRect(vP, fHElSB.fScrollBarRect)
      and // scrollbar completely is not located in the window
      (vP.Y < (HeightRect(Control.BoundsRect)-cyBottomEdge))
    then
    begin
      Result := HTHSCROLL;
      exit;
    end;
  end;

//VERTICAL:
  if fIsVSB then
  begin
    if LMDPointInRect(vP, fVElSB.fScrollBarRect) then
    begin
      Result := HTVSCROLL;
      exit;
    end;
  end;
//CROSS SB AREA (GRIPPER):
//{
  if (fIsHSB and fIsVSB)
     and (Control is TCustomForm)
     and ( TCustomFormProtected(Control).BorderStyle in [bsSizeable, bsSizeToolWin])
  then
  begin
    R := GetCrossScrollBarsRect;
    if not bRightAlignedView then
    begin
      //inc(R.Right, cxRightEdge);
      //inc(R.Bottom, cyBottomEdge);
      inc(R.Top, 1);
      inc(R.Left, 1);
    end
    else
    begin
      //dec(R.Left, cxLeftEdge);
      //inc(R.Bottom, cyBottomEdge);
      inc(R.Top, 1);
      dec(R.Right, 1);
    end;
    if LMDPointInRect( vP, R) then
    begin
      if not bRightAlignedView then
        Result := HTBOTTOMRIGHT
      else
        Result := HTBOTTOMLEFT;
      exit;
    end;
  end;
{}
end;

function TElSBController.WMNCHitTest(var Msg :TWMNCHitTest):Boolean;
  var
    fIsHSB, fIsVSB :Boolean;
begin
  Result := False;

  fIsHSB := fHElSB.Visible;
  fIsVSB := fVElSB.Visible;
  if not (fIsHSB or fIsVSB) then
    exit;

  Msg.Result := InternalHitTest(Msg.XPos, Msg.YPos);
  if Msg.Result = HTHSCROLL then // HORIZONTAL
      begin
        Result := True;
        if fIsVSB and fVElSB.MouseInControl then
        begin
          fVElSB.IntMouseMove(-1, -1);
          fVElSB.IntMouseLeave(False);
        end;
      end
    else if Msg.Result = HTVSCROLL then
      begin
        Result := True;
        if fIsHSB and fHElSB.MouseInControl then
        begin
          fHElSB.IntMouseMove(-1, -1);
          fHElSB.IntMouseLeave(False);
        end;
      end
    else
    begin
      //if (Msg.Result in [HTBOTTOMLEFT, HTBOTTOMRIGHT]) then
      //  Result := True
      //else
        Msg.Result := HTNOWHERE;
      if fIsVSB and fVElSB.MouseInControl then
      begin
        fVElSB.IntMouseMove(-1, -1);
        fVElSB.IntMouseLeave(False);
      end;
      if fIsHSB and fHElSB.MouseInControl then
      begin
        fHElSB.IntMouseMove(-1, -1);
        fHElSB.IntMouseLeave(False);
      end;
    end;
end; //of: TElSBController.WMNCHitTest

{IFDEF _SB_HOOKIMPEXP_}
function GetScrollBarPos( hWnd: THandle; BarFlag:Integer; var Pos:Integer ):Boolean;
var
  SI: TScrollInfo;
begin
  SI.cbSize := SizeOf(SI);
  SI.fMask := SIF_POS;
  if GetScrollInfo(hWnd, BarFlag, SI) then
  begin
    Pos := SI.nPos;
    Result := True;
  end
  else
    Result := False;
end;
{ENDIF IFDEF _SB_HOOKIMPEXP_}

(*
function GetScrollBarTrackPos( hWnd: THandle; BarFlag:Integer; var Pos:Integer ):Boolean;
var
  SI: TScrollInfo;
begin
  SI.cbSize := SizeOf(SI);
  SI.fMask := SIF_ALL;// bug in TRACKPOS
  if GetScrollInfo(hWnd, BarFlag, SI) then
  begin
    Pos := SI.nPos;
    Result := True;
  end
  else
    Result := False;
end;
*)

procedure TElSBController.ElSBScrollEvent(Sender: TObject; ScrollCode: TElScrollCode;
  var ScrollPos: Integer; var DoChange: Boolean);

var
    vSBCode :DWORD;
    SB      :TElSBHandlerCustom;
    SavePos :Integer;
    Si:TScrollInfo;
    CSB: TControlScrollBar;
begin
try
  with Control do
  begin

    SB := TElSBHandlerCustom(Sender);

    SavePos := SB.fPosition;

    if SB.Kind = sbHorizontal then
      vSBCode := WM_HSCROLL
    else
      vSBCode := WM_VSCROLL;

    case ScrollCode of
      escLineUp:
        begin
          if SB.UseSystemStep then
          begin
            Perform( vSBCode, SB_LINEUP, 0);   // SB_LINELEFT = SB_LINEUP
            {IFNDEF _SB_HOOKIMPEXP_}
            if (not IsHookImpExp)and(SB.fPosition = SavePos)
               //and (SavePos <> ScrollPos)
            then
              Perform( vSBCode, ScrollPos shl 16 + SB_THUMBPOSITION, 0);
            {ENDIF}
          end
          else
          {IFDEF _SB_HOOKIMPEXP_}
          if (not IsHookImpExp)or(SavePos <> ScrollPos) then
          {ENDIF}
            Perform( vSBCode, ScrollPos shl 16 + SB_THUMBPOSITION, 0);
        end;
      escLineDown:
        begin
          if SB.UseSystemStep then
          begin
            Perform( vSBCode, SB_LINEDOWN, 0); // SB_LINERIGHT = SB_LINEDOWN
            {IFNDEF _SB_HOOKIMPEXP_}
            if (not IsHookImpExp)and(SB.fPosition = SavePos)
               //and (SavePos <> ScrollPos)
            then
              Perform( vSBCode, ScrollPos shl 16 + SB_THUMBPOSITION, 0);
            {ENDIF}
          end
          else
          {IFDEF _SB_HOOKIMPEXP_}
          if (not IsHookImpExp)or(SavePos <> ScrollPos) then
          {ENDIF}
            Perform( vSBCode, ScrollPos shl 16 + SB_THUMBPOSITION, 0);
        end;
      escPageUp:
        begin
          {if SB.UseSystemStep then
          begin
            Perform( vSBCode, SB_PAGEUP, 0);   // SB_PAGELEFT = SB_PAGEUP
            if (SB.fPosition = SavePos)
               //and (SavePos <> ScrollPos)
            then
              Perform( vSBCode, ScrollPos shl 16 + SB_THUMBPOSITION, 0);
          end
          else{}
          {IFDEF _SB_HOOKIMPEXP_}
          if (not IsHookImpExp)or(SavePos <> ScrollPos) then
          {ENDIF}
            Perform( vSBCode, ScrollPos shl 16 + SB_THUMBPOSITION, 0);
        end;
      escPageDown:
        begin
          {if SB.UseSystemStep then
          begin
            Perform( vSBCode, SB_PAGEDOWN, 0); // SB_PAGERIGHT = SB_PAGEDOWN
            if (SB.fPosition = SavePos)
               //and (SavePos <> ScrollPos)
            then
              Perform( vSBCode, ScrollPos shl 16 + SB_THUMBPOSITION, 0);
          end
          else{}
          {IFDEF _SB_HOOKIMPEXP_}
          if (not IsHookImpExp)or(SavePos <> ScrollPos) then
          {ENDIF}
            Perform( vSBCode, ScrollPos shl 16 + SB_THUMBPOSITION, 0);
        end;
      escPosition:
        begin
          {IFDEF _SB_HOOKIMPEXP_}
          if (not IsHookImpExp)or(SavePos <> ScrollPos) then
          {ENDIF}
            Perform( vSBCode, ScrollPos shl 16 + SB_THUMBPOSITION, 0);
        end;
      escTrack:
        if (SB.fPosition <> ScrollPos){+!}{and(SB.fTrackPos<>ScrollPos){-!} then
        begin
          SavePos := SB.fTrackPos;
          Perform( vSBCode, ScrollPos shl 16 + SB_THUMBTRACK, 0);
          SB.SyncScrollInfoFromSystem(False);
          if SavePos = SB.fTrackPos then
          begin // TElExplorerBar
            if Assigned(FWinCtrl) then
            begin
              if SB.Kind = sbVertical then
                CSB := FWinCtrl.VertScrollBar
              else
                CSB := FWinCtrl.HorzScrollBar;
            end
            else
              CSB := nil;
            if IsHookImpExp or (SB.fScrollTracking) or (Assigned(CSB) and CSB.Tracking) then
              Perform( vSBCode, ScrollPos shl 16 + SB_THUMBPOSITION, 0)
            else
            begin
              FillChar(SI, SizeOf(SI), 0);
              SI.cbSize := SizeOf(SI);
              SI.fMask := SIF_TRACKPOS or SIF_POS;
              SI.nTrackPos := ScrollPos;
              SI.nPos := ScrollPos;
              Windows.SetScrollInfo(Control.Handle, SB.fBarFlag, SI, False);
            end;
            SB.SyncScrollInfoFromSystem(False);
            ScrollPos := SB.fPosition;
          end
          else
            ScrollPos := SB.fTrackPos;
          DoChange := SavePos <> ScrollPos;
          exit;
        end;
      escTop:
        begin
          {IFDEF _SB_HOOKIMPEXP_}
          if IsHookImpExp and (SavePos <> SB.fMin) then
          {ENDIF}
            Perform( vSBCode, SB_TOP, 0);        // SB_LEFT = SB_TOP
        end;
      escBottom:
        begin
          {IFDEF _SB_HOOKIMPEXP_}
          if IsHookImpExp and (SavePos <> SB.fMax) then
          {ENDIF}
            Perform( vSBCode, SB_BOTTOM, 0);     // SB_RIGHT = SB_BOTTOM
        end;
      escEndScroll:
        Perform( vSBCode, SB_ENDSCROLL, 0);    // default handler
      escSndLineUp:
        exit;
      escSndLineDown:
        exit;
    end;//of: case
  end;//of: with Control

  //if not (ScrollCode in [escSndLineUp, escSndLineDown]) then

  // Win9X (98) (TElListBox):
  SB.SyncScrollInfoFromSystem(False);

  DoChange := SavePos <> SB.fPosition;

  if DoChange then
  begin
    ScrollPos := SB.fPosition;
  (*
  {IFDEF _SB_HOOKIMPEXP_}
  end
  else
  if bHookImpExp then
  begin
    if (ScrollCode <> escEndScroll) and (not SB.fTracking) then
    begin
      // The problem was in duplicating of messages from timer (OnScrollTimer)
      // in case positions match.
      SB.fScrollTimer.Enabled := False;
      SB.fPressedIn := sbpNowhere;
     end;
  {ENDIF IFDEF _SB_HOOKIMPEXP_}
  //*)
  end;
except
  on e:exception do
  begin
    LMDDebug( PChar('ERROR: ElSBScrollEvent( ScrollCode='+IntToStr(Byte(ScrollCode))+', ScrollPos='+IntToStr(ScrollPos)+' ): '+e.Message) );
  end;
end;
end; //of: TElSBController.ElSBScrollEvent

procedure TElSBController.SyncScrollInfo(BarFlag: Integer; const SI:TScrollInfo; bRedraw:BOOL);
begin
  ScrollBar[BarFlag].SyncScrollInfo(SI, bRedraw);
end;

function TElSBController.IsScrollingWinControl:Boolean;
begin
  Result := Assigned(FWinCtrl);
end;

procedure TElSBController.UpdateSystemMetrics(bRedraw:Boolean);
  var
    SaveElHookActive :Boolean;
begin
  SaveElHookActive := fElHook.Active;
  if (not bRedraw) and fElHook.Active then
    fElHook.Active := False;
  try
    fHElSB.UpdateSystemMetrics;
    fVElSB.UpdateSystemMetrics;
  finally
    if (not bRedraw) and (SaveElHookActive) then
      fElHook.Active := True;
  end;
end;

function TElSBController.GetElSBHandlerClass:TElSBHandlerCustomClass;
begin
  Result := TElCtrlScrollBarStyles;
end;

procedure TElSBController.InitiateNCCalcSize;
begin
  if Assigned(Control)and(Control.HandleAllocated) and Assigned(fElHook) and fElHook.Active then
    SetWindowPos(Control.Handle, 0,
    //Rect:
      //Control.Left, Control.Top, Control.Width, Control.Height,
      0, 0, 0, 0,
    //Flags:
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE or
      SWP_FRAMECHANGED or SWP_DRAWFRAME
    );
end;

procedure TElSBController.ELSettingChange(var Message: TMessage);
begin
  InitiateNCCalcSize;
end;

procedure TElSBController.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);;
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

procedure TElSBController.DoThemeChanged;
var
  R : TRect;
begin
  if Assigned(fHElSB) then
  begin
    fHElSB.ThemeMode := ThemeMode;
    fHElSB.ThemeGlobalMode := ThemeGlobalMode;
  end;
  if Assigned(fVElSB) then
  begin
    fVElSB.ThemeMode := ThemeMode;
    fVElSB.ThemeGlobalMode := ThemeGlobalMode;
  end;
  if (fUpdateCount=0) and Assigned(Control) and Control.HandleAllocated then
  begin
    R := Control.Boundsrect;
    OffsetRect(R, -R.Left, -R.Top);
    Control.Invalidate;
    RedrawWindow(Control.Handle, @R, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME or RDW_ALLCHILDREN);
  end;
end;

function TElSBController.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

procedure TElSBController.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

procedure TElSBController.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

procedure TElSBController.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

function TElSBController.UseThemeMode: TLMDThemeMode;
begin
  if FThemeGlobalMode then
    result := LMDApplication.ThemeGlobalMode
  else
    result := FThemeMode;
  result := LMDThemeServices.UseTheme(result);
end;

{ TElSBControllerTracking }

function TElSBControllerTracking.GetElSBHandlerClass:TElSBHandlerCustomClass;
begin
  Result := TElCtrlScrollBarStylesTracking;
end;

initialization
  fBlendBitmap := nil;
  //RegisterWindowMessage(MSH_MOUSEWHEEL);
  if Classes.GetClass(TElCtrlScrollBarStyles.ClassName)=nil then
    CLasses.RegisterClass(TElCtrlScrollBarStyles);
finalization
  try
    begin
      fBlendBitmap.Free;
      fBlendBitmap := nil;
      CLasses.UnRegisterClass(TElCtrlScrollBarStyles);
    end;
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElSBCtrl: ' + e.Message);
    end;
  end;
end.
