unit ElTrayInfo;
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

ElTrayInfo unit
---------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Math, Classes, Controls, Forms,
  Buttons, Menus, ExtCtrls, Types, Themes, StdCtrls, Graphics,

  LMDUtils, LMDDebugUnit, LMDSysIn, ElVCLUtils, ElHTMLLbl,
  LMDObjectList,  LMDProcs, LMDGraph, LMDGlyphs,
  LMDClass, LMDThemes, LMDTypes, LMDHTMLUnit,

  ElPopBtn, ElImgLst,  ElTopmost, ElComponent, ElCLabel,
  ElMenus, ElLabel, ElPanel;

type
  TElTrayInfoType = (titInformation, titWarning, titError, titNone);

type
  TElCanDeleteMessageEvent = procedure(Sender: TObject; const Index: Integer; var CanDelete: Boolean) of object;

type
  TElTrayInfo = class;
  TElTrayMessageList = class;

  TElTrayMessage = class(TCollectionItem)
  private
    FGlyph: TBitmap;
    FGradientEndColor: TColor;
    FGradientStartColor: TColor;
    FIsHtml: Boolean;
    FText: TLMDString;

    procedure SetGradientEndColor(const Value: TColor);
    procedure SetGradientStartColor(const Value: TColor);
    procedure SetIsHtml(const Value: Boolean);
    procedure SetText(const Value: TLMDString);
    procedure SetGlyph(const Value: TBitmap);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property GradientStartColor: TColor read FGradientStartColor write SetGradientStartColor;
    property GradientEndColor: TColor read FGradientEndColor write SetGradientEndColor;
    property IsHTML: Boolean read FIsHtml write SetIsHtml;
    property Text: TLMDString read FText write SetText;
  end;

  TElTrayMessageList = class(TCollection)
  private
    FTrayInfo: TElTrayInfo;
    function Get(Index: Integer): TElTrayMessage;
    procedure Put(Index: Integer; const Value: TElTrayMessage);
    procedure RebuildPopupMenu;
  protected
    procedure Update(Item: TCollectionItem); override;
    //procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    procedure AClick(Sender: TObject);
  public
    function Add: TElTrayMessage;
    property Items[Index: Integer]: TElTrayMessage read Get write Put;
  end;

  TElTrayVisualScheme = class(TPersistent)
  private
    FName: TLMDString;
    FBorderColor: TColor;
    FWindowGradientEnd: TColor;
    FBarGradientStart: TColor;
    FWindowGradientStart: TColor;
    FBarGradientEnd: TColor;
    FButtonHoverGradientEnd: TColor;
    FButtonDownGradientEnd: TColor;
    FButtonHoverGradientStart: TColor;
    FButtonDownGradientStart: TColor;
    FBorderWidth: Integer;
    FOnChange: TNotifyEvent;
    FBackgroundType: TLMDBackgroundType;
    FBarHeight: Integer;
    FBarPosition: TTaskbarEdge;
    procedure SetBackgroundType(const Value: TLMDBackgroundType);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderWidth(const Value: Integer);
    procedure SetButtonDownGradientEnd(const Value: TColor);
    procedure SetButtonDownGradientStart(const Value: TColor);
    procedure SetButtonHoverGradientEnd(const Value: TColor);
    procedure SetButtonHoverGradientStart(const Value: TColor);
    procedure SetBarGradientEnd(const Value: TColor);
    procedure SetBarGradientStart(const Value: TColor);
    procedure SetWindowGradientEnd(const Value: TColor);
    procedure SetWindowGradientStart(const Value: TColor);
    procedure SetBarHeight(const Value: Integer);
    procedure SetBarPosition(const Value: TTaskbarEdge);
  protected
    procedure TriggerChangeEvent; virtual;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Name: TLMDString read FName write FName;
    property BackgroundType: TLMDBackgroundType read FBackgroundType write SetBackgroundType;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth;

    property BarPosition: TTaskbarEdge read FBarPosition write SetBarPosition;
    property BarHeight: Integer read FBarHeight write SetBarHeight;
    property ButtonHoverGradientStart: TColor read FButtonHoverGradientStart write SetButtonHoverGradientStart;
    property ButtonHoverGradientEnd: TColor read FButtonHoverGradientEnd write SetButtonHoverGradientEnd;
    property ButtonDownGradientStart: TColor read FButtonDownGradientStart write SetButtonDownGradientStart;
    property ButtonDownGradientEnd: TColor read FButtonDownGradientEnd write SetButtonDownGradientEnd;
    property WindowGradientStart: TColor read FWindowGradientStart write SetWindowGradientStart;
    property WindowGradientEnd: TColor read FWindowGradientEnd write SetWindowGradientEnd;
    property BarGradientStart: TColor read FBarGradientStart write SetBarGradientStart;
    property BarGradientEnd: TColor read FBarGradientEnd write SetBarGradientEnd;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TElAdvButton = class(TCustomElPanel)
  private
    FDown: Boolean;
    FHover: Boolean;
    FGlyph: TLMDButtonGlyph;
    FDownGradientEndColor: TColor;
    FHoverGradientStartColor: TColor;
    FHoverGradientEndColor: TColor;
    FBorderColor: TColor;
    FDownGradientStartColor: TColor;
    FCaption: TLMDString;
    function GetGlyph: TBitmap;
    procedure SetGlyph(const Value: TBitmap);
    procedure SetBorderColor(const Value: TColor);
    procedure SetDownGradientEndColor(const Value: TColor);
    procedure SetDownGradientStartColor(const Value: TColor);
    procedure SetHoverGradientEndColor(const Value: TColor);
    procedure SetHoverGradientStartColor(const Value: TColor);
  protected
    procedure SetCaption(Value: TLMDString); override;
    procedure TriggerPaintEvent; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseEnter(Sender: TObject);
    procedure MouseLeave(Sender: TObject);
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
  published
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property Caption: TLMDString read FCaption write SetCaption;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property HoverGradientStartColor: TColor read FHoverGradientStartColor write SetHoverGradientStartColor;
    property HoverGradientEndColor: TColor read FHoverGradientEndColor write SetHoverGradientEndColor;
    property DownGradientStartColor: TColor read FDownGradientStartColor write SetDownGradientStartColor;
    property DownGradientEndColor: TColor read FDownGradientEndColor write SetDownGradientEndColor;
    property OnClick;
  end;

  TTrayInfoForm = class(TForm)
    Timer: TTimer;
    Panel1: TElPanel;
    InfoLabel: TElHTMLLabel;
    Image1: TPaintBox;
    procedure TimerTimer(Sender: TObject);
    procedure ClickHandler(Sender: TObject);
    procedure DblClickHandler(Sender: TObject);
    procedure ShowHandler(Sender: TObject);
    procedure HideHandler(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Paint(Sender: TObject);
  private
    FShadowXP: Boolean;
    FBorderColor: TColor;
    FBarHeight: Integer;
    FBarPosition: TTaskbarEdge;
    FBorderWidth: Integer;
    FBarGradientStart: TColor;
    FBarGradientEnd: TColor;
    FSaveState: Boolean;
  protected
    procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetShadowXP(const Value: Boolean);
    procedure Paint; override;
    procedure DoDestroy; override;
  protected
    FOnShow,
    FOnHide,
    FOnClick,
    FOnDblClick : TNotifyEvent;
    FPages: TElLabel;

    FGlyph: TLMDButtonGlyph;
    FCloseBtn: TElAdvButton;
    FNextBtn: TElAdvButton;
    FPrevBtn: TElAdvButton;
    FDeleteBtn: TElAdvButton;
    FMenuBtn: TElAdvButton;
    FTopmost : TElTopmost;

    procedure CreateParams(var Params: TCreateParams); override;

    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  public
    property ShadowXP: Boolean read FShadowXP write SetShadowXP;
  end;

  TElTrayInfo = class(TElComponent)
  private
    FIsHTML : Boolean;
    FInfoForm : TTrayInfoForm;
    FShowTime : Cardinal;
    FInfoType : TElTrayInfoType;
    FMessage  : TLMDString;
    FColor    : TColor;
    FShowCloseButton : boolean;
    FOnImageNeeded : TElHTMLImageNeededEvent;
    FOnLinkClick   : TElHTMLLinkClickEvent;
    FShadowXP: Boolean;
    FOnShow,
    FOnHide,
    FOnClick,
    FOnDblClick : TNotifyEvent;

    FMsgs: TElTrayMessageList;
    FCurrentMsg: Integer;
    FPopupMenu: TElPopupMenu;

    FOnPrevMessage: TNotifyEvent;
    FOnNextMessage: TNotifyEvent;
    FOnPopupClick: TNotifyEvent;
    FOnCanDeleteMessage: TElCanDeleteMessageEvent;

    FVisualSchemeList: TLMDObjectList;
    FVisualScheme: TElTrayVisualScheme;
    FShowNavPanel: Boolean;
    FShowMenuButton: Boolean;
    FShowDeleteButton: Boolean;
    FFormatOfNavigation: TLMDString;

    FFormWidth: Integer;
    FFormHeight: Integer;

    procedure PrepareInfoForm;
    procedure FixTopbarPos; virtual;
    procedure SetVisualScheme(const Value: TElTrayVisualScheme);
    procedure HandlerChangeVisualScheme(Sender: TObject);
    procedure SetShowNavPanel(const Value: Boolean);
    procedure SetFormatOfNavigation(const Value: TLMDString);
    procedure CloseBtnClick(Sender : TObject);
    procedure NextBtnClick(Sender : TObject);
    procedure PrevBtnClick(Sender : TObject);
    procedure MenuBtnClick(Sender : TObject);
    procedure DeleteBtnClick(Sender : TObject);
    procedure SetShowDeleteButton(const Value: Boolean);
    procedure SetShowMenuButton(const Value: Boolean);
    function GetVisible: Boolean;
  protected
    FFont: TFont;
    FParentFont: Boolean;
    procedure SetShowTime(newValue : Cardinal); virtual;
    procedure SetInfoType(newValue : TElTrayInfoType); virtual;
    procedure SetMessage(newValue: TLMDString); virtual;
    procedure AdjustFormIcon;
    procedure AdjustFormSize(X, Y : integer);
    function SuggestedHeight : integer;
    function SuggestedWidth : integer;
    procedure SetIsHTML(newValue : Boolean); virtual;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure ClickHandler(Sender: TObject);
    procedure DblClickHandler(Sender: TObject);
    procedure ShowHandler(Sender: TObject);
    procedure HideHandler(Sender: TObject);
    procedure SetColor(Value : TColor);
    procedure SetFont(Value: TFont);
    procedure FontChange(Sender : TObject);
    procedure SetParentFont(Value: Boolean);
    procedure FillVisualStyles;
  public
    procedure SetMessageIndex(const Index: Integer);
    procedure Show;
    procedure Hide;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure ShowEx(X, Y : integer; AdjustY : boolean);
    procedure ChooseVisualScheme(AName: String);
    property InfoForm : TTrayInfoForm read FInfoForm;
    property Visible: Boolean read GetVisible;
  published
    property Color : TColor read FColor write SetColor default clInfoBk;
    property ShowTime : Cardinal read FShowTime write SetShowTime;  { Published }
    property InfoType : TElTrayInfoType read FInfoType write SetInfoType;  { Published }
    property Message: TLMDString read FMessage write SetMessage;
    property IsHTML   : Boolean read FIsHTML write SetIsHTML default false;  { Published }
    property ShowNavPanel: Boolean read FShowNavPanel write SetShowNavPanel;
    property ShowMenuButton: Boolean read FShowMenuButton write SetShowMenuButton;
    property ShowDeleteButton: Boolean read FShowDeleteButton write SetShowDeleteButton;
    property ShowCloseButton : boolean read FShowCloseButton write FShowCloseButton;
    property VisualScheme: TElTrayVisualScheme read FVisualScheme write SetVisualScheme;
    property FormatOfNavigation: TLMDString read FFormatOfNavigation write SetFormatOfNavigation;

    property Messages: TElTrayMessageList read FMsgs write FMsgs;

    property Width: Integer read SuggestedWidth write FFormWidth;
    property Height: Integer read SuggestedHeight write FFormHeight;

    property Font: TFont read FFont write SetFont;
    property ParentFont: Boolean read FParentFont write SetParentFont default true;

    property OnNextMessage: TNotifyEvent read FOnNextMessage write FOnNextMessage;
    property OnPrevMessage: TNotifyEvent read FOnPrevMessage write FOnPrevMessage;
    property OnPopupClick: TNotifyEvent read FOnPopupClick write FOnPopupClick;
    property OnCanDeleteMessage: TElCanDeleteMessageEvent read FOnCanDeleteMessage write FOnCanDeleteMessage;

    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
  end;

  TTrayInfoFormClass = class of TTrayInfoForm;

var

  TrayInfoFormClass: TTrayInfoFormClass = TTrayInfoForm;

implementation
uses
  LMDGraphUtils;

type

  TElTrayInfoCloseButton = class(TElGraphicButton)
  protected
    function GetDetails: TThemedElementDetails; override;
  end;

function TElTrayInfoCloseButton.GetDetails: TThemedElementDetails;
begin
  if not Enabled then
    Result := ThemeServices.GetElementDetails(twCloseButtonDisabled)
  else
  if FState in [ebsDown, ebsExclusive] then
    Result := ThemeServices.GetElementDetails(twCloseButtonPushed)
  else
  if FMouseInControl or FMouseInArrow or FInMenu then
    Result := ThemeServices.GetElementDetails(twCloseButtonHot)
  else
    Result := ThemeServices.GetElementDetails(twCloseButtonNormal);
end;

constructor TElTrayInfo.Create(AOwner : TComponent);
begin
  inherited;
  if LMDSIWindows2000Up then
    FShadowXP := True;
  FFont := Tfont.Create;
  FFont.OnChange := Fontchange;
  ParentFont := true;
  FColor := clInfoBk;
  FPopupMenu := TElPopupMenu.Create(nil{AOwner});
  FPopupMenu.DrawStyle := tdsOfficeXP;
  FPopupMenu.TrackButton := tbLeftButton;

  FFormWidth := 300;
  FFormHeight := 100;

  FCurrentMsg := -1;

  FVisualScheme := TElTrayVisualScheme.Create;
  FVisualSchemeList := TLMDObjectList.Create;

  FillVisualStyles;

  FFormatOfNavigation := '%d of %d';

  FMsgs := TElTrayMessageList.Create(TElTrayMessage);
  FMsgs.FTrayInfo := Self;

  if FInfoForm <> nil then
    FInfoForm.Panel1.Color := FColor;
end;

procedure TElTrayInfo.SetColor(Value : TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if FInfoForm <> nil then
      FInfoForm.Panel1.Color := FColor;
  end;
end;

procedure TElTrayInfo.SetShowTime(newValue : Cardinal);
{ Sets data member FShowTime to newValue. }
begin
  if (FShowTime <> newValue) then
  begin
    FShowTime := newValue;
  end;  { if }
end;  { SetShowTime }

procedure TElTrayInfo.SetInfoType(newValue : TElTrayInfoType);
{ Sets data member FInfoType to newValue. }
begin
  if (FInfoType <> newValue) then
  begin
    FInfoType := newValue;
    if (FInfoForm <> nil) and (FInfoForm.Visible) then
      Show;
  end;  { if }
end;  { SetInfoType }

procedure TElTrayInfo.SetMessage(newValue: TLMDString);
{ Sets data member FMessage to newValue. }
begin
  if (FMessage <> newValue) then
  begin
    FMessage := newValue;
    if (FInfoForm <> nil) and (FInfoForm.Visible) then
      FInfoForm.InfoLabel.Caption := FMessage;
//      Show;
 end;  { if }
end;  { SetMessage }

var
  AppWndProc : UniPtr;

function NoActWndProc(Window: HWND; Message, WParam: Longint;
                    LParam: Longint): Longint; stdcall;

begin
  if (Message = WM_ACTIVATEAPP) and (wParam = 1) then
  begin
    result := 0;
  end
  else
  if (Message = WM_WINDOWPOSCHANGING) then
  begin
    with PWindowPos(lParam)^ do
    flags := flags and (not SWP_SHOWWINDOW);
    result := 0;
    end
  else
    result := CallWindowProc(AppWndProc, Window, Message, wParam, lParam);
end;

procedure HookAppl;
begin
  AppWndProc := UniPtr(GetWindowLong(Application.Handle, GWL_WNDPROC));
  SetWindowLong(Application.Handle, GWL_WNDPROC, TLMDPtrUInt(@NoActWndProc));
end;

procedure UnHookAppl;
begin
  SetWindowLong(Application.Handle, GWL_WNDPROC, TLMDPtrUInt(AppWndProc));
end;

procedure TElTrayInfo.ChooseVisualScheme(AName: String);
var
  I: Integer;
begin
  for i := 0 to FVisualSchemeList.Count - 1 do
    if UpperCase(TElTrayVisualScheme(FVisualSchemeList.Items[i]).Name) = UpperCase(AName) then
      VisualScheme := TElTrayVisualScheme(FVisualSchemeList.Items[i]);
end;

procedure TElTrayInfo.Show;  { public }
var X,
    Y : integer;
    H1,
    H2 : HWND;
    R,
    R1 : TRect;
    TBarAlign : TTaskBarEdge;
    DesktopWidth,
    DesktopHeight : integer;
begin
  if (FMsgs.Count <= 0) and (Length(FMessage) = 0) then
    exit;

  PrepareInfoForm;

  H1 := FindWindow('Shell_TrayWnd', nil);
  if H1 <> 0 then
  begin
    H2 := FindWindowEx(H1, 0, 'TrayNotifyWnd', nil);
    if H2 <> 0 then
    begin
      R := GetWorkspaceRect;
      DesktopWidth  := R.Right;
      DesktopHeight := R.Bottom;

      GetWindowRect(H1, R1);
      GetWindowRect(H2, R);
      TBarAlign := GetTaskBarEdge;

      FInfoForm.InfoLabel.Caption := FMessage;

      case TBarAlign of
        tbeBottom: begin
             Y := R1.Top - SuggestedHeight;
             X := DesktopWidth - SuggestedWidth;
           end;
        tbeLeft: begin
             X := R1.Right;
             Y := DesktopHeight - SuggestedHeight;
           end;
        tbeTop: begin
             Y := R1.Bottom;
             X := DesktopWidth - SuggestedWidth;
           end;
        tbeRight: begin
             X := R1.Left - SuggestedWidth - 1;
             Y := DesktopHeight - SuggestedHeight - 1;
           end;
        else
           begin
             Y := R1.Top - SuggestedHeight;
             X := DesktopWidth - SuggestedWidth;
           end;
      end;
      ShowEx(X, Y, false);
    end;
  end;
end;  { Show }

procedure TElTrayInfo.Hide;  { public }
begin
  if FInfoForm <> nil then FInfoForm.Hide;
end;  { Hide }

procedure TElTrayInfo.AdjustFormIcon;  { protected }
var s : string;
begin
  case FInfoType of
    titInformation: s := 'HINTICONINFO';
    titWarning:     s := 'HINTICONWARNING';
    titError:       s := 'HINTICONERROR';
  end;
  if (FInfoForm <> nil) and (FInfoType <> titNone) then
    FInfoForm.FGlyph.Glyph.LoadFromResourceName(HInstance, s);
end;  { AdjustFormIcon }

function TElTrayInfo.SuggestedHeight: integer;
var
  LBarOffset: Integer;
begin
  Result := 0;
  if Assigned(FInfoForm) then
  begin
    LBarOffset := 0;
    case VisualScheme.BarPosition of
    tbeTop:
      LBarOffset := VisualScheme.BarHeight;
    tbeBottom:
      LBarOffset := VisualScheme.BarHeight
    end;
    Result := Max(20 + ((FInfoForm.Panel1.Height - FInfoForm.Panel1.ClientHeight) + LBarOffset) + (FInfoForm.FBorderWidth * 2),
                       ((FInfoForm.Panel1.Height - FInfoForm.Panel1.ClientHeight) + FInfoForm.InfoLabel.Height + 4) + LBarOffset + (FInfoForm.FBorderWidth * 2));
    if FShowNavPanel then
      Result := Result + Max(FInfoForm.FPages.Height, FInfoForm.FNextBtn.Height) + 5;
  end;
  Result := Max(Result, FFormHeight);
end;

function TElTrayInfo.SuggestedWidth : integer;
begin
  Result := 0;
  if Assigned(FInfoForm) then
  begin
    Result := (FInfoForm.Panel1.Width - FInfoForm.Panel1.ClientWidth) + 38 + FInfoForm.InfoLabel.Width + (FInfoForm.FBorderWidth * 2) + 1;
    if ShowCloseButton then
      Inc(Result, 20);
  end;
  Result := Max(Result, FFormWidth);
end;

procedure TElTrayInfo.HandlerChangeVisualScheme(Sender: TObject);
begin
  if Assigned(InfoForm) then
  begin
    InfoForm.Panel1.GradientStartColor := VisualScheme.WindowGradientStart;
    InfoForm.Panel1.GradientEndColor := VisualScheme.WindowGradientEnd;
    InfoForm.FBarGradientStart := VisualScheme.BarGradientStart;
    InfoForm.FBarGradientEnd := VisualScheme.BarGradientEnd;
    InfoForm.FBorderColor := VisualScheme.BorderColor;
    InfoForm.FBorderWidth := VisualScheme.FBorderWidth;
    InfoForm.FBarHeight := FVisualScheme.BarHeight;
    InfoForm.FBarPosition := FVisualScheme.BarPosition;

    InfoForm.FCloseBtn.HoverGradientEndColor := FVisualScheme.ButtonHoverGradientEnd;
    InfoForm.FCloseBtn.DownGradientEndColor := FVisualScheme.ButtonDownGradientEnd;
    InfoForm.FCloseBtn.HoverGradientStartColor := FVisualScheme.ButtonHoverGradientStart;
    InfoForm.FCloseBtn.DownGradientStartColor := FVisualScheme.ButtonDownGradientStart;
    InfoForm.FCloseBtn.BorderColor := FVisualScheme.BorderColor;

    InfoForm.FNextBtn.HoverGradientEndColor := FVisualScheme.ButtonHoverGradientEnd;
    InfoForm.FNextBtn.DownGradientEndColor := FVisualScheme.ButtonDownGradientEnd;
    InfoForm.FNextBtn.HoverGradientStartColor := FVisualScheme.ButtonHoverGradientStart;
    InfoForm.FNextBtn.DownGradientStartColor := FVisualScheme.ButtonDownGradientStart;
    InfoForm.FNextBtn.BorderColor := FVisualScheme.BorderColor;

    InfoForm.FPrevBtn.HoverGradientEndColor := FVisualScheme.ButtonHoverGradientEnd;
    InfoForm.FPrevBtn.DownGradientEndColor := FVisualScheme.ButtonDownGradientEnd;
    InfoForm.FPrevBtn.HoverGradientStartColor := FVisualScheme.ButtonHoverGradientStart;
    InfoForm.FPrevBtn.DownGradientStartColor := FVisualScheme.ButtonDownGradientStart;
    InfoForm.FPrevBtn.BorderColor := FVisualScheme.BorderColor;

    InfoForm.FDeleteBtn.HoverGradientEndColor := FVisualScheme.ButtonHoverGradientEnd;
    InfoForm.FDeleteBtn.DownGradientEndColor := FVisualScheme.ButtonDownGradientEnd;
    InfoForm.FDeleteBtn.HoverGradientStartColor := FVisualScheme.ButtonHoverGradientStart;
    InfoForm.FDeleteBtn.DownGradientStartColor := FVisualScheme.ButtonDownGradientStart;
    InfoForm.FDeleteBtn.BorderColor := FVisualScheme.BorderColor;

    InfoForm.FMenuBtn.HoverGradientEndColor := FVisualScheme.ButtonHoverGradientEnd;
    InfoForm.FMenuBtn.DownGradientEndColor := FVisualScheme.ButtonDownGradientEnd;
    InfoForm.FMenuBtn.HoverGradientStartColor := FVisualScheme.ButtonHoverGradientStart;
    InfoForm.FMenuBtn.DownGradientStartColor := FVisualScheme.ButtonDownGradientStart;
    InfoForm.FMenuBtn.BorderColor := FVisualScheme.BorderColor;

    FixTopbarPos;

    InfoForm.Invalidate;
  end;
end;

procedure TElTrayInfo.SetVisualScheme(const Value: TElTrayVisualScheme);
begin
  FVisualScheme.Assign(Value);
  HandlerChangeVisualScheme(Value);
end;

procedure TElTrayInfo.AdjustFormSize(X, Y : integer);  { protected }
var R : TRect;
    DesktopWidth,
    DesktopHeight  : integer;
begin
  if FInfoForm <> nil then
  begin
    R := GetWorkspaceRect;
    DesktopWidth  := R.Right;
    DesktopHeight := R.Bottom;

    R.Left := X;
    R.Top  := Y;
    R.Right := SuggestedWidth;
    R.Bottom := SuggestedHeight;

    if R.Left + R.Right > DesktopWidth then
                R.Left := DesktopWidth - R.Right;
    if R.Top + R.Bottom > DesktopHeight then
                R.Top := DesktopHeight - R.Bottom;

    with R do
      FInfoForm.SetBounds(Left, Top, Right, Bottom);
  end;
end;  { AdjustFormSize }

procedure TElTrayInfo.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FInfoForm) then
  begin
    FInfoForm.FOnClick := nil;
    FInfoForm.FOnDblClick := nil;
    FInfoForm.FOnShow := nil;
    FInfoForm.FOnHide := nil;

    FInfoForm := nil;
  end;
end;

procedure TElTrayInfo.SetIsHTML(newValue : Boolean);
{ Sets data member FIsHTML to newValue. }
begin
  if (FIsHTML <> newValue) then
  begin
    FIsHTML := newValue;
    if FInfoForm <> nil then
       FInfoForm.InfoLabel.IsHTML := newValue;
  end;  { if }
end;  { SetIsHTML }

procedure TElTrayInfo.SetShowNavPanel(const Value: Boolean);
begin
  if (FShowNavPanel <> Value) then
  begin
    FShowNavPanel := Value;
    if Assigned(FInfoForm) and (FInfoForm.Visible) then
      Show;
  end;
end;

procedure TElTrayInfo.SetShowDeleteButton(const Value: Boolean);
begin
  FShowDeleteButton := Value;
end;

procedure TElTrayInfo.SetShowMenuButton(const Value: Boolean);
begin
  FShowMenuButton := Value;
end;

procedure TElTrayInfo.ShowHandler(Sender: TObject);
begin
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

procedure TElTrayInfo.HideHandler(Sender: TObject);
begin
  if Assigned(FOnHide) then
    FOnHide(Self);
end;

procedure TElTrayInfo.ClickHandler(Sender: TObject);
begin
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure TElTrayInfo.DblClickHandler(Sender: TObject);
begin
  if Assigned(FOnDblClick) then
    FOnDblClick(Self);
end;

destructor TElTrayInfo.Destroy;  { public }
var
  AVisualScheme: TElTrayVisualScheme;
begin
  if (FInfoForm <> nil) and (not (csDestroying in ComponentState)) then
  begin
    FInfoForm.Hide;
    FInfoForm.Free;
    FInfoForm := nil;
  end;
  while FVisualSchemeList.Count > 0 do
  begin
    AVisualScheme :=  TElTrayVisualScheme(FVisualSchemeList.Items[0]);
    FVisualSchemeList.Remove(AVisualScheme);
    FreeAndNil(AVisualScheme);
//    AVisualScheme.Free;
//    AVisualScheme:=nil;
  end;
  FreeAndNil(FVisualScheme);
  FreeAndNil(FVisualSchemeList);
  FreeAndNil(FMsgs);
  FreeAndNil(FPopupMenu);
  inherited;
  FFont.Free;
end;  { Destroy }

procedure TElTrayInfo.ShowEx(X, Y : integer; AdjustY : boolean);
var cX,
    cY : integer;
    H1,
    H2 : HWND;
    R,
    R1 : TRect;
    TBarAlign : TTaskBarEdge;
    DesktopWidth,
    DesktopHeight : integer;
    i : integer;
begin
  if (FMsgs.Count <= 0) and (FCurrentMsg < FMsgs.Count) then
  begin
    if (Length(FMessage) = 0) then exit;
  end
  else
    SetMessageIndex(FCurrentMsg);

  PrepareInfoForm;

  H1 := FindWindow('Shell_TrayWnd', nil);
  if H1 <> 0 then
  begin
    H2 := FindWindowEx(H1, 0, 'TrayNotifyWnd', nil);
    if H2 <> 0 then
    begin
      R := GetWorkspaceRect;
      DesktopWidth  := R.Right;
      DesktopHeight := R.Bottom;

      GetWindowRect(H1, R1);
      GetWindowRect(H2, R);
      TBarAlign := GetTaskBarEdge;

      FInfoForm.InfoLabel.Caption := FMessage;

      case TBarAlign of
        tbeBottom:
          begin
            if AdjustY then
              Dec(Y, SuggestedHeight);
            cy := SuggestedHeight;
            if Y + cy > DesktopHeight then
              Y := DesktopHeight - cy;
            cx := SuggestedWidth;
            if X + cx > DesktopWidth then
              X := DesktopWidth - CX;
          end;
        tbeLeft:
          begin
            cx := SuggestedWidth;
            if X + cx > DesktopWidth then
              X := DesktopWidth - CX;
            cy := SuggestedHeight;
            if Y + cy > DesktopHeight then
              Y := DesktopHeight - cy;
          end;
        tbeTop:
          begin
            if AdjustY then
              Dec(Y, SuggestedHeight);
            cy := SuggestedHeight;
            if Y + cy < 0 then
              Y := 0;
            cx := SuggestedWidth;
            if X + cx > DesktopWidth then
              X := DesktopWidth - CX;
          end;
        tbeRight:
          begin
            cx := SuggestedWidth;
            if X + cx > DesktopWidth then
              X := DesktopWidth - CX;
            cy := SuggestedHeight;
            if Y + cy > DesktopHeight then
              Y := DesktopHeight - cy;
          end;
        else
          begin
            Y := R1.Top - SuggestedHeight;
            X := DesktopWidth - SuggestedWidth;
          end;
      end;

      FInfoForm.Timer.Enabled  := false;
      FInfoForm.Timer.Interval := FShowTime;

//      AdjustFormIcon;

//      R.Left := max(X, 0);
      //R.Top  := max(Y, 0);
      i := SuggestedWidth;
      if i > DesktopWidth then
        FInfoForm.InfoLabel.WordWrap := true;
      FInfoForm.Visible := true;
      FInfoForm.SetBounds(X, Y, min(i, DesktopWidth), min(SuggestedHeight, DesktopHeight));

      FInfoForm.FCloseBtn.Parent := FInfoForm.Panel1;
      FInfoForm.FNextBtn.Parent := FInfoForm.Panel1;
      FInfoForm.FPrevBtn.Parent := FInfoForm.Panel1;
      FInfoForm.FDeleteBtn.Parent := FInfoForm.Panel1;
      FInfoForm.FMenuBtn.Parent := FInfoForm.Panel1;
      FInfoForm.FPages.Parent := FInfoForm.Panel1;

      H1 := GetForegroundWindow;

      HookAppl;
      SetWindowPos(FInfoForm.Handle, HWND_TOPMOST, 0,0,0,0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE {or SWP_SHOWWINDOW});
      SetForegroundWindow(H1);

      FixTopbarPos;

      FInfoForm.Timer.Enabled := FShowTime > 0;
      UnhookAppl;
    end;
  end;
end;

procedure TElTrayInfo.FixTopbarPos;
var
  LOld: Integer;
begin
  FInfoForm.Panel1.Left := FInfoForm.FBorderWidth;
  FInfoForm.Panel1.Width := FInfoForm.Width - (FInfoForm.FBorderWidth * 2);

  FInfoForm.FCloseBtn.Visible := ShowCloseButton;
  FInfoForm.FCloseBtn.SetBounds(FInfoForm.ClientRect.Right - 20, 1, 18, Min(18, FInfoForm.ClientRect.Bottom - 2));
  FInfoForm.FCloseBtn.Left := FInfoForm.Width - FInfoForm.FCloseBtn.Width - ((FInfoForm.FBorderWidth * 2) + 1);

  FInfoForm.FPages.Caption := Format(FFormatOfNavigation, [FCurrentMsg + 1, FMsgs.Count]);
  FInfoForm.FPages.Top := ((FInfoForm.Height - FInfoForm.FPages.Height) - 6);
  FInfoForm.FPages.Left := (FInfoForm.Width - FInfoForm.FPages.Width) div 2;
  FInfoForm.FPages.Visible := ShowNavPanel;

  FInfoForm.FNextBtn.Visible := ShowNavPanel;
  FInfoForm.FNextBtn.SetBounds((FInfoForm.FPages.Left + FInfoForm.FPages.Width) + 3,
                               ((FInfoForm.Height - FInfoForm.FNextBtn.Height) - 4),
                               18, Min(18, FInfoForm.ClientRect.Bottom - 2));

  FInfoForm.FDeleteBtn.Visible := ShowDeleteButton and ShowNavPanel;
  FInfoForm.FDeleteBtn.SetBounds((FInfoForm.FNextBtn.Left + FInfoForm.FNextBtn.Width) + 3,
                               ((FInfoForm.Height - FInfoForm.FDeleteBtn.Height) - 4),
                               18, Min(18, FInfoForm.ClientRect.Bottom - 2));

  FInfoForm.FMenuBtn.Visible := ShowMenuButton and ShowNavPanel;
  FInfoForm.FMenuBtn.SetBounds((FInfoForm.FNextBtn.Left + FInfoForm.FNextBtn.Width) + 3,
                               ((FInfoForm.Height - FInfoForm.FMenuBtn.Height) - 4),
                               18, Min(18, FInfoForm.ClientRect.Bottom - 2));

  if ShowDeleteButton then
    FInfoForm.FMenuBtn.Left := FInfoForm.FDeleteBtn.Left + FInfoForm.FDeleteBtn.Width + 3;

  FInfoForm.FPrevBtn.Visible := ShowNavPanel;
  FInfoForm.FPrevBtn.SetBounds(FInfoForm.FPages.Left - 21,
                               ((FInfoForm.Height - FInfoForm.FNextBtn.Height) - 4),
                               18, Min(18, FInfoForm.ClientRect.Bottom - 2));

  LOld := FInfoForm.Height;
  FInfoForm.Height := SuggestedHeight;
  FInfoForm.Top := FInfoForm.Top + (LOld - FInfoForm.Height);

  FInfoForm.InfoLabel.Left := (FInfoForm.Image1.Left + FInfoForm.FGlyph.Glyph.Width) + 4;

  case VisualScheme.BarPosition of
  tbeTop:
    begin
      FInfoForm.Panel1.Top := VisualScheme.BarHeight + FInfoForm.FBorderWidth;
      FInfoForm.Panel1.Height := InfoForm.Height - (VisualScheme.BarHeight + (FInfoForm.FBorderWidth * 2));
      FInfoForm.Panel1.Left := FInfoForm.FBorderWidth;
      FInfoForm.Panel1.Width := InfoForm.Width - (FInfoForm.FBorderWidth * 2);

      FInfoForm.FPages.Top := FInfoForm.FPages.Top - VisualScheme.BarHeight;
      FInfoForm.FMenuBtn.Top := FInfoForm.FMenuBtn.Top - VisualScheme.BarHeight;
      FInfoForm.FDeleteBtn.Top := FInfoForm.FDeleteBtn.Top - VisualScheme.BarHeight;
      FInfoForm.FPrevBtn.Top := FInfoForm.FPrevBtn.Top - VisualScheme.BarHeight;
      FInfoForm.FNextBtn.Top := FInfoForm.FNextBtn.Top - VisualScheme.BarHeight;
    end;
  tbeLeft:
    begin
      FInfoForm.Panel1.Top := FInfoForm.FBorderWidth;
      FInfoForm.Panel1.Height := InfoForm.Height - (FInfoForm.FBorderWidth * 2);
      FInfoForm.Panel1.Left := VisualScheme.BarHeight - FInfoForm.FBorderWidth;
      FInfoForm.Panel1.Width := InfoForm.Width - VisualScheme.BarHeight;

      FInfoForm.InfoLabel.Left := FInfoForm.InfoLabel.Left - VisualScheme.BarHeight;
      FInfoForm.FPages.Left := FInfoForm.FPages.Left - VisualScheme.BarHeight;
      FInfoForm.FCloseBtn.Left := (FInfoForm.FCloseBtn.Left - VisualScheme.BarHeight) + 1;
      FInfoForm.FNextBtn.Left := FInfoForm.FNextBtn.Left - VisualScheme.BarHeight;
      FInfoForm.FPrevBtn.Left := FInfoForm.FPrevBtn.Left - VisualScheme.BarHeight;
      FInfoForm.FMenuBtn.Left := FInfoForm.FMenuBtn.Left - VisualScheme.BarHeight;
      FInfoForm.FDeleteBtn.Left := FInfoForm.FCloseBtn.Left - VisualScheme.BarHeight;
    end;
  tbeBottom:
    begin
      FInfoForm.Panel1.Top := FInfoForm.FBorderWidth;
      FInfoForm.Panel1.Height := InfoForm.Height - (VisualScheme.BarHeight + (FInfoForm.FBorderWidth * 2));
      FInfoForm.Panel1.Left := FInfoForm.FBorderWidth;
      FInfoForm.Panel1.Width := InfoForm.Width - (FInfoForm.FBorderWidth * 2);

      FInfoForm.FPages.Top := FInfoForm.FPages.Top - VisualScheme.BarHeight;
      FInfoForm.FMenuBtn.Top := FInfoForm.FMenuBtn.Top - VisualScheme.BarHeight;
      FInfoForm.FDeleteBtn.Top := FInfoForm.FDeleteBtn.Top - VisualScheme.BarHeight;
      FInfoForm.FPrevBtn.Top := FInfoForm.FPrevBtn.Top - VisualScheme.BarHeight;
      FInfoForm.FNextBtn.Top := FInfoForm.FNextBtn.Top - VisualScheme.BarHeight;
    end;
  tbeRight:
    begin
      FInfoForm.Panel1.Top := FInfoForm.FBorderWidth;
      FInfoForm.Panel1.Height := InfoForm.Height - (FInfoForm.FBorderWidth * 2);
      FInfoForm.Panel1.Left := FInfoForm.FBorderWidth;
      FInfoForm.Panel1.Width := InfoForm.Width - (VisualScheme.BarHeight + (FInfoForm.FBorderWidth * 2));
    end;
  end;
  FInfoForm.FCloseBtn.Color := Color;
end;

procedure TElTrayInfo.PrepareInfoForm;
begin
  if FInfoForm = nil then
  begin
    FInfoForm := TTrayInfoForm.Create(Application);
    FInfoForm.InfoLabel.OnImageNeeded := FOnImageNeeded;
    FInfoForm.InfoLabel.OnLinkClick := FOnLinkClick;
    FInfoForm.Panel1.Color := FColor;
    FInfoForm.FOnClick := ClickHandler;
    FInfoForm.FOnDblClick := DblClickHandler;
    FInfoForm.FOnShow := ShowHandler;
    FInfoForm.FOnHide := HideHandler;
    FInfoForm.ShadowXP := FShadowXP;

    HandlerChangeVisualScheme(Self);

    FInfoForm.FreeNotification(Self);
  end
  else if FInfoForm.Visible then
    FInfoForm.Hide;
  FInfoForm.InfoLabel.Font := FFont;
  FInfoForm.InfoLabel.IsHTML := IsHTML;
  FInfoForm.Panel1.Top := 8;

  FInfoForm.FCloseBtn.OnClick := CloseBtnClick;
  FInfoForm.FNextBtn.OnClick := NextBtnClick;
  FInfoForm.FPrevBtn.OnClick := PrevBtnClick;
  FInfoForm.FDeleteBtn.OnClick := DeleteBtnClick;
  FInfoForm.FMenuBtn.OnClick := MenuBtnClick;

  SetMessageIndex(FCurrentMsg);
//  SetVisualStyle(FVisualStyle);
end;

procedure TElTrayInfo.FillVisualStyles;
var
  LTemp: TElTrayVisualScheme;
begin
  LTemp := TElTrayVisualScheme.Create;
  LTemp.Name := 'Standard';
  LTemp.BorderColor := clBlack;
  LTemp.BorderWidth := 1;
  LTemp.BarHeight := 0;
  LTemp.BackgroundType := bgtColorFill;
  LTemp.WindowGradientStart := clInfoBk;
  LTemp.WindowGradientEnd := clInfoBk;
  LTemp.ButtonHoverGradientStart := clBtnFace;
  LTemp.ButtonHoverGradientEnd := clBtnFace;
  LTemp.ButtonDownGradientStart := clBtnFace;
  LTemp.ButtonDownGradientEnd := clBtnFace;
  FVisualSchemeList.Add(LTemp);

  VisualScheme := LTemp;

  LTemp := TElTrayVisualScheme.Create;
  LTemp.Name := 'Outlook 2003 Blue';
  LTemp.BorderColor := $962D00;
  LTemp.BorderWidth := 1;
  LTemp.BarHeight := 8;
  LTemp.BarPosition := tbeTop;
  LTemp.BackgroundType := bgtVertGradient;
  LTemp.WindowGradientStart := $FADAC4;
  LTemp.WindowGradientEnd := $F5BFA0;
  LTemp.BarGradientStart := $D68759;
  LTemp.BarGradientEnd := $962D00;
  LTemp.ButtonHoverGradientStart := $00DCFFFF;
  LTemp.ButtonHoverGradientEnd := $005BC0F7;
  LTemp.ButtonDownGradientStart := $00087FE8;
  LTemp.ButtonDownGradientEnd := $007CDAF7;
  FVisualSchemeList.Add(LTemp);

  LTemp := TElTrayVisualScheme.Create;
  LTemp.Name := 'FireFox';
  LTemp.BorderColor := RGB(123, 150, 156);
  LTemp.BorderWidth := 2;
  LTemp.BarHeight := 0;
  LTemp.BackgroundType := bgtColorFill;
  LTemp.WindowGradientStart := clBtnFace;
  LTemp.WindowGradientEnd := clBtnFace;
  LTemp.ButtonHoverGradientStart := clBtnFace;
  LTemp.ButtonHoverGradientEnd := clBtnFace;
  LTemp.ButtonDownGradientStart := RGB(103, 130, 136);
  LTemp.ButtonDownGradientEnd := RGB(103, 130, 136);
  FVisualSchemeList.Add(LTemp);

  LTemp := TElTrayVisualScheme.Create;
  LTemp.Name := 'Miranda Popup';
  LTemp.BorderColor := clBlack;
  LTemp.BorderWidth := 1;
  LTemp.BarHeight := 25;
  LTemp.BarPosition := tbeLeft;
  LTemp.BackgroundType := bgtHorzGradient;
  LTemp.WindowGradientStart := RGB(193, 223, 247);
  LTemp.WindowGradientEnd := RGB(193, 223, 247);
  LTemp.BarGradientStart := RGB(193, 223, 247);
  LTemp.BarGradientEnd := RGB(160, 185, 205);
  LTemp.ButtonHoverGradientStart := $00DCFFFF;
  LTemp.ButtonHoverGradientEnd := $005BC0F7;
  LTemp.ButtonDownGradientStart := $00087FE8;
  LTemp.ButtonDownGradientEnd := $007CDAF7;
  FVisualSchemeList.Add(LTemp);
end;

procedure TElTrayInfo.SetMessageIndex(const Index: Integer);
begin
//  if (FCurrentMsg <> Index) or (Index < 0) then
//    if (Index >= FMsgs.Count) then
//      exit;
   if LMDInRange(Index, -1, FMsgs.Count - 1) then
   begin
     FCurrentMsg := Index;
//     if FCurrentMsg < 0 then
//       FCurrentMsg := 0;
     if LMDInRange(FCurrentMsg, 0, FMsgs.Count - 1) then
     begin
       Message := FMsgs.Items[FCurrentMsg].Text;
       IsHTML := FMsgs.Items[FCurrentMsg].IsHTML;
     end;
   end
   else
     if Assigned (FInfoForm) then
       FInfoForm.InfoLabel.Caption := FMessage;
  if Assigned(FInfoForm) then
  begin
    VisualScheme := FVisualScheme;

    if LMDInRange(FCurrentMsg, 0, FMsgs.Count - 1) then
    begin
      if not FMsgs.Items[FCurrentMsg].Glyph.Empty then
        FInfoForm.FGlyph.Glyph.Assign(FMsgs.Items[FCurrentMsg].Glyph)
      else
        AdjustFormIcon;

      if FMsgs.Items[FCurrentMsg].GradientStartColor <> clNone then
        FInfoForm.Panel1.GradientStartColor := FMsgs.Items[FCurrentMsg].GradientStartColor;

      if FMsgs.Items[FCurrentMsg].GradientEndColor <> clNone then
        FInfoForm.Panel1.GradientEndColor := FMsgs.Items[FCurrentMsg].GradientEndColor;

      FInfoForm.Panel1.GradientSteps := FInfoForm.Panel1.Height div 3;

      FInfoForm.FNextBtn.Enabled := Boolean(FCurrentMsg < FMsgs.Count - 1);
      FInfoForm.FPrevBtn.Enabled := Boolean(FCurrentMsg > 0);
    end
    else
      AdjustFormIcon;
    if Assigned(FInfoForm.FGlyph.Glyph) then
    begin
      FInfoForm.Image1.Top := 0;
      FInfoForm.Image1.Left := 0;
      FInfoForm.Image1.Height := FInfoForm.FGlyph.Glyph.Height+5;
      FInfoForm.Image1.Width := FInfoForm.FGlyph.Glyph.Width+5;
    end;
    if FInfoForm.InfoLabel.Height < (FInfoForm.Image1.Top + FInfoForm.FGlyph.Glyph.Height) then
      FInfoForm.InfoLabel.Top := FInfoForm.Image1.Top + (FInfoForm.FGlyph.Glyph.Height - FInfoForm.InfoLabel.Height) div 2
    else
      FInfoForm.InfoLabel.Top := FInfoForm.Image1.Top;

    if VisualScheme.BarPosition = tbeLeft then
      FInfoForm.InfoLabel.Left := ((FInfoForm.Image1.Left + FInfoForm.FGlyph.Glyph.Width) + 4) - VisualScheme.BarHeight
    else
      FInfoForm.InfoLabel.Left := (FInfoForm.Image1.Left + FInfoForm.FGlyph.Glyph.Width) + 4;
  end;
end;

procedure TElTrayInfo.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  if FInfoForm <> nil then
  begin
    FInfoForm.InfoLabel.Font := FFont;
    FInfoForm.FNextBtn.Font := FFont;
    FInfoForm.FPrevBtn.Font := FFont;
  end;
end;

procedure TElTrayInfo.SetFormatOfNavigation(const Value: TLMDString);
begin
  FFormatOfNavigation := Value;
  if FInfoForm <> nil then
    FInfoForm.FPages.Caption := Value;
end;

procedure TElTrayInfo.FontChange(Sender : TObject);
begin
  FParentFont := false;
  if FInfoForm <> nil then
  begin
    FInfoForm.InfoLabel.Font := FFont;
    FInfoForm.FNextBtn.Font := FFont;
    FInfoForm.FPrevBtn.Font := FFont;
  end;
end;

function TElTrayInfo.GetVisible: Boolean;
begin
  if Assigned(FInfoForm) then
    Result := FInfoForm.Visible
  else
    Result := False;
end;

procedure TElTrayInfo.SetParentFont(Value: Boolean);
var AForm : TForm;
begin
  if FParentFont <> Value then
  begin
    if Value then
    begin
      AForm := LMDGetOwnerForm(Self);
      if AForm <> nil then
        Font := AForm.Font;
      FParentFont := true;
    end
    else
      FParentFont := false;
  end;
end;

{$R *.DFM}

procedure TTrayInfoForm.TimerTimer(Sender: TObject);
begin
  Hide;
end;

procedure TTrayInfoForm.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent is TElTrayInfo) then
  begin
    FOnClick := nil;
    FOnDblClick := nil;
  end;
end;

procedure TTrayInfoForm.CMMouseEnter(var Message: TMessage);
begin
  FSaveState := Timer.Enabled;
  Timer.Enabled := False;
end;

procedure TTrayInfoForm.CMMouseLeave(var Message: TMessage);
begin
  Timer.Enabled := FSaveState;
end;

procedure TTrayInfoForm.CreateParams(var Params: TCreateParams);  { protected }
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    WndParent := GetDesktopWindow;
  end;
end;  { CreateParams }

procedure TTrayInfoForm.ClickHandler(Sender: TObject);
begin
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure TTrayInfoForm.DblClickHandler(Sender: TObject);
begin
  if Assigned(FOnDblClick) then
    FOnDblClick(Self);
end;

procedure TTrayInfoForm.ShowHandler(Sender: TObject);
begin
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

procedure TTrayInfoForm.HideHandler(Sender: TObject);
begin
  if Assigned(FOnHide) then
    FOnHide(Self);
end;

procedure TTrayInfoForm.WMMouseActivate(var Msg: TWMMouseActivate);
begin
  Msg.Result := MA_NOACTIVATE;
end;

procedure TTrayInfoForm.FormCreate(Sender: TObject);
var Bmp : TBitmap;
    i, j: integer;
begin
  FTopmost := TElTopmost.Create(Self);
//  FCloseBtn := TElTrayInfoCloseButton.Create(Self);
  FCloseBtn := TElAdvButton.Create(Self);
  FNextBtn := TElAdvButton.Create(Self);
  FPrevBtn := TElAdvButton.Create(Self);
  FDeleteBtn := TElAdvButton.Create(Self);
  FMenuBtn := TElAdvButton.Create(Self);
  FPages := TElLabel.Create(Self);

  FGlyph := TLMDButtonGlyph.Create;

  FCloseBtn.Name := 'FCloseBtn';
  FNextBtn.Name := 'FNextBtn';
  FPrevBtn.Name := 'FPrevBtn';

  Bmp := TBitmap.Create;
  Bmp.Width := 16;
  Bmp.Height := 16;
//  FCloseBtn.Flat := true;
  Bmp.Canvas.Brush.Color := Panel1.Color;
  Bmp.Canvas.FillRect(Rect(0, 0, 16, 16));
  DrawFrameControl(Bmp.Canvas.Handle, Rect(-1, -1, 18, 18), DFC_CAPTION, DFCS_CAPTIONCLOSE);
  for i := 0 to bmp.Width do
    for j := 0 to Bmp.Height do
    begin
      if Bmp.Canvas.Pixels[i, j] <> colorToRGB(clBlack) then
        Bmp.Canvas.Pixels[i, j] := RGB(255, 0, 255);
    end;
  FCloseBtn.Glyph := Bmp;
  FCloseBtn.Transparent := True;

  FNextBtn.Caption := #187;
  FNextBtn.Transparent := True;
  FNextBtn.Font := Font;

  FPrevBtn.Caption := #171;
  FPrevBtn.Transparent := True;
  FPrevBtn.Font := Font;

  FDeleteBtn.Glyph := Bmp;
  FDeleteBtn.Transparent := True;
  FDeleteBtn.Visible := False;
  Bmp.LoadFromResourceName(HInstance, 'ELDOWNARROW');
  FMenuBtn.Glyph := Bmp;
  FMenuBtn.Transparent := True;
  FMenuBtn.Visible := False;
  Bmp.Free;
end;

procedure TTrayInfoForm.WMNCHitTest(var Message: TWMNCHitTest);
var
  LPoint: TPoint;
  LIsCaption: Boolean;
begin
  Inherited;
  LPoint := ScreenToClient(SmallPointToPoint(Message.Pos));
  LIsCaption := False;
  case FBarPosition of
  tbeTop:
    if (LPoint.Y >= 0) and (LPoint.Y <= FBarHeight) then
      LIsCaption := True;
  tbeLeft:
    if (LPoint.X >= 0) and (LPoint.X <= FBarHeight) then
      LIsCaption := True;
  tbeBottom:
    if (LPoint.Y >= Height - FBarHeight) and (LPoint.Y <= Height) then
      LIsCaption := True;
  tbeRight:
    if (LPoint.X >= Width - FBarHeight) and (LPoint.X <= Width) then
      LIsCaption := True;
  end;

  if LIsCaption then
    Message.Result := HTCAPTION
  else
    Message.Result := HTCLIENT;
end;

procedure TTrayInfoForm.SetShadowXP(const Value: Boolean);
const
  CS_DROPSHADOW = $00020000;
var
  LVisible: Boolean;
begin
  LVisible := Visible;
  if FShadowXP <> Value then
  begin
    FShadowXP := Value;
    Hide;
    if Value then
      SetClassLong(Handle, GCL_STYLE, GetClassLong(Handle, GCL_STYLE) or CS_DROPSHADOW)
    else
      SetClassLong(Handle, GCL_STYLE, GetClassLong(Handle, GCL_STYLE) xor CS_DROPSHADOW);
    RecreateWnd;
    if LVisible then
      Show;
  end;
end;

procedure TTrayInfoForm.Paint;
const
  CPoints = 9;
var
  LBeg, LTemp: Integer;
  I: Integer;
  LBuf: TBitmap;
begin
  inherited;

  LBuf := TBitmap.Create;
  LBuf.Width := Width;
  LBuf.Height := Height;

  with LBuf do
  begin
    Canvas.Brush.Color := FBorderColor;
    Canvas.FillRect(Rect(0, 0, Width, Height));
    if FBarHeight > 0 then
    begin
      case FBarPosition of
      tbeTop:
        LMDGradientPaint(Canvas, Rect(FBorderWidth, FBorderWidth, Width - FBorderWidth, FBarHeight + FBorderWidth),
                     FBarGradientStart, FBarGradientEnd, 32, gstVertical, 0, 0);
      tbeLeft:
        LMDGradientPaint(Canvas.Handle, Rect(FBorderWidth, FBorderWidth, FBarHeight - FBorderWidth, Height - FBorderWidth),
                     FBarGradientStart, FBarGradientEnd, 32, gstHorizontal, 0, 0);
      tbeBottom:
        LMDGradientPaint(Canvas.Handle, Rect(FBorderWidth, FBorderWidth, Width - FBorderWidth, FBarHeight + FBorderWidth),
                     FBarGradientStart, FBarGradientEnd, 32, gstVertical, 0, 0);
      tbeRight:
        LMDGradientPaint(Canvas.Handle, Rect(FBorderWidth, FBorderWidth, Width - FBorderWidth, FBarHeight + FBorderWidth),
                     FBarGradientStart, FBarGradientEnd, 32, gstVertical, 0, 0);
      end;

      LBeg := (ClientWidth - ((3 * CPoints) + (CPoints - 1))) div 2;
      for i := 0 to (CPoints - 1) do
      begin
        LTemp := LBeg + (i * 4);
        Canvas.Brush.Color := clBlack;
        Canvas.FillRect(Rect(LTemp, 2, LTemp + 2, 4));
        Canvas.Brush.Color := clWhite;
        Canvas.FillRect(Rect(LTemp + 1, 3, LTemp + 3, 5));
        Canvas.Pixels[LTemp + 1, 3] := FBarGradientEnd;
      end;
    end;

  end;
  Canvas.Draw(0, 0, LBuf);
  LBuf.Free;
end;

procedure TTrayInfoForm.Image1Paint(Sender: TObject);
var
  LDetails: TThemedElementDetails;
begin
  if FBarPosition = tbeTop then
    FGlyph.Draw(Image1.Canvas, Rect(0, 0, FGlyph.Glyph.Width, FGlyph.Glyph.Height), Point(FBorderWidth + 2, {FBarHeight +} FBorderWidth + 2), '', blGlyphLeft,
              0, 0, ebsExclusive, ebsExclusive, taCenter, True, True, True, True, True, 0,
              tdtNormal, clBlack, ttmNone, LDetails, False, False, False, nil, True)
  else
    FGlyph.Draw(Image1.Canvas, Rect(0, 0, FGlyph.Glyph.Width, FGlyph.Glyph.Height),
                Point(FBorderWidth + 2, FBorderWidth + 2), '', blGlyphLeft,
                0, 0, ebsExclusive, ebsExclusive, taCenter, True, True, True, True, True, 0,
                tdtNormal, clBlack, ttmNone, LDetails, False, False, False, nil, True);
end;

{ TElTrayMessage }

procedure TElTrayMessage.Assign(Source: TPersistent);
begin
  if Source is TElTrayMessage then
    with Source as TElTrayMessage do
    begin
      Self.FGlyph := Glyph;
      Self.FGradientEndColor := GradientEndColor;
      Self.FGradientStartColor := GradientStartColor;
      Self.FIsHtml := IsHTML;
      Self.FText := Text;
    end
  else
    inherited;
end;

constructor TElTrayMessage.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FGradientEndColor := clNone;
  FGradientStartColor := clNone;
  FGlyph := TBitmap.Create;
end;

destructor TElTrayMessage.Destroy;
begin
  FreeAndNil(FGlyph);
  inherited;
end;

procedure TElTrayMessage.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
  Changed(True);
end;

procedure TElTrayMessage.SetGradientEndColor(const Value: TColor);
begin
  if FGradientEndColor <> Value then
  begin
    FGradientEndColor := Value;
    Changed(False);
  end;
end;

procedure TElTrayMessage.SetGradientStartColor(const Value: TColor);
begin
  if FGradientStartColor <> Value then
  begin
    FGradientStartColor := Value;
    Changed(False);
  end;
end;

procedure TElTrayMessage.SetIsHtml(const Value: Boolean);
begin
  FIsHtml := Value;
  Changed(False);
end;

procedure TElTrayMessage.SetText(const Value: TLMDString);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed(False);
  end;
end;

{ --------------------------- TElTrayMessageList ----------------------------- }
{ ---------------------------------------------------------------------------- }
{ ---------------------------------------------------------------------------- }
procedure TElTrayMessageList.AClick(Sender: TObject);
begin
  FTrayInfo.SetMessageIndex(FTrayInfo.FPopupMenu.Items.IndexOf((Sender as TElMenuItem)));
end;

function TElTrayMessageList.Add: TElTrayMessage;
begin
  Result := TElTrayMessage(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayMessageList.RebuildPopupMenu;
var
  i: Integer;
begin
  if Assigned(FTrayInfo) and Assigned(FTrayInfo.FPopupMenu) then
  begin
    FTrayInfo.FPopupMenu.Items.Clear;
    FTrayInfo.FPopupMenu.IsHTML := FTrayInfo.IsHTML;
    for i := 0 to Count - 1 do
    begin
      FTrayInfo.FPopupMenu.Items.Add(ElNewItem(Items[i].Text, 0, False, True, AClick, 0, 'ElMsg' + IntToStr(i), TElMenuItem));
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayMessageList.Update(Item: TCollectionItem);
begin
  inherited;
  RebuildPopupMenu;
end;

{ ---------------------------------------------------------------------------- }
{procedure TElTrayMessageList.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  inherited;
end;}

{ ---------------------------------------------------------------------------- }
function TElTrayMessageList.Get(Index: Integer): TElTrayMessage;
begin
  Result := TElTrayMessage(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayMessageList.Put(Index: Integer; const Value: TElTrayMessage);
begin
  inherited SetItem(Index, Value);
end;

{ ----------------------------- TElAdvButton --------------------------------- }
{ -------------------------------- private ----------------------------------- }
function TElAdvButton.GetGlyph: TBitmap;
begin
  Result := FGlyph.Glyph;
end;

{ ---------------------------------------------------------------------------- }
procedure TElAdvButton.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TElAdvButton.SetDownGradientEndColor(const Value: TColor);
begin
  FDownGradientEndColor := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TElAdvButton.SetDownGradientStartColor(const Value: TColor);
begin
  FDownGradientStartColor := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TElAdvButton.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Glyph := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TElAdvButton.SetHoverGradientEndColor(const Value: TColor);
begin
  FHoverGradientEndColor := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TElAdvButton.SetHoverGradientStartColor(const Value: TColor);
begin
  FHoverGradientStartColor := Value;
  Invalidate;
end;

{ -------------------------- protected --------------------------------------- }
procedure TElAdvButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FDown := true;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TElAdvButton.MouseEnter(Sender: TObject);
begin
  FHover := True;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TElAdvButton.MouseLeave(Sender: TObject);
begin
  FHover := False;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TElAdvButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FDown := false;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TElAdvButton.TriggerPaintEvent;
var
  FBuf: TBitmap;
  LEnabled: TLMDExButtonState;
  LDetails: TThemedElementDetails;
begin
  inherited;
  FBuf := TBitmap.Create;
  FBuf.Width := Width;
  FBuf.Height := Height;
  FBuf.Canvas.CopyRect(Rect(0, 0, Width, Height), Canvas, Rect(0, 0, Width, Height));

  if FHover then
  begin
    if FDown then
      LMDGradientPaint(FBuf.Canvas.Handle, Rect(1, 1, Width - 1, Height - 1),
                   FDownGradientStartColor, FDownGradientEndColor, 64, gstVertical, 0, 0)
    else
      LMDGradientPaint(FBuf.Canvas.Handle, Rect(1, 1, Width - 1, Height - 1),
                   FHoverGradientStartColor, FHoverGradientEndColor, 64,  gstVertical, 0, 0);

    FBuf.Canvas.Brush.Color := FBorderColor;
    FBuf.Canvas.FrameRect(Rect(0, 0, Width, Height));
  end;

  if Enabled then
    LEnabled := ebsUp
  else
    LEnabled := ebsDisabled;

  FGlyph.Draw(FBuf.Canvas, Rect(0, 0, Width, Height), Point(0, 0), Caption, blGlyphLeft,
              (Width - FGlyph.Glyph.Width - FBuf.Canvas.TextWidth(Caption)) div 2, 0,
              LEnabled, LEnabled, taCenter, True, True, True, True, True, 0,
              tdtNormal, clBlack, ttmNone, LDetails, False, False, False, nil, True);

  Canvas.Draw(0, 0, FBuf);
  FBuf.Free;
end;

{ ------------------------------- public ------------------------------------- }
constructor TElAdvButton.Create(AOwner: TComponent);
begin
  inherited;
  FGlyph := TLMDButtonGlyph.Create;
  FOwnerDraw := True;
  ThemeMode := ttmNone;
  FTransparent := True;

  BevelKind := bkNone;
  BorderStyle := bsNone;
  BevelInner := bvNone;
  BevelOuter := bvNone;

  Resizable := False;
  Movable := False;

  OnMouseEnter := MouseEnter;
  OnMouseLeave := MouseLeave;
end;

{ ---------------------------------------------------------------------------- }
destructor TElAdvButton.Destroy;
begin
  inherited;
  FGlyph.Free;
end;

{ -------------------------- TElTrayVisualScheme ----------------------------- }
{ -------------------------------- private ----------------------------------- }
procedure TElTrayVisualScheme.SetBackgroundType(const Value: TLMDBackgroundType);
begin
  if FBackgroundType <> Value then
  begin
    FBackgroundType := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.SetBorderWidth(const Value: Integer);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.SetButtonDownGradientEnd(const Value: TColor);
begin
  if FButtonDownGradientEnd <> Value then
  begin
    FButtonDownGradientEnd := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.SetButtonDownGradientStart(const Value: TColor);
begin
  if FButtonDownGradientStart <> Value then
  begin
    FButtonDownGradientStart := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.SetButtonHoverGradientEnd(const Value: TColor);
begin
  if FButtonHoverGradientEnd <> Value then
  begin
    FButtonHoverGradientEnd := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.SetButtonHoverGradientStart(const Value: TColor);
begin
  if FButtonHoverGradientStart <> Value then
  begin
    FButtonHoverGradientStart := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.SetBarGradientEnd(const Value: TColor);
begin
  if FBarGradientEnd <> Value then
  begin
    FBarGradientEnd := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.SetBarGradientStart(const Value: TColor);
begin
  if FBarGradientStart <> Value then
  begin
    FBarGradientStart := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.SetWindowGradientEnd(const Value: TColor);
begin
  if WindowGradientEnd <> Value then
  begin
    FWindowGradientEnd := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.SetWindowGradientStart(const Value: TColor);
begin
  if FWindowGradientStart <> Value then
  begin
    FWindowGradientStart := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.SetBarHeight(const Value: Integer);
begin
  if FBarHeight <> Value then
  begin
    FBarHeight := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.SetBarPosition(const Value: TTaskbarEdge);
begin
  if FBarPosition <> Value then
  begin
    FBarPosition := Value;
    TriggerChangeEvent;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElTrayVisualScheme.TriggerChangeEvent;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{ --------------------------------- public ----------------------------------- }
procedure TElTrayVisualScheme.Assign(Source: TPersistent);
begin
  if (Source is TElTrayVisualScheme) then
  begin
    FName := TElTrayVisualScheme(Source).Name;
    FBorderColor := TElTrayVisualScheme(Source).BorderColor;
    FBorderWidth := TElTrayVisualScheme(Source).BorderWidth;
    FBarHeight := TElTrayVisualScheme(Source).BarHeight;
    FBarPosition := TElTrayVisualScheme(Source).BarPosition;
    FWindowGradientStart := TElTrayVisualScheme(Source).WindowGradientStart;
    FWindowGradientEnd := TElTrayVisualScheme(Source).WindowGradientEnd;
    FBarGradientStart := TElTrayVisualScheme(Source).BarGradientStart;
    FBarGradientEnd := TElTrayVisualScheme(Source).BarGradientEnd;
    FButtonHoverGradientEnd := TElTrayVisualScheme(Source).ButtonHoverGradientEnd;
    FButtonHoverGradientStart := TElTrayVisualScheme(Source).ButtonHoverGradientStart;
    FButtonDownGradientEnd := TElTrayVisualScheme(Source).ButtonDownGradientEnd;
    FButtonDownGradientStart := TElTrayVisualScheme(Source).ButtonDownGradientStart;
  end
  else
    inherited;
end;

procedure TElAdvButton.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  LMDDebug(IntToStr(ALeft));
end;

procedure TElAdvButton.SetCaption(Value: TLMDString);
begin
  FCaption := Value;
end;

procedure TElAdvButton.WMMove(var Message: TWMMove);
begin
  inherited;
end;

procedure TElTrayInfo.CloseBtnClick(Sender: TObject);
begin
  if Assigned(FInfoForm) then
    FInfoForm.Close;
end;

procedure TElTrayInfo.DeleteBtnClick(Sender: TObject);
var
  LCanDel: Boolean;
begin
  if Assigned(FOnCanDeleteMessage) then
    FOnCanDeleteMessage(Sender, FCurrentMsg, LCanDel);

  if LCanDel then
  begin
    if Assigned(FInfoForm) then
      FMsgs.Delete(FCurrentMsg);
    if FMsgs.Count = 0 then
    begin
      FCurrentMsg := -1;
      FInfoForm.Close;
      exit;
    end
    else
      Dec(FCurrentMsg);
    SetMessageIndex(FCurrentMsg);
  end;
end;

procedure TElTrayInfo.MenuBtnClick(Sender: TObject);
var
  LPoint: TPoint;
begin
  LPoint := FInfoForm.Panel1.ClientToScreen(Point((FInfoForm.FMenuBtn.Left + FInfoForm.FMenuBtn.Width),
                                            FInfoForm.FMenuBtn.Top{ - FInfoForm.FMenuBtn.Height}));

  if Assigned(FOnPopupClick) then
    FOnPopupClick(Sender);

  if Assigned(FPopupMenu) and (Assigned(FInfoForm)) then
    FPopupMenu.Popup(LPoint.X, LPoint.Y);
end;

procedure TElTrayInfo.NextBtnClick(Sender: TObject);
begin
  SetMessageIndex(FCurrentMsg + 1);
  if Assigned(FOnNextMessage) then
    FOnNextMessage(Self);
end;

procedure TElTrayInfo.PrevBtnClick(Sender: TObject);
begin
  SetMessageIndex(FCurrentMsg - 1);
  if Assigned(FOnPrevMessage) then
    FOnPrevMessage(Self);
end;

procedure TTrayInfoForm.DoDestroy;
begin
  FCloseBtn.Parent := nil;
  FCloseBtn.Destroy;
  FNextBtn.Parent := nil;
  FNextBtn.Destroy;
  FPrevBtn.Parent := nil;
  FPrevBtn.Destroy;
  FDeleteBtn.Parent := nil;
  FDeleteBtn.Destroy;
  FMenuBtn.Parent := nil;
  FMenuBtn.Destroy;
  FPages.Parent := nil;
  FPages.Destroy;
  FGlyph.Destroy;
  FTopmost.Destroy;
  inherited;
end;

end.
