unit ElBiProgr;
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

ElBiProgr unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Graphics, Controls, Forms, Math, ExtCtrls,
  Types, Classes, SysUtils, TypInfo,
  UxTheme, Themes,
  ElStyleMan, ElImgFrm, ElVCLUtils, ElXPThemedControl,
  LMDUtils, LMDGraphUtils, LMDTypes, LMDProcs, LMDThemes;

type
  TProgrShowMode = (psmAllFull, psmLightHalf, psmDarkHalf, psmAllHalf);
  TElBevelStyle = (ebsNone, ebsLowered, ebsRaised);
  TElProgrOrientation = (poHorizontal, poVertical);

type

  TElBiProgressBar = class(TElXPThemedControl)
  private
    FMinValue: Integer;
    FOrientation: TElProgrOrientation;
    FSmooth: boolean;
    FScale: integer;
    FAdditive: boolean;
    FProgrShowMode: TProgrShowMode;
    FLightTextFullLine: Boolean;
    FDarkTextFullLine: Boolean;
    FLightButtonStyle: Boolean;
    FDarkButtonStyle: Boolean;
    FBevelStyle: TElBevelStyle;
    FDarkText: TLMDString;
    FLightText: TLMDString;
    FDarkTextColor: TColor;
    FLightTextColor: TColor;
    FLightColor: TColor;
    FDarkColor: TColor;
    FLightValue: integer;
    FDarkValue: integer;
    FImgFormChLink: TImgFormChangeLink;
    FImgForm: TElImageForm;

    FCaption: TLMDString;
    FBitmap: TBitmap;
    FInfiniteMode: boolean;

    FMarquee: Boolean;
    FMarqueeSize: Integer;
    FMarqueeUpdateInterval: Integer;
    FMarqueeTimer: TTimer;
    FMarqueeValue: Integer;
    FMarqueeColor: TColor;
    FMarqueeDirection: Boolean;

    procedure SetMarquee(Value: Boolean);
    procedure SetMarqueeSize(Value: Integer);
    procedure SetMarqueeUpdateInterval(Value: Integer);
    procedure OnMarqueeTimer(Sender : TObject);

    procedure SetImageForm(NewValue: TElImageForm); virtual;
    procedure ImageFormChange(Sender : TObject);
    procedure SetMarqueeColor(aValue: TColor);
    procedure SetLightColor(aValue: TColor);
    procedure SetDarkColor(aValue: TColor);
    procedure SetScale(aValue: integer);
    procedure SetLightValue(aValue: integer);
    procedure SetDarkValue(aValue: integer);
    procedure SetAdditive(aValue: boolean);
    procedure SetProgrShowMode(aValue: TProgrShowMode);
    procedure SetDarkText(NewValue: TLMDString);
    procedure SetLightText(NewValue: TLMDString);
    procedure SetCaption(NewValue: TLMDString);
    procedure SetDarkTextColor(NewValue: TColor);
    procedure SetLightTextColor(NewValue: TColor);
    procedure SetBevelStyle(NewValue: TElBevelStyle);
    procedure SetMinValue(NewValue: Integer);
    procedure SetLightButtonStyle(NewValue: Boolean);
    procedure SetDarkButtonStyle(NewValue: Boolean);
    procedure SetLightTextFullLine(NewValue: boolean);
    procedure SetDarkTextFullLine(NewValue: boolean);
    procedure SetDarkGradient(Value: Boolean);
    procedure SetDarkGradientSteps(Value: Integer);
    procedure SetLightGradient(Value: Boolean);
    procedure SetLightGradientSteps(Value: Integer);
    procedure SetOrientation(NewValue: TElProgrOrientation);
    procedure SetSmooth(NewValue: boolean);
  protected
{$IFDEF LMD_UNICODE}
    FHint: TLMDString;
{$ENDIF}
    FTransparent: Boolean;
    FDarkGradient: Boolean;
    FDarkGradientSteps: Integer;
    FLightGradient: Boolean;
    FLightGradientSteps: Integer;
    procedure Paint; override;
    {$IFDEF LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    {$ENDIF}
    function GetThemedElement: TThemedElement; override;

    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadBorderStyle(Reader: TReader);

    procedure SetTransparent(NewValue: Boolean);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc(var Message : TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetValues(ALightValue, ADarkValue, AScale: integer; AAdditive:
      boolean);
  published
    property Marquee: Boolean read FMarquee write SetMarquee default False;
    property MarqueeSize: Integer read FMarqueeSize write SetMarqueeSize default 20;
    property MarqueeUpdateInterval: Integer read FMarqueeUpdateInterval write SetMarqueeUpdateInterval default 25;
    property MarqueeColor: TColor read FMarqueeColor write SetMarqueeColor default clMaroon;
    property LightColor: TColor read FLightColor write SetLightColor default clRed;
    property DarkColor: TColor read FDarkColor write SetDarkColor default clMaroon;
    property Scale: integer read FScale write SetScale default 100;
    property LightValue: integer read FLightValue write SetLightValue default 0;
    property DarkValue: integer read FDarkValue write SetDarkValue default 0;
    property Additive: boolean read FAdditive write SetAdditive default False;
    property Caption: TLMDString read FCaption write SetCaption;
    property ProgressShowMode: TProgrShowMode read FProgrShowMode write SetProgrShowMode
      default psmAllFull;
    property LightTextFullLine: Boolean read FLightTextFullLine write SetLightTextFullLine default False;
    property DarkTextFullLine: Boolean read FDarkTextFullLine write SetDarkTextFullLine default False;
    property DarkText: TLMDString read FDarkText write SetDarkText;
    property LightText: TLMDString read FLightText write SetLightText;
    property DarkTextColor: TColor read FDarkTextColor write SetDarkTextColor default clBtnText;
    property LightTextColor: TColor read FLightTextColor write SetLightTextColor default clBtnText;
    property BevelStyle: TElBevelStyle read FBevelStyle write SetBevelStyle default ebsNone;
    property MinValue: Integer read FMinValue write SetMinValue default 0;
    property LightButtonStyle: Boolean read FLightButtonStyle write SetLightButtonStyle default False;
    property DarkButtonStyle: Boolean read FDarkButtonStyle write SetDarkButtonStyle default False;
    property Orientation: TElProgrOrientation read FOrientation write SetOrientation
      default poHorizontal;
    property Smooth: boolean read FSmooth write SetSmooth default False;
    property InfiniteMode: boolean read FInfiniteMode write FInfiniteMode default False;
    property DarkGradient: Boolean read FDarkGradient write SetDarkGradient default
        false;
    property DarkGradientSteps: Integer read FDarkGradientSteps write
        SetDarkGradientSteps default 64;
    property LightGradient: Boolean read FLightGradient write SetLightGradient
        default false;
    property LightGradientSteps: Integer read FLightGradientSteps write
        SetLightGradientSteps default 64;
    {$IFDEF LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
{$ENDIF}
    property ImageForm: TElImageForm read FImgForm write SetImageForm;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;
    property Align;
    property Color default clWindow;

    property DragCursor;

    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default False;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    property Anchors;
    property Constraints;

    property DockOrientation;
    property Floating;
    property DragKind;
    property DoubleBuffered;

  end;

implementation

uses  LMDClass, LMDGraph;

//uses ElTools;

{TELBiProgressBar}

//---------------------------------------------------------------
//                        create/destroy
//---------------------------------------------------------------

constructor TELBiProgressBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // win control style:
  ControlStyle := ControlStyle + [csOpaque];
  // color:
  ParentColor := False;
  FLightColor := clRed;
  FDarkColor := clMaroon;
  Color := clWindow;
  // size:
  Width := 100;
  Height := 21;
  // other data:
  FBitmap := TBitmap.Create;
  // other properties:
  FMinValue := 0;
  FOrientation := poHorizontal;
  FSmooth := False;
  FProgrShowMode := psmAllFull;
  Scale := 100;

  FDarkTextColor := clBtnText;
  FLightTextColor := clBtnText;

  FDarkGradientSteps := 64;
  FLightGradientSteps := 64;
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  if not (csDesigning in ComponentState) then
    StyleManager := DefaultStyleManager;
  FMarquee := False;
  FMarqueeUpdateInterval := 25;
  FMarqueeSize := 20;
  FMarqueeColor := clMaroon;
end;

procedure TElBiProgressBar.WndProc(var Message: TMessage);
begin
  inherited;
  if (TLMDPtrUInt(Message.Msg) = ParentControlRepaintedMessage) and Transparent and
     (Message.lParam <> TLMDPtrInt(Self)) then
  begin
      Invalidate;
  end;
end;

destructor TELBiProgressBar.Destroy;
begin
  if Assigned(FMarqueeTimer) then
  begin
    FMarqueeTimer.Enabled := False;
    FreeAndNil(FMarqueeTimer);
  end;
  FreeAndNil(FBitmap);
  FreeAndNil(FImgFormChLink);
  inherited Destroy;
end;

procedure TELBiProgressBar.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TELBiProgressBar.SetImageForm(NewValue: TElImageForm);
{ Sets data member FImageForm to NewValue. }
begin
  if FImgForm <> NewValue then
  begin
    if FImgForm <> nil then
    begin
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    FImgForm := NewValue;
    if FImgForm <> nil then
    begin
      FImgForm.RegisterChanges(FImgFormChLink);
      FImgForm.FreeNotification(Self);
    end;
    Invalidate;
  end;
end; { SetImageForm }

function TELBiProgressBar.GetThemedElement: TThemedElement;
begin
  Result := teProgress;
end;

//---------------------------------------------------------------
//                     get/set properties
//---------------------------------------------------------------

procedure TELBiProgressBar.SetCaption(NewValue: TLMDString);
{ Sets data member FDarkText to NewValue. }
begin
  if (FCaption <> NewValue) then
  begin
    FCaption := NewValue;
    Invalidate;
  end; { if }
end; { SetCaption }

procedure TELBiProgressBar.SetDarkText(NewValue: TLMDString);
{ Sets data member FDarkText to NewValue. }
begin
  if (FDarkText <> NewValue) then
  begin
    FDarkText := NewValue;
    Invalidate;
  end; { if }
end; { SetDarkText }

procedure TELBiProgressBar.SetLightText(NewValue: TLMDString);
{ Sets data member FLightText to NewValue. }
begin
  if (FLightText <> NewValue) then
  begin
    FLightText := NewValue;
    Invalidate;
  end; { if }
end; { SetLightText }

procedure TELBiProgressBar.SetDarkTextColor(NewValue: TColor);
{ Sets data member FDarkTextColor to NewValue. }
begin
  if (FDarkTextColor <> NewValue) then
  begin
    FDarkTextColor := NewValue;
    Invalidate;
  end; { if }
end; { SetDarkTextColor }

procedure TELBiProgressBar.SetLightTextColor(NewValue: TColor);
{ Sets data member FLightTextColor to NewValue. }
begin
  if (FLightTextColor <> NewValue) then
  begin
    FLightTextColor := NewValue;
    Invalidate;
  end; { if }
end; { SetLightTextColor }

procedure TELBiProgressBar.SetBevelStyle(NewValue: TElBevelStyle);
{ Sets data member FBevelStyle to NewValue. }
begin
  if (FBevelStyle <> NewValue) then
  begin
    FBevelStyle := NewValue;
    Invalidate;
  end; { if }
end; { SetBevelStyle }

procedure TELBiProgressBar.SetLightColor(aValue: TColor);
begin
  if FLightColor = aValue then Exit;
  FLightColor := aValue;
  Invalidate;
end;

procedure TELBiProgressBar.SetDarkColor(aValue: TColor);
begin
  if FDarkColor = aValue then Exit;
  FDarkColor := aValue;
  Invalidate;
end;

procedure TELBiProgressBar.SetScale(aValue: integer);
begin
  if FScale = aValue then Exit;
  FScale := aValue;
  Invalidate;
end;

procedure TELBiProgressBar.SetLightValue(aValue: integer);
begin
  if FLightValue = aValue then Exit;
  FLightValue := aValue;
  Invalidate;
end;

procedure TELBiProgressBar.SetDarkValue(aValue: integer);
begin
  if FDarkValue = aValue then Exit;
  FDarkValue := aValue;
  Invalidate;
end;

procedure TELBiProgressBar.SetAdditive(aValue: boolean);
begin
  if FAdditive = aValue then Exit;
  FAdditive := aValue;
  Invalidate;
end;

procedure TELBiProgressBar.SetValues(ALightValue, ADarkValue, AScale: integer;
  AAdditive: boolean);
begin
  FScale := AScale;
  FLightValue := ALightValue;
  FDarkValue := ADarkValue;
  FAdditive := AAdditive;
  Invalidate;
end;

procedure TELBiProgressBar.SetProgrShowMode(aValue: TProgrShowMode);
begin
  if FProgrShowMode <> aValue then
  begin
    FProgrShowMode := aValue;
    Invalidate;
  end;
end;

procedure TELBiProgressBar.SetLightTextFullLine(NewValue: boolean);
begin
  if FLightTextFullLine <> NewValue then
  begin
    FLightTextFullLine := NewValue;
    Invalidate;
  end;
end;

procedure TELBiProgressBar.SetDarkTextFullLine(NewValue: boolean);
begin
  if FDarkTextFullLine <> NewValue then
  begin
    FDarkTextFullLine := NewValue;
    Invalidate;
  end;
end;

procedure TELBiProgressBar.Paint;
const
  dx = 8;
  ox = 2;
var
  R: TRect;
  IntRect : TRect;
  PartRect: TRect;

  MSize: integer;
  DarkSize: integer;
  LightSize: integer;

  DarkRect: TRect;
  LightRect: TRect;
  ps: TSize;
  wd: integer;
  rd: boolean;
  MyRgn: HRGN;

  procedure FillPBRect(const R: TRect; Gradient : boolean; GradientSteps : integer; ReverseDir : boolean = false);
  var
    r1 : trect;
    SC,
    EC : TColor;
  begin
    with FBitmap.Canvas do
    if Smooth then
      begin
        if Gradient then
        begin
          if (not ReverseDir) xor (Orientation = poVertical) then
          begin
            EC := Brush.Color;
            SC := Color;
          end
          else
          begin
            SC := Brush.Color;
            EC := Color;
          end;
          if FOrientation = poVertical then
            LMDGradientPaint(Handle, R, SC, EC, GradientSteps, gstVertical, 0, 0)
          else
            LMDGradientPaint(Handle, R, SC, EC, GradientSteps, gstHorizontal, 0, 0);
        end
        else
          FillRect(R)
      end
      else
      begin
        r1 := r;
        if FOrientation = poVertical then
          repeat
            r1.top := max(r1.bottom - dx, r.top);
            FillRect(r1);
            r1.bottom := r1.top - ox;
          until r1.top <= r.top
        else
          while r1.left < R.Right do
          begin
            r1.Right := min(r1.Left + dx, R.Right);
            FillRect(r1);
            r1.left := r1.right + ox;
          end;
      end;
  end;

var
  OldP, P: TPoint;
  BgRect,
  R1    : TRect;
  ACtl  : TWinControl;
  ax, ay: integer;
  pid: Integer;
  Details: TThemedProgress;
  LThemeMode: TLMDThemeMode;
begin
  rd := false;

  FBitmap.Width := ClientWidth;
  FBitmap.Height := ClientHeight;

  FBitmap.Handle := CreateCompatibleBitmap(Canvas.Handle, ClientWidth, ClientHeight);

  R := ClientRect;
  IntRect := ClientRect;

  Details := tpChunk;
  pid := PP_CHUNK;
  LThemeMode := UseThemeMode;

  if LThemeMode <> ttmNone then
  begin
    if (GetWindowTheme(Parent.Handle) <> 0) then
    begin
      // copy parent's background
      P := Point(Left, Top);
      SetMapMode(Self.Canvas.Handle, MM_ANISOTROPIC);
      SetViewPortOrgEx(Self.Canvas.Handle, -P.x, -P.y, @OldP);
      SendMessage(Parent.Handle, WM_ERASEBKGND, Self.Canvas.Handle, Self.Canvas.Handle);
      SetViewPortOrgEx(Self.Canvas.Handle, OldP.x, OldP.y, nil);
      SetMapMode(Self.Canvas.Handle, MM_TEXT);
      bitblt(FBitmap.Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom -
        R.Top, Self.Canvas.Handle, R.Left, R.Top, SRCCOPY);
    end;

    LMDThemeServices.DrawElement(LThemeMode, FBitmap.Canvas.Handle, tpBar, R);
    R := LMDThemeServices.ContentRect(LThemeMode, FBitmap.Canvas.Handle, ThemeServices.GetElementDetails(tpBar), R);

    IntRect := R;
    if FOrientation = poVertical then
    begin
      Details := tpChunkVert;
      pid := PP_CHUNKVERT;
    end;

  end
  else

  if not Transparent then
  begin
    if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
    begin
      if FImgForm.Control <> Self then
      begin
        ACtl := FImgForm.GetRealControl;
        BgRect := ClientRect;
        R1 := BgRect;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        P := Parent.ClientToScreen(Point(Left, Top));
        ax := BgRect.Left - P.x;
        ay := BgRect.Top - P.y;

        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

        FImgForm.PaintBkgnd(FBitmap.Canvas.Handle, R1, Point(BgRect.Left - ax, BgRect.Top - ay), False);
      end;
    end
    else
    begin
      with FBitmap.Canvas do
      begin
        Brush.Color := Self.Color;
        Brush.Style := bsSolid;
        FillRect(R);
      end;
    end;
  end
  else { if Transparent }
  if Transparent then
  begin

    GetClipBox(Canvas.Handle, R);
    OffsetRect(R, Left, Top);
    if Assigned(parent) then
    RedrawWindow(Parent.Handle, @R, 0, RDW_ERASE or RDW_INVALIDATE or
      RDW_NOCHILDREN or RDW_UPDATENOW);
    OffsetRect(R, -Left, -Top);
    BitBlt(FBitmap.Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
      Self.Canvas.Handle, R.Left, R.Top, SRCCOPY);

  end;

  with FBitmap.Canvas do
  begin
    // paint background:
    if FBevelStyle <> ebsNone then
    begin
      Pen.Width := 1;
      // paint bevel rect:
      PartRect := Rect(0, 0, Width - 1, Height - 1);
      with FBitmap.Canvas, PartRect do
      begin
        // calculate color left - top:
        if FBevelStyle = ebsLowered then
          Pen.Color := clBtnShadow
        else
          Pen.Color := clBtnHighlight;
        // bevel left - top:
        PolyLine([
          Point(Left, Bottom),
          Point(Left, Top),
          Point(Right, Top)
        ]);
        // calculate color right - bottom:
        if FBevelStyle = ebsLowered then
          Pen.Color := clBtnHighlight
        else
          Pen.Color := clBtnShadow;
        // bevel right - bottom:
        PolyLine([
          Point(Right, Top),
          Point(Right, Bottom),
          Point(Left, Bottom)
        ]);
      end;
      // skip bevel:
      InflateRect(IntRect, -1, -1);
      InflateRect(R, -1, -1);
    end;
    if FScale > 0 then
    try
    // paint of dark part:
      PartRect := IntRect;
      if FMarquee then
      begin
        if FOrientation = poHorizontal then
        begin
          wd := R.Right - R.Left;
          MSize := Max(MulDiv(FMarqueeValue, wd, Scale), 0);
          if IsThemed then
          begin
            LMDThemeServices.GetThemePartSize(LThemeMode, Handle, teProgress, pid, 0, ps);
            if ps.cx <= 0 then ps.cx := 1;
          end
          else
            if FSmooth then ps.cx := 1 else ps.cx := dx+ox;
          R.Right := R.Left + MSize;
          MSize := Max(MulDiv(FMarqueeSize, Width, 100), 0);
          MyRgn := CreateRectRgn(max(0, R.Right - MSize), R.Top, R.Right, R.Bottom);
          SelectClipRgn(FBitmap.Canvas.Handle, MyRgn);
    //          R.Left := max(0, R.Right - MSize);
        end
        else
        begin
          wd := R.Bottom - R.Top;
          MSize := Max(MulDiv(FMarqueeValue, wd, Scale), 0);
          if IsThemed then
          begin
            LMDThemeServices.GetThemePartSize(LThemeMode, Handle, teProgress, pid, 0, ps);

            if ps.cy <= 0 then ps.cy := 0;
          end
          else
            if FSmooth then ps.cy := 1 else ps.cy := dx+ox;
          R.Top := R.Bottom - MSize;
          MSize := Max(MulDiv(FMarqueeSize, Height, 100), 0);
          MyRgn := CreateRectRgn(R.Left, R.Top, R.Right, min(R.Bottom, R.Top + MSize));
          SelectClipRgn(FBitmap.Canvas.Handle, MyRgn);
        end;
        Brush.Color := FMarqueeColor;
        if IsThemed then
        begin
          if FMarqueeValue > 0 then
            LMDThemeServices.DrawElement(LThemeMode, Handle, Details, R);
//            DrawThemeBackground(Theme, Handle, pid, 0, R, nil);
        end
        else
        begin
          if FMarqueeValue > 0 then
            FillPBRect(R, False, 0, False);
        end;
//        SelectClipRgn(FBitmap.Canvas.Handle, nil);
        DeleteObject(MyRgn);
      end
      else
      begin
        if FOrientation = poHorizontal then
        begin
          wd := Max(1, R.Right - R.Left);
          DarkSize := Max(MulDiv(DarkValue - MinValue, wd, Scale - MinValue), 0);

          if IsThemed then
          begin
            LMDThemeServices.GetThemePartSize(LThemeMode, Handle, teProgress, pid, 0, ps);

            if ps.cx <= 0 then ps.cx := 1;
          end
          else
            if FSmooth then ps.cx := 1 else ps.cx := dx+ox;

          LightSize := DarkSize mod wd;
          if not FDarkButtonStyle then
            LightSize := (LightSize div ps.cx) * ps.cx;

          with R do
            if FInfiniteMode then
            begin
              if ((DarkSize div wd) mod 2 = 1) then
              begin
                rd := true;
                Left := Left + wd - LightSize
              end
              else
                Right := Left + LightSize;
            end
            else
              Right := Left + DarkSize;
        end
        else
        begin
          wd := R.Bottom - R.Top;
          DarkSize := Max(MulDiv(DarkValue - MinValue, wd, Scale - MinValue), 0);

          if IsThemed and not FLightButtonStyle then
          begin
            LMDThemeServices.GetThemePartSize(LThemeMode, Handle ,teProgress, pid, 0, ps);

            if ps.cy <= 0 then ps.cy := 0;
          end
          else

            if FSmooth then ps.cy := 1 else ps.cy := dx+ox;

          LightSize := DarkSize mod wd;
          if not FDarkButtonStyle then
            LightSize := (LightSize div ps.cy) * ps.cy;

          with R do
            if FInfiniteMode then
            begin
              if ((DarkSize div wd) mod 2 = 1) then
              begin
                rd := true;
                Bottom := Bottom - (wd - LightSize)
              end
              else
                Top := Bottom - LightSize;
            end
            else
              Top := Bottom - DarkSize;
        end;

        Brush.Color := FDarkColor;
        if FProgrShowMode in [psmDarkHalf, psmAllHalf] then
        begin
          if FOrientation = poHorizontal then
            R.Top := (R.Bottom - R.Top) div 2 + IntRect.Top
          else
            R.Right := (R.Right - R.Left) div 2 + IntRect.Left;
        end;

        if IsThemed then
        begin
          if FDarkValue > 0 then
            if FDarkButtonStyle then
              LMDThemeServices.DrawElement(LThemeMode, Handle, tbPushButtonNormal, R)
//              DrawThemeBackground(LMDThemeService.Theme[tiButton], Handle, BP_PUSHBUTTON, 0, R, nil)
            else
            begin
              LMDThemeServices.DrawElement(LThemeMode, Handle, Details, R);
//              DrawThemeBackground(Theme, Handle, pid, 0, R, nil);
              if FOrientation = poVertical then
                StretchBlt(handle, r.Left, r.top, r.Right - R.Left, r.bottom -
                  r.top, handle, r.left, r.bottom, r.Right - r.left, r.Top - r.Bottom,
                  SRCCOPY);
            end;
        end
        else
        begin
          if FDarkButtonStyle then
          begin
            if FDarkValue > 0 then
            begin
              DrawFrameControl(Handle, R, DFC_BUTTON, DFCS_BUTTONPUSH);
            end;
          end
          else
            if FDarkValue > 0 then
              FillPBRect(R, DarkGradient, DarkGradientSteps, rd);
        end;

        DarkRect := R;
        //paint of light part:
        rd := false;
        R := IntRect;
//        if FBevelStyle <> ebsNone then
//          InflateRect(R, -1, -1);
        if FProgrShowMode in [psmLightHalf, psmAllHalf] then
          if FOrientation = poHorizontal then
            R.Bottom := (R.Bottom - R.Top) div 2 + IntRect.Top
          else
            R.Left := (R.Right - R.Left) div 2 + IntRect.Left;

        PartRect := R;
        if FOrientation = poHorizontal then
        begin
          LightSize := MulDiv(LightValue - MinValue, wd, Scale - MinValue);
          DarkSize := LightSize mod wd;
          if not FLightButtonStyle then
            DarkSize := (DarkSize div ps.cx) * ps.cx;

          with R do
            if InfiniteMode then
            begin
              if ((LightSize div wd) mod 2 = 1) then
              begin
                rd := true;
                Left := Left + wd - DarkSize
              end
              else
                Right := Left + DarkSize;
            end
            else
              Right := Left + LightSize;
        end
        else
        begin
          LightSize := MulDiv(LightValue - MinValue, wd, Scale - MinValue);
          DarkSize := LightSize mod wd;
          if not FLightButtonStyle then
            DarkSize := (DarkSize div ps.cy) * ps.cy;

          with R do
            if FInfiniteMode then
            begin
              if ((LightSize div wd) mod 2 = 1) then
              begin
                rd := true;
                Bottom := Bottom - (wd - DarkSize)
              end
              else
                Top := Bottom - DarkSize;
            end
            else
              Top := Bottom - LightSize;
        end;

        Brush.Color := FLightColor;

        if IsThemed then
        begin
          if FLightValue > 0 then
            if FLightButtonStyle then
              LMDThemeServices.DrawElement(LThemeMode, Handle, tbPushButtonNormal, R)
//              DrawThemeBackground(LMDThemeService.Theme[tiButton], Handle, BP_PUSHBUTTON, 0, R, nil)
            else
            begin
              LMDThemeServices.DrawElement(LThemeMode, Handle, Details, R);
//              DrawThemeBackground(Theme, Handle, pid, 1, R, nil);
              if FOrientation = poVertical then
                StretchBlt(handle, r.Left, r.top, r.Right - R.Left, r.bottom -
                  r.top, handle, r.left, r.bottom, r.Right - r.left, r.Top - r.Bottom,
                  SRCCOPY);
            end;
        end
        else

        begin
          if FLightButtonStyle then
          begin
            if FLightValue > 0 then
              DrawFrameControl(Handle, R, DFC_BUTTON, DFCS_BUTTONPUSH);
            end
          else
            if FLightValue > 0 then
              FillPBRect(R, LightGradient, LightGradientSteps, rd);
        end;

        LightRect := R;
        R.Left := 1;
        R.Right := Width - 1;

        // paint of dark text:

        Font.Assign(Self.Font);
        Font.Color := FDarkTextColor;
        Brush.Color := clNone;
        Brush.Style := bsClear;
        if Length(FDarkText) > 0 then
        begin
          if not FDarkTextFullLine then
            PartRect := DarkRect
          else
          begin
            PartRect := Rect(0, 0, 0, 0);
            LMDDrawText(Handle, FDarkText,
                                 Length(FDarkText),PartRect, DT_CALCRECT);
            with PartRect do
              LMDCenterRects(Right - Left, R.Right - R.Left, Bottom - Top, R.Bottom - R.Top, PartRect);
                OffsetRect(PartRect, 0, R.Top);
          end;
          LMDDrawText(Handle, FDarkText,
                               Length(FDarkText), PartRect, DT_NOPREFIX or DT_CENTER or DT_SINGLELINE or DT_VCENTER);
    end;

      // paint of light text:

        Font.Assign(Self.Font);
        Font.Color := FLightTextColor;
        Brush.Color := clNone;
        Brush.Style := bsClear;
        if Length(FLightText) > 0 then
        begin
          if not FLightTextFullLine then
            PartRect := LightRect
          else
          begin
            PartRect := Rect(0, 0, 0, 0);
            LMDDrawText(Handle, FLightText,
                                 Length(FLightText), PartRect, DT_CALCRECT);
            with PartRect do
              LMDCenterRects(Right - Left, R.Right - R.Left, Bottom - Top, R.Bottom - R.Top, PartRect);
            OffsetRect(PartRect, 0, R.Top);
          end;
          LMDDrawText(Handle, FLightText,
                              Length(FLightText), PartRect, DT_NOPREFIX or DT_CENTER or DT_SINGLELINE or DT_VCENTER);
    end;
      end;
      if FCaption <> '' then
      begin
        Brush.Style := bsClear;
        Font.Assign(Self.Font);
        PartRect := Rect(0, 0, 0, 0);
        R := ClientRect;
        R.Left := 1;
        R.Right := Width - 1;
        LMDDrawText(Handle, Caption, Length(FCaption), PartRect,
          DT_CALCRECT);
  with PartRect do
          LMDCenterRects(Right - Left, R.Right - R.Left, Bottom - Top, R.Bottom - R.Top, PartRect);
        OffsetRect(PartRect, 0, R.Top);
        LMDDrawText(Handle, Caption, Length(FCaption), PartRect,
          DT_NOPREFIX or DT_CENTER or DT_VCENTER);
  end;
    except
    end;
  end;

  with FBitmap do
    BitBlt(Self.Canvas.Handle, 0, 0, Width, Height, FBitmap.Canvas.Handle, 0, 0, SRCCOPY);

end;

procedure TELBiProgressBar.SetMinValue(NewValue: Integer);
begin
  if (FMinValue <> NewValue) then
  begin
    FMinValue := NewValue;
    Invalidate;
  end; {if}
end; {SetMinValue}

procedure TELBiProgressBar.SetLightButtonStyle(NewValue: Boolean);
begin
  if (FLightButtonStyle <> NewValue) then
  begin
    FLightButtonStyle := NewValue;
    Invalidate;
  end; {if}
end; {SetLightButtonStyle}

procedure TELBiProgressBar.SetDarkButtonStyle(NewValue: Boolean);
begin
  if (FDarkButtonStyle <> NewValue) then
  begin
    FDarkButtonStyle := NewValue;
    Invalidate;
  end; {if}
end; {SetDarkButtonStyle}

procedure TElBiProgressBar.SetOrientation(NewValue: TElProgrOrientation);
begin
  if FOrientation <> NewValue then
  begin
    FOrientation := NewValue;
    if not (csLoading in ComponentState) then
      SetBounds(Left, Top, Height, Width);
    Invalidate;
  end;
end;

procedure TElBiProgressBar.SetSmooth(NewValue: boolean);
begin
  if FSmooth <> NewValue then
  begin
    FSmooth := NewValue;
    Invalidate;
  end;
end;

{$IFDEF LMD_UNICODE}
procedure TElBiProgressBar.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

procedure TElBiProgressBar.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF LMD_UNICODE}

procedure TElBiProgressBar.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('Transparent', FakeBoolean, nil, False);
  Filer.DefineProperty('BorderStyle', ReadBorderStyle, nil, False);
end;

procedure TElBiProgressBar.ReadBorderStyle(Reader: TReader);
var
  S: String;
begin
  s := Reader.ReadIdent;
end;

procedure TElBiProgressBar.SetTransparent(NewValue: Boolean);
{ Sets data member FTransparent to NewValue. }
begin
  if (FTransparent <> NewValue) then
  begin
    FTransparent := NewValue;
    if FTransparent then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    if HandleAllocated then
      RecreateWnd;
  end; { if }
end; { SetTransparent }

procedure TElBiProgressBar.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if Transparent then
    Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT
  else
    Params.ExStyle := Params.ExStyle and not WS_EX_TRANSPARENT;
end; { CreateParams }

procedure TElBiProgressBar.SetDarkGradient(Value: Boolean);
begin
  if FDarkGradient <> Value then
  begin
    FDarkGradient := Value;
    if FDarkvalue > 0 then
      Invalidate;
  end;
end;

procedure TElBiProgressBar.SetDarkGradientSteps(Value: Integer);
begin
  if FDarkGradientSteps <> Value then
  begin
    FDarkGradientSteps := Value;
    if FDarkValue > 0 then
      Invalidate;
  end;
end;

procedure TElBiProgressBar.SetLightGradient(Value: Boolean);
begin
  if FLightGradient <> Value then
  begin
    FLightGradient := Value;
    if FLightValue > 0 then
      Invalidate;
  end;
end;

procedure TElBiProgressBar.SetLightGradientSteps(Value: Integer);
begin
  if FLightGradientSteps <> Value then
  begin
    FLightGradientSteps := Value;
    if FLightValue > 0 then
      Invalidate;
  end;
end;

procedure TElBiProgressBar.SetMarquee(Value: Boolean);
begin
  if Value <> FMarquee then
  begin
    FMarquee := Value;
    if Value then
    begin
      if not Assigned(FMarqueeTimer) then
      begin
        FMarqueeTimer := TTimer.Create(nil);
        FMarqueeTimer.Enabled := False;
        FMarqueeTimer.OnTimer := OnMarqueeTimer;
        FMarqueeValue := Max(MulDiv(FMarqueeSize, Scale, 100), 0);
        FMarqueeDirection := True;
      end;
      FMarqueeTimer.Interval := FMarqueeUpdateInterval;
      FMarqueeTimer.Enabled := True;
    end
    else
    begin
      if Assigned(FMarqueeTimer) then
      begin
        FMarqueeTimer.Enabled := False;
        FreeAndNil(FMarqueeTimer);
      end;
    end;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TElBiProgressBar.SetMarqueeSize(Value: Integer);
begin
  if Value <> FMarqueeSize then
  begin
    FMarqueeSize := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TElBiProgressBar.SetMarqueeUpdateInterval(Value: Integer);
begin
  if Value <> FMarqueeUpdateInterval then
  begin
    FMarqueeUpdateInterval := Value;
    if Assigned(FMarqueeTimer) then
      FMarqueeTimer.Interval := FMarqueeUpdateInterval;
  end;
end;

procedure TElBiProgressBar.OnMarqueeTimer(Sender: TObject);
begin
  if csDesigning in ComponentState then
    exit;
  if FMarqueeDirection then
  begin
    FMarqueeValue := FMarqueeValue + 1;
    if FMarqueeValue > FScale then
    begin
      FMarqueeValue := FScale;
      FMarqueeDirection := False;
    end;
  end
  else
  begin
    FMarqueeValue := FMarqueeValue - 1;
    if FMarqueeValue <  MulDiv(FMarqueeSize, Scale, 100) then
    begin
      FMarqueeValue := Max(MulDiv(FMarqueeSize, Scale, 100), 0);
      FMarqueeDirection := True;
    end;
  end;
  if HandleAllocated then
    Invalidate;
end;

procedure TElBiProgressBar.SetMarqueeColor(aValue: TColor);
begin
  if FMarqueeColor <> aValue then
  begin
    FMarqueeColor := aValue;
    if Marquee and HandleAllocated then
      Invalidate;
  end;
end;

end.
