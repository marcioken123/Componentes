unit LMDPageControl;
{$I lmdcmps.INC}

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

LMDPageControl unit (RM)
-----------------------
LMD Tab- and PageControls

ToDo
----
* Instead of scrollbuttons --> popup menu
* More TabStyles (with regions)
* Optimizations for custom buttons (EnabledState)

Notes
-----
* ScrollOpposite --> Fake property, no funcctionality here
* CloseButton, Scroll Buttons: only when Multiline=false

Changes
-------
Release 8.10 (May 2008)
[+] Options property: toShowAccelChar flag added
[*] Prefixes (when toShowAccelChar is enabled) are drawn correctly when TabPosition is Left or Right.

Release 8.05 (Januar 2008)
[*] OnChanging functionality changed. In TLMDPageControl an available OnChangingEx
    event handler has higher priority than OnChanging event handler.
[+] Added docking support

Release 8.03 (December 2007)
[-] Problem in Multiline Mode in certain cases (2 clicks required to activate tab) fixed

Release 8.0 (July 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Menus, Forms, Messages, Contnrs,
  ComCtrls, ExtCtrls, Themes,LMDObjectList,
  LMDTypes, LMDBase, LMDClass, LMDGraph, LMDFxCaption, LMDCustomSheetControl;

type
  TLMDTabOptions = set of (toCloseButton, toNoTabIfEmpty, toShowBorder, toShowFocusRect,
                           toMouseWheelSupport, toShowAccelChar);

const
  def_LMDTABOptions=[toCloseButton, toNoTabIfEmpty, toShowBorder, toShowFocusRect, toShowAccelChar];

type
  TLMDCustomTabControl=class;
  TLMDPageControl=class;

  TLMDTabSheet=class(TLMDCustomSheet)
  private
    FTabEnabled: Boolean;
    FData: TLMDDataTag;
    procedure SetPageControl(const Value: TLMDPageControl);
    procedure SetTabVisible(Value:Boolean);
    function GetPageControl: TLMDPageControl;
    function GetTabVisible:Boolean;
    procedure SetTabEnabled(const Value: Boolean);
    procedure CMColorChanged(var Message:TMessage);message CM_COLORCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent);  override;
    property Data: TLMDDataTag read FData write FData;
    property PageControl: TLMDPageControl read GetPageControl write SetPageControl;
  published
    property BorderWidth;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property TabEnabled:Boolean read FTabEnabled write SetTabEnabled default true;
    property TabVisible:Boolean read GetTabVisible write SetTabVisible default true;
  end;

  TLMDTabButtonKind = (tbkNone, tbkClose, tbkScrollLeft, tbkScrollRight, tbkTab);

  TLMDDrawTabEvent = procedure(Control: TLMDCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean) of object;
  TLMDTabStyle = (tsTabs, tsButtons, tsFlatButtons, tsSquareTabs, tsNetTabs);

  {------------------------- TLMDCustomTabControl -----------------------------}
  TLMDCustomTabControl=class(TLMDCustomSheetControl)
  private
    FDownButton,
    FHotButton: TLMDTabButtonKind;
    FHotTabIndex:Integer;
    FEnabledButton:array[TLMDTabButtonKind] of Boolean;
    FTimer:TTimer;
    FTimerInterval:Word;
    // controlling tabs
    FTabList:TLMDObjectList;
    FTabRect:TRect; //only for speeding up mouse checks
    FFirstTab,
    FRowCount:Integer;
    // ------------------

    // Text / ImageDisplay
    FImageGap: Byte;
    FIntImageHeight,
    FIntImageWidth : Integer;
    FFont3D : TLMDFxCaption;  // we'll make actually use of it in a future version

    FCloseBtnBitmap: TBitmap;
    FTabBKColor: TColor;
    FHotTrack,
    FRaggedRight,
    FMultiline,
    FOwnerDraw,
    FScrollOpposite,
    FShowTabs: Boolean;
    FTabPosition: TTabPosition;
    FOffset,
    FTabSize: TSmallPoint;
    FMinTabWidth: SmallInt;
    FTabStyle: TLMDTabStyle;
    FOptions: TLMDTabOptions;
    FOnDrawTab: TLMDDrawTabEvent;
    FOnGetImageIndex: TTabGetImageEvent;
    FOnChanging:TTabChangingEvent;
    FHotColor: TColor;
    FTabMenu: TPopupMenu;
    FTabAlignment: TLMDAlignment;

    procedure SetBoolean(const Index: Integer; const Value: Boolean);
    procedure SetDimensions(const Index:Integer; const Value:SmallInt);
    procedure SetOptions(const Value: TLMDTabOptions);
    procedure SetTabPosition(const Value: TTabPosition);
    procedure SetTabStyle(const Value: TLMDTabStyle);
    procedure SetTabBKColor(const Value: TColor);
    function GetDisplayRect: TRect;
    function GetIntTabHeight:Integer;
    function GetTabAreaRect: TRect;
    function GetThemedTabAreaColor: TColor;
    function GetTabAreaColor: TColor;
    function GetShownTabIndex(const TabListIndex:Integer):Integer;
    function GetVisibleLastIndex:Integer;
    function GetVisibleFirstIndex:Integer;
    // Buttons
    function KindOfButtonAt(X, Y: Integer): TLMDTabButtonKind;
    function GetButtonRect(Kind: TLMDTabButtonKind): TRect;
    procedure DrawButton(Kind: TLMDTabButtonKind); virtual;
    procedure DrawTabEdges(var R: TRect; tabID : TThemedTab; clipRect: TRect); overload;
    procedure DrawTabEdges(r1: TRect); overload;
    procedure MakeTabVisible(TabIndex: Integer);
    procedure UpdateButton(Kind: TLMDTabButtonKind; Index:Integer=-1);
    // Timer
    procedure AddTimer;
    procedure RemoveTimer;
    procedure TimerExpired(Sender: TObject);
    // ----
    procedure UpdateIntImageValues;

    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKeyDown(var Msg : TWMKeyDown); message WM_KEYDOWN;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SetFocus;
    procedure SetTabAlignment(const Value: TLMDAlignment);
  protected
    procedure AdjustClientRect(var Rect: TRect); override;
    function CanScroll(Kind: TLMDTabButtonKind=tbkNone): Boolean;
    procedure DoThemeChanged;override;
    procedure DoPageClose(PageIndex:Integer);virtual;abstract;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;override;
    procedure GetChange(Sender:TObject);override;
    function GetTabWidth(Index:Integer): Integer;virtual;
    function GetTabEnabled(Index:Integer):Boolean;virtual;abstract;
    function GetTabsWidth: Integer;
    function GetTabIndex: Integer;virtual;abstract;
    function GetTabText(Index:Integer):String;virtual;abstract;
    function GetTabColor(Index:Integer):TColor;virtual;abstract;
    function GetTabGap:Integer;
    function GetTabCount:Integer;virtual;abstract;
    function GetButtonAreaStart: Integer;
    function GetTabMenuPopupComponent: TComponent; virtual; abstract;
    function HasVisibleTabs:Boolean;
    function IMLEmpty: Boolean; override;
    procedure Loaded;override;
    procedure Paint;override;

    procedure DrawTabs(Canvas:TCanvas; var bRect: TRect; CalcOnly: Boolean=false);
    procedure DrawTab(TabIndex: Integer; const Rect: TRect; Active: Boolean); virtual;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseExit; override;
    procedure SetTabIndex(const Value: Integer);virtual;abstract;
    procedure UpdateTab(const index: Integer);

    property DisplayRect:TRect read GetDisplayRect;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IndexOfTabAt(X, Y: Integer): Integer;
    function IndexOfTabByCaption(aTabCaption: TLMDString ): Integer;
    function IndexOfTabByName(aTabName: TLMDString ): Integer;

    function GetHitTestInfoAt(X, Y: Integer): THitTests;
    function RowCount: Integer;

    function NextTab:Boolean;virtual;abstract;
    function PrevTab:Boolean;virtual;abstract;

    procedure ScrollTabs(Delta: Integer);
    function TabRect(Index:Integer): TRect;
    function TabShowing(Index:Integer): Boolean;

    property Canvas;
    property CtlXP default true; // compatibility
    //property TabStop default True;
    property HotTabIndex: Integer read FHotTabIndex;
    property TabIndex: Integer read GetTabIndex write SetTabIndex default -1;
  published
    property AutoFocus default false;
    property BorderWidth;
    property HotTrack:Boolean index 5 read FHotTrack write SetBoolean default false;
    property HotColor:TColor read FHotColor write FHotColor default clHighLight;
    property ParentBackground default false;
    property ImageList;
    property ListIndex;

    property TabMenu: TPopupMenu read FTabMenu write FTabMenu;
    property MinTabWidth:SmallInt index 4 read FMinTabWidth write SetDimensions default 40;
    // works only with tabs --> compatibility
    property MultiLine:Boolean index 3 read FMultiline write SetBoolean default false;

    // horz intend
    property OffsetX: SmallInt index 2 read FOffset.X write SetDimensions default 0; // 2
    // vert intend
    property OffsetY: SmallInt index 3 read FOffset.Y write SetDimensions default 0; // 3
    property Options:TLMDTabOptions read FOptions write SetOptions default def_LMDTABOptions;
    property OwnerDraw: Boolean index 1 read FOwnerDraw write SetBoolean default false;

    property RaggedRight: Boolean index 4 read FRaggedRight write SetBoolean default true;
    // ToDo --> Make fake property
    property ScrollOpposite: Boolean index 2 read FScrollOpposite write SetBoolean default false;

    property ShowTabs:Boolean index 0 read FShowTabs write SetBoolean default true;

    property TabAlignment: TLMDAlignment read FTabAlignment write SetTabAlignment default agCenterLeft;
    property TabBkColor:TColor read FTabBkColor write SetTabBKColor default clBtnFace;
    // TabHeight = 0 --> Auto
    property TabHeight: SmallInt index 1 read FTabSize.Y write SetDimensions default 0;
    property TabPosition: TTabPosition read FTabPosition write SetTabPosition default tpTop;
    property TabStyle: TLMDTabStyle read FTabStyle write SetTabStyle default tsTabs;
    // TabWidth = 0 --> Auto
    property TabWidth: SmallInt index 0 read FTabSize.X write SetDimensions default 0;
    property TabStop default true;
    property ThemeMode default ttmPlatform; // 9.0
    property ThemeGlobalMode;

    // additional events
    property OnChanging: TTabChangingEvent read FOnChanging write FOnChanging;
    property OnDrawTab: TLMDDrawTabEvent read FOnDrawTab write FOnDrawTab;
    property OnGetImageIndex: TTabGetImageEvent read FOnGetImageIndex write FOnGetImageIndex;

    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TLMDTabGetColorEvent = procedure(Sender:TObject; TabIndex: Integer; var iColor: TColor) of object;
  TLMDTabGetEnabledEvent = procedure(Sender:TObject; TabIndex: Integer; var iEnabled: Boolean) of object;

  {------------------------- TLMDTabControl -----------------------------------}
  TLMDTabControl=class(TLMDCustomTabControl)
  private
    FTabIndex:Integer;
    FTabs: TStrings;
    FOnCloseEvent: TLMDIndexEvent;
    FOnTabGetColor: TLMDTabGetColorEvent;
    FOnTabGetEnabled: TLMDTabGetEnabledEvent;
    procedure SetTabs(const Value: TStrings);
  protected
    procedure DoPageChange(NewPage:TLMDCustomSheet; var Cancel:Boolean);override;
    procedure DoPageClose(PageIndex:Integer);override;
    function GetTabCount:Integer;override;
    function GetTabIndex:Integer;override;
    function GetTabColor(Index:Integer):TColor;override;
    function GetTabEnabled(Index:Integer):Boolean;override;
    function GetTabText(Index:Integer):String;override;
    function GetVisible(Index:Integer):Boolean;override;
    function GetVisibleCount:Integer;override;
    function GetTabMenuPopupComponent: TComponent; override;
    procedure SetTabIndex(const Value: Integer);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FirstPage; override;
    function NextTab:Boolean;override;
    function PrevTab:Boolean;override;
    function GetSheetClass:TLMDSheetClass;override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent);override;
    property DisplayRect;
  published
    property Tabs: TStrings read FTabs write SetTabs;
    property TabIndex;
    property OnCloseClick:TLMDIndexEvent read FOnCloseEvent write FOnCloseEvent;
    property OnGetColorEvent:TLMDTabGetColorEvent read FOnTabGetColor write FOnTabGetColor;
    property OnGetEnabledEvent:TLMDTabGetEnabledEvent read FOnTabGetEnabled write FOnTabGetEnabled;
  end;

  TLMDPageChangeEvent=procedure(Sender:TObject; NewPage:TLMDTabSheet; var Cancel:Boolean) of object;
  TLMDPageCloseEvent=procedure (Sender: TObject; Page:TLMDTabSheet; var Cancel: Boolean) of object;

  {------------------------- TLMDPageControl ----------------------------------}
  TLMDPageControl = class(TLMDCustomTabControl)
  private
    FOnPageChanging:TLMDPageChangeEvent;
    FOnPageClose:TLMDPageCloseEvent;
    FXPages: Boolean;
    FDefaultPage: TLMDTabSheet;
    // AH: Dock supporting
    FNewDockSheet: TLMDTabSheet;
    FUndockingPage: TLMDTabSheet;
    FDockMouseDown: Boolean;
    FDockMousePos: TPoint;

    // new
    procedure SetActivePage(aValue:TLMDTabSheet);
    function GetPage(Index:Integer):TLMDTabSheet;
    function GetActivePage:TLMDTabSheet;
    function GetActivePageIndex: Integer;
    procedure SetActivePageIndex(const Value: Integer);
  protected
    procedure DoPageChange(NewPage:TLMDCustomSheet; var Cancel:Boolean);override;
    procedure DoPageClose(PageIndex:Integer);override;
    function GetTabIndex:Integer;override;
    function GetTabCount:Integer;override;
    function GetTabColor(Index:Integer):TColor;override;
    function GetTabText(Index:Integer):String;override;
    function GetTabEnabled(Index:Integer):Boolean;override;
    function GetTabMenuPopupComponent: TComponent; override;
    procedure SetTabIndex(const Value: Integer);override;
    // AH: Dock supporting
    procedure CMDockNotification(var Message: TCMDockNotification); message CM_DOCKNOTIFICATION;
    procedure CMUnDockClient(var Message: TCMUnDockClient); message CM_UNDOCKCLIENT;
    procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;
    procedure DockOver(Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
    procedure DoRemoveDockClient(Client: TControl); override;
    function GetDockClientFromMousePos(MousePos: TPoint): TControl;
    function GetPageFromDockClient(Client: TControl): TLMDTabSheet;
    procedure GetSiteInfo(Client: TControl; var InfluenceRect: TRect; MousePos:
      TPoint; var CanDock: Boolean); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseExit; override;

  public
    constructor Create(AOwner: TComponent);  override;
    destructor Destroy; override;
    function GetSheetClass: TLMDSheetClass;override;
    procedure MovePage(OldIndex, NewIndex: Integer);override;
    function NextTab:Boolean;override;
    function PrevTab:Boolean;override;
    function PageAt(const X, Y: Integer): TLMDTabSheet;
    function AddPage: TLMDTabSheet; virtual;
    procedure RemovePage(const AIndex: Integer); virtual;
    property ActivePageIndex: Integer read GetActivePageIndex write SetActivePageIndex;

    property PageCount:Integer read GetTabCount;
    property Pages[Index:Integer]:TLMDTabSheet read GetPage;
  published
    property DockSite;
    property DockOrientation;
    property OnDblClick;
    property OnDockOver;
    property OnDockDrop;
    property OnGetSiteInfo;
    // New
    property DefaultPage: TLMDTabSheet read FDefaultPage write FDefaultPage;
    property ActivePage: TLMDTabSheet read GetActivePage write SetActivePage;
    property FreeClosedPages:Boolean read FXPages write FXPages default true;
    property OnChangingEx:TLMDPageChangeEvent read FOnPageChanging write FOnPageChanging;
    property OnPageClose:TLMDPageCloseEvent read FOnPageClose write FOnPageClose;
  end;

implementation
uses
  Consts, Types, uxTheme,
  LMDCont, LMDBmp, LMDResWinControl, LMDProcs, LMDGraphUtils, LMDSysIn,
  LMDButtonBase, LMDUtils, LMDStrings, LMDThemes;

const
  def_ImageGap=5;  // later -> GlyphTextLayout feature
  def_ButtonSize=16; // later -> allow custom sizes
  def_TabStyles=[tsTabs, tsSquareTabs, tsNetTabs];

var
  tsRegistered:Boolean;

type
  // hold reference information about
  TLMDTabListItem=class(TObject)
  public
    RefIndex,
    Line:Integer;
    pRect:TRect;
  end;

{********************* TLMDTabSheet *******************************************}
{----------------------- private ----------------------------------------------}
procedure TLMDTabSheet.SetTabVisible(Value: Boolean);
begin
  Included:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDTabSheet.SetPageControl(const Value: TLMDPageControl);
begin
  SheetControl:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDTabSheet.SetTabEnabled(const Value: Boolean);
begin
  if FTabEnabled <> Value then
    begin
      FTabEnabled := Value;
      LMDSetEnabledState(self, FTabEnabled);
      if Assigned(PageControl) then
        PageControl.DoChange;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDTabSheet.GetPageControl: TLMDPageControl;
begin
  result:=TLMDPageControl(SheetControl);
end;

{------------------------------------------------------------------------------}
function TLMDTabSheet.GetTabVisible: Boolean;
begin
  result:=Included;
end;

{------------------------------------------------------------------------------}
procedure TLMDTabSheet.CMTextChanged(var Message: TMessage);
begin
  if Included and Assigned(PageControl) then
    PageControl.UpdateTab(-2);
end;

{------------------------------------------------------------------------------}
procedure TLMDTabSheet.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if Assigned(PageControl) then
    begin
      if not (IsThemed and IsNotOpaque) then
        NotifyControls(CM_LMDTHEMECHANGED);
      if Included then
        PageControl.DoChange;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTabSheet.Paint;
begin
  if ([csLoading, csReading] * ComponentState <> []) or not Showing then exit;
  FillControl;
  GetBevel.PaintBevel(Canvas, GetClientRect, TransparentBorder);
  //Canvas.TextOut(0,0,Inttostr(ord(ParentBackground))+' '+Inttostr(ord(IsNotOpaque)));
end;

{----------------------- public -----------------------------------------------}
constructor TLMDTabSheet.Create(AOwner: TComponent);
begin
  inherited;
  FTabEnabled := True;
end;

{ ********************* TLMDCustomTabControl **********************************}
{----------------------- private ----------------------------------------------}
procedure TLMDCustomTabControl.SetBoolean(const Index: Integer; const Value: Boolean);
begin
  case Index of
    0: if Value<>FShowTabs then FShowTabs:=Value else exit;
    1: if Value<>FOwnerDraw then FOwnerDraw:=Value else exit;
    2: if Value<>FScrollOpposite then FScrollOpposite:=Value else exit;
    3: if Value<>FMultiline then FMultiline:=Value else exit;
    4: if Value<>FRaggedRight then FRaggedRight:=Value else exit;
    5: if Value<>FHotTrack then FHotTrack:=Value else exit;
  end;
  if (Index in [2, 4]) and not Multiline then exit;
  GetChange(nil);
  ReAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.SetTabAlignment(const Value: TLMDAlignment);
begin
  if Value <> FTabAlignment then
    begin
     FTabAlignment := Value;
     Repaint;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.SetTabBKColor(const Value: TColor);
begin
  if FTabBkColor<>Value then
    begin
      FTabBkColor := Value;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.SetDimensions(const Index: Integer; const Value: SmallInt);
begin
  case Index of
    0: if Value<>FTabSize.X then FTabSize.X:=Value else exit;
    1: if Value<>FTabSize.Y then FTabSize.Y:=Value else exit;
    2: if Value<>FOffset.X then FOffset.X:=Value else exit;
    3: if Value<>FOffset.Y then FOffset.Y:=Value else exit;
    4: if Value<>FMinTabWidth then FMinTabWidth:=Value else exit;
  end;
  GetChange(nil);
  ReAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.SetOptions(const Value: TLMDTabOptions);
begin
  if FOptions<>Value then
    begin
      FOptions := Value;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.SetTabPosition(const Value: TTabPosition);
begin
  if FTabPosition <> Value then
    begin
      if (Value in [tpLeft, tpRight]) and not (FTabStyle in def_TabStyles) then
        raise EInvalidOperation.Create(SInvalidTabPosition);
      FTabPosition := Value;
      ReAlign;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.SetTabStyle(const Value: TLMDTabStyle);
begin
  if Value<>FTabStyle then
    begin
      if (FTabPosition in [tpLeft, tpRight]) and not (Value in def_TabStyles) then
        raise EInvalidOperation.Create(SInvalidTabPosition);
       FTabStyle:=Value;
       ReAlign;
       GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.TimerExpired(Sender: TObject);
begin
  FTimer.Interval:=FTimerInterval;
  if (FDownButton in [tbkScrollLeft, tbkScrollRight]) then
    try
      case FDownButton of
        tbkScrollLeft: ScrollTabs(-1);
        tbkScrollRight: ScrollTabs(1);
      end;
    except
      RemoveTimer;
      raise;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetDisplayRect: TRect;
var
  tmp:Integer;
  tabRect:TRect;
begin
  result := ClientRect;

  tmp:=2+(Ord(IsThemed)*2);
  LMDAdjustRectExt(result, tmp, tmp, -tmp, -tmp);

  tabRect:=GetTabAreaRect;
  if ShowTabs then
    case FTabPosition of
      tpTop: result := Rect(result.Left, TabRect.Bottom+tmp, result.Right, result.Bottom);
      tpBottom: result := Rect(result.Left, result.Top, result.Right, TabRect.Top-tmp);
      tpLeft: result := Rect(TabRect.Right+tmp, result.Top, result.Right-TabRect.Left, result.Bottom);
      tpRight: result := Rect(result.Left, result.Top, TabRect.Left-tmp, result.Bottom);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetVisibleFirstIndex: Integer;
var
 i:integer;
begin
  result:=-1;
  for i:=0 to GetTabCount-1 do
    if GetVisible(i) then
      begin
        result:=i;
        break;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetVisibleLastIndex: Integer;
var
 i:integer;
begin
  result:=-1;
  for i:=GetTabCount-1 downto 0 do
    if GetVisible(i) then
      begin
        result:=i;
        break;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetShownTabIndex(const TabListIndex:Integer):Integer;
var
  i:integer;
begin
  result:=-1;
  for i:=0 to FTabList.Count-1 do
    if TLMDTabListItem(FTabList[i]).RefIndex=TabListIndex then
      begin
        result:=TLMDTabListItem(FTabList[i]).RefIndex;
        break;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetTabAreaRect: TRect;
begin
  SetRectEmpty(result);
  if not ShowTabs then exit;
  case FTabPosition of
    tpTop: result := Rect(0, 0, ClientWidth, GetIntTabHeight+FOffset.Y+2);
    tpLeft: result := Rect(0, 0, GetIntTabHeight+FOffset.X+2, ClientHeight);
    tpBottom: result := Rect(0, ClientHeight-(GetIntTabHeight+2+FOffset.Y), ClientWidth, ClientHeight);
    tpRight: result := Rect(ClientWidth-2-GetIntTabHeight-FOffset.X, 0, ClientWidth, ClientHeight);
  end;
  if FMultiline then
    DrawTabs(Canvas, result, true);
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetTabAreaColor: TColor;
var
  lThemeMode: TLMDThemeMode;
begin
  Result := FTabBkColor;

  if IsThemed then
  begin
    lThemeMode := UseThemeMode;
    if not (csDesigning in ComponentState) and (lThemeMode = ttmNative) then
      Result := LMDThemeServices.GetThemeColor(lThemeMode, teTab, 1, 0, TMT_FILLCOLOR)
    else
    begin
      Result := GetThemedTabAreaColor;//!!!Color;
    end;
  end
  else if FTabStyle = tsNetTabs then
    Result := LMDIncColor(FTabBkColor, 20, 20, 20);
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetIntTabHeight: Integer;
begin
  if FTabSize.Y=0 then
    begin
      Canvas.Font:=self.Font;
      if not LMDIsTrueTypeFontCheck(Canvas) then
        Canvas.Font.Name:=LMD_DEFAULTFONT;
      result:=LMDMax([Canvas.TextHeight('Wq'), FIntImageHeight])+8;
      // --> LMDGet3DTextHeight (Font3D, Font);
      if not IsThemed then
        case FTabStyle of
          tsButtons, tsFlatButtons: Inc(result, 12);
        end;
    end
  else
    result:=FTabSize.Y;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.DrawButton(Kind: TLMDTabButtonKind);
var
  aRect:TRect;

  procedure DrawCustomButton;
  begin
    // color -> TabAreaColor
    if FEnabledButton[Kind] then
      if FDownButton = Kind then
        LMDDrawButtonFrame(Canvas.Handle, aRect, false, true, GetTabAreaColor, false, LMDFullBorderSides)
      else
       if FHotButton = Kind then
         LMDDrawButtonFrame(Canvas.Handle, aRect, false, false, GetTabAreaColor, false, LMDFullBorderSides);
    case Kind of
      tbkClose: Canvas.Draw(aRect.Left+2, aRect.Top+2,  FCloseBtnBitmap);
      tbkScrollRight:
        if FTabPosition in [tpLeft, tpRight] then
          LMDDrawArrow(Canvas, eadDown, aRect, clBlack, FEnabledButton[Kind])
        else
          LMDDrawArrow(Canvas, eadRight, aRect, clBlack, FEnabledButton[Kind]);
      tbkScrollLeft:
        if FTabPosition in [tpLeft, tpRight] then
          LMDDrawArrow(Canvas, eadUp, aRect, clBlack, FEnabledButton[Kind])
        else
          LMDDrawArrow(Canvas, eadLeft, aRect, clBlack, FEnabledButton[Kind]);
    end;

  end;

  procedure DrawSystemButton;
  var
    aState, aType: Integer;
    Details : TThemedElementDetails;
    lTheme: TLMDThemeMode;
  begin
    lTheme := UseThemeMode;
    if lTheme<>ttmNone then
      begin
        aState:= 0;
        if FDownButton = Kind then
          aState := 2
        else
          if FHotButton = Kind then
             aState := 1;
        if not FEnabledButton[Kind] then
          aState := 3;
        case Kind of
          tbkClose:  begin Details := ThemeServices.GetElementDetails(TThemedWindow(Ord(twSmallCloseButtonNormal)+aState)); end;
          tbkScrollRight: if FTabPosition in [tpTop, tpBottom] then
                             Details := ThemeServices.GetElementDetails(TThemedSpin(Ord(tsUpHorzNormal)+aState))
                          else
                             Details := ThemeServices.GetElementDetails(TThemedSpin(Ord(tsDownNormal)+aState));
          tbkScrollLeft : if FTabPosition in [tpTop, tpBottom] then
                             Details := ThemeServices.GetElementDetails(TThemedSpin(Ord(tsDownHorzNormal)+aState))
                          else
                             Details := ThemeServices.GetElementDetails(TThemedSpin(Ord(tsUpNormal)+aState));
        end;
        LMDThemeServices.DrawElement(lTheme, Canvas.Handle, Details, aRect);
      end
    else
      begin
        aType:=DFC_SCROLL;
        if FEnabledButton[Kind] then aState:=0 else aState:=DFCS_INACTIVE;
        if FDownButton = Kind then
          aState:=DFCS_PUSHED
        else
          if FHotButton = Kind then
            aState:=DFCS_HOT;
        case Kind of
          tbkClose:  begin aType:=DFC_CAPTION; aState:=aState or DFCS_CAPTIONCLOSE; end;
          tbkScrollRight: if FTabPosition in [tpTop, tpBottom] then aState:=aState or DFCS_SCROLLRIGHT else aState:=aState or DFCS_SCROLLDOWN;
          tbkScrollLeft: if FTabPosition in [tpTop, tpBottom] then aState:=aState or DFCS_SCROLLLEFT else aState:=aState or DFCS_SCROLLUP;
        end;
        DrawFrameControl(Canvas.Handle, aRect, aType, aState);
      end;
  end;

begin
  if not (Kind in [tbkClose, tbkScrollRight,tbkScrollLeft]) then exit;

  aRect:=GetButtonRect(Kind);
  case Kind of
    tbkClose:FEnabledButton[tbkClose]:=GetTabIndex<>-1;
    tbkScrollRight:FEnabledButton[tbkScrollRight]:=CanScroll(tbkScrollRight);
    tbkScrollLeft:FEnabledButton[tbkScrollLeft]:=CanScroll(tbkScrollLeft);
  end;

  case FTabStyle of
   tsTabs, tsSquareTabs, tsButtons, tsFlatButtons:
     DrawSystemButton;
   tsNetTabs:
     DrawCustomButton;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.DrawTabEdges(var R: TRect; tabID : TThemedTab; clipRect: TRect);
var
  TmpBmp, TmpBmp1: TBitmap;
  R1: TRect;
  lTheme : TLMDThemeMode;
begin
  lTheme := UseThemeMode;
  if FTabPosition=tpTop then
    begin
      LMDThemeServices.DrawElement(lTheme, Canvas.Handle, tabID, R, LMDRectToPtr(clipRect));
      exit;
    end;

  TmpBmp := TBitmap.Create;
  TmpBmp1 := TBitmap.Create;
  try
    TmpBmp1.Width := R.Right - R.Left;
    TmpBmp1.Height := R.Bottom - R.Top;
    if FTabPosition in [tpLeft, tpRight] then
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
    if IsRectEmpty(ClipRect) then
      ClipRect:=R;

    TmpBmp.PixelFormat := pf32bit;
    {$IFDEF LMDCOMP16}
    //remove black corners
    if StyleServices.Enabled and  not StyleServices.IsSystemStyle then
      LMDThemeServices.DrawElement(lTheme, TmpBmp.Canvas.Handle, ttBody, R1);
    {$ENDIF}
    LMDThemeServices.DrawElement(lTheme, TmpBmp.Canvas.Handle, tabID, R1);

    case FTabPosition of
      tpLeft:
        begin
          LMDBmpRotate(TmpBmp, TmpBmp1, 90 * Pi / 180);
          BitBlt(Canvas.Handle, ClipRect.Left, ClipRect.Top,
                 ClipRect.Right - ClipRect.Left, ClipRect.Bottom - ClipRect.Top,
                 TmpBmp1.Canvas.Handle, ClipRect.Top-R.Top, ClipRect.Top-R.Top, SRCCOPY);
        end;
      tpRight:
        begin
          LMDBmpRotate(TmpBmp, TmpBmp1, 270 * Pi / 180);
          BitBlt(Canvas.Handle, ClipRect.Left, ClipRect.Top,
                 ClipRect.Right - ClipRect.Left, ClipRect.Bottom - ClipRect.Top,
                 TmpBmp1.Canvas.Handle, ClipRect.Left-R.Left, ClipRect.Top-R.Top, SRCCOPY);
        end;
      tpBottom:
        begin
          LMDBMPFlipVertical(TmpBmp, TmpBmp1);
          BitBlt(Canvas.Handle, ClipRect.Left, ClipRect.Top,
                 ClipRect.Right - ClipRect.Left, ClipRect.Bottom - ClipRect.Top,
                 TmpBmp1.Canvas.Handle, ClipRect.Left-R.Left, ClipRect.Top-R.Top, SRCCOPY);
        end;
    end;
  finally
    TmpBmp.Free;
    TmpBmp1.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.DrawTabEdges(r1: TRect);
const
  ROUND_CORNER_SIZE = 2;
var
  bSides:TLMDBorderSides;
begin
  if CheckOptimized then
    BackDrawArea(Canvas, r1, Point(0,0){(Left,Top}, 0)
  else
    Canvas.FillRect(r1);
{  case FTabPosition of   // RM (use later ClipRect instead)
    tpTop: Dec(r1.Bottom);
    tpLeft: Dec(r1.Right);
  end;}
  case FTabStyle of
    tsSquareTabs:
      begin
        case FTabPosition of
          tpLeft: bSides:=[ebsLeft, ebsTop, ebsBottom];
          tpRight:bSides:=[ebsTop, ebsRight, ebsBottom];
          tpTop: bSides:=[ebsLeft, ebsTop, ebsRight];
          tpBottom: bSides:=[ebsLeft, ebsRight, ebsBottom];
        else
          bSides:=[ebsLeft, ebsTop, ebsRight];
        end;
        LMDDrawButtonFrame(Canvas.Handle, r1, true, false, clBtnFace, false, bSides); // Active state?
      end;
    tsTabs:
      with Canvas do
        begin
          Pen.Color := clBtnHighlight;
          case FTabPosition of
            tpTop:
              begin
                (* highlight *)
                MoveTo(r1.left, r1.bottom - 1);
                LineTo(r1.left, r1.top + ROUND_CORNER_SIZE);
                LineTo(r1.left + ROUND_CORNER_SIZE, r1.top);
                LineTo(r1.right - ROUND_CORNER_SIZE, r1.top);
                (* shadow *)
                Pen.Color := cl3DDkShadow;
                MoveTo(r1.right - 2, r1.Top + 1);
                LineTo(r1.right - 1, r1.top + ROUND_CORNER_SIZE);
                LineTo(r1.right - 1, r1.bottom);
                 (* shade *)
                Pen.Color := clBtnShadow;
                MoveTo(r1.right - 2, r1.top + ROUND_CORNER_SIZE);
                LineTo(r1.right - 2, r1.bottom);
              end;
             tpLeft:
               begin
                 (* highlight *)
                 MoveTo(r1.right, r1.top);
                 LineTo(r1.left + ROUND_CORNER_SIZE, r1.top);
                 LineTo(r1.left, r1.top + ROUND_CORNER_SIZE);
                 LineTo(r1.left, r1.bottom - ROUND_CORNER_SIZE);
                 (* shadow *)
                 Pen.Color := cl3DDkShadow;
                 MoveTo(r1.left + 1, r1.bottom - 2);
                 LineTo(r1.left + ROUND_CORNER_SIZE, r1.bottom - 1);
                 LineTo(r1.right, r1.bottom - 1);
                 (* shade *)
                 Pen.Color := clBtnShadow;
                 MoveTo(r1.left + ROUND_CORNER_SIZE, r1.bottom - 2);
                 LineTo(r1.right, r1.bottom - 2);
              end;
             tpRight:
               begin
                 MoveTo(r1.left, r1.top);
                 LineTo(r1.right - ROUND_CORNER_SIZE - 1, r1.top);
                 LineTo(r1.right - 1, r1.top + ROUND_CORNER_SIZE);
                 (* shadow *)
                 Pen.Color := cl3DDkShadow;
                 LineTo(r1.right - 1, r1.bottom - ROUND_CORNER_SIZE - 1);
                 LineTo(r1.right - ROUND_CORNER_SIZE - 1, r1.bottom - 1);
                 LineTo(r1.left-1, r1.bottom - 1);
                 (* shade *)
                 Pen.Color := clBtnShadow;
                 MoveTo(r1.right - 2, r1.top + 2);
                 LineTo(r1.right - 2, r1.bottom - 2);
                 MoveTo(r1.right - 3, r1.bottom - 2);
                 LineTo(r1.left-1, r1.bottom - 2);
               end;
             tpBottom:
               begin
                 (* highlight *)
                 MoveTo(r1.left, r1.top);
                 LineTo(r1.left, r1.bottom - ROUND_CORNER_SIZE - 1);
                 LineTo(r1.left + ROUND_CORNER_SIZE, r1.bottom - 1);
                 (* shadow *)
                 Pen.Color := cl3DDkShadow;
                 LineTo(r1.right - ROUND_CORNER_SIZE - 1, r1.bottom - 1);
                 LineTo(r1.right, r1.bottom - ROUND_CORNER_SIZE - 2);
                 MoveTo(r1.right - 1, r1.bottom - ROUND_CORNER_SIZE - 1);
                 LineTo(r1.right - 1, r1.top-1);
                 (* shade *)
                 Pen.Color := clBtnShadow;
                 MoveTo(r1.left + ROUND_CORNER_SIZE, r1.bottom - 2);
                 LineTo(r1.right - 2, r1.bottom - 2);
                 MoveTo(r1.right - 2, r1.bottom - ROUND_CORNER_SIZE - 1);
                 LineTo(r1.right - 2, r1.top-1);
               end;
          end;
        end;
    tsNetTabs:
      with Canvas do
        begin
          Canvas.Pen.Color := LMDIncColor(clBtnHighlight, 20, 20, 20);
          case FTabPosition of
            tpLeft:
              begin
                (* highlight *)
                MoveTo(r1.right - 1, r1.top);
                LineTo(r1.left, r1.top);
                LineTo(r1.left, r1.bottom + 1);
                (* shadow *)
                Pen.Color := cl3DDkShadow;
                MoveTo(r1.left + 1, r1.bottom);
                LineTo(r1.right, r1.bottom);
              end;
            tpTop:
              begin
                (* highlight *)
                MoveTo(r1.left, r1.bottom - 1);
                LineTo(r1.left, r1.top);
                LineTo(r1.right, r1.top);
                (* shadow *)
                Pen.Color := cl3DDkShadow;
                MoveTo(r1.right - 1, r1.top + 1);
                LineTo(r1.right - 1, r1.bottom - 1);
              end;
            tpRight:
              begin
                (* highlight *)
                MoveTo(r1.left, r1.top);
                LineTo(r1.right, r1.top);
                (* shadow *)
                Pen.Color := cl3DDkShadow;
                LineTo(r1.right, r1.bottom + 1);
                MoveTo(r1.left, r1.bottom);
                LineTo(r1.right, r1.bottom);
              end;
            tpBottom:
              begin
                (* highlight *)
                MoveTo(r1.left, r1.top);
                LineTo(r1.left, r1.bottom + 1);
                (* shadow *)
                Pen.Color := cl3DDkShadow;
                MoveTo(r1.right, r1.top);
                LineTo(r1.right, r1.bottom);
                LineTo(r1.left, r1.bottom);
              end;
          end;
        end;
   end; // FTabStyle
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.CMDialogChar(var Message: TCMDialogChar);
var
  i:Integer;
begin
  inherited;
  if not (toShowAccelChar in FOptions) then exit;
  with Message do
    for i:=0 to GetTabCount-1 do
      if (i<>TabIndex) and IsAccel(CharCode, GetTabText(i)) and CanFocus
          and GetVisible(i) and GetTabEnabled(i) then
        begin
          TabIndex := i;
          Result := 1;
          exit;
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  if (IndexOfTabAt(Message.XPos, Message.YPos)<>-1) or (KindofButtonAt(Message.XPos, Message.YPos)<>tbkNone) then
    Message.Result := 1
  else
    Message.Result := 0;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
 inherited;
 Msg.Result := Msg.Result or DLGC_WANTARROWS;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.WMKeyDown(var Msg: TWMKeyDown);
begin
  inherited;
  case Msg.CharCode of
    VK_DOWN, VK_RIGHT : NextTab;
    VK_UP, VK_LEFT : PrevTab;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.WMSetFocus(var Message: TWMSetFocus);
//var
//  aRect:TRect;
begin
  inherited;
  if TabStop then
    begin
      if AutoFocus and (ActiveSheet<>nil) then
        ActiveSheet.SetFocus
      else
        if CanFocus then
          self.SetFocus;
      //aRect:=GetTabAreaRect;
      InvalidateRect(Handle, @FTabRect, False);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.WMKillFocus(var Msg: TWMKillFocus);
//var
//  aRect:TRect;
begin
  inherited;
  if TabStop then
    begin
      //aRect:=GetTabAreaRect;
      InvalidateRect(Handle, @FTabRect, False);
    end;
end;

{----------------------- protected --------------------------------------------}
procedure TLMDCustomTabControl.AdjustClientRect(var Rect: TRect);
begin
  Rect := DisplayRect;
  inherited AdjustClientRect(Rect);
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.CanScroll(Kind: TLMDTabButtonKind=tbkNone): Boolean;
begin
  result:=false;
  if FMultiline or (FTabList.Count=0) then exit;

  canScroll:=true;

  case Kind of
    // scrolling at all?
    tbkNone: result:=GetTabsWidth>GetButtonAreaStart; //CanScroll(tbkScrollLeft) or CanScroll(tbkScrollright);
    tbkScrollLeft: result:=TLMDTabListItem(FTabList[0]).RefIndex<>GetVisibleFirstIndex;
    tbkScrollright: result:=TLMDTabListItem(FTabList[FTabList.Count-1]).RefIndex<>GetVisibleLastIndex;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.DoThemeChanged;
begin
  inherited;
  GetChange(nil);
  ReAlign;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  result:=false;
  inherited DoMouseWheelDown(Shift, MousePos);
  if not (toMouseWheelSupport in FOptions) then exit;
  if Focused and TabStop then
    result:=PrevTab;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  result:=false;
  inherited DoMouseWheelUp(Shift, MousePos);
  if not (toMouseWheelSupport in FOptions) then exit;
  if Focused and TabStop then
    result:=NextTab;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.DrawTabs(Canvas:TCanvas; var bRect: TRect; CalcOnly: Boolean=false);
var
  // i, j: loop variables;  X, Y: coordinates; ic: counte for loop; ifiR: internal first in Row
  i, j, ic, rc, ifiR, X, Y:Integer;
  //tw, th: TabHeight; ti: TabIndex
  tw, th, ti, linefeed: Integer;
  // cRow: Count Rows, indexRow: Row where Index resides; firstInRow: index of first in Row
  cRow, firstinrow,
  maxWidth, testw, tabGap:Integer;
  cRect: TRect;
  horz, adaptRects:Boolean;

  procedure AddTabInfo(const aRect:TRect; const aRow, aTabIndex:Integer);
  begin
    FTabList.Add(TLMDTabListItem.Create);
    with TLMDTabListItem(FTabList.Last) do
      begin
        pRect:=aRect;
        Line:=aRow;
        RefIndex:=aTabIndex;
      end;
  end;

  procedure NewLine(updateRow:Boolean=true);
  begin
    if horz then
      begin
        Y:=Y+linefeed;
        X:=FOffset.X+2;
      end
    else
      begin
        X:= X+linefeed;
        Y :=FOffset.Y+2;
      end;
    inc(cRow);
    if updateRow then ifir:=i;
  end;

  procedure AdjustWidth;
  var
    k, gap:Integer;
    tmpr:TRect;
  begin
    rc:=0;
    for k:=FTabList.Count-1 downto 0 do
      if TLMDTabListItem(FTabList[k]).Line=cRow then Inc(rc) else break;

    if horz then
      begin
        gap:=((maxWidth-X) div rc);
        with TLMDTabListItem(FTabList[FTabList.Count-rc]) do pRect.Right:=pRect.Right+gap;
        for k:=1 to rc-1 do
          begin
            tmpr:=TLMDTabListItem(FTabList[FTabList.Count-rc+k]).pRect;
            OffsetRect(tmpr, k*gap, 0);
            Inc(tmpr.Right, gap);
            if tmpr.Right>maxWidth-2 then tmpr.Right:=maxWidth-2;
            TLMDTabListItem(FTabList[FTabList.Count-rc+k]).pRect:=tmpr;
          end;
      end
    else
      begin
        gap:=((maxWidth-Y) div rc);
        with TLMDTabListItem(FTabList[FTabList.Count-rc]) do pRect.Bottom:=pRect.Bottom+gap;
        for k:=1 to rc-1 do
          begin
            tmpr:=TLMDTabListItem(FTabList[FTabList.Count-rc+k]).pRect;
            OffsetRect(tmpr, 0, k*gap);
            Inc(tmpr.Bottom, gap);
            if tmpr.Bottom>maxWidth-2 then tmpr.Bottom:=maxWidth-2;
            TLMDTabListItem(FTabList[FTabList.Count-rc+k]).pRect:=tmpr;
          end;
      end;
  end;

begin
  cRow:=0; maxWidth:=ClientWidth;

  ti := GetTabIndex;      // buffer to calculate only once
  th := GetIntTabHeight;  // buffer to calculate only once

  if CalcOnly then
    begin
      linefeed:=th+1;
      case FTabPosition of
        tpLeft: X:= FOffset.X+2;
        tpRight: X:= bRect.Left+FOffset.X+2;
        tpTop: Y := FOffset.Y+2;
        tpBottom: Y := bRect.Top+FOffset.Y+2;
      end;
    end
   else
     begin
       FTabList.Clear;
       if not (Transparent or (IsThemed and IsNotOpaque)) then
         with Canvas do
           begin
             Brush.Color := GetTabAreaColor;
             FillRect(bRect);
           end;
       case FTabPosition of
         tpLeft:     begin
                       linefeed:=-th-1;
                       X:=bRect.Right-th;
                     end;
         tpRight:    begin
                       linefeed:=th+1;
                       X:=bRect.Left;
                     end;
         tpTop:      begin
                       Y := bRect.Bottom-th;          //FOffset.Y;
                       linefeed:=-th;
                     end;
         tpBottom:   begin
                       Y := bRect.Top;
                       linefeed:=th+1;
                     end;
       end;
     end;

  horz:=FTabPosition in [tpTop, tpBottom];
  if not FMultiline then
    maxWidth:=GetButtonAreaStart;

  if horz then
    begin
      X := FOffset.X+2;
      if FMultiline then maxWidth:=bRect.Right;
    end
  else
    begin
      Y := FOffset.Y+2;
      if FMultiline then maxWidth:=bRect.Bottom;
    end;

  // 0..FirstTab..GetTabCount-1
  // i=loop variable, ic=Number tabs, j: counts number of checked items
  ic:=GetTabCount; i:=FFirstTab; j:=0; firstinrow:=FFirstTab; ifir:=FFirstTab; tabGap:=GetTabGap;
  while j<ic do
    begin
      if (GetSheetClass=nil) or GetVisible(i) then
        begin
          tw := GetTabWidth(i);
          If Horz then testw:=X+tw else testw:=Y+tw;
          if testW > maxWidth then       // extends with?
            if FMultiline then
              begin
                if not CalcOnly and not FRaggedRight then AdjustWidth;
                NewLine(true);
              end
            else
              begin
                if j=0 then
                  tw:=maxWidth // we must display at least 1 tab
                else
                  Break; // not Multiline? we can exit...
              end;
          if testW >= 0 then
            begin
              if not CalcOnly then
                begin
                  if horz then
                    cRect := Types.Rect(X, Y, X + tw, Y + th)
                  else
                    cRect := Types.Rect(X, Y, X + th, Y + tw);
                  AddTabInfo(cRect, cRow, i)
                end
              else
                if Multiline and (i=ti) then
                  firstinrow:=ifir;
            end;
          if horz then
            Inc(X, tw + tabGap)       // increment Width
          else
            Inc(Y, tw + tabGap);
        end;
      // loop variables
      Inc(j); Inc(i);
      if i=ic then
        if FMultiline then
          begin
            i:=0;
            if not CalcOnly and (j<ic) then
              begin
                if not FRaggedRight then AdjustWidth;
                NewLine(false);
              end;
          end
        else
          break;
      if (j=ic) and FMultiline and not CalcOnly and not FRaggedRight and (cRow>1) then AdjustWidth;
    end;

  adaptRects:=not ((FTabStyle in def_TabStyles) or IsThemed);
  if CalcOnly then
    begin
      case FTabPosition of
        tpTop: bRect.Bottom:=Y+LineFeed;
        tpBottom: bRect.Top:=bRect.Bottom-(Y+LineFeed-bRect.Top);
        tpRight: bRect.Left:=bRect.Right-(X+LineFeed-bRect.Left);
        tpLeft: bRect.Right:=X+LineFeed;
      end;
      if (not adaptRects) and FMultiline and (ti<>-1) then    // Multiline top -> tabindex must be in last row
         FFirstTab:=firstinRow;
      exit;
    end;

  // Draw the tabs!!
  FRowCount:=CRow;
  FTabRect:=bRect;

  tw:=-1;  // we use tw as buffer variable to check whether PageIndex tab is shown
  for i:=0 to FTabList.Count-1 do
    with TLMDTabListItem(FTabList[i]) do
      begin
        if RefIndex=ti then
          begin
            cRect:=pRect;
            tw:=0;
          end
        else
          DrawTab(RefIndex, pRect, false);
        // if adaptRects then ;
      end;

  // finally: PageIndex tab
  if (ti<>-1) and (tw<>-1) then
    DrawTab(ti, cRect, true);

  // ButtonArea
  if FMultiLine then exit;
  if toCloseButton in FOptions then
    DrawButton(tbkClose);
  if CanScroll then
    begin
      DrawButton(tbkScrollLeft);
      DrawButton(tbkScrollRight);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.DrawTab(TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  c, tabcolor:TColor;
  tabtext:String;
  flags :Word;
  tabId:TThemedTab;
  tmp:TLMDTabStyle;
  xp:Boolean;
  r1, clipRect, tabRect: TRect;
  TmpBmp, aBitmap:TBitmap;
  tabstate: cardinal;
  dtls: TThemedElementDetails;

  procedure CheckRect(horz:Boolean);
  begin
    if horz then
      begin
        if r1.Top<0 then r1.Top:=0;
        if r1.Bottom>ClientHeight-Ord(xp) then r1.Bottom:=ClientHeight-Ord(xp);
      end
    else
      begin
        if r1.Left<0 then r1.Left:=0;
        if r1.Right>ClientWidth-2*Ord(xp) then r1.Right:=ClientWidth-2*Ord(xp);
      end;
  end;

  procedure AdaptTextGlyphRect;
  begin
    InflateRect(r1, -2, -2);
  end;

  procedure AdaptFocusRect;
  begin
    case FTabStyle of
      tsFlatButtons,
      tsButtons: r1:=LMDExpandRect(tabRect, -1);
    else
      r1:=LMDExpandRect(tabRect, -3);
    end;
  end;

begin
  r1:=Rect;
  Canvas.Font.Assign(Self.Font);
  if not LMDIsTrueTypeFontCheck(Canvas) then
    Canvas.Font.Name:=LMD_DEFAULTFONT;

  Canvas.Brush.Style:=bsClear;
  tabColor:=GetTabColor(TabIndex);
  Canvas.Brush.Color:=tabColor;

  if FOwnerDraw then
    begin
      if Assigned(FOnDrawTab) then
        FOnDrawTab(self, TabIndex, Rect, Active);
      exit;
    end;

  // init
  xp:=IsThemed;
  if xp then tmp:=tsTabs else tmp:=FTabStyle; // Themed mode overrides all settings
  tabtext:=GetTabText(TabIndex);

  // Tabs
  // -------------
  case tmp of
    tsButtons:
      begin
        LMDAdjustRectExt(r1, 0, Ord(FTabPosition=tpBottom)*4, 0, Ord(FTabPosition=tpTop)*-4);
        if Active then
          LMDDrawBtnFace(Canvas, false {MOuseOver}, r1, ubsWin40, bsOptionSet, BDF_SPEEDBUTTON,clBtnFace)
        else
          LMDDrawBtnFace(Canvas, false, r1, ubsWin40, bsUp, BDF_SPEEDBUTTON, clBtnFace);
      end;
    tsFlatButtons:
      begin
        if TabIndex<>TLMDTabListItem(FTabList[FTabList.Count-1]).RefIndex then  // last item requires no line
          begin
            r1:=Types.Rect(r1.right-1,r1.Top+1, r1.right, r1.Bottom-1);
            DrawEdge(Canvas.Handle, r1, EDGE_ETCHED, BF_LEFT);
          end;
        r1:=Rect;
        LMDAdjustRectExt(r1, 4, Ord(FTabPosition=tpBottom)*4, -4, Ord(FTabPosition=tpTop)*-4);
        if Active then
          LMDDrawBtnFace(Canvas, false {MOuseOver}, r1, ubsWin40, bsOptionSet, BDF_SPEEDBUTTON,clBtnFace)
      end;
    tsTabs, tsSquareTabs, tsNetTabs:  // and themed mode
      begin
        case FTabPosition of
          tpLeft: begin
                    if Active then
                      begin
                        LMDAdjustRectExt(r1, -2, -2, 2{+Ord(xp)}, 2);
                        CheckRect(true);
                        if xp then
                          clipRect:=Types.Rect(r1.Left, r1.Top, r1.Right-1, r1.Bottom);
                      end;
                   end;
          tpRight:begin
                    if Active then
                      begin
                        LMDAdjustRectExt(r1, -2-(2*Ord(xp)), -2, 2, 2);
                        CheckRect(true);
                        if xp then
                          clipRect:=Types.Rect(r1.Left+1, r1.Top, r1.Right, r1.Bottom);
                       end
                     else
                       if xp then LMDAdjustRectExt(r1, -2, 0, 0, 0);
                  end;
          tpTop: begin
                   if Active then
                     begin
                       LMDAdjustRectExt(r1, -2, -2, 2, 2{+Ord(XP)});
                       CheckRect(false);
                       if xp then
                         clipRect:=Types.Rect(r1.Left, r1.Top, r1.Right, r1.Bottom-1);
                      end;
                 end;
          tpBottom:
                 begin
                   if Active then
                     begin
                       LMDAdjustRectExt(r1, -2, -2-Ord(xp), 2, 2);
                       CheckRect(false);
                       if xp then
                         clipRect:=Types.Rect(r1.Left, r1.Top+1, r1.Right, r1.Bottom);
                     end
                   else
                     if xp then LMDAdjustRectExt(r1, 0, -1, 0, 0);
                 end;
        end;

        if xp then
          begin
            tabID:=ttTopTabItemNormal;
            if Active then
              tabID:=ttTopTabItemSelected
            else
              begin
                clipRect:=r1;
                if TabIndex=FHotTabIndex then tabID := ttTopTabItemHot;
              end;
            DrawTabEdges(R1, tabID, clipRect);
          end
        else
          if not (FTabStyle=tsNetTabs) or Active then
            DrawTabEdges(R1)
          else
            if TabIndex<>TLMDTabListItem(FTabList[FTabList.Count-1]).RefIndex then  // last item requires no line
              with Canvas do
                begin
                  Pen.Color := clBtnFace;
                  if FTabPosition in [tpLeft, tpRight] then
                    begin
                      MoveTo(r1.Left+2, r1.Bottom);
                      LineTo(r1.Right-2, r1.Bottom);
                    end
                  else
                    begin
                      MoveTo(r1.Right, r1.Top+2);
                      LineTo(r1.Right, r1.bottom-2);
                    end;
                end;
      end;

    end;  // case tmp

  tabRect:=r1;
  AdaptTextGlyphRect;

  // Glyphs
  // -------------
  if IMLEmpty or (TabIndex>=LMDIMLCount(ImageList, ListIndex)) then
    begin
      case FTabPosition of
        tpTop, tpBottom: Inc(r1.Left, 3);
        tpRight: Inc(r1.top, 3);
        tpLeft: Dec(r1.Bottom, 3);
      end;
    end
  else
    begin
      aBitmap := TBitmap.Create;
      try
         LMDIMLItemBitmap(ImageList, ListIndex, TabIndex, aBitmap);
         aBitmap.Transparent:=True;
         case FTabPosition of
           tpTop, tpBottom:
                  begin
                    Canvas.Draw(r1.Left+FImageGap, r1.Top+((LMDRectHeight(r1)-aBitmap.Height) div 2), aBitmap);
                    r1.Left:=r1.Left+aBitmap.Width+2*FImageGap;
                  end;
           tpLeft:
                  begin
                    Canvas.Draw(r1.Left+((LMDRectWidth(r1)-aBitmap.Width) div 2),
                                r1.Bottom-FImageGap-aBitmap.Height, aBitmap);
                    r1.Bottom := r1.Bottom-aBitmap.Width-2*FImageGap;
                  end;
           tpRight:
                  begin
                    Canvas.Draw(r1.Left+((LMDRectWidth(r1)-aBitmap.Width) div 2),
                               r1.Top+FImageGap, aBitmap);
                    r1.Top:=r1.Top+aBitmap.Width+2*FImageGap;
                  end;
         end;
      finally
        aBitmap.Free;
      end;
  end;

  // Text
  // -------------
  flags:=DrawTextBiDiModeFlags(DT_SINGLELINE);
  flags := flags or TLMDALIGNFLAGS[TabAlignment];

  tabstate := Ord(ttTabItemNormal);//!!!TIS_NORMAL;
  if IsThemed and not (csDesigning in ComponentState) then
  begin
    if TabIndex = Self.TabIndex then
      tabstate := Ord(ttTabItemSelected)//!!!TIS_SELECTED
    else
      if TabIndex = FHotTabIndex then
        tabstate := Ord(ttTabItemHot);//!!!TIS_HOT;

    dtls := LMDThemeServices.GetDetails(teTab, tabstate);
    Canvas.Font.Color := LMDThemeServices.GetThemeColor(UseThemeMode, dtls,
                                                        TMT_TEXTCOLOR);
  end;

  if (FHotTabIndex = TabIndex) and (UseThemeMode <> ttmNative) then
    Canvas.Font.Color := FHotColor;

  if (FTabPosition in [tpLeft, tpRight]) and (toShowAccelChar in FOptions) then
    // 8.10
    begin
      FFont3D.Angle:=0;
      FFont3D.SetPosXY(0,0);
      TmpBmp := TBitmap.Create;
      aBitmap := TBitmap.Create;
      try
        TmpBmp.PixelFormat := pf24bit;
        aBitmap.PixelFormat := pf24bit;

        if self.Canvas.Font.Color = clFuchsia then  // specify transparent color
          tabColor := clMaroon
        else
          tabColor := clFuchsia;

        if LMDSIWindowsVistaUp then
          c := clNone
        else
          c := tabColor;

        LMDBmpCreateFromRect(TmpBmp, Types.Rect(0,0, r1.Bottom-r1.top, r1.right-r1.Left), c);
        if LMDSIWindowsVistaUp then
          BitBlt(TmpBmp.Handle, 0, 0, TmpBmp.Width, TmpBmp.Height, Canvas.Handle, r1.Left, r1.Top, SRCCOPY)
        else
        begin
          TmpBmp.TransparentColor := tabColor;
          TmpBmp.Transparent := true;
          TmpBmp.TransparentMode := tmAuto;
        end;

        TmpBmp.Canvas.Font.Assign(self.Canvas.Font);

        LMDDrawTextExt (TmpBmp.Canvas, tabtext, FFont3D, Types.Rect(0,0, TmpBmp.Width, TmpBmp.Height), flags,
                        [TLMDDrawTextStyle(GetTabEnabled(TabIndex)), dt3DDisabled{, dtClip}], nil);
        aBitmap.Width := TmpBmp.Height;
        aBitmap.Height := TmpBmp.Width;
        case FTabPosition of
          tpLeft:
            begin
              LMDBmpRotate(TmpBmp, aBitmap, 90 * Pi / 180);
            end;
          tpRight:
            begin
              LMDBmpRotate(TmpBmp, aBitmap, 270 * Pi / 180);
            end;
        end;
        aBitmap.TransparentColor := tabColor;
        aBitmap.Transparent := true;
        aBitmap.TransparentMode := tmAuto;
        Canvas.Draw(r1.Left, r1.Top, aBitmap);
      finally
        TmpBmp.Free;
        aBitmap.Free;
      end;
    end
  else
    begin
      case FTabPosition of
        tpBottom, tpTop:
          begin
            if not (toShowAccelChar in FOptions) then
              flags:= flags or DT_NOPREFIX;
            FFont3D.Angle:=0;
          end;
        tpLeft:
          begin
            FFont3D.SetPosXY(0,0);
            FFont3D.Angle:=90;
            r1:=LMDAlignTextRect(agBottomCenter, tabtext, FFont3D, r1, Canvas.Font, false, false, flags);
          end;
        tpRight:
          begin
            FFont3D.Angle:=270;
            r1:=LMDAlignTextRect(agTopCenter, tabtext, FFont3D, r1, Canvas.Font, false, false, flags);
          end;
      end;
      LMDDrawTextExt (Canvas, tabtext, FFont3D, r1, flags,
                      [TLMDDrawTextStyle(GetTabEnabled(TabIndex)), dt3DDisabled, dtClip], @tabrect);
      FFont3D.SetPosXY(0,0);
    end;

  Canvas.Font:=Self.Font;
  if not (toShowFocusRect in FOptions) then exit;

  //FocusRect
  // -------------
  if TabStop and Focused and Active then
    begin
      AdaptFocusRect;
      Canvas.Brush.Style:=bsSolid;
      Windows.SetTextColor(Canvas.Handle, clBlack);
      DrawFocusRect(Canvas.Handle, r1);
    end;

end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetButtonAreaStart: Integer;

  procedure DecValue(aValue:Integer);
  begin
    if result-aValue>0 then
      Dec(result, aValue);
  end;

begin
  if FTabPosition in [tpTop, tpBottom] then
    result:=ClientWidth
  else
    result:=ClientHeight;
  if FMultiline then exit;

  // area for scroll, close buttons etc.
  if toCloseButton in FOptions then DecValue(20);
  if GetTabsWidth>=result then DecValue(32);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.GetChange(Sender: TObject);
begin
  if FMultiline then
    FFirstTab:=0;
  if Sender=ImageList then
    UpdateIntImageValues;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.Paint;
var
  bRect, tabRect: TRect;

  procedure DrawBackGround;
  var
    lTheme:TLMDThemeMode;
  begin
    lTheme := UseThemeMode;
    if lTheme<>ttmNone then
      LMDThemeServices.DrawElement(lTheme, Canvas.Handle, ttPane, bRect)
    else
      begin
        FillControl;
        if toShowBorder in FOptions then
          case FTabStyle of
            tsTabs, tsSquareTabs, tsNetTabs: LMDDrawButtonFrame(Canvas.Handle, bRect, true, false, clBtnFace, false, LMDFullBorderSides);
          end;
      end;
  end;

begin
  if not Showing then exit;

  // reset TabList
  SetRectEmpty(FTabRect);

  if not HasVisibleTabs and (toNoTabIfEmpty in FOptions) then
    begin
      bRect:=ClientRect;
      DrawBackground;
      exit;
    end;

  if not ShowTabs then exit;

  // Tab and button area
  // ---------------------------------------------------------------------------
  bRect:=ClientRect;
  TabRect:=GetTabAreaRect;

  //1. calculate size of tab area
  case FTabPosition of
    tpTop: bRect.Top:=TabRect.Bottom;
    tpLeft: bRect.Left:=TabRect.Right;
    tpRight: bRect.Right:=TabRect.Left;
    tpBottom: bRect.Bottom:=TabRect.Top;
  end;

  //2. draw client area
  DrawBackground;

  //3. Tab and button area
  DrawTabs(Canvas, TabRect);

  Canvas.Font:=self.Font;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.RowCount: Integer;
begin
  result:=FRowCount;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetButtonRect( Kind: TLMDTabButtonKind): TRect;
var
  aLeft: Integer;
  tmp:TPoint;
begin
  SetRectEmpty(result);
  if (Kind = tbkTab) and (FHotTabIndex<>-1) then
    begin
      result:=TabRect(FHotTabIndex);
      exit;
    end;
  aLeft:=0;
  case FTabPosition of
    tpTop, tpBottom: aLeft:=ClientWidth-2;
    tpLeft, tpRight: aLeft:=ClientHeight-2;
  end;
  with result do
    begin
      if toCloseButton in Options then
        Dec(aLeft, 16);
      case Kind of
        tbkScrollLeft: Dec(aLeft, 32);
        tbkScrollRight: Dec(aLeft, 16);
      end;
      case FTabPosition of
        tpTop: tmp:=Point(aLeft, FTabRect.Bottom-def_ButtonSize-(2+Ord(FTabStyle in [tsButtons, tsFlatButtons])*2));
        tpBottom:tmp:=Point(aLeft, FTabRect.Top+2+Ord(FTabStyle in [tsButtons, tsFlatButtons])*2);
        tpLeft: tmp:=Point(FTabRect.Right-def_ButtonSize-2, ALeft);
        tpRight: tmp:=Point(FTabRect.Left+2, ALeft);
      end;
      result:=Types.Rect(tmp.X, tmp.Y, tmp.X+def_ButtonSize, tmp.Y+def_ButtonSize);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.KindOfButtonAt(X, Y: Integer): TLMDTabButtonKind;
begin
  result := tbkNone;
  if FMultiLine then exit;
  if (toCloseButton in FOptions) and FEnabledButton[tbkCLose] then
    if PtInRect(GetButtonRect(tbkClose), Point(X,Y)) then
      begin
        result := tbkClose;
        exit;
      end;
  if not CanScroll then exit;
  if FEnabledButton[tbkScrollLeft] and PtInRect(GetButtonRect(tbkScrollLeft), Point(X,Y)) then
    result := tbkScrollLeft
  else
    if FEnabledButton[tbkScrollRight] and PtInRect(GetButtonRect(tbkScrollRight), Point(X,Y)) then
      result := tbkScrollRight;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetTabsWidth: Integer;
var
  i, gap:Integer;
begin
  result := 0;
  gap := GetTabGap; // required for overlapping tabs
  for i := 0 to GetTabCount-1 do
    if GetVisible(i) then
      Inc(result, GetTabWidth(i)-gap);
  if GetTabCount>0 then
    Inc(result, gap);
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetTabWidth(Index: Integer): Integer;
var
  aRect:TRect;
  flags:Word;
begin
  if TabWidth=0 then
    begin
      Canvas.Font:= self.Font;
      if not LMDIsTrueTypeFontCheck(Canvas) then
        Canvas.Font.Name:=LMD_DEFAULTFONT;
      flags:=DrawTextBiDiModeFlags(DT_SINGLELINE);
      if not (toShowAccelChar in FOptions) then
        flags := flags or DT_NOPREFIX;

      if FTabPosition in [tpLeft, tpRight] then
        FFont3D.Angle:=90
      else
        begin
          flags := flags or DT_LEFT or DT_VCENTER;
          FFont3D.Angle:=0;
        end;

      LMDDrawTextCalc (GetTabText(Index), FFont3D, aRect, Canvas.Font, false, true, 0, flags);
      if FTabPosition in [tpLeft, tpRight] then
        result:=LMDRectHeight(aRect)+1
      else
        result:=LMDRectWidth(aRect);

      inc(result, 8);
      if not IMLEmpty then
        Inc(result, FIntImageWidth+2*FImageGap);

      if UseThemeMode=ttmNone then
        case FTabStyle of
          tsButtons: Inc(result, 4);
          tsFlatButtons: Inc(result, 8);
        end;
      if result < FMinTabWidth then
        result := FMinTabWidth;
    end
  else
    begin
      result:=TabWidth;
    end;
end;

function TLMDCustomTabControl.GetThemedTabAreaColor: TColor;
var
  b:    TBitmap;
  r:    TRect;
  dtls: TThemedElementDetails;
begin
  if not LMDThemeServices.ThemesEnabled then
  begin
    Result := clInfoBk;
    Exit;
  end;

  b := TBitmap.Create;
  try
    b.Width  := 16;
    b.Height := 16;
    r        := Rect(0, 0, b.Width, b.Height);

    dtls := LMDThemeServices.GetDetails(teTab, Ord(ttPane));
    LMDThemeServices.DrawElement(ttmPlatform, b.Canvas.Handle, dtls, r);
    Result := b.Canvas.Pixels[8, 8];
  finally
    b.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.HasVisibleTabs: Boolean;
var
  i:Integer;
begin
  result:=false;
  for i:=0 to GetTabCount-1 do
    if GetVisible(i) then
      begin
        result:=True;
        break;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.IMLEmpty: Boolean;
begin
  result:=not ((ImageList<>nil) and (LMDIMLCount(ImageList, ListIndex)>0));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.Loaded;
begin
  inherited;
  UpdateIntImageValues;
  if (not StartFirstPage) and (TabIndex<>-1) and not TabShowing(Tabindex) then
    MakeTabVisible(TabIndex);
  ReAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pi:Integer;
  Form: TCustomForm;
  LPoint: TPoint;
begin
  inherited;
  if Button = mbLeft then
  begin
    pi:=Ord(KindofButtonAt(X, Y));
    if pi=0 then
      begin
        pi := IndexOfTabAt(X, Y);
        if (pi<>-1) and (TabIndex<>pi) then
          begin
            TabIndex:=pi;
            FDownButton := tbkTab;
            if csDesigning in ComponentState then
              begin
                Form := GetParentForm(Self);
                if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
              end;
          end;
      end
    else
      if not (csDesigning in ComponentState) then
        begin
          if FEnabledButton[TLMDTabButtonKind(pi)] then
            begin
              FDownButton := TLMDTabButtonKind(pi);
              if FDownButton in [tbkScrollLeft, tbkScrollRight] then
                begin
                  if FDownButton = tbkScrollLeft then
                    ScrollTabs(-1)
                  else
                    ScrollTabs(1);
                  AddTimer;
                  FTimer.Interval:=FTimerInterval+200;
                  FTimer.Enabled:=True;
                end
              else
                UpdateButton(FDownButton);
            end;
        end;
  end;
  if Button = mbRight then
  begin
    if Assigned(FTabMenu) then
    begin
      pi := Ord(KindofButtonAt(X, Y));
      if pi = 0 then
      begin
        pi := IndexOfTabAt(X, Y);
        if (pi <> -1) then
        begin
          if (TabIndex <> pi) then
          begin
            TabIndex := pi;
            FDownButton := tbkTab;
            if csDesigning in ComponentState then
            begin
              Form := GetParentForm(Self);
              if (Form <> nil) and (Form.Designer <> nil) then
                Form.Designer.Modified;
            end;
          end;
          LPoint := ClientToScreen(Point(X, Y));
          FTabMenu.PopupComponent := GetTabMenuPopupComponent;
          FTabMenu.Popup(LPoint.X, LPoint.Y);
        end;
      end;
    end;
  end;
  if csDesigning in ComponentState then exit;
  if TabStop and CanFocus then
    if not Focused then self.SetFocus;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  pi:Integer;
begin
  inherited;
  if ([csDesigning]*ComponentState=[]) then
    begin
      pi:=Ord(KindofButtonAt(X, Y));
      if pi>0 then
        begin
          if FHotTrack and FEnabledButton[TLMDTabButtonKind(pi)] and (TLMDTabButtonKind(pi)<>FHotButton) then
            begin
              UpdateButton(FHotButton);
              UpdateButton(TLMDTabButtonKind(pi));
              FHotButton:=TLMDTabButtonKind(pi);
              FHotTabIndex:=-1;
            end;
          exit;
        end
      else
        if FDownButton in [tbkClose, tbkScrollLeft, tbkScrollRight] then
          begin
            UpdateButton(FDownButton);
            FDownButton:=tbkNone;
          end;
      if not FHotTrack then exit;
      pi := IndexOfTabAt(X, Y);
      if (pi>-1) then
        begin
          if (FHotButton<>tbkTab) or (FHotTabIndex<>pi) then
            begin
              UpdateButton(FHotButton);
              UpdateButton(tbkTab, pi);
              FHotButton:=tbkTab; FHotTabIndex:=pi;
            end;
          exit;
        end;
      UpdateButton(FHotButton);
      FHotButton:=tbkNone; FHotTabIndex:=-1;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if FDownButton <> tbkNone then
    begin
      if not (csDesigning in ComponentState) then
        case KindOfButtonAt(X, Y) of
          tbkClose:
            if GetTabIndex<>-1 then
              DoPageClose(GetTabIndex);
        end;
      if (FHotButton=FDownButton) and not FEnabledButton[FHotButton] then
        FHotButton:=tbkNone;
      UpdateButton(FDownButton);
    end;
  FDownButton := tbkNone;
  RemoveTimer;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.MouseExit;
begin
  inherited;
  if (FHotButton=tbkNone) or not FHottrack then exit;
  UpdateButton(FHotButton);
  FHotButton := tbkNone;
  FHotTabIndex := -1;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.UpdateButton(Kind: TLMDTabButtonKind; Index:Integer=-1);
var
  aRect: TRect;
begin
  case kind of
    tbkTab:
      begin
        if index=-1 then index := FHotTabIndex;
        if index=-1 then
          exit
        else
          aRect:=TabRect(index);
      end;
    tbkClose, tbkScrollLeft, tbkScrollRight: aRect := GetButtonRect(Kind);
  else
    exit;
  end;
  InvalidateRect(Handle, @aRect, False);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.UpdateIntImageValues;
begin
  if IMLEmpty then
    begin
      FIntImageHeight:=-1;
      FIntImageWidth:=-1;
    end
  else
    begin
      FIntImageWidth:=LMDIMLItemWidth(ImageList, ListIndex);
      FIntImageHeight:=LMDIMLItemHeight(ImageList, ListIndex);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.UpdateTab(const index: Integer);
var
  tmp:Integer;
  aRect:TRect;
begin
  if index=-2 then
    aRect:=FTabRect //GetTabAreaRect
  else
    begin
      tmp:=GetShownTabIndex(index);
      if tmp=-1 then exit;
      aRect:=TabRect(tmp); //
    end;
  LMDAdjustRectExt(aRect, -2*Ord(FTabPosition=tpRight), -2*Ord(FTabPosition=tpBottom),
                          2*Ord(FTabPosition=tpLeft), 2*Ord(FTabPosition=tpTop));
  InvalidateRect(Handle, @aRect, False);
end;

{----------------------- public -----------------------------------------------}
constructor TLMDCustomTabControl.Create(AOwner: TComponent);
begin
  inherited;
  //ControlStyle := ControlStyle + [csAcceptsControls, csOpaque]-[csParentBackground];
  ControlStyle := ControlStyle + [csAcceptsControls, csOpaque]{$IFDEF LMDCOMP7}-[csParentBackground]{$ENDIF};
  {$IFNDEF LMDCOMP7}
  ParentBackground := false; 
  {$ENDIF}
  inherited AutoFocus := false;
  inherited TabStop := true;
  {$IFNDEF LMDCOMP11}
  inherited DoubleBuffered := true;
  {$ENDIF}
  FTabAlignment := agCenterLeft;
  FTabBkColor:=clBtnFace;
  FMinTabWidth:=40;
  FShowTabs:=True;
  FDownButton := tbkNone;
  FHotButton := tbkNone;
  FHotColor := clHighLight;
  FTimerInterval := 100;
  FHotTabIndex := -1;
  FRaggedRight := true;
  FThemeMode := ttmPlatform;
  FOptions := def_LMDTABOptions;
  FTabList:=TLMDObjectList.Create;
  FTabList.AutoClearObjects := True;
//  FXPCloseTheme:=0;
//  FXPScrollTheme:=0;

  FIntImageHeight:=-1;
  FIntImageWidth:=-1;
  FImageGap := def_ImageGap;

  FFont3D := TLMDFxCaption.Create;
  //FFont3D.OnChange := GetChange;

  // --> global bitmap
  FCloseBtnBitmap := TBitmap.Create;
  LMDGetSysButton(FCloseBtnBitmap);
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomTabControl.Destroy;
begin
  RemoveTimer;
  FFont3D.OnChange := nil;
  FreeAndNil(FFont3D);
  FreeAndNil(FTabList);
  FreeAndNil(FCloseBtnBitmap);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.ScrollTabs(Delta: Integer);
var
  i, j:integer;
begin
  if FMultiline or (Delta=0) then exit;
  j:=0; i:=FFirstTab;
  if (Delta<0) then
    begin
      if CanScroll(tbkScrollLeft) then
        for i:=FFirstTab-1 downto 0 do
          begin
            if GetVisible(i) then Dec(j);
            if j=delta then break;
          end
    end
  else
    if CanScroll(tbkScrollRight) then
      for i:=FFirstTab+1 to GetTabCount-1 do
        begin
          if GetVisible(i) then Inc(j);
          if j=delta then break;
        end;
  FFirstTab:=i;
  RePaint;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.TabRect(Index: Integer): TRect;
var
  i:Integer;
begin
  SetRectEmpty(result);
  for i:=0 to FTabList.Count-1 do
    if Index=TLMDTabListItem(FTabList[i]).RefIndex then
      begin
        result:=TLMDTabListItem(FTabList[i]).pRect;
        exit;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.TabShowing(Index: Integer): Boolean;
begin
  result:=GetShownTabIndex(Index)<>-1;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetHitTestInfoAt(X, Y: Integer): THitTests;
begin
  result := [];
  if PtInRect(ClientRect, Point(X, Y)) then
    if IndexOfTabAt(X, Y)=-1 then
      Include(result, htNowhere)
    else
      Include(result, htOnItem);
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.IndexOfTabAt(X, Y: Integer): Integer;
var
  i: Integer;
begin
  result:=-1;
  if not PtInRect(FTabRect, Point(X, Y)) then exit;
  for i:=0 to FTabList.Count-1 do
    with TLMDTabListItem(FTabList[i]) do
      if PtInRect(pRect, Point(X,Y)) then
        begin
          result:=RefIndex;
          break;
        end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.IndexOfTabByCaption(
  aTabCaption: TLMDString): Integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to Count - 1 do
    if Sheet[i].Caption = aTabCaption then
    begin
      result := i;
      break;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.IndexOfTabByName(aTabName: TLMDString): Integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to Count - 1 do
    if Sheet[i].Name = aTabName then
    begin
      result := i;
      break;
    end;
end;


{ ********************* TLMDTabControl ****************************************}
{----------------------- private ----------------------------------------------}
procedure TLMDTabControl.SetTabIndex(const Value: Integer);
var
  tmp:Boolean;
begin
  if FTabIndex<>Value then
    begin
      if ([csLoading, csDestroying, csReading]*ComponentState=[]) then
        begin
          tmp := true;
          If Assigned(FOnChanging) then
            FOnChanging(self, tmp);
          if not tmp then exit;
        end;
      FTabIndex := Value;
      if FTabIndex>FTabs.Count-1 then
        FTabIndex:=FTabs.Count-1;
      if (FTabIndex<>-1) and not FMultiline then
        MakeTabVisible(FTabIndex);
      if ([csLoading, csDestroying, csReading]*ComponentState=[]) then
        begin
          If Assigned(OnChange) then
            OnChange(self);
          GetChange(nil);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTabControl.SetTabs(const Value: TStrings);
begin
  FTabs.Assign(Value);
end;

{----------------------- protected --------------------------------------------}
procedure TLMDTabControl.DoPageChange(NewPage: TLMDCustomSheet; var Cancel: Boolean);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDTabControl.DoPageClose(PageIndex: Integer);
begin
  if Assigned(FOnCloseEvent) then
    FOnCloseEvent(self, PageIndex);
  FTabs.Delete(PageIndex);
  if PageIndex<GetTabCount then
    TabIndex:=PageIndex
  else
    TabIndex:=GetTabCount-1;
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
function TLMDTabControl.GetSheetClass: TLMDSheetClass;
begin
  result:=nil;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTabControl.GetTabGap: Integer;
begin
  // certain gap between different tabs
  result:=0;
  if UseThemeMode=ttmNone then
    case FTabStyle of
      tsButtons: result:=3;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDTabControl.GetTabCount: Integer;
begin
  result:=FTabs.Count;
end;

{------------------------------------------------------------------------------}
function TLMDTabControl.GetTabIndex: Integer;
begin
  result:=FTabIndex;
end;

{------------------------------------------------------------------------------}
function TLMDTabControl.GetTabMenuPopupComponent: TComponent;
begin
  Result := Self;
end;

{------------------------------------------------------------------------------}
function TLMDTabControl.GetTabColor(Index: Integer): TColor;
begin
  result:=self.color;
  if Assigned(FOnTabGetColor) then
    FOnTabGetColor(self, index, result);
end;

{------------------------------------------------------------------------------}
function TLMDTabControl.GetTabEnabled(Index: Integer): Boolean;
begin
  result:=true;
  if Assigned(FOnTabGetEnabled) then
    FOnTabGetEnabled(self, index, result);
end;

{------------------------------------------------------------------------------}
function TLMDTabControl.GetTabText(Index: Integer): String;
begin
  result:=FTabs[Index];
end;

{------------------------------------------------------------------------------}
function TLMDTabControl.GetVisible(Index: Integer): Boolean;
begin
  result:=true; // in TabControl all tabs are visible
end;

{------------------------------------------------------------------------------}
function TLMDTabControl.GetVisibleCount: Integer;
begin
  result:=FTabs.Count;
end;

{------------------------------------------------------------------------------}
function TLMDTabControl.NextTab:Boolean;
var
  tmp:Integer;
begin
  tmp:=TabIndex;
  if (tmp < FTabs.Count) and (FTabs.Count>0) then
    TabIndex := tmp + 1;
  result:=TabIndex <> tmp;
end;

{------------------------------------------------------------------------------}
function TLMDTabControl.PrevTab:Boolean;
var
  tmp:Integer;
begin
  tmp:=TabIndex;
  if tmp > 0 then
    TabIndex := tmp -1;
  result:=TabIndex <> tmp;
end;

{----------------------- public -----------------------------------------------}
constructor TLMDTabControl.Create(AOwner: TComponent);
begin
  inherited;
  FTabs := TStringList.Create;
  TStringList(FTabs).OnChange:=GetChange;
  FTabIndex:=-1;
end;

{------------------------------------------------------------------------------}
destructor TLMDTabControl.Destroy;
begin
  TStringList(FTabs).OnChange:=nil;
  FreeAndNil(FTabs);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDTabControl.FirstPage;
begin
  if FTabs.Count>0 then
   TabIndex:=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDTabControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: Integer;
  Control: TControl;
begin
  for i := 0 to ControlCount - 1 do
    begin
      Control := Controls[i];
      if Control.Owner = Root then Proc(Control);
    end;
end;

{************************ Object TLMDPageControl ******************************}
{----------------------------- private ----------------------------------------}
procedure TLMDPageControl.SetActivePage(aValue: TLMDTabSheet);
begin
  ActiveSheet:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.SetActivePageIndex(const Value: Integer);
begin
  TabIndex:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.SetTabIndex(const Value: Integer);
begin
  Self.PageIndex := Value;
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.GetPage(Index: Integer): TLMDTabSheet;
begin
  Result:=TLMDTabSheet(Sheet[Index]);
end;

{----------------------- protected --------------------------------------------}
function TLMDPageControl.GetPageFromDockClient(Client: TControl): TLMDTabSheet;
var
  i: integer;
begin
  Result := nil;
  if Client = nil then
  begin
    result := nil;
    exit;
  end;
  for i := 0 to PageCount - 1 do
  begin
    if (Client.Parent = Pages[i]) and (Client.HostDockSite = Self) then
    begin
      Result := Pages[i];
      exit;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.CMDockNotification(var Message: TCMDockNotification);
var
  I: integer;
  S: string;
  LPage: TLMDTabSheet;
begin
  LPage := GetPageFromDockClient(Message.Client);
  if LPage <> nil then
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
          LPage.Caption := S;
        end;
      CM_VISIBLECHANGED:
        LPage.TabVisible := Boolean(Message.NotifyRec.MsgWParam);
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.AddPage: TLMDTabSheet;
var
  LTabSheet: TLMDTabSheet;
begin
  LTabSheet := TLMDTabSheet(GetSheetClass.Create(Owner));
  LTabSheet.PageControl := Self;
  ActivePage := LTabSheet;
  Result := LTabSheet;
end;

{------------------------------------------------------------------------------}

procedure TLMDPageControl.CMDockClient(var Message: TCMDockClient);

var
  LIsVisible: Boolean;
  LDockCtl: TControl;
begin
  Message.result := 0;
  FDockMouseDown := False;
  FNewDockSheet := TLMDTabSheet.Create(Self);
  try
    try
      LDockCtl := Message.DockSource.Control;
      if LDockCtl is TCustomForm then
        FNewDockSheet.Caption := TCustomForm(LDockCtl).Caption;
      FNewDockSheet.PageControl := Self;
      LDockCtl.Dock(Self, Message.DockSource.DockRect);
      except
      FNewDockSheet.Free;
      raise;
    end;
    LIsVisible := LDockCtl.Visible;
    FNewDockSheet.TabVisible := LIsVisible;
    FNewDockSheet.Caption := LDockCtl.Name;
    if LIsVisible then
      ActivePage := FNewDockSheet;
    LDockCtl.Align := alClient;
  finally
    FNewDockSheet := nil;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDPageControl.CMUnDockClient(var Message: TCMUnDockClient);

var
  LPage: TLMDTabSheet;
begin
  inherited;
  Message.result := 0;
  LPage := GetPageFromDockClient(Message.Client);
  if LPage <> nil then
    begin
      FUndockingPage := LPage;
      Message.Client.Align := alNone;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.DoAddDockClient(Client: TControl; const ARect: TRect);
begin
  if FNewDockSheet <> nil then
    Client.Parent := FNewDockSheet;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.DockOver(Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
var
  R: TRect;
begin
  DoDockOver(Source, X, Y, State, Accept);
  if Accept then
  begin
    GetWindowRect(Handle, R);
    Source.DockRect := R;
  end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.DoPageChange(NewPage: TLMDCustomSheet; var Cancel: Boolean);
var
  tmp:boolean;
begin
  if ([csLoading, csDestroying, csReading]*ComponentState=[]) then
    begin
      if Assigned(FOnPageChanging) then
        FOnPageChanging(self, TLMDTabSheet(NewPage), Cancel)
      else
        if Assigned(FOnChanging) then
          begin
            tmp := not Cancel;
            FOnChanging(self, tmp);
            Cancel := not tmp;
          end;
    end;
  if Cancel or FMultiline then exit;
  MakeTabVisible(Sheets.IndexOf(NewPage));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.MakeTabVisible(TabIndex: Integer);
var
  i, pos, ifiR, tw, firstinrow, maxWidth, tabGap:Integer;
begin
  maxWidth:=GetButtonAreaStart;
  if (GetTabsWidth<maxWidth) then
    begin
      FFirstTab:=0;
      exit;
    end;
  if (TabIndex=-1) or TabShowing(TabIndex) then exit;
  // 0..FirstTab..GetTabCount-1
  // i=loop variable, ic=Number tabs, j: counts number of checked items
  pos:=0; firstinrow:=0; ifir:=0; tabGap:=GetTabGap;
  for i:=0 to GetTabCount-1 do
    if (GetSheetClass=nil) or GetVisible(i) then
      begin
        tw := GetTabWidth(i)+tabGap;
        if pos + tw > maxWidth then       // extends with?
          begin
            pos:=0; ifir:=i;
          end;
        if (i=TabIndex) then
          begin
            firstinrow:=ifir; break;
          end;
        Inc(pos, tw);
      end;
  FFirstTab:=firstinRow;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.AddTimer;
begin
  if Assigned(FTimer) then exit;
  {get a global timer-id}
  FTimer:=TTimer.Create(nil);
  FTimer.Enabled:=False;
  FTimer.OnTimer:=TimerExpired;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTabControl.RemoveTimer;
begin
  If Assigned(FTimer) then
    FreeAndNil(FTimer);
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.DoPageClose(PageIndex: Integer);
var
  Cancel:Boolean;
begin
  Cancel:=false;
  if Assigned(FOnPageClose) then
    FOnPageClose(self, Pages[PageIndex], Cancel);
  if Cancel then exit;
  if FXPages then
    FreePage(Pages[PageIndex])
  else
    Pages[PageIndex].TabVisible:=false;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.DoRemoveDockClient(Client: TControl);
var
  LPage: TLMDTabSheet;
begin
  if (FUndockingPage <> nil) and not (csDestroying in ComponentState) then
    begin
      if ActivePageIndex < PageCount - 1 then
        LPage := TLMDTabSheet(FindNextPage(ActivePage, true, true))
      else
        LPage := TLMDTabSheet(FindNextPage(ActivePage, False, true));
      FUndockingPage.Free;
      FUndockingPage := nil;
      ActivePage := LPage;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.GetActivePage: TLMDTabSheet;
begin
  result:=TLMDTabSheet(ActiveSheet);
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.GetActivePageIndex: Integer;
begin
  result:=TabIndex;
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.GetDockClientFromMousePos(MousePos: TPoint): TControl;
var
  LPage: TLMDTabSheet;
begin
  Result := nil;
  if DockSite then
    begin
      LPage := PageAt(MousePos.X, MousePos.Y);
      if (LPage <> nil) and (LPage.ControlCount > 0) then
        begin
          Result := LPage.Controls[0];
          if Result.HostDockSite <> Self then
            Result := nil;
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.GetSheetClass: TLMDSheetClass;
begin
  result:=TLMDTabSheet;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.GetSiteInfo(Client: TControl; var InfluenceRect: TRect; MousePos: TPoint;
  var CanDock: Boolean);
begin
  CanDock := GetPageFromDockClient(Client) = nil;
  inherited GetSiteInfo(Client, InfluenceRect, MousePos, CanDock);
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.GetTabCount: Integer;
begin
  result:=Count;
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.GetTabColor(Index: Integer): TColor;
begin
  if IsThemed and Pages[Index].ParentBackground then
    result := self.Color
  else
    result:=Pages[Index].Color;
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.GetTabEnabled(Index: Integer): Boolean;
begin
  result:=Pages[Index].TabEnabled;
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.GetTabText(Index: Integer): String;
begin
  result:=Pages[Index].Caption;
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.GetTabIndex: Integer;
begin
  result := -1;
  if Assigned(ActiveSheet) then result:=ActiveSheet.PageIndex;
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.GetTabMenuPopupComponent: TComponent;
begin
  Result := ActivePage;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DockCtl:TControl;
begin
  inherited;
//  if FDownButton <> tbkTab then exit; --> Clicks on Scroll-/Close Buttons need not to be checked
  DockCtl := GetDockClientFromMousePos(Point(X, Y));
  if DockCtl = nil then exit;
  if ssDouble in Shift then
    DockCtl.BeginDrag(True);
  FDockMouseDown := True;
  FDockMousePos := Point(X, Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.MouseExit;
begin
  inherited;
  if FDockMouseDown then
    FDockMouseDown := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  LDockCtl: TControl;

  function GetDistance(AFirstPoint, ASecondPoint: TPoint): Integer;
  begin
    Result := Round(Sqrt(sqr(ASecondPoint.X - AFirstPoint.X) + sqr(ASecondPoint.Y - AFirstPoint.Y)));
  end;

begin
  inherited;
  if FDockMouseDown then
    begin
      LDockCtl := GetDockClientFromMousePos(Point(X, Y));
      if (LDockCtl <> nil) and (GetDistance(FDockMousePos, Point(X, Y)) >= 5) then
        LDockCtl.BeginDrag(False);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FDockMouseDown := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.MovePage(OldIndex, NewIndex: Integer);
begin
  inherited;
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.NextTab:Boolean;
var
  tmp:TLMDCustomSheet;
begin
  result:=false;
  tmp:=FindNextPage(ActiveSheet, true, true);
  if Assigned(tmp) then
    begin
      TabIndex := tmp.PageIndex;
      result:=true;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.PageAt(const X, Y: Integer): TLMDTabSheet;
var
  LPageIndex: Integer;
begin
  Result := nil;
  LPageIndex := IndexOfTabAt(X, Y);
  if (LPageIndex > -1) and (LPageIndex < PageCount) then
    Result := Pages[LPageIndex];
end;

{------------------------------------------------------------------------------}
function TLMDPageControl.PrevTab:Boolean;
var
  tmp:TLMDCustomSheet;
begin
  result:=false;
  tmp := FindNextPage(ActiveSheet, false, true);
  if Assigned(tmp) then
    begin
      TabIndex := tmp.PageIndex;
      result:=true;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPageControl.RemovePage(const AIndex: Integer);
var
  LTabSheet: TLMDTabSheet;
begin
  LTabSheet := Pages[AIndex];
  if Assigned(LTabSheet) then
  begin
    LTabSheet.PageControl := nil;
    LTabSheet.Free;
  end;
end;

{----------------------- public -----------------------------------------------}
constructor TLMDPageControl.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csDoubleClicks {$IFDEF LMDCOMP10}, csPannable{$ENDIF}];
  FXPages := true;
  FDockMouseDown := False;
  if FDefaultPage <> nil then
    ActivePage := FDefaultPage;
  if not tsRegistered then
  begin
    RegisterClass(TLMDTabSheet);
    tsRegistered:=true;
  end;
end;

{------------------------------------------------------------------------------}
destructor TLMDPageControl.Destroy;
begin
  inherited;
end;

initialization
  tsRegistered:=False;
end.
