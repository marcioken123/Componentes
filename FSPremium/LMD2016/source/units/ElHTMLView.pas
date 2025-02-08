unit ElHTMLView;
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

ElHTMLView unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  LMDTypes, Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, Menus,
  StdCtrls, ExtCtrls,  Types, Themes,

  LMDHTMLUnit, LMDProcs, LMDSysIn, LMDThemes, LMDGraph, LMDClass, LMDUtils,

  ElSBCtrl, ElHTMLContainer,
  ElImgFrm, ElXPThemedControl, ElFormDisplay, ElVCLUtils;

type
  { event handlers support }
  //{$NODEFINE TLMDString}

  TElHTMLView = class(TElXPThemedControl)
  private
    //ElFormDisplay support ElPack 5
    FFormDisplayChangeLink:TElFormDisplayChangeLink;
    FFormDisplay: TElFormDisplay;
    FCheckFormDisplay: boolean;
    // Container support ElPack 5
    FContainer:TElHTMLContainer;
    FIndex:Integer;
    FChangeLink:TElHTMLChangeLink;
    FCheck:Boolean;
    // ----------------
    procedure SetContainer(aValue: TElHTMLContainer);
    procedure SetIndex(aValue: Integer);
    function GetCaptionText: TLMDString;
    function LinkEmpty: Boolean;
    procedure DoCaptionChange(Sender: TObject);
  private
    {< ELSCROLLBAR}
    fSBCtrl :TElSBController;
  protected
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    property SBCtrl :TElSBController read fSBCtrl;
    {> ELSCROLLBAR}
  protected
    FLineSpacing: Integer;
    FFlatFocusedScrollBars : Boolean;
    FUseCustomScrollBars : Boolean;
    FLinkPopupMenu : TPopupMenu;
    FCursor : TCursor;
    FHighlightColor : TColor;
    FHighlightBkColor : TColor;
    FOnLinkClick : TElHTMLLinkClickEvent;
    FOnImageNeeded : TElHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FOnTagFound: TLMDHTMLTagFoundEvent;
    FLinkColor : TColor;
    FLinkStyle : TFontStyles;

    FImgForm : TElImageForm;

    FActiveBorderType : TElFlatBorderType;
    FInactiveBorderType : TElFlatBorderType;
    FFlat : Boolean;
    FWordWrap : Boolean;
    FMouseOver: Boolean;
    FBorderStyle: TBorderStyle;
    FRender : TLMDHTMLRender;
    TmpDC   : HDC;
    FGradientSteps : Integer;
    FGradientStartColor : TColor;
    FGradientEndColor : TColor;
    FTmpBmp : TBitmap;
    FTransparent : Boolean;
    FBackground : TBitmap;
    FBackgroundType : TLMDBackgroundType;

    FImgFormChLink  : TImgFormChangeLink;

    FDummyString : string;
    FViewPos  : TPoint;
    FTextRect : TRect;
    FScrollStep : integer;
    FVScrollVisible,
    FHScrollVisible : boolean;
    FBorderSides: TLMDBorderSides;
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    FCaption: TLMDString;
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FViewRect: TRect;
    FMargin: Integer;
    FRightAlignedView: Boolean;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorShadow: TColor;
    FBorderColorWindow: TColor;

    procedure SetRightAlignedView(Value: Boolean);
    procedure WMSysColorChange(var Msg: TMessage); message WM_SYSCOLORCHANGE;
    procedure CMFontChanged(var Msg : TMessage); message CM_FONTCHANGED;
    procedure CMSysColorChange(var Msg : TMessage); message CM_SYSCOLORCHANGE;
    procedure SBChanged(Sender: TObject);
    procedure CMMouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure SetBorderStyle(Value: TBorderStyle);

    procedure SetImageForm(newValue : TElImageForm);

    procedure SetTransparent(newValue : boolean);
    procedure SetBackground(newValue : TBitmap);
    procedure SetBackgroundType(newValue : TLMDBackgroundType);
    procedure ImageChange(Sender : TObject);

    procedure ImageFormChange(Sender : TObject);

    procedure SetGradientStartColor(newValue : TColor);
    procedure SetGradientEndColor(newValue : TColor);
    procedure SetGradientSteps(newValue : Integer);
    procedure RedoTmpBmp;
    procedure DrawFlatBorder(HorzTracking, VertTracking : boolean);
    procedure DrawFlatBorderEx(DC : HDC; HorzTracking, VertTracking : boolean);

    procedure OnHScroll(Sender: TObject; ScrollCode: TElScrollCode;
                        var ScrollPos: Integer; var DoChange : boolean);
    procedure OnVScroll(Sender: TObject; ScrollCode: TElScrollCode;
                        var ScrollPos: Integer; var DoChange : boolean);
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure CMTextChanged(var Msg : TMessage); message CM_TEXTCHANGED;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPaint(var Msg : TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure SetLinkPopupMenu(newValue : TPopupMenu);
    procedure WMNCPaint(var Msg : TWMNCPaint); message WM_NCPAINT;
    procedure WMNCCalcSize(var Message : TWMNcCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Msg : TWMNCHitTest); message WM_NCHITTEST;
    procedure WMVScroll(var Msg : TWMVScroll); message WM_VSCROLL;
    procedure WMHScroll(var Msg : TWMHScroll); message WM_HSCROLL;

    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseWheel(var Msg : TCMMouseWheel); message CM_MOUSEWHEEL;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;

    {< ELSCROLLBAR}
    function GetHorzScrollBar:TElCtrlScrollBarStyles; virtual;
    function GetVertScrollBar:TElCtrlScrollBarStyles; virtual;
    procedure SetHorzScrollBar(const Value:TElCtrlScrollBarStyles); virtual;
    procedure SetVertScrollBar(const Value:TElCtrlScrollBarStyles); virtual;
    {> ELSCROLLBAR}
    procedure PrepareText; virtual;
    procedure SetViewPos(newValue : TPoint); virtual;
    procedure SetWordWrap(newValue : Boolean); virtual;
    procedure AdjustScrollBars;
    procedure Paint; override;
    procedure UpdateFrame;
    procedure SetActiveBorderType(newValue : TElFlatBorderType); virtual;
    procedure SetInactiveBorderType(newValue : TElFlatBorderType); virtual;
    procedure SetFlat(newValue : Boolean); virtual;
    procedure Notification(AComponent : TComponent; operation : TOperation); override;
    procedure CreateParams(var Params : TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
    procedure SetHighlightColor(newValue : TColor); virtual;
    procedure SetHighlightBkColor(newValue : TColor); virtual;
    procedure TriggerLinkClickEvent(HRef : string); virtual;
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image: TBitmap); virtual;
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString); virtual;
    procedure TriggerTagFoundEvent(Sender : TObject; var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing:boolean; aSupported: boolean);
    procedure TriggerRenderChange(Sender : TObject);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure SetCursor(newValue : TCursor); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SetUseCustomScrollBars(newValue : Boolean); virtual;
    procedure SetFlatFocusedScrollBars(newValue : Boolean); virtual;
    procedure Loaded; override;
    procedure SetCaption(newValue: TLMDString); virtual;

    procedure IFMRepaintChildren(var Message: TMessage); message IFM_REPAINTCHILDREN;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;

    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure SetThemeGlobalMode(const Value: Boolean);override;
    procedure SetThemeMode(const Value: TLMDThemeMode);override;
//    function GetThemedClassName: TLMDThemedItem; override;
    function GetThemedElement: TThemedElement; override;
    procedure DoLinkPopup(MousePos : TPoint);
    procedure SetLineSpacing(AValue: Integer);
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    procedure SetViewRect(Value: TRect);
    procedure SetMargin(Value: Integer);
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$endif}
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);
    // VB
    procedure SetFormDisplay(const Value: TElFormDisplay);
    // --
    property ViewRect: TRect read FViewRect write SetViewRect;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    property VertScrollBarVisible : boolean read FVScrollVisible;
    property HorzScrollBarVisible : boolean read FHScrollVisible;
    property Position : TPoint read FViewPos write SetViewPos;
    property UseXPThemes;
    procedure LoadFromFile(const AFileName: TLMDString); virtual;
  published
    // ElFormDisplay support ElPack 5
    property FormDisplay: TElFormDisplay read FFormDisplay write SetFormDisplay;
    property CheckFormDisplay: boolean read FCheckFormDisplay write FCheckFormDisplay;
    // --
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property Caption: TLMDString read FCaption write SetCaption;
    {< ELSCROLLBAR}
    property HorzScrollBarStyles: TElCtrlScrollBarStyles read GetHorzScrollBar
      write SetHorzScrollBar;
    property VertScrollBarStyles: TElCtrlScrollBarStyles read GetVertScrollBar
      write SetVertScrollBar;
    {> ELSCROLLBAR}
    property RightAlignedView: Boolean read FRightAlignedView write SetRightAlignedView
      default false;
    property WordWrap   : Boolean read FWordWrap write SetWordWrap;
    property Transparent : Boolean read FTransparent write SetTransparent; { Protected }
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsRight, ebsTop, ebsBottom];
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace
        default clBtnFace;
    property BorderColorHighlight: TColor read FBorderColorHighlight write
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorShadow: TColor read FBorderColorShadow write
        SetBorderColorShadow default clBtnShadow;

    property ActiveBorderType : TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;
    property InactiveBorderType : TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;
    property Flat : Boolean read FFlat write SetFlat;

    property ImageForm : TElImageForm read FImgForm write SetImageForm;

    property GradientStartColor : TColor read FGradientStartColor write SetGradientStartColor;  { Protected }
    property GradientEndColor : TColor read FGradientEndColor write SetGradientEndColor;  { Protected }
    property GradientSteps : Integer read FGradientSteps write SetGradientSteps default 16;  { Protected }
    property Background : TBitmap read FBackground write SetBackground;
    property BackgroundType : TLMDBackgroundType read FBackgroundType write SetBackgroundType default bgtColorFill;
    property Cursor : TCursor read FCursor write SetCursor;  { Published }
    property LinkColor : TColor read FLinkColor write SetLinkColor default def_LMDLinkColor;  { Published }
    property LinkStyle : TFontStyles read FLinkStyle write SetLinkStyle default def_LMDLinkStyle;  { Published }
    property LinkPopupMenu : TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property HighlightColor : TColor read FHighlightColor write SetHighlightColor default clHighlightText;  { Published }
    property HighlightBkColor : TColor read FHighlightBkColor write SetHighlightBkColor default clHighlight;  { Published }
    property OnLinkClick : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnImageNeeded : TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnVariableNeeded: TLMDHTMLVariableNeededEvent read FOnVariableNeeded write FOnVariableNeeded;
    property OnTagFound : TLMDHTMLTagFoundEvent read FOnTagFound write FOnTagFound;

    property UseCustomScrollBars : Boolean read FUseCustomScrollBars write SetUseCustomScrollBars default true;  { Published }
    property FlatFocusedScrollBars : Boolean read FFlatFocusedScrollBars write SetFlatFocusedScrollBars default False;  { Published }
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor default clBlack;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor default clBlack;
    property Text : string read FDummyString;
    property Margin: Integer read FMargin write SetMargin default 4;
    property BorderColorWindow: TColor read FBorderColorWindow write SetBorderColorWindow default clWindow;

    // RM
    property Container: TElHTMLContainer read FContainer write SetContainer;
    property ContainerIndex: Integer read FIndex write SetIndex default 0;
    property CheckContainerLinks: Boolean read FCheck write FCheck default true;
    // ----

    property LineSpacing: Integer read FLineSpacing write SetLineSpacing default 0;

    property Anchors;

    property Color;

    property Constraints;

    property Ctl3D;
    property DragCursor;

    property DragKind;

    property Align;
    property DragMode;
    property Enabled;
    property Font;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property ParentThemeMode default true;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property ThemeMode;
    property ThemeGlobalMode;

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

    property OnStartDock;
    property OnEndDock;
    property OnContextPopup;
  end;  { TElHTMLView }

implementation

uses  LMDGraphUtils, LMDStrings;

procedure TElHTMLView.OnHScroll(Sender: TObject; ScrollCode: TElScrollCode;
                                var ScrollPos: Integer; var DoChange : boolean);
begin
  //if ScrollCode <> escTrack then
  begin
    if (FViewPos.X <> ScrollPos) then
    begin
      FViewPos.X := ScrollPos;
      DoChange := true;
      AdjustScrollBars;
      InvalidateRect(Handle, @FViewRect, true);
      DrawFlatBorder(false, false);
    end;
  end;
end;

procedure TElHTMLView.OnVScroll(Sender: TObject; ScrollCode: TElScrollCode;
                                var ScrollPos: Integer; var DoChange : boolean);
{
var xoffs,
    yoffs : integer;
    R     : TRect;
}
begin
  //if ScrollCode <> escTrack then
  begin
    if (FViewPos.Y <> ScrollPos) then
    begin
      //yoffs := FViewPos.Y - ScrollPos;
      //ScrollWindowEx(Handle, 0, yoffs, @FViewRect, @FViewRect, 0, @R, SW_INVALIDATE);
      FViewPos.Y := ScrollPos;
      DoChange := true;
      AdjustScrollBars;
      InvalidateRect(Handle, @FViewRect, true);
      DrawFlatBorder(false, false);
    end;
  end;
end;

procedure TElHTMLView.SBChanged(Sender: TObject);
begin
  AdjustScrollBars;
  Invalidate;
  UpdateFrame;
end;

{< ELSCROLLBAR}
function TElHTMLView.GetHorzScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_HORZ]);
end;

function TElHTMLView.GetVertScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_VERT]);
end;

procedure TElHTMLView.SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_HORZ].Assign(Value);
end;

procedure TElHTMLView.SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_VERT].Assign(Value);
end;

procedure TElHTMLView.CreateWnd;
begin
  fSBCtrl.Control := nil;
  inherited;
  if fUseCustomScrollBars then
  begin
    fSBCtrl.Control := Self;
    if not fSBCtrl.Active then
    begin
      fUseCustomScrollBars := False;
      fSBCtrl.Control := nil;
    end;
  end;
end;

procedure TElHTMLView.DestroyWnd;
begin
  inherited;
  fSBCtrl.Control := nil;
end;

{> ELSCROLLBAR}

procedure TElHTMLView.SetViewPos(newValue : TPoint);
var R : TRect;
begin
  if (newValue.x <> FViewPos.x) or (newValue.y <> FViewPos.y) then
  begin
    FViewPos := newValue;
    AdjustScrollBars;
    R := FViewRect;
    if HandleAllocated then
       InvalidateRect(Handle, @R, false);
    //UpdateFrame;
  end;
end;

procedure TElHTMLView.PrepareText;
var
  ww : boolean;
begin
  FViewPos := Point(0, 0);
  FRender.Data.DefaultStyle := Font.Style;
  FRender.Data.DefaultFont  := Font.Name;
  FRender.Data.DefaultColor := Font.Color;
  FRender.Data.DefaultHeight:= Font.Height;
  FRender.Data.Charset      := Font.Charset;
  FRender.Data.LinkColor    := LinkColor;
  FRender.Data.LinkStyle    := LinkStyle;
  FRender.Data.HighlightColor := FHighlightColor;
  FRender.Data.HighlightBgColor := FHighlightBkColor;
  FRender.Data.LineSpacing  := FLineSpacing;
  ww := WordWrap;
  if (csLoading in ComponentState) then
    ww := false;
  if HandleAllocated then
    begin
      FRender.PrepareText(GetCaptionText, FTextRect.Right - FTextRect.Left, ww);
      Invalidate;
    end;
end;

procedure TElHTMLView.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TElHTMLView.UpdateFrame;
var R : TRect;
begin
  if HandleAllocated then
  begin
    R := Rect(0, 0, Width, Height);
    if (BorderStyle = bsSingle) and (not (csDestroying in ComponentState)) and (HandleAllocated) then
       RedrawWindow( Handle, @R, 0, rdw_Invalidate or rdw_UpdateNow or rdw_Frame );
  end;
end;

procedure TElHTMLView.CMFontChanged(var Msg : TMessage);  { private }
begin
  inherited;
  FScrollStep := Abs(Font.Height) div 2;
  PrepareText;
  AdjustScrollBars;
  Invalidate;
  UpdateFrame;
end;  { CMFontChanged }

procedure TElHTMLView.CMSysColorChange(var Msg : TMessage);  { private }
begin
  inherited;
  Invalidate;
  UpdateFrame;
end;  { CMSysColorChange }

procedure TElHTMLView.SetWordWrap(newValue : Boolean);
{ Sets data member FWordWrap to newValue. }
begin
  if (FWordWrap <> newValue) then
    begin
      FWordWrap := newValue;
      AdjustScrollBars;
      PrepareText;
      AdjustScrollBars;
      Invalidate;
      UpdateFrame;
    end;  { if }
end;  { SetWordWrap }

procedure TElHTMLView.AdjustScrollBars;  { protected }
    function UpdateVScroll : boolean;
    var b : boolean;
        i : integer;
        ScrollInfo : TScrollInfo;
    begin
      if FHScrollVisible then
         i := HorzScrollBarStyles.Width
      else
         i := 0;
      if (not UseCustomScrollbars) or (not FVScrollVisible) then
      begin
        VertScrollBarStyles.Max := FRender.Data.TextSize.cy;
        VertScrollBarStyles.Position := FViewPos.y;
        VertScrollBarStyles.Page := (ClientHeight - i);
        VertScrollbarStyles.Step := Abs(Font.Height);
      end;
      ScrollInfo.cbSize := sizeof(ScrollInfo);
      ScrollInfo.fMask := SIF_ALL;
      ScrollInfo.nMin  := 0;
      ScrollInfo.nMax  := FRender.Data.TextSize.cy;
      ScrollInfo.nPage := (ClientHeight - i);
      ScrollInfo.nPos  := FViewPos.y;
      ScrollInfo.nTrackPos := FViewPos.y;
      SetScrollInfo(Handle, SB_VERT, ScrollInfo, True);
      b := VertScrollBarStyles.Max > VertScrollBarStyles.Page;
      Result := b <> FVScrollVisible;
      FVScrollVisible := b;
    end;

    function UpdateHScroll : boolean;
    var b : boolean;
        i : integer;
        ScrollInfo : TScrollInfo;
    begin
      if FVScrollVisible then
         i := VertScrollBarStyles.Width
      else
         i := 0;

      if (not UseCustomScrollbars) or (not FHScrollVisible) then
      begin
        if WordWrap or (FRender.Data.TextSize.cx < FTextRect.Right - FTextRect.Left) then
          HorzScrollBarStyles.Max := 0
        else
          HorzScrollBarStyles.Max := FRender.Data.TextSize.cx;
        HorzScrollBarStyles.Page := (ClientWidth - i) div 2;
        HorzScrollBarStyles.Position := FViewPos.x;
      end;

      ScrollInfo.cbSize := sizeof(ScrollInfo);
      ScrollInfo.fMask := SIF_ALL;
      ScrollInfo.nMin  := 0;
      if WordWrap or (FRender.Data.TextSize.cx < FTextRect.Right - FTextRect.Left) then
        ScrollInfo.nMax  := 0
      else
        ScrollInfo.nMax  := FRender.Data.TextSize.cx;
      ScrollInfo.nPage := (ClientWidth - i) div 2;
      ScrollInfo.nPos  := FViewPos.x;
      ScrollInfo.nTrackPos := FViewPos.x;
      SetScrollInfo(Handle, SB_HORZ, ScrollInfo, True);
      b := HorzScrollBarStyles.Max > (ClientWidth - i);
      Result := b <> FHScrollVisible;
      FHScrollVisible := b;
    end;
var SaveViewPos : TPoint;
begin
  if not HandleAllocated then
    exit;

  FHScrollVisible := (not WordWrap) and (ClientWidth < FRender.Data.TextSize.cx);
  //FVScrollVisible := FRender.Data.TextSize.cy > ClientHeight ;

  while UpdateHScroll or UpdateVSCroll do
  begin
    if WordWrap then
    begin
      SaveViewPos := FViewPos;
      PrepareText;
      FViewPos := SaveViewPos;
    end;
  end;
  ViewRect := ClientRect;
end;  { AdjustScrollBars }

procedure TElHTMLView.Paint;  { protected }
var R, Rect,
    R1     : TRect;
    ACtl   : TWinControl;
    //ax, ay : integer;
    P      : TPoint;
    BgRect : TRect;
begin
  if Flat then
    DrawFlatBorder(false, false);

  R := ClientRect;

  if not Transparent then
  begin
    if (FImgForm <> nil) and (not (csDesigning in FImgForm.ComponentState)) then
    begin
      if (FImgForm.Control <> Self) then
      begin
        ACtl := FImgForm.GetRealControl;
        BgRect := R;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        P := Parent.ClientToScreen(Point(Left, Top));
        {ax := BgRect.Left - P.x;
        ay := BgRect.Top - P.y;
        }
        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

        FImgForm.PaintBkgnd(Canvas.Handle, R, BgRect.TopLeft, false);
      end;
      //FImgForm.PaintBkgnd(Canvas.Handle, R, Point(BgRect.Left - ax, BgRect.Top - ay), false);
    end
    else
    begin
      with Canvas do
      case BackgroundType of //
        bgtColorFill :
          begin
            Canvas.Brush.Style := bsSolid;
            Canvas.Brush.Color := Color;
            Canvas.FillRect(R);
          end;
        bgtHorzGradient, bgtVertGradient, bgtSquareGradient, bgtEllipticGradient,
        bgtTopLeftGradient, bgtTopRightGradient, bgtBottomLeftGradient,
        bgtBottomRightGradient, bgtTopLeftDiagonalGradient, bgtTopRightDiagonalGradient:
          LMDGradientPaint(Canvas, R, GradientStartColor, GradientEndColor, GradientSteps,LMDBackgroundType2GradientStyle[BackgroundType], 0, 0);
        bgtStretchBitmap:
          begin
//            CopyRect(R, FBackground.Canvas, Classes.Rect(0, 0, FBackground.Width, FBackground.Height));
            StretchDraw(R, FBackground);
          end;
        bgtTileBitmap:
          begin
            TiledPaint(Canvas, FBackground, R);
          end;
        bgtCenterBitmap :
          begin
            Brush.Color := Color;
            Rect := R;
            FillRect(Rect);
            R := Classes.Rect(0, 0, FBackground.Width, FBackground.Height);
            LMDCenterRects(FBackground.Width, Rect.Right - Rect.Left, FBackground.Height, Rect.Bottom - Rect.Top, R1);
            OffsetRect(R1, Rect.Left, Rect.Top);
            CopyRect(R1, FBackground.Canvas, Classes.Rect(0, 0, FBackground.Width, FBackground.Height));
          end;
      end; // case

      if (FVScrollVisible and FHScrollVisible) and (FUseCustomScrollBars) then
      begin
        // PAINT CROSS SCROLLBARS AREA:
        SetRect( R,
          VertScrollbarStyles.ScrollBarRect.Left,
          HorzScrollbarStyles.ScrollBarRect.Top,
          VertScrollbarStyles.ScrollBarRect.Right,
          HorzScrollbarStyles.ScrollBarRect.Bottom
        );
        Canvas.Brush.Style := bsSolid;
        Canvas.Brush.Color := VertScrollBarStyles.Color;
        Canvas.FillRect(R);
      end;
    end;
  end
  else
  begin
    GetClipBox(Canvas.Handle, R);
    R1 := R;
    P := Parent.ScreenToClient(ClientToScreen(Point(0, 0)));
    with P do
      OffsetRect(R1, X, Y);

    InflateRect(R1,-1,-1);
    RedrawWindow(Parent.Handle, @R1, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);
    BitBlt(Canvas.Handle, R.Left, R.Top, R.Right, R.Bottom, TmpDC, R.Left, R.Top, SRCCOPY);
  end;
  FRender.DrawText(Canvas, FViewPos, FTextRect, clNone);
end;  { Paint }

procedure TElHTMLView.CMMouseEnter(var Msg : TMessage);  { private }
begin
  inherited;
  FMouseOver := true;
  if (Flat and (not Focused)) then
    DrawFlatBorder(false, false);
end;  { CMMouseEnter }

procedure TElHTMLView.CMMouseLeave(var Msg : TMessage);  { private }
begin
  FMouseOver := false;
  if (Msg.LParam = 0) or (Msg.LParam = TLMDPtrInt(Self)) then
    begin
      if (Flat and (not Focused)) then
        DrawFlatBorder(false, false);
      inherited Cursor := FCursor;
    end;
  inherited;
end;  { CMMouseLeave }

procedure TElHTMLView.SetActiveBorderType(newValue : TElFlatBorderType);
begin
  if (FActiveBorderType <> newValue) then
  begin
    FActiveBorderType := newValue;
    if (Focused or FMouseOver) then UpdateFrame;
  end;  { if }
end;  { SetActiveBorderType }

procedure TElHTMLView.SetInactiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FInactiveBorderType to newValue. }
begin
  if (FInactiveBorderType <> newValue) then
  begin
    FInactiveBorderType := newValue;
    if (not (Focused or FMouseOver)) then UpdateFrame;
  end;  { if }
end;  { SetInactiveBorderType }

procedure TElHTMLView.SetFlat(newValue : Boolean);
{ Sets data member FFlat to newValue. }
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    UpdateFrame;
  end;  { if }
end;  { SetFlat }

procedure TElHTMLView.SetImageForm(newValue : TElImageForm);
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
    if not (csDesigning in ComponentState) then
    begin
      Invalidate;
      UpdateFrame;
    end;
  end;  { if }
end;  { SetImageForm }

procedure TElHTMLView.SetGradientStartColor(newValue : TColor);
{ Sets data member FGradientStartColor to newValue. }
begin
  if (FGradientStartColor <> newValue) then
  begin
    FGradientStartColor := newValue;
    if LMDBackgroundIsGradient(FBackgroundType) then
    begin
      Invalidate;
      UpdateFrame;
    end;
  end;  { if }
end;  { SetGradientStartColor }

procedure TElHTMLView.SetGradientEndColor(newValue : TColor);
{ Sets data member FGradientEndColor to newValue. }
begin
  if (FGradientEndColor <> newValue) then
  begin
    FGradientEndColor := newValue;
    if LMDBackgroundIsGradient(FBackgroundType) then
    begin
      Invalidate;
      UpdateFrame;
    end;
  end;  { if }
end;  { SetGradientEndColor }

procedure TElHTMLView.SetGradientSteps(newValue : Integer);
{ Sets data member FGradientSteps to newValue. }
begin
  if (FGradientSteps <> newValue) and (newValue > 0) then
  begin
    FGradientSteps := newValue;
    if LMDBackgroundIsGradient(FBackgroundType) then
    begin
      Invalidate;
      UpdateFrame;
    end;
  end;  { if }
end;  { SetGradientSteps }

procedure TElHTMLView.SetBackground(newValue : TBitmap);
begin
  FBackground.Assign(newValue);
  if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
     then BackgroundType := bgtColorFill;
end; {SetBackground}

procedure TElHTMLView.SetBackgroundType(newValue : TLMDBackgroundType);
begin
  if (FBackgroundType <> newValue) then
  begin
    FBackgroundType := newValue;
    if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
       then FBackgroundType := bgtColorFill;
    RedoTmpBmp;
    begin
      Invalidate;
      UpdateFrame;
    end;
  end; {if}
end; {SetBackgroundType}

procedure TElHTMLView.ImageFormChange(Sender : TObject);
begin
  Invalidate;
  UpdateFrame;
end;

procedure TElHTMLView.ImageChange(Sender : TObject);
begin
  if ((FBackground.Height = 0) or (FBackground.Width = 0)) then
    BackgroundType := bgtColorFill
  else
  begin
    if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then RedoTmpBmp;
    UpdateFrame;
  end;
end;

procedure TElHTMLView.CreateParams;
const

  BorderStyles: array[TBorderStyle] of DWord = (0, WS_BORDER);

  LeftSB: array[Boolean] of DWORD = (0, WS_EX_LEFTSCROLLBAR);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle] {or (WS_HSCROLL or WS_VSCROLL)};
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
    if Transparent then
       ExStyle := ExStyle or WS_EX_TRANSPARENT
    else
       ExStyle := ExStyle and not WS_EX_TRANSPARENT;
    with Params.WindowClass do
      style := style and not (CS_HREDRAW or CS_VREDRAW);
    if NewStyleControls or UseCustomScrollBars then
      ExStyle := ExStyle or LeftSB[RightAlignedView];
  end;
end;

procedure TElHTMLView.SetRightAlignedView(Value: Boolean);
begin
  if FRightAlignedView <> Value then
  begin
    FRightAlignedView := Value;
    AdjustScrollBars;
    RecreateWnd;
  end;
end;

procedure TElHTMLView.SetTransparent(newValue : Boolean);
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
    UpdateFrame;
  end; { if }
end; { SetTransparent }

procedure TElHTMLView.DrawFlatBorder(HorzTracking, VertTracking : boolean);
var
  DC : HDC;
  RC,
  RW : TRect;
  SavedDC : HDC;
  b  : boolean;
  BS : TElFlatBorderType;
//  Theme : HTheme;
  AColor: TColor;
  LThemeMode: TLMDThemeMode;
const
  ScrollBars: array [Boolean, Boolean] of TScrollStyle = (
    (ssNone,       ssVertical),
    (ssHorizontal, ssBoth)
  );

begin
  Windows.GetClientRect(Handle, RC);
  LThemeMode := UseThemeMode;
  if UseCustomScrollBars then
  begin
    if VertScrollBarStyles.Visible then
    begin
      if not RightAlignedView then
        inc(RC.Right, VertScrollBarStyles.Depth)
      else
        dec(RC.Left, VertScrollBarStyles.Depth)
    end;
    if HorzScrollBarStyles.Visible then
      inc(RC.Bottom, HorzScrollBarStyles.Depth);
  end
  else
  begin
    if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
    begin
      if (not RightAlignedView) or (not NewStyleControls) then
        inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL))
      else
        dec(RC.Left, GetSystemMetrics(SM_CXVSCROLL));
    end;
    if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
      inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
  end;

  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  OffsetRect(RW, -RW.Left, -RW.Top);

  DC := GetWindowDC(Handle);
  try
    if (BorderStyle = bsSingle) and (LThemeMode <> ttmNone) then
      begin
        SavedDC := SaveDC(DC);
        ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
        LMDThemeServices.DrawElement(LThemeMode, DC, teEditDontCare, RW, nil);
        RestoreDC(DC, SavedDC);
      end;
    begin
      if (BorderStyle = bsSingle) and not IsThemed then
      begin
        b := Focused or FMouseOver;
        if b then BS := FActiveBorderType else BS := FInactiveBorderType;
        if (not FFlat) then
           BS := fbtSunken;
        if bs = fbtRaised then bs := fbtRaisedOuter;
        if Focused or FMouseOver then
          AColor := LineBorderActiveColor
        else
          AColor := LineBorderInactiveColor;
        DrawFlatFrameEx2(DC, RW, AColor, Color, b, Enabled, BorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
      end;
      if (not FUseCustomScrollBars) and
         (FFlatFocusedScrollBars or not (Focused or FMouseOver))
      then
         DrawFlatScrollBars(Handle, DC, RW, (Focused or FMouseOver) and (not FlatFocusedScrollBars),
            ScrollBars[FHScrollVisible, FVScrollVisible], HorzTracking, VertTracking, False,
            GetWindowLong(Handle, GWL_STYLE), GetWindowLong(Handle, GWL_EXSTYLE));
    end;
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TElHTMLView.DrawFlatBorderEx(DC : HDC; HorzTracking, VertTracking : boolean);
var
  RC,
  RW : TRect;
  SavedDC : HDC;
  b  : boolean;
  BS : TElFlatBorderType;
  AColor: TColor;
  LThemeMode: TLMDThemeMode;

const ScrollBars: array [boolean, boolean] of TScrollStyle = ((ssNone, ssVertical), (ssHorizontal, ssBoth));
begin
  Windows.GetClientRect(Handle, RC);
  LThemeMode := UseThemeMode;
  if UseCustomScrollBars then
  begin
    if VertScrollBarStyles.Visible then
    begin
      if not RightAlignedView then
        inc(RC.Right, VertScrollBarStyles.Depth)
      else
        dec(RC.Left, VertScrollBarStyles.Depth)
    end;
    if HorzScrollBarStyles.Visible then
      inc(RC.Bottom, HorzScrollBarStyles.Depth);
  end
  else
  begin
    if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
    begin
      if (not RightAlignedView) or (not NewStyleControls) then
        inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL))
      else
        dec(RC.Left, GetSystemMetrics(SM_CXVSCROLL));
    end;
    if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
      inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
  end;

  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  OffsetRect(RW, -RW.Left, -RW.Top);

  if (BorderStyle = bsSingle) and (LThemeMode <> ttmNone) then
  begin
    begin
      SavedDC := SaveDC(DC);
      ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
      LMDThemeServices.DrawElement(LThemeMode, DC, teEditDontCare, RW, nil);
      RestoreDC(DC, SavedDC);
    end;
  end;
  if (BorderStyle = bsSingle) and (LThemeMode = ttmNone) then
  begin
    b := Focused or FMouseOver;
    if b then BS := FActiveBorderType else BS := FInactiveBorderType;
    if (not FFlat) then
       BS := fbtSunken;
    if bs = fbtRaised then bs := fbtRaisedOuter;
    if Focused or FMouseOver then
      AColor := LineBorderActiveColor
    else
      AColor := LineBorderInactiveColor;

    DrawFlatFrameEx2(DC, RW, AColor, Color, b, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
  end;

  if (not FUseCustomScrollBars) and //(not IsThemeApplied)
     (FFlatFocusedScrollBars or not (Focused or FMouseOver))
  then
     DrawFlatScrollBars(Handle, DC, RW, (Focused or FMouseOver) and (not FlatFocusedScrollBars),
       ScrollBars[FHScrollVisible, FVScrollVisible], HorzTracking, VertTracking, false,
       GetWindowLong(Handle, GWL_STYLE), GetWindowLong(Handle, GWL_EXSTYLE));
end;

procedure TElHTMLView.RedoTmpBmp;
var BgRect,
    BgRect2 : TRect;
begin
  if BackgroundType in [bgtHorzGradient, bgtVertGradient, bgtColorFill, bgtCenterBitmap] then
  begin
    FTmpBmp.FreeImage;
  end else
  begin
    if HandleAllocated and (ClientWidth <> 0) and (ClientHeight <> 0) then
    begin
      FTmpBmp.Height := ClientHeight - 1;
      FTmpBmp.Width := ClientWidth - 1;
      BgRect := ClientRect;
      BgRect2 := BgRect;
      OffsetRect(BgRect2, BgRect2.Left, BgRect2.Top);
      LMDExtDrawBkgnd(FTmpBmp.Canvas.Handle, BgRect, BgRect, BgRect, BgRect2, false, Color, Color, Background, BackgroundType);
    end;
  end;
end;

procedure TElHTMLView.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
    begin
      if (AComponent = FImgForm) then
        ImageForm := nil;
      if (AComponent = FLinkPopupMenu) then
        LinkPopupMenu := nil;
      if (AComponent = FContainer) then
        Container := nil;
      if (AComponent = FFormDisplay) then
        FFormDisplay := nil;
    end;  { if }
end;  { Notification }

procedure TElHTMLView.WMSetFocus(var Msg : TWMSetFocus);  { private }
begin
  inherited;
  if Flat then
    UpdateFrame;
end;  { WMSetFocus }

procedure TElHTMLView.WMKillFocus(var Msg : TWMKillFocus);  { private }
begin
  inherited;
  if not HandleAllocated then exit;
  if Flat then
    UpdateFrame;
end;  { WMKillFocus }

procedure TElHTMLView.CMTextChanged(var Msg : TMessage);  { private }
var
  R : TRect;
begin
  inherited;
  FViewPos := Point(0, 0);
  if WordWrap then
    begin
      PrepareText;
      AdjustScrollBars;
    end;
  PrepareText;
  AdjustScrollBars;
  R := FViewRect;
  if HandleAllocated then
     InvalidateRect(Handle, @R, false);
  //UpdateFrame;
end;  { CMTextChanged }

procedure TElHTMLView.CreateWindowHandle(const Params: TCreateParams);  { protected }
begin
  inherited CreateWindowHandle(Params);
  PrepareText;
  AdjustScrollBars;
  if WordWrap then
    PrepareText;
end;  { CreateWindowHandle }

procedure TElHTMLView.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
    begin
      FLinkColor := newValue;
      PrepareText;
    end;  { if }
end;  { SetLinkColor }

procedure TElHTMLView.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
    begin
      FLinkStyle := newValue;
      PrepareText;
    end;  { if }
end;  { SetLinkStyle }

procedure TElHTMLView.SetHighlightColor(newValue : TColor);
{ Sets data member FHighlightColor to newValue. }
begin
  if (FHighlightColor <> newValue) then
  begin
    FHighlightColor := newValue;
    Invalidate;
    UpdateFrame;
  end;  { if }
end;  { SetHighlightColor }

procedure TElHTMLView.SetHighlightBkColor(newValue : TColor);
{ Sets data member FHighlightBkColor to newValue. }
begin
  if (FHighlightBkColor <> newValue) then
  begin
    FHighlightBkColor := newValue;
    Invalidate;
    UpdateFrame;
  end;  { if }
end;  { SetHighlightBkColor }

procedure TElHTMLView.TriggerLinkClickEvent(HRef : string);
var
  tmp:Integer;
begin
  // VB
  if (FFormDisplay<>nil) and FCheckFormDisplay and (HRef<>'') then
  begin
    tmp := FFormDisplay.FormContainer.FormList.IndexOf(HRef);
    if (tmp <> -1) and (tmp <> FFormDisplay.ActiveFormIndex) then
    begin
      try
        FFormDisplay.ActiveFormIndex := tmp;
      except
        FFormDisplay.ActiveFormIndex := -1;
      end;
      //exit;
    end;
  end;
  // RM !!
  if FCheck and not LinkEmpty then
    begin
      tmp:=FContainer.ItemByName[HRef];
      if tmp>-1 then
        begin
          ContainerIndex:=tmp;
          Exit;
        end;
    end;
  // ---
  if Assigned(FOnLinkClick) then
    FOnLinkClick(Self,HRef);
end;  { TriggerLinkClickEvent }

procedure TElHTMLView.TriggerImageNeededEvent(Sender : TObject; Src: TLMDString; var Image : TBitmap);
begin
  if Assigned(FOnImageNeeded) then
    FOnImageNeeded(Self, Src , Image );
end;  { TriggerImageNeededEvent }

procedure TElHTMLView.Click;  { public }
var P : TPoint;
    href : TLMDString;
    P1: TPoint;
begin
  P1 := FViewPos;
  dec(P1.x, FTextRect.Left);
  dec(P1.y, FTextRect.Top);

  GetCursorPos(P);
  P := ScreenToClient(P);
  if FRender.IsCursorOverLink(P, P1, FTextRect, href) then
    TriggerLinkClickEvent(href)
  else
    inherited;
end;  { Click }

procedure TElHTMLView.MouseMove(Shift: TShiftState; X, Y: Integer);  { protected }
var href : TLMDString;
    P1   : TPoint;
begin
  P1 := FViewPos;
  dec(P1.x, FTextRect.Left);
  dec(P1.y, FTextRect.Top);

  if FRender.IsCursorOverLink(Point(X, Y), P1, FTextRect, href) then
    inherited Cursor := crHandPoint
  else
    inherited Cursor := FCursor;
  inherited MouseMove(Shift, X, Y);
end;  { MouseMove }

procedure TElHTMLView.SetCursor(newValue : TCursor);
var P : TPoint;
    href : TLMDString;
    P1    : TPoint;
begin
  if (FCursor <> newValue) then
  begin
    P1 := FViewPos;
    dec(P1.x, FTextRect.Left);
    dec(P1.y, FTextRect.Top);

    FCursor := newValue;
    GetCursorPos(P);
    P := ScreenToClient(P);
    if FRender.IsCursorOverLink(P, P1, FTextRect, href) then
       inherited Cursor := crHandPoint
    else
       inherited Cursor := FCursor;
  end;  { if }
end;  { SetCursor }

procedure TElHTMLView.KeyDown(var Key: Word; Shift: TShiftState);  { protected }
 function GetScrollCodes(KeyCode:DWORD):DWORD;
 begin
   case KeyCode of
    VK_PRIOR: Result := SB_PAGEUP;
    VK_NEXT:  Result := SB_PAGEDOWN;
    VK_LEFT:  Result := SB_LINELEFT;
    VK_UP:    Result := SB_LINEUP;
    VK_RIGHT: Result := SB_LINERIGHT;
    VK_DOWN:  Result := SB_LINEDOWN;
    else
              Result := 0;
   end;
 end;
begin
  inherited KeyDown(Key, Shift);
  if (Key <> 0) and (Shift = []) then
  begin
    case Key of
      VK_RETURN:
        begin
          if (FRender.Data.SelectedItem <> nil) and
             (FRender.Data.SelectedItem.IsLink) then
          TriggerLinkClickEvent(FRender.Data.SelectedItem.LinkRef);
        end;
//      VK_TAB:
//        begin
//          FRender.SelectNextSuitableItem;
//          InvalidateRect(Handle, @FViewRect, false);
//        end;
      VK_PRIOR,//33
      VK_NEXT, //34
      VK_UP,   //38
      VK_DOWN: //40
        begin
          if VertScrollBarStyles.Visible then
            Perform( WM_VSCROLL, GetScrollCodes(Key), 0);
        end;
      VK_SPACE:
        begin
          Key := VK_NEXT;
          if VertScrollBarStyles.Visible then
            Perform( WM_VSCROLL, GetScrollCodes(Key), 0);
        end;
      VK_LEFT,  // 37
      VK_RIGHT: // 39
        begin
          if HorzScrollBarStyles.Visible then
            Perform( WM_HSCROLL, GetScrollCodes(Key), 0);
        end;
    end;
  end
  else
//  if (Key <> 0) and (Shift = [ssShift]) then
//  begin
//    if (Key = VK_TAB) then
//    begin
//      FRender.SelectPrevSuitableItem;
//      InvalidateRect(Handle, @FViewRect, false);
//    end;
//  end else
  if (Key <> 0) and (Shift = [ssCtrl]) then
  begin
    if (Key = VK_LEFT) or (Key = VK_RIGHT) then
    begin
      if (Key = VK_LEFT) then
        Key := VK_PRIOR
      else
      if (Key = VK_RIGHT) then
        Key := VK_NEXT;
      Perform( WM_HSCROLL, GetScrollCodes(Key), 0);
    end;
  end;
end;  { KeyDown }

procedure TElHTMLView.WMGetDlgCode(var Msg : TWMGetDlgCode);  { private }
begin
  Msg.Result := DLGC_WANTARROWS or DLGC_WANTCHARS or DLGC_WANTTAB;
end;  { WMGetDlgCode }

procedure TElHTMLView.WMPaint(var Msg : TWMPaint);  { private }
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R : TRect;
  ARgn : HRGN;
begin
  if (Msg.DC <> 0) then
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
      GetClipBox(DC, R);
      if IsRectEmpty(R) then
         R := FViewRect
      else
        InflateRect(R, 1, 1);
      ARgn := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
      SelectClipRgn(MemDC, ARgn);

      TmpDC := DC;

      Msg.DC := MemDC;
      WMPaint(Msg);
      SelectClipRgn(MemDC, 0);
      DeleteObject(ARgn);
      Msg.DC := 0;
      with R do
        BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;  { WMPaint }

procedure TElHTMLView.WMEraseBkgnd(var Msg : TWMEraseBkgnd);  { private }
begin
  Msg.Result := 1;
end;  { WMEraseBkgnd }

procedure TElHTMLView.WMMouseWheel(var Msg: TWMMouseWheel); { private }
var
  Dy : integer;
  sl : integer;
begin
  if LMDSIWindowsNT or LMDSIWindows98 then
     SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
  else
     sl := 3;
  if sl = 0 then sl := 1;
  Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
  if Dy <> 0 then
    Perform( WM_VSCROLL, ((FViewPos.Y - Dy * FScrollStep) shl 16) + SB_THUMBPOSITION, 0);
end; { WMMouseWheel }

procedure TElHTMLView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);  { protected }
{var P : TPoint;
    href : TLMDString;
    P1: TPoint;}
begin
  inherited MouseDown(Button, Shift, X, Y);
  if CanFocus then SetFocus;
{  P := Point(X, Y);
  P1 := FViewPos;
  dec(P1.x, FTextRect.Left);
  dec(P1.y, FTextRect.Top);

{  if FRender.IsCursorOverLink(P, P1, FTextRect, href) then
     FRender.SelectLinkAt(P, FViewPos, FTextRect)
  else
     FRender.SelectLinkAt(Point(-1, -1), Point(0, 0), FTextRect); }

//  InvalidateRect(Handle, @FViewRect, false);
end;

procedure TElHTMLView.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  if (FLinkPopupMenu <> newValue) then
    begin
      if FLinkPopupMenu <> nil then
        if not (csDestroying in FLinkPopupMenu.ComponentState) then
          FLinkPopupMenu.RemoveFreeNotification(Self);
      FLinkPopupMenu := newValue;
      if (newValue <> nil) then
         newValue.FreeNotification(Self);
    end;  { if }
end;  { SetLinkPopupMenu }

procedure TElHTMLView.SetUseCustomScrollBars(newValue : Boolean);
{ Sets data member FUseCustomScrollBars to newValue. }
begin
  if (FUseCustomScrollBars <> newValue) then
  begin
    FUseCustomScrollBars := newValue;
    fSBCtrl.Control := nil;
    if fUseCustomScrollBars then
    begin
      fSBCtrl.Control := Self;
      if not fSBCtrl.Active then
      begin
        fUseCustomScrollBars := False;
        fSBCtrl.Control := nil;
        exit;
      end;
    end;
    AdjustScrollBars;
  end;  { if }
end;  { SetUseCustomScrollBars }

procedure TElHTMLView.CMEnabledChanged(var Message: TMessage);

begin
  inherited;
  VertScrollBarStyles.Enabled := Enabled;
  HorzScrollBarStyles.Enabled := Enabled;
end;

procedure TElHTMLView.WMNCPaint(var Msg : TWMNCPaint);  { private }
var DC : HDC;

  procedure CallInheritedWOFrame;
  var
    WS, WES :DWORD;
  begin
    try
      WES := GetWindowLong(Handle, GWL_EXSTYLE);
      if WES and WS_EX_CLIENTEDGE <> 0 then
      begin
        WS := 0;
        FPreventStyleChange := True;
        SetWindowLong(Handle, GWL_EXSTYLE, WES and not WS_EX_CLIENTEDGE);
      end
      else
      begin
        WES := 0;
        WS  := GetWindowLong(Handle, GWL_STYLE);
        if WS and WS_BORDER <> 0 then
        begin
          FPreventStyleChange := True;
          SetWindowLong(Handle, GWL_STYLE, WS and not WS_BORDER);
        end
        else
          WS := 0;
      end;

      //inherited
      DefaultHandler(Msg);

      if WES <> 0 then
        SetWindowLong(Handle, GWL_EXSTYLE, WES)
      else if WS <> 0 then
        SetWindowLong(Handle, GWL_STYLE, WS);
    finally
      if FPreventStyleChange then
        FPreventStyleChange := False;
    end;
  end;

  procedure PaintCrossSystemScrollbarsArea;
    var
      nFrameSize :Integer;
      RW         :TRect;
  begin
    // paint left cross scrollbars area for system scrollbars:
    begin
      GetWindowRect(Handle, RW);
      MapWindowPoints(0, Handle, RW, 2);
      OffsetRect(RW, -RW.Left, -RW.Top);

      if ((GetWindowLong(Handle, GWL_STYLE) and WS_BORDER) = WS_BORDER) then
        nFrameSize := GetSystemMetrics(SM_CXBORDER)
      else
        if ((GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
        nFrameSize := GetSystemMetrics(SM_CXEDGE)
      else
        nFrameSize := 0;

      with RW do
      begin
        if (not RightAlignedView) or (not NewStyleControls) then
        begin
          dec(Right, nFrameSize);
          Left:= Right - GetSystemMetrics(SM_CXVSCROLL);
          dec(Bottom, nFrameSize);
          Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
        end
        else
        begin
          Left   := nFrameSize;
          Right := Left + GetSystemMetrics(SM_CXVSCROLL);
          dec(Bottom, nFrameSize);
          Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
        end;
        Windows.DrawEdge(DC, RW, EDGE_SUNKEN, BF_MIDDLE);
      end;
    end;
  end;

begin
  if FPreventStyleChange then
    exit;

  if (Flat or FUseCustomScrollBars or IsThemed) and
    (BorderStyle = bsSingle) then
  begin
    if not FUseCustomScrollBars then
      CallInheritedWOFrame;

    DC := GetWindowDC(Handle);
    {
    if IsThemeApplied then
    begin
      R1 := BoundsRect;
      OffsetRect(R1, -R1.Left, - R1.Top);

      R.TopLeft := Parent.ClientToScreen(BoundsRect.TopLeft);
      R.BottomRight := Parent.ClientToScreen(BoundsRect.BottomRight);
      R2 := ClientRect;
      OffsetRect(R2, ClientOrigin.X - R.Left, ClientOrigin.Y - R.Top);

      with R2 do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
      DrawThemeBackgroundTo('EDIT', DC, 0, 0, R1, nil)
    end
    else
    {}

    DrawFlatBorderEx(DC, false, false);

    if (not UseCustomScrollBars) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) and
       (NewStyleControls)
    then
      PaintCrossSystemScrollbarsArea;

    ReleaseDC(Handle, DC);
    Msg.Result := 0;
  end
  else
  begin
    inherited;
    if RightAlignedView and (not UseCustomScrollBars) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) and
       (NewStyleControls)
    then
    begin
      //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
      //if DC = 0 then
        DC := GetWindowDC(Handle);
      PaintCrossSystemScrollbarsArea;
      ReleaseDC(Handle, DC);
    end;
  end;
end;  { WMNCPaint }

procedure TElHTMLView.WMNCCalcSize(var Message : TWMNcCalcSize);  { private }

begin
  inherited;
  if BorderStyle = bsSingle then
    begin
      if not (ebsLeft in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
      if not (ebsTop in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
      if not (ebsRight in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
      if not (ebsBottom in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));

      if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
        Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
      if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
        Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;
      end;
end;  { WMNCCalcSize }

procedure TElHTMLView.WMNCHitTest(var Msg : TWMNCHitTest);  { private }
begin
  inherited;
  if Msg.Result = HTBORDER then
    Msg.Result := HTSIZE;
end;  { WMNCHitTest }

{$WARNINGS OFF}
procedure TElHTMLView.WMVScroll(var Msg : TWMVScroll);  { private }
var b : boolean;
    sc: TElscrollCode;
    sp: integer;
begin
  b := false;
  if VertScrollBarStyles.Page > VertScrollBarStyles.Max then
    exit;
  case Msg.ScrollCode of
    SB_TOP:
      begin
        sc := escTop;
        sp := 0;
      end;
    SB_BOTTOM:
      begin
        sc := escBottom;
        sp := FRender.Data.TextSize.cy - VertScrollBarStyles.Page + 1;
      end;
    SB_ENDSCROLL:
      begin
        sc := escEndScroll;
        sp := FViewPos.y;
      end;
    SB_LINEDOWN:
      begin
        sc := escLineDown;
        if FViewPos.y + VertScrollBarStyles.Page < VertScrollBarStyles.Max then
          sp := FViewPos.y + Abs(Font.Height)
        else
          sp := FViewPos.y;
      end;
    SB_LINEUP:
      begin
        sc := escLineUp;
        sp := FViewPos.y - Abs(Font.Height);
        if sp < 0 then
          sp := 0;
      end;
    SB_PAGEDOWN:
      begin
        sc := escPageDown;
        sp := FViewPos.y + VertScrollBarStyles.Page;
        if sp + VertScrollBarStyles.Page >= VertScrollBarStyles.Max then
          sp := (VertScrollBarStyles.Max - VertScrollBarStyles.Page) + 1;
      end;
    SB_PAGEUP:
      begin
        sc := escPageUp;
        sp := FViewPos.y - VertScrollBarStyles.Page;
        if sp<0 then
          sp := 0;
      end;
    SB_THUMBPOSITION:
      begin
        sc := escPosition;
        sp := Msg.Pos;
      end;
    SB_THUMBTRACK:
      begin
        sc := escTrack;
        sp := Msg.Pos;
      end;
  end;
  if (sp >= 0) and
     (sp <= VertScrollBarStyles.Max)
  then
     OnVScroll(
       VertScrollBarStyles,
       SC, sp, b);
end;  { WMVScroll }

procedure TElHTMLView.WMHScroll(var Msg : TWMHScroll);  { private }
var b : boolean;
    sc: TElscrollCode;
    sp: integer;
begin
  b := false;
  case Msg.ScrollCode of
    SB_TOP:
      begin
        sc := escTop;
        sp := 0;
      end;
    SB_BOTTOM:
      begin
        sc := escTop;
        sp := FRender.Data.TextSize.cx;
      end;
    SB_ENDSCROLL:
      begin
        sc := escEndScroll;
        sp := FViewPos.x;
      end;
    SB_LINEDOWN:
      begin
        sc := escLineDown;
        sp := FViewPos.x + 1;
      end;
    SB_LINEUP:
      begin
        sc := escLineUp;
        sp := FViewPos.x - 1;
      end;
    SB_PAGEDOWN:
      begin
        sc := escPageDown;
        sp := FViewPos.x + HorzScrollBarStyles.Page;
      end;
    SB_PAGEUP:
      begin
        sc := escPageUp;
        sp := FViewPos.x - HorzScrollBarStyles.Page;
        if sp<0 then
          sp := 0;
      end;
    SB_THUMBPOSITION:
      begin
        sc := escPosition;
        sp := Msg.Pos;
      end;
    SB_THUMBTRACK:
      begin
        sc := escTrack;
        sp := Msg.Pos;
      end;
  end;
  if (sp >= 0) and
     (sp < HorzScrollBarStyles.Max)
  then
     OnHScroll(HorzScrollBarStyles, SC, sp, b);
end;  { WMHScroll }
{$WARNINGS ON}

procedure TElHTMLView.CMMouseWheel(var Msg : TCMMouseWheel);  { private }
var
  Dy : integer;
  sl : integer;
begin
  if LMDSIWindowsNT or LMDSIWindows98 then
     SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
  else
     sl := 3;
  if sl = 0 then sl := 1;
  Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
  if Dy <> 0 then
    Perform( WM_VSCROLL, FViewPos.Y - Dy * FScrollStep shl 16 + SB_THUMBPOSITION, 0);
end;  { CMMouseWheel }

procedure TElHTMLView.SetFlatFocusedScrollBars(newValue : Boolean);
{ Sets data member FFlatFocusedScrollBars to newValue. }
begin
  if (FFlatFocusedScrollBars <> newValue) then
  begin
    FFlatFocusedScrollBars := newValue;
    if Focused then
      DrawFlatBorder(false, false);
  end;  { if }
end;  { SetFlatFocusedScrollBars }

procedure TElHTMLView.Loaded;  { protected }
begin
  inherited;
  AdjustScrollBars;
  if HandleAllocated then
    begin
      PrepareText;
      Invalidate;
    end;
end;  { Loaded }

procedure TElHTMLView.WMSize(var Msg : TWMSize);  { private }
begin
  inherited;
  AdjustScrollBars;
  if WordWrap then
    PrepareText;
  AdjustScrollBars;
  Invalidate;

  if IsThemed or (Flat and (BorderStyle <> bsNone)) then
    DrawFlatBorder(false, false);

end;  { WMSize }

destructor TElHTMLView.Destroy;
begin
  Destroying;
  FreeAndNil(FChangeLink);
  FreeAndNil(FFormDisplayChangeLink);

  ImageForm := nil;

  FRender.Free;
  FBackground.Free;
  FTmpBmp.Free;

  FImgFormChLink.Free;

  inherited Destroy;
end;  { Destroy }

constructor TElHTMLView.Create(AOwner : TComponent);
begin

  BeginCreate;
  inherited Create(AOwner);

  {< ELSCROLLBAR}
  fSBCtrl := TElSBController.Create(Self);
  FSBCtrl.UseXPThemes := true;
  {> ELSCROLLBAR}

  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
  FUseCustomScrollBars := True;
  FRender := TLMDHTMLRender.Create;
  FRender.Control := Self;
  FRender.LinkSelect := True;

  FImgFormChLink  := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;

  FBackground := TBitmap.Create;
  FBackground.OnChange := ImageChange;
  FBackgroundType := bgtColorFill;
  FGradientSteps := 16;
  FMargin := 4;
  FLineSpacing := 0;
  FTmpBmp := TBitmap.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;
  FRender.OnChange := TriggerRenderChange;
  FRender.OnVariableNeeded := TriggerVariableNeededEvent;
  FRender.OnTagFound := TriggerTagFoundEvent;

  FLinkColor := def_LMDLinkColor;
  FLinkStyle := def_LMDLinkStyle;
  FBorderStyle := bsSingle;
  Parentcolor := false;
  Color := clWindow;
  FActiveBorderType := fbtSunken;
  FInactiveBorderType := fbtSunkenOuter;
  FHighlightColor := clHighlightText;
  FHighlightBkColor := clHighlight;
  FScrollStep := Abs(Font.Height) div 2;

  HorzScrollBarStyles.OnScroll := OnHScroll;
  HorzScrollBarStyles.OnChange := SBChanged;
  VertScrollBarStyles.OnScroll := OnVScroll;
  VertScrollBarStyles.OnChange := SBChanged;

  // RM
  FChangeLink:=TELHTMLChangeLink.Create;
  FChangeLink.OnChange:=DoCaptionChange;
  FCheck:=True;
  //VB
  FFormDisplayChangeLink := TELFormDisplayChangeLink.Create;
  FFormDisplayChangeLink.OnChange := DoCaptionChange;
  FCheckFormDisplay := true;

  Width := 136;
  Height := 81;

  EndCreate;
end;  { Create }

procedure TElHTMLView.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TElHTMLView.SetCaption(newValue: TLMDString);
{ Sets data member FCaption to newValue. }
begin
  FCaption := newValue;
  inherited Caption := newValue;
end; { SetCaption }

procedure TElHTMLView.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TElHTMLView.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TElHTMLView.SetUseXPThemes(const Value: Boolean);
begin
  inherited;
  HorzScrollBarStyles.UseXPThemes := Value;
  VertScrollBarStyles.UseXPThemes := Value;
  fSBCtrl.UseXPThemes := Value;
end;

procedure TElHTMLView.SetThemeGlobalMode(const Value: Boolean);
begin
  inherited;
  HorzScrollBarStyles.ThemeGlobalMode := Value;
  VertScrollBarStyles.ThemeGlobalMode := Value;
  fSBCtrl.ThemeGlobalMode := Value;
end;

procedure TElHTMLView.SetThemeMode(const Value: TLMDThemeMode);
begin
  inherited;
  HorzScrollBarStyles.ThemeMode := Value;
  VertScrollBarStyles.ThemeMode := Value;
  fSBCtrl.ThemeMode := Value;
end;

function TElHTMLView.GetThemedElement: TThemedElement;
begin
  Result := teWindow;
end;

procedure TElHTMLView.WMRButtonUp(var Message: TWMRButtonUp);

begin
  inherited;
end;

procedure TElHTMLView.DoLinkPopup(MousePos : TPoint);
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

procedure TElHTMLView.WMContextMenu(var Message: TWMContextMenu);
var
  Pt,
  P1, Temp: TPoint;
  Handled : Boolean;
  href    : TLMDString;
begin
  if Message.Result <> 0 then Exit;
  if csDesigning in ComponentState then Exit;

  Pt := ScreenToClient(SmallPointToPoint(Message.Pos));
  P1 := FViewPos;
  dec(P1.x, FTextRect.Left);
  dec(P1.y, FTextRect.Top);

  if FRender.IsCursorOverLink(Pt, P1, FTextRect, href) then
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
    inherited;
end;

procedure TElHTMLView.SetLineSpacing(AValue: Integer);
begin
  if FLineSpacing <> AValue then
  begin
    FLineSpacing := AValue;
    PrepareText;
  end;
end;

procedure TElHTMLView.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
      if HandleAllocated then
        Invalidate;
  end;
end;

procedure TElHTMLView.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
      if HandleAllocated then
        Invalidate;
  end;
end;

procedure TElHTMLView.WMSysColorChange(var Msg: TMessage);
begin
  inherited;
end; { WMSysColorChange }

procedure TElHTMLView.SetViewRect(Value: TRect);
begin
  FViewRect := Value;
  FTextRect := FViewRect;
  InflateRect(FTextRect, -FMargin, 0);
  if HandleAllocated then
  begin
    // FRender.PrepareText(GetCaptionText, FTextRect.Right - FTextRect.Left, HandleAllocated and WordWrap);
    Invalidate;
  end;
end;

procedure TElHTMLView.SetMargin(Value: Integer);
var R : TRect;
begin
  if FMargin <> Value then
    begin
      FMargin := Value;
      R := FViewRect;
      FViewRect := Rect(0, 0, 0, 0);
      ViewRect := R;
    end;
end;

{$ifdef LMD_UNICODE}
{------------------------------------------------------------------------------}
procedure TElHTMLView.CMHintShow(var Message:TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

{------------------------------------------------------------------------------}
procedure TElHTMLView.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

procedure TElHTMLView.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder(false, false);
    end;
end;

procedure TElHTMLView.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder(false, false);
    end;
end;

procedure TElHTMLView.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder(false, false);
    end;
end;

procedure TElHTMLView.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder(false, false);
    end;
end;

procedure TElHTMLView.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder(false, false);
    end;
end;

// RM
{ ---------------------------------------------------------------------------- }
procedure TElHTMLView.SetContainer(aValue:TElHTMLContainer);
begin
  if FContainer<>nil then
    FContainer.UnRegisterChanges(FChangeLink);
  FContainer:=aValue;
  if FContainer<>nil then
    begin
      FContainer.RegisterChanges(FChangeLink);
      FContainer.FreeNotification(Self);
    end;
  DoCaptionChange(nil);
end;

//VB
{ ---------------------------------------------------------------------------- }
procedure TElHTMLView.SetFormDisplay(const Value: TElFormDisplay);
begin
  if FFormDisplay<>nil then
    FFormDisplay.UnRegisterChanges(FFormDisplayChangeLink);

  FFormDisplay := Value;

  if FFormDisplay<>nil then
    begin
      FFormDisplay.RegisterChanges(FFormDisplayChangeLink);
      FFormDisplay.FreeNotification(Self);
    end;
  DoCaptionChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TElHTMLView.SetIndex(aValue:Integer);
begin
  if aValue<>FIndex then
    begin
      FIndex:=aValue;
      if Assigned(FContainer) then DoCaptionChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TElHTMLView.GetCaptionText: TLMDString;
begin
  if LinkEmpty then
    result:=Caption
  else
    result:=FContainer.Items[FIndex].Caption;
end;

{ ---------------------------------------------------------------------------- }
function  TElHTMLView.LinkEmpty:Boolean;
begin
  result:=not ((FContainer<>nil) and (FIndex<FContainer.Count));
end;

{ -----------------------------------------------------------------------------}
procedure TElHTMLView.DoCaptionChange(Sender: TObject);
begin
  if csLoading in ComponentState then exit;
  Perform(CM_TEXTCHANGED, 0, 0);
end;

{ -----------------------------------------------------------------------------}
procedure TElHTMLView.TriggerRenderChange(Sender: TObject);
begin
  Invalidate;
end;

{ -----------------------------------------------------------------------------}
procedure TElHTMLView.TriggerVariableNeededEvent(Sender: TObject;
  const aVar: TLMDString; var aVal: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aVar, aVal);
end;

{ -----------------------------------------------------------------------------}
procedure TElHTMLView.LoadFromFile(const AFileName: TLMDString);
var
  sl: TLMDMemoryStrings;
begin
  sl := TLMDMemoryStrings.Create;
  sl.LoadFromFile(aFileName);
  Caption := sl.Text;
  sl.Free;
end;

{ -----------------------------------------------------------------------------}
procedure TElHTMLView.TriggerTagFoundEvent(Sender: TObject;
  var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing,
  aSupported: boolean);
begin
  if Assigned(FOnTagFound) then
    FOnTagFound(Self, Tag, Item, Params, aClosing, aSupported);
end;

end.
