unit ElScrollBox;
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

ElScrollBox unit
----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, StdCtrls, Windows, Controls, Messages, Graphics,
  Types, Forms, Themes,

  LMDSysIn, LMDProcs, LMDThemes, LMDClass, LMDUtils, LMDGraph,
  LMDTypes, intfLMDBase,
 ElStyleMan, ElVCLUtils, ElImgFrm, ElSBCtrl;

type
  TElScrollBox = class(TScrollBox, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FActiveBorderType: TElFlatBorderType;
    FBackground: TBitmap;
    FBorderSides: TLMDBorderSides;
    FFlat: Boolean;
    FFlatFocusedScrollBars: Boolean;
    FInactiveBorderType: TElFlatBorderType;

    FUseBackground: Boolean;
    FImgForm: TElImageForm;
    FImgFormChLink: TImgFormChangeLink;
    FMouseOver: Boolean;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FPainting: Boolean;
    FPaintingTo: Boolean;
    FTransparent: Boolean;
    FStyleMgrLink : TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    FRightAlignedView: Boolean;

    {< ELSCROLLBAR}
    fUseCustomScrollBars : Boolean;
    fSBCtrl: TElSBController;
    function GetHorzScrollBar:TElCtrlScrollBarStyles;
    function GetVertScrollBar:TElCtrlScrollBarStyles;
    procedure SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
    procedure SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
    procedure SetUseCustomScrollBars(const Value:Boolean);
    {> ELSCROLLBAR}

    procedure SetRightAlignedView(Value: Boolean);
    procedure SetActiveBorderType(const Value: TElFlatBorderType);
    procedure SetBackground(const Value: TBitmap);
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure SetFlat(const Value: boolean);
    procedure SetFlatFocusedScrollBars(const Value: boolean);
    procedure SetImageForm(newValue : TElImageForm);
    procedure SetInactiveBorderType(const Value: TElFlatBorderType);
    procedure SetUseBackground(const Value: boolean);
    procedure BackgroundChanged(Sender: TObject);
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure DrawBackground(DC: HDC; R: TRect);
    procedure DrawFlatBorder(DC: HDC);
    procedure DrawParentControl(DC: HDC);
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure ImageFormChange(Sender : TObject);
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure SetParentThemeMode(const Value: boolean);
    //<abb 2014>
    procedure DoPaintCrossScrollBarsArea(Sender :TObject; Canvas :TCanvas; R :TRect;
                                         var DefaultDraw :Boolean);
    //</abb 2014>
  protected
    FPreventStyleChange :Boolean;
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    FTransparentXPThemes: Boolean;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorShadow: TColor;
    FBorderColorWindow: TColor;
    FParentThemeMode: boolean;
    FThemeGlobalMode: Boolean;
    FThemeMode : TLMDThemeMode;

    function GetUseXPThemes: Boolean;
    procedure ReadUseXPThemes(Reader: TReader);
    procedure DefineProperties(Filer:TFiler);override;
    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;
    procedure SetUseXPThemes(const Value: Boolean);virtual;

    procedure WMStyleChanging(var Message: TWMStyleChanging); message WM_STYLECHANGING;
    procedure WMStyleChanged(var Message: TWMStyleChanged); message WM_STYLECHANGED;
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure WMNCPaint(var Msg : TMessage); message WM_NCPAINT;
    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure CMMouseWheel(var Msg : TWMMouseWheel); message CM_MOUSEWHEEL;
    procedure DoMouseEnter; dynamic;
    procedure DoMouseLeave; dynamic;
    procedure DoPaint(DC : HDC); dynamic;
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    procedure CreateParams(var Params: TCreateParams); override;

    procedure SetStyleManager(Value: TElStyleManager); virtual;
    procedure SetStyleName(const Value: string); virtual;
    procedure StyleMgrChange(Sender : TObject);
    procedure UpdateStyle;

    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    {$endif}
    procedure DrawThemedBackground(DC : HDC); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetTransparentXPThemes(Value: Boolean); virtual;
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);
    procedure AutoScrollInView(AControl: TControl);override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;
    function IsThemed: Boolean;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property ActiveBorderType: TElFlatBorderType read FActiveBorderType write
        SetActiveBorderType default fbtSunken;
    property Background: TBitmap read FBackground write SetBackground;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides
      default [ebsLeft, ebsTop, ebsRight, ebsBottom];
    property Flat: Boolean read FFlat write SetFlat default False;
    property FlatFocusedScrollBars: Boolean read FFlatFocusedScrollBars write
        SetFlatFocusedScrollBars default False;
    property ImageForm: TElImageForm read FImgForm write SetImageForm;
    property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write
        SetInactiveBorderType default fbtSunkenOuter;
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor default clBlack;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor default clBlack;
    property UseBackground: Boolean read FUseBackground write SetUseBackground
        default False;
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    property TransparentXPThemes: Boolean read FTransparentXPThemes write
        SetTransparentXPThemes default true;

    {< ELSCROLLBAR}
    property UseCustomScrollBars : Boolean read fUseCustomScrollBars write SetUseCustomScrollBars
      default True;
    property HorzScrollBarStyles: TElCtrlScrollBarStyles read GetHorzScrollBar
      write SetHorzScrollBar;
    property VertScrollBarStyles: TElCtrlScrollBarStyles read GetVertScrollBar
      write SetVertScrollBar;
    {> ELSCROLLBAR}

    property RightAlignedView: Boolean read FRightAlignedView write
        SetRightAlignedView default false;
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
    property DoubleBuffered;
    {$IFDEF LMCCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
  end;

implementation

uses TypInfo, FlatSB;

type
   THackWinControl = class(TWinControl);

{function QueryThemeData : boolean;
var hTestTheme : HTheme;
begin
  result := false;
  hTestTheme := Open.ThemeData(0, 'LISTVIEW');
  if hTestTheme <> 0 then
  begin
    result := true;
    Close.ThemeData(hTestTheme);
  end;
end;}

procedure TElScrollBox.SetActiveBorderType(const Value: TElFlatBorderType);
begin
  if FActiveBorderType <> Value then
  begin
    FActiveBorderType := Value;
    if Focused or FMouseOver then DrawFlatBorder(0);
    end;
end;

procedure TElScrollBox.SetBackground(const Value: TBitmap);
begin
  FBackground.Assign(Value);
end;

procedure TElScrollBox.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TElScrollBox.SetFlat(const Value: boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    if HandleAllocated then
      Invalidate;
    end;
end;

procedure TElScrollBox.SetFlatFocusedScrollBars(const Value: boolean);
begin
  if FFlatFocusedScrollBars <> Value then
  begin
    FFlatFocusedScrollBars := Value;
    if Focused then DrawFlatBorder(0);
    end;
end;

procedure TElScrollBox.SetImageForm(newValue : TElImageForm);
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
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
    end;
end;

procedure TElScrollBox.SetInactiveBorderType(const Value: TElFlatBorderType);
begin
  if FInactiveBorderType <> Value then
  begin
    FInactiveBorderType := Value;
    if not Focused and not FMouseOver then DrawFlatBorder(0);
    end;
end;

procedure TElScrollBox.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
      if HandleAllocated then
        Invalidate;
  end;
end;

procedure TElScrollBox.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
      if HandleAllocated then
        Invalidate;
  end;
end;

procedure TElScrollBox.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

procedure TElScrollBox.SetUseBackground(const Value: boolean);
begin
  if FUseBackground <> Value then
  begin
    FUseBackground := Value;
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
    end;
end;

procedure TElScrollBox.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
    if HandleAllocated then
    begin
      fSBCtrl.ThemeMode := LMDCtlXP[Value];
      Perform(CM_RECREATEWND, 0, 0);
    end;
  end;
end;

function TElScrollBox.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

procedure TElScrollBox.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

procedure TElScrollBox.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

procedure TElScrollBox.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    if HandleAllocated then
    begin
      fSBCtrl.ThemeGlobalMode := Value;
    end;
    DoThemeChanged;
  end;
end;

procedure TElScrollBox.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    if HandleAllocated then
      fSBCtrl.ThemeMode := Value;
    DoThemeChanged;
  end;
end;

procedure TElScrollBox.DoThemeChanged;
begin
  if HandleAllocated then
  begin
    if (ComponentState * [csLoading, csReading, csDesigning] = []) then
      Perform(CM_RECREATEWND, 0, 0);
    if (UseThemeMode <> ttmNone) then
    begin
      SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
      RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
    end;
  end;
end;

function TElScrollBox.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

function TElScrollBox.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

procedure TElScrollBox.BackgroundChanged(Sender: TObject);
begin
  Invalidate;
  Perform(CM_COLORCHANGED, 0, 0);
end;

procedure TElScrollBox.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := True;
  if IsThemed or ((Flat and (FInactiveBorderType <> FActiveBorderType)) and not Focused) then
    DrawFlatBorder(0);
  DoMouseEnter;
end;

procedure TElScrollBox.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  FMouseOver := False;
  if (Msg.LParam = 0) or (Msg.LParam = TLMDPtrInt(Self)) then
    begin
      if IsThemed or ((Flat and (FInactiveBorderType <> FActiveBorderType)) and not Focused) then DrawFlatBorder(0);
      DoMouseLeave;
    end;
end;

procedure TElScrollBox.CreateWnd;
begin
  {< ELSCROLLBAR}
  fSBCtrl.Control := nil;
  {> ELSCROLLBAR}
  inherited;
  if UseXPThemes and not IsThemed then
  begin
    UninitializeFlatSB(Handle);
  end;
  {< ELSCROLLBAR}
  // reset control handler
  if fUseCustomScrollBars then
  begin
    fSBCtrl.Control := Self;
    //<abb 2014>
    fSBCtrl.ThemeMode := FThemeMode;
    if FThemeMode = ttmNone then
      fSBCtrl.OnPaintCrossScrollBarsArea := DoPaintCrossScrollBarsArea;
    //</abb 2014>
    if not fSBCtrl.Active then
    begin
      fUseCustomScrollBars := False;
      //<abb 2014>
      fSBCtrl.OnPaintCrossScrollBarsArea := nil;
      //</abb 2014>
      fSBCtrl.Control := nil;
    end;
  end;
  {> ELSCROLLBAR}
end;

procedure TElScrollBox.DestroyWnd;
begin
  inherited;
  {< ELSCROLLBAR}
  fSBCtrl.Control := nil;
  {> ELSCROLLBAR}
end;

{< ELSCROLLBAR}
function TElScrollBox.GetHorzScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_HORZ]);
end;

function TElScrollBox.GetVertScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_VERT]);
end;

procedure TElScrollBox.SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_HORZ].Assign(Value);
end;

procedure TElScrollBox.SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_VERT].Assign(Value);
end;

procedure TElScrollBox.SetUseCustomScrollBars(const Value:Boolean);
begin
  if fUseCustomScrollBars<>Value then
  begin
    fUseCustomScrollBars := Value;
    if fUseCustomScrollBars then
    begin
      fSBCtrl.Control := nil;
      fSBCtrl.Control := Self;
      //<abb 2014>
      fSBCtrl.ThemeMode := FThemeMode;
      if FThemeMode = ttmNone then
        fSBCtrl.OnPaintCrossScrollBarsArea := DoPaintCrossScrollBarsArea;
      //</abb 2014>
      if not fSBCtrl.Active then
      begin
        fUseCustomScrollBars := False;
        fSBCtrl.Control := nil;
        //<abb 2014>
        fSBCtrl.OnPaintCrossScrollBarsArea := nil;
        //</abb 2014>
      end;
    end
    else
      fSBCtrl.Control := nil;
  end;
end;
{> ELSCROLLBAR}

procedure TElScrollBox.DrawBackground(DC: HDC; R: TRect);
begin
  if FUseBackground and not FBackground.Empty then
    TiledPaint(DC, FBackground, R);
end;

procedure TElScrollBox.DrawFlatBorder(DC: HDC);
var
  R : TRect;
  BS: TElFlatBorderType;
  MustRelease: boolean;
  AColor : TColor;
  ARgn,
  CRgn   : HRGN;

const BordersFlat : array[boolean] of Integer = (0, WS_BORDER);
      Borders3D : array[boolean] of Integer = (0, WS_EX_CLIENTEDGE);

begin
  if not HandleAllocated then exit;
  R := Rect(0, 0, Width, Height);
  if IsThemed then
  begin
    if BorderStyle = bsSingle then
    begin
      ARgn := CreateRectRgnIndirect(R);
      R := ClientRect;
      CRgn := CreateRectRgnIndirect(R);
      CombineRgn(ARgn, ARgn, CRgn, RGN_DIFF);
      RedrawWindow(Handle, nil, ARgn, RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);
      DeleteObject(ARgn);
      DeleteObject(CRgn);
    end;
    exit;
  end;
  MustRelease := (DC = 0);
  if MustRelease then
    DC := GetWindowDC(Handle);
  try
    if (BorderStyle = bsSingle) then
    begin
      if Focused or FMouseOver then
        BS := FActiveBorderType
      else
        BS := FInactiveBorderType;
      if Focused or FMouseOver then
        AColor := LineBorderActiveColor
      else
        AColor := LineBorderInactiveColor;
      DrawFlatFrameEx2(DC, R, AColor, Color, Focused or FMouseOver, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
    end;
    if (not UseCustomScrollBars) and
       (FFlatFocusedScrollBars or not (Focused or FMouseOver))
    then
       DrawFlatScrollbars(Handle, DC, R,
        (Focused or FMouseOver) and not FFlatFocusedScrollBars,
        ssBoth, False, False, False,
        GetWindowLong(Handle, GWL_STYLE) or BordersFlat[(not Ctl3D) and (BorderStyle = bsSingle)],
        GetWindowLong(Handle, GWL_EXSTYLE) or Borders3D[Ctl3D and (BorderStyle = bsSingle)]);
  finally
    if MustRelease then ReleaseDC(Handle, DC);
  end;
end;

procedure TElScrollBox.DrawParentControl(DC: HDC);
var
  SavedDC: integer;
  P: TPoint;
begin
  if Assigned(Parent) then
  begin
    SavedDC := SaveDC(DC);
    try
      P := Parent.ScreenToClient(ClientOrigin);
      MoveWindowOrg(DC, -P.X, -P.Y);
      Parent.Perform(WM_ERASEBKGND, DC, 0);
      Parent.Perform(WM_PAINT, DC, 0);
      THackWinControl(Parent).PaintControls(DC, nil);
    finally
      RestoreDC(DC, SavedDC);
    end;
  end;
end;

procedure TElScrollBox.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
var
  R1,
  BgRect : TRect;
  ACtl   : TWinControl;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  if LThemeMode <> ttmNone then
  begin
    if not TransparentXPThemes then
    begin
      inherited;
    end
    else
    begin
      R1 := ClientRect;
      LMDThemeServices.DrawThemeParentBackground(LThemeMode, Handle, Msg.DC, LMDRectToPtr(R1));
    end;
  end
  else
  begin
    if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in FImgForm.GetRealControl.Componentstate)) then
    begin
      if (FImgForm.Control <> Self) then
      begin
        ACtl := FImgForm.GetRealControl;
        R1 := ClientRect;
        BgRect := ClientRect;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

        FImgForm.PaintBkgnd(Msg.DC, R1, Point(BgRect.Left, BgRect.Top), false);
      end;
    end
    else
    if FTransparent then
      DrawParentControl(Msg.DC)
    else
    if FUseBackground and not FBackground.Empty then
      DrawBackground(Msg.DC, ClientRect)
    else
    begin
      //if not IsThemed then
      inherited;
      //Msg.Result := 1;
    end;
  end;
end;

procedure TElScrollBox.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if not HandleAllocated then exit;
  if (Flat and (FInactiveBorderType <> FActiveBorderType))  and not FMouseOver then DrawFlatBorder(0);
end;

procedure TElScrollBox.WMNCCalcSize(var Message : TWMNCCalcSize);

begin
  if (BorderStyle = bsSingle) and Flat and (not IsThemed ) then
  begin
    inherited;
    if (ebsLeft in BorderSides) then
      inc(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
    if (ebsTop in BorderSides) then
      inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
    if (ebsRight in BorderSides) then
      dec(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
    if (ebsBottom in BorderSides) then
      dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));

    if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
      Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
    if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
      Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;
    end
  else
  begin
    inherited;
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
  // Message.Result := WVR_REDRAW;
end;

procedure TElScrollBox.WMStyleChanging(var Message: TWMStyleChanging);
begin
  if not FPreventStyleChange then
    inherited
  else
    Message.Result := 0;
end;

procedure TElScrollBox.WMStyleChanged(var Message: TWMStyleChanged);
begin
  if not FPreventStyleChange then
    inherited
  else
    Message.Result := 0;
end;

procedure TElScrollBox.WMNCPaint(var Msg : TMessage);
var DC : HDC;
    RW,
    RC,
    R : TRect;
    ARgn, CRgn : HRGN;

const BordersFlat : array[boolean] of Integer = (0, WS_BORDER);
      Borders3D : array[boolean] of Integer = (0, WS_EX_CLIENTEDGE);
      ScrollBars : array[boolean, boolean] of Integer = ((0, WS_VSCROLL), (WS_HSCROLL, WS_HSCROLL or WS_VSCROLL));

  procedure PaintCrossSystemScrollbarsArea;
    var
      nFrameSize :Integer;
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

      //inherited;
      DefWindowProc(Handle, Msg.Msg, Msg.WParam, Msg.LParam);
      if WES <> 0 then
        SetWindowLong(Handle, GWL_EXSTYLE, WES)
      else if WS <> 0 then
        SetWindowLong(Handle, GWL_STYLE, WS);
    finally
      if FPreventStyleChange then
        FPreventStyleChange := False;
    end;
  end;

begin
  if FPreventStyleChange then
    exit;

  if IsThemed and (BorderStyle = bsSingle) then
  begin
    //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    //if DC = 0 then
      DC := GetWindowDC(Handle);

    Windows.GetClientRect(Handle, RC);

    {< ELSCROLLBAR}
    if UseCustomScrollBars then
    begin //???
      if VertScrollBarStyles.Visible then
      begin
        if (not RightAlignedView) then
          inc(RC.Right, VertScrollBarStyles.Depth)
        else
          dec(RC.Left, VertScrollBarStyles.Depth);
      end;
      if HorzScrollBarStyles.Visible then
        inc(RC.Bottom, HorzScrollBarStyles.Depth);
    end
    else
    {> ELSCROLLBAR}
    begin
      if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
      begin
        if (not RightAlignedView) or (not NewStyleControls) then
          inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL))
        else
          dec(RC.Left, GetSystemMetrics(SM_CXVSCROLL));

        if (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) then
          PaintCrossSystemScrollbarsArea;

      end;
      if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
        inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
    end;

    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);

    R := RW;
    OffsetRect(R, -RW.Left, -RW.Top);
    CRgn := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);

    ARgn := CreateRectRgn(RC.Left, RC.Top, RC.Right, RC.Bottom);
    SelectClipRgn(DC, ARgn);

    //inherited;
    if (not UseCustomScrollBars) and (
       (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) or
       (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) )
    then
    begin
      CallInheritedWOFrame;
      //PaintCrossSystemScrollbarsArea;
    end;

    CombineRgn(CRgn, CRgn, ARgn, RGN_DIFF);
    DeleteObject(ARgn);
    SelectClipRgn(DC, CRgn);
    OffsetRect(RW, -RW.Left, -RW.Top);

    //if UseCustomScrollBars and
    LMDThemeServices.DrawElement(UseThemeMode, DC, teEditDontCare, RW);


    DeleteObject(CRgn);

    ReleaseDC(Handle, DC);
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
      DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
      if DC = 0 then
        DC := GetWindowDC(Handle);
      PaintCrossSystemScrollbarsArea;
      ReleaseDC(Handle, DC);
    end;
  end;
end;

//<abb 2014>
procedure TElScrollBox.DoPaintCrossScrollBarsArea(Sender :TObject; Canvas :TCanvas; R :TRect;
                                                  var DefaultDraw :Boolean);
var
  i, j, k : integer;
begin
  // we'll draw the sizing grip ourself
  DefaultDraw := false;
  // this area appears only when horz scroller appears,
  // so we get all colors from the horz scroll style
  with Canvas do
  begin
    Brush.Color := HorzScrollBarStyles.Color;
    Pen.Color := HorzScrollBarStyles.BarColor;
    FillRect(R);
    i := R.Right - 1;
    j := R.Bottom - 1;
    for k := 0 to 3 do
    begin
      MoveTo(i, R.Bottom); LineTo(R.Right, j); Dec(i); Dec(j);
      MoveTo(i, R.Bottom); LineTo(R.Right, j); Dec(i, 3); Dec(j, 3);
      if (i < R.Left) or (j < R.Top) then Exit;
    end;
  end;
end;
//</abb 2014>

procedure TElScrollBox.WMPaint(var Msg: TWMPaint);
//var PS : TPaintStruct;
var CtlDC : HDC;
begin
  if Msg.DC = 0 then
  begin
    inherited;
    if FFlat and (not IsThemed) then
    begin
      CtlDC := GetWindowDC(Handle);
      DrawFlatBorder(CtlDC);
      ReleaseDC(Handle, CtlDC);
    end;
  end
  else
  if not FPainting and not FPaintingTo then
  begin
    //BeginPaint(Handle, PS);
    // inherited;
    (*if FTransparent or (FUseBackground and not FBackground.Empty) or
       ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate))) then
    *)
    DoPaint(Msg.DC);
    //EndPaint(Handle, PS);
  end
  else
    inherited;
end;

procedure TElScrollBox.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if (Flat and (FInactiveBorderType <> FActiveBorderType)) and (not FMouseOver) and
     (not IsThemed)
  then
    DrawFlatBorder(0);
end;

procedure TElScrollBox.WMMouseWheel(var Msg: TWMMouseWheel);
begin
  inherited;
  CMMouseWheel(Msg);
end;

procedure TElScrollBox.CMMouseWheel(var Msg : TWMMouseWheel);
var
  Dy : integer;
  sl : integer;
  SD : DWORD;
  SC : DWORD;
  bIsVSB, bIsHSb :Boolean;
begin
  bIsVSB := (WS_VSCROLL and GetWindowLong(Handle, GWL_STYLE))<>0;
  bIsHSB := (not bIsVSB) and ((WS_HSCROLL and GetWindowLong(Handle, GWL_STYLE))<>0);
  if not (bIsVSB or bIsHSB) then
    exit;
  if bIsVSB then
    SD := WM_VSCROLL
  else
    SD := WM_HSCROLL;
  if LMDSIWindowsNT or LMDSIWindows98 then
     SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
  else
     sl := 3;
  if sl = 0 then
    sl := 1;
  Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
  if Dy <> 0 then
  begin
    if Dy>0 then
      SC := SB_LINEUP
    else
      SC := SB_LINEDOWN;
    for Dy := 1 to sl do
      Perform( SD, SC, 0);
  end;
end;

procedure TElScrollBox.ELThemeChanged(var Message: TMessage);
begin
  DoThemeChanged;
  Message.Result := 1;
end;

constructor TElScrollBox.Create(AOwner: TComponent);
begin
  inherited;
  {< ELSCROLLBAR}
  fSBCtrl := TElSBController.Create(Self);
  fSBCtrl.UseXPThemes := true;
  fUseCustomScrollBars := True;
  {> ELSCROLLBAR}
  //ControlStyle := ControlStyle + [csOpaque];
  FActiveBorderType := fbtSunken;
  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChanged;
  FBorderSides := AllBorderSides;
  FFlat := False;
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
 FFlatFocusedScrollBars := False;
  FInactiveBorderType := fbtSunkenOuter;
  FMouseOver := False;
  FPainting := False;
  FPaintingTo := False;
  FTransparent := False;
  FUseBackground := False;
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FThemeMode := ttmPlatform;
  FTransparentXPThemes := true;
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
  if not (csDesigning in ComponentState) then
    StyleManager := DefaultStyleManager;
end;

destructor TElScrollBox.Destroy;
begin
  ImageForm := nil;
  FImgFormChLink.Free;
  FBackground.Free;
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
  inherited;
end;

procedure TElScrollBox.DoMouseEnter;
begin
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TElScrollBox.DoMouseLeave;
begin
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TElScrollBox.DoPaint(DC : HDC);
const
  BorderOffsets: array [TBorderStyle] of integer = (1, -1);
var
  CtlDC, TempDC: HDC;
  OldBmp, TempBmp: HBITMAP;
begin
  FPainting := True;
  if (not IsThemed) and
     (FTransparent or (FUseBackground and not FBackground.Empty)
     or
     ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))
     ) then
  begin
    CtlDC := DC;//GetDC(Handle);
    try
      TempDC := CreateCompatibleDC(CtlDC);
      try
        TempBmp := CreateCompatibleBitmap(CtlDC, ClientWidth + 1, ClientHeight + 1);
        try
          OldBmp := SelectObject(TempDC, TempBmp);
          FPaintingTo := True;
          try
            PaintTo(TempDC, 0, 0);
          finally
            FPaintingTo := False;
          end;
          if IsThemed or FFlat then DrawFlatBorder(TempDC);
          BitBlt(CtlDC, BorderOffsets[BorderStyle], BorderOffsets[BorderStyle], ClientWidth, ClientHeight, TempDC, 1, 1, SRCCOPY);
          SelectObject(TempDC, OldBmp);
        finally
          DeleteObject(TempBmp);
        end;
      finally
        DeleteDC(TempDC);
      end;
    finally
      // ReleaseDC(Handle, CtlDC);
    end;
  end
  else
  begin
    DrawThemedBackground(DC);
    // CtlDC := GetDC(Handle);
    //ReleaseDC(Handle, CtlDC);
  end;
  FPainting := False;
end;

procedure TElScrollBox.IFMRepaintChildren(var Message: TMessage);
var i : integer;
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  for i := 0 to ControlCount -1 do
  begin
    if Controls[i] is TWinControl then
      PostMessage(TWinControl(Controls[i]).Handle, Message.Msg, Message.wParam, Message.lParam);
  end;
end;

procedure TElScrollBox.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TElScrollBox.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if Assigned(ImageForm) then
    Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TElScrollBox.CreateParams(var Params: TCreateParams);
const
  LeftSB: array[Boolean] of DWORD = (0, WS_EX_LEFTSCROLLBAR);
begin
  inherited;
  Params.Style := Params.Style or WS_CLIPCHILDREN;
  if (BorderStyle = bsSingle) and Flat and (not IsThemed) then
  begin
    Params.Style := Params.Style and (not WS_BORDER);
    Params.ExStyle := Params.ExStyle and (not WS_EX_CLIENTEDGE);
  end;
  if NewStyleControls or UseCustomScrollBars then
    Params.ExStyle := Params.ExStyle or LeftSB[RightAlignedView];
  Params.WindowClass.style := Params.WindowClass.style or CS_HREDRAW or CS_VREDRAW;
end;

procedure TElScrollBox.SetRightAlignedView(Value: Boolean);
begin
  if FRightAlignedView <> Value then
  begin
    FRightAlignedView := Value;
    RecreateWnd;
  end;
end;

{$ifdef LMD_UNICODE}
{------------------------------------------------------------------------------}
procedure TElScrollBox.CMHintShow(var Message:TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

procedure TElScrollBox.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

procedure TElScrollBox.DrawThemedBackground(DC : HDC);
var
  hBr : HBRUSH;
  R : TRect;
begin
  GetClipBox(DC, R);
  if IsRectEmpty(R) then
    R := ClientRect;
  hBr := CreateSolidBrush(ColorToRGB(Color));
  FillRect(DC, R, hBr);
  DeleteObject(hBr);
end;

procedure TElScrollBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FImgForm) then
    ImageForm := nil;
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
end; { Notification }

procedure TElScrollBox.SetStyleManager(Value: TElStyleManager);
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

procedure TElScrollBox.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TElScrollBox.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
end;

procedure TElScrollBox.UpdateStyle;
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

procedure TElScrollBox.SetTransparentXPThemes(Value: Boolean);
begin
  if FTransparentXPThemes <> Value then
  begin
    FTransparentXPThemes := Value;
    Invalidate;
  end;
end;

procedure TElScrollBox.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElScrollBox.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElScrollBox.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElScrollBox.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElScrollBox.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElScrollBox.WMSize(var Message: TWMSize);
begin
  inherited;
  if IsThemed or (Flat and (BorderStyle <> bsNone)) then
    DrawFlatBorder(0);
end;

procedure TElScrollBox.AutoScrollInView(AControl: TControl);
begin
end;

procedure TElScrollBox.Loaded;
begin
  inherited;
  UpdateStyle;
end;

function TElScrollBox.getLMDPackage:TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;
end.
