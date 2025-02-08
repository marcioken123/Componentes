unit LMDTextCustomScroll;
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

LMDTextCustomScroll unit (JH)
-----------------------------

Scrolling formatted text 

ToDo
----

Large Texts, scrolling left to right or vice versa causes to start scrolling on 
the half way done ...

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Graphics,
  LMDTimer,
  LMDClass,
  LMDGraph,
  LMDTextPanel,
  LMDTextObject;

type
  TLMDTextScrollMode = (tmTopDown, tmBottomUp, tmLeftRight, tmRightLeft);
  TLMDTextScrollStyle = (tsOnce, tsLoop, tsLoopReverse);
  TLMDTextScrollStartPos = (spHidden, spCentered, spFull);

  TLMDTextCustomScroll = class (TLMDTextPanel)
  private
    FTimerID     : Word;
    FRestart,               //internal variable for differentiating between
                            //start and restart
    FScroll      : Boolean;
    FScrollStep,
    FScrollDelay : Integer;
    FScrollStyle : TLMDTextScrollStyle;
    FScrollingMode,         //actual scrolling direction
    FScrollMode  : TLMDTextScrollMode;
    FScrolled    : TPoint;  //actual scroll offset
    FHelpBmp     : TBitmap; ////blit bitmap, sized with control size
    FTextRect,              //area in control where text can be drawn
    FTDimens     : TRect;   //dimension of text to be scrolled

    FTimerMode   : TLMDTimerMode;
    FTimer       : TLMDHiTimer;
    FThreadPriority : TThreadPriority;
    FTStartPos   : TLMDTextScrollStartPos;

    procedure SetThreadPriority(aValue:TThreadPriority);
    procedure SetTimerMode(aValue:TLMDTimerMode);

    procedure SetScrollMode (aValue : TLMDTextScrollMode);
    procedure SetScroll (aValue : Boolean);
  protected
    procedure Scroll;
    procedure EndScroll;
    procedure DoStep (Sender : TObject);
    procedure DrawCaption(aRect:TRect; aAlignment:TLMDAlignment); override;
    procedure DrawState(const aRect : TRect);
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure Start;
    procedure Execute;
    procedure Stop;
    procedure SetStartPos(aValue: TLMDTextScrollStartPos);
  published
    property Active : Boolean read FScroll write SetScroll default false;
    property Mode : TLMDTextScrollMode read FScrollMode write SetScrollMode default tmBottomUp;
    property Style : TLMDTextScrollStyle read FScrollStyle write FScrollStyle default tsLoop;
    property Interval : Integer read FScrollDelay write FScrollDelay default 100;
    property Step : Integer read FScrollStep write FScrollStep default 1;
    property TimerMode:TLMDTimerMode read FTimerMode write SetTimerMode default tmGlobalTimer;
    property ThreadPriority:TThreadPriority read FThreadPriority write
                            SetThreadPriority default tpNormal;
  end;

implementation

uses
  LMDProcs;

function LMDMax (x1, x2 : Integer) : Integer;
begin
  result := x1;
  if x1 < x2 then
    result := x2;
end;

{ -------------------------------- private ----------------------------------- }
procedure TLMDTextCustomScroll.SetScrollMode (aValue : TLMDTextScrollMode);
begin
  if aValue <> FScrollMode then
    begin
      EndScroll;

      FScrollMode := aValue;

      //backup the current scroll mode
      FScrollingMode := FScrollMode;

      if FScroll then Scroll;

    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.SetScroll (aValue : Boolean);
begin
  if aValue <> FScroll then
    begin
      FScroll := aValue;
      FRestart := false;
      if FScroll then Scroll else EndScroll;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.SetThreadPriority(aValue:TThreadPriority);
begin
  if aValue <> FThreadPriority then
    FThreadPriority := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.SetTimerMode(aValue:TLMDTimerMode);
begin
  if FTimerMode <> aValue then
    if csLoading in ComponentState then
      FTimerMode := aValue
    else
      begin
        Stop;
        FTimerMode := aValue;
      end;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDTextCustomScroll.Scroll;
var
  aRect : TRect;
  UseStartPos: TLMDTextScrollStartPos;
begin
  //stop any running scrolling process
  //EndScroll will do the check whether there is something to stop or not
  EndScroll;

  //reset scrolling position
  FScrolled := Point(0, 0);

  aRect := FTextRect;
  OffsetRect (aRect, -aRect.Left, -aRect.Top);

  //calculate dimensions of the text to be scrolled
  FTDimens := TextSettings.GetClientRect(Canvas, aRect, Font, false, true);

  if FRestart then
    UseStartPos := spHidden
  else
    UseStartPos := FTStartPos;

  //the text bmp will be moved over the client bmp!!
  //set scrolling start position according to the srolling mode
  case FScrollingMode of
    tmBottomUp  : begin
                    case UseStartPos of
                      spHidden  : FScrolled.Y := FTextRect.Bottom;
                      spCentered: FScrolled.Y :=
                                  ((FTextRect.Bottom - FTextRect.Top) -
                                   (FTDimens.Bottom - FTDimens.Top)) div 2 +
                                   (FTextRect.Top);
                      spFull    : begin
                                    FScrolled.X := 0;
                                    if FTextRect.Bottom - FTDimens.Bottom > 0 then
                                      FScrolled.Y := FTextRect.Bottom - FTDimens.Bottom
                                    else
                                      FScrolled.Y := 0;
                                  end;
                    end;
                  end;
    tmLeftRight : begin
                    case UseStartPos of
                      spHidden  : FScrolled.X := -FTDimens.Right;
                      spCentered: FScrolled.X :=
                                  ((FTextRect.Right - FTextRect.Left) -
                                   (FTDimens.Right - FTDimens.Left)) div 2 +
                                   (FTextRect.Left);
                      spFull    : begin
                                    FScrolled.X := 0;
                                    FScrolled.Y := 0;
                                  end;
                    end;

                  end;
    tmTopDown   : begin
                    case UseStartPos of
                      spHidden  : FScrolled.Y := -FTDimens.Bottom;
                      spCentered: FScrolled.Y :=
                                  ((FTextRect.Bottom - FTextRect.Top) -
                                   (FTDimens.Bottom - FTDimens.Top)) div 2 +
                                   (FTextRect.Top);
                      spFull    : begin
                                    FScrolled.X := 0;
                                    FScrolled.Y := 0;
                                  end;
                    end;

                  end;
    tmRightLeft : begin
                    case UseStartPos of
                      spHidden  : FScrolled.X := FTextRect.Right;
                      spCentered: FScrolled.X :=
                                  ((FTextRect.Right - FTextRect.Left) -
                                   (FTDimens.Right - FTDimens.Left)) div 2 +
                                   (FTextRect.Left);
                      spFull    : begin
                                    if FTextRect.Right - FTDimens.Right > 0 then
                                      FScrolled.X := FTextRect.Right - FTDimens.Right
                                    else
                                      FScrolled.X := 0;
                                    FScrolled.Y := 0;
                                  end;
                    end;

                  end;
  end;

  //fetch a timer
  case FTimerMode of
    tmGlobalTimer : begin //fetch a global timer
                      FTimerId := LMDApplication.AddTimer (FScrollDelay, DoStep);
                      LMDApplication.Timer [FTimerId].Enabled := true;
                    end;
    tmThreaded,
    tmHiTimer     : begin //create a timer
                      FTimer := TLMDHiTimer.Create(self);
                      FTimer.OnTimer := DoStep;
                      FTimer.UseThread := FTimerMode=tmThreaded;
                      FTimer.Interval := FScrollDelay;
                      FTimer.Enabled := true;
                    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.EndScroll;
begin
  //check whether there is an active timer, if not do nothing and exit
  if ((FTimerId = 0) and (FTimerMode = tmGlobalTimer)) or
     ((FTimer = nil) and (FtimerMode <> tmGlobalTimer)) then exit;
  //remove timer
  case FTimerMode of
    tmGlobalTimer : begin
                      LMDApplication.Timer [FTimerId].Enabled := false;
                      LMDApplication.RemoveTimer (FTimerId);
                      FTimerId := 0;
                    end;
    tmThreaded,
    tmHiTimer     : begin
                      If Assigned(FTimer) then FTimer.Free;
                      FTimer:=nil;
                    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.DoStep (Sender : TObject);

        procedure restart;
        begin
          FRestart := true;
          //check for restart mode
          if FScrollStyle = tsLoopReverse then
            begin
              //turn direction accroding to old scrollmode
              case FScrollingMode of
                tmBottomUp : FScrollingMode := tmTopDown;
                tmLeftRight : FScrollingMode := tmRightLeft;
                tmTopDown : FScrollingMode := tmBottomUp;
                tmRightLeft : FScrollingMode := tmLeftRight;
              end;
            end;
          if FScrollStyle = tsOnce then
            Stop //do not restart
          else
            Scroll; //restart
        end;

begin
  //the text bmp will be moved over the client bmp!!
  case FScrollingMode of
    tmBottomUp : dec (FScrolled.Y, FScrollStep);
    tmLeftRight : inc (FScrolled.X, FScrollStep);
    tmTopDown : inc (FScrolled.Y, FScrollStep);
    tmRightLeft : dec (FScrolled.X, FScrollStep);
  end;
  //draw current scroll step
  DrawState (GetClientRect);
  //check whether scrolling borders are reached
  case FScrollingMode of //if we leave away the = the text will defintely move completely out of the visible are before it is restartet!
    tmTopDown: if FScrolled.y > FTextRect.Bottom then restart;
    tmRightLeft : if FScrolled.x <= -FTDimens.Right then restart;
    tmBottomUp  : if FScrolled.y <= -FTDimens.Bottom then restart;
    tmLeftRight : if FScrolled.x >= (FTDimens.Right+ FTextRect.Right) then restart;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.DrawCaption(aRect:TRect; aAlignment:TLMDAlignment);
begin
  //just draw an image of the text
  DrawState(aRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.DrawState(const aRect : TRect);
var
//  cRect,
  bRect : TRect;
//  B:TBitmap;
  myFont: TFont;
begin
  myFont := TFont.Create;
  try
    myFont.Assign(self.Font);
    myFont.Color := GetThemedTextColor;
    Canvas.Font  := myFont;

    //fill the background of help bitmap with the control's background
    if not BackDrawArea(FHelpBmp.Canvas, FTextRect, Point(0,0), 0) then
    begin
      FHelpBmp.Canvas.Brush.Color := GetThemedBkColor;
      FHelpBmp.Canvas.Brush.Style := bsSolid;
      FHelpBmp.Canvas.FillRect(FTextRect);
    end;
    //fetch the control's rect
    bRect := FTextRect;
    //make the bRect (controls paintable area rect) (0,0) based
    //the bRect will be positioned as view above the text bitmap, which is (0,0)
    //based (naturally)
    OffsetRect(bRect, -bRect.Left, -bRect.Top);

  {  b := TBitmap.Create;
    b.Width := bRect.Right;
    b.Height := bRect.Bottom;}

    //move the control's rect on the approbiate position above the text bitmap
    OffSetRect(bRect, FScrolled.x, FScrolled.y);
    //draw a rect of the text bitmap on the help bitmap

    //otherwise we would try to paint non existing bmp areas -> resulting into white spaces

  //   OffSetRect (cRect, FTextRect.Left, FTextRect.Top);

     //problem occuring here: bitmaps will be mapped correctly, but parts of the
     //backgroundimage not covered by scrolling text parts will be white

  //  IntersectRect (bRect, bRect, Rect (0,0,FTextBmp.Width, FTextBmp.Height));

    //b.Canvas.CopyRect (Rect (0,0,b.Width, b.Height), FTextBmp.Canvas, bRect);

    TextSettings.Render(FHelpBmp.Canvas, FTextRect, bRect.TopLeft, myFont, clWhite, false, true);

  //  LMDBmpDrawExt(FHelpBmp.Canvas, FTextRect, FTextBmp.Canvas, bRect, DSF_TRANSPARENCY, clWhite, 0, nil);

  //  FHelpBmp.Canvas.CopyRect (FTextRect, FTextBmp.Canvas, bRect);
  ///  Canvas.CopyMode := cmSrcAND;
    //draw the help bitmap on the control's canvas;
    Canvas.CopyRect(FTextRect, FHelpBmp.Canvas, FTextRect);
    //Canvas.Draw (FTextRect.Left, FTextRect.Top, FHelpBmp);
  finally
    myFont.Free;
  end;
end;

{ -------------------------------- public ------------------------------------ }
constructor TLMDTextCustomScroll.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  //initialize the component's variables with default values
  FScroll := false;
  FScrollStep := 1;
  FScrollDelay := 100;
  FTimerId := 0;
  FTimer := nil;
  FTimerMode := tmGlobalTimer;
  FThreadPriority := tpNormal;
  FScrolled := Point (0,0);
  FScrollMode := tmBottomUp;
  FScrollingMode := FScrollMode;
  FHelpBmp := TBitmap.Create;
  FScrollStyle := tsLoop;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextCustomScroll.Destroy;
begin
  Stop;
  if Assigned (FHelpBmp) then FHelpBmp.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.Loaded;
begin
  inherited Loaded;
  if FScroll then
   begin
     Scroll;
   end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.Paint;
var
  aRect : TRect;
begin
  if (csLoading in ComponentState)then exit;

  //fill the control's background
  FillControl;

  if GetEmpty then
    begin
      if csDesigning in ComponentState then DrawDashedFrame;
      exit;
    end;

  //paint the bevel (if needed) and detrmine the inner rect of the controls
  //which can be used for drawing the text
  if not Flat or Entered then
    FTextRect:=Bevel.PaintBevel(Canvas, GetClientRect, TransparentBorder)
  else
    FTextRect := GetClientRect;

  aRect := FTextRect;
  OffsetRect (aRect, -aRect.Left, -aRect.Top);

  //calculate dimensions of the text to be scrolled
  FTDimens := TextSettings.GetClientRect(Canvas, aRect, Font, false, true);

  //create a help bitmap, as large as the control
  FHelpBmp.Width := ClientRect.Right - ClientRect.Left;
  FHelpBmp.Height := ClientRect.Bottom - ClientRect.Top;

  //draw the caption
  DrawCaption(FTextRect, Alignment);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.Start;
begin
  SetScroll (true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.Execute;
begin
  Start;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.Stop;
begin
  SetScroll (false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCustomScroll.SetStartPos (aValue: TLMDTextScrollStartPos);
begin
  FTStartPos := aValue;
end;

end.
