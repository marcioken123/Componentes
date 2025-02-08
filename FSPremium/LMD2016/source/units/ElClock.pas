unit ElClock;
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

ElClock unit
------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  ExtCtrls,
  Graphics,
  Math, Types,  Menus,

  LMDTypes,
  LMDSysIn,
  LMDDebugUnit,
  LMDProcs,
  LMDObjectList,
  LMDGraphUtils,
  LMDDateUtils,
  LMDGraph,

  ElVCLUtils,
  ElPanel;

type
  TElClockMode = (cmAnalog, cmDigital);
  TElClockStyle=(csSimple, csWin95);

  TElClockHand=class(TPersistent)
  private
    FColor:TColor;
    FOnChange : TNotifyEvent;
    FThick:Byte;
    FVisible:Boolean;
    procedure SetColor(aColor:TColor);
    procedure SetThickness(aValue:Byte);
    procedure SetVisible(aBool:Boolean);
  protected
    procedure Change; dynamic;
  public
    constructor Create;
  published
    property Color:TColor read FColor write SetColor default clBlack;
    property Visible:Boolean read FVisible write SetVisible default true;
    property Thickness:Byte read FThick write SetThickness default 2;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TElClock = class(TElPanel)
  protected
    FMemBitmap: TBitmap;
    FNeedBmpPaint: Boolean;
    FTimerPaused : Boolean;
    FStartTime : TDateTime;
    FPauseTime : TDateTime;
    FIsTimer : Boolean;
    FTimerActive : Boolean;
    FShowDate : Boolean;
    FShowHint : boolean;
    FTimer : TTimer;
    FTZone : TTImeZoneInformation;
    FLocal : Boolean;
    FSeconds : boolean;
    FAMPM : boolean;
    FCaption : string;
    FUseBias : Boolean;
    FBias : Integer;
    FShowWeekDay : Boolean;
    FUseCustomFormat : Boolean;
    FCustomFormat : string;
    FShowDaysInTimer : Boolean;
    FCountdownActive : Boolean;
    FOnCountdownDone : TNotifyEvent;
    FOnCountdownTick : TNotifyEvent;
    FCountdownPaused : Boolean;
    FCountdownTime : Integer;
    FSaveCDTime : Integer;
    FIsCountdown : boolean;
    FDummyStr   : TLMDString;
    FClockMode: TElClockMode;
    FIsPainting: Boolean;
    FHourHand,
    FMinuteHand,
    FSecondHand: TELClockHand;
    FSecMode,
    FOldSec: Integer;
    FCirclePen: TPen;
    FShowSecCircle: Boolean;
    FStyle:TElClockStyle;
    FFaceColors      : array[0..3] of TColor;
    FDT : TDateTime;
    FResizing: Boolean;
    procedure Loaded; override;
    procedure SetCirclePen(Value: TPen);
    procedure SetShowSeconds(Value: Boolean);
    procedure GetChange(Sender: TObject);
    function GetFaceColors (anIndex : integer) : TColor;
    procedure SetFaceColors (anIndex : integer; aColor : TColor);
    procedure SetIsCountdown(newValue : boolean);
    procedure SetCountdownTime(newValue : Integer);
    procedure SetCountdownPaused(newValue : Boolean);
    procedure SetCountdownActive(newValue : Boolean);
    procedure SetShowDaysInTimer(newValue : Boolean);
    procedure SetUseCustomFormat(newValue : Boolean);
    procedure SetCustomFormat(newValue : string);
    procedure SetShowWeekDay(newValue : Boolean);
    procedure SetUseBias(newValue : Boolean);
    procedure SetBias(newValue : Integer);
    function GetTimer : boolean;
    procedure SetTimer(value : boolean);
    procedure OnTimer(Sender : TObject);
    procedure WMMouseMove(var Msg : TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonDown(var Msg : TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg : TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMEnterSizeMove(var Message: TMessage); message WM_ENTERSIZEMOVE;
    procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;
    procedure SetShowDate(newValue : Boolean);
    procedure SetShowHint(newValue : Boolean);
    procedure SetIsTimer(newValue : Boolean);
    function GetTimeElapsed : TDateTime;
    procedure SetTimerActive(newValue : Boolean);
    procedure SetTimerPaused(newValue : Boolean);
    procedure CreateTimer;
    procedure PaintBorders(Canvas : TCanvas; var R : TRect);
    procedure Paint; override;
    procedure DigitalPaint;
//    procedure PaintHands(ACanvas:TCanvas);
    procedure PaintHands(ABitmap:TBitmap);
    procedure AnalogPaint;
    procedure PaintSmallScale(ACanvas:TCanvas; p1,p2:TPoint);
    procedure PaintNormalScale(ACanvas:TCanvas; p1,p2:TPoint);
    procedure InheritedPaint;
    procedure TriggerCountdownDoneEvent; virtual;
    procedure TriggerCountdownTickEvent; virtual;
    procedure SetStyle(Value: TElClockStyle);
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure Resize; override;
    procedure SetClockMode(Value: TElClockMode);
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Kick; virtual;
    procedure GetTime(var Time : TSystemTime); virtual;
    procedure ResetTimer;

    property TimeElapsed: TDateTime read GetTimeElapsed;
    property TimeZone: TTimeZoneInformation read FTZone write FTZone;
    property DT: TDateTime read FDT;
  published
    property Caption: TLMDString read FDummyStr;
    property LocalTime : boolean read FLocal write FLocal default true;
    property ShowWeekDay : Boolean read FShowWeekDay write SetShowWeekDay default False;
    property ShowSeconds : boolean read FSeconds write SetShowSeconds default True;
    property ShowDate : Boolean read FShowDate write SetShowDate default False; { Published }
    property AM_PM : boolean read FAMPM write FAMPM default False;
    property Labels : boolean read FShowHint write SetShowHint default False;
    property UseBias : Boolean read FUseBias write SetUseBias default False;
    property Bias : Integer read FBias write SetBias default 0;
    property UseCustomFormat : Boolean read FUseCustomFormat write SetUseCustomFormat default False;
    property CustomFormat : string read FCustomFormat write SetCustomFormat;
    property ShowSecCircle: Boolean read FShowSecCircle write FShowSecCircle default False;
    property ClockMode: TElClockMode read FClockMode write SetClockMode default cmDigital;
    property ClockStyle:TElClockStyle read FStyle write SetStyle default csWin95;
    property IsTimer: Boolean read FIsTimer write SetIsTimer default False;
    property TimerActive : Boolean read FTimerActive write SetTimerActive default False;
    property TimerPaused : Boolean read FTimerPaused write SetTimerPaused default False;
    property ShowDaysInTimer : Boolean read FShowDaysInTimer write SetShowDaysInTimer default False;
    property IsCountdown : boolean read FIsCountdown write SetIsCountdown default False;
    property CountdownTime : Integer read FCountdownTime write SetCountdownTime default 0;
    property CountdownActive : Boolean read FCountdownActive write SetCountdownActive default False;
    property CountdownPaused : Boolean read FCountdownPaused write SetCountdownPaused default False;
    property UseTimer : Boolean read GetTimer write SetTimer default true;

    property OnCountdownDone : TNotifyEvent read FOnCountdownDone write FOnCountdownDone;
    property OnCountdownTick : TNotifyEvent read FOnCountdownTick write FOnCountdownTick;

    property ColorSmallTick :TColor index 0 read GetFaceColors write SetFaceColors default clWhite;
    property ColorSmallTickShade :TColor index 1 read GetFaceColors write SetFaceColors default clBtnShadow;
    property ColorBigTick :TColor index 2 read GetFaceColors write SetFaceColors default clAqua;
    property ColorBigTickShade :TColor index 3 read GetFaceColors write SetFaceColors default clBlack;
    property HourHand: TElClockHand read FHourHand write FHourHand stored True;
    property MinuteHand: TELClockHand read FMinuteHand write FMinuteHand stored True;
    property SecondHand: TELClockHand read FSecondHand write FSecondHand stored True;
    property SecondCircle: TPen read FCirclePen write SetCirclePen;

    property Align;
    property Alignment;
    property BevelInner default bvLowered;
    property BevelOuter default bvRaised;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property Cursor;
    property Font;
    property Hint;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property OnClick;
    property OnDblClick;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnDragOver;
    property OnDragDrop;
    property OnEndDrag;
    property OnStartDrag;
    property OnResize;

    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;

  end;

type
  PShortTZ = ^TShortTZ;
  TShortTZ = packed record
    Bias,
      StandardBias,
      DayLightBias : LongInt;
    wReserved1, // year field
      StdMonth,
      StdDayOfWeek,
      StdDay,
      StdHour,
      StdMinute,
      StdSecond,
      wReserved2, // msec field
      wReserved3, // year field
      DLMonth,
      DLDayOfWeek,
      DLDay,
      DLHour,
      DLMinute,
      DLSecond,
      wReserved4 // msec field
      : word;

  end;

  PTimeZoneInfo = ^TTimeZoneInfo;
  TTimeZoneInfo = record
  KeyName : string;
    DisplayName : string;
    DltName : string;
    StdName : string;
    MapID : string;
    TimeZone : TTimeZoneInformation;
    STimeZone : TShortTZ;
  end;

function RetrieveTimeZoneInfo(TimeZoneInfoList : TLMDObjectList) : boolean;
procedure ShortTZToTimeZoneInfo(ShortTZ : TShortTZ; var TZInfo : TTimeZoneInfo);
function TranslateTZDate(ADate : TSystemTime) : string;

var
  FDL : boolean;
  SysTimeZones : TLMDObjectList;

implementation

constructor TElClock.Create(AOwner : TComponent);
begin
  inherited;
  FMemBitmap := TBitmap.Create;
  FMemBitmap.HandleType := bmDIB;
  FNeedBmpPAint := True;
  BevelInner := bvLowered;
  BevelOuter := bvRaised;
  FLocal := true;
  UseTimer := true;
  FCustomFormat := 'DD xx';
  FClockMode := cmDigital;
  FShowSecCircle := False;
  FSeconds := True;
  FStyle := csWin95;
  FFaceColors[0] := clwhite ; {small tick}
  FFaceColors[1] := clBtnShadow ; {small tick shade}
  FFaceColors[2] := clAqua ; {big ticks}
  FFaceColors[3] := clBlack ; {big tick shade}
  FHourHand:=TElClockHand.Create;

  with FHourHand do
  begin
    Thickness := 5;
    Color := clAqua;
    OnChange := Self.GetChange;
  end;

  FMinuteHand := TElClockHand.Create;
  with FMinuteHand do
  begin
    Thickness := 3;
    Color := clTeal;
    OnChange := Self.GetChange;
  end;

  FSecondHand := TElClockHand.Create;
  with FSecondHand do
  begin
    Thickness := 1;
    OnChange := Self.GetChange;
  end;
  FCirclePen := TPen.Create;
  FCirclePen.OnChange := GetChange;
  FResizing := False;
end;

destructor TElClock.Destroy;
begin
  FreeAndNil(FMemBitmap);
  FreeAndNil(FCirclePen);
  FHourHand.OnChange:=nil;
  FMinuteHand.OnChange:=nil;
  FSecondHand.OnCHange:=nil;
  FreeAndNil(FHourHand);
  FreeAndNil(FMinuteHand);
  FreeAndNil(FSecondHand);
  if FTimer <> nil then
  begin
    FTimer.Free;
    FTimer := nil;
  end;
  inherited;
end;

procedure TElClock.GetTime(var Time : TSystemTime);
var
  LocalTime : TSystemTime;
begin
  if FLocal then
    GetLocalTime(Time)
  else
  begin
    GetSystemTime(LocalTime);
    Time := LocalTime;
    LMDUTCToZoneLocal(@FTZone, LocalTime, Time);
    if UseBias then
      DateTimeToSystemTime(LMDIncTime(SystemTimeToDateTime(Time), 0, FBias, 0, 0), Time);
  end;
end;

procedure TElClock.Kick;
var
  CurTime : TSystemTime;
  Buffer : pchar;
  s, s1, s2 : string;
begin
  if HandleAllocated then
    AdjustSize;
  if IsTimer then
  begin
    if FTimerActive then
    begin
      if FTimerPaused then
        FDT := FPauseTime - FStartTime
      else
        FDT := Now - FStartTime;
    end
    else
    begin
      FDT := 0;
    end;
    if ShowDaysInTimer then
    begin
      FCaption := IntToStr(Round(FDT)) + '.';
    end
    else
    begin
      FCaption := '';
    end;
    FCaption := FCaption + TimeToStr(Frac(FDT));
    Repaint;
    exit;
  end
  else
  if IsCountDown then
  begin
    if FCountdownActive then
    begin
      if FCountdownPaused then
        FDT := FStartTime - FPauseTime
      else
      begin
        FDT := FStartTime - Now;
      end;
      FCountDownTime := Trunc(FDT * 86400);
      if not FCountDownPaused then TriggerCountdownTickEvent;
      if (FDT = 0) or (Now > FStartTime) then
      begin
        TriggerCountdownDoneEvent;
        CountdownActive := false;
      end;
    end
    else
      FDT := CountdownTime / 86400;
    if UseCustomFormat then
      FCaption := LMDGetFormattedTimeString(Frac(FDT), CustomFormat)
    else
      FCaption := FormatDateTime('hh:nn:ss', Frac(FDT));
    Invalidate;
    exit;
  end;
  GetMem(Buffer, 100);
  GetTime(CurTime);

  if UseCustomFormat then
  begin
    FDT := SystemTimeToDateTime(CurTime);
    FCaption := LMDGetFormattedTimeString(FDT, CustomFormat);
  end
  else
  begin
    if not FAMPM then
    begin
      s := IntToStr(CurTime.wHour);
      if Length(s) = 1 then
        S2 := '0' + s
      else
        S2 := s;
      s := IntToStr(CurTime.wMinute);
      if Length(s) = 1 then
        S2 := S2 + ':0' + s
      else
        S2 := S2 + ':' + s;
      if ShowSeconds then
      begin
        s := IntToStr(CurTime.wSecond);
        if Length(s) = 1 then
          S2 := S2 + ':0' + s
        else
          S2 := S2 + ':' + s;
      end;
    end
    else
    begin
      s := IntToStr(CurTime.wHour mod 12);
      if CurTime.wHour = 0 then s := '12';
      S2 := s;
      s := IntToStr(CurTime.wMinute);
      if Length(s) = 1 then
        S2 := S2 + ':0' + s
      else
        S2 := S2 + ':' + s;
      if ShowSeconds then
      begin
        s := IntToStr(CurTime.wSecond);
        if Length(s) = 1 then
          S2 := S2 + ':0' + s
        else
          S2 := S2 + ':' + s;
      end;
      if (CurTime.wHour div 12 = 0) then
        S2 := S2 + ' AM'
      else
        S2 := S2 + ' PM';
    end;
    GetDateFormat(LOCALE_USER_DEFAULT, DATE_SHORTDATE, @CurTime, nil, Buffer, 100);
    S1 := StrPas(Buffer);
    FDT := SystemTimeToDateTime(CurTime);
    if FPressed then FCaption := S1
    else
    begin
      if FShowWeekDay then CurTime.wDayOfWeek := SysUtils.DayOfWeek(SystemTimeToDateTime(CurTime)) - 1;
      if FShowWeekDay and FShowDate then S1 := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames[CurTime.wDayOfWeek + 1] + ', ' + S1;
      FCaption := S2;
      if FShowDate then
        FCaption := FCaption + #13#10 + S1;
      if FShowWeekDay and (not FShowDate) then FCaption := FCaption + #13#10 + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames[CurTime.wDayOfWeek + 1];
    end;
  end;
  if Labels then FCaption := FCaption + #13#10 + Hint;
  FreeMem(Buffer, 100);
  end;

procedure TElClock.OnTimer(Sender : TObject);
begin
  if FIsTimer then
  begin
    if (not FTimerPaused) and FTimerActive then Kick;
  end
  else
    Kick;
  if HandleAllocated and Visible then
    Repaint;
end;

procedure TElClock.CreateTimer;
begin
  FTimer := TTimer.Create(self);
  FTimer.Interval := 1000;
  FTimer.OnTimer := OnTimer;
  FTimer.Enabled := true;
end;

function TElClock.GetTimer : boolean;
begin
  result := Assigned(FTimer);
end;

procedure TElClock.SetTimer(value : boolean);
begin
  if value <> Assigned(FTimer) then
  begin
    if value then
      CreateTimer
    else
    begin
      FTimer.Free;
      FTimer := nil;
    end;
  end;
end;

procedure TElClock.WMLButtonDown(var Msg : TWMLButtonDown); { private }
begin
  inherited;
  if (not ShowDate) and not ((ClockMode = cmAnalog) and (UseTimer=false)) then
  begin
    Kick;
    Repaint;
  end;
end; { WMLButtonDown }

procedure TElClock.WMLButtonUp(var Msg : TWMLButtonUp); { private }
begin
  inherited;
  if not ((ClockMode = cmAnalog) and (UseTimer=false)) then
  begin
    Kick;
    Repaint;
  end;
end; { WMLButtonUp }

procedure TElClock.SetShowHint(newValue : Boolean);
begin
  if (FShowHint <> newValue) then
  begin
    FShowHint := newValue;
    Kick;
    Repaint;
  end; { if }
end; { SetShowDate }

procedure TElClock.SetShowDate(newValue : Boolean);
begin
  if (FShowDate <> newValue) then
  begin
    FShowDate := newValue;
    Kick;
    Repaint;
  end; { if }
end; { SetShowDate }

procedure TElClock.PaintBorders(Canvas : TCanvas; var R : TRect);
var
  TopColor,
    BottomColor : TColor;

const
  Alignments : array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);

  procedure AdjustColors(Bevel : TLMDBevelStyle);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;

begin
  if BevelOuter <> bvNone then
  begin
    AdjustColors(BevelOuter);
    Frame3D(Canvas, R, TopColor, BottomColor, BevelWidth);
  end;
  Frame3D(Canvas, R, Color, Color, BorderWidth);
  if BevelInner <> bvNone then
  begin
    AdjustColors(BevelInner);
    Frame3D(Canvas, R, TopColor, BottomColor, BevelWidth);
  end;
end;

procedure TElClock.InheritedPaint;
begin
  inherited Paint;
end;

procedure TElClock.PaintNormalScale(ACanvas: TCanvas; p1, p2: TPoint);
const
  rsize=2;
begin
  with aCanvas do
    case FStyle of
      csSimple:
                begin
                  moveto(p1.x, p1.y);
                  lineto(p2.x, p2. y);
                end;
      csWIN95:  begin
                  Brush.Style := bsSolid;
                  Brush.Color := FFaceColors[3];
                  Pen.Color := FFaceColors[3];
                  Ellipse(p1.x+rsize, p1.y+rsize,  p1.x-rsize, p1.y-rsize);
                  Pen.Color := FFaceColors[2];
                  Brush.Color := FFaceColors[2];
                  Ellipse(p1.x-rsize, p1.y-rsize,  p1.x + rsize-1, p1.y + rsize-1);
//                  Windows.Rectangle(Handle, p1.x+rsize, p1.y+rsize,  p1.x-rsize-1, p1.y-rsize-1);
//                  Pen.Color := clBlack;
//                  moveTo(p1.x-rsize-1, p1.y+rsize-1);
//                  lineto(p1.x+rsize-1, p1.y+rsize-1);
//                  lineto(p1.x+rsize-1, p1.y-rsize-1);
                end;
    end;
end;

procedure TElClock.PaintSmallScale(ACanvas: TCanvas; p1, p2: TPoint);
const
  rsize=2;
begin
  with ACanvas do
    case FStyle of
      csSimple:
               begin
                 moveto(p1.x, p1.y);
                 lineto(p2.x, p2.y);
               end;
      csWIN95: begin
                 Pen.Color := FFaceColors[0];
                 Brush.Color := FFaceColors[0];
                 Brush.Style := bsSolid;
                 Ellipse(p1.x-rsize, p1.y-rsize,  p1.x+rsize, p1.y+rsize);
                 Pen.Color := FFaceColors[1];
                 Brush.Color := FFaceColors[1];
                 Ellipse(p1.x-rsize, p1.y-rsize,  p1.x+ rsize-1, p1.y+rsize-1);
               end;
    end;
end;

procedure TElClock.PaintHands(ABitmap: TBitmap);
const
  AxisRad=1;
  Rop=R2_Nop;
var
  t, x, y, r1, r2, r3, r4,r5:integer;
  cs, sn: real;
  fchr, fcmi, fcsc, fcms :word;
begin
  fchr := 0;
  if FShowSecCircle then inc (fchr, FCirclePen.Width);

  x := (width - 6) div 2;
  y := (height - 6) div 2;
  if BevelInner <> bvNone then
  begin
    x := x - BevelWidth;
    y := y - BevelWidth;
  end;
  if BevelOuter <> bvNone then
  begin
    x := x - BevelWidth;
    y := y - BevelWidth;
  end;
  r1 := Min(x,y)-fchr;
  if FShowSecCircle then
    r1 := r1 - 1 - FCirclePen.Width;

  r2 := round(0.5 * r1);
  r3 := round(0.6 * r1);
  r4 := round(0.7 * r1);
  r5 := round(0.1 * r1);
  with aBitmap.Canvas do
    begin
      Pen.Style:=psSolid;
      if Enabled {and not (csDesigning in ComponentState)} then
        DecodeTime(FDT, fchr, fcmi, fcsc, fcms)
      else
        begin
          fchr := 0;
          fcmi := 0;
          fcsc := 0;
        end;
      if FHourHand.Visible then
        with FHourHand do
          begin
            Pen.Color := Color;
            cs := cos((360/12*fchr+0.5*fcmi)*pi/180);
            sn := sin((360/12*fchr+0.5*fcmi)*pi/180);
            Pen.Width := Thickness;
            t := Thickness div 2;
            if t > 0 then
            begin
              moveto(x - round(r5*sn), y + round(r5*cs));
              lineto(x + round(r2*sn), y - round(r2*cs));
              if not FResizing then
              begin
                if (x - round(r5*sn) < x + round(r2*sn)) then
                begin
                  LMDDrawSmoothLine(aBitmap,x - round(r5*sn)+t, y + round(r5*cs)-t,x + round(r2*sn)+t, y - round(r2*cs)-t,Color);
                  LMDDrawSmoothLine(aBitmap,x - round(r5*sn)-t, y + round(r5*cs)+t,x + round(r2*sn)-t, y - round(r2*cs)+t,Color);
                end
                else
                begin
                  LMDDrawSmoothLine(aBitmap,x - round(r5*sn)+t, y + round(r5*cs)+t,x + round(r2*sn)+t, y - round(r2*cs)+t,Color);
                  LMDDrawSmoothLine(aBitmap,x - round(r5*sn)-t, y + round(r5*cs)-t,x + round(r2*sn)-t, y - round(r2*cs)-t,Color);
                end;
              end;
            end
            else
              if not FResizing then
                LMDDrawSmoothLine(aBitmap,x - round(r5*sn), y + round(r5*cs),x + round(r2*sn), y - round(r2*cs),Color)
              else
              begin
                moveto(x - round(r5*sn), y + round(r5*cs));
                lineto(x + round(r2*sn), y - round(r2*cs));
              end;
          end;
      if FMinuteHand.Visible then
        with FMinuteHand do
          begin
            Pen.Color := Color;
            cs := cos(360/60*fcmi*pi/180);
            sn := sin(360/60*fcmi*pi/180);
            Pen.Width := Thickness;
            t := Thickness div 2;
            if t > 0 then
            begin
              moveto(x - round(r5*sn), y + round(r5*cs));
              lineto(x + round(r3*sn), y - round(r3*cs));
              if not FResizing then
              begin
                if (x - round(r5*sn) < x + round(r2*sn)) then
                begin
                  LMDDrawSmoothLine(aBitmap,x - round(r5*sn)+t, y + round(r5*cs)-t,x + round(r3*sn)+t, y - round(r3*cs)-t,Color);
                  LMDDrawSmoothLine(aBitmap,x - round(r5*sn)-t, y + round(r5*cs)+t,x + round(r3*sn)-t, y - round(r3*cs)+t,Color);
                end
                else
                begin
                  LMDDrawSmoothLine(aBitmap,x - round(r5*sn)+t, y + round(r5*cs)+t,x + round(r3*sn)+t, y - round(r3*cs)+t,Color);
                  LMDDrawSmoothLine(aBitmap,x - round(r5*sn)-t, y + round(r5*cs)-t,x + round(r3*sn)-t, y - round(r3*cs)-t,Color);
                end;
              end;
            end
            else
              if not FResizing then
                LMDDrawSmoothLine(aBitmap,x - round(r5*sn), y + round(r5*cs),x + round(r3*sn), y - round(r3*cs),Color)
              else
              begin
                moveto(x - round(r5*sn), y + round(r5*cs));
                lineto(x + round(r3*sn), y - round(r3*cs));
              end;
          end;
      if FSecondHand.Visible then
        with FSecondHand do
          begin
            Pen.Color := Color;
            cs := cos(360/60*fcsc*pi/180);
            sn := sin(360/60*fcsc*pi/180);
            Pen.Width := Thickness;
            t := Thickness div 2;
            if t > 0 then
            begin
              moveto(x - round(r5*sn), y + round(r5*cs));
              lineto(x + round(r4*sn), y - round(r4*cs));
              if not FResizing then
              begin
                if (x - round(r5*sn) < x + round(r2*sn)) then
                begin
                  LMDDrawSmoothLine(aBitmap,x - round(r5*sn)+t, y + round(r5*cs)-t,x + round(r4*sn)+t, y - round(r4*cs)-t,Color);
                  LMDDrawSmoothLine(aBitmap,x - round(r5*sn)-t, y + round(r5*cs)+t,x + round(r4*sn)-t, y - round(r4*cs)+t,Color);
                end
                else
                begin
                  LMDDrawSmoothLine(aBitmap,x - round(r5*sn)+t, y + round(r5*cs)+t,x + round(r4*sn)+t, y - round(r4*cs)+t,Color);
                  LMDDrawSmoothLine(aBitmap,x - round(r5*sn)-t, y + round(r5*cs)-t,x + round(r4*sn)-t, y - round(r4*cs)-t,Color);
                end;
              end;
            end
            else
              if not FResizing then
                LMDDrawSmoothLine(aBitmap,x - round(r5*sn), y + round(r5*cs),x + round(r4*sn), y - round(r4*cs),Color)
              else
              begin
                moveto(x - round(r5*sn), y + round(r5*cs));
                lineto(x + round(r4*sn), y - round(r4*cs));
              end;
          end;
        if FShowSecCircle then
        begin
          Pen.Assign(FCirclePen);
          inc(r1, 2 + FCirclePen.Width);
          cs := cos(360/60*fcsc*pi/180) * -1;
          sn := sin(360/60*fcsc*pi/180);
          if FOldSec > fcsc then
            FSecMode := 1 - FSecMode;
          case FSecMode of
            0: Arc (x - r1, y - r1, x + r1, y + r1, x,0,  x+round(r1* sn), y+round(r1 * cs));
            1: if fcsc <> 0 then Arc (x - r1, y - r1, x + r1, y + r1, x+round(r1* sn), y+round(r1 * cs), x,0);
          end;
          FOldSec := fcsc;
        end;
    end;
end;

procedure TElClock.AnalogPaint;
  procedure PaintAnalog(aBitmap :TBitmap);
  const
    Step=6;
  var
    i, x, y, r1, r2, r3: integer;
    cs, sn: real;
    rgn : HRGN;
  begin
    with aBitmap do
    begin
      i := 0;
      r2 := 2;

      if FShowSecCircle then
        inc (r2, FCirclePen.Width);

      x := width div 2;
      y := Height div 2;

      r1 := Min(x,y)-r2;
      if FShowSecCircle then
        r1 := r1 - 1 - FCirclePen.Width;

      r2 := round(0.9 * r1);
      r3 := round(0.8 * r1);
      rgn := CreateEllipticRgn (x-r1, y - r1, x+r1, y+r1);

      SelectClipRgn (aBitmap.Canvas.Handle, rgn);

      if (not Transparent) or (IsThemed and TransparentXPThemes) then
      begin
        aBitmap.Canvas.Brush.Color := self.Color;
        aBitmap.Canvas.FillRect(Rect(x-r1, y - r1, x+r1, y+r1));
      end
      else
      begin
        aBitmap.Canvas.Brush.Style := bsClear;
        aBitmap.Canvas.FillRect(Rect(x-r1, y - r1, x+r1, y+r1));
      end;
      SelectClipRgn (aBitmap.Canvas.Handle, 0);
      DeleteObject (rgn);
      aBitmap.Canvas.Pen.Style:=psSolid;
      aBitmap.Canvas.Pen.Color:=clBlack;
      while i<360 do
        begin
          cs := cos(i*pi/180);
          sn := sin(i*pi/180);
          if i mod 30 =0 then
            PaintNormalScale(aBitmap.Canvas,Point(x + round(r1*sn), y - round(r1*cs)),
                                     Point(x + round(r3*sn), y - round(r3*cs)))
          else
            PaintSmallScale(aBitmap.Canvas,Point(x + round(r1*sn), y - round(r1*cs)),
                                    Point(x + round(r2*sn), y - round(r2*cs)));

          inc(i, step);
        end;
    end;
  end;
var
  R : TRect;
  H, W : integer;
  UsBitmap :TBitmap;
begin
  if FIsPainting or (csLoading in ComponentState) then exit;
  FIsPainting:=True;
  R := ClientRect;
  if BevelInner <> bvNone then InflateRect(R, -BevelWidth, -BevelWidth);
  if BevelOuter <> bvNone then InflateRect(R, -BevelWidth, -BevelWidth);
  InflateRect(R, -4, -4);
  W := (R.Right - R.Left);
  H := (R.Bottom - R.Top);
  if FNeedBmpPaint then
  begin
    FNeedBmpPaint := False;
    with FMemBitmap do
    begin
      FMemBitmap.Width := W;
      FMemBitmap.Height := H;
      FMemBitmap.Canvas.CopyRect(Rect(0,0,W,H), Self.Canvas, R);
      PaintAnalog(FMemBitmap);
    end;
  end;
  UsBitmap := TBitmap.Create;
  UsBitmap.HandleType := bmDIB;
  with UsBitmap do
    try
      UsBitmap.Width := W;
      UsBitmap.Height := H;
//      Canvas.Brush.Color := Color;
//      UsBitmap.Canvas.CopyRect(Rect(0,0,W,H), FMemBitmap.Canvas, R);
      UsBitmap.Assign(FMemBitmap);
      PaintHands(UsBitmap);
      Self.Canvas.CopyRect(R, UsBitmap.Canvas, Rect(0,0,W,H));
    finally
      FreeAndNil(UsBitmap);
      FIsPainting:=False;
    end;
end;

procedure TElClock.DigitalPaint;
var
  R : TRect;
  AL : integer;
begin
  R := ClientRect;
  if Transparent or TransparentXPThemes then
  begin
  end;
  Canvas.Brush.Style := bsClear;
  if BevelInner <> bvNone then InflateRect(R, -BevelWidth, -BevelWidth);
  if BevelOuter <> bvNone then InflateRect(R, -BevelWidth, -BevelWidth);
  case Alignment of
    taCenter : AL := DT_CENTER;
    taRightJustify : AL := DT_RIGHT;
  else
    AL := DT_LEFT;
  end;
  if Pos(#13#10, FCaption) = 0 then AL := AL or DT_SINGLELINE;
  DrawText(Canvas.Handle, PChar(FCaption), -1, R, DT_VCENTER or DT_NOCLIP or DT_EXPANDTABS or DT_NOPREFIX or AL);
end;

procedure TElClock.Paint; { public }
begin
  inherited;
  case FClockMode of
    cmDigital: DigitalPaint;
    cmAnalog: AnalogPaint;
  end;
end; { Paint }

procedure TElClock.SetIsTimer(newValue : Boolean);
begin
  if (FIsTimer <> newValue) then
  begin
    FIsTimer := newValue;
    if FIsTimer then
    begin
      FStartTime := Now;
      isCountdown := false;
    end;
  end; {if}
  Kick;
  Repaint;
end;

function TElClock.GetTimeElapsed : TDateTime;
begin
  if FTimerPaused then
    Result := FPauseTime - FStartTime
  else
    Result := Now - FStartTime;
end;

procedure TElClock.SetTimerActive(newValue : Boolean);
begin
  if (FTimerActive <> newValue) then
  begin
    FTimerActive := newValue;
    ResetTimer;
  end; {if}
  if IsTimer then
  begin
    Kick;
    Repaint;
  end;
end;

procedure TElClock.ResetTimer;
begin
  FStartTime := Now;
  FPauseTime := FStartTime;
  Kick;
  Repaint;
end;

procedure TElClock.SetTimerPaused(newValue : Boolean);
begin
  if (FTimerPaused <> newValue) then
  begin
    FTimerPaused := newValue;
    if NewValue then
    begin
      FPauseTime := Now;
    end
    else
    begin
      FStartTime := FStartTime + (Now - FPauseTime);
      Kick;
      Repaint;
    end;
  end;
end; {SetTimerPaused}

procedure TElClock.SetUseBias(newValue : Boolean);
begin
  if (FUseBias <> newValue) then
  begin
    FUseBias := newValue;
    if not IsTimer then
    begin
      Kick;
      Repaint;
    end;
  end; {if}
end;

procedure TElClock.SetBias(newValue : Integer);
begin
  if (FBias <> newValue) then
  begin
    FBias := newValue;
    if not IsTimer then
    begin
      Kick;
      Repaint;
    end;
  end; {if}
end;

procedure TElClock.SetShowWeekDay(newValue : Boolean);
begin
  if (FShowWeekDay <> newValue) then
  begin
    FShowWeekDay := newValue;
    if FShowDate then
    begin
      Kick;
      Repaint;
    end;
  end; {if}
end; {SetShowWeekDay}

procedure TElClock.SetUseCustomFormat(newValue : Boolean);
begin
  if (FUseCustomFormat <> newValue) then
  begin
    FUseCustomFormat := newValue;
    Kick;
    Repaint;
  end; {if}
end; {SetUseCustomFormat}

procedure TElClock.SetCustomFormat(newValue : string);
begin
  if (FCustomFormat <> newValue) then
  begin
    FCustomFormat := newValue;
    Kick;
    Repaint;
  end; {if}
end; {SetCustomFormat}

procedure TElClock.SetShowDaysInTimer(newValue : Boolean);
begin
  if (FShowDaysInTimer <> newValue) then
  begin
    FShowDaysInTimer := newValue;
    if FIsTimer then
    begin
      Kick;
      Repaint;
    end;
  end; {if}
end;

procedure TElClock.SetIsCountdown(newValue : boolean);
begin
  if (FIsCountdown <> newValue) then
  begin
    FIsCountdown := newValue;
    if FIsCountdown then
    begin
      FStartTime := Now + CountdownTime / 86400;
      IsTimer := false;
    end;
    Kick;
    Repaint;
  end; {if}
end;

procedure TElClock.SetCountdownTime(newValue : Integer);
begin
  if (FCountdownTime <> newValue) then
  begin
    FCountdownTime := newValue;
    FSaveCDTime := FCountdownTime;
    FStartTime := Now + CountdownTime / 86400;
  end; {if}
end;

procedure TElClock.SetCountdownPaused(newValue : Boolean);
begin
  if (FCountdownPaused <> newValue) then
  begin
    FCountdownPaused := newValue;
    if NewValue then
    begin
      FPauseTime := Now;
    end
    else
    begin
      FStartTime := FStartTime + (Now - FPauseTime);
      Kick;
      Repaint;
    end;
  end; {if}
end;

procedure TElClock.TriggerCountdownDoneEvent;
begin
  if (assigned(FOnCountdownDone)) then FOnCountdownDone(Self);
  CountdownTime := FSaveCDTime;
end;

procedure TElClock.SetCountdownActive(newValue : Boolean);
begin
  if (FCountdownActive <> newValue) then
  begin
    if newValue then
    begin
      FStartTime := Now + CountdownTime / 86400;
      FSaveCDTime := CountdownTime;
    end
    else
      CountdownTime := FSaveCDTime;
    FCountdownActive := newValue;
    Kick;
    Repaint;
  end; {if}
end;

procedure TElClock.TriggerCountdownTickEvent;
{ Triggers the OnCountdownTick event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnCountdownTick)) then
    FOnCountdownTick(Self);
end; { TriggerCountdownTickEvent }

procedure TElClock.WMMouseMove(var Msg : TWMMouseMove); { private }
var
  b : boolean;
begin
  b := Movable and FPressed;
  inherited;
  if b then
  begin
    Kick;
    Repaint;
  end;
end; { WMMouseMove }

function TElClock.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
var
  R : TRect;
  AL : integer;
  x, y : integer;
begin
  if HandleAllocated then
  begin
    SetRectEmpty(R);

    Canvas.Brush.Style := bsClear;
    case Alignment of
      taCenter : AL := DT_CENTER;
      taRightJustify : AL := DT_RIGHT;
    else
      AL := DT_LEFT;
    end;
    if Pos(#13#10, FCaption) = 0 then
      AL := AL or DT_SINGLELINE;
    DrawText(Canvas.Handle, PChar(FCaption), -1, R, DT_CALCRECT or DT_VCENTER or DT_NOCLIP or DT_EXPANDTABS or DT_NOPREFIX or AL);

    x := R.Right - R.Left + 2;
    y := R.Bottom - R.Top + 2;

    if BevelInner <> bvNone then
    begin
      inc(x, BevelWidth);
      inc(y, BevelWidth);
    end;
    if BevelOuter <> bvNone then
    begin
      inc(x, BevelWidth);
      inc(y, BevelWidth);
    end;

    NewWidth := x;
    NewHeight := y;
  end;
  Result := True;
end;

procedure ShortTZToTimeZoneInfo(ShortTZ : TShortTZ; var TZInfo : TTimeZoneInfo);
begin
  TZInfo.TimeZone.Bias := ShortTZ.Bias;
  TZInfo.TimeZone.StandardBias := ShortTZ.StandardBias;
  TZInfo.TimeZone.DaylightBias := ShortTZ.DaylightBias;
  MoveMemory(@TZInfo.TimeZone.StandardDate, @(ShortTZ.wReserved1), sizeof(TSystemTime));
  MoveMemory(@TZInfo.TimeZone.DaylightDate, @(ShortTZ.wReserved3), sizeof(TSystemTime));
  end;

function TranslateTZDate(ADate : TSystemTime) : string;
const
  ACounts : array[1..5] of string = ('First', 'Second', 'Third', 'Fourth', 'Last');
  ADays : array[0..6] of string = ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
  AMonthes : array[1..12] of string = ('January', 'February', 'March',
    'April', 'May', 'June',
    'July', 'August', 'September',
    'October', 'November', 'December');
begin
  result := ACounts[ADate.wDay] + ' ' + ADays[ADate.wDayOfWeek] + ' of ' + AMonthes[ADate.wMonth] + ' at '
    + TimeToStr(EncodeTime(ADate.wHour, ADate.wMinute, ADate.wSecond, 0));
end;

function RetrieveTimeZoneInfo;

type
  PByte = ^byte;

var
  KeyStr,
    SubKeyStr : string;
  Key,
    SubKey : HKey;
  ptz : PTimeZoneInfo;
  res : DWORD;
  i : integer;
  b1 : PChar;
  b2 : PByte;
  bufsize : DWORD;
  atime : TFileTime;
begin
  {$IFDEF LMD_DEBUGMESSAGES}
  LMDDebug('Reading time zones');
  {$ENDIF}
  result := false;
  try
    if LMDSIWindowsNT then
      KeyStr := 'Software\Microsoft\Windows NT\CurrentVersion\Time Zones'
    else
      KeyStr := 'Software\Microsoft\Windows\CurrentVersion\Time Zones';
    if RegOpenKeyEx(HKEY_LOCAL_MACHINE, Int_ref(KeyStr), 0, KEY_READ, Key) <> ERROR_SUCCESS then
    begin
      //MessageBox(0, 'Failed to open TimeZone key', '', 0);
      exit;
    end;
    i := 0;
    repeat
      New(PTZ);
      GetMem(b1, 100);
      BufSize := 100;
      res := RegEnumKeyEx(Key, i, b1 {key name}, BufSize, nil, nil, nil, @atime);
      if res = ERROR_SUCCESS then
      begin
        PTZ.KeyName := StrPas(B1);
        SubKeyStr := PTZ.KeyName;
        if RegOpenKeyEx(Key, Int_Ref(SubKeyStr), 0, KEY_READ, SubKey) = ERROR_SUCCESS then
        begin
          GetMem(b2, 100);
          BufSize := 100;
          if RegQueryValueEx(SubKey, 'MapID', nil, nil, @(byte(B2^)), @BufSize) = ERROR_SUCCESS then
            PTZ.MapID := StrPas(PChar(B2))
          else
          begin
            {$IFDEF LMD_DEBUGMESSAGES}
            LMDDebug('Failed to retrieve MapID of this zone: ' + SubKeyStr);
            {$ENDIF}
          end;

          BufSize := 100;
          if RegQueryValueEx(SubKey, 'Display', nil, nil, @(byte(B2^)), @BufSize) = ERROR_SUCCESS then
            PTZ.DisplayName := StrPas(PChar(B2))
          else
          begin
            {$IFDEF LMD_DEBUGMESSAGES}
            LMDDebug('Failed to retrieve Display of this zone: ' + SubKeyStr);
            {$ENDIF}
          end;

          BufSize := sizeof(PTZ.STimeZone);
          if RegQueryValueEx(SubKey, 'TZI', nil, nil, @PTZ.STimeZone, @BufSize) = ERROR_SUCCESS then
          begin
          ShortTZToTimeZoneInfo(PTZ.STimeZone, PTZ^);
          end
          else
          begin
            {$IFDEF LMD_DEBUGMESSAGES}
            LMDDebug('Failed to retrieve TZI of this zone: ' + SubKeyStr);
            {$ENDIF}
          end;
          BufSize := 100;
          if RegQueryValueEx(SubKey, 'Dlt', nil, nil, @(byte(B2^)), @BufSize) = ERROR_SUCCESS then
            PTZ.DltName := StrPas(PChar(B2))
          else
          begin
            {$IFDEF LMD_DEBUGMESSAGES}
            LMDDebug('Failed to retrieve Dlt of this zone: ' + SubKeyStr);
            {$ENDIF}
          end;
          BufSize := 100;
          if RegQueryValueEx(SubKey, 'Std', nil, nil, @(byte(B2^)), @BufSize) = ERROR_SUCCESS then
            PTZ.StdName := StrPas(PChar(B2))
          else
          begin
            {$IFDEF LMD_DEBUGMESSAGES}
            LMDDebug('Failed to retrieve Std of this zone: ' + SubKeyStr);
            {$ENDIF}
          end;
          RegCloseKey(SubKey);
          FreeMem(b2);
          end
        else
        begin
          {$IFDEF LMD_DEBUGMESSAGES}
          LMDDebug('Failed to retrieve any information at all about this zone: ' + SubKeyStr);
          {$ENDIF}
        end;
        TimeZoneInfoList.Add(PTZ);
      end
      else
      begin
        {$IFDEF LMD_DEBUGMESSAGES}
        LMDDebug('Failed to query time zone ' + IntToStr(i));
        {$ENDIF}
        Dispose(PTZ);
        end;
      inc(i);
      FreeMem(b1, 100);
      until RES = ERROR_NO_MORE_ITEMS;
    RegCloseKey(Key);
    //MessageBox(0, PChar('Total items: ' + IntToStr(TimeZoneInfoList.Count)), '', 0);
    result := true;
  except
    on E: EOutOfMemory do
    result := false;
  end;
end;

{$warnings off}
var i : integer;

{ TElClockHand }

procedure TElClockHand.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

constructor TElClockHand.Create;
begin
  inherited Create;
  FVisible := true;
  FColor := clBlack;
  FThick := 2;
end;

procedure TElClockHand.SetColor(aColor: TColor);
begin
  if aColor<>FColor then
    begin
      FColor:=aColor;
      Change;
    end;
end;

procedure TElClockHand.SetThickness(aValue: Byte);
begin
  if aValue<>FThick then
    begin
      FThick := AValue;
      Change;
    end;
end;

procedure TElClockHand.SetVisible(aBool: Boolean);
begin
  if aBool<>FVisible then
    begin
      FVisible := aBool;
      Change;
    end;
end;

procedure TElClock.GetChange(Sender: TObject);
begin
  FNeedBmpPaint := True;
  Refresh;
end;

function TElClock.GetFaceColors(anIndex: integer): TColor;
begin
  if anIndex<4 then
    result:=FFaceColors[anindex]
end;

procedure TElClock.SetFaceColors(anIndex: integer; aColor: TColor);
begin
  if anIndex<4 then
  begin
    if FFaceColors[anindex]<>AColor then FFaceColors[anindex] := AColor else exit;
    GetChange(nil);
  end;
end;

procedure TElClock.SetCirclePen(Value: TPen);
begin
  FCirclePen.Assign(Value);
end;

procedure TElClock.SetClockMode(Value: TElClockMode);
begin
  if FClockMode <> Value then
  begin
    FClockMode := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TElClock.SetShowSeconds(Value: Boolean);
begin
  FSeconds := Value;
  FSecondHand.Visible := Value;
end;

procedure TElClock.SetStyle(Value: TElClockStyle);
begin
  FStyle := Value;
  FNeedBmpPaint := True;
end;

procedure TElClock.Resize;
begin
  inherited;
  FNeedBmpPaint := True;
end;

procedure TElClock.WMEnterSizeMove(var Message: TMessage);
begin
  FResizing := True;
end;

procedure TElClock.WMExitSizeMove(var Message: TMessage);
begin
  FResizing := False;
end;

procedure TElClock.Loaded;
begin
  inherited;
  Kick;
  invalidate;
end;

initialization
  FDL := false;
  SysTimeZones := TLMDObjectList.Create;
  RetrieveTimezoneInfo(SysTimeZones);

finalization
  try
    for i := 0 to SysTimeZones.Count - 1 do
    Dispose(PTimeZoneInfo(SysTimezones[i]));
    SysTimeZones.Free;

  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElClock: ' + e.Message);
    end;
  end;

end.
