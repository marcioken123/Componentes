unit LMDBiProgressBar;
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

LMDBiProgressBar unit (AH)
--------------------------


Changes
-------
Release 10.0 (August 2009)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Graphics, Controls, Forms, Math, ExtCtrls,
  Types, Classes, SysUtils, TypInfo, UxTheme, Themes, LMDCustomControl,
  LMDFillObject, LMDGraph, LMDUtils, LMDGraphUtils, LMDTypes, LMDProcs,
  LMDThemes, LMD3DCaption, LMDBevel;

type
  TLMDProgressShowMode = (psmAllFull, psmLightHalf, psmDarkHalf, psmAllHalf);

type
  TLMDBiProgressBar = class(TLMDCustomControl)
  private
    FMinValue: Integer;
    FDirection: TLMDMeterDirection;
    FSmooth: boolean;
    FScale: integer;
    FAdditive: boolean;
    FProgressShowMode: TLMDProgressShowMode;
    FLightTextFullLine: Boolean;
    FDarkTextFullLine: Boolean;
    FDarkText: TLMDString;
    FLightText: TLMDString;
    FDarkTextColor: TColor;
    FLightTextColor: TColor;
    FLightColor: TColor;
    FDarkColor: TColor;
    FLightValue: integer;
    FDarkValue: integer;

    FCaption: TLMDString;
    FBitmap: TBitmap;
    FInfiniteMode: boolean;

    FMarquee: Boolean;
    FMarqueeSize: Integer;
    FMarqueeUpdateInterval: Integer;
    FMarqueeTimer: TTimer;
    FMarqueeValue: Integer;
    FMarqueeDirection: Boolean;
    FMarqueeFillObject: TLMDFillObject;
    FDarkFillObject: TLMDFillObject;
    FLightFillObject: TLMDFillObject;
    FDarkBar3D: TLMDBorderStyle;
    FLightBar3D: TLMDBorderStyle;
    FFont3D: TLMD3DCaption;
    FBevel: TLMDBevel;
    FBackFillObject: TLMDFillObject;
    FBrushBackColor: TColor;
    FDarkTextOptions: TLMDMeterTextOptions;
    FLightTextOptions: TLMDMeterTextOptions;
    FLightMargins: TLMDMargins;
    FDarkMargins: TLMDMargins;

    procedure SetMarquee(Value: Boolean);
    procedure SetMarqueeSize(Value: Integer);
    procedure SetMarqueeUpdateInterval(Value: Integer);
    procedure OnMarqueeTimer(Sender : TObject);

    procedure SetScale(aValue: integer);
    procedure SetLightValue(aValue: integer);
    procedure SetDarkValue(aValue: integer);
    procedure SetAdditive(aValue: boolean);
    procedure SetProgressShowMode(aValue: TLMDProgressShowMode);
    procedure SetDarkText(NewValue: TLMDString);
    procedure SetLightText(NewValue: TLMDString);
    procedure SetCaption(NewValue: TLMDString);
    procedure SetDarkTextColor(NewValue: TColor);
    procedure SetLightTextColor(NewValue: TColor);
    procedure SetMinValue(NewValue: Integer);
    procedure SetLightTextFullLine(NewValue: boolean);
    procedure SetDarkTextFullLine(NewValue: boolean);
    procedure SetDirection(NewValue: TLMDMeterDirection);
    procedure SetSmooth(NewValue: boolean);
    procedure SetDarkFillObject(const Value: TLMDFillObject);
    procedure SetLightFillObject(const Value: TLMDFillObject);
    procedure SetDarkBar3D(const Value: TLMDBorderStyle);
    procedure SetLightBar3D(const Value: TLMDBorderStyle);
    procedure SetMarqueeFillObject(const Value: TLMDFillObject);
    function GetDarkFillObject: TLMDFillObject;
    procedure SetFont3D(const Value: TLMD3DCaption);
    function GetMarqueeFillObject: TLMDFillObject;
    procedure SetBevel(const Value: TLMDBevel);
    procedure SetBackFillObject(const Value: TLMDFillObject);
    procedure SetBrushBackColor(const Value: TColor);
    procedure SetDarkTextOptions(const Value: TLMDMeterTextOptions);
    procedure SetLightTextOptions(const Value: TLMDMeterTextOptions);
    procedure SetLightMargins(const Value: TLMDMargins);
    procedure SetDarkMargins(const Value: TLMDMargins);
    procedure RepaintControl(Sender: TObject);
    function GetBackFillObject: TLMDFillObject;
    function GetLightFillObject: TLMDFillObject;
  protected
{$IFDEF LMD_UNICODE}
    FHint: TLMDString;
{$ENDIF}
    FTransparent: Boolean;
    procedure Paint; override;
    {$IFDEF LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    {$ENDIF}
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadBorderStyle(Reader: TReader);

    procedure SetTransparent(NewValue: Boolean);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc(var Message : TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetValues(ALightValue, ADarkValue, AScale: integer; AAdditive: boolean);
  published
    property Marquee: Boolean read FMarquee write SetMarquee default False;
    property MarqueeSize: Integer read FMarqueeSize write SetMarqueeSize default 20;
    property MarqueeUpdateInterval: Integer read FMarqueeUpdateInterval write SetMarqueeUpdateInterval default 25;
    property MarqueeFillObject: TLMDFillObject read GetMarqueeFillObject write SetMarqueeFillObject;
    property Scale: integer read FScale write SetScale default 100;
    property LightValue: integer read FLightValue write SetLightValue default 0;
    property DarkValue: integer read FDarkValue write SetDarkValue default 0;
    property Additive: boolean read FAdditive write SetAdditive default False;
    property Caption: TLMDString read FCaption write SetCaption;
    property ProgressShowMode: TLMDProgressShowMode read FProgressShowMode write SetProgressShowMode default psmAllFull;
    property LightTextFullLine: Boolean read FLightTextFullLine write SetLightTextFullLine default False;
    property DarkTextFullLine: Boolean read FDarkTextFullLine write SetDarkTextFullLine default False;
    property DarkText: TLMDString read FDarkText write SetDarkText;
    property LightText: TLMDString read FLightText write SetLightText;
    property DarkTextColor: TColor read FDarkTextColor write SetDarkTextColor default clBtnText;
    property LightTextColor: TColor read FLightTextColor write SetLightTextColor default clBtnText;
    property MinValue: Integer read FMinValue write SetMinValue default 0;
    property LightBar3D: TLMDBorderStyle read FLightBar3D write SetLightBar3D default lsNone;
    property DarkBar3D: TLMDBorderStyle read FDarkBar3D write SetDarkBar3D default lsNone;
    property Direction: TLMDMeterDirection read FDirection write SetDirection default mdHorizontal;
    property Smooth: boolean read FSmooth write SetSmooth default False;
    property InfiniteMode: boolean read FInfiniteMode write FInfiniteMode default False;
    property DarkFillObject: TLMDFillObject read GetDarkFillObject write SetDarkFillObject;
    property LightFillObject: TLMDFillObject read GetLightFillObject write SetLightFillObject;
    property BackFillObject: TLMDFillObject read GetBackFillObject write SetBackFillObject;
    property BrushBackColor: TColor read FBrushBackColor write SetBrushBackColor default clBtnFace;
    property Font3D: TLMD3DCaption read FFont3D write SetFont3D;
    property Bevel: TLMDBevel read FBevel write SetBevel;
    property LightTextOptions: TLMDMeterTextOptions read FLightTextOptions write SetLightTextOptions default toNoText;
    property DarkTextOptions: TLMDMeterTextOptions read FDarkTextOptions write SetDarkTextOptions default toNoText;
    property LightMargins: TLMDMargins read FLightMargins write SetLightMargins;
    property DarkMargins: TLMDMargins read FDarkMargins write SetDarkMargins;
    {$IFDEF LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$ENDIF}
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property ThemeMode;
    property ParentThemeMode default true;
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

  end;

implementation

uses  
  LMDClass;

{TLMDBiProgressBar}

//---------------------------------------------------------------
//                        create/destroy
//---------------------------------------------------------------

procedure TLMDBiProgressBar.RepaintControl(Sender: TObject);
begin
  invalidate;
end;

constructor TLMDBiProgressBar.Create(AOwner: TComponent);
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
  FDirection := mdHorizontal;
  FSmooth := False;
  FProgressShowMode := psmAllFull;
  Scale := 100;

  FDarkTextColor := clBtnText;
  FLightTextColor := clBtnText;
  FBrushBackColor := clBtnFace;

  FFont3D := TLMD3DCaption.Create;
  FBackFillObject := nil;
  FLightFillObject := nil;
  FDarkFillObject := nil;
  FMarqueeFillObject := nil;

  FDarkMargins := TLMDMargins.Create;
  FDarkMargins.OnChange := RepaintControl;
  FLightMargins := TLMDMargins.Create;
  FLightMargins.OnChange := RepaintControl;

  FBevel := TLMDBevel.Create;

  FMarquee := False;
  FMarqueeUpdateInterval := 25;
  FMarqueeSize := 20;
end;

procedure TLMDBiProgressBar.WndProc(var Message: TMessage);
begin
  inherited;
//  if (Cardinal(Message.Msg) = ParentControlRepaintedMessage) and Transparent and
//     (Message.lParam <> TLMDPtrInt(Self)) then
//  begin
//    Invalidate;
//  end;
end;

destructor TLMDBiProgressBar.Destroy;
begin
  if Assigned(FMarqueeTimer) then
  begin
    FMarqueeTimer.Enabled := False;
    FreeAndNil(FMarqueeTimer);
  end;
  FreeAndNil(FBitmap);
  if Assigned(FDarkFillObject) then
    FreeAndNil(FDarkFillObject);
  if Assigned(FLightFillObject) then
    FreeAndNil(FLightFillObject);
  if Assigned(FMarqueeFillObject) then
    FreeAndNil(FMarqueeFillObject);
  if Assigned(FBackFillObject) then
    FreeAndNil(FBackFillObject);
  FreeAndNil(FLightMargins);
  FreeAndNil(FDarkMargins);
  FreeAndNil(FFont3D);
  FreeAndNil(FBevel);
  inherited Destroy;
end;

function TLMDBiProgressBar.GetBackFillObject: TLMDFillObject;
begin
  if not Assigned(FBackFillObject) then
  begin
    FBackFillObject := TLMDFillObject.Create;
    FBackFillObject.OnChange := RepaintControl;
  end;
  Result := FBackFillObject;
end;

function TLMDBiProgressBar.GetDarkFillObject: TLMDFillObject;
begin
  if not Assigned(FDarkFillObject) then
  begin
    FDarkFillObject := TLMDFillObject.Create;
    FDarkFillObject.OnChange := RepaintControl;
  end;
  Result := FDarkFillObject;
end;

function TLMDBiProgressBar.GetLightFillObject: TLMDFillObject;
begin
  if not Assigned(FLightFillObject) then
  begin
    FLightFillObject := TLMDFillObject.Create(nil);
    FLightFillObject.OnChange := RepaintControl;
  end;
  Result := FLightFillObject;
end;

function TLMDBiProgressBar.GetMarqueeFillObject: TLMDFillObject;
begin
  if not Assigned(FMarqueeFillObject) then
  begin
    FMarqueeFillObject := TLMDFillObject.Create(Self);
    FMarqueeFillObject.OnChange := RepaintControl;
  end;
  Result := FMarqueeFillObject;
end;

//---------------------------------------------------------------
//                     get/set properties
//---------------------------------------------------------------

procedure TLMDBiProgressBar.SetCaption(NewValue: TLMDString);
{ Sets data member FDarkText to NewValue. }
begin
  if (FCaption <> NewValue) then
  begin
    FCaption := NewValue;
    if HandleAllocated  then
      Invalidate;
  end; { if }
end; { SetCaption }

procedure TLMDBiProgressBar.SetDarkText(NewValue: TLMDString);
{ Sets data member FDarkText to NewValue. }
begin
  if (FDarkText <> NewValue) then
  begin
    FDarkText := NewValue;
    if HandleAllocated  then
      Invalidate;
  end; { if }
end; { SetDarkText }

procedure TLMDBiProgressBar.SetLightText(NewValue: TLMDString);
{ Sets data member FLightText to NewValue. }
begin
  if (FLightText <> NewValue) then
  begin
    FLightText := NewValue;
    if HandleAllocated  then
      Invalidate;
  end; { if }
end; { SetLightText }

procedure TLMDBiProgressBar.SetDarkTextColor(NewValue: TColor);
{ Sets data member FDarkTextColor to NewValue. }
begin
  if (FDarkTextColor <> NewValue) then
  begin
    FDarkTextColor := NewValue;
    if HandleAllocated  then
      Invalidate;
  end; { if }
end; { SetDarkTextColor }

procedure TLMDBiProgressBar.SetLightTextColor(NewValue: TColor);
{ Sets data member FLightTextColor to NewValue. }
begin
  if (FLightTextColor <> NewValue) then
  begin
    FLightTextColor := NewValue;
    if HandleAllocated  then
      Invalidate;
  end; { if }
end; { SetLightTextColor }

procedure TLMDBiProgressBar.SetLightFillObject(const Value: TLMDFillObject);
begin
  FLightFillObject.Assign(Value);
  if HandleAllocated  then
    Invalidate;
end;

procedure TLMDBiProgressBar.SetLightMargins(const Value: TLMDMargins);
begin
  if not EqualRect(FLightMargins.AsRect, Value.AsRect) then
  begin
    FLightMargins := Value;
    if HandleAllocated  then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.SetDarkFillObject(const Value: TLMDFillObject);
begin
  FDarkFillObject.Assign(Value);
  if HandleAllocated  then
    Invalidate;
end;

procedure TLMDBiProgressBar.SetDarkMargins(const Value: TLMDMargins);
begin
  if not EqualRect(FDarkMargins.AsRect, Value.AsRect) then
  begin
    FDarkMargins := Value;
    if HandleAllocated  then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.SetScale(aValue: integer);
begin
  if FScale <> aValue then
    FScale := aValue;
  if HandleAllocated  then
    Invalidate;
end;

procedure TLMDBiProgressBar.SetLightValue(aValue: integer);
begin
  if FLightValue = aValue then Exit;
  FLightValue := aValue;
  if HandleAllocated  then
    Invalidate;
end;

procedure TLMDBiProgressBar.SetDarkValue(aValue: integer);
begin
  if FDarkValue <> aValue then
  begin
    FDarkValue := aValue;
    if HandleAllocated  then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.SetAdditive(aValue: boolean);
begin
  if FAdditive = aValue then
  begin
    FAdditive := aValue;
    if HandleAllocated  then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.SetBackFillObject(const Value: TLMDFillObject);
begin
  FBackFillObject.Assign(Value);
  if HandleAllocated then
    Invalidate;
end;

procedure TLMDBiProgressBar.SetBevel(const Value: TLMDBevel);
begin
  FBevel.Assign(Value);
  Perform (CM_LMDBEVELCHANGED, 0, 0);
end;

procedure TLMDBiProgressBar.SetBrushBackColor(const Value: TColor);
begin
  if (FBrushBackColor <> Value) then
  begin
    FBrushBackColor := Value;
    if HandleAllocated then
      Invalidate
  end;
end;

procedure TLMDBiProgressBar.SetValues(ALightValue, ADarkValue, AScale: integer;
  AAdditive: boolean);
begin
  FScale := AScale;
  FLightValue := ALightValue;
  FDarkValue := ADarkValue;
  FAdditive := AAdditive;
  if HandleAllocated  then
    Invalidate;
end;

procedure TLMDBiProgressBar.SetProgressShowMode(aValue: TLMDProgressShowMode);
begin
  if FProgressShowMode <> aValue then
  begin
    FProgressShowMode := aValue;
    if HandleAllocated  then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.SetLightTextFullLine(NewValue: boolean);
begin
  if FLightTextFullLine <> NewValue then
  begin
    FLightTextFullLine := NewValue;
    if HandleAllocated  then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.SetLightTextOptions(const Value: TLMDMeterTextOptions);
begin
  if (FLightTextOptions <> Value) then
  begin
    FLightTextOptions := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.SetDarkTextFullLine(NewValue: boolean);
begin
  if FDarkTextFullLine <> NewValue then
  begin
    FDarkTextFullLine := NewValue;
    if HandleAllocated  then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.SetDarkTextOptions(const Value: TLMDMeterTextOptions);
begin
  if (FDarkTextOptions <> Value) then
  begin
    FDarkTextOptions := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.Paint;
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
  MyRgn: HRGN;
  LText: TLMDString;
  LLightRect: TRect;
  LDarkRect: TRect;

var
  OldP, P: TPoint;
  pid: Integer;
  Details: TThemedProgress;
  LThemeMode: TLMDThemeMode;
begin
  FBitmap.Width := ClientWidth;
  FBitmap.Height := ClientHeight;

  FBitmap.Handle := CreateCompatibleBitmap(Canvas.Handle, ClientWidth, ClientHeight);

  R := ClientRect;
  IntRect := ClientRect;

  Details := tpChunk;
  pid := PP_CHUNK;
  LThemeMode := UseThemeMode;
  if (LThemeMode <> ttmNone) or ((LMDApplication.UseXPThemes and (Bevel.Mode=bmWindows))) then
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
    if LThemeMode = ttmNone then
      LThemeMode := ttmPlatform; // bmWindows compatibility
    if Direction in [mdVertical, mdVerticalReverse] then
      Details := tpBarVert
    else
      Details := tpBar;

    LMDThemeServices.DrawElement(LThemeMode, FBitmap.Canvas.Handle, Details, R);
    R := LMDThemeServices.ContentRect(LThemeMode, FBitmap.Canvas.Handle, ThemeServices.GetElementDetails(tpBar), R);

    IntRect := R;
    if FDirection in [mdVertical, mdVerticalReverse] then
    begin
      Details := tpChunkVert;
      pid := PP_CHUNKVERT;
    end
    else
    begin
      Details := tpChunk;
      pid := PP_CHUNK;
    end;
  end
  else
  begin
    // paint background:
    Bevel.PaintBevel(FBitmap.Canvas, IntRect, False);
    // skip bevel:
    IntRect := Bevel.ClientRect(ClientRect);
    R := IntRect;

    if not Transparent then
    begin
      // FillObject here
      if GetBackFillObject.Style <> sfNone then
      begin
        GetBackFillObject.FillCanvas(FBitmap.Canvas, R, FBrushBackColor);
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
  end;

  with FBitmap.Canvas do
  begin
    if FScale > 0 then
    try
    // paint of dark part:
      PartRect := IntRect;
      if FMarquee then
      begin
        if (FDirection = mdHorizontal) or (FDirection = mdHorizontalReverse) then
        begin
          wd := R.Right - R.Left;
          MSize := Max(MulDiv(FMarqueeValue, wd, Scale), 0);
          if IsThemed then
          begin
            LMDThemeServices.GetThemePartSize(LThemeMode, Handle, teProgress, PP_MOVEOVERLAY, 1, ps);
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
        if IsThemed then
        begin
          if FMarqueeValue > 0 then
            LMDThemeServices.DrawElement(LThemeMode, Handle, Details, R);
        end
        else
        begin
          if FMarqueeValue > 0 then
            GetMarqueeFillObject.ClipFill(FBitmap.Canvas, R, FBrushBackColor, 0);
        end;
        DeleteObject(MyRgn);
      end
      else
      begin
        if (FDirection = mdHorizontal) or (FDirection = mdHorizontalReverse) then
        begin
          wd := R.Right - R.Left;
          DarkSize := Max(MulDiv(DarkValue - MinValue, wd, Scale - MinValue), 0);

          if IsThemed then
          begin
            LMDThemeServices.GetThemePartSize(LThemeMode, Handle, teProgress, pid, 0, ps);

            if ps.cx <= 0 then
              ps.cx := 1;
          end
          else
            if FSmooth then
              ps.cx := 1
            else
              ps.cx := dx + ox;

          LightSize := DarkSize mod wd;
          if FDarkBar3D = lsNone then
            LightSize := (LightSize div ps.cx) * ps.cx;

          with R do
            if FInfiniteMode then
            begin
              if ((DarkSize div wd) mod 2 = 1) then
              begin
                Left := Left + wd - LightSize
              end
              else
                Right := Left + LightSize;
            end
            else
            begin
              if FDirection = mdHorizontalReverse then
                Left := Left + wd - DarkSize
              else
                Right := Left + DarkSize;
            end;
        end
        else
        begin
          wd := R.Bottom - R.Top;
          DarkSize := Max(MulDiv(DarkValue - MinValue, wd, Scale - MinValue), 0);

          if IsThemed and (FLightBar3D = lsWindowBorder) then
          begin
            LMDThemeServices.GetThemePartSize(LThemeMode, Handle ,teProgress, pid, 0, ps);

            if ps.cy <= 0 then
              ps.cy := 0;
          end
          else
            if FSmooth then
              ps.cy := 1
            else
              ps.cy := dx + ox;

          LightSize := DarkSize mod wd;
          if FDarkBar3D = lsNone then
            LightSize := (LightSize div ps.cy) * ps.cy;

          with R do
            if FInfiniteMode then
            begin
              if ((DarkSize div wd) mod 2 = 1) then
              begin
                Bottom := Bottom - (wd - LightSize)
              end
              else
                Top := Bottom - LightSize;
            end
            else
            begin
              if FDirection = mdVerticalReverse then
                Bottom := Bottom - wd + DarkSize
              else
                Top := Bottom - DarkSize;
            end;
        end;

        Brush.Color := FDarkColor;
        if FProgressShowMode in [psmDarkHalf, psmAllHalf] then
        begin
          if (FDirection = mdHorizontal) or (FDirection = mdHorizontalReverse) then
            R.Top := (R.Bottom - R.Top) div 2 + IntRect.Top
          else
            R.Right := (R.Right - R.Left) div 2 + IntRect.Left;
        end;

        if IsThemed then
        begin
          if FDarkValue > 0 then
            if FDarkBar3D = lsWindowBorder then
              LMDThemeServices.DrawElement(LThemeMode, Handle, tbPushButtonNormal, R)
            else
            begin
              LMDThemeServices.DrawElement(LThemeMode, Handle, Details, R);
              if FDirection in [mdVertical, mdVerticalReverse] then
                StretchBlt(handle, r.Left, r.top, r.Right - R.Left, r.bottom -
                  r.top, handle, r.left, r.bottom, r.Right - r.left, r.Top - r.Bottom,
                  SRCCOPY);
            end;
        end
        else
        begin
          if FDarkValue > 0 then
          begin
            LDarkRect := R;
            LMDAdjustRectExt(R, FDarkMargins.AsRect);
            FDarkFillObject.ClipFill(FBitmap.Canvas, R, FBrushBackColor, 0);
            if FDarkBar3D <> lsNone then
              LMDDrawStdFrame(Handle, R, FDarkBar3D, 0)
          end;
        end;

        DarkRect := R;
        //paint of light part:
        R := IntRect;
//        if FBevelStyle <> ebsNone then
//          InflateRect(R, -1, -1);
        if FProgressShowMode in [psmLightHalf, psmAllHalf] then
          if (FDirection = mdHorizontal) or (FDirection = mdHorizontalReverse) then
            R.Bottom := (R.Bottom - R.Top) div 2 + IntRect.Top
          else
            R.Left := (R.Right - R.Left) div 2 + IntRect.Left;

        PartRect := R;
        if (FDirection = mdHorizontal) or (FDirection = mdHorizontalReverse) then
        begin
          LightSize := MulDiv(LightValue - MinValue, wd, Scale - MinValue);
          DarkSize := LightSize mod wd;
          if FLightBar3D = lsNone then
            DarkSize := (DarkSize div ps.cx) * ps.cx;

          with R do
            if InfiniteMode then
            begin
              if ((LightSize div wd) mod 2 = 1) then
              begin
                Left := Left + wd - DarkSize
              end
              else
                Right := Left + DarkSize;
            end
            else
            begin
              if FDirection = mdHorizontalReverse then
                Left := Left + wd - LightSize
              else
                Right := Left + LightSize;
            end;
        end
        else
        begin
          LightSize := MulDiv(LightValue - MinValue, wd, Scale - MinValue);
          DarkSize := LightSize mod wd;
          if FLightBar3D = lsNone then
            DarkSize := (DarkSize div ps.cy) * ps.cy;

          with R do
            if FInfiniteMode then
            begin
              if ((LightSize div wd) mod 2 = 1) then
              begin
                Bottom := Bottom - (wd - DarkSize)
              end
              else
                Top := Bottom - DarkSize;
            end
            else
            begin
              if FDirection = mdVerticalReverse then
                Bottom := Bottom - wd + LightSize
              else
                Top := Bottom - LightSize;
            end;
        end;

        Brush.Color := FLightColor;

        if IsThemed then
        begin
          if FLightValue > 0 then
            if FLightBar3D = lsWindowBorder then
              LMDThemeServices.DrawElement(LThemeMode, Handle, tbPushButtonNormal, R)
            else
            begin
              LMDThemeServices.DrawElement(LThemeMode, Handle, Details, R);
              if FDirection in [mdVertical, mdVerticalReverse] then
                StretchBlt(handle, r.Left, r.top, r.Right - R.Left, r.bottom -
                  r.top, handle, r.left, r.bottom, r.Right - r.left, r.Top - r.Bottom,
                  SRCCOPY);
            end;
        end
        else
        begin
          if FLightValue > 0 then
          begin
            LLightRect := R;
            LMDAdjustRectExt(R, FLightMargins.AsRect);
            FLightFillObject.ClipFill(FBitmap.Canvas, R, FBrushBackColor, 0);
            if FLightBar3D <> lsNone then
              LMDDrawStdFrame(Handle, R, FLightBar3D, 0);
          end;
        end;

        LightRect := R;
        R.Left := 1;
        R.Right := Width - 1;

        // paint of dark text:
        Font.Assign(Self.Font);
        Font.Color := FDarkTextColor;
        Brush.Color := clNone;
        Brush.Style := bsClear;
        if (Length(FDarkText) > 0) or (FDarkTextOptions <> toNoText) then
        begin
          if FDarkTextOptions = toPercent then
            LText := Format('%d%%', [MulDiv(100, FDarkValue, Scale - FMinValue)])
          else
            LText := FDarkText;

          if not FDarkTextFullLine then
            PartRect := DarkRect
          else
            PartRect := LMDAlignTextRect(agCenter, LText, FFont3D, R, Font, False, False, 0);

          LMDDrawTextExt(FBitmap.Canvas, LText, FFont3D, PartRect, DT_NOPREFIX or DT_CENTER or DT_SINGLELINE or DT_VCENTER, [TLMDDrawTextStyle(Enabled)], nil);
        end;

        // paint of light text:
        Font.Assign(Self.Font);
        Font.Color := FLightTextColor;
        Brush.Color := clNone;
        Brush.Style := bsClear;
        if (Length(FLightText) > 0) or (FLightTextOptions <> toNoText) then
        begin
          if FLightTextOptions = toPercent then
            LText := Format('%d%%', [MulDiv(100, FLightValue, Scale - FMinValue)])
          else
            LText := FLightText;

          if not FLightTextFullLine then
            PartRect := LightRect
          else
            PartRect := LMDAlignTextRect(agCenter, LText, FFont3D, ClientRect, Font, False, False, 0);

          LMDDrawTextExt(FBitmap.Canvas, LText, FFont3D, PartRect, DT_NOPREFIX or DT_CENTER or DT_SINGLELINE or DT_VCENTER, [TLMDDrawTextStyle(Enabled)], nil);
        end;
      end;

      if FCaption <> '' then
      begin
        Brush.Style := bsClear;
        Font.Assign(Self.Font);
        PartRect := LMDAlignTextRect(agCenter, FCaption, FFont3D, ClientRect, Font, False, False, 0);
        LMDDrawTextExt(FBitmap.Canvas, FCaption, FFont3D, PartRect, DT_NOPREFIX or DT_CENTER or DT_SINGLELINE or DT_VCENTER, [TLMDDrawTextStyle(Enabled)], nil);
      end;
    except
    end;
  end;

  with FBitmap do
    BitBlt(Self.Canvas.Handle, 0, 0, Width, Height, FBitmap.Canvas.Handle, 0, 0, SRCCOPY);

end;

procedure TLMDBiProgressBar.SetMinValue(NewValue: Integer);
begin
  if (FMinValue <> NewValue) then
  begin
    FMinValue := NewValue;
    if HandleAllocated  then
      Invalidate;
  end; {if}
end; {SetMinValue}

procedure TLMDBiProgressBar.SetLightBar3D(const Value: TLMDBorderStyle);
begin
  if (FLightBar3D <> Value) then
  begin
    FLightBar3D := Value;
    if HandleAllocated  then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.SetDarkBar3D(const Value: TLMDBorderStyle);
begin
  if (FDarkBar3D <> Value) then
  begin
    FDarkBar3D := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.SetDirection(NewValue: TLMDMeterDirection);
var
  LInverse: Boolean;
begin
  if FDirection <> NewValue then
  begin
    LInverse := False;
    if ((Ord(FDirection) mod 2) <> (Ord(NewValue) mod 2))then
      LInverse := True;

    FDirection := NewValue;
    if (not (csLoading in ComponentState)) and (LInverse) then
      SetBounds(Left, Top, Height, Width);
    if HandleAllocated  then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.SetFont3D(const Value: TLMD3DCaption);
begin
  FFont3D.Assign(Value);
end;

procedure TLMDBiProgressBar.SetSmooth(NewValue: boolean);
begin
  if FSmooth <> NewValue then
  begin
    FSmooth := NewValue;
    if HandleAllocated  then
      Invalidate;
  end;
end;

{$IFDEF LMD_UNICODE}
procedure TLMDBiProgressBar.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

procedure TLMDBiProgressBar.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF LMD_UNICODE}

procedure TLMDBiProgressBar.DefineProperties(Filer: TFiler);
begin
  inherited;
//  with GetElReader do
//    Filer.DefineProperty('Transparent', FakeBoolean, nil, False);
//  Filer.DefineProperty('BorderStyle', ReadBorderStyle, nil, False);
end;

procedure TLMDBiProgressBar.ReadBorderStyle(Reader: TReader);
var
  S: String;
begin
  s := Reader.ReadIdent;
end;

procedure TLMDBiProgressBar.SetTransparent(NewValue: Boolean);
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

procedure TLMDBiProgressBar.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if Transparent then
    Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT
  else
    Params.ExStyle := Params.ExStyle and not WS_EX_TRANSPARENT;
end; { CreateParams }

procedure TLMDBiProgressBar.SetMarquee(Value: Boolean);
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

procedure TLMDBiProgressBar.SetMarqueeSize(Value: Integer);
begin
  if Value <> FMarqueeSize then
  begin
    FMarqueeSize := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TLMDBiProgressBar.SetMarqueeUpdateInterval(Value: Integer);
begin
  if Value <> FMarqueeUpdateInterval then
  begin
    FMarqueeUpdateInterval := Value;
    if Assigned(FMarqueeTimer) then
      FMarqueeTimer.Interval := FMarqueeUpdateInterval;
  end;
end;

procedure TLMDBiProgressBar.OnMarqueeTimer(Sender: TObject);
begin
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

procedure TLMDBiProgressBar.SetMarqueeFillObject(const Value: TLMDFillObject);
begin
  FMarqueeFillObject.Assign(Value);
  if HandleAllocated then
    Invalidate;
end;

end.
