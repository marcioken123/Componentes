unit LMDAniCtrl;
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

LMDAniCtrl unit (RM)
--------------------

Animation component. Will display a list of images as fluent animation.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Graphics,
  Messages,
  Classes,
  LMDBase,
  LMDClass,
  LMDTimer,
  LMDCustomLImage;

type
  {3.0}
  TLMDAnimationStyle=(asLoop,           {loop animation}
                      asLoopHide,       {loop animation, hide ctrl when stopped}
                      asLoopReverse,    {loop and flip direction}
                      asRepeat,           {play animation 'repetitions' times, last picture is shown}
                      asRepeatFirst,      {play animation 'repetitions' times, first picture is shown}
                      asRepeatHide);      {play animation 'repetitions' times, hide ctrl then}

  {--------------------------- TLMDAniCtrl ------------------------------------}
  TLMDAniCtrl=class(TLMDCustomLImage)
  private
    {Background}
    FBack:TBitmap;
    FRestore:Boolean;
    FMakeVisible,
    FForward,           {internal, current direction}
    FUseBitmap,
    FReverse,
    FPlaying:Boolean;   {are we currently playing?}
    FInterval:TLMDTimerInterval;
    FAniStyle:TLMDAnimationStyle;
    FStartFrame, FStopFrame:Integer;
    FRepeat, FCounter:Byte;
    FTimerId:TLMDTimer;
    //4.0
    FTimerMode:TLMDTimerMode;
    FTimer:TLMDHiTimer;
    FThreadPriority:TThreadPriority;
    //--
    FOnStart,
    FOnAnimate,
    FOnStop:TNotifyEvent;

    procedure SetAniStyle(aValue:TLMDAnimationStyle);
    procedure SetBool(Index:Integer; aValue:Boolean);
    procedure SetInterval(aValue:TLMDTimerInterval);
    procedure SetRepetitions(aValue:Byte);
    procedure SetStartFrame(aValue:Integer);
    procedure SetStopFrame(aValue:Integer);
    procedure SetThreadPriority(aValue:TThreadPriority);
    procedure SetTimerMode(aValue:TLMDTimerMode);
    procedure GetTimer(Sender:TObject);
    function  GetCurrentFrame:Integer;
    function  GetFirstFrame:Integer;
    function  GetLastFrame:Integer;
    //4.0
    procedure ActivateTimer;
    procedure DeActivateTimer(aValue:TLMDTimerMode);
    procedure EnableTimer(aValue:Boolean);
    //--
    procedure CMTRANSPARENTCHANGED(var Message: TMessage); message CM_TRANSPARENTCHANGED;
  protected
    procedure BoundsChange(State:TLMDBoundsChangeStates);override;
    function GetEmpty:Boolean;override;
    procedure GetIMLChange(Sender:TObject);override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure PaintImage(f:Boolean);
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Invalidate;override;
    procedure BackUpdate;override;
    {Play/Stop -Routines}
    procedure Play;
    procedure Stop;

    {Movement-Routines}
    procedure First;
    procedure Last;
    procedure Move(aValue:Integer);
    procedure Next;
    procedure Prev;

    property Current:Integer read GetCurrentFrame;
  published
    property Animate:Boolean index 0 read FPlaying write SetBool stored false;
    property AnimationStyle:TLMDAnimationStyle read FAniStyle write SetAniStyle default asLoop;
    property Bevel;
    property MakeVisible:Boolean index 1 read FMakeVisible write SetBool default True;
    property Interval:TLMDTimerInterval read FInterval write SetInterval default 200;
    property Repetitions:Byte read FRepeat write SetRepetitions default 1;
    property Reverse:Boolean index 3 read FReverse write SetBool default false;
    property StartFrame:Integer read FStartFrame write SetStartFrame;
    property StopFrame:Integer read FStopFrame write SetStopFrame;
    property UseBitmap:Boolean index 2 read FUseBitmap write SetBool default True;

    {enthalten}
    property ForceTransparent default True;
    property ImageList;
    property ListIndex;
    property SilentMove;
    property Style;
    property Transparent default false;

    // NEW from 4.0
    property TimerMode:TLMDTimerMode read FTimerMode write SetTimerMode default tmNormal;
    property ThreadPriority:TThreadPriority read FThreadPriority write SetThreadPriority default tpNormal;

    {events}
    property OnStart:TNotifyEvent read FOnStart write FOnStart;
    property OnAnimate:TNotifyEvent read FOnAnimate write FOnAnimate;
    property OnStop:TNotifyEvent read FOnStop write FOnStop;
  end;

implementation

uses
  Types, Consts, SysUtils,
  LMDCustomControl, LMDProcs, LMDGraphUtils, LMDCont;

{------------------------- Private---------------------------------------------}
procedure TLMDAniCtrl.SetAniStyle(aValue:TLMDAnimationStyle);
begin
  if aValue<>FAniStyle then
    begin
      Stop;
      FAniStyle:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.SetBool(Index:Integer; aValue:Boolean);
begin
  case Index of
    0: if aValue<>FPlaying then
         if aValue then Play else Stop;
    1: FMakeVisible:=aValue;
    2: If FUseBitmap<>aValue then
         begin
           FUseBitmap:=aValue;
           GetChange(nil);
         end;
    3: begin
         Stop;
         FReverse:=aValue;
       end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.SetInterval(aValue:TLMDTimerInterval);
begin
  if aValue<>FInterval then
    if csLoading in ComponentState then
      FInterval:=aValue
    else
      begin
        Stop;
        FInterval:=aValue;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.SetRepetitions(aValue:Byte);
begin
  if (aValue<>FRepeat) and (aValue>0) then
    begin
      Stop;
      FRepeat:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.SetStartFrame(aValue:Integer);
var
  i,j:Integer;
begin
  if csLoading in ComponentState then
    FStartFrame:=aValue
  else
    begin
      if GetEmpty then
        FStartFrame:=0
      else

        if (FStartFrame<>aValue) and ((aValue>=0) and (aValue<=LMDIMLCount(ImageList, ListIndex))) then
          begin
            Stop;
            i:=aValue;j:=FStopFrame;
            FStartFrame:=LMDMin([i,j]);
            FStopFrame:=LMDMax([i,j]);
            Move(aValue);
          end;
       InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.SetStopFrame(aValue: Integer);
var
  i,j:Integer;
begin
  if csLoading in ComponentState then
    FStopFrame:=aValue
  else
    begin
      if GetEmpty then
        FStopFrame:=0
      else

        if (FStopFrame<>aValue) and ((aValue>=0) and (aValue<=LMDIMLCount(ImageList, ListIndex))) then
          begin
            Stop;
            i:=aValue;j:=FStartFrame;
            FStartFrame:=LMDMin([i,j]);
            FStopFrame:=LMDMax([i,j]);
            SetImageIndex(FStartFrame);
          end;
       InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.SetThreadPriority(aValue:TThreadPriority);
begin
  if aValue<>FThreadPriority then
    begin
      FThreadPriority:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.SetTimerMode(aValue:TLMDTimerMode);
begin
  if FTimerMode<>aValue then
    if csLoading in ComponentState then
      FTimerMode:=aValue
    else
      begin
        Stop;
        DeactivateTimer(FTimerMode);
        FTimerMode:=aValue;
        ActivateTimer;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDAniCtrl.GetFirstFrame;
begin
  if FReverse then result:=FStopFrame else result:=FStartFrame;
end;

{------------------------------------------------------------------------------}
function TLMDAniCtrl.GetLastFrame;
begin
 if FReverse then result:=FStartFrame else result:=FStopFrame;
end;

{------------------------------------------------------------------------------}
function TLMDAniCtrl.GetCurrentFrame;
begin
  result:=ImageIndex;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.GetTimer(Sender:TObject);
begin

  if not FPlaying then exit;

  if GetEmpty or not Visible then
    begin
      Stop;
      Exit;
    end;

  if FForward then
    begin
      if ImageIndex=FStopFrame then
        case FAniStyle of
          asLoop, asLoopHide:SetImageIndex(FStartFrame);
          asLoopReverse:FForward:=false;
          asRepeat:
            if FCounter<Pred(FRepeat) then
              begin
                Inc(FCounter);
                SetImageIndex(FStartFrame);
              end
            else
              begin Stop; exit; end;
        else
          begin Stop; exit; end;
        end
      else
        SetImageIndex(ImageIndex+1);
    end
  else
    begin
      if ImageIndex=FStartFrame then
        case FAniStyle of
          asLoop, asLoopHide:SetImageIndex(FStopFrame);
          asLoopReverse:FForward:=True;
          asRepeat:
            if FCounter<Pred(FRepeat) then
              begin
                Inc(FCounter);
                SetImageIndex(FStopFrame);
              end
            else
              begin Stop; exit; end;
        else
          begin Stop; exit; end;
        end
      else
        SetImageIndex(ImageIndex-1);
    end;

  if Transparent and not UseBitmap then
    Invalidate
  else
    PaintImage(True);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.ActivateTimer;
begin
  case FTimerMode of
    tmNormal, tmGlobalTimer:
      FTimerId:=TLMDTimer.Create(FInterval, GetTimer, false, (FTimerMode=tmGlobalTimer));
    tmThreaded, tmHiTimer:
       begin
         FTimer:=TLMDHiTimer.Create(self);
         FTimer.OnTimer:=GetTimer;
         FTimer.UseThread:=FTimerMode=tmThreaded;
       end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.DeActivateTimer(aValue:TLMDTimerMode);
begin
  case aValue of
    tmNormal, tmGlobalTimer:
      if Assigned(FTimerID) then
        FreeAndNil(FTimerID);
    tmThreaded, tmHiTimer:
       begin
         If Assigned(FTimer) then FTimer.Free;
         FTimer:=nil;
       end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.EnableTimer(aValue:Boolean);
begin
  case FTimerMode of
    tmNormal, tmGlobalTimer:
      begin
        if aValue then FTimerId.Interval:=FInterval;
        FTimerId.Enabled:=aValue;
      end;
    tmThreaded, tmHiTimer:
      begin
        if aValue then
          begin
            FTimer.Interval:=FInterval;
            FTimer.ThreadPriority:=FThreadPriority;
          end;
        FTimer.Enabled:=aValue;
      end;
   end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.CMTRANSPARENTCHANGED(var Message: TMessage);
begin
  if Transparent then
    FBack:=TBitmap.Create
  else
    if Assigned(FBack) then
      begin
        FBack.Free;
        FBack:=nil
      end;
  inherited;
end;

{------------------------ Protected -------------------------------------------}
procedure TLMDAniCtrl.BoundsChange(State:TLMDBoundsChangeStates);
begin
  inherited BoundsChange(State);
  if Transparent then FRestore:=True;
end;

{------------------------------------------------------------------------------}
function TLMDAniCtrl.GetEmpty:Boolean;
begin
  result:=not ((ImageList<>nil) and (LMDIMLCount(ImageList, ListIndex)>0) and
              LMDIMLIsValidItem(ImageList, ListIndex, ImageIndex));
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.GetIMLChange(Sender:TObject);
begin
  if not (csLoading in ComponentState) then
    begin
      FStartFrame:=0;
      FStopFrame:=0;
      if not GetEmpty then
        FStopFrame:=Pred(LMDIMLCount(ImageList, ListIndex));
    end;
  SetImageIndex(GetFirstFrame);
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.Invalidate;
begin
  inherited Invalidate;
  if Transparent then FRestore:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.BackUpdate;
begin
  if Transparent or SilentMove then Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.Loaded;
begin
  inherited Loaded;
  if FTimerMode<>tmNormal then
    begin
     DeActivateTimer(tmNormal);
     ActivateTimer;
    end;
  SetImageIndex(GetFirstFrame);
  if FPlaying then Play;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.Move(aValue:Integer);
begin
  if FPlaying or GetEmpty then exit;
  if (aValue>=FStartFrame) and (aValue<=FStopFrame) then
    begin
      SetImageIndex(aValue);
      PaintImage(True);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.Paint;
begin
  if (csLoading in ComponentState) or CorrectBounds then exit;

  if not Transparent and not SilentMove then FillControl;

  if GetEmpty and (BevelExt=0) then
    begin
      inherited Paint;
      exit;
    end;

  if Transparent and FRestore then
    begin
      {Version 3.10}
      if CheckOptimized then
        begin
          FBack.Width:=Width;
          FBack.Height:=Height;
          BackDrawArea(FBack.Canvas, ClientRect, Point(0,0));
        end
      else
        LMDBmpFromDesktop(FBack, GetScreenRect(Bevel.PaintBevel(Canvas, GetClientRect, false)));
      FRestore:=False;
    end;

  Bevel.PaintBevel(Canvas, GetClientRect, false);
  PaintImage(false);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.PaintImage(f:Boolean);
var
  flags:Word;
  aRect:TRect;
  t:TBitmap;

  procedure Fillc;
  begin
    with Canvas do
      begin
        Brush.Style := bsSolid;
        Brush.Color := Color;
        pen.Style:=psClear;
        FillRect(aRect);
      end;
  end;

begin

  if GetEmpty then exit;

  aRect:=BeveledRect;
  flags:=0;
  if ForceTransparent then flags:=flags+DSF_TRANSPARENCY;
  AddStyleFlags(flags);

  if f then if Assigned(FOnAnimate) then FOnAnimate(self);

  if Transparent and not SilentMove then
    begin
      if FUseBitmap then
        begin
           t:=TBitmap.Create;
           try
             t.Width:=aRect.Right-aRect.Left;
             t.Height:=aRect.Bottom-aRect.Top;
             t.Canvas.CopyRect(Rect(0,0, t.Width, t.Height), FBack.Canvas,
                               Bounds(aRect.Left, aRect.Top, t.Width, t.Height));
             LMDIMLClipDraw(t.Canvas, Rect(0,0,t.Width, t.Height), flags, 0,
                             LMDIMLTransparentColor(ImageList, ListIndex, ImageIndex),
                             ImageList, ListIndex, ImageIndex);

             if not QuickDraw then
               begin
                 SelectPalette(Canvas.Handle, t.Palette, True);
                 RealizePalette(Canvas.Handle);
               end;

             Canvas.Draw(aRect.Left, aRect.Top, t);
           finally
             t.Free;
           end;
        end
      else
        begin
          if not QuickDraw then
            begin
              SelectPalette(Canvas.Handle, LMDIMLPalette(ImageList, ListIndex), True);
              RealizePalette(Canvas.Handle);
            end;
            LMDIMLClipDraw(Canvas, aRect, flags, MakeLong(Left, Top),
                       LMDIMLTransparentColor(ImageList, ListIndex, ImageIndex),
                       ImageList, ListIndex, ImageIndex);
        end;
    end
  else
    begin
      if (LMDIMLMasked(ImageList,ListIndex) or FForceTransparent) then
        begin
          if FUseBitmap then
            begin
              t:=TBitmap.Create;
              try
                if SilentMove and CheckOptimized then
                  begin
                    t.Width:=aRect.Right-aRect.Left;
                    t.Height:=aRect.Bottom-aRect.Top;
                    BackDrawArea(t.Canvas, Rect(0,0, t.Width, t.Height), Point(aRect.Left,aRect.Top));
                  end
                else
                  LMDBmpCreateFromRect(t, aRect, Color);
                  LMDIMLClipDraw(t.Canvas, Rect(0,0, t.Width, t.Height), flags, 0,
                                LMDIMLTransparentColor(ImageList, ListIndex, ImageIndex),
                                ImageList, ListIndex, ImageIndex);

                if not QuickDraw then
                  begin
                    SelectPalette(Canvas.Handle, t.Palette, True);
                    RealizePalette(Canvas.Handle);
                  end;

                Canvas.Draw(aRect.Left, aRect.Top, t);
              finally
                t.Free;
              end;
              exit;
            end
          else
            begin
              if SilentMove and CheckOptimized then
                BackDrawArea(Canvas, aRect, Point(aRect.Left,aRect.Top))
              else
                Fillc;
            end;
          end
        else
          Fillc;

        try
          if not QuickDraw then
            begin
              SelectPalette(Canvas.Handle,  LMDIMLPalette(ImageList,ListIndex), True);
              RealizePalette(Canvas.Handle);
            end;
          LMDIMLClipDraw(Canvas, aRect, flags, MakeLong(Left, Top),
                         LMDIMLTransparentColor(ImageList, ListIndex, ImageIndex),
                         ImageList, ListIndex, ImageIndex);
        except
          on exception do exit;
        end;
    end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDAniCtrl.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  DisableTransMode;

  FAniStyle:=asLoop;
  FCounter:=0;
  FRepeat:=1;
  FPlaying:=False;
  FMakeVisible:=True;
  FInterval:=200;
  FForceTransparent:=True;

  FUseBitmap:=True;
  FRestore:=False;
  FBack:=nil;

  //4.0
  FThreadPriority:=tpNormal;
  FTimerMode:=tmNormal;
  ActivateTimer;
end;

{------------------------------------------------------------------------------}
Destructor TLMDAniCtrl.Destroy;
begin
  Stop;
  {free timer...}
  DeActivateTimer(FTimerMode);
  if Assigned(FBack) then FBack.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.Play;
begin

  if (csLoading in ComponentState) or GetEmpty then exit;
  if FPlaying then Stop;

  {if not visible - exit, except FMakeVisible is set...}
  if not Visible then
    if not FMakeVisible then exit else Visible:=True;

  FForward:=not FReverse;
  FCounter:=0;

  SetImageIndex(GetFirstFrame);
  FPlaying:=True;
  if Assigned(FOnStart) then FOnStart(Self);
  PaintImage(True);
  EnableTimer(True);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.Stop;
begin
  if not FPlaying then exit;
  EnableTimer(False);
  FCounter:=0;
  FPlaying:=False;
  if csDestroying in ComponentState then exit;

  case FAniStyle of
    asLoopHide,
    asRepeatHide:if not (csDesigning in ComponentState) then Visible:=false;
    asRepeatFirst, asLoop, asLoopReverse:
      begin
        SetImageIndex(GetFirstFrame);
        PaintImage(True);
      end;
  end;

  if Assigned(FOnStop) then FOnStop(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.First;
begin
  Move(GetFirstFrame);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.Last;
begin
  if not GetEmpty then
   Move(GetLastFrame);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.Next;
begin
  if FReverse then Move(ImageIndex-1) else Move(ImageIndex+1);
end;

{------------------------------------------------------------------------------}
procedure TLMDAniCtrl.Prev;
begin
  if FReverse then Move(ImageIndex+1) else Move(ImageIndex-1);
end;

end.
