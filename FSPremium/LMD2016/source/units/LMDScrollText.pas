unit LMDScrollText;
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

LMDScrollText unit (RM)
-----------------------
Scrolling Text component.

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Controls, Classes, Messages,
  LMDGraph, LMDClass, LMDBase, LMDTimer, LMD3DCaption, LMDGraphicControl;

type
  {------------------------- TLMDScrollText -----------------------------------}
  TLMDScrollDirection=(sdBottomToTop, sdLeftToRight, sdRightToLeft, sdTopToBottom);
  TLMDScrollStyle=(ssLoop, ssLoopReverse, ssOnce);
  TLMDScrollMode=(smMarquee, smTicker);

  TLMDScrollText=class(TLMDGraphicControl)
  private
    FAlignment : TAlignment;
    FBack      : TBitmap;
    FDirection : TLMDScrollDirection;
    FFont3D    : TLMD3DCaption;
    FInterval  : TLMDTimerInterval;
    FLines     : TStringList;
    FMakeVisible:Boolean;
    FRestore   : Boolean;
    FScroll    : Boolean;
    FStyle     : TLMDScrollStyle;
    FMode      : TLMDScrollMode;
    FTimerID   : TLMDTimer;
    FTransparent:Boolean;
    FSteps,
    {internal}
    bmw, bmh, th, tw, lh,
    FCurrent   : Integer;
    pos        : TPoint;
    FOnScrollStart,
    FOnScroll,
    FOnScrollEnd:TNotifyEvent;

    //4.0
    FTimerMode:TLMDTimerMode;
    FTimer:TLMDHiTimer;
    FThreadPriority:TThreadPriority;
    procedure SetThreadPriority(aValue:TThreadPriority);
    procedure SetTimerMode(aValue:TLMDTimerMode);
    //---

    procedure SetAlignment(aValue:TAlignment);
    procedure SetBool(index:Integer; aValue:Boolean);
    procedure SetDirection(aValue:TLMDScrollDirection);
    procedure SetFont3D(aValue:TLMD3DCaption);
    procedure SetInterval(aValue:TLMDTimerInterval);
    procedure SetLines(aValue:TStringList);
    procedure SetSteps(aValue:Integer);
    procedure SetStyle(aValue:TLMDScrollStyle);
    procedure SetMode(aValue : TLMDScrollMode);
    procedure GetTimer(Sender:TObject);

    //4.0
    procedure ActivateTimer;
    procedure DeActivateTimer(aValue:TLMDTimerMode);
    procedure EnableTimer(aValue:Boolean);
    //--

    procedure CMFontChanged(var Message:TMessage);message CM_FONTCHANGED;
  protected
    function GetAsTickerText : String;
    procedure BoundsChange(State:TLMDBoundsChangeStates);override;
    procedure CalculateDimensions;
    procedure GetChange(Sender:TObject);override;
    function GetEmpty:Boolean;override;
    procedure Loaded;override;
    procedure Paint;override;
    procedure PaintImage;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate;override;
    procedure BackUpdate; override;

    {methods}
    procedure Execute;
    procedure ExecuteEnh(StartStep:Integer);
    procedure Reverse;
    procedure Stop;

    {runtime properties}
    property Step:Integer read FCurrent;
  published
    property About;
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property BackFX;
    property Direction: TLMDScrollDirection read FDirection write SetDirection default sdBottomToTop;
    property Font3D: TLMD3DCaption read FFont3D write SetFont3D;
    property Interval:TLMDTimerInterval read FInterval write SetInterval default 100;
    property Lines: TStringList read FLines write SetLines;
    property MakeVisible:Boolean index 0 read FMakeVisible write SetBool default True;
    property Scroll:Boolean index 1 read FScroll write SetBool stored false;
    property ScrollStyle:TLMDScrollStyle read FStyle write SetStyle default ssLoop;
    property ScrollMode: TLMDScrollMode read FMode write SetMode default smMarquee;
    property Steps:Integer read FSteps write SetSteps default 100;
    property Transparent:Boolean index 2 read FTransparent write SetBool default false;

    property OnStart:TNotifyEvent read FOnScrollStart write FOnScrollStart;
    property OnScroll:TNotifyEvent read FOnScroll write FOnScroll;
    property OnStop:TNotifyEvent read FOnScrollEnd write FOnScrollEnd;

    //4.0
    property TimerMode:TLMDTimerMode read FTimerMode write SetTimerMode default tmNormal;
    property ThreadPriority:TThreadPriority read FThreadPriority write
                            SetThreadPriority default tpNormal;

    {inherited properties}
    property Align;
    property Bevel;
    property Color;
    property DragCursor;
    property DragMode;
    property Font;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    Property ShowHint;
    Property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    {4.0}
    //properties
    property Anchors;
    property BiDiMode;
    property DragKind;
    property Constraints;
    property ParentBiDiMode;
    //events
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}    
  end;

implementation
uses
  Types, Consts, Forms, SysUtils,
  LMDFormShape, LMDCustomControl, LMDProcs, LMDGraphUtils;

{------------------------- Private---------------------------------------------}
procedure TLMDScrollText.SetAlignment(aValue: TAlignment);
begin
  if aValue<>FAlignment then
    begin
      FAlignment:=aValue;
      if not FScroll then InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.SetBool(Index:Integer; aValue: Boolean);
begin
  case index of
    0: FMakeVisible:=aValue;
    1: if aValue<>FScroll then
         if aValue then
           Execute
         else
           begin
             Stop;
             if csDesigning in ComponentState then InvalidateControl;
           end;
    2: if aValue<>FTransparent then
         begin
           FTransparent:=aValue;
           inherited Transparent:=FTransparent;
           Stop;
           if FTransparent then
             FRestore:=True
           else
             begin
               FBack.Width:=0;
               FBack.Height:=0;
               FBack.Dormant;
             end;
           InvalidateControl;
         end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.SetDirection(aValue:TLMDScrollDirection);
begin
  if FDirection<>aValue then
    begin
      Stop;
      FDirection:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.SetFont3D(aValue:TLMD3DCaption);
begin
  FFont3D.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.SetInterval(aValue:TLMDTimerInterval);
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
procedure TLMDScrollText.SetLines(aValue: TStringList);
begin
  FLines.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.SetSteps(aValue: Integer);
begin
  if (FSteps<>aValue) and (aValue>0) then
    begin
      Stop;
      FSteps:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.SetStyle(aValue:TLMDScrollStyle);
begin
  if aValue<>FStyle then
    begin
      Stop;
      FStyle:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.SetMode(aValue:TLMDScrollMode);
begin
  if aValue<>FMode then
    begin
      Stop;
      FMode:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.SetThreadPriority(aValue:TThreadPriority);
begin
  if aValue<>FThreadPriority then
    begin
      FThreadPriority:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.SetTimerMode(aValue:TLMDTimerMode);
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
procedure TLMDScrollText.GetTimer(Sender:TObject);
begin
  if not FScroll then exit;

  Inc(FCurrent);
  PaintImage;

  if FCurrent > FSteps then
    begin
      case FStyle of
        ssLoop:FCurrent:=0;
        ssLoopReverse:Reverse;
      else
        Stop;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.ActivateTimer;
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
procedure TLMDScrollText.DeActivateTimer(aValue:TLMDTimerMode);
begin
  case FTimerMode of
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
procedure TLMDScrollText.EnableTimer(aValue:Boolean);
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
procedure TLMDScrollText.CMFontChanged(var Message: TMessage);
begin
  inherited;
  GetChange(Font);
end;

{------------------------- Protected ------------------------------------------}
function TLMDScrollText.getAsTickerText : String;
var
  i : integer;
begin
  result := '';
  for i := 0 to FLines.Count - 1 do
    result := result + FLines[i]+' ';
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.BoundsChange(State:TLMDBoundsChangeStates);
begin
  inherited BoundsChange(State);
  BackFX.DestroyBuffer;
  if FTransparent then FRestore:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.CalculateDimensions;
var
  t,i:Integer;
begin
  if csLoading in ComponentState then exit;
  {calculate dimensions}
  lh:=LMDGet3DTextHeight(FFont3D, Font);
  th:=lh*FLines.Count;
  tw:=0;
  case FMode of
    smMarquee : for i:=0 to Pred(FLines.Count) do
                  begin
                    t:=LMDGet3DTextWidth(Flines[i], FFont3D, Font);
                    if t>tw then tw:=t;
                  end;
    smTicker  : begin
                  t:=LMDGet3DTextWidth(getAsTickerText, FFont3D, Font);
                  th := lh; //we have only one line :-)
                  if t>tw then tw:=t;
                end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDScrollText.GetEmpty:Boolean;
begin
  result:=(FLines.Count=0);
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.GetChange(Sender:TObject);
begin
  if (csLoading in ComponentState) then exit;
  if (sender=Font) or (sender=FFont3D) or (sender=FLines) then
    CalculateDimensions;
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.Invalidate;
begin
  inherited Invalidate;
  if FTransparent then FRestore:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.BackUpdate;
begin
  if not (csLoading in ComponentState) and (CheckOptimized or Transparent) then
    begin
      FRestore:=True;
      BackFX.DestroyBuffer;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.Loaded;
begin
  inherited Loaded;
  if FTimerMode<>tmNormal then
    begin
     DeActivateTimer(tmNormal);
     ActivateTimer;
    end;
  CalculateDimensions;
end;

{------------------------------------------------------------------------------}
{function clearedStr (Str : String) : String;
var
  pb, pnb : Integer;
begin
  result := Str;
  repeat
    pb := System.Pos ('<b>', result);
    pnb := System.Pos ('</b>', result);
    if pb <> 0 then
      Delete (result, pb ,3)
    else
      if pnb <> 0 then
        Delete (result, pnb ,4);
  until (pb=0) and (pnb=0);
end;

{------------------------------------------------------------------------------}

function  LMDPos(const Substr, S: string): integer;
begin
  Result := Pos(Substr, S);
end;

procedure TLMDScrollText.PaintImage;
var
  t     : TBitmap;
  bold  : boolean;
  s2,
  s     : String;
  hRect,
  aRect,
  nRect,
  bRect : TRect;
  tp    : TPoint;
  i     : Integer;
  Done  : Extended;

const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);

  function getPart : String;
  var
    pb, pnb : Integer;
  begin
    pb := LMDPos('<b>', s);
    pnb := LMDPos('</b>', s);
    repeat //try to find all <b></b> tags (doing nothing) and switch bold - not bold
      if (pnb = 1) then
        begin
          bold := false;
          Delete (s, 1, 4);
        end;
      if (pb = 1) then
        begin
          bold := true;
          Delete (s, 1, 3);
        end;
      pb := LMDPos('<b>', s);
      pnb := LMDPos('</b>', s);
    until (pb <> 1) and (pnb <> 1);
    result := s;
    //we now know whether we are bold or not
    if (pb <> 0) and ((pb < pnb) or (pnb = 0)) then //(we are normal)
      begin //we have got a <b> tag before any existing </b>
        //return the string up to the first occurence of <b>
        result := Copy (s, 1, pb - 1);
//        Delete (s, 1, pb - 1);
      end
    else
      if (pnb <> 0) then //we have no pb or pb > pnb (we are bold)
        begin
          result := Copy (s, 1, pnb - 1);
//          Delete (s, 1, pnb - 1);
        end;
    delete (s, 1, length(result));
    if bold then
      t.Canvas.Font.Style := Canvas.Font.Style + [fsBold]
    else
      t.Canvas.Font.Style := Canvas.Font.Style - [fsBold];
  end;

  procedure calcRowWidth;
  var
    b : Boolean;
    s2, s3 : String;
    c : TRect;
  begin
    b := bold;
    s2 := s;
    s3 := getPart;
    c := Rect (0,aRect.Top, 0, aRect.Bottom);
    hRect.Right := 0;
    while s3 <> '' do
      begin
        LMDDrawTextCalc (s3, FFont3D, c, t.Canvas.Font,
                         false, false, 0, 0);
        hRect.Right := c.Right + hRect.right;
        s3 := getPart;
      end;
    case FAlignment of
       taCenter : begin
                    hRect.Left := aRect.Left + ((aRect.Right - aRect.Left) - (hRect.Right)) div 2;
                    hRect.Right := hRect.Left+ hRect.Right;
                  end;
       taLeftJustify : begin
                         hRect.Left := aRect.Left;
                         hRect.Right := hRect.Left+ hRect.Right;
                       end;
       taRightJustify : begin
                          hRect.Left := aRect.Right - hRect.Right;
                          hRect.Right := hRect.Left+ hRect.Right;
                        end;
    end;
    s := s2;
    bold := b;
  end;

  procedure getBoldState (Str : String);
  begin
    s := Str;
    while getPart <> '' do;
  end;

begin
  t:=TBitmap.Create;
  try
    //bmw, bmh inner rect if bevel is enabled otherwise whole control
    t.Width:=bmw;
    t.Height:=bmh;
    t.PixelFormat:=pf24Bit;    
    t.Canvas.Font:=self.Font;

    if FTransparent then
      t.Canvas.Draw(0,0,FBack)
    else
      with t.Canvas do
        begin
          Brush.Color:=Color;
          Brush.Style:=bsSolid;
          Pen.Style:=psClear;
          FillRect(Rect(0,0, t.Width, t.Height));
        end;

    BackFX.Draw (t);
//    BackFX.ControlBlend (FBack, Rect (0,0, Width, Height), t.Canvas.ClipRect, t.Canvas, Rect (BevelExt,BevelExt, Width-BevelExt, Height-BevelExt));

    tp:=Point(0,0);
    if tw>bmw then pos.X:=0 else pos.X:=(bmw-tw) div 2;
    if th>bmh then pos.Y:=0 else pos.Y:=(bmh-th) div 2;
    Done:=FCurrent/FSteps;

    case FDirection of
      sdBottomToTop:tp:=Point(pos.X, Round((th+bmh)*(1-Done))-th);
      sdLeftToRight:tp:=Point(Round((tw+bmw)*(Done))-tw,pos.Y);
      sdRightToLeft:tp:=Point(Round((tw+bmw)*(1-Done))-tw,pos.Y);
      sdTopToBottom:tp:=Point(pos.X, Round((th+bmh)*Done)-th);
    end;

    bRect:=Rect(0,0,bmw, bmh);

    bold := false;
    case FMode of
      smMarquee : for i:=0 to Pred(FLines.Count) do
                    begin
                      if FDirection in [sdBottomToTop, sdTopToBottom] then
                        aRect:=Rect(0, tp.Y, bmw, tp.Y+lh)
                      else
                        aRect:=Rect(tp.X, tp.Y, tp.X+tw, tp.Y+lh);
                      if IntersectRect(nRect, aRect, bRect) then
                        begin
                          t.Canvas.Brush.Color:=Color;
                          t.Canvas.Font.Color:=Font.Color;

                          s := FLines[i];

                          hRect := aRect;
                          calcRowWidth;

                          s2 := getPart;
                          while s2 <> '' do
                             begin
                               LMDDrawTextExt(t.Canvas, s2, FFont3D, hRect,
                                              DT_SINGLELINE or DT_NOPREFIX {or Alignments[FAlignment]},
                                              [TLMDDrawTextStyle(Enabled)], nil);

                               LMDDrawTextCalc (s2, FFont3D, hRect, t.Canvas.Font,
                                                false, false, 0, 0);

                               hRect.Left := hRect.Right;
                               hRect.Right := aRect.Right;
                               s2 := getPart;
                             end;
                        end
                      else //we do not paint this line
                        getBoldState (FLines[i]);
                      Inc(tp.Y, lh);
                    end;
      smTicker : begin
                   if FDirection in [sdBottomToTop, sdTopToBottom] then
                     aRect:=Rect(0, tp.Y, bmw, tp.Y+lh)
                   else
                     aRect:=Rect(tp.X, tp.Y, tp.X+tw, tp.Y+lh);
                   t.Canvas.Brush.Color:=Color;
                   t.Canvas.Font.Color:=Font.Color;
                   s := getAsTickerText;

                   hRect := aRect;

                   s2 := getPart;
                   while s2 <> '' do
                      begin
                        LMDDrawTextExt(t.Canvas, s2, FFont3D, hRect,
                                       DT_SINGLELINE or DT_NOPREFIX{or Alignments[FAlignment]},
                                       [TLMDDrawTextStyle(Enabled)], nil);

                        LMDDrawTextCalc (s2, FFont3D, hRect, t.Canvas.Font,
                                         false, false, 0, 0);

                        hRect.Left := hRect.Right;
                        hRect.Right := aRect.Right;
                        s2 := getPart;
                      end;

{                   LMDDrawTextExt(t.Canvas, getAsTickerText, FFont3D, aRect,
                                  DT_SINGLELINE or Alignments[FAlignment],
                                  [TLMDDrawTextStyle(Enabled)], nil);}
                 end;
    end;

    if Assigned(FOnScroll) then FOnScroll(self);
//    Canvas.Draw(BevelExt, BevelExt, t);
    Canvas.CopyRect (Rect (BevelExt, BevelExt, Width - BevelExt, Height - BevelExt), t.Canvas, t.Canvas.ClipRect);
  finally
    t.Free;
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.Paint;
var
  aRect:TRect;
begin
  if (csLoading in ComponentState) or Painting then exit;
  Painting:=True;
  try
    aRect:=Bevel.PaintBevel(Canvas, GetClientRect, false);

    bmw:=aRect.Right-aRect.Left;
    bmh:=aRect.Bottom-aRect.Top;;

    if FRestore and FTransparent then
      begin
        {Version 3.50}
        if CheckOptimized then
           begin
             FBack.Width:=Width;
             FBack.Height:=Height;

             BackDrawArea(FBack.Canvas, ClientRect, Point(0, 0), 0);
           end
        else
          LMDBmpFromDesktop(FBack, GetScreenRect(aRect));
        FRestore:=False;
      end;

    PaintImage;

    if (csDesigning in ComponentState) and not FScroll then
       if (BevelExt=0) then DrawDashedFrame;

  finally
    Painting:=False;
  end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDScrollText.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DisableTransMode;  {required, check TLMDBaseGraphicControl}

  {init}
  FLines:=TStringList.Create;
  FLines.Add(ClassName);
  FLines.OnChange:=GetChange;

  FFont3D:=TLMD3DCaption.Create;
  FFont3D.OnChange:=GetChange;

  FAlignment:=taCenter;
  FDirection := sdBottomToTop;
  FInterval:=100;
  FMakeVisible:=True;
  FScroll:=False;
  FStyle:=ssLoop;

  {default dimensions}
  Width := 200;
  Height := 20;

  FSteps := 100;
  FCurrent := 0;

  FBack:=TBitmap.Create;
  FRestore:=False;
  FTransparent:=False;

  //4.0
  FThreadPriority:=tpNormal;
  FTimerMode:=tmNormal;
  ActivateTimer;
  //---

  FMode := smMarquee;

end;

{------------------------------------------------------------------------------}
destructor TLMDScrollText.Destroy;
begin
  Stop;
  //Scroll:=False;
  DeActivateTimer(FTimerMode);
  FBack.Free;
  FFont3D.OnChange:=nil;
  FLines.OnChange:=nil;
  FFont3D.Free;
  FLines.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.Execute;
begin
  ExecuteEnh(0);
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.ExecuteEnh(StartStep:Integer);
begin
  if (csLoading in ComponentState) or GetEmpty then exit;
  if FScroll then Stop;

  {if not visible - exit, except FMakeVisible is set...}
  if not Visible then
    if FMakeVisible then Visible:=True else exit;

  FScroll:=True;
  //StartStep in [0..Pred(FSteps)] ... removed by JH 99
  if (StartStep >= 0) and (StartStep <= Pred(FSteps)) then
    FCurrent:=StartStep
  else
    FCurrent:=0;

  if Assigned(FOnScrollStart) then FOnScrollStart(Self);

  PaintImage;
  EnableTimer(True);
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.Reverse;
begin
  FCurrent:=FSteps-FCurrent;
  case FDirection of
    sdBottomToTop: FDirection := sdTopToBottom;
    sdLeftToRight: FDirection := sdRightToLeft;
    sdRightToLeft: FDirection := sdLeftToRight;
    sdTopToBottom: FDirection := sdBottomToTop;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScrollText.Stop;
begin
  if not FScroll then exit;
  EnableTimer(false);
  FScroll:=False;
  FCurrent:=0;
  if csDestroying in ComponentState then exit;
  if Assigned(FOnScrollEnd) then FOnScrollEnd(Self);
end;

end.
