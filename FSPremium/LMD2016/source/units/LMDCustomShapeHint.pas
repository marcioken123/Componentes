unit LMDCustomShapeHint;
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

LMDCustomShapeHint unit (RM)
----------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Graphics, Controls, LMDTypes, LMDButtonBase,
  LMD3DCaption, LMDShadow, LMDPNGImage, LMDNativeHint, LMDCustomHint,
  LMDGradient, LMDClass, LMDThemes;

type
  TLMDCustomShapeHint = class;

  TLMDHintStyle=(hsRect, hsRoundRect, hsEllipse, hsNoseRect, hsNoseRoundRect, hsNoseEllipse);
  TLMDHintPosition=(hpAboveLeft, hpAboveRight, hpBelowLeft, hpBelowRight);
  TLMDHintOption = (hoShowTitle, hoShowCloseButton, hoShowIcon, hoRightAngledNose);
  TLMDHintOptions = set of TLMDHintOption;
  TLMDHintCloseBtnType = (hcbCustom, hcbToolTip, hcbToolWindow);
  TLMDHintIconType = (hitCustom, hitError, hitInfo, hitQuestion, hitWarning);


  {-------------- class TLMDShapeHintWindow -----------------------------------}

  TLMDShapeHintWindow = class(TLMDCustomHTMLHintWindow)
  private
    FIcon:            TLMDPNGObject;
    FIconType:        TLMDHintIconType;
    FCloseBtnRect:    TRect;
    FCloseBtnPressed: Boolean;
    FTitle:           TLMDString;

    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    function  ShadowDepth: integer;
    procedure SetTitle(const Value: TLMDString);
    procedure SetIcon(const Value: TLMDPNGObject);
    procedure SetIconType(const Value: TLMDHintIconType);
  protected
    FOrigin:       TPoint;
    FCloseBtnSize: TSize;

    procedure AdjustTextRect(var aRect: TRect; aShowIcon, aShowCloseBtn: boolean); virtual;
    procedure CalculateDimensions(var aRect:TRect);virtual;
    procedure PreCreateWnd; virtual;
    procedure CreateWnd; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure PrepareIcon; virtual;
    procedure PaintHintWindow; virtual;
    procedure PaintCloseBtn(ARect: TRect; ABtnType: TLMDHintCloseBtnType; aButtonState: TLMDButtonState); virtual;
    procedure PaintBgr(ACanvas: TCanvas; ARect: TRect); virtual;
    procedure Draw(ACanvas: TCanvas; AHintPosition: TLMDHintPosition; var TxRect:TRect; Pos:TPoint); virtual;
    procedure SetPosition(Origin:TPoint; var pos:TLMDHintPosition; var aRect:TRect);
    procedure WndProc(var Message: TMessage);override;
    procedure DrawTextTo(ACanvas : TCanvas; ACaption : TLMDString; ATextRect : TRect); override;
    procedure DrawTitleTo(ACanvas : TCanvas; ACaption : TLMDString; ATextRect : TRect); virtual;
    procedure GetTitleSize(ACaption: String; var aRect: TRect);
    function  UseSystemShadow: boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function  HintControl: TLMDCustomShapeHint;
    procedure ActivateHint(aRect: TRect; const AHint: string); override;
    procedure ActivateHintExt(aRect:TRect; const aHint: string);
    property  Title: TLMDString read FTitle write SetTitle;
    property  Icon: TLMDPNGObject read FIcon write SetIcon;
    property  IconType: TLMDHintIconType read FIconType write SetIconType;
  end;

  TLMDCustomShapeHint = class(TLMDCustomHTMLHint)
  private
    FDefaultTitle: TLMDString;
    FTitleFont: TFont;
    FTitleFont3D: TLMD3DCaption;
    FOptions: TLMDHintOptions;
    FCloseBtnType: TLMDHintCloseBtnType;
    FCloseBtnStyle: TLMDUserButtonStyle;
    FDefaultIcon: TLMDHintIconType;

    FBorderColor:TColor;
    FPosition:TLMDHintPosition;
    FStyle:TLMDHintStyle;
    FShadow:TLMDShadow;
    FOnClose:TNotifyEvent;
    FUseSystemShadow: boolean;

    FNoseLength,
    FNoseWidth,
    FNoseAndleWidth,  {Elliptic Width of Nose}
    FRoundRect,       {RoundRect}
    FDistance: byte;  {Distance Hint from MousePointer}
    FIsBalloon: boolean;
    FGradient: TLMDGradient;
    FUseGradient: boolean;

    FThemeGlobalMode: boolean;
    FThemeMode: TLMDThemeMode;

    procedure SetShadow(aValue:TLMDShadow);
    procedure SetIsBalloon(const Value: boolean);
    procedure SetOptions(const Value: TLMDHintOptions);
    procedure SetTitleFont3D(const Value: TLMD3DCaption);
    procedure SetTitleFont(const Value: TFont);
    procedure SetCloseButtonType(const Value: TLMDHintCloseBtnType);
    procedure SetCloseButtonStyle(const Value: TLMDUserButtonStyle);
    procedure SetDefaultIcon(const Value: TLMDHintIconType);
    procedure SetUseSystemShadow(const Value: Boolean);
    procedure SetGradient(const Value: TLMDGradient);
    procedure SetThemeGlobalMode(const Value: Boolean);
    procedure SetThemeMode(const Value: TLMDThemeMode);
    procedure SetUseGradient(const Value: boolean);
  protected
    function GetHintClass: THintWindowClass; override;
    function UseThemeMode: TLMDThemeMode;
    property CloseBtnType: TLMDHintCloseBtnType read FCloseBtnType write SetCloseButtonType default hcbToolTip;
    property CloseBtnStyle: TLMDUserButtonStyle read FCloseBtnStyle write SetCloseButtonStyle default ubsWin40;
    property DefaultTitle: TLMDString read FDefaultTitle write FDefaultTitle;
    property Distance: byte read FDistance write FDistance default 1;
    property DefaultIcon: TLMDHintIconType read FDefaultIcon write SetDefaultIcon default hitInfo;
    property Gradient: TLMDGradient read FGradient write SetGradient;
    property IsBalloon: boolean read FIsBalloon write SetIsBalloon default false;
    property NoseLength: byte read FNoseLength write FNoseLength default 25;
    property NoseWidth: byte read FNoseWidth write FNoseWidth default 25;
    property NoseAngleWidth: byte read FNoseAndleWidth write FNoseAndleWidth default 25;
    property Options: TLMDHintOptions read FOptions write SetOptions;
    property Position:TLMDHintPosition read FPosition write FPosition default hpAboveRight;
    property RoundRectWidth: byte read FRoundRect write FRoundRect default 18;
    property Shadow: TLMDShadow read FShadow write SetShadow;
    property Style: TLMDHintStyle read FStyle write FStyle default hsNoseRoundRect;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property TitleFont3D: TLMD3DCaption read FTitleFont3D write SetTitleFont3D;
    property UseGradient: boolean read FUseGradient write SetUseGradient default false;
    property UseSystemShadow: boolean read FUseSystemShadow write SetUseSystemShadow default false;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure Assign(Source: TPersistent); override;
    function  IsThemed: Boolean;
    property  HideAccelChar;
  published
    property About;
    property BorderColor: TColor read FBorderColor write FBorderColor default clBlack;
    property Color;
    property Enabled;
    property OnCloseHintWindow: TNotifyEvent read FOnClose write FOnClose;
    property TitleFont: TFont read FTitleFont write SetTitleFont;
  end;

implementation

uses
  LMDGraph, SysUtils, Types, Forms, Themes, UxTheme, Dialogs, LMDGraphUtils,
  LMDProcs, LMDSysIn, LMDMessageHint, LMDBase;

const
  HConvert  = Pi / 180;
  NoseDelta = 20;

function LMDEllipticAngleToPoint(aRect:TRect; Angle:TLMDAngle; aDelta: integer):TPoint;
var
  center:TPoint;
  a, b: integer;
begin
  with aRect do
    begin
      center := Point(LMDMidI(Left, Right), LMDMidI(Top, Bottom));
      a := Right - center.x;
      b := Bottom - center.y;
      //new version for region painting:
      //Decrement by aDelta is for avoiding junction glitch of the triangled nose and
      //main elliptic shape
      result.X := center.X + Trunc((a - aDelta) * (cos(Angle * HConvert)));
      result.Y := center.Y - Trunc((b - aDelta) * (sin(Angle * HConvert)));
    end;
end;

{---------------------------- Private -----------------------------------------}
procedure TLMDCustomShapeHint.SetCloseButtonStyle(
  const Value: TLMDUserButtonStyle);
begin
  FCloseBtnStyle := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeHint.SetCloseButtonType(const Value: TLMDHintCloseBtnType);
begin
  FCloseBtnType := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeHint.SetDefaultIcon(const Value: TLMDHintIconType);
begin
  FDefaultIcon := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeHint.SetGradient(const Value: TLMDGradient);
begin
  FGradient.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeHint.SetIsBalloon(const Value: boolean);
var
  i:  Integer;
  hw: TLMDBaseHintWindow;
begin
  FIsBalloon := Value;

  if FIsBalloon then
  begin
    FPosition:=hpAboveRight;
    FStyle:=hsNoseRoundRect;
    FNoseLength := 25;
    FNoseWidth := 25;
    FNoseAndleWidth := 25;
    FRoundRect := 18;
    FDistance := 1;
    FUseSystemShadow := true;
    FShadow.Style := hssNone;
  end
  else
  begin
    FPosition:=hpAboveRight;
    FStyle:=hsRect;
    FShadow.Style := hssNone;

    for i := 0 to WindowCount - 1 do
    begin
      hw := Windows[i];
      SetWindowRgn(hw.Handle, 0, False);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeHint.SetOptions(const Value: TLMDHintOptions);
begin
  FOptions := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeHint.SetShadow(aValue:TLMDShadow);
begin
  FShadow.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeHint.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
    begin
      FThemeGlobalMode := Value;
      //DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeHint.SetThemeMode(const Value: TLMDThemeMode);
begin
  if (FThemeMode <> Value) then
    begin
      FThemeMode := Value;
      //if not FThemeGlobalMode then
      //  DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomShapeHint.IsThemed: Boolean;
begin
  Result := (UseThemeMode <> ttmNone);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeHint.SetTitleFont(const Value: TFont);
begin
  FTitleFont.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeHint.SetTitleFont3D(const Value: TLMD3DCaption);
begin
  FTitleFont3D.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeHint.SetUseGradient(const Value: boolean);
begin
  FUseGradient := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShapeHint.SetUseSystemShadow(const Value: Boolean);
begin
  if FUseSystemShadow <> Value then
    FUseSystemShadow := Value;
end;

{------------------------------------------------------------------------------}
function TLMDCustomShapeHint.UseThemeMode: TLMDThemeMode;
begin
  if FThemeGlobalMode then
    result := LMDApplication.ThemeGlobalMode
  else
    result := FThemeMode;
  result := LMDThemeServices.UseTheme(result);
end;

{--------------------------- Public -------------------------------------------}
procedure TLMDCustomShapeHint.Assign(Source: TPersistent);
begin
  inherited;
  if Assigned(Source) and (Source is TLMDCustomShapeHint) then
    begin
      BorderColor := TLMDCustomShapeHint(Source).BorderColor;
      Options := TLMDCustomShapeHint(Source).Options;
      Position := TLMDCustomShapeHint(Source).Position;
      Shadow := TLMDCustomShapeHint(Source).Shadow;
      Style := TLMDCustomShapeHint(Source).Style;
      UseSystemShadow := TLMDCustomShapeHint(Source).UseSystemShadow;
      Font.Assign(TLMDCustomShapeHint(Source).Font);
      TitleFont.Assign(TLMDCustomShapeHint(Source).TitleFont);
      Font3D.Assign(TLMDCustomShapeHint(Source).Font3D);
      TitleFont3D.Assign(TLMDCustomShapeHint(Source).TitleFont3D);
    end;
end;

{------------------------------------------------------------------------------}
Constructor TLMDCustomShapeHint.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FTitleFont := TFont.Create;
  FTitleFont.Name := 'Arial';
  FTitleFont.Size := 10;

  FTitleFont3D:=TLMD3DCaption.Create;
  FTitleFont.Color:=clInfoText;

  FDefaultTitle := '';

  FPosition:=hpAboveRight;
  FStyle:=hsNoseRoundRect;
  FBorderColor:=clBlack;
  FShadow := TLMDShadow.Create;
  FUseSystemShadow := false;
  FNoseLength := 25;
  FNoseWidth := 25;
  FNoseAndleWidth := 25;
  FRoundRect := 18;
  FDistance := 1;

  FCloseBtnType := hcbToolTip;
  FCloseBtnStyle := ubsWin40;
  FDefaultIcon := hitInfo;

  FGradient := TLMDGradient.Create;
  FUseGradient := false;
  FThemeMode := ttmPlatform;
  FThemeGlobalMode := false;
  FIsBalloon := false;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomShapeHint.Destroy;
begin
  FreeAndNil(FTitleFont3D);
  FreeAndNil(FTitleFont);
  FreeAndNil(FShadow);
  FreeAndNil(FGradient);
  inherited Destroy;
end;

function TLMDCustomShapeHint.GetHintClass: THintWindowClass;
begin
  Result := TLMDShapeHintWindow;
end;

{ ********************* TLMDShapeHintWindow ***********************************}
{--------------------------- Private ------------------------------------------}
procedure TLMDShapeHintWindow.CalculateDimensions(var aRect:TRect);
var
  lStyle: TLMDHintStyle;
  lNoseWidth, lNoseLen, lRw: byte;
begin
  lStyle := HintControl.Style;
  lRw := HintControl.RoundRectWidth;
  lNoseLen := HintControl.NoseLength;
  lNoseWidth := HintControl.NoseWidth;
  with aRect do
    case lStyle of
      hsRect:         LMDAdjustRect(aRect, ShadowDepth + 4, ShadowDepth);
      hsRoundRect:    LMDAdjustRect(aRect, ShadowDepth + (lRw Div 2), ShadowDepth + 4);
      hsNoseRect,
      hsNoseRoundRect:
        begin
          if Right < lNoseWidth + lRw then
            Right := lNoseWidth + lRw;
          LMDAdjustRect(aRect, lNoseLen + ShadowDepth + (lRw Div 2), lNoseLen + ShadowDepth + 3 + 6);
        end;
      hsEllipse:      LMDAdjustRect(aRect, Right div 3 + (ShadowDepth),
                                    Bottom div 3 + (ShadowDepth));
      hsNoseEllipse:  LMDAdjustRect(aRect, Right div 2 + ShadowDepth + lNoseLen,
                                    Bottom div 2 + ShadowDepth + lNoseLen);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.SetIcon(const Value: TLMDPNGObject);
begin
  FIcon := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.SetIconType(const Value: TLMDHintIconType);
begin
  FIconType := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.SetPosition(Origin:TPoint; var pos:TLMDHintPosition;
                                           var aRect:TRect);
var
  counter:Integer;
  temp, scrRect:TRect;
  lShift: integer;
  lOpt: TLMDHintOptions;
  lStyle: TLMDHintStyle;
  lNoseLen, lDist: integer;
begin
  lOpt := HintControl.Options;
  lStyle := HintControl.Style;
  lDist := HintControl.Distance;
  lNoseLen := HintControl.NoseLength;
  Counter:=0;
  // Fix in 7.01.10
  scrRect:=Rect(Screen.DesktopLeft,Screen.DesktopTop, Screen.DesktopWidth, Screen.DesktopHeight);
  // --------------
  repeat
    temp := aRect;
    case pos of
      hpAboveRight: OffSetRect(temp, Origin.X + lDist, Origin.Y - lDist - aRect.Bottom);
      hpAboveLeft:  OffsetRect(temp, Origin.X - lDist - aRect.Right,
                                     Origin.Y - lDist - aRect.Bottom);
      hpBelowRight: OffSetRect(temp, Origin.X + 6 * lDist, Origin.Y + lDist);
      hpBelowLeft:  OffSetRect(temp, Origin.X - (3 * lDist) - aRect.Right, Origin.Y + lDist);
    end;
    if (PtInRect(scrRect, temp.TopLeft)) and  (PtInRect(scrRect, temp.BottomRight)) then
      Counter := 255
    else
      if Ord(pos) < Ord(High(TLMDHintPosition)) then
        pos := Succ(pos)
      else
        pos := TLMDHintPosition(0);
    Inc(Counter);
  until (Counter > Ord(High(TLMDHintPosition)));

  //<-- adjust position if nose is right-angled
  if (hoRightAngledNose in lOpt) and
     (lStyle in [hsNoseRect, hsNoseRoundRect]) then
    begin
      lShift :=  lNoseLen + NoseDelta;
      if pos in [hpAboveLeft, hpBelowLeft] then
        lShift := -lShift;
      OffsetRect(temp, -lShift, 0);
    end;
  //-->

  aRect := temp;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.SetTitle(const Value: TLMDString);
begin
  FTitle := Value;
end;

{------------------------------------------------------------------------------}
function TLMDShapeHintWindow.ShadowDepth: integer;
var
  lUseSh: boolean;
  lSh: TLMDShadow;
begin
  if HintControl = nil then
  begin
    Result := 0;
    Exit;
  end;

  lSh := HintControl.Shadow;
  lUseSh := HintControl.UseSystemShadow;
  if (lSh.Style <> hssNone) and not lUseSh then
    Result := lSh.Depth
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  message.result:=1;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDShapeHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      style:=WS_POPUP {or WS_DISABLED};
      //Added in new version to support system shadows //VB Mar 2008
      if UseSystemShadow then
        WindowClass.Style := WindowClass.style or $00020000  //CS_DROPSHADOW
      else
        WindowClass.Style := WindowClass.style and not $00020000; // CS_DROPSHADOW
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.Paint;
begin
  if (HintControl = nil) and (not IsCustom) then
  begin
    inherited Paint;
    Exit;
  end
  else
    PaintHintWindow;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.PaintBgr(ACanvas: TCanvas; ARect: TRect);
var
  lGrad: TLMDGradient;
  lUseGrad,
  lIsThemed: boolean;
  lUseTM: TLMDThemeMode;
begin
  lGrad     := HintControl.Gradient;
  lUseGrad  := HintControl.UseGradient;
  lIsThemed := HintControl.IsThemed;
  lUseTM    := HintControl.UseThemeMode;

  if lUseGrad then
  begin
    if Assigned(lGrad) then
      lGrad.PaintGradient(aCanvas, aRect);
  end
  else if LMDSIWindowsXPUp and lIsThemed then
  begin
    // Paint themed background if themes enabled
    with ThemeServices do
      LMDThemeServices.DrawElement(lUseTM, aCanvas.Handle, GetElementDetails(
                                   tttStandardNormal), aRect, @aRect);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.PaintCloseBtn(ARect: TRect;
  ABtnType: TLMDHintCloseBtnType; aButtonState: TLMDButtonState);
var
  flag: integer;
  Details: TThemedElementDetails;
  ltm: TLMDThemeMode;
  lCbtnStyle: TLMDUserButtonStyle;
begin
  lCbtnStyle := HintControl.CloseBtnStyle;
  ltm        := HintControl.UseThemeMode;

  if (ltm = ttmNone) and (ABtnType <> hcbCustom) then
  begin
    if not (LMDApplication.UseXPThemes) then
      ABtnType := hcbCustom
    else
      ltm := ttmPlatform;
  end;
  case ABtnType of
    hcbCustom:
    begin
      flag := BDF_SPEEDBUTTON or BDF_ROUNDED {or BDF_CTLXP};
      LMDDrawBtnFaceExt(self, Canvas, false, aRect, lCbtnStyle, aButtonState, flag, Color, ttmNone);
      Canvas.Pen.Width := 2;
      Canvas.MoveTo(aRect.Left + 1, aRect.Top + 1);
      Canvas.LineTo(aRect.Right - 1, aRect.Bottom - 1);
      Canvas.MoveTo(aRect.Right - 1, aRect.Top + 1);
      Canvas.LineTo(aRect.Left + 1, aRect.Bottom - 1);
      Canvas.Pen.Width := 1;
    end;
    hcbToolTip:
    begin
      case aButtonState of
        bsMouseOver: Details := ThemeServices.GetElementDetails(tttCloseHot);
        bsDown: Details := ThemeServices.GetElementDetails(tttClosePressed);
      else
        Details :=  ThemeServices.GetElementDetails(tttCloseNormal);
      end;
      LMDThemeServices.DrawElement(ltm, Canvas.Handle, Details, aRect);
    end;
    hcbToolWindow:
    begin
      case aButtonState of
        bsMouseOver: Details := ThemeServices.GetElementDetails(twSmallCloseButtonHot);
        bsDown: Details := ThemeServices.GetElementDetails(twSmallCloseButtonPushed);
      else
        Details := ThemeServices.GetElementDetails(twSmallCloseButtonNormal);
      end;
      LMDThemeServices.DrawElement(ltm, Canvas.Handle, Details, aRect);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.PaintHintWindow;
var
  pos:TLMDHintPosition;
  lTextRect, lTitleRect, aRect: TRect;
  lTitleHeight, lTitleWidth, lTitleGap: integer;
  lTitle: TLMDString;
  lDrawIcon, lDrawCb: boolean;
  lOpt: TLMDHintOptions;
  lCbtnType: TLMDHintCloseBtnType;
begin
  pos := HintControl.Position;
  lOpt := HintControl.Options;
  lCbtnType := HintControl.CloseBtnType;
  lDrawCb := (hoShowCloseButton in lOpt);
  lDrawIcon := (hoShowIcon in lOpt);

  {1. Icon and close button}
  {1.1. Icon}
  if lDrawIcon then
    PrepareIcon;

  {1.2 Calulate close button size, if any}
  if lDrawCb then
    case lCbtnType of
      hcbCustom:
      begin
        FCloseBtnSize.cx := 16;
        FCloseBtnSize.cy := 16;
      end;
      hcbToolTip:
        LMDThemeServices.GetThemePartSize(ttmPlatform, Canvas.Handle, teToolTip, TTP_CLOSE, TTCS_NORMAL, FCloseBtnSize);
      hcbToolWindow:
        LMDThemeServices.GetThemePartSize(ttmPlatform, Canvas.Handle, teWindow, WP_SMALLCLOSEBUTTON, PBS_NORMAL, FCloseBtnSize);
    end;

  {2. Calculate title rect, if any}
  if (hoShowTitle in lOpt) then
  begin
    lTitle := Title;
    if lTitle = '' then
      lTitle := HintControl.DefaultTitle;
      lTitleRect := Bounds(0, 0 , HintControl.RealMaxWidth, 0);
    GetTitleSize(lTitle, lTitleRect);
    lTitleHeight := lTitleRect.Bottom - lTitleRect.Top;
    lTitleWidth := lTitleRect.Right - lTitleRect.Left;
    lTitleGap := 1;
  end
  else
  begin
    lTitleHeight := 0;
    lTitleWidth := 0;
    lTitleGap := 0;
  end;

  {3. Calculate Dimensions of text}
  aRect := Bounds(0, 0 , HintControl.RealMaxWidth, 0);
  {$IFDEF LMD_UNICODE}
  GetTextSize(FWideCaption, aRect);
  {$ELSE}
  GetTextSize(Caption, aRect);
  {$ENDIF}
  {3.1. Allow space for title}
  aRect.Bottom := aRect.Bottom + lTitleHeight + lTitleGap;
  if aRect.Right < aRect.Left + lTitleWidth  then
    aRect.Right := aRect.Left + lTitleWidth;
  lTextRect := aRect;

  {4. Get Dimensions of full Control}
  CalculateDimensions(aRect);

  {4.1. Allow space for close button}
  if lDrawCb then
  begin
    aRect.Right := aRect.Right + FCloseBtnSize.cx + 4;
    if aRect.Bottom < FCloseBtnSize.cy + 2 then
      aRect.Bottom := FCloseBtnSize.cy + 2;
  end;

  {4.2. Allow space for icon}
  if lDrawIcon then
  begin
    aRect.Right := aRect.Right + Icon.Width + 2;
    if aRect.Bottom < Icon.Height + 2 then
      aRect.Bottom := Icon.Height + 2;
  end;

  {5. Position the window}
  SetPosition(FOrigin, pos, aRect);
  BoundsRect := aRect;

  {6. Draw the hint shape}
  Draw(Canvas, pos, lTextRect, aRect.TopLeft);

  {7. Paint the Text}
  //Canvas.Brush.Color := HintControl.Color; <-- Color is set in Draw method, step 6
  Canvas.Font:= HintControl.GetHintFont;

  OffsetRect(lTextRect, 2, lTitleHeight + lTitleGap);

  AdjustTextRect(lTextRect, lDrawIcon, lDrawCb);

  {$IFDEF LMD_UNICODE}
  DrawTextTo(Canvas, FWideCaption, lTextRect);
  {$ELSE}
  DrawTextTo(Canvas, Caption, lTextRect);
  {$ENDIF}

  {8. Paint the Title}
  if hoShowTitle in lOpt then
  begin
    lTitleRect.Left := lTextRect.Left;
    lTitleRect.Right := lTitleRect.Left + lTitleWidth;
    lTitleRect.Top := lTextRect.Top - lTitleGap - lTitleHeight;
    lTitleRect.Bottom := lTitleRect.Top + lTitleHeight;
    Canvas.Font := HintControl.TitleFont;
    DrawTitleTo(Canvas, lTitle, lTitleRect);
  end;

  {9. Paint the Close button}
  if lDrawCb then
  begin
    aRect := lTextRect;
    //aRect.Top := aRect.Top - lTitleHeight;
    aRect.Bottom := aRect.Top + FCloseBtnSize.cy;
    aRect.Left := aRect.Right - 1;
    aRect.Right := aRect.Left + FCloseBtnSize.cx;
    FCloseBtnRect := aRect;
    PaintCloseBtn(ARect, lCbtnType, bsUp);
  end;

  {10. Paint the icon, if any}
  if lDrawIcon then
  begin
    ARect.Left := lTextRect.Left - Icon.Width - 1;
    ARect.Top := lTextRect.Top - lTitleHeight;
    ARect.Right := ARect.Left + Icon.Width;
    ARect.Bottom := ARect.Top + Icon.Height;
    Icon.Draw(Canvas, ARect);
  end;
end;

procedure TLMDShapeHintWindow.PrepareIcon;
var
  lIconType: TLMDHintIconType;
  lOpt: TLMDHintOptions;
  const ICONID: array[TLMDHintIconType]
    of string = ('', IDB_HINTICONERROR,
                     IDB_HINTICONINFO,
                     IDB_HINTICONQUESTION,
                     IDB_HINTICONWARNING);
begin
  lOpt := HintControl.Options;
  if not (hoShowIcon in lOpt) or (Icon <> nil) then
    exit;
  lIconType := IconType;
  Icon := TLMDPNGObject.Create;
  if (IconType = hitCustom) then
    lIconType := HintControl.DefaultIcon;
    Icon.LoadFromResourceName(HInstance, ICONID[lIconType]);
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.WndProc(var Message: TMessage);

   procedure CallHandler;
   begin
     if (HintControl <> nil) and Assigned(HintControl.OnCloseHintWindow) then
       HintControl.OnCloseHintWindow(HintControl);
   end;

   function HandleCloseBtn: boolean;
   var
     lpos:TSmallPoint;
     //lmsg: TWMShowWindow;
     lCbtnType: TLMDHintCloseBtnType;
   begin
    lCbtnType := HintControl.CloseBtnType;
    result := false;
     case Message.Msg of
       WM_LBUTTONDOWN:
         begin
           lPos := TWMMouse(Message).Pos;
           if PtInRect(FCloseBtnRect, Point(lpos.x, lpos.y)) then
             begin
               FCloseBtnPressed := true;
               PaintCloseBtn(FCloseBtnRect, lCbtnType, bsDown);
             end;
         end;
       WM_LBUTTONUP:
         begin
           if FCloseBtnPressed then
             begin
               //lpos := TWMMouseMove(Message).pos;
               //lmsg.Msg := WM_SHOWWINDOW;
               //lmsg.Show := false;
               //WMShowWindow(lmsg);
               OnHide;
               result := true;
             end;
           FCloseBtnPressed := false;
         end;
       WM_MOUSEMOVE:
         begin
           lpos := TWMLButtonDown(Message).pos;
           if FCloseBtnPressed then
             PaintCloseBtn(FCloseBtnRect, lCbtnType, bsDown)
           else
             begin
               if PtInRect(FCloseBtnRect, Point(lpos.x, lpos.y)) then
                 PaintCloseBtn(FCloseBtnRect, lCbtnType, bsMouseOver)
               else
                 PaintCloseBtn(FCloseBtnRect, lCbtnType, bsUp);
             end;
         end;
       WM_MOUSELEAVE:
         PaintCloseBtn(FCloseBtnRect, lCbtnType, bsUp);
     end;
   end;

begin
  with Message do
    if IsCustom then
    begin
      if Msg=WM_Destroy then
        CallHandler;
      if HandleCloseBtn then
        exit;
      if TLMDMessageHint(HintControl).SetCapture then
      begin
        if ((Msg >= WM_KEYFIRST) and (Msg <= WM_KEYLAST)) or
           ((Msg = CM_ACTIVATE) or (Msg = CM_DEACTIVATE)) or
           (Msg = CM_APPKEYDOWN) or (Msg = CM_APPSYSCOMMAND) or
           (Msg = WM_KEYDOWN) or (MSG = WM_Activate) or
           (Msg = WM_COMMAND) or (Msg = 28) or
           ((Msg > WM_MOUSEMOVE) and (Msg <= WM_MOUSELAST)) or (Msg = WM_NCMOUSEMOVE) then
        begin
          SetCaptureControl(nil);
          ReleaseHandle;
          if (Msg <> WM_LBUTTONDOWN) and (Msg <> WM_MOUSEMOVE) then //WM_LBUTTONDOWN must reach TLMDCustomHintWindow
            exit;
        end
      end
    end
    else if (Msg = WM_SHOWWINDOW) and not TWMShowWindow(Message).Show then
      CallHandler;
  inherited WndProc(Message);
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.DrawTextTo(ACanvas: TCanvas;
  ACaption: TLMDString; ATextRect: TRect);
var
  flags: LongInt;
begin
  if HintControl = nil then
    Exit;
  if IsHtml then
    inherited DrawTextTo (ACanvas, ACaption, ATextRect)
  else
  begin
    flags:=0;
    flags:=DrawTextBiDiModeFlags(flags);
    if HintControl.HideAccelChar then
      flags := flags or DT_NOPREFIX;
    LMDDrawTextExt(ACanvas, ACaption, HintControl.Font3D, ATextRect,
                   DT_Left or DT_WORDBREAK or flags, [TLMDDrawTextStyle(Enabled)], nil);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.DrawTitleTo(ACanvas: TCanvas; ACaption: TLMDString; ATextRect: TRect);
var
  flags: LongInt;
  lTitleFont3d: TLMD3DCaption;
begin
  if HintControl = nil then
    Exit;
  lTitleFont3D := HintControl.TitleFont3D;
  flags:=0;
  flags:=DrawTextBiDiModeFlags(flags);
  if HintControl.HideAccelChar then
    flags := flags or DT_NOPREFIX;
  LMDDrawTextExt(ACanvas, ACaption, lTitleFont3D, ATextRect,
                 DT_Left or DT_WORDBREAK or flags, [TLMDDrawTextStyle(Enabled)], nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.GetTitleSize(ACaption: String; var aRect: TRect);
var
  flags: LongInt;
  lTitleFont: TFont;
  lTitleFont3D: TLMD3DCaption;
begin
  if HintControl = nil then
    Exit;
  lTitleFont3D := HintControl.TitleFont3D;
  lTitleFont := HintControl.TitleFont;
  flags:=0;
  flags:=DrawTextBiDiModeFlags(flags) or DT_NOPREFIX;
  LMDDrawTextCalc(ACaption, lTitleFont3D, aRect, lTitleFont, True, false, 0, flags);
end;

function TLMDShapeHintWindow.HintControl: TLMDCustomShapeHint;
begin
  Result := (inherited HintControl) as TLMDCustomShapeHint;
end;

{------------------------------------------------------------------------------}
function TLMDShapeHintWindow.UseSystemShadow: boolean;
var
  lShadowsEnabled: BOOL;
begin
  result := false;
  lShadowsEnabled := false;
  if LMDSIWindowsXPUp then
    SystemParametersInfo($1024{SPI_GETDROPSHADOW}, 0, @lShadowsEnabled, 0);
  if HintControl <> nil then
    result := HintControl.UseSystemShadow and lShadowsEnabled;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDShapeHintWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Canvas.Brush.Style:=bsClear;
  FCloseBtnPressed := false;
  FIcon := nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDShapeHintWindow.Destroy;
begin
  if Assigned(Icon) then
    Icon.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.ActivateHint(aRect: TRect; const AHint: string);
begin
  if (aRect.Right = -1) and (aRect.Bottom = -1) then
  begin
    FOrigin := Point(aRect.Left, aRect.Top);
    if (HintControl = nil) and not IsCustom then
      Exit;
  end
  else
    GetCursorPos(FOrigin);

  {Standard Behaviour if no ShapeHintControl is assigned}
  if not IsCustom and (HintControl = nil) then
  begin
    inherited ActivateHint(aRect, AHint);
    Exit;
  end;

  //Moved to CreateWnd to support system shadow //VB Mar 2008
  //if not FCustom then FCaller := GetShapeHintControl;
  {$IFDEF LMD_UNICODE}
  FWideCaption := WideString(AHint);
  {$ELSE}
  Caption := AHint;
  {$ENDIF}
  PaintHintWindow;

  if IsCustom and TLMDMessageHint(HintControl).SetCapture then
    SetCaptureControl(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.ActivateHintExt(aRect: TRect;
  const AHint: string);
begin
  CalcHintRect(MaxWidth, AHint, nil);
  ActivateHint(aRect, aHint);
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.AdjustTextRect(var aRect: TRect; aShowIcon,
  aShowCloseBtn: boolean);
begin
  if not aShowCloseBtn and aShowIcon then
    OffsetRect(aRect, Icon.Width div 2, 0);
  if aShowCloseBtn and not aShowIcon then
    OffsetRect(aRect, -FCloseBtnSize.cx div 2, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.Draw(ACanvas: TCanvas; aHintPosition: TLMDHintPosition;
          var TxRect:TRect; pos:TPoint);

var
  LWRgn, LRgn, LRgnS: HRGN;
  wRect: TRect;
  lShapeRect: TRect;
  lNShift: integer;

  lOpt: TLMDHintOptions;
  lShadow: TLMDShadow;
  lStyle: TLMDHintStyle;
  lNoseAngleWidth, lRoundRectWidth, lNoseLength, lNoseWidth: byte;
  lUseGradient, lIsThemed: boolean;

  function CreatePolyRgn(const Points: array of TPoint): HRGN;
  begin
    Result := CreatePolygonRgn(Points, Length(Points), WINDING);
  end;

  procedure prepareMaskDraw;
  begin
    with aCanvas do
      case lShadow.Style of
        hssSolid:
        begin
          brush.Color := lShadow.Color;
          pen.Style := psClear;
        end;
        hssTracing:
        begin
          brush.Bitmap := LMDApplication.GetBrushBitmap(lShadow.Color);
          pen.Mode := pmMask;
          pen.Style := psClear;
        end;
      end;
  end;

  procedure prepareNormalDraw;
  begin
    with aCanvas do
    begin
      Pen.Style := psSolid;
      Pen.Mode := pmCopy;
      Pen.Color := HintControl.BorderColor;
      Brush.Color := HintControl.Color;
      Brush.Style := bsSolid;
   end;
  end;

  procedure PrepareEllipse(R: TRect; ARgnOnly: boolean; var ARgn: HRGN);
  var
    rgn: HRGN;
  begin
    inc(R.Top);
    dec(R.Right);
    if ARgnOnly then
      ARgn :=  CreateEllipticRgnIndirect(R)
    else
    begin
      if ARgn = 0 then
      begin
        BeginPath(ACanvas.Handle);
        ACanvas.Ellipse(R);
        EndPath(ACanvas.Handle);
        ARgn := PathToRegion(ACanvas.Handle);

        BeginPath(ACanvas.Handle);
        ACanvas.Ellipse(R);
        EndPath(ACanvas.Handle);
        WidenPath(ACanvas.Handle);
        rgn := PathToRegion(ACanvas.Handle);
        CombineRgn(ARgn, ARgn, rgn, RGN_OR);
        DeleteObject(rgn);
      end;
      BeginPath(ACanvas.Handle);
      ACanvas.Ellipse(R);
      EndPath(ACanvas.Handle);
    end;
  end;

  procedure PrepareRect(R: TRect; flag: byte; ARgnOnly: boolean; var ARgn: HRGN);
  var
    rgn: HRGN;
    procedure CreatePath;
    begin
      case lStyle of
        hsRoundRect: ACanvas.RoundRect(R.Left, R.Top, R.Right, R.Bottom, lRoundRectWidth, lRoundRectWidth);
        hsRect: ACanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
      end;
    end;
  begin
    inc(R.Top);
    dec(R.Right);
    if ARgnOnly then
      case lStyle of
        hsRoundRect: ARgn :=  CreateRoundRectRgn(R.Left, R.Top, R.Right,  R.Bottom, lRoundRectWidth, lRoundRectWidth);
        hsRect: ARgn :=  CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
      end
    else
    begin
      if ARgn = 0 then
      begin
        BeginPath(ACanvas.Handle);
        CreatePath;
        EndPath(ACanvas.Handle);
        ARgn := PathToRegion(ACanvas.Handle);

        BeginPath(ACanvas.Handle);
        CreatePath;
        EndPath(ACanvas.Handle);
        WidenPath(ACanvas.Handle);
        rgn := PathToRegion(ACanvas.Handle);
        CombineRgn(ARgn, ARgn, rgn, RGN_OR);
        DeleteObject(rgn);
      end;
      BeginPath(ACanvas.Handle);
      CreatePath;
      EndPath(ACanvas.Handle);
    end;
  end;

  procedure PrepareMRect(R:TRect; stp, ep:TPoint; flag:Byte; ARgnOnly:boolean; var ARgn: HRGN);
  var
    LNoseRgn, rgn: HRGN;

    procedure CreatePath;
    var
      lDelta, lDelta2, w, ew: integer;
    begin
      if hoRightAngledNose in lOpt then
        lDelta := lNoseWidth
      else
        lDelta := 0;
      w := lRoundRectWidth;
      ew := w div 2;
      //Dec(R.Bottom);//r := Rect(x, y + 1, x1 - 1, y1 - 1);
      case lStyle of
        hsNoseRoundRect:
          if aHintPosition in [hpAboveLeft, hpAboveRight] then
            with aCanvas do
              begin
                //nose
                MoveTo(stp.X, stp.y - 1);
                LineTo(ep.X, ep.y);
                LineTo(stp.X + lNoseWidth + 1, stp.y - 1);
                //bottom line after nose
                LineTo(r.Right - ew - 1, stp.y - 1);
                //right bottom corner
                Windows.ArcTo(handle, r.Right - w, r.Bottom - w, r.Right, r.bottom, r.right - ew, r.bottom, r.Right, r.bottom - ew);
                //right line
                LineTo(r.Right - 1, r.Top + ew);
                //right top corner
                Windows.ArcTo(handle, r.Right - w, r.Top, r.Right, r.Top + w, r.right, r.Top + ew + 1, r.Right - ew, r.Top);
                //top line
                LineTo(r.Left + ew - 1, r.Top);
                //left top corner
                Windows.ArcTo(handle, r.Left, r.Top, r.Left + w, r.Top + w, r.Left + ew, r.Top, r.Left, r.Top + ew);
                //left line
                LineTo(r.Left, r.Bottom - ew - 1);
                //left bottom corner
                Windows.ArcTo(handle, r.Left, r.Bottom - w, r.Left + w, r.Bottom, r.Left, r.Bottom - ew, r.Left + ew, r.Bottom);
                //bottom line before nose
                LineTo(stp.X, stp.y - 1);
              end
          else
            with aCanvas do
              begin
                //nose
                MoveTo(stp.X + lNoseWidth, stp.y - 1);
                LineTo(ep.X + lDelta, ep.y);
                LineTo(stp.X, stp.y );
                //top line after nose
                LineTo(r.Left + ew - 1, r.Top);
                //left top corner
                Windows.ArcTo(handle, r.Left, r.Top, r.Left + w, r.Top + w, r.Left + ew, r.Top, r.Left, r.Top + ew);
                //left line
                LineTo(r.Left, r.Bottom - ew - 1);
                //left bottom corner
                Windows.ArcTo(handle, r.Left, r.Bottom - w, r.Left + w, r.Bottom, r.Left, r.Bottom - ew, r.Left + ew, r.Bottom);
                //bottom line
                LineTo(r.Right - ew - 1, r.Bottom - 1);
                //right bottom corner
                Windows.ArcTo(handle, r.Right - w, r.Bottom - w, r.Right, r.bottom, r.right  - ew, r.bottom, r.Right, r.bottom - ew);
                //right line
                LineTo(r.Right - 1, r.Top + ew);
                //right top corner
                Windows.ArcTo(handle, r.Right - w, r.Top, r.Right, r.Top + w, r.right, r.Top + ew + 1, r.Right - ew, r.Top);
                canvas.LineTo(stp.X + lNoseWidth, stp.y);
              end;
        hsNoseRect:
          if aHintPosition in [hpAboveRight, hpAboveLeft] then
            ACanvas.Polygon([Point(r.Left, r.Bottom), stp, Point(ep.x, ep.y + 1), Point(stp.X + lNoseWidth + 1, stp.Y), Point(r.Right, r.Bottom), Point(r.Right, r.Top), Point(r.Left, r.Top)])
          else
            begin
              if aHintPosition = hpBelowLeft then
                lDelta2 := 0
              else
                lDelta2 := 1;
              ACanvas.Polygon([stp, r.TopLeft, Point(r.Left, r.Bottom - 1), Point(r.Right, R.Bottom - 1), Point(r.Right, r.Top), Point(stp.X + lNoseWidth, stp.Y), Point(ep.x + lDelta, ep.y + lDelta2)]);
            end;
      end;
    end;

  begin
    inc(R.Top);
    dec(R.Right);
    if ARgnOnly then
      begin
        case lStyle of
          hsNoseRoundRect: ARgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, lRoundRectWidth, lRoundRectWidth);
          hsNoseRect: ARgn :=  CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
        end;
        if flag=0 then
          exit;
        if (hoRightAngledNose in lOpt) and (aHintPosition in [hpBelowLeft, hpBelowRight]) then
          lNShift := lNoseWidth
        else
          lNShift := 0;
        LNoseRgn := CreatePolyRgn([stp, Point(ep.x + lNShift, ep.y), Point(stp.X + lNoseWidth, stp.Y)]);
        CombineRgn(ARgn, LNoseRgn, ARgn, RGN_OR);
        DeleteObject(LNoseRgn);
      end
    else
      begin
        if ARgn = 0 then
          begin
            BeginPath(ACanvas.Handle);
            CreatePath;
            EndPath(ACanvas.Handle);
            ARgn := PathToRegion(ACanvas.Handle);

            BeginPath(ACanvas.Handle);
            CreatePath;
            EndPath(ACanvas.Handle);
            WidenPath(ACanvas.Handle);
            rgn := PathToRegion(ACanvas.Handle);
            CombineRgn(ARgn, ARgn, rgn, RGN_OR);
            DeleteObject(rgn);
          end;
        BeginPath(ACanvas.Handle);
        CreatePath;
        EndPath(ACanvas.Handle);
      end;
  end;

  procedure PrepareERect(aRect:TRect; sta:TLMDAngle; tp:TPoint; flag:Byte; ARgnOnly: boolean; var ARgn: HRGN);
  var
    stp, ep:TPoint;
    rgn: HRGN;

    procedure CreatePath;
    begin
      stp := LMDEllipticAngleToPoint(aRect, sta, 0);
      ep := LMDEllipticAngleToPoint(aRect, sta + lNoseAngleWidth, 0);
      ACanvas.MoveTo(tp.X, tp.Y);
      ACanvas.LineTo(ep.X, ep.Y);
      ArcTo(ACanvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom, ep.X, ep.Y, stp.X, stp.Y);
      ACanvas.LineTo(tp.X, tp.Y);
    end;

  begin
    Inc(ARect.Top);
    Inc(ARect.Bottom);
    if ARgnOnly then
      begin
        ARgn := CreateEllipticRgnIndirect(ARect);
        if flag=0 then
          exit;
        stp := LMDEllipticAngleToPoint(aRect, sta, 3);
        ep := LMDEllipticAngleToPoint(aRect, sta + lNoseAngleWidth, 3);
        rgn := CreatePolyRgn([stp, tp, ep]);
        CombineRgn(ARgn, rgn, ARgn, RGN_OR);
        DeleteObject(rgn);
      end
    else
      begin
        if ARgn = 0 then
          begin
            BeginPath(ACanvas.Handle);
            CreatePath;
            EndPath(ACanvas.Handle);
            ARgn := PathToRegion(ACanvas.Handle);

            BeginPath(ACanvas.Handle);
            CreatePath;
            EndPath(ACanvas.Handle);
            WidenPath(ACanvas.Handle);
            rgn := PathToRegion(ACanvas.Handle);
            CombineRgn(ARgn, ARgn, rgn, RGN_OR);
            DeleteObject(rgn);
           end;
          BeginPath(ACanvas.Handle);
          CreatePath;
          EndPath(ACanvas.Handle);
       end;
     end;

  procedure AdjustTextRect(aShapeRect: TRect);
  begin
    OffsetRect(txRect,
                (aShapeRect.Right + aShapeRect.Left - txRect.Right - txRect.Left) div 2,
                (aShapeRect.Top + aShapeREct.Bottom - txRect.Top - txRect.Bottom) div 2 + 3);
  end;

  procedure PrepareShadow;
  var
    epx: integer;
  begin
    case lStyle of
      hsRect:
         PrepareRect(Rect(ShadowDepth, ShadowDepth, Width, Height - 1), 0, true, LRgnS);
      hsRoundRect:
         PrepareRect(Rect(ShadowDepth, ShadowDepth, Width, Height - 1), 0, true, LRgnS);
      hsEllipse:
         PrepareEllipse(Rect(ShadowDepth, ShadowDepth, Width, Height), true, LRgnS);
      hsNoseEllipse:
        begin
          case aHintPosition of
            hpAboveRight:
               PrepareERect(Rect(ShadowDepth + lNoseLength, ShadowDepth, Width, Height - lNoseLength),
                          225, Point(0,Height), 1, true, LRgnS);
             hpAboveLeft:
               PrepareERect(Rect(ShadowDepth, ShadowDepth, Width - lNoseLength, Height - lNoseLength),
                            305, Point(Width,Height), 1, true, LRgnS);
            hpBelowLeft:
               PrepareERect(Rect(ShadowDepth, lNoseLength + ShadowDepth, Width - lNoseLength, Height - 1),
                            45, Point(Width, ShadowDepth), 1, true, LRgnS);
            hpBelowRight:
               PrepareERect(Rect(ShadowDepth + lNoseLength, ShadowDepth + lNoseLength, Width, Height - 1),
                            125, Point(ShadowDepth, ShadowDepth), 0, true, LRgnS);
          end;
        end;
      hsNoseRoundRect, hsNoseRect:
        begin
          case aHintPosition of
            hpAboveRight:
              begin
                if hoRightAngledNose in lOpt then
                  epx := ShadowDepth + lNoseLength + NoseDelta
                else
                  epx := 0;
                PrepareMRect(Rect(ShadowDepth + lNoseLength, ShadowDepth, Width, Height - lNoseLength),
                              Point(ShadowDepth + lNoseLength + NoseDelta, Height - lNoseLength - 2),
                              Point(epx, Height - 1), 1, true, LRgnS);
              end;
            hpAboveLeft:
              begin
                if hoRightAngledNose in lOpt then
                  epx :=  Width - lNoseLength - NoseDelta + 1
                else
                  epx := Width - ShadowDepth;
                PrepareMRect(Rect(ShadowDepth, ShadowDepth, Width - lNoseLength, Height - lNoseLength),
                            Point(Width - lNoseLength - NoseDelta - lNoseWidth, Height - lNoseLength - 2),
                            Point(epx, Height - 1), 1, true, LRgnS);
              end;
            hpBelowLeft:
              begin
                if hoRightAngledNose in lOpt then
                  epx := Width - lNoseLength - NoseDelta - lNoseWidth
                else
                  epx := Width;
                PrepareMRect(Rect(ShadowDepth, lNoseLength + ShadowDepth, Width - lNoseLength, Height - 1),
                            Point(Width - lNoseLength - NoseDelta - lNoseWidth, lNoseLength + ShadowDepth),
                            Point(epx, ShadowDepth), 1, true, LRgnS);
              end;
            hpBelowRight:
              PrepareMRect(Rect(ShadowDepth + lNoseLength, ShadowDepth + lNoseLength, Width, Height - 1),
                            Point(lNoseLength + NoseDelta + ShadowDepth + lNoseWidth, lNoseLength + ShadowDepth), Point(ShadowDepth, ShadowDepth), 0, true, LRgnS);
          end;
        end;
    end;
  end;

  function PrepareShape(aRgnOnly: boolean): TRect;
  var
    epx: integer;
  begin
    begin
      case lStyle of
        hsRect, hsRoundRect:
          begin
            Result := Rect(1, 0, Width - ShadowDepth, Height - ShadowDepth);
            PrepareRect(Result, 1, aRgnOnly, LRgn);
          end;
        hsEllipse:
          begin
            Result := Rect(0, 0, Width - ShadowDepth, Height - ShadowDepth);
            PrepareEllipse(Result, aRgnOnly, LRgn);
          end;
        hsNoseEllipse:
          begin
            case aHintPosition of
              hpAboveRight:
                begin
                  Result := Rect(lNoseLength, 0, Width - ShadowDepth, Height - ShadowDepth - lNoseLength);
                  PrepareERect(Result, 225, Point(0,Height - ShadowDepth), 2, aRgnOnly, LRgn);
                end;
              hpAboveLeft:
                begin
                  Result := Rect(0, 0, Width - ShadowDepth - lNoseLength, Height-ShadowDepth - lNoseLength);
                  PrepareERect(Result, 305, Point(Width - ShadowDepth ,Height - ShadowDepth), 2, aRgnOnly, LRgn);
                end;
              hpBelowLeft:
                begin
                  Result := Rect(0, lNoseLength, Width - ShadowDepth - lNoseLength, Height - ShadowDepth - 1);
                  PrepareERect(Result, 45, Point(Width, 0), 2, aRgnOnly, LRgn);
                end;
              hpBelowRight:
                begin
                  Result := Rect(lNoseLength, lNoseLength, Width - ShadowDepth, Height - ShadowDepth - 1);
                  PrepareERect(Result, 125, Point(0, 0), 2, aRgnOnly, LRgn);
                end;
            end;
          end;
        hsNoseRoundRect, hsNoseRect:
          begin
            case aHintPosition of
              hpAboveRight:
                begin
                  if hoRightAngledNose in lOpt then
                    epx := lNoseLength + NoseDelta
                  else
                    epx := 0;
                  Result := Rect(lNoseLength, 0, Width - ShadowDepth, Height - ShadowDepth - lNoseLength);
                  PrepareMRect(Result ,
                            Point(lNoseLength + NoseDelta, Height - lNoseLength {- 1} - ShadowDepth) ,
                            Point(epx, Height - ShadowDepth {- 1}), 2, aRgnOnly, LRgn);
                end;
              hpAboveLeft:
                begin
                  if hoRightAngledNose in lOpt then
                    epx := Width - lNoseLength - ShadowDepth - NoseDelta + 1
                  else
                    epx := Width - ShadowDepth;
                  Result := Rect(1, 0, Width - ShadowDepth - lNoseLength, Height - ShadowDepth - lNoseLength);
                  PrepareMRect(Result,
                            Point(Width - lNoseLength - ShadowDepth - NoseDelta - lNoseWidth, Height - ShadowDepth - lNoseLength {- 1}),
                            Point(epx, Height - ShadowDepth {- 1}), 2, aRgnOnly, LRgn);
                end;
              hpBelowLeft:
                begin
                  if hoRightAngledNose in lOpt then
                    epx := Width - lNoseLength - ShadowDepth - NoseDelta - lNoseWidth
                  else
                    epx := Width;
                  Result := Rect(1, lNoseLength, Width - ShadowDepth - lNoseLength, Height - ShadowDepth);
                  PrepareMRect(Result,
                            Point(Width - lNoseLength - ShadowDepth - NoseDelta - lNoseWidth, lNoseLength + 1),
                            Point(epx, 1), 2, aRgnOnly, LRgn);
                end;
              hpBelowRight:
                begin
                  if hoRightAngledNose in lOpt then
                    epx := lNoseLength + NoseDelta - lNoseWidth
                  else
                    epx := 0;
                  Result := Rect(lNoseLength, lNoseLength, Width - ShadowDepth, Height - ShadowDepth);
                  PrepareMRect(Result,
                            Point(lNoseLength + NoseDelta, lNoseLength + 1), Point(epx, 0), 2, aRgnOnly, LRgn);
                end;
            end;
          end;
      end;
    end;
  end;

begin
  LRgn := 0;     //hint region
  LRgnS := 0;    //shadow region

  lOpt := HintControl.Options;
  lShadow := HintControl.Shadow;
  lStyle := HintControl.Style;
  lNoseLength := HintControl.NoseLength;
  lNoseWidth := HintControl.NoseWidth;
  lRoundRectWidth := HintControl.RoundRectWidth;
  lUseGradient := HintControl.UseGradient;
  lNoseAngleWidth := HintControl.NoseAngleWidth;
  lIsThemed := HintControl.IsThemed;

  try
    if (lShadow.Style <> hssNone) and not UseSystemShadow then
      PrepareShadow;

    lShapeRect := PrepareShape(not LMDSIWindowsNTUp);
    AdjustTextRect(lShapeRect);

    LWRgn := CreateRectRgn(0, 0, 1, 1);

    if LRgnS <> 0 then
      begin
        CombineRgn(LWRgn, LRgn, LRgnS, RGN_OR);
        CombineRgn(LRgns, LRgns, LRgn, RGN_DIFF);
      end
    else
      CombineRgn(LWRgn, LRgn, LRgn, RGN_OR);

    //SetWindowRgn(Self.Handle, LRgn, false);

    GetRgnBox(LWRgn, wRect);

    PaintBgr(aCanvas, wRect);

    SetWindowRgn(Self.Handle, LWRgn, true);

    // Drawing
    SetWindowPos(Handle, HWND_TOPMOST, pos.X, pos.Y, 0,
               0,  SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOSIZE);

    if LRgnS <> 0 then
      begin
        PrepareMaskDraw;
        PaintRgn(aCanvas.Handle, LRgnS);
      end;

    PrepareNormalDraw;

    if LMDSIWindowsNTUp then
      begin
        PrepareShape(false);
        if not lIsThemed and not lUseGradient then
          StrokeAndFillPath(aCanvas.Handle)
        else
          StrokePath(aCanvas.Handle);
      end
    else
      begin
        PaintRgn(aCanvas.Handle, LRgn);
        aCanvas.Brush.Color := HintControl.BorderColor;
        FrameRgn(aCanvas.Handle, LRgn, aCanvas.Brush.handle, 1, 1);
        aCanvas.Brush.Color := HintControl.Color;
      end;

  finally
    DeleteObject(LRgn);
    if LRgnS <> 0 then
      DeleteObject(LRgnS);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.CreateWnd;
begin
  PreCreateWnd;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShapeHintWindow.PreCreateWnd;
begin
  if not IsCustom and (HintControl <> nil) then
    Color := HintControl.Color;
end;

end.

