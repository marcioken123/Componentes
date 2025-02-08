unit LMDClock;
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

LMDClock unit (RM, JH)
----------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, menus, Forms,
  LMDConst, LMDLED, LMDObject, LMDGraph, LMDClass, LMDFillObject, LMDDateTime,
  LMDBase, LMDGraphicControl, LMDGradientFrames, LMDFillers, LMDFigures;

type

  {data types}
  TLMDClockMode=(cmNormal, cmDate, cmStopwatch, cmCountdown, cmAlarm);
  TLMDClockStyle=(csSimple, csWin95, csVista, csWindows7);

  TLMDClockOption=(coShowDigital, coShowAnalog, coEnableAlarm, co24Hour, coFixed, coOffset, coShowSecCircle);
  TLMDClockOptions=set of TLMDClockOption;

  {***************************** used objects *********************************}
  {----------------- TLMDClockHand --------------------------------------------}
  TLMDClockHand=Class(TLMDObject)
  private
    FColor:TColor;
    FStyle:TLMDClockStyle;
    FThick:Byte;
    FVisible:Boolean;
    procedure SetColor(aColor:TColor);
    procedure SetThickness(aValue:Byte);
    procedure SetVisible(aBool:Boolean);
  public
    constructor Create(Owner:TPersistent=nil); override;
  published
    property Color:TColor read FColor write SetColor default clBlack;
    property Visible:Boolean read FVisible write SetVisible default true;
    property Thickness:Byte read FThick write SetThickness default 2;
  end;

  {----------------- TLMDTimeInterval -----------------------------------------}
  TLMDTimeInterval=class(TLMDObject)
  private
    FTimeInterval:array[1..3] of word;
    FEnabled:Boolean;
    FEndTime:TDatetime;
    procedure SetEnabled(aBool:Boolean);
    procedure SetEndtime(aDatetime:TDatetime);
    procedure SetTime(anIndex:Integer; aWord:Word);
    function GetEndtime:TDatetime;
    function GetTime(anIndex:Integer):Word;
  public
    constructor Create(Owner:TPersistent=nil); override;
  published
    property Enabled:Boolean read FEnabled write SetEnabled default false;
    property EndTime:TDatetime read GetEndtime write SetEndtime stored FEnabled;
    property Hour:Word index 1 read GetTime write SetTime default 0;
    property Minute:Word index 2 read GetTime write SetTime default 1;
    property Second:Word index 3 read GetTime write SetTime default 0;
  end;

  { ******************** object TLMDTimeOffset ******************************* }
  TLMDTimeOffset = class (TLMDObject)
  private
    FDays,
    FHours,
    FMinutes,
    FSeconds  : Integer;
  public
    constructor Create(Owner:TPersistent=nil); override;
    procedure Assign (Source : TPersistent); override;
    procedure Offset (var time : TDateTime);
  published
    property Days : Integer read FDays write FDays default 0;
    property Hours : Integer read Fhours write FHours default 0;
    property Minutes : Integer read FMinutes write FMinutes default 0;
    property Seconds : Integer read FSeconds write FSeconds default 0;
  end;

  TLMDClockFill = (fmControl, fmClock);

  {****************************** Component ***********************************}
  {---------------------------- TLMDClock -------------------------------------}
  TLMDClock = class(TLMDGraphicControl)
  private
    FAlarm,
    First            : Boolean;
    FDigital         : TLMDLed;
    FUseCustomDT,
    FDigitalOnly,
    FDigitalShowSecs : Boolean;
    FDigitalString   : String;
    FHourHand,
    FMinuteHand,
    FSecondHand      : TLMDClockHand;
    FTimerIdent      : TLMDTimer;
    FIsPainting      : Boolean;
    {clock functions}
    FAlarmtime,
    FStopwatch       : TDatetime;
    FClockMode       : TLMDClockMode;
    FCountdown       : TLMDTimeInterval;
    FStopwatchEnabled: Boolean;
    FStopwatchPaused : Boolean;
    //overall time in stopwatch paused mode
    FStopwatchPausedTime : TDatetime;
    //start time of the current pause
    FStopwatchPauseStart : TDatetime;

    {clock appearance}
    FPosY,
    FPosX            : Integer;
    FStyle           : TLMDClockStyle;
    FFaceColors      : array[0..4] of TColor;
    FDigitalColor    : TColor;
    FOptions         : TLMDClockOptions;
    FSaveBitmap      : TBitmap;
    FRepeat          : Word;
    FRepCount        : Integer; //JH 21.05.99 (:word) <0 not possible
    FDateTimeFormat  : TLMDDateTimeFormat;
    FFixedTime       : TLMDDateTime;
    FTimeOffset      : TLMDTimeOffset;
    FFillObject      : TLMDFillObject;
    FFillMode        : TLMDClockFill;

    {helper}
    FCirclePen       : TPen;
    FSecMode,
    FOldSec          : Integer;

    {events}
    FOnAlarm,
    FOnCountdownStart,
    FOnCountdownEnd,
    FOnStopWatchStart,
    FOnStopWatchEnd,
    FOnStopWatchPause,
    FOnStopWatchResume: TNotifyEvent;
    FUseGlobalTimer: Boolean;

    FColorScheme: TLMDColorScheme;
    procedure SetUseGlobalTimer(const Value: Boolean);
    procedure SetDateTimeFormat (aValue : TLMDDateTimeFormat);
    procedure SetBoolean (Index : Integer; aValue : Boolean);
    procedure SetClockOptions (aSet : TLMDClockOptions);
    procedure SetDigital (aValue : TLMDLED);
    procedure SetFaceColors (anIndex : integer; aColor : TColor);
    procedure SetPos (Index : Integer; aValue : integer);
    procedure SetStyle (aStyle : TLMDClockStyle);
    procedure SetMode (aMode : TLMDClockMode);
    procedure SetFixed (aValue : TLMDDateTime);
    procedure SetOffset (aValue : TLMDTimeOffset);
    procedure SetFillObject (aValue : TLMDFillObject);
    procedure SetFillMode (aValue : TLMDClockFill);
    procedure SetCirclePen (aValue: TPen);
    function GetFaceColors (anIndex : integer) : TColor;

    function  CorrectBounds:Boolean;
    procedure PaintAnalog(ACanvas:TCanvas);

    procedure PaintDigital(ACanvas:TCanvas);
    procedure PaintHands(ACanvas:TCanvas);
    procedure PaintSmallScale(ACanvas:TCanvas; p1,p2:TPoint);
    procedure PaintNormalScale(ACanvas:TCanvas; p1,p2:TPoint);
    procedure PaintHourNumber(ACanvas:TCanvas; x, y:integer; cs, sn: double; r:integer; aHour: integer);

    procedure CMColorChanged(var Message:TMessage);message CM_COLORCHANGED;
    procedure CMEnabledChanged(var Message:TMessage);message CM_ENABLEDCHANGED;
    procedure SetColorScheme(const Value: TLMDColorScheme);
  protected
    function GetDigitalText : String; virtual;
    procedure GetChange(Sender:TObject);override;
    procedure BoundsChange(State:TLMDBoundsChangeStates);override;
    function GetTime : TDateTime; virtual;
    procedure GetIMLChange (Sender : TObject); override;

    procedure Loaded;override;
    procedure OnTimer(Sender:TObject);
    procedure Paint; override;

  public
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    procedure BackUpdate; override;

    {Methods for clock functions}
    procedure Alarm; virtual;
    procedure EndAlarm;
    {stopwatch}
    procedure StartStpWatch;
    procedure EndStpWatch;
    procedure PauseStpWatch;
    procedure ResumeStpWatch;
    {countdown}
    procedure StartCountdown;
    procedure EndCountdown;

    property Alarmtime:TDateTime read FAlarmtime write FAlarmtime;
    property Countdown:TLMDTimeInterval read FCountdown write FCountdown;
    property StopwatchPausedTime: TDateTime read FStopwatchPausedTime;
  published
    property About;
    property Bevel;
    property Color;
    property ColorScheme: TLMDColorScheme read FColorScheme write SetColorScheme default csDefaultScheme;

    // 7.0
    property UseGlobalTimer:Boolean read FUseGlobalTimer write SetUseGlobalTimer default false;
    // ---
    property ColorSmallTick :TColor index 0 read GetFaceColors write SetFaceColors default clWhite;
    property ColorSmallTickShade :TColor index 1 read GetFaceColors write SetFaceColors default clBtnFace;
    property ColorBigTick :TColor index 2 read GetFaceColors write SetFaceColors default clTeal;
    property ColorBigTickShade :TColor index 3 read GetFaceColors write SetFaceColors default clAqua;
    property ColorBigTickLight :TColor index 4 read GetFaceColors write SetFaceColors default clBlack;
    property Digital:TLMDLED read FDigital write SetDigital;
    property DigitalColor:TColor index 5 read GetFaceColors write SetFaceColors default clBlack;
    property DigitalOnly:Boolean index 0 read FDigitalOnly write SetBoolean default false;
    property DigitalShowSecs:Boolean index 1 read FDigitalShowSecs write SetBoolean default True;
    property DigitalPosX:integer index 0 read FPosx write SetPos default -1;
    property DigitalPosY:Integer index 1 read FPosy write SetPos default -1;
    property Enabled;
    property FillObject : TLMDFillObject read FFillObject write SetFillObject;
    property FillMode : TLMDClockFill read FFillMode write SetFillMode default fmControl;
    property FixedTime : TLMDDateTime read FFixedTime write SetFixed;
    property HourHand:TLMDClockHand read FHourHand write FHourHand;
    property ImageList;
    property ListIndex;
    property MinuteHand:TLMDClockHand read FMinuteHand write FMinuteHand;
    property Mode:TLMDClockMode read FClockMode write SetMode default cmNormal;
    property Options:TLMDClockOptions read FOptions write SetClockOptions default [coShowAnalog, co24Hour];
    property RepeatAlarm:Word read FRepeat write FRepeat default 10;
    property SecondHand:TLMDClockHand read FSecondHand write FSecondHand;
    property SecondCircle: TPen read FCirclePen write SetCirclePen;
    property Stopwatch:TDatetime read FStopwatch;
    property Style:TLMDClockStyle read FStyle write SetStyle default csWin95;
    property TimeOffset : TLMDTimeOffset read FTimeOffset write SetOffset;
    property Transparent nodefault;
    property CustomDateTimeFormat : TLMDDateTimeFormat read FDateTimeFormat write SetDateTimeFormat;
    property UseCustomDateTime : Boolean index 2 read FUseCustomDT write SetBoolean default false;
    {events}
    property OnAlarm :TNotifyEvent read FOnAlarm write FOnAlarm;
    property OnCountdownStart :TNotifyEvent read FOnCountdownStart write FOnCountdownStart;
    property OnCountdownEnd :TNotifyEvent read FOnCountdownEnd write FOnCountdownEnd;
    property OnStopWatchStart: TNotifyEvent read FOnStopWatchStart write FOnStopWatchStart;
    property OnStopWatchEnd: TNotifyEvent read FOnStopWatchEnd write FOnStopWatchEnd;
    property OnStopWatchPause: TNotifyEvent read FOnStopWatchPause write FOnStopWatchPause;
    property OnStopWatchResume: TNotifyEvent read FOnStopWatchResume write FOnStopWatchResume;
    {inherited}
    property DragCursor;
    property DragMode;
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
    property DragKind;
    property OnEndDock;
    property OnStartDock;
  end;

implementation

uses
  RtlConsts, Types, Consts, SysConst,
  LMDProcs, LMDCustomScrollBox, LMDCustomControl, LMDCustomImageList, LMDCont;

{****************************** Object TLMDClockHand **************************}
{--------------------------------- Private ------------------------------------}
procedure TLMDClockHand.SetColor(aColor:TColor);
begin
  if aColor<>FColor then
    begin
      FColor:=aColor;
      Change;
    end;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDClockHand.SetStyle(aStyle:TLMDClockStyle);
begin
  if AStyle<>FStyle then
    begin
      FStyle := AStyle;
      Change;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClockHand.SetThickness(aValue:Byte);
begin
  if aValue<>FThick then
    begin
      FThick := AValue;
      Change;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClockHand.SetVisible(aBool:Boolean);
begin
  if aBool<>FVisible then
    begin
      FVisible := aBool;
      Change;
    end;
end;

{--------------------------------- Public -------------------------------------}
constructor TLMDClockHand.Create;
begin
  inherited Create;
  FVisible := true;
  FColor := clBlack;
  FThick := 2;
  FStyle := csWin95;
end;

{*********************** Object TLMDTimeInterval ******************************}
{--------------------------------- Private ------------------------------------}
procedure TLMDTimeInterval.SetEnabled(aBool:Boolean);
begin
  if abool<> FEnabled then
    begin
      FEnabled:=aBool;
      FEndtime := now + EncodeTime(FTimeInterval[1], FTimeInterval[2], FTimeInterval[3],0);
      Change;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimeInterval.SetEndtime(aDatetime:TDatetime);
var
  dummy :TDatetime;
  nopvalue :word;
begin
  if aDatetime<>FEndtime then
    begin
      FEndtime:=aDatetime;
      dummy:=FEndtime-now;
      if dummy>0 then
        begin
          DecodeTime(dummy,FTimeInterval[1],FTimeInterval[2],FTimeInterval[3], nopvalue);
          change;
        end
      else
        SetTime(2,1);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimeInterval.SetTime(anIndex:Integer; aWord:Word);
begin
  if FTimeInterval[anIndex]<>aWord then
    begin
      FTimeInterval[anIndex]:=aWord;
      FEndtime:=Now+EncodeTime(FTimeInterval[1],FTimeInterval[2],FTimeInterval[3],0);
      Change;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTimeInterval.GetEndtime:TDatetime;
begin
  result := FEndtime;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTimeInterval.GetTime(anIndex:Integer):Word;
begin
  result:=FTimeInterval[anIndex];
end;

{--------------------------------- Public -------------------------------------}
constructor TLMDTimeInterval.Create;
begin
  inherited Create;
  FTimeInterval[1] := 0;
  FTimeInterval[2] := 1;
  FTimeInterval[3] := 0;
  SetEndtime(now + 0.000694445); {equal to now + 1 minute = 1 /(24*60)}
end;

{************************* Object TLMDTimeOffset ******************************}
constructor TLMDTimeOffset.Create;
begin
  inherited Create;
  FDays := 0;
  FHours := 0;
  FMinutes := 0;
  FSeconds := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimeOffset.Assign (Source : TPersistent);
var
  S: TLMDTimeOffset;
begin
  if Source is TLMDTimeOffset then
    begin
      S := TLMDTimeOffset(Source);
      FDays := S.Days;
      FHours := S.Hours;
      FMinutes := S.Minutes;
      FSeconds := S.Seconds;
      Exit;
    end;
  inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimeOffset.Offset (var time : TDateTime);
begin
  time := time + FDays;
  time := time + FHours / 24;
  time := time + FMinutes /(24*60);
  time := time + FSeconds /(24*60*60);
end;

{************************* Component TLMDClock ********************************}
{--------------------------------- Private ------------------------------------}
procedure TLMDClock.SetBoolean(Index:Integer; aValue:Boolean);
begin
  case Index of
    0:if aValue=FDigitalOnly then exit else FDigitalOnly:=aValue;
    1:if aValue=FDigitalShowSecs then exit else FDigitalShowSecs:=aValue;
    2:if aValue=FUseCustomDT then exit else FUseCustomDT:=aValue;
  end;
  if FDigitalShowSecs then FDigitalString:='hh:nn:ss' else FDigitalString:='hh:nn';
  if not FSaveBitmap.Empty then FSaveBitmap.FreeImage;
  GetChange(nil);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDClock.SetDateTimeFormat (aValue : TLMDDateTimeFormat);
begin
  if aValue <> FDateTimeFormat then
    begin
      FDateTimeFormat := aValue;
      if FUseCustomDT then
        GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.SetClockOptions(aSet:TLMDClockOptions);
begin
  if aSet<>FOptions then
    begin

      if not ((coShowDigital in ASet) or (coShowAnalog in ASet)) then
        raise exception.Create(IDS_MustShowOne);

      if (coShowAnalog in FOptions) and not (coShowAnalog in aSet) then
        begin
          FPosx:=0;
          FPosy:=0;
        end;
      FOptions:=aSet;
      GetChange(nil);
    end;
end;

procedure TLMDClock.SetColorScheme(const Value: TLMDColorScheme);
begin
  //Different styles may have different settings for same color scheme, so
  //we do not perform usual check "if FColorScheme <> Value" here
  BeginUpdate;
  FColorScheme := Value;
  case FColorScheme of
    csDefaultScheme:
    begin
      case Style of
        csWin95:
        begin
          Color := clBtnFace;
          FillObject.Style := sfNone;
          FFaceColors[0] := clWhite ; {small tick}
          FFaceColors[1] := clbtnface ; {small tick shade}
          FFaceColors[2] := clTeal ; {big ticks}
          FFaceColors[3] := clAqua ; {big tick shade}
          FFaceColors[4] := clBlack ; {big tick light}
          HourHand.Color:=clAqua;
          MinuteHand.Color := clTeal;
          SecondHand.Color := clBlack;
        end;
        csVista:
        begin
          Color := clWhite;
          ColorSmallTick := $003E474A;
          ColorSmallTickShade := clWhite;
          ColorBigTick := $002A2820;
          ColorBigTickShade := $00ACB1B0;
          ColorBigTickLight := $002A2820;
          FillMode := fmClock;
          FillObject.Style := sfGradient;
          FillObject.Gradient.Style := gstElliptic;
          FillObject.Gradient.TwoColors := False;
          FillObject.Gradient.Colors.Clear;
          FillObject.Gradient.ColorCount := 64;
          FillObject.Gradient.Colors.Add(Pointer(15791606));
          FillObject.Gradient.Colors.Add(Pointer(15530491));
          FillObject.Gradient.Colors.Add(Pointer(15530491));
          FillObject.Gradient.Colors.Add(Pointer(15530491));
          FillObject.Gradient.InitPalette;
          HourHand.Color := $005F686B;
          MinuteHand.Color := $005F686B;
          SecondHand.Color := clRed
        end;
        csWindows7:
        begin
          Color := clWhite;
          ColorSmallTick := 10328205;
          ColorSmallTickShade := 7300948;
          ColorBigTick := 10328205;
          ColorBigTickShade := 7300948;
          ColorBigTickLight := 10328205;
          HourHand.Color := 7300948;
          MinuteHand.Color := 7300948;
          SecondHand.Color := 10328205;
        end;
      end;
    end;
    csBlue:
    begin
      Color := clWhite;
      ColorSmallTick := 14405798;
      ColorSmallTickShade := clWhite;
      ColorBigTick := clWhite;
      ColorBigTickShade := 15918030;
      ColorBigTickLight := clNavy;
      FillMode := fmClock;
      FillObject.Style := sfGradient;
      FillObject.Gradient.Style := gstTopRight;
      FillObject.Gradient.TwoColors := False;
      FillObject.Gradient.Colors.Clear;
      FillObject.Gradient.ColorCount := 64;
      FillObject.Gradient.Colors.Add(Pointer(15192764));
      FillObject.Gradient.Colors.Add(Pointer(16513268));
      FillObject.Gradient.Colors.Add(Pointer(16510945));
      FillObject.Gradient.InitPalette;
      HourHand.Color := 11759451;
      MinuteHand.Color := 11759451;
      SecondHand.Color := 11759451;
      Transparent := True;
    end;
    csMetallic:
    begin
      Color := clWhite;
      ColorSmallTick := clSilver;
      ColorSmallTickShade := clWhite;
      ColorBigTick := clWhite;
      ColorBigTickShade := clSilver;
      ColorBigTickLight := clGray;
      FillMode := fmClock;
      FillObject.Style := sfGradient;
      FillObject.Gradient.ColorCount := 64;
      FillObject.Gradient.Style := gstTopRight;
      FillObject.Gradient.TwoColors := False;
      FillObject.Gradient.Colors.Clear;
      FillObject.Gradient.ColorCount := 64;
      FillObject.Gradient.Colors.Add(Pointer(13487565));
      FillObject.Gradient.Colors.Add(Pointer(16316664));
      FillObject.Gradient.Colors.Add(Pointer(12369084));
      FillObject.Gradient.InitPalette;
      HourHand.Color := 10724259;
      MinuteHand.Color := 10724259;
      SecondHand.Color := 10724259;
      Transparent := True;
    end;
    csBlack:
    begin
      Color := clBlack;
      ColorSmallTick := clGray;
      ColorSmallTickShade := clSilver;
      ColorBigTick := clWhite;
      ColorBigTickShade := clSilver;
      FillMode := fmClock;
      FillObject.Style := sfGradient;
      FillObject.Gradient.Style := gstTopRight;
      FillObject.Gradient.TwoColors := False;
      FillObject.Gradient.Colors.Clear;
      FillObject.Gradient.ColorCount := 64;
      FillObject.Gradient.Colors.Add(Pointer(4802889));
      FillObject.Gradient.Colors.Add(Pointer(10066329));
      FillObject.Gradient.Colors.Add(Pointer(5395026));
      FillObject.Gradient.InitPalette;
      HourHand.Color := clWhite;
      MinuteHand.Color := clWhite;
      SecondHand.Color := clWhite;
      Transparent := True;
    end;
  end;
  EndUpdate(false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.SetDigital(aValue:TLMDLED);
begin
  FDigital.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.SetFaceColors(anIndex:Integer;aColor:TColor);
begin
  case anIndex of
    0..4: if FFaceColors[anindex]<>AColor then FFaceColors[anindex] := AColor else exit;
    5:    if FDigitalColor<>aColor then FDigitalColor:=aColor else exit;
  end;
  GetChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.SetMode(aMode:TLMDClockMode);
begin
  if AMode<>FClockMode then
    begin
      FCountdown.Enabled:=false;
      FStopWatchEnabled:=false;
      FClockMode:=AMode;
      Paint;
   end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.SetFixed (aValue : TLMDDateTime);
begin
  FFixedTime.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.SetOffset (aValue : TLMDTimeOffset);
begin
  FTimeOffset.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.SetFillObject (aValue : TLMDFillObject);
begin
  FFillObject.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.SetFillMode (aValue : TLMDClockFill);
begin
  if aValue <> FFillMode then
    begin
      FFillMode := aValue;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.SetCirclePen (aValue: TPen);
begin
  FCirclePen.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.SetPos(Index:Integer; aValue:Integer);
begin
  case Index of
    0:if aValue=FPosX then exit else FPosX:=aValue;
    1:if aValue=FPosY then exit else FPosY:=aValue;
  end;
  GetChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.SetStyle(AStyle :TLMDClockStyle);
begin
  if AStyle<>FStyle then
    begin
      FStyle:=aStyle;
      ColorScheme := csDefaultScheme;
        //GetChange(nil);  GetChange is triggered when ColorScheme is set
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.SetUseGlobalTimer(const Value: Boolean);
begin
  if FUseGlobalTimer<>Value then
    begin
      FUseGlobalTimer := Value;
      FTimerIdent.GlobalMode:=FUseGlobalTimer;
      if FUseGlobalTimer then
        FTimerIdent.Interval:=500  // avoids "jumping" of seconds hand
      else
        FTimerIdent.Interval:=1000;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDClock.GetFaceColors(anIndex:Integer):TColor;
begin
  if anIndex<5 then
    result:=FFaceColors[anindex]
  else
    result:=FDigitalColor;
end;

{ ---------------------------------------------------------------------------- }
function TLMDClock.CorrectBounds:Boolean;
var
  w, h:Integer;
begin
  result:=false;
  if FDigitalOnly then
    begin
      h:=DblBevelExt;
      //+1 removed from w:= line, 18.09.2000 JH
      w:=FDigital.LEDWidth*Length(GetDigitalText)+DblBevelExt;
      inc(h,FDigital.LEDHeight);
      if (w<>Width) or (h<>Height) then
        begin
          SetBounds(Left, Top, w, h);
          result:=True;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.PaintAnalog(aCanvas :TCanvas);
const
  Step=6;
var
  i, x, y, r1, r2, r3, r: integer;
  cs, sn: real;
  rgn : HRGN;

  lfg: TLMDEllipse;
  lfr: TLMDGradientCircleFrame;
  lefl: TLMDEllipseFiller;
  llfl1,llfl2,llfl3: TLMDLineFiller;
  lbmp: TBitmap;
  w, h: integer;
  br: TRect;

begin
  i := 0;
  if BevelExt<=1 then r2:=4 else r2:=DblBevelExt{+2};

  if coShowSecCircle in FOptions then inc (r2, FCirclePen.Width);

  x := width div 2;
  y := height div 2;

  r1 := LMDMin([x,y])-r2;

  case Style of
  csVista:
    begin
      r2 := round(0.9 * r1);
      r3 := round(0.84 * r1);
    end;
  csWindows7:
    begin
      r2 := round(0.9 * r1);
      r3 := round(0.88 * r1);
    end
  else
    begin
      r2 := round(0.9 * r1);
      r3 := round(0.8 * r1);
    end;
  end;

  if Style = csWindows7 then
  begin
    w := r1 * 2;
    h := r1 * 2;

    lbmp:= TBitmap.Create;
    lbmp.PixelFormat := pf24bit;
    lbmp.Width := w;
    lbmp.Height := h;
    br := Rect(0, 0, w, h);

    if (FFillMode <> fmClock) and (FFillObject.Style <> sfNone) then
      FFillObject.FillCanvas (lbmp.Canvas, br, Color)
    else
    begin
      lbmp.Canvas.Brush.Style := bsSolid;
      lbmp.Canvas.Brush.Color := Color;
      lbmp.Canvas.FillRect(br);
    end;

    lfg := TLMDEllipse.Create(0, 0, w, h);

    lefl := TLMDEllipseFiller.Create;
    lfg.Filler := lefl;
    lefl.Axis1 := muldiv(w, 4, 5);
    lefl.Axis2 := muldiv(h, 4, 5) ;
    lefl.BasePoint := Point(w, h);
    lefl.FirstAxisDirection := Point(1, 0);
    lefl.StartColor := 16645370;
    lefl.EndColor := 14473679;


    lfg.AntiAliasing := true;
    lfg.Draw24(lbmp);

    lfr := TLMDGradientCircleFrame.Create;

    lfr.VisibleParts := [sfpOuterBorder, sfpInnerSpace, sfpInnerBorder];
    lfr.OuterBorder.Width := (w + h) div 100;
    lfr.SpaceWidth := (w + h) div 133;
    lfr.InnerBorder.Width := (w + h) div 100;


    lfr.ContentsRect := lfr.CalcContentsRect(br);

    llfl1 := TLMDLineFiller.Create;
    llfl1.ColorCount := 2;
    llfl1.UseRelativeUnits := true;
    llfl1.FixedColors[0] := 16447736;
    llfl1.FixedColors[1] := 13156798;
    llfl1.BasePoint := Point(0, 0);
    llfl1.VectorN := Point(w, h);
    llfl1.VectorT := Point(w, -h);

    lfr.OuterBorder.Filler := llfl1;
    lfr.OuterBorder.EdgeWidth := 1;
    lfr.OuterBorder.EdgeColor := 13354434;

    llfl2 := TLMDLineFiller.Create;
    llfl2.ColorCount := 2;
    llfl2.UseRelativeUnits := true;
    llfl2.FixedColors[0] := 14275272;
    llfl2.FixedColors[1] := 16711422;
    llfl2.BasePoint := Point(0, 0);
    llfl2.VectorN := Point(w, h);
    llfl2.VectorT := Point(w, -h);

    lfr.InnerSpace.Filler := llfl2;
    lfr.InnerSpace.EdgeWidth := 0;

    llfl3 := TLMDLineFiller.Create;
    llfl3.ColorCount := 2;
    llfl3.UseRelativeUnits := true;
    llfl3.FixedColors[0] := 14341063;
    llfl3.FixedColors[1] := 16119027;
    llfl3.BasePoint := Point(0, 0);
    llfl3.VectorN := Point(w, h);
    llfl3.VectorT := Point(w, -h);

    lfr.InnerBorder.Filler := llfl3;
    lfr.InnerBorder.EdgeWidth := 0;

    br := lfr.ContentsRect;
    InflateRect(br, -2, -2);
    lfr.Draw(lbmp, br);

    aCanvas.Draw(x - r1, y - r1, lbmp);

    llfl1.Free;
    llfl2.Free;
    llfl3.Free;
    lefl.Free;
  end
  else
  begin
    if (FFillMode = fmClock) and (FFillObject.Style <> sfNone) then
    begin
      rgn := CreateEllipticRgn (x-r1, y - r1, x+r1, y+r1);
      SelectClipRgn (aCanvas.Handle, rgn);
      FFillObject.FillCanvas (aCanvas, Rect (x-r1, y - r1, x+r1, y+r1), Color);
      SelectClipRgn (aCanvas.Handle, 0);
      DeleteObject (rgn);
    end;
    if Style = csVista then
    begin
      aCanvas.Brush.Style := bsClear;
      aCanvas.Pen.Style := psSolid;
      aCanvas.Pen.Color := FFaceColors[3];
      aCanvas.Pen.Width := 7;
      aCanvas.Ellipse(x-r1+1, y-r1+1, x+r1-1, y+r1-1);
      aCanvas.Pen.Color := FFaceColors[2];
      aCanvas.Pen.Width := 4;
      aCanvas.Ellipse(x-r1, y - r1, x+r1, y+r1);
    end;
  end;

  h := 9;
  while i<360 do
  begin
    cs := cos(i*pi/180);
    sn := sin(i*pi/180);
    if i mod 30 =0 then
    begin
      case Style of
        csVista:
          r := round(r1*0.9);
        csWindows7:
          r := round(r1*0.75);
        else
          r := r1;
      end;
      PaintNormalScale(aCanvas,Point(x + round(r*sn), y - round(r*cs)),
                               Point(x + round(r3*sn), y - round(r3*cs)));
      if Style = csVista then
        PaintHourNumber(aCanvas, x, y, cs, sn, r3, h);
      dec(h);
      if(h = 0) then
        h := 12;
    end
    else
    begin
      case Style of
        csVista:
          r := round(r1*0.91);
        csWindows7:
          r := round(r1*0.85);
        else
          r := r1;
      end;
      PaintSmallScale(aCanvas,Point(x + round(r*sn), y - round(r*cs)),
                              Point(x + round(r2*sn), y - round(r2*cs)));
    end;

    inc(i, step);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.PaintDigital(ACanvas:TCanvas);
var
  px, py, w:integer;
  sText:String;

begin
  sText:=GetDigitalText;
  w:=FDigital.LEDWidth*Length(sText);
  if FDigitalOnly then
    begin
      px:=BevelExt;
      py:=BevelExt;
    end
  else
    begin
      {place them...}
      if (FPosy=-1) then py:=LMDMin([Width div 2, Height div 2]) else pY:=FPosY+BevelExt;
      if (fPosx=-1) then px:=round(width div 2 - (w div 2)) else px:=FPosX+BevelExt;
    end;
  FDigital.BackColor:=FDigitalColor;
  FDigital.PaintLED(aCanvas, Bounds(px, py, w, FDigital.LEDHEight), sText, Enabled, True);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.PaintHands(ACanvas :TCanvas);
const
  AxisRad=1;
  Rop=R2_Nop;
var
  x, y, r1, r2, r3, r4,r5: integer;
  cs, sn, cs1, sn1, cs2, sn2: real;
  fchr, fcmi, fcsc, fcms :word;
  points: array[0..2] of TPoint;

begin

  if BevelExt<=1 then fchr:=4 else fchr:=DblBevelExt;

  if coShowSecCircle in FOptions then inc (fchr, FCirclePen.Width);

  x := width div 2;
  y := height div 2;
  r1 := LMDMin([x,y])-fchr;
  case Style of
    csVista:
    begin
      r2 := round(0.6 * r1);
      r3 := round(0.85 * r1);
      r4 := round(0.85 * r1);
      r5 := round(0.05 * r1);
    end;
    csWindows7:
    begin
      r2 := round(0.6 * r1);
      r3 := round(0.72 * r1);
      r4 := round(0.8 * r1);
      r5 := round(0.1 * r1);
    end
    else
    begin
      r2 := round(0.5 * r1);
      r3 := round(0.6 * r1);
      r4 := round(0.7 * r1);
      r5 := round(0.1 * r1);
    end;
  end;
  with aCanvas do
    begin
      Pen.Style:=psSolid;
      if Enabled {and not (csDesigning in ComponentState)} then
        DecodeTime(GetTime ,fchr, fcmi, fcsc, fcms)
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
            if Style = csVista then
            begin
              cs1 := cos((360/12*fchr+0.5*fcmi-40)*pi/180);
              sn1 := sin((360/12*fchr+0.5*fcmi-40)*pi/180);
              cs2 := cos((360/12*fchr+0.5*fcmi+40)*pi/180);
              sn2 := sin((360/12*fchr+0.5*fcmi+40)*pi/180);
              Pen.Width := 1;
              points[0] := Point(x - round(r5*sn1), y + round(r5*cs1));
              points[1] := Point(x + round(r2*sn), y - round(r2*cs));
              points[2] := Point(x - round(r5*sn2), y + round(r5*cs2));
              Brush.Color := Pen.Color;
              Polygon(points);
            end
            else
            begin
              Pen.Width := Thickness;
              moveto(x - round(r5*sn), y + round(r5*cs));
              lineto(x + round(r2*sn), y - round(r2*cs));
            end;
          end;
      if FMinuteHand.Visible then
        with FMinuteHand do
          begin
            cs := cos(360/60*fcmi*pi/180);
            sn := sin(360/60*fcmi*pi/180);
            if Style = csVista then
            begin
              cs1 := cos((360/60*fcmi - 40)*pi/180);
              sn1 := sin((360/60*fcmi - 40)*pi/180);
              cs2 := cos((360/60*fcmi + 40)*pi/180);
              sn2 := sin((360/60*fcmi + 40)*pi/180);
              Pen.Width := 1;
              points[0] := Point(x - round(r5*sn1), y + round(r5*cs1));
              points[1] := Point(x + round(r3*sn), y - round(r3*cs));
              points[2] := Point(x - round(r5*sn2), y + round(r5*cs2));
              Brush.Color := Pen.Color;
              Polygon(points);
            end
            else
            begin
              Pen.Color := Color;
              Pen.Width := Thickness;
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
            if Style = csVista then
              r5 := r5 + 15;
            moveto(x - round(r5*sn), y + round(r5*cs));
            lineto(x + round(r4*sn), y - round(r4*cs));
            if Style in [csVista, csWindows7] then
              Ellipse(x - 2, y - 2, x + 2, y + 2);
          end;
      //
      if coShowSecCircle in FOptions then
        begin
          Pen.Assign (FCirclePen);
          inc(r1, 2 + FCirclePen.Width);
          cs := cos(360/60*fcsc*pi/180) * -1;
          sn := sin(360/60*fcsc*pi/180);
          if FOldSec > fcsc then
            FSecMode := 1 - FSecMode;
          case FSecMode of
            //remove (drawn circle piece by piece)
            0: Arc (x - r1, y - r1, x + r1, y + r1, x,0,  x+round(r1* sn), y+round(r1 * cs));
            //paint (circle piece by piece)
            1: if fcsc <> 0 then Arc (x - r1, y - r1, x + r1, y + r1, x+round(r1* sn), y+round(r1 * cs), x,0);
          end;
          FOldSec := fcsc;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.PaintNormalScale(ACanvas:TCanvas; p1,p2:TPoint);
const
  rsize=2;
begin
  with aCanvas do
    case FStyle of
      csSimple: begin
                  moveto(p1.x, p1.y);
                  lineto(p2.x, p2. y);
                end;
      csWIN95:  begin
                  Brush.Color := FFaceColors[2];
                  Brush.Style := bsSolid;
                  Pen.Color := FFaceColors[3];
                  Windows.Rectangle(Handle, p1.x+rsize, p1.y+rsize,  p1.x-rsize-1, p1.y-rsize-1);
                  Pen.Color := FFaceColors[4];
                  moveTo(p1.x-rsize-1, p1.y+rsize-1);
                  lineto(p1.x+rsize-1, p1.y+rsize-1);
                  lineto(p1.x+rsize-1, p1.y-rsize-1);
                end;
      csVista, csWindows7:
               begin
                  Pen.Width := 2;
                  Pen.Color := FFaceColors[2]; //big ticks
                  moveto(p1.x, p1.y);
                  lineto(p2.x, p2.y);
                end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.PaintHourNumber(ACanvas:TCanvas; x, y:integer; cs, sn: double; r:integer; aHour: integer);
var
  lx, ly: integer;
  s: string;
begin
  s := inttostr(aHour);
  lx := x - round(r*0.85*cs);
  ly := y + round(r*0.85*sn);
  with aCanvas do
  begin
    Font.Size := 10;
    Font.Name := 'Arial Narrow';
    Font.Color := Pen.Color;
    Font.Style := [fsBold];
    lx := lx - TextWidth(s) div 2;
    ly := ly - TextHeight(s) div 2;
    TextOut(lx, ly, s);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.PaintSmallScale(ACanvas :TCanvas; p1,p2:TPoint);
const
  rsize=2;
begin
  with ACanvas do
    case FStyle of
      csSimple:begin
                 moveto(p1.x, p1.y);
                 lineto(p2.x, p2.y);
               end;
      csWIN95: begin
                 Pen.Color := FFaceColors[0];
                 Brush.Color := FFaceColors[0];
                 Brush.Style := bsSolid;
                 Ellipse(p1.x+rsize, p1.y+rsize,  p1.x-rsize, p1.y-rsize);
                 Pen.Color := FFaceColors[1];
                 Brush.Color := FFaceColors[1];
                 Ellipse(p1.x-rsize, p1.y-rsize,  p1.x+ rsize-1, p1.y+rsize-1);
               end;
      csVista, csWindows7: begin
                 Pen.Color := FFaceColors[0]; //small tick
                 Windows.Rectangle(Handle, p1.x-1, p1.y-1,  p1.x+1, p1.y+1);
               end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.CMColorChanged(var Message: TMessage);
begin
  First:=True;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.CMEnabledChanged(var Message: TMessage);
begin
  FTimerIdent.Enabled:=Enabled;
  GetChange(nil);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDClock.CMLMDBACKCHANGED(var Message: TMessage);
begin
  exit;
  First := true;
  inherited;
end;}

{---------------------- protected ---------------------------------------------}
function TLMDClock.GetDigitalText:String;
var
  DigString : string;
  Hour, Min, Sec, MS : Word;
  D: TDateTime;
begin
  DigString := FDigitalString;
  if FUseCustomDT then
    DigString := FDateTimeFormat;
  if Enabled then
    case FClockMode of
      cmNormal:
        if co24Hour in Options then
          result:=FormatDateTime(DigString, GetTime)
        else
          result := FormatDateTime(DigString+' a/p', GetTime);
      cmDate:
        result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames[DayofWeek(GetTime)]+ ' '+DateToStr(GetTime);
      cmAlarm:
        if coEnableAlarm in FOptions then
          if co24Hour in Options then
            result := 'A '+ FormatDateTime(DigString, FAlarmtime)
          else
            result := 'A '+ FormatDateTime(DigString+' a/p', FAlarmtime)
        else
          if co24Hour in Options then
            result := 'NA '+ FormatDateTime(DigString, FAlarmtime)
          else
            result := 'NA '+ FormatDateTime(DigString+' a/p', FAlarmtime);
      cmStopwatch:
        begin
          if (FStopwatchenabled) and (FStopwatch<GetTime) then
            begin
              if FStopWatchPaused then
                D := FStopwatchPauseStart - FStopwatch - FStopwatchPausedTime
              else
                D := GetTime-FStopwatch - FStopwatchPausedTime
            end
          else
            D := FStopwatch;
          if FUseCustomDT then
            //added VB Oct 2008
            result := FormatDateTime(DigString, D)
          else
            result := 'S '+ TimeToStr(D);
        end;
      cmCountdown:
        if Countdown.Endtime>GetTime then
          begin
            D := FCountdown.Endtime-GetTime;
            DecodeTime (D, Hour, Min, Sec, MS);
            if FUseCustomDT then
              //added VB Oct 2008
              result := FormatDateTime(DigString, D)
            else
              result := 'C '+ Format('%.2d:%.2d:%.2d',[Hour,Min,Sec]);
            //result := 'C '+ TimeToStr(FCountdown.Endtime-GetTime)
          end
        else
          result := 'C 00:00:00';
     end
   else
     result:='--- NA ---';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.BoundsChange(State:TLMDBoundsChangeStates);
begin
  First:=True;
  inherited BoundsChange(State);
end;

{ ---------------------------------------------------------------------------- }
function TLMDClock.GetTime : TDateTime;
begin
  //return actual system time
  result := Now;
  //if fixed time then return this instead of the actual time
  if coFixed in FOptions then
    result := FFixedTime.DateTimeValue;
  //offset time to be returned ...
  if coOffset in FOptions then
    FTimeOffset.Offset (result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.GetIMLChange(Sender:TObject);
begin
  if not IMLEmpty then
    LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, FFillObject.ListBitmap)
  else
    FFillObject.ListBitmap:=nil;
  GetChange(FFillObject);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.GetChange(Sender:TObject);
begin
  if (Sender=FillObject) or (Sender=Bevel) or (Sender=nil) or (Sender is TLMDClockHand) then
  begin
    First:=True;
    FColorScheme := csUnknown;
  end;
  Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.Loaded;
begin
  inherited Loaded;
  if Enabled then Paint;
  FRepCount := FRepeat;//JH 21.05.99 (otherwise RepeatAlaram = 0 has no effect for the first time it is called)
  if Transparent then   First:=True;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.Paint;
var
  UsBitmap :TBitmap;
begin
  if not Visible then exit; //JH 21.05.99; clock only as invisible alarm object ...

  if FIsPainting or (csLoading in ComponentState) then exit;
  if FDigitalOnly and CorrectBounds then exit;

  if not ((Width > 0) and (Height > 0)) then exit; //added Oct 02, JH

  UsBitmap := TBitmap.Create;
  with UsBitmap do
    try
      FIsPainting:=True;
      Width:=Self.Width; //-1 removed 14.01.00 JH
      Height:=Self.Height;

      if FDigitalOnly then
        begin
          Bevel.PaintBevel(Canvas, ClientRect ,false);
          PaintDigital(Canvas);
        end
      else
        begin
          if First then
            begin
              First := false;
              Canvas.Brush.Color := Color;
              if CheckOptimized then
                BackDrawArea (UsBitmap.Canvas, Rect(0,0,Self.Width, Self.Height), Point(0,0), 0)
              else
                if (FFillMode = fmControl) and (FFillObject.Style <> sfNone) then
                  FFillObject.FillCanvas (Canvas, Rect(0,0, Width, Height), Color)
                else
                  Canvas.FillRect(Rect(0,0, Width, Height));
              if Transparent and not CheckOptimized then //try again next time
                First := true;
              Bevel.PaintBevel(Canvas, Rect(0,0, Width, Height), false);
              //paint ticks
              if coShowAnalog in Options then PaintAnalog(Canvas);
              //save the created bitmap (buffer it)
              FSaveBitmap.Assign(UsBitmap);
            end
          else
            if coShowAnalog in Options then
              Canvas.Draw(0,0, FSaveBitmap)
            else
              begin
                Canvas.Brush.Color := Color;
                Canvas.FillRect(Rect(0,0,Width, Height));
              end;

          if CoShowDigital in Options then
            PaintDigital(Canvas);

          if coShowAnalog in Options then
            PaintHands(Canvas);

        end;

      self.Canvas.Draw(0,0, UsBitmap);
    finally
      UsBitmap.Free;
      FIsPainting:=False;
    end;
end;

{---------------------- public ------------------------------------------------}
constructor TLMDClock.Create(aOwner:TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle-[csSetCaption];
//  DisableTransMode;

  {Create LED display}
  FDigital := TLMDLED.Create;
  FDigital.OnChange:=GetChange;
  FDigitalShowSecs:=True;
  FDigitalString:='hh:nn:ss';
  FPosY := -1;
  FPosx := -1;
  FDigitalColor:=clBlack;

  FFixedTime  := TLMDDateTime.Create;
  FTimeOffset := TLMDTimeOffset.Create;
  FFillObject := TLMdFillObject.Create;
  FFillObject.OnChange := GetChange;

  //init helpers for circle displaying of passed seconds
  FOldSec := -1;
  FSecMode := 0;
  FCirclePen := TPen.Create;
  FCirclePen.OnChange := GetChange;

  {Init hand properties}
  FHourHand:=TLMDClockHand.Create;
  with FHourHand do
    begin
      Thickness:=5;
      Color:=clAqua;
      OnChange:=Self.GetChange;
    end;

  FMinuteHand:=TLMDClockHand.Create;
  with FMinuteHand do
    begin
      Thickness:=3;
      Color:=clTeal;
      OnChange:=Self.GetChange;
    end;

  FSecondHand := TLMDClockHand.Create;
  with FSecondHand do
    begin
      Thickness := 1;
      OnChange := Self.GetChange;
    end;

  {Create countdown object}
  FCountdown := TLMDTimeInterval.Create;

  {Init timer}
  FTimerIdent:=TLMDTimer.Create(1000, OnTimer);

  {Setup clock mode and style}
  FClockMode := cmNormal;
  FStyle := csWin95;

  FDigitalOnly:=False;
  {Setup alarm time}
  FAlarmtime := EncodeTime(0,0,0,0);
  FAlarmtime := Date; {stay for today...}
  FAlarm := false;
  FRepeat := 10;  {alarm will be repeated ten times...}
  FRepCount := 10; {to restore old values after the alarm...}

  FSaveBitmap := TBitmap.Create;
  FOptions := [coShowAnalog, co24Hour];
  FUseCustomDT := False;
  FDateTimeFormat := 'hh:nn:ss';

  ColorScheme := csDefaultScheme;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDClock.Destroy;
begin
  {free them...}
  FreeAndNil(FTimerIdent);

  FreeAndNil(FCirclePen);

  FFillObject.OnChange := nil;
  FreeAndNil(FFillObject);
  FreeAndNil(FFixedTime);
  FreeAndNil(FTimeOffset);

  FCountDown.OnChange:=nil;
  FDigital.OnChange:=nil;
  FHourHand.OnChange:=nil;
  FMinuteHand.OnChange:=nil;
  FSecondHand.OnCHange:=nil;
  FreeAndNil(FCountdown);
  FreeAndNil(FDigital);
  FreeAndNil(FHourHand);
  FreeAndNil(FMinuteHand);
  FreeAndNil(FSecondHand);
  FreeAndNil(FSaveBitmap);

  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.BackUpdate;
begin
  First := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.OnTimer(Sender:TObject);

  //-1 = (d1 > d2); 0 = (d1 = d2); 1 = (d1 < d2)
  function compareDates (d1, d2 : TDateTime) : Integer;
  begin
    result := 0; //equal
    if int(d1) < int(d2) then begin result := 1; exit; end;
    if int(d1) > int(d2) then begin result := -1; exit; end;

    //year, month, day ok
    if frac(d1) < frac(d2) then begin result := 1; exit; end;
    if frac(d1) > frac(d2) then begin result := -1; exit; end;
  end;

begin

  if (csDesigning in ComponentState) then exit;

  {Check countdown...}
  if FCountdown.Enabled then
    if (compareDates (GetTime, FCountDown.EndTime) <= 0) and (Enabled) then
      begin
        EndCountdown;
        if (coEnableAlarm in Options) then Alarm;
      end;

  {Check for repeat alarm}
  if FAlarm then
    begin
      Dec(FRepcount);
      Paint;
      if FRepeat <> 0 then  //added 21.05. otherwise the alarm will be executed twice
        Alarm;
      if frepcount<=0 then
        begin
          EndAlarm;
          fRepcount := FRepeat;
        end;
        exit;
     end
   else
     if (FClockMode=cmAlarm) and (coEnableAlarm in Options) and
        (compareDates (GetTime, FAlarmtime) <= 0) then Alarm;

  Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.Alarm;
begin
  FAlarm:=True;
  fDigital.BeginFlash;
  if Assigned(FOnAlarm) then FOnAlarm(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.EndAlarm;
begin
  fDigital.EndFlash;
  Mode := cmNormal;
  FAlarm := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.StartStpWatch;
begin
  FClockMode := cmStopwatch;
  FStopWatchEnabled:=True;
  FStopwatch := GetTime;
  FStopwatchPausedTime := 0;
  FStopwatchPaused := False;
  if Assigned(FOnStopWatchStart) then FOnStopWatchStart(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.PauseStpWatch;
begin
  if not FStopWatchPaused then
    begin
      FStopWatchPaused := True;
      FStopwatchPauseStart := GetTime;
      if Assigned(FOnStopWatchPause) then FOnStopWatchPause(Self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.ResumeStpWatch;
begin
  if FStopWatchPaused then
    begin
      FStopWatchPaused := False;
      FStopwatchPausedTime := FStopwatchPausedTime + GetTime - FStopwatchPauseStart;
      if Assigned(FOnStopWatchResume) then FOnStopWatchResume(Self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.EndStpWatch;
begin
  FStopwatchenabled := false;
  try
    if GetTime > FStopwatch then
      FStopwatch := GetTime - FStopwatch - FStopwatchPausedTime
    else
      FStopwatch := 0.0;
  except
    on Exception do
      raise EConvertError.Create(SInvalidTime);
  end;
  if Assigned(FOnStopWatchEnd) then FOnStopWatchEnd(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.StartCountdown;
begin
  FCountdown.Enabled :=True;
  FClockMode := cmCountdown;
  if Assigned(FOnCountdownStart) then FOnCountdownStart(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClock.EndCountdown;
begin
  FCountdown.Enabled := False;
  FClockMode := cmNormal;
  if Assigned(FOnCountdownEnd) then FOnCountdownEnd(Self);
end;

end.

