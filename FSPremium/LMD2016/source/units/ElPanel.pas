unit ElPanel;
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

ElPanel unit
------------

Changes
-------
Release 6.05
 [+] WordWrap property.

Release 6.0 (February 2007)
 - Initial Release
###############################################################################}

interface

uses
  Windows, Messages, Graphics, Controls, StdCtrls, Forms, ExtCtrls, Menus,
  Types, SysUtils, Classes, UxTheme, Themes,

  ElCGControl, ElXPThemedControl, ElImgFrm, ElStyleMan, ElVCLUtils,

  LMDThemes, LMDClass, LMDUtils, LMDTypes, intfLMDBase, LMDGraph, LMDProcs;

type
  TElPanelGrabHandleKind = (ghkNone, ghkMove, ghkResize, ghkMoveParent);
type

  TCustomElPanel = class;

  TElPanelGrabHandle = class(TPersistent)
  private
    FEnabled : Boolean;
    FSize : Integer;
    FKind : TElPanelGrabHandleKind;
    FBevelKind : TLMDBevelStyle;
    FOwner      : TCustomElPanel;
    FVisible : Boolean;
    procedure SetVisible(newValue : Boolean);
    procedure SetEnabled(newValue : Boolean);
    procedure SetSize   (newValue : Integer);
    procedure SetBevelKind(newValue : TLMDBevelStyle);
  public
    procedure Assign(Source : TPersistent); override;
  published
    property Enabled    : Boolean read FEnabled write SetEnabled default false;  { Published }
    property Size       : Integer read FSize write SetSize default 0;  { Published }
    property Kind       : TElPanelGrabHandleKind read FKind write FKind default ghkNone;  { Published }
    property BevelKind  : TLMDBevelStyle read FBevelKind write SetBevelKind default bvNone;  { Published }
    property Visible : Boolean read FVisible write SetVisible default false;  { Published }
  end;

  TCustomElPanel = class(TCustomPanel, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FSize: TSize;
    function GetUseXPThemes: Boolean;
    procedure SetParentThemeMode(const Value: boolean);
  protected
    FParentThemeMode: boolean;
    FThemeGlobalMode: Boolean;
    FThemeMode: TLMDThemeMode;

    FWordWrap: Boolean;
    FIsUpdated: Boolean;
    FBorderColorShadow: TColor;
    FBorderColorDkShadow: TColor;
    FBorderColorWindow: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorFace: TColor;
    FBorderType: TElFlatBorderType;
    FBorderSides: TLMDBorderSides;
    FBorderStyle: TBorderStyle;
    FBevelInner: TLMDBevelStyle;
    FBevelOuter: TLMDBevelStyle;
    FBevelWidth: TBevelWidth;
    FOwnerDraw : Boolean;
    FAlwaysPaintBackground: boolean;
    FLayout : TTextLayout;
    FOnPaint : TNotifyEvent;
    FGradientSteps : Integer;
    FGradientStartColor : TColor;
    FGradientEndColor : TColor;
    FTmpBmp : TBitmap;
    FTransparent : Boolean;
    FBackground : TBitmap;
    FBackgroundType : TLMDBackgroundType;

    FImgFormChLink  : TImgFormChangeLink;
    FImgForm        : TElImageForm;

    FSaveCapture : HWND;
    FOnMove : TNotifyEvent;
    FResizable : Boolean;
    FMovable : Boolean;
    FSizeMoveRect : TRect;
    FGrabHandles    : array[1..4] of TElPanelGrabHandle;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FMouseInControl: Boolean;
    FPressed : boolean;
    FIntPaint: boolean;
    FCaption: TLMDString;
    FAlphaLevel: Byte;
    FTransparentXPThemes: Boolean;
    FSizeGrip: Boolean;
    SizeGripRect : TRect;
    FBevelSpaceColor: TColor;
    FShowFocus: Boolean;
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}

    FStyleMgrLink : TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;

    FCreating: Integer;

    function UseThemeMode: TLMDThemeMode;
    procedure SetUseXPThemes(const Value: Boolean);virtual;
    procedure DefineProperties(Filer:TFiler);override;
    procedure ReadUseXPThemes(Reader: TReader);
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure DoThemeChanged; virtual;
    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    function GetThemedElement: TThemedElement; virtual;
    procedure SetWordWrap(Value: Boolean);
    procedure SetBorderType(const Value: TElFlatBorderType); virtual;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);
    procedure SetBackground(newValue : TBitmap);
    procedure ImageChange(Sender : TObject);
    procedure ImageFormChange(Sender : TObject);
    procedure SetResizable(newValue : Boolean); virtual;
    procedure SetBevelInner(Value: TLMDBevelStyle);
    procedure SetBevelOuter(Value: TLMDBevelStyle);
    procedure SetBevelWidth(Value: TBevelWidth);
    procedure WMEnterSizeMove(var Msg : TMessage); message WM_ENTERSIZEMOVE;
    procedure WMExitSizeMove(var Msg : TMessage); message WM_EXITSIZEMOVE;
    procedure WMNCHitTest(var Msg : TWMNCHitTest); message WM_NCHITTEST;
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd); message WM_EraseBkgnd;
    procedure WMMouseMove(var Msg : TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonDown(var Msg : TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg : TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMove(var Msg : TWMMove); message WM_MOVE;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure WMPaint(var Msg : TWMPaint); message WM_PAINT;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;

    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure IFMRepaintChildren(var Message: TMessage); message IFM_REPAINTCHILDREN;
    procedure RedoTmpBmp;
    procedure SetGradientStartColor(newValue : TColor);
    procedure SetGradientEndColor(newValue : TColor);
    procedure SetGradientSteps(newValue : Integer);
    procedure SetLayout(newValue : TTextLayout);
    procedure SetOwnerDraw(newValue : Boolean);
    function GetTopGrabHandle : TElPanelGrabHandle;
    procedure SetTopGrabHandle(newValue : TElPanelGrabHandle);
    function GetRightGrabHandle : TElPanelGrabHandle;
    procedure SetRightGrabHandle(newValue : TElPanelGrabHandle);
    function GetLeftGrabHandle : TElPanelGrabHandle;
    procedure SetLeftGrabHandle(newValue : TElPanelGrabHandle);
    function GetBottomGrabHandle : TElPanelGrabHandle;
    procedure SetBottomGrabHandle(newValue : TElPanelGrabHandle);
    procedure SetAlwaysPaintBackground(Value : boolean);
    procedure NotifyChildsThatRepaint(AllChilds: Boolean = false);virtual;
    procedure Loaded; override;
    procedure SetImageForm(newValue : TElImageForm); virtual;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure StyleMgrChange(Sender : TObject);
    procedure UpdateStyle;virtual;
    procedure SetBackgroundType(newValue : TLMDBackgroundType); virtual;
    procedure SetTransparent(newValue : Boolean); virtual;
    procedure SetMovable(newValue : Boolean); virtual;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Paint; override;
    procedure TriggerMoveEvent; virtual;
    procedure TriggerPaintEvent; virtual;
    procedure SetCaption(newValue: TLMDString); virtual;
    procedure CreateParams(var Params : TCreateParams); override;
    procedure WndProc(var Message : TMessage); override;

    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure AdjustClientRect(var Rect: TRect);override;
    function  InGrabHandle(X, Y : integer; Rect : TRect) : TElPanelGrabHandle;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoMouseEnter; dynamic;
    procedure DoMouseLeave; dynamic;
    function GetCaption: TLMDString; virtual;
    procedure SetAlphaLevel(Value: Byte);

    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED; //(VB theme engine transition)
    procedure DrawThemedBackground(ARect: TRect); virtual;
    function GetBackgroundClientRect: TRect; virtual;
    procedure SetTransparentXPThemes(Value: Boolean); virtual;
    procedure SetSizeGrip(Value: Boolean);
    procedure UpdateInterior; virtual;
    procedure SetBevelSpaceColor(Value: TColor);
    procedure SetShowFocus(Value: Boolean);
    procedure PaintWindow(DC: HDC); override;
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);

    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$endif}
    procedure BeginCreate;
    procedure EndCreate;

    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    property AlwaysPaintBackground : boolean read FAlwaysPaintBackground write SetAlwaysPaintBackground default false;
    property Layout : TTextLayout read FLayout write SetLayout default tlCenter;  { Published }
    property OwnerDraw : Boolean read FOwnerDraw write SetOwnerDraw default false;  { Published }
    property Background : TBitmap read FBackground write SetBackground;
    property BackgroundType : TLMDBackgroundType read FBackgroundType write SetBackgroundType default bgtColorFill;
    property Resizable : Boolean read FResizable write SetResizable default false;
    property Movable : Boolean read FMovable write SetMovable default false;
    property Transparent : Boolean read FTransparent write SetTransparent default false; { Protected }
    property Caption: TLMDString read GetCaption write SetCaption;
    property GradientStartColor : TColor read FGradientStartColor write SetGradientStartColor default clBlack;  { Protected }
    property GradientEndColor : TColor read FGradientEndColor write SetGradientEndColor default clBlack;  { Protected }
    property GradientSteps : Integer read FGradientSteps write SetGradientSteps default 16;  { Protected }
    property ImageForm     : TElImageForm read FImgForm write SetImageForm;
    property TopGrabHandle : TElPanelGrabHandle read GetTopGrabHandle write SetTopGrabHandle;  { Published }
    property RightGrabHandle : TElPanelGrabHandle read GetRightGrabHandle write SetRightGrabHandle;  { Published }
    property LeftGrabHandle : TElPanelGrabHandle read GetLeftGrabHandle write SetLeftGrabHandle;  { Published }
    property BottomGrabHandle : TElPanelGrabHandle read GetBottomGrabHandle write SetBottomGrabHandle;  { Published }

    property OnMove : TNotifyEvent read FOnMove write FOnMove;
    property OnPaint : TNotifyEvent read FOnPaint write FOnPaint;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property AlphaLevel: Byte read FAlphaLevel write SetAlphaLevel default 0;
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property TransparentXPThemes: Boolean read FTransparentXPThemes write SetTransparentXPThemes default true;
    property MouseCapture default false;
    property TabStop;
    property SizeGrip: Boolean read FSizeGrip write SetSizeGrip default false;
    property BevelInner: TLMDBevelStyle read FBevelInner write SetBevelInner default bvNone;
    property BevelOuter: TLMDBevelStyle read FBevelOuter write SetBevelOuter default bvRaised;
    property BevelWidth: TBevelWidth read FBevelWidth write SetBevelWidth default 1;
    property BevelSpaceColor: TColor read FBevelSpaceColor write SetBevelSpaceColor default clBtnFace;
    property ShowFocus: Boolean read FShowFocus write SetShowFocus default false;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsRight, ebsTop, ebsBottom];
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsNone;
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
    property BorderType: TElFlatBorderType read FBorderType write
        SetBorderType default fbtSunken;
    procedure RepaintRect(ARect: TRect); virtual;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function IsThemed: Boolean;
    function getLMDPackage:TLMDPackageID;
    property MouseInControl: Boolean read FMouseInControl;
    property Canvas;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;
  published
    property DoubleBuffered;
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    {$IFDEF LMCCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
  end;

  TElPanel = class(TCustomElPanel)
  published
    property WordWrap;
    property BorderSides;
    property BorderColorDkShadow;
    property BorderColorFace;
    property BorderColorShadow;
    property BorderColorHighlight;
    property BorderColorWindow;
    property BorderType;
    property AlphaLevel;
    property AlwaysPaintBackground;
    property Background;
    property BackgroundType;
    property GradientEndColor;
    property GradientStartColor;
    property GradientSteps;
    property Alignment;
    property Layout;
    property OwnerDraw;
    property ImageForm;
    property TopGrabHandle;
    property RightGrabHandle;
    property LeftGrabHandle;
    property BottomGrabHandle;

    property Resizable;
    property Movable;
    property OnMove;
    property OnPaint;

    property SizeGrip;
    property Align nodefault;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelSpaceColor;
    property BevelWidth;
    property BorderStyle;
    property BorderWidth;
    property TransparentXPThemes;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;

    property Color;

    property DragCursor;

    property DragMode;
    property Enabled;
    property Font;

    property Locked;
    property MouseCapture default False;

    property ParentColor;

    property ParentCtl3D;

    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowFocus;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property Caption;
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
    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnStartDrag;
    property OnDockOver;
    property OnDockDrop;
    property OnUnDock;
    property OnEndDock;
    property Anchors;
    property Constraints;
    property DockSite;
    property DockOrientation;
    property BevelKind;
    property DoubleBuffered default False;
    property DragKind;
    property OnContextPopup;
  end;

implementation

uses TypInfo, LMDGraphUtils;

procedure TElPanelGrabHandle.Assign(Source : TPersistent);
begin
  if Source is TElPanelGrabHandle then
  with TElPanelGrabHandle(Source) do
    begin
      Self.FEnabled := Enabled;
      Self.FSize := Size;
      Self.FKind := Kind;
      Self.FBevelKind := BevelKind;
      Self.FVisible := Visible;
      if (not (csLoading in Self.FOwner.ComponentState)) and (FOwner.HandleAllocated) then
      Self.FOwner.Invalidate;
    end
  else inherited;
end;

procedure TElPanelGrabHandle.SetEnabled(newValue : Boolean);
var
  R : TRect;
begin
  if (FEnabled <> newValue) then
  begin
    FEnabled := newValue;
    R := FOwner.ClientRect;
    FOwner.AlignControls(nil, R);
    FOwner.UpdateInterior;
    FOwner.Invalidate;
  end;  { if }
end;  { SetEnabled }

procedure TElPanelGrabHandle.SetBevelKind(newValue : TLMDBevelStyle);
begin
  if (FBevelKind <> newValue) then
  begin
    FBevelKind := newValue;
    if FOwner.Handleallocated then
      FOwner.Invalidate;
  end;  { if }
end;

procedure TElPanelGrabHandle.SetSize(newValue : Integer);
var R : TRect;
begin
  if (FSize <> newValue) then
  begin
    FSize := newValue;
    if FOwner.Handleallocated then
    begin
      R := FOwner.ClientRect;
      FOwner.AlignControls(nil, R);
      FOwner.UpdateInterior;
      FOwner.Invalidate;
    end;
  end;  { if }
end;  { SetSize }

procedure TElPanelGrabHandle.SetVisible(newValue : Boolean);
var R : TRect;
begin
  if (FVisible <> newValue) then
  begin
    FVisible := newValue;
    if FOwner.Handleallocated then
    begin
      R := FOwner.ClientRect;
      FOwner.AlignControls(nil, R);
      FOwner.UpdateInterior;
      FOwner.Invalidate;
    end;  { if }
  end;
end;  { SetVisible }

procedure TCustomElPanel.WMMouseMove(var Msg : TWMMouseMove); { private }
var aHandle : TElPanelGrabHandle;
    R : TRect;
begin
  inherited;
//  if (not FMouseInControl) then
//  begin
//    DoMouseEnter;
//  end;

  if FPressed then
  begin
    R := ClientRect;
    if BorderWidth <> 0 then InflateRect(R, -BorderWidth, -BorderWidth);
    if BevelInner <> bvNone then InflateRect(R, -BevelWidth, -BevelWidth);
    if BevelOuter <> bvNone then InflateRect(R, -BevelWidth, -BevelWidth);
    aHandle := InGrabHandle(Msg.XPos, Msg.YPos, R);
    if ((AHandle <> nil) and (AHandle.Kind = ghkMoveParent)) and not (csDesigning in ComponentState) then
    begin
      FPressed := false;
      ReleaseCapture;
      Parent.BringToFront;
      PostMessage(Parent.Handle, wm_SysCommand, sc_DragMove, Msg.XPos shl 16 + Msg.YPos);
      PostMessage(Parent.Handle, wm_KeyDown, VK_SPACE, 0);
      exit;
    end;
  end;
  if FPressed and (FMovable) and not (csDesigning in ComponentState)  then
  begin
    FPressed := false;
    ReleaseCapture;
    DoMouseLeave;
    BringToFront;
    PostMessage(Handle, wm_SysCommand, sc_DragMove, Msg.XPos shl 16 + Msg.YPos);
    PostMessage(Handle, wm_KeyDown, VK_SPACE, 0);
  end;
end; { WMMouseMove }

procedure TCustomElPanel.WMLButtonUp(var Msg : TWMLButtonUp); { private }
begin
  if FPressed then
  begin
    FPressed := false;
    if FSaveCapture <> 0 then
    begin
      SetCapture(FSaveCapture);
      FSaveCapture := 0;
    end
    else
      ReleaseCapture;
  end;
  inherited;
end; { WMLButtonUp }

procedure TCustomElPanel.WMLButtonDown(var Msg : TWMLButtonDown);
begin
  inherited;
  FPressed := true;
  if Movable then
    FSaveCapture := SetCapture(Handle);
end; {WMLButtonDown}

procedure TCustomElPanel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FImgForm then
    begin
      FImgForm := nil;
      if HandleAllocated then Invalidate;
    end;
  end;
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
end;

procedure TCustomElPanel.SetImageForm(newValue : TElImageForm);
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
    if FImgForm <> nil then FImgForm.RegisterChanges(FImgFormChLink);
    Invalidate;
  end;
end;

procedure TCustomElPanel.SetBackground(newValue : TBitmap);
begin
  FBackground.Assign(newValue);
  if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
     then BackgroundType := bgtColorFill;
end; {SetBackground}

procedure TCustomElPanel.SetBackgroundType(newValue : TLMDBackgroundType);
begin
  if (FBackgroundType <> newValue) then
  begin
    FBackgroundType := newValue;
    if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
       then FBackgroundType := bgtColorFill;
    RedoTmpBmp;
    Invalidate;
  end; {if}
end; {SetBackgroundType}

procedure TCustomElPanel.CreateParams(var Params : TCreateParams);
begin
  inherited;
  if Transparent and (not IsThemed) then
    Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT
  else
    Params.ExStyle := Params.ExStyle and not WS_EX_TRANSPARENT;
//  Params.WindowClass.style := Params.WindowClass.style or CS_HREDRAW or CS_VREDRAW;
end; { CreateParams }

procedure TCustomElPanel.WndProc(var Message : TMessage); { protected }
begin
  inherited;
  if (TLMDPtrUInt(Message.Msg) = ParentControlRepaintedMessage) and
     (Message.lParam <> TLMDPtrInt(Self)) then
    begin
      Invalidate;
//      if not (Assigned(Parent) and (Parent is TCustomElPanel)) then
        NotifyChildsThatRepaint(Message.WParam = 1);
    end;
end; { WndProc }

procedure TCustomElPanel.RepaintRect(ARect: TRect);
var
  Rect,
  CalcRect,
  R,
  R1, R2 : TRect;
  TopColor,
  BottomColor : TColor;
  C : integer;
  aHandle    : TElPanelGrabHandle;
  ACtl       : TWinControl;
  ax, ay     : integer;
  P          : TPoint;
  const

  Alignments : array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  Layouts    : array[TTextLayout] of Word = (DT_TOP, DT_VCENTER, DT_BOTTOM);

  procedure AdjustColors(Bevel : TLMDBevelStyle);
  begin
    if Bevel = LMDGraph.bvSpace then
    begin
      TopColor := BevelSpaceColor;
      BottomColor := BevelSpaceColor;
    end
    else
    begin
      TopColor := clBtnHighlight;
      if Bevel = bvLowered then TopColor := clBtnShadow;
      BottomColor := clBtnShadow;
      if Bevel = bvLowered then BottomColor := clBtnHighlight;
    end;
  end;

  procedure PaintGrabHandle(R : TRect; IsVert : boolean; BevelKind : TLMDBevelStyle);
  var X, Y   : integer;
      DX, DY,
      ox, oy : integer;
      Color1, Color2: TColor;
      LDetail: TThemedElementDetails;
      LThemeMode: TLMDThemeMode;
  begin
    if BevelKind = bvNone then exit;
    LThemeMode := UseThemeMode;
    if (lThemeMode <> ttmNone) then
    begin
      LDetail.Element := teToolBar; // GetThemedElement;
      if IsVert then
        LDetail.Part := TP_SEPARATOR
      else
        LDetail.Part := TP_SEPARATORVERT;
      if BevelKind = bvLowered then
        LDetail.State := BSS_SUNKEN
      else
        if BevelKind = bvRaised then
          LDetail.State := BSS_RAISED
        else
          if BevelKind = bvSpace then
            LDetail.State := BSS_FLAT;
      LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail, R, LMDRectToPtr(R));
    end
    else
    begin
      if bevelKind = bvRaised then
      begin
        Color1 := clBtnHighlight;
        Color2 := clBtnShadow;
      end else
      begin
        Color2 := clBtnHighlight;
        Color1 := clBtnShadow;
      end;
      if IsVert then
      begin
        x := R.Left + (R.Right - R.Left) div 2 - 1;
        y := R.Top + 1;
        DX := X;
        DY := R.Bottom - 1;
        ox := 1;
        oy := 0;
      end else
      begin
        x := R.Left + 1;
        y := R.Top + (R.Bottom - R.Top) div 2 - 1;
        DX := R.Right - 1;
        DY := y;
        ox := 0;
        oy := 1;
      end;
      Canvas.Brush.Color := color;
      Canvas.FillRect(R);
      Canvas.Pen.Color := Color1;
      MoveToEx(Canvas.Handle, X, Y, nil);
      LineTo(Canvas.Handle, DX, DY);
      Canvas.Pen.Color := Color2;
      MoveToEx(Canvas.Handle, X + ox, Y + oy, nil);
      LineTo(Canvas.Handle, DX + ox, DY + oy);
    end;
  end;
var
  Bmp : TBitmap;
  DC  : HDC;
  LFlag: integer;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  if (LThemeMode <> ttmNone) then
  begin
    DrawThemedBackground(ARect);
  end
  else
  begin
    if Transparent then
    begin
      DC := GetDC(Handle);
//      GetClipBox(Canvas.Handle, Rect);
      Rect := ARect;
      OffsetRect(Rect, Left, Top);
      //vb March 2006
      RedrawWindow(Parent.Handle, @Rect, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);

//      if Parent is TCustomElPanel then
//        if TCustomElPanel(Parent).Transparent or (TCustomElPanel(Parent).IsThemed and TCustomElPanel(Parent).TransparentXPThemes) then
//          RedrawWindow(Parent.Handle, @Rect, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW)
//        else
//          RedrawWindow({Parent.}Handle, @Rect, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);
      if AlphaLevel > 0 then
      begin
        OffsetRect(Rect, -Left, -Top);
        Bmp := TBitmap.Create;
        Bmp.Handle := CreateCompatibleBitmap(Canvas.Handle, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top);
        // DC := GetDC(Handle);
        bitblt(Bmp.Canvas.Handle, 0, 0, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, DC,
               Rect.Left, Rect.Top, SRCCOPY);
        ReleaseDC(Handle, DC);
        LMDAlphaFillRect(Bmp.Canvas, Classes.Rect(0, 0, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top), Color, AlphaLevel);
        bitblt(Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
               Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        Bmp.Free;
      end
      else
      begin
        OffsetRect(Rect, -Left, -Top);
        // DC := GetDC(Handle);
        bitblt(Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, DC, Rect.Left, Rect.Top, SRCCOPY);
        ReleaseDC(Handle, DC);
      end;
    end;
//    Rect := GetClientRect;
    Rect := ARect;
    if (not Transparent) and (not (OwnerDraw and ((not (csDesigning in ComponentState)) or FIntPaint)) or (AlwaysPaintBackground)) then
    begin
      with Canvas do
      begin
        if (FImgForm <> nil) and (FImgForm.GetRealControl <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
        begin
          if (FImgForm.Control <> Self) then
          begin
            Bmp := TBitmap.Create;
            Bmp.Handle := CreateCompatibleBitmap(Canvas.Handle, ClientRect.Right - ClientRect.Left, ClientRect.Bottom - ClientRect.Top);
            ACtl := FImgForm.GetRealControl;
            R1 := ClientRect;
            R2 := ClientRect;
            R2.TopLeft := ClientToScreen(R2.TopLeft);
            R2.BottomRight := ClientToScreen(R2.BottomRight);

            P := Parent.ClientToScreen(Point(Self.Left, Self.Top));
            ax := R2.Left - P.x;
            ay := R2.Top - P.y;

            R2.TopLeft := ACtl.ScreenToClient(R2.TopLeft);
            R2.BottomRight := ACtl.ScreenToClient(R2.BottomRight);

            FImgForm.PaintBkgnd(Bmp.Canvas.Handle, R1, Point(R2.Left - ax, R2.Top - ay), false);
            if AlphaLevel <> 0 then
            begin
              LMDAlphaFillRect(Bmp.Canvas, Classes.Rect(0, 0, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top), Color, AlphaLevel);
            end;
            bitblt(Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
                   Bmp.Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY);
            Bmp.Free;
          end;
        end
        else
        begin
          case BackgroundType of //
            bgtColorFill :
              begin
                Brush.Color := Color;
                FillRect(Rect);
              end;
            bgtHorzGradient, bgtVertGradient, bgtSquareGradient, bgtEllipticGradient,
            bgtTopLeftGradient, bgtTopRightGradient, bgtBottomLeftGradient,
            bgtBottomRightGradient, bgtTopLeftDiagonalGradient, bgtTopRightDiagonalGradient:
            begin
              Bmp := TBitmap.Create;
              Bmp.Handle := CreateCompatibleBitmap(Canvas.Handle, ClientRect.Right - ClientRect.Left, ClientRect.Bottom - ClientRect.Top);
              LMDGradientPaint(Bmp.Canvas, ClientRect, GradientStartColor, GradientEndColor, GradientSteps, LMDBackgroundType2GradientStyle[BackgroundType], 0, 0);
              bitblt(Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
                     Bmp.Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY);
              Bmp.Free;
            end;
            bgtStretchBitmap,
            bgtTileBitmap:
              begin
                Bmp := TBitmap.Create;
                Bmp.Handle := CreateCompatibleBitmap(Canvas.Handle, ClientRect.Right - ClientRect.Left, ClientRect.Bottom - ClientRect.Top);
                Bmp.Canvas.CopyRect(Rect, FTmpBmp.Canvas, Rect);
                bitblt(Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
                       Bmp.Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY);
                Bmp.Free;
              end;
            bgtCenterBitmap :
              begin
                Bmp := TBitmap.Create;
                Bmp.Handle := CreateCompatibleBitmap(Canvas.Handle, ClientRect.Right - ClientRect.Left, ClientRect.Bottom - ClientRect.Top);
                Bmp.Canvas.Brush.Color := Color;
                Bmp.Canvas.FillRect(Rect);
                R := Classes.Rect(0, 0, FBackground.Width, FBackground.Height);
                LMDCenterRects(FBackground.Width, ClientRect.Right - ClientRect.Left, FBackground.Height, ClientRect.Bottom - ClientRect.Top, R1);
                OffsetRect(R1, ClientRect.Left, ClientRect.Top);
                Bmp.Canvas.CopyRect(R1, FBackground.Canvas, R);
                bitblt(Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
                       Bmp.Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY);
                Bmp.Free;
              end;
            bgtTopLeftBitmap:
              begin
                if Background.Empty then
                  FillRect(Rect)
            else
            begin
              Bmp := TBitmap.Create;
              Bmp.Handle := CreateCompatibleBitmap(Canvas.Handle, ClientRect.Right - ClientRect.Left, ClientRect.Bottom - ClientRect.Top);
              if BackgroundType = bgtTopLeftBitmap then
              begin
                Color := Background.Canvas.Pixels[Background.Width-1, Background.Height-1];
                end;
              R1 := Rect;
              OffsetRect(R1, -Rect.Left, -Rect.Top);
              LMDExtDrawBkgnd2(Bmp.Canvas.Handle, ClientRect, ClientRect, R1.TopLeft, Color, Background, BackgroundType);
              bitblt(Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
                     Bmp.Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY);
              Bmp.Free;
            end;
              end;
          end; // case
        end;
      end;
    end;
  end;

  Rect := GetClientRect;
  if FBorderStyle <> bsNone then
    DrawFlatFrameEx2(Canvas.Handle, Rect, BorderColorFace, Color, Focused, Enabled, FBorderSides, FBorderType, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);

  if BevelOuter <> bvNone then
  begin
    if LThemeMode <> ttmNone then
    begin
      if BevelOuter = bvLowered then
      begin
        LMDThemeServices.DrawThemeEdge(LThemeMode, Canvas.Handle, GetThemedElement, GP_BORDER, BSS_SUNKEN, Rect, BDR_SUNKENOUTER, BF_RECT or BF_ADJUST, LMDRectToPtr(Rect));
      end
      else
      if BevelOuter = bvRaised then
      begin
        LMDThemeServices.DrawThemeEdge(LThemeMode, Canvas.Handle, GetThemedElement, GP_BORDER, BSS_RAISED, Rect, BDR_RAISEDOUTER, BF_RECT or BF_ADJUST, LMDRectToPtr(Rect));
      end;
    end
    else
    begin
      AdjustColors(BevelOuter);
      Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
    end;
  end;

  if LThemeMode <> ttmNone then
  begin
    InflateRect(Rect, - BevelWidth, - BevelWidth);
  end;
//  else

//  if not NoPaintBorder then
//     Frame3D(Canvas, Rect, clRed{Color}, Color, BorderWidth);
  if BevelInner <> bvNone then
  begin
    if LThemeMode <> ttmNone then
    begin
      if BevelInner = bvLowered then
      begin
        LMDThemeServices.DrawThemeEdge(LThemeMode, Canvas.Handle, GetThemedElement, GP_BORDER, BSS_SUNKEN, Rect, BDR_SUNKENOUTER, BF_RECT or BF_ADJUST, LMDRectToPtr(Rect));
      end
      else
      if BevelOuter = bvRaised then
      begin
        LMDThemeServices.DrawThemeEdge(LThemeMode, Canvas.Handle, GetThemedElement, GP_BORDER, BSS_RAISED, Rect, BDR_RAISEDOUTER, BF_RECT or BF_ADJUST, LMDRectToPtr(Rect));
      end;
    end
    else
    begin
      AdjustColors(BevelInner);
      Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
    end;
  end;

  aHandle := LeftGrabHandle;
  if aHandle.Visible and aHandle.Enabled and (aHandle.BevelKind <> bvNone) then
  begin
    R := Rect;
    R.Right := R.Left + aHandle.Size;
    Inc(Rect.Left, aHandle.Size);
    PaintGrabHandle(R, true, aHandle.BevelKind);
  end;

  aHandle := RightGrabHandle;
  if aHandle.Visible and aHandle.Enabled and (aHandle.BevelKind <> bvNone) then
  begin
    R := Rect;
    R.Left := R.Right - aHandle.Size;
    Dec(Rect.Right, aHandle.Size);
    PaintGrabHandle(R, true, aHandle.BevelKind);
  end;

  aHandle := TopGrabHandle;
  if aHandle.Visible and aHandle.Enabled and (aHandle.BevelKind <> bvNone) then
  begin
    R := Rect;
    R.Bottom := R.Top + aHandle.Size;
    Inc(Rect.Top, aHandle.Size);

    PaintGrabHandle(R, false, aHandle.BevelKind);
  end;

  aHandle := BottomGrabHandle;
  if aHandle.Visible and aHandle.Enabled and (aHandle.BevelKind <> bvNone) then
  begin
    R := Rect;
    R.Top := R.Bottom - aHandle.Size;
    Dec(Rect.Bottom, aHandle.Size);
    PaintGrabHandle(R, false, aHandle.BevelKind);
  end;

  if OwnerDraw and ((not (csDesigning in ComponentState)) or FIntPaint) then
    TriggerPaintEvent
  else
  with Canvas do
  begin
    Brush.Style := bsClear;
    Font := Self.Font;
    R1 := Rect;

    if FLayout <> tlTop then
    begin
      CalcRect := Rect;
      AdjustClientRect(CalcRect);
      LFlag := DT_EXPANDTABS or Alignments[Alignment] or DT_CALCRECT;
      {$ifdef LMD_UNICODE}
      LMDDrawText(Canvas.Handle, Caption, -1, CalcRect, LFlag);
      if WordWrap and (CalcRect.Right - CalcRect.Left > Width) then
      begin
        CalcRect.Right := CalcRect.Left + Width;
        LMDDrawText(Canvas.Handle, Caption, -1, CalcRect, LFlag or DT_WORDBREAK);
      end;
     {$else}
      DrawText(Canvas.Handle,PChar(Caption), -1, CalcRect, LFlag);
      if WordWrap and (CalcRect.Right - CalcRect.Left > Width) then
      begin
        CalcRect.Right := CalcRect.Left + Width;
        DrawText(Canvas.Handle,PChar(Caption), -1, CalcRect, LFlag or DT_WORDBREAK);
      end;
      {$endif}

      if FLayout = tlBottom then
        OffsetRect(R1, 0, ((R1.Bottom - R1.Top) - (CalcRect.Bottom - CalcRect.Top)))
      else
      if FLayout = tlCenter then
        OffsetRect(R1, 0, ((R1.Bottom - R1.Top) - (CalcRect.Bottom - CalcRect.Top)) div 2);
    end;

    LFlag := DT_EXPANDTABS or Alignments[Alignment];
    if WordWrap then
      LFlag := LFlag or DT_WORDBREAK;
    LMDDrawText(Handle, Caption, -1, R1, LFlag);
    if (ShowFocus) and
    (GetFocus = Self.Handle)
    then
      DrawFocusRect(R1);
  end;

  if SizeGrip and Resizable then
  begin
    if LThemeMode <> ttmNone then
    begin
      R := ClientRect;
      inc(R.Top, 2);
      R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL) - 1;
      dec(R.Bottom);
      dec(R.Right);
      if not IsRectEmpty(R) then
      begin
        LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, tsGripper, R);
        R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);
        SizeGripRect := R;
      end;
    end
    else
    begin
      R := Rect;
      R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);
      R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
      SizeGripRect := R;

      C := R.Bottom - R.Top + 1;
      R.Left := R.Right - C;
      R.Top := R.Bottom - C;
      DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);
      (*
      {.$else}
      i := 4;
      C := R.Bottom - R.Top;

      OffsetRect(R, 0, -2);
      while true do
      begin
        R.Left := R.Right - C + i;
        R.Top := R.Bottom - C + i;
        Canvas.Pen.Color := clBtnHighlight;
        Canvas.MoveTo(R.Left, R.Bottom);
        Canvas.LineTo(R.Right, R.Top);
        Inc(R.Left);
        Inc(R.Top);
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(R.Left, R.Bottom);
        Canvas.LineTo(R.Right, R.Top);
        Inc(R.Left);
        Inc(R.Top);
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(R.Left, R.Bottom);
        Canvas.LineTo(R.Right, R.Top);
        inc(i, 4);
        if i >= c then break;
      end;
      *)
      end;
  end;
end;

procedure TCustomElPanel.Paint;
var
  LR: TRect;
begin
  LR := Canvas.ClipRect;
  if IsRectEmpty(LR) then
  begin
    LR := BoundsRect;
    OffsetRect(LR, -LR.Left, -LR.Top);
  end;
  RepaintRect(LR);
end;

procedure TCustomElPanel.Loaded;
begin
  inherited;
  UpdateStyle;
  if OwnerDraw then
    Invalidate;
  if Transparent then
    NotifyChildsThatRepaint;
end;

procedure TCustomElPanel.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
var
  R: TRect;
begin
  if (not DoubleBuffered) or (LPARAM(TMessage(Msg).wParam) = TMessage(Msg).lParam) then
    begin
      if IsThemed then
        begin
          if not TransparentXPThemes then
            begin
              Canvas.Handle := Msg.DC;
              Canvas.Brush.Color := Color;
              R := ClientRect;
              Canvas.FillRect(R);
              Canvas.Handle := 0;
            end
        else
          begin
            R := ClientRect;
            if Assigned(Parent) then
              if Parent.DoubleBuffered then
                SendMessage(Parent.Handle, WM_ERASEBKGND, Msg.DC, Msg.DC)
              else
                //This was restored because of transparency issue
                //DrawThemeParentBackground causes controls to be erased from parent (BTS#758 runtime issue)
                //Workaround for #758 is setting Parent.DoubleBuffered to true
                DrawThemeParentBackground(Handle, Msg.DC, @R);
          end
        end
      else
        begin
          if Transparent then
            begin
              if not FIsUpdated and Assigned(Parent) then
                SendMessage(parent.Handle, WM_ERASEBKGND, Msg.DC, Msg.DC);
            end
          else
            begin
              if not (FBackgroundType in [bgtStretchBitmap, bgtTileBitmap, bgtHorzGradient, bgtVertGradient]) then
                begin
                  Canvas.Handle := Msg.DC;
                  Canvas.Brush.Color := Color;
                  Canvas.FillRect(ClientRect);
                  Canvas.Handle := 0;
                  inherited;
                end;
            end;
        end;
    end;
  Msg.Result := 1;
end;

procedure TCustomElPanel.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElPanel.ImageChange(Sender : TObject);
begin
  if ((FBackground.Height = 0) or (FBackground.Width = 0)) then
    BackgroundType := bgtColorFill
  else
  begin
    if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then RedoTmpBmp;
    Invalidate;
  end;
end;

procedure TCustomElPanel.SetResizable(newValue : Boolean);
begin
  if (FResizable <> newValue) then
  begin
    FResizable := newValue;
    if SizeGrip then
      Invalidate;
  end; {if}
end; {SetResizable}

function TCustomElPanel.InGrabHandle(X, Y : integer; Rect : TRect) : TElPanelGrabHandle;
var aHandle : TElPanelGrabHandle;
    R : TRect;
begin
  aHandle := LeftGrabHandle;
  if aHandle.Enabled then
  begin
    R := Rect;
    R.Right := R.Left + aHandle.Size;
    if PtInRect(R, Point(X, Y)) then
    begin
      result := aHandle;
      exit;
    end;
  end;

  aHandle := RightGrabHandle;
  if aHandle.Enabled then
  begin
    R := Rect;
    R.Left := R.Right - aHandle.Size;
    if PtInRect(R, Point(X, Y)) then
    begin
      result := aHandle;
      exit;
    end;
  end;

  aHandle := TopGrabHandle;
  if aHandle.Enabled then
  begin
    R := Rect;
    R.Bottom := R.Top + aHandle.Size;
    if PtInRect(R, Point(X, Y)) then
    begin
      result := aHandle;
      exit;
    end;
  end;

  aHandle := BottomGrabHandle;
  if aHandle.Enabled then
  begin
    R := Rect;
    R.Top := R.Bottom - aHandle.Size;
    if PtInRect(R, Point(X, Y)) then
    begin
      result := aHandle;
      exit;
    end;
  end;
  result := nil;
end;

procedure TCustomElPanel.WMNCHitTest(var Msg : TWMNCHitTest);
var
  R : TRect;
  P : TPoint;
  bv: integer;
  aHandle : TElPanelGrabHandle;

begin
  inherited;
  if BevelInner <> bvNone then bv := BevelWidth else bv := 0;
  if BevelOuter <> bvNone then bv := bv + BevelWidth;
  bv := bv + BorderWidth;

  if bv = 0 then bv := 1;
  with Msg do
  begin
    P.x := XPos;
    P.y := YPos;
    P := ScreenToClient(P);
    R := BoundsRect;
    OffsetRect(R, -R.Left, -R.Top);
  end;
  if FResizable and not (csDesigning in Componentstate) then
  with Msg do
  begin
    Result := HitTest(R, P, R.Bottom div 8, BevelWidth);
    if (Result = HTCLIENT) and SizeGrip then
    begin
      if PtInRect(SizeGripRect, P) then
        result := HTBOTTOMRIGHT;
    end;
  end
  else
  begin
    InflateRect(R, - bv, -bv);
    AHandle := InGrabHandle(P.X, P.Y, R);
    if AHandle <> nil then
    begin
      if (AHandle.Kind = ghkMove) and not (csDesigning in ComponentState) then
      begin
        Msg.result := HTCaption;
        BringToFront;
        exit;
      end;
      if (AHandle.Kind = ghkResize) and not (csDesigning in ComponentState) then
      begin
        if AHandle = TopGrabHandle then Msg.result := HTTOP else
        if AHandle = bottomGrabHandle then Msg.result := HTBOTTOM else
        if AHandle = LeftGrabHandle then Msg.result := HTLEFT else
        if AHandle = RightGrabHandle then Msg.result := HTRIGHT;
      end;
    end;
  end;
end; {WMNCHitTest}

procedure TCustomElPanel.SetMovable(newValue : Boolean);
begin
  if (FMovable <> newValue) then
  begin
    FMovable := newValue;
  end; {if}
end;

procedure TCustomElPanel.WMMove(var Msg : TWMMove);
begin
  inherited;
//  if Transparent or (IsThemed and TransparentXPThemes) then
//    Invalidate;
  TriggerMoveEvent;
end; { WMMove }

procedure TCustomElPanel.TriggerMoveEvent;
begin
  if (assigned(FOnMove)) then FOnMove(Self);
end; { TriggerMoveEvent }

procedure TCustomElPanel.SetTransparent(newValue : Boolean);
{ Sets data member FTransparent to newValue. }
begin
  if (FTransparent <> newValue) then
  begin
    FTransparent := newValue;
    if FTransparent then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    RecreateWnd;
  end; { if }
end; { SetTransparent }

procedure TCustomElPanel.SetCaption(newValue: TLMDString);
{ Sets data member FCaption to newValue. }
begin
  FCaption := newValue;
  inherited Caption := newValue;
end; { SetCaption }

procedure TCustomElPanel.RedoTmpBmp;
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
      BgRect := GetBackgroundClientRect;
      BgRect2 := BgRect;

      FTmpBmp.Height := BgRect.Bottom - BgRect.Top;
      FTmpBmp.Width := BgRect.Right - BgRect.Left;
      OffsetRect(BgRect2, BgRect2.Left, BgRect2.Top);
      LMDExtDrawBkgnd(FTmpBmp.Canvas.Handle, BgRect, BgRect, BgRect, BgRect2, false, Color, Color,  Background, BackgroundType);
    end;
  end;
end;

procedure TCustomElPanel.WMEnterSizeMove(var Msg : TMessage);
begin
  GetWindowRect(Handle, FSizeMoveRect);
  inherited;
end;

procedure TCustomElPanel.WMExitSizeMove(var Msg : TMessage);
var i,
    j : integer;
    R : TRect;
begin
  inherited;
  GetWindowRect(Handle, R);
  if (((R.Right - R.Left) = (FSizeMoveRect.Right - FSizeMoveRect.Left)) and
     ((R.Bottom - R.Top) = (FSizeMoveRect.Bottom - FSizeMoveRect.Top))) or
     ((FSizeMoveRect.Left <> R.Left) or (FSizeMoveRect.Top <> R.Top)) then
  begin
    if Assigned(FOnMove) then
      FOnMove(Self);
  end;
  Parent.Realign;
  j := ControlCount - 1;
  for i := 0 to j do
    Controls[i].Invalidate;
end;

procedure TCustomElPanel.WMSize(var Msg : TWMSize);  { private }

  procedure NotifyPart;
  var
    i: integer;
  begin
    if not (csLoading in ComponentState) and
       not (csDestroying in ComponentState) then
    begin
      for i := 0 to ControlCount - 1 do
        if (not ((csLoading in Controls[i].ComponentState) or
           (csDestroying in Controls[i].ComponentState))) then
        begin
          if (Controls[i] is TElXPThemedControl) then
            if ((FSize.cx < Msg.Width) and
                (Controls[i].Left + Controls[i].Width >= FSize.cx) and
                (Controls[i].Left - 2 <= Msg.Width)) or
               ((FSize.cy < Msg.Height) and
                (Controls[i].Top + Controls[i].Height >= FSize.cy) and
                (Controls[i].Top - 2 <= Msg.Height)) then
            begin
              if TElXPThemedControl(Controls[i]).HandleAllocated then
                PostMessage(TElXPThemedControl(Controls[i]).Handle,
                  ParentControlRepaintedMessage, 0, TLMDPtrInt(Self));
            end;

          if (Controls[i] is TCustomElPanel) then
            if ((FSize.cx <> Msg.Width) and
                (Controls[i].Left + Controls[i].Width + 2 > FSize.cx) and
                (Controls[i].Left - 2 < Msg.Width)) or
               ((FSize.cy <> Msg.Height) and
                (Controls[i].Top + Controls[i].Height + 2 > FSize.cy) and
                (Controls[i].Top - 2 < Msg.Height)) then
            begin
              if TCustomElPanel(Controls[i]).HandleAllocated then
                PostMessage(TCustomElPanel(Controls[i]).Handle,
                  ParentControlRepaintedMessage, 1, TLMDPtrInt(Self));
            end;

          if (Controls[i] is TElCustomGraphicControl) then
            if ((FSize.cx <> Msg.Width ) and
                (Controls[i].Left + Controls[i].Width + 2 > FSize.cx) and
                (Controls[i].Left - 2 < Msg.Width)) or
               ((FSize.cy <> Msg.Height) and
                (Controls[i].Top + Controls[i].Height + 2 > FSize.cy) and
                (Controls[i].Top - 2 < Msg.Height)) then
               TElCustomGraphicControl(Controls[i]).Invalidate;
        end;
    end;
  end;

  procedure NotifyAll;
  var
    i: integer;
  begin
    if (not ((csLoading in ComponentState) or (csDestroying in ComponentState))) then
    begin
      for i := 0 to ControlCount - 1 do
        if (not ((csLoading in Controls[i].ComponentState) or (csDestroying in Controls[i].ComponentState))) then
        begin
          if (Controls[i] is TElXPThemedControl) then
            PostMessage(TElXPThemedControl(Controls[i]).Handle, ParentControlRepaintedMessage, 0, TLMDPtrInt(Self));
          if (Controls[i] is TCustomElPanel) then
            PostMessage(TCustomElPanel(Controls[i]).Handle, ParentControlRepaintedMessage, 1, TLMDPtrInt(Self));
          if (Controls[i] is TElCustomGraphicControl) then
            TElCustomGraphicControl(Controls[i]).Invalidate;
        end;
    end;
  end;

var
  LRect: TRect;
begin
  if ((not IsThemed and Transparent) or (UseXPThemes and TransparentXPThemes)) and
     ((Parent is TElXPThemedControl) or (Parent is TCustomElPanel)) then
  begin
    RedoTmpBmp;
    Invalidate;
    if not (Assigned(Parent) and (Parent is TCustomElPanel)) then
      NotifyChildsThatRepaint(True);
  end
  else if IsThemed then
  begin
    if Resizable and SizeGrip then
      Invalidate;
    NotifyPart;
  end
  else if BackgroundType in [bgtStretchBitmap, bgtTileBitmap, bgtCenterBitmap,
                             bgtHorzGradient, bgtVertGradient] then
  begin
    RedoTmpBmp;
    Invalidate;
    NotifyAll;
  end
  else
  begin
    if Resizable and SizeGrip then
      Invalidate;
    NotifyPart;
  end;

  if RightGrabHandle.Visible then
  begin
    LRect := Rect(FSize.cx - RightGrabHandle.Size, 0, Msg.Width, Height);
    RepaintRect(LRect);
  end;
  if BottomGrabHandle.Visible then
  begin
    LRect := Rect(0, FSize.cy - BottomGrabHandle.Size, Width, Msg.Height);
    RepaintRect(LRect);
  end;
  if TopGrabHandle.Visible then
  begin
    LRect := Rect(0, 0, Msg.Width, TopGrabHandle.Size);
    RepaintRect(LRect);
  end;

  FSize.cx := Msg.Width;
  FSize.cy := Msg.Height;

  inherited;
end;  { WMSize }

function TCustomElPanel.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

procedure TCustomElPanel.SetGradientStartColor(newValue : TColor);
{ Sets data member FGradientStartColor to newValue. }
begin
  if (FGradientStartColor <> newValue) then
  begin
    FGradientStartColor := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then
      Invalidate;
  end;  { if }
end;  { SetGradientStartColor }

procedure TCustomElPanel.SetGradientEndColor(newValue : TColor);
{ Sets data member FGradientEndColor to newValue. }
begin
  if (FGradientEndColor <> newValue) then
  begin
    FGradientEndColor := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then
      Invalidate;
  end;  { if }
end;  { SetGradientEndColor }

procedure TCustomElPanel.SetGradientSteps(newValue : Integer);
{ Sets data member FGradientSteps to newValue. }
begin
  if (FGradientSteps <> newValue) and (newValue > 0) then
  begin
    FGradientSteps := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then
      Invalidate;
  end;  { if }
end;  { SetGradientSteps }

procedure TCustomElPanel.SetLayout(newValue : TTextLayout);
{ Sets data member FLayout to newValue. }
begin
  if (FLayout <> newValue) then
  begin
    FLayout := newValue;
    if inherited Caption <> '' then
      Invalidate;
  end;  { if }
end;  { SetLayout }

procedure TCustomElPanel.TriggerPaintEvent;
begin
  if (assigned(FOnPaint)) then FOnPaint(Self);
end;  { TriggerPaintEvent }

procedure TCustomElPanel.SetOwnerDraw(newValue : Boolean);
{ Sets data member FOwnerDraw to newValue. }
begin
  if (FOwnerDraw <> newValue) then
  begin
    FOwnerDraw := newValue;
    if (not (csDesigning in ComponentState)) and (not (csLoading in ComponentState)) then
      Invalidate;
  end;  { if }
end;

procedure TCustomElPanel.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

{ SetOwnerDraw }

function TCustomElPanel.GetTopGrabHandle : TElPanelGrabHandle;
{ Returns the value of data member FTopGrabHandle. }
begin
  result := FGrabHandles[2];
end;  { GetTopGrabHandle }

procedure TCustomElPanel.SetTopGrabHandle(newValue : TElPanelGrabHandle);
{ Sets data member FTopGrabHandle to newValue. }
begin
  FGrabHandles[2].Assign(newValue);
end;  { SetTopGrabHandle }

function TCustomElPanel.GetRightGrabHandle : TElPanelGrabHandle;
{ Returns the value of data member FRightGrabHandle. }
begin
  result := FGrabHandles[3];
end;  { GetRightGrabHandle }

procedure TCustomElPanel.SetRightGrabHandle(newValue : TElPanelGrabHandle);
{ Sets data member FRightGrabHandle to newValue. }
begin
  FGrabHandles[3].Assign(newValue);
end;  { SetRightGrabHandle }

function TCustomElPanel.GetLeftGrabHandle : TElPanelGrabHandle;
{ Returns the value of data member FLeftGrabHandle. }
begin
  result := FGrabHandles[1];
end;  { GetLeftGrabHandle }

procedure TCustomElPanel.SetLeftGrabHandle(newValue : TElPanelGrabHandle);
{ Sets data member FLeftGrabHandle to newValue. }
begin
  FGrabHandles[1].Assign(newValue);
end;  { SetLeftGrabHandle }

function TCustomElPanel.GetBottomGrabHandle : TElPanelGrabHandle;
{ Returns the value of data member FBottomGrabHandle. }
begin
  result := FGrabHandles[4];
end;  { GetBottomGrabHandle }

procedure TCustomElPanel.SetBottomGrabHandle(newValue : TElPanelGrabHandle);
{ Sets data member FBottomGrabHandle to newValue. }
begin
  FGrabHandles[4].Assign(newValue);
end;  { SetBottomGrabHandle }

procedure TCustomElPanel.SetAlwaysPaintBackground(Value : boolean);
begin
  if (Value <> FAlwaysPaintBackground) then
  begin
    FAlwaysPaintBackground := Value;
    if FOwnerDraw then
      Invalidate;
  end;
end;

procedure TCustomElPanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited;
  if FBorderStyle = bsNone then Exit;
end;

procedure TCustomElPanel.AdjustClientRect(var Rect : TRect);
var
  bCheckBorderSides: Boolean;
begin
  inherited;

  bCheckBorderSides := (BevelInner = bvNone) and (BevelOuter = bvNone) and
                       (FBorderStyle <> bsNone) and (FBorderType <> fbtNone);
  if LeftGrabHandle.Visible and LeftGrabHandle.Enabled then
    Inc(Rect.Left, LeftGrabHandle.FSize)
  else
    if bCheckBorderSides and (ebsLeft in FBorderSides) then Inc(Rect.Left, 2);

  if TopGrabHandle.Visible and TopGrabHandle.Enabled then
    Inc(Rect.Top, TopGrabHandle.FSize)
  else
    if bCheckBorderSides and (ebsTop in FBorderSides) then Inc(Rect.Top, 2);

  if RightGrabHandle.Visible and RightGrabHandle.Enabled then
    Dec(Rect.Right, RightGrabHandle.FSize)
  else
    if bCheckBorderSides and (ebsRight in FBorderSides) then Dec(Rect.Right, 2);

  if BottomGrabHandle.Visible and BottomGrabHandle.Enabled then
    Dec(Rect.Bottom, BottomGrabHandle.FSize)
  else
    if bCheckBorderSides and (ebsBottom in FBorderSides) then Dec(Rect.Bottom, 2);
end;

destructor TCustomElPanel.Destroy;
var i : integer;
begin
  ImageForm := nil;
  FImgFormChLink.Free;
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
  FBackground.Free;
  FTmpBmp.Free;
  for i := 1 to 4 do FGrabHandles[i].Free;
  inherited Destroy;
end; {Destroy}

constructor TCustomElPanel.Create(AOwner : TComponent);
var i : integer;
begin
  BeginCreate;
  inherited Create(AOwner);

  FThemeMode := ttmPlatform;
  FTransparentXPThemes := true;
  FImgFormChLink  := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
  for i := 1 to 4 do
  begin
    FGrabHandles[i] := TElPanelGrabHandle.Create;
    FGrabHandles[i].FOwner := Self;
  end;
  ControlStyle := ControlStyle + [csOpaque];

  FBorderSides := AllBorderSides;
  FBorderStyle := bsNone;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
  FBorderType := fbtSunken;
  FBackground := TBitmap.Create;
  FBackground.OnChange := ImageChange;
  FBackgroundType := bgtColorFill;
  FGradientSteps := 16;
  FTmpBmp := TBitmap.Create;
  FTmpBmp.PixelFormat := pf24bit;
  FullRepaint := false;
  FLayout := tlCenter;
  BevelOuter := bvRaised;
  BevelWidth := 1;
  FBevelSpaceColor := clBtnFace;

  EndCreate;
end; {Create}

procedure TCustomElPanel.DoMouseEnter;
begin
  FMouseInControl := true;
  if assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TCustomElPanel.DoMouseLeave;
begin
  FMouseInControl := false;
  if assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

function TCustomElPanel.GetCaption: TLMDString;
begin
  Result := FCaption;
end;

procedure TCustomElPanel.SetAlphaLevel(Value: Byte);
begin
  if FAlphaLevel <> Value then
  begin
    FAlphaLevel := Value;
    if Transparent then
      Invalidate;
  end;
end;

procedure TCustomElPanel.CMMouseEnter(var Message: TMessage);
begin
  inherited;
//  if not FMouseInControl then
  DoMouseEnter;
end;

procedure TCustomElPanel.CMMouseLeave(var Message: TMessage);
//  function IsParent(CaptureControl: TControl): Boolean;
//  begin
//    Result := False;
//    while Assigned(CaptureControl.Parent) do
//    begin
//      if CaptureControl.Parent = Self then
//      begin
//        Result := True;
//        Break;
//      end;
//      CaptureControl := CaptureControl.Parent;
//    end;
//  end;
//var
//  CaptureControl: TControl;
//  P: TPoint;
begin
  inherited;
//  GetCursorPos(P);
//  CaptureControl := FindDragTarget(P, True);
//  if ((Message.LParam = 0) and Assigned(CaptureControl) and (not IsParent(CaptureControl)){or (Message.LParam = TLMDPtrInt(Self)})}) or
//    ((Message.LParam <> 0) and Assigned(CaptureControl) and (CaptureControl <> Self)) then
  DoMouseLeave;
end;

procedure TCustomElPanel.PaintWindow(DC: HDC);
var
  MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  R : TRect;
  ARgn : HRGN;
begin
  MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
  MemDC := CreateCompatibleDC(DC);
  OldBitmap := SelectObject(MemDC, MemBitmap);
  try
    GetClipBox(DC, R);
    with R do
      ARgn := CreateRectRgn(Left, Top, right, Bottom);
    SelectClipRgn(MemDC, ARgn);
    //InvalidateRect(MemDC, @R, false);
    Perform(WM_ERASEBKGND, MemDC, MemDC);
    Canvas.Lock;
    try
      Canvas.Handle := MemDC;
      try
        TControlCanvas(Canvas).UpdateTextFlags;
        Paint;
      finally
        Canvas.Handle := 0;
      end;
    finally
      Canvas.Unlock;
    end;

    SelectClipRgn(MemDC, 0);
    //SelectClipRgn(DC, ARgn);
    with R do
      BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
    if ARgn <> 0 then
      DeleteObject(ARgn);
  finally
    SelectObject(MemDC, OldBitmap);
    DeleteDC(MemDC);
    DeleteObject(MemBitmap);
  end;
end;

procedure TCustomElPanel.WMPaint(var Msg : TWMPaint);
(*
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R : TRect;
  ARgn : HRGN;
  i,
  SaveIndex : integer;
  Clip      : integer;
  DoPaint   : boolean;
*)
  (*
  type TRectArray = array[0..65535] of TRect;

  procedure ReportRgn(ARgn : HRGN);
  var RgnData  : PRgnData;
      Rects    : ^TRectArray;
      RgnCount,
      i        : integer;
  begin
    RgnCount := GetRegionData(ARgn, 0, nil);
    GetMem(RgnData, RgnCount);
    GetRegionData(ARgn, RgnCount, RgnData);
    SendDebug('Region begin');
    Rects := @RgnData^.Buffer;
    for i := 0 to RgnData^.rdh.nCount - 1 do
    begin
      with Rects[i] do
      SendDebug(Format('Rectange %d: ((%d, %d), (%d, %d))', [i, Left, Top, Right, Bottom]));
    end;
    SendDebug('Region end');
  end; *)

begin
  inherited;
  exit;
  // PaintHandler(Msg);
  (*
  exit;

  if (Msg.DC <> 0) or Transparent then
    PaintHandler(Msg)
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      DoPaint := true;

      SaveIndex := SaveDC(DC);

      // check whether we have anything to paint
      if ControlCount <> 0 then
      begin
        Clip := SimpleRegion;
        for I := 0 to ControlCount - 1 do
          with TControl(Controls[I]) do
            if (Visible or (csDesigning in ComponentState) and
              not (csNoDesignVisible in ControlStyle)) and
              (csOpaque in ControlStyle) then
            begin
              Clip := ExcludeClipRect(DC, Left, Top, Left + Width, Top + Height);
              if Clip = NullRegion then
              begin
                DoPaint := false;
                break;
              end;
            end;

        if DoPaint then
        begin
          GetClipBox(DC, R);
          with R do
            ARgn := CreateRectRgn(Left, Top, right, Bottom);
          if Clip = ComplexRegion then
          begin
            GetClipRgn(DC, ARgn);
            ReportRgn(ARgn);
          end;
        end
        else
          ARgn := 0;
        RestoreDC(DC, SaveIndex);
      end
      else
      begin
        GetClipBox(DC, R);
        if IsRectEmpty(R) then
          R := ClientRect
        else
        begin
          if not EqualRect(R, ClientRect) then
            InflateRect(R, 1, 1);
        end;

        with R do
          ARgn := CreateRectRgn(Left, Top, right, Bottom);
      end;


      // do actual painting
      if DoPaint then
      begin
        SelectClipRgn(MemDC, ARgn);
        //InvalidateRect(MemDC, @R, false);
        Perform(WM_ERASEBKGND, MemDC, MemDC);
        Msg.DC := MemDC;
        WMPaint(Msg);
        SelectClipRgn(MemDC, 0);
        Msg.DC := 0;
        //SelectClipRgn(DC, ARgn);
        with R do
          BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
      end;
      if ARgn <> 0 then
        DeleteObject(ARgn);

      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
  *)
end;  { WMPaint }

{
procedure TCustomElPanel.WMPaint(var Msg : TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R : TRect;
  ARgn : HRGN;
  (*
  i,
  SaveIndex : integer;
  Clip      : integer;
  *)
  DoPaint   : boolean;

begin
  (*inherited;
  exit;
  *)
  if (Msg.DC <> 0) or Transparent then
    PaintHandler(Msg)
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      DoPaint := true;

      (*
      SaveIndex := SaveDC(DC);

      // check whether we have anything to paint
      if ControlCount <> 0 then
      begin
        Clip := SimpleRegion;
        for I := 0 to ControlCount - 1 do
          with TControl(Controls[I]) do
            if (Visible or (csDesigning in ComponentState) and
              not (csNoDesignVisible in ControlStyle)) and
              (csOpaque in ControlStyle) then
            begin
              Clip := ExcludeClipRect(DC, Left, Top, Left + Width, Top + Height);
              if Clip = NullRegion then
              begin
                DoPaint := false;
                break;
              end;
            end;

        //
        if DoPaint then
        begin
          Clip := GetClipBox(DC, R);
          with R do
            ARgn := CreateRectRgn(Left, Top, right, Bottom);
          if Clip = ComplexRegion then
          GetClipRgn(DC, ARgn);
        end
        else
          ARgn := 0;
        RestoreDC(DC, SaveIndex);
      end
      else
      *)
      begin
        GetClipBox(DC, R);
        if IsRectEmpty(R) then
          R := ClientRect
        else
        begin
          if not EqualRect(R, ClientRect) then
            InflateRect(R, 1, 1);
        end;

        with R do
          ARgn := CreateRectRgn(Left, Top, right, Bottom);
      end;


      // do actual painting
      if DoPaint then
      begin
        SelectClipRgn(MemDC, ARgn);
        //InvalidateRect(MemDC, @R, false);
        Perform(WM_ERASEBKGND, MemDC, MemDC);
        Msg.DC := MemDC;
        WMPaint(Msg);
        SelectClipRgn(MemDC, 0);
        Msg.DC := 0;
        //SelectClipRgn(DC, ARgn);
        with R do
          BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
      end;
      if ARgn <> 0 then
        DeleteObject(ARgn);

      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;  { WMPaint }

procedure TCustomElPanel.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TCustomElPanel.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if Transparent or TransparentXPThemes then
    begin
      //<-- EK&VB 13 Oct 2008 transparency issue fix
      //    for cases ElAdvPanel on ElPanel (ElAdvPanel caption does not repaint
      //    otherwise) -->
      Invalidate;
      NotifyChildsThatRepaint(true);
    end;
  if Assigned(ImageForm) then
    Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TCustomElPanel.ELThemeChanged(var Message: TMessage);
begin
  DoThemeChanged;
  Message.Result := 1;
end;

procedure TCustomElPanel.DrawThemedBackground(ARect: TRect);
begin
  if not FTransparentXPThemes then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ARect);
  end
  else
  begin
  //<-- EK incorrect drawing if we use ImageForm (see report from Patrick COUDRAY 26.06.2008)
  //(Only SendMessage was left)
  //-->
  //<-- EK&VB 13 Oct 2008
  // Code restored in order to fix transparency issue; for cases like COUDRAY's
  // DoubleBuffered must be set to true
  //-->
  if Parent.DoubleBuffered then
    SendMessage(Parent.Handle, WM_ERASEBKGND, Canvas.Handle, Canvas.Handle)
  else
    DrawThemeParentBackground(Handle, Canvas.Handle, @ARect);
  end;
end;

function TCustomElPanel.GetThemedElement: TThemedElement;
begin
  Result := teWindow;
end;

procedure TCustomElPanel.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
  end;
end;

function TCustomElPanel.GetBackgroundClientRect: TRect;
begin
  Result := ClientRect;
end;

procedure TCustomElPanel.SetTransparentXPThemes(Value: Boolean);
begin
  if FTransparentXPThemes <> Value then
  begin
    FTransparentXPThemes := Value;
    Invalidate;
  end;
end;

procedure TCustomElPanel.SetSizeGrip(Value: Boolean);
begin
  if FSizeGrip <> Value then
  begin
    FSizeGrip := Value;
    Invalidate;
  end;
end;

procedure TCustomElPanel.SetBevelInner(Value: TLMDBevelStyle);
begin
  FBevelInner := Value;
  if Value in [bvNone, bvLowered, bvRaised, bvSpace] then
    inherited BevelInner := TPanelBevel(Value);
  UpdateInterior;
end;

procedure TCustomElPanel.SetBevelOuter(Value: TLMDBevelStyle);
begin
  FBevelOuter := Value;
  if Value in [bvNone, bvLowered, bvRaised, bvSpace] then
    inherited BevelOuter := TPanelBevel(Value);
  UpdateInterior;
end;

procedure TCustomElPanel.SetBevelWidth(Value: TBevelWidth);
begin
  FBevelWidth := Value;
  inherited BevelWidth := Value;
  UpdateInterior;
end;

procedure TCustomElPanel.UpdateInterior;
begin
  // intentionally left blank
end;

procedure TCustomElPanel.SetBevelSpaceColor(Value: TColor);
begin
  if FBevelSpaceColor <> Value then
  begin
    FBevelSpaceColor := Value;
    if (BevelInner = bvSpace) or (BevelOuter = bvSpace) then
      Invalidate;
    end;
end;

procedure TCustomElPanel.SetShowFocus(Value: Boolean);
begin
  if FShowFocus <> Value then
  begin
    FShowFocus := Value;
    if Handleallocated and
       (ComponentState * [csLoading, csreading, csDestroying] = []) and
       (GetFocus = Self.Handle)
      then
      Invalidate;
  end;
end;

procedure TCustomElPanel.WMSetFocus(var Message: TWMSetFocus);

begin
  inherited;
  if ShowFocus then
    Invalidate;
end;

procedure TCustomElPanel.WMKillFocus(var Message: TWMKillFocus);

begin
  inherited;
  if not HandleAllocated then exit;
  if ShowFocus then
    Invalidate;
end;

{$ifdef LMD_UNICODE}
{------------------------------------------------------------------------------}
procedure TCustomElPanel.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message);  //outcommented VB Dec 2008
end;

{------------------------------------------------------------------------------}
procedure TCustomElPanel.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

procedure TCustomElPanel.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
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

procedure TCustomElPanel.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TCustomElPanel.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
  NotifyChildsThatRepaint(True);
end;

procedure TCustomElPanel.UpdateStyle;
var i : integer;
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
      for i := 0 to controlCount - 1 do
      begin
        Controls[i].Invalidate;
      end;
    end;
  end;
end;

procedure TCustomElPanel.CMDialogChar(var Message: TCMDialogChar);
begin
  if Enabled and
    IsAccel(Message.CharCode, Caption) then
      if CanFocus then
      begin
        SetFocus;
        Message.Result := 1;
        exit;
      end;
  inherited;
end;

procedure TCustomElPanel.CMEnabledChanged(var Message: TMessage);
var
  i: Integer;
begin
  inherited;
  for i := 0 to ControlCount - 1 do
  begin
    Controls[i].Enabled := Enabled;
  end;
end;

procedure TCustomElPanel.BeginCreate;
begin
  inc(FCreating);
end;

procedure TCustomElPanel.EndCreate;
begin
  dec(FCreating);
  if FCreating = 0 then
  begin
    if not (csDesigning in ComponentState) then
      StyleManager := DefaultStyleManager;
  end;
end;

procedure TCustomElPanel.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomElPanel.SetBorderStyle(Value: TBorderStyle);
begin
  if (FBorderStyle <> Value) then
  begin
    FBorderStyle := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomElPanel.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    Invalidate;
  end;
end;

procedure TCustomElPanel.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    Invalidate;
  end;
end;

procedure TCustomElPanel.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    Invalidate;
  end;
end;

procedure TCustomElPanel.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    Invalidate;
  end;
end;

procedure TCustomElPanel.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    Invalidate;
  end;
end;

procedure TCustomElPanel.SetBorderType(const Value: TElFlatBorderType);
begin
  if FBorderType <> Value then
  begin
    FBorderType := Value;
    Invalidate;
  end;
end;

procedure TCustomElPanel.NotifyChildsThatRepaint(AllChilds: Boolean = false);
// ToDo Alex
var
  i: integer;
begin
  FIsUpdated := True;
  if (not ((csLoading in ComponentState) or (csDestroying in ComponentState))) then
    if AllChilds or (((not IsThemed and Transparent) or (IsThemed and TransparentXPThemes)) and ((Parent is TElXPThemedControl) or (Parent is TCustomElPanel))) then
      for i := 0 to ControlCount - 1 do
        if (not ((csLoading in Controls[i].ComponentState) or (csDestroying in Controls[i].ComponentState))) then
        begin
          if (Controls[i] is TElXPThemedControl) then
            PostMessage(TElXPThemedControl(Controls[i]).Handle, ParentControlRepaintedMessage, 0, TLMDPtrInt(Self));
          if (Controls[i] is TCustomElPanel) {and (TCustomElPanel(Controls[i]).Transparent)} then
            PostMessage(TCustomElPanel(Controls[i]).Handle, ParentControlRepaintedMessage, 0, TLMDPtrInt(Self));
          if (Controls[i] is TElCustomGraphicControl) then
            TElCustomGraphicControl(Controls[i]).Invalidate;
        end;
  FIsUpdated := False;
end;

procedure TCustomElPanel.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    Invalidate;
  end;
end;

procedure TCustomElPanel.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

procedure TCustomElPanel.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

procedure TCustomElPanel.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

function TCustomElPanel.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

procedure TCustomElPanel.DoThemeChanged;
begin
  if (UseThemeMode <> ttmNone) and HandleAllocated and not (csDestroying in ComponentState) then
  begin
// EK: I add 'csDesigning' to solve problem with 'CDS2009 hangs up'.
//     This need to be checked in final release of Tiburon
    if Showing and (ComponentState * [csLoading, csReading, csDesigning] = []) then
    begin
      RecreateWnd;
//      // Recalculate frame size
//      SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
      RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
    end;
  end
  else
    Invalidate;
end;

procedure TCustomElPanel.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

function TCustomElPanel.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

function TCustomElPanel.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

end.
